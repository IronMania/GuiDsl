package org.xtext.example.guidsl.generator.and

import org.xtext.example.guidsl.guiDsl.Event
import org.xtext.example.guidsl.guiDsl.TappedEvent
import org.xtext.example.guidsl.guiDsl.ChangePage

class AndroidEvents {
	static dispatch def CharSequence clickedEvent(Event event) {
		''''''
	}
	
	static dispatch def clickedEvent(TappedEvent event) {
		'''android:onClick="«event.name»"'''
	}
	
	static dispatch def changePageEvent (TappedEvent event){
		''''''
	}
	static dispatch def changePageEvent (ChangePage event){
		'''
		«IF event != null»
			Intend myIntent = new Intend(appContext, «event.targetPage.name».class);
			startActivityForResult(myIntent,0);
		«ENDIF»
		'''
	}
}