package classes.display 
{
	import fl.containers.ScrollPane;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.ui.Keyboard;
	import flash.utils.describeType;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class BindingPane extends ScrollPane
	{	
		private var _keyDict:Dictionary;
		
		private var _funcLabels:Array = new Array();
		private var _bindLabels:Array = new Array();
		
		public function BindingPane(xPos:int, yPos:int, width:int, height:int) 
		{
			this.x = xPos;
			this.y = yPos;
			this.width = width;
			this.height = height;
			
			// Cheap hack to remove the stupid styling elements of the stock ScrollPane
			var blank:MovieClip = new MovieClip();
			this.setStyle("upSkin", blank);
			
			this.PopulateKeyboardDict();
		}
		
		public function ListBindingOptions(functions:Array, bindings:Array):void
		{
			for (var i:int = 0; i < functions.length; i++)
			{
				var funcLabel:TextField = new TextField();
				this.addChild(funcLabel);
				
				funcLabel.x = 4;
				funcLabel.y = 4 + (20 * i);
				
				funcLabel.htmlText = "<b>" + functions[i].Name + ":</b>";
				
				_funcLabels.push(funcLabel);
			}
		}
		
		// Builds a dictionary to lookup keyCode values -> string representations of key name
		// Handles things like turning keyCode = 8 into "BACKSPACE" rather than an undisplayable
		// character.
		private function PopulateKeyboardDict():void
		{
			var keyDescriptions:XML = describeType(Keyboard);
			var keyNames:XMLList = keyDescriptions..constant.@name;
			
			_keyDict = new Dictionary();
			
			for (var i:int = 0; i < keyNames.length(); i++)
			{
				_keyDict[Keyboard[keyNames[i]]] = keyNames[i];
			}
		}
	}

}