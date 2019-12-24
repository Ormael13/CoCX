/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Shield;
import classes.Items.Weapon;

	public class AuroraFollower extends NPCAwareContent
	{
		
		public function AuroraFollower() 
		{}

public function putInTheJadeTalismanEpilogue():void {
	outputText("As you walk to Yang she waves up to you.\n\n");
	outputText("\"<i>Hey [name] perfect timing, your request just got completed and as it happens the man who did it already collected the reward in advance. He's going to move the statue back to your camp but he needs coordinates so you might as well go to the cave with him. Just wait while I call him.</i>\"\n\n");
	outputText("A few minutes later a tattooed minotaur enters the room. The both of you head to the cave where the gargoyle is still chained. He prepared a few weird magical circles and rituals ahead of time, not that you understand any. You put a pointer on a map and he nods, drawing something on a paper tag he's holding before making a few movements with his hands in the air. ");
	outputText("To your astonishment the statue vanishes along with the chains.\n\n");
	outputText("\"<i>Your delivery should be around the location you provided. Ever a pleasure to do business. Should you need more objects displaced just call on me.</i>\"\n\n");
	outputText("His job done, he heads back to town for a drink. You may want to ask him how he did that later.\n\n");
	outputText("After you return to camp, there seems to be what looks like a random pillar gargoyle here"+(silly() ? ". She even brought her own pillar! S":", s")+"urprisingly it’s the golem from the cave who welcomes you.\n\n");
	outputText("\"<i>What are your orders, " + player.mf("Master", "Mistress") + "?</i>\" she asks.\n\n");
	outputText("The first order you give her is to tell something about herself.\n\n");
	outputText("\"<i>I’m Advanced Utility & Reconnaissance Organical Restorative Automaton Mark lll. You can call me whatever you want, " + player.mf("Master", "Mistress") + ". I was manufactured by a great goblin mechanic called Nicole. I can perform many different types of roles: bodyguard, worker, ‘personal companion’. Which one of those do you desire for me to be now?</i>\"\n\n");
	outputText("After a moment of thinking you tell her to find some place to stay and you will come by later to tell her what role she will perform in the camp.\n\n");
	outputText("(<b>Aurora has been added to the Followers menu!</b>)\n\n");
	flags[kFLAGS.AURORA_LVL] = 1;
	doNext(camp.returnToCampUseOneHour);
}

public function auroraCampMenu():void {
	clearOutput();
	outputText("As you approach Aurora, she turns toward you as she notices you’re walking towards her.\n\n\"<i>Greetings " + player.mf("Master", "Mistress") + ", What do you need?</i>\"\n\n");
	menu();
	addButton(0, "Appearance", auroraAppearance).hint("Examine Aurora appearance.");
	//talk
	if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) addButton(4, "Spar", auroraSparsWithPC).hint("Ask Aurora for a mock battle.");
	if (player.hasPerk(PerkLib.BasicLeadership)) {
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "") addButton(5, "Team", auroraHenchmanOption).hint("Ask Aurora to join you in adventures outside camp.");
		else if (flags[kFLAGS.PLAYER_COMPANION_1] == "Aurora") addButton(5, "Team", auroraHenchmanOption).hint("Ask Aurora to stay in camp.");
		else addButtonDisabled(5, "Team", "You already have other henchman accompany you. Ask him/her to stay at camp before you talk with Aurora about accompaning you.");
	}
	addButton(14, "Back", camp.campFollowers);
}

public function auroraAppearance():void {
	clearOutput();
	outputText("Before you stands Aurora at 9 feet tall, she has an overall thicker body than most golems.\n\n");
	outputText("Her flowing locks of hair are navy blue, with green eyes on a bat-like face. Around her neck is a mane of light blue fur. Two huge bat ears swivel around from the top of her head, detecting all noises in the area.\n\n");
	outputText("Her skin is a light turquoise with blue markings all over and a white belly. Two huge bat wings come from her back, and she has a long tail ending in blue fur.\n\n");
	outputText("She has HHH cup breasts. Right above where her cleavage begins, is a black tattoo with the letter A above 3 lines, forming the Roman numeral 3.\n\n");
	menu();
	addButton(14, "Back", auroraCampMenu);
}

