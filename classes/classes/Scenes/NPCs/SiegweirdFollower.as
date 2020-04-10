/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Monsters.ImpLord;
import classes.Scenes.NPCs.Siegweird;
import classes.display.SpriteDb;

public class SiegweirdFollower extends NPCAwareContent
	{
		
		public function SiegweirdFollower() 
		{}

public function siegweirdFirstEncounter():void
{
	//spriteSelect(SpriteDb.);
	clearOutput();
	outputText("You are traveling through the blight ridge when you hear a sound. It would seem that amongst the many armors that litter the floor, at least one is actually sitting.\n\n");
	outputText("\"<i>Mmmmmmm…..</i>\"");
	outputText("Ok, that strange spherical armor set definitely made a sound.\n\n");
	outputText("\"<i>Mmmmmmmnmmmmmmm...</i>\"");
	outputText("You poke the helmet and the knight inside, because it’s clearly a knight, suddenly looks at you, surprised. It's a bear morph with white fur, for all you can tell of the ursine face in the big round helmet, and he looks quite pensive.\n\n");
	outputText("\"<i>I’ve been unable to solve this problem for days, but I’m in quite a pickle as my sword was stolen by an imp somewhere on the ridge.. Mmmmm… I’m sure there is a way to recover it.</i>\"");
	menu();
	addButton(1, "Help him", siegweirdFirstEncounterHelpHim).hint("Helping him may lead to recrutiment (if all went according to the plan) so that will lock out chance to get Alvina. So think carefully fi you sure you want get him over Alvina.");
	addButton(3, "Do not help him", siegweirdFirstEncounterDoNotHelpHim).hint("Later on PC will be still able meet him and get offer to help.");
}
public function siegweirdFirstEncounterHelpHim():void
{
	//spriteSelect(SpriteDb.);
	clearOutput();
	outputText("You leave the weird bear knight to his monologue and start searching for the imp in question. A few hours later your efforts are rewarded, an imp suddenly pops out of nowhere, trying to attack you with the greatsword you were looking for!\n\n");
	flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 2;
	player.createStatusEffect(StatusEffects.SiegweirdImp,0,0,0,0);
	startCombat(new ImpLord());
}
public function siegweirdFirstEncounterDoNotHelpHim():void
{
	flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 1;
	doNext(camp.returnToCampUseOneHour);
}

public function siegweirdFirstEncounterPostFight():void
{
	outputText("You kick the imp away and take the sword. Going back to the outskirts of the ridge, where the knight should still be. As soon as you get there you present it to him, asking the bear morph if this was what he was looking for.\n\n");
	outputText("\"<i>My sword! Wonderful, I’m saved and so is my quest! Thank you, traveler. I, Siegweird, paladin of Catelyna, thank you for your assistance!</i>\"");
	cleanupAfterCombat();
	if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3) siegweirdFirstEncounterPostFightAnotherFight();
	else siegweirdFirstEncounterPostFightJoin();
}
public function siegweirdFirstEncounterPostFightJoin():void
{
	outputText("Is this buffoon really a paladin? You weren't sure about him until now. That and the fact he openly claim to be a holy warrior in the middle of enemy territory either makes him the dumbest or the strongest warrior around here. Does that mean he actually knows magic?\n\n");
	outputText("\"<i>My, of course I do. I was trained in the use of white magic as well as swords. Perhaps I could teach you if you promise to help me on my glorious quest to defeat the demons.</i>\"\n\n");
	outputText("Would you like to invite Siegweird to your camp? This choice might be a very important one.\n\n");
	menu();
	addButton(1, "Yes", siegweirdFirstEncounterPostFightJoinYes);
	addButton(3, "No", siegweirdFirstEncounterPostFightJoinNo);
}
public function siegweirdFirstEncounterPostFightJoinYes():void
{
	outputText("Well he sure is an enthusiastic one. You tell him you would gladly take him to your camp and Siegweird follows you there.\n\n");
	outputText("<b>Siegweird has joined you as a follower.</b>\n\n");
	flags[kFLAGS.ALVINA_FOLLOWER] = 12;
	if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 2.5) {
		flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 4;
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 4;
		doNext(camp.returnToCampUseSixHours);
	}
}
public function siegweirdFirstEncounterPostFightJoinNo():void
{
	outputText("While you do have the utmost respect for any and all fellow adventurers you can't take Siegweird seriously at all. Beside you think a paladin this noisy is definitely bound to attract a demon army to your home. Thus you politely decline Siegweird offer, saying that you must be on your way.\n\n");
	outputText("\"<i>Ah this is fine, just seek me out if you ever change your mind, now I must be back to my hunt… right after I finish my nap.</i>\"\n\n");
	outputText("The snoring noise coming from the armor tells you the discussion is over, thus you head back to camp.\n\n");
	if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 2.5) doNext(camp.returnToCampUseOneHour);
	else {
		flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 2.5;
		doNext(camp.returnToCampUseSixHours);
	}
}
public function siegweirdFirstEncounterPostFightAnotherFight():void
{
	outputText("The paladin suddenly notice your demonic outlook and looks at you in stupor just before he starts swearing and charging at you.\n\n");
	outputText("\"<i>Damn it! Can’t believe I was helped out by a demon, this has to be a trick and I won’t fall for it. Die, fiend!</i>\"");
	startCombat(new Siegweird());
}
public function siegweirdFirstEncounterPostFightAnotherFightWon():void
{
	outputText("You proceed to finish off the bear morph and collect his holy symbol as proof of his demise. Alvina will be very pleased about this.\n\n");
	outputText("<b>You obtained Siegweird's holy symbol!</b>\n\n");
	player.createKeyItem("Siegweird's holy symbol", 0, 0, 0, 0);
	flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 3;
	doNext(camp.returnToCampUseSixHours);
}
public function siegweirdFirstEncounterPostFightAnotherFightLost():void
{
	outputText("Siegweird looks at your kneeling form for a moment, then the last thing you see is his sword rushing for your neck as he finishes you off, clean and quick.\n\n");
	EventParser.gameOver();
}

