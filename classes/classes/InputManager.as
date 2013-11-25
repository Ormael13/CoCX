package classes 
{
	import classes.display.BindingPane;
	import coc.view.MainView;
	import fl.controls.UIScrollBar;
	import fl.containers.ScrollPane;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.display.MovieClip;
	import flash.utils.describeType;
	import flash.ui.Keyboard;
	
	/**
	 * Generic input manager
	 * I feel sick writing some of these control functors; rather than having some form of queryable game state
	 * we're checking for the presence (and sometimes, the label contents) of UI elements to determine what state
	 * the game is currently in.
	 * @author Gedan
	 */
	public class InputManager 
	{
		private var _stage:Stage;
		
		private var _keyDict:Dictionary;

		private var _controlMethods:Object = new Object();
		private var _availableControlMethods:int = 0;

		private var _cheatControlMethods:Object = new Object();
		private var _availableCheatControlMethods:int = 0;
		
		private var _keysToControlMethods:Object = new Object();
		private var _mainView:MainView;

		private var _mainText:TextField;
		private var _mainTextScollBar:UIScrollBar;
		
		private var _bindingPane:BindingPane;
		
		public function InputManager(stage:Stage)
		{
			_stage = stage;
			_mainView = _stage.getChildByName("mainView") as MainView;
			_availableControlMethods = 0;
			_availableCheatControlMethods = 0;
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, this.KeyHandler);
			
			_mainText = (_stage.getChildByName("mainView") as MovieClip).mainText as TextField;
			_mainTextScollBar = (_stage.getChildByName("mainView") as MovieClip).scrollBar as UIScrollBar;
			
			_bindingPane = new BindingPane(_mainText.x, _mainText.y, _mainText.width, _mainText.height);
			
			this.PopulateKeyboardDict();
		}
		
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
		
		// Add a new action that can be bound to keys -- this will (mostly) be static I guess
		// Tempted to make this private and init all of the functors we want in the constructor for the manager
		public function AddBindableControl(name:String, desc:String, func:Function, isCheat:Boolean = false):void
		{
			if (isCheat)
			{
				_cheatControlMethods[_availableCheatControlMethods] = new BoundControlMethod(func, name, desc);
				_availableCheatControlMethods++;
			}
			else
			{
				_controlMethods[_availableControlMethods] = new BoundControlMethod(func, name, desc);
				_availableControlMethods++;
			}
		}
		
		public function BindKeyToControl(keyCode:int, funcName:String):void
		{
			for (var i:int = 0; i < _availableControlMethods; i++)
			{
				if (funcName == _controlMethods[i].Name)
				{
					_keysToControlMethods[keyCode] = _controlMethods[i];
					return;
				}
			}
			
			trace("Failed to bind control method [" + funcName + "] to keyCode [" + keyCode + "]");
		}
		
		// Core handler we attach to the stage to do our event/control processing
		public function KeyHandler(e:KeyboardEvent):void
		{
			trace("Got key input " + e.keyCode);
			
			// Ignore key input during certain phases of gamestate
			if (_mainView.eventTestInput.x == 207.5)
			{
				return;
			}
			
			if (_mainView.nameBox.visible && _stage.focus == _mainView.nameBox)
			{
				return;
			}
			
			// Made it this far, process the key and call the relevant (if any) function
			this.ExecuteKeyCode(e.keyCode);
		}
		
		private function ExecuteKeyCode(keyCode:int):void
		{
			if (_keysToControlMethods[keyCode] != null)
			{
				trace("Attempting to exec func [" + _keysToControlMethods[keyCode].Name + "]");
				
				_keysToControlMethods[keyCode].ExecFunc();
			}
			
			for (var i:int = 0; i < _availableCheatControlMethods; i++)
			{
				_cheatControlMethods[i].ExecFunc(keyCode);
			}
		}
		
		public function DisplayBindingPane():void
		{
			_mainText.visible = false;
			_mainTextScollBar.visible = false;
			
			_bindingPane.functions = this.GetAvailableFunctions();
			_bindingPane.binds = this.GetBoundKeyCodesAsDisplayArray(_bindingPane.functions);
			_bindingPane.ListBindingOptions();
			
			_stage.addChild(_bindingPane);
		}
		
		public function HideBindingPane():void
		{
			_mainText.visible = true;
			_mainTextScollBar.visible = true;
			_stage.removeChild(_bindingPane);
		}
		
		public function GetAvailableFunctions():Array
		{
			var funcNames:Array = new Array();
			
			for (var i:int = 0; i < _availableControlMethods; i++)
			{
				funcNames.push(_controlMethods[i].Name);
			}
			
			return funcNames;
		}
		
		public function GetBoundKeyCodesAsDisplayArray(functions:Array):Array
		{
			// Gonna pack keycodes as a series of pairs, a pair for each function
			var keyCodes:Array = new Array();
			
			for (var i:int = 0; i < functions.length; i++)
			{
				var funcKeys:Array = GetBoundKeyCodesForFunction(functions[i]);
				
				if (funcKeys.length == 0)
				{
					funcKeys.push("Unbound");
					funcKeys.push("Unbound");
				}
				else if (funcKeys.length == 1)
				{
					funcKeys.push("Unbound");
				}
				else if (funcKeys.length > 2)
				{
					funcKeys.splice(2, funcKeys.length - 1);
				}
				
				keyCodes = keyCodes.concat(funcKeys);
			}
			
			return keyCodes;
		}
		
		public function GetBoundKeyCodesForFunction(funcName:String):Array
		{
			var keyCodes:Array = new Array();
			
			for (var i:String in _keysToControlMethods)
			{
				if (funcName == _keysToControlMethods[i].Name)
				{
					keyCodes.push(int(i));
				}
			}
			
			return keyCodes;
		}
		
		public function GenerateControlMenuText():String
		{
			var result:String = "";
			
			var funcNames:Array = GetAvailableFunctions();
			
			for (var i:int = 0; i < funcNames.length; i++)
			{
				var keyCodes:Array = GetBoundKeyCodesForFunction(funcNames[i]);
				
				result += "<b>" + funcNames[i] + ":</b>";
				
				if (keyCodes.length == 0)
				{
					result += " Unbound"
				}
				else
				{
					for (var k:int = 0; k < keyCodes.length; k++)
					{
						var charRep:String;
						
						result += " " + _keyDict[keyCodes[k]];
					}
				}
				
				result += "\n";
			}
			
			return result;
		}
	}
	
	/**
	 * List of known bound keyboard methods
	 * 
	 * Some of the methods use an undefined "Event" parameter to pass into the actual UI components...
	 * ... strip this out and instead modify the handlers on the execution end to have a default null parameter?
	 * 
	 * ** Bypass handler if mainView.eventTestInput.x == 270.5
	 * ** Bypass handler if mainView.nameBox.visible && stage.focus == mainView.nameBox
	 * 
	 * 38	-- UpArrow			-- Cheat code for Humus stage 1
	 * 40	-- DownArrow		-- Cheat code for Humus stage 2
	 * 37 	-- LeftArrow		-- Cheat code for Humus stage 3
	 * 39	-- RightArrow		-- Cheat code for Humus stage 4 IF str > 0, not gameover, give humus
	 * 
	 * 83	-- s				-- Display stats if main menu button displayed
	 * 76	-- l				-- Level up if level up button displayed
	 * 112	-- F1				-- Quicksave to slot 1 if menu_data displayed
	 * 113	-- F2				-- Quicksave slot 2
	 * 114	-- F3				-- Quicksave slot 3
	 * 115	-- F4				-- Quicksave slot 4
	 * 116	-- F5				-- Quicksave slot 5
	 * 
	 * 117	-- F6				-- Quickload slot 1
	 * 118	-- F7				-- Quickload slot 2
	 * 119	-- F8				-- Quickload slot 3
	 * 120	-- F9				-- Quickload slot 4
	 * 121	-- F10				-- Quickload slot 5
	 * 
	 * 8	-- Backspace		-- Go to "Main" menu if in game
	 * 68	-- d				-- Open saveload if in game
	 * 65	-- a				-- Open apperance if in game
	 * 78	-- n				-- "no" if button index 1 displays no		<--
	 * 89	-- y				-- "yes" if button index 0 displays yes		<-- These two seem akward
	 * 80	-- p				-- display perks if in game
	 * 
	 * 13/32 -- Enter/Space		-- if button index 0,4,5 or 9 has text of (nevermind, abandon, next, return, back, leave, resume) execute it
	 * 
	 * 36	-- Home				-- Cycle the background of the maintext area
	 * 
	 * 49	-- 1				-- Execute button index 0 if visisble
	 * 50	-- 2				-- ^ index 1
	 * 51	-- 3				-- ^ index 2
	 * 52	-- 4				-- ^ index 3
	 * 53	-- 5				-- ^ index 4
	 * 54/81-- 6/q				-- ^ index 5
	 * 55/87-- 7/w				-- ^ index 6
	 * 56/69-- 8/e				-- ^ index 7
	 * 57/82-- 9/r				-- ^ index 8
	 * 48/84-- 0/t				-- ^ index 9
	 * 
	 * 68	-- ???				-- ??? Unknown, theres a conditional check for the button, but no code is ever executed
	 */
}