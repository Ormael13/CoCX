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
			
			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0; //Cave Wyrm (lvl 35)
			//choice[choice.length] = 1; //Ant worker (lvl 41)
			choice[choice.length] = 1; //2Dark Elf Ranger (underground ver lvl 48)
			choice[choice.length] = 2; //3Dark Slime (lvl 54 lub 55)
			choice[choice.length] = 3; //4Displacer Beast (lvl 60)
			//choice[choice.length] = 5; //Ebonbloom
			choice[choice.length] = 4; //6Methir Crystal
			if (rand(4) == 0) choice[choice.length] = 5; //7Find nothing!
			
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
					break;/*
				case 5:
					clearOutput();
					outputText("You spot something on the ground. Taking a closer look, it's one of those imps food packages. ");
					inventory.takeItem(useables.EBONBLO, camp.returnToCampUseOneHour);
					outputText("You spend one hour exploring the caves but you don't manage to find anything interesting, unless feeling of becoming slight tougher counts.");
					dynStats("tou", .5);
					doNext(camp.returnToCampUseOneHour);
					break;*/
				case 4://6
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
	}
}