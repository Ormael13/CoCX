/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.UniqueSexScenes;
	
	public class HolliPureScene extends NPCAwareContent
	{
	
	public var uniquuuesexscene:UniqueSexScenes = new UniqueSexScenes();
	
	public function HolliPureScene() 
	{	
	}

//VARS
//const TIMES_FUCKED_FLOWER:int = 594; liczenie ilości używania soulforce infused blood
//const TIMES_RIDDEN_FLOWER:int = 595; liczenie ilości podlewań wodą
//const FLOWER_LEVEL:int = 2348;
//const FUCK_FLOWER_GROWTH_COUNTER:int = 597;
//const FUCK_FLOWER_KILLED:int = 598;
//const HOLLI_FRUIT:int = 600;
//const HOLLI_FRUIT_EXPLAINED:int = 601;
//const HOLLI_DEFENSE_ON:int = 602;

public function treeMenu():void {
	clearOutput();
	if (flags[kFLAGS.FLOWER_LEVEL] == 1) {
		outputText("The sprout looks about the same as when you first noticed it.  It's a simple, leafy shoot that only goes to about knee height.  It looks healthy and strong, with a few dozen branches and shiny green leaves.  You could easily destroy it.");
		menu();
		addButton(0, "Burn It", destroyDatTree);
		if (player.fatigue + 50 < player.maxFatigue()) addButton(1, "Water It", waterIt);
		addButton(14, "Back", inventory.inventoryMenu);
	}
	else if (flags[kFLAGS.FLOWER_LEVEL] == 2) {
		outputText("Before you is a large, waist-high plant of questionable origin.  A huge, violet bloom sits atop a strong, central stalk, and the obscene flower looks positively female in every sense, right down to a clit-shaped bump and moist, gently parted lips.  Inside that central passage, you can see a bevy of wiggling staman surrounding a larger, flared stalk.  The scent that wafts out of that opening is sweet and floral, but undoubtedly sexual.  It looks like an organic sex toy and it may be corrupted.  It wouldn't be hard to get rid of right now, assuming you don't let it grow larger.");
		menu();
		addButton(0, "Destroy It", destroyDatFuckingPlantAtP2);
		if (player.fatigue + 50 < player.maxFatigue()) addButton(1, "Water It", waterIt);
		if (player.HP > 150 && player.soulforce>= 50 && player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(2, "Use SFIB", useSouforceInfusedBlood);
		addButton(14, "Back", inventory.inventoryMenu);
	}
	else if (flags[kFLAGS.FLOWER_LEVEL] == 3) {
		outputText("The familiar plant has blossomed into a nicely sized tree, though you doubt it has finished growing just yet.  It sports an outstretched canopy with nice, green leaves.  The vaginal flower is still there and is in full bloom, now several feet across and practically dripping with moisture.  Just up the trunk, there's a pair of small, roughly b-cup breasts bulging out of the bark.  They're exquisitely smooth and soft, and they ooze sweet-smelling sap that your tongue would love to taste.  In the canopy above, tentacle vines idly writhe about, though they show no sizes of aggression.");
		if(player.findPerk(PerkLib.DragonFireBreath) >= 0 || player.findPerk(PerkLib.FireLord) >= 0 || player.findPerk(PerkLib.Hellfire) >= 0 || player.hasStatusEffect(StatusEffects.KnowsWhitefire)) {
			outputText("\n\nIt could be burned down with your supernatural fire, but it would definitely tire you.");
		}
		menu();
		addButton(0, "Torch It", torchP3Tree);
		if (player.fatigue + 50 < player.maxFatigue()) addButton(1, "Water It", waterIt);
		if (player.HP > 150 && player.soulforce>= 50 && player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(2, "Use SFIB", useSouforceInfusedBlood);
		addButton(3, "Drink Sap", drinkThePlantGirlsSap);
		addButton(14, "Back", inventory.inventoryMenu);
	}
	else if (flags[kFLAGS.FLOWER_LEVEL] == 4) {
		outputText("Walking over to the edge of your camp, you approach the familiar tree.  It looks innocent enough from a distance, but this image is strained a little but by the tentacles cleverly camouflaged in the foliage!  Once you get closer, the bark splits like a pair of silken curtains, and a female form exposes itself from inside the interior.  Heavy, dripping tits and a fully-unfolded female flower dominate her form, but you drag your eyes up to her own, staring into Holli's golden-brown pupils and black sclera as you greet her.");
		outputText("\n\n\"<i>Welcome back, [name].  ");
		if(rand(2) == 0) outputText("Did you come for a drink?  I've built up lots of nectar for you.  Surely, a sip would be refreshing for you...");
		else outputText("How may I help you?  Tell me your wish so that I can try fulfill it.");
		outputText("</i>\"");
		//Extra line on description:  
		if(flags[kFLAGS.HOLLI_FRUIT] > 0) {
			if(flags[kFLAGS.HOLLI_FRUIT] == 1) outputText("\n\nA large, purple fruit hangs from Holli's branches, twisting softly in the breeze.  It looks succulent and ripe.");
			else outputText("\n\n" + Num2Text(flags[kFLAGS.HOLLI_FRUIT]) + " large, purple fruits hang from Holli's branches, twisting softly in the breeze.  They look succulent and ripe.");
			//Optional Addition: 
			if(flags[kFLAGS.HOLLI_FRUIT_EXPLAINED] > 0) outputText("  A very small, strange part of you actually feels proud to have made something like that with the tree-woman.");
		}
		menu();
		if(player.hasCock() && player.lust >= 33) addButton(0, "Fuck Holli", holliGetsDickDommed);
		if(player.tentacleCocks() >= 10 && player.lust >= 33) addButton(1, "TentacleBone", fullOnTentacleTasticGangBangForHolli);
	//	if(player.stamenCocks() >= 10) && player.lust >= 33) addButton(1, "StamenBone", fullOnTentacleTasticGangBangForHolli);
		if (player.hasVagina() && player.lust >= 33) addButton(2, "Ride Holli", vaginalDomHollisTentacruels);
		addButton(3, "TentacleDuel", uniquuuesexscene.alrauneExtraSceneWithHollicyntiaTentacleDuel);
		addButton(5, "Drink Sap", haveAMapleSyrupSnack);
		if (flags[kFLAGS.HOLLI_FRUIT] > 0) addButton(6, "Eat A Fruit", eatHolliFruit);
		else addButtonDisabled(6,"Eat A Fruit");
		if (flags[kFLAGS.DAILY_MARA_FRUIT_COUNTER] < 1) addButton(7, "Mara Fruit", getMaraFruit);
		else addButtonDisabled(7, "Mara Fruit");
		addButton(8, "Guarding", askHolliToGuard);
		addButton(14, "Leave", camp.campFollowers);
	}
}

private function getMaraFruit():void
{
	clearOutput();
	outputText("You ask plant goddess for another Mara Fruit.");
	flags[kFLAGS.DAILY_MARA_FRUIT_COUNTER] = 1;
	inventory.takeItem(consumables.MARAFRU, treeMenu);
}

public function getASprout():void {
	clearOutput();
	outputText("Around the edge of your camp, you spot some plant-life beginning to sprout.  The barren, wasteland crust is fractured and broken, giving up a leafy green shoot.  It only reaches up to your knee, but the plant looks healthy and young.  Perhaps it will grow larger?  There is a central stem that supports most of the weight, but a dozen branches fork off, supporting a bevy of shiny green leaves.");
	outputText("\n\nYou briefly wonder how something could take root in such soil and be so successful, but then you recall goddess, Marae.  She mentioned something about having roots through this world, didn't she?");
	outputText("  But what if it's not her doing and another demons deception to gain a foothold in your camp?\n\n<b>Do you destroy it?</b>");
	flags[kFLAGS.FLOWER_LEVEL] = 1;
	flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] = 0;
	menu();
	addButton(0, "Yes", destroyDatTree);
	addButton(1, "No", letZeSproutLive);
}
private function destroyDatTree():void {
	clearOutput();
	outputText("You reach down and begin to excavate meticulously around the sapling.  It has one central root that seems to go down forever, but after you've uncovered half a foot of taproot, you grab hold of it and yank.  At first, your straining seems unnoticed by the plant, the leaves rustling as it shakes and strains under your grip.  Then, all at once, it gives with a violent SNAP.  You tumble end over end, clutching to the suspicious-flora tightly to your [chest].  Sighing and grumbling, you get up and toss the leafy plant into your fire.");
	outputText("\n\nSparks and smoke issue; the fire burns purple and low as it struggles to consume the resilient plant.  Fading slowly, the wilting flames look as though they're about to go out; you scramble to add fuel to the guttering fire before it dies entirely.  Each chunk of dry wood that you add seems to help, and soon the rosy red of all-consuming heat has returned.  The plant's stem withers away into charred, black ash.");
	outputText("\n\nYou have a hopeful feeling that you won't see any more of those plants cropping up.");
	//(+5 corruption)
	dynStats("cor", 5);
	flags[kFLAGS.FUCK_FLOWER_KILLED] = 1;
	doNext(camp.returnToCampUseOneHour);
}
private function letZeSproutLive():void {
	clearOutput();
	outputText("Looking down at the sapling, you stay your wrath.  It may be corrupt, but it hasn't done anything to harm you just yet.  You give it a little pat on the uppermost leaves and leave it be.  It's not like it's going anywhere.");
	outputText("\n\n(<b>'Plant' added to your items menu</b>.  It's too small to know what it will grow into yet.  You can currently remove it at your leisure.)");
	doNext(playerMenu);
}

public function plantGrowsToLevel2():void {
	clearOutput();
	flags[kFLAGS.FLOWER_LEVEL] = 2;
	flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] = 0;
	outputText("The sound of creaking, snapping vines draws your attention to the corner of your camp, where the small plant had grown.  You rush in that direction without delay, raising your [weapon] in case you need to fight.  The violent noises die away before you can round the last large stone in the intervening distance, leaving you to wonder just what transpired.  Well, you don't have to wait long - you come around the obstruction at top speed, skidding to a stop at the view before you.");
	outputText("\n\nWhere once there was a small, tree-like sapling, there is now a waist-high flower of exotic colors and proportions.  The central stalk is much thicker than it was before, and though the familiar leaves are still there (in greater number), the obscene flower topping the plant is what really draws your eyes.  Vibrant purple petals spread over a two foot diameter, turning iridescent as they curve into a large, central bulb.  Inside that cavity, there're dozens of stamen surrounding a central style that's flared roundly and mottled; the plant-organs are moving about unlike any you've ever seen before.  They look... sexual.");
	outputText("\n\nYour skin flushes as you react to the view.");
	if(player.gender == 0) outputText("  Sucks to be it!  You don't waste time with stupid shit.");
	outputText("  Is this really Marae's gift?");
	if(player.gender > 0) outputText("  Well, you could make use of this build up arousal on someone... just being around it seems to slowly turn you on.");
	outputText("  Of course, destroying it would be the safest option.");
	dynStats("lus", 33, "scale", false);
	if(silly()) outputText("\n\n<b>What do?</b>");
	else outputText("\n\n<b>What do you do?</b>");
	menu();
	addButton(0, "Destroy It", destroyDatFuckingPlantAtP2);
	addButton(1, "Do Nothing", playerMenu);
}
private function waterIt():void {
	clearOutput();
	outputText("For a moment you think what to do with this ");
	if (flags[kFLAGS.FLOWER_LEVEL] == 3) outputText("tree");
	else outputText("plant");
	outputText(". Maybe bring some water from near the stream to water it? Or is this realm causing them to not need it? After a moment of hesitation, you go to the stream looking for some way to bring water. A few runs later you finished watering it and feeling tired, spend some time resting.");
	fatigue(50);
	if(flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] < 1000) flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER]++;
	flags[kFLAGS.TIMES_RIDDEN_FLOWER]++;
	doNext(camp.returnToCampUseOneHour);
}
private function useSouforceInfusedBlood():void {
	clearOutput();
	outputText("For a moment you think what to do with this ");
	if (flags[kFLAGS.FLOWER_LEVEL] == 3) outputText("tree");
	else outputText("plant");
	outputText(". Bringing water is fine but it seems the plant is growing too slowly. What else could make it grow faster? While thinking you casually remember about something you started to develop: Soulforce. After visiting the river village you’ve seen that it can even enhance natural healing. So maybe if you could use it now it could provide better nourishment for this ");
	if (flags[kFLAGS.FLOWER_LEVEL] == 3) outputText("tree");
	else outputText("plant");
	outputText(" than mere water. For a moment you ponder if it is actually a good idea to spray it with your own blood. Probably that it would also give it some of your Soulforce. Preparing mentally to do that as you focus on infusing a tiny bit of your soulforce into your blood, you cut your hand and drip a little bit of your blood at the ");
	if (flags[kFLAGS.FLOWER_LEVEL] == 3) outputText("tree");
	else outputText("plant");
	outputText(". It seems to greedily absorb the liquid for a moment, turning slightly crimson in the place where blood made contact with it, while you go to patch your hand. Better hope the blood scent doesn’t attract something to the camp.");
	player.HP -= 150;
	player.soulforce -= 50;
	if(flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] < 1000) flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] += 4;
	flags[kFLAGS.TIMES_FUCKED_FLOWER]++;
	doNext(camp.returnToCampUseOneHour);
}
private function destroyDatFuckingPlantAtP2():void {
	clearOutput();
	outputText("You know that letting this thing continue to grow would only threaten the safety of your camp.  Sighing, you trudge over to your supplies, gathering up some dry wood to stack around the invading foilage.  The plant, as if knowing what you're about to do, begins to wiggle from side to side, petals quivering in a panic.  However, your course is set, and this plant must die.  You take a burning log from your fire and torch the pile, feeling a little better about yourself as the blaze slowly consumes the wilting plant.");
	outputText("\n\nThe fire flutters, smoky purple sparks shooting into the air, blotting out the sky.  You cough and step back from the conflagration, waiting until it burns itself out and nothing but ash remains.  You have a hunch you won't be seeing any more of those plants... hopefully.");
	//(+5 corruption)
	dynStats("cor", 5);
	flags[kFLAGS.FUCK_FLOWER_KILLED] = 1;
	doNext(camp.returnToCampUseOneHour);
}

