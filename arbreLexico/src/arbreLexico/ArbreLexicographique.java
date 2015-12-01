package arbreLexico;

public class ArbreLexicographique {
	NoeudAbstrait entree;

	public ArbreLexicographique() {
		entree = null;
	}

	public boolean contient(String s) {
		if (entree == null)
			return false;
		return entree.contient(s);
	}

	public boolean prefixe(String s) {
		if (entree == null)
			return false;
		return entree.prefixe(s);
	}

	public int nbMots() {
		if (entree == null)
			return 0;
		return entree.nbMots();
	}

	public boolean ajout(String s) {
		try {
			if (entree == null) {
				entree = new Marque(null);
				if (!s.isEmpty()) {
					entree = entree.ajout(s);
					entree = entree.suppr("");
				}
			} else {
				entree = entree.ajout(s);
			}
		} catch (ModificationImpossibleException e) {
			return false;
		}
		return true;
	}

	public boolean suppr(String s) {
		try {
			if (entree == null) {
				return false;
			} else {
				entree = entree.suppr(s);
			}
		} catch (ModificationImpossibleException e) {
			return false;
		}
		return true;
	}
	
	public String toString() {
		return entree.toString("");
	}
	
	public boolean estVide() {
		return entree == null;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
