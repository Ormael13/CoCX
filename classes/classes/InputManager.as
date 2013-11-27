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
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.display.MovieClip;
	import flash.utils.describeType;
	import flash.ui.Keyboard;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Generic input manager
	 * I feel sick writing some of these control functors; rather than having some form of queryable game state
	 * we're checking for the presence (and sometimes, the label contents) of UI elements to determine what state
	 * the game is currently in.
	 * @author Gedan
	 */
	public class InputManager 
	{
		// Declaring some consts for clarity when using some of the InputManager methods
		public static const PRIMARYKEY:Boolean = true;
		public static const SECONDARYKEY:Boolean = false;
		public static const NORMALCONTROL:Boolean = false;
		public static const CHEATCONTROL:Boolean = true;
		public static const UNBOUNDKEY:int = -1;
		
		private var _stage:Stage;
		private var _debug:Boolean;

		private var _defaultControlMethods:Object = new Object();
		private var _defaultAvailableControlMethods:int = 0;
		private var _defaultKeysToControlMethods:Object = new Object();
		
		// Basically, an associative list of Names -> Control Methods
		// TODO: Actually conver this into being associative
		private var _controlMethods:Object = new Object();
		private var _availableControlMethods:int = 0;

		// A list of cheat control methods that we can throw incoming keycodes against at will
		private var _cheatControlMethods:Object = new Object();
		private var _availableCheatControlMethods:int = 0;
		
		// The primary lookup method for finding what method an incoming keycode should belong too
		private var _keysToControlMethods:Object = new Object();
		
		// Visual shit
		private var _mainView:MainView;
		private var _mainText:TextField;
		private var _mainTextScollBar:UIScrollBar;
		
		// A new UI element that we can embed buttons into to facilitate key rebinding
		private var _bindingPane:BindingPane;
		
		// A flag to determine if we're listening for keyCodes to execute, or keyCodes to bind a method against
		private var _bindingMode:Boolean;
		private var _bindingFunc:String;
		private var _bindingSlot:Boolean;
		
		public function InputManager(stage:Stage, debug:Boolean = true)
		{
			_bindingMode = false;
			_debug = debug;
			
			_stage = stage;
			_mainView = _stage.getChildByName("mainView") as MainView;
			_availableControlMethods = 0;
			_availableCheatControlMethods = 0;
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, this.KeyHandler);
			
			_mainText = (_stage.getChildByName("mainView") as MovieClip).mainText as TextField;
			_mainTextScollBar = (_stage.getChildByName("mainView") as MovieClip).scrollBar as UIScrollBar;
			
			_bindingPane = new BindingPane(this, _mainText.x, _mainText.y, _mainText.width, _mainText.height);
		}
		
		public function ListenForNewBind(funcName:String, isPrimary:Boolean = true):void
		{
			if (_debug)
			{
				var slot:String = "";
				
				if (isPrimary)
				{
					slot = "Primary";
				}
				else
				{
					slot = "Secondary";
				}
				
				trace("Listening for a new " + slot + " bind for " + funcName);
			}
			
			_bindingMode = true;
			_bindingFunc = funcName;
			_bindingSlot = isPrimary;
			
			_mainText.htmlText = "<b>Hit the key that you want to bind " + funcName + " to!</b>";
			HideBindingPane();
		}
		
		public function StopListenForNewBind():void
		{
			_bindingMode = false;
			DisplayBindingPane();
		}
		
		// Add a new action that can be bound to keys -- this will (mostly) be static I guess
		// Tempted to make this private and init all of the functors we want in the constructor for the manager
		// but that would require arguing with getting access to the function calls we need to bind
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
		
		// Bind either the primary or secondary binding for the control method to a given keycode
		public function BindKeyToControl(keyCode:int, funcName:String, isPrimary:Boolean = true):void
		{
			for (var i:int = 0; i < _availableControlMethods; i++)
			{
				// Find the method we want to bind the incoming key to
				if (funcName == _controlMethods[i].Name)
				{
					// Check if the incoming key is already bound to *something* and if it is, remove the bind.
					this.RemoveExistingKeyBind(keyCode);
					
					// If we're binding the primary key of the method...
					if (isPrimary)
					{
						// If the primary key of the method is already bound, removing the existing bind
						if (_controlMethods[i].PrimaryKey != InputManager.UNBOUNDKEY)
						{
							delete _keysToControlMethods[_controlMethods[i].PrimaryKey];
						}
						
						// Add the new bind
						_keysToControlMethods[keyCode] = _controlMethods[i];
						_controlMethods[i].PrimaryKey = keyCode;
						return;
					}
					// We're doing the secondary key of the method
					else
					{
						// If the secondary key is already bound, remove the existing bind
						if (_controlMethods[i].SecondaryKey != InputManager.UNBOUNDKEY)
						{
							delete _keysToControlMethods[_controlMethods[i].SecondaryKey];
						}
						
						// Add the new bind
						_keysToControlMethods[keyCode] = _controlMethods[i];
						_controlMethods[i].SecondaryKey = keyCode;
						return;
					}
				}
			}
			
			trace("Failed to bind control method [" + funcName + "] to keyCode [" + keyCode + "]");
		}
		
		// Remove an existing key from BoundControlMethods, if present, and shuffle the remaining key as appropriate
		private function RemoveExistingKeyBind(keyCode:int):void
		{
			// If the key is already bound to a method, remove it from that method
			if (_keysToControlMethods[keyCode] != null)
			{
				if (_keysToControlMethods[keyCode].PrimaryKey == keyCode)
				{
					_keysToControlMethods[keyCode].PrimaryKey = _keysToControlMethods[keyCode].SecondaryKey;
					_keysToControlMethods[keyCode].SecondaryKey = InputManager.UNBOUNDKEY;
				}
				else if (_keysToControlMethods[keyCode].SecondaryKey == keyCode)
				{
					_keysToControlMethods[keyCode].SecondaryKey = InputManager.UNBOUNDKEY;
				}
			}
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
			
			// If we're not in binding mode, listen for key inputs to act on
			if (_bindingMode == false)
			{
				// Made it this far, process the key and call the relevant (if any) function
				this.ExecuteKeyCode(e.keyCode);
			}
			// Otherwise, we're listening for a new keycode from the player
			else
			{
				BindKeyToControl(e.keyCode, _bindingFunc, _bindingSlot);
				StopListenForNewBind();
			}
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
		
		/**
		 * Hide the mainText object and scrollbar, ensure the binding ScrollPane is up to date with the latest
		 * data and then show the binding scrollpane.
		 */
		public function DisplayBindingPane():void
		{
			_mainText.visible = false;
			_mainTextScollBar.visible = false;
			
			_bindingPane.functions = this.GetAvailableFunctions();
			_bindingPane.ListBindingOptions();
			
			_stage.addChild(_bindingPane);
		}
		
		/**
		 * Hide the binding ScrollPane, and re-display the mainText object + Scrollbar.
		 */
		public function HideBindingPane():void
		{
			_mainText.visible = true;
			_mainTextScollBar.visible = true;
			_stage.removeChild(_bindingPane);
		}
		
		/**
		 * Register the current methods, and their associated bindings, as the defaults.
		 * TODO: Finish this shit off
		 */
		public function RegisterDefaults():void
		{

		}
		
		/**
		 * Reset the bound keys to the defaults previously registered.
		 */
		public function ResetToDefaults():void
		{

		}

		public function GetAvailableFunctions():Array
		{
			var funcNames:Array = new Array();
			
			for (var i:int = 0; i < _availableControlMethods; i++)
			{
				funcNames.push(_controlMethods[i]);
			}
			
			return funcNames;
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