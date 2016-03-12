create or replace package ila_tree as

procedure create_node(
  p_node_id in tree_xref.parent_id%type,
   p_site_id in tree_xref.parent_id%type,
   p_object_type in tree_xref.parent_object_type%type,
  p_tree_type in tree_xref.tree_type%type);

procedure create_leaf_node(
  p_node_id in tree_xref.parent_id%type,
   p_site_id in tree_xref.parent_id%type,
   p_parent_id in tree_xref.parent_id%type,
   p_object_type in tree_xref.parent_object_type%type,
  p_tree_type in tree_xref.tree_type%type);

procedure delete_node(
  p_node_id in tree_xref.parent_id%type,
  p_tree_type in tree_xref.tree_type%type);

procedure delete_leaf_node(
  p_node_id in tree_xref.parent_id%type,
  p_tree_type in tree_xref.tree_type%type);

procedure add_child(
   p_site_id in tree_xref.parent_id%type,
  p_parent_id in tree_xref.parent_id%type,
   p_child_id in tree_xref.child_id%type,
  p_tree_type in tree_xref.tree_type%type);

procedure add_leaf_child(
   p_site_id in tree_xref.parent_id%type,
   p_parent_id in tree_xref.parent_id%type,
   p_child_id in tree_xref.child_id%type,
   p_child_object_type in tree_xref.child_object_type%type,
   p_tree_type in tree_xref.tree_type%type);

procedure remove_leaf_child(
   p_parent_id in tree_xref.parent_id%type,
   p_child_id in tree_xref.child_id%type,
   p_tree_type in tree_xref.tree_type%type);

procedure remove_child(
  p_parent_id in tree_xref.parent_id%type,
   p_child_id in tree_xref.child_id%type,
  p_tree_type in tree_xref.tree_type%type);

end ila_tree;
/

