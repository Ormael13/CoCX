package classes.Scenes.NPCs{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.display.SpriteDb;

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
	spriteSelect(SpriteDb.s_rathazul);
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
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
    if (player.hasStatusEffect(StatusEffects.RathazulAprilFool) && player.statusEffectv3(StatusEffects.RathazulAprilFool) == 1) {
        rathazulAprilFoolPart3();
        return;
    }
	if (flags[kFLAGS.MARBLE_PURIFICATION_STAGE] == 2 && player.hasStatusEffect(StatusEffects.MetRathazul)) {
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
	if(player.lust > 2000) dynStats("lus", -11);
	if(player.lust > 2200) dynStats("lus", -11);
	//Introduction
	outputText(images.showImage("rathazul-camp"));
	outputText("Rathazul looks up from his equipment and gives you an uncertain smile.\n\n\"<i>Oh, don't mind me,</i>\" he says, \"<i>I'm just running some tests here.  Was there something you needed, [name]?</i>\"\n\n");
	//player.createStatusEffect(StatusEffects.metRathazul,0,0,0,0);
	eachMinuteCount(5);
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
	spriteSelect(SpriteDb.s_rathazul);
	var totalOffers:int = 0;
	var spoken:Boolean = false;
	var debimbo:Boolean = false;
	var lethiciteDefense:Function = null;
	if (flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] == 1 && flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] < 10) {
		purificationByRathazulBegin();
		return true;
	}
	if (BelisaFollower.BelisaQuestOn && !BelisaFollower.BelisaRalthTalked) {
		BelisaRalthazulTalk();
		return true;
	}
	if (player.hasItem(consumables.BLACKEG) || player.hasItem(consumables.L_BLKEG)) {
		flags[kFLAGS.PC_KNOWS_ABOUT_BLACK_EGGS] = 1;
		spoken = true;
		outputText("He eyes the onyx egg in your inventory and offers a little advice.  \"<i>Be careful with black eggs.  They can turn your skin to living latex or rubber.  The smaller ones are usually safer, but everyone reacts differently.  I'd get rid of them, if you want my opinion.</i>\"\n\n");
	}
	var pCounter:int = 0;
	//Item purification offer
	if(player.hasItem(consumables.INCUBID)) {
		totalOffers++;
		pCounter++;
	}
	if(player.hasItem(consumables.SUCMILK)) {
		totalOffers++;
		pCounter++;
	}
	if(player.hasItem(consumables.SDELITE)) {
		totalOffers++;
		pCounter++;
	}
	if(player.hasItem(consumables.LABOVA_)) {
		totalOffers++;
		pCounter++;
	}
	if(player.hasItem(consumables.MINOCUM)) {
		totalOffers++;
		pCounter++;
	}
	if (pCounter > 0) {
		if (pCounter == 1)
			outputText("The rat mentions, \"<i>I see you have at least one tainted item on you... for 20 gems I could remove most of the taint, making it a good deal safer to use.  Of course, who knows what kind of freakish transformations it would cause...</i>\"\n\n");
		else
			outputText("The rat mentions, \"<i>I see you have a number of demonic items on your person.  For 20 gems I could attempt to remove the taint from one of them, rendering it a good deal safer for consumption.  Of course it would not remove most of the transformative properties of the item...</i>\"\n\n");
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
		spoken = true;
		totalOffers++;
	}
	//Pro Lactaid & Centaurinum & Scorpinum
	if (player.statusEffectv2(StatusEffects.MetRathazul) >= 5) {
		outputText("The rat mentions, \"<i>You know, I could make something new if you're willing to hand over two of vials labeled \"Equinum\", one vial of minotaur blood and one hundred gems. Or two vials of Bee Honey, two vials of Snake Oil and 100 gems. Or five bottles of Lactaid and two bottles of purified LaBova along with 250 gems.</i>\"\n\n");
		spoken = true;
		totalOffers++;
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
	if(player.hasKeyItem("Marae's Lethicite") >= 0 && player.keyItemvX("Marae's Lethicite", 1) > 0 && !player.hasStatusEffect(StatusEffects.DefenseCanopy) && player.hasStatusEffect(StatusEffects.CampRathazul)) {
		outputText("His eyes widen in something approaching shock when he sees the Lethicite crystal you took from Marae.  Rathazul stammers, \"<i>By the goddess... that's the largest piece of lethicite I've ever seen.  I don't know how you got it, but there is immense power in those crystals.  If you like, I know a way we could use its power to grow a canopy of thorny vines that would hide the camp and keep away imps.  Growing such a defense would use a third of that lethicite's power.</i>\"\n\n");
		totalOffers++;
		spoken = true;
		lethiciteDefense = growLethiciteDefense;
	}
	if(player.hasStatusEffect(StatusEffects.CampRathazul)) {
	if(flags[kFLAGS.RATHAZUL_DEBIMBO_OFFERED] == 0 && (sophieBimbo.bimboSophie() || flags[kFLAGS.JOJO_BIMBO_STATE] == 3 || (flags[kFLAGS.EXCELLIA_RECRUITED] > 2 && flags[kFLAGS.EXCELLIA_RECRUITED] < 33) || player.hasPerk(PerkLib.BroBrains) || player.hasPerk(PerkLib.BimboBrains) || player.hasPerk(PerkLib.FutaFaculties))) {
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
		if (flags[kFLAGS.SAMIRAH_FOLLOWER] == 6) rathazulReptaTonguePotionOffer();
		if (flags[kFLAGS.ELECTRA_FOLLOWER] == 2 && !player.hasStatusEffect(StatusEffects.ElectraOff) && player.hasItem(useables.RPLASMA, 1)) rathazulAlchemicalThunderOffer();
	}
	if(totalOffers == 0 && spoken) {
		doNext(camp.returnToCampUseOneHour);
		return true;
	}
	if(totalOffers > 0) {
		outputText("Will you take him up on an offer or leave?");
		//In camp has no time passage if left.
		menu();
		//Shop sub-menu
		if (dyes || philters || reductos)
			addButton(0, "Shop", rathazulShopMenu).hint("Check Rathazul's wares.");
		else
			addButtonDisabled(0, "Shop", "You can't afford anything Rathazul has to offer.");
		addButton(1, "Purify", purifySomething).hint("Ask him to purify any tainted potions. \n\nCost: 20 Gems.");
		if (BelisaFollower.BelisaRalthTalked && BelisaFollower.BelisaFollowerStage == 0) {
			if (player.hasItem(consumables.SHARK_T) && player.hasItem(consumables.PPHILTR) && player.hasItem(consumables.VITAL_T)) addButton(3, "C.CurePotion", RathazulMakesToothCursePotion).hint("Ask him to make cure curse cure potion. \n\nNeeds shark tooth, purity philter and vitality tincture");
			else addButtonDisabled(3, "C.CurePotion", "Ask him to make cure curse cure potion. \n\nNeeds shark tooth, purity philter and vitality tincture");
		}
		if (dyes && player.hasItem(consumables.REPTLUM, 1) && flags[kFLAGS.ARIAN_SCALES] > 0) addButton(4, "Make Dye", makeDyes).hint("Ask him to make a special dye for you. (Only dyes here are for Arian) \n\nCost: 50 Gems.");
		if (player.hasItem(consumables.BEEHONY)) addButton(5, consumables.PURHONY.shortName, rathazulMakesPureHoney).hint("Ask him to distill a vial of bee honey into a pure honey. \n\nCost: 25 Gems \nNeeds 1 vial of Bee Honey");
		if (debimbo) addButton(6, "Debimbo", makeADeBimboDraft).hint("Ask Rathazul to make a debimbofying potion for you. \n\nCost: 250 Gems \nNeeds 5 Scholar Teas.");
		if (flags[kFLAGS.ELECTRA_FOLLOWER] > 2 && !player.hasStatusEffect(StatusEffects.ElectraOff)) {
		if (player.hasItem(useables.RPLASMA, 2) && player.hasItem(consumables.L_DRAFT, 1)) addButton(7, "Alch.Thun.", makeAlchemicalThunder).hint("Ask him to help Mitzi. \n\nNeeds two raiju plasmas and one lust draft");
			else addButtonDisabled(7, "Alch.Thun.", "Need to gather two raiju plasmas and one lust draft for this.");
		}
		if (flags[kFLAGS.MITZI_RECRUITED] == 2) {
			if (player.hasItem(consumables.SMART_T, 5) && player.hasItem(consumables.VITAL_T, 5) && player.hasItem(consumables.S_WATER, 1) && player.hasItem(consumables.PURHONY, 1)) addButton(8, "Mitzi", cureMitzi).hint("Ask him to help Mitzi. \n\nNeeds five scholar teas, five vitality tinctures, one bottle of pure spring water, and one vial of pure honey");
			else addButtonDisabled(8, "Mitzi", "Need to gather five scholar teas, five vitality tinctures, one bottle of pure spring water, and one vial of pure honey for this.");
		}
		if (flags[kFLAGS.SAMIRAH_FOLLOWER] == 7) {
			if (player.hasItem(consumables.HUMMUS_, 1) && player.hasItem(consumables.REPTLUM, 1) && player.hasItem(consumables.OVIELIX, 1)) addButton(9, "ReptaTongue P", makeReptaTonguePotion).hint("Ask him to make Repta-Tongue Potion. \n\nNeeds 1 Hummus, 1 Reptilium and 1 Ovi Elixir");
			else addButtonDisabled(9, "ReptaTongue P", "Need to gather 1 Hummus, 1 Reptilium and 1 Ovi Elixir for this potion.");
		}
		if (player.hasItem(consumables.PURHONY, 1) && player.hasItem(consumables.C__MINT, 1) && player.hasItem(consumables.PURPEAC, 1) && player.hasKeyItem("Rathazul's Purity Potion") < 0 &&(flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] == 2 && flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] < 10)) {
			addButton(10, "Pure Potion", rathazulMakesPurifyPotion).hint("Ask him to brew a purification potion for Minerva.");
		}
		if (TyrantiaFollower.TyrantiaFollowerStage == 5) addButton(12, "Tyrantia", TyrantiaEggQuestRathazul);
		if (lethiciteDefense != null) addButton(13, "Lethicite", lethiciteDefense).hint("Ask him if he can make use of that lethicite you've obtained from Marae.");
		if (player.hasStatusEffect(StatusEffects.CampRathazul)) addButton(14,"Leave", camp.campFollowers);
		else addButton(14, "Leave", camp.returnToCampUseOneHour);
		return true;
	}
	return false;
}

