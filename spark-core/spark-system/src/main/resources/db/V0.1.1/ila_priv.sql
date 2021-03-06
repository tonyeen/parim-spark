CREATE OR REPLACE PACKAGE ILA_PRIV AS

  TARGET_TYPE_NONE            CONSTANT CHAR := '';
  TARGET_TYPE_SITE            CONSTANT CHAR := 'S';
  TARGET_TYPE_USER            CONSTANT CHAR := 'U';
  TARGET_TYPE_ORGANIZATION    CONSTANT CHAR := 'O';
  TARGET_TYPE_RCO             CONSTANT CHAR := 'R';
  TARGET_TYPE_CONTENT_FOLDER  CONSTANT CHAR := 'F';
  TARGET_TYPE_CLASSROOM       CONSTANT CHAR := 'L';
  TARGET_TYPE_CLASSROOM_GROUP CONSTANT CHAR := 'I';
  TARGET_TYPE_USER_GROUP      CONSTANT CHAR := 'G';
  TARGET_TYPE_CHAT            CONSTANT CHAR := 'C';
  TARGET_TYPE_FORUM           CONSTANT CHAR := 'D';
  TARGET_TYPE_ADHOC_REPORT    CONSTANT CHAR := 'A';

  TREE_TYPE_PRIVILEGE CONSTANT CHAR := 'P';
  TREE_TYPE_MANAGER   CONSTANT CHAR := 'M';

  /*TYPE PERMISSION IS RECORD(
    ID               USER_ROLE.ID%TYPE,
    SITE_ID          USER_ROLE.SITE_ID%TYPE,
    USER_ID          USER_ROLE.USER_ID%TYPE,
    USER_GROUP_ID    USER_ROLE.USER_GROUP_ID%TYPE,
    LOGICAL_GROUP_ID USER_ROLE.LOGICAL_GROUP_ID%TYPE,
    TARGET_ID        USER_ROLE.TARGET_ID%TYPE,
    TARGET_TYPES     ADMIN_PRIVILEGE.TARGETS%TYPE);

  PROCEDURE TARGET_CREATED(P_TARGET_ID   PRIVILEGE_REF.TARGET_ID%TYPE,
                           P_SITE_ID     PRIVILEGE_REF.SITE_ID%TYPE,
                           P_PARENT_ID   PRIVILEGE_REF.TARGET_ID%TYPE,
                           P_TARGET_TYPE PRIVILEGE_REF.TARGET_TYPE%TYPE);

  PROCEDURE TARGET_DELETED(P_TARGET_ID PRIVILEGE_REF.TARGET_ID%TYPE);

  PROCEDURE CHILD_TARGET_REMOVED(P_PARENT_ID PRIVILEGE_REF.TARGET_ID%TYPE,
                                 P_TARGET_ID PRIVILEGE_REF.TARGET_ID%TYPE);

  PROCEDURE CHILD_TARGET_ADDED(P_SITE_ID   PRIVILEGE_REF.SITE_ID%TYPE,
                               P_PARENT_ID PRIVILEGE_REF.TARGET_ID%TYPE,
                               P_TARGET_ID PRIVILEGE_REF.TARGET_ID%TYPE);

  PROCEDURE LEAF_CHILD_TARGET_REMOVED(P_PARENT_ID PRIVILEGE_REF.TARGET_ID%TYPE,
                                      P_TARGET_ID PRIVILEGE_REF.TARGET_ID%TYPE);

  PROCEDURE LEAF_CHILD_TARGET_ADDED(P_SITE_ID     PRIVILEGE_REF.SITE_ID%TYPE,
                                    P_PARENT_ID   PRIVILEGE_REF.TARGET_ID%TYPE,
                                    P_TARGET_ID   PRIVILEGE_REF.TARGET_ID%TYPE,
                                    P_TARGET_TYPE PRIVILEGE_REF.TARGET_TYPE%TYPE);

  PROCEDURE USER_CREATED(P_USER_ID   sys_user.ID%TYPE,
                         P_SITE_ID   sys_user.SITE_ID%TYPE,
                         P_PARENT_ID PRIVILEGE_REF.TARGET_ID%TYPE);

  PROCEDURE USER_DELETED(P_USER_ID sys_user.ID%TYPE);

  PROCEDURE USER_REMOVED_FROM_PARENT(P_PARENT_ID PRIVILEGE_REF.TARGET_ID%TYPE,
                                     P_USER_ID   sys_user.ID%TYPE);

  PROCEDURE USER_ADDED_TO_PARENT(P_SITE_ID   sys_user.SITE_ID%TYPE,
                                 P_PARENT_ID PRIVILEGE_REF.TARGET_ID%TYPE,
                                 P_USER_ID   sys_user.ID%TYPE);

  PROCEDURE USER_ADDED_TO_CONDITION(P_SITE_ID      CONDITION_MATCH.SITE_ID%TYPE,
                                    P_USER_ID      CONDITION_MATCH.USER_ID%TYPE,
                                    P_CONDITION_ID CONDITION_MATCH.CONDITION_ID%TYPE);

  PROCEDURE USER_REMOVED_FROM_CONDITION(P_USER_ID      CONDITION_MATCH.USER_ID%TYPE,
                                        P_CONDITION_ID CONDITION_MATCH.CONDITION_ID%TYPE);

  PROCEDURE USER_GROUP_REMOVED_FROM_PARENT(P_PARENT_ID     PRIVILEGE_REF.TARGET_ID%TYPE,
                                           P_USER_GROUP_ID USER_GROUP.ID%TYPE);

  PROCEDURE USER_GROUP_ADDED_TO_PARENT(P_SITE_ID       USER_GROUP.SITE_ID%TYPE,
                                       P_PARENT_ID     PRIVILEGE_REF.TARGET_ID%TYPE,
                                       P_USER_GROUP_ID USER_GROUP.ID%TYPE);

  PROCEDURE PERMISSION_GRANTED(P_ID               USER_ROLE.ID%TYPE,
                               P_SITE_ID          USER_ROLE.SITE_ID%TYPE,
                               P_USER_ID          USER_ROLE.USER_ID%TYPE,
                               P_USER_GROUP_ID    USER_ROLE.USER_GROUP_ID%TYPE,
                               P_LOGICAL_GROUP_ID USER_ROLE.LOGICAL_GROUP_ID%TYPE,
                               P_ROLE_ID          USER_ROLE.ROLE_ID%TYPE,
                               P_PRIVILEGE_ID     USER_ROLE.PRIVILEGE_ID%TYPE,
                               P_TARGET_ID        USER_ROLE.TARGET_ID%TYPE);

  PROCEDURE PERMISSION_REVOKED(P_ID               USER_ROLE.ID%TYPE,
                               P_SITE_ID          USER_ROLE.SITE_ID%TYPE,
                               P_USER_ID          USER_ROLE.USER_ID%TYPE,
                               P_USER_GROUP_ID    USER_ROLE.USER_GROUP_ID%TYPE,
                               P_LOGICAL_GROUP_ID USER_ROLE.LOGICAL_GROUP_ID%TYPE,
                               P_ROLE_ID          USER_ROLE.ROLE_ID%TYPE,
                               P_PRIVILEGE_ID     USER_ROLE.PRIVILEGE_ID%TYPE,
                               P_TARGET_ID        USER_ROLE.TARGET_ID%TYPE);

  PROCEDURE ROLE_TARGETS_CHANGED(P_ROLE_ID     ADMIN_ROLE.ID%TYPE,
                                 P_OLD_TARGETS ADMIN_ROLE.TARGETS%TYPE,
                                 P_NEW_TARGETS ADMIN_ROLE.TARGETS%TYPE);

  PROCEDURE UPDATE_PRIVILEGES;

  FUNCTION TABLE_NAME_FOR_TYPE(P_TABLE_TYPE CHAR) RETURN VARCHAR2;*/

