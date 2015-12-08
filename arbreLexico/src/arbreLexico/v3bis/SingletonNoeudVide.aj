package arbreLexico.v3bis;

public aspect SingletonNoeudVide {

	
	private NoeudVide leNoeudVide = new NoeudVide();
	
	pointcut appelConstructeur(): call(NoeudVide.new()) && (! within(SingletonNoeudVide)) && within(arbreLexoco.*);
	
	NoeudVide around() : appelConstructeur(){
		return leNoeudVide;
	}
	
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
	/*	ArbreLexicographique a = new ArbreLexicographique();
		a.ajout("bla");
		System.out.print("");*/
	
	}
	
	
	

}
