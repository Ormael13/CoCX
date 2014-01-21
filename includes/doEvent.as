
//Event No's 2000 4999 use this function

public function doEvent(eventNo:Number):void
{
	var temp2:Number = 0;
	//New game gooooooo!
	if (eventNo == 2000)
	{
		hideUpDown();
		dynStats("lus", 40, "cor", 2);
		model.time.hours = 18;
		outputText("You wake with a splitting headache and a body full of burning desire.  A shadow darkens your view momentarily and your training kicks in.  You roll to the side across the bare ground and leap to your feet.  A surprised looking imp stands a few feet away, holding an empty vial.  He's completely naked, an improbably sized pulsing red cock hanging between his spindly legs.  You flush with desire as a wave of lust washes over you, your mind reeling as you fight ", true);
		if (player.gender == 2)
			outputText("the urge to chase down his rod and impale yourself on it.\n\n", false);
		else
			outputText("the urge to ram your cock down his throat.  The strangeness of the thought surprises you.\n\n", false);
		speech("I'm amazed you aren't already chasing down my cock, human.  The last Champion was an eager whore for me by the time she woke up.  This lust draft made sure of it.", "The Imp");
		doNext(2001);
	}
	else if (eventNo == 2001)
	{
		hideUpDown();
		dynStats("lus", -30);
		outputText("\nThe imp shakes the empty vial to emphasize his point.  You reel in shock at this revelation - you've just entered the demon realm and you've already been drugged!  You tremble with the aching need in your groin, but resist, righteous anger lending you strength.\n\nIn desperation you leap towards the imp, watching with glee as his cocky smile changes to an expression of sheer terror.  The smaller creature is no match for your brute strength as you pummel him mercilessly.  You pick up the diminutive demon and punt him into the air, frowning grimly as he spreads his wings and begins speeding into the distance.\n\n", true);
		speech("FOOL!  You could have had pleasure unending...but should we ever cross paths again you will regret humiliating me!  Remember the name Zetaz, as you'll soon face the wrath of my master!", "The Imp");
		outputText("\nYour pleasure at defeating the demon ebbs as you consider how you've already been defiled.  You swear to yourself you will find the demon responsible for doing this to you and the other Champions, and destroy him AND his pet imp.", false);
		doNext(2002);
	}
	else if (eventNo == 2002)
	{
		hideUpDown();
		outputText("\nYou look around, surveying the hellish landscape as you plot your next move.  The portal is a few yards away, nestled between a formation of rocks.  It does not seem to exude the arousing influence it had on the other side.  The ground and sky are both tinted different shades of red, though the earth beneath your feet feels as normal as any other lifeless patch of dirt.   You settle on the idea of making a camp here and fortifying this side of the portal.  No demons will ravage your beloved hometown on your watch.\n\nIt does not take long to set up your tent and a few simple traps.  You'll need to explore and gather more supplies to fortify it any further.  Perhaps you will even manage to track down the demons who have been abducting the other champions!", true);
		doNext(1);
	}
	//Meditate w/Jojo
	else if (eventNo == 2003)
	{
		jojoScene.jojoSprite();
		outputText("Jojo smiles and leads you off the path to a small peaceful clearing.  There is a stump in the center, polished smooth and curved in a way to be comfortable.  He gestures for you to sit, and instructs you to meditate.\n\nAn indeterminate amount of time passes, but you feel more in control of yourself.  Jojo congratulates you, but offers a warning as well.  \"<i>Be ever mindful of your current state, and seek me out before you lose yourself to the taints of this world.  Perhaps someday this tainted world can be made right again.</i>\"", true);
		
		dynStats("str", .5,"tou", .5, "int", .5, "lib", -1, "lus", -5, "cor", -1);
		if (player.hasStatusAffect("Jojo Meditation Count") < 0)
			player.createStatusAffect("Jojo Meditation Count", 1, 0, 0, 0);
		else
			player.addStatusValue("Jojo Meditation Count", 1, 1);
		temp = player.statusAffectv1("Jojo Meditation Count");
		if (temp >= 5)
		{
			outputText("\n\nJojo nods respectfully at you when the meditation session is over and smiles.  ");
			//Forest Jojo Eligible for Invite After Meditation but There's Trash in Camp -Z
			if (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 4 && flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && temp % 5 == 0)
			{
				//replaces 'Jojo nods respectfully at you [...] "It seems you have quite a talent for this. [...]"' invite paragraphs while Treefingers is getting slut all over your campsite
				//gives Small Talisman if PC never had follower Jojo or used it and ran from the fight
				//[(if PC has Small Talisman)
				if (player.hasKeyItem("Jojo's Talisman") >= 0)
				{
					outputText("Jojo smiles at you.  \"<i>[name], well done.  Your talent at focusing is undiminished.  Regarding the other issue... you still have the item I gave you?</i>\"");
					outputText("\n\nYou hold up the talisman, and he nods.  \"<i>Good.  Stay safe and signal me with it if you need help.</i>\"");
				}
				//(else no Small Talisman)
				else
				{
					outputText("Jojo nods at you respectfully.  \"<i>Well done today; your dedication is impressive.  We could meditate together more often.</i>\"");
					outputText("\n\nAs much as you'd like to, you can't stay in the forest, and you can't invite him back with you right now.  Reluctantly, you mention the stubborn, demonic godseed's presence on the borders of your camp.  Jojo's eyebrows furrow in concentration.");
					outputText("\n\n\"<i>Yes, that's a problem.  Oh, that we did not have to resist the very spirit of the land!  [name], take this.  Use it to call me if the demon gives you trouble; I will come and render what aid I can.</i>\"  The monk fishes in his robe and places a small talisman into your hand.");
					//get a small talisman if not have one
					player.createKeyItem("Jojo's Talisman", 0, 0, 0, 0);
					outputText("\n\n(Gained Key Item: Jojo's Talisman)");
				}
				doNext(14);
				return;
			}
			else
				outputText("\"<i>It seems you have quite a talent for this.  We should meditate together more often.</i>\"", false);
		}
		if (temp % 5 == 0)
		{
			outputText("\n\nYou ponder and get an idea - the mouse could stay at your camp.  There's safety in numbers, and it would be easier for the two of you to get together for meditation sessions.  Do you want Jojo's company at camp?", false);
			doYesNo(2149, 14);
			return;
		}
		else
			outputText("\n\nHe bows his head sadly and dismisses you.", false);
		doNext(14);
	}
	//Encounter sand-witch
	else if (eventNo == 2005)
	{
		spriteSelect(50);
		outputText("A strange woman seems to appear from the dunes themselves.  She identifies herself as a sand witch, and politely asks if she can cast a spell on you.", true);
		if (player.statusAffectv1("Exgartuan") == 1 && player.cockArea(0) > 100 && player.statusAffectv2("Exgartuan") == 0)
		{
			outputText("\n\nThe " + player.armorName + " covering your lower half hits the ground, as if yanked down by magic.  Your " + cockDescript(0) + " pulsates darkly, growing rigid in seconds as the demon within you takes over.  It barks, \"<i>Fuck, how about I cast my spell on you baby?</i>\"\n\n", false);
			outputText("The sandwitch ", false);
			if (player.cor < 50)
				outputText("and you both turn crimson", false);
			else
				outputText("turns crimson", false);
			outputText(" as you yank your " + player.armorName + " back into place.  You're in charge here, not some possessed appendage!   Exgartuan yells something snide, but it's muffled too much to understand.  You look up in time to sidestep an attack from the Sand Witch.  It looks like you'll have to fight her!", false);
			startCombat(new SandWitch());
		}
		else
			doYesNo(2006, 2007);
	}
	//SANDVICH MAGICK
	else if (eventNo == 2006)
	{
		spriteSelect(50);
		outputText("", true);
		if (player.hairColor == "sandy blonde")
		{
			outputText("She smiles wickedly and intones, \"<i>Tresed eht retaw llahs klim ruoy.</i>\"\n\n", false);
			if (player.breastRows.length == 0 || player.biggestTitSize() == 0)
			{
				outputText("You grow a perfectly rounded pair of C-cup breasts!  ", false);
				if (player.breastRows.length == 0)
					player.createBreastRow();
				player.breastRows[0].breasts = 2;
				player.breastRows[0].breastRating = 3;
				if (player.breastRows[0].nipplesPerBreast < 1)
					player.breastRows[0].nipplesPerBreast = 1;
				dynStats("sen", 2, "lus", 1);
			}
			if (player.biggestTitSize() >= 1 && player.biggestTitSize() <= 2)
			{
				outputText("Your breasts suddenly balloon outwards, stopping as they reach a perfectly rounded C-cup.  ", false);
				player.breastRows[0].breastRating = 3;
				dynStats("sen", 1, "lus", 1);
			}
			if (player.breastRows[0].nipplesPerBreast < 1)
			{
				outputText("Two dark spots appear on your chest, rapidly forming into sensitive nipples.  ", false);
				player.breastRows[0].nipplesPerBreast = 1;
				dynStats("sen", 2, "lus", 1);
			}
			if (player.biggestLactation() > 0)
			{
				outputText("A strong pressure builds in your chest, painful in its intensity.  You yank down your top as ", false);
				if (player.biggestLactation() < 2)
					outputText("powerful jets of milk spray from your nipples, spraying thick streams over the desert sands.  You moan at the sensation and squeeze your tits, hosing down the tainted earth with an offering of your milk.  You blush as the milk ends, quite embarassed with your increased milk production.  ", false);
				if (player.biggestLactation() >= 2 && player.biggestLactation() <= 2.6)
					outputText("eruptions of milk squirt from your nipples, hosing thick streams everywhere.  The feeling of the constant gush of fluids is very erotic, and you feel yourself getting more and more turned on.  You start squeezing your breasts as the flow diminishes, anxious to continue the pleasure, but eventually all good things come to an end.  ", false);
				if (player.biggestLactation() > 2.6 && player.biggestLactation() < 3)
					outputText("thick hoses of milk erupt from  your aching nipples, forming puddles in the sand.  You smile at how well you're feeding the desert, your milk coating the sand faster than it can be absorbed.  The constant lactation is pleasurable... in a highly erotic way, and you find yourself moaning and pulling on your nipples, totally outside of your control.  In time you realize the milk has stopped, and even had time to soak into the sands.  You wonder at your strange thoughts and pull your hands from your sensitive nipples.  ", false);
				if (player.biggestLactation() >= 3)
					outputText("you drop to your knees and grab your nipples.  With a very sexual moan you begin milking yourself, hosing out huge quantities of milk.  You pant and grunt, offering as much of your milk as you can.  It cascades down the dune in a small stream, and you can't help but blush with pride... and lust.  The erotic pleasures build as you do your best to feed the desert of all your milk.  You ride the edge of orgasm for an eternity, milk everywhere.  When you come to, you realize you're kneeling there, tugging your dry nipples.  Embarrassed, you stop, but your arousal remains.  ", false);
				if (player.biggestLactation() < 3)
				{
					player.boostLactation(.75);
					outputText("Your breasts feel fuller... riper... like your next milking could be even bigger.  ", false);
				}
				dynStats("lib", 1, "sen", 4, "lus", 15);
			}
			if (player.biggestLactation() == 0)
			{
				outputText("A pleasurable release suddenly erupts from your nipples!  Streams of milk are spraying from your breasts, soaking into the sand immediately.  It stops all too soon, though the witch assures you that you can lactate quite often now.  ", false);
				player.boostLactation(1);
				dynStats("lib", .5, "sen", 1, "lus", 10);
			}
			outputText("The sand-witch smiles and thanks you for your offering.  You notice her dress is damp in four spots on the front.  ", false);
			if (sand == 0)
				outputText("You wonder at what her robes conceal as she vanishes into the dunes.", false);
			if (sand == 1)
			{
				if (player.cor <= 33)
					outputText("You are glad to avoid servicing her again as she vanishes into the dunes.", false);
				if (player.cor > 33 && player.cor <= 66)
					outputText("You wonder if you should've resisted and tried for some sex as she departs.", false);
				if (player.cor > 66)
					outputText("You wish you had said no, so you could fuck with her and her magnificent quartet of breasts some more.", false);
			}
			doNext(13);
		}
		else
		{
			outputText("She smiles wickedly and intones, \"<i>nuf erutuf rof riah ydnas, nus tresed eht sa ydnas.</i>\"\n\nYou feel a tingling in your scalp, and realize your hair has become a sandy blonde!", false);
			player.hairColor = "sandy blonde";
			doNext(13);
		}
	}
	//SANDWITCH COMMMMBAAAAT
	else if (eventNo == 2007)
	{
		spriteSelect(50);
		outputText("With an inarticulate scream of rage, the Sand Witch attacks!", true);
		startCombat(new SandWitch());
	}
	//Minotaur shows up...rape?
	else if (eventNo == 2008)
	{
		// This event body was almost entirely an older version of the scene we're going to call instead
		mountain.minotaurScene.getRapedByMinotaur(true);
	}
	//Tentacle's appear!
	else if (eventNo == 2009)
	{
		trace("Tentacle event here");
		outputText("", true);
		spriteSelect(100);
		//Tentacle Encounter - beware legalese!
		/*
		   LICENSE
		
		   This license grants Fenoxo, creator of this game usage of the works of
		   Dxasmodeus in this product. Dxasmodeus grants Fenoxo and the coders assigned by him
		   to this project permission to alter the text to conform with current and new game
		   functions, only. Dxasmodeus grants exclusive rights to Fenoxo to add upon events to meet with
		   suggestions made by consumers as to new content. Dxasmodeus retains exclusive rights to alter
		   or change the core contents of the events and no other developer may alter, change or use the events without
		   permission from dxasmodeus except where otherwise specified in this license. Fenoxo agrees to
		   include Dxasmodeus' name in the credits with indications to the specific contribution made to the licensor.
		   This license must appear either at the beginning or the end of the primary file in the source code and cannot be deleted
		   by a third party. This license is also retroactive to include all versions of the game code
		   including events created by dxasmodeus.
		
		   DECLARATION OF OWNERSHIP
		
		   The following events are the creative works of dxasmodeus and are covered under this license.
		
		   Tentacle Plant Event
		   Giacomo the Travelling Merchant
		   All item events relating to purchases from Giacomo the Travelling Merchant
		   Worm Colony Infestation Events
		
		   Tentacle Plant Event and Giacomo sub-events are copyright 2010 by Dxasmodeus.
		   Worm Colony Events are copyright 2011 by dxasmodeus.
		
		   THIRD PARTY USAGE
		
		   As Fenoxo has made his game code open source, this license DOES NOT transfer to a
		   third party developer. The events created by Dxasmodeus may not be used in whole or in part
		   without permission and license from Dxasmodeus. Dxasmodeus reserves the sole and exclusive right to
		   grant third party licenses of copyrighted scenarios.
		
		   For further information and license requests, dxasmodeus may be contacted through private
		   message at the Futanari Palace. http://www.futanaripalace.com/forum.php.
		
		   ENFORCEMENT
		
		   This license supercedes all previous licenses and remains in force.
		 */
		//Gender hilarity chance.
		if (player.gender == 0 && rand(3) == 0 && !player.isNaga() && !player.isTaur() && !player.isGoo())
		{
			//Warm up for neuters as per the old event:
			outputText("You see a massive, shambling form emerge from the underbrush. While first appearing to be a large shrub, it shifts its bulbous mass and reveals a collection of thorny tendrils and cephalopodic limbs. Sensing your presence, it lumbers at you, full speed, tentacles outstretched.\n\n", false);
			
			if (player.cor > 50 && player.cor <= 75)
				outputText("You debate the merits of running from such a creature, and realize it's now too late to escape.  ", false);
			if (player.cor > 75)
				outputText("You smile and stride forward, welcoming the pleasure you expect from such a monster.  ", false);
			//HILARIOUS NEUTER EVENT HERE
			if (player.cor < 75)
				outputText("While you attempt to resist the abomination, its raw muscle mass is too much. ", false);
			outputText("It pins you to the ground easily. You feel slimy tentacles run up and down your groin as the creature searches for whatever gonads it expected you to have. When it realizes that you have neither penis nor vagina, it smartly casts you to the ground in apparent disgust.\n\n\"<i>WHAT THE FUCK IS THIS SHIT?!!</i>\" The creature speaks in an unnervingly human voice.\n\n", false);
			outputText("Completely confused, all you can do is sit there in shock.\n\n\"<i>Where are your naughty bits, goddammit!</i>\" the creature bellows. \"<i>Us tentacle creatures need to FEED!</i>\"\n\n", false);
			outputText("You sheepishly state that you are gender-neutral and have no genitalia.\n\n\"<i>You gotta be shitting me!!</i>\" the monster bellows in contempt. \"<i>Of all the motherfuckers I ambush, it has to be the ONE bastard I can't feed from! What am I supposed to do now, asshole?! I gotta eat!</i>\"", false);
			outputText("At a loss for words, you meekly offer the creature some of your food you have packed for your journey. The creature slaps it out of your hand, almost breaking your wrist.\n\n\"<i>I can't eat that shit!</i>\" roars the abomination. \"<i>Do I look like I have a fucking mouth to chew that with?! NOOOOOO! I feed off dicks and wayward women! Cum and tit milk! YOU have NEITHER!!!</i>\"  ", false);
			outputText("The beast slaps you squarely on the ass as if to push you along. \"<i>Get the fuck out of here!</i>\" it screams. \"<i>Get lost so I can hunt me a REAL meal!!!</i>\"", false);
			outputText("You walk away from the creature, which hides back in the brush. After you trek a bit, you wonder if what happened really DID happen...", false);
			dynStats("lus", -5);
			doNext(13);
			return;
		}
		//Combat starter
		outputText("You see a massive, shambling form emerge from the underbrush.  While it resembles a large shrub, a collection of thorny tendrils and cephalopodic limbs sprout from its bulbous mass.  Sensing your presence, it lumbers at you, full speed, tentacles outstretched.\n\n", false);
		if (player.cor > 50 && player.cor <= 75)
			outputText("You debate the merits of running from such a creature.\n\n", false);
		if (player.cor > 75)
			outputText("You smile and stride forward, welcoming the pleasure you expect from such a monster.\n\n", false);
		//Worms get nothing!
		if (player.hasStatusAffect("infested") >= 0)
		{
			outputText("It stops itself completely in a moment and twitches, as if sniffing the air, before turning around and disappearing into the underbrush.", false);
			doNext(13);
			return;
		}
		if (player.cor > 50)
		{
			outputText("Do you joyfully submit or fight back?\n\n", false);
			simpleChoices("Fight", 2080, "Submit", forest.tentacleBeastScene.tentacleLossRape, "", 0, "", 0, "", 0);
			return;
		}
		startCombat(new TentacleBeast());
	}
	//Tentacle continuation!
	else if (eventNo == 2010)
	{
		dynStats("tou", 1, "int", -.5, "lib", 2, "sen", 1, "lus=", 0, "cor", .5);
		//Pg2
		if (player.gender == 1)
		{
			outputText("You next feel the wretched sensation of another tentacle pushing its way past your anus and into your rectum. You cry more out of frustration and anger than pain as the foreign body settles a few inches inside your body. With a furious, coordinated rhythm, the monstrosity begins swelling the tentacle in your ass and ", true);
			spriteSelect(100);
			if (player.cockTotal() == 1)
				outputText("using a sucking-stroking motion on your helpless " + multiCockDescriptLight() + ". The swelling of the ass tentacle pressures your prostate in a paradoxically pleasurable and painful manner. You realize, much to your terror, that this beast is MILKING you of your semen!", false);
			else
				outputText("using a sucking-stroking motion on your " + multiCockDescriptLight() + ".  The swelling of the ass tentacle pressures your prostate in a paradoxical pleasurable and painful manner.  You realize, much to your terror, that this beast is MILKING you of your semen!", false);
			player.buttChange(50, true);
			outputText("\n\nHelpless and overwhelmed by the pleasure of such rough and primal stimulation, all you can do is give the creature what it wants; your hot cum. Your body only responds to the sensations from your ", false);
			if (player.cockTotal() == 1)
				outputText(multiCockDescriptLight() + " and ass and in a very short time, your phallus explodes, launching stream upon stream of hot, thick cum into the horror. Your hips and pelvis buck violently with each thrust as the creature masterfully strokes your " + multiCockDescriptLight() + "  and milks your prostate of your fluids. You cry with each orgasm, prompting the thing to milk you harder. After an eternity of successive ejaculations, the creature withdraws its unholy arms and leaves you in a bruised, lacerated, overfucked heap on the ground, discarded like a person throws away a corn cob after a meal.", false);
			else
				outputText(multiCockDescriptLight() + " and ass and in a very short time, your dicks explode, launching stream upon stream upon stream of hot, thick cum into the horror.  Your hips and pelvis buck violently with each thrust as the creature masterfully strokes your " + multiCockDescriptLight() + " and milks your prostate of your fluids.  You cry with each orgasm, prompting the thing to milk you harder. After an eternity of successive ejaculations, the creature withdraws its unholy arms and leaves you in a bruised, lacerated, overfucked heap on the ground, discarded like a person throws away a corn cob after a meal.", false);
		}
		if (player.gender == 2)
		{
			outputText("The beast rears up to reveal a beak-like maw. It opens its massive jaws to reveal ", true);
			spriteSelect(100);
			if (player.vaginas.length == 1)
				outputText("a tongue shaped like a large cock while its tongue, like any tentacle, immediately seeks out your defenseless pussy. It prods itself mockingly around your labia as you attempt to contract to keep it from violating you and depriving you of what dignity you have left. The creature flexes its appendage and easily forces its way into your vagina", false);
			else
				outputText(player.vaginas.length + " tongues shaped like large cocks while its tongues, like any other tentacles, seeks out your defenseless pussies.  It prods itself mockingly around your labias as you attempt to contract to keep them from violating you and depriving you of what dignity you have left.  The creature flexes its appendages and easily forces its way into your " + vaginaDescript(0) + "s", false);
			if (player.vaginas.length > 1)
				outputText("s", false);
			outputText(". As you cry out in shock, another dick-shaped appendage forces its way into your throat. The beast takes care to prevent you from choking on its limb.", false);
			outputText("\n\nIn a coordination that can only signify higher intelligence, the monster fucks your " + vaginaDescript(0), false);
			if (player.vaginas.length > 1)
				outputText("s", false);
			outputText(" and mouth and begins milking your swollen breasts and sucks your throbbing ", false);
			if (player.vaginas.length > 1)
				outputText("clits. ", false);
			else
				outputText("clit. ", false);
			player.cuntChange(player.vaginalCapacity() * .76, true);
			outputText(" Your body betrays your resistance as pleasure hammers you from crotch to head. After some time, you begin bucking your hips in tandem to the creature's thrusts, drunk with pleasure. As you peak for your orgasm, you feel the creature bottom out inside your womb. Oceans of hot cum flood your " + vaginaDescript(0), false);
			if (player.vaginas.length > 1)
				outputText("s", false);
			outputText(" and your mouth. You are being inseminated by the abomination, but you do not care. The fucking is too good. The hot, musky fluids pour into your mouth. The taste crushes your last bit of resistance and you NEED MORE, not just to swallow, but to devour with your womb. You manage to free one hand, only to grasp the tentacle in your mouth to coax more semen inside you. You feel your stomach distend from the amount of cum you greedily swallow. The beast floods you with more cum than you can handle and proceeds to soak you from head to toe in its fluids as it runs from your overwhelmed orifices.", false);
			doNext(2011);
			player.slimeFeed();
			//lactate more from the encounter.
			player.boostLactation(.3);
			return;
		}
		if (player.gender == 3)
		{
			if (player.cockTotal() == 1)
			{
				outputText("A sharp tug tells you that the creature has sealed itself upon your " + cockDescript(0) + ". You see " + player.totalBreasts() + " smaller tentacles latch onto your erect nipples. You feel milk begin to leak out as the creature makes a perfect seal around your areola. A thick, phallic tentacle probes underneath your trapped " + cockDescript(0) + " until it finds your vaginal opening. You cry out as the member punches past your opening and bottoms out in your womb. The tentacle swells up until it completely fills your " + vaginaDescript(0) + ".  ", true);
				spriteSelect(100);
				player.cuntChange(player.vaginalCapacity() * .76, true, false, true);
				outputText("With freakish coordination, the beast sucks your " + cockDescript(0) + " and tits while hammering away at your " + vaginaDescript(0) + ". The overwhelming pleasure courses through your body and triggers an immediate orgasm, sending gouts of cum into the tentacle sealed around your " + cockDescript(0) + ". The sensation of your fluids entering the creature prompts it to suck your " + cockDescript(0) + " harder as well as hammer your " + vaginaDescript(0) + " faster, leading to a chain of orgasms.\n\n", false);
				outputText("Drunk with pleasure, you revel in the sensation of cumming into the creature while it breast feeds from you. All you can do is drown in the experience of being milked from top to bottom. The creature begins piledriving your box faster and you feel like the creature is going to impale you with its phallic tentacle.\n\n", false);
				outputText("The creature's milking tentacles stop moving and you feel the dick-tentacle press sharply against your womb. You feel the thunderous force of hot fluid lance into your body as the creature cums repeatedly inside you, triggering yet another orgasm. The creature cums in surges and shoots repeatedly inside you. Within moments, excess cum spews out of your " + vaginaDescript(0) + " as it cannot hold anymore, but the creature keeps cumming.\n\n", false);
				outputText("After a while the creature withdraws its tentacles from you. It poises the tentacle-cock over your face and lets out one last load, covering your face in hot, thick sperm. You reflexively open your mouth and allow loads of the salty juice down your throat. Once spent, the creature shambles off, leaving you well milked and cum-soaked.", false);
			}
			else
			{
				outputText("A sharp tug tells you that the creature has sealed itself upon your " + multiCockDescriptLight() + ". You see " + player.totalBreasts() + " smaller tentacles latch onto your erect nipples. You feel milk begin to leak out as the creature makes a perfect seal around your areola. A thick, phallic tentacle probes underneath your trapped cocks until it finds your vaginal opening. You cry out as the member punches past your opening and bottoms out in your womb. The tentacle swells up until it completely fills your " + vaginaDescript(0) + ".", true);
				spriteSelect(100);
				player.cuntChange(player.vaginalCapacity() * .76, true, true, false);
				outputText("  With freakish coordination, the beast sucks your " + multiCockDescriptLight() + " and tits while hammering away at your " + vaginaDescript(0) + ". The overwhelming pleasure courses through your body and triggers an immediate orgasm, sending gouts of cum into the tentacles sealed around your pricks. The sensation of your fluids entering the creature prompts it to suck your throbbing cocks harder as well as hammer your " + vaginaDescript(0) + " faster, leading to a chain of orgasms.\n\n", false);
				outputText("Drunk with pleasure, you revel in the sensation of cumming into the creature while it breast feeds from you. All you can do is drown in the experience of being milked from top to bottom. The creature begins piledriving your box faster and you feel like the creature is going to impale you with its phallic tentacle.\n\n", false);
				outputText("The creature's milking tentacles stop moving and you feel the dick-tentacle press sharply against your womb. You feel the thunderous force of hot fluid lance into your body as the creature cums repeatedly inside you, triggering yet another orgasm. The creature cums in surges and shoots repeatedly inside you. Within moments, excess cum spews out of your " + vaginaDescript(0) + " as it cannot hold anymore, but the creature keeps cumming.\n\n", false);
				outputText("After a while the creature withdraws its tentacles from you. It poises the tentacle-cock over your face and lets out one last load, covering your face in hot, thick sperm. You reflexively open your mouth and allow loads of the salty juice down your throat. Once spent, the creature shambles off, leaving you well milked and cum-soaked.", false);
			}
			player.slimeFeed();
			//lactate more from the encounter.
			player.boostLactation(.3);
		}
		if (gameState > 0)
			cleanupAfterCombat();
		else
			doNext(13);
		
	}
	//Tentacle rape continuation for females (pg3!)
	else if (eventNo == 2011)
	{
		//single coochie
		if (player.vaginas.length == 1)
		{
			outputText("Satisfied, the creature drops you smartly, withdraws its limbs from you, and lumbers away. Covered completely in cum, you see that your clitoris swelled up to ", true);
			spriteSelect(100);
			//Big clit girls get huge clits
			if ((player.hasPerk("Big Clit") >= 0 && player.clitLength > 2) || player.clitLength > 3)
				outputText("almost " + num2Text(Math.floor(player.clitLength * 1.75)) + " inches in length. ", false);
			//normal girls get big clits
			else
				outputText("almost four inches in length. ", false);
			outputText("Bruised and sore, you pass into unconsciousness ", false);
		}
		else {
			outputText("Satisfied, the creature drops you smartly and withdraws its limbs from you and lumbers away. Covered completely in cum, you see that your " + player.vaginas.length + " clits swelled up to almost four inches in length. Bruised and sore, you pass into unconsciousness, ", true);
			spriteSelect(100);
		}
		//Not too corrupt
		if (player.cor < 75)
			outputText("too intoxicated with lust to fume over your violation. ", false);
		//Very corrupt
		else
			outputText("too intoxicated with lust continue the pleasure. ", false);
		//If has big-clit grow to max of 6"
		if (player.clitLength < 7 && player.clitLength >= 3.5 && player.hasPerk("Big Clit") >= 0)
		{
			player.clitLength += .1 + player.cor / 100;
			outputText("Your massive clitty eventually diminishes, retaining a fair portion of it's former glory.  It is now " + int(player.clitLength * 10) / 10 + " inches long when aroused, ", false);
			if (player.clitLength < 5)
				outputText("like a tiny cock.", false);
			if (player.clitLength >= 5 && player.clitLength < 7)
				outputText("like a slick throbbing cock.", false);
			if (player.clitLength >= 7)
				outputText("like a big thick cock.", false);
		}
		//Grow clit if smaller than 3.5"
		else if (player.clitLength < 3.5)
		{
			outputText("In time your clit returns to a more normal size, but retains a bit of extra volume.", false);
			player.clitLength += .2;
		}
		//Mention that clit doesn't grow if your big enough.
		else
			outputText("In time it returns to it's normal size, losing all the extra volume.", false);
		if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_TIGHT)
			player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_NORMAL;
		player.slimeFeed();
		if (gameState > 0)
			cleanupAfterCombat();
		else
			doNext(13);
		
	}
	//Flower fun-times
	else if (eventNo == 2012)
	{
		//Sex scenes for those with cawks
		if (player.gender == 1 || player.gender == 3)
		{
			//Single Cawk
			if (player.cocks.length == 1)
			{
				outputText("You grin to yourself as you decide to see just how close to a pussy these perverted little flowers are.  The thick stem bends with ease as you grasp it and bend it towards your groin, your other hand fumbling to open your " + player.armorName + ". In seconds you free yourself and gingerly bring the folds closer, the musky scent that fills the air rapidly bringing you to a full, throbbing hardness. The ", true);
				spriteSelect(92);
				outputText("first touch of petals to your skin slicks you with the flower's silky secretions, allowing you to easily slip between the petals. Though the flower looks fairly deep, you quickly feel yourself bottom out inside the petal's slippery grip. Shrugging, you decide to make the best of it and begin thrusting into the plant, enjoying the unusual sensations along the front-most parts of your " + cockDescript(0) + ". As ", false);
				outputText("you pound away, you begin to notice a change in the rear of the flower.\n\n", false);
				//New PG
				outputText("It feels as if something is opening up, and the tip of your cock begins slipping through a tight ring, bulging the plant's stem noticeably. The sudden change worries you enough to pull back for a moment, your " + cockDescript(0) + " nearly clearing the opening before dozens of tiny whip-like tendrils burst from the flower, wrapping your maleness with painful tightness. They constrict further and with a burst of movement, slam the flower down onto your " + cockDescript(0) + ", pulling you further and further into the stem with painful force. You struggle briefly but the pain it causes your ", false);
				outputText("over-stimulated member is too much, so you just give up, letting the pussy-like plant draw the last of you inside its stem, the silken flowers cupping around your ", false);
				if (player.balls > 0)
					outputText("balls and gently squeezing them.\n\n", false);
				else
					outputText("groin and gently squeezing your taint.\n\n", false);
				//New PG
				outputText("You feel a flood of wetness surge up from the depths of the plant, surrounding your member with even more fluid as the stem begins constricting and squeezing. Gently at first, and then with increasing insistence, a suction builds inside the stem, drawing more and more blood into your " + cockDescript(0) + ". The stem, now heavily distended by your massive member, continues rippling, squeezing, and sucking your over-engorged meat-pole, overwhelming your mind with sensation far beyond normal. You'd wonder just what kind of tactile-enhancing fluids that plant excretes, if you weren't already mindlessly pistoning against the tainted plant, still locked inside it by tight little tentacles.\n\n", false);
				//new PG
				outputText("You cum, and cum, and cum, the evidence of your pleasure devoured by the plant's sucking, squeezing gullet. The orgasm drags on for what feels like forever, your " + player.legs() + " eventually giving out, your hips the only muscle that seems to work as they twitch into the air, as if begging for more. You are milked of a few last big spurts, at last collapsing.\n\n", false);
				//New PG
				outputText("The tendrils encircling your genitals do not release, instead they pull tighter, one of the tiny plant's appendages penetrating your urethra, squirming up the cum slick passage with uncomfortable slowness. You lay there, too weak to resist it or fight, hoping that whatever the plant is doing won't hurt much. You feel it twisting and coiling inside you... until it stops. You feel a sharp pinch, and then it withdraws, seemingly satisfied. The tendrils unwrap, allowing the plant to spring back up, exposing your still over-engorged and sensitive member.\n\n", false);
				//New PG
				outputText("You lay there for some time until your muscle control returns, your cock still slightly over-large ", false);
				if (player.balls >= 2)
					outputText("and your " + ballsDescriptLight() + " ", false);
				else
					outputText("and ", false);
				outputText("feeling sore from the exertion. At least you hope it's just from the exertion and not from whatever the plant did.\n\n", false);
				if (player.cumQ() < 25)
					outputText("As you depart, you notice the plant looking remarkably colorful and healthy...", false);
				if (player.cumQ() >= 25 && player.cumQ() < 250)
					outputText("As you depart, you notice the plant's stalk bulging slightly from your deposit.", false);
				if (player.cumQ() >= 250 && player.cumQ() < 500)
					outputText("As you depart, you note the plant's stalk bulging obscenely, bits of your seed dripping from the flower's opening.", false);
				if (player.cumQ() >= 500)
					outputText("As you depart, you note the plant's stalk bulging out obscenely, looking like an overfull balloon.  It's stretched so thin as to be transparent, your cum sloshing about inside it as it attempts to digest it's meal. Steady streams of your jism leak from the flower's lips, unable to keep it all inside.", false);
			}
			//Multicock
			else
			{
				outputText("You grin to yourself as you decide to see just how close to a pussy these perverted little flowers are.  The thick stems bends with ease as you grab a few with your hand and pull them towards your groin, your other hand fumbling to open your " + player.armorName + ". In seconds you free yourself, and gingerly bring the folds closer.  The musky scent filling the air rapidly brings your " + multiCockDescriptLight() + " to a full, throbbing hardness. The first touch of petals to your skin slicks you with the flower's silky secretions, allowing you to easily slip between the petals. Though the flowers look fairly deep, you quickly feel yourself bottom out inside the petals' slippery grip. Shrugging, you decide to make the best of it and begin thrusting into the plant, enjoying the unusual sensations along the front-most parts of your " + multiCockDescriptLight() + ". As you pound away, you begin to notice a change in the rear of the flowers.\n\n", true);
				spriteSelect(92);
				outputText("They seem to be gradually opening up, allowing the smallest of your cock-tips to begin slipping through an opening in the backs of the flowers and into the stems.  Shocked by this unexpected development, you pull the bundle of flowers from your " + multiCockDescriptLight() + ", but whiplike tendrils shoot forth from deep within the flowers, wrapping tightly around your manhoods, painfully squeezing as they drag your " + multiCockDescriptLight() + " back into the tight vaginal openings.  They pull tighter as they force you deeper inside the plant, pulling the full length of each of your members into the constricting stalks.   Wrapped tightly around your base, the tendrils form effective cock-rings, making each of your " + multiCockDescriptLight() + " overfill with blood.\n\n", false);
				outputText("You briefly try to free yourself but the pain it causes your groin overwhelms you.  Resigned to your fate, you allow the plants to wrap their petals fully around your groin, encapsulating all of your maleness.  With surprising gentleness, you feel a suction and squeezing building around each and every one of your dicks.  You feel a flood of fluids around each over-engorged member, making them tingle with unnatural sensitivity.  The squeezing and sucking of the plant's stalks, combined with the sudden onset of strange sensation, is too much to bear.  You feel a churning pressure at the base of your groin, liquid heat filling every member as your body makes ready to give these plants what they want.\n\n", false);
				outputText("You cum, and cum, and cum, the evidence of your pleasure devoured by the plant's sucking, squeezing gullet. The orgasm drags on for what feels like forever, your " + player.legs() + " eventually giving out, your hips the only muscle that seems to work as they twitch into the air, as if begging for more. You are milked of a few last big spurts, at last collapsing.\n\n", false);
				outputText("The tendrils encircling your genitals do not release, instead they pull tighter, one of each plant's tiny appendages penetrating your urethras, squirming up your cum slick passages with uncomfortable slowness.  You lay there, too weak to resist it or fight, hoping that whatever the plants are doing won't hurt much. You feel it twisting and coiling inside you... until it stops. You feel a sharp pinch, and then it withdraws, seemingly satisfied. The tendrils unwrap, allowing the plants to spring back up, exposing your still over-engorged and sensitive members.\n\n", false);
				outputText("You lay there for some time until your muscle control returns, your cock still slightly over-large ", false);
				if (player.balls >= 2)
					outputText("and your " + ballsDescriptLight() + " ", false);
				else
					outputText("and ", false);
				outputText("feeling sore from the exertion. At least you hope it's just from the exertion and not from whatever the plant did.\n\n", false);
				if (player.cumQ() < 25)
					outputText("As you depart, you notice the plants looking remarkably colorful and healthy...", false);
				if (player.cumQ() >= 25 && player.cumQ() < 250)
					outputText("As you depart, you notice the plants' stalks bulging slightly from your deposit, their flowers wet with moisture and bright red.", false);
				if (player.cumQ() >= 250 && player.cumQ() < 500)
					outputText("As you depart, you note the plants' stalks bulging obscenely, bits of your seed dripping from the flowers' opening.", false);
				if (player.cumQ() >= 500)
					outputText("As you depart, you note the plants' stalks bulging out obscenely, looking like overfull balloons.  They're stretched so thin as to be transparent, your cum sloshing about inside them as they attempt to digest their meals. Steady streams of your jism leak from the flowers' lips, unable to keep it all inside.", false);
			}
			//Stat changes!
			dynStats("sen", 2, "lus=", 0);
			var booster:Number = 1;
			if (player.balls == 0)
				booster += 3;
			else if (player.ballSize < 6)
				booster += 2;
			if (player.hasPerk("Messy Orgasms") >= 0 && player.cumMultiplier < 3)
				booster += 1;
			player.cumMultiplier += booster;
		}
		//Oral sex for those without!
		else
		{
			outputText("You grin to yourself and decide to sample the fine smelling nectar of the flowers. You grip the unusually thick stalk as you lean down, taking in the bright red and iridescent purples of the pussy-flower's petals. You give it an experimental lick, gaining a feeling for the flavor of the nectar. It's delicious, but leaves your tongue tingling and sensitive. A small budding protrusion emerges from between the petals, slick with more of the plants fluid, cherry red and looking very much like an engorged clit.\n\n", true);
			spriteSelect(92);
			//New PG
			outputText("Giddy from either the novelty of the situation or the chemicals in the flower's juices, you lick at the plant's bud-like clit and are immediately rewarded with a burst of fruity plant-nectar. The taste becomes the last thing on your mind as your tongue becomes even more sensitive, every touch and taste rapidly becoming highly erotic. You delve into it's folds, seeking more nectar, your tongue slurping and licking, noisily tongue-fucking the little plant. The taste deepens, losing some of the sweetness as that clitty swells bigger, drops of tangy moisture oozing from it.\n\n", false);
			//New PG
			outputText("Closing your eyes, it becomes easy to lose yourself in the feeling of plunging in and out of those petals, your tongue a tiny cock. You revel in the decadence of it all, your lips becoming equally sensitive and engorged, french kissing the pussy-flower with abandon, rubbing your puffy lips over it's clit, tongue-fucking the flower with abandon. The petals curl around your face, as a sudden gush of fluid rushes out from deep within the flower, flooding your mouth with tangy sweetness. Your tongue quivers in pleasure as you feel your over-sensitized mouth orgasming, pleasurable and unlike anything else you've experienced. Swallowing instinctively, you collapse back on your haunches, licking your lips and squirming in satisfaction.", false);
			//Last PG
			outputText("You walk away, your lips and tongue feeling slightly puffy and sensitive, but none the worse for the wear.", false);
			player.slimeFeed();
			dynStats("sen", 4, "lus=", 0, "cor", 1);
		}
		doNext(13);
	}
	//Tentacle fun-times
	else if (eventNo == 2013)
	{
		//Vaginal Variant 50% of the time
		if (player.vaginas.length > 0 && rand(2) == 0)
		{
			outputText("You saunter over to a dangling group of perverted looking vines, discarding your " + player.armorName + " along the way. Running your fingertips along the bulbous-tipped tentacle-like vines, you find one that looks ", true);
			spriteSelect(92);
			//Big medium or small
			temp = rand(3);
			//Normal
			if (temp == 0)
			{
				outputText("well suited to your ", false);
				//determine size
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_TIGHT)
					temp2 = 3;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_NORMAL)
					temp2 = 6.5;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LOOSE)
					temp2 = 26;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING)
					temp2 = 60;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE)
					temp2 = 115;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LEVEL_CLOWN_CAR)
					temp2 = 175;
			}
			//Small
			if (temp == 1)
			{
				outputText("a little small for your ", false);
				//determine size
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_TIGHT)
					temp2 = 0;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_NORMAL)
					temp2 = 4;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LOOSE)
					temp2 = 16;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING)
					temp2 = 40;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE)
					temp2 = 65;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LEVEL_CLOWN_CAR)
					temp2 = 100;
			}
			//Large
			if (temp == 2)
			{
				outputText("almost too big to cram in your ", false);
				//determine size
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_TIGHT)
					temp2 = 6;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_NORMAL)
					temp2 = 9;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LOOSE)
					temp2 = 34;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING)
					temp2 = 78;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE)
					temp2 = 135;
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LEVEL_CLOWN_CAR)
					temp2 = 210;
			}
			//resume secksings
			outputText(vaginaDescript(0) + ". Yanking gently, you manage to yank a bit more vine free, allowing it to brush against the damp forest loam. That same soft earth makes the perfect cushion for you as you lay down, spreading your legs. With both hands you grasp the vine, guiding it towards the entrance of your " + vaginaDescript(0) + ". The beaded moisture that covers the vine tingles tantalizingly at the first contact with your lips.\n\n", false);
			//new PG
			//Small
			if (temp == 1)
				outputText("With a sexy little sigh, you slip the mushroom-like tip between your nether-lips, feeling it bulge a little as it penetrates you. The vine's lubricants combine with your own, turning your horny cunt into a sloppy little slip-and-slide. You take it all the way to your cervix, easily handling it's smaller size as you begin to use it like a favorite dildo. Deep inside your " + vaginaDescript(0) + ", the vine's lubricants begin to make your passage tingle, intensifying until your entire channel is overloaded with clit-like levels of sensation.\n\n", false);
			//Medium
			if (temp == 0)
				outputText("With a soft grunt, you manage to wrangle the fat tip of the vine between your nether-lips, feeling the swollen bulge pulse inside you penetrate yourself with it. The vine's lubricants combine with your own, turning your horny cunt into a sloppy slip-and-slide. You force in the rest of the vine's length, taking it all the way to your cervix, enjoying the feeling of fullness it gives you as you begin pumping it in and out like an obscene green dildo. Deep inside your " + vaginaDescript(0) + ", the vine's lubricants begin to make your passage tingle, intensifying until your entire channel is overloaded with clit-like levels of sensation.\n\n", false);
			//Large
			if (temp == 2)
				outputText("With a desperate grunt, you barely manage to force the obscene cock-head of the vine between your nether-lips. The swollen bulge pulses inside you, stretching you uncomfortably as it reacts to the warmth and tightness of your " + vaginaDescript(0) + ". The vine's lubricants begin to combine with your own, rapidly transforming your horny cunt into a sloppy slip-and-slide. You manage to cram the vine the rest of the way inside, bottoming it out against your cervix, reveling in the feeling of being stretched so wide, as you begin pumping it in and out of your " + vaginaDescript(0) + " like an over-sized sex-toy. Deep inside your " + vaginaDescript(0) + ", the vine's lubricants begin to make your passage tingle, intensifying until your entire channel is overloaded with clit-like levels of sensation.\n\n", false);
			//Stretch cuuuuunt and newline if it gets stretched
			if (player.cuntChange(temp2, true))
				outputText("\n\n", false);
			//New PG
			outputText("The rest of the world disappears as your mind tries to cope with the sensation overload coming from your groin. You're dimly aware of your hands pumping the slippery vine in and out, in and out, over and over.  Hips bucking, " + vaginaDescript(0) + " squeezing, thighs trembling, you achieve the first of many orgasms.  Incredibly, the sensitivity of your groin redoubles, nearly blacking you out from the pleasure.  Cumming over and over, you writhe in the dirt, pumping the corrupted prick-vine in and out of your spasming cunt.  Your eyes roll back in your head when the vine begins pumping you full of its strange fluid, and you finally lose your battle to remain conscious.\n\n", false);
			//New PG
			outputText("An hour or two later, you wake feeling very sore, but satisfied.  The vine must have popped free at some point and the bulb now rests on your pussy lips.  You go to brush it off and nearly orgasm from touching your nether-lips, still sensitive and parted from the overlarge tentacle they so recently took.  A rush of white goop escapes from between your thighs as you stand, soaking back into the soil immediately.   A quick stretch later, you don your gear and head back to camp with a smile.\n\n", false);
			//Normal stat changes
			player.slimeFeed();
			dynStats("sen", 5, "lus=", 0, "cor", 2);
			//Xforms
			//Change hair to green sometimes
			if (rand(3) == 0 && player.hairColor != "green")
			{
				temp++;
				outputText("You don't get far before you realize all the hair on your body has shifted to a verdant green color.  <b>You now have green hair.</b>  ", false);
				player.hairColor = "green";
			}
			//+hip up to 10
			if (rand(4) == 0 && player.hipRating <= 10)
			{
				temp++;
				outputText("A strange shifting occurs below your waist, making your " + player.armorName + " feel tight.  <b>Your hips have grown larger</b>, becoming " + hipDescript() + ".  ", false);
				player.hipRating += rand(3) + 1;
				player.fertility++;
			}
			doNext(13);
		}
		else
		{
			outputText("You approach the swollen vines, noting a drizzle of fluid leaking from one of the bulbous and mushroom-like tips.   Licking your lips as you approach, you feel your heart beat faster in anticipation of sampling the tainted flora of the glade.   Grasping one gently, you lift it up, noting the pebbly texture along the curvature of its head, and the soft nubs on the underside where it rejoins the stalk.  The whole thing feels moist, just barely lubricated with some fluid that the plant seems to sweat.\n\n", true);
			spriteSelect(92);
			//new PG
			outputText("Pulling it closer, you open your mouth wide enough to take in the plant, slipping it between your lips.  The taste of the plant is starchy with a tangy aftertaste.  You run your tongue around it lewdly, your efforts swiftly rewarded by a spurt of salty cream.   The penis vine seems more receptive to your actions than the real thing, shifting color to a rapidly darkening pink.  You begin jacking the vine off with your hands, rubbing a fingertip where the 'bulb' joins the stalk.  In no time it starts spurting seed into your throat, bright crimson spreading back along the vine as thick bulges of goo are pumped down the vine.  The bulb in your mouth swells up like a balloon, wrenching your jaws apart and trapping itself behind your teeth.   You're forced to breathe through your nose as it rapidly plugs your oral opening, gulping down each load of throat-filling seed in an effort not to choke.\n\n", false);
			//New PG
			outputText("You wonder if your efforts are in vain as time passes and your stomach fills with strange alien fluids.  Feeling faint from lack of oxygen, you drop to your knees, throat working overtime to swallow and breathe, only to immediately swallow another load.   Your whole body burns from the effort.  Your lungs hurt, your heart spasms, and your gut gurgles as it takes in the strange liquid.   Nearly unconscious, you sway, the vine pulled tight in your mouth, supporting the weight of your body.\n\n", false);
			//New PG
			outputText("With a snap you feel consciousness return, the endless torrent of fluid has stopped, though your mouth is still pried wide open by the engorged bulb.  In panic, you thrash backwards, painfully yanking against the now-taut vine.  You struggle in vain a moment, the vine not giving an inch, until finally you feel the bulb start to soften.  Working it back and forth, you eventually manage to pry it free with a satisfying 'pop'.   Rubbing your hand against your sore jawline, you step away from the glade, spitting out some of the musky goop with every step.\n\n", false);
			//Last PG includes change-texts
			outputText("As you leave the corrupted plant-life behind a comforting warmth seems to radiate from your gut, suffusing you with gentle heat that makes your ", false);
			//Cocks (and maybe vagina)
			if (player.cocks.length > 0)
			{
				if (player.cocks.length == 1)
					outputText(cockDescript(0), false);
				if (player.cocks.length > 1)
					outputText(multiCockDescriptLight(), false);
				if (player.vaginas.length > 0)
					outputText(" and " + vaginaDescript(0), false);
			}
			//Vagina
			else if (player.vaginas.length > 0)
				outputText(vaginaDescript(0), false);
			//nipples
			else if (player.vaginas.length == 0 && player.cocks.length == 0)
				outputText("nipples", false);
			//Finish sentance
			outputText(" tingle.  ", false);
			//Simple stat changes - + lust.
			dynStats("lus", 25 + player.lib / 10, "cor", 2);
			//Changes start, counted with temp
			temp = 0;
			player.slimeFeed();
			//Change hair to green sometimes
			if (rand(3) == 0 && player.hairColor != "green")
			{
				temp++;
				outputText("You don't get far before you realize all the hair on your body has shifted to a verdant green color.  <b>You now have green hair.</b>  ", false);
				player.hairColor = "green";
			}
			//+butt up to 10
			if (rand(4) == 0 && player.buttRating <= 10)
			{
				temp++;
				outputText("A strange shifting occurs on your backside, making your " + player.armorName + " feel tight.  <b>Your butt has grown larger</b>, becoming a " + buttDescript() + ".  ", false);
				player.buttRating += rand(3) + 1;
			}
			//Rarely change one prick to a vine-like tentacle cock. 
			if (rand(3) == 0 && player.cocks.length > 0 && player.hairColor == "green")
			{
				if (player.tentacleCocks() < player.cockTotal())
				{
					//Single cawks
					if (player.cocks.length == 1)
					{
						outputText("Your feel your " + cockDescript(0) + " bending and flexing of its own volition... looking down, you see it morph into a green vine-like shape.  <b>You now have a tentacle cock!</b>  ", false);
						//Set primary cock flag
						player.cocks[0].cockType = CockTypesEnum.TENTACLE;
						temp++;
					}
					//multi
					if (player.cockTotal() > 1)
					{
						outputText("Your feel your " + multiCockDescriptLight() + " bending and flexing of their own volition... looking down, you watch them morph into flexible vine-like shapes.  <b>You now have green tentacle cocks!</b>  ", false);
						temp2 = player.cocks.length;
						//Set cock flags
						while (temp2 > 0)
						{
							temp2--;
							player.cocks[temp2].cockType = CockTypesEnum.TENTACLE;
						}
						temp++;
					}
				}
			}
			doNext(13);
		}
	}
	
	//A WILD GIACOMO APPEARS
	else if (eventNo == 2015)
	{
		spriteSelect(23);
		//set gamestate to 4, used for making item looting function with his shop
		gameState = 4;
		if (giacomo > 0)
		{
			//If infested && no worm offer yet
			if (player.hasStatusAffect("WormOffer") < 0 && player.hasStatusAffect("infested") >= 0)
			{
				outputText("Upon walking up to Giacomo's wagon, he turns to look at you and cocks an eyebrow in curiosity and mild amusement.\n\n", true);
				outputText("\"<i>Been playing with creatures best left alone, I see</i>,\" he chuckles. \"<i>Infestations of any kind are annoying, yet your plight is quite challenging given the magnitude of corrupt creatures around here. It is not the first time I have seen one infested with THOSE worms.</i>\"\n\n", false);
				outputText("You ask how he knows of your change and the merchant giggles heartily.\n\n", false);
				outputText("\"<i>Do not look at me as if I am a mystic,</i>\" Giacomo heckles lightly. \"<i>Your crotch is squirming.</i>\"\n\n", false);
				outputText("Looking down, you realize how right he is and attempt to cover yourself in embarrassment.\n\n", false);
				outputText("\"<i>Fear not!</i>\" the purveyor jingles. \"<i>I have something that will cure you of those little bastards. Of course, there is also a chance that it will purge your system in general. This potion is not cheap. I will trade it for 175 gems.</i>\"\n\n", false);
				//Broke as a joke
				if (player.gems < 175)
				{
					outputText("You realize you don't have enough gems for such a pricey potion, but perhaps there is something else in his inventory you can buy.", false);
					doNext(2015);
				}
				//Can afford
				else
				{
					outputText("Do you purchase his cure?", false);
					//Remove/No
					doYesNo(2081, 2015);
				}
				player.createStatusAffect("WormOffer", 0, 0, 0, 0);
			}
			else
			{
				outputText("You spy the merchant Giacomo in the distance.  He makes a beeline for you, setting up his shop in moments.  ", true);
				outputText("Giacomo's grin is nothing short of creepy as he offers his wares to you. What are you interested in?", false);
				//If player is infested and knows of the cure..
				if (player.hasStatusAffect("WormOffer") >= 0 && player.hasStatusAffect("infested") >= 0)
				{
					simpleChoices("Potions", 2016, "Books", 2017, "Erotica", 2018, "Worm Cure", 2082, "Leave", 13);
				}
				//If the cure isnt an option
				else
					simpleChoices("Potions", 2016, "Books", 2017, "Erotica", 2018, "", 0, "Leave", 13);
				statScreenRefresh();
			}
		}
		else
		{
			outputText("As you travel, you see another person on the road. He is tethered to a small cart that is overloaded with a hodgepodge of items. He is dressed in a very garish manner, having a broad, multicolored hat, brocaded coat and large, striped pantaloons. His appearance is almost comical and contrasts with his severe and hawkish facial features. The man sees you, smiles and stops his cart.\n", true);
			outputText("\"<i>Greetings, traveler! My name is Giacomo. I am, as you can see, a humble purveyor of items, curios and other accoutrements. While I am not in a position to show you my full wares as my shop is packed on this push-cart, I do offer some small trinkets for travelers I meet.</i>\"\n\n", false);
			outputText("The merchant looks at you sharply and cracks a wide, toothy smile you find... unnerving. The merchant twists his way around to access a sack he has around his back. After a moment, he swings the sack from his back to have better access to its contents. Inquisitively, the merchant turns back to you.\n", false);
			outputText("\"<i>So stranger, be you interested in some drafts to aid you in your travels, some quick pamphlets to warn you of dangers on journeys or...</i>\"\n\n", false);
			outputText("Giacomo pauses and turns his head in both directions in a mocking gesture of paranoid observation. His little bit of theatrics does make you wonder what he is about to offer.\n", false);
			outputText("\"<i>...maybe you would be interested in some items that enhance the pleasures of the flesh? Hmmm?</i>\"\n\n", false);
			outputText("Giacomo's grin is nothing short of creepy as he offers his wares to you. What are you interested in?", false);
			simpleChoices("Potions", 2016, "Books", 2017, "Erotica", 2018, "", 0, "Leave", 13);
			statScreenRefresh();
			giacomo++;
		}
	}
	//Potion list!
	else if (eventNo == 2016)
	{
		spriteSelect(23);
		outputText("Which potion or tincture will you examine?", true);
		if (player.gender == 2)
			simpleChoices("Vitality T.", 2019, "Scholar's T.", 2021, "Blank", 0, "", 0, "Back", 2015);
		else
			simpleChoices("Vitality T.", 2019, "Scholars T.", 2021, "Cerulean P.", 2023, "", 0, "Back", 2015);
		statScreenRefresh();
	}
	//Book list!
	else if (eventNo == 2017)
	{
		spriteSelect(23);
		outputText("Which book are you interested in perusing?", true);
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00244] > 0)
			simpleChoices("Dangerous Plants", 2029, "Traveler's Guide", 2031, "Hentai Comic", 2033, "Yoga Guide", 2940, "Back", 2015);
		else
			simpleChoices("Dangerous Plants", 2029, "Traveler's Guide", 2031, "Hentai Comic", 2033, "", 0, "Back", 2015);
		statScreenRefresh();
	}
	//Erotica List - Sex Toy Choices!
	else if (eventNo == 2018)
	{
		spriteSelect(23);
		outputText("Giacomo's grin is nothing short of creepy as he offers his wares to you. What are you interested in?", true);
		if (player.gender == 1)
			simpleChoices("Dildo", 2035, "Onahole", 2041, "D Onahole", 2044, "", 0, "Back", 2015);
		if (player.gender == 2)
			simpleChoices("Dildo", 2035, "Stim-Belt", 2037, "AN Stim-Belt", 2039, "", 0, "Back", 2015);
		if (player.gender == 3)
			choices("Onahole", 2041, "D Onahole", 2044, "AN Onahole", 2048, "Stim-Belt", 2037, "AN Stim-Belt", 2039, "Dual Belt", 2142, "", 0, "", 0, "Dildo", 2035, "Back", 2015);
		if (player.gender == 0)
			simpleChoices("Dildo", 2035, "Onahole", 2041, "Stim-Belt", 2037, "", 0, "Back", 2015);
		statScreenRefresh();
	}
	//Vitality tincture pitch
	else if (eventNo == 2019)
	{
		spriteSelect(23);
		outputText("Giacomo holds up the item and says, \"<i>Ah, yes! The quintessential elixir for all travelers, this little bottle of distilled livelihood will aid you in restoring your energy on your journey and, should you be hurt or injured, will aid the body's ability to heal itself. Yes ", true);
		if (player.gender == 1)
			outputText("sir, ", false);
		if (player.gender == 2 || player.gender == 3)
			outputText("madam, ", false);
		outputText("this is liquid gold for pilgrim and adventurer alike. Interested? It is <b>15 gems</b></i>.\"  ", false);
		doYesNo(2020, 2016);
	}
	//vitality tincture purchase
	else if (eventNo == 2020)
	{
		spriteSelect(23);
		if (player.gems < 15)
		{
			outputText("\n\nGiacomo sighs, indicating you need " + String(15 - player.gems) + " more gems to purchase this item.", true);
			doNext(2016);
		}
		else
		{
			player.gems -= 15;
			inventory.takeItem(consumables.VITAL_T);
			statScreenRefresh();
		}
	}
	//Pitch Scholar's Tea
	else if (eventNo == 2021)
	{
		spriteSelect(23);
		outputText("Giacomo holds up a pouch of dried, fragrant leaves and begins his spiel, \"<i>Have you ever wondered how scholars and other smart folk keep up such a mental effort for so long? They make a tea out of this fine mixture of quality plants and herbs. Nothing but the best, this mysterious mixture of herbs in its Orange Pekoe base makes anyone, short of a lummox, as brainy as the finest minds of the land. All you do is steep the leaves in some water and drink up! Hot or cold, straight or sweetened with honey, your mind will run circles around itself once it has this for fuel. Buy it now and I will throw in the strainer for free!  Interested? Only <b>15 gems</b>!</i>\"  ", true);
		doYesNo(2022, 2016);
	}
	//Purchase Scholar's Tea
	else if (eventNo == 2022)
	{
		spriteSelect(23);
		if (player.gems < 15)
		{
			outputText("\n\nGiacomo sighs, indicating you need " + String(15 - player.gems) + " more gems to purchase this item.  ", true);
			doNext(2016);
		}
		else
		{
			player.gems -= 15;
			inventory.takeItem(consumables.SMART_T);
			statScreenRefresh();
		}
	}
	//Pitch cerulean potion
	else if (eventNo == 2023)
	{
		spriteSelect(23);
		outputText("Giacomo makes his comical over-the-shoulder search and holds up a sky-blue bottle. He grins widely as he begins his pitch, \"<i>My friend, you truly have a discerning eye. Even the most successful of men seek to attract more women for pleasure and status. This, my friend, will attract the most discerning and aroused of women. Women attracted by this fine unction will NEVER say no. I GUARANTEE that she will want pleasure every time you demand pleasure! A bit of a caution to you, brother. Some say this works TOO well. If you aren't man enough to handle the women this urn draws to you, you'd best say so now and I will offer something more to your liking. However, if you have the heart for it, I can sell you this little gem for <b>75 gems</b></i>!\"  ", true);
		doYesNo(2024, 2016);
	}
	//Purchase cerulean potion
	else if (eventNo == 2024)
	{
		spriteSelect(23);
		if (player.gems < 75)
		{
			outputText("\n\nGiacomo sighs, indicating you need " + String(75 - player.gems) + " more gems to purchase this item.", true);
			doNext(2016);
		}
		else
		{
			inventory.takeItem(consumables.CERUL_P);
			player.gems -= 75;
			statScreenRefresh();
		}
	}
	//Cerulean Potion Normal Variant!
	else if (eventNo == 2025)
	{
		spriteSelect(8);
		outputText("\nAs you sleep, your rest becomes increasingly disturbed. You feel a great weight on top of you and you find it difficult to breathe. Stirred to consciousness, your eyes are greeted by an enormous pair of blue tinged breasts. The nipples are quite long and thick and are surrounded by large, round areola. A deep, feminine voice breaks the silence. \"<i>I was wondering if you would wake up.</i>\" You turn your head to the voice to see the visage of a sharp-featured, attractive woman. The woman grins mischievously and speaks again. \"<i>I was hoping that idiot, Giacomo, did not dilute the 'potion' again.</i>\" Your campfire reflects off the woman's face and her beauty contains some sharply contrasting features. The pupils of her eyes are slit like a cat's. As she grins, she bares her teeth, which contain two pairs of long and short fangs. This woman is clearly NOT human! In shock, you attempt to get up, only prompting the woman to prove her inhuman nature by grabbing your shoulders and pinning you to the ground. You see that each finger on her hand also contains a fourth joint, further proving her status. Before you can speak a word, the woman begins mocking your fear and places her face in front of yours. Her face is almost certainly demonic in nature.\n\n", false);
		if (player.gender == 0)
		{
			outputText("She quickly moves down to your crotch... only to discover no organs down there.\n\n", false);
			outputText("*record scratch*\n\n", false);
			
			outputText("\"<i>Wait a fucking minute,</i>\" the Succubus says, \"<i>Where's your dick?!</i>\"\n\n", false);
			
			outputText("As you state your genderless nature, the succubus hops off and from nowhere pulls out a large folder marked \"<i>Corruption of Champions-Script</i>\" and begins thumbing through the pages. After finding the page she is looking for, she reads it and looks off into the distance in disgust.\n\n", false);
			
			outputText("\"<i>Hey Fenoxo and Dxasmodeus!!!!!!</i>\" the Succubus crows, \"<i>The goddamn script says that I should be milking someone's DICK!!! Man, futa, herm, I don't give a shit. YOUR OWN FUCKING SCRIPT SAYS I SHOULD BE MOUNTING AND MILKING A COCK!!!! THIS IS A SEX GAME!!!!!! THAT MEANS FUCKING! WHAT THE HELL AM I SUPPOSED TO FUCK???!!!</i>\"\n\n", false);
			
			outputText("The Succubus looks at you with utter contempt, \"<i>THIS motherfucker doesn't have a DAMN thing! What am I supposed to do?! I can't exactly order a fucking Happy Meal!!!!!</i>\"\n\n", false);
			
			outputText("Throwing the script down in an utter rage, the tantrum continues, \"<i>Goddammit! I can't believe this shit! HEY!!!!! INTERN!!!! Bring me my robe, aspirins and cancer sticks!!!!</i>\"\n\n", false);
			
			outputText("The Succubus walks a few paces away where a plain-dressed woman with a clipboard hands the Succubus a pack of cigarettes and a small bottle of aspirin. She takes a fistful of the painkillers and immediately lights up a smoke. The Succubus takes a couple of drags off the cig and rubs her temples.\n\n", false);
			
			outputText("\"<i>You two are killing me!</i>\" she groans in clear frustration, \"<i>I come to work for you perverts based off the promise of MORE perverts to feed from and you do THIS to me! I can't work like this!</i>\"\n\n", false);
			
			outputText("The plain woman hands the Succubus a robe, which she crudely puts on as she storms off into the night.\n\n", false);
			
			outputText("\"<i>I will discuss this horseshit with my agent,</i>\" the Succubus continues bitching, \"<i>THIS was NOT in my contract.</i>\"\n\n", false);
			
			outputText("The Succubus stops, turns and points to you in derision. \"<i>And YOU! You no-cock, no-cunt having pissant! Take your ass back to the lab before they find out you escaped!!!!!</i>\"\n\n", false);
			
			outputText("The Succubus resumes her stormy exit. You look at the bottle of Cerulean Potion and wonder if it REALLY had some psychotropics in it. What the hell just happened?!", false);
			flags[kFLAGS.CERULEAN_POTION_NEUTER_ATTEMPTED] = 1;
			doNext(1);
			return;
		}
		if (player.gender == 1)
			outputText("\"<i>Awwww! Did my blue skin and pointy teeth scare you?</i>\" she says in a childish voice. \"<i>Believe me stud, if I wanted to harm you, I would not have let you wake up at all. I am here because you have 'called' me.</i>\" She teases you with the empty blue bottle you bought from the merchant. \"<i>My essence is in this bottle. Any man who drinks this, I am compelled to return the pleasure by drinking his.</i>\" The demon woman reaches her skinny hand down to your crotch where you see you have become fiercely erect. The demon gently strokes your cock until you begin oozing generous amounts of your own natural lubricants. The demon takes one of her massive breasts and teases you with her fat nipples. \"<i>Open your mouth,</i>\" she demands. \"<i>Take me into your mouth as I will soon take you into mine.</i>\"\n\n", false);
		else if (player.gender == 3)
		{
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00111]++;
			outputText("\nIt is obvious that you have been confronted by a succubus. As the fire illuminates your captor, her grin widens broadly.\n\n", false);
			
			outputText("\"<i>Well, well, well!</i>\" the Succubus jingles. \"<i>What have we here?! A little girl with a big cock!</i>\"\n\n", false);
			
			outputText("As the Succubus looks down at your " + cockDescript(0) + ", you have quickly achieved one of the healthiest erections you have ever had. The succubus quickly poises her hairy hole over your member and allows her weight to force your dick into her womb. The demoness rests her weight in her lap as she allows you to fully penetrate her. Her womb is hot, wet and her muscles have your prick in one of the strongest grips imaginable. Even if you went totally limp, withdrawal would be an impossibility. Wincing at the sudden crushing force of her vaginal muscles, the succubus giggles inhumanly.\n\n", false);
			
			outputText("\"<i>Quit whimpering,</i>\" the Succubus orders. \"<i>I hope the rumors about you futas are true. I need a good, fiery load of cum to get me going. I haven't had one in a while and as much as I LOVE men, they can only feed me so much.</i>\"\n\n", false);
			
			outputText("You quickly try to struggle, but find the Succubus to be utterly dominating. She wraps her arms around your back and entwines her lean legs around your hips. The Succubus playfully licks your lips and grins.\n\n", false);
			
			outputText("\"<i>You are getting your dick milked,</i>\" the Succubus says flatly, \"<i>Accept it. Trust me, when I am done, you will want more of me, anyway.</i>\"\n\n", false);
			
			outputText("As the Succubus finishes her ultimatum, you feel churning vaginal contractions stroking your massive cock. Heavy, powerful, coordinated undulations work your dick as surely as the best handjob. You quickly moan in shock and pleasure at such rough treatment.", false);
		}
		dynStats("lus", 35);
		doNext(2026);
	}
	//Cerulean potion continued
	else if (eventNo == 2026)
	{
		outputText("", true);
		spriteSelect(8);
		if (player.gender == 1)
		{
			outputText("Your natural instincts immediately take over and you open your mouth and allow her nipple inside. Immediately, your mouth has a mind of its own as you press your head firmly into her breast and begin suckling the unnaturally long teat like a starving baby. The demon-woman laughs in satisfaction. \"<i>To think, that you believed me to do you harm!</i>\" she taunts. \"<i>Drink, little man. Feed your lust as you will soon feed mine.</i>\" Immediately, you feel her milk flood your mouth. Its taste immediately reminds you of the potion you got from Giacomo. You realize the potion was not a potion at all, but this demon's breast milk! Concerned only for your blind libido, the suction of your mouth coaxes torrents of the devil's fluid into your mouth and down your throat. She continues teasing your cock only enough to maintain your erection. In time, your stomach signals that you are full and you break the seal from her tit, making a loud 'pop'.   She briefly hoses you down with milk, soaking you.\n\n", true);
			outputText("The demon has a satisfied look on her face. \"<i>Did I taste good? Was I wholesome and fulfilling?</i>\" she asks. \"<i>Since you have fed from my life-milk, it is only fair that I do the same. To be fair, 'yes', I am as fierce as I look and I will leave you sore and insensible. However, I do so to pleasure you and feed myself. Accept it and be happy.</i>\" She gives you another inhumanly toothy grin and kisses you deeply. A small pang of fear still shoots through you as you feel the sharpness of her teeth. She breaks away from your lips and sighs in excitement. \"<i>Now, I FEED!</i>\" she utters jubilantly.", false);
		}
		else
		{
			outputText("\"<i>See,</i>\" the Succubus says triumphantly, \"<i>You are already enjoying it. You don't even have to hump. My cunt does all the work. Try THAT with a human woman. Good fucking luck. Half of them don't even know how to keep a prick hard once it's inside them and then they bitch because THEY didn't cum.</i>\"\n\n", false);
			
			outputText("The fierce milking continues for several minutes until you reflexively buck your hips as your inner organs fill with the white, milky life-water the demoness demands in order to slake her thirst. Quick to take notice of your muscular reaction, the succubus snickers.\n\n", false);
			
			outputText("\"<i>Ready to burst, are you?</i>\" the Succubus playfully challenges. \"<i>Well, then. No reason for you to hold back.</i>\"", false);
		}
		dynStats("tou", .3, "lib", .5, "sen", .5, "lus", 5, "cor", 1);
		doNext(2027);
	}
	//Cerulean potion continued
	else if (eventNo == 2027)
	{
		outputText("", true);
		spriteSelect(8);
		if (player.gender == 1)
		{
			outputText("Rotating herself into a 69 position, she seizes your throbbing member and effortlessly begins deep throating. Her thighs wrap around your head and confront you with her surprisingly hairy pussy. Her clitoris is long and erect, begging for attention and the smell of her pheromones enslaves you. You bury your face into her furry mound, ignoring your normal revulsion to such an unshaved state and begin eating her as well as any woman you have ever pleased. The demon takes your cock out of her mouth to cry in delight. \"<i>YES, LITTLE MAN!</i>\" she screams. \"<i>LICK ME! TEASE ME! LOVE MY WOMB WITH YOUR TONGUE!!!!</i>\" She responds by clamping her mouth around the head of your penis and sucking smartly. A sharp pain in your ass signals the entry of her bony fingers working their way to your inner manhood. Finding the root of your sex easily, she mashes down to force you to cum.\n\n", true);
			outputText("Finding it impossible to resist such pleasure, you immediately begin cumming. Glob after glob, stream after stream of your semen shoots into the woman's mouth. Her timed sucking ensures that she swallows each drop as you launch it into her. While you have been proud of the ability to cum in a woman for over a minute, you are wracked with both pain and pleasure as your ejaculations continue for almost ten. Once you have spent your last, the demon releases your penis to bear down on your face with her thighs and unloads a massive squirting orgasm. Your face is soaked with pussy juice as you see her cunt spasm from the force of her pleasure. The sight of her rhythmic muscles is hypnotic. She then promptly removes her finger from your ass.", false);
		}
		else
		{
			outputText("The Succubus rears up and pins your shoulders firmly to the ground. The speed of her vaginal contractions becomes impossibly fast. As you look down at the Succubus' crotch, you can clearly see her contractions working your penis despite the massive growth of fur between your legs. The pressure deep behind your cock is crushing. With one last spasmodic push, you release a thick, superhuman gout of semen deep in the Succubus' cunt. She lets out an inhuman howl of pleasure as her womb clamps down upon you like a vise.  She literally squeezes each stream and drop of cum out of you.\n\n", false);
			
			outputText("After a couple of minutes, you feel your dick weaken and begin going limp. Satisfied, you feel the Succubus' grip on your prick release and you quickly fall out of her womb. Much to your surprise, despite the massive load you released, not a single drop of cum falls out or is left on your prick. The Succubus begins rubbing herself all over, clearly in post-orgasmic ecstasy from absorbing your fluids. After a couple of chain-orgasms, the Succubus sits down next to the empty jar.\n\n", false);
			
			outputText("She places the mouth of the jar next to one of her fat nipples and begins milking her tit into the jar, filling it back up with her fluids. She places the jar next to you and stands up.\n\n", false);
			
			outputText("\"<i>It has been a long time since I soaked up a load that good,</i>\" she says, \"<i>Anytime you want more of that, just drink my milk again. It's only fair. I take your milk, you take mine.</i>\"\n\n", false);
			
			outputText("She smiles and flies off, leaving you with a fresh bottle of \"Cerulean Potion\". As pleasing as the experience was, it has left you thoroughly exhausted.", false);
				//[Mechanics: Corruption increase same as male counterpart. No hit point recover for that night. When fatigue model is implemented, no fatigue recovery and add 25 points]
		}
		fatigue(20);
		dynStats("lib", .5, "lus=", 0);
		doNext(2028);
	}
	//Succubi 
	else if (eventNo == 2028)
	{
		outputText("", true);
		spriteSelect(8);
		if (player.gender == 1)
		{
			outputText("She stands up and helps you to your feet. While dazed, ", true);
			if (player.tallness < 80)
				outputText("you see that she towers over you. She must stand well over seven feet in height. ", false);
			if (player.tallness >= 80 && player.tallness < 90)
				outputText("you see she is about as tall as you - around seven feet in height. ", false);
			if (player.tallness >= 90)
				outputText("you see she's definitely shorter than you, only about seven feet tall. ", false);
			outputText("She braces you against a tree and picks up the empty potion bottle. Grabbing the tit you ignored during the unholy tryst, she pokes her nipple into the bottle and squeezes for about a minute. Satisfied, she corks the bottle and hands it to you. She begins licking her nectar off your face. \"<i>You have pleased me, little man,</i>\" she coos. \"<i>It is a rare thing indeed for one of my meals to pleasure me so. If you ever desire for me again, all you need is to drink my milk. I will appear forthwith to let you suckle me and I will suckle you! We will feed each other and grow stronger for the effort!</i>\" ", false);
			outputText(" She gives a giggle and disappears before your eyes. At that moment the fatigue from the massive fucking you received catches up with you and you pass out in a slump.", false);
			dynStats("str", .5,"lus", 4);
		}
		inventory.takeItem(consumables.CERUL_P);
	}
	//Dangerous Plants Pitch
	else if (eventNo == 2029)
	{
		spriteSelect(23);
		if (player.hasKeyItem("Dangerous Plants") >= 0)
		{
			outputText("<b>You already own the book 'Dangerous Plants'.</b>", true);
			doNext(2017);
			return;
		}
		outputText("Giacomo proudly holds up a small text. The cover is plain and unadorned with artwork. \"<i>According to the scholars,</i>\" Giacomo begins, \"<i>knowledge is power. It is one of the few things that scholars say that I agree with. You cannot survive in today's world without knowing something of it. Beasts and men are not your only problems. This book specializes in the dangerous plants of the realm.  There exists flora the likes of which will chew you up and spit you out faster than any pack of wolves or gang of thieves. For the small price of 10 gems, you can benefit from this fine book on the nastiest blossoms in existence. Care to broaden your learning?</i>\"", true);
		doYesNo(2030, 2017);
	}
	//Dangerous Plants Purchase
	else if (eventNo == 2030)
	{
		spriteSelect(23);
		if (player.hasKeyItem("Dangerous Plants") >= 0)
		{
			outputText("<b>You already own the Book 'Dangerous Plants'.</b>", true);
			doNext(2017);
			return;
		}
		if (player.gems < 10)
		{
			outputText("\n\nGiacomo sighs, indicating you need " + String(10 - player.gems) + " more gems to purchase this item.", true);
			doNext(2017);
		}
		else
		{
			outputText("You consider yourself fortunate to be quite literate in this day and age. It certainly comes in handy with this book. Obviously written by well-informed, but women-starved men, the narrative drearily states the various types of poisonous and carnivorous plants in the world. One entry that really grabs you is the chapter on 'Violation Plants'. The chapter drones on about an entire classification of specially bred plants whose purpose is to torture or feed off a human being without permanently injuring and killing them. Most of these plants attempt to try breeding with humans and are insensitive to the intricacies of human reproduction to be of any value, save giving the person no end of hell. These plants range from massive shambling horrors to small plant-animal hybrids that attach themselves to people. As you finish the book, you cannot help but shiver at the many unnatural types of plants out there and wonder what sick bastard created such monstrosities. ", true);
			doNext(2017);
			player.gems -= 10;
			player.createKeyItem("Dangerous Plants", 0, 0, 0, 0);
			statScreenRefresh();
		}
	}
	//Traveler's Guide - Pitch
	else if (eventNo == 2031)
	{
		spriteSelect(23);
		if (player.hasKeyItem("Traveler's Guide") >= 0)
		{
			outputText("<b>You already own the book 'Traveler's Guide'.</b>", true);
			doNext(2017);
			return;
		}
		outputText("Giacomo holds up a humble pamphlet. \"<i>While you may not find value in this as a seasoned traveler,</i>\", Giacomo opens, \"<i>you never know what you may learn from this handy, dandy information packet! Geared to the novice, this piece of work emphasizes the necessary items and some good rules of thumb for going out into the world. You may not need it, but you may know someone who does. Why waste your time when the answers could be in this handy pamphlet! I will offer the super-cheap price of 1 gem!</i>\"", true);
		doYesNo(2032, 2017);
	}
	//Traveler's Guide Sale
	else if (eventNo == 2032)
	{
		spriteSelect(23);
		if (player.hasKeyItem("Traveler's Guide") >= 0)
		{
			outputText("<b>You already own the book 'Traveler's Guide'.</b>", true);
			doNext(2017);
			return;
		}
		if (player.gems < 1)
		{
			outputText("\n\nGiacomo sighs, indicating you need 1 gem to purchase this item.", true);
			doNext(2017);
		}
		else
		{
			outputText("The crazy merchant said you might not need this and he was right. Written at a simple level, this was obviously intended for a city-dweller who never left the confines of their walls. Littered with childish illustrations and silly phrases, the book is informative in the sense that it does tell a person what they need and what to do, but naively downplays the dangers of the forest and from bandits. Were it not so cheap, you would be pissed at the merchant. However, he is right in the fact that giving this to some idiot ignorant of the dangers of the road saves time from having to answer a bunch of stupid questions.", true);
			doNext(2017);
			player.gems -= 1;
			player.createKeyItem("Traveler's Guide", 0, 0, 0, 0);
			statScreenRefresh();
		}
	}
	//Hentai Comic Pitch
	else if (eventNo == 2033)
	{
		spriteSelect(23);
		if (player.hasKeyItem("Hentai Comic") >= 0)
		{
			outputText("<b>You already own a Hentai Comic!</b>", true);
			doNext(2017);
			return;
		}
		outputText("Giacomo takes out a colorfully written magazine from his bag. The cover contains well-drawn, overly-endowed women in sexual poses. \"<i>Perhaps your taste in reading is a bit more primal, my good ", true);
		if (player.gender == 1)
			outputText("man", false);
		if (player.gender == 2 || player.gender == 3)
			outputText("lady", false);
		if (player.gender == 0)
			outputText("...err, whatever you are", false);
		outputText("</i>,\" says Giacomo. \"<i>Taken from the lands far to the east, this is a tawdry tale of a group of ladies seeking out endless pleasures.  With a half a dozen pictures on every page to illustrate their peccadilloes, you will have your passions inflamed and wish to join these fantasy vixens in their adventures! Collectable and in high demand, and even if this is not to your tastes, you can easily turn a profit on it! Care to adventure into the realm of fantasy? It's only 10 gems and I am doing YOU a favor for such a price.</i>\"", false);
		doYesNo(2034, 2017);
	}
	//Hentai Comic Sale
	else if (eventNo == 2034)
	{
		spriteSelect(23);
		if (player.hasKeyItem("Hentai Comic") >= 0)
		{
			outputText("<b>You already own a Hentai Comic!</b>", true);
			doNext(2017);
			return;
		}
		if (player.gems < 10)
		{
			outputText("\n\nGiacomo sighs, indicating you need " + String(10 - player.gems) + " more gems to purchase this item.", true);
			doNext(2017);
		}
		else
		{
			outputText("You peruse the erotic book. The story is one of a group of sisters who are all impossibly heavy-chested and equally horny getting into constant misadventures trying to satisfy their lust. While the comic was entertaining and erotic to the highest degree, you cannot help but laugh at how over-the-top the story and all of the characters are. Were the world as it was in the book, nothing would get done as humanity would be fucking like jackrabbits in heat for the rest of their lives. While certainly a tempting proposition, everyone gets worn out sometime. You place the book in your sack, well entertained and with a head filled with wilder perversions than what you woke up with this morning.", true);
			doNext(2017);
			player.gems -= 10;
			player.createKeyItem("Hentai Comic", 0, 0, 0, 0);
			statScreenRefresh();
		}
	}
	//Dildo Sales Pitch
	else if (eventNo == 2035)
	{
		spriteSelect(23);
		if (player.hasKeyItem("Dildo") >= 0)
		{
			outputText("<b>You already own a Dildo!</b>", true);
			doNext(2018);
			return;
		}
		outputText("Giacomo takes out a slender tube roughly over half a foot in length. \"<i>Since you seek pleasure, this is as simple and effective as it gets. This dildo is a healthy seven inches long and is suitable for most women and even adventurous men. Pick a hole, stick it in and work it to your heart's content or your partner's pleasure. The single-piece construction makes it solid, sturdy and straightforward. For 20 gems, you can take matters into your own hands. How about it?</i>\"", true);
		doYesNo(2036, 2018);
	}
	//Buy Dildo
	else if (eventNo == 2036)
	{
		spriteSelect(23);
		if (player.gems < 20)
		{
			outputText("\n\nGiacomo sighs, indicating you need " + String(20 - player.gems) + " more gems to purchase this item.", true);
			doNext(2018);
		}
		else
		{
			outputText("After making the payment, Giacomo hands you the Dildo", true);
			doNext(2018);
			player.gems -= 20;
			player.createKeyItem("Dildo", 0, 0, 0, 0);
			statScreenRefresh();
		}
	} //Self Stimulation Belt Sales Pitch
	else if (eventNo == 2037)
	{
		spriteSelect(23);
		if (player.hasKeyItem("Self-Stimulation Belt") >= 0)
		{
			outputText("<b>You already own a Self-Stimulation Belt!</b>", true);
			doNext(2018);
			return;
		}
		outputText("Giacomo holds up what appears to be a chastity belt. However, this device has a dildo attached to the inside. There is a small gearbox on the outside and a wind-up key is tethered to it. The crazed merchant holds the contraption up and begins his liturgy. \"<i>Ah! Someone who both appreciates pleasure AND the wonders of artifice. This naughty little piece of jewelry is designed to pleasure any woman all at the push of a button! All you do is take this key, wind up the gear box...</i>\" Giacomo takes the key and inserts it into the box and winds it like a watch. He then points to a switch. \"<i>...you then press this button and enjoy yourself!</i>\" Giacomo flips the switch and the dildo vibrates rapidly. The distinct hum from the toy and the whirring of gears stirs your imagination. Giacomo pipes up, breaking your train of thought. \"<i>This belt is not cheap, but it is most certainly worth the investment of 30 gems!</i>\"", true);
		doYesNo(2038, 2018);
	}
	//Buy Self-Stimulation Belt
	else if (eventNo == 2038)
	{
		spriteSelect(23);
		if (player.gems < 30)
		{
			outputText("\n\nGiacomo sighs, indicating you need " + String(30 - player.gems) + " more gems to purchase this item.", true);
			doNext(2018);
			return;
		}
		outputText("After making the payment, Giacomo hands you the Self-Stimulation Belt", true);
		player.createKeyItem("Self-Stimulation Belt", 0, 0, 0, 0);
		doNext(2018);
		player.gems -= 30;
		statScreenRefresh();
	}
	//Natural SelfStim Belt Sales Pitch
	else if (eventNo == 2039)
	{
		spriteSelect(23);
		if (player.hasKeyItem("All-Natural Self-Stimulation Belt") >= 0)
		{
			outputText("<b>You already own an All-Natural Self-Stimulation Belt!</b>", true);
			doNext(2018);
			return;
		}
		outputText("The merchant places his bag on the ground. He reaches into one of his purses and pulls out a pair of gloves. After putting them on, he reaches into his bag and pulls out what appears to be a chastity belt. The device has a clearly organic look to it. In the center of the front cover is a nodule. You have heard of similar devices. They normally have a dildo attached to them to pleasure women. ", true);
		outputText("\"<i>This device is quite intriguing,</i>\" Giacomo begins, \"<i>This pleasure engine is NOT for the faint-of-heart. Being constructed of materials from the workshops of biomechanical artificers, this device outperforms its mechanical cousin in every way. Guaranteed to last longer than you do, this machine will give you as many mind-shattering orgasms as you can handle. Unlike the mechanical belt, you do not need to wind it up. It soaks up the power of the sun itself in an amazing feat of engineering. Four hours a day is all it needs! Keep in mind that if there is no sun for a couple of days, it will not work without a full day's sunshine. You may wonder why I am wearing gloves. Well, that is because of the pads on the belt.</i>\" Giacomo points to a couple of small, amber pads on the belt. \"<i>They are sensitive to human touch and activate the belt. This is all yours for 40 gems and you get the gloves for free! Again, this device offers ultimate pleasure. If you can't handle it, I will not be offended if you turn it down.</i>\"", false);
		if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte > 39)
		{
			outputText("\n\nThe nodule and the base of the stimulator look vaguely like some of the things you have seen in the Dangerous Plant book. You wonder if there is not something devious about this item. Giacomo is also sweating. It is too cool for that, this time of year.", false);
		}
		else
		{
			if (player.inte > 29)
			{
				outputText("\n\nYou notice a change in Giacomo's attitude. He REALLY wants to sell you this sex toy. Something this exotic should cost much more than what he is offering.", false);
			}
		}
		outputText("\n\nDo you buy the All-Natural Self-Stimulation Belt?", false);
		doYesNo(2040, 2018);
	}
	//Buy all natural SelfStimulation Belt
	else if (eventNo == 2040)
	{
		spriteSelect(23);
		if (player.gems < 40)
		{
			outputText("\n\nGiacomo sighs, indicating you need " + String(40 - player.gems) + " more gems to purchase this item.", true);
			doNext(2018);
			return;
		}
		outputText("After making the payment, Giacomo hands you the All-Natural Self-Stimulation Belt", true);
		player.createKeyItem("All-Natural Self-Stimulation Belt", 0, 0, 0, 0);
		doNext(2018);
		player.gems -= 40;
		statScreenRefresh();
	}
	//Onahole Sales Pitch
	else if (eventNo == 2041)
	{
		spriteSelect(23);
		if (player.hasKeyItem("Plain Onahole") >= 0)
		{
			outputText("<b>You already own a Plain Onahole!</b>", true);
			doNext(2018);
			return;
		}
		outputText("Giacomo takes out a pink cylinder from his bag. It appears to be sealed at one end and the cap is topped with a piece of rubber that has a vertical slit. \"<i>Friend</i>,\" Giacomo starts, \"<i>when you do not want to go through all of the shit to bag a woman, this is the thing for you. It never says no, it never bitches and it never takes everything you own in a divorce. All you do is get hard, slip your cock in the slit, work it at your pace and unload. Simple is as simple does. Take the top off for easy clean up and there you go! As you can see it is portable and is much safer than risking some social disease from an errant barmaid. I have plenty of these in stock and I can let it go for 20 gems. What say you?</i>\"", true);
		doYesNo(2043, 2018);
	}
	//All-natural Self-Stim Bad End
	else if (eventNo == 2042)
	{
		spriteSelect(23);
		outputText("Whatever the belt is, whatever it does, it no longer matters to you.  The only thing you want is to feel the belt and its creature fuck the hell out of you, day and night.  You quickly don the creature again and it begins working its usual lustful magic on your insatiable little box.  An endless wave of orgasms take you.  All you now know is the endless bliss of an eternal orgasm.\n\n", true);
		outputText("Your awareness hopelessly compromised by the belt and your pleasure, you fail to notice a familiar face approach your undulating form.  It is the very person who sold you this infernal toy.  The merchant, Giacomo.\n\n", false);
		outputText("\"<i>Well, well,</i>\" Giacomo says.  \"<i>The Libertines are right.  The creature's fluids are addictive. This poor woman is a total slave to the beast!</i>\"\n\n", false);
		outputText("Giacomo contemplates the situation as you writhe in backbreaking pleasure before him.  His sharp features brighten as an idea strikes him.\n\n", false);
		outputText("\"<i>AHA!</i>\" the hawkish purveyor cries.  \"<i>I have a new product to sell!!!! I will call it the 'One Woman Show!'</i>\"\n\n", false);
		outputText("Giacomo cackles smugly at his idea.  \"<i>Who knows how much someone will pay me for a live woman who can't stop cumming!</i>\"\n\n", false);
		outputText("Giacomo loads you up onto his cart and sets off for his next sale.  You do not care.  You do not realize what has happened.  All you know is that the creature keeps cumming and it feels... sooooo GODDAMN GOOD!", false);
		eventParser(5035);
	}
	//Buy Onahole
	else if (eventNo == 2043)
	{
		spriteSelect(23);
		if (player.gems < 20)
		{
			outputText("\n\nGiacomo sighs, indicating you need " + String(20 - player.gems) + " more gems to purchase this item.", true);
			doNext(2018);
			return;
		}
		outputText("After making the payment, Giacomo hands you the Plain Onahole", true);
		player.createKeyItem("Plain Onahole", 0, 0, 0, 0);
		doNext(2018);
		player.gems -= 20;
		statScreenRefresh();
	}
	//Delux Onahole Sales Pitch
	else if (eventNo == 2044)
	{
		spriteSelect(23);
		if (player.hasKeyItem("Deluxe Onahole") >= 0)
		{
			outputText("<b>You already own a Deluxe Onahole!</b>", true);
			doNext(2018);
			return;
		}
		outputText("Giacomo holds up a weirdly shaped lump of rubber. One end is shaped and contoured like a woman's genitalia while the rest stretches out to almost a foot long. \"<i>This thing right here is excellent! While a standard onahole will get you off, this has the look and feel of the real thing! As you can see, the outside orifice looks just like a woman's privates and,</i>\" Giacomo pauses to open the inside for you to view. You see the inner folds and curves that are typical to the inside of a woman's womb, \"<i>as you can see, great care has been taken to make the inside feel as much like a real pussy as possible. You hammer your cock with this thing a few times and you may never want the real thing again! If nothing else, it won't whine about you running out the door first thing in the morning. 50 gems is more than reasonable for all of the satisfaction this will bring.</i>\"", true);
		doYesNo(2045, 2018);
	}
	//Buy Deluxe Onahole
	else if (eventNo == 2045)
	{
		spriteSelect(23);
		if (player.gems < 50)
		{
			outputText("\n\nGiacomo sighs, indicating you need " + String(50 - player.gems) + " more gems to purchase this item.", true);
			doNext(2018);
			return;
		}
		outputText("After making the payment, Giacomo hands you the Deluxe Onahole", true);
		player.createKeyItem("Deluxe Onahole", 0, 0, 0, 0);
		doNext(2018);
		player.gems -= 50;
		statScreenRefresh();
	}
	//Onahole multi-cock continuation!
	else if (eventNo == 2046)
	{
		outputText("You pull the sloppy toy from your dribbling dick and smile, shoving its slippery surface down on another of your " + multiCockDescriptLight() + ".  You rapidly work it around your cocks, orgasming until ", true);
		if (player.balls > 0)
			outputText("you pass out with aching, empty balls.", false);
		else
			outputText("you pass out with " + multiCockDescriptLight() + " sore from exertion.", false);
		dynStats("sen", -1, "lus=", 0);
		doNext(13);
	}
	//Natural Stim Belt continuation
	else if (eventNo == 2047)
	{
		outputText("In shock, you scream as you realize the nodule has instantly grown into a massive, organic dildo. It bottoms out easily and rests against your cervix as you recover from the initial shock of its penetration. As the pangs subside, the infernal appendage begins working itself. It begins undulating in long, slow strokes. It takes great care to adjust itself to fit every curve of your womb. Overwhelmed, your body begins reacting against your conscious thought and slowly thrusts your pelvis in tune to the thing.\n\n", true);
		outputText("As suddenly as it penetrated you, it shifts into a different phase of operation. It buries itself as deep as it can and begins short, rapid strokes. The toy hammers your insides faster than any man could ever hope to do. You orgasm immediately and produce successive climaxes. Your body loses what motor control it had and bucks and undulates wildly as the device pistons your cunt without end. You scream at the top of your lungs. Each yell calls to creation the depth of your pleasure and lust.\n\n", false);
		outputText("The fiendish belt shifts again. It buries itself as deep as it can go and you feel pressure against the depths of your womanhood. You feel a hot fluid spray inside you. Reflexively, you shout, \"<b>IT'S CUMMING!!!! IT'S CUMMING INSIDE ME!!!</b>\" Indeed, each push of the prodding member floods your box with juice. It cums... and cums... and cums... and cums...\n\n", false);
		outputText("An eternity passes, and your pussy is sore. It is stretched and filled completely with whatever this thing shoots for cum. It retracts itself from your hole and you feel one last pang of pressure as your body now has a chance to force out all of the spunk that it cannot handle. Ooze sprays out from the sides of the belt and leaves you in a smelly, sticky mess. You feel the belt's tension ease up as it loosens. The machine has run its course. You immediately pass out.", false);
		player.slimeFeed();
		dynStats("lib", 1, "sen", (-0.5), "lus=", 0);
		doNext(13);
	}
	//Natural Onahole Sales Pitch
	else if (eventNo == 2048)
	{
		spriteSelect(23);
		if (player.hasKeyItem("All-Natural Onahole") >= 0)
		{
			outputText("<b>You already own an All-Natural Onahole!</b>", true);
			doNext(2018);
			return;
		}
		outputText("Giacomo reaches into his bag and pulls out what looks like an oblong coconut. It is roughly seven inches in diameter. There is a distinctive opening in one end that is just large enough for an erect penis. Inside the opening you see what looks like two pink cushions. There are multiple symmetrical depressions surrounding the outside hole of the thing. Giacomo's smile fades and he takes on a much more serious attitude befitting his aquiline face. \"<i>Miss,</i>\" Giacomo states, \"<i>without sounding too bold, it is no secret that members of the third gender are capable of sexual feats that force the other two genders into jealous fits. Having bigger cocks than men, cumming more than an elephant and a pussy with the strength and coordination of a human hand, regular toys do not last long for you folk. Hence, this little beasty. I will tell you straightaway, only the third sex ", true);
		outputText("can handle this toy. The other two genders simply do not have the stamina for it. This thing is all-natural, meaning that it powers itself and is made with the Artificers' organic methods. It will cease functioning if it is not used or you fail to give the opening a few drops of this fluid once every three days.</i>\" Giacomo pauses to hold up a small bottle. He places the bottle down and continues his sales pitch, \"<i>If you plan on not using this thing regularly, do not buy it. These items are very rare and this one will probably be the only one you'll ever see. Normally I pitch my products like crazy. However, with this I do not need to. This thing DOES work too well, and you WILL cum, period. It will work you until you do not want it to work anymore. It will not stop until IT decides to stop. However, for the extreme needs of a lovely example of the dual-sex, it may be the very thing you need. Again, this is for the ultimate hardcore pleasure seeker amongst the ultimate hardcore. It costs a humble 150 gems, but for superhuman thrills, who can put a price tag on that?</i>", false);
		if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte > 35)
		{
			outputText("\n\nWhile skillfully avoiding Giacomo's suspicion, you correctly surmise that the toy is not a toy at all. It is the outer shell for a hybrid animal-plant. The creature is very much alive. While the technical name for this beast is in the usual unpronounceable scholastic gibberish, the common nickname for this is the \"All-Day Sucker\". It gets its name due to the fact that its diet consists of high nutrient fluids, especially semen. It was used both as a torture device and as a pleasure pet of the snobbish elite because it would clamp down upon the member of a person and not release until it has stimulated the person enough to ejaculate sufficiently to feed. However, the All-Day Sucker swells up like fleas and ticks do, thus requiring hours of stimulation to have its fill. There was something else about these things, but you cannot remember exactly what it was.", false);
			if (player.inte > 65)
			{
				outputText("After a moment, you remember what it was you read. Unlike many simple beasts, this creature has a male and a female gender. The creature itself is similar to a tubeworm. While the males are considered reasonably \"safe\", the females have a nasty habit of injecting its young inside the sex organs of the person using the thing, leaving the hapless person to convulse in endless, painful orgasms as the beasties wriggle around their insides until they are ready for birth. The process takes about a week and recorded victims normally make full recoveries after a period of blindingly painful orgasms as they shoot out the young. It is not a surprise to have people's hearts give out at the endless stimulation from the young. The recovery time is quite long due to the stress on the body such overwhelming stimulus would generate. Some ultra-extreme pleasure seekers actively look for these things just for this experience.\n\nHowever, the problem is there is NO WAY to tell if this is male or female by looking at it.", false);
			}
		}
		doYesNo(2049, 2018);
	}
	//Natural Onahole Purchase
	else if (eventNo == 2049)
	{
		spriteSelect(23);
		if (player.gems < 150)
		{
			outputText("\n\nGiacomo sighs, indicating you need " + String(150 - player.gems) + " more gems to purchase this item.", true);
			doNext(2018);
			return;
		}
		outputText("After making the payment, Giacomo hands you the All-Natural Onahole", true);
		player.createKeyItem("All-Natural Onahole", 0, 0, 0, 0);
		doNext(2018);
		player.gems -= 150;
		statScreenRefresh();
	}
	//Deluxe Onahole Futa continuation
	else if (eventNo == 2050)
	{
		if (player.gender == 3)
		{
			outputText("\n\nThe blessing (or curse, depending on how you feel) of your gender catches up. As with all members of your gender, you are incapable of having just ONE orgasm. You feel the muscles deep in your crotch bear down hard. Your eyes widen as you realize you are about to blow a monumental load. The pressure works its way through you and towards your cock as, with one final push, you force a torrent of semen out of your body. Your grip was not sufficient on the onahole and you launch it ", true);
			outputText(String(int(((Math.random() * player.str / 12) + player.str / 6) * 10) / 10), false);
			outputText(" feet away from you. Delirious with pleasure, you continue your 'impression' of a semen volcano, covering yourself and the area with your seed. ", false);
			outputText(" As your orgasms fade, you find yourself a well-fucked mess, and pass out.", false);
			dynStats("sen", -1, "lus=", 0);
		}
		doNext(1);
	}
	//You fight the bee!
	else if (eventNo == 2060)
	{
		outputText("You clear your head and resolve to defeat the monstrous bee-woman.", true);
		spriteSelect(6);
		startCombat(new BeeGirl());
	}
	//Do you help the wanderer?
	
	//Encounter Rathazul
	else if (eventNo == 2070)
	{
		if (player.hasStatusAffect("Camp Rathazul") >= 0)
			rathazul.campRathazul();
		else
			rathazul.encounterRathazul();
	}
	//Purify Incubi Draft
	else if (eventNo == 2071)
	{
		if (player.gems < 20)
		{
			outputText("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"", true);
			doNext(2070);
			return;
		}
		outputText("", true);
		if (!debug)
			player.destroyItems(consumables.INCUBID, 1);
		inventory.takeItem(consumables.P_DRAFT);
		player.gems -= 20;
		statScreenRefresh();
		player.addStatusValue("metRathazul", 2, 1);
	}
	//Purify Succubi Milk
	else if (eventNo == 2072)
	{
		if (player.gems < 20)
		{
			outputText("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"", true);
			doNext(2070);
			return;
		}
		outputText("", true);
		if (!debug)
			player.destroyItems(consumables.SUCMILK, 1);
		inventory.takeItem(consumables.P_S_MLK);
		player.gems -= 20;
		statScreenRefresh();
		player.addStatusValue("metRathazul", 2, 1);
	}
	//Purify Succubi's Delight
	else if (eventNo == 2073)
	{
		if (player.gems < 20)
		{
			outputText("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"", true);
			doNext(2070);
			return;
		}
		outputText("", true);
		if (!debug)
			player.destroyItems(consumables.SDELITE, 1);
		inventory.takeItem(consumables.PSDELIT);
		player.gems -= 20;
		statScreenRefresh();
		player.addStatusValue("metRathazul", 2, 1);
	}
	
	//Grab marae's boob!
	else if (eventNo == 2075)
	{
		outputText("You reach forward to cop a feel.  The goddess' eyes go wide with fury as a massive branch swings down, catching you in the sternum.  It hits you hard enough that you land in your boat and float back a few feet into the water.  Nothing to do but leave and hope for another chance at her breasts...", true);
		doNext(13);
		takeDamage(player.HP - 1);
	}
	//Run from corrupt marae
	else if (eventNo == 2078)
	{
		outputText("You turn and run for the boat, leaving the corrupt goddess behind.  High pitched laugher seems to chase you as you row away from the island.", true);
		doNext(13);
	}
	else if (eventNo == 2080)
	{
		startCombat(new TentacleBeast());
		eventParser(1);
	}
	//Remove worms
	else if (eventNo == 2081)
	{
		spriteSelect(23);
		outputText("You toss the gems at the merchant, who calmly hands you the bottle. Gulping down the liquid, your guts light up as if you swallowed fire. Pain overwhelms your body and you drop to your knees convulsing. You curse the merchant for poisoning you, yet you can only choke out gibberish through your groans. The pain quickly focuses from your stomach to your crotch as the worms inside you are clearly NOT happy with what you have done. You fall onto your back as the thrashing overwhelms you. With an unexpected climax, every worm in your body fights to escape your gonads. The fat worm that resided deep in your sex lazily pushes itself out last.\n\n", true);
		outputText("Upon seeing the fat worm, Giacomo displays a freakish celerity by jumping off his cart, grabbing an empty container and collecting the fat worm. Regaining your senses, you look at him with inquisitive shock at what he just did.\n\n", false);
		outputText("\"<i>You have to realize that I AM a merchant, after all.</i>\", he calmly replies. \"<i>Hell for you is heaven for someone else. This bugger will easily fetch 10,000 gems to some noble looking for a quick buzz. Don't WE know better!</i>\"\n\n", false);
		outputText("The merchant puts away his prize and comes back to help you up. \"<i>Here.</i>\", he says as he shoves a couple of bottles into your hand. \"<i>This is on the house. You probably need it after the shock of getting those things out.</i>\"\n\n", false);
		//Add 1 tincture of vitality to inventory
		//Infestation purged. Hit Points reduced to 10% of MAX. Corruption -20.
		if (player.HP > int(maxHP() * .15))
			player.HP = int(maxHP() * .15);
		//Maybe add a random chance of losing a random transformation with a smaller chance of losing ALL transformations except gender changes. This will probably be a bitch to implement.
		player.removeStatusAffect("infested");
		dynStats("lib", -1, "lus", -99, "cor", -4);
		player.gems -= 175;
		statScreenRefresh();
		inventory.takeItem(consumables.VITAL_T);
	}
	//Offer to remove worms #2
	else if (eventNo == 2082)
	{
		spriteSelect(23);
		outputText("\n\n\"<i>Been playing with creatures best left alone, I see</i>\", he chuckles, \"<i>Infestations of any kind are annoying, yet your plight is quite challenging given the magnitude of corrupt creatures around here. It is not the first time I have seen one infested with THOSE worms.</i>\"\n\n", false);
		outputText("You ask how he knows of your change and the merchant giggles heartily.\n\n", false);
		outputText("\"<i>Do not look at me as if I am a mystic.</i>\", Giacomo heckles lightly. \"<i>Your crotch is squirming.</i>\"\n\n", false);
		outputText("Looking down, you realize how right he is and attempt to cover yourself in embarrassment.\n\n", false);
		outputText("\"<i>Fear not!</i>\", the purveyor jingles. \"<i>I have something that will cure you of those little bastards. Of course, there is also a chance that it will purge your system in general. This potion is not cheap. I will trade it for 175 gems.</i>\"\n\n", false);
		//Broke as a joke
		if (player.gems < 175)
		{
			outputText("You realize you don't have enough gems for such a pricey potion, but perhaps there is something else in his inventory you can buy.", false);
			doNext(2015);
		}
		//Can afford
		else
		{
			outputText("Do you purchase his cure?", false);
			//Remove/No
			doYesNo(2081, 2015);
		}
		
	}
	//Jojo worm removal
	else if (eventNo == 2083)
	{
		jojoScene.jojoSprite();
		outputText("\"<i>Excellent, young one,</i>\" Jojo continues. \"<i>Your dedication to purification is admirable. Relax and know that the parasites will leave you soon.</i>\"\n\n", true);
		outputText("Jojo gets up and walks over to a backpack hidden in the bushes. He removes a lacquered box. He removes and combines a rather noxious combination of herbs, oils and other concoctions into a mortar and grinds it with a pestle. After a few minutes, he ignites the mixture and uses a feathered fan to blow the fumes over you. The smell of the mix is nauseating and repugnant. Your stomach turns and you fight the urge to vomit. Eventually, you are no longer able to resist and you purge yourself onto the ground. Cramping from your vomiting fits, you wrack with discomfort, which slowly builds to genuine pain. As the pain sets in, you feel a stirring deep in your crotch. The worms inside you are stirring and thus are compelling another unwanted orgasm. Unable to control your body, your cock explodes, launching cum and worms everywhere. Jojo begins fanning faster as he sees the worms leave your body.\n\n", false);
		outputText("\"<i>Further endurance is needed, young one,</i>\" Jojo says. \"<i>The root of your problem must leave before you may pursue further purification. Healing is always twice as uncomfortable as the illness requiring attention.</i>\"\n\n", false);
		outputText("Your body cramps up as you feel the fat worm struggle. You feel it pushing up your urethra, fighting to escape your fumigated body. The worm rapidly peeks from the end of your penis. With expedience, Jojo quickly grabs the worm and pulls it out of you, triggering one last orgasm. The monk casts the fat worm to the ground and strikes it dead with his staff.\n\n", false);
		outputText("\"<i>The culprit has been exorcised and will no longer trouble you. Rest here for a while and join me in some meditation to heal your exhausted body and soul.</i>\"\n\n", false);
		outputText("Being too tired for anything else, you join Jojo in meditation, which does much to relive you of your former woes.", false);
		//Infestation removed. HP reduced to 50% of MAX. Sensitivity reduced by -25 or reduced to 10, which ever is the smaller reduction.
		//Infestation purged. Hit Points reduced to 10% of MAX. Corruption -20.
		if (player.HP > int(maxHP() * .5))
			player.HP = int(maxHP() * .5);
		player.sens = 11;
		player.removeStatusAffect("infested");
		dynStats("sen", -1, "lus", -99, "cor", -15);
		doNext(13);
	}
	//Treeboob fun-times
	else if (eventNo == 2084)
	{
		outputText("", true);
		spriteSelect(92);
		outputText("Stepping carefully around the other hazards of the glade, you close on the strange trees with equal parts curiosity and desire.  Up close, it's easy to see the strange growths that sprout from the bark – dozens of full ripe-looking breasts, each capped with a swollen and leaking nipple.  You touch one, marveling at the smooth texture of its chocolate-colored skin.   In response a runner of sap oozes free of the nipple and slides down the curved surface.\n\n", false);
		outputText("You lean forwards and lick around the nipple's surface, sampling the sweetness of the trickling sap.   The stuff nearly overpowers you with a taste like syrupy cream as more sap drips free of the fully-erect tree-nipple.  Unable to resist testing this nonsensical oddity, you engulf the entire nipple between your lips, suckling hard.   The tree seems to oblige your efforts with a fresh discharge of the sticky sap.   Your tongue tingles and vibrates with the sinfully sweet taste in your mouth, dancing in circles around the nipple, coaxing yet more nectar from swollen plant-jug.  It's easy to lose yourself in that taste, falling into a rhythm of alternatively sucking, swallowing, and licking.\n\n", false);
		outputText("In time you realize the breast has long since been emptied by your hungry mouth, and you pull free with a pop, letting your tongue run over your now over-sensitive lips.  It seems your entire mouth has been affected by the tree's sap, and is now as sensitive and receptive as a maiden's box.  You don't think you could drink any more sap with how full you feel, and you make ready to depart this perverted place.", false);
		dynStats("sen", 1, "lus", 15, "cor", .5);
		player.slimeFeed();
		doNext(13);
		if (player.hasStatusAffect("LustyTongue") < 0)
		{
			//25% Chance of sensitive mouth status – increased lust gain/hour due to licking your lips :3
			if (rand(4) == 0)
			{
				outputText("  The feeling doesn't seem to fade, only becoming more and more intense over the coming hour.  It will be hard to keep from getting turned on any time you lick your lips or eat some food.", false);
				player.createStatusAffect("LustyTongue", 24, 0, 0, 0);
			}
			//ELSE
			else
				outputText("  Thankfully, the feeling goes away after a few minutes, leaving you feeling just a bit more sensitive.", false);
		}
		//50% Chance of breast-growth
		if (rand(2) == 0)
		{
			if (player.biggestTitSize() > 5)
			{
				outputText("  As you redress, you feel a sense of added weight on your chest.  After a few moments you realize your already-formidable chest has grown even larger.", false);
				player.growTits(1, 1 + rand(3), false, 1);
				
			}
			else
			{
				//No tits yet
				if (player.biggestTitSize() == 0)
				{
					outputText("  As you redress, you realize you have grown a pair of luscious breasts!  Perhaps this was a good idea after all...", false);
					player.growTits(1, 2 + rand(3), false, 1);
				}
				else //Small tits growth
				{
					outputText("  As you redress, you realize your breasts have gotten quite a bit larger!  Maybe you can come back later when you aren't so full and plump them up a bit more.", false);
					player.growTits(1, 1 + rand(3), false, 1);
				}
			}
		}
	}
	//MARBLE SHIT STARTS HERE
	else if (eventNo == 2112)
	{
		outputText("", true);
		marbleScene.marbleSex2Continued(1);
		doNext(13);
	}
	else if (eventNo == 2113)
	{
		outputText("", true);
		marbleScene.marbleSex2Continued(2);
		doNext(13);
	}
	else if (eventNo == 2124)
	{
		outputText("Rathazul smiles happily back at you and begins packing up his equipment.  He mutters over his shoulder, \"<i>It will take me a while to get my equipment moved over, but you head on back and I'll see you within the hour.  Oh my, yes.</i>\"\n\nHe has the look of someone experiencing hope for the first time in a long time.", true);
		player.createStatusAffect("Camp Rathazul", 0, 0, 0, 0);
		doNext(13);
	}
	else if (eventNo == 2125)
	{
		outputText("Rathazul wheezes out a sigh, and nods.\n\n\"<i>Perhaps I'll still be of some use out here after all,</i>\" he mutters as he packs up his camp and prepares to head to another spot along the lake.", true);
		doNext(13);
	}
	else if (eventNo == 2128)
	{
		var ttemp2:Function = null;
		var ttemp3:Function = null;
		var ttemp4:Function = null;
		var ttemp5:Function = null;
		var ttemp6:Function = null;
		var ttemp7:Function = null;
		if (player.hasPerk("Marble's Milk") >= 0 && player.hasItem(consumables.LACTAID, 1))
			ttemp2 = marbleScene.giveMarbleLactaid;
		if (player.hasItem(consumables.P_DRAFT, 1) && flags[kFLAGS.MARBLE_DICK_TYPE] == 0)
			ttemp4 = marbleScene.MarbleDigsDraftsYo;
		if (flags[kFLAGS.MARBLE_DICK_TYPE] > 0)
		{
			if (player.hasItem(consumables.PINKEGG, 1))
				ttemp5 = marbleScene.MarblepinkEgg;
			if (player.hasItem(consumables.L_PNKEG, 1))
				ttemp6 = marbleScene.MarbleLPinkEgg;
		}
		if (flags[kFLAGS.MARBLE_BOVA_LEVEL] < 2 && player.hasItem(consumables.PROBOVA, 1))
			ttemp7 = marbleScene.giveMarbleTheProBovas4Sho;
		if (player.hasItem(consumables.OVIELIX, 1))
			ttemp3 = marbleScene.marbleOvulatesLikeMadDawg;
		outputText("What item do you want to give Marble?", true);
		choices("Lactaid", ttemp2, "OviElixir", ttemp3, "P.Incub Dr", ttemp4, "Pink Egg", ttemp5, "L.Pink Egg", ttemp6, "Pro Bova", ttemp7, "", 0, "", 0, "", 0, "Back", marbleScene.interactWithMarbleAtCamp);
	}
	else if (eventNo == 2134)
	{
		doNext(1);
		jojoScene.jojoSprite();
		jojoScene.jojoMutationOfferYes();
	}
	else if (eventNo == 2135)
	{
		doNext(1);
		jojoScene.jojoSprite();
		jojoScene.jojoMutationOfferNo();
	}
	else if (eventNo == 2136)
	{
		doNext(1);
		jojoScene.jojoSprite();
		jojoScene.mutateJojo();
	}
	else if (eventNo == 2137)
	{
		doNext(1);
		jojoScene.jojoSprite();
		jojoScene.useTentacleJojo();
	}
	else if (eventNo == 2138)
	{
		jojoScene.jojoSprite();
		masturbateJojo();
	}
	else if (eventNo == 2142)
	{
		outputText("", true);
		spriteSelect(23);
		outputText("Giacomo smiles widely as you look through his wares seeing a strange looking device sitting there. \"<i>Ahh, I see you have spotted our latest piece of equipment. Members of the third gender had a hard time finding enough pleasure to suit their special needs. With this little device, you will never have to worry about satisfying your needs ever again.</i>\" He grins widely at you. \"<i>The deluxe dual belt will have you shaking in the throes of orgasm hours after a simple stim belt would leave you dry. You will cum in this thing, and it will leave you running back to it anytime you need sexual gratification. Everything else may as well be sandpaper on your skin. Simply flick this switch here on the side to start it up and send yourself to heaven. And you can have it for the low price of 50 gems.</i>\" He smiles again at you. \"<i>So, shall I hand it over to you?</i>\" he asks.", false);
		doYesNo(2143, 2018);
	}
	else if (eventNo == 2143)
	{
		spriteSelect(23);
		if (player.hasKeyItem("Dual Belt") >= 0)
		{
			outputText("<b>You already own a dual belt!</b>", true);
			doNext(2018);
			return;
		}
		if (player.gems < 50)
		{
			outputText("You do not have enough gems to purchase this item.", true);
			doNext(2018);
			return;
		}
		outputText("You are a bit dubious at the pleasure it could offer you, but it would be better than being raped by the creatures constantly... maybe to even work out some excess lusts... hesitantly, you reach into your bag and grab 50 gems, handing it to him. He greedily snatches it from your palm and hands you with the belt with a smile. \"<i>I promise you won't be disappointed.</i>\" He counts the gems and waves goodbye.\n\n(<b>Dual Belt acquired!</b>)", true);
		player.createKeyItem("Dual Belt", 0, 0, 0, 0);
		player.gems -= 50;
		statScreenRefresh();
		doNext(2018);
	}
	else if (eventNo == 2144)
	{
		outputText("", true);
		outputText("You look at the thing in front of you and sigh, your " + multiCockDescriptLight() + " and " + vaginaDescript(0) + " dripping with fluids. With a nervous sigh you step into the underwear looking device and slip it up your legs, the cold metal feeling so good on your " + player.skinDesc + ", sending a rush of feelings up your body. You slip your " + cockDescript(0) + " down and into a hole on the front of the belt, the extra length sticking out on the other side of it. Underneath the hole and right above your pussy is another metal square with what feels like a small nub on the inside rubbing against your clit. Shivering from the feeling of it, you stay there for a moment, waiting in anticipation. Finally, you reach down to the side of the belt and flick the switch to the on position.\n\n", false);
		outputText("The belt whirs to life, shaking on your waist, sending jolts of pleasure through your clit as the small inside nub hits it. \"<i>Ohh...</i>\" Suddenly, the ring around you cock vibrates and then tightens hard around your cock, the belt sinking onto your body and locking in place. Worry sets in instantly as you try to wiggle and take it off, but it is no use. You see something black bubble from the edges of the metal, worried even more that it might be some sort of acid. It begins to creep across your skin at a disturbing rate, going down your " + player.legs() + " and encasing them in the blackness, wrapping your cock, ", false);
		if (player.tailType > TAIL_TYPE_NONE)
			outputText("covering up your tail, ", false);
		outputText("and then going up your body, covering your " + allBreastsDescript() + " and neck. The only part of your body unclad by the suit is your head. The blackness feels slick and smooth, almost cold, a strange type of feeling washes over you until your realize that it is a rubber suit.\n\n", false);
		outputText("Before you can do anything else, the belt activates again and the latex covering of your " + cockDescript(0) + " begins to tighten and pulse around the meat, warming up to feel like a virgin cunt. A moan is dragged from your lips as it begins to ripple and pulse, simulating the feeling of fucking a tight hole as the entire suit molds itself to your body. Before you can get too used to the feeling of the suit milking your cock, the nub that had been teasing your clit suddenly expands and pushes out, the slick feeling of the latex pushing into your pussy.  The hardened black latex splits your tunnel and spreads you wide as it goes in deep. Your eyes widen for a moment as both stop, and then your world explodes in a flash of pleasure. The hardened lump begins to piston in and out of your " + vaginaDescript(0) + ", vibrating wildly as a lump grows in on top in precisely the right spot to rub back and forth on your g-spot.\n\n", false);
		outputText("Meanwhile the latex around your " + cockDescript(0) + " begins to pulse and ripple faster than ever before. You quake and quiver, " + player.legs() + " giving out at it teases and pulses around you " + allBreastsDescript() + ". Your hands hopelessly go down your body and start stroking at your encased cock, rubbing up and down your length. Unfortunately, all things must come to an end as the pleasure gets to be way too much and you feel yourself cum. Your hips buck wildly as you feel cum spurt into the latex, the end swelling up and filling like a ", false);
		if (player.cumQ() > 200)
			outputText("massive ", false);
		outputText("balloon. ", false);
		if (player.cumQ() >= 1000)
			outputText("It grows larger and larger until you are sure it will pop, but it doesn't.  It just sloshes around - a huge bubble, nearly waist high. ", false);
		outputText("Your eyes close in shivered ecstasy as your cunt spasms and clutches down around the hardened section deep inside of you. ", false);
		//([If high lactation]
		if (player.biggestLactation() >= 2)
			outputText("Milk gushes out from your " + breastDescript(0) + " as you orgasm, filling the inside of the suit with a slick layer of milk and forming milk bubbles that hang lewdly off your chest. ", false);
		outputText("However, the suit is far from over as it keeps up all of its actions, keeping you on an orgasmic plateau, making sure you never stop coming. Your hands fall to the side and your body falls down, unable to keep it up as your consciousness fades, suit still filling with all your fluids.\n\n", false);
		outputText("When you wake, the black latex is no longer covering your body and the belt is silent around your waist. Cum drips from the tip of your cock and the top part of your " + player.legs() + " are coated with your feminine juices. ", false);
		if (player.biggestLactation() >= 2)
			outputText("Thin streams of creamy milk flow from your " + allBreastsDescript() + ", your torso and midsection dripping wet from the stuff. ", false);
		outputText("Completely sated, you take off the belt, finding it slides off easily, and put it away in your campsite, eagerly awaiting the time you can next use it and have the suit work you over once more.", false);
		dynStats("sen", -1, "lus", -300);
		if (player.lib < 30)
			dynStats("lib", .5);
		if (player.lib < 50)
			dynStats("lib", .5);
		if (player.lib < 60)
			dynStats("lib", .5);
		doNext(13);
		if (player.sens > 40)
			player.sens -= 1;
		if (player.sens > 60)
			player.sens -= 1;
		if (player.sens > 80)
			player.sens -= 1;
		if (player.tou > 50)
			dynStats("tou", -1);
		if (player.tou > 75)
			dynStats("tou", -1);
	}
	//Purify LaBova Draft
	else if (eventNo == 2145)
	{
		if (player.gems < 20)
		{
			outputText("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"", true);
			doNext(2070);
			return;
		}
		outputText("", true);
		if (!debug)
			player.destroyItems(consumables.LABOVA_, 1);
		inventory.takeItem(consumables.P_LBOVA);
		player.gems -= 20;
		statScreenRefresh();
		player.addStatusValue("metRathazul", 2, 1);
	}
	
	//Move Jojo into camp
	else if (eventNo == 2149)
	{
		jojoScene.jojoSprite();
		if (player.hasStatusAffect("Ever Raped Jojo") >= 0 || flags[kFLAGS.JOJO_MOVE_IN_DISABLED] == 1)
		{
			outputText("You offer Jojo the chance to stay at your camp, but before you can finish your sentance he shakes his head 'no' and stalks off into the woods, remembering.", false);
			doNext(13);
			return;
		}
		outputText("You offer Jojo the chance to stay at your camp.  He cocks his head to the side and thinks, stroking his mousey whiskers.\n\n\"<i>Yes, it would be wise.   We would be safer together, and if you like I could keep watch at night to keep some of the creatures away.  I'll gather my things and be right there!</i>\"\n\nJojo scurries into the bushes, disappearing in a flash.  Knowing him, he'll be at camp before you!", true);
		player.createStatusAffect("PureCampJojo", 0, 0, 0, 0);
		doNext(13);
	}
	//Jojo in camp
	else if (eventNo == 2150)
	{
		jojoScene.jojoSprite();
		//Amily meets Jojo:
		if (flags[kFLAGS.AMILY_MET_PURE_JOJO] == 0 && flags[kFLAGS.AMILY_FOLLOWER] == 1 && amilyScene.amilyFollower())
		{
			followerInteractions.amilyMeetsPureJojo();
			return;
		}
		//Rathazul & Jojo
		if (flags[kFLAGS.JOJO_RATHAZUL_INTERACTION_COUNTER] == 1 && rand(2) == 0)
		{
			followerInteractions.catchRathazulNapping();
			return;
		}
		var jojoDefense:String = "N.Watch:";
		var jojoRapeFuncNum:Number = 0;
		outputText("You find Jojo sitting cross-legged on a flat rock with his staff leaning against his shoulder, thinking.  He looks to you and nods, \"<i>Greetings, " + player.short + ".  Is there something I could do to assist you?</i>\"\n\n", true);
		if (player.hasStatusAffect("JojoNightWatch") >= 0)
		{
			jojoDefense += "On";
			outputText("(Jojo is currently watching for enemies at night.)\n\n", false);
		}
		else
			jojoDefense += "Off";
		if (player.lust >= 33 && player.gender > 0)
			jojoRapeFuncNum = 2153;
		//Menu with worm purge
		if (player.hasStatusAffect("infested") >= 0)
		{
			outputText("As you approach the serene monk, you see his nose twitch.\n\n", false);
			outputText("\"<i>It seems that the agents of corruption have taken residence within the temple that is your body,</i>\" Jojo says flatly, \"<i>This is a most unfortunate development. There is no reason to despair as there are always ways to fight the corruption. However, great effort will be needed to combat this form of corruption and may have a lasting impact upon you. If you are ready, we can purge your being of the rogue creatures of lust.</i>\"\n\n", false);
			simpleChoices("Meditate", 2151, jojoDefense, 2152, "Purge", 2083, "Rape", jojoRapeFuncNum, "Leave", 74);
		}
		//normal menu
		else
			simpleChoices("Meditate", 2151, jojoDefense, 2152, "", 0, "Rape", jojoRapeFuncNum, "Leave", 74);
	}
	//New meditate
	else if (eventNo == 2151)
	{
		jojoScene.jojoSprite();
		if (player.statusAffectv1("Meditated") > 0)
		{
			outputText("Jojo smiles and meditates with you.  The experience is calming, but it's so soon after your last session that you don't get much benefit from it.", true);
			if (player.lust > 40)
				dynStats("lus", -10);
			doNext(13);
			return;
		}
		outputText("The mouse monk leads you to a quiet spot away from the portal and the two of you sit down, him cross-legged and you mimicing to the best of your ability, back to back.  You close your eyes and meditate for half-an hour, centering your body and mind.  Afterwards, he guides you through stretches and exercises to help keep your bodies fit and healthy.\n\nWhen you are done, Jojo nods to you, and climbs back onto his rock, still thinking.", true);
		//OLD STAT LINE - dynStats("str", .25,"tou", .25, "spe", .25, "int", .25, "lib", -1, "lus", -10, "cor", -2);
		//Reduces lust
		dynStats("lus", -30);
		//Corruption reduction - faster at high corruption
		if (player.cor > 80)
			dynStats("cor", -1);
		if (player.cor > 60)
			dynStats("cor", -1);
		if (player.cor > 40)
			dynStats("cor", -1);
		dynStats("cor", -2);
		//Str boost to 45
		if (player.str < 45)
			dynStats("str", 1);
		//Tou boost to 45
		if (player.tou < 45)
			dynStats("tou", 1);
		//Speed boost to 75
		if (player.spe < 75)
			dynStats("spe", 1);
		//Int boost to 80
		if (player.inte < 80)
			dynStats("int", 1);
		//Libido lower to 15
		if (player.lib > 15)
			dynStats("lib", -1);
		doNext(13);
		player.createStatusAffect("Meditated", 1, 0, 0, 0);
	}
	//Jojo defense toggle
	else if (eventNo == 2152)
	{
		jojoScene.jojoSprite();
		clearOutput();
		if (player.hasStatusAffect("JojoNightWatch") >= 0)
		{
			player.removeStatusAffect("JojoNightWatch");
			outputText("You tell Jojo that you no longer need him to watch the camp at night.  He nods, then speaks.  \"<i>Alright.  Please let me know if you require my help again.</i>\"");
		}
		else
		{
			player.createStatusAffect("JojoNightWatch", 0, 0, 0, 0);
			outputText("You ask the monk if he could guard the camp for you at night.  He smiles politely.  \"<i>Certainly, [name].</i>\"");
		}
		doNext(2150);
	}
	//Take Jojo out and rape
	else if (eventNo == 2153)
	{
		jojoScene.jojoSprite();
		player.removeStatusAffect("JojoNightWatch");
		player.removeStatusAffect("PureCampJojo");
		outputText("You ask Jojo if he'd like to go on a hunt through the woods to clear out some of the corrupted creatures, and the mouse readily agrees.  He asks if you've been getting a bit stir-crazy from having your camp in one place as the two of you walk into the woods...", true);
		doNext(jojoScene.jojoRape);
	}
	//Rathazul Armor Crafting
	else if (eventNo == 2180)
	{
		doNext(13);
		rathazul.craftCarapace();
	}
	
	//Buy breast-milker from whitney
	else if (eventNo == 2182)
	{
		//[YES] 
		outputText("Whitney takes the gems and leaves with the promise of having your gear set up within the hour.  She calls back over her shoulder with a cryptic warning, \"<i>Watch how much time you spend getting milked like an animal, lest you wind up like one.</i>\"", true);
		doNext(13);
		player.createKeyItem("Breast Milker - Installed At Whitney's Farm", 0, 0, 0, 0);
		player.gems -= 250;
		statScreenRefresh();
	}
	//[NO]
	else if (eventNo == 2183)
	{
		doNext(13);
		outputText("Whitney shrugs and the two of you chat about other things, just passing the time and enjoying a relatively normal chat.", true);
		//+3 int if less than 15, +2 int if less 20, +1 int if less than 30, +.5 int if less than 40.
		if (player.inte < 15)
			dynStats("int", 1);
		if (player.inte < 20)
			dynStats("int", 1);
		if (player.inte < 30)
			dynStats("int", .5);
		if (player.inte < 40)
			dynStats("int", .5);
	}
	//Continuing mino voyeurism
	else if (eventNo == 2190)
	{
		outputText("They go at it for nearly an hour, oblivious to you watching them, before their intensity heightens as they near orgasm. The results are almost explosive, both of them crying out as they begin twitching uncontrollably. Clinging desperately to the cow-girl's ass, the minotaur pumps so much cum into her depths that it begins spurting out. This accidental lubrication releases his grip and the pair collapse to the ground. Yet the minotaur isn't finished, his man-milk spraying into the air almost like his still-erect dick is a hose and splattering down onto both of them.\n\n", true);
		outputText("As you look at the two cum-covered creatures laying their in their exhausted sex-induced stupors, the minotaur's thick horse-cock now slowly deflating, you realize that you've been touching yourself.  You make yourself stop ", false);
		//[low corruption]
		if (player.cor < 33)
			outputText("in disgust.", false);
		else if (player.cor < 66)
			outputText("in confusion.", false);
		else
			outputText("reluctantly.", false);
		outputText("\n\nOnly now do you notice other faces peeking over ledges and ridges. You count at least two goblins and one imp who quickly pull back. From the sounds, they were busy getting themselves off.", false);
		//[if first appearance of this event]
		if (player.statusAffectv1("Mino + Cowgirl") == 0)
			outputText("  Apparently this isn't an uncommon show, and the locals enjoy it immensely.", false);
		//Lust!
		dynStats("lus", 5 + player.lib / 20 + player.minoScore() + player.cowScore());
		doNext(13);
	}
	//Bad end for going full demon
	else if (eventNo == 2191)
	{
		demonBadEnd();
	}
	
	else if (eventNo == 2203)
	{
		outputText("Tamani adopts a fighting pose and says, \"<i>If I have to I'll beat my children out of you!</b>\"", true);
		startCombat(new Tamani());
	}
	else if (eventNo == 2257)
	{
		telAdre.edryn.edrynBarTalk();
	}
	else if (eventNo == 2264)
	{
		sharkGirlGetsDildoed();
	}
	else if (eventNo == 2265)
	{
		sandwitchGetsDildoed();
	}
	else if (eventNo == 2266)
	{
		succubusGetsDildoed();
	}
	else if (eventNo == 2371)
	{
		amilyScene.exploreVillageRuin();
	}
	else if (eventNo == 2382)
	{
		amilyScene.sexWithAmily();
	}
	else if (eventNo == 2399)
	{
		//No sex after
		amilyScene.talkWithCuntIMeanAmily(false);
	}
	else if (eventNo == 2400)
	{
		//sex after
		amilyScene.talkWithCuntIMeanAmily(true);
	}
	else if (eventNo == 2405)
	{
		amilyScene.amilySexHappens();
	}
	else if (eventNo == 2409)
	{
		amilyScene.sitAndWatchAmilySex();
	}
	else if (eventNo == 2410)
	{
		amilyScene.caressAmilyHaveSex();
	}
	else if (eventNo == 2427)
	{
		amilyScene.amilyFollowerEncounter();
	}
	else if (eventNo == 2429)
	{
		amilyScene.talkToAmilyCamp();
	}
	else if (eventNo == 2453)
	{
		amilyScene.giveAmilyPureIncubusDraft();
	}
	else if (eventNo == 2456)
	{
		amilyScene.giveAmilyPurifiedSuccubusMilk();
	}
	else if (eventNo == 2457)
	{
		amilyScene.giveAmilyAPinkEgg();
	}
	else if (eventNo == 2458)
	{
		amilyScene.giveAmilyAWhiteEgg();
	}
	else if (eventNo == 2459)
	{
		amilyScene.giveAmilyABrownEgg();
	}
	else if (eventNo == 2460)
	{
		amilyScene.giveAmilyAPurpleEgg();
	}
	else if (eventNo == 2461)
	{
		amilyScene.giveAmilySomePants();
	}
	else if (eventNo == 2486)
	{
		player.gems += 50;
		statScreenRefresh();
		if (player.hasStatusAffect("Camp Rathazul") >= 0)
			rathazul.campRathazul();
		else
			rathazul.encounterRathazul();
	}
	else if (eventNo == 2487)
	{
		catAutoLick();
	}
	else if (eventNo == 2493)
	{
		telAdre.edryn.arousedByPregdryn();
	}
	else if (eventNo == 2495)
	{
		telAdre.edryn.fuckPregEdryn();
	}
	
	else if (eventNo == 2498)
	{
		jojoScene.jojoSprite();
		followerInteractions.agreeToHelpAmilyFixJojo();
	}
	else if (eventNo == 2499)
	{
		jojoScene.jojoSprite();
		followerInteractions.tellAmilyToFuckOffRuinedJojo();
	}
	else if (eventNo == 2500)
	{
		jojoScene.jojoSprite();
		followerInteractions.AmilyLeavesBirdJojoTentacles();
	}
	else if (eventNo == 2502)
	{
		jojoScene.jojoSprite();
		followerInteractions.stopJojoDeathInTheNameOfLove();
	}
	else if (eventNo == 2503)
	{
		jojoScene.jojoSprite();
		followerInteractions.whyWouldDoThis();
	}
	else if (eventNo == 2504)
	{
		jojoScene.jojoSprite();
		followerInteractions.tellRathazulYouOwnJojo();
	}
	else if (eventNo == 2505)
	{
		jojoScene.jojoSprite();
		followerInteractions.tellRathazulYouCanHandleIt();
	}
	else if (eventNo == 2506)
	{
		jojoScene.jojoSprite();
		followerInteractions.TellRathazulJojoIsHarmless();
	}
	else if (eventNo == 2512)
	{
		followerInteractions.BlameMarblezSweetVagoozle();
	}
	else if (eventNo == 2594)
	{
		freeValazLooseCoochie();
	}
	else if (eventNo == 2595)
	{
		useVala();
	}
	else if (eventNo == 2597)
	{
		healVala();
	}
	else if (eventNo == 2599)
	{
		ValaGetsSexed();
	}
	else if (eventNo == 2609)
	{
		loseToValaMaleIIGape();
	}
	else if (eventNo == 2614)
	{
		leftValaAlone();
	}
	else if (eventNo == 2617)
	{
		useValaOHYEAHSNAPINTOASLIMJIM();
	}
	else if (eventNo == 2619)
	{
		wakeValaUpBeforeYouGoGo();
	}
	else if (eventNo == 2621)
	{
		chooseValaInBar();
	}
	
	else if (eventNo == 2625)
	{
		cleansedValaRepeatBrainFucking();
	}
	
	else if (eventNo == 2633)
	{
		endZetaz();
	}
	else if (eventNo == 2634)
	{
		sexualTortureTightenZetaz();
	}
	else if (eventNo == 2635)
	{
		sexualTortureReleaseZetaz();
	}
	else if (eventNo == 2638)
	{
		outputText("", true);
		flags[kFLAGS.ZETAZ_LAIR_TOOK_BONDAGE_STRAPS]++;
		inventory.takeItem(armors.BONSTRP);
	}
	else if (eventNo == 2639)
	{
		spriteSelect(52);
		theSeanShopOffer();
	}
	else if (eventNo == 2640)
	{
		spriteSelect(52);
		incubusDeal();
	}
	else if (eventNo == 2641)
	{
		spriteSelect(52);
		incubusNoDeal();
	}
	else if (eventNo == 2642)
	{
		spriteSelect(52);
		incubusShop();
	}
	else if (eventNo == 2643)
	{
		spriteSelect(52);
		incubusBuy(consumables.NUMBROX);
	}
	else if (eventNo == 2644)
	{
		spriteSelect(52);
		incubusBuy(consumables.SENSDRF);
	}
	else if (eventNo == 2645)
	{
		spriteSelect(52);
		incubusBuy(consumables.REDUCTO);
	}
	else if (eventNo == 2653)
	{
		incubusBuy(weapons.SUCWHIP);
	}
	else if (eventNo == 2739)
	{
		telAdre.dominika.fellatrixBarApproach();
	}
	else if (eventNo == 2756)
	{
		amilyScene.girlyGirlMouseSex();
	}
	else if (eventNo == 2757)
	{
		amilyScene.hermilyOnFemalePC();
	}
	else if (eventNo == 2768)
	{
		amilyScene.makeAmilyAHerm();
	}
	else if (eventNo == 2775)
	{
		amilyScene.makeChildren();
	}
	else if (eventNo == 2800)
	{
		amilyScene.giveCorruptAmilySuccubusDelight();
	}
	
	else if (eventNo == 2819)
	{
		telAdre.cotton.cottonTantricSex();
	}
	else if (eventNo == 2844)
	{
		telAdre.heckel.greetHeckel();
	}
	
	else if (eventNo == 2855)
	{
		if (model.time.hours == 19 || model.time.hours == 20)
		{
			flags[kFLAGS.COUNTDOWN_TO_NIGHT_RAPE]++;
			if (flags[kFLAGS.COUNTDOWN_TO_NIGHT_RAPE] % 4 == 0 && player.gender == 1)
			{
				bazaar.nightBazaarButtfuck();
				return;
			}
		}
		bazaar.enterTheBazaarAndMenu();
	}
	else if (eventNo == 2884)
	{
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00226] = 1;
		bazaar.roxanne.roxanneDrinkingContest();
	}
	else if (eventNo == 2933)
	{
		telAdre.maddie.nopeAintGotNoneODemSpeculIngredimathings();
	}
	else if (eventNo == 2934)
	{
		telAdre.maddie.handOverIngredientsItBeBakingTimeYo();
	}
	else if (eventNo == 2940)
	{
		spriteSelect(23);
		outputText("Giacomo holds up the book with a small degree of reverence. The cover is leather, with the lettering stitched in by hand. \"<i>This, my friend,</i>\" begins Giacomo, \"<i>is a strange book indeed. I traded for it in the east, where they practice a form of exercise known as yoga. This volume in particular deals with those of, shall we say, unusual body shapes. Because of its rarity and usefulness, I simply cannot let it go for less than 100 gems and believe me, at this price I'm practically cutting my own throat. Care to broaden your horizons?</i>\"", true);
		doYesNo(2941, 2017);
	}
	else if (eventNo == 2941)
	{
		if (player.hasKeyItem("Yoga Guide") >= 0)
		{
			outputText("<b>You already own a yoga guide!</b>", true);
			doNext(2017);
			return;
		}
		if (player.gems < 100)
		{
			outputText("You cannot afford a yoga guide!", true);
			doNext(2017);
			return;
		}
		outputText("You exchange 100 gems for the tome.  Now you can finally enjoy a workout with Cotton!", true);
		player.createKeyItem("Yoga Guide", 0, 0, 0, 0);
		player.gems -= 100;
		statScreenRefresh();
		doNext(2017);
	}
	else if (eventNo == 2951)
	{
		camp.stash(false);
	}
	else if (eventNo == 2968)
	{
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00256] = 1;
		isabellaScene.isabellaGreeting();
	}
	else if (eventNo == 2997)
	{
		startCombat(new MaleSpiderMorph());
		eventParser(1);
		spriteSelect(74);
	}
	else if (eventNo == 3002)
	{
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] = 1;
		rathazul.chooseArmorOrRobes();
	}
	else if (eventNo == 3004)
	{
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00275] = 2;
		rathazul.chooseArmorOrRobes();
	}
	else if (eventNo == 3041)
	{
		if (rand(24) == 0 && player.hasCock())
			ceraphFollowerScene.catgirlEncounter();
		else if (rand(24) == 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00293] == 0)
			ceraphFollowerScene.carephCorruptionSlaves();
		else if (rand(24) <= 1 && player.gender > 0)
			ceraphFollowerScene.encounterZetsuko();
		else
			ceraphFollowerScene.ceraphFollowerAppearance();
	}
	else if (eventNo == 3077)
	{
		telAdre.lottie.gotInShapeComedyDeclineLottie();
	}
	else if (eventNo == 3081)
	{
		telAdre.lottie.analLottieMilkshake();
	}
	else if (eventNo == 3082)
	{
		telAdre.lottie.getSuckedOffByAHamSandwich();
	}
	else if (eventNo == 3107)
	{
		telAdre.lottie.lottieFatLoserCulminationLeaveComedyChoice();
	}
	else if (eventNo == 3110)
	{
		telAdre.lottie.ewLottieNo();
	}
	else if (eventNo == 3113)
	{
		telAdre.lottie.charlottesWebComedyBullshit();
	}
	else if (eventNo == 3133)
	{
		telAdre.lottie.giveLottieAnItem();
	}
	else if (eventNo == 3135)
	{
		telAdre.lottie.feedLottieLaBova();
	}
	else if (eventNo == 3136)
	{
		telAdre.lottie.giveLottieGroPlus();
	}
	else if (eventNo == 3137)
	{
		telAdre.lottie.giveLottieReducto();
	}
	else if (eventNo == 3138)
	{
		telAdre.lottie.hamSammitchTimeBIATCH();
	}
	else if (eventNo == 3139)
	{
		telAdre.lottie.lottieFuck();
	}
	else if (eventNo == 3142)
	{
		telAdre.lottie.lottieRepeatCowGirl();
	}
	else if (eventNo == 3143)
	{
		telAdre.lottie.lottieRepeatQuickie();
	}
	else if (eventNo == 3146)
	{
		telAdre.lottie.lottieRepeatBackwardsAssCowgirl();
	}
	else if (eventNo == 3147)
	{
		telAdre.lottie.lottieRepeatFEMDOMFEMFDOM();
	}
	else if (eventNo == 3148)
	{
		telAdre.lottie.hugTheShitOutOfYourHam();
	}
	else if (eventNo == 3149)
	{
		telAdre.lottie.encounterLottie(true);
	}
	else if (eventNo == 3172)
	{
		amilyScene.amilyDefurryOfferAtCamp();
	}
	else if (eventNo == 3174)
	{
		amilyScene.amilyNoFur();
	}
	else if (eventNo == 3187)
	{
		followerInteractions.askAboutAmily();
	}
	else if (eventNo == 3190)
	{
		followerInteractions.amilyUrtaSex();
	}
	else if (eventNo == 3400)
	{
		amilyScene.dateNightFirstTime();
	}
	else if (eventNo == 3409)
	{
		meditate();
	}
	else if (eventNo == 3414)
	{
		centaurGirlsGetHorseAids();
	}
	else if (eventNo == 3415)
	{
		centaurDudesGetHorseAids();
	}
	else if (eventNo == 3416)
	{
		telAdre.lottie.lottiesThirtyMinutePigGasm();
	}
	else if (eventNo == 3449)
	{
		valaCumBath();
	}
	else if (eventNo == 3457)
	{
		amilyScene.fuckIncestCunts();
	}
	else if (eventNo == 3458)
	{
		amilyScene.fuckIncestCunts(true);
	}
	else if (eventNo == 3525)
	{
		telAdre.niamh.getANiamhBeer();
	}
	else if (eventNo == 3532)
	{
		telAdre.niamh.maybeLaterNiamh();
	}
	else if (eventNo == 3533)
	{
		telAdre.niamh.taintNiamh(true);
	}
	else if (eventNo == 3537)
	{
		telAdre.niamh.bazaarNiamh();
	}
	else if (eventNo == 3542)
	{
		telAdre.niamh.seanBimboBrewing();
	}
	else if (eventNo == 3543)
	{
		telAdre.niamh.yeahSeanLetsBimbooze();
	}
	else if (eventNo == 3688)
	{
		pumpkinFuck();
	}
	else if (eventNo == 3727)
	{
		mountPumpkin();
	}
	else if (eventNo == 3803)
	{
		stuffDatTurkeyWithSpoo();
	}
	else if (eventNo == 3804)
	{
		spitRoastThatTurkey();
	}
	else if (eventNo == 3805)
	{
		thatllDoTurkey();
	}
	else if (eventNo == 3851)
	{
		getHugeEggsInCawk();
	}
	else if (eventNo == 3879)
	{
		telAdre.rubi.giveRubiClothes(armors.CLSSYCL);
	}
	else if (eventNo == 3880)
	{
		telAdre.rubi.giveRubiClothes(armors.RBBRCLT);
	}
	else if (eventNo == 3881)
	{
		telAdre.rubi.giveRubiClothes(armors.ADVCLTH);
	}
	else if (eventNo == 3882)
	{
		telAdre.rubi.giveRubiClothes(armors.TUBETOP);
	}
	else if (eventNo == 3883)
	{
		telAdre.rubi.giveRubiClothes(armors.T_BSUIT);
	}
	else if (eventNo == 3884)
	{
		telAdre.rubi.giveRubiClothes(armors.B_DRESS);
	}
	else if (eventNo == 3885)
	{
		telAdre.rubi.giveRubiClothes(armors.LTHRPNT);
	}
	else if (eventNo == 3886)
	{
		telAdre.rubi.giveRubiClothes(armors.NURSECL);
	}
	else if (eventNo == 3887)
	{
		telAdre.rubi.giveRubiClothes(armors.S_SWMWR);
	}
	else if (eventNo == 3893)
	{
		telAdre.rubi.cheatingRubi();
	}
	else if (eventNo == 3894)
	{
		telAdre.rubi.approachRubiScenes();
	}
	else if (eventNo == 3895)
	{
		telAdre.rubi.buyRubiMilk();
	}
	else if (eventNo == 3896)
	{
		telAdre.rubi.getTeaFromRubi();
	}
	else if (eventNo == 3897)
	{
		telAdre.rubi.chatWithRubi();
	}
	else if (eventNo == 3898)
	{
		telAdre.rubi.rubisFuckingHouseYouPervert();
	}
	else if (eventNo == 3899)
	{
		telAdre.rubi.fuckRubi();
	}
	else if (eventNo == 3900)
	{
		telAdre.rubi.dildoFuckRubi();
	}
	else if (eventNo == 3901)
	{
		telAdre.rubi.teaseRubi();
	}
	else if (eventNo == 3902)
	{
		telAdre.rubi.releaseRubi();
	}
	
	else if (eventNo == 3904)
	{
		telAdre.rubi.dontCareAboutNoCheatingRubis();
	}
	else if (eventNo == 3905)
	{
		telAdre.rubi.findBimboCheatster();
	}
	else if (eventNo == 3950)
	{
		amilyScene.layEggsInAmily();
	}
	else if (eventNo == 3951)
	{
		if (!player.canOvipositBee() || rand(2) == 0)
			plains.bunnyGirl.ovipositBunnyEaster();
		else
			plains.bunnyGirl.layEggsInBunbuns();
	}
	else if (eventNo == 3952)
	{
		layEggsInYerTits();
	}
	else if (eventNo == 3960)
	{
		amilyScene.amilySwimFuckIntro();
	}
	else if (eventNo == 3964)
	{
		nieveBuilding();
	}
	else if (eventNo == 3965)
	{
		approachNieve();
	}
	else if (eventNo == 3966)
	{
		telAdre.heckel.dominateHeckel();
	}
	else if (eventNo == 3968)
	{
		highMountains.chickenHarpy();
	}
	else if (eventNo == 3989)
	{
		amilyScene.amilyXIzmaSuperPregOptions();
	}
	else if (eventNo == 3990)
	{
		amilyScene.drinkThePotion();
	}
	else if (eventNo == 3991)
	{
		amilyScene.amilyNurseCheckup();
	}
	else if (eventNo == 3993)
	{
		telAdre.houses();
	}
	else
	{
		//Problem here. Lots of the old code relies on the fall through to proceed forward. Prime offender is the
		//the 2000 EventNo imp meeting stuff after choosing your history. This needs some tinkering to get working correctly.
		errorPrint(eventNo); // Dump the system state to the window so the player can file a decent bug-report
		//trace("ERROR Event "+eventNo+" not found");
	}

}

