package arbreLexico.interfaceGraphique;

import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.JTree;

public class OngletPanel extends JTabbedPane{

	JScrollPane scrollPan1;
	JScrollPane scrollPan2;
	JTree arbre; //il faudra probablement créer une nouvelle classe
	JTextArea liste;
	
	OngletPanel(){
		super();
		scrollPan1 = new JScrollPane();
		scrollPan2 = new JScrollPane();
		arbre = new JTree();
		liste = new JTextArea();
		
		scrollPan1.add(arbre);
		scrollPan2.add(liste);
		
		this.add(scrollPan1,"Arbre");
		this.add(scrollPan2,"Liste");
	}
	
	
}
