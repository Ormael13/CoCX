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
		private var mainClassPtr:*;
		private var stage:Stage;
		private var debug:Boolean;
		private var buttons:Array;

		public function ChaosMonkey(mainClass:*)
		{
			this.debug = true;


			this.mainClassPtr = mainClass;
			this.stage = this.mainClassPtr.stage;
			this.run = false;
		}

		private function randomChoice(inArr:Array):*
		{
			return inArr[ Math.floor( Math.random() * inArr.length ) ];
		}

		private function getAvailableKeys()
		{
			if (this.debug) trace("Getting available key events")
			var controlMethods:Array;
			this.buttons = this.mainClassPtr.inputManager.GetControlMethods()
			trace("ControlMethods = ", this.buttons)
			for (var button in this.buttons)
			{
				trace("button - ", this.buttons[button])
			}
			if (this.debug) trace(this.buttons)
		}

		public function createChaos()
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