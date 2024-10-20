package classes.Scenes.NPCs{
import classes.*;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.*;
import classes.IMutations.IMutationsLib;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

import coc.view.CoCButton;

public class JojoScene extends NPCAwareContent implements TimeAwareInterface {

	public var pregnancy:PregnancyStore;
	public static const JOJO_NOT_MET:int      = 0;
	public static const JOJO_MET:int          = 1;
	public static const JOJO_CORRUPT_1:int    = 2;
	public static const JOJO_CORRUPT_2:int    = 3;
	public static const JOJO_CORRUPT_3:int    = 4;
	public static const JOJO_CORRUPT_FULL:int = 5;
	// Jojo denied sex first time
	public static const JOJO_NOSEX_1:int      = -1;
	// Jojo denied sex at high affection
	public static const JOJO_NOSEX_2:int      = -2;
	// Jojo agreed to sex
	public static const JOJO_SEXED:int        = -3;


    public static var monk:Number = JOJO_NOT_MET;

    public function JojoScene()
		{
			pregnancy = new PregnancyStore(kFLAGS.JOY_PREGNANCY_TYPE, kFLAGS.JOY_PREGNANCY_INCUBATION, kFLAGS.JOJO_BUTT_PREGNANCY_TYPE, kFLAGS.JOJO_EGGCUBATE_COUNT);
			pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER, 150, 120, 96, 72, 48);
			EventParser.timeAwareClassAdd(this);
		}

		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			pregnancy.pregnancyAdvance();
			if (flags[kFLAGS.JOJO_COCK_MILKING_COOLDOWN] > 0) flags[kFLAGS.JOJO_COCK_MILKING_COOLDOWN]--;
			if (player.hasStatusEffect(StatusEffects.NoJojo)) player.removeStatusEffect(StatusEffects.NoJojo);
			if (pregnancy.isButtPregnant && pregnancy.buttIncubation == 0) {
				jojoLaysEggs();
				return true;
			}
			if (player.hasStatusEffect(StatusEffects.PureCampJojo) && inventory.hasItemInStorage(consumables.BIMBOLQ) && flags[kFLAGS.JOJO_BIMBO_STATE] == 0 && flags[kFLAGS.BIMBO_LIQUEUR_STASH_COUNTER_FOR_JOJO] < 72) {
				flags[kFLAGS.BIMBO_LIQUEUR_STASH_COUNTER_FOR_JOJO]++;
			}
			if (flags[kFLAGS.JOJO_BIMBO_STATE] == 2 && flags[kFLAGS.BIMBO_LIQUEUR_STASH_COUNTER_FOR_JOJO] < 24) {
				flags[kFLAGS.BIMBO_LIQUEUR_STASH_COUNTER_FOR_JOJO]++;
			}
			if (pregnancy.isPregnant) {
				if (joyScene.joyPregnancyUpdate()) return true;
			}
			if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3 && flags[kFLAGS.JOY_TAKES_BABIES_AWAY_COUNTER] > 1)
				flags[kFLAGS.JOY_TAKES_BABIES_AWAY_COUNTER]--;
			return false;
		}

		public function timeChangeLarge():Boolean {
			if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3 && flags[kFLAGS.JOY_TAKES_BABIES_AWAY_COUNTER] == 1) {
				joyScene.joyTakesTheBabiesAway();
				return true;
			}
			return false;
		}
		//End of Interface Implementation

//const TIMES_AMILY_AND_JOJO_PLAYED_TIMES:int = 434;
//const AMILY_X_JOJO_COOLDOWN:int = 435;
//const JOJO_MOVE_IN_DISABLED:int = 550;
//const TIMES_EGGED_JOJO:int = 590;
//const JOJO_EGGCUBATE_COUNT:int = 591;
//const TALKED_TO_JOJO_ABOUT_JOY:int = 1305; //set after you talked to jojo after debimboing him

public function jojoSprite():void {
	if (flags[kFLAGS.JOJO_BIMBO_STATE] != 3) {
		if (tentacleJojo()) spriteSelect(SpriteDb.s_jojoTentacle);
		else spriteSelect(SpriteDb.s_jojo);
	}
	else spriteSelect(SpriteDb.s_joy);
}

private function assholeOrDP():String {
	if(player.hasVagina()) return (vaginaDescript(0) + " and " + assholeDescript());
	return assholeDescript();
}
private function vaginaOrDicksOrCrotch():String {
	if(player.gender == 0) return "crotch";
	if(player.gender == 1) return multiCockDescriptLight();
	if(player.gender == 2) return vaginaDescript(0);
	if(player.gender == 3) return (multiCockDescriptLight() + " and " + vaginaDescript(0));
	return "FUKK: ERROR";
}
private function mouthMuzzle():String {
	if (player.hasMuzzle()) return "muzzle";
	return "mouth";
}
private function faceMuzzle():String {
	if (player.hasMuzzle()) return "muzzle";
	return "face";
}
public function tentacleJojo():Boolean {
	return player.hasStatusEffect(StatusEffects.TentacleJojo);

}
override public function campCorruptJojo():Boolean {
	return monk >= 5 && !player.hasStatusEffect(StatusEffects.NoJojo) && flags[kFLAGS.JOJO_DEAD_OR_GONE] == 0;
}

private function jojoMutationOffer():void {
	jojoSprite();
	clearOutput();
	outputText("A wicked idea comes to mind while thinking of Jojo.  The lethicite you took from the lake goddess – perhaps it could be used to enhance your own budding demonic powers, and twist your mousey fuck-puppet into a truly worthy pet?\n\n<b>Do You?</b> (WARNING: Offered only once & unlocks tentacle content)");
	doYesNo(jojoMutationOfferYes, jojoMutationOfferNo);
}

private function jojoMutationOfferNo():void {
	jojoSprite();
	clearOutput();
	outputText("There are some lines even you won't cross.  Besides, having a sex-addled mouse with a constantly drooling foot-long cock is all the fun you can handle.\n\nWith that decided you prepare to call on your slut.");
	//Normal jojo sex scene here
	doNext(corruptCampJojo);
}

//CORRUPT CAMP JOJO
public function corruptCampJojo():void {
	clearOutput();
	jojoSprite();
	if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 0)
	{
		//Corrupt Amily and Jojo sexings
		if(flags[kFLAGS.AMILY_FOLLOWER] == 2 && amilyScene.amilyFollower() && campCorruptJojo() && flags[kFLAGS.AMILY_X_JOJO_COOLDOWN] <= 0 && rand(5) == 0 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) {
			flags[kFLAGS.AMILY_X_JOJO_COOLDOWN] = 7;
			hideMenus();
			amilyTeachingJojoBJ();
			return;
		}
		//Oh shit goes down! (Wiv Tentacles)
		if(amilyScene.amilyFollower && flags[kFLAGS.AMILY_DISCOVERED_TENTATLE_JOJO] == 0 && rand(10) <= 1 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && player.hasStatusEffect(StatusEffects.TentacleJojo)) {
			finter.amilyDiscoversJojoWithTentaclesAndShitOhBoy();
			return;
		}
		//Oh shit goes down! (No tentacles)
		else if(flags[kFLAGS.AMILY_PISSED_PC_CORRUPED_JOJO] == 0 && rand(10) <= 1 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower() && !player.hasStatusEffect(StatusEffects.TentacleJojo)) {
			finter.amilyIsPissedAtYouForRuiningJojo();
			return;
		}
		//Offer lethicite jojo tf if the player is ready
		if(!player.hasStatusEffect(StatusEffects.JojoTFOffer) && player.hasKeyItem("Marae's Lethicite") >= 0 && player.keyItemvX("Marae's Lethicite", 1) > 0 && player.cor >= 75 - player.corruptionTolerance && player.gender > 0) {
			jojoMutationOffer();
			player.createStatusEffect(StatusEffects.JojoTFOffer,0,0,0,0);
			return;
		}
		clearOutput();
		outputText("Before you call for your corrupted pet, how do you want to use him?");
	}
	else
	{
		outputText("Jojo slinks out of a barn when you call his name, hating and loving every step he takes towards you. He looks dusty and worn out but his dick still strains at the sight of you.");

		// Appearance splice lel
		outputText("\n\nJojo is an anthropomorphic mouse with immaculate white fur. His brown eyes stare at you with a mixture of despair and unrequited need. Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed. He’s naked, with a large tainted throbbing member bouncing at attention. A fuzzy sack with painfully large looking balls dangles between his legs.");
		if (tentacleJojo()) outputText(" A number of tentacles vaugley resembling cocks have sprouted from his back and groin. They sway restlessly around him, oozing thick, fragrant pre from their tips.");

		if (SceneLib.farm.farmCorruption.hasTattoo("jojo")) {
			outputText("\n\n");
			if (SceneLib.farm.farmCorruption.fullTribalTats("jojo")) {
				outputText("He is covered from head to tail in tribal tattoos, erotic lines snaking all over his naked frame, giving him the look of a barely tamed savage.")
			} else {
				if (SceneLib.farm.farmCorruption.numTattoos("jojo") > 1) outputText("He has the following tattoos emblazoned across his body:\n");
				else outputText("He has ");

				if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE] != 0) outputText(flags[kFLAGS.JOJO_TATTOO_COLLARBONE] + "\n");
				if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS] != 0) outputText(flags[kFLAGS.JOJO_TATTOO_SHOULDERS] + "\n");
				if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK] != 0) outputText(flags[kFLAGS.JOJO_TATTOO_LOWERBACK] + "\n");
				if (flags[kFLAGS.JOJO_TATTOO_BUTT] != 0) outputText(flags[kFLAGS.JOJO_TATTOO_BUTT] + "\n");
				outputText("\n");
			}
		}
		if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO_GIBS_DRAFT] == 1) {
			flags[kFLAGS.FOLLOWER_AT_FARM_JOJO_GIBS_DRAFT] = 2;
			outputText("\n\nYou wordlessly hold out your hand. Trembling, Jojo lays an incubus draft on it.");
			outputText("\n\n\"<i>M-mistress Whitney says s-she'll put the rest with your cut of the farm profits [master].</i>\"\n\n");
			inventory.takeItem(consumables.INCUBID, corruptCampJojo);
			return;
		} else outputText("\n\n\"<i>What can I do for [master]?</i>\"");
	}
	menu();
	addButton(0, "Sex", corruptJojoSexMenu)
		.disableIf(player.isGenderless(), "Not for you, genderless!")
		.disableIf(player.lust < 33, "Not aroused enough!");
	addButton(1, "TentacleSex", useTentacleJojo)
		.disableIf(player.lust < 33, "Not aroused enough!")
		.disableIf(!tentacleJojo(), "He has to undergo some <i>changes</i> first...", "???");
	addButton(2, "Milk Him", flags[kFLAGS.JOJO_TIMES_MILKED] == 0 ? milkJojoFirst : repeatMilkJojo)
		.disableIf(flags[kFLAGS.JOJO_COCK_MILKING_COOLDOWN] > 0,
			"Jojo is still drained from his last visit to the milkers - you should wait a few hours before taking him back.")
		.disableIf(player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") < 0,
			"You lack some equipment on Whitney's farm...", "???");
	addButton(3, "TentacleMilk", repeatMilkJojo, true)
		.disableIf(flags[kFLAGS.JOJO_COCK_MILKING_COOLDOWN] > 0,
			"Jojo is still drained from his last visit to the milkers - you should wait a few hours before taking him back.")
		.disableIf(!tentacleJojo(), "He has to undergo some <i>changes</i> first...", "???")
		.disableIf(player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") < 0,
			"You lack some equipment on Whitney's farm...", "???");
	addButton(4, "Lay Eggs", beeEggsInCorruptJojo)
		.disableIf(!player.canOvipositBee(), "Req. a bee ovipositor");
	addButton(5, "Hair Care", jojoPaysForPerms)
		.hint("Use your mouse-slut to pay for your hair-care at Lynette's.")
		.disableIf(!player.hasStatusEffect(StatusEffects.HairdresserMeeting),
			"You need to find some place to take care of your hair first.", "???");
	if (flags[kFLAGS.FARM_CORRUPTION_STARTED] == 1) {
		if (flags[kFLAGS.FOLLOWER_AT_FARM_JOJO]) {
			addButton(10, "Go Camp", backToCamp);
			if (flags[kFLAGS.FOLLOWER_PRODUCTION_JOJO]) addButton(11, "Stop Harvest", stopHarvestJojoDraft);
			else addButton(11, "Harvest Draft", harvestJojoDraft);
		}
		else addButton(10, "Farm Work", sendToFarm);
	}
	addButton(14, "Back", flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] ? SceneLib.farm.farmCorruption.rootScene : camp.campSlavesMenu);
}

private function harvestJojoDraft():void
{
	clearOutput();
	jojoSprite();

	outputText("You tell Jojo that you want him hooked up to a cock milker whenever possible; you need his fluids.");

	outputText("\n\n\"<i>Th-that’s why you wanted me to come out here? To... harvest me?</i>\" Jojo’s mouth opens to the monstrosity of it, even as his dick strains helplessly to the selfsame idea.");

	if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 0) outputText("\n\n\"<i>I-I’m sorry [master], but there’s no device around here that could be used t-to do that. Talk to Mistress Whitney, maybe she can have one built.</i>\"");
	else outputText("\n\n\"<i>As you wish [master],</i>\" he whispers.");

	if (flags[kFLAGS.FARM_UPGRADES_REFINERY] == 1) flags[kFLAGS.FOLLOWER_PRODUCTION_JOJO] = 1;

	doNext(SceneLib.farm.farmCorruption.rootScene);
}

private function stopHarvestJojoDraft():void
{
	clearOutput();
	jojoSprite();

	outputText("You tell Jojo to stop producing incubus draft; you’re practically drowning in the stuff. Jojo closes his eyes, and you grin as you envisage the image you’ve just planted in his mind.");

	outputText("\n\n\"<i>Would you like that, Jojo? To literally drown in your [master]’s fluids? Well, maybe later. For now, when you’re fapping to the idea, squirt your useless cum somewhere other than into a bottle, got that?</i>\"");

	outputText("\n\n\"<i>Yes [master],</i>\" says Jojo lowly.");

	flags[kFLAGS.FOLLOWER_PRODUCTION_JOJO] = 0;

	doNext(SceneLib.farm.farmCorruption.rootScene);
}

private function sendToFarm():void
{
	clearOutput();
	jojoSprite();

	outputText("You tell your pet mouse");
	if (tentacleJojo()) outputText("-come-tentacle-beast");
	outputText( " that he is to head towards the lake, find a farm, present himself to the lady who works there and do as she says.");

	outputText("\n\nA mixture of expressions vie for control of Jojo’s face as he swallows this information; you grin as you realize that being at the farm will simply amplify the fact he is both delighted and horrified at being away from you.");

	outputText("\n\n\"<i>I need you to be doing more than jacking off to the thought of servicing me, frankly. Don’t worry though, slut, I will always be close by, and if you’re really lucky and work hard, I might come and fuck you so rotten you can’t walk every now and then. Go on now!</i>\"");

	outputText("\n\n\"<i>As... as you wish [master],</i>\" whispers Jojo, and shakily walks off towards the lake. He will make a decent worker for Whitney, you think, and his haunted midnight pacing will at least add a bit of vigilance to the farm.");

	flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] = 1;

	endEncounter();
}

private function backToCamp():void
{
	clearOutput();
	jojoSprite();

	outputText("You tell him to head back to camp; there are things you need to do to him that you can’t do whilst he’s here. Repeatedly. Jojo trembles, manages a bow, and then slowly trails off towards camp.");

	flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] = 0;

	doNext(SceneLib.farm.farmCorruption.rootScene);
}

public function jojoMutationOfferYes():void {
	jojoSprite();
	if (!recalling) player.addKeyValue("Marae's Lethicite",1,-1);
	clearOutput();
	if (!recalling) outputText("<b>New scene is unlocked in 'Recall' menu!</b>\n\n");
	outputText("There's no question about it, this is a great idea.  It might be coming from the corruption in your blood, but why bother to fight it?  You take Marae's lethicite and grab one of the larger crystalline protrusions.  With a hard yank, you break it off from the main cluster, sending tiny crystalline shards over the campsite.  They vanish into the ground before you have a chance to gather them.\n\n");
	outputText("Whether by luck or some unconscious demonic magic, the smaller piece of lethicite is rather phallic. If it weren't for the sharp corners and hard edges, it would look like a large dildo with a pair of balls at the base.  You put away the larger piece, focusing this tool and your plans for your pet.\n\n");
	outputText("You lick the sharp crystalline dildo, slathering it with spit.  You aren't sure, but you seem unable to stop.  It's as if some demonic force guides you.  It's difficult to focus on much beyond your own arousal and the tingling feeling that spreads through your body as you taste this piece of a goddess' essence.  Your mind drifts off into a perverted fantasy, unable to cope with total loss of control and oral debauchery.\n==========================================\n");
	sceneHunter.selectGender(dickF, vagF, null, null)
	//[Male]
	function dickF():void {
		outputText("<i>In your fantasy you're fucking Jojo again, bottoming out against his cute girlish ass over and over.  His dick spurts mouse-milk with each thrust, feeding a dozen growing puddles underneath him as they slowly merge together.  He writhes and squirms, a pair of crystalline balls against his chin while he deep-throats a massive dildo.  You blast another wave into his overloaded spunk-dumpster, forcing a thick jet out of him and into the cum-puddles underneath you.\n\n");
		outputText("Tired of the foreplay, you pull out of him, watching a river of your cum escape from the uncorked opening.  You pull him up, watching the crystal cock slide out of his mouth, the bulge along his throat slowly disappearing as each inch escapes.  He staggers, completely exhausted, but still hard and horny judging by the look in his eye.\n\n");
		outputText("You shove him over a log and grab his spit-slick toy, dragging it through the puddled cum until it's white and dripping.  Jojo whimpers, his disproportional member stuck between his legs and twitching with anticipation.  The dildo slides into his well-stretched hole with ease, sealing the rest of your tainted seed deep inside his bowels as your magic begins to change him...</i>\n==========================================\n");
		outputText("You snap out of the fantasy with a start.  The crystal shard is sitting on the ground in front of you, but it is no longer a shard – it's the dildo from your fantasy, complete with a thick covering of your cum.  You manage to pry your hand away from your softening member");
		if (player.cockTotal() > 1) outputText("s");
		outputText(" and take the tainted artifact, now ready to be used.</i>\n");
		outputText("\n<b>You just can't wait!  You'll call him over now...</b>");
		doNext(mutateJojo);
	}
	//[Female]
	function vagF():void {
		outputText("<i>In your fantasy, you're riding Jojo hard, milking his swollen dick with your pussy");
		if(player.biggestLactation() < 2) outputText(" while your tits cover his head, nearly suffocating him");
		else outputText(" while he suckles one of your breasts hungrily, sucking down your milk");
		outputText(". A crystalline dildo is buried hilt-deep in his ass, held in place by a harness of your own design that twists it around every time he moves.  You cum again, relishing the desperate and needy look the poor mouse is giving.  Your spasming pussy is immediately filled with even more warmth, and you feel the thick spunk forcing its way into your core until you feel bloated.\n\n");
		outputText("You calm your trembling body and stand up off of him, soaking him with his own escaping fluids.  Jojo moans and starts pumping his dick, wriggling his hips while his orgasm is dragged on by the dildo squeezing his prostate.  You curl up alongside his ear and begin whispering into his mind, watching as your words soak in and begin to change him with the aid of the crystalline cock's magic.</i>\n==========================================\n");
		outputText("You snap out of your fantasy with a start.  The crystal shard is sitting on the ground in front of you, but it's no longer a shard – it's the dildo from your fantasy, now slick with pussy juices.  You touch your sore cunt and gasp when you realize where it went.  ");
		if(player.vaginas[0].virgin) outputText("(Yet somehow your virginity remains intact).  ");
		outputText("The dildo disappears back into your inventory, and you smile in wicked anticipation of your next meeting with Jojo.\n");
		outputText("\n<b>You just can't wait!  You'll call him over now...</b>");
		doNext(mutateJojo);
	}
}

private function mutateJojo():void {
	jojoSprite();
	clearOutput();
	outputText("You call out, and Jojo obediently pads into the camp.  At some point he decided to switch to wearing a loin-cloth, for all the good it has done him – it drapes over his member, barely covering half of it as it twitches and throbs from your presence.  You gesture for him to remove that tiny cloth, and he does immediately.  When he gets within a few feet of you, he drops to his knees with his hands behind his back, his head down submissively.  You see little tics and twitches run through his body as he fights to resist touching himself, so you drag it out and see how long he can wait.\n\n");
	outputText("It doesn't take long.  A plaintive whine escapes him as his hand creeps around his waist.  You grin and push him onto his back, stepping onto his wrist to pin his hand in place.  You drop the crystal dildo onto his chest with a single command, \"<i>Use it</i>\".\n\n");
	outputText("Jojo shivers and takes your offering with his free hand, slowly hefting it and dragging it lower.  He looks up at you questioningly, and you gesture impatiently at him to quit wasting your time.  The dildo's crown presses against his sphincter, stopping for a second as the bitch-boy relaxes, and then begins its long journey inward.  Jojo's eyes roll up a bit and his prick starts pumping out a clear stream of his pre-cum, wetting most of his belly.  Finally the pinkish-hued balls press against his bum.  He's taken the whole thing.\n\n");
	outputText("While you still have one of the mouse's hands pinned under your [foot], his other has already released the tainted sex-toy, and journeyed up to his pre-cum spurting cock.  You waste no time and push his hand away as you jump on top of him, being sure to grind your " + vaginaOrDicksOrCrotch() + " against his slick boner.  He keeps whining plaintively and wriggling his hips against you, but you deny him any further stimulation, instead focusing on keeping him horny while the tainted dildo settles in.\n\n");
	outputText("Jojo's moans reach a fevered pitch as a soft buzzing begins to fill the air behind you.  You turn around and see that the lethicite-crafted dildo has begun to vibrate inside of him!  Somehow you can feel that this is the time to change him – that his form is malleable and ready.  Your hand finds itself wrapped around the base of his cock, bottling him up until you're ready, while you lean up to his cute mouse-ears and start to whisper, \"<i>Aww, does my little rodent-bitch want to cum?</i>\"\n\n");
	outputText("He shakes his head and whines again, trembling underneath you.\n\n");
	outputText("\"<i>Too bad slut,</i>\" you say while you give his balls a squeeze, \"<i>you can't cum until I've changed you into the perfect fuck-toy.  A toy that can just keep cumming, more than once.  A toy who can fill more than one hole at a time.  A toy I could share with my friends, who could keep up with a succubus and an incubus simultaneously.  You'll be that toy for me.  My delicious fuck-puppet that cums on command with tentacle-dicks and pussy-vines aplenty.</i>\"\n\n");
	outputText("Jojo's eyes roll back until all you can see is the whites.  His mouth lolls open from pleasure and lets loose a constant stream of pants and moans.  Already you can feel his cock squirming in your hand, thrashing to get free.  The dildo starts vibrating louder, and his pre-cum manages to start spurting free again, despite your tight grip on his member.  You see his shoulders bulge as something starts wriggling under his skin, thrashing back and forth until they sprout free as a pair of tentacles.\n\n");
	outputText("Uncontrolled, the tentacles curl down to Jojo's vine-like member, wrapping it in coils until your hand is forced off and wriggling around it.  You note each of his new appendages is developing a flare at their tips, and the puddle of pre seems to be growing faster than it ever did before.\n\n");
	outputText("You whisper, \"<i>Good bitch, you'll be able to fuck every hole around you, won't you?  But all I see is an ass and a mouth for cocks.  You need some nice tight cock-sleeves don't you?</i>\"\n\n");
	outputText("On cue, you feel his tail curl up your back, already longer than it ever was before.  To your surprise the fur is vanishing, leaving you feeling smooth rubbery skin.  It splits three ways in an instant, but each grows thicker than his tail ever was before.  One curls over your shoulder as if looking for something, and reveals a strange sucking opening, sticky with some kind of fluid and filled with undulating fleshy ridges.\n\n");
	outputText("You smile and give the opening a lick – it's sweet – and turn back to his ear, \"<i>Now you're where I want you bitch.  Feel that dildo squeezing your prostate?  You'll cum just from that, won't you?  Take those new tentacles off your dick and aim them at your face, I want to watch you give yourself a facial and cum all over yourself just from my other toy.</i>\"\n\n");
	outputText("Despite looking lost to the pleasure, his body obeys, releasing his dick and aiming his shoulder-tentacles at his open mouth.  You can see now that each is a dark green color, and capped with a shiny purplish head, just like the vines in the corrupted glade.  Each of them starts flaring wider, and you feel his cock snake up between your ");
	if(player.biggestTitSize() < 1) outputText("bodies");
	else outputText(allBreastsDescript());
	outputText(", until it pops out just under his chin, looking like a fatter version of the twins on his shoulders.  All three start flaring wider in preparation, and you know he is about to erupt.\n\n");
	outputText("\"<i>Good toy,</i>\" you whisper, \"<i>cum for your ");
	if(player.gender <= 1) outputText("master");
	else outputText("mistress");
	outputText(".</i>\"\n\n");
	outputText("He submits happily, a smile overtaking his face in spite of his eyes rolled back and his tongue drooling all over his muzzle.  His entire body quakes, and you feel bulges beginning to pass under your ");
	if(player.biggestTitSize() >= 1) outputText(allBreastsDescript());
	else outputText("chest");
	outputText(".  You can see them moving up the shoulder tentacles with agonizing slowness, until all three cock-vines erupt simultaneously, splattering Jojo's face with his own seed.  The perfect synchronization is broken immediately when his primary tentacle blasts a glob into his hair, and then the entire scene devolves into a mess of quivering tentacles and splattering spooge.  Jojo's mouth catches plenty, and he begins swallowing instinctively as his tentacles do their best to drown him.\n\n");
	outputText("You pull back and watch, ");
	if(player.cockTotal() > 0) {
		outputText("stroking your own member");
		if(player.cockTotal() > 1) outputText("s");
		outputText(" ");
		if(player.hasVagina()) outputText("and ");
	}
	if(player.hasVagina()) outputText("caressing your aching twat ");
	outputText("as the mouse slowly paints himself with spoo.  By the time he has finished, he is soaked from head to toe, and lying in a puddle of his own making.  The tentacles fall limp and slowly begin to retract, until the only visible indication of their presence is a small lump on each shoulder.  His tails seem to regrow their fur in an instant, but they stay separate, and retain their thicker size.  Last but not least, you see that his member has shrunk back down to almost a foot and a half long, but has thickened up nicely.  Most of it returns to his natural pink skin-tone, but the head remains an angry purple as it stays hard and keeps drooling.\n\n");
	outputText("The dildo is gone, leaving only a hot pink tinge on the fur around his pucker.  Whatever dark magic you managed to imbue it with was used up by the transformation.  Jojo is still out cold, probably unable to cope with the force of his altered orgasm, but his body is doing an admirable job of adjusting.  You even see his three tails curling together until they look like one larger tail.  Only close inspection would reveal the difference.\n\n");
	outputText("You turn back to your " + camp.homeDesc() + ", turned on beyond all measure, and needing to masturbate NOW.  You wonder what Jojo's new additions will feel like on your body when he wakes up, but for now you'll have to get off another way.");
	if (!recalling) {
		dynStats("lus", 300, "cor", 10);
		player.createStatusEffect(StatusEffects.NoJojo, 0, 0, 0, 0);
		player.createStatusEffect(StatusEffects.TentacleJojo, 0, 0, 0, 0);
		doNext(playerMenu);
	} else doNext(recallWakeUp)
}