public function flowerGrowsToP3():void {
	clearOutput();
	outputText("Again, you hear odd noises coming from a corner of your camp - the corner where you let that shrubbery grow.");
	if(flags[kFLAGS.TIMES_FUCKED_FLOWER] + flags[kFLAGS.TIMES_RIDDEN_FLOWER] > 0) outputText("  The gardening and using souldforce infused blood probably only helped it to grow faster.");
	outputText("  The distinct sound of wood bowing and creaking under new weight catches your ears, and well before you can get to the plant, you can see a leafy canopy stretching towards the sky.  <b>It's grown into a small tree, with bark, leaves, and everything!</b>  Warily, you round one of the ancient standing stones to get a better look.");
	outputText("\n\nThe first thing you notice is that the weird flower remains, affixed at waist height to the side of the tree.  Glancing further up the smooth, knotless trunk, you see the most surprising thing of all - a pair of almond-colored nipples, perched upon small, tit-like bulges in the wood.  The bark on these globular protrusion is smoother and fairer than the surrounding surface.  On one of them, a trickle of sap has formed into a heavy bead, and it smells sweet, like maple syrup");
	outputText("\n\nA dollop of something moist landing in your hair startles you from your visual inspection.  Gingerly, you touch your fingers to the wet spot and come away with a thick, viscous fluid that smells faintly musky... and salty...  It's cum!  You recoil, looking up in time to see a half dozen tentacles curling between the branches rubbing against each other.  Well now, your little pet plant is growing up.  There's no easy way to get rid of it now");
	if(player.findPerk(PerkLib.DragonFireBreath) >= 0 || player.findPerk(PerkLib.FireLord) >= 0 || player.findPerk(PerkLib.Hellfire) >= 0 || player.hasStatusEffect(StatusEffects.KnowsWhitefire)) {
		outputText(", though you suppose you could burn it down with magical fire if you set your mind to it");
	}
	flags[kFLAGS.FLOWER_LEVEL] = 3;
	flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] = 0;
	outputText(".\n\n<b>What do you do?</b>");
	menu();
	if(player.findPerk(PerkLib.DragonFireBreath) >= 0 || player.findPerk(PerkLib.FireLord) >= 0 || player.findPerk(PerkLib.Hellfire) >= 0 || player.hasStatusEffect(StatusEffects.KnowsWhitefire)) addButton(0, "Torch It", torchP3Tree);
	addButton(1, "Leave It", playerMenu);
}
private function drinkThePlantGirlsSap():void {
	clearOutput();
	//Regain 50 fatigue and gain 15 lust, .5 libido, 1 sensitivity and loose 1 corruption.
	dynStats("lib", .5, "sen", 1, "lus", 15, "cor", -1);
	fatigue(-50);
	outputText("Feeling like you could use a pick-me-up, you prance up to the tree-boobs and give them an appraising look.  The're pert and rounded, smooth despite the roughness of the bark around them.  When you touch one, it feels warm, soft, and exquisitely tender, just like a breast should.  A small droplet beads on the tree-tit and drips on the ground while you man-handle it, smelling strongly of maple syrup.  Chuckling at that, you run your finger around the almond-colored protrusion and gather up a touch of the fluid.  The digit tastes sweet in a comforting, familiar way, and when you remove your sticky finger from your lips, you look back with undisguised hunger.");
	outputText("\n\nThe tree's nipples look larger and harder after your inspection, and when you take one into your mouth, it immediately releases a trickle of its amber syrup onto your hungry tongue.  A shiver runs down your spine from the sweet taste, a rush of sugary delight invigorating your body as you drink.  Unfortunately, the tree's tit soon empties of its delicious treat, and you have to slide around to the other.  You wrap your arms around the trunk for stability as you suck");
	if(silly()) outputText(", tree hugger that you are");
	outputText(".  The thick 'milk' quickly fills your body with energy, though it runs out nearly as soon as it started.");
	player.refillHunger(10);
	outputText("\n\nYou wipe your slightly sticky mouth on your arm and sigh with the act done, admiring the slightly rosy tinge of the now-smaller breasts.  This whole thing is weird as hell, but you're as full of energy as ever after the snack.");
	doNext(camp.returnToCampUseOneHour);
}
private function torchP3Tree():void {
	clearOutput();
	//Requires fire-based attack and removes the tree.
	outputText("This has gone on long enough!  This thing cannot continue to grow in your camp any longer, and you have just the means to remove it: fire.  ");
	//[(nerdfire)
	if(player.hasStatusEffect(StatusEffects.KnowsWhitefire)) outputText("Closing your eyes to focus, you gather your energies, and unleash your white, supernatural flames upon the thing.");
	//(bromancefire)
	else if(player.findPerk(PerkLib.FireLord) >= 0) outputText("Sucking in your breath, you inflate your chest and stir the embers of the jaguar demon's gift.  Dredging up an enormous pine-green fireball, you exhale and launch it at the tree.");
	else outputText("Sucking in your breath, you inflate your chest and stir the embers of your fiery gift.  Dredging up an enormous fireball, you exhale and launch it at the tree.");
	outputText("  It goes up by the torch, though the fire starts to fade sooner than you would expect.  You huff, but repeat the action, layering a new blaze atop the previous one; you put all your concentration into this new conflagration, stoking the inferno with every ounce of your ");
	if(player.hasStatusEffect(StatusEffects.KnowsWhitefire)) outputText("magical will");
	else outputText("breath");
	outputText(".");
	outputText("\n\nThis time, it stays suitably lit.  The tree makes a handy torch for a few hours while it burns to ash, but leaves behind a thick, cloying smoke that takes forever to dissipate.  At least that nuisance plant is gone for good.");
	fatigue(100);
	flags[kFLAGS.FUCK_FLOWER_KILLED] = 1;
	doNext(camp.returnToCampUseTwoHours);
}

