package org.xtext.example.guidsl.generator.winph

import org.eclipse.emf.common.util.EList
import org.xtext.example.guidsl.guiDsl.AppBar
import org.xtext.example.guidsl.guiDsl.AppBarEntry
import org.xtext.example.guidsl.guiDsl.DisplayedPage
import org.xtext.example.guidsl.guiDsl.Element
import org.xtext.example.guidsl.guiDsl.Horizontal
import org.xtext.example.guidsl.guiDsl.Image
import org.xtext.example.guidsl.guiDsl.InputText
import org.xtext.example.guidsl.guiDsl.Label
import org.xtext.example.guidsl.guiDsl.Page
import org.xtext.example.guidsl.guiDsl.TabBar
import org.xtext.example.guidsl.guiDsl.Vertical
import org.xtext.example.guidsl.guiDsl.Grid
import org.xtext.example.guidsl.guiDsl.WP7_TAB_TYPE
import org.xtext.example.guidsl.guiDsl.APP_BAR_ENTRY_IMPORTANCE
import org.xtext.example.guidsl.guiDsl.Button

//This class is for generating the UI Elements
class WP7Elements {
	String _nameSpace
	String _appName
	new (String nameSpace){
		_nameSpace = nameSpace
	}
	
	def dispatch userControl(DisplayedPage page){
		'''Dummy'''
	}
	def dispatch userControl(Page page){
		'''
		<UserControl 
		    x:Class="«_nameSpace».Pages.«page.name»"
		    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
			xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
			xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
			xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
			xmlns:controls="clr-namespace:Microsoft.Phone.Controls;assembly=Microsoft.Phone.Controls"
			mc:Ignorable="d"
			FontFamily="{StaticResource PhoneFontFamilyNormal}"
			FontSize="{StaticResource PhoneFontSizeNormal}"
			Foreground="{StaticResource PhoneForegroundBrush}"
			d:DesignHeight="480"
			d:DesignWidth="480">
		«page.layout.element»
		
		</UserControl>
		'''
	}
	
	def dispatch page(TabBar tabBar) {
		'''
		<phone:PhoneApplicationPage 
		    x:Class="«_nameSpace».«tabBar.name»"
		    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
		    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
		    xmlns:phone="clr-namespace:Microsoft.Phone.Controls;assembly=Microsoft.Phone"
		    xmlns:shell="clr-namespace:Microsoft.Phone.Shell;assembly=Microsoft.Phone"
		    xmlns:controls="clr-namespace:Microsoft.Phone.Controls;assembly=Microsoft.Phone.Controls"
		    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
		    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
		    mc:Ignorable="d" d:DesignWidth="480" d:DesignHeight="768" 
		    d:DataContext="{d:DesignData SampleData/MainViewModelSampleData.xaml}"
		    FontFamily="{StaticResource PhoneFontFamilyNormal}"
		    FontSize="{StaticResource PhoneFontSizeNormal}"
		    Foreground="{StaticResource PhoneForegroundBrush}"
		    SupportedOrientations="Portrait"  Orientation="Portrait"
		    shell:SystemTray.IsVisible="True"
		    xmlns:pages="clr-namespace:«_nameSpace»">
			<Grid x:Name="LayoutRoot" Background="Transparent">
				«tabBar.getWp7TabBar»
			</Grid>
		
			«tabBar.appBar.addAppBar»
		</phone:PhoneApplicationPage>
		'''
	}
	
	def addAppBar(AppBar bar) {
		if (bar == "" || bar == null || bar.entry.nullOrEmpty)
		return ""
		'''
		<phone:PhoneApplicationPage.ApplicationBar>
			<shell:ApplicationBar IsVisible="True"
			IsMenuEnabled="True">
				«bar.entry.actionEntry»
				<shell:ApplicationBar.MenuItems>
					«bar.entry.optionsEntry»
				</shell:ApplicationBar.MenuItems>
		</phone:PhoneApplicationPage.ApplicationBar>
		'''
	}
	
	def actionEntry(EList<AppBarEntry> entryList) {
		'''
		«FOR e : entryList.filter[ e | e.importance.equals(APP_BAR_ENTRY_IMPORTANCE::ACTION)]»
		<shell:ApplicationBarIconButton x.Name="«e.name»" Text="«e.text»"«IF !e.icon.nullOrEmpty»IconUri="«e.icon»"«ENDIF»/>
		«ENDFOR»
		'''
	}
	