END ILA_PRIV;
/

CREATE OR REPLACE PACKAGE BODY ILA_PRIV IS
BEGIN
  NULL;
/*
CURSOR TARGET_TREE_OF_TYPES(P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_TARGET_TYPES IN ADMIN_ROLE.TARGETS%TYPE) IS
SELECT T.CHILD_ID AS
ID, T.CHILD_OBJECT_TYPE AS
TARGET_TYPE FROM TREE_XREF T WHERE T.TREE_TYPE = TREE_TYPE_PRIVILEGE AND T.PARENT_ID = P_TARGET_ID AND INSTR(P_TARGET_TYPES, T.CHILD_OBJECT_TYPE) <> 0; CURSOR TARGETED_PERMISSIONS(P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE) RETURN PERMISSION IS
SELECT UR.ID AS
ID, UR.SITE_ID AS
SITE_ID, UR.USER_ID AS
USER_ID, UR.USER_GROUP_ID AS
USER_GROUP_ID, UR.LOGICAL_GROUP_ID AS
LOGICAL_GROUP_ID, UR.TARGET_ID AS
TARGET_ID, NVL(P.TARGETS, R.TARGETS) AS
TARGET_TYPES FROM USER_ROLE UR, TREE_XREF T, ADMIN_PRIVILEGE P, ADMIN_ROLE R WHERE T.CHILD_ID = P_TARGET_ID AND T.TREE_TYPE = TREE_TYPE_PRIVILEGE AND T.PARENT_ID = UR.TARGET_ID AND UR.ROLE_ID = R.ID(+) AND UR.PRIVILEGE_ID = P.ID(+); CURSOR TARGETED_PERMISSIONS_OF_TYPE(P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_TARGET_TYPE IN PRIVILEGE_REF.TARGET_TYPE%TYPE) RETURN PERMISSION IS
SELECT UR.ID AS
ID, UR.SITE_ID AS
SITE_ID, UR.USER_ID AS
USER_ID, UR.USER_GROUP_ID AS
USER_GROUP_ID, UR.LOGICAL_GROUP_ID AS
LOGICAL_GROUP_ID, UR.TARGET_ID AS
TARGET_ID, NVL(P.TARGETS, R.TARGETS) AS
TARGET_TYPES FROM USER_ROLE UR, TREE_XREF T, ADMIN_PRIVILEGE P, ADMIN_ROLE R WHERE T.CHILD_ID = P_TARGET_ID AND T.TREE_TYPE = TREE_TYPE_PRIVILEGE AND T.PARENT_ID = UR.TARGET_ID AND UR.ROLE_ID = R.ID(+) AND UR.PRIVILEGE_ID = P.ID(+) AND INSTR(NVL(P.TARGETS, R.TARGETS), P_TARGET_TYPE) <> 0; CURSOR ORG_ACTOR_PERMISSIONS(P_ORG_ID IN USER_GROUP.ID%TYPE) RETURN PERMISSION IS
SELECT UR.ID AS
ID, UR.SITE_ID AS
SITE_ID, UR.USER_ID AS
USER_ID, UR.USER_GROUP_ID AS
USER_GROUP_ID, UR.LOGICAL_GROUP_ID AS
LOGICAL_GROUP_ID, UR.TARGET_ID AS
TARGET_ID, NVL(P.TARGETS, R.TARGETS) AS
TARGET_TYPES FROM USER_ROLE UR, TREE_XREF T, ADMIN_PRIVILEGE P, ADMIN_ROLE R WHERE T.CHILD_ID = P_ORG_ID AND T.TREE_TYPE = TREE_TYPE_PRIVILEGE AND T.PARENT_ID = UR.USER_GROUP_ID AND UR.ROLE_ID = R.ID(+) AND UR.PRIVILEGE_ID = P.ID(+); CURSOR LG_ACTOR_PERMISSIONS(P_LOGICAL_GROUP_ID IN LOGICAL_GROUP.ID%TYPE) RETURN PERMISSION IS
SELECT UR.ID AS
ID, UR.SITE_ID AS
SITE_ID, UR.USER_ID AS
USER_ID, UR.USER_GROUP_ID AS
USER_GROUP_ID, UR.LOGICAL_GROUP_ID AS
LOGICAL_GROUP_ID, UR.TARGET_ID AS
TARGET_ID, NVL(P.TARGETS, R.TARGETS) AS
TARGET_TYPES FROM USER_ROLE UR, ADMIN_PRIVILEGE P, ADMIN_ROLE R WHERE UR.LOGICAL_GROUP_ID = P_LOGICAL_GROUP_ID AND UR.ROLE_ID = R.ID(+) AND UR.PRIVILEGE_ID = P.ID(+); CURSOR CONDITION_ACTOR_PERMISSIONS(P_CONDITION_ID IN CONDITION_MATCH.CONDITION_ID%TYPE) RETURN PERMISSION IS
SELECT UR.ID AS
ID, UR.SITE_ID AS
SITE_ID, UR.USER_ID AS
USER_ID, UR.USER_GROUP_ID AS
USER_GROUP_ID, UR.LOGICAL_GROUP_ID AS
LOGICAL_GROUP_ID, UR.TARGET_ID AS
TARGET_ID, NVL(P.TARGETS, R.TARGETS) AS
TARGET_TYPES FROM USER_ROLE UR, ADMIN_PRIVILEGE P, ADMIN_ROLE R, LOGICAL_GROUP LG WHERE LG.CONDITION_ID = P_CONDITION_ID AND UR.LOGICAL_GROUP_ID = LG.ID AND UR.ROLE_ID = R.ID(+) AND UR.PRIVILEGE_ID = P.ID(+); CURSOR ROLE_PERMISSIONS(P_ROLE_ID IN ADMIN_ROLE.ID%TYPE) RETURN PERMISSION IS
SELECT UR.ID AS
ID, UR.SITE_ID AS
SITE_ID, UR.USER_ID AS
USER_ID, UR.USER_GROUP_ID AS
USER_GROUP_ID, UR.LOGICAL_GROUP_ID AS
LOGICAL_GROUP_ID, UR.TARGET_ID AS
TARGET_ID, NULL AS
TARGET_TYPES FROM USER_ROLE UR WHERE UR.ROLE_ID = P_ROLE_ID; CURSOR USER_GROUP_USERS(P_USER_GROUP_ID IN USER_GROUP.ID%TYPE) IS
SELECT T.CHILD_ID AS
ID FROM TREE_XREF T WHERE T.PARENT_ID = P_USER_GROUP_ID AND T.TREE_TYPE = TREE_TYPE_PRIVILEGE AND T.CHILD_OBJECT_TYPE = TARGET_TYPE_USER; CURSOR LOGICAL_GROUP_USERS(P_LOGICAL_GROUP_ID IN USER_GROUP.ID%TYPE) IS
SELECT CM.USER_ID AS
ID FROM CONDITION_MATCH CM, CONDITION C WHERE C.LOGICAL_GROUP_ID IS
NOT NULL AND C.LOGICAL_GROUP_ID = P_LOGICAL_GROUP_ID AND C.ID = CM.CONDITION_ID; CURSOR USER_LOGICAL_GROUPS(P_USER_ID IN sys_user.ID%TYPE) IS
SELECT C.LOGICAL_GROUP_ID AS
ID FROM CONDITION_MATCH CM, CONDITION C WHERE CM.USER_ID = P_USER_ID AND C.LOGICAL_GROUP_ID IS
NOT NULL AND CM.CONDITION_ID = C.ID; FUNCTION CREATE_PERMISSION(P_ID IN USER_ROLE.ID%TYPE, P_SITE_ID IN USER_ROLE.USER_ID%TYPE, P_USER_ID IN USER_ROLE.USER_ID%TYPE, P_USER_GROUP_ID IN USER_ROLE.USER_GROUP_ID%TYPE, P_LOGICAL_GROUP_ID IN USER_ROLE.LOGICAL_GROUP_ID%TYPE, P_ROLE_ID IN USER_ROLE.ROLE_ID%TYPE, P_PRIVILEGE_ID IN USER_ROLE.PRIVILEGE_ID%TYPE, P_TARGET_ID IN USER_ROLE.TARGET_ID%TYPE) RETURN PERMISSION IS
V_PERMISSION PERMISSION;
BEGIN
V_PERMISSION.ID := P_ID; V_PERMISSION.SITE_ID := P_SITE_ID; V_PERMISSION.USER_ID := P_USER_ID; V_PERMISSION.USER_GROUP_ID := P_USER_GROUP_ID; V_PERMISSION.LOGICAL_GROUP_ID := P_LOGICAL_GROUP_ID; V_PERMISSION.TARGET_ID := P_TARGET_ID; IF P_ROLE_ID IS
NOT NULL THEN SELECT TARGETS INTO V_PERMISSION.TARGET_TYPES FROM ADMIN_ROLE WHERE ID = P_ROLE_ID; ELSE SELECT TARGETS INTO V_PERMISSION.TARGET_TYPES FROM ADMIN_PRIVILEGE WHERE ID = P_PRIVILEGE_ID;
END IF; RETURN V_PERMISSION;
END CREATE_PERMISSION; PROCEDURE ADD_REF(P_SITE_ID IN PRIVILEGE_REF.SITE_ID%TYPE, P_USER_ID IN PRIVILEGE_REF.USER_ID%TYPE, P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_TARGET_TYPE IN PRIVILEGE_REF.TARGET_TYPE%TYPE) IS
V_REF_COUNT PRIVILEGE_REF.REF_COUNT%TYPE;
BEGIN
SELECT REF_COUNT INTO V_REF_COUNT FROM PRIVILEGE_REF WHERE USER_ID = P_USER_ID AND TARGET_ID = P_TARGET_ID; UPDATE PRIVILEGE_REF SET REF_COUNT = V_REF_COUNT + 1 WHERE USER_ID = P_USER_ID AND TARGET_ID = P_TARGET_ID;
EXCEPTION
WHEN NO_DATA_FOUND THEN INSERT INTO PRIVILEGE_REF(SITE_ID, USER_ID, TARGET_ID, TARGET_TYPE, REF_COUNT) VALUES(P_SITE_ID, P_USER_ID, P_TARGET_ID, P_TARGET_TYPE, 1);
END ADD_REF; PROCEDURE REMOVE_REF(P_USER_ID IN PRIVILEGE_REF.USER_ID%TYPE, P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE) IS
V_REF_COUNT PRIVILEGE_REF.REF_COUNT%TYPE;
BEGIN
SELECT REF_COUNT INTO V_REF_COUNT FROM PRIVILEGE_REF WHERE USER_ID = P_USER_ID AND TARGET_ID = P_TARGET_ID; IF V_REF_COUNT <= 1 THEN DELETE FROM PRIVILEGE_REF WHERE USER_ID = P_USER_ID AND TARGET_ID = P_TARGET_ID; ELSE UPDATE PRIVILEGE_REF SET REF_COUNT = V_REF_COUNT - 1 WHERE USER_ID = P_USER_ID AND TARGET_ID = P_TARGET_ID;
END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN NULL;
END REMOVE_REF; PROCEDURE EXTEND_PERMISSION(P_PERMISSION IN PERMISSION) IS
BEGIN
IF P_PERMISSION.USER_ID IS
NOT NULL THEN FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_PERMISSION.TARGET_ID, P_PERMISSION.TARGET_TYPES) LOOP ADD_REF(P_PERMISSION.SITE_ID, P_PERMISSION.USER_ID, A_TARGET.ID, A_TARGET.TARGET_TYPE);
END LOOP; ELSIF P_PERMISSION.USER_GROUP_ID IS
NOT NULL THEN FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_PERMISSION.TARGET_ID, P_PERMISSION.TARGET_TYPES) LOOP FOR A_USER IN USER_GROUP_USERS(P_PERMISSION.USER_GROUP_ID) LOOP ADD_REF(P_PERMISSION.SITE_ID, A_USER.ID, A_TARGET.ID, A_TARGET.TARGET_TYPE);
END LOOP;
END LOOP; ELSIF P_PERMISSION.LOGICAL_GROUP_ID IS
NOT NULL THEN FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_PERMISSION.TARGET_ID, P_PERMISSION.TARGET_TYPES) LOOP FOR A_USER IN LOGICAL_GROUP_USERS(P_PERMISSION.LOGICAL_GROUP_ID) LOOP ADD_REF(P_PERMISSION.SITE_ID, A_USER.ID, A_TARGET.ID, A_TARGET.TARGET_TYPE);
END LOOP;
END LOOP;
END IF;
END EXTEND_PERMISSION; PROCEDURE WITHDRAW_PERMISSION(P_PERMISSION IN PERMISSION) IS
BEGIN
IF P_PERMISSION.USER_ID IS
NOT NULL THEN FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_PERMISSION.TARGET_ID, P_PERMISSION.TARGET_TYPES) LOOP REMOVE_REF(P_PERMISSION.USER_ID, A_TARGET.ID);
END LOOP; ELSIF P_PERMISSION.USER_GROUP_ID IS
NOT NULL THEN FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_PERMISSION.TARGET_ID, P_PERMISSION.TARGET_TYPES) LOOP FOR A_USER IN USER_GROUP_USERS(P_PERMISSION.USER_GROUP_ID) LOOP REMOVE_REF(A_USER.ID, A_TARGET.ID);
END LOOP;
END LOOP; ELSIF P_PERMISSION.LOGICAL_GROUP_ID IS
NOT NULL THEN FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_PERMISSION.TARGET_ID, P_PERMISSION.TARGET_TYPES) LOOP FOR A_USER IN LOGICAL_GROUP_USERS(P_PERMISSION.LOGICAL_GROUP_ID) LOOP REMOVE_REF(A_USER.ID, A_TARGET.ID);
END LOOP;
END LOOP;
END IF;
END WITHDRAW_PERMISSION; PROCEDURE EXTEND_PERM_TO_USER(P_PERMISSION IN PERMISSION, P_USER_ID IN sys_user.ID%TYPE, P_ALLOW_TO_TARGET_SELF IN BOOLEAN := TRUE) IS
BEGIN
IF P_ALLOW_TO_TARGET_SELF THEN FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_PERMISSION.TARGET_ID, P_PERMISSION.TARGET_TYPES) LOOP ADD_REF(P_PERMISSION.SITE_ID, P_USER_ID, A_TARGET.ID, A_TARGET.TARGET_TYPE);
END LOOP; ELSE FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_PERMISSION.TARGET_ID, P_PERMISSION.TARGET_TYPES) LOOP IF A_TARGET.ID != P_USER_ID THEN ADD_REF(P_PERMISSION.SITE_ID, P_USER_ID, A_TARGET.ID, A_TARGET.TARGET_TYPE);
END IF;
END LOOP;
END IF;
END EXTEND_PERM_TO_USER; PROCEDURE WITHDRAW_PERM_FROM_USER(P_PERMISSION IN PERMISSION, P_USER_ID IN sys_user.ID%TYPE) IS
BEGIN
FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_PERMISSION.TARGET_ID, P_PERMISSION.TARGET_TYPES) LOOP REMOVE_REF(P_USER_ID, A_TARGET.ID);
END LOOP;
END WITHDRAW_PERM_FROM_USER; PROCEDURE EXTEND_PERM_TO_USER_GROUP(P_PERMISSION IN PERMISSION, P_USER_GROUP_ID IN USER_GROUP.ID%TYPE) IS
BEGIN
FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_PERMISSION.TARGET_ID, P_PERMISSION.TARGET_TYPES) LOOP FOR A_USER IN USER_GROUP_USERS(P_USER_GROUP_ID) LOOP ADD_REF(P_PERMISSION.SITE_ID, A_USER.ID, A_TARGET.ID, A_TARGET.TARGET_TYPE);
END LOOP;
END LOOP;
END EXTEND_PERM_TO_USER_GROUP; PROCEDURE WITHDRAW_PERM_FROM_USER_GROUP(P_PERMISSION IN PERMISSION, P_USER_GROUP_ID IN USER_GROUP.ID%TYPE) IS
BEGIN
FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_PERMISSION.TARGET_ID, P_PERMISSION.TARGET_TYPES) LOOP FOR A_USER IN USER_GROUP_USERS(P_USER_GROUP_ID) LOOP REMOVE_REF(A_USER.ID, A_TARGET.ID);
END LOOP;
END LOOP;
END WITHDRAW_PERM_FROM_USER_GROUP; PROCEDURE EXTEND_PERM_TO_TARGET(P_PERMISSION IN PERMISSION, P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_TARGET_TYPE IN PRIVILEGE_REF.TARGET_TYPE%TYPE) IS
BEGIN
IF INSTR(P_PERMISSION.TARGET_TYPES, P_TARGET_TYPE) = 0 THEN RETURN;
END IF; IF P_PERMISSION.USER_ID IS
NOT NULL THEN ADD_REF(P_PERMISSION.SITE_ID, P_PERMISSION.USER_ID, P_TARGET_ID, P_TARGET_TYPE); ELSIF P_PERMISSION.USER_GROUP_ID IS
NOT NULL THEN FOR A_USER IN USER_GROUP_USERS(P_PERMISSION.USER_GROUP_ID) LOOP ADD_REF(P_PERMISSION.SITE_ID, A_USER.ID, P_TARGET_ID, P_TARGET_TYPE);
END LOOP; ELSIF P_PERMISSION.LOGICAL_GROUP_ID IS
NOT NULL THEN FOR A_USER IN LOGICAL_GROUP_USERS(P_PERMISSION.LOGICAL_GROUP_ID) LOOP ADD_REF(P_PERMISSION.SITE_ID, A_USER.ID, P_TARGET_ID, P_TARGET_TYPE);
END LOOP;
END IF;
END EXTEND_PERM_TO_TARGET; PROCEDURE EXTEND_PERM_TO_TARGET_CASCADE(P_PERMISSION IN PERMISSION, P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_TARGET_TYPES IN ADMIN_PRIVILEGE.TARGETS%TYPE) IS
BEGIN
IF P_PERMISSION.USER_ID IS
NOT NULL THEN FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_TARGET_ID, P_TARGET_TYPES) LOOP ADD_REF(P_PERMISSION.SITE_ID, P_PERMISSION.USER_ID, A_TARGET.ID, A_TARGET.TARGET_TYPE);
END LOOP; ELSIF P_PERMISSION.USER_GROUP_ID IS
NOT NULL THEN FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_TARGET_ID, P_TARGET_TYPES) LOOP FOR A_USER IN USER_GROUP_USERS(P_PERMISSION.USER_GROUP_ID) LOOP ADD_REF(P_PERMISSION.SITE_ID, A_USER.ID, A_TARGET.ID, A_TARGET.TARGET_TYPE);
END LOOP;
END LOOP; ELSIF P_PERMISSION.LOGICAL_GROUP_ID IS
NOT NULL THEN FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_TARGET_ID, P_TARGET_TYPES) LOOP FOR A_USER IN LOGICAL_GROUP_USERS(P_PERMISSION.LOGICAL_GROUP_ID) LOOP ADD_REF(P_PERMISSION.SITE_ID, A_USER.ID, A_TARGET.ID, A_TARGET.TARGET_TYPE);
END LOOP;
END LOOP;
END IF;
END EXTEND_PERM_TO_TARGET_CASCADE; PROCEDURE EXTEND_PERM_TO_TARGET_CASCADE(P_PERMISSION IN PERMISSION, P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE) IS
BEGIN
EXTEND_PERM_TO_TARGET_CASCADE(P_PERMISSION, P_TARGET_ID, P_PERMISSION.TARGET_TYPES);
END EXTEND_PERM_TO_TARGET_CASCADE; PROCEDURE WITHDRAW_PERM_FROM_TARGET(P_PERMISSION IN PERMISSION, P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE) IS
BEGIN
IF P_PERMISSION.USER_ID IS
NOT NULL THEN REMOVE_REF(P_PERMISSION.USER_ID, P_TARGET_ID); ELSIF P_PERMISSION.USER_GROUP_ID IS
NOT NULL THEN FOR A_USER IN USER_GROUP_USERS(P_PERMISSION.USER_GROUP_ID) LOOP REMOVE_REF(A_USER.ID, P_TARGET_ID);
END LOOP; ELSIF P_PERMISSION.LOGICAL_GROUP_ID IS
NOT NULL THEN FOR A_USER IN LOGICAL_GROUP_USERS(P_PERMISSION.LOGICAL_GROUP_ID) LOOP REMOVE_REF(A_USER.ID, P_TARGET_ID);
END LOOP;
END IF;
END WITHDRAW_PERM_FROM_TARGET; PROCEDURE WITHDRAW_PERM_FROM_TARGET_CASC(P_PERMISSION IN PERMISSION, P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_TARGET_TYPES IN ADMIN_PRIVILEGE.TARGETS%TYPE) IS
BEGIN
IF P_PERMISSION.USER_ID IS
NOT NULL THEN FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_TARGET_ID, P_TARGET_TYPES) LOOP REMOVE_REF(P_PERMISSION.USER_ID, A_TARGET.ID);
END LOOP; ELSIF P_PERMISSION.USER_GROUP_ID IS
NOT NULL THEN FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_TARGET_ID, P_TARGET_TYPES) LOOP FOR A_USER IN USER_GROUP_USERS(P_PERMISSION.USER_GROUP_ID) LOOP REMOVE_REF(A_USER.ID, A_TARGET.ID);
END LOOP;
END LOOP; ELSIF P_PERMISSION.LOGICAL_GROUP_ID IS
NOT NULL THEN FOR A_TARGET IN TARGET_TREE_OF_TYPES(P_TARGET_ID, P_TARGET_TYPES) LOOP FOR A_USER IN LOGICAL_GROUP_USERS(P_PERMISSION.LOGICAL_GROUP_ID) LOOP REMOVE_REF(A_USER.ID, A_TARGET.ID);
END LOOP;
END LOOP;
END IF;
END WITHDRAW_PERM_FROM_TARGET_CASC; PROCEDURE WITHDRAW_PERM_FROM_TARGET_CASC(P_PERMISSION IN PERMISSION, P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE) IS
BEGIN
WITHDRAW_PERM_FROM_TARGET_CASC(P_PERMISSION, P_TARGET_ID, P_PERMISSION.TARGET_TYPES);
END WITHDRAW_PERM_FROM_TARGET_CASC; PROCEDURE TARGET_CREATED(P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_SITE_ID IN PRIVILEGE_REF.SITE_ID%TYPE, P_PARENT_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_TARGET_TYPE IN PRIVILEGE_REF.TARGET_TYPE%TYPE) IS
BEGIN
FOR A_PERMISSION IN TARGETED_PERMISSIONS_OF_TYPE(P_PARENT_ID, P_TARGET_TYPE) LOOP EXTEND_PERM_TO_TARGET(A_PERMISSION, P_TARGET_ID, P_TARGET_TYPE);
END LOOP;
END TARGET_CREATED; PROCEDURE TARGET_DELETED(P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE) IS
BEGIN
DELETE FROM PRIVILEGE_REF WHERE TARGET_ID = P_TARGET_ID;
END TARGET_DELETED; PROCEDURE CHILD_TARGET_REMOVED(P_PARENT_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE) IS
BEGIN
FOR A_PERMISSION IN TARGETED_PERMISSIONS(P_PARENT_ID) LOOP WITHDRAW_PERM_FROM_TARGET_CASC(A_PERMISSION, P_TARGET_ID);
END LOOP;
END CHILD_TARGET_REMOVED; PROCEDURE LEAF_CHILD_TARGET_REMOVED(P_PARENT_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE) IS
BEGIN
FOR A_PERMISSION IN TARGETED_PERMISSIONS(P_PARENT_ID) LOOP WITHDRAW_PERM_FROM_TARGET(A_PERMISSION, P_TARGET_ID);
END LOOP;
END LEAF_CHILD_TARGET_REMOVED; PROCEDURE CHILD_TARGET_ADDED(P_SITE_ID IN PRIVILEGE_REF.SITE_ID%TYPE, P_PARENT_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE) IS
BEGIN
FOR A_PERMISSION IN TARGETED_PERMISSIONS(P_PARENT_ID) LOOP EXTEND_PERM_TO_TARGET_CASCADE(A_PERMISSION, P_TARGET_ID);
END LOOP;
END CHILD_TARGET_ADDED; PROCEDURE LEAF_CHILD_TARGET_ADDED(P_SITE_ID IN PRIVILEGE_REF.SITE_ID%TYPE, P_PARENT_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_TARGET_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_TARGET_TYPE IN PRIVILEGE_REF.TARGET_TYPE%TYPE) IS
BEGIN
FOR A_PERMISSION IN TARGETED_PERMISSIONS(P_PARENT_ID) LOOP EXTEND_PERM_TO_TARGET(A_PERMISSION, P_TARGET_ID, P_TARGET_TYPE);
END LOOP;
END LEAF_CHILD_TARGET_ADDED; PROCEDURE USER_CREATED(P_USER_ID IN sys_user.ID%TYPE, P_SITE_ID IN sys_user.SITE_ID%TYPE, P_PARENT_ID IN PRIVILEGE_REF.TARGET_ID%TYPE) IS
BEGIN
FOR A_PERMISSION IN ORG_ACTOR_PERMISSIONS(P_PARENT_ID) LOOP EXTEND_PERM_TO_USER(A_PERMISSION, P_USER_ID);
END LOOP; FOR A_LOGICAL_GROUP IN USER_LOGICAL_GROUPS(P_USER_ID) LOOP FOR A_PERMISSION IN LG_ACTOR_PERMISSIONS(A_LOGICAL_GROUP.ID) LOOP EXTEND_PERM_TO_USER(A_PERMISSION, P_USER_ID);
END LOOP;
END LOOP;
END USER_CREATED; PROCEDURE USER_DELETED(P_USER_ID IN sys_user.ID%TYPE) IS
BEGIN
DELETE FROM PRIVILEGE_REF WHERE USER_ID = P_USER_ID;
END USER_DELETED; PROCEDURE USER_REMOVED_FROM_PARENT(P_PARENT_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_USER_ID IN sys_user.ID%TYPE) IS
BEGIN
FOR A_PERMISSION IN ORG_ACTOR_PERMISSIONS(P_PARENT_ID) LOOP WITHDRAW_PERM_FROM_USER(A_PERMISSION, P_USER_ID);
END LOOP;
END USER_REMOVED_FROM_PARENT; PROCEDURE USER_ADDED_TO_PARENT(P_SITE_ID IN sys_user.SITE_ID%TYPE, P_PARENT_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_USER_ID IN sys_user.ID%TYPE) IS
BEGIN
FOR A_PERMISSION IN ORG_ACTOR_PERMISSIONS(P_PARENT_ID) LOOP EXTEND_PERM_TO_USER(A_PERMISSION, P_USER_ID);
END LOOP;
END USER_ADDED_TO_PARENT; PROCEDURE USER_ADDED_TO_CONDITION(P_SITE_ID IN CONDITION_MATCH.SITE_ID%TYPE, P_USER_ID IN CONDITION_MATCH.USER_ID%TYPE, P_CONDITION_ID IN CONDITION_MATCH.CONDITION_ID%TYPE) IS
BEGIN
FOR A_PERMISSION IN CONDITION_ACTOR_PERMISSIONS(P_CONDITION_ID) LOOP EXTEND_PERM_TO_USER(A_PERMISSION, P_USER_ID);
END LOOP;
END USER_ADDED_TO_CONDITION; PROCEDURE USER_REMOVED_FROM_CONDITION(P_USER_ID IN CONDITION_MATCH.USER_ID%TYPE, P_CONDITION_ID IN CONDITION_MATCH.CONDITION_ID%TYPE) IS
BEGIN
FOR A_PERMISSION IN CONDITION_ACTOR_PERMISSIONS(P_CONDITION_ID) LOOP WITHDRAW_PERM_FROM_USER(A_PERMISSION, P_USER_ID);
END LOOP;
END USER_REMOVED_FROM_CONDITION; PROCEDURE USER_GROUP_REMOVED_FROM_PARENT(P_PARENT_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_USER_GROUP_ID IN USER_GROUP.ID%TYPE) IS
BEGIN
FOR A_PERMISSION IN ORG_ACTOR_PERMISSIONS(P_PARENT_ID) LOOP WITHDRAW_PERM_FROM_USER_GROUP(A_PERMISSION, P_USER_GROUP_ID);
END LOOP; CHILD_TARGET_REMOVED(P_PARENT_ID, P_USER_GROUP_ID);
END USER_GROUP_REMOVED_FROM_PARENT; PROCEDURE USER_GROUP_ADDED_TO_PARENT(P_SITE_ID IN USER_GROUP.SITE_ID%TYPE, P_PARENT_ID IN PRIVILEGE_REF.TARGET_ID%TYPE, P_USER_GROUP_ID IN USER_GROUP.ID%TYPE) IS
BEGIN
FOR A_PERMISSION IN ORG_ACTOR_PERMISSIONS(P_PARENT_ID) LOOP EXTEND_PERM_TO_USER_GROUP(A_PERMISSION, P_USER_GROUP_ID);
END LOOP; CHILD_TARGET_ADDED(P_SITE_ID, P_PARENT_ID, P_USER_GROUP_ID);
END USER_GROUP_ADDED_TO_PARENT; PROCEDURE PERMISSION_GRANTED(P_ID IN USER_ROLE.ID%TYPE, P_SITE_ID IN USER_ROLE.SITE_ID%TYPE, P_USER_ID IN USER_ROLE.USER_ID%TYPE, P_USER_GROUP_ID IN USER_ROLE.USER_GROUP_ID%TYPE, P_LOGICAL_GROUP_ID IN USER_ROLE.LOGICAL_GROUP_ID%TYPE, P_ROLE_ID IN USER_ROLE.ROLE_ID%TYPE, P_PRIVILEGE_ID IN USER_ROLE.PRIVILEGE_ID%TYPE, P_TARGET_ID IN USER_ROLE.TARGET_ID%TYPE) IS
BEGIN
EXTEND_PERMISSION(CREATE_PERMISSION(P_ID, P_SITE_ID, P_USER_ID, P_USER_GROUP_ID, P_LOGICAL_GROUP_ID, P_ROLE_ID, P_PRIVILEGE_ID, P_TARGET_ID));
END PERMISSION_GRANTED; PROCEDURE PERMISSION_REVOKED(P_ID IN USER_ROLE.ID%TYPE, P_SITE_ID IN USER_ROLE.SITE_ID%TYPE, P_USER_ID IN USER_ROLE.USER_ID%TYPE, P_USER_GROUP_ID IN USER_ROLE.USER_GROUP_ID%TYPE, P_LOGICAL_GROUP_ID IN USER_ROLE.LOGICAL_GROUP_ID%TYPE, P_ROLE_ID IN USER_ROLE.ROLE_ID%TYPE, P_PRIVILEGE_ID IN USER_ROLE.PRIVILEGE_ID%TYPE, P_TARGET_ID IN USER_ROLE.TARGET_ID%TYPE) IS
BEGIN
WITHDRAW_PERMISSION(CREATE_PERMISSION(P_ID, P_SITE_ID, P_USER_ID, P_USER_GROUP_ID, P_LOGICAL_GROUP_ID, P_ROLE_ID, P_PRIVILEGE_ID, P_TARGET_ID));
END PERMISSION_REVOKED; PROCEDURE ROLE_TARGETS_CHANGED(P_ROLE_ID IN ADMIN_ROLE.ID%TYPE, P_OLD_TARGETS IN ADMIN_ROLE.TARGETS%TYPE, P_NEW_TARGETS IN ADMIN_ROLE.TARGETS%TYPE) IS
V_TYPE CHAR(1); V_ADDED_TYPES ADMIN_ROLE.TARGETS%TYPE; V_REMOVED_TYPES ADMIN_ROLE.TARGETS%TYPE; I NUMBER;
BEGIN
V_ADDED_TYPES := NULL; V_REMOVED_TYPES := NULL; IF P_OLD_TARGETS IS
NULL THEN V_ADDED_TYPES := P_NEW_TARGETS; ELSIF P_NEW_TARGETS IS
NULL THEN V_REMOVED_TYPES := P_OLD_TARGETS; ELSE FOR I IN 1 .. LENGTH(P_OLD_TARGETS) LOOP V_TYPE := SUBSTR(P_OLD_TARGETS, I, 1); IF INSTR(P_NEW_TARGETS, V_TYPE) = 0 THEN V_REMOVED_TYPES := V_REMOVED_TYPES || V_TYPE;
END IF;
END LOOP; FOR I IN 1 .. LENGTH(P_NEW_TARGETS) LOOP V_TYPE := SUBSTR(P_NEW_TARGETS, I, 1); IF INSTR(P_OLD_TARGETS, V_TYPE) = 0 THEN V_ADDED_TYPES := V_ADDED_TYPES || V_TYPE;
END IF;
END LOOP;
END IF; IF V_ADDED_TYPES IS
NOT NULL THEN FOR A_PERMISSION IN ROLE_PERMISSIONS(P_ROLE_ID) LOOP EXTEND_PERM_TO_TARGET_CASCADE(A_PERMISSION, A_PERMISSION.TARGET_ID, V_ADDED_TYPES);
END LOOP;
END IF; IF V_REMOVED_TYPES IS
NOT NULL THEN FOR A_PERMISSION IN ROLE_PERMISSIONS(P_ROLE_ID) LOOP WITHDRAW_PERM_FROM_TARGET_CASC(A_PERMISSION, A_PERMISSION.TARGET_ID, V_REMOVED_TYPES);
END LOOP;
END IF;
END ROLE_TARGETS_CHANGED; PROCEDURE UPDATE_PRIVILEGES IS
CURSOR ALL_PERMISSIONS RETURN PERMISSION IS
SELECT UR.ID AS
ID, UR.SITE_ID AS
SITE_ID, UR.USER_ID AS
USER_ID, UR.USER_GROUP_ID AS
USER_GROUP_ID, UR.LOGICAL_GROUP_ID AS
LOGICAL_GROUP_ID, UR.TARGET_ID AS
TARGET_ID, NVL(P.TARGETS, R.TARGETS) AS
TARGET_TYPES FROM USER_ROLE UR, ADMIN_PRIVILEGE P, ADMIN_ROLE R WHERE UR.ROLE_ID = R.ID(+) AND UR.PRIVILEGE_ID = P.ID(+);
BEGIN
DELETE FROM PRIVILEGE_REF; FOR A_PERMISSION IN ALL_PERMISSIONS LOOP EXTEND_PERMISSION(A_PERMISSION);
END LOOP;
END UPDATE_PRIVILEGES; FUNCTION TABLE_NAME_FOR_TYPE(P_TABLE_TYPE IN CHAR) RETURN VARCHAR2 IS
BEGIN
IF P_TABLE_TYPE = ILA_PRIV.TARGET_TYPE_SITE THEN RETURN 'site'; ELSIF P_TABLE_TYPE = ILA_PRIV.TARGET_TYPE_USER THEN RETURN 'sys_user'; ELSIF P_TABLE_TYPE = ILA_PRIV.TARGET_TYPE_ORGANIZATION THEN RETURN 'user_group'; ELSIF P_TABLE_TYPE = ILA_PRIV.TARGET_TYPE_RCO THEN RETURN 'rco'; ELSIF P_TABLE_TYPE = ILA_PRIV.TARGET_TYPE_CONTENT_FOLDER THEN RETURN 'content_group'; ELSIF P_TABLE_TYPE = ILA_PRIV.TARGET_TYPE_CLASSROOM THEN RETURN 'classroom'; ELSIF P_TABLE_TYPE = ILA_PRIV.TARGET_TYPE_CLASSROOM_GROUP THEN RETURN 'classroom_group'; ELSIF P_TABLE_TYPE = ILA_PRIV.TARGET_TYPE_USER_GROUP THEN RETURN 'logical_group'; ELSIF P_TABLE_TYPE = ILA_PRIV.TARGET_TYPE_CHAT THEN RETURN 'chat'; ELSIF P_TABLE_TYPE = ILA_PRIV.TARGET_TYPE_FORUM THEN RETURN 'forum'; ELSIF P_TABLE_TYPE = ILA_PRIV.TARGET_TYPE_ADHOC_REPORT THEN RETURN 'adhoc_report'; ELSE RETURN NULL;
END IF;
END TABLE_NAME_FOR_TYPE;*/
END;
/
