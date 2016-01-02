package arbreLexico.v6;

import java.util.Enumeration;

import javax.swing.JTree;
import javax.swing.event.TreeModelListener;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;
import javax.swing.tree.TreeModel;
import javax.swing.tree.TreeNode;
import javax.swing.tree.TreePath;

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
	
	/*pointcut constructeurArbre(ArbreLexicographique arbre) : execution(ArbreLexicographique.new()) && target (arbre);
	after(ArbreLexicographique arbre) : constructeurArbre(arbre){
		//arbre.defaultTreeModel = new DefaultTreeModel(new DefaultMutableTreeNode());
		//arbre.entree.defaultMutableTreeNode = new DefaultMutableTreeNode("");
		//arbre.defaultTreeModel = new DefaultTreeModel(arbre.entree.defaultMutableTreeNode);
		//arbre.vue = new JTree(arbre.defaultTreeModel);
		
		arbre.entree.defaultMutableTreeNode = new DefaultMutableTreeNode("");
		arbre.defaultTreeModel = new DefaultTreeModel(arbre.entree.defaultMutableTreeNode);
		
		System.out.println("creation arbreLexico");
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

	// ==== POINTCUT - ArbreLexicographique arbre ==== //	
	pointcut constructeurArbre(ArbreLexicographique arbre) : execution(ArbreLexicographique.new()) && target (arbre);
	after(ArbreLexicographique arbre) : constructeurArbre(arbre){
		//arbre.defaultTreeModel = new DefaultTreeModel(new DefaultMutableTreeNode());
		//arbre.entree.defaultMutableTreeNode = new DefaultMutableTreeNode("");
		//arbre.defaultTreeModel = new DefaultTreeModel(arbre.entree.defaultMutableTreeNode);
		//arbre.vue = new JTree(arbre.defaultTreeModel);
		DefaultMutableTreeNode racine = new DefaultMutableTreeNode("");
		arbre.defaultTreeModel = new DefaultTreeModel(racine);
		System.out.println("creation arbreLexico");
	}
	
	// si modification de la variable ArbreLexicographique.entree, on capture sans rien faire
	pointcut ajoutArbre(ArbreLexicographique arbre) : this(arbre) && set(NoeudAbstrait ArbreLexicographique.entree);
	after(ArbreLexicographique arbre) : ajoutArbre(arbre){
		System.out.println("modification - ArbreLexicographique.entree");
	}
	// si appel ArbreLexicographique.ajout
	/*pointcut ajoutArbreLexicoTest(ArbreLexicographique arbre) : target(arbre) && execution(boolean ArbreLexicographique.ajout(String));
	before(ArbreLexicographique arbre) : ajoutArbreLexicoTest(arbre){
		System.out.println("appel modification d'entrée");
	}*/
	// si appel de ArbreLexicographique.ajout ET modification de la variable ArbreLexicographique.entree ALORS on advice
	pointcut ajoutArbreLexico(ArbreLexicographique arbre) : target(arbre) && ajoutArbre(ArbreLexicographique) && withincode(boolean ArbreLexicographique.ajout(String));
	after(ArbreLexicographique arbre) : ajoutArbreLexico(arbre){
		System.out.println("modification ArbreLexicographique");
		DefaultMutableTreeNode nouvelleRacine = new DefaultMutableTreeNode();
		nouvelleRacine = (DefaultMutableTreeNode)arbre.defaultTreeModel.getRoot();
		nouvelleRacine.insert(arbre.entree.defaultMutableTreeNode, 0);
		arbre.defaultTreeModel.reload();
	}
	// si appel de ArbreLexicographique.suppr ET modification de la variable ArbreLexicographique.entree ALORS on advice
	pointcut supprArbre(ArbreLexicographique arbre) : target(arbre) && ajoutArbre(ArbreLexicographique) && withincode(boolean ArbreLexicographique.suppr(String));
	before(ArbreLexicographique arbre) : supprArbre(arbre){
		//arbre.entree.defaultMutableTreeNode.removeAllChildren();
		((DefaultMutableTreeNode)arbre.getRoot()).remove(arbre.entree.defaultMutableTreeNode);
	}
	
	after(ArbreLexicographique arbre) : supprArbre(arbre){
		//arbre.entree.defaultMutableTreeNode.removeAllChildren();
		if(arbre.entree != NoeudVide.getInstance()){
			((DefaultMutableTreeNode)arbre.defaultTreeModel.getRoot()).insert(arbre.entree.defaultMutableTreeNode, 0);
		}
		arbre.defaultTreeModel.reload();
		System.out.println("suppression arbre lexicographique");
	}
	
	// ==== POINTCUT - NoeudAbstrait frere ==== //	
	//test sur la modification du frere
	//pointcut modificationFrere(NoeudAbstrait noeudAbstrait) : this(noeudAbstrait) && set(NoeudAbstrait NoeudAbstrait.frere);
	// si NoeudAbstrait.ajout ET modfication du frere
	pointcut AjoutFrere(NoeudAbstrait noeudAbstrait) : target(noeudAbstrait) && withincode(NoeudAbstrait NoeudAbstrait.ajout(String)) && set(NoeudAbstrait NoeudAbstrait.frere);	
	after(NoeudAbstrait noeudAbstrait) : AjoutFrere(noeudAbstrait){
		if(noeudAbstrait.getParent() != null){
			DefaultMutableTreeNode noeudFrere = noeudAbstrait.frere.defaultMutableTreeNode;
			((DefaultMutableTreeNode)noeudAbstrait.getParent()).insert(noeudFrere, 0);
		}
		System.out.println("Ajout d'un frere");
	}
	
	// si NoeudAbstrait.suppr ET modfication du frere
	pointcut supprFrere(NoeudAbstrait noeudAbstrait) : target(noeudAbstrait) && withincode(NoeudAbstrait NoeudAbstrait.suppr(String)) && set(NoeudAbstrait NoeudAbstrait.frere);	
	before(NoeudAbstrait noeudAbstrait) : supprFrere(noeudAbstrait){
		((DefaultMutableTreeNode)noeudAbstrait.getParent()).remove(noeudAbstrait.frere.defaultMutableTreeNode);
	}
	after(NoeudAbstrait noeudAbstrait) : supprFrere(noeudAbstrait){
		//((DefaultMutableTreeNode)noeudAbstrait.getParent()).remove(noeudAbstrait.frere.defaultMutableTreeNode);
		if(noeudAbstrait.frere != NoeudVide.getInstance()){
			((DefaultMutableTreeNode)noeudAbstrait.getParent()).insert(noeudAbstrait.frere.defaultMutableTreeNode, 0);
		}
		System.out.println("suppression d'un frere");
	}
	
	// ==== POINTCUT - Noeud fils ==== //	
	/*	pointcut testfils(Noeud n, String s) : target (n) && args(s) && call(NoeudAbstrait NoeudAbstrait.ajout(String));	
	after(Noeud n, String s) : testfils(n,s){
		System.out.println("test - val : "+s);
	}*/
	//test si modification du fils
	//pointcut modificationFils(Noeud noeud) : this(noeud) && set(NoeudAbstrait Noeud.fils);
	// si Noeud.ajout ET Modification fils
	pointcut ajoutFils(Noeud noeud) : target(noeud) && withincode(NoeudAbstrait NoeudAbstrait.ajout(String)) && set(NoeudAbstrait Noeud.fils);	
	after(Noeud noeud) : ajoutFils(noeud){
	//	noeud.defaultMutableTreeNode.add();	
		System.out.println("Creation d'un nouveau fils ");
	//	DefaultMutableTreeNode nouveauFils = new DefaultMutableTreeNode(thisJoinPoint.getArgs()[0]);
		noeud.defaultMutableTreeNode.add(noeud.getFils().defaultMutableTreeNode);	
	}
	
	pointcut supprFils(Noeud noeud) : target(noeud) && withincode(NoeudAbstrait Noeud.suppr(String)) && set(NoeudAbstrait Noeud.fils);	
	before(Noeud noeud) : supprFils(noeud){
		if(noeud.getFils().defaultMutableTreeNode.getParent() != null) noeud.defaultMutableTreeNode.remove(noeud.getFils().defaultMutableTreeNode);
	}
	after(Noeud noeud) : supprFils(noeud){
		//if(noeud.getFils().defaultMutableTreeNode.getParent() != null) noeud.defaultMutableTreeNode.remove(noeud.getFils().defaultMutableTreeNode);
		if(noeud.getFils() != NoeudVide.getInstance()) noeud.defaultMutableTreeNode.add(noeud.getFils().defaultMutableTreeNode);
		System.out.println("suppression d'un fils");
	}
	
	// == constucteur Marque == //
	pointcut constructeurMarque(Marque marque, NoeudAbstrait frere) : target (marque) && args(frere) && execution(Marque.new(NoeudAbstrait));
	after(Marque marque, NoeudAbstrait frere) : constructeurMarque(marque, frere){
		marque.defaultMutableTreeNode = new DefaultMutableTreeNode();
		System.out.println("création marque");
	} 
	
	// == constructeur Noeud == //
	pointcut ConstructeurNoeud(Noeud nouveauNoeud, NoeudAbstrait frere, NoeudAbstrait fils, char valeur) : target (nouveauNoeud) && args(frere, fils, valeur) && execution(Noeud.new(NoeudAbstrait , NoeudAbstrait , char));
	after(Noeud nouveauNoeud, NoeudAbstrait frere, NoeudAbstrait fils, char valeur) : ConstructeurNoeud(nouveauNoeud, frere, fils, valeur){
		nouveauNoeud.defaultMutableTreeNode = new DefaultMutableTreeNode(valeur);					// creer un noeud avec valeur
		DefaultMutableTreeNode NoeudFils = fils.defaultMutableTreeNode;								
		nouveauNoeud.defaultMutableTreeNode.add(NoeudFils);											// ajout du fils 
		//DefaultMutableTreeNode NoeudFrere = fils.frere.defaultMutableTreeNode;					// si y'a un frere, on l'ajoute
		System.out.println("création noeud - valeur : "+valeur);
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
