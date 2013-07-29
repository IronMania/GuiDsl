package org.xtext.example.guidsl.generator.and

import org.xtext.example.guidsl.guiDsl.DisplayedPage
import org.xtext.example.guidsl.guiDsl.TabBar
import org.xtext.example.guidsl.guiDsl.Tab
import org.xtext.example.guidsl.guiDsl.Page
import org.xtext.example.guidsl.guiDsl.AppBar

class AndroidActivity {
	static def codeActivity(DisplayedPage page, String nameSpace) {
		'''
			package «nameSpace»;
			
			import android.R;
			import android.app.ActionBar;
			import android.app.ActionBar.Tab;
			import android.app.Activity;
			import android.app.Fragment;
			import android.app.FragmentTransaction;
			import android.content.Context;
			import android.os.Bundle;
			import android.view.Menu;
			import android.view.MenuItem;
			
			public class «page.name»Activity extends Activity {
			
				public static Context appContext;
			
				@Override
				protected void onCreate(Bundle savedInstanceState) {
					super.onCreate(savedInstanceState);
					setContentView(R.layout.«page.name»);
				
					«page.addActionBar»
				
				}
			
				@Override
				public boolean onCreateOptionsMenu(Menu menu) {
			// Inflate the menu; this adds items to the action bar if it is present.
			«IF page.hasOptionsMenu»
			getMenuInflater().inflate(R.menu.«page.name», menu);
			«ELSE»
			//getMenuInflater().inflate(R.menu.«page.name», menu);		
			«ENDIF»
					return true;
				}
				
				«page.appBar.onOptionsItemSelected»
			}
			
			
		'''
	}
	
	static def onOptionsItemSelected(AppBar bar) {
		if (bar == null)
			return ''''''
		'''
		@Override
		public boolean onOptionsItemSelected(MenuItem item){
			switch (item.getItemId()){
				«FOR e : bar.entry»
				case R.id.«e.name»:
					«e.name»();
					return true;
				«ENDFOR»
				default:
				return super.onOptionsItemSelected(item);
			}
		}
		
		«FOR e : bar.entry»
		private void «e.name»(){
			«IF e.clickEvent != null»
			«AndroidEvents::changePageEvent(e.clickEvent)»
			«ENDIF»
		}
		«ENDFOR»
		'''
	}
	
	static def dispatch hasOptionsMenu(Page page) {
		return page.appBar!= null && !page.appBar.entry.nullOrEmpty		
	}
	static def dispatch hasOptionsMenu(TabBar tabBar) {
		return tabBar.appBar!= null && !tabBar.appBar.entry.nullOrEmpty
	}
	static def codePageContent(Page page, String nameSpace) {
		'''
		'''
	}
	
	static def codeTabBarContent(TabBar tabBar, String nameSpace){
		'''
		'''
	}
	def static dispatch addActionBar(DisplayedPage page) {
		''''''
	}
	def static dispatch addActionBar(Page page){
		'''
		'''
	}
	def static dispatch addActionBar(TabBar bar) {
		'''
		final ActionBar actionbar = getActionBar();
		actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);
		«FOR Tab tabPage : bar.tabs»
		«tabPage.addTabs»
		«ENDFOR»
		'''
	}
	
	def static addTabs(Tab page) {
		'''
		ActionBar.Tab «page.name» = actionBar.newTab()
			.setText(R.string.title_«page.name»)
			«IF page.icon.nullOrEmpty»
			.setIcon(R.drawable.«page.icon»)
			«ENDIF»
			.setTabListener(new MyTabsListener<«page.name»>(this, "«page.title»",«page.name».class));
		actionBar.addTab(«page.name»);
		'''
	}
	
	static def getTabListenerCode(String nameSpace){'''
			package «nameSpace»;
			import android.app.ActionBar.Tab;
			import android.app.ActionBar.TabListener;
			import android.app.Activity;
			import android.app.Fragment;
			import android.app.FragmentTransaction;
			public class MyTabsListener<T extends Fragment> implements TabListener {
				
				private Fragment mFragment;
			    private final Activity mActivity;
			    private final String mTag;
			    private final Class<T> mClass;

				 public MyTabsListener(Activity activity, String tag, Class<T> clz) {
				        mActivity = activity;
				        mTag = tag;
				        mClass = clz;
				    }
			
				public void onTabReselected(Tab tab, FragmentTransaction ft) {
					//Toast.makeText(MainActivity.appContext, "Reselected!", Toast.LENGTH_LONG).show();
				}
			
				public void onTabSelected(Tab tab, FragmentTransaction ft) {
				    // Check if the fragment is already initialized
			        if (mFragment == null) {
			            // If not, instantiate and add it to the activity
			            mFragment = Fragment.instantiate(mActivity, mClass.getName());
			            ft.add(android.R.id.content, mFragment, mTag);
			        } else {
			            // If it exists, simply attach it in order to show it
			            ft.attach(mFragment);
			        }
				}
			
				public void onTabUnselected(Tab tab, FragmentTransaction ft) {
				      if (mFragment != null) {
				            // Detach the fragment, because another one is being attached
				            ft.detach(mFragment);
				        }
				}
			
			}
		'''
		}

}