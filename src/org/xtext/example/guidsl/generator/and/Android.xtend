package org.xtext.example.guidsl.generator.and

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.generator.IGenerator
import org.xtext.example.guidsl.guiDsl.Application
import org.xtext.example.guidsl.guiDsl.Control
import org.xtext.example.guidsl.guiDsl.DisplayedPage
import org.xtext.example.guidsl.guiDsl.Page
import org.xtext.example.guidsl.guiDsl.Tab
import org.xtext.example.guidsl.guiDsl.TabBar
import org.xtext.example.guidsl.guiDsl.Element
import org.xtext.example.guidsl.guiDsl.AppBarEntry
import org.xtext.example.guidsl.guiDsl.APP_BAR_ENTRY_IMPORTANCE

class Android implements IGenerator{

	IFileSystemAccess _access
	String _appName
	String _nameSpace
	new (IFileSystemAccess fsa)
	{
		_access=fsa
	}
	override doGenerate(Resource input, IFileSystemAccess fsa) {
		_access=fsa
		for (o : input.contents.filter(typeof(Application))) {
			o.compile();
		}
	}
	
	def void compile (Application app){
		_appName = app.name
		_nameSpace = app.nameSpace
		//for generating Pages and corresponding Layouts
		for(DisplayedPage p : app.pages)
		{
			//generate Layout
			_access.generateFile("Android/res/layout/" + p.name + ".xml", p.pageContent)
			//generate Activity
			_access.generateFile("Android/src/" +  _nameSpace + "/"  +p.name + "Activity.java",AndroidActivity::codeActivity(p ,_nameSpace) )
			//generate menu for AppBar
			if(p.appBar != null)
			{
				_access.generateFile("Android/res/menu/" + p.name + ".xml", p.pageOptionsMenu)	
			}
			
		}
		
		//Create TabListener for switching Tabs
		if(!app.pages.filter(typeof(TabBar)).nullOrEmpty)
		{
			_access.generateFile("Android/src/" +packagePath + "MyTabsListener.java",AndroidActivity::getTabListenerCode(_nameSpace))
		}
		
		// for generating String ressource file
		var list = app.eAllContents.filter(typeof(Element))
		var settingsList = app.eAllContents.filter(typeof(AppBarEntry))
		
		_access.generateFile("Android/res/values/strings.xml",AndroidStringRessource::getStringRessourceContent(list,settingsList))
	}
	
	def pageOptionsMenu(DisplayedPage page) {
		'''
		<menu xmlns:android="http://schemas.android.com/apk/res/android">
		«FOR entry : page.appBar.entry»
			<item android:id="@+id/«entry.name»"
			android:title="@string/«entry.name»"
			«IF entry.icon.nullOrEmpty»
			android:icon="@drawable/«entry.icon»"
			«ENDIF»
			android:orderInCategory="100"
			«IF entry.importance == APP_BAR_ENTRY_IMPORTANCE::ACTION »
			android:showAsAction="ifRoom"
			«ENDIF» 
			
			/>
		«ENDFOR»
		</menu>
		
		'''
	}
	
	
	//this function generates the Fragments for Tab bars
	def generateFragments(TabBar tabBar) {
		for( Tab tab : tabBar.tabs)
		{
			val fragmentCreator = new AndroidFragment(_nameSpace)
			_access.generateFile("Android/src/" +packagePath + tab.page.name +"Fragment.java",fragmentCreator.getFragmentPage(tab.page))
			_access.generateFile("Android/res/layout/"+tab.name + ".xml",tab.page.getPageContent(true))
			
			//generate appar
			if(tab.page.appBar != null)
			{
				_access.generateFile("Android/res/menu/" + tab.page.name + ".xml", tab.page.pageOptionsMenu)	
			}	
		}		
	}
	
	
	def CharSequence getPageContent(Page page, boolean isFragment){
		val androidElements = new AndroidElements(isFragment)
		return androidElements.getPage(page.layout)
	}
	
	def dispatch getPageContent(Page page) {
		return page.getPageContent(false)		 
	}
	def dispatch  getPageContent(TabBar tabBar) {
		tabBar.generateFragments
	'''<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:id="@+id/«tabBar.name»"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".«tabBar.name»"
    tools:ignore="MergeRootFrame" />'''	
	}
	
	def getPackagePath(){
		_nameSpace.replace('.','/') + '/'
	}
	
}