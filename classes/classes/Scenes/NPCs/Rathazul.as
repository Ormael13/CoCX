package classes.Scenes.NPCs{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class Rathazul extends NPCAwareContent implements TimeAwareInterface {

//const RATHAZUL_DEBIMBO_OFFERED:int = 744;

	//Rathazul the Alchemist
	//Encounter, random text for potential uses, choices.
	//After he has crafted 3 things for the player, option to move into camp.
		public function Rathazul()
		{
			CoC.timeAwareClassAdd(this);
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
			if (player.findStatusEffect(StatusEffects.CampRathazul) >= 0)
				campRathazul();
			else encounterRathazul();
		}

public function encounterRathazul():void {
	spriteSelect(49);
	clearOutput();
	if (flags[kFLAGS.MARBLE_PURIFICATION_STAGE] == 2 && player.findStatusEffect(StatusEffects.MetRathazul) >= 0)
	{
		marblePurification.visitRathazulToPurifyMarbleAfterLaBovaStopsWorkin();
		return;
	}
	var offered:Boolean;
	//Rat is definitely not sexy!
	if (player.lust > 30) dynStats("lus", -10);
	//Introduction
	outputText(images.showImage("rathazul-lake"));
	if (player.findStatusEffect(StatusEffects.MetRathazul) >= 0) {
		if (player.findStatusEffect(StatusEffects.CampRathazul) >= 0)
			outputText("You walk over to Rathazul's corner of the camp.  He seems as busy as usual, with his nose buried deep in some tome or alchemical creation, but he turns to face you as soon as you walk within a few paces of him.\n\n");
		else
			outputText("You spy the familiar sight of the alchemist Rathazul's camp along the lake.  The elderly rat seems to be oblivious to your presence as he scurries between his equipment, but you know him well enough to bet that he is entirely aware of your presence.\n\n");
	}
	else {
		outputText("You encounter a hunched figure working as you come around a large bush.  Clothed in tattered robes that obscure most his figure, you can nontheless see a rat-like muzzle protruding from the shadowy hood that conceals most of his form.  A simple glance behind him confirms your suspicions - this is some kind of rat-person.  He seems oblivious to your presence as he stirs a cauldron of viscous fluid with one hand; a neat stack of beakers and phials sit in the dirt to his left.  You see a smile break across his aged visage, and he says, \"<i>Come closer child.  I will not bite.</i>\"\n\nApprehensive of the dangers of this unknown land, you cautiously approach.\n\n\"<i>I am Rathazul the Alchemist.  Once I was famed for my miracle cures.  Now I idle by this lake, helpless to do anything but measure the increasing amounts of corruption that taint its waters,</i>\" he says as he pulls back his hood, revealing the entirety of his very bald and wrinkled head.\n\n");
		player.createStatusEffect(StatusEffects.MetRathazul,0,0,0,0);
	}
	//Camp offer!
	if (player.statusEffectv2(StatusEffects.MetRathazul) >= 3 && player.statusEffectv3(StatusEffects.MetRathazul) != 1 && player.cor < 75) {
		outputText("\"<i>You know, I think I might be able to do this worn-out world a lot more good from your camp than by wandering around this lake.  What do you say?</i>\" asks the rat.\n\n(Move Rathazul into your camp?)", false);
		doYesNo(rathazulMoveToCamp, rathazulMoveDecline);
		//Set rathazul flag that he has offered to move in (1 time offer)
		player.changeStatusValue(StatusEffects.MetRathazul,3,1);
		return;
	}
	offered = rathazulWorkOffer();
	if (!offered) {
		outputText("He sighs dejectedly, \"<i>I am not sure what I can do for you, youngling.  This world is fraught with unimaginable dangers, and you're just scratching the surface of them.</i>\"\n\nYou nod and move on, leaving the depressed alchemist to his sadness.", false);
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
	if (flags[kFLAGS.MARBLE_PURIFICATION_STAGE] == 2 && player.findStatusEffect(StatusEffects.MetRathazul) >= 0)
	{
		marblePurification.visitRathazulToPurifyMarbleAfterLaBovaStopsWorkin();
		return;
	}
	if (flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] == 1 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] > 0) {
		collectSilkArmor();
		return;
	}
	//Special rathazul/follower scenes scenes.
	if (rand(6) == 0 && flags[kFLAGS.RATHAZUL_CAMP_INTERACTION_COUNTDOWN] == 0) {
		flags[kFLAGS.RATHAZUL_CAMP_INTERACTION_COUNTDOWN] = 3;
		//Pure jojo
		if (flags[kFLAGS.JOJO_RATHAZUL_INTERACTION_COUNTER] == 0 && player.findStatusEffect(StatusEffects.PureCampJojo) >= 0 && flags[kFLAGS.JOJO_DEAD_OR_GONE] == 0) {
			finter.jojoOffersRathazulMeditation();
			return;
		}
		if (flags[kFLAGS.AMILY_MET_RATHAZUL] == 0 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower()) {
			finter.AmilyIntroducesSelfToRathazul();
			return;
		}
		if (flags[kFLAGS.AMILY_MET_RATHAZUL] == 1 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower()) {
			finter.amilyIngredientDelivery();
			return;
		}
		if (flags[kFLAGS.AMILY_MET_RATHAZUL] == 2 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower()) {
			finter.amilyAsksAboutRathazulsVillage();
			return;
		}
	}
	var offered:Boolean;
	//Rat is definitely not sexy!
	if (player.lust > 50) dynStats("lus", -1);
	if (player.lust > 65) dynStats("lus", -5);
	if (player.lust > 80) dynStats("lus", -5);
	if (player.lust > 90) dynStats("lus", -5);
	//Introduction
	outputText(images.showImage("rathazul-camp"));
	outputText("Rathazul looks up from his equipment and gives you an uncertain smile.\n\n\"<i>Oh, don't mind me,</i>\" he says, \"<i>I'm just running some tests here.  Was there something you needed, " + player.short + "?</i>\"\n\n");
	//player.createStatusEffect(StatusEffects.metRathazul,0,0,0,0);
	offered = rathazulWorkOffer();
	if (!offered) {
		outputText("He sighs dejectedly, \"<i>I don't think there is.  Why don't you leave me be for a time, and I will see if I can find something to aid you.</i>\"", false);
		if (player.findStatusEffect(StatusEffects.CampRathazul) >= 0)
			doNext(camp.campFollowers);
		else doNext(playerMenu);
	}

}

private function rathazulWorkOffer():Boolean {
	spriteSelect(49);
	var totalOffers:int = 0;
	var spoken:Boolean = false;
	//These variables might go away at a point.
	var showArmorMenu:Boolean = false;
	var dyes:Boolean = false;
	var purify:Boolean = false;
	var philters:Boolean = false;
	var alchemy:Boolean = false;
	var debimbo:Boolean = false;
	var reductos:Boolean = false;
	var lethiciteDefense:Function = null;
	if (flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] == 1 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] > 0) {
		collectSilkArmor();
		return true;
	}
	if (flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] == 1 && flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] < 10) {
		purificationByRathazulBegin();
		return true;
	}
	if (player.hasItem(consumables.BLACKEG) || player.hasItem(consumables.L_BLKEG)) {
		flags[kFLAGS.PC_KNOWS_ABOUT_BLACK_EGGS] = 1;
		spoken = true;
		outputText("He eyes the onyx egg in your inventory and offers a little advice.  \"<i>Be careful with black eggs.  They can turn your skin to living latex or rubber.  The smaller ones are usually safer, but everyone reacts differently.  I'd get rid of them, if you want my opinion.</i>\"\n\n");
	}
	//Item crafting offer
	if (player.hasItem(useables.GREENGL)) { //Green Gel
		if (player.findStatusEffect(StatusEffects.RathazulArmor) < 0) outputText("He pipes up with a bit of hope in his voice, \"<i>I can smell the essence of the tainted lake-slimes you've defeated, and if you'd let me, I could turn it into something a bit more useful to you.  You see, the slimes are filled with the tainted essence of the world-mother herself, and once the taint is burned away, the remaining substance remains very flexible but becomes nearly impossible to cut through.  With the gel of five defeated slimes I could craft you a durable suit of armor.</i>\"", false);
		else outputText("He pipes up with a bit of excitement in his voice, \"<i>With just five pieces of slime-gel I could make another suit of armor...</i>\"", false);
		spoken = true;
		if (player.hasItem(useables.GREENGL,5)) {
			showArmorMenu = true;
			totalOffers++;
		}
		else {
			outputText("\nYou realize you're still a bit short of gel.\n", false);
		}
		outputText("\n\n");
	}
	if (player.hasItem(useables.B_CHITN)) { //Bee Chitin
		outputText("The elderly rat looks at you intently and offers, \"<i>I see you've gathered a piece of chitin from the giant bees of the forests.  If you bring me five pieces I could probably craft it into some tough armor.</i>\"", false);
		spoken = true;
		if (player.hasItem(useables.B_CHITN, 5)) {
			showArmorMenu = true;
			totalOffers++;
		}
		else {
			outputText("\nYou realize you're still a bit short of chitin.", false);
		}
		outputText("\n\n");
	}
	if (player.hasItem(useables.T_SSILK) && flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] == 0) { //SPOIDAH
		showArmorMenu = true;
		spoken = true;
		totalOffers++;
		outputText("\"<i>Oooh, is that some webbing from a giant spider or spider-morph?  Most excellent!  With a little bit of alchemical treatment, it is possible I could loosen the fibers enough to weave them into something truly magnificent - armor, or even a marvelous robe,</i>\" offers Rathazul.\n\n", false);
	}
	if (player.hasItem(useables.D_SCALE)) { //Dragonscale
		showArmorMenu = true;
		totalOffers++;
		outputText("\"<i>Oooh, is that dragon scale? If you happen to have five of these, I can work them into armor,</i>\" Rathazul says.\n\n");
	}
	//Marae bark armor
	if (player.hasKeyItem("Tentacled Bark Plates") >= 0 || player.hasKeyItem("Divine Bark Plates") >= 0) showArmorMenu = true;
	var pCounter:int = 0;
	//Item purification offer
	if (player.hasItem(consumables.INCUBID))
		pCounter++;
	if (player.hasItem(consumables.SUCMILK))
		pCounter++;
	if (player.hasItem(consumables.SDELITE))
		pCounter++;
	if (player.hasItem(consumables.LABOVA_))
		pCounter++;
	if (player.hasItem(consumables.MINOCUM))
		pCounter++;
	if (pCounter > 0) {
		if (pCounter == 1) 
			outputText("The rat mentions, \"<i>I see you have at least one tainted item on you... for 20 gems I could remove most of the taint, making it a good deal safer to use.  Of course, who knows what kind of freakish transformations it would cause...</i>\"\n\n", false);
		else
			outputText("The rat mentions, \"<i>I see you have a number of demonic items on your person.  For 20 gems I could attempt to remove the taint from one of them, rendering it a good deal safer for consumption.  Of course it would not remove most of the transformative properties of the item...</i>\"\n\n", false);
		purify = true;
		spoken = true;
		totalOffers += pCounter;
	}
	//Offer dyes if offering something else.
	if (player.gems >= 50) {
		outputText("Rathazul offers, \"<i>Since you have enough gems to cover the cost of materials for my dyes as well, you could buy one of my dyes for your hair.  ", false);
		if (player.statusEffectv2(StatusEffects.MetRathazul) >= 8) outputText("I should be able to make exotic-colored dyes if you're interested.  ");
		outputText("Or if you want some changes to your skin, I have skin oils and body lotions.  I will need 50 gems up-front.</i>\"\n\n");
		dyes = true;
		spoken = true;
		totalOffers++;
	}
	//Offer purity philter and numbing oil.
	if (player.gems >= 100) {
		outputText("Rathazul offers, \"<i>I can make something for you. Something to counter the corruption of this realm and if you're feeling too sensitive, I have these oils. I'll need 100 gems up-front.</i>\"");
		philters = true;
		spoken = true;
		totalOffers++;
	}
	//Bee honey
	if (player.hasItem(consumables.BEEHONY)) {
		outputText("Rathazul offers, \"<i>If you're in need of a pure honey, I can distill the regular bee honey. You'll also need 20 gems up front.</i>\"\n\n");
		spoken = true;
		alchemy = true;
		totalOffers++;
	}
	//Pro Lactaid & Taurinum
	if (player.statusEffectv2(StatusEffects.MetRathazul) >= 5) {
		outputText("The rat mentions, \"<i>You know, I could make something new if you're willing to hand over two of vials labeled \"Equinum\", one vial of minotaur blood and one hundred gems. Or five bottles of Lactaid and two bottles of purified LaBova along with 250 gems.</i>\"\n\n");
		spoken = true;
		alchemy = true;
		totalOffers++;
	}
	//Reducto
	if (player.findStatusEffect(StatusEffects.CampRathazul) >= 0 && player.statusEffectv2(StatusEffects.MetRathazul) >= 4) {
		outputText("The rat hurries over to his supplies and produces a container of paste, looking rather proud of himself, \"<i>Good news everyone!  I've developed a paste you could use to shrink down any, ah, oversized body parts.  The materials are expensive though, so I'll need ");
		if (flags[kFLAGS.AMILY_MET_RATHAZUL] >= 2) outputText("50");
		else outputText("100");
		outputText(" gems for each jar of ointment you want. And if you're, ah, not feeling big enough, I've also developed a liquid that you inject. The materials are expensive too so it's the same price for each needle.</i>\"\n\n");
		totalOffers++;
		spoken = true;
		reductos = true;
	}
	//Vines
	if (player.keyItemv1("Marae's Lethicite") > 0 && player.findStatusEffect(StatusEffects.DefenseCanopy) < 0 && player.findStatusEffect(StatusEffects.CampRathazul) >= 0) {
		outputText("His eyes widen in something approaching shock when he sees the Lethicite crystal you took from Marae.  Rathazul stammers, \"<i>By the goddess... that's the largest piece of lethicite I've ever seen.  I don't know how you got it, but there is immense power in those crystals.  If you like, I know a way we could use its power to grow a canopy of thorny vines that would hide the camp and keep away imps.  Growing such a defense would use a third of that lethicite's power.</i>\"\n\n");
		totalOffers++;
		spoken = true;
		lethiciteDefense = growLethiciteDefense;
	}
	if (player.findStatusEffect(StatusEffects.CampRathazul) >= 0) {
		if (flags[kFLAGS.RATHAZUL_DEBIMBO_OFFERED] == 0 && (sophieBimbo.bimboSophie() || player.findPerk(PerkLib.BroBrains) >= 0 || player.findPerk(PerkLib.BimboBrains) >= 0 || player.findPerk(PerkLib.FutaFaculties) >= 0)) {
			rathazulDebimboOffer();
			return true;
		}
		else if (flags[kFLAGS.RATHAZUL_DEBIMBO_OFFERED] > 0) {
			outputText("You recall that Rathazul is willing to make something to cure bimbo liqueur for 250 gems and five Scholar's Teas.");
			if (player.hasItem(consumables.SMART_T,5) && player.gems >= 250) {
				totalOffers++;
				debimbo = true;
				alchemy = true;
			}
			else if (!player.hasItem(consumables.SMART_T,5)) outputText("  You should probably find some if you want that...");
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
	if (totalOffers == 0 && spoken) {
		doNext(camp.returnToCampUseOneHour);
		return true;
	}
	if (totalOffers > 0) {
		outputText("Will you take him up on an offer or leave?", false);
		//In camp has no time passage if left.
		menu();
		var button:int = 5; //After the 8th button, the menus will dynamically fill in.
		//Armour sub-menu
		if (showArmorMenu)
			addButton(0, "Armor", rathazulArmorMenu, null, null, null, "Ask Rathazul to make an armour for you.");
		else
			addButtonDisabled(0, "Armor", "You don't have sufficient materials that can be made into armour.");
		//Shop sub-menu
		if (dyes || philters || reductos)
			addButton(1, "Shop", rathazulShopMenu, dyes, philters, reductos, "Check Rathazul's wares.");
		else
			addButtonDisabled(1, "Shop", "You can't afford anything Rathazul has to offer.");
		//Purification sub-menu
		if (purify) {
			addButton(2, "Purify", purifySomething, null, null, null, "Ask him to purify any tainted potions. \n\nCost: 20 Gems.");
		}
		else {
			addButtonDisabled(2, "Purify", "You don't have any items that can be purified.");
		}
		//Alchemy sub-menu
		if (alchemy) {
			addButton(3, "Alchemy", rathazulAlchemyMenu, null, null, null, "Have Rathazul make something out of the ingredients you carry.");
		}
		//These will be filled in.
		if (lethiciteDefense != null) addButton(button++, "Lethicite", lethiciteDefense, null, null, null, "Ask him if he can make use of that lethicite you've obtained from Marae.");

		if (player.findStatusEffect(StatusEffects.CampRathazul) >= 0)
			addButton(14,"Leave", camp.campFollowers);
		else
			addButton(14, "Leave", camp.returnToCampUseOneHour);
		return true;
	}
	return false;
}

//------------
// ARMOUR
//------------
public function rathazulArmorMenu():void {
	spriteSelect(49);
	clearOutput();
	outputText("Which armor project would you like to pursue with Rathazul?");
	menu();
	if (player.hasItem(useables.GREENGL, 5)) {
		addButton(0, "GelArmor", craftOozeArmor);
	}
	if (player.hasItem(useables.B_CHITN, 5)) {
		addButton(1, "BeeArmor", craftCarapace);
	}
	if (player.hasItem(useables.T_SSILK) && flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] == 0) {
		addButton(2, "SpiderSilk", craftSilkArmor);
	}
	if (player.hasItem(useables.D_SCALE, 2)) {
		addButton(3, "Dragonscale", craftDragonscaleArmor);
	}
	if (player.hasKeyItem("Tentacled Bark Plates") >= 0) {
		addButton(5, "T.Bark Armor", craftMaraeArmor, false);
	}
	if (player.hasKeyItem("Divine Bark Plates") >= 0) {
		addButton(6, "D.Bark Armor", craftMaraeArmor, true);
	}
	addButton(14, "Back", returnToRathazulMenu);
}

