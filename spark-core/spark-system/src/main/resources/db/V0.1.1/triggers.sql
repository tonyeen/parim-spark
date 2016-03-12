CREATE OR REPLACE TRIGGER "SITE_DELETE"
before delete on site for each row
   begin
      -- Copy the SITE into the archive table
      
      ila_priv.target_deleted(:old.id);
      ila_tree.delete_leaf_node(:old.id, ila_priv.TREE_TYPE_PRIVILEGE);

      ila_tree.delete_leaf_node(:old.id, ila_priv.TREE_TYPE_MANAGER);
   end;
/

CREATE OR REPLACE TRIGGER "SITE_INSERT"
after insert on site for each row
   begin
      ila_tree.create_leaf_node(:new.id, :new.id, :new.parent_id, ila_priv.TARGET_TYPE_SITE, ila_priv.TREE_TYPE_PRIVILEGE);
      ila_priv.target_created(:new.id, :new.id, :new.parent_id, ila_priv.TARGET_TYPE_SITE);

      ila_tree.create_leaf_node(:new.id, :new.id, :new.parent_id, ila_priv.TARGET_TYPE_SITE, ila_priv.TREE_TYPE_MANAGER);
      --add default report group
      ila_seed.createDefaultAdhocGroup(:new.id,:new.short_name,:new.created_by);
   end;
/

CREATE OR REPLACE TRIGGER "SITE_PARENT_ID_UPDATE"
before update of parent_id on site for each row
   begin
      ila_priv.child_target_removed(:old.parent_id, :old.id);
      ila_tree.remove_child(:old.parent_id, :old.id, ila_priv.TREE_TYPE_PRIVILEGE);
      ila_tree.add_child(:old.id, :new.parent_id, :old.id, ila_priv.TREE_TYPE_PRIVILEGE);
      ila_priv.child_target_added(:new.id, :new.parent_id, :new.id);

      ila_tree.remove_child(:old.parent_id, :old.id, ila_priv.TREE_TYPE_MANAGER);
      ila_tree.add_child(:old.id, :new.parent_id, :old.id, ila_priv.TREE_TYPE_MANAGER);
   end;
/

CREATE OR REPLACE TRIGGER "UG_DELETE"
before delete on user_group for each row
   begin
      ila_priv.target_deleted(:old.id);
      ila_tree.delete_leaf_node(:old.id, ila_priv.TREE_TYPE_PRIVILEGE);
   end;
/

CREATE OR REPLACE TRIGGER "UG_INSERT"
after insert on user_group for each row
   declare
      v_parent_id number;
   begin
      v_parent_id := nvl(:new.parent_id, :new.site_id);
      ila_tree.create_leaf_node(
         :new.id, :new.site_id, v_parent_id, ila_priv.TARGET_TYPE_ORGANIZATION, ila_priv.TREE_TYPE_PRIVILEGE);
      ila_priv.target_created(:new.id, :new.site_id, v_parent_id, ila_priv.TARGET_TYPE_ORGANIZATION);
   end;
/

CREATE OR REPLACE TRIGGER "UG_PARENT_UPDATE"
before update of parent_id, site_id on user_group for each row
   declare
      v_new_parent_id number;
      v_old_parent_id number;
   begin
      v_old_parent_id := nvl(:old.parent_id, :old.site_id);
      v_new_parent_id := nvl(:new.parent_id, :new.site_id);
      if v_old_parent_id <> v_new_parent_id then
         ila_priv.user_group_removed_from_parent(v_old_parent_id, :old.id);
         ila_tree.remove_child(
            v_old_parent_id, :old.id, ila_priv.TREE_TYPE_PRIVILEGE);
         ila_tree.add_child(
            :new.site_id, v_new_parent_id, :new.id, ila_priv.TREE_TYPE_PRIVILEGE);
         ila_priv.user_group_added_to_parent(:new.site_id, v_new_parent_id, :new.id);
         ila_condition.org_parent_changed(:old.id, :new.site_id, v_old_parent_id, v_new_parent_id);
      end if;
   end;
