package classes.Scenes.NPCs{
import classes.*;
import classes.GlobalFlags.kFLAGS;

public class Rathazul extends NPCAwareContent implements TimeAwareInterface {

//const RATHAZUL_DEBIMBO_OFFERED:int = 744;

	//Rathazul the Alchemist
	//Encounter, random text for potential uses, choices.
	//After he has crafted 3 things for the player, option to move into camp.
		public function Rathazul()
		{
			EventParser.timeAwareClassAdd(this);
		}
		
		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			if (flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] > 1) {
				flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN]--;
				if (flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] < 1) flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] = 1;
				if (flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] > 300) flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] = 24;
			}
			if (flags[kFLAGS.RATHAZUL_CAMP_INTERACTION_COUNTDOWN] > 0) {
				flags[kFLAGS.RATHAZUL_CAMP_INTERACTION_COUNTDOWN]--;
				if (flags[kFLAGS.RATHAZUL_CAMP_INTERACTION_COUNTDOWN] < 0) flags[kFLAGS.RATHAZUL_CAMP_INTERACTION_COUNTDOWN] = 0;
			}
			return false;
		}
	
		public function timeChangeLarge():Boolean {
			return false;
		}
		//End of Interface Implementation
		
		public function returnToRathazulMenu():void {
			if (player.hasStatusEffect(StatusEffects.CampRathazul))
				campRathazul();
			else encounterRathazul();
		}

public function encounterRathazul():void {
	spriteSelect(49);
	clearOutput();
	if(flags[kFLAGS.MARBLE_PURIFICATION_STAGE] == 2 && player.hasStatusEffect(StatusEffects.MetRathazul))
	{
		marblePurification.visitRathazulToPurifyMarbleAfterLaBovaStopsWorkin();
		return;
	}
	var offered:Boolean;
	//Rat is definitely not sexy!
	if(player.lust > 30) dynStats("lus", -10);
	//Introduction
	outputText(images.showImage("rathazul-lake"));
	if(player.hasStatusEffect(StatusEffects.MetRathazul)) {
		if(player.hasStatusEffect(StatusEffects.CampRathazul))
			outputText("You walk over to Rathazul's corner of the camp.  He seems as busy as usual, with his nose buried deep in some tome or alchemical creation, but he turns to face you as soon as you walk within a few paces of him.\n\n");
		else
			outputText("You spy the familiar sight of the alchemist Rathazul's camp along the lake.  The elderly rat seems to be oblivious to your presence as he scurries between his equipment, but you know him well enough to bet that he is entirely aware of your presence.\n\n");
	}
	else {
		outputText("You encounter a hunched figure working as you come around a large bush.  Clothed in tattered robes that obscure most his figure, you can nontheless see a rat-like muzzle protruding from the shadowy hood that conceals most of his form.  A simple glance behind him confirms your suspicions - this is some kind of rat-person.  He seems oblivious to your presence as he stirs a cauldron of viscous fluid with one hand; a neat stack of beakers and phials sit in the dirt to his left.  You see a smile break across his aged visage, and he says, \"<i>Come closer child.  I will not bite.</i>\"\n\nApprehensive of the dangers of this unknown land, you cautiously approach.\n\n\"<i>I am Rathazul the Alchemist.  Once I was famed for my miracle cures.  Now I idle by this lake, helpless to do anything but measure the increasing amounts of corruption that taint its waters,</i>\" he says as he pulls back his hood, revealing the entirety of his very bald and wrinkled head.\n\n");
		player.createStatusEffect(StatusEffects.MetRathazul,0,0,0,0);
	}
	//Camp offer!
	if(player.statusEffectv2(StatusEffects.MetRathazul) >= 2 && player.statusEffectv3(StatusEffects.MetRathazul) != 1 && player.cor < 75) {
		outputText("\"<i>You know, I think I might be able to do this worn-out world a lot more good from your camp than by wandering around this lake.  What do you say?</i>\" asks the rat.\n\n(Move Rathazul into your camp?)");
		doYesNo(rathazulMoveToCamp, rathazulMoveDecline);
		//Set rathazul flag that he has offered to move in (1 time offer)
		player.changeStatusValue(StatusEffects.MetRathazul,3,1);
		return;
	}
	offered = rathazulWorkOffer();
	if(!offered) {
		outputText("He sighs dejectedly, \"<i>I am not sure what I can do for you, youngling.  This world is fraught with unimaginable dangers, and you're just scratching the surface of them.</i>\"\n\nYou nod and move on, leaving the depressed alchemist to his sadness.");
		doNext(camp.returnToCampUseOneHour);
	}
}

private function rathazulMoveToCamp():void {
	clearOutput();
	outputText("Rathazul smiles happily back at you and begins packing up his equipment.  He mutters over his shoulder, \"<i>It will take me a while to get my equipment moved over, but you head on back and I'll see you within the hour.  Oh my, yes.</i>\"\n\nHe has the look of someone experiencing hope for the first time in a long time.");
	player.createStatusEffect(StatusEffects.CampRathazul, 0, 0, 0, 0);
	doNext(camp.returnToCampUseOneHour);
}

private function rathazulMoveDecline():void {
	clearOutput();
	outputText("Rathazul wheezes out a sigh, and nods.\n\n\"<i>Perhaps I'll still be of some use out here after all,</i>\" he mutters as he packs up his camp and prepares to head to another spot along the lake.");
	doNext(camp.returnToCampUseOneHour);
}