//[POST TENTACLE DICKINGS]
public function useTentacleJojo():void {
	jojoSprite();
	player.slimeFeed();
	var nippleSucking:Boolean = false;
	var mouthFucking:Boolean = false;
	var titFucking:Boolean = false;
	var cumPuddle:Boolean = false;
	var milkPuddle:Boolean = false;
	clearOutput();
	outputText("You call out, \"<i>Sluuuuuut!</i>\"\n\n");
	outputText("A few seconds later Jojo comes bounding into camp on all fours, blushing furiously and with his ass high in the air, trying to keep his tumescent mouse-member from dragging along the ground.  He presents himself to you, putting his hands behind his back and displaying his prick.  It squirms and wriggles obscenely in a way that nothing that thick should be able to move.  Jojo is biting his lip and blushing hard at his uncontrollable display.  You note that despite his blush, the tiny lumps on his shoulders are growing larger and taking on a purplish hue, while his three tails have begun to disentangle themselves behind him.\n\n");
	outputText("Desperation hangs thick about him in the air as his newfound additions react to your summons.  Somehow he knows you wanted to use them, but he's trying to hold himself back like a good bitch.  You egg him on a bit, taunting, \"<i>Awww, look at the cute little tentacles begging to come out and play,</i>\" while you begin to brush your fingertips along underside of his writhing cock.  Jojo's eye cross from the pleasure, his member growing longer and longer under your touches until it's swaying in the air, snake-like, with its flared purple tip lying in the palm of your hand.\n\n");
	outputText("You drop it, letting it smack into the floor with a wet-sound 'SPLAT' that creates a puddle of pre-cum on the ground.  With your hands free, it is easy to quickly remove your [armor] and toss it back towards your " + camp.homeDesc() + ".  By the time you turn back around, his snake-like member is curling up your thigh, towards your " + assholeOrPussy() + ".  ");
	if(player.hasVagina()) outputText("You feel it split in half, dividing in order to take you from both ends.  ");
	outputText("You marvel at just how hard it is to dominate someone who can fuck you from a few feet away and wrap you up with a half-dozen appendages before you just give in and decide to enjoy it.\n\n");
	outputText("You put your arms on your hips and say, \"<i>Go ahead and ravage me then, but if I don't love every second of it you'll regret it.</i>\"\n\n");
	outputText("Looking very much like a starving man looking at a steak, Jojo smiles serenely and lashes out with his shoulder-tentacles, grabbing your arms and pinning them to your waist.  They wrap about your middle and lift you off the ground with ease.  Suspended in front of him, you're effortlessly rotated in place until your " + assholeDescript() + " is in the air and your legs splayed apart, with the mutant-mouse's primary tentacle getting ever closer to your " + assholeDescript());
	if(player.hasVagina()) outputText(" and " + vaginaDescript(0));
	outputText(".\n\n");
	//REAL SECKS STARTS HERE
	if(player.cockTotal() > 0) {
		outputText("Upside down, you're forced to watch as his tail-tentacles curl out from between his legs, and extend towards your vulnerable [cocks].  All three of them pause a few inches away for what seems an eternity, revealing circular dripping orifices filled with slimy wriggling cilia.\n\n");
		if(player.cockTotal() == 1) {
			//(1dick+balls =
			if(player.hasBalls()) {
				outputText("One of them lashes forwards, ");
				if(player.biggestCockArea() > 60) outputText("laboriously stretching around");
				else if(player.biggestCockArea() >= 20) outputText("engulfing");
				else outputText("easily swallowing");
				outputText(" your [cock] in a tight vise of pleasure.  The other two tentacles slide under, each taking a " + ballDescript() + " partially inside their 'mouths' and massaging them softly.");
				outputText("\n\n");
			}
			//(1 dick no balls =
			else {
				outputText("One of them lashes forwards, ");
				if(player.biggestCockArea() > 60) outputText("laboriously stretching around");
				else if(player.biggestCockArea() >= 20) outputText("engulfing");
				else outputText("easily swallowing");
				outputText(" your [cock] in a tight vise of pleasure.  The other two tentacles slide under, ");
				if(!player.hasVagina()) outputText("rubbing back and forth along your taint and smearing you with their slime.");
				else {
					outputText("rubbing against your thighs and smearing them with lubricant while one of them easily sucks your " + clitDescript() + " inside.");
					//(If big clit –
					if(player.clitLength >= 4) outputText("  You nearly cum on the spot from the clitoral stimulation; it's like you have a super-sensitive cock being licked by a thousand tongues.");
				}
				outputText("\n\n");
			}
		}
		//(2 dicks +
		if(player.cockTotal() == 2) {
			//balls)
			if(player.hasBalls()) {
				outputText("Two of them lash forward, ");
				if(player.biggestCockArea() > 60) outputText("laboriously stretching around");
				else if(player.biggestCockArea() >= 20) outputText("engulfing");
				else outputText("easily swallowing");
				outputText(" your [cocks] in tight vises of pleasure.  The remaining tentacle slides underneath, alternatively taking each of your " + ballsDescript() + " partway into its 'mouth' and massaging them with its thousands of wriggling stimulators.\n\n");
			}
			//(2 dicks no balls)
			else {
				outputText("Two of them lash forward, ");
				if(player.biggestCockArea() > 60) outputText("laboriously stretching around");
				else if(player.biggestCockArea() >= 20) outputText("engulfing");
				else outputText("easily swallowing");
				outputText(" your [cocks] in tight vises of pleasure.  The remaining tentacle slides underneath, seeking ");
				if(player.hasVagina()) {
					outputText("out your " + clitDescript() + " and sucking it inside.");
					//(If big clit –
					if(player.clitLength >= 4) outputText("  You nearly cum on the spot from the clitoral stimulation; it's like you have a super-sensitive cock being licked by a thousand tongues.");
				}
				else outputText("to rub itself along your taint, massaging the sensitive skin with its slimy lubricants.");
				outputText("\n\n");
			}
		}
		//(3 dicks)
		if(player.cockTotal() >= 3) {
			outputText("All three of them lash forward, ");
			if(player.biggestCockArea() > 60) outputText("laboriously working to swallow");
			else if(player.biggestCockArea() >= 20) outputText("engulfing");
			else outputText("easily swallowing");
			outputText(" your [cocks] in tight vises of pleasure.  The sensation is overwhelmingly pleasurable, like having three cocks being licked and sucked by a thousand tongues.");
			//(if extra:
			if(player.cockTotal() > 3) outputText("  The remaining " + Appearance.cockNoun(CockTypesEnum.HUMAN) + "'s pulse and throb with jealous desire, until one of the tentacles slips off and captures it.  They take turns, slipping off and capturing each of your offerings until you wish they'd just keep sucking forever.");
			outputText("\n\n");
		}
	}
	//(0 dicks but clit)
	if(player.cockTotal() == 0 && player.hasVagina()) {
		outputText("One of Jojo's tail-tentacles slides underneath his body, shooting forwards to seek out your " + clitDescript() + ".  It pauses an inch or two away and opens up a horrific orifice full of wriggling tentacles and slick fluids.  The next moment it lunges forwards and sucks it inside.");
		//(If big clit –
		if(player.clitLength >= 4) outputText("  You nearly cum on the spot from the clitoral stimulation; it's like you have a super-sensitive cock being licked by a thousand tongues.");
		else outputText("  The sensation was unreal, and you find yourself wishing your clit was bigger so you could feel even more of the tendrils pleasure-hole.");
		outputText("\n\n");
	}
	//GET BUTT/VAGOO PENETRATED
	outputText("The ");
	if(player.hasVagina()) outputText("pair of tentacles ");
	else outputText("tentacle ");
	outputText("hanging over your bottom decide");
	if(!player.hasVagina()) outputText("s");
	outputText(" that now is a good time to penetrate your undefended opening");
	if(player.hasVagina()) outputText("s");
	outputText(", and press against you, ");
	//Virgin taking
	if(player.hasVirginVagina() || player.ass.analLooseness == 0) {
		outputText("barely slipping inside your virginal opening");
		if(player.hasVirginVagina() && player.ass.analLooseness == 0) outputText("s");
	}
	//not virgin taking
	else {
		//With cunt
		if(player.hasVagina()) {
			if(player.vaginas[0].vaginalLooseness >= VaginaClass.LOOSENESS_GAPING_WIDE) outputText(" practically falling into your oversized cum-receptacles");
			else {
				if(player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_SLICK) outputText(" sliding inside easily thanks to your copious lubrication");
				else outputText("forcing their way inside your " + vaginaDescript(0) + " and " + assholeDescript());
			}
		}
		//Just butt
		else {
			if(player.ass.analLooseness >= 4) outputText(" practically falling into your oversized cum-receptacle");
			else {
				if(player.ass.analWetness >= 3) outputText(" sliding inside easily thanks to your copious lubrication");
				else outputText("forcing its way inside your " + assholeDescript());
			}
		}
	}
	//ON WITH THE PENETRATION
	outputText(".  Your " + mouthMuzzle() + " opens with a wordless cry of surprise ");
	if(player.hasVagina()) outputText("and pleasure ");
	outputText("as Jojo's tentacle");
	if(player.hasVagina()) outputText("s begin");
	else outputText(" begins");
	outputText(" thoroughly violating you, pistoning in and out relentlessly.");
	if(player.cockTotal() > 0) {
		outputText("  You feel a strange pleasure every time it plunges deep into your ass, smacking into your prostate.  ");
		if(player.cockTotal() == 1) outputText("  The tentacle on your [cocks] seems appreciative, and begins sucking to swallow down all your pre.");
		if(player.cockTotal() > 1) outputText("  The tentacles on your [cocks] seem appreciative, and begin sucking to swallow down all your pre.");
	}
	if(player.hasVagina()) outputText("  Your " + vaginaDescript(0) + " spasms around the invader, clenching uncontrollably as it's plowed by the thick vine-prick.");
	outputText("\n\n");
	outputText("You feel the bindings around your waist sliding and twisting to free up some of their length.  The pair of tentacle-cocks rear up before your [allbreasts] like hungry snakes eyeing a mouse.\n\n");
	//(Large tits &/or multitits with no lactation)
	if((player.biggestTitSize() >= 4 || (player.biggestTitSize() >= 4 && player.breastRows.length > 1)) && player.biggestLactation() < 2) {
		titFucking = true;
		outputText("The twin tentacles erupt like kinked up garden-hoses that have suddenly become free, splattering your chest with thick white goop.  They spurt until all of your " + breastDescript(0) + " are painted white with warm dripping goop.  One of the purple-headed monsters slides into the mess, while the other ties itself around your " + breastDescript(0) + ", squeezing its brother tightly between the walls of cum-slickened titflesh.  The swollen purple head bumps your chin, smearing you with its cum as it begins to fuck your tits.  Glob after glob of mouse-cum spatters up from your chest into your chin and mouth, eventually soaking your " + faceMuzzle() + " and neck.\n\n");
	}
	//(Lactating highly)
	if(player.biggestLactation() >= 2) {
		nippleSucking = true;
		outputText("The heads split apart, dividing into quarters as they reveal wet openings with pink, tongue-like appendages.  Milk begins to leak from your nipples as their intent becomes clear, and you inwardly scold yourself for ");
		if(player.cor < 80) outputText("being such a wanton slut");
		else outputText("giving it up too easily");
		outputText(".  Jojo's dick-mouths latch on and suck hard, pulling your " + nippleDescript(0) + "s deep into their internal reservoir and stimulating your breasts to release a torrent of milk.  ");
		if(player.isRace(Races.COW, 1, false)) outputText("You find yourself mooing in contentment as your fuck-slave works to milk you.  ");
		outputText("You watch with a happy smile, enjoying the sensations as the tentacles bulge and move milk-distended knots down their lengths towards Jojo.  They are so full that the sloshing whiteness actually becomes visible through the 'skin' of his tendrils.");
		if(player.breastRows.length > 1) {
			//(NewPG if multirow)
			outputText("\n\nThere is nothing to do but enjoy the sensations until your " + breastDescript(0) + " are emptied, but before that can happen, they detach, soaking your chest with excess milk, and move down to the next row.  It becomes clear they will keep milking you, moving from row to row to give each a chance to recover, so that they can feed indefinitely...");
		}
		outputText("\n\n");
	}
	//(NEITHER - JUST NIPS)
	else if(player.biggestTitSize() < 4 && rand(2) == 0) {
		nippleSucking = true;
		outputText("The heads split apart, dividing into quarters and revealing a wet pink opening with a writhing tongue in the center.  They latch on and suck hard, each pulling your entire " + nippleDescript(0) + " into their interior.  Gasping at the sensations, you can only moan as the tentacular tongue twists itself around your nipple.  ");
		if(player.biggestLactation() >= 1) outputText("A squirt of milk escapes and is quickly sucked down by the hungry tentacles.  ");
		outputText("The sucking and teasing is relentless, keeping your nipples hard and incredibly sensative as Jojo has his way with you.\n\n");
	}
	//mouthfuck – if shoulder-tentacles are unoccupied – random
	else if(player.biggestTitSize() < 4 && player.biggestLactation() < 2) {
		mouthFucking = true;
		outputText("You feel the bindings around your waist sliding and twisting to free up some of their length.  The pair of tentacle-cocks rear up in front of your face, dripping cum from their tainted purple heads.  One curls around the other, twirling around it until the two tentacles look more like some obscene double-headed dildo.  They smear against your lips, coating them with spunk and begging to be let inside.  Pushing harder and harder, they eventually work your jaw open and cram themselves inside.  An immediate jet of cum paints the back of your throat, nearly gagging you for a moment.  The sensation passes quickly, as if your gag reflex was somehow numbed.\n\n");
		outputText("Twinned dicks force themselves further into your throat, until you are sure they must be outlined and clearly visible to Jojo on your neck.  The mouse-dicks push further in, working their way down to the bottom of your esophagus before pulling back, dripping cum all the while.  Every now and then you get a feeling of fullness in your belly, and realize one of them must have shot off a load of spunk directly into you.  The brutal mouthfuck shows no sign of slowing down, forcing you to gasp in a breath through your nose every time the tentacles pull back.\n\n");
	}
	//Cumsplosion
	outputText("Jojo unleashes a howl of bestial pleasure, and you feel the ");
	if(player.hasVagina()) {
		outputText("tentacles in your " + assholeOrDP() + " thicken perceptibly.  Bulges of cum work their way down the tentacles, spreading your " + assholeOrDP() + " wide before stuffing you full of mouse cream.  You can feel your bowels and uterus filling, expanding you until you look ");
		if(player.isPregnant()) outputText("even more pregnant");
		else outputText("mildly pregnant");
		outputText(".  Your body spasms around them, locked in the throes of orgasm");
		if(player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(", and soaks him with a wave of puss juice.  ");
		else if(player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_SLICK) outputText(", as your drooling cunt forms a slick puddle.  ");
		else outputText(".  ");
		//(If big clit being sucked –
		if(player.cockTotal() <= 2 && player.balls == 0) {
			outputText("The tentacle locked around your " + clitDescript() + " bulges out a bit as your clit throbs from the orgasm, before it sucks harder, making your clitty even larger.  You squeal from the raw sensation until the tentacle pops off, satisfied, leaving your clit looking like an angry red cock.  ");
			player.clitLength += .25;
		}
		outputText("Both tentacles pull out, still dripping whiteness that puddles in your holes.");
	}
	else {
		outputText("tentacle in your " + assholeDescript() + " thickens perceptibly.  Bulges of cum work their way down the main tentacle, spreading your " + assholeDescript() + " wide before stuffing you full of mouse cream.  You can feel your bowels filling, expanding you until you look mildly pregnant.  Your body spasms around them, locked in the throes of orgasm.  The tentacle pulls out, still dripping whiteness that puddles in your well-used hole.");
	}
	//Dick milkings ahoy!
	if(player.cockTotal() > 0) {
		if(player.cockTotal() == 1) {
			outputText("The tentacle working over your " + multiCockDescript() + " clamps down and wriggles deliciously around you.  You can't help but cum from the assault, feeding the tentacle your hot spoogy load.  It drinks it down eagerly");
			if(player.cumQ() >= 100) {
				outputText(", but after a few moments it begins to struggle with the sheer output.");
				if(player.cumQ() >= 300) {
					outputText("  When you finally finish, it's bloated and dripping your cum all over your crotch.");
					if(player.cumQ() >= 600) {
						outputText("  You pump the tentacle so full it turns pinkish-white and bloats obscenely, before suddenly releasing a backflow that soaks you in spunk from the waist down. It drops to the ground limp and spent");
						if(player.cumQ() >= 800) outputText(" but you don't stop cumming until it lies in a deep puddle of jizz");
						outputText(".");
						cumPuddle = true;
					}
				}
			}
			else outputText(".");
		}
		if(player.cockTotal() > 1) {
			outputText("The tentacles working over your " + multiCockDescript() + " clamp down and wriggle deliciously around you.  You can't help but cum from the assault, feeding the tentacles your hot spoogy load.  They drink it down eagerly");
			if(player.cumQ() >= 100) {
				outputText(", but after a few moments they begin to struggle with the sheer output.");
				if(player.cumQ() >= 300) {
					outputText("  When you finally finish, they're bloated and dripping your cum all over your crotch.");
					if(player.cumQ() >= 600) {
						outputText("  You pump the tentacles so full they turn pinkish-white and bloat obscenely, before suddenly releasing a backflow that soaks you in spunk from the waist down. They drop to the ground limp and spent");
						if(player.cumQ() >= 800) outputText(" but you don't stop cumming until they lie in a deep puddle of jizz");
						outputText(".");
						cumPuddle = true;
					}
				}
			}
			else outputText(".");
		}
	}
	//Breastgasm
	if(player.biggestLactation() >= 2 && nippleSucking) {
		outputText("Your " + breastDescript(0) + " squirt milk even harder, pushing the tentacles clear off you with the force of your lactation.  Your " + nippleDescript(0) + "s look like ");
		if(player.nippleLength >= 2) outputText("even larger");
		else outputText("obscene");
		outputText(" cow-teats from all the suction, fountaining milk everywhere as it puddles on the ground.  The milk flow tapers off after a few seconds, leaving you stretched and sore.");
		if(player.nippleLength < 4 && player.breastRows[0].breastRating >= 1) {
			outputText("  Somehow you know they won't shrink the whole way back down to normal.");
			player.nippleLength += .25;
		}
		else outputText("  Somehow you know they won't get any bigger from his rough treatment.");
		outputText("  Your [allbreasts] finally feel emptied; it's a relief.\n\n");
		milkPuddle = true;
	}
	//Titfucking breastgasm
	if(titFucking) {
		outputText("The titfucking tentacles squeeze tighter against your [allbreasts] before they cum again, much harder than before.  Each time it pops free of your flesh, a wave of spunk flows out with it, rolling off your chest to drip into your already soaked face and mouth.  ");
		if(player.cor >= 80 && player.lib >= 70) outputText("You lick your lips and swallow as much of it as possible, wallowing in the mouse-cream.  ");
		if(player.hairLength > 0) outputText("He keeps unloading it until you feel it in your " + hairDescript());
		else outputText("He keeps unloading it until you feel it on your head");
		outputText(", then both tentacles abruptly release, going flaccid.\n\n");
	}
	if(mouthFucking) {
		outputText("A wide bulge forces your jaw apart, distends your throat, and finally empties into your gut, filling you with warmth.  The action repeats until you feel bloated and full, far worse than before as you're now filled from BOTH ends.  You look more like ");
		if(player.canGetPregnant() && player.buttPregnancyIncubation == 0) outputText("an eight month pregnant woman");
		else outputText("a brood-mother immobilized by her growing offspring");
		outputText(" than your old self at this point, and Jojo wastes no time in pulling out to paint your " + faceMuzzle() + " with his baby batter.\n\n");
		cumPuddle = true;
		dynStats("cor", .5);
	}
	outputText("All of Jojo's tentacles seem to lose their strength, and he gently sets your violated body down ");
	if(cumPuddle) {
		if(milkPuddle) outputText("in the puddle of cum and milk");
		else outputText("in the puddle of spunk");
	}
	else {
		if(milkPuddle) outputText("in the puddle of milk");
		else outputText("on the ground");
	}
	outputText(".  You moan in frustration, feeling the fluid soak into your skin, secretly wishing he could've fucked you into unconsciousness.  ");
	outputText("The mouse kneels over you and begins licking your body, cleaning you with his tongue.  The tentacles join in, noisily slurping up every ounce of fluid from your form until you're clean and sated.  Sighing dreamily from the attention, you close your eyes and murmer, \"<i>Good boy.</i>\" When you open them, he's trotting away towards the forest, his tentacles well-hidden again...\n\n");
	player.buttChange(40, true);
	player.cuntChange(40, true);
	player.sexReward("cum");
	dynStats("cor", .5);
	endEncounter();
}

//Jojo milk payments
private function jojoMilkPay(tentacle:Boolean = false):void {
	jojoSprite();
	flags[kFLAGS.JOJO_COCK_MILKING_COOLDOWN] = 4;
	outputText("A loud 'ding' chimes and a panel displays ");

	//Set temp to liter amount produced.
	var payout:Number = 0;
	var cap:Number = 500;
	var cumQ:Number;
	//Ez mode cap is 10x
	if(flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) cap *= 10;
	if(debug)
	{
		flags[kFLAGS.WHITNEY_GEMS_PAID_THIS_WEEK] = 0;
		cap = 9999;
	}
	//Get rid of extra digits
	cumQ = jojoCumQ();
	if(tentacle) cumQ += 40000 + rand(1000);

	//10% randomization
	cumQ -= rand(cumQ/10);
	cumQ = Math.round(cumQ);

	outputText(cumQ/1000 + " Ls.  ");

	//Calculate payout
	if(cumQ > 100) {
		payout = 2 + int(cumQ/200)*2;
	}
	//Reduce payout if it would push past
	if(flags[kFLAGS.WHITNEY_GEMS_PAID_THIS_WEEK] + payout >= cap) {
		payout = cap - flags[kFLAGS.WHITNEY_GEMS_PAID_THIS_WEEK];
		outputText("It also shows a warning: <b>Not enough gems for full payment.  GEMS NOW EXHAUSTED.</b>  ");
	}
	//If over cap!
	else if(flags[kFLAGS.WHITNEY_GEMS_PAID_THIS_WEEK] >= cap) {
		payout = 0;
		outputText("It also shows a warning: <b>FUNDS EXHAUSTED.</b>  ");
	}
	if(payout > 0) {
		player.gems += payout;
		flags[kFLAGS.WHITNEY_GEMS_PAID_THIS_WEEK] += payout;
		statScreenRefresh();
		flags[kFLAGS.JOJO_TIMES_MILKED]++;
		if(payout == 1) outputText(Num2Text(payout) + " gem rolls out into a collection plate.  Whitney really put a lot of work into this!  You pocket the gem and g");
		else outputText(Num2Text(payout) + " gems roll out into a collection plate.  Whitney really put a lot of work into this!  You pocket the gems and g");
	}
	else outputText("You g");
}
public function jojoCumQ():Number {
	var cumQ:Number;
	cumQ = 400;
	if(flags[kFLAGS.JOJO_TIMES_MILKED] < 4) cumQ += flags[kFLAGS.JOJO_TIMES_MILKED] * 200;
	else cumQ += flags[kFLAGS.JOJO_TIMES_MILKED] * 100;
	if (tentacleJojo()) cumQ += 500 + flags[kFLAGS.JOJO_TIMES_MILKED] * 100;
	if (flags[kFLAGS.JOJO_BLOWJOB_XP] < 10) cumQ += flags[kFLAGS.JOJO_BLOWJOB_XP] * 50;
	else cumQ += 500;
	if (flags[kFLAGS.JOJO_SEX_COUNTER] < 10) cumQ += flags[kFLAGS.JOJO_SEX_COUNTER] * 25;
	else cumQ += 250;
	return cumQ;
}

//Jojo - First Time Milking (edited)
public function milkJojoFirst():void {
	jojoSprite();
	var x:Number = player.cockThatFits(40);
	clearOutput();
	if (!recalling) outputText("<b>New scene is unlocked in 'Recall' menu!</b>\n\n");
	outputText("A wicked idea comes to mind, and you call for your favorite mousey ");
	if(tentacleJojo()) outputText("tentacle");
	else outputText("boy");
	outputText("-toy.  He runs up as quickly as he can with his swollen, cum-dripping genitalia. With how big his balls are, it's a wonder he can run anywhere at all.  Jojo's eyes are fogged and lidded, his tongue is hanging out, and he's slowly stroking his swollen meat, moaning with each pump.  You take him by the clean hand and instruct him, \"<i>No cumming just yet, my toy; I'm going to give you a special treat today.</i>\"\n\n");

	outputText("The white-furred mouse mewls in disappointment, but he obeys reluctantly, slowing his constant stroking down to more measured caresses.  Without any further instruction, you start walking towards Whitney's farm, the corrupted vermin trailing behind you like a lost puppy.  The constant, lurid panting is the only clue you have that he's obeying you, though at this point you're confident you've fucked every single ounce of disobedience out of your plaything.  Maybe there's a puddle of it somewhere in the forest, helping to seed a corrupted glade.  No matter, you're almost there.\n\n");

	outputText("Looming over the next hill, you can see the large, well-maintained roof of Whitney's farm.  She does a fantastic job of keeping everything running considering it seems to be primarily a one-woman show.  Whatever the case, it doesn't look like she's near the barn right now.  It's the perfect time to introduce two of your favorite toys to one another!  Tugging on Jojo's ear, you start dragging him down the hillside towards the empty barn.  He doesn't fight at all, moaning and dripping behind you as if he knows what's coming.  Perhaps he learned a little about 'milking' from somewhere before you broke him?\n\n");

	outputText("Sliding easily, the barn door barely creaks as you push it open and send Jojo inside.  You glance around furtively, making sure you weren't seen, and then you close the door behind you.  Jojo has slumped down into some straw and started masturbating again, yanking on his corruption-bloated cock as if it's the only thing in the room that matters.  Slapping his balls to get his attention, you lead him towards your stall.  It's empty and clean as always");
	if(flags[kFLAGS.TIMES_COCK_MILKED] > 0) outputText(", even though it reeks of the spunk you've spilled into the milker's mechanical embrace");
	outputText(".  Jojo shrugs and whines at you, pleading to be allowed to touch himself again.\n\n");

	outputText("You smirk and push him inside, tangling him up in the dangling milk-harness.  The surprised mouse struggles and looks back at you with a mix of confusion and lust warring in his pliant, submissive eyes.  Placing a reassuring fingertip on his nose, you make calming, shushing noises at him as you strap him in properly.  Thankfully the harness is quite adjustable, and you're able to give the corrupt fuck-beast a proper fitting before you milk him.  Each time you cinch one of the bands tight, you make sure to give his balls or his cock a gentle squeeze.  The extra attention keeps Jojo calm as he is increasingly immobilized.  Only one fitting remains to be tightened, and knowing all too well what will happen, you give it a tug.\n\n");

	outputText("As soon as the white slut-mouse is secured, the machinery kicks in.  It starts with the harness whirring and rising, lifting Jojo up high enough that his arms and legs can't scrabble for purchase.  He's going to be completely immobilized the entire time, and there's nothing he can do about it.  Meanwhile, a hatch on the far wall pops open, revealing a tangled nest of wires.  A single hose with a slimy, pulsating texture on its interior worms out of the machinery, slithering across the floor like a snake.  ");
	if(player.hasCock()) outputText("It starts to turn your way before it stops and rises, seeming to sniff at the rodent directly above.");
	else outputText("It slowly starts to rise, seeming to sniff at the rodent above as it orients itself.");
	outputText("  Rising upward and undulating through the air, it closes with Jojo's twitching, dripping erection a second later.\n\n");

	outputText("The purplish-pink interior writhes and jiggles when a droplet of Jojo's pre-cum lands in the hose's moist insides.  It truly does seem to be alive.  Perhaps in reaction to your mouse's leaky, drooling shaft, the milker's hose seems to dilate wider and lurch upward.  It slurps up Jojo's prick in an instant, the only evidence of its rapid dick-devouring being the loud wet 'slurrrp' that still echoes throughout the barn.  The slut boy immediately groans from the onslaught of sucking sensation, trying to pump his hips into the pulsating cock-tube.  Of course, it's a futile effort - the harness holds him quite firmly in place, keeping him nice and immobile while every drop of precious 'milk' is sucked from his body.\n\n");

	outputText("Bouncing up, down, back, and forth, the milker twitches with every change of pressure and beat of Jojo's furiously pounding heart.  He whines pitifully, the sound a mix of begging and intense, erotic pleasure.  You gently caress his twitching sack, letting the heavy orbs roll back and forth between your fingers.  They even bounce from time to time, drawn tight every time the machine edges him closer to orgasm.  What an absolute marvel of demon technology.  It's able to take a body to the very brink of release and then back off.  It keeps the victim on edge as long as possible in order to maximize the user's (or victim's?) eventual 'output'.\n\n");

	sceneHunter.passCheckOnce();
	sceneHunter.selectGender(dickF, vagF, ["Watch", glessF], null, 0,
			player.hasCock(),
			"Need a penis");

	function dickF():void {
		//(Cock - too big!)
		if(x < 0) {
			x = player.biggestCockIndex();
			if(flags[kFLAGS.TIMES_COCK_MILKED] > 0) outputText("You know from experience that machine usually takes an hour before it will allow release");
			else outputText("You figure the machine will probably pump him for quite a while before it allows release");
			outputText(", and you're getting quite turned on from the show.  You shuck your [armor] and pull out " + oMultiCockDesc() + ", feeling ");
			if(player.lust < 50) outputText("it stiffen in your hand");
			else outputText("it's rigidity with your hand");
			outputText(".  For his part, Jojo doesn't even notice.  He just moans, squirms, and twitches any time he's brought particularly close to orgasm.  You sigh, wishing you were small enough to fit inside him, but there's more than one way to fuck a mouse.  Resting your heavy male endowment between his asscheeks, you twirl his tail around your member and turn it into an impromptu cock-ring.  Jojo cranes his head back to see what's going on.  His blush seems to deepen three shades at the sight.  Giving him a wink, you start rocking back and forth.  His ass serves as the perfect hotdog 'bun' while the tightness of his tail keeps your " + cockDescript(x) + " so hard it feels like it could burst.\n\n");
		}
		//(Cock - butt rape!)
		else {
			if(flags[kFLAGS.TIMES_COCK_MILKED] > 0) outputText("You know from experience that machine usually takes an hour before it will allow release");
			else outputText("You figure the machine will probably pump him for quite a while before it allows release");
			outputText(", and you're getting quite turned on from the show.  You shuck your [armor] and pull out " + oMultiCockDesc() + ", feeling ");
			if(player.lust < 50) outputText("it stiffen in your hand");
			else outputText("it's rigidity with your hand");
			outputText(".  For his part, Jojo doesn't even notice.  He just moans, squirms, and twitches any time he's brought particularly close to orgasm.  You smile and push forward, sheathing yourself inside Jojo's spasming asshole.  His happily convulsing muscles clamp tight around you, seizing your " + cockDescript(x) + " in his hot innards.  Swatting his plump, furry cheeks, you start to fuck him, noting that the machine all but stops its rhythmic motions.  It seems pounding Jojo's prostate into mush is as effective at milking his dick as the unholy semen-seeking machinery.\n\n");
		}
		if (!recalling) player.sexReward("no", "Dick");
		sharedEnd(true);
	}
	function vagF():void {
		if(flags[kFLAGS.TIMES_COCK_MILKED] > 0) outputText("You know from experience that machine usually takes an hour before it will allow release");
		else outputText("You figure the machine will probably pump him for quite a while before it allows release");
		outputText(", and you're getting quite turned on from the show.  You shuck your [armor] and reveal your " + vaginaDescript() + ", feeling your " + clitDescript() + " grow firm and hard.  For his part, Jojo doesn't even notice.  He just moans, squirms, and twitches any time he's brought particularly close to orgasm.  Seating yourself down below him, you let your fingers play across your now-wet folds, caressing your labia before you slide a few digits inside.  You brush your thumb against your clitoral hood and shudder from pleasure, enjoying watching your pet get milked as much as he's enjoying the milking.  ");
		if(player.clitLength > 3) outputText("Your other hand grabs your penis-sized 'button' and begins to jack it, the action sending tremors of sensation through your " + hipDescript() + ".  ");
		outputText("Feeling naughty, you sit up straight and lick at Jojo's twitching balls, observing his shame as he squirms on your nose.\n\n");
		if (!recalling) player.sexReward("no", "Vaginal");
		sharedEnd();
	}
	function glessF():void {
		if(flags[kFLAGS.TIMES_COCK_MILKED] > 0) outputText("You know from experience that machine usually takes an hour before it will allow release");
		else outputText("You figure the machine will probably pump him for quite a while before it allows release");
		outputText(", and while you're getting quite turned on from the show, you lack the equipment to take care of your lusts in a satisfactory way.  Meanwhile, Jojo is just moaning, squirming, and twitching each time he's brought close to orgasm.  You sit down and watch the machinery take your mouse-toy to task, wishing you had similar endowments you could be taking care of right now.\n\n");
		if (!recalling) dynStats("lus", 50, "scale", false);
		sharedEnd();
	}

	function sharedEnd(cock:Boolean = false):void {
		outputText("At long last, the appointed time has come, and Jojo lets out the most lewd-sounding squeak you've ever heard come from his mouth.  His ass-cheeks and legs clench and flex against their restraints");
		if (cock) outputText(", squeezing your " + cockDescript(x) + " with agonizingly pleasurable pressure");
		outputText(".  His back arches in ecstasy.  Most noticeably, the tube slurping on his cock is suddenly distorting as thick, round globules of mousey seed are sucked towards the wall.  The bulges are quickly smoothed out into one long, hose-dilating river of rodent-spooge.");
		if (!cock) outputText("  His balls tremble and shrink in your mouth, pumping his prodigious semen out, wasting it in exchange for a pittance of gems.");
		outputText("\n\n");

		if (cock) {
			//(Too big dick:
			if (player.cockThatFits(40) < 0) outputText("You release your cum all over Jojo's back, matting his white fur with cum.  Each successive splatter of spunk makes the mouse look even more like a semen-drenched whore.  It's a good look for him.");
			else outputText("You pull out and release your cum all over Jojo's back, matting his white fur with cum.  Each successive splatter of spunk makes the mouse look even more like a semen-drenched whore.  It's a good look for him.");
		} else if (player.hasVagina()) outputText("You climax and clamp down on your fingers, squeezing your hand as your own cries of pleasure mix with your cock-toy's milked-out moans.");
		else outputText("You sigh wistfully as Jojo ejaculates his load, wishing you could feel such exquisite sensations.  Maybe you can find something to give you some proper sexual organs soon?");
		outputText("  Though he cums for minutes on end, the machinery doesn't seem to have much problem keeping up.  Eventually the hose pops off and drags back towards the wall, leaking a small trail of mouse-spunk on the floor.\n\n");

		outputText("Jojo is lowered to the ground and released.  He immediately nuzzles against you, still trembling from the force of his orgasm and clearly thankful for the treat.  ");

		if (!recalling) jojoMilkPay();
		else outputText("A loud 'ding' chimes and a panel displays 0.864 Ls.  Ten gems roll out into a collection plate.  Whitney really put a lot of work into this!  You pocket the gems and g");

		outputText("o on your way, dragging an exhausted mouse behind you as you head back towards camp.");
		doNext(recalling ? recallWakeUp : explorer.done);
	}
}

private function repeatMilkJojo(tentacle:Boolean = false):void {
	jojoSprite();
	clearOutput();
	//Jojo Repeat Milking - Non Tentacle (edited)
	if(!tentacle || !tentacleJojo()) {
		outputText("You call for your corruption-filled mouse-pet, and Jojo immediately bounds out of the woods on all fours, his bloated dick practically dragging the ground as it dribbles behind him. He looks up at you with eyes full of hope, still remembering the pleasure of his last trip to the farm.  You sigh and say, \"<i>Yes, I'm going to take you for another milking.  Are your balls nice and full?  I expect you to earn me a few gems, my little cum-cow.</i>\"\n\n");

		outputText("Jojo nods his head eagerly and sits up on his haunches, his hand darting down to fondle his dick for you and show you just how much it dribbles now.  He seems to be more than ready for another session.  You start leading him to the farm, listening to him moan and pant behind you.  Drops of pre-cum splatter into the ground with every movement, and you realize he seems to be leaking a little more heavily than the last time the two of you embarked on this journey.  Somehow either the milkers or what you did originally must be slowly increasing his 'productivity' the more he empties out.  Perfect!\n\n");

		outputText("In no time, the two of you are back inside the barn.  Jojo practically leaps into the stall, helping you strap him into the harness in record time.  His dick ");

		if(jojoCumQ() < 1000) outputText("has already dripped everywhere, making a mess of the floor.");
		else if(jojoCumQ() < 4000) outputText("is drizzling a steady flow of man-slime, puddling on the floor.");
		else outputText("is already pouring out a river of pre-cum, turning the floor into a slippery morass.");
		outputText("  The mouse is quickly immobilized and left to hang there, waiting on you to finish strapping him into his place.  You tune out his frantic whines and admire your handiwork.  Jojo is utterly restrained and hanging in the air.  His dick is throbbing and dripping in anticipation.  Even his balls are twitching and shuddering, aching to release their heavy cream.  You give his weighty orbs a squeeze and pull the last strap into place, activating the machinery.\n\n");

		outputText("Your white-furred slut is hauled up into the air, kept up high enough that he can't get any kind of traction.  He can barely move at all!  Well, most of him can barely move - the way his dick is bobbing around makes it clear that no matter how you tie him down, Jojo will find a way to squirm like a bitch.  Once again, the wall pops open and releases a thick tube.  Just looking at the pulsating purple opening, you can tell it will be a near-perfect fit for your fuckpet's throbbing erection.  The faint sounds of suction mix with wet squishes as the hose rises up, homing in on Jojo's bouncing shaft.\n\n");

		outputText("Lunging forward, the tube's opening slips around your mouse's cock-head, slurping it up as the sound of mechanized suction whines higher.  Jojo's own voice rises as well, matching the machine pitch for pitch as he moans in bliss.  Lurid slurps fill the barn as the tube greedily devours the mouse's boner, eventually coming to rest snugly against his groin and bouncing, squirming gonads.  Now that his member has been completely encapsulated by the machinery, Jojo sighs blissfully.  His hips are rocking gently against the restraints, as if it would somehow increase the pleasure coursing through his penis.  You know better - he gets to hang there on the edge for most of the next hour.\n\n");

		outputText("Giving your furry slut's clenching ass a smack, you walk around in front of him, nearly tripping over the bouncing tube as you change position.  Jojo's panting with his eyes nearly rolled back into his head.  Every fifteen seconds or so his body will clench, only to have the cocksucker's motions slow torturously.  He squeals and squeaks each time as if it was the first time.  You scratch him behind his large, dish-shaped ears as words bubble up from within you.  \"<i>Good pet.  You love being milked.  Your balls get so full and heavy... so full of spunk.  They ache, don't they?  Yes... they hurt you so bad.  You get so much cum pent-up in there, and you can't let it out, not without being sucked like this.  Shhh... shhh... it's okay.  Just enjoy how perfectly swollen your balls are getting.  You can let it out eventually.</i>\"\n\n");

		outputText("Jojo's eyes roll the whole way back for a moment, and his mouth begins to froth as he utterly caves in to his animal, pleasure-seeking instincts.  You lean back against a smooth part of the wall and shed your clothes, beginning to masturbate directly in front of your stall.  In time, your own pleasured moans draw your pet from his pleasure-induced stupor, and he watches with wide, bloodshot eyes as you bring yourself off to climax after climax");
		if(!player.hasCock() && !player.hasVagina()) outputText(", even though to do so you're forced to stimulate your " + assholeDescript());
		outputText(".  His twitching rodent-nose sniffs at the air wildly as he pants, inhaling your scent between long, forlorn sounding moans.\n\n");

		outputText("Jojo's muscles seize, and you can tell his orgasm has arrived.  You smirk and lean closer, tugging an ear close to your mouth for another dose of 'encouragement'.  \"<i>Cum for me, pet.  Let all that spunk clogging up your balls boil out into the milker.  Give it all up for me.  Just let out every... thick... pent-up... liter of your seed.  Empty it all!  Cum and squirt until your balls are as empty as your virtue!</i>\"\n\n");

		//(\"<i>Normal</i>\" Jojo cum)
		if(jojoCumQ() < 1000) {
			outputText("Your poor semen-slave does not disappoint.  His balls, looking far more swollen than when you arrived, tremble beneath him in time with his bouncing cock, convulsing as they begin to obey your commands.  Big spheres of cum suddenly distend the hose, stretching it with their liquid weight as they're pumped away toward the wall.  Jojo happily squeaks with each fresh burst he releases, though he rapidly devolves into just constantly screeching and moaning as his dick begins to continually twitch, unloading the rest of his spermy cargo in one thick deluge.  He hangs over the slightly dilated, whirring hose as it slurps down all of his cum.  Eventually, the mouse is totally drained, and his body goes limp in the harness.\n\n");
			outputText("The hose slides off Jojo's softening member and heads back to the wall, trailing mouse-slime as it goes.  At the same time, Jojo is lowered down to the floor.  He stands up on wobbling feet and stumbles down to kneel beneath you.  Looking up, he pants, \"<i>Did I cum enough?</i>\"\n\n");
			outputText("You pat his head and answer, \"<i>Yes, for now.  I expect your swollen balls can do better next time though, can't they?</i>\"\n\n");
		}
		//(\"<i>Big</i>\" Jojo Cum)
		else if(jojoCumQ() < 4000) {
			outputText("Your poor, pent-up semen-slave does not disappoint.  His swollen balls look like heavy grapefruits, only with a much different juice inside them.  Trembling to obey your commands, the hefty spheres bounce and shake, starting to pump out their syrupy rodent-sludge into Whitney's retrofitted demonic machinery.  Just below his swollen tip, the hose massively distends with cum in one climactic moment, accompanied by a squeal of pleasure from your slut.  You can hear the device's humming jump an octave from the heavy load it's being forced to accept, but it seems to manage well enough.  The blob slowly flattens out as it's siphoned down the spunk-devouring tube, just in time for another fat sphere to bloat the hose.  Jojo's eyes roll back, showing you just the whites, and he simply sits and shakes, depositing an inhuman amount of jizm into the milker's ravenous tubing.  After a time, the drained mouse goes limp, his dick still releasing a little more cream even after he goes unconscious.\n\n");

			outputText("Finished, the hose slides off Jojo's hard, cum-drooling cock and retracts towards the wall, leaving a messy trail of mouse-spunk in its wake.  At the same time, Jojo is lowered down to the floor.  He finds his bearings, waking up to stumble over to kneel before you.  Looking up, he pants, \"<i>Was... was that enough?</i>\"\n\n");

			outputText("You pet him affectionately and answer, \"<i>Not too bad, pet.  I still think those balls of yours can do more.  Maybe someday you'll put out so much that the machine can't take it.  Only then will you be cumming enough for me.</i>\"\n\n");
		}
		//(\"<i>Victory</i>\" Jojo Cum)
		else {
			outputText("Your poor, pent-up semen-slave does not disappoint.  His swollen balls are huge and heavy, swaying back and forth as they shudder and shake with the massive amount of jism they've built up.  Suddenly, they convulse in sync, absolutely flooding the milker's tube with a torrential spurt of mouse-cum.  Globules of jizz leak out around the seal at Jojo's crotch, drizzling down his stretched sack to drip to the floor in gooey strands.  The hose doubles in size, more reminiscent of a rubber balloon than a mechanical device.  Jojo is simply cumming far too hard and too fast for the machinery to handle.  Meanwhile, the noise of the milker's motor jumps up three octaves, becoming an earsplitting whine.  With the seal around your slave's cock failing, the tube is starting to slide off.  He really did it this time!  You rush underneath Jojo and grab hold of the tube with both hands, ramming it back up his shaft in time for his next gigantic pulse of cum to wash through the tube.  Some of it sprays out around the seal, but you hang on for dear life as your mouse's amazing orgasm floods into the receptacles.  He quickly slumps in his hardness, but you keep the milker in place until every drop has been siphoned from his body.\n\n");

			outputText("Finally finished, you release the tube and let it slither towards its home in the wall.  It burps out a wave of cum that stains the floor as it goes.  Meanwhile, Jojo's dick is still rock-hard and dumping his alabaster slime.  Once lowered to the ground, he rouses from his state and drops to his knees, right in the middle of his spunk-puddle.  With heavy-lidded eyes, he asks, \"<i>Did I cum enough?</i>\"\n\n");

			outputText("You pet him affectionately and reply, \"<i>Yes you did.  You're such a good cum-slave.</i>\"\n\n");
		}

		jojoMilkPay();

		outputText("o on your way, dragging an exhausted mouse behind you as you head back towards camp.");
	}
	//TENTACLE JOJO MILKING (edited)
	else {
		outputText("You call for your mutated mouse, and Jojo immediately lumbers out of the woods on all fours, his bloated tentacle-cock dragging on the ground and painting a trail of spooge behind it.  He looks up at you with eyes full of hope, two indistinct bulges on his shoulders twitching in excitement as he remembers the last time you took him to the farm.  You sigh and ask, \"<i>I suppose you're thinking that I'll be giving your tentacles a nice, firm milking, huh, slut?  Well it looks like you lucked out today, but you had better cum hard enough with those three cocks to impress me.</i>\"\n\n");

		outputText("Jojo nods his head, his shoulder-tentacles starting to engorge and lift out of his fur, already aching for another session.  You slap one of them, causing them to retract, and start leading him towards the farm.  The whole time he's dripping splatters of pre-cum everywhere, letting his swollen penis drag through the grass and leave a slimy trail in his wake.  What a mess.  You idly wonder if his time in the milkers has increased his virility, but as much cum as he leaks at any given time, it'd be hard to tell without an objective measurement.  Lucky for you, you're about to get one.\n\n");

		outputText("In no time, the two of you have slipped back inside Whitney's barn.  Jojo rushes to the stall, snuggling himself into the harness in no time.  His dick unspools from his crotch, hanging down to the floor while his two shoulder tentacles enlarge, slowly lowering themselves down alongside it.  All three start drizzling pre-cum as you work to buckle him the rest of the way into his harness.  Though he's immobile, he does not sit idly by while you secure his restraints.  Each of the three prehensile penises turns towards you and wraps around your [legs], sliding along your body in a show of perverse affection.  Even his heavy balls are shaking in anticipation.  You give them a gentle caress as the last part of his harness is secured.\n\n");

		outputText("With a sudden lurch, Jojo is lifted towards the ceiling in order to immobilize him for his milking.  Obviously the designers of such machinery did not count on their victims' having lengthy tentacle-cocks.  As soon as the wall panel opens to release the hoses, Jojo's vine-like pricks go into a frenzy, tangling around each other as they await their chance to get milked.  Three hoses snake from the wall, sliding across the floor with odd undulations.  The tentacle-mouse in the harness doesn't seem inclined to wait, and in a blur of movement, he swiftly plugs each of his three penises into an appropriate orifice.  The purple, flesh-like interiors easily accommodate the sudden penetration, at least initially.  Jojo's penises keep pushing, and you're treated to a view of the tubes distending as they're forced to swallow several feet of mouse-cock.\n\n");

		outputText("Smiling, you begin stroking on one of the tentacles where it emerges from his shoulders, encouraging him to stuff yet more penile tissue inside the milker's sucking embrace.  Of course, he's already trying, but the added stimulation can't hurt.  You've truly made this mouse into the perfect fuck-toy.  If only there was a way to suck the pussy-juice from his trio of tail-tentacles, it would be perfect!  Between Jojo's forceful thrusting and the milker's incessant advances, the mouse's three shafts are soon girded in flexible, flesh-lined tubing.  They flail around on the slick floor, motivated by the pulsating bursts of suction and your pet's frenzied spasms.\n\n");

		outputText("You carefully pace around the edge of the stall, moving carefully to avoid tripping up on the wildly-waving hoses.  Once you get in front of him, you grab the mutant rodent's ear and begin to whisper instructions to him.  \"<i>You need to flood this machine, pet.  Feel all that jizz, feel it building up inside you, backing up inside your swollen, cum-heavy nuts.  You're just filling up with spunk, aren't you?  Good.  Stay there and enjoy the cock-massages while you watch me masturbate.  I expect you to be messy enough to need a mop when we're done, understand?</i>\"  There's a dark undercurrent to your words, similar to the one you used when initially corrupting the mouse.  It destroys any doubts you had about his output - he'll be every bit as messy as you instructed him to be.\n\n");

		outputText("Leaning back, you let your fingers casually attend to your own growing needs.  Seeing Jojo's extraordinary form succumbing to its lusts has stirred up some arousal within your own ");
		if(player.gender > 0) outputText("loins");
		else outputText("body");
		outputText(".  You close your eyes and forget about the mouse, stripping out of your clothes to expose your nudity to questing hands.  As you work yourself into a sexual frenzy, you become more aware of Jojo's lusty, panting gaze on your exposed skin.  ");
		if(flags[kFLAGS.PC_FETISH] > 0) outputText("An exhibitionist thrill shivers through you at the thought of being watched while engaged in such a carnal act.  ");
		outputText("Your climax comes as fast as it is hard, breaking over you in a concussive wave of bliss.\n\n");

		outputText("Blinking the stars from your eyes, you look up to see Jojo hanging there, panting and shaking.  The ever-present mechanical hum incrementally increases in pitch, climbing all the way to a keening wail that would put a banshee to shame.  Swollen bulges of cum are coursing through the tentacle-slut's members, distending the shafts and the tubes struggling to encapsulate the newfound girth.  Jojo's eyes roll back while frothy spit drips from his open maw and dangling tongue.  His body strains at the harness' bindings, the huge, dangling orbs between his legs visibly contracting as their cargo is released.  Semen bubbles from the seals at the edges of hoses as your pet drowns the cock-milker in spooge.  Gauges on the wall rapidly switch to 'F', one after another.  The last meter tops out, and then the pressure is blasting the suckers off his dicks, sending the sperm-packed machinery flying from the sheer, cummy pressure.\n\n");

		outputText("Jojo sags down in the harness while his members finish releasing their load.  The leftovers from his orgasm easily fill the stall with at least a foot of cum.  You sigh at the realization that both you and your clothes are utterly drenched.  The harness unceremoniously dumps Jojo into the puddle of his own making, and as he rises, he hugs your [legs] and says, \"<i>Thank you.  Did... did I cum enough?  I'll do more next time, I promise!</i>\"\n\n");

		outputText("You scratch his jizz-slicked fur and let him know that he did great.  ");
		jojoMilkPay(true);

		outputText("o on your way, dragging an exhausted mouse behind you as you head back towards camp.");
	}
	player.orgasm();
	endEncounter();
}
//Use Jojo to pay for Hair Care
private function jojoPaysForPerms():void {
	jojoSprite();
	clearOutput();
	outputText("Lynnette the goblin answers the door and lets you in, waving you deeper into her shop.  Her shining black dress barely contains her fertile-hips and jiggling chest as she greets you, \"<i>Welcome back honey!  Who's the cutie?</i>\"\n\n");

	outputText("You answer that your pet mouse, Jojo will be taking care of payment for you today.  Lynnette looks doubtful, but she quickly drops to her knees in front of the mouse, determined to get her payment one way or another.  Jojo's forearm-length erection immediately makes itself apparent.  The goblin matron coos at the sight, humming happily once she sees the rivulets of pre-cum streaming down your slut's cock.  In one smooth motion, she devours the heavy mouse-shaft, sliding her lips down all the way to the base.\n\n");
	outputText("Jojo moans and reaches for Lynnette's hair, but you stop him with a sharp command.  He's paying for your services today, not getting a reward.  Big, lusty eyes look up at him from his loins, and he shudders, his heavy balls clenching and relaxing from the goblin's perfect throat-fuck.  She reaches up to caress them, ");
	if(jojoCumQ() >= 4000)
		outputText("and releases a surprised gurgle when she feels just how heavy and full they've gotten.  All that time at the milker has clearly done Jojo's body good, and Lynette is likely to leave with a mouse-milk mustache.");
	else if(jojoCumQ() >= 1000)
		outputText("and releases a surprised gurgle when she discovers their size.  Clearly all the trips to the milker have given Jojo an impressive set of testes.");
	else outputText("and rolls them back and forth in her fingers, expertly pleasuring Jojo.");
	outputText("  In no time flat he's reached the edge of his endurance.\n\n");

	outputText("Lynnette, for her part, has two wet stains on her blouse, but she ignores them as she gives the mouse's nuts a gentle squeeze.  He cums easily and hard from that little bit of extra stimulation.  The goblin's throat works to devour it all");
	if(jojoCumQ() < 1000)
		outputText(", readily swallowing most of it.  After a short time, she pulls back and lets him finish by filling her mouth.  In turn, she spits the sticky mess into a funnel that leads to who-knows-where.");
	else if(jojoCumQ() < 4000)
		outputText(", swallowing as much as she can.  Still, Jojo is pumping out enough that Lynette's belly quickly grows even more gravid, and the semen froths at the edges of her lips.  Eventually she just gives up and pulls off, aiming him at a funnel.  She keeps stroking his spit-slicked shaft as he's drained off that way, the goblin's grin growing a touch manic at the sight of that much seed being collected.");
	else
		outputText(", but there's no way she can keep up with Jojo's ridiculous cum-production.  Two jets of seed leave her belly stretched to its limit, and the goblin matron quickly pulls back with a panicked look in her eyes, barely aiming Jojo's spunk-sprayer at the funnel in time for it to be filled by the next blast.  Watching with rapt attention, the green-skinned girl smiles wider and wider when she realizes just how much your pet can produce.  It's quite some time before his flow tapers off, but Lynnette doesn't seem to mind at all.");
	outputText("  Perhaps one of her daughters has the other end of that pipe jammed into her pussy?\n\n");
	outputText("Lynnete pants");
	if(jojoCumQ() >= 1000 && jojoCumQ() < 4000)
		outputText(" with a smile");
	else if(jojoCumQ() >= 4000)
		outputText(" with a dazed, crazy-looking smile");
	outputText(", \"<i>What'll it be today?</i>\"\n\n");
	SceneLib.mountain.salon.salonPurchaseMenu();
}

//Scene 1: Amily Teaches Jojo How To Give Blowjobs. (Z)
private function amilyTeachingJojoBJ():void {
	clearOutput();
	//First time version
	if(flags[kFLAGS.TIMES_AMILY_AND_JOJO_PLAYED_TIMES] == 0) {
		outputText("Your pet mice make an appearance as you're plotting your next move, Amily practically dragging Jojo behind her, ignoring the thick ropes of spunk he drizzles on the ground in his path.  He pants and whines, \"<i>-don't wanna suck cocks!  Fucking is totally better.</i>\"");
		outputText("\n\nAmily turns about and boxes his rebellious little muzzle.  \"<i>You need schooling in how to properly please our [master].  Do you honestly think [he] will be satisfied with just plowing your ass or riding your thick... drooling... cock...</i>\" Amily's question trails off as she reaches down to caress Jojo's ever-present, cum-slicked boner.");
	}
	//Repeat
	else {
		outputText("It seems Amily and Jojo are together again, this time in the center of the camp.  Amily is holding Jojo's swollen balls in one hand as she graphically explains how a proper slave should swallow every drop of cum in order to please his [master].  Jojo is panting, his tongue lolling from his mouth as he absently agrees with Amily's particularly pleasurable demonstration, too focused on her fingers to pay attention to her words.");
		outputText("\n\nThe corrupted girl's demon-like tail swishes angrily, and she squeezes his throbbing sac as she chides, \"<i>Are you even listening, cum-for-brains?!</i>\"  A thick rope of pre-spunk squirts from Jojo's cum-slit, splashing against her chin and sending a bone-deep shudder down her spine and into her over-sexed loins.");
	}
	flags[kFLAGS.TIMES_AMILY_AND_JOJO_PLAYED_TIMES]++;
	//Universal Outro
	outputText("  She seems visibly distracted by the mouse's boner, and will likely wind up fucking him soon.");
	if (player.hasCock()) outputText(" Do you surprise them both by allowing Amily to demonstrate on you?");
	else outputText(" Do you want to watch them fuck?");

	menu();
	addButton(0, "Demonstrate", BJRidesGETYOUONE).disableIf(!player.hasCock(), "Req. a cock!");
	addButton(1, "Watch", amilyAndJojoFuck);
	addButton(4, "Leave", playerMenu);
}
//Scene 1 Result: Male Gets BJ (Z)
private function BJRidesGETYOUONE():void {
	amilyScene.amilySprite();
	clearOutput();
	outputText("You step into view and knowingly ask just what all the fuss is about.  Amily meekly prostrates herself before you, apologizing, \"<i>I'm sorry, [master], I merely wanted to help your boyslut learn to satisfy your needs better.</i>\"  You wait, just long enough to make her nervous.  The pregnant pause hangs in the air as both your murine whores look increasingly worried, their large, radar-like ears twitching fitfully about as they await your response.  Laughing, you undo your [armor] and ask Amily how she planned to teach without a proper 'teaching tool'.");
	outputText("\n\nThe succubus-tainted mouse looks up at you with lust pooling in her large, languid eyes.  \"<i>As you command, [master],</i>\" she whispers eagerly as she rises her feet, her spaded tail curling behind Jojo's neck, dragging him closer to you.  Flopping free, [oneCock] dangles enticingly in the air before them, swaying back and forth to a rhythm that seems almost hypnotic to your poor, corrupted sluts.  They zero in on your [cock biggest] as if it were the only thing in the world.  Even Jojo's reluctant attitude evaporates when faced with the irresistable allure of your swinging manhood.  He sits at your [feet] as eagerly as his teacher, his expression an ecstatic portrait of mesmeric cock-worship.");
	outputText("\n\nTaking your [cock biggest] in hand, Amily begins to caress it in adoring reverence before beginning her lecture.  \"<i>It's important to make sure you've gotten your [master]'s attention before really getting into it, particularly if [he] isn't fully hard yet.  As you can see, [name] is already pleased by my devotion to [his] cock.  Of course, the direct approach can often work just as w-</i>\"  Amily cuts herself off by jamming ");
	if(player.biggestCockArea() > 50)
		outputText("as much of your [cock biggest] as possible");
	else
		outputText("your entire [cock biggest]");
	outputText(" into her mouth and throat.  The tight warmth of your pet's puffy, corruption-engorged cocksucker shoots tingling thrills of delight through your maleness, and as she's careful to guide the sensitive underside along her tongue as she swallows, [eachCock] soon stiffens to a full, throbbing erection.  You cannot help but groan at the skillful sucking, and when Amily pops off a moment later, she looks quite pleased with herself.");
	outputText("\n\n\"<i>Our [master] very much enjoys the wet suction of a skilled mouth and gratifying [him] is a decadent pleasure in and of itself.  Just taking [him] inside my lips makes me so wet!</i>\" Amily cries as she resumes stroking you.  Jojo glances away from the handjob long enough to see the streamers of girl-honey hanging from Amily's nethers, and he moans lustily.  Amily barely notices, too intent on pleasuring your [cock biggest] to worry about Jojo's inattentiveness.  She jacks your spit-soaked tool with neat, even strokes all the way from [sheath] to [cockHead biggest].  Sighing, you edge your [hips] forwards to give her better access to and encouragement from your excited loins.");
	outputText("\n\nSensing your need, Amily begins to pump faster as she continues her instruction, \"<i>You have to pay attention to your [master]'s body when you do this.  See the little twitches, how [his] [hips] and shaft are bouncing for [his] little slut?  That means I'm being a good cum-slut.  I made [his] cock happy.</i>\"  Jojo nods and licks at his lips, watching in rapt study as Amily enthusiastically tends to your throbbing tool.  \"<i>You can't slow down here,</i>\" Amily continues, before spitting on her other hand and raising it to fondle your long member.  Your glossed prick slides easily through Amily's pink palms, filling the air with a wet squishing that brings drool to the lips of your mice.");
	outputText("\n\nJojo leans closer and closer to his female counterpart while the other works, nuzzling so close that they're soon cheek to cheek, ears flat against each other.  The feminine cum-junkie graciously points your [cock biggest] towards the former monk, and he nervously licks at your [cockHead biggest], each lap faster and more eager than the one before.  Soon he is slurping the entire tip into his maw and letting Amily squeeze the pre-cum onto his wiggling tongue.  Jojo's eyes cross to better watch the pumping passion under his nose, while your other cum-slut eggs him on with lewd, encouraging remarks. \"<i>You're a natural cock-sucker, Jojo.  The demons were right about us... we're meant to serve the powerful.</i>\"  She sighs and whispers, \"<i>...our [master].</i>\"");
	outputText("\n\nYou groan at the dual sensations assaulting your [cock biggest].  Four eyes look up, happily twinkling as they service you, their eager devotion nearly drawing your orgasm right there, the temptation to gush your jetting spunk into their whorish little ");
	if(flags[kFLAGS.AMILY_NOT_FURRY] == 1)
		outputText("mouths ");
	else
		outputText("muzzles ");
	outputText("almost too great to resist.  Amily seems to sense this, obediently offering their bodies for your release. \"<i>[Master], would you like to fill your cum-slut's pussy or mouth?  Or maybe you want to give your bitch-boy a taste?</i>\"");
	//[Cum in Amily Mouth] [Cum in Amily Pussy] [Cum in Jojo Mouth]
	outputText("\n\nWhere do you cum?");
	//Pussy requires a minimum tallness?
	var puss:Function = null;
	if(player.tallness > 55) puss = stuffAmilysMouthWithPostBJCUM;
	simpleChoices("Amily's Mouth", fillAmilysMouth,
					"Amily's Pussy", puss,
					"Jojo's Mouth", fillJojosMouthWithHotStickyCum,
					"", null,
					"", null);
}
//Fill Amily's Mouth (Z)
private function fillAmilysMouth():void {
	amilyScene.amilySprite();
	clearOutput();
	outputText("You tell Amily to open wide, and she gleefully yanks your [cock biggest] away from Jojo.  He whines pathetically but, servile as he is, the mouse-boy");
	if (player.hasBalls()) outputText(" leans down to desperately suckle at your [sack], subserviently worshipping your bloated testes and their liquid bliss one after another; tonguing, sucking, and moaning into the spunk - bloated mass of your ambrosial scrotum.");
	else outputText(" leans down to slurp needily at the bottom of your cock, licking it with languid tongue-strokes each time Amily gives him an opening.");
	outputText(" Amily looks up at you, her cute, succubi - like horns glinting in the light as she purrs, \"<i>Please, [master], give slut a throat-thick load to swallow.  Fill your nympho's mouth-pussy with sticky baby batter and splatter her whorish face with oozing leftovers.</i>\"");
	outputText("\n\nThe mousette's chemically-engorged lips spread into an 'o', then happily devour most of your dick's straining length, leaving room at the base for her hands and Jojo's tongue to work.  She pumps you hard and fast, and you feel the telltale twitching of your internal muscles, signaling the crest of your onrushing orgasm.  Your [hips] jerk spasmodically as the pleasure overwhelms your control, but Amily holds on like a pro.  She slides her hot, wet little tongue along your member's underside again as your urethra fills with goo, and in one explosive moment, you propel the thick rope of seed hard into the hungry addict's throat.  You see her jaw work breathlessly as she swallows [if (cumQuantity >= 250) most of|all of] it.  You cum and cum for her, packing her worthless throat with your gushing cream, unloading even as she does her best to wring you dry (with Jojo's help).[if (cumQuantity >= 500) \"  Before long, her belly is nicely rounded from all the seed she's swallowed, a happy little bump visible on her lithe frame.\"][if (cumQuantity >= 1000)   Too full to keep drinking, she releases your [cock biggest] with a zestful gasp and gladly takes the next spurt directly on her face and hair.  The huge blob of cum soaks her ardent features, cataracts of jism cascading lazily towards the ground.][if (cumQuantity >= 3000) \"  You keep blasting her with ever-greater volumes of spooge until she's stained completely white with gobs of spunk and lounging euphorically in a deep puddle of it.\"]");
	outputText("\n\nThe sperm-filled girl burps and turns to kiss Jojo, the once-pure monk eagerly returning the embrace and getting a good taste for your seed as Amily fervently tongues it into his mouth.  She eventually pulls back to encourage him with an overwrought sigh. \"<i>Maybe if you service [master] better you'll be allowed to receive [his] seed next time.</i>\"  Jojo pants and licks at his lips, hands darting down to tend to his long-neglected phallus.");
	outputText("\n\nYour personal whore laughs and hugs your leg, whispering, \"<i>Cum-slut thanks you, [master].</i>\"  You pull her up and smile at her, glad she's working to make your budding harem as sexually adept as possible.  She beams and grabs Jojo with her tail, no doubt eager to drag him off for more training.");
	player.sexReward("saliva");
	endEncounter();
}
//Fill Amily's Twat (requires not short-ass, weak-ass nigga) (Z)
private function stuffAmilysMouthWithPostBJCUM():void {
	amilyScene.amilySprite();
	clearOutput();
	outputText("You tell Amily to hurry up and climb on.  With a squeak of joy, she bounds up into your arms, immediately sinking her plush little pussy onto your lap and swallowing your cocktip.  Surprising you with her control, she holds herself like that, restraining herself from taking in your whole [cock biggest] and instead bouncing up and down atop your peak while Jojo attends to the lower portion of your manhood with his eager tongue.  He tentatively licks along the swell of your shaft, sucking at the sensitive underside and planting desperate kisses over your length, lapping up Amily's freely flowing juices as she rides the crest of your pulsing tip.  The mouse-girl's ears tickle as they brush against you, her voice husky with desperate need.  \"<i>Please, [master], give slut your seed.  Her cunny needs to be filled sooo badly.  Make me your pregnant, baby-bloated whore, [master]!</i>\"");
	outputText("\n\nAs if you'd resist such an invitation!  You squeeze your demon mouse tightly and push her further down, impaling her juicy snatch ");
	outputText("on your rigid fuck-tool");
	outputText(".  She squeaks in surprise, her yelp turning into a high-pitched moan as your [cockHead biggest] widens in preparation for your looming orgasm.  Spunk forces your cum-slit open and sprays into Amily's clenching uterus, gorging her lascivious cunt with the virile seed it craves.  You hold her, impaled and squirming, as you continue to spray, inseminating her moist twat with squirt after squirt of oozing cock-nectar.[if (cumQuantity > 500)   Her belly rounds out delightfully from the extra stuffing.  You run a palm across it and smile when you feel your sperm churning under her stretched skin.][if (cumQuantity >= 1000) \"  Rivulets of spooge run from her overflowing pussy in thick cascades of pearl goo.  Jojo does his best to keep up, but even his growing lust for swallowing your cum can't match the volume of the salty surf foaming from the spasming girl's flush pussy.\"][if (cumQuantity >= 2000) \"  Amily's eyes roll back in complete pleasure as the pressure of your cum begins to cause the ejaculate to spout from her spunk-laden twat.  Jojo gives up on swallowing it all and leans back, opening wide to catch as much as possible as your second-hand seed showers the fallen monk, an ivory rain of hot slime splattering from your freshly stuffed slut's cream-sated cunny.\"]");
	outputText("\n\nSatisfied, you pull out and let Amily's insensate body slide off into the dirt.  She shivers and cups her box, trying to hold all the jizz inside her leaky quim as she comes down from the bliss of being your personal cock-sleeve.  Smirking, you work on getting dressed.  By the time you're ready to go, you realize Amily has stirred enough to pull Jojo between her legs.  His muzzle is lodged deep into the cum-slut's pussy, and she's moaning words of encouragement nonstop.  \"<i>Good boy... lick up [master]'s cum.  Savor its taste, its texture.  Don't worry, you'll never get it out of my womb.  Just drink it down, and maybe - if you're a good little bitch - [master] might let you have the next load.</i>\"");
	outputText("\n\nYou leave them behind with a spring in your step.  With a dedicated slave like that training your harem, you have no doubt that you'll be well taken care of.");
	player.sexReward("saliva");
	dynStats("sen", -1);
	//{DONT FORGET PREGNANCY CHECK}
	amilyScene.amilyPreggoChance();
	endEncounter();
}
//Fill Jojo's Mouth (Z)
private function fillJojosMouthWithHotStickyCum():void {
	jojoSprite();
	clearOutput();
	outputText("You point at Jojo and command, \"<i>Open wide.</i>\"  The former monk happily opens his muzzle broadly, so far open that his buck-teeth practically vanish into the roof of his mouth.  Amily looks disappointed, but then she consoles herself by [if (hasBalls = true) sinking down to covetously suck your swollen balls while ]tugging on your shaft, squeezing it from stem to stern with hard, fast pumps.  Jojo's tongue slips out to lick the beading pre-cum from your [cock biggest] as it flexes powerfully in the other slut's grip.  Warmth races through your loins as you feel your orgasm approaching.\n\nAn explosion of bliss burns in your head as [eachCock] spews its load.  Thick waves of pent-up jism spray out from your cum-slit, filling Jojo's mouth with honey-thick cream, and splatter across his nose and hair.  ");
	outputText("He gurgles as his mouth fills with your musky spunk and opens wider, keenly trying to catch as much of your seed as possible with his cum-dribbled face before he slurps it down in one sputtering gulp. "+(player.cumQ () >= 1000 ? "He swallows, taking a blast of spunk across his brow, and opens up again, giving you another hole to aim for.  Another eruption of your virile seed rushes past his lips and coats the back of his throat in your fluid ivory, nearly drowning him as the column of jism gushes into his windpipe and up his nostrils, surging out of his nose.  The domesticated mouse gulps desperately at your slimy passion while your fountaining cum arcs to dump fat globs on his shuddering body":"You "+(player.cumQ () >= 500 ? "spurt again and again, splattering heavy ropes of goo across his face and fur.  His mouth floods, too full of jizz to contain it all, giving the vanquished monk a thick glaze of cum that very quickly leaves his body with an oily sheen":"discharge your alabaster lacquer again and again, whitewashing his already pale fur until his face seems little more than a glistening mask, dripping with your seething unguent.  Bound to your will, he patiently awaits your permission to swallow, his pacified mouth full to the brim, leaking out the sides in twin ivory cascades. You nod curtly and the tamed mouse-boy obeys happily, savoring the humbling salt of your overpowering jizz as it rolls down his throat")+"")+".  You finish and shove your [cock biggest] into his throat for cleaning.  Jojo happily obliges.");
	outputText("\n\nWhile one of your mouse-toys is polishing your rod, the other is masturbating and panting.  \"<i>Please, [master], may I... may I have some cum?  Can I... I lick him clean?  He's so...</i>\"  She inhales and luridly moans, \"<i>...messy.</i>\"  You give her your assent as you withdraw your spit-shined pecker from Jojo's maw, not caring how the two of them get their rocks off so long as your harem is kept well-trained and willing.");
	player.sexReward("saliva");
	dynStats("lib", -1, "cor", 1);
	endEncounter();
}

//Scene 2: Amily And Jojo Fuck (w/o Tentacles) (Z)
private function amilyAndJojoFuck():void {
	jojoSprite();
	clearOutput();
	outputText("You find a nearby rock to perch on as the two mice begin to get more lewd with their actions.  Amily uses her tail to sit Jojo down in front of her, squeezing his taut balls in her hand and gasping when he spews a thick stream of pre-cum.  You use the commotion as cover to squeeze out of your [armor] and get comfortable.  Thankfully, neither of them hears you, or if they do, they don't care.  Amily titters, \"<i>Wow, no wonder [master] keeps you around with a cum-fountain like that!</i>\"  She gently traces a fingertip along the swollen underside of Jojo's cock, giggling when he, over-stimulated, immediately starts dripping fluid on her fingers.");
	outputText("\n\nJojo moans, \"<i>Ugh... stop... please Amily, please, can I cum?</i>\"  Amily jerks and shakes her head in disappointment.  She mouths, \"<i>Not yet,</i>\" and stands back up, turning around and pulling Jojo's muzzle into her slippery twat with her demonic tail.  The former monk's protests are muffled by Amily's sodden quim, and he soon begins to eagerly slurp at her drooling cunny.  With each enthusiastic lick, she reaches between her knees to caress Jojo's corruption-engorged cock, egging him on to please her more thoroughly.");
	outputText("\n\n\"<i>R-right there,</i>\" Amily moans, \"<i>Lick my clit!  Suck it!  Suck it bitch!</i>\"  Jojo reaches around her to find her tits, and he begins to knead them in his hands while he eats her out, matching his movements to the rhythm of his graceful tongue and the pulsing suction of his mindless lust on her drenched joybuzzer.  She shudders and cries out in euphoric mastery. \"<i>Yes!  Fuck yes!  Good bitch! GOOD BIIITCH!</i>\"  Jojo's muzzle and face darken from a sudden onslaught of moisture, and you realize Amily has just cum so hard her gushing orgasm has soaked his face with her glistening honey.  She tumbles down onto her hands and knees, groaning and shuddering as the spasming climax wracks her body and mind.");
	outputText("\n\nJojo sees his opening, and with surprising speed, he's up and on top of Amily, mounting her from behind like a beast in rut.  Even as far away as you are, you can hear the wet squelching sound of his massive dick spearing through Amily's sopping folds, even louder than Amily's lascivious exultations of pleasure.  For one with such a small frame, Jojo's movements have surprising confidence and strength.  His white-furred hips start to thrust into Amily with hard, fast motions.  Without the leash of a dominating partner, he's become like a feral animal, fucking her with no regard for her pleasure- only the suffocating, all-consuming need to BREED.  The soft patter of mousey cunt-juice splattering on the ground alerts you to Amily's shared urgency - she's getting off on being mindlessly ridden like a beast, coarsely degraded and carnally ravaged like the worthless cum dump she's willingly become.");
	outputText("\n\nThe succubus-like mouse's restless demonic tail twitches back and forth between Jojo's legs, then strikes, serpent-like, towards his distended cum-sack.  It twists around the top of his scrotum, pulling it tightly to perfectly outline the shape of his massive gonads through the lightly-furred skin.  Distressed by the new development, yet not slowing from the rapid pace of his bestial pounding, he throws his head back and releases a shrill, feminine squeak of impotent displeasure.");
	outputText("\n\n\"<i>Don't... unf... be a... unf... baby,</i>\" the demonic woman chides in between each jarring impact against her snatch, \"<i>I don't... uh... want... oooh... you cummMMING... ahhh... too soon.</i>\"");
	outputText("\n\nOf course, hearing her voice rise and fall in time with his frenzied pounding drives Jojo onward, fueling the mad fires of his perverted lust.  The mouse's hips pump faster, and Amily's entire body begins to tremble from the force of his blows.  His bound nuts sway dangerously, slapping noisily against Amily's sodden mons with each hard smack of his swollen girth.  The girl stops doing much of anything but moaning and shaking from the experience, her voice finally muffled into grunts and squeaks of muted enjoyment as the relentless mouse-boy tames the over-bold female, breaking her to the dominating frenzy of his squelching bitch-tamer.");
	outputText("\n\nJojo grabs her hair and pulls as he fucks her, growling against her ear.  You can see his balls bobbing and twitching through their bondage.  They're trying so hard to cum, and yet, Amily's vice-tight tail is keeping all that spooge bottled up inside them.  Jojo's sack even appears to be swelling under the pressure of their liquid weight.  In his frenzied desperation, the male mouse begins to nip and bite Amily's ears, bringing her to heel with the feral gesture of dominance.  It seems to pay off, as the corrupted mouse-girl begins to shiver and shake, losing a bit of her muscle control as she orgasms.  Her tail loosens, not completely, but enough for Jojo's visibly-pulsating nut-sack to unleash the tidal-wave of spooge that's been backing up inside and force it open.  You see his eyes clench, and then Amily's belly begins to bulge slightly.  His hips shiver, and the bulge grows.  It goes for what seems like ages - Jojo giving little shifts and sighs of pleasure, Amily's belly becoming more and more pregnant with cum.  It doesn't really sink in just how big she's gotten until you realize her belly has touched the ground.  It trembles and wobbles with fluid girth before the former monk has finally had enough and withdraws to hose her down with the last few thick strands of his seed.");
	outputText("\n\nJojo stands back and smiles, observing his handwork.  His dick never even goes soft.  If anything, you see his balls swelling back up to their normal size - well, the norm since you changed him.  He starts leaking pre again, and as he runs off towards the woods, you have to wonder if he's off to visit the flower in the corrupted glade.  Amily lies on her side and cradles her cum-stuffed belly, squeaking soft bleats of happiness as she tries to recover.");
	outputText("\n\nYou stealthily slide down the rock and get dressed.");
	if (player.hasVagina()) outputText(" It isn't until you notice how wet your crotch is that you come to the realization that you've masturbated yourself through a few orgasms as well.");
	else outputText(" It isn't until you notice how clearheaded you are that you come to the relaization that you've masturbated while watching the pair.");
	outputText(" Maybe you'll get to catch them in the act again?");
	player.orgasm();
	//{DONT FORGET PREGNANCY CHECK}
	//amilyPreggoChance();
	endEncounter();
}

public function jojoFollowerMeditate(doClear:Boolean = true):void {
	jojoSprite();
	if (doClear) clearOutput();
	if (flags[kFLAGS.JOJO_LAST_MEDITATION] == model.time.days) {
		outputText("Jojo smiles and meditates with you.  The experience is calming, but it's so soon after your last session that you don't get much benefit from it.");
		dynStats("lus", -30, "scale", false);
	}
	else {
		outputText("The mouse monk leads you to a quiet spot away from the portal and the two of you sit down, him cross-legged and you mimicking to the best of your ability, back to back.  You close your eyes and meditate for half-an hour, centering your body and mind.  Afterwards, he guides you through stretches and exercises to help keep your bodies fit and healthy.\n\nWhen you are done, Jojo nods to you, and climbs back onto his rock, still thinking.");
		//Reduces lust
		dynStats("lus", -30, "scale", false);
		var cleanse:int = -2; //Corruption reduction - faster at high corruption
		if (player.cor > 80)
			cleanse -= 3;
		else if (player.cor > 60)
			cleanse -= 2;
		else if (player.cor > 40)
			cleanse -= 1;
		dynStats("cor", cleanse - player.countCockSocks("alabaster"));
		player.trainStat("str", +1, player.trainStatCap("str",50));
		player.trainStat("tou", +1, player.trainStatCap("tou",50));
		player.trainStat("spe", +1, player.trainStatCap("spe",50));
		player.trainStat("int", +1, player.trainStatCap("int",50));
		player.trainStat("wis", +1, player.trainStatCap("wis",50));
		player.trainStat("wis", +1, player.trainStatCap("wis",100));
		flags[kFLAGS.JOJO_LAST_MEDITATION] = model.time.days;
		player.addStatusValue(StatusEffects.JojoMeditationCount, 1, 1);
	}
	endEncounter();
}

		public function jojoDefenseToggle():void {
			jojoSprite();
			clearOutput();
			if (player.hasStatusEffect(StatusEffects.JojoNightWatch)) {
				player.removeStatusEffect(StatusEffects.JojoNightWatch);
				outputText("You tell Jojo that you no longer need him to watch the camp at night.  He nods, then speaks.  \"<i>Alright.  Please let me know if you require my help again.</i>\"");
			}
			else {
				player.createStatusEffect(StatusEffects.JojoNightWatch, 0, 0, 0, 0);
				outputText("You ask the monk if he could guard the camp for you at night.  He smiles politely.  \"<i>Certainly, [name].</i>\"");
			}
			doNext(jojoCamp);
		}

		public function jojoAtCampRape():void {
			jojoSprite();
			player.removeStatusEffect(StatusEffects.JojoNightWatch);
			player.removeStatusEffect(StatusEffects.PureCampJojo);
            monk = JOJO_MET; //reset, preparing to the first rape
			clearOutput();
			outputText("You ask Jojo if he'd like to go on a hunt through the woods to clear out some of the corrupted creatures, and the mouse readily agrees.  He asks if you've been getting a bit stir-crazy from having your camp in one place as the two of you walk into the woods...");
			menu();
			addButton(0, "Next", jojoRape);
		}

		public function defeatedJojo(hpVictory:Boolean):void {
			jojoSprite();
			if (player.lust > 33 && player.gender > 0) {
				clearOutput();
				outputText("You smile in satisfaction as Jojo" + (hpVictory ? " collapses, unable to continue fighting" :" collapses and begins masturbating feverishly") + ".  Sadly you realize your own needs have not been met.  Of course, you could always rape the poor thing...\n\nDo you rape him?");
                doYesNo(postCombatRape, SceneLib.combat.cleanupAfterCombatImpl);
            }
			else {
				combat.finishCombat();
			}
		}

		private function postCombatRape():void {
			jojoSprite();
			outputText("  You disrobe and prepare to ");
			if (monk == 5)
				outputText("fuck your violent little slut senseless.  ");
			else outputText("teach the uppity monk a lesson...\n\n");
			menu();
			addButton(0, "Next", jojoRape);
		}

		public function jojoRape():void {
			jojoSprite();
			//Track Jojo rapeage
			if (!player.hasStatusEffect(StatusEffects.EverRapedJojo))
				player.createStatusEffect(StatusEffects.EverRapedJojo, 1, 0, 0, 0);
			else player.addStatusValue(StatusEffects.EverRapedJojo, 1, 1);
			switch (monk) {
				case JOJO_MET:
					jojosFirstRape();
					break;
				case JOJO_CORRUPT_1:
					jojosSecondRape();
					break;
				case JOJO_CORRUPT_2:
					jojosThirdRape();
					break;
				case JOJO_CORRUPT_3:
					jojosFourthRape();
					break;
				case JOJO_CORRUPT_FULL: //repeat
					jojosFifthRape();
                    break;
				default: //from camp states or anything
                    CoC_Settings.error("Unexpected Jojo rape state (" + monk + "). Please report it as a bug.");
					jojosFirstRape();
					break;
			}
        }

		public function jojosFirstRape():void {
			if (recalling) monster = new Jojo();
			clearOutput();
			if (!recalling) {
				dynStats("lib", -10, "cor", 4);
				monk = JOJO_CORRUPT_1;
				outputText("<b>New scene is unlocked in 'Recall' menu!</b>\n\n");
			}
			outputText("You pretend to agree, and follow Jojo into the woods.  You bide your time, waiting for him to relax.  Eventually the mouse stumbles, and you have your chance!\n\n");
			sceneHunter.selectGender(player.hasVagina() ? hermF : dickF, vagF);

			function dickF():void
			{
				outputText("You push him hard, following through to pin his small frame.  He struggles but you twist his arm expertly and hold him down with your larger bodyweight.  He squirms as you tear off the bottom of his outfit, protesting mightily as you force him into the dirt and expose his toned bottom.\n\n");
				if (player.cockTotal() == 1)
				{
					outputText("You grin and press your [cock] against him, making him squeal in protest.  You press on, eager to violate his puckered asshole, reveling in the crushing tightness.  His muscles quiver nervelessly as you pound him raw, his muted protests getting weaker as you notice a rapidly swelling bulge under him.  You reach around and begin jerking him off as you fuck him, fantasizing about pouring him full of corruptive demon power, making him your slave.  The dirty thoughts make your balls feel full; a pulsing, squeezing tightness builds in your nethers as your [cock] flexes and bulges inside your prey.  You cum hard, pressing his muzzle into the dirt as you pump glob after glob of cum up his ass, violating him to his core.\n\n");
					outputText("With a satisfied sigh, you pull your [cock] out with an audible 'pop'.  Your cum begins leaking out, pooling under him and mixing with his own.  The little guy must have cum hard; he seems fairly comatose.  As you leave your senseless victim, you realize  you feel more satisfied than you have in a while, almost like you've cum so hard it took some of your libido with it.");
				} else {
					outputText("You grin and press your [cocks] against him, making him squeal in protest.  You press on, eager to violate his tight asshole, reveling in the crushing tightness.  His muscles quiver nervelessly as you pound him raw, his muted protests getting weaker as you notice a rapidly swelling bulge under him.  You reach around and begin jerking him off as you fuck him, fantasizing about pouring him full of corruptive demon power, making him your slave.  The dirty thoughts make your balls feel full, a pulsing squeezing tightness building in your nethers as your [cock] flexes and bulges inside your prey.  You cum hard, pressing his muzzle into the dirt as you pump glob after glob of cum up his ass, violating him to his core.  Cum sprays over his ass, the rest of your equipment soaking him as it cums as hard as the one you sank up into the mouse-hole.\n\n");
					outputText("With a satisfied sigh, you pull your [cock] out with an audible 'pop'.  Your cum begins leaking out, pooling under him and mixing with his own.  The little guy must have cum hard, he seems fairly comatose.  As you leave your senseless victim, you realize  you feel more satisfied than you have in a while, almost like you've cum so hard it took some of your libido with it.");
				}
				if (!recalling) {
					player.sexReward("no", "Dick");
					cleanupAfterCombat();
				} else doNext(recallWakeUp);
			}
			function vagF():void
			{
				outputText("You smack the back of his head hard, dazing him.  You spin him around as you take his feet out from under him, one hand pulling his pants while the other slashes his belt.  He literally falls out of his pants' and onto the soft earth of the forest.  You pounce on the stunned monk, shedding your own clothes and pinning him to the ground.  He begins to resist, squirming under you, ");

				if (player.wetness() < 2)
					outputText("but the sensation of you grinding your folds against him momemtarily breaks his will.  ");
				else
					outputText("but the feeling of your " + vaginaDescript(0) + " grinding against his hardening cock robs him of any will.  ");

				outputText("You smile when you realize how large he is for his frame, and mount him, taking care to keep him pinned hard to the ground.");

				if (!recalling) player.cuntChange(12, true, true, false);

				outputText("\n\n");

				outputText("He lets out little grunts and whines of protest as you ride him hard, but quickly cums.  The flood of warmth inside your canal only serves to spur you on, slamming your " + vaginaDescript(0) + " down on him with brutal force.  You envision yourself raping others, corrupting all those you come across with your needy pussy.  You imagine what it must be like to be a succubus, fucking poor monks like this, your magics making your victim's manhood ever larger.  The thought breaks over you like a wave and you cum, hard; your " + vaginaDescript(0) + " clamps down hard on Jojo's cock as he finds himself cumming again, eyes rolling back in his head.  You shudder and moan, cum squirting out of your fuck-hole with each bounce on the poor mouse.");

				if (player.biggestLactation() >= 1 && player.biggestLactation() < 2)
					outputText("  Milk squirts from  your nipples, spraying him down with small droplets of your creamy tit-treat.");

				if (player.biggestLactation() >= 2 && player.biggestLactation() < 3)
					outputText("  Streams of milk spray from your nipples in time with your pussy contractions, hosing the poor mouse down and puddling on his fur.");

				if (player.biggestLactation() >= 3)
					outputText("  Gouts of milk erupt from your nipples, spraying continually as you cum.  The poor mouse is soaked from head to toe, your cream utterly drenching the monk.");

				outputText("\n\nYou stand on wobbly legs, happy to have so thoroughly fucked such a chaste and good-natured creature.  You vow to do it again soon, realizing you feel more clearheaded, if a bit more evil.");
				if (!recalling) {
					player.sexReward("cum","Vaginal");
					if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
					else player.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE + 82); //Jojo's kids take longer for some reason
					cleanupAfterCombat();
				} else doNext(recallWakeUp);
			}
			function hermF():void
			{
				trace("gender3");

				outputText("You push him hard, following through to pin his small frame.  He struggles but you twist his arm expertly and hold him down with your larger bodyweight.  He squirms as you tear off the bottom of his outfit, protesting mightily as you force him into the dirt and expose his toned bottom.\n\n");
				if (player.cockTotal() == 1)
				{
					outputText("You grin and press your [cock] against him, making him squeal in protest.  You press on, eager to violate his tight asshole, reveling in the crushing tightness.  His muscles quiver nervelessly as you pound him raw, his muted protests getting weaker as you notice a rapidly swelling bulge under him.  You reach around and begin jerking him off as you fuck him, fantasizing about pouring him full of corruptive demon power, making him your slave.  The dirty thoughts make your balls feel full, a pulsing squeezing tightness building in your nethers as your [cock] flexes and bulges inside your prey.  You cum hard, pressing his muzzle into the dirt as you pump glob after glob of cum up his ass, violating him to his core.  Your pussy quivers, cumming as well, feeling empty.  You resolve to take his cock's virginity next time.");
					if (player.biggestLactation() >= 1 && player.biggestLactation() < 2)
						outputText("  Milk squirts from  your nipples, spraying him down with small droplets of your creamy tit-treat.  ");

					if (player.biggestLactation() >= 2 && player.biggestLactation() < 3)
						outputText("  Streams of milk spray from your nipples in time with your pussy contractions, hosing the poor mouse down and puddling on his fur.  ");

					if (player.biggestLactation() >= 3)
						outputText("  Gouts of milk erupt from your nipples, spraying continually as you cum.  The poor mouse is soaked from head to toe, your cream utterly drenching the monk.  ");

					outputText("\n\nWith a satisfied sigh, you pull your [cock] out with an audible 'pop'.  Your cum begins leaking out, pooling under him and mixing with his own.  The little guy must have cum hard, he seems fairly comatose.  As you leave your senseless victim, you realize  you feel more satisfied than you have in a while, almost like you've cum so hard it took some of your libido with it.");
				} else {
					outputText("You grin and press your [cocks] against him, making him squeal in protest.  You press on, eager to violate his tight asshole, reveling in the crushing tightness.  His muscles quiver nervelessly as you pound him raw, his muted protests getting weaker as you notice a rapidly swelling bulge under him.  You reach around and begin jerking him off as you fuck him, fantasizing about pouring him full of corruptive demon power, making him your slave.  The dirty thoughts make your balls feel full, a pulsing squeezing tightness building in your nethers as your [cock] flexes and bulges inside your prey.  You cum hard, pressing his muzzle into the dirt as you pump glob after glob of cum up his ass, violating him to his core.  Cum sprays over his ass, the rest of your equipment soaking him as it cums as hard as the one you sank up into the mouse-hole.  Your pussy quivers, cumming as well, feeling empty.  Mentally you resolve to take his cock's virginity next time.");
					if (player.biggestLactation() >= 1 && player.biggestLactation() < 2)
						outputText("  Milk squirts from  your nipples, spraying him down with small droplets of your creamy tit-treat.  ");

					if (player.biggestLactation() >= 2 && player.biggestLactation() < 3)
						outputText("  Streams of milk spray from your nipples in time with your pussy contractions, hosing the poor mouse down and puddling on his fur.  ");

					if (player.biggestLactation() >= 3)
						outputText("  Gouts of milk erupt from your nipples, spraying continually as you cum.  The poor mouse is soaked from head to toe, your cream utterly drenching the monk.  ");

					outputText("\n\nWith a satisfied sigh, you pull your [cock] out with an audible 'pop'.  Your cum begins leaking out, pooling under him and mixing with his own.  The little guy must have cum hard, he seems fairly comatose.  As you leave your senseless victim, you realize  you feel more satisfied than you have in a while, almost like you've cum so hard it took some of your libido with it.");
				}
				if (!recalling) {
					player.sexReward("no", "Dick");
					cleanupAfterCombat();
				} else doNext(recallWakeUp);
			}
		}

		public function jojosSecondRape():void {
			if (recalling) monster = new Jojo();
			clearOutput();
			outputText("The poor mouse is already hard... his cock is throbbing eagerly as it protrudes through the opening in his robe, looking nearly eight inches long.  You're pretty sure it wasn't that big last time.\n\n");
			if (!recalling) {
				monk = JOJO_CORRUPT_2;
				outputText("<b>New scene is unlocked in 'Recall' menu!</b>\n\n");
				dynStats("lib", -10, "cor", 4);
			}
			sceneHunter.selectGender(dickF, vagF, null, null, -1);

			function dickF():void {
				outputText("You force Jojo over a log, running your hands through his fur and slapping his ass.  He grunts, but it's impossible to tell if it's in frustration, anger, or arousal.  You quickly force yourself back into his ass, finding it noticably stretched from your last incursion.  ");
				if(player.averageCockThickness() >= 3) outputText("It makes little difference to your [cock], he still feels tight as a virgin's cunt to you.  ");
				outputText("You grab him by the waist and fuck him powerfully, slamming your [cock] in brutally hard and fast.  You notice his hands are in his crotch, feverishly masturbating his disproportionately large cock like a slut.  You start leaking pre-cum like a sieve, realizing you're doing it, really doing it - making this virtuous mouse into a wanton slut!  You squeeze him tightly as you cum into his bowels, his belly distending slightly as your orgasm goes on and on.  Trails of cum run down his fur as it becomes more than his ass can handle.");
				if(player.cockTotal() > 1) outputText("  Your remaining equipment showers him with jizz, more than you ever thought you could produce.");
				outputText("  The mouse moans and cums himself, with loud moans and messy splurts coating the ground every time your hips meet.\n\n");
				outputText("Eventually it ends, and you drop him into the puddled spooge like a used condom.  He lays there, idly stroking himself in a daze, his prick still swollen with need and dripping fluids.  You can't wait to corrupt him some more.");
				if (!recalling) {
					player.sexReward("Default", "Dick",true,false);
					cleanupAfterCombat();
				} else doNext(recallWakeUp);
			}

			function vagF():void {
				outputText("You throw him on the soft soil of the forest and mount him, skillfully guiding his member towards your now dripping wet hole.  As you slide down you marvel at how he feels larger and thicker than before, deliciously so.  Your " + vaginaDescript(0) + " throbs in the most pleasant way as you rape his small form.  You play with your clit, watching Jojo's face flit between rapture and disgust.  You lick your lips and smile as the disgust vanishes, his hot jets of cum painting your cunt-walls.  You giggle and keep fucking him, hoping that somehow your corruption and lust are influencing him, turning him into your personal fucktoy.  The thought brings you over the edge.  You clamp down, your " + vaginaDescript(0) + " milking, squeezing every last drop from him as his prick erupts inside you.  ");
				if (!recalling) player.cuntChange(1.5, true);
				if(player.biggestLactation() >= 1 && player.biggestLactation() < 2) outputText("Milk squirts from  your nipples, spraying him down with small droplets of your creamy tit-treat.  ");
				if(player.biggestLactation() >= 2 && player.biggestLactation() < 3) outputText("Streams of milk spray from your nipples in time with your pussy contractions, hosing the poor mouse down and puddling on his fur.  ");
				if(player.biggestLactation() >= 3) outputText("Gouts of milk erupt from your nipples, spraying continually as you cum.  The poor mouse is soaked from head to toe, your cream utterly drenching the monk.  ");
				if(player.averageVaginalWetness() == 5) outputText("Your " + vaginaDescript(0) + " drenches him with your squirting girl-cum, mixed with his own seed.");
				if(player.cockTotal() == 1) outputText("Jizz sprays onto his chest from your [cock].  ");
				if(player.cockTotal() == 2) outputText("A hail of jizz splatters over Jojo from your [cocks].  ");
				if(player.cockTotal() == 3) outputText("A multitude of thick cum-streams splatter over Jojo from head to waist as your [cocks] hose him down.  ");
				outputText("\n\nSatisfied at last, you pull yourself away from the dazed mouse.  His shaft is still swollen with need, his hands irresistibly stroking it, eyes vacant.  You're going to corrupt him so much more next time.\n\n");
				if (!recalling) {
					player.sexReward("cum","Vaginal");
					if (player.hasCock()) player.sexReward("Default", "Dick",true,false);
					if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
					else player.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE + 82); //Jojo's kids take longer for some reason
					cleanupAfterCombat();
				} else doNext(recallWakeUp);
			}
		}

		public function jojosThirdRape():void {
			if (recalling) monster = new Jojo();
			clearOutput();
			outputText("It's no wonder the monk's body has betrayed him so thoroughly, his [monster cockshort] is nearly ten inches long, pulsing with hot need.\n\n");
			sceneHunter.selectGender(dickF, player.hasCock() ? hermF : vagF, null, null, -1);

			function dickF():void {
				outputText("You yank Jojo up from the ground and onto his knees, ");
				if(player.cockTotal() == 1) {
					outputText("presenting your [cock] to him.  ");
				}
				else outputText("presenting your [cocks] to him.  ");
				outputText("The monk betrays his violated state of mind, licking his lips demurely and opening wide.  The invitation is all you need ");
				if(player.cockTotal() == 1) outputText("to ram your [cock] deep into his maw.  You roughly grab his ears, facefucking him hard, his tongue working hard to please.  ");
				if(player.cockTotal() > 1) outputText("to cram two cocks deep into his maw, making his jaw stretch obscenely.  You roughly grab his ears, facefucking him hard, his tongue working hard to please you.  ");
				outputText("One of Jojo's paws is buried in his groin, stroking his [monster cockshort] with feverish intensity.  The hornier he gets, the more his throat seems to relax, allowing you to push deeper.  The glazed, lust-addled look on his face is so hot, you can't hold back any longer.  ");
				if(player.cockTotal() == 1) outputText("Your [cock] clenches tightly, erupting ");
				if(player.cockTotal() > 1) outputText("Your twin dicks clench tightly, erupting ");
				outputText("hot seed into the now meek and subdued bitch-boy.  His throat squeezes around you as he presses his nose tightly against your crotch, pulling as much of you in as he can.  Mouse-spunk spatters your legs as he cums with you.\n\n");
				if(player.lib > 60 && player.cor > 40) {
					outputText("You flip him onto his back, both of you still hard and ready for more.  He gets up on all fours and wiggles his bum tantalizingly.  You press on, ");
					if(player.cockTotal() == 1) outputText("violating his loosened sphincter, and begin to fuck him hard.  He whimpers with a mixture of pain and pleasure, your spit-lubed [cock] pounding his prostate mercilessly.  Thick ropes of mousey-cum drool with each anus-stretching thrust of your cock, pooling below you.  You wickedly smile, slapping his ass, imagining him stretched further, his ass gaping, his cock huge and dripping with cum.  The strange thoughts filling your mind seem to travel straight to your balls and distill into pools of cum.  Like a long dormant volcano, you erupt, hot liquid spraying into Jojo, pumping his ass full and leaking down his legs.  He cums again, harder than before, his pulsing prick seeming to grow larger throughout his orgasm.\n\n");
					else outputText("violating his loosened sphincter, and begin to fuck him hard.  He whimpers with a mixture of pain and pleasure, a spit-lubed cock pounding his prostate mercilessly.  Thick ropes of mousey-cum drool with each anus-stretching thrust of your cock, pooling below you.  You wickedly smile, slapping his ass, imagining him stretched further, his ass gaping, his cock huge and dripping with cum.  The strange thoughts filling your mind seem to travel straight to your balls and distill into pools of cum.  Like a long dormant volcano, you erupt, hot liquid spraying into Jojo, pumping his ass full and leaking down his legs.  He cums again, harder than before, his pulsing prick seeming to grow larger throughout his orgasm.\n\n");
				}
				outputText("You leave the exhausted mousey behind you, wondering how you'll take him next time.  ");
				sharedEnd(false);
			}
			function vagF():void {
				if (player.isBiped()) outputText("You spread your legs and crook your finger");
				else outputText("You crook your finger");
				outputText(", beckoning him towards your " + vaginaDescript(0) + ".  He looks disheartened, but obediently kneels before you, his whiskers tickling your " + vaginaDescript(0) + ", his wet nose bumping your clit, his tongue taking long licks between your lips.  ");
				if(player.biggestTitSize() >= 2) {
					outputText("You sigh and knead your breasts in pleasure.  ");
				}
				if(player.biggestLactation() >= 1.5 && player.biggestTitSize() > 2 && player.mostBreastsPerRow() >= 2 && player.breastRows.length >= 1) outputText("Every sensual peak within you is mirrored with small spurts of milk from your nipples.  It eventually trickles down to Jojo's tongue, spurring his efforts on.  ");
				outputText("The mousey gets more and more in to eating your box, making it harder and harder to stave off an orgasm.  You wrap ");
				if(player.isNaga()) outputText("your coils ");
				else if(player.lowerBody == LowerBody.GOO) outputText("your jiggling goo ");
				else outputText("your thighs ");
				outputText("around his head and quiver with passion, ");
				if(player.averageVaginalWetness() <= 1) outputText("squeezing him tightly into your " + vaginaDescript(0) + ".");
				if(player.averageVaginalWetness() > 1 && player.averageVaginalWetness() <= 3) outputText("creaming his tongue liberally with girlcum.");
				if(player.averageVaginalWetness() == 4) outputText("creaming all over him with your slobbering pussy.");
				if(player.averageVaginalWetness() == 5) outputText("splattering him with girlcum from your " + vaginaDescript(0) + ".");
				outputText("\n\nYou pull the cunt-dazed mouse away reluctantly, and bend over,");
				if (player.isBiped()) outputText(" spreading your legs and");
				outputText(" shaking your rump.  ");
				if(player.hasLongTail() > 0) outputText("Your tail swishes back and forth teasingly.  ");
				outputText("Your tantalizing backside is too much for him.  He pounces your ass in a second, penetrating your " + vaginaDescript(0) + " forcefully.  The knowledge that your demonic influence is responsible for his state nearly makes you cream all over his cock.  You fantasize about your cunt making his cock grow longer and fatter as it corrupts him further, transforming his morals and values into cock and cum.  Jojo thrashes against you, brutally pounding your " + vaginaDescript(0) + " as he orgasms.  His [monster cockshort] erupts inside you, the feeling of being filled with mouse-spunk drives you over the edge with him.  More and more of his cum sprays inside you, unnatural amounts for a creature his size.  Thick streams of the stuff escape down your thighs as your belly distends.  ");
				if (!recalling) player.cuntChange(2, true);
				outputText("\n\n");
				outputText("You let the drained mouse pop free, reveling in the sensation of cum pouring from");
				if (player.isBiped()) outputText(" between your thighs");
				else outputText(" your cunt");
				outputText(".  Jojo has already passed out behind you.  ");
				sharedEnd(true);
			}
			function hermF():void {
				if (player.isBiped()) outputText("You spread your legs and crook your finger");
				else outputText("You crook your finger");
				outputText(", beckoning him towards your " + vaginaDescript(0) + ".  He looks disheartened, but obediently kneels before you, his whiskers tickling, his wet nose bumping your clit, his tongue taking long licks between your lips.  ");
				if(player.cockTotal() == 1) outputText("You sigh as your [cock] droops over his head.  ");
				if(player.cockTotal() > 1) outputText("You sigh as your [cocks] pile atop his head.  ");
				if(player.biggestTitSize() >= 2) outputText("You kneed your breasts, excited and filled with pleasure.  ");
				if(player.biggestLactation() >= 1.5 && player.biggestTitSize() > 2 && player.mostBreastsPerRow() >= 2 && player.breastRows.length >= 1) outputText("Every sensual peak within you is mirrored with small spurts of milk from your nipples.  It eventually trickles down to Jojo's tongue, spurring his efforts on.  ");
				outputText("The mousey gets more and more into eating your box, making it harder and harder to stave off an orgasm.  You wrap your thighs around his head and quiver with passion, ");
				if(player.averageVaginalWetness() <= 1) outputText("squeezing him tightly into your " + vaginaDescript(0) + ".");
				if(player.averageVaginalWetness() > 1 && player.averageVaginalWetness() < 4) outputText("creaming his tongue liberally with girlcum.");
				if(player.averageVaginalWetness() == 4) outputText("creaming all over him with your slobbering pussy.");
				if(player.averageVaginalWetness() >= 5) outputText("splattering him with you girlcum from your " + vaginaDescript(0) + ".");
				if(player.cockTotal() > 0) outputText("  Thick runners of your pre dribble down his neck, sticking to his fur.  ");
				outputText("\n\nYou pull the cunt-dazed mouse away reluctantly, and bend over,");
				if (player.isBiped()) outputText(" spreading your legs and");
				outputText(" shaking your rump.  ");
				if(player.hasLongTail() > 0) outputText("Your tail swishes back and forth teasingly.  ");
				outputText("Your tantalizing backside is too much for him.  He pounces your ass in a second, penetrating your " + vaginaDescript(0) + " forcefully.  The knowledge that your demonic influence is responsible for his state nearly makes you cream all over his cock.  You fantasize about your cunt making his cock grow longer and fatter as it corrupts him further, transforming his morals and values into cock and cum.  Jojo thrashes against you, brutally pounding your " + vaginaDescript(0) + " as he orgasms.  His [monster cockshort] erupts inside you, the feeling of being filled with mouse-spunk drives you over the edge with him.  More and more of his cum sprays inside you, unnatural amounts for a creature his size.  Thick streams of the stuff escape down your thighs as your belly distends.  ");
				if (!recalling) player.cuntChange(2, true);
				if(player.cockTotal() == 1) outputText("Your [cock] trembles in orgasm, squirting your load into the thick forest loam.  ");
				if(player.cockTotal() > 1) outputText("Your [cocks] tremble in orgasm, squirting their hot loads all over the thick forest loam.  ");
				outputText("\n\n");
				outputText("You let the drained mouse pop free, reveling in the sensation of cum pouring from ");
				if (player.isBiped()) outputText("between your thighs");
				else outputText("your cunt");
				outputText(".  Jojo has already passed out behind you.  ");
				sharedEnd(true);
			}
			function sharedEnd(vag:Boolean):void {
				if(player.lib > 60 && player.cor > 50 - player.corruptionTolerance) {
					if (!vag) outputText("You smile as you hear him begin masturbating in the background.  There can be no doubt, you are tainting him more and more...");
					else outputText("You lean down and whisper strange un-words as you stroke his cock.  It spasms and grows, cum pumping from it slowly but constantly.  You walk away, leaving him in a growing puddle of what was once his morals.  You don't know where the words came from, but you do know you're getting better at tempting and corrupting.");
					if (!recalling) {
						monk = JOJO_CORRUPT_3;
						outputText("\n\n<b>New scene is unlocked in 'Recall' menu!</b>");
						dynStats("lib", -10, "cor", 4);
					}
				} else {
					outputText("Seems like that still wasn't enough... maybe you need to be more corrupted or have higher libido?");
					if (!recalling) dynStats("lib", 2, "cor", 1);
				}
				if (!recalling) {
					if (!vag) player.sexReward("no", "Dick");
					else {
						player.sexReward("cum", "Vaginal");
						if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
						else player.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE + 82); //Jojo's kids take longer for some reason
					}
					cleanupAfterCombat();
				} else doNext(recallWakeUp);
			}
		}

		public function jojosFourthRape():void {
			if (recalling) monster = new Jojo();
			clearOutput();
			outputText("Jojo flops down, eyes filled with anticipation.  His self-control has really slipped away.  The corrupted and horny mouse on display here is anathema to the studious monk you met before.  His cock is close to a foot long and over two inches thick, veiny with arousal.\n\n");
			sceneHunter.selectGender(dickF, vagF, null, null, -1)

			//Male Version
			function dickF():void {
				outputText("The mousy former-monk kneels as you disrobe, his will nearly broken by desire.  ");
				if(player.cockTotal() == 1) outputText("You touch his head softly and guide him to your [cock], smiling as he licks his lips with anticipation.  You gasp at the feeling of his soft lips and wet tongue as he pleasures you, your knees going weak from his efforts.  Jojo cups your balls and slips a fuzzy finger into your ass.  He labors to take as much of you as possible into his mouth, panting warmly and wetly around your [cock].  You twitch in pleasure as he alternates pressure on your prostate with smooth strokes of his slick tongue.  ");
				else outputText("You touch his head softly and guide him to your [cocks], smiling as he licks his lips in anticipation.  You gasp at the feelings of his soft lips and wet tongue on your heads as he pleasures you, your knees going weak from his efforts.  Jojo cups your balls and slips a fuzzy finger into your ass.  He labors to take in two shafts, struggling to swallow them as deep as possible, panting wetly around you.  You twitch with pleasure as he alternates pressure on your prostate with smooth strokes of his slick tongue.  ");
				//Too thick for him
				if(player.averageCockThickness() > 3 || (player.dogCocks() > 0 && player.averageCockThickness() > 3)) outputText("Jojo is forced to back off of your [cock] from time to time to come up for air, barely opening his jaw wide enough to take your girth back inside his mouth.  ");
				//Too long for him
				if(player.averageCockLength() > 10 || (player.horseCocks() > 0 && player.averageCockLength() > 10)) outputText("He struggles not to gag on your [cock]'s length, opening his throat as far as he can.  ");
				outputText("You rock back and forth on his face as he expertly keeps you on the edge of orgasm.  ");
				if(player.cumQ() > 25) outputText("Your constant stream of heavy pre practically chokes the poor mouse as he edges you mercilessly, his own equipment drizzling in sympathetic lust.  ");
				outputText("Jojo presses his paw hard into your ass, squeezing your prostate tightly as his hot muzzle dives deeply over your cock.  You feel the building tightness of your orgasm and pull him tightly against you as the pressure builds.  ");
				if(player.cumQ() < 25) outputText("You buck against him as you orgasm, your small squirts of cum eagerly devoured by the slutty mouse.");
				if(player.cumQ() >= 25 && player.cumQ() < 250) outputText("You buck against him as you orgasm, the slutty mouse's throat squeezing against you as he works to swallow your seed.");
				if(player.cumQ() >= 250 && player.cumQ() < 500) outputText("You spasm against him as you orgasm, the pleasure erupting into the slut-mouse's throat as he tries to swallow it all.  Excess cum dribbles from the corners of his mouth as you fully spend yourself.");
				if(player.cumQ() >= 500) outputText("You buck against him as you orgasm, the slutty mouse's cheeks bulging in surprise as your cum explodes into his mouth.  Thick streams escape from the corners of his muzzle, your seed pouring into him faster than he can swallow.  Eventually you finish, and see the mouse dripping with your spunk nearly to the waist, a small bulge in his belly.");
				outputText("  Jojo leans back, panting for breath, a dull smile on his face.  He spits a load of your cum into his paw and begins jerking himself off with it, lewdly putting on a show for you.\n\n");
				if(player.lib > 50 && player.cor > 80 - player.corruptionTolerance) {
					outputText("<b>You feel a familiar power growing within you and decide to unleash it.</b>  You grab the prayer beads from his outfit and spit on them, making them slick and wet.  Holding them below your flagging cock, you focus on the demonic visions in your mind, slowly but constantly milking larger and larger dollops of cum onto the once holy beads.  Jojo moans as he comes to understand your intent, and turns around, shaking his lithe mouse-bum at you.  You lean over him, whispering into his ear, \"<i>Each defiled bead I push into you is going to make you more of a willing slut.  More of a willing receptacle for demon cum.  More of a fountain of desire waiting to be tapped by Succubi.  More my toy.</i>\"\n\n");
					outputText("He whimpers as you slide the first bead in, his eyes growing foggy and his bum wiggling more eagerly.  You push the second bead inside him, and feel his asshole stretch and loosen, welcoming the corruption.  The third bead slips right in, and he moans, \"<i>sluuuut</i>,\" His cock grows longer and thicker throughout the moan, stopping at over a foot long and 3 inches thick, dribbling cum.  You whisper, \"<i>Cum, my Toy,</i>\" and push the remaining beads inside him.  His eyes roll back as his paws frantically milk his [monster cockshort], cum spraying from him like a fountain.  Jojo trembles, losing complete control and falling away from you.  You still hold the end of his beads, and smile as they pop out, stained almost as dark as the poor mouse's soul.\n\n");
					outputText("You walk away, leaving your new pet to explore his outlook on life, and to test your awakened powers.  ");
					if (!recalling) {
						monk = JOJO_CORRUPT_FULL;
						outputText("<b>New scenes are unlocked in 'Recall' menu!</b>\n\n");
						dynStats("lib", -10, "cor", 10);
					}
				}
				else {
					outputText("Jojo eventually cums violently, collapsing into a puddle of spent jizz.  You smile and walk away, hoping to encounter him again.  ");
					outputText("Seems like that still wasn't enough... maybe you need to be more corrupted or have higher libido?");
					if (!recalling) dynStats("lib", 2, "cor", 1);
				}
				if (!recalling) {
					player.sexReward("no", "Dick");
					cleanupAfterCombat();
				} else doNext(recallWakeUp);
			}
			//Female or Herm Version
			function vagF():void {
				//Oral
				outputText("The mousy once-monk kneels as you disrobe, his will nearly broken by desire.  ");
				outputText("You touch his head softly, guiding him to your " + vaginaDescript(0) + ", lips breaking into a grin as he licks his mouth with desire.  You gasp at the feeling of his wet nose as it bumps against your groin, shooting thunderbolts of pleasure from your " + clitDescript() + ".  He attacks with his tongue, thrusting strikes practically attacking your " + vaginaDescript(0) + " with his long, practically serpentine, tongue.  You shudder, knowing a visible sign of corruption when you see it, moisture slicking the mouse's face.\n\n");
				outputText("Jojo moans into your folds as his [monster cockshort]");
				if (player.isBiped()) outputText(" brushes against your calf");
				else outputText(" brushes against your [leg]");
				outputText(".  You get a devilish idea, ");
				if(player.lowerBody == LowerBody.GOO) outputText("and push his [monster cockshort] in between folds of slime, sandwiching it in a mass of slippery, gooey tightness.  Holding his shoulder for balance, you slowly squeeze him, gently milking out small dribbles of pre.  He redoubles his efforts, burying his nose into your " + vaginaDescript(0) + ", tongue swirling over your folds and around your " + clitDescript() + ".  For every effort on his part you step up your own, squeezing and stroking him with your goo, doing your best to impart a fetish for being masturbated with someone's lower body on his slowly warping mind.  You feel a hot wetness in your slime, and it grows slicker and wetter every second. Jojo's cum drips out of you, glazing your jello-like form white.  ");
				else outputText("and push his [monster cockshort] with your [foot], sandwiching it under one [foot] and on top of the other.  Holding his shoulder for balance, you slowly squeeze him, gently milking out small dribbles of pre.  He redoubles his efforts, burying his nose into your " + vaginaDescript(0) + ", tongue swirling over your folds and around your " + clitDescript() + ".  For every effort on his part you step up your own, squeezing and stroking him with your [feet], doing your best to impart a [foot] fetish on his slowly warping mind.  You feel a hot wetness on your [feet], and they grow slicker and wetter every second. Jojo's cum drips out from between them, glazing them white.  ");
				if(player.averageVaginalWetness() <= 1) outputText("You clamp down on his muzzle as you writhe in orgasm.  ");
				if(player.averageVaginalWetness() > 1 && player.averageVaginalWetness() <= 3) outputText("Your legs trap his muzzle in your " + vaginaDescript(0) + " as orgasm wracks your body.  ");
				if(player.averageVaginalWetness() == 4) outputText("Your legs trap his muzzle in your " + vaginaDescript(0) + ", slicking his muzzle with girlcum as you spasm with bliss.  ");
				if(player.averageVaginalWetness() == 5)outputText("Your legs squeeze him against your " + vaginaDescript(0) + ", girlcum erupting over his face and soaking him as you bliss out with orgasm  ");
				if(player.cockTotal() == 1) outputText("Your [cock] drizzles cum in his hair, some dripping off by his ear.  ");
				if(player.cockTotal() > 1) outputText("Your [cock]s drizzle him with cum, covering his head with thick white streams of your jizz.  ");
				outputText("Twitching weakly with pleasure, you fall back.\n\n");
				//Fux!
				outputText("The pleasure was magnificent... but you want MORE.  You push yourself up, feeling pleased as you spy Jojo stroking his cum-slick [monster cockshort], thick streams of cum leaking from the tip.  You pounce on him, pushing him down on the ground, and position your " + vaginaDescript(0) + " over him, allowing him to scent your sex.  With a triumphant smile, you sink down onto him, impaling yourself on his [monster cockshort].  ");
				if(player.averageVaginalLooseness() == 0) outputText("He is painfully large, so much so that you feel more pain than pleasure.  ");
				if(player.averageVaginalLooseness() == 1) outputText("He stretches you around him like a latex glove, pulling your " + vaginaDescript(0) + " taught with his [monster cockshort], the sensation riding a razor's edge between pleasure and pain.  ");
				if(player.averageVaginalLooseness() == 2) outputText("His [monster cockshort] stuffs you completely, filling your " + vaginaDescript(0) + " to capacity.  ");
				if(player.averageVaginalLooseness() == 3) outputText("His [monster cockshort] fits you perfectly, burying deep inside your folds.  ");
				if(player.averageVaginalLooseness() == 4) outputText("You easily accommodate his member into your " + vaginaDescript(0) + ".  ");
				if(player.averageVaginalLooseness() == 5) outputText("His [monster cockshort] slips inside your " + vaginaDescript(0) + " with little resistance, easily sinking in to the hilt.  You muse to yourself, \"<i>If only he were thicker...</i>\"  ");
				outputText("You ride him slowly, gyrating your hips in tiny grinding circles while you run your hands through his fur.  His hips bounce you gently with tiny twitching thrusts, cum pooling out of your " + vaginaDescript(0) + " as it continues to drip from him.  ");
				outputText("He gradually ups the tempo, and you are forced to go along for the ride as you begin to bounce on his [monster cockshort].  You grab fistfuls of his fur and hang on as he begins pounding your " + vaginaDescript(0) + ", his huge balls slapping against you.  Cum squirts from your pussy with each of his violent thrusts, more pouring deep inside you continually.  Jojo squeals with glee and slams his hips into yours a final time, triggering an eruption of seed in your channel.  You feel it pouring into your womb, slowly distending your belly with every shuddering pump of cum.  You orgasm helplessly, fingering your " + clitDescript() + " the whole time.  ");
				//Futacawk here
				if(player.cockTotal() > 0) {
					//Single Cock
					if(player.cockTotal() == 1) {
						//Horsefun!
						if(player.horseCocks() == 1) outputText("Your [cock] feels a building pressure, the whole thing pulsating wildly with each of your heartbeats, most noticably the tip, which flares out wildly.  Powerful contractions wrack your sheath and [cock] as pre practically fountains from it.  ");
						//DogFun!
						if(player.dogCocks() == 1) outputText("Your [cock] feels an intense pressure, and begins bulging out obscenely above your sheath.  The knot thickens gratuitiously, filling as it pulses with need.  Cum drips from your pointed tip as it continues to bulge wider, filling you with unbearable pressure.  ");
						//Else
						if(player.normalCocks() == 1) outputText("Your [cock] twitches, muscle contractions slowly working their way up from the base.  ");
						//CUMSPLOISION
						if(player.cumQ() < 25) outputText("Your body tenses and cums, spraying spurts of jizz over the mouse.  ");
						if(player.cumQ() >= 25 && player.cumQ() < 250) {
							if(player.horseCocks() == 1) outputText(" Your [cock] flares wildly as musky horse-cum erupts from it, splattering over Jojo.  ");
							if(player.dogCocks() == 1) outputText("The terrible pressure in your [cock] finally relents, in the form of a fountain of doggie-cum, spraying out from your [cock] in a steady stream that seems to last and last.  ");
							if(player.cocks[0].cockType == CockTypesEnum.HUMAN || player.cocks[0].cockType.Index > 2) outputText("Your body tenses and cums a thick eruption far beyond what a normal human could produce.  Jojo is splattered with the stuff.  ");
						}
						if(player.cumQ() >= 250) {
							if(player.horseCocks() == 1) outputText("Your [cock] ripples and bulges with animalistic vigor, horse-cum splattering everywhere with each contraction.  The musky animal-jizz never seems to stop pouring from your equine organ, soaking the mouse from the waist up.  ");
							if(player.dogCocks() == 1) outputText("Your [cock] suddenly releases the pressure, a constant stream of doggie-cum spouting from your [cock] like some kind of cum-hose.  It seems to go on endlessly, covering the mouse from the waist up with thick ribbons of doggie-spooge as your knot slowly shrinks to normal.  ");
							if(player.cocks[0].cockType == CockTypesEnum.HUMAN || player.cocks[0].cockType.Index > 2) outputText("Your body tenses and cums a thick eruption far beyond what a normal human could produce.  Jojo is splattered with the stuff.  ");
						}
					}
					//Sorry multicocks, I'm donE!
					if(player.cockTotal() > 1) {
						outputText("Your cocks feel a building pressure at their base. It only seems to get stronger and stronger, until at last it explodes out from you, jizz covering the poor mouse from the waist up.  ");
					}
				}

				//Milk here
				if(player.biggestLactation() >= 1 && player.biggestTitSize() > 3) {
					if(player.biggestTitSize() * player.biggestLactation() * player.breastRows.length < 8) outputText("Milk sprays from your " + breastDescript(0) + " in tiny streams, triggered by your orgasms.");
					if(player.biggestTitSize() * player.biggestLactation() * player.breastRows.length < 20 &&
					player.biggestTitSize() * player.biggestLactation() * player.breastRows.length >= 8) outputText("Milk erupts from your " + breastDescript(0) + ", spraying out over the mouse, squirting out the contractions of each shuddering orgasm.");
					if(player.biggestTitSize() * player.biggestLactation() * player.breastRows.length < 35 &&
					player.biggestTitSize() * player.biggestLactation() * player.breastRows.length >= 20) outputText("Milk erupts from your " + breastDescript(0) + ", spraying in pulsing blasts, soaking the mouse.  Each nerve-wracking orgasm seems to wring more and more milk from you, until it puddles around.");
					if(player.biggestTitSize() * player.biggestLactation() * player.breastRows.length >= 35) outputText("Milk fountains from your " + breastDescript(0) + ", soaking the mouse with a continuous river of cream.  For every blob of cum you feel pushing into your over-filled uterus, another torrent of milk sprays out.  As your mind-bending orgasms drag on, a small lake of milk forms around you.");
				}
				if (!recalling) {
					player.cuntChange(3, true);
					player.sexReward("cum", "Vaginal");
					if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
					else player.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE + 82); //Jojo's kids take longer for some reason
				}
				if(player.lib > 50 && player.cor > 80 - player.corruptionTolerance) {
					outputText("\n\n<b>You feel a familiar power growing within you and decide to unleash it.</b>  You grab the prayer beads from his outfit and spit on them, making them slick and wet.  Holding them below his flagging cock, you focus on the demonic visions in your mind, slowly but constantly milking larger and larger dollops of cum onto the once holy beads.  Jojo moans as he comes to understand your intent, and turns around, shaking his lithe mouse-bum at you.  You lean over him, whispering into his ear, \"<i>Each defiled bead I push into you is going to make you more of a willing slut.  More of a willing receptacle for demon cum.  More of a fountain of desire waiting to be tapped by Succubi.  More my toy.</i>\"\n\n");
					outputText("He whimpers as you slide the first bead in, his eyes growing foggy and his bum wiggling more eagerly.  You push the second bead inside him, and feel his asshole stretch and loosen, welcoming the corruption.  The third bead slips right in, and he moans, \"<i>sluuuut</i>,\" His cock grows longer and thicker throughout the moan, stopping at over a foot long and 3 inches thick, dribbling cum.  You whisper, \"<i>Cum, my Toy,</i>\" and push the remaining beads inside him.  His eyes roll back as his paws frantically milk his [monster cockshort], cum spraying from him like a fountain.  Jojo trembles, losing complete control and falling away from you.  You still hold the end of his beads, and smile as they pop out, stained almost as dark as the poor mouse's soul.\n\n");
					outputText("You walk away, leaving your new pet to explore his outlook on life, and to test your awakened powers.  ");
					if (!recalling) {
						monk = JOJO_CORRUPT_FULL;
						outputText("\n\n<b>New scenes are unlocked in 'Recall' menu!</b>");
						dynStats("lib", -10, "cor", 10);
					}
				}
				else {
					outputText("\n\nExhausted, you pull yourself free from the mouse, drained of lust but feeling VERY naughty.  Jojo doesn't even bother getting up, he just keeps masturbating, lost in the scents of your slick juices and his cum.  As you walk away with a sexy wiggle, the sexual fluids are absorbed into the ground.");
					outputText("Seems like that still wasn't enough... maybe you need to be more corrupted or have higher libido?");
					if (!recalling) dynStats("lib", 2, "cor", 1);
				}
                if (!recalling) {
					player.sexReward("cum", "Vaginal");
					cleanupAfterCombat();
				} else doNext(recallWakeUp);
			}
		}

        //Called when he's fully corrupted, but still raped.
		private function jojosFifthRape():void {
			clearOutput();
			outputText("Jojo smiles serenely, pleased at the outcome, a foot of tumescent mouse-meat bobbing at attention.\n\n");
			//Placeholder till I'm less lazy
			outputText("You fuck your mousey slut for what feels like hours, orgasming until both of you are tired and worn out.  ");
			player.sexReward("cum", "Default");
			fatigue(-20);
			if (player.lib > 40) {
				outputText("When you're done you feel more clear-headed, but Jojo looks hornier than ever.");
				dynStats("lib", -4);
			}
			cleanupAfterCombat();
		}

		//Not worth it. -SH
		public function loseToJojo():void {
			if (recalling) monster = new Jojo();
			clearOutput();
			if (monk == JOJO_CORRUPT_1 || monk == JOJO_CORRUPT_2) {
				outputText("Jojo glares down at you, and begins praying, slowly laying prayer papers all over your battered form.  You feel rage that quickly dissipates, replaced with a calm sense of peace.  You quickly lose consciousness, but are happy he defeated you.\n\nWhen you wake, you discover a note:\n\"<i>The fighting allowed me to exorcise most of your inner demons.  A part of me wanted to seek revenge for what you had done to me, but I know it was the taint on your soul that was responsible.  If we meet again I would be happy to meditate with you.\n\n          -Jojo.</i>\"");
				if (!recalling) {
					dynStats("lib", -10., "cor", -15);
					monk = JOJO_MET;
				}
			}
			else {
				outputText("Jojo grins wickedly as he senses your defeat, [monster cockshort] throbbing hard.  ");
				if (player.lust >= player.maxOverLust() || recalling) {
					if (player.gender == 1) {
						outputText("Too aroused to think, you just bend over, displaying your bum and letting your [cocks] dangle freely.  The mouse doesn't hesitate, and he thrusts his [monster cockshort] with painful force.  You stagger from the size and struggle to stay conscious as he fucks you like a mad beast, hammering your ass with incredible force.  ");
						if (player.cockTotal() == 1) outputText("Pre and cum drip from your [cock], forced out of your prostate by the rough beating it's taking.  You feel a flash of warm wetness inside you, and realize Jojo is cumming.  A sense of relief washes over you as the last burst of cum squirts out from your cheeks, only to be replaced with a dawning sense of horror as he continues fucking you harder than ever.\n\nYou black out after a few dozen of his orgasms and one or two of your own, your gut painfully distended with semen.");
						if (player.cockTotal() > 1) outputText("Pre and cum drip from your [cock]s, forced out of your prostate by the rough beating it's taking.  You feel a flash of warm wetness inside you, and realize Jojo is cumming.  A sense of relief washes over you as the last burst of cum squirts out from your cheeks, only to be replaced with a dawning sense of horror as he continues fucking you harder than ever.\n\nYou black out after a few dozen of his orgasms and one or two of your own, your gut painfully distended with semen.");
						if (!recalling) {
							player.buttChange(monster.cockArea(0), true);
							player.sexReward("cum", "Anal");
						}
					}
					if (player.gender >= 2) {
						outputText("Too aroused to think, you bend over, displaying your bum and " + vaginaDescript(0) + " to Jojo as open targets.  The mouse obliges, plunging himself into you, hard.  He fucks you with abandon, pounding your wanton little pussy with no regard for your pleasure.  Despite yourself, you enjoy the rough treatment.  A spasm of warmth erupts inside you as Jojo cums.  You worry he might stop, but as the mouse's orgasm ends he resumes fucking with even greater energy. You cum powerfully, his jizz seeping down your thighs as you begin lose track of yourself.  ");
						if (player.cockTotal() > 1) outputText("Your [cock] splatters the ground with cum repeatedly, until both your genders are raw and sore.  ");
						else outputText("Your " + vaginaDescript(0) + " cums on him many more times it until it is sore and tender, dripping with spunk.  ");
						outputText("You black out as Jojo cums AGAIN, forcing a river of spunk from your already over-filled uterus.");
						if (!recalling) {
							player.cuntChange(monster.cocks[0].cockThickness, true);
							//Preggers chance!
							if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
							else player.knockUp(PregnancyStore.PREGNANCY_MOUSE, PregnancyStore.INCUBATION_MOUSE + 82, 101); //Jojo's kids take longer for some reason
							player.sexReward("cum", "Vaginal");
						}
					}
					if (player.gender == 0) {
						outputText("Too aroused to think, you just bend over, displaying your bum and wiggling enticingly.  The mouse doesn't hesitate, and he thrusts his [monster cockshort] with painful force.  You stagger from the size and struggle to stay conscious as he fucks you like a mad beast, hammering your ass with incredible force.");
						if (!recalling) {
							player.buttChange(monster.cockArea(0), true);
							outputText("You feel a flash of warm wetness inside you, and realize Jojo is cumming.  A sense of relief washes over you as the last burst of cum squirts out from your cheeks, only to be replaced with a dawning sense of horror as he continues fucking you harder than ever.\n\nYou black out after a few dozen of his orgasms and one or two of your own, your gut painfully distended with semen.");
							player.sexReward("cum", "Anal");
						}
					}
					if (!recalling) dynStats("cor", 1);
				}
				//HP Defeat
				else {
					outputText("You black out from the pain of your injuries.\n\n");
				}
			}
			if (!recalling) cleanupAfterCombat();
			else doNext(recallWakeUp);
		}

		private function corruptJojoSexMenu():void {
			menu();
			addButton(0, "Give BJ", corruptJojoGiveBJ);
			addButton(5, (player.biggestLactation() > 1 ? "Suckle" : "Breasts"), corruptJojoBreasts)
				.disableIf(player.biggestTitSize() < 2, "You need boobs for that!");
			addButton(1, "Gentle BJ", corruptJojoBJGentle)
				.disableIf(!player.hasCock(), "Req. a cock!");
			addButton(6, "Cruel BJ", corruptJojoBJCruel)
				.disableIf(!player.hasCock(), "Req. a cock!");
			addButton(2, "Gentle Anal", corruptJojoAnalGentle)
				.disableIf(!player.hasCock(), "Req. a cock!");
			addButton(7, "Cruel Anal", corruptJojoAnalCruel)
				.disableIf(!player.hasCock(), "Req. a cock!");
			addButton(12, "Whisper", whisperJojobait)
				.disableIf(player.hasPerk(PerkLib.Whispered), "You need to submit to some jaguar-like demon for it.")
				.disableIf(!player.hasCock(), "Req. a cock!");
			addButton(3, "Gentle Vaginal", corruptJojoVaginalGentle)
				.disableIf(!player.hasVagina(), "Req. a vagina!");
			addButton(8, "Vag. Smother", corruptJojoVaginalSmother)
				.disableIf(!player.hasVagina(), "Req. a vagina!");
			addButton(13, "Anal Smother", corruptJojoAnalSmother)
				.disableIf(!player.hasVagina(), "Req. a vagina!");
			addButton(14, "Back", playerMenu);
		}

		private function corruptJojoBJCruel():void {
			jojoSprite();
			clearOutput();
			var x:int = player.biggestCockIndex();
			outputText("You yell out into the jungle, \"<i>Slut!</i>\" Minutes later Jojo slips into your camp from the jungle's shadows, dropping to his knees with a timid look of fear in his eyes. You step forward and grip the fur between his shell-like ears firmly, hissing angrily, \"<i>When I call for you, you need to be here. Do I need to teach you your place again?</i>\"  ");
			outputText("He shakes his head as you say this, trying to marshal up the strength to resist you. You draw your teeth back in a snarl of anger at this resistance and punch the mouse in the gut, dropping him to his knees gasping for breath.  ");
			if (player.cocks[x].cArea() < 10)
				outputText("You grip the fur on his head tightly in one hand and pull his mouth over your " + player.cockDescript(x) + ", thrusting into his muzzle with little concern for letting him catch his breath. You shove your length down his throat and start sawing away, making the mouse's eyes roll back from breathlessness. You can feel the muscles of his throat grip and spasm around your cock flesh as he chokes on the length, his thin lips trembling around your.  ");
			else if (player.cocks[x].cArea() < 36)
				outputText("You grip the fur on his head tightly in one hand and pull his mouth over your " + cockDescript(x) + ", thrusting into his muzzle with little concern for letting him catch his breath. The girth of your " + player.cockDescript(x) + " nearly dislocates his jaw. You can feel his throat stretching around you, like a hot, wet, tight sleeve, trembling with the pulse of his racing heart as you grind in and out of his mouth.  ");
			else outputText("You grip the fur on his head tightly in one hand and pull his mouth over your " + player.cockDescript(x) + ", thrusting against his muzzle with your " + player.cockDescript(x) + ". You can feel his buck teeth scratching against the top and bottom of your " + player.cockDescript(x) + "'s crown, but it does nothing to prevent what is to come. He lifts his hands to try to push your huge erection away, and since you can't fit your girth in his mouth, you decide to use that; grabbing hold of his hands and using them to stroke your length.  ");
			outputText("His eyes turn to you in fear and his body shudders for lack of breath, but it does nothing more than stoke the fires of your lust. You groan in pleasure as your balls draw up tight, churning with your corrupted seed, and in a rush you feed it to him, your orgasm overtaking you as surge after hot surge of cum flares through your flesh and into his throat.  " + (player.hasVagina() ? "A sympathetic orgasm hits your pussy, causing a surge of feminine juices to splash against his chest and dribble down your thighs lewdly.  " : ""));
			outputText("Your orgasm seems to last forever, filling his belly with your corrupted essence, causing his stomach to bulge slightly with the sheer volume of it. You pull away at last, letting him gasp for breath and fall to the ground, curling around his bloated belly.  ");
			outputText("You sneer at him and shake your head, hissing out, \"<i>It would be so much better for you if you didn't try to resist, my slut.</i>\"  ");
			player.sexReward("saliva", "Dick");
			dynStats("cor", 0.5);
			endEncounter();
		}

		private function corruptJojoBJGentle():void {
			jojoSprite();
			clearOutput();
			var x:int = player.biggestCockIndex();
			outputText("As if on command, Jojo slips into your camp from the jungle's shadows, dropping to his knees with a timid look of fear in his eyes. You step forward and caress your fingers through the fur between his shell-like ears, whispering softly to him, \"<i>It's all right, my beautiful slut, it will all be over soon.</i>\"");
			outputText("  He whimpers as you say this, feeling the corruption flowing off of your body like an alluring musk, drawing him deeper into your service.  ");
			if (player.cocks[x].cArea() < 10)
				outputText("He opens his mouth to protest, but you never give him the chance, sliding your " + player.cockDescript(x) + " between his lips and down his throat. You can feel the muscles of his throat grip and spasm around your " + player.cockDescript(x) + " as he chokes on the length, his thin lips trembling around your girth as his tongue slides across your vein-lined underside.  " + (player.biggestTitSize() >= 2 ? "Your hands lift to massage your breasts and tug at your nipples, and you can see him watching transfixed as you fuck his throat.  " : ""));
			else if (player.cocks[x].cArea() < 36)
				outputText("He opens his mouth to protest, but you never give him the chance, forcing your " + player.cockDescript(x) + " between his lips and nearly dislocating his jaw with the girth of it. You can feel his throat stretching around you, like a hot, wet, tight sleeve, trembling with the pulse of his racing heart as you grind in and out of his mouth.  " + (player.biggestTitSize() >= 2 ? "Your hands lift to massage your breasts and tug at your nipples, and you can see him watching transfixed as you fuck his throat.  " : ""));
			else outputText("He opens his mouth to protest, only to have your " + player.cockDescript(x) + " mute him. You can feel his buck teeth scratching against the top and bottom of your " + player.cockDescript(x) + "'s crown, but it does nothing to prevent what is to come. He lifts his hands to try to push your huge erection away, and since you can't fit your girth in his mouth, you decide to use that; grabbing hold of his hands and using them to stroke your length.  " + (player.biggestTitSize() >= 2 ? "His eyes move from your massive member to your bouncing breasts above with a look of wanton desire that makes you laugh softly.  " : ""));
			outputText("His eyes turn to you in fear and awe, pleading for release, and a slip of your foot to his own straining erection lets you know how in need of an orgasm he is, but this time is yours. You groan in pleasure as your balls draw up tight, churning with your corrupted seed, and in a rush you feed it to him, your orgasm overtaking you as surge after hot surge of cum flares through your flesh and into his throat.  " + (player.hasVagina() ? "A sympathetic orgasm hits your pussy, causing a surge of feminine juices to splash against his chest and dribble down your thighs lewdly.  " : ""));
			outputText("Your orgasm seems to last forever, filling his belly with your corrupted essence, causing his stomach to bulge slightly with the sheer volume of it. You pull away at last, letting him gasp for breath and fall to the ground, curling around his bloated belly.  ");
			if (player.biggestTitSize() >= 2)
				outputText("You draw him to your bosom and kiss his forehead and then stand and go about your duties, leaving him to recover from the intense encounter and then retreat back into the jungle.  ");
			else outputText("You give him one last fond caress, running your fingers through his fur in an almost patronizing petting motion, then turn without another word and leave him to retreat back into the jungle.  ");
			player.sexReward("saliva", "Dick");
			dynStats("cor", 0.5);
			endEncounter();
		}

		private function corruptJojoGiveBJ():void {
			jojoSprite();
			clearOutput();
			outputText("You decide to finally reward your slut for all his service to you, summoning him to your camp for pleasure. He meekly appears at your bidding and you direct him to lie down on the ground before you. He does as you ask and you gently spread his legs, settling down between them.  ");
			outputText("He looks at you in confusion that turns to bliss as you start to lick and caress his sheath and balls, urging the male to a full erection.  ");
			switch (rand(3)) {
				case 0:
					outputText("You take the tip of his member into your mouth, suckling at it as your tongue curls at the crown and teases at the tiny slit at the tip. You take your time with him, letting your hands rub up and down his length, masturbating him slowly and giving his needy balls the occasional caress.  ");
					break;
				case 1: outputText("You take the tip of his member into your mouth and slowly start to bob your head, one hand squeezing at his balls tenderly as your other hand strokes the length of his cock that your lips don't reach. You let your pace quicken over time, mimicking a vigorous fucking.  ");
					break;
				default:
					outputText("You take the tip of his member into your mouth, and then take a deep breath through your nose, before dropping your head down, listening to him gasp as his cock slides all the way into your mouth and down your throat, until your nose presses against his musky sheath.  Your hands tease and squeeze at his balls, urging him to cum as your throat rhythmically swallows at his length in a milking motion.  ");
			}
			outputText("You work until your slut explodes, and then, keeping all his seed in your mouth, you lift your head and press your lips to his in a firm kiss, feeding him the load of cum that he just released. He blushes as you do so, but obediently takes it all in, swallowing it down as you feed it to him.  ");
			outputText("Once the vulgar kiss is finished, you stand and smile, dismissing him with a casual wave of your hand.  ");
			player.sexReward("cum", "Lips");
			dynStats("cor", 0.5);
			endEncounter();
		}

		private function corruptJojoVaginalGentle():void {
			jojoSprite();
			clearOutput();
			outputText("Feeling the urge to be filled, you summon your mouse slut to you and smile as he quickly responds, moving to kneel before you reverently. You let your hand caress the side of his head, then order him to lay back.  ");
			outputText("He swallows and nods, nervously obeying, stretching himself out on his back on the ground. He watches as you crawl slowly up his body and press a firm kiss to his muzzle, which he returns with the impossible lust you have planted within him. You can feel his member stirring between your legs, rising up firm against your " + (player.hasCock() ? "own endowments" : "crotch") + " as you grind your dripping slit along it.  ");
			if (player.vaginalCapacity() < 10) {
				outputText("You lower your hand to take hold of his cock, lining it up with your entrance, and then with a soft grunt, you start to lower your weight atop him.\n");
				player.cuntChange(36.4, true);
				outputText("\n\nYou can feel every vein and ridge in his thick erection, stretching your tight pussy open around him. You start to ride him the best you can, taking barely half his length into your tight body with the knowledge that neither of you will last long. He cums first, however, and you can feel the seed surging into your body past the tight seal of your internal muscles.  ");
			}
			else if (player.vaginalCapacity() < 36) {
				outputText("You lower your hand to take hold of his cock, lining it up with your entrance, and then with a moan of pleasure, you lower your weight atop him. His cock slides into your pussy like a hand into a glove, fitting perfectly, as though he were made for you.\n");
				player.cuntChange(36.4, true);
				outputText("\n\nYou begin to rise and fall over him, setting a loving pace as you roll your hips. It doesn't last near as long as you would wish, however, as soon enough you can feel him cumming within your body, filling you with his seed. Not dissuaded, you grind at him, working your clit against his sheath and belly fur.  ");
			}
			else {
				outputText("You shift forward, and then tilt your hips and drive back, taking his length into your wide stretched body.\n");
				player.cuntChange(36.4, true);
				outputText("\n\nYou laugh at him, barely able to feel his dick within you, and whisper into his ear, \"<i>Just like a mouse to be tiny...</i>\" You watch his blush as you start to grind and roll atop his cock and belly, taking all the pleasure that you can from your slut.  ");
			}
			outputText("You cry out in pleasure as your orgasm floods through your body, causing your juices to splash out around your mouse slut's cock" + (player.hasCock() ? ", and your own [cocks] to explode with thick splashes of your hot cum across his chest and belly" : "") + ". You stay seated on his hips until your orgasm fades, then with a sigh of pleasure you stand off of him and dismiss him with a wave of your hand.  ");
			//Preggers chance!
			if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
			else player.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE + 82); //Jojo's kids take longer for some reason
			player.sexReward("cum","Vaginal");
			dynStats("cor", 0.5);
			endEncounter();
		}

		private function corruptJojoVaginalSmother():void {
			jojoSprite();
			clearOutput();
			outputText("You feel the need to gain a little sexual relief and a mischievous idea comes to your mind, making you grin wickedly. You slip off into the jungle to seek out your monk mouse fuck toy, and when you find him, you practically pounce atop him, pinning him to his back. He struggles in surprise until he realizes that it is you, at which point he blushes and tries to look away, unable to help the erection that you are sitting against as you straddle him.  ");
			outputText("You crawl further up his body and grin down at him as you press your already dripping pussy to his mouth and command sharply, \"<i>Start licking if you want to breathe.</i>\" His eyes go wide, but you can feel his tongue already starting to work at your lusty slit.  ");
			if (player.wetness() > 4)
				outputText("You moan as he works, your juices flowing liberally across his muzzle and into his mouth and nose, making him struggle not to drown in your pleasure as he focuses on giving you even more so.  ");
			else if (rand(2) == 0)
				outputText("You grind your slit against him as he eats you out, moaning with pleasure and writhing above him. You lift off of his face every so often, giving him just enough of a break to catch his breath before cutting it off with your pussy once again.  ");
			else outputText("You settle the full of your weight against his face and laugh as you feel him struggling to pleasure you, his nose and mouth trapped tight against your slit so that every attempt to breathe is halted, making him tremble breathlessly beneath you.  ");
			outputText("His tongue digs deep into your body, finally bringing you to an explosive climax that leaves you shuddering thoughtlessly above him. You actually forget you are sitting on his face for a moment, feeling him go still as he nearly passes out from lack of breath before you stand up.  ");
			outputText("He gasps for breath and coughs a few times, and once you are sure that he is safe, you laugh softly and walk back to your camp.  ");
			player.sexReward("saliva","Vaginal");
			dynStats("cor", 0.5);
			endEncounter();
		}

		private function corruptJojoAnalCruel():void {
			jojoSprite();
			clearOutput();
			var x:int = player.biggestCockIndex();
			outputText("You decided that it is time to seek out your pet monk slut, and stalk into the jungle after the mouse. It doesn't take long to find him, so you move silently to avoid his notice. You move with a predator's grace as you sneak up behind him, your hand reaching down to grab hold of his tail firmly as you shove him against a nearby tree.  ");
			outputText("You press your body up behind him" + (player.biggestTitSize() >= 2 ? ", mashing your breasts against his back" : "") + " and hiss into his ear, \"<i>Hello slut...</i>\" You keep hold of the base of his tail, hiking it up to lift his ass enough that he has to go to his toes to stay standing. You listen to him whimper softly as he feels your stirring loins press against the cleft of his oh-so-fuckable ass.  ");
			if (player.cocks[x].cArea() < 10)
				outputText("You saw your swelling erection between his ass cheeks a few times, and then with little warning, you shove yourself deep into his body, making the mouse gasp out as you fill his well-used rear. You groan in pleasure as you feel his anal ring grip in flutters along your " + player.cockDescript(x) + " as you spear in and out of him, fucking your slut toy with wild abandon.  ");
			else if (player.cocks[x].cArea() < 36)
				outputText("You press the mouse hard against the tree, inhaling his scent and sliding your " + cockDescript(x) + " between his firm cheeks.  There is little in the way of tenderness as you thrust deep into his body. You can hear him groan as your " + player.cockDescript(x) + " forces his intestines to shift to accommodate you.  ");
			else outputText("You grin as your mouse slut cries out with your " + player.cockDescript(x) + " spearing into his bowels. You can feel the weight of the tree against your " + player.cockDescript(x) + " as you force his belly to bulge out vulgarly to accommodate the enormous girth.  ");
			outputText("You thrust away at your squirming and mewling mouse, taking out your pleasure on him with little concern for his own enjoyment, not that this is really a problem, as before you manage to cum, you feel him tense as he 'fertilizes' the tree you have him pressed against. The feel of his orgasm milks you to your own explosion within his belly, emptying your balls with a low groan of relief.  ");
			outputText("You pull out of Jojo's ass once your orgasm has subsided and wipe your " + player.cockDescript(x) + " off on the fur of his back, then walk away to leave him to his own devices.  ");
			player.sexReward("no", "Dick");
			dynStats("cor", 0.5);
			endEncounter();
		}

		private function corruptJojoAnalGentle():void {
			jojoSprite();
			clearOutput();
			var x:int = player.biggestCockIndex();
			outputText("You watch as Jojo slinks into your camp from the dense jungle, moving timidly with his eyes focused on your feet. The sight of such a once pious monk reduced to your submissive fuck toy stirs your loins and brings a smile to your lips.  ");
			outputText("You pull him against your body in a firm and possessive hug, and press your lips to his in a forceful kiss, laughing as you break the kiss to the sight of his discomfort. You pay it little mind as you gently force him back onto the ground and spread his legs. You can see in his eyes that he knows what is coming, and you can see that he is as eager for it as he is humiliated by that eagerness.  ");
			if (player.cocks[x].cArea() < 10)
				outputText("You lift the mouse's balls out of the way and spit down onto the crinkled star of his anus, then lever your tip to the well-used hole. There is little ceremony or foreplay, but his cock is already straining erect, and a blush colors his cheeks as you push into his ass, inch by inch. You set a slow and tender pace at first, but as your orgasm nears, your thrusts become more animal and needy.  ");
			else if (player.biggestCockArea() < 36)
				outputText("You slide your thick and drooling cockhead beneath the mouse's balls, working the musky drool of your pre-cum against the well-used crinkle of his ass before forcing the thick vein-lined length of your " + player.cockDescript(x) + " into him. You watch as inch after thick, vulgar inch disappears into his body, grinning as his face contorts in a mix of pain and pleasure from it, and then start to fuck him in earnest, watching as his belly bulges with each thrust of your massive prick.  ");
			else outputText("You force your " + player.cockDescript(x) + " against the mouse's ass and watch as he shakes his head, silently begging you not to do it. You smile and grip his hips, then press forward hard, forcing his body to adapt to your girth, stretching his ass and belly dangerously. You can barely get more than a foot of your " + player.cockDescript(x) + " into him before bottoming out against his diaphragm, so you just fuck him with what you can, churning his insides with each thrust.  ");
			outputText("You pound away at the mouse's tight body for as long as you can, then feel your orgasm hit you hard, your balls drawing up tight as your seed churns and pulses through you and into the mouse's ass, filling his belly with your lust and corruption. You watch his belly swell with the seed in a beautifully vulgar display.  ");
			outputText("His eyes glaze over from the intensity of the act, his teeth tightly grit, and then you can hear a keening groan from him as he falls over the edge into his own orgasm, his untouched mouse cock bouncing and jerking on his belly as his thick seed is sprayed across his chest and face lewdly. He blushes deep at the visible proof that he enjoyed what you did to him and trembles beneath you.  ");
			outputText("You can't help but laugh at the scene, and draw out of his ass with a groan of pleasure. You watch as he crawls back into the jungle in shame, leaving a trail of your cum the whole way.  ");
			player.sexReward("Default","Dick");
			dynStats("cor", 0.5);
			endEncounter();
		}

		private function corruptJojoAnalSmother():void {
			jojoSprite();
			clearOutput();
			outputText("You feel the need to gain a little sexual relief and a mischievous idea comes to your mind, making you grin wickedly. You slip off into the jungle to seek out your monk mouse fuck toy, and when you find him, you practically pounce atop him, pinning him to his back. He struggles in surprise until he realizes that it is you, at which point he blushes and tries to look away, unable to help the erection that you are sitting against as you straddle him.  ");
			outputText("You crawl further up his body and grin down at him as he stares at your exposed pussy. You suddenly spin, sitting down the other way, so that your ass cheeks envelope his muzzle, trapping his nose and mouth against your tight pucker. \"<i>Get that tongue up in there slut.</i>\"  ");
			switch (rand(3)) {
				case 0:
					outputText("You grind your ass against him as he eats you out, moaning with pleasure and writhing above him. You lift off of his face every so often, giving him just enough of a break to catch his breath before cutting it off with your ass once again.  ");
					break;
				case 1:
					outputText("You settle the full of your weight against his face and laugh as you feel him struggling to pleasure you, his nose and mouth trapped tight against your ass so that every attempt to breathe is halted, making him tremble breathlessly beneath you.  ");
					break;
				default:
					outputText("You moan as he takes you at your word, spearing his tongue deep into your anus and thrusting it in and out as though it were a sleek-muscled shaft, making your body tremble in pleasure. It makes you wonder where he learned such a trick in his life as a pious monk.  ");
			}
			outputText("His tongue continues to work at your ass, finally bringing you to an explosive climax that leaves you shuddering thoughtlessly above him. You actually forget you are sitting on his face for a moment, feeling him go still as he nearly passes out from lack of breath before you stand up.  ");
			outputText("He gasps for breath and coughs a few times, and once you are sure that he is safe, you laugh softly and walk back to your camp.");
			player.sexReward("saliva","Anal");
			dynStats("cor", 0.5);
			endEncounter();
		}

		private function corruptJojoBreasts():void { //Should only be available to players with biggestBreastSize > 2
			jojoSprite();
			clearOutput();
			outputText("You lay yourself out for a quiet moment of self pleasure, your hands moving to your breasts and fondling them gently, when the sound of a snapping twig brings your attention to the edge of camp. Jojo stands timidly, half hidden within the shadows just outside your encampment, watching you with a look of submissive desire. You smile and lift your hand, beckoning him towards you with a crook of your finger.  ");
			outputText("Your mouse slut obediently slips from the darkness and into your camp, approaching you and kneeling at your side. You can see the lust in his eyes as he looks at your breasts, longing and love reflecting wonderfully. You nod your approval and let him worship your bosom.  ");
			if (player.biggestLactation() > 1) { //For suckling the scene is the same regardless of player's gender
				outputText("He leans in and starts to kiss along your nipples before taking one into his mouth. He gives a firm suckle at the engorged teat, and you can see his eyes open wider in surprise at the sudden surge of milk that fills his muzzle. He shivers and starts to suckle in earnest, drinking from first one breast, then the other, ");
				if (player.breastRows.length > 1) outputText("and then all the others, "); //Extra boob coverage
				outputText("partaking of your blessing until his belly is full.  ");
				player.milked();
			}
			if (flags[kFLAGS.JOJO_ANAL_XP] < 3) flags[kFLAGS.JOJO_ANAL_XP]++;
			else if (player.biggestTitSize() <= 5) {
				outputText("He leans in to nuzzle and kiss at your breasts, his hands moving to caress the soft and full orbs in gentle worship. His kissing and licking slowly circles in on your nipples, bringing them to firm points that send jolts of warm pleasure through your body when he at last takes them into his mouth. You reach down between your legs, " + (player.hasCock() ? "taking hold of your shaft and masturbating it lazily as he works.  " : "slipping your fingers into your slit as you lazily masturbate with the pleasure he brings.  "));
			}
			else {
				outputText("He leans in close and presses a kiss to first one nipple, then the other, starting to worship your breasts lovingly. You have other plans, however, and one hand grabs the fur at the back of his neck as the other slips beneath your breasts to pull them together to either side of his face as you press him in tight against the curves of your cleavage, forcing the mouse to fight for every breath.  ");
			}
			outputText("You can hear Jojo's breath quickening, then his body shudders as he climaxes spontaneously, splashing his seed across your hip and belly. You can't help the laugh that rises from within you at his submissive gesture, watching as shame washes across his face and his ears lay back.  ");
			outputText("He slinks back into the woods, chased by your amused laughter.");
			player.sexReward("cum");
			dynStats("cor", 0.5);
			endEncounter();
		}

		//Extra Scenes
		//[Jojo Whispered Sex scene]
		//(Requires the Whispered perk and Jojo as follower)
		private function whisperJojobait():void {
			clearOutput();
			outputText(images.showImage("akbal-deepwoods-male-jojosex"));
			var x:int = player.biggestCockIndex();
			outputText("You close your eyes and begin to think of Jojo.  You can feel the former monk's presence far away in the forest, futilely trying to meditate and rid himself of the corruption you so generously bestowed upon him.  He is sitting with one paw on his knee, and the other on his rigid tool.\n\n");
			outputText("He flinches as a chorus of voices begin whispering in his ear.  He looks around, wondering if he truly heard something or if he's just imagining the many beings saying such lewd things about him.  As you begin to visualize his body being dominated and forcibly made to submit to your every twisted whim, he begins to squirm as a stream of clear mouse-pre starts leaking down his ridged shaft.  After a moment's hesitation, he starts to head in your direction.\n\n");
			outputText("You turn up the pressure with a wicked smile, and watch the mousey begin to walk in wide strides as his orbs slowly swell.  He is soon so devastatingly aroused that he falls to his knees with a cry.  Through your mind's eye, you see him wrapping his fists around his shaft. He tries to masturbate in a desperate bid to relieve himself, but it is to no avail.  Your spell numbs his member every time he reaches for it, teasing and frustrating the mouse as he becomes increasingly aware that only you can relieve him of his steadily growing lust.  Unable to walk straight anymore, he crawls towards your camp on his hands and knees, his mouth snapped shut to stop himself from calling out and attracting the attention of any demon or creature that is not his master.\n\n");
			outputText("Jojo enters the edge of your camp with a wail, his once proud voice breaking as he begs you to come have your way with him.  You concentrate harder on the spell, sitting down as Jojo howls his woe for all the world to hear.  He is clawing the ground, dragging his belly through the dirt.  His balls are swollen to a massive size, stopping all but the tips of his toes from touching the ground.  His large swollen phallus drags behind him, leaving a river of spunky pre in its wake.\n\n");
			outputText("When he does finally reach you, with a labored breath he presents himself to you as best he can.");
			outputText("\n\n");

			outputText("You bend down to pat Jojo's obscenely swollen sac; you're determined to empty them of the liquid you hear sloshing around inside.  Jojo yelps as you do, your spell having made his body overtly sensitive to your touch.  ");
			//[Tentacle Penis]
			if (player.cocks[x].cockType == CockTypesEnum.TENTACLE) {
				outputText("His rodent tail wraps around your waist as you get into position, causing your " + player.cockDescript(x) + " to writhe even harder, searching for the hole Jojo's tail is pulling you towards.  As soon as you're close enough, your " + player.cockDescript(x) + " pushes into Jojo, twisting around to widen the mouse's hole even further.  Jojo squirms as you brutally stretch him out, stiffening once his hole is stretched to the max.  After admiring the now obscenely gaping hole of your mouse slut, you begin to grind your member around, causing Jojo to scream in ectasy as your " + player.cockDescript(x) + " goes ballistic inside of his hungry bowels.\n\n");
			}
			//[Small penis (7 inches or less)]
			else if (player.cockArea(x) < 13) {
				outputText("His hole flexes constantly, as if hungry for your " + player.cockDescript(x) + ". Jojo's tail wraps around your waist as you get into position, and you sink your " + player.cockDescript(x) + " into his hungry mouse hole.  The sensation of Jojo's hole quivering around your " + player.cockDescript(x) + "makes you smile as you begin thrusting in and out of him.  Jojo groans beneath you like a whore in heat, his ass moving in time to meet your thrusts.  The sound of your bodies clapping together is an applause as you fuck the little mousey without reservation.\n\n");
			}
			//[Medium penis (8-12 inches)]
			else if (player.cockArea(x) < 25) {
				outputText("His tail possessively wraps itself around your waist as you tease him with your " + player.cockDescript(x) + ", smearing your leaking pre all over his stretched tail hole.  You slide yourself into him with a sigh, feeling his hole quiver around your invading sex organ.  Jojo wails like a whore in heat beneath you, grunting as you begin to piston pump your swollen sex organ in and out of his greedy mousey hole.\n\n");
			}
			//[Large penis (13 inches and up)]
			else {
				outputText("Jojo's tail wraps around your waist as you get into position behind him, tightening possessively and trying to bring you closer.  You oblige the slut, sliding your " + player.cockDescript(x) + ", up the mouse's spread cheeks, teasing his ass with the underside.  When you slip your oversized sex organ into his hungry hole, you feel a cringe ripple through his entire body.  You can soon feel the earth beneath Jojo's stomach as the slow invasion of your " + player.cockDescript(x) + " is halted by the mouse's diaphragm; you're unable to fit more than a foot of its length into Jojo's overstuffed tail hole.  You withdraw slowly before suddenly shoving your hips forward, knocking the wind out of the little mousey.  Despite being stretched and filled beyond his limits, the mouse releases a pleased groan and begs for more.\n\n");
			}

			outputText("You feel the pressure building as you saw your " + player.cockDescript(x) + " in and out of Jojo's tail hole, brutally fucking the mouse.  Jojo moans in both ecstasy and pain, releasing a shrill squeak with every thrust.  He claws at the ground, both hungry for more and desperate for release.  The tip of his tail unwraps from your rapidly thrusting hips and slides down your [butt], spurring you to jackhammer his insides faster. The tip slips into your " + assholeDescript() + ", working your prostate as you abuse the mouse's.\n\n");

			//[With Fertility/Lots of Jizz Perk]
			if (player.cumQ() >= 1500) {
				outputText("You let out a roar as you cum together with Jojo.  Your hips work through your orgasm, fucking your seed deeper into the ex-monk even as you pump gallons of your sperm into him.  His bowels and stomach are filled in no time at all, causing your every thrust to squirt spunk out of his over-filled body.\n\n");

				outputText("Jojo howls like a whore in heat, squirming around your still-pumping " + player.cockDescript(x) + " as his fuzzy sac shrinks, your rough thrusts forcing his body flat against the ground once his sex organs have returned to normal size.\n\nAfter your orgasms have subsided, Jojo smiles up at you and thanks you over and over for 'saving' him.  You pull out, an ocean of creamy white spilling down his already cum-splattered fur, framing his tail hole with leaking gobs of milky liquid.\n\n");
				outputText("As you move away from the mouse, you step into a huge puddle of Jojo's creamy rodent cum and look back. You see that his dick, still trapped under his body and pointing behind the two of you, blasted long ropes of thick mouse spunk far into the depths of the forest.  Feeling the after-effects of your titanic orgasm, you lay next to your mousey whore and close your eyes, allowing him to curl up next to you as you both fall asleep, exhausted and beyond satisfied.\n\n");
			}
			//Without Fertility/Lots of Jizz Perk]
			else {
				outputText("You grit your teeth as you cum together with Jojo.  With one last great thrust, you slam your trunk into his mousey tail hole and unload into his tightly clenched bowels.\n\n");

				outputText("Jojo's balls begin to shrink as he shoots his own seed, your weight forcing his body flat against the ground once his sac has shrunk to normal.  His tail still slides around inside your [butt], spurring you to reward him with a few post-orgasm thrusts.  His bowels are hot and wet from your load, and you grind your " + player.cockDescript(x) + " around with a look of supreme bliss on your face.  Jojo groans as you pull out, releasing a stream of creamy white that slides down to his now normal-sized balls. Well... normal for Jojo.\n\n");
				outputText("As you move away from the mouse, you step into a huge puddle of Jojo's creamy rodent cum and look back. You see that his dick, still trapped under his body and pointing behind the two of you, blasted long ropes of thick mouse spunk far into the depths of the forest.  Feeling beyond satisfied, you give your mouse slut a quick scratch behind the ear as he passes out – cum splattered and smiling.");
			}
			player.sexReward("no", "Dick");
			endEncounter(120);
		}

