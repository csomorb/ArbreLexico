package arbreLexico.v3;

public class ArbreLexicographique {
	NoeudAbstrait entree;

	public ArbreLexicographique() {
		entree = new NoeudVide();
	}

	public boolean contient(String s) {
		return entree.contient(s);
	}

	public boolean prefixe(String s) {
		return entree.prefixe(s);
	}

	public int nbMots() {
		return entree.nbMots();
	}

	public boolean ajout(String s) {
		try {
		
				if (!s.isEmpty()) {
					entree = entree.ajout(s);
				}
			else {
				entree = entree.ajout(s);
			}
		} catch (ModificationImpossibleException e) {
			return false;
		}
		return true;
	}

	public boolean suppr(String s) {
		try {
		 entree = entree.suppr(s);
		} catch (ModificationImpossibleException e) {
			return false;
		}
		return true;
	}
	
	public String toString() {
		return entree.toString("");
	}
	
	public boolean estVide() {
		return this.entree instanceof NoeudVide;
	}

	public static void main(String[] args) {
		ArbreLexicographique a =  new ArbreLexicographique();
		System.out.println(a.ajout("Que"));
		System.out.println(a.ajout("Quo"));
		System.out.println(a);
		System.out.println(a.nbMots());
	}

}
