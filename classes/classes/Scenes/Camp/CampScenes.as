/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kACHIEVEMENTS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Camp;
	import classes.Scenes.Camp.*;
	import classes.Scenes.NPCs.*;
	import classes.StatusEffects;
	
	import coc.view.MainView;
	
	use namespace kGAMECLASS;
	
	public class CampScenes extends NPCAwareContent
{

public static var elderKitsuneColors:Array = ["metallic golden", "golden blonde", "metallic silver", "silver blonde", "snow white", "iridescent gray"];

public function KitsuneShrine():void {
	var tailz:int = getGame().kitsuneScene.meditateAtKitsuneShrine();
	if (tailz == 9 && flags[kFLAGS.AYANE_FOLLOWER == 0]) {
		outputText("\n\nYou see a form surging from the shadow of the shrine. It’s Ayane and you ponder how she found your camp.");
		outputText("\n\nThe kitsune approaches and bows to you in reverence. \"<i>You have acquired a near deific status [name], as a priestess of Taoth it would be an honor to serve as your attendant. That is, if you would allow me to follow and assist you.</i>\"");
		outputText("\n\nA little surprised, you ask Ayane why she wants to serve you.");
		outputText("\n\n\"<i>Nine-tailed kitsunes are, in every aspect, divine messengers of Taoth in the mortal world. By serving you I follow the fox god's teachings and uphold his will. It would be an honor with no equal for me.</i>\"");
		outputText("\n\nDo you take her as your attendant?");
		doYesNo(AyaneStayAtCamp, AyaneGoBackToShrine);
	} else {
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
	//clearOutput();
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
	outputText("You decide to take a bath to rest your weary adventurer body.\n\n");
	if (player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] < 3) outputText("Jojo isn’t exactly what you would call muscular but his size and lean frame fits his mouse outlook.\n\n");
	if (player.hasStatusEffect(StatusEffects.CampRathazul)) outputText("You're almost glad you don’t see anything of Rathazul body beyond the hip level but again It’s not like you are this interested into knowing.\n\n");
	if (arianScene.arianFollower() && flags[kFLAGS.ARIAN_VAGINA] < 1 && flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("Arian doesn’t seem to hate the water. He's likely cold blooded and must be enjoying it.\n\n");
	if (emberScene.followerEmber() && flags[kFLAGS.EMBER_GENDER] == 1) outputText("Ember body and maleness could easily give all the other boys inferiority complex.\n\n");
	if (camp.loversHotBathCount() > 0) {
		outputText("You discuss your goals with the other guys when a girl's voices ring out from outside the spring.\n\n");
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
//	 outputText("Chi Chi, while small, easily sports a bigger cup than Amily.\n\n");//Chi Chi
//	 outputText("Alvina does not seem to care about her breast size. Her dark charms and unholy attraction aura does everything for her. Naturally nobody but you can see she’s there as usual.\n\n");//Alvina
	if (player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) outputText("Marble easily has the largest pair here, beating all of the other girls without contest. They’re probably the milkiest too.\n\n");
	if (isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) outputText("Isabella sings as she bathes, which is not surprising. You assume they’re folk songs from her home.\n\n");
	if (sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
		outputText("Sophie, while not having the largest breasts, easily outshines every other girl when it comes to her hips. Her matronly build and egg bearing hips fit her stern confidence as she bathes");
		if (flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) outputText(", her daughter sitting at her side");
		outputText(".\n\n");
	}
	if (followerHel()) outputText("Helia is lazily sitting in the bath, not saying a word.\n\n");
//	 outputText("-Daughtername- is relaxing letting her equine half soak in the deeper watery area.\n\n");//Celess
	if (flags[kFLAGS.KINDRA_FOLLOWER] >= 1) outputText("Kindra’s wool doesn't seem to prevent her from enjoying the bath.\n\n");
	if (flags[kFLAGS.ETNA_FOLLOWER] > 0) outputText("Etna isn’t far from your hiding spot, her tail tip covered with a towel for everyone else's safety.\n\n");
	if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) outputText("Ayane is enjoying some time off duty in the other corner, tending to her fur.\n\n");
	if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) {
		if (flags[kFLAGS.IZMA_NO_COCK] == 0) outputText("While not entirely a girl, Izma is womanly enough that she was still accepted in the bath, her crotch well hidden behind a cloth.\n\n");
		else outputText("While she was not always a girl, Izma is womanly enough that she was still accepted in the bath.\n\n");
	}
//	 outputText("As a naga, Samira take a lot of space in the bath. You're glad you made it big enough to hold as many people as necessary.\n\n");//Samira
	if (arianScene.arianFollower() && flags[kFLAGS.ARIAN_VAGINA] > 0 && flags[kFLAGS.ARIAN_COCK_SIZE] == 0) outputText("Arian, while formerly a male, seems to get along with the other girls perfectly.\n\n");
	outputText("The girls are discussing womanly topics giving you a nice display of their assets.\n\n");
	if (emberScene.followerEmber() && (flags[kFLAGS.EMBER_GENDER] == 2 || flags[kFLAGS.EMBER_GENDER] == 3)) {
		outputText("Something suddenly grabs you and lifts you by the leg. Turns out it’s Ember and she’s angry.\n\n");
		outputText("\"<i>Hey! What the hell are you doing [name]! I saw all of it, you were peeping!</i>\"\n\n");
		outputText("All the girls leap out of the hot spring and rush toward you, calling you a jerk and a voyeur as they glare. One of them craftily suggests you deserve a proper punishment.\n\n");
		outputText("\"<i>Since [name] wants to see us naked that badly, let’s offer him a show he won’t forget!</i>\"\n\n");
		outputText("You are shoved to the ground, each of your angry lovers taking turns to rape you. It’s gonna take a full day for your cock to stop burning from the abuse your lovers gave it.\n\n");
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
//	 outputText("Chi Chi, while small, easily sports a bigger cup than Amily.\n\n");//Chi Chi
//	 outputText("Alvina does not seem to care about her breast size. Her dark charms and unholy attraction aura does everything for her. Naturally nobody but you can see she’s there as usual.\n\n");//Alvina
	if (player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) outputText("Marble easily has the largest pair here, beating all of the other girls without contest, They’re probably the milkiest too.\n\n");
	if (isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) outputText("Isabella sings as she bathes, which is not surprising. You assume they’re folk songs from her home.\n\n");
	if (sophieFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
		outputText("Sophie, while not having the largest breasts, easily outshines every other girl when it comes to her hips.Her matronly build and egg bearing hips fit her stern confidence as she bathes");
		if (flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) outputText(", her daughter sittings at her side");
		outputText(".\n\n");
	}
	if (followerHel()) outputText("Helia is lazily sitting in the bath, not saying a word.\n\n");
//	 outputText("-Daughtername- is relaxing letting her equine half soak in the deeper watery area.\n\n");//Celess
	if (flags[kFLAGS.KINDRA_FOLLOWER] >= 1) outputText("Kindra’s wool doesn't seem to prevent her from enjoying the bath.\n\n");
	if (flags[kFLAGS.ETNA_FOLLOWER] > 0) outputText("Etna isn’t far from you, her tail tip covered with a towel for everyone else's safety.\n\n");
	if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) {
		outputText("Ayane is enjoying some quality time in the other corner, tending to her fur");
		if (player.kitsuneScore() >= 5) outputText(" and yours");
		outputText(".\n\n");
	}
//	 outputText("As a naga Samira take a lot of space in the bath. You're glad you made it big enough to hold as many people as necessary.\n\n");//Samira
	if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) {
		if (flags[kFLAGS.IZMA_NO_COCK] == 0) outputText("While not entirely a girl, Izma is womanly enough that she was still accepted in the bath, her crotch well hidden behind a cloth.\n\n");
		else outputText("While she was not always a girl, Izma is womanly enough that she was still accepted in the bath.\n\n");
	}
	if (emberScene.followerEmber() && flags[kFLAGS.EMBER_GENDER] == 2) {
		outputText("While Ember's size is impressive, her breasts are, simply put, intimidating");
		if (player.hasStatusEffect(StatusEffects.CampMarble) && flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 0) outputText(". You still can’t help but wonder how come Marble can sit right next to her and act like everything is ok");
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

}
}