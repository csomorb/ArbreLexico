package arbreLexico.v5.interfaceGraphique;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Serializable;

public aspect Serialisation{
	declare parents: ArbreLexicographique implements Serializable;
		
	public void ArbreLexicographique.sauve(String nomFichier){
		File f = new File (nomFichier);
		try
		{
		    FileWriter fw = new FileWriter (f);
		 
		/*    for (double d : data)
		    {
		        fw.write (String.valueOf (d));
		        fw.write ("\r\n");
		    }*/
		    fw.write(this.toString());
		    
		    fw.close();
		}
		catch (IOException exception)
		{
		    System.out.println ("Erreur lors de la lecture : " + exception.getMessage());
		}
	}
	
	public void ArbreLexicographique.charge(String nomFichier){
		try{
		    File f = new File (nomFichier);
		    FileReader fr = new FileReader (f);
		    BufferedReader br = new BufferedReader (fr);
		    this.entree = NoeudVide.getInstance();
		    try{
		        String mot = br.readLine();
		 
		        while (mot != null){
		            this.ajout(mot);
		            mot = br.readLine();
		        }
		        br.close();
		        fr.close();
		    }
		    catch (IOException exception){
		        System.out.println ("Erreur lors de la lecture : " + exception.getMessage());
		    }
		}
		catch (FileNotFoundException exception){
		    System.out.println ("Le fichier \""+nomFichier +"\" n'a pas ete trouve, l'arbre ne change pas");
		}
	}
	
	public static void main(String[] args) {
		ArbreLexicographique a = new ArbreLexicographique();
		a.ajout("se");
		System.out.print(a);
		a.charge("essai.txt");
		System.out.print(a);
		a.charge("essai.tt");
		System.out.print(a.toString());
		a.sauve("essai_out.txt");
		a.charge("essai_out.txt");
		System.out.println("----");
		System.out.print(a);
		System.out.println("----");
	}	
}
