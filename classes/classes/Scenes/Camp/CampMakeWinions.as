/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	
	public class CampMakeWinions extends BaseContent
	{
		
		public function CampMakeWinions() 
		{}
		
		//TEMPORAL_GOLEMS_BAG and PERNAMENT_GOLEMS_BAG - pretty easy to quess: amount of temp or perm golems PC have in "golem bag"
		
		public function maxTemporalGolemsBagSize():Number {
			var maxTemporalGolemsBagSizeCounter:Number = 0;
			if (player.findPerk(PerkLib.JobGolemancer) >= 0) maxTemporalGolemsBagSizeCounter += 3;
			return maxTemporalGolemsBagSizeCounter;
		}
		public function maxPernamentGolemsBagSize():Number {
			var maxPernamentGolemsBagSizeCounter:Number = 0;
			return maxPernamentGolemsBagSizeCounter;
		}
		public function maxReusableGolemCoresBagSize():Number {
			var maxReusableGolemCoresBagSizeCounter:Number = 0;
			if (maxTemporalGolemsBagSize() > 0) maxReusableGolemCoresBagSizeCounter += maxTemporalGolemsBagSize();
			if (maxPernamentGolemsBagSize() > 0) maxReusableGolemCoresBagSizeCounter += maxPernamentGolemsBagSize();
			maxReusableGolemCoresBagSizeCounter *= 2;
			return maxReusableGolemCoresBagSizeCounter;
		}
		
		public function accessMakeWinionsMainMenu():void {
			clearOutput();
			menu();
			outputText("What helper would you like to make?\n");
			outputText("Stored golem cores for future reuse when making new golems: " + flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] + " / " + maxReusableGolemCoresBagSize() + "\n");
			if (player.findPerk(PerkLib.JobGolemancer) >= 0) outputText("Temporal Golems Bag: " + flags[kFLAGS.TEMPORAL_GOLEMS_BAG] + " golems\n");
		//	if (player.findPerk(PerkLib.) >= 0) outputText("Pernament Golems Bag: " + flags[kFLAGS.PERNAMENT_GOLEMS_BAG] + " golems\n");
			if (player.findPerk(PerkLib.JobGolemancer) >= 0) addButton(0, "T.S.Golem", makeTemporalStoneGolem).hint("Make most simply golem made of pile of bones. <b>It will cruble after one attack!</b>")
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 0) addButton(13, "TakeOutCore", takeOutGolemCoreFromGolemBag).hint("Take out one golem core from 'golem bag'.")
			addButton(14, "Back", playerMenu);
		}
		
		public function makeTemporalStoneGolem():void {
			clearOutput();
			if (player.mana < 50) {
				outputText("Your mana is too low to finish golem creation.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (!player.hasItem(useables.GOLCORE, 1)) {
				outputText("You lack golem core to finish golem creation.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] == maxTemporalGolemsBagSize()) {
				outputText("You not having enough space to store another one.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 0) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]--;
			else player.destroyItems(useables.GOLCORE, 1);
			player.mana -= 50;
			statScreenRefresh();
			outputText("You draw a seal in the ground around the pile of stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] < 1) flags[kFLAGS.TEMPORAL_GOLEMS_BAG] = 1;
			else flags[kFLAGS.TEMPORAL_GOLEMS_BAG]++;
			doNext(accessMakeWinionsMainMenu);
			cheatTime(1/4);
		}
		
		public function takeOutGolemCoreFromGolemBag():void {
			clearOutput();
			outputText("In order to not overload your bad ofr reusable golem cores you took one of them.\n\n");
			flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]--;
			inventory.takeItem(useables.GOLCORE, accessMakeWinionsMainMenu);
		}
		
	}

}