public function auroraSparsWithPC():void {
	clearOutput();
	outputText("You ask Aurora for a mock battle.\n\n");
	outputText("\"<i>As you command " + player.mf("master", "mistress") + ".</i>\"");
	startCombat(new Aurora());
}
public function AuroraWonSparring():void {
	clearOutput();
	outputText("\"<i>I spotted a few flaws in your combat patterns, " + player.mf("Master", "Mistress") + ",</i>\" she says while smiling due to winning the mock battle against her " + player.mf("master", "mistress") + ".");
	cleanupAfterCombat();
}
public function AuroraLostSparring():void {
	clearOutput();
	outputText("\"<i>I need get stronger to be of better use to " + player.mf("Master", "Mistress") + ",</i>\" she mumbles under her breath.");
	if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
		if (flags[kFLAGS.AURORA_DEFEATS_COUNTER] >= 1) flags[kFLAGS.AURORA_DEFEATS_COUNTER]++;
		else flags[kFLAGS.AURORA_DEFEATS_COUNTER] = 1;
		if (flags[kFLAGS.AURORA_DEFEATS_COUNTER] == 1 && flags[kFLAGS.AURORA_LVL] == 1) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, 6);
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, 6, 0, 0);
			flags[kFLAGS.AURORA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.AURORA_LVL] = 2;
		}
		if (flags[kFLAGS.AURORA_DEFEATS_COUNTER] == 2 && flags[kFLAGS.AURORA_LVL] == 2) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, 12);
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, 12, 0, 0);
			flags[kFLAGS.AURORA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.AURORA_LVL] = 3;
		}
		if (flags[kFLAGS.AURORA_DEFEATS_COUNTER] == 3 && flags[kFLAGS.AURORA_LVL] == 3) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, 18);
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, 18, 0, 0);
			flags[kFLAGS.AURORA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.AURORA_LVL] = 4;
		}/*
		if (flags[kFLAGS.AURORA_DEFEATS_COUNTER] == 4 && flags[kFLAGS.AURORA_LVL] == 4) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, 24);
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, 24, 0, 0);
			flags[kFLAGS.AURORA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.AURORA_LVL] = 5;
		}
		if (flags[kFLAGS.AURORA_DEFEATS_COUNTER] == 5 && flags[kFLAGS.AURORA_LVL] == 5) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, 30);
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, 30, 0, 0);
			flags[kFLAGS.AURORA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.AURORA_LVL] = 6;
		}*/
	}
	cleanupAfterCombat();
}

public function auroraHenchmanOption():void
{
	clearOutput();
	if (flags[kFLAGS.PLAYER_COMPANION_1] == "") {
		outputText("\"<i>As you command " + player.mf("master", "mistress") + ".</i>\"\n\n");
		outputText("Aurora is now following you around.\n\n");
		var strAurora:Number = 10;
		var touAurora:Number = 300;
		var meleeAtkAurora:Number = 5;
		if (flags[kFLAGS.AURORA_LVL] >= 1) {
			if (flags[kFLAGS.AURORA_LVL] == 2) {
				meleeAtkAurora += 4;
			}
			if (flags[kFLAGS.AURORA_LVL] == 3) {
				touAurora += 20;
				meleeAtkAurora += 10;
			}
			if (flags[kFLAGS.AURORA_LVL] == 4) {
				touAurora += 20;
				meleeAtkAurora += 18;
			}/*
			if (flags[kFLAGS.AURORA_LVL] == 5) {
				touAurora += 40;
				meleeAtkAurora += 28;
			} 
			if (flags[kFLAGS.AURORA_LVL] == 6) {
				touAurora += 40;
				meleeAtkAurora += 40;
			}
			if (flags[kFLAGS.AURORA_LVL] == 7) {
				touAurora += 60;
				meleeAtkAurora += 54;
			}
			if (flags[kFLAGS.AURORA_LVL] == 8) {
				touAurora += 60;
				meleeAtkAurora += 70;
			}
			if (flags[kFLAGS.AURORA_LVL] == 9) {
				touAurora += 80;
				meleeAtkAurora += 88;
			}
			if (flags[kFLAGS.AURORA_LVL] >= 2 && flags[kFLAGS.AURORA_LVL] < 10) strAurora += 40 * (2 - flags[kFLAGS.AURORA_LVL]);
			if (flags[kFLAGS.AURORA_LVL] >= 10) {
				strAurora += 320 + (3 * (11 - flags[kFLAGS.AURORA_LVL]));
				touAurora += 80 + (6 * (11 - flags[kFLAGS.AURORA_LVL]));
				meleeAtkAurora += 88 + (4 * (11 - flags[kFLAGS.AURORA_LVL]));
			}*/
		}
		strAurora *= (1 + (0.2 * player.newGamePlusMod()));
		strAurora = Math.round(strAurora);
		touAurora *= (1 + (0.2 * player.newGamePlusMod()));
		touAurora = Math.round(touAurora);
		meleeAtkAurora += (1 + (int)(meleeAtkAurora / 5)) * player.newGamePlusMod();
		player.createStatusEffect(StatusEffects.CombatFollowerAurora, strAurora, touAurora, meleeAtkAurora, 0);
		flags[kFLAGS.PLAYER_COMPANION_1] = "Aurora";
	}
	else {
		outputText("Aurora is no longer following you around.\n\n");
		player.removeStatusEffect(StatusEffects.CombatFollowerAurora);
		flags[kFLAGS.PLAYER_COMPANION_1] = "";
	}
	doNext(auroraCampMenu);
	cheatTime(1/12);
}

//9 feet tall THICC bat gargoyle gurl ^^ (mk 2 ma 4 feet a Ted ma 6 and half feet czyli po miedzy wzrostami mk 2 i mk 3 xD)
//green eyes
//very long/flowing locks of [hair]
//skinTone = "turquoise"; - turkusowa + białe podbrzusze i etc.
//hairColor = "navy blue"; - granatowe
	}
}