public function campRathazul():void {
	spriteSelect(49);
	clearOutput();
	if(flags[kFLAGS.MARBLE_PURIFICATION_STAGE] == 2 && player.hasStatusEffect(StatusEffects.MetRathazul))
	{
		marblePurification.visitRathazulToPurifyMarbleAfterLaBovaStopsWorkin();
		return;
	}
	//Special rathazul/follower scenes scenes.
	if(rand(6) == 0 && flags[kFLAGS.RATHAZUL_CAMP_INTERACTION_COUNTDOWN] == 0) {
		flags[kFLAGS.RATHAZUL_CAMP_INTERACTION_COUNTDOWN] = 3;
		//Pure jojo
		if(flags[kFLAGS.JOJO_RATHAZUL_INTERACTION_COUNTER] == 0 && player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_DEAD_OR_GONE] == 0) {
			finter.jojoOffersRathazulMeditation();
			return;
		}
		if(flags[kFLAGS.AMILY_MET_RATHAZUL] == 0 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower()) {
			finter.AmilyIntroducesSelfToRathazul();
			return;
		}
		if(flags[kFLAGS.AMILY_MET_RATHAZUL] == 1 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower()) {
			finter.amilyIngredientDelivery();
			return;
		}
		if(flags[kFLAGS.AMILY_MET_RATHAZUL] == 2 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower()) {
			finter.amilyAsksAboutRathazulsVillage();
			return;
		}
	}
	var offered:Boolean;
	//Rat is definitely not sexy!
	if(player.lust > 30) dynStats("lus", -1);
	if(player.lust > 50) dynStats("lus", -2);
	if(player.lust > 100) dynStats("lus", -3);
	if(player.lust > 150) dynStats("lus", -4);
	if(player.lust > 200) dynStats("lus", -5);
	if(player.lust > 300) dynStats("lus", -5);
	if(player.lust > 400) dynStats("lus", -6);
	if(player.lust > 500) dynStats("lus", -6);
	if(player.lust > 600) dynStats("lus", -7);
	if(player.lust > 700) dynStats("lus", -7);
	if(player.lust > 800) dynStats("lus", -8);
	if(player.lust > 1000) dynStats("lus", -8);
	if(player.lust > 1200) dynStats("lus", -9);
	if(player.lust > 1400) dynStats("lus", -9);
	if(player.lust > 1600) dynStats("lus", -10);
	if(player.lust > 1800) dynStats("lus", -10);
	//Introduction
	outputText(images.showImage("rathazul-camp"));
	outputText("Rathazul looks up from his equipment and gives you an uncertain smile.\n\n\"<i>Oh, don't mind me,</i>\" he says, \"<i>I'm just running some tests here.  Was there something you needed, [name]?</i>\"\n\n");
	//player.createStatusEffect(StatusEffects.metRathazul,0,0,0,0);
	offered = rathazulWorkOffer();
	if (!offered) {
		outputText("He sighs dejectedly, \"<i>I don't think there is.  Why don't you leave me be for a time, and I will see if I can find something to aid you.</i>\"");
		if (player.hasStatusEffect(StatusEffects.CampRathazul))
			doNext(camp.campFollowers);
		else doNext(playerMenu);
	}

}