private function craftOozeArmor():void {
	spriteSelect(49);
	clearOutput();
	outputText(images.showImage("rathazul-craft-gelarmor"));
	outputText("Rathazul takes the green gel from you and drops it into an empty cauldron.  With speed well beyond what you'd expect from such an elderly creature, he nimbly unstops a number of vials and pours them into the cauldron.  He lets the mixture come to a boil, readying a simple humanoid-shaped mold from what you had thought was piles of junk material.  In no time at all, he has cast the boiling liquid into the mold, and after a few more minutes he cracks it open, revealing a suit of glistening armor.\n\n");
	player.destroyItems(useables.GREENGL, 5);
	player.addStatusValue(StatusEffects.MetRathazul,2,1);
	inventory.takeItem(armors.GELARMR, returnToRathazulMenu);
	if (player.findStatusEffect(StatusEffects.RathazulArmor) < 0) player.createStatusEffect(StatusEffects.RathazulArmor,0,0,0,0);
}

private function craftCarapace():void {
	spriteSelect(49);
	clearOutput();
	outputText(images.showImage("rathazul-craft-chitinarmor"));
	outputText("The rat takes the scales and works on his bench for an hour while you wait.  Once he has finished, Ratzhul is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHe hands you the armor.  ");
	outputText("The plates shine and shimmer like black steel.  He has used the yellow chitin to add accents and embroidery to the plates with a level of detail and craftsmanship rarely seen back home. A yellow fur neck lining has been fashioned from hairs found on the pieces.  The armor includes a breastplate, shoulder guards, full arm guards, and knee high boots.  You notice there are no pants.  As you turn to ask him where the pants are, you see him scratching his head and hastily rustling in drawers.  He mutters under his breath, \"<i>I'm sorry, I'm sorry, I got so focused on working on the pauldrons that I forgot to make any leg coverings!  Here, this should look good with it, and it won't restrict your movements.</i>\"  He hands you a silken loincloth", false);
	if (player.mf("m", "f") == "f") outputText(" with stockings and garters", false);
	outputText(".  He still manages to look somewhat pleased with himself in spite of the blunder, even bragging a little bit, \"<i>Let me show you the different lengths of string I used.</i>\"\n\n", false);
	if (player.cockTotal() > 0 && player.biggestCockArea() >= 40) outputText("The silken material does little to hide the bulge of your groin, if anything it looks a little lewd.  Rathazul mumbles and looks away, shaking his head.\n\n", false);
	if (player.biggestTitSize() >= 8) outputText("Your " + player.biggestBreastSizeDescript() + " barely fit into the breastplate, leaving you displaying a large amount of jiggling cleavage.\n\n", false);
	player.destroyItems(useables.B_CHITN, 5);
	player.addStatusValue(StatusEffects.MetRathazul,2,1);
	inventory.takeItem(armors.BEEARMR, returnToRathazulMenu);
}

