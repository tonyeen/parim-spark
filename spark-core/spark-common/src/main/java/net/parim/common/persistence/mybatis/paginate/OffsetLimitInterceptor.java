package net.parim.common.persistence.mybatis.paginate;

import java.util.HashMap;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.ExecutorService;

import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlSource;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.springframework.data.domain.Pageable;

import net.parim.common.config.Global;
import net.parim.common.persistence.Page;
import net.parim.common.persistence.dialect.Dialect;
import net.parim.common.persistence.dialect.db.DB2Dialect;
import net.parim.common.persistence.dialect.db.DerbyDialect;
import net.parim.common.persistence.dialect.db.H2Dialect;
import net.parim.common.persistence.dialect.db.HSQLDialect;
import net.parim.common.persistence.dialect.db.MySQLDialect;
import net.parim.common.persistence.dialect.db.OracleDialect;
import net.parim.common.persistence.dialect.db.PostgreSQLDialect;
import net.parim.common.persistence.dialect.db.SQLServer2005Dialect;
import net.parim.common.persistence.dialect.db.SybaseDialect;
import net.parim.common.persistence.interceptor.SQLHelper;
import net.parim.common.persistence.interceptor.PaginationInterceptor.BoundSqlSqlSource;
import net.parim.common.persistence.mybatis.paginate.domain.PageImpl;
import net.parim.common.utils.Reflections;
import net.parim.common.utils.StringUtils;

@Intercepts({ @Signature(type = Executor.class, method = "query", args = { MappedStatement.class, Object.class,
		RowBounds.class, ResultHandler.class }) })
public class OffsetLimitInterceptor implements Interceptor {
	private Log logger = LogFactory.getLog(getClass());
	private Dialect DIALECT;
	static int MAPPED_STATEMENT_INDEX = 0;
	static int PARAMETER_INDEX = 1;
	static int ROWBOUNDS_INDEX = 2;
	static int RESULT_HANDLER_INDEX = 3;

	static ExecutorService pool;
	String dialectClass;
	boolean asyncTotalCount = false;

	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		//final Executor executor = (Executor) invocation.getTarget();
		final Object[] queryArgs = invocation.getArgs();
		final MappedStatement mappedStatement = (MappedStatement) queryArgs[MAPPED_STATEMENT_INDEX];
		//final RowBounds rowBounds = (RowBounds) queryArgs[ROWBOUNDS_INDEX];
		final Object parameter;
		final Pageable pageable;

		Object prefParameter = queryArgs[PARAMETER_INDEX];
		if (!(prefParameter instanceof HashMap)) {
			return invocation.proceed();
		}

		int size = ((HashMap<?, ?>) prefParameter).size()/2;
		Object lastParam = ((HashMap<?, ?>) prefParameter).get("" + (size - 1));
		if (null != lastParam && lastParam instanceof Pageable) {
			if (size == 1) {
				queryArgs[PARAMETER_INDEX] = null;
				parameter = null;
			} else if (size == 2) {
				queryArgs[PARAMETER_INDEX] = ((HashMap<?, ?>) prefParameter).get("0");
				parameter = ((HashMap<?, ?>) prefParameter).get("0");
			} else {
				// size大于2的时候，默认用map不变
				parameter = prefParameter;
			}
			pageable = (Pageable) lastParam;
		} else {
			return invocation.proceed();
		}
		// TODO: 处理更多的传入参数的情况

		// 通过上面的判断，现在是有分页的
		Page<Object> page = new Page<Object>();
		page.setPageNo(pageable.getPageNumber()+1);
		page.setPageSize(pageable.getPageSize());
		//page.setOrderBy(pageable.getSort().toString());