private function get philters():Boolean {
	return player.gems >= 100;
}
private function get reductos():Boolean {
	return player.hasStatusEffect(StatusEffects.CampRathazul) && player.statusEffectv2(StatusEffects.MetRathazul) >= 4 && ((flags[kFLAGS.AMILY_MET_RATHAZUL] >= 2 && player.gems >= 50) || player.gems >= 100);
}
private function get dyes():Boolean {
	return player.gems >= 50;
}
private function rathazulWorkOffer():Boolean {
	spriteSelect(49);
	var totalOffers:int = 0;
	var spoken:Boolean = false;
	var purify:Boolean = false;
	var debimbo:Boolean = false;
	var lethiciteDefense:Function = null;
	if (flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] == 1 && flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] < 10) {
		purificationByRathazulBegin();
		return true;
	}
	if(player.hasItem(consumables.BLACKEG) || player.hasItem(consumables.L_BLKEG)) {
		flags[kFLAGS.PC_KNOWS_ABOUT_BLACK_EGGS] = 1;
		spoken = true;
		outputText("He eyes the onyx egg in your inventory and offers a little advice.  \"<i>Be careful with black eggs.  They can turn your skin to living latex or rubber.  The smaller ones are usually safer, but everyone reacts differently.  I'd get rid of them, if you want my opinion.</i>\"\n\n");
	}
	var pCounter:int = 0;
	//Item purification offer
	if(player.hasItem(consumables.INCUBID)) {
		purify = true;
		totalOffers++;
		pCounter++;
	}
	if(player.hasItem(consumables.SUCMILK)) {
		purify = true;
		totalOffers++;
		pCounter++;
	}
	if(player.hasItem(consumables.SDELITE)) {
		purify = true;
		totalOffers++;
		pCounter++;
	}
	if(player.hasItem(consumables.LABOVA_)) {
		purify = true;
		totalOffers++;
		pCounter++;
	}
	if(player.hasItem(consumables.MINOCUM)) {
		purify = true;
		totalOffers++;
		pCounter++;
	}
	if (pCounter > 0) {
		if (pCounter == 1)
			outputText("The rat mentions, \"<i>I see you have at least one tainted item on you... for 20 gems I could remove most of the taint, making it a good deal safer to use.  Of course, who knows what kind of freakish transformations it would cause...</i>\"\n\n");
		else
			outputText("The rat mentions, \"<i>I see you have a number of demonic items on your person.  For 20 gems I could attempt to remove the taint from one of them, rendering it a good deal safer for consumption.  Of course it would not remove most of the transformative properties of the item...</i>\"\n\n");
		purify = true;
		spoken = true;
		totalOffers += pCounter;
	}
	//Offer dyes if offering something else.
	if(dyes) {
		outputText("Rathazul offers, \"<i>Since you have enough gems to cover the cost of materials for my dyes as well, you could buy one of my dyes for your hair.  ");
		if (player.statusEffectv2(StatusEffects.MetRathazul) >= 8) outputText("I should be able to make exotic-colored dyes if you're interested.  ");
		outputText("Or if you want some changes to your skin, I have skin oils and body lotions.  I will need 50 gems up-front.</i>\"\n\n");
		spoken = true;
		totalOffers++;
	}
	//Offer purity philter and numbing oil.
	if (philters) {
		outputText("Rathazul offers, \"<i>I can make something for you. Something to counter the corruption of this realm and if you're feeling too sensitive, I have these oils. I'll need 100 gems up-front.</i>\"");
		spoken = true;
		totalOffers++;
	}
	//Bee honey
	if (player.hasItem(consumables.BEEHONY)) {
		outputText("Rathazul offers, \"<i>If you're in need of a pure honey, I can distill the regular bee honey. You'll also need 25 gems up front.</i>\"\n\n");
	}
	//Pro Lactaid & Centaurinum & Scorpinum
	if (player.statusEffectv2(StatusEffects.MetRathazul) >= 5) {
		outputText("The rat mentions, \"<i>You know, I could make something new if you're willing to hand over two of vials labeled \"Equinum\", one vial of minotaur blood and one hundred gems. Or two vials of Bee Honey, two vials of Snake Oil and 100 gems. Or five bottles of Lactaid and two bottles of purified LaBova along with 250 gems.</i>\"\n\n");
	}
	//Reducto
	if(reductos) {
		outputText("The rat hurries over to his supplies and produces a container of paste, looking rather proud of himself, \"<i>Good news everyone!  I've developed a paste you could use to shrink down any, ah, oversized body parts.  The materials are expensive though, so I'll need ");
		if(flags[kFLAGS.AMILY_MET_RATHAZUL] >= 2) outputText("50");
		else outputText("100");
		outputText(" gems for each jar of ointment you want. And if you're, ah, not feeling big enough, I've also developed a liquid that you inject. The materials are expensive too so it's the same price for each needle.</i>\"\n\n");
		totalOffers++;
		spoken = true;
	}

	
	//Vines
	if(player.keyItemv1("Marae's Lethicite") > 0 && !player.hasStatusEffect(StatusEffects.DefenseCanopy) && player.hasStatusEffect(StatusEffects.CampRathazul)) {
		outputText("His eyes widen in something approaching shock when he sees the Lethicite crystal you took from Marae.  Rathazul stammers, \"<i>By the goddess... that's the largest piece of lethicite I've ever seen.  I don't know how you got it, but there is immense power in those crystals.  If you like, I know a way we could use its power to grow a canopy of thorny vines that would hide the camp and keep away imps.  Growing such a defense would use a third of that lethicite's power.</i>\"\n\n");
		totalOffers++;
		spoken = true;
		lethiciteDefense = growLethiciteDefense;
	}
	if(player.hasStatusEffect(StatusEffects.CampRathazul)) {
		if(flags[kFLAGS.RATHAZUL_DEBIMBO_OFFERED] == 0 && (sophieBimbo.bimboSophie() || player.findPerk(PerkLib.BroBrains) >= 0 || player.findPerk(PerkLib.BimboBrains) >= 0 || player.findPerk(PerkLib.FutaFaculties) >= 0)) {
			rathazulDebimboOffer();
			return true;
		}
		else if(flags[kFLAGS.RATHAZUL_DEBIMBO_OFFERED] > 0) {
			outputText("You recall that Rathazul is willing to make something to cure bimbo liqueur for 250 gems and five Scholar's Teas.");
			if(player.hasItem(consumables.SMART_T,5) && player.gems >= 250) {
				totalOffers++;
				debimbo = true;
			}
			else if(!player.hasItem(consumables.SMART_T,5)) outputText("  You should probably find some if you want that...");
			else outputText("  You need more gems to afford that, though.");
			outputText("\n\n");			
		}
		//Purification potion for Minerva
		if (flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] == 2 && flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] < 10 && player.hasKeyItem("Rathazul's Purity Potion") < 0) {
			outputText("The rodent alchemist suddenly looks at you in a questioning manner. \"<i>Have you had any luck finding those items? I need pure honey and at least two samples of other purifiers; your friend’s spring may grow the items you need.</i>\"");
			outputText("\n\n");	
		}
		if (player.hasItem(consumables.LACTAID, 5) && player.hasItem(consumables.P_LBOVA, 2)) {
			outputText("The rodent sniffs your possessions. \"<i>You know, I could make something with five bottles of Lactaid and two bottles of purified LaBova. I'll also need 250 gems.</i>\"");
			outputText("\n\n");
		}
	}
	if(totalOffers == 0 && spoken) {
		doNext(camp.returnToCampUseOneHour);
		return true;
	}
	if(totalOffers > 0) {
		outputText("Will you take him up on an offer or leave?");
		//In camp has no time passage if left.
		menu();
		if (dyes) addButton(0, "Make Dye", makeDyes).hint("Ask him to make a special dye for you. \n\nCost: 50 Gems.");
		//Shop sub-menu
		if (dyes || philters || reductos)
			addButton(1, "Shop", rathazulShopMenu).hint("Check Rathazul's wares.");
		else
			addButtonDisabled(1, "Shop", "You can't afford anything Rathazul has to offer.");
		addButton(4, "Purify", purifySomething).hint("Ask him to purify any tainted potions. \n\nCost: 20 Gems.");
		
		if (debimbo) addButton(5, "Debimbo", makeADeBimboDraft).hint("Ask Rathazul to make a debimbofying potion for you. \n\nCost: 250 Gems \nNeeds 5 Scholar Teas.");
		if (player.hasItem(consumables.BEEHONY)) addButton(6, consumables.PURHONY.shortName, rathazulMakesPureHoney).hint("Ask him to distill a vial of bee honey into a pure honey. \n\nCost: 25 Gems \nNeeds 1 vial of Bee Honey");
		if (player.statusEffectv2(StatusEffects.MetRathazul) >= 5) addButton(7, "ProLactaid", rathazulMakesMilkPotion).hint("Ask him to brew a special lactation potion. \n\nCost: 250 Gems \nNeeds 5 Lactaids and 2 Purified LaBovas.");
		if (lethiciteDefense != null) addButton(10, "Lethicite", lethiciteDefense).hint("Ask him if he can make use of that lethicite you've obtained from Marae.");
		if (player.hasItem(consumables.PURHONY, 1) && player.hasItem(consumables.C__MINT, 1) && player.hasItem(consumables.PURPEAC, 1) && player.hasKeyItem("Rathazul's Purity Potion") < 0 &&(flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] == 2 && flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] < 10)) {
			addButton(11, "Pure Potion", rathazulMakesPurifyPotion).hint("Ask him to brew a purification potion for Minerva.");
		}
		if (player.statusEffectv2(StatusEffects.MetRathazul) >= 5) addButton(12, "Scorpinum", rathazulMakesScorpioPotion).hint("Ask him to brew a special potion that could aid in gaining scorpion tail. \n\nCost: 100 Gems \nNeeds 2 vials of Bee Honey and 2 vials of Snake Oil.");

		if(player.hasStatusEffect(StatusEffects.CampRathazul))
			addButton(14,"Leave", camp.campFollowers);
		else
			addButton(14, "Leave", camp.returnToCampUseOneHour);
		return true;
	}
	return false;
}

