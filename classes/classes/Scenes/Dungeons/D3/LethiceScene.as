package classes.Scenes.Dungeons.D3 
{
	import classes.*;
	import classes.GlobalFlags.*;

	public class LethiceScene extends BaseContent
	{
		
		public function LethiceScene() 
		{
			
		}
		
		public function lethiceIntro():void {
			clearOutput();
			outputText(images.showImage("lethice-intro"));
			outputText("You walk through the throne room and marvel at the massive size of it. Lethice is staring at you, eating a small bit of lethicite out of a chalice. \"<i>Well done, [name]. You may have fought my minions but it's not over!</i>\" she yells and she stands up.");
			outputText("\n\nLethice slowly walks down the steps and says, \"<i>You may have shut down that factory in the mountains. You may have defeated Zetaz and found the map that leads here. You may have fought your way up to here. But... this is where your journey ends! What is your intent?</i>\"");
			menu();
			addButton(0, "End Threat", chooseEndThreat, null, null, null, "You're here to defeat Lethice and free Mareth from the corruption!");
			if (player.cor >= 50) addButton(1, "Dominance", chooseDominance, null, null, null, "You're here to defeat Lethice, take her place and attempt to dominate Mareth!");
		}
		
		private function chooseEndThreat():void {
			clearOutput();
			outputText("\"<i>I will put an end to your plots to corrupt and dominate Mareth!</i>\" you proclaim.");
			finalBattleBegin()
		}
		
		private function chooseDominance():void {
			clearOutput();
			outputText("\"<i>I'm going to dethrone you and dominate this world!</i>\" you proclaim.");
			finalBattleBegin()
		}
		
		private function finalBattleBegin():void {
			outputText("\n\n\"<i>So be it. Now, shall I take you as my slave? Or shall I kill you? Decisions, decisions,</i>\" Lethice growls at you. She raises her lethicite-topped staff.");
			outputText("\n\n<b>As if by magic, the door shuts and locks itself! It's a fight!</b>");
			startCombat(new Lethice(), true)
		}
		public function finalBattlePart2():void {
			clearOutput();
			outputText(images.showImage("monster-lethice-phase2"));
			outputText("Lethice hisses at you. \"<i>Today is the day you'll die!</i>\" She raises her staff and makes a series of strange arcane gestures you've never even seen! One of the panels on the floor slides open and the hidden compartment raises to reveal a suit of strange, purple armor seeming to be made of glowing lethicite. What catches your eyes the most is the intricately-decorated hole at the groin area, presumably to expose the wearer's nether regions. You can only imagine how many mortals were turned into demons to harvest enough lethicite to create such an imposing armor. ");
			outputText("\n\nIn no time, she quickly strips out her fetish churchwear and slips into the armor. She definitely looks more imposing yet her slavering cunt remains visible. \"<i>Like this beauty? I've turned hundreds of mortals into a demon to harvest enough lethicite. It takes a lot of work to forge this armor considering the strange properties of lethicite. You may think lethicite is one of demon's favorite treats but it has some uses!</i>\" Lethice says, glaring at you.");
			startCombat(new Lethice());
			monster.createStatusAffect(StatusAffects.Berzerking, 50, 0, 0, 0);
			monster.createPerk(PerkLib.LustyRegeneration, 0, 0, 0, 0);
			monster.bonusHP += 200;
			monster.lustVuln -= 0.05;
			monster.str += 20;
			monster.tou += 20;
			monster.spe += 10;
			monster.inte += 20;
			monster.HP = monster.eMaxHP();
			monster.lust = 0;
			monster.fatigue = 0;
			monster.imageName = "lethice-phase2";
			if (monster.lustVuln < 0.1) monster.lustVuln = 0.1;
			monster.long = "She is no doubt the Queen of the Demons. She has pink skin, a rare example among demons. Her eyes are black with yellow iris and slit pupil. Her fangs are clearly visible, protruding along her upper row of teeth. She has long, luxurious purple hair with black roses woven in it, parted by her pair of goat horns and multiple pairs of demonic horns. She has numerous lethicite piercings piercing her ears. Huge draconic wings grow from her back, easily rivaling a full-fledged dragon-morph. Her feet end in high heels. " + (monster.findStatusAffect(StatusAffects.Berzerking) >= 0 ? "She's wearing a suit of lethicite armor that exposes her lethicite-pierced nipples and her glistening vagina." : "She's wearing a set of fetishy churchwear that doesn't seem to cover her B-cup breasts and her glistening vagina.") + " She's currently wielding an ebony staff topped with lethicite.";
			monster.weaponAttack = 50;
			monster.armorName = "lethicite armor";
			monster.armorDef = 32;
			doNext(playerMenu);
		}
		
		
		public function loseToLethiceEpicFuckUp():void {
			clearOutput();
			if (player.HP <= 0) outputText("You collapse from your injuries.");
			else outputText("You collapse from your overwhelming desires.");
			outputText("\n\nLethice walks over to your defeated form. \"<i>Pity. Yet another 'champion' who tried to dethrone me. You will forever serve me as my slave.</i>\"");
			outputText("\n\n(Placeholder) You are abducted, abused, and forced to serve Lethice as slave forever.");
			getGame().gameOver();
		}
		
		public function theFinalEnding():void {
			flags[kFLAGS.LETHICE_DEFEATED] = 1;
			clearOutput();
			outputText("\"<i>No! It cannot be!</i>\" Lethice screams. You walk over to her defeated form and yank the staff away from her. ");
			cleanupAfterCombat();
			inventory.takeItem(weapons.L_STAFF, theFinalEndingPart2);
		}
		
		private function theFinalEndingPart2():void {
			clearOutput();
			outputText("\"<i>I'm going to decide what I should do to you,</i>\" you say. You ponder over what you should do with Lethice.");
			outputText("\n\n(<b>Note:</b> This ending is placeholder and <font color=\"#800000\"><b>not official</b></font>. Please don't confuse it. -Kitteh6660)");
			menu();
			addButton(0, "Execute Her", executeLethice, null, null, null, "Finish Lethice off for once and for all.");
			if (player.lust >= 33) addButton(1, "Fuck Her", fuckLethice, null, null, null, "Fuck Lethice. (Placeholder)");
			//doNext(theFinalEndingPart3);
		}
		
		private function executionPrompt():void {
			if (player.weaponVerb == "slash" || player.weaponVerb == "cleave" || player.weaponVerb == "keen cut") {
				clearOutput();
				outputText("How would you execute Lethice?");
				menu();
				addButton(0, "Snap Her Neck", executeLethice, 0, null, null, "Snap her neck.");
				addButton(1, "Behead Her", executeLethice, 1, null, null, "Off with her head!\n\n(Warning: Contains gore!)");
			}
			else executeLethice();
		}
		
		private function executeLethice(method:int = 0):void {
			flags[kFLAGS.LETHICE_DEFEATED] = 2;
			clearOutput();
			outputText("You finally make your mind up. She must be punished for her wicked deeds. ");
			if (method == 1) {
				outputText("\n\nYou raise your [weapon] and cleanly slice through Lethice's neck. Demonic blood spills forth, staining the carpet. ");
				if (silly()) outputText("<b>FATALITY!</b> ");
			}
			else outputText("You grab Lethice and snap her neck, putting an end to her corruptive conquests. ");
			outputText("\n\nWith Lethice dead, your destiny as a Champion has been fulfilled. You step up the steps, sit on the throne, and look back and reflect on your past accomplishments.");
			if (player.cor >= 70) outputText("\n\nYou could even rule Mareth!");
			doNext(theFinalEndingPart3);
		}
		private function fuckLethice():void {
			clearOutput();
			outputText("Super-duper placeholder for epic fuck scene.");
			outputText("\n\nWith Lethice overthrown, your destiny as a Champion has been fulfilled. You step up the steps, sit on the throne, and look back and reflect on your past accomplishments.");
			if (player.cor >= 70) outputText("\n\nYou could even rule Mareth!");
			player.orgasm();
			doNext(theFinalEndingPart3);
		}
		
		private function theFinalEndingPart3():void {
			clearOutput();
			outputText("It's time for you to return to your camp. With the threat dealt with, you could even return to Ingnam... only if you have something to amplify the portal. You know you can return to the stronghold anytime to grab any remaining loot.");
			outputText("\n\nYou get up from the throne, walk to the door, and make your way to the great lift. ");
			if (flags[kFLAGS.D3_MECHANIC_FIGHT_RESULT] == 0) outputText("The incubus sighs and says, \"<i>So you've defeated Lethice? Very well, I'll offer you a safe passage out of this place. Get in there.</i>\"");
			outputText("\n\nYou get into the lift and hold onto the railing before the platform lowers. While the platform does rock from side to side along the slow trip down, its motions are not erratic enough to put you in any significant danger. Even better, you aren't bothered by a single harpy along the way. This section of the high mountains seems to have been cleansed of them.");
			outputText("\n\nThe platform touches down roughly thirty minutes after your departure, and you head back to camp with all due haste.");
			
			doNext(theFinalEndingPart4);
		}

		private function theFinalEndingPart4():void {
			clearOutput();
			outputText("By the time you finally arrive at your camp, joy spreads throughout you. ");
			if (camp.companionsCount() >= 3) outputText("The camp folks are already cheering for you even before you arrived.");
			//Followers!
			if (player.findStatusAffect(StatusAffects.CampRathazul) >= 0) outputText("\n\nRathazul hollers \"<i>Good news, everyone! Lethice is dead!</i>\"");
			if (player.findStatusAffect(StatusAffects.PureCampJojo) >= 0) outputText("\n\nThe mouse monk, Jojo, cheers for you. \"<i>The source of the corruption is gone.</i>\"");
			//Lovers!
			if (camp.amilyFollower()) outputText("\n\nAmily the mouse-girl is already dancing and cheering. \"<i></i>\"");
			if (camp.followerHel()) outputText("\n\nHelia the salamander girl smiles and gives you a hug. \"<i>You've really whopped that demon queen's ass, lover!</i>\" Hel chuckles. ");
			if (camp.followerKiha()) outputText("\n\nKiha the dragoness smiles and says, \"<i>I knew it! I can trust you, my doofus. You took out Lethice!</i>\"");
			if (flags[kFLAGS.VALARIA_AT_CAMP] == 1) outputText("\n\nValeria the armored goo-girl walks up to you and says, \"<i>Hey, " + player.mf("sir", "madam") + ", you've done it!</i>\" She smiles.");
			else if (player.armor == armors.GOOARMR) outputText("\n\nValeria pours out of your armor and says, \"<i>Hey, " + player.mf("sir", "madam") + ", you've done it!</i>\" She smiles.");
			if (camp.marbleFollower()) outputText("\n\n\"<i>Sweetie, you've done it! I'm happy for you,</i>\" Marble smiles.");
			if (camp.isabellaFollower()) { //To be expanded.
				if (camp.isabellaAccent()) outputText("\n\n\"<i>Zis great!</i>\" Isabella says.");
				else outputText("\n\n\"<i>This is great!</i>\" Isabella says.");
			}
			if (camp.milkSlave()) outputText(""); //To be worked on
			if (camp.companionsCount() >= 3) outputText("\n\nYou spend a great amount of time celebrating among your companions. ");
			
			outputText("\n\n<b>Meanwhile in Tel'Adre...</b>\n");
			outputText("News spread throughout Tel'Adre about the fall of Lethice. The citizens are cheering and dancing to celebrate the fall of Lethice and the liberation of Mareth. ");
			if (kGAMECLASS.urta.urtaLove()) outputText("\n\n\"<i>I'm happy for my Lover! " + player.heShe(true) + " did it!</i>\" Urta says before taking another swig of booze.");
			//outputText("\n\n<b>Back at camp...</b>\n");
			//outputText("");
			
			outputText("\n\nIn time, the corruption will eventually get erased from Mareth. ");

			if (player.cor >= 80) outputText("Or maybe not... After all, you have Mareth to yourself.");
			awardAchievement("Demon Slayer", kACHIEVEMENTS.STORY_FINALBOSS, true, true, false);
			outputText("\n\n<b>THE END!</b> Now sit tight and wait until the official ending gets added!");
			doNext(bringUpTheCredits);
		}
		
		private function bringUpTheCredits():void {
			showCredits();
			menu();
			addButton(0, "Continue", continueFromEnding, null, null, null, "Continue playing?");
		}
		
		private function continueFromEnding():void {
			clearOutput();
			outputText("You may have defeated Lethice but your adventures are still not over! There are still plenty of things you can do. Even something you could not do before Lethice was defeated. Why not explore for secrets or even challenge Marae?");
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) outputText("\n\n<b>You may start New Game+! (Level 25+ recommended)</b>");
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 1) outputText("\n\n<b>You may start New Game++! (Level 55+ recommended)</b>");
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 2) outputText("\n\n<b>You may start New Game+++! (Level 85+ recommended)</b>");
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 3) outputText("\n\n<b>You may start New Game+" + (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] + 1) + "! (Level 100+ recommended)</b>");
			outputText("\n\nTo start a new game plus, choose 'Camp Actions' then 'Ascension'.");
			kGAMECLASS.inRoomedDungeon = false;
			player.HP = player.maxHP();
			player.lust = player.minLust();
			player.fatigue = 0;
			player.hunger = 100;
			statScreenRefresh();
			model.time.days++;
			model.time.hours = 0;
			doNext(camp.returnToCampUseEightHours);
		}
		
		public function takeLethiciteArmor():void {
			flags[kFLAGS.LETHICITE_ARMOR_TAKEN] = 1;
			clearOutput();
			//outputText("Thankfully, the armor is still there. ");
			inventory.takeItem(armors.LTHCARM, getGame().d3.resumeFromFight, putBackLethiciteArmor);
		}
		private function putBackLethiciteArmor():void {
			flags[kFLAGS.LETHICITE_ARMOR_TAKEN] = 0;
			clearOutput();
			outputText("Unfortunately, you don't have enough space in your inventory so you put the armor back where it was.");
			doNext(getGame().d3.resumeFromFight);
		}
	}

}