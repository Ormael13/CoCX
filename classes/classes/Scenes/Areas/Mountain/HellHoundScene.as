/**
 * Created by aimozg on 04.01.14.
 */
package classes.Scenes.Areas.Mountain
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	public class HellHoundScene extends BaseContent
	{
		public function HellHoundScene()
		{
		}

		/*
		 Attacks:
		 1. Attack (claw); 
		 2. Breath corrupted fire, dealing damage and raising lust due to the heat; 
		 3. Catch the scent of their foe, lowering the chance of successfully running away;

		 Raped by:
		 Doggy style, using both dicks if the foe has two holes.

		 Rape:
		 Upon defeat, the flames in the hellhound's mouth goes out. It submits to its foe by licking their gear.
		 */

		public function hellhoundEncounter():void
		{
			outputText("You hear a fiery howl as a demonic, two-headed beast-man leaps out in front of you!", true);
			if (flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_HELLHOUNDS] = 1;
				outputText("\n\n<b>New codex entry unlocked: Hellhounds!</b>")
			}
			startCombat(new HellHound());
			spriteSelect(27);
		}


		public function hellhoundRapesPlayer():void
		{
			if (doSFWloss()) return; //No rape in SFW mode.
			//Lust or HP loss texts here
			if (player.lust >= player.maxLust()) outputText("Overcome by sexual desire, you submit to the hungry hellhound.\n\n", true);
			else outputText("Too weak to continue fighting, you fall to your knees.\n\n", true);
			outputText("The heads of the hellhound grin with desire as he rises onto his hind legs. As the hellhound stands before you, your eyes widen at the sight of its equipment: a pair of eight-inch long black rods, one above the other, with a sack containing a quad of flaming balls underneath. As the hound swaggers closer, you gulp at the thought of what those fiery balls are going to be pumping into you. You are helpless against the hellhound as he pushes you onto your ", false);
			if (player.lowerBody == LOWER_BODY_TYPE_HOOFED) outputText("hocks and knees", false);
			else outputText("hands and knees", false);
			outputText(" and positions himself behind you. He grips you with his clawed hands on your shoulders and easily holds you in place. The powerful creature is easily able to get past your " + player.armorName + " and you feel one of his rods brush against your " + player.buttDescript() + ".  A shudder shoots through your body as he brings his two heads down to either side of your own, his hot canine breath blowing past your ears. He stays there for a few moments, completely still... before suddenly pulling his heads back and ", false);
			if (player.vaginas.length > 0 && player.lowerBody != LOWER_BODY_TYPE_NAGA) outputText("slamming his twin dicks into your " + player.vaginaDescript(0) + " and your " + player.assholeDescript() + ".  ", false);
			else outputText("slamming his lower dick into your " + player.assholeDescript() + ", while rubbing the other between the cheeks of your " + player.buttDescript() + ".  ", false);
			if (player.vaginas.length > 0 && player.lowerBody != LOWER_BODY_TYPE_NAGA) {
				if (player.vaginalCapacity() < monster.cockArea(0)) outputText("You feel an intense mixture of sensations in your lower body as your " + player.assholeDescript() + " feels like it is being torn apart, while your " + player.vaginaDescript(0) + " is filled with an intense pleasure at being filled with the creature's large member.  ", false);
				else outputText("Your lower body explodes with pain as the hellhound forces himself in too quickly for either your " + player.assholeDescript() + " or your " + player.vaginaDescript(0) + " to handle.  ", false);
				if (player.vaginas[0].virgin) outputText("<b>You are no longer a virgin!  </b>", false);
				if (player.cuntChange(monster.cockArea(0), false)) outputText("The beast howls as your " + player.vaginaDescript(0) + " is stretched to accommodate the large shaft.  ", false);
				outputText("The hellhound pants for a few seconds before continuing.  ", false);
				if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_WET) outputText("The pause gives your " + player.vaginaDescript(0) + " time to moisten, ensuring the next thrust won't be quite as rough.  ", false);
				outputText("This time the beast starts pumping in and out more gently, only a short distance at a time as the hellhound continues panting.  As the pain in your " + player.assholeDescript() + " fades, you start feeling pleasure to match the sensations rising from your " + player.vaginaDescript(0) + ". Each thrust of the beast's twin manhoods bring you closer and closer to your peak.\n\n", false);
				//Cum
				outputText("As you reach your climax, the beast howls and you feel its incredibly hot seed pour into you.  ", false);
				if (player.cor < 40) outputText("You moan as your insides begin to heat up. The uncomfortably hot sensation only grows as more and more of its fiery seed is pumped into your body. After what feels like an eternity, the beast pulls out of you. He gives your " + player.vaginaDescript(0) + " and your " + player.assholeDescript() + " a single extended lick with its long dog-like tongue before running off out of sight. The tainted heat inside you proves to be too much and you pass out. After some time passes, you wake up to find the corrupt warmth inside you has thankfully faded away. You're able to stand up again, but the damage is done and the creature's seed has left you feeling rather weak.", false);
				else outputText("His flaming seed brings about a pleasure you had not expected; your insides feel like they are burning with passion and power.  It is an incredible and fiery experience, one that you don't think you could have had if it wasn't for the power of corruption that you've gained since you got here. Too soon, the beast pulls out of you.  He gives your " + player.vaginaDescript(0) + " and your " + player.assholeDescript() + " a single extended lick with his long dog-like tongue before he runs off. You quickly look over and manage to catch a glimpse of its tail before it disappears from view, just before your body falls into a deep sleep. When you wake, you can still feel the afterglow of the hot seed inside you.", false);
				//Preggers chance!
				player.knockUp(PregnancyStore.PREGNANCY_HELL_HOUND, PregnancyStore.INCUBATION_HELL_HOUND, 101);
			}
			else {
				outputText("Your lower body explodes with pain as the hellhound forces himself in too quickly for your " + player.assholeDescript() + " to handle. He pauses and pants for a few seconds, but you barely have enough time to catch your breath before the beast starts thrusting in and out again. However, this time the beast starts pumping in and out more gently, only a short distance at a time as the hellhound continues panting.  As the pain in your " + player.assholeDescript() + " fades, you start feeling strong pleasure from it. Each thrust of the beast's lower manhood, combined with the upper one tickling and teasing your " + player.buttDescript() + " above it brings you closer and closer to your peak.\n\n", false);
				//Cum
				outputText("As you reach your climax, the beast howls and you feel its incredibly hot seed pour into you and onto your back.  ", false);
				if (player.cor < 40) outputText("You moan while trying to break free to get the heat off your back... but the beast keeps a firm grip on you as more and more of its fiery seed is pumped into and onto your body. After what feels like an eternity, the beast pulls out of you. He gives your " + player.assholeDescript() + " a single extended lick with his long dog-like tongue before running off out of sight. You are finally able to roll around and get the heat off of your back, but you can do nothing about the tainted warmth inside you. The heat proves to be too much and you pass out. After some time passes, you wake up to find the fire inside you has thankfully faded away. You're able to stand up again, but the damage is done and the creature's seed has left you feeling rather weak.", false);
				else outputText("His flaming seed brings about a pleasure you had not expected; your insides feel like they are alight with passion and power. You feel a similar joy on your back, and your muscles feel like they are being massaged from the heat.  It is an incredible and fiery experience, one that you don't think you could have had if it wasn't for the power of corruption that you've gained since you got here. Too soon, the beast pulls out of you, giving your " + player.assholeDescript() + " a single extended lick with its long dog-like tongue before running off. You quickly look over and manage to catch a glimpse of its tail before it disappears from view, just before your body falls into a deep sleep. When you wake, you can still feel the afterglow of the flaming seed inside you.", false);
			}
			player.slimeFeed();
			//(after either of them)
			//(Lose player anal virginity; if player has vagina, lose vaginal virginity)
			player.buttChange(monster.cockArea(0), true);
			player.orgasm();
			//[if not corrupt]
			if (player.cor < 40) dynStats("tou", -2, "cor", 1);
			//[if corrupt]
			else dynStats("cor", 1.5);
			combat.cleanupAfterCombat();
		}

		public function hellHoundGetsRaped():void
		{
			clearOutput();
			//(Raped by player)
			//[if player has only one dick and no vagina]
			if (player.cocks.length == 1 && player.vaginas.length == 0) outputText("The twin heads of the hellhound eagerly lick your " + player.cockDescript(0) + " for a while.  The large, flat tongues give you a rather unusual feeling, but it is definitely effective. As you approach your peak, one of the heads tries to take your manhood into its mouth. But the other head doesn't seem all that pleased with this, and the two start to nip at each other in an effort to claim the right to be the one to push you over the edge. Annoyed at being ignored, you give both heads a smack with your hand. After a moment of recoil, they look down apologetically before resuming their licking. As you peak, the heads pull back and try to catch all the cum that erupts from your " + player.cockDescript(0) + " in their mouths. The fierce competition between the two means that most of the cum ends up outside their eager maws, but they are nontheless satisfied.  With a pair of happy barks, the hellhound turns and runs away.", false);
			//[if player has only a vagina and no dick] 
			if (player.gender == 2) outputText("The twin heads of the hellhound eagerly lick your " + player.vaginaDescript(0) + " for a while.  The large, flat tongues give you a rather unusual feeling, but it is definitely effective. As you approach your peak, one of the heads tries to force the other out of the way and push its snout into your " + player.vaginaDescript(0) + ". But the other head doesn't seem all that pleased with this, and the two start to nip at each other in an effort to claim the right to be the one to push you over the edge. Annoyed at being ignored, you give both heads a smack with your hand. After a moment of recoil, they look down apologetically before resuming their licking. As you peak, the heads resume their quarrel and try to drink as much as the fluids coming from your " + player.vaginaDescript(0) + " as they can.  You don't know which got the most, but before long your " + player.vaginaDescript(0) + " is definitely quite clean.  With a pair of happy barks, the hellhound turns and runs away.", false);
			//[if player has a dick and a vagina] 
			if (player.gender == 3 && player.cocks.length == 1) outputText("One of the heads eagerly starts licking your " + player.cockDescript(0) + " while the other starts working on your " + player.vaginaDescript(0) + ". The large, flat tongues give you a rather unusual feeling, but it is definitely effective.  As you approach your peak, the head that had been licking your " + player.cockDescript(0) + " suddenly takes it into its mouth while the other pushes its snout into your " + player.vaginaDescript(0) + ". The pleasure from this new arrangement quickly overwhelms you, leaving you dazed.  When your senses return to you, you look up to see the hellhound's tongues running all over their mouths, clearly very happy.  With a pair of happy barks, the hellhound turns and runs away.", false);
			//If player has multiple endowments
			if (player.cocks.length > 1) outputText("One of the heads eagerly starts licking your " + player.cockDescript(0) + " while the other starts to work on your " + player.cockDescript(1) + ". The large, flat tongues give you a rather unusual feeling, but it is definitely effective.   As you approach your peak, the heads quickly take your " + player.cockDescript(0) + " and " + player.cockDescript(1) + " into their mouths. The pleasure from this new arrangement quickly overwhelms you, leaving you dazed.  When your senses return to you, you look up to see the hellhound's tongues running all over their mouths, clearly very happy.  With a pair of happy barks, the hellhound turns and runs away.", false);
			//[if player has no endowments] 
			if (player.gender == 0) outputText("The two heads stare at your lack of sexual endowments for a few seconds before looking up at you sadly.  With a whine, the hellhound wanders off.  Feeling rather unsatisfied, you think that you should probably fix your lack of sexual 'parts'...", false);
			else player.orgasm();
			combat.cleanupAfterCombat();
		}


