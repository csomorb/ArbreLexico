package arbreLexico.v2;


public class Marque extends NoeudAbstrait {

	public Marque(NoeudAbstrait frere) {
		super(frere);
	}

	public boolean contient(String s) {
		if (s.isEmpty())
			return true;
		return frere != null && frere.contient(s);
	}

	public boolean prefixe(String s) {
		if (s.isEmpty())
			return true;
		return frere != null && frere.prefixe(s);
	}
/**
 * A compléter!!!
 * 
 */
	public int nbMots() {
		return 1;
	}

	public NoeudAbstrait ajout(String s) {
		if (s.isEmpty())
			throw new ModificationImpossibleException("ajout impossible : mot d�j� pr�sent");
		if (frere != null) {
			frere = frere.ajout(s);
			return this;
		}
		// frere == null
		NoeudAbstrait n = new Marque(null);
		for (int i = s.length() - 1; i >= 0; i --)
			n = new Noeud(null, n, s.charAt(i));
		frere = n;
		return this;
	}

	public NoeudAbstrait suppr(String s) {
		if (s.isEmpty())
			return frere;
		if (frere != null) {
			frere = frere.suppr(s);
			return this;
		}
		// frere == null
		return this;
	}

	public String toString(String s) {
		String t;
		if (frere == null)
			t = "";
		else
			t = frere.toString(s);
		return s + "\n" + t;
	}

}
