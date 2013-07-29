package org.xtext.example.guidsl.exportPlugin;

import org.eclipse.jface.dialogs.IDialogSettings;
import org.eclipse.jface.viewers.IStructuredSelection;
import org.eclipse.jface.wizard.IWizardContainer;
import org.eclipse.jface.wizard.IWizardPage;
import org.eclipse.jface.wizard.Wizard;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.graphics.RGB;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.ui.IExportWizard;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.internal.WorkbenchPlugin;

public class ExpWizard  extends Wizard implements IExportWizard {

	private ExportPage mMainPage;
	@Override
	public void init(IWorkbench arg0, IStructuredSelection arg1) {
		setWindowTitle(ExportPage.WindowTitle);
        setNeedsProgressMonitor(true);
        
	}

	@Override
	public boolean performFinish() {
		// TODO Auto-generated method stub
		return mMainPage.exportGui();
		
	}
	
    @Override
    public void addPages() {
        mMainPage = new ExportPage();
        addPage(mMainPage);

		
    }

}
