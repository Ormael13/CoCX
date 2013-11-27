package classes.display 
{
	import classes.BoundControlMethod;
	import classes.InputManager;
	import fl.containers.ScrollPane;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.ui.Keyboard;
	import flash.utils.describeType;
	import classes.display.BindDisplay;
	
	/**
	 * Defines a new UI element, providing a scrollable container to be used for display of bound
	 * keyboard controls.
	 * @author Gedan
	 */
	public class BindingPane extends ScrollPane
	{	
		private var _inputManager:InputManager;
		
		// A lookup for integer keyCodes -> string representations
		private var _keyDict:Dictionary;
		
		private var _functions:Array;
		private var _newFuncs:Array;
		
		private var _content:MovieClip;
		private var _contentChildren:int;
		
		/**
		 * Initiate the BindingPane, setting the stage positioning and reference back to the input manager
		 * so we can generate function callbacks later.
		 * 
		 * @param	inputManager	Reference to the game input manager for method access
		 * @param	xPos			X position on the stage for the top-left corner of the ScrollPane
		 * @param	yPos			Y position on the stage for the top-left corner of the ScrollPane
		 * @param	width			Fixed width of the containing ScrollPane
		 * @param	height			Fixed height of the containing ScrollPane
		 */
		public function BindingPane(inputManager:InputManager, xPos:int, yPos:int, width:int, height:int) 
		{
			_inputManager = inputManager;
			
			this.x = xPos;
			this.y = yPos;
			this.width = width;
			this.height = height;
			
			// Cheap hack to remove the stupid styling elements of the stock ScrollPane
			var blank:MovieClip = new MovieClip();
			this.setStyle("upSkin", blank);
			
			// Build the keyCode->string lookup object
			this.PopulateKeyboardDict();
			
			// Initiate a new container for content that will be placed in the scroll pane
			_content = new MovieClip();
			_content.name = "controlContent";
			_contentChildren = 0;
		}
		
		public function ListBindingOptions():void
		{
			if (_contentChildren == 0)
			{
				InitContentObjects();
			}
			else
			{
				UpdateContentObjects();
			}
			
			this.source = _content;
		}
		
		/**
		 * Initiate the container used to display all of the available functions that can be bound,
		 * along with a pair of buttons representing primary and secondary keys.
		 * The buttons call back into the input manager to trigger the key binding mode, display object
		 * switches, and set state so the input manager knows what function to bind an incoming keyCode
		 * to.
		 * TODO: Shoot self in face.
		 */
		private function InitContentObjects():void
		{
			for (var i:int = 0; i < _functions.length; i++)
			{
				_contentChildren++;
				
				var newLabel = new BindDisplay(this.width);
				newLabel.name = _functions[i].Name;
				newLabel.x = 2;
				newLabel.y = BindDisplay.BUTTON_Y_DELTA * i;
				newLabel.htmlText = "<b>" + _functions[i].Name + ":</b>";
				newLabel.button1Text = _keyDict[_functions[i].PrimaryKey];
				newLabel.button2Text = _keyDict[_functions[i].SecondaryKey];
				
				// This is going to look crazy...
				var genPrimaryCallback:Function = function(funcName:String, inMan:InputManager):Function
				{
					return function():void 
					{
						inMan.ListenForNewBind(funcName, InputManager.PRIMARYKEY);
					}
				}
				
				var genSecondaryCallback:Function = function(funcName:String, inMan:InputManager):Function
				{
					return function():void
					{
						inMan.ListenForNewBind(funcName, InputManager.SECONDARYKEY);
					}
				}
				// ... Warned you.

				newLabel.button1Callback = genPrimaryCallback(_functions[i].Name, _inputManager);
				newLabel.button2Callback = genSecondaryCallback(_functions[i].Name, _inputManager);
				
				_content.addChild(newLabel);
			}
		}
		
		/**
		 * Operating under the assumption that new control cannot be added once the game is running,
		 * ie we will never see new controls in the incoming function list versus what it contained
		 * when we initially created the display objects in the _content container.
		 */
		private function UpdateContentObjects():void
		{
			for (var i:int = 0; i < _functions.length; i++)
			{
				var currLabel:BindDisplay = _content.getChildByName(_functions[i].Name) as BindDisplay;
				
				currLabel.button1Text = _keyDict[_functions[i].PrimaryKey];
				currLabel.button2Text = _keyDict[_functions[i].SecondaryKey];
			}
		}
		
		/**
		 * Builds a dictionary to lookup keyCode values -> string representations of key names.
		 * Handles things like turning keyCode = 8 into "BACKSPACE" rather than an undisplayable
		 * character.
		 * TODO: Probably work out a good way of shortening some possibly long key names.
		 */
		private function PopulateKeyboardDict():void
		{
		
			var keyDescriptions:XML = describeType(Keyboard);
			var keyNames:XMLList = keyDescriptions..constant.@name;
			
			_keyDict = new Dictionary();
			
			for (var i:int = 0; i < keyNames.length(); i++)
			{
				_keyDict[Keyboard[keyNames[i]]] = keyNames[i];
			}
			
			_keyDict[ -1] = "Unbound";
		}
		
		public function set functions(funcs:Array):void
		{
			_functions = funcs;
		}
		
		public function get functions():Array
		{
			return _functions;
		}
	}
}