//Bee on C. Jojo: Finished (Fenoxo) (Zedit)
private function beeEggsInCorruptJojo():void {
	clearOutput();
	outputText("Drawing Jojo close, you gently tease your fingertips along the soft fur of his cheeks, buzzing reassuring noises into his dish-shaped ears.  The greedy little slut perks up and nuzzles against you happily.  His hand, soft and delicate, reaches down inside your [armor] to touch your groin.  Its partner strays south to the mouse's own erection, gathering his copious pre to smear a fresh layer across his hardness.  You let him be for now, allowing him to build your lust higher and higher.  The show draws your ovipositor out of its slit and fills it with fresh blood, hardening the tubular organ into an approximation of a large phallus.");
	outputText("\n\nJojo, for his part, seems oblivious to the swelling protrusion or your malicious grin.  Once fully hard, you whisper to him, instructing for him to get on all fours and let you fuck him.  ");
	if(!player.hasCock()) {
		if(flags[kFLAGS.TIMES_EGGED_JOJO] == 0) outputText("Jojo looks confused at this; he knows you don't have a cock!  ");
		else outputText("Jojo looks confused at first, and then nods in understanding, remembering the last time you laid in him.  ");
	}
	outputText("He bends over, obedient slut that he is, lifting his ");
	if(tentacleJojo()) outputText("tentacle-");
	outputText("tail for you in an inviting motion.  His butt looks nice and cushy, a soft heart-shape just beckoning to be impaled on your rigid egg-tool.  You give the mouse-tush a hearty swat and smile at his squeak of surprise and winking anus.");

	outputText("\n\nMoving forward, you ");
	if(player.isNaga()) outputText("slither around him");
	else if(player.isGoo()) outputText("ooze over him");
	else if(player.isTaur()) outputText("straddle him");
	else outputText("climb atop him");
	outputText(".  Jojo looks up over his shoulder trustingly, swaying a bit from trying to hold up your body weight.  He starts to reach for his corruption-fueled boner, but of course, he has to drop his arm to hold himself upright.  The rodent whines plaintively, begging you to take him, stroke him... ANYTHING!  You gently shush him and sink your stinger into his backside, rewarding his obedience with a flash of pain and injection of fresh, unnatural lust.  His arms begin to shake, his butt begins to wiggle, and he starts to drool all over the ground, panting in a way that reminds you more of a canine than a mouse.");
	outputText("\n\nYou withdraw one insectile spear from the slut-mouse's rump and replace it with another, thicker prong.  Your honeyed ovipositor slides right into Jojo's welcoming anus, his rectum stretching to welcome the egg-pipe's healthy width.  A trickle of lubricating, honey-like fluid dribbles from the tip to aid the penetration, and in no time flat, the mouse's ass is a slick fuck-tunnel that sweetly squishes with each pump of your abdomen.  His thick, foot-long mouse-cock actually softens slightly and flops around with each thrust, trailing trickles of stringing pre-cum as you squeeze it out of him.");
	outputText("\n\nJojo mewls in pleasure when you push particularly hard and bottom out the heavy ovipositor, your stinger nearly scratching his balls.  A huge wad of semi-opaque cum drizzles from his cocktip, and he begins to push back against you like the willing fuck-pet that he is.  You grab him by the ears and begin to fuck him faster; the wet squelches carry through your camp to let anyone nearby know exactly what's going on.  You'd worry if you weren't lost in the moment, tugging his back and lewdly kissing him while your honey-flow thickens and the eggs shift into position.");
	outputText("\n\n\"<i>Here it comes pet,</i>\" you coo, \"<i>Let's see just how many eggs you can hold, hrmm?</i>\"");
	outputText("\n\nJojo whimpers and nods, his dick dripping a bit quicker at your words.  What a whore!  Gasping in pleasure, you feel the first egg begin to slide through your fuck-tube, the muscular contractions coaxing it deeper and deeper inside your pet.  Your organ, made to stretch as it is, easily handles the passage, but Jojo's butthole doesn't fare quite as well.  He is liberally strained by it, his poor prostate pressed so hard that a rope of thick fluid squirts from his cock, not from orgasm or pleasure, but because there is no room in his body for it.");
	outputText("\n\nThe white mouse moans lustily, trying to hump back against you, actually seeking more pressure on his prostate even though you've stopped thrusting.  Fortunately for him, you can feel your next egg squeezing down into your ovipositor, even as the first pops out into the rodent's gut.  Jojo gasps at the change in pressure before resuming his panting moans.  Even before the second egg has traversed half your length, the third makes itself known, nestling into the base and beginning its slow, pleasure-filled journey out your prong and into your pet's behind.");
	outputText("\n\nLaying eggs feels so goddamn good!  ");
	if(player.gender > 0) {
		outputText("Your ");
		if(player.hasVagina()) outputText("pussy ");
		if(player.gender == 3) outputText(" and [eachCock] ");
		if(player.gender == 1) outputText(multiCockDescriptLight() + " ");
		if(player.gender == 3 || player.cockTotal() > 1) outputText("are");
		else outputText("is");
		outputText(" gushing all over Jojo's back, but you don't feel particularly inclined to deal with your regular genitals.  ");
	}
	outputText("You're utterly focused on the silky feel of those smooth spheres rolling out of you, being implanted into a host, willing or not.  Thankfully, Jojo is willing, creaming the ground, sputtering strings of spunk with each new egg that you force inside his once-tight anus.  Orb after orb slides inside him, drawing shivers of ecstasy from your alien-looking egg-cock.  With an explosive clench, you cum and force the remainder of your eggs into the mouse-bitch's butt-cunt.");
	if(player.eggs() > 30) outputText("  His belly is slightly rounded by the time you finish, with small, egg-shaped bumps visible through his fur.");

	outputText("\n\nYou pull out with a self-satisfied smile, the ovipositor swiftly retracting into your body.  A trickle of golden honey pours from the mouse's abused anus to mix with his puddling spunk.  The relief you feel is palpable - you're light on your [feet] when you climb off him, and Jojo sighs, \"<i>Thank you for the orgasm!</i>\"");

	outputText("\n\nHe shambles off towards the woods when you dismiss him, his hard cock still dribbling mousey sperm the whole way.  You have to wonder if the eggs are sliding over his prostate with every step he takes?  Oh well, it's no concern of yours.");
	if (player.fertilizedEggs() > 0 && !pregnancy.isButtPregnant) {
		pregnancy.buttKnockUpForce(PregnancyStore.PREGNANCY_BEE_EGGS, 80);
	}
	flags[kFLAGS.TIMES_EGGED_JOJO]++;
	player.dumpEggs();
	player.sexReward("Default","Default",true,false);
	cleanupAfterCombat();
}
//Jojo Got Laid With Fertilized Bee Eggs (Zedit)
public function jojoLaysEggs():void {
	outputText("\nWhile passing time, you hear grunts of pleasure from the direction of the forest.  You amble over to investigate and find Jojo bent over, ass-up.  He's tugging on his cock non-stop, firing ropes of cum one after another while heavy, honey-slicked eggs roll out of his gaped anus to form an amber pile.");
	outputText("\n\nYou watch idly as the mouse gathers up the drizzling honey for lube and smears it over his cock, turning his twitching, orgasmic prick golden.  He pumps faster and faster, squeezing and jerking, moaning in lurid, unrestrained bliss.  Jojo is focused utterly on laying eggs and getting off, or maybe he's just getting off from the act of laying.  He's not even supporting his upper body - he just sits there, face down in the dirt, laying and cumming, laying and cumming.  His eggs are even drizzled with his wasted spunk, a testament to the debauchery of their surrogate 'mother'.");
	outputText("\n\nThe mouse turns his head to meet your gaze and whimpers, \"<i>Did... did I do a good job?</i>\"");
	outputText("\n\nYou start to answer, but the exhausted, anal-gaped slut slumps onto his side and starts snoring, exhausted and dripping both white and yellow.  The whole thing makes you feel a little hot under the collar, but there's nothing to do for now but head back to camp.\n");
	pregnancy.buttKnockUpForce(); //Clear Butt Pregnancy
}

