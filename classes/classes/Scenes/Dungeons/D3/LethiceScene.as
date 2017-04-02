package classes.Scenes.Dungeons.D3 
{
	import classes.*;
	import classes.GlobalFlags.*;

	public class LethiceScene extends BaseContent
	{
		
		public function LethiceScene() 
		{
			
		}
		
		public function takeLethiciteArmor():void {
			flags[kFLAGS.LETHICITE_ARMOR_TAKEN] = 1;
			clearOutput();
			//outputText("Thankfully, the armor is still there. ");
			inventory.takeItem(armors.LTHCARM, getGame().d3.resumeFromFight, putBackLethiciteArmor);
		}
		private function putBackLethiciteArmor():void {
			flags[kFLAGS.LETHICITE_ARMOR_TAKEN] = 0;
			clearOutput();
			outputText("Unfortunately, you don't have enough space in your inventory so you put the armor back where it was.");
			doNext(getGame().d3.resumeFromFight);
		}
	}

}