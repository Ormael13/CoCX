/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Camp 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.NPCs.*;
import classes.Scenes.SceneLib;

use namespace CoC;
	
	public class CampScenes extends NPCAwareContent
{

public static var elderKitsuneColors:Array = ["metallic golden", "golden blonde", "metallic silver", "silver blonde", "snow white", "iridescent gray"];

private var daughtersCount:Number = 0;

public function KitsuneShrine():void {
    var tailz:int = SceneLib.kitsuneScene.meditateAtKitsuneShrine();
    if (tailz == 9 && flags[kFLAGS.AYANE_FOLLOWER == 0]) {
		outputText("\n\nYou see a form surging from the shadow of the shrine. It’s Ayane and you ponder how she found your camp.");
		outputText("\n\nThe kitsune approaches and bows to you in reverence. \"<i>You have acquired a near deific status [name], as a priestess of Taoth it would be an honor to serve as your attendant. That is, if you would allow me to follow and assist you.</i>\"");
		outputText("\n\nA little surprised, you ask Ayane why she wants to serve you.");
		outputText("\n\n\"<i>Nine-tailed kitsunes are, in every aspect, divine messengers of Taoth in the mortal world. By serving you I follow the fox god's teachings and uphold his will. It would be an honor with no equal for me.</i>\"");
		outputText("\n\nDo you take her as your attendant?");
		doYesNo(AyaneStayAtCamp, AyaneGoBackToShrine);
	}
	else {
		doNext(camp.returnToCampUseOneHour);
	}
}

private function AyaneStayAtCamp():void {
	clearOutput();
	outputText("\"<i>Thank you " + player.mf("lord", "lady") + " [name] please allow me to tend to your every need from now on.</i>\"");
	outputText("\n\nAyane nod then head back to the forest to gather her things in a weird bag that seems to never be fuller or emptier and starts to follow you around.");
	outputText("\n\n(<b>Ayane has been added to the Followers menu!</b>)\n\n");
	flags[kFLAGS.AYANE_FOLLOWER] = 2;
	doNext(camp.returnToCampUseOneHour);
}
private function AyaneGoBackToShrine():void {
	clearOutput();
	outputText("\n\nAyane looks disappointed but nods regardless. \"<i>I accept your choice... maybe I was too hasty. Come back and see me again, should you be in need of counsel or a servant, my " + player.mf("lordship", "ladyship") + ".</i>\"");
	flags[kFLAGS.AYANE_FOLLOWER] = 1;
	doNext(camp.returnToCampUseOneHour);
}

public function HotSpring():void {
	menu();
	if (!player.hasCock()) addButton(0, "Bath (F)", HaveAGirlBath).hint("Have a bath.");
	if (player.hasCock()) {
		addButton(1, "Bath (M)", HaveABoysBath).hint("Have at bath.");
		if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] >= 5) addButton(2, "PeepingTom", PeepingTom2).hint("Peep at bath.");
	}
	addButton(14, "Back", playerMenu);
} 

