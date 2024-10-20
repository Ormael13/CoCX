/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;

public class AuroraFollower extends NPCAwareContent
	{
		
		public function AuroraFollower()
		{}

public function putInTheJadeTalismanEpilogue():void {
	outputText("As you walk to Yang she waves up to you.\n\n");
	outputText("\"<i>Hey [name] perfect timing, your request just got completed and as it happens the man who did it already collected the reward in advance. He's going to move the statue back to your camp but he needs coordinates so you might as well go to the cave with him. Just wait while I call him.</i>\"\n\n");
	outputText("A few minutes later a tattooed minotaur enters the room. Both of you head to the cave where the gargoyle is still chained. He prepared a few weird magical circles and rituals ahead of time, not that you understand any. You put a pointer on a map and he nods, drawing something on a paper tag he's holding before making a few movements with his hands in the air. ");
	outputText("To your astonishment the statue vanishes along with the chains.\n\n");
	outputText("\"<i>Your delivery should be around the location you provided. Ever a pleasure to do business. Should you need more objects displaced just call on me.</i>\"\n\n");
	outputText("His job done, he heads back to town for a drink. You may want to ask him how he did that later.\n\n");
	outputText("After you return to camp, there seems to be what looks like a random pillar gargoyle here"+(silly() ? ". She even brought her own pillar! S":", s")+"urprisingly it’s the golem from the cave who welcomes you.\n\n");
	outputText("\"<i>What are your orders, [Master]?</i>\" she asks.\n\n");
	outputText("The first order you give her is to tell something about herself.\n\n");
	outputText("\"<i>I’m Advanced Utility & Reconnaissance Organical Restorative Automaton Mark lll. You can call me whatever you want, [Master]. I was manufactured by a great goblin mechanic called Nicole. I can perform many different types of roles: bodyguard, worker, ‘personal companion’. Which one of those do you desire for me to be now?</i>\"\n\n");
	outputText("After a moment of thinking you tell her to find some place to stay and you will come by later to tell her what role she will perform in the camp.\n\n");
	outputText("(<b>Aurora has been added to the Followers menu!</b>)\n\n");
	flags[kFLAGS.AURORA_LVL] = 1;
	if (player.hasKeyItem("Radiant shard") >= 0) player.addKeyValue("Radiant shard",1,+1);
	else player.createKeyItem("Radiant shard", 1,0,0,0);
	outputText("\n\n<b>Before fully settling in your camp as if remembering something Aurora pulls a shining shard from her inventory and hand it over to you as a gift. You acquired a Radiant shard!</b>");
	doNext(camp.returnToCampUseOneHour);
}

public function auroraCampMenu():void {
	clearOutput();
	outputText("As you approach Aurora, she turns toward you as she notices you’re walking towards her.\n\n\"<i>Greetings [Master], What do you need?</i>\"\n\n");
	menu();
	addButton(0, "Appearance", auroraAppearance).hint("Examine Aurora appearance.");
	//talk
	addButton(4, "Spar", auroraSparsWithPC).hint("Ask Aurora for a mock battle.")
		.disableIf((flags[kFLAGS.PLAYER_COMPANION_1] == "Aurora" || flags[kFLAGS.PLAYER_COMPANION_2] == "Aurora"), "You can't fight against her as long she's in your team.")
		.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 2, "You need a good sparring ring for that.");
	if (player.hasPerk(PerkLib.BasicLeadership)) addButton(5, "Team", auroraHenchmanOption);
	else addButtonDisabled(5, "Team", "You need to have at least Basic Leadership to form a team.");
	if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] > 0) {
		if (camp.FisheryWorkersCount() < camp.FisheryMaxWorkersCount() && flags[kFLAGS.PLAYER_COMPANION_1] != "Aurora" && flags[kFLAGS.PLAYER_COMPANION_2] != "Aurora") addButton(6, "Fishery Work", sendToFishery);
		if (flags[kFLAGS.FOLLOWER_AT_FISHERY_1] == "Aurora" || flags[kFLAGS.FOLLOWER_AT_FISHERY_2] == "Aurora" || flags[kFLAGS.FOLLOWER_AT_FISHERY_3] == "Aurora") addButton(6, "Stop Work", backFromFishery);
	}
	else addButtonDisabled(6, "???", "You need to have functional fishery first.");
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
	outputText("\"<i>As you command [master].</i>\"");
	startCombat(new Aurora());
}
public function AuroraWonSparring():void {
	clearOutput();
	outputText("\"<i>I spotted a few flaws in your combat patterns, [Master],</i>\" she says while smiling due to winning the mock battle against her [master].");
	cleanupAfterCombat();
}
public function AuroraLostSparring():void {
	clearOutput();
	outputText("\"<i>I need get stronger to be of better use to [Master],</i>\" she mumbles under her breath.");
	if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
		if (flags[kFLAGS.AURORA_DEFEATS_COUNTER] >= 1) flags[kFLAGS.AURORA_DEFEATS_COUNTER]++;
		else flags[kFLAGS.AURORA_DEFEATS_COUNTER] = 1;
		if (flags[kFLAGS.AURORA_DEFEATS_COUNTER] == 1 && flags[kFLAGS.AURORA_LVL] == 1) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction), 0, 0);
			flags[kFLAGS.AURORA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.AURORA_LVL] = 2;
		}
		if (flags[kFLAGS.AURORA_DEFEATS_COUNTER] == 2 && flags[kFLAGS.AURORA_LVL] == 2) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 2), 0, 0);
			flags[kFLAGS.AURORA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.AURORA_LVL] = 3;
		}
		if (flags[kFLAGS.AURORA_DEFEATS_COUNTER] == 3 && flags[kFLAGS.AURORA_LVL] == 3) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 3));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 3), 0, 0);
			flags[kFLAGS.AURORA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.AURORA_LVL] = 4;
		}/*
		if (flags[kFLAGS.AURORA_DEFEATS_COUNTER] == 4 && flags[kFLAGS.AURORA_LVL] == 4) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 4));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 4), 0, 0);
			flags[kFLAGS.AURORA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.AURORA_LVL] = 5;
		}
		if (flags[kFLAGS.AURORA_DEFEATS_COUNTER] == 5 && flags[kFLAGS.AURORA_LVL] == 5) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 5));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 5), 0, 0);
			flags[kFLAGS.AURORA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.AURORA_LVL] = 6;
		}*/
	}
	cleanupAfterCombat();
}