/

CREATE OR REPLACE TRIGGER "USER_DELETE"
before delete on sys_user for each row
   begin
      ila_priv.user_deleted(:old.id);
      ila_tree.delete_leaf_node(:old.id, ila_priv.TREE_TYPE_PRIVILEGE);
      ila_tree.delete_leaf_node(:old.id, ila_priv.TREE_TYPE_MANAGER);

      -- Deleting condition_match records moved from java to plsql - djh
      --delete from condition_match where user_id = :old.id;
      -- Deleting attribute_value records moved from java to plsql - djh
      --delete from attribute_value where object_id = :old.id;

      -- Copy the user into the archive table
      
   end;
/

CREATE OR REPLACE TRIGGER "USER_INSERT"
after insert on sys_user for each row

declare
      v_parent_id number;
   begin
      v_parent_id := nvl(:new.user_group_id, :new.site_id);
      ila_tree.create_leaf_node(
         :new.id, :new.site_id, v_parent_id, ila_priv.TARGET_TYPE_USER, ila_priv.TREE_TYPE_PRIVILEGE);
      ila_priv.user_created(:new.id, :new.site_id, v_parent_id);
      /*insert into synch_condition_chg(user_id,site_id,old_group_id,new_group_id,type,create_date)
             values(:new.id,:new.site_id,0, v_parent_id,'I',sysdate);*/

      v_parent_id := nvl(:new.manager_id, :new.site_id);
      ila_tree.create_leaf_node(
         :new.id, :new.site_id, v_parent_id, ila_priv.TARGET_TYPE_USER, ila_priv.TREE_TYPE_MANAGER);
      --ila_condition.user_created(:new.id, :new.site_id, :new.user_group_id, :new.manager_id);

 end;
/

CREATE OR REPLACE TRIGGER "USER_PARENT_UPDATE"
before update of user_group_id, site_id/*, manager_id*/ on sys_user for each row

declare
      v_new_parent_id number;
      v_old_parent_id number;
   begin
      v_old_parent_id := nvl(:old.user_group_id, :old.site_id);
      v_new_parent_id := nvl(:new.user_group_id, :new.site_id);
      if v_old_parent_id <> v_new_parent_id then
         ila_priv.user_removed_from_parent(v_old_parent_id, :old.id);
         ila_tree.remove_leaf_child(
            v_old_parent_id, :old.id, ila_priv.TREE_TYPE_PRIVILEGE);
         ila_tree.add_leaf_child(
            :new.site_id, v_new_parent_id, :new.id, ila_priv.TARGET_TYPE_USER, ila_priv.TREE_TYPE_PRIVILEGE);
         ila_priv.user_added_to_parent(:new.site_id, v_new_parent_id, :new.id);
         --ila_condition.user_org_changed(:old.id, :new.site_id, v_old_parent_id, v_new_parent_id);
         /*insert into synch_condition_chg(user_id,site_id,old_group_id,new_group_id,type,create_date)
                values(:old.id,:new.site_id,v_old_parent_id, v_new_parent_id,'U',sysdate);*/
      end if;
      --exception when others then
        -- delete from synch_condition_chg where user_id = :old.id and old_group_id = v_new_parent_id and new_group_id = v_old_parent_id;

/*
      v_old_parent_id := nvl(:old.manager_id, :old.site_id);
      v_new_parent_id := nvl(:new.manager_id, :new.site_id);
      if v_old_parent_id <> v_new_parent_id then
         ila_tree.remove_child(
            v_old_parent_id, :old.id, ila_priv.TREE_TYPE_MANAGER);
         ila_tree.add_child(
            :new.site_id, v_new_parent_id, :new.id, ila_priv.TREE_TYPE_MANAGER);
         ila_condition.user_manager_changed(:old.id, :new.site_id, v_old_parent_id, v_new_parent_id);
      end if;
*/
   end;

/
