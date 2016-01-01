package arbreLexico.v5.aspectVisualisation;

import java.util.Enumeration;

import javax.swing.JTree;
import javax.swing.event.TreeModelListener;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;
import javax.swing.tree.TreeModel;
import javax.swing.tree.TreeNode;
import javax.swing.tree.TreePath;
import javax.swing.tree.MutableTreeNode;



public aspect Visualisation {
	// declaration intertype indiquant que ArbreLexicographique implémente TreeModel et NoeudAbstrait implemente TreeNode
/*	declare parents : ArbreLexicographique implements TreeModel;
	declare parents : NoeudAbstrait implements TreeNode;
	
	// Attribut privé de type DefaultTreeModel dans ArbreLexicographique 
	private DefaultTreeModel ArbreLexicographique.defaultTreeModel;
	// Attribut privé de type DefaultMutableTreeNode dans NoeudAbstrait 
	private DefaultMutableTreeNode NoeudAbstrait.defaultMutableTreeNode;
	
	// Attribut privé vue de type jTree dans ArbreLexicographique
	private JTree ArbreLexicographique.vue;	
	// Methode Vue dans ArbreLexicographique permettant de modifier la valeur de l'attribut vue
	// classe à  appeler depuis l'interface graphique pour afficher la JTree
	public void ArbreLexicographique.setVue(JTree jt){
		this.vue = jt;
	}
*/
	/*pointcut ajout(ArbreLexicographique arbre): call(boolean ArbreLexicographique.ajout(String)) && target (arbre);
	after (ArbreLexicographique arbre) returning (boolean modifie):ajout(arbre){
		if(modifie){
			System.out.print("L'arbre a ete modifie");
			DefaultMutableTreeNode tr = new DefaultMutableTreeNode("");  
		}
	}*/
	
	// == ArbreLexicographique - Attributs == //
	declare parents : ArbreLexicographique implements TreeModel;
	private DefaultTreeModel ArbreLexicographique.defaultTreeModel;
	private JTree ArbreLexicographique.vue;	
	
	//== NoeudAbstrait - Attributs == //
	declare parents : NoeudAbstrait implements TreeNode;
	private DefaultMutableTreeNode NoeudAbstrait.defaultMutableTreeNode;
	
	//== ArbreLexicographique - Methodes == //
	public void ArbreLexicographique.setVue(JTree jt){
		this.vue = jt;
	}
	
	pointcut constructeurArbre(ArbreLexicographique arbre) : target (arbre) && execution(ArbreLexicographique.new());
	after(ArbreLexicographique arbre) : constructeurArbre(arbre){
		arbre.defaultTreeModel = new DefaultTreeModel(new DefaultMutableTreeNode());
		//arbre.entree.defaultMutableTreeNode = new DefaultMutableTreeNode("");
		//arbre.defaultTreeModel = new DefaultTreeModel(arbre.entree.defaultMutableTreeNode);
		//arbre.vue = new JTree(arbre.defaultTreeModel);
		System.out.println("creation arbreLexico");
	}
	// si modification de la variable ArbreLexicographique.entree, on capture sans rien faire
	pointcut ajoutArbre(ArbreLexicographique arbre) : this(arbre) && set(NoeudAbstrait ArbreLexicographique.entree);
	after(ArbreLexicographique arbre) : ajoutArbre(arbre){
		System.out.println("modification d'entrée");
	}
	// pour faire des test //
	pointcut ajoutArbreLexicoTest(ArbreLexicographique arbre) : target (arbre) && execution(boolean ArbreLexicographique.ajout(String));
	before(ArbreLexicographique arbre) : ajoutArbreLexicoTest(arbre){
		System.out.println("appel modification d'entrée");
	}
	// si appel de ajout arbre et modification de entree, alors y'a eu un ajout donc on capture
	pointcut ajoutArbreLexico(ArbreLexicographique arbre) : target (arbre) && ajoutArbre(ArbreLexicographique) && withincode(boolean ArbreLexicographique.ajout(String));
	after(ArbreLexicographique arbre) : ajoutArbreLexico(arbre){
		System.out.println("ajout arbre lexicographique");
	}
	
	pointcut supprArbre(ArbreLexicographique arbre) : target (arbre) && execution(boolean ArbreLexicographique.suppr(String));
	after(ArbreLexicographique arbre) : supprArbre(arbre){
		System.out.println("suppression arbre lexicographique");
	}
	
	pointcut constructeurMarque(Marque marque, NoeudAbstrait frere) : target (marque) && args(frere) && execution(Marque.new(NoeudAbstrait));
	after(Marque marque, NoeudAbstrait frere) : constructeurMarque(marque, frere){
		System.out.println("ajout marque");
	} 
	
	pointcut ConstructeurNoeud(Noeud nouveauNoeud, NoeudAbstrait frere, NoeudAbstrait fils, char valeur) : target (nouveauNoeud) && args(frere, fils, valeur) && execution(Noeud.new(NoeudAbstrait , NoeudAbstrait , char));
	after(Noeud nouveauNoeud, NoeudAbstrait frere, NoeudAbstrait fils, char valeur) : ConstructeurNoeud(nouveauNoeud, frere, fils, valeur){
		System.out.println("ajout noeud");
	}
	
	// modification du constructeur de la classe arbrelexicographique 
	/*pointcut constructeurArbre(ArbreLexicographique arbre) : execution(ArbreLexicographique.new()) && target (arbre);
		after(ArbreLexicographique arbre) : constructeurArbre(arbre){
			arbre.entree.defaultMutableTreeNode = new DefaultMutableTreeNode("");
			arbre.defaultTreeModel = new DefaultTreeModel(arbre.entree.defaultMutableTreeNode);
			arbre.vue = new JTree(arbre.defaultTreeModel);
		}
	*/
	//======================================================================================//
	// Introduction des methodes necessaires pour que l'interface TreeModel soit implémenté //
	// ArbreLexicographique.TreeModel
	
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
	
	//======================================================================================//
	// Introduction des methodes necessaires pour que l'interface TreeNode soit implémenté //
	// NoeudAbstrait.TreeNode
	
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
