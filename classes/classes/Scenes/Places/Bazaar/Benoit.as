package classes.Scenes.Places.Bazaar {
import classes.*;
import classes.BodyParts.Ears;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;

//  TIMES_IN_BENOITS:int = 562;
//  BENOIT_AFFECTION:int = 563;
//  BENOIT_EXPLAINED_SHOP:int = 564;
//  BENOIT_SUGGEST_UNLOCKED:int = 565;
//  BENOIT_1:int = 567;
//  BENOIT_2:int = 568;
//  BENOIT_3:int = 569;
//  BENOIT_4:int = 1294;
//  BENOIT_5:int = 1295;
//  BENOIT_TALKED_TODAY:int = 570;
//  BENOIT_TALKED_TO_PROPERLY:int = 571;
//  BENOIT_EGGS:int = 572;
//  BENOIT_TIMES_SEXED_FEMPCS:int = 573;
//  BENOIT_BIRTH_DELAY:int = 574;
//  BENOIT_WOMB_TALK_UNLOCKED:int = 575;
//  BENOIT_POST_FIRSTFUCK_TALK:int = 576;
//  BENOIT_TESTED_BASILISK_WOMB:int = 577;
//  BENOIT_GENERIC_EGGS:int = 632;
//(Shop open between 9:00 and 17:00)
public class Benoit extends BazaarAbstractContent {

	public function Benoit()
	{
	}

//Fen, you'll need a function to determine gendered pronouns and version of name for this character. I've formatted all the eligible places I found in the order of [male/female]. -Z
public function benoitMF(stringM:String,stringF:String):String {
	if (flags[kFLAGS.BENOIT_STATUS] == 1 || flags[kFLAGS.BENOIT_STATUS] == 2 || flags[kFLAGS.BENOIT_STATUS] == 3) return stringF;
	return stringM;
}
private function benoitLover():Boolean {
	return flags[kFLAGS.BENOIT_TIMES_SEXED_FEMPCS] >= 2;
}
public function benoitAffection(changes:Number = 0):Number {
	if(changes != 0) {
		flags[kFLAGS.BENOIT_AFFECTION] += changes;
		if(flags[kFLAGS.BENOIT_AFFECTION] > 100) flags[kFLAGS.BENOIT_AFFECTION] = 100;
		else if(flags[kFLAGS.BENOIT_AFFECTION] < 0) flags[kFLAGS.BENOIT_AFFECTION] = 0;
	}
	return flags[kFLAGS.BENOIT_AFFECTION];
}

private function benoitKnocksUpPCCheck():void {
	//Convert old basi's to real basi's!
	if (player.pregnancyType == PregnancyStore.PREGNANCY_BASILISK && player.hasPerk(PerkLib.BasiliskWomb)) player.knockUpForce(PregnancyStore.PREGNANCY_BENOIT, player.pregnancyIncubation);
	if (player.pregnancy2Type == PregnancyStore.PREGNANCY_BASILISK && player.hasPerk(PerkLib.BasiliskWomb)) player.knockUpForce(PregnancyStore.PREGNANCY_BENOIT, player.pregnancy2Incubation, 1);
	//Knock up chances:
	if ((player.inHeat || player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS || player.pregnancy2Type == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS || player.hasPerk(PerkLib.HarpyWomb) || player.hasPerk(PerkLib.Oviposition) || player.hasPerk(PerkLib.BasiliskWomb)) && ((player.canGetPregnant() || player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS || player.pregnancy2Type == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS))) {
		if (player.hasPerk(PerkLib.BasiliskWomb) && flags[kFLAGS.BENOIT_TESTED_BASILISK_WOMB] == 1) {
			if (player.canGetPregnant || ((player.pregnancyType != PregnancyStore.PREGNANCY_OVIELIXIR_EGGS || player.pregnancy2Type != PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) && !player.hasUniquePregnancy())) {
				player.knockUp(PregnancyStore.PREGNANCY_BENOIT, PregnancyStore.INCUBATION_BASILISK);
			}
			if (player.pregnancyIncubation > 0 && player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) player.knockUpForce(PregnancyStore.PREGNANCY_BENOIT, player.pregnancyIncubation);
			if (player.pregnancy2Incubation > 0 && player.pregnancy2Type == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) player.knockUpForce(PregnancyStore.PREGNANCY_BENOIT, player.pregnancyIncubation, 1);
		}
		else {
			if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
			else player.knockUp(PregnancyStore.PREGNANCY_BASILISK, PregnancyStore.INCUBATION_BASILISK);
		}
	}
}

/**
	Return the "heaviness" of the pregnancy
*/
public function benoitPreggers():Boolean
{
	return flags[kFLAGS.BENOIT_STATUS] != 0 && flags[kFLAGS.FEMOIT_EGGS] > 0;
}

public function benoitRegularPreggers():Boolean
{
	return flags[kFLAGS.BENOIT_STATUS] != 0 && flags[kFLAGS.FEMOIT_EGGS] >= 1 && flags[kFLAGS.FEMOIT_EGGS] <= 4;
}

public function benoitHeavyPreggers():Boolean
{
	return flags[kFLAGS.BENOIT_STATUS] != 0 && flags[kFLAGS.FEMOIT_EGGS] >= 5 && flags[kFLAGS.FEMOIT_EGGS] <= 8;
}

public function benoitVeryHeavyPreggers():Boolean
{
	return flags[kFLAGS.BENOIT_STATUS] != 0 && flags[kFLAGS.FEMOIT_EGGS] >= 9 && flags[kFLAGS.FEMOIT_EGGS] <= 12;
}

public function benoitExtremePreggers():Boolean
{
	return flags[kFLAGS.BENOIT_STATUS] != 0 && flags[kFLAGS.FEMOIT_EGGS] >= 13;
}

public function benoitInClutch():Boolean
{
	if (flags[kFLAGS.BENOIT_STATUS] == 0) return false;

	// Benoit enters "clutch" every 21 days, for 7 days
	var startDay:int = flags[kFLAGS.FEMOIT_NEXTDAY_EVENT];
    var currDay:int = CoC.instance.model.time.days;
    var diffDays:int = (currDay - startDay) % 28;

	return diffDays >= 21;
}

/*
Cum to Clutch Equation:

Benoite becomes pregnant with 1 egg by default.

She can produce a max clutch of 16 eggs, and a PC can only make her pregnant with up to 12 eggs by cum quantity alone. Elven Bounty gives +1 to both min and max clutch size (so a PC with that perk will give her 2-13 eggs each time they fertilise her), Marae's Gift - Stud gives +2 to both min and max clutch size. These two perks stack.

Every 200mls of cum the PC produces above the first 200mls equals 1 extra egg fertilised. So, producing 2 eggs requires 400mls, 3 eggs requires 600mls, etc, all the way to 12 eggs at 2400mls.

1-4 Eggs equates to a Regular Pregnancy.
5-8 Eggs equates to a Heavy Pregnancy.
9-12 Eggs equates to a Very Heavy Pregnancy.
13-16 Eggs equates to an Extremely Heavy Pregnancy.
*/
public function numEggs():int {
	var eggMod:int = 0;
	if (player.hasPerk(PerkLib.ElvenBounty)) eggMod += 1;
	if (player.hasPerk(PerkLib.MaraesGiftStud)) eggMod += 2;
	if (player.hasPerk(PerkLib.FerasBoonAlpha)) eggMod += 1;
	var numEggs:int = player.cumQ() / 200;
	var minEggs:int = 1 + eggMod;
	var maxEggs:int = 12 + eggMod;
	if (numEggs < minEggs) numEggs = minEggs;
	if (numEggs > maxEggs) numEggs = maxEggs;
	return numEggs;
}

public function benoitKnockUp():Boolean
{
	if (benoitPreggers() || !benoitInClutch()) return false;
	if (flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS]) outputText("\n<b>Benoit is pregnant!</b>");
	flags[kFLAGS.FEMOIT_EGGS] = numEggs();
	flags[kFLAGS.FEMOIT_INCUBATION] = 168;
	return true;
}

public function benoitKnockUpSmart(next:Function):void {
	if (benoitPreggers() || !benoitInClutch()) doNext(next);
	outputText("\n\n<b>You somehow were able to <i>magically</i> control your cum flow. How much pregnant do you want to get Benoit?</b>");
	outputText("\n\nHint: it changes some sex scenes.");
	var eggs:int = numEggs();
	menu();
	addButton(0, "Regular", curry(benoitEggSet, Math.min(eggs, 4), next));
	addButtonIfTrue(1, "Heavy", curry(benoitEggSet, Math.min(eggs, 8), next), "Not enough cum!", eggs >= 5);
	addButtonIfTrue(2, "Very Heavy", curry(benoitEggSet, Math.min(eggs, 12), next), "Not enough cum!", eggs >= 9);
	addButtonIfTrue(3, "Extreme", curry(benoitEggSet, eggs, next),
		"Not enough cum (at least 2600) or no required perk (Fera's Boon / Marae's Gift - Stud / Elven Bounty) / lacks required\n(Don't worry though, the sex scene doesn't differ from 'Very Heavy').",
		eggs >= 13);
}

public function benoitEggSet(eggs:int, next:Function):void {
	flags[kFLAGS.FEMOIT_EGGS] = eggs;
	flags[kFLAGS.FEMOIT_INCUBATION] = 168;
	next();
}

public function clearBenoitPreggers():void
{
	if (flags[kFLAGS.FEMOIT_EGGS] != 0)
	{
		flags[kFLAGS.FEMOIT_EGGS_LAID] += flags[kFLAGS.FEMOIT_EGGS];
		flags[kFLAGS.FEMOIT_EGGS] = 0;
		flags[kFLAGS.FEMOIT_INCUBATION] = 0;
        flags[kFLAGS.FEMOIT_NEXTDAY_EVENT] = CoC.instance.model.time.days; // Cycle "resets" based off birth day.
    }
}

public function setBenoitShop(setButtonOnly:Boolean = false):void {
	if (model.time.hours >= 9 && model.time.hours <= 17 && (flags[kFLAGS.FEMOIT_NEXTDAY_EVENT_DONE] != 1 || CoC.instance.model.time.days >= flags[kFLAGS.FEMOIT_NEXTDAY_EVENT])) {
		if (flags[kFLAGS.TIMES_IN_BENOITS] == 0) {
			if (!setButtonOnly) outputText("\n\nYou notice a large market stall wedged between two wagons, swaddled in carpets and overflowing with all manner of objects.  On top of its looming fabric canopy is a wooden sign with the words \"Geckos Garbidg\" crudely scrawled upon them.  You wonder what that's all about.");
			else addButton(0, "Market Stall", benoitIntro);
		} else {
			if (!setButtonOnly) outputText("\n\n[benoit name] the basilisk's stall looks open for business.  You could go see what's on offer.");
			else addButton(0, "[benoit name]", benoitIntro);
		}
	} else addButtonDisabled(0, flags[kFLAGS.TIMES_IN_BENOITS] == 0 ? "???" : "[benoit name]", "Currently closed.")
}

//Introduction Scenes
public function benoitIntro():void {
	clearOutput();
	if(flags[kFLAGS.TIMES_IN_BENOITS] == 0) {
		outputText("You cautiously approach the stall.  The shadow thrown by its large, overhanging canopy makes it quite difficult to see into its interior, and getting inside is made even more hazardous by the sheer volume of objects which clutter the area around it and hang out of the shelves arranged along its wooden walls.  Everything Mareth has ever created or distilled seems to be here - or at least, everything Mareth has ever thrown out.  Pots, pans, ugly crockery, shelves stuffed with clothing, a spice rack bulging with all manner of suspect-looking potions... you imagine you could probably find anything you'd ever want in here - or something closely resembling it - if you looked hard enough.");
		outputText("\n\n\"<i>Allo?</i>\" says a raspy voice from further in the gloom.  \"<i>'Oo is zair?</i>\"  You can make out a counter constructed from crates, and a tall, thin shape behind it - a lizan, by the looks of " + benoitMF("his","her") + " build and smooth scales.  Something about his shape makes you feel uneasy, though... you shift further in to take a closer look at the stall owner.  He's seated in the only area of his shop not taken up by junk, right next to a heap of rugs and robes, and has a fez perched on top of his blunt head.  It's when he turns his grey slit eyes to you that you realize what is putting you on edge - it's a basilisk!  Panic grips you as you try to wrench your eyes away... which you do, easily.  Curious despite yourself, you look back tentatively.  The creature's eyes seem oddly milky, and they seem to be staring beyond you.  Realisation takes hold when you see the white stick balanced carefully on the counter's side.");
		outputText("\n\n\"<i>Yes, go ahead, stare,</i>\" says the basilisk in a long-suffering tone, making you jump. \"<i>It is a funny joke, yes?  Believe me, I wake up laughing about it every morning.  At least here zey stare.  In ze mountains, zey are so embarrassed zey can't even look at me.  Or at least I assume zey can't.</i>\"  He straightens his back and sets his jaw.  \"<i>'Owever, my slack-jawed friend, zis is not a freak show.  Zis is Benoit's Spectacular Salvage Shop!  So if you are not 'ere to buy or sell salvage... kindly piss off.</i>\"");

		outputText("\n\nYou wonder how a blind anything can make it in such a rough and ready place as the Bazaar, but then Benoit curls [benoit eir] claws protectively into what appears to be a pile of robes sitting next to [benoit em], which opens dark brown eyes and sets its muzzle on the counter, looking at you plaintively.  The Alsatian buried within the cloth looks to you like a big softy, but you're willing to concede the point as made.");
	}
	else if(flags[kFLAGS.BENOIT_SUGGEST_UNLOCKED] == 0 && player.hasVagina() && (player.inHeat || (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS || player.pregnancy2Type == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) || player.hasPerk(PerkLib.HarpyWomb) || player.hasPerk(PerkLib.Oviposition)) && (player.canGetPregnant() || (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS || player.pregnancy2Type == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS)) && (flags[kFLAGS.BENOIT_STATUS] == 0 || flags[kFLAGS.BENOIT_STATUS] == 3)) {
		benoitAndFemPCTalkAboutEggings();
	}
    else if (flags[kFLAGS.FEMOIT_NEXTDAY_EVENT_DONE] == 1 && flags[kFLAGS.FEMOIT_NEXTDAY_EVENT] <= CoC.instance.model.time.days && flags[kFLAGS.BENOIT_STATUS] == 0) {
		femoitNextDayEvent();
	}
	else if (benoitInClutch() && flags[kFLAGS.FEMOIT_READY_FOR_EGGS] == 0 && (flags[kFLAGS.BENOIT_STATUS] == 1 || flags[kFLAGS.BENOIT_STATUS] == 2))
	{
		flags[kFLAGS.FEMOIT_READY_FOR_EGGS]++;

		outputText("As you enter the stall Benoite looks up; though her blind, milky eyes make her harder to read, she looks excited. \"<i>Ah! [name]; it iz good you are here... I had hope zat you would come for a vizit today.</i>\"");

		outputText("\n\nShe stands up somewhat nervously, and you realize that her stomach is visibly bulging, her typical outfit straining slightly to cover the bulk of her midriff. She pats it with a timid sense of pride. \"<i>I am wiz clutch. My womb, it haz created eggz, and zey are ready to be fertilized.  I... I could be a mother now. I-if I could find myzelf a willing partner...</i>\" She trembles, despite herself; it's clear that the idea of going from lone male to expectant mother in the space of a few days is a bit much for the basilisk.");

		outputText("\n\nYou ask if she's sure she's ready for this. Benoite stiffens her spine and draws herself up proudly. \"<i>I am ready. If it is your nerve zat is weak, well... I will be with eggs for anozer few days. After that, I won't be wizzem again for zome weeks. I can wait until you are ready, if you need.</i>\"");
	}
	else if (benoitPreggers() && flags[kFLAGS.FEMOIT_INCUBATION] < 0)
	{
		// Missed it by a week
		if (flags[kFLAGS.FEMOIT_INCUBATION] < -168)
		{
			outputText("When you enter the stall, you notice that Benoite's stomach is flat again. She gives you a toothy grin when you enter her stall. \"<i>I have good newz [name]! You are a fazer! " + String(flags[kFLAGS.FEMOIT_EGGS]) + " timez over in fact! Oh I wish zat you could have helped; but I was ztrong, ztrong enough get through it on my own.</i>\" she gushes, speaking at a mile-a-minute. She's clearly pleased with herself; and your virility.");

			outputText("\n\nShe takes a moment to compose herself, still giddy with the prospect of potentially finding the answer that could save her people; although the means might not be quite what she had in mind, she seems to be taking to the situation with gusto.");

			outputText("\n\nThe world continues on though, and she has a shop to run after all; especially if she wants to provide for the hungry mouths that will soon demand her attention.");

			outputText("\n\n\"<i>Zo [name],</i>\" she starts, still a hint of excited energy prevalent in her voice, \"<i>what can Benoite azzist you wiz?</i>\"");

			clearBenoitPreggers();
			flags[kFLAGS.FEMOIT_NEXTDAY_EVENT] -= 7;
		}
		else
		{
			femoitBirths();
			return;
		}
	}
    else if (!benoitInClutch() && !benoitPreggers() && (CoC.instance.model.time.days - flags[kFLAGS.FEMOIT_NEXTDAY_EVENT] >= 30) && (flags[kFLAGS.BENOIT_STATUS] > 0)) {
		if (flags[kFLAGS.FEMOIT_FIRST_CLUTCH_MISSED] == 0)
		{
			flags[kFLAGS.FEMOIT_FIRST_CLUTCH_MISSED]++;
			outputText("When you enter the stall, you are greeted by the smell of something cooking. Investigating further brings you to the blind basilisk's small kitchen, where she is busy frying something. Her nose preoccupied with her meal, she doesn't realize you're approaching until you touch her shoulder, yelping in shock.");

			outputText("\n\n\"<i>Don't do zat!</i>\" she complains when she recognizes it's you. \"<i>I almost brained you with zis skittle.</i>\"");

			outputText("\n\nYou ask her what she's making.");

			outputText("\n\n\"<i>My lunch; an omlette,</i>\" she says.");

			outputText("\n\nYour eyes are drawn almost magnetically to her now flat-again stomach and the realization sinks in just where she got the eggs. You ask how she could have done such a thing.");

			outputText("\n\n\"<i>Do what exza- oh. Ooh. Aha, mon Dieu, [name]!</i>\" Benoite chokes out between a mix of chortles and guffaws. \"<i>Non [name], I know what it iz zat you are zinking. Aha,</i>\" she continues whilst still half laughing, but manages to calm herself down after a short pause, trying to return to some degree of seriousness. \"<i>I am just hungry. I am, how you say, having a craving for zees strange items one of my zuppliers has been selling lately. 'Cheeken eggz'? I guess my body knowz what it needs to replenish zat which it has lost?</i>\"");

			outputText("\n\nShe pats her midriff and you start to put the pieces together. \"<i>Oh. Oooh,</i>\" you mumble back as a response.");
		}
		else
		{
			outputText("The flat-bellied basilisk is tucking away into a plate laden with a heavy omlette when you arrive.");
			outputText("\n\n\"<i>Ah, [name]! What can I azzist you wiz?</i>\"");
		}
	}
	else
	{
		//Subsequent Visit, Affection 0-10:
		if(benoitAffection() <= 10) outputText("Once again, you carefully enter the gloom of Benoit's salvage shop.  The proprietor sniffs the air as you enter, and then looks at you sourly.  \"<i>Well?</i>\" [benoit ey] rasps.");
		//Benoit reacts after fucking the PC.
		else if(flags[kFLAGS.BENOIT_TIMES_SEXED_FEMPCS] == 1 && flags[kFLAGS.BENOIT_POST_FIRSTFUCK_TALK] == 0)
			firstTimeAfterBoningEncounterBenoit();
		else if(benoitAffection() < 35) outputText("Once again, you carefully enter the gloom of Benoit's salvage shop.  The proprietor sniffs the air as you enter, and then relaxes in [benoit eir] seat.  \"<i>Allo again, [name].  What brings you 'ere?</i>\"");
		//Subsequent Visit, Affection 35+ but pre-lover/pre-fem:
		else
		{
			outputText("Once again, you carefully enter the gloom of [benoit name]'s salvage shop.  The proprietor sniffs the air as you enter, and then smiles widely.  \"<i>If it isn't my favorite customer!  Do not 'ang around out zere, [name]; please, come in and let us, 'ow you say, chew ze fat.</i>\"");

			// Preggers stuff
			if (benoitInClutch() && !benoitPreggers()) outputText("\n\nAn obvious bulge in the female basilisk's apron-clad belly signals the presence of new eggs. If you were to have sex with her in this state then there's a good chance she'll end up with a belly full of fertilized eggs.");
			else if (benoitRegularPreggers()) outputText("\n\nThe basilisk's belly bulges out, big as any pregnant woman back home. Her apron merely highlights the fact she's carrying the eggs you fathered.");
			else if (benoitHeavyPreggers()) outputText("\n\nBenoite's pregnancy is unmistakable, and the number of eggs she's carrying is quite impressive. Her apron is strained to the limit to contain her distended belly, and you wonder how she manages to tie it up each morning.");
			else if (benoitVeryHeavyPreggers()) outputText("\n\nThe basilisk's belly is hugely swollen with fertilized eggs, and you notice that she tries to avoid moving unless she has to. She's so bloated that she has given up trying to tie her apron on, and instead lets it flap idly on her engorged midriff.");
			else if (benoitExtremePreggers()) outputText("\n\nYou can hardly believe just how pregnant Benoite is - you wouldn't have imagined it was possible to carry that many fertilized eggs. She's practically immobile, and when she does get up and shuffle along, her belly nearly drags along the ground; it's that swollen with your young. Needless to say, practicality demands she goes around naked.");
		}
	}

	flags[kFLAGS.TIMES_IN_BENOITS]++;

	menu();
	//Core buttons
	addButton(0, "Buy", benoitsBuyMenu);
	addButton(1, "Sell", benoitSellMenu);
	addButton(2, "Talk", talkToBenoit);
	addButton(14, "Leave", bazaar.enterTheBazaarAndMenu);
	//Feminize & Herminize
	if (flags[kFLAGS.FEMOIT_UNLOCKED] == 0) addButton(3, "HelpRace-Him", femoitInitialTalk)
		.disableIf(flags[kFLAGS.BENOIT_TIMES_SEXED_FEMPCS] > 0 || !sceneHunter.other,
			"The problem is <i>already</i> solved.\n\n"
			+ "<b>You can enable SH:Other to try this option too.</b>", "???")
		.disableIf(benoitAffection() < 40, "He doesn't trust you enough.", "???")
		.disableIf(flags[kFLAGS.BENOIT_TALKED_TO_PROPERLY] == 0, "You don't know him good enough.", "???");
	else if (flags[kFLAGS.FEMOIT_UNLOCKED] == 1 && flags[kFLAGS.BENOIT_STATUS] == 0) addButton(3, "Feminize", benoitFeminise);
	else if (flags[kFLAGS.BENOIT_STATUS] > 0 && flags[kFLAGS.BENOIT_STATUS] < 3) addButton(3, "Herminize", benoitHerminise);
	//Basilisk Womb
	if (flags[kFLAGS.BENOIT_WOMB_TALK_UNLOCKED] == 1 && (!(player.hasPerk(PerkLib.BasiliskWomb))) && flags[kFLAGS.BENOIT_TESTED_BASILISK_WOMB] == 0 && (flags[kFLAGS.BENOIT_STATUS] == 0 || flags[kFLAGS.BENOIT_STATUS] == 3)) addButton(4, "Basil. Womb", tryToConvertToBassyWomb);
	else if (flags[kFLAGS.BENOIT_WOMB_TALK_UNLOCKED] == 0) addButton(4, "HelpRace-You", talkHelp)
		.disableIf(!player.hasVagina(), "Req. a pussy.")
		.disableIf(flags[kFLAGS.BENOIT_TIMES_SEXED_FEMPCS] < 2, "Requires meeting Benoit a little <i>closer</i>.", "???");
	//Suggest & sex
	if (flags[kFLAGS.BENOIT_SUGGEST_UNLOCKED] > 0 && player.hasVagina() && (flags[kFLAGS.BENOIT_STATUS] == 0 || flags[kFLAGS.BENOIT_STATUS] == 3)) addButton(5, "Suggest", eggySuggest);
	if (flags[kFLAGS.BENOIT_STATUS] > 0) {
		if (flags[kFLAGS.FEMOIT_TALKED_TO] == 0) addButton(6, "What's next?", femoit1stTalk);
		else addButton(6, "Sex", femoitSexIntro).disableIf(player.lust < 33, "Not aroused enough.");
	}
}

//Buy or Sell First Time, only if prelover/prefem: You ask him what the deal is with his shop.
private function buyOrSellExplanationFirstTime():void {
	flags[kFLAGS.BENOIT_EXPLAINED_SHOP]++;
	outputText("\"<i>If you can see something you want in Benoit's Spectacular Salvage Shop, and you can walk away with it, it's yours,</i>\" replies Benoit, theatrically sweeping " + benoitMF("his","her") + " claw to take in the entirety of " + benoitMF("his","her") + " stall but almost knocking over a birdcage.  \"<i>Assuming you can pay whatever I've decided it's worth, of course.  If you want to unload your garbage 'ere?  Zis is also fine.  I cannot pay what ze fat cats in Tel'Adre can, though.  Check back every day; ze Spectacular Salvage Shop always 'as new zings to sell.</i>\"");
}

public function benoitsBuyMenu():void {
	clearOutput();
	if(flags[kFLAGS.BENOIT_1] == 0) updateBenoitInventory();
	if (flags[kFLAGS.BENOIT_EXPLAINED_SHOP] == 0) buyOrSellExplanationFirstTime();
	var buyMod:Number = 2;

	if (flags[kFLAGS.BENOIT_STATUS] == 1)
	{
		buyMod = 1.66;
		outputText("\"<i>Some may call zis junk,</i>\" says Benoite, indicating her latest wares.  \"<i>Me... I call it garbage.</i>\"");
	}
	else
	{
		outputText("\"<i>Some may call zis junk,</i>\" says Benoit, indicating " + benoitMF("his","her") + " latest wares.  \"<i>Me... I call it garbage.</i>\"");
	}
	outputText("\n\n<b><u>[benoit name]'s Prices</u></b>");
	var shop:/*ItemType*/Array = [];
	var item:ItemType;
	var btn:int = 0;
	for each (var flag:int in [kFLAGS.BENOIT_1, kFLAGS.BENOIT_2, kFLAGS.BENOIT_3, kFLAGS.BENOIT_4, kFLAGS.BENOIT_5])
		shop.push(ItemType.lookupItem(flags[flag]));
	menu();
	for each (item in shop) {
		var cost:int = int(buyMod * item.value);
		outputText("\n" + item.longName + ": " + cost);
		addButton(btn++, item.shortName, benoitTransactBuy, item)
			.disableIf(player.gems < cost, "Not enough gems.");
	}
	if (sceneHunter.printChecks) {
		outputText("\nCheck the new stock tomorrow!")
		outputText("\nFull list of items: ");
		for each (item in itemShop) outputText(item.shortName + ", ");
		outputText("\nFull list of armors & materials: ");
		for each (item in armorShop) outputText(item.shortName + ", ");
	}
	if (player.keyItemvX("Backpack", 1) < 12) addButton(5, "Backpack", buyBackpack).hint("This backpack will allow you to carry more items.");
	if (flags[kFLAGS.BENOIT_CLOCK_BOUGHT] <= 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND] > 0) addButton(6, "Alarm Clock", buyAlarmClock).hint("This mechanical clock looks like it was originally constructed by the Goblins before the corruption spreaded throughout Mareth.");
	if (flags[kFLAGS.BENOIT_PISTOL_BOUGHT] < 2 && flags[kFLAGS.BENOIT_AFFECTION] == 100) addButton(7, "Zweihander", buyZweihander);
	addButton(14, "Back", benoitIntro);
}

