/**
 * ...
 * @author Ormael (idea) & Liadri (writing)
 */
package classes.Scenes.NPCs {
	
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Scenes.Camp;
	import classes.Scenes.NPCs.Kindra;
	
	use namespace CoC;
	
	public class KindraFollower extends NPCAwareContent {
	//implements TimeAwareInterface {

public function kindraAffection(changes:Number = 0):Number
{
	flags[kFLAGS.KINDRA_AFFECTION] += changes;
	if (flags[kFLAGS.KINDRA_AFFECTION] > 100) flags[kFLAGS.KINDRA_AFFECTION] = 100;
	return flags[kFLAGS.KINDRA_AFFECTION];
}

private function bowSkill(diff:Number):Number {
	player.addStatusValue(StatusEffects.Kindra,1,diff);
	if (player.statusEffectv1(StatusEffects.Kindra) >= 95 && flags[kFLAGS.KINDRA_ADV_ARCHERY] < 3) player.changeStatusValue(StatusEffects.Kindra,1,95);
	if (player.statusEffectv1(StatusEffects.Kindra) >= 140 && flags[kFLAGS.KINDRA_ADV_ARCHERY] < 5) player.changeStatusValue(StatusEffects.Kindra,1,140);
	if (player.statusEffectv1(StatusEffects.Kindra) >= 150) player.changeStatusValue(StatusEffects.Kindra,1,150);
	return player.statusEffectv1(StatusEffects.Kindra);
}

public function lostFightToKindra():void {
	clearOutput();
	outputText("The sheep girl approach your defeated form and knock you out with a rock. You wake up not so far from the warning sign. Still sore, you head back to camp.");
	cleanupAfterCombat();
	return;
}

public function firstWonFightWithKindra():void {
	clearOutput();
	outputText("Just as you're about to finish your opponent with a decisive blow the sheep girl does a backward jump throwing a handful of grass which blinds you momentarily. When you look back she’s gone. You just head back to camp.");
	flags[kFLAGS.KINDRA_AFFECTION] = 2;
	flags[kFLAGS.KINDRA_LVL_UP] = 2;
	cleanupAfterCombat();
	return;
}

public function secondWonFightWithKindra():void {
	clearOutput();
	outputText("Just as you're about to finish your opponent with a decisive blow the sheep girl does a backward jump throwing a handful of grass which blinds you momentarily. When you look back she’s gone. You just head back to camp.");
	flags[kFLAGS.KINDRA_AFFECTION]++;
	flags[kFLAGS.KINDRA_LVL_UP]++;
	cleanupAfterCombat();
	return;
}

public function thirdWonFightWithKindra():void {
	clearOutput();
	outputText("The sheep girl fall fall down defeated then look at you finally speaking for the first time.\n\n");
	outputText("\"<i>I guess my grounds below to you now hunter. I will have to head out and hunt elsewhere...</i>\"\n\n");
	outputText("Whoa wait you just wanted to talk to her and get she was constantly attacking you.\n\n");
	outputText("\"<i>A hunter has to defend its territory lest it be taken by others. You won it fair and square also the game was becoming scarce in the area anyway it’s time for me to move.</i>\"\n\n");
	outputText("You tell her she don’t have to go this far just for you not to mention the area around your camp is ripe for hunting.\n\n");
	outputText("\"<i>Bah I stuck next to these coward up to now because I need supplies but truth be told you look like you can handle yourself so I'll come with you. Names Kindra by the way make sure you remember it.</i>\"\n\n");
	outputText("You tell her your name is [name] and that she's free to hunt around your camp. She grunt in approval then follow you back to camp.\n\n");
	outputText("(<b>Kindra has been added to the Followers menu!</b>)\n\n");
	flags[kFLAGS.KINDRA_AFFECTION]++;
	flags[kFLAGS.KINDRA_FOLLOWER] = 1;
	cleanupAfterCombat();
	return;
}

public function wonFightWithKindra():void {
	clearOutput();
	outputText("Kindra put a knee down defeated.\n\n");
	outputText("\"<i>That was a good skirmish [name] as much as I hate to admit it your the greater hunter in these grounds.</i>\"\n\n");
	outputText("You tell her she don’t have to worry about her talent as an huntress either.\n\n");
	outputText("\"<i>You don’t really get my point but it's fine perhaps you will get it eventually.</i>\"\n\n");
	outputText("The both of you head back to camp.");
	if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] >= 1) flags[kFLAGS.KINDRA_DEFEATS_COUNTER]++;
		else flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 1;
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] == 8 && flags[kFLAGS.KINDRA_LVL_UP] == 6) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 1, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 8));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 8), 0, 0, 0);
			flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KINDRA_LVL_UP] = 7;
		}
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] == 9 && flags[kFLAGS.KINDRA_LVL_UP] == 7) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 1, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 9));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 9), 0, 0, 0);
			flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KINDRA_LVL_UP] = 8;
		}
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] == 10 && flags[kFLAGS.KINDRA_LVL_UP] == 8) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 1, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 10));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 10), 0, 0, 0);
			flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KINDRA_LVL_UP] = 9;
		}
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] == 11 && flags[kFLAGS.KINDRA_LVL_UP] == 9) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 1, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 11));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 11), 0, 0, 0);
			flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KINDRA_LVL_UP] = 10;
		}
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] == 12 && flags[kFLAGS.KINDRA_LVL_UP] == 10) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 1, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 12));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 12), 0, 0, 0);
			flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KINDRA_LVL_UP] = 11;
		}
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] == 13 && flags[kFLAGS.KINDRA_LVL_UP] == 11) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 1, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 13));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 13), 0, 0, 0);
			flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KINDRA_LVL_UP] = 12;
		}
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] == 14 && flags[kFLAGS.KINDRA_LVL_UP] == 12) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 1, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 14));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 14), 0, 0, 0);
			flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KINDRA_LVL_UP] = 13;
		}
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] == 15 && flags[kFLAGS.KINDRA_LVL_UP] == 13) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 1, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 15));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 15), 0, 0, 0);
			flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KINDRA_LVL_UP] = 14;
		}
		if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] == 16 && flags[kFLAGS.KINDRA_LVL_UP] == 14) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 1, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 16));
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 16), 0, 0, 0);
			flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KINDRA_LVL_UP] = 15;
		}
	}
	kindraAffection(1);
	cleanupAfterCombat();
	return;
}
public function lostFightWithKindra():void {
	clearOutput();
	outputText("As you fall down to the ground Kindra move to you.\n\n");
	outputText("\"<i>Losing isn’t in your habits [name] I trust you just got distracted and got yourself hurt as a result. Focus your mind on the prey not the horizon and you should be fine.</i>\"\n\n");
	outputText("You thank her for this advice as she help you stand back up the both of you heading back to camp.");
	cleanupAfterCombat();
	return;
}