private function TyrantiaEggQuestRathazul():void {
	clearOutput();
	outputText("You walk to the old mouse alchemist, your heart slightly heavy. You know that Tyrantia’s been trying to purify herself through his Philters, and it hasn’t worked so far. Despite this, you feel like going to him is worth a shot.\n\n");
	outputText("\"<i>What can I help you with, [name]?</i>\" The old alchemist asks. You tell him about Tyrantia’s conversation with you. Your desire to have a family with her, but the fear and doubt that your Drider lover has about foisting her corruption onto a child. Even worse, what that child or children could do to the world if someone without Tyrantia’s willpower was given the corrupting aura.\n\n");
	outputText("\"<i>Ah, yes. I understand perfectly.</i>\" He thinks for a moment, then looks at you. \"<i>Well...As a matter of fact, I might be able to help.</i>\" He scratches the top of his head. \"<i>Spider eggs are permeable, and so if Drider eggs share similar properties, then I could potentially whip up a batch of my purity Philter that could purify any unborn within the egg.</i>\" ");
	outputText("He smiles. \"<i>I’ve run studies with other people’s corruption. Children, while they’re very young, or at least have a young body, are very susceptible to corruption or purification, due to the fact that there’s less of them.</i>\" He rubs his hands together, somewhat excited. \"<i>I have every confidence that this will work.</i>\"\n\n");
	outputText("You bring Ralthazul back to Tyrantia, and you ask him to fill her in. The old mouse puts a hand on Tyrantia’s leg, telling her what he told you. Your giantess looks at you, eyes gleaming, and both hands in front of her mouth.\n\n");
	outputText("\"<i>Really?!</i>\" She pats the alchemist’s head, somewhat dazed. \"<i>...I...Okay.</i>\" She turns to you, inhaling nervously. \"<i>...I trust you. If you think Ralthzul can stop me from ruining our podlings, then...I’ll do it.</i>\"\n\n");
	TyrantiaFollower.TyrantiaFollowerStage = 6;
	eachMinuteCount(15);
	doNext(playerMenu);
}