private function benoitSellMenu(page:int = 1):void {
	var slot:int;
	clearOutput();
	if (flags[kFLAGS.BENOIT_EXPLAINED_SHOP] == 0)
		buyOrSellExplanationFirstTime();
	else
		outputText("\"<i>Let us feel what you are trying to palm off upon me zis time, zen,</i>\" sighs [benoit name], sitting down and opening [benoit eir] hand to you.");
	var sellMod:int = 3;
	outputText("\n\n(You can shift-click to sell all items in a stack.)");
	if (flags[kFLAGS.BENOIT_EGGS] > 0 || flags[kFLAGS.BENOIT_STATUS] != 0) sellMod = 2;
	outputText("\n\n<b><u>[benoit name]'s Estimates</u></b>");
	menu();
	var totalItems:int = 0;
	if (page == 1) {
		for (slot = 0; slot < 10; slot++) {
			if (player.itemSlots[slot].quantity > 0 && int(player.itemSlots[slot].itype.value / sellMod) >= 1) {
				outputText("\n" + int(player.itemSlots[slot].itype.value / sellMod) + " gems for " + player.itemSlots[slot].itype.longName + ".");
				addButton(slot, (player.itemSlots[slot].itype.shortName + " x" + player.itemSlots[slot].quantity), createCallBackFunction2(benoitSellTransact, slot, sellMod));
				totalItems += player.itemSlots[slot].quantity;
			}
		}
		if (inventory.getMaxSlots() > 10) addButton(13, "Next", benoitSellMenu, page + 1);
	}
	if (page == 2) {
		for (slot = 10; slot < 20; slot++) {
			if (player.itemSlots[slot].quantity > 0 && int(player.itemSlots[slot].itype.value / sellMod) >= 1) {
				outputText("\n" + int(player.itemSlots[slot].itype.value / sellMod) + " gems for " + player.itemSlots[slot].itype.longName + ".");
				addButton(slot-10, (player.itemSlots[slot].itype.shortName + " x" + player.itemSlots[slot].quantity), createCallBackFunction2(benoitSellTransact, slot, sellMod));
				totalItems += player.itemSlots[slot].quantity;
			}
		}
		addButton(13, "Prev", benoitSellMenu, page - 1);
	}
	if (totalItems > 1) addButton(12, "Sell All", createCallBackFunction2(benoitSellAllTransact, totalItems, sellMod));
	addButton(14, "Back", benoitIntro);
}

private function benoitTransactBuy(itype:ItemType):void {
	clearOutput();
	var buyMod:Number = 2;

	if (flags[kFLAGS.BENOIT_STATUS] == 1) buyMod = 1.66;
	if(benoitLover()) outputText("After examining what you've picked out with [benoit eir] fingers, [benoit name] hands it over and accepts your gems with a grin.");
	else outputText("After examining what you've picked out with [benoit eir] fingers, [benoit name] hands it over, names the price and accepts your gems with a curt nod.\n\n");
	//(+3 Affection)
	benoitAffection(3);

	player.gems -= int(buyMod * itype.value);
	statScreenRefresh();
	inventory.takeItem(itype, benoitsBuyMenu);
}

private function benoitSellTransact(slot:int, sellMod:int):void {
	clearOutput();
	if(benoitLover()) outputText("[benoit name] gives your object the briefest of goings-over with [benoit eir] fingers before stowing it away and handing over your gem reward with a trusting smile.");
	else outputText("Following a painstaking examination of what you've given [benoit em] with his hands and nose, Benoit grudgingly accepts it and carefully counts out your reward.");
	if (shiftKeyDown) {
		while (player.itemSlots[slot].quantity > 0) {
			player.gems += int(player.itemSlots[slot].itype.value / sellMod);
			player.itemSlots[slot].removeOneItem();
			benoitAffection(1);
		}
	}
	else {
		player.gems += int(player.itemSlots[slot].itype.value / sellMod);
		player.itemSlots[slot].removeOneItem();
		//(+1 Affection)
		benoitAffection(1);
	}
	statScreenRefresh();
	doNext(benoitSellMenu);
}

private function benoitSellAllTransact(totalItems:int, sellMod:int):void {
	clearOutput();
	var itemValue:int = 0;
	for (var slot:int = 0; slot < 20; slot++) {
		if (player.itemSlots[slot].quantity > 0 && int(player.itemSlots[slot].itype.value / sellMod) >= 1) {
			itemValue += player.itemSlots[slot].quantity * int(player.itemSlots[slot].itype.value / sellMod);
			player.itemSlots[slot].quantity = 0;
		}
	}
	if (benoitLover())
		outputText("[benoit name] gives your objects the briefest of goings-over with [benoit eir] fingers before stowing them away and handing over your " + num2Text(itemValue) + " gem reward with a trusting smile.");
	else outputText("Following a painstaking examination of the items you've given him with his hands and nose, Benoit grudgingly accepts them and carefully counts out your " + num2Text(itemValue) + " gem reward.");
	player.gems += itemValue;
	statScreenRefresh();
	//(+1 Affection per item)
	benoitAffection(totalItems);
	doNext(benoitIntro);
}

// items by slots
public static function get itemShop():/*ItemType*/Array {
	return [
		consumables.INCUBID,
		consumables.MINOBLO,
		consumables.MINOCUM,
		consumables.EQUINUM,
		consumables.BLACKPP,
		consumables.SMART_T,
		consumables.VITAL_T,
		consumables.DBLPEPP,
		consumables.PURHONY,
		consumables.BEEHONY,
		consumables.SUCMILK,
		consumables.W_FRUIT,
		consumables.WETCLTH,
		consumables.GLDSEED,
		consumables.LABOVA_,
		consumables.SNAKOIL,
		consumables.S_GOSSR,
		consumables.HUMMUS_,
		consumables.PIGTRUF,
		consumables.B_GOSSR,
		// rare before, now normal
		consumables.L_PNKEG,
		consumables.L_BLUEG,
		consumables.BIMBOLQ,
		consumables.BROBREW,
		consumables.TSTOOTH,
		consumables.W_PDDNG,
		consumables.NUMBROX,
		consumables.SENSDRF,
	];
}

public static function get armorShop():/*ItemType*/Array {
	return [
		armors.W_ROBES,
		armors.S_SWMWR,
		useables.GREENGL,
		useables.B_CHITN,
		// rare before, now normal
		armors.BONSTRP,
		armors.NURSECL,
	];
}

//All slots are reset each day.  Benoit buys items at 66% the rate Oswald does.
public function updateBenoitInventory():void {
	var pickedItems:Array = randomChoices(true, 4, itemShop);
	flags[kFLAGS.BENOIT_1] = pickedItems[0].id;
	flags[kFLAGS.BENOIT_2] = pickedItems[1].id;
	flags[kFLAGS.BENOIT_3] = pickedItems[2].id;
	flags[kFLAGS.BENOIT_4] = pickedItems[3].id;
	flags[kFLAGS.BENOIT_5] = randomChoice(armorShop).id;
}

private function buyAlarmClock():void {
	clearOutput();
	outputText("You wander [benoit name]'s shop for a good while as you're searching for something interesting until you spot something interesting.");
	outputText("\n\nIt's a mechanical clock.  It has a flip display and there are buttons on top of the clock for the purpose of setting time and alarm.  You wind up the clock and the display flips, indicating that the clock works.  Whoever constructed this clock must have been a genius, you would have even guessed a goblin constructed it before the corruption.  You pick up the clock and show it to [benoit name].");
	outputText("\n\n\"<i>It works?  I have no need for zis.  500 gems,</i>\" [benoit Ey] says.");
	outputText("\n\nDo you buy the clock?");
	doYesNo(buyAlarmClockConfirmation, benoitsBuyMenu);
}
private function buyAlarmClockConfirmation():void {
	clearOutput();
	if (player.gems < 500) {
		outputText("You count out your gems and realize it's beyond your price range.");
		doNext(benoitsBuyMenu);
		return;
	}
	outputText("\"<i>Here you go.  I have no need for zis,</i>\" [benoit name] says.");
	outputText("\n\n<b>You can now set alarm. Go to your cabin to set the alarm. (And change the time when you'll wake up.)</b>");
	player.gems -= 500;
	statScreenRefresh();
	flags[kFLAGS.BENOIT_CLOCK_BOUGHT]++;
	flags[kFLAGS.BENOIT_CLOCK_ALARM] = 6;
	doNext(benoitsBuyMenu);
}

private function buyBackpack():void {
	clearOutput();
	outputText("You ask [benoit name] if [benoit ey] has a backpack to spare.");
	outputText("\n\n\"<i>Yes. Zese come in six sizes. What will you pick?</i>\" [benoit ey] asks.");
	outputText("\n\n<b><u>Backpack Size and Pricings</u></b>");
	outputText("\nSmall: 100 gems, +2 inventory slot");
	outputText("\nMedium: 200 gems, +4 inventory slots");
	outputText("\nLarge: 300 gems, +6 inventory slots");
	outputText("\nExtra Large: 400 gems, +8 inventory slots");
	outputText("\nDouble Extra Large: 500 gems, +10 inventory slots");
	outputText("\nTriple Extra Large: 600 gems, +12 inventory slots");
	menu();
	if (player.keyItemvX("Backpack", 1) < 2) addButton(0, "Small", buyBackpackConfirmation, 2, "Small", 100, "Grants additional two slot. \n\nCost: 100 gems");
	if (player.keyItemvX("Backpack", 1) < 4) addButton(1, "Medium", buyBackpackConfirmation, 4, "Medium", 200, "Grants additional four slots. \n\nCost: 200 gems");
	if (player.keyItemvX("Backpack", 1) < 6) addButton(2, "Large", buyBackpackConfirmation, 6, "Large", 300, "Grants additional six slots. \n\nCost: 300 gems");
	if (player.keyItemvX("Backpack", 1) < 8) addButton(3, "X Large", buyBackpackConfirmation, 8, "X Large", 400, "Grants additional eight slots. \n\nCost: 400 gems");
	if (player.keyItemvX("Backpack", 1) < 10) addButton(4, "XX Large", buyBackpackConfirmation, 10, "XX Large", 500, "Grants additional ten slots. \n\nCost: 500 gems");
	if (player.keyItemvX("Backpack", 1) < 12) addButton(5, "XXX Large", buyBackpackConfirmation, 12, "XXX Large", 600, "Grants additional twelve slots. \n\nCost: 600 gems");
	addButton(14, "Never mind", benoitsBuyMenu);
}
private function buyBackpackConfirmation(size:int = 2, sizeDesc:String = "Small", price:int = 100):void {
	clearOutput();
	if (player.gems < price) {
		outputText("You count out your gems and realize it's beyond your price range.");
		doNext(benoitsBuyMenu);
		return;
	}
	outputText("\"<i>Here you go.  I have no need for zis,</i>\" [benoit name] says.");
	if (player.hasKeyItem("Backpack") >= 0) {
		price = (size - player.keyItemvX("Backpack", 1)) * 50;
		outputText("\n\n<b>(Key Item Upgraded: " + sizeDesc + " Backpack! You now have " + num2Text(size - player.keyItemvX("Backpack", 1)) + " extra inventory slots");
		player.addKeyValue("Backpack", 1, size - player.keyItemvX("Backpack", 1));
		outputText(" for a total of " + num2Text(inventory.getMaxSlots()) + " slots.)</b>");
	}
	else {
		outputText("\n\n<b>(Key Item Gained: " + sizeDesc + " Backpack! You now have " + num2Text(size) + " extra inventory slots");
		player.createKeyItem("Backpack", size, 0, 0, 0);
		outputText(" for a total of " + num2Text(inventory.getMaxSlots()) + " slots.)</b>");
	}
	player.gems -= price;
	statScreenRefresh();
	doNext(benoitsBuyMenu);
}

private function buyZweihander():void {
	clearOutput();
	outputText("You look around the things that [benoit name] has to sell and a strange axe catches your attention. It’s big, and it’s head has a very unusual shape. Odd runes cover its handle. Curious, you pick it up, and take it to [benoit name].");
	outputText("\n\n[benoit Ey] examines it for a bit, mumbling something about harpies.");
	outputText("\n\n\"<i>Huh, zis is a very old ax. Still in good shape, but I’m not using zat kind of stuff anytime soon. You can have it for, let me zink, 2000 gems.</i>\" [benoit name] says.");
	menu();
	addButton(0, "Yes", buyZweihanderConfirmation);
	addButton(1, "No", benoitsBuyMenu);
}
private function buyZweihanderConfirmation():void {
	clearOutput();
	if (player.gems < 2000) {
		outputText("You count out your gems and realize it's beyond your price range.");
		doNext(benoitsBuyMenu);
		return;
	}
	outputText("[benoit Ey] gives you the axe, and you pack it with the rest of your stuff.");
	player.gems -= 2000;
	flags[kFLAGS.BENOIT_PISTOL_BOUGHT] = 2;
	statScreenRefresh();
	inventory.takeItem(weapons.FRTAXE, benoitsBuyMenu);
}

private function talkCount():void {
	//(+5 Affection per day if used)
	if (flags[kFLAGS.BENOIT_TALKED_TODAY] == 0) {
		flags[kFLAGS.BENOIT_TALKED_TODAY] = 1;
		benoitAffection(5);
	}
}

private function talkHelp():void {
	clearOutput();
	talkCount();
	outputText("You ask [benoit name] if [benoit ey] has ever thought about trying to do something to help his people's plight.");

	outputText("\n\nThe basilisk is silent for a time, running his claws along the counter pensively.  \"<i>Yes,</i>\" [benoit ey] says eventually, in a quiet tone.  \"<i>I 'ave.  Away from ze mountains, I 'ave 'ad time to sink.  I am not ze demons' slave anymore, and I am a funny joke of a basilisk anyway, so I 'ave often thought about... making certain zacrifices.  If we 'ad just one female, away from zeir corruption, zen...</i>\" [benoit ey] trails off, sighing heavily before smiling ruefully at you.  \"<i>Zose were ze kind of soughts I 'ad before I met you.  Crazy, yes?  Even more crazy to be still sinking zem when a good woman is giving me 'er love for no reason except through ze kindness of 'er 'art.  Still... it is so frustrating, being able to sink clearly about zese sings and not being able to do anysing about it.</i>\"");

	if (player.inte >= 60) {
		outputText("\n\nYour mind wanders.  You doubt that even if you wanted to you could turn into a basilisk proper, but you wonder if there's some kind of transformation that would allow a human womb to mimic that of another race.");
		outputText("\n\nBenoit answers warily.  \"<i>A double dose of ovi-elixer, a bottle of reptilum, goblin ale and some basilisk blood would probably do... if you were so minded.  But, [name], tell me you're not going to do somesing so reckless as experiment on your body?</i>\"");
		//toggle on "Bas. Womb" from benoit's main menu.
		flags[kFLAGS.BENOIT_WOMB_TALK_UNLOCKED] = 1;
		outputText("\n\n(<b>Basilisk Womb option enabled in Benoit's menu!</b>)");
	} else {
		outputText("\n\nYou rack your brain but can't think of anything that could help Benoit, so you end up simply sympathising with [benoit em].  \"<i>Do not beat yourself up over it,</i>\" says the basilisk, touching the tips of your fingers and smiling warmly.  \"<i>It is just foolishness.  And anyway, I told you: we are a race of bastards.  We are ze last guys who deserve someone sinking after us.</i>\"");
		//don't trigger event again until the PC is smart enough!
		sceneHunter.print("Check failed: you're too dumb.");
	}
	doNext(camp.returnToCampUseOneHour);
}

private function femoit1stTalk():void {
	clearOutput();
	talkCount();
	flags[kFLAGS.FEMOIT_TALKED_TO]++;
	outputText("You ask Benoite if she intends to go back to the mountains now.  She laughs long and hard at this.  One thing the transformation has certainly gifted her is an extraordinarily filthy laugh.");

	outputText("\n\n\"<i>Oh [name], you are so silly,</i>\" she says fondly.  \"<i>'Ow long do you sink a blind female basilisk would last up zair, eh?  If I was really lucky ze minotaurs would get me before ze demons did.  No, I will stay ere.  Ze uzzer basilisks, I cannot trust zem - zey are always exposed to ze corruption, some of zem even like it.  I will lay eggs far away from zere, I will raise my children to be different; away from ze corruption and with equal numbers of males and females, it will be different.  Zere are many empty places in zis world now zey can go to and be left alone.</i>\"  She pauses. \"<i>Or at least zese sings will 'appen once I work up ze courage to find a, er, donor.</i>\"");

	if (!player.hasCock()) {
		outputText("You ask if she's had any thoughts on that front.  \"<i>Not really,</i>\" Benoite sighs.  \"<i>I 'ave many male customers but zey all 'ave - 'ow you say? Rough round edges.  You now 'ow it is, [name], all men are pigs.</i>\"  You both laugh at this.  \"<i>I will find someone though, don't worry.  As I said before...</i>\" she points two fingers at her blind eyes and then at the stall entrance.  There's a distinct gleam in those cloudy grey depths you think would scare the hell out of most things with a penis.  \"<i>I 'ave a purpose now.</i>\"");
	} else {
		outputText("\n\nYou ask if she's had any thoughts on that front. \"<i>Well, I do 'ave zis one customer 'oo seems very kind.  And 'oo knows me a great deal better zan anyone else around 'ere,</i>\" Benoite mumbles, twiddling her fingers.  \"<i>But zis person 'as already done a great deal for me, so I don't know if... per'aps zis is asking too much. I will find someone though, never fear.  As I said before...</i>\" Benoite points two fingers at her blind eyes and then at the stall entrance.  There’s a distinct gleam in those cloudy grey depths you think would scare the hell out of most things with a penis. \"<i>I ‘ave a purpose now.</i>");
		menu();
		doYesNo(femoitFirstTimeYes, femoitFirstTimeNo);
	}
}