public function siegweirdRepeatEncounterPostFight():void
{
	if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3) {
		clearOutput();
		outputText("You find Siegweird about where you left him. He's still patrolling the ridge looking for his target which you assume right now is having a good read next to your camp. The moment he spots you however, he does not greet you warmly.\n\n");
		outputText("\"<i>So you came back after all. I should've known, you've been working with this witch from the start haven't you? Even went so far as to sell your soul to her? I don't know what she promised you but in the end you will come to regret it, be it by my blade or by some twisted machinations she may have prepared for you.</i>\"\n\n");
		outputText("You tell him you're here for his pendant and his life and that you ain't leaving without it.\n\n");
		outputText("\"<i>Of course you are… it's a shame that I'll have to put you down.</i>\"\n\n");
		outputText("Siegweird draws his massive bastard sword as you ready for battle, the paladin does not intend to go down easy and neither will you.\n\n");
		startCombat(new Siegweird());
	}
	else if (flags[kFLAGS.ALVINA_FOLLOWER] > 12) {
		outputText("Is this buffoon really a paladin? You weren't sure about him until now. That and the fact he openly claim to be a holy warrior in the middle of enemy territory either makes him the dumbest or the strongest warrior around here. Does that mean he actually knows magic?\n\n");
		outputText("\"<i>My, of course I do. I was trained in the use of white magic as well as swords. I would teach you but alas my quarry vanished from her lair recently. I cannot settle down while evil runs rampant. I must say farewell to you for now brave hero, may luck always be on your path.</i>\"\n\n");
		outputText("On this he heads back into the open fields looking for his target. Well that was a strange encounter if anything.\n\n");
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		outputText("While exploring the Ridge you run into Siegweird of Catelyna who is as his usual lost in some important puzzle or dilemma of his. How do you know it’s him and not someone else in the armor? Well the 'Mmmmmm' gave him away. Noticing you he waves at you with his chubby steel gauntlet.\n\n");
		outputText("\"<i>Ahhh good afternoon [name], your company is most welcome. Did you perhaps change your mind on your decision to skip on my training?</i>\"\n\n");
		menu();
		addButton(1, "Yes", siegweirdFirstEncounterPostFightJoinYes);
		addButton(3, "No", siegweirdFirstEncounterPostFightJoinNo);
	}
}