public function treePhaseFourGo():void {
	clearOutput();
	outputText("An unfamiliar female voice calls out your name, high-pitched and lilting.  Unflinchingly, you respond to the call, winding your way through your camp towards the fringe, where the tree was growing.  Did a faerie get caught in it? A tiny creature like that would probably shouldn't have trouble to free herself.  Still, you redouble your pace and ready your [weapon].  You know well enough that a fair voice doesn't always match up to a fair demeanor - in Ingnam OR Mareth.");
	outputText("\n\n\"<i>Oh, [name]!  Where are yoooouuu?</i>\" the voice croons.  You turn the bend to a sight both familiar and haunting.  There, in the middle of a wide, ancient-looking tree trunk, is a woman.  She's emerged from a split in the center of the wood, and she appears to be made of flesh, blood, and bone the same as anyone else.  However, she's got some traces of corruption.  It is most visible in her brown-gold eyes, tainting the sclera a solid black.  Above, a pair of gnarled oak horns sprout from her forehead, parting the woman's generous, dark green curls.  Her skin is a pale jade and as smooth as buttered glass, and her lips are full and pouty, curved in a knowing smile.");
	outputText("\n\n\"<i>Hello there, cutie,</i>\" the verdant plant-woman trills, crossing her arms across her weighty G-cup melons in feigned modesty, \"<i>");
	if(flags[kFLAGS.TIMES_FUCKED_FLOWER] + flags[kFLAGS.TIMES_RIDDEN_FLOWER] > 0) outputText("Did you enjoy watering me?");
	else outputText("Did you enjoy watching me grow?");
	outputText("</i>\"");
	outputText("\n\nYou shake your head dumbly.  This girl could very well be like corrupt goddess's sister, a demon-twin born of lust and simmering desires if not fact you do saved Marae.  So why this one looks so... corrupted?");
	if(flags[kFLAGS.TIMES_FUCKED_FLOWER] + flags[kFLAGS.TIMES_RIDDEN_FLOWER] > 0) outputText("  \"<i>It was so much easier to grow with this nutrients");
	else outputText("  \"<i>You should have watered me.  It was so much harder to grow without proper nutrients");
	outputText(",</i>\" the dryad explains while lifting an arm to brush an errant curl from her view.  Her other arm studiously remains clapped across her glossy, almond-colored nipples, but you still manage a quick glance.  She giggles, her melons jiggling with her breathing as she promises, \"<i>Mother Marae created me to be your gift.  Your personal attendant.  My name is Hollicynthea, but you can call me Holli.  She also gave me most of her corruption at the moment of my seed creation so I'm looking and acting much alike some kind of corrupted creature.  She said it was unavoidable outcome of what she have done.  I hope you could live with this, right?</i>\"");
	outputText("\n\nYou snap your eyes back up to her oddly-colored gaze just in time for her to drop the other arm away.  Of course, when you try to glance back down, she has her hands over her nipples again.");
	outputText("\n\n\"<i>I can't leave my tree, not for a few years, so you'll have to keep me nice and... warm,</i>\" she coos.  Below, you realize the familiar flower remains, though it looks almost dainty compared to its former glory.  It's now nestled between the woman's thighs, just above where her body merges back into the wood-grain, and the petals are folded closed into a modest bud.");
	outputText("\n\nHolli offers, \"<i>If you ask nicely, I'll even help to guard you while you rest.  Lesser creatures are so easily snared and toyed with.</i>\"");
	outputText("\n\nWell... you have a plant-woman on your hands; a dryad by the legends of your homeland.  She looks harmless, so long as you don't stand too close, and she's quite the alluring sight.  What now?\n\n<b>Hollicynthea is now available in the followers tab!</b>");
	flags[kFLAGS.FLOWER_LEVEL] = 4;
	flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] = 0;
	dynStats("lus", 15);
	doNext(treeMenu);
}

