package classes
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.Stage;

	public class ChaosMonkey
	{	
		
		/*
		Utility to randomly hammer buttons in the hope of generating a crash

		*/
		public var run:Boolean
		public var excludeMenuKeys:Boolean;
		private var mainClassPtr:*;
		private var stage:Stage;
		private var debug:Boolean;
		private var buttons:Array;

		public function ChaosMonkey(mainClass:*)
		{
			this.debug = false;
			this.excludeMenuKeys = true;

			this.mainClassPtr = mainClass;
			this.stage = this.mainClassPtr.stage;
			this.run = false;
			this.getAvailableKeys()
		}

		private function randomChoice(inArr:Array):*
		{
			return inArr[ Math.floor( Math.random() * inArr.length ) ];
		}

		private function getAvailableKeys()
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

			var blockedButtons = new Array(112, 113, 114, 115, 116, 83, 76, 117, 118, 119, 120, 121, 8, 68, 65, 36)

			if (this.debug) trace("Getting available key events")
			var controlMethods:Array;
			
			this.buttons = new Array()

			controlMethods = this.mainClassPtr.inputManager.GetControlMethods()
			
			if (this.debug) trace(controlMethods)
			if (this.debug) trace(blockedButtons)

			if (this.debug) trace("ControlMethods = ", this.buttons)
			for (var button in controlMethods)
			{
				if (!this.excludeMenuKeys)
				{
					this.buttons.push(controlMethods[button]);
				}
				else if (blockedButtons.indexOf(controlMethods[button]) < 0)
				{
					this.buttons.push(controlMethods[button]);
				}

			}

			/*
			for (button in this.buttons)
			{
				trace("Index of", this.buttons[button], "=", blockedButtons.indexOf(Number(this.buttons[button])))
				for (var a = 0; a < blockedButtons.length; a++)
				{

					if (this.buttons[button] == blockedButtons[a])
					{
						trace("It's a duplicate - ", this.buttons[button])
					}
				}

			}
			*/
			if (this.debug) trace(this.buttons)
			if (this.debug) trace(blockedButtons)
		}

		public function createChaos(blockSaves:Boolean = true)
		{
			this.run = true;
			this.getAvailableKeys()
			this.stage.addEventListener(Event.EXIT_FRAME, this.throwAMonkeyAtIt);
		}

		// KeyHandler(e:KeyboardEvent)
		public function throwAMonkeyAtIt(e:*)
		{

			
			var fakeEvent:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN);
			fakeEvent.keyCode = randomChoice(this.buttons);
			if (this.debug) trace("FakeEvent - ", fakeEvent)
			this.mainClassPtr.inputManager.KeyHandler(fakeEvent);

			if (!(this.run))
				this.stage.removeEventListener(Event.EXIT_FRAME, this.throwAMonkeyAtIt);


		}

	}
}