private function craftSilkArmor():void {
	spriteSelect(49);
	clearOutput();
	outputText("You hand the bundled webbing to Rathazul carefully, lest you damage the elderly mouse.  He gives you a bemused smile and snatches the stuff from your grasp while he mutters, \"<i>I'm not falling apart you know.</i>\"\n\n", false);
	//(Not enough webs: 
	if (!player.hasItem(useables.T_SSILK, 5)) {
		outputText("The rat shakes his head and hands it back to you.  \"<i>This isn't enough for me to make anything with.  I'll need at least five bundles of this stuff total, so you'll need to find more,</i>\" he explains.\n\n", false);
		//(optional spider bonus: 
		if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN) {
			outputText("You show him your spider-like abdomen in response, offering to produce more webbing for him.  Rathazul chuckles dryly, a sound that reminds you of hot wind rushing through a dead valley.  \"<i>Dear child, this would never do.  Silk this tough can only be produced by a true-born spider.  No matter how you change yourself, you'll always be a human at heart.</i>\"\n\n", false);
			outputText("The old rat shakes his head and adds, \"<i>Well, now that I think about it, the venom of a red widow might be able to transform you until you are a spider to the core, but I have absolutely no idea what that would do to you.  If you ever try such a dangerous, reckless idea, let me know.  I want to have my notebooks handy, for SCIENCE!</i>\"\n\n", false);
		}
		if (player.hasItem(useables.T_SSILK, 2)) {
			outputText("\"<i>But this should be enough for undergarments if you want,</i>\" Rathazul adds.");
			doYesNo(commissionSilkArmorForReal,declineSilkArmorCommish);
			return;
		}
		doNext(returnToRathazulMenu);
		return;
	}
	outputText("The rat limps over to his equipment, spider-silk in hand.  With efficient, practiced motions, he runs a few tests.  As he finishes, he sighs and explains, \"<i>This will be harder than I thought.  The webbing is highly resistant to most of my alchemic reagents.  To even begin to work with such material I will need a number of rare, expensive elements.  I would need 500 gems to even start such a project.</i>\"\n\n", false);
	outputText("You can't help but sigh when he names such a sizable figure.  Do you give him the 500 gems and spider-silk in order for him to create you a garment?", false);
	if (player.gems < 500) {
		outputText("  <b>Wait... you don't even have 500 gems.  Damn.</b>", false);
		doNext(returnToRathazulMenu);
		return;
	}
	//[Yes] [No]
	doYesNo(commissionSilkArmorForReal,declineSilkArmorCommish);
}
private function commissionSilkArmorForReal():void {
	spriteSelect(49);
	clearOutput();
	outputText("You sort 500 gems into a pouch and toss them to Rathazul, along with the rest of the webbing.  The wizened alchemist snaps the items out of the air with lightning-fast movements and goes to work immediately.  He bustles about with enormous energy, invigorated by the challenging task before him.  It seems Rathazul has completely forgotten about you, but as you turn to leave, he calls out, \"<i>What did you want me to make?  A mage's robe or some nigh-impenetrable armor?  Or undergarments if you want.</i>\"\n\n", false);
	menu();
	if (player.hasItem(useables.T_SSILK, 5)) {
		addButton(0, "Armor", chooseArmorOrRobes, 1, null, null, armors.SSARMOR.description);
		addButton(1, "Robes", chooseArmorOrRobes, 2, null, null, armors.SS_ROBE.description);
	}
	addButton(2, "Bra", chooseArmorOrRobes, 3, null, null, undergarments.SS_BRA.description);
	addButton(3, "Panties", chooseArmorOrRobes, 4, null, null, undergarments.SSPANTY.description);
	addButton(4, "Loincloth", chooseArmorOrRobes, 5, null, null, undergarments.SS_LOIN.description);
	addButton(14, "Nevermind", declineSilkArmorCommish);
}
private function declineSilkArmorCommish():void {
	spriteSelect(49);
	clearOutput();
	outputText("You take the silk back from Rathazul and let him know that you can't spend 500 gems on a project like that right now.  He sighs, giving you a crestfallen look and a slight nod of his hooded muzzle.", false);
	doNext(returnToRathazulMenu);
}
public function chooseArmorOrRobes(robeType:int):void {
	spriteSelect(49);
	if (robeType == 1 || robeType == 2) { //Armor or robes
		player.destroyItems(useables.T_SSILK, 5);
	}
	else { //Undergarments
		player.destroyItems(useables.T_SSILK, 2);
	}
	player.gems -= 500;
	statScreenRefresh();
	outputText("Rathazul grunts in response and goes back to work.  ", true);
	if (player.findStatusEffect(StatusEffects.CampRathazul) >= 0)
	{
		outputText("You turn back to the center of your camp", false);
	}
	else
	{
		outputText("You head back to your camp", false);
	}
	outputText(", wondering if the old rodent will actually deliver the wondrous item that he's promised you.", false);
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] = robeType;
	flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] = 24;
	trace("274: " + flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN]);
	doNext(camp.returnToCampUseOneHour);
}
private function collectSilkArmor():void {
	spriteSelect(49);
	clearOutput();
	
	outputText("Rathazul beams and ejaculates, \"<i>Good news everyone!  Your ", false);
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] == 1) outputText("armor", false);
	else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] == 2) outputText("robe", false);
	else outputText("undergarment", false);
	outputText(" is finished!</i>\"\n\n", false);
	
	var itype:ItemType;
	switch(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275]) {
		case 1: //Armor
			outputText(images.showImage("rathazul-craft-silkarmor"));
			outputText("A glittering white suit of armor sits atop a crude armor rack, reflecting the light that plays across its surface beautifully.  You definitely didn't expect anything like this!  It looks nearly identical to a set of light platemail, though instead of having a cold metal surface, the armor feels slightly spongy, with just a little bit of give in it.\n\n", false);
			outputText("While you marvel at the strange equipment, Rathazul explains, \"<i>When you said you wanted armor, I realized I could skip a few of the alchemical processes used to soften material.  The savings let me acquire a cheap metal set of armor to use as a base, and I molded half the armor around each piece, then removed it and created the outer, defensive layers with the rest of the webbing.  Unfortunately, I didn't have enough silk for a solid codpiece, but I did manage to make a you thin loincloth from the leftover scraps  - for modesty.</i>\"\n\n", false);
			itype = armors.SSARMOR;
			break;
		case 2: //Robes
			outputText(images.showImage("rathazul-craft-silkrobes"));
			outputText("Hanging from a small rack is a long, flowing robe.  It glitters brightly in the light, the pearl-white threads seeming to shimmer and shine with every ripple the breeze blows through the soft fabric.  You run your fingers over the silken garment, feeling the soft material give at your touch.  There's a hood with a golden border embroidered around the edge.  For now, it hangs limply down the back, but it would be easy to pull up in order to shield the wearer's eyes from harsh sunlight or rainy drizzle.  The sleeves match the cowl, circled with intricate threads laid out in arcane patterns.\n\n", false);
			outputText("Rathazul gingerly takes down the garment and hands it to you.  \"<i>Don't let the softness of the material fool you.  This robe is tougher than many armors, and the spider-silk's properties may even help you in your spell-casting as well.</i>\"\n\n", false);
			itype = armors.SS_ROBE;
			break;
		case 3: //Bra
			outputText(images.showImage("rathazul-craft-silkbra"));
			outputText("On a table is a pair of white bra.  It glitters brightly in the light, the pearl-white threads seeming to shimmer and shine with every ripple the breeze blows through the soft fabric.  You run your fingers over the silken garment, feeling the soft material give at your touch.  \n\n", false);
			outputText("Rathazul gingerly takes the garment and hands it to you.  \"<i>Don't let the softness of the material fool you.  These bras are very durable and should be comfortable as well.</i>\"\n\n", false);
			itype = undergarments.SS_BRA;
			break;
		case 4: //Panties
			outputText(images.showImage("rathazul-craft-silkpanties"));
			outputText("On a table is a pair of white panties.  It glitters brightly in the light, the pearl-white threads seeming to shimmer and shine with every ripple the breeze blows through the soft fabric.  You run your fingers over the silken garment, feeling the soft material give at your touch.  \n\n", false);
			outputText("Rathazul gingerly takes the garment and hands it to you.  \"<i>Don't let the softness of the material fool you.  These panties are very durable and should be comfortable as well.</i>\"\n\n", false);
			itype = undergarments.SSPANTY;
			break;
		case 5: //Loincloth
			outputText(images.showImage("rathazul-craft-silkloincloth"));
			outputText("On a table is a white loincloth.  It glitters brightly in the light, the pearl-white threads seeming to shimmer and shine with every ripple the breeze blows through the soft fabric.  You run your fingers over the silken garment, feeling the soft material give at your touch.  \n\n", false);
			outputText("Rathazul gingerly takes the garment and hands it to you.  \"<i>Don't let the softness of the material fool you.  This loincloth is very durable and should be comfortable as well.</i>\"\n\n", false);
			itype = undergarments.SS_LOIN;
			break;
		default:
			outputText("Something bugged! Please report this bug to Kitteh6660.");
			itype = armors.SS_ROBE;
	}
	//Reset counters
	player.addStatusValue(StatusEffects.MetRathazul,2,1);
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] = 0;
	flags[kFLAGS.RATHAZUL_SILK_ARMOR_COUNTDOWN] = 0;
	inventory.takeItem(itype, returnToRathazulMenu);
}

