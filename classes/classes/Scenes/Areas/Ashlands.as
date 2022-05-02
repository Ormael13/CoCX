/**
 * @author Ormael
 * Area with lvl 40-55 enemies.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Ashlands.*;
import classes.Scenes.NPCs.Forgefather;
import classes.Scenes.Areas.Forest.AlrauneScene;
import classes.Scenes.Areas.HighMountains.PhoenixScene;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class Ashlands extends BaseContent
	{
		public var phoenixScene:PhoenixScene = new PhoenixScene();
		public var alrauneScene:AlrauneScene = new AlrauneScene();
		public var hellcatScene:HellCatScene = new HellCatScene();
		
		public function Ashlands() 
		{
		}
		
		public function exploreAshlands():void {
			flags[kFLAGS.DISCOVERED_ASHLANDS]++;
			doNext(playerMenu);
			
			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0; //Phoenix Squad - (lvl 41) OR Fire Golem (lvl 64)
			choice[choice.length] = 1; //?? (lvl 52)
			choice[choice.length] = 2; //Hellcat (lvl 46)
			choice[choice.length] = 3; //Cinderbloom (lvl 40)
			choice[choice.length] = 4; //Fire Golem (lvl 64)
            if (player.hasKeyItem("Old Pickaxe") > 0 && Forgefather.materialsExplained)
			    choice[choice.length] = 5; //Granite Mine
            if (rand(4) == 0)
			    choice[choice.length] = 6; //Find nothing!
			
			//Double barreled dragon gun
			if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns1) && player.statusEffectv3(StatusEffects.TelAdreTripxiGuns1) == 0 && player.hasKeyItem("Double barreled dragon gun") < 0 && rand(2) == 0) {
				partsofTripxiDoubleBarreledDragonGun();
				return;
			}
			//Volcanic Crag
			if (flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] <= 0 && (player.level + combat.playerLevelAdjustment()) >= 65) {
				flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] = 1;
				clearOutput();
				outputText("You walk for some time, roaming the ashlands. As you progress, you can feel the air getting warm. It gets hotter as you progress until you finally stumble across a blackened landscape. You reward yourself with a sight of the endless series of a volcanic landscape. Crags dot the landscape.\n\n");
				outputText("<b>You've discovered the Volcanic Crag!</b>");
				doNext(camp.returnToCampUseTwoHours);
				return;
			}
			
			select = choice[rand(choice.length)];
			switch(select) {
				case 0:
					if (flags[kFLAGS.HEL_PHOENIXES_DEFEATED] > 0) phoenixScene.encounterPhoenix(1);
					else {
						clearOutput();
						outputText("As you take a stroll, from behind nearby ash pile emerge huge golem. Looks like you have encountered 'true fire golem'! You ready your [weapon] for a fight!");
						startCombat(new GolemTrueFire());
					}
					break;
				case 1:
				//	wendigoScene.encounterWendigo();
				//	break;
				case 2: //Hellcat/Witches Sabbath
					if ((flags[kFLAGS.WITCHES_SABBATH] > 3 && player.hellcatScore() > 9 && player.gender == 3) || (flags[kFLAGS.WITCHES_SABBATH] > 0 && player.catScore() >= 8 && player.inte >= 40 && player.hasStatusEffect(StatusEffects.KnowsWhitefire))) SceneLib.ashlands.hellcatScene.WitchesSabbath();
					else SceneLib.ashlands.hellcatScene.HellCatIntro();
					break;
				case 3:	//Cinderbloom
					clearOutput();
					if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
						outputText("You can smell the thick scent of particularly strong pollen in the air. The book mentioned something about this but you don’t recall exactly what. Do you turn back to camp?\n\n");
						menu();
						addButton(0, "Yes", camp.returnToCampUseOneHour);
						addButton(1, "No", alrauneScene.alrauneVolcanicCrag);
					} else {
						alrauneScene.alrauneVolcanicCrag();
					}
					break;
				case 4: //True Fire Golem
					clearOutput();
					outputText("As you take a stroll, from behind nearby ash pile emerge huge golem. Looks like you have encountered 'true fire golem'! You ready your [weapon] for a fight!");
					startCombat(new GolemTrueFire());
					break;
				case 5: //Find Granite
					clearOutput();
                    outputText("You stumble across a vein of Granite, this looks like suitable material for your gargoyle form.\n");
                    outputText("Do you wish to mine it?");
                    menu();
                    addButton(0, "Yes", ahslandsSiteMine);
                    addButton(1, "No", camp.returnToCampUseOneHour);
					break;
				default:
					clearOutput();
					outputText("You spend one hour exploring ashlands but you don't manage to find anything interesting.");
					if (player.tou < 50){
						outputText("But on your way back you feel you're a little more used to traveling through this harsh area.");
						player.trainStat("tou", +1, 50);
					}
					dynStats("tou", .5);
					doNext(camp.returnToCampUseOneHour);
			}
		}
		
		public function partsofTripxiDoubleBarreledDragonGun():void {
			clearOutput();
			outputText("As you explore the ashlands you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Double barreled dragon gun in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Double barreled dragon gun", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function ahslandsSiteMine():void {
			if (Forgefather.materialsExplained != 1) doNext(camp.returnToCampUseOneHour);
			else {
				clearOutput();
				if (player.fatigue > player.maxFatigue() - 50) {
					outputText("\n\n<b>You are too tired to consider mining. Perhaps some rest will suffice?</b>");
					doNext(camp.returnToCampUseOneHour);
					return;
				}
				outputText("\n\nYou begin slamming your pickaxe against the granite, spending the better part of the next two hours mining. This done, you bring back your prize to camp. ");
				var minedStones:Number = 13 + Math.floor(player.str / 20);
				minedStones = Math.round(minedStones);
				fatigue(50, USEFATG_PHYSICAL);
				SceneLib.forgefatherScene.incrementGraniteSupply(minedStones);
				doNext(camp.returnToCampUseTwoHours);
			}
		}
	}
}