public function siegweirdMainCampMenu():void
{
	//spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("You wave a hearty hello to Siegweird who responds likewise. Though only after mumbling his classic “Mmmmmh” for a moment realising you’re addressing him shortly after.\n\n");
	outputText("\"<i>Oh?! Good day [name] how is the world treating you?!</i>\"\n\n");
	menu();
	if (player.statusEffectv1(StatusEffects.SiegweirdSoup) == 1) addButtonDisabled(5, "Soup", "You already ate today bowl of Siegweird’s soup.");
	else addButton(5, "Soup", siegweirdCampSoup);
	if ((player.hasItem(consumables.ICICLE_, 1) && player.statusEffectv1(StatusEffects.SiegweirdSoup1) < 1) || (player.hasItem(consumables.CANINEP, 1) && player.statusEffectv1(StatusEffects.SiegweirdSoup2) < 1) || (player.hasItem(consumables.BAYRLEA, 1) && player.statusEffectv1(StatusEffects.SiegweirdSoup3) < 1) || (player.hasItem(consumables.SALAMFW, 1) && player.statusEffectv1(StatusEffects.SiegweirdSoup4) < 1) || 
	(player.hasItem(consumables.LABOVA_, 1) && player.statusEffectv1(StatusEffects.SiegweirdSoup5) < 1) || (player.hasItem(consumables.RINGFIG, 1) && player.statusEffectv2(StatusEffects.SiegweirdSoup1) < 1) || (player.hasItem(consumables.ALICORN, 1) && player.statusEffectv2(StatusEffects.SiegweirdSoup2) < 1) || (player.hasItem(consumables.WOFRUIT, 1) && player.statusEffectv2(StatusEffects.SiegweirdSoup3) < 1) || 
	(player.hasItem(consumables.MAGSEED, 1) && player.statusEffectv2(StatusEffects.SiegweirdSoup4) < 1) || (player.hasItem(consumables.NOCELIQ, 1) && player.statusEffectv2(StatusEffects.SiegweirdSoup5) < 1) || (player.hasItem(consumables.GODMEAD, 1) && player.statusEffectv3(StatusEffects.SiegweirdSoup1) < 1)) addButton(9, "Add an ingredient", siegweirdCampSoup2);
	else addButtonDisabled(9, "Add an ingredient", "Need to have one of those: Icicle, Canine pepper, Bayr leaf, Firemander whisky, La bova, Ringtail fig, Alicornium, Wonder fruit, Magic seed, Nocello or God Mead to be able to improve soup.");
	if (player.hasStatusEffect(StatusEffects.SiegweirdTraining)) addButtonDisabled(10, "Study", "You already completed basic Study.");
	else addButton(10, "Study", siegweirdCampStudy);
	if (player.hasStatusEffect(StatusEffects.SiegweirdTraining) && !player.hasStatusEffect(StatusEffects.SiegweirdTraining2)) addButton(11, "Advanced Study", siegweirdAdvancedCampStudy);
	if (player.hasStatusEffect(StatusEffects.SiegweirdTraining2)) {
		if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 0 && player.hasItem(useables.DIAMOND, 1) && player.hasItem(useables.S_INGOT, 1) && (player.hasItem(useables.DBAPLAT, 1) || player.hasItem(useables.TBAPLAT, 1))) addButton(11, "Advanced Study", siegweirdAdvancedCampStudy);
		else addButtonDisabled(11, "Advanced Study", "You need to gather a perfect Diamond, Silver ingot and a piece of bark from oldest tree (Marae) before you can progress.");
		if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 1) {
			if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] < 10) addButtonDisabled(11, "Advanced Study", "You need to wait until Siegweird ends his work. (It may take around three days)");
			else addButton(11, "Advanced Study", siegweirdAdvancedCampStudy);
		}
		if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 2) {
			if (player.hasKeyItem("Alvina's Shattered Phylactery") >= 0) addButton(11, "Advanced Study", siegweirdAdvancedCampStudy);
			else addButtonDisabled(11, "Advanced Study", "You need to go kill certain dangerous devil in Blight Ridge.");
		}
		if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 3) addButtonDisabled(11, "Advanced Study", "You already completed Advanced Study.");
	}
	addButton(14, "Back", camp.campFollowers);
}

