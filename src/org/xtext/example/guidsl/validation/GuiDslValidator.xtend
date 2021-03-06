/*
 * generated by Xtext
 */
package org.xtext.example.guidsl.validation

import org.xtext.example.guidsl.guiDsl.Element
import org.eclipse.xtext.validation.Check
import org.xtext.example.guidsl.guiDsl.GuiDslPackage
import org.xtext.example.guidsl.guiDsl.TabBar
import org.xtext.example.guidsl.guiDsl.LayoutManager
import org.xtext.example.guidsl.guiDsl.Application

/**
 * Custom validation rules. 
 *
 * see http://www.eclipse.org/Xtext/documentation.html#validation
 */
class GuiDslValidator extends AbstractGuiDslValidator {

  public static val INVALID_NAME = 'invalidName'

	@Check
	def checkElementStartsWithCapital(Element element) {
		if (!Character::isLowerCase(element.name.charAt(0))) {
			warning('Name should start with a lowerCase Char', 
				GuiDslPackage$Literals::ELEMENT__NAME,
					INVALID_NAME)
		}
	}

	@Check
	def uniqueName(Element element) {
		
		var superEntity = (element.eContainer)
		while (superEntity.eContainer != null){
			superEntity = (superEntity.eContainer)
		}
		var app = superEntity as Application
		var iterator = app.eAllContents.filter(typeof(Element))
		while (iterator.hasNext)
		{
			var e =iterator.next
			if(e.name.equals(element.name))
			{
				if(e != element)
				{
					error("The names of Elements must be unique",
					GuiDslPackage$Literals::ELEMENT__NAME)
					return;	
				}
			}
		}
	}
	
	@Check
	def appBarInTabbars(TabBar bar) {
		if(bar.appBar != null){
			for(tab : bar.tabs){
				if(tab.page.appBar != null){
				error('No Appbar is allowed in the TabBar AND in the Tabs. Choose one!', 
				GuiDslPackage$Literals::DISPLAYED_PAGE__APP_BAR)
				error('No Appbar is allowed in the TabBar AND in this Tabpage. Delete one AppBar!', 
				tab.page ,  GuiDslPackage$Literals::DISPLAYED_PAGE__APP_BAR)
				}
			}
		}
	}
}
