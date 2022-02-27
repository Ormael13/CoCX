/**
 * @author Ormael
 * Area with lvl 40-55 enemies.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Forest.AlrauneScene;
import classes.Scenes.Areas.Tundra.*;
import classes.Scenes.NPCs.Forgefather;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class Tundra extends BaseContent
	{
		public var valkyrieScene:ValkyrieScene = new ValkyrieScene();
		public var alrauneScene:AlrauneScene = new AlrauneScene();
		
		public function Tundra() 
		{
		}
		
		public function exploreTundra():void {
			flags[kFLAGS.DISCOVERED_TUNDRA]++;
			doNext(playerMenu);
			
			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0; //Valkyrie (lvl 44)
			choice[choice.length] = 1; //?? (lvl 52)
			choice[choice.length] = 2; //Young Frost Giant (lvl 47)
			choice[choice.length] = 3; //Snow Lily (lvl 40)
			choice[choice.length] = 4; //Ice Golem (lvl 64)
            if (player.hasKeyItem("Old Pickaxe") > 0 && Forgefather.materialsExplained)
			    choice[choice.length] = 5; //Find Alabaster
            if (rand(4) == 0)
			    choice[choice.length] = 6; //Find nothing!
			
			//Glacial Rift
			if (flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] <= 0 && (player.level + combat.playerLevelAdjustment()) >= 65) {
				flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] = 1;
				clearOutput();
				outputText("You walk for some time, roaming the tundra. As you progress, a cool breeze suddenly brushes your cheek, steadily increasing in intensity and power until your clothes are whipping around your body in a frenzy. Every gust of wind seems to steal away part of your strength, the cool breeze having transformed into a veritable arctic gale. ");
				outputText("You wrap your arms around yourself tightly, shivering fiercely despite yourself as the dirt slowly turns to white; soon you’re crunching through actual snow, thick enough to make you stumble with every other step. You come to a stop suddenly as the ground before you gives way to a grand ocean, many parts of it frozen in great crystal islands larger than any city.\n\n");
				outputText("<b>You've discovered the Glacial Rift!</b>");
				doNext(camp.returnToCampUseTwoHours);
				return;
			}
			
			select = choice[rand(choice.length)];
			switch(select) {
				case 0:
					clearOutput();
					outputText("Making your way across the tundra, you’re surprised to see the thick gray clouds part overhead.  You see a beautiful woman descend from on high, her snow-white wings flapping powerfully behind her back.  Armed with a long spear and shield, and clad in a bronze cuirass and a winged helm, she looks every bit the part of a mighty warrior.\n\n");
					outputText("She touches down gently a few feet before you, her shield and spear raised.  \"<i>You seem a worthy sort to test my skills against, wanderer.  Prepare yourself!</i>\" she shouts, bearing down on you.  She doesn’t look like she’s going to back down -- you ready your [weapon] for a fight!");
					startCombat(new Valkyrie());
					break;
				case 1:
				//	wendigoScene.encounterWendigo();
				//	break;
				case 2: //Young Frost Giant
					clearOutput();
					outputText("You wander the chilling landscape of the Tundra. As you cross the peak of a rather large, lightly forested hill, you come face to gigantic face with a Young Frost Giant! He belches fiercely at you and you tumble back down the hill. He mostly steps over it as you come to your senses. You quickly draw your [weapon] and withdraw from the hill to prepare for battle.\n\n");
					startCombat(new YoungFrostGiant());
					break;
				case 3:	//Snow Lily
					clearOutput();
					if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
						outputText("You can smell the thick scent of particularly strong pollen in the air. The book mentioned something about this but you don’t recall exactly what. Do you turn back to camp?\n\n");
						menu();
						addButton(0, "Yes", camp.returnToCampUseOneHour);
						addButton(1, "No", alrauneScene.alrauneGlacialRift);
					} else {
						alrauneScene.alrauneGlacialRift();
					}
					break;
				case 4: //True Ice Golems
					clearOutput();
					outputText("As you take a stroll, from nearby trees emerge huge golem. Looks like you have encountered 'true ice golem'! You ready your [weapon] for a fight!");
					startCombat(new GolemTrueIce());
					break;
				case 5: //Alabaster
					clearOutput();
                    outputText("You stumble across a vein of Alabaster, this looks like suitable material for your gargoyle form.\n");
                    outputText("Do you wish to mine it?");
                    menu();
                    addButton(0, "Yes", tundraSiteMine);
                    addButton(1, "No", camp.returnToCampUseOneHour);
					break;
				default:
					clearOutput();
					outputText("You spend one hour exploring tundra but you don't manage to find anything interesting.");
					if (player.tou < 50){
						outputText("But on your way back you feel you're a little more used to traveling through this harsh area.");
						player.trainStat("tou", +1, 50);
					}
					dynStats("tou", .5);
					doNext(camp.returnToCampUseOneHour);
			}
		}	

		private function tundraSiteMine():void {
			if (Forgefather.materialsExplained != 1) doNext(camp.returnToCampUseOneHour);
			else {
				clearOutput();
				if (player.fatigue > player.maxFatigue() - 50) {
					outputText("\n\n<b>You are too tired to consider mining. Perhaps some rest will suffice?</b>");
					doNext(camp.returnToCampUseOneHour);
					return;
				}
				outputText("\n\nYou begin slamming your pickaxe against the alabaster, spending the better part of the next two hours mining. This done, you bring back your prize to camp. ");
				var minedStones:Number = 13 + Math.floor(player.str / 20);
				minedStones = Math.round(minedStones);
				fatigue(50, USEFATG_PHYSICAL);
				SceneLib.forgefatherScene.incrementAlabasterSupply(minedStones);
				doNext(camp.returnToCampUseTwoHours);
			}
		}
	}
}