package org.xtext.example.guidsl.generator.winph

import org.xtext.example.guidsl.guiDsl.DisplayedPage
import org.xtext.example.guidsl.guiDsl.Page
import org.xtext.example.guidsl.guiDsl.TabBar
import org.xtext.example.guidsl.guiDsl.Event
import org.xtext.example.guidsl.guiDsl.LayoutManager
import org.xtext.example.guidsl.guiDsl.ActiveControl
import org.xtext.example.guidsl.guiDsl.WP7_TAB_TYPE
import org.xtext.example.guidsl.guiDsl.Element

//this class ist for generating SourceCode
class WP7Code {
	
	String _nameSpace
	String _appName
	new (String nameSpace, String appName){
		_nameSpace = nameSpace
		_appName = appName
	}
	
	def code(DisplayedPage page) {
		page.code(false)
	}
	
	def code(DisplayedPage page, boolean isUserControl) {
		'''
	using System;
		using System.Collections.Generic;
		using System.Linq;
		using System.Net;
		using Microsoft.Phone.Controls;
		using Microsoft.Phone.Tasks;
		 
		namespace «_nameSpace»
		{
			public partial class «page.name» : «isUserControl.getControlType» 
			{
				public «page.name»()
				{
					InitializeComponent();
				}
				«page.addEventListener1»
				
			}
		}		
		'''
	}
	
	def getControlType(boolean b) {
		if (b)
			'''UserControl'''
		else 
			'''PhoneApplicationPage'''
	}
	
	def dispatch addEventListener1(DisplayedPage page) {
	}
	
	def dispatch addEventListener1(Page page) {
		page.layout.addEventListener
	}
	
	def dispatch addEventListener(LayoutManager manager) {
		'''
		«FOR element : manager.elements»
		«element.addEventListener»
		«ENDFOR»
		'''
	}
	
	def dispatch addEventListener(Element manager) {
	}
	
	def dispatch CharSequence addEventListener(ActiveControl control) {
		if (control != null && control.clickEvent != null)
			WP7Events::codeClicked(control.clickEvent)
	}
	
}

