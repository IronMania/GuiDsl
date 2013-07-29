package org.xtext.example.guidsl.generator.and

import org.xtext.example.guidsl.guiDsl.LayoutManager
import org.xtext.example.guidsl.guiDsl.Label
import org.xtext.example.guidsl.guiDsl.InputText
import org.xtext.example.guidsl.guiDsl.Image
import org.xtext.example.guidsl.guiDsl.Grid
import org.xtext.example.guidsl.guiDsl.Vertical
import org.xtext.example.guidsl.guiDsl.Horizontal
import org.xtext.example.guidsl.guiDsl.Button
import org.xtext.example.guidsl.guiDsl.Element

class AndroidElements {
	boolean _isFragment
	
	new (boolean isFragment){
		_isFragment = isFragment
	}
	
	def getPage(LayoutManager layout){
		layout.element
	}
	
	def dispatch element(LayoutManager layout){
		''''''
	} 
	
	def dispatch element(Label label){
		'''
		<TextView android:id="@+id/«label.name»"
			android:layout_width="wrap_content"
			android:layout_height="wrap_content"
			android:text="@string/«label.name»"
			/>
		'''
	}
	
	def dispatch element(InputText input){
		'''
		<TextView android:id="@+id/«input.name»"
			android:layout_width="wrap_content"
			android:layout_height="wrap_content"
			android:text="@string/«input.name»"
			/>
		'''
	}
	
	def dispatch element(Image image){
		'''
		<ImageView android:id="@+id/«image.name»"
			android:layout_width="wrap_content"
			android:layout_height="wrap_content"
			android:text="@string/«image.name»"
			/>
		'''
	}
	
	def dispatch element(Grid grid){
		'''
		<GridView xmlns:android="http://schemas.android.com/apk/res/android"
			android:id="@+id/«grid.name»"
			android:layout_width="fill_parent"
			android:layout_height="fill_parent"
			android:orientation="vertical"
			android:columnCount="«grid.columns»"
			android:rowCount="«grid.rows»"
			>
			«FOR Element e : grid.elements»
			«e.element()»
			«ENDFOR»
			</GridView>
		'''
	}
	
	def dispatch element(Vertical layout)
	{
		'''
		<LinearLayout xmlns:android="ahttp://schemas.android.com/apk/res/android"
			android:id="@+id/«layout.name»"
			android:layout_width="fill_parent"
			android:layout_height="fill_parent"
			android:orientation="vertical">
			«FOR Element e : layout.elements»
			«e.element()»
			«ENDFOR»
			</LinearLayout>
		'''
	}
	
	def dispatch element(Horizontal layout)
	{
		'''
		<LinearLayout xmlns:android="ahttp://schemas.android.com/apk/res/android"
			android:id="@+id/«layout.name»"
			android:layout_width="fill_parent"
			android:layout_height="fill_parent"
			android:orientation="horizontal">
			«FOR Element e : layout.elements»
			«e.element()»
			«ENDFOR»
			</LinearLayout>
		'''
	}
	def dispatch element(Button button){
		'''
		<Button android:id="@+id/«button.name»"
			android:layout_width="wrap_content"
			android:layout_height="wrap_content"
			android:text="@string/«button.name»"
			«IF button.clickEvent!= null && !_isFragment»
			«AndroidEvents::clickedEvent(button.clickEvent)»
			«ENDIF»
		/>
		'''
	}
	
	
}