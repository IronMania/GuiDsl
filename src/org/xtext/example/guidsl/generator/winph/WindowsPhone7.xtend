package org.xtext.example.guidsl.generator.winph

import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.generator.IGenerator
import org.xtext.example.guidsl.guiDsl.Application
import org.xtext.example.guidsl.guiDsl.DisplayedPage
import org.xtext.example.guidsl.guiDsl.TabBar
import org.xtext.example.guidsl.guiDsl.Tab

class WindowsPhone7 implements IGenerator{
	
	String _appName
	String _nameSpace
	IFileSystemAccess _access
	
	new (IFileSystemAccess fsa)
	{
		_access=fsa
	}
	
	override doGenerate(Resource input, IFileSystemAccess fsa) {
		_access = fsa
		for (EObject o : input.contents) {
			o.compile();
		}
	}

	def dispatch void compile(EObject o) {
		//throw new UnsupportedOperationException("TODO: auto-generated method stub")
		}
	
	def dispatch void compile (Application app){
		_appName = app.name
		_nameSpace = app.nameSpace
		
		for(DisplayedPage p : app.pages)
		{
			var wp7Code = new WP7Code(app.nameSpace, app.name)	
			var wp7Elements = new WP7Elements(app.nameSpace)			
			_access.generateFile("WP7/"+p.name + ".xaml",wp7Elements.page(p))
			_access.generateFile("WP7/"+p.name + ".xaml.cs",wp7Code.code(p))
		}
		for(TabBar bar : app.pages.filter(typeof(TabBar))){
			var wp7Code = new WP7Code(app.nameSpace + ".pages",app.name)	
			var wp7Elements = new WP7Elements(app.nameSpace + ".pages")
					
//			for(DisplayedPage p : bar .pages)
			for(Tab tab : bar.tabs)
			{	var p = tab.page
				_access.generateFile("WP7/pages/"+p.name + ".xaml",wp7Elements.userControl(p))
				_access.generateFile("WP7/pages/"+p.name + ".xaml.cs",wp7Code.code(p,true))
			}
		}
	}
	
	
	
}