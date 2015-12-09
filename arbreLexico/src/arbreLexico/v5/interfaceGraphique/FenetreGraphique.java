package arbreLexico.v5.interfaceGraphique;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JMenuBar;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JToolBar;
import java.awt.BorderLayout;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JLabel;
import javax.swing.JTextField;
import java.awt.Color;
import javax.swing.JTabbedPane;

public class FenetreGraphique {

	private JFrame frame;
	private JTextField textField;
	private JMenuItem mntmQuiter;
	private ArbreLexicographique arbre;
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					FenetreGraphique window = new FenetreGraphique();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public FenetreGraphique() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 450, 300);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.arbre = new ArbreLexicographique();
		JMenuBar menuBar = new JMenuBar();
		frame.setJMenuBar(menuBar);
		
		JMenu mnFichier = new JMenu("Fichier");
		menuBar.add(mnFichier);
		
		JMenuItem mntmCharger = new JMenuItem("Charger");
		mnFichier.add(mntmCharger);
		
		JMenuItem mntmSauvegarder = new JMenuItem("Sauvegarder");
		mnFichier.add(mntmSauvegarder);
		
		mntmQuiter = new JMenuItem("Quitter");
		mntmQuiter.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				System.exit(0);
			}
		});
		mnFichier.add(mntmQuiter);
		
		JMenu mnAide = new JMenu("Aide");
		menuBar.add(mnAide);
		
		JMenuItem mntmAide = new JMenuItem("Aide");
		mnAide.add(mntmAide);
		
		JToolBar toolBar = new JToolBar();
		frame.getContentPane().add(toolBar, BorderLayout.NORTH);
		
		JLabel lblNewLabel = new JLabel("Barre d'\u00E9tat");
		lblNewLabel.setForeground(Color.RED);
		
		JButton btnNewButton = new JButton("Ajouter");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if(arbre.ajout(textField.getText())){
					lblNewLabel.setText("Ajout du mot: "+textField.getText()+" effectue");
					lblNewLabel.setForeground(Color.BLACK);
				}
				else{
					lblNewLabel.setText("L'ajout n'a pas ete effectue");
					lblNewLabel.setForeground(Color.RED);
				}
			}
		});
		toolBar.add(btnNewButton);
		
		JButton btnSupprimer = new JButton("Supprimer");
		btnSupprimer.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if(arbre.suppr(textField.getText())){
					lblNewLabel.setText("Suppression du mot: "+textField.getText()+" effectue");
					lblNewLabel.setForeground(Color.BLACK);
				}
				else{
					lblNewLabel.setText("La suppression n'a pas ete effectue");
					lblNewLabel.setForeground(Color.RED);
				}
			}
		});
		toolBar.add(btnSupprimer);
		
		JButton btnChercher = new JButton("Chercher");
		btnChercher.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if(arbre.contient(textField.getText())){
					lblNewLabel.setText("Le mot: "+textField.getText()+" est dans l'arbre");
					lblNewLabel.setForeground(Color.BLACK);
				}
				else{
					lblNewLabel.setText("Le mot n'est pas dans l'arbre");
					lblNewLabel.setForeground(Color.RED);
				}
			}
		});
		toolBar.add(btnChercher);
		
		JButton btnPrefixe = new JButton("Prefixe");
		btnPrefixe.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if(arbre.prefixe(textField.getText())){
					lblNewLabel.setText("Le mot: "+textField.getText()+" est un prefixe");
					lblNewLabel.setForeground(Color.BLACK);
				}
				else{
					lblNewLabel.setText("Le mot n'est pas un prefixe");
					lblNewLabel.setForeground(Color.RED);
				}
			}
		});
		toolBar.add(btnPrefixe);
		
		JLabel lblQuoi = new JLabel("Quoi");
		toolBar.add(lblQuoi);
		
		textField = new JTextField();
		toolBar.add(textField);
		textField.setColumns(10);
		
		
		frame.getContentPane().add(lblNewLabel, BorderLayout.SOUTH);
		
		JTabbedPane tabbedPane = new JTabbedPane(JTabbedPane.TOP);
		frame.getContentPane().add(tabbedPane, BorderLayout.CENTER);
		
		JTabbedPane tabbedPane_1 = new JTabbedPane(JTabbedPane.TOP);
		tabbedPane.addTab("Arbre", null, tabbedPane_1, null);
		
		JTabbedPane tabbedPane_2 = new JTabbedPane(JTabbedPane.TOP);
		tabbedPane.addTab("Liste", null, tabbedPane_2, null);
	}

}
