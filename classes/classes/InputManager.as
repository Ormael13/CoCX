package classes 
{
	import coc.view.MainView;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	import flash.display.MovieClip;
	
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

		private var _controlMethods:Object = new Object();
		private var _availableControlMethods:int = 0;

		private var _cheatControlMethods:Object = new Object();
		private var _availableCheatControlMethods:int = 0;
		
		private var _keysToControlMethods:Object = new Object();
		private var _mainView:MainView;

		public function InputManager(stage:Stage) 
		{
			_stage = stage;
			_mainView = _stage.getChildByName("mainView") as MainView;
			_availableControlMethods = 0;
			_availableCheatControlMethods = 0;
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, this.KeyHandler);
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
		
		public function BindKeyToControl(keyCode:int, funcName:String)
		{
			for (var i:int in _controlMethods)
			{
				if (funcName == _controlMethods[i].Name)
				{
					_keysToControlMethods[keyCode] = _controlMethods[i];
					return;
				}
			}
			
			trace("Failed to bind control method [" + funcName + "] to keyCode [" + keyCode);
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