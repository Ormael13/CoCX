/**
 * @author Ormael
 * Demon area with lvl 41-61 demonic enemies. Each exploration will even slowly corrupt PC unless corruption is above 71.
 * Currently a Work in Progress.
 */

package classes.Scenes.Areas 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.Areas.BlightRidge.DemonScene;
import classes.Scenes.Areas.DefiledRavine.*;
import classes.Scenes.NPCs.Forgefather;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class DefiledRavine extends BaseContent
	{
		public var demonScene:DemonScene = new DemonScene();
		
		public function DefiledRavine() 
		{
		}
		
		public function exploreDefiledRavine():void {
			flags[kFLAGS.DISCOVERED_DEFILED_RAVINE]++;
			if (player.cor < 71) dynStats("cor", 1.5);
			
			//Twin Dart pistol
			if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns2) && player.statusEffectv2(StatusEffects.TelAdreTripxiGuns2) == 0 && player.hasKeyItem("Twin Dart pistol") < 0 && rand(2) == 0) {
				partsofTwinDartPistol();
				return;
			}
			//Alvina
			if (flags[kFLAGS.ALVINA_FOLLOWER] < 12 && player.hasKeyItem("Zetaz's Map") >= 0 && ((rand(10) == 0) || (flags[kFLAGS.LETHICE_DEFEATED] > 0 && rand(2) == 0))) {
				SceneLib.alvinaFollower.alvinaThirdEncounter();
				return;
			}
			if (((flags[kFLAGS.ALVINA_FOLLOWER] > 8 && flags[kFLAGS.ALVINA_FOLLOWER] < 12 && player.hasKeyItem("Zetaz's Map") >= 0) || player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 2) && rand(2) == 0) {
				SceneLib.alvinaFollower.alvinaThirdEncounter();
				return;
			}
			
			var choice:Array = [];
			var select:int;
			//Dragon Demon, Demon Soldier, Demon Pristress, even stronger imp variants (ayo/flesh golem versions?), Kitsune Demon - Kumiho, Salamander Demon
			//Build choice list!
			//choice[choice.length] = 0; //???Demon Centauress/Demon Pack/super buffed imp variant??? (lvl 41)
			choice[choice.length] = 0; //Cow Succubus (lvl 45)/Mino Incubus (lvl 46)
			//choice[choice.length] = 0; //???Demon Pack/Demon Centauress/Kumiho??? (lvl 52)
			//choice[choice.length] = 0; //???Demon Pack/Demon Centauress??? (lvl 56)
			choice[choice.length] = 1; //Corrupted Improved Flesh Golem (lvl 59)/Corrupted Improved Flesh Golems(lvl 61)
			choice[choice.length] = 2; //Imp Food
            if (player.hasKeyItem("Old Pickaxe") > 0 && Forgefather.materialsExplained)
			    choice[choice.length] = 3; //Marble
			if (rand(4) == 0) choice[choice.length] = 4; //Find nothing! The rand will be removed from this once the Defiled Ravine is populated with more encounters.
			
			select = choice[rand(choice.length)];
			switch(select) {
				/*case 0:
					SceneLib.exploration.genericImpEncounters2();
					break;*/
				case 0:
					if (rand(2) == 0) demonScene.CowSuccubusEncounter();
					else demonScene.MinoIncubusEncounter();
					break;
				/*case 2:
					SceneLib.exploration.();
					break;
				case 3:
					SceneLib.exploration.();
					break;*/
				case 1:
					SceneLib.fleshGolemScenes.introCorruptedImprovedFleshGolemS();
					return;
				case 2:
					clearOutput();
					outputText("You spot something on the ground. Taking a closer look, it's one of those imps food packages. ");
					inventory.takeItem(consumables.IMPFOOD, camp.returnToCampUseOneHour);
					break;
				case 3:
					clearOutput();
                    outputText("You stumble across a vein of Marble, this looks like suitable material for your gargoyle form.\n");
                    outputText("Do you wish to mine it?");
                    menu();
                    addButton(0, "Yes", defiledRavineSiteMine);
                    addButton(1, "No", camp.returnToCampUseOneHour);
					break;
				default:
					clearOutput();
					outputText("You spend one hour exploring the tainted ravine but you don't manage to find anything interesting, unless feeling like you are becoming slightly more horny counts.");
					dynStats("lib", 1);
					doNext(camp.returnToCampUseOneHour);
			}
		}
		
		public function partsofTwinDartPistol():void {
			clearOutput();
			outputText("As you explore the blight ridge you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Twin Dart pistol in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Twin Dart pistol", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function defiledRavineSiteMine():void {
			if (Forgefather.materialsExplained != 1) doNext(camp.returnToCampUseOneHour);
			else {
				clearOutput();
				if (player.fatigue > player.maxFatigue() - 50) {
					outputText("\n\n<b>You are too tired to consider mining. Perhaps some rest will suffice?</b>");
					doNext(camp.returnToCampUseOneHour);
					return;
				}
				outputText("\n\nYou begin slamming your pickaxe against the marble, spending the better part of the next two hours mining. This done, you bring back your prize to camp. ");
				var minedStones:Number = 13 + Math.floor(player.str / 20);
				minedStones = Math.round(minedStones);
				fatigue(50, USEFATG_PHYSICAL);
				SceneLib.forgefatherScene.incrementMarbleSupply(minedStones);
				doNext(camp.returnToCampUseTwoHours);
			}
		}
	}
}