private function purifySomething():void {
	spriteSelect(SpriteDb.s_rathazul);
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
	if (!debug) player.destroyItems(consumables.INCUBID, 1);
	inventory.takeItem(consumables.P_DRAFT, returnToRathazulMenu);
	player.gems -= 20;
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}

//For Belisa's Tooth Quest
public function BelisaRalthazulTalk():void {
	outputText("Hoping your trusty alchemist friend can make Belisa's smile whole again, You ask Ralthazul about curing a cursed injury. \"<i>Oh? Cursed injury, you say?</i>\" He ponders for a second. \"<i>What sort of injury, and what kind of curse?</i>\"\n\n"); 
	outputText("You explain Belisa’s plight, and he nods thoughtfully, hand on his chin. \"<i>Well…As a matter of fact, there might be a way I can help, young one.</i>\" He brings you over to his beakers excitedly. \"<i>You see, Succubus magic tends to draw upon corruption, and long-term curses…well, they’re niggly little bits of magic.</i>\" He shakes his head. \"<i>If the Succubus in question was a practiced hexmage, they’ll know how to get around this…But if they weren’t…</i>\" He gives you a wry little grin. \"<i>Standard curses of that nature draw upon corruption, if not from the individual, than from the environment around them.</i>\" He rummages around, producing a purity philter. \"<i>However, this little mixture here can cut the curse off from the environment, if you cover the wound in it, starving it out.</i>\"\n\n"); 
	outputText("You begin to get excited. Belisa is pure. Perhaps too pure. You know her body won’t give this magic any fuel.\n\n"); 
	outputText("\"<i>But…I’ll need other ingredients to cure the actual injury. Unless we also heal the injury, the curse will just return once it absorbs enough corrupted energy.</i>\" He nods. \"<i>I can do it. I’ll need a shark’s tooth from the lake, one of my purity philter and one vitality tincture.</i>\"\n\n"); 
	BelisaFollower.BelisaRalthTalked = true;
	doNext(camp.returnToCampUseOneHour);
}