private function craftDragonscaleArmor():void {
	spriteSelect(49);
	clearOutput();
	outputText("The rat looks at the sheets of dragon scales you're carrying and says, \"<i>I could work these into armor. Or if you want, undergarments. I have the necessary supplies.</i>\"");
	menu();
	if (player.hasItem(useables.D_SCALE, 5)) {
		addButton(0, "Armor", craftDragonscaleArmorForReal, 0, null, null, armors.DSCLARM.description);
		addButton(1, "Robe", craftDragonscaleArmorForReal, 1, null, null, armors.DSCLROB.description);
	}
	else outputText("\n\nYou realize you're still a bit short on dragonscales for the armor but you can have undergarments made instead.");
	addButton(2, "Bra", craftDragonscaleArmorForReal, 2, null, null, undergarments.DS_BRA.description);
	addButton(3, "Thong", craftDragonscaleArmorForReal, 3, null, null, undergarments.DSTHONG.description);
	addButton(4, "Loincloth", craftDragonscaleArmorForReal, 4, null, null, undergarments.DS_LOIN.description);
	addButton(14, "Nevermind", rathazulArmorMenu);
}
private function craftDragonscaleArmorForReal(type:int = 0):void {
	spriteSelect(49);
	if (type == 0 || type == 1) { //Armor or robes
		player.destroyItems(useables.D_SCALE, 5);
	}
	else { //Undergarments
		player.destroyItems(useables.D_SCALE, 2);
	}
	clearOutput();
	var itype:ItemType;
	switch(type) {
		case 0: //Armor
			outputText(images.showImage("rathazul-craft-dragonscalearmor"));
			outputText("The rat takes the scales and works on his bench for an hour while you wait.  Once he has finished, Ratzhul is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHe hands you the armor.  ");
			outputText("The armor is red and the breastplate has nicely decorated pauldrons to give an imposing looks. You touch the armor and feel the scaly texture. \"<i>It's quite flexible and should offer very good protection,</i>\" Rathazul says.");
			itype = armors.DSCLARM;
			break;
		case 1: //Robes
			outputText(images.showImage("rathazul-craft-dragonscalerobes"));
			outputText("The rat takes the scales and works on his bench for an hour while you wait.  Once he has finished, Ratzhul is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHe hands you the robes.  ");
			outputText("The robe is red and appears to be textured with scales.  You touch the robes and feel the scaly texture. \"<i>It's quite flexible and should offer very good protection,</i>\" Rathazul says.");
			itype = armors.DSCLROB;
			break;
		case 2: //Bra
			outputText(images.showImage("rathazul-craft-dragonscalebra"));
			outputText("The rat takes the scales and works on his bench for an hour while you wait.  Once he has finished, Ratzhul is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHe hands you the bra.  ");
			outputText("It's nicely textured with dragon scales. \"<i>I've used leather straps to maintain the flexibility. It should be comfortable and protective,</i>\" Rathazul says.", false);
			itype = undergarments.DS_BRA;
			break;
		case 3: //Thong
			outputText(images.showImage("rathazul-craft-dragonscalethong"));
			outputText("The rat takes the scales and works on his bench for an hour while you wait.  Once he has finished, Ratzhul is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHe hands you the thong.  ");
			outputText("It's nicely textured with dragon scales. \"<i>I've used leather straps to maintain the flexibility. It should be comfortable and protective,</i>\" Rathazul says.", false);
			itype = undergarments.DSTHONG;
			break;
		case 4: //Loincloth
			outputText(images.showImage("rathazul-craft-dragonscaleloincloth"));
			outputText("The rat takes the scales and works on his bench for an hour while you wait.  Once he has finished, Ratzhul is beaming with pride, \"<i>I think you'll be pleased. Go ahead and take a look.</i>\"\n\nHe hands you the loincloth.  ");
			outputText("It's nicely textured with dragon scales. \"<i>I've used leather straps to maintain the flexibility. It should be comfortable and protective,</i>\" Rathazul says.", false);
			itype = undergarments.DS_LOIN;
			break;
		default:
			outputText("Something bugged! Please report this bug to Kitteh6660.");
			itype = armors.DSCLARM;
			break;
	}
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	inventory.takeItem(itype, returnToRathazulMenu);
}