public function HaveABoysBath():void {
	clearOutput();
	outputText("You decide to take a bath to rest your weary body.\n\n");
	if (player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] < 3) outputText("Jojo isn’t exactly what you would call muscular, but his size and lean frame fits his mouse appearance.\n\n");
	if (player.hasStatusEffect(StatusEffects.CampRathazul)) outputText("You're almost glad you don’t see any part of Rathazul’s body beyond the hip level, though you’re not particularly interested anyway.\n\n");
	if (arianScene.arianFollower() && flags[kFLAGS.ARIAN_VAGINA] < 1 && flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("Arian doesn’t seem to hate the water. He's likely cold blooded and is probably enjoying it.\n\n");
	if (flags[kFLAGS.IZMA_BROFIED] == 1) outputText("Since Ismael is a true guy now, he was allowed to bath with the boys.\n\n");
	if (flags[kFLAGS.KONSTANTIN_FOLLOWER] >= 2) outputText("Sitting near you, Konstantin relaxes and stretches his limbs. His large and thick build dwarf those from the other guys. While chit-chatting, he friendly puts one arm around you, and with the other he shamelessly washes his gigantic manhood, earning no few stares and some blushes from the other boys.\n\n");
    if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] > 3) {
		outputText("Siegweird is bragging about his epic adventures in the corner");
		if (camp.maleNpcsHotBathCount() > 1) outputText(", much to everyone's annoyance");
		outputText(". You wish he would just relax and share his tales later.\n\n");
	}
	if (emberScene.followerEmber() && flags[kFLAGS.EMBER_GENDER] == 1) outputText("Ember’s body and maleness could easily give all the other boys an inferiority complex.\n\n");
	if (camp.loversHotBathCount() > 0) {
		outputText("You discuss your goals with the other guys when a girl's voice ring out from outside the spring.\n\n");
		outputText("\"<i>Ok boys, time's up it’s our turn.</i>\"\n\n");
		outputText("The lot of you hurry and dress back up before the girls get to the bath. It then comes to mind that you could peep on them... do you?\n\n");
		menu();
		addButton(0, "Leave", LeaveAfterMaleBath);
		addButton(1, "PeepingTom", PeepingTom1);
	}
}
public function LeaveAfterMaleBath():void {
	if (player.statusEffectv1(StatusEffects.BathedInHotSpring) < 73) {
		player.removeStatusEffect(StatusEffects.BathedInHotSpring);
		player.createStatusEffect(StatusEffects.BathedInHotSpring, 73, 0, 0, 0);
	}
	else player.createStatusEffect(StatusEffects.BathedInHotSpring, 73, 0, 0, 0);
	doNext(camp.returnToCampUseOneHour);
}

