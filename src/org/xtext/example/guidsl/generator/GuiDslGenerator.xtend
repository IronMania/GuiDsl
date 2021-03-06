/*
 * generated by Xtext
 */
package org.xtext.example.guidsl.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.generator.IFileSystemAccess
import org.xtext.example.guidsl.guiDsl.Application
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.ecore.EObject
import org.xtext.example.guidsl.generator.and.Android
import org.xtext.example.guidsl.generator.winph.WindowsPhone7
import org.xtext.example.guidsl.generator.iph.Iphone

/**
 * Generates code from your model files on save.
 * 
 * see http://www.eclipse.org/Xtext/documentation.html#TutorialCodeGeneration
 */
class GuiDslGenerator implements IGenerator {
	
	override void doGenerate(Resource resource, IFileSystemAccess fsa) {
		var androidGenerator = new Android(fsa)
		var wp7Generator = new WindowsPhone7(fsa)
		var iphoneGenerator = new Iphone(fsa)  
		for (Application app : resource.contents.filter(typeof(Application))){
			androidGenerator.compile(app)
			wp7Generator.compile(app)
			iphoneGenerator.compile(app)
		}
		
//		fsa.generateFile('greetings.txt', 'People to greet: ' + 
//			resource.allContents
//				.filter(typeof(Greeting))
//				.map[name]
//				.join(', '))
	}
	
	
	def dispatch compile(EObject object) {
		return '''doesntwork'''
	}
	
	def dispatch compile (Application app){
		'''
		AppName: ��app.name��
		NameSpaec: ��app.nameSpace��
		'''
		
	}
	
}
