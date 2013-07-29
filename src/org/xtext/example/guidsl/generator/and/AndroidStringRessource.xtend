package org.xtext.example.guidsl.generator.and

import java.util.Iterator
import org.xtext.example.guidsl.guiDsl.Image
import org.xtext.example.guidsl.guiDsl.InputText
import org.xtext.example.guidsl.guiDsl.Label
import org.xtext.example.guidsl.guiDsl.Button
import org.xtext.example.guidsl.guiDsl.Control
import org.xtext.example.guidsl.guiDsl.Element
import org.xtext.example.guidsl.guiDsl.AppBarEntry

class AndroidStringRessource {
	static def CharSequence getStringRessourceContent(Iterator<Element> list,Iterator<AppBarEntry> settings)
	{
		
		var controlList = list.toList
		var settingsList = settings.toList
		'''		
		
		<?xml version="1.0" encoding="utf-8"?>
		<resources>
		«FOR control : controlList»
		«control.getStringRessource»
		«ENDFOR»
		«FOR entry : settingsList»
		<string name="«entry.name»">«entry.text»</string>
		«ENDFOR»
		</resources>
		'''
		
	}
	
	static def dispatch CharSequence getStringRessource(Element controls) {
		''''''
	}
	
	static def dispatch CharSequence getStringRessource(Button button) {
	 '''
	 <string name="«button.name»">«button.text»</string>
	 '''	
	}
	
	static def dispatch CharSequence getStringRessource(InputText inputText) {
	'''
	 <string name="«inputText.name»">«inputText.text»</string>
	 '''		
	}
	static def dispatch CharSequence getStringRessource(Label label) {
		'''
	 <string name="«label.name»">«label.text»</string>
	 '''	
	}
	static def dispatch CharSequence getStringRessource(Image image) {
		'''
	 <string name="«image.name»">«image.description»</string>
	 '''	
	}
}