//HELLHOUND MASTER+ BAD ENDZZZZZ
		public function HellHoundMasterEncounter():void
		{
			clearOutput();
			//Initial encounter (A)
			//Requires canine face, [either two dog dicks, or a vag and pregnant with a hellhound], at least two other hellhound features (black fur, dog legs, dog tail), and corruption >=60.
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00141] == 0) {
				outputText("As you're wandering the mountains, you feel an odd presence in the back of your mind.  It calls out to you with promise of power and safety, but part of you feels a bit apprehensive at the prospect of giving yourself over to it.  Do you let the presence take over?", false);
				//Player chooses yes/no - no -> (B), yes -> (C)
				doYesNo(acceptCrazyPresences, declineCrazyPresences);
			}
			else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00141] == 1) {
				//Second Encounter (D)
				//can be triggered if the PC still has the required canine traits, and has a piece of Lethicite.
				outputText("As you're wandering the mountains, you once again feel an odd presence in the back of your mind.  You're sure it is the hellhound master once again.  You look at the pink crystal in your possession, and wonder if you should exchange it for the promissed hellfire.  Do you let the presence take over and give away the Lethicite?", false);
				doYesNo(giveUpLethicite, declineGivingAwayLethicite);
				//Player choose yes or no, no -> E, yes -> F
			}
		}