private function holliGetsDickDommed():void {
	clearOutput();
	outputText("Tossing your [armor] aside, you expose your [cocks].  Holli's eyes fixate on [oneCock], her attention rapturously contained by a single phallus.  You grip your maleness in hand and bounce it up and down into your other palm.  The solid slaps of genital impacts echo off the surrounding rocks, each sending a pleasant tingle of pleasure through the root of your manhood.  Before long, you're completely erect and throbbingly hard, bouncing unbidden with each and every thrum of your heart.");
	outputText("\n\nHolli leans forward, entranced by the sight.  Her head and shoulders slip through the surprisingly pliant bark as she bends down to view the show.  Swaying beneath her, Holli's weighty tits dangle unrestrained and unbound.  Sappy moisture clings to her almond nipples like morning dew, dripping in small drops onto the wasted ground.  The tips of her teats have gone rigid, engorged with whatever strange substance passes for blood.  Similarly, the dryad's flower is in full bloom, with its vibrant petals spread open, welcomingly.  The constant lubricants make the slick lips glitter like diamonds in the light, until their owner's shadow eclipses the illumination.");
	outputText("\n\nHanging out of her tree, Holli reaches for [oneCock], but stops just short.  \"<i>Can I pleasure it, please?</i>\"  She's looking up at you hopefully, like a kid hoping for a treat.");
	outputText("\n\nSo long as she continues to be good, you don't mind letting her have a few licks.  You nod to the black-eyed beauty and rock forward, butting your [cockHead biggest] right into her soft lips.  Holli squeaks in surprise and grabs hold, firmly gripping your [cock biggest] in her capable fingers.  She makes to kiss it, but you pump yourself forward again.  The first few inches sink into her mouth before she can react.  This time, all she manages is a muffled groan, lips thoroughly snared with dick.  Her distraught vocalizations die down as she begins to accept her role, gently sliding your [cock biggest] down to take in as much as she can");
	if(player.biggestCockArea() > 80) outputText(", jaw stretching obscenely");
	outputText(".");
	outputText("\n\nYou congratulate her on her success in handling your dick and push on the back of her head with gentle but unforgiving pressure.  Pleasant body heat envelops your prick as it's gobbled down deep");
	if(player.biggestCockArea() <= 80) {
		outputText(", swallowed to the ");
		if(player.balls > 0) outputText("[balls]");
		else outputText("[sheath]");
		outputText(".");
	}
	else outputText(", swallowed as deep as Holli's distended neck can handle.");
	outputText("  Gurgling, the demonic dryad flutters her lengthy eyelashes and looks up at your eyes, twinkling with happiness at her servitude.  You wiggle your crotch around, and it twists your [cock biggest] around her mouth and throat.  The tainted tree's tongue massages the underside of your length, embracing you with subtle moisture and frictionless pressure.");
	outputText("\n\nBubbling sexual pleasure begins to build up inside you, making your ");
	if(player.balls > 0) outputText("[sack] feel taut and ready to burst");
	else outputText("body feel strung tight like an over-tuned guitar");
	outputText(".  Holli pulls back, inciting a snarl of displeasure to vibrate from you, but as soon as she's withdrawn, her hands clasp onto the slick shaft and begin to pump it with vigorous strokes.  Her mouth settles back into place around your [cockHead biggest], circling it with her tongue while she bobs up and down on it, snaring your most sensitive place with overwhelming sensations.");
	outputText("\n\nYou grab hold of the hungry cock-sucker by her neck and push her back, up into her tree, releasing your [cock biggest] before it can blow.  It's a close thing - you're rigid and bobbing, muscles clenching involuntary right on the edge.  Holli makes a choking protestation as she's forced into place but doesn't struggle, fearful of your wrath.  You let the hungry slut go, unharmed but chastised by the rough treatment.  Your cum is destined for her twat, not to be wasted in her slutty noise-hole.");
	
	outputText("\n\nStepping up, you ram your rigid phallus deep into the slick flower at Holli's waist.");
	if(player.biggestCockArea() > 80) outputText("  It bends slightly as the immense girth is forced inside her, aiming down, deep inside the trunk.");
	outputText("  Holli flops into your [chest], twitching weakly and breathing heavily.  \"<i>Fffuck, so good!</i>\" she pants, nuzzling her cheek into your collarbone while her hands play across your shoulders.  You ruthlessly mount her flowery mound with fast motions.  Juices squirt out around your member at the apex of every stroke, raining down over the surrounding ground.  You grab Holli's deep green hair and pull her back.  Her face is wrecked by bliss, her mouth and eyes moving in uncoordinated twitches.");
	outputText("\n\nYou kiss your planty pet forcefully, and she yields to your impressive dominance, putty in your hands.  Her body quavers against you, and then, she's moaning into your lips, forgetting the kiss as climax wracks her frail, human-like half.  Nectar drips down your [legs] in a steady drizzle, sweet, lubricating juices that fill the air with a flowery, feminine musk.  You pull away from her mouth's incessant utterances and watch her cum, held in your arms.  The pleasant caresses of the dryad's inner walls squeeze down with pliant pressure, rolling over your [cock biggest] in slow waves, hungrily sucking at you and ready for sperm.");
	outputText("\n\nThe abruptness of your orgasm startles you.  One moment there's the sanguine ecstasy of the surrounding fuck-flesh, and the next, there's an explosive volcano of lust boiling out of your [cocks], geysering fountains of fluid.");
	if(player.cockTotal() > 1) {
		outputText("  Excess jism spurts onto Holli's jiggling udders from below, spotting the viridian mounds with white.");
		if(player.cumQ() >= 500) outputText("  The constant sprays turn them white in little time, dripping from the peaks of her nipples along with her sticky sap.");
	}
	if(player.cumQ() > 1000) outputText("  A trickle of sperm washes out of the demoness's entrance, somehow escaping the heavy suction.");
	if(player.cumQ() > 2000) outputText("  A moment later, that trickle turns into a river.");
	if(player.cumQ() > 3000) outputText("  You swear that her trunk must be absolutely stuffed with spunk.");
	if(player.cumQ() > 5000) outputText("  A spooge-spout sprays out as the pressure goes through the roof, confirming your suspicions in the messiest way possible.");
	outputText("  Holli's tentacles cum with her, spraying her seed through her canopy in aimless ropes.  Most of it sticks to her branches and leaves, but small amounts of it trickle down to spatter the ground.  One of them lands on the back of your hand.  You frown and push it up against the tree-woman's mouth.  She licks you clean without question, still dazed from her orgasm.");
	outputText("\n\nRemoving yourself from the gaping flowerpot, you admire the fruits of your labors.  Holli breathily says, \"<i>Th-thank you, [name]...  So good...</i>\"");
	outputText("\n\nYou crook a finger and point down at the slop of sperm and nectar glazing your [cock biggest].  Getting the idea, she leans back out and opens wide.  You get a thorough cock polishing from the much meeker plant-woman.  She swallows it all and withdraws, offering, \"<i>If you ever want another round... my flower is yours.</i>\"");
	player.sexReward("vaginalFluids","Dick");
	dynStats("sen", -2, "cor", 1);
	fertilizeHolli();
	doNext(camp.returnToCampUseOneHour);
}
private function fullOnTentacleTasticGangBangForHolli():void {
	clearOutput();
	outputText("You remove your [armor] and expose your writhing mass of wriggling tendrils to the tree-tart.  She places a hand over her mouth and exhales, \"<i>Oh my, Mother Marae sure knows how to pick them, doesn't she?</i>\"");
	outputText("\n\nExercising considerable control over your vegetative peckers, you extend one forward, the phallic tentacle lurching out to silence the troublesome tree in a split-second.  Holli gives up a strangled, \"<i>h-urk!</i>\" and rocks back into her tree's entrances, eyes crossed to look at the green snake protruding from her lips.  Her mouth feels good around the purple-tinged cock-tip you've forced inside, but you think her throat would feel better.  Your tentacle tool stretches, lengthening with supernatural agility, and you push the fresh flesh down Holli's gullet, distending her throat with the imprint of your length.  Her esophagus instinctively works to swallow the obstruction, which serves you just fine.  The tight oral pleasure has you oozing droplets of pre-seed directly into her belly, but you're far from ready to blow.  After all, with nine more penises, satisfaction remains a good ways away.");
	outputText("\n\nHolli reaches up at the pioneering phallus.  You aren't sure if she's trying to pull it out or massage it, but her hands could be put to better use.  Snapping out, two tendrils lance forward, twining around the dryad's arms before she can bother the busy cock in her mouth.  They snugly entwine her limbs with warm cockflesh and pull taut.  No matter how she struggles, the oppressive penises hold her restrained.  You push the busy tentacles harder, forcing them to climb higher.  Their heads push into her fingers, then past, giving the plant-girl a firm hold on your sensitive tendrils.");
	outputText("\n\nLooking your way, the dryad cast a smoldering look at you and begins to massage all three of the busy cocks.  She strokes the ones in her hands eagerly.  The mouth-penetrating penis finds itself on the receiving end of rather skilled fellatio.  Holli's tongue dances along the underside with inhuman skill, touching every sensitive area of the shaft with supreme, whore-like skill.  You partially release her arms to allow her to better serve you, and she does not disappoint, her handjobs growing faster and more eager now that they can get at more of your members.");
	outputText("\n\nBy now, you've started to flush somewhat.  The three-way pleasure is significant, enough that the rest of your bundle of vegetative dicks are wildly waving");
	if(silly()) outputText(", inflatable-arm, flailing tube-cocks");
	outputText(".  Below the orgy of arboreal affection, Holli's slick petals have spread wide.  You can actually see her interior twitching voraciously.  It opens and closes with pulsing hunger, vibrantly engorged.  As you watch, the fourth of your members lances forward of its own volition, spearing straight for that welcoming hole with no guidance from you.  It hits like a missile.  Two feet of that cock is gone in a moment, swallowed deep in the cunt-flower's bottomless depths.  A gush of girl-cum spurts out around the intruding member, and you can feel the muffled moan vibrate through the mouth-bound cock as she gives in to the four-way fucking.");
	outputText("\n\nHolli's hands begin to glisten, glossed with your pre-sap.  The other six penises are all dripping as well, filled with unbridled lust long denied.  You look her over, determined to find a home for every single one.  The chlorophyll-laced girl shudders, and the wobbling of her tremendous breasts answers your question for you.  The fifth green cock darts out from your genital bundle toward the quaking cleavage, crossing the intervening distance in a heartbeat.  It snuggles right into Holli's breasty crevasse and immediately sets to moving.  Jiggling, the sea of breast-flesh wobbles obscenely with every pass your tentacle makes into its valley.  Your own pre-sap quickly converts the mammary ravine into a swampy, sticky, cock-flavored mess.  The head curls down to press on one of her almond nipples, smearing its syrupy lactic cargo over the hardening bud. ");
	outputText("\n\nThe dryad is inundated with cock, dominated with dick.  Her eyes roll back from pleasure, and her entire body begins to shake with spasms of delight.  Above, the foliage joins her in orgasmic writhing, the rustling leaves sounding very much like they're in the enduring of gale-force winds.  Her tentacle-vines, while normally content to stay above, drop down, vacantly spraying sap onto the ground.  The bark below Holli's legs glistens with her gushing nectar.  The tentacle inside her flower is being squeezed, caressed, and wrung by her tender folds.  Higher up, your tit-fucking tendril is splattered with syrupy breast 'milk', which makes her cleavage that much slicker, wetter, and better for you to abuse.");
	outputText("\n\nYou unspool a sixth penis from your remaining, unoccupied bundle.  It whips right into the syrupy, sappy little valley with its brother, and you begin to double-tit-fuck and frot yourself simultaneously, twin dicks grinding against each other and the soaked breasts at the same time.  Holli jolts weakly at the new sensation, but otherwise she seems to remain comatose.  Well, except her hands, which she keeps dutifully pumping on your second and third dongs, squeezing more and more pre onto her palms as she goes.  You're enjoying this so much that you find yourself eager for more stimulation, and you easily contort your members to spool around Holli's well-used form.  The throat-fucking cock wraps around her neck and shoulders.  You loop the pussy-penetrating dick up and around so as to caress her waist.  The tit-fuckers each encircle one of her breasts in their spare time.  She is surrounded with penis and drunk on the pleasure that only they can offer, her body reduced to a masturbation aid for you to fuck and rub on.");
	outputText("\n\nWhile the experience is intense, perhaps exquisite, you have four more manhoods left to tend to and precious little of her human shape left to abuse.  It's then that the drooping tentacles catch your eyes.  Not all of them are phallic, like your own.  Some are rather different... hollow and wet.  You release your remaining quartet of cocks to investigate these new arrivals, and as they probe at the slick entrances, you're greeted by pleasure as immediate as it is intense.  These are cunt-tentacles!  All four of the unsated penises thrust as one, snaring themselves into the sucking wet holes they've been presented with.  Holli's tube-pussies prove a perfect match for your virile green shafts - they devour your manhoods with unholy glee, easily swallowing up foot after foot of pulsing, tumescent flesh.");
	outputText("\n\nYou're awash in an orgy of pleasure.  It radiates out from your groin in pulsing waves, forming into breakers as it travels up your spine.  Then, it breaks over your brain, and like a switch inside you is flipped, you go into a frenzy.  Every single one of your tentacles begins to move faster and faster, pumping with quick, hard strokes into its orifice of choice, be it fingers, cleavage, mouth, or twat.  You pound each hole brutally hard.  Fluids spray out with each thrust to spatter the ground.  You can't tell if they're yours or hers, only that the air fills with the scents and sounds of rampant sex.");
	outputText("\n\nA tremendous upwelling of excitement surges through your meager frame, and you feel insignificant in the face of it, like your body is simply too small and simple for you to endure such agonizingly intense pleasure.  Your penises thrust and move of their own accord as your bliss builds, eyes rolled back into your head.  Holli watches you with a dopey, pleasure-dazed look in her eyes as she's thoroughly fucked, smiling faintly when she sees your [hips] begin to shake as orgasm overtakes you.");
	if(player.balls > 0) outputText("  Your [balls] draw up tight to your groin and squeeze, rhythmically discharging their heavy loads.");
	outputText("\n\nSemen distends each of your tools with spheroid bulges, rushing out from the root and through the stem.  Holli's plush body distends beautifully as the swollen shapes squeeze on her tentacle-wrapped form.  Her breasts even fountain a spray of syrup from the extra compression.  The first one to enter her comes through her mouth, stretching her jaw to its limits.  Distending her throat, the bulging spunk-globule passes down her esophagus to burst free from your flaring, purplish cock-tip and explodes into her waiting belly.  Her eyes widen in confusion as her abdomen is packed with spunk, all without her getting to taste a single, salty drop.");
	outputText("\n\nWhile those spooge-filled distortions travel on, your body has already pushed out the next set");
	if(player.cumQ() > 500) outputText(", and the next");
	if(player.cumQ() > 1400) outputText("... and the next");
	outputText(".  Another jizz-load reaches one of your crowns, and you fire a goopy load into Holli's hair from one of the hand-bound shafts.  The other side follows, spraying a torrent of milky creme onto her face, practically gluing the dryad's eyes shut with semen.  The twin-tit-fucking tendrils ejaculate next.  The first one is barely seen, as it's lodged deep between her gorgeous g-cups, but you can feel it.  The warmth floods her breasts with subtle, wet heat, making your other tentacle cum all that much harder.  It spurts hard enough that the load deflects off her neck and chin and right back down onto the top of her tits, glazing both.");
	outputText("\n\nHolli climaxes again when your load passes into her vagina, deforming the petals slightly as it goes.  Her cunt-tentacles are similarly stretched by the force of your orgasm, distended by spermy knots that erupt inside them.  Jizz and girl-cum drip from the numerous twats, all five of them.  Those pussies aren't simply idly filled either.  They hungrily massage you throughout their own moments of bliss, actually providing a modicum of suction to draw even more spunk from your [balls].  You roar in triumph and thrust all ten at once, pushing them as deep into their chosen locations as you ride out of the ecstasy, spurting and shaking.");
	outputText("\n\nYou come to a little while later.  Your myriad tentacles have retracted back to your groin, though a goodly number of them have a distinctly feminine odor clinging to them.  Holli is sagging back in her tree, covered in a pearly shine that can only be your fertile batter.  She's panting while the cum runs out and over her unimpeded, dripping from the canopy as well.");
	outputText("\n\nStretching the kinks from your shoulders, you walk up to the confused cum-dump and say, \"<i>That's how you sow seed, little flower.</i>\"  Holli shudders, releasing a squirt of your goo from her twat.  You laugh and get dressed before departing, feeling blessedly sated.");
	player.sexReward("vaginalFluids","Dick");
	dynStats("lib", .4, "sen", -3, "cor", 1);
	fertilizeHolli();
	fertilizeHolli();
	doNext(camp.returnToCampUseOneHour);
}
private function vaginalDomHollisTentacruels():void {
	clearOutput();
	outputText("You sashay over to your favorite tentacular tree and trace your finger through Holli's cleavage, purring, \"<i>I'm feeling a little randy.  Do me a favor and bring your 'little' friends down to play, would you?</i>\"  The commanding tone of your voice leaves little doubt that the question is anything but.  With a little bit of fear in her black, tainted eyes, Holli nods meekly.  A rain of green, phallic tentacles pours out of the robust canopy above, hanging behind you idly, though a few of them arch up like snakes sensing prey.  You hold your immobilized pet's chin in your hand and tilt her head up slightly so she sees you eye to eye.");
	outputText("\n\n\"<i>Good pet,</i>\" you coo, releasing her and turning about, making sure to sway your [hips] hypnotically and remind her just what she's going to get.  The closest tentacle sways in your direction to nuzzle on your " + player.skinFurScales() + ".  You raise your palm to support it, gliding your palm along the underside while you shrug out of your [armor].  The phallic vine eagerly rubs against you like an affectionate pet, though clear sap leaks from the moist slit at its tip.  You squeeze it just behind the purple-tinged tip and pull, dragging it over toward Holli.");
	outputText("\n\nThe dryad tilts her head uncertainly as she's confronted with one of her own unholy malenesses.  You set the long shaft in between her heavy breasts and step back to observe your handiwork.  The tendril wiggles happily and begins to slide through her cleavage, rocking her back a little from the force of its affections.  Holli gasps, surprised by her lack of control and the masturbatory tit-fuck.  Her eyes cross, trying to lock onto it as it pushes through her tits, the purple tip butting up against her chin at the apex of its path.  You pump the shaft a few feet back to encourage it, and the pulsing prehensile penis plunges through her lips.");
	outputText("\n\nA muffled moan slips from the arbor bitch's well-stuffed mouth, accompanied by a shuddering shake that sets her tits to wobbling.  You prance up next to her and whispers in her ear, \"<i>Get that one nice and wet for me, okay, babe?</i>\"");
	outputText("\n\nHolli moans again, this time loud enough to be audible from more than a few feet away.  You pirouette away, flouncing through the forest of idle green cocks.  They seem a little bigger - perhaps more engorged - than before.  The arousal coursing through Holli's body must be spreading through all of her extremities, even ones as far removed as these.  Grabbing two more, you spin back to face the orally occupied god-spawn.  Her eyes are half-closed and unaware, though she can surely feel the heat of your palms warming her double dicks' undersides.");
	outputText("\n\nA wicked idea comes to mind, and you act on it without pause, releasing one of your prizes to pry the saliva-soaked member from Holli's mouth.  She gasps in a quick pant, just in time to be plugged with a fresh cock, immediately releasing the fresh air in a whimpering groan that vibrates through this new cock.  You yank the well-lubed phallus down to your mons and press it up into your [vagina].  Though it is wide, the tip is well rounded, and it slides through you with almost buttery smoothness.  Behind the distended crown, the wiggling flesh tube begins to exert a gentle pressure, lashing around as it tries to penetrate you further.  You relax further and allow it to spear deeper, all the way to your unguarded cervix.");
	player.cuntChange(25,true,true,false);
	outputText("\n\nIt takes considerable effort, but you manage to remain upright through it all.  An involuntary trembling washes through you as you caress the remaining cock.  You cough to clear your throat and tauntingly ask, \"<i>Enjoying the mouthful, dear?</i>\"  She nods, jiggling the dangling shaft this way and that with the motion.  \"<i>Good, keep on sucking, and don't let the tentacle between my legs be idle either.  You're going to bring me off to a nice, wet orgasm.</i>\"");
	outputText("\n\nHolli nods again, more enthusiastically this time.  The tentacle lodged in your [vagina] retracts slightly, but only for a moment.  It returns to your twat with a vengeance, plunging up hard.  You gasp, \"<i>O-oh!  Go... go slower!</i>\"");
	outputText("\n\nThe tentacle prick pumps faster, more and more of its surface coated with wetness as it works.  You growl in frustration, yank the dick out of Holli's mouth, and slap her across the face with it, broadside.  She gasps in pain and shock.  Between your legs, the overeager motions cease.  In your hand, the slick shaft tries to wiggle free.  You squeeze down on it, and it arrests its rebellious motions, lest it injures itself.");
	outputText("\n\n\"<i>I told you, slower,</i>\" you say, punctuating the sentence with another heavy cock-slap.  Holli works her jaw in irritation, but lowers her eyes against the inferno in your steely gaze.  \"<i>Better.  Now, kiss and make up, you two.</i>\"  You cram the tender cock right back into her noise hole and command, \"<i>Giddyup, little pony - you've still got a [master] to serve.</i>\"");
	outputText("\n\nThe undulations down below resume, this time at a pleasantly languid pace.  You sigh in contentment, finally able to enjoy the slow fuck.  You grope at your [fullChest]");
	if(!player.hasFuckableNipples() && player.lactationQ() < 50) outputText(" and pay special attention to your [nipples], tugging them in time with every sluggish thrust in your slit.");
	else if(player.lactationQ() >= 50) {
		outputText(" and sigh at the ");
		if(player.lactationQ() < 150) outputText("squirts");
		else if(player.lactationQ() < 800) outputText("sprays");
		else if(player.lactationQ() < 2000) outputText("outpouring");
		else outputText("thick fountains");
		outputText(" of milk that escape with every tug, timed to match the sluggish thrusts at your slit.");
	}
	else outputText(" and sink your fingers into your [nipples], fucking them to the sluggish tempo of the thrusting tentacle.");
	outputText("  A loud groan escapes your mouth, and you rock your [hips] against the undulating tendril.  Your body's eagerness for more pleasure is unparalleled, but you control yourself as efficiently as you control the dryad.");
	outputText("\n\n\"<i>Bring two tentacles over here, Holli.  I want to see how you look with a mask of your own seed.</i>\"  Holli's pale green skin blushes darker, almost as dark as her viridian hair, but two tentacles appear beside you, as if by magic.  Their heads are flared and purplish, as wide as the shaft and a half, leaking clear trails of slick pre-sap.  You touch the tip of one and giggle when it bubbles up a fresh batch of lubricant.  It's smooth and slick on your hand, perfect for a handjob.  You begin to masturbate the two arrivals, taking care to keep them pointed directly at Holli's face.  The poor woman has her mouth full of dick, a cock deep in your twat, and two swollen heads barely a few inches away from her unprotected face.  It's a wonder she can think with all that going on.");
	outputText("\n\nMoving quicker now, Holli's tentacle begins to pound you faster, pistoning with greater and greater enthusiasm.  You let it - you're achingly wet by this point, and a fast, fervent fuck is exactly what your [vagina] needs.  \"<i>Harder!</i>\" you urge, and your obedient tree-slut obeys.  The thick-tipped tendril smacks into your cervix, filling your channel completely with its thick length.  Its shaft arches up, grinding over your [clit]");
	if(player.clitLength >= 3.5) outputText(" for a moment before wrapping around and jerking on it");
	outputText(".");
	outputText("\n\nHolli cries, \"<i>Hnnng...  grmmnuh... gmmmnuh mmphum!</i>\"");
	outputText("\n\nShe's... what?  A telltale flaring deep inside you alerts you what she was trying to tell you - she's about to cum.  Well, you aren't far that yourself, and there's nothing like a show to put you over the edge.  You jerk faster on the cocks in your hands, smiling when their purplish heads distend violently, so wide you're forced to keep your hands behind the tips.  Droplets of pre-cum spatter off the ground, and Holli's cheeks bulge with the over-engorged girth inside her mouth.");
	outputText("\n\nYou whisper into her ear, \"<i>Go on, slut, cum.</i>\"  You stroke her faster, so fast your arms are starting to burn from the effort.  \"<i>Cum for [master], go on.  Spooge all over your pretty face and hair.  Pump all that nasty cum straight down your throat.</i>\"  Holli's eyes begin to roll back, and you throatily purr, \"<i>Bust a nut in my cunt, little slut.</i>\"");
	outputText("\n\nThe tentacles go rigid, completely, absolutely hard.  The swollen heads pulsate while bulges of cum ripple down the lengths behind them, eventually bursting out.  You hold them firmly and direct them across the dryad's striking face, burying it in thick flows of white.  Her shiny green hair quickly comes to wear an alabaster bonnet, dripping thick spunk over her eyes toward her tits.  Jism pours out of Holli's nostrils unhindered while her throat works to swallow it all, but no matter how much she gulps, she can't seem to keep up.");
	outputText("\n\nA warm wave washes into your womb at the same time, easily injected past your cervix's unresisting entrance.  Some of it sputters out to the sides to further lubricate your tunnel.  It sets you off like a bomb, and you fall back onto the ground, trying to lift your [hips] higher.  With gravity assisting, the jism floods your uterus even faster.  The squeezing tightness of your involuntary muscle spasms don't help.  If anything, your body is holding even more of the spooge inside, forcing you to take another few blasts of jizz straight into your well-packed reproductive system.");
	outputText("\n\nThe still spurting cock begins to withdraw, dragging its over-sized head through your sensitive, quavering gates.  It bumps your tender clit on the way, soaking it with a fresh flow of semen.  Then it ascends into the canopy, leaving your [vagina] empty of everything but the gallon of creme it left behind.  You hum in satisfaction and try to stand.  Your [legs] wobble and give out, dropping you back ");
	if(player.wetness() < 4) outputText("onto the ground");
	else outputText("into the leavings of your squirting orgasm");
	outputText(".  The second time, you make it up.  Holli is a mess.  Everything from the shoulders up is glazed white, while the rest of her body has strings of seed dangling like obscene Christmas ornaments.  Around you, there's small puddles of seed rapidly vanishing into the wasted earth - each of the other tentacles erupted with its brothers, spurting uselessly as you ignored it.");
	outputText("\n\nYou give Holli a peck on her cheek, savoring the flavor and say, \"<i>Good girl.</i>\"  Then, you get dressed, trying to ignore the squishing wetness between your thighs.");
	fertilizeHolli(false);
	player.sexReward("cum");
	dynStats("sen", -2, "cor", 1);
	doNext(camp.returnToCampUseOneHour);
}

