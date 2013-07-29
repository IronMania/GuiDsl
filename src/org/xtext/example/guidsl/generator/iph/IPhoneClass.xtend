package org.xtext.example.guidsl.generator.iph

import org.xtext.example.guidsl.guiDsl.Image
import org.xtext.example.guidsl.guiDsl.Button
import org.xtext.example.guidsl.guiDsl.Element
import org.xtext.example.guidsl.guiDsl.Label
import org.xtext.example.guidsl.guiDsl.InputText
import org.xtext.example.guidsl.guiDsl.Page
import org.xtext.example.guidsl.guiDsl.LayoutManager
import org.xtext.example.guidsl.guiDsl.ActiveControl
import org.xtext.example.guidsl.guiDsl.ChangePage
import org.xtext.example.guidsl.guiDsl.TappedEvent
import org.xtext.example.guidsl.guiDsl.Event

class IPhoneClass {


	def static dispatch getIphoneClass(Image img){
		"UIImage"
	}
	def static dispatch getIphoneClass(Label label){
		"UILabel"
	}
	def static dispatch getIphoneClass(Button img){
		"UIButton"
	}
	def static dispatch getIphoneClass(InputText img){
		"UITextField"
	}	
	def static dispatch getIphoneClass(Element ele){
//		throw new UnsupportedOperationException( "The Class of Elemenent: " + ele.class +" could not be found")
		throw new UnsupportedOperationException( "Some Element is not implemented")
	}
	
	def static getModule(Page page){
		'''
		//
		//  «page.name»Controller.m
		//
		//
		
		#import "«page.name»Controller.h"
		
		@interface «page.name»Controller ()
		
		@end
		
		@implementation «page.name»Controller
		
		
		- (void)viewDidLoad
		{
		    [super viewDidLoad];
		        // Do any additional setup after loading the view.
		}
		- (void)didReceiveMemoryWarning
		{
		    [super didReceiveMemoryWarning];
		    // Dispose of any resources that can be recreated.
		}
		
		«page.layout.getActions»
		@end
		
		'''
	}
	
	def static dispatch getActions(Element element){
	}
	
	def static dispatch getActions(LayoutManager manager) {
		'''
		«FOR element : manager.elements»
		«element.getActions»
		«ENDFOR»
		'''
	}
	
	def static dispatch getActions(ActiveControl control){
		if (control.clickEvent == null)
			return "";
		'''
		- (IBAction)«control.clickEvent.name»:(id)sender {
			«control.clickEvent.getTapped»
		}
		'''
	}
	
	def static dispatch CharSequence getTapped(ChangePage changePageEvent)
	{
		throw new UnsupportedOperationException("TODO: ChangePage needs to be implemented") 
	}
	
	def static dispatch getTapped(TappedEvent event){
		''''''
	}
	
	
	
}