// JOJO: THE EXPANSIONING
//Alternative Recruitment by LukaDoc
//Note: Since you are not corrupt here Jojo cannot sense you.
//Requirements: Level 4, Corruption < 20
public function lowCorruptionJojoEncounter():void
{
	monk = JOJO_MET;
	clearOutput();
	jojoSprite();

	outputText("Tired of exploring the forest for the moment, you decide to head back to camp.  Not feeling like taking the scenic route, you move to step through some bushes, but immediately your mind registers a yelp.  The instant you move to look at the source of the noise, a white blur smacks you right on your head.");

	if (player.tou >= 50 && player.isBiped())
		outputText("  You take a few steps back, momentarily dazed.  Shaking it off, you ready your [weapon] and assume a fighting stance.\n\n");
	else if (player.tou < 50 && !player.isBiped())
		outputText("The force of the blow knocks you flat on your [ass].  Shaking it off, you immediately climb to your feet and take on a fighting stance.\n\n");
	else if (player.isTaur())
		outputText("The blow does little more than leave you momentarily dazed but isn’t enough to knock you over.  You shake it off and ready your [weapon] as you assume a fighting stance.\n\n");
	else // Was originally isNaga() only, but this will also cover Drider just as well
		outputText("You recoil as you are struck, but the force of the blow does little more than leave you momentarily dazed. You assume a fighting stance, ready to defend yourself.\n\n");

	outputText("To your surprise you are greeted with the visage of a rather surprised mouse.\n\n");

	outputText("\"<i>Oh... erm... I’m sorry.  You spooked me,</i>\" he says apologetically, rubbing the back of his neck in embarrassment.\n\n");

	outputText("Do you accept his apology?\n\n");

	menu();
	addButton(0, "Yes", acceptJojosApology);
	addButton(1, "No", refuseJojosApology);
}