//choose no (B)
		private function declineCrazyPresences():void
		{
			clearOutput();
			outputText("You force the presence out of your mind.  You feel almost a bit lost after it disappears, but giving yourself over to foreign control can never be a good idea, can it?", false);
			//end event, A can repeat later.
			doNext(camp.returnToCampUseOneHour);
		}

//choose yes (C)
		private function acceptCrazyPresences():void
		{
			clearOutput();
			outputText("You relax your mind and allow the presence to fill your mind.  It takes control of your consciousness, and guides your thoughts.  You feel like you should go home, your master probably wants to meet you for the first time.  Instinctively you navigate the many twists and turns of the mountains, a path you can't remember, and don't have the presence of mind to chart.  Some time later, you emerge from the crags and passes to find an elaborate vale, filled with hellhounds.\n\n", false);

			outputText("You smile at the sight of your brothers running around, playing with each other, and fucking one another.  You can see many of both the violent twin headed and dicked hellhound males, and the more seductive twin headed and cunted hellhound females. It is also easy to see the vicious clearly heavily pregnant barghests, given the wide birth the other hounds give them once the females reach that stage.  It is quite the pack, but you can't look proudly at it for too long, you need to go see your master!\n\n", false);

			outputText("You continue your trek to the master's home, you can feel that you're close.  At the back of the vale, stands what seems to be a fort of sorts in front of a large cliff face.  At the entrance, stands a stunning indigo succubus holding the leash of a very big hellhound.  She smiles as she sees you approach and calls you over.  You happily trot over to the demon mistress and nuzzle your head against her thighs.  She takes your canine head between her hands and gives you a playful rub while saying \"<i>Ah, what a cute little lost doggy.  You here to see the master?  Go on in, he always has time for his faithful hounds.  You're probably really lonely, I'm sure he can find a friend to join you on that beautiful body.</i>\"  You nod at her eagerly and proceed inside.\n\n", false);
			//nxt page
			doNext(acceptCrazyPresencesII);
		}

		private function acceptCrazyPresencesII():void
		{
			clearOutput();
			outputText("The interior of the fort is obviously just the outer fortifications of a much bigger complex that goes deep inside a cave system.  As you move further inside, you find yourself stopping in front of the kennels.  These seem to be for the strongest of the hellhounds, and those that have their own demon masters.  You see a few other incubi and succubi playing with their hellhound pets.  For the most part though, you don't pay attention to the details of the fortress.  You're far too excited to get to the deepest part and meet up with your master, so you hurry on past.\n\n", false);

			outputText("You quickly move through the kennels, the pleasure pits, and the lab to get to the inner sanctum.  Inside you find a mighty and beautiful masculine demon.  He grins as he sees you and tells you to stand up so he can get a good look at you.  You eagerly rise up onto your hind legs and give a happy yip as he starts to walk around you and examine you.  At the same time, you get a chance to have a closer look at him.  He stands about seven feet tall, and has beautifully carved muscles and dark skin.  It is quite clear that he likes the appearance of his hounds, as he takes a form that has a build that is very close to that of the male hounds.  Well, save for only having one head, having both two dicks and two cunts.  He probably samples his hounds all the time.  The thought that he might do the same to you too brings on more than a little excitement.\n\n", false);

			outputText("After getting a good look at you, he speaks up.  \"<i>Well, well, well, how interesting!  So you were such a fan of my pets that you wanted to become one yourself, huh?  I'm flattered!</i>\"  He takes a step back and gets a look at the whole package.  \"<i>Very nice!  You've gotten very close to being a hellhound without my help, but it isn't a perfect job.  If I'm not mistaken, you haven't got the signature hellfire, have you?</i>\"  He pauses for a moment, while he taps his chin and strokes one of his shafts.  \"<i>Tell you what, If you can find me a piece of a pink crystal filled with soul power, I'll give you the power of hellfire.  Nothing else to it!  Just follow my call when you've got it, and you'll find your way back, don't worry.</i>\"\n\n", false);

			outputText("Some time later, you find yourself at the base of the mountains.  Your mind is once again your own.  After a few moments you realize that you can still feel the faint call of the hellhound master's voice in your mind, then it's gone.  You could probably find it again without too much trouble if you just head back into the mountains, but there isn't really much point unless you've got something to trade for the hellfire he mentioned...", false);

			if (player.hasKeyItem("Marae's Lethicite") >= 0 && player.keyItemv2("Marae's Lethicite") < 3) outputText(" You extract Marae's lethicite from your pack, and wonder if you really want to trade it for the hellfire he offered.", false);
			//advance to repeat version
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00141] = 1;
			doNext(camp.returnToCampUseOneHour);
		}

