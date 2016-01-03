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

	TreePath parentPath;
	
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
		// On créer une racine, avec un noeud.
		DefaultMutableTreeNode racine = new DefaultMutableTreeNode("");						
		arbre.defaultTreeModel = new DefaultTreeModel(racine);
		//System.out.println("creation arbreLexico");
	}
	// si modification de la variable ArbreLexicographique.entree, on capture sans rien faire
	pointcut ajoutArbre(ArbreLexicographique arbre) : this(arbre) && set(NoeudAbstrait ArbreLexicographique.entree);
	after(ArbreLexicographique arbre) : ajoutArbre(arbre){
		//System.out.println("modification - ArbreLexicographique.entree");
	}
	// si appel de ArbreLexicographique.ajout ET modification de la variable ArbreLexicographique.entree ALORS on advice
	pointcut ajoutArbreLexico(ArbreLexicographique arbre) : target(arbre) && ajoutArbre(ArbreLexicographique) && withincode(boolean ArbreLexicographique.ajout(String));
	after(ArbreLexicographique arbre) : ajoutArbreLexico(arbre){
		//System.out.println("modification ArbreLexicographique");
		// On créer une nouvelle racine en passsant par un TreeModel et on recharge
		DefaultMutableTreeNode nouvelleRacine = new DefaultMutableTreeNode();
		nouvelleRacine = (DefaultMutableTreeNode)arbre.defaultTreeModel.getRoot();
		nouvelleRacine.insert(arbre.entree.defaultMutableTreeNode, 0);
		arbre.defaultTreeModel.reload();
		derouleArbre(arbre.vue, (DefaultMutableTreeNode)arbre.entree.defaultMutableTreeNode.getRoot(), 0);
	}
	// si appel de ArbreLexicographique.suppr ET modification de la variable ArbreLexicographique.entree ALORS on advice
	pointcut supprArbre(ArbreLexicographique arbre) : target(arbre) && ajoutArbre(ArbreLexicographique) && withincode(boolean ArbreLexicographique.suppr(String));
	before(ArbreLexicographique arbre) : supprArbre(arbre){
		//on enleve le noeud racine
		((DefaultMutableTreeNode)arbre.getRoot()).remove(arbre.entree.defaultMutableTreeNode);
	}
	
	after(ArbreLexicographique arbre) : supprArbre(arbre){
		//on insert arbre.entree comme noeud racine d'arbre
		if(arbre.entree != NoeudVide.getInstance()){
			((DefaultMutableTreeNode)arbre.defaultTreeModel.getRoot()).insert(arbre.entree.defaultMutableTreeNode, 0);
		}
		arbre.defaultTreeModel.reload();
		if(arbre.entree != NoeudVide.getInstance())
			derouleArbre(arbre.vue, (DefaultMutableTreeNode)arbre.entree.defaultMutableTreeNode.getRoot(), 0);
		//System.out.println("suppression arbre lexicographique");
	}
	
	// ==== POINTCUT - NoeudAbstrait frere ==== //	
	// si NoeudAbstrait.ajout ET modfication du frere
	pointcut AjoutFrere(NoeudAbstrait noeudAbstrait) : target(noeudAbstrait) && withincode(NoeudAbstrait NoeudAbstrait.ajout(String)) && set(NoeudAbstrait NoeudAbstrait.frere);	
	after(NoeudAbstrait noeudAbstrait) : AjoutFrere(noeudAbstrait){
		if(noeudAbstrait.getParent() != null){
			DefaultMutableTreeNode noeudFrere = noeudAbstrait.frere.defaultMutableTreeNode;
			((DefaultMutableTreeNode)noeudAbstrait.getParent()).insert(noeudFrere, 0);
		}
	}
	// si NoeudAbstrait.suppr ET modfication du frere
	pointcut supprFrere(NoeudAbstrait noeudAbstrait) : target(noeudAbstrait) && withincode(NoeudAbstrait NoeudAbstrait.suppr(String)) && set(NoeudAbstrait NoeudAbstrait.frere);	
	// on récupere le parent de target, puis on lui supprime le fils qui est le frere de target
	before(NoeudAbstrait noeudAbstrait) : supprFrere(noeudAbstrait){
		((DefaultMutableTreeNode)noeudAbstrait.getParent()).remove(noeudAbstrait.frere.defaultMutableTreeNode);
	}
	// si NoeudAbstrait a toujours un frere, on l'insert comme fils du parent de noeudAbstrait ...
	after(NoeudAbstrait noeudAbstrait) : supprFrere(noeudAbstrait){
		if(noeudAbstrait.frere != NoeudVide.getInstance()){
			((DefaultMutableTreeNode)noeudAbstrait.getParent()).insert(noeudAbstrait.frere.defaultMutableTreeNode, 0);
		}
	}
	
	// ==== POINTCUT - Noeud fils ==== //
	
	// Noeud.GetFils();
	// Nous n'avons pas réussit a récupérer le Noeud.Fils ou l'arguments (String) passé lors de ça création : "advice defined in arbreLexico has not been applied [advice did not match]"
	// Pour continuer le projet, nous avons donc choisi d'utiliser un getter pour pouvoir acceder au fils (noeud.getFils())
	
	// si Noeud.ajout ET Modification fils
	pointcut ajoutFils(Noeud noeud) : target(noeud) && withincode(NoeudAbstrait NoeudAbstrait.ajout(String)) && set(NoeudAbstrait Noeud.fils);	
	after(Noeud noeud) : ajoutFils(noeud){
		//System.out.println("Creation d'un nouveau fils ");
		noeud.defaultMutableTreeNode.add(noeud.getFils().defaultMutableTreeNode);	
	}
	// si Noeud.suppr ET Modification fils
	pointcut supprFils(Noeud noeud) : target(noeud) && withincode(NoeudAbstrait Noeud.suppr(String)) && set(NoeudAbstrait Noeud.fils);	
	before(Noeud noeud) : supprFils(noeud){
		if(noeud.getFils().defaultMutableTreeNode.getParent() != null) noeud.defaultMutableTreeNode.remove(noeud.getFils().defaultMutableTreeNode);
	}
	after(Noeud noeud) : supprFils(noeud){
		if(noeud.getFils() != NoeudVide.getInstance()) noeud.defaultMutableTreeNode.add(noeud.getFils().defaultMutableTreeNode);
		//System.out.println("suppression d'un fils");
	}
	
	// == constucteur Marque == //
	pointcut constructeurMarque(Marque marque, NoeudAbstrait frere) : target (marque) && args(frere) && execution(Marque.new(NoeudAbstrait));
	after(Marque marque, NoeudAbstrait frere) : constructeurMarque(marque, frere){
		marque.defaultMutableTreeNode = new DefaultMutableTreeNode();
		//System.out.println("création marque");
	} 
	
	// == constructeur Noeud == //
	pointcut ConstructeurNoeud(Noeud nouveauNoeud, NoeudAbstrait frere, NoeudAbstrait fils, char valeur) : target (nouveauNoeud) && args(frere, fils, valeur) && execution(Noeud.new(NoeudAbstrait , NoeudAbstrait , char));
	after(Noeud nouveauNoeud, NoeudAbstrait frere, NoeudAbstrait fils, char valeur) : ConstructeurNoeud(nouveauNoeud, frere, fils, valeur){
		nouveauNoeud.defaultMutableTreeNode = new DefaultMutableTreeNode(valeur);					// creer un noeud avec valeur
		DefaultMutableTreeNode NoeudFils = fils.defaultMutableTreeNode;								
		nouveauNoeud.defaultMutableTreeNode.add(NoeudFils);											// ajout du fils 
		//System.out.println("création noeud - valeur : "+valeur);
	}
	// ouvre l'arbre
	pointcut OuvreArbre(ArbreLexicographique arbre) : args(arbre) && call(void FenetreGraphique.test(ArbreLexicographique));
	after(ArbreLexicographique arbre) : OuvreArbre(arbre){
		if(arbre.entree != NoeudVide.getInstance())
			derouleArbre(arbre.vue, (DefaultMutableTreeNode)arbre.entree.defaultMutableTreeNode.getRoot(), 0);
	}
	
	pointcut arbreContient(ArbreLexicographique arbre) : target (arbre) && execution(boolean ArbreLexicographique.contient(String));
	after(ArbreLexicographique arbre) returning(boolean result) : arbreContient(arbre){
		if(result){
			fermeArbre(arbre.vue, (DefaultMutableTreeNode)arbre.entree.defaultMutableTreeNode.getRoot(),0);
			arbre.vue.collapsePath(parentPath);
			//System.out.println("result2");
		}
	}
	pointcut noeudContient(NoeudAbstrait noeud) : target (noeud) && execution(boolean NoeudAbstrait.contient(String));
	after(NoeudAbstrait noeud):noeudContient(noeud){
	}
	
	pointcut marqueContient(NoeudAbstrait noeud) : target (noeud) && execution(boolean Marque.contient(String));
	after(NoeudAbstrait noeud)returning(boolean result):marqueContient(noeud){
		if(result){
			parentPath = new TreePath(noeud.defaultMutableTreeNode.getPath());
			//System.out.println("result");
		}
	}
	
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
	// retourne le nombre total de noeud
	public int countNode(DefaultMutableTreeNode node, int nbr){
		if(!(node.isLeaf())){
			nbr++;
			for(int i=0; i<node.getChildCount(); i++){
				nbr = nbr + countNode((DefaultMutableTreeNode)node.getChildAt(i), nbr);
			}
		}
		return nbr;
	}
	// deroule l'arbre passé en Paramètre
	public void derouleArbre(JTree tree, DefaultMutableTreeNode node, int posNoeud){
		int nombreNoeud = countNode(node, 0);
		for(int i =0; i<=nombreNoeud; i++){
			tree.expandRow(i);
		}
	}
	// deroule l'arbre passé en Paramètre
	public void fermeArbre(JTree tree, DefaultMutableTreeNode node, int posNoeud){
		int nombreNoeud = countNode(node, 0);
		for(int i =nombreNoeud; i>=0; i--){
			tree.collapseRow(i);
		}
	}
	
}