public function PeepingTom1():void {
	clearOutput();
	outputText("As usual your many female lovers and followers head for their daily bath and you search the wooden wall for a hole to peep through. Now that's what you wanted to see!\n\n");
	if (player.statusEffectv1(StatusEffects.BathedInHotSpring) < 73) {
		player.removeStatusEffect(StatusEffects.BathedInHotSpring);
		player.createStatusEffect(StatusEffects.BathedInHotSpring, 73, 0, 0, 0);
	}
	else player.createStatusEffect(StatusEffects.BathedInHotSpring, 73, 0, 0, 0);
	if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] < 5) flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] += 1;
	PeepingTom3();
}
public function PeepingTom2():void {
	clearOutput();
	outputText("As usual your many female lovers and followers head for their daily bath. This time around, you don't feel like simply waiting your turn, and search the wooden wall for a hole to peep through.\n\n");
	PeepingTom3();
}
public function PeepingTom3():void {
	if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) outputText("Amily is sitting in the left corner. Naturally, she’s a little shy about her modest breasts.\n\n");
	if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3 && flags[kFLAGS.JOY_COCK_SIZE] < 1) outputText("Joy is quite silent for once, you expected her to constantly blabber lewd comments about everyone's nudity.\n\n");
	if (followerKiha()) outputText("Kiha definitely doesn’t have a size complex, with her huge breasts leaving most of the other girls in the shade.\n\n");
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5) outputText("Chi Chi, while small, easily sports a bigger cup than Amily.\n\n");
	if (flags[kFLAGS.ALVINA_FOLLOWER] > 12) outputText("Alvina does not seem to care about her breast size. Her dark charms and unholy attraction aura does everything for her. Naturally nobody but you can see she’s there as usual. She look at you for a split second winking. Clearly she knows you are looking but as you expected of the demoness she really does not care.\n\n");
	if (player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) outputText("Marble easily has the largest pair here, beating all of the other girls without contest. They’re probably the milkiest too.\n\n");
	if (isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) outputText("Isabella sings as she bathes, which is not surprising. You assume they’re folk songs from her home.\n\n");
	if (sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
		outputText("Sophie, while not having the largest breasts, easily outshines every other girl when it comes to her hips. Her matronly build and egg bearing hips fit her stern confidence as she bathes");
		if (flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) outputText(", her daughter sitting at her side");
		outputText(".\n\n");
	}
	if (followerHel()) outputText("Helia is lazily sitting in the bath, not saying a word.\n\n");
	if (CelessScene.instance.isCompanion() && CelessScene.instance.isAdult) outputText(CelessScene.instance.Name+" is relaxing letting her equine half soak in the deeper watery area.\n\n");
	if (flags[kFLAGS.KINDRA_FOLLOWER] >= 1) outputText("Kindra’s wool doesn't seem to prevent her from enjoying the bath.\n\n");
	if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && !player.hasStatusEffect(StatusEffects.EtnaOff)) outputText("Etna isn’t far from your hiding spot, her tail tip covered with a towel for everyone else's safety.\n\n");
	if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) outputText("Ayane is enjoying some time off duty in the other corner, tending to her fur.\n\n");
	if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) {
		if (flags[kFLAGS.IZMA_NO_COCK] == 0) outputText("While not entirely a girl, Izma is womanly enough that she was still accepted in the bath, her crotch well hidden behind a cloth.\n\n");
		else outputText("While she was not always a girl, Izma is womanly enough that she was still accepted in the bath.\n\n");
	}
	if (flags[kFLAGS.SAMIRAH_FOLLOWER] > 9) outputText("As a naga, Samirah take a lot of space in the bath. You're glad you made it big enough to hold as many people as necessary.\n\n");
	if (flags[kFLAGS.DIANA_FOLLOWER] > 5 && !player.hasStatusEffect(StatusEffects.DianaOff)) outputText("Diana is resting next to a set of medicinal and aromatic oils she regularly spray in the bath.\n\n");
	//if (flags[kFLAGS.MICHIKO_FOLLOWER] >= 1) Michiko
	if (flags[kFLAGS.MITZI_RECRUITED] >= 4) outputText("Your resident goblin Mitzi saunters over, looking excited. She strips what little clothing she wears then climbs into the warm waters. Her large tits help her stay afloat as she lays back and relaxes, letting out a sigh of relief.\n\n");
	if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 33) outputText("Excellia comes over to enjoy the soothing waters. She climbs in, letting out a content moo as she lays back letting the warm waters wash over her.\n\n");
	if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) outputText("Luna is enjoying a break relaxing for once as she is not on duty" + (flags[kFLAGS.LUNA_FOLLOWER] > 6 ? ", though for a few split second you imagined her doing doggy paddle in the water" : "") + ".\n\n");
	if (arianScene.arianFollower() && flags[kFLAGS.ARIAN_VAGINA] > 0 && flags[kFLAGS.ARIAN_COCK_SIZE] == 0) outputText("Arian while formerly a male seems to get along with the other girls.\n\n");
	if (flags[kFLAGS.SIDONIE_FOLLOWER] >= 1) {
		outputText("Sitting on a side of the spring that is spacious enough to accommodate her larger frame, Sidonie lies relaxed, among the girls. Most of them give her not-so subtle glances, some of them at her hefty bosom, but the most directed at the thick equine member dangling from the legs. Not caring too much about their looks, she simply lies and enjoy the bath.\n\n");
	}
	outputText("The girls are discussing womanly topics giving you a nice display of their assets.\n\n");
	if (emberScene.followerEmber() && (flags[kFLAGS.EMBER_GENDER] == 2 || flags[kFLAGS.EMBER_GENDER] == 3)) {
		outputText("Something suddenly grabs you and lifts you by the leg. Turns out it’s Ember and she’s angry.\n\n");
		outputText("\"<i>Hey! What the hell are you doing [name]! I saw all of it, you were peeping!</i>\"\n\n");
		outputText("All the girls leap out of the hot spring and rush toward you, calling you a jerk and a voyeur as they glare. One of them craftily suggests you deserve a proper punishment.\n\n");
		outputText("\"<i>Since [name] wants to see us naked that badly, let’s offer him a show he won’t forget!</i>\"\n\n");
		outputText("You are shoved to the ground, each of your angry lovers taking turns raping you. It’s gonna take a full day for your cock to stop burning from the abuse your lovers gave it.\n\n");
		player.orgasm();
		if (player.statusEffectv1(StatusEffects.Dysfunction) < 25) {
			player.removeStatusEffect(StatusEffects.Dysfunction);
			player.createStatusEffect(StatusEffects.Dysfunction, 25, 0, 0, 0);
		}
		else player.createStatusEffect(StatusEffects.Dysfunction, 25, 0, 0, 0);
	}
	else {
		outputText("You grin as you watch them for hours, masturbating in the background, and leave without anyone knowing.");
		player.orgasm();
	}
	doNext(camp.returnToCampUseOneHour);
}

