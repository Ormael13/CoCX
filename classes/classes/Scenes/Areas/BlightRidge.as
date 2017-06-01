/**
 * @author Ormael
 * Demon area with lvl 26-31 demonic enemies. Each exploration will even slowly corrupt PC unless corruption is above 66.
 * Currently a Work in Progress.
 */

package classes.Scenes.Areas 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.BlightRidge.*;
	import classes.Scenes.Monsters.Imp;
	import classes.Scenes.Monsters.ImpPack;
	
	use namespace kGAMECLASS;
	
	public class BlightRidge extends BaseContent
	{
		public function BlightRidge() 
		{
		}
		
		public function exploreBlightRidge():void {
			flags[kFLAGS.DISCOVERED_BLIGHT_RIDGE]++
			if (player.cor < 66) dynStats("cor", 1);
			
			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0; //Imp enemies
			choice[choice.length] = 1; //Succubi/Incubu/Omnicubi enemies
			choice[choice.length] = 2; //Imp Food
			//choice[choice.length] = 3; //
			//if (rand(3) == 0) choice[choice.length] = 2; //Find Imp's Food ^^
			if (rand(4) == 0) choice[choice.length] = 3; //Find nothing! The rand will be removed from this once the Blight Ridge is populated with more encounters.
			
			select = choice[rand(choice.length)];
			switch(select) {
				case 0:
					kGAMECLASS.exploration.genericImpEncounters2();
					break;
				case 1:
					kGAMECLASS.exploration.genericDemonsEncounters1();
					break;
				case 2:
					clearOutput();
					outputText("You spot something on the ground. Taking a closer look, it's one of those imps food packages. ");
					inventory.takeItem(consumables.IMPFOOD, camp.returnToCampUseOneHour);
					break;
				default:
					clearOutput();
					outputText("You spend one hour exploring the tainted ridge but you don't manage to find anything interesting, unless feeling of becoming slight more horny counts.");
					dynStats("lib", .5);
					doNext(camp.returnToCampUseOneHour);
			}
		}
		
	}

}