private function RathazulMakesToothCursePotion():void {
	clearOutput();
	player.destroyItems(consumables.SHARK_T, 1);
	player.destroyItems(consumables.PPHILTR, 1);
	player.destroyItems(consumables.VITAL_T, 1);
	outputText("You run over to Ralthazul, showing him the ingredients you’ve obtained in your adventures. \"<i>Alright, that should do it. Give me just a moment please.\"</i> The wizened alchemist grinds up the teeth, and begins to mix the ingredients together. You take a small stroll around the camp to let him work, and within fifteen short minutes, Ralthazul comes to you, a smile on his old face. \n\n");
	outputText("\"<i>Remember, you must completely submerge the injury in the mixture. And it needs some time to work.\"</i> He blinks, remembering something. \"<i>Oh, and this will hurt, in all probability. Most curses don’t go easily, and the mouth is rather sensitive.\"</i> He passes you a small vial of a silver-white liquid, with streaks of red running through it. \"<i>An hour, at least. Depending on the curse’s power.\"</i> \n\n");
	BelisaFollower.BelisaFollowerStage = 1;
	doNext(camp.returnToCampUseOneHour);
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
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	if(flags[kFLAGS.RATHAZUL_DEBIMBO_OFFERED] == 0) {
        if (player.hasPerk(PerkLib.BimboBrains) || player.hasPerk(PerkLib.FutaFaculties)) {
            outputText("\n\nRathazul glances your way as you approach his lab, a thoughtful expression on his age-lined face.  \"<i>Tell me [name], do you truly enjoy living your life under the debilitating effects of that cursed potion?  Even now the spark of intelligence has all but left from your eyes.  Do you even understand what I'm saying?</i>\"");
            outputText("\n\nYou twirl a lock of hair around your finger and giggle.  This silly old rat thinks you're like, dumb and stuff!  He just doesn't know how great it is to have a rocking body and a sex-drive that's always ready to suck and fuck.  It's so much fun!  You look back at the rat, realizing you haven't answered him yet, feeling a bit embarrassed as he sighs in disappointment.");
            outputText("\n\n\"<i>Child, please... bring me five Scholar's Teas and 250 gems for reagents, then I can fix you!  I can help you!  Just... get the tea!</i>\" the alchemist pleads, counting off to five on his clawed fingers for extra emphasis while shaking his gem pouch profusely.  You bite your lower lip— he seems really really mad about this or something.  Maybe you should like, get the tea?");
        }
        else if (player.hasPerk(PerkLib.BroBrains)) {
            outputText("\n\nRathazul glances your way as you approach his lab, a thoughtful expression on his age-lined face.  \"<i>I see you happen to have drank a can of Bro Brew in the past. If you ever need me to restore your intelligence capabilities, bring me five scholar teas and 250 gems. Thanks Marae you're not a bimbo; that would have been worse.</i>\"");
        }
		else {
			outputText("Rathazul glances your way as you approach his lab, a thoughtful expression on his age-lined face.  \"<i>Tell me, [name], do you truly enjoy having that vacuous idiot around, lusting after you at all hours of the day?</i>\" he asks, shaking his head in frustration.  \"<i>She's clearly been subjected to the effects of Bimbo Liqueur, which as you can plainly see are quite indeed potent.  However, like most things in Mareth, it can be countered - at least partially.</i>\"  Rathazul folds his long, clawed fingers together, his tail lashing behind him as he thinks.  \"<i>Perhaps with a sufficient quantity of something called Scholar's Tea... I could counter the stupefying effects of the elixir... oh my, yes... hmm...</i>\"  Rathazul nods, stroking at the few long wisps of fur that hang from his chin.");
			outputText("\n\nYou await");
			if (silly()) outputText(" getGoodPost()"); // C# await joke ;_; http://msdn.microsoft.com/en-gb/library/hh156528.aspx
			outputText(" further clarification, but the old rat just stands there, staring off into space.  Coughing politely, you reacquire his attention, causing him to jump.");
			outputText("\n\n\"<i>Oh?  Nmm, YES, bimbos, that's right!  As I was saying, five Scholar's Teas along with 250 gems for other reagents should give me all I need to create a bimbo-beating brew!  Oh my, the alliteration!  How absurd.</i>\"  Rathazul chuckles slowly, wiping a drop from his eye before he looks back at you fiercely, \"<i>It is a worthwhile goal - no creature should be subjected to a reduced intellect.  Let me know when you have acquired what is needed.</i>\"");
		}
		flags[kFLAGS.RATHAZUL_DEBIMBO_OFFERED]++;
	}
	//Rath menu
	menu();
	addButton(0,"Next",campRathazul);
}