public function siegweirdCampSoup():void
{
	clearOutput();
	if (player.hasStatusEffect(StatusEffects.SiegweirdSoup)) {
		outputText("You inquire on Siegweird’s soup. Does he have a few bowls ready?\n\n");
		outputText("\"<i>Sure there's plenty to share! Here, have one on me, it will help you recover from your tiresome battles. To our valour and to our duty as heroes ahahahaha!</i>\"\n\n");
		outputText("You share the meal with Siegweird, the magical soup replenishing your endurance and healing your wounds.\n\n");
		player.addStatusValue(StatusEffects.SiegweirdSoup, 1, 1);
		player.hunger = player.maxHunger();
		var recoveryV:Number = 0.25;
		if (player.statusEffectv1(StatusEffects.SiegweirdSoup1) == 1) recoveryV += 0.05;
		if (player.statusEffectv1(StatusEffects.SiegweirdSoup2) == 1) recoveryV += 0.05;
		if (player.statusEffectv1(StatusEffects.SiegweirdSoup3) == 1) recoveryV += 0.05;
		if (player.statusEffectv1(StatusEffects.SiegweirdSoup4) == 1) recoveryV += 0.05;
		if (player.statusEffectv1(StatusEffects.SiegweirdSoup5) == 1) recoveryV += 0.05;
		if (player.statusEffectv2(StatusEffects.SiegweirdSoup1) == 1) recoveryV += 0.05;
		if (player.statusEffectv2(StatusEffects.SiegweirdSoup2) == 1) recoveryV += 0.05;
		if (player.statusEffectv2(StatusEffects.SiegweirdSoup3) == 1) recoveryV += 0.05;
		if (player.statusEffectv2(StatusEffects.SiegweirdSoup4) == 1) recoveryV += 0.05;
		if (player.statusEffectv2(StatusEffects.SiegweirdSoup5) == 1) recoveryV += 0.05;
		if (player.statusEffectv3(StatusEffects.SiegweirdSoup1) == 1) recoveryV += 0.05;
		HPChange(Math.round(player.maxHP() * recoveryV), true);
		EngineCore.changeFatigue(-(Math.round(player.maxFatigue() * recoveryV)));
		doNext(camp.campFollowers);
		cheatTime2(15);
	}
	else {
		outputText("You notice Siegweird cooking a cauldron of some kind of potion and inquire about it.\n\n");
		outputText("\"<i>Oh?!? That’s nothing dangerous [name] this here is my famous home cooked soup. It does not look like it but a good meal can help your performance and help relieve you of the stress and fatigue of battle. The cauldron is enchanted so that once it’s full it nevers depletes, therefore whenever you want a bowl just ask. However you can only have one per day as to give a chance for the cauldron to replenish the content.</i>\"\n\n");
		outputText("Can the soup even be improved? It smells wonderful already.\n\n");
		outputText("\"<i>Yeah, sure if you find some special ingredients across Mareth. Bring them here and I can add them to the soup.</i>\"\n\n");
		player.createStatusEffect(StatusEffects.SiegweirdSoup, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.SiegweirdSoup1, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.SiegweirdSoup2, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.SiegweirdSoup3, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.SiegweirdSoup4, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.SiegweirdSoup5, 0, 0, 0, 0);
		menu();
		addButton(14, "Back", siegweirdMainCampMenu);
	}
}
public function siegweirdCampSoup2():void
{
	clearOutput();
	outputText("You drop the ingredient into the pot and Siegweird looks at you surprised.\n\n");
	outputText("\"<i>Oh how could I have not thought of that! Thank you [name] the soup should be even better now!</i>\"\n\n");
	if (player.hasItem(consumables.ICICLE_, 1)) {
		player.destroyItems(consumables.ICICLE_, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup1, 1, 1);
	}
	if (player.hasItem(consumables.CANINEP, 1)) {
		player.destroyItems(consumables.CANINEP, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup2, 1, 1);
	}
	if (player.hasItem(consumables.BAYRLEA, 1)) {
		player.destroyItems(consumables.BAYRLEA, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup3, 1, 1);
	}
	if (player.hasItem(consumables.SALAMFW, 1)) {
		player.destroyItems(consumables.SALAMFW, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup4, 1, 1);
	}
	if (player.hasItem(consumables.LABOVA_, 1)) {
		player.destroyItems(consumables.LABOVA_, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup5, 1, 1);
	}
	if (player.hasItem(consumables.RINGFIG, 1)) {
		player.destroyItems(consumables.RINGFIG, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup1, 2, 1);
	}
	if (player.hasItem(consumables.ALICORN, 1)) {
		player.destroyItems(consumables.ALICORN, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup2, 2, 1);
	}
	if (player.hasItem(consumables.WOFRUIT, 1)) {
		player.destroyItems(consumables.WOFRUIT, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup3, 2, 1);
	}
	if (player.hasItem(consumables.MAGSEED, 1)) {
		player.destroyItems(consumables.MAGSEED, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup4, 2, 1);
	}
	if (player.hasItem(consumables.NOCELIQ, 1)) {
		player.destroyItems(consumables.NOCELIQ, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup5, 2, 1);
	}
	if (player.hasItem(consumables.GODMEAD, 1)) {
		player.destroyItems(consumables.GODMEAD, 1);
		player.addStatusValue(StatusEffects.SiegweirdSoup1, 3, 1);
	}
	doNext(camp.campFollowers);
	cheatTime2(5);
}