private function craftMaraeArmor(divine:Boolean = false):void {
	clearOutput();
	if (!divine) {
		outputText(images.showImage("rathazul-craft-barkarmor-corrupt"));
		outputText("You show him the pieces of thick bark with tentacles attached. \n\n \"<i>My, my. That's definitely the strangest thing I've ever seen. But as you've requested, I'll make armor for you,</i>\" the old rat says. He takes the pile of bark, taking care to avoid touching the still-alive tentacles. He works on his bench for an hour while you wait. \n\n")
		outputText("Once he has finished, Ratzhul is beaming with both pride and shame, \"<i>I think you'll be pleased. Go ahead and take a look. I'm not working on this type of armor again. I nearly got surprised by tentacles.</i>\"\n\nHe hands you the armor. \n\n", false)
		outputText("The plates are white like snow. Green tentacles grow from the shoulderpads. The armor includes a breastplate, pauldrons, full arm guards, and knee-high boots. You realize the armor is missing pants. \n\n", false);
		outputText("\"<i>Something wrong? Nothing to protect your modesty? Surprise!</i>\"  He hands you a silken loincloth", false);
		if (player.mf("m", "f") == "f") outputText(" with stockings and garters", false);
		outputText(". You thank him for the armor.\n\n", false)
		if (player.cockTotal() > 0 && player.biggestCockArea() >= 40) outputText("The silken material does little to hide the bulge of your groin, if anything it looks a little lewd.  Rathazul mumbles and looks away, shaking his head.\n\n", false);
		if (player.biggestTitSize() >= 8) outputText("Your " + player.biggestBreastSizeDescript() + " barely fit into the breastplate, leaving you displaying a large amount of jiggling cleavage.\n\n", false);
		player.removeKeyItem("Tentacled Bark Plates");
		inventory.takeItem(armors.TBARMOR, returnToRathazulMenu);
	}
	else {
		outputText(images.showImage("rathazul-craft-barkarmor-pure"));
		outputText("You show him the pieces of glowing white thick bark attached. \n\n \"<i>My, my. I heard a voice from Marae instructing me to make the armor for you,</i>\" the old rat says. He takes the pile of bark and works on his bench for an hour while you wait. \n\n")
		outputText("Once he has finished, Ratzhul is beaming with both pride and shame, \"<i>I think you'll be pleased. Go ahead and take a look. I'm not working on this type of armor again. It took me many attempts to bend the bark plates to get them right.</i>\"\n\nHe hands you the armor. \n\n", false)
		outputText("The plates are white like snow. The armor includes a breastplate, pauldrons, full arm guards, and knee-high boots. You notice there are no pants.  As you turn to ask him where the pants are, you see him scratching his head and hastily rustling in drawers.  He mutters under his breath, \"<i>I'm sorry, I'm sorry, I got so focused on working on the pauldrons that I forgot to make any leg coverings!  Here, this should look good with it, and it won't restrict your movements.</i>\"  He hands you a silken loincloth", false);
		if (player.mf("m", "f") == "f") outputText(" with stockings and garters", false);
		outputText(".  He still manages to look somewhat pleased with himself in spite of the blunder, even bragging a little bit, \"<i>Let me show you the different lengths of string I used.</i>\"\n\n", false);
		if (player.cockTotal() > 0 && player.biggestCockArea() >= 40) outputText("The silken material does little to hide the bulge of your groin, if anything it looks a little lewd.  Rathazul mumbles and looks away, shaking his head.\n\n", false);
		if (player.biggestTitSize() >= 8) outputText("Your " + player.biggestBreastSizeDescript() + " barely fit into the breastplate, leaving you displaying a large amount of jiggling cleavage.\n\n", false);
		player.removeKeyItem("Divine Bark Plates");
		inventory.takeItem(armors.DBARMOR, returnToRathazulMenu);
	}
}

