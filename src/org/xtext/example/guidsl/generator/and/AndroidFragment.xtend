package org.xtext.example.guidsl.generator.and

import org.xtext.example.guidsl.guiDsl.Page
import org.xtext.example.guidsl.guiDsl.LayoutManager
import org.xtext.example.guidsl.guiDsl.Event
import org.xtext.example.guidsl.guiDsl.Button
import org.xtext.example.guidsl.guiDsl.InputText
import org.xtext.example.guidsl.guiDsl.ActiveControl
import org.xtext.example.guidsl.guiDsl.ChangePage
import java.awt.DisplayMode
import org.xtext.example.guidsl.guiDsl.DisplayedPage

class AndroidFragment {
	String _nameSpace
	
	new(String nameSpace) {
		_nameSpace= nameSpace
	}
	def dispatch getFragmentPage(DisplayedPage page){
		'''
		'''
	}
	
	def dispatch getFragmentPage(Page page) {
		'''
		package «_nameSpace»;

		import android.R;
		import android.os.Bundle;
		import android.app.Fragment;
		import android.view.LayoutInflater;
		import android.view.View;
		import android.view.View.OnClickListener;
		import android.view.ViewGroup;
		import android.widget.Button;
		import android.widget.EditText;
		import android.widget.TextView;
		
		public class «page.name» extends Fragment  {
		
		
			@Override
			public View onCreateView(LayoutInflater inflater, ViewGroup container,
					Bundle savedInstanceState) {
		
				View view = inflater.inflate(R.layout.«page.name», container, false);
				«buttonTappedRegistration(page.layout)»
		
				return view;
			}
			
			
		}
		'''
	}
	
	
	
	def CharSequence buttonTappedRegistration(LayoutManager layoutManager) {
		if (layoutManager.elements.nullOrEmpty)
			return ""
		'''
		«FOR ActiveControl control : layoutManager.elements.filter(typeof(ActiveControl))»
			«IF control.clickEvent != null»
				«getTypeOfActiveControl(control)» «control.name» =(«getTypeOfActiveControl(control)») view.findViewById(R.id.«control.name»);
				«control.name».setOnClickListener(new OnClickListener(){
					@Override
					public void onClick(View v){
						«control.clickEvent.PageChangeEvent»
					}
				});
			«ENDIF»
			«FOR LayoutManager layout : layoutManager.elements.filter(typeof(LayoutManager))»
				«buttonTappedRegistration(layout)»
			«ENDFOR»
		«ENDFOR»
		'''
	}
	
	def PageChangeEvent(Event event) {
		if (event instanceof ChangePage)
		{
			val changePageEvent = event as ChangePage
			'''
			Intent myIntent = new Intent(view.getContext(),«changePageEvent.name».class);
			startActivityForResult(myIntent,0); 
			'''
		}
	}
	
	def getTypeOfActiveControl(ActiveControl element) {
		switch element{
			Button:
			{
				return '''Button'''
			}
			InputText:{
				return '''EditText'''	
			}
			
		}
	}
	
}