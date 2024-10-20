/**
 * Created by aimozg on 04.01.14.
 */
package classes.Scenes.Areas.Mountain
{
import classes.*;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Scenes.NPCs.LunaFollower;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

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
			clearOutput();
			outputText("You hear a fiery howl as a demonic, two-headed beast-man leaps out in front of you!");
			camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_HELLHOUNDS);
			startCombat(new HellHound());
			spriteSelect(SpriteDb.s_hellhound);
		}


		public function hellhoundRapesPlayer():void
		{
			//Lust or HP loss texts here
			clearOutput();
			if (player.lust >= player.maxOverLust()) outputText("Overcome by sexual desire, you submit to the hungry hellhound.\n\n");
			else outputText("Too weak to continue fighting, you fall to your knees.\n\n");
			outputText("The heads of the hellhound grin with desire as he rises onto his hind legs. As the hellhound stands before you, your eyes widen at the sight of its equipment: a pair of eight-inch long black rods, one above the other, with a sack containing a quad of flaming balls underneath. As the hound swaggers closer, you gulp at the thought of what those fiery balls are going to be pumping into you. You are helpless against the hellhound as he pushes you onto your ");
			if (player.lowerBody == LowerBody.HOOFED) outputText("hocks and knees");
			else outputText("hands and knees");
			outputText(" and positions himself behind you. He grips you with his clawed hands on your shoulders and easily holds you in place. The powerful creature is easily able to get past your [armor], and you feel one of his rods brush against your [butt].  A shudder shoots through your body as he brings his two heads down to either side of your own, his hot canine breath blowing past your ears. He stays there for a few moments, completely still... before suddenly pulling his heads back and ");
			if (player.vaginas.length > 0 && !player.isNaga()) outputText("slamming his twin dicks into your " + vaginaDescript(0) + " and your " + assholeDescript() + ".  ");
			else outputText("slamming his lower dick into your " + assholeDescript() + ", while rubbing the other between the cheeks of your [butt].  ");
			if (player.vaginas.length > 0 && !player.isNaga()) {
				if (player.vaginalCapacity() < monster.cockArea(0)) outputText("You feel an intense mixture of sensations in your lower body as your " + assholeDescript() + " feels like it is being torn apart, while your " + vaginaDescript(0) + " is filled with an intense pleasure at being filled with the creature's large member.  ");
				else outputText("Your lower body explodes with pain as the hellhound forces himself in too quickly for either your " + assholeDescript() + " or your " + vaginaDescript(0) + " to handle.  ");
				if (player.vaginas[0].virgin) outputText("<b>You are no longer a virgin!  </b>");
				if (player.cuntChange(monster.cockArea(0), false)) outputText("The beast howls as your " + vaginaDescript(0) + " is stretched to accommodate the large shaft.  ");
				outputText("The hellhound pants for a few seconds before continuing.  ");
				if (player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_WET) outputText("The pause gives your " + vaginaDescript(0) + " time to moisten, ensuring the next thrust won't be quite as rough.  ");
				outputText("This time the beast starts pumping in and out more gently, only a short distance at a time as the hellhound continues panting.  As the pain in your " + assholeDescript() + " fades, you start feeling pleasure to match the sensations rising from your " + vaginaDescript(0) + ". Each thrust of the beast's twin manhoods bring you closer and closer to your peak.\n\n");
				//Cum
				outputText("As you reach your climax, the beast howls, and you feel its incredibly hot seed pour into you.  ");
				if (player.cor < 40) outputText("You moan as your insides begin to heat up. The uncomfortably hot sensation only grows as more and more of its fiery seed is pumped into your body. After what feels like an eternity, the beast pulls out of you. He gives your " + vaginaDescript(0) + " and your " + assholeDescript() + " a single extended lick with its long dog-like tongue before running off out of sight. The tainted heat inside you proves to be too much, and you pass out. After some time passes, you wake up to find the corrupt warmth inside you has thankfully faded away. You're able to stand up again, but the damage is done, and the creature's seed has left you feeling rather weak.");
				else outputText("His flaming seed brings about a pleasure you had not expected; your insides feel like they are burning with passion and power.  It is an incredible and fiery experience, one that you don't think you could have had if it wasn't for the power of corruption that you've gained since you got here. Too soon, the beast pulls out of you.  He gives your " + vaginaDescript(0) + " and your " + assholeDescript() + " a single extended lick with his long dog-like tongue before he runs off. You quickly look over and manage to catch a glimpse of its tail before it disappears from view, just before your body falls into a deep sleep. When you wake, you can still feel the afterglow of the hot seed inside you.");
				//Preggers chance!
				if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
				else player.knockUp(PregnancyStore.PREGNANCY_HELL_HOUND, PregnancyStore.INCUBATION_HELL_HOUND, 101);
			}
			else {
				outputText("Your lower body explodes with pain as the hellhound forces himself in too quickly for your " + assholeDescript() + " to handle. He pauses and pants for a few seconds, but you barely have enough time to catch your breath before the beast starts thrusting in and out again. However, this time the beast starts pumping in and out more gently, only a short distance at a time as the hellhound continues panting.  As the pain in your " + assholeDescript() + " fades, you start feeling strong pleasure from it. Each thrust of the beast's lower manhood, combined with the upper one tickling and teasing your [butt] above it brings you closer and closer to your peak.\n\n");
				//Cum
				outputText("As you reach your climax, the beast howls, and you feel its incredibly hot seed pour into you and onto your back.  ");
				if (player.cor < 40) outputText("You moan while trying to break free to get the heat off your back... but the beast keeps a firm grip on you as more and more of its fiery seed is pumped into and onto your body. After what feels like an eternity, the beast pulls out of you. He gives your " + assholeDescript() + " a single extended lick with his long dog-like tongue before running off out of sight. You are finally able to roll around and get the heat off of your back, but you can do nothing about the tainted warmth inside you. The heat proves to be too much, and you pass out. After some time passes, you wake up to find the fire inside you has thankfully faded away. You're able to stand up again, but the damage is done, and the creature's seed has left you feeling rather weak.");
				else outputText("His flaming seed brings about a pleasure you had not expected; your insides feel like they are alight with passion and power. You feel a similar joy on your back, and your muscles feel like they are being massaged from the heat.  It is an incredible and fiery experience, one that you don't think you could have had if it wasn't for the power of corruption that you've gained since you got here. Too soon, the beast pulls out of you, giving your " + assholeDescript() + " a single extended lick with its long dog-like tongue before running off. You quickly look over and manage to catch a glimpse of its tail before it disappears from view, just before your body falls into a deep sleep. When you wake, you can still feel the afterglow of the flaming seed inside you.");
				player.sexReward("cum","Vaginal");
			}
			player.sexReward("cum","Anal");
			player.buttChange(monster.cockArea(0), true);
			if (player.cor < 40) dynStats("tou", -2, "cor", 1);
			else dynStats("cor", 1.5);
			cleanupAfterCombat();
		}

		public function hellHoundPostFightOptions(hpVictory:Boolean):void
		{
			clearOutput();
			menu();
			if (hpVictory) {
				outputText("The hellhound's flames dim, and the heads let out a whine before the creature slumps down, defeated and nearly unconscious" + (monster is InfestedHellhound? ", and yet still drooling worms." : "."));
				addButton(12, "Slay", killHellhound);
			}
			else
				outputText("Unable to bear " + (monster is InfestedHellhound? "its unnatural arousal, the infested" : "hurting you anymore, the") + " hellhound's flames dim as he stops his attack. The two heads look at you, whining plaintively.  The hellhound slowly pads over to you and nudges its noses at your crotch.  It seems he wishes to pleasure you.\n\n");
			if (player.lust >= 33) {
				if (hpVictory)
					outputText("  You find yourself musing that you could probably take advantage of the poor 'doggy'.  Do you fuck it?");
				else
					outputText("You realize your desires aren't quite sated.  You could let it please you" + (player.hasVagina() && !player.isNaga() ? " or make it fuck you" : "") + ".  What do you do?");
				//sex menu
				addButton(0, "Get Licked", hellHoundGetsRaped);
				addButtonIfTrue(1, "Fuck", hellHoundPropahRape, "Req. a vagina and NOT naga lower body.", player.hasVagina() && !player.isNaga());
				addButtonIfTrue(2, "TakeBothIn", takeBothIn, "Req. to be a liliraune.", player.isLiliraune());
				addButtonIfTrue(3, "Dominate", rapeCerberusStyle, "Req. to be a Cerberus.", player.isRaceCached(Races.CERBERUS));
				SceneLib.uniqueSexScene.pcUSSPreChecksV2(curry(hellHoundPostFightOptions, hpVictory)); //CALLED AT THE END
			}
			else {
				if (hpVictory) outputText("You're not aroused enough to rape your enemy.'.");
				else outputText("You turn away, not really turned on enough to be interested in such an offer.");
			}
			addButtonIfTrue(11, "Tame It", SceneLib.campMakeWinions.tamingAttempt, "Req. to have Job: Tamer", player.hasPerk(PerkLib.JobTamer));
			addButton(14, "Leave", cleanupAfterCombat);
		}

		public function hellHoundGetsRaped():void
		{
			clearOutput();
			if (player.gender == 0) {
				outputText("The two heads stare at your lack of sexual endowments for a few seconds before looking up at you sadly.  With a whine, the hellhound wanders off.  Feeling rather unsatisfied, you think that you should probably fix your lack of sexual 'parts'...");
				cleanupAfterCombat();
			}
			else sceneHunter.selectGender(
				curry(sceneHunter.selectSingleMulti, dickSingleF, dickMultiF),
				vagF, null, hermF
			);

			//==============================================================
			function dickSingleF():void {
				outputText("The twin heads of the hellhound eagerly lick your [cock] for a while.  The large, flat tongues give you a rather unusual feeling, but it is definitely effective. As you approach your peak, one of the heads tries to take your manhood into its mouth. But the other head doesn't seem all that pleased with this, and the two start to nip at each other in an effort to claim the right to be the one to push you over the edge. Annoyed at being ignored, you give both heads a smack with your hand. After a moment of recoil, they look down apologetically before resuming their licking. As you peak, the heads pull back and try to catch all the cum that erupts from your [cock] in their mouths. The fierce competition between the two means that most of the cum ends up outside their eager maws, but they are nontheless satisfied.  With a pair of happy barks, the hellhound turns and runs away.");
				player.sexReward("saliva","Dick");
				cleanupAfterCombat();
			}
			function vagF():void {
				outputText("The twin heads of the hellhound eagerly lick your " + vaginaDescript(0) + " for a while.  The large, flat tongues give you a rather unusual feeling, but it is definitely effective. As you approach your peak, one of the heads tries to force the other out of the way and push its snout into your " + vaginaDescript(0) + ". But the other head doesn't seem all that pleased with this, and the two start to nip at each other in an effort to claim the right to be the one to push you over the edge. Annoyed at being ignored, you give both heads a smack with your hand. After a moment of recoil, they look down apologetically before resuming their licking. As you peak, the heads resume their quarrel and try to drink as much as the fluids coming from your " + vaginaDescript(0) + " as they can.  You don't know, which got the most, but before long your " + vaginaDescript(0) + " is definitely quite clean.  With a pair of happy barks, the hellhound turns and runs away.");
				player.sexReward("saliva","Vaginal");
				cleanupAfterCombat();
			}
			function hermF():void {
				outputText("One of the heads eagerly starts licking your [cock] while the other starts working on your " + vaginaDescript(0) + ". The large, flat tongues give you a rather unusual feeling, but it is definitely effective.  As you approach your peak, the head that had been licking your [cock] suddenly takes it into its mouth while the other pushes its snout into your " + vaginaDescript(0) + ". The pleasure from this new arrangement quickly overwhelms you, leaving you dazed.  When your senses return to you, you look up to see the hellhound's tongues running all over their mouths, clearly very happy.  With a pair of happy barks, the hellhound turns and runs away.");
				player.sexReward("saliva","Dick");
				player.sexReward("saliva","Vaginal");
				cleanupAfterCombat();
			}
			function dickMultiF():void {
				outputText("One of the heads eagerly starts licking your [cock] while the other starts to work on your " + cockDescript(1) + ". The large, flat tongues give you a rather unusual feeling, but it is definitely effective.   As you approach your peak, the heads quickly take your [cock] and " + cockDescript(1) + " into their mouths. The pleasure from this new arrangement quickly overwhelms you, leaving you dazed.  When your senses return to you, you look up to see the hellhound's tongues running all over their mouths, clearly very happy.  With a pair of happy barks, the hellhound turns and runs away.");
				player.sexReward("saliva","Dick");
				player.sexReward("saliva","Dick");
				cleanupAfterCombat();
			}



		}