// Yes
public function acceptJojosApology():void
{
	clearOutput();
	jojoSprite();

	outputText("You forgive him for hitting you and apologize for spooking him yourself, prompting a relieved sigh.\n\n");

	outputText("\"<i>Thanks, it’s a relief to meet a friendly face,</i>\" he says, his mouth breaking into a smile. \"<i>Oh, where are my manners!</i>\"\n\n");

	lowCorruptionIntro();
}

//No
public function refuseJojosApology():void
{
	clearOutput();
	jojoSprite();

	outputText("With a smile you curl up a fist and knock the unsuspecting mouse morph upside the head, causing him drop his staff and rub the spot where you slugged him.  As he looks up at you you give his angry expression a shrug, telling him that now the two of you are even.\n\n");

	outputText("\"<i>O-Kay</i>\" The mouse says slowly, suddenly watching your movements very closely with those quick little eyes of his, \"<i>But I guess it’s fair, no harm done right?</i>\"\n\n");
	outputText("It’s all water under the bridge to you now; after all you did slug him real good. The two of you agree to start over.\n\n");

	lowCorruptionIntro();
}

private function rapeButton(btn:int, camp:Boolean):CoCButton {
	return addButton(btn, "Rape", camp ? jojoAtCampRape : jojoRape)
		.hint("Rape the poor monk." + (player.cor < 50 ? "  Why would you do that?": ""))
		.disableIf(player.lust < 33, "Not horny enough.")
		.disableIf(player.cor < 33, "You're not corrupted enough to betray your friend.")
		.disableIf(player.isGenderless(), "You're genderless...")
		.disableIf(flags[kFLAGS.DISABLED_JOJO_RAPE], "You can just ask him nicely.");
}