private function fertilizeHolli(cock:Boolean = true):void {
	//20% chance per sexing.  Up to bonus 20% for jizz or fertility! Max 62%.
	var odds:Number = 20;
	if(cock && player.hasCock()) {
		odds += player.cumQ()/300;
		if(odds > 40) odds = 40;
		if(player.findPerk(PerkLib.MaraesGiftStud) >= 0) odds += 10;
		if(player.findPerk(PerkLib.FerasBoonAlpha) >= 0) odds += 10;
		if(player.findPerk(PerkLib.ElvenBounty) >= 0) odds += 2;
	}
	if(!cock && player.hasVagina()) {
		odds += player.totalFertility()/5;
		if(odds > 40) odds = 40;
		if(player.findPerk(PerkLib.MaraesGiftFertility) >= 0) odds += 10;
		if(player.findPerk(PerkLib.FerasBoonBreedingBitch) >= 0) odds += 10;
		if(player.findPerk(PerkLib.ElvenBounty) >= 0) odds += 2;
	}
	if(odds >= rand(101)) {
		flags[kFLAGS.HOLLI_FRUIT] += 1 + rand(Math.floor(odds/10));
		trace("Holli pregged!");
	}
}

private function haveAMapleSyrupSnack():void {
	clearOutput();
	outputText("You approach Holli with a hungry smile plastered across your [face], licking your chops as you eye the arboreal dryad with unrestrained desire.  Of course, your gaze fixes on her heavy chest, with its distended, dripping nipples.  They leak sweet sap as you stare; the plant-woman seems eager to feel your mouth on her slick, almond-colored buds.  Looking at you knowingly, Holli asks, \"<i>Come for a little pick-me-up?  Well, go on; drink deeply of my nectar, </i>champion.\"  The last word is inundated with tender, encouraging tones.");
	outputText("\n\nGrowling faintly, you snake your arm in along her side and curl it behind her back, pulling her forward and out.  Holli gasps in surprise, but doesn't struggle.  A drop of her syrupy sap splashes on your [armorname], trickling out with greater rapidity from the dryad's sweet tits.  You crane your neck to take one in your mouth, and immediately begin to suckle it down.  The fluid is more like maple syrup than milk, and so potent it fizzles on your tongue, bursting with flavor.  With your free hand, you squeeze the rounded tit and increase the flow.");
	outputText("\n\nHolli gasps, \"<i>Not so hard!</i>\"");
	outputText("\n\nLooking up at her concerned visage, you wink and bite down on the tender nipple, just hard enough to make her squeak in distress.  The pant-women body twists in your grip, but with your arm around the small of her back and her body part of the tree, she has nowhere to go.  You easily restrain her, allowing yourself to fully sample her treats.  Your throat bobs with each gulp of the free-flowing nectar and tingles as your tongue did before.  Soon, your whole body feels alight with energy, just as you finish the first breast.");
	outputText("\n\nThe nipple pops out of your lips with a weak spray of 'milk', and its owner shudders slightly, her flower blooming against your [legs], weakly grasping.  You let your restraining arm go a bit lower to squeeze Holli's cute little butt.  Her smooth skin feels perfect in your hand, though you can feel that a little lower, her flesh joins with the wood of the tree, becoming quite rough.  How odd.");
	outputText("\n\nYou quickly tire of fondling the proud creature's body and return to drinking her treasure straight from the tap, suckling hungrily to expedite the process.  Holli's pants can be heard above you, and the slick grinding of her petals over your [hips] adds to the eroticism in the air.  Your own blood is pumping harder and faster, flushing your [skin].  Drinking deeper, you realize you feel vibrantly alive, completely and utterly suffused with energy.  You swallow the last of Holli's syrup and shake slightly, breaking away from the intimate embrace you shared.");
	player.refillHunger(20);
	outputText("\n\nHolli is trembling and oozing lubricants from below, her pale-green skin flushed almost purple.  Eyelids hanging heavy over her dilated pupils, she gasps and pants... it appears that she was able to orgasm from that, but still wants more.");
	outputText("\n\nPerhaps later.  You burp and walk off, having gotten just what you wanted.");
	//stat changes n' shit
	dynStats("lib", .5, "sen", 1, "lus", 15, "cor", -1);
	fatigue(-100);
	doNext(camp.returnToCampUseOneHour);
}

