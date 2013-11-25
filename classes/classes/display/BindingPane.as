package classes.display 
{
	import fl.containers.ScrollPane;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.ui.Keyboard;
	import flash.utils.describeType;
	import classes.display.BindDisplay;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class BindingPane extends ScrollPane
	{	
		private var _keyDict:Dictionary;
		
		private var _funcLabels:Array = new Array();
		private var _bindLabels:Array = new Array();
		
		private var _functions:Array;
		private var _binds:Array;
		private var _requireUpdate:Boolean;
		
		private var _content:MovieClip;
		
		public function BindingPane(xPos:int, yPos:int, width:int, height:int) 
		{
			this.x = xPos;
			this.y = yPos;
			this.width = width;
			this.height = height;
			
			this._requireUpdate = true;
			
			// Cheap hack to remove the stupid styling elements of the stock ScrollPane
			var blank:MovieClip = new MovieClip();
			this.setStyle("upSkin", blank);
			
			this.PopulateKeyboardDict();
			
			_content = new MovieClip();
			_content.name = "controlContent";
		}
		
		public function ListBindingOptions():void
		{
			trace("List bindings called");
			
			if (_requireUpdate)
			{
				for (var i:int = 0; i < _functions.length; i++)
				{
					var newLabel = new BindDisplay(this.width);
					newLabel.x = 2;
					newLabel.y = BindDisplay.BUTTON_Y_DELTA * i;
					newLabel.htmlText = "<b>" + _functions[i] + ":</b>";
					_content.addChild(newLabel);
				}
			}
			this.source = _content;
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
		
		public function set functions(funcs:Array):void
		{
			_functions = funcs;
			_requireUpdate = true;
		}
		
		public function get functions():Array
		{
			return _functions;
		}
		
		public function set binds(bindings:Array):void
		{
			_binds = bindings;
			_requireUpdate = true;
		}
		
		public function get binds():Array
		{
			return _binds;
		}
		
		public function get requireUpdate():Boolean
		{
			return _requireUpdate;
		}
	}

}