//Intro
public function lowCorruptionIntro():void
{
	outputText("He extends a hand, which you gladly shake. \"<i>My name is Jojo, pleased to meet you.</i>\" You introduce yourself in kind.\n\n");

	outputText("Now that you have the opportunity to take a good look at him, you notice that he is dressed in simple garbs reminiscent of a monk. A light-blue robe covers his flat chest, tied with a simple sash around his waist. His pants, similar to his robes, fit him snugly as well.\n\n");

	outputText("His build is lithe, though you detect he isn’t weak by any means. His handshake is firm and transmits confidence; it’s clear that this mouse has trained well, though you can’t see any hint of muscles with his robes covering him. His hair is short and as white as his fur, you’d guess he’s an albino if not for his brown eyes. Surprisingly, he doesn’t seem to be carrying anything on his person, save for a necklace made of beads.\n\n"); // Can't really presume that they're holy without knowing much more about him, rite?

	outputText("He smiles knowingly, \"<i>Yes I am a monk, and yes this is a strange place for one such as I... this world was not always this way.  Long ago this world was home to many villages, including my own.  But then the demons came.  I'm not sure if they were summoned, created, or simply a perversion of magic or breeding, but they came swarming out of the mountains to destroy everything in their path.</i>\"\n\n");

	outputText("Jojo sighs sadly, \"<i>Enough of my woes.  Though I ");
	if (player.cor <= 5) outputText("don't ");
	else outputText("barely ");
	outputText("feel any corruption within you, it’s always best to be prepared.  Would you care to join me in meditation?</i>\"\n\n");
	//Choices time!
	menu();
	addButton(0, "Meditate", meditateInForest); // OH GOD NO SEND HELP
	addButton(1, "Leave", explorer.done);
}

public function highCorruptionJojoEncounter():void {
	monk = JOJO_MET;
	SceneLib.jojoScene.jojoSprite();
	outputText("While marvelling at the strange trees and vegetation of the forest, the bushes ruffle ominously.  A bush seems to explode into a flurry of swirling leaves and movement.  Before you can react you feel your [feet] being swept out from under you, and land hard on your back.\n\n");
	outputText("The angry visage of a lithe white mouse gazes down on your prone form with a look of confusion.");
	outputText("\n\n\"<i>I'm sorry, I sensed a great deal of corruption, and thought a demon or monster had come to my woods,</i>\" says the mouse, \"<i>Oh, where are my manners!</i>\"\n\nHe helps you to your feet and introduces himself as Jojo.  Now that you have a good look at him, it is obvious this mouse is some kind of monk, dressed in robes, holy symbols, and draped with prayer beads.\n\nHe smiles knowingly, \"<i>Yes I am a monk, and yes this is a strange place for one such as I... this world was not always this way.  Long ago this world was home to many villages, including my own.  But then the demons came.  I'm not sure if they were summoned, created, or simply a perversion of magic or breeding, but they came swarming out of the mountains to destroy everything in their path.</i>\"");
	outputText("\n\nJojo sighs sadly, \"<i>Enough of my woes.  You are very corrupted.  If you cannot be sufficiently purified you WILL become one of them in time.  Will you let me help you?</i>\"");
	//Choices time!
	menu();
    addButton(0, "Accept", SceneLib.jojoScene.meditateInForest);
    addButton(1, "Decline", explorer.done);
	rapeButton(2, false);
}

//Repeat encounter
public function repeatJojoEncounter():void {
	if (player.hasStatusEffect(StatusEffects.Infested)) {
		SceneLib.jojoScene.jojoSprite();
		clearOutput();
		outputText("As you approach the serene monk, you see his nose twitch, disturbing his meditation.\n\n");
		outputText("\"<i>It seems that the agents of corruption have taken residence within the temple that is your body.</i>\", Jojo says flatly. \"<i>This is a most unfortunate development. There is no reason to despair as there are always ways to fight the corruption. However, great effort will be needed to combat this form of corruption and may leave lasting impressions upon you. If you are ready, we can purge your being of the rogue creatures of lust.</i>\"\n\n");
		//Choices time!
		menu();
        addButton(0, "Meditate", SceneLib.jojoScene.meditateInForest);
        addButton(1, "Purge", SceneLib.jojoScene.wormRemoval).hint("Request him to purge the worms from your body.");
		rapeButton(2, false);
        addButton(4, "Leave", explorer.done);
		return;
	}
	SceneLib.jojoScene.jojoSprite();
	outputText("Jojo the monk appears before you, robes and soft white fur fluttering in the breeze.  He asks, \"<i>Are you ready for a meditation session?</i>\"");
	//Choices time!
	menu();
    doYesNo(SceneLib.jojoScene.meditateInForest, explorer.done);
	rapeButton(2, false);
}

public function corruptJojoEncounter():void {
	SceneLib.jojoScene.jojoSprite();
	clearOutput();
	outputText("You are enjoying a peaceful walk through the woods when Jojo drops out of the trees ahead, ");
	if (monk == 2) outputText("his mousey visage twisted into a ferocious snarl.  \"YOU!\" he screams, launching himself towards you, claws extended.");
	if (monk == 3) outputText("unsteady on his feet, but looking for a fight!");
	if (monk == 4) outputText("visibly tenting his robes, but intent on fighting you.");
	if (monk == 5) outputText("panting and nude, his fur rustling in the breeze, a twitching behemoth of a cock pulsing between his legs.");
	startCombat(new Jojo());
}

public function meditateInForest():void {
	jojoSprite();
	clearOutput();
	outputText("Jojo smiles and leads you off the path to a small peaceful clearing.  There is a stump in the center, polished smooth and curved in a way to be comfortable.  He gestures for you to sit, and instructs you to meditate.\n\nAn indeterminate amount of time passes, but you feel more in control of yourself.  Jojo congratulates you, but offers a warning as well.  \"<i>Be ever mindful of your current state, and seek me out before you lose yourself to the taints of this world.  Perhaps someday this tainted world can be made right again.</i>\"");

	dynStats("str", .5, "tou", .5, "int", .5, "wis", .5,"lib", -1, "lus", -5, "cor", (-1 - player.countCockSocks("alabaster")));

	if (!player.hasStatusEffect(StatusEffects.JojoMeditationCount))
		player.createStatusEffect(StatusEffects.JojoMeditationCount, 1, 0, 0, 0);
	else player.addStatusValue(StatusEffects.JojoMeditationCount, 1, 1);

	if (player.statusEffectv1(StatusEffects.JojoMeditationCount) >= 5) {
		outputText("\n\nJojo nods respectfully at you when the meditation session is over and smiles.  ");
		//Forest Jojo Eligible for Invite After Meditation but There's Trash in Camp -Z
		if (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && player.statusEffectv1(StatusEffects.JojoMeditationCount) % 5 == 0) {
			//replaces 'Jojo nods respectfully at you [...] "It seems you have quite a talent for this. [...]"' invite paragraphs while Treefingers is getting slut all over your campsite
			//gives Small Talisman if PC never had follower Jojo or used it and ran from the fight
			if (player.hasKeyItem("Jojo's Talisman") >= 0) { //[(if PC has Small Talisman)
				outputText("Jojo smiles at you.  \"<i>[name], well done.  Your talent at focusing is undiminished.  Regarding the other issue... you still have the item I gave you?</i>\"");
				outputText("\n\nYou hold up the talisman, and he nods.  \"<i>Good.  Stay safe and signal me with it if you need help.</i>\"");
			}
			else { //(else no Small Talisman)
				outputText("Jojo nods at you respectfully.  \"<i>Well done today; your dedication is impressive.  We could meditate together more often.</i>\"");
				outputText("\n\nAs much as you'd like to, you can't stay in the forest, and you can't invite him back with you right now.  Reluctantly, you mention the stubborn, demonic godseed's presence on the borders of your camp.  Jojo's eyebrows furrow in concentration.");
				outputText("\n\n\"<i>Yes, that's a problem.  Oh, that we did not have to resist the very spirit of the land!  [name], take this.  Use it to call me if the demon gives you trouble; I will come and render what aid I can.</i>\"  The monk fishes in his robe and places a small talisman into your hand.\n\n(Gained Key Item: Jojo's Talisman)");
				//get a small talisman if not have one
				player.createKeyItem("Jojo's Talisman", 0, 0, 0, 0);
			}
			endEncounter(120);
			return;
		}
		else
			outputText("\"<i>It seems you have quite a talent for this.  We should meditate together more often.</i>\"");
	}
	if (player.statusEffectv1(StatusEffects.JojoMeditationCount) % 5 == 0)
	{
		outputText("\n\nYou ponder and get an idea - the mouse could stay at your camp.  There's safety in numbers, and it would be easier for the two of you to get together for meditation sessions.  Do you want Jojo's company at camp?");
		doYesNo(jojoScene.acceptJojoIntoYourCamp, curry(explorer.done,120));
	} else {
		outputText("\n\nHe bows his head sadly and dismisses you.");
		endEncounter(120);
	}
}


public function acceptJojoIntoYourCamp():void {
	jojoSprite();
	if (player.hasStatusEffect(StatusEffects.EverRapedJojo) || flags[kFLAGS.JOJO_MOVE_IN_DISABLED] == 1) {
		outputText("You offer Jojo the chance to stay at your camp, but before you can finish your sentence he shakes his head 'no' and stalks off into the woods, remembering.");
	}
	else {
		clearOutput();
		outputText("You offer Jojo the chance to stay at your camp.  He cocks his head to the side and thinks, stroking his mousey whiskers.\n\n\"<i>Yes, it would be wise.   We would be safer together, and if you like I could keep watch at night to keep some of the creatures away.  I'll gather my things and be right there!</i>\"\n\nJojo scurries into the bushes, disappearing in a flash.  Knowing him, he'll be at camp before you!");
		player.createStatusEffect(StatusEffects.PureCampJojo, 0, 0, 0, 0);
	}
	endEncounter();
}

//Jojo In Camp
// Player approaches pure Jojo in camp, gets offer to mediate if > 10 cor -- responses
//[Yes]
public function acceptOfferOfHelp():void
{
	clearOutput();
	jojoSprite();

	outputText("<i>\"Thank Marae.  You’re much stronger than I, my friend... to hold so much corruption and still retain your will.  But let us not tempt fate,\"</i> he says before the two of you get to it.\n\n");

	jojoFollowerMeditate(false);
}

//[No]
public function refuseOfferOfHelp():void
{
	clearOutput();
	jojoSprite();

	outputText("You assure Jojo you're fine, and that you'll consider his offer.  \"<i>But... I... we...</i>\" he stammers. \"<i>Alright, but please do not let the corruption get the better of you.  You’re my friend and I couldn't bear to lose you to its vile influence.</i>\"  He recomposes himself and asks, \"<i>So... is there anything I can assist you with?</i>\"\n\n");
	jojoCampMenu();
}

public function jojoCamp2():void {
	if (!player.hasStatusEffect(StatusEffects.LunaOff) && !player.hasStatusEffect(StatusEffects.LunaWasWarned)) {
		if ((flags[kFLAGS.LUNA_JEALOUSY] > 200 && rand(10) < 4) || (flags[kFLAGS.LUNA_JEALOUSY] > 300 && rand(10) < 8)) mishapsLunaJojo();
		else jojoCamp();
	}
	else jojoCamp();
}

public function jojoCamp():void {
	clearOutput();
	jojoSprite();
	if (flags[kFLAGS.AMILY_MET_PURE_JOJO] == 0 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower()) {
        SceneLib.followerInteractions.amilyMeetsPureJojo();
        return;
	}
	if (flags[kFLAGS.JOJO_RATHAZUL_INTERACTION_COUNTER] == 1 && rand(2) == 0) {
        SceneLib.followerInteractions.catchRathazulNapping();
        return;
	}
	if (player.hasStatusEffect(StatusEffects.Infested)) { // Worms overrides everything else
		outputText("As you approach the serene monk, you see his nose twitch.\n\n");
		outputText("\"<i>It seems that the agents of corruption have taken residence within the temple that is your body,</i>\" Jojo says flatly, \"<i>This is a most unfortunate development.  There is no reason to despair as there are always ways to fight the corruption.  However, great effort will be needed to combat this form of corruption and may have a lasting impact upon you.  If you are ready, we can purge your being of the rogue creatures of lust.</i>\"\n\n");
		jojoCampMenu();
		return;
	}
	if (player.cor > 10 && flags[kFLAGS.JOJO_LAST_MEDITATION] != model.time.days) { //New "offer of help" menu
		if (player.cor >= 40) {
			outputText("You walk toward the boulder where Jojo usually sits, and as soon as you're close Jojo approaches you with urgency.  \"<i>By Marae! [name], we must do something! I feel the corruption surrounding you like a dense fog.  We need to meditate or I’m going to lose you!</i>\" Jojo pleads.\n\n");
		}
		else {
			outputText("You walk up to the boulder where Jojo usually sits, and see him sitting cross-legged with his eyes closed.  He seems to be deep in meditation, but when you approach his eyes open suddenly and he gets up appearing slightly distressed, \"<i>Uh... [name], I can feel a bit of corruption within you.  It is not much, but I think you should be concerned about it before it gets out of hand and you do something you might regret.  If you want to I'd be happy to meditate with you as you rid yourself of it.</i>\" he offers with a concerned look on his face.\n\n");
		}
		outputText("Do you accept Jojo's help?\n\n");
		doYesNo(acceptOfferOfHelp, refuseOfferOfHelp);
		rapeButton(4, true);
	}
	else { //Normal shit
		if (player.cor > 10)
			outputText("You walk up to the boulder where Jojo usually sits, and see him sitting cross-legged with his eyes closed.  He seems to be deep in meditation, but when you approach his eyes open suddenly and he gets up appearing slightly distressed, \"<i>Uh... [name], " + (player.cor >= 40 ? "I feel the corruption surrounding you like a dense fog.  We need to meditate more or I’m going to lose you!" : "I still can feel a bit of corruption within you.  It is not much, but I think you should be concerned about it before it gets out of hand and you do something you might regret.") + "  If you want to I'd be happy to meditate with you as you rid yourself of it.</i>\" he offers with a concerned look on his face. \n\n");
		else {
			switch (rand(3)) {
				case 0: outputText("You walk toward the boulder where Jojo usually sits, and see him cross-legged with his eyes closed.  At first, he seems to be deep in meditation, but when you approach his mouth curls into a smile; he gets up and opens his eyes regarding you with a welcoming expression.  \"<i>Greetings [name], is there anything I can assist you with?</i>\"\n\n");
						break;
				case 1: outputText("You walk up to the boulder where Jojo usually sits and find him a few paces behind it. He is standing and practicing his form, gracefully moving from one pose to the next. As you approach him you see his ears visibly perk and he turns his head towards you without breaking his stance, saying, \"<i>Greetings [name], is there anything I can assist you with?</i>\"\n\n");
						break;
				default: outputText("You find Jojo sitting cross-legged on a flat rock with his staff leaning against his shoulder, thinking.  He looks to you and nods, \"<i>Greetings, [name].  Is there something I could do to assist you?</i>\"\n\n");
			}
		}
		jojoCampMenu();
	}
}

private function jojoCampMenu():void {
//Normal Follower Choices
//[Appearance] [Talk] [Train] [Meditate] [Night Watch toggle]
	var jojoDefense:String = "N.Watch:";
	if (player.hasStatusEffect(StatusEffects.JojoNightWatch)) {
		outputText("(Jojo is currently watching for enemies at night.)\n\n");
		jojoDefense += "On";
	}
	else jojoDefense += "Off";
	menu();
	addButton(0, "Appearance", jojoAppearance).hint("Examine Jojo's appearance.");
	addButton(1, "Talk", talkMenu).hint("Discuss with him about topics.");
	if (flags[kFLAGS.UNLOCKED_JOJO_TRAINING] == 1) addButton(2, "Train", apparantlyJojoDOESlift).hint("Join him in a training session.");
	addButton(3, "Meditate", jojoFollowerMeditate);
	addButton(4, jojoDefense, jojoDefenseToggle).hint((player.hasStatusEffect(StatusEffects.JojoNightWatch) ? "Request him to stop guarding the camp.": "Request him to guard the camp at night."));
	if (player.hasStatusEffect(StatusEffects.Infested)) addButton(5, "Purge", wormRemoval).hint("Request him to purge the worms from your body.");
	if (player.lust >= 33 && monk <= -3)
        addButton(8, "Sex", pureJojoSexMenu).hint("Initiate sexy time with the mouse-morph.");
	else rapeButton(8, true);
	addButton(14, "Leave", camp.campFollowers);
}


//Appearance
public function jojoAppearance():void
{
	clearOutput();
	jojoSprite();
	outputText(images.showImage("jojo-appearance"));
	outputText("Jojo is a white furred mouse-morph with dish-like ears and a small muzzle below a sometimes twitchy nose. He watches you with striking blue eyes.\n\n");

	outputText("He's wearing pale blue monk robes that are form fitting yet loose enough to allow him to move freely if the need arises. He also wears prayer beads, a cloth sash that holds his robe close and baggy pants cover his legs all the way to his mouse-like footpaws; on the back of his pants a small hole is cut to allow his ropy pink tail freedom.\n\n");

	outputText("It's hard to estimate due to his clothing, but you can tell he is pretty lean and doesn't have much in the way of muscle; which makes sense since his martials arts rely more on speed than strength anyways.\n\n");

	outputText("His weapons of choice are his fists and a polished wooden staff he wields with practiced hands, right now it is tucked away in his bedroll.\n\n");
	menu();
	doNext(jojoCamp);
}

public function talkMenu():void
{
	jojoSprite();
	menu();
	addButton(0, "Village", jojoTalkVillage).hint("Ask him about the village he was raised in.");
	addButton(1, "Monks", jojoTalkJoiningTheMonks).hint("Ask him about how and why he became a monk.");
	addButton(2, "MonksFall", jojoTalkFallOfTheMonks).hint("Ask him about the demise of the monks.");
	addButton(3, "Forest", jojoTalkForestConvo).hint("Ask him about how he ended up in the forest.");
	if (flags[kFLAGS.TIMES_TALKED_WITH_JOJO] >= 4) addButton(4, "You", jojoTalkYourOrigin).hint("Tell him about Ingnam and your history.");
	if (flags[kFLAGS.FACTORY_SHUTDOWN] > 0) addButton(5, "Factory", jojoTalkFactory).hint("Tell him about how you've shut down the factory.");
	if (flags[kFLAGS.SAND_WITCHES_COWED] == 1 || flags[kFLAGS.SAND_WITCHES_FRIENDLY] == 1 || flags[kFLAGS.SAND_MOTHER_DEFEATED] == 1) addButton(6, "SandCave", jojoTalkSandCave).hint("Tell him about your encounter in the Sand Cave in the desert.");
	if (flags[kFLAGS.UNLOCKED_JOJO_TRAINING] == 0 && flags[kFLAGS.TIMES_TALKED_WITH_JOJO] >= 4) addButton(7, "Training", apparantlyJojoDOESlift).hint("Ask him if he's willing to train you.");
	if (flags[kFLAGS.MINERVA_PURIFICATION_JOJO_TALKED] == 1 && flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] < 10) addButton(8, "Purification", SceneLib.mountain.minervaScene.minervaPurification.purificationByJojoPart1).hint("Ask him if he can exorcise the demonic parasite infesting Minerva.");
	//Sex button
	if (player.cor <= (10 + player.corruptionTolerance) && player.lust >= 33) {
		addButton(9, "Sex?", offerSexFirstTime).hint("Ask him if he's willing to have sex with you.");
		if (flags[kFLAGS.TIMES_TALKED_WITH_JOJO] < 4) addButtonDisabled(9, "Sex?", "You should socialize with Jojo a bit more.");
		//if (player.hasStatusEffect(StatusEffects.EverRapedJojo)) addButtonDisabled(9, "Sex?". "You've raped Jojo in the past, now you can't ask him out.");
	}
	if (player.cor <= 10 && player.lust >= 33 && monk == -1) addButtonDisabled(9, "Sex?", "You need to spend more time with Jojo. \n\nTalk sessions: " + flags[kFLAGS.TIMES_TALKED_WITH_JOJO] + "/6 \nTraining sessions: " + flags[kFLAGS.TIMES_TRAINED_WITH_JOJO] + "/10 \nMeditation sessions: " + player.statusEffectv1(StatusEffects.JojoMeditationCount) + "/10 \nYou must be pure enough and have sufficient lust as well.");
	if (player.cor <= 10 && player.lust >= 33 && flags[kFLAGS.TIMES_TALKED_WITH_JOJO] >= 6 && flags[kFLAGS.TIMES_TRAINED_WITH_JOJO] >= 10 && player.statusEffectv1(StatusEffects.JojoMeditationCount) >= 10 && monk > -3) addButton(9, "Sex?", offerSexFirstTimeHighAffection).hint("You've spent quite the time with Jojo, maybe you can offer him if he's willing to have sex with you?"); //Will unlock consensual sex scenes.
	if (monk <= -3) removeButton(9);
	if (TyrantiaFollower.TyrantiaFollowerStage == 5) addButton(10, "Tyrantia", TyrantiaEggQuestJoJo);
	addButton(14, "Back", jojoCamp);
}

private function TyrantiaEggQuestJoJo():void {
	clearOutput();
	outputText("You ask Jojo about his holy mantras and abilities, and if he could purify the unborn in such a way. You tell him about Tyrantia’s desire to have a family, and her guilt over her own corruption and how that’d affect a child.\n\n");
	outputText("Jojo shakes his head, sending a ripple through his fur. \"<i>My methods draw upon a conscious desire to be free from taint and corruption.</i>\" He sits down. \"<i>I will meditate on your request, but I do not believe that I can help you.</i>\" You thank Jojo for his time and walk away, heavy-hearted.");
	advanceMinutes(15);
	doNext(talkMenu);
}

//Talk
//Jojo’s Past

//Village Convo
public function jojoTalkVillage():void
{
	clearOutput();
	jojoSprite();
	flags[kFLAGS.TIMES_TALKED_WITH_JOJO]++;
	outputText("You decide to ask Jojo about his village.\n\n");
	outputText("He speaks softly with a smile on his face and in his voice, \"<i>It was a small village near a large beautiful lake. We were peaceful people who laughed and trusted one another, just good simple folk you know?\"\n\n");
	outputText("\"Most of the people of Belridge were either fishers or farmers with huge families that stayed near the village. There were a few hunters and a few craftsmen. We made enemies of no one and sought to do no harm to others,</i>\" Jojo says, his smile fading.\n\n");
	outputText("Before you can muster a reaction to his sadness, his fuzzy cheeks spread again as he looks up at you with bright eyes.\n\n");
	outputText("\"<i>My father was a fisherman.  He was this calm, strong man with a lot of silver whiskers that always smelled like fish.  I remember I used to go out on the boat with him and a few of my brothers and he’d always make sure to pick me up and put me on his shoulders... that is until I got too big. He always made everything look so easy, like the world was just there to shake his hand and make him smile. No one could cook seafood like he did, no one.</i>\"\n\n");
	outputText("\"<i>Then there was my mother who was a little high strung, but no one could hug you more fiercely or love you more dearly.  She was a small woman with a big soul who loved her family more than anything.  She was a seamstress before she met my dad and was always the brightest one in the room, which is hard when you have seventeen loud children clamoring for your attention.</i>\"\n\n");
	outputText("\"<i>Even with 19 people living under one roof my family wasn’t the biggest family in town, but there was always plenty work and plenty food.  It was a nice simple existence and I am thankful for the time I had with everyone in that village,</i>\" he finishes with a serene smile.\n\n");
	if (player.cor < 40)
	{
		outputText("Looks like Jojo's childhood wasn't so bad... you thank the mouse morph monk for sharing his treasured memories with you now that the conversation is over.\n\n");
	}
	else
	{
		outputText("Looks like Jojo’s childhood wasn’t so bad. A little sickly sweet and void of wet pussies and drooling dicks but not bad. You tell him you’re happy to have him near you and he smiles for ear to ear, ignorant of your thoughts.\n\n");
	}
	doNext(talkMenu); // Dunno where exactly to kick back to, fuck it, back to camp yo!
	advanceMinutes(5);
}

//Joining the Monks convo
public function jojoTalkJoiningTheMonks():void
{
	clearOutput();
	jojoSprite();
	flags[kFLAGS.TIMES_TALKED_WITH_JOJO]++;
	outputText("You decide to ask Jojo why he decided to become a monk in the first place.\n\n");
	outputText("He gives you a warm smile as he speaks, \"<i>Well I grew up in a big family of 19 so when I was younger I was always the quiet one.  I guess I was just introverted but being quiet meant that I didn’t always get a lot of attention.  It didn’t bother me, quite the opposite actually, I enjoyed quiet introspection but with so many brothers and sisters it was next to impossible to get a quiet moment at home.</i>\"\n\n");
	outputText("\"<i>So I would sneak out. My father understood but it drove my mother crazy.  Whenever she noticed I had slipped away she would stop everything in the house and take my two oldest brothers to come find me.  I never understood why it was such a big deal.  We were in a small village near a prestigious monastery, we were safe.  Parents let their kids go out and play and run and explore because everyone knew everyone but not my mom.  She had to know where you were going, what you were doing and how long until you got back. I would’ve told her but saying I wanted to explore wasn’t a satisfactory answer.</i>\"\n\n");
	outputText("\"<i>Whenever she found me she would yell for a bit and then hold me close like she’d just watched me dodge a charging rhinoceros.  Whenever she asked why I did it I just told her the truth, it was too loud and crowded at home.  After a few weeks of this she suggested a compromise.  She said I could leave if I had one of my older brothers walk me to the temple, and I stayed there, where the clergy could see me and keep me safe and fed.  Honestly I think my dad came up with the idea, he was always good at compromising and keeping the peace.</i>\"\n\n");
	outputText("\"<i>The temple became very important to me.  I read about the world, I spoke to the clergy and I sat and thought.  I was enraptured with learning but I didn’t want to be a priest, I don’t know why... I guess it just didn’t appeal to me.  When I first saw the monks visiting the temple, it was like dawn breaking.  After that I waited until I was old enough to join and made the short pilgrimage to the Monastery of the Celestial Lotus.</i>\"\n\n");
	outputText("Jojo wears this quiet little smile as he finishes.  Then he chuckles and says, \"<i>Thank you for the memories, [name].  I enjoy our talks.</i>\"\n\n");
	doNext(talkMenu);
	advanceMinutes(5);
}

//Fall of the Monks convo
public function jojoTalkFallOfTheMonks():void
{
	clearOutput();
	jojoSprite();
	flags[kFLAGS.TIMES_TALKED_WITH_JOJO]++;
	outputText("You decide to ask Jojo if he'd be willing to tell you exactly what happened to the monks of his order.\n\n");
	outputText("Jojo speaks with eyes downcast and a voice soft as feathers landing on fallen soldiers, \"<i>Truthfully?...  I don’t know exactly how it happened... or why... but my order was wiped out.  Though I've looked for my brothers and sisters of the Celestial Lotus ever since then, I'm the only survivor, as far as I can tell.  You see, the demons attacked the monastery while I was away with one of the senior brothers.  I was a mere novice and he was one of the most fun teachers so we lost track of time.  The sun was setting and we were halfway back to the monastery when we saw what we thought was a huge column of smoke rising from the central building.  When we got closer we saw the cloud for what it truly was, a billowing tower of those imps.  We were spotted and several of them came flying at us - they crossed the distance far faster than we could have.</i>\"\n\n");
	outputText("\"<i>Senior Brother Logray didn't hesitate - he leapt in front of me, staff twirling, shattering skulls and breaking limbs with each sweep.  As he barred their path, he cried out to me to flee, to run for the safety of the village... and I did.  Overwhelmed by the bitter-sweet stink of corruption wafting off the demons, I ran like a frightened little field mouse.  I was a coward and I left my masters and all my friends to face the horde one mouse short.</i>\"\n\n");
	outputText("You watch as Jojo bows his head in shame for a moment. Yet when he looks back up there’s fire in his eyes.\n\n");
	outputText("\"<i>Never again....</i>\"\n\n");
	outputText("You try to comfort Jojo, telling him he couldn’t have made a difference being but a single mouse, but he waves you off.  He tells you he is fine and thanks you for your concern.\n\n");
	outputText("You can tell the story has affected him, but you’re surprised to hear the resolve in his voice and see the defiant strength in his eyes. Excusing yourself, you rise and leave him to do as he will.\n\n");
	doNext(talkMenu);
	advanceMinutes(5);
}

