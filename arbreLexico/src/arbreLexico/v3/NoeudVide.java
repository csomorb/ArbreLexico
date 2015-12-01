package arbreLexico.v3;

public class NoeudVide extends NoeudAbstrait {

	public NoeudVide() {
		super(null);
		frere = null;
	}

	public boolean contient(String s) {
		return false;
	}

	public boolean prefixe(String s) {
		return false;
	}

	public int nbMots() {
		return 0;
	}

	public NoeudAbstrait ajout(String s) {
		//frere == null
		NoeudAbstrait n = new Marque(new NoeudVide());
		for (int i = s.length() - 1; i >= 0; i --)
			n = new Noeud(new NoeudVide(), n, s.charAt(i));
		return n;
	}

	public NoeudAbstrait suppr(String s) {
		throw new ModificationImpossibleException("suppression impossible : mot absent");
	}

	@Override
	public String toString(String s) {
		return "";
	}

}
