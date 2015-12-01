package arbreLexico.interfaceGraphique;

import java.awt.Color;

import javax.swing.JLabel;

public class EtatLabel extends JLabel{
	
	EtatLabel(){
		super();
		this.setText("Barre d'etat");
		this.setForeground(Color.red);
	}
	
}