public function HaveAGirlBath():void {
	clearOutput();
	outputText("You sigh in relief as you remove your clothes and head to the bath along with the other girls.\n\n");
	if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) outputText("Amily is sitting in the left corner. Naturally, she’s a little shy about her modest breasts.\n\n");
	if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3 && flags[kFLAGS.JOY_COCK_SIZE] < 1) outputText("Joy is quite silent for once, you expected her to constantly blabber lewd comments about everyone's nudity.\n\n");
	if (followerKiha()) outputText("Kiha definitely doesn’t have a size complex, with her huge breasts leaving most of the other girls in the shade.\n\n");
	if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 && flags[kFLAGS.CHI_CHI_FOLLOWER] != 5) outputText("Chi Chi, while small, easily sports a bigger cup than Amily.\n\n");
	if (flags[kFLAGS.ALVINA_FOLLOWER] > 12) outputText("Alvina does not seem to care about her breast size. Her dark charms and unholy attraction aura does everything for her. Naturally nobody but you can see she’s there as usual.\n\n");
	if (player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) outputText("Marble easily has the largest pair here, beating all of the other girls without contest, They’re probably the milkiest too.\n\n");
	if (isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) outputText("Isabella sings as she bathes, which is not surprising. You assume they’re folk songs from her home.\n\n");
	if (sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
		outputText("Sophie, while not having the largest breasts, easily outshines every other girl when it comes to her hips.Her matronly build and egg bearing hips fit her stern confidence as she bathes");
		if (flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) outputText(", her daughter sittings at her side");
		outputText(".\n\n");
	}
	if (followerHel()) outputText("Helia is lazily sitting in the bath, not saying a word.\n\n");
	if (CelessScene.instance.isCompanion() && CelessScene.instance.isAdult) outputText(CelessScene.instance.Name+" is relaxing letting her equine half soak in the deeper watery area.\n\n");
	if (flags[kFLAGS.KINDRA_FOLLOWER] >= 1) outputText("Kindra’s wool doesn't seem to prevent her from enjoying the bath.\n\n");
	if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && !player.hasStatusEffect(StatusEffects.EtnaOff)) outputText("Etna isn’t far from you, her tail tip covered with a towel for everyone else's safety.\n\n");
	if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) {
		outputText("Ayane is enjoying some quality time in the other corner, tending to her fur");
		if (player.kitsuneScore() >= 5) outputText(" and yours");
		outputText(".\n\n");
	}
	if (flags[kFLAGS.SAMIRAH_FOLLOWER] > 9) outputText("As a naga Samirah take a lot of space in the bath. You're glad you made it big enough to hold as many people as necessary.\n\n");
	if (flags[kFLAGS.DIANA_FOLLOWER] > 5 && !player.hasStatusEffect(StatusEffects.DianaOff)) outputText("Diana is resting next to a set of medicinal and aromatic oils she regularly spray in the bath. Can’t say this is not welcome.\n\n");
	//if (flags[kFLAGS.MICHIKO_FOLLOWER] >= 1) Michiko
	if (flags[kFLAGS.MITZI_RECRUITED] >= 4) outputText("Your resident goblin Mitzi saunters over, looking excited. She strips what little clothing she wears then climbs into the warm waters. Her large tits help her stay afloat as she lays back and relaxes, letting out a sigh of relief.\n\n");
	if (flags[kFLAGS.EXCELLIA_RECRUITED] >= 33) outputText("Excellia comes over to enjoy the soothing waters. She climbs in, letting out a content moo as she lays back letting the warm waters wash over her.\n\n");
	if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && !player.hasStatusEffect(StatusEffects.LunaOff)) outputText("Luna is enjoying a break relaxing for once as she is not on duty" + (flags[kFLAGS.LUNA_FOLLOWER] > 6 ? ", though for a few split second you imagined her doing doggy paddle in the water" : "") + ".\n\n");
	if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) {
		if (flags[kFLAGS.IZMA_NO_COCK] == 0) outputText("While not entirely a girl, Izma is womanly enough that she was still accepted in the bath, her crotch well hidden behind a cloth.\n\n");
		else outputText("While she was not always a girl, Izma is womanly enough that she was still accepted in the bath.\n\n");
	}
	if (emberScene.followerEmber() && flags[kFLAGS.EMBER_GENDER] == 2) {
		outputText("While Ember's size is impressive, her breasts are, simply put, intimidating");
		if (player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) outputText(". You still can’t help but wonder how Marble can sit right next to her and act like everything is ok");
		outputText(".\n\n");
	}
	if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) {
		outputText("Amily laughs as she notices you're comparing everyone's cup size to your own, gently reminding you that ");
		if (player.biggestTitSize() >= 2) outputText("she is off course the smallest");
		else outputText("you are of course the smallest");
		outputText(". This friendly competition continues for a few minutes, before escalating as everyone starts groping each other to compare their relative size. Perhaps it’s the water temperature, but soon groping is no longer enough, with caresses and kisses beginning to be exchanged all over the pool. ");
		outputText("A hand trails to your pussy and, in the confusion of the moment, you join in starting to finger your neighbor. Your communal bath quickly takes a lewder turn when everyone starts playing with each other, devolving into a heated orgy. Amidst this confusion, you kiss your nearest neighbor and abandon yourself to the heat of the moment.\n\n");
	}
	if (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 || flags[kFLAGS.FLOWER_LEVEL] >= 4) outputText("At some point during the orgy, you hear Holli yelling that it’s unfair she’s rooted in place at the other edge of the camp while everyone is enjoying themselves.\n\n");
	if (player.hasStatusEffect(StatusEffects.CampRathazul)) outputText("You can hear a half muffled chuckle from behind the wall. You could swear it was Rathazul, but you’re sure the old rat wouldn’t stoop so low as to peep on the lot of you, right?\n\n");
	outputText("An hour later you all get out of the hot spring, still giggling.");
	if (player.statusEffectv1(StatusEffects.BathedInHotSpring) < 73) {
		player.removeStatusEffect(StatusEffects.BathedInHotSpring);
		player.createStatusEffect(StatusEffects.BathedInHotSpring, 73, 0, 0, 0);
	}
	else player.createStatusEffect(StatusEffects.BathedInHotSpring, 73, 0, 0, 0);
	doNext(camp.returnToCampUseOneHour);
}