//Choose no (E)
		private function declineGivingAwayLethicite():void
		{
			clearOutput();
			outputText("You push the presence out of your mind.  Maybe later you'll collect the hellfire, but for now you'd rather keep the lethicite.", false);
			//end event, D can repeat.
			doNext(camp.returnToCampUseOneHour);
		}

//Choose yes (F)
		private function giveUpLethicite():void
		{
			clearOutput();
			outputText("You once again allow the master's will to fill you and bring you to his home.  Once again you pass through the many crags and passes of the mountains and find yourself in the hellhound valley.  The place is just as it was the last time you were here, but you don't take in the views, you have other pressing matters to deal with.  You quickly make your way across the valley to the entrance to the master's lair.\n\n", false);

			outputText("Another succubus stands guard at the entrance with another hellhound standing next to her.  She gives you a bit of a disdainful look before her hound steps forward.  \"<i>My mistress doesn't like dealing with lower hounds.  The grand master will be glad to see you, however.  Please go right in.</i>\"  One of its heads intones before directing you inside the fort.  Without hesitation you rush in.\n\n", false);

			outputText("You barely spare a thought at the interior in your hurry to get to the master.  As you burst into the room, the master's eyes light up at the sight of you.  \"<i>Ah!  It is my favorite fan.  Have you brought me a piece of that pink crystal I asked you for?</i>\"\n\n", false);

			//Player chooses to either give Merae's full Lethicite, or a regular piece of Lethicite.  Limited by what they have, of course.  They cannot choose to leave at this point.  Merae's Lethicite -> G, Regular Lethicite -> H.
			if (player.keyItemv2("Marae's Lethicite") == 0) simpleChoices("Give All", giveALLTHELETHICITES, "Give Part", giveLethicitePiece, "", null, "", null, "", null);
			else doNext(giveLethicitePiece);
		}

//Regular Lethicite
		private function giveLethicitePiece():void
		{
			clearOutput();
			//Give a single piece of Lethicite, get hellfire
			outputText("You produce the pink crystal and hand it to the master.  As the crystal touches his hand, he gives a low growl of pleasure and holds the crystal up to his eyes.  \"<i>Ah yes, excellent!  Thank you so much for this tasty treat of power.</i>\"\n\n", false);
			//if (PC gave 2/3 Merae's crystal)
			if (player.keyItemv1("Marae's Lethicite") == 2) {
				outputText("He looks at the crystal for a moment, before biting off half of it and giving the other half back to you.  \"<i>This is enough for the hellfire, I think.  Go ahead and keep the rest, my favorite fan!</i>\"\n\n", false);
				//Replace 2/3 Merae's Lethicite with regular lethicite.
				player.addKeyValue("Marae's Lethicite", 1, -1);
			}
			else {
				//Remove 1 lethicite crystal from the PC
				flags[kFLAGS.MARAE_LETHICITE]--;
				player.addKeyValue("Marae's Lethicite", 1, -1);
			}
			outputText("He rolls the crystal around in his mouth for a few moments before swallowing the crystal.  In a moment, white flames rise up around his body, and he gives you a wicked grin.  \"<i>Now, let me give you the gift promised for this tribute.</i>\"\n\n", false);

			outputText("He extracts a special cup from his throne, and starts to stroke the two of his large 10 inch pointed members with one hand.  \"<i>Watch closely, I want you to see where this power comes from.</i>\"  He starts to pant as the movements of his hands intensifies.  At the same time the aura concentrates on his pair of cocks and he brings the cup in front of them.  He gives a satisfied groan, and white hot cum sprays around the cup, carrying the same flame.  Clearly he isn't finished yet, and he brings the cup under his equipment, to catch a spray of less masculine fluids, flowing out from the omnibus's other genitals.\n\n", false);

			outputText("Afterwards, there is quite the pool of hot fluids on the ground around the omnibus, but he seems to think that enough was collected into the cup and hands it to you with a smile.  \"<i>Drink up my special friend, and partake in my hellfire.</i>\"  You put the cup to your lips and down the hot fluid.  In moments, you feel a rush pass through your body, and your stomach fills with heat and power.  You bring out the rush, and let out a roar of corrupt flames.  The master holds out his arms and grins as the wave of hellfire passes over him.\n\n", false);

			outputText("He pants, and waits for a moment to relish the feeling that your flames gave him.  \"<i>Now my young pet, you have the greatest power I've given my hounds.  Relish this gift!</i>\"  he declares before sending you on your way.  Some time later, you find yourself at the base of the mountains, your will once again your own.  You take a few experimental breaths, and can easily feel the fires within you.  It seems that you do indeed now have the power to breathe hellhound flames.\n\n", false);

			outputText("After a moment, you notice that something else seems off... the world seems to be slightly tinged red.  Worried that something else might have been done to you, you find some water to look at your reflection.  After a moment of shock, you steady yourself, and slowly tell yourself that you now have visible fires in your eyes and mouth.  This is going to take some getting used to.\n\n", false);

			outputText("<b>You now have the power to breath hellfire!</b>  (This power remains available to you so long as you maintain a corruption of at least 50.)", false);
			//increase lust by 30, corruption by 6, and libido by 3
			dynStats("lib", 3, "lus", 30, "cor", 6);
			//player gains hellfire perk.  Hellfire deals physical damage to completely pure foes, lust damage to completely corrupt foes, and a mix for those in between.  Its power is based on the PC's corruption and level.  Appearance is slightly changed to mention that the PC's eyes and mouth occasionally show flicks of fire from within them, text could possibly vary based on corruption.
			if (player.findPerk(PerkLib.Hellfire) < 0) player.createPerk(PerkLib.Hellfire, 0, 0, 0, 0);
			//Hellhounds no longer encounterable.
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00141]++;
			doNext(camp.returnToCampUseOneHour);
		}