//------------
// SHOP
//------------
private function rathazulShopMenu(dyes:Boolean = false, philters:Boolean = false, reductos:Boolean = false):void {
	//Dyes
	if (dyes) {
		addButton(0, "Hair Dyes", buyDyes, null, null, null, "Ask him to make a dye for you. \n\nCost: 50 Gems.");
		addButton(1, "Skin Oils", buyOils, null, null, null, "Ask him to make a skin oil for you. \n\nCost: 50 Gems.");
		addButton(2, "Body Lotions", buyLotions, null, null, null, "Ask him to make a body lotion for you. \n\nCost: 50 Gems.");
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
		addButtonDisabled(3, "Reducto", "Rathazul isn't currently producing this item.");
		addButtonDisabled(4, "GroPlus", "Rathazul isn't currently producing this item.");
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
private function buyDyes():void {
	spriteSelect(49);
	clearOutput();
	outputText("Rathazul smiles and pulls forth several vials of colored fluids.  Which type of dye would you like?");
	outputText("\n\n<b>(-50 Gems)</b>");
	player.gems -= 50;
	statScreenRefresh();
	menu();
	addButton(0, "Auburn", buyDye, consumables.AUBURND);
	addButton(1, "Black", buyDye, consumables.BLACK_D);
	addButton(2, "Blond", buyDye, consumables.BLOND_D);
	addButton(3, "Brown", buyDye, consumables.BROWN_D);
	addButton(4, "Red", buyDye, consumables.RED_DYE);
	addButton(5, "White", buyDye, consumables.WHITEDY);
	addButton(6, "Gray", buyDye, consumables.GRAYDYE);
	if (player.statusEffectv2(StatusEffects.MetRathazul) >= 8) {
		addButton(7, "Blue", buyDye, consumables.BLUEDYE);
		addButton(8, "Green", buyDye, consumables.GREEN_D);
		addButton(9, "Orange", buyDye, consumables.ORANGDY);
		addButton(10, "Purple", buyDye, consumables.PURPDYE);
		addButton(11, "Pink", buyDye, consumables.PINKDYE);
	}
	if (player.statusEffectv2(StatusEffects.MetRathazul) >= 12) {
		addButton(12, "Rainbow", buyDye, consumables.RAINDYE);
	}
	addButton(14, "Nevermind", buyDyeNevermind);
}
private function buyDye(dye:ItemType):void {
	spriteSelect(49);
	clearOutput();
	outputText(images.showImage("rathazul-buy-dye"));
	inventory.takeItem(dye, returnToRathazulMenu);
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}
private function buyDyeNevermind():void {
	spriteSelect(49);
	clearOutput();
	outputText("You change your mind about the dye, and Rathazul returns your gems.\n\n<b>(+50 Gems)</b>");
	player.gems += 50;
	statScreenRefresh();
	doNext(returnToRathazulMenu);
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
	addButton(14, "Nevermind", buyOilNevermind);
}
private function buyOil(oil:ItemType):void {
	spriteSelect(49);
	clearOutput();
	outputText(images.showImage("rathazul-buy-oil"));
	inventory.takeItem(oil, returnToRathazulMenu);
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}
private function buyOilNevermind():void {
	spriteSelect(49);
	clearOutput();
	outputText("You change your mind about the oil, and Rathazul returns your gems.\n\n<b>(+50 Gems)</b>");
	player.gems += 50;
	statScreenRefresh();
	doNext(returnToRathazulMenu);
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
	inventory.takeItem(lotion, returnToRathazulMenu);
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}
private function buyLotionNevermind():void {
	spriteSelect(49);
	clearOutput();
	outputText("You change your mind about the lotion, and Rathazul returns your gems.\n\n<b>(+50 Gems)</b>");
	player.gems += 50;
	statScreenRefresh();
	doNext(returnToRathazulMenu);
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
		inventory.takeItem(consumables.REDUCTO, returnToRathazulMenu);
		statScreenRefresh();
		player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	}
	else {
		outputText("\"<i>I'm sorry, but you lack the gems I need to make the trade,</i>\" apologizes Rathazul.");
		doNext(returnToRathazulMenu);
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
		inventory.takeItem(consumables.GROPLUS, returnToRathazulMenu);
		statScreenRefresh();
		player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	}
	else {
		outputText("\"<i>I'm sorry, but you lack the gems I need to make the trade,</i>\" apologizes Rathazul.");
		doNext(returnToRathazulMenu);
	}
}


private function buyPuritySomething(item:ItemType):void {
	player.gems -= 100;
	statScreenRefresh();
	inventory.takeItem(item, returnToRathazulMenu);
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}

//------------
// PURIFY
//------------
private function purifySomething():void {
	spriteSelect(49);
	clearOutput();
	outputText("Rathazul asks, \"<i>What would you like me to purify?</i>\"");
	menu();
	//Item purification offer
	if (player.hasItem(consumables.INCUBID)) {
		addButton(0, "Incubi Draft", rathazulPurifyItem, consumables.INCUBID, consumables.P_DRAFT);
	}
	if (player.hasItem(consumables.SUCMILK)) {
		addButton(1, "SuccubiMilk", rathazulPurifyItem, consumables.SUCMILK, consumables.P_S_MLK);
	}
	if (player.hasItem(consumables.SDELITE)) {
		addButton(2, "S. Delight", rathazulPurifyItem, consumables.SDELITE, consumables.PSDELIT);
	}
	if (player.hasItem(consumables.LABOVA_)) {
		addButton(3, "LaBova", rathazulPurifyItem, consumables.LABOVA_, consumables.P_LBOVA);
	}
	if (player.hasItem(consumables.MINOCUM)) {
		addButton(4, "MinoCum", rathazulPurifyItem, consumables.MINOCUM, consumables.P_M_CUM);
	}
	addButton(14, "Back", returnToRathazulMenu);
}

private function rathazulPurifyItem(itype:ItemType, result:ItemType):void {
	if (player.gems < 20) {
		outputText("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"");
		doNext(returnToRathazulMenu);
		return;
	}
	if (!debug)
		player.destroyItems(itype, 1);
	inventory.takeItem(result, returnToRathazulMenu);
	player.gems -= 20;
	statScreenRefresh();
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
}

//For Minerva purification.
public function purificationByRathazulBegin():void {
	outputText("Hoping the rodent-morph alchemist can assist you, you waste no time in approaching him. Rathazul looks up when he sees you, raising an eye curiously. \"<i>Is something the matter, " + player.short + "?</i>\"");
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

//------------
// ALCHEMY
//------------
private function rathazulAlchemyMenu():void {
	menu();
	//Distill Honey
	if (player.hasItem(consumables.BEEHONY)) {
		addButton(0, "Distill Honey", rathazulMakesPureHoney, null, null, null, "Ask him to distill a vial of bee honey into a pure honey. \n\nCost: 25 Gems \nNeeds 1 vial of Bee Honey");
	}
	else {	
		addButtonDisabled(0, "Distill Honey", "You don't have any bee honey to be distilled.");
	}
	//Debimbo
	if (flags[kFLAGS.RATHAZUL_DEBIMBO_OFFERED] > 0) {
		if (player.hasItem(consumables.SMART_T,5) && player.gems >= 250)
			addButton(1, "Debimbo", makeADeBimboDraft, null, null, null, "Ask Rathazul to make a debimbofying potion for you. \n\nCost: 250 Gems \nNeeds 5 Scholar Teas.");
		else
			addButtonDisabled(1, "Debimbo", "You don't have everything needed for this item. \n\nCost: 250 Gems \nNeeds 5 Scholar Teas.");
	}
	else {
		addButtonDisabled(1, "Debimbo", "Rathazul sees no reason to make this. Maybe if someone's a bimbo in this camp...");
	}
	//Purification Potion for Minerva
	if (flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] == 2 && flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] < 10) {
		if ((player.hasItem(consumables.PURHONY, 1) || player.hasItem(consumables.PPHILTR, 1)) && player.hasItem(consumables.C__MINT, 1) && player.hasItem(consumables.PURPEAC, 1) && player.hasKeyItem("Rathazul's Purity Potion") < 0)
			addButton(2, "Pure Potion", rathazulMakesPurifyPotion, null, null, null, "Ask him to brew a purification potion for Minerva.");
		else if (player.hasKeyItem("Rathazul's Purity Potion") >= 0)
			addButtonDisabled(2, "Pure Potion", "You already have the potion made. Bring it to Minerva.");
		else
			addButtonDisabled(2, "Pure Potion", "You don't have the ingredients needed to make the purification potion. \n\nNeeds 1 Pure Honey or Pure Philter, 1 Calm Mint, 1 Pure Peach.");
	}
	//Special Transformations
	if (player.statusEffectv2(StatusEffects.MetRathazul) >= 5) {
		//Pro Lactaid
		if (player.gems >= 250 && player.hasItem(consumables.LACTAID, 5) && player.hasItem(consumables.P_LBOVA, 2))
			addButton(5, "ProLactaid", rathazulMakesMilkPotion, null, null, null, "Ask him to brew a special lactation potion. \n\nCost: 250 Gems \nNeeds 5 Lactaids and 2 Purified LaBovas.");
		else
			addButtonDisabled(5, "ProLactaid", "You don't have everything needed for this item. \n\nCost: 250 Gems \nNeeds 5 Lactaids and 2 Purified LaBovas.");
		//Taurinum
		if (player.gems >= 100 && player.hasItem(consumables.EQUINUM, 2) && player.hasItem(consumables.MINOBLO, 1))
			addButton(6, "Taurinum", rathazulMakesTaurPotion, null, null, null, "Ask him to brew a special potion that could aid in becoming a centaur. \n\nCost: 100 Gems \nNeeds 2 Equinum and 1 Minotaur Blood.");
		else
			addButtonDisabled(6, "Taurinum", "You don't have everything needed for this item. \n\nCost: 100 Gems \nNeeds 2 Equinum and 1 Minotaur Blood.");
	}
	else {
		addButtonDisabled(5, "ProLactaid", "Rathazul doesn't know how to make this yet. Try buying more from him.");
		addButtonDisabled(6, "Taurinum", "Rathazul doesn't know how to make this yet. Try buying more from him.");
	}
	addButton(14, "Back", returnToRathazulMenu);
}

private function rathazulDebimboOffer():void {
	spriteSelect(49);
	clearOutput();
	if (flags[kFLAGS.RATHAZUL_DEBIMBO_OFFERED] == 0) {
		if (sophieBimbo.bimboSophie()) {
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

//Turn several ingredients into a special potion/consumable.
private function rathazulMakesPureHoney():void {
	clearOutput();
	if (player.gems < 25) {
		outputText("\"<i>I'm sorry but you don't have the gems for this service,</i>\" Rathazul says.");
		doNext(returnToRathazulMenu);
		return;
	}
	player.destroyItems(consumables.BEEHONY, 1);
	player.gems -= 25;
	statScreenRefresh();
	outputText("You hand over a vial of bee honey and the 25 gems.");
	outputText("\n\n\"<i>I'll see what I can do,</i>\" he says as he takes the bee honey and begin brewing something. ");
	outputText("\n\nA few minutes later, he comes back with the crystal vial that contains glittering liquid.  \"<i>It's ready. The honey should be pure now,</i>\" he says. He hands you over the vial of honey and goes back to working.  ");
	inventory.takeItem(consumables.PURHONY, returnToRathazulMenu);
}

private function rathazulMakesMilkPotion():void {
	clearOutput();
	if (player.gems < 250) {
		outputText("\"<i>I'm sorry but you don't have the gems for this service,</i>\" Rathazul says.");
		doNext(returnToRathazulMenu);
		return;
	}
	else if (!(player.hasItem(consumables.LACTAID, 5) && player.hasItem(consumables.P_LBOVA, 2))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need five bottles of Lactaid and two bottles of purified LaBova,</i>\" Rathazul says.");
		doNext(returnToRathazulMenu);
		return;
	}
	player.destroyItems(consumables.LACTAID, 5);
	player.destroyItems(consumables.P_LBOVA, 2);
	player.gems -= 250;
	statScreenRefresh();
	outputText("You hand over the ingredients and 250 gems.");
	outputText("\n\n\"<i>I'll see what I can do,</i>\" he says as he takes the ingredients and begin brewing something. ");
	outputText("\n\nA few minutes later, he comes back with the potion.  \"<i>It's ready. If you have some issues with lactation or you want to produce milk forever, drink this. Keep in mind that it might be irreversible,</i>\" he says. He hands you over the potion and goes back to working.  ");
	inventory.takeItem(consumables.MILKPTN, returnToRathazulMenu);
}

private function rathazulMakesTaurPotion():void {
	spriteSelect(49);
	clearOutput();
	if (player.gems < 100) {
		outputText("\"<i>I'm sorry but you don't have the gems for this service,</i>\" Rathazul says.");
		doNext(returnToRathazulMenu);
		return;
	}
	else if (!(player.hasItem(consumables.EQUINUM, 2) && player.hasItem(consumables.MINOBLO, 1))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need two vials of Equinum and one vial of minotaur blood,</i>\" Rathazul says.");
		doNext(returnToRathazulMenu);
		return;
	}
	player.destroyItems(consumables.EQUINUM, 2);
	player.destroyItems(consumables.MINOBLO, 1);
	player.gems -= 100;
	statScreenRefresh();
	outputText("You hand over two vials of Equinum, one vial of Minotaur Blood and one hundred gems to Rathazul, which he gingerly takes them and proceeds to make a special potion for you.");
	outputText("\n\nAfter a while, the rat hands you a vial labeled \"Taurinum\" and nods.");
	player.addStatusValue(StatusEffects.MetRathazul, 2, 1);
	inventory.takeItem(consumables.TAURICO, returnToRathazulMenu);
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
	outputText("Rathazul nods sagely, \"<i>That may be wise.  Perhaps there will be another use for this power.");
	doNext(returnToRathazulMenu);
}

}
}