private function eatHolliFruit():void {
	clearOutput();
	outputText("You reach up into Holli's branches and pluck ");
	if(flags[kFLAGS.HOLLI_FRUIT] == 1) outputText("the fruit");
	else outputText("one of the fruits");
	outputText(".  ");
	if(flags[kFLAGS.HOLLI_FRUIT_EXPLAINED] == 0) {
		outputText("Holli smiles over at you and asks, \"<i>Enjoying the fruits of our union?</i>\"");
		outputText("\n\nYou nearly drop the purplish pear in surprise...  This came from the... the sex?  The plant-woman nods at you and explains, \"<i>Well, what did you think?  I'd get pregnant?  I'm a tree.  When we bear fruit, we do it literally.</i>\"  Holli smirks a little and encourages you, \"<i>Go on, try it.  They're supposed to be delicious... though I haven't eaten one, of course.</i>\"\n\n");
		flags[kFLAGS.HOLLI_FRUIT_EXPLAINED]++;
	}
	outputText("Biting into it, sweet juices seem to explode from the flesh, dribbling down your chin.  It tastes like a dessert and you chow down, happily munching away.  In no time flat, you're down to just a core.  You toss it and wipe your [face] clean, then burp.  Damn, that was good! ");
	player.refillHunger(25);
	//TF CHANCES
	if(rand(2) == 0 && player.cockTotal() > player.tentacleCocks()) {
		var choices:Array = [];
		var i:int = 0;
		while(i < player.cockTotal()) {
			if(player.cocks[i].cockType != CockTypesEnum.TENTACLE) choices[choices.length] = i;
			i++;
		}
		i = choices[rand(choices.length)];
		outputText("\n\nYour " + num2Text2(i+1) + " penis itches, and you idly scratch at it.  As you do, it begins to grow longer and longer, all the way to the ground before you realize something is wrong.  You pull open your [armor] and look down, discovering your " + cockDescript(i) + " has become a tentacle!  As you watch, it shortens back up; it's colored green except for a purplish head, and evidence seems to suggest you can make it stretch out at will.  <b>You now have a");
		if(player.tentacleCocks() > 0) outputText("nother");
		outputText(" tentacle-cock!</b>");
		player.cocks[i].cockType = CockTypesEnum.TENTACLE;
		player.cocks[i].knotMultiplier = 1.3;
		dynStats("sen", 3, "lus", 10);
	}
	flags[kFLAGS.HOLLI_FRUIT]--;
	if(player.tou < 50) dynStats("tou", 1);
	if(player.str < 50) dynStats("str", 1);
	doNext(camp.returnToCampUseOneHour);
}

//Guard Camp
private function askHolliToGuard():void {
	clearOutput();
	outputText("Holli bows her head when you mention her guarding camp.  She asks, \"<i>Shall I keep watch for foes to drain or let them into camp for you to have the pleasure of dealing with, [name]?  <b>I've been ");
	if(flags[kFLAGS.HOLLI_DEFENSE_ON] == 1) outputText("keeping watch");
	else outputText("sleeping, instead");
	outputText(".</b></i>\"");
	menu();
	if(flags[kFLAGS.HOLLI_DEFENSE_ON] == 1) addButton(1,"Don't Guard",toggleHolliGuard);
	else addButton(0,"Guard",toggleHolliGuard);
	addButton(4,"Back",treeMenu);
}

//Guard On
private function toggleHolliGuard():void {
	clearOutput();
	if(flags[kFLAGS.HOLLI_DEFENSE_ON] == 0) {
		outputText("\"<i>All right, I'll get to have some fun then,</i>\" Holli quips while rubbing her palms together in anticipation.");
		outputText("\n\nYou suppose you can sleep better with your dryad taking on the lesser whelps of this land.");
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

}
}