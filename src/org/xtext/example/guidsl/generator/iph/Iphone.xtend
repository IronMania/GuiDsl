package org.xtext.example.guidsl.generator.iph

import org.eclipse.xtext.generator.IGenerator
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.EObject
import org.xtext.example.guidsl.guiDsl.Application

class Iphone implements IGenerator {
	IFileSystemAccess _access
	override doGenerate(Resource input, IFileSystemAccess fsa) {
		_access = fsa
		for (EObject o : input.contents) {
			o.compile();
		}
	}
	new (IFileSystemAccess fsa)
	{
		_access=fsa
	}
	def compile(Application app) {
		var storyBoard = new IPhoneStoryBoard()
		_access.generateFile("iPhone/en.lproj/MainStoryboard.storyboard", storyBoard.getStoryboar(app))	
	}
	
	def compile(EObject o) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
