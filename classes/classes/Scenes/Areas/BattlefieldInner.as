/**
 * @author Ormael
 * Area with lvl 24-60 group enemies. Good for PC focused on group fights.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.Areas.Battlefield.*;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class BattlefieldInner extends BaseContent
	{
		
		public function BattlefieldInner() 
		{
		}
		
		public function exploreInnerBattlefield():void {
			flags[kFLAGS.DISCOVERED_INNER_BATTLEFIELD]++;
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !SceneLib.helFollower.followerHel()) {
				SceneLib.helScene.helSexualAmbush();
				return;
			}
			//Etna
			if (flags[kFLAGS.ETNA_FOLLOWER] < 1 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && !player.hasStatusEffect(StatusEffects.EtnaOff) && rand(5) == 0) {
				SceneLib.etnaScene.repeatYandereEnc();
				return;
			}
			//Diana
			if (flags[kFLAGS.DIANA_FOLLOWER] < 6 && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1 && !player.hasStatusEffect(StatusEffects.DianaOff) && rand(10) == 0) {
				SceneLib.dianaScene.repeatLakeEnc();
				return;
			}
			//Ted
			if (flags[kFLAGS.TED_LVL_UP] >= 1 && flags[kFLAGS.TED_LVL_UP] < 4 && player.statusEffectv1(StatusEffects.CampSparingNpcsTimers4) < 1 && rand(10) == 0) {
				SceneLib.tedScene.introPostHiddenCave();
				return;
			}
			
			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0; //Golem group enemies
			choice[choice.length] = 1; //Golem group enemies
			choice[choice.length] = 2; //Golem group enemies
			choice[choice.length] = 3; //Goblin/Imp group enemies
			choice[choice.length] = 4; //Goblin/Imp group enemies
			choice[choice.length] = 5; //Items
			choice[choice.length] = 6; //Items
			choice[choice.length] = 7; //Find nothing!
			
			select = choice[rand(choice.length)];
			switch(select) {
				case 0:
				case 1:
				case 2:
					SceneLib.exploration.genericGolemsEncounters1();
					break;
				case 3:
				case 4:
					SceneLib.exploration.genericGobImpEncounters1();
					break;
				case 5:
					clearOutput();
					outputText("You spot something on the ground among various items remains. Taking a closer look, it's ");
					if (rand(2) == 0) {
						if (player.level >= 48 && rand(3) == 0) {
							outputText("a high-grade Soulforce Recovery Pill. ");
							inventory.takeItem(consumables.HG_SFRP, camp.returnToCampUseOneHour);
						}
						else {
							outputText("a mid-grade Soulforce Recovery Pill. ");
							inventory.takeItem(consumables.MG_SFRP, camp.returnToCampUseOneHour);
						}
					}
					else {
						if (player.level >= 48 && rand(3) == 0) {
							outputText("an Arcane Regen Concotion. ");
							inventory.takeItem(consumables.AREGCON, camp.returnToCampUseOneHour);
						}
						else {
							outputText("a diluted Arcane Regen Concotion. ");
							inventory.takeItem(consumables.D_ARCON, camp.returnToCampUseOneHour);
						}
					}
					break;
				case 6:
					clearOutput();
					outputText("While exploring the battlefield you find the remains of some metal scraps. At first you think you won't find anything useful there but a metal plate draws your attention, it could be useful later. You put the item in your backpack and head back to camp.\n\n");
					outputText("<b>You found a metal plate.</b>");
					flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES]++;
					break;
				default:
					clearOutput();
					outputText("You spend one hour exploring this deserted battlefield but you don't manage to find anything interesting. Yet this trip made you become a little bit more wise.");
					dynStats("wis", 1);
					doNext(camp.returnToCampUseOneHour);
			}
		}
	}
}