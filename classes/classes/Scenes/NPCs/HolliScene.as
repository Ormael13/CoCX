package classes.Scenes.NPCs{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	public class HolliScene extends NPCAwareContent {

	public function HolliScene()
	{
	}

//VARS
//const TIMES_FUCKED_FLOWER:int = 594;
//const TIMES_RIDDEN_FLOWER:int = 595;
//const FUCK_FLOWER_LEVEL:int = 596;
//const FUCK_FLOWER_GROWTH_COUNTER:int = 597;
//const FUCK_FLOWER_KILLED:int = 598;
//const AMILY_TREE_FLIPOUT:int = 599;
//const HOLLI_FRUIT:int = 600;
//const HOLLI_FRUIT_EXPLAINED:int = 601;
//const HOLLI_DEFENSE_ON:int = 602;
//const HOLLI_SUBMISSIVE:int = 682;
//const FOUGHT_HOLLI:int = 923;
//const THREATENED_HOLLI:int = 924;

/*Plant Sprout Notes:
	-Small sapling plants near corner of camp after 2nd Marae meeting.
	-Appears in items screen.  Can be pulled out, or left alone.
	-After a while, it 'blooms' to stage 2.  Procs a scene describing it with option to destroy it or...
	-Phase 2 Notes:
		-Grows into a pussy flower with tentacle-stamen.
		-Males can fuck it if penis is less than 150 area.
		-Females can ride the stamen.
		-Takes 25 days (-4 per fuck) to hit phase 3.
		-Can be destroyed at any point
	-Phase 3 Notes:
		-Is a small tree with numerous tentacle-cocks, two small, pert syrup-lactating breasts, and a large flower at waist height that can handle any size member.
		-Takes 40 days, (-5 per fuck) to hit the fourth, and final phase.
	Phase 4 Notes:
		-The boobs fade into the tree and the tentacles retract, then the trunk 'blooms', exposing a humanoid woman with:
		-Pale green skin.
		-Dark Green Hair
		-Black sclera with brown, almost golden eyes.
		-G cup breasts with shiny almost brown nipples, slick with her sweet, drug-like sap.
		-Vaginal flower that exposes at will, can handle any dick.
		-Can stamen-cock at will and grow tentacles from the branches to fuck you with.
		-Domineering Personality.  Can be overpowered and treated like a bitch. (future update?)
	*/

private function fightHolli():void {
	flags[kFLAGS.FOUGHT_HOLLI] = 1;
	startCombat(new Holli());
}

public function treeMenu(output:Boolean = true):void {
	if (output) clearOutput();
	var ride:Function = null;
	var fuck:Function = null;
	var burnIt:Function = null;
	if (flags[kFLAGS.FOUGHT_HOLLI] > 0) {
		//If You Fight, Run, and Come Back To Her in the Menu -Z
		outputText("The demon tree is still here, and the face peeking from it still stares daggers at you even from a distance.  It looks like forgiveness won't be forthcoming.");
		//[Fight][Call Jojo(req Small Talisman)][Retreat]
		//Call Jojo goes to above scene, others go to fight or camp directly
		menu();
		addButton(0,"Fight",fightHolli);
		if (player.hasKeyItem("Jojo's Talisman") >= 0) addButton(1,"Call Jojo",callDatJojo);
		addButton(4, "Back", inventory.inventoryMenu);
	}
	else if (flags[kFLAGS.FUCK_FLOWER_LEVEL] == 1) {
		if (output) outputText("The sprout looks about the same as when you first noticed it.  It's a simple, leafy shoot that only goes to about knee height.  It looks healthy and strong, with a few dozen branches and shiny green leaves.  If you look closely, the veins on the undersides of the leaf are purplish and pulse slightly with corruption.  You could easily destroy it.");
		simpleChoices("Burn It", destroyDatFukkinTree, "", null, "", null, "", null, "Back", inventory.inventoryMenu);
	}
	else if (flags[kFLAGS.FUCK_FLOWER_LEVEL] == 2) {
		//[Fuck It] [Ride Stamen] [Do Nothing] [Destroy It]
		if (output) outputText("Before you is a large, waist-high plant of questionable origin.  A huge, violet bloom sits atop a strong, central stalk, and the obscene flower looks positively female in every sense, right down to a clit-shaped bump and moist, gently parted lips.  Inside that central passage, you can see a bevy of wiggling staman surrounding a larger, flared stalk.  The scent that wafts out of that opening is sweet and floral, but undoubtedly sexual.  It looks like an organic sex toy and is clearly corrupt.  It wouldn't be hard to get rid of right now, assuming you don't let it grow larger.");
		if (player.hasCock() && player.cockThatFits(100) >= 0 && player.lust >= 33) fuck = fuckFuckingFuckFlowerP2;
		
		if (player.hasVagina() && player.lust >= 33) ride = rideDatFuckingFukkFlowerP2;
		simpleChoices("Fuck It", fuck, "Ride Stamen", ride, "", null, "Destroy It", destroyDatFuckingPlantAtP2, "Back", inventory.inventoryMenu);
	}
	else if (flags[kFLAGS.FUCK_FLOWER_LEVEL] == 3) {
		if (output) outputText("The familiar plant has blossomed into a nicely sized tree, though you doubt it has finished growing just yet.  It sports an outstretched canopy with nice, green leaves.  Unfortunately, you can still trace the corrupted veins on their undersides from below.  The vaginal flower is still there and is in full bloom, now several feet across and practically dripping with moisture.  Just up the trunk, there's a pair of small, roughly b-cup breasts bulging out of the bark.  They're exquisitely smooth and soft, and they ooze sweet-smelling sap that your tongue would love to taste.  In the canopy above, tentacle vines idly writhe about, though they show no sizes of aggression.");
		if (player.findPerk(PerkLib.Dragonfire) >= 0 || player.findPerk(PerkLib.FireLord) >= 0 || player.findPerk(PerkLib.Hellfire) >= 0 || player.findStatusEffect(StatusEffects.KnowsWhitefire) >= 0) {
			if (output) outputText("\n\nIt could be burned down with your supernatural fire, but it would definitely tire you.");
			burnIt = torchP3Tree;
		}
		if (player.hasCock() && player.lust >= 33) fuck = fuckTheFlower;
		if (player.hasVagina() && player.lust >= 33) ride = rideTheWalrusP3;
		//[Fuck flower] [Drink Sap] [Ride Tentacles] [{Torch It}] [Leave It]
		simpleChoices("Fuck Flower", fuck, "Drink Sap", drinkThePlantGirlsSap, "Ride Tentacle", ride, "Torch It", burnIt, "Leave It", inventory.inventoryMenu);
	}
	else {
		//Camp Menu (edited)
		if (output) {
			outputText("Walking over to the edge of your camp, you approach the familiar demon-tree.  It looks innocent enough from a distance, but the pulsing purple veins in the green leaves show its true nature.  If they didn't, the tentacles cleverly camouflaged in the foliage certainly would!  Once you get closer, the bark splits like a pair of silken curtains, and a female form exposes itself from inside the interior.  Heavy, dripping tits and a fully-unfolded female flower dominate her form, but you drag your eyes up to her own, staring into Holli's golden-brown pupils and black sclera as you greet her.");
			if (flags[kFLAGS.HOLLI_SUBMISSIVE] == 1) {
				outputText("\n\n\"<i>Welcome back, [name].  ");
				if (flags[kFLAGS.TIMES_FUCKED_FLOWER] > 0 && rand(3) == 0) outputText("Did you want to fertilize me again?  My flower is ready and waiting...");
				else if (flags[kFLAGS.TIMES_RIDDEN_FLOWER] > 0 && rand(3) == 0) outputText("Did you want to use my tentacles again?  They've been restless without you...");
				else if (rand(2) == 0) outputText("Did you come for a drink?  I've built up lots of nectar for you.  Surely, a sip would be refreshing for you...");
				else outputText("How may I serve you?  Come, give me a command so that I can fulfill it for you.");
				outputText("</i>\"");
				
			}
			else {
				outputText("\n\n\"<i>Welcome back, [name].  ");
				if (flags[kFLAGS.TIMES_FUCKED_FLOWER] > 0 && rand(3) == 0) outputText("Did you want to fertilize me again?  Gardening is such exhausting work, but so rewarding...");
				else if (flags[kFLAGS.TIMES_RIDDEN_FLOWER] > 0 && rand(2) == 0) outputText("Did you come back to play again?  My tentacles are so restless.");
				else if (rand(2) == 0) outputText("Did you come for a drink?  I've built up lots of nectar for you.  Surely a hungry adventurer like yourself needs a sip, right?");
				else outputText("Do you want to play?  Come on, taste Mother Marae's finest creation.");
				outputText("</i>\"");
			}
			//Extra line on description:  
			if (flags[kFLAGS.HOLLI_FRUIT] > 0) {
				if (flags[kFLAGS.HOLLI_FRUIT] == 1) outputText("\n\nA large, purple fruit hangs from Holli's branches, twisting softly in the breeze.  It looks succulent and ripe.");
				else outputText("\n\n" + Num2Text(flags[kFLAGS.HOLLI_FRUIT]) + " large, purple fruits hang from Holli's branches, twisting softly in the breeze.  They look succulent and ripe.");
				//Optional Addition: 
				if (flags[kFLAGS.HOLLI_FRUIT_EXPLAINED] > 0) outputText("  A very small, strange part of you actually feels proud to have made something like that with the tree-woman.");
			}
		}
		if (flags[kFLAGS.HOLLI_SUBMISSIVE] == 0) {
			var eat:Function = null;
			if (flags[kFLAGS.HOLLI_FRUIT] > 0) eat = eatHolliFruit;
			if (player.hasCock() && player.lust >= 33) fuck = fuckHolliInZeFlowerPuss;
			if (player.hasVagina() && player.lust >= 33) ride = level4RideHollisTentacruels;
			
			var guardT:String = "";
			if (flags[kFLAGS.HOLLI_DEFENSE_ON] == 1) guardT = "Stop Guarding";
			else guardT = "Guard Camp";
			burnIt = askHolliToWatch;
			
			//[Fuck Her] [Drink] [Tentacle Ride] {Guard Camp} {Threaten} [Leave]
			choices("Fuck Holli", fuck, "Drink Sap", haveAMapleSyrupSnack, "Ride Tentacles", ride, guardT, burnIt, "Eat A Fruit", eat,
				"", null, "", null, "", null, "", null, "Leave", inventory.inventoryMenu);
		}
		else {
			menu();
			if (player.hasCock() && player.lust >= 33) addButton(0, "Fuck Holli", holliGetsDickDommed);
			if (player.countCocksOfType(CockTypesEnum.TENTACLE) >= 10 && player.lust >= 33) addButton(1, "TentacleBone", fullOnTentacleTasticGangBangForHolli);
			if (player.hasVagina() && player.lust >= 33) addButton(2, "Ride Holli", vaginalDomHollisTentacruels);
			addButton(3, "Drink Sap", haveAMapleSyrupSnack);
			if (flags[kFLAGS.HOLLI_FRUIT] > 0) addButton(4, "Eat A Fruit", eatHolliFruit);
			addButton(5, "Guarding", askBrokenHolliToGuard);
			addButton(9, "Leave", inventory.inventoryMenu);
		}
		
		if (flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] == 0 && flags[kFLAGS.FARM_CORRUPTION_STARTED] == 1) addButton(6, "Farm Help", helpWithFarm);
	}
}

private function helpWithFarm():void
{
	clearOutput();
	
	outputText("You ask if a plant goddess might not be able to help the farm you recently acquired.");

	outputText("\n\n“<i>Ah yes,</i>” Holli breathes. “<i>The patch of verdant orderliness between me and mother. It feels bright and cold to me... the life that grows there so starchy and dull. Empty calories.</i>” You wait as she hums to herself absently.");

	// PC not had sex with Holli that day:
	if (flags[kFLAGS.HOLLI_FUCKED_TODAY] == 0)
	{
		outputText("\n\n“<i>I could help with your little patch of boringness,</i>” Holli smirks eventually, before closing her eyes and beginning to slowly paw at her flower. “<i>But oh... it’s been so long since you properly fertilised me. How can you expect a goddess to bless your crops if she has not been showered with worship?</i>” You roll your eyes. You can guess what you have to do in order to get this being’s help.");

		treeMenu(false);
	}
	else
	{
		outputText("\n\n“<i>I can help you with it,</i>” she says eventually. “<i>But nourishing such dullness will take effort. I can give your produce a boost, but only once, and it won’t last forever. Would you like that?</i>”");

		menu();
		addButton(0, "Yes", doFarmFuckery);
		addButton(1, "No", noPlzDontFuckWithFarm);
	}
}

private function doFarmFuckery():void
{
	clearOutput();
	outputText("Holli closes her eyes and hums. The sound seems to reverberate in your bones, and you feel the ground move uneasily below you. Holli’s roots shift ponderously, and you hear new growth crackling, burying eagerly through the soil, moisture being taken in. The tree woman opens her eyes to lazily grin at you as the portentous sounds below you continue.");

	outputText("\n\n“<i>It’s happening. I hope you and your doggie enjoy what I have done!</i>”");

	flags[kFLAGS.FOLLOWER_AT_FARM_HOLLI] = 1;
	
	doNext(camp.returnToCampUseOneHour);
}

private function noPlzDontFuckWithFarm():void
{
	clearOutput();
	
	outputText("“<i>Such a fickle mortal,</i>” she sighs. “<i>But I am a kind goddess. Ask me for it anytime, assuming you’ve... performed the rites.</i>”");
	
	treeMenu(false);
}

private function fertilizeHolli(cock:Boolean = true):void {
	//20% chance per sexing.  Up to bonus 20% for jizz or fertility! Max 62%.
	var odds:Number = 20;
	if (cock && player.hasCock()) {
		odds += player.cumQ()/300;
		if (odds > 40) odds = 40;
		if (player.findPerk(PerkLib.MaraesGiftStud) >= 0) odds += 10;
		if (player.findPerk(PerkLib.FerasBoonAlpha) >= 0) odds += 10;
		if (player.findPerk(PerkLib.ElvenBounty) >= 0) odds += 2;
	}
	if (!cock && player.hasVagina()) {
		odds += player.totalFertility()/5;
		if (odds > 40) odds = 40;
		if (player.findPerk(PerkLib.MaraesGiftFertility) >= 0) odds += 10;
		if (player.findPerk(PerkLib.FerasBoonBreedingBitch) >= 0) odds += 10;
		if (player.findPerk(PerkLib.ElvenBounty) >= 0) odds += 2;
	}
	if (odds >= rand(101)) {
		flags[kFLAGS.HOLLI_FRUIT] += 1 + rand(Math.floor(odds/10));
		trace("Holli pregged!");
	}
}


//Sprout Phase: (edited)
public function getASprout():void {
	clearOutput();
	outputText("Around the edge of your camp, you spot some plant-life beginning to sprout.  The barren, wasteland crust is fractured and broken, giving up a leafy green shoot.  It only reaches up to your knee, but the plant looks healthy and young.  Perhaps it will grow larger?  There is a central stem that supports most of the weight, but a dozen branches fork off, supporting a bevy of shiny green leaves.");
	outputText("\n\nYou briefly wonder how something could take root in such soil and be so successful, but then you recall the corrupt goddess, Marae.  She mentioned something about having roots through this world, didn't she?");
	if (flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] == 2) outputText("  She even promised to plant a tree in your camp...");
	outputText("  You look closer and see purple veins on the undersides of the leaves, throbbing with what can only be the tainted liquids that suffuse much of this planet.  Fully grown, it might spread its corruption to your camp.\n\n<b>Do you destroy it?</b>");
	flags[kFLAGS.FUCK_FLOWER_LEVEL] = 1;
	flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] = 0;
	//[Yes] [No]
	simpleChoices("Yes", destroyDatFukkinTree, "No", letZeFuckingSproutLive, "", null, "", null, "", null);
}
//[Yes] Destroy Tree (edited)
private function destroyDatFukkinTree():void {
	clearOutput();
	outputText("You reach down and begin to excavate meticulously around the tainted sapling.  It has one central root that seems to go down forever, but after you've uncovered half a foot of taproot, you grab hold of it and yank.  At first, your straining seems unnoticed by the plant, the leaves rustling as it shakes and strains under your grip.  Then, all at once, it gives with a violent SNAP.  You tumble end over end, clutching to the demon-flora tightly to your [chest].  Sighing and grumbling, you get up and toss the leafy demon into your fire.");
	outputText("\n\nSparks and smoke issue; the fire burns purple and low as it struggles to consume the resilient plant.  Fading slowly, the wilting flames look as though they're about to go out; you scramble to add fuel to the guttering fire before it dies entirely.  Each chunk of dry wood that you add seems to help, and soon the rosy red of all-consuming heat has returned.  The plant's stem withers away into charred, black ash.");
	outputText("\n\nYou have a hopeful feeling that you won't see any more of those plants cropping up.");
	//(-5 corruption)
	dynStats("cor", -5);
	flags[kFLAGS.FUCK_FLOWER_KILLED] = 1;
	doNext(camp.returnToCampUseOneHour);
}
//[No] (edited)
private function letZeFuckingSproutLive():void {
	clearOutput();
	outputText("Looking down at the sapling, you stay your wrath.  It may be corrupt, but it hasn't done anything to harm you just yet.  You give it a little pat on the uppermost leaves and leave it be.  It's not like it's going anywhere.");
	outputText("\n\n(<b>'Plant' added to your items menu</b>.  It's too small to know what it will grow into yet.  You can currently remove it at your leisure.)");
	doNext(playerMenu);
}

//Phase 2: Pussy Tentacle Flower Phase (edited)
public function fuckPlantGrowsToLevel2():void {
	clearOutput();
	flags[kFLAGS.FUCK_FLOWER_LEVEL] = 2;
	flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] = 0;
	outputText("The sound of creaking, snapping vines draws your attention to the corner of your camp, where the small plant had grown.  You rush in that direction without delay, raising your [weapon] in case you need to fight.  The violent noises die away before you can round the last large stone in the intervening distance, leaving you to wonder just what transpired.  Well, you don't have to wait long - you come around the obstruction at top speed, skidding to a stop at the view before you.");
	outputText("\n\nWhere once there was a small, tree-like sapling, there is now a waist-high flower of exotic colors and proportions.  The central stalk is much thicker than it was before, and though the familiar leaves are still there (in greater number), the obscene flower topping the plant is what really draws your eyes.  Vibrant purple petals spread over a two foot diameter, turning iridescent as they curve into a large, central bulb.  Inside that cavity, there're dozens of stamen surrounding a central style that's flared roundly and mottled; the plant-organs are moving about unlike any you've ever seen before.  They look... sexual.  More like something that belongs in a crotch than a flower.  As you watch, the vibrant petals moisten, their surfaces going slick with nectar so sweet and warm it fogs the air above the flower into a heady steam.");
	outputText("\n\nYour skin flushes as you react to the obvious, sexual enticements of the sprout, realizing it wants you to fuck it.");
	if (player.gender == 0) outputText("  Sucks to be it!  You don't waste time with stupid shit, like genitals.");
	outputText("  Is this Marae's idea of a gift?");
	if (player.gender > 0) outputText("  Well, you could give it a whirl... just being around it seems to slowly turn you on.");
	outputText("  Of course, destroying it would be the safest option.");
	dynStats("lus", 33, "resisted", false);
	if (silly()) outputText("\n\n<b>What do?</b>");
	else outputText("\n\n<b>What do you do?</b>");
	//[Fuck It] [Ride Stamen] [Do Nothing] [Destroy It]
	var fuck:Function = null;
	if (player.hasCock() && player.cockThatFits(100) >= 0 && player.lust >= 33) fuck = fuckFuckingFuckFlowerP2;
	var ride:Function = null;
	if (player.hasVagina() && player.lust >= 33) ride = rideDatFuckingFukkFlowerP2;
	simpleChoices("Fuck It", fuck, "Ride Stamen", ride, "Do Nothing", playerMenu, "Destroy It", destroyDatFuckingPlantAtP2, "", null);
}




