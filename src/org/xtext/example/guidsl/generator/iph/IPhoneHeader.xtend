package org.xtext.example.guidsl.generator.iph

import org.xtext.example.guidsl.guiDsl.Page
import org.xtext.example.guidsl.guiDsl.LayoutManager
import org.xtext.example.guidsl.guiDsl.Control
import org.xtext.example.guidsl.guiDsl.ActiveControl

class IPhoneHeader {
	
	def getHeaderFiles(Page page){
		'''
		//
		//  «page.name»Controller.h
		
		#import <UIKit/UIKit.h>
		
		@interface «page.name»Controller : UIViewController
		«page.layout.getActions»
		«page.layout.getProperties»
		
		@end
		'''
	}
	
	def dispatch getProperties(LayoutManager manager) {
		'''
		«FOR element : manager.elements»
		«element.getProperties»
		«ENDFOR»
		'''
	}
	
	def dispatch getProperties(Control control){
		'''
		@property (weak, nonatomic) IBOutlet «IPhoneClass::getIphoneClass(control)» *«control.name»;
		'''
		
	}
	
	def dispatch getActions(LayoutManager manager) {
		'''
		«FOR element : manager.elements»
		«element.getActions»
		«ENDFOR»
		'''
	}
	
	def dispatch getActions(Control control) {
		
	} 
	
	def dispatch getActions(ActiveControl control){
		if (control.clickEvent == null)
			return "";
		'''
		- (IBAction)«control.clickEvent.name»:(id)sender;
		'''
	}
	
}