/**
 * Created by Kitteh6660. Volcanic Crag is a new endgame area with level 25 encounters.
 * Currently a Work in Progress.
 * 
 * This zone was mentioned in Glacial Rift doc.
 */

package classes.Scenes.Areas 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.VolcanicCrag.*;
	
	use namespace kGAMECLASS;
	
	public class VolcanicCrag extends BaseContent
	{
		public var behemothScene:BehemothScene = new BehemothScene();
		
		public function VolcanicCrag() 
		{
		}
		
		public function exploreVolcanicCrag():void {
			flags[kFLAGS.DISCOVERED_GLACIAL_RIFT]++
			doNext(playerMenu);
			if (isAprilFools() && flags[kFLAGS.DLC_APRIL_FOOLS] == 0) {
				getGame().DLCPrompt("Extreme Zones DLC", "Get the Extreme Zones DLC to be able to visit Glacial Rift and Volcanic Crag and discover the realms within!", "$4.99");
				return;
			}
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !kGAMECLASS.helScene.followerHel()) {
				kGAMECLASS.helScene.helSexualAmbush();
				return;
			}
			
			var chooser:Number = rand(5);
			if (chooser > 0) {
				behemothScene.behemothIntro();
			}
			else {
				outputText("You spend one hour exploring the infernal landscape but you don't manage to find anything interesting.", true);
				doNext(camp.returnToCampUseOneHour);
				return;
			}
		}
		
	}

}