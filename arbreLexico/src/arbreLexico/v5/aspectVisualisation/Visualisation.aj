package arbreLexico.v5.aspectVisualisation;

import java.util.Enumeration;

import javax.swing.JTree;
import javax.swing.event.TreeModelListener;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;
import javax.swing.tree.TreeModel;
import javax.swing.tree.TreeNode;
import javax.swing.tree.TreePath;

public aspect Visualisation {

	declare parents : ArbreLexicographique implements TreeModel;
	declare parents : NoeudAbstrait implements TreeNode;
	
	private DefaultTreeModel ArbreLexicographique.defaultTreeModel;
	
	private DefaultMutableTreeNode NoeudAbstrait.defaultMutableTreeNode;
	
	private JTree ArbreLexicographique.vue;
	
	public void ArbreLexicographique.setVue(JTree jt){
		// classe � appeler depuis l'interface graphique pour afficher la JTree
	}
	
	//Methodes pour treemodel
	public void ArbreLexicographique.addTreeModelListener(TreeModelListener l) {
		// TODO Auto-generated method stub

	}

	public Object ArbreLexicographique.getChild(Object parent, int index) {
		// TODO Auto-generated method stub
		return null;
	}

	public int ArbreLexicographique.getChildCount(Object parent) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int ArbreLexicographique.getIndexOfChild(Object parent, Object child) {
		// TODO Auto-generated method stub
		return 0;
	}

	public Object ArbreLexicographique.getRoot() {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean ArbreLexicographique.isLeaf(Object node) {
		// TODO Auto-generated method stub
		return false;
	}

	public void ArbreLexicographique.removeTreeModelListener(TreeModelListener l) {
		// TODO Auto-generated method stub

	}

	public void ArbreLexicographique.valueForPathChanged(TreePath path, Object newValue) {
		// TODO Auto-generated method stub

	}
	
	//methodes pout treenode
	
	@SuppressWarnings("rawtypes")
	public Enumeration NoeudAbstrait.children() {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean NoeudAbstrait.getAllowsChildren() {
		// TODO Auto-generated method stub
		return false;
	}

	public TreeNode NoeudAbstrait.getChildAt(int arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public int NoeudAbstrait.getChildCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	public int NoeudAbstrait.getIndex(TreeNode arg0) {
		// TODO Auto-generated method stub
		return 0;
	}

	public TreeNode NoeudAbstrait.getParent() {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean NoeudAbstrait.isLeaf() {
		// TODO Auto-generated method stub
		return false;
	}
}