public function meet2Kindra():void {
	clearOutput();
	outputText("You find Kindra hunting for food in the vicinity. She notice you're there grumble about an escaped target then address you.\n\n");
	outputText("\"<i>What is it you wanted exactly [name]?</i>\"\n\n");
	menu();
	addButton(0, "Appearance", kindraAppearance).hint("Examine Kindra's detailed appearance.");
	if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) addButton(1, "Fight", fight2Kindra).hint("Fight her");
	if (player.statusEffectv1(StatusEffects.Kindra) < 150) addButton(2, "Training", trainingArcheryWithKindra).hint("Train your archery skills with her.");
	else addButtonDisabled(2, "Training", "You finished advanced archery training.");
	addButton(14, "Back", camp.campFollowers);
}

public function kindraAppearance():void
{
	clearOutput();
	outputText("Kindra is a sheep morph or so you believe. Her white hair flow on the back of her head like a mace. Her cyan pupils have something ominous about them through you cannot guess what. Her long sheep ears are alert to sound and she use them alot when hunting. She doesn't wear any clothing letting her natural sheep wool grow wherever it is necessary to cover her privates. ");
	outputText("While it doesn't cover her body she carry around a strange and ominous mask on her head in the shape of some beast.\n\n");
	outputText("Her arms looks about human albeit for the wool but her legs are shaped like those of a sheep ending in a pair of small hooves. Her lunar white skin is covered in strange tattoo design that seems to glow at time. From her well shaped ass grow a small sheep tail.\n\n");
	outputText("Surprisingly for a sheep morph her breast almost reach C cup.\n\n");
	outputText("Her fairly fair pussy is hidden under a small layer of wool.\n\n");
	menu();
	addButton(14, "Back", meet2Kindra);
}

