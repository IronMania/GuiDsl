package org.xtext.example.guidsl.exportPlugin;

import java.io.File;

import javax.swing.JOptionPane;

import org.eclipse.jface.dialogs.IDialogSettings;
import org.eclipse.jface.wizard.WizardPage;
import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Text;
import org.eclipse.swt.custom.CLabel;
import org.eclipse.swt.widgets.Combo;
import org.eclipse.swt.widgets.DirectoryDialog;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.events.SelectionAdapter;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.ui.internal.WorkbenchPlugin;

public class ExportPage extends WizardPage {

	public static final String WindowTitle = "Android User Interface Export";
	private Text androidFolder;
	private Text iphoneFolder;
	private Text wp7Folder;
	private Button btnAndroid;
	private Button btnIphone;
	private Button btnWindowsPhone;
	private Button androidFolderSelection;
	private Button iphoneFolderSelection;
	private Button wp7FolderSelection;
	
	private String destination;
	private IDialogSettings section;

	/**
	 * Create the wizard.
	 */
	public ExportPage() {
		super("wizardPage");
		setTitle("Export User Interface");
		setDescription("Exports User Interface");
		
        

		@SuppressWarnings("restriction")
		IDialogSettings settings = WorkbenchPlugin.getDefault().getDialogSettings();
		section = settings.getSection("GuiDSLFolder");
		if (section == null) {
			   section = settings.addNewSection("GuiDSLFolder");
//				String lastSelectedFolder = section.get("Android");
//				String lastSelectedFolder2 = section.get("iPhone");
//				String lastSelectedFolder3 = section.get("WP7");
		//
		} 


	}

	/**
	 * Create contents of the wizard.
	 * @param parent
	 */
	public void createControl(Composite parent) {
		Composite container = new Composite(parent, SWT.NULL);

		setControl(container);
		
		SelectionAdapter selector = new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				boolean android =btnAndroid.getSelection();
				boolean iPhone =btnIphone.getSelection();
				boolean wp7 =btnWindowsPhone.getSelection();
				
				androidFolder.setEnabled(android);
				androidFolderSelection.setEnabled(android);
				iphoneFolder.setEnabled(iPhone);
				iphoneFolderSelection.setEnabled(iPhone);
				wp7Folder.setEnabled(wp7);
				wp7FolderSelection.setEnabled(wp7);
				
			}
		};
		
		androidFolder = new Text(container, SWT.BORDER);
		androidFolder.setEnabled(section.getBoolean("AndroidChk"));
		androidFolder.setBounds(142, 31, 378, 21);
		String folder = section.get("Android");
		if(folder!= null){
			androidFolder.setText(folder);	
		}
		
		iphoneFolder = new Text(container, SWT.BORDER);
		iphoneFolder.setEnabled(section.getBoolean("iPhoneChk"));
		iphoneFolder.setBounds(142, 60, 378, 21);
		folder = section.get("iPhone");
		if(folder!= null){
			iphoneFolder.setText(folder);	
		}
		
		wp7Folder = new Text(container, SWT.BORDER);
		wp7Folder.setEnabled(section.getBoolean("WP7Chk"));
		wp7Folder.setBounds(142, 91, 378, 21);
		folder = section.get("WP7");
		if(folder!= null){
			wp7Folder.setText(folder);	
		}
		
		Label lblSelectDestinationFolder = new Label(container, SWT.NONE);
		lblSelectDestinationFolder.setBounds(10, 10, 217, 15);
		lblSelectDestinationFolder.setText("Select destination folder");
		
		androidFolderSelection = new Button(container, SWT.NONE);
		androidFolderSelection.setEnabled(section.getBoolean("AndroidChk"));
		androidFolderSelection.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				DirectoryDialog dirDialog = new DirectoryDialog(getShell());
			    dirDialog.setText("Select your home directory");
			    destination = dirDialog.open();
			    androidFolder.setText(destination);
			    System.out.println(destination);
			}
		});
		androidFolderSelection.setBounds(526, 29, 38, 25);
		androidFolderSelection.setText("...");
		
		iphoneFolderSelection = new Button(container, SWT.NONE);
		iphoneFolderSelection.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				DirectoryDialog dirDialog = new DirectoryDialog(getShell());
			    dirDialog.setText("Select your home directory");
			    destination = dirDialog.open();
			    iphoneFolder.setText(destination);
			    System.out.println(destination);
			}
		});
		iphoneFolderSelection.setEnabled(section.getBoolean("iPhoneChk"));
		iphoneFolderSelection.setText("...");
		iphoneFolderSelection.setBounds(526, 58, 38, 25);
		
		wp7FolderSelection = new Button(container, SWT.NONE);
		wp7FolderSelection.addSelectionListener(new SelectionAdapter() {
			@Override
			public void widgetSelected(SelectionEvent e) {
				DirectoryDialog dirDialog = new DirectoryDialog(getShell());
			    dirDialog.setText("Select your home directory");
			    destination = dirDialog.open();
			    wp7Folder.setText(destination);
			    System.out.println(destination);
			}
		});
		wp7FolderSelection.setEnabled(section.getBoolean("WP7Chk"));
		wp7FolderSelection.setText("...");
		wp7FolderSelection.setBounds(526, 89, 38, 25);
		
		btnAndroid = new Button(container, SWT.CHECK);
		btnAndroid.addSelectionListener(selector);
		btnAndroid.setBounds(10, 33, 93, 16);
		btnAndroid.setText("Android");
		btnAndroid.setSelection(section.getBoolean("AndroidChk"));
		
		
		
		btnIphone = new Button(container, SWT.CHECK);
		btnIphone.addSelectionListener(selector);
		btnIphone.setText("iPhone");
		btnIphone.setBounds(10, 62, 126, 16);
		btnIphone.setSelection(section.getBoolean("iPhoneChk"));
		
		btnWindowsPhone = new Button(container, SWT.CHECK);
		btnWindowsPhone.addSelectionListener(selector);
		btnWindowsPhone.setText("Windows Phone 7");
		btnWindowsPhone.setBounds(10, 93, 126, 16);
		btnWindowsPhone.setSelection(section.getBoolean("WP7Chk"));
		


//		String lastSelectedFolder = section.get("Android");
//		String lastSelectedFolder2 = section.get("iPhone");
//		String lastSelectedFolder3 = section.get("WP7");
//
//		
	}

	public boolean exportGui() {
		boolean returnvalue = true;
		if (btnAndroid.getSelection()){
			File theDir = new File(androidFolder.getText());
			if(!theDir.exists()){
				returnvalue = false;
			}else{
				section.put("Android", androidFolder.getText());
			}
		}
		if (btnIphone.getSelection()){
			File theDir = new File(iphoneFolder.getText());
			if(!theDir.exists()){
				returnvalue = false;
			}else{
				section.put("iPhone", iphoneFolder.getText());
			}
		}
		if (btnWindowsPhone.getSelection()){
			File theDir = new File(wp7Folder.getText());
			if(!theDir.exists()){
				returnvalue = false;
			}else{
				section.put("WP7", wp7Folder.getText());
			}
		}
		section.put("AndroidChk",btnAndroid.getSelection());
		section.put("iPhoneChk",btnIphone.getSelection());
		section.put("WP7Chk",btnWindowsPhone.getSelection());
		
		
		
		return returnvalue;
	}
}
