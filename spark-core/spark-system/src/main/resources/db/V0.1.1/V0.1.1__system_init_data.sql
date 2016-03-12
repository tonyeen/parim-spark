--添加权限插入触发器，触动添加所有supperadmin的权限关系
CREATE or replace trigger trg_admin_privilege
  after insert or update or delete
  on ADMIN_PRIVILEGE 
  for each row
declare
  -- local variables here
begin
  IF inserting THEN
     INSERT INTO admin_role_xref(site_id,
                                 privilege_id,
                                 role_id,
                                 created_by,
                                 create_date)
            SELECT role.site_id, :new.Id, role.id, 2, SYSDATE FROM admin_role role WHERE role.is_supperuser = 1; 
  END IF;
  
  IF deleting THEN 
    DELETE FROM admin_role_xref x WHERE x.privilege_id = :OLD.ID;
  END IF;
end trg_admin_privilege;

-- TODO： generate admin user id and site id as a param

/*prompt Importing table SITE...
set feedback off
set define off*/
insert into SITE (ID, NAME, SHORT_NAME, DESCRIPTION, CREATED_BY, CREATE_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE)
values ('1', 'Root Site', 'ROOT', 'This is root site inited by application.', null, null, null, null);

/*prompt Done.*/


/*prompt Importing table SYS_USER...
set feedback off
set define off*/
insert into SYS_USER (ID, SITE_ID, USER_GROUP_ID, USERNAME, EMAIL, PHONE, FIRST_NAME, LAST_NAME, PASSWORD, SALT, START_DATE, END_DATE, ALLOW_UPDATE, TOTAL_SESSION_COUNT, TOTAL_SESSION_TIME, CREATED_BY, CREATE_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE)
values ('2', '1', null, 'admin', 'admin@parim.net', null, 'admin', null, 'dLNBDdOxC3ut7NcfNtJ/aA==', '8o6b0dbbQJDkp9mWDjqeeO', null, null, null, null, null, null, null, null, null);

/*prompt Done.*/


/*prompt Importing table admin_role...
set feedback off
set define off*/
insert into admin_role (ID, SITE_ID, NAME, DESCRIPTION, IS_SUPPERUSER, TARGETS, CREATED_BY, CREATE_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE)
values ('1', '1', '超级管理员', null, 1, 'SG', '2', SYSDATE, null, null);

/*prompt Importing table ADMIN_PRIVILEGE...
set feedback off
set define off*/
insert into ADMIN_PRIVILEGE (ID, NAME, IDENTIFIER, DESCRIPTION, TARGETS, USER_TYPE, TYPE)
values (1, '查看菜单', 'system:menu:view', null, null, null, 'system');

insert into ADMIN_PRIVILEGE (ID, NAME, IDENTIFIER, DESCRIPTION, TARGETS, USER_TYPE, TYPE)
values (2, '编辑菜单', 'system:menu:edit', null, null, null, 'system');

insert into ADMIN_PRIVILEGE (ID, NAME, IDENTIFIER, DESCRIPTION, TARGETS, USER_TYPE, TYPE)
values (3, '删除菜单', 'system:menu:delete', null, null, null, 'system');

/*prompt Done.*/


/*prompt Importing table user_role...
set feedback off
set define off*/
insert into user_role (ID, SITE_ID, USER_ID, USER_GROUP_ID, LOGICAL_GROUP_ID, ROLE_ID, PRIVILEGE_ID, TARGET_ID, TARGET, CREATED_BY, CREATE_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE)
values ('1', '1', '2', null, null, '1', null, '1', 'S', null, null, null, null);

/*prompt Done.*/





/*prompt Importing table sys_menu...
set feedback off
set define off*/
insert into sys_menu (ID, PARENT_ID, NAME, IDENTIFIER, SORT, URL, TARGET, ICON, IS_SHOW, PERMISSION)
values (1001, 2, '用户管理', 'users_management', 10, '/sys/user/', null, null, 1, null);

insert into sys_menu (ID, PARENT_ID, NAME, IDENTIFIER, SORT, URL, TARGET, ICON, IS_SHOW, PERMISSION)
values (1002, 4, '字典管理', 'system_dict_management', 20, '/sys/dict/list', null, null, 1, null);

insert into sys_menu (ID, PARENT_ID, NAME, IDENTIFIER, SORT, URL, TARGET, ICON, IS_SHOW, PERMISSION)
values (1, null, '系统管理', 'system_management', 10, '/sys/user/', null, null, 1, null);

insert into sys_menu (ID, PARENT_ID, NAME, IDENTIFIER, SORT, URL, TARGET, ICON, IS_SHOW, PERMISSION)
values (2, 1, '用户管理', 'user_management', 10, null, null, null, 1, null);

insert into sys_menu (ID, PARENT_ID, NAME, IDENTIFIER, SORT, URL, TARGET, ICON, IS_SHOW, PERMISSION)
values (3, 2, '站点管理', 'site_management', 10, '/sys/site/', null, null, 1, null);

insert into sys_menu (ID, PARENT_ID, NAME, IDENTIFIER, SORT, URL, TARGET, ICON, IS_SHOW, PERMISSION)
values (4, 1, '系统设置', 'system_setting', 20, null, null, null, 1, null);

insert into sys_menu (ID, PARENT_ID, NAME, IDENTIFIER, SORT, URL, TARGET, ICON, IS_SHOW, PERMISSION)
values (5, 4, '菜单管理', 'menu_management', 10, '/sys/menu/', null, null, 1, null);

/*prompt Done.
*/

COMMIT;


CREATE OR REPLACE VIEW USER_PRIVILEGE_VIEW AS
SELECT
  ur.target_id AS target_id,
  ur.target AS target,
  ur.user_id AS user_id
FROM
  user_role ur
UNION
  SELECT
    ur.target_id AS target_id,
    ur.target AS target,
    x.child_id AS user_id
  FROM
      user_role ur, tree_xref x
  WHERE ur.user_group_id = x.parent_id
      AND x.tree_type = 'P'
      AND x.child_object_type = 'U';

