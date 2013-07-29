package org.xtext.example.guidsl.generator.winph

import org.xtext.example.guidsl.guiDsl.Event
import org.xtext.example.guidsl.guiDsl.TappedEvent
import org.xtext.example.guidsl.guiDsl.ChangePage

class WP7Events {
	
	static dispatch def CharSequence clickedEvent(Event event) {
		''''''
	}
	
	static dispatch def CharSequence clickedEvent(TappedEvent event) {
		if (event == null)
				return ""
		'''Click="«event.name» "'''
	}
	
	static dispatch def CharSequence codeClicked(TappedEvent event){
		if (event == null)
			return ""
		'''
		private void «event.name»(object sender, RoutedEventArgs e)
		{
		}
		'''
	}
	static dispatch def CharSequence codeClicked(ChangePage event){
		'''
		private void «event.name»(object sender, RoutedEventArgs e)
		{
			DependencyObject depObject = this;
			while (depObject != null)
			{
				if (typeof(Page).IsInstanceOfType(depObject))
				{
					break;
				}
				else
				{
					debObject = VisualTreeHelper.GetParent(depObject);
				}
			}
			var page = depObject as Page;
			page.NavigationService.Navigate(new Uri("/«event.targetPage»", UriKind.Relative));
		}
		'''
	}
}