public function auroraHenchmanOption():void
{
	menu();
	if (flags[kFLAGS.PLAYER_COMPANION_1] == "") {
		if (flags[kFLAGS.PLAYER_COMPANION_2] == "Aurora" || flags[kFLAGS.PLAYER_COMPANION_3] == "Aurora") addButtonDisabled(0, "Team (1)", "You already have Aurora accompany you.");
		else addButton(0, "Team (1)", auroraHenchmanOption2, 1).hint("Ask Aurora to join you in adventures outside camp.");
	}
	else {
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Aurora") addButton(5, "Team (1)", auroraHenchmanOption2, 21).hint("Ask Aurora to stay in camp.");
		else addButtonDisabled(5, "Team (1)", "You already have other henchman accompany you as first party member. Ask him/her to stay at camp before you talk with Aurora about accompaning you as first party member.");
	}
	if (player.hasPerk(PerkLib.IntermediateLeadership)) {
		if (flags[kFLAGS.PLAYER_COMPANION_2] == "") {
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Aurora" || flags[kFLAGS.PLAYER_COMPANION_3] == "Aurora") addButtonDisabled(1, "Team (2)", "You already have Aurora accompany you.");
			else addButton(1, "Team (2)", auroraHenchmanOption2, 2).hint("Ask Aurora to join you in adventures outside camp.");
		}
		else {
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Aurora") addButton(6, "Team (2)", auroraHenchmanOption2, 22).hint("Ask Aurora to stay in camp.");
			else addButtonDisabled(6, "Team (2)", "You already have other henchman accompany you as second party member. Ask him/her to stay at camp before you talk with Aurora about accompaning you as second party member.");
		}
	}
	else {
		addButtonDisabled(1, "Team (2)", "Req. Intermediate Leadership.");
		addButtonDisabled(6, "Team (2)", "Req. Intermediate Leadership.");
	}
	addButton(14, "Back", auroraCampMenu);
}
public function auroraHenchmanOption2(slot:Number = 1):void
{
	clearOutput();
	if (slot < 21) {
		outputText("\"<i>As you command [master].</i>\"\n\n");
		outputText("Aurora is now following you around.\n\n");
		var strAurora:Number = 10;
		var touAurora:Number = 300;
		var meleeAtkAurora:Number = 5;
		if (flags[kFLAGS.AURORA_LVL] >= 1) {
			if (flags[kFLAGS.AURORA_LVL] == 2) {
				strAurora += 40;
				meleeAtkAurora += 4;
			}
			if (flags[kFLAGS.AURORA_LVL] == 3) {
				strAurora += 80;
				touAurora += 20;
				meleeAtkAurora += 10;
			}
			if (flags[kFLAGS.AURORA_LVL] == 4) {
				strAurora += 120;
				touAurora += 20;
				meleeAtkAurora += 18;
			}/*
			if (flags[kFLAGS.AURORA_LVL] == 5) {
				strAurora += 160;
				touAurora += 40;
				meleeAtkAurora += 28;
			}
			if (flags[kFLAGS.AURORA_LVL] == 6) {
				strAurora += 200;
				touAurora += 40;
				meleeAtkAurora += 40;
			}
			if (flags[kFLAGS.AURORA_LVL] == 7) {
				strAurora += 240;
				touAurora += 60;
				meleeAtkAurora += 54;
			}
			if (flags[kFLAGS.AURORA_LVL] == 8) {
				strAurora += 280;
				touAurora += 60;
				meleeAtkAurora += 70;
			}
			if (flags[kFLAGS.AURORA_LVL] == 9) {
				strAurora += 320;
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
		if (slot == 2) flags[kFLAGS.PLAYER_COMPANION_2] = "Aurora";
		if (slot == 1) flags[kFLAGS.PLAYER_COMPANION_1] = "Aurora";
	}
	else {
		outputText("Aurora is no longer following you around.\n\n");
		player.removeStatusEffect(StatusEffects.CombatFollowerAurora);
		if (slot == 22) flags[kFLAGS.PLAYER_COMPANION_2] = "";
		if (slot == 21) flags[kFLAGS.PLAYER_COMPANION_1] = "";
	}
	doNext(auroraCampMenu);
	cheatTime(1/12);
}

private function sendToFishery():void
{
	clearOutput();
	outputText("Information Noona here: So you bossy today and asked gargoyle servant to work at fishery.... very clever.");
	if (flags[kFLAGS.FOLLOWER_AT_FISHERY_1] == "") flags[kFLAGS.FOLLOWER_AT_FISHERY_1] = "Aurora";
	else if (flags[kFLAGS.FOLLOWER_AT_FISHERY_2] == "") flags[kFLAGS.FOLLOWER_AT_FISHERY_2] = "Aurora";
	else if (flags[kFLAGS.FOLLOWER_AT_FISHERY_3] == "") flags[kFLAGS.FOLLOWER_AT_FISHERY_3] = "Aurora";
	doNext(auroraCampMenu);
}

private function backFromFishery():void
{
	clearOutput();
	outputText("Information no one reminds your gargoyle servant no longer work at fishery.");
	if (flags[kFLAGS.FOLLOWER_AT_FISHERY_1] == "Aurora") flags[kFLAGS.FOLLOWER_AT_FISHERY_1] = "";
	else if (flags[kFLAGS.FOLLOWER_AT_FISHERY_2] == "Aurora") flags[kFLAGS.FOLLOWER_AT_FISHERY_2] = "";
	else if (flags[kFLAGS.FOLLOWER_AT_FISHERY_3] == "Aurora") flags[kFLAGS.FOLLOWER_AT_FISHERY_3] = "";
	doNext(auroraCampMenu);
}

//9 feet tall THICC bat gargoyle gurl ^^ (mk 2 ma 4 feet a Ted ma 6 and half feet czyli po miedzy wzrostami mk 2 i mk 3 xD)
//green eyes
//very long/flowing locks of [hair]
//bodyColor = "turquoise"; - turkusowa + białe podbrzusze i etc.
//hairColor = "navy blue"; - granatowe
	}
}
