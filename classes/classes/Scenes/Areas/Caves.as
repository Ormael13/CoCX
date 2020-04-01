/**
 * @author Ormael
 * Area with lvl 35-60 enemies.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.Areas.Caves.*;
import classes.Scenes.Dungeons.EbonLabyrinth;
import classes.Scenes.Monsters.DarkElfScene;
import classes.Scenes.SceneLib;

use namespace CoC;
	
	public class Caves extends BaseContent
	{
		public var darkelfScene:DarkElfScene = new DarkElfScene();
		public var cavewyrmScene:CaveWyrmScene = new CaveWyrmScene();
		public var displacerbeastScene:DisplacerBeastScene = new DisplacerBeastScene();
		public var darkslimeScene:DarkSlimeScene = new DarkSlimeScene();
		public var dungeonEL:EbonLabyrinth = new EbonLabyrinth();
		
		public function Caves() 
		{
		}
		
		public function exploreCaves():void {
			flags[kFLAGS.DISCOVERED_CAVES]++;
			
			//Harpoon gun
			if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns5) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns5) == 0 && player.statusEffectv2(StatusEffects.TelAdreTripxi) == 1 && rand(2) == 0) {
				partsofTouhounaM3();
				return;
			}
			//Wild manticore/malicore
			if (flags[kFLAGS.ETNA_AFFECTION] >= 5 && rand(4) == 0) {
				player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
				if (rand(2) == 0) {
					player.createStatusEffect(StatusEffects.WildManticore, 0, 0, 0, 0);
					SceneLib.etnaScene.repeatEnc();
					return;
				}
				else {
					SceneLib.bashemathScene.repeatEncWM();
					return;
				}
			}
			//Ebon Labyrinth
			if (flags[kFLAGS.EBON_LABYRINTH] < 1 && rand(3) == 0) {
				dungeonEL.ebonlabyrinthdiscovery();
				return;
			}
			
			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0; //Cave Wyrm (lvl 35)
			//choice[choice.length] = 1; //Ant worker (lvl 41)
			choice[choice.length] = 1; //2Dark Elf Ranger (underground ver lvl 48)
			choice[choice.length] = 2; //3Dark Slime (lvl 54 lub 55)
			choice[choice.length] = 3; //4Displacer Beast (lvl 60)
			choice[choice.length] = 4; //5Ebonbloom
			choice[choice.length] = 5; //6Methir Crystal
			if (rand(4) == 0) choice[choice.length] = 6; //7Find nothing!
			
			select = choice[rand(choice.length)];
			switch(select) {
				case 0:
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					cavewyrmScene.berserkingCaveWyrmEncounter();
					break;/*
				case 1: && rand(4) == 0
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					//antworker.();
					clearOutput();
					outputText("You spend one hour exploring the caves but you don't manage to find anything interesting, unless feeling of becoming slight tougher counts
					dynStats("tou", .5);
					outputText("You spend one hour exploring the caves but you don't
					dynStats("tou", .5);
					clearOutput();
					outputText("You spend one hour exploring the caves but you don't manage to
					dynStats("tou", .5);
					doNext(camp.returnToCampUseOneHour);
					//clearOutput();
					//outputText("You spend one hour exploring the caves but you don't manage to find anything interesting, unless feeling of becoming slight tougher counts.");
					break;*/
				case 1://2:
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					darkelfScene.introDarkELfRangerCaves();
					break;
				case 2://3:
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					darkslimeScene.cavesDarkSlimeEncounter();
					break;
				case 3://4:
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					displacerbeastScene.displacerBeastEncounter();
					break;
				case 4://5
					clearOutput();
					outputText("You're exploring the vast cave system when you come across a small cavern. As you head further into the cavern you spot something glinting just up ahead. A small crack in the ceiling lets a sliver of light shine down on a dark metallic looking flower growing on top of a stone pillar. ");
					outputText("Your eyes widen in surprise when you recognize it to be a rare Ebonbloom. Seeing that nothing else is around, you make your way over to the flower then try to pluck it. It doesn't budge at first but with a little more effort you manage to pull the flower free. ");
					if (silly()) outputText("You suddenly hear dramatic music play as the cavern around you begins to cave in. You don your brown explorer's hat and whip as you make your way out of the collapsing cavern, dodging falling rocks in the process. By the skin of your teeth you escape from the cavern with your treasure in hand. ");
					inventory.takeItem(useables.EBONBLO, camp.returnToCampUseOneHour);
					break;
				case 5://6
					clearOutput();
					outputText("As you explore the cave, you run into a weird neon blue crystal that glow in the dark. You pack it in your backpack in case it could be sold for a decent amount"+(silly() ? ", perhaps to a drug dealer" : "")+". ");
					inventory.takeItem(consumables.METHIRC, camp.returnToCampUseOneHour);
					break;
				default:
					clearOutput();
					outputText("You spend one hour exploring the caves but you don't manage to find anything interesting, unless feeling of becoming slight tougher counts.");
					dynStats("tou", .5);
					doNext(camp.returnToCampUseOneHour);
			}
		}
		
		public function partsofTouhounaM3():void {
			clearOutput();
			outputText("As you explore the caves you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Touhouna M3 in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns5, 1, 1);
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Touhouna M3", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}
	}
}