//Destroy It (edited)
private function destroyDatFuckingPlantAtP2():void {
	clearOutput();
	outputText("You know that letting this thing continue to grow would only threaten the safety of your camp.  Sighing, you trudge over to your supplies, gathering up some dry wood to stack around the invading foilage.  The plant, as if knowing what you're about to do, begins to wiggle from side to side, petals quivering in a panic.  However, your course is set, and this plant must die.  You take a burning log from your fire and torch the pile, feeling a little better about yourself as the blaze slowly consumes the wilting demon-plant.");
	outputText("\n\nThe fire flutters, smoky purple sparks shooting into the air, blotting out the sky.  You cough and step back from the conflagration, waiting until it burns itself out and nothing but ash remains.  You have a hunch you won't be seeing any more of those plants... hopefully.");
	//(-5 corruption)
	dynStats("cor", -5);
	flags[kFLAGS.FUCK_FLOWER_KILLED] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//Fuck It (skimmed)
private function fuckFuckingFuckFlowerP2():void {
	clearOutput();
	var x:int = player.cockThatFits(100);
	if (x < 0) x = player.smallestCockIndex();
	outputText("Undoing your [armor], you approach the pulsating plant with one thought in mind: fucking it.  At the sight of [eachCock], the petals flutter happily, their surface glimmering with moisture in an instant, slick and wet for your pleasure.  You lean down to inhale the sweet yet sensual nature of the flower's aroma, letting it tickle your nostrils as you idly fondle [oneCock].  Your maleness quickly assumes your favorite state - hard and sensitive, ready to plunge into the nearest set of wet lips with reckless abandon.  At the same time, you can see the wriggling tendrils inside the flower's vase waving about hungrily.");
	outputText("\n\nYou laugh in amusement; who are you to deny it the creamy treat it so richly deserves?  Letting go of your " + player.cockDescript(x) + ", you reach around the soft petals to the harder, central bud and slide yourself through the honeyed embraced into the pulsating, tentacled flower-core.  Juicy warmth snuggles about your dick, the velvet-soft chamber immediately tightening up while the petals fold in, crossing over one another until they form a tube long enough to swallow you whole.  Gentle suction begins to rhythmically tug at your " + player.cockHead(x) + ", swelling you larger and more sensitive inside.  Immediately, the tiny tendrils you saw swarming around earlier reach up to massage your cock, slithering across your skin like tiny, sinuous snakes.");
	outputText("\n\nIt's enough to make your [legs] quake, and you slowly slide to the ground.  The flower, now a tightly-sealed bulb, sucks hard enough to stay latched onto you as you recline.  It makes the stem double over, but the resilient plant seems to handle the strain with ease.  Rivulets of clear slime escape from the tight seal to run down your ");
	if (player.balls > 0) outputText("[balls]");
	else outputText("[legs]");
	outputText(" and form a sticky puddle.  Now moaning, you grab the stem and start to pump the sheath up and down, using the plant like the cock-toy it was meant to be.  Lewd, wet squishes ring out through the air,");
	if (player.cor < 33) outputText(" and you timidly look around, hoping you haven't attracted an audience.");
	else if (player.cor < 66) outputText(" and you worriedly glance around, hoping yet terrified that someone will walk in on it.");
	else outputText(" and you glance around, hoping someone will walk in on the sexy show you're making.");
	outputText("\n\nNow panting with unbearable lust and undeniable levels of pleasure, you give up all sense of propriety and resort to fucking wildly, [hips] jumping inches into the air.  The flower's interior is a slick, silky heaven for your " + player.cockDescript(x) + ", a sucking, squeezing hole of seemingly infinite pleasure.  Inside its gluttonous gullet, the numerous tentacles twist around, the longest ones circling the base of your shaft");
	if (player.hasSheath()) outputText(" inside your violated sheath");
	outputText(".  With so much blood trapped in your " + player.cockDescript(x) + ", it's bigger and harder than ever, twitching valiantly against its restraints with every beat of your heart.");
	outputText("\n\nOne of the tentacles circles your " + player.cockHead(x) + " for a moment, and without much warning or pause, it lances forward to bury itself into your vulnerable cum-slit.  Your preconceptions are turned on their heads when there's a complete lack of pain from the abrupt penetration.  If anything, it actually feels kind of good... like there's a warm, slippery finger caressing your penis from the inside out.  It slithers in and out of you, pumping you inside, burrowing pleasure into your center even while stroking you from without.  Your body, burning from the exertion of fucking the flower's pod and the constantly-rising tidal wave of lust, begins to twitch spasmodically.");
	outputText("\n\nThe internal suction spikes as your dick bloats larger, and with a roar of bestial pleasure, you arch your back, hands pushing your " + player.cockDescript(x) + " as deep into the plant's gullet as possible.  ");
	if (player.balls > 0) outputText("Your [balls] gurgle, a surprisingly happy sound, and cling tight to your loins.  ");
	outputText("Inside you, you can feel the liquid heat of your spurting release exploding out, melting everything before it with liquid, orgasmic bliss.  A low moan bursts from your lips when the sounding tentacle pulls out of your sloppy cock-slot, and the rushing tide of bubbling cum follows it, bursting into the sweet, suckling nectar-pot.");
	if (player.cumQ() > 500) outputText("  You pour forth your prodigious essence without pause or fail, and the plant immediately begins to drink it down, the stem bulging with rounded balls of sperm that it carries underground.");
	if (player.cumQ() > 1500) outputText("  Soon, the meager stem cannot swallow it all.  Spunk froths and squirts out around the base of your tool for a moment, and then a veritable tide of the stuff gushes out to soak  you.");
	outputText("\n\nSatisfied and a little exhausted, you slump down and release your grip on the creampied fuck-flower.  It slowly, laboriously removes itself from around your orgasm-bloated shaft, cleaning the sperm from it as it goes.  There's a visible swallowing motion, and a globular bulb moves down the stalk into the ground.  Once the stalk stands fully erect, the petals bloom back into the flower, the only hint of your tryst a milky-white sheen upon the purple petals.");
	player.orgasm();
	dynStats("cor", 1);
	flags[kFLAGS.TIMES_FUCKED_FLOWER] = 1;
	if (flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] < 1000) flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] += 4;
	player.changeFatigue(5);
	doNext(camp.returnToCampUseOneHour);
}

//Ride It (skimmed)(coded)
private function rideDatFuckingFukkFlowerP2():void {
	clearOutput();
	outputText("You shuck your [armor] and slowly ease yourself towards the violet-hued creature.  As soon as you get within a few feet, the flower's bulb angles toward you, the petals wiggling slightly along with the stamen inside.  A few of them even stretch out towards you like longing fingertips, shaking slightly from the effort before sliding back inside.  The dull ache in your [vagina] grows a few degrees hotter at the display, your body growing flush with excitement for the coming copulation.  Throwing caution to the wind, you move forward with a confident sway of your [hips].  It's time to get pollinated.");
	outputText("\n\nGrabbing hold of the plant, you tug it up against your mons and sigh.  The silky-smooth petals flatten against your thighs, the tips curling over to touch the sides of your [butt], slicking it with lubricating moisture.  You let go, and the flower holds fast to your [hips], firmly embracing you as its stamen begin to roam across your vulva.  Slowly, an intrepid tentacle ventures between your labia, into the slick passageway you're so ready to fill with wiggly delight.  A dribble of fresh fluid rushes out at those first, hesitant touches, and encouraged by its success, the stamen's brothers join in on the slippery party, plunging into your box and immediately swirling over your inner walls.");
	outputText("\n\nDriven mercilessly by the sudden onslaught of sensation, you flop back onto the ground, but the flower comes with you, latched onto your [hips] with no sign of releasing.  The swirling tentacles twist around inside you in a tornado of ecstasy, and the pleasure, that awful, unstoppable pleasure, twists your muscles into knots.  They instinctively convulse to raise your lower lips higher, as if that would somehow propagate even deeper penetration.  One of the tentacles retracts, drawing a burst of slick cunt-lube with it.  Then, it twists around your [clit], tightening up on the over-sensitive bud until it feels like it could pop.");
	if (player.clitLength > 4) outputText("  Your heavy buzzer is so big that the flexible plant-cock has plenty of room to curl around it, and if you could see it, your clit would look almost like a candy-cane (if one set of stripes was jerking off the cane beneath).");
	if (player.cockTotal() > 0) outputText("  [EachCock] soon has its own partner twisting around it, a pussy-slicked vine to jerk and twine about its girth.");
	outputText("\n\nWith nothing to occupy your roving hands, you let them slide up your " + player.skinFurScales() + " to your ");
	if (player.bRows() > 1) outputText("lowest row of tits, cupping them before groping to your top row of breasts");
	else outputText("[chest]");
	outputText(", caressing the");
	if (player.biggestTitSize() > 1) outputText("ir");
	outputText(" swell as you search for the lust-tightened skin of your [nipples].  They seem almost as sensitive as little clits, and as soon as you find them, you immediately set to circling them slowly, occasionally tugging and twisting when a particularly powerful sensation works through your pleasure-wracked body.");
	if (player.lactationQ() > 50) {
		outputText("  One after the other, they begin to ");
		if (player.lactationQ() < 150) outputText("trickle");
		else if (player.lactationQ() < 500) outputText("leak");
		else outputText("spray torrents of");
		outputText(" milk.");
	}
	outputText("  You moan in unabashed delight, your mouth hanging open in a mindless, blissful 'o' in between vocalizations.  If your friends back home could see you now, writhing in the dirt, face open in simple, animal pleasure, and perhaps worst of all, fucking a plant, you'd die of ");
	if (flags[kFLAGS.PC_FETISH] == 0 && player.cor + player.lib < 150) outputText("embarrassment");
	else outputText("lust");
	outputText(".");
	
	outputText("\n\nWith that thought somehow staying firmly in your battered consciousness, you reach a climax of mind-breaking proportion, eyes rolling wildly as every muscle locks in one united twitch of rapture.");
	if (player.hasCock()) outputText("  [EachCock] explodes in release, pumping heavy flows of seed into the petals, even as y");
	else outputText("Y");
	outputText("our quivering pussy, already sopping wet, releases the last of your juices in a soaked ");
	if (player.cumQ() < 50) outputText("drizzle");
	else if (player.cumQ() < 250) outputText("stream");
	else if (player.cumQ() < 750) outputText("spray");
	else outputText("torrent");
	outputText(".  The tentacles inside you curl in on themselves and slowly pull back from the well-creamed quim, scraping out as much fluid as possible from your oversensitive honey-pot.  The binding on your [clit] releases, which of course sets off a whole new wave of rippling pleasure-contractions in your cunt.");
	
	outputText("\n\nYou swoon from it all, your body slowly relaxing, sinking back to the ground.  The fuck-flower visibly swallows your juices, a bulge visible on the stem.  It detaches with a hungry pop, strands of its slime webbing the space between person and plant for a second before it withdraws completely.  Slowing gradually, the corrupt greenery resumes its formerly placid, open state, aimed at the sky.  You can see the tentacle-like stamen still wiggling inside, but they seem a little more lethargic now.  Your [vagina] twitches in rememberence of their caresses, and you wonder when you'll take advantage of this wondrous gift next.");
	player.orgasm();
	dynStats("cor", 1);
	player.changeFatigue(5);
	flags[kFLAGS.TIMES_RIDDEN_FLOWER] = 1;
	if (flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] < 1000) flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] += 4;
	doNext(camp.returnToCampUseOneHour);
}

//Phase 3 Intro: (edited)
public function flowerGrowsToP3():void {
	clearOutput();
	outputText("Again, you hear odd noises coming from a corner of your camp - the corner where you let that tainted shrubbery grow.");
	if (flags[kFLAGS.TIMES_FUCKED_FLOWER] + flags[kFLAGS.TIMES_RIDDEN_FLOWER] > 0) outputText("  The fucking probably only helped it to grow faster.");
	outputText("  The distinct sound of wood bowing and creaking under new weight catches your ears, and well before you can get to the plant, you can see a leafy canopy stretching towards the sky.  <b>It's grown into a small tree, with bark, leaves, and everything!</b>  Warily, you round one of the ancient standing stones to get a better look.");
	outputText("\n\nThe first thing you notice is that the vaginal tentacle flower remains, affixed at waist height to the side of the tree.  It looks bigger, the petals huge and glossy, undoubtedly far more capable of swallowing dick than ever before.  The tree isn't that thick, just yet.  Glancing further up the smooth, knotless trunk, you see the most surprising thing of all - a pair of almond-colored nipples, perched upon small, tit-like bulges in the wood.  The bark on these globular protrusion is smoother and fairer than the surrounding surface.  On one of them, a trickle of sap has formed into a heavy bead, and it smells sweet, like maple syrup.");
	outputText("\n\nA dollop of something moist landing in your hair startles you from your visual inspection.  Gingerly, you touch your fingers to the wet spot and come away with a thick, viscous fluid that smells faintly musky... and salty...  It's cum!  You recoil, looking up in time to see a half dozen tentacles curling between the branches rubbing against each other in what can only be described as an orgy of frotting cock-lust.  Well now, your little pet plant is growing up.  There's no easy way to get rid of it now");
	var burnIt:Function = null;
	if (player.findPerk(PerkLib.Dragonfire) >= 0 || player.findPerk(PerkLib.FireLord) >= 0 || player.findPerk(PerkLib.Hellfire) >= 0 || player.findStatusEffect(StatusEffects.KnowsWhitefire) >= 0) {
		outputText(", though you suppose you could burn it down with magical fire if you set your mind to it");
		burnIt = torchP3Tree;
	}
	flags[kFLAGS.FUCK_FLOWER_LEVEL] = 3;
	flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] = 0;
	outputText(".\n\n<b>What do you do?</b>");
	var fuck:Function = null;
	var ride:Function = null;
	if (player.hasCock() && player.lust >= 33) fuck = fuckTheFlower;
	if (player.hasVagina() && player.lust >= 33) ride = rideTheWalrusP3;
	//[Fuck flower] [Drink Sap] [Ride Tentacles] [{Torch It}] [Leave It]
	simpleChoices("Fuck Flower", fuck, "Drink Sap", drinkThePlantGirlsSap, "Ride Tentacle", ride, "Torch It", burnIt, "Leave It", playerMenu);
}

//Fuck Flower (skimmed)
private function fuckTheFlower():void {
	clearOutput();
	var x:int = player.biggestCockIndex();
	//(Similar to stage 2 fuck, but no cock limits, wetter, and more aggressive.
	outputText("Smiling to yourself, you shed your [armor] like a snake wriggling free of useless, old skin and expose yourself.  Of course, the tree doesn't react - it's just a tree, right?  So, feeling a little cocky (in more than one way), you prowl up to the flower, intent on venting some frustration in the best way possible.  The petals are as violet as ever and glittering with the moisture you've grown used to seeing appear whenever you approach, as if by magic.  The inner folds look even softer, if a bit redder, and they drip steadily with sweet nectar.");
	outputText("\n\nYou bend down for a sniff - nothing like a little foreplay, after all.  The flower-cunt's scent is spicy-sweet and undeniably potent.  The air visibly steams with the wood-bound box's honeyed heat, and you close your eyes to better appreciate it.  There's a distinct, feminine undercurrent to the odor, a cloying aroma that clings to your nostrils, sending a pleasant tingle to your loins.");
	if (player.hasVagina()) outputText("  Wetness builds in your [vagina] as well, but you're focusing on your maleness just now.  Your neglected twat will have to wait its turn.");
	outputText("  A feverish sweat breaks out on your brow, though whether from your own arousal, the plant's heat, or some chemical in its juices, you cannot tell.");
	
	outputText("\n\nBefore you can pull back, the hiss of something cutting through the air with lightning speed hits your eardrums.  Almost at the same time, tentacles (stamen?) snap around your neck, head, and ears, going taut in an instant.  Your " + player.face() + " is pulled roughly into the glossy hole, the soft folds of the petals smearing your nose and mouth with their saccharine sweetness.  You cannot help but breathe in more deeply as you struggle for your freedom, and with every struggle, every struggling gasp, [eachCock] grows hotter and harder, pulsating with tactile hunger.  With each moment that passes the motivation for your struggles shifts from freedom to fucking.  You don't care about getting away so much as getting your dick in this aromatic fuck-pot.");
	
	outputText("\n\nYou claw the whip-like vines from your face in a frenzy and fall back, tumbling end over when the tension suddenly gives way.  Landing flat on your back and gasping, you immediately try to rise, spurred on by the white-hot desire burning in your groin.  Tentacles drop down as you climb to your [feet], and they loop under your arms, around your shoulders, and even over your [chest].  They hoist you up before you can get your [feet], another vine twisting your wrists together behind you, immobile.  You foolishly pump your hips forwards, struggling to reach the plant's puckered opening, but the attempt bears no fruit.");
	
	outputText("\n\nRacking your brain for ideas, you momentarily slump into a temporary acceptance of your position, sagging heavily into the strong, fibrous tentacles.  Perhaps that's what the unnatural creature wants, for as soon as you let it have control, the tendrils swing you closer, close enough for [oneCock] to kiss the warm, wet hole.  Momentum carries you away from the promise of greater pleasure, your " + player.cockDescript(x) + "'s tip nicely moistened by lubricants and its own heavy bead of liquid pleasure.  When you swing back, a few inches are lucky enough to nestle inside, and you find yourself moaning without meaning to.");
	
	outputText("\n\nYou're swung to and fro, held aloft by a shrubbery harness seemingly intent on teasing you.  First, you get a taste of heaven, but only on your " + player.cockHead(x) + ".  Then, you're left to flutter in the breeze, the only sexual sensation available the cool wind fluttering across your whetted tip.  Over and over, the plant teases you until you lose track of time.  The closest thing to a watch you have is the gentle throb in your [balls] and its gradually strengthening intensity.  Oh, how it aches!  You feel taut and stretched like a harp string being tuned, only the musician just keeps cranking away, ratcheting up the pressure until you feel about to snap.  Your one comfort is the momentary bliss of the flower's sweet kiss, an exciting pleasure that's slowly being turned into an aching hell.");
	outputText("\n\nDuring a particularly shameless moan, you realize that you're dipping a little deeper with each pendulous stream.  Luckily, the corrupt tree's arboreal lust must be rising like your own, and after a few slow swings, your " + player.cockDescript(x) + " is slipping three quarters of the way in");
	if (player.cockArea(x) >= 150) outputText(", sliding down the trunk as easily if the entire inside was a giant pussy just waiting to get fucked");
	outputText(".");
	if (player.cockTotal() > 1) {
		outputText("  Your other penis");
		if (player.cockTotal() > 2) outputText("es rub");
		else outputText(" rubs");
		outputText(" sensually across the moist outer blossom, drooling their clear pre-cum over the petals.");
	}
	outputText("  Schliiick.  You slide out.  Slorp-pop.  You slide in, this time to the ");
	if (player.hasSheath()) outputText("sheath");
	else outputText("base");
	if (player.balls > 0) outputText(" with your gurgling balls slapping against the flower's edge");
	outputText(", accompanied by a small squirt of sweet lubricants.");
	outputText("\n\nYou've been kept on edge for so long that even this brief taste of liquid-soft snugness has your body clenching and warm bliss mounting inside of you.  You wrap as much of your [legs] around the trunk below as possible and give into your pleasure, thrusting your " + player.cockDescript(x) + " against the petalled muff each time the vines draw you away.  You rut like a demon's pet, half-mad with pleasure and desire so powerful it obviates rational thought.  The ecstasy rises like an all consuming tide, tinting your vision pink as your eyes roll back and [eachCock] thickens.");
	
	outputText("\n\nJizz blasts out of your " + player.multiCockDescriptLight() + " with uncommon force, painting the flower's interior with white");
	if (player.cockTotal() > 1) outputText(", as your multiple endowments allow you to drizzle the purple bloom's exterior with alabaster cream");
	outputText(".");
	if (player.cumQ() > 500) outputText("  Pearly ropes big enough to fill a flask lurch out from your cum-slit, propelled by your quivering orgasmic muscles deep into the trunk, and you swear you can hear the pitch of your sexual pumping rising in tone, changed by the flooded vessel.");
	if (player.cumQ() > 1500) outputText("  A wave of your thick gunk rolls out from under your pumping cock - you've filled the tree beyond even its capacity, and the thick puddle forming beneath your [feet] is all the proof you need of your virility.");
	if (player.hasVagina()) {
		outputText("  Your hungry cunt, long denied in this exchange, trembles as it ");
		if (player.wetness() < 4) outputText("leaks");
		else outputText("sprays");
		outputText(" your own female fluids in sympathy.");
	}
	outputText("  After what feels like forever, the spurting seed no longer flows from your long-abused dick, and as your member softens, the tentacles swing you away, setting you down softly.");
	
	outputText("\n\nYou sigh, utterly exhausted and drained of sperm.  What a rush!  Your [armor] slips on easily after that ordeal, though your muscles are a bit sore.");
	player.orgasm();
	dynStats("cor", 1);
	player.changeFatigue(5);
	if (flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] < 1000) flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] += 5;
	flags[kFLAGS.TIMES_FUCKED_FLOWER]++;
	flags[kFLAGS.HOLLI_FUCKED_TODAY] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//Drink Sap (edited)
private function drinkThePlantGirlsSap():void {
	clearOutput();
	//Regain 50 fatigue but gain 1 corruption, .5 libido, 15 lust, and 1 sensitivity.
	dynStats("lib", .5, "sen", 1, "lus", 15, "cor", 1);
	player.changeFatigue(-50);
	outputText("Feeling like you could use a pick-me-up, you prance up to the tree-boobs and give them an appraising look.  The're pert and rounded, smooth despite the roughness of the bark around them.  When you touch one, it feels warm, soft, and exquisitely tender, just like a breast should.  A small droplet beads on the tree-tit and drips on the ground while you man-handle it, smelling strongly of maple syrup.  Chuckling at that, you run your finger around the almond-colored protrusion and gather up a touch of the fluid.  The digit tastes sweet in a comforting, familiar way, and when you remove your sticky finger from your lips, you look back with undisguised hunger.");
	outputText("\n\nThe tree's nipples look larger and harder after your inspection, and when you take one into your mouth, it immediately releases a trickle of its amber syrup onto your hungry tongue.  A shiver runs down your spine from the sweet taste, a rush of sugary delight invigorating your body as you drink.  Unfortunately, the tree's tit soon empties of its delicious treat, and you have to slide around to the other.  You wrap your arms around the trunk for stability as you suck");
	if (silly()) outputText(", tree hugger that you are");
	outputText(".  The thick 'milk' quickly fills your body with energy, though it runs out nearly as soon as it started.");
	outputText("\n\nYou wipe your slightly sticky mouth on your arm and sigh with the act done, admiring the slightly rosy tinge of the now-smaller breasts.  This whole thing is weird as hell, but you're as full of energy as ever after the snack.");
	doNext(camp.returnToCampUseOneHour);
}