//HELLHOUND MASTER+ BAD ENDZZZZZ
		public function HellHoundMasterEncounter():void
		{
			clearOutput();
			//Initial encounter (A)
			//Requires canine face, [either two dog dicks, or a vag and pregnant with a hellhound], at least two other hellhound features (black fur, dog legs, dog tail), and corruption >=60.
			if (flags[kFLAGS.HELLHOUND_MASTER_PROGRESS] == 0) {
				outputText("As you're wandering the mountains, you feel an odd presence in the back of your mind.  It calls out to you with promise of power and safety, but part of you feels a bit apprehensive at the prospect of giving yourself over to it.  Do you let the presence take over?");
				//Player chooses yes/no - no -> (B), yes -> (C)
				doYesNo(acceptCrazyPresences, declineCrazyPresences);
			}
			else if (flags[kFLAGS.HELLHOUND_MASTER_PROGRESS] == 1) {
				//Second Encounter (D)
				//can be triggered if the PC still has the required canine traits, and has a piece of Lethicite.
				outputText("As you're wandering the mountains, you once again feel an odd presence in the back of your mind.  You're sure it is the hellhound master once again.  You look at the pink crystal in your possession, and wonder if you should exchange it for the promissed hellfire.  Do you let the presence take over and give away the Lethicite?");
				doYesNo(giveUpLethicite, declineGivingAwayLethicite);
				//Player choose yes or no, no -> E, yes -> F
			}
		}