private function rathazulAlchemicalThunderOffer():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText("\"<i>I have been studying the fluids produced by your raiju friend and I may be able to produce a powerful substance that would add the fulgurating property of Raiju lightning to your weapon. Provide me with two Raiju Plasma and a Lust Draft and I will create some for you.</i>\"\n\n");
	flags[kFLAGS.ELECTRA_FOLLOWER] = 3;
	//Rath menu
	menu();
	addButton(0,"Next",campRathazul);
}
private function makeAlchemicalThunder():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	player.consumeItem(useables.RPLASMA, 2);
	player.consumeItem(consumables.L_DRAFT, 1);
	outputText("You hand over the ingredients and Rathazul gets to work, heating and mixing the things. Eventually he hands you what appears to be a set of purple vials.\n\n");
	outputText("\"<i>Apply those to your weapon before a fight, I promise you it will be most efficient especially against underwater creatures.</i>\"\n\n");
	inventory.takeItem(consumables.ALCTHUN, makeAlchemicalThunder1);
}
private function makeAlchemicalThunder1():void {
	inventory.takeItem(consumables.ALCTHUN, makeAlchemicalThunder2);
}
private function makeAlchemicalThunder2():void {
	inventory.takeItem(consumables.ALCTHUN, makeAlchemicalThunder3);
}
private function makeAlchemicalThunder3():void {
	inventory.takeItem(consumables.ALCTHUN, makeAlchemicalThunder4);
}
private function makeAlchemicalThunder4():void {
	inventory.takeItem(consumables.ALCTHUN, returnToRathazulMenu);
}

private function cureMitzi():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	player.consumeItem(consumables.SMART_T, 5);
	player.consumeItem(consumables.VITAL_T, 5);
	player.consumeItem(consumables.S_WATER, 1);
	player.consumeItem(consumables.PURHONY, 1);
	outputText("You turn over the items Rathazul requested. He takes them and pours the tea, tinctures, and spring water into a mixing bowl. He stirs it together then adds in just a few drops of pure honey, turning the brew a bright purple.\n\n");
	outputText("\"<i>Let's hope this will be enough...</i>\"\n\n");
	outputText("He picks up the bowl then takes it over to Mitzi. You lean over the drugged up goblin and help her sit up. The elder rat holds the bowl to her lips. Mitzi unconsciously gulps down the bowl's contents until it's all gone. Not even a moment after she finishes the brew, her body convulses and shakes. She clutches her head and groans as the brew works to expel the demonic concoction from her system. You hold her close as the tremors in her body slowly wind down until she's just left breathing heavily in your grip. Once she finally calms down, she looks up at you, confused. Her eyes noticeably have a spark of clarity. Seems the brew did the trick.\n\n");
	outputText("\"<i>W-What... where am I?</i>\"\n\n");
	outputText("You let her go and explain to the goblin girl her situation. As you go on you notice that she's shivering a bit. You ask her if she's alright.\n\n");
	outputText("\"<i>Y-Yeah… It's just… after so long… Thank you.</i>\"\n\n");
	outputText("Mitzi is grateful for you saving her though you can't help but notice that her breasts seem to have grown to a hefty G cup and her hips more waspish. Even her lips seem even more plump with a long purple tongue slicking out from between them. Rathazul hums in thought.\n\n");
	outputText("\"<i>I see… It seems while the brew did help, the purging of those drugs left an... adverse effect on her body.</i>\"\n\n");
	outputText("The goblin looks at her sizable love pillows and fuller hips in surprise. She squeezed her breasts together then lets them go, making them bounce and wobble. She giggles, enjoying her increased assets.\n\n");
	outputText("\"<i>Now this I can get used to.</i>\"\n\n");
	outputText("At least the goblin isn't upset about it. Now that she is free from the drugs influence, you ask her what she plans to do next. Mitzi's brow furrowed.\n\n");
	outputText("\"<i>Oh… I never really thought about that. After being used by that drider for so long, I thought that would be my life for the rest of my days. That is until you saved me of course.</i>\"\n\n");
	outputText("You can imagine that it would be hard to think about after so long. If she did leave, then she'll more than like just return to the forest with the rest of the goblins lurking there. Then again you could make room in your camp for her though you're not sure what it'll be like to have a resident goblin woman living so close without jumping you for your seed. What will you do?\n\n");
	menu();
	addButton(1,"Make Leave",cureMitziMakeLeave);
	addButton(3,"Stay",cureMitziStay);
}
private function cureMitziMakeLeave():void {
    clearOutput();
	outputText("You may have saved the goblin but you certainly don't want her to stay here. Mitzi looks shocked with tears starting to well up in her eyes.\n\n");
	outputText("\"<i>B-But I thought since you saved me…</i>\"\n\n");
	outputText("Her shock turns to sadness as she hops off the cot.\n\n");
	outputText("\"<i>And here I thought you were actually a nice "+player.mf("guy","girl")+" but I guess I was wrong… again…</i>\"\n\n");
	outputText("She turns and then walks out of Rathazul's lab. She heads towards the forest, sparing one last glance over shoulder before disappearing into the distance. You shake your head, thinking you'll more than likely never see her again. Not much you can do now that she's gone.\n\n");
	flags[kFLAGS.MITZI_RECRUITED] = 3;
	menu();
	addButton(0,"Next",campRathazul);
}
private function cureMitziStay():void {
    clearOutput();
	outputText("Well, since she doesn't have anywhere to go, she can always stay here in your camp. She looks up at you in shock.\n\n");
	outputText("\"<i>You mean it? I can really stay here with you?</i>\"\n\n");
	outputText("You nod your head, ensuring her it's okay with the promise that she doesn't make a nuisance of herself. Her smile widens as she leaps from her cot and "+(player.tallness > 48 ? "tries to wrap her arms around you to hug, squishing her large breast against you":"tackles you into a hug")+".\n\n");
	outputText("\"<i>Thank you, uh… ummm… I don't think I caught your name before.</i>\"\n\n");
	outputText("You tell her your name.\n\n");
	outputText("\"<i>Thank you [name]... I swear I won't cause any trouble!</i>\"\n\n");
	outputText("Mitzi hops off the cot and thanks Rathazul before heading out of the lab. She shoots you a flirtatious wink over her shoulder then heads into camp. It's obvious she wants something more from you. The elder rat shakes his head.\n\n");
	outputText("\"<i>Honestly, [name]. You find the strangest people out there.</i>\"\n\n");
	outputText("(<b>Mitzi has been added to the Followers menu!</b>)\n\n");
	flags[kFLAGS.MITZI_RECRUITED] = 4;
	menu();
	addButton(0,"Next",campRathazul);
}