CREATE OR REPLACE PACKAGE BODY ILA_TREE IS
  CURSOR ANCESTORS(P_ID   IN TREE_XREF.CHILD_ID%TYPE,
                   P_TYPE IN TREE_XREF.TREE_TYPE%TYPE) IS
    SELECT PARENT_ID ID, DISTANCE, PARENT_OBJECT_TYPE OBJECT_TYPE
      FROM TREE_XREF
     WHERE CHILD_ID = P_ID
       AND TREE_TYPE = P_TYPE;
  CURSOR DESCENDANTS(P_ID   IN TREE_XREF.PARENT_ID%TYPE,
                     P_TYPE IN TREE_XREF.TREE_TYPE%TYPE) IS
    SELECT CHILD_ID ID, DISTANCE, CHILD_OBJECT_TYPE OBJECT_TYPE
      FROM TREE_XREF
     WHERE PARENT_ID = P_ID
       AND TREE_TYPE = P_TYPE;
  CURSOR CHILDREN(P_ID   IN TREE_XREF.PARENT_ID%TYPE,
                  P_TYPE IN TREE_XREF.TREE_TYPE%TYPE) IS
    SELECT CHILD_ID ID
      FROM TREE_XREF
     WHERE PARENT_ID = P_ID
       AND TREE_TYPE = P_TYPE
       AND DISTANCE = 1;
  CURSOR PARENTS(P_ID   IN TREE_XREF.CHILD_ID%TYPE,
                 P_TYPE IN TREE_XREF.TREE_TYPE%TYPE) IS
    SELECT PARENT_ID ID
      FROM TREE_XREF
     WHERE CHILD_ID = P_ID
       AND TREE_TYPE = P_TYPE
       AND DISTANCE = 1;
  PROCEDURE CREATE_NODE(P_NODE_ID     IN TREE_XREF.PARENT_ID%TYPE,
                        P_SITE_ID     IN TREE_XREF.PARENT_ID%TYPE,
                        P_OBJECT_TYPE IN TREE_XREF.PARENT_OBJECT_TYPE%TYPE,
                        P_TREE_TYPE   IN TREE_XREF.TREE_TYPE%TYPE) IS
  BEGIN
    INSERT INTO TREE_XREF
      (PARENT_ID,
       CHILD_ID,
       DISTANCE,
       PATH_COUNT,
       PARENT_OBJECT_TYPE,
       CHILD_OBJECT_TYPE,
       CHILD_COUNT,
       TREE_TYPE)
    VALUES
      (P_NODE_ID,
       P_NODE_ID,
       0,
       '1',
       P_OBJECT_TYPE,
       P_OBJECT_TYPE,
       0,
       P_TREE_TYPE);
  END CREATE_NODE;
  PROCEDURE CREATE_LEAF_NODE(P_NODE_ID     IN TREE_XREF.PARENT_ID%TYPE,
                             P_SITE_ID     IN TREE_XREF.PARENT_ID%TYPE,
                             P_PARENT_ID   IN TREE_XREF.PARENT_ID%TYPE,
                             P_OBJECT_TYPE IN TREE_XREF.PARENT_OBJECT_TYPE%TYPE,
                             P_TREE_TYPE   IN TREE_XREF.TREE_TYPE%TYPE) IS
  BEGIN
    CREATE_NODE(P_NODE_ID, P_SITE_ID, P_OBJECT_TYPE, P_TREE_TYPE);
    FOR AN_ANCESTOR IN ANCESTORS(P_PARENT_ID, P_TREE_TYPE) LOOP
      INSERT INTO TREE_XREF
        (PARENT_ID,
         CHILD_ID,
         DISTANCE,
         PATH_COUNT,
         PARENT_OBJECT_TYPE,
         CHILD_OBJECT_TYPE,
         CHILD_COUNT,
         TREE_TYPE)
      VALUES
        (AN_ANCESTOR.ID,
         P_NODE_ID,
         AN_ANCESTOR.DISTANCE + 1,
         '1',
         AN_ANCESTOR.OBJECT_TYPE,
         P_OBJECT_TYPE,
         0,
         P_TREE_TYPE);
    END LOOP;
    UPDATE TREE_XREF
       SET CHILD_COUNT = CHILD_COUNT + 1
     WHERE CHILD_ID = P_PARENT_ID
       AND TREE_TYPE = P_TREE_TYPE;
  END CREATE_LEAF_NODE;
  PROCEDURE DELETE_LEAF_NODE(P_NODE_ID   IN TREE_XREF.PARENT_ID%TYPE,
                             P_TREE_TYPE IN TREE_XREF.TREE_TYPE%TYPE) IS
  BEGIN
    FOR A_PARENT IN PARENTS(P_NODE_ID, P_TREE_TYPE) LOOP
      UPDATE TREE_XREF
         SET CHILD_COUNT = CHILD_COUNT - 1
       WHERE CHILD_ID = A_PARENT.ID
         AND TREE_TYPE = P_TREE_TYPE;
    END LOOP;
    DELETE FROM TREE_XREF
     WHERE CHILD_ID = P_NODE_ID
       AND TREE_TYPE = P_TREE_TYPE;
  END DELETE_LEAF_NODE;
  PROCEDURE DELETE_NODE(P_NODE_ID   IN TREE_XREF.PARENT_ID%TYPE,
                        P_TREE_TYPE IN TREE_XREF.TREE_TYPE%TYPE) IS
  BEGIN
    FOR A_CHILD IN CHILDREN(P_NODE_ID, P_TREE_TYPE) LOOP
      REMOVE_CHILD(P_NODE_ID, A_CHILD.ID, P_TREE_TYPE);
    END LOOP;
    DELETE_LEAF_NODE(P_NODE_ID, P_TREE_TYPE);
  END DELETE_NODE;
  PROCEDURE ADD_LEAF_CHILD(P_SITE_ID           IN TREE_XREF.PARENT_ID%TYPE,
                           P_PARENT_ID         IN TREE_XREF.PARENT_ID%TYPE,
                           P_CHILD_ID          IN TREE_XREF.CHILD_ID%TYPE,
                           P_CHILD_OBJECT_TYPE IN TREE_XREF.CHILD_OBJECT_TYPE%TYPE,
                           P_TREE_TYPE         IN TREE_XREF.TREE_TYPE%TYPE) IS
    V_DISTANCE TREE_XREF.DISTANCE%TYPE;
  BEGIN
    FOR AN_ANCESTOR IN ANCESTORS(P_PARENT_ID, P_TREE_TYPE) LOOP
      V_DISTANCE := AN_ANCESTOR.DISTANCE + 1;
      BEGIN
        INSERT INTO TREE_XREF
          (PARENT_ID,
           CHILD_ID,
           DISTANCE,
           PATH_COUNT,
           PARENT_OBJECT_TYPE,
           CHILD_OBJECT_TYPE,
           CHILD_COUNT,
           TREE_TYPE)
        VALUES
          (AN_ANCESTOR.ID,
           P_CHILD_ID,
           V_DISTANCE,
           '1',
           AN_ANCESTOR.OBJECT_TYPE,
           P_CHILD_OBJECT_TYPE,
           0,
           P_TREE_TYPE);
      EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
          UPDATE TREE_XREF
             SET PATH_COUNT = TO_NUMBER(PATH_COUNT) + 1
           WHERE TREE_TYPE = P_TREE_TYPE
             AND PARENT_ID = AN_ANCESTOR.ID
             AND CHILD_ID = P_CHILD_ID
             AND DISTANCE = V_DISTANCE;
      END;
    END LOOP;
    UPDATE TREE_XREF
       SET CHILD_COUNT = CHILD_COUNT + 1
     WHERE CHILD_ID = P_PARENT_ID
       AND TREE_TYPE = P_TREE_TYPE;
  END ADD_LEAF_CHILD;
  PROCEDURE ADD_CHILD(P_SITE_ID   IN TREE_XREF.PARENT_ID%TYPE,
                      P_PARENT_ID IN TREE_XREF.PARENT_ID%TYPE,
                      P_CHILD_ID  IN TREE_XREF.CHILD_ID%TYPE,
                      P_TREE_TYPE IN TREE_XREF.TREE_TYPE%TYPE) IS
    V_DISTANCE      TREE_XREF.DISTANCE%TYPE;
    V_BASE_DISTANCE TREE_XREF.DISTANCE%TYPE;
    V_CHILD_COUNT   TREE_XREF.CHILD_COUNT%TYPE;
  BEGIN
    FOR A_DESCENDANT IN DESCENDANTS(P_CHILD_ID, P_TREE_TYPE) LOOP
      V_BASE_DISTANCE := 1 + A_DESCENDANT.DISTANCE;
      SELECT CHILD_COUNT
        INTO V_CHILD_COUNT
        FROM TREE_XREF
       WHERE PARENT_ID = A_DESCENDANT.ID
         AND CHILD_ID = A_DESCENDANT.ID
         AND DISTANCE = 0
         AND TREE_TYPE = P_TREE_TYPE;
      FOR AN_ANCESTOR IN ANCESTORS(P_PARENT_ID, P_TREE_TYPE) LOOP
        V_DISTANCE := V_BASE_DISTANCE + AN_ANCESTOR.DISTANCE;
        BEGIN
          INSERT INTO TREE_XREF
            (PARENT_ID,
             CHILD_ID,
             DISTANCE,
             PATH_COUNT,
             PARENT_OBJECT_TYPE,
             CHILD_OBJECT_TYPE,
             CHILD_COUNT,
             TREE_TYPE)
          VALUES
            (AN_ANCESTOR.ID,
             A_DESCENDANT.ID,
             V_DISTANCE,
             '1',
             AN_ANCESTOR.OBJECT_TYPE,
             A_DESCENDANT.OBJECT_TYPE,
             V_CHILD_COUNT,
             P_TREE_TYPE);
        EXCEPTION
          WHEN DUP_VAL_ON_INDEX THEN
            UPDATE TREE_XREF
               SET PATH_COUNT = TO_NUMBER(PATH_COUNT) + 1
             WHERE TREE_TYPE = P_TREE_TYPE
               AND PARENT_ID = AN_ANCESTOR.ID
               AND CHILD_ID = A_DESCENDANT.ID
               AND DISTANCE = V_DISTANCE;
        END;
      END LOOP;
    END LOOP;
    UPDATE TREE_XREF
       SET CHILD_COUNT = CHILD_COUNT + 1
     WHERE CHILD_ID = P_PARENT_ID
       AND TREE_TYPE = P_TREE_TYPE;
  END ADD_CHILD;
  PROCEDURE PURGE_BY_PATH_COUNT IS
  BEGIN
    DELETE /*+ index (tree_xref  tree_xref_path_count_index) */
    FROM TREE_XREF
     WHERE PATH_COUNT = '0';
  END PURGE_BY_PATH_COUNT;
  PROCEDURE REMOVE_LEAF_CHILD(P_PARENT_ID IN TREE_XREF.PARENT_ID%TYPE,
                              P_CHILD_ID  IN TREE_XREF.CHILD_ID%TYPE,
                              P_TREE_TYPE IN TREE_XREF.TREE_TYPE%TYPE) IS
  BEGIN
    UPDATE TREE_XREF
       SET PATH_COUNT = TO_NUMBER(PATH_COUNT) - 1
     WHERE TREE_TYPE = P_TREE_TYPE
       AND PARENT_ID IN (SELECT PARENT_ID
                           FROM TREE_XREF
                          WHERE CHILD_ID = P_PARENT_ID
                            AND TREE_TYPE = P_TREE_TYPE)
       AND CHILD_ID = P_CHILD_ID;
    PURGE_BY_PATH_COUNT;
    UPDATE TREE_XREF
       SET CHILD_COUNT = CHILD_COUNT - 1
     WHERE CHILD_ID = P_PARENT_ID
       AND TREE_TYPE = P_TREE_TYPE;
  END REMOVE_LEAF_CHILD;
  PROCEDURE REMOVE_CHILD(P_PARENT_ID IN TREE_XREF.PARENT_ID%TYPE,
                         P_CHILD_ID  IN TREE_XREF.CHILD_ID%TYPE,
                         P_TREE_TYPE IN TREE_XREF.TREE_TYPE%TYPE) IS
  BEGIN
    UPDATE TREE_XREF
       SET PATH_COUNT = TO_NUMBER(PATH_COUNT) - 1
     WHERE TREE_TYPE = P_TREE_TYPE
       AND PARENT_ID IN (SELECT PARENT_ID
                           FROM TREE_XREF
                          WHERE CHILD_ID = P_PARENT_ID
                            AND TREE_TYPE = P_TREE_TYPE)
       AND CHILD_ID IN (SELECT CHILD_ID
                          FROM TREE_XREF
                         WHERE PARENT_ID = P_CHILD_ID
                           AND TREE_TYPE = P_TREE_TYPE);
    PURGE_BY_PATH_COUNT;
    UPDATE TREE_XREF
       SET CHILD_COUNT = CHILD_COUNT - 1
     WHERE CHILD_ID = P_PARENT_ID
       AND TREE_TYPE = P_TREE_TYPE;
  END REMOVE_CHILD;
END ILA_TREE;
/