private function purifySomething():void {
	spriteSelect(49);
	clearOutput();
	outputText("Rathazul asks, \"<i>What would you like me to purify?</i>\"");
	menu();
	//Item purification offer
	if (player.hasItem(consumables.INCUBID)) {
		addButton(0, "Incubi Draft", rathazulPurifyIncubiDraft);
	}
	if (player.hasItem(consumables.SUCMILK)) {
		addButton(1, "SuccubiMilk", rathazulPurifySuccubiMilk);
	}
	if (player.hasItem(consumables.SDELITE)) {
		addButton(2, "S. Delight", rathazulPurifySuccubiDelight);
	}
	if (player.hasItem(consumables.LABOVA_)) {
		addButton(3, "LaBova", rathazulPurifyLaBova);
	}
	if(player.hasItem(consumables.MINOCUM)) {
		addButton(4,"MinoCum",purifyMinoCum);
	}
	addButton(14,"Back",rathazulWorkOffer);
}


private function rathazulPurifyIncubiDraft():void {
	clearOutput();
	if (player.gems < 20) {
		outputText("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"");
		doNext(returnToRathazulMenu);
		return;
	}
	if (!debug)
		player.destroyItems(consumables.INCUBID, 1);
	inventory.takeItem(consumables.P_DRAFT, returnToRathazulMenu);
	player.gems -= 20;
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}

//For Minerva purification.
public function purificationByRathazulBegin():void {
	outputText("Hoping the rodent-morph alchemist can assist you, you waste no time in approaching him. Rathazul looks up when he sees you, raising an eye curiously. \"<i>Is something the matter, [name]?</i>\"");
	outputText("\n\nYou nod, and ask him if he knows anything about either killing pests or purifying the corruption from people as well as objects. At his bemused expression, you explain about Minerva and her conditions, repeating your query if he could possibly help you. Rathazul looks downcast and shakes his head.");

	outputText("\n\n\"<i>I am afraid that I have never truly succeeded in my efforts to create a potion to purify the corrupted themselves.</i>\" The rat alchemist explains sadly. \"<i>The problem is there is very little, if anything, in this world that is capable of removing corruption from a consumer... But, I do have a theoretical recipe. If you can just find me some foodstuffs that would lower corruption and soothe the libido, and bring them to me, then I might be able to complete it. I can suggest pure giant bee honey as one, but I need at least two other items that can perform at least one of those effects. You said that the spring was able to keep your friend's corruption in check? Maybe some of the plants that grow there would be viable; bring me some samples, and a fresh dose of pure honey, and we’ll see what I can do.</i>\" He proclaims, managing to shake off his old depression and sound determined.");

	outputText("\n\nWith that in mind, you walk away from him; gathering the items that could cure Minerva is your responsibility.");
	flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] = 2;
	doNext(camp.returnToCampUseOneHour);
}

private function rathazulMakesPurifyPotion():void {
	clearOutput();
	player.destroyItems(consumables.PURHONY, 1);
	player.destroyItems(consumables.C__MINT, 1);
	player.destroyItems(consumables.PURPEAC, 1);
	outputText("You hurry over to Rathazul, and tell him you have the items you think he needs. His eyes widen in shock as you show them to him, and he immediately snatches them from you without a word, hurrying over to his alchemical equipment. You watch, uncertain of what he’s doing, as he messes around with it, but within minutes he has produced a strange-looking potion that he brings back to you.");

	outputText("\n\n\"<i>Have her swallow this, and it should kill the parasite within her at the very least.</i>\"");

	outputText("\n\nYou take it gratefully, but can’t help asking what he means by ‘should’.");

	outputText("\n\nRathazul shrugs helplessly. \"<i>This formula is untested; its effects are unpredictable... But, surely it cannot make things worse?</i>\"");

	outputText("\n\nYou concede he has a point and take the potion; all you need to do now is give it to Minerva and hope for the best.");
	player.createKeyItem("Rathazul's Purity Potion", 0, 0, 0, 0);
	menu();
	addButton(0, "Next", campRathazul);
}