private function rathazulReptaTonguePotionOffer():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText("You mention the desert naga to Rathazul who look at you somewhat surprised.\n\n\"<i>Well that is an odd request? You need me to craft a potion that will allow some naga to understand the common language? Yes I can do that, but it would require some pretty rare ingredients such as hummus, reptilium, and one ovi elixir. Get me those three and I will make the potion for you.</i>\"\n\n");
	flags[kFLAGS.SAMIRAH_FOLLOWER] = 7;
	//Rath menu
	menu();
	addButton(0,"Next",campRathazul);
}
private function makeReptaTonguePotion():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText("Rathazul picks up the hummus, the reptilium and the ovi elixir before mixing them up in his alchemical equipment. He hands you the potion and get back to his things. You realise he didn’t mix in the ovi elixir and you are about to ask him about it when you see that weird gleam in his eyes as he mix it with firemander whisky and what might be a massive dose of lust draft. You back down, some things are better left unknown...");
	outputText("\n\n<b>Acquired Repta-Tongue potion</b>");
	player.consumeItem(consumables.HUMMUS_, 1);
	player.consumeItem(consumables.REPTLUM, 1);
	player.consumeItem(consumables.OVIELIX, 1);
	flags[kFLAGS.SAMIRAH_FOLLOWER] = 8;
	//Rath menu
	menu();
	addButton(0,"Next",campRathazul);
}

//Creation Of The Draft:*
private function makeADeBimboDraft():void {
	clearOutput();
	spriteSelect(SpriteDb.s_rathazul);
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
		addButton(5, consumables.NUMBOIL.shortName, buyPuritySomething, consumables.NUMBOIL);
		addButton(6, consumables.PPHILTR.shortName, buyPuritySomething, consumables.PPHILTR);
	}
	else {
		addButtonDisabled(5, consumables.NUMBOIL.shortName, "You can't afford to buy this.\n\n100 gems required.");
		addButtonDisabled(6, consumables.PPHILTR.shortName, "You can't afford to buy this.\n\n100 gems required.");
	}
	if (player.gems >= 12) addButton(7, consumables.H_PILL.shortName, buyPuritySomething1, consumables.H_PILL);
	else addButtonDisabled(7, consumables.H_PILL.shortName, "You can't afford to buy this.\n\n12 gems required.");
	if (player.level >= 24) {
		if (player.gems >= 30) addButton(8, consumables.MH_PILL.shortName, buyPuritySomething2, consumables.MH_PILL);
		else addButtonDisabled(8, consumables.MH_PILL.shortName, "You can't afford to buy this.\n\n30 gems required.");
	}
	else addButtonDisabled(8, "???", "Required to be lvl 24+ for this.");
	if (player.level >= 42) {
		if (player.gems >= 85) addButton(9, consumables.BH_PILL.shortName, buyPuritySomething3, consumables.BH_PILL);
		else addButtonDisabled(9, consumables.BH_PILL.shortName, "You can't afford to buy this.\n\n85 gems required.");
	}
	else addButtonDisabled(9, "???", "Required to be lvl 42+ for this.");
	if (player.statusEffectv2(StatusEffects.MetRathazul) >= 5) addButton(10, "ProLactaid", rathazulMakesMilkPotion).hint("Ask him to brew a special lactation potion. \n\nCost: 250 Gems \nNeeds 5 Lactaids and 2 Purified LaBovas.");
	if (player.statusEffectv2(StatusEffects.MetRathazul) >= 5) addButton(11, "Scorpinum", rathazulMakesScorpioPotion).hint("Ask him to brew a special potion that could aid in gaining scorpion tail. \n\nCost: 100 Gems \nNeeds 2 vials of Bee Honey and 2 vials of Snake Oil.");
	addButton(14, "Back", returnToRathazulMenu);
}
//Hair dyes
private function buyDyes(fromPage2:Boolean = false):void {
	clearOutput();
	if (!fromPage2) {
		spriteSelect(SpriteDb.s_rathazul);
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
		addButton(9, "Green", buyDye, consumables.GREEN_D);
		addButton(10, "Orange", buyDye, consumables.ORANGDY);
		addButton(11, "Purple", buyDye, consumables.PURPDYE);
		addButton(12, "Pink", buyDye, consumables.PINKDYE);
	}
	addButton(13, "Reagent", buyDye, useables.REAGENT);
	addButton(14, "Nevermind", buyDyeNevermind);
}
private function buyDyesPage2():void {
	clearOutput();
	if (player.statusEffectv2(StatusEffects.MetRathazul) < 8) { // Failsafe, should probably never happen (Stadler76)
		buyDyes(true);
		return;
	}
	spriteSelect(SpriteDb.s_rathazul);
	menu();
	addButton(0, "Russet", buyDye, consumables.RUSSDYE);
	if (player.statusEffectv2(StatusEffects.MetRathazul) >= 12) {
		addButton(1, "Rainbow", buyDye, consumables.RAINDYE);
	}
	addButton(4, "Previous", buyDyes, true);
	addButton(14, "Nevermind", buyDyeNevermind);
 }