//Talk
private function talkToBenoit():void {
	clearOutput();
	talkCount();
	//First time Talk:
	if(flags[kFLAGS.BENOIT_TALKED_TO_PROPERLY] == 0) {
		flags[kFLAGS.BENOIT_TALKED_TO_PROPERLY]++;
		outputText("You take a moment to look the strange merchant over.  Although blind, [benoit ey] doesn't seem very old - [benoit ey] retains the tight, thin muscular frame of other basilisks you've seen, but looks to be slightly shorter and for all his proud, cruel profile seems slightly shabby around the edges.  In what is presumably a nod towards civilized manners, [benoit ey] is wearing a pair of denim long johns as well as his fez, perched upon one of his head spines.  You introduce yourself, and then decide to ask [benoit em] about basilisks.");

		outputText("\n\n\"<i>We were a proud race once,</i>\" sighs Benoit.  \"<i>A noble race, who carried our 'eads 'igh, and...</i>\" the blind basilisk bursts into throaty laughter, which eventually subsides into a coughing fit.  You watch, bemused.  \"<i>Hahaha!  Aha.  Sorry.  No, we were always a race of egg-thieving bastards.  The lizans,</i>\" [benoit ey] flicks his snout in the general direction of the bonfire with disdain, \"<i>absolutely 'ate us.  Zey drove us to live in ze mountains, far away from zeir precious clutches, to live like savages.  'Ze family with ze evil eye over it', zat's what zey call us.  Eh... in basilisk it's more snappy.</i>\"  Benoit pauses, running his fingers over the counter ruminatively.  \"<i>But it wasn't so bad, up zair.  We kept ze harpies under control, and we collected scrap, sold it to zose who were brave enough to trade blindfolded.  We've always been good at zat.  Zen ze demons came to ze mountains.</i>\"");

		outputText("\n\nHe shrugs. \"<i>What were we going to do?  Go down and throw ourselves on the mercy of the races 'oo despise us?  Ze demons offered to set us high in zeir service, augment our natural abilities if we agreed to help zem.  I suppose zey did, at zat.</i>\"  Benoit scratches a long groove in his counter, trembling with anger.  \"<i>By making us all male zey made sure we are always fixated on finding egg bearers, on keeping ze harpies down, and bringing scrap and statues to zem so zey don't do anysing worse to us.  We are just a brainless natural defence to zem now, in zeir mountain hideaways.  Don't go up ze mountain or ze evil basilisks will get you!  Bastards.  Bastards.</i>\"  Benoit finishes mutilating the wood in front of [benoit em] and sighs.  \"<i>But zat is by ze by.  Are you going to buy sumsing or not?</i>\"");
	}
	//Subsequent Talk
	else {
		var choice:int;
		/* BUILD ZE CHOICES!*/
		var choices:Array = [0, 1, 2, 3, 4, 5, 6, 7, 8];
		//option 9 is non-lover non-fem only
		if (!benoitLover() && benoitMF("he", "she") == "he") choices[choices.length] = 9;
		//Special male benoit fucker only talks
		if (benoitLover() && benoitMF("he", "she") == "he" && player.hasVagina()) {
			choices[choices.length] = 10;
			choices[choices.length] = 11;
			choices[choices.length] = 12;
			choices[choices.length] = 13;
		}
		// Femoit specials
		if (flags[kFLAGS.BENOIT_STATUS] != 0) {
			choices.push(14);
			choices.push(15);
			if (benoitLover()) choices.push(16);
		}
		//trace("BENOIT CHOICE: " + choice);
		//Pick one and go!
		choice = choices[rand(choices.length)];
		//(Randomly generated)
		switch (choice) {
			case 0:
				outputText("You ask if all basilisks talk as [benoit ey] does.");
				outputText("\n\n\"<i>Only on zis side of ze mountain,</i>\" comes the reply.  \"<i>Ze uzzer side are all stuck-up snobs who speak 'orribly.  Zey are all pale and flabby too, and zeir cooking is terrible.  Pwah!</i>\"  [benoit Ey] makes an exasperated gesture with a claw.");
				break;
			case 1:
				outputText("You ask [benoit name] about the dog.");
				outputText("\n\n\"<i>Pierre 'asn't been giving you trouble, as 'e?  Big stupid mutt does not know 'is mouth from 'is arse.  Which is why 'e checks so often,</i>\" says the basilisk fondly, rubbing the Alsatian behind his ear.  \"<i>I found 'im prowling around eating scraps from ze food sellers when I first got ere; I sink 'e must 'ave belonged to anuzzer trader 'oo left [benoit em] behind.  I do not sink I could run this shop without [benoit em] - every evening I go out into the wilds with [benoit em] and 'unt down more salvage.  'Ee is so good at finding perfectly good sings other people 'ave left behind.  Particularly cloze.  'E loves robes, Pierre.  Don't you, boy?</i>\"  Pierre whines.");
				break;
			case 2:
				outputText("You ask [benoit em] about the sign above the shop.");
				outputText("\n\n\"<i>It's good, isn't it?</i>\"  the trader says proudly.  \"<i>I got a catguy to do it when I first got 'ere and didn't know ze language so well.  'E suggested...</i>\"  [benoit Ey] spreads [benoit eir] claws expressively.  \"<i>'Salamander's Salubrious Salvage'.  Because, everyone likes salamanders, and once zey get in and realize I am not a salamander and it is just a play on words, zey would be so entranced by what I am selling zey would not care.</i>\"  [benoit name] taps the counter happily.  \"<i>In gold print, too!  It is a surprise it has not brought more customers in.</i>\"");
				outputText("\n\nYou decide not to disillusion the blind basilisk.");
				break;
			case 3:
				outputText("You ask if [benoit ey] has always been blind.");
				outputText("\n\n\"<i>I don't know,</i>\" [benoit ey] says. \"<i>Ask me what red is.</i>\"");
				outputText("\n\nYou ask what red is.");
				outputText("\n\n\"<i>'Ow ze fuck should I know?</i>\" the basilisk replies, deadpan.  \"<i>Stop asking stupid questions.</i>\"");
				outputText("\n\nYou decide not to pursue the subject.");
				break;
			case 4:
				outputText("You ask [benoit name] how [benoit ey] got into this line of work.");
				outputText("\n\n\"<i>I 'ave always worked with salvage,</i>\" [benoit ey] shrugs.  \"<i>Back in ze mountains I worked in ze magpie room - obviously, because I was no good on ze outside.  You can tell from ze weight of sings, and 'ow zey smell, what it is and 'ow much it is worth.  More zan zat you can tell... what it meant to its last owner.  Zat is ze true worse of an object.</i>\"  [benoit Ey] taps his claws on the counter, lost in thought.  \"<i>Ze magpie room is amazing, [name], I wish I could show it to you.  Such good acoustics, filled with ze sound and smell of a thousand pieces of junk - every day a new symphony.  And 'oo would ever steal ze demons' treasures?  You would 'ave to be mad to try to steal from a hall full of basilisks.  Or blind.</i>\"");
				outputText("\n\n[benoit Ey] laughs throatily, then sighs.  \"<i>Ah, but it was rotten, really - always a sour note underneath everysing.  A thousand basilisks, driven by nussing but greed and lust.  I got sick of it, being stuck in zat place with zose thoughts, zat 'opeless cycle, and one day ran away.  I took what I could carry and used zat to start up here.  Away from ze mountains, I can zink clearly.  I can say what ze uzzer basilisks only know at ze back of zeir minds.</i>\"  [benoit name] slams a fist into the counter, making you jump.  \"<i>Don't ever make a deal with a demon, [name],</i>\" [benoit ey] says, voice thick with rage.  \"<i>Even when you sink it is a win-win?  Zey will still find a way to fuck you good.</i>\"");
				dynStats("cor", -1);
				break;
			case 5:
				outputText("You ask Benoit if [benoit ey] can tell you anything about the Bazaar.");

				outputText("\n\n\"<i>You are really asking zis question to a blind person?</i>\" comes the reply.  \"<i>Ok, I will tell you what I know, for what it is worth.  Over zeir by ze fire, I know zeir are lizans having a good time, because zey shout insults when zey get really drunk.  Zey would get violent with me I sink, if it weren't for Pierre.  Zeir leader has a big problem with her male hormones, judging from ze way she smells.</i>\"  [benoit Ey] sniggers with a distinct lack of sympathy.  \"<i>In ze uzzer direction, I can smell a lot of males together in one place.  Smell like zey are doing something very macho - and a bit painful, from ze sound of zeir walk afterwards.</i>\"  [benoit Ey] points in the opposite direction.  \"<i>Zerr are plenty of, ow you say, crumpets who work around here.  Some of zem can do some pretty wild sings for you, for a fee.  Or so I'm told.</i>\"  [benoit Ey] coughs.");
				break;
			case 6:
				outputText("You ask [benoit name] for any rumors going around.");
				//[Deep cave cleared:
				if (flags[kFLAGS.DEFEATED_ZETAZ] > 0) outputText("\n\n\"<i>Somesing strange did 'appen ze uzzer day, now you mention it,</i>\" [benoit ey] says, tapping a curved tooth.  \"<i>I got a big group of imps in ere.  I normally don't serve zem because zey are always stealing sings whilst one of zem is paying, but zese guys seemed too worked up to even sink about lifting ze shop - zey smelt of fear.  Zey were buying lots of food and survival gear - one of zem kept going on and on about ze fact zey left \"<i>ze fairy</i>\" behind, until one of ze uzzers slapped 'im and said if 'ee didn't shut up, 'ee would be ze fairy.</i>\"  [benoit name] shrugs.  \"<i>Nasty little sings.  Tasty, though.</i>\"");
				//[Factory not cleared:
				else if (flags[kFLAGS.FACTORY_SHUTDOWN] <= 0) outputText("\n\n\"<i>Not anysing very interesting,</i>\" [benoit ey] shrugs.  \"<i>I get a few customers from ze desert city, Tel'Adre, coming in 'ere in secret to pick up a few sings zey cannot find back 'ome.  So zey are still a sing.  You 'ave to wonder ow much longer zey can keep hiding, though.</i>\"");
				else if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) outputText("\n\n\"<i>I don't know what is 'appening exactly,</i>\" [benoit ey] says, leaning over the counter. \"<i>But ze demons 'oo I trade with, zey seem very worked up about sumsing.  Sumsing went wrong at one of zeir facilities, I sink.  I also get a number of shark ladies coming in ere, asking if I sell fresh water.  Zey also seem very unhappy.</i>\"");
				else outputText("\n\n\"<i>I don't know what is 'appening exactly,</i>\" [benoit ey] says, leaning over the counter.  \"<i>But ze demons 'oo I trade with, zey seem very worked up about somesing.  Sumsing went wrong at one of zeir facilities, I sink.  I also hear a number of passers-by talking about ze lake.  Apparently it is much cleaner now; many are going back to use it for water.  Now if only someone could make zose crazy cultists go away, eh?</i>\"");
				break;
			case 7:
				outputText("You ask if [benoit ey]'s ever had any trouble with the demons who frequent the Bazaar.");
				outputText("\n\n\"<i>Not really,</i>\" [benoit ey] replies.  \"<i>I don't like zem, but zey are my main source of income.  Zey are always coming in here to sell zeir fluids.  The truth is its worthless - I pour most of ze disgusting stuff away.  But it is worth paying for zeir custom because zey are always buying many more potions.  It isn't a good demon party unless you 'ave sprouted two new dicks and four new nipples for it, apparently.  Always one of zem is asking if zey can 'do ze dinosaur' as way of payment.  I 'ate zem so much.</i>\"");
				if (silly()) outputText("\n\nThe basilisk rubs Pierre behind the ear as [benoit ey] thinks.  \"<i>I did once get a group of demons coming in ere, asking me what 'cheese omelette' is in basilisk.  When I told zem, zey ran away laughing, shouting 'Zat is all you can say! Zat is all you can say!'</i>\"  [benoit Ey] shrugs, irritated.  \"<i>Arseholes.</i>\"");
				break;
			case 8:
				outputText("You ask [benoit name] what results when basilisks mate with harpies.");
				outputText("\n\n\"<i>Most of ze time? Basilisks,</i>\" [benoit ey] replies, carefully counting gems with [benoit eir] fingers."
					+ " \"<i>Some of ze time? 'Arpies. But ze arpies feed zeir basilisk children to zeir chicks if ze former do not get away"
					+ " in time, so it works out. Really, we are doing zem and ze world a favor by stealing zeir eggs - if we weren't around ze"
					+ " 'ole world would be drowned in guano by now.</i>\" Satisfied with the takings, [benoit ey] stows the money away underneath"
					+ " the counter. \"<i>Very rarely, you get cockatrices. Now ZEY are weird-looking.</i>\"");
				if (flags[kFLAGS.COCKATRICES_UNLOCKED] <= 0) {
					outputText("\n\n<b>Perhaps you should try to find one of these elusive hybrids."
						+ " You suspect the high mountains would be the best place to look.</b>");
					flags[kFLAGS.COCKATRICES_UNLOCKED] = 1;
				}
				break;
			case 9:
				//non-lover non-fem only
				outputText("You ask if [benoit name] really can tell who you are just by smell.");

				if (player.isRace(Races.HUMAN, 1, false)) outputText("\n\n\"<i>Certainly!</i>\" [benoit ey] smiles.  \"<i>Ze smell of shaved monkey is distinctive.  I get very few 'uman customers, you know.</i>\"  The basilisk scratches [benoit eir] jaw absent-mindedly.  \"<i>If you do not mind me saying so, [name], you also smell... different.  Like you do not really belong 'ere.  In ze nicest possible way, of course.</i>\"");
				else outputText("\n\n\"<i>Certainly!</i>\" [benoit ey] smiles.  \"<i>Ze smell of shaved monkey is distinctive.  I get very few 'uman customers, you know.</i>\"  You look down at yourself, then back at the basilisk suspiciously, before saying you don't much look or feel human.  \"<i>Oh, I do not doubt zat,</i>\" says the trader.  \"<i>You 'umans and your flexible genes - zat makes you very alluring, as I am sure you 'ave already noticed, eh?  I am sure somebody 'oo relied upon sight would not be able to tell you are 'uman.  But 'oo you are underneath all zat, zat never changes, and I can smell zat.  All you are doing really is dressing up as something else.  If you wanted to, you could change back tomorrow, if you 'ad ze right ingredienns.</i>\"");
				//[(male Benoit only)
				if (benoitMF("he", "she") == "he") outputText("  There's a hint of longing jealousy in the basilisk's voice and when [benoit ey] lapses into silence you decide not to push the subject.");
				break;
			//Male Benoit Lover Talk options
			//(Randomly generated.  Added to normal talk options after PC has had sex with Benoit two times or more regardless of womb quest.)
			case 10:
				outputText("You ask Benoit there is anything useful [benoit ey] can tell you about the demon strongholds.");
				outputText("\n\n\"<i>I'm afraid I cannot be very 'elpful zeir, [name],</i>\" [benoit ey] sighs.  \"<i>Unless you want me to tell you what zey smell like.  I do not sink you want to be knowing zis.  Ze demons, zey were not much in ze business of telling us what zeir plans were, and zey did not much like 'anging around us, which is understandable.   Zair is every treasure you can ever imagine in ze magpie room, but zeir is no way you could ever get at zem unless you could work out some way of making many undreds of basilisks close zeir eyes at once.</i>\"");
				break;
			case 11:
				outputText("You ask Benoit if [benoit ey] can suggest anything to help you fight his brethren in the high mountains.");
				outputText("\n\n\"<i>You could carry a mirror with you,</i>\" [benoit ey] says, pointing.  \"<i>There's one over zair, isn't zair?</i>\" You report that it is cracked badly - at any rate, you're not carrying a bulky mirror up a mountain two or three times a day.  \"<i>I will give it to you half price,</i>\" [benoit ey] says hopefully.  \"<i>Sink 'ow useful it will be to check for transformations!  You could get somebody else to carry it for you... ok, alright, so you don't want ze mirror.  Most prey, my bruzzers are expecting zem to lash out in a panic.  So use sings which do not involve approaching.  We do not like magic or ranged sings, zey are too unpredictable - I suggest using zem.</i>\"");
				break;
			case 12:
				outputText("\"<i>Gnoll.</i>\"");
				outputText("\n\n You make a gentle humming noise.");
				outputText("\n\n\"<i>Bee maiden,</i>\" says Benoit after a moment.");
				outputText("\n\nYou stamp your feet and snuffle and snort.");
				outputText("\n\n\"<i>Minotaur,</i>\" says Benoit immediately.  You sigh - [benoit ey]'s too good at this game, and you're running out of creatures.  Thinking briefly, you make a clop-clopping whilst slapping the counter, throwing in a bit of heavy breathing for good measure.");
				outputText("\n\n\"<i>What ze 'ell is zat supposed to be?</i>\" says Benoit, looking alarmed.  You tell " + benoitMF("him", "her") + " it's a ");
				outputText("Unitaur.");
				outputText("\n\n\"<i>A what?</i>\"");
				outputText("\n\nYou explain that an Unitaur is like a white centaur, only it has a horse's face.  It has massively strong human arms though, and it can cast magic better than anyone, and it can go faster than a cheetah, and... you can't help yourself and begin to giggle at the expression of terror that has emerged on Benoit's face.");
				outputText("\n\n\"<i>Oh, I see.  You are pulling my tail.  Very amusing.</i>\"  You laugh even harder at the expression of wounded dignity which replaces the terror.");
				break;
			case 13:
				outputText("You ask Benoit if [benoit ey] really, <b>really</b> can tell who you are just by smell.");
				outputText("\n\n\"<i>Well, of course I can,</i>\" [benoit ey] says teasingly.  \"<i>When you end up smelling like someone else for several hours, it is a difficult sing to mistake.  It is a memento of you and it reminds me of 'appiness; I wish I could smell zat way for longer.  My sexy little shaved monkey.</i>\"");
				break;
			case 14:
				outputText("You ask Benoite how she’s getting on with being the opposite sex.  Benoite stops cleaning the tarnished silver plate in her hands to think.");
				outputText("\n\n\"<i>It is... different,</i>\" she says eventually, before laughing at the platitude.  \"<i>Ze ‘ole wizzing situation, zis is terrible for instance.  I do not know [name], I am so busy during ze day and it ‘appened so suddenly, it is difficult to properly reflect.  Sometimes I am sinking somesing, like ‘ow somesing smells, and zen I catch myself sinking... would Benoit ‘ave sought zat? Is my perception different because I ‘ave different ‘ormones swirling around my ‘ead?</i>\" She turns the plate around in her hands absently. \"<i>Zerr are... uzzer sings, too.  Sometimes I am smelling a customer is finding me strange, and I realize I am doing somesing which is... male.  Like, somesing I would never ‘ave sought about before, walking with feet splayed instead of in a line.  A ‘undred and one sings to remember to not stand out.  Zat is wearying.</i>\"");
				if (benoitLover() && player.hasCock() && player.hasVagina()) outputText("\n\nShe smiles shyly at you. \"<i>I am very lucky in one respect zo, because I ‘ave not ‘ad to resink what I find attractive to lie wizz you.  Whatever you ‘ave between your legs you smell and feel female to me, and zat is a comfort.</i>\"");
				else if (benoitLover() && player.hasCock() && !player.hasVagina()) {
					outputText("She smiles shyly at you. \"<i>One sing I ‘ave definitely ‘ad to resink is what I find attractive.  I did not find ze male form attractive before, so for my body to... respond... when you are close, zat is when I most feel ze disconnect between my experience and what I am now.  Per’aps zis is also why I ‘ave not sought about it too much; it is better just to rely on instinct.</i>\"");
					outputText("\n\nCharming, you say.");
					outputText("\n\nBenoite grins wider at your affected hurt. \"<i>Oh do not worry [name], you ‘ave a beautiful personality.  And ow important exactly do you sink your personal appearance is to me?</i>\"");
				} else {
					outputText("\n\nShe smiles shyly at you. \"<i>Listen to me, ow you say, riveting on.  You I am guessing do not see what ze big fuss is- you ‘umans can chop and change whenever you feel like, so to speak.  Must be nice.</i>\"");
					outputText("\n\nYou point out that your mutability is not always an advantage- it can be used against you, and this land is full of types who would be only too keen to do so.");
					outputText("\n\nBenoite nods thoughtfully. \"<i>I never sought about it like zat.  Ze demons just love slaves zey can change wizzer a few potions, don’t zey? You are right [name], I will count my blessings in ze future.</i>\"");
				}
				break;
			case 15:
				outputText("\n\nYou ask Benoite if she isn’t worried that demon customers won’t notice what she is.");
				outputText("\n\n\"<i>Zat is why I am wearing zis cunning disguise,</i>\" she says, patting her large beret.  She lowers her voice to a growl. \"<i>And I talk like zis when I am serving zem.  Grr.  To be honest I do not sink I ‘ave to be worrying much,</i>\" she goes on in her normal tone, tightening her apron. \"<i>Most of ze demons 'oo come 'ere are not very bright, zey are not very interested in anysing except when zey are next banging zair bits together.  Also I sink most mammals are 'aving trouble telling ze difference between male and female reptiles wizzout looking closely.  Am I right?</i>\" She grins her long, meandering smile at you and you take her point.");
				break;
			case 16:
				outputText("You ask Benoite if she really can tell who you are just by smell.");
				outputText("\n\n\"<i>Well, of course I can, zilly,</i>\" she says teasingly. \"<i>When you end up smelling like someone else for several hours, it is a difficult sing to mistake.  It is a memento of you and it reminds me of appiness; I wish I could smell zat way for longer.  My sexy little shaved monkey.</i>\"");
				break;
			default:
				CoC_Settings.error("Benoit talk is broken");
		}
	}
	doNext(camp.returnToCampUseOneHour);
}


//Male Benoit x Female PC Interactions
//First talk
//Requires: PC has oviposition/ovi-elixered/in heat, Affection 35+
private function benoitAndFemPCTalkAboutEggings():void {
	clearOutput();
	flags[kFLAGS.BENOIT_SUGGEST_UNLOCKED] = 1;
	outputText("[benoit name] seems very on edge today.  [benoit Ey] paces up and down, returns your greeting with a stiff nod, and fiddles endlessly with the stock in reach of [benoit eir] counter as you search for a topic.  You ask if there's something wrong.");

	outputText("\n\n\"<i>Nuzzing!</i>\" [benoit ey] barks angrily.  [benoit Ey] coughs.  \"<i>Nussing,</i>\" [benoit ey] says in a calmer tone.  You wait.  \"<i>It's just... ze way your body is right now,</i>\" [benoit ey] says eventually.  \"<i>It...speaks to me.  But zis is my problem,</i>\" [benoit ey] goes on, straightening [benoit eir] neck and nervously tapping [benoit eir] claws on the counter. \"<i>And I am not myself if I cannot control myself.  Please, [name], ask your questions.</i>\" You look at the sad, proud basilisk and wonder when exactly the last time [benoit ey] got laid was.");

	outputText("\n\n(\"<i>Suggest</i>\" option added to [benoit name]'s menu.)");
}

