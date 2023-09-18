package classes.display
{
import classes.InputManager;

import coc.view.Block;

import com.bit101.components.ScrollPane

import flash.display.Bitmap;

import flash.display.MovieClip;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.ui.Keyboard;
import flash.utils.Dictionary;
import flash.utils.describeType;

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
		private static var _keyDict:Dictionary;
		
		private var _functions:Array;
		private var _newFuncs:Array;
		
		private var _content:Block;
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
			move(xPos,yPos);
			setSize(width,height);
			
			// Cheap hack to remove the stupid styling elements of the stock ScrollPane
			PanelAlpha = 0;
			color = 0xCCCCC;
			// Initiate a new container for content that will be placed in the scroll pane
			_content = new Block({layoutConfig:{
				type: Block.LAYOUT_FLOW,
				direction: 'column',
				gap: 4
			}});
			_content.name = "controlContent";
			_content.addEventListener(Block.ON_LAYOUT,function(e:Event):void{
				if (content) {
					update();
				}
			});
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
			this._vScrollbar.value += -( e.delta * 8 );
			update();
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

			this.content.addChild(_content);
			update();
		}
		
		/**
		 * Initiate the container used to display all of the available functions that can be bound,
		 * along with a pair of buttons representing primary and secondary keys.
		 * The buttons call back into the input manager to trigger the key binding mode, display object
		 * switches, and set state so the input manager knows what function to bind an incoming keyCode
		 * to.
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
			helpLabel.htmlText += "Click a button next to the action you wish to bind to a new key, then hit the key you want to bind the selected action to.\n\n";
			helpLabel.htmlText += "Custom bindings are stored inside your save game files.\n\n";
			helpLabel.htmlText += "Duplicate keys are automatically unbound from their old control action.\n\n";
			helpLabel.htmlText += "<b>Reset Ctrls</b> will reset all of the control bindings to their defaults.\n\n";
			helpLabel.htmlText += "<b>Clear Ctrls</b> will remove all of the current control bindings, leaving everything Unbound.\n\n";
			
			//helpLabel.height *= 2;
			
			_contentChildren++;
			_content.addElement(helpLabel);
			
			for (var i:int = 0; i < _functions.length; i++)
			{
				_contentChildren++;
				
				var newLabel:BindDisplay = new BindDisplay(this.width-20);
				newLabel.name = _functions[i].Name;
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
				};
				
				var genSecondaryCallback:Function = function(funcName:String, inMan:InputManager):Function
				{
					return function():void
					{
						inMan.ListenForNewBind(funcName, InputManager.SECONDARYKEY);
						_stage.focus = _stage;
					}
				};
				// ... Warned you.

				newLabel.button1Callback = genPrimaryCallback(_functions[i].Name, _inputManager);
				newLabel.button2Callback = genSecondaryCallback(_functions[i].Name, _inputManager);
				
				_content.addElement(newLabel);
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
				var currLabel:BindDisplay = _content.getElementByName(_functions[i].Name) as BindDisplay;
				
				currLabel.button1Text = _keyDict[_functions[i].PrimaryKey];
				currLabel.button2Text = _keyDict[_functions[i].SecondaryKey];
			}
		}
		
		/**
		 * Builds a dictionary to lookup keyCode values -> string representations of key names.
		 * Handles things like turning keyCode = 8 into "BACKSPACE" rather than an undisplayable
		 * character.
		 */
		private static function PopulateKeyboardDict():void
		{
		
			var keyDescriptions:XML = describeType(Keyboard);
			var keyNames:XMLList = keyDescriptions..constant.@name;
			
			_keyDict = new Dictionary();
			
			for (var i:int = 0; i < keyNames.length(); i++)
			{
				_keyDict[Keyboard[keyNames[i]]] = humanize(keyNames[i].toString());
			}
			
			_keyDict[ -1] = "Unbound";
		}
		
		private static function humanize(name:String):String {
			if (name.indexOf("NUMBER_") == 0) name = name.slice("NUMBER_".length);
			return name;
		}
		// Build the keyCode->string lookup object
		PopulateKeyboardDict();
		public static function keyName(keyCode:int,defaultName:String):String {
			return _keyDict[keyCode] || defaultName;
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
