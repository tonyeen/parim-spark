package net.parim.system.service;

import java.util.List;

import net.parim.system.entity.Site;
import net.parim.system.entity.TreeXref;
import net.parim.system.repository.TreeXrefRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TreeXrefService {
	@Autowired
	TreeXrefRepository treeXrefRepository ;
	
	public void removeLeafChild(Site site){
		this.removeLeafNode(getTreeNode(site));
	}
	
	public TreeXref getTreeNode(Site site){
		TreeXref node = new TreeXref();
		node.setChildId(site.getId());
		node.setParentId(site.getParentId());
		node.setChildObjectType("S");
		node.setTreeType("P");
		return node;
	}

	protected void removeLeafNode(TreeXref node){
		//查询父级节点
		List<TreeXref> parents = treeXrefRepository.findParents(node);
		for(TreeXref parent : parents){
			parent.setChildCount(parent.getChildCount() - 1);
			treeXrefRepository.update(parent);
		}
		
		treeXrefRepository.removeByChildId(node.getChildId());
	}
	
	protected void createLeafNode(TreeXref node){
		addChild(node);
		List<TreeXref> ancestors = treeXrefRepository.findAncestors(node);
		for(TreeXref ancestor : ancestors){
			ancestor.setChildCount(ancestor.getChildCount() + 1);
			treeXrefRepository.update(ancestor);
		}
	}
	
	protected void addChild(TreeXref node){
		
	}
	
	protected void removeChild(TreeXref node){
		
	}
	
}
