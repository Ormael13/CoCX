package classes.Scenes.Areas.Lake
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class SwordInStone extends AbstractLakeContent
	{
		public function SwordInStone()
		{}

		public function findSwordInStone():void {
			clearOutput();
			if (flags[kFLAGS.FACTORY_SHUTDOWN] < 2) {
				//Encounter it!
				outputText("While walking along the lake, the glint of metal catches your eye.  You drop into a combat stance, readying your [weapon] for another fight.   Your eyes dart about, searching for the source of the light. You feel rather foolish when you locate the source of the reflection.  It came from a sword lodged hilt-deep in the trunk of a tree.  You relax a bit, approaching the odd sight to get a better look.\n\n");
				//Describe it!
				outputText("The tree is thick enough to encapsulate the entire blade.  Nothing protrudes from the far side at all.  In another odd twist, there is not any sap leaking around the undamaged bark that surrounds the sword.  The hilt itself appears made of bronze, with gold inlays along the outside of the handguard.  Looking closer, you realize they portray a stylized figure battling a horde of demons.  The handle is wrapped tightly with rugged leather that still looks brand new in spite of how long this sword must have been here for the tree to grow so thoroughly around it.\n\n");
				outputText("You suppose you could try to pull it free, do you?");
				doYesNo(tryToTakeSwordInStone,camp.returnToCampUseOneHour);
			}
			else {
				outputText("While walking along the lake, a massive tree catches your eye.  You carefully circle some bushes, wary of an ambush as you get closer.   As you close the distance, it becomes clear the tree is terribly corrupt.  It weeps black sap from gnashing mouths and clenching distorting twats.  The very center of the tree has a massive knot, as if it had sustained a massive injury there.  You decide to avoid it, given the hungry-looking nature of its mouths, but before you depart you spot the pieces of a broken sword scattered around the trunk, completely covered in rust.");
				doNext(camp.returnToCampUseOneHour);
				player.createStatusEffect(StatusEffects.BSwordBroken,0,0,0,0);
			}
		}
		private function tryToTakeSwordInStone():void {
			clearOutput();
			//if corrupted...
			if (player.cor >= 25) {
				outputText("You grip the handle with both hands and ");
				if (player.str > 70) outputText("pull mightily, making the tree strain and groan from the force, ");
				if (player.str <= 70 && player.str >= 40) outputText("pull hard, feeling your muscles tighten from the strain, ");
				if (player.str < 40) outputText("pull as hard as you can, ");
				outputText("but the sword remains stubbornly lodged in its arboreal home.  Frustrated, you give up and resolve to try later.");
				doNext(camp.returnToCampUseOneHour);
			}
			//If not corrupted...
			else {
				outputText("You grip the handle with both hands and ");
				if (player.str > 70) outputText("pull so hard you fall on your ass when the sword slips free.  The tip buries itself a few inches from your head.  You count yourself lucky and stand up.  ");
				if (player.str <= 70 && player.str >= 40) outputText("give a mighty pull and nearly fall over as the sword easily slides free from the tree.  ");
				if (player.str < 40) outputText("easily pull the sword free, surprising yourself with how easy it was to remove.  ");
				outputText("Remarkably the tree's trunk is entirely intact.  While marveling at this new development, a leaf brushes your shoulder.  You look up and watch as every single leaf turns from healthy green, to brilliant orange, and finally changes to brown.  The leaves rain down around you, covering the ground in dead plant-matter, leaving you alone with the withering skeleton of a dead tree.  The sight saddens you, though you cannot fathom why.\n\n");
				outputText("The blade itself is three and a half feet of the purest, shining steel you have ever seen.  It truly is a beautiful blade.\n\n");
				dynStats("lib", -(player.lib/3), "lus", -15);
				inventory.takeItem(weapons.B_SWORD, camp.returnToCampUseOneHour);
				player.createStatusEffect(StatusEffects.TookBlessedSword,0,0,0,0);
			}
		}
		
		public function findBowInStone():void {
			clearOutput();
			if (flags[kFLAGS.FACTORY_SHUTDOWN] < 2) {
				//Encounter it!
				outputText("While walking along the lake, the glint of metal catches your eye.  You drop into a combat stance, readying your [weapon] for another fight.   Your eyes dart about, searching for the source of the light. You feel rather foolish when you locate the source of the reflection.  It came from a bow embeded in trunk of a tree.  You relax a bit, approaching the odd sight to get a better look.\n\n");
				//Describe it!
				outputText("The tree is thick enough to encapsulate the entire handle.  In another odd twist, there is not any sap leaking around the undamaged bark that surrounds the bow.  The handle itself appears made of bronze, with gold inlays along the outside of the handle.  Looking closer, you realize they portray a stylized figure battling a horde of demons.  The handle is wrapped tightly with rugged leather that still looks brand new in spite of how long this bow must have been here for the tree to grow so thoroughly around it.\n\n");
				outputText("You suppose you could try to pull it free, do you?");
				doYesNo(tryToTakeBowInStone,camp.returnToCampUseOneHour);
			}
			else {
				outputText("While walking along the lake, a massive tree catches your eye.  You carefully circle some bushes, wary of an ambush as you get closer.   As you close the distance, it becomes clear the tree is terribly corrupt.  It weeps black sap from gnashing mouths and clenching distorting twats.  The very center of the tree has a massive knot, as if it had sustained a massive injury there.  You decide to avoid it, given the hungry-looking nature of its mouths, but before you depart you spot the pieces of a broken bow scattered around the trunk, completely covered in rust.");
				doNext(camp.returnToCampUseOneHour);
				player.createStatusEffect(StatusEffects.BBowBroken,0,0,0,0);
			}
		}
		private function tryToTakeBowInStone():void {
			clearOutput();
			//if corrupted...
			if (player.cor >= 25) {
				outputText("You grip the handle with both hands and ");
				if (player.str > 70) outputText("pull mightily, making the tree strain and groan from the force, ");
				if (player.str <= 70 && player.str >= 40) outputText("pull hard, feeling your muscles tighten from the strain, ");
				if (player.str < 40) outputText("pull as hard as you can, ");
				outputText("but the bow remains stubbornly lodged in its arboreal home.  Frustrated, you give up and resolve to try later.");
				doNext(camp.returnToCampUseOneHour);
			}
			//If not corrupted...
			else {
				outputText("You grip the handle with both hands and ");
				if (player.str > 70) outputText("pull so hard you fall on your ass when the bow slips free.  One of it sharp tips buries itself a few inches from your head.  You count yourself lucky and stand up.  ");
				if (player.str <= 70 && player.str >= 40) outputText("give a mighty pull and nearly fall over as the bow easily slides free from the tree.  ");
				if (player.str < 40) outputText("easily pull the bow free, surprising yourself with how easy it was to remove.  ");
				outputText("Remarkably the tree's trunk is entirely intact.  While marveling at this new development, a leaf brushes your shoulder.  You look up and watch as every single leaf turns from healthy green, to brilliant orange, and finally changes to brown.  The leaves rain down around you, covering the ground in dead plant-matter, leaving you alone with the withering skeleton of a dead tree.  The sight saddens you, though you cannot fathom why.\n\n");
				outputText("The bow itself is three and a half feet of the purest, wood you have ever seen.  It truly is a beautiful bow.\n\n");
				dynStats("lib", -(player.lib/3), "lus", -15);
				inventory.takeItem(weaponsrange.BEA_BOW, camp.returnToCampUseOneHour);
				player.createStatusEffect(StatusEffects.TookBlessedBow,0,0,0,0);
			}
		}
		
		public function findStaffInStone():void {
			clearOutput();
			if (flags[kFLAGS.FACTORY_SHUTDOWN] < 2) {
				//Encounter it!
				outputText("While walking along the lake, the glint of metal catches your eye.  You drop into a combat stance, readying your [weapon] for another fight.   Your eyes dart about, searching for the source of the light. You feel rather foolish when you locate the source of the reflection.  It came from a staff lodged halfway in the trunk of a tree.  You relax a bit, approaching the odd sight to get a better look.\n\n");
				//Describe it!
				outputText("The tree is thick enough to encapsulate the entire shaft.  Nothing protrudes from the far side at all.  In another odd twist, there is not any sap leaking around the undamaged bark that surrounds the staff.  The hilt itself appears made of bronze, with gold inlays along the outside of the handguard.  Looking closer, you realize they portray a stylized figure battling a horde of demons.  The handle is wrapped tightly with rugged leather that still looks brand new in spite of how long this staff must have been here for the tree to grow so thoroughly around it.\n\n");
				outputText("You suppose you could try to pull it free, do you?");
				doYesNo(tryToTakeStaffInStone,camp.returnToCampUseOneHour);
			}
			else {
				outputText("While walking along the lake, a massive tree catches your eye.  You carefully circle some bushes, wary of an ambush as you get closer.   As you close the distance, it becomes clear the tree is terribly corrupt.  It weeps black sap from gnashing mouths and clenching distorting twats.  The very center of the tree has a massive knot, as if it had sustained a massive injury there.  You decide to avoid it, given the hungry-looking nature of its mouths, but before you depart you spot the pieces of a broken staff scattered around the trunk, completely covered in rust.");
				doNext(camp.returnToCampUseOneHour);
				player.createStatusEffect(StatusEffects.BStaffBroken,0,0,0,0);
			}
		}
		private function tryToTakeStaffInStone():void {
			clearOutput();
			//if corrupted...
			if (player.cor >= 25) {
				outputText("You grip the handle with both hands and ");
				if (player.str > 70) outputText("pull mightily, making the tree strain and groan from the force, ");
				if (player.str <= 70 && player.str >= 40) outputText("pull hard, feeling your muscles tighten from the strain, ");
				if (player.str < 40) outputText("pull as hard as you can, ");
				outputText("but the staff remains stubbornly lodged in its arboreal home.  Frustrated, you give up and resolve to try later.");
				doNext(camp.returnToCampUseOneHour);
			}
			//If not corrupted...
			else {
				outputText("You grip the handle with both hands and ");
				if (player.str > 70) outputText("pull so hard you fall on your ass when the staff slips free.  The tip buries itself a few inches from your head.  You count yourself lucky and stand up.  ");
				if (player.str <= 70 && player.str >= 40) outputText("give a mighty pull and nearly fall over as the staff easily slides free from the tree.  ");
				if (player.str < 40) outputText("easily pull the staff free, surprising yourself with how easy it was to remove.  ");
				outputText("Remarkably the tree's trunk is entirely intact.  While marveling at this new development, a leaf brushes your shoulder.  You look up and watch as every single leaf turns from healthy green, to brilliant orange, and finally changes to brown.  The leaves rain down around you, covering the ground in dead plant-matter, leaving you alone with the withering skeleton of a dead tree.  The sight saddens you, though you cannot fathom why.\n\n");
				outputText("The staff itself is four and a half feet of the purest, shining steel you have ever seen.  It truly is a beautiful staff.\n\n");
				dynStats("lib", -(player.lib/3), "lus", -15);
				inventory.takeItem(weapons.B_STAFF, camp.returnToCampUseOneHour);
				player.createStatusEffect(StatusEffects.TookBlessedStaff,0,0,0,0);
			}
		}
		
		public function findShieldInStone():void {
			clearOutput();
			if (flags[kFLAGS.FACTORY_SHUTDOWN] < 2) {
				//Encounter it!
				outputText("While walking along the lake, the glint of metal catches your eye.  You drop into a combat stance, readying your [weapon] for another fight.   Your eyes dart about, searching for the source of the light. You feel rather foolish when you locate the source of the reflection.  It came from a shield embeded halfway in trunk of a tree.  You relax a bit, approaching the odd sight to get a better look.\n\n");
				//Describe it!
				outputText("The tree is thick enough to encapsulate half of the shield disc.  Nothing protrudes from the far side at all.  In another odd twist, there is not any sap leaking around the undamaged bark that surrounds the shield.  The outer layer itself appears made of bronze, with gold inlays along the edges.  Looking closer, you realize they portray a stylized figure battling a horde of demons.  The handle is wrapped tightly with rugged leather that still looks brand new in spite of how long this shield must have been here for the tree to grow so thoroughly around it.\n\n");
				outputText("You suppose you could try to pull it free, do you?");
				doYesNo(tryToTakeShieldInStone,camp.returnToCampUseOneHour);
			}
			else {
				outputText("While walking along the lake, a massive tree catches your eye.  You carefully circle some bushes, wary of an ambush as you get closer.   As you close the distance, it becomes clear the tree is terribly corrupt.  It weeps black sap from gnashing mouths and clenching distorting twats.  The very center of the tree has a massive knot, as if it had sustained a massive injury there.  You decide to avoid it, given the hungry-looking nature of its mouths, but before you depart you spot the pieces of a broken shield scattered around the trunk, completely covered in rust.");
				doNext(camp.returnToCampUseOneHour);
				player.createStatusEffect(StatusEffects.BShieldBroken,0,0,0,0);
			}
		}
		private function tryToTakeShieldInStone():void {
			clearOutput();
			//if corrupted...
			if (player.cor >= 25) {
				outputText("You grip the shield with both hands and ");
				if (player.str > 70) outputText("pull mightily, making the tree strain and groan from the force, ");
				if (player.str <= 70 && player.str >= 40) outputText("pull hard, feeling your muscles tighten from the strain, ");
				if (player.str < 40) outputText("pull as hard as you can, ");
				outputText("but the shield remains stubbornly lodged in its arboreal home.  Frustrated, you give up and resolve to try later.");
				doNext(camp.returnToCampUseOneHour);
			}
			//If not corrupted...
			else {
				outputText("You grip the shield with both hands and ");
				if (player.str > 70) outputText("pull so hard you fall on your ass when the shield slips free.  The edge buries itself a few inches from your head.  You count yourself lucky and stand up.  ");
				if (player.str <= 70 && player.str >= 40) outputText("give a mighty pull and nearly fall over as the shield easily slides free from the tree.  ");
				if (player.str < 40) outputText("easily pull the shield free, surprising yourself with how easy it was to remove.  ");
				outputText("Remarkably the tree's trunk is entirely intact.  While marveling at this new development, a leaf brushes your shoulder.  You look up and watch as every single leaf turns from healthy green, to brilliant orange, and finally changes to brown.  The leaves rain down around you, covering the ground in dead plant-matter, leaving you alone with the withering skeleton of a dead tree.  The sight saddens you, though you cannot fathom why.\n\n");
				outputText("The shield itself is made from purest, shining steel you have ever seen.  It truly is a beautiful shield.\n\n");
				dynStats("lib", -(player.lib/3), "lus", -15);
				inventory.takeItem(shields.BSHIELD, camp.returnToCampUseOneHour);
				player.createStatusEffect(StatusEffects.TookBlessedShield,0,0,0,0);
			}
		}
	}
}