package classes.Scenes.Areas.Lake
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class SwordInStone extends AbstractLakeContent
	{
		public function SwordInStone()
		{
		}

		public function findSwordInStone():void 
		{
			if (flags[kFLAGS.FACTORY_SHUTDOWN] < 2)
			{
				//Encounter it!
				outputText("While walking along the lake, the glint of metal catches your eye.  You drop into a combat stance, readying your " + player.weaponName + " for another fight.   Your eyes dart about, searching for the source of the light. You feel rather foolish when you locate the source of the reflection.  It came from a sword lodged hilt-deep in the trunk of a tree.  You relax a bit, approaching the odd sight to get a better look.\n\n", true);
				
				//Describe it!
				outputText("The tree is thick enough to encapsulate the entire blade.  Nothing protrudes from the far side at all.  In another odd twist, there is not any sap leaking around the undamaged bark that surrounds the sword.  The hilt itself appears made of bronze, with gold inlays along the outside of the handguard.  Looking closer, you realize they portray a stylized figure battling a horde of demons.  The handle is wrapped tightly with rugged leather that still looks brand new in spite of how long this sword must have been here for the tree to grow so thoroughly around it.\n\n", false);
			
				outputText("You suppose you could try to pull it free, do you?", false);
			
				doYesNo(tryToTakeSwordInStone,camp.returnToCampUseOneHour);
			}
			else 
			{
				outputText("While walking along the lake, a massive tree catches your eye.  You carefully circle some bushes, wary of an ambush as you get closer.   As you close the distance, it becomes clear the tree is terribly corrupt.  It weeps black sap from gnashing mouths and clenching distorting twats.  The very center of the tree has a massive knot, as if it had sustained a massive injury there.  You decide to avoid it, given the hungry-looking nature of its mouths, but before you depart you spot the pieces of a broken sword scattered around the trunk, completely covered in rust.", true);
				
				doNext(camp.returnToCampUseOneHour);
				
				player.createStatusEffect(StatusEffects.BSwordBroken,0,0,0,0);
			}
		}

		private function tryToTakeSwordInStone():void 
		{
			clearOutput();
			//if corrupted...
			if (player.cor >= 25) 
			{
				outputText("You grip the handle with both hands and ", false);
				
				if (player.str > 70) outputText("pull mightily, making the tree strain and groan from the force, ", false);
				if (player.str <= 70 && player.str >= 40) outputText("pull hard, feeling your muscles tighten from the strain, ", false);
				if (player.str < 40) outputText("pull as hard as you can, ", false);
				
				outputText("but the sword remains stubbornly lodged in its arboreal home.  Frustrated, you give up and resolve to try later.", false);
				
				doNext(camp.returnToCampUseOneHour);
			}
			//If not corrupted...
			else 
			{
				outputText("You grip the handle with both hands and ", false);
			
				if (player.str > 70) outputText("pull so hard you fall on your ass when the sword slips free.  The tip buries itself a few inches from your head.  You count yourself lucky and stand up.  ", false);
				if (player.str <= 70 && player.str >= 40) outputText("give a mighty pull and nearly fall over as the sword easily slides free from the tree.  ", false);
				if (player.str < 40) outputText("easily pull the sword free, surprising yourself with how easy it was to remove.  ", false);
				
				outputText("Remarkably the tree's trunk is entirely intact.  While marveling at this new development, a leaf brushes your shoulder.  You look up and watch as every single leaf turns from healthy green, to brilliant orange, and finally changes to brown.  The leaves rain down around you, covering the ground in dead plant-matter, leaving you alone with the withering skeleton of a dead tree.  The sight saddens you, though you cannot fathom why.\n\n", false);
			
				outputText("The blade itself is three and a half feet of the purest, shining steel you have ever seen.  It truly is a beautiful blade.\n\n", false);
				dynStats("lib", -(player.lib/3), "lus", -15);
				inventory.takeItem(weapons.B_SWORD, camp.returnToCampUseOneHour);
				player.createStatusEffect(StatusEffects.TookBlessedSword,0,0,0,0);
			}
		}
	}
}