//Suggest:
//Recall - first time
public function eggySuggest():void {
	clearOutput();
	if(flags[kFLAGS.BENOIT_TESTED_BASILISK_WOMB] == .5 && !recalling) {
		suggestSexAfterBasiWombed(true);
		return;
	}
	if(flags[kFLAGS.BENOIT_TIMES_SEXED_FEMPCS] > 0 && !recalling) {
		if(player.isTaur()) {
			outputText("You silently reach across the counter to squeeze [benoit eir] hands again.  [benoit name] grins with deep affection at you and, hand in hand, the two of you quietly debunk to the store room again.");
			outputText("\n\nOnce again, you carefully inch your blind charge to a clear cranny and push [benoit em] against a wooden wall, standing back to slowly peel off your [armor].  You grin as you ostentatiously drop each piece onto the packed earth, allowing [benoit em] to guess what it is by the sound it makes.  [benoit Eir] breathing comes heavier as your undergarments make a feathery sound as they fall.  As you take [benoit eir] hands and lay them upon your naked skin, you think about how you want to go about this.");
		}
		else {
			outputText("You silently reach across the counter to squeeze [benoit eir] hands again.  [benoit name] beams at you and, hand in hand and without a word, the two of you depart to the store room again.");

			outputText("\n\nOnce again, you carefully inch your blind charge to a clear cranny and push [benoit em] against a wooden wall, standing back to slowly peel off your [armor].  You grin as you ostentatiously drop each piece onto the packed earth, allowing [benoit em] to guess what it is by the sound it makes.  [benoit Eir] breathing comes heavier as your undergarments make a feathery sound as they fall.  As you take [benoit eir] hands and lay them upon your naked skin, you think about how you want to go about this.");
		}
		simpleChoices("Let [benoit Em]",repeatSexWithBenoitLetHim,"Take Charge",repeatBenoitFuckTakeCharge, "", null, "", null, "", null);
		return;
	}
	if (!recalling) flags[kFLAGS.BENOIT_TIMES_SEXED_FEMPCS]++;
	if(player.isTaur()) {
		//Suggest:
		outputText("You reach your fingers across the counter and lightly touch [benoit name]'s hands, saying you don't mind working out a few natural urges, if [benoit ey]'s in the mood.");
		outputText("\n\n\"You- I- what?\" [benoit ey] replies, looking slightly stunned. \"You don't? Are you...I don't know if...\" you reach across and squeeze [benoit name]'s hands until [benoit eir] nervous babble dies out and hesitantly, [benoit ey] squeezes back.  Still holding [benoit eir] hand, you move behind the crates and then gently lead [benoit em] behind the stall's canopy.");
		outputText("\n\nWhat passes for [benoit name]'s back office is perfect for your purposes; the two wagons between which [benoit eir] stall is sandwiched close together here and the triangular space is filled with crates and unsorted salvage.  You carefully inch your blind charge to a clear cranny and push [benoit em] against a wooden wall, standing back to slowly peel off your [armor].  You grin as you ostentatiously drop each piece onto the packed earth, allowing [benoit em] to guess what it is by the sound it makes.  [benoit Eir] breathing comes heavier as your undergarments make a feathery sound as they fall.");
		outputText("\n\n\"Zis will sound strange,\" says [benoit name] in a thick voice, \"But- would you mind if I just touched you a bit first? All I know about you is ze sound of your voice.\"  You acquiesce and draw close, taking [benoit eir] hands once again and gently laying them upon you.  You sigh as, holding [benoit eir] index claws back, [benoit ey] begins to move them slowly up and down.");
		outputText("\n\n[benoit Eir] warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel like you're being read like a book in Braille.  \"Good Gods,\" [benoit ey] murmurs as [benoit eir] hands lead back onto your flanks.  \"Good Gods!\" [benoit ey] cries out as [benoit ey] follows you all the way back to your mighty, powerful rear.  \"I knew you were a centaur because of all ze clip clopping,\" [benoit ey] says, rubbing your side back and forth in wonder.  \"But to know it and actually feel it, zey are somesing very different.\" [benoit Ey] sighs.  \"I 'ope you do not mind zis being a bit... awkward, but I am guessing you are probably used to zat by now, yes?\"");
		// Herm:
		if(player.gender == 3) {
			outputText("\n\n[benoit Eir] hands travel down your behind until, with a sharp intake of breath, [benoit ey] touches [oneCock].  \"Aren't you just full of surprises,\" [benoit ey] says dryly.  After a pause, [benoit ey] slowly wraps [benoit eir] dry, smooth grasp around your semi-erect cock and moves it up and down, rubbing and coiling you until you are straining.");
			//[cock 10 inches or less:
			if(player.longestCockLength() <= 10) outputText("  Although this is evidently an uncanny experience for [benoit em], [benoit ey] does manage a cocky smile as [benoit eir] hand moves around your male sex. \"Mine is bigger,\" [benoit ey] teases.  Unable to reward [benoit eir] cheek from where [benoit ey] is, you simply snort and shuffle your hooves, impatient now with need.");
			//[cock  >10 inches:
			else outputText("  This is evidently an uncanny experience for [benoit em], the alien nature of it deepening as [benoit eir] hands moves around your male sex. \"Oly Gods [name], you are a monster,\" [benoit ey] says thickly.  You smile and stamp your hooves, impatient now with need.");
		}
		outputText("\n\n[benoit Eir] hands trail upwards, moving over your bestial behind, exploring your soft flesh until [benoit ey] touches your lips.  You close your eyes and sigh as [benoit ey] slowly parts them with [benoit eir] smooth fingers and slides into your [vagina].  Although [benoit eir] breath is becoming increasingly heavy [benoit ey] also seems genuinely curious about you; with surprising gentleness [benoit eir] fingers travel over and around your moistening sex, exploring your every fold, working deeper and deeper as [benoit ey] does.  You let [benoit em] know what pleases you by sighing when [benoit ey] touches a sweet spot, moving deliberately with [benoit eir] finger's motions so [benoit ey] may give them better attention.  [benoit Ey] soon finds your [clit], beginning to bulge with need; slowly [benoit ey] circles it and then flicks at it, gently frigging you.");
		//[In heat:]
		if(player.inHeat) outputText("  By now your vagina is practically gushing, your bodies' own deep seated pheromone need stoked to blazing heights by the basilisk's gentle, painstaking exploration of your body.  You cannot stop thrusting yourself against [benoit eir] soaked hand, announcing how badly you want this with heavy moans.");

		outputText("\n\nThe scent of your arousal is in the air and as [benoit name] breathes it in [benoit eir] own breath comes heavier.  [benoit Eir] erection bulges in [benoit eir] long johns and you decide it's time for you to take charge; you back up, butting [benoit em] insistently with your powerful body until you have [benoit em] pinned against a space upon the opposite wall.  You watch [benoit em] over your shoulder as [benoit ey] unbuckles himself and lets [benoit eir] trousers fall.  Stoked by the pheromones simmering off your body, [benoit eir] long, thin purple erection is straining and [benoit ey] arches [benoit eir] back and opens [benoit eir] mouth as you flare your [butt] and press yourself against it.  You know just from looking at [benoit eir] intense arousal you're going to have to go slow to stop [benoit em] from shooting [benoit eir] bolt straight away; with a wicked smile your partner can't see, you suppose such is your effect on [benoit em] it may not even matter if [benoit ey] does.  Still, as [benoit ey] lays [benoit eir] hands upon your flanks, and you lean back with a sigh and slowly slide [benoit eir] length into your moistened [vagina] as gently as you can.");
		if (!recalling) player.cuntChange(12,true,true,false);
		outputText("\n\nBenoit's dick is incredibly smooth and you move down onto it with incredible, slick ease.  Rather than burying yourself onto it straight away you stop with only a third of it in your wet depths and slowly bring it out of you, dipping yourself slowly.  You stop with [benoit eir] sensitive head just inside and work your [hips] around deliberately, sighing as it rotates slowly around your slick walls.  [benoit name] moans dryly and you feel [benoit eir] body tense; immediately you stop your movements and wait, only gradually beginning to gyrate and thrust again when [benoit ey] has calmed down.  You slide more of [benoit em] into you when you bend forwards again, this time leaving only [benoit eir] base outside of you; you sigh as you feel [benoit em] creeping further into your moist depths.  [benoit Ey] makes a bestial noise and tries to thrust himself into you and upon you; tutting mockingly, you pull yourself away from [benoit em] and stop moving until, with what is evidently a huge force of will, the basilisk calms himself, backs himself against the wall and allows you to work [benoit em].");

		//[Small capacity:
		if(player.vaginalCapacity() <= 30) outputText("\n\nYou slide back down onto [benoit em], cooing this time as you feel [benoit em] bottom out with several inches of [benoit em] still outside of you.  [benoit Eir] thin, long length could not be more perfect for your tight sex; [benoit ey] rubs your walls up and down as you dreamily thrust in and out of [benoit eir] body, sending waves of pleasure flowing through you.");
		//Large capacity:
		else outputText("\n\nYou slide back down onto [benoit em], cooing this time as your groin meets [benoit eir] muscled thighs with a wet kiss, your sex swallowing [benoit eir] cock whole.  You begin to ride [benoit em] hard and slow, bending [benoit eir] cock upwards to push at your sensitive walls, waves of pleasure starting to flow through you.");

		outputText("\n\nYou keep at this slow ride for what feels like hours, stopping and starting, pulling and pushing deliberately to keep the basilisk you have backed into a corner under your control.  The pace of the fuck is clearly agonising for [benoit name]; [benoit ey] pants, tenses and gasps to the wet movement of your [vagina], [benoit eir] face and chest red with extreme arousal, but [benoit ey] lets you stay in control, eventually unable to do anything but lie back and let you have your way with [benoit em].");
		//[Lactation:
		if(player.lactationQ() >= 50) outputText("  The slow, sensual sex is enough for you to begin to bead milk from your sensitive [nipples]; you moan as the flow intensifies until you are instinctively kneading your [chest], spurting your sweet, warm fluids onto the floor.  [benoit name] starts in genuine amazement at the sound.  \"Mammals are so damn weird,\" [benoit ey] mutters, making you giggle.");

		outputText("\n\nYour lust ratchets up as [benoit eir] warm hands continue to move over your behind, and at last losing your discipline you begin to thrust into [benoit em] with abandon, eager now for your peak.  [benoit name] pants as you really begin to fuck [benoit em] and thrusts with you; the wetness of your arousal spatters against [benoit eir] thighs as your body slaps into the basilisk's tight muscles.  [benoit Ey] makes a harsh, bestial noise when [benoit ey] cums; [benoit eir] blind eyes roll as [benoit ey] clutches your back and shoots surge after surge of cum into your churning depths.  The warmth of [benoit eir] jizz and [benoit eir] helpless bucking thrust you to your own orgasm; irrepressible pulses of pleasure overwhelm your mind and you can do nothing for long minutes except cry and squeal against the basilisk, clutching [benoit em] back as you work [benoit eir] dick for every last drop.");
		if(player.gender == 3) outputText("  [EachCock] thickens and spurts in sympathy to your female high, spattering the floor with white paint.");
	}
	else {
		sceneHunter.print("Check failed: Taur body");
		outputText("You reach your fingers across the counter and lightly touch [benoit name]'s hands, saying you don't mind working out a few natural urges, if [benoit ey]'s in the mood.");

		outputText("\n\n\"<i>You - I - what?</i>\" [benoit ey] replies, looking slightly stunned. \"<i>You don't?  Are you... I do not know if...</i>\"  You reach across and squeeze [benoit name]'s hands until [benoit eir] nervous babble dies out and hesitantly, [benoit ey] squeezes back.  Still holding [benoit eir] hand, you move behind the crates and then gently lead [benoit em] behind the stall's canopy.");

		outputText("\n\nWhat passes for [benoit name]'s back office is perfect for your purposes; the two wagons between which [benoit eir] stall is sandwiched close together here and the triangular space is filled with crates and unsorted salvage.  You carefully inch your blind charge to a clear cranny and push [benoit em] against a wooden wall, standing back to slowly peel off your [armor].  You grin as you ostentatiously drop each piece onto the packed earth, allowing [benoit em] to guess what it is by the sound it makes.  [benoit Eir] breathing comes heavier as your undergarments make a feathery sound as they fall.");

		outputText("\n\n\"<i>Zis will sound strange,</i>\" says [benoit name] in a low, thick voice, \"<i>But - would you mind if I just touched you a bit first?  All I know about you is your smell and ze sound of your voice.</i>\"  You acquiesce and draw close, taking [benoit eir] hands once again and gently laying them upon your body.  You sigh as, holding [benoit eir] index claws back, [benoit ey] begins to move them slowly up and down.");

	//[Demon:
		if(player.horns.count > 0 && player.horns.type == Horns.DEMON && player.tailType == Tail.DEMONIC && (player.isRace(Races.DEMON, 1, false)||player.isRace(Races.IMP, 1, false))) outputText("\n\n[benoit Eir] warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  [benoit Ey] touches your horns and pauses; [benoit ey] reaches around, finds and grips your tail, running [benoit eir] pads up to the spaded point.  \"<i>So,</i>\" [benoit ey] says quietly.  \"<i>You are one of zem.</i>\"  [benoit Ey] is silent for a while before finding a warm smile.  \"<i>But I am being silly.  I know you are different inside.</i>\"");
		//[Dog enough for ears and tail:
		else if(player.ears.type == Ears.DOG && player.tailType == Tail.DOG && player.racialScore(Races.DOG, false) >= 3) outputText("\n\n[benoit Eir] warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  [benoit Ey] grins as [benoit ey] finds your floppy ears and outright laughs when [benoit ey] reaches around and touches your tail. \"<i>I like dogs, but not ZAT much, [name],</i>\" [benoit ey] laughs.");
		//[Cat/Bunny enough for ditto:
		else if(player.racialScore(Races.CAT, false) >= 3 && player.tailType == Tail.CAT && player.ears.type == Ears.CAT) outputText("\n\n[benoit Eir] warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  [benoit Ey] grins as [benoit ey] finds your ears, outright laughs when [benoit ey] reaches around and touches your soft tail.  \"<i>I always wondered why Pierre gets all excited when 'e sees you,</i>\" [benoit ey] chuckles huskily.");
		//[Avian with wings and feet:
		else if(player.lowerBody == LowerBody.HARPY && player.wings.type == Wings.FEATHERED_LARGE) outputText("\n\n[benoit Eir] warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  [benoit Ey] finds your wings and follows them up as far as [benoit ey] can reach, making you twitch as [benoit ey] caresses your delicate pinfeathers; [benoit ey] carefully shifts [benoit eir] feet forward to touch at your own clawed toes.  \"<i>So,</i>\" [benoit ey] sighs, a smile playing on [benoit eir] lips as [benoit ey] touches your shoulder.  \"<i>What is in front of me is a terrible 'arpy.  Come from ze skies to ravish me.</i>\"");
		//[Reptile/Naga:
		else if(player.isScaleCovered() && (player.racialScore(Races.LIZARD, false) >= 3 || player.racialScore(Races.NAGA, false) >= 3) || player.racialScore(Races.DRAGON) >= 3) outputText("\n\n[benoit Eir] warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  [benoit Ey] starts slightly when [benoit ey] touches your scales, and then caresses the reptilian parts of your body with increasing interest.  \"<i>I cannot believe I did not realize you were a sister of ze scales,</i>\" [benoit ey] says huskily.  \"<i>Zat is very... interesting.</i>\"  You can see real arousal in the tense lines of [benoit eir] face now.");
		//[Bee:
		else if((player.wings.type == Wings.BEE_SMALL || player.wings.type == Wings.BEE_LARGE) && player.lowerBody == LowerBody.BEE) outputText("\n\n[benoit Eir] warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  [benoit Ey] finds your diaphanous wings and follows them up as far as [benoit ey] can reach, [benoit eir] grip on your sensitive membranes making you twitch a bit; then [benoit ey] sends [benoit eir] hands trailing down your carapace-armored limbs.  \"<i>I sought you just liked wearing big boots,</i>\" [benoit ey] murmurs.  \"<i>But zis is actually a part of you?  'Ow... interesting.</i>\"");
		//[Centaur:
		else if(player.isTaur()) outputText("\n\n[benoit Eir] warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  \"<i>Good Gods,</i>\" [benoit ey] murmurs as [benoit eir] hands lead back onto your flanks.  \"<i>Good Gods!</i>\" [benoit ey] cries out as [benoit ey] follows you all the way back to your mighty, powerful rear.  \"<i>I knew you were a centaur because of all ze clopping,</i>\" [benoit ey] says, rubbing your flank back and forth in wonder.  \"<i>But to know it and actually feel it, zey are very different.</i>\"  [benoit Ey] sighs.  \"<i>Zis is going to be a bit... awkward, but I am guessing you are all too used to zat by now, yes?</i>\"");
		else if(player.isDrider()) outputText("\n\n[benoit Eir] warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  \"<i>Good Gods,</i>\" [benoit ey] murmurs as [benoit eir] hands lead back onto your tough exoskeleton. \"<i>Good Gods!</i>\" [benoit ey] cries out as [benoit ey] follows your bulging abdomen all the way back to your spinnerets. \"<i>I knew you were a spider because of all ze click-clacking,</i>\" [benoit ey] says, [benoit eir] fingers feeling around one of your intricate, many-jointed legs in wonder.  \"<i>But to know it and actually feel it, zey are very different.</i>\"");
		//[Slime:
		else if(player.isGoo()) outputText("\n\n[benoit Eir] warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  \"<i>I knew you were different from ze squishy sounds you made,</i>\" [benoit ey] murmurs as [benoit eir] hands sink into your soft, amorphous mass.  \"<i>But zis is...good Gods, zis is strange.  And zis doesn't 'urt you at all?</i>\" [benoit ey] asks incredulously as [benoit ey] gently pokes a finger into you.  You answer [benoit eir] question by giggling.  \"<i>Zat must come in very useful,</i>\" [benoit ey] says, shaking [benoit eir] head in wonder.  You push yourself slowly up [benoit eir] arms and tell [benoit em] [benoit ey] has no idea.");
		else outputText("\n\n[benoit Eir] warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  \"<i>You 'umans are so squishy, fuzzy and 'ot,</i>\" [benoit ey] says huskily. \"<i>'Ow can you stand it?</i>\"");
		if(player.hasCock()) {
			outputText("\n\n[benoit Eir] hands travel downwards until, with a sharp intake of breath, [benoit ey] touches [oneCock].  \"<i>Aren't you just full of surprises,</i>\" [benoit ey] says dryly.  After a pause, [benoit ey] slowly wraps [benoit eir] smooth hand around your semi-erect cock and moves it up and down, rubbing and coiling you until you are straining.");
			if(player.cocks[player.biggestCockIndex()].cockLength < 10) outputText("  Although this is evidently an uncanny experience for [benoit em], [benoit ey] does manage a cocky smile as [benoit eir] hand moves along your male sex.  \"<i>Mine is bigger,</i>\" [benoit ey] teases.  You reward [benoit eir] cheek by doing some feeling yourself, grasping and pinching at [benoit eir] tight, supple behind through [benoit eir] trousers, making [benoit em] gasp as you move into [benoit em].");
			else outputText("  This is evidently an uncanny experience for [benoit em], the alien nature of it deepening as [benoit eir] hands moves along your male sex. \"<i>'Oly Gods, [name]; you are a monster,</i>\" [benoit ey] says thickly.  You smile and decide it's time to do some feeling yourself; you grasp and pinch at [benoit eir] tight, supple behind through [benoit eir] trousers, making [benoit em] gasp as you move into [benoit em].");
		}
		outputText("\n\n[benoit Eir] hands trail further down, moving into your inner thighs, exploring your soft flesh until [benoit ey] touches your lips.  You close your eyes and sigh as [benoit ey] slowly parts them with [benoit eir] smooth fingers and slides into your [vagina].  Although [benoit eir] breath is becoming increasingly heavy [benoit ey] also seems genuinely curious about you; with surprising gentleness [benoit eir] fingers travel over and around your moistening sex, exploring your every fold, working deeper and deeper as [benoit ey] does.  You let [benoit em] know what pleases you by sighing when [benoit ey] touches a sweet spot, moving deliberately with [benoit eir] finger's motions so [benoit ey] may give them better attention.  [benoit Ey] soon finds your [clit], beginning to bulge with need; slowly [benoit ey] circles it and then flicks at it, gently frigging you.");
		if(player.inHeat) outputText(" By now your vagina is practically gushing, your body's own deep-seated pheromone need stoked to blazing heights by the basilisk's gentle, painstaking exploration.  You cannot stop yourself thrusting against [benoit eir] soaked hand, announcing how badly you want this with heavy moans.");

		outputText("\n\nThe scent of your arousal is in the air and as [benoit name] inhales it, [benoit eir] own breath comes heavier.  [benoit Eir] erection bulges in [benoit eir] long johns and you decide it's time for you to take charge; you push [benoit em] against the wall, unbuckle [benoit em] and let [benoit eir] trousers fall.  Stoked by the pheromones simmering off your body, [benoit eir] long, thin, purple erection is straining and [benoit ey] arches [benoit eir] back and opens [benoit eir] mouth as you lay a hand on it.  You know just from looking at [benoit eir] straining prick you're going to have to go slow for [benoit em] not to shoot [benoit eir] bolt straight away; with a wicked smile your partner can't see, you suppose that such is your body's effect on [benoit em] it may not even matter if [benoit ey] does.  As lost as the horny lizan is to the haze of [benoit eir] pleasure, you remind [benoit em] of reality the best way you know how, guiding [benoit eir] hands to your [hips] and with a sigh, slowly sliding [benoit eir] length into your moistened [vagina] with as much grace as your eagerness can stand.");

		if (!recalling) player.cuntChange(14,true,true,false);

		outputText("\n\nBenoit's dick is incredibly smooth and you move down onto it with slick ease.  Rather than burying yourself onto it straight away, you stop with only a third of it in your wet depths and bring it out of you, dipping yourself slowly.  You stop with [benoit eir] sensitive head just inside and work your thighs around deliberately, sighing as it rotates around your slick walls.  [benoit name] moans and you feel [benoit eir] body tense; immediately you halt your movements and wait, only gradually beginning to gyrate and thrust again when [benoit ey] has calmed down.  You slide more inside when you bend forwards again, this time leaving only [benoit eir] base outside of you; a sigh rolls from you as you feel [benoit em] creeping further into your moist depths.  [benoit Ey] makes a bestial noise and tries to thrust himself into you and upon you; tutting mockingly, you pull yourself away from [benoit em] and stop moving until, with what is evidently a huge force of will, the basilisk calms himself, backs himself against the wall and allows you to work [benoit em].");

		if(player.vaginalCapacity() < 15) outputText("\n\nYou slide back down onto [benoit em], cooing this time as you feel [benoit em] bottom out with several inches still outside.  [benoit Eir] thin member could not be more perfect for your tight sex; [benoit ey] rubs your walls up and down as you dreamily thrust in and out of [benoit eir] body, sending waves of pleasure washing through you.");
		else outputText("\n\nYou slide back down onto [benoit em], cooing this time as your groin meets [benoit eir] muscular thighs with a wet kiss, your sex swallowing [benoit eir] cock whole.  You begin to ride [benoit em] hard and slow, bending [benoit eir] cock upwards to push at your sensitive walls, waves of pleasure starting to wash through you.");

		outputText("\n\nYou keep at this for what feels like hours, stopping and starting, pulling and pushing deliberately to keep the basilisk you have backed into a corner under your control.  The pace of the fuck is clearly agonising for [benoit name]; [benoit ey] pants, tenses and gasps to the wet movement of your [vagina], [benoit eir] face and chest heaving with extreme arousal, but [benoit ey] lets you stay in command, eventually giving up on anything but lying back and letting you have your way with [benoit em].  To give [benoit em] something to do, you grab [benoit eir] hands and lay them upon your [chest]; after exploring your flesh for a time, [benoit ey] finds your [nipple]s and begins to knead them, placing each nub between two fingers and rubbing them insistently.");
		if(player.lactationQ() > 100) {
			outputText("  You moan as your breasts reward [benoit eir] attention with spurts of milk; [benoit ey] starts in genuine amazement when they ");
			if(!player.isTaur()) outputText("hit [benoit em] in the face");
			else outputText("trickle over [benoit eir] fingers");
			outputText(".  \"<i>Mammals are so damn weird,</i>\" [benoit ey] mutters, making you giggle.");
		}
		outputText("\n\nYour lust ratchets up as [benoit eir] warm hands continue to move, and at last losing your discipline you thrust into [benoit em] with abandon, eager now for your peak.  [benoit name] pants as you really begin to fuck [benoit em] and begins to thrust with you; you clutch [benoit eir] neck and bite into [benoit eir] shoulder as you pound into each other, the wetness of your arousal spattering against [benoit eir] thighs as your body slaps into the basilisk's tight muscles.  [benoit Ey] makes a harsh, bestial noise when [benoit ey] cums; [benoit eir] blind eyes roll as [benoit ey] clutches your back and shoots surge after surge of cum into your churning depths.  The warmth of [benoit eir] jizz and [benoit eir] helpless bucking thrust you to your own orgasm; irrepressible pulses of pleasure overwhelm your mind and you can do nothing for long minutes except cry and squeal on top of the basilisk, clutching [benoit em] back as you work [benoit eir] dick for every last drop of cum.");
		if(player.hasCock()) {
			if(!player.isTaur()) outputText("  Stuck between your two burning bodies, y");
			else outputText("Y");
			outputText("our [cock] spurts in sympathy to your female high, soaking ");
			if(!player.isTaur()) outputText("both of you");
			else outputText("the dry dirt");
			outputText(" with white.");
		}
	}
	outputText("\n\nEventually, the two of you part, dripping your mixed fluids as you step back.  \"<i>Phew!</i>\" [benoit name] says after [benoit ey]'s managed to catch [benoit eir] breath.  \"<i>That was... somesing.  Mademoiselle, you are... amazing.</i>\"  You find yourself laughing at [benoit eir] slightly shell-shocked expression, and the light, happy sound seems to bring [benoit em] around a bit. ");
	//fast exit for recalling
	if (recalling) {
		doNext(recallWakeUp);
		return;
	}
	outputText("[benoit Ey] brushes your shoulder as [benoit ey] walks past you, feeling around the stockroom until [benoit ey] finds a chest of drawers.  [benoit Ey] opens a compartment and withdraws a small woollen bag, stuffed with pungent green leaves.");
	outputText("\n\n\"<i>Ze shark ladies are always coming up from ze lake to sell me zis,</i>\" [benoit ey] says. \"<i>It is a very effective, 'ow you say, 'counter septic'?");
	player.sexReward("cum", "Vaginal");
	if ((player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS || player.hasPerk(PerkLib.HarpyWomb) || player.hasPerk(PerkLib.Oviposition) >= 0) && (player.canGetPregnant() || (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS || player.pregnancy2Type == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) && !player.hasUniquePregnancy())) {
		outputText("  I would not inflict my children upon you.  Ere, take as much as you like.</i>\"");
		simpleChoices("Take It", takeBenoitsContraceptives, "", null, "", null, "", null, "Leave", dontTakeEggtraceptives);
	}
	else {
		outputText("  I cannot give you babies unless you 'ave eggs.  I guess I should think a bit more before I go digging for things...</i>\"");
		//, but if your body goes into 'eat again and you are afraid of 'aving... unwanted experiences... I can sell it to you.</i>\"]
		doNext(camp.returnToCampUseOneHour);

	}

}

private function takeBenoitsContraceptives():void {
	clearOutput();
	outputText("You gladly accept the herbal contraceptive and push it into your mouth, enjoying the pleasantly sharp, citrus flavour.");
	doNext(camp.returnToCampUseOneHour);
}

private function dontTakeEggtraceptives():void {
	clearOutput();
	outputText("You smile and say you don't mind carrying and laying a few basilisk eggs. \"<i>You... you don't?</i>\" [benoit ey] says hesitantly.  [benoit Ey] faces you and for a moment looks like [benoit ey]'s going to say something else; but then [benoit ey] shakes [benoit eir] head and puts the bag back into the drawer.");
	outputText("\n\nIn the warm afterglow you redress at leisure before leading [benoit em] back inside the shop and, after squeezing [benoit eir] hand, take your leave.");
	benoitKnocksUpPCCheck();
	doNext(camp.returnToCampUseOneHour);
}


//Subsequent visit to the shop:
private function firstTimeAfterBoningEncounterBenoit():void {
	clearOutput();
	//Set a flag here to make sure it only happens once.
	flags[kFLAGS.BENOIT_POST_FIRSTFUCK_TALK] = 1;
	outputText("A strange, faint noise is emanating from the salvage shop.  It's only when you duck cautiously into the stall proper that you realize it's the sound of a basilisk humming.  [benoit name] stops to sniff the air when you come in, immediately puts down the mug [benoit ey] is polishing, and beckons you inside.");

	outputText("\n\n\"<i>'Allo again, [name]</i>\"!</i>\" [benoit ey] says brightly.  \"<i>'Ow pleasant it is to see you.  'Ow are we zis very fine day?</i>\"  There's something imperceptibly different about [benoit name] today and it takes you a moment to work out what it is.  [benoit Ey] doesn't seem quite as shabby as [benoit ey] did before; [benoit eir] scales gleam dully and you wonder if [benoit ey]'s taken a bath recently.  There's something else, too.");

	outputText("\n\n\"<i>Zis?  No.  Of course not!</i>\" [benoit ey] says, when you ask if [benoit ey]'s wearing the navy tie just for you.  \"<i>Is zere somesing wrong with a basilisk wanting to look 'is best?  Anyway, I am taking it off now.  It is very silly, I see zis now.  Now... what is it zat mademoiselle is after?</i>\" You try not to laugh at this display and consider what it is you're here for.");
}

