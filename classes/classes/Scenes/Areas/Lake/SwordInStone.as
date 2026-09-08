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
				doYesNo(tryToTakeSwordInStone,explorer.done);
			}
			else {
				outputText("While walking along the lake, a massive tree catches your eye.  You carefully circle some bushes, wary of an ambush as you get closer.   As you close the distance, it becomes clear the tree is terribly corrupt.  It weeps black sap from gnashing mouths and clenching distorting twats.  The very center of the tree has a massive knot, as if it had sustained a massive injury there.  You decide to avoid it, given the hungry-looking nature of its mouths, but before you depart you spot the pieces of a broken sword scattered around the trunk, completely covered in rust.");
				endEncounter();
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
				endEncounter();
			}
			//If not corrupted...
			else {
				outputText("You grip the handle with both hands and ");
				if (player.str > 70) outputText("pull so hard you fall on your ass when the sword slips free.  The tip buries itself a few inches from your head.  You count yourself lucky and stand up.  ");
				if (player.str <= 70 && player.str >= 40) outputText("give a mighty pull and nearly fall over as the sword easily slides free from the tree.  ");
				if (player.str < 40) outputText("easily pull the sword free, surprising yourself with how easy it was to remove.  ");
				outputText("Remarkably the tree's trunk is entirely intact.  While marveling at this new development, a leaf brushes your shoulder.  You look up and watch as every single leaf turns from healthy green, to brilliant orange, and finally changes to brown.  The leaves rain down around you, covering the ground in dead plant-matter, leaving you alone with the withering skeleton of a dead tree.  The sight saddens you, though you cannot fathom why.\n\n");
				outputText("The blade itself is three and a half feet of the purest, shining steel you have ever seen.  It truly is a beautiful blade.\n\n");
				dynStats("lus", -15, "scale", false);
				inventory.takeItem(weapons.B_SWORD, explorer.done);
				if (player.hasStatusEffect(StatusEffects.BlessedItemAtTheLake)) player.addStatusValue(StatusEffects.BlessedItemAtTheLake, 1 , 1);
				else player.createStatusEffect(StatusEffects.BlessedItemAtTheLake, 1, 0, 0, 0);
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
				doYesNo(tryToTakeBowInStone,explorer.done);
			}
			else {
				outputText("While walking along the lake, a massive tree catches your eye.  You carefully circle some bushes, wary of an ambush as you get closer.   As you close the distance, it becomes clear the tree is terribly corrupt.  It weeps black sap from gnashing mouths and clenching distorting twats.  The very center of the tree has a massive knot, as if it had sustained a massive injury there.  You decide to avoid it, given the hungry-looking nature of its mouths, but before you depart you spot the pieces of a broken bow scattered around the trunk, completely covered in rust.");
				endEncounter();
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
				endEncounter();
			}
			//If not corrupted...
			else {
				outputText("You grip the handle with both hands and ");
				if (player.str > 70) outputText("pull so hard you fall on your ass when the bow slips free.  One of it sharp tips buries itself a few inches from your head.  You count yourself lucky and stand up.  ");
				if (player.str <= 70 && player.str >= 40) outputText("give a mighty pull and nearly fall over as the bow easily slides free from the tree.  ");
				if (player.str < 40) outputText("easily pull the bow free, surprising yourself with how easy it was to remove.  ");
				outputText("Remarkably the tree's trunk is entirely intact.  While marveling at this new development, a leaf brushes your shoulder.  You look up and watch as every single leaf turns from healthy green, to brilliant orange, and finally changes to brown.  The leaves rain down around you, covering the ground in dead plant-matter, leaving you alone with the withering skeleton of a dead tree.  The sight saddens you, though you cannot fathom why.\n\n");
				outputText("The bow itself is three and a half feet of the purest, wood you have ever seen.  It truly is a beautiful bow.\n\n");
				dynStats("lus", -15, "scale", false);
				inventory.takeItem(weaponsrange.BEA_BOW, explorer.done);
				if (player.hasStatusEffect(StatusEffects.BlessedItemAtTheLake)) player.addStatusValue(StatusEffects.BlessedItemAtTheLake, 1 , 1);
				else player.createStatusEffect(StatusEffects.BlessedItemAtTheLake, 1, 0, 0, 0);
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
				doYesNo(tryToTakeStaffInStone,explorer.done);
			}
			else {
				outputText("While walking along the lake, a massive tree catches your eye.  You carefully circle some bushes, wary of an ambush as you get closer.   As you close the distance, it becomes clear the tree is terribly corrupt.  It weeps black sap from gnashing mouths and clenching distorting twats.  The very center of the tree has a massive knot, as if it had sustained a massive injury there.  You decide to avoid it, given the hungry-looking nature of its mouths, but before you depart you spot the pieces of a broken staff scattered around the trunk, completely covered in rust.");
				endEncounter();
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
				endEncounter();
			}
			//If not corrupted...
			else {
				outputText("You grip the handle with both hands and ");
				if (player.str > 70) outputText("pull so hard you fall on your ass when the staff slips free.  The tip buries itself a few inches from your head.  You count yourself lucky and stand up.  ");
				if (player.str <= 70 && player.str >= 40) outputText("give a mighty pull and nearly fall over as the staff easily slides free from the tree.  ");
				if (player.str < 40) outputText("easily pull the staff free, surprising yourself with how easy it was to remove.  ");
				outputText("Remarkably the tree's trunk is entirely intact.  While marveling at this new development, a leaf brushes your shoulder.  You look up and watch as every single leaf turns from healthy green, to brilliant orange, and finally changes to brown.  The leaves rain down around you, covering the ground in dead plant-matter, leaving you alone with the withering skeleton of a dead tree.  The sight saddens you, though you cannot fathom why.\n\n");
				outputText("The staff itself is four and a half feet of the purest, shining steel you have ever seen.  It truly is a beautiful staff.\n\n");
				dynStats("lus", -15, "scale", false);
				inventory.takeItem(weapons.B_STAFF, explorer.done);
				if (player.hasStatusEffect(StatusEffects.BlessedItemAtTheLake)) player.addStatusValue(StatusEffects.BlessedItemAtTheLake, 1 , 1);
				else player.createStatusEffect(StatusEffects.BlessedItemAtTheLake, 1, 0, 0, 0);
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
				doYesNo(tryToTakeShieldInStone,explorer.done);
			}
			else {
				outputText("While walking along the lake, a massive tree catches your eye.  You carefully circle some bushes, wary of an ambush as you get closer.   As you close the distance, it becomes clear the tree is terribly corrupt.  It weeps black sap from gnashing mouths and clenching distorting twats.  The very center of the tree has a massive knot, as if it had sustained a massive injury there.  You decide to avoid it, given the hungry-looking nature of its mouths, but before you depart you spot the pieces of a broken shield scattered around the trunk, completely covered in rust.");
				endEncounter();
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
				endEncounter();
			}
			//If not corrupted...
			else {
				outputText("You grip the shield with both hands and ");
				if (player.str > 70) outputText("pull so hard you fall on your ass when the shield slips free.  The edge buries itself a few inches from your head.  You count yourself lucky and stand up.  ");
				if (player.str <= 70 && player.str >= 40) outputText("give a mighty pull and nearly fall over as the shield easily slides free from the tree.  ");
				if (player.str < 40) outputText("easily pull the shield free, surprising yourself with how easy it was to remove.  ");
				outputText("Remarkably the tree's trunk is entirely intact.  While marveling at this new development, a leaf brushes your shoulder.  You look up and watch as every single leaf turns from healthy green, to brilliant orange, and finally changes to brown.  The leaves rain down around you, covering the ground in dead plant-matter, leaving you alone with the withering skeleton of a dead tree.  The sight saddens you, though you cannot fathom why.\n\n");
				outputText("The shield itself is made from purest, shining steel you have ever seen.  It truly is a beautiful shield.\n\n");
				dynStats("lus", -15, "scale", false);
				inventory.takeItem(shields.BSHIELD, explorer.done);
				if (player.hasStatusEffect(StatusEffects.BlessedItemAtTheLake)) player.addStatusValue(StatusEffects.BlessedItemAtTheLake, 1 , 1);
				else player.createStatusEffect(StatusEffects.BlessedItemAtTheLake, 1, 0, 0, 0);
				player.createStatusEffect(StatusEffects.TookBlessedShield,0,0,0,0);
			}
		}
		
		public function findWhipInStone():void {
			clearOutput();
			if (flags[kFLAGS.FACTORY_SHUTDOWN] < 2) {
				//Encounter it!
				outputText("While walking along the lake, the glint of metal catches your eye.  You drop into a combat stance, readying your [weapon] for another fight.   Your eyes dart about, searching for the source of the light. You feel rather foolish when you locate the source of the reflection.  It came from a whip lodged halfway in the trunk of a tree.  You relax a bit, approaching the odd sight to get a better look.\n\n");
				//Describe it!
				outputText("The tree is thick enough to encapsulate the entire thong.  Nothing protrudes from the far side at all.  In another odd twist, there is not any sap leaking around the undamaged bark that surrounds the whip.  The handle itself appears made of bronze, with gold inlays along the outside of the handguard.  Looking closer, you realize they portray a stylized figure battling a horde of demons.  The handle is wrapped tightly with rugged leather that still looks brand new in spite of how long this whip must have been here for the tree to grow so thoroughly around it.\n\n");
				outputText("You suppose you could try to pull it free, do you?");
				doYesNo(tryToTakeWhipInStone,explorer.done);
			}
			else {
				outputText("While walking along the lake, a massive tree catches your eye.  You carefully circle some bushes, wary of an ambush as you get closer.   As you close the distance, it becomes clear the tree is terribly corrupt.  It weeps black sap from gnashing mouths and clenching distorting twats.  The very center of the tree has a massive knot, as if it had sustained a massive injury there.  You decide to avoid it, given the hungry-looking nature of its mouths, but before you depart you spot the pieces of a broken whip scattered around the trunk, completely covered in rust.");
				endEncounter();
				player.createStatusEffect(StatusEffects.BWhipBroken,0,0,0,0);
			}
		}
		private function tryToTakeWhipInStone():void {
			clearOutput();
			//if corrupted...
			if (player.cor >= 25) {
				outputText("You grip the whip with both hands and ");
				if (player.str > 70) outputText("pull mightily, making the tree strain and groan from the force, ");
				if (player.str <= 70 && player.str >= 40) outputText("pull hard, feeling your muscles tighten from the strain, ");
				if (player.str < 40) outputText("pull as hard as you can, ");
				outputText("but the whip remains stubbornly lodged in its arboreal home.  Frustrated, you give up and resolve to try later.");
				endEncounter();
			}
			//If not corrupted...
			else {
				outputText("You grip the whip with both hands and ");
				if (player.str > 70) outputText("pull so hard you fall on your ass when the whip slips free.  The fall buries itself a few inches from your head.  You count yourself lucky and stand up.  ");
				if (player.str <= 70 && player.str >= 40) outputText("give a mighty pull and nearly fall over as the whip easily slides free from the tree.  ");
				if (player.str < 40) outputText("easily pull the whip free, surprising yourself with how easy it was to remove.  ");
				outputText("Remarkably the tree's trunk is entirely intact.  While marveling at this new development, a leaf brushes your shoulder.  You look up and watch as every single leaf turns from healthy green, to brilliant orange, and finally changes to brown.  The leaves rain down around you, covering the ground in dead plant-matter, leaving you alone with the withering skeleton of a dead tree.  The sight saddens you, though you cannot fathom why.\n\n");
				outputText("The whip itself is made from purest, shining leather you have ever seen.  It truly is a beautiful whip.\n\n");
				dynStats("lus", -15, "scale", false);
				inventory.takeItem(weapons.B_WHIP, explorer.done);
				if (player.hasStatusEffect(StatusEffects.BlessedItemAtTheLake)) player.addStatusValue(StatusEffects.BlessedItemAtTheLake, 1 , 1);
				else player.createStatusEffect(StatusEffects.BlessedItemAtTheLake, 1, 0, 0, 0);
				player.createStatusEffect(StatusEffects.TookBlessedWhip,0,0,0,0);
			}
		}

		public function findFlyWhiskInStone():void {
			clearOutput();
			if (flags[kFLAGS.FACTORY_SHUTDOWN] < 2) {
				//Encounter it!
				outputText("While walking along the lake, the glint of metal catches your eye.  You drop into a combat stance, readying your [weapon] for another fight.   Your eyes dart about, searching for the source of the light. You feel rather foolish when you locate the source of the reflection.  It came from a fly-whisk lodged halfway in the trunk of a tree.  You relax a bit, approaching the odd sight to get a better look.\n\n");
				//Describe it!
				outputText("The tree is thick enough to encapsulate the entire thong.  Nothing protrudes from the far side at all.  In another odd twist, there is not any sap leaking around the undamaged bark that surrounds the fly-whisk.  The handle itself appears made of bronze, with gold inlays along the outside of the handguard.  Looking closer, you realize they portray a stylized figure battling a horde of demons.  The handle is wrapped tightly with rugged leather that still looks brand new in spite of how long this fly-whisk must have been here for the tree to grow so thoroughly around it.\n\n");
				outputText("You suppose you could try to pull it free, do you?");
				doYesNo(tryToTakeFlyWhiskInStone,explorer.done);
			}
			else {
				outputText("While walking along the lake, a massive tree catches your eye.  You carefully circle some bushes, wary of an ambush as you get closer.   As you close the distance, it becomes clear the tree is terribly corrupt.  It weeps black sap from gnashing mouths and clenching distorting twats.  The very center of the tree has a massive knot, as if it had sustained a massive injury there.  You decide to avoid it, given the hungry-looking nature of its mouths, but before you depart you spot the pieces of a broken fly-whisk scattered around the trunk, completely covered in rust.");
				endEncounter();
				player.createStatusEffect(StatusEffects.BFlyWhiskBroken,0,0,0,0);
			}
		}
		private function tryToTakeFlyWhiskInStone():void {
			clearOutput();
			//if corrupted...
			if (player.cor >= 25) {
				outputText("You grip the fly-whisk with both hands and ");
				if (player.str > 70) outputText("pull mightily, making the tree strain and groan from the force, ");
				if (player.str <= 70 && player.str >= 40) outputText("pull hard, feeling your muscles tighten from the strain, ");
				if (player.str < 40) outputText("pull as hard as you can, ");
				outputText("but the fly-whisk remains stubbornly lodged in its arboreal home.  Frustrated, you give up and resolve to try later.");
				endEncounter();
			}
			//If not corrupted...
			else {
				outputText("You grip the fly-whisk with both hands and ");
				if (player.str > 70) outputText("pull so hard you fall on your ass when the fly-whisk slips free.  The fall buries itself a few inches from your head.  You count yourself lucky and stand up.  ");
				if (player.str <= 70 && player.str >= 40) outputText("give a mighty pull and nearly fall over as the fly-whisk easily slides free from the tree.  ");
				if (player.str < 40) outputText("easily pull the fly-whisk free, surprising yourself with how easy it was to remove.  ");
				outputText("Remarkably the tree's trunk is entirely intact.  While marveling at this new development, a leaf brushes your shoulder.  You look up and watch as every single leaf turns from healthy green, to brilliant orange, and finally changes to brown.  The leaves rain down around you, covering the ground in dead plant-matter, leaving you alone with the withering skeleton of a dead tree.  The sight saddens you, though you cannot fathom why.\n\n");
				outputText("The fly-whisk itself is made from purest, shining leather you have ever seen.  It truly is a beautiful fly-whisk.\n\n");
				dynStats("lus", -15, "scale", false);
				inventory.takeItem(weapons.B_FLYWHISK, explorer.done);
				if (player.hasStatusEffect(StatusEffects.BlessedItemAtTheLake)) player.addStatusValue(StatusEffects.BlessedItemAtTheLake, 1 , 1);
				else player.createStatusEffect(StatusEffects.BlessedItemAtTheLake, 1, 0, 0, 0);
				player.createStatusEffect(StatusEffects.TookBlessedFlyWhisk,0,0,0,0);
			}
		}
		
		public function findVolcanicGravehammer():void {
			clearOutput();
			outputText("While exploring the molten hellscape, you notice a cave in the distance. Deciding to investigate, you cautiously peek inside the cave. There are a few dangerous looking stalactites, but they seem stable. Seeing no other signs of danger, you decide to enter. The cave narrows slightly, but you push deeper into the cave, which opens into a crude, half-melted room of some sort, constructed out of ash-grey stone bricks.\n\n");
			outputText("In the center of the room is a titanic molten warhammer. At some point, a lava flow had broken through the wall, ruining the brick and seeping into the room. The hammer’s shaft leans heavily to the right, head sunk deep into the once-molten rock.\n\n");
			outputText("A marble effigy in the shape of a cross rests nearby, buried similarly in layers of molten stone. The arms of the cross have something etched into it, but the marble arms of the cross are melted and warped, blackened by whatever disaster had befallen this ancient shrine.\n\n");
			outputText("Your [skin] begins to crawl, and you feel heat, like warm breathing on your back. This was once some sort of mausoleum, or shrine to a fallen warrior, and this weapon was once theirs.\n\n");
			outputText("On the other hand you reckon if you were strong enough, you could dislodge the titanic weapon and wield it.\n\n");
			menu();
			addButton(1, "Leave", findVolcanicGravehammerLeave);
			addButtonIfTrue(2, "Dislodge", findVolcanicGravehammerDislodge, "The thought of attempting to lift something of that caliber already exhausts you. (Req. 500+ fatigue, 100+ in core / train str part and 400+ total str)", (player.fatigue <= player.maxOverFatigue() - 500), "Req. 500+ fatigue, 100+ in core / train str part and 400+ total str");
			addButton(3, "Never", findVolcanicGravehammerNever);
		}
		private function findVolcanicGravehammerLeave():void {
			clearOutput();
			outputText("You make a mental note to return when you are more prepared. Taking one last look back at the charred shrine, you leave the cave and return to your camp.\n\n");
			endEncounter();
		}
		private function findVolcanicGravehammerDislodge():void {
			clearOutput();
			outputText("Ignoring the foreboding feeling, you approach the behemoth of a hammer. Firmly planting yourself and getting a good grip, you pull…\n\n");
			fatigue(500);
			if (player.str >= 400 && player.strStat.core.value >= 100 && player.strStat.train.value >= 100) {
				outputText("The hammer shifts a bit, emboldened by this you redouble your efforts. With a primal shout and one last heave, the hammer breaks loose! You take a moment to catch your breath and admire your prize. As you gaze on the titanic warhammer, you feel the shrine rumble as the sound of distant falling stones echo through the cave. Spurred on by instinct, you rush into the cave, to see a stalactite fall right in front of you, crashing to the floor and sending shards of stone every which way. You ignore the sting of the rock shards, rushing towards the exit.\n\n");
				outputText("As you push through a fallen rock, making your way back into the light of day, you feel your back trembling, sweat pouring from your spine. As you begin to make your way back to camp, you can hear a faint hiss and pop, like flowing magma. You turn towards the noise each time, but there’s never anything there. You move further and further from that now-collapsed shrine, and the frequency of the sounds gets less and less, fainter and fainter. By the time you get back to camp, you’ve stopped hearing them entirely.\n\n");
				inventory.takeItem(weapons.VGRAVEH, explorer.done);
				player.createStatusEffect(StatusEffects.TookVolcanicGravehammer,0,0,0,0);
			}
			else {
				outputText("No matter how hard you try, you can't get it to budge, even a little bit. Exhausted, you decide to come back later when you're more prepared.\n\n");
				endEncounter();
			}
		}
		private function findVolcanicGravehammerNever():void {
			clearOutput();
			outputText("This is clearly a shrine to someone loved, and taking this weapon, no matter how useful it may be. A feeling crawls up your spine as you stay your hand. Putting aside the implications of graverobbing, this world has proven to you, time and again, that indescribable magic runs deep within it. This could unearth something dangerous, and it’s best to leave this charred shrine be.\n\n");
			outputText("You take your leave.\n\n");
			endEncounter();
			player.createStatusEffect(StatusEffects.VolcanicGravehammerNever,0,0,0,0);
		}
		
		public function findGlacialGraveaxe():void {
			clearOutput();
			outputText("While trudging the frozen wastes, you scan the horizon for anything out of the ordinary. During your survey, you notice what appears to be a pole atop one of the many frozen hills. Against your better judgment, you make your way towards it, slogging your way through deep snow.\n\n");
			outputText("As you near the odd pole, you quickly realize that the pole is actually a titanic battleaxe. With each advancing step, you notice that the odd axe is made of ice and stone. It’s sunk deep into the frozen earth, head stuck halfway in.\n\n");
			outputText("Leaning against it is a stone tablet. You make out some discoloration… almost where words on a headstone would have been. This is a tombstone of some kind, but the working forces of time and raging blizzards have worn them away.\n\n");
			outputText("A strange sense of foreboding washes over you. You can feel your [skin] crawl, and it’s not just the cold. While the weapon is clearly well-made, and could be of use to you… Something gives you pause. You could just leave now and forget about this oddity.\n\n");
			outputText("On the other hand, you could dislodge the titanic weapon and wield it… If you’re strong enough.\n\n");
			menu();
			addButton(1, "Leave", findGlacialGraveaxeLeave);
			addButtonIfTrue(2, "Dislodge", findGlacialGraveaxeDislodge, "The thought of attempting to lift something of that caliber already exhausts you. (Req. 500+ fatigue, 100+ in core / train str part and 400+ total str)", (player.fatigue <= player.maxOverFatigue() - 500), "Req. 500+ fatigue, 100+ in core / train str part and 400+ total str");
			addButton(3, "Never", findGlacialGraveaxeNever);
		}
		private function findGlacialGraveaxeLeave():void {
			clearOutput();
			outputText("This is clearly a gravesite of some kind, and taking this weapon, no matter how valuable or useful it might be to your cause, could disturb the rest of whoever or whatever is entombed here. Knowing this world, any disturbance could have disastrous consequences.\n\n");
			endEncounter();
		}
		private function findGlacialGraveaxeDislodge():void {
			clearOutput();
			outputText("Ignoring the foreboding feeling, you approach the behemoth of an axe. Firmly planting yourself and getting a good grip, you pull…\n\n");
			fatigue(500);
			if (player.str >= 400 && player.strStat.core.value >= 100 && player.strStat.train.value >= 100) {
				outputText("The axe shifts a bit as the ice cracks under your feet. Emboldened by this, you redouble your efforts. With a primal shout and one last heave, the axe breaks loose, sending cracks shooting through the icy ground beneath you. You take a moment to catch your breath and admire your prize. Seeing there's nothing left to do here, you stow the weapon and begin making your way to camp.\n\n");
				outputText("Suddenly, it hits you. This feeling of being watched, it’s like something’s breathing down your neck! You whirl, readying yourself for a fight. Mentally, you kick yourself, of course this weapon would have some sort of guardian…\n\n");
				outputText("But there’s nothing there. Nothing but the howling of the wind, the swirling of the snow. The feeling begins to fade, and you trudge back to camp, the feeling completely gone by the time you return home.\n\n");
				inventory.takeItem(weapons.GGRAVEA, explorer.done);
				player.createStatusEffect(StatusEffects.TookGlacialGraveaxe,0,0,0,0);
			}
			else {
				outputText("No matter how hard you try, you can't get it to budge, even a little bit. Exhausted, you decide to come back later when you're more prepared.\n\n");
				endEncounter();
			}
		}
		private function findGlacialGraveaxeNever():void {
			clearOutput();
			outputText("This is clearly a gravesite of some kind, and taking this weapon, no matter how valuable or useful it might be to your cause, could disturb the rest of whoever or whatever is entombed here. Knowing this world, any disturbance could have disastrous consequences.\n\n");
			outputText("You take your leave.\n\n");
			endEncounter();
			player.createStatusEffect(StatusEffects.GlacialGraveaxeNever,0,0,0,0);
		}
		
		public function findStormcallerGravespear():void {
			clearOutput();
			outputText("While traversing the mountaintops, clouds, and the odd floating island, you hear thunder crash in the distance, followed by another clap of thunder, then another, with shocking regularity. It's not entirely unheard of given the beings that call this area home, but some gut feeling tells you this isn't the case in this instance.\n\n");
			outputText("Curious, you make your way towards the source of the noise. Surprisingly, you find an uncommonly large floating island, upon which rests an oddly ornate, circular shrine, which provides shelter from the winds of the region. Carved wing-motifs line the inside of the shrine, with odd greenish-grey veins on the ceiling, but as the lightning strikes, the veins light up, revealing intricately decorated clouds, ");
			outputText("with the strokes of green acting as lineart. Sparks of lightning jump between the wings, and you can see more of the strange green ore poking out, attracting the bolts and passing them along. As the power fades, however, your gaze is drawn to the centerpiece of this ancient, wondrous building.\n\nStabbed blade-first into the floor of this shrine is a behemoth of spear, made of bedrock, with veins of a metal ore you don't recognize inlaid all along the haft. ");
			outputText("Your hair stands on end simply being near it. To either side of the spear are two ancient statues of oddly human-like figures, half the spear’s size. The statues seem to be praying or begging, but their facial features have been struck by something a long time ago, shards of their facial features litter the otherwise smooth floor. A plaque, made of the same greenish-grey alloy, sits between them, the lettering long-since wiped from its face.\n\n");
			outputText("This appears to be a sort of shrine, probably to a fallen warrior. You know enough about Mareth to know that something could be disturbed by any thoughtless actions on your part.\n\n");
			outputText("On the other hand, that spear looks like it could kill a lot of demons. Surely any noble warrior would rather their weapon be used to save Mareth, right?\n\n");
			menu();
			addButton(1, "Leave", findStormcallerGravespearLeave);
			addButtonIfTrue(2, "Dislodge", findStormcallerGravespearDislodge, "The thought of attempting to lift something of that caliber already exhausts you. (Req. 500+ fatigue, 100+ in core / train str part and 400+ total str)", (player.fatigue <= player.maxOverFatigue() - 500), "Req. 500+ fatigue, 100+ in core / train str part and 400+ total str");
			addButton(3, "Never", findStormcallerGravespearNever);
		}
		private function findStormcallerGravespearLeave():void {
			clearOutput();
			outputText("You make a mental note to return when you are more prepared. Taking one last look back at the odd site, you return to your camp.\n\n");
			endEncounter();
		}
		private function findStormcallerGravespearDislodge():void {
			clearOutput();
			outputText("Ignoring the foreboding feeling, you approach the behemoth of a spear. Firmly planting yourself and getting a good grip, you pull…\n\n");
			fatigue(500);
			if (player.str >= 400 && player.strStat.core.value >= 100 && player.strStat.train.value >= 100) {
				outputText("The spear rises from the stone about a half-inch. You release it as the lightning falls once more, shocking the weapon, but you’ve proven you can move it! Emboldened, you wait for the energy to fade, then redouble your efforts. With a primal shout and one last heave, the spear is pulled from its stone prison! You take a moment to catch your breath and admire your prize.\n\n");
				outputText("Lightning strikes the shrine again, this time sending its charge through the spot where the spear had once stood. The stone shakes, and the stone wings around the shrine shudder, sloughing off stone as the lightning arcs towards the most conductive thing in the temple…The spear in your hands! With an undignified yelp, you rush towards the exit, narrowly evading the sparks as the odd shrine begins to shudder. Another bolt strikes it, stonework shuddering, nearly throwing you from your [legs] as you flee.\n\n");
				outputText("You make haste, trying to get back to the safety of your camp as fast as possible, as if the storm itself was chasing you… for all you know, it very well could. Static electricity crawls up your back, making you shudder. The feeling fades as you leave the stormy cliffs and mountains behind, heading back to camp, and by the time you get there, the feeling’s gone.\n\n");
				inventory.takeItem(weapons.SGRAVES, explorer.done);
				player.createStatusEffect(StatusEffects.TookStormcallerGravespear,0,0,0,0);
			}
			else {
				outputText("No matter how hard you try, you can't get it to budge, even a little bit. Exhausted, you decide to come back later when you're more prepared.\n\n");
				endEncounter();
			}
		}
		private function findStormcallerGravespearNever():void {
			clearOutput();
			outputText("This is clearly a gravesite of some kind, and taking this weapon, no matter how tempting it is to try and take the weapon for yourself, you have a feeling it would disturb the rest of whoever or whatever has been entombed here.\n\n");
			outputText("You take your leave.\n\n");
			endEncounter();
			player.createStatusEffect(StatusEffects.StormcallerGravespearNever,0,0,0,0);
		}
		
		public function findUmbralGravesword():void {
			clearOutput();
			outputText("While exploring the deep cave system, you find yourself treading deeper than you normally would. As you round a corner you find yourself peering into a large cavern, eerily quiet, and seemingly devoid of life, the whole place just feels… wrong.\n\nThe feeling gets worse the further you go in, ");
			if (player.hasKeyItem("Torch") >= 0) outputText("the light from your torch even seems to light up less of the space the further you tread");
			else if (player.hasPerk(PerkLib.DarknessAffinity) || player.hasPerk(PerkLib.FireShadowAffinity) || player.hasDarkVision()) outputText("even with your enhanced vision you find it hard to make out what lies ahead");
			outputText(". You come upon a raised platform of some sort, etched with circles of runes that you can't even begin to decipher. In the center, a titanic stone sword is embedded into the floor. The dark seems to cling to it, or perhaps it clings to the dark… If such a thing were even possible.\n\n");
			outputText("You really feel like you shouldn't be here, you can't shake the feeling that you are being watched, that the shadows are alive. You could just leave, and never ever think about ever returning to this accursed site.\n\n");
			outputText("On the other hand, you could just be paranoid. You don't come across a blade like this every day… You figure if you were strong enough, you could dislodge the titanic weapon and put it to good use on your quest, after all, slaying demons with a giant slab of bedrock that you can barely call a sword would just feel so right!\n\n");
			menu();
			addButton(1, "Leave", findUmbralGraveswordLeave);
			addButtonIfTrue(2, "Dislodge", findUmbralGraveswordDislodge, "The thought of attempting to lift something of that caliber already exhausts you. (Req. 500+ fatigue, 100+ in core / train str part and 400+ total str)", (player.fatigue <= player.maxOverFatigue() - 500), "Req. 500+ fatigue, 100+ in core / train str part and 400+ total str");
			addButton(3, "Never", findUmbralGraveswordNever);
		}
		private function findUmbralGraveswordLeave():void {
			clearOutput();
			outputText("You make a mental note to return when you are more prepared. Taking one last look back at the odd site, you return to your camp.\n\n");
			endEncounter();
		}
		private function findUmbralGraveswordDislodge():void {
			clearOutput();
			outputText("Ignoring the foreboding feeling, you approach the behemoth of a sword. Firmly planting yourself and getting a good grip, you pull…\n\n");
			fatigue(500);
			if (player.str >= 400 && player.strStat.core.value >= 100 && player.strStat.train.value >= 100) {
				outputText("The sword shifts a bit, causing the ground below you to crack and deform slightly, shattering any silence the still cave once carried. The onslaught of echoing sound hits you like a wall, stunning you momentarily. Regaining your composure, you return to your task with renewed vigor. You put your whole body into it, and with a primal shout and a mighty heave the sword breaks loose!\n\n");
				outputText("You take a moment to catch your breath and admire your prize, but your reprieve is short lived, the platform shatters with a thunderous crack, sending chunks of debris in all directions. You manage to block the worst of it with the flat of your newly-claimed sword.\n\n");
				outputText("The ground shudders and groans, and your blood goes cold. Cursing, you make a break for it in the direction you remember entering from, and manage to make it out of the cavern right before the ceiling starts coming down. Not willing to wait around, you hasten your way back to camp.\n\n");
				outputText("Every so often on your way back, everything goes eerily quiet, and you get the feeling of predatory eyes on your back. You stop, looking for any signs of a follower, but you see ");
				if (player.companionsInPCParty()) {
					outputText(" only ");
					if (flags[kFLAGS.PLAYER_COMPANION_0] != "") outputText(""+flags[kFLAGS.PLAYER_COMPANION_0]+"");
					else if (flags[kFLAGS.PLAYER_COMPANION_1] != "") outputText(""+flags[kFLAGS.PLAYER_COMPANION_1]+"");
					else if (flags[kFLAGS.PLAYER_COMPANION_2] != "") outputText(""+flags[kFLAGS.PLAYER_COMPANION_2]+"");
					else if (flags[kFLAGS.PLAYER_COMPANION_3] != "") outputText(""+flags[kFLAGS.PLAYER_COMPANION_3]+"");
				}
				else outputText("nothing");
				outputText(" behind you. The closer you get to camp the less it happens, eventually, the dread fades completely.\n\n");
				inventory.takeItem(weapons.UGRAVES, explorer.done);
				player.createStatusEffect(StatusEffects.TookUmbralGravesword,0,0,0,0);
			}
			else {
				outputText("No matter how hard you try, you can't get it to budge, even a little bit. Exhausted, you decide to come back later when you're more prepared\n\n");
				endEncounter();
			}
		}
		private function findUmbralGraveswordNever():void {
			clearOutput();
			outputText("This is clearly some sort of seal of some kind, and taking this weapon, no matter how tempting it is, would undoubtedly break the seal, releasing whatever, or whoever is entombed here. Knowing how Mareth operates, it would be best to just leave it be, you have more than enough problems to deal with already, after all.\n\n");
			outputText("You take your leave.\n\n");
			endEncounter();
			player.createStatusEffect(StatusEffects.UmbralGraveswordNever,0,0,0,0);
		}
	}
}