//Ride Tentacles (C)
private function rideTheWalrusP3():void {
	clearOutput();
	//(Let them pull you into the tree and bang, battering you with cum repeatedly.)
	outputText("You eye the tentacles hiding amongst the leafy branches above, writhing obscenely around each other as they snake through the foilage.  You shed your [armor] into a worthless pile and bare your body, cupping your [chest] enticingly as you whistle up at the tree.  Your calls seem to fall on deaf ears; the whirling vines stay put up in their perch.  They're ignoring your delicious, feminine flesh!  Irritated, you stomp up to the trunk's flower and plunge your fist inside it.  Fresh fluid gushes out over your armor, releasing a spray of sweet, musky lubricants.  You blindly feel around inside the pliant plant-pussy with your fingers, giggling to yourself whenever the soft cavity clenches tightly to your arm.  Whatever this is, it can feel pleasure.");
	outputText("\n\nEgging it on, you pump away until there's a waterfall of clear slime oozing down the bark, the heavy folds inside clamping tightly about your forearm.  Inside, smaller tentacles twist around your fingertips, mindlessly jerking them off as if they were tiny cocks.  You smirk and pull your arm out with deliberate slowness, ignoring the hungry suction that tries to pull you back in and the twisting tendrils that snake out after you.  Now that you've taken the corrupted creature into a more empathetic position, you spread your arms to the vines above and call for them, \"<i>Come on down and play.  We both want this.</i>\"");
	outputText("\n\nThis time, the tendrils DO react, dropping down in a circle around you and lifting their purple, engorged tips to scent the air.  That's what it looks like anyhow, you aren't sure how a prehensile penis could possible smell you, but they nuzzle against your juice-slathered wrists like they're drunk on pussy-musk.  You grip one tenderly, admiring the smooth stalk and small, vein-like textures that decorate it.  It produces a dollop of clear pre-cum that slowly rolls down the underside to your palm in response.  Smiling wide, you bring it lower, to the joint of your female delta, and rub it across your own slickening lips.  The touch of your hot juices seems to invigorate the lethargic cock-snakes, and as one, they begin to loop around your extremities, homing in your loins and stained arm.");
	outputText("\n\nWith a sweet sigh, you spread your arms and let the surprisingly talented feelers take you.  One wraps around your midsection on its way down to your claimed [vagina], cinching around you with gentle tightness.  A trio of verdant vines hooks under your armpits, two on the wet side, and one on your dry, unscented arm.  They really like the smell of cunt, even their own.  A mass of them gathers in and around your [legs], and as soon as they wrap you up tight, the whole group of them begins to lift you up.  A tremor of worry runs through your stomach, but a slow, gentle prodding in your [vagina] does much to assuage your worries.  Another, smaller cock circles around its lucky brother, pressing its tip insistently at your [clit] while the first slowly penetrates you.");
	//cuntChange:15
	player.cuntChange(15,true,true,false);
	outputText("\n\nYour [nipples] go hard; whether from the penetration, reek of sex, or body-caressing vines, you cannot say.  A few more loops of plant-cock surround you, to the point where you're beginning to wonder if this is what a snake's prey feels like, bound up with smooth coils that cling tightly to every curve of your body.  Pumping slowly, the tentacle you eased into your [vagina] begins to fuck you with meticulous slowness.  The surface of the slick shaft turns glossy with your lust and wriggles pleasantly inside you, twirling around in a ballet of unnatural motions that make you feel like you're atop a tornado of sexual pleasure.  Between that and the numerous coils gliding across your sensitive nipples, you throw back your head and moan with unrestrained delight.");
	outputText("\n\nOne industrious tool rears back, then thrusts itself past your gaped lips, across your thrashing tongue, and deep into your throat.  This cuts off your vocalizations, turning them into a weak 'mphh' that cuts off entirely once the wiggly prick plunges deeper.  It loops its exposed bulk first around your head to block off your vision, and then lower, around your neck.  It cinches closed quickly, tightening up your violated throat into an even tighter cock-sleeve for itself to fuck.  Bulges of ropey plant cum work their way down the tunnel-like cock, distending it to such a degree that you can feel it on your tongue as it passes inside you.  You don't get to taste the stuff, since it's injecting itself directly into your gut, but you can feel it flowing through you, filling you with warm, goopy plant-sperm.");
	outputText("\n\nMeanwhile, down south, your sodden snatch is squishing lewdly with the slow, methodical penetration.  The other tentacles are worming forward, and first one, then another find their way inside your loosened cunt.  You feel stretched to an almost unpleasant degree, but with three cocks sliding in and out to different tempos, twisting and sliding over your sensitive walls and each other, the pleasure drowns out the discomfort.  You squirm in your bindings as your [vagina] gives in to being relentlessly, unflinchingly taken, and you moan, voice muffled while your eyes roll back into your head.  Your hands idly begin to caress the closest cocks, and you soon give yourself completely over to their attentions.");
	outputText("\n\nYou hang in the tree for what seems like forever, somehow able to breathe with a dick down your throat to your belly, your pussy completely violated and your hands tending to the unsatisfied cocks seemingly of their own volition.  Or perhaps you just enjoy being surrounded by so much male flesh, pleasuring it all while you're used as a cum-hungry fuck-dump.  Your head is hazy from something in the cum or the frequent orgasms you're enduring, and when the first tentacle to take your cunt thickens and releases its load, you black out momentarily.");
	outputText("\n\nWith your vision hazy and swimming, you open your eyes to a world upside-down.  You're still suspended in the tentacles, and your body is absolutely covered in alabaster spunk.  Rivulets of it drip from you, and you idly squeeze a tentacle, giggling around the cock in your throat when it pours out a fresh sample to further soak you.  Your belly is full of spooge and wiggling tendrils, visible to anyone lucky enough to catch a glimpse of it through your bindings.  Coming from the other side, at least two cocks are twined into an anal double-helix, their passage lubricated by the copious cum running down your [butt].  You tremble again with barely any strength in your limbs and cum.  The orgasm, like you, is worn out and weak, nearly worthless in comparison to how good it felt when this all started.");
	outputText("\n\nYou endure it all with wordless pleasure, your eyes vacant and spacy.  Your brain shuts down, and you simply go weak.  The tentacles, for their part, continue to take you with unhealthy levels of ardor, your body growing more and more cum-plastered until it's hard to make out your shape beneath all the dripping jizz and undulated, snake-like shapes.  The orgasms that follow are pitiful, pathetic punctuations of pleasure  that can't even spur your laconic muscles into movement.");
	outputText("\n\nAt some point, you are set back down on the ground and sprayed with a fresh batch of seed.  You rest there for a while, until you can catch your breath and move without pain.  When you start trying to clean up, you realize the puddle of cum is completely gone, likely swallowed back up the tree's hungry roots, and the only mess left is your sodden " + player.skinDesc + ".  You get dressed and stumble away a little drunkenly, your [vagina] raw and oozing.");
	//{- big sensitivity loss, big libido gain, minus lust}
	player.orgasm();
	dynStats("lib", 1, "sen", -5);
	if (flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] < 1000) flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] += 5;
	flags[kFLAGS.TIMES_RIDDEN_FLOWER]++;;
	flags[kFLAGS.HOLLI_FUCKED_TODAY] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//Torch It (edited)(C)
private function torchP3Tree():void {
	clearOutput();
	//Requires fire-based attack and fatigue at or below 30.  Maxes fatigue and removes the tree.
	outputText("This has gone on long enough!  This thing cannot continue to grow in your camp any longer, and you have just the means to remove it: fire.  ");
	//[(nerdfire)
	if (player.findStatusEffect(StatusEffects.KnowsWhitefire) >= 0) outputText("Closing your eyes to focus, you gather your energies, and unleash your white, supernatural flames upon the thing.");
	//(bromancefire)
	else if (player.findPerk(PerkLib.FireLord) >= 0) outputText("Sucking in your breath, you inflate your chest and stir the embers of the jaguar demon's gift.  Dredging up an enormous pine-green fireball, you exhale and launch it at the tree.");
	else outputText("Sucking in your breath, you inflate your chest and stir the embers of your fiery gift.  Dredging up an enormous fireball, you exhale and launch it at the tree.");
	outputText("  It goes up by the torch, though the fire starts to fade sooner than you would expect.  You huff, but repeat the action, layering a new blaze atop the previous one; you put all your concentration into this new conflagration, stoking the inferno with every ounce of your ");
	if (player.findStatusEffect(StatusEffects.KnowsWhitefire) >= 0) outputText("magical will");
	else outputText("breath");
	outputText(".");
	
	outputText("\n\nThis time, it stays suitably lit.  The tree makes a handy torch for a few hours while it burns to ash, but leaves behind a thick, cloying smoke that takes forever to dissipate.  At least that nuisance plant is gone for good.");
	player.changeFatigue(100);
	flags[kFLAGS.FUCK_FLOWER_KILLED] = 1;
	doNext(camp.returnToCampUseTwoHours);
}


//Phase Four (edited)
public function treePhaseFourGo():void {
	clearOutput();
	outputText("An unfamiliar female voice calls out your name, high-pitched and lilting.  Unflinchingly, you respond to the call, winding your way through your camp towards the fringe, where the corrupt fuck-tree was growing.  Did a faerie get caught in it? A tiny creature like that would probably wind up as a tentacle condom before it got free.  Still, you redouble your pace and ready your [weapon].  You know well enough that a fair voice doesn't always match up to a fair demeanor - in Ingnam OR Mareth.");
	outputText("\n\n\"<i>Oh, [name]!  Where are yoooouuu?</i>\" the voice croons.  You turn the bend to a sight both familiar and haunting.  There, in the middle of a wide, ancient-looking tree trunk, is a woman.  She's emerged from a split in the center of the wood, and she appears to be made of flesh, blood, and bone the same as anyone else.  However, she's obviously some kind of demon.  The corruption is most visible in her brown-gold eyes, tainting the sclera a solid black.  Above, a pair of gnarled oak horns sprout from her forehead, parting the woman's generous, dark green curls.  Her skin is a pale jade and as smooth as buttered glass, and her lips are full and pouty, curved in a knowing smile.");
	outputText("\n\n\"<i>Hello there, cutie,</i>\" the verdant succubi trills, crossing her arms across her weighty G-cup melons in feigned modesty, \"<i>");
	if (flags[kFLAGS.TIMES_FUCKED_FLOWER] + flags[kFLAGS.TIMES_RIDDEN_FLOWER] > 0) outputText("Did you enjoy feeding me?  You should have seen the expression on your face when you were cumming in me.  Your eyes were rolling back and your mouth was just hanging open.  Do you know what it made me want to do?");
	else outputText("Did you enjoy watching me grow?  You should have fed me.  It was so much harder to grow without proper nutrients.  Do you know what I thought about during all the time I spent waiting?  Do you know what it made me want to do?");
	outputText("</i>\"");
	
	outputText("\n\nYou shake your head dumbly.  This girl could very well be the corrupt goddess's sister, a demon-twin born of lust and simmering desires.  You still haven't quite gotten over her sudden appearance.");
	
	outputText("\n\n\"<i>It made me want to fuck you that much harder.  It made me want to take you again and again, in every way possible, bringing you to the peak of pleasure that you lust for it above all else and never want to leave,</i>\" the demon dryad explains while lifting an arm to brush an errant curl from her view.  Her other arm studiously remains clapped across her glossy, almond-colored nipples, but you still manage a quick glance.  She giggles, her melons jiggling with her breathing as she promises, \"<i>Mother Marae created me to be your gift.  Your personal attendant.  My name is Hollicynthea, but you can call me Holli.  I'm your very own cum-potted plant!  And I can see that you're already quite taken with me, aren't you?</i>\"");
	outputText("\n\nYou snap your eyes back up to her oddly-colored gaze just in time for her to drop the other arm away.  Of course, when you try to glance back down, she has her hands over her nipples again.");
	outputText("\n\n\"<i>Tut tut, you'll have to play with me if you want to see these...  I can't leave my tree, not for a few years, so you'll have to keep me nice and... warm,</i>\" she coos.  Below, you realize the familiar flower remains, though it looks almost dainty compared to its former glory.  It's now nestled between the woman's thighs, just above where her body merges back into the wood-grain, and the petals are folded closed into a modest bud.");
	outputText("\n\nThe demon-tree offers, \"<i>Come on, let's sate our lusts together.  If not now, then in a few hours, when championing pointless causes gets you all... hot and bothered.  And... maybe if you ask nicely, I'll even help to guard you while you rest.  Lesser creatures are so easily snared and toyed with.</i>\"");
	outputText("\n\nWell... you have a demonic plant-woman on your hands; a dryad by the legends of your homeland.  She looks harmless, so long as you don't stand too close, and she's quite the alluring sight.  What now?");
	flags[kFLAGS.FUCK_FLOWER_LEVEL] = 4;
	flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] = 0;
	dynStats("lus", 15);
	//[Load Camp Menu with no text]
	treeMenu(false);
	
}

//ojo Rolls Out -Z
public function JojoTransformAndRollOut():void {
	clearOutput();
	//triggers if both puru jojo and shoe tree are in camp
	outputText("\"<i>[name], come here please.</i>\"");
	outputText("\n\nJojo is calling to you from the border of the camp.  Politely, you approach the monk.  This is probably the first time since your rather violent initial meeting that he's addressed you so directly, and you're a bit curious as to why.");
	if (flags[kFLAGS.TIMES_FUCKED_FLOWER] + flags[kFLAGS.TIMES_RIDDEN_FLOWER] == 0) outputText("\n\n\"<i>Perhaps it had escaped your notice until now, but the portal site has a somewhat out-of-place... guest.  That tree actually contains a creature.</i>\"  He gestures toward the strange plant.  \"<i>I overheard it speaking to itself.  It seems to believe that it has been put here by Marae, but such a thing...  Anyone looking at that monster can see that it is a demon, not the kindred of a goddess.</i>\"");
	else outputText("\n\n\"<i>That plant you were... engaged with earlier seems to have grown.</i>\"  He gestures toward the humming, verdant woman, currently peeking from her tree boldly.  \"<i>I was going to encourage you to rid your campsite of such an abomination, but one of the things it keeps repeating to itself gave me pause.  It seems to believe it is a child of Marae - though anyone with eyes to see can tell that it's a demon.</i>\"");
	
	outputText("\n\nQuietly, you interrupt to break the bad news to Jojo; that you found Marae recently, quite corrupted and soulless, and that the growth in your camp does seem to be an offshoot of the now-twisted tree.  ");
	if (player.cor < 25) outputText("Not willing to lie to your friend, you also admit that she seems to have changed after your actions in the factory - that, though you were trying to render the tanks permanently inoperable, the spillage you created pushed the cthonic spirit over the edge.");
	else outputText("Though, you do leave out the precise, needless details of what caused the change.");
	outputText("  The monk's eyes widen in surprise and surmise.");

	outputText("\n\n\"<i>Unbelievable...</i>\" he blurts.  \"<i>");
	if (flags[kFLAGS.TIMES_FUCKED_FLOWER] + flags[kFLAGS.TIMES_RIDDEN_FLOWER] == 0) outputText("To think that I must now consider Marae herself my enemy.  Forgive me, but this place is not safe for us anymore if it has attracted the attention of such a creature.  For now, I will return to the forest.  I know that you believe your mission keeps you here, but I urge you to stay away from that thing and watch the portal from an adequate distance.");
	//(totally deflowered that flower)
	else outputText("And even knowing that this could be the case, you still chose to fornicate with it?  [name]... I cannot say that I am not disappointed.  This place is not safe for me anymore.  For now, I will return to the forest.");
	outputText("</i>\"");
	
	outputText("Jojo looks at you sadly; any argument you try to make is met with a resigned shake of his head.  \"<i>If the creature truly is the demonic offspring of a corrupted earth spirit, doubtless it will be powerful and the wrath of its parent severe.");
	if (player.level < 20) outputText("  Nonetheless, if you find yourself in a position where you must confront this demon or perish, call upon me.  I will render what aid I can, though I prefer it not be in vain.");
	else outputText("  Though, a mortal of your stature and resources may be able to destroy her and escape the reprisal.  I would counsel against direct confrontation until you are sure of victory, but if you must fight, then call upon me and you will have what aid I can give.");
	outputText("</i>\"  So saying, he presses a small talisman into your hand.");
	
	outputText("\"<i>Until then, you will find me in the forest if you need my assistance.</i>\"  Jojo makes a polite bow and departs.");
	outputText("(<b>Jojo is no longer a companion!</b>)");
	//no mo' Jojo; ho made schmo go
	//return Jojo to forest, get key item Small Talisman
	player.removeStatusEffect(StatusEffects.PureCampJojo);
	player.createKeyItem("Jojo's Talisman",0,0,0,0);
	
	doNext(playerMenu);
}

//Amily Hates Trees -Z
//new overriding line for Amily's camp descript if tree is there
//PC Fucked Adult Tree, Amily Leaves -Z
public function amilyHatesTreeFucking():void {
	clearOutput();
	outputText("Your mousey cohabitant tramps up to you, irritation plain on her expression.");
	outputText("\n\n\"<i>[name], I saw what you did with that that... tree.  I thought that was just one of those perverted plants you find in the forest, but there's an actual demon in it?!  I can't believe your poor judgment!  You do know what happens to people who give themselves to demons, right?  It hasn't slipped your mind that they rape and suck souls out of everyone they come across?  I don't even feel safe anymore with you bringing trash like that into camp!</i>\"");
	outputText("\n\nNo matter how you try to interrupt, Amily's not even giving you a chance to answer...");
	
	//[Stay Quiet][Slap Her]
	simpleChoices("Stay Quiet", stayQuietWhileAmilyBitchesAboutFuckingArborday, "Slap Her", slapAmilysWhoreFace, "", null, "", null, "", null);
}
//[Stay Quiet]
private function stayQuietWhileAmilyBitchesAboutFuckingArborday():void {
	clearOutput();
	outputText("Amily berates you for some while longer, then eyeballs you.  Just as you begin to speak, she cuts you off again.");
	outputText("\n\n\"<i>I'm not staying here anymore.  Maybe if you move or clean this place up, I'll return... maybe not.  Depends how many demons you insist on bringing home and fucking, I suspect.</i>\"");
	outputText("\n\nCurtly, she turns and departs, tail lashing past you.  You wonder just how sincere her last words were.");
	//put her in ruined village
	//maybe flag her to re-add if plant dies
	flags[kFLAGS.AMILY_FOLLOWER] = 0;
	//Set - amily flipped her shit
	flags[kFLAGS.AMILY_TREE_FLIPOUT] = 1;
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00173] = 0;
	//Enable village encounters
	flags[kFLAGS.AMILY_VILLAGE_ENCOUNTERS_DISABLED] = 0;
	//Change to plain mouse birth!
	if (player.pregnancyType == PregnancyStore.PREGNANCY_AMILY) player.knockUpForce(PregnancyStore.PREGNANCY_MOUSE, player.pregnancyIncubation);
	doNext(playerMenu);
}

//[Slapaho]
private function slapAmilysWhoreFace():void {
	clearOutput();
	outputText("You slap Amily across the ");
	if (flags[kFLAGS.AMILY_NOT_FURRY] == 0) outputText("nose");
	else outputText("face");
	outputText("\n\n\"<i>What I do and whom I do it with is none of your business,</i>\" you declare.  \"<i>If you don't trust me not to fall prey to the demons after everything we've had together, that's too bad.</i>\"");
	
	outputText("\n\nShe looks wounded and irate, but mostly unhappy.  \"<i>I'm sorry,</i>\" the ");
	if (flags[kFLAGS.AMILY_NOT_FURRY] == 0) outputText("mouse-");
	outputText("girl says, eyes wet with tears, \"<i>but I don't.  Goodbye.</i>\"");
	
	outputText("\n\nWithout another word, she turns, gathers her things, and leaves.");
	flags[kFLAGS.AMILY_FOLLOWER] = 0;
	flags[kFLAGS.AMILY_CORRUPT_FLIPOUT] = 1;
	flags[kFLAGS.AMILY_VILLAGE_ENCOUNTERS_DISABLED] = 0;
	flags[kFLAGS.AMILY_VILLAGE_ACCESSIBLE] = 1;
	//no more classes, no more books; no more Amily's dirty looks
	//bitch goes in ruined village
	doNext(playerMenu);
}