public function fight2Kindra():void {
	clearOutput();
	outputText("Kindra adjusts her clothes and after stretching a few times she’s finished her warm up.  You raise your [weapon] and prepare to fight.  It's on!");
	startCombat(new Kindra());
}

public function trainingArcheryWithKindra():void {
	clearOutput();
	if (flags[kFLAGS.KINDRA_DAILY_TRAINING] < 1) {
		if (player.statusEffectv1(StatusEffects.Kindra) >= 140) {
			if (player.isArtifactBow()) {
				outputText("You ready your magical bow and shoot putting both your dexterity and will at the task and pushing them to the limit. Your arrows all impale one another the last striking the target with such impossible power the target fissure by the center in a cross shape and falls ground in rubble.\n\n");
				outputText("Kindra applaud you.\n\n");
				outputText("\"<i>Well wow I didn’t expect you to not only manage this feat but also actually destroy the target in the process pup. I can hereby and without doubt call you one of Mareth best archer your training is complete.</i>\"\n\n");
				outputText("\"<b>Learned Sidewinder ability!</b>\"\n\n");
				if (!player.hasStatusEffect(StatusEffects.KnowsSidewinder)) player.createStatusEffect(StatusEffects.KnowsSidewinder, 0, 0, 0, 0);
				bowSkill(10);
			}
			else {
				outputText("You head back to the archery field to resume training.\n\n");
				outputText("Your aim is true but no matter how you do it your arrows tend to only shoot around the absolute center rather than in it. At least you improved your accuracy a little today.\n\n");
				outputText("Kindra watch passively all the while but eventually calling it off for the day you both head back to camp.\n\n");
			}
			flags[kFLAGS.KINDRA_DAILY_TRAINING] = 1;
			doNext(camp.returnToCampUseFourHours);
		}
		if (player.statusEffectv1(StatusEffects.Kindra) >= 100 && player.statusEffectv1(StatusEffects.Kindra) < 140) {
			if (flags[kFLAGS.KINDRA_ADV_ARCHERY] == 4) {
				outputText("You head back to the archery field to resume training.\n\n");
			}
			else {
				outputText("Kindra brings you to the field again this time there's but a single target.\n\n");
				outputText("\"<i>Your final test is to hit the center five consecutive times without fail.</i>\"\n\n");
				outputText("At first you think this is a joke... the test has to be harder than that so you ask her what's the catch?\n\n");
				outputText("\"<i>The catch is that you can’t hit anywhere but the absolute center of this target of course which means....</i>\"\n\n");
				outputText("She draw her bow and shoots six time. You watch spellbound as all of her arrows lands not only in the center but literally impale one another striking the point zero with absolute and terrifying precision. This..this is impossible, how does she plan you to do that?!\n\n");
				outputText("\"<i>There is no time limit to this training pup. I personally expect even in the best conditions it will take you at least a month of constant training to even get this trick now get to it.</i>\"\n\n");
				flags[kFLAGS.KINDRA_ADV_ARCHERY] = 4;
			}
			outputText("Your aim is true but no matter how you do it your arrows tend to only shoot around the absolute center rather than in it. At least you improved your accuracy a little today.\n\n");
			outputText("Kindra watch passively all the while but eventually calling it off for the day you both head back to camp.\n\n");
			if (player.spe < 200) {
				dynStats("spe", 5);
			}
			if (player.inte < 200) {
				dynStats("inte", 5);
			}
			if (player.spe >= 150 && player.inte >= 120) flags[kFLAGS.KINDRA_ADV_ARCHERY] = 5;
			bowSkill(10);
			flags[kFLAGS.KINDRA_DAILY_TRAINING] = 1;
			doNext(camp.returnToCampUseFourHours);
		}
		if (player.statusEffectv1(StatusEffects.Kindra) >= 50 && player.statusEffectv1(StatusEffects.Kindra) < 100) {
			if (flags[kFLAGS.KINDRA_ADV_ARCHERY] == 2) {
				outputText("You head to the training field with Kindra to resume shooting.\n\n");
			}
			else {
				outputText("Kindra brings you to the training field as usual but this time she lined several target each at different ranges.\n\n");
				outputText("\"<i>Shooting the same target over and over is cute but enemies will change distance moving closer or farther during battle. Your beyond shooting a stationary target now. Your training today is to shoot those targets in rapid fire and constantly adapt to the changing distance. Once you reliably hit all targets in the center we can continue.</i>\"\n\n");
				flags[kFLAGS.KINDRA_ADV_ARCHERY] = 2;
			}
			outputText("This training is somewhat harder than anything you’ve tried so far. You shoot those targets for a while missing quite a few shots. After a few hour you indeed gain in accuracy and fluidity your arrows hitting the targets more often. ");
			outputText("This doesn’t prevent Kindra mocking you when you fail at hitting targets entirely but strangely her taunts helps you push yourself harder and harder. Perhaps because you want to prove the sheep morph wrong.\n\n");
			if (player.spe < 150) {
				dynStats("spe", 5);
			}
			if (player.inte < 120) {
				dynStats("inte", 5);
			}
			if (player.statusEffectv1(StatusEffects.Kindra) >= 90 && player.spe >= 150 && player.inte >= 120) {
				outputText("Kindra watch satisfied as your arrows hits the five consecutives targets right in their centers.\n\n");
				outputText("\"<i>Good that will be all for today. I have a new training for you tomorrow that will push your skill to the limit. For now go rest pup you earned it.</i>\"\n\n");
				outputText("\"<b>Learned Barrage ability!</b>\"\n\n");
				if (!player.hasStatusEffect(StatusEffects.KnowsBarrage)) player.createStatusEffect(StatusEffects.KnowsBarrage, 0, 0, 0, 0);
				flags[kFLAGS.KINDRA_ADV_ARCHERY] = 3;
			}
			bowSkill(10);
			flags[kFLAGS.KINDRA_DAILY_TRAINING] = 1;
			doNext(camp.returnToCampUseFourHours);
		}
		if (player.statusEffectv1(StatusEffects.Kelt) >= 100 && player.statusEffectv1(StatusEffects.Kindra) < 50) {
			if (flags[kFLAGS.KINDRA_ADV_ARCHERY] == 1) {
				outputText("\"<i>I see you here for more archery training pup... lets see what you can do.</i>\"\n\n");
			}
			else {
				outputText("You ask Kindra if she would mind to teach you how to properly use a bow. She’s quite skilled. She ask a few question then nod satisfied.\n\n");
				outputText("\"<i>You know the basics which is a good start and something I can work with. Keep in mind I won’t be going easy on you. If you thought your first teacher was a cold hearted jackass then know I will likely be pushing you hard just as much if not more pup. Our training begins now.</i>\"\n\n");
				flags[kFLAGS.KINDRA_ADV_ARCHERY] = 1;
			}
			outputText("She leads you to a nearby field where she set a target and has you practice your aim in various sometime weird condition such as doing jump shots or shooting while running. It doesn’t come as a surprise that the majority of your shots miss.\n\n");
			outputText("\"<i>Eyes the prey not the horizon. You ain’t aiming straight at all! Stop thinking about fucking and concentrate on the target!</i>\"\n\n");
			outputText("You get at it for several hours until you're so tired you can no longer pull your bowstring.\n\n");
			if (player.inte < 100) {
				outputText("\"<i>That will do for today pup ask me tomorrow to resume training.</i>\"\n\n");
				dynStats("spe", 5);
				dynStats("inte", 5);
			}
			if (player.statusEffectv1(StatusEffects.Kindra) >= 40) {
				outputText("\"<i>Not bad you're hitting the center as you should. We can move on to step two tomorrow, I expect you to be ready.</i>\"\n\n");
			}
			if (player.statusEffectv1(StatusEffects.Kindra) < 10) player.createStatusEffect(StatusEffects.Kindra,10,0,0,0);
			else bowSkill(10);
			flags[kFLAGS.KINDRA_DAILY_TRAINING] = 1;
			doNext(camp.returnToCampUseFourHours);
		}
		if (player.statusEffectv1(StatusEffects.Kelt) < 100) {
			outputText("You ask Kindra if she would mind to teach you how to properly use a bow. She’s quite skilled. She ask a few question then sigh in disappointment.\n\n");
			outputText("\"<i>You don’t seem to have any proper training. You will need to learn the base from someone else as I don’t teach to beginners.</i>\"\n\n");
			doNext(meet2Kindra);
		}
	}
	else {
		outputText("You ask for more lesson from Kindra but she answers by the negative.\n\n");
		outputText("\"<i>It’s pointless to teach you anything more right now. Start by letting what you learned today sink in well resume training tomorrow.</i>\"\n\n");
		doNext(meet2Kindra);
	}
}
}
}