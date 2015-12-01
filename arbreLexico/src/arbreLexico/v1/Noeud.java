package arbreLexico.v1;

public class Noeud extends NoeudAbstrait {

	private char valeur;
	private NoeudAbstrait fils;

	public Noeud(NoeudAbstrait frere, NoeudAbstrait fils, char valeur) {
		super(frere);
		if (fils == null)
			throw new ArbreLexicographiqueException();
		this.fils = fils;
		this.valeur = valeur;
	}

	public boolean contient(String s) {
		if (s.isEmpty())
			return false;
		char c = s.charAt(0);
		if (c == valeur)
			return fils.contient(s.substring(1));
		if (c < valeur)
			return false;
		return frere != null && frere.contient(s);
	}

	public boolean prefixe(String s) {
		if (s.isEmpty())
			return true;
		char c = s.charAt(0);
		if (c == valeur)
			return fils.prefixe(s.substring(1));
		if (c < valeur)
			return false;
		return frere != null && frere.prefixe(s);
	}

	public int nbMots() {
		return fils.nbMots() + (frere == null ? 0 : frere.nbMots());
	}

	public NoeudAbstrait ajout(String s) {
		if (s.isEmpty())
			return new Marque(this);
		char c = s.charAt(0);
		if (c == valeur) {
			fils = fils.ajout(s.substring(1));
			return this;
		}
		if (c < valeur) {
			NoeudAbstrait n = new Marque(null);
			for (int i = s.length() - 1; i >= 0; i --)
				n = new Noeud(null, n, s.charAt(i));
			n.frere = this;
			return n;
		}
		if (frere != null) {
			frere = frere.ajout(s);
			return this;
		}
		//frere == null
		NoeudAbstrait n = new Marque(null);
		for (int i = s.length() - 1; i >= 0; i --)
			n = new Noeud(null, n, s.charAt(i));
		frere = n;
		return this;
	}

	public NoeudAbstrait suppr(String s) {
		if (s.isEmpty())
			return this;
		char c = s.charAt(0);
		if (c == valeur) {
			fils = fils.suppr(s.substring(1));
			if (fils == null)
				return frere;
			return this;
		}
		if (c < valeur) {
			return this;
		}
		if (frere != null) {
			frere = frere.suppr(s);
			return this;
		}
		//frere == null
		return this;
	}

	public String toString(String prefixe) {
		String t;
		if (frere == null)
			t = "";
		else
			t = frere.toString(prefixe);
		return fils.toString(prefixe + valeur) + t;

	}

}