public function siegweirdCampStudy():void
{
	//spriteSelect(SpriteDb.);
	clearOutput();
	outputText("You tell Siegweird you would like to learn more about white magic.\n\n");
	outputText("\"<i>So I heard. I’m afraid I’m not the best of teachers, but there are many things I can show you to fight against the demon’s corruptive influences. Still, before I teach you new spells, you need to purify your mind, as white magic is easier to learn when you are not plagued by impure thoughts.</i>\"\n\n");
	if (player.cor > 30) {
		outputText("You tell Siegweird that the moment you are purified, you will seek him out.\n\n");
		doNext(camp.campFollowers);
		cheatTime2(5);
	}
	else {
		outputText("You tell Siegweird you feel pure enough to concentrate correctly and he nods.\n\n");
		outputText("\"<i>That should be enough for now, regardless, we will start with the fundamentals. White magic has been practiced for millennia by priests and knights. It’s been mainly used to imbue equipment or regenerate wounds, through the darker arts, of which I will not speak, ");
		outputText("developed a more direct version of this ability in the form of the heal spell, something which even today is still viewed as a blasphemy by most practitioners of the Way of the White. I will now lay down a few pieces of equipment on the ground. ");
		outputText("I want you to take your time and enchant each of them with magic. This should improve your casting endurance as well as the quality of your enchantments.</i>\"\n\n");
		if (player.inte > 70 && flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 6) {
			outputText("A few pieces was a literal joke on the bear’s part, what he displayed was nothing short of his full inventory! You spend the entire day enchanting armor pieces and weapons. It's quite an exhausting task but you eventually finish enchanting the last item. In the end, it wasn’t as exhausting as before and, truth be told, you have tons of energy left! Siegweird takes a look at your work, nodding.\n\n");
			outputText("\"<i>Mmmmm... that should do, you seem to be ready for the next step, however, you should first purge your mind of corruption entirely.</i>\"\n\n");
			player.createStatusEffect(StatusEffects.SiegweirdTraining, 0, 0, 0, 0);
			dynStats("inte", 10, "cor", -3);
			player.fatigue = player.maxFatigue();
			flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 7;
		}
		else if (player.inte > 50 && flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 5) {
			outputText("A few pieces was a literal joke on the bear’s part, what he displayed was nothing short of his full inventory! You spend the entire day enchanting armor pieces and weapons. It's quite an exhausting task but you eventually finish enchanting the last item. You feel yourself growing better each time you try. Siegweird examines your progress and nods.\n\n");
			outputText("\"<i>Great job so far but you can still improve. Come back again when you are rested, then we can resume the training.</i>\"\n\n");
			dynStats("inte", 7, "cor", -2);
			player.fatigue = player.maxFatigue();
			flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 6;
		}
		else {
			outputText("A few pieces was a literal joke on the bear’s part, what he displayed was nothing short of his full inventory! You spend the entire day enchanting armor pieces and weapons. It's quite an exhausting task and truth be told, you ran out of energy way before you were finished enchanting the last piece of gear.\n\n");
			outputText("\"<i>You are only starting so it's normal that you are exhausted. Come back again when you are rested then we can resume the training.</i>\"\n\n");
			dynStats("inte", 4, "cor", -1);
			player.fatigue = player.maxFatigue();
			flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 5;
		}
		doNext(camp.returnToCampUseSixHours);
	}
}

