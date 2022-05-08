package classes.Scenes.Places{
	import classes.*;
	import classes.BodyParts.Antennae;
	import classes.BodyParts.Horns;
	import classes.BodyParts.RearBody;
	import classes.BodyParts.Skin;
	import classes.BodyParts.Tail;
	import classes.BodyParts.Wings;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.ArmorLib;
	import classes.Scenes.Crafting;
	import classes.Scenes.Areas.Forest.WoodElvesHuntingParty;
    import classes.display.SpriteDb;
	import classes.internals.SaveableState;
	import classes.CoC;

	public class WoodElves extends BaseContent implements SaveableState {

		public static var WoodElvesQuest:int;
		public static const QUEST_STAGE_METELFSANDEVENBEATSTHEM:int = -1;
		public static const QUEST_STAGE_NOT_STARTED:int = 0;
		public static const QUEST_STAGE_METELF:int = 1;
		public static const QUEST_STAGE_LOSTTOELF:int = 2;
		public static const QUEST_STAGE_TOPICUNLOCKED:int = 3;
		public static const QUEST_STAGE_PCFUCKOFF:int = 4;
		public static const QUEST_STAGE_PCELF:int = 5;
		public static const QUEST_STAGE_PCNOTELF:int = 6;
		public static const QUEST_STAGE_PCCAMEBACK:int = 7;

		public static var WoodElfBowTraining:int;
		public static const QUEST_STAGE_BOWTRAINING0:int = 0;
		public static const QUEST_STAGE_BOWTRAINING1:int = 1;
		public static const QUEST_STAGE_BOWTRAINING2:int = 2;
		public static const QUEST_STAGE_BOWTRAINING3:int = 3;
		public static const QUEST_STAGE_BOWTRAINING4:int = 4;

		public static var WoodElfSpearTraining:int;
		public static const QUEST_STAGE_SPEARTRAININGFIRST:int = 0;
		public static const QUEST_STAGE_SPEARTRAINING0:int = 1;
		public static const QUEST_STAGE_SPEARTRAINING1:int = 2;
		public static const QUEST_STAGE_SPEARTRAINING2:int = 3;
		public static const QUEST_STAGE_SPEARTRAINING3:int = 4;
		public static const QUEST_STAGE_SPEARTRAINING4:int = 5;

		public static var hasTrainedToday:Boolean;
		public static var hasTrainedTodayCooldown:int;

		public function stateObjectName():String {
			return "WoodElves";
		}

		public function resetState():void {
			hasTrainedToday = false;
			hasTrainedTodayCooldown = 0;
			WoodElvesQuest = QUEST_STAGE_NOT_STARTED;
			WoodElfBowTraining = QUEST_STAGE_BOWTRAINING0;
			WoodElfSpearTraining = QUEST_STAGE_SPEARTRAININGFIRST;
		}

		public function saveToObject():Object {
			return {
				"stage": WoodElvesQuest,
				"stageBow": WoodElfBowTraining,
				"stageSpear": WoodElfSpearTraining,
				"elfHasTrainedToday": hasTrainedToday,
				"elfHasTrainedTodayCooldown": hasTrainedTodayCooldown
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				WoodElvesQuest = o["stage"];
				WoodElfBowTraining = o["stageBow"];
				WoodElfSpearTraining = o["stageSpear"];
				hasTrainedToday = o["elfHasTrainedToday"];
				if ("elfHasTrainedTodayCooldown" in o) {
					// new save, can load
					hasTrainedTodayCooldown = o["elfHasTrainedTodayCooldown"];
				} else {
					// old save, still need to set Cooldown  to something
					hasTrainedTodayCooldown = 0;
				}
			} else {
				// loading from old save
				resetState();
			}
		}

		public function WoodElves(){
			Saves.registerSaveableState(this);
		}

		//[Find Elves]
		public function findElves():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			WoodElvesQuest = QUEST_STAGE_METELF;
			outputText("As you explore the woods, you find a grove with a small pond in the middle and a large, vibrant tree growing in the corner. The tree isn’t a kind you recall seeing in the past. You examine the tree and fail to properly remember which variety it belongs to, not to mention the small green lights that dance around it, a bit like the faerie fires in a bog. As you are examining the tree you hear a crystal clear, beautiful laugh to your left, followed by the sounds of shuffling leaves. You ready yourself for combat and turn around just in time to see a blonde woman with pointed ears and green eyes staring at you from the middle of the clearing. She wears an outfit of white silk that covers her but does little to hide her feminine curves, which stand out on her delicate and ethereal frame in a way no human could match. You imagine even most succubi would be jealous of the natural way she wears her beauty, as if some goddess had sculpted her form from marble stone, clear water and living wood, then animated it with the lithe spirit of a fairy. You are still gazing, spellbound by her appearance, when she calls out to you in a clear, musical voice." +
					"\n\n\"<i>Welcome to our sacred grove, traveler. Are you perhaps lost?</i>\"\n\n" +
					"Not lost, you reply, though you don’t recall ever seeing this grove before. You were simply wandering the forest looking for whatever might cross your path. You ask her who or what she is." +
					"\n\n\"<i>We have our own name for ourselves, but others call us elves. And, a question for a question: who might you be, and what is the aim of your wandering?</i>\"\n\n" +
					"You briefly explain your origin and quest to the beautiful woman, her peaceful bearing and unearthly beauty having allayed your usual suspicion. As you do, you hear more chime-like laughter to both sides, and notice that you have more company now. More light-skinned, blonde, green-eyed elven girls seem to pop out of nowhere all around you, some perched in the trees, others standing right behind the bushes." +
					"\n\n\"<i>Such a valiant quest! How noble of you!</i>\", the lovely elf who first addressed you says, clasping her hands together.");
			//[Ask about elves] [Leave]
			menu();
			addButton(0, "About elves", AskAboutElves);
			addButton(1, "Leave", LeaveStartElfFight);
		}
		public function findElvesRematch():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("As you explore the forest you hear giggling. You feel a rush of air and barely have time to duck before an arrow misses you by an inch. It's the elves again! You try and run for it but a tree vine has firmly attached itself to your left leg, holding you in place and slowly attempting to drag you towards the giggling elves.");
			outputText("\n\n\"<i>Good day mister adventurer, how kind of you to come to us. Just sit down and relax; let us take great care of you.~♥</i>\"");
			outputText("\n\nHell no! <b>IT'S A FIGHT!</b>");
			startCombat(new WoodElvesHuntingParty());
		}

		public function AskAboutElves():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You press the beautiful elf for more information about her people. " +
					"While the word is familiar enough to you from stories even in your old world, you’ve never met one, even in Mareth, and know nothing of their nature or goals. " +
					"How have they remained hidden from the demonic threat even in these tainted woods?." +
					"\n\n\"<i>Oh goodness, what a curious little darling you are! But how should we answer so freely in such dangerous times? If our positions were reversed, would you tell a stranger about yourself, and maybe endanger your friends and way of life?</i>\"\n\n" +
					"She casts a meaningful look at a pair of elves in the tree above you, which you follow. One is cupping her cheeks with her hands, her face filled with mocking surprise, while the other grins widely and nods back to her companion in front of you, who addresses you once more, now sporting a more sadistic smile." +
					"\n\n\"<i>I cannot tell you what you wish to know...But I can show you. Come with me, and We'll let you experience it for yourself! Although, I’m afraid once you do you likely won’t be going back.</i>\"\n\n" +
					"As soon as she finishes speaking a pair of green vines grapple your torso from behind. You turn just in time to cry out as a normal-looking knot on the tree grows tentacles that begin to crawl toward you. " +
					"This must be yet another damn breed of tentacle plant, one you haven’t seen yet! Will you resist, despite your disadvantage? Or will you submit to your capture, though the elves are clearly planning something untoward?");
			//[Ask about elves] [Leave]
			menu();
			addButton(0, "Submit", YouAreAlreadyElfSubmit);
			addButton(1, "Resist", StartElfFight);
		}

		public function LeaveStartElfFight():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You decide to turn and exit the area." +
					"\n\nThe elf speaks up as you attempt to leave, \"<i>Oh my, you wish to leave already? I’m very sorry, but you won’t be going anywhere at the moment, not so long as we have you surrounded. There's so many things left we'd like to talk about and besides... I don't think <b>he</b> would agree to let you leave either. Please don’t hold it against us, though - this is all for your own good, I promise. By the end of it you will be thanking us for it.</i>\"\n\n" +
					"The elves tighten their circle around you to prevent any chance of escape as their sinister intentions become clear.");
			if (silly()) outputText(" Those dastardly ladies! Of all things you're in the midst of a circle of hedonistic elves!")
			outputText(" You brace for the incoming combat.");
			doNext(StartElfFight);
		}

		public function StartElfFight():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("Realising that there is no peaceful way out of this you ready your [weapon] and prepare for battle. The elves don't seem all too worried, after all its you versus an entire group of them. They likely think they can easily overwhelm you. They have archers surrounding you, and the ones on the ground have elegant, yet deadly-looking spears. This is not going to be a fun fight.");
			startCombat(new WoodElvesHuntingParty());
		}
		public function ElfFightWin():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("This battle is out of your hands. The moment you manage to defeat an elf another jumps in while a battle medic moves from the back to heal the fallen. You merely manage to create an exit amidst the mayhem, running as fast as you can. You will need to be wary of trees and blonde girls from now on. This is unlikely to be the last time you run into them.");
			WoodElvesQuest = QUEST_STAGE_METELFSANDEVENBEATSTHEM;
			doNext(cleanupAfterCombat);
		}
		public function ElfFightLoose():void {
			cleanupAfterCombatTFEvent();
			doNext(YouAreAlreadyElfLose);
		}

		public function YouAreAlreadyElfSubmit():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You decide to let the elven lady proceed. The elf leader raises an hand and tentacle-like vines whip around you as the elves encircling you smirk and giggle");
			YouAreAlreadyElf1();
		}

		public function YouAreAlreadyElfLose():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("Bested in combat and unable to continue fighting, the horde of elven ladies encroach upon you. The elf leader raises an arm as tentacle-like vines whip around you. The elves circling you titter, clearly eager to watch.");
			YouAreAlreadyElf1();
		}

		public function YouAreAlreadyElf1():void {
			outputText(" among each other. \n\n\"<i>See you again soon, my cute little adventurer.</i>\" says the leader playfully. \"<i>Try not to struggle too much, you’ll spoil the fun~♥</i>\"\n\n" +
					"A vine wraps around your mouth, silencing any further objections you might have. Your restraints prevent you from looking anywhere but straight ahead, but you feel a great load of sticky resin fall on you from above," +
					" presumably from the tree. you feel it even more than you might have expected, as the vines grappling you are joined by more, smaller tendrils. They begin removing your clothing, sliding underneath and peeling it off you. As if galvanized by the warm" +
					", golden ooze now covering you the vines begin swirling and slithering over your now naked body, teasing and tickling you until you begin to feel sensitive and aroused despite your situation." +
					" You clench in anticipation as one explores between the cheeks of your "+player.assDescript()+", then pushes its way into your "+player.assholeDescript()+"" +
					", its tapered end swirling about provocatively inside. The vine already gagging you stifles your cry of indignation as it works its way into your mouth, acting much the same way.\n\n As it does, it begins releasing a sticky, faintly sweet sap that trickles down your throat and coats your tongue, making you feel dizzy and flushed.");
			if (player.hasVagina()) outputText("You continue to thrash helplessly as a third tentacle winds its way into your "+player.vaginaDescript()+", and despite yourself your hips start to twitch and buck as it eagerly explores your wet cavity, tickling your sensitive places and slowly filling you with  more sticky fluid; it clings to your walls and makes them feel warm and tingly, and before long your slit is engorged and drooling with a mixture of the plant’s secretions and your own feminine fluids.");
			outputText("With a muffled gasp of terror and arousal you realize yet another tentacle is pressing against your belly-button, and you squeal against the tentacle invading your throat as it actually penetrates through you and begins, impossibly, to move about inside your stomach, tickling and teasing you from inside. Insanely, rather than the pain of your stomach being impaled it brings a feeling of soothing warmth - almost relief. ");
			if (player.hasCoat()) outputText("With a shock you look down at your body to see your "+player.coatType()+" melting away and washing off, replaced by smooth, silky skin. ");
			if (player.tailType != Tail.NONE || player.wings.type != Wings.NONE || player.legCount != 2) outputText("Soon after, your other extra, unneeded appendages begin to shrivel and melt away as well. ");
			if (player.hasCoat() || player.tailType != Tail.NONE || player.wings.type != Wings.NONE || player.legCount != 2) outputText("despite the radical changes your form is undergoing, ");
			else outputText("Despite being violated in every hole you have, and some you don’t, ");
			outputText("a wave of peace and well-being comes over you, dispelling your panic and all sense of urgency as it does. How can this be a violation when it feels so <b>good</b>? ");
			if (player.cocks.length >= 1){
				outputText("You sigh in pleasure as you feel a vine wrapping slowly about the base of your male organ");
				if (player.cocks.length >= 2) outputText("s");
				outputText(", and don’t even flinch as it pulls ");
				if (player.cocks.length == 1) outputText("it ");
				if (player.cocks.length >= 2) outputText("them ");
				outputText("off as easily as one might pluck a ripe fruit from a tree. You never needed ");
				if (player.cocks.length == 1) outputText("it ");
				if (player.cocks.length >= 2) outputText("them ");
				outputText("anyway, ridiculous, ugly thing");
				if (player.cocks.length >= 2) outputText("s");
				outputText("; you’re much better off without ");
				if (player.cocks.length == 1) outputText("it.");
				if (player.cocks.length >= 2) outputText("them.");
				if (!player.hasVagina()) {
					outputText(" Instead you feel a rising sense of ecstatic rightness as a new slit forms where ");
					if (player.cocks.length == 1) outputText("it");
					if (player.cocks.length >= 2 ) outputText("they");
					outputText(" once hideously stuck out of you. Ah, this is much more fitting! And <b>so</b> much more pleasurable!");
				}
			}
			outputText(" You feel as if you are being reshaped into the form you were always meant to have, the form your old" +
					", ugly self was hiding, caked over like dried mud. Now you are clean, pure, truly yourself. " +
					"Under the loving, tender caress of your rescuers, the holy vines, caressed by the warm sap of the sacred tree, " +
					"the relaxation and pleasure and euphoria finally drive you over the edge, and you cry out ecstatically in your sweet, clear voice as you cum, " +
					"twitching and shuddering against the embrace that holds you as your pussy splashes clear, sweet liquid onto the vines." +
					" Then, you are gently released to the ground, where you lie in bliss until a light sleep takes you.");
			player.sexReward("vaginalFluids", "Vaginal");
			player.sexReward("vaginalFluids", "Vaginal");
			player.sexReward("vaginalFluids", "Vaginal");
			CoC.instance.transformations.EarsElven.applyEffect(false);
			CoC.instance.transformations.FaceElf.applyEffect(false);
			CoC.instance.transformations.EyesElf.applyEffect(false);
			CoC.instance.transformations.TongueElf.applyEffect(false);
			CoC.instance.transformations.ArmsElf.applyEffect(false);
			CoC.instance.transformations.LowerBodyElf.applyEffect(false);
			outputText("\n\n");
			CoC.instance.transformations.HairSilky.applyEffect(false);
			player.wings.type = Wings.NONE;
			CoC.instance.transformations.EyesChangeColor(["light green"]).applyEffect(false);
			if (player.skin.base.pattern != Skin.PATTERN_NONE) {
				CoC.instance.transformations.SkinPatternNone.applyEffect(false);
			}
			player.skin.base.color = "light";
			player.skinType = Skin.PLAIN;
			player.skin.base.adj = "flawless";
			player.tone = 0;
			player.thickness = 20;
			player.femininity = 80;
			player.horns.type = Horns.NONE;
			player.antennae.type = Antennae.NONE;
			player.tailType = Tail.NONE;
			player.rearBody.type = RearBody.NONE;
			player.femininity = 80;
			player.killCocks(player.cocks.length);
			player.balls = 0;
			player.ballSize = 0;
			if (!player.hasVagina()) player.createVagina();
			if (player.breastRows.length >= 2) player.removeBreastRow(player.breastRows.length - 1,player.breastRows.length-1);
			if (player.biggestTitSize() <= 4){
				var sizeIncrement:Number = 5-player.biggestTitSize();
				player.growTits(sizeIncrement, 1, false, 3)
			}
			player.createPerk(PerkLib.FlawlessBody,0,0,0,0);
			player.createPerk(PerkLib.ElvenSense,0,0,0,0);
			WoodElvesQuest = QUEST_STAGE_LOSTTOELF;
			doNext(YouAreAlreadyElf2);
		}

		public function YouAreAlreadyElf2():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			outputText("You awaken a short while later. Still dazed, you crawl your way to the pond to take a look at yourself, only to find a stunningly beautiful elf girl looking back at you. " +
					"She has "+player.breastCup(0)+" breasts, round and firm and tipped with pink, blushing nipples, and clear, smooth skin as unblemished as the crystal waters of a forest stream, fairer than any mortal. " +
					"Her "+ Appearance.hairDescription(player) +" are like silk, " +
					"and her eyes are the emerald green of fresh leaves in early spring. Slowly your waking mind begins to piece together that this beautiful elven girl is actually you, the resemblance with the elves who found you earlyer is shocking! " +
					"\n\n\"<i>Oh heavens, Alyssa was right: you turned out just adorable<b>~♥</b></i>\"\n\n" +
					"The elf girl who seemed to be the leader of the others speaks from behind you, and you turn to face her. " +
					"She is gazing at you with eyes full of affection and approval. She is also alone; the other elves seem to have already left. " +
					"As you gaze up at her she reaches a hand out to you. With no real reason not to, you accept her offer and she helps you to your feet. " +
					"Then, gently but firmly holding your hand, the elf woman leads you out of the clearing. Still dazed, you ask her where she's taking you. " +
					"\n\n\"<i>Why, silly girl, I'm taking you home, of course! You wanted to see what elvish life is like, and now you will, little sister! Besides, the others are dying to see you. Oh, right! My name is Merisiel.</i></b>\"\n\n" +
					"Far, far back in the recesses of your mind a little fly buzzes; is it worry? Alarm? What could be causing that? After all, your big sister is finally taking you home! Everything is going to be okay now. With a shake of your head you dismiss the strange fancy and listen to Merisiel as she tells you how cute you look. You smile and blush shyly at your big sister’s praise, happier than you’ve ever been that she thinks so highly of you.\n\n" +
					"After a few minutes’ walk the two of you reach a clearing filled with small tents, tables, soft mats for resting, and, most of all: elves!" +
					" So many beautiful, lithe, smooth-skinned elves, and not an ugly male in sight to mar the beauty! Most of them have stopped what they were doing," +
					" turning their lovely faces your way to give you quiet, curious stares. For a moment you feel the icy grip of fear on your heart;" +
					" is something wrong with you? Are you going to be cast out from this very heart of the world’s beauty before you even enter?" +
					" But before you can work yourself up into a panic Merisiel leads you to a large tent and motions you to enter," +
					" smiling warmly at you to quell your worries. Inside you see  two elves sitting on a bed of soft pillows heaped together and covered with a warm," +
					" pink blanket - dimly you recognize them as the two Merisiel consulted in the tree when you were… before you… where were you before this? What were you doing?" +
					" The thought troubles you for an instant, but the sweet voice of one of the two women in front of you quickly drives it away as she welcomes you." +
					"\n\n\"<i>It’s nice to meet you, little sister. My name is Elenwen. Please, join us in the bed and relax.</i>\"\n\n" +
					"Elenwen has short hair, blond like all of the others, and her eyes are slightly slanted, giving her a slightly piercing gaze that contrasts with her soft, gentle voice. Her hips and breasts are full and womanly, and also exposed - neither she nor her neighbor are wearing a stitch between them." +
					" Distantly you realize that you aren’t either, though the thought brings no embarrassment with it - after all, you’re all sisters here, right?");
			if (player.armor != ArmorLib.NOTHING) outputText(" Wait, didn’t you have some things with you before? Important things…?");
			outputText("\n\n\"<i>And I'm Alyssa,</i>\" says the elf sitting next to Elenwen, her chiming tone driving away your hesitation again. Her blond hair is done up in adorable braided twintails, accentuating her slender, girlish build, and her eyes are large and filled with gentle curiosity. \"<i>Oh look, Elenwen, her hair is still...</i>\"\n\n" +
					"With a shock you realize why everyone must have been staring at you! Your hair is "+ player.hairColor +", not blonde like it should be! Your face becomes hot with shame and tears begin to fill your eyes as you realize something is separating you from your sisters. However, Elenwen quickly speaks to you to soothe your worries." +
					"\n\n\"<i>Don’t worry, little sister! We’ll make it all right. Just let Alyssa and I take care of everything.</i>\" She turns to face her companion. \"<i>Alyssa, you manage her after we’re finished here, okay? I did the last one, after all; it’s only fair.</i>\"\n\n" +
					"That didn’t sound quite right, you think, but you don’t have time to work through your misgivings as Elenwen addresses you again with a loving smile that almost reaches her lovely, slanted eyes." +
					"\n\n\"<i>Come, new little sister. Let’s clean all that sticky sap off you, hmm?</i>\"\n\n" +
					"Merisiel quietly leaves the tent as Elenwen pulls you onto the bed and lays you down between her and Alyssa." +
					" She nibbles at your long, pointed ears, which you now realize are <b>very</b> sensitive as the feeling of her lips and teeth forces a soft gasp from you." +
					" Alyssa wastes no time watching, instead softly, teasingly licking at your left breast, starting at the nipple and slowly circling her way outward, gently cleaning the sap from your skin." +
					" Leaving your trembling ear, Elenwen traces a delightful trail down your neck with her soft, pink tongue, then turns your head toward her with her slender hands to cup your cheeks and kiss you." +
					" Her lips are so soft, warm, and sweet that you fail to notice Alyssa’s delicate fingers take hold of your hand and guide it into your pussy," +
					" until she starts pushing and pulling with leading movements until you are fingering yourself, slowly but lustfully, and you moan in arousal into Elenwen’s passionate kiss." +
					" By the time Alyssa removes her hand from yours the movements have become automatic, and you pleasure yourself eagerly, moaning and gasping in delight while the two women continue to lick and caress you all over." +
					"\n\n\"<i>Hee hee, goodness! Our little sister has taken to it like a fish to water; I dare say she’s going to fit right in here.</i>\"\n\n" +
					"Elenwen pulls a lock of your "+ player.hairColor +" hair in front of your eyes between her lovely fingers, and to your surprise they have started to turn golden blonde, just like that of all the other elves." +
					"\n\n\"<i>Mmmm, she sure is, Elenwen!</i>\"replies Alyssa, \"<i>And I bet she’s <b>really</b> going to enjoy this…</i>\"\n\n" +
					"You shudder in delighted pleasure as Alyssa runs her tongue down your belly, from your sternum down to just above your glistening lower lips," +
					" which you are still mindlessly plowing with your own slender fingers." +
					" The thought of becoming more like your elven sisters carries you to new heights of arousal, and your hips buck as you gasp from a small orgasm that leaves your body trembling with the promise of more to come." +
					" Meanwhile, Elenwen pulls back to retrieve something from the end of the bed: a double-ended dildo made of a translucent green-gold substance." +
					"\n\nAlyssa whispers in your ear. \"<i>That lovely thing is made from the very sap of the tree you fell from. With its help, everything will go even faster. Just lay still, and let the tree’s sap work its magic, little sis. You’re going to <b>love</b> it.</i>\"\n\n" +
					"Even if you wanted to resist, you’re much too far gone; the pleasure has paralyzed your mind and body and all you can do is writhe in ecstasy as Allyssa pins you under her." +
					" Her pert palm-sized breasts and stiff nipples press against your own as Elenwen inserts one end of the toy into her own welcoming slit then pushes the other tip of the golden length between your pink," +
					" dripping lips. For a moment the entire world seems to pause in anticipation, then you gasp and let your mouth gape open as Elenwen fully slides the toy in, the blonde color running higher up your hair strands. Why does it feel so <b>good</b>? " +
					"You didn’t think anything could feel this good! You lose yourself entirely in the experience as Elenwen thrusts into you again and again, moaning as with each shock of pleasure your "+player.hairColor+" hair becomes a little more blonde. Just before you reach orgasm, the last of the "+player.hairColor+" fades, leaving your hair fully golden blonde." +
					" Elenwen stops her thrusting and  whispers sweetly in your sensitive ear as your juices run freely down the toy, twitching with each spasm of your drenched pussy around it as it begs for your impending climax." +
					"\n\n\"<i>Tell me, little sister, what is it that you want right now? Is it something cute, fun, or pleasurable? Whatever it is we'll do it for you, as much as you like, as often as you like, from now on. All you have to do… is… ask<b>~♥</b></i>\" She punctuates the end of her sultry proposal by brushing her fingers against your clitoris, making you jump.\n\n" +
					"What do you want? You only want her to finish, to push you over the edge, tumbling into the mind-shattering orgasm you feel coming, don’t you? There wasn’t anything else… before all this… Just as you start to waver Elenwen gives the golden dildo a little twist inside you and the question evaporates.. No, of course, you are an elf;" +
					" you are Elenwen and Alyssa’s youngest and dearly beloved little sister. All you want, all you ever wanted, all you will want is for your big sisters to love you more… play with you more… make love to you, always and forever, here in this paradise. You beg her to push you over the edge, to drown you in pleasure and never let you come back up." +
					"\n\n\"<i>Awww, Alyssa, she’s so cute~! Now I want to have her…</i>\" Elenwen pouts as she complains to Alyssa, who giggles on top of you and begins kissing your lips.\n\n" +
					"\n\n\"<i>Hee hee, too laa~aate sister, you already assigned her to me<b>~♥</b></i>\" She says in between kisses.\n\n" +
					"Still pouting, Elenwen obliges you, thrusting and twisting the magical toy while she teases your clit with her fingers, and you sail over the edge into the most intense orgasm you can remember; your vision goes pure white and you scream while Alyssa gently restrains your thrashing limbs, kissing your cheeks and nibbling at your lips and ears." +
					" For a few blissful moments your mind is filled only with the shock of orgasm, love for your sisters, and happiness at having finally come home; then, as you come down, the two elven women cuddle you until you fall asleep, whispering and cooing in your ears as they praise you for a job well done.");
			player.hairColor = "golden blonde";
			doNext(YouAreAlreadyElf3);
		}

		public function YouAreAlreadyElf3():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			outputText("The next few days pass like a happy dream as you play with your sisters, collect flowers, and have 'fun time' with Alyssa, and sometimes Elenwen and even Merisiel." +
					" However, something nags at your mind… something very important, you think, but like a wisp of smoke it keeps twisting and dissipating every time you try to grasp hold of it." +
					" It’s certainly not enough to ruin the enjoyment of your new, perfect life, but as the only sour note to your experience in the elves’ secluded grove you can’t bring yourself to ignore it.\n\n" +
					"Then, one day, you come across the elves’ armory: gracefully curved hunting bows carved from dark, rich-grained forest wood and strung with Elf-hair;" +
					" slender, barb-tipped arrows fletched with lovely, bright feathers; broad-bladed knives and glittering spears with wickedly sharp edges and tips to belie the beautiful, pale gleam of the silvery metal," +
					" the intricate carvings along the shafts and the soft leather-wrapped hilts. The first indication of violence, of anything besides peaceful days and nights of singing and cuddling and bathing with your sisters," +
					" shocks your memory and you recall that before you came here you too were… what were you? Some kind of warrior…? You had something to protect… a duty that mattered more than anything else…" +
					" For the first time the thought doesn’t immediately evaporate, and you seize the opportunity by grabbing a bow and a few arrows from their rack." +
					" A small row of targets stands not far from you and, with practiced movements you nock a delicate shaft, draw the surprisingly weighty bow, and fire." +
					" Your arrow strikes true and sinks deeply into your target; not a bulls-eye but a respectable shot for someone who can’t remember ever drawing a bow before." +
					"\n\n\"<i>Woah, what a shot, little sister! You almost looked like a real elven huntress just then<b>~♥</b></i>\"\n\n" +
					"Startled, you turn around to see Merisiel standing behind you - you must have been too focused on your shot to hear her approach." +
					" Your face, driven by instinct, blushes at her praise as you smile happily and nock another arrow, drawing your bow and aiming it directly at your captor’s lovely breasts." +
					" The thoughts still aren’t fully coherent but somehow it’s coming together in your head that your beautiful sister is an enemy, that she and the rest of the elves are keeping you from..." +
					" what was it? Unbidden, the image comes to your mind of a glowing, purple scar torn into the very air, as if a magical knife had cut a circle out of the world into… somewhere?" +
					" Somewhere important,.. somewhere you must protect, no matter the cost.\n\n" +
					"Merisiel slowly raises her hands as you keep your shot trained on her, your arms trembling ever so slightly as you strain to keep the bow drawn." +
					" Her warm smile slowly fades to a blank expression as she watches you slowly recover yourself." +
					"\n\n\"<i>Ah.</i>\" she says, then gives you another smile, this one significantly more strained.\"<i>Okay, so before we do anything that can’t be undone, can we talk? I’ll call Alyssa and Elenwen over and we can discuss things peacefully, okay?</i>\"\n\n" +
					"Despite how obviously suspicious her statement is, all things considered, something in your transformation and pleasure-addled brain still resists the idea of shooting the lovely girl in front of you in cold blood, so you nod and slowly lower the bow." +
					" Merisiel laughs nervously and beckons you to follow her. Even so, you grab a knife as you do." +
					"\n\n\"<i>Uh oh,</i>\" Elenwen says, then side-eyes her companion. \"<i>I thought you said <b>you</b> wanted to take care of her!</i>\"" +
					"\n\n\"<i>I <b>did</b>,</i>\" Alyssa replies. \"<i>I did everything I was supposed to! This shouldn’t have happened!</i>\"" +
					" Then she turns her head toward you and talks to you in a conciliatory voice. \"<i>Okay little sister… or, adventurer, I guess… we don’t know your old name and your naming ceremony was tomorrow. You can put down the bow, we won’t try to start anything. I promise.</i>\"\n\n" +
					"Merisiel chimes in as Alyssa finishes. \"<i>No Elf has killed another since we founded this village, and we’ve got no intention of starting now. And if you’re recovering your memory there’s nothing we can do. The Sacred Tree’s… ‘blessing’, only works once. It can’t transform you twice. So it’s over; the only thing we ask is that you not hurt our sisters. We won’t stop you if you want to leave.</i>\"\n\n" +
					"Elenwen speaks up after Merisel. \"<i>I’m sure you have some questions for us. We’ll answer you as best we can. Please don’t hate us for this; I know you must be angry but we have our circumstances as well. We’re trying to survive, just like everyone else in Mareth.</i>\"\n\n" +
					"Something about the way the three are speaking to you makes you feel like you can trust them, and it isn’t just the lingering fog in your brain. You still can’t quite remember your name, but other things have been flowing back into your mind as they’ve been talking to you: Ingnam, your old world, your camp, the people you’ve met in Mareth before now." +
					" You lower your bow and take a seat with the others, and they await your questions as they pass uncomfortable looks back and forth.");
			menu();
			addButton(0, "Elves", ElvesTopic);
			addButton(1, "The Tree", TheTreeTopic);
			addButton(2, "The Grove", TheGroveTopic);
			addButton(3, "Demons", DemonsTopic);
			addButton(4, "Ceremony?", CeremonyTopic);
			addButton(5, "Need2Go", Need2GoEndElfQuest);
			//addButton(6, "Want2Stay", Want2Stay);
		}

		public function ElvesTopic():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You ask the three elves about the elven race: why is there so little information about them? Have they always been hidden away or is something else going on?" +
					"\n\nMerisiel responds first. \"<i>We have been here since ancient times its just that we don't like to mingle with outsiders and this holds twice as true since the demon invasion happened.</i>\"" +
					"\n\nAlyssa continues. \"<i>Whoever somehow finds us tends to stay here and keep shut about our existance we mind our business and prefer to keep to ourselves.</i>\"" +
					"\n\nElenwen takes over. \"<i>Idealy only those we 'invite' in can find the village so most people don't even know we exist.</i>\"" +
					"\n\nMerisiel finishes the story as her sisters trail into sad silence. \"<i>I guess since we tend to kidnap people we wouldn't exactly receive a warm welcome amonst the other civilised races. Then there's our cousins the dark elves... They have an...unfortunately well-earned reputation as slavers. We used to be cleaner then this... But ever since the demons defiled our sacred trees, lust is one of the only things we can focus on.</i>\"\n\n" +
					"She glances at her sisters, a mixture of emotions visible in her face. Clearly the priority among these elves of the wood is no longer on exploration and diplomacy - you’ve experienced that much yourself by now.");
			menu();
			addButton(1, "The Tree", TheTreeTopic);
			addButton(2, "The Grove", TheGroveTopic);
			addButton(3, "Demons", DemonsTopic);
			addButton(4, "Ceremony?", CeremonyTopic);
			addButton(5, "Need2Go", Need2GoEndElfQuest);
			//addButton(6, "Want2Stay", Want2Stay);
			if (WoodElvesQuest == QUEST_STAGE_TOPICUNLOCKED){
				addButton(7, "Do Ceremony!", Ceremony1);
				addButton(8, "Keep name", KeepName);
			}
		}

		public function TheTreeTopic():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You tell them to explain what is going on with that bizarre tree." +
					"\n\nAlyssa responds first. \"<i>The Sacred Tree grew from a sapling that dates back to the first days of Mareth. It is, or it was, I suppose, a core part of our culture; we elves are forest spirits deeply connected to the trees and animals of the woods, and the Sacred Tree was like our patron. When a new elf was born, we would place it underneath the tree, and it would be blessed with the spirit of the forest, growing into a true elf.</i>\"" +
					"\n\nElenwen continues. \"<i>When the demons found it, though, they changed all that. They corrupted it, turned it into… something else. They also corrupted us. You may have noticed that there are no male elves here; or at least none you would easily recognize as such without… checking. The truth is that male wood elves are so rare, thanks to those...Demons... That our males...well... Our only means of increasing our numbers nowadays is to abduct people.</i>\"" +
					"\n\nMerisiel nods. \"<i>The Sacred Tree, or I suppose the Corrupted Tree, now... it eats men. Or, it eats the ‘male’ out of men, I guess… in the process changing them into one of us. We can’t reproduce among ourselves anymore - the few of us that still have some of the right equipment are sterile. And when we breed with other races, the children aren’t elves. So the only way we can replenish our numbers from losses is by letting the Tree have its way with travelers we find… like we did with you.</i>\"" +
					"\n\n\"<i>But we really do care for them afterward!</i>\" Alyssa interjects. \"<i>Just like we did with you… or tried to, at least. We really did consider you to be one of us. I still do… little sister.</i>\" She trails off as she looks away from you sadly.");
			menu();
			addButton(0, "Elves", ElvesTopic);
			addButton(2, "The Grove", TheGroveTopic);
			addButton(3, "Demons", DemonsTopic);
			addButton(4, "Ceremony?", CeremonyTopic);
			addButton(5, "Need2Go", Need2GoEndElfQuest);
			//addButton(6, "Want2Stay", Want2Stay);
			if (WoodElvesQuest == QUEST_STAGE_TOPICUNLOCKED){
				addButton(7, "Do Ceremony!", Ceremony1);
				addButton(8, "Keep name", KeepName);
			}
		}

		public function TheGroveTopic():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You ask about the Grove." +
					"\n\n\"<i>It’s been our home for years, of course,</i>\" says Elenwen. \"<i>Well truth be told its one of the few remaining if not the last wood elf community across mareth since our species is mostly extinct due to our ahem... reproduction issues.</i>\"" +
					"\n\nMerisiel adds, \"<i>It’s a beautiful place, even after the corruption, I think. Nature thrives here; the plants and animals are healthy and free, and we live mostly in peace, aside from catching an adventurer every so often to replenish our numbers.</i>\"\n\n" +
					"Like they did with you, you add." +
					"\n\nThe three girls look a little guilty for a minute and nod. Alyssa says \"<i>We really did love you though. I… I still love you, and I wish you would stay with us. It’s not so bad here, is it?</i>\"\n\n" +
					"Unable to truthfully answer yes with certitude, you hold your silence and move on.");
			menu();
			addButton(0, "Elves", ElvesTopic);
			addButton(1, "The Tree", TheTreeTopic);
			addButton(3, "Demons", DemonsTopic);
			addButton(4, "Ceremony?", CeremonyTopic);
			addButton(5, "Need2Go", Need2GoEndElfQuest);
			//addButton(6, "Want2Stay", Want2Stay);
			if (WoodElvesQuest == QUEST_STAGE_TOPICUNLOCKED){
				addButton(7, "Do Ceremony!", Ceremony1);
				addButton(8, "Keep name", KeepName);
			}
		}

		public function DemonsTopic():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You ask about the elves’ relationship to the Demons." +
					"\n\nMerisiel answers you first. \"<i>When the demons invaded Mareth it didn’t take them long to find us here in the forest.</i>\" she says, sadly. \"<i>They… changed our Sacred Tree, and when they did we changed with it. We became much more sexually active, and our men mostly turned into women. Those of us that were affected the worst they took with them to be… toys, I suppose, or maybe soldiers; we don’t really know. Since then they’ve left us alone, I’m sure because they know we’re not a threat.</i>\"" +
					"\n\nAlyssa interjects. \"<i>But we’re not allied with them! We hate Lethice for what she did to our Sacred Tree… even if we, um… kind of enjoy the sex now.</i>\"" +
					"\n\nElenwen smiles dreamily. \"<i>Yeah, I’m not really sure I’d want to go back now if I could… it just feels so good, and everyone gets along even better than they did before, hee hee…</i>\"\n\n" +
					"The three girls break off into giggling and staring lustily at each other, and you; sighing, you abandon the topic. It’s unlikely you’re going to get more out of them about the demons. Oh well, at least they’re not working with Lethice actively.");
			menu();
			addButton(0, "Elves", ElvesTopic);
			addButton(1, "The Tree", TheTreeTopic);
			addButton(2, "The Grove", TheGroveTopic);
			addButton(4, "Ceremony?", CeremonyTopic);
			addButton(5, "Need2Go", Need2GoEndElfQuest);
			//addButton(6, "Want2Stay", Want2Stay);
			if (WoodElvesQuest == QUEST_STAGE_TOPICUNLOCKED){
				addButton(7, "Do Ceremony!", Ceremony1);
				addButton(8, "Keep name", KeepName);
			}
		}

		public function CeremonyTopic():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You ask Merisiel what this naming ceremony is about. She uncomfortably shifts in place before answering you." +
					"\n\n\"<i>Well it's a big event first and foremost, all new elves get a name given to them by the sacred trees. As we told you before, we elves are bonded to the forests. When a sister is ready to become a true wood elf she must undergo the naming ceremony which consists in fully bonding with an offshoot of the sacred tree, both in body and soul. Your elven name is something that will come to you naturally, and your soul will merge with that of the forest.</i>\"\n\n" +
					"Merge with the forest? She could not possibly mean... Sensing your confusion Merisiel, with an almost ironic, somewhat deadpan soulless glare clarifies the rest for you." +
					"\n\n\"<i>If I was not clear enough your soul will safely stay bound within the tree, out of your body. So long as the forest lives you will never age again.</i>\"\n\n" +
					"You think for a moment, unite your soul with the forest in exchange for a timeless body and a new elven name? Is this what you truly want?");

			menu();
			addButton(0, "Elves", ElvesTopic);
			addButton(1, "The Tree", TheTreeTopic);
			addButton(2, "The Grove", TheGroveTopic);
			addButton(3, "Demons", DemonsTopic);
			addButton(5, "Need2Go", Need2GoEndElfQuest);
			//addButton(6, "Want2Stay", Want2Stay);
			addButton(7, "Do Ceremony!", Ceremony1);
			addButton(8, "Keep name", KeepName);
			WoodElvesQuest = QUEST_STAGE_TOPICUNLOCKED;
		}

		public function Need2GoEndElfQuest():void {
			clearOutput();
			WoodElvesQuest = QUEST_STAGE_PCFUCKOFF;
			outputText("The three look sad as you tell them you’ll be leaving." +
					"\n\nMerisiel sighs. \"<i>I figured you would when I realized your memories were returning. Don’t worry, we won’t try to stop you.</i>\"\n\n" +
					"Elenwen tells you where your old equipment is being stored. \"<i>We didn’t get rid of it… we were planning on giving it back to you after your naming ceremony tomorrow anyway. I suppose you’ll be wanting it.</i>\"\n\n" +
					"Alyssa has tears in her eyes as she pleads with you but your mind's made up and you decide to leave, heading back to your camp.");
			doNext(camp.returnToCampUseOneHour);
		}

		public function KeepName():void {
			clearOutput();
			outputText("Despite everything that happened in this time together, you still smile at the three misty-eyed Elven girls." +
					" You did grow close to them over the last couple of days, and you think you may miss them too," +
					" even if what they did to you was rude, more or less by Mareth’s twisted standards anyways." +
					" Once you’ve made sure all is well at your camp and resumed your duties as Champion, perhaps you’ll take them up on your offer." +
					" With a goodbye for now to the three girls, you collect your old equipment and leave the elven Grove." +
					" The voices of your would-be sisters fading into the distance behind you as you return to your camp. As you tread back," +
					" the paths slowly become familiar as the last of your brainwashing fades, and you remember your name." +
					" You won’t forget it again; you’ll live or die as [name], the Champion of Ingnam. But, you think with a faint smile," +
					" you certainly wouldn’t mind coming back now and again to spend more time with the lovely elves," +
					" now that you’ve sorted out their rather forceful welcome. The thought manages to bring a stirring heat deep within you.");
			WoodElvesQuest = QUEST_STAGE_PCNOTELF;
			doNext(camp.returnToCampUseOneHour);
		}

		public function Ceremony1():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("While you do want to continue your quest you feel a strong tie to your sisters. Maybe it's the elven brainwashing magic that compels you ");
			if (flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] > 0) outputText(", maybe it's your disillusion toward mankind, after all, the elders of your village sold you into slavery.");
			outputText("or maybe it's just that you really love your elder sister that much. Regardless, your old name holds little meaning to you now and you are more than ready to discard it, just as you would your past as a human. If relinquishing your soul to the forest can make you that much closer to your dear sisters, then all the better. You announce your decision to take on the naming ceremony and become a true elf like them, however you will pursue your original quest as well; if not for Ingnam, which never deserved your efforts, then for the elves so they can one day be free of demonic influence." +
					"\n\nAlyssa claps her hands, overjoyed \"<i>Sister, you are the best, you know that? Despite everything that happened you still haven't given up on living together with us.</i>\"\n\n" +
					"As if you would. This little paradise is what's truly worth fighting for.");
			doNext(Ceremony2);
		}

		public function Ceremony2():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("On the following day, the elven community assembles next to the tree line. You stand amongst a few other antsy sisters. " +
					"You feel slightly tense, but at least you are not alone in getting a new name today. One after another, " +
					"the young elves head toward the trees. You are unable to see much given you are at the back of the crowd. " +
					"Though, the cheers and encouraging words from your sisters are telling that they passed the ceremony effortlessly. " +
					"Eventually, your turn arrives. Your caretaker gently ushers you toward the front of the crowd." +
					"\n\nAlyssa, being your eldest, encourages you with a gentle whisper, \"<i>Do not let fear or doubts consume you. Approach and embrace a tree. It will do the rest. Trust it. Relinquish yourself to it. Let the bonding happen naturally. It will be a pleasant experience. All your sisters know you are ready. Your other sisters and I are all cheering for you.</i>\"\n\n" +
					"With an assured nod, you slowly walk toward the treeline. Unsurprisingly, those trees are very similar to the tree that made you what you are now. They are smaller but nearly as corrupted. " +
					"Were you any different; you would walk toward these things with a weapon drawn, but that was the old you. " +
					"You are different now. You know what you want to do now. This tree calls to you in earnest, and you will gladly accept its call.");
			doNext(Ceremony3);
		}

		public function Ceremony3():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("The first time you met one of the tentacle trees, you were dragged against your will and fought back with all you had." +
					" Now, you walk toward the tentacle tree with focused will and determination, discarding your ephemeral elven clothes as you press your naked form against the bark of the tree. " +
					"\n\nYou sigh in delight as you make contact. Unlike a typical tree, the warm trunk is smooth against your elven skin." +
					" Vines crawl from above to gently press you against the tree into a soothing embrace like you are a long-missed lover." +
					" Feeling safe in the tree's embrace, you abandon yourself to your verdant lover's ministrations." +
					" A tendril gently wraps itself around your left leg, teasing the entryway to your elven nether lips as if asking for your permission." +
					" You coax the vine with a slow caress from your right hand, relinquishing control entirely." +
					"\n\nIt is a slow but gentle penetration as the vine parts your lips, inserting itself into you with several inches, following the pulse of your heartbeat." +
					" A second vine fondles the entryway to your anus before it proceeds softly digging into you." +
					" Your mind trails, lost in the thought of giving yourself to the gentleness of the tree." +
					"\n\nYou open your eyes, barely spying a faint green glow coming from your pussy where the vine is embedded as the glow from your cunt slowly transfers to the vine, then through the tree." +
					" The tree permeates with a warm, green glow as foreign yet incredible sensations overwhelm your entire body." +
					"\n\nYou can hear the pulse of the sap, the slow movement of a tainted source of water underground." +
					" The mating calls of faraway birds, the breeze caressing a whole field of open flowers, pistils brushing against one another as pollen flies in the air. You hear the forest, or rather, you are the forest." +
					" The sensory overload causes you to clench as your climax hits. You reflexively clamp around the vine within you as the green light funnels into the tree. A soft moan escapes your lips as the vine pumps sap directly into your womb." +
					" Within the high of your climax, you hear the whisper of a name in the rustling of leaves." +
					" Your mind sharpens at the sound as if given a moment of clarity. What is it that you heard?");
			doNext(Ceremony4);
		}

		public function Ceremony4():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("This name, whispered to you by the spirit of the forest, was...");

			flushOutputTextToGUI();
			mainView.nameBox.text = "";
			mainView.nameBox.maxChars = 16;
			mainView.nameBox.visible = true;
			mainView.nameBox.width = 165;
			// place below currently displayed text
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
			addButton(0, "OK", chooseName);
		}

		public function chooseName():void {
			if (mainView.nameBox.text == "") {
				clearOutput();
				spriteSelect(SpriteDb.s_WoodElves);
				outputText("You try to listen again for the name you heard in the rustling leaves what is it you heard? (You must select a name)");
				doNext(Ceremony4);
			}
			else{
				mainView.hideComboBox();
				mainView.nameBox.visible = false;
				player.short = mainView.nameBox.text;

				clearOutput();
				spriteSelect(SpriteDb.s_WoodElves);
				outputText("Is this realy the name you heard?");
				menu()
				addButton(0, "Yes", Ceremony5);
				addButton(1, "No", Ceremony4);
			}
		}

		public function Ceremony5():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("[name]! Yes, that is you. You are [name], beloved child of the forest, and this is the tree which initiated you." +
					" The tree is now vibrant with green light, your soul in the safekeeping of its woods along those of the many elves who came here before you." +
					" With tender care, the vines slowly disentangle you from its embrace before allowing you to escape." +
					"\n\nYou can still feel the connection between you and the forest, leaving you with enhanced senses. The overwhelming sensations dim down over time," +
					" becoming easier to bear and allowing you to regain a semblance of control over yourself, though it never dies out completely." +
					"\n\nYour pussy still slowly dripping a small stream of sap, you walk back to your sisters smiling serenely." +
					" Sex is such a taboo concept for most, but having achieved inner harmony and symbiosis with the forest has granted you insight into your sexuality like never before." +
					" Would you be able to go back to being a prude boring human after tasting this and finding your calling? No, certainly not, and even if you could, your form is now wholly body and soul that of a wood elf, the wood elf named [name]." +
					" With your new name and heightened resolve, you heard back from the treeline.");
			doNext(Ceremony6);
		}

		public function Ceremony6():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("Alyssa welcomes you back with a loving hug as you come running out of the woods toward her. Her hand pleasantly ruffles through your hairs while the upcoming uninitiated head for the woods." +
					"\n\n\"<i>See? That wasn't too bad. Now we truly are connected both by blood and soul; that of the forest. I will clean you up so you can be ready for the evening meal. I know you will likely want to resume your old quest tomorrow. Merisiel, Elenwen, and I have already retrieved your things. You will be up and ready for adventure again in no time.</i>\"\n\n" +
					"What about home, though? Is this goodbye?" +
					"\n\n\"<i>You're joking aren't you? You're free to take a break from your world trekking anytime and come back here to visit. No one here will judge you if you truly decided to retire from adventuring and stay here permanently. Honestly, I think a cute girl like you doesn't belong out there fighting monsters and demons. But since this is the choice you made, all we can do is make sure this adventure won't cost you anything. And should things become impossible, you can always come back here and lay on your big sister's shoulder for moral support.</i>\"\n\n" +
					"This evening, you eat fresh fish caught from the stream and berries, sharing this final meal with your sisters. Knowing you might not see them for a long while, you want to spend another moment of intimacy with them. The four of you playfully share the comfy pillow bed one last time. You doze off within your sisters' arms, feeling both bliss and security." +
					"\n\nThe day after, you pick up your gear and get ready to resume your quest. With a heartfelt goodbye for now to the three girls, you leave the elven grove." +
					" The voices of your sisters fade into the forest behind you as you return to your camp. The paths slowly become familiar while you tread as the last of your brainwashing fades. " +
					"As you pass a nearby running river, you look into it as your reflection stares back at you. Your reflection carries two bright green eyes, like shining emeralds." +
					" Something about it is deeply unsettling. The reflection shines with a foreign luster. Lifeless, hollow, empty... Soulless." +
					" Chills run down your body as your mind trails, knowing your soul is lingering in the trees with all the other elves." +
					" Trying not to think about it, you turn your gaze from the river before you resume your walk. You turn your head over your shoulder; the soulless reflection stares back at you with glistening eyes." +
					" You shake your head as you focus your mind on the road in front of you. The gentle trickle of water echoes behind you as the sound fades with distance." +
					"\n\nThe world around you already looks less colorful and happy. The grove, despite its corruption, is an oasis of love and happiness in the middle of the bleak desert of sadness that is Mareth. " +
					"It takes great effort from you not to turn back right away and give up, but you are determined to see this through, at least for now.");
			WoodElvesQuest = QUEST_STAGE_PCELF;
			player.createPerk(PerkLib.BlessingOfTheAncestorTree,0,0,0,0);
			player.removeAllRacialMutation();
			doNext(camp.returnToCampUseSixteenHours);
		}

		public function GroveLayout():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			if (WoodElvesQuest != QUEST_STAGE_PCCAMEBACK){
				outputText("You walk along the treeline following the way back to the elves as you last remember. You know you are nearing your destination as the familiar sound of running water as the river hits your ears before coming to view." +
						"You spot the giant tree resting in its clearing before you quickly advance to it. Memories flow through you as you caress its fine bark. A gentle vine stretches out, endearingly caressing you in reciprocation. Your memories guide you as you follow the river back and finally spot the elven houses. You walk on the gravel as a few curious glances turn your way. Their eyes glint with the sparkling green light bouncing off of their glance as the elves take notice of you one after the other." +
						"\n\nOut of nowhere, you are grabbed from behind as an elf gives you a surprise hug. You flinch softly at the vice-like grip, it's as if they never want to let go of you again. The elf gently loosens her grip as she looks into your eyes. Alyssa stares at you intently before gathering her words." +
						"\n\n\"<i>Sister [name]! You came back, we all thought you would get captured by demons or worse out there!</i>");
			if(player.elfScore() < 11 && player.woodElfScore() < 22) outputText("<i> Well... you did change a little, but that doesn't matter. You're still, and forever will be family!.</i>");
				outputText("\"" +
				"\n\nUnsurprisingly, Elenwen is not so far behind, a little confused." +
						"\n\n\"<i>Alyssa, what's going on? </i>");
				if(player.elfScore() < 11 && player.woodElfScore() < 22) outputText("<i>Who's this?</i>");
				outputText("<i> Wait, that's actually [name]?! You finally came home! Merisiel is going to be overjoyed!</i>\"" +
						"\n\nYou pause briefly; that's slightly concerning. You ask what happened with Merisiel." +
						"\n\n\"<i>Well, ever since you left she's been kind of depressed. She's constantly asking herself over and over if the memory incident was her fault. </i>");
				if(player.elfScore() < 11 && player.woodElfScore() < 22) outputText("<i> Doesn't matter if you've changed, t</i>");
				else outputText("<i>T</i>");
				outputText("<i>he mere fact that you are here despite everything is going to cheer her up.</i>\"" +
						"Before you know it, they organize a whole party just for you. Wine, food, and more discreet pleasures included. Perhaps coming back once in a while would be nice." +
						" You think out loud. It's just that you need time to yourself. Besides, if you spent all your time here there wouldn't be any time left for your quest." +
						"\n\nElenwen shrugs before replying to your statement. Guess you have been thinking out loud. \"<i>You're free to come and go. Besides that, you fighting to save the land is something we should be proud of. Who knows, you might even free the blessed tree eventually.</i>\"" +
						"\n\nFreeing the blessed tree uh… that might be something worth looking into. Regardless, you spend the few remaining hours with them and only leave at dusk promising not only to them but yourself that you will visit once in a while.");
				WoodElvesQuest = QUEST_STAGE_PCCAMEBACK;
				GroveLayout2(true);
			}
			else GroveLayout2();
		}


		///ELF VILLAGE SECTION///
		public function GroveLayout2(isFirstTime:Boolean = false):void {
			spriteSelect(SpriteDb.s_WoodElves);
			if (!isFirstTime)outputText("The elven village is at its usual calm today. Your sisters are playfully frolicking around in the grove. Sewing, swimming, playing music, or in some rare cases training with weapons in the small area dedicated to archery and more martial pursuits." +
					" This grove is a small oasis of innocence cut away from the rest of Mareth. The elves living their long hedonistic existence on a day-to-day basis without worry or fear." +
					"\n\nThe only stain amidst this beautiful scenery is the 'blessed' trees at the edge of this settlement, which reminds you all too well that if no one steps up and does the fighting, even this haven will eventually become corrupted and defiled beyond repair before disappearing from the face of Mareth. You try and keep your mind joyful however not to darken the light of day.");
			if (flags[kFLAGS.FACTORY_SHUTDOWN] > 0) outputText(" Well, what's left of it… it's hard to get any sun with those damn clouds covering the sky.");
			menu();
			addButton(0, "River", River);
			if ((player.elfScore() <=10 && player.woodElfScore() <=16)) addButtonDisabled(0,"River","You need to be an elf in order to go bath with the girls.");
			else if (!player.hasVagina()) addButtonDisabled(0,"River","You can't seriously go back naked with girls as a guy! Just what were you thinking, You degenerate pervert!?");
			addButton(1, "Tent", Tent);
			if ((player.elfScore() <=10 && player.woodElfScore() <=16)) addButtonDisabled(1,"Tent","You need to be an elf.");
			else if (!player.hasVagina()) addButtonDisabled(1,"Tent","You need to be female or herm in order to use the tents.");
			addButton(2, "Fletching table", Fletching);
			addButton(3, "Elenwen", Elenwen);
			if (hasTrainedToday) addButtonDisabled(3,"Elenwen","You need a break from your recent training before you can train again.");
		    else if (!player.isElf()) addButtonDisabled(3,"Elenwen","Elenwen has personal preferences in regards to the people she will train, maybe you should make yourself more elf like.");
			else if (!player.hasVagina()) addButtonDisabled(3,"Elenwen","Elenwen has personal preferences in regards to the people she will train with... it's not like archery is just for girls, but considering the fact that she's practicing naked...");
			addButton(4, "Alyssa", Alyssa);
			if (hasTrainedToday) addButtonDisabled(4,"Alyssa","You need a break from your recent training before you can train again.");
			else if (!player.isElf()) addButtonDisabled(4,"Alyssa","Alyssa has personal preferences in regards to the people she will train, maybe you should make yourself more elf like.");
			else if (!player.hasVagina()) addButtonDisabled(4,"Alyssa","Alyssa has personal preferences in regards to the people she will train with... it's not like the spear is a girl only discipline but the way she use it might as well be...");
			addButton(5, "Leave", camp.returnToCampUseOneHour);
		}

		public function River():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			if (!player.statStore.hasBuff("Sisterly bathing")) {
				outputText("You learned to love bathing in this stream during your days spent living with the Wood elves;" +
						" its clear, cool waters always left you feeling refreshed and clear-headed. More importantly," +
						" there was almost always someone else bathing there who was happy to have a little… fun." +
						" Today is no exception - with a smile you see that Merisiel has left her clothes and hunting gear by the banks and is splashing herself in the shallows," +
						" cleaning the mud and debris of the hunt from her cream-colored skin and luscious curves." +
						" You call out to her, already stripping your own gear, and she turns to you with a delighted expression and waves you over." +
						"\n\nIn a moment you are lovingly washing each other, running your hands over each other’s bodies and gently laving each other’s hair until the clean waters have you both sparkling." +
						" Then Merisiel takes you by the hand and leads you further into the river until you are up to your breasts in the stream. A bit further downstream the bank overhangs where a tree has grown into a little hillock cut through by the waters, creating a shaded area of calm, eddying water." +
						" There, the two of you relax, letting the water caress your naked forms. You giggle gleefully as you splash your face a bit, savoring the cool, bracing feeling.. You are free, at one with Mareth's beating heart; what could be better? As if to answer you, a stronger current errantly slides between your legs and rubs against your nethers," +
						" sending a chill of pleasure that travels up your spine. You blissfully sigh," +
						" enjoying the sensations against your soft, receptive skin, your entire body like a delicate instrument for nature to strum whimsically. A few fishes approach your naked form curiously, only to retreat back after staring for a few seconds, like little voyeurs afraid of being caught." +
						"\n\nNoticing your state of heightened arousal, Merisiel gives you a knowing grin and wades over to you. " +
						"\"<i>Need a little help, [name]? Perhaps we missed a spot earlier.</i>\"" +
						" With that she wraps an arm around your back and pulls you in for a kiss. Her sweet saliva tickles your senses as your tongues intertwine, and your own hands find their way to her bountiful," +
						" smooth breasts, eliciting a sweet breath to mark her approval. As you gently fondle her soft chest and hard, pink nipples - fully erect and beautifully sensitive from the cool water before you even started - she maneuvers her other hand down between your thighs and lightly caresses your labia," +
						" teasing and rubbing until your sex engorges and blooms like a perverted flower. Then, teasing your emerging clitoris with a flexible thumb, she inserts first one, then another, then a third of her long, slender fingers into your hot, wet tunnel. You moan in pleasure," +
						" leaning away from her as your back arches involuntarily. Then, acclimated to the stimulation, you exchange a loving gaze with her and begin working her face once more," +
						" kissing slowly up her neck and chin, nibbling and tugging at her full, pink lips, and then with a playful giggle hoisting yourself up on her shoulders, the water supporting you both, and nibbling and licking at her long, pointed ears." +
						"\n\nShe gasps and laughs at your playful assault and redoubles her own, bending her fingers to stimulate your folds as you contract your pussy around them, and for a moment the two of you playfully wrestle in upright in the water," +
						" each trying to pleasure the other more, until with a little shriek Merisiel tumbles back into the water with a splash, taking you with her." +
						"\n\nThe two of you stand back up, laughing at each other, faces flush from arousal and the shock of the cool water, and then with a sweet smile Merisiel leads you to a shallower spot, where the two of you sit facing each other." +
						"\"<i>Mmmmm… that was fun, [name], but I want something a bit more intimate from my cute little sister. You don’t mind, do you?</i>\"" +
						"You certainly do not, you tell her, and she lifts one of your legs to scoot her hips closer to you until you are wrapped around each other," +
						" and in the cool water you feel the hot, slippery sensation of her pink, hairless elven pussy pressing against your own." +
						" You wrap your arms around each other for a moment, pulling each other close and simply savoring the warm, snuggly feeling of your bodies and pussies pressed together." +
						" Then Merisiel kisses you again and begins slowly gyrating her hips, up and down, slowly rubbing her lips and clitoris against yours." +
						"\n\nYour already well-stimulated pussy quivers at the warm, slippery feeling of her lips stroking against yours, and soon you’re moaning in pleasure as you move your hips with hers in a comfortable rhythm," +
						" each of you seeking to match the other and maximize your shared sensations. All the while Merisiel continues to kiss you, sometimes pressing her soft, pink tongue into your mouth and wrapping it around yours," +
						" other times nibbling and sucking at your lips. Sometimes she breaks the kiss to give a heavy, sweet breath as her own pleasure mounts, meeting your eyes with her own rich, green ones in a loving gaze before showering you with tiny," +
						" affectionate kisses on your forehead, cheeks, and lips, only to redouble her grinding as she once more invades your mouth passionately." +
						"\n\nYou lose track of time as the two of you indulge each other’s bodies, grinding and caressing and kissing and gasping and moaning," +
						" until finally it becomes too much to endure. Merisiel cums first; she gives a shuddering little gasp and her eyes open wide as she arches her back away from you," +
						" her hips bucking against yours. Grinning, you take the chance to grab her puffy, pink nipples and give them a firm tweak, shocking her into an even larger orgasm in the middle of her original," +
						" and she cries out and bucks your hips against yours as she spasms in ecstasy. Her impassioned cries and the movement of her hips pushes you over the edge as well, and as your strength givers over to pleasure Merisiel pulls you down on top of her," +
						" and the two of you ride out your orgams with your upper bodies resting on the bank of the little sheltered pool, Merisiel gazing up at the tree roots above while you rest your head against her pillowy breasts." +
						" The two of you lay there cuddling for a few moments, enjoying the afterglow as the gentle currents and eddies of the pool wash your lower halves clean again." +
						" Merisiel gives you a loving little squeeze, pressing you even harder into her chest." +
						"\n\n\"<i>Mmmmm… that was <b>wonderful</b>, little [name]... thank you. I’m glad we ran across each other; my day just doesn’t feel right without spending some time with my adorable little sister.</i>\"" +
						" You respond by planting a kiss on her sternum and nuzzling even more snugly between her perfect tits. Her warmth and softness, the cool, peaceful water, the sounds of the river, and your relaxed," +
						" synchronized breathing as she lovingly embraces and supports you soon have you drifting into a blissful sleep, but before your world goes totally dark she gently rouses you with a hand, gently petting your head and neck to keep you just away from sleep." +
						"\n\n\"<i>Ahhhh, you’re such a good, sweet girl, [name],</i>\" she coos softly into your sensitive ear." +
						"\"<i>You know I’d love nothing more than to let you nap on top of me, but I do have other things to do today, and I’m sure you do as well. Go on, return to your duties as Champion, and I’ll continue my work. We can always have a nice nap together - and other things, hee hee - some other time.</i>\"" +
						"You drowsily agree, and stand yourself up despite the protest of your body against leaving its blissful perch on top of the lovely Elf woman. You offer her a hand and she gracefully pulls herself up as well," +
						" and the two of you share one more sweet kiss before you wade back to your equipment and prepare to continue your day.");
				player.sexReward("vaginalFluids", "Vaginal");
				player.sexReward("vaginalFluids", "Vaginal");
				player.sexReward("vaginalFluids", "Vaginal");
				player.sexReward("vaginalFluids", "Vaginal");
				player.sexReward("vaginalFluids", "Vaginal");
				player.trainStat("lib", +1, 80);
				player.trainStat("lib", +1, 80);
				player.trainStat("lib", +1, 80);
				player.trainStat("lib", +1, 80);
				CoC.instance.timeQ = 1;
				player.buff("Sisterly bathing").addStats({int:20,wis:20}).withText("Sisterly bathing").forDays(1);
			} else {
				outputText("You approach the clear, spritely waters of the stream that runs through the elven Village to clean yourself off again." +
						" There are a few elves enjoying themselves nearby, but they seem very focused on each other and their pleasures," +
						" and you still have things to do, so you opt to leave them be and simply enjoy the cool, refreshing water as it washes you clean of" +
						" the sweat and grime you’ve accumulated. The gasps and cries of your sisters upstream leave you feeling a little aroused, but you" +
						" resist the urge to join them, for now; you can always find another release later, when you’re a little less busy.")
				player.dynStats("lus",+30);
			}
			doNext(camp.returnToCampUseOneHour);
		}

		public function Tent():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("This tent only really gets used for one thing, and it’s just what you want right now. Alyssa and Elenwen notice you entering, and you smile as they glance at each other and leave off their work to follow you in." +
					" Before long, the three of you are stripped naked and laying together on the bed, already feeling each other up and preparing for the fun you’re about to have." +
					"\n\n\"<i>This brings back memories, doesn’t it, [name]?</i>\"says Elenwen, smiling nostalgically." +
					"\n\n\"<i>I… I hope they’re good ones…</i>\" Alyssa says, with a hint of guilt or nervousness in your voice. Considering the circumstances of your \"welcome\" here that’s understandable, but you smile at the dainty Elf and pull her into an embrace, assuring her that you have no regrets about how things went that day. She smiles and gives you a kiss." +
					"\n\n\"<i>Hey, I’m here too!</i>\" Elenwen interjects, pouting. \"<i>Don’t just create a mood between the two of you.</i>\"" +
					"\n\nShe punctuates her teasing complaint by nibbling at the sensitive tips of your pointy ears, just as she always does. Not one to just watch, Alyssa begins licking and cleaning your left breast with her soft, pink tongue." +
					" Elenwen moves from your eartip, licking a delightful trail to your neck and taking hold of your mouth before gently kissing you. Perhaps moved by their memories of that first sweet meeting, they’re retracing their old movements to pleasure you," +
					" but this time you’re not a confused, amnesiac neophyte, and you match their loving attacks with your own. Soon the three of you are a tangled, gasping mess on the pillows, hands and tongues gently exploring each other’s sensitive places and rewarding each other with sweet moans and breathy sighs." +
					"\n\n\"<i>Ah, this is heaven, little sister. I’m so glad you decided to accept us<b>~♥</b></i>\"" +
					" says Alyssa between the cute noises she makes as you finger her stiff little clit, poking out like a red berry from her pink, hairless slit. She gives you a passionate kiss and grinds her hips against your hand, seeking even deeper pleasure, and Elenwen gives you both an exasperated sigh." +
					"\n\n\"<i>Alright you lovers, I see how it’s going to be.</i>\"" +
					" she says chidingly in a voice that can’t hide her affection. " +
					"\"<i>In that case, let’s get you set up properly.</i>\"" +
					" She reaches over to the end of the bed and retrieves a familiar golden-green object, twelve inches long, gently curved, and rounded at the ends. " +
					"\"<i>You remember this toy, don't you little sister? It's the one we used when we first met, crafted from the very sap of the sacred tree itself. Come on, I know you two want to use it; why hold back?</i>\"" +
					"\n\nYou find yourself fixated on it, and glancing away for a moment you see Alyssa is as well. After a few seconds she turns back to face you, her flushed cheeks inches from yours. " +
					"\"<i>Um… [name]... I want to-</i>\"" +
					" You don’t let her finish, instead grabbing her cheeks and pulling her in for another kiss. Elenwen chuckles at the two of you and brings the toy to Alyssa’s tight snatch first." +
					"\n\n\"<i>Well, look at you, Alyssa, all ready to go with no delay!</i>\"" +
					" she says teasingly, slipping the toy inside her sister and twisting it around a bit before sliding it halfway in. Alyssa moans pleasurably into your mouth as the toy slides home. " +
					"\"<i>Okay, okay, Alyssa, you have to sit up now, or you’ll never get the other end in. Besides,</i>\"" +
					" she adds, fingering her own dripping pussy with her free hand, " +
					"\"<i>[name]’s going to need that mouth of hers free, so big sister Elenwen doesn’t feel left out.</i>\"" +
					"\n\nAlyssa nods, blushing and biting her lower lip as she tries to endure the pleasure of the toy filling her. She rears up until she is straddling you, and you see the remaining six inches of the toy protruding from her glistening lips, twitching almost like a real cock as her pleasured spasms move it up and down." +
					" Elenwen uses a hand to guide the tip to your own hungry opening. " +
					"\"<i>H-here I come, [name]...</i>\"" +
					" she squeaks as she pushes her slender hips forward, penetrating you in a smooth motion. You gasp and buck your hips at the pleasure of the insertion, and soon the two of you are grinding against each other, moaning in tandem as you seek pleasure from the stiff, warm rod joining you. Your combined juices froth and drip down from your pussies where they rub together, already soaking the bed below." +
					"\n\n\"<i>Oh my, isn’t that nice<b>~♥</b></i>\"" +
					" says Elenwen, gazing in mock admiration at your lewd coupling, though her face is just as red as Alyssa’s. " +
					"\"<i>But don’t forget big sister Elenwen, little [name], or I’ll be sad.</i>\"" +
					" So saying she crawls up until her face is just above yours and gives you a kiss; just a light peck on the lips, followed by a smile that takes on a teasing look from her almond-shaped," +
					" slanting eyes. Then she lifts herself up and straddles your face, her dripping pussy directly over your mouth. " +
					"\"<i>If you would be so kind, little sister, I’d love it if you’d take care of me down there with your cute little mouth<b>~♥</b></i>\"" +
					"\n\nYou need no further exhortation, quickly bringing your lips to hers and tending to her heeds as Alyssa continues to grind ecstatically against you." +
					" Soon Elenwen’s happy moans join the two of yours as you pleasure her clit and her sensitive lips with your tongue and teeth," +
					" gently but energetically licking, prodding, and nibbling until she is squirming above you, trying to contain her pleasure enough to keep her mounted above you." +
					"With the three of you finally positioned it doesn’t take long to climax. Alyssa, seeking greater pleasure," +
					" adds a bouncing movement to her grinding, her moans escalating to cries of pleasure." +
					" Moved by the increased sensation you redouble your efforts on Elenwen’s flooded pussy; you push your tongue as far as it will go inside her to lick her hot, wet folds," +
					" while rubbing her stiff clit with your upper lip and teeth. Elenwen gasps and moans, her own hands rubbing her ample breasts and squeezing her stiff, cherry-colored nipples as she builds toward her orgasm." +
					" Alyssa’s movements cause her own cute palm-sized tits to bounce up and down, and she reaches down to fondle your breasts, trying generously to bring you to a simultaneous orgasm with her. Elenwen comes first;" +
					" a flood of her salty-sweet girl juice sprays onto you and she cries out, arching back until her head is below Alyssa’s. Alyssa slams her hips into yours a few more times and cums next, crying out and kissing her sister," +
					" their heads meeting from opposite ends of your body in a triangle of bodies, and Alyssa’s final thrusts and twitching, flooding pussy rubbing against yours work to finish you off third." +
					" You cry out and buck your hips upward against Alyssa’s and grab Elenwen’s hips to steady yourself as you thrash from a deep, full-body orgasm. Finally the three of you come down and collapse on each other," +
					" shuffling until the two beautiful elves have you sandwiched between them on the pillows." +
					"\n\nAlyssa gazes at you with her big, green eyes, her cute face twisted and flushed with pleasure." +
					"\"<i>Mmmmm… that was wonderful, [name]. You’re the best little sister I could have asked for.</i>\"" +
					" She snuggles closer against you, hugging your arm to her little breasts and wrapping a slender thigh around you." +
					"\n\n\"<i>I agree,</i>\"" +
					" says Elenwen, doing similarly, her twin melons embracing your upper arm as she wraps a curvaceous thigh around you, topping Alyssa’s. " +
					"\"<i>You did wonderfully. I hope it was as good for you as it was for us.</i>\"" +
					" Her slanted eyes are filled with tender affection." +
					"\n\nYou can only bring yourself to nod as the three of you drift into an exhausted but happy slumber," +
					" snuggled against each other in the tent. An hour later you awaken. Elenwen seems to have awoken first and left." +
					" Alyssa is still asleep, hugging you. You give her a gentle kiss on her large forehead and carefully extract yourself to avoid waking her." +
					" She mumbles a bit in her sleep as your warmth leaves her, but remains there as you dress yourself and exit the tent to continue your day.");
			player.sexReward("vaginalFluids", "Vaginal");
			player.sexReward("vaginalFluids", "Vaginal");
			player.sexReward("vaginalFluids", "Vaginal");
			player.sexReward("vaginalFluids", "Vaginal");
			player.sexReward("vaginalFluids", "Vaginal")
			player.trainStat("lib", +1, 80);
			CoC.instance.timeQ = 1;
			doNext(camp.returnToCampUseOneHour);
		}

		public function Fletching():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			if (!player.hasStatusEffect(StatusEffects.FletchingTable)) player.createStatusEffect(StatusEffects.FletchingTable,0,0,0,0);
			outputText("You approach the fletching table. Here you can craft improved arrows using elven tools.");
			menu();
			addButton(1, "CraftArrows", FletchingCraftArrows);
			addButton(2, "AdjustString", FletchingAdjustString);
			addButton(3, "Reinforce", FletchingReinforce);
			addButton(14, "Back", GroveLayout);
		}

		public function FletchingCraftArrows():void {
			outputText("What kind of arrows would you like to create?");
			menu();
			if (player.hasItem(useables.IARROWHEAD, 1)) addButton(0, "Iron", FletchingCraftArrows2, "iron", 1).hint("Use iron arrowheads to craft arrows.");
			if (player.hasItem(useables.MARROWHEAD, 1)) addButton(1, "Moonstone", FletchingCraftArrows2, "moonstone", 2).hint("Use moonstone arrowheads to craft arrows.");
			if (player.hasItem(useables.SARROWHEAD, 1)) addButton(2, "Skymetal", FletchingCraftArrows2, "skymetal", 3).hint("Use skymetal arrowheads to craft arrows.");
			if (player.hasItem(useables.EARROWHEAD, 1)) addButton(3, "Ebonbloom", FletchingCraftArrows2, "ebonbloom", 4).hint("Use ebonbloom arrowheads to craft arrows.");
			//Moonstone(Obtained by mining at night) +20 % Damage
			//Skymetal(Found in glacial rift) +30% Damage
			addButton(14, "Back", Fletching);
		}
		private function FletchingCraftArrows2(itype:String, type:Number):void {
			outputText("You work for 8 hours crafting a full quiver of " + itype + " arrows. Those will serve you well in your adventures.");
			if (!player.hasPerk(PerkLib.CraftedArrows)) player.createPerk(PerkLib.CraftedArrows,0,0,0,0);
			switch (type) {
				case 1:
					player.destroyItems(useables.IARROWHEAD, 1);
					player.addPerkValue(PerkLib.CraftedArrows, 1, 100);
					break;
				case 2:
					player.destroyItems(useables.MARROWHEAD, 1);
					player.addPerkValue(PerkLib.CraftedArrows, 2, 100);
					break;
				case 3:
					player.destroyItems(useables.SARROWHEAD, 1);
					player.addPerkValue(PerkLib.CraftedArrows, 3, 100);
					break;
				case 4:
					player.destroyItems(useables.EARROWHEAD, 1);
					player.addPerkValue(PerkLib.CraftedArrows, 4, 100);
					break;
			}
			doNext(camp.returnToCampUseEightHours);
		}

		public function FletchingAdjustString():void {
			outputText("You may choose a different sturdier string for your bow. What would you use?");
			menu();
			if (player.statusEffectv2(StatusEffects.FletchingTable) > 0) addButtonDisabled(0, "SpiderSilk", "You already used this for improving bow string.");
			else {
				if (player.hasItem(useables.T_SSILK, 1)) addButton(0, "SpiderSilk", FletchingAdjustString2, useables.T_SSILK);
				else addButtonDisabled(0, "SpiderSilk", "You need spider silk.");
			}
			if (player.statusEffectv2(StatusEffects.FletchingTable) > 1) addButtonDisabled(1, "Ebonbloom", "You already used this for improving bow string.");
			else {
				if (player.hasItem(useables.EBONBLO, 1)) {
					if (player.statusEffectv2(StatusEffects.FletchingTable) < 1) addButtonDisabled(1, "Ebonbloom", "You need to improve string with spider silk first.");
					else addButton(1, "Ebonbloom", FletchingAdjustString2, useables.EBONBLO);
				}
				else addButtonDisabled(1, "Ebonbloom", "You need ebonbloom.");
			}
			if (player.statusEffectv2(StatusEffects.FletchingTable) > 2) addButtonDisabled(2, "UnicornHair", "You already used this for improving bow string.");
			else {
				if (player.hasItem(useables.UNICORNH, 1)) {
					if (player.statusEffectv2(StatusEffects.FletchingTable) < 2) addButtonDisabled(2, "UnicornHair", "You need to improve string with ebonbloom first.");
					else addButton(2, "UnicornHair", FletchingAdjustString2, useables.UNICORNH);
				}
				else addButtonDisabled(2, "UnicornHair", "You need unicron hair.");
			}
			addButton(14, "Back", Fletching);
		}
		private function FletchingAdjustString2(itype:ItemType):void {
			outputText("You work for 8 hours adjusting your new " + itype.shortName + " string to your bow. This will serve you well in your adventures.");
			player.addStatusValue(StatusEffects.FletchingTable, 2, 1);
			player.destroyItems(itype, 1);
			doNext(camp.returnToCampUseEightHours);
		}

		public function FletchingReinforce():void {
			outputText("You may choose to reinforce your bow using various materials. What would you use?");
			menu();
			if (player.statusEffectv1(StatusEffects.FletchingTable) > 0) addButtonDisabled(0, "Bronze", "You already used this for reinforcing bow.");
			else {
				if (player.hasItem(useables.BRONZEB, 1) || Crafting.BagSlot03 > 0) addButton(0, "Bronze", FletchingReinforce2, useables.BRONZEB, 1);
				else addButtonDisabled(0, "Bronze", "You need bronze bar.");
			}
			if (player.statusEffectv1(StatusEffects.FletchingTable) > 1) addButtonDisabled(1, "Iron", "You already used this for reinforcing bow.");
			else {
				if (player.hasItem(useables.IRONORE, 1) || Crafting.BagSlot04 > 0) {
					if (player.statusEffectv1(StatusEffects.FletchingTable) < 1) addButtonDisabled(1, "Iron", "You need to reinforce bow with bronze first.");
					else addButton(1, "Iron", FletchingReinforce2, useables.IRONORE, 2);
				}
				else addButtonDisabled(1, "Iron", "You need iron ore.");
			}
			if (player.statusEffectv1(StatusEffects.FletchingTable) > 2) addButtonDisabled(2, "Moonstone", "You already used this for reinforcing bow.");
			else {
				if (player.hasItem(useables.MOONSTO, 1) || Crafting.BagSlot07 > 0) {
					if (player.statusEffectv1(StatusEffects.FletchingTable) < 2) addButtonDisabled(2, "Moonstone", "You need to reinforce bow with iron first.");
					else addButton(2, "Moonstone", FletchingReinforce2, useables.MOONSTO, 3);
				}
				else addButtonDisabled(2, "Moonstone", "You need moonstone.");
			}
			if (player.statusEffectv1(StatusEffects.FletchingTable) > 3) addButtonDisabled(3, "EbonIng", "You already used this for reinforcing bow.");
			else {
				if (player.hasItem(useables.EBONING, 1) || Crafting.BagSlot06 > 0) {
					if (player.statusEffectv1(StatusEffects.FletchingTable) < 3) addButtonDisabled(3, "EbonIng", "You need to reinforce bow with moonstone first.");
					else addButton(3, "EbonIng", FletchingReinforce2, useables.EBONING, 4);
				}
				else addButtonDisabled(3, "EbonIng", "You need ebon ingot.");
			}
			//Moonstone(Obtained by mining at night) +30 % Damage
			//Divine Ice(Requires Divine ice, found in glacial rift) +50% Damage
			//Orichalcum(Found in deep sea) +60% Damage
			//Skymetal(Found in End game zone) +70% Damage
			addButton(14, "Back", Fletching);
		}
		private function FletchingReinforce2(itype:ItemType, type:Number):void {
			outputText("You work for 8 hours applying your new " + itype.shortName + " reinforcement to your bow. This will serve you well in your adventures.");
			player.addStatusValue(StatusEffects.FletchingTable, 1, 1);
			switch (type) {
				case 1:
					if (Crafting.BagSlot03 > 0) Crafting.BagSlot03 -= 1;
					else player.destroyItems(itype, 1);
					break;
				case 2:
					if (Crafting.BagSlot04 > 0) Crafting.BagSlot04 -= 1;
					else player.destroyItems(itype, 1);
					break;
				case 3:
					if (Crafting.BagSlot07 > 0) Crafting.BagSlot07 -= 1;
					else player.destroyItems(itype, 1);
					break;
				case 4:
					if (Crafting.BagSlot06 > 0) Crafting.BagSlot06 -= 1;
					else player.destroyItems(itype, 1);
					break;
			}
			doNext(camp.returnToCampUseEightHours);
		}

		//unused
		/*
		//Elenwen is nearly as skilled as Kindra, but is very picky on who she teaches to. Better be an elf. Also her training is slower as she tends to fool around.
		private function bowSkill(diff:Number):Number {
			player.addStatusValue(StatusEffects.Kelt,1,diff);
			if (player.statusEffectv1(StatusEffects.Kelt) >= 100) player.changeStatusValue(StatusEffects.Kelt,1,100);//Kelt track basic archery skill that caps on 100 not 150 so not need to thanks me for fixing too high cap on this training ;)
			return player.statusEffectv1(StatusEffects.Kelt);
		}
		*/

		public function Elenwen():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("At the archery range, you find Elenwen practicing with her bow. Her posture is poised and masterful as she aims at a target before nocking an arrow." +
					" She releases the arrow in a single smooth motion that leaves her long, golden hair fluttering. The arrow flies directly into the center of her mark," +
					" joining several other perfect shots on the many targets that surround her. Her demeanor is serious and focused," +
					" a far cry from her usual teasing, seductive attitude when you and Alyssa are together with her." +
					" You walk up to her before asking if she would be willing to train you in Elven archery techniques." +
					"\n\n\"<i>Ah, little sister, of course! I’m delighted that you asked,</i>\" she replies, fixing you with her slanted eyes. \"<i>Come on over and we’ll see what you can do.</i>\"" +
					"\n\nUnder her guidance, you spend some time firing at targets, as well as fruits in trees dotted about the range." +
					" She gently corrects your posture with her long, elegant fingers, pushing and pulling on your limbs and torso." +
					" It reminisces of her usual playful touching, but her body language and sheer focus give you a different thought." +
					"\n\nToward the end of your training, however, she begins taking a somewhat more teasing attitude." +
					" As your posture becomes consistent enough that she no longer needs to correct it often," +
					" she starts lightly brushing your sensitive places with her hands or nibbling at your ears just as you are taking aim," +
					" causing you to blush and jerk with the sensation." +
					"\n\nWhen you complain about the sudden change in her behavior, she replies, teasingly, " +
					"\"<i>[name] dear, if my teasing is enough to disrupt your posture, how do you intend to shoot accurately against demons using eromancy? Your focus needs to be perfect no matter what pain or pleasure you’re in. Be it from movement, wind against your form or facing one to many foes.</i>\"" +
					"You can’t deny that she has a point, but her playful attacks have got your blood so hot that Elenwen is starting to make you want to drop the bow and work on her instead." +
					" Oh well, all work and no play makes a dull Champion, right?" +
					"\n\nJust as she leans in to brush her fingers against your sensitive breasts again," +
					" you drop your bow and grab her hands, earning a satisfying cute squeak of surprise from your teasing elder sister." +
					" Using her as leverage to spin around in her arms, you plant a kiss on her lips and press your hands into the soft," +
					" yielding curves of her ample rear." +
					" She moans in arousal under your sudden turnabout but quickly recovers and pulls away from the kiss." +
					" \"<i>Oh, playing dominant now are we, [name]? Let’s see how long you can keep that up~♥</i>\"" +
					"\n\nHer hand drifts down your body as she speaks, sliding ");
					if (player.armor == ArmorLib.NOTHING) outputText("down to your glistening slit");
					else outputText("under your equipment to your glistening slit");
			outputText(" to give you a loving stroke, ending in her finger rubbing on your stiff, sensitive button." +
					" You gasp at the stimulation but manage to retaliate by slipping a hand under her white dress to prod at her lips as well." +
					" The two of you continue briefly, moaning pleasurably and bucking your hips against each other's hands as you kiss and gently nibble at each other's lips," +
					" but then Elenwen takes her hand from your dripping snatch and lightly pulls your hand from hers." +
					"\n\n\"<i>Mmm.... that was fun, sweet little sister, but we should get back to work. If you can manage to hit a bullseye as excited as you are now, I’ll be satisfied with your practice for today. Then, if you want, we can continue this later~♥</i>\"" +
					"\n\nYou nod, a bit disappointed at being cut off before climax, and take up your bow again. After several tries, you ");
			if (player.statusEffectv1(StatusEffects.Kelt) <= 100) outputText("manage to make a shot Elenwen considers fair for her standards.");
			if (player.statusEffectv1(StatusEffects.Kelt) >= 100) outputText("hit a bullseye, and Elenwen praises your efforts before you say your goodbyes.");
			outputText("\n\nAs you leave for your camp Elenwen waves at you with a \"<i>See you later, sister. We can do something more fun next time~♥</i>\"" +
					" With a hint of regret, you wave and head back home, seriously considering taking her up on the offer before the day is up.");
			player.trainStat("tou", +1, 50);
			player.trainStat("tou", +1, 50);
			player.trainStat("tou", +1, 50);
			player.trainStat("tou", +1, 50);
			player.trainStat("spe", +1, 100);
			player.trainStat("spe", +1, 100);
			player.trainStat("spe", +1, 100);
			player.trainStat("spe", +1, 100);
			player.trainStat("int", +1, 80);
			player.trainStat("int", +1, 80);
			player.trainStat("int", +1, 80);
			player.trainStat("int", +1, 80);
			if (player.spe >= 50 && player.statusEffectv1(StatusEffects.Kelt) >= 25 && WoodElfBowTraining == QUEST_STAGE_BOWTRAINING0 && !hasTrainedToday){
				WoodElfBowTraining = QUEST_STAGE_BOWTRAINING1;
				outputText("\n\nThanks to your extensive training in elven archery you have unlocked the Pin down ability! <b>Gained P.Ability: Pin Down</b>");
				hasTrainedToday = true;
				hasTrainedTodayCooldown = 24;
			}
			else if (player.spe >= 100 && player.statusEffectv1(StatusEffects.Kelt) >= 50 && WoodElfBowTraining == QUEST_STAGE_BOWTRAINING1 && !hasTrainedToday){
				WoodElfBowTraining = QUEST_STAGE_BOWTRAINING2;
				outputText("\n\nThanks to your extensive training in elven archery you have unlocked the Elven Eye ability! <b>Gained P.Ability: Elven Eye</b>");
				hasTrainedToday = true;
				hasTrainedTodayCooldown = 24;
			}
			else if (player.spe >= 150 && player.statusEffectv1(StatusEffects.Kelt) >= 100 && WoodElfBowTraining == QUEST_STAGE_BOWTRAINING2 && !hasTrainedToday){
				WoodElfBowTraining = QUEST_STAGE_BOWTRAINING3;
				player.createPerk(PerkLib.ELFMasterShot,0,0,0,0);
				outputText("\n\nThanks to your extensive training in elven archery you have unlocked the Master Shot Perk! <b>Gained Perk: Master Shot</b>");
				hasTrainedToday = true;
				hasTrainedTodayCooldown = 24;
			}
			else if (player.spe >= 200 && player.statusEffectv1(StatusEffects.Kelt) >= 150 && WoodElfBowTraining == QUEST_STAGE_BOWTRAINING3 && !hasTrainedToday){
				WoodElfBowTraining = QUEST_STAGE_BOWTRAINING4;
				player.createPerk(PerkLib.ELFArcherCovenant,0,0,0,0);
				outputText("\n\nThanks to your extensive training in elven archery you have unlocked the Archer Covenant Perk! <b>Gained Perk: Archer Covenant</b>");
				hasTrainedToday = true;
				hasTrainedTodayCooldown = 24;
			}
			else{
				hasTrainedToday = true;
				hasTrainedTodayCooldown = 24;
			}
			if (!player.hasStatusEffect(StatusEffects.Kelt)) player.createStatusEffect(StatusEffects.Kelt, 5, 0, 0, 0);
			else player.addStatusValue(StatusEffects.Kelt, 1, 5);
			CoC.instance.timeQ = 1;
			doNext(camp.returnToCampUseOneHour);
		}

		public function Alyssa():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("On the sparring grounds, you find Alyssa practicing her spear technique." +
					" She moves elegantly, alternating between smooth, dance-like footwork with broad sweeps and twirls of her long spear and sharp," +
					" snapping thrusts that seem to pierce the air itself. She is naked, and her petite, slender frame seems to emanate vitality and grace" +
					" in a way that feels almost pure, very unlike the typical atmosphere of corruption that permeates the Elven Village." +
					" You approach her and ask her if she would be willing to train you in Elven spearwomanship." +
					" She pauses her exercises and wipes her brow before smiling at you and replying. " +
					"\"<i>Of course, little sis! Let’s dance together!</i>\"");
			if (WoodElfSpearTraining == QUEST_STAGE_SPEARTRAININGFIRST){
				if (player.armor == ArmorLib.NOTHING) outputText("\n\nShe looks approvingly at your lack of clothing, not with her standard expression of perverted lust but with a serious glance.");
				else outputText("\n\nHer first instruction is to strip. Unlike her usual, somewhat perverted expression when she says that, she appears serious.");
				WoodElfSpearTraining = QUEST_STAGE_SPEARTRAINING0;
			}
			outputText("\n\n\"<i>Remember, [name], we Elves are fundamentally spiritual creatures. Elves do not fight with strength but rather by listening to the voices around us. Elves become one with the voices of the wind and the forest. To do that, you have to be able to feel the air around you, and the easiest way to learn to do that is, well, to have nothing between you and it. Once you’re confident with your abilities, you can wear clothes, but beginners must always learn naked. I still practice that way, as you can see.</i>\"" +
					"\n\nWith that, you take up a practice spear and begin training your posture and movements." +
					" Alyssa alternates between watching you and correcting your posture with her hands." +
					" Though she constantly tells you not to force your movement in favor of feeling where the wind is directing you," +
					" you still find yourself flushed and sweating from the exertion. As she directs your form," +
					" you can't help but relish her soft, warm fingers gently adjusting your limbs and torso are very arousing." +
					"\n\n\"<i>You’re doing well, [name]!</i>\"" +
					"she cheerfully states. Though, you feel as if you’ve done nothing but mess up. Alyssa continues, " +
					"\n\n\"<i>It is always hard for a young elf to learn to let go and listen to the spirits, but I can see your movements getting more refined and natural even after a few hours. Keep it up and you’ll be dancing with the best of us!</i>\"" +
					"\n\nAs she says this, she corrects your posture from behind. Her movements are professional and intentional," +
					" but even so, you feel her small palm-sized breasts and stiff pink nipples pressing into your back." +
					" After all of that stimulation and with your already accelerated pulse, the sensation is too much." +
					"Every fiber of your being tells you to drop your spear and turn around. You can imagine grabbing her and pulling " +
					"her to the ground on top of you, pulling her in for a kiss as you wrap your arms around her." +
					"\n\nAlyssa speaks up \"<i>Hey, lil sis, try to focus. We can worry about... other forms of training later, but for now I'm your instructor.</i>\"" +
					"\n\nYou feel yourself blushing as she speaks up, redirecting your attention, " +
					"\"<i>Let’s try a different stance, shall we?</i>\" She spins you around to face her." +
					"\n\nShe pulls you closer to her with her delicate fingers. Wasting no time, you begin kissing her soft lips, pulling her face closer to yours." +
					" She reaches a hand down to your nethers," +
					" gently prodding at your clit, slowly rubbing it in gentle, circular motions." +
					"\n\nYou clamp reflexively, but she hasn't dipped any fingers into your nethers. You give a slight whine of protest in the passionate kiss before Alyssa breaks the embrace." +
					"\n\n\"<i>We still have to a little left to practice, [name]</i>\" she states, stepping away. \"<i>Besides, a bit of arousal can actually make it easier to feel the spirits. Still,</i>\"" +
					" she adds, \"<i>you can always come and find me later. We can go all the way whenever you want. You know I’m always looking forward to it.</i>\"" +
					"\n\nShe gives you a gentle peck on the lips before turning and picking up her training spear to continue her practice." +
					"The two of you practice for a few more minutes before she nods respectfully, " +
					"\"<i>I hope you now feel more comfortable about handling an Elven spear.</i>\"" +
					"\n\nAs you leave, waving goodbye, the kiss resonates with you, perhaps there are many ways to think about how to handle melee combat.");
			player.trainStat("str", +1, 80);
			player.trainStat("str", +1, 80);
			player.trainStat("str", +1, 80);
			player.trainStat("str", +1, 80);
			player.trainStat("spe", +1, 100);
			player.trainStat("spe", +1, 100);
			player.trainStat("spe", +1, 100);
			player.trainStat("spe", +1, 100);
			player.trainStat("tou", +1, 80);
			player.trainStat("tou", +1, 80);
			player.trainStat("tou", +1, 80);
			player.trainStat("tou", +1, 80);
			CoC.instance.timeQ = 1;
			if (player.spe >= 50 && WoodElfSpearTraining == QUEST_STAGE_SPEARTRAINING0 && !hasTrainedToday){
				WoodElfSpearTraining = QUEST_STAGE_SPEARTRAINING1;
				player.createPerk(PerkLib.ELFElvenSpearDancingFlurry1to4,1,0,0,0);
				outputText("\n\nThanks to your extensive training in elven spear techniques you have unlocked the Elven Spear Dancing Flurry! <b>Gained Perk:Elven Spear Dancing Flurry</b>");
				hasTrainedToday = true;
				hasTrainedTodayCooldown = 24;
			}
			else if (player.spe >= 100 && WoodElfSpearTraining == QUEST_STAGE_SPEARTRAINING1 && !hasTrainedToday){
				WoodElfSpearTraining = QUEST_STAGE_SPEARTRAINING2;
				player.createPerk(PerkLib.ELFElvenBattleStyle,0,0,0,0);
				player.setPerkValue(PerkLib.ELFElvenSpearDancingFlurry1to4,1,2);
				outputText("\n\nThanks to your extensive training in elven spear techniques you have unlocked the Elven Battle Style and Elven Spear Dancing Flurry II Perk! <b>Gained Perk: Elven Battle Style and Elven Spear Dancing Flurry II</b>");
				hasTrainedToday = true;
				hasTrainedTodayCooldown = 24;
			}
			else if (player.spe >= 150 && WoodElfSpearTraining == QUEST_STAGE_SPEARTRAINING2 && !hasTrainedToday){
				WoodElfSpearTraining = QUEST_STAGE_SPEARTRAINING3;
				player.setPerkValue(PerkLib.ELFElvenSpearDancingFlurry1to4,1,3);
				outputText("\n\nThanks to your extensive training in elven spear techniques you have unlocked the Spear Dancing Flurry III Perk! <b>Gained Perk: Elven Spear Dancing Flurry III</b>");
				hasTrainedToday = true;
				hasTrainedTodayCooldown = 24;
			}
			else if (player.spe >= 200 && WoodElfSpearTraining == QUEST_STAGE_SPEARTRAINING3 && !hasTrainedToday){
				WoodElfSpearTraining = QUEST_STAGE_SPEARTRAINING4;
				player.createPerk(PerkLib.ELFElvenSpearDancingTechnique,0,0,0,0);
				player.setPerkValue(PerkLib.ELFElvenSpearDancingFlurry1to4,1,4);
				outputText("\n\nThanks to your extensive training in elven spear techniques you have unlocked the Elven Spear Dancing Technique and Elven Spear Dancing Flurry IV Perk! <b>Gained Perk: Spear Dancing Technique and Elven Spear Dancing Flurry IV</b>");
				hasTrainedToday = true;
				hasTrainedTodayCooldown = 24;
			}
			else{
				hasTrainedToday = true;
				hasTrainedTodayCooldown = 24;
			}
			doNext(camp.returnToCampUseOneHour);
		}
	}
}