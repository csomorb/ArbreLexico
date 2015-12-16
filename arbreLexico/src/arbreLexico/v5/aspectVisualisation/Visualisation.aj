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
	
//	private JTree ArbreLexicographique.vue;
	public JTree ArbreLexicographique.vue;
	
	public void ArbreLexicographique.setVue(JTree jt){
		// classe à appeler depuis l'interface graphique pour afficher la JTree
		this.vue = jt;
	}

	pointcut ajout(ArbreLexicographique arbre): call(boolean ArbreLexicographique.ajout(String)) && target (arbre);
	after (ArbreLexicographique arbre) returning (boolean modifie):ajout(arbre){
		if(modifie){
			System.out.print("L'arbre a ete modifie");
			DefaultMutableTreeNode tr = new DefaultMutableTreeNode("");  
			
			
		}
	}
	
	// modification du constructeur de la classe arbrelexicographique 
	pointcut constructeurArbre(ArbreLexicographique arbre) : execution(ArbreLexicographique.new()) && target (arbre);
	 
	after(ArbreLexicographique arbre) : constructeurArbre(arbre){
		arbre.entree.defaultMutableTreeNode = new DefaultMutableTreeNode("");
		arbre.defaultTreeModel = new DefaultTreeModel(arbre.entree.defaultMutableTreeNode);
		arbre.vue = new JTree(arbre.defaultTreeModel);
	}

	//Methodes pour treemodel
	public void ArbreLexicographique.addTreeModelListener(TreeModelListener l) {
		this.defaultTreeModel.addTreeModelListener(l);
	}

	public Object ArbreLexicographique.getChild(Object parent, int index) {
		return this.defaultTreeModel.getChild(parent, index);
	}

	public int ArbreLexicographique.getChildCount(Object parent) {
		return this.defaultTreeModel.getChildCount(parent) ;
	}

	public int ArbreLexicographique.getIndexOfChild(Object parent, Object child) {
		return this.defaultTreeModel.getIndexOfChild(parent, child);
	}

	public Object ArbreLexicographique.getRoot() {
		return this.defaultTreeModel.getRoot();
	}

	public boolean ArbreLexicographique.isLeaf(Object node) {
		return this.defaultTreeModel.isLeaf(node);
	}

	public void ArbreLexicographique.removeTreeModelListener(TreeModelListener l) {
		this.defaultTreeModel.removeTreeModelListener(l);
	}

	public void ArbreLexicographique.valueForPathChanged(TreePath path, Object newValue) {
		this.defaultTreeModel.valueForPathChanged(path,newValue);
	}
	
	//methodes pout treenode
	
	@SuppressWarnings("rawtypes")
	public Enumeration NoeudAbstrait.children() {
		return this.defaultMutableTreeNode.children();
	}

	public boolean NoeudAbstrait.getAllowsChildren() {
		return this.defaultMutableTreeNode.getAllowsChildren();
	}

	public TreeNode NoeudAbstrait.getChildAt(int arg0) {
		return this.defaultMutableTreeNode.getChildAt(arg0);
	}

	public int NoeudAbstrait.getChildCount() {
		return this.defaultMutableTreeNode.getChildCount();
	}

	public int NoeudAbstrait.getIndex(TreeNode arg0) {
		return this.defaultMutableTreeNode.getIndex(arg0);
	}

	public TreeNode NoeudAbstrait.getParent() {
		return this.defaultMutableTreeNode.getParent();
	}

	public boolean NoeudAbstrait.isLeaf() {
		return this.defaultMutableTreeNode.isLeaf();
	}
}
