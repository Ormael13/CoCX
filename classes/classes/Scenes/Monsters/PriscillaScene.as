package classes.Scenes.Monsters
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

public class PriscillaScene extends BaseContent
	{
		public function goblinElderEncounter():void {
			var canFuck:Boolean = player.cor < 60 + player.corruptionTolerance;

			clearOutput();
			spriteSelect(SpriteDb.s_priscilla);
			//First Time Intro
			if (flags[kFLAGS.TIMES_ENCOUNTERED_PRISCILLA] == 0) {
				outputText("As you take a stroll, you catch the glimpse of an imposing goblin.  Unlike most of the goblins you've seen so far, she's clad in primitive bone armor, wielding a metal sword lined with lethicite crystal, and holding a metal greatshield.  Her hair is crimson and black.  She walks over to you in a peaceful manner.\n\n");
				if (player.hasCock()) {
					if (canFuck) outputText("\"<i>Hey, my name is Priscilla. Would you like to fuck me?  I'll promise to teach my newborn goblins the values of pre-corruption lifestyle.</i>\"");
					else outputText("\"<i>Please don't fuck me!  You're too corrupt!</i>\"");
				}
				else outputText("\"<i>You don't have anything to knock me up but I'm always up for the challenge.</i>\"");
			} else if (player.hasVagina() && !player.hasCock() && (flags[kFLAGS.PRISCILLA_AFFECTION] == 1 || flags[kFLAGS.PRISCILLA_AFFECTION] == 2)) {
				startffaction();
				return;
			} else {
				outputText("As you walk, the familiar sight of a powerful goblin catches your eye.  You have encountered " + (flags[kFLAGS.PRISCILLA_TALK_COUNTER] > 0 ?  "Priscilla" : "the goblin elder") + " again!\n\n");
				if (player.hasCock()) {
					if (canFuck) outputText("\"<i>Hello again" + (player.hasCock() ?  ", "+player.mf("stud","slut")+".  Ready to knock me up with your cum?  Or are you here to duel?" : ",") + "</i>\"");
					else outputText("\"<i>Please don't fuck me!  You're too corrupt!</i>\"");
				}
				else outputText("\"<i>You don't have anything to knock me up but I'm always up for the challenge,</i>\".");
			}
			flags[kFLAGS.TIMES_ENCOUNTERED_PRISCILLA]++;
			//codex
			camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_GOBLINS);
			//menu
			monster = new Priscilla();
			menu();
			addButton(0, "Fight", startFight);
			if (flags[kFLAGS.PRISCILLA_TALK_COUNTER] < 2) addButton(1, "Talk", talkToGoblinElder);
			if (player.hasVagina() && player.lust >= 33 && canFuck) {
				addButton(2, "Sex Anyway", startffaction);
				if (flags[kFLAGS.PRISCILLA_AFFECTION] >= 3 || player.cockThatFits(monster.vaginalCapacity()) >= 0) addButton(2, "Sex", startforeplay);
			}
			if (player.hasCock() && player.lust >= 33 && canFuck) {
				if (player.cockThatFits(monster.vaginalCapacity()) >= 0) addButton(2, "Sex", startforeplay);
				else outputText("\n\n<b>There is no way you can fit your cock into her cunt!</b>");
			}
			addButton(4, "Leave", explorer.done);
		}

		private function startFight():void {
			startCombat(new Priscilla());
			playerMenu();
		}

		//[WIN RAEPZ]
		public function priscillaDefeated():void {
			if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
				if (flags[kFLAGS.PRISCILLA_DEFEATS_COUNTER] >= 1) flags[kFLAGS.PRISCILLA_DEFEATS_COUNTER]++;
				else flags[kFLAGS.PRISCILLA_DEFEATS_COUNTER] = 1;
				if (flags[kFLAGS.PRISCILLA_LVL_UP] < 11 && flags[kFLAGS.PRISCILLA_DEFEATS_COUNTER] > flags[kFLAGS.PRISCILLA_LVL_UP]) {
					flags[kFLAGS.PRISCILLA_DEFEATS_COUNTER] = 0;
					++flags[kFLAGS.PRISCILLA_LVL_UP];
				}
			}
			SceneLib.goblinScene.gobboRapeIntro();
		}

		private function talkToGoblinElder():void {
			clearOutput();
			outputText("You ask the goblin if she wouldn't mind talking.  ");
			if (flags[kFLAGS.PRISCILLA_TALK_COUNTER] == 0) {
				outputText("What is she anyway?  How is she unusual from the other goblins?  Of all the goblins you've seen, she isn't as sexually inclined.");
				outputText("\n\n\"<i>Of course.  I've travelled a lot and I have slain a lot of imps, hellhounds, and minotaurs.  The demons must pay for the damage caused to my race and I worked hard to keep my mind off constant sexual desires.  I gave birth to hundreds of goblins but I keep my boobs normal with Reducto.  I still have unfinished business,</i>\" she says.");
				outputText("\n\nWhat are her current goals then?");
				outputText("\n\n\"<i>I'm seeking out someone who's not corrupt so I can give birth to less-tainted goblin.  My tribe is isolated from the corrupted Goblin societies and I tried to brew a purifying potion but to no avail" + (flags[kFLAGS.LETHICE_DEFEATED] > 0 ?  ".  I did hear the news that you have defeated Lethice.  You're my saviour and I'll be forever grateful at you for causing a major blow against the demons" : "") + ",</i>\" the goblin says.");
			}
			else if (flags[kFLAGS.PRISCILLA_TALK_COUNTER] == 1) {
				outputText("Where did she originally come from?  How did she escape corruption?");
				outputText("\n\n\"<i>I came from the old goblin city.  Before the demons came, we were the technological leaders.  When the demons came, they offer us a treaty guaranteeing the peace and safety.  But they lied and they corrupted the water supply.  I knew there was something wrong with the water supply so I escaped and hid in the Deepwoods, where no demons would find me.</i>\"");
			}
			outputText("\n\nYou thank the goblin for telling you and wave her off.");
			flags[kFLAGS.PRISCILLA_TALK_COUNTER]++;
			endEncounter();
		}

		private function startffaction():void {
			clearOutput();
			if (flags[kFLAGS.PRISCILLA_AFFECTION] == 0) {
				outputText("You smile seductively and ask aloud if Priscilla wouldn’t mind keeping you company even without a dick.  Priscilla’s ear twitches at this, but to your surprise she frowns, and waits a moment before responding.\n\n");
				outputText("\"<i>I’m sure you don’t get told ‘no’ often, but I don’t fuck just for the fun of it.</i>\"  Priscilla started.  \"<i>Everything I do is to restore my people, so if you don’t have a penis, you’re just wasting my time.</i>\"\n\n");
				outputText("You start to protest, but Priscilla had already started walking away. You try to think about what she said, but you find yourself glued the sway of her thighs in that tight spider-silk loincloth. You’re parched, and not from a lack of water.  But unless you have a dick, she’s not interested.  Maybe you should just forget about her?");
				menu();
				addButton(0, "Yes", explorer.done);
				addButton(1, "No", notForget);
			}
			else if (flags[kFLAGS.PRISCILLA_AFFECTION] == 1) {
				outputText("As you walk, exploring for new places and potential opponents, you see Priscilla, and she doesn’t look too good.  Her sword is embedded into the skull of a recently deceased imp overlord, and her bone armor is strewn everywhere in pieces.  As for Priscilla herself, she’s not beaten up too bad, but she’s leaning up against a stump, spasming violently and moaning lewdly as she squeezes her breasts.  Looking back towards the imp, you see in his hands were a vial dripping a pink liquid, and a succubi whip.  It’s obvious now what the imp tried to do, and Priscilla is suffering from that attack.  What do you do?  ");
				menu();
				addButton(0, "Check", checkonher);
				addButton(1, "Leave", leaveher);
			}
			else if (flags[kFLAGS.PRISCILLA_AFFECTION] == 2) {
				outputText("\"<i>Hey you...</i>\"  Priscilla says awkwardly.  You smile and walk towards her.  She looks at the ground, a bit embarrassed.  \"<i>The other day you saw me at a weak moment, and I wasn’t myself.  I drove you away when you tried to help me, and I’m...s...s...I was a fucking bitch.</i>\" Priscilla finally says.  You mention it’s no problem, and that you’re happy to help out a friend.  Hearing that word brings Priscilla to look into your eyes again.\n\n");
				outputText("\"<i>Friend?  I don’t think I’ve had a friend since the demons attacked.</i>\"  Priscilla says.  \"<i>And...me and my girlfriends, we used to get into all kinds of... fun.  Priscilla says, the way she says it, with the slight grin on her face and blush on her cheeks, give you an idea of what kind of fun she and her goblin girls were into.  And I do owe you for that time. So...friend, ready for some fun?</i>\" You eagerly nod.  ");
				doNext(scissorscene);
			}
		}

		private function notForget():void {
			++flags[kFLAGS.PRISCILLA_AFFECTION];
			explorer.done();
		}

		private function checkonher():void {
			var canHelp:Boolean = player.hasItem(consumables.PURHONY, 1) || player.hasItem(consumables.PPHILTR, 1);
			clearOutput();
			outputText("You walk out of where you were hidden. Priscilla didn’t even notice you until you cleared your throat while in front of her. Before you could ask what you could do to help, Priscilla started an angry verbal assault: \"<i>Damn you you’re worse than vultures! What, now that I’m weak and horny you think you can take advantage of me?  Get out of here dyke!</i>\"  She yells at you with all of her strength as she covers her breasts, and tries to stifle her gasps as even covering her melons made her almost cum.\n\n");
			outputText("How rude. You only had the best intentions for the goblin elder but screw that now. You could just leave her to stew in her wet sticky bitterness.  A dark thought then enters your head-she is in no shape to fight back, you could teach her a lesson in respecting others. Or better yet, its obvious she has you on her mind, which is why she on the defensive when she’s her most horny. Why not give her a show? ");
			outputText("But then again she looks awful, and is only trying to protect herself the only way she knows how... ");
			if (canHelp) outputText(" and you just happen to have the right item.  Should you give it to her?");
			menu();
			addButtonIfTrue(0, "Help", helpher, "Req. a vial of Pure Honey or Purity Philter.", canHelp);
			addButton(1, "Seduce", seduceher);
			addButton(2, "Rape", SceneLib.goblinScene.gobboGetsRapedFem);
			addButton(4, "Leave", leaveher2);
		}

		private function helpher():void {
			var item:ItemType = player.hasItem(consumables.PPHILTR, 1) ? consumables.PPHILTR : consumables.PURHONY;
			player.consumeItem(item);
			clearOutput();
			flags[kFLAGS.PRISCILLA_AFFECTION]++;
			outputText("You take out your vial, and hold it out in front of Priscilla, she glances at it, then at you.\n\n");
			outputText("\"<i>You think I need your charity!</i>\"  Priscilla whispers, beads of sweat forming on her forehead.  \"<i>Who the hell do you think I am, you bitch?!</i>\"  It’s obvious she won’t listen to reason, but you’re not going to force the issue-you place the "+item.longName+" on the ground slowly, back up a meter, and walk away towards camp.  Before you left the area completely you look behind you.  Priscilla as well as the "+item.longName+" is gone.  ");
			endEncounter();
		}

		private function leaveher():void {
			clearOutput();
			outputText("Hey, she’s a big girl, this can’t be the first time she got drugged, she’ll be fine.  Pushing Priscilla out of your mind, you head back to camp ");
			endEncounter();
		}

		private function leaveher2():void {
			clearOutput();
			outputText("Without even a backwards glance, you step away from Priscilla and head back to camp, ignoring the choking sobs as you left the clearing.  ");
			endEncounter();
		}

		//SH is too lazy to add this to Recall menu. Do it yourself if you must.
		private function seduceher():void {
			clearOutput();
			outputText("\"<i>No, I’m not going anywhere.</i>\" You say with a smile, as you strip out of your " + player.armorName + ", as slowly and shamelessly as possible, starting off with the top, jiggling your " + player.breastDescript(0) + " from side to side.  Priscilla pretended she didn’t care, but her eyes reflected the lust as she honed in on your " + player.nippleDescript(0) + " and started to lap up some spittle from her wide open mouth.\n\n");
			outputText("\"<i>S-stop!</i>\"  Priscilla moans, trying to reach for her weapon, or a means to escape, but you just continued.  Next was your bottoms.  As you discarded that portion of your " + player.armorName + " you squat right in front of Priscilla, giving her a full view of your pink, bare, pussy.  As you raised a hand towards Priscilla, she gasped as she unconsciously started to squeeze her breasts again.  No!  Don’t touch me, or Marae help me- but her words died as she saw you take the index finger of that hand, and thrust it along with your middle finger, into your happy hole.  You moan sensually, and slowly thrust your fingers farther and deeper, a wave of arousal wafts the air.  Priscilla is fidgeting now, the hem of her loincloth she’s ready to throw away.  You decide now is the time for the coup de grâce:\n\n");
			outputText("You stop playing with yourself and you turn around, showing your " + player.buttDescript() + " to Priscilla, whose breath quickens, and a bright green flush enters her cheeks, and she breaks out in a cold sweat.  You lift your " + player.buttDescript() + " into the air, and start shaking it up down and around in front of Priscilla, the smell of your arousal wafting through thunderous intense clapping is all she notices.  As you start bouncing faster, you look behind yourself, enjoying the sight of Priscilla’s walls finally breaking, as she tears off her spider-silk loincloth and throws it aside, and plunges two of her fingers right into her slop hungry vagina, exalting a crushing wail of her defeat, but she no longer cares, as with an inhuman pace, she attacks her clit and vagina, rubbing them for dear life.  You bounce faster and faster, wiggling your perfect " + player.buttDescript() + " for Priscilla, who has finally reached the throes of passion.\n\n");
			outputText("With a cry, Priscilla arches her back as she cums, a tangy sour flow of juices squirts out of her pussy, all over your back and ass.  You blush at the thought of another woman cumming on you, and realize your needs haven’t been met yet.  You turn around expecting Priscilla to fly into your arms, but all you see is that she has passed out.  You remember that Priscilla was drugged, and now that she came, she’s not going to be receptive.  Accepting your defeat this time, you walk back to camp, but not before placing Priscilla’s sword within reach of her.\n\n");
			endEncounter();
		}

		private function scissorscene():void {
			clearOutput();
			flags[kFLAGS.PRISCILLA_AFFECTION]++;
			outputText("Eagerly, Priscilla went towards her supplies, rummages through her bag, and throws you a vial.  Inside was a purple highly viscous liquid.  \"<i>Rub it on your pussy.</i>\"  Priscilla said, walking back towards you.  The liquid was cold told to the touch, especially when you massaged it on your vagina.  You pass the vial back to Pricilla, who sat down and applied to liquid to herself.  As you watched Priscila, you felt a heat slowly coming from your nether region.  You bit your lip as the heat started to burn, and could literally feel all your blood moving towards your pussy, until it’s engorged and puffy-It didn’t hurt, but you definitely wished for the burning to extinguish.\n\n");
			outputText("\"<i>Alright, I’m ready.</i>\"  Priscilla moans, watching you with a smile.  \"<i>You feel that heat?  Don’t worry baby, that’s supposed to happen.  Now come here, there’s the only way to make it stop.</i>\"  Priscilla opens her legs and waits on you.  You quickly move on to Priscilla, putting one of your legs under Priscilla’s and the other above Priscilla’s legs, and the two of you lean back, to now that you are both pussy to pussy.  Priscilla reaches a hand towards you - you grab hers, and when you do so, Priscilla pulls you towards her so that with a clap, your swollen pussies smack into each other.\n\n");
			outputText("It felt like electricity shooting through you.  You gasp in shock, in contrast to Priscilla’s sweet moans, and the two of you slam each other again and again.  First it was slow, but you and Priscilla go faster and faster, until All is heard is pussy clapping and feminine squeals of joys as you slide and gyrate between each other.  It was so hot.  The burning, the heat was intense.  You mash against each other, shuddering as you and Priscilla bump and clap, your asses and tittiess jiggling with sweat.  ");
			if (player.hasCock()) outputText("Your " + player.cockDescript(0) + " flops noisily on you and Priscilla, smearing and shooting pre everywhere.  ");
			outputText("In desperation Priscilla takes her other hand and grabs your outstretched hand, and jerks you hard enough that you are now looking at each other face to face, panting in each other's face, inching closer and closer.  Priscilla breaks first, thrusting her tongue into your mouth, at which you happily accommodate.  You suck on her tongue, the sour smell of her pussy and sour taste of her mouth was everyone in your senses.  Your pussies have long stop bumping into each other, and it seemed as you two were conjoined by the crotch, as all that was happening was grinding.\n\n");
			outputText("\"<i>I'm going to cum, fucking bitch I'm gonna cum!</i>\"  Priscilla grunts, as she breaks the kiss and pulls into your neck, kissing it.  Unable to stop the heat, you grab Priscilla body from her ass and push her into your twat.  She bites into your neck as she starts thrusting into you as if she had a cock and was getting ready to give you a sloppy finish.  You fall back, gasping and grunting, with Priscilla, now slave to lust, on top of you, bashing your pussy like crazy, her face twisting into an uncontrollable whore.  You can barely move as you took the assault as you screamed, your pussy contracting and shaking as you squirted all over Priscilla's sopping pussy, who herself can no longer hold back.  Grabbing your breasts to prop herself");
			if (player.hasCock()) outputText("and your " + player.cockDescript(0) + " jerking you as hard as she could");
			outputText(", she thrust into you one last time, before with a shriek her fluids gushed all over your pussy and onto the ground.  You moan under Priscilla, the burning finally put out by her fire-fighting.  Priscilla holds the position arching above you shaking slowly for what felt like an eternity before looking at you with a smile on your face.\n\n");
			outputText("\"<i>Almost as good as cock, right?</i>\"  Priscilla said.  You're only response was pulling Priscilla into a passionate kiss, before the two of you cuddled on the ground, enjoying the closeness and warmth between you two.  After almost an hour, the two of you got up and got dressed and left, but not before kissing each other fully one last time, and promising to meet up again real soon.\n\n");
			player.sexReward("vaginalFluids", "Vaginal");
			endEncounter();
		}

		private function startforeplay():void {
			clearOutput();
			outputText("How would you like to start this?\n\n");
			menu();
			addButtonIfTrue(0, "Dick (Sub)", dickF_sub, "Req. a fitting dick.", player.cockThatFits(monster.vaginalCapacity()) >= 0, "Let Priscilla take the lead.");
			if (flags[kFLAGS.PRISCILLA_FOREPLAY_COUNTER] > 0 || flags[kFLAGS.PRISCILLA_AFFECTION] >= 3) {
				addButtonIfTrue(1, "Dick (Dom)", dickF_dom, "Req. a fitting dick.", player.cockThatFits(monster.vaginalCapacity()) >= 0, "Take the lead yourself.");
				if (player.hasVagina()) {
					if (flags[kFLAGS.PRISCILLA_AFFECTION] >= 3) {
						addButtonIfTrue(2, "Vagina", vagF, "Req. a vagina.", player.hasVagina(), "Have some girl-on-girl fun.");
						addButtonIfTrue(3, "HermWay", hermF, "Req. to be a herm.", player.isHerm(), "Please both your dick and vagina!");
					} else if (player.hasVagina()) addButton(2, "Lesbi?", hermF_noFP).hint("Suggest having fun without using your dick.");
				}
			}
			++flags[kFLAGS.PRISCILLA_FOREPLAY_COUNTER];

			//====================================
			function hermF_noFP():void {
				outputText("\"<i>I thought we understood each other.</i>\" Priscilla pouts.  \"<i>I need daughters, I need to restore Goblins to their rightful place!  Pussy eating doesn’t help me one bit!</i>\" She starts to walk away, but you remind her that dicks like yours are scarce these days, which causes her to stop in her tracks.  Grabbing her by the waist and turning her around you tell her that if she does a good job lezzing out, you’ll be forever grateful.  She sighs at this, but a sly grin grows on her face as you start detailing a vision of you paying your gratefulness by breeding her another 100 daughters, and she’s game.");
				flags[kFLAGS.PRISCILLA_AFFECTION] = 3; //She likes you now! Skip girl route.
				sexMenu_vag();
			}
			function hermF():void {
				outputText("You tell Priscilla you’re here to lez out.  A big, wide grin grows on her face as she starts to shed out of her spider silk loincloth and bone armor, watching you intently as you strip off your " + player.armorName + ".  Fully nude, Priscilla’s tiny hands dart towards her breasts, kneading them slowly as you walk towards her, fondling your " + player.cockDescript(0) + " at the sight of her exotic body.  You lick your lips at the sight of the goblin, and ");
				if (player.tallness >= 60) outputText("kneel down and scoop Priscilla into your arms for a kiss.  ");
				else outputText("pull Priscilla into a kiss.  ");
				outputText("She thrusts her sour tasting tongue into your mouth as soon as your lips touched, and one of her hands reach towards your breasts, and the other, to your pussy.  You moan as her fingers plunge into you making a sloppy sound.  You break the kiss and start kissing on Priscilla’s neck slowly, and while she paws at your tits, and finger-fuck your pussy, you grip her side with one of your hands, and with your other hand you reach towards her firm but jiggable butt, and you take your middle finger and prod her asshole, before going inside.  Her hole was springy and stretched to accommodate you, and you felt your knees shake as Priscilla cried out, sounding almost orgasmic, as wave a pleasure came over her.  her hands grabbing your " + player.cockDescript(0) + " and started rubbing you as rough as you're treating her hole.\n\n");
				outputText("\"<i>Yes, finger my ass!</i>\"  Priscilla squeals as she simutanously jerks and fingerfuck you.  You find the dual attack too much and you start shooting out your spunk, spraying Priscilla on her thighs, her shaved pussy mound, her stomach, and breasts.  You ignored Priscilla's look of disappointment however, you told her cock wasn’t on the menu today after all.\n\n");
				outputText("\"<i>Yeah...we're definitely focusing on vag today.</i>\"  Priscilla muttered, as she brought a bit of your spooge to her lips, a smile appears as she moans at the taste.  ");
				if (player.cumQ() >= 750) outputText("\"<i>Think you can help me out "+player.mf("stud","slut")+"?</i>\"  Getting on your knees, you start lapping up your cum, trying not to swallow too much, cleaning Priscilla's body from wherever she was stained.  The taste of the minotaur and imp blood she stains herself with was sweet, tangy, yet bitter, in contrast with her oily, sour skin.  She moaned as she dined on your seed trapped in her breasts, as your tongue slurped and glided up and down her body, fighting every urge to locate all of your work between her legs.  When you were finished, you pulled Priscilla into another kiss, depositing the remaining amounts of your sticky cream that you didn't swallow as you cleaned Priscilla.  \"<i>Thank you.</i>\"  Priscilla said, licking her lips and savoring the taste.\n\n");
				outputText("Placing her hands on your now softened " + player.cockDescript(0) + " as she looked up at you.  \"<i>Now let’s get down to business.</i>\"  Her hands move from your " + player.cockDescript(0) + " to your sides.  \"<i>I’m following your lead on this one.  How do you want me?</i>\"  ");
				sexMenu_vag();
			}
			function dickF_sub():void {
				outputText("You tell Priscilla you’re here to fuck.  A big, wide grin grows on her face as she starts to shed out of her spider silk loincloth and bone armor, watching you intently as you strip off your " + player.armorName + ".  Fully nude, Priscilla’s tiny hands dart towards her breasts, kneading them slowly as you walk towards her, fondling your " + player.cockDescript(0) + " at the sight of her exotic body.  Her ears perk up in excitement as she sees your " + player.cockDescript(0) + ", now completely hardened, reach its fully erect size of " + num2Text(Math.round(player.cocks[0].cockLength)) + ".  Priscilla starts to seductively sway her body towards you, her ample hips and round ass cheeks jiggling slightly, as her fingers thread from her breasts to her soft thighs.\n\n");
				if (player.tallness >= 60) outputText("You kneel down and scoop Priscilla into your arms for a kiss");
				else outputText("You pull Priscilla into a kiss");
				outputText(", halfway expecting her to instantly swoon, but as soon as your lips touch, you find her foreign tongue swimming in your mouth; A sour taste overcomes your senses.  You suppress a moan as her tongue glides along your own, her hands grabbing your " + player.cockDescript(0) + " firmly as one of your hands grabs a firm breast, and the other, reaching towards the small of Priscilla’s back before gripping the cheeks of her soft ass.  Feeling your hands invade her skin, Priscilla breaks the kiss and leans in towards your neck, placing butterfly kisses as she traced your collarbone with her lips, fervently jerking your " + player.cockDescript(0) + " upon her shaved yellow green mound, daring you to soak her blood-stained body with your fresh seed.  You squeeze Priscilla’s peach bottom even harder and attack her nipple, pinching and pulling it hard enough to elicit a sharp gasp from the goblin.  With a chuckle, Priscilla pushes away from you, breaking your hold on her thighs, and before you could even react, she shoves you onto ground quite easily.  \n\n");
				outputText("\"<i>Naughty boy...</i>\"  Priscilla purrs, placing her hands on your knees with an ardent gleam in her eye, and a slight drool slithering away from her bottom lip.  \"<i>No more foreplay – it’s fuck time.</i>\"  She puts up a tough front as if she’s dominating you, but even now she awaits on you to take charge – how do you want her?");
				sexMenu_dick();
			}
			function dickF_dom():void {
				outputText("You tell Priscilla there’s a thick, creamy load with her name on it, and her spider silk loincloth had already been discarded onto the ground.  She didn’t even take off the rest of her armor as she sat down, spread her legs, and started fingering her pussy and squeezing her breasts.  As you walked towards her fully free from your " + player.armorName + ", you stroke your " + player.cockDescript(0) + " to her, finding amusement as Priscilla starts rubbing her wet slit at breakneck speed as she watches your " + player.cockDescript(0) + " harden, her gasps quickening and her skin blushing a bright shade of green as a bit of pre-cum oozes out of your rod.  By the time you’re fully erect she howls loudly as she arches her back, squirting her juices all over the ground.  The sour fragrance is in the air again.\n\n");
				outputText("You pick Priscilla up gently and doesn’t bother lifting her off the ground before you pull her in for a forceful kiss, shoving your tongue into her mouth, and it’s almost a test of wills once again.  As before, the intoxicating, seemingly drugged taste of her tongue fights and swims with yours; you literally tear Priscilla’s bone armor off of her as you grab a breast and her ass, gripping and pinching to stay in control of this \"<i>battle.</i>\" Priscilla’s hands roam towards your own nipples in response and twists and squeezes them with a level of strength that definitely would leave you bruised.  When you yelp, you release Priscilla, who continues her attack by pushing you to ground, quite easily once again.\n\n");
				outputText("\"<i>Alright, "+player.mf("stud","slut")+", no more games, I have places to go, demons to kill...</i>\"  Priscilla starts, placing her hands on your knees with a fierce stare in her eye, and a ravenous smile on her lips.  \"<i>...Champions to fuck, babies to make.</i>\"  Of course, as a goblin, she has a one-track mind, but you know Priscilla - procreation is necessary, but she likes your seed in other places too - how are you going to give it to her?  ");
				sexMenu_dick();
			}
			function vagF():void {
				if (flags[kFLAGS.PRISCILLA_AFFECTION] < 4) vagF_first();
				else vagF_nice();
			}
			function vagF_first():void {
				flags[kFLAGS.PRISCILLA_AFFECTION] = 4;
				outputText("You tell Priscilla you’re here for some cunt.  She smiles a toothy grin as she starts to shed out of her spidersilk loincloth and bone armor, watching you intently as you stripped off your " + player.armorName + ".  Fully nude, Priscilla’s tiny hands went towards her breasts, kneading them slowly as you walked towards her.  You licked your lips at the sight of the goblin, and ");
				if (player.tallness >= 60) outputText("kneel down and scoop Priscilla into your arms for a kiss.  ");
				else outputText("pull Priscilla into a kiss.  ");
				outputText("She thrusts her sour-tasting tongue into your mouth as soon as your lips touched, and one of her hands reach towards your breasts, and the other, to your pussy.  You moan as her fingers plunge into you making a sloppy sound.  You break the kiss and start kissing on Priscilla’s neck slowly, and while she paws at your tits, and finger-fuckы your pussy, you grip her side with one of your hands, and with your other hand you reach towards her firm but jiggable butt, and you take your middle finger and prod her asshole, before going inside.  Her hole was springy and stretched to accommodate you, and you felt your knees shake as Priscilla cried out, sounding almost orgasmic, as wave a pleasure came over her-then with her cavity muscles, she pushes your finger out with a grunt.\n\n");
				outputText("\"<i>You bitch...</i>\"  Priscilla moans, and the two of you french kiss once again.  The sour taste of her tongue and lips drown you, and you find yourself so dazed you didn’t realize that the goblin has stopped playing with your pussy, until you find Priscilla’s stained fingers in front of your lips.  You suckle dreamily, enjoying your taste, while Priscilla goes towards your " + player.breastDescript(0) + " biting into them gently, and kissing the " + player.nippleDescript(0) + ".  You gasp out loud as Priscilla starts becoming rougher with your breasts, squeezing and pushing them together, and slurping and biting them as well.  You start to feel your orgasm building.  With a grunt you pull away from Priscilla, gasping out loud at how quickly you almost came.  Priscilla smiles a small smile, and places her hands on her hips.\n\n");
				outputText("\"<i>Alright babe, let’s get down.  How do you want to do it?  We can scissor, that’s one thing I got all 120+ of my daughters addicted to so they won’t roam looking for cock, and there’s probably a tentacle beast we could ambush for a threesome.  What sounds good?</i>\"\n\n");
				outputText("You mention the obvious one: Priscilla’s lips on your nethers, but she only laughs.  \"<i>If you’d like, we can wrestle for dominance.  The loser must do whatever the winner wants: You want me to dine on your gash? That’s the only way to do it.</i>\"  You raise an eyebrow, not remotely surprised at Priscilla intention to keep from eating your tuna, but you are intrigued at the challenge.\n\n");
				outputText("\"<i>So...how do you want to handle this?</i>\"  ");
				sexMenu_vag();
			}
			function vagF_nice():void {
				outputText("You tell Priscilla you’re here for her.  She smiles a toothy grin as she starts to shed out of her spidersilk loincloth and bone armor, watching you intently as you stripped off your " + player.armorName + ".  Fully nude, Priscilla’s tiny hands went towards her breasts, kneading them slowly as you walked towards her.  You licked your lips at the sight of the goblin, and ");
				if (player.tallness >= 60) outputText("kneel down and scoop Priscilla into your arms for a kiss.  ");
				else outputText("pull Priscilla into a kiss.  ");
				outputText("She thrusts her tongue into your mouth as soon as your lips touched, and one of her hands reach towards your breasts, and the other, to your pussy.  You moan as her fingers plunge into you making a sloppy sound.  You break the kiss and start kissing on Priscilla’s neck slowly, and while she paws at your tits, and finger-fuck your pussy, you grip her side with one of your hands, and with your other hand you reach towards her firm but jiggable butt, slapping her as Priscilla cried out, sounding almost orgasmic.\n\n");
				outputText("\"<i>Yes, spank me harder!  I’ve been a naughty girl!</i>\"  Priscilla moans, and the two of you french kiss once again as you continued your swat assault The sour taste of her tongue and lips drown you, and you find yourself so dazed you didn’t realize that the goblin has stopped playing with your pussy, until you find Priscilla’s stained fingers in front of your lips.  You suckle dreamily, enjoying your taste, while Priscilla goes towards your " + player.breastDescript(0) + " biting into them gently, and kissing the " + player.nippleDescript(0) + ".  You gasp out loud as Priscilla starts becoming rougher with yout breasts, squeezing and pushing them together, and slurping and biting them as well.  You start to feel your orgasm building.  Priscilla stops, and pushes you away-your finger jerks out of Priscilla’s booty with a ‘pop’ You sit back up with a smile, so ready to get a taste of this goblin whore.\n\n");
				outputText("\"<i>Alright, "+player.mf("stud","slut")+", you want some of my babymaker right?  Lay on back so I can give you all of it in one go.</i>\"  Sounds tempting, you point out, but you mention maybe you’d like to sit on her face");
				if (!flags[kFLAGS.PRISCILLA_WRESTLE_COUNTER] == 0) outputText(" this time");
				outputText(".  \"<i>Well you know the toll, friend.</i>\"  Priscilla said with a grin.  \"<i>Of course, we can scissor, or we can find some poor sap and make him our bitch?  Whatever you want babe.</i>\"\n\n");
				outputText("How are you going to spend time with Priscilla today?  ");
				sexMenu_vag();
			}
			function sexMenu_dick():void {
				menu();
				addButton(0, "Fuck Pussy", pussyfuck);
				addButton(1, "Fuck Ass", assfuck);
				addButton(2, "Fuck Mouth", mouthfuck);
			}
			function sexMenu_vag():void {
				menu();
				addButton(0, "Scissor", scissorscene);
				addButton(1, "Threesome", unleashthekraken);
				addButton(2, "Wrestle", wrestle);
				addButton(3, "LetHerDom", priscilladom);
			}
		}

		private function unleashthekraken():void {
			clearOutput();
			outputText("Priscilla goes towards her armor and supplies and pulls out what looked like to be a flesh colored penis shaped whistle.  Before you can ask what it was for, she blew on it, and then grabbed you by the hands, and pulled you behind a rock formation.  Not even half a minute went by before a loud roar was heard, and a tentacle beast was in the clearing.\n\n");
			outputText("\"<i>Attack!</i>\"  Priscilla shouted as she rushed the beast.  Momentarily surprised, you jumped out from behind the rock and before the tentacle beast could even react, you and Priscilla deck the tentacle monster as hard as you both could.  It wails, dazed.  Taking your hand, Priscilla guides you to sit on the beast, whose body looked like a giant shrub.  As you sit on it, grimacing as what felt like a twig was poking your inner thigh, Priscilla kicked the tentacle beast, waking it up.  She then moves to you, straddling you on your lap.  The tentacle beast stirs, notices two nubile, and powerful females on top of him, and doesn’t take long to figure out what he’s there for.\n\n");
			outputText("\"<i>There we go~...</i>\"  Priscilla says as a tentacle slides from under you, and pulls through you and Priscilla’s legs.  You shudder as the tentacle slides past your crotch, and moan along with Priscilla as it starts thrusting through your thighs slow and rough.\n\n");
			if (flags[kFLAGS.PRISCILLA_THREESOME_COUNTER] == 0) {
				outputText("You ask if the beast can be trusted as you feel a tentacle going through your hands and arms, binding.  \"<i>If it tries to go overboard with us, it will die. And it knows that.</i>\"  Priscilla laughs, allowing the beast to do the same to her.  ");
			}
			else outputText("You ask Priscilla how she learned to call the beasts as you feel a tentacle going through your hands and arms, binding.  \"<i>Goblin sex hunters.</i>\" Priscilla said as the beast bound her as well.  \"<i>4 of them at a time would gather around, blow a beast whistle, and rape whatever comes.</i>\"  ");
			outputText("You both are becoming bound, but still you two bounce and slide along the tentacle between the two of you, your juices slicking the beast.  You almost feel ready to cum, but the beast stops, and pulls you both into the air suspending you bound between one tentacle.\n\n");
			if (flags[kFLAGS.PRISCILLA_THREESOME_COUNTER] == 0) {
				outputText("\"<i>Get Ready to rock!</i>\"  Priscilla says gleefully.  Before you can ask what she means, two of the beasts tentacle, one for each of you, springs forwards into your wet pussies.  ");
				flags[kFLAGS.PRISCILLA_THREESOME_COUNTER]++;
			}
			else outputText("\"<i>Yes!  Here it comes!</i>\"  Priscilla yells, a look of mania in her eyes.  You close your eyes, anticipating the tentacles, coming for you and for Priscilla.  ");
			outputText("You suppress a scream as the beast pushes itself deep into your caverns as far as it could, kissing your cervix, before jettisoning out of your entrance, and busting into your hole again and again.  ");
			if (player.hasCock()) outputText("your " + player.cockDescript(0) + " instantly goes erect, the pain was excruciating, but exciting.  ");
			outputText("\n\n\"<i>Yes!  Yes!</i>\"  Priscilla screams, going wild as her tentacle was sliding in and out of her, and thrust deeper and rougher in side of her.  You could easily see her stomach distend to take the tentacle, it bulged out through her as if she was bubblegum being blown into.  You try to hang on, and then, you felt a painful swat, on your ass!  You scream out, taking note of the tentacle’s fourth tentacle, swiping at you, then at Priscilla.  Tears started streaming freely from your eyes, but yet, the tentacles plowing you, as well as Priscilla’s ecstatic roar, started to really turn you on, as pain turned to pleasure.  Just when you couldn’t take it anymore, the swatting tentacle stopped spanking you and Priscilla, and thrust itself into your " + player.assholeDescript() + " just when your pussy was fully stuffed.  You couldn’t even cry out in pain, just whimper as your body spasms, ");
			if (player.hasCock()) outputText("your " + player.cockDescript(0) + " starts cumming everywhere, shooting your nut on to the tentacles and all over Priscilla’s face, ");
			outputText("being overtaken by the orgasm.  \"<i>Me next!  Me next!</i>\"  Priscilla cries watching you take the tentacles crazy assault on your holes pushing deep and hard inside you.  Oddly enough it did not cum, after you finally went limp, exhausted, the beasts’ tentacles pulled out of you, and started ravishing Priscilla.  You dimly watched as Priscilla receives both tentacles in her ass, and all three tear her in breakneck speed.\n\n");
			outputText("\"<i>Right there!  Right there!  Yes!  Yes!</i>\"  Priscilla squealed, as she and the tentacle beast fulfilled their innermost desires.  Priscilla, to have her walls broken down and gangbanged with no way to fight back, and the tentacle beast, letting loose all of its frustration on the goblin who summoned it here.  It wasn’t much longer as with a cry, Priscilla screamed an orgasmic pitch, and her pussy juices squirted everywhere, on the tentacles, on the beast, on you... Still struggling to stay awake, the tentacle beast dropped you and Priscilla to the ground gently, and pulled out of the babbling Priscilla, and all four tentacles pointed out at you both before the tentacle beast did finally cum.  What felt like loads and loads of cream coated you and Priscilla both, caking you in sticky love.\n\n");
			outputText("You awake an hour later.  Both Priscilla and the Tentacle Beast are gone.  Still aching from before, you gather your gear and head to camp.  ");
			player.sexReward("cum", "Vaginal");
			endEncounter();
		}

		private function wrestle():void {
			clearOutput();
			if (flags[kFLAGS.PRISCILLA_WRESTLE_COUNTER] == 0)
				outputText("You and Priscilla grab a stick from a tree, and create a circle with a 5-meter diameter.  You chuckle at what you’re doing, without clothes even, but with Priscilla the two of you form the circle and get in, being on the edges. Both of you widen your stance and circle around each other before charging at each other with great speed.");
			else
				outputText("As the two of you form the circle again, You say that this time, Priscilla will be the one eating your juicy cunt.\n\n");
				outputText("\"<i>Sure Babe, sure.</i>\"  Priscilla laughs,.  The two of you get into your set circle and wrestling stances.  The two of you watch each other for any tells, unmoving and silent.  It’s not until you hear a twig snap, probably a squirrel, that the two you charge at each other.");
			doNext(wrestle2);
		}

		private function wrestle2():void {
			clearOutput();
			flags[kFLAGS.PRISCILLA_WRESTLE_COUNTER]++;
			outputText("You and Priscilla arm lock, then after a bit of pushing and pulling between you two, you pull her into a headlock.  She grunts as you squeeze her head between your underarms, at which you pull her over your body, flipping her over.  You let her go and she falls on to the ground with an ‘oomph’ but she rolls away from and charges.  You throw a punch at Priscilla’s, but Priscilla ducks under the strike and chains into a tackle.  You are astounded at Priscilla’s raw power when you barely withstood the blow, but then your astonishment went to horror as Priscilla picked you up by your lower body and suplexed you, falling back.\n\n");
			outputText("You roll off the ground, and when Priscilla jumped at you headbutted her in the face.  As she reeled from the strike you dashed towards Priscilla to take her down to the ground, but as if she had wings on her feet, Priscilla jumped incredible hight and ejected her feet into your face.  You jerked back, face smarting, and slightly dazed.  The goblin waited for you to recover, smugly.  You shake your head in frustration, and the two of you circled each other again.\n\n");
			outputText("You charged Priscilla again, but she was ready for.  She rolled under your attempt to grab her and with her unbelievable strength hooks you in the side.  You bow over pained, allowing Priscilla to grab you by your head in an armlock, and fall back, driving your head into the ground.  Before you could recover from (as your friend back home called it) the Death Drop Takedown, Priscilla jumps on your back like a crazed monkey, tearing out your hair, and clawing on your back, you scream out in pain, and you fall backwards, attempting to get her off you.  She jumps off your back before you land ");
			if (player.str + player.tou + player.spe + player.inte/2 + rand(50) > 230) {
				outputText("<b>but you are faster.</b> Before she lands you grab her by the sides and push her to the ground, head down and ass up.  Priscilla wheeze, and gasp, clearly exhausted.\n\n");
				outputText("\"<i>Grrr...</i>\"  Priscilla grunted, pushing back on you, but you held firm.  Priscilla tried pulling you towards her, and then pushing you away, but you still you were steadfast.  She then tried to break away from you.  With a smile, you shake your head, still holding on to her.  What the hell?  Priscilla shouted, before trying to kick at your ankles, but she couldn’t move.  It was then You set up your final attack.  Grabbing her by the arms, you spin her in the air like a rag doll, before hoisting her into the air, and while she was still processing what was happening, you easily tossed her and sent her flying.  With a scream she flew into the air and hit the ground outside the wrestling circle with a thud.  She bounced once, and tumbled on the ground before stopping, and just laid where she landed looking like a crumpled heap.  After a minute She groaned out in pain, as she slowly got herself up.  You inquired if she was alright.  ");
				outputText("\"<i>Shut up!</i>\"  She said while you laughed.  You walk towards her and waited until she got back her breath.  When she recomposed herself, you pointed at the ground, still smiling.  \"<i>Next time...</i>\"  Priscilla mumbled.  ");
				doNext(dompriscilla);
			} else {
				outputText(".  You try to grab her, <b>but you’re too slow.</b> Priscilla and you arm lock.  You wheeze and gasp, clearly exhausted.\n\n");
				outputText("\"<i>I’m going to be honest babe.</i>\"  Priscilla said.  \"<i>I expected better-far better.</i>\"  You exclaim that both of you are still evenly matched, all you received was a chuckle for your trouble.  It was then Priscilla broke out of your grip and grabbed your arm, and wrenched you to the ground.  With all of your strength you swing your twisted arm wildly, throwing Priscilla who rolled to the ground, but then barrelled back at you, forcing you to the ground with a tackle, and before you could fight back, Priscilla twisted her entire body around your arm, and started twisting back hard, just enough to make you slam your other hand on the ground, crying in pain.  Priscilla relents, leaving you for a moment to breathe.  You pull yourself up to your feet, holding your arm, and gasping large breaths of air, but as the Priscilla steps over to you, hands on her hips with an evil grin on her face, it dawns on you you have no idea what it means to be truly short of breath-not yet.  ");
				doNext(priscilladom);
			}
		}

		private function dompriscilla():void {
			clearOutput();
			outputText("Priscilla lies on the ground, looking slightly more demure than usual.  You blow a kiss to the submissive goblin, before standing over her head.  You slowly guide your self down, squatting your love box in front of Priscilla’s face.  ");
			if (player.hasCock()) outputText("you start pulling on " + player.cockDescript(0) + " slowly, getting it hard.");
			outputText("\n\nPriscilla’s hand start to rub your butt and your sides, pulling you closer towards her face as you spread her thighs.  Priscilla parts your entrance with her tongue, licking them slowly and flicking your clitoris.  You exhale loudly, grabbing your breasts and squeezing them in response to Priscilla’s ministrations.  Your pussy starts to queeze on Priscilla’s face as her tongue swirls inside you.  You spasm at the feeling, and you hold back, trying to stave off an orgasm.\n\n");
			outputText("\"<i>MMMMmmmm!</i>\"  Priscilla moans, dining on your snatch.  You laugh to yourself thinking about for someone who doesn’t like pussy, she sure loves the taste.  You grind and rub on Priscilla’s face.  She licks and sucks, moving faster and faster as she slurps on your juices as you quiver and gyrate.  You smush Priscilla’s face as hard as you could.  Eventually with a scream you paint Priscilla’s with your juices.  Shaking all over her.  You slowly pull up over her.  Priscilla has a wide smile on her face, as if your pussy juices were a new ale she’s drunk on.  ");
			if (player.hasCock()) outputText("kneeling down you slowly push your " + player.cockDescript(0) + " in front of Priscilla’s face, who immediately opens her mouth, ready for meat any time-however with a chuckle, you pull away.  ");
			outputText("You chuckle to yourself as you grab your things, watching as an annoyed Priscilla get hers.  \n\n");
			outputText("\"<i>I’ll be the one to take you down next time.</i>\"  Priscilla said as she walks away with a wave.  \"<i>Just you wait!</i>\"  You head back to camp, thinking of the next time you’ll get to dominate Priscilla again.");
			player.sexReward("saliva", "Vaginal");
			endEncounter();
		}

		private function priscilladom():void {
			clearOutput();
			outputText("Being ordered to lay on the ground, you do as you’re told.  Priscilla smirks as she stands above your head, before she pivots and drops on top of your face.  All you could see is green delectable cheeks, and a drippy wet pussy smush on your nose and then on your lips.  you stick your tongue out at the folds, licking them clean before darting your tongue into her sugar walls, taking her sweaty dirty pussy in full.  Priscilla utters a loud, moan, as she rocks her hips, grinding her clitoris along your lips.  Tastes definitely like pickle: You open your mouth as wide as you could and started to swirl and your tongue in the crevices of Priscilla’s greedy hole.  Gasps and squirms are your rewards as you dine on your meal, you grasp Priscilla along the arches of her sides and thrust upward.  ");
			if (player.hasCock()) outputText("Your " + player.cockDescript(0) + " twirls around, aching for contact, but whether Priscilla didn’t care, or didn’t want you to enjoy this (too late), she didn’t touch you.  ");
			outputText("Yeah, you love being my bottom bitch, don’t you?  Priscilla moans between gasps.  All you could answer with was a \"<i>mmph!</i>\" and dive in further.  Eventually Priscilla started grinding faster and faster on your face, more bestial groans coming out of her, before finally releasing a flow of tangy snatch cream, almost drowning you.  You quickly start gulping, quite unable to shake the goblin off as she’s crossed her legs under you and is holding on.  Priscilla squeals and shakes above you.  Priscilla slowly gets up, allowing you to breathet, but then you grow silent as she looks at you, blushing furiously as she bites her bottom lip with a serious look.  Stick your tongue in here.  Priscilla murmurs as she spreads her cheeks and her butthole open and comes back down, aligning your lips to her back door.  You obediently prod her asshole, before going all the way in, as well as grabbing her breasts.  ");
			if (player.hasCock()) outputText("At this, your cock becomes fully erect, the clean but lewd taste of her asshole exciting you.  ");
			outputText("\"<i>Yes!  Oh Marae, Yes!</i>\"  Priscilla shouts, riding your face as she starts rubbing her clit furiously.  One of your hands grab her sides and while still holding one of her breasts and start pushing your tongue in farther, her caverns squeezed and gripped you , but in response you fought back, going wild in her taint.  As you kneaded her breasts roughly until she finally exploded in a cry, jumping off your tongue and falling onto your stomach, squirting juices on your chest.  You watch, satisfied as her asshole quivers, slowly opening and closing in pleasure.  ");
			outputText("When she recomposes herself, Priscilla gets up, not giving you a second glance.  \"<i>Thanks babe, you’re a doll.</i>\"  Priscilla says happily, going towards her armor and weapons.  \"<i>I do hope we can do this again.</i>\"  Before she puts on her loincloth, you get up quite dissatisfied, inquiring about your needs.  Priscilla just laughs.  \"<i>Sorry, honey, maybe next time.  Claim dominance over me and you get to call the shots.</i>\"  You watch as the goblin elder blows you a kiss and walks away smugly.  You tell yourself you’ll get her next time as you head back to camp ");
			player.sexReward("vaginalFluids", "Lick");
			endEncounter();
		}

		private function pussyfuck():void {
			var x:int = player.cockThatFits(monster.vaginalCapacity());
			clearOutput();
			outputText("Grabbing your shaft, you sit up and point a finger at Priscilla in a beckoning motion, jerking your manhood slowly.  \"<i>Let’s try to put a bun in that oven.</i>\"\n\n");
			outputText("In an instant, Priscilla was all over your " + player.cockDescript(x) + ", kissing your glans with sloppy, wet kisses and gripping your " + player.ballsDescriptLight() + " roughly, causing you to elicit a muffled moan.  She danced her lips down your shaft, going down slowly towards your abused fruits, at which she nuzzles against, caringly, sniffing them as one would an intoxicating flower.  You watch her closely as she goes back up to your " + player.cockDescript(x) + " - your eyes meet once she’s stood up.\n\n");
			outputText("\"<i>I’m so wet for you.  See for yourself.</i>\"  You take one of your free hands and reach towards Priscilla’s crevice, and you shudder at how slick her womanhood is.  You easily plunge your fingers into her hole as Priscilla arches her back, sighing sensually amidst the squelching sounds of her sex.  You take your sloppy fingers and bring them to her gaping mouth, and as you watch her greedily lick the taste and inhale the scent of her sour arousal, you guide her muff box to your " + player.cockDescript(x) + ".\n\n");
			outputText("She doesn’t even hesitate, falling on your spear like a pro, garnering a sweet moan from your lips, and a gasp from hers.  Her pussy was so warm and unbelievably tight you almost want to release your cum into her womb right now, but you took ahold of her sides, and with a grunt, pulled her down towards your base as you started thrusting upwards.  In response Priscilla matches you slamming down, her body quivering as she does so.\n\n");
			outputText("\"<i>Yes!  Fuck me.  Fuck me pregnant!</i>\"  Priscilla coos between gasps, seesawing up and down your shaft, a smile on her lips, as your hands went towards gripping her by her waist.  For added stability, she rests her hands on your shoulders, and in the throes of passion the two of you start colliding into each other faster and faster.\n\n");
			outputText("As Priscilla bounces on your " + player.cockDescript(x) + ", You eagerly move one of your hands towards her clitoris, and started to flick her clitoris with a finger, causing Priscilla to erupt in a cry.  As she leans back away from you, you pepper her neck and breasts with kisses, and with your other hand, you slap the goblin’s ass repeatedly, causing her to squeak and cry out your name, begging you to keep going.  Her pussy starts tightening and churning on your " + player.cockDescript(x) + ", demanding your cream, but you press on further, mashing her bean as the parted lips of her flower devoured your " + player.cockDescript(x) + " with no resistance.\n\n");
			outputText("You start moving faster, and you force yourself into Priscilla further, your " + player.ballsDescriptLight() + " slapping on the bottom of her ass with each jerk.  Priscilla’s sour fragrance spread everywhere with each squeal that came from her lips.  You pull yourself to her left breast, and then her right, slurping on her lethicite pierced nipples, the taste of the red minotaur blood exciting your loins, and igniting your spirit.  Breed me!  Fucking breed me you bastard!  Priscilla roars as she starts to cum her head off, her body shaking violently, and the sour scent of her pussy overpowering your senses..  Each slam into her pussy causes the goblin to cry out, every smash on her clit overpowering her will, and each nom on her nipples causing her to shiver.  You’ve started to feel your seed coming, and with one last thrust, you take Priscilla’s left breast into your mouth, biting deep and hard.  With a shriek, Priscilla arched her back and convulsed intensely, her pussy squeezing your cock good and tight, begging for the hot sticky load she always wanted.  It is then you feel you can no longer contain your juice.  Still biting Priscilla’s nipple, your eyes lose focus, as you feel your " + player.cockDescript(x) + " enlarging as your semen shot out into Priscilla’s greedy womb.\n\n");
			outputText("\"<i>Ah!  Oh yes breed me!</i>\"  Priscilla cried out, grasping your head closer into her breast.  \"<i>I’m going to be a mommy!</i>\" She starts swiveling on your dick, her pussy felt like an endless motion of contracting, and strangling more of your life creating liquid into her.  ");
			if (player.cumQ() >= 750) outputText("Amidst your nipple suckling, you watched as Priscilla’s stomach started to slowly inflate as if she already was pregnant, and you felt a large gush of your flow squeeze itself out of Priscilla’s pussy onto your balls.");
			outputText("Priscilla holds you onto her until the flow of semen finally stops.  You let go of Priscilla breasts-red with bite marks-dazed, yet satisfied.  You lay back on the ground, unable to move.\n\n");
			outputText("\"<i>Mmmm...</i>\" Priscilla moaned as she stood up above you, and walked towards her armor, loincloth, and weapons.  ");
			if (player.cumQ() >= 750) outputText("\"<i>You’re such an amazing breeder baby!  Maybe so good, I shouldn’t let you go...</i>\"");
			else outputText("\"<i>Stay safe out there, "+player.mf("stud","slut")+".  I’m going to need more of that sticky cream later.  Find me again okay?</i>\"");
			outputText("She gives you a devious look, the glance made you gulp and almost reach for your " + player.weaponName + " ... \"<i>Whenever you’re done being champion, me and my daughters would love a permanent home "+player.mf("stud","slut")+" to keep us company. Non-stop sex for the rest of your life - don’t say no now, just think about it.</i>\" She blows you a kiss, and walks away.  With a small smile on your face, you sleepily head back to camp for rest.\n\n");
			player.sexReward("vaginalFluids", "Dick");
			endEncounter();
		}

		private function assfuck():void {
			var x:int = player.cockThatFits(monster.vaginalCapacity());
			clearOutput();
			outputText("Priscilla huffs at your request for butt fun, but goes towards her supplies, rummages through her bag, and throws you a vial-lubricant.  \"<i>Babies aren’t made like this you know.</i>\"  She calls out, but the slight blush on her cheeks tells you that even so, she won’t mind the fun that will be had.\n\n");
			outputText("Priscilla gets on all fours, slowly swaying her body invitingly: her toned ass has a delicious jiggle to it that makes your rod stiffen so hard it hurts.  You kneel behind her, watching with an intense gaze as Priscilla spread her green cheeks and asshole open.  With the lube Priscilla gave you, you coat your first two fingers and slowly thrust your fingers inside her asshole, eliciting a sharp gasp from her.\n\n");
			outputText("\"<i>Your fingers are so cold!</i>\"  Priscilla whispers, taken in by this foreign and taboo pleasure.  You chuckle at her shaking and quivering, and with an evil thought, started lubricating the rest of your hand.  You force a third finger in, followed by a fourth, and finally your thumb.  Priscilla grit her teeth as you had your whole fist pumping in and out the rim , faster and faster until with a cry Priscilla collapses onto the ground, a puddle of her freshly squeezed pussy juice spread all over the ground.  You slip your fingers out of Priscilla’s now dilated asshole.  It just can’t quite close fully, meaning it's ready for service.\n\n");
			outputText("\"<i>Wait, wait!</i>\"  Priscilla slurred, dazed, and laying on her stomach with her gaping hole winking at you like a slut, but you take your " + num2Text(Math.round(player.cocks[x].cockLength)) + " hard cock and push it in past her rim.  Her eyes widen larger than the size of dinner plates as you grab her by the waist and thrust deep and hard!  Priscilla’s mouth opens to exclaim \"<i>G-gah!</i>\"  As her body spasms, as you pull her onto and off your throbbing " + player.cockDescript(x) + ", using her as a living clocksleeve");
			if (player.cocks[x].cockLength > 14) outputText("Slamming her into your meat, you took delight not only in her tightness, but at how her stomach bulged out when forced to take your cock.  ");
			outputText("A large moan escapes your lips, as your " + player.cockDescript(x) + " started to throb, painfully inside Priscilla.  You felt yourself unconsciously thrusting upwards, as your eyes rolled into the back of your head, the feeling of this goblin’s tight sweaty lube stained asshole leaving you unable to think coherently, except you needed to push farther, push deeper inside, until finally, the wave of pleasure overwhelms you.\n\n");
			outputText("A shrieking cry comes out from you as well as Priscilla, you feel your baby batter jettisoning out past Priscilla’s sphincter.  \"<i>Yes Champion, yes!  Paint my shitter white!</i>\"  Priscilla greedily shouts, eyes rolled up to the back of her head and mouth wide open and slobbering.  You grunt and moan as you hold the goblin in place, as each wave and ml of your semen left your body-you never felt so alive anywhere else, pumping cum into this goblin whore’s back door, but all good things must come to an end.  You pull your " + player.cockDescript(x) + " out of Priscilla, you shudder in pleasure, and a big grin appears on your face as ");
			if (player.cumQ() >= 750) outputText("a pure white flow of your baby jism shamelessly torrents out of Priscilla’s gaping brown star, a hole which doesn’t look like it’s going to fully close any time soon.");
			else outputText("a thin trail of your man milk leaks subtly out of Priscilla’s quivering but closing asshole.  ");
			outputText("Priscilla for her credit is still conscious, but other than the goofy look on her face, and murmurings of her asshole being pregnant, she wasn’t all there for the moment.  Utterly satisfied, you blow Priscilla a kiss, and head towards your camp.\n\n");
			player.sexReward("no", "Dick");
			endEncounter();
		}

		private function mouthfuck():void {
			var x:int = player.cockThatFits(monster.vaginalCapacity());
			clearOutput();
			outputText("Grabbing your shaft, you sit up and point a finger at Priscilla in a come beckon motion, jerking your manhood slowly.  \"<i>Come over here and taste this sausage.</i>\" You chuckle immaturely at your joke, but you almost yelp at how quickly Priscilla was kneeling in front of your cock, a flash of desire in her eyes, made you a bit uneasy.\n\n");
			outputText("Grasping your " + player.ballsDescriptLight() + " firmly, Priscilla slowly went towards the base of your shaft, and with the edge of her tongue, deftly licked and tasted you from your glans to the bottom of your member’s road, moaning in pleasure as she did so, as if just tasting your organ gave her the greatest orgasm.  She looked utterly enraptured, licking her lips as she stared at your member.  You’ve never seen anyone stare at you with such a hunger before, not even the shark girls.\n\n");
			if (player.cocks[x].cockLength > 14) outputText("\"<i>So much meat...And it’s all mine!</i>\"  ");
			else outputText("\"<i>Oh, this is going to be a treat.</i>\"  ");
			outputText("Priscilla whispered, as she grasped your " + player.cockDescript(x) + " and placed her lips to the head of your " + player.cockDescript(x) + " There was no attempt at foreplay.  Without even an ‘itadakimasu’ Priscilla had already downed half of your cock, causing you to yelp painfully as going down, her teeth awkwardly nipped your penis’ opening, though a wave of pleasure washed over you as Priscilla’s throat started to squeeze your " + player.cockDescript(x) + " like a vice, begging for your cum.\n\n");
			outputText("You start to moan as you look into your lovers eyes, enthralled by how several " + num2Text(Math.round(player.cocks[0].cockLength)) + " of your meat has already disappeared into her throat.  You shudder at the feeling of your precum already leaving your shaft, and almost feel ready to release early as you can feel the tightening of Priscilla's throat, as each dollop of pre causes her to spasm with need, begging for a taste.  Priscilla looks to be in utter bliss as one of her hands wrapped around your shaft, her other hand, went towards her slicken womanhood, and her head started struggling towards your crotch, using your pre as a lubricant.  Just when you thought you were going to explode, Priscilla’s throat slackened, as she slowly pulled her self off of your cock\n\n");
			outputText("\"<i>Oh I can’t believe this is all mine!  My girls will be so jealous!</i>\"  Priscilla moaned, as her lips went towards your balls, slurping and sucking on them like they were sugary jawbreakers, as her hands jerked, squeezed and milked your shaft as much as it was truly worth.  You bit your bottom lip in anguished pleasure as a slight masochistic streak developed within you as the constant edging of your cock and " + player.ballsDescriptLight() + " made you want to honestly die in a puddle of liquid bliss.  And then, almost as if you displeased her, Priscilla released your cock and grabbed your balls, wringing them taut and squeezing them to death.  You yelp and look at her in fear, and you see the whore grin an evil, evil grin: \"<i>Such a naughty dick must have the tastiest throat glue, right?  Don’t even hold back, Fill my throat with your gooey seed Champion!</i>\"  Visions of the utterly insatiable, utterly greedy Tamani entered your mind as without a word Priscilla went facedown in your crotch, taking all of your " + player.cockDescript(x) + " with one gulp.\n\n");
			outputText("Priscilla’s tits jiggle and sway as she slams her head down to your base.  A moan escapes you as Priscilla looks into your eyes, and you felt ready to melt nut something was keeping you to hang on.  As you find yourself enthralled by Priscilla’s mouth pussy, you feel your need to cum rising.  You mutter Priscilla’s name, which only spurs her faster.  Throughout all this, Priscilla never broke eye contact, mesmerizing you with the lust in her eyes, and the warmth of her tongue.  Slowly she releases your squeezed genitals, and she reaches towards her own.  Amidst her gagging and slurping, you can hear her shlicking her pussy while she goes \"<i>no hands</i>\" as your head doctor, going up and down again on your " + player.cockDescript(x) + ", her eyes rolling up into the back of her head in delight.\n\n");
			outputText("It was then that you lost control, utterly giving in to your better, this goblin elder.  \"<i>Oh Priscilla!</i>\" you cry out sensually, and you start thrusting up, matching her downward slams.  Priscilla started bobbing her head faster and closer on your " + player.cockDescript(x) + ", frigging her pussy fast and rough as her inhuman goblin whore throat starts unconsciously milking your cock.  No longer able to hold back, you use the last of your failing strength to grasp her head to push Priscillia down to the base of your cock.  You let out a howling scream as you arch your back and start to attack Priscilla's throat with three short thrusts, before you feel your seed, jetting out through your cock.  Priscilla's eyes rolled into the back of her head as she screamed into your cock, spasming violently as her pussy sprayed her hand and the parched dirt with her sour womanly flavor and scent.\n\n");
			outputText("You feel Priscilla’s hands on your balls again, making them slippery with her juices as she massaged your of your batter out of your shaft in tandem with her sweet lock jaw skills.  You cry out again as you even felt a three fingers reach into your bunghole, jabbing your prostate clumsily to claim even more of your nut - it works.  You groan outward in pain, as you feel the dregs of your semen finally leave your body, to be vacuumed into Priscilla’s mouth.  You weakly watch as she chews your load as she wipes her hands off on to the ground, and did nothing, as after she swallowed, she went up to you, and placed a sloppy, wet, semen tasted kiss on your lips, giving you a taste of her meal.  You moan weakly, so exhausted, that you find you’re unable to even stay awake.\n\n");
			outputText("You wake up an hour later, dazed, but satisfied.  Fantasies of you and Priscilla engage your mind as you gather your things, count to make sure none of your gems are missing, and walk back to camp.");
			player.sexReward("saliva", "Dick");
			endEncounter();
		}



	}
}