//Let [benoit em](not for horses):
private function repeatSexWithBenoitLetHim():void {
	clearOutput();
	if(player.isTaur()) {
		outputText("\n\nFor the moment you don't do anything; you simply stand back and let [benoit eir] hands slowly move across your frame.  One of [benoit eir] hands comes to rest upon your [nipples]; as [benoit ey] gently teases and kneads the soft, sensitive flesh [benoit eir] other hand drift downwards, across your belly, around your waist and down your velvety back.  Although [benoit ey] is familiar with your frame by now [benoit name] never seems to stop being enthralled by your body; there is an unconscious frown of concentration on [benoit eir] face as [benoit eir] smooth hands move across your warm skin, as if [benoit ey] were mapping you in [benoit eir] mind's eye.");
		outputText("\n\nThis slow, gentle pressure is all very well, but you can't help but wonder if you can't awaken something a bit more bestial in the timid basilisk.  The thought of making [benoit em] lose [benoit eir] self-control over you makes you grin, and tenderly but firmly you put your hands on [benoit eir] claws and tell [benoit em] to stop.  [benoit Ey] looks at you in puzzlement.  Smiling, you begin to give [benoit em] some of [benoit eir] own treatment; your hands drift softly over [benoit eir] tight, smooth flesh, working down [benoit eir] flat stomach until they reach [benoit eir] long johns.  You slowly unbuckle them and let them fall, releasing [benoit eir] long, thin erection.  With one hand you circle the base gently; even touching this least sensitive part of [benoit eir] dick makes [benoit em] grunt with need, the thump of [benoit eir] heart reverberating through [benoit eir] scales, and [benoit ey] involuntarily thrusts forwards, trying to get more of your hand upon [benoit em].  Again, you tell [benoit em] to be still.  You continue to almost-masturbate [benoit em], your one hand rubbing the very base of [benoit eir] cock and the lips from which it thrusts, whilst you very gently sway your powerful back hips, your [vagina] beginning to moisten at the sight of the basilisk's intense arousal.  The scent of your sex is in the air and the fact you cannot reach back and do anything about it only intensifies your excitement.  [benoit name] is clenching [benoit eir] pointed teeth, trembling slightly like a pipe about to burst, [benoit eir] tail thrashing fitfully as you ponderously turn and lead your rump into [benoit em], smearing your essence over [benoit eir] incredibly receptive nostrils.  All [benoit ey] can smell is your own arousal as you begin to talk huskily, saying you've been a naughty girl playing in the mountains, you've teased and run away and mocked every creature you've found but now a big bad basilisk has got you cornered, and what is the big bad basilisk going to do now it's got this naughty girl all to itself...?");

		outputText("\n\nBenoit surges forwards, grasps you by the [butt], turns and pinions you to the wall.  Your laughs turn to gasps as with an almost pained growl, [benoit name] thrusts himself straight into your moist twat.  You can only clutch at the wall of the wagon as [benoit ey] begins to fuck you with abandon, pushing your human front forwards as [benoit ey] levers your [hips] upwards with each thrust.  [benoit Ey] is clumsy with lust as well as blind, uncaring of anything but the need to clench your body and hilt himself in your depths, unable to take hold of himself with your pussy juices coating [benoit eir] nose and burning an unstoppable path to [benoit eir] brain.  [benoit Eir] pheromone driven callousness and the discomfort of the wood against your hands ");
		if(player.biggestTitSize() >= 1) outputText("and [fullChest] ");
		outputText("augments the roughness of the fuck and you find yourself getting carried along with it, thrusting your powerful rump back against the basilisk and clenching [benoit em] deeper into you, delighting in [benoit eir] firm, dense mass pounding into you.  Your [vagina] dribbles juices around [benoit eir] impatient, straining dick, practically foaming as [benoit eir] smooth length rubs forcefully all along your sensitive tunnel.");
		player.cuntChange(14,true,true,false);

		outputText("\n\nThe rough sex knocks the breath and sense out of you and you are dizzy with it by the time you reach your high, gasping and making guttural noises as [benoit name]'s thumping makes your pussy clench and spasm around [benoit em].  [benoit Ey] joins in with a thick, breathless growl, and you feel surge after surge of cum flood your depths with warmth.  After you have finished thrashing against each other you stay where you are, gathering your breath on each other.  It takes you a while to realize [benoit ey] hasn't gone soft, and is still embedded firmly within you; your mixed fluids are dripping down your thighs and your musk is still in the air.  [benoit Ey] grins at you and gives you a tiny thrust, making you bite your lip; ejaculating seems to have only taken the slightest edge off the rut you've induced in [benoit em].  \"You did not sink you would get away zat easily, did you?\" [benoit ey] growls softly.");

		outputText("\n\nHe pulls out of you, trailing threads of semen as [benoit ey] goes, before slowly turning you around, painstakingly feeling around for a clear space with [benoit eir] feet, and then putting you down, gently but firmly positioning you on your lower body.  [benoit Eir] hands descend upon your [butt]; grinning, you poke it outwards invitingly, sighing with mock frustration as the blind basilisk painstakingly lines up [benoit eir] next shot with your drooling, sticky sex.");

		outputText("\n\nWhen [benoit ey] slides into you [benoit ey] does so with virtually no resistance whatsoever; the two of you have turned your pussy into an inviting, gooey sleeve.  ");
		//[Tight:
		if(player.vaginalCapacity() < 30) outputText("You don't mind; your tight sex is a perfect fit for [benoit eir] smooth, thin dick, and you work with [benoit em] as [benoit ey] thrusts, pulling and pushing your walls in time with [benoit eir] length, your lubrication allowing [benoit em] to quickly increase the tempo until the two of you are once again bucking against each other gleefully, your fluids spattering against each other.");
		//Loose:
		else outputText("Although [benoit ey] is long, [benoit ey] barely even touches the sides of your encompassing twat.  The sensation isn't great for you until [benoit ey] really starts to go to town, ramming into you with all [benoit ey]'s got, beating a wet staccato against your [butt], pushing against your [clit] as [benoit ey] sheaths himself in you.  Your fluids begin to dribble onto your hooves as your slick pleasure button bulges with increasing delight.");
		outputText("\n\nThe difference in the position makes [benoit eir] dick bend into you at a different angle, stroking a neglected spot which soon has you gasping with need.  [benoit name] is not as maddened as [benoit ey] was the first time, and [benoit ey] has the composure to draw himself out; [benoit ey] slows himself down and then back up again, fucking you magisterially, withdrawing himself almost all the way out of you before slamming firmly back in, stopping whilst hilted in you until you beg and moan for [benoit em] to continue.  You give yourself up to the dominant rut you've awoken in [benoit em], thrusting back into [benoit em] as you are fucked up to a second ecstatic height and then a third; everything disappearing underneath a timeless red haze, of having your [butt] in the air and being given what a mare needs.");

		outputText("\n\nWhen [benoit name] finally cums [benoit ey] sounds almost pained; [benoit eir] aching cock delivers another load into your already packed womb, semen dribbling and spurting onto the floor.  You work [benoit eir] dick for as long as you can until it finally droops out of your abused cunt.  Finally you sit up, turn around and cuddle into the basilisk, who pools onto the floor and responds tentatively.");

		outputText("\n\n\"Zat was... wow,\" [benoit ey] manages.  With [benoit eir] dick wrung of every last drop of [benoit eir] seed you can see [benoit ey] is returning to himself, and [benoit eir] hand around your waist is cautious. \"Was zat... all right for you? I do not know if... I get zese smells in my 'ead and zen...\" You answer [benoit em] by kissing [benoit em] on the cheek and saying with teasing huskiness that it was good, but maybe next time [benoit ey] shouldn't hold back so much.  [benoit Ey] grins at this.  You spend a bit more time cuddling whilst recovering from the intense fuck, before finally clambering to your feet.  Your final act before dressing and taking your leave is to faintly brush your scent across [benoit name]'s nose again, telling [benoit em] you expect [benoit em] to be ready and primed the next time this naughty girl pays a visit.  [benoit Ey] doesn't respond- maybe [benoit ey] is still privately ashamed about losing [benoit eir] cool over you- but you can tell by the lines of [benoit eir] face and the way [benoit eir] head moves unconsciously to follow your path out of [benoit eir] shop that [benoit em] not being aroused by you isn't something you're ever going to have to worry about.");
	}
	else {
		sceneHunter.print("Check failed: Taur body");
		outputText("For the moment you don't do anything; you simply stand back and let [benoit eir] hands slowly move across your frame.  One of [benoit eir] hands comes to rest upon your " + nippleDescript(0) + "; as [benoit ey] gently teases and kneads the soft, sensitive flesh [benoit eir] other hand drift downwards, across your belly, around over the crack of your [butt] then down to cup your behind.  Although [benoit ey] is familiar with your frame by now, [benoit name] never seems to stop being enthralled by your body; there is an unconscious frown of concentration on [benoit eir] face as [benoit eir] smooth hands move across your warm skin, as if [benoit ey] were mapping you in [benoit eir] mind's eye.");

		outputText("\n\nThis slow, gentle pressure is all very well, but you can't help but wonder if you can't awaken something a bit more bestial in the timid basilisk.  The thought of making [benoit em] lose [benoit eir] self-control over you causes you to grin, unseen, and tenderly but firmly you put your hands on [benoit eir] claws and tell [benoit em] to stop.  [benoit Ey] looks at you in puzzlement as you shift your bodies around, your hands sliding over [benoit eir] shoulders and chest as you change position so that it is you with your back to the wall.  [benoit Ey] begins to move [benoit eir] hands again and you tut mockingly, telling [benoit em] to be still for now.  Smiling, you begin to give [benoit em] some of [benoit eir] own treatment; your hands drift softly over [benoit eir] tight, smooth flesh, working down [benoit eir] washboard stomach until they reach [benoit eir] long johns.  You slowly unbuckle them and let them fall, releasing [benoit eir] long, thin erection.  With one hand you circle the base gently; even touching this least sensitive part of [benoit eir] dick makes [benoit em] grunt with need, the thump of [benoit eir] heart reverberating through [benoit eir] scales, and [benoit ey] involuntarily thrusts forwards, trying to get more of your hand upon [benoit em].  Again, you tell [benoit em] to be still.  You continue to almost-masturbate [benoit em], your one hand rubbing the very base of [benoit eir] cock and the slit from which it thrusts, whilst with the other you reach down and touch your own slickening [vagina].  You moan exaggeratedly as you dip first one finger and then two into your honey pot, gently frigging your [clit] until you are in full spate, dripping your fluids onto the packed earth beneath you.  [benoit name] is clenching [benoit eir] pointed teeth, trembling slightly like a pipe about to burst, as you lift your coated fingers up and smear your essence over [benoit eir] incredibly receptive nostrils.  [benoit Eir] tail thrashes fitfully as you continue to torment [benoit eir] dick, just barely touching [benoit eir] purple tip before returning to [benoit eir] base.  All [benoit ey] can smell is your own arousal as you begin to talk huskily, saying you've been a naughty girl playing in the mountains, you've teased and mocked and run away from every creature you've found but now a big bad basilisk has got you cornered, and what is the big bad basilisk going to do now it's got this naughty girl all to itself...?");

		outputText("\n\nBenoit surges forward, grasps you by the [butt] and pinions you to the wall.  Your laughs turn to gasps as [benoit ey] lifts your teasing hands upwards, pinning them out of the way with the mass of [benoit eir] body and with an almost pained growl, thrusts himself straight into your moist twat.  You can only clutch at [benoit eir] back as [benoit ey] begins to fuck you with complete abandon, smacking your back into the wall of the wagon and levering your [hips] upwards with each thrust.  [benoit Ey] is clumsy with lust as well as blind, uncaring of anything but the need to clench your body and hilt himself in your depths, unable to take hold of himself with your pussy juices coating [benoit eir] nose and burning an unstoppable path to [benoit eir] brain.  [benoit Eir] pheromone-driven callousness and the discomfort of the wood rubbing against your back and butt augments the roughness of the fuck and you find yourself getting carried along with it, wrapping your thighs around the basilisk's thin waist and clenching [benoit em] deeper into you, delighting in [benoit eir] firm, dense mass pounding into you.  Your [vagina] dribbles juices around [benoit eir] impatient, straining dick, practically foaming as [benoit eir] smooth length rubs forcefully all along your sensitive tunnel.");

		outputText("\n\nThe rough sex knocks the breath and sense out of you and you are dizzy with it by the time you reach your high, gasping and making guttural noises as [benoit name]'s thumping makes your pussy clench and spasm around [benoit em].  [benoit Ey] joins in with a thick, breathless growl, and you feel surge after surge of cum flood your depths with warmth.  After you have finished thrashing against each other, you stay still, gathering your breath on each other.  It takes you a while to realize [benoit ey] hasn't gone soft, that [benoit eir] prick is still embedded firmly within you; your mixed fluids are dripping down your thighs and your musk is still in the air.  [benoit Ey] grins at you and gives you a tiny thrust, making you bite your lip; ejaculating seems to have only taken the slightest edge off the rut you've induced in [benoit em].  \"<i>You did not sink you would get away zat easily, did you?</i>\" [benoit ey] growls softly.");


		outputText("\n\nHe pulls out of you, trailing threads of semen as [benoit ey] goes, before slowly turning you around, painstakingly feeling around for a clear space with [benoit eir] feet, and then putting you down, gently but firmly positioning you on your hands and ");
		if(player.isBiped()) outputText("knees");
		else outputText("lower body");
		outputText(".  [benoit Eir] hands descend upon your [butt]; grinning, you poke it outwards invitingly, sighing with affected frustration as the blind basilisk painstakingly lines up [benoit eir] next shot with your drooling, sticky sex.");

		outputText("\n\nWhen [benoit ey] slides into you [benoit ey] does so with virtually no resistance whatsoever; the two of you have turned your pussy into an inviting, gooey sleeve.  ");
		if(player.vaginalCapacity() < 30) outputText("You don't mind; your tight sex is a perfect fit for [benoit eir] smooth, thin dick, and you work with [benoit em] as [benoit ey] thrusts, pulling and pushing your walls in time with [benoit eir] length, your lubrication allowing [benoit em] to quickly increase the tempo until the two of you are once again bucking against each other gleefully, your fluids spattering against each other.");
		else outputText("Although [benoit ey] is long, [benoit ey] barely even touches the sides of your encompassing twat.  The sensation isn't great for you until [benoit ey] really starts to go to town, ramming into you with all [benoit ey]'s got, beating a wet staccato against your [butt].  You send a hand roaming back around and begin to finger your [clit] as [benoit ey] sheaths himself in you, [benoit eir] fluids running down your fingers as you work your slick, bulging pleasure button with increasing delight.");
		player.cuntChange(10,true,true,false);
		outputText("  The difference in the position makes [benoit eir] dick bend into you at an angle, stroking a neglected spot which soon has you gasping with need.  [benoit name] is not as maddened as [benoit ey] was the first time, and [benoit ey] has the composure to draw himself out; [benoit ey] slows himself down and then back up again, fucking you magisterially, withdrawing himself almost completely before slamming firmly back in, stopping whilst hilted in you until you beg and moan for [benoit em] to continue.  You give yourself up to the dominant rut you've awoken in [benoit em], thrusting back into [benoit em] as you are fucked up to a second ecstatic height and then a third; everything disappearing underneath a timeless red haze, of being on your hands and knees with your [butt] in the air and being given what a female animal needs.");

		outputText("\n\nWhen [benoit name] finally cums [benoit ey] sounds almost pained; [benoit eir] aching cock delivers another load into your already packed womb, semen dribbling and spurting onto the floor.  You work [benoit eir] dick for as long as you can until it finally droops out of your abused cunt.  Finally you crawl into a sitting position and cuddle into the basilisk, who pools onto the floor and responds tentatively.");

		outputText("\n\n\"<i>Zat was... wow,</i>\" [benoit ey] manages.  With [benoit eir] dick wrung of every last drop of [benoit eir] seed you can see [benoit ey] is returning to himself, and [benoit eir] hand on your shoulder is cautious.  \"<i>Was zat... alright for you?  I do not know if... I get zese smells in my 'ead and zen...</i>\"  You answer [benoit em] by kissing [benoit em] on the cheek and saying with teasing huskiness that it was good, but perhaps next time [benoit ey] shouldn't hold back so much.  [benoit Ey] grins at this.  You spend a bit more time cuddling whilst recovering from the intense fuck, before finally clambering to your feet.  Your final act before dressing and taking your leave is to dip a lazy finger into your cunt and faintly brush your scent across [benoit name]'s nose again, telling [benoit em] you expect [benoit em] to be ready and primed the next time this naughty girl pays a visit.  [benoit Ey] doesn't respond - maybe [benoit ey] is still privately ashamed about losing [benoit eir] cool over you - but you can tell by the lines of [benoit eir] face and the way [benoit eir] head moves unconsciously to follow your path out of [benoit eir] shop that [benoit em] not being aroused by you isn't something you're ever going to have to worry about.");
	}
	flags[kFLAGS.BENOIT_TIMES_SEXED_FEMPCS]++;
	player.sexReward("cum", "Vaginal");
	benoitKnocksUpPCCheck();
	benoitAffection(2);
	doNext(camp.returnToCampUseOneHour);
}

//Take charge:
private function repeatBenoitFuckTakeCharge():void {
	clearOutput();
	if(player.isTaur()) {
		outputText("\n\nFor the moment you don't do anything; you simply stand back and let [benoit eir] hands slowly move across your frame.  One of [benoit eir] hands comes to rest upon your [nipple]; as [benoit ey] gently teases and kneads the soft, sensitive flesh [benoit eir] other hand drift downwards, across your belly, then slowly back along your vast equine frame.  Although [benoit ey] is familiar with your frame by now [benoit name] never seems to stop being enthralled by your body; there is an unconscious frown of concentration on [benoit eir] face as [benoit eir] smooth hands move across your warm skin, as if [benoit ey] were mapping you in [benoit eir] mind's eye.");

		//[Herm:
		if(player.isTaur()) outputText("\n\n[benoit Eir] hands travel downwards until, with a small grin, [benoit ey] finds what [benoit ey] knows is there.  [benoit Ey] wraps [benoit eir] dry, smooth grasp around your semi-erect cock and moves it up and down, rubbing and coiling you until you are straining.  You close your eyes and sigh, enjoying the masterful treatment that both of you can only feel, not see.");

		outputText("\n\n[benoit Eir] hands trail upwards, moving over your bestial behind, exploring your soft flesh until [benoit ey] touches your lips.  You close your eyes and sigh as [benoit ey] slowly parts them with [benoit eir] smooth fingers and slides into your [vagina].  Although [benoit eir] breath is becoming increasingly heavy [benoit ey] also seems genuinely curious about you; with surprising gentleness [benoit eir] fingers travel over and around your moistening sex, exploring your every fold, working deeper and deeper as [benoit ey] does.  You let [benoit em] know what pleases you by sighing when [benoit ey] touches a sweet spot, moving deliberately with [benoit eir] finger's motions so [benoit ey] may give them better attention.  [benoit Ey] soon finds your [clit], beginning to bulge with need; slowly [benoit ey] circles it and then flicks at it, gently frigging you.");
		if(player.inHeat) outputText("  By now your vagina is practically gushing, your bodies' own deep seated pheromone need stoked to blazing heights by the basilisk's gentle, painstaking exploration of your body.  You cannot stop thrusting yourself against [benoit eir] soaked hand, announcing how badly you want this with heavy moans.");

		outputText("\n\nThe scent of your arousal is in the air and as [benoit name] breathes it in [benoit eir] own breath comes heavier.  [benoit Eir] erection bulges in [benoit eir] long johns and you decide it's time for you to take charge; you back up, butting [benoit em] insistently with your powerful body until you have [benoit em] pinned against a space upon the opposite wall.  You watch [benoit em] over your shoulder as [benoit ey] unbuckles himself and lets [benoit eir] trousers fall.  Stoked by the pheromones simmering off your body, [benoit eir] long, thin purple erection is straining and [benoit ey] arches [benoit eir] back and opens [benoit eir] mouth as you flare your [butt] and press yourself against it.  You know just from looking at [benoit eir] intense arousal you're going to have to go slow to stop [benoit em] from shooting [benoit eir] bolt straight away; with a wicked smile your partner can't see, you suppose such is your effect on [benoit em] it may not even matter if [benoit ey] does.  Still, as [benoit ey] lays [benoit eir] hands upon your flanks, and with a sigh you lead back and slowly slide [benoit eir] length into your moistened [vagina], it is as gently as you can.");

		outputText("\n\nBenoit's dick is incredibly smooth and you move down onto it with incredible, slick ease.  Rather than burying yourself onto it straight away you stop with only a third of it in your wet depths and slowly bring it out of you, dipping yourself slowly.  You stop with [benoit eir] sensitive head just inside and work your [hips] around deliberately, sighing as it rotates slowly around your slick walls.  [benoit name] moans dryly and you feel [benoit eir] body tense; immediately you stop your movements and wait, only gradually beginning to gyrate and thrust again when [benoit ey] has calmed down.  You slide more of [benoit em] into you when you bend forwards again, this time leaving only [benoit eir] base outside of you; you sigh as you feel [benoit em] creeping further into your moist depths.  [benoit Ey] makes a bestial noise and tries to thrust himself into you and upon you; tutting mockingly, you pull yourself away from [benoit em] and stop moving until, with what is evidently a huge force of will, the basilisk calms himself, backs himself against the wall and allows you to work [benoit em].");

		outputText("\n\n");
		//[Small capacity:]
		if(player.vaginalCapacity() < 30) outputText("You slide back down onto [benoit em], cooing this time as you feel [benoit em] bottom out with several inches of [benoit em] still outside of you.  [benoit Eir] thin, long length could not be more perfect for your tight sex; [benoit ey] rubs your walls up and down as you dreamily thrust in and out of [benoit eir] body, sending waves of pleasure flowing through you.");
		//Large capacity:
		else outputText("You slide back down onto [benoit em], cooing this time as your groin meets [benoit eir] muscular thighs with a wet kiss, your sex swallowing [benoit eir] cock whole.  You begin to ride [benoit em] hard and slow, bending [benoit eir] cock upwards to push at your sensitive walls, waves of pleasure starting to flow through you.");

		outputText("\n\nYou keep at this slow ride for what feels like hours, stopping and starting, pulling and pushing deliberately to keep the basilisk you have backed into a corner under your control.  The pace of the fuck is clearly agonising for [benoit name]; [benoit ey] pants, tenses and gasps to the wet movement of your [vagina], [benoit eir] face and chest red with extreme arousal, but [benoit ey] lets you stay in control, eventually unable to do anything but lie back and let you have your way with [benoit em].");
		player.cuntChange(14,true,true,false);
		//[Lactation:
		if(player.lactationQ() >= 50) outputText("  The slow, sensual sex is enough for you to begin to bead milk from your sensitive [nipples]; you moan as the flow intensifies until you are instinctively kneading your [chest], spurting your sweet, warm fluids onto the floor.  [benoit name] starts in genuine amazement at the sound.  \"Mammals are so damn weird,\" [benoit ey] mutters, making you giggle.");

		outputText("\n\nYour lust ratchets up as [benoit eir] warm hands continue to move over your behind, and at last losing your discipline you begin to thrust into [benoit em] with abandon, eager now for your peak.  [benoit name] pants as you really begin to fuck [benoit em] and thrusts with you; the wetness of your arousal spatters against [benoit eir] thighs as your body slaps into the basilisk's tight muscles.  [benoit Ey] makes a harsh, bestial noise when [benoit ey] cums; [benoit eir] blind eyes roll as [benoit ey] clutches your back and shoots surge after surge of cum into your churning depths.  The warmth of [benoit eir] jizz and [benoit eir] helpless bucking thrust you to your own orgasm; irrepressible pulses of pleasure overwhelm your mind and you can do nothing for long minutes except cry and squeal against the basilisk, clutching [benoit em] back as you work [benoit eir] dick for every last drop.");
		//[Herm:
		if(player.hasCock()) outputText("  [EachCock] thickens and spurts in sympathy to your female high, spattering the floor with white paint.");

		outputText("\n\nYou puddle onto the packed earth floor and cuddle for a while, holding each other as you bask in the afterglow, silently listening to the far away bustle and clatter of the carnival.");

		outputText("\n\n\"I am not really sure what I did to deserve you,\" says [benoit name] eventually, [benoit eir] voice barely above a raspy murmur in [benoit eir] throat.  You give [benoit em] a playful dig in the ribs and say you're only in it for the counter sceptic.  [benoit Ey] grins and the two of you get up, get dressed, and go your separate ways.");
	}
	else {
		outputText("For the moment you don't do anything; you simply stand back and let [benoit eir] hands slowly move across your frame.  One of [benoit eir] hands comes to rest upon your " + nippleDescript(0) + "; as [benoit ey] gently teases and kneads the soft, sensitive flesh [benoit eir] other hand drift downwards, across your belly, around over the crack of your [butt] then down to cup your behind.  Although [benoit ey] is familiar with your frame by now [benoit name] never seems to stop being enthralled by your body; there is an unconscious frown of concentration on [benoit eir] face as [benoit eir] smooth hands move across your warm skin, as if [benoit ey] were mapping you in [benoit eir] mind's eye.");

		if(player.hasCock()) outputText("\n\n[benoit Eir] hands travel downwards until, with a small grin, [benoit ey] finds what [benoit ey] knows is there.  [benoit Ey] wraps [benoit eir] dry, smooth grasp around your semi-erect cock and moves it up and down, rubbing and coiling you until you are straining.  You decide it's time to do some feeling yourself; you grasp and pinch at [benoit eir] tight, supple behind through [benoit eir] trousers, making [benoit em] gasp as you move into [benoit em].");

		//begin copypasta
		outputText("[benoit Eir] hands trail further down, moving into your inner thighs, exploring your soft flesh until [benoit ey] touches your lips.  You close your eyes and sigh as [benoit ey] slowly parts them with [benoit eir] smooth fingers and slides into your [vagina].  Although [benoit eir] breath is becoming increasingly heavy [benoit ey] also seems genuinely curious about you; with surprising gentleness [benoit eir] fingers travel over and around your moistening sex, exploring your every fold, working deeper and deeper as [benoit ey] does.  You let [benoit em] know what pleases you by sighing when [benoit ey] touches a sweet spot, moving deliberately with [benoit eir] finger's motions so [benoit ey] may give them better attention.  [benoit Ey] soon finds your [clit], beginning to bulge with need; slowly [benoit ey] circles it and then flicks at it, gently frigging you.");
		if(player.inHeat) outputText("  By now your vagina is practically gushing, your body's own deep-seated pheromone need stoked to blazing heights by the basilisk's gentle, painstaking exploration.  You cannot stop yourself thrusting against [benoit eir] soaked hand, announcing how badly you want this with heavy moans.");

		outputText("\n\nThe scent of your arousal is in the air and as [benoit name] inhales it, [benoit eir] own breath comes heavier.  [benoit Eir] erection bulges in [benoit eir] long johns and you decide it's time for you to take charge; you push [benoit em] against the wall, unbuckle [benoit em] and let [benoit eir] trousers fall.  Stoked by the pheromones simmering off your body, [benoit eir] long, thin, purple erection is straining and [benoit ey] arches [benoit eir] back and opens [benoit eir] mouth as you lay a hand on it.  You know just from looking at [benoit eir] straining prick you're going to have to go slow for [benoit em] not to shoot [benoit eir] bolt straight away; with a wicked smile your partner can't see, you suppose that such is your body's effect on [benoit em] it may not even matter if [benoit ey] does.  Still, as you once again lay [benoit eir] hands upon you, brace [benoit em] against the wall and, with a sigh, slowly slide [benoit eir] length into your moistened [vagina], it is as gently as your eagerness can stand.");
		player.cuntChange(10,true,true,false);

		outputText("\n\nBenoit's dick is incredibly smooth and you move down onto it with slick ease.  Rather than burying yourself onto it straight away, you stop with only a third of it in your wet depths and bring it out of you, dipping yourself slowly.  You stop with [benoit eir] sensitive head just inside and work your [hips] around deliberately, sighing as it rotates around your slick walls.  [benoit name] moans and you feel [benoit eir] body tense; immediately you halt your movements and wait, only gradually beginning to gyrate and thrust again when [benoit ey] has calmed down.  You slide more inside when you bend forwards again, this time leaving only [benoit eir] base outside of you; a sigh rolls from you as you feel [benoit em] creeping further into your moist depths.  [benoit Ey] makes a bestial noise and tries to thrust himself into you and upon you; tutting mockingly, you pull yourself away from [benoit em] and stop moving until, with what is evidently a huge force of will, the basilisk calms himself, backs himself against the wall and allows you to work [benoit em].");

		//[Small capacity:
		if(player.vaginalCapacity() < 30) outputText("\n\nYou slide back down onto [benoit em], cooing this time as you feel [benoit em] bottom out with several inches still outside.  [benoit Eir] thin member could not be more perfect for your tight sex; [benoit ey] rubs your walls up and down as you dreamily thrust in and out of [benoit eir] body, sending waves of pleasure washing through you.");
		else outputText("\n\nYou slide back down onto [benoit em], cooing this time as your groin meets [benoit eir] muscled thighs with a wet kiss, your sex swallowing [benoit eir] cock whole.  You begin to ride [benoit em] hard and slow, bending [benoit eir] cock upwards to push at your sensitive walls, waves of pleasure starting to wash through you.");

		outputText("\n\nYou keep at this for what feels like hours, stopping and starting, pulling and pushing deliberately to keep the basilisk you have backed into a corner under your control.  The pace of the fuck is clearly agonising for [benoit name]; [benoit ey] pants, tenses and gasps to the wet movement of your [vagina], [benoit eir] face and chest heaving with extreme arousal, but [benoit ey] lets you stay in command, eventually giving up on anything but lying back and letting you have your way with [benoit em].  To give [benoit em] something to do, you grab [benoit eir] hands and lay them upon your [chest]; after exploring your flesh for a time, [benoit ey] finds your [nipple]s and begins to knead them, placing each nub between two fingers and rubbing them insistently.");
		//[Lactation:
		if(player.lactationQ() > 100) {
			outputText("  You moan as your breasts reward [benoit eir] attention with spurts of milk; [benoit ey] starts in genuine amazement when they ");
			if(!player.isTaur()) outputText("hit [benoit em] in the face");
			else outputText("trickle over [benoit eir] fingers");
			outputText(".  \"<i>Mammals are so damn weird,</i>\" [benoit ey] mutters, making you giggle.");
		}

		outputText("\n\nYour lust ratchets up as [benoit eir] warm hands continue to move, and at last losing your discipline you thrust into [benoit em] with abandon, eager now for your peak.  [benoit name] pants as you really begin to fuck [benoit em] and begins to thrust with you; you clutch [benoit eir] neck and bite into [benoit eir] shoulder as you pound into each other, the wetness of your arousal spattering against [benoit eir] thighs as your body slaps into the basilisk's tight muscles.  [benoit Ey] makes a harsh, bestial noise when [benoit ey] cums; [benoit eir] blind eyes roll as [benoit ey] clutches your back and shoots surge after surge of cum into your churning depths.  The warmth of [benoit eir] jizz and [benoit eir] helpless bucking thrust you to your own orgasm; irrepressible pulses of pleasure overwhelm your mind and you can do nothing for long minutes except cry and squeal on top of the basilisk, clutching [benoit em] back as you work [benoit eir] dick for every last drop of cum.");
		if(player.hasCock()) {
			//[(not horse)
			if(!player.isTaur()) outputText("  Stuck between your two burning bodies, y");
			else outputText("Y");
			outputText("our [cock] spurts in sympathy to your female high, soaking ");
			if(!player.isTaur()) outputText("both of you");
			else outputText("the dry dirt");
			outputText(" with white.");
		}

		outputText("\n\nYou puddle onto the packed earth floor and cuddle for a while, holding each other as you bask in the afterglow, silently listening to the far away bustle and clatter of the carnival.");

		outputText("\n\n\"<i>I am not really sure what I did to deserve you,</i>\" says [benoit name] eventually, [benoit eir] voice barely above a raspy murmur in [benoit eir] throat.  You give [benoit em] a playful dig in the ribs and say you're only in it for the counter sceptic.  [benoit Ey] grins and the two of you get up, get dressed, and go your separate ways.");
	}
	player.sexReward("cum", "Vaginal");
	benoitKnocksUpPCCheck();
	benoitAffection(2);
	flags[kFLAGS.BENOIT_TIMES_SEXED_FEMPCS]++;
	doNext(camp.returnToCampUseOneHour);
}