public function HclassHTbeaten():void {
	clearOutput();
	outputText("\nPLACEHOLDER TEXT 2\n");
	player.createPerk(PerkLib.HclassHeavenTribulationSurvivor, 0, 0, 0, 0);
	player.XP = player.XP + 5000;
	cleanupAfterCombat();
}
public function HclassHTsurvived():void {
	clearOutput();
	outputText("\nPLACEHOLDER TEXT 3\n");
	player.createPerk(PerkLib.HclassHeavenTribulationSurvivor, 0, 0, 0, 0);
	player.XP = player.XP + 2500;
	cleanupAfterCombat();
}

public function goblinsBirthScene():void {
	daughtersCount += 1 + rand(5);
	outputText("\n");
	if(player.vaginas.length == 0) {
		outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  <b>You look down and behold a new vagina</b>.  ");
		player.createVagina();
	}
	outputText("A sudden gush of fluids erupts from your vagina - your water just broke. You moan in pleasure as you feel wriggling and squirming inside your belly, muscle contractions forcing it downwards.\n\n");
	outputText("The pleasure only increase as your delivery continues... Arousal spikes through you as the contractions intensify, and as you feel something begin to pass you have a tiny orgasm. Yet this is only the beginning, and the contractions spike again, pushing you to orgasm as your daughter keeps moving forward. It repeats, over and over, nearly a dozen times she causes you to orgasm... this is even better then getting fucked! ");
	if (daughtersCount > 1) outputText("Each new baby you pop is a new orgasm and by the end of it your tongue is panting out from pleasure, bet you look wonderful right now. ");
	outputText("After an eternity of procreation and pleasure, you sense your ordeal is over and look for your newborn daughter"+(daughtersCount > 1 ? "s":"")+". ");
	outputText(""+(daughtersCount > 1 ? "One of t":"T")+"he green skinned cutie is thankfully right there between your leg and by instinct you grab and cradle her against your breast. ");
	if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] == 0) {
		outputText("Still, since she is your firstborn, how will you name her?\n\n");
		mainView.nameBox.text = "";
		menu();
		addButton(0, "Next", nameEldestGobo);
	}
	else goblinsBirthScene2();
}
private function nameEldestGobo():void {
	if (mainView.nameBox.text == "") {
		clearOutput();
		outputText("<b>You must name her.</b>");
		mainView.nameBox.text = "Eldest";
		mainView.nameBox.visible = true;
		mainView.nameBox.width = 165;
		mainView.nameBox.x = mainView.mainText.x + 5;
		mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		doNext(nameEldestGobo);
		return;
	}
	flags[kFLAGS.ELDEST_GOBLIN_DAUGHTER] = mainView.nameBox.text;
	mainView.nameBox.text = "";
	mainView.nameBox.visible = false;
	clearOutput();
	outputText("" + flags[kFLAGS.ELDEST_GOBLIN_DAUGHTER] + " now that's a name worthy of a future genius! ");
	goblinsBirthScene2();
}
private function goblinsBirthScene2():void {
	outputText("That solved, you doze off with your daughter against you, supremely happy.");
	player.cuntChange(60, true, true, false);
	outputText("\n\nWhen you wake up you are no longer holding a baby but what looks like a teenage goblin.\n\n");
	flags[kFLAGS.PC_GOBLIN_DAUGHTERS] += daughtersCount;
	if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] == daughtersCount) {
		outputText("" + flags[kFLAGS.ELDEST_GOBLIN_DAUGHTER] + " is looking at you with an adoring gaze.\n\n");
		outputText("\"<i>Morning Mom. Hey, say I was considering your setup here and decided, instead of running about aimlessly in the wild I might as well stay around your camp. You might actually need my help to get your work running.</i>\"\n\n");
		if (camp.maleNpcsHotBathCount() > 0 && !player.hasStatusEffect(StatusEffects.PureCampJojo)) {
			outputText("She licks her lips glancing sideways at your camp.\n\n");
			outputText("\"<i>Also because you have a "+(camp.maleNpcsHotBathCount() > 1 ? "few studs":"stud")+" available in the place which will help me breed a brood of my own when I’m ready to go.</i>\"\n\n");
		}
	}
	else {
		outputText("Your new daughter is looking at you with an adoring gaze.\n\n");
		outputText("\"<i>Morning Mom. Hey, say I might as well stay around the camp with everyone. Big sister " + flags[kFLAGS.ELDEST_GOBLIN_DAUGHTER] + " is here too and I think I might progress better along my goal in life by staying close to you"+((camp.maleNpcsHotBathCount() > 0 && !player.hasStatusEffect(StatusEffects.PureCampJojo)) ? ". Not to mention the "+(camp.maleNpcsHotBathCount() > 1 ? "many studs":"stud")+" available around the place":"")+".</i>\"\n\n");
	}
	outputText("Aw she’s fully grown up now but hey having more hands to get the work done only helps, right?\n\n");
	if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) player.vaginas[0].vaginalWetness++;
	player.orgasm();
	player.dynStats("str", -1, "tou", -2, "spe", 3, "lib", 1, "sen", .5);
	daughtersCount = 0;
	player.removeStatusEffect(StatusEffects.PCDaughters);
	doNext(camp.returnToCampUseOneHour);
}



