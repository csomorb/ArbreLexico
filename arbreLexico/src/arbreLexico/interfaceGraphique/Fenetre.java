package arbreLexico.interfaceGraphique;

import java.awt.BorderLayout;
import java.awt.Dimension;

import javax.swing.JFrame;
import javax.swing.JPanel;

public class Fenetre extends JFrame {

	Menu menu;
	CommandeToolBar commandeToolBar ;
	OngletPanel onglet;
	JPanel panel1;
	JPanel panel2;
	EtatLabel etatLabel;
	
	Fenetre(){
		super();
		this.setTitle("TP arbre lexicographique");
	    this.setSize(400, 500);
	    this.setLocationRelativeTo(null);
	    this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); 
	    menu = new Menu();
	    commandeToolBar  = new CommandeToolBar ();
	    onglet = new OngletPanel();
	    etatLabel = new EtatLabel();
	    panel1 = new JPanel();
	    panel2 = new JPanel();
	    panel1.setLayout(new BorderLayout());
	    panel2.setLayout(new BorderLayout());
	    panel2.add(commandeToolBar,BorderLayout.NORTH);
	    panel2.add(onglet,BorderLayout.CENTER);
	    panel2.add(etatLabel, BorderLayout.SOUTH);
	    panel1.add(menu,BorderLayout.NORTH);
	    panel1.add(panel2, BorderLayout.CENTER);
	    this.setMinimumSize(new Dimension(350,160));
	    this.setContentPane(panel1);
	    this.setVisible(true);
	}
	
}
