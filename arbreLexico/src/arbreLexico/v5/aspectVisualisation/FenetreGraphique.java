package arbreLexico.v5.aspectVisualisation;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JMenuBar;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JToolBar;
import java.awt.BorderLayout;
import javax.swing.JButton;
import javax.swing.JFileChooser;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JLabel;
import javax.swing.JTextField;
import java.awt.Color;
import javax.swing.JTabbedPane;
import javax.swing.JScrollPane;
import javax.swing.JTextPane;
import javax.swing.JTree;
import javax.swing.tree.DefaultTreeModel;
import javax.swing.tree.TreeNode;
import javax.swing.tree.DefaultMutableTreeNode;

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
		
		JLabel lblNewLabel = new JLabel("Barre d'\u00E9tat");
		lblNewLabel.setForeground(Color.RED);
		
		JMenuItem mntmCharger = new JMenuItem("Charger");
		mntmCharger.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				JFileChooser choix = new JFileChooser();
				choix.setFileSelectionMode(JFileChooser.FILES_ONLY);
				choix.setMultiSelectionEnabled(false);
				int retour=choix.showOpenDialog(null);
				if(retour==JFileChooser.APPROVE_OPTION){
				   // un fichier a �t� choisi (sortie par OK)
				   arbre.charge(choix.getSelectedFile().getAbsolutePath());
				   lblNewLabel.setText("Arbre charge dpuis le fichier: "+choix.getSelectedFile().getName());
				   lblNewLabel.setForeground(Color.BLACK);
				}else{ // pas de fichier choisi
					lblNewLabel.setText("Pas de fichier choisi");
					lblNewLabel.setForeground(Color.RED);
				}
			}
		});
		mnFichier.add(mntmCharger);
		
		JMenuItem mntmSauvegarder = new JMenuItem("Sauvegarder");
		mntmSauvegarder.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				JFileChooser choix = new JFileChooser();
				choix.setFileSelectionMode(JFileChooser.FILES_ONLY);
				choix.setMultiSelectionEnabled(false);
				int retour=choix.showSaveDialog(null);
				if(retour==JFileChooser.APPROVE_OPTION){
				   // un fichier a �t� choisi (sortie par OK)
				   arbre.sauve(choix.getSelectedFile().getAbsolutePath());
				   lblNewLabel.setText("Arbre sauvegarde dans le fichier: "+choix.getSelectedFile().getName());
				   lblNewLabel.setForeground(Color.BLACK);
				}else{ // pas de fichier choisi
					lblNewLabel.setText("Pas de fichier choisi pour la sauvegarde");
					lblNewLabel.setForeground(Color.RED);
				}
			}
		});
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
		
		JScrollPane scrollPane = new JScrollPane();
		tabbedPane.addTab("Arbre", null, scrollPane, null);
	 	

		DefaultMutableTreeNode racine1 = new DefaultMutableTreeNode("/") ;
		JTree tree = new JTree(racine1,false);
		
		arbre.setVue(tree);
		/*
		tree.setModel(new DefaultTreeModel(
			new DefaultMutableTreeNode("Arbre") {
				{
					DefaultMutableTreeNode node_1;
					DefaulSZtMutableTreeNode node_2;
					node_1 = new DefaultMutableTreeNode("un noeud");
						node_1.add(new DefaultMutableTreeNode("vide"));
						node_1.add(new DefaultMutableTreeNode("vide"));
					add(node_1);
					node_1 = new DefaultMutableTreeNode("un autre noeud");
						node_2 = new DefaultMutableTreeNode("un autre noeud");
							node_2.add(new DefaultMutableTreeNode("vide"));
						node_1.add(node_2);
						node_1.add(new DefaultMutableTreeNode("a"));
						node_1.add(new DefaultMutableTreeNode("c"));
						node_1.add(new DefaultMutableTreeNode("d"));
					add(node_1);
				}
			}
		));*/
		scrollPane.setViewportView(tree);
		
		JScrollPane scrollPane_1 = new JScrollPane();
		tabbedPane.addTab("Liste", null, scrollPane_1, null);
		
		JTextPane txtpnHjkbhjhj = new JTextPane();
		txtpnHjkbhjhj.setText("Liste des mots de l'arbre");
		scrollPane_1.setViewportView(txtpnHjkbhjhj);
	}

}