public function tryToConvertToBassyWomb():void {
	clearOutput();
	//A double dose of ovi-elixer, a bottle of reptilum, goblin ale and some basilisk blood would probably do...
	if(!recalling && !(player.hasItem(consumables.OVIELIX,2) && player.hasItem(consumables.REPTLUM) && player.hasItem(consumables.GOB_ALE))) {
		outputText("You don't have the necessary ingredients to attempt this yet.  You recall [benoit name] mentioning that you would need Reptilum, two Ovi Elixirs, and Goblin Ale.");
		doNext(benoitIntro);
	}
	else {
		if (!recalling) {
			player.consumeItem(consumables.OVIELIX, 2);
			player.consumeItem(consumables.REPTLUM);
			player.consumeItem(consumables.GOB_ALE);
		}
		outputText("You ferret out the ingredients you have collected and begin to bang them onto the counter in front of [benoit name], telling [benoit em] that you've got what [benoit ey] needs.  Pierre barks excitedly at the noise.");

		outputText("\n\n\"<i>And what is zat?</i>\" the basilisk says, bewildered. You explain you can whip something up which will give you a basilisk womb - and hence, female basilisk kids.  [benoit name] opens [benoit eir] mouth then closes it again; it takes [benoit em] a while to properly compute these words.  \"<i>But... but zat is completely impossible, [name]!</i>\" [benoit ey] says eventually, wringing [benoit eir] hands.  \"<i>'Ow do you know you won't just poison yourself?  Or, or turn yourself into a newt or somesing?  Please... don't 'urt... I should never 'ave said...</i>\"  [benoit Ey] lapses into silence as you grab a pewter bowl from a nearby shelf and a wooden spoon from a container full of old utensils, and begin to mix the various ingredients together.  You pour the ovi-elixers into the goblin ale, beating them together until a fairly unpleasant sulfuric smell fills the close market stall.  Carefully you dribble the reptilum in whilst continuing to stir, until the smell changes to that of cooking sherry.  You frown at the mixture.  It feels like it's missing something...  Casually, you ask [benoit name] to open [benoit eir] hand to you, whilst plucking a kitchen knife from the utensil container.  [benoit Ey] barks in pain as you run the blade across [benoit eir] palm and then hold [benoit eir] hand firmly over the bowl.  Drops of dark red blossom into the mixture, and as you carefully stir the potion turns a green-grey color: the color of [benoit name]'s scales.");

		outputText("\n\n\"<i>You 'ave been in ze sun too long [name],</i>\" says the basilisk harshly, clutching [benoit eir] hand. \"<i>Go 'ave a lie down and zen resink drinking whatever it is you 'ave just concocted.  I never asked for you to try zis.</i>\" You feel a moment of doubt... but no, you've poured good ingredients into this and you sure as hell aren't going to wimp out now.  You give [benoit name]'s uninjured hand a reassuring squeeze and say with as much confidence as you can muster that you know what you're doing.  With that, you cup the bowl, and with only a moment's hesitation, drink deeply.");

		outputText("\n\nThe mixture has a lingering bite of mint overlaying the all-consuming burn of alcohol; you are reminded vaguely of the sticky liqueurs that populated the recesses of cupboards back home.  You smack your lips and plonk the bowl back down with deliberate loudness after you have finished; [benoit name] clutches the counter tensely as you wait.  You haven't died straight away, so that's a positive... an immense gurgle comes from your belly and you double over as your insides shift and the contents of your gut churn.  The sensation is not painful exactly but you feel like you've lost all control of your insides; you clutch your sides and try to breathe levelly as your stomach turns upside down and makes a sound like trapped gas.  Eventually you feel something like a bubble form just below your gut; slowly your insides settle as the bubble grows larger and larger, until the sensation slowly fades.  Cautiously you walk back and forth a few times, before poking your tummy.");
		//[No oviposition:
		if(player.hasPerk(PerkLib.Oviposition) < 0) outputText("  You feel slightly bloated, but otherwise fine; you sense that you can lay eggs of your own volition now.");
		else outputText("You feel slightly bloated, but otherwise fine; you sense that were you to get impregnated by basilisk seed, the eggs you produce would be pure basilisk.");

		outputText("\n\n\"<i>[name]?</i>\" says [benoit name] nervously.  \"<i>Are you all right?  Shall I call ze sawbones? I will call ze sawbones.  'E is mostly good at taking people apart and putting zem back togezzer again, but I am sure 'e can give you a good purgative if we rush...</i>\"  You toy with the idea of staging a dramatic allergic reaction, but deciding not to fray [benoit eir] nerves any further you tell [benoit em] you feel absolutely fine.  Indeed, stroking your belly, you are almost certain that it worked.");

		outputText("\n\n\"<i>Really?</i>\"  The basilisk is off [benoit eir] feet and around the counter faster than you gave [benoit em] credit for.  \"<i>You are not just high from ze goblin ale?</i>\"  [benoit Ey] holds you around the waist and breathes you in slowly.  \"<i>You... you are not joking.</i>\"  [benoit Ey] sounds shell-shocked.  \"<i>You really did it.  You... really did mean to do zis.</i>\"");

		//put some tag here to track dis shit.
		if (!recalling) flags[kFLAGS.BENOIT_TESTED_BASILISK_WOMB] = .5;

		//[Lust 30 or more:
		if(player.lust >= 33 || recalling) {
			outputText("  You grin and say you're not sure it worked, but you suppose there's only one real way of finding out...");
			if(player.tallness <= 78 && !player.isTaur()) outputText("  The basilisk is still for a moment, and then with a sudden surge of movement, grabs you by the waist and hoists you over [benoit eir] shoulder.  You squeal in mock terror as [benoit ey] hauls you as fast as [benoit ey] can into the back room, knocking over half [benoit eir] stock as [benoit ey] does.");
			else outputText("  The basilisk is still for a moment, and then with a sudden surge of movement, grabs you by the waist and frenetically attempts to hoist you over [benoit eir] shoulder.  You are far too big for [benoit em] though; after several valiant attempts, [benoit ey] collapses against a shelf.  Laughing, you pick the stricken, panting reptile up, hoist [benoit em] over your own shoulder, and navigate a path into the back room.");
			doNext(createCallBackFunction(suggestSexAfterBasiWombed,false));
			return;
		}
		else outputText("  You grin and say you're not even sure it worked... but you'll be back at some point to try it out, and [benoit ey]'d better be ready for when you do.  You gently pry yourself out of [benoit eir] grip and leave as deliberately as you can, aware of the beguiling, invisible scent you are leaving for the stunned, silent basilisk to simmer in.");
		doNext(camp.returnToCampUseOneHour);
	}
}


private function suggestSexAfterBasiWombed(later:Boolean = true):void {
	clearOutput();
	//Subsequent \"<i>Suggest</i>\" if initial sex option not taken:
	if(later) {
		outputText("You smile coquettishly and ask if [benoit ey]'s interested in taking your new body for a... test drive.  ");
		//(6'6 or less:
		if(player.tallness <= 78 && !player.isTaur()) outputText("The basilisk is still for a moment, and then with a sudden surge of movement, grabs you by the waist and hoists you over [benoit eir] shoulder.  You squeal in mock terror as [benoit ey] hauls you as fast as [benoit ey] can into the back room, knocking over half [benoit eir] stock as [benoit ey] does.");
		else outputText("The basilisk is still for a moment, and then with a sudden surge of movement, grabs you by the waist and frenetically attempts to hoist you over [benoit eir] shoulder.  You are far too big for [benoit em] though; after several valiant attempts, [benoit ey] collapses against a shelf.  Laughing, you pick the stricken, panting reptile up, hoist [benoit em] over your own shoulder, and navigate a path into the back room.");
		outputText("\n\n");
	}
	if(!player.isTaur()) {
		sceneHunter.print("Check failed: Taur body");
		//Both go to: [>6'6:
		if(player.tallness > 78) outputText("You haul your lizard boy into the cramped space of the backroom before gently setting [benoit em] down.  Now that your gut has settled you feel imbued with an odd, ripe sensation; your belly bulges ever-so-slightly with unfertilized eggs and you feel red, soft and ready.  You begin to disrobe eagerly; having recovered himself slightly, [benoit name] shrugs out of [benoit eir] trousers, reaching out to you before stopping.  Grinning kindly at the emasculated basilisk, you lower yourself onto the floor, spread your [hips] casually and then ask if [benoit ey] see... smells anything interesting.");
		else outputText("[benoit name] staggers into the back room, bumping into several things as [benoit ey] sets you down, thankfully onto a clear space on the ground.  [benoit Ey] leans into you, [benoit eir] weight pushing you onto the ground, hands flying over your [armor], fumbling off clasps and belts when [benoit ey] finds them.  Now that your gut has settled you feel imbued with an odd, ripe sensation; your belly bulges ever-so-slightly with unfertilized eggs and you feel red, soft and ready.  You work with [benoit em], wriggling out of your clothes and ripping [benoit eir] own trousers off, spreading your [hips] eagerly as [benoit eir] long, smooth prick springs to attention.");

		outputText("\n\nThe basilisk needs no further invitation.  In a moment [benoit ey] is upon you, [benoit eir] tight, muscled chest pressed against your [chest], [benoit eir] flat stomach rubbing over your own fertile belly and the head of [benoit eir] dick pushed against your moist lips.");
		if(player.hasCock()) outputText("  [benoit Ey] deliberately rubs himself up and down your body, and the [cock] trapped between your warm bodies quickly hardens against the warm, smooth friction.");
		outputText("  Despite [benoit eir] blindness, [benoit ey] slides straight into your moist depths, making you coo as [benoit eir] hard, smooth spur glides across your sensitive walls, slowly bringing himself out before thrusting himself in again, working more and more of [benoit eir] length into you.  Never quite able to control himself around your body, it's obvious in the strain in [benoit eir] face and the raggedness of [benoit eir] breath against your skin that [benoit ey] is exercising every restraint [benoit ey] has not to fuck you into the ground; [benoit ey] pushes [benoit eir] dick upwards with each return thrust to bump deliberately against your [clit], sending irresistible spasms of pleasure chiming through you.  Pushed inexorably upwards you curl an arm around [benoit eir] neck, kiss [benoit eir] nose and grit your teeth, then whisper into [benoit eir] ear to stop holding back.  [benoit name] pauses for a moment to gather [benoit eir] breath, hilted entirely in your wet cunt, then hooks [benoit eir] hips around yours, entrapping you around [benoit eir] body, before beginning to fuck your softened, ripe body like a jackhammer.  [benoit Ey] pounds into you with everything [benoit ey]'s got, clenching you as your gushing [vagina] deliriously spatters fluids across your entwined bodies.  Lost in rut now, [benoit name] licks your face with [benoit eir] long tongue, the soft, sticky pressure against your reddened cheeks only seeming to make the contrasting sensation of [benoit eir] long prick taking you deep even more overwhelming.");
		if (!recalling) player.cuntChange(14,true,true,false);

		outputText("\n\nYou cannot stop yourself from screaming as your orgasm hits, your pussy clenching and wringing [benoit name]'s smooth dick as [benoit ey] continues to slam himself into you until [benoit ey] can take your milking no longer and cums in sympathy, clutching you as [benoit ey] fountains thick, warm cum into your fertile depths.  Having your lower body held in place like this makes your orgasm all the more overpowering; you wriggle futilely against the basilisk's strong legs, unable to thrash away the unbearable pleasure.");

		outputText("\n\nAfter minutes of being locked in orgasm together, you finally ride the last of it out.  You stay entwined for the moment, your hands roaming over each other as you enjoy the afterglow.");

		outputText("\n\n\"<i>Do you sink it will really work?</i>\" says [benoit name] eventually, [benoit eir] voice so low it is barely above a murmur.  \"<i>What if I can only give you males?</i>\"  The thought has already occurred to you, but right now you are feeling in a playful mood.  [benoit Eir] dick is still inside you and has barely softened, despite the volume of cum it is plugging into you; grinning, you push into [benoit eir] chest and slide your legs over [benoit em] until you are on top of [benoit em].  You very slowly work your hips in a circular motion, back and forth, deliberately working the cock wedged inside of you until it starts to inexorably harden again; [benoit name] closes [benoit eir] eyes and grunts as you abuse [benoit eir] aching sex.  Not willing to let [benoit em] simply sit back and take it, you slide your grip around [benoit eir] wrists and silently place them on your [nipples].  [benoit Ey] dumbly gets to work, gingerly moving [benoit eir] hands, [benoit eir] fingers pressing deep into your flesh.  As [benoit ey] brushes and squeezes you softly tell [benoit em] that whether or not you are able to give birth to female basilisks, [benoit ey]'s the father to your children now, and that mommy needs - you thrust your hips as far as you can, bending [benoit eir] dick backwards to make your point - service.  Lots and lots of service.  Driven by your words and your merciless sex, [benoit name] closes [benoit eir] eyes, squeezes your nipples between [benoit eir] fingers and helplessly orgasms a second time, spurting one or two more gobs of cum into you before [benoit eir] cock flexes fruitlessly against your sopping walls.");

		outputText("\n\nHaving milked your stud entirely dry, you dismount, clean yourself up and get dressed.  Before you can leave, [benoit name] feels around and pulls you into a tight hug.");

		outputText("\n\n\"<i>Bring ze eggs 'ere,</i>\" [benoit ey] says huskily.  \"<i>'Owever zey turn out, I would be honored to raise ze shildren of such a woman as you.</i>\"  You give [benoit em] a playful punch and say [benoit ey] may regret those words when [benoit ey]'s got a dozen tiny, scaly yous tearing up [benoit eir] shop.  You part and take your leave, [benoit eir] hoarse, slightly scared laughter in your ears.");
	}
	else {
		outputText("You haul your lizard boy into the cramped space of the backroom before gently setting [benoit em] down.  Now that your gut has settled, you feel imbued with an odd, ripe sensation; your horse belly bulges ever so slightly with unfertilized eggs and you feel red, soft and ready.  You begin to shrug your clothes off eagerly; having recovered himself slightly [benoit name] shrugs out of [benoit eir] trousers, reaching out to you before stopping, blushing furiously.  Grinning kindly at the emasculated basilisk, you lower yourself onto the floor, flare your [hips] casually and then ask if [benoit ey] see... smells anything interesting.");
		outputText("\n\nThe basilisk needs no further invitation.  In a moment [benoit ey] is upon you, [benoit eir] tight, muscled chest is pressed against your [ass], [benoit eir] hands moving over your own fertile belly and the head of [benoit eir] dick pushed against your moist [vagina].");
		//[Herm:
		if(player.hasCock()) outputText("  [benoit Ey] deliberately moves [benoit eir] hand over [oneCock] before trapping it in [benoit eir] warm grasp.   It quickly hardens against [benoit eir] warm, smooth friction.");
		outputText("  Used to your body now despite [benoit eir] blindness, [benoit ey] slides straight into your moist depths, making you coo as [benoit eir] hard, smooth spur glides across your sensitive walls, slowly bringing himself out before thrusting himself in again, working more and more of [benoit eir] long length into you.   Never quite able to control himself around your body, it's obvious in the strain of the muscles pressed against you and the raggedness of [benoit eir] breath upon your skin that [benoit ey] is exercising every restraint [benoit ey] has not to fuck you into the ground; [benoit ey] pushes [benoit eir] dick downwards with each return thrust to bump deliberately against your [clit], sending irresistible spasms of pleasure chiming through you.  You slowly move forwards until your arms are braced against the wall, before gritting over your shoulder to [benoit em] to stop holding back.  [benoit name] pauses for a moment to gather [benoit eir] breath, hilted entirely in your wet cunt, then hooks [benoit eir] strong arms around your back end, entrapping you around [benoit eir] body, before beginning to fuck your softened, ripe body like a jackhammer.  [benoit Ey] pounds into you with everything [benoit ey]'s got, clenching you as your gushing [vagina] deliriously spatters fluids across your entwined bodies.");
		if (!recalling) player.cuntChange(14,true,true,false);

		outputText("\n\nYou cannot stop yourself from screaming as your orgasm hits, your pussy clenching and wringing [benoit name]'s smooth dick as [benoit ey] continues to slam himself into you until [benoit ey] cannot take your milking any longer and cums in sympathy, clutching you as [benoit ey] fountains thick, warm cum into your fertile depths.  Having your lower body held in place like this makes your orgasm all the more overpowering; you wriggle futilely against the basilisk's strong legs, unable to thrash away the unbearable pleasure.");

		outputText("\n\nAfter what seems like hours of being locked in orgasm together, you finally ride the last of it out.  You stay entwined for the moment, your hands roaming over each other as you enjoy the afterglow.");

		outputText("\n\n\"Do you sink it will really work?\" says [benoit name] eventually, [benoit eir] voice so low it is barely above a murmur. \"What if I can only give you males?\"  The thought has already occurred to you, but you are feeling in a playful mood.  [benoit Eir] dick is still inside you and has barely softened, despite the volume of cum it is plugging into you; grinning, you push backwards, sitting yourself down so that [benoit ey] is trapped under your bestial weight.  You look over your shoulder and lock eyes with [benoit em] as you very slowly work your powerful hips in a circular motion, back and forth, deliberately working the cock wedged inside of you until it starts to inexorably harden again; [benoit name] closes [benoit eir] eyes and grunts as you abuse [benoit eir] aching sex.  You softly tell [benoit em] as you wring [benoit em] that whether or not you are able to give birth to female basilisks, [benoit ey]'s the father to your children now and that mommy needs- you thrust your hips as far forwards as you can, bending [benoit eir] dick backwards to make your point - service.  Lots and lots of service.  Driven by your words and your merciless sex, [benoit name] closes [benoit eir] eyes, clutches your flanks and helplessly orgasms a second time, spurting one or two more gobs of cum into you before [benoit eir] cock flexes fruitlessly against your sopping walls.");

		outputText("\n\nHaving milked your stud entirely dry, you get to your hooves, clean yourself up and get dressed.  Before you can leave, [benoit name] feels around and pulls your upper half into a tight hug.");

		outputText("\n\n\"Bring ze eggs ere,\" [benoit ey] says huskily.  \"Owever zey turn out, I would be honored to raise ze shildren of such a woman as you.\"  You give [benoit em] a playful punch and say [benoit ey] may regret those words when [benoit ey]'s got a dozen tiny scaly yous tearing up [benoit eir] shop.  You part and take your leave, [benoit eir] hoarse, slightly scared laughter in your ears.");
	}
	if (!recalling) {
		flags[kFLAGS.BENOIT_TESTED_BASILISK_WOMB] = 1;
		benoitKnocksUpPCCheck();
		//(Oviposition perk added)
		player.createPerk(PerkLib.BasiliskWomb, 0, 0, 0, 0);
		outputText("\n\n(<b>Perk Unlocked: Basilisk Womb - You can now give birth to female basilisks.</b>)");
		if (!(player.hasPerk(PerkLib.Oviposition))) {
			player.createPerk(PerkLib.Oviposition, 0, 0, 0, 0);
			outputText("\n(<b>Perk Unlocked: Oviposition - You will now regularly lay unfertilized eggs.</b>)");
		}
		if (player.pregnancyType == PregnancyStore.PREGNANCY_BASILISK) player.knockUpForce(PregnancyStore.PREGNANCY_BENOIT, player.pregnancyIncubation);
		if (player.pregnancy2Type == PregnancyStore.PREGNANCY_BASILISK) player.knockUpForce(PregnancyStore.PREGNANCY_BENOIT, player.pregnancy2Incubation, 1);
		player.sexReward("cum", "Vaginal");
		doNext(camp.returnToCampUseOneHour);
		dynStats("sen", -2);
	}
	else doNext(recallWakeUp);
}

//PC laying
//happens only at night, after all other night events
//PC lays 2 eggs per 10 points of Fertility they have
public function popOutBenoitEggs():void {
	if(player.vaginas.length == 0) {
		outputText("\nYou feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  <b>You look down and behold a new vagina</b>.\n");
		player.createVagina();
	}
	outputText("\nA sudden pressure in your belly rouses you, making you moan softly in pain as you feel your womb rippling and squeezing, the walls contracting around the ripe eggs inside you.  You drag yourself from your bedding, divesting yourself of your lower clothes and staggering out into the middle of the camp.  Squatting upright, you inhale deeply and start to concentrate.");

	outputText("\n\nA thick, green slime begins to flow from your stretched netherlips, splatting wetly onto the ground below you and quickly soaking into the dry earth.  You settle easily into the rhythm of pushing with your contractions and breathing deeply when they ebb.  The eggs inside you move quickly, lubricated by the strange slime that cushioned them in your womb; sized and shaped just right, the pressure of their passage stretches you in the most delightful way, your [clit] growing erect ");
	if(player.hasCock()) outputText("and [eachCock] starting to leak pre-cum ");
	outputText("as you find yourself being moved to climax by the birthing.  You see no point in resisting and reach down to begin fiddling with yourself, moaning in pain-spiked pleasure as the stimulus overwhelms you.  With an orgasmic cry, you release your eggs into the world amidst a gush of femcum");
	if(player.hasCock()) outputText(" and a downpour of semen");
	outputText(".");

	outputText("\n\nWhen you find yourself able to stand, you examine what it is you have birthed: " + num2Text(Math.floor(player.totalFertility() / 10)) + " large, jade-colored eggs, the unmistakable shape of reptile eggs.  You pick one up and hold it gently against your ear; inside, you can hear a little heart, beating strong and quick; [benoit name]'s child and yours.  You place the egg back down and gather them all up, moving them closer to the campfire to warm while you recover from your exertions.");

	outputText("\n\nWhen the light of day breaks, you gather your newly laid clutch and set off for [benoit name]'s shop.  The blind basilisk is asleep when you arrive, forcing you to bang loudly on [benoit eir] door to wake [benoit em] up.");

	outputText("\n\n\"<i>What is it?!</i>\" [benoit ey] snarls, displaying [benoit eir] fangs when [benoit ey] pops [benoit eir] head irritably out of the door.  [benoit Ey] stops and inhales through [benoit eir] nose, starting lightly when [benoit ey] recognizes your scent.  \"<i>Oops!  [name], I am zo sorry, I did not think it would be you.  But why are you here at such an early hour?</i>\"");

	outputText("\n\nYou smile at your blind lover and tell [benoit em] that [benoit ey]'s a father");
	if(flags[kFLAGS.BENOIT_EGGS] > 0) outputText(" once more");
	outputText(".  Well, [benoit ey] will be when this ");
	if(flags[kFLAGS.BENOIT_EGGS] > 0) outputText("latest ");
	outputText("clutch hatches, anyway.");

	//First Time:
	if(flags[kFLAGS.BENOIT_EGGS] == 0) {
		outputText("\n\nHe beams with joy, then looks confused.  \"<i>But... why have you brought zem 'ere?</i>\" [benoit ey] questions.");

		outputText("\n\nYou explain that you don't feel your camp is safe enough to keep them there, and [benoit name] nods.  \"<i>Yes, I can see your point... come, give zem 'ere, and I shall look after them for ze both of us.</i>\"");

		outputText("\n\nHe opens the door and offers [benoit eir] hand to help lead you in.  [benoit Ey] feels around the clutter of [benoit eir] store room until [benoit ey] finds what [benoit ey]'s looking for: a battered old basket stuffed with a soft pillow.  You raise an eyebrow at the liberal amounts of dog hair the pillow is covered with and [benoit name] coughs apologetically.");

		outputText("\n\n\"<i>'E isn't 'appy about me taking 'is bed, but to 'ell wizzim; 'e always gets is 'air on everysing anyway.</i>\"  You spend some time arranging the eggs where they will be safe and warm.  Although you know they can't be, [benoit name]'s blind eyes seem to be fixed upon the brood when you have finished.");

		outputText("\n\n\"<i>And zese eggs are different?</i>\" [benoit ey] says hesitantly. \"<i>I - we will 'ave... daughters?</i>\"  You shrug and say even if they aren't female, at least [benoit ey]'ll have some sons [benoit ey] can keep away from the mountain.  [benoit Ey] sets [benoit eir] jaw and nods.");

		outputText("\n\n\"<i>If zis works, [name], you 'ave done my people a service I cannot repay.  Even if it doesn't, to do zis for me is...</i>\" [benoit ey] gestures futilely as words fail [benoit em].  \"<i>All zis time I 'ave been trading potions, I could 'ave done it myself, and I never did.  Per'aps I sought I was too much a man or somesing.  Pah!  I was a coward, a cringing coward.  You 'ad ze idea, you 'ad ze courage, you 'ad ze strength, and because of zat, my people 'ave a chance.  Sank you.</i>\"  [benoit Ey] sounds slightly choked, and stops for a moment.  \"<i>It is very, very little, but for you I buy and sell sings at zeir true value.  If zeir is anysing I can do for you, ever, please just say.</i>\"  You are slightly embarrassed by [benoit eir] effusiveness and mumble something.  Perhaps aware of the awkwardness, [benoit name] gestures to the corner where [benoit ey] has put together a serviceable stove from scrap.\n\n\"<i>'Ungry?</i>\"");
		outputText("\n\nYou linger long enough to share breakfast with [benoit em], and then return to camp.");
	}
	//Subsequent:
	else {
		outputText("\n\nBenoit smiles proudly.  \"<i>I cannot zank you enough for zis.  Do not worry, I shall keep zem as safe as I ave ze ozzeir clutches.</i>\"\n");
	}
	player.orgasm();
	flags[kFLAGS.BENOIT_EGGS] += Math.floor(player.totalFertility() / 10);
	//doNext(1);
}

