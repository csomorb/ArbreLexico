package arbreLexico.v5.aspectVisualisation;

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
		// classe à appeler depuis l'interface graphique pour afficher la JTree
	}
	
	//Methodes pour treemodel
	@Override
	public void ArbreLexicographique.addTreeModelListener(TreeModelListener l) {
		// TODO Auto-generated method stub

	}

	@Override
	public Object ArbreLexicographique.getChild(Object parent, int index) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int ArbreLexicographique.getChildCount(Object parent) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int ArbreLexicographique.getIndexOfChild(Object parent, Object child) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Object ArbreLexicographique.getRoot() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean ArbreLexicographique.isLeaf(Object node) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void ArbreLexicographique.removeTreeModelListener(TreeModelListener l) {
		// TODO Auto-generated method stub

	}

	@Override
	public void ArbreLexicographique.valueForPathChanged(TreePath path, Object newValue) {
		// TODO Auto-generated method stub

	}
	
	//methodes pout treenode
	
	
}