private function buyDye(dye:ItemType):void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText(images.showImage("rathazul-buy-dye"));
	inventory.takeItem(dye, rathazulShopMenu);
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}

private function buyDyeNevermind():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText("You change your mind about the dye, and Rathazul returns your gems.\n\n<b>(+50 Gems)</b>");
	player.gems += 50;
	statScreenRefresh();
	doNext(rathazulShopMenu);
}

//Scales dyes
private function makeDyes():void {
	spriteSelect(SpriteDb.s_rathazul);
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
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	player.destroyItems(consumables.REPTLUM, 1);
	player.destroyItems(consumables.WHITEDY, 1);
	outputText(images.showImage("rathazul-buy-dye"));
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	inventory.takeItem(useables.VIALCLE, rathazulShopMenu);
}

private function makeDye2():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	player.destroyItems(consumables.REPTLUM, 1);
	player.destroyItems(consumables.BLUEDYE, 1);
	outputText(images.showImage("rathazul-buy-dye"));
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	inventory.takeItem(useables.VIALTUR, rathazulShopMenu);
}

private function makeDye3():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	player.destroyItems(consumables.REPTLUM, 1);
	player.destroyItems(consumables.PINKDYE, 1);
	outputText(images.showImage("rathazul-buy-dye"));
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	inventory.takeItem(useables.VIALPIN, rathazulShopMenu);
}

private function makeDye4():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	player.destroyItems(consumables.REPTLUM, 1);
	player.destroyItems(consumables.RAINDYE, 1);
	outputText(images.showImage("rathazul-buy-dye"));
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	inventory.takeItem(useables.VIALRAI, rathazulShopMenu);
}

private function makeDyeNevermind():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText("You change your mind about the dye, and Rathazul returns your gems.\n\n<b>(+50 Gems)</b>");
	player.gems += 50;
	statScreenRefresh();
	doNext(rathazulShopMenu);
}

//Skin Oils
private function buyOils():void {
	spriteSelect(SpriteDb.s_rathazul);
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
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText(images.showImage("rathazul-buy-oil"));
	inventory.takeItem(oil, rathazulShopMenu);
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}

private function buyOilNevermind():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText("You change your mind about the oil, and Rathazul returns your gems.\n\n<b>(+50 Gems)</b>");
	player.gems += 50;
	statScreenRefresh();
	doNext(rathazulShopMenu);
}

//Body Lotions
private function buyLotions():void {
	spriteSelect(SpriteDb.s_rathazul);
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
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText(images.showImage("rathazul-buy-lotion"));
	inventory.takeItem(lotion, rathazulShopMenu);
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}

private function buyLotionNevermind():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText("You change your mind about the lotion, and Rathazul returns your gems.\n\n<b>(+50 Gems)</b>");
	player.gems += 50;
	statScreenRefresh();
	doNext(rathazulShopMenu);
}