//choose no (B)
		private function declineCrazyPresences():void
		{
			clearOutput();
			outputText("You force the presence out of your mind.  You feel almost a bit lost after it disappears, but giving yourself over to foreign control can never be a good idea, can it?");
			//end event, A can repeat later.
			endEncounter();
		}

//choose yes (C)
		private function acceptCrazyPresences():void
		{
			clearOutput();
			outputText("You relax your mind and allow the presence to fill your mind.  It takes control of your consciousness, and guides your thoughts.  You feel like you should go home, your master probably wants to meet you for the first time.  Instinctively you navigate the many twists and turns of the mountains, a path you can't remember, and don't have the presence of mind to chart.  Some time later, you emerge from the crags and passes to find an elaborate vale, filled with hellhounds.\n\n");

			outputText("You smile at the sight of your brothers running around, playing with each other, and fucking one another.  You can see many of both the violent twin headed and dicked hellhound males, and the more seductive twin headed and cunted hellhound females. It is also easy to see the vicious clearly heavily pregnant barghests, given the wide birth the other hounds give them once the females reach that stage.  It is quite the pack, but you can't look proudly at it for too long, you need to go see your master!\n\n");

			outputText("You continue your trek to the master's home, you can feel that you're close.  At the back of the vale, stands what seems to be a fort of sorts in front of a large cliff face.  At the entrance, stands a stunning indigo succubus holding the leash of a very big hellhound.  She smiles as she sees you approach and calls you over.  You happily trot over to the demon mistress and nuzzle your head against her thighs.  She takes your canine head between her hands and gives you a playful rub while saying \"<i>Ah, what a cute little lost doggy.  You here to see the master?  Go on in, he always has time for his faithful hounds.  You're probably really lonely, I'm sure he can find a friend to join you on that beautiful body.</i>\"  You nod at her eagerly and proceed inside.\n\n");
			//nxt page
			doNext(acceptCrazyPresencesII);
		}

		private function acceptCrazyPresencesII():void
		{
			clearOutput();
			outputText("The interior of the fort is obviously just the outer fortifications of a much bigger complex that goes deep inside a cave system.  As you move further inside, you find yourself stopping in front of the kennels.  These seem to be for the strongest of the hellhounds, and those that have their own demon masters.  You see a few other incubi and succubi playing with their hellhound pets.  For the most part though, you don't pay attention to the details of the fortress.  You're far too excited to get to the deepest part and meet up with your master, so you hurry on past.\n\n");

			outputText("You quickly move through the kennels, the pleasure pits, and the lab to get to the inner sanctum.  Inside you find a mighty and beautiful masculine demon.  He grins as he sees you and tells you to stand up so he can get a good look at you.  You eagerly rise up onto your hind legs and give a happy yip as he starts to walk around you and examine you.  At the same time, you get a chance to have a closer look at him.  He stands about seven feet tall, and has beautifully carved muscles and dark skin.  It is quite clear that he likes the appearance of his hounds, as he takes a form that has a build that is very close to that of the male hounds.  Well, save for only having one head, having both two dicks and two cunts.  He probably samples his hounds all the time.  The thought that he might do the same to you too brings on more than a little excitement.\n\n");

			outputText("After getting a good look at you, he speaks up.  \"<i>Well, well, well, how interesting!  So you were such a fan of my pets that you wanted to become one yourself, huh?  I'm flattered!</i>\"  He takes a step back and gets a look at the whole package.  \"<i>Very nice!  You've gotten very close to being a hellhound without my help, but it isn't a perfect job.  If I'm not mistaken, you haven't got the signature hellfire, have you?</i>\"  He pauses for a moment, while he taps his chin and strokes one of his shafts.  \"<i>Tell you what, If you can find me a piece of a pink crystal filled with soul power, I'll give you the power of hellfire.  Nothing else to it!  Just follow my call when you've got it, and you'll find your way back, don't worry.</i>\"\n\n");

			outputText("Some time later, you find yourself at the base of the mountains.  Your mind is once again your own.  After a few moments you realize that you can still feel the faint call of the hellhound master's voice in your mind, then it's gone.  You could probably find it again without too much trouble if you just head back into the mountains, but there isn't really much point unless you've got something to trade for the hellfire he mentioned...");

			outputText(" You extract Marae's lethicite from your pack, and wonder if you really want to trade it for the hellfire he offered.");
			//advance to repeat version
			flags[kFLAGS.HELLHOUND_MASTER_PROGRESS] = 1;
			endEncounter();
		}

//Choose no (E)
		private function declineGivingAwayLethicite():void
		{
			clearOutput();
			outputText("You push the presence out of your mind.  Maybe later you'll collect the hellfire, but for now you'd rather keep the lethicite.");
			//end event, D can repeat.
			endEncounter();
		}