//Merae's Lethicite
		private function giveALLTHELETHICITES():void
		{
			clearOutput();
			//Give him Merae's Lethicite, now he's got enough power for a major upheaval in the demon hierarchy.  You don't get to keep being a champion.
			//Max player's lust for genital descriptions.
			dynStats("lus=", player.maxLust());

			outputText("You pull out the giant pink crystal that you stole from Merae.  At the sight of the gem, the demon's eyes go so wide, you almost can't believe that they stay in his head.  \"<i>Is that what I think... yes, YES! This is quite the prize you have brought me, my wonderful imitator!</i>\"  He snatches the crystal out of your hands and cradles it in his hands for a few moments, a crazed hungry look in his eyes.  You remain in his power, and can do nothing but watch as he raves for a few minutes with the jewel in his hands.\n\n", false);

			outputText("\"<i>Hum, hum, hum.</i>\"  He chuckles.  \"<i>The crystal of a goddess, this is going to bring changes, oh yes.</i>\"  The crystal flares up as he grips it more tightly.  \"<i>And you, oh you deserve so much more than just hellfire for this gift.  Come!</i>\"  He calls out.  In a moment, the biggest hellhound you've ever seen rushes into the room.\n\n", false);

			//if (PC has two dog dicks)
			if (player.dogCocks() >= 2) {
				//the male bad end
				outputText("This hound is quite clearly a she, bearing a massive septuplet of breasts, and wide hips.  She is also quite clearly pregnant, and radiates an intense aura of power.  One of her two heads intones towards the crazed omnibus, \"<i>You called me master?</i>\"  \"<i>Yes I did my precious Cremera!  Have sex with this imitation at once!  " + player.mf("He", "She") + " is to become your third head!</i>\"\n\n", false);

				outputText("Instantly Cremera turns around and presents to you her waiting sloppy twin cunts.  The hellhound master walks behind you and slaps you on the ass.  \"<i>Don't keep her waiting.</i>\"  He says as a shudder passes through you and your " + player.armorName + " falls to the ground around you.\n\n", false);

				//make sure that the PC will fit in the bitch
				//(PC's dog cocks are not each of an area of 20 to 60 OR PC has more than two cocks)
				if (player.totalCocks() > 2 || player.cockThatFits(60) < 0) {
					outputText("He then reaches around your waist and takes a hold of your " + player.multiCockDescriptLight() + ".  \"<i>Before we get started, let's make sure you're just right for Cremera.</i>\"  He then reforms your body to have twin doggy pricks of appropriately sized.  \"<i>Now.</i>\"\n\n", false);
					//PC's dicks become two 14 by 3 inch dog dicks, all other dicks are removed
					player.cocks[0].cockType = CockTypesEnum.DOG;
					player.cocks[1].cockType = CockTypesEnum.DOG;
					player.cocks[0].cockThickness = 3;
					player.cocks[1].cockThickness = 3;
					player.cocks[0].cockLength = 14;
					player.cocks[1].cockLength = 14;
					while (player.cocks.length > 2) {
						player.removeCock(2, 1);
					}
				}
				outputText("You don't hesitate.  You pounce on the horny barghest, slamming your two dog pricks inside her two cunts without hesitation.  The bitch responds with a low growl, and starts bucking her rear against you, while you thrust into her with abandon.  The pleasure of her interior drives you mad like no other that you've ever been in before.  The loud squelching and stimulation of her slobbering pussies don't give you a chance to do anything but thrust and lose yourself in the feeling.\n\n", false);

				outputText("\n\nIn a matter of moments, you're releasing yourself inside her and feeling your knots swell to tie the two of you together.  The master caresses your head a moment before whispering in your ear, \"<i>Normally, dog knots are about the only thing I don't like about regular old doggies, but for this, it's perfect.</i>\"  He grins at you and holds up a brilliantly glowing hand, before smacking you on your " + player.assDescript() + ".  You feel like you've been forced even further inside Cremera, and can't help but release yourself once more inside her from the pleasure.  \"<i>Not enough!</i>\" the omnibus yells and smacks you again, pushing you even further inside her.  You don't even have a chance to think about how the hell this is happening, you're too overwhelmed by the pleasure, but when you try to cum, you find you can't!  You give a whimper, but the demon ignores you and smacks you again, forcing you even further in.  You cry out at not being able to cum, but all you're met with is another smack, then another, and another...\n\n", false);

				outputText("After what feels like hours, you're hit one more time, and feel like you've burst through Cremera completely. You feel your twin dog cocks burst free and finally cum; they feel like they cum out everything inside you.  You pant with finally being free and look down in front of you.   You blink a few times and focus on what is in front of you.  All you can see are several rows of breasts, a protruding pregnant belly, and your large dog cocks, now oddly with their knots gone and turned black.  They also seem to have gained a package of four balls underneath.  In front of you sits a huge pool of white steaming fluid, with a pink crystal resting in the middle.\n\n", false);

				outputText("\"<i>Well my new pet, what do you think?</i>\"  A voice calls out in your head.  You look to the side, and see one of Cremera's heads on your right, and the other on your left.  Your hands seem to move on their own, and grip your twin dicks.  Another voice calls out in your mind, \"<i>They are wonderful master.</i>\"\n\n", false);
			}
			else {
				//female part
				outputText("The hound is quite clearly a he, carrying a pair of 15 inch long black pointed shafts, and a sack containing a quad of cantaloupe sized balls.  He radiates an intense aura of power.  One of his two heads intones towards the crazed omnibus, \"<i>You called me master?</i>\"  \"<i>Yes I did my precious Cimer!  Have sex with this imitation at once!  " + player.mf("He", "She") + " is to become your third head!</i>\"\n\n", false);

				outputText("Instantly Cimer moves behind you and puts one of his clawed hands on your head and starts to push you down, his twin dog dicks pushing into your back.  The master steps up in front of you and puts his hand under your chin.  \"<i>Don't disappoint my pet.</i>\"  He says and brings his hand down your body, and your " + player.armorName + " tumbles to the ground.  Before Cimer has a chance to push you down, you bend over, ready to take his members in your " + player.vaginaDescript(0) + " and your " + player.assholeDescript() + ".  \"<i>Wait, one last preparation...</i>\"\n\n", false);

				outputText("He steps around behind you, and you feel something cool and small get put inside your " + player.assholeDescript() + ".  It seems to extend further inside you, and wriggles around.  You get an odd feeling in your gut, like it's being rearranged.  After a moment the object is removed and you notice that your " + player.buttDescript() + " now feels remarkably like your " + player.vaginaDescript(0) + "!  \"<i>How do you like your new second vagina?  It will be perfect for my pet's rods, I even added the knots back to his cocks.  Normally, knots are about the only thing I don't like about regular old doggies, but for this, it's perfect.</i>\"\n\n", false);

				outputText("You barely register that he's finished talking when your whole lower body feels like it's being filled in the most wonderful way imaginable!\n\n", false);

				//If (PC's vag can't fit an area of 45)
				if (player.vaginalCapacity() < 45) {
					if (player.vaginas[0].virgin) {
						outputText("Relieving both your virgin holes of their virginity in one thrust, y", false);
					}
					else outputText("Y");
					//stretch vag to very loose
					player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_GAPING;
					outputText("our two cunts quickly stretch larger to accommodate the intruders.\n\n", false);
				}
				outputText("You let out a moan of pleasure from the pleasure of being filled.  The hound doesn't hesitate at all, and just thrusts into you with abandon.  You can't believe the feral feeling of it all, and that your twin womanhoods manage to so easily take the members and flow around them.\n\n", false);

				outputText("In moments, you feel Cimer's members explode inside you with their wonderful hot seed, and his new knots swell to tie the two of you together.  Though, something feels wrong, you didn't feel an orgasm yourself!  You give a whimper and try to thrust against Cimer's pair of dog pricks inside you.  Suddenly there is a loud smack, and you feel like Cimer was just propelled inside you even further!  It's an incredible feeling, almost like he is pushing past your " + player.buttDescript() + ", but you still can't cum!  \"<i>This isn't enough!  Further inside, further!</i>\"  You hear the master yell.  Once again you feel Cimer being forced further and further inside you, again accentuated by a loud smacking noise.  Again, you find yourself unable to achieve sweet release, but you hardly have time to register that, as there is another burst and a smack, and another, and another.  It almost feels like your " + player.buttDescript() + " is being smacked...\n\n", false);

				outputText("After what feels like hours of painful pleasure without release, you're smacked on your rear one last time, and it feels like Cimer bursts through your body completely.  This finally frees the floodgates, and you feel like you're releasing everything in your body in the most powerful orgasm you've ever felt.  You pant for a moment and look down in front of you.  You can see your " + player.allBreastsDescript() + " and your pregnant belly in front of you. You also see a package of demonic dicks sticking out in front of you, with a quad of hot balls resting underneath.  In front of you is a large pool of white steaming fluid, with a pink crystal resting in the middle.\n\n", false);

				outputText("<i>Well my new pet, what do you think?</i>\"  A voice calls out in your head.  You look to the side, and see one of Cimer's heads on your right, and the other on your left.  Your hands seem to move on their own, and reach down to touch your " + player.vaginaDescript(0) + ".  Another voice calls out in your mind, <i>They are wonderful master.</i>\"\n\n", false);
			}
			outputText("You feel inclined to agree at the wonderful feeling of your new body, and the incredible amount of power you feel rushing through you.  You move one of your hands so that you can play with both your dicks and your cunts, relishing in the feeling of them and the flames that lie within.  You gasp for a moment, and open your mouth as a rush of heat rises up from your chest and a burst of flame emerges from your mouth.\n\n", false);

			outputText("A powerful demon steps out in front of you, and picks up the crystal.  You can feel a strong connection with him, and you know this is your master.  \"<i>Well now, I think you need a new name now in commemoration of being the first three headed hellhound, and for being the one who will give me the world.</i>\"  He unceremoniously puts the crystal in his mouth and swallows it.  \"<i>Your new name is Cerberus, and you're my greatest pet.</i>\"  He steps closer and looks into your center head's eyes for a moment.  \"<i>That's much better than being a champion ever was, isn't it?</i>\"  You can't help but eagerly nod in agreement.", false);
			player.orgasm();
			dynStats("lib", 50, "cor", 100);
			getGame().gameOver();

		}

		public function hellHoundPropahRape():void
		{
			clearOutput();
			if (monster.HP < 1) outputText("The hellhound's flames dim and the heads let out a whine before the creature slumps down, defeated and barely conscious. After all the trouble you had with him, you want to have some fun in exchange. \"<i>Bad boy, roll over!</i>\" you command as if the hellhound was just an ordinary domestic dog. To your surprise the creature actually does as you say. Accepting your victory he rolls onto his back, exposing his human-like abs and throat, signaling submissiveness. Looking down on your foe, your lustful gaze rests upon his privates. You examine the unusual ballsack with its quadruple testes, but the real treasure is yet to be found. Pulling on his sheath you reveal his twin dog members. An obsessive idea comes to your mind and you are determined to put his magnificent tools to a good use.\n\n", false);
			else outputText("Unable to bear hurting you anymore, the hellhound's flames dim as he stops its attack. The two heads look at you, whining plaintively. After all the trouble you had with him, you want to have some fun in exchange. \"<i>Bad boy, roll over!</i>\" you command as if the hellhound was just an ordinary domestic dog. To your surprise the creature actually does as you say. Accepting your victory he rolls onto his back, exposing his human-like abs and throat, signaling submissiveness. Looking down on your foe, your lustful gaze rests upon his privates. You examine the unusual ballsack with its quadruple testes, but the real treasures are pulsating just above it. Pulling on his sheath, you smile as his twin members twitch in response. An obsessive idea comes to your mind and you are determined to put his magnificent tools to a good use.\n\n", false);

			outputText("You start caressing his pair of wonderful canine cocks. Although the hellhound is pretty out of it, his dicks ", false);
			if (monster.HP < 1) outputText("spring to life, extending rapidly from the sheath. Tentatively you give one of them a gentle lick, being rewarded with a drop of pre-cum.\n\n", false);
			else outputText("still manage to leak plenty of hot, steamy pre-cum all over his belly. Tentatively you give one of them a gentle lick, being rewarded with a dollop of the stuff.\n\n", false);
			//--- IF CORRUPTION < 20 ---
			if (player.cor < 20) {
				outputText("The corrupt juice burns on your tongue, far worse than the hottest spicy dish you have ever had. You instantly back off from his member, cursing this abomination of nature. Leaving the submissive creature as it is, you head back for your camp.", false);
				dynStats("lus", -99);
				combat.cleanupAfterCombat();
				return;
			}
			//--- ELSE (CORRUPTION >= 20) ---
			else {
				outputText("The musky scent sends pleasure all over your body, moistening your " + player.vaginaDescript(0) + ". You decide the foreplay is over and remove the lower part of your " + player.armorName + ". You stroke both members, bringing them to full, overly-erect state. You grab one of them while you carefully position your butt over the first mastiff-like dong. Its pointy tip pushes against your asshole. Relaxing your sphincter, the pre-dripping cone-shaped rod easily slides into you. Having the first penis halfway buried into your ready asshole, you stop. Struggling with your balance, you grab the hellhound's other throbbing member, guiding it to your now soaking vagina. Slowly you let yourself down, impaling yourself on his gorgeous twin members.  ", false);
				player.cuntChange(monster.cockArea(0), true, false, true);
				player.buttChange(monster.cockArea(1), true, false, true);
				// --- CORRUPTION < 40 (and not masocistic - I lost track if there is such a perk) ---
				if (player.cor < 40 && player.findPerk(PerkLib.Masochist) < 0) {
					outputText("As you bottom out on his sheath, you lean forward to engulf more of his hot cocks inside you. The hellhound enjoys the treatment you are giving him. As a result, the flames along his eyes and snout flicker back to life. Just as your hardening clit presses against the top of his ballsack, the hellhound's natural flames lick across your sex. The magical fire fills you with arousal, but also applies intense pain to your most sensitive spot. You practically jump off the corrupt creature, pulling the dicks from your holes in great speed. Nearly blacking out from the sensations, you cover your burnt button, not daring to touch it. You curse the creature, loudly swearing at the hellhound. In your fury, you barely notice that he looks disappointed and maybe even somewhat sorry.", false);
					player.takeDamage(20);
					dynStats("lus", -99);
					//--> deals 20dmg (lowering hp to a minimum of 1), introduces inability to masturbate
					combat.cleanupAfterCombat();
					return;
				}
				//--- ELSE (CORRUPTION >= 40) ---
				outputText("His magical natural flames fill your body with fierce warmth, arousing you further. You pick yourself up, letting the hellhound's cocks nearly escape your nethers just to sit down again, taking the duo of dog members to the hilt. Grabbing his hind legs like the handlebars of an exercise machine, you bring yourself into position for a good amount of training. Gradually, you pick up the pace, rocking your hips up and down, enjoying the awesome double penetration.", false);
				if (player.biggestTitSize() > 1) outputText("  Your " + player.chestDesc() + " jiggle in exquisite ways along with your bumping, grinding motions.", false);
				outputText("  Riding the hound for a couple of minutes, you feel the dick in your " + player.assholeDescript() + " extending, giving you a good stretching. Its brother in your " + player.vaginaDescript(0) + " does the same, pushing more and more girl-fluids out of your slippery slit while stimulating your sensitive clit from the inside. You lean forward, running your hands through your fuckpet's dense midnight black fur, feeling his animal body warmth. The hellhound is moaning and panting beneath you, unsure whether to fear you or to enjoy what you are doing to him.\n\n", false);

				//--- IF PC HAS PENIS ---
				if (player.hasCock()) {
					outputText("His canine cock in your anus stimulates your prostate perfectly. His exotic black dong applies pressure in parts of your body you wouldn't expect to get such pleasure from.", false);
					//--- IF ONE PENIS ---
					if (player.totalCocks() == 1) outputText("  Soon your own " + player.cockDescript(0) + " reacts, quickly growing into a full throbbing erection. You leave your member alone, and it keeps flapping against the hellhound's belly while you ride him.", false);
					//--- ELSE ---
					else outputText("  Soon " + player.sMultiCockDesc() + " reacts, quickly growing into a throbbing erection.  You leave your members alone, and they flap against the hellhound's belly while you ride him.", false);
				}
				//--- IF PC HAS BALLS ---
				if (player.balls > 0) outputText("  Whenever you lower your hips to your mates belly, your " + player.ballsDescriptLight() + " touches his. The magical flames fill your scrotum with unnatural heat but no pain. You literally feel the cum in your balls boiling upwards, building up immense pressure.", false);
				outputText("\n\n", false);

				outputText("Way too early, the two doggie pricks stuffed inside you start to twitch, unloading four balls worth of spunk into you. In ecstasy, the hellhound's eyes look in four different directions. The dual eruptions in your love-canal and rectum feel amazing as they pulse in and out of sync, dumping cum into your body over and over.  The hellhound's contractions ebb away as he finishes, but you're not done yet. You slowly start tilting your hips back and forth, continuing to fiercely fuck the prime member while the other rests nearly motionless in your ass. Soon the hellhound whines from the unwanted stimulation of his now sensitive pricks, but he is too defeated to put up much of a struggle.\n\n", false);

				outputText("Slowly but steadily you bring yourself to the verge of orgasm. The hellhound under you squirms and tries to get free, his hind legs flailing through the air behind your back. You keep riding his magnificent member, grinding it up and down in your moist cave. Finally you feel the familiar rippling of your vaginal walls, milking his cock and intensifying your pleasant sensations. Clamping down on his members, you keep moving your hips in a circling motion, working your clit, vagina and butt in equal measure. The sensations eventually grant you an intense orgasm while the hellhound's still-distended members apply the perfect pressure to all of your sensitive spots and prolong your bliss.", false);
				//--- IF PC HAS PENIS ---
				if (player.totalCocks() > 0) {
					// --- IF ONE PENIS ---
					if (player.cockTotal() == 1) outputText("Your " + player.cockDescript(0) + " twitches as it ejects its sticky load.", false);
					//--- ELSE ---
					else outputText("Your " + player.multiCockDescriptLight() + " twitch as they eject their sticky loads.", false);
					outputText("  Keeping up your motions, you scatter your cum across the hellhound's body and the ground nearby.", false);
					//--- IF MESSY ORGASM PERK OR CUM MULTIPILER > 5 ---
					if (player.cumQ() > 700) outputText("  As your orgasm drags on, you practically drench the hellhound in your seed. An especially large load lands on his snouts and the heads greedily start licking your juice with their canine toungues. Your mate's black fur is soaked with your cum, and he'll definitely be busy licking himself clean for some time.", false);
				}


				outputText("\n\n", false);

				outputText("Busy with your own orgasm, you barely notice the twitching of the dual pricks buried inside you.  The hellhound launches into another orgasm or two, his dongs aching for peace and wanting to go soft, but forced to orgasm by your body.  You clench your muscles, locking the blood in the throbbing members, trying to preserve the sensations forever.\n\n", false);

				outputText("Finally having finished, you relax your anal sphincter and allow his member to leave your anus. His members rise from the feel of the incredible amount of cum his quadruple balls pumped into your holes squirting back out to wash over them. The hellhound curls up, spent, his tail covering his privates. His rods look a little red from the intense fuck, and you're sure that in spite of his fiery nature he is experiencing a little more than a burning sensation.", false);
				//--> increases corruption, usual post coital procedure
				player.orgasm();
				//[if not corrupt]
				if (player.cor < 40) dynStats("tou", -2, "cor", 1);
				//[if corrupt]
				else dynStats("cor", 1.5);
				//Preggers chance!
				player.knockUp(PregnancyStore.PREGNANCY_HELL_HOUND, PregnancyStore.INCUBATION_HELL_HOUND, 101);
			}
			combat.cleanupAfterCombat();
		}
	}
}