//Reducto
private function buyReducto():void {
	spriteSelect(SpriteDb.s_rathazul);
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
	spriteSelect(SpriteDb.s_rathazul);
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
	private function buyPuritySomething1(item:ItemType):void {
		clearOutput();
		player.gems -= 12;
		statScreenRefresh();
		inventory.takeItem(item, rathazulShopMenu);
		player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	}
	private function buyPuritySomething2(item:ItemType):void {
		clearOutput();
		player.gems -= 30;
		statScreenRefresh();
		inventory.takeItem(item, rathazulShopMenu);
		player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	}
	private function buyPuritySomething3(item:ItemType):void {
		clearOutput();
		player.gems -= 85;
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
	spriteSelect(SpriteDb.s_rathazul);
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
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText("Rathazul asks, \"<i>Are you absolutely sure?  Growing this thorn canopy as a defense will use one third of the crystal's power.</i>\"\n\n(Do you have Rathazul use the crystal to grow a defensive canopy?)");
	doYesNo(growLethiciteDefenseYesYesYes, growLethiciteDefenseGuessNot);
}

private function growLethiciteDefenseYesYesYes():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText("Rathazul nods and produces a mallet and chisel from his robes.  With surprisingly steady hands for one so old, he holds the chisel against the crystal and taps it, easily cracking off a large shard.  Rathazul gathers it into his hands before slamming it down into the dirt, until only the smallest tip of the crystal is visible.  He produces vials of various substances from his robe, as if by magic, and begins pouring them over the crystal.  In a few seconds, he finishes, and runs back towards his equipment.\n\n\"<i>You may want to take a step back,</i>\" he warns, but before you have a chance to do anything, a thick trunk covered in thorny vines erupts from the ground.  Thousands of vine-like branches split off the main trunk as it reaches thirty feet in the air, radiating away from the trunk and intertwining with their neighbors as they curve back towards the ground.  In the span of a few minutes, your camp gained a thorn tree and a thick mesh of barbed vines preventing access from above.");
	player.createStatusEffect(StatusEffects.DefenseCanopy, 0, 0, 0, 0);
	player.addKeyValue("Marae's Lethicite", 1, -1);
	doNext(playerMenu);
}

private function growLethiciteDefenseGuessNot():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText("Rathazul nods sagely, \"<i>That may be wise.  Perhaps there will be another use for this power.\"</i>");
	doNext(returnToRathazulMenu);
}

public function rathazulAprilFool():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText("Rathazul comes to you all of a sudden, an urgent expression on his face.\n\n");
	outputText("\"<i>Look [name] I know you are very busy but I am in dire need of something only you can do...\"</i>\n\n");
	outputText("Rathazul suddenly drops his pants down revealing his old furry legs which smell like old sewage water. He barely wears any undergarment under that, that old white loincloth stained olive green by the passage of time. You can smell rancid mushrooms growing on his toes… gods above are those warts?!! What about the 'thing' hiding behind the loin cloth. You know Rathazul is good enough at alchemy to brew something just potent enough to give him as many second winds as he could ever want and worst of all he has an endless supply of grow+!\n\n");
	outputText("His face is serious and solemn as he walks toward you, holding the pants, and so you gulp in horror as your mind races and goes on about all the things the dirty old rat could want when…\n\n");
	menu();
	addButton(1, "Next", rathazulAprilFoolPart2);
	addButton(3, "Next", rathazulAprilFoolPart2);
	addButton(7, "Next", rathazulAprilFoolPart2);
	addButton(11, "Next", rathazulAprilFoolPart2);
	addButton(13, "Next", rathazulAprilFoolPart2);
}

private function rathazulAprilFoolPart2():void {
	spriteSelect(SpriteDb.s_rathazul);
	outputText("he suddenly pulls a single vial he was hiding in a pocket on the inside of his pants before putting them back on.\n\n");
	outputText("\"<i>Oh please don't tell me you thought I would ever ask for something like that, I'm way too old! No obviously all I need is for you to go grab water from a fountain of purity somewhere around Mareth. Maybe even deep underground, or in some sort of ancient labyrinth... With this I should be able to create the Purity elixir, my ultimate creation. A concoction that I recall could reverse and undo any corruption. Imagine… this could even perhaps fix any damage the demons did to the world. All I need is a sample to study and I could create as many vials as is necessary.\"</i>\n\n");
	if (player.hasStatusEffect(StatusEffects.RathazulAprilFool)) {
		player.changeStatusValue(StatusEffects.RathazulAprilFool, 1, date.fullYear);
		player.addStatusValue(StatusEffects.RathazulAprilFool, 3, -2);
	}
	else player.createStatusEffect(StatusEffects.RathazulAprilFool, date.fullYear, 0, 0, 0);
	doNext(returnToRathazulMenu);
}

public function rathazulAprilFoolPart3():void {
	spriteSelect(SpriteDb.s_rathazul);
	clearOutput();
	outputText("Rathazul almost steals the vial from your hands and get to work mixing it into a potion.\n\n");
	outputText("\"<i>Here's your purity elixir. Use it with wisdom because it's the only one you will get until I get enough materials to create a second one which considering the rarity of the components is easily going to take me a full year. I definitively need to find a way to mass produce these...\"</i>");
    outputText("\n\n<b>Gained Key Item: Rathazul's Purity Elixir</b>");
	player.addStatusValue(StatusEffects.RathazulAprilFool, 2, 1);
	player.addStatusValue(StatusEffects.RathazulAprilFool, 3, 1);
    if (player.hasKeyItem("Rathazul's Purity Elixir") < 0)
	    player.createKeyItem("Rathazul's Purity Elixir", 1, 0, 0, 0);
    else
        player.addKeyValue("Rathazul's Purity Elixir", 1, 1);
	doNext(returnToRathazulMenu);
}
}
}
