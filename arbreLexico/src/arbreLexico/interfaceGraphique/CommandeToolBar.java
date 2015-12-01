package arbreLexico.interfaceGraphique;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.JToolBar;

public class CommandeToolBar extends JToolBar{
	
	JButton bAjouter;
	JButton bSupprimer;
	JButton bChercher;
	JButton bPrefixe;
	JLabel lQuoi;
	JTextField tfQuoi;
	
	CommandeToolBar(){
		super();
		this.setOrientation(JToolBar.HORIZONTAL);
	//	this.setFloatable(false);
		this.bAjouter = new JButton("Ajouter");
		this.bSupprimer = new JButton("Supprimer");
		this.bChercher = new JButton("Chercher");
		this.bPrefixe = new JButton("Prefixe");
		this.lQuoi = new JLabel("Quoi?");
		this.tfQuoi = new JTextField();
		this.tfQuoi.setColumns(8);
		this.add(bAjouter);
		this.add(bSupprimer);
		this.add(bChercher);
		this.add(bPrefixe);
		this.add(lQuoi);
		this.add(tfQuoi);
	}
}