//Feminising

//Opening Talk
//Requires: Affection 40+, Have already talked to Benoit at least once, have not had sex with Benoit
public function femoitInitialTalk():void
{
	clearOutput();
	talkCount();

	outputText("You ask [benoit name] if [benoit ey] has ever thought about trying to do something to help [benoit eir] people's plight.");

	outputText("\n\nThe basilisk is silent for a time, running [benoit eir] claws along the counter pensively.  \"<i>Yes,</i>\" [benoit ey] says eventually, in a quiet tone.  \"<i>I 'ave.  Away from ze mountains, I 'ave 'ad time to sink.  I am not ze demons' slave anymore, and I am a funny joke of a basilisk anyway, so I 'ave often thought about making certain... zacrifices.  If we 'ad just one female, away from zeir corruption, zen...</i>\" [benoit ey] tails off, shrugging unhappily.  \"<i>But I just torment myself sinking about zis, [name].  Ze demons made us very resistant to change.  I would need somesing very powerful for me to become... somesing useful.</i>\"");

	if (player.inte >= 60)
	{
		outputText("\n\nYou reckon that even a resistant creature could be made to transform to the opposite sex, with a strong enough potion, and ask [benoit name] about it.");

		outputText("\n\n\"<i>Well... if you got a double dose of purified zuccubus milk, a large pink egg, zome ovi-elixir and some reptilum, you could probably do it...</i>\"");

		outputText("\n\n(\"<b>Feminize</b>\" option added to [benoit name]'s menu.)");

		flags[kFLAGS.FEMOIT_UNLOCKED] = 1;
	}
	else
	{
		outputText("\n\nYou rack your brain but can't think of anything that could help [benoit name], so end up simply sympathising with [benoit em].  \"<i>Do not beat yourself up over it,</i>\" says the basilisk, with a smile.  \"<i>It is a foolish dream.  And anyway, I told you: we are a race of bastards.  We are ze last guys who deserve someone sinking after us.</i>\"");
	}
	doNext(camp.returnToCampUseOneHour);
}

// Feminise

public function benoitFeminise():void
{
	clearOutput();

	// Ingredients not in inventory
	if (!player.hasItem(consumables.P_S_MLK, 2) || !player.hasItem(consumables.L_PNKEG) || !player.hasItem(consumables.OVIELIX) || !player.hasItem(consumables.REPTLUM))
	{
		outputText("You don't have the necessary ingredients to attempt this yet.");
		outputText("\n\n<b>(Requires 2x Purified Succubus Milk, 1x Large Pink Egg, 1x Ovi Elixir, 1x Reptilium.)</b>");
        CoC.instance.flushOutputTextToGUI();
    }
	else
	{
		player.destroyItems(consumables.P_S_MLK, 2);
		player.destroyItems(consumables.L_PNKEG, 1);
		player.destroyItems(consumables.OVIELIX, 1);
		player.destroyItems(consumables.REPTLUM, 1);

		outputText("You ferret out the ingredients you have collected and begin to bang them onto the counter in front of [benoit name], telling [benoit em] that you've got what [benoit ey] needs.  Pierre barks excitedly at the noise.");

		outputText("\n\n\"<i>I - what?</i>\" the basilisk says, bewildered.  \"<i>But... [name], zat was just fantasy!  I was not expecting you to...</i>\"  [benoit Ey] lapses into silence as you grab a pewter bowl from a nearby shelf and a wooden spoon from a container full of old utensils, and begin to mix the various ingredients together.  You crack the egg against the bowl and then beat it into the milk; the goop takes on a pink cake-mix texture until you pour in the ovi-elixir, which thins it as well as filling the close market stall with a rather bad, sulfuric smell.  Carefully you drip in the reptilum whilst continuing to stir; eventually the liquid in front of you takes on a livid lime color.  When the scent changes to that of cooking sherry you stop and step back to admire your handiwork, before pushing the bowl gently across the counter until it touches the basilisk's claws.  [benoit Ey] slowly clasps [benoit eir] fingers around it, staring blindly into the concoction.");

		outputText("\n\n\"<i>And you sink zis will actually work?</i>\" [benoit ey] says eventually.  \"<i>Zat it will... change me?</i>\" You honestly have no idea - and you're quite glad [benoit name] can't see the color of it - but you tell [benoit em] as confidently as you can that it will.  [benoit Ey] sighs raggedly, [benoit eir] claws trembling slightly.  \"<i>Oh well, what is the worst that it could do - make me deaf?</i>\"  A look of horror settles on [benoit eir] face as the words leave [benoit eir] mouth, but [benoit ey] manages to shake the thought away and lifts the bowl to [benoit eir] lips.  \"<i>Sante,</i>\" [benoit ey] manages with a small smile, and then drinks.");

		outputText("\n\nYou watch as the potion slides into [benoit eir] mouth and down [benoit eir] gullet.  When it is all gone [benoit ey] sets the bowl down and licks [benoit eir] lips thoughtfully.");

		outputText("\n\n\"<i>Well... not ze worst sing I have ever tasted,</i>\" [benoit ey] says. \"<i>It could 'ave used more alcoh-hol zo.  Uh.  Uhhhhhhh...</i>\"  [benoit Ey] clenches the desk as a tremendous gurgling sound emanates from [benoit eir] gut.  Pierre whines, and unconsciously both you and the dog back away from the basilisk as [benoit ey] begins to twitch and spasm.  There is a grinding noise as [benoit eir] bones begin to shift; although [benoit ey] is holding onto the counter as hard as [benoit ey] can, [benoit ey] cannot stop knocking bottles and trinkets onto the floor as [benoit eir] flesh begins to move.  [benoit Eir] torso sucks in, a great deal of mass moving downwards; the sound of long johns giving at the seams trades with an unpleasant cracking and popping sound as [benoit eir] shoulders shift inwards.  There is a sprouting sound as iridescent red feathers emerge upon [benoit eir] crown; below [benoit eir] clenched teeth and eyes, [benoit eir] jaw line softens and moves upwards.  The basilisk's now slighter front bulges faintly, and with that the transformation stops, or at least the transformation you can readily observe.  Judging by the way [benoit eir] gut continues to groan and the way [benoit ey] continues to clutch the wooden surface hard enough to leave yet more claw marks, something fairly significant is happening in the ruins of [benoit name]'s long johns.");

		outputText("\n\n\"<i>Zut.  Fucking.  Alors,</i>\" the basilisk manages at last.  The creature's voice has gone up by several octaves; although it is still deep, it now sounds rather... husky.  \"<i>Zat was almost as bad as zat time I tried goblin food.  Is... is zat me?</i>\" [benoit name] puts a claw to [benoit eir]... no, her throat in a panic.  Her hands then roam downwards and upwards, each new protuberance and crevice discovered amplifying her disquiet.  \"<i>Zis... zis can't be real,</i>\" she mutters.  \"<i>Zis can't actually 'ave 'appened...</i>\"  She turns as if to try and shake herself out of a dream, and knocks over a pile of books with her behind.  Your one salient thought as you watch is that whatever else you've managed to do to the blind basilisk, she certainly has it going on now.  She stands in the fairly impressive mess the two of you have created wringing her hands, apparently unwilling to move her new physique around for fear of knocking over even more of the stock.");

		outputText("\n\n\"<i>C... could you come back tomorrow?</i>\" says [benoit name] unevenly.  \"<i>Zis is... I need some time to get my 'ead around zis.</i>\"  You put the books back on the counter, scratch a terrified-looking Pierre behind the ear, and take your leave.");

		flags[kFLAGS.FEMOIT_NEXTDAY_EVENT] = CoC.instance.model.time.days + 1;
        flags[kFLAGS.FEMOIT_NEXTDAY_EVENT_DONE] = 1;
		doNext(camp.returnToCampUseOneHour);
	}
}

public function femoitNextDayEvent():void
{
	clearOutput();

	flags[kFLAGS.BENOIT_STATUS] = 1;
	flags[kFLAGS.FEMOIT_NEXTDAY_EVENT_DONE] = 2;

	outputText("A strange, faint sound is emanating from the salvage shop.  It's only when you duck cautiously into the stall proper that you realize it's the sound of a basilisk humming.  [benoit name] stops to sniff the air when you come in, immediately puts down the mug she is polishing, and beckons you inside.");

	outputText("\n\n\"<i>[name]!</i>\" she says brightly.  \"<i>Do not be standing around zere!  Come in, I want to talk to you.</i>\"  You work your way to the counter and take her in.  She is wearing a beret instead of a fez, and an apron over her front, which combine to more or less disguise her new feathers and small, ornamental chest bumps.  However it is easy, or at least it is to you, to notice in the basilisk's jaw-line and considerable new hips and butt that her gender has definitely changed... you can only assume that her sex has as well, concealed under that apron.  She doesn't seem to mind you checking her out, or maybe she just doesn't realize.  You ask how Ben- you stop.");

	outputText("\n\n\"<i>You can call me Benoite.  Ben - oy,</i>\" she says, smiling.  \"<i>Zat is easy to adapt to, yes?  And I am fine.  Better zan fine; your potion worked perfectly.  I feel like I 'ave a new life now - before I was a sad excuse of a basilisk, going nowhere.  Now I 'ave a purpose.  A raison d'etre.  Also, being female 'as made me realize 'ow badly zis place needs a clean.  I get more customers now!</i>\"");

	outputText("\n\nShe leans across the counter, her smile fading.  \"<i> Seriously, [name], you 'ave done my people a service I cannot repay.  I can lay eggs, zere can be more female basilisks, away from Lethice and 'er thugs.  All zis time I 'ave been trading potions, I could 'ave done it myself, and I never did.  Per'aps I sought I was too much a man or somesing.  Pah!  I was a coward, a cringing coward.  You forced me to decide, and because of zat, my people 'ave a chance.  Sank you. </i>\"");

	outputText("\n\nShe sounds slightly choked, and stops for a moment. \"<i> It is very, very little, but for you I buy and sell sings at zeir true value.  If zere is anysing I can do for you, ever, please just say. </i >\"  You are slightly embarrassed by her effusiveness and mumble something along the lines of it being all her doing.  Perhaps aware of this, Benoite sits back down, hatches her fingers and smiles at you primly.  \"<i> Now... is " + player.mf("sir", "madam") + " buying or selling? </i>\" ");

	//[Benoite buys at same rate Oswald does and sells at a 33% discount]
}

//Benoite Interactions

public function femoitFirstTimeNo():void
{
	clearOutput();
	outputText("You let her down as kindly as you can.");
	outputText("\n\n\"<i>No, you are right,</i>\" she says in a casual tone, although the color is still very high in her scales. \"<i>It would be way too weird zat, wouldn’t it? I will find someone though, never fear.  As I said before...</i>\" Benoite points two fingers at her blind eyes and then at the stall entrance.  There’s a distinct gleam in those cloudy grey depths you think would scare the hell out of most things with a penis. \"<i>I ‘ave a purpose now.</i>\"");
	outputText("\n\nCatching a subtle tone of dissapointment in Benoite's voice, you bid her a quick farewell and head back to camp, deciding to give her some time to recover.");
	doNext(camp.returnToCampUseOneHour);
}

public function femoitFirstTimeYes():void
{
	if (!recalling) flags[kFLAGS.TIMES_FUCKED_FEMOIT]++;

	clearOutput();
	outputText("Smiling, you reach across the counter and squeeze Benoite's hands until her nervous babble dies out and she smiles back.  Still holding her hand, you move behind the crates and then gently lead her behind the stall's canopy.");

	outputText("\n\nWhat passes for Benoite's back office is perfect for your purposes; the two wagons between which her stall is sandwiched close together here and the triangular space is filled with crates and unsorted salvage.  You carefully inch your blind charge to a clear cranny and push her against a wooden wall, leaning into her as you gently undo her apron.  The excited bustle, thump and clatter of the carnival sounds like it's coming from a million miles away.");

	outputText("\n\n\"<i>Zis is so weird,</i>\" she mumbles as you drop the garment onto the packed dirt and slowly move your hands up her smooth body to take her beret; you can't imagine what's going through her head, but looking into Benoite's snub lizard face and cloudy grey eyes, you can only agree with the sentiment.  Still... your eyes are drawn to her softer jaw line, her swollen chest and her bright feathers.  The fact that you did this to her, literally emasculated her and that she now wants you to take her, touches something deep and you eagerly begin to peel off your [armor], blood rushing to your groin. ");

	outputText("\n\n\"<i>Zis will sound strange,</i>\" says Benoite in a shivery voice, as you eventually stand before her naked, \"<i>But... would you mind if I just touched you a bit first?  All I know about you is ze sound of your voice.</i>\"  You acquiesce and draw close, sighing as she gently lays her hands upon you, holding her index claws back as she begins to move them slowly up and down.");

	if (player.isTaur()) outputText("\n\nHer warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  \"<i>Good Gods,</i>\" she murmurs as her hands lead back onto your flanks.  \"<i>Good Gods!</i>\" she cries out as she follows you all the way back to your mighty, powerful rear.  \"<i>I knew you were a centaur because of all ze clopping,</i>\" she says, rubbing your side back and forth in wonder.  \"<i>But to know it and actually feel it, zey are very different.</i>\"  She sighs.  \"<i>Zis is going to be... awkward, but I guess you are probably used to zat by now, yes?</i>\"");
	else if (player.isDrider()) outputText("\n\nHer warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  \"<i>Good Gods,</i>\" she murmurs as her hands lead back onto your abdomen. \"<i>Good Gods!</i>\" she cries out as she follows your bulging abdomen all the way back to your spinnerets. \"<i>I knew you were a spider because of all ze click clacking,</i>\" she says, her fingers feeling around one of your intricate, many-jointed legs in wonder . \"<i>But to know it and actually feel it, zey are very different.</i>\"");
	else if (player.isRace(Races.DEMON, 1, false)||player.isRace(Races.IMP, 1, false)) outputText("\n\nHer warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  She touches your horns and pauses; she reaches around, finds and grips your tail, running her grasp up to the spaded point. \"<i>So,</i>\" she says quietly. \"<i>You are one of zem.</i>\" She is silent for a while before finding a warm smile. \"<i>But I am being zilly.  I know you are different inside.</i>\"");
	else if (player.isRace(Races.DOG, 1, false) && player.ears.type == 2 && player.tailType == 2) outputText("\n\nHer warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  She grins as she finds your floppy ears and outright laughs when she reaches around and touches your tail.  \"<i>I like dogs but not ZAT much, \"<i>[name],</i>\" she giggles.  \"<i>No wonder Pierre 'as been acting jealous recently.</i>\"");
	else if ((player.racialScore(Races.BUNNY, false) >= 4 && player.ears.type == 7 && player.tailType == 10) || (player.racialScore(Races.CAT, false) >= 4 && player.ears.type == 5 && player.tailType == 8)) outputText("\n\nHer warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  She grins as she finds your ears, outright laughs when she reaches around and touches your soft tail.  \"<i>I always wondered why Pierre gets all excited when 'e sees you,</i>\" she giggles.");
	else if (player.isRace(Races.HARPY, 1, false) && player.wings.type != 0 && player.arms.type == 1) outputText("\n\nHer warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  She finds your wings and follows them up as far as she can reach; she carefully shifts her feet forward to touch at your own clawed toes.  \"<i>So zis is what irony is,</i>\" she murmurs, a smile playing on her lips as she touches your shoulder.  \"<i>My saviour is an 'arpy, come to ravish me.</i>\"");
	else if (player.isRace(Races.BEE, 1, false) && player.wings.type != 0 && player.lowerBody == 7) outputText("\n\nHer warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  She finds your diaphanous wings and follows them up as far as she can reach, her grip on your sensitive membranes making you twitch a bit; then she sends her hands trailing down your carapace-armored limbs. \"<i>I always sought you just liked wearing big boots,</i>\" she murmurs. \"<i>But zis is actually a part of you?  'Ow... interesting.</i>\"");
	else if (player.racialScore(Races.SLIME, false) >= 4 && player.isGooSkin()) outputText("\n\nHer warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  \"<i>I knew you were different from ze squishy sounds you made,</i>\" she murmurs as her hands sink into your soft, amorphous mass.  \"<i>But zis is... good Gods, zis is strange.  And zis doesn't 'urt you at all?</i>\" she asks incredulously as she gently pokes a finger into you.  You answer her question by laughing.  \"<i>Zat must come in very useful,</i>\" she says.  You push yourself slowly up her arms and tell her she has no idea.");
	else if (player.isScaleCovered()) outputText("\n\nHer warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  She starts slightly when she touches your scales, and then caresses the reptilian parts of your body with increasing interest.  \"<i>You didn't do zis just for me, did you [name]?</i>\" she murmurs.  \"<i>I 'ave to admit - it feels very good.</i>\"");
	else outputText("\n\nHer warm fingers travel over your body, brushing over your face, your belly, your [hips]; you feel as though you're being read like a book.  \"<i>You 'umans are so squishy, fuzzy and 'ot,</i>\" she giggles huskily. \"<i>'Ow can you stand it?</i>\"");

	outputText("\n\nBenoite's hands travel down your torso until, with a sharp intake of breath, she touches your [cock].  After a pause, she slowly wraps her dry, smooth grasp around your semi-erect cock and moves it up and down, rubbing and coiling you until you are straining.");
	if (player.biggestCockLength() <= 10) outputText("  Although this is evidently an uncanny experience for her, she does manage a cocky smile as her hand moves around your sex.  \"<i>Mine was bigger,</i>\" she teases.  You reward her cheek by doing some feeling yourself, grasping her large, supple behind, making her squeak as you move into her.");
	else outputText("  This is evidently an uncanny experience for her, the alien nature of it deepening as her hands moves around your sex. \"<i>'Oly Gods, [name]; you are a monster,</i>\" she says thickly.  You smile and decide it's time to do some feeling yourself; you grasp her large, supple behind, making her squeak as you move into her.");

	outputText("\n\nThe scent of your arousal is in the air and as Benoite inhales it in her own breath comes heavier.  Still grasping her butt, you spread her hips to reveal her genital slit, gleaming with wetness.  Bracing her against the wall, you press your [cock] against her ready sex.  \"<i>Please be gentle,</i>\" says a husky, nervous voice below you.  You respond by slowly pushing open her lips and sliding your head into her warmth.");

	outputText("Benoite's pussy is virginally tight and you go as slowly as you can, lightly moving your hips as you work more of your length in.  Sharp claws grasp your back as you feel resistance that gives as you push more of yourself in; blood trickles down your shaft to drip onto the floor.  You keep working her slowly, withdrawing almost completely before sinking yourself in, using your head on the outward pull to tease at the clit hidden in her folds.  Benoite seems almost frozen by what's happening; she simply clutches at your back, breathing heavily and allowing you to do all the work.  You don't mind; whatever her mind is thinking her body is responding to your methodical treatment, her lips widening and slick moisture oiling your dick as you press into that tight, graspingly tight tunnel.");
	if (player.biggestCockLength() < 15 && player.balls == 0) outputText("  Eventually you manage to hilt yourself entirely in her depths, your stomach pressing against her own tight belly.");
	else if (player.biggestCockLength() < 15 && player.hasBalls()) outputText("  Eventually you manage to hilt yourself in her depths, your [balls] pressing into her sex as your stomach bumps into her own tight belly.");
	else if (player.biggestCockLength() >= 15 && player.balls == 0) outputText("  Eventually you manage to bottom out, your dick pressed against her cervix.");
	else if (player.biggestCockLength() >= 15 && player.hasBalls()) outputText("  Eventually you manage to bottom out, your dick pressed against her cervix, your [balls] swinging heavily below your shaft.");
	outputText("  Staying like that for a moment, you slowly withdraw almost all of the way out before pushing all the way in again, continuing the process, your grunts melding with Benoite's soft moans at the almost-agonizingly slow sex, exercising all the self-restraint you have not to begin pounding away at the basilisk's deliciously tight cunt.  Occasionally you pause at the deepest moment, waiting for your blood to cool down and letting Benoite get used to the sensation of being fully stuffed by you.");

	outputText("\n\nSlowly, eventually, Benoite gets into it, her frozen limbs thawing to your loving, careful movement.  Beginning to pant, she moves her powerful hips with you, trying to draw your dick further into her.  Gratefully you begin to pick up the pace, thrusting into her with increasing force.  Her claws grip your back painfully as she pushes herself into you, the soft leather of her chest bumps squeezing into your [fullChest].");
	if (player.isLactating()) outputText(" The pressure and arousal makes your [nipples] dribble milk, spattering fluids across both of your chests.");
	outputText("  Soon the two of you are thrashing into each other, Benoite moaning huskily as you batter her against the wagon wall, both seeking your peak together, each pushing the other a bit further upwards.  Your world is lost to everything but the warm tightness around your [cock] and the pressure against your chest.");

	outputText("\n\nBenoite howls as she orgasms, clutching you for dear life as she pushes as much of herself into you as she can.  The contractions around your cock are too much and with a bestial, wordless sound, you cum.  Your mind superseded by everything but that all-conquering animal imperative to breed, you hilt as much of yourself in Benoite, pushing as much of your seed upwards as you can, delivering rope after rope of cum until it dribbles out of her, dripping onto the floor to mingle with her blood.");

	outputText("\n\nEventually you pulse your last drop and return to yourself; slowly you lower Benoite to her feet.  She staggers slightly and clutches a stack of crates for support, your cum still beading out of her.");

	outputText("\n\n\"<i>Phew!</i>\" she says after she's managed to catch her breath.  \"<i>That was... somesing.</i>\" You're slightly worried you went a bit too far with her, but when she has recovered herself a bit she advances on you with a wide, blissed-out grin.  She feels around until she finds your hands.  You suppose the done thing at this point is to kiss her, but you're not entirely sure how to do that.  As you hesitate, she opens her mouth, unrolls her long tongue and licks your face.  The sensation is warm and sticky and you find yourself laughing at the strange tenderness of the gesture. ");

	outputText("\n\n\"<i>Sank you for zat, [name],</i>\" she says huskily. \"<i>Of course, I will need you to do zat again if it doesn't take.  And again, once ze first clutch is done.  Basically we will be doing zis a lot.  Purely for ze purpose of procreation, you understand.</i>\"  Grinning, you lead her back inside the shop and after squeezing her hand, take your leave.");

	player.sexReward("vaginalFluids", "Dick");
	doNext(camp.returnToCampUseOneHour);
}