//(FUCK DAT TREE BITCH)
private function fuckHolliInZeFlowerPuss():void {
	clearOutput();
	flags[kFLAGS.HOLLI_FUCKED_TODAY] = 1;
	var x:int = player.biggestCockIndex();
	outputText("With a knowing smile, you toss your [armor] aside and say, \"<i>Let's do this.</i>\"  [EachCock] juts out, hard and proud from your body, pointed straight towards the entrancing woman before you.  She leans down from her perch in the tree and rolls her shoulders from side to side, jiggling her pale green assets back and forth, traces of syrup hanging from her pendulous melons.");
	outputText("\n\n\"<i>Well, come on over then, ");
	if (player.tallness < 84) outputText("little");
	else outputText("big");
	outputText(" " + player.mf("boy","girl") + ",</i>\" the arboreal tramp suggests with a husky coo, \"<i>I got you some sugar.</i>\"  She pinches her nipples and gasps, dark streams of sugary juices dripping wetly into the soil as she beckons you closer.");
	outputText("\n\nYou confidently advance, phallus first, and press your erection into the syrup-spurting valley, getting fluid all over yourself in the process.  Wet, sticky squishes greet your ears as [oneCock] is enveloped in the jiggling G-cups, webs of amber fluid hanging between your loins and the hefty globes as they're lifted away, stroking along your sensitive length.");
	if (player.cockTotal() > 1) {
		if (player.cockTotal() == 2) outputText("  Your other penis splays");
		else outputText("The rest of your penises splay");
		outputText(" to the side, smearing furrows of the stuff around as they slide over the butter-smooth skin.");
	}
	outputText(" The demon dryad's hand reaches below to ");
	if (player.balls > 0) outputText("cradle your [balls], gently massaging your sack");
	else {
		outputText("gently caress your ");
		if (player.hasSheath()) outputText("sheath");
		else outputText("loins");
	}
	outputText(" encouragingly.  You respond by edging your [hips] upward, more effectively presenting your shaft to be pleasured.");
	
	outputText("\n\nSighing happily, the immobile beauty ");
	if (player.cockArea(x) < 100) outputText("leans down and kisses the tip, opening her glossy green puckers to slurp it down, sucking just hard enough to make your " + player.cockHead(x) + " tingle with erotic warmth.");
	else outputText("kisses up and down your huge, towering shaft, slobbering her glossy green puckers all over your urethral bulge, making it even more of a wet mess.");
	outputText("  You grab hold of the edges of her tits and squeeze, smushing them tight around yourself and sliding them up and down.  The plant-woman's twinkling golden eyes meet your own while she pleasures your " + player.cockDescript(x) + ", and her hands come to rest over top of your own, assisting you with the quick tit-fuck.");
	
	outputText("\n\n\"<i>Go on, give me a taste,</i>\" the hungry slut whispers encouragingly, giving her tits a slap to make them jiggle around you, vibrating through your cock.  You give her exactly what she wants when you start to bounce the breasts on your ");
	if (player.balls > 0) outputText("balls");
	else outputText("groin");
	outputText(", slapping wetly against you.  Soon, the slick texture of her soft melons has you throbbing eagerly and dribbling hot trails of pre-cum.  You're going to blow any second now, and the hot bloom of pleasure within you is spreading further and further.  Those gold and black eyes look up imploringly while the pale green cheeks hollow hungrily, and you release ecstatically, arching your back as you pound the heavy tits down your length.");
	
	outputText("\n\nA geyser of spunk rockets out into ");
	if (player.cockArea(x) >= 100) outputText("the air, where it hangs for a moment before splattering down atop the plant-girl's leaf-colored hair and face, forming a gossamer shroud.");
	else outputText("her mouth, which works noisily to swallow the hot load even as you inject it into her.  After a few swallows, she leans back and lets you shoot it up into the air, so that it can fall down over her face and hair, into a gossamer shroud.");
	//highish cum:  
	if (player.cumQ() >= 500) outputText("  You keep blasting heavy ropes of seed until her body and trunk are painted with goo, and then you cum some more, smattering spunk until she looks more like a gooey waterfall than a fey creature.");
	if (player.cumQ() >= 1500) outputText("  Before you know it, there's a lake around the two of you and a small river running downhill away from camp.");
	outputText("  A mischievous grin breaks out under the goopy facial, followed by an unnaturally long tongue that pulls gobs of the stuff into the dryad's hungry mouth.  Once she can see again, the girl gives her tits a squeeze and affectionately kisses your cock, practically worshipping it with sloppy-sweet licks.");

	outputText("\n\nYou break the embrace with a happy sigh and admire the state of your cock: it drips with milky syrup and still pulses with the pleasant aftershocks of your climax.  The pressure of your lust is dimmed, though a hint of it remains in your [balls], and you're still fairly hard.");
	
	outputText("\n\nPale hands reach out to fondle you, and when they make contact, the tree-girl's soothing voice asks, \"<i>Are you still hard after letting out all that seed?  My my... you truly have a special sapling.  Let's put it in a nice, fertile flower-pot, shall we?</i>\"");
	outputText("\n\nYou roll your eyes and idly stroke your chin... do you have time to - whoah, hey!  Dozens of tentacles have dropped down from above, and they slam into your back together in a unified attack.  Individually, they're somewhat weak, but the gestalt impact hits you hard enough to send you stumbling forward, right into Holli's ");
	if (player.tallness < 60) outputText("tits");
	else outputText("arms");
	outputText(".  [EachCock], instead of slamming into the bark painfully, slots into something warm and wet, pulsating and pliant.  A clingy, tight hold that ripples gently around your member");
	if (player.cockTotal() > 1) outputText("s, massaging the bundle of cocks with uncommon ferver");
	else outputText(", massing your tool with uncommon fervor");
	outputText(".  Your grunt of irritation vanishes as soon as your tender sex is forced into the heavenly hole, and with the soft breasts pressing into ");
	if (player.biggestTitSize() >= 2) outputText("your own");
	else outputText("your [chest]");
	outputText(", you give up and kiss the dryad full on the lips, biting the lower one roughly in irritation.");
	
	outputText("\n\nHolli deprived you of choice, but if you have to fuck, it's going to be by your rules.  You slide your fingers through the seam between her hips and the tree, finding a squeezable, pert behind to grab hold of.  Then, you pull your hips back, and still biting her lip, you slam them home, powerfully delivering your " + player.multiCockDescriptLight() + " into her slobbering, nectar-filled gash.  You let her lip go and menacingly growl at her, plowing her fields with animalistic vigor.");
	outputText("\n\n\"<i>F-f-fuck yeah!  Ooooh...</i>\" Holli moans, clinging tightly to you as she pouts her lower lip at you, \"<i>Take me!  Seed me!  Seed me, please, [name]!</i>\"");
	outputText("\n\nYou snarl in irritation at the dryad's pathetic pillow talk, and tweak her nipple, turning her pleading into in a high pitched whine.  Meanwhile, the slick, outer petals have spread out around your [hips], closing neatly behind your [butt].  It limits your range of motion, but you don't have to pull back THAT far to give this pussy a proper reaming.  You fuck it faster and harder, hitting that tight twat hard enough to rustle the leaves above.  She gushes sweet nectar down your [legs] with each clap of hip to hip, and soon her accommodating interior is quivering uncontrollably, actually spurting out jets of fragrant nectar with each cock-devouring push.");
	
	outputText("\n\nHolli's black-ringed eyes roll back, her mouth quivering wordlessly.  The sight is enough to drive you to a release of your own, and you vent your [balls] into the quavering honeypot. Kissing her again, you enjoy the moment, your hips slowly pumping in time with the muscular contractions that squirt ever more of your seed into her furrow.  The petals that were constraining you open wide, oozing their matching moisture in fat drops.  The moment is as messy as a mud wrestling competition in the rain, a sexual frenzy of sordid, splattering proportions.");
	outputText("\n\nOnce you've fully sown your seed, you stumble out and away, completely drained of lust and feeling there's nothing left inside you but dust.  That flower... it sucks you dry!  Girlish giggles stir you from your reverie, and you see that Holli has recovered already, her petals already folded closed, though her breasts swing free.");
	outputText("\n\n\"<i>A drink for my noble champion,</i>\" she offers sarcastically, raising a boob.  You gratefully partake in the proffered moisture, which invigorates your tired body back to its former state, leaving you no worse for the wear.");
	outputText("\n\nHolli pouts when you get dressed and leave, doing her best to entice you, but you can't sit around camp fucking all day.  Maybe after you defeat the demons, you can come back and give the perpetual bone zone a try...");
	//{+1 corruption, -100 lust, -1 sensitivity.}
	flags[kFLAGS.TIMES_FUCKED_FLOWER]++;
	fertilizeHolli();
	player.orgasm();
	dynStats("sen", -1, "cor", 1);
	doNext(camp.returnToCampUseOneHour);
}

//Drink From Her (edited)(C)
private function haveAMapleSyrupSnack():void {
	clearOutput();
	outputText("You approach Holli with a hungry smile plastered across your [face], licking your chops as you eye the arboreal slut with unrestrained desire.  Of course, your gaze fixes on her heavy chest, with its distended, dripping nipples.  They leak sweet sap as you stare; the demon seems eager to feel your mouth on her slick, almond-colored buds.  Looking at you ");
	if (flags[kFLAGS.HOLLI_SUBMISSIVE] == 0) outputText("knowingly, Holli asks, \"<i>Come for a little pick-me-up?  Well, go on; drink deeply of my nectar, </i>champion.\"  The last word is inundated with malicious, mocking tones.");
	else outputText("eagerly, Holli asks, \"<i>Care for a little pick-me-up?  They're getting very engorged, and I'm sure it would be a refreshing snack for you.</i>\"");
	outputText("\n\nGrowling faintly, you snake your arm in along her side and curl it behind her back, pulling her forward and out.  Holli gasps in surprise, but doesn't struggle.  A drop of her syrupy sap splashes on your [armorname], trickling out with greater rapidity from the dryad's sweet tits.  You crane your neck to take one in your mouth, and immediately begin to suckle it down.  The fluid is more like maple syrup than milk, and so potent it fizzles on your tongue, bursting with flavor.  With your free hand, you squeeze the rounded tit and increase the flow.");
	outputText("\n\nHolli gasps, \"<i>Not so hard!</i>\"");
	outputText("\n\nLooking up at her concerned visage, you wink and bite down on the tender nipple, just hard enough to make her squeak in distress.  The demon's body twists in your grip, but with your arm around the small of her back and her body part of the tree, she has nowhere to go.  You easily restrain her, allowing yourself to fully sample her treats.  Your throat bobs with each gulp of the free-flowing nectar and tingles as your tongue did before.  Soon, your whole body feels alight with energy, just as you finish the first breast.");
	outputText("\n\nThe nipple pops out of your lips with a weak spray of 'milk', and its owner shudders slightly, her flower blooming against your [legs], weakly grasping.  You let your restraining arm go a bit lower to squeeze Holli's cute little butt.  Her smooth skin feels perfect in your hand, though you can feel that a little lower, her flesh joins with the wood of the tree, becoming quite rough.  How odd.");
	outputText("\n\nYou quickly tire of fondling the proud creature's body and return to drinking her treasure straight from the tap, suckling hungrily to expedite the process.  Holli's pants can be heard above you, and the slick grinding of her petals over your [hips] adds to the eroticism in the air.  Your own blood is pumping harder and faster, flushing your " + player.skin() + ".  Drinking deeper, you realize you feel vibrantly alive, completely and utterly suffused with energy.  You swallow the last of Holli's syrup and shake slightly, breaking away from the intimate embrace you shared.");
	player.refillHunger(10);
	outputText("\n\nHolli is trembling and oozing lubricants from below, her pale-green skin flushed almost purple.  Eyelids hanging heavy over her dilated pupils, she gasps and pants... it appears that she was able to orgasm from that, but still wants more.");
	outputText("\n\nPerhaps later.  You burp and walk off, having gotten just what you wanted.");
	//stat changes n' shit
	dynStats("lib", .5, "sen", 1, "lus", 15, "cor", 1);
	player.changeFatigue(-60);
	doNext(camp.returnToCampUseOneHour);
}
	
//Tentacle Ride (looks ok)(C)
private function level4RideHollisTentacruels():void {
	clearOutput();
	flags[kFLAGS.HOLLI_FUCKED_TODAY] = 1;
	//(PC voluntary gets tentacle pounded, and high from flower pussy spores.  clitoral BJ?  Nipple suckers!}
	outputText("You smirk knowingly and suggest to Holli that she take you for a ride... if she knows what you mean.  This earns you a pleased applause from the delighted demon dryad, and she immediately sets to helping you undress, her eager tentacles lowering from the tree and arching up like searching snakes.  You let her remove your [armor] with the patience of a goddess, shivering slightly when the sticky gear is peeled away from your eager undercarriage.");
	outputText("\n\n\"<i>Oh, you're going to love this, [name],</i>\" the demon tree promises, \"<i>Just lie back into my tentacles, and let me do the work.  You'll feel so good, you'll NEVER want to leave.</i>\"");
	outputText("\n\nYou fold your arms impatiently across your [chest] and nod, waiting for her to get her phallic tendrils in position.  It takes you completely off guard when a half-dozen tentacles snap across your front and another bundle sweeps your [legs] out, spinning you to look face down at the ground, supported horizontally on a bed of taut, straining tentacles.  More loop over you, under you, and around you, cinching tight to your wrists and [feet].  They pull them out while other prehensile plants swing down to support you, occasionally looping around you, their moist skin easily gliding over your " + player.skinFurScales() + ".  All that, and she's not even fucking you yet!");
	outputText("\n\nYou try to glare up at her, but when you look up, all you get is a faceful of flower-cunt.  Sneezing, you shake your head and try to pull away, but you have no control over your position at this point.  All you manage to do is smear feminine slime over your cheeks and get a fresh deposit of pollen on your nose, which brings on a fresh fit of sneezes.  \"<i>This isn't what I ahh-ahhh-CHOOO!  ...asked for!</i>\" you bellow before one of the thick, pulsating folds can obscure your mouth.");
	outputText("\n\nA hand pats your head condescendingly, and Holli replies, \"<i>A little foreplay never hurt anyone my dear.  I simply thought that sampling my pollen might make things a little more enjoyable for you.  Marae said it has some fun effects on mammals.</i>\"  The hand goes away in time for the voice to proclaim, \"<i>Now, back to the good part!</i>\"");
	if (silly()) outputText("  She proceeds to sing about Jack Sparrow's awesome adventures for a solid ten minutes, then goes on as if nothing had happened.");
	
	outputText("\n\nA hot drop of fluid drips onto your [butt], followed a moment later by an even larger splattering of pre.  Twisting in your bindings, you struggle for a look but vertigo takes you, robbing you of any chance at success.  You woozily flop back against the wet blossom-twat, inadvertently breathing in more pollen from a protrusion located where a clit would be on a human.  It isn't really irritating anymore, in fact, it smells kind of nice.  Forgetting about the pre-cum raining onto your [butt], you nuzzle up to the clitty-shaped pollen dispenser and take another whiff.  It's kind of nice, though it's making your salivate like crazy - spittle is actually drooling out of your dopey maw in a river until you realize what you're doing and close your gob, swallowing like crazy.");
	outputText("\n\nA burst of pleasure somewhat like a firework in strength and intensity goes off in your nether-lips, jarring you out of your drug-fueled stupor.  Aching fullness radiates from your [vagina] coupled with convulsing delight, brought on by twin tools, one wrapped around the other in a helix.  They fuck you like one giant dick, pushing in to your cervix with potent, forceful strokes that turn your [legs] to jelly.  A gush of femspunk splatters the wasteland soil beneath you, and as the paired pricks ravage you, greater and greater levels of lady-cum gush out.  You're so wet that it's like you're squirting with every thrust, and a puddle forms under you in no time, growing bigger with each piston-like reaming of your [vagina].");
	//cuntChange, 60
	player.cuntChange(60,true,true,false);
	outputText("\n\nThe vibrant purples, pinks, and reds of the flower grow brighter and more intense.  When did Holli gain bioluminescence?  You barely suppress a giggle, which comes out as a snort, and turn to face the bright red, pollen-soaked bulb.  It doesn't take any encouragement for you to open wide and swallow it into your maw, but you do manage to miss the first few times, earning a good smearing of the stuff on your cheeks for your troubles.  The pollen is delicious, and as you lick it off, you get to savor the sweeter nectar below.  Your saliva runs from the shaft and down the inner lips in a curtain, unimpeded by your facile lips.  Meanwhile, you're aware of ");
	if (player.lactationQ() == 0) outputText("droplets of milk dripping from your nipples.  When did you start lactating?");
	else outputText("steady streams of milk erupting from your nipples.  When did you start lactating this hard?");
	
	outputText("\n\n\"<i>Titty-fucking Marae!  This shit is getting you wet, isn't it?  And from both ends to boot!</i>\" Holli cheers.  Her hand grabs your head and pulls it deeper into her muff, and getting the idea, you begin to lick and hum.  Your spit makes the already sloppy box into a frothing riverbed, though some of the additional moisture comes from within.  Sometimes you drink down a particularly flavorful gush.  Other times, you're too full of saliva to take in any more liquid, and you spray the slick fluid out around the sensitive nub even as you suckle it.  The demonic tree-woman titters, \"<i>Atta girl... I bet I can get another two tentacles in you like this, and maybe taste some of that sweet mammal-milk that Mother's on about.</i>\"");
	outputText("\n\nA set of pitcher-pot tipped roots emerge from the muddy puddle below, wiggling happily in your milk-streams as they climb higher.  It does not take them long to find your [nipples] or latch on.  Indeed, they begin to suck almost immediately, drawing deep, vacuuming breaths with a pleasant, staccato rhythm.  You leaky teats let down, hard, and gush incredible amounts of milk with little effort, which the plant-slut happily sucks up.  She remarks, \"<i>That's... mmm... good,</i>\" and begins to pant, clearly enjoying your confused, sloppy attempts at oral combined with the feelings coming from her tentacles as they double-team your tightly-packed pussy.");
	outputText("\n\nThe spittle-soaked clit puffs up in your mouth, and a torrent of juices washes out from the folds below as the plant-woman achieves orgasm.  In your cunt, one of the plant-pricks spasms and un-twines from its twin, sliding out of your warm, creme-oozing twat to spray the last of its load across your gushing nether-lips.  Another takes its place, but then, the first monstrous member spurts out its own thick love, also withdrawing to plaster you with a wave of jizz.  Again, a fresh cock burrows into your soaked sex, and the cycle repeats itself like over and over - one cock cums, pulls out, and is replaced.  Then, another replaces it. Your [vagina] is so effectively tag-teamed that you cum mid-womb-bukkake, splattering your lubricants in a fan-shaped spray below while your hips writhe uselessly.");
	outputText("\n\nThe milk spraying from your nipples redoubles, gushing out fast enough to knock the pitchers from your [chest], and the puddle below deepens further, gradually turning white and opaque, much like your cum-plastered bottom.  A pink cloud of lust settles over your brain, and as soon as the orgasm dies down, you get right into eating that juicy, gooey twat.  At some point, the tentacles work a third penetrator into their rotation, stretching your salty, slicked snatch wider.  The flower's colors grow so vibrant that they defy language, and the world seems to be spinning so fast that there's no longer up or down, only licking, cumming, and squirting.");
	outputText("\n\n<b>An hour later...</b>");
	
	outputText("\n\nYou wake up, utterly soaked with girl-goo and jizz at the base of the tree.  Holli is nowhere to be found, hidden behind her bark to rest in all likelihood.  She did quite the number on you - ");
	if (!player.isBiped()) outputText("you'd be walking bowlegged for a week, if you had legs.");
	else outputText("you'll be walking bowlegged for a week!");
	//empty lust, boost corruption, slimefeed(), +1 cor, -3 sens, +.5 libido
	player.orgasm();
	dynStats("lib", .5, "sen", 2, "cor", 1);
	fertilizeHolli(false);
	player.slimeFeed();
	flags[kFLAGS.TIMES_RIDDEN_FLOWER]++;
	doNext(camp.returnToCampUseOneHour);
}

//Bear Fruit(C)
private function eatHolliFruit():void {
	clearOutput();
	outputText("You reach up into Holli's branches and pluck ");
	if (flags[kFLAGS.HOLLI_FRUIT] == 1) outputText("the fruit");
	else outputText("one of the fruits");
	outputText(".  ");
	if (flags[kFLAGS.HOLLI_FRUIT_EXPLAINED] == 0) {
		outputText("Holli smiles over at you and asks, \"<i>Enjoying the fruits of our union?</i>\"");
		outputText("\n\nYou nearly drop the purplish pear in surprise...  This came from the... the sex?  The corrupt woman nods at you and explains, \"<i>Well, what did you think?  I'd get pregnant?  I'm a tree.  When we bear fruit, we do it literally.</i>\"  Holli smirks a little and encourages you, \"<i>Go on, try it.  They're supposed to be delicious... though I haven't eaten one, of course.</i>\"\n\n");
		flags[kFLAGS.HOLLI_FRUIT_EXPLAINED]++;
	}
	outputText("Biting into it, sweet juices seem to explode from the flesh, dribbling down your chin.  It tastes like a dessert and you chow down, happily munching away.  In no time flat, you're down to just a core.  You toss it and wipe your [face] clean, then burp.  Damn, that was good! ");
	player.refillHunger(25);
	//TF CHANCES
	if (rand(2) == 0 && player.cockTotal() > player.countCocksOfType(CockTypesEnum.TENTACLE)) {
		var choices:Array = [];
		temp = 0;
		while(temp < player.cockTotal()) {
			if (player.cocks[temp].cockType != CockTypesEnum.TENTACLE) choices[choices.length] = temp;
			temp++;
		}
		temp = choices[rand(choices.length)];
		outputText("\n\nYour " + num2Text2(temp+1) + " penis itches, and you idly scratch at it.  As you do, it begins to grow longer and longer, all the way to the ground before you realize something is wrong.  You pull open your [armor] and look down, discovering your " + player.cockDescript(temp) + " has become a tentacle!  As you watch, it shortens back up; it's colored green except for a purplish head, and evidence seems to suggest you can make it stretch out at will.  <b>You now have a");
		if (player.countCocksOfType(CockTypesEnum.TENTACLE) > 0) outputText("nother");
		outputText(" tentacle-cock!</b>");
		player.cocks[temp].cockType = CockTypesEnum.TENTACLE;
		player.cocks[temp].knotMultiplier = 1.3;
		dynStats("sen", 3, "lus", 10);
	}
	flags[kFLAGS.HOLLI_FRUIT]--;
	dynStats("cor", 1);
	if (player.tou < 50) dynStats("tou", 1);
	if (player.str < 50) dynStats("str", 1);
	doNext(camp.returnToCampUseOneHour);
}

//Beg Her To Guard (edited)(C)

//PC can beg or not beg?
private function askHolliToWatch():void {
	clearOutput();
	if (flags[kFLAGS.HOLLI_DEFENSE_ON] == 0) {
		outputText("You ask Holli if she would mind using her tentacles to help guard the camp at night.  She rolls her eyes and taunts, \"<i>I don't know; maybe if you get down on your knees and beg me.  ...And I mean </i>really<i> beg, with plenty of whimpering.  Lick my roots too.  After all, I should get something out of this.</i>\"");
		outputText("\n\nIt looks like she'll only help guard camp if you debase yourself for her.  You could try to overpower her in a show of dominance, <b>but she'd likely act a lot more meek after such a display of assertive dominance.</b>");
		if (flags[kFLAGS.THREATENED_HOLLI] > 0) outputText("<b>  You could always just slap the cunt.</b>");
		//choosing not to beg unlocks Threaten?
		//[Beg][Threaten][Back]
		//simpleChoices("Beg",begHolli4Watches,"Threaten",0,"Assert Self",domUpSomeHolli,"",0,"Back",treeMenu);
		menu();
		addButton(0,"Beg",begHolli4Watches);
		if (flags[kFLAGS.THREATENED_HOLLI] == 0) addButton(1,"Threaten",threatenHolli);
		else addButton(1,"Slap Her",slapDatHo);
		addButton(2,"Assert Self",domUpSomeHolli);
		addButton(4,"Back",treeMenu);
	}
	//Stop Guarding (edited)(C)
	else {
		outputText("You tell Holli you'd like her to stop watching at night.  She laughs, \"<i>You just want a chance to come back and beg some more, don't you?  I thought you were supposed to be tough shit, not a simpering little submissive.</i>\"");
		flags[kFLAGS.HOLLI_DEFENSE_ON] = 0;
		doNext(treeMenu);
	}
}