public function siegweirdAdvancedCampStudy():void
{
	if (player.hasStatusEffect(StatusEffects.SiegweirdTraining2)) {
		if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 2) {
			player.removeKeyItem("Alvina's Shattered Phylactery");
			outputText("Siegweird notices that you have the pendant as soon as you come near him, giving you a cheerful smile.\n\n");
			outputText("\"<i>On this day, friend, a great evil was vanquished! You, perhaps, have helped the cause of purity more than you would think. While not the leader of the demonic horde, Alvina was easily as threatening, if not worse then Lethice, and could have tipped the scale of the war in their favor at any time. Also this Tome is for you, I never was good enough to understand it anyway.</i>\"\n\n");
			outputText("<b>You gained a tome of Meteor Shower.</b>\n\n");
			player.addStatusValue(StatusEffects.SiegweirdTraining2, 1, 1);
			inventory.takeItem(consumables.MET_SHO, camp.campFollowers);
			cheatTime2(5);
		}
		else if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 1 && flags[kFLAGS.SIEGWEIRD_FOLLOWER] == 10) {
			outputText("Siegweird notices your presence and stops hammering on his portable anvil to look at you with a cheerful smile… or at least what you can see through the small hole in his helmet.\n\n");
			outputText("\"<i>Hey hello [name]!I finished your holy symbol, it should empower your white magic ability further. Consider this your graduation gift.</i>\"\n\n");
			outputText("He brings over the fruits of his labor and hands it to you. The holy symbol shines with an inner light that simply cannot be snuffed out. You feel serene and safe with this item on you and thank Siegweird for it.\n\n");
			outputText("\"<i>No need to thank me friend. Say I think I will stay in your camp a little longer. There's enough imps around here to keep me working for weeks! Also I will prepare a curative soup every day, so feel free to come by and take a bowl.</i>\"\n\n");
			outputText("<b>You gained a Holy Symbol. +20% to white spells and white healing magic spellpower.</b>\n\n");
			player.createKeyItem("Holy Symbol", 0, 0, 0, 0);
			player.addStatusValue(StatusEffects.SiegweirdTraining2, 1, 1);
			doNext(camp.campFollowers);
			cheatTime2(5);
		}
		else {
			player.destroyItems(useables.DIAMOND, 1);
			player.destroyItems(useables.S_INGOT, 1);
			if (player.hasItem(useables.DBAPLAT, 1)) player.destroyItems(useables.DBAPLAT, 1);
			else player.destroyItems(useables.TBAPLAT, 1);
			outputText("You bring the ingredients to Siegweird, who applauds your initiative.\n\n");
			outputText("\"<i>Good! Now, while I will forge this item for you right now and hand it over in a day, I would also need you to do a favor for me. See, I wasn’t wandering the blight ridges for no reason, I was  hunting a very specific demoness. Her name is Alvina, and she is rumored to be the creator of black magic and perhaps even the source of the demonic corruption. ");
			outputText("I don’t know her full story but what I am sure about is that even the other demons whisper her name in hushed tones so she ought to be fearsome even by their standards. I would request that you find and slay her. I found a magic tome in some ruins containing a very ancient and powerful white magic spell to reward you with, should you do so.</i>\"\n\n");
			outputText("Siegweird pulls out a portable anvil and starts working, waving you off.\n\n");
			player.addStatusValue(StatusEffects.SiegweirdTraining2, 1, 1);
			doNext(camp.campFollowers);
			cheatTime2(5);
		}
	}
	else {
		if (player.cor > 0) {
			outputText("You ask Siegweird about those extra lessons.\n\n");
			outputText("\"<i>Mmmmmmm… like I said before, I can teach you this only if you are entirely pure. Come back when you are.</i>\"\n\n");
		}
		else {
			outputText("You ask Siegweird about those extra lessons.\n\n");
			outputText("\"<i>Mmmmmmm… you look about ready to me, so let’s begin with the facts. To channel white magic to its fullest you will also need a holy symbol. While white magic was created by mortals, its origin lies deeper in the roots of divine magic, which belong to the gods. ");
			outputText("Making a holy symbol is as easy as carving a cross out of wood however, the material will increase the potency of the item. I would need you to find barks from the world's oldest tree and bring it to me. If you can find a silver ingot, the material could serve as the casing. ");
			outputText("Finally, a perfect diamond will be the ornament. You should get going and start looking for these items, they are somewhat rare.</i>\"\n\n");
			player.createStatusEffect(StatusEffects.SiegweirdTraining2, 0, 0, 0, 0);
		}
		doNext(camp.campFollowers);
		cheatTime2(5);
	}
}

	}

}