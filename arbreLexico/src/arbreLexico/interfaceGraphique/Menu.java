package arbreLexico.interfaceGraphique;

import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;

public class Menu extends JMenuBar{
	JMenu menuFichier;
    JMenu menuAide;
	JMenuItem menuItemCharger;
	JMenuItem menuItemSauvegarder;
	
	Menu(){
		super();
	    menuFichier = new JMenu("Fichier");
	    menuAide = new JMenu("Aide");
	    menuItemCharger = new JMenuItem("Charger");
	    menuItemSauvegarder = new JMenuItem("Sauvegarder");
	    menuFichier.add(menuItemCharger);
	    menuFichier.add(menuItemSauvegarder);
	    this.add(menuFichier);
	    this.add(menuAide);
	}
}