		// 如果设置了分页对象，则进行分页
		if (page != null && page.getPageSize() != -1) {
			BoundSql boundSql = mappedStatement.getBoundSql(parameter);
			if (StringUtils.isBlank(boundSql.getSql())) {
				return null;
			}
			String originalSql = boundSql.getSql().trim();

			// 得到总记录数
			page.setCount(SQLHelper.getCount(originalSql, null, mappedStatement, parameter, boundSql, logger));

			// 分页查询 本地化对象 修改数据库注意修改实现
			String pageSql = SQLHelper.generatePageSql(originalSql, page, DIALECT);
			// if (log.isDebugEnabled()) {
			// log.debug("PAGE SQL:" + StringUtils.replace(pageSql, "\n", ""));
			// }
			invocation.getArgs()[2] = new RowBounds(RowBounds.NO_ROW_OFFSET, RowBounds.NO_ROW_LIMIT);
			BoundSql newBoundSql = new BoundSql(mappedStatement.getConfiguration(), pageSql,
					boundSql.getParameterMappings(), boundSql.getParameterObject());
			// 解决MyBatis 分页foreach 参数失效 start
			if (Reflections.getFieldValue(boundSql, "metaParameters") != null) {
				MetaObject mo = (MetaObject) Reflections.getFieldValue(boundSql, "metaParameters");
				Reflections.setFieldValue(newBoundSql, "metaParameters", mo);
			}
			// 解决MyBatis 分页foreach 参数失效 end
			MappedStatement newMs = copyFromMappedStatement(mappedStatement, new BoundSqlSqlSource(newBoundSql));

			invocation.getArgs()[0] = newMs;
			//org.springframework.data.domain.Page page2;
			@SuppressWarnings("unchecked")
			PageImpl<?> pageImpl = new PageImpl<Object>((List<Object>)invocation.proceed(), pageable, page.getCount());
			return pageImpl;
		}
		
		//这个返回值有问题，有可能是传了pageable参数但上一个判断不成功，这样的话，返回强转就会报错
		return invocation.proceed();
	}

	@Override
	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	@Override
	public void setProperties(Properties properties) {
		initProperties(properties);
	}

	/**
	 * 设置属性，支持自定义方言类和制定数据库的方式 <code>dialectClass</code>,自定义方言类。可以不配置这项
	 * <ode>dbms</ode> 数据库类型，插件支持的数据库 <code>sqlPattern</code> 需要拦截的SQL ID
	 * 
	 * @param p
	 *            属性
	 */
	protected void initProperties(Properties p) {
		Dialect dialect = null;
		String dbType = Global.getConfig("jdbc.type");
		if ("db2".equals(dbType)) {
			dialect = new DB2Dialect();
		} else if ("derby".equals(dbType)) {
			dialect = new DerbyDialect();
		} else if ("h2".equals(dbType)) {
			dialect = new H2Dialect();
		} else if ("hsql".equals(dbType)) {
			dialect = new HSQLDialect();
		} else if ("mysql".equals(dbType)) {
			dialect = new MySQLDialect();
		} else if ("oracle".equals(dbType)) {
			dialect = new OracleDialect();
		} else if ("postgre".equals(dbType)) {
			dialect = new PostgreSQLDialect();
		} else if ("mssql".equals(dbType) || "sqlserver".equals(dbType)) {
			dialect = new SQLServer2005Dialect();
		} else if ("sybase".equals(dbType)) {
			dialect = new SybaseDialect();
		}
		if (dialect == null) {
			throw new RuntimeException("mybatis dialect error.");
		}
		DIALECT = dialect;
	}

	private MappedStatement copyFromMappedStatement(MappedStatement ms, SqlSource newSqlSource) {
		MappedStatement.Builder builder = new MappedStatement.Builder(ms.getConfiguration(), ms.getId(), newSqlSource,
				ms.getSqlCommandType());
		builder.resource(ms.getResource());
		builder.fetchSize(ms.getFetchSize());
		builder.statementType(ms.getStatementType());
		builder.keyGenerator(ms.getKeyGenerator());
		if (ms.getKeyProperties() != null) {
			for (String keyProperty : ms.getKeyProperties()) {
				builder.keyProperty(keyProperty);
			}
		}
		builder.timeout(ms.getTimeout());
		builder.parameterMap(ms.getParameterMap());
		builder.resultMaps(ms.getResultMaps());
		builder.cache(ms.getCache());
		return builder.build();
	}
}
