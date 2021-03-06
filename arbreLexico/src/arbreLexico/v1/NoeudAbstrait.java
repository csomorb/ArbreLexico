package arbreLexico.v1;

public abstract class NoeudAbstrait {
	protected NoeudAbstrait frere;

	public NoeudAbstrait(NoeudAbstrait frere) {
		this.frere = frere;
	}

	public abstract boolean contient(String s);

	public abstract boolean prefixe(String s);

	public abstract int nbMots(); // nombre d'�l�ments

	public abstract NoeudAbstrait ajout(String s);

	public abstract NoeudAbstrait suppr(String s);

	public abstract String toString(String s); // �l�ments s�par�s par \n

	public static void main(String[] args) {
		NoeudAbstrait n = new Marque(null);
		n.ajout("FOR");
		n.ajout("FOX");
		n.ajout("FOG");
		n.ajout("AXE");
		n.ajout("FOG");
		n.suppr("");
		System.out.println(n.toString(""));

	}

}