private function rathazulPurifySuccubiMilk():void {
	clearOutput();
	if (player.gems < 20) {
		outputText("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"");
		doNext(returnToRathazulMenu);
		return;
	}
	if (!debug)
		player.destroyItems(consumables.SUCMILK, 1);
	inventory.takeItem(consumables.P_S_MLK, returnToRathazulMenu);
	player.gems -= 20;
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}


private function rathazulPurifySuccubiDelight():void {
	clearOutput();
	if (player.gems < 20) {
		outputText("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"");
		doNext(returnToRathazulMenu);
		return;
	}
	if (!debug)
		player.destroyItems(consumables.SDELITE, 1);
	inventory.takeItem(consumables.PSDELIT, returnToRathazulMenu);
	player.gems -= 20;
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}


private function rathazulPurifyLaBova():void {
	clearOutput();
	if (player.gems < 20) {
		outputText("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"");
		doNext(returnToRathazulMenu);
		return;
	}
	if (!debug)
		player.destroyItems(consumables.LABOVA_, 1);
	inventory.takeItem(consumables.P_LBOVA, returnToRathazulMenu);
	player.gems -= 20;
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}

private function rathazulDebimboOffer():void {
	spriteSelect(49);
	clearOutput();
	if(flags[kFLAGS.RATHAZUL_DEBIMBO_OFFERED] == 0) {
		if(sophieBimbo.bimboSophie()) {
			outputText("Rathazul glances your way as you approach his lab, a thoughtful expression on his age-lined face.  \"<i>Tell me, [name], do you truly enjoy having that vacuous idiot around, lusting after you at all hours of the day?</i>\" he asks, shaking his head in frustration.  \"<i>She's clearly been subjected to the effects of Bimbo Liqueur, which as you can plainly see are quite indeed potent.  However, like most things in Mareth, it can be countered - at least partially.</i>\"  Rathazul folds his long, clawed fingers together, his tail lashing behind him as he thinks.  \"<i>Perhaps with a sufficient quantity of something called Scholar's Tea... I could counter the stupefying effects of the elixir... oh my, yes... hmm...</i>\"  Rathazul nods, stroking at the few long wisps of fur that hang from his chin.");
			outputText("\n\nYou await");
			if (silly()) outputText(" getGoodPost()"); // C# await joke ;_; http://msdn.microsoft.com/en-gb/library/hh156528.aspx
			outputText(" further clarification, but the old rat just stands there, staring off into space.  Coughing politely, you reacquire his attention, causing him to jump.");
			outputText("\n\n\"<i>Oh?  Nmm, YES, bimbos, that's right!  As I was saying, five Scholar's Teas along with 250 gems for other reagents should give me all I need to create a bimbo-beating brew!  Oh my, the alliteration!  How absurd.</i>\"  Rathazul chuckles slowly, wiping a drop from his eye before he looks back at you fiercely, \"<i>It is a worthwhile goal - no creature should be subjected to a reduced intellect.  Let me know when you have acquired what is needed.</i>\"");
		}
		else {
			//Notification if the PC is the one bimbo'ed*
			if (player.findPerk(PerkLib.BimboBrains) >= 0 || player.findPerk(PerkLib.FutaFaculties) >= 0) {
				outputText("\n\nRathazul glances your way as you approach his lab, a thoughtful expression on his age-lined face.  \"<i>Tell me [name], do you truly enjoy living your life under the debilitating effects of that cursed potion?  Even now the spark of intelligence has all but left from your eyes.  Do you even understand what I'm saying?</i>\"");
				outputText("\n\nYou twirl a lock of hair around your finger and giggle.  This silly old rat thinks you're like, dumb and stuff!  He just doesn't know how great it is to have a rocking body and a sex-drive that's always ready to suck and fuck.  It's so much fun!  You look back at the rat, realizing you haven't answered him yet, feeling a bit embarrassed as he sighs in disappointment.");
				outputText("\n\n\"<i>Child, please... bring me five Scholar's Teas and 250 gems for reagents, then I can fix you!  I can help you!  Just... get the tea!</i>\" the alchemist pleads, counting off to five on his clawed fingers for extra emphasis while shaking his gem pouch profusely.  You bite your lower lip— he seems really really mad about this or something.  Maybe you should like, get the tea?");
			}
			else if (player.findPerk(PerkLib.BroBrains) >= 0) {
				outputText("\n\nRathazul glances your way as you approach his lab, a thoughtful expression on his age-lined face.  \"<i>I see you happen to have drank a can of Bro Brew in the past. If you ever need me to restore your intelligence capabilities, bring me five scholar teas and 250 gems. Thanks Marae you're not a bimbo; that would have been worse.</i>\"");
			}
		}
		flags[kFLAGS.RATHAZUL_DEBIMBO_OFFERED]++;
	}
	//Rath menu
	menu();
	addButton(0,"Next",campRathazul);
}

//Creation Of The Draft:*
private function makeADeBimboDraft():void {
	clearOutput();
	spriteSelect(49);
	outputText("Rathazul takes the teas and the gems into his wizened palms, shuffling the glittering jewels into a pouch and the teas into a large decanter.  He promptly sets the combined brews atop a flame and shuffles over to his workbench, where he picks up numerous pouches and vials of every color and description, adding them to the mix one after the other.  The mixture roils and bubbles atop the open flame like a monstrous, eerie thing, but quickly simmers down to a quiet boil.  Rathazul leaves it going for a while, stirring occasionally as he pulls out a smaller vial.  Once most of the excess liquid has evaporated, he pours the concoction into the glass container and corks it, holding it up to the light to check its coloration.");
	outputText("\n\n\"<i>That <b>should</b> do,</i>\" he mutters to himself.  Rathazul turns, carefully handing you the mixture.  \"<i>This should counter the mental-inhibiting effects of the Bimbo Liqueur, but I have no idea to what extent those who imbibe it will retain of their time spent as a bimbo...</i>\"\n\n");
	//Take items
	player.gems -= 250;
	player.consumeItem(consumables.SMART_T,5);
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul,2,1);
	inventory.takeItem(consumables.DEBIMBO, returnToRathazulMenu);
}

//PURIFICATION
private function purifyMinoCum():void{
	if (player.gems < 20)
	{
		clearOutput();
		outputText("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"");
		doNext(returnToRathazulMenu);
		return;
	}
	clearOutput();
	if (!debug) player.destroyItems(consumables.MINOCUM, 1);
	inventory.takeItem(consumables.P_M_CUM, returnToRathazulMenu);
	player.gems -= 20;
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}

//------------
// SHOP
//------------
private function rathazulShopMenu():void {
	menu();
	//Dyes
	if (dyes) {
		addButton(0, "Hair Dyes", buyDyes).hint("Ask him to make a dye for you. \n\nCost: 50 Gems.");
		addButton(1, "Skin Oils", buyOils).hint("Ask him to make a skin oil for you. \n\nCost: 50 Gems.");
		addButton(2, "Body Lotions", buyLotions).hint("Ask him to make a body lotion for you. \n\nCost: 50 Gems.");
	}
	else {
		addButtonDisabled(0, "Hair Dyes", "You can't afford to buy dyes. \n\n50 gems required.");
		addButtonDisabled(1, "Skin Oils", "You can't afford to buy oil. \n\n50 gems required.");
		addButtonDisabled(2, "Body Lotions", "You can't afford to buy lotions. \n\n50 gems required.");
	}
	//Reducto & GroPlus
	if (reductos) {
		addButton(3, "Reducto", buyReducto);
		addButton(4, "GroPlus", buyGroPlus);
	}
	else {
		addButtonDisabled(3, "Reducto", "Rathazul isn't currently producing this item or you can't afford to buy it.");
		addButtonDisabled(4, "GroPlus", "Rathazul isn't currently producing this item or you can't afford to buy it.");
	}
	//Philters
	if (philters) {
		addButton(5, consumables.H_PILL.shortName, buyPuritySomething, consumables.H_PILL);
		addButton(6, consumables.PPHILTR.shortName, buyPuritySomething, consumables.PPHILTR);
		addButton(7, consumables.NUMBOIL.shortName, buyPuritySomething, consumables.NUMBOIL);
	}
	else {
		addButtonDisabled(5, consumables.H_PILL.shortName, "You can't afford to buy this.\n\n100 gems required.");
		addButtonDisabled(6, consumables.PPHILTR.shortName, "You can't afford to buy this.\n\n100 gems required.");
		addButtonDisabled(7, consumables.NUMBOIL.shortName, "You can't afford to buy this.\n\n100 gems required.");
	}
	addButton(14, "Back", returnToRathazulMenu);
}
//Hair dyes
private function buyDyes(fromPage2:Boolean = false):void {
	clearOutput();
	if (!fromPage2) {
		spriteSelect(49);
		outputText("Rathazul smiles and pulls forth several vials of colored fluids.  Which type of dye would you like?");
		outputText("\n\n<b>(-50 Gems)</b>");
		player.gems -= 50;
		statScreenRefresh();
	}
	menu();
	addButton(0, "Auburn", buyDye, consumables.AUBURND);
	addButton(1, "Black", buyDye, consumables.BLACK_D);
	addButton(2, "Blond", buyDye, consumables.BLOND_D);
	addButton(3, "Brown", buyDye, consumables.BROWN_D);
	addButton(5, "Red", buyDye, consumables.RED_DYE);
	addButton(6, "White", buyDye, consumables.WHITEDY);
	addButton(7, "Gray", buyDye, consumables.GRAYDYE);
	if (player.statusEffectv2(StatusEffects.MetRathazul) >= 8) {
		addButton(4, "Next", buyDyesPage2);
		addButton(8, "Blue", buyDye, consumables.BLUEDYE);
		addButton(10, "Green", buyDye, consumables.GREEN_D);
		addButton(11, "Orange", buyDye, consumables.ORANGDY);
		addButton(12, "Purple", buyDye, consumables.PURPDYE);
		addButton(13, "Pink", buyDye, consumables.PINKDYE);
	}
	addButton(14, "Nevermind", buyDyeNevermind);
}
private function buyDyesPage2():void {
	clearOutput();
	if (player.statusEffectv2(StatusEffects.MetRathazul) < 8) { // Failsafe, should probably never happen (Stadler76)
		buyDyes(true);
		return;
	}
	spriteSelect(49);
	menu();
	addButton(0, "Russet", buyDye, consumables.RUSSDYE);
	if (player.statusEffectv2(StatusEffects.MetRathazul) >= 12) {
		addButton(1, "Rainbow", buyDye, consumables.RAINDYE);
	}
	addButton(4, "Previous", buyDyes, true);
	addButton(14, "Nevermind", buyDyeNevermind);
 }

private function buyDye(dye:ItemType):void {
	spriteSelect(49);
	clearOutput();
	outputText(images.showImage("rathazul-buy-dye"));
	inventory.takeItem(dye, rathazulShopMenu);
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}

private function buyDyeNevermind():void {
	spriteSelect(49);
	clearOutput();
	outputText("You change your mind about the dye, and Rathazul returns your gems.\n\n<b>(+50 Gems)</b>");
	player.gems += 50;
	statScreenRefresh();
	doNext(rathazulShopMenu);
}

//Scales dyes
private function makeDyes():void {
	spriteSelect(49);
	clearOutput();
	outputText("Rathazul smiles and pulls forth several vials preparing for mixing.  Which type of dye need?");
	outputText("\n\n<b>(-50 Gems)</b>");
	player.gems -= 50;
	statScreenRefresh();
	menu();
	if (player.hasItem(consumables.REPTLUM, 1) && flags[kFLAGS.ARIAN_SCALES] > 0) {
		if (player.hasItem(consumables.WHITEDY, 1)) addButton(0, "White", makeDye1);
		if (player.hasItem(consumables.BLUEDYE, 1)) addButton(1, "Blue", makeDye2);
		if (player.hasItem(consumables.PINKDYE, 1)) addButton(2, "Pink", makeDye3);
		if (player.hasItem(consumables.RAINDYE, 1)) addButton(3, "Rainbow", makeDye4);
	}
	addButton(14, "Nevermind", makeDyeNevermind);
}

private function makeDye1():void {
	spriteSelect(49);
	clearOutput();
	player.destroyItems(consumables.REPTLUM, 1);
	player.destroyItems(consumables.WHITEDY, 1);
	outputText(images.showImage("rathazul-buy-dye"));
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	inventory.takeItem(useables.VIALCLE, rathazulShopMenu);
}

private function makeDye2():void {
	spriteSelect(49);
	clearOutput();
	player.destroyItems(consumables.REPTLUM, 1);
	player.destroyItems(consumables.BLUEDYE, 1);
	outputText(images.showImage("rathazul-buy-dye"));
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	inventory.takeItem(useables.VIALTUR, rathazulShopMenu);
}

private function makeDye3():void {
	spriteSelect(49);
	clearOutput();
	player.destroyItems(consumables.REPTLUM, 1);
	player.destroyItems(consumables.PINKDYE, 1);
	outputText(images.showImage("rathazul-buy-dye"));
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	inventory.takeItem(useables.VIALPIN, rathazulShopMenu);
}

private function makeDye4():void {
	spriteSelect(49);
	clearOutput();
	player.destroyItems(consumables.REPTLUM, 1);
	player.destroyItems(consumables.RAINDYE, 1);
	outputText(images.showImage("rathazul-buy-dye"));
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	inventory.takeItem(useables.VIALRAI, rathazulShopMenu);
}

private function makeDyeNevermind():void {
	spriteSelect(49);
	clearOutput();
	outputText("You change your mind about the dye, and Rathazul returns your gems.\n\n<b>(+50 Gems)</b>");
	player.gems += 50;
	statScreenRefresh();
	doNext(rathazulShopMenu);
}

//Skin Oils
private function buyOils():void {
	spriteSelect(49);
	clearOutput();
	outputText("Rathazul smiles and pulls forth several bottles of skin oil.  Which type of skin oil would you like?");
	outputText("\n\n<b>(-50 Gems)</b>");
	player.gems -= 50;
	statScreenRefresh();
	menu();
	addButton(0, "Dark", buyOil, consumables.DARK_OL);
	addButton(1, "Ebony", buyOil, consumables.EBONYOL);
	addButton(2, "Fair", buyOil, consumables.FAIR_OL);
	addButton(3, "Light", buyOil, consumables.LIGHTOL);
	addButton(4, "Mahogany", buyOil, consumables.MAHOGOL);
	addButton(5, "Olive", buyOil, consumables.OLIVEOL);
	addButton(6, "Russet", buyOil, consumables.RUSS_OL);
	addButton(10, "Tan", buyOil, consumables.TAN_OIL);
	addButton(14, "Nevermind", buyOilNevermind);
}

private function buyOil(oil:ItemType):void {
	spriteSelect(49);
	clearOutput();
	outputText(images.showImage("rathazul-buy-oil"));
	inventory.takeItem(oil, rathazulShopMenu);
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}

private function buyOilNevermind():void {
	spriteSelect(49);
	clearOutput();
	outputText("You change your mind about the oil, and Rathazul returns your gems.\n\n<b>(+50 Gems)</b>");
	player.gems += 50;
	statScreenRefresh();
	doNext(rathazulShopMenu);
}

//Body Lotions
private function buyLotions():void {
	spriteSelect(49);
	clearOutput();
	outputText("Rathazul smiles and pulls forth several vials of body lotion.  Which type of body lotion would you like?");
	outputText("\n\n<b>(-50 Gems)</b>");
	player.gems -= 50;
	statScreenRefresh();
	menu();
	addButton(0, "Clear", buyLotion, consumables.CLEARLN);
	addButton(1, "Rough", buyLotion, consumables.ROUGHLN);
	addButton(2, "Sexy", buyLotion, consumables.SEXY_LN);
	addButton(3, "Smooth", buyLotion, consumables.SMTH_LN);
	addButton(14, "Nevermind", buyLotionNevermind);
}

private function buyLotion(lotion:ItemType):void {
	spriteSelect(49);
	clearOutput();
	outputText(images.showImage("rathazul-buy-lotion"));
	inventory.takeItem(lotion, rathazulShopMenu);
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}

private function buyLotionNevermind():void {
	spriteSelect(49);
	clearOutput();
	outputText("You change your mind about the lotion, and Rathazul returns your gems.\n\n<b>(+50 Gems)</b>");
	player.gems += 50;
	statScreenRefresh();
	doNext(rathazulShopMenu);
}

//Reducto
private function buyReducto():void {
	spriteSelect(49);
	clearOutput();
	var cost:int = (flags[kFLAGS.AMILY_MET_RATHAZUL] >= 2 ? 50 : 100);
	if (player.gems >= cost) {
		outputText(images.showImage("rathazul-buy-reducto"));
		outputText("Rathazul hands you the Reducto with a nod before returning to his work.\n\n");
		player.gems -= cost;
		inventory.takeItem(consumables.REDUCTO, rathazulShopMenu);
		statScreenRefresh();
		player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	}
	else {
		outputText("\"<i>I'm sorry, but you lack the gems I need to make the trade,</i>\" apologizes Rathazul.");
		doNext(rathazulShopMenu);
	}
}

//GroPlus
private function buyGroPlus():void {
	spriteSelect(49);
	clearOutput();
	var cost:int = (flags[kFLAGS.AMILY_MET_RATHAZUL] >= 2 ? 50 : 100);
	if (player.gems >= cost) {
		outputText(images.showImage("rathazul-buy-groplus"));
		outputText("Rathazul hands you the GroPlus with a nod before returning to his work.\n\n");
		player.gems -= cost;
		inventory.takeItem(consumables.GROPLUS, rathazulShopMenu);
		statScreenRefresh();
		player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	}
	else {
		outputText("\"<i>I'm sorry, but you lack the gems I need to make the trade,</i>\" apologizes Rathazul.");
		doNext(rathazulShopMenu);
	}
}


	private function buyPuritySomething(item:ItemType):void {
		clearOutput();
		player.gems -= 100;
		statScreenRefresh();
		inventory.takeItem(item, rathazulShopMenu);
		player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	}

//Turn several ingredients into a special potion/consumable.
private function rathazulMakesPureHoney():void {
	clearOutput();
	if (player.gems < 25) {
		outputText("\"<i>I'm sorry but you don't have the gems for this service,</i>\" Rathazul says.");
		doNext(rathazulShopMenu);
		return;
	}
	player.destroyItems(consumables.BEEHONY, 1);
	player.gems -= 25;
	statScreenRefresh();
	outputText("You hand over a vial of bee honey and the 25 gems.");
	outputText("\n\n\"<i>I'll see what I can do,</i>\" he says as he takes the bee honey and begin brewing something. ");
	outputText("\n\nA few minutes later, he comes back with the crystal vial that contains glittering liquid.  \"<i>It's ready. The honey should be pure now,</i>\" he says. He hands you over the vial of honey and goes back to working.  ");
	inventory.takeItem(consumables.PURHONY, rathazulShopMenu);
}

private function rathazulMakesMilkPotion():void {
	clearOutput();
	if (player.gems < 250) {
		outputText("\"<i>I'm sorry but you don't have the gems for this service,</i>\" Rathazul says.");
		doNext(rathazulShopMenu);
		return;
	}
	else if (!(player.hasItem(consumables.LACTAID, 5) && player.hasItem(consumables.P_LBOVA, 2))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need five bottles of Lactaid and two bottles of purified LaBova,</i>\" Rathazul says.");
		doNext(rathazulShopMenu);
		return;
	}
	player.destroyItems(consumables.LACTAID, 5);
	player.destroyItems(consumables.P_LBOVA, 2);
	player.gems -= 250;
	statScreenRefresh();
	outputText("You hand over the ingredients and 250 gems.");
	outputText("\n\n\"<i>I'll see what I can do,</i>\" he says as he takes the ingredients and begin brewing something. ");
	outputText("\n\nA few minutes later, he comes back with the potion.  \"<i>It's ready. If you have some issues with lactation or you want to produce milk forever, drink this. Keep in mind that it might be irreversible,</i>\" he says. He hands you over the potion and goes back to working.  ");
	inventory.takeItem(consumables.MILKPTN, rathazulShopMenu);
}

private function rathazulMakesScorpioPotion():void {
	spriteSelect(49);
	clearOutput();
	if (player.gems < 100) {
		outputText("\"<i>I'm sorry but you don't have the gems for this service,</i>\" Rathazul says.");
		doNext(rathazulShopMenu);
		return;
	}
	else if (!(player.hasItem(consumables.BEEHONY, 2) && player.hasItem(consumables.SNAKOIL, 2))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need two vials of Bee Honey and two vials of snake oil,</i>\" Rathazul says.");
		doNext(rathazulShopMenu);
		return;
	}
	player.destroyItems(consumables.BEEHONY, 2);
	player.destroyItems(consumables.SNAKOIL, 2);
	player.gems -= 100;
	statScreenRefresh();
	outputText("You hand over two vials of Bee Honey, two vials of Snake Oil and one hundred gems to Rathazul, which he gingerly takes them and proceeds to make a special potion for you.");
	outputText("\n\nAfter a while, the rat hands you a vial labeled \"Scorpinum\" and nods.");
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	inventory.takeItem(consumables.SCORICO, rathazulShopMenu);
}



private function growLethiciteDefense():void {
	spriteSelect(49);
	clearOutput();
	outputText("Rathazul asks, \"<i>Are you absolutely sure?  Growing this thorn canopy as a defense will use one third of the crystal's power.</i>\"\n\n(Do you have Rathazul use the crystal to grow a defensive canopy?)");
	doYesNo(growLethiciteDefenseYesYesYes, growLethiciteDefenseGuessNot);
}

private function growLethiciteDefenseYesYesYes():void {
	spriteSelect(49);
	clearOutput();
	outputText("Rathazul nods and produces a mallet and chisel from his robes.  With surprisingly steady hands for one so old, he holds the chisel against the crystal and taps it, easily cracking off a large shard.  Rathazul gathers it into his hands before slamming it down into the dirt, until only the smallest tip of the crystal is visible.  He produces vials of various substances from his robe, as if by magic, and begins pouring them over the crystal.  In a few seconds, he finishes, and runs back towards his equipment.\n\n\"<i>You may want to take a step back,</i>\" he warns, but before you have a chance to do anything, a thick trunk covered in thorny vines erupts from the ground.  Thousands of vine-like branches split off the main trunk as it reaches thirty feet in the air, radiating away from the trunk and intertwining with their neighbors as they curve back towards the ground.  In the span of a few minutes, your camp gained a thorn tree and a thick mesh of barbed vines preventing access from above.");
	player.createStatusEffect(StatusEffects.DefenseCanopy, 0, 0, 0, 0);
	player.addKeyValue("Marae's Lethicite", 1, -1);
	doNext(playerMenu);
}

private function growLethiciteDefenseGuessNot():void {
	spriteSelect(49);
	clearOutput();
	outputText("Rathazul nods sagely, \"<i>That may be wise.  Perhaps there will be another use for this power.\"</i>");
	doNext(returnToRathazulMenu);
}

}
}
