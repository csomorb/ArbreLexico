package arbreLexico;
public privileged aspect AireClonable {
	declare parents: ArbreLexicographique implements Cloneable;
	

	public abstract Object NoeudAbstrait.clone();

	public Object Noeud.Clone(){
		return new Noeud((NoeudAbstrait)frere.clone(),(NoeudAbstrait)fils.clone(),valeur);
	}
	
/*	public NoeudAbstrait NoeudVide.clone(){
		return this;
	}*/
	
	public Object  Marque.clone(){
		return new Marque((NoeudAbstrait)frere.clone());
	}
	
	public Object  ArbreLexicographique.clone(){
		ArbreLexicographique a = new ArbreLexicographique();
		a.entree = (NoeudAbstrait)entree.clone();
		return a;
	}

	public static void main(String args[]){
		ArbreLexicographique a1 = new ArbreLexicographique();
		a1.ajout("bldz");
		ArbreLexicographique a2 = (ArbreLexicographique)a1.clone();
		System.out.println(a1);
	}

}