// Subsequent Sex
// Requires: Benoite not pregnant
public function femoitSexIntro():void
{
	clearOutput();
	outputText("Once again, you take Benoite's hand and lead her into the back room.  Your free hand roams underneath her apron as you carefully pick out a path through the junk and Benoite is swiftly in on the game too; her fingers slide downwards to pinch and fondle at her favorite parts of you.  By the time you make it into the storage space you are practically falling over each other, laughing as you fumble off each other's clothes.");

	if (!benoitPreggers())
	{
		outputText("\n\nBenoite's fingers travel down your sides as you lift her apron off her, her warm, smooth touch eventually falling upon your [cock]; already aware of every inch of you she rubs and coils you expertly, softly pumping you until your flesh is straining in her grasp. She circles a feather-light touch around your [cockHead] with one finger ever so gently, grinning slyly as she does.  Grunting with need, you push her insistently down onto the packed soil, shaking out of the last of your underclothes; Benoite spreads her thighs for you, her genital lips widened and moist with readiness.");
		if (benoitInClutch()) outputText("  Her stomach bulges with clutch and the air is thick with female musk; the sight and smell of overwhelming ripeness speaks to your body in a way which bypasses your higher cognition entirely, sending you growling on top her, barely even hearing her giggle.");

 		outputText("\n\nYou cup her large, supple behind and push into her wet opening, sighing as you reach a comfortable depth before slowly sliding in and out.  Benoite's hands move over you, reminding herself of you with dry, smooth pressure as you find a slow, silky rhythm.  The basilisk arches her back and moans hoarsely as you push more and more of your wick into her depths; she moves with you, wriggling her body to gently work your [cock] this way and that to enhance your sensation.");

		outputText("\n\n");
 		if (player.biggestCockLength() < 15) outputText("Soon you are hilting yourself in her depths, making her gasp as you slap into her.");
 		else outputText("Soon you are bottoming out in her, making her gasp as your hulking length spreads her wide.");
 		outputText("  You quickly pick up the pace as you enter rut, thrusting into your basilisk lover with red-flecked abandon, her powerful thighs working with yours to make each return plunge into her warm depths more gratifying than the last.");

		outputText("\n\n");
 		if (!player.isTaur())
		{
			outputText("Eventually, sweat dripping off you, you grab her thighs and heave them upwards so that you can really go to town, drawing yourself almost all the way out of her before smacking back into her,");
			if (!benoitInClutch()) outputText(" your stomach beating out a slapping rhythm against her own flat abdomen.  ");
			else outputText(" your stomach beating out a slapping rhythm against her bulging, gravid abdomen.  ");
		}
 		outputText("Benoite moans, squeals and eventually screams to your exertions, her fluids spurting and spattering against your groin");
 		if (player.hasBalls()) outputText(" and [balls].  You tumble over your peak as her cunt suddenly tightens around yours, sending surge after surge of cum into her fertile depths, your body seized in a rictus of pleasure.");
 		if (player.cumQ() >= 2500) outputText("  The quantity of it is such that it quickly dribbles back out around your cock and pools on the floor.");

		outputText("\n\nAfter you have both rode out the last of your mutual orgasm you lie for a time on the floor tangled together, enjoying the feeling of your smooth, scaly lover.");

		outputText("\n\n\"<i>Big, zilly stud,</i>\" she says fondly, as she moves her hands, painting a picture of you in this moment she can hold on the walls of her mind for days to come.  Eventually, you get up, redress and quietly take your leave.  In your haze you manage to feel glad that she didn't leave quite so many claw marks on your back this time.");

		player.sexReward("vaginalFluids", "Dick");
		if (sceneHunter.other) {
			benoitKnockUpSmart(camp.returnToCampUseOneHour); //select the clutch size
			return;
		}
		else benoitKnockUp();
	}
	else if (benoitRegularPreggers() && (!player.isTaur() || (player.isTaur() && (player.tallness * (5/6) < player.cocks[player.longestCock()].cockLength))))
	{
		clearOutput();
		outputText("Once you are both in the usual spot, neither of you waste any time undressing.  The pregnant basilisk stands there, staring blindly at you, and waiting for you to make the first move, tongue occasionally flicking past her lips to nervously wet them.");

		outputText("\n\nYou use this opportunity to examine your reptilian lover more closely, stepping forward and reaching out with your hands.  You gently trail your fingers across her jawline, then reach up and softly ruffle the feathery crest on her head, making her coo appreciatively.  Your fingers slide down the lines of her body to cup and stroke her small, rounded chest, and then inexorably continue onwards to the hard, round, swollen mass that is her egg-laden belly.  You place your palms flat against the distended orb, feeling the pressure that the sizable clutch is exerting on the interior of her womb, massaging her sides and making her moan softly; you'd almost swear you can hear her eggs softly clicking as you move them against each other.");

		outputText("\n\n\"<i>Enough foreplay; I sought zat we were going to fuck?</i>\" she playfully reprimands, and you smirk and nod your head, knowing guiltily that she can't see it.  Nimbly you skip around behind her, catching her tail and rubbing it affectionately against your cheek, then tell her to find something sturdy to support her; you want her to kneel down against it.");

		outputText("\n\n\"<i>So, zat is what you 'ave in mind?  Kinky " + player.mf("boy","girl") +"...</i>\" Benoite replies.  Her long tongue flickers out to dart across your other cheek, and then she carefully lowers herself to the ground, making herself comfortable and groaning softly with relief. \"<i>I must say, zat is much more better on my poor feet... all zese eggs are 'eavy, you know?</i>\"");

		outputText("\n\nYou cup her buttocks, squeezing the delightfully full, feminine globes, and promise her that she'll forget all about the weight of her eggs soon enough.");

		outputText("\n\n\"<i>Promises, promises,</i>\" is the cheeky retort you get, which prompts you to playfully slap her right asscheek with your hand.  Your [cock] is already begining to swell with arousal, and you tantalizingly brush it against the outer lips of Benoite's pussy, sliding it back and forth and occasionally bumping its tip into her swollen belly.  Soon, it's hard as a rock, and slick with both pre-cum and Benoite's feminine equivalent.  The genderbent reptilian moans and growls in the back of her throat, arching her magnificent ass towards you to make it easier for you to tantalise her, your hands instinctively moving to grope and squeeze her luscious cheeks.");

		outputText("\n\n\"<i>Enough with ze teasing, put ze damn thing in already!</i>\" she barks at you.  She lifts one hand off of the ground and begins to rub and squeeze her chest in frustrated pleasure.");

		outputText("\n\nDeciding you've had enough foreplay, you take a moment to properly position yourself and begin sliding gently into her cool, silky depths, trying to keep calm even as you work yourself deeper and deeper inside her.");
		if (player.biggestCockLength() < 15) outputText("  Soon you are hilting yourself in her depths, making her gasp as you slap into her.");
		else outputText("  Soon you are bottoming out in her, making her gasp as your hulking length spreads her wide.");

		outputText("\n\nYou take a momentary pause to properly reposition yourself, placing your hands on Benoite's butt for assistance in balancing and causing her to place her free hand back on the ground, and then you begin to thrust. She groans and gasps as you slide yourself back and forth inside her, doing her best to meet your thrusts with her own, egg-laden belly sliding back and forth across the floor, the stimulation on her stretched, sensitive scales adding to her pleasure, her tail beating a tattoo of lust against your back.");

		outputText("\n\n\"<i>Yez!  Yez, oh, yez!  This iz zo good, [name]!  Oh, fuck... I sink zat I am...</i>\"  You feel her rippling, squeezing pussy clenching tighter and tighter around you, striving to milk you dry.  \"<i>...I em c-c-cumming!</i>\" she cries out as climax ripples through her, belly jiggling against you as the pleasure makes her whole body quiver and shake.  She moans and growls throatily, then gives a gasp of relief, audibly spent...");

		outputText("\n\nBut you're not done yet, as enticing a display as that was, and so you continue to thrust, the juices from Benoite's orgasm making your cock wonderfully slick and easy to slide into her. Weak-kneed and overstimulated from her recent orgasm, the basilisk can only mewl and groan in equal parts pleasure and desperation.  She strives to massage and milk your cock with her wet cunt, aching to have you fill her with more of your potent seed.  The sight of her like this, her belly swollen with your fertilized clutch, down on her hands and knees and anxious to be bred anyway, is ultimately too much to resist and you find yourself exploding into the reptilian woman's snatch, triggering a second orgasm as your cum spurts inside her.");
		if (player.cumQ() >= 2500) outputText("  Because her womb is already so jam-packed with eggs, the bulk of your deposit simply oozes messily back out of her, leaving her well and truly creampied.");

		outputText("\n\nNow it is your turn to slump down in a spent state, though you retain enough control to avoid adding any more weight to your already heavy lover.  The two of you remain there in the backgroom, gathering up your strength, letting the musk of your carnal pleasure roll over your still forms.");

		outputText("\n\nBenoite stirs first.  \"<i>Mmm... I guess being so pregnant is not such a bad sing if it means we can have sex like zis...</i>\" she murmurs, though it's quite obvious she intends for you to hear her. With a groan of effort, she heaves herself back upright.  \"<i>Come back and see me any time, lover-"+ player.mf("boy","girl") +",</i>\" she tells you.  \"<i>But don't sink zat you need me to be pregnant to give me a good time, okay?</i>\"  Benoite smirks, striding across the floor and giving you a hand up before delicately flicking her tongue across your lips in a reptilian kiss.");

		outputText("\n\nYou redress yourself, give the trader a hand getting back to the front of the shop without knocking anything over - she may be familiar with her shop, but her distended belly still gives her problems - and then head back to camp.");
		player.sexReward("vaginalFluids", "Dick");
	}
	else if (benoitVeryHeavyPreggers() || benoitExtremePreggers())
	{
		clearOutput();
		if (player.isTaur())
		{
			outputText("\"<i>No.  Non!  Absolutely non!</i>\" Benoite insists.  \"<i>You are my amazing stallion, [name], but... it is simply too much.  Wis all zis weight on me, zere is simply no way we can do it.</i>\"");

			outputText("\n\nShe places a hand on you, working it up to your face cautiously until she's holding your cheek.  \"<i>Truly, I am sorry.  I am eager to see you again, my 'andsome 'orse... once our children are walking on their own feet.</i>\"");
		}
		else
		{
			if (flags[kFLAGS.FEMOIT_SPOONED] == 0)
			{
				flags[kFLAGS.FEMOIT_SPOONED]++;
				outputText("Benoite seems to peer at you, then places her clawed hand gently on her belly. \"<i>And I sought my eyes were the ones that didn't work... You can surely see how big I am, yes?  Do you really sink you could carry me for the sex?  Because there is no way I can let you sit on my lap with all zese eggs in me.</i>\"");

				outputText("\n\nYou assure her that you know a position that will work just fine, if she's willing to try.");

				outputText("\n\nThe egg-laden reptilian woman visibly thinks it over, then shrugs. \"<i>Well, I guess I'm willing to try if you are.</i>\"  She smirks softly.  \"<i>Drat zese 'ormonez; I am too 'orny for my own good.</i>\"");
			}
			else
			{
				outputText("Benoite smirks at you.  \"<i>Well, I guess ze last time was enjoyable enough.  Come, then; I am horny and you arrived in time to scratch my itch.</i>\"");
			}

			outputText("\n\nShe turns around slowly and waddles into the private part of her shop, tail waving over her admirable butt.");

			outputText("\n\nFortunately, Benoite sleeps in her shop these days, so you don't have to help her waddle far before she collapses gratefully into her bedding.  \"<i>Zut alors, I am such a 'og...</i>\" she murmurs, hands trying desperately to measure her huge belly.  While she is doing that, you slip out of your [armor] and then quietly climb into the bed beside her.");

			outputText("\n\nShe starts in shock as your arms wrap around her waist. \"<i>Do not sneak up on me like zat!</i>\" she complains, her tail slapping forcefully against your [ass] to emphasize her point. You apologize, but neither of you really mean what you're saying and you both know that.  You snuggle in close to your reptilian lover, pressing yourself against her back, feeling her cool scales against your [skinFurScales].  Your roving hands caress her chest, making her croon at the attention, and are then drawn magnetically to her impossibly pregnant stomach.");

			outputText("\n\nIt's huge and heavy, solid like a rock, the scaly skin stretched so taut over the eggs inside you're certain you can actually feel them through her skin. There are too many of them jam-packed in there to actually move, though, signaling just how remarkably gravid Benoite is.  Your examinations are cut off when Benoite suddenly grinds her ass insistently against your crotch. \"<i>Ze snuggling is nice, lovair, but I am in ze mood for somesing a leetle more... active,</i>\" the basilisk comments, her tone light and airy.");

			outputText("\n\nYou feign offence, asking if it's so wrong for you to take such pride in having such an wonderfully, majestically fertile lover, caressing her distended belly with gentle sweeping strokes, sliding your fingers across her sensitive skin.  The basilisk moans softly, shivering with pleasure at the sensation, her tail sliding up to caress your [hips]. \"<i>You are such a flatterer,</i>\" she tells you.  \"<i>Mmm... but I must confess zat zis is quite nice also...</i>\" she emphasizes her point by wriggling back against you, doing her best to nestle against your body.");

			outputText("\n\nOne hand continues to trace circles across her egg-laden womb, even as you move the other down to gently cup and squeeze her full bottom, rubbing the base of her tail before creeping down in between her legs. Dampness meets your probing fingers, letting you know your efforts have been rewarded, and you decide to give Benoite something a little more intense. Your [cock] begins to poke into the she-lizard's luscious ass, making her laugh that oh-so-filthy laugh of hers.  \"<i>And 'ere I sought zat you were just wanting to snuggle?  Well, come on z'en, my lovair; if you sink you know 'ow to use zat properly?</i>\"");

			outputText("\n\nYou hold onto her swollen stomach as you maneuver your cock up under her ass, seeking her feminine orifice. After a few moments, you find yourself properly aligned and begin to gently push yourself in, being careful and patient to ensure that you are not hurting your lover in her most delicate of conditions.  She gasps and sighs as you reach a comfortable depth inside her dripping cunt; too heavy to really move herself, she must submissively take each and every thrust and release as you slide yourself in and out, working yourself progressively deeper inside of her.");

			if (player.biggestCockLength() < 15) outputText("\n\nSoon you are hilting yourself in her depths, making her gasp as you slap into her.");
			else outputText("\n\nSoon you are bottoming out in her, making her gasp as your hulking length spreads her wide.");

			outputText("\n\nWith a surprising amount of languidness, you gently rock yourself back and forth inside of her, slowly drawing yourself out and then sliding back inside.  The basilisk's belly leaves her at your mercy, and you take full advantage of that, playing with her small nipples (after all, what other purpose do they have besides being used for her pleasure?) and stroking her belly.  She hisses and coos, but remains immobile; living proof of your virility, your sheer masculine potency.  Your hands cannot reach far enough to encompass all of her belly, so heavy is she with your offspring, and this merely spurs your pride and your arousal.  Only the need to avoid injuring her or her precious cargo keeps you from rutting her like a wild animal... though her desperate cries as she begs you to go faster, to do it harder, help quench the urges.  She is yours, totally and utterly, and you will have her as you want her.");

			outputText("\n\nSeeing that her pleas aren't getting her anywhere, Benoite manages to fight past her lust to try a different tack.  \"<i>C-Come on!  Is zis ze cock zat knocked me up?  Ze virile fuckstick zat made all zese eggs?</i>\"  She grinds her crotch into you as best she can, her slick cunt hungrily squeezing your intruding cock.  \"<i>I am not ze nervous leetle virgin anymore, [name]; I am ze expectant mozzair.  Give me your cum; let me be warm and full of your seed again! Zat is, if you have ze balls to do eet?</i>\" she coos");
			if (player.balls == 0) outputText(" with a smile, knowing damn well you don't, literally");
			outputText(".");

			outputText("\n\nYou can't resist it anymore; you slide yourself home in one final forceful thrust and cum, eliciting a delighted squawk from Benoite as jizz thunders from your cock into her depths, her own orgasm lost amidst the cascade of fluids churning and seething into her.  With her womb as jam-packed as it is, incapable of holding any more, the pressure just sends everything spurting back out of her cunt, drenching the pair of you in your seed.  Finally, your orgasm ends and you sigh in unison with her.");

			outputText("\n\n\"<i>Now zat is what I am talking about,</i>\" Benoite sighs softly.  \"<i>...I may 'ave to close ze shop early today.</i>\"");

			outputText("\n\nIn the end, it doesn't come to that, but it takes you quite a while to help Benoite get up, clean her off, tidy up the mess you made, and otherwise get her presentable again.  She gives you one of her reptilian kisses in appreciation, and sends you home again. ");
			player.sexReward("vaginalFluids", "Dick");
		}
	}
	doNext(camp.returnToCampUseOneHour);
}

	//Benoite Gives Birth

	public function femoitBirths():void
	{
		clearOutput();
		outputText("As you enter Benoite's stall, you hear the sounds of gasps of pain from the backroom, mingling with the sounds of stock being knocked around. You race through and find Benoite, completely naked, leaning against a table and groaning in anguish, her tail slashing wildly through the air behind her.  \"<i>[name]!  It.. it iz good zat you are here.  Ze eggs!  Zey come!</i>\"");

		outputText("\n\nShe lets out a howl of pain, claws digging deeply into the scarred wood of the tough old table she's leaning on, her huge belly hanging heavily over the floor. Instinct motivates you to help the soon-to-be mother of your children, and you dart around behind her.");

	// (First time:
		if (flags[kFLAGS.FEMOIT_HELPED_LAY] == 0)
		{
			outputText("\n\nYou ask if she can think of any way for you to help her.");

			outputText("\n\n\"<i>Just catch ze eggs, and try to make zis stop hurting so much!</i>\" the basilisk whines, claws audibly carving into tough old wood.  She looks on the verge of hysteria.  \"<i>Why did I sink zis was a great idea?  Fuck my race, </i>nuzzing<i> is worth zis amount of pain!</i>\"");
		}
		else
		{
			outputText("\n\nRemembering what you did before leaves you with no doubt as to how you can help.");

			outputText("\n\nLooking around, you easily find an array of scrap and lost clothing, which you quickly assemble into a crude nest underneath the laboring basilisk.  It's not much, but it'll give you a place to put the eggs");
			if (benoitVeryHeavyPreggers() || benoitExtremePreggers()) outputText("... which is good, because you can tell there're a lot of them coming");
			outputText(".  That done, you squat down behind Benoite, keeping your head down to avoid having it slapped by her swishing tail, and reach up between her legs. She promptly lets out a shriek.");

			if (flags[kFLAGS.FEMOIT_HELPED_LAY] == 1)
			{
				outputText("\"<i>What's the matter?</i>\" you blurt, alarmed.");

				outputText("\"<i>You... you 'ave cold 'ands!</i>\" she squeals, shuddering in displeasure.");
			}
			else
			{
				outputText("\"<i>What have I told you about warming zose hands?</i>\" she snaps angrily.");
			}
		}
		flags[kFLAGS.FEMOIT_HELPED_LAY]++;

		outputText("\n\nYou apologize, but don't take your hands away; instead, you start to rub her netherlips, feeling how dilated they are and trying to gauge how close she is to laying.  You occasionally rub the underside of her straining, swollen stomach in an effort to provide some comfort.  Her labor is progressing fast; you're certain she'll start delivery soon.");

		outputText("\n\n\"<i>At least basilisks - Oh! - lay eggs!</i>\" she pants.  \"<i>It iz easier zan trying to push out a baby...</i>\" she winces as another contraction visibly ripples across her belly. \"<i>It still 'urts like 'ell, though.</i>\"");

		outputText("\n\nYou encourage her to breathe deeply, to try and focus on pushing in time with the contractions.  Benoite groans but does as you instruct, and within moments she is gritting her teeth as the unmistakable form of an egg bulges from her pussy");
		if (silly()) outputText(".  It's shaped like a complex rhomboidal polygon with 15 sides.");
		else outputText(", the smoothly curved peak of a jade egg beginning to crest.");
		outputText("  With a strangled cry of orgasm tinged with pained relief, Benoite pushes it from her passage into your hands. Slick with juices, the egg makes for quite a handful and you find yourself struggling to safely cradle it within your grasp. You quickly place it into the makeshift nest at her feet.");

		if (flags[kFLAGS.FEMOIT_EGGS] >= 2)
		{
			outputText("\n\nFrom the continued distension of Benoite's midriff, though, it's obvious that this clutch contains multiple eggs.  She groans at the prospect, but continues to breathe and push.");

			if (benoitRegularPreggers())
			{
				outputText("\n\nHer labors are over quickly; the clutch isn't that big, and her muscles are already well prepared.  Soon, she's squatting over a pile of " + num2Text(flags[kFLAGS.FEMOIT_EGGS]) + " eggs.");
			}
			else if (benoitHeavyPreggers())
			{
				outputText("\n\nThanks to the shape of her eggs and the fact she's already properly dilated, the rest of the clutch comes relatively quickly.  It's a pretty decent brood of children, you feel; "+ num2Text(flags[kFLAGS.FEMOIT_EGGS]) +" eggs, all told.");
			}
			else if (benoitVeryHeavyPreggers())
			{
				outputText("\n\nYou're glad that giving birth is easier for Benoite than it would be for a mammal, as she needs all the help she can get.  Her huge stomach proves that she wasn't merely putting on weight as egg after egg pushes out of her stretched cunt.  By the time she's flat as a board again, you've counted her offspring; " + num2Text(flags[kFLAGS.FEMOIT_EGGS]) + " eggs, each with a baby basilisk still growing inside it.");
			}
			else if (benoitExtremePreggers())
			{
				outputText("\n\nBenoite groans and moans like she's dying, but somehow finds the strength to soldier on as egg after egg after egg slides from her well-stuffed womb.  For a moment you wonder just how many she's got in there, but the cascade finally comes to an end; with a great deal of relief on both your parts.  While Benoite gasps for breath from her labors, you busy yourself counting your brood... "+ num2Text(flags[kFLAGS.FEMOIT_EGGS]) +" eggs!")
			}
		}

		outputText("\n\nLaying done, Benoite heaves a great sigh of relief.  \"<i>Sank goodness zat's over,</i>\" she declares, even as she sinks to her knees, careful to avoid crushing the egg");
		if (flags[kFLAGS.FEMOIT_EGGS] > 1) outputText("s");
		outputText(" she just laid.  You nod from behind her, and cautiously move around to give her a hug.  She is a very, very brave woman, and an even braver man for making the decision to do this in the first place.");

		outputText("\n\n\"<i>Flattery,</i>\" Benoite declares in her husky voice, a hint of a reptilian blush in her crest, suddenly flush against her head.  \"<i>Now, let us see ze fruits of zis crazy union, shall we?</i>\"  With your help, she repositions herself so that she can start feeling at the contents of your 'nest', allowing her to touch and count the numbers of her clutch.");

		if (benoitRegularPreggers()) outputText(" She sighs softly.  \"<i>A small clutch, this is... normal for my people, yes, but not very good for my mission, is it?  Still, a small step to freedom is still a step.</i>\"  She manages to smile.  \"<i>My children will be free, and that is something to celebrate.</i>\"");
		else if (benoitHeavyPreggers()) outputText(" \"<i>My, a nice big clutch we had together, didn't we?</i>\" she smiles, proudly.  \"<i>Yes, these will be strong children, I zink.</i>\"");
		else if (benoitVeryHeavyPreggers()) outputText(" \"<i>...Wow, you're quite ze stud, aren't you?</i>\" Benoite says, giving a throaty growl of lust.  \"<i>I chose well when I decided to let you fertilize my eggs... so many eggs, too.</i>\"");
		else if (benoitExtremePreggers()) outputText(" The basilisk stops after her counting, visibly stunned.  She recounts her eggs again, and then again, shaking her head in amazement.  \"<i>Incredible... simply, incredible.  I didn't think it was possible for one woman to lay zo many eggs!  Zut alors!</i>\"  A sudden look of horrified realization washes over her features.  \"<i>I'm going to be run off my feet with all zese little monsters, aren't I?</i>\" she murmurs to herself.");

		outputText("\n\nYou ask if Benoite will be alright now.");

		outputText("\n\nThe basilisk looks at you and smirks.  \"<i>I am not so fragile, [name].  I can move like my old self again, and don't worry, I 'ave got somewhere nice and warm and safe picked out already.</i>\"  She pinches your [ass], making you jump.");

		outputText("\n\nYou insist on helping Benoite put the egg");
		if (flags[kFLAGS.FEMOIT_EGGS] > 1) outputText("s");
		outputText(" away safely, though, and the blind reptilian clearly appreciates the help.  Leaving her to admire her new clutch you head back to camp.");
		clearBenoitPreggers();
		doNext(camp.returnToCampUseOneHour);
	}

	//Herminise Benoite.
	public function benoitHerminise():void
	{
		clearOutput();

		// Ingredients not in inventory
		if (!player.hasItem(consumables.P_DRAFT, 2) || !player.hasItem(consumables.PSDELIT) || !player.hasItem(consumables.REPTLUM))
		{
			outputText("You don't have the necessary ingredients to attempt this yet.");
			outputText("\n\n<b>(Requires 2x Purified Incubi Draft, 1x Purified Succubi's Delight, 1x Reptilium.)</b>");
            CoC.instance.flushOutputTextToGUI();
        }
		else
		{
			player.destroyItems(consumables.P_DRAFT, 2);
			player.destroyItems(consumables.PSDELIT, 1);
			player.destroyItems(consumables.REPTLUM, 1);

			outputText("You tell her that she could use a new penis, just like her old form.");

			outputText("\n\nYou ferret out the ingredients you have collected and begin to bang them onto the counter in front of Benoite, telling her that you've got what she needs.  Pierre barks excitedly at the noise.");

			outputText("\n\n\"<i>Zis a good idea.</i>\" the basilisk says.  \"<i>Zat way, I can still lay eggs and you get to lay eggs.</i>\"  She lapses into silence as you grab a glass bottle from a nearby shelf and a wooden spoon from a container full of old utensils, and begin to mix the various ingredients together.  You pour the liquids into the glass bottle.  Carefully you drip in the reptilum whilst continuing to stir and; eventually the liquid in front of you takes on a livid lime color.  You shake the bottle to get it well-mixed.  When the scent changes to that of cooking sherry you stop and step back to admire your handiwork, before pushing the bowl gently across the counter until it touches the basilisk's claws.  She slowly clasps her fingers around it, staring blindly into the concoction.");

			outputText("\n\nYou instruct her to drink the concoction.  She nods and slowly drinks the concoction until the bottle is empty.  \"<i>I can feel it...</i>\" she slowly mutters.  A bulge starts to form under her robes. \"<i>Ohhh... It is coming!</i>\" she announces.  She opens her robes to reveal her new reptilian prick and a set of balls just above her vagina.  \"<i>Thank you.  Wis that, I can help you to lay some eggs,</i>\" she says.");

			outputText("\n\nYou assure her that she can do it someday when you're ready.");
			flags[kFLAGS.BENOIT_STATUS] = 3; //Hermaphrodite Benoite.
			doNext(camp.returnToCampUseOneHour);
		}
	}
}
}