//Actually beg: (edited)(C)
private function begHolli4Watches():void {
	clearOutput();
	outputText("You swallow your pride and drop down prostrate on the ground.  Sighing, you grudgingly say, \"<i>Please, Holli, guard my camp at night.  I don't want to be raped by monsters.</i>\"");
	outputText("\n\nThe devilish dryad grips her tit and squirts some sap at you, taunting, \"<i>You'll have to do better than that.  I don't think you really mean it.  It's like you're just going through the motions... pretending.  And you're not licking my roots; get to it.</i>\"");
	outputText("\n\nGrimacing, you push your face down to where the tree's roots enter the soil, and hesitantly extend your tongue.  You can taste the fouled earth's flavor on the craggy bark... disgusting.  \"<i>Please...</i>\"");
	outputText("\n\n\"<i>Nah, not enough.  Tell me how the little weakling needs me in vivid detail.  Don't leave anything out, especially getting raped at night by dozens of imp-cocks and goblin cunts.</i>\"");
	outputText("\n\nThis is... utterly humiliating!  You blush in shame and give her root another, longer lick, no longer caring about how bad it tastes, as long as you can get this over with!  You blink moisture from your eyes and unabashedly beg, \"<i>Please, mistress Holli.  I need you.  I don't want to get stuffed by dozens of imps.  I'm weak, and I need you to watch over me.  Please, please help me, mistress Holli.</i>\"  You rub your cheek against her root and look up hopefully.");
	outputText("\n\n\"<i>Hah.  I guess I'll watch your camp.</i>\"");
	flags[kFLAGS.HOLLI_DEFENSE_ON] = 1;
	doNext(treeMenu);
}
	
//Donation Day Dominate Holli Content
//Started by choosing "assert" at the prompt where you can beg.
//If PC is too low level, Holli closes up and nothing happens.
//Changes the dynamic significantly - Holli becomes very subservient in her scenes.
//Guard Camp
//Assert Self:
//Success/Fail dependent on: Level, height, tone, width.

