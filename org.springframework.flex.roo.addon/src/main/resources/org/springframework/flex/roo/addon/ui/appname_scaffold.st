<?xml version="1.0" encoding="utf-8"?>
<s:Application xmlns:fx="http://ns.adobe.com/mxml/2009" 
			   xmlns:s="library://ns.adobe.com/flex/spark" 
			   xmlns:mx="library://ns.adobe.com/flex/mx"
			   minWidth="955" minHeight="600">

	<fx:Script>
		<![CDATA[
			import flash.utils.getDefinitionByName;
			import flash.utils.getQualifiedClassName;
			
			import mx.controls.Alert;
			import mx.core.UIComponent;
			
			protected function entityList_doubleClickHandler(event:MouseEvent):void
			{	
				var selectedEntity:String = entityList.selectedItem;
				var selectedEntityPackage:String = selectedEntity.substr(0,1).toLowerCase() + selectedEntity.substring(1);
				var viewClass:Class = getDefinitionByName("$presentationPackage$."+selectedEntityPackage+"::"+selectedEntity+"View") as Class;
				if (viewClass != null) {
					var newView:UIComponent = UIComponent(new viewClass());
					newView["remotingChannels"] = remotingChannels;
					mainGroup.addElement(newView);
				} else {
					Alert.show("No view found for the selected entity.", "View Unavailable");
				}
			}
		]]>
	</fx:Script>

	<fx:Declarations>
		<s:ArrayList id="entities">
			$org/springframework/flex/roo/addon/ui/entity_list_entry()$
		</s:ArrayList>
		
		<s:ChannelSet id="remotingChannels">
			<s:AMFChannel id="amf" url="$amfRemotingUrl$"/>	
		</s:ChannelSet>
	</fx:Declarations>
	
	<s:Group id="mainGroup" height="100%" width="100%">
		<s:layout>
			<s:HorizontalLayout/>
		</s:layout>
		
		<s:Panel id="entityPanel" title="Entity List" height="100%">
			<s:List id="entityList" dataProvider="{entities}" width="100%" height="100%" 
					toolTip="Double-Click the selected Entity" doubleClickEnabled="true" 
					doubleClick="entityList_doubleClickHandler(event)"/>
		</s:Panel>
	</s:Group>
		
</s:Application>