//Forest Convo
public function jojoTalkForestConvo():void
{
	clearOutput();
	jojoSprite();
	flags[kFLAGS.TIMES_TALKED_WITH_JOJO]++;
	outputText("You think for a while and decide to ask Jojo how he ended up in the forest.\n\n");
	outputText("He looks at you with suddenly tired eyes as he says, \"<i>Well, I was training in the fields with one of the senior brothers when we saw the monastery was under attack.  He sent me to the village to save me since I was a novice.  I decided to rally the people there.  I figured that I had ran like a coward, I wasn’t going to hide like one.  It was the village where I was born and a home to many of my brothers and sisters, both figuratively and literally.  I ran towards the village with everything I had, hoping to redeem my cowardice by returning with a militia of mice to aid the members of my order.</i>\"  His voice catches and he looks away, obviously struggling to form words.\n\n");
	outputText("When you open your mouth to speak he raises his hand, asking for a moment with a single furry finger.\n\n");
	outputText("\"<i>I was too late.  The demons had struck there first, then moved on to my monastery once they were finished.  I spent hours searching the streets; every basement, every alley, every attic, every place I could think of where somebody might have hidden.  Nothing but ruined buildings, smears of assorted tainted bodily fluids, and the occasional corpse - some demons, many more mice.</i>\"\n\n");
	if (player.cor < 35)
	{
		outputText("That's terrible... you can only imagine what you'd feel like if you returned to Ignam and saw it destroyed... your family, your friends... You put a hand on the monk's shoulder, intent on comforting him for the moment.\n\n");
	}
	else if (player.cor >= 35 && player.cor <= 75)
	{
		outputText("Tough luck... thankfully your village still stands and you doubt any demons would dare attack on your watch...  You feel like you should do something for the monk though, so you put a hand on his shoulder, comforting him for the moment.\n\n");
	}
	else
	{
		outputText("Mice... must've been a village of wimps if a few demons could take them out... The monk is obviously distressed... maybe you should comfort him for the moment, if only to make him stop.  You put a hand on his silent shoulder...\n\n");
	}
	outputText("\"<i>Thank you [name].  I was born there and seeing that...</i>\"  The monk falls silent again.\n\n");
	if (player.cor < 35)
	{
		outputText("You slide an arm around Jojo’s shoulders in an attempt to reassure the monk.  He manages a smile in response as he looks up at you.  A single tear manages to slide down his muzzle as he says, \"<i>Thank you, my friend.</i>\"\n\n");
	}
	else if (player.cor >= 35 && player.cor <= 75)
	{
		outputText("You try to further console the distressed monk by moving your hand to his back and giving him a few friendly taps.  Jojo visibly pulls himself together. \"Thank you, I’m alright now,\" he tells you as he looks up and gives you a weak smile.\n\n");
	}
	else
	{
		outputText("Seeing an opportunity, you wrap your arms around the monk as he silently tries to reign in his emotions.  Holding him close you can feel the mouse morph’s lean muscles as you rub his back ‘accidentally’ going too low and feeling the base of his tail and the top of his tight little pert ass.  As you ‘hug’ the mouse you make sure he doesn’t notice your true intentions and when you release him he actually thanks you.\n\n");
		dynStats("lus+", 10);
	}
	outputText("After you’ve comforted the monk you ask him what he did next.\n\n");
	outputText("When he answers you his shoulders are squared and his voice has regained some of its former volume, \"<i>I did what anyone looking at the shattered remains of their life would.  I buried them.  For the next few hours I took the time to lay each and every villager to rest before praying over them all.  Then I went back to my monastery, praying with all my heart that they had managed to hold out, at least long enough to escape rather than to be captured and twisted into perverse shells of their former selves.  Yet the monastery was another graveyard.  I found many bodies there.  Some were of the order but there were also countless imps and more than a few demons.  The place was defiled with semen and milk reeking of corruption.</i>\"\n\n");
	outputText("You see anger in the monk’s eyes as he clenches his fists, \"<i>They had utterly defiled the monastery and there was nothing I could do about it but honor its memory.  I labored for what felt like days; burying the fallen; seeking out survivors; gathering what few items of my faith had escaped demonic desecration.</i>\"  He touches the large beads around his neck meaningfully.\n\n");
	outputText("\"<i>Then, I burned the monastery to the ground and set fire to all the fields...  Since that day, I have eked out a meager existence in the wilderness; I study the texts I can, train my body as best I can, and seek to fortify my soul against demonic blandishments.  Though I have technically progressed far along my path, with no master and only a pale echo of a fraction of my order’s texts at my disposal, I may never be a true master in my own right.</i>\"\n\n");
	outputText("He gives you an appraising look before looking away, \"<i>Until I met you, [name], my only purpose had been to find the demons who destroyed my order and make them pay for the lives they took.  That is why I was in the forest, I was in the middle of a harsh training regimen to increase my power and skill so that I may seek out those evil brutes who took everything I loved away from me... but vengeance is not the way of the Celestial Lotus.  The Celestial doesn’t train bullies or assassins.  Finding you and aiding in your quest to protect your village from these demonic creatures of perversion gave me new purpose and would make my departed brothers and sisters proud.  I can’t honestly say I’ve given up on having my vengeance but... I will aid you in your quest first if for nothing more than to honor our friendship and honor the memory of the order and its teachings.</i>\n\n");
	outputText("Looking renewed and at peace despite the emotional storm you know must be raging within his tiny frame Jojo returns to what he was doing after thanking you for giving him new purpose.\n\n");
	doNext(talkMenu);
	advanceMinutes(5);
}

//Yourself
//Origin
public function jojoTalkYourOrigin():void // Prob tack on some interaction count or something to unlock this
{
	clearOutput();
	jojoSprite();
	flags[kFLAGS.TIMES_TALKED_WITH_JOJO]++;
	outputText("As you start up a conversation with Jojo, the two of you speak at length about nothing really important or noteworthy, just small talk.  That is until the monk brings up the subject of your background.  You tell him about Ingnam and your family there, and the tradition of sending a champion through the portal.  When he asks why anyone would choose to come here, you tell him how legends say that in years a champion wasn’t sent through the portal, terrible things happened to the village.\n\n");
	outputText("\"<i>That portal?</i>\" Jojo asks, pointing to the very portal you stumbled through. You nod and he asks, \"<i>So... what were you like in Ingnam?</i>\"\n\n");
	if (player.hasPerk(PerkLib.HistoryAlchemist)) {
		outputText("You tell Jojo that you were the assistant to Riku, an alchemist residing in your village.  He asks questions about your time with the alchemist and how your family felt about you taking up alchemy.  You tell him that you were just about to go into advanced studies when it was announced that you were the next champion and all you really learned was how to increase the potency of certain types of items.\n\n");
	}
	else if (player.hasPerk(PerkLib.HistoryCultivator)) {
		outputText("You tell Jojo about how you spent your time training to become a soul cultivator.  Hearing this little monk get slight more interested and asked you to say more about this cultivator and his chosen path, on which you gladly reply telling all you remembered.\n\n");
	}
	else if (player.hasPerk(PerkLib.HistoryFighter)) {
		outputText("You tell Jojo about how, growing up, you got into fights a lot.  You name names and tell him why and how each of those little brats had got what was coming to them. You tell him how you had planned to join the village guard, but that became a pipe dream when it was announced that you were the next champion.\n\n");
	}
	else if (player.hasPerk(PerkLib.HistoryFortune)) {
		outputText("You tell Jojo about how you're lucky and you've made quite a bit of money.  When the monk asks how, you shrug and tell him it's just plain luck.\n\n");
	}
	else if (player.hasPerk(PerkLib.HistoryHealer)) {
		outputText("You tell Jojo about how you spent a lot of your time at the side of Dende, the village healer. You talk about why you wanted to spend time with the older man as he looked after the sick and infirm and the skills you learned there. You let him know how you had just decided to train to become an official healer when you were announced to be the next champion.\n\n");
	}
	else if (player.hasPerk(PerkLib.HistoryReligious)) {
		outputText("You tell Jojo about how you spent most of your time in the temple. He seems to really like hearing about the differences in religious practices between the Celestial Lotus and your village. You tell him about the various clergy of your hometown and how Sister Esther took time to teach you about meditation.\n\n");
	}
	else if (player.hasPerk(PerkLib.HistoryScholar)) {
		outputText("You tell Jojo about your insatiable thirst for knowledge and how you spent a lot of time in school. You tell him the story about how you ‘convinced’ Mr. ");
		if (EngineCore.silly()) outputText("Savin");
		else outputText("Sellet");
		outputText(" to let you read some of the rare books in his collection, skipping over how much begging and pleading was actually involved.\n\n");
	}
	else if (player.hasPerk(PerkLib.HistoryScout)) {
		outputText("You tell Jojo about how you spent your time training with any bow you could find.  You tell him how you had planned to join the village hunters squad, but that became a pipe dream when it was announced that you were the next champion.\n\n");
	}
	else if (player.hasPerk(PerkLib.HistorySlacker)) {
		outputText("You tell Jojo about how you spent your time basically relaxing with your fiends.  You gloss over how big of a lazy bum you were with stories of the times you generally made a nuisance of yourself.  You don’t tell him that you’re pretty sure you were chosen as the next champion in order to be gotten rid of.\n\n");
	}
	else if (player.hasPerk(PerkLib.HistorySlut)) {
		outputText("You tell Jojo about how you spent time... making friends.  Jojo looks at you weirdly and when you tell him you had a lot of friends....\n\n");
		outputText("\"<i>That’s nice I guess [name] but didn’t you have aspirations beyond being, erm... popular?</i>\" he questions.\n\n");
		outputText("You laugh and tell him that you were just really good and making friends, instead of the truth about how much of a slut you actually were.\n\n");
	}
	else if (player.hasPerk(PerkLib.HistorySmith)) {
		outputText("You tell Jojo about how you spent your time training to become a blacksmith.  Not knowing much about smithing he asks questions about the things you learned and you answer them to the best of your ability.  To finish you describe the process of fitting armor in great detail and how you were going to start learning advanced techniques but were announced to be the next champion.\n\n");
	}
	else if (player.hasPerk(PerkLib.HistoryTactician)) {
		outputText("You tell Jojo about how you spent your time learning many different war tactics from a retired commander that lived in your village. Especially on making anyone under your following put more than 100% of their effort.\n\nJojo seems disinterested in the many violent tactics you have learned. Eventually, he changes the subject.\n\n");
	}
	else if (player.hasPerk(PerkLib.HistoryWhore)) {
		outputText("You tell Jojo about how you spent a lot of your time... making money.  When the naive little monk asks how, you just smile as you fondly remember the older whore, Poison, showing you the ropes and teaching the tricks of the trade.  Regardless of how it made people think of you, it was certainly good money.  In an attempt to hide some of the messier details of your past from the monk, you explain how you accepted... odd jobs for people, important work that not many others in the village would be willing to accept.  He seems confused but shrugs it off.\n\n");
	}
	else if (player.hasPerk(PerkLib.HistoryFeral)) {
		outputText("You tell Jojo about how you spent a lot of your time in the wild. You tell him that before arriving in Mareth, you were living your life among a pack of wild wolves.  \n\n");  // I am not a writer, feel free to amend.
	}
	else {
		outputText("You're not sure where to start. You have been doing countless activities before arriving in Mareth that it'd be virtually impossible to list all of them. It's almost impossible to choose where to start or what to even begin talking about. It comes to the point where you're not sure if there's anything you HAVEN'T done.\n\n");
	}
	outputText("Jojo smiles now that he has gotten to know you a little better. After a little bit more small talk, the two of you decide the conversation is over and part ways.\n\n");
	doNext(talkMenu);
	advanceMinutes(5);
}

//Dungeon Convo: Factory
//Requirements: Completed Demon Factory -- flags[kFLAGS.FACTORY_SHUTDOWN] > 0
public function jojoTalkFactory():void
{
	clearOutput();
	jojoSprite();
	flags[kFLAGS.TIMES_TALKED_WITH_JOJO]++;
	outputText("You tell Jojo about your having successfully found and stopped the demonic factory.  You tell him how you found out the factory was there and how you defeated the demons inside. He seems impressed.\n\n");
	if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2)
	{
		outputText("His ears perk at the news as you continue, telling him that you destroyed the factory controls, which permanently shut down the factory - but released an enormous quantity of corrupted fluids into the environment.\n\n");
		outputText("Jojo cocks his head to the side as he considers his words carefully before speaking, \"<i>I guess it seems like the right move.  Permanently disabling the factory would not only deal a heavy blow to the demons, but also give the rest of us time to reclaim the forest... but I don’t know.  If the release of fluids was as much as you say it was then there’s a chance that it’ll do more harm than good.  I’ve seen what corruption does to this world and that much corrupted fluid flooding out all at once could really hurt our cause. I’m not saying it was the wrong thing to do, or lessening your accomplishment, but you have to be careful.  The demons aren’t just powerful, they’re deceptive.</i>\"\n\n");
		outputText("You listen to the monk’s council and despite his concerns he seems genuinely happy to hear you’ve struck a blow against the demonic regime.\n\n");
	}
	else
	{
		outputText("His ears perk at the news as you continue, telling him that you shut down the factory and destroyed the controls, for the sake of the surrounding environment.\n\n");
		outputText("Jojo’s chest swells with pride as he looks at you with new eyes before saying, \"<i>Wow [name], I don’t know what to say.  I know it uprooted your life and took you away from the ones you love but I sincerely believe that the day you came through that portal was a good day for all of Mareth.  I am proud of you and humbled by the fact that I can call you my friend.</i>\"  He rises and gives you a hug of fierce devotion and friendly affection before pulling away and saying, \"<i>We’ll have to watch the factory though... the demons can’t be allowed to reopen that evil place.</i>\"\n\n");
	}
	outputText("Once the two of you are done discussing the demonic factory Jojo excuses himself to think on what you’ve told him.\n\n");
	doNext(talkMenu);
	advanceMinutes(5);
}

//Dungeon Convo: Sand Cave
//Requirements: Completed Sand Witch Dungeon
public function jojoTalkSandCave():void
{
	clearOutput();
	jojoSprite();
	flags[kFLAGS.TIMES_TALKED_WITH_JOJO]++;
	outputText("You tell Jojo about your discovery of a cave that served as a base for the sand witches of the desert. You tell him about the whole ordeal, and he listens with wide eyes and jaw agape. When you tell him about meeting the Sand Mother Jojo gasps.\n\n");
	outputText("\"<i>Wait... so you mean to tell me that these sand witches a-are... allies of Marae?  But they’re s-so... sexual.</i>\"  He seems genuinely confused, but you tell him that sex is part of nature after all, and that there is nothing wrong or shameful about it.  He agrees with you, but decries the way the sand witches use their power.\n\n");
	//if PC raped Sand Mother
	if (flags[kFLAGS.SAND_WITCHES_COWED] == 1)
	{
		outputText("You describe your battle with the Sand Mother in an animated blow-by-blow fashion, and when you get to the end where you raped the Sand Mother you look at Jojo and... lie.  You completely gloss over the fact that you sexually assaulted the Sand Mother, because despite his interest, he is a little naive and offended by the world of sexual conquest.  He appraises your actions, ignorant of what actually occurred.\n\n");
	}
	//if PC spoke to Sand Mother after Fighting her
	// FRIENDLY is the overall victory flag (theres a separate flag used to indicate you dun wanna be attacked by sandbitches in the desert anymore)
	else if (flags[kFLAGS.SAND_WITCHES_FRIENDLY] == 1 && flags[kFLAGS.SAND_MOTHER_DEFEATED] == 1)
	{
		 outputText("You describe your battle with the Sand Mother in an animated blow by blow. When you get to the end you tell him about how reasonable the Sand Mother actually was after you beat her.\n\n");
		 outputText("Jojo’s head tils to the side as he says, \"<i>Maybe the whole thing didn’t need to come to an altercation in the first place, a little diplomacy on both sides....</i>\"  He gives you a pointed look, \"<i>Might have gone a long way.</i>\"\n\n");
	}
	//if PC just spoke to the Sand Mother
	else if (flags[kFLAGS.SAND_WITCHES_FRIENDLY] == 1 && flags[kFLAGS.SAND_MOTHER_DEFEATED] == 0)
	{
		outputText("You tell Jojo about how the Sand Mother spoke with you once you had battled your way to her.  You tell him she was reasonable and how the whole thing was, in the end, a simple misunderstanding.\n\n");
		outputText("He marvels at the way you handled the situation, \"<i>Many would have expected her trying to talk to them to be a trap [name] and hurried to attack her but not you... that is... wow [name], you are truly a great individual.</i>\"\n\n");
	}
	//[if {PC met bath slut}
	if (flags[kFLAGS.MET_MILK_SLAVE] == 1)
	{
		outputText("You tell Jojo about the poor mind addled thing you found sitting in a tub of milk acting as a slave to the sand witch coven.\n\n");
		outputText("He shudders like a child being told a scary story and asks, \"<i>What did you do?</i>\"\n\n");
		//[if {PC hasn’t spoken to Sand Mother about Bath Slut yet}
		// Can't differentiate this
		// All I have is HAS_MET and HAS_RECRUITED effectively
		if (flags[kFLAGS.MILK_NAME] is Number)
		{
			outputText("You tell Jojo about how the Sand Mother told you the bath girl was unfit to be free and how they care for her because she can’t care for herself.\n\n");
			outputText("Jojo reacts by putting his chin in his hands and thinking, \"<i>Well... I guess that’s the human thing to do, especially since she doesn’t seem to be corrupted.  Maybe these sand witch covens aren’t all bad, still hard to believe that they’re on our side though....</i>\"  He looks up and shrugs, \"<i>Any act of charity though is a good thing.  I do hope the poor girl will be alright.</i>\"\n\n");
		}
		// [if {PC has bath slut in camp}
		else if (flags[kFLAGS.MILK_NAME] is String)
		{
			outputText("As the question leaves his lips you give Jojo a confused look and, with a glance, direct his gaze toward " + flags[kFLAGS.MILK_NAME] + ".\n\n");
			outputText("He slaps his own forehead and says, \"<i>Oh... yeah... right.</i>\" Obviously embarrassed by not putting two and two together. He smiles good naturedly though, \"<i>I don’t know I guess I just assumed you found some poor mind addled soul and decided to save her.</i>\" Jojo says as he looks over at " + flags[kFLAGS.MILK_NAME] + ".\n\n");
			//[if (bathSlutStage1 - unaltered)
			if (flags[kFLAGS.MILK_SIZE] == 0)
			{
				outputText("\"<i>She’ll fare much better in our care than in the coven’s,</i>\" he states with conviction.\n\n");
			}
			//[if (bathSlutStage2 - HHH)
			else if (flags[kFLAGS.MILK_SIZE] == 1)
			{
				outputText("\"<i>She’s already much better than she was when she got here,</i>\" he says with a grin.\n\n");
			}
			//[if (bathSlutStage3 - DD)
			else
			{
				outputText("\"<i>The coven wouldn’t have done what you’ve done for her.  You’ve given her a much, much better life and even aided in fixing her condition, you truly are a champion, [name],</i>\" he says, giving you a fond smile and a pat on the back.\n\n");
			}
		}
	}
	// There's an untracked gap here, where the player doesn't accept a blessing from the Cum Witch, but there's no other existing tracking for this shit.
	//[if {PC met Cum Witch}
	if (flags[kFLAGS.CUM_WITCH_DEFEATED] == 1 || flags[kFLAGS.BEEN_BLESSED_BY_CUM_WITCH] == 1)
	{
		outputText("You tell Jojo about the cum witch, the herm witch responsible for inseminating the witches there, acting as a father to the others.  When you do he scratches his ear, \"<i>Like I said, I don’t get why sex is so overly important to these creatures but whatever, continue.</i>\"\n\n");
		//[if {PC allowed Cum Witches to increase their numbers}
		if (flags[kFLAGS.MORE_CUM_WITCHES] == 1)
		{
			outputText("You tell him how you tried to remedy the current cum witch’s situation by asking the Sand Mother to make more cum witches.\n\n");
			outputText("He whistles low, \"<i>That’s a bold move [name].  It seems like they would want that though, it’d allow them to, er, you know... more often, and make more sand witches in the long run wouldn’t it?</i>\" As the question sound rhetorical you plow on ahead.\n\n");
		}
		//[if {PC allowed Cum Witches to rome}
		else if (flags[kFLAGS.CUM_WITCHES_FIGHTABLE] == 1)
		{
			outputText("You describe to him how you convinced the Sand Mother to allow her cum witches to rome the desert along with the sand witches and he looks at you with astonishment, \"<i>You are a generous spirit [name] and this Sand Mother doesn’t seem entirely unreasonable.</i>\"\n\n");
		}
		//[if {PC did nothing to help Cum Witch}
		else
		{
			outputText("\"You tell Jojo that you’re actually done. He says, \"<i>Oh... Well, that’s weird.</i>\" and after an awkward silence, the two of you burst out laughing.\n\n");
		}
	}
	outputText("Having concluded the conversation the two of you stand and Jojo gives you an appreciative pat on the shoulder, seeming more fond of you.\n\n");
	doNext(talkMenu);
	advanceMinutes(5);
}

//Training
// Initiate first time as a talk option, and then display as a "base menu" option?
public function apparantlyJojoDOESlift():void
{
	clearOutput();
	jojoSprite();
	//{First Session only}
	if (flags[kFLAGS.UNLOCKED_JOJO_TRAINING] == 0)
	{
		flags[kFLAGS.UNLOCKED_JOJO_TRAINING] = 1;
		outputText("You ask Jojo if he can teach you how to fight like a monk.\n\n");
		outputText("Jojo considers you for a moment before saying, \"<i>Yes I can teach you the forms, skills and techniques I was taught by my order. Plus...</i>\" Jojo gazes off into the distance, his attention drifing for a moment before he continues, \"<i>since I am all that is left, it is up to me to bestow this knowledge upon a worthy soul.</i>\"\n\n");
		if (player.cor >= (25 + player.corruptionTolerance))
		{
			outputText("Jojo frowns, \"<i>I am willing to teach you [name], when I can.  However I am no master, therefore I am unworthy of taking a disciple.  But as your friend, I will teach you what I know so that you may protect yourself.  I believe our time would be better spent meditating.  There is very little you can do with these techniques without first finding your center.</i>\"\n\n");
			// Kick back to previous menu
			doNext(jojoCamp);
			return;
		}
		else
		{
			outputText("Jojo smiles, \"<i>I am not a master, therefore I am unworthy of taking you on as a disciple... but as a friend I can teach you all I know.  Whenever you are ready, just ask.</i>.\"\n\n");
			// Sounds like this should kick back to menu
			doNext(jojoCamp);
			return;
		}
	}
	// {Repeatable Generic Training Session Stuffs}
	else
	{
		if (player.fatigue >= player.maxOverFatigue() - 150)
		{
			outputText("You ask the monk to continue your training; but he shakes his head.\n\n");
			outputText("\"<i>Not yet [name]. Your body must be fit and rested before our training sessions. Rest first, and come back to me later.</i>\"\n\n");
			doNext(jojoCamp);
			return;
		}
		if (player.cor >= (25 + player.corruptionTolerance))
		{
			outputText("You ask the monk to continue your training; but he shakes his head.\n\n");
			outputText("\"<i>I fear that your time would be better spend meditating before we continue your training. Would you like to do so now?</i>\"\n\n");
			menu();
			doYesNo(jojoFollowerMeditate, jojoCamp);
			return;
		}
	}
	flags[kFLAGS.TIMES_TRAINED_WITH_JOJO]++;
	trace(flags[kFLAGS.TIMES_TRAINED_WITH_JOJO]);
	// {If everything is cool}
	if (!player.hasPerk(PerkLib.ControlledBreath) && !player.hasPerk(PerkLib.CleansingPalm) && !player.hasPerk(PerkLib.Enlightened))
	{
		outputText("Jojo gives you a bright cheerful smile, \"<i>Alright [name]... let’s begin.</i>\"\n\n");
		outputText("Jojo’s teaching style periodically switches between lecture and sparring.  When he explains a concept or a strike, he guides you through it before asking you to try it on him. He is patient but firm.  He doesn’t punish you when you make a mistake, instead, corrects you and asks you to try again.  He doesn’t allow you to give up, and his teaching style stops you from feeling frustrated.\n\n");
		outputText("The entire session is intense, and each brief lecture or demonstration serves as a quick break to stop your body from giving out, and help you build endurance.\n\n");
		outputText("By the end of the training session you are covered in sweat, your lungs heaving for breath.\n\n");
		outputText("As you bow to Jojo he bows back and says, \"<i>Go get some rest [name], you’ve earned it.</i>\"\n\n");
		fatigue(150);
		if (flags[kFLAGS.TIMES_TRAINED_WITH_JOJO] == 5)
		{
			trace("ADDING FIRST PERK");
			outputText("\"<i>Breathing is key.</i>\"\n\n");
			outputText("Jojo’s constantly repeated words resonate within you as you realize you’ve learned to control your breathing. It takes you less time to rest than normal and you feel as though you are bursting with energy because of it.  Your [fullChest]");
			if (player.biggestTitSize() == 0) outputText(" rises and falls");
			else outputText(" rise and fall");
			outputText(" smoothly even in the heat of battle.  From now on you know you’ll recover more quickly.\n\n");
			outputText("<b>(Perk Gained: Controlled Breath -</b> Increases rate of fatigue/mana/soulforce regeneration by 20%<b>)</b>");
			player.createPerk(PerkLib.ControlledBreath, 0, 0, 0, 0);
		}
	}
	//{after the PC has gained the controlled breath perk}
	else if (player.hasPerk(PerkLib.ControlledBreath) && !player.hasPerk(PerkLib.CleansingPalm) && !player.hasPerk(PerkLib.Enlightened))
	{
		outputText("Jojo gives you a big toothy grin, \"<i>Alright [name]... let’s begin.</i>\"\n\n");
		outputText("Jojo switches up the way he is instructing you.  Largely due to your increased endurance, the two of you spend more time moving through forms together and practicing strikes and maneuvers.  When it comes time for a brief lecture, he breaks out one of the few scrolls he has from his order and tells you what he knows about the contents.\n\n");
		outputText("Before too long, the two of you are up again and practicing forms and mock strikes, even sparring briefly from time to time.  By the end of the intense training session you are covered in sweat... but so is Jojo, and neither of you are out of breath. As you bow to Jojo he returns the gesture and says, \"<i>Go get some rest [name], you’ve earned it.</i>\"\n\n");
		fatigue(150);
		if (flags[kFLAGS.TIMES_TRAINED_WITH_JOJO] == 10)
		{
			trace("ADDING SECOND PERK");
			outputText("The repeated movements are slowly starting to sink in, your muscles becoming accustomed to Jojo’s training.\n\n");
			outputText("By the end of the training session with the mouse, you think that you may have picked up something that might help against the denizens of this world.\n\n");
			outputText("<b>(Ability Gained: Cleansing Palm -</b> A ranged fighting technique of Jojo’s order, allows you to blast your enemies with waves of pure spiritual energy, weakening them and hurting the corrupt.<b>)</b>");
			player.createPerk(PerkLib.CleansingPalm, 0, 0, 0, 0);
		}
	}
	//{after the PC has gained the Cleansing Palm attack}
	else if (player.hasPerk(PerkLib.ControlledBreath) && player.hasPerk(PerkLib.CleansingPalm) && !player.hasPerk(PerkLib.Enlightened))
	{
		outputText("Jojo gives you a big smile brimming with pride, \"<i>Alright [Name]... let’s begin.</i>\"\n\n");
		outputText("Largely due to your increased endurance and improved technique the two of you spend more time sparring and dancing through the forms Jojo knows.  When it comes time for a brief lecture, Jojo pants as he sits with you, taking a minute to regain his breath.  Jojo’s lectures, instead of dealing with how to strike and defend oneself, deal with the nature of the soul.  You learn much about individuality, willpower and determination and after the lecture the two of you meditate on what you’ve learned for a few silent moments.\n\n");
		outputText("Then the two of you are back up, sweeping gracefully through forms and striking invisible enemies with fierce blows.  By the end of the intense training session both you and Jojo are tired, having trained to both of your limits.\n\n");
		outputText("As the two of you give each other decidedly shaky bows, Jojo says, \"<i>Great effort [name], you are... wow... I need a rest. I’ve earned it.</i>\"  The two of you share a laugh and end you training.\n\n");
		fatigue(150);
		if (flags[kFLAGS.TIMES_TRAINED_WITH_JOJO] >= 15 && player.inte >= 70)
		{
			trace("ADDING THIRD PERK");
			//{text shows after generic 16th technique training session}
			outputText("As you finish training you decide to meditate alone; returning to your " + camp.bedDesc() + ", you close your eyes and begin to breathe.  Then the world around you begins to sing.\n\n");
			outputText("The camp is alive with the sounds of voices on the wind, of the ominous sizzling of the great scar between worlds that is the portal that brought you here.  You feel open to the universe as if it were a lady in a dress sitting next to you, that you could easily reach out and touch.  You feel liberated and free despite the fact that you are not moving a muscle.  You are ready for anything but expecting nothing.  You are neither thinking nor dreaming, you simply are.\n\n");
			outputText("<b>(Perk Gained: Enlightened -</b> White magic threshold reduced. Meditation restores health. Grants the ability to meditate alone.<b>)</b>");
			player.createPerk(PerkLib.Enlightened, 0, 0, 0, 0);
		}
	}
	//{after PC has gained the Enlightened Perk}
	else
	{
		outputText("Jojo smiles, \"<i>In all honesty [name], I should be asking you to teach me, but I’ll do my best.</i>\"\n\n");
		outputText("There are no lectures.  Neither you nor Jojo are masters, but as of right now, the two of you have exhausted the small store of knowledge available to you from the Celestial Lotus.  You and Jojo instead practice to exhaustion, heaving and panting for breath, whilst still finding time to enjoy each other's company.\n\n");
		fatigue(150);
		//{each scene only shows if the follower is there}
		var enlightenedBlurbs:Array = [];
		enlightenedBlurbs.push("You can hear Jojo’s feet move through the campsite as he heads toward his rock, seeking rest after your training session.");
		// Lookit all these different ways followers are tracked! fml.
		if (player.hasStatusEffect(StatusEffects.CampMarble)) enlightenedBlurbs.push("You can hear Marble humming a song to herself you can’t place.");
		if (flags[kFLAGS.AMILY_FOLLOWER] > 0) enlightenedBlurbs.push("You can hear Amily changing the bedding to her nest.");
		if (SceneLib.emberScene.followerEmber()) enlightenedBlurbs.push("You can hear Ember cleaning" + emberScene.emberMF("his", "her") + "scales.");
		if (player.hasStatusEffect(StatusEffects.CampRathazul)) enlightenedBlurbs.push("You can hear Rathazul experimenting with surprisingly nimble fingers.");
		if (sophieFollower() && !player.hasStatusEffect(StatusEffects.SophieOff)) enlightenedBlurbs.push("You can hear Sophie breathing as she sleeps.");
		if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] > 0) {
			if (flags[kFLAGS.IZMA_BROFIED] > 0) enlightenedBlurbs.push("You can hear Izmael doing push-ups to stay fit.");
			else enlightenedBlurbs.push("You can hear Izma flipping through the pages of a book.");
		}
		if (SceneLib.helScene.followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff)) enlightenedBlurbs.push("You can hear Helia throwing her fists at nothing.");
		outputText(enlightenedBlurbs[rand(enlightenedBlurbs.length)] + "\n\n");
	}
	//Boost attributes!
	if (player.canTrain('str', player.trainStatCap("str",80))) {
		dynStats("str", 2); //Str boost to 80
		player.trainStat("str", 1, player.trainStatCap("str",80));
	}
	if (player.canTrain('int', player.trainStatCap("int",80))){
		dynStats("int", 2); //Int boost to 80
		player.trainStat("int", 1, player.trainStatCap("int",80));
	}
	if (player.canTrain('wis', player.trainStatCap("wis",100))){
		dynStats("wis", 6); //Wisdom boost to 100
		player.trainStat("wis", 3, player.trainStatCap("wis",100));
	}
	endEncounter();
}

public function wormRemoval():void {
	jojoSprite();
	clearOutput();
	outputText("\"<i>Excellent, young one,</i>\" Jojo continues. \"<i>Your dedication to purification is admirable. Relax and know that the parasites will leave you soon.</i>\"\n\n");
	outputText("Jojo gets up and walks over to a backpack hidden in the bushes. He removes a lacquered box. He removes and combines a rather noxious combination of herbs, oils and other concoctions into a mortar and grinds it with a pestle. After a few minutes, he ignites the mixture and uses a feathered fan to blow the fumes over you. The smell of the mix is nauseating and repugnant. Your stomach turns and you fight the urge to vomit. Eventually, you are no longer able to resist and you purge yourself onto the ground. Cramping from your vomiting fits, you wrack with discomfort, which slowly builds to genuine pain. As the pain sets in, you feel a stirring deep in your crotch. The worms inside you are stirring and thus are compelling another unwanted orgasm. Unable to control your body, your cock explodes, launching cum and worms everywhere. Jojo begins fanning faster as he sees the worms leave your body.\n\n");
	outputText("\"<i>Further endurance is needed, young one,</i>\" Jojo says. \"<i>The root of your problem must leave before you may pursue further purification. Healing is always twice as uncomfortable as the illness requiring attention.</i>\"\n\n");
	outputText("Your body cramps up as you feel the fat worm struggle. You feel it pushing up your urethra, fighting to escape your fumigated body. The worm rapidly peeks from the end of your penis. With expedience, Jojo quickly grabs the worm and pulls it out of you, triggering one last orgasm. The monk casts the fat worm to the ground and strikes it dead with his staff.\n\n");
	outputText("\"<i>The culprit has been exorcised and will no longer trouble you. Rest here for a while and join me in some meditation to heal your exhausted body and soul.</i>\"\n\n");
	outputText("Being too tired for anything else, you join Jojo in meditation, which does much to relive you of your former woes.");
	//Infestation removed. HP reduced to 50% of MAX. Sensitivity reduced by -25 or reduced to 10, which ever is the smaller reduction.
	//Infestation purged. Hit Points reduced to 10% of MAX. Corruption -20.
	if (player.HP > int(player.maxHP() * .5)) player.HP = int(player.maxHP() * .5);
	player.damageHunger(30);
	player.removeStatusEffect(StatusEffects.Infested);
	player.buff("Infested").remove();
	dynStats("lus", -99, "cor", -15);
	player.orgasm();
	endEncounter();
}

public function jojoFreaksOutSoulless():void {
	outputText("Jojo suddenly takes notice of the all damning aura of corruption surrounding you and backs off in horror.\n\n");
	outputText("\"<i>Wait, that's not possible, how could I have missed this aura of smothering corruption?!? You're no longer normal, you're actually a demon! What have you done to your soul [name]!</i>\"\n\n");
	outputText("Jojo is already adopting a defensive pose ready to defend his purity and chastity. What will you do?\n");
	menu();
	addButton(0, "Save me", saveMeFromMyWickedness).hint("You might have lost your soul but despite all odds you might have managed to keep a karma good enough that Jojo will still be willing to hear you out.");
	addButton(4, "Rape", jojoAtCampRape).hint("It's time to initiate that virgin to sex!");

	function saveMeFromMyWickedness():void {
		outputText("[pg]You kneel down before the monk, who stares at you astonished, as though working out what could have been the last fading glimmer of your purity. You beg him to save you from yourself. You've gone too far, you see that now. You're growing afraid of what you've become and what you might do to your friends. Temptation invites you to turn them into toys yet you resist. What even led you down this path?! Yet despite how messed up you've become you still have a soul… sealed within a pendant next to your heart. Telling Jojo of this is the next best thing to laying down and offering your head in apology, if he decides to execute you. Yet you know this is the only way you're getting out of this mess.");
		outputText("[pg]Jojo eyes you down before replying solemnly \"<i>The path to redemption is a harsh one [name], each impurity chaining your soul will be twice as hard to remove now. Thankfully you still got a soul albeith outside your body otherwise I would be powerless to do anything at all. If you indeed are serious about it I will need to purge the corruption out of your body bit by bit. You're not likely to ever be pure again and will still be constantly at war with yourself to contain your demonic urges but at least that's a start I will need something extraordinary to perform what I'm about to do here. I know this might sound impossible but in order to cleanse you I will require an artefact of great purity, some item of legend sanctified by the gods. A miracle requires a miracle and thus the item will probably be destroyed in the process.</i>\"");
		outputText("[pg]On this note, Jojo takes a safe distance from you. He doesn't trust you fully… not anymore but still he's willing to give you a chance.");
		outputText("[pg]\"<i>Once you have the item, meet me in the forest. For my own safety I'm leaving your camp until you do.</i>\"");
		SceneLib.alvinaFollower.JojoDevilPurification = 1;
		endEncounter();
	}
}

public function jojoForestPurifyMeFromDevilry():void {
	jojoSprite();
	clearOutput();

	outputText("As you venture into  the woods you run into jojo who nods at you.[pg]");
	outputText("\"<i>So you came after all [name] I was worried you would lose this near impossible battle with yourself. I can sense the pure item. Place it down here and I will prepare for the ceremony.</i>\"[pg]");
	outputText("This consumable requires the use of a Legendary artifact. Which artifact will you use?\n\n<u>Available artifacts in inventory:</u>\n");

	var availableArtifacts:Array = player.allPureLegendaryItems();
	var button:int = 0;
	menu();
	for each(var item:ItemType in availableArtifacts){
		outputText(item.longName +"\n");
		addButton(button++, item.shortName, jojoDevilPurificationScene, item);
	}
	addButton(14, "Never mind", explorer.done);

	function jojoDevilPurificationScene(item:ItemType):void {
		outputText("[pg]Jojo begins to draw circles into the ground.[pg]");
		outputText("\"<i>Sit in the middle and embrace the artefact like your soul depend on it wich may or may not be the case. You must thoroughly reject your corruption for this to work or nothing will happen there is no faking it or half hearted measure here. Brace yourself because it will hurt… a lot.</i>\"[pg]");
		outputText("You do as jojo says, each second in the circle seems to stretch into an eternity of torture. You yearn for pleasure yet you deny yourself. At first the contact with the holy item is just a tingling but after a while it feels like a hot iron searing your flesh. You embrace pain, pain is your punishment, pain is your atonement. Through suffering you somehow slowly gain back focus as your corrupt though recedes one by one, burnt into the holy pyre of suffering that is your body at the time. This agonizing treatment continue for what seems to stretch like forever before Jojo calls out to you.[pg]");
		outputText("\"<i>[name] are you all right?! I saw you burning as if engulfed in whitefire! The ritual worked but by Marae what I witnessed was not pretty… You just spent the past five minutes screaming I thought you were going to die!</i>\"[pg]");
		outputText("Your body singed by pain is regenerating itself already but pain did cleanses your mind. Were the now consumed holy item used to be now rest a burnt mark not unlike a rune, clear reminder of your resolve to see this through. You can see everything with clarity again. Jojo notice the change too.[pg]");
		outputText("\"<i>It worked! Your corruption is down to an acceptable, yet somewhat bad amount. I can't do much more for you [name], you will have to find your own solutions from now on.</i>\"[pg]");
		player.createStatusEffect(StatusEffects.DevilPurificationScar, 0, 0, 0, 0);
		player.cor -= 50;
		SceneLib.alvinaFollower.JojoDevilPurification = 2;
		player.consumeItem(item);
		explorer.stopExploring();
		doNext(camp.returnToCampUseFourHours);
	}
}

