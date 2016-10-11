package classes 
{

	public class LightsOut extends BaseContent
	{
		
		public function LightsOut() {}
		
		public var lightsOutVictoryFunction:Function;
		public var lightsOutFailureFunction:Function;

		public var lightsArray:Array;

		public function startLightsOut(victoryFunction:Function = null, failureFunction:Function = null):void
		{
			clearOutput();
			if (victoryFunction == null) victoryFunction = getGame().debugMenu.accessDebugMenu;
			lightsOutVictoryFunction = victoryFunction;
			if (failureFunction == null) failureFunction = getGame().debugMenu.accessDebugMenu;
			lightsOutFailureFunction = failureFunction;
			
			menu();
			lightsArray = new Array();
			
			for (var i:int = 0; i < 15; i++)
			{
				lightsArray[i] = false;
				
				addButton(i, " ", toggleLight, i);
			}
			
			var onBts:Array = [1, 5, 6, 9, 10, 11, 12, 13];
			
			for (i = 0; i < onBts.length; i++)
			{
				lightsArray[onBts[i]] = true;
				
				addButton(onBts[i], "XXXXXXXX", toggleLight, onBts[i]);
			}
		}

		public function testVictoryFunc():void
		{
			clearOutput();
			outputText("A winner is you! A horsecock for your butt as tribute!");
			menu();
			addButton(0, "Next", getGame().debugMenu.accessDebugMenu);
		}

		public function testFailureFunc():void
		{
			clearOutput();
			outputText("You failed. Try again?");
			menu();
			addButton(0, "Yes", startLightsOut, testVictoryFunc, testFailureFunc);
			addButton(1, "No", getGame().debugMenu.accessDebugMenu);
		}
		
		public function toggleSlot(slot:int):void
		{
			lightsArray[slot] = !lightsArray[slot]
			
			if (lightsArray[slot]) 
			{
				//userInterface.setButtonPurple(slot);
				mainView.setButtonText(slot, "XXXXXXXX");
			}
			else
			{
				//userInterface.setButtonBlue(slot);
				mainView.setButtonText(slot, "");
			}
		}

		public function toggleLight(slot:int):void
		{
			toggleSlot(slot);
			toggleNearby(slot);
			
			var allOff:Boolean = true;
			var allOn:Boolean = true;
			
			for (var i:int = 0; i < 15; i++)
			{
				if (lightsArray[i] == 1) allOff = false;
				if (lightsArray[i] == 0) allOn = false;

			}
			if (allOn)
			{
				lightsOutFailureFunction();
			}
			if (allOff)
			{
				lightsOutVictoryFunction();
			}
		}

		public function toggleNearby(slot:int):void
		{
			var pX:int = slot % 5;
			var pY:int = slot / 5;
			
			if (pX > 0) toggleSlot(slot - 1);
			if (pX < 4) toggleSlot(slot + 1);
			if (pY > 0) toggleSlot(slot - 5);
			if (pY < 2) toggleSlot(slot + 5);
		}
		
	}

}