/**
 * @author Ormael
 * Area with lvl 6-42 group enemies. Good for PC focused on group fights.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	
	use namespace kGAMECLASS;
	
	public class BattlefieldOuter extends BaseContent
	{
		
		public function BattlefieldOuter() 
		{
		}
		
		public function exploreOuterBattlefield():void {
			flags[kFLAGS.DISCOVERED_OUTER_BATTLEFIELD]++;
			
			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0; //Golem enemies
			if (rand(4) == 0) choice[choice.length] = 1; //3 Find nothing! The rand will be removed from this once the Outer Battlefield is populated with more encounters.
			
			select = choice[rand(choice.length)];
			switch(select) {
				case 0:
					kGAMECLASS.exploration.genericGolemsEncounters1();
					break;/*
				case 1:
					kGAMECLASS.exploration.genericDemonsEncounters1();
					break;
				case 2:
					clearOutput();
					outputText("You spot something on the ground. Taking a closer look, it's one of those imps food packages. ");
					inventory.takeItem(consumables.IMPFOOD, camp.returnToCampUseOneHour);
					break;*/
				default:
					clearOutput();
					outputText("You spend one hour exploring this deserted battlefield but you don't manage to find anything interesting. Yet this trip made you become a little bit more wise.");
					dynStats("wis", .5);
					doNext(camp.returnToCampUseOneHour);
			}
		}
	}
}