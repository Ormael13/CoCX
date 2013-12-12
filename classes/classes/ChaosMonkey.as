package classes
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.Stage;
	import classes.CoC_Settings

	/**
	 * Chaos Monkey!
	 * Basically a tool to randomly generate BUTTON_DOWN events, to 
	 * stress-test the game.
	 * @author Fake-Name
	 */
	public class ChaosMonkey
	{	
		
		/*
		Utility to randomly hammer buttons in the hope of generating a crash

		*/
		public var run:Boolean
		private var _excludeMenuKeys:Boolean;
		private var _catchOutputTextErrors:Boolean;
		private var _mainClassPtr:*;
		private var stage:Stage;
		private var debug:Boolean;
		private var buttons:Array;

		private var exitKeyCode:Number = 123;

		/**
		 * Init the ChaosMonkey
		 * @param   mainClass   Reference to core CoC class which is needed to access the inputManager to 
		      *                 properly synthesize fake key events
		 * @param   debug       Emit debugging trace statements
		 */
		public function ChaosMonkey(mainClass:*, debug = false)
		{
			this.debug = debug;
			this._excludeMenuKeys = true;
			this._catchOutputTextErrors = false;

			this._mainClassPtr = mainClass;
			this.stage = this._mainClassPtr.stage;
			this._mainClassPtr.testingBlockExiting = false;

		}

		private function randomChoice(inArr:Array):*
		{
			return inArr[ Math.floor( Math.random() * inArr.length ) ];
		}

		private function initAvailableKeysList()
		{
			/*
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
			*/

			var blockedButtons = new Array(112,     // Quicksave buttons
											113,
											114,
											115,
											116,
											
											117,     // Quickload buttons
											118,
											119,
											120,
											121,
											
											// 83,      // -- Display stats if main menu button displayed
											// 76,      // -- Level up if level up button displayed
											 8,      // -- Go to "Main" menu if in game
											68,      // -- Open saveload if in game
											// 65,      // -- Open apperance if in game
											36);      // -- Cycle the background of the maintext area

			if (this.debug) trace("Getting available key events")
			var controlMethods:Array;
			
			this.buttons = new Array()

			controlMethods = this._mainClassPtr.inputManager.GetControlMethods()
			
			if (this.debug) trace(controlMethods)
			if (this.debug) trace(blockedButtons)

			if (this.debug) trace("ControlMethods = ", this.buttons)
			for (var button in controlMethods)
			{
				if (controlMethods[button] != exitKeyCode)   // prevent the monkey from exiting itself by blocking it from adding the exit key-code to the key array
				{
					if (!this._excludeMenuKeys)
					{
						this.buttons.push(controlMethods[button]);
					}
					else if (blockedButtons.indexOf(controlMethods[button]) < 0)
					{
						this.buttons.push(controlMethods[button]);
					}
				}

			}

			if (this.debug) trace(this.buttons)
			if (this.debug) trace(blockedButtons)
		}

		private function setupExitKey():void
		{
			
			// IIFE Hack: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
			var stopMonkahTempFunc:Function = function(callFunc:Function):Function
			{ 
				return function():void { callFunc() }
			}(this.stopMonkey);

			this._mainClassPtr.inputManager.AddBindableControl(
				"StopMonkah",
				"Stop the chaos-monkey running",
				stopMonkahTempFunc
			);

			this._mainClassPtr.inputManager.BindKeyToControl(exitKeyCode, "StopMonkah");
		}


		public function get excludeMenuKeys():Boolean
		{
			return this._excludeMenuKeys;
		}
		
		public function set excludeMenuKeys(flag:Boolean):void
		{
			this._excludeMenuKeys = flag;
		}

		public function get throwOnSyntaxError():Boolean
		{
			return this._catchOutputTextErrors;
		}
		
		public function set throwOnSyntaxError(flag:Boolean):void
		{
			this._catchOutputTextErrors = flag;
		}

		public function stopMonkey():void
		{
			this._mainClassPtr.testingBlockExiting = false;
			CoC_Settings.haltOnErrors = false;
		}

		private function disengageMonkey():void
		{
				this._mainClassPtr.inputManager.RemoveExistingKeyBind(this.exitKeyCode);
				this.stage.removeEventListener(Event.EXIT_FRAME, this.throwAMonkeyAtIt);

		}

		public function createChaos(blockSaves:Boolean = true)
		{

			trace("Starting monkey")
			CoC_Settings.haltOnErrors = true;
			this._mainClassPtr.testingBlockExiting = true;
			this._mainClassPtr.encounteredErrorFlag = false;

			// Pull in key list from the InputManager
			this.initAvailableKeysList()

			// setup exit handler
			this.setupExitKey()
			
			// Tie the random keypress generator to the EXIT_FRAME event, which
			// runs at the end of each render cycle (it's not *quite* an ON_IDLE event
			// but apparently flash doesn't have a proper ON_IDLE, so what the hell.)
			this.stage.addEventListener(Event.EXIT_FRAME, this.throwAMonkeyAtIt);
		}

		// KeyHandler(e:KeyboardEvent)
		public function throwAMonkeyAtIt(e:*)
		{

			
			var fakeEvent:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN);

			fakeEvent.keyCode = randomChoice(this.buttons);
			
			if (this.debug) trace("FakeEvent - ", fakeEvent);

			this._mainClassPtr.inputManager.KeyHandler(fakeEvent);

			this._mainClassPtr.encounteredErrorFlag

			if (!(this._mainClassPtr.testingBlockExiting))
			{
				trace("Stopping Monkey");
				disengageMonkey();
			}
			if (this._mainClassPtr.encounteredErrorFlag && this._catchOutputTextErrors)
			{
				trace("Stopping Monkey");
				disengageMonkey();
				throw new Error("Syntax Error!")
			}


		}

	}
}