//Choose yes (F)
		private function giveUpLethicite():void
		{
			clearOutput();
			outputText("You once again allow the master's will to fill you and bring you to his home.  Once again you pass through the many crags and passes of the mountains and find yourself in the hellhound valley.  The place is just as it was the last time you were here, but you don't take in the views, you have other pressing matters to deal with.  You quickly make your way across the valley to the entrance to the master's lair.\n\n");

			outputText("Another succubus stands guard at the entrance with another hellhound standing next to her.  She gives you a bit of a disdainful look before her hound steps forward.  \"<i>My mistress doesn't like dealing with lower hounds.  The grand master will be glad to see you, however.  Please go right in.</i>\"  One of its heads intones before directing you inside the fort.  Without hesitation, you rush in.\n\n");

			outputText("You barely spare a thought at the interior in your hurry to get to the master.  As you burst into the room, the master's eyes light up at the sight of you.  \"<i>Ah!  It is my favorite fan.  Have you brought me a piece of that pink crystal I asked you for?</i>\"\n\n");

			//Player chooses to either give Merae's full Lethicite, or a regular piece of Lethicite.  Limited by what they have, of course.  They cannot choose to leave at this point.  Merae's Lethicite -> G, Regular Lethicite -> H.
			menu();
			addButton(0, "Give Part", giveLethicitePiece);
			addButtonIfTrue(1, "Give All", giveALLTHELETHICITES,  "Oops. You've already wasted a part of it somewhere.",
				player.keyItemvX("Marae's Lethicite", 1) == 3);
		}

//Regular Lethicite
		private function giveLethicitePiece():void
		{
			clearOutput();
			outputText("You produce the pink crystal and hand it to the master.  As the crystal touches his hand, he gives a low growl of pleasure and holds the crystal up to his eyes.  \"<i>Ah yes, excellent!  Thank you so much for this tasty treat of power.</i>\"\n\n");
			if (player.keyItemvX("Marae's Lethicite", 1) == 3) {
				outputText("He looks at the crystal for some time, obviously wanting to consume it all, but then breaks a small part of it and giving the crystal back to you.  \"<i>This is enough for the hellfire, I think.  Go ahead and keep the rest, my favorite fan!</i>\"\n\n");
			}
			else if (player.keyItemvX("Marae's Lethicite", 1) == 2) {
				outputText("He looks at the crystal for a moment, before biting off half of it and giving the other half back to you.  \"<i>This is enough for the hellfire, I think.  Go ahead and keep the rest, my favorite fan!</i>\"\n\n");
			}
			player.addKeyValue("Marae's Lethicite", 1, -1);
			outputText("He rolls the crystal around in his mouth for a few moments before swallowing the crystal.  In a moment, white flames rise up around his body, and he gives you a wicked grin.  \"<i>Now, let me give you the gift promised for this tribute.</i>\"\n\n");

			outputText("He extracts a special cup from his throne, and starts to stroke the two of his large 10-inch pointed members with one hand.  \"<i>Watch closely, I want you to see where this power comes from.</i>\"  He starts to pant as the movements of his hands intensifies.  At the same time the aura concentrates on his pair of cocks, and he brings the cup in front of them.  He gives a satisfied groan, and white hot cum sprays around the cup, carrying the same flame.  Clearly he isn't finished yet, and he brings the cup under his equipment, to catch a spray of less masculine fluids, flowing out from the omnibus's other genitals.\n\n");

			outputText("Afterwards, there is quite the pool of hot fluids on the ground around the omnibus, but he seems to think that enough was collected into the cup and hands it to you with a smile.  \"<i>Drink up my special friend, and partake in my hellfire.</i>\"  You put the cup to your lips and down the hot fluid.  In moments, you feel a rush pass through your body, and your stomach fills with heat and power.  You bring out the rush, and let out a roar of corrupt flames.  The master holds out his arms and grins as the wave of hellfire passes over him.\n\n");

			outputText("He pants, and waits for a moment to relish the feeling that your flames gave him.  \"<i>Now my young pet, you have the greatest power I've given my hounds.  Relish this gift!</i>\"  he declares before sending you on your way.  Some time later, you find yourself at the base of the mountains, your will once again your own.  You take a few experimental breaths, and can easily feel the fires within you.  It seems that you do indeed now have the power to breathe hellhound flames.\n\n");

			outputText("After a moment, you notice that something else seems off... the world seems to be slightly tinged red.  Worried that something else might have been done to you, you find some water to look at your reflection.  After a moment of shock, you steady yourself, and slowly tell yourself that you now have visible fires in your eyes and mouth.  This is going to take some getting used to.\n\n");

			outputText("<b>You now have the power to breathe hellfire!</b>  (This power remains available to you so long as you maintain a corruption of at least 50.)");
			//increase lust by 30, corruption by 6, and libido by 3
			dynStats("lib", 3, "lus", 30, "cor", 6);
			player.createPerk(PerkLib.Hellfire, 0, 0, 0, 0);
			//Hellhounds no longer encounterable.
			flags[kFLAGS.HELLHOUND_MASTER_PROGRESS]++;
			endEncounter();
		}

