/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     2016/3/6 10:47:07                            */
/*==============================================================*/


DROP TABLE "DEV_POST" CASCADE CONSTRAINTS;

DROP TABLE "DEV_PROJECT" CASCADE CONSTRAINTS;

DROP TABLE "DEV_PROJECT_RELEASELIST" CASCADE CONSTRAINTS;

DROP TABLE "DEV_PROJECT_REPOSITORY" CASCADE CONSTRAINTS;

/*==============================================================*/
/* Table: "DEV_POST"                                            */
/*==============================================================*/
CREATE TABLE "DEV_POST" 
(
   "ID"                 NUMBER               NOT NULL,
   "TITLE"              VARCHAR2(255),
   "PUBLIC_SLUG"        VARCHAR2(255),
   "CATEGORY"           VARCHAR2(255),
   "BROADCAST"          SMALLINT,
   "DRAFT"              SMALLINT,
   "PUBLISH_DATE"       DATE,
   "RAW_CONTENT"        CLOB,
   "RENDERED_CONTENT"   CLOB,
   "RENDERED_SUMMARY"   CLOB,
   "CREATED_BY"         NUMBER,
   "CREATE_DATE"        DATE,
   CONSTRAINT PK_DEV_POST PRIMARY KEY ("ID")
);

COMMENT ON TABLE "DEV_POST" IS
'post';

COMMENT ON COLUMN "DEV_POST"."ID" IS
'id';

COMMENT ON COLUMN "DEV_POST"."TITLE" IS
'title';

COMMENT ON COLUMN "DEV_POST"."PUBLIC_SLUG" IS
'public_slug';

COMMENT ON COLUMN "DEV_POST"."CATEGORY" IS
'category';

COMMENT ON COLUMN "DEV_POST"."BROADCAST" IS
'broadcast';

COMMENT ON COLUMN "DEV_POST"."DRAFT" IS
'draft';

COMMENT ON COLUMN "DEV_POST"."PUBLISH_DATE" IS
'publish_date';

COMMENT ON COLUMN "DEV_POST"."RAW_CONTENT" IS
'raw_content';

COMMENT ON COLUMN "DEV_POST"."RENDERED_CONTENT" IS
'rendered_content';

COMMENT ON COLUMN "DEV_POST"."RENDERED_SUMMARY" IS
'rendered_summary';

COMMENT ON COLUMN "DEV_POST"."CREATED_BY" IS
'created_by';

COMMENT ON COLUMN "DEV_POST"."CREATE_DATE" IS
'create_date';

/*==============================================================*/
/* Table: "DEV_PROJECT"                                         */
/*==============================================================*/
CREATE TABLE "DEV_PROJECT" 
(
   "ID"                 NUMBER               NOT NULL,
   "NAME"               VARCHAR2(255),
   "REPO_URL"           VARCHAR2(255),
   "CATEGORY"           VARCHAR2(255),
   "SITE_URL"           VARCHAR2(255),
   "IS_AGGREGATOR"      SMALLINT,
   CONSTRAINT PK_DEV_PROJECT PRIMARY KEY ("ID")
);

COMMENT ON TABLE "DEV_PROJECT" IS
'project';

COMMENT ON COLUMN "DEV_PROJECT"."ID" IS
'id';

COMMENT ON COLUMN "DEV_PROJECT"."NAME" IS
'name';

COMMENT ON COLUMN "DEV_PROJECT"."REPO_URL" IS
'repo_url';

COMMENT ON COLUMN "DEV_PROJECT"."CATEGORY" IS
'category';

COMMENT ON COLUMN "DEV_PROJECT"."SITE_URL" IS
'site_url';

COMMENT ON COLUMN "DEV_PROJECT"."IS_AGGREGATOR" IS
'is_aggregator';

/*==============================================================*/
/* Table: "DEV_PROJECT_RELEASELIST"                             */
/*==============================================================*/
CREATE TABLE "DEV_PROJECT_RELEASELIST" 
(
   "ID"                 NUMBER               NOT NULL,
   "VERSION_NAME"       VARCHAR2(255)        NOT NULL,
   "REPONSITORY_ID"     VARCHAR2(255),
   "API_DOC_URL"        VARCHAR2(255),
   "ARTIFACT_ID"        VARCHAR2(255),
   "GROUP_ID"           VARCHAR2(255),
   "IS_CURRENT"         SMALLINT,
   "REF_DOC_URL"        VARCHAR2(255),
   "RELEASE_STATUS"     INTEGER,
   CONSTRAINT PK_DEV_PROJECT_RELEASELIST PRIMARY KEY ("ID", "VERSION_NAME")
);

COMMENT ON TABLE "DEV_PROJECT_RELEASELIST" IS
'project_releaselist';

COMMENT ON COLUMN "DEV_PROJECT_RELEASELIST"."ID" IS
'id';

COMMENT ON COLUMN "DEV_PROJECT_RELEASELIST"."VERSION_NAME" IS
'version_name';

COMMENT ON COLUMN "DEV_PROJECT_RELEASELIST"."REPONSITORY_ID" IS
'reponsitory_id';

COMMENT ON COLUMN "DEV_PROJECT_RELEASELIST"."API_DOC_URL" IS
'api_doc_url';

COMMENT ON COLUMN "DEV_PROJECT_RELEASELIST"."ARTIFACT_ID" IS
'artifact_id';

COMMENT ON COLUMN "DEV_PROJECT_RELEASELIST"."GROUP_ID" IS
'group_id';

COMMENT ON COLUMN "DEV_PROJECT_RELEASELIST"."IS_CURRENT" IS
'is_current';

COMMENT ON COLUMN "DEV_PROJECT_RELEASELIST"."REF_DOC_URL" IS
'ref_doc_url';

COMMENT ON COLUMN "DEV_PROJECT_RELEASELIST"."RELEASE_STATUS" IS
'release_status';

/*==============================================================*/
/* Table: "DEV_PROJECT_REPOSITORY"                              */
/*==============================================================*/
CREATE TABLE "DEV_PROJECT_REPOSITORY" 
(
   "ID"                 NUMBER               NOT NULL,
   "NAME"               VARCHAR2(255),
   "URL"                VARCHAR2(255),
   "SNAPSHOTS_ENABLE"   SMALLINT,
   CONSTRAINT PK_DEV_PROJECT_REPOSITORY PRIMARY KEY ("ID")
);

COMMENT ON TABLE "DEV_PROJECT_REPOSITORY" IS
'project_repository';

COMMENT ON COLUMN "DEV_PROJECT_REPOSITORY"."ID" IS
'id';

COMMENT ON COLUMN "DEV_PROJECT_REPOSITORY"."NAME" IS
'name';

COMMENT ON COLUMN "DEV_PROJECT_REPOSITORY"."URL" IS
'url';

COMMENT ON COLUMN "DEV_PROJECT_REPOSITORY"."SNAPSHOTS_ENABLE" IS
'snapshots_enable';

