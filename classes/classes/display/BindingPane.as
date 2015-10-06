package classes.display 
{
	import classes.BoundControlMethod;
	import classes.InputManager;
	import fl.containers.ScrollPane;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.ui.Keyboard;
	import flash.utils.describeType;
	import classes.display.BindDisplay;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * Defines a new UI element, providing a scrollable container to be used for display of bound
	 * keyboard controls.
	 * @author Gedan
	 */
	public class BindingPane extends ScrollPane
	{	
		private var _inputManager:InputManager;
		private var _stage:Stage;
		
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
		public function BindingPane(inputManager:InputManager, xPos:int, yPos:int, width:int, height:int, uiscrollwidth:int) 
		{
			_inputManager = inputManager;
			
			/* This is a super super fucking annoying fix. The TextField class, whilst it supports being bound to a
			*  doesn't include a scrollbar by default, it has to be attached as a sperate, distinct component. It's
			*  literally bolted onto the side, and isn't part of the sizing information of the TextField itself.
			*  ScrollPanes on the other hand, DO feature a scrollbar as a core part of their functionality. And
			*  for ScrollPanes, the UIScrollBar is included in the total sizing information. Whoever wrote this shit
			*  was literally on crack, I SWEAR TO GOD. */
			this.width = width + uiscrollwidth + 3;
			this.height = height - 3;
			
			this.x = xPos - 1;
			this.y = yPos;
			
			// Cheap hack to remove the stupid styling elements of the stock ScrollPane
			var blank:MovieClip = new MovieClip();
			this.setStyle("upSkin", blank);
			
			// Build the keyCode->string lookup object
			this.PopulateKeyboardDict();
			
			// Initiate a new container for content that will be placed in the scroll pane
			_content = new MovieClip();
			_content.name = "controlContent";
			_contentChildren = 0;
			
			// Hook into some stuff so that we can fix some bugs that ScrollPane has
			this.addEventListener(Event.ADDED_TO_STAGE, AddedToStage);
		}
		
		/**
		 * Cleanly get us a reference to the stage to add/remove other event listeners
		 * @param	e
		 */
		private function AddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, AddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, RemovedFromStage);
			
			_stage = this.stage;
			
			_stage.addEventListener(MouseEvent.MOUSE_WHEEL, MouseScrollEvent);
		}
		
		private function RemovedFromStage(e:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, RemovedFromStage);
			this.addEventListener(Event.ADDED_TO_STAGE, AddedToStage);
			
			_stage.removeEventListener(MouseEvent.MOUSE_WHEEL, MouseScrollEvent);
		}
		
		private function MouseScrollEvent(e:MouseEvent):void
		{
			this.verticalScrollPosition += -( e.delta * 8 );
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
			// Add a nice little instructional field at the top of the display.
			var _textFormatLabel:TextFormat = new TextFormat();
			_textFormatLabel.size = 20;
			
			var helpLabel:TextField = new TextField();
			helpLabel.name = "helpLabel";
			helpLabel.x = 10;
			helpLabel.width = this.width - 40;
			helpLabel.defaultTextFormat = _textFormatLabel;			
			helpLabel.multiline = true;
			helpLabel.wordWrap = true;
			helpLabel.autoSize = TextFieldAutoSize.LEFT; // With multiline enabled, this SHOULD force the textfield to resize itself vertically dependent on content.
			helpLabel.htmlText = "<b>Keyboard Control Bindings:</b>\n\n";
			helpLabel.htmlText += "Click a button next to the action you wish to bind to a new key, then hit the key you want to bind the selected action to.\n\n"
			helpLabel.htmlText += "Custom bindings are stored inside your save game files.\n\n";
			helpLabel.htmlText += "Duplicate keys are automatically unbound from their old control action.\n\n";
			helpLabel.htmlText += "<b>Reset Ctrls</b> will reset all of the control bindings to their defaults.\n\n";
			helpLabel.htmlText += "<b>Clear Ctrls</b> will remove all of the current control bindings, leaving everything Unbound.\n\n";
			
			//helpLabel.height *= 2; 
			
			_contentChildren++;
			_content.addChild(helpLabel);
			
			for (var i:int = 0; i < _functions.length; i++)
			{
				_contentChildren++;
				
				var newLabel:BindDisplay = new BindDisplay(this.width);
				newLabel.name = _functions[i].Name;
				newLabel.x = 2;
				newLabel.y = ( BindDisplay.BUTTON_Y_DELTA * i ) + ( 7 + helpLabel.textHeight );
				newLabel.htmlText = "<b>" + _functions[i].Name + ":</b>";
				newLabel.button1Text = _keyDict[_functions[i].PrimaryKey];
				newLabel.button2Text = _keyDict[_functions[i].SecondaryKey];
				
				// This is going to look crazy...
				var genPrimaryCallback:Function = function(funcName:String, inMan:InputManager):Function
				{
					return function():void 
					{
						inMan.ListenForNewBind(funcName, InputManager.PRIMARYKEY);
						_stage.focus = _stage;
					}
				}
				
				var genSecondaryCallback:Function = function(funcName:String, inMan:InputManager):Function
				{
					return function():void
					{
						inMan.ListenForNewBind(funcName, InputManager.SECONDARYKEY);
						_stage.focus = _stage;
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
