//Event No's 2000 4999 use this function
function doEvent(eventNo):void {
	var temp2:Number = 0;
	var temp3:Number = 0;
	var temp4:Number = 0;
	var temp5:Number = 0;
	var temp6:Number = 0;
	var temp7:Number = 0;
	var temp8:Number = 0;
	
	//New game gooooooo!
	if(eventNo == 2000) 
	{
		hideUpDown();
		stats(0,0,0,0,0,0,40,2);
		hours = 18;
		outputText("You wake with a splitting headache and a body full of burning desire.  A shadow darkens your view momentarily and your training kicks in.  You roll to the side across the bare ground and leap to your feet.  A surprised looking imp stands a few feet away, holding an empty vial.  He's completely naked, an improbably sized pulsing red cock hanging between his spindly legs.  You flush with desire as a wave of lust washes over you, your mind reeling as you fight ", true);
		if(player.gender == 2) outputText("the urge to chase down his rod and impale yourself on it.\n\n", false);
		else outputText("the urge to ram your cock down his throat.  The strangeness of the thought surprises you.\n\n", false);
		speech("I'm amazed you aren't already chasing down my cock, human.  The last Champion was an eager whore for me by the time she woke up.  This lust draft made sure of it.", "The Imp");
		doNext(2001);
	}
	if(eventNo == 2001) {
		hideUpDown();
		stats(0,0,0,0,0,0,-30,0);
		outputText("\nThe imp shakes the empty vial to emphasize his point.  You reel in shock at this revelation - you've just entered the demon realm and you've already been drugged!  You tremble with the aching need in your groin, but resist, righteous anger lending you strength.\n\nIn desperation you leap towards the imp, watching with glee as his cocky smile changes to an expression of sheer terror.  The smaller creature is no match for your brute strength as you pummel him mercilessly.  You pick up the diminutive demon and punt him into the air, frowning grimly as he spreads his wings and begins speeding into the distance.\n\n", true);
		speech("FOOL!  You could have had pleasure unending...but should we ever cross paths again you will regret humiliating me!  Remember the name Zetaz, as you'll soon face the wrath of my master!", "The Imp");
		outputText("\nYour pleasure at defeating the demon ebbs as you consider how you've already been defiled.  You swear to yourself you will find the demon responsible for doing this to you and the other Champions, and destroy him AND his pet imp.", false);
		doNext(2002);
	}
	if(eventNo == 2002) {
		hideUpDown();
		outputText("\nYou look around, surveying the hellish landscape as you plot your next move.  The portal is a few yards away, nestled between a formation of rocks.  It does not seem to exude the arousing influence it had on the other side.  The ground and sky are both tinted different shades of red, though the earth beneath your feet feels as normal as any other lifeless patch of dirt.   You settle on the idea of making a camp here and fortifying this side of the portal.  No demons will ravage your beloved hometown on your watch.\n\nIt does not take long to set up your tent and a few simple traps.  You'll need to explore and gather more supplies to fortify it any further.  Perhaps you will even manage to track down the demons who have been abducting the other champions!", true);
		doNext(1);
	}
	//Meditate w/Jojo
	if(eventNo == 2003) {
		spriteSelect(34);
		outputText("Jojo smiles and leads you off the path to a small peaceful clearing.  There is a stump in the center, polished smooth and curved in a way to be comfortable.  He gestures for you to sit, and instructs you to meditate.\n\nAn indeterminate amount of time passes, but you feel more in control of yourself.  Jojo congratulates you, but offers a warning as well.  \"<i>Be ever mindful of your current state, and seek me out before you lose yourself to the taints of this world.  Perhaps someday this tainted world can be made right again.</i>\"", true);
		
		stats(.5,.5,0,.5,-1,0,-5,-1);
		if(player.hasStatusAffect("Jojo Meditation Count") < 0) player.createStatusAffect("Jojo Meditation Count",1,0,0,0);
		else player.addStatusValue("Jojo Meditation Count",1,1);
		temp = player.statusAffectv1("Jojo Meditation Count");
		if(temp >= 5) {
			outputText("\n\nJojo nods respectfully at you when the meditation session is over and smiles.  ");
			//Forest Jojo Eligible for Invite After Meditation but There's Trash in Camp -Z
			if(flags[FUCK_FLOWER_LEVEL] >= 4 && flags[FUCK_FLOWER_KILLED] == 0 && temp % 5 == 0) {
				//replaces 'Jojo nods respectfully at you [...] "It seems you have quite a talent for this. [...]"' invite paragraphs while Treefingers is getting slut all over your campsite
				//gives Small Talisman if PC never had follower Jojo or used it and ran from the fight
				//[(if PC has Small Talisman)
				if(player.hasKeyItem("Jojo's Talisman") >= 0) {
					outputText("Jojo smiles at you.  \"<i>[name], well done.  Your talent at focusing is undiminished.  Regarding the other issue... you still have the item I gave you?</i>\"");
					outputText("\n\nYou hold up the talisman, and he nods.  \"<i>Good.  Stay safe and signal me with it if you need help.</i>\"");
				}
				//(else no Small Talisman)
				else {
					outputText("Jojo nods at you respectfully.  \"<i>Well done today; your dedication is impressive.  We could meditate together more often.</i>\"");
					outputText("\n\nAs much as you'd like to, you can't stay in the forest, and you can't invite him back with you right now.  Reluctantly, you mention the stubborn, demonic godseed's presence on the borders of your camp.  Jojo's eyebrows furrow in concentration.");
					outputText("\n\n\"<i>Yes, that's a problem.  Oh, that we did not have to resist the very spirit of the land!  [name], take this.  Use it to call me if the demon gives you trouble; I will come and render what aid I can.</i>\"  The monk fishes in his robe and places a small talisman into your hand.");
					//get a small talisman if not have one
					player.createKeyItem("Jojo's Talisman",0,0,0,0);
					outputText("\n\n(Gained Key Item: Jojo's Talisman)");
				}
				doNext(14);
				return;
			}
			else outputText("\"<i>It seems you have quite a talent for this.  We should meditate together more often.</i>\"", false);
		}
		if(temp % 5 == 0) {
			outputText("\n\nYou ponder and get an idea - the mouse could stay at your camp.  There's safety in numbers, and it would be easier for the two of you to get together for meditation sessions.  Do you want Jojo's company at camp?", false);
			doYesNo(2149,14);
			return;
		}
		else outputText("\n\nHe bows his head sadly and dismisses you.", false);
		doNext(14);
	}
	//Begin the jojo rapingz
	if(eventNo == 2004) {
		spriteSelect(34);
		jojoRape();
		doNext(13);
	}
	//Encounter sand-witch
	if(eventNo == 2005) {
		spriteSelect(50);
		outputText("A strange woman seems to appear from the dunes themselves.  She identifies herself as a sand witch, and politely asks if she can cast a spell on you.", true);
		if(player.statusAffectv1("Exgartuan") == 1 && player.cockArea(0) > 100 && player.statusAffectv2("Exgartuan") == 0) {
			outputText("\n\nThe " + player.armorName + " covering your lower half hits the ground, as if yanked down by magic.  Your " + cockDescript(0) + " pulsates darkly, growing rigid in seconds as the demon within you takes over.  It barks, \"<i>Fuck, how about I cast my spell on you baby?</i>\"\n\n", false);
			outputText("The sandwitch ", false);
			if(player.cor < 50) outputText("and you both turn crimson", false);
			else outputText("turns crimson", false);
			outputText(" as you yank your " + player.armorName + " back into place.  You're in charge here, not some possessed appendage!   Exgartuan yells something snide, but it's muffled too much to understand.  You look up in time to sidestep an attack from the Sand Witch.  It looks like you'll have to fight her!", false);
			startCombat(2);
			return;
		}
		else doYesNo(2006, 2007);
		return;
	}
	//SANDVICH MAGICK
	if(eventNo == 2006) {
		spriteSelect(50);
		outputText("", true);
		if(player.hairColor == "sandy blonde") {
			outputText("She smiles wickedly and intones, \"<i>Tresed eht retaw llahs klim ruoy.</i>\"\n\n", false); 
			if(player.breastRows.length == 0 || player.biggestTitSize() == 0) {
				outputText("You grow a perfectly rounded pair of C-cup breasts!  ", false);
				if(player.breastRows.length == 0) player.createBreastRow();
				player.breastRows[0].breasts = 2;
				player.breastRows[0].breastRating = 3;
				if(player.breastRows[0].nipplesPerBreast < 1) player.breastRows[0].nipplesPerBreast = 1;
				stats(0, 0, 0, 0, 0, 2, 1, 0);
			}
			if(player.biggestTitSize() >= 1 && player.biggestTitSize() <= 2) {
				outputText("Your breasts suddenly balloon outwards, stopping as they reach a perfectly rounded C-cup.  ", false);
				player.breastRows[0].breastRating = 3;
				stats(0, 0, 0, 0, 0, 1, 1, 0);
			}
			if(player.breastRows[0].nipplesPerBreast < 1) {
				outputText("Two dark spots appear on your chest, rapidly forming into sensitive nipples.  ", false);
				player.breastRows[0].nipplesPerBreast = 1;
				stats(0, 0, 0, 0, 0, 2, 1, 0);
			}
			if(player.biggestLactation() > 0) {
				outputText("A strong pressure builds in your chest, painful in its intensity.  You yank down your top as ", false);
				if(player.biggestLactation() < 2) outputText("powerful jets of milk spray from your nipples, spraying thick streams over the desert sands.  You moan at the sensation and squeeze your tits, hosing down the tainted earth with an offering of your milk.  You blush as the milk ends, quite embarassed with your increased milk production.  ", false);
				if(player.biggestLactation() >=2 && player.biggestLactation() <=2.6) outputText("eruptions of milk squirt from your nipples, hosing thick streams everywhere.  The feeling of the constant gush of fluids is very erotic, and you feel yourself getting more and more turned on.  You start squeezing your breasts as the flow diminishes, anxious to continue the pleasure, but eventually all good things come to an end.  ", false);
				if(player.biggestLactation() > 2.6 && player.biggestLactation() < 3) outputText("thick hoses of milk erupt from  your aching nipples, forming puddles in the sand.  You smile at how well you're feeding the desert, your milk coating the sand faster than it can be absorbed.  The constant lactation is pleasurable... in a highly erotic way, and you find yourself moaning and pulling on your nipples, totally outside of your control.  In time you realize the milk has stopped, and even had time to soak into the sands.  You wonder at your strange thoughts and pull your hands from your sensitive nipples.  ", false);
				if(player.biggestLactation() >= 3) outputText("you drop to your knees and grab your nipples.  With a very sexual moan you begin milking yourself, hosing out huge quantities of milk.  You pant and grunt, offering as much of your milk as you can.  It cascades down the dune in a small stream, and you can't help but blush with pride... and lust.  The erotic pleasures build as you do your best to feed the desert of all your milk.  You ride the edge of orgasm for an eternity, milk everywhere.  When you come to, you realize you're kneeling there, tugging your dry nipples.  Embarrassed, you stop, but your arousal remains.  ", false);
				if(player.biggestLactation() < 3) {
					player.boostLactation(.75);
					outputText("Your breasts feel fuller... riper... like your next milking could be even bigger.  ", false);
				}
				stats(0, 0, 0, 0, 1, 4, 15, 0);
			}
			if(player.biggestLactation() == 0) {
				outputText("A pleasurable release suddenly erupts from your nipples!  Streams of milk are spraying from your breasts, soaking into the sand immediately.  It stops all too soon, though the witch assures you that you can lactate quite often now.  ", false);
				player.boostLactation(1);
				stats(0, 0, 0, 0, .5, 1, 10, 0);
			}
			outputText("The sand-witch smiles and thanks you for your offering.  You notice her dress is damp in four spots on the front.  ", false);
			if(sand == 0) outputText("You wonder at what her robes conceal as she vanishes into the dunes.", false);
			if(sand == 1) {
				if(player.cor <= 33) outputText("You are glad to avoid servicing her again as she vanishes into the dunes.", false);
				if(player.cor > 33 && player.cor <= 66) outputText("You wonder if you should've resisted and tried for some sex as she departs.", false);
				if(player.cor > 66) outputText("You wish you had said no, so you could fuck with her and her magnificent quartet of breasts some more.", false);
			}
			doNext(13);
			return;
		}
		else {
			outputText("She smiles wickedly and intones, \"<i>nuf erutuf rof riah ydnas, nus tresed eht sa ydnas.</i>\"\n\nYou feel a tingling in your scalp, and realize your hair has become a sandy blonde!", false);
			player.hairColor = "sandy blonde";
			doNext(13);
			return;
		}
	}
	//SANDWITCH COMMMMBAAAAT
	if(eventNo == 2007) {
		spriteSelect(50);
		outputText("With an inarticulate scream of rage, the Sand Witch attacks!", true);
		startCombat(2);
	}
	//Minotaur shows up...rape?
	if(eventNo == 2008) {
		outputText("As you take the winding path up through the rocky trail, you come upon the opening to a cave. Peering inside, the stench of an overpowering musk washes over you. The primal scent excites you, causing you to become aroused almost immediately.  Not thinking as clearly as you normally might, you slowly sneak your way into the cave. Signs of life litter the cave floor.\n\n", true);
		stats(0,0,0,0,0,0,10+player.lib/5,0);
		//Detect minotaur coming
		if(rand(30) + player.inte/5 > 18) {
			outputText("You spot a shadow moving and spin around to see a minotaur lumbering after you from the back of the cave!", false);
			startCombat(4);
			return;
		}
		outputText("Suddenly you're grabbed from behind, your arms held together by a single massive, furry hand. A heavy, snorting breath brushes the top of your head. You turn your neck to see a massive bull-man. His impressive dick presses ", false);
		if(player.lowerBody == 4) outputText("against your buttocks", false);
		else outputText("into the small of your back", false);
		outputText(" as it grows larger and harder, smearing its pre-cum into your skin and making you shiver.  ", false);
		//High str escape
		if(rand(20) + player.str/3 > 18) {
			outputText("\n\nYou twist around using the additional lubrication and squirm free!  Rolling away, you come up in a crouch, ready to fight!", false);
			startCombat(4);
			return;
		}
		if(player.vaginas.length > 0) {
			outputText("The bull-man roughly grabs your hair and begins rubbing the flared head of his penis along your " + vaginaDescript(0) + ".  ", false);
			if(player.averageVaginalWetness() < 2) outputText("You aren't very wet, and fear the damage this beast will inflict on your " + vaginaDescript(0) + ".  ", false);
			else outputText("You're shamefully wet by this point, and your knees are ready to buckle.  ", false);
		}
		//BUTTSECKS!
		else {
			outputText("The bull-man roughly grabs your hair and repositions himself to press against your asshole, slowly building the pressure until suddenly, the flared head pops into you.  ", false);
			buttChange(100, true);
		}
		if(player.lowerBody == 4) outputText("Grabbing your buttocks with his huge hands, he lifts your buttocks, and violently drive his shaft as far into you as he can manage. You cry out, your whole lower body in fire, as your rear legs dangle helplessly. Unhindered by your weight, he uses your lower body as a cock-sleeve, as you try your best to keep your front legs from buckling.  ", false);
		else {
			outputText("\n\nHe lifts you into the air, with little effort hefting your insignificant weight, and roughly impales you onto his shaft, forcing himself as far into you as he can manage. You cry out, and looking down you can see your stomach distending to accommodate his incredible size. Using you like a human cock-sleeve, he simply holds you by the torso and begins lifting you up and down.  ", false);
			if(player.biggestTitSize() > 0 && player.mostBreastsPerRow() > 1 && player.breastRows.length > 0) {
				outputText("He manhandles your tits as he does so, almost violently squeezing and stretching them to his enjoyment.  ", false);
				if(player.biggestLactation() > 1.5) outputText("He then gives a grunt in what you take to be approval as your milk begins to squirt out. He licks a milk-coated finger in satisfaction.  ", false);
			}
		}
		if(player.cockTotal() == 1) outputText("The bull-man bends forward a little, and grabs your " + cockDescript(0) + " in a crushing grip. He makes short jerking motions as he keeps thrusting into you.", false);
		if(player.cockTotal() > 1) outputText("The bull-man bends forward a little, and grabs one of your " + cockDescript(0) + "s in a crushing grip. He makes short jerking motions as he keeps thrusting into you.", false);
		outputText("\n\nFinally, you can feel he's ready to cum. His thrusts become shorter and faster, and just when you think you can't stand it anymore he starts shooting his sperm into you. You notice your stomach beginning to round out from the sheer amount of bull seed being pumped into your belly.  ", false);
		stats(0,0,0,0,1,-.5,0,1);
		if(player.vaginas.length > 0) {
			if(player.averageVaginalWetness() >= 2) {
				if(player.averageVaginalWetness() < 4) outputText("You squirm and quiver, orgasming from the beast's rough usage.  ", false);
				if(player.averageVaginalWetness() == 4) outputText("You squirm and quiver, orgasming from the beast's rough usage, soaking him with your " + vaginaDescript(0) + ".  ", false);
				if(player.averageVaginalWetness() == 5) outputText("You orgasm on his massive rod, splattering the beast with girlcum.  ", false);
				stats(0,0,0,0,.5,0,-100,1);
			}
			if(player.averageVaginalWetness() < 2) {
				outputText("You gasp in pain, your cunt rubbed raw by the rough and violent penetration.  ", false);
				stats(0,-.5,0,0,0,0,-5,1);
			}
			//Preggers chance!
			player.knockUp(2,432,101);
		}
		slimeFeed();
		if(player.cockTotal() > 0 && (player.sens + rand(40) > 50)) {
			outputText("You orgasm, ", false);
			if(player.cumQ() < 25) outputText("spurting your seed helplessly from the brutal rape.  ", false);
			if(player.cumQ() >= 25 && player.cumQ() < 250) outputText("squirting thick ropes of cum over the cave.  ", false);
			if(player.cumQ() >= 250 && player.cumQ() < 500) outputText("erupting potent ropes of seed in thick bursts, splattering the cave walls and floors.  ", false);
			if(player.cumQ() >= 500) outputText("erupting a thick torrent of seed that seems to go on forever, spurred by the constant pressure of the huge minotaur cock.  You paint the cave wall with cum, the beast egging you on as it roughly jacks your " + cockDescript(0) + ".  You are vaguely aware of your orgasm dragging on and on, until eventually your orgasm stops, leaving a sizable puddle of cum on the floor.  ", false);
			stats(0,0,0,0,.5,0,-100,1);
		}
		//Need to figure out minotaur cock volume for new function UNFINISHED
		if(player.vaginas.length > 0) cuntChange((24*3), true);
		outputText("The bull-man relaxes for a moment, then shoves you off of him and to the cold ground.\n\nYou awaken several hours later. The bull-man is nowhere to be seen, so you make a hasty exit.", false);
		doNext(15);
	}
	//Tentacle's appear!
	if(eventNo == 2009) {
		trace("Tentacle event here");
		outputText("", true);
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
		if(player.gender == 0 && rand(3) == 0 && !player.isNaga() && !player.isTaur() && !player.isGoo()) {
			//Warm up for neuters as per the old event:
			outputText("You see a massive, shambling form emerge from the underbrush. While first appearing to be a large shrub, it shifts its bulbous mass and reveals a collection of thorny tendrils and cephalopodic limbs. Sensing your presence, it lumbers at you, full speed, tentacles outstretched.\n\n", false);
			
			if(player.cor > 50 && player.cor <= 75) outputText("You debate the merits of running from such a creature, and realize it's now too late to escape.  ", false);
			if(player.cor > 75) outputText("You smile and stride forward, welcoming the pleasure you expect from such a monster.  ", false);
			//HILARIOUS NEUTER EVENT HERE
			if(player.cor < 75) outputText("While you attempt to resist the abomination, its raw muscle mass is too much. ", false);
			outputText("It pins you to the ground easily. You feel slimy tentacles run up and down your groin as the creature searches for whatever gonads it expected you to have. When it realizes that you have neither penis nor vagina, it smartly casts you to the ground in apparent disgust.\n\n\"<i>WHAT THE FUCK IS THIS SHIT?!!</i>\" The creature speaks in an unnervingly human voice.\n\n", false);
			outputText("Completely confused, all you can do is sit there in shock.\n\n\"<i>Where are your naughty bits, goddammit!</i>\" the creature bellows. \"<i>Us tentacle creatures need to FEED!</i>\"\n\n", false);
			outputText("You sheepishly state that you are gender-neutral and have no genitalia.\n\n\"<i>You gotta be shitting me!!</i>\" the monster bellows in contempt. \"<i>Of all the motherfuckers I ambush, it has to be the ONE bastard I can't feed from! What am I supposed to do now, asshole?! I gotta eat!</i>\"", false);
			outputText("At a loss for words, you meekly offer the creature some of your food you have packed for your journey. The creature slaps it out of your hand, almost breaking your wrist.\n\n\"<i>I can't eat that shit!</i>\" roars the abomination. \"<i>Do I look like I have a fucking mouth to chew that with?! NOOOOOO! I feed off dicks and wayward women! Cum and tit milk! YOU have NEITHER!!!</i>\"  ", false);
			outputText("The beast slaps you squarely on the ass as if to push you along. \"<i>Get the fuck out of here!</i>\" it screams. \"<i>Get lost so I can hunt me a REAL meal!!!</i>\"", false);
			outputText("You walk away from the creature, which hides back in the brush. After you trek a bit, you wonder if what happened really DID happen...", false);
			stats(0,0,0,0,0,0,-5,0);
			doNext(13);
			return;
		}
		//Combat starter
		outputText("You see a massive, shambling form emerge from the underbrush.  While it resembles a large shrub, a collection of thorny tendrils and cephalopodic limbs sprout from its bulbous mass.  Sensing your presence, it lumbers at you, full speed, tentacles outstretched.\n\n", false);
		if(player.cor > 50 && player.cor <= 75) outputText("You debate the merits of running from such a creature.\n\n", false);
		if(player.cor > 75) outputText("You smile and stride forward, welcoming the pleasure you expect from such a monster.\n\n", false);
		//Worms get nothing!
		if(player.hasStatusAffect("infested") >= 0) {
			outputText("It stops itself completely in a moment and twitches, as if sniffing the air, before turning around and disappearing into the underbrush.", false);
			doNext(13);
			return;
		}
		if(player.cor > 50) {
			outputText("Do you joyfully submit or fight back?\n\n", false);
			simpleChoices("Fight",2080, "Submit",5074,"",0,"",0,"",0);
			return;
		}
		startCombat(14);
		return;
	}
	//Tentacle continuation!
	if(eventNo == 2010) {
		stats(0, 1, 0, -.5, 2, 1, -100, .5);
		//Pg2
		if(player.gender == 1) {
			outputText("You next feel the wretched sensation of another tentacle pushing its way past your anus and into your rectum. You cry more out of frustration and anger than pain as the foreign body settles a few inches inside your body. With a furious, coordinated rhythm, the monstrosity begins swelling the tentacle in your ass and ", true);
			if(player.cockTotal() == 1) outputText("using a sucking-stroking motion on your helpless " + multiCockDescriptLight() + ". The swelling of the ass tentacle pressures your prostate in a paradoxically pleasurable and painful manner. You realize, much to your terror, that this beast is MILKING you of your semen!", false);
			else outputText("using a sucking-stroking motion on your " + multiCockDescriptLight() + ".  The swelling of the ass tentacle pressures your prostate in a paradoxical pleasurable and painful manner.  You realize, much to your terror, that this beast is MILKING you of your semen!", false);
			buttChange(50, true);		
			outputText("\n\nHelpless and overwhelmed by the pleasure of such rough and primal stimulation, all you can do is give the creature what it wants; your hot cum. Your body only responds to the sensations from your ", false);
			if(player.cockTotal() == 1) outputText(multiCockDescriptLight() + " and ass and in a very short time, your phallus explodes, launching stream upon stream of hot, thick cum into the horror. Your hips and pelvis buck violently with each thrust as the creature masterfully strokes your " + multiCockDescriptLight() + "  and milks your prostate of your fluids. You cry with each orgasm, prompting the thing to milk you harder. After an eternity of successive ejaculations, the creature withdraws its unholy arms and leaves you in a bruised, lacerated, overfucked heap on the ground, discarded like a person throws away a corn cob after a meal.", false);
			else outputText(multiCockDescriptLight() + " and ass and in a very short time, your dicks explode, launching stream upon stream upon stream of hot, thick cum into the horror.  Your hips and pelvis buck violently with each thrust as the creature masterfully strokes your " + multiCockDescriptLight() + " and milks your prostate of your fluids.  You cry with each orgasm, prompting the thing to milk you harder. After an eternity of successive ejaculations, the creature withdraws its unholy arms and leaves you in a bruised, lacerated, overfucked heap on the ground, discarded like a person throws away a corn cob after a meal.", false);
		}
		if(player.gender == 2){
			outputText("The beast rears up to reveal a beak-like maw. It opens its massive jaws to reveal ", true);
			if(player.vaginas.length == 1) outputText("a tongue shaped like a large cock while its tongue, like any tentacle, immediately seeks out your defenseless pussy. It prods itself mockingly around your labia as you attempt to contract to keep it from violating you and depriving you of what dignity you have left. The creature flexes its appendage and easily forces its way into your vagina", false);
			else outputText(player.vaginas.length + " tongues shaped like large cocks while its tongues, like any other tentacles, seeks out your defenseless pussies.  It prods itself mockingly around your labias as you attempt to contract to keep them from violating you and depriving you of what dignity you have left.  The creature flexes its appendages and easily forces its way into your " + vaginaDescript(0) + "s", false);
			if(player.vaginas.length > 1) outputText("s", false);
			outputText(". As you cry out in shock, another dick-shaped appendage forces its way into your throat. The beast takes care to prevent you from choking on its limb.", false);
			outputText("\n\nIn a coordination that can only signify higher intelligence, the monster fucks your " + vaginaDescript(0), false);
			if(player.vaginas.length > 1) outputText("s", false);
			outputText(" and mouth and begins milking your swollen breasts and sucks your throbbing ", false);
			if(player.vaginas.length > 1) outputText("clits. ", false);
			else outputText("clit. ", false);
			cuntChange(player.vaginalCapacity()*.76, true);
			outputText(" Your body betrays your resistance as pleasure hammers you from crotch to head. After some time, you begin bucking your hips in tandem to the creature's thrusts, drunk with pleasure. As you peak for your orgasm, you feel the creature bottom out inside your womb. Oceans of hot cum flood your " + vaginaDescript(0), false);
			if(player.vaginas.length > 1) outputText("s", false);
			outputText(" and your mouth. You are being inseminated by the abomination, but you do not care. The fucking is too good. The hot, musky fluids pour into your mouth. The taste crushes your last bit of resistance and you NEED MORE, not just to swallow, but to devour with your womb. You manage to free one hand, only to grasp the tentacle in your mouth to coax more semen inside you. You feel your stomach distend from the amount of cum you greedily swallow. The beast floods you with more cum than you can handle and proceeds to soak you from head to toe in its fluids as it runs from your overwhelmed orifices.", false);
			doNext(2011);
			slimeFeed();
			//lactate more from the encounter.
			player.boostLactation(.3);
			return;			
		}
		if(player.gender == 3) {
			if(player.cockTotal() == 1) {
				outputText("A sharp tug tells you that the creature has sealed itself upon your " + cockDescript(0) + ". You see " + player.totalBreasts() + " smaller tentacles latch onto your erect nipples. You feel milk begin to leak out as the creature makes a perfect seal around your areola. A thick, phallic tentacle probes underneath your trapped " + cockDescript(0) + " until it finds your vaginal opening. You cry out as the member punches past your opening and bottoms out in your womb. The tentacle swells up until it completely fills your " + vaginaDescript(0) + ".  ", true);
				cuntChange(player.vaginalCapacity()*.76, true, false, true);
				outputText("With freakish coordination, the beast sucks your " + cockDescript(0) + " and tits while hammering away at your " + vaginaDescript(0) + ". The overwhelming pleasure courses through your body and triggers an immediate orgasm, sending gouts of cum into the tentacle sealed around your " + cockDescript(0) + ". The sensation of your fluids entering the creature prompts it to suck your " + cockDescript(0) + " harder as well as hammer your " + vaginaDescript(0) + " faster, leading to a chain of orgasms.\n\n", false);
				outputText("Drunk with pleasure, you revel in the sensation of cumming into the creature while it breast feeds from you. All you can do is drown in the experience of being milked from top to bottom. The creature begins piledriving your box faster and you feel like the creature is going to impale you with its phallic tentacle.\n\n", false);
				outputText("The creature's milking tentacles stop moving and you feel the dick-tentacle press sharply against your womb. You feel the thunderous force of hot fluid lance into your body as the creature cums repeatedly inside you, triggering yet another orgasm. The creature cums in surges and shoots repeatedly inside you. Within moments, excess cum spews out of your " + vaginaDescript(0) + " as it cannot hold anymore, but the creature keeps cumming.\n\n", false);
				outputText("After a while the creature withdraws its tentacles from you. It poises the tentacle-cock over your face and lets out one last load, covering your face in hot, thick sperm. You reflexively open your mouth and allow loads of the salty juice down your throat. Once spent, the creature shambles off, leaving you well milked and cum-soaked.", false);
			}
			else {
				outputText("A sharp tug tells you that the creature has sealed itself upon your " + multiCockDescriptLight() + ". You see " + player.totalBreasts() + " smaller tentacles latch onto your erect nipples. You feel milk begin to leak out as the creature makes a perfect seal around your areola. A thick, phallic tentacle probes underneath your trapped cocks until it finds your vaginal opening. You cry out as the member punches past your opening and bottoms out in your womb. The tentacle swells up until it completely fills your " + vaginaDescript(0) + ".", true);
				cuntChange(player.vaginalCapacity()*.76, true, true, false);
				outputText("  With freakish coordination, the beast sucks your " + multiCockDescriptLight() + " and tits while hammering away at your " + vaginaDescript(0) + ". The overwhelming pleasure courses through your body and triggers an immediate orgasm, sending gouts of cum into the tentacles sealed around your pricks. The sensation of your fluids entering the creature prompts it to suck your throbbing cocks harder as well as hammer your " + vaginaDescript(0) + " faster, leading to a chain of orgasms.\n\n", false);
				outputText("Drunk with pleasure, you revel in the sensation of cumming into the creature while it breast feeds from you. All you can do is drown in the experience of being milked from top to bottom. The creature begins piledriving your box faster and you feel like the creature is going to impale you with its phallic tentacle.\n\n", false);
				outputText("The creature's milking tentacles stop moving and you feel the dick-tentacle press sharply against your womb. You feel the thunderous force of hot fluid lance into your body as the creature cums repeatedly inside you, triggering yet another orgasm. The creature cums in surges and shoots repeatedly inside you. Within moments, excess cum spews out of your " + vaginaDescript(0) + " as it cannot hold anymore, but the creature keeps cumming.\n\n", false);
				outputText("After a while the creature withdraws its tentacles from you. It poises the tentacle-cock over your face and lets out one last load, covering your face in hot, thick sperm. You reflexively open your mouth and allow loads of the salty juice down your throat. Once spent, the creature shambles off, leaving you well milked and cum-soaked.", false);
			}
			slimeFeed();
			//lactate more from the encounter.
			player.boostLactation(.3);
		}				
		if(gameState > 0) eventParser(5007);
		else doNext(13);
	}
	//Tentacle rape continuation for females (pg3!)
	if(eventNo == 2011) {
		//single coochie
		if(player.vaginas.length == 1) {
			outputText("Satisfied, the creature drops you smartly, withdraws its limbs from you, and lumbers away. Covered completely in cum, you see that your clitoris swelled up to ", true);
			//Big clit girls get huge clits
			if((player.hasPerk("Big Clit") >= 0 && player.clitLength > 2) || player.clitLength > 3) outputText("almost " + num2Text(Math.floor(player.clitLength*1.75)) + " inches in length. ", false);
			//normal girls get big clits
			else outputText("almost four inches in length. ", false);
			outputText("Bruised and sore, you pass into unconsciousness ", false);
		}
		else outputText("Satisfied, the creature drops you smartly and withdraws its limbs from you and lumbers away. Covered completely in cum, you see that your " + player.vaginas.length + " clits swelled up to almost four inches in length. Bruised and sore, you pass into unconsciousness, ", true);
		//Not too corrupt
		if(player.cor < 75) outputText("too intoxicated with lust to fume over your violation. ", false);
		//Very corrupt
		else outputText("too intoxicated with lust continue the pleasure. ", false);
		//If has big-clit grow to max of 6"
		if(player.clitLength < 7 && player.clitLength >= 3.5 && player.hasPerk("Big Clit") >= 0) {
			player.clitLength += .1 + player.cor/100;
			outputText("Your massive clitty eventually diminishes, retaining a fair portion of it's former glory.  It is now " + int(player.clitLength*10)/10 + " inches long when aroused, ", false);
			if(player.clitLength < 5) outputText("like a tiny cock.", false);
			if(player.clitLength >= 5 && player.clitLength < 7) outputText("like a slick throbbing cock.", false);
			if(player.clitLength >= 7) outputText("like a big thick cock.", false);
		}
		//Grow clit if smaller than 3.5"
		else if(player.clitLength < 3.5) {
			outputText("In time your clit returns to a more normal size, but retains a bit of extra volume.", false);
			player.clitLength += .2;
		}
		//Mention that clit doesn't grow if your big enough.
		else outputText("In time it returns to it's normal size, losing all the extra volume.", false);
		if(player.vaginas[0].vaginalLooseness == 0) player.vaginas[0].vaginalLooseness = 1;
		slimeFeed();
		if(gameState > 0) eventParser(5007);
		else doNext(13);
	}
	//Flower fun-times
	if(eventNo == 2012) {
		//Sex scenes for those with cawks
		if(player.gender == 1 || player.gender == 3) {
			//Single Cawk
			if(player.cocks.length == 1) {
				outputText("You grin to yourself as you decide to see just how close to a pussy these perverted little flowers are.  The thick stem bends with ease as you grasp it and bend it towards your groin, your other hand fumbling to open your " + player.armorName + ". In seconds you free yourself and gingerly bring the folds closer, the musky scent that fills the air rapidly bringing you to a full, throbbing hardness. The ", true);
				outputText("first touch of petals to your skin slicks you with the flower's silky secretions, allowing you to easily slip between the petals. Though the flower looks fairly deep, you quickly feel yourself bottom out inside the petal's slippery grip. Shrugging, you decide to make the best of it and begin thrusting into the plant, enjoying the unusual sensations along the front-most parts of your " + cockDescript(0) + ". As ", false);
				outputText("you pound away, you begin to notice a change in the rear of the flower.\n\n", false);
				//New PG
				outputText("It feels as if something is opening up, and the tip of your cock begins slipping through a tight ring, bulging the plant's stem noticeably. The sudden change worries you enough to pull back for a moment, your " + cockDescript(0) + " nearly clearing the opening before dozens of tiny whip-like tendrils burst from the flower, wrapping your maleness with painful tightness. They constrict further and with a burst of movement, slam the flower down onto your " + cockDescript(0) + ", pulling you further and further into the stem with painful force. You struggle briefly but the pain it causes your ", false);
				outputText("over-stimulated member is too much, so you just give up, letting the pussy-like plant draw the last of you inside its stem, the silken flowers cupping around your ", false);
				if(player.balls > 0) outputText("balls and gently squeezing them.\n\n", false);
				else outputText("groin and gently squeezing your taint.\n\n", false);
				//New PG
				outputText("You feel a flood of wetness surge up from the depths of the plant, surrounding your member with even more fluid as the stem begins constricting and squeezing. Gently at first, and then with increasing insistence, a suction builds inside the stem, drawing more and more blood into your " + cockDescript(0) + ". The stem, now heavily distended by your massive member, continues rippling, squeezing, and sucking your over-engorged meat-pole, overwhelming your mind with sensation far beyond normal. You'd wonder just what kind of tactile-enhancing fluids that plant excretes, if you weren't already mindlessly pistoning against the tainted plant, still locked inside it by tight little tentacles.\n\n", false);
				//new PG
				outputText("You cum, and cum, and cum, the evidence of your pleasure devoured by the plant's sucking, squeezing gullet. The orgasm drags on for what feels like forever, your " + player.legs() + " eventually giving out, your hips the only muscle that seems to work as they twitch into the air, as if begging for more. You are milked of a few last big spurts, at last collapsing.\n\n", false);
				//New PG
				outputText("The tendrils encircling your genitals do not release, instead they pull tighter, one of the tiny plant's appendages penetrating your urethra, squirming up the cum slick passage with uncomfortable slowness. You lay there, too weak to resist it or fight, hoping that whatever the plant is doing won't hurt much. You feel it twisting and coiling inside you... until it stops. You feel a sharp pinch, and then it withdraws, seemingly satisfied. The tendrils unwrap, allowing the plant to spring back up, exposing your still over-engorged and sensitive member.\n\n", false);
				//New PG
				outputText("You lay there for some time until your muscle control returns, your cock still slightly over-large ", false);
				if(player.balls >= 2) outputText("and your " + ballsDescriptLight() + " ", false);
				else outputText("and ", false);
				outputText("feeling sore from the exertion. At least you hope it's just from the exertion and not from whatever the plant did.\n\n", false);
				if(player.cumQ() < 25) outputText("As you depart, you notice the plant looking remarkably colorful and healthy...", false);
				if(player.cumQ() >= 25 && player.cumQ() < 250) outputText("As you depart, you notice the plant's stalk bulging slightly from your deposit.", false);
				if(player.cumQ() >= 250 && player.cumQ() < 500) outputText("As you depart, you note the plant's stalk bulging obscenely, bits of your seed dripping from the flower's opening.", false);
				if(player.cumQ() >= 500) outputText("As you depart, you note the plant's stalk bulging out obscenely, looking like an overfull balloon.  It's stretched so thin as to be transparent, your cum sloshing about inside it as it attempts to digest it's meal. Steady streams of your jism leak from the flower's lips, unable to keep it all inside.", false);
			}
			//Multicock
			else {
				outputText("You grin to yourself as you decide to see just how close to a pussy these perverted little flowers are.  The thick stems bends with ease as you grab a few with your hand and pull them towards your groin, your other hand fumbling to open your " + player.armorName + ". In seconds you free yourself, and gingerly bring the folds closer.  The musky scent filling the air rapidly brings your " + multiCockDescriptLight() + " to a full, throbbing hardness. The first touch of petals to your skin slicks you with the flower's silky secretions, allowing you to easily slip between the petals. Though the flowers look fairly deep, you quickly feel yourself bottom out inside the petals' slippery grip. Shrugging, you decide to make the best of it and begin thrusting into the plant, enjoying the unusual sensations along the front-most parts of your " + multiCockDescriptLight() + ". As you pound away, you begin to notice a change in the rear of the flowers.\n\n", true);
				outputText("They seem to be gradually opening up, allowing the smallest of your cock-tips to begin slipping through an opening in the backs of the flowers and into the stems.  Shocked by this unexpected development, you pull the bundle of flowers from your " + multiCockDescriptLight() + ", but whiplike tendrils shoot forth from deep within the flowers, wrapping tightly around your manhoods, painfully squeezing as they drag your " + multiCockDescriptLight() + " back into the tight vaginal openings.  They pull tighter as they force you deeper inside the plant, pulling the full length of each of your members into the constricting stalks.   Wrapped tightly around your base, the tendrils form effective cock-rings, making each of your " + multiCockDescriptLight() + " overfill with blood.\n\n", false);
				outputText("You briefly try to free yourself but the pain it causes your groin overwhelms you.  Resigned to your fate, you allow the plants to wrap their petals fully around your groin, encapsulating all of your maleness.  With surprising gentleness, you feel a suction and squeezing building around each and every one of your dicks.  You feel a flood of fluids around each over-engorged member, making them tingle with unnatural sensitivity.  The squeezing and sucking of the plant's stalks, combined with the sudden onset of strange sensation, is too much to bear.  You feel a churning pressure at the base of your groin, liquid heat filling every member as your body makes ready to give these plants what they want.\n\n", false);
				outputText("You cum, and cum, and cum, the evidence of your pleasure devoured by the plant's sucking, squeezing gullet. The orgasm drags on for what feels like forever, your " + player.legs() + " eventually giving out, your hips the only muscle that seems to work as they twitch into the air, as if begging for more. You are milked of a few last big spurts, at last collapsing.\n\n", false);
				outputText("The tendrils encircling your genitals do not release, instead they pull tighter, one of each plant's tiny appendages penetrating your urethras, squirming up your cum slick passages with uncomfortable slowness.  You lay there, too weak to resist it or fight, hoping that whatever the plants are doing won't hurt much. You feel it twisting and coiling inside you... until it stops. You feel a sharp pinch, and then it withdraws, seemingly satisfied. The tendrils unwrap, allowing the plants to spring back up, exposing your still over-engorged and sensitive members.\n\n", false);
				outputText("You lay there for some time until your muscle control returns, your cock still slightly over-large ", false);
				if(player.balls >= 2) outputText("and your " + ballsDescriptLight() + " ", false);
				else outputText("and ", false);
				outputText("feeling sore from the exertion. At least you hope it's just from the exertion and not from whatever the plant did.\n\n", false);
				if(player.cumQ() < 25) outputText("As you depart, you notice the plants looking remarkably colorful and healthy...", false);
				if(player.cumQ() >= 25 && player.cumQ() < 250) outputText("As you depart, you notice the plants' stalks bulging slightly from your deposit, their flowers wet with moisture and bright red.", false);
				if(player.cumQ() >= 250 && player.cumQ() < 500) outputText("As you depart, you note the plants' stalks bulging obscenely, bits of your seed dripping from the flowers' opening.", false);
				if(player.cumQ() >= 500) outputText("As you depart, you note the plants' stalks bulging out obscenely, looking like overfull balloons.  They're stretched so thin as to be transparent, your cum sloshing about inside them as they attempt to digest their meals. Steady streams of your jism leak from the flowers' lips, unable to keep it all inside.", false);				
			}
			//Stat changes!
			stats(0,0,0,0,0,2,-100,0);
			var booster:Number = 1;
			if(player.balls == 0) booster += 3;
			else if(player.ballSize < 6) booster += 2;
			if(player.hasPerk("Messy Orgasms") >= 0 && player.cumMultiplier < 3) booster += 1;
			player.cumMultiplier += booster;			
		}
		//Oral sex for those without!
		else {
			outputText("You grin to yourself and decide to sample the fine smelling nectar of the flowers. You grip the unusually thick stalk as you lean down, taking in the bright red and iridescent purples of the pussy-flower's petals. You give it an experimental lick, gaining a feeling for the flavor of the nectar. It's delicious, but leaves your tongue tingling and sensitive. A small budding protrusion emerges from between the petals, slick with more of the plants fluid, cherry red and looking very much like an engorged clit.\n\n", true);
			//New PG
			outputText("Giddy from either the novelty of the situation or the chemicals in the flower's juices, you lick at the plant's bud-like clit and are immediately rewarded with a burst of fruity plant-nectar. The taste becomes the last thing on your mind as your tongue becomes even more sensitive, every touch and taste rapidly becoming highly erotic. You delve into it's folds, seeking more nectar, your tongue slurping and licking, noisily tongue-fucking the little plant. The taste deepens, losing some of the sweetness as that clitty swells bigger, drops of tangy moisture oozing from it.\n\n", false);
			//New PG
			outputText("Closing your eyes, it becomes easy to lose yourself in the feeling of plunging in and out of those petals, your tongue a tiny cock. You revel in the decadence of it all, your lips becoming equally sensitive and engorged, french kissing the pussy-flower with abandon, rubbing your puffy lips over it's clit, tongue-fucking the flower with abandon. The petals curl around your face, as a sudden gush of fluid rushes out from deep within the flower, flooding your mouth with tangy sweetness. Your tongue quivers in pleasure as you feel your over-sensitized mouth orgasming, pleasurable and unlike anything else you've experienced. Swallowing instinctively, you collapse back on your haunches, licking your lips and squirming in satisfaction.", false);
			//Last PG
			outputText("You walk away, your lips and tongue feeling slightly puffy and sensitive, but none the worse for the wear.", false);
			slimeFeed();
			stats(0,0,0,0,0,4,-100,1);
		}
		doNext(13);
	}
	//Tentacle fun-times
	if(eventNo == 2013) {
		//Vaginal Variant 50% of the time
		if(player.vaginas.length > 0 && rand(2) == 0 ) {
			outputText("You saunter over to a dangling group of perverted looking vines, discarding your " + player.armorName + " along the way. Running your fingertips along the bulbous-tipped tentacle-like vines, you find one that looks ", true);
			//Big medium or small
			temp = rand(3);
			//Normal
			if(temp == 0) {
				outputText("well suited to your ", false);
				//determine size
				if(player.vaginas[0].vaginalLooseness == 0) temp2 = 3;
				if(player.vaginas[0].vaginalLooseness == 1) temp2 = 6.5;
				if(player.vaginas[0].vaginalLooseness == 2) temp2 = 26;
				if(player.vaginas[0].vaginalLooseness == 3) temp2 = 60;
				if(player.vaginas[0].vaginalLooseness == 4) temp2 = 115;
				if(player.vaginas[0].vaginalLooseness == 5) temp2 = 175;
			}
			//Small
			if(temp == 1) {
				outputText("a little small for your ", false);
				//determine size
				if(player.vaginas[0].vaginalLooseness == 0) temp2 = 0;
				if(player.vaginas[0].vaginalLooseness == 1) temp2 = 4;
				if(player.vaginas[0].vaginalLooseness == 2) temp2 = 16;
				if(player.vaginas[0].vaginalLooseness == 3) temp2 = 40;
				if(player.vaginas[0].vaginalLooseness == 4) temp2 = 65;
				if(player.vaginas[0].vaginalLooseness == 5) temp2 = 100;
			}
			//Large
			if(temp == 2) {
				outputText("almost too big to cram in your ", false);
				//determine size
				if(player.vaginas[0].vaginalLooseness == 0) temp2 = 6;
				if(player.vaginas[0].vaginalLooseness == 1) temp2 = 9;
				if(player.vaginas[0].vaginalLooseness == 2) temp2 = 34;
				if(player.vaginas[0].vaginalLooseness == 3) temp2 = 78;
				if(player.vaginas[0].vaginalLooseness == 4) temp2 = 135;
				if(player.vaginas[0].vaginalLooseness == 5) temp2 = 210;
			}
			//resume secksings
			outputText(vaginaDescript(0) + ". Yanking gently, you manage to yank a bit more vine free, allowing it to brush against the damp forest loam. That same soft earth makes the perfect cushion for you as you lay down, spreading your legs. With both hands you grasp the vine, guiding it towards the entrance of your " + vaginaDescript(0) + ". The beaded moisture that covers the vine tingles tantalizingly at the first contact with your lips.\n\n", false);
			//new PG
			//Small
			if(temp == 1) outputText("With a sexy little sigh, you slip the mushroom-like tip between your nether-lips, feeling it bulge a little as it penetrates you. The vine's lubricants combine with your own, turning your horny cunt into a sloppy little slip-and-slide. You take it all the way to your cervix, easily handling it's smaller size as you begin to use it like a favorite dildo. Deep inside your " + vaginaDescript(0) + ", the vine's lubricants begin to make your passage tingle, intensifying until your entire channel is overloaded with clit-like levels of sensation.\n\n", false);
			//Medium
			if(temp == 0) outputText("With a soft grunt, you manage to wrangle the fat tip of the vine between your nether-lips, feeling the swollen bulge pulse inside you penetrate yourself with it. The vine's lubricants combine with your own, turning your horny cunt into a sloppy slip-and-slide. You force in the rest of the vine's length, taking it all the way to your cervix, enjoying the feeling of fullness it gives you as you begin pumping it in and out like an obscene green dildo. Deep inside your " + vaginaDescript(0) + ", the vine's lubricants begin to make your passage tingle, intensifying until your entire channel is overloaded with clit-like levels of sensation.\n\n", false);
			//Large
			if(temp == 2) outputText("With a desperate grunt, you barely manage to force the obscene cock-head of the vine between your nether-lips. The swollen bulge pulses inside you, stretching you uncomfortably as it reacts to the warmth and tightness of your " + vaginaDescript(0) + ". The vine's lubricants begin to combine with your own, rapidly transforming your horny cunt into a sloppy slip-and-slide. You manage to cram the vine the rest of the way inside, bottoming it out against your cervix, reveling in the feeling of being stretched so wide, as you begin pumping it in and out of your " + vaginaDescript(0) + " like an over-sized sex-toy. Deep inside your " + vaginaDescript(0) + ", the vine's lubricants begin to make your passage tingle, intensifying until your entire channel is overloaded with clit-like levels of sensation.\n\n", false);
			//Stretch cuuuuunt and newline if it gets stretched
			if(cuntChange(temp2, true)) outputText("\n\n", false);
			//New PG
			outputText("The rest of the world disappears as your mind tries to cope with the sensation overload coming from your groin. You're dimly aware of your hands pumping the slippery vine in and out, in and out, over and over.  Hips bucking, " + vaginaDescript(0) + " squeezing, thighs trembling, you achieve the first of many orgasms.  Incredibly, the sensitivity of your groin redoubles, nearly blacking you out from the pleasure.  Cumming over and over, you writhe in the dirt, pumping the corrupted prick-vine in and out of your spasming cunt.  Your eyes roll back in your head when the vine begins pumping you full of its strange fluid, and you finally lose your battle to remain conscious.\n\n", false);
			//New PG
			outputText("An hour or two later, you wake feeling very sore, but satisfied.  The vine must have popped free at some point and the bulb now rests on your pussy lips.  You go to brush it off and nearly orgasm from touching your nether-lips, still sensitive and parted from the overlarge tentacle they so recently took.  A rush of white goop escapes from between your thighs as you stand, soaking back into the soil immediately.   A quick stretch later, you don your gear and head back to camp with a smile.\n\n", false);
			//Normal stat changes
			slimeFeed();
			stats(0,0,0,0,0,5,-100, 2);
			//Xforms
			//Change hair to green sometimes
			if(rand(3) == 0 && player.hairColor != "green") {
				temp++;
				outputText("You don't get far before you realize all the hair on your body has shifted to a verdant green color.  <b>You now have green hair.</b>  ", false);
				player.hairColor = "green";
			}
			//+hip up to 10
			if(rand(4) == 0 && player.hipRating <= 10) {
				temp++;
				outputText("A strange shifting occurs below your waist, making your " + player.armorName + " feel tight.  <b>Your hips have grown larger</b>, becoming " + hipDescript() + ".  ", false);
				player.hipRating += rand(3) + 1;
				player.fertility++;
			}
			doNext(13);
		}
		else {
			outputText("You approach the swollen vines, noting a drizzle of fluid leaking from one of the bulbous and mushroom-like tips.   Licking your lips as you approach, you feel your heart beat faster in anticipation of sampling the tainted flora of the glade.   Grasping one gently, you lift it up, noting the pebbly texture along the curvature of its head, and the soft nubs on the underside where it rejoins the stalk.  The whole thing feels moist, just barely lubricated with some fluid that the plant seems to sweat.\n\n", true);
			//new PG
			outputText("Pulling it closer, you open your mouth wide enough to take in the plant, slipping it between your lips.  The taste of the plant is starchy with a tangy aftertaste.  You run your tongue around it lewdly, your efforts swiftly rewarded by a spurt of salty cream.   The penis vine seems more receptive to your actions than the real thing, shifting color to a rapidly darkening pink.  You begin jacking the vine off with your hands, rubbing a fingertip where the 'bulb' joins the stalk.  In no time it starts spurting seed into your throat, bright crimson spreading back along the vine as thick bulges of goo are pumped down the vine.  The bulb in your mouth swells up like a balloon, wrenching your jaws apart and trapping itself behind your teeth.   You're forced to breathe through your nose as it rapidly plugs your oral opening, gulping down each load of throat-filling seed in an effort not to choke.\n\n", false);
			//New PG
			outputText("You wonder if your efforts are in vain as time passes and your stomach fills with strange alien fluids.  Feeling faint from lack of oxygen, you drop to your knees, throat working overtime to swallow and breathe, only to immediately swallow another load.   Your whole body burns from the effort.  Your lungs hurt, your heart spasms, and your gut gurgles as it takes in the strange liquid.   Nearly unconscious, you sway, the vine pulled tight in your mouth, supporting the weight of your body.\n\n", false);
			//New PG
			outputText("With a snap you feel consciousness return, the endless torrent of fluid has stopped, though your mouth is still pried wide open by the engorged bulb.  In panic, you thrash backwards, painfully yanking against the now-taut vine.  You struggle in vain a moment, the vine not giving an inch, until finally you feel the bulb start to soften.  Working it back and forth, you eventually manage to pry it free with a satisfying 'pop'.   Rubbing your hand against your sore jawline, you step away from the glade, spitting out some of the musky goop with every step.\n\n", false);
			//Last PG includes change-texts
			outputText("As you leave the corrupted plant-life behind a comforting warmth seems to radiate from your gut, suffusing you with gentle heat that makes your ", false);
			//Cocks (and maybe vagina)
			if(player.cocks.length > 0) {
				if(player.cocks.length == 1) outputText(cockDescript(0), false);
				if(player.cocks.length > 1) outputText(multiCockDescriptLight(), false);
				if(player.vaginas.length > 0) outputText(" and " + vaginaDescript(0), false);
			}
			//Vagina
			else if(player.vaginas.length > 0) outputText(vaginaDescript(0), false);
			//nipples
			else if(player.vaginas.length == 0 && player.cocks.length == 0) outputText("nipples", false);
			//Finish sentance
			outputText(" tingle.  ", false);
			//Simple stat changes - + lust.
			stats(0,0,0,0,0,0,25 + player.lib/10, 2);
			//Changes start, counted with temp
			temp = 0;
			slimeFeed();
			//Change hair to green sometimes
			if(rand(3) == 0 && player.hairColor != "green") {
				temp++;
				outputText("You don't get far before you realize all the hair on your body has shifted to a verdant green color.  <b>You now have green hair.</b>  ", false);
				player.hairColor = "green";
			}
			//+butt up to 10
			if(rand(4) == 0 && player.buttRating <= 10) {
				temp++;
				outputText("A strange shifting occurs on your backside, making your " + player.armorName + " feel tight.  <b>Your butt has grown larger</b>, becoming a " + buttDescript() + ".  ", false);
				player.buttRating += rand(3) + 1;
			}
			//Rarely change one prick to a vine-like tentacle cock. 
			if(rand(3) == 0 && player.cocks.length > 0 && player.hairColor == "green") {
				if(player.tentacleCocks() < player.cockTotal()) {
					//Single cawks
					if(player.cocks.length == 1) {
						outputText("Your feel your " + cockDescript(0) + " bending and flexing of its own volition... looking down, you see it morph into a green vine-like shape.  <b>You now have a tentacle cock!</b>  ", false);
						//Set primary cock flag
						player.cocks[0].cockType = 4;
						temp++;
					}
					//multi
					if(player.cockTotal() > 1) {
						outputText("Your feel your " + multiCockDescriptLight() + " bending and flexing of their own volition... looking down, you watch them morph into flexible vine-like shapes.  <b>You now have green tentacle cocks!</b>  ", false);
						temp2 = player.cocks.length;
						//Set cock flags
						while(temp2 > 0) {
							temp2--;
							player.cocks[temp2].cockType = 4;
						}
						temp++;
					}				
				}
			}
			doNext(13);
		}		
	}
	//Tree Boob fun-times
	if(eventNo == 2014) {
		//UNFINISHED
	}
	//A WILD GIACOMO APPEARS
	if(eventNo == 2015) {
		spriteSelect(23);
		//set gamestate to 4, used for making item looting function with his shop
		gameState = 4;
		if(giacomo > 0) {
			//If infested && no worm offer yet
			if(player.hasStatusAffect("WormOffer") < 0 && player.hasStatusAffect("infested") >= 0) {
				outputText("Upon walking up to Giacomo's wagon, he turns to look at you and cocks an eyebrow in curiosity and mild amusement.\n\n", true);
				outputText("\"<i>Been playing with creatures best left alone, I see</i>,\" he chuckles. \"<i>Infestations of any kind are annoying, yet your plight is quite challenging given the magnitude of corrupt creatures around here. It is not the first time I have seen one infested with THOSE worms.</i>\"\n\n", false);
				outputText("You ask how he knows of your change and the merchant giggles heartily.\n\n", false);
				outputText("\"<i>Do not look at me as if I am a mystic,</i>\" Giacomo heckles lightly. \"<i>Your crotch is squirming.</i>\"\n\n", false);
				outputText("Looking down, you realize how right he is and attempt to cover yourself in embarrassment.\n\n", false);
				outputText("\"<i>Fear not!</i>\" the purveyor jingles. \"<i>I have something that will cure you of those little bastards. Of course, there is also a chance that it will purge your system in general. This potion is not cheap. I will trade it for 175 gems.</i>\"\n\n", false);
				//Broke as a joke
				if(player.gems < 175) {
					outputText("You realize you don't have enough gems for such a pricey potion, but perhaps there is something else in his inventory you can buy.", false);
					doNext(2015);
				}
				//Can afford
				else {
					outputText("Do you purchase his cure?", false);
					//Remove/No
					doYesNo(2081,2015);
				}
				player.createStatusAffect("WormOffer",0,0,0,0);
				return;
			}
			else {
				outputText("You spy the merchant Giacomo in the distance.  He makes a beeline for you, setting up his shop in moments.  ", true);
				outputText("Giacomo's grin is nothing short of creepy as he offers his wares to you. What are you interested in?", false);
				//If player is infested and knows of the cure..
				if(player.hasStatusAffect("WormOffer") >= 0 && player.hasStatusAffect("infested") >= 0) {
					simpleChoices("Potions", 2016, "Books", 2017, "Erotica", 2018, "Worm Cure", 2082, "Leave", 13);
				}
				//If the cure isnt an option
				else
					simpleChoices("Potions", 2016, "Books", 2017, "Erotica", 2018, "", 0, "Leave", 13);
				statScreenRefresh();
			}
		}
		else {
			outputText("As you travel, you see another person on the road. He is tethered to a small cart that is overloaded with a hodgepodge of items. He is dressed in a very garish manner, having a broad, multicolored hat, brocaded coat and large, striped pantaloons. His appearance is almost comical and contrasts with his severe and hawkish facial features. The man sees you, smiles and stops his cart.\n", true);
			outputText("\"<i>Greetings, traveler! My name is Giacomo. I am, as you can see, a humble purveyor of items, curios and other accoutrements. While I am not in a position to show you my full wares as my shop is packed on this push-cart, I do offer some small trinkets for travelers I meet.</i>\"\n\n", false);
			outputText("The merchant looks at you sharply and cracks a wide, toothy smile you find... unnerving. The merchant twists his way around to access a sack he has around his back. After a moment, he swings the sack from his back to have better access to its contents. Inquisitively, the merchant turns back to you.\n", false)
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
	if(eventNo == 2016) {
		spriteSelect(23);
		outputText("Which potion or tincture will you examine?", true);
		if(player.gender == 2) simpleChoices("Vitality T.", 2019, "Scholar's T.", 2021, "Blank", 0, "", 0, "Back", 2015);
		else simpleChoices("Vitality T.", 2019, "Scholars T.", 2021, "Cerulean P.", 2023, "", 0, "Back", 2015);
		statScreenRefresh();
	}
	//Book list!
	if(eventNo == 2017) {
		spriteSelect(23);
		outputText("Which book are you interested in perusing?", true);
		if(flags[244] > 0) simpleChoices("Dangerous Plants", 2029, "Traveler's Guide", 2031, "Hentai Comic", 2033, "Yoga Guide", 2940, "Back", 2015);
		else simpleChoices("Dangerous Plants", 2029, "Traveler's Guide", 2031, "Hentai Comic", 2033, "", 0, "Back", 2015);
		statScreenRefresh();
	}
	//Erotica List - Sex Toy Choices!
	if(eventNo == 2018) {
		spriteSelect(23);
		outputText("Giacomo's grin is nothing short of creepy as he offers his wares to you. What are you interested in?", true);
		if(player.gender == 1) simpleChoices("Dildo", 2035, "Onahole", 2041, "D Onahole", 2044, "", 0, "Back", 2015);
		if(player.gender == 2) simpleChoices("Dildo", 2035, "Stim-Belt", 2037, "AN Stim-Belt", 2039, "", 0, "Back", 2015);
		if(player.gender == 3) choices("Onahole", 2041, "D Onahole", 2044, "AN Onahole", 2048, "Stim-Belt", 2037, "AN Stim-Belt", 2039, "Dual Belt",2142,"",0,"",0,"Dildo",2035,"Back",2015);
		if(player.gender == 0) simpleChoices("Dildo",2035, "Onahole", 2041, "Stim-Belt", 2037, "", 0, "Back", 2015);
		statScreenRefresh();
	}	
	//Vitality tincture pitch
	if(eventNo == 2019) {
		spriteSelect(23);
		outputText("Giacomo holds up the item and says, \"<i>Ah, yes! The quintessential elixir for all travelers, this little bottle of distilled livelihood will aid you in restoring your energy on your journey and, should you be hurt or injured, will aid the body's ability to heal itself. Yes ", true);
		if(player.gender == 1) outputText("sir, ", false);
		if(player.gender == 2 || player.gender == 3) outputText("madam, ", false);
		outputText("this is liquid gold for pilgrim and adventurer alike. Interested? It is <b>15 gems</b></i>.\"  ", false);
		doYesNo(2020, 2016);
	}
	//vitality tincture purchase
	if(eventNo == 2020) {
		spriteSelect(23);
		if(player.gems < 15) {
			outputText("\n\nGiacomo sighs, indicating you need " + String(15 - player.gems) + " more gems to purchase this item.", true);
			doNext(2016);
		}
		else
		{
			player.gems-=15;
			shortName = "Vital T";
			takeItem();
			statScreenRefresh();
		}
	}
	//Pitch Scholar's Tea
	if(eventNo == 2021) {
		spriteSelect(23);
		outputText("Giacomo holds up a pouch of dried, fragrant leaves and begins his spiel, \"<i>Have you ever wondered how scholars and other smart folk keep up such a mental effort for so long? They make a tea out of this fine mixture of quality plants and herbs. Nothing but the best, this mysterious mixture of herbs in its Orange Pekoe base makes anyone, short of a lummox, as brainy as the finest minds of the land. All you do is steep the leaves in some water and drink up! Hot or cold, straight or sweetened with honey, your mind will run circles around itself once it has this for fuel. Buy it now and I will throw in the strainer for free!  Interested? Only <b>15 gems</b>!</i>\"  ", true);
		doYesNo(2022, 2016);
	}
	//Purchase Scholar's Tea
	if(eventNo == 2022) {
		spriteSelect(23);
		if(player.gems < 15) {
			outputText("\n\nGiacomo sighs, indicating you need " + String(15 - player.gems) + " more gems to purchase this item.  ", true);
			doNext(2016);
		}
		else
		{
			player.gems-=15;
			shortName = "Smart T";
			takeItem();
			statScreenRefresh();
		}
	}
	//Pitch cerulean potion
	if(eventNo == 2023) {
		spriteSelect(23);
		outputText("Giacomo makes his comical over-the-shoulder search and holds up a sky-blue bottle. He grins widely as he begins his pitch, \"<i>My friend, you truly have a discerning eye. Even the most successful of men seek to attract more women for pleasure and status. This, my friend, will attract the most discerning and aroused of women. Women attracted by this fine unction will NEVER say no. I GUARANTEE that she will want pleasure every time you demand pleasure! A bit of a caution to you, brother. Some say this works TOO well. If you aren't man enough to handle the women this urn draws to you, you'd best say so now and I will offer something more to your liking. However, if you have the heart for it, I can sell you this little gem for <b>75 gems</b></i>!\"  ", true);
		doYesNo(2024, 2016);
	}
	//Purchase cerulean potion
	if(eventNo == 2024) {
		spriteSelect(23);
		if(player.gems < 75) {
			outputText("\n\nGiacomo sighs, indicating you need " + String(75 - player.gems) + " more gems to purchase this item.", true);
			doNext(2016);
		}
		else
		{
			shortName = "Cerul P";
			takeItem();
			player.gems-=75;
			statScreenRefresh();
		}
	}
	//Cerulean Potion Normal Variant!
	if(eventNo == 2025) {
		spriteSelect(8);
		outputText("\nAs you sleep, your rest becomes increasingly disturbed. You feel a great weight on top of you and you find it difficult to breathe. Stirred to consciousness, your eyes are greeted by an enormous pair of blue tinged breasts. The nipples are quite long and thick and are surrounded by large, round areola. A deep, feminine voice breaks the silence. \"<i>I was wondering if you would wake up.</i>\" You turn your head to the voice to see the visage of a sharp-featured, attractive woman. The woman grins mischievously and speaks again. \"<i>I was hoping that idiot, Giacomo, did not dilute the 'potion' again.</i>\" Your campfire reflects off the woman's face and her beauty contains some sharply contrasting features. The pupils of her eyes are slit like a cat's. As she grins, she bares her teeth, which contain two pairs of long and short fangs. This woman is clearly NOT human! In shock, you attempt to get up, only prompting the woman to prove her inhuman nature by grabbing your shoulders and pinning you to the ground. You see that each finger on her hand also contains a fourth joint, further proving her status. Before you can speak a word, the woman begins mocking your fear and places her face in front of yours. Her face is almost certainly demonic in nature.\n\n", false);
		if(player.gender == 0) {
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
			flags[62] = 1;
			doNext(1);
			return;
		}
		if(player.gender == 1) outputText("\"<i>Awwww! Did my blue skin and pointy teeth scare you?</i>\" she says in a childish voice. \"<i>Believe me stud, if I wanted to harm you, I would not have let you wake up at all. I am here because you have 'called' me.</i>\" She teases you with the empty blue bottle you bought from the merchant. \"<i>My essence is in this bottle. Any man who drinks this, I am compelled to return the pleasure by drinking his.</i>\" The demon woman reaches her skinny hand down to your crotch where you see you have become fiercely erect. The demon gently strokes your cock until you begin oozing generous amounts of your own natural lubricants. The demon takes one of her massive breasts and teases you with her fat nipples. \"<i>Open your mouth,</i>\" she demands. \"<i>Take me into your mouth as I will soon take you into mine.</i>\"\n\n", false);
		else if(player.gender == 3) {
			flags[111]++;
			outputText("\nIt is obvious that you have been confronted by a succubus. As the fire illuminates your captor, her grin widens broadly.\n\n", false);

			outputText("\"<i>Well, well, well!</i>\" the Succubus jingles. \"<i>What have we here?! A little girl with a big cock!</i>\"\n\n", false);

			outputText("As the Succubus looks down at your " + cockDescript(0) + ", you have quickly achieved one of the healthiest erections you have ever had. The succubus quickly poises her hairy hole over your member and allows her weight to force your dick into her womb. The demoness rests her weight in her lap as she allows you to fully penetrate her. Her womb is hot, wet and her muscles have your prick in one of the strongest grips imaginable. Even if you went totally limp, withdrawal would be an impossibility. Wincing at the sudden crushing force of her vaginal muscles, the succubus giggles inhumanly.\n\n", false);

			outputText("\"<i>Quit whimpering,</i>\" the Succubus orders. \"<i>I hope the rumors about you futas are true. I need a good, fiery load of cum to get me going. I haven't had one in a while and as much as I LOVE men, they can only feed me so much.</i>\"\n\n", false);

			outputText("You quickly try to struggle, but find the Succubus to be utterly dominating. She wraps her arms around your back and entwines her lean legs around your hips. The Succubus playfully licks your lips and grins.\n\n", false);

			outputText("\"<i>You are getting your dick milked,</i>\" the Succubus says flatly, \"<i>Accept it. Trust me, when I am done, you will want more of me, anyway.</i>\"\n\n", false);

			outputText("As the Succubus finishes her ultimatum, you feel churning vaginal contractions stroking your massive cock. Heavy, powerful, coordinated undulations work your dick as surely as the best handjob. You quickly moan in shock and pleasure at such rough treatment.", false);
		}
		stats(0, 0, 0, 0, 0, 0, 35, 0);
		doNext(2026);			
	}
	//Cerulean potion continued
	if(eventNo == 2026) {
		outputText("", true);
		spriteSelect(8);
		if(player.gender == 1) {
			outputText("Your natural instincts immediately take over and you open your mouth and allow her nipple inside. Immediately, your mouth has a mind of its own as you press your head firmly into her breast and begin suckling the unnaturally long teat like a starving baby. The demon-woman laughs in satisfaction. \"<i>To think, that you believed me to do you harm!</i>\" she taunts. \"<i>Drink, little man. Feed your lust as you will soon feed mine.</i>\" Immediately, you feel her milk flood your mouth. Its taste immediately reminds you of the potion you got from Giacomo. You realize the potion was not a potion at all, but this demon's breast milk! Concerned only for your blind libido, the suction of your mouth coaxes torrents of the devil's fluid into your mouth and down your throat. She continues teasing your cock only enough to maintain your erection. In time, your stomach signals that you are full and you break the seal from her tit, making a loud 'pop'.   She briefly hoses you down with milk, soaking you.\n\n", true);
			outputText("The demon has a satisfied look on her face. \"<i>Did I taste good? Was I wholesome and fulfilling?</i>\" she asks. \"<i>Since you have fed from my life-milk, it is only fair that I do the same. To be fair, 'yes', I am as fierce as I look and I will leave you sore and insensible. However, I do so to pleasure you and feed myself. Accept it and be happy.</i>\" She gives you another inhumanly toothy grin and kisses you deeply. A small pang of fear still shoots through you as you feel the sharpness of her teeth. She breaks away from your lips and sighs in excitement. \"<i>Now, I FEED!</i>\" she utters jubilantly.", false);
		}
		else {
			outputText("\"<i>See,</i>\" the Succubus says triumphantly, \"<i>You are already enjoying it. You don't even have to hump. My cunt does all the work. Try THAT with a human woman. Good fucking luck. Half of them don't even know how to keep a prick hard once it's inside them and then they bitch because THEY didn't cum.</i>\"\n\n", false);

			outputText("The fierce milking continues for several minutes until you reflexively buck your hips as your inner organs fill with the white, milky life-water the demoness demands in order to slake her thirst. Quick to take notice of your muscular reaction, the succubus snickers.\n\n", false);

			outputText("\"<i>Ready to burst, are you?</i>\" the Succubus playfully challenges. \"<i>Well, then. No reason for you to hold back.</i>\"", false);
		}
		stats(0, .3, 0, 0, .5, .5, 5, 1);
		doNext(2027);
	}
	//Cerulean potion continued
	if(eventNo == 2027) {
		outputText("", true);
		spriteSelect(8);
		if(player.gender == 1) {
			outputText("Rotating herself into a 69 position, she seizes your throbbing member and effortlessly begins deep throating. Her thighs wrap around your head and confront you with her surprisingly hairy pussy. Her clitoris is long and erect, begging for attention and the smell of her pheromones enslaves you. You bury your face into her furry mound, ignoring your normal revulsion to such an unshaved state and begin eating her as well as any woman you have ever pleased. The demon takes your cock out of her mouth to cry in delight. \"<i>YES, LITTLE MAN!</i>\" she screams. \"<i>LICK ME! TEASE ME! LOVE MY WOMB WITH YOUR TONGUE!!!!</i>\" She responds by clamping her mouth around the head of your penis and sucking smartly. A sharp pain in your ass signals the entry of her bony fingers working their way to your inner manhood. Finding the root of your sex easily, she mashes down to force you to cum.\n\n", true);
			outputText("Finding it impossible to resist such pleasure, you immediately begin cumming. Glob after glob, stream after stream of your semen shoots into the woman's mouth. Her timed sucking ensures that she swallows each drop as you launch it into her. While you have been proud of the ability to cum in a woman for over a minute, you are wracked with both pain and pleasure as your ejaculations continue for almost ten. Once you have spent your last, the demon releases your penis to bear down on your face with her thighs and unloads a massive squirting orgasm. Your face is soaked with pussy juice as you see her cunt spasm from the force of her pleasure. The sight of her rhythmic muscles is hypnotic. She then promptly removes her finger from your ass.", false);
		}
		else {
			outputText("The Succubus rears up and pins your shoulders firmly to the ground. The speed of her vaginal contractions becomes impossibly fast. As you look down at the Succubus' crotch, you can clearly see her contractions working your penis despite the massive growth of fur between your legs. The pressure deep behind your cock is crushing. With one last spasmodic push, you release a thick, superhuman gout of semen deep in the Succubus' cunt. She lets out an inhuman howl of pleasure as her womb clamps down upon you like a vise.  She literally squeezes each stream and drop of cum out of you.\n\n", false); 

			outputText("After a couple of minutes, you feel your dick weaken and begin going limp. Satisfied, you feel the Succubus' grip on your prick release and you quickly fall out of her womb. Much to your surprise, despite the massive load you released, not a single drop of cum falls out or is left on your prick. The Succubus begins rubbing herself all over, clearly in post-orgasmic ecstasy from absorbing your fluids. After a couple of chain-orgasms, the Succubus sits down next to the empty jar.\n\n", false);

			outputText("She places the mouth of the jar next to one of her fat nipples and begins milking her tit into the jar, filling it back up with her fluids. She places the jar next to you and stands up.\n\n", false);

			outputText("\"<i>It has been a long time since I soaked up a load that good,</i>\" she says, \"<i>Anytime you want more of that, just drink my milk again. It's only fair. I take your milk, you take mine.</i>\"\n\n", false);

			outputText("She smiles and flies off, leaving you with a fresh bottle of \"Cerulean Potion\". As pleasing as the experience was, it has left you thoroughly exhausted.", false);
			//[Mechanics: Corruption increase same as male counterpart. No hit point recover for that night. When fatigue model is implemented, no fatigue recovery and add 25 points]
		}
		fatigue(20);
		stats(0, 0, 0, 0, .5, 0, -100, 0);
		doNext(2028);
	}
	//Succubi 
	if(eventNo == 2028) {
		outputText("", true);
		spriteSelect(8);
		if(player.gender == 1) {
			outputText("She stands up and helps you to your feet. While dazed, ", true);
			if(player.tallness < 80) outputText("you see that she towers over you. She must stand well over seven feet in height. ", false);
			if(player.tallness >= 80 && player.tallness < 90) outputText("you see she is about as tall as you - around seven feet in height. ", false);
			if(player.tallness >= 90) outputText("you see she's definitely shorter than you, only about seven feet tall. ", false);
			outputText("She braces you against a tree and picks up the empty potion bottle. Grabbing the tit you ignored during the unholy tryst, she pokes her nipple into the bottle and squeezes for about a minute. Satisfied, she corks the bottle and hands it to you. She begins licking her nectar off your face. \"<i>You have pleased me, little man,</i>\" she coos. \"<i>It is a rare thing indeed for one of my meals to pleasure me so. If you ever desire for me again, all you need is to drink my milk. I will appear forthwith to let you suckle me and I will suckle you! We will feed each other and grow stronger for the effort!</i>\" ", false);
			outputText(" She gives a giggle and disappears before your eyes. At that moment the fatigue from the massive fucking you received catches up with you and you pass out in a slump.", false);
			stats(.5, 0, 0, 0, 0, 0, 4, 0);
		}
		shortName = "Cerul P";
		takeItem();
	}
	//Dangerous Plants Pitch
	if(eventNo == 2029) {
		spriteSelect(23);
		if(player.hasKeyItem("Dangerous Plants") >= 0) {
			outputText("<b>You already own the book 'Dangerous Plants'.</b>", true);
			doNext(2017);
			return;
		}
		outputText("Giacomo proudly holds up a small text. The cover is plain and unadorned with artwork. \"<i>According to the scholars,</i>\" Giacomo begins, \"<i>knowledge is power. It is one of the few things that scholars say that I agree with. You cannot survive in today's world without knowing something of it. Beasts and men are not your only problems. This book specializes in the dangerous plants of the realm.  There exists flora the likes of which will chew you up and spit you out faster than any pack of wolves or gang of thieves. For the small price of 10 gems, you can benefit from this fine book on the nastiest blossoms in existence. Care to broaden your learning?</i>\"", true);
		doYesNo(2030, 2017);
	}
	//Dangerous Plants Purchase
	if(eventNo == 2030) {
		spriteSelect(23);
		if(player.hasKeyItem("Dangerous Plants") >= 0) {
			outputText("<b>You already own the Book 'Dangerous Plants'.</b>", true);
			doNext(2017);
			return;
		}
		if(player.gems < 10) {
			outputText("\n\nGiacomo sighs, indicating you need " + String(10 - player.gems) + " more gems to purchase this item.", true);
			doNext(2017);
		}
		else
		{
			outputText("You consider yourself fortunate to be quite literate in this day and age. It certainly comes in handy with this book. Obviously written by well-informed, but women-starved men, the narrative drearily states the various types of poisonous and carnivorous plants in the world. One entry that really grabs you is the chapter on 'Violation Plants'. The chapter drones on about an entire classification of specially bred plants whose purpose is to torture or feed off a human being without permanently injuring and killing them. Most of these plants attempt to try breeding with humans and are insensitive to the intricacies of human reproduction to be of any value, save giving the person no end of hell. These plants range from massive shambling horrors to small plant-animal hybrids that attach themselves to people. As you finish the book, you cannot help but shiver at the many unnatural types of plants out there and wonder what sick bastard created such monstrosities. ", true);
			doNext(2017);
			player.gems-=10;
			player.createKeyItem("Dangerous Plants",0,0,0,0);
			statScreenRefresh();
		}
	}
	//Traveler's Guide - Pitch
	if(eventNo == 2031) {
		spriteSelect(23);
		if(player.hasKeyItem("Traveler's Guide") >= 0) {
			outputText("<b>You already own the book 'Traveler's Guide'.</b>", true);
			doNext(2017);
			return;
		}
		outputText("Giacomo holds up a humble pamphlet. \"<i>While you may not find value in this as a seasoned traveler,</i>\", Giacomo opens, \"<i>you never know what you may learn from this handy, dandy information packet! Geared to the novice, this piece of work emphasizes the necessary items and some good rules of thumb for going out into the world. You may not need it, but you may know someone who does. Why waste your time when the answers could be in this handy pamphlet! I will offer the super-cheap price of 1 gem!</i>\"", true);
		doYesNo(2032, 2017);
	}
	//Traveler's Guide Sale
	if(eventNo == 2032) {
		spriteSelect(23);
		if(player.hasKeyItem("Traveler's Guide") >= 0) {
			outputText("<b>You already own the book 'Traveler's Guide'.</b>", true);
			doNext(2017);
			return;
		}
		if(player.gems < 1) {
			outputText("\n\nGiacomo sighs, indicating you need 1 gem to purchase this item.", true);
			doNext(2017);
		}
		else
		{
			outputText("The crazy merchant said you might not need this and he was right. Written at a simple level, this was obviously intended for a city-dweller who never left the confines of their walls. Littered with childish illustrations and silly phrases, the book is informative in the sense that it does tell a person what they need and what to do, but naively downplays the dangers of the forest and from bandits. Were it not so cheap, you would be pissed at the merchant. However, he is right in the fact that giving this to some idiot ignorant of the dangers of the road saves time from having to answer a bunch of stupid questions.", true);
			doNext(2017);
			player.gems-=1;
			player.createKeyItem("Traveler's Guide",0,0,0,0);
			statScreenRefresh();
		}
	}
	//Hentai Comic Pitch
	if(eventNo == 2033) {
		spriteSelect(23);
		if(player.hasKeyItem("Hentai Comic") >= 0) {
			outputText("<b>You already own a Hentai Comic!</b>", true);
			doNext(2017);
			return;
		}
		outputText("Giacomo takes out a colorfully written magazine from his bag. The cover contains well-drawn, overly-endowed women in sexual poses. \"<i>Perhaps your taste in reading is a bit more primal, my good ", true);
		if(player.gender == 1) outputText("man", false);
		if(player.gender == 2 || player.gender == 3) outputText("lady", false);
		if(player.gender == 0) outputText("...err, whatever you are", false);
		outputText("</i>,\" says Giacomo. \"<i>Taken from the lands far to the east, this is a tawdry tale of a group of ladies seeking out endless pleasures.  With a half a dozen pictures on every page to illustrate their peccadilloes, you will have your passions inflamed and wish to join these fantasy vixens in their adventures! Collectable and in high demand, and even if this is not to your tastes, you can easily turn a profit on it! Care to adventure into the realm of fantasy? It's only 10 gems and I am doing YOU a favor for such a price.</i>\"", false);
		doYesNo(2034, 2017);
	}
	//Hentai Comic Sale
	if(eventNo == 2034) {
		spriteSelect(23);
		if(player.hasKeyItem("Hentai Comic") >= 0) {
			outputText("<b>You already own a Hentai Comic!</b>", true);
			doNext(2017);
			return;
		}		
		if(player.gems < 10) {
			outputText("\n\nGiacomo sighs, indicating you need " + String(10 - player.gems) + " more gems to purchase this item.", true);
			doNext(2017);
		}
		else
		{
			outputText("You peruse the erotic book. The story is one of a group of sisters who are all impossibly heavy-chested and equally horny getting into constant misadventures trying to satisfy their lust. While the comic was entertaining and erotic to the highest degree, you cannot help but laugh at how over-the-top the story and all of the characters are. Were the world as it was in the book, nothing would get done as humanity would be fucking like jackrabbits in heat for the rest of their lives. While certainly a tempting proposition, everyone gets worn out sometime. You place the book in your sack, well entertained and with a head filled with wilder perversions than what you woke up with this morning.", true);
			doNext(2017);
			player.gems-=10;
			player.createKeyItem("Hentai Comic",0,0,0,0);
			statScreenRefresh();
		}
	}
	//Dildo Sales Pitch
	if(eventNo == 2035) {
		spriteSelect(23);
		if(player.hasKeyItem("Dildo") >= 0) {
			outputText("<b>You already own a Dildo!</b>", true);
			doNext(2018);
			return;
		}
		outputText("Giacomo takes out a slender tube roughly over half a foot in length. \"<i>Since you seek pleasure, this is as simple and effective as it gets. This dildo is a healthy seven inches long and is suitable for most women and even adventurous men. Pick a hole, stick it in and work it to your heart's content or your partner's pleasure. The single-piece construction makes it solid, sturdy and straightforward. For 20 gems, you can take matters into your own hands. How about it?</i>\"", true);
		doYesNo(2036,2018);
	}
	//Buy Dildo
	if(eventNo == 2036) {
		spriteSelect(23);
		if(player.gems < 20) {
			outputText("\n\nGiacomo sighs, indicating you need " + String(20 - player.gems) + " more gems to purchase this item.", true);
			doNext(2018);
			return;
		}
		else
		{
			outputText("After making the payment, Giacomo hands you the Dildo", true);
			doNext(2018);
			player.gems-=20;
			player.createKeyItem("Dildo",0,0,0,0);
			statScreenRefresh();
		}
	}//Self Stimulation Belt Sales Pitch
	if(eventNo == 2037) {
		spriteSelect(23);
		if(player.hasKeyItem("Self-Stimulation Belt") >= 0) {
			outputText("<b>You already own a Self-Stimulation Belt!</b>", true);
			doNext(2018);
			return;
		}
		outputText("Giacomo holds up what appears to be a chastity belt. However, this device has a dildo attached to the inside. There is a small gearbox on the outside and a wind-up key is tethered to it. The crazed merchant holds the contraption up and begins his liturgy. \"<i>Ah! Someone who both appreciates pleasure AND the wonders of artifice. This naughty little piece of jewelry is designed to pleasure any woman all at the push of a button! All you do is take this key, wind up the gear box...</i>\" Giacomo takes the key and inserts it into the box and winds it like a watch. He then points to a switch. \"<i>...you then press this button and enjoy yourself!</i>\" Giacomo flips the switch and the dildo vibrates rapidly. The distinct hum from the toy and the whirring of gears stirs your imagination. Giacomo pipes up, breaking your train of thought. \"<i>This belt is not cheap, but it is most certainly worth the investment of 30 gems!</i>\"", true);
		doYesNo(2038,2018);
	}
	//Buy Self-Stimulation Belt
	if(eventNo == 2038) {
		spriteSelect(23);
		if(player.gems < 30) {
			outputText("\n\nGiacomo sighs, indicating you need " + String(30 - player.gems) + " more gems to purchase this item.", true);
			doNext(2018);
			return;
		}
		outputText("After making the payment, Giacomo hands you the Self-Stimulation Belt", true);
		player.createKeyItem("Self-Stimulation Belt",0,0,0,0);		
		doNext(2018);
		player.gems-=30;
		statScreenRefresh();
		return;
	}
	//Natural SelfStim Belt Sales Pitch
	if(eventNo == 2039) {
		spriteSelect(23);
		if(player.hasKeyItem("All-Natural Self-Stimulation Belt") >= 0) {
			outputText("<b>You already own an All-Natural Self-Stimulation Belt!</b>", true);
			doNext(2018);
			return;
		}
		outputText("The merchant places his bag on the ground. He reaches into one of his purses and pulls out a pair of gloves. After putting them on, he reaches into his bag and pulls out what appears to be a chastity belt. The device has a clearly organic look to it. In the center of the front cover is a nodule. You have heard of similar devices. They normally have a dildo attached to them to pleasure women. ", true);
		outputText("\"<i>This device is quite intriguing,</i>\" Giacomo begins, \"<i>This pleasure engine is NOT for the faint-of-heart. Being constructed of materials from the workshops of biomechanical artificers, this device outperforms its mechanical cousin in every way. Guaranteed to last longer than you do, this machine will give you as many mind-shattering orgasms as you can handle. Unlike the mechanical belt, you do not need to wind it up. It soaks up the power of the sun itself in an amazing feat of engineering. Four hours a day is all it needs! Keep in mind that if there is no sun for a couple of days, it will not work without a full day's sunshine. You may wonder why I am wearing gloves. Well, that is because of the pads on the belt.</i>\" Giacomo points to a couple of small, amber pads on the belt. \"<i>They are sensitive to human touch and activate the belt. This is all yours for 40 gems and you get the gloves for free! Again, this device offers ultimate pleasure. If you can't handle it, I will not be offended if you turn it down.</i>\"", false);
		if(player.hasKeyItem("Dangerous Plants") >= 0 && player.inte > 39) {
			outputText("\n\nThe nodule and the base of the stimulator look vaguely like some of the things you have seen in the Dangerous Plant book. You wonder if there is not something devious about this item. Giacomo is also sweating. It is too cool for that, this time of year.", false);
		}
		else {
			if(player.inte > 29) {
				outputText("\n\nYou notice a change in Giacomo's attitude. He REALLY wants to sell you this sex toy. Something this exotic should cost much more than what he is offering.", false);
			}
		}
		outputText("\n\nDo you buy the All-Natural Self-Stimulation Belt?", false);
		doYesNo(2040, 2018);
	}
	//Buy all natural SelfStimulation Belt
	if(eventNo == 2040) {
		spriteSelect(23);
		if(player.gems < 40) {
			outputText("\n\nGiacomo sighs, indicating you need " + String(40 - player.gems) + " more gems to purchase this item.", true);
			doNext(2018);
			return;
		}
		outputText("After making the payment, Giacomo hands you the All-Natural Self-Stimulation Belt", true);
		player.createKeyItem("All-Natural Self-Stimulation Belt",0,0,0,0);
		doNext(2018);
		player.gems-=40;
		statScreenRefresh();
		return;
	}
	//Onahole Sales Pitch
	if(eventNo == 2041) {
		spriteSelect(23);
		if(player.hasKeyItem("Plain Onahole") >= 0) {
			outputText("<b>You already own a Plain Onahole!</b>", true);
			doNext(2018);
			return;
		}
		outputText("Giacomo takes out a pink cylinder from his bag. It appears to be sealed at one end and the cap is topped with a piece of rubber that has a vertical slit. \"<i>Friend</i>,\" Giacomo starts, \"<i>when you do not want to go through all of the shit to bag a woman, this is the thing for you. It never says no, it never bitches and it never takes everything you own in a divorce. All you do is get hard, slip your cock in the slit, work it at your pace and unload. Simple is as simple does. Take the top off for easy clean up and there you go! As you can see it is portable and is much safer than risking some social disease from an errant barmaid. I have plenty of these in stock and I can let it go for 20 gems. What say you?</i>\"", true);
		doYesNo(2043, 2018);
	}
	//All-natural Self-Stim Bad End
	if(eventNo == 2042) {
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
	if(eventNo == 2043) {
		spriteSelect(23);
		if(player.gems < 20) {
			outputText("\n\nGiacomo sighs, indicating you need " + String(20 - player.gems) + " more gems to purchase this item.", true);
			doNext(2018);
			return;
		}
		outputText("After making the payment, Giacomo hands you the Plain Onahole", true);
		player.createKeyItem("Plain Onahole",0,0,0,0);
		doNext(2018);
		player.gems-=20;
		statScreenRefresh();
		return;
	}
	//Delux Onahole Sales Pitch
	if(eventNo == 2044) {
		spriteSelect(23);
		if(player.hasKeyItem("Deluxe Onahole") >= 0) {
			outputText("<b>You already own a Deluxe Onahole!</b>", true);
			doNext(2018);
			return;
		}
		outputText("Giacomo holds up a weirdly shaped lump of rubber. One end is shaped and contoured like a woman's genitalia while the rest stretches out to almost a foot long. \"<i>This thing right here is excellent! While a standard onahole will get you off, this has the look and feel of the real thing! As you can see, the outside orifice looks just like a woman's privates and,</i>\" Giacomo pauses to open the inside for you to view. You see the inner folds and curves that are typical to the inside of a woman's womb, \"<i>as you can see, great care has been taken to make the inside feel as much like a real pussy as possible. You hammer your cock with this thing a few times and you may never want the real thing again! If nothing else, it won't whine about you running out the door first thing in the morning. 50 gems is more than reasonable for all of the satisfaction this will bring.</i>\"", true);
		doYesNo(2045, 2018);
	}
	//Buy Deluxe Onahole
	if(eventNo == 2045) {
		spriteSelect(23);
		if(player.gems < 50) {
			outputText("\n\nGiacomo sighs, indicating you need " + String(50 - player.gems) + " more gems to purchase this item.", true);
			doNext(2018);
			return;
		}
		outputText("After making the payment, Giacomo hands you the Deluxe Onahole", true);
		player.createKeyItem("Deluxe Onahole",0,0,0,0);
		doNext(2018);
		player.gems-=50;
		statScreenRefresh();
		return;
	}
	//Onahole multi-cock continuation!
	if(eventNo == 2046) {
		outputText("You pull the sloppy toy from your dribbling dick and smile, shoving its slippery surface down on another of your " + multiCockDescriptLight() + ".  You rapidly work it around your cocks, orgasming until ", true);
		if(player.balls > 0) outputText("you pass out with aching, empty balls.", false);
		else outputText("you pass out with " + multiCockDescriptLight() + " sore from exertion.", false);
		stats(0,0,0,0,0,-1,-100,0);
		doNext(13);
	}
	//Natural Stim Belt continuation
	if(eventNo == 2047) {
		outputText("In shock, you scream as you realize the nodule has instantly grown into a massive, organic dildo. It bottoms out easily and rests against your cervix as you recover from the initial shock of its penetration. As the pangs subside, the infernal appendage begins working itself. It begins undulating in long, slow strokes. It takes great care to adjust itself to fit every curve of your womb. Overwhelmed, your body begins reacting against your conscious thought and slowly thrusts your pelvis in tune to the thing.\n\n", true);
		outputText("As suddenly as it penetrated you, it shifts into a different phase of operation. It buries itself as deep as it can and begins short, rapid strokes. The toy hammers your insides faster than any man could ever hope to do. You orgasm immediately and produce successive climaxes. Your body loses what motor control it had and bucks and undulates wildly as the device pistons your cunt without end. You scream at the top of your lungs. Each yell calls to creation the depth of your pleasure and lust.\n\n", false);
		outputText("The fiendish belt shifts again. It buries itself as deep as it can go and you feel pressure against the depths of your womanhood. You feel a hot fluid spray inside you. Reflexively, you shout, \"<b>IT'S CUMMING!!!! IT'S CUMMING INSIDE ME!!!</b>\" Indeed, each push of the prodding member floods your box with juice. It cums... and cums... and cums... and cums...\n\n", false);
		outputText("An eternity passes, and your pussy is sore. It is stretched and filled completely with whatever this thing shoots for cum. It retracts itself from your hole and you feel one last pang of pressure as your body now has a chance to force out all of the spunk that it cannot handle. Ooze sprays out from the sides of the belt and leaves you in a smelly, sticky mess. You feel the belt's tension ease up as it loosens. The machine has run its course. You immediately pass out.", false);
		slimeFeed();
		stats(0,0,0,0,1,(-0.5),-100,0);
		doNext(13);
	}
	//Natural Onahole Sales Pitch
	if(eventNo == 2048) {
		spriteSelect(23);
		if(player.hasKeyItem("All-Natural Onahole") >= 0) {
			outputText("<b>You already own an All-Natural Onahole!</b>", true);
			doNext(2018);
			return;
		}
		outputText("Giacomo reaches into his bag and pulls out what looks like an oblong coconut. It is roughly seven inches in diameter. There is a distinctive opening in one end that is just large enough for an erect penis. Inside the opening you see what looks like two pink cushions. There are multiple symmetrical depressions surrounding the outside hole of the thing. Giacomo's smile fades and he takes on a much more serious attitude befitting his aquiline face. \"<i>Miss,</i>\" Giacomo states, \"<i>without sounding too bold, it is no secret that members of the third gender are capable of sexual feats that force the other two genders into jealous fits. Having bigger cocks than men, cumming more than an elephant and a pussy with the strength and coordination of a human hand, regular toys do not last long for you folk. Hence, this little beasty. I will tell you straightaway, only the third sex ", true);
		outputText("can handle this toy. The other two genders simply do not have the stamina for it. This thing is all-natural, meaning that it powers itself and is made with the Artificers' organic methods. It will cease functioning if it is not used or you fail to give the opening a few drops of this fluid once every three days.</i>\" Giacomo pauses to hold up a small bottle. He places the bottle down and continues his sales pitch, \"<i>If you plan on not using this thing regularly, do not buy it. These items are very rare and this one will probably be the only one you'll ever see. Normally I pitch my products like crazy. However, with this I do not need to. This thing DOES work too well, and you WILL cum, period. It will work you until you do not want it to work anymore. It will not stop until IT decides to stop. However, for the extreme needs of a lovely example of the dual-sex, it may be the very thing you need. Again, this is for the ultimate hardcore pleasure seeker amongst the ultimate hardcore. It costs a humble 150 gems, but for superhuman thrills, who can put a price tag on that?</i>", false);
		if(player.hasKeyItem("Dangerous Plants") >= 0 && player.inte > 35) {
			outputText("\n\nWhile skillfully avoiding Giacomo's suspicion, you correctly surmise that the toy is not a toy at all. It is the outer shell for a hybrid animal-plant. The creature is very much alive. While the technical name for this beast is in the usual unpronounceable scholastic gibberish, the common nickname for this is the \"All-Day Sucker\". It gets its name due to the fact that its diet consists of high nutrient fluids, especially semen. It was used both as a torture device and as a pleasure pet of the snobbish elite because it would clamp down upon the member of a person and not release until it has stimulated the person enough to ejaculate sufficiently to feed. However, the All-Day Sucker swells up like fleas and ticks do, thus requiring hours of stimulation to have its fill. There was something else about these things, but you cannot remember exactly what it was.", false);
			if(player.inte > 65) {
				outputText("After a moment, you remember what it was you read. Unlike many simple beasts, this creature has a male and a female gender. The creature itself is similar to a tubeworm. While the males are considered reasonably \"safe\", the females have a nasty habit of injecting its young inside the sex organs of the person using the thing, leaving the hapless person to convulse in endless, painful orgasms as the beasties wriggle around their insides until they are ready for birth. The process takes about a week and recorded victims normally make full recoveries after a period of blindingly painful orgasms as they shoot out the young. It is not a surprise to have people's hearts give out at the endless stimulation from the young. The recovery time is quite long due to the stress on the body such overwhelming stimulus would generate. Some ultra-extreme pleasure seekers actively look for these things just for this experience.\n\nHowever, the problem is there is NO WAY to tell if this is male or female by looking at it.", false);
			}
		}
		doYesNo(2049, 2018);
	}
	//Natural Onahole Purchase
	if(eventNo == 2049) {
		spriteSelect(23);
		if(player.gems < 150) {
			outputText("\n\nGiacomo sighs, indicating you need " + String(150 - player.gems) + " more gems to purchase this item.", true);
			doNext(2018);
			return;
		}
		outputText("After making the payment, Giacomo hands you the All-Natural Onahole", true);
		player.createKeyItem("All-Natural Onahole",0,0,0,0);
		doNext(2018);
		player.gems-=150;
		statScreenRefresh();
		return;
	}
	//Deluxe Onahole Futa continuation
	if(eventNo == 2050) {
		if(player.gender == 3) {
			outputText("\n\nThe blessing (or curse, depending on how you feel) of your gender catches up. As with all members of your gender, you are incapable of having just ONE orgasm. You feel the muscles deep in your crotch bear down hard. Your eyes widen as you realize you are about to blow a monumental load. The pressure works its way through you and towards your cock as, with one final push, you force a torrent of semen out of your body. Your grip was not sufficient on the onahole and you launch it ", true);
			outputText(String(int(((Math.random() * player.str/12) + player.str/6) * 10)/10), false);
			outputText(" feet away from you. Delirious with pleasure, you continue your 'impression' of a semen volcano, covering yourself and the area with your seed. ", false);
			outputText(" As your orgasms fade, you find yourself a well-fucked mess, and pass out.", false);
			stats(0,0,0,0,0,-1,-100,0);
		}
		doNext(1);
	}
	//Encounter bee girl!
	if(eventNo == 2051) {
		beeEncounter();
	}
	//Encounter bee girl step 2
	if(eventNo == 2052) {
		outputText("", true);
		beeEncounterLevel2();
	}
	//Encounter bee girl level 3 - get raeped.
	if(eventNo == 2053) {
		beeEncounterLevel3();
		if(gameState > 0) eventParser(5007);
	}
	//Talk to bee girl
	if(eventNo == 2054) {
		beeTalk();
	}
	//Decline talking to bee-girl
	if(eventNo == 2055) {
		declineBeeTalk();
	}
	//Free honey event!
	if(eventNo == 2056) {
		freeHoneyEvent();
	}
	//Seduce bee girl
	if(eventNo == 2057) {
		seduceBeeGirl();
	}
	//Bee rapes you
	if(eventNo == 2058) {
		beeRapesYou();
	}
	//You rape the bee
	if(eventNo == 2059) {
		rapeTheBeeGirl();
	}
	//You fight the bee!
	if(eventNo == 2060) {
		outputText("You clear your head and resolve to defeat the monstrous bee-woman.", true);
		spriteSelect(6);
		startCombat(5);
	}
	//Level 3 with clear previous text
	//Encounter bee girl level 3 - get raeped.
	if(eventNo == 2061) {
		outputText("", true);
		beeEncounterLevel3();
	}
	//Encounter the wanderer for the first time
	if(eventNo == 2062) {
		wandererFirstMeeting();
	}
	//Encounter the wanderer repeat visits
	if(eventNo == 2063) {
		wandererRepeatMeeting();
	}
	//Do you help the wanderer?
	if(eventNo == 2064) {
		wandererHelpHim();
	}
	//Tell the wanderer to go demon
	if(eventNo == 2065) {
		wandererGoDemon();
	}
	//Tell him to stay human
	if(eventNo == 2066) {
		wandererStayHuman();
	}
	//Leave the wanderer and ignore him
	if(eventNo == 2067) {
		wandererLeave();
	}
	//Generic farm encounter
	if(eventNo == 2068) {
		farmExploreEncounter();
	}
	//Let Rathazul craft armor
	if(eventNo == 2069) {
		craftOozeArmor();
	}
	//Encounter Rathazul
	if(eventNo == 2070) {
		if(player.hasStatusAffect("Camp Rathazul") >= 0) campRathazul();
		else encounterRathazul();
	}
	//Purify Incubi Draft
	if(eventNo == 2071) {
		if(player.gems < 20) {
			outputText("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"", true);
			doNext(2070);
			return;
		}
		outputText("", true);
		if(!debug) destroyItems("IncubiD", 1);
		shortName = "P.Draft";
		takeItem();
		player.gems -= 20;
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
		return;
	}
	//Purify Succubi Milk
	if(eventNo == 2072) {
		if(player.gems < 20) {
			outputText("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"", true);
			doNext(2070);
			return;
		}
		outputText("", true);
		if(!debug) destroyItems("SucMilk", 1);
		shortName = "P.S.Mlk";
		takeItem();
		player.gems -= 20;
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
		return;
	}
	//Purify Succubi's Delight
	if(eventNo == 2073) {
		if(player.gems < 20) {
			outputText("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"", true);
			doNext(2070);
			return;
		}
		outputText("", true);
		if(!debug) destroyItems("SDelite", 1);
		shortName = "PSDelit";
		takeItem();
		player.gems -= 20;
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
		return;
	}
	//Try to pull sword free of tree
	if(eventNo == 2074) {
		tryToTakeSwordInStone();
	}
	//Grab marae's boob!
	if(eventNo == 2075) {
		outputText("You reach forward to cop a feel.  The goddess' eyes go wide with fury as a massive branch swings down, catching you in the sternum.  It hits you hard enough that you land in your boat and float back a few feet into the water.  Nothing to do but leave and hope for another chance at her breasts...", true);
		doNext(13);
		takeDamage(player.HP-1);
	}
	if(eventNo == 2076) {
		maraeStealLethicite();
	}
	if(eventNo == 2077) {
		maraeBadEnd();
	}
	//Run from corrupt marae
	if(eventNo == 2078) {
		outputText("You turn and run for the boat, leaving the corrupt goddess behind.  High pitched laugher seems to chase you as you row away from the island.", true);
		doNext(13);
		return;
	}
	if(eventNo == 2079) {
		boatExplore();
		return;
	}
	if(eventNo == 2080) {
		startCombat(14);
		eventParser(1);
		return;
	}
	//Remove worms
	if(eventNo == 2081) {
		spriteSelect(23);
		outputText("You toss the gems at the merchant, who calmly hands you the bottle. Gulping down the liquid, your guts light up as if you swallowed fire. Pain overwhelms your body and you drop to your knees convulsing. You curse the merchant for poisoning you, yet you can only choke out gibberish through your groans. The pain quickly focuses from your stomach to your crotch as the worms inside you are clearly NOT happy with what you have done. You fall onto your back as the thrashing overwhelms you. With an unexpected climax, every worm in your body fights to escape your gonads. The fat worm that resided deep in your sex lazily pushes itself out last.\n\n", true);
		outputText("Upon seeing the fat worm, Giacomo displays a freakish celerity by jumping off his cart, grabbing an empty container and collecting the fat worm. Regaining your senses, you look at him with inquisitive shock at what he just did.\n\n", false);
		outputText("\"<i>You have to realize that I AM a merchant, after all.</i>\", he calmly replies. \"<i>Hell for you is heaven for someone else. This bugger will easily fetch 10,000 gems to some noble looking for a quick buzz. Don't WE know better!</i>\"\n\n", false);
		outputText("The merchant puts away his prize and comes back to help you up. \"<i>Here.</i>\", he says as he shoves a couple of bottles into your hand. \"<i>This is on the house. You probably need it after the shock of getting those things out.</i>\"\n\n", false);
		//Add 1 tincture of vitality to inventory
		//Infestation purged. Hit Points reduced to 10% of MAX. Corruption -20.
		if(player.HP > int(maxHP() * .15)) player.HP = int(maxHP() * .15);
		//Maybe add a random chance of losing a random transformation with a smaller chance of losing ALL transformations except gender changes. This will probably be a bitch to implement.
		player.removeStatusAffect("infested");
		stats(0,0,0,0,-1,0,-99,-4);
		player.gems -= 175;
		statScreenRefresh();
		shortName = "Vital T";
		takeItem();
	}
	//Offer to remove worms #2
	if(eventNo == 2082) {
		spriteSelect(23);
		outputText("\n\n\"<i>Been playing with creatures best left alone, I see</i>\", he chuckles, \"<i>Infestations of any kind are annoying, yet your plight is quite challenging given the magnitude of corrupt creatures around here. It is not the first time I have seen one infested with THOSE worms.</i>\"\n\n", false);
		outputText("You ask how he knows of your change and the merchant giggles heartily.\n\n", false);
		outputText("\"<i>Do not look at me as if I am a mystic.</i>\", Giacomo heckles lightly. \"<i>Your crotch is squirming.</i>\"\n\n", false);
		outputText("Looking down, you realize how right he is and attempt to cover yourself in embarrassment.\n\n", false);
		outputText("\"<i>Fear not!</i>\", the purveyor jingles. \"<i>I have something that will cure you of those little bastards. Of course, there is also a chance that it will purge your system in general. This potion is not cheap. I will trade it for 175 gems.</i>\"\n\n", false);
		//Broke as a joke
		if(player.gems < 175) {
			outputText("You realize you don't have enough gems for such a pricey potion, but perhaps there is something else in his inventory you can buy.", false);
			doNext(2015);
		}
		//Can afford
		else {
			outputText("Do you purchase his cure?", false);
			//Remove/No
			doYesNo(2081,2015);
		}
		
	}
	//Jojo worm removal
	if(eventNo == 2083) {
		spriteSelect(34);
		outputText("\"<i>Excellent, young one,</i>\" Jojo continues. \"<i>Your dedication to purification is admirable. Relax and know that the parasites will leave you soon.</i>\"\n\n", true);
		outputText("Jojo gets up and walks over to a backpack hidden in the bushes. He removes a lacquered box. He removes and combines a rather noxious combination of herbs, oils and other concoctions into a mortar and grinds it with a pestle. After a few minutes, he ignites the mixture and uses a feathered fan to blow the fumes over you. The smell of the mix is nauseating and repugnant. Your stomach turns and you fight the urge to vomit. Eventually, you are no longer able to resist and you purge yourself onto the ground. Cramping from your vomiting fits, you wrack with discomfort, which slowly builds to genuine pain. As the pain sets in, you feel a stirring deep in your crotch. The worms inside you are stirring and thus are compelling another unwanted orgasm. Unable to control your body, your cock explodes, launching cum and worms everywhere. Jojo begins fanning faster as he sees the worms leave your body.\n\n", false);
		outputText("\"<i>Further endurance is needed, young one,</i>\" Jojo says. \"<i>The root of your problem must leave before you may pursue further purification. Healing is always twice as uncomfortable as the illness requiring attention.</i>\"\n\n", false);
		outputText("Your body cramps up as you feel the fat worm struggle. You feel it pushing up your urethra, fighting to escape your fumigated body. The worm rapidly peeks from the end of your penis. With expedience, Jojo quickly grabs the worm and pulls it out of you, triggering one last orgasm. The monk casts the fat worm to the ground and strikes it dead with his staff.\n\n", false);
		outputText("\"<i>The culprit has been exorcised and will no longer trouble you. Rest here for a while and join me in some meditation to heal your exhausted body and soul.</i>\"\n\n", false);
		outputText("Being too tired for anything else, you join Jojo in meditation, which does much to relive you of your former woes.", false);
		//Infestation removed. HP reduced to 50% of MAX. Sensitivity reduced by -25 or reduced to 10, which ever is the smaller reduction.
		//Infestation purged. Hit Points reduced to 10% of MAX. Corruption -20.
		if(player.HP > int(maxHP() * .5)) player.HP = int(maxHP() * .5);
		player.sens = 11;
		player.removeStatusAffect("infested");
		stats(0,0,0,0,0,-1,-99,-15);
		doNext(13);
		return;
	}
	//Treeboob fun-times
	if(eventNo == 2084) {
		outputText("", true);
		outputText("Stepping carefully around the other hazards of the glade, you close on the strange trees with equal parts curiosity and desire.  Up close, it's easy to see the strange growths that sprout from the bark – dozens of full ripe-looking breasts, each capped with a swollen and leaking nipple.  You touch one, marveling at the smooth texture of its chocolate-colored skin.   In response a runner of sap oozes free of the nipple and slides down the curved surface.\n\n", false);
		outputText("You lean forwards and lick around the nipple's surface, sampling the sweetness of the trickling sap.   The stuff nearly overpowers you with a taste like syrupy cream as more sap drips free of the fully-erect tree-nipple.  Unable to resist testing this nonsensical oddity, you engulf the entire nipple between your lips, suckling hard.   The tree seems to oblige your efforts with a fresh discharge of the sticky sap.   Your tongue tingles and vibrates with the sinfully sweet taste in your mouth, dancing in circles around the nipple, coaxing yet more nectar from swollen plant-jug.  It's easy to lose yourself in that taste, falling into a rhythm of alternatively sucking, swallowing, and licking.\n\n", false);
		outputText("In time you realize the breast has long since been emptied by your hungry mouth, and you pull free with a pop, letting your tongue run over your now over-sensitive lips.  It seems your entire mouth has been affected by the tree's sap, and is now as sensitive and receptive as a maiden's box.  You don't think you could drink any more sap with how full you feel, and you make ready to depart this perverted place.", false);
		stats(0,0,0,0,0,1,15,.5);
		slimeFeed();
		doNext(13);
		if(player.hasStatusAffect("LustyTongue") < 0) {
			//25% Chance of sensitive mouth status – increased lust gain/hour due to licking your lips :3
			if(rand(4) == 0) {
				outputText("  The feeling doesn't seem to fade, only becoming more and more intense over the coming hour.  It will be hard to keep from getting turned on any time you lick your lips or eat some food.", false);
				player.createStatusAffect("LustyTongue",24,0,0,0);
			}
			//ELSE
			else outputText("  Thankfully, the feeling goes away after a few minutes, leaving you feeling just a bit more sensitive.", false);
		}
		//50% Chance of breast-growth
		if(rand(2) == 0) {
			if(player.biggestTitSize() > 5) {
				outputText("  As you redress, you feel a sense of added weight on your chest.  After a few moments you realize your already-formidable chest has grown even larger.", false);
				growTits(1, 1 + rand(3), false, 1);

			}
			else {
				//No tits yet
				if(player.biggestTitSize() == 0) {
					outputText("  As you redress, you realize you have grown a pair of luscious breasts!  Perhaps this was a good idea after all...", false);
					growTits(1, 2 + rand(3), false, 1);
				}
				else //Small tits growth
				{
					outputText("  As you redress, you realize your breasts have gotten quite a bit larger!  Maybe you can come back later when you aren't so full and plump them up a bit more.", false);
					growTits(1, 1 + rand(3), false, 1);
				}
			}
		}
	}
	//MARBLE SHIT STARTS HERE
	if(eventNo == 2085) {
		marblePicksYouUpInitially();
		return;
	}
	if(eventNo == 2086) {
		doNext(13);
		resistMarbleInitially();
		return;
	}
	if(eventNo == 2087) {
		caressMarble();
		return;
	}
	if(eventNo == 2088) {
		suckleMarble();
		doNext(13);
		return;
	}
	if(eventNo == 2089) {
		doNext(13);
		rapeDAHMARBLEZ();
		return;
	}
	if(eventNo == 2090) {
		drinkMarbleMilk();
		return;
	}
	if(eventNo == 2091) {
		doNext(13);
		playerRefusesMarbleMilk();
		return;
	}
	if(eventNo == 2092) {
		doNext(13);
		AcceptMarblesSexualAdvances();
		return;
	}
	if(eventNo == 2093) {
		doNext(13);
		turnDownMarbleSexRepeat();
		return;
	}
	if(eventNo == 2094) {
		turnDownMarbleSexFirstTime();
		return;
	}
	if(eventNo == 2095) {
		doNext(13);
		wantMarbleAddiction();
		return;
	}
	if(eventNo == 2096) {
		doNext(13);
		doNotWantMarbleAddiction();
		return;
	}
	if(eventNo == 2097) {
		playerAgreesToDrinkMarbleMilkBottled();
		return;
	}
	if(eventNo == 2098) {
		playerRefusesToDrinkBottledMilk();
		return;
	}
	if(eventNo == 2099) {
		doNext(13);
		playerDrinksMarbleMilk();
		return;
	}
	if(eventNo == 2100) {
		playerDeclinesToDrinkMarbleMilk();
		return;
	}
	if(eventNo == 2101) {
		marbleChoreHelpChooseMilk();
		return;
	}
	if(eventNo == 2102) {
		doNext(13);
		marbleChoreHelpChooseMarble();
		return;
	}
	if(eventNo == 2103) {
		marbleChoreRefusal();
		return;
	}
	if(eventNo == 2104) {
		AshamedAddictionComfort();
		return;
	}
	if(eventNo == 2105) {
		AshamedAddictionBlame();
		return;
	}
	if(eventNo == 2106) {
		resistAddiction();
		return;
	}
	if(eventNo == 2107) {
		addictionGiveIn()
		return;
	}
	if(eventNo == 2108) {
		dumpMarblesMilk();
		return;
	}
	if(eventNo == 2109) {
		refuseMarblesMilkAddiction();
		return;
	}
	if(eventNo == 2110) {
		ashamedAddictionBegForIt();
		return;
	}
	if(eventNo == 2111) {
		doNext(13);
		marbleCampFuckFUCKFUCKFUCK();
		return;
	}
	if(eventNo == 2112) {
		outputText("", true);
		marbleSex2Continued(1);
		doNext(13);
		return;
	}
	if(eventNo == 2113) {
		outputText("", true);
		marbleSex2Continued(2);
		doNext(13);
		return;
	}
	if(eventNo == 2114) {
		doNext(13);
		keltReluctantlyGetNaked();
		return;		
	}
	if(eventNo == 2115) {
		doNext(13);
		keltEagerlyGetNaked();
		return;		
	}
	if(eventNo == 2116) {
		doNext(13);
		keltRefuseNakedness();
		return;		
	}
	if(eventNo == 2117) {
		doNext(13);
		keltBlowjobRequirementShamefully();
		return;		
	}
	if(eventNo == 2118) {
		doNext(13);
		keltBlowjobRequirementEagerly();
		return;		
	}
	if(eventNo == 2119) {
		doNext(13);
		keltBlowjobRequirementNever();
		return;		
	}
	if(eventNo == 2120) {
		doNext(13);
		keltSubmitGivingBJ();
		return;		
	}
	if(eventNo == 2121) {
		doNext(13);
		keltResistGivingBJ();
		return;		
	}
	if(eventNo == 2122) {
		doNext(13);
		continueAfterBJ();
		return;		
	}
	if(eventNo == 2123) {
		doNext(13);
		keltBadEndEpilogue();
		return;		
	}
	if(eventNo == 2124)
	{
		outputText("Rathazul smiles happily back at you and begins packing up his equipment.  He mutters over his shoulder, \"<i>It will take me a while to get my equipment moved over, but you head on back and I'll see you within the hour.  Oh my, yes.</i>\"\n\nHe has the look of someone experiencing hope for the first time in a long time.", true);
		player.createStatusAffect("Camp Rathazul",0,0,0,0);
		doNext(13);
		return;
	}
	if(eventNo == 2125)
	{
		outputText("Rathazul wheezes out a sigh, and nods.\n\n\"<i>Perhaps I'll still be of some use out here after all,</i>\" he mutters as he packs up his camp and prepares to head to another spot along the lake.", true);
		doNext(13);
		return;
	}
	if(eventNo == 2126) 
	{
		doNext(1);
		marbleInfo();
		return;		
	}
	if(eventNo == 2127) 
	{
		doNext(1);
		marbleSexExpanded();
		return;		
	}
	if(eventNo == 2128) 
	{
		temp2 = 0;
		temp3 = 0;
		temp4 = 0;
		temp5 = 0;
		temp6 = 0;
		temp7 = 0;
		temp8 = 0;
		if(player.hasPerk("Marble's Milk") >= 0 && hasItem("Lactaid",1)) temp2 = 2269;
		if(hasItem("P.Draft",1) && flags[4] == 0) temp4 = 2273;
		if(flags[4] > 0) {
			if(hasItem("PinkEgg",1)) temp5 = 2270;
			if(hasItem("L.PnkEg",1)) temp6 = 2271;
		}
		if(flags[MARBLE_BOVA_LEVEL] < 2 && hasItem("ProBova",1)) temp7 = 3569;
		if(hasItem("OviElix",1)) temp3 = 2272;
		outputText("What item do you want to give Marble?", true);
		choices("Lactaid",temp2,"OviElixir",temp3,"P.Incub Dr",temp4,"Pink Egg",temp5,"L.Pink Egg",temp6,"ProBova",temp7,"",0,"",0,"",0,"Back",2133);
		return;		
	}
	if(eventNo == 2129) 
	{
		doNext(1);
		marbleGathered();
		return;		
	}
	if(eventNo == 2130) 
	{
		doNext(1);
		talkWithMarbleAtCamp();
		return;		
	}
	if(eventNo == 2131) 
	{
		doNext(1);
		gotMilk();
		return;		
	}
	if(eventNo == 2132) 
	{
		doNext(1);
		marbleAppearance();
		return;		
	}
	if(eventNo == 2133) 
	{
		doNext(1);
		interactWithMarbleAtCamp();
		return;		
	}
	if(eventNo == 2134) 
	{
		doNext(1);
		spriteSelect(34);
		jojoMutationOfferYes();
		return;		
	}
	if(eventNo == 2135) 
	{
		doNext(1);
		spriteSelect(34);
		jojoMutationOfferNo();
		return;		
	}
	if(eventNo == 2136) 
	{
		doNext(1);
		spriteSelect(34);
		mutateJojo();
		return;		
	}
	if(eventNo == 2137) 
	{
		doNext(1);
		spriteSelect(34);
		useTentacleJojo();
		return;		
	}
	if(eventNo == 2138) {
		spriteSelect(34);
		masturbateJojo();
		return;
	}
	if(eventNo == 2139) {
		oasisBadEnd();
		return;
	}
	if(eventNo == 2140) {
		oasisBadEndEpilogue();
		return;
	}
	if(eventNo == 2141) {
		oasisSexing();
		return;
	}
	if(eventNo == 2142) {
		outputText("", true);
		spriteSelect(23);
		outputText("Giacomo smiles widely as you look through his wares seeing a strange looking device sitting there. \"<i>Ahh, I see you have spotted our latest piece of equipment. Members of the third gender had a hard time finding enough pleasure to suit their special needs. With this little device, you will never have to worry about satisfying your needs ever again.</i>\" He grins widely at you. \"<i>The deluxe dual belt will have you shaking in the throes of orgasm hours after a simple stim belt would leave you dry. You will cum in this thing, and it will leave you running back to it anytime you need sexual gratification. Everything else may as well be sandpaper on your skin. Simply flick this switch here on the side to start it up and send yourself to heaven. And you can have it for the low price of 50 gems.</i>\" He smiles again at you. \"<i>So, shall I hand it over to you?</i>\" he asks.", false);
		doYesNo(2143,2018);
		return;
	}
	if(eventNo == 2143) {
		spriteSelect(23);
		if(player.hasKeyItem("Dual Belt") >= 0) {
			outputText("<b>You already own a dual belt!</b>", true);
			doNext(2018);
			return;
		}
		if(player.gems < 50) {
			outputText("You do not have enough gems to purchase this item.", true);
			doNext(2018);
			return;
		}
		outputText("You are a bit dubious at the pleasure it could offer you, but it would be better than being raped by the creatures constantly... maybe to even work out some excess lusts... hesitantly, you reach into your bag and grab 50 gems, handing it to him. He greedily snatches it from your palm and hands you with the belt with a smile. \"<i>I promise you won't be disappointed.</i>\" He counts the gems and waves goodbye.\n\n(<b>Dual Belt acquired!</b>)", true);
		player.createKeyItem("Dual Belt",0,0,0,0);
		player.gems -= 50;
		statScreenRefresh();
		doNext(2018);
	}
	if(eventNo == 2144) {
		outputText("", true);
		outputText("You look at the thing in front of you and sigh, your " + multiCockDescriptLight() + " and " + vaginaDescript(0) + " dripping with fluids. With a nervous sigh you step into the underwear looking device and slip it up your legs, the cold metal feeling so good on your " + player.skinDesc + ", sending a rush of feelings up your body. You slip your " + cockDescript(0) + " down and into a hole on the front of the belt, the extra length sticking out on the other side of it. Underneath the hole and right above your pussy is another metal square with what feels like a small nub on the inside rubbing against your clit. Shivering from the feeling of it, you stay there for a moment, waiting in anticipation. Finally, you reach down to the side of the belt and flick the switch to the on position.\n\n", false);
		outputText("The belt whirs to life, shaking on your waist, sending jolts of pleasure through your clit as the small inside nub hits it. \"<i>Ohh...</i>\" Suddenly, the ring around you cock vibrates and then tightens hard around your cock, the belt sinking onto your body and locking in place. Worry sets in instantly as you try to wiggle and take it off, but it is no use. You see something black bubble from the edges of the metal, worried even more that it might be some sort of acid. It begins to creep across your skin at a disturbing rate, going down your " + player.legs() + " and encasing them in the blackness, wrapping your cock, ", false);
		if(player.tailType > 0) outputText("covering up your tail, ", false);
		outputText("and then going up your body, covering your " + allBreastsDescript() + " and neck. The only part of your body unclad by the suit is your head. The blackness feels slick and smooth, almost cold, a strange type of feeling washes over you until your realize that it is a rubber suit.\n\n", false);
		outputText("Before you can do anything else, the belt activates again and the latex covering of your " + cockDescript(0) + " begins to tighten and pulse around the meat, warming up to feel like a virgin cunt. A moan is dragged from your lips as it begins to ripple and pulse, simulating the feeling of fucking a tight hole as the entire suit molds itself to your body. Before you can get too used to the feeling of the suit milking your cock, the nub that had been teasing your clit suddenly expands and pushes out, the slick feeling of the latex pushing into your pussy.  The hardened black latex splits your tunnel and spreads you wide as it goes in deep. Your eyes widen for a moment as both stop, and then your world explodes in a flash of pleasure. The hardened lump begins to piston in and out of your " + vaginaDescript(0) + ", vibrating wildly as a lump grows in on top in precisely the right spot to rub back and forth on your g-spot.\n\n", false);
		outputText("Meanwhile the latex around your " + cockDescript(0) + " begins to pulse and ripple faster than ever before. You quake and quiver, " + player.legs() + " giving out at it teases and pulses around you " + allBreastsDescript() + ". Your hands hopelessly go down your body and start stroking at your encased cock, rubbing up and down your length. Unfortunately, all things must come to an end as the pleasure gets to be way too much and you feel yourself cum. Your hips buck wildly as you feel cum spurt into the latex, the end swelling up and filling like a ", false);
		if(player.cumQ() > 200) outputText("massive ", false);
		outputText("balloon. ", false);
		if(player.cumQ() >= 1000) outputText("It grows larger and larger until you are sure it will pop, but it doesn't.  It just sloshes around - a huge bubble, nearly waist high. ", false);
		outputText("Your eyes close in shivered ecstasy as your cunt spasms and clutches down around the hardened section deep inside of you. ", false);
		//([If high lactation]
		if(player.biggestLactation() >= 2) outputText("Milk gushes out from your " + breastDescript(0) + " as you orgasm, filling the inside of the suit with a slick layer of milk and forming milk bubbles that hang lewdly off your chest. ", false);
		outputText("However, the suit is far from over as it keeps up all of its actions, keeping you on an orgasmic plateau, making sure you never stop coming. Your hands fall to the side and your body falls down, unable to keep it up as your consciousness fades, suit still filling with all your fluids.\n\n", false);
		outputText("When you wake, the black latex is no longer covering your body and the belt is silent around your waist. Cum drips from the tip of your cock and the top part of your " + player.legs() + " are coated with your feminine juices. ", false);
		if(player.biggestLactation() >= 2) outputText("Thin streams of creamy milk flow from your " + allBreastsDescript() + ", your torso and midsection dripping wet from the stuff. ", false);
		outputText("Completely sated, you take off the belt, finding it slides off easily, and put it away in your campsite, eagerly awaiting the time you can next use it and have the suit work you over once more.", false);
		stats(0,0,0,0,0,-1,-300,0);
		if(player.lib < 30) stats(0,0,0,0,.5,0,0,0);
		if(player.lib < 50) stats(0,0,0,0,.5,0,0,0);
		if(player.lib < 60) stats(0,0,0,0,.5,0,0,0);
		doNext(13);
		if(player.sens > 40) player.sens -= 1;
		if(player.sens > 60) player.sens -= 1;
		if(player.sens > 80) player.sens -= 1;
		if(player.tou > 50) stats(0,-1,0,0,0,0,0,0);
		if(player.tou > 75) stats(0,-1,0,0,0,0,0,0);
	}
	//Purify LaBova Draft
	if(eventNo == 2145) {
		if(player.gems < 20) {
			outputText("Rathazul says, \"<i>You do not have enough gems for that service.</i>\"", true);
			doNext(2070);
			return;
		}
		outputText("", true);
		if(!debug) destroyItems("LaBova ", 1);
		shortName = "P.LBova";
		takeItem();
		player.gems -= 20;
		statScreenRefresh();
		player.addStatusValue("metRathazul",2,1);
		return;
	}
	//Marble 
	if(eventNo == 2146) {
		marbleAfterRapeNo();
		return;
	}
	//after rape - choose to fight
	if(eventNo == 2147) {
		marbleAfterRapeStartFight();
		return;
	}
	//after rape - choose to confront
	if(eventNo == 2148) {
		marbleAfterRapeYes();
		return;
	}
	//Move Jojo into camp
	if(eventNo == 2149) {
		spriteSelect(34);
		if(player.hasStatusAffect("Ever Raped Jojo") >= 0 || flags[JOJO_MOVE_IN_DISABLED] == 1) {
			outputText("You offer Jojo the chance to stay at your camp, but before you can finish your sentance he shakes his head 'no' and stalks off into the woods, remembering.", false);
			doNext(13);
			return;
		}
		outputText("You offer Jojo the chance to stay at your camp.  He cocks his head to the side and thinks, stroking his mousey whiskers.\n\n\"<i>Yes, it would be wise.   We would be safer together, and if you like I could keep watch at night to keep some of the creatures away.  I'll gather my things and be right there!</i>\"\n\nJojo scurries into the bushes, disappearing in a flash.  Knowing him, he'll be at camp before you!", true);
		player.createStatusAffect("PureCampJojo",0,0,0,0);
		doNext(13);
		return;
	}
	//Jojo in camp
	if(eventNo == 2150) {
		spriteSelect(34);
		//Amily meets Jojo:
		if(flags[74] == 0 && flags[43] == 1 && amilyFollower()) {
			amilyMeetsPureJojo();
			return;
		}
		//Rathazul & Jojo
		if(flags[84] == 1 && rand(2) == 0) {
			catchRathazulNapping();
			return;
		}
		var jojoDefense:String = "N.Watch:";
		var jojoRape:Number = 0;
		outputText("You find Jojo sitting cross-legged on a flat rock with his staff leaning against his shoulder, thinking.  He looks to you and nods, \"<i>Greetings, " + player.short + ".  Is there something I could do to assist you?</i>\"\n\n", true);		
		if(player.hasStatusAffect("JojoNightWatch") >= 0) {
			jojoDefense += "On";
			outputText("(Jojo is currently watching for enemies at night.)\n\n", false);
		}
		else jojoDefense += "Off";
		if(player.lust >= 33 && player.gender > 0) jojoRape = 2153;
		//Menu with worm purge
		if(player.hasStatusAffect("infested") >= 0) {
			outputText("As you approach the serene monk, you see his nose twitch.\n\n", false);
			outputText("\"<i>It seems that the agents of corruption have taken residence within the temple that is your body,</i>\" Jojo says flatly, \"<i>This is a most unfortunate development. There is no reason to despair as there are always ways to fight the corruption. However, great effort will be needed to combat this form of corruption and may have a lasting impact upon you. If you are ready, we can purge your being of the rogue creatures of lust.</i>\"\n\n", false);
			simpleChoices("Meditate",2151,jojoDefense,2152,"Purge",2083,"Rape",jojoRape,"Leave",74);
			return;
		}
		//normal menu
		else simpleChoices("Meditate",2151,jojoDefense,2152,"",0,"Rape",jojoRape,"Leave",74);
		return;
	}
	//New meditate
	if(eventNo == 2151) {
		spriteSelect(34);
		if(player.statusAffectv1("Meditated") > 0) {
			outputText("Jojo smiles and meditates with you.  The experience is calming, but it's so soon after your last session that you don't get much benefit from it.", true);
			if(player.lust > 40) stats(0,0,0,0,0,0,-10,0);
			doNext(13);
			return;
		}
		outputText("The mouse monk leads you to a quiet spot away from the portal and the two of you sit down, him cross-legged and you mimicing to the best of your ability, back to back.  You close your eyes and meditate for half-an hour, centering your body and mind.  Afterwards, he guides you through stretches and exercises to help keep your bodies fit and healthy.\n\nWhen you are done, Jojo nods to you, and climbs back onto his rock, still thinking.", true);
		//OLD STAT LINE - stats(.25,.25,.25,.25,-1,0,-10,-2);
		//Reduces lust
		stats(0,0,0,0,0,0,-30,0);
		//Corruption reduction - faster at high corruption
		if(player.cor > 80) stats(0,0,0,0,0,0,0,-1);
		if(player.cor > 60) stats(0,0,0,0,0,0,0,-1);
		if(player.cor > 40) stats(0,0,0,0,0,0,0,-1);
		stats(0,0,0,0,0,0,0,-2);
		//Str boost to 45
		if(player.str < 45) stats(1,0,0,0,0,0,0,0);
		//Tou boost to 45
		if(player.tou < 45) stats(0,1,0,0,0,0,0,0);
		//Speed boost to 75
		if(player.spe < 75) stats(0,0,1,0,0,0,0,0);
		//Int boost to 80
		if(player.inte < 80) stats(0,0,0,1,0,0,0,0);
		//Libido lower to 15
		if(player.lib > 15) stats(0,0,0,0,-1,0,0,0);
		doNext(13);
		player.createStatusAffect("Meditated",1,0,0,0);
		return;
	}
	//Jojo defense toggle
	if(eventNo == 2152) {
		spriteSelect(34);
		clearOutput();
		if(player.hasStatusAffect("JojoNightWatch") >= 0) {
			player.removeStatusAffect("JojoNightWatch");
			outputText("You tell Jojo that you no longer need him to watch the camp at night.  He nods, then speaks.  \"<i>Alright.  Please let me know if you require my help again.</i>\"");
		}
		else {
			player.createStatusAffect("JojoNightWatch",0,0,0,0);
			outputText("You ask the monk if he could guard the camp for you at night.  He smiles politely.  \"<i>Certainly, [name].</i>\"");
		}
		doNext(2150);
		return;
	}
	//Take Jojo out and rape
	if(eventNo == 2153) {
		spriteSelect(34);
		player.removeStatusAffect("JojoNightWatch");
		player.removeStatusAffect("PureCampJojo");
		outputText("You ask Jojo if he'd like to go on a hunt through the woods to clear out some of the corrupted creatures, and the mouse readily agrees.  He asks if you've been getting a bit stir-crazy from having your camp in one place as the two of you walk into the woods...",true);
		doNext(2004);
	}
	//Hair dresser BJ
	if(eventNo == 2154) {
		goblinHairDresserFacefuck();
		return;
	}
	//Dog BJ
	if(eventNo == 2155) {
		gloryholeDoggie();
		return;
	}
	//Imp BJ
	if(eventNo == 2156) {
		gloryholeImp();
		return;
	}
	//Minotaur BJ
	if(eventNo == 2157) {
		gloryholeMinotaur();
		return;
	}
	//Incubus BJ
	if(eventNo == 2158) {
		gloryholeIncubus();
		return;
	}
	//Cut short
	if(eventNo == 2159) {
		cutShort();
		return;
	}
	//Cut Med
	if(eventNo == 2160) {
		cutMedium();
		return;
	}
	//CutLong
	if(eventNo == 2161) {
		cutLong();
		return;
	}
	//Lengthen Hair
	if(eventNo == 2162) {
		hairGrow();
		return;
	}
	//Dyes
	if(eventNo == 2163) {
		dyeMenu();
		return;
	}
	//Blue dye
	if(eventNo == 2164) {
		outputText("", true);
		shortName = "BlueDye";
		takeItem();
		return;
	}
	//orange dye
	if(eventNo == 2165) {
		outputText("", true);
		shortName = "OrangDy";
		takeItem();
		return;
	}
	//Pink Dye
	if(eventNo == 2166) {
		outputText("", true);
		shortName = "PinkDye";
		takeItem();
		return;
	}
	//Purple dye
	if(eventNo == 2167) {
		outputText("", true);
		shortName = "PurpDye";
		takeItem();
		return;
	}
	//Shop menu
	if(eventNo == 2168) {
		outputText("", true);
		hairDressingMainMenu();
		return;
	}
	//Shop encounter
	if(eventNo == 2169) {
		if(player.hasStatusAffect("hairdresser meeting") >= 0) {
			hairDresserRepeatGreeting();
			return;
		}
		else {
			player.createStatusAffect("hairdresser meeting",0,0,0,0);
			hairDresserGreeting();
			return;
		}
	}
	//Fuck faerie
	if(eventNo == 2170) {
		faerieCaptureHJ();
		return;
	}
	//Dont fuck faerie
	if(eventNo == 2171) {
		letFaerieGo();
		return;
	}
	//Encounter kelt
	if(eventNo == 2172) {
		breakingKeltOptions();
		//keltEncounter();
		return;
	}
	//Explore farm
	if(eventNo == 2173) {
		exploreFarm();
		return;
	}
	//Hook up tit milker
	if(eventNo == 2174) {
		whitneyMilkerHookup();
		return;
	}
	//Hook up cock milker
	if(eventNo == 2175) {
		whitneyMilkerHookup(false);
		return;
	}
	//Refuse hookup
	if(eventNo == 2176) {
		whitneyMilkerRefusal();
		return;
	}
	//Farm talkie
	if(eventNo == 2177) {
		talkWhitney();
		return;
	}	
	//Farm work
	if(eventNo == 2178) {
		workFarm();
		return;
	}
	//Milked work
	if(eventNo == 2179) {
		getMilked();
		return;
	}
	//Rathazul Armor Crafting
	if(eventNo == 2180) {
		doNext(13);
		craftCarapace();
		return;
	}
	//Marble Bad-End Continuation
	if(eventNo == 2181) {
		marbleBadEndFollowup();
		return;
	}
	//Buy breast-milker from whitney
	if(eventNo == 2182) {
		//[YES] 
		outputText("Whitney takes the gems and leaves with the promise of having your gear set up within the hour.  She calls back over her shoulder with a cryptic warning, \"<i>Watch how much time you spend getting milked like an animal, lest you wind up like one.</i>\"", true);
		doNext(13);
		player.createKeyItem("Breast Milker - Installed At Whitney's Farm",0,0,0,0);
		player.gems-=250;
		statScreenRefresh();
		return;
	}
	//[NO]
	if(eventNo == 2183) {
		doNext(13);
		outputText("Whitney shrugs and the two of you chat about other things, just passing the time and enjoying a relatively normal chat.", true);
		//+3 int if less than 15, +2 int if less 20, +1 int if less than 30, +.5 int if less than 40.
		if(player.inte < 15) stats(0,0,0,1,0,0,0,0);
		if(player.inte < 20) stats(0,0,0,1,0,0,0,0);
		if(player.inte < 30) stats(0,0,0,.5,0,0,0,0);
		if(player.inte < 40) stats(0,0,0,.5,0,0,0,0);
		return;
	}
	//Cock pump go
	if(eventNo == 2184) {
		doNext(13);
		cockPumping();
		return;
	}
	//Female faerie rape
	if(eventNo == 2185) {
		faerieRAEP();
		return;
	}
	//Female do nothing
	if(eventNo == 2186) {
		faerieDoNothing();
		return;
	}
	//Female shoo
	if(eventNo == 2187) {
		faerieShooAway();
		return;
	}
	//Cow Bad End 1
	if(eventNo == 2188) {
		cowBadEnd1();
		return;
	}
	//Cow Bad End 2
	if(eventNo == 2189) {
		cowBadEnd2();
		return;
	}
	//Continuing mino voyeurism
	if(eventNo == 2190) {
		outputText("They go at it for nearly an hour, oblivious to you watching them, before their intensity heightens as they near orgasm. The results are almost explosive, both of them crying out as they begin twitching uncontrollably. Clinging desperately to the cow-girl's ass, the minotaur pumps so much cum into her depths that it begins spurting out. This accidental lubrication releases his grip and the pair collapse to the ground. Yet the minotaur isn't finished, his man-milk spraying into the air almost like his still-erect dick is a hose and splattering down onto both of them.\n\n", true);
		outputText("As you look at the two cum-covered creatures laying their in their exhausted sex-induced stupors, the minotaur's thick horse-cock now slowly deflating, you realize that you've been touching yourself.  You make yourself stop ", false);
		//[low corruption]
		if(player.cor < 33) outputText("in disgust.", false);
		else if(player.cor < 66) outputText("in confusion.", false);
		else outputText("reluctantly.", false);
		outputText("\n\nOnly now do you notice other faces peeking over ledges and ridges. You count at least two goblins and one imp who quickly pull back. From the sounds, they were busy getting themselves off.", false);
		//[if first appearance of this event]
		if(player.statusAffectv1("Mino + Cowgirl") == 0) outputText("  Apparently this isn't an uncommon show, and the locals enjoy it immensely.", false);
		//Lust!
		stats(0,0,0,0,0,0,5+player.lib/20+player.minoScore()+player.cowScore(),0);
		doNext(13);
		return;
	}
	//Bad end for going full demon
	if(eventNo == 2191) {
		demonBadEnd();
		return;
	}
	//Bad end for going full demon
	if(eventNo == 2192) {
		demonBadEnd2();
		return;
	}
	if(eventNo == 2193) {
		tamaniFemaleYes();
		return;
	}
	if(eventNo == 2194) {
		tamaniFemaleNo();
		return;
	}
	if(eventNo == 2195) {
		tamaniFirstTimeConsentual();
		return;
	}
	if(eventNo == 2196) {
		tamaniFirstTimeRefusal();
		return;
	}
	if(eventNo == 2197) {
		tamaniSecondRefusal();
		return;
	}
	if(eventNo == 2198) {
		tamaniSexLetHer();
		return;
	}
	if(eventNo == 2199) {
		tamaniSexLost();
		return;
	}
	if(eventNo == 2200) {
		tamaniSexWon();
		return;
	}
	if(eventNo == 2201) {
		tamaniPregnantFuck();
		return;
	}
	if(eventNo == 2202) {
		tamaniPregnantRefusal();
		return;
	}
	if(eventNo == 2203) {
		outputText("Tamani adopts a fighting pose and says, \"<i>If I have to I'll beat my children out of you!</b>\"", true);
		startCombat(17);
		return;
	}
	if(eventNo == 2204) {
		exgartuanBeeRape();
		return;
	}
	if(eventNo == 2205) {
		freeBeePostRape();
		return;
	}
	if(eventNo == 2206) {
		leaveBeePostRape();
		return;
	}
	if(eventNo == 2207) {
		drinkFountainEndowment();
		return;
	}
	if(eventNo == 2208) {
		discoverTelAdre();
		return;
	}
	if(eventNo == 2209) {
		encounterTelAdre();
		return;
	}
	if(eventNo == 2210) {
		telAdreTour();
		return;
	}
	if(eventNo == 2211) {
		telAdreMenu();
		return;
	}
	if(eventNo == 2212) {
		piercingStudio();
		return;
	}
	if(eventNo == 2213) {
		pierceMenu();
		return;
	}
	if(eventNo == 2214) {
		chooseMaterials();
		return;
	}
	if(eventNo == 2215) {
		clitPierce();
		return;
	}
	if(eventNo == 2216) {
		dickPierce();
		return;
	}
	if(eventNo == 2217) {
		earPierce();
		return;
	}
	if(eventNo == 2218) {
		eyebrowPierce();
		return;
	}
	if(eventNo == 2219) {
		lipPierce();
		return;
	}
	if(eventNo == 2220) {
		nipplePierce();
		return;
	}
	if(eventNo == 2221) {
		nosePierce();
		return;
	}
	if(eventNo == 2222) {
		tonguePierce();
		return;
	}
	if(eventNo == 2223) {
		vulvaPierce();
		return;
	}
	if(eventNo == 2224) {
		chooseStud();
		return;
	}
	if(eventNo == 2225) {
		chooseRing();
		return;
	}
	if(eventNo == 2226) {
		chooseLadder();
		return;
	}
	if(eventNo == 2227) {
		chooseHoop();
		return;
	}
	if(eventNo == 2228) {
		chooseChain();
		return;
	}
	if(eventNo == 2229) {
		chooseMaterials();
		return;
	}
	if(eventNo == 2230) {
		normalPierceAssemble();
		return;
	}
	if(eventNo == 2231) {
		chooseAmethyst();
		return;
	}
	if(eventNo == 2232) {
		chooseDiamond();
		return;
	}
	if(eventNo == 2233) {
		chooseGold();
		return;
	}
	if(eventNo == 2234) {
		chooseEmerald();
		return;
	}
	if(eventNo == 2235) {
		chooseJade();
		return;
	}
	if(eventNo == 2236) {
		chooseOnyx();
		return;
	}
	if(eventNo == 2237) {
		chooseRuby();
		return;
	}
	if(eventNo == 2238) {
		chooseSteel();
		return;
	}
	if(eventNo == 2239) {
		aboutYara();
		return;
	}
	if(eventNo == 2240) {
		piercingRemove();
		return;
	}
	if(eventNo == 2241) {
		removeClitPierce();
		return;
	}
	if(eventNo == 2242) {
		removeCockPierce();
		return;
	}
	if(eventNo == 2243) {
		removeEarsPierce();
		return;
	}
	if(eventNo == 2244) {
		removeEyebrowPierce();
		return;
	}
	if(eventNo == 2245) {
		removeLipPierce();
		return;
	}
	if(eventNo == 2246) {
		removeNipplesPierce();
		return;
	}
	if(eventNo == 2247) {
		removeNosePierce();
		return;
	}
	if(eventNo == 2248) {
		removeTonguePierce();
		return;
	}
	if(eventNo == 2249) {
		removeVulvaPierce();
		return;
	}
	if(eventNo == 2250) {
		chooseAdvancedMaterials();
		return;
	}
	if(eventNo == 2251) {
		chooseLethite();
		return;
	}
	if(eventNo == 2252) {
		chooseFertite();
		return;
	}
	if(eventNo == 2253) {
		chooseFurrite();
		return;
	}
	if(eventNo == 2254) {
		chooseCrimstone();
		return;
	}
	if(eventNo == 2255) {
		oswaldPawn();
		return;
	}
	if(eventNo == 2256) {
		barTelAdre();
		return;
	}
	if(eventNo == 2257) {
		edrynBarTalk();
		return;
	}
	if(eventNo == 2258) {
		fuckEdrynNonTaur();
		return;
	}
	if(eventNo == 2259) {
		edrynSexSelecter();
		return;
	}
	if(eventNo == 2260) {
		keltResistancePussyOut();
		return;
	}
	if(eventNo == 2261) {
		fuckKeltsShitUp();
		return;
	}
	if(eventNo == 2262) {
		keltResistance();
		return;
	}
	if(eventNo == 2263) {
		beeGirlsGetsDildoed();
		return;
	}
	if(eventNo == 2264) {
		sharkGirlGetsDildoed();
		return;
	}
	if(eventNo == 2265) {
		sandwitchGetsDildoed();
		return;
	}
	if(eventNo == 2266) {
		succubusGetsDildoed();
		return;
	}
	if(eventNo == 2267) {
		marbleNightSexDudes();
		return;
	}
	if(eventNo == 2268) {
		marbleNightSexChicks();
		return;
	}
	if(eventNo == 2269) {
		giveMarbleLactaid();
		return;
	}
	if(eventNo == 2270) {
		MarblepinkEgg();
		return;
	}
	if(eventNo == 2271) {
		MarbleLPinkEgg();
		return;
	}
	if(eventNo == 2272) {
		marbleOvulatesLikeMadDawg();
		return;
	}
	if(eventNo == 2273) {
		MarbleDigsDraftsYo();
		return;
	}
	if(eventNo == 2274) {
		armorShop();
		return;
	}
	if(eventNo == 2275) {
		armorBuy();
		return;
	}
	if(eventNo == 2276) {
		shortName = "ChBikni";
		armorBuy();
		return;
	}
	if(eventNo == 2277) {
		shortName = "FullChn";
		armorBuy();
		return;
	}
	if(eventNo == 2278) {
		shortName = "FullPlt";
		armorBuy();
		return;
	}
	if(eventNo == 2279) {
		shortName = "IndecSt";
		armorBuy();
		return;
	}
	if(eventNo == 2280) {
		shortName = "LthrRob";
		armorBuy();
		return;
	}
	if(eventNo == 2281) {
		shortName = "ScaleMl";
		armorBuy();
		return;
	}
	if(eventNo == 2282) {
		debitArmor();
		return;
	}
	if(eventNo == 2283) {
		urtaBarDescript();
		return;
	}
	if(eventNo == 2284) {
		urtaBarApproach();
		return;
	}
	if(eventNo == 2285) {
		drinkUrtasBooze();
		return;
	}
	if(eventNo == 2286) {
		drinkUrtasBoozePtTwo();
		return;
	}
	if(eventNo == 2287) {
		drinkUrtasBoozeRun();
		return;
	}
	if(eventNo == 2288) {
		drinkUrtasBoozeLetHer();
		return;
	}
	if(eventNo == 2289) {
		urtaFollowedOutBack();
		return;
	}
	if(eventNo == 2290) {
		urtaSneakAwayFromMasturbate();
		return;
	}
	if(eventNo == 2291) {
		watchUrtaJerkIt();
		return;
	}
	if(eventNo == 2292) {
		dualUrtaMasturbation();
		return;
	}
	if(eventNo == 2293) {
		urtaFuckHer();
		return;
	}
	if(eventNo == 2294) {
		urtaSneakAwayFromMasturbate();
		return;
	}
	if(eventNo == 2295) {
		blowUrtaUnderTable();
		return;
	}
	if(eventNo == 2296) {
		takeUrtaInTheButtPublically();
		return;
	}
	if(eventNo == 2297) {
		getAPublicFacialFromUrta();
		return;
	}
	if(eventNo == 2298) {
		optionalUrtaBukkake();
		return;
	}
	if(eventNo == 2299) {
		declineUrtaBukkake();
		return;
	}
	if(eventNo == 2300) {
		goBackToUrtasForLuvinz();
		return;
	}
	if(eventNo == 2301) {
		rideUrtaTenderFemale();
		return;
	}
	if(eventNo == 2302) {
		dudeFuckingUrtasCooch();
		return;
	}
	if(eventNo == 2303) {
		fuckUrtasVagButTooBig();
		return;
	}
	if(eventNo == 2304) {
		fuckItAndLeave();
		return;
	}
	if(eventNo == 2305) {
		tenderTakeItUpTheAssFromUrta();
		return;
	}
	if(eventNo == 2306) {
		supahAkabalEdition();
		return;
	}
	if(eventNo == 2307) {
		superAkbalioTalk();
		return;
	}
	if(eventNo == 2308) {
		repeatAkbalPostSubmission();
		return;
	}
	if(eventNo == 2309) {
		akbalDeny();
		return;
	}
	if(eventNo == 2310) {
		 ackbalRepeatAfterWin();
		return;
	}
	if(eventNo == 2311) {
		ackbalRepeatAfterLoss();
		return;
	}
	if(eventNo == 2312) {
		startuAkabalFightomon();
		return;
	}
	if(eventNo == 2313) {
		akbalSubmit();
		return;
	}
	if(eventNo == 2314) {
		akbalSubmissionFollowup();
		return;
	}
	if(eventNo == 2315) {
		minoAddictionBadEndEncounter();
		return;
	}
	if(eventNo == 2316) {
		minoAddictionBadEnd2();
		return;
	}
	if(eventNo == 2317) {
		minoCumAddictBadEnd3();
		return;
	}
	if(eventNo == 2318) {
		maleFuckCeraphsPussy();
		return;
	}
	if(eventNo == 2319) {
		rideCeraphsCockLikeaBAWSSexclamation11eleven();
		return;
	}
	if(eventNo == 2320) {
		loseToCeraphAndGetPiercingsInEarsOrSomethingSomehow();
		return;
	}
	if(eventNo == 2321) {
		loseToCeraphAnGetPierced2();
		return;
	}
	if(eventNo == 2322) {
		getPiercedByCeraphLoss3();
		return;
	}
	if(eventNo == 2323) {
		finalEncounterLevelCeraphPiercingButtholeNipples();
		return;
	}
	if(eventNo == 2324) {
		finalCeraphEncounterChoiceNo();
		return;
	}
	if(eventNo == 2325) {
		finalCeraphEncounterStartFight();
		return;
	}
	if(eventNo == 2326) {
		agreeToBecomeCeraphsFuckpetBondageToyBitchSlut();
		return;
	}
	if(eventNo == 2327) {
		agreeToBeABitchPt2();
		return;
	}
	if(eventNo == 2328) {
		ceraphFirstTime();
		return;
	}
	if(eventNo == 2329) {
		ceraphFirstTimeDecline();
		return;
	}
	if(eventNo == 2330) {
		ceraphFirstTimeVolunteer();
		return;
	}
	if(eventNo == 2331) {
		ceraphFirstTimeRepeat();
		return;
	}
	if(eventNo == 2332) {
		level3CeraphOffer();
		return;
	}
	if(eventNo == 2333) {
		level3CeraphOfferNo();
		return;
	}
	if(eventNo == 2334) {
		yesOHGODYESPIERCELEVEL3();
		return;
	}
	if(eventNo == 2335) {
		ceraphBindingStruggle();
		return;
	}
	if(eventNo == 2336) {
		ceraphBoundWait();
		return;
	}
	if(eventNo == 2337) {
		outputText("", true);
		shortName = "ExtSerm";
		takeItem();
		return;
	}
	if(eventNo == 2338) {
		marbleCockuBlockuUrta();
		return;
	}
	if(eventNo == 2339) {
		TellUrtaDAHTRUUUUF();
		return;
	}
	if(eventNo == 2340) {
		comfortUrtaAfterTellinTruuf();
		return;
	}
	if(eventNo == 2341) {
		toughenUpUrtaAfterTellingTruuf();
		return;
	}
	if(eventNo == 2342) {
		walkoutOnUrtaAfterTellingTruff();
		return;
	}
	if(eventNo == 2343) {
		trufftrufftrufftruff();
		return;
	}
	if(eventNo == 2344) {
		lietoUrtaAboutMarble();
		return;
	}
	if(eventNo == 2345) {
		UrtaTwuWuvOffer();
		return;
	}
	if(eventNo == 2346) {
		noUDontLoveUrta();
		return;
	}
	if(eventNo == 2347) {
		stayFuckbuddiesAfterShootingDown();
		return;
	}
	if(eventNo == 2348) {
		turnDownFuckbuddiesANDLove();
		return;
	}
	if(eventNo == 2349) {
		TwuWuvIsBeautifulUrta();
		return;
	}
	if(eventNo == 2350) {
		eatUrtaOutNomNomPussy();
		return;
	}
	if(eventNo == 2351) {
		giveUrtaCumGlass();
		return;
	}
	if(eventNo == 2352) {
		drinkUrtasCumGlass();
		return;
	}
	if(eventNo == 2353) {
		setAsideUrtaCumGlass();
		return;
	}
	if(eventNo == 2354) {
		blowUrtaUnderTheTableLuv();
		return;
	}
	if(eventNo == 2355) {
		rideUrtasCoochLoveyDovey();
		return;
	}
	if(eventNo == 2356) {
		rideUrtaInButtAtHomeLove();
		return;
	}
	if(eventNo == 2357) {
		oralFiestyUberExplosionUrta();
		return;
	}
	if(eventNo == 2358) {
		urtaHomeLuvLuvinsMenu();
		return;
	}
	if(eventNo == 2359) {
		declineXmasPresent();
		return;
	}
	if(eventNo == 2360) {
		watchUrtaBeABadass();
		return;
	}	
	if(eventNo == 2361) {
		openXmasPresent();
		return;
	}	
	if(eventNo == 2362) {
		unwrapElfyPresent();
		return;
	}	
	if(eventNo == 2363) {
		xmasFuckFollowup();
		return;
	}	
	if(eventNo == 2364) {
		xmasFuckFollowupFems();
		return;
	}	
	if(eventNo == 2365) {
		xmasSmart();
		return;
	}	
	if(eventNo == 2366) {
		xmasPerkM()
		return;
	}	
	if(eventNo == 2367) {
		urtasCoochiNeedsFuckedLove();
		return;
	}	
	if(eventNo == 2368) {
		discoverAmilyVillage();
		return;
	}	
	if(eventNo == 2369) {
		dontExploreAmilyVillage();
		return;
	}	
	if(eventNo == 2370) {
		exploreAmilyVillage();
		return;
	}
	if(eventNo == 2371) {
		exploreVillageRuin();
		return;
	}	
	if(eventNo == 2372) {
		acceptAmilysOfferEagerly();
		return;
	}
	if(eventNo == 2373) {
		acceptAmilyOfferHesitantly();
		return;
	}
	if(eventNo == 2374) {
		refuseAmilysOffer();
		return;
	}
	if(eventNo == 2375) {
		remeetingAmilyAnnounceSelf();
		return;
	}
	if(eventNo == 2376) {
		remeetingAmilyScare();
		return;
	}
	if(eventNo == 2377) {
		amilyRemeetingContinued();
		return;
	}
	if(eventNo == 2378) {
		secondTimeAmilyOfferedAccepted();
		return;
	}
	if(eventNo == 2379) {
		secondTimeAmilyRefuseAgain();
		return;
	}
	if(eventNo == 2380) {
		repeatAmilyTalk();
		return;
	}
	if(eventNo == 2381) {
		tellAmilyToGetLost();
		return;
	}
	if(eventNo == 2382) {
		sexWithAmily();
		return;
	}
	if(eventNo == 2383) {
		talkToAmily();
		return;
	}
	if(eventNo == 2384) {
		talkThenSexWithAmily();
		return;
	}
	if(eventNo == 2385) {
		sneakyUberAmilyRemeetingsAnnounce();
		return;
	}
	if(eventNo == 2386) {
		scareAmilyRemeetingsProBaws();
		return;
	}
	if(eventNo == 2387) {
		announceSelfOnDesperatePleaMeeting();
		return;
	}
	if(eventNo == 2388) {
		scareAmilyOnDesperatePleaMeeting();
		return;
	}
	if(eventNo == 2389) {
		desperateFinallyAmily();
		return;
	}
	if(eventNo == 2390) {
		desperateAmilyPleaAcceptHer();
		return;
	}
	if(eventNo == 2391) {
		desperateAmilyPleaTurnDown();
		return;
	}
	if(eventNo == 2392) {
		desperateAmilyPleaTurnDownBlunt();
		return;
	}
	if(eventNo == 2393) {
		fuckingMouseBitchPopsShitOut();
		return;
	}
	if(eventNo == 2394) {
		pregnancyIsScaryGoddamnMousePregnancyImNotWatchingThisShit();
		return;
	}
	if(eventNo == 2395) {
		heyIGotTicketsToMicePoppingOut();
		return;
	}
	if(eventNo == 2396) {
		helpThatFukkinUngratefulBitchGiveBirth();
		return;
	}
	if(eventNo == 2397) {
		thisIsAReallyShittyBadEnd();
		return;
	}
	if(eventNo == 2398) {
		thisFunctionProbablySucksTooOhYeahAmilyFunction();
		return;
	}
	if(eventNo == 2399) {
		//No sex after
		talkWithCuntIMeanAmily(false);
		return;
	}
	if(eventNo == 2400) {
		//sex after
		talkWithCuntIMeanAmily(true);
		return;
	}
	if(eventNo == 2401) {
		stickItInMouseTwatForTheFirstTimeNOTWORTHALLBULLSHIT();
		return;
	}
	if(eventNo == 2402) {
		FirstTimeAmilyTakeCharge();
		return;
	}
	if(eventNo == 2403) {
		beSomeKindofNervousDoucheAndWaitForAmily();
		return;
	}
	if(eventNo == 2404) {
		kissAmilyInDaMoufFirstTimeIsSomehowBetterThatWay();
		return;
	}
	if(eventNo == 2405) {
		amilySexHappens();
		return;
	}
	if(eventNo == 2406) {
		amilySexBusiness();
		return;
	}
	if(eventNo == 2407) {
		amilySexPlaytimeFirst();
		return;
	}
	if(eventNo == 2408) {
		amilySexPtII();
		return;
	}
	if(eventNo == 2409) {
		sitAndWatchAmilySex();
		return;
	}
	if(eventNo == 2410) {
		caressAmilyHaveSex();
		return;
	}
	if(eventNo == 2411) {
		AmilyGetKissed();
		return;
	}
	if(eventNo == 2412) {
		AmilyTakeTheKiss();
		return;
	}
	if(eventNo == 2413) {
		continueAmilySmex();
		return;
	}
	if(eventNo == 2414) {
		amilyEnjoyShow();
		return;
	}
	if(eventNo == 2415) {
		amilyStepTheFuckIn();
		return;
	}
	if(eventNo == 2416) {
		AmilyMidSexLevel2();
		return;
	}
	if(eventNo == 2417) {
		StripForAmilyYouSlut();
		return;
	}
	if(eventNo == 2418) {
		getDownWithSexTiem();
		return;
	}
	if(eventNo == 2419) {
		continueWithMoreMidLevelAmilySex();
		return;
	}
	if(eventNo == 2420) {
		playAlongWithAmilyWhataDumbBitch();
		return;
	}
	if(eventNo == 2421) {
		workToPleaseTheCunt();
		return;
	}
	if(eventNo == 2422) {
		AmilyMiddleGradeSexOver();
		return;
	}
	if(eventNo == 2423) {
		sayGoodByeToAmilyPostSecks();
		return;
	}
	if(eventNo == 2424) {
		stayAfterAmilyMiddleGradeSecks();
		return;
	}
	if(eventNo == 2425) {
		amilyHighAffectionSecks();
		return;
	}
	if(eventNo == 2426) {
		fuckAmilyPreg();
		return;
	}
	if(eventNo == 2427) {
		amilyFollowerEncounter();
		return;
	}
	if(eventNo == 2428) {
		amilyAppearance();
		return;
	}
	if(eventNo == 2429) {
		talkToAmilyCamp();
		return;
	}
	if(eventNo == 2430) {
		fuckTheMouseBitch();
		return;
	}
	if(eventNo == 2431) {
		amilyTakesChargeSex();
		return;
	}
	if(eventNo == 2432) {
		letAmilyLead();
		return;
	}
	if(eventNo == 2433) {
		giveAmilyAPresent();
		return;
	}
	if(eventNo == 2434) {
		lumiEncounter();
		return;
	}
	if(eventNo == 2435) {
		lumiLabChoices();
		return;
	}
	if(eventNo == 2436) {
		lumiShop();
		return;
	}
	if(eventNo == 2437) {
		lumiLustDraftPitch();
		return;
	}
	if(eventNo == 2438) {
		lumiPitchGobboAle();
		return;
	}
	if(eventNo == 2439) {
		lumiPitchOviElixer();
		return;
	}
	if(eventNo == 2440) {
		lumiPurchase();
		return;
	}
	if(eventNo == 2441) {
		lumiEnhance();
		return;
	}
	if(eventNo == 2442) {
		lumiEnhanceLaBova();
		return;
	}
	if(eventNo == 2443) {
		lumiEnhanceSDelight();
		return;
	}
	if(eventNo == 2444) {
		lumiEnhanceOviElix();
		return;
	}
	if(eventNo == 2445) {
		lumiEnhanceDraft();
		return;
	}
	if(eventNo == 2446) {
		lumiEnhanceGo();
		return;
	}
	if(eventNo == 2447) {
		talkToScylla();
		return;
	}
	if(eventNo == 2448) {
		helpScylla();
		return;
	}
	if(eventNo == 2449) {
		dontHelpScylla();
		return;
	}
	if(eventNo == 2450) {
		scyllaRoundII();
		return;
	}
	if(eventNo == 2451) {
		scyllaRoundIIPartII();
		return;
	}
	if(eventNo == 2452) {
		scyllaRoundIIPartIII();
		return;
	}
	if(eventNo == 2453) {
		giveAmilyPureIncubusDraft();
		return;
	}
	if(eventNo == 2454) {
		giveAmilyPureIncubusDraft4Realz();
		return;
	}
	if(eventNo == 2455) {
		declineToMakeAmilyFuta();
		return;
	}
	if(eventNo == 2456) {
		giveAmilyPurifiedSuccubusMilk();
		return;
	}
	if(eventNo == 2457) {
		giveAmilyAPinkEgg();
		return;
	}
	if(eventNo == 2458) {
		giveAmilyAWhiteEgg();
		return;
	}
	if(eventNo == 2459) {
		giveAmilyABrownEgg();
		return;
	}
	if(eventNo == 2460) {
		giveAmilyAPurpleEgg();
		return;
	}
	if(eventNo == 2461) {
		giveAmilySomePants();
		return;
	}
	if(eventNo == 2462) {
		scyllaRoundThreeCUM();
		return;
	}
	if(eventNo == 2463) {
		scyllaIIIBellyChat();
		return;
	}
	if(eventNo == 2464) {
		scyllaIIIHOWZUBREETH();
		return;
	}
	if(eventNo == 2465) {
		scyllaLevelIIIRoundIIIFIGHT();
		return;
	}
	if(eventNo == 2466) {
		scyllaIIIFinisher();
		return;
	}
	if(eventNo == 2467) {
		getRapedByTamaniYouHypnoSlut();
		return;
	}
	if(eventNo == 2468) {
		encounterTamanisDaughters();
		return;
	}
	if(eventNo == 2469) {
		playDumbToTamanisDaughters();
		return;
	}
	if(eventNo == 2470) {
		fightTamanisDaughters();
		return;
	}
	if(eventNo == 2471) {
		fuckYoDaughtersHomie();
		return;
	}
	if(eventNo == 2472) {
		legTamanisDaughtersRAEPYou();
		return;
	}
	if(eventNo == 2473) {
		tamaniDaughtersCombatLossDrain();
		return;
	}
	if(eventNo == 2474) {
		tamaniDaughtersBadEndChoice();
		return;
	}
	if(eventNo == 2475) {
		tamaniDaughtersYesBadEndMePlease();
		return;
	}
	if(eventNo == 2476) {
		tamaniDaughtersDeclineBadEnd();
		return;
	}
	if(eventNo == 2477) {
		tamanisDaughtersFillIndividuallyBADEND();
		return;
	}
	if(eventNo == 2478) {
		loseToDaughtersWithTamaniThere();
		return;
	}
	if(eventNo == 2479) {
		fightTamanisDaughters(true);
		return;
	}
	if(eventNo == 2480) {
		rapeOozeWithMilk();
		return;
	}
	if(eventNo == 2481) {
		areImpsLactoseIntolerant();
		return;
	}
	if(eventNo == 2482) {
		giveGoblinAMilkMustache();
		return;
	}
	if(eventNo == 2483) {
		minotaurDrinksMilkNewsAtEleven();
		return;
	}
	if(eventNo == 2484) {
		milkAndHoneyAreKindaFunny();
		return;
	}
	if(eventNo == 2485) {
		fetishCultistHasAMilkFetish();
		return;
	}
	if(eventNo == 2486) {
		player.gems += 50;
		statScreenRefresh();
		if(player.hasStatusAffect("Camp Rathazul") >= 0) campRathazul();
		else encounterRathazul();
		return;
	}
	if(eventNo == 2487) {
		catAutoLick();
		return;
	}
	if(eventNo == 2488) {
		findOutEdrynIsPregnant();
		return;
	}
	if(eventNo == 2489) {
		shockedByEdrynsPregnancy();
		return;
	}
	if(eventNo == 2490) {
		shockedByPregdrynThenAccept();
		return;
	}
	if(eventNo == 2491) {
		beAnAssholeToPregdryn();
		return;
	}
	if(eventNo == 2492) {
		pleasedbyPregdryn();
		return;
	}
	if(eventNo == 2493) {
		arousedByPregdryn();
		return;
	}
	if(eventNo == 2494) {
		pregdrynOffer();
		return;
	}
	if(eventNo == 2495) {
		fuckPregEdryn();
		return;
	}
	if(eventNo == 2496) {
		jizzFromEatingPregdrynOut();
		return;
	}
	if(eventNo == 2497) {
		ceraphsNiceOffer();
		return;
	}
	if(eventNo == 2498) {
		spriteSelect(34);
		agreeToHelpAmilyFixJojo();
		return;
	}
	if(eventNo == 2499) {
		spriteSelect(34);
		tellAmilyToFuckOffRuinedJojo();
		return;
	}
	if(eventNo == 2500) {
		spriteSelect(34);
		AmilyLeavesBirdJojoTentacles();
		return;
	}
	if(eventNo == 2501) {
		aerisDies();
		return;
	}
	if(eventNo == 2502) {
		spriteSelect(34);
		stopJojoDeathInTheNameOfLove();
		return;
	}
	if(eventNo == 2503) {
		spriteSelect(34);
		whyWouldDoThis();
		return;
	}
	if(eventNo == 2504) {
		spriteSelect(34);
		tellRathazulYouOwnJojo();
		return;
	}
	if(eventNo == 2505) {
		spriteSelect(34);
		tellRathazulYouCanHandleIt();
		return;
	}
	if(eventNo == 2506) {
		spriteSelect(34);
		TellRathazulJojoIsHarmless();
		return;
	}
	if(eventNo == 2507) {
		marbleIsPissyAndYourTooDumbToTalk();
		return;
	}
	if(eventNo == 2508) {
		beAPimpMarbleLovesIt();
		return;
	}
	if(eventNo == 2509) {
		srslyPimpinGuyz();
		return;
	}
	if(eventNo == 2510) {
		jokeAboutPimpularness();
		return;
	}
	if(eventNo == 2511) {
		LucyYouGotSomeSplainingToDo();
		return;
	}
	if(eventNo == 2512) {
		BlameMarblezSweetVagoozle();
		return;
	}
	if(eventNo == 2513) {
		blameAmilysDumbMouseCunt();
		return;
	}
	if(eventNo == 2514) {
		WinOnHarpyAndOralRape();
		return;
	}
	if(eventNo == 2515) {
		winAndRapeHarpyAnally();
		return;
	}
	if(eventNo == 2516) {
		victoryHarpyGetsHerPussyRaped();
		return;
	}
	if(eventNo == 2517) {
		meetSophie();
		return;
	}
	if(eventNo == 2518) {
		meetSophieRepeat();
		return;
	}
	if(eventNo == 2519) {
		fightSophie();
		return;
	}
	if(eventNo == 2520) {
		repeatBreastFeeding();
		return;
	}
	if(eventNo == 2521) {
		PCIgnoresSophieAndHarpyIsFought();
		return;
	}
	if(eventNo == 2522) {
		sophieLookingForDemons();
		return;
	}
	if(eventNo == 2523) {
		shootDownSophieSex();
		return;
	}
	if(eventNo == 2524) {
		sophieMeetingChoseSex();
		return;
	}
	if(eventNo == 2525) {
		FirstTimeSophieForceSex();
		return;
	}
	if(eventNo == 2526) {
		sophieMeetingGotLost();
		return;
	}
	if(eventNo == 2527) {
		tellSophieYoureForagingForStuff();
		return;
	}
	if(eventNo == 2528) {
		cramANippleInIt();
		return;
	}
	if(eventNo == 2529) {
		consensualSexSelector();
		return;
	}
	if(eventNo == 2530) {
		postSophieSexSnuggle();
		return;
	}
	if(eventNo == 2531) {
		postSexSophieSnuggleTurnedDown();
		return;
	}
	if(eventNo == 2532) {
		consensualSophieSexNoFit();
		return;
	}
	if(eventNo == 2533) {
		maleVictorySophieRape();
		return;
	}
	if(eventNo == 2534) {
		maleVictorySophieRapeHUGE();
		return;
	}
	if(eventNo == 2535) {
		sophieVictoryPussyGrind();
		return;
	}
	if(eventNo == 2536) {
		fuckDatClit();
		return;
	}
	if(eventNo == 2537) {
		tinyDickSupremeSophieLoss();
		return;
	}
	if(eventNo == 2538) {
		normalLossRapuuuuSophie();
		return;
	}
	if(eventNo == 2539) {
		tooBigForOwnGoodSophieLossRape();
		return;
	}
	if(eventNo == 2540) {
		SophieLossRapeNoDonguuuu();
		return;
	}
	if(eventNo == 2541) {
		MaraeIIStageII();
		return;
	}
	if(eventNo == 2542) {
		MaraePt2RoundIIIPrizes();
		return;
	}
	if(eventNo == 2543) {
		MaraeIIFlyAway();
		return;
	}
	if(eventNo == 2544) {
		scyllaRoundIVPtII();
		return;
	}
	if(eventNo == 2545) {
		scyllaRoundIVPtIII();
		return;
	}
	if(eventNo == 2546) {
		scyllaRoundIVPtIVWATCH();
		return;
	}
	if(eventNo == 2547) {
		scyllaWatchSecondPartPoorImp();
		return;
	}
	if(eventNo == 2548) {
		scyllaWatchThirdPartOhShitSon();
		return;
	}
	if(eventNo == 2549) {
		scyllaPtIVKissPtI();
		return;
	}
	if(eventNo == 2550) {
		scyllaPtIVKissPtII();
		return;
	}
	if(eventNo == 2551) {
		scyllaPtIVKissPtIII();
		return;
	}
	if(eventNo == 2552) {
		scyllaPtIVEpilogue();
		return;
	}
	if(eventNo == 2553) {
		weaponShop();
		return;
	}
	if(eventNo == 2554) {
		shortName = "W.Staff";
		weaponBuy();
		return;
	}
	if(eventNo == 2555) {
		debitWeapon();
		return;
	}
	if(eventNo == 2556) {
		shortName = "W.Stick";
		weaponBuy();
		return;
	}
	if(eventNo == 2557) {
		shortName = "Claymor";
		weaponBuy();
		return;
	}
	if(eventNo == 2558) {
		shortName = "Warhamr";
		weaponBuy();
		return;
	}
	if(eventNo == 2559) {
		shortName = "Katana ";
		weaponBuy();
		return;
	}
	if(eventNo == 2560) {
		shortName = "Spear  ";
		weaponBuy();
		return;
	}
	if(eventNo == 2561) {
		shortName = "Whip   ";
		weaponBuy();
		return;
	}
	if(eventNo == 2562) {
		shortName = "S.Gaunt";
		weaponBuy();
		return;
	}
	if(eventNo == 2563) {
		scyllaAdictsAnonV();
		return;
	}
	if(eventNo == 2564) {
		scyllaPtVFirstTime();
		return;
	}
	if(eventNo == 2565) {
		scyllaPtVFirstTimeII();
		return;
	}
	if(eventNo == 2566) {
		scyllaPtVRepeat();
		return;
	}
	if(eventNo == 2567) {
		scyllaPtVLeave();
		return;
	}
	if(eventNo == 2568) {
		scyllaPtVTakeAdvantage();
		return;
	}
	if(eventNo == 2569) {
		scyllaPtVShare();
		return;
	}
	if(eventNo == 2570) {
		scyllaPtVNoDiscussion();
		return;
	}
	if(eventNo == 2571) {
		scyllaPtVMilk();
		return;
	}
	if(eventNo == 2572) {
		scyllaPtVMilkII();
		return;
	}
	if(eventNo == 2573) {
		scyllaPtVMilkIII();
		return;
	}
	if(eventNo == 2574) {
		scyllaPtVMilkIV();
		return;
	}
	if(eventNo == 2575) {
		scyllaPtVMilkV();
		return;
	}
	if(eventNo == 2576) {
		scyllaPtVCum();
		return;
	}
	if(eventNo == 2577) {
		scyllaPtVCumII();
		return;
	}
	if(eventNo == 2578) {
		scyllaPtVCumIII();
		return;
	}
	if(eventNo == 2579) {
		scyllaPtVCumIV();
		return;
	}
	if(eventNo == 2580) {
		scyllaPtVCumV();
		return;
	}
	if(eventNo == 2581) {
		scyllaPtVSex();
		return;
	}
	if(eventNo == 2582) {
		scyllaPtVSexII();
		return;
	}
	if(eventNo == 2583) {
		scyllaPtVSexIII();
		return;
	}
	if(eventNo == 2584) {
		scyllaPtVSexIV();
		return;
	}
	if(eventNo == 2585) {
		milkerBadEnd1();
		return;
	}
	if(eventNo == 2586) {
		leavePonies();
		return;
	}
	if(eventNo == 2587) {
		approachPonies();
		return;
	}
	if(eventNo == 2588) {
		derpPolitely();
		return;
	}
	if(eventNo == 2589) {
		derpCreepy();
		return;
	}
	if(eventNo == 2590) {
		derpyParty();
		return;
	}
	if(eventNo == 2591) {
		rapeAnemoneWithPussy();
		return;
	}
	if(eventNo == 2592) {
		rapeAnemoneWithDick();
		return;
	}
	if(eventNo == 2593) {
		victoryButtholeRape();
		return;
	}
	if(eventNo == 2594) {
		freeValazLooseCoochie();
		return;
	}
	if(eventNo == 2595) {
		useVala();
		return;
	}
	if(eventNo == 2596) {
		useValaPtII();
		return;
	}
	if(eventNo == 2597) {
		healVala();
		return;
	}
	if(eventNo == 2598) {
		healValaPartTwoTheHealingHealsOfRevenge();
		return;
	}
	if(eventNo == 2599) {
		ValaGetsSexed();
		return;
	}
	if(eventNo == 2600) {
		valaGetsSexedPtDuece();
		return;
	}
	if(eventNo == 2601) {
		rejectFuckingVala();
		return;
	}
	if(eventNo == 2602) {
		loseToValaAsHermPartII();
		return;
	}
	if(eventNo == 2603) {
		badEndValaNumber1();
		return;
	}
	if(eventNo == 2604) {
		badEndValaNumber2();
		return;
	}
	if(eventNo == 2605) {
		badEndValaNumber2Pt2();
		return;
	}
	if(eventNo == 2606) {
		loseToValaAsMaleIITight();
		return;
	}
	if(eventNo == 2607) {
		loseToValaMaleIILoose();
		return;
	}
	if(eventNo == 2608) {
		loseToValaMaleIIVeryLoose();
		return;
	}
	if(eventNo == 2609) {
		loseToValaMaleIIGape();
		return;
	}
	if(eventNo == 2610) {
		loseToValueFemalePtII();
		return;
	}
	if(eventNo == 2611) {
		loseToValaFemale();
		return;
	}
	if(eventNo == 2612) {
		valaFightVictoryFuck();
		return;
	}
	if(eventNo == 2613) {
		valaFightVictoryFuckPtII();
		return;
	}
	if(eventNo == 2614) {
		leftValaAlone();
		return;
	}
	if(eventNo == 2615) {
		tryToHealVala();
		return;
	}
	if(eventNo == 2616) {
		tryToHealValaWHoney2();
		return;
	}
	if(eventNo == 2617) {
		useValaOHYEAHSNAPINTOASLIMJIM();
		return;
	}
	if(eventNo == 2618) {
		useValaOHYEAHKOOLAIDPTII();
		return;
	}
	if(eventNo == 2619) {
		wakeValaUpBeforeYouGoGo();
		return;
	}
	if(eventNo == 2620) {
		wakeMeUpBeforeValaGoGosPtII()
		return;
	}
	if(eventNo == 2621) {
		chooseValaInBar();
		return;
	}
	if(eventNo == 2622) {
		cleansedFirstRemeet();
		return;
	}
	if(eventNo == 2623) {
		cleansedValaFuckHerBrainsOut();
		return;
	}
	if(eventNo == 2624) {
		cleansedValaFuckHerBrainsOutPtII();
		return;
	}
	if(eventNo == 2625) {
		cleansedValaRepeatBrainFucking();
		return;
	}
	if(eventNo == 2626) {
		faerieOrgyFuck();
		return;
	}
	if(eventNo == 2627) {
		faerieOrgyFuckMaleContinue();
		return;
	}
	if(eventNo == 2628) {
		faerieOrgyFuckFemaleContinue();
		return;
	}
	if(eventNo == 2629) {
		femaleZetazOverPtII();
		return;
	}
	if(eventNo == 2630) {
		hermZetazOverPtII();
		return;
	}
	if(eventNo == 2631) {
		malesZetazOverPtII();
		return;
	}
	if(eventNo == 2632) {
		zetazBadEndEpilogue();
		return;
	}
	if(eventNo == 2633) {
		endZetaz();
		return;
	}
	if(eventNo == 2634) {
		sexualTortureTightenZetaz();
		return;
	}
	if(eventNo == 2635) {
		sexualTortureReleaseZetaz();
		return;
	}
	if(eventNo == 2636) {
		sexualInterrogation();
		return;
	}
	if(eventNo == 2637) {
		releaseZForInfo();
		return;
	}
	if(eventNo == 2638) {
		outputText("", true);
		shortName = "BonStrp";
		flags[129]++;
		takeItem();
		return;
	}
	if(eventNo == 2639) {
		spriteSelect(52);
		theSeanShopOffer();
		return;
	}
	if(eventNo == 2640) {
		spriteSelect(52);
		incubusDeal();
		return;
	}
	if(eventNo == 2641) {
		spriteSelect(52);
		incubusNoDeal();
		return;
	}
	if(eventNo == 2642) {
		spriteSelect(52);
		incubusShop();
		return;
	}
	if(eventNo == 2643) {
		spriteSelect(52);
		shortName = "NumbRox";
		incubusBuy();
		return;
	}
	if(eventNo == 2644) {
		spriteSelect(52);
		shortName = "SensDrf";
		incubusBuy();
		return;
	}
	if(eventNo == 2645) {
		spriteSelect(52);
		shortName = "Reducto";
		incubusBuy();
		return;
	}
	if(eventNo == 2646) {
		spriteSelect(52);
		incubusTransact();
		return;
	}
	if(eventNo == 2647) {
		talkToBunnyBunBun();
		return;
	}
	if(eventNo == 2648) {
		rapeBunBun();
		return;
	}
	if(eventNo == 2649) {
		bunbunFucksYourVag();
		return;
	}
	if(eventNo == 2650) {
		bunbunFucksPCInAss();
		return;
	}
	if(eventNo == 2651) {
		bunbunGetsFucked();
		return;
	}
	if(eventNo == 2652) {
		bunbun69();
		return;
	}
	if(eventNo == 2653) {
		shortName = "SucWhip";
		incubusBuy();
		return;
	}
	if(eventNo == 2654) {
		meetRaphaelPtII();
		return;
	}
	if(eventNo == 2655) {
		RaphaelFirstMeetingSLAP();
		return;
	}
	if(eventNo == 2656) {
		RaphaelFirstMeetingSWOON()
		return;
	}
	if(eventNo == 2657) {
		RaphaelFirstMeetingTALK();
		return;
	}
	if(eventNo == 2658) {
		RaphaelDress()
		return;
	}
	if(eventNo == 2659) {
		RaphaelDressPtII();
		return;
	}
	if(eventNo == 2660) {
		RaphaelEncounterIIDressFollowup();
		return;
	}
	if(eventNo == 2661) {
		RaphaelSelectDate();
		return;
	}
	if(eventNo == 2662) {
		RaphaelChooseReject();
		return;
	}
	if(eventNo == 2663) {
		RaphaelChooseFrisk();
		return;
	}
	if(eventNo == 2664) {
		friskAcceptChoice();
		return;
	}
	if(eventNo == 2665) {
		friskRejectChoice();
		return;
	}
	if(eventNo == 2666) {
		friskFondleChoice();
		return;
	}
	if(eventNo == 2667) {
		friskSqueezeChoice();
		return;
	}
	if(eventNo == 2668) {
		RaphaelPicnic();
		return;
	}
	if(eventNo == 2669) {
		RaphaelPicnicII();
		return;
	}
	if(eventNo == 2670) {
		RaphaelPicnicEnd();
		return;
	}
	if(eventNo == 2671) {
		RaphaelPicnicSkill();
		return;
	}
	if(eventNo == 2672) {
		fenceOfferChangeToDiscuss();
		return;
	}
	if(eventNo == 2673) {
		fenceRaphaelSexily();
		return;
	}
	if(eventNo == 2674) {
		fenceRaphaelSexilyPtII();
		return;
	}
	if(eventNo == 2675) {
		RaphaelPostFenceSex();
		return;
	}
	if(eventNo == 2676) {
		postRaphaelCoitus();
		return;
	}
	if(eventNo == 2677) {
		declinePuttingOutForRogues();
		return;
	}
	if(eventNo == 2678) {
		RaphaelPicnicChooseThieving();
		return;
	}
	if(eventNo == 2679) {
		thieveryEnding();
		return;
	}
	if(eventNo == 2680) {
		RaphaelThieverySmex();
		return;
	}
	if(eventNo == 2681) {
		RaphaelThieverySmexPtII();
		return;
	}
	if(eventNo == 2682) {
		quiksilverFawkesEndGame();
		return;
	}
	if(eventNo == 2683) {
		QuiksilverFawkesPtII();
		return;
	}
	if(eventNo == 2684) {
		coverForRaphael();
		return;
	}
	if(eventNo == 2685) {
		coverForRaphaelII();
		return;
	}
	if(eventNo == 2686) {
		betrayRaphael();
		return;
	}
	if(eventNo == 2687) {
		meetRaphael();
		return;
	}
	if(eventNo == 2688) {
		declineCrazyPresences();
		return;
	}
	if(eventNo == 2689) {
		acceptCrazyPresences();
		return;
	}
	if(eventNo == 2690) {
		acceptCrazyPresencesII();
		return;
	}
	if(eventNo == 2691) {
		declineGivingAwayLethicite();
		return;
	}
	if(eventNo == 2692) {
		giveUpLethicite();
		return;
	}
	if(eventNo == 2693) {
		giveLethicitePiece();
		return;
	}
	if(eventNo == 2694) {
		giveALLTHELETHICITES();
		return;
	}
	if(eventNo == 2695) {
		minotaurSalonFollowUp();
		return;
	}
	if(eventNo == 2696) {
		if(player.gems < 60) {
			outputText("You can't afford any minotaur cum right now!", true);
			if(flags[SALON_PAID] == 0) doNext(2169);
			else salonPurchaseMenu();
		}
		else {
			menuLoc = 2;
			player.gems -= 60;
			outputText("You happily give Lynnette 60 gems and pick up the bottle full of glistening, heavenly cum.  ", true);
			statScreenRefresh();
			shortName = "MinoCum";
			takeItem();
		}
		return;
	}
	if(eventNo == 2697) {
		scyllaAndUrtaSittingInATree();
		return;
	}
	if(eventNo == 2698) {
		heartBreakHotelInTelAdre();
		return;
	}
	if(eventNo == 2699) {
		flipUrtaTheBird();
		return;
	}
	if(eventNo == 2700) {
		watchTwoHotBitchesAndJerkIt();
		return;
	}
	if(eventNo == 2701) {
		makeUrtaSitOnYourLapWithScylla();
		return;
	}
	if(eventNo == 2702) {
		addictionScyllaTakeAdvantageDicksII();
		return;
	}
	if(eventNo == 2703) {
		addictionScyllaTakeAdvantageDicksIII();
		return;
	}
	if(eventNo == 2704) {
		addictionScyllaTakeAdvantageDicksBonusAndEpilogue();
		return;
	}
	if(eventNo == 2705) {
		Scylla6();
		return;
	}
	if(eventNo == 2706) {
		Scylla6DUCK();
		return;
	}
	if(eventNo == 2707) {
		Scylla6SLOW();
		return;
	}
	if(eventNo == 2708) {
		lactateAndKickAss();
		return;
	}
	if(eventNo == 2709) {
		Scylla6YellForHelp();
		return;
	}
	if(eventNo == 2710) {
		Scylla6AfterYellTruth();
		return;
	}
	if(eventNo == 2711) {
		Scylla6AfterYellLie();
		return;
	}
	if(eventNo == 2712) {
		Scylla6MilkyWait();
		return;
	}
	if(eventNo == 2713) {
		Scylla6MilkyWaitII();
		return;
	}
	if(eventNo == 2714) {
		Scylla6MilkyWaitIII();
		return;
	}
	if(eventNo == 2715) {
		Scylla6NoMilkGetHelp();
		return;
	}
	if(eventNo == 2716) {
		Scylla6NoMilkTruth();
		return;
	}
	if(eventNo == 2717) {
		Scylla6NoMilkLie();
		return;
	}
	if(eventNo == 2718) {
		Scylla6NoMilkSubmit();
		return;
	}
	if(eventNo == 2719) {
		Scylla6NoMilkSubmitII();
		return;
	}
	if(eventNo == 2720) {
		Scylla6NoMilkSubmitIII();
		return;
	}
	if(eventNo == 2721) {
		Scylla6NoMilkSubmitIV();
		return;
	}
	if(eventNo == 2722) {
		Scylla6NoMilkRAPETHEWORLD();
		return;
	}
	if(eventNo == 2723) {
		Scylla6NoMilkRapeII();
		return;
	}
	if(eventNo == 2724) {
		Scylla6NoMilkRapeIII();
		return;
	}
	if(eventNo == 2725) {
		Scylla6NoMilkRapeIV();
		return;
	}
	if(eventNo == 2726) {
		tellUrtaNoMoreScylla();
		return;
	}
	if(eventNo == 2727) {
		tellUrtaMoreScyllaIsFine();
		return;
	}
	if(eventNo == 2728) {
		leaveUrtaAfterScyllaConfrontation();
		return;
	}
	if(eventNo == 2729) {
		tellUrtaToBeADrunkenHussy();
		return;
	}
	if(eventNo == 2730) {
		tellUrtaToStopBeingALush();
		return;
	}
	if(eventNo == 2731) {
		tellUrtaToStayTheSame();
		return;
	}
	if(eventNo == 2732) {
		turnDownDominikasKnowledge();
		return;
	}
	if(eventNo == 2733) {
		acceptDominikasKnowledge();
		return;
	}
	if(eventNo == 2734) {
		fellatrixSexWarmup();
		return;
	}
	if(eventNo == 2735) {
		declineFellatrixOral();
		return;
	}
	if(eventNo == 2736) {
		declineFellatrixOralHARDCORE();
		return;
	}
	if(eventNo == 2737) {
		declineFellatrixOralSUPERHARDCORE();
		return;
	}
	if(eventNo == 2738) {
		acceptFellatrixOral();
		return;
	}
	if(eventNo == 2739) {
		fellatrixBarApproach();
		return;
	}
	if(eventNo == 2740) {
		dontGiveMino();
		return;
	}
	if(eventNo == 2741) {
		giveMino();
		return;
	}
	if(eventNo == 2742) {
		dickDownGnollClit();
		return;
	}
	if(eventNo == 2743) {
		dickInGnollAss();
		return;
	}
	if(eventNo == 2744) {
		suckGnollClit();
		return;
	}
	if(eventNo == 2745) {
		takeGnollClit();
		return;
	}
	if(eventNo == 2746) {
		hellHoundPropahRape();
		return;
	}
	if(eventNo == 2747) {
		agreeWithDominika();
		return;
	}
	if(eventNo == 2748) {
		ehhhhDominika();
		return;
	}
	if(eventNo == 2749) {
		disagreeDominika();
		return;
	}
	if(eventNo == 2750) {
		amilyIsTotallyALesbo();
		return;
	}
	if(eventNo == 2751) {
		amilyLesboStopHer();
		return;
	}
	if(eventNo == 2752) {
		amilyLesboLetHerGo();
		return;
	}
	if(eventNo == 2753) {
		amilyPostConfessionGirlRemeeting();
		return;
	}
	if(eventNo == 2754) {
		amilyOnGirlSurpriseBonerAcceptance();
		return;
	}
	if(eventNo == 2755) {
		amilyOnGirlSurpriseBonerREJECT();
		return;
	}
	if(eventNo == 2756) {
		girlyGirlMouseSex();
		return;
	}
	if(eventNo == 2757) {
		hermilyOnFemalePC();
		return;
	}
	if(eventNo == 2758) {
		pcBirthsAmilysKidsQuestVersion();
		return;
	}
	if(eventNo == 2759) {
		postBirthingEndChoices();
		return;
	}
	if(eventNo == 2760) {
		acceptAmilyAsYourFemaleWaifu();
		return;
	}
	if(eventNo == 2761) {
		declineButBeFriends();
		return;
	}
	if(eventNo == 2762) {
		notInterestedInDumbshitMouseBitches();
		return;
	}
	if(eventNo == 2763) {
		amilyNewGenderConfrontation();
		return;
	}
	if(eventNo == 2764) {
		whyNotHerms();
		return;
	}
	if(eventNo == 2765) {
		maybeHermsAintAllBadBITCH();
		return;
	}
	if(eventNo == 2766) {
		beAmilysDadAsAHerm();
		return;
	}
	if(eventNo == 2767) {
		fuckNoYouWontBeAmilysHermDaddy();
		return;
	}
	if(eventNo == 2768) {
		makeAmilyAHerm();
		return;
	}
	if(eventNo == 2769) {
		takeChargeAmilyFuck();
		return;
	}
	if(eventNo == 2770) {
		takeChargeAmilyMouseMilk();
		return;
	}
	if(eventNo == 2771) {
		takeChargeAmilyEatOut();
		return;
	}
	if(eventNo == 2772) {
		takeChargeAmilyGetSucked();
		return;
	}
	if(eventNo == 2773) {
		takeChargeAmilyScissorMeTimbers();
		return;
	}
	if(eventNo == 2774) {
		takeChargeAmilyMountHer();
		return;
	}
	if(eventNo == 2775) {
		makeChildren();
		return;
	}
	if(eventNo == 2776) {
		nagaRapesPt2TheExtremeContinuationOfAwesome();
		return;
	}
	if(eventNo == 2777) {
		corruptNagaBitchesRapeABee();
		return;
	}
	if(eventNo == 2778) {
		beeGirlRapeForTheDistinguishedGentleman();
		return;
	}
	if(eventNo == 2779) {
		futaRapesBeeGirl();
		return;
	}
	if(eventNo == 2780) {
		rapeABeeGirlWithYourVagina();
		return;
	}
	if(eventNo == 2781) {
		rapeTheBeeGirlWithADick();
		return;
	}
	if(eventNo == 2782) {
		rapeTheBeeMultiCockStuff();
		return;
	}
	if(eventNo == 2783) {
		gymDesc();
		return;
	}
	if(eventNo == 2784) {
		buyGymLifeTimeMembership();
		return;
	}
	if(eventNo == 2785) {
		weightLifting();
		return;
	}
	if(eventNo == 2786) {
		goJogging();
		return;
	}
	if(eventNo == 2787) {
		rapeCorruptAmily1();
		return;
	}
	if(eventNo == 2788) {
		rapeCorruptAmily1Male();
		return;
	}
	if(eventNo == 2789) {
		rapeCorruptAmily1Female();
		return;
	}
	if(eventNo == 2790) {
		rapeCorruptAmily2Male();
		return;
	}
	if(eventNo == 2791) {
		rapeCorruptAmily2Female();
		return;
	}
	if(eventNo == 2792) {
		rapeCorruptAmily3Male();
		return;
	}
	if(eventNo == 2793) {
		rapeCorruptAmily3Female();
		return;
	}
	if(eventNo == 2794) {
		rapeCorruptAmily4Meeting();
		return;
	}
	if(eventNo == 2795) {
		rapeCorruptAmily4Male();
		return;
	}
	if(eventNo == 2796) {
		rapeCorruptAmily4Female();
		return;
	}
	if(eventNo == 2797) {
		corruptAmilyYouDeclineMaxxingHerDick();
		return;
	}
	if(eventNo == 2798) {
		corruptAmilyGetsDickMaxxedOut();
		return;
	}
	if(eventNo == 2799) {
		amilyDrinksSuccubusDelight();
		return;
	}
	if(eventNo == 2800) {
		giveCorruptAmilySuccubusDelight();
		return;
	}
	if(eventNo == 2801) {
		corruptAmilyBuckFutter();
		return;
	}
	if(eventNo == 2802) {
		corruptAmilyCampBonesPCWithHerCock();
		return;
	}
	if(eventNo == 2803) {
		corruptAmilyOralSuckOff();
		return;
	}
	if(eventNo == 2804) {
		corruptAmilysPussyGetsMotherfuckingFucked();
		return;
	}
	if(eventNo == 2805) {
		talkWithCORRUPTCUNT();
		return;
	}
	if(eventNo == 2806) {
		corruptAmilyLickPussiesLikeAPro();
		return;
	}
	if(eventNo == 2807) {
		corruptAmilyScissorsLikeAPro();
		return;
	}
	if(eventNo == 2808) {
		cottonGreeting();
		return;
	}
	if(eventNo == 2809) {
		turnDownYogaWifCottonFirstTime();
		return;
	}
	if(eventNo == 2810) {
		acceptYoga();
		return;
	}
	if(eventNo == 2811) {
		leaveAfterYoga();
		return;
	}
	if(eventNo == 2812) {
		cottonShowerFunTimes();
		return;
	}
	if(eventNo == 2813) {
		cottonFirstTimeFuckHer();
		return;
	}
	if(eventNo == 2814) {
		cottonFucksYou();
		return;
	}
	if(eventNo == 2815) {
		serviceFirstTimeCotton();
		return;
	}
	if(eventNo == 2816) {
		refuseFirstTimeCotton();
		return;
	}
	if(eventNo == 2817) {
		fuckCottonInShowerRepeat();
		return;
	}
	if(eventNo == 2818) {
		cottonFucksYouInShowerRepeat();
		return;
	}
	if(eventNo == 2819) {
		cottonTantricSex();
		return;
	}
	if(eventNo == 2820) {
		leaveCotton();
		return;
	}
	if(eventNo == 2821) {
		changingRoom();
		return;
	}
	if(eventNo == 2822) {
		meetJasun();
		return;
	}
	if(eventNo == 2823) {
		meetJasun2();
		return;
	}
	if(eventNo == 2824) {
		turnAwayFromAdj();
		return;
	}
	if(eventNo == 2825) {
		acceptJasunsAdvances();
		return;
	}
	if(eventNo == 2826) {
		jasunSecks();
		return;
	}
	if(eventNo == 2827) {
		exploreShowers();
		return;
	}
	if(eventNo == 2828) {
		leaveShowers();
		return;
	}
	if(eventNo == 2829) {
		useTheSexMachine();
		return;
	}
	if(eventNo == 2830) {
		//[doughnuts] – some thickness, lots of – tone. (+hips and butt!)
		flags[198] = "doughnuts";
		flags[199] = 5;
		nomnomnom();
		return;
	}
	if(eventNo == 2831) {
		//[cookies] – thickness and a little – tone (+hips)
		flags[198] = "cookies";
		flags[199] = 4;
		nomnomnom();
		return;
	}
	if(eventNo == 2832) {
		//[brownies] – lots of thickness (chance of +butt)
		flags[198] = "brownies";
		flags[199] = 3;
		nomnomnom();
		return;
	}
	if(eventNo == 2833) {
		//[cupcakes] – lots of – tone (chance of +hips)
		flags[198] = "cupcakes";
		flags[199] = 3;
		nomnomnom();
		return;
	}
	if(eventNo == 2834) {
		//[pound cake] – even split of + thickness and – tone.  (+butt)
		flags[198] = "pound cake";
		flags[199] = 4;	
		nomnomnom();
		return;
	}
	if(eventNo == 2835) {
		//[mino cum eclair] – helps your cravings and – tone!, LUST!
		flags[198] = "eclair";
		flags[199] = 10;
		nomnomnom();
		return;
	}
	if(eventNo == 2836) {
		bakeryuuuuuu();
		return;
	}
	if(eventNo == 2837) {
		sandFacial();
		return;
	}
	if(eventNo == 2838) {
		mudFacial();
		return;
	}
	if(eventNo == 2839) {
		heckelTraining();
		return;
	}
	if(eventNo == 2840) {
		heckelOrallyFixated();
		return;
	}
	if(eventNo == 2841) {
		heckelOralFixationII();
		return;
	}
	if(eventNo == 2842) {
		heckelLovesDaAnal();
		return;
	}
	if(eventNo == 2843) {
		heckelLovesAnal2();
		return;
	}
	if(eventNo == 2844) {
		greetHeckel();
		return;
	}
	if(eventNo == 2845) {
		approachIfris();
		return;
	}
	if(eventNo == 2846) {
		workOutForIfris();
		return;
	}
	if(eventNo == 2847) {
		askIfrisToJoinYou();
		return;
	}
	if(eventNo == 2848) {
		liftWhileIfrisWatches();
		return;
	}
	if(eventNo == 2849) {
		showOffForIfris();
		return;
	}
	if(eventNo == 2850) {
		dominidrama();
		return;
	}
	if(eventNo == 2851) {
		dominidramaYes();
		return;
	}
	if(eventNo == 2852) {
		dominidramaNo();
		return;
	}
	if(eventNo == 2853) {
		findBazaar();
		return;
	}
	if(eventNo == 2854) {
		approachBazaarGuard();
		return;
	}
	if(eventNo == 2855) {
		if(hours == 19 || hours == 20) {
			flags[COUNTDOWN_TO_NIGHT_RAPE]++;
			if(flags[COUNTDOWN_TO_NIGHT_RAPE] % 4 == 0 && player.gender == 1) {
				nightBazaarButtfuck();
				return;
			}
		}
		enterTheBazaarAndMenu();
		return;
	}
	if(eventNo == 2856) {
		theSlipperySqueeze();
		return;
	}
	if(eventNo == 2857) {
		joeyMassage();
		return;
	}
	if(eventNo == 2858) {
		joeysMassageWifNoExtraJizz();
		return;
	}
	if(eventNo == 2859) {
		joeysMassageWithEXTRASpooge();
		return;
	}
	if(eventNo == 2860) {
		cinnabarGreeting();
		return;
	}
	if(eventNo == 2861) {
		cinnabarNonHugeDickings();
		return;
	}
	if(eventNo == 2862) {
		cinnabarGetsFUKKKKED();
		return;
	}
	if(eventNo == 2863) {
		fuckCinnabarHugerAndCorruptedEr();
		return;
	}
	if(eventNo == 2864) {
		cinnabarHuger();
		return;
	}
	if(eventNo == 2865) {
		cinnabarHuge();
		return;
	}
	if(eventNo == 2866) {
		cinnabarMultiCockPortalFuckFest();
		return;
	}
	if(eventNo == 2867) {
		startAFightWithCeraph();
		return;
	}
	if(eventNo == 2868) {
		runFromCeraphsNiceDeal();
		return;
	}
	if(eventNo == 2869) {
		tradeCeraphSomething();
		return;
	}
	if(eventNo == 2870) {
		getCeraphsArmor();
		return;
	}
	if(eventNo == 2871) {
		tradeCeraphBimboLiqueur();
		return;
	}
	if(eventNo == 2872) {
		tradeCeraphCrotchityBits();
		return;
	}
	if(eventNo == 2873) {
		bailBeforeCeraphYoinksYourNads();
		return;
	}
	if(eventNo == 2874) {
		giveUpYourBallsOrWhateverForLessFetishes();
		return;
	}
	if(eventNo == 2875) {
		buttRapeCeraph();
		return;
	}
	if(eventNo == 2876) {
		Roxanne1stApproach();
		return;
	}
	if(eventNo == 2877) {
		RoxanneChooseApproachOrRepeat();
		return;
	}
	if(eventNo == 2878) {
		roxanneDrinkingContest();
		return;
	}
	if(eventNo == 2879) {
		roxanneGivesABlowjob();
		return;
	}
	if(eventNo == 2880) {
		roxanneCunnilingus();
		return;
	}
	if(eventNo == 2881) {
		roxanneRimjob();
		return;
	}
	if(eventNo == 2882) {
		roxanneReamsYouNormal();
		return;
	}
	if(eventNo == 2883) {
		roxanneFucksYourAssOHGODITSHUGE();
		return;
	}
	if(eventNo == 2884) {
		flags[226] = 1;
		roxanneDrinkingContest();
		return;
	}
	if(eventNo == 2885) {
		lumiEnhanceGoldenSeed();
		return;
	}
	if(eventNo == 2886) {
		lumiEnhanceKanga();
		return;
	}
	if(eventNo == 2887) {
		joeyAndrogyny();
		return;
	}
	if(eventNo == 2888) {
		tradeWithFuckingSharkBitches();
		return;
	}
	if(eventNo == 2889) {
		readSharkCuntManual();
		return;
	}
	if(eventNo == 2890) {
		readSharkCuntManual2();
		return;
	}
	if(eventNo == 2891) {
		sharkEdgingGuideLOL();
		return;
	}
	if(eventNo == 2892) {
		readSharkEdgingGuideLOL();
		return;
	}
	if(eventNo == 2893) {
		sharkgirlPronz();
		return;
	}
	if(eventNo == 2894) {
		readSharkgirlPornzYouFuckingPervertAsshole();
		return;
	}
	if(eventNo == 2895) {
		talkToASharkCoochie();
		return;
	}
	if(eventNo == 2896) {
		leaveSumSharkPussyOnTheBeach();
		return;
	}
	if(eventNo == 2897) {
		fightSharkCunt();
		return;
	}
	if(eventNo == 2898) {
		defeatIzma();
		return;
	}
	if(eventNo == 2899) {
		IzmaWins();
		return;
	}
	if(eventNo == 2900) {
		loseToIzma();
		return;
	}
	if(eventNo == 2901) {
		finalIzmaSubmission();
		return;
	}
	if(eventNo == 2902) {
		IzmaBadEnd();
		return;
	}
	if(eventNo == 2903) {
		victoryPenisIzma();
		return;
	}
	if(eventNo == 2904) {
		useVagooOnIzmaWin();
		return;
	}
	if(eventNo == 2905) {
		eatIzmasLeafAfterRapinHer();
		return;
	}
	if(eventNo == 2906) {
		dontEatIzamsLeafAfterRape();
		return;
	}
	if(eventNo == 2907) {
		takeItInZeButtVictoryLikeFromIzma();
		return;
	}
	if(eventNo == 2908) {
		leaveIzmaVictoryTease();
		return;
	}
	if(eventNo == 2909) {
		chooseIzmaTooth();
		return;
	}
	if(eventNo == 2910) {
		chooseIzmaGloves();
		return;
	}
	if(eventNo == 2911) {
		nonFightIzmaSmexPAINUS();
		return;
	}
	if(eventNo == 2912) {
		nonFightIzmaSmexASS();
		return;
	}
	if(eventNo == 2913) {
		nonFightIzmaSmexCUNTPUSSYSNATCHQUIM();
		return;
	}
	if(eventNo == 2914) {
		meetIzmaAtLake();
		return;
	}
	if(eventNo == 2915) {
		chooseYourIzmaWeapon();
		return;
	}
	if(eventNo == 2916) {
		izmaLakeTurnedDownCampSex();
		return;
	}
	if(eventNo == 2917) {
		izmaLakeSexAsEquals();
		return;
	}
	if(eventNo == 2918) {
		izmaLakeDominate();
		return;
	}
	if(eventNo == 2919) {
		submitToLakeIzma();
		return;
	}
	if(eventNo == 2920) {
		acceptIzmaAsYourBitch();
		return;
	}
	if(eventNo == 2921) {
		IzmaStayAtTheLakeBitch();
		return;
	}
	if(eventNo == 2922) {
		izmaFollowerMenu();
		return;
	}
	if(eventNo == 2923) {
		izmaPearance();
		return;
	}
	if(eventNo == 2924) {
		izmaSexMenu();
		return;
	}
	if(eventNo == 2925) {
		followerIzmaMountsPC();
		return;
	}
	if(eventNo == 2926) {
		followerIzmaTakesItInPooper();
		return;
	}
	if(eventNo == 2927) {
		followerIzmaTakesItInVagoo();
		return;
	}
	if(eventNo == 2928) {
		followerIzmaTakesIt69();
		return;
	}
	if(eventNo == 2929) {
		talkWivIzma();
		return;
	}
	if(eventNo == 2930) {
		chooseNotToFlirtWithIzma();
		return;
	}
	if(eventNo == 2931) {
		chooseToFlirtWithIzma();
		return;
	}
	if(eventNo == 2932) {
		followMinotaurIntoBackroom();
		return;
	}
	if(eventNo == 2933) {
		nopeAintGotNoneODemSpeculIngredimathings();
		return;
	}
	if(eventNo == 2934) {
		handOverIngredientsItBeBakingTimeYo();
		return;
	}
	if(eventNo == 2935) {
		sneakAwayFromMaddie();
		return;
	}
	if(eventNo == 2936) {
		waitForSlutCake();
		return;
	}
	if(eventNo == 2937) {
		runAwayFromMaddiiiieee();
		return;
	}
	if(eventNo == 2938) {
		talkToMaddie();
		return;
	}
	if(eventNo == 2939) {
		buySlutCake();
		return;
	}
	if(eventNo == 2940) {
		spriteSelect(23);
		outputText("Giacomo holds up the book with a small degree of reverence. The cover is leather, with the lettering stitched in by hand. \"<i>This, my friend,</i>\" begins Giacomo, \"<i>is a strange book indeed. I traded for it in the east, where they practice a form of exercise known as yoga. This volume in particular deals with those of, shall we say, unusual body shapes. Because of its rarity and usefulness, I simply cannot let it go for less than 100 gems and believe me, at this price I'm practically cutting my own throat. Care to broaden your horizons?</i>\"", true);
		doYesNo(2941,2017);
		return;
	}
	if(eventNo == 2941) {
		if(player.hasKeyItem("Yoga Guide") >= 0) {
			outputText("<b>You already own a yoga guide!</b>", true);
			doNext(2017);
			return;
		}
		if(player.gems < 100) {
			outputText("You cannot afford a yoga guide!", true);
			doNext(2017);
			return;
		}
		outputText("You exchange 100 gems for the tome.  Now you can finally enjoy a workout with Cotton!", true);
		player.createKeyItem("Yoga Guide",0,0,0,0);
		player.gems -= 100;
		statScreenRefresh();
		doNext(2017);
		return;
	}
	if(eventNo == 2942) {
		gatASharkTooth();
		return;
	}
	if(eventNo == 2943) {
		izmaKidsPlaytime();
		return;
	}
	if(eventNo == 2944) {
		firstTimeDeclineIzmasKdiddlezlijfhdjkfhslkfbsjkhfbs(); 
		return;
	}
	if(eventNo == 2945) {
		childToggle();
		return;
	}
	if(eventNo == 2946) {
		inCampRideIzmasDickDongTheWitchIsDead();
		return;
	}
	if(eventNo == 2947) {
		IzmaCampBooks();
		return;
	}
	if(eventNo == 2948) {
		campCuntManual();
		return;
	}
	if(eventNo == 2949) {
		entropyGuideByStephenHawking();
		return;
	}
	if(eventNo == 2950) {
		stephenHawkingPorn();
		return;
	}
	if(eventNo == 2951) {
		stash(false);
		return;
	}
	if(eventNo == 2952) {
		leaveAngryIzzy();
		return;
	}
	if(eventNo == 2953) {
		unwelcomeFightCowGal();
		return;
	}
	if(eventNo == 2954) {
		fightIsabella();
		return;
	}
	if(eventNo == 2955) {
		tryToTalkDownAngryCow();
		return;
	}
	if(eventNo == 2956) {
		nomOnMommaIzzysTits();
		return;
	}
	if(eventNo == 2957) {
		izzyGivesSmallWangsFreeOral();
		return;
	}
	if(eventNo == 2958) {
		volunteerToSlurpCowCunt();
		return;
	}
	if(eventNo == 2959) {
		IsabellaWinsAndSpanks();
		return;
	}
	if(eventNo == 2960) {
		isabellaRapesYouWithHerAss();
		return;
	}
	if(eventNo == 2961) {
		IsabellaPostSpankFeedSex();
		return;
	}
	if(eventNo == 2962) {
		victoryLactation69();
		return;
	}
	if(eventNo == 2963) {
		PCVictoryOnIsabellaButtsex();
		return;
	}
	if(eventNo == 2964) {
		victoryAgainstIzzzzzySixtyNine();
		return;
	}
	if(eventNo == 2965) {
		tooBigVictoryTittyFuckingFuntimesWithMilk();
		return;
	}
	if(eventNo == 2966) {
		vaginalProdNPokeIsabella();
		return;
	}
	if(eventNo == 2967) {
		tinyVictoryTittyFuckingFuntimesWithMilk();
		return;
	}
	if(eventNo == 2968) {
		flags[256] = 1;
		isabellaGreeting();
		return;
	}
	if(eventNo == 2969) {
		talkWithIsabella();
		return;
	}
	if(eventNo == 2970) {
		interactWithAuntNancy();
		return;
	}
	if(eventNo == 2971) {
		strongStuff();
		return;
	}
	if(eventNo == 2972) {
		lightStuff();
		return;
	}
	if(eventNo == 2973) {
		declineAuntNancyMassage();
		return;
	}
	if(eventNo == 2974) {
		timeForAuntNancySpiderCooch();
		return;
	}
	if(eventNo == 2975) {
		auntNancyPoonPartII();
		return;
	}
	if(eventNo == 2976) {
		auntNancyPoonPartIII();
		return;
	}
	if(eventNo == 2977) {
		auntNancyPoonPartIV();
		return;
	}
	if(eventNo == 2978) {
		approachLilium();
		return;
	}
	if(eventNo == 2979) {
		payForLilium();
		return;
	}
	if(eventNo == 2980) {
		leaveLilium();
		return;
	}
	if(eventNo == 2981) {
		buttFuckTongueJeorb();
		return;
	}
	if(eventNo == 2982) {
		liliumDickRidah();
		return;
	}
	if(eventNo == 2983) {
		liliumNippleFuck();
		return;
	}
	if(eventNo == 2984) {
		fightFSpiderMorph();
		return;
	}
	if(eventNo == 2985) {
		runFromFSpiderMorph();
		return;
	}
	if(eventNo == 2986) {
		talkToFSpiderMorph();
		return;
	}
	if(eventNo == 2987) {
		voluntaryFemaleSpiderMorphRapesYou();
		return;
	}
	if(eventNo == 2988) {
		declinedCrazyFemaleSpiderMorphSexFunTimes();
		return;
	}
	if(eventNo == 2989) {
		fSpiderMorphRape();
		return;
	}
	if(eventNo == 2990) {
		fSpiderMorphRapeDude();
		return;
	}
	if(eventNo == 2991) {
		evilSpiderGirlVictoryAnal();
		return;
	}
	if(eventNo == 2992) {
		goblinCondomed();
		return;
	}
	if(eventNo == 2993) {
		victoryButtFuck();
		return;
	}
	if(eventNo == 2994) {
		victoryFrotTheSpoidah();
		return;
	}
	if(eventNo == 2995) {
		victoryCowgirlRidingOnSpiderBoi();
		return;
	}
	if(eventNo == 2996) {
		talkToSpiderBoy();
		return;
	}
	if(eventNo == 2997) {
		startCombat(38);
		eventParser(1);
		spriteSelect(74);
		return;
	}
	if(eventNo == 2998) {
		RathazulArmorMenu();
		return;
	}
	if(eventNo == 2999) {
		craftSilkArmor();
		return;
	}
	if(eventNo == 3000) {
		commissionSilkArmorForReal();
		return;
	}
	if(eventNo == 3001) {
		declineSilkArmorCommish();
		return;
	}
	if(eventNo == 3002) {
		flags[275] = 1;
		chooseArmorOrRobes();
		return;
	}
	if(eventNo == 3003) {
		collectRathazulArmor();
		return;
	}
	if(eventNo == 3004) {
		flags[275] = 2;
		chooseArmorOrRobes();
		return;
	}
	if(eventNo == 3005) {
		rapeAGoblinCorruptTooBig();
		return;
	}
	if(eventNo == 3006) {
		manRapesGoblinTooBig();
		return;
	}
	if(eventNo == 3007) {
		rapeImpWithPussy();
		return;
	}
	if(eventNo == 3008) {
		centaurGirlOnImps();
		return;
	}
	if(eventNo == 3009) {
		centaurOnImpStart();
		return;
	}
	if(eventNo == 3010) {
		centaurOnImpMale(true);
		return;
	}
	if(eventNo == 3011) {
		centaurOnImpFemale(true);
		return;
	}
	if(eventNo == 3012) {
		tongueBasiliskSmex();
		return;
	}
	if(eventNo == 3013) {
		defeatBasiliskAndAnal();
		return;
	}
	if(eventNo == 3014) {
		winDriderPCDickInSpiderCunt();
		return;
	}
	if(eventNo == 3015) {
		winDriderPCDickInSpiderCunt2();
		return;
	}
	if(eventNo == 3016) {
		winVSDriderTakeItsCockInCunt();
		return;
	}
	if(eventNo == 3017) {
		victoryVSDriderRideOviVaginal();
		return;
	}
	if(eventNo == 3018) {
		victoryVSDriderRideOviAnal();
		return;
	}
	if(eventNo == 3019) {
		victoryVSDriderStickDickInSpinneret();
		return;
	}
	if(eventNo == 3020) {
		scyllaVTakeAdvantageWithExgartuan2();
		return;
	}
	if(eventNo == 3021) {
		scyllaVTakeAdvantageWithExgartuan3();
		return;
	}
	if(eventNo == 3022) {
		scyllaVTakeAdvantageWithExgartuan4();
		return;
	}
	if(eventNo == 3023) {
		girlsRapeAkbal();
		return;
	}
	if(eventNo == 3024) {
		girlsRapeAkbalPart2();
		return;
	}
	if(eventNo == 3025) {
		rapeAkbalForcedFemaleOral();
		return;
	}
	if(eventNo == 3026) {
		declineBimboSophie();
		return;
	}
	if(eventNo == 3027) {
		acceptBimboSophie();
		return;
	}
	if(eventNo == 3028) {
		approachBimboSophieInCamp();
		return;
	}
	if(eventNo == 3029) {
		bimboSophieLicksRugs();
		return;
	}
	if(eventNo == 3030) {
		bimboSophieSixtyNineAfterCunnilingus();
		return;
	}
	if(eventNo == 3031) {
		buttFuckBimboSophie();
		return;
	}
	if(eventNo == 3032) {
		fuckBimboSophiesTits();
		return;
	}
	if(eventNo == 3033) {
		sophieEggApocalypse();
		return;
	}
	if(eventNo == 3034) {
		beBimboSophiesSugarDaddy();
		return;
	}
	if(eventNo == 3035) {
		beBimboSophiesSugarMommy();
		return;
	}
	if(eventNo == 3036) {
		bimbotizeMeCaptainSophie();
		return;
	}
	if(eventNo == 3037) {
		submissiveCeraphOffer();
		return;
	}
	if(eventNo == 3038) {
		collarCeraph();
		return;
	}
	if(eventNo == 3039) {
		carryCarephsToken();
		return;
	}
	if(eventNo == 3040) {
		getCeraphFollowerPiercing();
		return;
	}
	if(eventNo == 3041) {
		if(rand(24) == 0 && player.hasCock()) catgirlEncounter();
		else if(rand(24) == 0 && flags[293] == 0) carephCorruptionSlaves();
		else if(rand(24) <= 1 && player.gender > 0) encounterZetsuko();
		else ceraphFollowerAppearance();
		return;
	}
	if(eventNo == 3042) {
		cawkTawgle();
		return;
	}
	if(eventNo == 3043) {
		CeraphHandsOutNewFetishesLikePervCandy();
		return;
	}
	if(eventNo == 3044) {
		unfetishifyYourselfWithFollowerCeraph();
		return;
	}
	if(eventNo == 3045) {
		goThroughWithCeraphUnfetishification();
		return;
	}
	if(eventNo == 3046) {
		fuckFollowerCeraphsVagoo();
		return;
	}
	if(eventNo == 3047) {
		followerCeraphTongueFucking();
		return;
	}
	if(eventNo == 3048) {
		ceraphTentacleGrape();
		return;
	}
	if(eventNo == 3049) {
		punishCeraphForSurpriseThroatFuck();
		return;
	}
	if(eventNo == 3050) {
		winRapeChoices();
		return;
	}
	if(eventNo == 3051) {
		ceraphRapesYouBADDAWGYODIGGITY();
		return;
	}
	if(eventNo == 3052) {
		followerCeraphRoleplay();
		return;
	}
	if(eventNo == 3053) {
		fuckCeraphsCatgirls();
		return;
	}
	if(eventNo == 3054) {
		declineCeraphsCatgirls();
		return;
	}
	if(eventNo == 3055) {
		ceraphUrtaRoleplay();
		return;
	}
	if(eventNo == 3056) {
		ceraphUrtaRoleplaySober();
		return;
	}
	if(eventNo == 3057) {
		ceraphUrtaRoleplaySober2();
		return;
	}
	if(eventNo == 3058) {
		overHearDemonsAboutSyrena();
		return;
	}
	if(eventNo == 3059) {
		iQuitCeraphCorruptionDemons();
		return;
	}
	if(eventNo == 3060) {
		declineCeraphFauxCorruption();
		return;
	}
	if(eventNo == 3061) {
		acceptMoreCeraphFauxCorruption();
		return;
	}
	if(eventNo == 3062) {
		makeCarephsLackeysLeave();
		return;
	}
	if(eventNo == 3063) {
		ceraphLackeyCorruption();
		return;
	}
	if(eventNo == 3064) {
		ceraphUrtaRoleplayDrunk2();
		return;
	}
	if(eventNo == 3065) {
		ceraphUrtaRoleplayDrunk();
		return;
	}
	if(eventNo == 3066) {
		postUdderChoice(true);
		return;
	}
	if(eventNo == 3067) {
		yesUdderPWEASE();
		return;
	}
	if(eventNo == 3068) {
		noUdderPlz();
		return;
	}
	if(eventNo == 3069) {
		noUdderPlz(true);
		return;
	}
	if(eventNo == 3070) {
		sweetieNOOOO();
		return;
	}
	if(eventNo == 3071) {
		encounterLottie();
		return;
	}
	if(eventNo == 3072) {
		fourthMeetingChooseSexWithLottie();
		return;
	}
	if(eventNo == 3073) {
		stayLottieBuds4Evah();
		return;
	}
	if(eventNo == 3074) {
		declineBeingLottiesGymHamsandwich();
		return;
	}
	if(eventNo == 3075) {
		acceptBeingLottiesHamSandwich();
		return;
	}
	if(eventNo == 3076) {
		gotInShapeButTurnedDownLottie();
		return;
	}
	if(eventNo == 3077) {
		gotInShapeComedyDeclineLottie();
		return;
	}
	if(eventNo == 3078) {
		gotInShapeAcceptTrainingOffer();
		return;
	}
	if(eventNo == 3079) {
		drinkWaterWithYourHamhock();
		return;
	}
	if(eventNo == 3080) {
		drinkLustWithYourHamhock();
		return;
	}
	if(eventNo == 3081) {
		analLottieMilkshake();
		return;
	}
	if(eventNo == 3082) {
		getSuckedOffByAHamSandwich();
		return;
	}
	if(eventNo == 3083) {
		lotteryAppearance();
		return;
	}
	if(eventNo == 3084) {
		talkToPigSlut();
		return;
	}
	if(eventNo == 3085) {
		firstOralReactionChooseEncourage();
		return;
	}
	if(eventNo == 3086) {
		firstOralReactionChooseAbuse();
		return;
	}
	if(eventNo == 3087) {
		firstAnalReactionChooseEncourage();
		return;
	}
	if(eventNo == 3088) {
		firstAnalReactionChooseAbuse();
		return;
	}
	if(eventNo == 3089) {
		lottieLowMoraleWeightGainEncourage();
		return;
	}
	if(eventNo == 3090) {
		lottieLowMorealeWeightGainAbuse();
		return;
	}
	if(eventNo == 3091) {
		lottieMediumMoraleWeightGainEncourage();
		return;
	}
	if(eventNo == 3092) {
		lottieMediumMorealeWeightGainAbuse();
		return;
	}
	if(eventNo == 3093) {
		lottieHighMoraleWeightGainEncourage();
		return;
	}
	if(eventNo == 3094) {
		lottieHighMoraleWeightGainAbuse();
		return;
	}
	if(eventNo == 3095) {
		lottieHighMoraleWeightGainFATTYLOVESIT();
		return;
	}
	if(eventNo == 3096) {
		lottieHighMoraleWeightGainFATTYLOVESABUSE();
		return;
	}
	if(eventNo == 3097) {
		lottieLowMoraleWeightLossEncourage();
		return;
	}
	if(eventNo == 3098) {
		lottieLowMoraleWeightLossAbuse();
		return;
	}
	if(eventNo == 3099) {
		lottieMediumMoraleWeightLossEncourage();
		return;
	}
	if(eventNo == 3100) {
		lottieMediumMoraleWeightLossAbuse();
		return;
	}
	if(eventNo == 3101) {
		lottieHighMoraleWeightLossEncourage();
		return;
	}
	if(eventNo == 3102) {
		lottieHighMoraleWeightLossAbuse();
		return;
	}
	if(eventNo == 3103) {
		lottieHighMoraleWeightLossFATTYLOVESIT();
		return;
	}
	if(eventNo == 3104) {
		lottieHighMoraleWeightLossFATTYLOVESABUSE();
		return;
	}
	if(eventNo == 3105) {
		lottieFatLoserCulminationFuckChoice();
		return;
	}
	if(eventNo == 3106) {
		lottieFatLoserCulminationHumiliationChoice();
		return;
	}
	if(eventNo == 3107) {
		lottieFatLoserCulminationLeaveComedyChoice();
		return;
	}
	if(eventNo == 3108) {
		lottieHighMoraleFatLoveSelfOneTimeEvent();
		return;
	}
	if(eventNo == 3109) {
		lottieHighMoraleFatYoullGetThereOneTimeEvent();
		return;
	}
	if(eventNo == 3110) {
		ewLottieNo();
		return;
	}
	if(eventNo == 3111) {
		lottieElleThreesomeFirstTime();
		return;
	}
	if(eventNo == 3112) {
		fuckElleInsteadOfThatFatSlutFirstTime();
		return;
	}
	if(eventNo == 3113) {
		charlottesWebComedyBullshit();
		return;
	}
	if(eventNo == 3114) {
		lottieSuccessOneShot();
		return;
	}
	if(eventNo == 3115) {
		leaveLottieInsteadOfYogaSex();
		return;
	}
	if(eventNo == 3116) {
		lottieExercise();
		return;
	}
	if(eventNo == 3117) {
		lottieWeights();
		return;
	}
	if(eventNo == 3118) {
		boastAtLottie();
		return;
	}
	if(eventNo == 3119) {
		trainWithLottie();
		return;
	}
	if(eventNo == 3120) {
		boastAtFitLottie();
		return;
	}
	if(eventNo == 3121) {
		trainWithFitLottie();
		return;
	}
	if(eventNo == 3122) {
		goJoggingWithLottie();
		return;
	}
	if(eventNo == 3123) {
		sprintAndLeaveLottieBehind();
		return;
	}
	if(eventNo == 3124) {
		jogWithLottie();
		return;
	}
	if(eventNo == 3125) {
		sprintAndLeaveFitLottieBehind();
		return;
	}
	if(eventNo == 3126) {
		jogWithFitLottie();
		return;
	}
	if(eventNo == 3127) {
		lottieYoga();
		return;
	}
	if(eventNo == 3128) {
		lottieYogaAlone();
		return;
	}
	if(eventNo == 3129) {
		togetherLottieYoga();
		return;
	}
	if(eventNo == 3130) {
		lottiePool();
		return;
	}
	if(eventNo == 3131) {
		jumpInPoolBeforeLottieSeesYourWingWang();
		return;
	}
	if(eventNo == 3132) {
		waitAndShowLottieYourPoolBoner();
		return;
	}
	if(eventNo == 3133) {
		giveLottieAnItem();
		return;
	}
	if(eventNo == 3134) {
		feedLottieAWholeCafe();
		return;
	}
	if(eventNo == 3135) {
		feedLottieLaBova();
		return;
	}
	if(eventNo == 3136) {
		giveLottieGroPlus();
		return;
	}
	if(eventNo == 3137) {
		giveLottieReducto();
		return;
	}
	if(eventNo == 3138) {
		hamSammitchTimeBIATCH();
		return;
	}
	if(eventNo == 3139) {
		lottieFuck();
		return;
	}
	if(eventNo == 3140) {
		lottieRepeatDoggieStyle();
		return;
	}
	if(eventNo == 3141) {
		lottieRepeatWalkies();
		return;
	}
	if(eventNo == 3142) {
		lottieRepeatCowGirl();
		return;
	}
	if(eventNo == 3143) {
		lottieRepeatQuickie();
		return;
	}
	if(eventNo == 3144) {
		lottieRepeatThreesome();
		return;
	}
	if(eventNo == 3145) {
		lottieRepeatSUPERNEATORARES();
		return;
	}
	if(eventNo == 3146) {
		lottieRepeatBackwardsAssCowgirl();
		return;
	}
	if(eventNo == 3147) {
		lottieRepeatFEMDOMFEMFDOM();
		return;
	}
	if(eventNo == 3148) {
		hugTheShitOutOfYourHam();
		return;
	}
	if(eventNo == 3149) {
		encounterLottie(true);
		return;
	}
	if(eventNo == 3150) {
		negotiate();
		return;
	}
	if(eventNo == 3151) {
		runFromMinotaurs();
		return;
	}
	if(eventNo == 3152) {
		fightOTaurs();
		return;
	}
	if(eventNo == 3153) {
		submitToMinotaurMob();
		return;
	}
	if(eventNo == 3154) {
		nonAddictMinotaurGangBang();
		return;
	}
	if(eventNo == 3155) {
		loseToMinoMobVeryPregnant();
		return;
	}
	if(eventNo == 3156) {
		analSpearSemiPregMinotaurGangbang();
		return;
	}
	if(eventNo == 3157) {
		victoryMinotaurGangTitFuck();
		return;
	}
	if(eventNo == 3158) {
		victoryAllThePenetrationsMinotaurGangBang();
		return;
	}
	if(eventNo == 3159) {
		forceMinitaurToGiveOral(0);
		return;
	}
	if(eventNo == 3160) {
		forceMinitaurToGiveOral(1);
		return;
	}
	if(eventNo == 3161) {
		victoryBJNippleFuckMinotaurGang();
		return;
	}
	if(eventNo == 3162) {
		minotaurGangBadEnd2();
		return;
	}
	if(eventNo == 3163) {
		milkJojoFirst();
		return;
	}
	if(eventNo == 3164) {
		repeatMilkJojo();
		return;
	}
	if(eventNo == 3165) {
		repeatMilkJojo(true); //Tentacle version
		return;
	}
	if(eventNo == 3166) {
		jojoPaysForPerms();
		return;
	}
	if(eventNo == 3167) {
		fapArenaGOOOO();
		return;
	}
	if(eventNo == 3168) {
		fapArenaPageII();
		return;
	}
	if(eventNo == 3169) {
		fapResults(1);
		return;
	}
	if(eventNo == 3170) {
		fapResults(2);
		return;
	}
	if(eventNo == 3171) {
		fapResults(3);
		return;
	}
	if(eventNo == 3172) {
		amilyDefurryOfferAtCamp();
		return;
	}
	if(eventNo == 3173) {
		amilySufferNotTheFurryToLive();
		return;
	}
	if(eventNo == 3174) {
		amilyNoFur();
		return;
	}
	if(eventNo == 3175) {
		offerToBuyPassageFromKiha();
		return;
	}
	if(eventNo == 3176) {
		leaveWhenMeetingAgressiveKiha();
		return;
	}
	if(eventNo == 3177) {
		meetKihaAndFight();
		return;
	}
	if(eventNo == 3178) {
		askWhy();
		return;
	}
	if(eventNo == 3179) {
		payKihaTribute();
		return;
	}
	if(eventNo == 3180) {
		tellKihaTributeWasYourIdea();
		return;
	}
	if(eventNo == 3181) {
		tsundereMasturbationChristmasCarol();
		return;
	}
	if(eventNo == 3182) {
		kihaVictoryPomfTail();
		return;
	}
	if(eventNo == 3183) {
		victoryDickKiha();
		return;
	}
	if(eventNo == 3184) {
		kihaRapesLittleGirlsISawItOnTheNews();
		return;
	}
	if(eventNo == 3185) {
		rapeKihaWithWORDS();
		return;
	}
	if(eventNo == 3186) {
		kihaExplore();
		return;
	}
	if(eventNo == 3187) {
		askAboutAmily();
		return;
	}
	if(eventNo == 3188) {
		beADickToAmily();
		return;
	}
	if(eventNo == 3189) {
		smileAndNodToAmilyXUrta();
		return;
	}
	if(eventNo == 3190) {
		amilyUrtaSex();
		return;
	}
	if(eventNo == 3191) {
		amilyUrtaSexWatch();
		return;
	}
	if(eventNo == 3192) {
		joeyWanksItOut();
		return;
	}
	if(eventNo == 3193) {
		suckOffJoeysGardenHose();
		return;
	}
	if(eventNo == 3194) {
		missingoSex();
		return;
	}
	if(eventNo == 3195) {
		missingoSex2();
		return;
	}
	if(eventNo == 3196) {
		missingoSex3();
		return;
	}
	if(eventNo == 3197) {
		missingoSex4();
		return;
	}
	if(eventNo == 3198) {
		missingoSex5();
		return;
	}
	if(eventNo == 3199) {
		missingoSex6();
		return;
	}
	if(eventNo == 3200) {
		minotaurBlowjob();
		return;
	}
	if(eventNo == 3201) {
		itsOkayUrtaAmilyIsHot();
		return;
	}
	if(eventNo == 3202) {
		crushUrtasHeart();
		return;
	}
	if(eventNo == 3203) {
		askAboutAmilyPt2();
		return;
	}
	if(eventNo == 3204) {
		cheatingSloots();
		return;
	}
	if(eventNo == 3205) {
		letTheSlootsFuck();
		return;
	}
	if(eventNo == 3206) {
		endThisMadness();
		return;
	}
	if(eventNo == 3207) {
		yankeeEchoPapa();
		return;
	}
	if(eventNo == 3208) {
		novemberAlphaHotel();
		return;
	}
	if(eventNo == 3209) {
		defeatDannyPhantom();
		return;
	}
	if(eventNo == 3210) {
		noSlimingSlimer();
		return;
	}
	if(eventNo == 3211) {
		littlePigLittlePigLetMeIn();
		return;
	}
	if(eventNo == 3212) {
		nowOnVickiLake();
		return;
	}
	if(eventNo == 3213) {
		sharkbustersVictory();
		return;
	}
	if(eventNo == 3214) {
		sharkyEctoginas();
		return;
	}
	if(eventNo == 3215) {
		ghostIzmaPenis();
		return;
	}
	if(eventNo == 3216) {
		ghostGooGurlzDuckfaces();
		return;
	}
	if(eventNo == 3217) {
		slimeGinaFlation();
		return;
	}
	if(eventNo == 3218) {
		slimeyPenorsAhoy();
		return;
	}
	if(eventNo == 3219) {
		genderlessGhostBuster();
		return;
	}
	if(eventNo == 3220) {
		penisLossThatIsntALoss();
		return;
	}
	if(eventNo == 3221) {
		dewormYourGhost();
		return;
	}
	if(eventNo == 3222) {
		penisGartuanGhostSmexVictory();
		return;
	}
	if(eventNo == 3223) {
		ghostGinaWinSexings();
		return;
	}
	if(eventNo == 3224) {
		hermaphroditeGhostsCumEctoplasm();
		return;
	}
	if(eventNo == 3225) {
		loseToShouldra();
		return;
	}
	if(eventNo == 3226) {
		ourDadTaughtUsNotToBeAshamedOfOurDicks();
		return;
	}
	if(eventNo == 3227) {
		loseToShouldraWithWorms();
		return;
	}
	if(eventNo == 3228) {
		ghostGinaLosses();
		return;
	}
	if(eventNo == 3229) {
		loseToShouldraAsHerm();
		return;
	}
	if(eventNo == 3230) {
		shouldraGiantCockLoss();
		return;
	}
	if(eventNo == 3231) {
		genderlessShouldrasLossRapes();
		return;
	}
	if(eventNo == 3232) {
		ghostGartuanLossSceneOrSomeShit();
		return;
	}
	if(eventNo == 3233) {
		courtCrazyGirlsDotCom();
		return;
	}
	if(eventNo == 3234) {
		noCourtingYouFag();
		return;
	}
	if(eventNo == 3235) {
		letShouldraIn();
		return;
	}
	if(eventNo == 3236) {
		kickShouldraOut();
		return;
	}
	if(eventNo == 3237) {
		ignoreSatyr();
		return;
	}
	if(eventNo == 3238) {
		rapeSatyr();
		return;
	}
	if(eventNo == 3239) {
		dontRepeatFuckSatyr();
		return;
	}
	if(eventNo == 3240) {
		secondSatyrFuck();
		return;
	}
	if(eventNo == 3241) {
		turnDownIsabellaFollower();
		return;
	}
	if(eventNo == 3242) {
		moveTheBitchIn();
		return;
	}
	if(eventNo == 3243) {
		callForFollowerIsabella();
		return;
	}
	if(eventNo == 3244) {
		isabellasAccentCoaching();
		return;
	}
	if(eventNo == 3245) {
		toggleIsabellasMorningWoodChopping();
		return;
	}
	if(eventNo == 3246) {
		repeatGermanBratwurstInCamp();
		return;
	}
	if(eventNo == 3247) {
		tentacleBoneFollowerIzzy();
		return;
	}
	if(eventNo == 3248) {
		izzyMilkYourselfDamnit();
		return;
	}
	if(eventNo == 3249) {
		izzyMilkingMeinMilkersMya();
		return;
	}
	if(eventNo == 3250) {
		izzyMilkingMeinMilkersMya2();
		return;
	}
	if(eventNo == 3251) {
		AllowIzzyMilkerUse();
		return;
	}
	if(eventNo == 3252) {
		noMilkingMilky();
		return;
	}
	if(eventNo == 3253) {
		getMilk();
		return;
	}
	if(eventNo == 3254) {
		campIzzySexMenu();
		return;
	}
	if(eventNo == 3255) {
		isabellaSparMenu()
		return;
	}
	if(eventNo == 3256) {
		sparring(1);
		return;
	}
	if(eventNo == 3257) {
		sparring(2);
		return;
	}
	if(eventNo == 3258) {
		isabellaBurps();
		return;
	}
	if(eventNo == 3259) {
		runAwayFromIzzyBurps();
		return;
	}
	if(eventNo == 3260) {
		getIzzyBurped();
		return;
	}
	if(eventNo == 3261) {
		declineIzzysCowBurpApology();
		return;
	}
	if(eventNo == 3262) {
		acceptCowpology();
		return;
	}
	if(eventNo == 3263) {
		normalFemaleRapesAGooGirl();
		return;
	}
	if(eventNo == 3264) {
		exhibitionismGooGirlVictoryRape();
		return;
	}
	if(eventNo == 3265) {
		victoryRapeAGooGalAsFeeder();
		return;
	}
	if(eventNo == 3266) {
		victoryHermSex();
		return;
	}
	if(eventNo == 3267) {
		gooMaleRape(1);
		return;
	}
	if(eventNo == 3268) {
		gooMaleRape(2);
		return;
	}
	if(eventNo == 3269) {
		gooGirlBadEnd2();
		return;
	}
	if(eventNo == 3270) {
		analRapuzulaKiha();
		return;
	}
	if(eventNo == 3271) {
		dominikaBlowjobs2();
		return;
	}
	if(eventNo == 3272) {
		gatsGoblinBoners();
		return;
	}
	if(eventNo == 3273) {
		buttFuckADriderOhBaby();
		return;
	}
	if(eventNo == 3274) {
		cerminika();
		return;
	}
	if(eventNo == 3275) {
		postHelFuckBuddyFollowup();
		return;
	}
	if(eventNo == 3276) {
		declineHelSexings();
		return;
	}
	if(eventNo == 3277) {
		beatUpHelAndStealHerWalletFromHerVagina();
		return;
	}
	if(eventNo == 3278) {
		fuckHelsAss();
		return;
	}
	if(eventNo == 3279) {
		helBlowsYou();
		return;
	}
	if(eventNo == 3280) {
		dpHel();
		return;
	}
	if(eventNo == 3281) {
		getLickedByHel();
		return;
	}
	if(eventNo == 3282) {
		helTailWanksYourDickBecauseSheLovesYouDesuDesuHoraHora();
		return;
	}
	if(eventNo == 3283) {
		helTailPegging();
		return;
	}
	if(eventNo == 3284) {
		nagaCoilsUpHel();
		return;
	}
	if(eventNo == 3285) {
		nagaCoilsUpAnalNaga();
		return;
	}
	if(eventNo == 3286) {
		mountHel();
		return;
	}
	if(eventNo == 3287) {
		helVaginaTaur69();
		return;
	}
	if(eventNo == 3288) {
		helPossessionShitPoopCock();
		return;
	}
	if(eventNo == 3289) {
		rapingHelsAssMeansYourCorruptCauseAnalIsEvil();
		return;
	}
	if(eventNo == 3290) {
		receiveCorruptRimjobsFromHel();
		return;
	}
	if(eventNo == 3291) {
		helMinotaurThreesome();
		return;
	}
	if(eventNo == 3292) {
		leaveMinotaurHelThreesome();
		return;
	}
	if(eventNo == 3293) {
		fuckHerAss();
		return;
	}
	if(eventNo == 3294) {
		helMinoThreeSomeLickItsDick();
		return;
	}
	if(eventNo == 3295) {
		postMinoThreesomeDecisionTime();
		return;
	}
	if(eventNo == 3296) {
		bugOutAfterHelMinoThreesome();
		return;
	}
	if(eventNo == 3297) {
		berserkMode();
		return;
	}
	if(eventNo == 3298) {
		askHelAboutHer();
		return;
	}
	if(eventNo == 3299) {
		askHelAboutAttackingYou();
		return;
	}
	if(eventNo == 3300) {
		telHelSTOPATTACKINGMEYOUBITCH();
		return;
	}
	if(eventNo == 3301) {
		askMommaHelForSecondsAfterDinner();
		return;
	}
	if(eventNo == 3302) {
		leaveHelAfterMinoThreeSomeChat();
		return;
	}
	if(eventNo == 3303) {
		helDefeatedNormal(true);
		return;
	}
	if(eventNo == 3304) {
		helChatMenu();
		return;
	}
	if(eventNo == 3305) {
		salamanderXIsabellaDiplomacy();
		return;
	}
	if(eventNo == 3306) {
		salamanderXIsabellaDiplomacy2();
		return;
	}
	if(eventNo == 3307) {
		watchIsabellaAndHelFight();
		return;
	}
	if(eventNo == 3308) {
		skipTownOnIsabellaAndHelsFight();
		return;
	}
	if(eventNo == 3309) {
		leaveIsabellaSallyBehind();
		return;
	}
	if(eventNo == 3310) {
		nomOnIzzyTitWithSallyMancer();
		return;
	}
	if(eventNo == 3311) {
		noThreesomeSexWithSallyAndIssyLastMinute();
		return;
	}
	if(eventNo == 3312) {
		stuffIzzyAndSalamanderWithDicks();
		return;
	}
	if(eventNo == 3313) {
		izzySallyThreeSomeFollowup();
		return;
	}
	if(eventNo == 3314) {
		izzySallyThreeSomeVagoozlaz();
		return;
	}
	if(eventNo == 3315) {
		ceraphFollowerAppearance();
		return;
	}
	if(eventNo == 3316) {
		katherineGreeting();
		return;
	}
	if(eventNo == 3317) {
		visitKatherine();
		return;
	}
	if(eventNo == 3318) {
		katherineMenu();
		return;
	}
	if(eventNo == 3319) {
		talkToKatherine();
		return;
	}
	if(eventNo == 3320) {
		katherineDefur();
		return;
	}
	if(eventNo == 3321) {
		katherinesHistory();
		return;
	}
	if(eventNo == 3322) {
		askKatherineAboutGang();
		return;
	}
	if(eventNo == 3323) {
		askKatherineAboutDogCock();
		return;
	}
	if(eventNo == 3324) {
		askKatherineAboutVagrancy();
		return;
	}
	if(eventNo == 3325) {
		askKatherineAboutLoveAndLust();
		return;
	}
	if(eventNo == 3326) {
		katherinesAppearance();
		return;
	}
	if(eventNo == 3327) {
		giveKatherineAnItem();
		return;
	}
	if(eventNo == 3328) {
		useReductoOnKat();
		return;
	}
	if(eventNo == 3329) {
		useRedoctoOnKatsKnot();
		return;
	}
	if(eventNo == 3330) {
		useReductoOnKatsKock();
		return;
	}
	if(eventNo == 3331) {
		reductoBallSize();
		return;
	}
	if(eventNo == 3332) {
		giveKatABulbousPepper();
		return;
	}
	if(eventNo == 3333) {
		giveKatADoublePepper();
		return;
	}
	if(eventNo == 3334) {
		giveKatAOverlyLargePepper();
		return;
	}
	if(eventNo == 3335) {
		katherineSex();
		return;
	}
	if(eventNo == 3336) {
		katSexMenu();
		return;
	}
	if(eventNo == 3337) {
		katPenetrate();
		return;
	}
	if(eventNo == 3338) {
		katBalls();
		return;
	}
	if(eventNo == 3339) {
		katCock();
		return;
	}
	if(eventNo == 3340) {
		penetrateKatsVag();
		return;
	}
	if(eventNo == 3341) {
		pcPenetratesKatAnally();
		return;
	}
	if(eventNo == 3342) {
		suckNFuck();
		return;
	}
	if(eventNo == 3343) {
		letKatKnotYou();
		return;
	}
	if(eventNo == 3344) {
		letKatKnotYourCuntPussyFuck();
		return;
	}
	if(eventNo == 3345) {
		getPenetrated();
		return;
	}
	if(eventNo == 3346) {
		getDoublePennedByKat();
		return;
	}
	if(eventNo == 3347) {
		suckedNFuckedByKat();
		return;
	}
	if(eventNo == 3348) {
		oralKatherineChoices();
		return;
	}
	if(eventNo == 3349) {
		giveKatOralPenisWingWang();
		return;
	}
	if(eventNo == 3350) {
		katherineGivesPCOralAllDayLongDotJPG();
		return;
	}
	if(eventNo == 3351) {
		katherineGoesDownOnTheGirlsOhYahBabyLesbo();
		return;
	}
	if(eventNo == 3352) {
		katherineLicksAllTheBoyPenises();
		return;
	}
	if(eventNo == 3353) {
		katDoubleHelixCraziness();
		return;
	}
	if(eventNo == 3354) {
		suckleTacularKats();
		return;
	}
	if(eventNo == 3355) {
		approachHelAtZeBitch();
		return;
	}
	if(eventNo == 3356) {
		leaveHelInZeBitch();
		return;
	}
	if(eventNo == 3357) {
		helEdrynThreeSomeStartYerEngines();
		return;
	}
	if(eventNo == 3358) {
		threesomeEdrynAndHel();
		return;
	}
	if(eventNo == 3359) {
		tentaDickLottieButtFuckbuttFuckButtFUCKBUTTFUCKBUTTFUCK();
		return;
	}
	if(eventNo == 3360) {
		tamaniAnalShits();
		return;
	}
	if(eventNo == 3361) {
		encounterZetsuko();
		return;
	}
	if(eventNo == 3362) {
		fuckZetsukosTonguepussy();
		return;
	}
	if(eventNo == 3363) {
		getTonguedByZetsuko();
		return;
	}
	if(eventNo == 3364) {
		zetsukoBanana();
		return;
	}
	if(eventNo == 3365) {
		noZetsukoLoveToday();
		return;
	}
	if(eventNo == 3366) {
		lottieAndIfrisNTREpilogue();
		return;
	}
	if(eventNo == 3367) {
		ifrisAndLottieGetsNTRedLiftingWeights();
		return;
	}
	if(eventNo == 3368) {
		waitForChunkyOrcLoe();
		return;
	}
	if(eventNo == 3369) {
		dontWaitForRogar();
		return;
	}
	if(eventNo == 3370) {
		ewwwRogarIsGay();
		return;
	}
	if(eventNo == 3371) {
		noSlowBroIDontWantPokeSex();
		return;
	}
	if(eventNo == 3372) {
		okayBroLetsHaveAGayCarwash();
		return;
	}
	if(eventNo == 3373) {
		rogarThirdPhase();
		return;
	}
	if(eventNo == 3374) {
		rogarPhaseFour();
		return;
	}
	if(eventNo == 3375) {
		noTHanksRogarIAintGayDudeIjustLickedThatMudToBeNice();
		return;
	}
	if(eventNo == 3376) {
		loseButtGinity();
		return;
	}
	if(eventNo == 3377) {
		fuckRogarsButtPussyBoyCuntManMoundSissySlitQueerQuim();
		return;
	}
	if(eventNo == 3378) {
		brobrobrobro();
		return;
	}
	if(eventNo == 3379) {
		rogarIsDumb();
		return;
	}
	if(eventNo == 3380) {
		takeDatBroBrewFromDaBigMeanOlOrc();
		return;
	}
	if(eventNo == 3381) {
		frotWithRogar();
		return;
	}
	if(eventNo == 3382) {
		findLostIzmaKidsII();
		return;
	}
	if(eventNo == 3383) {
		disciplineEldestMinotaurSon();
		return;
	}
	if(eventNo == 3384) {
		exgartuanBulgeTortureII();
		return;
	}
	if(eventNo == 3385) {
		exgartuanBulgeTortureIII();
		return;
	}
	if(eventNo == 3386) {
		exgartuanBulgeTortureIV();
		return;
	}
	if(eventNo == 3387) {
		boobgartuanSurprise2();
		return;
	}
	if(eventNo == 3388) {
		boobgartuanSurprise3();
		return;
	}
	if(eventNo == 3389) {
		carnalityArmorIsCoolShitToo();
		return;
	}
	if(eventNo == 3390) {
		retributionArmorIsCoolShit();
		return;
	}
	if(eventNo == 3391) {
		noThankYouSirIDontWantAwesomeArmors();
		return;
	}
	if(eventNo == 3392) {
		swimsuitVibrators();
		return;
	}
	if(eventNo == 3393) {
		plugSwimsuitVag();
		return;
	}
	if(eventNo == 3394) {
		noogaisNippleRape();
		return;
	}
	if(eventNo == 3395) {
		urtaXAmilyAfterMurrrath();
		return;
	}
	if(eventNo == 3396) {
		urtaXAmilyCuntPussyVagSQUICK();
		return;
	}
	if(eventNo == 3397) {
		threesomeAmilUrtaCAWKS();
		return;
	}
	if(eventNo == 3398) {
		liqueurUpTheWaifus();
		return;
	}
	if(eventNo == 3399) {
		amilyXUrtaRunAWAY();
		return;
	}
	if(eventNo == 3400) {
		dateNightFirstTime();
		return;
	}
	if(eventNo == 3401) {
		heliaPlusFoxyFluffs();
		return;
	}
	if(eventNo == 3402) {
		runAwayFromFoxGirls();
		return;
	}
	if(eventNo == 3403) {
		heliasFoxyFourSomeFluffs();
		return;
	}
	if(eventNo == 3404) {
		foxyFluffsFoursomeAsMale();
		return;
	}
	if(eventNo == 3405) {
		foxyFluffGirlsFuckSex();
		return;
	}
	if(eventNo == 3406) {
		foxyFluffOutro();
		return;
	}
	if(eventNo == 3407) {
		letsDoYaraSex(true);
		return;
	}
	if(eventNo == 3408) {
		letsDoYaraSex(false);
		return;
	}
	if(eventNo == 3409) {
		meditate();
		return;
	}
	if(eventNo == 3410) {
		pureAmilyPutsItInYourRectumDamnNearKilledEm();
		return;
	}
	if(eventNo == 3411) {
		fuckPureAmilysHeiny();
		return;
	}
	if(eventNo == 3412) {
		yoDawgHyenaBallz2();
		return;
	}
	if(eventNo == 3413) {
		yoDawgHyenaBallz3();
		return;
	}
	if(eventNo == 3414) {
		centaurGirlsGetHorseAids();
		return;
	}
	if(eventNo == 3415) {
		centaurDudesGetHorseAids();
		return;
	}
	if(eventNo == 3416) {
		lottiesThirtyMinutePigGasm();
		return;
	}
	if(eventNo == 3417) {
		kihaSpiderEventIntro();
		return;
	}
	if(eventNo == 3418) {
		warnKihaOfHerImpendingDemise();
		return;
	}
	if(eventNo == 3419) {
		letTheSpidersHaveTheirWayWithKiha();
		return;
	}
	if(eventNo == 3420) {
		helpKihaAgainstSpoidahs();
		return;
	}
	if(eventNo == 3421) {
		leaveKihaToSpoidahHorde();
		return;
	}
	if(eventNo == 3422) {
		sparWithKiha();
		return;
	}
	if(eventNo == 3423) {
		GTFO();
		return;
	}
	if(eventNo == 3424) {
		lieThere();
		return;
	}
	if(eventNo == 3425) {
		hugFriendWarmKiha();
		return;
	}
	if(eventNo == 3426) {
		talkToFriendlyKiha();
		return;
	}
	if(eventNo == 3427) {
		jumpDaBitches();
		return;
	}
	if(eventNo == 3428) {
		lovingHugDickings();
		return;
	}
	if(eventNo == 3429) {
		lovingHugsGirlFuckSex();
		return;
	}
	if(eventNo == 3430) {
		lovingHugsForRetards();
		return;
	}
	if(eventNo == 3431) {
		hangOutWithKiha();
		return;
	}
	if(eventNo == 3432) {
		itsGood();
		return;
	}
	if(eventNo == 3433) {
		blechKihaYourCooking();
		return;
	}
	if(eventNo == 3434) {
		kihaSexMenu();
		return;
	}
	if(eventNo == 3435) {
		encounterKiha();
		return;
	}
	if(eventNo == 3436) {
		ghostboobiesKiha();
		return;
	}
	if(eventNo == 3437) {
		giveKihaIncubusDraft();
		return;
	}
	if(eventNo == 3438) {
		fuckKihaWithATentacle();
		return;
	}
	if(eventNo == 3439) {
		fuckKihasVagInCamp();
		return;
	}
	if(eventNo == 3440) {
		boneTheShitOutofKihaHolesWithHorsecock();
		return;
	}
	if(eventNo == 3441) {
		savinTheAnalForKiha();
		return;
	}
	if(eventNo == 3442) {
		kihaGirlGirlSex();
		return;
	}
	if(eventNo == 3443) {
		kihaPlaysWithBigassCocksFemDomAhoy();
		return;
	}
	if(eventNo == 3444) {
		inviteKihaForDickings();
		return;
	}
	if(eventNo == 3445) {
		lovinHugKiha();
		return;
	}
	if(eventNo == 3446) {
		dominateKihasFaceWithStuffAndStuffOrSomethingIDunnoWhyImStillWritingThis();
		return;
	}
	if(eventNo == 3447) {
		beABitchDumbass();
		return;
	}
	if(eventNo == 3448) {
		fightForDominanceWithDragonCunnies();
		return;
	}
	if(eventNo == 3449) {
		valaCumBath();
		return;
	}
	if(eventNo == 3450) {
		valaCumBath2();
		return;
	}
	if(eventNo == 3451) {
		amilyTeachingJojoBJ();
		return;
	}
	if(eventNo == 3452) {
		BJRidesGETYOUONE();
		return;
	}
	if(eventNo == 3453) {
		fillAmilysMouth();
		return;
	}
	if(eventNo == 3454) {
		stuffAmilysMouthWithPostBJCUM();
		return;
	}
	if(eventNo == 3455) {
		fillJojosMouthWithHotStickyCum();
		return;
	}
	if(eventNo == 3456) {
		amilyAndJojoFuck();
		return;
	}
	if(eventNo == 3457) {
		fuckIncestCunts();
		return;
	}
	if(eventNo == 3458) {
		fuckIncestCunts(true);
		return;
	}
	if(eventNo == 3459) {
		yvonneFlirt();
		return;
	}
	if(eventNo == 3460) {
		backOutOfYvonneFuck();
		return;
	}
	if(eventNo == 3461) {
		fuckYvonneInZeBlacksmith();
		return;
	}
	if(eventNo == 3462) {
		giveFollowerBodyBits();
		return;
	}
	if(eventNo == 3463) {
		ceraphFollowerCockTaking();
		return;
	}
	if(eventNo == 3464) {
		ceraphFollowerCockTaking(true);
		return;
	}
	if(eventNo == 3465) {
		ceraphFollowerCuntTaking();
		return;
	}
	if(eventNo == 3466) {
		ceraphFollowerTitTaking();
		return;
	}
	if(eventNo == 3467) {
		ceraphFollowerTitTaking(1);
		return;
	}
	if(eventNo == 3468) {
		ceraphFollowerTitTaking(2);
		return;
	}
	if(eventNo == 3469) {
		stuffSomeNippleCunts();
		return;
	}
	if(eventNo == 3470) {
		portalFuckWithFollowerCeraph();
		return;
	}
	if(eventNo == 3471) {
		ceraphSexMenu();
		return;
	}
	if(eventNo == 3472) {
		izmaDickToggle();
		return;
	}
	if(eventNo == 3473) {
		removeIzmasPenis();
		return;
	}
	if(eventNo == 3474) {
		RadarIzmaCumInYourChest();
		return;
	}
	if(eventNo == 3475) {
		facialWhereItGoesRadarIzmaXpack();
		return;
	}
	if(eventNo == 3476) {
		IzmaSelfFacialWheeRadar();
		return;
	}
	if(eventNo == 3477) {
		radarIzmaXpackDenyHer();
		return;
	}
	if(eventNo == 3478) {
		radarIzmaXPackLetHer();
		return;
	}
	if(eventNo == 3479) {
		followerIzmaMountsPC(true);
		return;
	}
	if(eventNo == 3480) {
		RadarIzmaLeaveHerWangUnWingWanged();
		return;
	}
	if(eventNo == 3481) {
		izmaLakeDominateContinueVanilla();
		return;
	}
	if(eventNo == 3482) {
		noWankingForIzma();
		return;
	}
	if(eventNo == 3483) {
		letIzmaWankLikeABitch();
		return;
	}
	if(eventNo == 3484) {
		noWankingForIzmaRadarSaysSo();
		return;
	}
	if(eventNo == 3485) {
		fuckIzmasPussyDominate();
		return;
	}
	if(eventNo == 3486) {
		gooJob();
		return;
	}
	if(eventNo == 3487) {
		radarIzmaSpanking(true);
		return;
	}
	if(eventNo == 3488) {
		radarIzmaGasm();
		return;
	}
	if(eventNo == 3489) {
		radarIzmaAnalDominant();
		return;
	}
	if(eventNo == 3490) {
		radarIzmaAnalDomResultTuckIn();
		return;
	}
	if(eventNo == 3491) {
		radarIzmaLeaveHerInTheDirtAfterAnalDom();
		return;
	}
	if(eventNo == 3492) {
		receiveAllTheCowTOngues();
		return;
	}
	if(eventNo == 3493) {
		fuckIsabella();
		return;
	}
	if(eventNo == 3494) {
		QBsTalkExpack();
		return;
	}
	if(eventNo == 3495) {
		urtaDiscussesSelf();
		return;
	}
	if(eventNo == 3496) {
		urtaDialogueMenu();
		return;
	}
	if(eventNo == 3497) {
		urtaDiscussesEdryn();
		return;
	}
	if(eventNo == 3498) {
		urtaDiscussesTheWatch();
		return;
	}
	if(eventNo == 3499) {
		urtaDiscussesAlcholism();
		return;
	}
	if(eventNo == 3500) {
		urtaDiscussAlcoholDrinkMore();
		return;
	}
	if(eventNo == 3501) {
		urtaDiscussAlcoholDrinkLess();
		return;
	}
	if(eventNo == 3502) {
		urtaDiscussAlcoholNoChange();
		return;
	}
	if(eventNo == 3503) {
		breakUpWithTheBitchOverAlcoholism();
		return;
	}
	if(eventNo == 3504) {
		urtaDiscussesFamily();
		return;
	}
	if(eventNo == 3505) {
		urtaDiscussesSexAndROmance();
		return;
	}
	if(eventNo == 3506) {
		urtaDiscussionLeaveAfterROmance();
		return;
	}
	if(eventNo == 3507) {
		urtaDiscussionTeaseAfterRomance();
		return;
	}
	if(eventNo == 3508) {
		urtaDiscussesEmployment();
		return;
	}
	if(eventNo == 3509) {
		urtaDiscussesPrejudice();
		return;
	}
	if(eventNo == 3510) {
		urtaDiscussesEdrynHistory();
		return;
	}
	if(eventNo == 3511) {
		urtaDiscussesWorkingWithEdryn();
		return;
	}
	if(eventNo == 3512) {
		urtaDiscussesEdrynRomance();
		return;
	}
	if(eventNo == 3513) {
		urtaDiscussesEdrynNonLoveAccept();
		return;
	}
	if(eventNo == 3514) {
		urtaDiscussesEdrynNonLoveREJECT();
		return;
	}
	if(eventNo == 3515) {
		urtaDiscussesEdrynLoveHappy();
		return;
	}
	if(eventNo == 3516) {
		urtaDiscussesEdrynLoveTolerate();
		return;
	}
	if(eventNo == 3517) {
		urtaDiscussesEdrynLoveBreakup();
		return;
	}
	if(eventNo == 3518) {
		urtaDiscussesWatchMembership();
		return;
	}
	if(eventNo == 3519) {
		urtaDiscussesWatchRole();
		return;
	}
	if(eventNo == 3520) {
		urtaDiscussesTheWatchsReach();
		return;
	}
	if(eventNo == 3521) {
		urtaDiscussesCrimeAndPunishment();
		return;
	}
	if(eventNo == 3522) {
		bigBootyRoxanneContestLoss();
		return;
	}
	if(eventNo == 3523) {
		spankTheShitOutOfUrtaAndMakeHerCreamHerselfFromProstateStimulationAloneLikeTheHornyDrunkenSlutSheReallyIs();
		return;
	}
	if(eventNo == 3524) {
		approach();
		return;
	}
	if(eventNo == 3525) {
		getANiamhBeer();
		return;
	}
	if(eventNo == 3526) {
		drinkNiamhsBeerInTelAdre();
		return;
	}
	if(eventNo == 3527) {
		blackCatBeerToGo();
		return;
	}
	if(eventNo == 3528) {
		talkToNiamh();
		return;
	}
	if(eventNo == 3529) {
		leaveNiamh();
		return;
	}
	if(eventNo == 3530) {
		harpyScissorSurprise();
		return;
	}
	if(eventNo == 3531) {
		harpyScissorSurprisePtII();
		return;
	}
	if(eventNo == 3532) {
		maybeLaterNiamh();
		return;
	}
	if(eventNo == 3533) {
		taintNiamh(true);
		return;
	}
	if(eventNo == 3534) {
		taintNiamh(false);
		return;
	}
	if(eventNo == 3535) {
		niamhCorruptMobileSnackTurnDown();
		return;
	}
	if(eventNo == 3536) {
		niamhCorruptedMobileSnackDrinkTime();
		return;
	}
	if(eventNo == 3537) {
		bazaarNiamh();
		return;
	}
	if(eventNo == 3538) {
		bazaardNiamhDrink();
		return;
	}
	if(eventNo == 3539) {
		drinkFromZeTap();
		return;
	}
	if(eventNo == 3540) {
		getBimboChampFromNiamh();
		return;
	}
	if(eventNo == 3541) {
		bazaarSex();
		return;
	}
	if(eventNo == 3542) {
		seanBimboBrewing();
		return;
	}
	if(eventNo == 3543) {
		yeahSeanLetsBimbooze();
		return;
	}
	if(eventNo == 3544) {
		getRidOfAnemone();
		return;
	}
	if(eventNo == 3545) {
		keepAnemoneKid();
		return;
	}
	if(eventNo == 3546) {
		approachAnemoneBarrel();
		return;
	}
	if(eventNo == 3547) {
		getAnemoneItem();
		return;
	}
	if(eventNo == 3548) {
		giveAnemoneWeapon();
		return;
	}
	if(eventNo == 3549) {
		takeOutOfAnemone();
		return;
	}
	if(eventNo == 3550) {
		anemoneWatchToggle();
		return;
	}
	if(eventNo == 3551) {
		evictANemone();
		return;
	}
	if(eventNo == 3552) {
		reallyEvictDaAnemone();
		return;
	}
	if(eventNo == 3553) {
		meetMarble();
		return;
	}
	if(eventNo == 3554) {
		definitelyBreakUpWithWithMarble();
		return;
	}
	if(eventNo == 3555) {
		breakUpWithMarble();
		return;
	}
	if(eventNo == 3556) {
		turnOffMarbleForever();
		return;
	}
	if(eventNo == 3557) {
		marbleNomNoms();
		return;
	}
	if(eventNo == 3558) {
		marbleNightSexIntro();
		return;
	}
	if(eventNo == 3559) {
		atNightAskMarbleForSomeSexMaybe();
		return;
	}
	if(eventNo == 3560) {
		forceFeedMarble();
		return;
	}
	if(eventNo == 3561) {
		rapeMarbleInHerRoom();
		return;
	}
	if(eventNo == 3562) {
		getOutOfDodge();
		return;
	}
	if(eventNo == 3563) {
		stayForFights();
		return;
	}
	if(eventNo == 3564) {
		pickAFight();
		return;
	}
	if(eventNo == 3565) {
		apologizetoWalkingTitsIMEANMARBLE();
		return;
	}
	if(eventNo == 3566) {
		leaveNonFriendsMarble4EVERRRR();
		return;
	}
	if(eventNo == 3567) {
		leaveNonFriendsMarble();
		return;
	}
	if(eventNo == 3568) {
		marbleWarningStateMeeting();
		return;
	}
	if(eventNo == 3569) {
		giveMarbleTheProBovas4Sho();
		return;
	}
	if(eventNo == 3570) {
		giveMarbleTailjobRelease();
		return;
	}
	if(eventNo == 3571) {
		marbleKidsPlaytime();
		return;
	}
	if(eventNo == 3572) {
		askJoeyAboutOffer();
		return;
	}
	if(eventNo == 3573) {
		noMilkerPlzJoey();
		return;
	}
	if(eventNo == 3574) {
		buyCockMilker();
		return;
	}
	if(eventNo == 3575) {
		antColiseumFight();
		return;
	}
	if(eventNo == 3576) {
		leaveAntColony();
		return;
	}
	if(eventNo == 3577) {
		playHero();
		return;
	}
	if(eventNo == 3578) {
		keepHidden();
		return;
	}
	if(eventNo == 3579) {
		consolePhylla();
		return;
	}
	if(eventNo == 3580) {
		buyFoxBerry();
		return;
	}
	if(eventNo == 3581) {
		lumiEnhanceFox();
		return;
	}
	if(eventNo == 3582) {
		noDungeon();
		return;
	}
	if(eventNo == 3583) {
		agreeToHelpHeliaDungeon();
		return;
	}
	if(eventNo == 3584) {
		notYet();
		return;
	}
	if(eventNo == 3585) {
		goToHeliaDungeon();
		return;
	}
	if(eventNo == 3586) {
		goToHeliaDungeon2();
		return;
	}
	if(eventNo == 3587) {
		heliaFollowerMenu();
		return;
	}
	if(eventNo == 3588) {
		valeriaFollower();
		return;
	}
	if(eventNo == 3589) {
		valeriaAppearance();
		return;
	}
	if(eventNo == 3590) {
		valeriaSpar();
		return;
	}
	if(eventNo == 3591) {
		pcWinsValeriaSpar();
		return;
	}
	if(eventNo == 3592) {
		pcWinsValeriaSparDefeat();
		return;
	}
	if(eventNo == 3593) {
		followersValeriaSex();
		return;
	}
	if(eventNo == 3594) {
		valeriaDickToggle();
		return;
	}
	if(eventNo == 3595) {
		valeriaGetFucked();
		return;
	}
	if(eventNo == 3596) {
		gooFlation();
		return;
	}
	if(eventNo == 3597) {
		penetrateValeria();
		return;
	}
	if(eventNo == 3598) {
		valeriaSexDominated();
		return;
	}
	if(eventNo == 3599) {
		talkWithValeria();
		return;
	}
	if(eventNo == 3600) {
		flirtWithValeria();
		return;
	}
	if(eventNo == 3601) {
		acceptValeriasNeeds();
		return;
	}
	if(eventNo == 3602) {
		declineValeriasNeeds();
		return;
	}
	if(eventNo == 3603) {
		takeValeria();
		return;
	}
	if(eventNo == 3604) {
		dontGoToZeVillage();
		return;
	}
	if(eventNo == 3605) {
		agreeToFollowRebecFirstTime();
		return;
	}
	if(eventNo == 3606) {
		declineRebeccsPlea();
		return;
	}
	if(eventNo == 3607) {
		acceptRebeccsPlea(true, true);
		return;
	}
	if(eventNo == 3608) {
		acceptRebeccsPlea(false, true);
		return;
	}
	if(eventNo == 3609) {
		acceptRebeccsPlea(false, false);
		return;
	}
	if(eventNo == 3610) {
		intoTheDemonPit(true);
		return;
	}
	if(eventNo == 3611) {
		intoTheDemonPit(false);
		return;
	}
	if(eventNo == 3612) {
		fightZeDemons(true);
		return;
	}
	if(eventNo == 3613) {
		fightZeDemons(false);
		return;
	}
	if(eventNo == 3614) {
		loseOrSubmitToVapula();
		return;
	}
	if(eventNo == 3615) {
		wakeUpAfterDemonGangBangs();
		return;
	}
	if(eventNo == 3616) {
		defeetVapulasHorde();
		return;
	}
	if(eventNo == 3617) {
		rapeZeVapula();
		return;
	}
	if(eventNo == 3618) {
		owcaTavern();
		return;
	}
	if(eventNo == 3619) {
		sheepMilk();
		return;
	}
	if(eventNo == 3620) {
		buyOwcaShit("MinoCum");
		return;
	}
	if(eventNo == 3621) {
		buyOwcaShit("BroBrew");
		return;
	}
	if(eventNo == 3622) {
		buyOwcaShit("Gob.Ale");
		return;
	}
	if(eventNo == 3623) {
		buyOwcaShit("SheepMk");
		return;
	}
	if(eventNo == 3624) {
		herds();
		return;
	}
	if(eventNo == 3625) {
		zePit();
		return;
	}
	if(eventNo == 3626) {
		rebeccMenu();
		return;
	}
	if(eventNo == 3627) {
		rebeccAppearance();
		return;
	}
	if(eventNo == 3628) {
		rebeccBathScene();
		return;
	}
	if(eventNo == 3629) {
		rapeRebecc(false);
		return;
	}
	if(eventNo == 3630) {
		rapeRebecc(true);
		return;
	}
	if(eventNo == 3631) {
		gangbangVillageStuff();
		return;
	}
	if(eventNo == 3632) {
		slaveToVapulaBadEnd();
		return;
	}
	if(eventNo == 3633) {
		noVapulaSex();
		return;
	}
	if(eventNo == 3634) {
		owcaBuySetup("MinoCum");
		return;
	}
	if(eventNo == 3635) {
		owcaBuySetup("Gob.Ale");
		return;
	}
	if(eventNo == 3636) {
		owcaBuySetup("BroBrew");
		return;
	}
	if(eventNo == 3637) {
		owcaBuySetup("SheepMk");
		return;
	}
	if(eventNo == 3638) {
		fightZeVillagers();
		return;
	}
	if(eventNo == 3639) {
		torchOwcaMotherFuckers();
		return;
	}
	if(eventNo == 3640) {
		leaveOwcaAfterWhupping();
		return;
	}
	if(eventNo == 3641) {
		torchUpVillagersAndLeave();
		return;
	}
	if(eventNo == 3642) {
		morningAfterRape();
		return;
	}
	if(eventNo == 3643) {
		forgiveOwca();
		return;
	}
	if(eventNo == 3644) {
		fuckThisShit();
		return;
	}
	if(eventNo == 3645) {
		leaveRebeccToBeRaped();
		return;
	}
	if(eventNo == 3646) {
		faceDownHordes();
		return;
	}
	if(eventNo == 3647) {
		noFollowerShoulders();
		return;
	}
	if(eventNo == 3648) {
		recruitShouldraForCampSexyTimes();
		return;
	}
	if(eventNo == 3649) {
		shouldrasButtBigginator();
		return;
	}
	if(eventNo == 3650) {
		shouldraGivesYaSomeFukkinTeats();
		return;
	}
	if(eventNo == 3651) {
		shouldraCockBloating101();
		return;
	}
	if(eventNo == 3652) {
		shouldraGrowsYoClit();
		return;
	}
	if(eventNo == 3653) {
		shouldraGrowsYoTits();
		return;
	}
	if(eventNo == 3654) {
		groBallsBiggaGHOSTYSTYLE();
		return;
	}
	if(eventNo == 3655) {
		shouldraGroPlus();
		return;
	}
	if(eventNo == 3656) {
		shouldraTalkMenu();
		return;
	}
	if(eventNo == 3657) {
		shouldraYappin();
		return;
	}
	if(eventNo == 3658) {
		shouldraReductoMenu();
		return;
	}
	if(eventNo == 3659) {
		shouldraReductosYourBallsUpInsideYa();
		return;
	}
	if(eventNo == 3660) {
		shouldraReductosYourTits();
		return;
	}
	if(eventNo == 3661) {
		clittyVanishingActShouldra();
		return;
	}
	if(eventNo == 3662) {
		shouldraMakesCocksDisappear();
		return;
	}
	if(eventNo == 3663) {
		shrinkDemNipplzForYoGhost();
		return;
	}
	if(eventNo == 3664) {
		shrinkDatBootyForYoGhost();
		return;
	}
	if(eventNo == 3665) {
		shouldraFollowerScreen();
		return;
	}
	if(eventNo == 3666) {
		definitelyKickOutCrazyGhosts();
		return;
	}
	if(eventNo == 3667) {
		edwardShouldraDickHandsPartII();
		return;
	}
	if(eventNo == 3668) {
		shouldraAndValaGetBigger();
		return;
	}
	if(eventNo == 3669) {
		shouldraMeetsCorruptVala();
		return;
	}
	if(eventNo == 3670) {
		sandWitchGetsGhostly();
		return;
	}
	if(eventNo == 3671) {
		shouldraFappinTimes();
		return;
	}
	if(eventNo == 3672) {
		nongenderlessAnalShouldraMasturbation();
		return;
	}
	if(eventNo == 3673) {
		shouldraSexMenu();
		return;
	}
	if(eventNo == 3674) {
		kickFollowerShouldraOut();
		return;
	}
	if(eventNo == 3675) {
		kickOutShouldra4YoWormyBuddies();
		return;
	}
	if(eventNo == 3676) {
		kickOutWormiesForYourGhostPalPAL();
		return;
	}
	if(eventNo == 3677) {
		keepExgartuanInsteadOfShouldra();
		return;
	}
	if(eventNo == 3678) {
		keepShouldraAndKickOutExgartuan();
		return;
	}
	if(eventNo == 3679) {
		keepShouldraPartIIExgartumonsUndeatH();
		return;
	}
	if(eventNo == 3680) {
		keepShouldraPartIIIExgartumonsUndeatH();
		return;
	}
	if(eventNo == 3681) {
		keepAllTheGhosts();
		return;
	}
	if(eventNo == 3682) {
		shouldraBakeryIntro();
		return;
	}
	if(eventNo == 3683) {
		bailOut();
		return;
	}
	if(eventNo == 3684) {
		feedShouldraACake();
		return;
	}
	if(eventNo == 3685) {
		shouldraAndMaddieSittingInATree();
		return;
	}
	if(eventNo == 3686) {
		goAlongWIthShouldrasEatingSpree();		
		return;
	}
	if(eventNo == 3687) {
		resistBeingAFatass();
		return;
	}
	if(eventNo == 3688) {
		pumpkinFuck();
		return;
	}
	if(eventNo == 3689) {
		pumpkinFuckPartII();
		return;
	}
	if(eventNo == 3690) {
		pumpkinFuckPartIII();
		return;
	}
	if(eventNo == 3691) {
		emberCampMenu();
		return;
	}
	if(eventNo == 3692) {
		findEmbersEgg();
		return;
	}
	if(eventNo == 3693) {
		leaveEmbersAssOutToDry();
		return;
	}
	if(eventNo == 3694) {
		destroyBabyEmberYouMonster();
		return;
	}
	if(eventNo == 3695) {
		eatEmbersYolkLikeAnEvenBiggerDick();
		return;
	}
	if(eventNo == 3696) {
		bloodForTheBloodGod();
		return;
	}
	if(eventNo == 3697) {
		getSomeStuff();
		return;
	}
	if(eventNo == 3698) {
		takeEmbersEggHomeInADoggieBag();
		return;
	}
	if(eventNo == 3699) {
		noMoDagronBlud();
		return;
	}
	if(eventNo == 3700) {
		drinkDeeplyOfDagronBlud();
		return;
	}
	if(eventNo == 3701) {
		emberEggInteraction();
		return;
	}
	if(eventNo == 3702) {
		dontEggFap();
		return;
	}
	if(eventNo == 3703) {
		leaveWithoutUsingAnEmberItem();
		return;
	}
	if(eventNo == 3704) {
		useIncubusDraftOnEmber(false);
		return;
	}
	if(eventNo == 3705) {
		useIncubusDraftOnEmber(true);
		return;
	}
	if(eventNo == 3706) {
		useSuccubiMilkOnEmber(false);
		return;
	}
	if(eventNo == 3707) {
		useSuccubiMilkOnEmber(true);
		return;
	}
	if(eventNo == 3708) {
		useOviElixerOnEmber();
		return;
	}
	if(eventNo == 3709) {
		useLactaidOnEmber();
		return;
	}
	if(eventNo == 3710) {
		hairExtensionSerum();
		return;
	}
	if(eventNo == 3711) {
		giveEmberBludSausages();
		return;
	}
	if(eventNo == 3712) {
		masturbateOntoAnEgg();
		return;
	}
	if(eventNo == 3713) {
		hatchZeMuzzles();
		return;
	}
	if(eventNo == 3714) {
		meetEmberAftermath();
		return;
	}
	if(eventNo == 3715) {
		embersAppearance();
		return;
	}
	if(eventNo == 3716) {
		talkToEmber();
		return;
	}
	if(eventNo == 3717) {
		talkToEmberAboutDragonzzz();
		return;
	}
	if(eventNo == 3718) {
		discussExplorationWithEmber();
		return;
	}
	if(eventNo == 3719) {
		talkToEmberAboutYourself();
		return;
	}
	if(eventNo == 3720) {
		emberIsAnEggFactory();
		return;
	}
	if(eventNo == 3721) {
		dontWatchEmberLayEgg();
		return;
	}
	if(eventNo == 3722) {
		watchMediumAffectionEmberEggLay();
		return;
	}
	if(eventNo == 3723) {
		getMilkFromEmber();
		return;
	}
	if(eventNo == 3724) {
		decideToSparEmbra();
		return;
	}
	if(eventNo == 3725) {
		mountPumpkinsIII();
		return;
	}
	if(eventNo == 3726) {
		pumpkinMountingLevelII();
		return;
	}
	if(eventNo == 3727) {
		mountPumpkin();
		return;
	}
	if(eventNo == 3728) {
		catchAnal();
		return;
	}
	if(eventNo == 3729) {
		suckEmberCock();
		return;
	}
	if(eventNo == 3730) {
		stickDickInKnifeDrawer();
		return;
	}
	if(eventNo == 3731) {
		stickItInEmbersButt();
		return;
	}
	if(eventNo == 3732) {
		slurpDraggieCunnies();
		return;
	}
	if(eventNo == 3733) {
		getEatenOutByEmbra();
		return;
	}
	if(eventNo == 3734) {
		penetrateEmbrah();
		return;
	}
	if(eventNo == 3735) {
		penetrateEmbrahPartII();
		return;
	}
	if(eventNo == 3736) {
		getPenetratedByEmberLastSexSceneWoooo();
		return;
	}
	if(eventNo == 3737) {
		getPenetratedByEmberLastSexSceneWooooPartII();
		return;
	}
	if(eventNo == 3738) {
		emberSexMenu();
		return;
	}
	if(eventNo == 3739) {
		driderVagSmartFuck();
		return;
	}
	if(eventNo == 3740) {
		dontSilkRapeDrider();
		return;
	}
	if(eventNo == 3741) {
		driderTiedUpPartTwo(true);
		return;
	}
	if(eventNo == 3742) {
		driderTiedUpPartTwo(false);
		return;
	}
	if(eventNo == 3743) {
		driderTiedUpPartThree();
		return;
	}
	if(eventNo == 3744) {
		driderTiedUpPartFour();
		return;
	}
	if(eventNo == 3745) {
		defeatDriderIntro();
		return;
	}
	if(eventNo == 3746) {
		flirtWithVictoria();
		return;
	}
	if(eventNo == 3747) {
		disbandHorde();
		return;
	}
	if(eventNo == 3748) {
		enslaveVapulaWithYourWang();
		return;
	}
	if(eventNo == 3749) {
		callSlaveVapula();
		return;
	}
	if(eventNo == 3750) {
		fapulaFapfapfapAppearance();
		return;
	}
	if(eventNo == 3751) {
		talkToVapulaForSomeReason();
		return;
	}
	if(eventNo == 3752) {
		toggleCeruleanVapulaAssist();
		return;
	}
	if(eventNo == 3753) {
		toggleVapulaHaremFucks();
		return;
	}
	if(eventNo == 3754) {
		feedVapulaACupOfJizz();
		return;
	}
	if(eventNo == 3755) {
		chicksFeedVapula();
		return;
	}
	if(eventNo == 3756) {
		teaseVapula();
		return;
	}
	if(eventNo == 3757) {
		vapulaAndIzmaThreeSome();
		return;
	}
	if(eventNo == 3758) {
		jojoButtFuckTrain();
		return;
	}
	if(eventNo == 3759) {
		vapulaJojoThreesomes();
		return;
	}
	if(eventNo == 3760) {
		NTRSomeJojos();
		return;
	}
	if(eventNo == 3761) {
		vapulaAndAmilyThreesome();
		return;
	}
	if(eventNo == 3762) {
		vapulaSophieThreesomeCunts();
		return;
	}
	if(eventNo == 3763) {
		vapulaSophieThreeSome();
		return;
	}
	if(eventNo == 3764) {
		vapulaSophieThreesomeSelect();
		return;
	}
	if(eventNo == 3765) {
		vapulaAndCeraphButtfuckTrainYeehaw();
		return;
	}
	if(eventNo == 3766) {
		vapulaCeraphThreesomePleaseBoth();
		return;
	}
	if(eventNo == 3767) {
		vapulaCeraphThreesome();
		return;
	}
	if(eventNo == 3768) {
		vapulaThreesomeMenu();
		return;
	}
	if(eventNo == 3769) {
		chixFeedVapulaBlehblehIVantToZuckYourSpooo();
		return;
	}
	if(eventNo == 3770) {
		chicksFeedVapula();
		return;
	}
	if(eventNo == 3771) {
		teaseVapula();
		return;
	}
	if(eventNo == 3772) {
		fuckOffEmberIWantANap();
		return;
	}
	if(eventNo == 3773) {
		timeToPuffTheMagicDragon();
		return;
	}
	if(eventNo == 3774) {
		getKnockedUpByEmbrahBroBaby();
		return;
	}
	if(eventNo == 3775) {
		breedEmberPregnantAsIfThereWasAnyOtherKindOfBreeding();
		return;
	}
	if(eventNo == 3776) {
		emberBreedingAfterMathWatchOutForRadioactiveFallout(true);
		return;
	}
	if(eventNo == 3777) {
		emberBreedingAfterMathWatchOutForRadioactiveFallout(false);
		return;
	}
	if(eventNo == 3778) {
		fuckDatChameleonAsACoolGuyGirlHerm();
		return;
	}
	if(eventNo == 3779) {
		manFucksChameleonWithBiggishWang();
		return;
	}
	if(eventNo == 3780) {
		femaleHasWinSexWithChamCham();
		return;
	}
	if(eventNo == 3781) {
		useAnItemOnTheChamcham();
		return;
	}
	if(eventNo == 3782) {
		giveTheChameleonASuccubiMilk();
		return;
	}
	if(eventNo == 3783) {
		doseDatChameleonWithLustAndSensitivityDrafts();
		return;
	}
	if(eventNo == 3784) {
		defeatChameleonGirl();
		return;
	}
	if(eventNo == 3785) {
		brigitPostQueenDeathBadEndII();
		return;
	}
	if(eventNo == 3786) {
		benoitIntro();
		return;
	}
	if(eventNo == 3787) {
		benoitsBuyMenu();
		return;
	}
	if(eventNo == 3788) {
		benoitSellMenu();
		return;
	}
	if(eventNo == 3789) {
		benoitTransactBuy(1);
		return;
	}
	if(eventNo == 3790) {
		benoitTransactBuy(2);
		return;
	}
	if(eventNo == 3791) {
		benoitTransactBuy(3);
		return;
	}
	if(eventNo == 3792) {
		benoitTransactBuy(4);
		return;
	}
	if(eventNo == 3793) {
		benoitSellTransact(1);
		return;
	}
	if(eventNo == 3794) {
		benoitSellTransact(2);
		return;
	}
	if(eventNo == 3795) {
		benoitSellTransact(3);
		return;
	}
	if(eventNo == 3796) {
		benoitSellTransact(4);
		return;
	}
	if(eventNo == 3797) {
		benoitSellTransact(5);
		return;
	}
	if(eventNo == 3798) {
		talkToBenoit();
		return;
	}
	if(eventNo == 3799) {
		letZeTurkeyApproach();
		return;
	}
	if(eventNo == 3800) {
		shooTurkeyAway();
		return;
	}
	if(eventNo == 3801) {
		noThanksTurkeyGal();
		return;
	}
	if(eventNo == 3802) {
		basteThatTurkeyBooty();
		return;
	}
	if(eventNo == 3803) {
		stuffDatTurkeyWithSpoo();
		return;
	}
	if(eventNo == 3804) {
		spitRoastThatTurkey();
		return;
	}
	if(eventNo == 3805) {
		thatllDoTurkey();
		return;
	}
	if(eventNo == 3806) {
		turkeyAppetizer();
		return;
	}
	if(eventNo == 3807) {
		femaleAndTurkeyMainCourse();
		return;
	}
	if(eventNo == 3808) {
		haveTurkeyGirlDesertInYourCunt();
		return;
	}
	if(eventNo == 3809) {
		eggySuggest();
		return;
	}
	if(eventNo == 3810) {
		takeBenoitsContraceptives();
		return;
	}
	if(eventNo == 3811) {
		dontTakeEggtraceptives();
		return;
	}
	if(eventNo == 3812) {
		repeatSexWithBenoitLetHim();
		return;
	}
	if(eventNo == 3813) {
		repeatBenoitFuckTakeCharge();
		return;
	}
	if(eventNo == 3814) {
		tryToConvertToBassyWomb();
		return;
	}
	if(eventNo == 3815) {
		//ARG: later:Boolean
		suggestSexAfterBasiWombed(true);
		return;
	}
	if(eventNo == 3816) {
		//ARG: later:Boolean
		suggestSexAfterBasiWombed(false);
		return;
	}
	if(eventNo == 3817) {
		
		return;
	}
	if(eventNo == 3818) {
		anemoneButtPlugginz();
		return;
	}
	if(eventNo == 3819) {
		anemoneQuoteUnquoteAnal();
		return;
	}
	if(eventNo == 3820) {
		hotdogTheAnemone();
		return;
	}
	if(eventNo == 3821) {
		fuckingAssholelessAnemoneeeez();
		return;
	}
	if(eventNo == 3822) {
		saveTheSandTarps();
		return;
	}
	if(eventNo == 3823) {
		dontSaveTheTarps();
		return;
	}
	if(eventNo == 3824) {
		startSandTarpFight();
		return;
	}
	if(eventNo == 3825) {
		nagaThreesomeWithSandTrap();
		return;
	}
	if(eventNo == 3826) {
		stickWangInSandgina();
		return;
	}
	if(eventNo == 3827) {
		rideDatSandTarpLikeIts1999();
		return;
	}
	if(eventNo == 3828) {
		useSandTarpsHands();
		return;
	}
	if(eventNo == 3829) {
		dickwieldersLoseToSandTarps();
		return;
	}
	if(eventNo == 3830) {
		chicksLoseToSandTarp();
		return;
	}
	if(eventNo == 3831) {
		genderlessLoss();
		return;
	}
	if(eventNo == 3832) {
		laySomeDriderEggsInGobboTwat();
		return;
	}
	if(eventNo == 3833) {
		layEggsInABeeSpiderLike();
		return;
	}
	if(eventNo == 3834) {
		eggUpANagaSpiderLike();
		return;
	}
	if(eventNo == 3835) {
		spoidahsLegEggsInHarpeis();
		return;
	}
	if(eventNo == 3836) {
		driderPCEggLaysBasilisk();
		return;
	}
	if(eventNo == 3837) {
		tamaniBeaten();
		return;
	}
	if(eventNo == 3838) {
		layEggsInAMinotaurSpiderLike();
		return;
	}
	if(eventNo == 3839) {
		layEggsInSlaveCeraph();
		return;
	}
	if(eventNo == 3840) {
		giveTheFoxSomeEggs();
		return;
	}
	if(eventNo == 3841) {
		sandwitchBirthsYourMonstrosities();
		return;
	}
	if(eventNo == 3842) {
		laySomeEggsInThatWitchFinally();
		return;
	}
	if(eventNo == 3843) {
		eggwitchForeplay();
		return;
	}
	if(eventNo == 3844) {
		getToFuckingWithZeEggsInWitch();
		return;
	}
	if(eventNo == 3845) {
		ovipositSandWitches();
		return;
	}
	if(eventNo == 3846) {
		beePositANagaPlease();
		return;
	}
	if(eventNo == 3847) {
		layBeeEggsInABasilisk();
		return;
	}
	if(eventNo == 3848) {
		layBeeEggsInGoo();
		return;
	}
	if(eventNo == 3849) {
		anemoneGetsLayedByBeePositor();
		return;
	}
	if(eventNo == 3850) {
		beeEggsInCorruptJojo();
		return;
	}
	if(eventNo == 3851) {
		getHugeEggsInCawk();
		return;
	}
	if(eventNo == 3852) {
		destroyDatFukkinTree();
		return;
	}
	if(eventNo == 3853) {
		letZeFuckingSproutLive();
		return;
	}
	if(eventNo == 3854) {
		destroyDatFuckingPlantAtP2();
		return;
	}
	if(eventNo == 3855) {
		fuckFuckingFuckFlowerP2();
		return;
	}
	if(eventNo == 3856) {
		rideDatFuckingFukkFlowerP2();
		return;
	}
	if(eventNo == 3857) {
		fuckTheFlower();
		return;
	}
	if(eventNo == 3858) {
		drinkThePlantGirlsSap();
		return;
	}
	if(eventNo == 3859) {
		rideTheWalrusP3();
		return;
	}
	if(eventNo == 3860) {
		torchP3Tree();
		return;
	}
	if(eventNo == 3861) {
		treeMenu();
		return;
	}
	if(eventNo == 3862) {
		slapAmilysWhoreFace();
		return;
	}
	if(eventNo == 3863) {
		fuckHolliInZeFlowerPuss();
		return;
	}
	if(eventNo == 3864) {
		haveAMapleSyrupSnack();
		return;
	}
	if(eventNo == 3865) {
		level4RideHollisTentacruels();
		return;
	}
	if(eventNo == 3866) {
		eatHolliFruit();
		return;
	}
	if(eventNo == 3867) {
		askHolliToWatch();
		return;
	}
	if(eventNo == 3868) {
		begHolli4Watches();
		return;
	}
	if(eventNo == 3869) {
		stayQuietWhileAmilyBitchesAboutFuckingArborday();
		return;
	}
	if(eventNo == 3870) {
		consensualSatyrFuck(0);
		return;
	}
	if(eventNo == 3871) {
		consensualSatyrFuck(1);
		return;
	}
	if(eventNo == 3872) {
		keepDrinking();
		return;
	}
	if(eventNo == 3873) {
		leavePartySatyr();
		return;
	}
	if(eventNo == 3874) {
		trickZeSatyr();
		return;
	}
	if(eventNo == 3875) {
		skipForeplay();
		return;
	}
	if(eventNo == 3876) {
		femaleTakesAdvantageOfSatyr();
		return;
	}
	if(eventNo == 3877) {
		malesTakeAdvantageOfSatyrs();
		return;
	}
	if(eventNo == 3878) {
		willinglyBoneSatyr();
		return;
	}
	if(eventNo == 3879) {
		giveRubiClothes("ClssyCl");
		return;
	}
	if(eventNo == 3880) {
		giveRubiClothes("RbbrClt");
		return;
	}
	if(eventNo == 3881) {
		giveRubiClothes("AdvClth");
		return;
	}
	if(eventNo == 3882) {
		giveRubiClothes("TubeTop");
		return;
	}
	if(eventNo == 3883) {
		giveRubiClothes("T.BSuit");
		return;
	}
	if(eventNo == 3884) {
		giveRubiClothes("B.Dress");
		return;
	}
	if(eventNo == 3885) {
		giveRubiClothes("LthrPnt");
		return;
	}
	if(eventNo == 3886) {
		giveRubiClothes("NurseCl");
		return;
	}
	if(eventNo == 3887) {
		giveRubiClothes("S.Swmwr");
		return;
	}
	if(eventNo == 3888) {
		//giveRubiBimboLiquer();
		return;
	}
	if(eventNo == 3889) {
		//giveIncubusDraftRubi();
		return;
	}
	if(eventNo == 3890) {
		specialRelationship20scene();
		return;
	}
	if(eventNo == 3891) {
		acceptRubi();
		return;
	}
	if(eventNo == 3892) {
		rejectRubi();
		return;
	}
	if(eventNo == 3893) {
		cheatingRubi();
		return;
	}
	if(eventNo == 3894) {
		approachRubiScenes();
		return;
	}
	if(eventNo == 3895) {
		buyRubiMilk();
		return;
	}
	if(eventNo == 3896) {
		getTeaFromRubi();
		return;
	}
	if(eventNo == 3897) {
		chatWithRubi();
		return;
	}
	if(eventNo == 3898) {
		rubisFuckingHouseYouPervert();
		return;
	}
	if(eventNo == 3899) {
		fuckRubi();
		return;
	}
	if(eventNo == 3900) {
		dildoFuckRubi();
		return;
	}
	if(eventNo == 3901) {
		teaseRubi();
		return;
	}
	if(eventNo == 3902) {
		releaseRubi();
		return;
	}
	if(eventNo == 3903) {
		pickAnItemToFeedRubi();
		return;
	}
	if(eventNo == 3904) {
		dontCareAboutNoCheatingRubis();
		return;
	}
	if(eventNo == 3905) {
		findBimboCheatster();
		return;
	}
	if(eventNo == 3906) {
		interruptTheNTRsYouCrazyFool();
		return;
	}
	if(eventNo == 3907) {
		waitAndGetNTRedLikeTheBoyBitchYouAre();
		return;
	}
	if(eventNo == 3908) {
		NTRbimboBitchResolution();
		return;
	}
	if(eventNo == 3909) {
		noBimboNTR();
		return;
	}
	if(eventNo == 3910) {
		yesBimboNTR();
		return;
	}
	if(eventNo == 3911) {
		breakUpWithRubi();
		return;
	}
	if(eventNo == 3912) {
		pimpOutRubi();
		return;
	}
	if(eventNo == 3913) {
		enterTheTrickster();
		return;
	}
	if(eventNo == 3914) {
		loseKitsuneImpFight();
		return;
	}
	if(eventNo == 3915) {
		winKitsuneImpFight();
		return;
	}
	if(eventNo == 3916) {
		willOWisp();
		return;
	}
	if(eventNo == 3917) {
		turnBackFromWillOWisp();
		return;
	}
	if(eventNo == 3918) {
		followTheWillOWisp();
		return;
	}
	if(eventNo == 3919) {
		talkAfterResistingKitsunellusion();
		return;
	}
	if(eventNo == 3920) {
		leaveKitsune(true);
		return;
	}
	if(eventNo == 3921) {
		mansion(true, false);
		return;
	}
	if(eventNo == 3922) {
		mansion(true, true);
		return;
	}
	if(eventNo == 3923) {
		mansion(false, false);
		return;
	}
	if(eventNo == 3924) {
		mansion(false, true);
		return;
	}
	if(eventNo == 3925) {
		nonTentaclePCMansion(true);
		return;
	}
	if(eventNo == 3926) {
		nonTentaclePCMansion(false);
		return;
	}
	if(eventNo == 3927) {
		kitsuneMaleOrHermMansion(true);
		return;
	}
	if(eventNo == 3928) {
		kitsuneMaleOrHermMansion(false);
		return;
	}
	if(eventNo == 3929) {
		kitSuneLetHerMansion(true);
		return;
	}
	if(eventNo == 3930) {
		kitSuneLetHerMansion(false);
		return;
	}
	if(eventNo == 3931) {
		kitsuneShoveHerMansion(true);
		return;
	}
	if(eventNo == 3932) {
		kitsuneShoveHerMansion(false);
		return;
	}
	if(eventNo == 3933) {
		kitsuneStillHungryMansion();
		return;
	}
	if(eventNo == 3934) {
		kitsuneFemaleOrGenderless(true);
		return;
	}
	if(eventNo == 3935) {
		kitsuneFemaleOrGenderless(false);
		return;
	}
	if(eventNo == 3936) {
		kitsunesGenderlessLetHer(true);
		return;
	}
	if(eventNo == 3937) {
		kitsunesGenderlessLetHer(false);
		return;
	}
	if(eventNo == 3938) {
		kitsunesGenderlessShoverHer(true);
		return;
	}
	if(eventNo == 3939) {
		kitsunesGenderlessShoverHer(false);
		return;
	}
	if(eventNo == 3940) {
		genderlessKitsuneStillHungry(true);
		return;
	}
	if(eventNo == 3941) {
		genderlessKitsuneStillHungry(false);
		return;
	}
	if(eventNo == 3942) {
		tentacleKitsuneWingWangs();
		return;
	}
	if(eventNo == 3943) {
		outro(true);
		return;
	}
	if(eventNo == 3944) {
		outro(false);
		return;
	}
	if(eventNo == 3945) {
		mansionBadEnd();
		return;
	}
	if(eventNo == 3946) {
		kitSuneMansionBadEndII();
		return;
	}
	if(eventNo == 3947) {
		followTheWillOWisp(true);
		return;
	}
	if(eventNo == 3948) {
		layEggsInAmilysCorruptedHole();
		return;
	}
	if(eventNo == 3949) {
		layEggsInAmilysButtPt2();
		return;
	}
	if(eventNo == 3950) {
		layEggsInAmily();
		return;
	}
	if(eventNo == 3951) {
		if(!player.canOvipositBee() || rand(2) == 0) ovipositBunnyEaster();
		else layEggsInBunbuns();
		return;
	}
	if(eventNo == 3952) {
		layEggsInYerTits();
		return;
	}
	if(eventNo == 3953) {
		leaveWithBeerTits();
		return;
	}
	if(eventNo == 3954) {
		sellYourBooze();
		return;
	}
	if(eventNo == 3955) {
		barBeerOrgyTits();
		return;
	}
	if(eventNo == 3956) {
		fuckUrtaWhileScyllaSucksSober();
		return;
	}
	if(eventNo == 3957) {
		dockWithUrtaUnderScyllasSoberSupervision();
		return;
	}
	if(eventNo == 3958) {
		dockWithUrtaUnderScyllasSoberSupervision2();
		return;
	}
	if(eventNo == 3959) {
		spankVapulaLikeABoss();
		return;
	}
	if(eventNo == 3960) {
		amilySwimFuckIntro();
		return;
	}
	if(eventNo == 3961) {
		amilySwimFuckPartII();
		return;
	}
	if(eventNo == 3962) {
		sandwitchSpanking();
		return;
	}
	if(eventNo == 3963) {
		clitFuckAHarpy();
		return;
	}
	if(eventNo == 3964) {
		nieveBuilding();
		return;
	}
	if(eventNo == 3965) {
		approachNieve();
		return;
	}
	if(eventNo == 3966) {
		dominateHeckel();
		return;
	}
	if(eventNo == 3967) {
		condomlessUrtaInHouseSmex();
		return;
	}
	if(eventNo == 3968) {
		chickenHarpy();
		return;
	}
	if(eventNo == 3969) {
		meanGooGirlRecruitment();
		return;
	}
	if(eventNo == 3970) {
		approachLatexy();
		return;
	}
	if(eventNo == 3971) {
		fightSomeKitsunes();
		return;
	}
	if(eventNo == 3972) {
		rideDatSophieVag();
		return;
	}
	if(eventNo == 3973) {
		preferTamaniFemdom();
		return;
	}
	if(eventNo == 3974) {
		domUpSomeHolli();
		return;
	}
	if(eventNo == 3975) {
		orphanageIntro();
		return;
	}
	if(eventNo == 3976) {
		loppeGenericMeetings();
		return;
	}
	if(eventNo == 3977) {
		marbleTalkOverhaul();
		return;
	}
	if(eventNo == 3978) {
		shareTentaclesWithScylla();
		return;
	}
	if(eventNo == 3979) {
		rideDatSophieVag(true);
		return;
	}
	if(eventNo == 3980) {
		lippleBondUrtaScylla();
		return;
	}
	if(eventNo == 3981) {
		telHelToGetOffTheMInoCock();
		return;
	}
	if(eventNo == 3982) {
		pussyOutOfHelSexAmbush();
		return;
	}
	if(eventNo == 3983) {
		lumiEnhanceFoxJewel();
		return;
	}
	if(eventNo == 3984) {
		talkWithUrtaAboutFamFam();
		return;
	}
	if(eventNo == 3985) {
		infertilityQuestions();
		return;
	}
	if(eventNo == 3986) {
		urtaFertilityDiscussion();
		return;
	}
	if(eventNo == 3987) {
		purifySomething();
		return;
	}
	if(eventNo == 3988) {
		lustyMaidenPaizuri();
		return;
	}
	if(eventNo == 3989) {
		amilyXIzmaSuperPregOptions();
		return;
	}
	if(eventNo == 3990) {
		drinkThePotion();
		return;
	}
	if(eventNo == 3991) {
		amilyNurseCheckup();
		return;
	}
	if(eventNo == 3992) {
		scyllasFlyingSolo();
		return;
	}
	if(eventNo == 3993) {
		houses();
		return;
	}
	if(eventNo == 3994) {
		dungeons();
		return;
	}
	if(eventNo == 3995) {
		armorShops();
		return;
	}
	if(eventNo == 3996) {
		visitZeMagesTower();
		return;
	}
	if(eventNo == 3997) {
		ingredientsMenu();
		return;
	}
}

