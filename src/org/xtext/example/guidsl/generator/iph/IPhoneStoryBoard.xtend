package org.xtext.example.guidsl.generator.iph

import org.xtext.example.guidsl.guiDsl.Application
import org.xtext.example.guidsl.guiDsl.DisplayedPage
import org.eclipse.emf.common.util.EList
import org.xtext.example.guidsl.guiDsl.Page
import org.xtext.example.guidsl.guiDsl.TabBar
import org.xtext.example.guidsl.guiDsl.AppBar
import org.xtext.example.guidsl.guiDsl.LayoutManager
import org.xtext.example.guidsl.guiDsl.Element

class IPhoneStoryBoard {
 	
 	int idCounter;
 	DisplayedPage startPage;
 	
 	new (){
 		//number 0 is the start Page
 		idCounter = 1;
 	}
 	
	def getStoryboar(Application app){
		startPage = app.startPage
		'''
	<?xml version="1.0" encoding="UTF-8" standalone="no"?>
	<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="2.0" toolsVersion="3084" systemVersion="12C60" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" initialViewController="0">
		<dependencies>
			<plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="2083"/>
		</dependencies>
		<scenes>
		«FOR e: app.pages»
		«e.getScenes»
		«ENDFOR»
		</scenes>
		<resources>
		
		</resources>
		<classes>
		«FOR page : app.pages»
			«page.getClassObject»
		«ENDFOR»
		</classes>
		<simulatedMetricsContainer key="defaultSimulatedMetrics">
			<simulatedStatusBarMetrics key="statusBar"/>
			<simulatedOrientationMetrics key="orientation"/>
			<simulatedScreenMetrics key="destination" type="retina4"/>
		</simulatedMetricsContainer>
	</document>	
		'''
	}
	
	def dispatch  getClassObject(DisplayedPage page) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def dispatch CharSequence getClassObject(Page page) {
		'''
		<class className="«page.name»Controller" superclassName="UIViewController">
			<soruce key="sourceIdentifier" type="project" relativePath="./Classes/«page.name»Controller.h"/>
			<relationships>
				«page.appBar.findRelationShipsBar»
				«page.layout.findRelationShipsLayout»
			</relationships>
		</class>
		'''
	}
	
	def findRelationShipsBar(AppBar bar) {
		if (bar == null)
			return "";
		'''
		«FOR entry : bar.entry»
		«IF entry != null && entry.clickEvent != null»
		<relationship kind="action" name="«entry.clickEvent.name»:"/>
		«ENDIF»
		«ENDFOR»
		'''
	}
	
	def dispatch CharSequence findRelationShipsLayout(LayoutManager layout) {
		'''
		«FOR e: layout.elements»
		«e.findRelationShipsLayout»
		«ENDFOR»
		'''
	}
	
	def dispatch CharSequence findRelationShipsLayout(Element ele) {
	'''
	<relationship kind="outlet" name="«ele.name»" candidateClass="«IPhoneClass::getIphoneClass(ele)»"/>
	'''
	}
	
	def dispatch getClassObject(TabBar bar) {
		'''
		«FOR e : bar.tabs»
		«getClassObject(e.page)»
		«ENDFOR»
		'''
	}
	
	def getScenes(DisplayedPage page) {
		'''
		<!--«page.name»-->
		<scene sceneID="«IF page==startPage»0«ELSE»«idCounter»«idCounter=idCounter+1»«ENDIF»">
			<objects>
			
			</objects>
			<point key="canvasLocation" x="0" y="0"/>
		</scene>
		'''
	}
	
}