private function domUpSomeHolli():void {
	clearOutput();
	flags[kFLAGS.HOLLI_FUCKED_TODAY] = 1;
	outputText("You swagger up to the tree and put your hand on the bark beside Holli.  Glancing over, she quips, \"<i>Is that supposed to be intimidating?</i>\"  The dryad smirks ingratiatingly.  \"<i>I'm the offshoot of a demon goddess.  I don't think you thought this through.</i>\"");
	outputText("\n\nSlapping your palm down on the other side, you look her right in her oddly gold and black eyes and tell her in no uncertain terms that she is going to serve and service you at your slightest whim.  Any choice she thinks she has is nothing more than an illusion.");
	var domPowah:Number = player.level;
	domPowah += player.tallness/12;
	if (player.horns > 0) domPowah += 3;
	if (player.cor > 66) domPowah += 2;
	//{fail} 
	if (domPowah < 20) {
		outputText("\n\nRolling her eyes, Holli sinks back into her arboreal core, the bark 'lips' slowly pulling together, creaking ominously.  You grab hold of them and try to wrench them open, but inexorably, each continues on to meet the other.  An inch before the wood crushes around your fingers, you let go, reminded of a tree back home that somehow split a stone with its growth.  The demonic dryad's home is closed to you.  Perhaps, if you were a little more intimidating, it would have worked.");
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	//{success}
	outputText("\n\nSlowly, the demonic dryad's eyes widen, exposing more of her pitch-black sclera as she takes in your imposing visage.  She bites her lower lip and gnaws at it uncertainly, amber pupils flicking back and forth as she searches for any sign of weakness.  Without warning, you blow in her face and laugh when she flinches.  Her hands fold together in front of her abdomen, driven to nervelessly clutch at her pale viridian flesh.");
	outputText("\n\n\"<i>Okay,</i>\" the intimidated arbor-slut sighs, \"<i>You're right...  It's what Marae intended anyway.  I'm supposed to be your reward - a slave-slut, obeying and rewarding until she comes to collect you.</i>\"  Holli hugs her chest in a vain attempt to endure the shattering of her confidence.  \"<i>What do you want me to do?  Whatever it is, I obey.</i>\"  She casts her eyes down to the ground and awaits your comment.");
	outputText("\n\nThat went well.  <b>Holli's confidence is broken.  She'll serve you obediently from now on.</b>");
	//[Next] - Holli's Menu
	flags[kFLAGS.HOLLI_SUBMISSIVE] = 1;
	treeMenu(false);
}

//Guard Camp
private function askBrokenHolliToGuard():void {
	clearOutput();
	outputText("Holli bows her head when you mention her guarding camp.  She asks, \"<i>Shall I keep watch for foes to drain or let them into camp for you to have the pleasure of dealing with, [name]?  <b>I've been ");
	if (flags[kFLAGS.HOLLI_DEFENSE_ON] == 1) outputText("keeping watch");
	else outputText("sleeping, instead");
	outputText(".</i>\"");
	
	//[Guard] [Don't Guard] [Back]
	menu();
	if (flags[kFLAGS.HOLLI_DEFENSE_ON] == 1) addButton(1,"Don't Guard",toggleBrokenHolliGuard);
	else addButton(0,"Guard",toggleBrokenHolliGuard);
	addButton(4,"Back",treeMenu);
}

//Guard On
private function toggleBrokenHolliGuard():void {
	clearOutput();
	if (flags[kFLAGS.HOLLI_DEFENSE_ON] == 0) {
		outputText("\"<i>All right, I'll get to have some fun then,</i>\" Holli quips while rubbing her palms together in anticipation.");
		outputText("\n\nYou suppose you can sleep better with your pet demoness taking on the lesser whelps of this land.");
		flags[kFLAGS.HOLLI_DEFENSE_ON] = 1;
	}
	//Guard Off
	else {
		outputText("\"<i>All right, they're yours to smite or play with,</i>\" Holli says with a wink.  You give her a glare, to which she responds with a shrug.  \"<i>What?  I know how it is!  You mortals can't fight worth a damn when you're sleeping.</i>\"");
		outputText("\n\nA warning look shuts her right up.  Now if you could just get her to think before she opens her trap.");
		flags[kFLAGS.HOLLI_DEFENSE_ON] = 0;
	}
	menu();
	addButton(0,"Next",treeMenu);
}

//Dom Her With a Dick
private function holliGetsDickDommed():void {
	clearOutput();
	outputText("Tossing your [armor] aside, you expose your " + player.multiCockDescriptLight() + ".  Holli's eyes fixate on [oneCock], her attention rapturously contained by a single phallus.  You grip your maleness in hand and bounce it up and down into your other palm.  The solid slaps of genital impacts echo off the surrounding rocks, each sending a pleasant tingle of pleasure through the root of your manhood.  Before long, you're completely erect and throbbingly hard, bouncing unbidden with each and every thrum of your heart.");
	outputText("\n\nHolli leans forward, entranced by the sight.  Her head and shoulders slip through the surprisingly pliant bark as she bends down to view the show.  Swaying beneath her, Holli's weighty tits dangle unrestrained and unbound.  Sappy moisture clings to her almond nipples like morning dew, dripping in small drops onto the wasted ground.  The tips of her teats have gone rigid, engorged with whatever strange substance passes for blood.  Similarly, the dryad's flower is in full bloom, with its vibrant petals spread open, welcomingly.  The constant lubricants make the slick lips glitter like diamonds in the light, until their owner's shadow eclipses the illumination.");
	outputText("\n\nHanging out of her tree, Holli reaches for [oneCock], but stops just short.  \"<i>Can I pleasure it, please?</i>\"  She's looking up at you hopefully, like a kid hoping for a treat.");
	outputText("\n\nSo long as she continues to be good, you don't mind letting her have a few licks.  You nod to the black-eyed beauty and rock forward, butting your [cockHead biggest] right into her soft lips.  Holli squeaks in surprise and grabs hold, firmly gripping your [cock biggest] in her capable fingers.  She makes to kiss it, but you pump yourself forward again.  The first few inches sink into her mouth before she can react.  This time, all she manages is a muffled groan, lips thoroughly snared with dick.  Her distraught vocalizations die down as she begins to accept her role, gently sliding your [cock biggest] down to take in as much as she can");
	if (player.biggestCockArea() > 80) outputText(", jaw stretching obscenely");
	outputText(".");
	outputText("\n\nYou congratulate her on her success in handling your dick and push on the back of her head with gentle but unforgiving pressure.  Pleasant body heat envelops your prick as it's gobbled down deep");
	if (player.biggestCockArea() <= 80) {
		outputText(", swallowed to the ");
		if (player.balls > 0) outputText("[balls]");
		else outputText("[sheath]");
		outputText(".");
	}
	else outputText(", swallowed as deep as Holli's distended neck can handle.");
	outputText("  Gurgling, the demonic dryad flutters her lengthy eyelashes and looks up at your eyes, twinkling with happiness at her servitude.  You wiggle your crotch around, and it twists your [cock biggest] around her mouth and throat.  The tainted tree's tongue massages the underside of your length, embracing you with subtle moisture and frictionless pressure.");
	outputText("\n\nBubbling sexual pleasure begins to build up inside you, making your ");
	if (player.balls > 0) outputText("[sack] feel taut and ready to burst");
	else outputText("body feel strung tight like an over-tuned guitar");
	outputText(".  Holli pulls back, inciting a snarl of displeasure to vibrate from you, but as soon as she's withdrawn, her hands clasp onto the slick shaft and begin to pump it with vigorous strokes.  Her mouth settles back into place around your [cockHead biggest], circling it with her tongue while she bobs up and down on it, snaring your most sensitive place with overwhelming sensations.");
	outputText("\n\nYou grab hold of the hungry cock-sucker by her neck and push her back, up into her tree, releasing your [cock biggest] before it can blow.  It's a close thing - you're rigid and bobbing, muscles clenching involuntary right on the edge.  Holli makes a choking protestation as she's forced into place but doesn't struggle, fearful of your wrath.  You let the hungry slut go, unharmed but chastised by the rough treatment.  Your cum is destined for her twat, not to be wasted in her slutty noise-hole.");
	
	outputText("\n\nStepping up, you ram your rigid phallus deep into the slick flower at Holli's waist.");
	if (player.biggestCockArea() > 80) outputText("  It bends slightly as the immense girth is forced inside her, aiming down, deep inside the trunk.");
	outputText("  Holli flops into your [chest], twitching weakly and breathing heavily.  \"<i>Fffuck, so good!</i>\" she pants, nuzzling her cheek into your collarbone while her hands play across your shoulders.  You ruthlessly mount her flowery mound with fast motions.  Juices squirt out around your member at the apex of every stroke, raining down over the surrounding ground.  You grab Holli's deep green hair and pull her back.  Her face is wrecked by bliss, her mouth and eyes moving in uncoordinated twitches.");
	outputText("\n\nYou kiss your planty pet forcefully, and she yields to your impressive dominance, putty in your hands.  Her body quavers against you, and then, she's moaning into your lips, forgetting the kiss as climax wracks her frail, human-like half.  Nectar drips down your [legs] in a steady drizzle, sweet, lubricating juices that fill the air with a flowery, feminine musk.  You pull away from her mouth's incessant utterances and watch her cum, held in your arms.  The pleasant caresses of the dryad's inner walls squeeze down with pliant pressure, rolling over your [cock biggest] in slow waves, hungrily sucking at you and ready for sperm.");
	outputText("\n\nThe abruptness of your orgasm startles you.  One moment there's the sanguine ecstasy of the surrounding fuck-flesh, and the next, there's an explosive volcano of lust boiling out of your " + player.multiCockDescriptLight() + ", geysering fountains of fluid.");
	if (player.cockTotal() > 1) {
		outputText("  Excess jism spurts onto Holli's jiggling udders from below, spotting the viridian mounds with white.");
		if (player.cumQ() >= 500) outputText("  The constant sprays turn them white in little time, dripping from the peaks of her nipples along with her sticky sap.");
	}
	if (player.cumQ() > 1000) outputText("  A trickle of sperm washes out of the demoness's entrance, somehow escaping the heavy suction.");
	if (player.cumQ() > 2000) outputText("  A moment later, that trickle turns into a river.");
	if (player.cumQ() > 3000) outputText("  You swear that her trunk must be absolutely stuffed with spunk.");
	if (player.cumQ() > 5000) outputText("  A spooge-spout sprays out as the pressure goes through the roof, confirming your suspicions in the messiest way possible.");
	outputText("  Holli's tentacles cum with her, spraying her seed through her canopy in aimless ropes.  Most of it sticks to her branches and leaves, but small amounts of it trickle down to spatter the ground.  One of them lands on the back of your hand.  You frown and push it up against the tree-woman's mouth.  She licks you clean without question, still dazed from her orgasm.");
	outputText("\n\nRemoving yourself from the gaping flowerpot, you admire the fruits of your labors.  Holli breathily says, \"<i>Th-thank you, [name]...  So good...</i>\"");
	outputText("\n\nYou crook a finger and point down at the slop of sperm and nectar glazing your [cock biggest].  Getting the idea, she leans back out and opens wide.  You get a thorough cock polishing from the much meeker plant-woman.  She swallows it all and withdraws, offering, \"<i>If you ever want another round... my flower is yours.</i>\"");
	player.orgasm();
	dynStats("sen", -2, "cor", 1);
	flags[kFLAGS.TIMES_FUCKED_FLOWER]++;
	flags[kFLAGS.HOLLI_FUCKED_TODAY] = 1;
	fertilizeHolli();
	doNext(camp.returnToCampUseOneHour);
}

//.PC Has 10 Tentacle Go Full On Monster With Her
private function fullOnTentacleTasticGangBangForHolli():void {
	clearOutput();
	flags[kFLAGS.HOLLI_FUCKED_TODAY] = 1;
	outputText("You remove your [armor] and expose your writhing mass of wriggling tendrils to the tree-tart.  She places a hand over her mouth and exhales, \"<i>Oh my, Mother Marae sure knows how to pick them, doesn't she?</i>\"");
	outputText("\n\nExercising considerable control over your vegetative peckers, you extend one forward, the phallic tentacle lurching out to silence the troublesome tree in a split-second.  Holli gives up a strangled, \"<i>h-urk!</i>\" and rocks back into her tree's entrances, eyes crossed to look at the green snake protruding from her lips.  Her mouth feels good around the purple-tinged cock-tip you've forced inside, but you think her throat would feel better.  Your tentacle tool stretches, lengthening with supernatural agility, and you push the fresh flesh down Holli's gullet, distending her throat with the imprint of your length.  Her esophagus instinctively works to swallow the obstruction, which serves you just fine.  The tight oral pleasure has you oozing droplets of pre-seed directly into her belly, but you're far from ready to blow.  After all, with nine more penises, satisfaction remains a good ways away.");
	outputText("\n\nHolli reaches up at the pioneering phallus.  You aren't sure if she's trying to pull it out or massage it, but her hands could be put to better use.  Snapping out, two tendrils lance forward, twining around the dryad's arms before she can bother the busy cock in her mouth.  They snugly entwine her limbs with warm cockflesh and pull taut.  No matter how she struggles, the oppressive penises hold her restrained.  You push the busy tentacles harder, forcing them to climb higher.  Their heads push into her fingers, then past, giving the demoness a firm hold on your sensitive tendrils.");
	outputText("\n\nLooking your way, the tainted dryad cast a smoldering look at you and begins to massage all three of the busy cocks.  She strokes the ones in her hands eagerly.  The mouth-penetrating penis finds itself on the receiving end of rather skilled fellatio.  Holli's tongue dances along the underside with inhuman skill, touching every sensitive area of the shaft with supreme, whore-like skill.  You partially release her arms to allow her to better serve you, and she does not disappoint, her handjobs growing faster and more eager now that they can get at more of your members.");
	outputText("\n\nBy now, you've started to flush somewhat.  The three-way pleasure is significant, enough that the rest of your bundle of vegetative dicks are wildly waving");
	if (silly()) outputText(", inflatable-arm, flailing tube-cocks");
	outputText(".  Below the orgy of arboreal affection, Holli's slick petals have spread wide.  You can actually see her interior twitching voraciously.  It opens and closes with pulsing hunger, vibrantly engorged.  As you watch, the fourth of your members lances forward of its own volition, spearing straight for that welcoming hole with no guidance from you.  It hits like a missile.  Two feet of that cock is gone in a moment, swallowed deep in the cunt-flower's bottomless depths.  A gush of girl-cum spurts out around the intruding member, and you can feel the muffled moan vibrate through the mouth-bound cock as she gives in to the four-way fucking.");
	outputText("\n\nHolli's hands begin to glisten, glossed with your pre-sap.  The other six penises are all dripping as well, filled with unbridled lust long denied.  You look her over, determined to find a home for every single one.  The chlorophyll-laced girl shudders, and the wobbling of her tremendous breasts answers your question for you.  The fifth green cock darts out from your genital bundle toward the quaking cleavage, crossing the intervening distance in a heartbeat.  It snuggles right into Holli's breasty crevasse and immediately sets to moving.  Jiggling, the sea of breast-flesh wobbles obscenely with every pass your tentacle makes into its valley.  Your own pre-sap quickly converts the mammary ravine into a swampy, sticky, cock-flavored mess.  The head curls down to press on one of her almond nipples, smearing its syrupy lactic cargo over the hardening bud. ");
	outputText("\n\nThe demon-dryad is inundated with cock, dominated with dick.  Her eyes roll back from pleasure, and her entire body begins to shake with spasms of delight.  Above, the foliage joins her in orgasmic writhing, the rustling leaves sounding very much like they're in the enduring of gale-force winds.  Her tentacle-vines, while normally content to stay above, drop down, vacantly spraying sap onto the ground.  The bark below Holli's legs glistens with her gushing nectar.  The tentacle inside her flower is being squeezed, caressed, and wrung by her tender folds.  Higher up, your tit-fucking tendril is splattered with syrupy breast 'milk', which makes her cleavage that much slicker, wetter, and better for you to abuse.");
	outputText("\n\nYou unspool a sixth penis from your remaining, unoccupied bundle.  It whips right into the syrupy, sappy little valley with its brother, and you begin to double-tit-fuck and frot yourself simultaneously, twin dicks grinding against each other and the soaked breasts at the same time.  Holli jolts weakly at the new sensation, but otherwise she seems to remain comatose.  Well, except her hands, which she keeps dutifully pumping on your second and third dongs, squeezing more and more pre onto her palms as she goes.  You're enjoying this so much that you find yourself eager for more stimulation, and you easily contort your members to spool around Holli's well-used form.  The throat-fucking cock wraps around her neck and shoulders.  You loop the pussy-penetrating dick up and around so as to caress her waist.  The tit-fuckers each encircle one of her breasts in their spare time.  She is surrounded with penis and drunk on the pleasure that only they can offer, her body reduced to a masturbation aid for you to fuck and rub on.");
	outputText("\n\nWhile the experience is intense, perhaps exquisite, you have four more manhoods left to tend to and precious little of her human shape left to abuse.  It's then that the drooping tentacles catch your eyes.  Not all of them are phallic, like your own.  Some are rather different... hollow and wet.  You release your remaining quartet of cocks to investigate these new arrivals, and as they probe at the slick entrances, you're greeted by pleasure as immediate as it is intense.  These are cunt-tentacles!  All four of the unsated penises thrust as one, snaring themselves into the sucking wet holes they've been presented with.  Holli's tube-pussies prove a perfect match for your virile green shafts - they devour your manhoods with unholy glee, easily swallowing up foot after foot of pulsing, tumescent flesh.");
	outputText("\n\nYou're awash in an orgy of pleasure.  It radiates out from your groin in pulsing waves, forming into breakers as it travels up your spine.  Then, it breaks over your brain, and like a switch inside you is flipped, you go into a frenzy.  Every single one of your tentacles begins to move faster and faster, pumping with quick, hard strokes into its orifice of choice, be it fingers, cleavage, mouth, or twat.  You pound each hole brutally hard.  Fluids spray out with each thrust to spatter the ground.  You can't tell if they're yours or hers, only that the air fills with the scents and sounds of rampant sex.");
	outputText("\n\nA tremendous upwelling of excitement surges through your meager frame, and you feel insignificant in the face of it, like your body is simply too small and simple for you to endure such agonizingly intense pleasure.  Your penises thrust and move of their own accord as your bliss builds, eyes rolled back into your head.  Holli watches you with a dopey, pleasure-dazed look in her eyes as she's thoroughly fucked, smiling faintly when she sees your [hips] begin to shake as orgasm overtakes you.");
	if (player.balls > 0) outputText("  Your [balls] draw up tight to your groin and squeeze, rhythmically discharging their heavy loads.");
	outputText("\n\nSemen distends each of your tools with spheroid bulges, rushing out from the root and through the stem.  Holli's plush body distends beautifully as the swollen shapes squeeze on her tentacle-wrapped form.  Her breasts even fountain a spray of syrup from the extra compression.  The first one to enter her comes through her mouth, stretching her jaw to its limits.  Distending her throat, the bulging spunk-globule passes down her esophagus to burst free from your flaring, purplish cock-tip and explodes into her waiting belly.  Her eyes widen in confusion as her abdomen is packed with spunk, all without her getting to taste a single, salty drop.");
	outputText("\n\nWhile those spooge-filled distortions travel on, your body has already pushed out the next set");
	if (player.cumQ() > 500) outputText(", and the next");
	if (player.cumQ() > 1400) outputText("... and the next");
	outputText(".  Another jizz-load reaches one of your crowns, and you fire a goopy load into Holli's hair from one of the hand-bound shafts.  The other side follows, spraying a torrent of milky creme onto her face, practically gluing the dryad's eyes shut with semen.  The twin-tit-fucking tendrils ejaculate next.  The first one is barely seen, as it's lodged deep between her gorgeous g-cups, but you can feel it.  The warmth floods her breasts with subtle, wet heat, making your other tentacle cum all that much harder.  It spurts hard enough that the load deflects off her neck and chin and right back down onto the top of her tits, glazing both.");
	outputText("\n\nHolli climaxes again when your load passes into her vagina, deforming the petals slightly as it goes.  Her cunt-tentacles are similarly stretched by the force of your orgasm, distended by spermy knots that erupt inside them.  Jizz and girl-cum drip from the numerous twats, all five of them.  Those pussies aren't simply idly filled either.  They hungrily massage you throughout their own moments of bliss, actually providing a modicum of suction to draw even more spunk from your [balls].  You roar in triumph and thrust all ten at once, pushing them as deep into their chosen locations as you ride out of the ecstasy, spurting and shaking.");
	outputText("\n\nYou come to a little while later.  Your myriad tentacles have retracted back to your groin, though a goodly number of them have a distinctly feminine odor clinging to them.  Holli is sagging back in her tree, covered in a pearly shine that can only be your fertile batter.  She's panting while the cum runs out and over her unimpeded, dripping from the canopy as well.");
	outputText("\n\nStretching the kinks from your shoulders, you walk up to the confused cum-dump and say, \"<i>That's how you sow seed, little flower.</i>\"  Holli shudders, releasing a squirt of your goo from her twat.  You laugh and get dressed before departing, feeling blessedly sated.");
	player.orgasm();
	dynStats("lib", .4, "sen", -3, "cor", 1);
	flags[kFLAGS.TIMES_FUCKED_FLOWER]++;
	flags[kFLAGS.HOLLI_FUCKED_TODAY] = 1;
	fertilizeHolli();
	fertilizeHolli();
	doNext(camp.returnToCampUseOneHour);
}
//Vaginally Dominate Tentacles
private function vaginalDomHollisTentacruels():void {
	clearOutput();
	flags[kFLAGS.HOLLI_FUCKED_TODAY] = 1;
	outputText("You sashay over to your favorite tentacular tree and trace your finger through Holli's cleavage, purring, \"<i>I'm feeling a little randy.  Do me a favor and bring your 'little' friends down to play, would you?</i>\"  The commanding tone of your voice leaves little doubt that the question is anything but.  With a little bit of fear in her black, tainted eyes, Holli nods meekly.  A rain of green, phallic tentacles pours out of the robust canopy above, hanging behind you idly, though a few of them arch up like snakes sensing prey.  You hold your immobilized pet's chin in your hand and tilt her head up slightly so she sees you eye to eye.");
	outputText("\n\n\"<i>Good pet,</i>\" you coo, releasing her and turning about, making sure to sway your [hips] hypnotically and remind her just what she's going to get.  The closest tentacle sways in your direction to nuzzle on your " + player.skinFurScales() + ".  You raise your palm to support it, gliding your palm along the underside while you shrug out of your [armor].  The phallic vine eagerly rubs against you like an affectionate pet, though clear sap leaks from the moist slit at its tip.  You squeeze it just behind the purple-tinged tip and pull, dragging it over toward Holli.");
	outputText("\n\nThe demon-dryad tilts her head uncertainly as she's confronted with one of her own unholy malenesses.  You set the long shaft in between her heavy breasts and step back to observe your handiwork.  The tendril wiggles happily and begins to slide through her cleavage, rocking her back a little from the force of its affections.  Holli gasps, surprised by her lack of control and the masturbatory tit-fuck.  Her eyes cross, trying to lock onto it as it pushes through her tits, the purple tip butting up against her chin at the apex of its path.  You pump the shaft a few feet back to encourage it, and the pulsing prehensile penis plunges through her lips.");
	outputText("\n\nA muffled moan slips from the arbor bitch's well-stuffed mouth, accompanied by a shuddering shake that sets her tits to wobbling.  You prance up next to her and whispers in her ear, \"<i>Get that one nice and wet for me, okay, babe?</i>\"");
	outputText("\n\nHolli moans again, this time loud enough to be audible from more than a few feet away.  You pirouette away, flouncing through the forest of idle green cocks.  They seem a little bigger - perhaps more engorged - than before.  The arousal coursing through Holli's body must be spreading through all of her extremities, even ones as far removed as these.  Grabbing two more, you spin back to face the orally occupied god-spawn.  Her eyes are half-closed and unaware, though she can surely feel the heat of your palms warming her double dicks' undersides.");
	outputText("\n\nA wicked idea comes to mind, and you act on it without pause, releasing one of your prizes to pry the saliva-soaked member from Holli's mouth.  She gasps in a quick pant, just in time to be plugged with a fresh cock, immediately releasing the fresh air in a whimpering groan that vibrates through this new cock.  You yank the well-lubed phallus down to your mons and press it up into your [vagina].  Though it is wide, the tip is well rounded, and it slides through you with almost buttery smoothness.  Behind the distended crown, the wiggling flesh tube begins to exert a gentle pressure, lashing around as it tries to penetrate you further.  You relax further and allow it to spear deeper, all the way to your unguarded cervix.");
	player.cuntChange(25,true,true,false);
	outputText("\n\nIt takes considerable effort, but you manage to remain upright through it all.  An involuntary trembling washes through you as you caress the remaining cock.  You cough to clear your throat and tauntingly ask, \"<i>Enjoying the mouthful, dear?</i>\"  She nods, jiggling the dangling shaft this way and that with the motion.  \"<i>Good, keep on sucking, and don't let the tentacle between my legs be idle either.  You're going to bring me off to a nice, wet orgasm.</i>\"");
	outputText("\n\nHolli nods again, more enthusiastically this time.  The tentacle lodged in your [vagina] retracts slightly, but only for a moment.  It returns to your twat with a vengeance, plunging up hard.  You gasp, \"<i>O-oh!  Go... go slower!</i>\"");
	outputText("\n\nThe tentacle prick pumps faster, more and more of its surface coated with wetness as it works.  You growl in frustration, yank the dick out of Holli's mouth, and slap her across the face with it, broadside.  She gasps in pain and shock.  Between your legs, the overeager motions cease.  In your hand, the slick shaft tries to wiggle free.  You squeeze down on it, and it arrests its rebellious motions, lest it injures itself.");
	outputText("\n\n\"<i>I told you, slower,</i>\" you say, punctuating the sentence with another heavy cock-slap.  Holli works her jaw in irritation, but lowers her eyes against the inferno in your steely gaze.  \"<i>Better.  Now, kiss and make up, you two.</i>\"  You cram the tender cock right back into her noise hole and command, \"<i>Giddyup, little pony - you've still got a [master] to serve.</i>\"");
	outputText("\n\nThe undulations down below resume, this time at a pleasantly languid pace.  You sigh in contentment, finally able to enjoy the slow fuck.  You grope at your [fullChest]");
	if (!player.hasFuckableNipples() && player.lactationQ() < 50) outputText(" and pay special attention to your [nipples], tugging them in time with every sluggish thrust in your slit.");
	else if (player.lactationQ() >= 50) {
		outputText(" and sigh at the ");
		if (player.lactationQ() < 150) outputText("squirts");
		else if (player.lactationQ() < 800) outputText("sprays");
		else if (player.lactationQ() < 2000) outputText("outpouring");
		else outputText("thick fountains");
		outputText(" of milk that escape with every tug, timed to match the sluggish thrusts at your slit.");
	}
	else outputText(" and sink your fingers into your [nipples], fucking them to the sluggish tempo of the thrusting tentacle.");
	outputText("  A loud groan escapes your mouth, and you rock your [hips] against the undulating tendril.  Your body's eagerness for more pleasure is unparalleled, but you control yourself as efficiently as you control the dryad.");
	outputText("\n\n\"<i>Bring two tentacles over here, Holli.  I want to see how you look with a mask of your own seed.</i>\"  Holli's pale green skin blushes darker, almost as dark as her viridian hair, but two tentacles appear beside you, as if by magic.  Their heads are flared and purplish, as wide as the shaft and a half, leaking clear trails of slick pre-sap.  You touch the tip of one and giggle when it bubbles up a fresh batch of lubricant.  It's smooth and slick on your hand, perfect for a handjob.  You begin to masturbate the two arrivals, taking care to keep them pointed directly at Holli's face.  The poor woman has her mouth full of dick, a cock deep in your twat, and two swollen heads barely a few inches away from her unprotected face.  It's a wonder she can think with all that going on.");
	outputText("\n\nMoving quicker now, Holli's tentacle begins to pound you faster, pistoning with greater and greater enthusiasm.  You let it - you're achingly wet by this point, and a fast, fervent fuck is exactly what your [vagina] needs.  \"<i>Harder!</i>\" you urge, and your obedient tree-slut obeys.  The thick-tipped tendril smacks into your cervix, filling your channel completely with its thick length.  Its shaft arches up, grinding over your [clit]");
	if (player.clitLength >= 3.5) outputText(" for a moment before wrapping around and jerking on it");
	outputText(".");
	outputText("\n\nHolli cries, \"<i>Hnnng...  grmmnuh... gmmmnuh mmphum!</i>\"");
	outputText("\n\nShe's... what?  A telltale flaring deep inside you alerts you what she was trying to tell you - she's about to cum.  Well, you aren't far that yourself, and there's nothing like a show to put you over the edge.  You jerk faster on the cocks in your hands, smiling when their purplish heads distend violently, so wide you're forced to keep your hands behind the tips.  Droplets of pre-cum spatter off the ground, and Holli's cheeks bulge with the over-engorged girth inside her mouth.");
	outputText("\n\nYou whisper into her ear, \"<i>Go on, slut, cum.</i>\"  You stroke her faster, so fast your arms are starting to burn from the effort.  \"<i>Cum for [master], go on.  Spooge all over your pretty face and hair.  Pump all that nasty cum straight down your throat.</i>\"  Holli's eyes begin to roll back, and you throatily purr, \"<i>Bust a nut in my cunt, little slut.</i>\"");
	outputText("\n\nThe tentacles go rigid, completely, absolutely hard.  The swollen heads pulsate while bulges of cum ripple down the lengths behind them, eventually bursting out.  You hold them firmly and direct them across the demon-dryad's striking face, burying it in thick flows of white.  Her shiny green hair quickly comes to wear an alabaster bonnet, dripping thick spunk over her eyes toward her tits.  Jism pours out of Holli's nostrils unhindered while her throat works to swallow it all, but no matter how much she gulps, she can't seem to keep up.");
	outputText("\n\nA warm wave washes into your womb at the same time, easily injected past your cervix's unresisting entrance.  Some of it sputters out to the sides to further lubricate your tunnel.  It sets you off like a bomb, and you fall back onto the ground, trying to lift your [hips] higher.  With gravity assisting, the jism floods your uterus even faster.  The squeezing tightness of your involuntary muscle spasms don't help.  If anything, your body is holding even more of the spooge inside, forcing you to take another few blasts of jizz straight into your well-packed reproductive system.");
	outputText("\n\nThe still spurting cock begins to withdraw, dragging its over-sized head through your sensitive, quavering gates.  It bumps your tender clit on the way, soaking it with a fresh flow of semen.  Then it ascends into the canopy, leaving your [vagina] empty of everything but the gallon of creme it left behind.  You hum in satisfaction and try to stand.  Your [legs] wobble and give out, dropping you back ");
	if (player.wetness() < 4) outputText("onto the ground");
	else outputText("into the leavings of your squirting orgasm");
	outputText(".  The second time, you make it up.  Holli is a mess.  Everything from the shoulders up is glazed white, while the rest of her body has strings of seed dangling like obscene Christmas ornaments.  Around you, there's small puddles of seed rapidly vanishing into the wasted earth - each of the other tentacles erupted with its brothers, spurting uselessly as you ignored it.");
	outputText("\n\nYou give Holli a peck on her cheek, savoring the flavor and say, \"<i>Good girl.</i>\"  Then, you get dressed, trying to ignore the squishing wetness between your thighs.");
	flags[kFLAGS.TIMES_RIDDEN_FLOWER]++;
	flags[kFLAGS.HOLLI_FUCKED_TODAY] = 1;
	fertilizeHolli(false);
	player.slimeFeed();
	player.orgasm();
	dynStats("sen", -2, "cor", 1);
	doNext(camp.returnToCampUseOneHour);
}

private function threatenHolli():void {
	clearOutput();
	outputText("You snarl and threaten to burn the barked bitch to the ground if she won't make herself useful after you ask politely.");
	outputText("\n\n\"<i>You threaten me with fire?!  Now?  [name], you could have uprooted my sapling and tossed it in the fire.  You could have made a bonfire to char my flower to cinders.  You could even have called upon magic to torch my tree while it was still young.  Now?  My bark is stronger than iron and flush with the power of an invigorated goddess.  You had opportunities to rid yourself of me before Marae had invested this much time and energy into your gift.  Trying to destroy such a personal present now would draw her attention... and her ire.</i>\"");
	
	outputText("\n\nThat is a compelling point.  ");
	if (player.level < 30) outputText("Mighty as you are, Marae is likely still beyond your power.  Perhaps you should just ignore this demon for the time being.");
	else outputText("Marae is likely beyond your power yet, but... you feel like she might not pressure you too hard if you can make a suitably credible threat.");
	outputText("\n\n\"<i>Now, I hope you rest well in the knowledge that I'm going to stay firmly in my tree, no matter what.  Watching the vermin of this land walk over your bedroll while you try to sleep will be suitable recompense for your rudeness.</i>\"");
	//[(kid a, thorn canopy, or other non-jojo watch is on)
	if ((player.gender > 0 && player.findStatusEffect(StatusEffects.JojoNightWatch) >= 0 && player.findStatusEffect(StatusEffects.PureCampJojo) >= 0) || flags[kFLAGS.ANEMONE_WATCH] > 0) {
		outputText("\n\nYeah, whatever.  She'll be waiting a while for that; you've got your back covered.  With a dismissive, pointed gesture, you leave the smug arboreal demon behind.");
	}
	//{No option to beg for night watch till PC has been imp raped}
	outputText("\n\n<b>Maybe you should just slap her the next time she refuses to guard the camp and try your luck anyway.</b>");
	flags[kFLAGS.THREATENED_HOLLI] = 1;
	doNext(camp.returnToCampUseOneHour);
}




//Hit Her With Your Hand (requires failing to threaten) -Z
//replaces Threaten button once PC fails threaten
private function slapDatHo():void {
	clearOutput();
	outputText("You slap the slut in the tree on the thighs, sending a ripple up her body; she regards you with a sneer, confident that her previous implication, that between her and her mother, only a fool would attack, will be enough to stop you from removing her by force.  You might still be able to if you're powerful enough, but... she has the energy of a demon 'goddess' flowing into her.  You should be <b>very</b> sure of yourself before you resort to open confrontation, lest you make your campsite uninhabitable.");
	outputText("\n\n\"<i>What do you want, meat?  Come to play?</i>\"");
	
	//[Cut Her Down][Call Jojo(requires talisman)][Ignore Her]
	//ignore returns to previous menu and is default spacebar option
	menu();
	addButton(0,"CutHerDown",cutHerDown);
	if (player.hasKeyItem("Jojo's Talisman") >= 0) addButton(1,"Call Jojo",callDatJojo);
	addButton(4,"Ignore",treeMenu,true);
}

//[Cut Her Down]
private function cutHerDown():void {
	clearOutput();
	outputText("\"<i>Are you serious?  You really want to be broken that badly, my little toy?</i>\"  The demon folds her arms over her hefty chest, her earlier, suggestive posture completely absent now.  \"<i>You know my bark is as strong as any armor, right?  That Marae herself - the land itself - bolsters me?  Take that back right now, and I'll let you return to my good graces... if you put your face in the dirt and plead for the duty to pleasure me whenever I want.</i>\"");
	
	//(if PC weapon = Large Axe)
	if (player.weaponName == "large axe") {
		outputText("\n\nThat's a trick.  You get your axe.  A tree is a tree, after all, and you quietly test the blade with your thumb meaningfully while the demon looks on.  She seems to quail slightly at the sight of it, but soon recovers her composure.  The jade-skinned succubus slides back into her tree, until only her livid face is visible in the middle of its hard surface.  Several roots burst from the ground around you as her visage takes on a fierce, thunderous aspect; she's trying to strike first!");
	}
	else {
		outputText("\n\n\"<i>So... you're armored and have magic?  Just like all the other tainted insects I crush.</i>\"");
		
		outputText("\n\nThe verdant demon looks incensed at your words, and withdraws into her tree; bark slides over her body until only her face is visible.  It contorts with rage as roots burst from the ground around you and she begins to attack!");
	}
	//go to fight
	flags[kFLAGS.FOUGHT_HOLLI] = 1;
	startCombat(new Holli());
}

//[Call Jojo]
private function callDatJojo():void {
	clearOutput();
	player.removeKeyItem("Jojo's Talisman");
	outputText("You take out the small talisman you got from the mouse monk, wondering just how to summon him with it.  A small string dangles from the side; when you pull it, you can feel a stitch coming undone and the weight of the talisman shifts toward the bottom.  A thick, billowing yellow smoke begins to pour out.  God, this reeks!  You hurl it away before the smell can permeate your clothing, and it sets off an echoing bang when it hits the ground!  It's not long before Jojo appears from the edge of the forest and calls to you.");
	
	outputText("\n\n\"<i>Apologies, [name], but the sound and smell were the only way I could be sure of knowing and finding you when you needed me!</i>\"  He raises a cloth over his nose, then hefts his staff.  \"<i>If you choose to fight this demon plant creature, I will try to start a blaze to limit her ability to regrow.  It will take a lot of wood to burn a tree so unnatural, so I will not be able to do much else but ferry tinder from the stock I've been laying in.  You will have to hold her attention.</i>\"");
	
	//[(if not made hostile by fight yet)]
	outputText("\n\n\"<i>What is this?</i>\" the demon tree roars, breaking in on your conversation.  \"<i>First you set off silly toys that foul my air, and now you talk of burning me?!  I will not tolerate this!</i>\"  Her voluptuous body pulls back into the tree and bark closes over all of her form except her face.  Roots burst violently from the ground, waving with menace.  \"<i>I will break you both!</i>\"  Jojo quickly scurries off to fetch the first armfuls of wood, leaving you to withstand the onslaught!");
	//go to fight
	flags[kFLAGS.FOUGHT_HOLLI] = 1;
	startCombat(new Holli());
	monster.createStatusEffect(StatusEffects.JojoIsAssisting,0,0,0,0);
}




internal function defeatHolli():void {
	clearOutput();
	flags[kFLAGS.FUCK_FLOWER_KILLED] = 1;
	//Win without Jojo -Z
	if (monster.findStatusEffect(StatusEffects.JojoIsAssisting) < 0) {
		outputText("Weary, the succubus godling folds into her tree, unwilling to allow you the sight of her defeat.  With her energy suppressed, you're free to ");
		if (player.weaponName != "large axe") outputText("fetch an axe and ");
		outputText("hack at her trunk, laboriously peeling bark and making wedge-shaped cuts in it as you try to fell the abomination.  It takes nearly eight hours, but eventually the gnarled tree topples.  No sooner does it fall than it shrivels and turns to ash.");
		temp = 7;
		while(temp > 0) {
			temp--;
			model.time.hours++;
			if (model.time.hours > 23) {
				model.time.days++;
				model.time.hours = 0;
			}
		}
		statScreenRefresh();
	}
	//Win with Jojo -Z
	else {
		outputText("The fire-blackened mouse cheers at you as the succubus groans and retreats completely into her bark.  \"<i>Well done, [name]!  Help me carry tinder and we can burn this abomination to the ground!</i>\"");
		outputText("\n\nWeary but recognizing the need to finish this now, you help the monk haul firewood to the base of the tree until the blaze roars like a bonfire.  It takes hours of carrying wood and eventually cutting it as well, but finally the tree is nothing but ash.");
		temp = 3;
		while(temp > 0) {
			temp--;
			model.time.hours++;
			if (model.time.hours > 23) {
				model.time.days++;
				model.time.hours = 0;
			}
		}
		statScreenRefresh();
		//[(if no Vapula)]
		if (!vapulaSlave()) {
			outputText("\n\nThe monk nods to you.  With the demon gone, you could probably invite him to remain in camp - after all, you are quite a good team.  Do you offer to let Jojo stay?");
			//[yes][no]
			menu();
			addButton(0,"Yes",recruitJojoToCamp);
			addButton(1,"No",dontRecruitJojoToCamp);
			return;
		}
	}
	outputText("\n\n(Key Item Gained: Holli's Ashes)");
	player.createKeyItem("Holli's Ashes",0,0,0,0);
	combat.cleanupAfterCombat();
}
	
//[yes gimme monk pls]
private function recruitJojoToCamp():void {
	clearOutput();
	outputText("Jojo nods eagerly at you when you invite him to share your camp.  \"<i>Excellent idea.  If you'll excuse me, I wish to attempt to purify the spot where the creature grew, and then I will fetch my things.</i>\"");
	outputText("\n\nBowing neatly, he takes his leave.");
	player.createStatusEffect(StatusEffects.PureCampJojo,0,0,0,0);
	outputText("\n\n(Key Item Gained: Holli's Ashes)");
	player.createKeyItem("Holli's Ashes",0,0,0,0);
	combat.cleanupAfterCombat();
}

//[no want]
private function dontRecruitJojoToCamp():void {
	clearOutput();
	outputText("You hold your tongue, allowing Jojo to make his way back to the forest.");
	outputText("\n\n(Key Item Gained: Holli's Ashes)");
	player.createKeyItem("Holli's Ashes",0,0,0,0);
	combat.cleanupAfterCombat();
}
	
//>Lose
internal function enjoyYourBadEndBIYAAAATCH():void {
	clearOutput();
	outputText("Screeching in triumph, the demon holds your defeated form aloft and begins to shake you.  ");
	if (monster.findStatusEffect(StatusEffects.JojoIsAssisting) >= 0) {
		outputText("Jojo drops the firewood he's carrying and attempts to strike her, but she swats him aside brutally with a branch, leaving him clutching his stomach and retching as he stumbles away; she returns her attention to you, completely fixated.  Her oozing sap runs in streams as she heals the damage from the dwindling flames.  ");
	}
	outputText("\"<i>Oh, my little meat...</i>\" Holli coos dangerously.  \"<i>Was I not clear enough before?  You exist to worship me.  If you won't give your mind to me, I'll have your body, instead.</i>\"  A floral tendril descends from her upper branches, slipping into your mouth and beginning to drool a nectar down your throat.  Forced to drink or drown, you gulp unhappily, feeling increasingly light-headed with each swallow.");
	
	//FOOOOARK - choose with RNG for herms
	//branch of penis-having
	if (player.gender == 1 || (rand(2) == 0 && player.hasCock())) {
		outputText("\n\nShe strips off your [armor] haphazardly, rending and shredding with vicious tugs and leaving deep lines where the clasps bite into your " + player.skinFurScales() + " before parting.  [OneCock] exposed, she lowers her mouth to the [cockHead biggest] and");
		if (player.cocks[player.biggestCockIndex()].cockThickness > 6) outputText(", stretching her jaw wide open in a way that makes you wince,");
		outputText(" engulfs you.  Holli's tongue plays over your slit and she looks up at you for just a moment to be sure you're watching.");
		
		outputText("\n\nOnce she's captured your attention, she smiles disarmingly around your shaft... until you feel a prick at the end.  A small stem slides into your cockhole, and you freeze in panic.  Holli's eyes dance with amusement at your discomfort, and she begins to work her lips up and down the [cock biggest], giggling into it every time the insertion scrapes your inside and you flinch.  It's hardly more than a few minutes of this internal and external stimulation before your doped-up mind is at the brink of climax, and your dick twitches eagerly.  Holli responds to this, halting her current plunge and watching you again.");
		
		outputText("\n\nYour pleasure-fogged eyes goggle at her face for several minutes as your impending orgasm recedes at a glacial pace - when the demon judges you to be calmed enough, ");
		if (player.biggestCockLength() > 24) outputText("her neck ripples and extends grotesquely, and her head begins to migrate down all " + num2Text(Math.round(player.biggestCockLength())) + " of your prick with alarming speed, pushing the stem inside along with it.  ");
		else outputText("she sinks her head down to the base of your prick in one quick thrust, bringing the stem with it.  ");
		outputText("The sensation of having your entire [cock biggest] penetrated and sucked into her hot, wet, clinging throat pushes you back toward the edge and over, and it literally becomes a race for Holli to reach bottom before your nerves fire.  Her wet lips impact your crotch with a lewd splatter, but her tongue keeps going deep into your body, stopping only once it reaches your prostate.  A small bulge fires down the thin stem, forcing through your slit and into the shaft to lodge in your gland.  Holli's mouth and tongue withdraw once it is in place, and she grabs your cock in her hand, masturbating you vigorously.");
		
		outputText("\n\nIt's too much; your climax comes in a flood");
		if (player.balls > 0) outputText(", and your [balls] draw close to your body to unload");
		outputText(".  Your eyes roll as you flex and flex, but nothing comes out.  As you conclude your dry orgasm, you begin to feel a pressure on your prostate.");
		
		outputText("\n\nHolli smiles.  \"<i>That's right, my toy... water my little seed.  Let it grow.</i>\"  The swelling increases, and you shiver as the pressure on your prostate forces out another squirt of fluid... which also never sees the light of day.  Each miniature orgasm causes the swelling to increase, which provokes yet another.  As you reach the conceivable limit of what your prostate could produce, hoping desperately for a respite, you feel a pincushion's worth of jabs in it, followed by a suffusion of fluttering warmth and growth, and then your agonizingly pleasurable squirts begin again.  You can actually feel a pressure finally begin to ascend your dick, and anticipate the release coming.  Closer and closer it creeps, right up to the tip, until what must be the first drop is peeking out.  You look down, and Holli's eyes join yours, to behold... a small green nub.  She smiles, leans down, and gingerly kisses it; a visible vibration travels back down your body and your prostate feels like it's overheating.  The sprout explodes from the end of your [cock biggest], a fleshy tentacle that lashes in the air, swaying your shaft wildly and drooling your cum from an open slit in its end.  More buds can be felt inside now, ");
		if (player.balls > 0) outputText("migrating the other direction into your [balls], entangling and infiltrating them, filling them with the same warmth, then pressing out against your sack.  ");
		else outputText("exploring the depths of your body and curling back against the surface of your " + player.skin() + ".  ");
		outputText("Your stomach turns as the sprouts push their way through, crawling from your crotch down the outside of your [legs] to root in the dry earth.  The shoots thicken into fibrous roots, forming a trunk that supports you and pushes you closer to Holli and lower to the ground, until your writhing, tentacle-tipped prick is lined up with her pussy flower and within her easy reach.");
		
		outputText("\n\n\"<i>Foolish little meat,</i>\" the demon smiles down at you, \"<i>I <b>am</b> Mareth.  There is a part of me in everything born in this land.  And now, in you as well.</i>\"  Your tendril reaches for Holli's nethers at her unspoken command, dragging your [cock biggest] into her wet, lush depths as she wraps her arms around you...");
		
		//--Next--
		player.orgasm();
		dynStats("lib", 5, "sen", 20);
		menu();
		addButton(0,"Next",holliPlaysWithPenisesBadEnd);
	}
	//branch of vagina-having
	else if (player.hasVagina()) {
		outputText("\n\nShe pulls impatiently at your [armor], ripping the fastenings and tearing it off of you to expose your crotch.  With a caress between your legs, she murmurs, \"<i>Oh, my pet, we are going to plant something beautiful in this little furrow of yours.</i>\"  Raising you above her head");
		if (player.isTaur()) outputText(" and turning you around");
		outputText(", the demon buries her face in your [vagina], penetrating it with her wet, flexible tongue.");
		
		outputText("\n\nYou peal in surprise at the sudden insertion but Holli does not relent or dally, pushing past the sensitive entrance and deep into your pussy, butting up against the cervix with a twinge.  Fretting, you look down at the demon, who meets your gaze with a diabolical smile.  A push and a pinch and her tongue slips past the gateway to your womb, tensing your body involuntarily.");
		
		outputText("\n\nHolli hums happily as her tongue reaches deep into your body.  Abruptly, you feel a small bulge pass through your entrance, and a moment later the demon's tongue withdraws.  Your curiosity mounts as she unbends and draws up to eye level - what was that bulge?  She offers no answer, instead kissing you on the lips gingerly and pushing your hair away from your face.  \"<i>Now for the fun part.</i>\"");
		
		outputText("\n\nSomething ");
		if (!player.isGoo() && !player.isNaga()) outputText("slips between your thighs and ");
		outputText("noses at your [vagina].  A phallic tendril, unnoticed by you as the demon was probing you with her tongue, slips into place, pressing insistently for admittance.  Muddled and slack-muscled from the her nectar, you can do nothing to keep it out; it threads its way between your well-lubricated labia with a soft, smooth scrape, forcing a sigh from your mouth");
		if (player.hasCock()) outputText(" and a glob of precum from [eachCock]");
		outputText(".");
		
		outputText("\n\nHolli smiles wanly at your body's betrayal, thrusting the tentacle in time with your wanton gasps.  Within minutes, her face pinches and your cunt is flooded with thick, liquid pressure.  The tentacle withdraws, triggering one last flush as it brushes by your labia, trailing hot, sticky sap.  Your expression must reveal something of your disappointment at its exit, because the demon takes your face in her hands and brings it closer to hers.");
		
		outputText("\n\n\"<i>Oh, my little toy... did you think us finished already?</i>\"  From the corner of your eye, you see another tendril drop into place as she speaks, followed by five more.  Against your better judgment, your eyes and mouth widen into an anticipatory smile, and then a moan as the next of Holli's rough-skinned arboreal cocks forces into your dripping cunt.");
		
		outputText("\n\nThis tentacle climaxes before you do as well, ejaculating a fresh load of the hot goo into your packed pussy and making you feel full.  Holli gives a short sigh and slumps against you as it pours forth, pressing her soft breasts to your");
		if (player.biggestTitSize() >= 1) outputText("s");
		else outputText("chest");
		outputText(".  The demon looks up, breathing heavily.  \"<i>Don't worry, lover.  When your time comes, you will as well.</i>\"  She holds you, looking into your eyes with her own eerie black portals, apparently waiting for something; as your heaving body calms down, she strokes your [hair].  Increasingly able to focus your thoughts on something other than the pleasure of being thrust into, awareness creeps in on you.  The wet, yielding pressure of Holli's ejaculate is receding as it oozes from your spread-open cunt, but in its wake, it's leaving a lesser, solid sensation.");
		
		outputText("\n\nYour musings are interrupted as another rough tentacle is jammed into your [vagina], filling your mind with pleasure and chasing out reason.  The green demon thrusts to orgasm again, and once again, bringing you maddeningly close to your limit but always depositing a fresh load of goo and withdrawing the spent tentacle for another bout of holding you still before you can peak.  Through Holli's unwelcome pauses and the sap of the fourth and fifth tentacles, the sensation from your cunt continues to change; by the entry of the sixth, it feels as though the walls have thickened and are gripping onto the shaft of Holli's appendage, every inch as sensitive as your [clit] and entrance used to be and wracking your body.  The demon bites her lower lip and this tendril climaxes as well; as it slides out, it feels as though the walls of your pussy are sliding out with it.  With a pop, something comes free, and you look down to see a bud of fleshy, vibrant red petals unfurling from your entrance.  Eyes glittering with excitement, Holli releases one of your hands from her grasp, and you automatically reach down to touch the flora emerging from your sex.  The simplest stroke sends near-orgasmic convulsions up the inside of your pussy and to the base of your spine, and the flower drools lubricant.");
		if (player.hasCock()) outputText("  [OneCock] drools precum down its length and onto the flower, triggering another spasm and another gush from your prick.  Holli laughs as you continue to self-stimulate with your uncontrollable fluids.");
		
		outputText("\n\n\"<i>What a pretty blossom you have become, my pet.</i>\"  The demon traces your new petals with the tip of her last tendril, destroying your muscle control and making you helpless in her grip.  Pressing herself to you, Holli slides the tendril in slowly, dragging it across the inside of your florid pussy, which constricts to perfectly fit the intruder and causes your eyes to roll back in your head as every tight inch of your new, sensitized vagina is stimulated.  In just two thrusts you're at your peak, and the demon squeezes you to her chest as she speaks.  \"<i>As promised, your time is now.</i>\"");
		
		outputText("\n\nHolli's lips dart to yours, locking you up in a kiss that carries pulses of slippery nectar and demonic energy through your throat and torso and down to your groin to meet the ones rising from her spurting cock-tendril.  As your body shudders in your devastating, long-wished-for orgasm, the pressure in the back of your vagina swells painfully and expands, racing along your walls toward your entrance.  When the sensations reach daylight, Holli pulls away and numerous long tendrils of your own snake from the gaps between your cunt and the slippery-sticky petals growing out of it, winding down your legs and up your torso, digging into the soil and ");
		if (player.biggestTitSize() > 1) outputText("wrapping around and under your breasts to keep them permanently jutting out in a lurid display");
		else outputText("tracing a lattice of slender, criss-crossing ivy over your chest that hangs just far enough over your [nipples] that a stiff breeze will drag it into them");
		outputText(", then continuing over your back and up your neck.  The tendrils thicken and multiply, occluding your forearms and lower [legs] in a casing of young bark and leaf buds, and Holli's own release you as yours take over the duty of holding you in place to receive whatever pleasure she forces upon you.  You're left in a salacious pose when the growth subsides, suspended several feet off the ground with your arms held over your head, your back arched in a memorial of your incredible orgasm, ");
		if (player.biggestTitSize() > 1) outputText("your breasts cupped and pressed together by vines, ");
		if (!player.isNaga() && !player.isGoo()) outputText("your thighs spread wide open, ");
		outputText("and your nectar-drooling flower-sex exposed with your [clit]");
		if (player.hasCock()) outputText(" and [eachCock]");
		outputText(" bobbing in a state of permanent semi-arousal.");
		
		outputText("\n\nThe young sapling encasing you bends toward Holli with a gesture from the demon, and she leans over you.  \"<i>Sweet little toy... you never had a chance.  I am Mareth. There is a part of me in everything of this world.  Now, in you as well.</i>\"  The verdant woman smiles darkly as vines cover your eyes, blinding you.  As something begins nosing up to your pussy, she whispers, \"<i>It won't be lonely, though...</i>\"");
		
		//--Next--
		player.orgasm();
		dynStats("lib", 5, "sen", 20);
		menu();
		addButton(0,"Next",girlsGetANiceManToBadEnd);
	}
	else {
		//branch of nothing-having
		player.orgasm();
		dynStats("lib", 5, "sen", 20);
		outputText("\n\nShe pulls your [armor] free without care, breaking the fastenings in her haste.  A raised eyebrow meets your bare crotch, but Holli doesn't pause for long.  \"<i>My simple little toy... if it were so easy to keep out the corruption of this land, the demons would be overthrown tomorrow.</i>\"  Revising her plans, the demon turns you around and slides a finger between your asscheeks, bending close.  ");
		if (player.ass.analWetness > 0) outputText("Betraying your depravity, the slick crack opens wide and your greedy, wet asshole practically welcomes the demon's entire hand, sucking it up and making you shiver with repressed delight.  \"<i>Oh, mother!  It seems as though this is not a new lesson to you, is it?  My little whore, will you beg and moan as I fill you?</i>\"");
		else if (player.analCapacity() < 30) outputText("With some difficulty, she forces it into your pucker.  \"<i>I think we'll just use this as our inroads, instead.  It may be slow going, but the journey is half the fun.</i>\"");
		else outputText("Despite your clenching, your loose hole proves no impediment to the demon's exploration.  \"<i>Ah, how roomy you are!  I think I'll move right in.</i>\"");
		
		outputText("\n\nHolli's eyes darken in concentration behind you, and you shudder and squirm as you feel her appendage swell and distort inside your ass.  The demon's fingertips pull apart, forcing your asshole wide open, and her hand begins to elongate, pushing the width of her palm deeper into your bud.");
		player.buttChange(20,true,true,false);
		outputText("  After an agonizing minute of intimate stimulation and expansion, Holli's face contorts to a grimace and veins begin to protrude on her arm.  A small bulge swells in her chest, briefly pushing her breasts into you before passing through her shoulder.  Down her arm it glides, pausing at her wrist as it meets the fear-inspired resistance of your [asshole], then disappearing into your backside with a painful push.  She sighs as the bulge slides the last few inches to the end of her hand, and your lower body is flooded with warmth.");
		
		outputText("\n\n\"<i>My gift to you,</i>\" the demon murmurs, pulling herself free.  As she extracts it, you can see over your shoulder that her hand is stretched to twice its former length and oozes a viscous fluid from a slit in the palm that matches the one drooling from your abused rectum.  The mangled hand slowly shifts back to a recognizable shape, but another bulge begins to form on Holli's mons.");
		
		outputText("\n\n\"<i>Ah... ah-ahhh!</i>\" she moans, as her body quivers and pushes out the growth.  \"<i>H-here you are, my toy - I've made the perfect key to unlock your body.</i>\"  ");
		//[(iff buttslut)
		if (player.ass.analWetness > 0) outputText("Try as you might, you can't see far enough down your back to determine what the demon has done.  The question answers itself, though, when she presses a shaft almost as thick as her leg into your [butt], nosing it into your wet, receptive asshole.  Despite yourself, you shiver in anticipation at being filled so completely.  ");
		else if (player.analCapacity() < 30) outputText("Your jaw hits your collarbone as Holli angles the florid head of a long, narrow penis into your field of view.  Judging by how far it comes up her chest, it's almost a foot and half long, and it's drooling sticky sap all over your back.  With a twisted smile, the demon pushes it along your spine until it reaches your [butt], then shoves it toward the hole.  ");
		else outputText("The demon presses up to your back, brushing her nipples against your skin and shoving her new growth between your thighs.  Looking down, you can see a fat, green shaft sticking from your crotch, glistening and dripping with sticky slime.  With another moan, Holli pulls it back from between your legs, then pushes apart your asscheeks and plunges it into your [asshole].  ");
		outputText("The sap oozing from her member coats your passage, ");
		if (player.ass.analWetness > 0) outputText("mingling with your own lubrication and ]easing her thrusts.  Holli's tempo picks up quickly, and soon you can feel her twitch inside you as she nears her climax.");
		
		outputText("\n\n\"<i>O-oh, my little toy, be excited,</i>\" she pants.  \"<i>I'm about to give you your purpose in this woh-world!</i>\"  With a shriek from the demon, Holli's shaft erupts and fills you with another wave of liquid warmth.  As she rests, panting, on your back, your [asshole] itches with arousal; your own unreached orgasm hangs out of reach, maddening you.  Your demon lover pulls her rapidly-deflating tool from your backside, ");
		//[(buttslut or loose)
		if (player.ass.analWetness > 0 || player.analCapacity() > 30) outputText("spilling a wave of her deposited fluids down your [legs].  ");
		else outputText("and your once-tight pucker reflexively squeezes shut as best it can, trapping all but a few trickles of Holli's deposit inside you.  ");
		outputText("The freshly-grown shaft between Holli's legs begins to shrivel, withering and browning like a cut flower.  With an expression of mild disdain, she pulls it from her body and casts it aside, where it crumbles to pieces.");
		
		outputText("\n\nThe fluids in your gut begin to mingle, sending a disquieting pinprick sensation through the skin");
		if (player.skinType == SKIN_TYPE_FUR || player.skinType == SKIN_TYPE_SCALES) outputText(" under your " + player.skinFurScales());
		outputText(".  Panic intensifies as the sensation quickly focuses on your crotch, and when the tendrils holding you push you away from the demon's tree, your curiosity gets the better of you.  You look over your shoulder again, trying to see what's happening.  As you strain to watch, you feel hundreds of tiny, sharp pinches and small vines begin to creep from your body, just below your ass.  The vines merge and thread into thick trunks as they get closer to the ground, pushing deep into the dirt and mooring you to the spot.  Arousal builds in you as they join the web of roots linking the demon Marae and Holli, as does a swelling at your crotch.  Another cluster of thin vines push free from your groin, growing upward in a lattice and lashing your arms into place, ");
		if (player.biggestTitSize() < 1) outputText("folded atop your chest");
		else outputText("crooked at your sides with your hands resting atop your [chest]");
		outputText(".  They continue past your face, reaching over your head to form a canopy similar to Holli's own.  Struggle as you may, when they're done growing you're left unable to budge and locked in a rather artful pose, head turned over your shoulder with your [ass] thrust out");
		if (player.biggestTitSize() >= 1) outputText(", your breasts exposed from the sides,");
		outputText(" and your [legs] concealed below your buttcheeks by a thick tree trunk.");
		
		outputText("\n\n\"<i>Lovely,</i>\" Holli admires.  \"<i>You'll make for a fine ambiance.</i>\"  The demon sticks one finger into your still-drooling asshole, stroking the inside of the ring and fanning the flame of your magic-driven lust.  \"<i>I may even consent to use you for release occasionally... if I can't find someone more interesting to have a tryst with!</i>\"  With a cruel laugh, she pulls out of you and retreats into her tree, leaving you staring at her bark, smouldering with desire and helpless to indulge it.");
		//--Next--
		dynStats("lus=", player.maxLust());
		menu();
		addButton(0,"Next",holliAndGenderlessSittingInATree);
	}
}

//female champ for weiner-based bad end
private function holliPlaysWithPenisesBadEnd():void {
	clearOutput();
	outputText("The young, brown-haired woman steps from the swirling portal, and the vortex collapses behind her.  Casting her eyes around the blasted, cracked landscape, she's surprised by the presence of two trees a short distance away, apparently healthy despite the lack of water and clouds of dust.  At first leery, she changes her mind when she cautiously edges closer and sees the huge, juicy fruits hanging from the branches of the leftmost tree.  Deciding that it <i>would</i> be wise to gather and use what she can find before dipping into her reserve, the brown-haired girl begins walking toward the strange trees.");
	
	outputText("\n\nAs she approaches, the outer barks of both trees part smoothly, exposing humanoid figures.  One, a voluptuous, green, horned beauty, steps down from the fruiting tree and stretches her arms toward the girl-next-door in greeting.");
	
	outputText("\n\n\"<i>Hello!  You must be the new Champion!  I am Hollicynthea, a dryad in service of this land's goddess, Marae.  I have taken root here to provide support for those who are forced to travel through the portal, that they may establish a foothold to better resist the demons.  Though admittedly, I could use your help in securing my orchard, I will still aid you however I can.</i>\"");
	
	outputText("\n\nThe brown-haired girl regards the dryad calmly.  \"<i>How can you help me?  Moreso, how could I begin to help you?</i>\"");
	
	outputText("\n\nHolli gestures to the second tree, whose figure has remained silent.  A ");
	if (player.biggestTitSize() < 1) outputText("masculine shape, it bears");
	else outputText("feminine shape, it nonetheless bears");
	outputText(player.multiCockDescript() + ", standing erect and hard as iron; the brown-haired girl blushes and looks away.");
	
	outputText("\n\n\"<i>Be not shy, Champion,</i>\" the dryad teases.  \"<i>My companion holds the answer to both of your questions.</i>\"  She reaches up to the silent figure's boughs, snapping off a strong branch and causing the tree to shake as if in pain.  The dryad draws the branch through her hand, and the wood straightens as the young twigs and leaves shift and congregate near the tip.  \"<i>Take this.  I have imbued it with a bit of my magic, and you may tap it to a plant to cause it to fruit or give up its nectar should you require sustenance.  I also notice that you are woefully unarmed; it will make a fair bludgeon until you can find something better.</i>\"");
	
	outputText("\n\nThe brown-haired girl graciously accepts the offered staff, and Holli continues.  \"<i>As to how you can help us... do not think me forward, but we could best be served by energy.  If you would lend some of your vigor to us, it would help us remain strong.</i>\"");
	
	outputText("\n\n\"<i>And how am I to do that?</i>\" the newest Champion counters.");
	
	outputText("\n\nThe dryad gestures once again to her companion's " + player.multiCockDescriptLight() + ", causing the brown-haired girl's mouth to hang open a little.  \"<i>I can think of few better ways to demonstrate your vitality,</i>\" Holli coos.  \"<i>Do not feel indebted to us, but if you would share of yourself, we would be grateful.  And, in truth, is it not a hint of longing I see in your eyes?  Come, join with " + player.mf("him","her") + " for a while and clear your head.</i>\"");
	if (player.smallestCockArea() > 36) outputText("  As the dryad speaks, the silent figure's [cock smallest] shudders and begins to shrink, dwindling to a size that would fit " + player.mf("him","her") + " prospective lover.");
	
	outputText("\n\nThe brown-haired girl wavers a bit more, but then appears to come to a decision.  Quietly unfastening her clothing, she bares herself, revealing a pair of C-cup breasts, a slender waist with wide hips, and a healthy handful of backside.");
	
	outputText("\n\n\"<i>Ahh, you have nothing to be ashamed of, my pet,</i>\" the dryad murmurs.  She extends a hand to the new Champion, then pulls her closer to the figure in the tree.  Several branches bend down from the canopy, forming a crude seat behind the brown-haired girl; as she sits nervously upon it, they draw her groin closer to the throbbing rod.");
	
	outputText("\n\n\"<i>I'm not sure...</i>\" the girl begins.  With a grin, Holli cuts her off by pushing her makeshift swing forward, impaling the Champion's pussy on the [cock smallest].  \"<i>Ahh!</i>\" she shrieks, as the branches begin to sway of their own accord in time with their master's pleasure.  A small trickle of blood seeps through the leaves, dripping onto the ground.");
	
	outputText("\n\n\"<i>Oh, Marae!  A maiden chooses to share her purity with humble dryads!</i>\" Holli coos.  \"<i>Your hymen is torn, robbing you of your virginity, but we must make this first time memorable!</i>\"  The brown-haired girl can answer only with panting and wide eyes as Holli's clitoris swells and elongates, growing into an erect, green penis capped with sepals.  As they open to reveal the plant-woman's new glans, she steps up to the young Champion's back and caresses her breasts from behind.  \"<i>Sweet young hero, accept my thanks for your offering, and be filled with the land's blessing.</i>\"");
	
	outputText("\n\n\"<i>N-no... ah!</i>\" the brown-haired girl yelps as Holli's shaft slides into her precum-slicked pussy on the next return swing.  Gibbering and drooling, the deflowered maiden is rocked back and forth with both dicks stretching her hole, rubbing in opposite directions as she swings; when one pulls out, the other slides further in.  The girl shudders and locks up as her first orgasm hits, but in spite of her sensitized nerves and cries for respite, the branches continue to sway between her lovers.");
	
	outputText("\n\nBy the time the girl reaches her third orgasm, her partners are tense and near the breaking point; with an shudder and a stilling of the shaking branches, the silent one opens " + player.mf("his", "her") + " mouth in mute ecstasy and ejaculates, ");
	if (player.cocks.length > 1) outputText("spraying the girl's stomach and tits with waste seed from " + player.mf("his", "her") + " unused manhood and ");
	outputText(" filling the Champion's pussy with so much semen it cascades from her stretched hole as Holli continues to pump.");

	outputText("\n\nThe dryad herself soon gives a cry and pushes her tits into the brown-haired girl's back as her climax comes.  A bulge ascends the green shaft, disappearing into the beat-up cunt of the Champion, and a trickle of golden sap leaks back down Holli's cock.  Pulling free, the dryad wipes her member off and folds it back into its bud; it shrinks and dwindles until nothing is left but her clitoris.  The silent one's branches lower the girl to the ground, " + player.mf("his","her") + " always-erect prick");
	if (player.cockTotal() > 1) outputText("s");
	outputText(" drooling aftershocks onto her breasts.");
	
	outputText("\n\n\"<i>Thank you, Champion,</i>\"  Holli prompts, and the girl's eyes snap open.  \"<i>The first time of a virgin is priceless; I could not help but partake.  Your gift of vitality is accepted.  Take as much of our fruit as you like, and go with our blessing.</i>\"");
	
	outputText("\n\nDazed, the brown-haired girl struggles to her feet, wobbling from the pounding her pelvis took.  \"<i>Uh... you're welcome.  Happy to help resist the demons in... any way I can.</i>\"  The silent figure's [cock smallest] twitches and pushes out one last drop of semen, and the girl looks at the shaft wistfully.  Shaking her head to break up her daydream, she dresses herself, picks up the staff, and collects several of the fruits, then makes her way into the world, disappearing into the ever-present red dust.");
	
	outputText("\n\n\"<i>Simple-minded fool,</i>\" Holli spits at the distant, retreating back of the newest Champion, stroking the erect shaft of her partner.  \"<i>I'm eager to see where and when she will take root.  Though, I wonder if your seed will impregnate her before mine can absorb it all?</i>\"");
	
	//--[Game Over], man! [Game Over]!--
	getGame().gameOver();
}

private function girlsGetANiceManToBadEnd():void {
	clearOutput();
	outputText("The weedy-looking young man steps out of the swirling, violet pool of the portal.  As the flickering shadows of its chaotic light recede, the lush glade that greets him is reminiscent of Ingnam's wilderness... apart from the nude bodies woven into the trees, bearing sundry and random erect animal cocks, voluptuous racks, wet pussies, and patches of smooth, trembling flesh - occasionally a tree will present all four.  A tent begins to form in his comfortable pants as he surveys the lewd greenery for a means to proceed.");
	
	outputText("\n\n\"<i>Welcome to Mareth, Champion,</i>\" calls a voice behind the youth.  He turns around, blushing with shame and arousal.  A gorgeous green face with dark eyes and curved horns regards him from the shadow beside the now-empty portal frame.  As she steps toward the young man, her own nudity is revealed in her swaying breasts and bare muff.  The bulge in his pants grows even as he assumes an amateurish boxing stance.");
	
	outputText("\n\n\"<i>I-identify yourself!</i>\" he calls, stuttering.  \"<i>Friend or foe?</i>\"");
	
	outputText("\n\n\"<i>Oh, please put your hands down,</i>\" the woman answers.  \"<i>I do not wish to challenge you, hero, but to aid you.  You are in the Glade of the Dryads, put here by the goddess of this land, Marae, to give succor to those brought through the portal.  I am Hollicynthea, her daughter.</i>\"");
	
	outputText("\n\n\"<i>That's... well, it does explain the people in the trees.  Why are they all nude, though?</i>\"");
	
	outputText("\n\nHolli glances down at his erect penis, now drooling a small spot of precum through his pants, and raises a smooth green eyebrow.  \"<i>Do tailors often make clothes to order for the trees in your village?</i>\"  The young man blushes again, and lowers his hand in front of his cock to block the dryad's gaze.  \"<i>Set your questions aside,</i>\" she continues.  \"<i>I offer you equipment and provisions for your journey, as a gift from my mother.  No payment is required, though if you wish to express your gratitude, we can certainly accept it.</i>\"  She glances pointedly at his concealed groin again, then approaches the two largest trees in the glade.");
	
	outputText("\n\nThe left tree lacks the nude resident of its fellows, though it appears older and thicker than any of the others, while the branches of the right one are bent low with juicy-looking fruit.  The figure in the right tree is contorted into a lewd pose, its ");
	//[(if tits)
	if (player.biggestTitSize() > 1) outputText("[chest] cupped by vines and held out toward the young man, ");
	else outputText("chest crisscrossed with a mesh of fine vines, ");
	outputText("its legs elevated and spread apart to display a ");
	if (player.balls > 0 && player.ballSize > 10 && player.gender == 3) outputText(player.multiCockDescriptLight() + " with [balls] swinging below.");
	//(if H and ballsize < 10)
	else if (player.balls > 0 && player.ballSize <= 10 && player.gender == 3) outputText(player.multiCockDescriptLight() + " and [balls] that hang slightly over a [vagina].");
	//(if H and noballs)
	else if (player.gender == 3) outputText(player.multiCockDescriptLight() + " and a [vagina].");
	else outputText("a wet, drooling cunt that practically begs to be filled.");
	outputText("  Though its eyes are covered, the figure's mouth works constantly, biting and licking its lips as if beset by otherworldly amounts of lust.  Holli beckons the youth toward this tree.");

	outputText("\n\nAs he approaches, the dryad reaches up to the canopy and pulls down a fruit-bearing branch; it snaps smoothly and the nude figure shudders, sending a tremor through the ");
	if (player.biggestTitSize() >= 1) outputText("[chest]");
	else outputText("vines");
	outputText(".  Plucking the fruit from its stem, Holli throws it to the young man.  \"<i>Eat that,</i>\" she commands.  As he looks over the fruit suspiciously and bites into it, the dryad places the broken end of the branch between her thighs and begins to draw it through, producing a smooth, straight staff glistening with her secretions.  Cock throbbing against his pants, the youth watches her show and chews distractedly as the twigs and leaves shift into a cluster that sticks out behind Holli's heart-shaped ass.  Withdrawing the new staff, Holli passes it to him, smiling knowingly as he touches her pussy-wettened hand and his cock spurts another glob of precum through its fabric prison.");
	
	outputText("\n\n\"<i>If you find yourself hungry or thirsty, place the leafy end on the nearest plant to cause it to fruit or give up its nectar.  It is imbued with the energy of my mother, the goddess.  It should be quite resilient and able to serve as a weapon until you find something better.  You may also take as much fruit as you can carry.</i>\"");
	
	outputText("\n\nThe young man handles the staff reverently.  \"<i>I don't... I don't know how to thank you for all this.</i>\"");
	
	outputText("\n\n\"<i>I told you before, did I not?</i>\" Holli retorts.  \"<i>We already know how you may thank us.  Share with us your vitality and help our kind to flourish.</i>\"  With a coy smile, the dryad reaches over to her lewd companion, ");
	if (player.ballSize > 10 && player.balls > 0) outputText("lifting the hefty testicles to reveal a wet, eager pussy.");
	else outputText("spreading the labia and exposing the eager, clenching hole inside.");
	
	outputText("\n\n\"<i>O-oh man, seriously?</i>\" the young man moans.  \"<i>I mean... I gratefully extend my thanks.</i>\"  Nearly ripping off his clothing in a comical, awkward dance, he exposes his lean frame and rock-hard, dripping cock.  He steps up to the tree and lines up with the dripping hole, then leans in, pushing his cockhead past the entrance with a small 'ssllp' noise.  The silent, blind figure opens her mouth in surprise, then closes it in a shy smile as her branches bend lower around her lover in imitation of an embrace.");
	
	outputText("\n\n\"<i>She likes you,</i>\" Holli says quietly, from behind the young man.  \"<i>Feel free to play with her body, if you wish.  It will please her.</i>\"");
	
	outputText("\n\nThe budding romantic, already thrusting eagerly, ");
	if (player.biggestTitSize() >= 1) {
		outputText("reaches up and grabs two handfuls of breast, passing his thumb over a nipple and watching the ");
		if (player.gender == 2) outputText("woman");
		else outputText("hermaphrodite");
		outputText("'s mouth open and close in bliss.  ");
	}
	else outputText("leans down and kisses the [woman/hermaphrodite]'s smooth chest, causing her to arch her back in pleasure.  ");
	if (player.hasCock()) outputText("With a nervous glance downward, he slides one hand to her [cock smallest].  \"<i>It's not gay if it's a chick's,</i>\" he mumbles to himself, and then begins to stroke haltingly, playing his finger along the urethra and drawing a squirt of precum from his shivering partner.  ");
	else {
		outputText("His hand slides to the [clit] above her wet fuck-hole; collecting some of the frothing lube from their wet sex, ");
		if (player.clitLength < 6) outputText("he smears it over the little button and then begins to trace up and down the underside with a finger.  ");
		else outputText("he coats the swollen organ with it and begins to jerk it off valiantly, like a cock.  ");
		outputText("\"<i>Does that feel good?</i>\" he asks, upping the pace of his thrusts.  ");
	}
	outputText("As if in reply, the ");
	if (player.gender == 2) outputText("woman");
	else outputText("hermaphrodite");
	outputText(" in the tree arches her back and her [vagina] clamps down on his tool");
	if (player.hasCock()) {
		outputText("; ");
		if (player.balls > 0) outputText("her balls draw closer to her body and ");
		outputText("her trembling dick");
		if (player.cockTotal() == 1) outputText(" throbs");
		else outputText("s throb");
		outputText(" as she nears climax");
	}
	outputText(".");

	//[(cock)]
	if (player.hasCock()) {
		outputText("\n\nThe youth's eyes widen briefly as he realizes what's coming, and he squeezes them shut against the expected load.  When none comes, he peeks at his lover again; several vines have reached down from her canopy and angled her cock");
		if (player.cockTotal() > 1) outputText("s");
		outputText(" toward her face; ");
		if (player.biggestCockArea() < 20) {
			outputText("semen spurts and dribbles down her [chest], pooling in the combined laps and mingling with the sticky lube ringing her vagina.  ");
			if (player.cumQ() >= 500) outputText("So much so that by the time she finishes her climax, both her partner's legs and her trunk are covered in a sheen of milky white seed.  ");
		}
		else if (player.biggestCockArea() < 80) {
			outputText("her mouth is now full of cockhead, and she gulps as eagerly as she spurts, drooling lines of white from the corners of her lips.  ");
			//[(big skeet)]
			if (player.cumQ() >= 500) outputText("The waves of seed don't stop coming, pouring into her and swelling her belly out until its round bulge pushes the cock away from her mouth and the remaining squirts fall on her [chest].  ");
		}
		//else cock biggest > 80)
		else {
			outputText("her body is easily dwarfed by her male sex's massive size, and globs of sperm shoot into her canopy to splatter among her leaves and branches.  ");
			if (player.cumQ() >= 1000) outputText("The overproductive hermaphrodite's body pushes out so much seed that the entire canopy soon turns white and drips constantly as though it were in a tropical rainforest.  ");
		}
	}
	//(vagina and no cock)
	else {
		outputText("\n\nA ");
		if (player.wetness() < 3) outputText("gush");
		else if (player.wetness() < 4) outputText("rush");
		else outputText("torrent");
		outputText(" of female orgasm pours from her pussy, and her mouth opens wide in pleasure.  The tree branches surrounding the young man seem to close in, pushing him toward her.  Getting the message, he leans in and kisses his lover; her tongue probes his mouth with abandon as her body shakes out its fit and her [vagina] wrings his prick.  ");
	}
	outputText("Pushed past his limit by her lewd display, the young man groans, shudders, and begins to unload his pent-up cargo.  Falling on top of his partner's slick ");
	if (player.cockTotal() == 1) outputText("cock");
	else if (player.cockTotal() > 1) outputText("cocks");
	else outputText("chest");
	outputText(", he goes limp and slack-jawed as his dick squirts, filling her vagina.");
	
	outputText("\n\n\"<i>Ah... ah, sorry!</i>\" he says, coming back to his senses and withdrawing his dick with a wet sound.  \"<i>I forgot to pull out!</i>\"");
	
	outputText("\n\n\"<i>Don't worry about it,</i>\" Holli replies, passing her hand over the silent ");
	if (player.gender == 2) outputText("woman");
	else outputText("hermaphrodite");
	outputText("'s stomach.  \"<i>In fact, she seems to have enjoyed it so much that she would have me bestow a blessing on you.</i>\"");
	
	outputText("\n\nKneeling before the young man, Holli takes his wet, half-limp cock in one hand and quickly slurps it into her mouth, right to the base.  He moans, and the dryad smiles as her tongue narrows, threading down his urethra, and then bulges to deposit something.");
	
	outputText("\n\n\"<i>Ow,</i>\" he says, as she pulls away.  \"<i>What was that?</i>\"");
	
	outputText("\n\n\"<i>A seed of my mother's power.  Many creatures in this land will try to overcome you by attacking your lusts, and this seed will absorb your excess ardor and keep you safe.</i>\"");
	
	outputText("\n\n\"<i>Oh, wow!</i>\" the young man exclaims, gathering his clothes, staff, and some clean fruit.  \"<i>You guys are amazing... thank you so much for everything.  When I beat the demons, I will be sure to come back here again!</i>\"  With a wave, he sets off through the trees.");
	
	outputText("\n\nHolli watches him until he's out of sight.  \"<i>When something seems too good to be true... it probably is.  Stupid imbecile.</i>\"  She turns to the figure in the tree, who is frowning deeply.  \"<i>Oh my... I was just lying before, but <b>do</b> you actually like him?  Well, you'll meet him again - when he sprouts and joins with Marae's roots.  In the meanwhile, I'm eager to see what the child of a pure human man and a once-human dryad like you will be.  I wonder if its tree will be more interesting than those of the imp- and beast-spawns you've given birth to already?</i>\"");
	
	//--Oh shit, it's already... [Game Over]--
	getGame().gameOver();
}

private function holliAndGenderlessSittingInATree():void {
	clearOutput();
	outputText("The tall, fit traveler steps through the portal, and its swirling colors dissolve to empty air behind him.  The blasted red landscape that welcomes him does so grudgingly, filling his face with a cloud of blown dust that sets him to coughing and sputtering.  Peering through a teary squint, the man looks around for a place that might provide some shelter from the wind and allow him to get his bearings, and a pair of scraggly trees nearby would seem to fill the bill.");
	
	outputText("\n\nAs he draws closer, though, it becomes evident that he's not the only one with the idea: two figures are already leaning on the trees.  Both nude, one is a gorgeous woman, albeit green-skinned and with horns, while the other appears to be ");
	if (player.skinType != SKIN_TYPE_FUR && player.skinType != SKIN_TYPE_SCALES) outputText(player.skinTone + "-colored");
	else outputText("covered in " + player.skinFurScales());
	outputText(" and wrapping its body around the tree in a way that makes determining its sex impossible.  No... it's not wrapping around the tree, but embedded in it up to the hips!");
	
	outputText("\n\n\"<i>Ho, stranger!</i>\" the green-skinned woman calls out.  \"<i>Come under our trees and shelter from this awful dust storm for a bit!</i>\"");
	
	outputText("\n\nThe traveler nods warily and steps under the broad canopy.  \"<i>Who are you two?  What's with Stumpy here?</i>\"");
	
	outputText("\n\nThe green woman laughs.  \"<i>We are dryads, put here by Marae, goddess of the land.</i>\"  As if to reinforce her words, the branches in the canopy bend down, blocking out the dirty red wind.  \"<i>I am Hollicynthea, her first daughter.  I have matured enough to leave my tree and walk about... and 'Stumpy' has not.  And yourself?</i>\"");
	
	outputText("\n\nThe stranger thinks for a moment, then replies.  \"<i>Got lost in the jungle and found by villagers from somewhere called Ingnam.  Had no skills except wilderness survival and nobody at home to go back to, so I agreed to become their 'Champion' and go through the portal.</i>\"");
	
	outputText("\n\n\"<i>Ah, is that so?  We have been waiting for you.  My mother bade us provide the new Champion with supplies and her blessing.  As you can see, it's been a bit of a dry period; we have no fruit to give.  But if you'll allow me...</i>\"  Holli reaches up to the canopy overhead, pulling down one of the branches from her companion's tree.  It snaps off with a splintering crack, and the mute figure shivers as the stranger winces.  The dryad draws the branch through her hand, causing bark and wood to shift and straighten, evening out.  The twigs and leaves gather into a cluster at the end, and Holli jams the finished stick into a crack in the red ground.  \"<i>Take that with you when you go.  It has my mother's magic in it, and you may tap its end to a plant and cause it to fruit or give up nectar.</i>\"");
	
	outputText("\n\n\"<i>And the blessing?</i>\" asks the stranger.");
	
	outputText("\n\n\"<i>Mmm...</i>\"  Holli lowers her eyes and smiles shyly.  \"<i>That's yours as well if you want it, but the giving is a bit more personal.  Would you... lie with me?  Here, in the shade of my tree?  Your shared vitality and energy will also help us to recover from the drought.</i>\"");
	
	outputText("\n\nThe stranger nods slowly.  \"<i>What about your buddy?</i>\"");
	
	outputText("\n\nHolli begins undressing her prospective lover.  \"<i>[name] is a bit of a weird one.  It has no sex we could use.  Customarily, we can choose whether we want to manifest as male, female, or both... [name] chose to be neither, and turned its back on the whole affair of sexual interplay - symbolically and literally.</i>\"");
	
	outputText("\n\n\"<i>How principled,</i>\" the traveler mumbles, shedding the last of his clothing.  \"<i>It must get bored often.</i>\"");
	
	outputText("\n\n\"<i>Indeed it does,</i>\" Holli agrees.  \"<i>But when you make a choice, you accept the consequences.  Is that not so?</i>\"  The dryad pulls the traveler onto her body, then begins to moan as he caresses her breasts and enters her; the eyes of her mute sentinel follow the lovers to the ground and ");
	if (player.skinType ==SKIN_TYPE_SCALES ) outputText("a quiver of arousal shakes its scales");
	else if (player.skinType == SKIN_TYPE_FUR) outputText("its fur begins to prick up with arousal");
	else outputText("a blush of lust colors its " + player.skinFurScales());
	outputText("...");
	
	//--Dante's Purgatorio is an epic poem about [Game Over]--
	getGame().gameOver();
}

public function amilyComesBack():void {
	clearOutput();
	outputText("Amily arrives with her belongings over her shoulder and a smile on her face.  \"<i>I knew you'd do the right thing, [name].  I'll get my nest set back up.</i>\"\n\n(<b>Amily has moved back in!  She can be found in the lovers tab.</b>)");
	//flags[kFLAGS.AMILY_TREE_FLIPOUT] = 1;
	flags[kFLAGS.AMILY_FOLLOWER] = 1;
	//Enable village encounters
	flags[kFLAGS.AMILY_VILLAGE_ENCOUNTERS_DISABLED] = 1;
	doNext(playerMenu);
}
}
}