	def optionsEntry(EList<AppBarEntry> list) {
		//Options Entry do not have an Icon in WP7
		'''
		«FOR AppBarEntry entry : list.filter[e | e.importance.equals(APP_BAR_ENTRY_IMPORTANCE::OPTION)]»
		<shell:ApplicationBarMenuItem x:Name="«entry.name»" Text="«entry.name»"/>
		«ENDFOR»
		'''
	}
	
	def CharSequence getWp7TabBar(TabBar bar) {
		switch bar.wp7TabType{
			case WP7_TAB_TYPE::NONE : 
			''''''
			case WP7_TAB_TYPE::PIVOT : 
			bar.wp7Pivot
			case WP7_TAB_TYPE::PANORAMA : 
			bar.wp7Panorama
			default:""
		}
	}
	def wp7Pivot(TabBar bar){
		'''
		<controls:Pivot Title="«_appName»">
		«FOR e : bar.tabs»
			<controls:PivotItem Header="«e.title»"
				<pages:«e.page.name»/>
			</controls:PivotItem>
		«ENDFOR»
		</controls:Pivot>
			'''
	}
	
	def wp7Panorama(TabBar bar){
		'''
			<controls:Panorama Title="«_appName»">
			«FOR e : bar.tabs»
				<controls:Panorama Header="«e.title»"
					<pages:«e.page.name»/>
				</controls:Panorama>
			«ENDFOR»
			</controls:Panorama>
			'''
	}
	
	def dispatch CharSequence page(DisplayedPage page) {
		throw new UnsupportedOperationException("This Should not occure")
	}
	
	def dispatch CharSequence page(Page page) {
		'''
		<phone:PhoneApplicationPage 
		    x:Class="«_nameSpace».«page.name»"
		    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
		    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
		    xmlns:phone="clr-namespace:Microsoft.Phone.Controls;assembly=Microsoft.Phone"
		    xmlns:shell="clr-namespace:Microsoft.Phone.Shell;assembly=Microsoft.Phone"
		    xmlns:controls="clr-namespace:Microsoft.Phone.Controls;assembly=Microsoft.Phone.Controls"
		    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
		    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
		    mc:Ignorable="d" d:DesignWidth="480" d:DesignHeight="768" 
		    d:DataContext="{d:DesignData SampleData/MainViewModelSampleData.xaml}"
		    FontFamily="{StaticResource PhoneFontFamilyNormal}"
		    FontSize="{StaticResource PhoneFontSizeNormal}"
		    Foreground="{StaticResource PhoneForegroundBrush}"
		    SupportedOrientations="Portrait"  Orientation="Portrait"
		    shell:SystemTray.IsVisible="True"
		    xmlns:pages="clr-namespace:«_nameSpace»">
			«page.layout.element»
			«page.appBar.addAppBar»
		
		</phone:PhoneApplicationPage>
		'''
	}
	
	
	def dispatch element(Label label){
		'''
		<TextBlock x:Name="«label.name»" Text="«label.text»"/>
		'''
	}
	
	def dispatch element(InputText input){
		'''
		<TextBlock x:Name="«input.name»" Text="«input.text»"/>
		'''
	}
	
	def dispatch element(Image image){
		'''
		<Image x:Name="«image.name»"«IF image.defaultImage== null» Source="«image.defaultImage»"«ENDIF»/>
		'''
	}
	
	def dispatch element(Vertical layout)
	{
		'''
		<StackPanel x:Name="«layout.name»">
			«FOR Element e : layout.elements»
			«e.element()»
			«ENDFOR»
			</StackPanel>
		'''
	}
	
	def dispatch element(Horizontal layout)
	{
		'''
		<StackPanel x:Name="«layout.name»" Orientation="Horizontal">
			«FOR Element e : layout.elements»
			«e.element()»
			«ENDFOR»
			</StackPanel>
		'''
	}
	
	def dispatch element(Grid layout)
	{
		'''
		<Grid x:Name="«layout.name»">
			«IF layout.columns > 0»
			<Grid.ColumnDefinitions>
			</Grid.ColumnDefinitions>
			«ENDIF»
			«IF layout.rows > 0»
			<Grid.RowDefinitions>
			</Grid.RowDefinitions>
			«ENDIF»
			«FOR Element e : layout.elements»
			«e.element()»
			«ENDFOR»
			</Grid>
		'''
	}
	
	def dispatch element(Button button){
		'''
		<Button x:name="«button.name»"	Contents="«button.text»"«IF button.clickEvent!= null» «WP7Events::clickedEvent(button.clickEvent)»«ENDIF»/>
		'''
	}
}