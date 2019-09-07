/**
 * @author Stadler (mostly) and Ormael (choice of enemies encounters and other events)
 * Area with lvl 50-70 enemies.
 * Currently a Work in Progress.
 */

package classes.Scenes.Areas 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Scenes.Areas.DeepSea.*;
	
	use namespace CoC;
	
	public class DeepSea extends BaseContent
	{
		
		public function DeepSea() 
		{
		}
		
		public function exploreDeepSea():void {
			flags[kFLAGS.DISCOVERED_DEEP_SEA]++;
			
			var choice:Array = [];
			var select:int;
			
			//Build choice list!
		//	choice[choice.length] = 0;	//Kraken
			choice[choice.length] = 0;	//Shark Girls Pack
			choice[choice.length] = 1;	//Tiger Shark Girls Pack
			if (rand(4) == 0) choice[choice.length] = 2;	 //Find nothing! The rand will be removed from this once the Deep Sea is populated with more encounters.
			
			select = choice[rand(choice.length)];
			switch(select) {
			/*	case 0:
					CoC.instance.exploration.genericDemonsEncounters1();
					break;
				case 01:
					flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] = 1;
					player.underwaterCombatBoost();
					sharkGirlScene.oceanSharkGirlEncounter();
					break;
				case 1:
					flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] = 2;
					player.underwaterCombatBoost();
					sharkGirlScene.oceanTigersharkGirlEncounter();
					break;
				case 3:
					CoC.instance.exploration.genericImpEncounters2();
					break;
			*/	default:
					clearOutput();
					outputText("You swim through the depths of the sea barely seeing anything for over an hour, finding nothing before you decied to give up and return to the shore.\n\n");
					if (rand(2) == 0) {
						//1/3 chance for strength
						if (rand(3) == 0 && player.str < 200) {
							outputText("The effort of struggling in the ocean depths has made you stronger.");
							dynStats("str", .5);
						}
						//1/3 chance for toughness
						else if (rand(3) == 1 && player.tou < 200) {
							outputText("The effort of struggling in the ocean depths has made you tougher.");
							dynStats("tou", .5);
						}
						//1/3 chance for speed
						else if (rand(3) == 2 && player.spe < 200) {
							outputText("The effort of struggling in the ocean depths has made you faster.");
							dynStats("tou", .5);
						}
					}
					doNext(camp.returnToCampUseTwoHours);
			}
			
		}
		
	}

}