//Consensual Jojo sex scenes! NOT DONE.
public function offerSexFirstTime():void {
	jojoSprite();
	clearOutput();
	outputText("You ask Jojo if he would be willing to help you with a... personal problem.");
	outputText("\n\n\"<i>Yes, of course! What is it, [name]?</i>\"");
	outputText("\n\nYou tell him that it has to do with certain... needs of yours. Desires that need slaking. You would much rather something consensual, with a friendly face, than to go out and offer yourself to the depraved interests of whatever corrupted being you find, or to engage in the uncomfortably demonic act of beating down and then raping one of the degenerates that roam this corrupted land.");
	outputText("\n\nJojo's eyes open wide in realization and he blushes so hard you can even see it through his white fur. \"<i>I... I'm flattered you would consider me for this... and I think you're really " + (player.femininity >= 50 ? "beautiful" : "handsome") + ", " + ((player.thickness >= 60 && player.tone < 60) ? "although you should work harder to keep yourself in shape." : "and you obviously keep yourself in good shape.") + " You're also nice to me and I do find you attractive but...</i>\"");
	outputText("\n\nBut...? You press. After all, isn't it better for both of you to turn to each other to slake your lusts then to bottle things up or go to the monsters who roam this land?");
	outputText("\n\n\"<i>I-I can't... I made a vow of chastity... I can't simply break my vows... please understand, [name]...</i>\" he says gazing at you apologetically, though you detect just the slightest hint of desire in his eyes before he averts his gaze and shakes his head of whatever thoughts could be plaguing it.");
	outputText("\n\nYou acknowledge his position and excuse yourself, but before you can leave he calls out to you. \"<i>Wait, [name]!</i>\" he says getting up and moving towards you. \"<i>While I can't really have sex with you, that doesn't mean I can't help you. If you want we could meditate to help you... umm... restrain your needs?</i>\" he suggests.");
	monk = JOJO_NOSEX_1;
	doYesNo(agreeToMeditate, noThanksToMeditate);
}
private function agreeToMeditate():void {
	jojoSprite();
	clearOutput();
	outputText("You decide that it would help you clear your head, and accept his offer. He motions for you to sit down beside him.");
	doNext(jojoFollowerMeditate);
}
private function noThanksToMeditate():void {
	jojoSprite();
	clearOutput();
	outputText("You shake your head, telling him that it'll be fine, and leave.");
	doNext(playerMenu);
	cheatTime(0.25);
}

public function offerSexFirstTimeHighAffection():void {
	jojoSprite();
	clearOutput();
	outputText("You've been spending great time with Jojo. You've meditated with him, you've discussed with him and you've even trained with him! Now's the time to ask him out.");
	outputText("\n\nYou approach Jojo. \"Yes, [name]? What is it you need?\" Jojo asks. You ask him if he would like to have sex.");
	outputText("\n\n\"<i>I'm sorry. I still can't break my vows of chastity,</i>\" he says apologetically.");
	monk = JOJO_NOSEX_2;
	menu();
	addButton(0, "Meditate", jojoFollowerMeditate);
	addButton(1, "Drop It", noThanksToMeditate);
	if (player.inte >= 60 && player.cor <= (10+ player.corruptionTolerance)) addButton(2, "Confront", confrontChastity);
}

public function confrontChastity():void {
	jojoSprite();
	clearOutput();
	outputText("He cannot keep his vows forever. After all, he's missing out on the pleasure! He probably never knew how he would feel if he has a perfect cock that fits perfectly in his butthole or his cock that fits perfectly in a vagina or an anus. He should be fine as long as he stays faithful to you.");
	outputText("\n\n\"<i>What about pleasure? " + (player.hasVagina() ? "How about potential mate like me? " : "") +"You're missing out!</i>\" you say. Jojo stares deeply into your eyes for a good moment.");
	outputText("\n\n\"<i>Well... young one, you're right. You did spend time together with me. We've meditated, I've taught you some important lessons and now we're here,</i>\" Jojo says hesitantly but he starts to smile, \"<i>Let's have sex; I want to experience.</i>\"");
	outputText("\n\nYou smile back at Jojo, knowing that you can have sex with him.");
	outputText("\n\n<b>You have unlocked Jojo sex menu!</b>");
	if (silly()) outputText("<b> Jojo can only learn four moves. Delete a move to learn a new one? Yes. 1... 2... 3... Poof! Jojo has forgotten Chastity and learned Sex!</b>");
	flags[kFLAGS.DISABLED_JOJO_RAPE] = 1;
	monk = JOJO_SEXED;
	doNext(pureJojoSexMenu);
}

private function pureJojoSexMenu():void {
	var capacity:int = 40;
	if (flags[kFLAGS.JOJO_ANAL_XP] < 10) capacity += (flags[kFLAGS.JOJO_ANAL_XP] * 3);
	else capacity += 30; //Caps at 70.
	//Call for the purpose of cock size.
	//startCombat(new Jojo());
	//CoC.instance.inCombat = false;
	//Begin
	jojoSprite();
	clearOutput();
	outputText("You ask Jojo if he's in the mood for sex right now. ");
	if (player.hasPerk(PerkLib.Phylactery) && !player.hasStatusEffect(StatusEffects.DevilPurificationScar) && SceneLib.alvinaFollower.JojoDevilPurification == 0) {
		jojoFreaksOutSoulless();
		return;
	}

	if (flags[kFLAGS.JOJO_SEX_COUNTER] < 3) outputText("Jojo looks into your eyes and says, \"<i>Only if you're going to be gentle.</i>\"");
	else outputText("Jojo looks into your eyes and says, \"<i>Yes, young one. Let's go.</i>\"");
	outputText("\n\nJojo escorts you to the forest and chooses the area with the most privacy.");
	outputText("\n\n(What way should you have with Jojo?)");
	if (debug) {
		outputText("\n\n<b><u>Jojo's Debug Stats</u></b>");
		outputText("\n<b>Anal Capacity:</b> " + capacity);
		outputText("\n<b>Cum Production:</b> " + jojoCumQ + "mL");
	}
	menu();
	addButton(0, "Anal Pitch", anallyFuckTheMouseButtSlut).hint("Fuck the monk mouse-morph's butt.")
		.disableIf(player.cockThatFits(capacity) < 0, "Req. a cock fitting "+capacity+" capacity.");
	addButton(1, "Anal Catch", getAnallyFuckedByMouseYouSlut).hint("Have Jojo penetrate you anally.");
	addButton(2, "Vaginal Catch", getVagFuckedByMouse).hint("Have Jojo penetrate you vaginally.")
		.disableIf(!player.hasVagina(), "Req. a vagina.");
	addButton(3, "Blow Him", suckJojosCock).hint("Suck Jojo's cock and get a taste of mouse cum!");
	addButton(14, "Never mind", jojoCampMenu);
}

private function anallyFuckTheMouseButtSlut():void {
	var capacity:int = 40;
	if (flags[kFLAGS.JOJO_ANAL_XP] < 10) capacity += (flags[kFLAGS.JOJO_ANAL_XP] * 3);
	else capacity += 30; //Caps at 70.
	var x:int = player.cockThatFits(capacity);
	//Begin
	jojoSprite();
	clearOutput();
	if (flags[kFLAGS.JOJO_ANAL_XP] == 0) outputText("You finally make up your mind; you want to stuff your cock into that tight ass of his. " + player.clothedOrNaked("You remove your [armor] and ") + "Jojo hesitantly strips out of his robe, revealing his naked form.");
	else if (flags[kFLAGS.JOJO_ANAL_XP] == 1) outputText("You decide that you want to stuff your cock into that tight ass of his again. " + player.clothedOrNaked("You remove your [armor] and ") + "Jojo hesitantly strips out of his robe, revealing his naked form.");
	else if (flags[kFLAGS.JOJO_ANAL_XP] >= 2) outputText("You decide that you want to stuff your cock into that tight ass of his again. " + player.clothedOrNaked("You remove your [armor] and ") + "Jojo without hesitation strips out of his robe, revealing his naked form.");
	//First and second time
	if (flags[kFLAGS.JOJO_ANAL_XP] < 3) {
		//Intro
		if (flags[kFLAGS.JOJO_ANAL_XP] < 1) outputText("\n\n\"<i>Just be gentle,</i>\" Jojo whimpers as he gets down on all fours.");
		else outputText("\n\n\"<i>Even though we've done it before, still, just be gentle, please,</i>\" Jojo says, nervous as he gets down on all fours.");
		//Check anal tightness
		outputText("\n\nYou gently caress Jojo’s toned, quivering butt-cheeks and get a good glance at his anus. ");
		if (flags[kFLAGS.JOJO_ANAL_XP] < 1) outputText("He’s too tight to stick your " + player.cockDescript(x) + " in right off; he needs stretching. You warn Jojo that you're going to start by fingering him, and he shakes with trepidation as he nods. You slick your hand up with some spit and then go for it. ");
		else outputText("You warn Jojo you're going to test him with your hand first. \"<i>If you have to,</i>\" he says, closing his eyes. You slick your fingers up with some saliva, and then gently probe Jojo’s pucker.");
		//Anal fingering and stretching
		outputText("\n\nJojo's cock starts leaking precum the moment your fingers breach his entrance, and he quivers. You're not sure if he's pained or aroused, but he might not know, either: he's really sensitive. ");
		if (flags[kFLAGS.JOJO_ANAL_XP] < 1) outputText("You take your time about it, since he's worried enough, but eventually you think you might be able to get your cock in.");
		else outputText("He relaxes much faster than he did last time. You should be good.");
		//Get lubed up and get your cock into Jojo's anus.
		outputText("\n\nYou spit on your hands and rub it all over your " + player.cockDescript(x) + ", getting it lubed up. You tell Jojo you're going in and you slowly slide your " + player.cockDescript(x) + " into Jojo’s butthole as he clenches around you. " + (flags[kFLAGS.JOJO_ANAL_XP] > 0 ? "By Marae, he’s tight as ever!" : "By Marae, he's tight!") + " ");
		if (flags[kFLAGS.JOJO_ANAL_XP] < 1) {
			outputText("<b>Jojo has lost his anal virginity!</b>");
			outputText("\n\nYou ask him if he’s all right. \"<i>Yes. It feels strange and it hurt a little... but it’s not bad! Keep going,</i>\" Jojo says. ");
		}
		else {
			outputText("\n\nJojo starts panting in arousal. You ask him if he’s ok and he gives you a thumbs-up. \"<i>I’m... fine. Keep going.</i>\" ");
		}
		outputText("His cock reaches full mast, ready to cum at any time. You smile at him and start to pick up the pace while keeping it at comfortable level. As you feel him loosening up, you decide to go faster and harder. Jojo starts moaning in both ecstasy and pain, releasing a shrill squeak with every thrust.");
		//ORGASM!
		outputText("\n\nEventually, you can’t hold back any more and you unleash your seed right into his bowels. ");
		if (flags[kFLAGS.JOJO_ANAL_XP] < 1) {
			outputText("Jojo orgasms as well, cumming all over the grass.");
			outputText("\n\nNow spent, you lay next to Jojo. There’s small trail of cum leaking out of Jojo’s ass. \"<i>It’s a new experience. I’m willing to try it again,</i>\" Jojo says, smiling, and you smile back. You know you'll be doing this often.");
		}
		else {
			outputText("Jojo pumps back into you, taking it all, before cumming all over the grass.");
			outputText("\n\nNow spent, you lay next to Jojo. There’s a small trail of cum leaking out of Jojo’s ass. You tell Jojo that he seems to really like anal. Jojo blushes. You laugh, telling your little butt slut that there's more in store for him.");
		}
	}
	//Third+ time
	else {
		outputText("\n\nJojo gets on all fours in a hurry, sticking his firm ass in the air for you to see as he spreads his cheeks apart. The little slut's so eager for you.");
		//Check anal tightness
		outputText("\n\nAnd you're eager, too: your " + player.multiCockDescriptLight() + "is already hard. You gently caress Jojo’s toned, quivering butt-cheeks and get a good glance at his anus. You decide to test it out again. You warn Jojo that you’ll be inserting your hand in first. Jojo says, “Hurry up.” You smile at his response. You slick your fingers up with some saliva, and then gently start to probe Jojo’s pucker, testing out the looseness.");
		//Anal fingering and stretching
		outputText("\n\nThe second your digits invade Jojo’s bowels, his cock starts leaking precum. Jojo’s face kept flickering between pain and arousal. Jojo must really be sensitive. ");
		outputText("Hmm... his ass seems more stretched out compared to the second time; you should be able to insert without worry. ");
		//Get lubed up and get your cock into Jojo's anus.
		outputText("\n\nYou spit on your hands and apply saliva evenly all over your " + player.cockDescript(x) + " to get it all lubed up. Deeming the lubrication sufficient, you let Jojo know that you’re going to start and you slowly slide your " + player.cockDescript(x) + " into Jojo’s butthole. His sphincter closes around you tightly. By Marae, he’s tight as ever! ");
		outputText("\n\nJojo starts panting in arousal. You ask him is he’s ok. Jojo gives you a thumbs-up. \"<i>I’m... fine. Keep going.</i>\" His cock reaches full erection, ready to cum at any time. You smile at him and start to pick up the pace while keeping it at comfortable level. As you feel his loosening up, you decide to go faster and harder. Jojo starts moaning in both ecstasy and pain, releasing a shrill squeak with every thrust. ");
		//ORGASM!
		outputText("\n\nEventually, you can’t hold back any more and you unleash your seed right into his bowels. ");
		outputText("Jojo starts pumping his hips in order to suck all the cum into his bowels and he wraps his long tail around you to pull you closer. He, soon, orgasms as well, cumming all over the grass.");
		outputText("\n\nNow spent, you lay next to Jojo. There’s small trail of cum leaking out of Jojo’s ass. You laugh, telling your little butt slut that there more in store for him.");
	}
	//The End
	if (flags[kFLAGS.JOJO_SEX_COUNTER] >= 4) outputText("He plants a kiss on your lips.");
	outputText("\n\nAfter a good while of rest, " + player.clothedOrNaked("the two of you get redressed and", "Jojo gets redressed and the two of you") + " return to your camp.");
	dynStats("cor", -1);
	flags[kFLAGS.JOJO_ANAL_XP]++;
	flags[kFLAGS.JOJO_SEX_COUNTER]++;
	player.sexReward("default","default",true,false);
	endEncounter();
}

private function getAnallyFuckedByMouseYouSlut():void {
	var isVirgin:Boolean = (player.looseness(false) == 0);
	jojoSprite();
	clearOutput();
	outputText("You finally make up your mind; you want his mouse-cock in your [ass]. " + player.clothedOrNaked("You remove your [armor] and ") + "Jojo " + (flags[kFLAGS.JOJO_SEX_COUNTER] < 4 ? "hesitantly " : "") + "strips out of his robe, revealing his naked form.");
	outputText("\n\n\"<i>Get down on all fours and I can begin,</i>\" Jojo instructs. You nod and get down on all fours, presenting your [butt] to Jojo. His cock grows to full erection. \"<i>I'm going to need to get this lubricated first,</i>\" Jojo says. He spits on his hands and applies the saliva evenly across his cock.");
	outputText("\n\nJojo gently massages your [butt] to assure you that he's going to go gentle. \"<i>Here I come,</i>\" Jojo announces as he slowly slides his cock right into your [ass].");
	player.buttChange(30, true);
	if (isVirgin) outputText(" \"<i>That's really tight; I'm going to enjoy your tightness while it lasts,</i>\" Jojo remarks. ");
	else if (player.looseness(false) < 2) outputText(" \"<i>That's tight,</i>\" Jojo says. ");
	else outputText(" \"<i>That's nice,</i>\" Jojo remarks. ");
	outputText("Slowly, he begins to rock his hips back and forth, placing his hands on your [hips] for support. ");
	outputText("\n\n\"<i>Does it feel good, [name]?</i>\" Jojo asks. You reply that you wish he would go a little faster. Wanting to please you, Jojo start thrusting his erect cock into you farther and faster than before. You start moaning in pleasure as his penis hollows out your insides.");
	outputText("\n\nAs the tension builds, Jojo keeps thrusting faster and faster. Not wanting him to be left out, you start moving in time with him and taking his cock up to the hilt. Jojo moans louder and shouts, \"<i>I’m going to cum!</i>\" Jojo rams you one last time hitting your prostate with all he’s got. He starts dumping his massive load into you" + (jojoCumQ() >= 750 ? ", filling your bowels" + (jojoCumQ() >= 1000 ? " and distending your belly" : ""): "") + ". With a tremendous shudder, you orgasm, your [asshole] clenching around his member, trying to wring it of all its delicious load. ");
	if (player.hasCock()) outputText("[EachCock] twitches with pleasure, soaking the ground beneath you with a small lake of cum. ");
	if (player.hasVagina()) outputText("Your [pussy] spontaneously " + (player.averageVaginalWetness() >= 4 ? "sprays" : "leaks") + " juices all over the ground. ");
	if (player.gender == 0) outputText("Your body rocks with ecstasy. ");
	outputText("\n\nHis cock slides out of your [ass] with a pop. Cum start dripping out of your [ass]. \"<i>That was... You were amazing, [name].</i>\" You smile at him while rubbing your inflated belly and tell him he wasn’t too bad himself. " + (flags[kFLAGS.JOJO_SEX_COUNTER] >= 4 ? "You give Jojo a lingering kiss." : ""));
	outputText("\n\nAfter a good while of rest, " + player.clothedOrNaked("the two of you get redressed and", "Jojo gets redressed and the two of you") + " return to your camp.");
	dynStats("sens", 1, "cor", -1);
	flags[kFLAGS.JOJO_ANAL_CATCH_COUNTER]++;
	flags[kFLAGS.JOJO_SEX_COUNTER]++;
	player.sexReward("cum","Anal");
	endEncounter();
}

private function getVagFuckedByMouse():void {
	jojoSprite();
	clearOutput();
	outputText("You finally make up your mind; you want his mouse-cock in your [vagina]. " + player.clothedOrNaked("You remove your [armor] and ") + "and Jojo " + (flags[kFLAGS.JOJO_SEX_COUNTER] < 4 ? "hesitantly " : "") + " strips out of his robe, revealing his naked form.");
	if (flags[kFLAGS.JOJO_VAGINAL_CATCH_COUNTER] == 0) {
		outputText("\n\nYou see that Jojo’s uncomfortable, so you lean back on your legs and pull open the lips of your [vagina], showing him your wet, hot insides. Jojo’s jaw drops and his cock gets fully erect. You tease Jojo by telling him to hurry up or you’ll go find some imps. Jojo’s snaps his jaws shut and says, \"<i>No. I promised to help you deal with your lust, so you can avoid corrupted creature. It’s just... well, this is my first time.</i>\" You’re surprised, considering that virginity was impossible in a land like Mareth. You tell him you’d be honored if he gave you his virginity. Jojo looks at you for a second and nods. \"<i>You’re the only one who I can trust it with... I’m ready now.</i>\"");
		outputText("\n\nJojo hesitates at the entrance of your [vagina] and suddenly with a single stroke jams his dick deep into you. ");
		player.cuntChange(20, true);
		outputText("Taken aback with his suddenness, you clench your muscles so tight that Jojo’s dick becomes stuck inside you. Jojo howls in pain and pleasure. You scold Jojo for his reckless action, but secretly you’re pleased that he took the initiative. You instruct Jojo to start slow and to go faster over time. Jojo nods and smiles nervously. You say don’t worry, you’ll guide him.");
		outputText("\n\nYou relax and let Jojo gently work his pace. His erect cock slides in and out of your [vagina] smoothly. So far, so good. Jojo starts picking up the pace. You can’t stop the moans of ecstasy from coming out of your mouth and that seemed to encourage Jojo to further exertions. He started ramming your cervix as if he wanted to invade your womb. You didn’t bother trying anymore, you let loose screams of pleasure. Jojo seemed to be near the end of his stamina because he started to slow down. He shouts, \"<i>I’m going to cum!</i>\" You hook your legs behind Jojo’s back to lock him in place. Jojo’s cock was right next to the entrance of your womb. When Jojo cummed, the force of his ejaculation pierces your womb and stuffs it full of hot mouse cum. " + (jojoCumQ() >= 750 ? "His orgasm seems to never end and he continues to stuff your womb. " + (jojoCumQ() >= 900 ? "Excessive mouse-spunk spills out of your [pussy]. Gods, that was intense!" : "") : ""));
		outputText("\n\nYou orgasm at the same time, spraying girlcum all over Jojo" + (player.hasCock() ? "; [eachCock] let loose a cum shower, drenching your belly and thighs" : "") + ". Losing strength in your limbs, you release Jojo. Jojo falls back on the grass, panting. \"<i>That was...  That was amazing...  We are going to do this again, aren’t we?</i>\" You smile at him and nod, thinking privately that if he’s this good as a virgin, how good he’ll be when you’re through with him.");
	}
	else if (flags[kFLAGS.JOJO_VAGINAL_CATCH_COUNTER] == 1) {
		outputText("\n\nYou see that Jojo’s still a little uncomfortable, so you lean back on your legs and pull open the lips of your [vagina], showing him your wet, hot insides. Jojo’s cock gets fully erect. With just a little hesitation, he gets into position in front of you. You’re impressed by Jojo’s growth. Soon he’ll be able to fuck you with no hesitation whatsoever. While you were musing the change in Jojo, he had dipped his head down and started licking your [clit] with his warm, soft tongue. You shiver, brought almost to the edge of orgasming. ");
		outputText("\n\nEmbarrassed, you ask him where he learned that. He replies \"<i>I heard about something called foreplay. Apparently I have to make you wet enough before I stick it in you or it will hurt you.</i>\" Impressed, you relax and let him continue his ministrations. After a while Jojo says \"<i>I think it’s wet enough now, so there shouldn’t be any pain this time.</i>\" and with that, he penetrates your [vagina] with a single stroke. ");
		player.cuntChange(20, true);
		outputText("\n\nJojo starts out slow, rocking his hips and gyrating to simulate you as much as possible. It’s hard to imagine that he was a virgin not too long ago. Gradually he speeds up, reaching further and further into you. You can’t stop the moans of ecstasy from coming out of your mouth and that seemed to encourage Jojo to further exertions. He started ramming your cervix as if he wanted to break your womb. You didn’t bother trying anymore, you let loose screams of pleasure. Jojo seemed to be near the end of his stamina because he started to slow down. He shouts, \"<i>I’m going to cum!</i>\" You hook your legs behind Jojo’s back to lock him in place. Jojo’s cock was right next to the entrance of your womb. When Jojo cummed, the force of his ejaculation pierces your womb and stuffs it full of hot mouse cum. " + (jojoCumQ() >= 750 ? "His orgasm seems to never end and he continues to stuff your womb. " + (jojoCumQ() >= 900 ? "Excessive mouse-spunk spills out of your [pussy]. Gods, that was intense!" : "") : ""));
		outputText("\n\nYou orgasm at the same time, spraying girlcum all over Jojo" + (player.hasCock() ? "; [eachCock] let loose a cum shower, drenching your belly and thighs" : "") + ". Losing strength in your limbs, you release Jojo. Jojo falls back on the grass, panting. \"<i>How’d I do?</i>\" You smile at him and say that if he kept fucking you like that, you might just avoid imps all together. He smiles, obviously happy to hear that.");
	}
	else if (flags[kFLAGS.JOJO_VAGINAL_CATCH_COUNTER] >= 2) {
		outputText("\n\nThere was no need to excite him now; Jojo’s cock was already fully erect. With no hesitation, he gets into position in front of you. You’re impressed by Jojo’s growth. While you were musing the change in Jojo, he had dipped his head down and started licking your [clit] with his warm, soft tongue. You shiver, brought almost to the edge of orgasming. Jojo’s gotten pretty good with using that tongue of his. You’ll have to be careful or you’ll end up cumming before he does. After a while Jojo sticks his hand into your [vagina] and finding it wet enough says, \"<i>I’m sticking it in now,</i>\" and with a single stroke, penetrates your vagina. ");
		player.cuntChange(20, true);
		outputText("\n\nJojo starts out slow, rocking his hips and gyrating to simulate you as much as possible. It’s hard to imagine that he was a virgin not too long ago. Gradually he speeds up, reaching further and further into you. You can’t stop the moans of ecstasy from coming out of your mouth and that seemed to encourage Jojo to further exertions. He started ramming your cervix as if he wanted to breach open. You didn’t bother trying anymore, you let loose screams of pleasure. Jojo just kept pounding you as if in a rut. His meager stamina was gone; he was a fucking machine now. Just when you were about to orgasm, he shouts, \"<i>I’m going to cum!</i>\" You hook your legs behind Jojo’s back to lock him in place. Jojo’s cock was right next to the entrance of your womb. When Jojo cummed, the force of his ejaculation pierces your womb and stuffs it full of hot mouse cum. ");
		outputText("\n\nYou orgasm at the same time, spraying girlcum all over Jojo" + (player.hasCock() ? "; [eachCock] let loose a cum shower, drenching your belly and thighs" : "") + ". Losing strength in your limbs, you release Jojo. Jojo falls back on the grass, panting. \"<i>I can’t wait to do that again.</i>\" You laugh and tease him by saying that this was supposed to be about satiating your lust, not his. Jojo blushes. You smile and tell him that you would let him fuck you anytime. He smiles, obviously happy to hear that. " + (flags[kFLAGS.JOJO_SEX_COUNTER] >= 4 ? "You give Jojo a lingering kiss." : ""));
	}
	outputText("\n\nAfter recovering, " + player.clothedOrNaked("the two of you get redressed and", "Jojo gets redressed and the two of you") + " return to your camp.");
	dynStats("sens", 1, "cor", -1);
	flags[kFLAGS.JOJO_VAGINAL_CATCH_COUNTER]++;
	flags[kFLAGS.JOJO_SEX_COUNTER]++;
	if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
	else player.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE + 82, (jojoCumQ() < 2000 ? 100 - (jojoCumQ() / 50) : 60));
	player.sexReward("cum","Vaginal");
	endEncounter();
}

public function giveBirthToPureJojoBabies():void {
	outputText("Pain shoots through you as they pull open your cervix forcefully, causing you to cry out involuntarily. Jojo comes running to you and says, \"<i>I sense something happening, is it time?</i>\" You scream, \"<i>No, I just like screaming in pain. YES, IT'S TIME!</i>\" You grip the ground and pant and push as the pains of labor overwhelm you. Jojo grips your hand tightly and seemed to be saying some prayers. You feel comforted for a second by the prayers before the pain brings you back to reality. You feel your hips being forcibly widened by the collective mass of the creatures moving down your birth canal. You spread your legs wide, laying your head back with groans and cries of agony as the first child moves out of your womb, through your cervix, down and into your twat. Your lips part and, with a grunt, you expel the first child into Jojo’s waiting hand. Jojo looks at it if it was the most beautiful thing he’s ever seen. He holds it up to you so you can see your firstborn; it’s a little mouselet with large innocent eyes, even larger ears, a cute, sniffling nose, and a long slender pink tail. Jojo helps hold it to your [chest], where it eagerly takes hold of your [nipples] and starts to suckle. As it drinks, it starts to grow larger, and fur the same color as your own hair starts to cover its body. It quickly drinks its fill and then detaches, its father putting it aside, which is good, because by this time there’s another baby waiting for its turn... and another... and another...\n\n");
	outputText("Soon, you are back to your old self again, lying down in exhaustion with Jojo sitting nearby, your many rambunctious offspring already starting to walk and play around you.\n\n");
	if (flags[kFLAGS.AMILY_FOLLOWER] == 1) {
		if (flags[kFLAGS.JOJO_LITTERS_AMILY_REACTION_COUNTER] == 0) {
			outputText("Amily comes running to you and shouts \"<i>What happened, why were you screaming?</i>\" then looks at the litter of mice in awe and says, \"<i>[name], those aren't mine...who's are they.</i>\" Jojo bites his lips and says, \"<i>They're mine.</i>\" Amily just stares at Jojo for a second. Jojo trys to placate her \"<i>I was..I was just trying to help [name] and it just happened and...</i>\" He stops and Amily starts to laugh. \"<i>I haven't seen you so worried since we were mouselets... I'm fine with it. I'm glad you found someone as great as [name]. If you want, I can take these kids to a secret settlement my kids have erected.</i>\" Jojo seemed surprised at Amily's lack of anger, but quickly joy transforms his face. \"<i>Thanks Amily. We have been worried about where we can send them, and you have solved all our problems. Thank you.</i>\" Amily smiles and says, \"<i>It's the least I can do.</i>\"\n\n");
			outputText("Exhausted, you start slipping into slumber. As your eyes close, you get a glimpse of Amily taking your litter away.\n\n");
		}
		else {
			outputText("Soon, you are back to your old self again, lying down in exhaustion with Jojo sitting nearby, your many rambunctious offspring already starting to walk and play around you.\n\n");
			outputText("As you lie resting from your exertions, you notice some of your kids from Jojo and Amily arrive and take away your newborns. They come by to say hi and catch up. As it got late, they had to say goodbye and leave. You watch them leave with a tiny bit worry gnawing inside. Your kids are so young, will they be ok? Jojo seems to sense our feeling and reassures you by squeezing your hand. You look up at him and slowly nod. They'll be fine; afterall, they're your kids.\n\n");
		}
		flags[kFLAGS.JOJO_LITTERS_AMILY_REACTION_COUNTER]++;
	}
	else outputText("\"<i>Look at them all. You... I never thought I would be able to have kids when my village was destroyed, but you made it happen. Thank you,</i>\" Jojo tells you sincerely. You ask him how they were going to raise them. Jojo frowned thoughtfully and says, \"<i>Hmm, you’re right...we can’t raise them here... I know of a place we can send them. It’s safe from corruption and it should do till we find better arrangements.</i>\" As sad as you were about sending your kids away, you agree with Jojo; it was for the best. You're too exhausted to keep your eyes open for long, but he promises watch them and even as you fall asleep, he’s gathering up your children and taking them away.\n\n");
	if (player.hasMutation(IMutationsLib.GoblinOvariesIM)) flags[kFLAGS.JOJO_LITTERS] += 2;
    else flags[kFLAGS.JOJO_LITTERS]++;
}

private function suckJojosCock():void {
	jojoSprite();
	clearOutput();
	if (flags[kFLAGS.JOJO_BLOWJOB_XP] <= 0) outputText("You tell Jojo that you feel like it’s his turn to be pleasured. " + player.clothedOrNaked("You remove your [armor] and ") + "Jojo hesitantly drops his pants, revealing his sheathed cock.");
	else outputText("You tell Jojo that you want to have a taste of his dick today. " + player.clothedOrNaked("You remove your [armor] and ") + "Jojo drops his pants, revealing his flaccid, sheathed cock.");
	outputText("\n\nYou approach him and position yourself before him, contemplating how to begin. You decide to tease Jojo as much as possible. You wrap your tongue around the head of his cock and start tugging at his sheathe. Instead of pulling his sheath back with your hands, you tug at it with your mouth. The second the sheath gets pulled back, the heady scent of Jojo’s animal musk almost overwhelms you. You feel yourself getting warmer" + (player.gender > 0 ? ", " : "") + (player.hasCock() ? "your [cocks] leaking pre" : "") + (player.gender == 3 ? " and " : "") + (player.hasVagina() ? "your [pussy] leaking juices" : "") + ". Your hot breath excites Jojo’s cock into full erection.");
	outputText("\n\nYou lick your lips in anticipation. \"<i>Thank you for the meal,</i>\" you say as you start licking his shaft from the cock head all the way to the balls. The first thing that hits you is the taste. Jojo’s cock tasted like sweat and old cheese which, surprisingly, tasted arousing. Combined with the heady scent of musk, it took all your self-control not to pounce on him. ");
	outputText("\n\nJojo starts moaning around the time you got to his balls. When you look up, you notice some pre coming out. You let go of his wet balls and started lapping up his precum. It tasted salty, making a great appetizer. You start massaging Jojo’s balls to keep the precum coming. Unnoticed to you, Jojo had been slowly moving his hands behind you. He suddenly grabs hold of your [hair] and forces your head back all the way to his hilt. Surprised and almost choking, you try to force your head back, but Jojo holds you firmly. You look up at Jojo see him panting in arousal, his eyes unfocused. Damn, you pushed him too far. Oh well, you kind of like it rough anyway.");
	outputText("\n\nInstead of resisting him, you start moving in time with him, deep-throating his tasty cock. Jojo start moaning louder and started rocking his hips back and forth rapidly. It felt like he was raping your throat. Jojo didn’t seem to be cumming anytime soon and you were getting impatient. You suddenly jab your finger into Jojo’s ass and stimulate his prostate. Panting, Jojo shouts, \"<i>I’m gonna cum!</i>\" and pull your head forward as much as possible. Hot cum came gushing out like a hose, instantly " + (jojoCumQ() >= 600 ? "distending" : "stuffing") + " your stomach. Jojo falls back, his cock spraying cum all over your [face] and running down your [fullchest]. " + (jojoCumQ() >= 900 ? "His orgasm seems to never end and he continues to cum for a good while." : ""));
	if (flags[kFLAGS.JOJO_BLOWJOB_XP] <= 0) outputText("\n\nJojo collapses on his back, winded. When he comes up, he says, \"<i>I can’t feel my legs... I don’t know what came over me, sorry [name].</i>\" You rub your full belly and smile and tell him he’ll have to make it up to you. He asks \"How, I’ll do anything.\" You tell him that the next time they eat it’s his treat. You lean in close and tell him that you prefer mouse-spunk. Jojo blushes and you lean back and says with a smile, \"<i>Um... sure. Since I made a promise, I’ll have to fulfill it.</i>\"");
	else outputText("\n\nJojo collapses on his back, winded. When he comes up, you say that was delicious and to treat you next time as well. Jojo’s too tired to say anything, but smiles in response.");
	outputText("\n\nAfter a good while of rest, " + player.clothedOrNaked("the two of you get redressed and", "Jojo gets redressed and the two of you") + " return to your camp.");
	if (jojoCumQ() < 2500) player.refillHunger(jojoCumQ() / 25);
	else player.refillHunger(100);
	flags[kFLAGS.JOJO_BLOWJOB_XP]++;
	flags[kFLAGS.JOJO_SEX_COUNTER]++;
	dynStats("lus", 20, "cor", -1);
	player.sexReward("cum","Lips");
	endEncounter();
}

public function mishapsLunaJojo():void {
	clearOutput();
	outputText("Jojo is looking at the ground in front of his training area in annoyance. Seems someone has drawn an ugly imp in the dirt using red paint and the imp happens to be jerking a 10 foot long cock." +
			" There is text along with it, \"Give in, you know you want it.\" You spot Luna in the distance, cleaning the area with a smile. Surely it couldn’t have been her.\n\n");
	if (player.hasStatusEffect(StatusEffects.CampLunaMishaps1)) player.addStatusValue(StatusEffects.CampLunaMishaps1, 2, 1);
	else player.createStatusEffect(StatusEffects.CampLunaMishaps1, 0, 1, 0, 0);
	if (!player.hasStatusEffect(StatusEffects.LunaWasCaugh)) player.createStatusEffect(StatusEffects.LunaWasCaugh, 1, 0, 0, 0);
	if (player.hasStatusEffect(StatusEffects.LunaWasCaugh)) player.addStatusValue(StatusEffects.LunaWasCaugh, 1, 1);
	if (player.statusEffectv1(StatusEffects.LunaWasCaugh) == 3) outputText("<b>That's it, you're sure of it now, it's all Luna's doing!</b>\n\n");
	doNext(playerMenu);
}

public function afterDebimboTalk():void {
	jojoSprite();
    clearOutput();
    outputText("About an hour passes, and Jojo eventually walks over to you, a conflicted look on his face. \"<i>[name], may I... talk to you for a minute?</i>\" You nod, and he sits across from you. \"<i>I... It’s come to my attention that I was... under the effects of Bimbo Liqueur... and... I’ve been trying to make sense of what happened while I was... Joy.</i>\" He sighs. \"<i>I... Approached you for sex, didn’t I?</i>\" You nod, and his face reddens. He inhales, hands shaking. \"<i>...And we... We did, did we not?</i>\"");
    outputText("\n\nYou nod again. He sighs. \"<i>So... I forsook my vows then. Affected as I was... I am no longer chaste.</i>\" He lowers his head. \"<i>[name], I... Need to talk to you... About our relationship. I am afraid I wasn’t entirely honest with you.</i>\"");
    outputText("\n\nYou tell Jojo that you know. He whips his head up, eyes locking with yours. \"<i>W-wait, you know?!</i>\" You laugh, telling the shy monk that Joy was very honest with what she wanted. This makes Jojo squirm uncomfortably. \"<i>So... You know that I... </i>\" You join the monk on his log, putting an arm around him. \"<i>You know that I... care deeply for you.</i>\"");
    outputText("\n\nYou put a finger on Jojo’s lips. You tell Jojo that you know he loves you. And if he remembers his time as Joy, he knows that feeling is mutual. At this, Jojo’s eyes brighten, and he almost tears up. \"<i>Y-you mean that?</i>\" You nod again, and Jojo leans in, resting his muzzle against your [chest].");
    outputText("\n\n\"<i>Thank you.</i>\" He says simply. \"<i>I... Will need to meditate more... I have no idea what the future brings... </i>\" He chuckles, standing back up. \"<i>But now... At least I have a little more Joy in my life.</i>\" Shocked, you ask him if he just made a joke, and he waggles his eyebrows, smiling deeply. \"<i>Maybe I did... or Maybe not.</i>\"");
    if (flags[kFLAGS.JOY_TWINS_BIRTHED] > 0)
        outputText("\n\nAt this, your mousey children poke their heads out from nearby, and Jojo opens his arms wide. They swarm him, and he scoops up a half-dozen, rubbing the tops of their heads with his cheek. Many of them seem confused, but they don’t care.");
    outputText("\n\n\"<i>I’ll be in my usual spot at camp.</i>\" Jojo says, looking back at you. \"<i>Visit me often, won’t you?</i>\"");
    flags[kFLAGS.TALKED_TO_JOJO_ABOUT_JOY] = 1;
    flags[kFLAGS.DISABLED_JOJO_RAPE] = 1;
	monk = JOJO_SEXED; //probably should lock the sex before... but better to change bimbo acquisition first.
    doNext(playerMenu);
}
}
}