public function PCGoblinDaughters():void {
	clearOutput();
	if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 9 && player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) {
		outputText("You check up on your goblin daughters at the workshop. " + flags[kFLAGS.ELDEST_GOBLIN_DAUGHTER] + " noticing you, screams some directive at her younger sisters and comes over to greet you.\n\n");
		outputText("\"<i>Sup Mom, how ya doin. Can I interest you into our newest projects? Or are you looking for something else?</i>\"\n\n");
	}
	else if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 1) {
		outputText("You check up on your goblin daughters. " + flags[kFLAGS.ELDEST_GOBLIN_DAUGHTER] + " comes over to greet you.\n\n");
		outputText("\"<i>Sup mom, how ya doin. Can I interest you into our newest projects? You know… if there were more of us we could actually build a workshop.</i>\"\n\n");
	}
	else {
		outputText("You check up on what " + flags[kFLAGS.ELDEST_GOBLIN_DAUGHTER] + " is doing.\n\n");
		outputText("\"<i>Sup Mom! How ya doin? I’m designing a new invention project, wanna have a look?</i>\"\n\n");
	}
	menu();
	if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 9 && player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) {
		if (player.goblinScore() > 9) addButton(2, "Engineering",  SceneLib.lumi.lumiWorkshop);
		else addButtonDisabled(2, "Engineering", "You need to be goblin for this.");
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshopSpareParts)) addButton(3, "Spare parts", PCGoblinDaughtersBuilingWorkshopSpareParts);
		else addButtonDisabled(3, "Spare parts", "You need to wait till tomorrow for new spare parts.");
	}
	addButton(14, "Back", camp.campFollowers);
}
public function PCGoblinDaughtersBuilingWorkshop():void {
	clearOutput();
	outputText("You wake up this morning and notice a new structure in your camp you didn’t see before. You can hear sounds of hammering and drilling inside and come over to notice your daughters finally built that workshop they were talking about. Your daughters inside are all busy tinkering with inventions and " + flags[kFLAGS.ELDEST_GOBLIN_DAUGHTER] + " comes over to greet you.\n\n");
	outputText("\"<i>Good morning Ma! we finally built that workshop we were all dreaming of! Look it’s already full of activity. We all run our own private projects here but sometimes come over with spare parts so feel free to dig in, you deserve as much.</i>\"\n\n");
	outputText("Well, how nice of them! You sure will dig in for spare parts every now and then, not to mention this atelier will provide a clean and productive area to build your own many inventions. You make sure to thank your eldest for setting this up for everyone.\n\n");
	player.createStatusEffect(StatusEffects.PCDaughtersWorkshop, 0, 0, 0, 0);
	doNext(playerMenu);
}
public function PCGoblinDaughtersBuilingWorkshopSpareParts():void {
	clearOutput();
	outputText("You look on your daily set of spare parts and happily notice you acquired the following items: <b>");
	outputText(player.statusEffectv1(StatusEffects.PCDaughtersWorkshopSpareParts)+" nails");
	if (player.statusEffectv2(StatusEffects.PCDaughtersWorkshopSpareParts) > 0) outputText(", "+player.statusEffectv2(StatusEffects.PCDaughtersWorkshopSpareParts)+" metal pieces");
	if (player.statusEffectv3(StatusEffects.PCDaughtersWorkshopSpareParts) > 0) outputText(", "+player.statusEffectv3(StatusEffects.PCDaughtersWorkshopSpareParts)+" mechanism");
	if (player.statusEffectv4(StatusEffects.PCDaughtersWorkshopSpareParts) > 0) outputText(", "+player.statusEffectv4(StatusEffects.PCDaughtersWorkshopSpareParts)+" energy core");
	outputText("</b>");
	flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] += player.statusEffectv1(StatusEffects.PCDaughtersWorkshopSpareParts);
	flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] += player.statusEffectv2(StatusEffects.PCDaughtersWorkshopSpareParts);
	if (player.statusEffectv3(StatusEffects.PCDaughtersWorkshopSpareParts) > 0) PCGoblinDaughtersBuilingWorkshopSparePartsMechanism();
	if (player.statusEffectv4(StatusEffects.PCDaughtersWorkshopSpareParts) > 0) PCGoblinDaughtersBuilingWorkshopSparePartsEnergyCore();
	player.removeStatusEffect(StatusEffects.PCDaughtersWorkshopSpareParts);
	doNext(playerMenu);
	cheatTime2(5);
}
public function PCGoblinDaughtersBuilingWorkshopSparePartsMechanism():void {
	player.addStatusValue(StatusEffects.PCDaughtersWorkshopSpareParts, 3, -1);
	if (player.statusEffectv2(StatusEffects.PCDaughtersWorkshopSpareParts) > 0) inventory.takeItem(useables.MECHANI, PCGoblinDaughtersBuilingWorkshopSparePartsMechanism);
	else inventory.takeItem(useables.MECHANI, null);
}
public function PCGoblinDaughtersBuilingWorkshopSparePartsEnergyCore():void {
	player.addStatusValue(StatusEffects.PCDaughtersWorkshopSpareParts, 4, -1);
	if (player.statusEffectv2(StatusEffects.PCDaughtersWorkshopSpareParts) > 0) inventory.takeItem(useables.ENECORE, PCGoblinDaughtersBuilingWorkshopSparePartsEnergyCore);
	else inventory.takeItem(useables.ENECORE, null);
}

}
}