//Merae's Lethicite
		private function giveALLTHELETHICITES():void
		{
			clearOutput();
			//Give him Merae's Lethicite, now he's got enough power for a major upheaval in the demon hierarchy.  You don't get to keep being a champion.
			//Max player's lust for genital descriptions.
			dynStats("lus=", player.maxOverLust());

			outputText("You pull out the giant pink crystal that you stole from Merae.  At the sight of the gem, the demon's eyes go so wide, you almost can't believe that they stay in his head.  \"<i>Is that what I think... yes, YES! This is quite the prize you have brought me, my wonderful imitator!</i>\"  He snatches the crystal out of your hands and cradles it in his hands for a few moments, a crazed hungry look in his eyes.  You remain in his power, and can do nothing but watch as he raves for a few minutes with the jewel in his hands.\n\n");

			outputText("\"<i>Hum, hum, hum.</i>\"  He chuckles.  \"<i>The crystal of a goddess, this is going to bring changes, oh yes.</i>\"  The crystal flares up as he grips it more tightly.  \"<i>And you, oh you deserve so much more than just hellfire for this gift.  Come!</i>\"  He calls out.  In a moment, the biggest hellhound you've ever seen rushes into the room.\n\n");
			sceneHunter.print("Fork: do you have 2 doggy dicks?");
			//if (PC has two dog dicks)
			if (player.dogCocks() >= 2) {
				//the male bad end
				outputText("This hound is quite clearly a she, bearing a massive septuplet of breasts, and wide hips.  She is also quite clearly pregnant, and radiates an intense aura of power.  One of her two heads intones towards the crazed omnibus, \"<i>You called me master?</i>\"  \"<i>Yes I did my precious Cremera!  Have sex with this imitation at once!  [He] is to become your third head!</i>\"\n\n");

				outputText("Instantly Cremera turns around and presents to you her waiting sloppy twin cunts.  The hellhound master walks behind you and slaps you on the ass.  \"<i>Don't keep her waiting.</i>\"  He says as a shudder passes through you and your [armor] falls to the ground around you.\n\n");

				//make sure that the PC will fit in the bitch
				//(PC's dog cocks are not each of an area of 20 to 60 OR PC has more than two cocks)
				if (player.cockTotal() > 2 || player.cockThatFits(60) < 0) {
					outputText("He then reaches around your waist and takes a hold of your [cocks].  \"<i>Before we get started, let's make sure you're just right for Cremera.</i>\"  He then reforms your body to have twin doggy pricks of appropriately sized.  \"<i>Now.</i>\"\n\n");
					//PC's dicks become two 14 by 3 inch dog dicks, all other dicks are removed
					transformations.CockDog(0, 14, 3).applyEffect(false);
					transformations.CockDog(1, 14, 3).applyEffect(false);
					while (player.cocks.length > 2) {
						player.removeCock(2, 1);
					}
				}
				outputText("You don't hesitate.  You pounce on the horny barghest, slamming your two dog pricks inside her two cunts without hesitation.  The bitch responds with a low growl, and starts bucking her rear against you, while you thrust into her with abandon.  The pleasure of her interior drives you mad like no other that you've ever been in before.  The loud squelching and stimulation of her slobbering pussies don't give you a chance to do anything but thrust and lose yourself in the feeling.\n\n");

				outputText("\n\nIn a matter of moments, you're releasing yourself inside her and feeling your knots swell to tie the two of you together.  The master caresses your head a moment before whispering in your ear, \"<i>Normally, dog knots are about the only thing I don't like about regular old doggies, but for this, it's perfect.</i>\"  He grins at you and holds up a brilliantly glowing hand, before smacking you on your [ass].  You feel like you've been forced even further inside Cremera, and can't help but release yourself once more inside her from the pleasure.  \"<i>Not enough!</i>\" the omnibus yells and smacks you again, pushing you even further inside her.  You don't even have a chance to think about how the hell this is happening, you're too overwhelmed by the pleasure, but when you try to cum, you find you can't!  You give a whimper, but the demon ignores you and smacks you again, forcing you even further in.  You cry out at not being able to cum, but all you're met with is another smack, then another, and another...\n\n");

				outputText("After what feels like hours, you're hit one more time, and feel like you've burst through Cremera completely. You feel your twin dog cocks burst free and finally cum; they feel like they cum out everything inside you.  You pant with finally being free and look down in front of you.   You blink a few times and focus on what is in front of you.  All you can see are several rows of breasts, a protruding pregnant belly, and your large dog cocks, now oddly with their knots gone and turned black.  They also seem to have gained a package of four balls underneath.  In front of you sits a huge pool of white steaming fluid, with a pink crystal resting in the middle.\n\n");

				outputText("\"<i>Well my new pet, what do you think?</i>\"  A voice calls out in your head.  You look to the side, and see one of Cremera's heads on your right, and the other on your left.  Your hands seem to move on their own, and grip your twin dicks.  Another voice calls out in your mind, \"<i>They are wonderful master.</i>\"\n\n");
			}
			else {
				//female part
				outputText("The hound is quite clearly a he, carrying a pair of 15 inch long black pointed shafts, and a sack containing a quad of cantaloupe sized balls.  He radiates an intense aura of power.  One of his two heads intones towards the crazed omnibus, \"<i>You called me master?</i>\"  \"<i>Yes I did my precious Cimer!  Have sex with this imitation at once!  [He] is to become your third head!</i>\"\n\n");

				outputText("Instantly Cimer moves behind you and puts one of his clawed hands on your head and starts to push you down, his twin dog dicks pushing into your back.  The master steps up in front of you and puts his hand under your chin.  \"<i>Don't disappoint my pet.</i>\"  He says and brings his hand down your body, and your [armor] tumbles to the ground.  Before Cimer has a chance to push you down, you bend over, ready to take his members in your " + vaginaDescript(0) + " and your " + assholeDescript() + ".  \"<i>Wait, one last preparation...</i>\"\n\n");

				outputText("He steps around behind you, and you feel something cool and small get put inside your " + assholeDescript() + ".  It seems to extend further inside you, and wriggles around.  You get an odd feeling in your gut, like it's being rearranged.  After a moment the object is removed, and you notice that your [butt] now feels remarkably like your " + vaginaDescript(0) + "!  \"<i>How do you like your new second vagina?  It will be perfect for my pet's rods, I even added the knots back to his cocks.  Normally, knots are about the only thing I don't like about regular old doggies, but for this, it's perfect.</i>\"\n\n");

				outputText("You barely register that he's finished talking when your whole lower body feels like it's being filled in the most wonderful way imaginable!\n\n");

				//If (PC's vag can't fit an area of 45)
				if (player.vaginalCapacity() < 45) {
					if (player.vaginas[0].virgin) {
						outputText("Relieving both your virgin holes of their virginity in one thrust, y");
					}
					else outputText("Y");
					//stretch vag to very loose
					player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_GAPING;
					outputText("our two cunts quickly stretch larger to accommodate the intruders.\n\n");
				}
				outputText("You let out a moan of pleasure from the pleasure of being filled.  The hound doesn't hesitate at all, and just thrusts into you with abandon.  You can't believe the feral feeling of it all, and that your twin womanhoods manage to so easily take the members and flow around them.\n\n");

				outputText("In moments, you feel Cimer's members explode inside you with their wonderful hot seed, and his new knots swell to tie the two of you together.  Though, something feels wrong, you didn't feel an orgasm yourself!  You give a whimper and try to thrust against Cimer's pair of dog pricks inside you.  Suddenly there is a loud smack, and you feel like Cimer was just propelled inside you even further!  It's an incredible feeling, almost like he is pushing past your [butt], but you still can't cum!  \"<i>This isn't enough!  Further inside, further!</i>\"  You hear the master yell.  Once again you feel Cimer being forced further and further inside you, again accentuated by a loud smacking noise.  Again, you find yourself unable to achieve sweet release, but you hardly have time to register that, as there is another burst and a smack, and another, and another.  It almost feels like your [butt] is being smacked...\n\n");

				outputText("After what feels like hours of painful pleasure without release, you're smacked on your rear one last time, and it feels like Cimer bursts through your body completely.  This finally frees the floodgates, and you feel like you're releasing everything in your body in the most powerful orgasm you've ever felt.  You pant for a moment and look down in front of you.  You can see your [allbreasts] and your pregnant belly in front of you. You also see a package of demonic dicks sticking out in front of you, with a quad of hot balls resting underneath.  In front of you is a large pool of white steaming fluid, with a pink crystal resting in the middle.\n\n");

				outputText("<i>Well my new pet, what do you think?</i>\"  A voice calls out in your head.  You look to the side, and see one of Cimer's heads on your right, and the other on your left.  Your hands seem to move on their own, and reach down to touch your " + vaginaDescript(0) + ".  Another voice calls out in your mind, <i>They are wonderful master.</i>\"\n\n");
			}
			outputText("You feel inclined to agree at the wonderful feeling of your new body, and the incredible amount of power you feel rushing through you.  You move one of your hands so that you can play with both your dicks and your cunts, relishing in the feeling of them and the flames lying within.  You gasp for a moment, and open your mouth as a rush of heat rises up from your chest and a burst of flame emerges from your mouth.\n\n");

			outputText("A powerful demon steps out in front of you, and picks up the crystal.  You can feel a strong connection with him, and you know this is your master.  \"<i>Well now, I think you need a new name now in commemoration of being the first three-headed hellhound, and for being the one who will give me the world.</i>\"  He unceremoniously puts the crystal in his mouth and swallows it.  \"<i>Your new name is Cerberus, and you're my greatest pet.</i>\"  He steps closer and looks into your center head's eyes for a moment.  \"<i>That's much better than being a champion ever was, isn't it?</i>\"  You can't help but eagerly nod in agreement.");
			player.sexReward("Cum","Default",true,false);
			dynStats("lib", 50, "cor", 100);
			EventParser.gameOver();

		}

		public function hellHoundPropahRape():void
		{
			clearOutput();
			if (monster.HP < 1) outputText("The hellhound's flames dim, and the heads let out a whine before the creature slumps down, defeated and barely conscious. After all the trouble you had with him, you want to have some fun in exchange. \"<i>Bad boy, roll over!</i>\" you command as if the hellhound was just an ordinary domestic dog. To your surprise the creature actually does as you say. Accepting your victory he rolls onto his back, exposing his human-like abs and throat, signaling submissiveness. Looking down on your foe, your lustful gaze rests upon his privates. You examine the unusual ballsack with its quadruple testes, but the real treasure is yet to be found. Pulling on his sheath you reveal his twin dog members.");
			else outputText("Unable to bear hurting you anymore, the hellhound's flames dim as he stops its attack. The two heads look at you, whining plaintively. After all the trouble you had with him, you want to have some fun in exchange. \"<i>Bad boy, roll over!</i>\" you command as if the hellhound was just an ordinary domestic dog. To your surprise the creature actually does as you say. Accepting your victory he rolls onto his back, exposing his human-like abs and throat, signaling submissiveness. Looking down on your foe, your lustful gaze rests upon his privates. You examine the unusual ballsack with its quadruple testes, but the real treasures are pulsating just above it. Pulling on his sheath, you smile as his twin members twitch in response.");
			outputText(" An obsessive idea comes to your mind, and you are determined to put his magnificent tools to a good use.\n\n")

			outputText("You start caressing his pair of wonderful canine cocks. Although the hellhound is pretty out of it, his dicks ");
			if (monster.HP < 1) outputText("spring to life, extending rapidly from the sheath. Tentatively you give one of them a gentle lick, being rewarded with a drop of pre-cum.\n\n");
			else outputText("still manage to leak plenty of hot, steamy pre-cum all over his belly. Tentatively you give one of them a gentle lick, being rewarded with a dollop of the stuff.\n\n");
			//--- IF CORRUPTION < 20 ---
			if (player.cor < 20 - player.corruptionTolerance) {
				sceneHunter.print("Check failed: mid-to-high corruption.");
				outputText("The corrupt juice burns on your tongue, far worse than the hottest spicy dish you have ever had. You instantly back off from his member, cursing this abomination of nature. Leaving the submissive creature as it is, you head back for your camp.");
				dynStats("lus", -99, "scale", false);
				cleanupAfterCombat();
				return;
			}
			//--- ELSE (CORRUPTION >= 20) ---
			else {
				outputText("The musky scent sends pleasure all over your body, moistening your " + vaginaDescript(0) + ". You decide the foreplay is over and remove the lower part of your [armor]. You stroke both members, bringing them to full, overly-erect state. You grab one of them while you carefully position your butt over the first mastiff-like dong. Its pointy tip pushes against your asshole. Relaxing your sphincter, the pre-dripping cone-shaped rod easily slides into you. Having the first penis halfway buried into your ready asshole, you stop. Struggling with your balance, you grab the hellhound's other throbbing member, guiding it to your now soaking vagina. Slowly you let yourself down, impaling yourself on his gorgeous twin members.  ");
				player.cuntChange(monster.cockArea(0), true, false, true);
				player.buttChange(monster.cockArea(1), true, false, true);
				// --- CORRUPTION < 40 (and not masocistic - I lost track if there is such a perk) ---
				if (player.cor < 40 - player.corruptionTolerance && !player.hasPerk(PerkLib.Masochist)) {
					sceneHunter.print("Check failed: high corruption or Masochist perk.");
					outputText("As you bottom out on his sheath, you lean forward to engulf more of his hot cocks inside you. The hellhound enjoys the treatment you are giving him. As a result, the flames along his eyes and snout flicker back to life. Just as your hardening clit presses against the top of his ballsack, the hellhound's natural flames lick across your sex. The magical fire fills you with arousal, but also applies intense pain to your most sensitive spot. You practically jump off the corrupt creature, pulling the dicks from your holes in great speed. Nearly blacking out from the sensations, you cover your burnt button, not daring to touch it. You curse the creature, loudly swearing at the hellhound. In your fury, you barely notice that he looks disappointed and maybe even somewhat sorry.");
					player.takeFireDamage(20);
					dynStats("lus", -99, "scale", false);
					//--> deals 20dmg (lowering hp to a minimum of 1), introduces inability to masturbate
					cleanupAfterCombat();
					return;
				}
				//--- ELSE (CORRUPTION >= 40) ---
				outputText("His magical natural flames fill your body with fierce warmth, arousing you further. You pick yourself up, letting the hellhound's cocks nearly escape your nethers just to sit down again, taking the duo of dog members to the hilt. Grabbing his hind legs like the handlebars of an exercise machine, you bring yourself into position for a good amount of training. Gradually, you pick up the pace, rocking your hips up and down, enjoying the awesome double penetration.");
				if (player.biggestTitSize() > 1) outputText("  Your " + chestDesc() + " jiggle in exquisite ways along with your bumping, grinding motions.");
				outputText("  Riding the hound for a couple of minutes, you feel the dick in your " + assholeDescript() + " extending, giving you a good stretching. Its brother in your " + vaginaDescript(0) + " does the same, pushing more and more girl-fluids out of your slippery slit while stimulating your sensitive clit from the inside. You lean forward, running your hands through your fuckpet's dense midnight black fur, feeling his animal body warmth. The hellhound is moaning and panting beneath you, unsure whether to fear you or to enjoy what you are doing to him.\n\n");

				//--- IF PC HAS PENIS ---
				if (player.hasCock()) {
					outputText("His canine cock in your anus stimulates your prostate perfectly. His exotic black dong applies pressure in parts of your body you wouldn't expect to get such pleasure from.");
					//--- IF ONE PENIS ---
					if (player.cockTotal() == 1) outputText("  Soon your own [cock] reacts, quickly growing into a full throbbing erection. You leave your member alone, and it keeps flapping against the hellhound's belly while you ride him.");
					//--- ELSE ---
					else outputText("  Soon " + sMultiCockDesc() + " reacts, quickly growing into a throbbing erection.  You leave your members alone, and they flap against the hellhound's belly while you ride him.");
				}
				//--- IF PC HAS BALLS ---
				if (player.hasBalls()) outputText("  Whenever you lower your hips to your mates belly, your [balls] touches his. The magical flames fill your scrotum with unnatural heat but no pain. You literally feel the cum in your balls boiling upwards, building up immense pressure.");
				outputText("\n\n");

				outputText("Way too early, the two doggie pricks stuffed inside you start to twitch, unloading four balls worth of spunk into you. In ecstasy, the hellhound's eyes look in four different directions. The dual eruptions in your love-canal and rectum feel amazing as they pulse in and out of sync, dumping cum into your body over and over.  The hellhound's contractions ebb away as he finishes, but you're not done yet. You slowly start tilting your hips back and forth, continuing to fiercely fuck the prime member while the other rests nearly motionless in your ass. Soon the hellhound whines from the unwanted stimulation of his now sensitive pricks, but he is too defeated to put up much of a struggle.\n\n");

				outputText("Slowly but steadily you bring yourself to the verge of orgasm. The hellhound under you squirms and tries to get free, his hind legs flailing through the air behind your back. You keep riding his magnificent member, grinding it up and down in your moist cave. Finally, you feel the familiar rippling of your vaginal walls, milking his cock and intensifying your pleasant sensations. Clamping down on his members, you keep moving your hips in a circling motion, working your clit, vagina and butt in equal measure. The sensations eventually grant you an intense orgasm while the hellhound's still-distended members apply the perfect pressure to all of your sensitive spots and prolong your bliss.");
				//--- IF PC HAS PENIS ---
				if (player.cockTotal() > 0) {
					// --- IF ONE PENIS ---
					if (player.cockTotal() == 1) outputText("Your [cock] twitches as it ejects its sticky load.");
					//--- ELSE ---
					else outputText("Your [cocks] twitch as they eject their sticky loads.");
					outputText("  Keeping up your motions, you scatter your cum across the hellhound's body and the ground nearby.");
					//--- IF MESSY ORGASM PERK OR CUM MULTIPILER > 5 ---
					if (player.cumQ() > 700) outputText("  As your orgasm drags on, you practically drench the hellhound in your seed. An especially large load lands on his snouts, and the heads greedily start licking your juice with their canine toungues. Your mate's black fur is soaked with your cum, and he'll definitely be busy licking himself clean for some time.");
				}

				outputText("\n\n");

				outputText("Busy with your own orgasm, you barely notice the twitching of the dual pricks buried inside you.  The hellhound launches into another orgasm or two, his dongs aching for peace and wanting to go soft, but forced to orgasm by your body.  You clench your muscles, locking the blood in the throbbing members, trying to preserve the sensations forever.\n\n");

				outputText("Finally having finished, you relax your anal sphincter and allow his member to leave your anus. His members rise from the feel of the incredible amount of cum his quadruple balls pumped into your holes squirting back out to wash over them. The hellhound curls up, spent, his tail covering his privates. His rods look a little red from the intense fuck, and you're sure that in spite of his fiery nature he is experiencing a little more than a burning sensation.");
				//--> increases corruption, usual post coital procedure
				player.sexReward("cum","Vaginal");
				//[if not corrupt]
				if (player.cor < 40 + player.corruptionTolerance) dynStats("tou", -2, "cor", 1);
				//[if corrupt]
				else dynStats("cor", 1.5);
				//Preggers chance!
				if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
				else player.knockUp(PregnancyStore.PREGNANCY_HELL_HOUND, PregnancyStore.INCUBATION_HELL_HOUND, 101);
			}
			cleanupAfterCombat();
		}

		public function takeBothIn():void
		{
			clearOutput();
			outputText("You and your twin lick your lips in anticipation as you grab the hellhound with your vines lifting it up to expose that wonderful crotch of his.\n\n" +
					"\"<i>Now that’s what I’m talking about! Look at this delicious set! Every male on Mareth should have at least a pair of these!</i>\"\n\n" +
					"\"<i>Ohhh yes indeed! And the best thing about it, is that we will both get him to fuck us at the same time! No waiting turns on this one. " +
					"It’s like his stamens were made for us! Now boy, be a good doggy, and we will make you feel veeeery good.</i>\"\n\n" +
					"The hellhound, of course, is not in any position to protest against that, not that any of you would allow him to if he could. " +
					"You reel the puppy in all the way to your shared pitcher and drop him in, dipping him down to the crotch in your nectar. " +
					"You giggle as you wrap one of the hellhound’s peckers between your nectar soaked breasts and start licking the tip, your twin sister doing the same. " +
					"Your attention and overpowering scent has an immediate effect on him causing both of his dongs to get almost painfully hard. " +
					"The hellhound winces as salty drops of precum start to flow out of his twin dicks.\n\n" +
					"\"<i>Hmmmm... now that’s a good dog.</i>\"\n\n" +
					"\"<i>That’s going to create some delicious nectar here sis. I want him inside already.</i>\"\n\n" +
					"The hellhound pants in pleasure, his drool mixing with your nectar, as you both insert a cock in, mewling in delight as his twin knots lock you both in place. " +
					"You kiss your sister as you both toy with your side of the dog’s twin tool, your tongues dancing as you mash your nectar dripping teats against hers. " +
					"The hellhound is simply enjoying himself, both front paws groping your asses as you bring his peckers to the seventh layer of heaven.\n\n" +
					"You and your sister both scream in orgasm as all four of the hellhound’s eyes crossed, howling in pleasure, a large bulge moving up his twin dicks as they explode into your pussies, creampieing them. " +
					"You both sigh in relief as his knots shrink back allowing you to slide off his dick, your pussies leaking some cum out into the bath, which will eventually melt deliciously in your nectar.\n\n" +
					"Utterly satisfied, you grab the doggy and pull him out of your pitcher. " +
					"He's still trying to recover from the double orgasm you gave him, but truthfully his enjoyment is the last of your concern. " +
					"You and your sister are still patting your bellies with content smiles as you head back to camp.");
			//--> increases corruption, usual post coital procedure
			player.sexReward("cum","Vaginal");
			//[if not corrupt]
			if (player.cor < 40) dynStats("tou", -2, "cor", 1);
			//[if corrupt]
			else dynStats("cor", 1.5);
			//Preggers chance!
			if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
			else player.knockUp(PregnancyStore.PREGNANCY_ALRAUNE, PregnancyStore.INCUBATION_ALRAUNE, 101);
			cleanupAfterCombat();
		}

		public function rapeCerberusStyle():void
		{
			clearOutput();
			outputText("You growl at the pitiful mess that the hellhound has become, curling into a ball, quivering at your mighty feet. Hellhound is hardly a fitting name for this thing, perhaps you should simply start calling it your pup. How did such a pathetic thing think he'd come out on top?[pg]");
			outputText("Your twin erections drip your burning precum in anticipation on the ground beneath you, causing the poor pup to crawl away in fear as it dribbles on his snout, but there's no escaping from you now.  Before it crawls away, you mount your new plaything, completely dwarfing the pup beneath your massive frame as your grab hold of his waist.[pg]");
			outputText("You waste no time aligning your [cock] into his tight hold, panting as your tapered tips grind together within his warm passage.[pg]");
			outputText("He whines in discomfort, but his whimpering only serves to motivate you. His ass is your property now, and you're going to make sure he'll never forget it.You unceremoniously continue plowing into the little bitch, relishing in the feeling of complete domination over him as your canine erections pulsate in anticipation.Your heavy balls slap against his underside with each thrust as a burning pressure quickly begins building within your loins.[pg]");
			outputText("You growl loudly as you hilt your erections as deep into him as you can, causing him to give a quick whimper in protest as you finally hit your climax. You practically erupt like a volcano, shooting jet after jet of cum into his abused hole. As your erections slowly deflate, you begin to pull out, satisfied having marked your territory. Your boiling cum dribbles from the head of your length and out of the pup's gaping hole. He'll serve as a reminder to everyone who's the top dog around here.[pg]");
			if(player.hasMutation(IMutationsLib.AlphaHowlIM) && player.hasMutation(IMutationsLib.HellhoundFireBallsIM)) {
				var ptier:Number = player.perkv1(IMutationsLib.HellhoundFireBallsIM);
				if (ptier > 1 && (LunaFollower.HellhoundPackMember < (ptier > 3 ? (Math.floor(2.5*ptier)) : ptier))) {
					outputText("With his ass thoroughly bred the hellhound got two choices right now, either to yield to your overwhelming supremacy and maleness or go back to his old pack in shame. The hellhound hesitates for a moment before ");
					if (rand(2) == 0) {
						outputText("following you back to your camp, betraying his old pack to join yours as your subservient new member. Well, you didn't expect him to be a subby bitch but so long as he's willing to take you in once in a while you don't mind keeping him around.");
						LunaFollower.HellhoundPackMember++;
					} else outputText("running off in shame back to his old pack. The poor guy is going to be chastised by his alpha, you would pity him if not for the fact that you don't care in the first place, he will inevitably meet you again and the next time you will make sure to fuck subserviance into his subby ass properly.");
				}
			}
			outputText("You head out to camp snarling in satisfaction.[pg]");
			if(player.isRaceCached(Races.CERBERUS) && player.hasMutation(IMutationsLib.AlphaHowlIM) && player.hasMutation(IMutationsLib.HellhoundFireBallsIM)){
				outputText(" Your hellhound pack is currently "+LunaFollower.HellhoundPackMember+" member strong.");
			}
			player.sexReward();
			cleanupAfterCombat();
		}

		private function killHellhound():void {
			clearOutput();
			flags[kFLAGS.HELLHOUNDS_KILLED]++;
			outputText("You finish off the hellhound and claim his two tongues as your prize. ");
			if (player.cor < 25) dynStats("cor", -0.5);
			if (player.enemiesKillCount() >= 10 && !player.hasPerk(PerkLib.KillingIntent)) {
				outputText("Kill upon kill, corpse after corpse... Ashes... to ashes... Your fingers itch, your blood boils, there's still more to kill, more fiends to slay. The fire burning inside is but another weapon of murder. <b>(You have gained the Killing Intent perk!)</b> ");
				player.createPerk(PerkLib.KillingIntent, 0, 0, 0, 0);
			}
			inventory.takeItem(useables.THHTONG, cleanupAfterCombat);
		}
	}
}
