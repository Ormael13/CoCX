package classes.Scenes.Places{
import classes.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Horns;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Scenes.Areas.Forest.WoodElvesHuntingParty;
import classes.Scenes.Crafting;
import classes.display.SpriteDb;
import classes.internals.SaveableState;

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
		public static const QUEST_STAGE_BOWTRAINING5:int = 5;
		public static const QUEST_STAGE_BOWTRAINING6:int = 6;

		public static var WoodElfSpearTraining:int;
		public static const QUEST_STAGE_SPEARTRAININGFIRST:int = 0;
		public static const QUEST_STAGE_SPEARTRAINING0:int = 1;
		public static const QUEST_STAGE_SPEARTRAINING1:int = 2;
		public static const QUEST_STAGE_SPEARTRAINING2:int = 3;
		public static const QUEST_STAGE_SPEARTRAINING3:int = 4;
		public static const QUEST_STAGE_SPEARTRAINING4:int = 5;

		public static var WoodElfMagicTraining:int;
		public static const QUEST_STAGE_MAGICTRAINING0:int = 0;
		public static const QUEST_STAGE_MAGICTRAINING1:int = 1;
		public static const QUEST_STAGE_MAGICTRAINING2:int = 2;
		public static const QUEST_STAGE_MAGICTRAINING3:int = 3;
		public static const QUEST_STAGE_MAGICTRAINING4:int = 4;
		public static const QUEST_STAGE_MAGICTRAINING5:int = 5;
		public static const QUEST_STAGE_MAGICTRAINING6:int = 6;
		public static const QUEST_STAGE_MAGICTRAINING7:int = 7;
		public static var WoodElfMagicTraner:Boolean;
		public static var WoodElfMagicTranerSex:int;
		public static var WoodElfMagicTranerGetLaid:Boolean;

		public static var WoodElfSeductionTraining:int;
		public static const QUEST_STAGE_SEDUCTIONTRAINING0:int = 0;
		public static const QUEST_STAGE_SEDUCTIONTRAINING1:int = 1;
		public static const QUEST_STAGE_SEDUCTIONTRAINING2:int = 2;
		public static var hasTrainedToday:Boolean;

		public static var ConvertedSisters:int;
		public static var ConvertedHerms:int;
		public static var CapturedSisters:Array;
		public static var CapturedHerms:Array;

		public function stateObjectName():String {
			return "WoodElves";
		}

		public function resetState():void {
			hasTrainedToday = false;
			WoodElvesQuest = QUEST_STAGE_NOT_STARTED;
			WoodElfBowTraining = QUEST_STAGE_BOWTRAINING0;
			WoodElfSpearTraining = QUEST_STAGE_SPEARTRAININGFIRST;
			WoodElfMagicTraining = QUEST_STAGE_MAGICTRAINING0;
			WoodElfSeductionTraining = QUEST_STAGE_SEDUCTIONTRAINING0;
			WoodElfMagicTraner = false;
			WoodElfMagicTranerSex = 0;
			WoodElfMagicTranerGetLaid = false;
			ConvertedSisters = 0;
			ConvertedHerms = 0;
			CapturedSisters = [];
			CapturedHerms = [];
		}

		public function saveToObject():Object {
			return {
				"stage": WoodElvesQuest,
				"stageBow": WoodElfBowTraining,
				"stageSpear": WoodElfSpearTraining,
				"elfHasTrainedToday": hasTrainedToday,
				"stageMagic": WoodElfMagicTraining,
				"stageSeduction": WoodElfSeductionTraining,
				"WoodElfMagicTraner": WoodElfMagicTraner,
				"WoodElfMagicTranerSex": WoodElfMagicTranerSex,
				"WoodElfMagicTranerGetLaid": WoodElfMagicTranerGetLaid,
				"ConvertedSisters": ConvertedSisters,
				"ConvertedHerms": ConvertedHerms,
				"CapturedSisters": CapturedSisters,
				"CapturedHerms": CapturedHerms
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				WoodElvesQuest = o["stage"];
				WoodElfBowTraining = o["stageBow"];
				WoodElfSpearTraining = o["stageSpear"];
				hasTrainedToday = o["elfHasTrainedToday"];
				WoodElfMagicTraining = valueOr(o["stageMagic"], 0);
				WoodElfSeductionTraining = valueOr(o["stageSeduction"], 0);
				WoodElfMagicTraner = valueOr(o["WoodElfMagicTraner"], false);
				WoodElfMagicTranerSex = valueOr(o["WoodElfMagicTranerSex"], 0);
				WoodElfMagicTranerGetLaid = valueOr(o["WoodElfMagicTranerGetLaid"], false);
				ConvertedSisters = valueOr(o["ConvertedSisters"], 0);
				ConvertedHerms = valueOr(o["ConvertedHerms"], 0);
				CapturedSisters = valueOr(o["CapturedSisters"], []);
				CapturedHerms = valueOr(o["CapturedHerms"], []);
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
			outputText("As you explore the forest, you hear giggling. You feel a rush of air and barely have time to duck before an arrow misses you by an inch. It's the elves again! You try and run for it but a tree vine has firmly attached itself to your left leg, holding you in place and slowly attempting to drag you towards the giggling elves.");
			outputText("\n\n\"<i>Good day " +player.mf("mister", "mis")+ " adventurer, how kind of you to come to us. Just sit down and relax; let us take great care of you.~♥</i>\"");
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
					"\n\n\"<i>I cannot tell you what you wish to know... But I can show you. Come with me, and We'll let you experience it for yourself! Although, I’m afraid once you do you likely won’t be going back.</i>\"\n\n" +
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
			outputText("Realising that there is no peaceful way out of this you ready your [weapon] and prepare for battle. The elves don't seem all too worried, after all it's you versus an entire group of them. They likely think they can easily overwhelm you. They have archers surrounding you, and the ones on the ground have elegant, yet deadly-looking spears. This is not going to be a fun fight.");
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
			outputText("You decide to let the elven lady proceed. The elf leader raises a hand and tentacle-like vines whip around you as the elves encircling you smirk and giggle");
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
					" You clench in anticipation as one explores between the cheeks of your [ass], then pushes its way into your [asshole]" +
					", its tapered end swirling about provocatively inside. The vine already gagging you stifles your cry of indignation as it works its way into your mouth, acting much the same way.\n\n As it does, it begins releasing a sticky, faintly sweet sap that trickles down your throat and coats your tongue, making you feel dizzy and flushed.");
			if (player.hasVagina()) outputText("You continue to thrash helplessly as a third tentacle winds its way into your [vagina], and despite yourself your hips start to twitch and buck as it eagerly explores your wet cavity, tickling your sensitive places and slowly filling you with  more sticky fluid; it clings to your walls and makes them feel warm and tingly, and before long your slit is engorged and drooling with a mixture of the plant’s secretions and your own feminine fluids.");
			outputText("With a muffled gasp of terror and arousal you realize yet another tentacle is pressing against your belly-button, and you squeal against the tentacle invading your throat as it actually penetrates through you and begins, impossibly, to move about inside your stomach, tickling and teasing you from inside. Insanely, rather than the pain of your stomach being impaled it brings a feeling of soothing warmth - almost relief. ");
			if (player.hasCoat()) outputText("With a shock you look down at your body to see your [skinfurscales] melting away and washing off, replaced by smooth, silky skin. ");
			if (player.tailType != Tail.NONE || player.wings.type != Wings.NONE || player.legCount != 2) outputText("Soon after, your other extra, unneeded appendages begin to shrivel and melt away as well. ");
			if (player.hasCoat() || player.tailType != Tail.NONE || player.wings.type != Wings.NONE || player.legCount != 2) outputText("despite the radical changes your form is undergoing, ");
			else outputText("Despite being violated in every hole you have, and some you don’t, ");
			outputText("a wave of peace and well-being comes over you, dispelling your panic and all sense of urgency as it does. How can this be a violation when it feels so <b>good</b>? ");
			if (player.cocks.length >= 1){
				outputText("You sigh in pleasure as you feel a vine wrapping slowly about the base of your male organ");
				if (player.cocks.length >= 2) outputText("s, and don’t even flinch as it pulls them off as easily as one might pluck a ripe fruit from a tree. You never needed them anyway, ridiculous, ugly things; you’re much better off without them.");
				else outputText(", and don’t even flinch as it pulls it off as easily as one might pluck a ripe fruit from a tree. You never needed it anyway, ridiculous, ugly thing; you’re much better off without it.");
				if (!player.hasVagina()) {
					outputText(" Instead you feel a rising sense of ecstatic rightness as a new slit forms where ");
					outputText(player.cocks.length == 1 ? "it" : "they");
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
			player.skinColor = "light";
			player.skinType  = Skin.PLAIN;
			player.skin.base.adj = "flawless";
			player.tone = 0;
			player.thickness = 20;
			player.femininity = 80;
			player.horns.type = Horns.NONE;
			player.antennae.type = Antennae.NONE;
			player.tailType = Tail.NONE;
			player.rearBody.type = RearBody.NONE;
			player.killCocks(player.cocks.length);
			player.balls = 0;
			player.ballSize = 0;
			if (!player.hasVagina()) player.createVagina();
			if (player.breastRows.length >= 2) player.removeBreastRow(player.breastRows.length - 1,player.breastRows.length-1);
			if (player.biggestTitSize() <= 4){
				var sizeIncrement:Number = 5-player.biggestTitSize();
				player.growTits(sizeIncrement, 1, false, 3)
			}
			if (!player.hasPerk(PerkLib.NaturalSpellcasting)) player.createPerk(PerkLib.NaturalSpellcasting,0,0,0,0);
			if (!player.hasPerk(PerkLib.FlawlessBody)) player.createPerk(PerkLib.FlawlessBody,0,0,0,0);
			if (!player.hasPerk(PerkLib.ElvenSense)) player.createPerk(PerkLib.ElvenSense,0,0,0,0);

			WoodElvesQuest = QUEST_STAGE_LOSTTOELF;
			doNext(function ():void {
				inventory.UseItemNow(CoC.instance.armors.ELFDRES, YouAreAlreadyElf2);
			});
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
					"As you gaze up at her, she reaches a hand out to you. With no real reason not to, you accept her offer and she helps you to your feet. " +
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
			if (!player.armor.isNothing) outputText(" Wait, didn’t you have some things with you before? Important things…?");
			outputText("\n\n\"<i>And I'm Alyssa,</i>\" says the elf sitting next to Elenwen, her chiming tone driving away your hesitation again. Her blond hair is done up in adorable braided twintails, accentuating her slender, girlish build, and her eyes are large and filled with gentle curiosity. \"<i>Oh look, Elenwen, her hair is still... </i>\"\n\n" +
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
					" The thoughts still aren’t fully coherent but somehow it’s coming together in your head that your beautiful sister is an enemy, that she and the rest of the elves are keeping you from... " +
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
			addButton(5, "Need2Go", Need2GoEndElfQuest).hint("<b>If you leave right now, you won't be able to come back to the grove.</b>");
			//addButton(6, "Want2Stay", Want2Stay);
		}

		public function ElvesTopic():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You ask the three elves about the elven race: why is there so little information about them? Have they always been hidden away or is something else going on?" +
					"\n\nMerisiel responds first. \"<i>We have been here since ancient times its just that we don't like to mingle with outsiders and this holds twice as true since the demon invasion happened.</i>\"" +
					"\n\nAlyssa continues. \"<i>Whoever somehow finds us tends to stay here and keep shut about our existance we mind our business and prefer to keep to ourselves.</i>\"" +
					"\n\nElenwen takes over. \"<i>Idealy only those we 'invite' in can find the village so most people don't even know we exist.</i>\"" +
					"\n\nMerisiel finishes the story as her sisters trail into sad silence. \"<i>I guess since we tend to kidnap people we wouldn't exactly receive a warm welcome amonst the other civilised races. Then there's our cousins the dark elves... They have an... unfortunately well-earned reputation as slavers. We used to be cleaner then this... But ever since the demons defiled our sacred trees, lust is one of the few things we can focus on.</i>\"\n\n" +
					"She glances at her sisters, a mixture of emotions visible in her face. Clearly the priority among these elves of the wood is no longer on exploration and diplomacy - you’ve experienced that much yourself by now.");
			menu();
			addButton(1, "The Tree", TheTreeTopic);
			addButton(2, "The Grove", TheGroveTopic);
			addButton(3, "Demons", DemonsTopic);
			addButton(4, "Ceremony?", CeremonyTopic);
			addButton(5, "Need2Go", Need2GoEndElfQuest).hint("<b>If you leave right now, you won't be able to come back to the grove.</b>");
			//addButton(6, "Want2Stay", Want2Stay);
			if (WoodElvesQuest == QUEST_STAGE_TOPICUNLOCKED){
				addButton(7, "Do Ceremony!", Ceremony1).hint("<b>This is irreversible. Are you sure?</b>");
				addButton(8, "Keep name", KeepName);
			}
		}

		public function TheTreeTopic():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You tell them to explain what is going on with that bizarre tree." +
					"\n\nAlyssa responds first. \"<i>The Sacred Tree grew from a sapling that dates back to the first days of Mareth. It is, or it was, I suppose, a core part of our culture; we elves are forest spirits deeply connected to the trees and animals of the woods, and the Sacred Tree was like our patron. When a new elf was born, we would place it underneath the tree, and it would be blessed with the spirit of the forest, growing into a true elf.</i>\"" +
					"\n\nElenwen continues. \"<i>When the demons found it, though, they changed all that. They corrupted it, turned it into… something else. They also corrupted us. You may have noticed that there are no male elves here; or at least none you would easily recognize as such without… checking. The truth is that male wood elves are so rare, thanks to those... Demons... That our males... well... Our only means of increasing our numbers nowadays is to abduct people.</i>\"" +
					"\n\nMerisiel nods. \"<i>The Sacred Tree, or I suppose the Corrupted Tree, now... it eats men. Or, it eats the ‘male’ out of men, I guess… in the process changing them into one of us. We can’t reproduce among ourselves anymore - the few of us that still has some of the right equipment are sterile. And when we breed with other races, the children aren’t elves. So the only way we can replenish our numbers from losses is by letting the Tree have its way with travelers we find… like we did with you.</i>\"" +
					"\n\n\"<i>But we really do care for them afterward!</i>\" Alyssa interjects. \"<i>Just like we did with you… or tried to, at least. We really did consider you to be one of us. I still do… little sister.</i>\" She trails off as she looks away from you sadly.");
			menu();
			addButton(0, "Elves", ElvesTopic);
			addButton(2, "The Grove", TheGroveTopic);
			addButton(3, "Demons", DemonsTopic);
			addButton(4, "Ceremony?", CeremonyTopic);
			addButton(5, "Need2Go", Need2GoEndElfQuest).hint("<b>If you leave right now, you won't be able to come back to the grove.</b>");
			//addButton(6, "Want2Stay", Want2Stay);
			if (WoodElvesQuest == QUEST_STAGE_TOPICUNLOCKED){
				addButton(7, "Do Ceremony!", Ceremony1).hint("<b>This is irreversible. Are you sure?</b>");
				addButton(8, "Keep name", KeepName);
			}
		}

		public function TheGroveTopic():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You ask about the Grove." +
					"\n\n\"<i>It’s been our home for years, of course,</i>\" says Elenwen. \"<i>Well truth be told its one of the few remaining if not the last wood elf community across Mareth since our species is mostly extinct due to our ahem... reproduction issues.</i>\"" +
					"\n\nMerisiel adds, \"<i>It’s a beautiful place, even after the corruption, I think. Nature thrives here; the plants and animals are healthy and free, and we live mostly in peace, aside from catching an adventurer every so often to replenish our numbers.</i>\"\n\n" +
					"Like they did with you, you add." +
					"\n\nThe three girls look a little guilty for a minute and nod. Alyssa says \"<i>We really did love you though. I… I still love you, and I wish you would stay with us. It’s not so bad here, is it?</i>\"\n\n" +
					"Unable to truthfully answer yes with certitude, you hold your silence and move on.");
			menu();
			addButton(0, "Elves", ElvesTopic);
			addButton(1, "The Tree", TheTreeTopic);
			addButton(3, "Demons", DemonsTopic);
			addButton(4, "Ceremony?", CeremonyTopic);
			addButton(5, "Need2Go", Need2GoEndElfQuest).hint("<b>If you leave right now, you won't be able to come back to the grove.</b>");
			//addButton(6, "Want2Stay", Want2Stay);
			if (WoodElvesQuest == QUEST_STAGE_TOPICUNLOCKED){
				addButton(7, "Do Ceremony!", Ceremony1).hint("<b>This is irreversible. Are you sure?</b>");
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
			addButton(5, "Need2Go", Need2GoEndElfQuest).hint("<b>If you leave right now, you won't be able to come back to the grove.</b>");
			//addButton(6, "Want2Stay", Want2Stay);
			if (WoodElvesQuest == QUEST_STAGE_TOPICUNLOCKED){
				addButton(7, "Do Ceremony!", Ceremony1).hint("<b>This is irreversible. Are you sure?</b>");
				addButton(8, "Keep name", KeepName);
			}
		}

		public function CeremonyTopic():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You ask Merisiel what this naming ceremony is about. She uncomfortably shifts in place before answering you." +
					"\n\n\"<i>Well it's a big event first and foremost, all new elves get a name given to them by the sacred trees. As we told you before, we elves are bonded to the forests. When a sister is ready to become a true wood elf she must undergo the naming ceremony, which consists in fully bonding with an offshoot of the sacred tree, both in body and soul. Your elven name is something that will come to you naturally, and your soul will merge with that of the forest.</i>\"\n\n" +
					"Merge with the forest? She could not possibly mean... Sensing your confusion Merisiel, with an almost ironic, somewhat deadpan soulless glare clarifies the rest for you." +
					"\n\n\"<i>If I was not clear enough your soul will safely stay bound within the tree, out of your body. So long as the forest lives you will never age again.</i>\"\n\n" +
					"You think for a moment, unite your soul with the forest in exchange for a timeless body and a new elven name? Is this what you truly want?");

			menu();
			addButton(0, "Elves", ElvesTopic);
			addButton(1, "The Tree", TheTreeTopic);
			addButton(2, "The Grove", TheGroveTopic);
			addButton(3, "Demons", DemonsTopic);
			addButton(5, "Need2Go", Need2GoEndElfQuest).hint("<b>If you leave right now, you won't be able to come back to the grove.</b>");
			//addButton(6, "Want2Stay", Want2Stay);
			addButton(7, "Do Ceremony!", Ceremony1).hint("<b>This is irreversible. Are you sure?</b>");
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
			endEncounter();
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
			endEncounter();
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
			outputText("This name, whispered to you by the spirit of the forest, was... ");

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
			player.createPerk(PerkLib.CovenantOfTheSpirits,0,0,0,0);
			if (player.hasPerk(PerkLib.RacialParagon))
				flags[kFLAGS.APEX_SELECTED_RACE] = Races.WOODELF;
			IMutationsLib.ElvishPeripheralNervSysIM.trueMutation = true;
			player.removeAllRacialMutation();
			explorer.stopExploring();
			doNext(camp.returnToCamp, 16);
		}

		public function GroveLayout():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			if (WoodElvesQuest != QUEST_STAGE_PCCAMEBACK){
				outputText("You walk along the treeline following the way back to the elves as you last remember. You know you are nearing your destination as the familiar sound of running water as the river hits your ears before coming to view." +
						"You spot the giant tree resting in its clearing before you quickly advance to it. Memories flow through you as you caress its fine bark. A gentle vine stretches out, endearingly caressing you in reciprocation. Your memories guide you as you follow the river back and finally spot the elven houses. You walk on the gravel as a few curious glances turn your way. Their eyes glint with the sparkling green light bouncing off of their glance as the elves take notice of you one after the other." +
						"\n\nOut of nowhere, you are grabbed from behind as an elf gives you a surprise hug. You flinch softly at the vice-like grip, it's as if they never want to let go of you again. The elf gently loosens her grip as she looks into your eyes. Alyssa stares at you intently before gathering her words." +
						"\n\n\"<i>Sister [name]! You came back, we all thought you would get captured by demons or worse out there!</i>");
			if(!player.isRace(Races.ELF, 1, false) && !player.isRace(Races.WOODELF, 1, false)) outputText("<i> Well... you did change a little, but that doesn't matter. You're still, and forever will be family!.</i>");
				outputText("\"" +
				"\n\nUnsurprisingly, Elenwen is not so far behind, a little confused." +
						"\n\n\"<i>Alyssa, what's going on? </i>");
				if(!player.isRace(Races.ELF, 1, false) && !player.isRace(Races.WOODELF, 1, false)) outputText("<i>Who's this?</i>");
				outputText("<i> Wait, that's actually [name]?! You finally came home! Merisiel is going to be overjoyed!</i>\"" +
						"\n\nYou pause briefly; that's slightly concerning. You ask what happened with Merisiel." +
						"\n\n\"<i>Well, ever since you left she's been kind of depressed. She's constantly asking herself over and over if the memory incident was her fault. </i>");
				if(!player.isRace(Races.ELF, 1, false) && !player.isRace(Races.WOODELF, 1, false)) outputText("<i> Doesn't matter if you've changed, t</i>");
				else outputText("<i>T</i>");
				outputText("<i>he mere fact that you are here despite everything is going to cheer her up.</i>\"" +
						"Before you know it, they organize a whole party just for you. Wine, food, and more discreet pleasures included. Perhaps coming back once in a while would be nice." +
						" You think out loud. It's just that you need time to yourself. Besides, if you spent all your time here there wouldn't be any time left for your quest." +
						"\n\nElenwen shrugs before replying to your statement. Guess you have been thinking out loud. \"<i>You're free to come and go. Besides that, you're fighting to save the land is something we should be proud of. Who knows, you might even free the blessed tree eventually.</i>\"" +
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
			addButton(0, "River", River)
				.disableIf(!player.isRace(Races.ELF, 1, false) && !player.isRace(Races.WOODELF, 1, false),"You need to be an elf in order to go bath with the girls.")
				.disableIf(!player.hasVagina(), "You can't seriously go back naked with girls as a guy! Just what were you thinking, You degenerate pervert!?");
			addButton(1, "Tent", Tent)
				.disableIf((!player.isRace(Races.ELF, 1, false) && !player.isRace(Races.WOODELF, 1, false)),"You need to be an elf.")
				.disableIf(!player.hasVagina(), "You need to be female or herm in order to use the tents.");
			addButton(2, "Fletching table", Fletching);
			addButton(3, "Elenwen", Elenwen)
				.disableIf(hasTrainedToday,"You need a break from your recent training before you can train again.")
				.disableIf(!player.isElf(),"Elenwen has personal preferences in regards to the people she will train, maybe you should make yourself more elf like.")
				.disableIf(!player.hasVagina(),"Elenwen has personal preferences in regards to the people she will train with... it's not like archery is just for girls, but considering the fact that she's practicing naked... ");
			addButton(4, "Alyssa", Alyssa)
				.disableIf(hasTrainedToday,"You need a break from your recent training before you can train again.")
				.disableIf(!player.isElf(),"Alyssa has personal preferences in regards to the people she will train, maybe you should make yourself more elf like.")
				.disableIf(!player.hasVagina(), "Alyssa has personal preferences in regards to the people she will train with... it's not like the spear is a girl only discipline, but the way she uses it might as well be... ");
			addButton(5, "Lutien", Lutien);
			addButton(6, "Chelsea", Chelsea)
					.disableIf(hasTrainedToday, "You need a break from your recent training before you can train again.");
			addButton(14, "Leave", explorer.done);
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
				player.trainStat("lib", 4, player.trainStatCap("lib",80));
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
			endEncounter();
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
					"\"<i>H-here I come, [name]... </i>\"" +
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
			player.trainStat("lib", +1, player.trainStatCap("lib",80));
			CoC.instance.timeQ = 1;
			endEncounter();
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
			clearOutput();
			outputText("What kind of arrows would you like to create?");
			menu();
			if (player.hasItem(useables.IARROWHEAD, 1)) addButton(0, "Iron", FletchingCraftArrows2, "iron", 1).hint("Use iron arrowheads to craft arrows.");
			if (player.hasItem(useables.MARROWHEAD, 1)) addButton(1, "Moonstone", FletchingCraftArrows2, "moonstone", 2).hint("Use moonstone arrowheads to craft arrows.");
			if (player.hasItem(useables.SARROWHEAD, 1)) addButton(2, "Skymetal", FletchingCraftArrows2, "skymetal", 3).hint("Use skymetal arrowheads to craft arrows.");
			if (player.hasItem(useables.EARROWHEAD, 1)) addButton(3, "Ebonbloom", FletchingCraftArrows2, "ebonbloom", 4).hint("Use ebonbloom arrowheads to craft arrows.");
			//Skymetal(Found in glacial rift) +30% Damage
			addButton(14, "Back", Fletching);
		}
		private function FletchingCraftArrows2(itype:String, type:Number):void {
			clearOutput();
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
			explorer.stopExploring();
			doNext(camp.returnToCampUseEightHours);
		}

		public function FletchingAdjustString():void {
			clearOutput();
			outputText("You may choose a different sturdier string for your bow. What would you use?");
			menu();
			if (player.statusEffectv2(StatusEffects.FletchingTable) > 0) addButtonDisabled(0, "SpiderSilk", "You've already used this to improve your bowstring.");
			else {
				if (player.hasItem(useables.T_SSILK, 1)) addButton(0, "SpiderSilk", FletchingAdjustString2, useables.T_SSILK);
				else addButtonDisabled(0, "SpiderSilk", "You need spider silk.");
			}
			if (player.statusEffectv2(StatusEffects.FletchingTable) > 1) addButtonDisabled(1, "Ebonbloom", "You've already used this to improve your bowstring.");
			else {
				if (player.hasItem(useables.EBONBLO, 1)) {
					if (player.statusEffectv2(StatusEffects.FletchingTable) < 1) addButtonDisabled(1, "Ebonbloom", "You need to improve the bowstring with spider silk first.");
					else addButton(1, "Ebonbloom", FletchingAdjustString2, useables.EBONBLO);
				}
				else addButtonDisabled(1, "Ebonbloom", "You need ebonbloom.");
			}
			if (player.statusEffectv2(StatusEffects.FletchingTable) > 2) addButtonDisabled(2, "UnicornHair", "You've already used this to improve your bowstring.");
			else {
				if (player.hasItem(useables.UNICORNH, 1)) {
					if (player.statusEffectv2(StatusEffects.FletchingTable) < 2) addButtonDisabled(2, "UnicornHair", "You need to improve the bowstring with ebonbloom first.");
					else addButton(2, "UnicornHair", FletchingAdjustString2, useables.UNICORNH);
				}
				else addButtonDisabled(2, "UnicornHair", "You need unicron hair.");
			}
			addButton(14, "Back", Fletching);
		}
		private function FletchingAdjustString2(itype:ItemType):void {
			clearOutput();
			outputText("You work for 8 hours adjusting your new " + itype.shortName + " string to your bow. This will serve you well in your adventures.");
			player.addStatusValue(StatusEffects.FletchingTable, 2, 1);
			player.destroyItems(itype, 1);
			explorer.stopExploring();
			doNext(camp.returnToCampUseEightHours);
		}

		public function FletchingReinforce():void {
			clearOutput();
			outputText("You may choose to reinforce your bow using various materials. What would you use?");
			menu();
			if (player.statusEffectv1(StatusEffects.FletchingTable) > 0) addButtonDisabled(0, "Bronze", "You've already used this to reinforce your bow.");
			else {
				if (player.hasItem(useables.BRONZEB, 1) || Crafting.BagSlot03 > 0) addButton(0, "Bronze", FletchingReinforce2, useables.BRONZEB, 1);
				else addButtonDisabled(0, "Bronze", "You need bronze bar.");
			}
			if (player.statusEffectv1(StatusEffects.FletchingTable) > 1) addButtonDisabled(1, "Iron", "You've already used this to reinforce your bow.");
			else {
				if (player.hasItem(useables.IRONORE, 1) || Crafting.BagSlot04 > 0) {
					if (player.statusEffectv1(StatusEffects.FletchingTable) < 1) addButtonDisabled(1, "Iron", "You need to reinforce your bow with bronze first.");
					else addButton(1, "Iron", FletchingReinforce2, useables.IRONORE, 2);
				}
				else addButtonDisabled(1, "Iron", "You need iron ore.");
			}
			if (player.statusEffectv1(StatusEffects.FletchingTable) > 2) addButtonDisabled(2, "Moonstone", "You've already used this to reinforce your bow.");
			else {
				if (player.hasItem(useables.MOONSTO, 1) || Crafting.BagSlot07 > 0) {
					if (player.statusEffectv1(StatusEffects.FletchingTable) < 2) addButtonDisabled(2, "Moonstone", "You need to reinforce your bow with iron first.");
					else addButton(2, "Moonstone", FletchingReinforce2, useables.MOONSTO, 3);
				}
				else addButtonDisabled(2, "Moonstone", "You need moonstone.");
			}
			if (player.statusEffectv1(StatusEffects.FletchingTable) > 3) addButtonDisabled(3, "EbonIng", "You've already used this to reinforce your bow.");
			else {
				if (player.hasItem(useables.EBONING, 1) || Crafting.BagSlot06 > 0) {
					if (player.statusEffectv1(StatusEffects.FletchingTable) < 3) addButtonDisabled(3, "EbonIng", "You need to reinforce your bow with moonstone first.");
					else addButton(3, "EbonIng", FletchingReinforce2, useables.EBONING, 4);
				}
				else addButtonDisabled(3, "EbonIng", "You need ebon ingot.");
			}
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
			explorer.stopExploring();
			doNext(camp.returnToCampUseEightHours);
		}

		//Elenwen is nearly as skilled as Kindra, but is very picky on who she teaches to. Better be an elf. Also her training is slower as she tends to fool around.
		private function bowSkill1(diff:Number):Number {
			player.addStatusValue(StatusEffects.Kelt,1,diff);
			if (player.statusEffectv1(StatusEffects.Kelt) >= 100) player.changeStatusValue(StatusEffects.Kelt,1,100);
			return player.statusEffectv1(StatusEffects.Kelt);
		}
		private function bowSkill2(diff:Number):Number {
			if (player.statusEffectv1(StatusEffects.Kindra) < 75) {
				var gain:Number = diff;
				if (player.statusEffectv1(StatusEffects.Kindra) + diff > 75) gain = (75 - player.statusEffectv1(StatusEffects.Kindra));
				player.addStatusValue(StatusEffects.Kindra,1,gain);
			}
			return player.statusEffectv1(StatusEffects.Kindra);
		}

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
					if (player.armor.isNothing) outputText("down to your glistening slit");
					else outputText("under your equipment to your glistening slit");
			outputText(" to give you a loving stroke, ending in her finger rubbing on your stiff, sensitive button." +
					" You gasp at the stimulation but manage to retaliate by slipping a hand under her white dress to prod at her lips as well." +
					" The two of you continue briefly, moaning pleasurably and bucking your hips against each other's hands as you kiss and gently nibble at each other's lips," +
					" but then Elenwen takes her hand from your dripping snatch and lightly pulls your hand from hers." +
					"\n\n\"<i>Mmm... . that was fun, sweet little sister, but we should get back to work. If you can manage to hit a bullseye as excited as you are now, I’ll be satisfied with your practice for today. Then, if you want, we can continue this later~♥</i>\"" +
					"\n\nYou nod, a bit disappointed at being cut off before climax, and take up your bow again. After several tries, you ");
			if (player.statusEffectv1(StatusEffects.Kelt) < 100) outputText("manage to make a shot Elenwen considers fair for her standards.");
			if (player.statusEffectv1(StatusEffects.Kelt) >= 100) outputText("hit a bullseye, and Elenwen praises your efforts before you say your goodbyes.");
			outputText("\n\nAs you leave for your camp Elenwen waves at you with a \"<i>See you later, sister. We can do something more fun next time~♥</i>\"" +
					" With a hint of regret, you wave and head back home, seriously considering taking her up on the offer before the day is up.");
			player.trainStat("tou", 4, player.trainStatCap("tou",50));
			player.trainStat("spe", 4, player.trainStatCap("spe",100));
			player.trainStat("int", 4, player.trainStatCap("int",80));
			if (player.spe >= 50 && player.statusEffectv1(StatusEffects.Kelt) >= 25 && WoodElfBowTraining == QUEST_STAGE_BOWTRAINING0 && !hasTrainedToday){
				WoodElfBowTraining = QUEST_STAGE_BOWTRAINING1;
				outputText("\n\nThanks to your extensive training in elven archery you have unlocked the Pin down ability! <b>Gained P.Ability: Pin Down</b>");
				hasTrainedToday = true;
			}
			else if (player.spe >= 100 && player.statusEffectv1(StatusEffects.Kelt) >= 50 && WoodElfBowTraining == QUEST_STAGE_BOWTRAINING1 && !hasTrainedToday){
				WoodElfBowTraining = QUEST_STAGE_BOWTRAINING2;
				outputText("\n\nThanks to your extensive training in elven archery you have unlocked the Elven Eye ability! <b>Gained P.Ability: Elven Eye</b>");
				hasTrainedToday = true;
			}
			else if (player.spe >= 150 && player.statusEffectv1(StatusEffects.Kelt) >= 100 && WoodElfBowTraining == QUEST_STAGE_BOWTRAINING2 && !hasTrainedToday){
				WoodElfBowTraining = QUEST_STAGE_BOWTRAINING3;
				player.createPerk(PerkLib.ELFMasterShot,0,0,0,0);
				outputText("\n\nThanks to your extensive training in elven archery you have unlocked the Master Shot Perk! <b>Gained Perk: Master Shot</b>");
				hasTrainedToday = true;
			}
			else if (player.spe >= 200 && player.statusEffectv1(StatusEffects.Kindra) >= 50 && WoodElfBowTraining == QUEST_STAGE_BOWTRAINING3 && !hasTrainedToday){
				WoodElfBowTraining = QUEST_STAGE_BOWTRAINING4;
				player.createPerk(PerkLib.ELFArcherCovenant,0,0,0,0);
				outputText("\n\nThanks to your extensive training in elven archery you have unlocked the Archer Covenant Perk! <b>Gained Perk: Archer Covenant</b>");
				hasTrainedToday = true;
			}
			else if (player.speStat.train.value >= 100 && WoodElfBowTraining == QUEST_STAGE_BOWTRAINING4 && !hasTrainedToday && !player.isRace(Races.WOODELF)){
				outputText("\n\n\"<i>Unfortunately I wont be able to teach you the ultimate skills of elven archery because you aren't complete or rather… you never made a covenant with the blessed tree. These last skills taps directly in the power of the covenant and thus cannot be learned by someone with no connection.</i>\"")
				hasTrainedToday = true;
			}
			else if (player.speStat.train.value >= 100 && WoodElfBowTraining == QUEST_STAGE_BOWTRAINING4 && !hasTrainedToday && player.isRace(Races.WOODELF) && player.hasStatusEffect(StatusEffects.KnowsBriarthorn)){
				WoodElfBowTraining = QUEST_STAGE_BOWTRAINING5;
				player.createPerk(PerkLib.ELFThornShot,0,0,0,0);
				flags[kFLAGS.ELVEN_THORNSHOT_ENABLED] = 1;
				outputText("\n\nIt occurs to you that by combining elven green magic with your shot you could to infuse your arrow with life energy, the wooden shaft growing thorns that would surely inflict painful poisoned wounds to your opponents. <b>Gained Perk: Elven Thorn Shot</b>");
				hasTrainedToday = true;
			}
			else if (WoodElfBowTraining == QUEST_STAGE_BOWTRAINING5 && !hasTrainedToday && player.isRace(Races.WOODELF)){
				if (player.spe100 < 100) {
					outputText("\n\nBy now you have achieved mastery of every technique Elenwen could touch you… well almost. Elenwen's single most amazing skill is her ability to shoot a salvo of two arrows in quick succession, a skill you have yet to see anyone but her use.");
					outputText(" You're certain if you train and improve your speed to the breaking point you could achieve it too. Guess you will need to increase your speed and dexterity to their utmost limit before you can unlock that skill.");
					hasTrainedToday = true;
				} else {
					WoodElfBowTraining = QUEST_STAGE_BOWTRAINING6;
					player.createPerk(PerkLib.ELFTwinShot,0,0,0,0);
					flags[kFLAGS.ELVEN_TWINSHOT_ENABLED] = 1;
					outputText("\n\nBy now you have achieved mastery of every technique Elenwen could touch you… well almost. Elenwen's single most amazing skill is her ability to shoot a salvo of two arrows in quick succession, a skill you have yet to see anyone but her use. <b>Gained Perk: Elven Twin Shot</b>");
					hasTrainedToday = true;
				}
			}
			else{
				hasTrainedToday = true;
			}
			if (!player.hasStatusEffect(StatusEffects.Kelt)) player.createStatusEffect(StatusEffects.Kelt, 5, 0, 0, 0);
			else {
				if (player.statusEffectv1(StatusEffects.Kelt) >= 100) {
					if (!player.hasStatusEffect(StatusEffects.Kindra)) player.createStatusEffect(StatusEffects.Kindra, 5, 0, 0, 0);
					else bowSkill2(5);
				}
				else bowSkill1(5);
			}
			CoC.instance.timeQ = 1;
			endEncounter();
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
				if (player.armor.isNothing) outputText("\n\nShe looks approvingly at your lack of clothing, not with her standard expression of perverted lust but with a serious glance.");
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
			player.trainStat("str", 4, player.trainStatCap("str",80));
			player.trainStat("spe", 4, player.trainStatCap("spe",100));
			player.trainStat("tou", 4, player.trainStatCap("tou",80));
			CoC.instance.timeQ = 1;
			if (player.spe >= 50 && WoodElfSpearTraining == QUEST_STAGE_SPEARTRAINING0 && !hasTrainedToday){
				WoodElfSpearTraining = QUEST_STAGE_SPEARTRAINING1;
				player.createPerk(PerkLib.ELFElvenSpearDancingFlurry1to4,1,0,0,0);
				outputText("\n\nThanks to your extensive training in elven spear techniques you have unlocked the Elven Spear Dancing Flurry! <b>Gained Perk:Elven Spear Dancing Flurry</b>");
				hasTrainedToday = true;
			}
			else if (player.spe >= 100 && WoodElfSpearTraining == QUEST_STAGE_SPEARTRAINING1 && !hasTrainedToday){
				WoodElfSpearTraining = QUEST_STAGE_SPEARTRAINING2;
				player.createPerk(PerkLib.ELFElvenBattleStyle,0,0,0,0);
				player.setPerkValue(PerkLib.ELFElvenSpearDancingFlurry1to4,1,2);
				outputText("\n\nThanks to your extensive training in elven spear techniques you have unlocked the Elven Battle Style and Elven Spear Dancing Flurry II Perk! <b>Gained Perk: Elven Battle Style and Elven Spear Dancing Flurry II</b>");
				hasTrainedToday = true;
			}
			else if (player.spe >= 150 && WoodElfSpearTraining == QUEST_STAGE_SPEARTRAINING2 && !hasTrainedToday){
				WoodElfSpearTraining = QUEST_STAGE_SPEARTRAINING3;
				player.setPerkValue(PerkLib.ELFElvenSpearDancingFlurry1to4,1,3);
				outputText("\n\nThanks to your extensive training in elven spear techniques you have unlocked the Spear Dancing Flurry III Perk! <b>Gained Perk: Elven Spear Dancing Flurry III</b>");
				hasTrainedToday = true;
			}
			else if (player.spe >= 200 && WoodElfSpearTraining == QUEST_STAGE_SPEARTRAINING3 && !hasTrainedToday){
				WoodElfSpearTraining = QUEST_STAGE_SPEARTRAINING4;
				player.createPerk(PerkLib.ELFElvenSpearDancingTechnique,0,0,0,0);
				player.setPerkValue(PerkLib.ELFElvenSpearDancingFlurry1to4,1,4);
				outputText("\n\nThanks to your extensive training in elven spear techniques you have unlocked the Elven Spear Dancing Technique and Elven Spear Dancing Flurry IV Perk! <b>Gained Perk: Spear Dancing Technique and Elven Spear Dancing Flurry IV</b>");
				hasTrainedToday = true;
			}
			else{
				hasTrainedToday = true;
			}
			endEncounter();
		}

		public function LutienMF(boy:String,girl:String):String {
			if (WoodElfMagicTraner) return boy;
			else return girl;
		}
		public function Lutien():void {
			if (WoodElfMagicTraining == QUEST_STAGE_MAGICTRAINING0) Lutien0();
			else if (WoodElfMagicTraining == QUEST_STAGE_MAGICTRAINING1) Lutien1();
			else LutienMain();
		}
		public function Lutien0():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("As you explore around the village, you come upon an Elf whose appearance sets her clearly apart from the rest of your sisters." +
					" Dressed in a loose, sleeveless blouse and knee-length skirt and wearing thigh-high leather boots, she seems to eschew the usual Wood Elf penchant for exposing as much skin as possible." +
					" Over the ensemble is a white cloak, which she wears with the hood down, concealing her hair and forehead. Her breasts are smaller even than Alyssa’s, practically non-existent; " +
					" evidently magic and bust size don’t always go hand in hand. Though, her white hood conceals her head, you spot braided hair long enough to lay alongside her slender thigh on the bench at which she sits." +
					" Though she seems preoccupied with the book in her hands, she nevertheless acknowledges you, waving a hand lazily in your direction without taking " +
					" her eyes from the tome in her lap, and addressing you languidly in a quiet, husky voice.\n\n");
			outputText("\"<i>Oh, if it isn’t the newest sister. Apologies for not coming to greet you with the others, but I’ve been busy. " +
					" As you can see, I have interests a bit different from the rest of us - I’d rather study and practice my magic than frolic in the woods. Ah, but where are my manners?</i>\"" +
					" She closes the book around a slender finger to keep her place and turns her head to face you, fixing you with a hooded, critical gaze. " +
					"\"<i>My name is Lutien, and I am the resident mage of the Wood Elves, if only for lack of any competition, or cooperation, from my sisters. What is your name?</i>\"\n\n");
			outputText("You smile and gladly tell her that you are [name] the newest little " + player.mf("brother","Sister") +".\n\n");
			outputText("\"<i>I assure you the pleasure is mine, [name]. If you have a need for magic I am very happy to assist you. Otherwise I’m afraid you won’t find me very interesting company, and you should probably return to playing with the others.</i>\"");
			menu();
			addButton(1, "Magic", Lutien3);
			addButton(3, "Not interested", Lutien2);
		}
		public function Lutien1():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You visit Lutien at " + LutienMF("his","her") + " tent, " + LutienMF("he","she") + " is currently in the process of reading what looks to be a book while writing notes on a parchment.\n\n");
			outputText("\"<i>Oh it's you again have you reconsidered on the training? If you're here for something else I would please ask that you leave. I have far more important matters to attend to at the time to talk about games and what not.</i>\"\n\n");
			menu();
			addButton(1, "Magic", Lutien3);
			addButton(3, "Not interested", Lutien2);
		}
		public function Lutien2():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("Lutien sighs," +
					" \"<i>Yes, yes, of course. No need for the tedium of magic when you can play around with your other sisters. I understand completely.</i>\"" +
					LutienMF("He","She")+" pauses as her attention shifts back to her book," +
					" \"<i>Now, if you would excuse me, I would like to continue my reading in peace.</i>\"\n\n");
			outputText("You leave Lutien to "+LutienMF("his","her")+" work, not wanting to disturb their efforts, and not especially appreciating "+LutienMF("his","her")+" company.");
			if (WoodElfMagicTraining == QUEST_STAGE_MAGICTRAINING0) WoodElfMagicTraining = QUEST_STAGE_MAGICTRAINING1;
			endEncounter();
		}
		public function Lutien3():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("Magic? That sounds <b>very</b> interesting, as a matter of fact. If you can learn Elf magic you want to.\n\n");
			outputText("Lutien blinks, startled by your reply." +
					" \"<i>Oh. I… I see? I will admit I didn’t expect you to have any interest when you have so many more pleasurable avenues to explore here," +
					" but perhaps you are different from the others after all. If you’re serious about this then I’m confident I can teach you." +
					" And, of course, you can always stop when things get difficult. I won’t try to keep you.</i>\"\n\n");
			outputText("Well, she doesn’t have the best personality, but the prospect of learning new ways to deal with your opponents is too good to pass up. Lutien pats the bench next to her, and you sit beside her to begin your lesson.\n\n");
			outputText("<b>Found Lutien in the Elven village!</b>");
			WoodElfMagicTraining = QUEST_STAGE_MAGICTRAINING2;
			endEncounter();
		}
		public function LutienMain():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You visit Lutien at " + LutienMF("his","her") + " tent, " + LutienMF("he","she") + " is currently in the process of reading what looks to be a book while writing notes on a parchment.\n\n");
			outputText("\"<i>Oh good day sister… how can I help you? Are you here to train your spellcasting or for something else?</i>\"\n\n");
			menu();
			addButton(0, "Train", LutienTrain)
					.disableIf(hasTrainedToday, "You need a break from your recent training before you can train again.");
			if (WoodElfMagicTraining >= QUEST_STAGE_MAGICTRAINING3) addButton(1, "Sex", LutienMainSex);
			else addButtonDisabled(1, "???", "???");
			addButton(4, "Back", GroveLayout);
		}
		public function LutienTrain():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			if (WoodElfMagicTraining == QUEST_STAGE_MAGICTRAINING2 && !hasTrainedToday){
				WoodElfMagicTraining = QUEST_STAGE_MAGICTRAINING3;
				outputText("After a few hours spent directing the discussion and answering your questions, Lutien sighs and closes her book.\n\n");
				outputText("\"<i>Well, I suppose that went about as well as I could expect.</i>\"\n\n");
				outputText("A bit miffed, you ask what you could do better next time.\n\n");
				outputText("\"<i>If there is a next time,</i>\" she replies pointedly, \"<i>you may find the time we spend more productive if you can keep your eyes on the text instead of my chest and groin.");
				outputText(" That level of distraction is mild by what passes for Elven standards now, but you shouldn’t expect to see success casting magic in combat if a little thing like me sitting next to you is enough to make your focus wander.</i>\"\n\n");
				outputText("You are forced to concede the point, though you counter that Lutien is much cuter than she lets on. You see a faint blush on her cheeks as she reopens the book to her original place and shoos you off.\n\n");
				outputText("\"<i>Enough, be off with you. I’d like to get back to my reading. If you can pull yourself away from your other activities on some other day we can try this again; I’m willing to go that far at least.</i>\"\n\n");
				if (!player.hasStatusEffect(StatusEffects.KnowsPlantGrowth)) {
					outputText("<b>Gained new green spell: Plant growth.</b>");
					player.createStatusEffect(StatusEffects.KnowsPlantGrowth, 0, 0, 0, 0);
				}
				if (WoodElfMagicTranerSex < 1) WoodElfMagicTranerSex = 1;
				hasTrainedToday = true;
			}
			else if (player.inte >= 100 && WoodElfMagicTraining == QUEST_STAGE_MAGICTRAINING3 && !hasTrainedToday){
				WoodElfMagicTraining = QUEST_STAGE_MAGICTRAINING4;
				outputText("After a few hours spent directing the discussion and answering your questions, Lutien sighs and closes " + LutienMF("his","her") + " book.\n\n");
				outputText("\"<i>You learn about as fast as I'd expect any other elf, which is to say slowly and with bits of distraction every now and then but at least you are making progress. I would give you homeworks but I'm afraid");
				outputText(" you would just forget about doing it. For now just stick to practicing what I've already taught you and come back later for more.</i>\"\n\n");
				outputText("You nod and leave Lutien to " + LutienMF("his","her") + " study.\n\n");
				if (!player.hasStatusEffect(StatusEffects.KnowsEntangle)) {
					outputText("<b>Gained new green spell: Entangle.</b>");
					player.createStatusEffect(StatusEffects.KnowsEntangle, 0, 0, 0, 0);
				}
				hasTrainedToday = true;
			}
			else if (player.inte >= 100 && WoodElfMagicTraining == QUEST_STAGE_MAGICTRAINING4 && !hasTrainedToday){
				WoodElfMagicTraining = QUEST_STAGE_MAGICTRAINING5;
				outputText("After a few hours spent directing the discussion and answering your questions, Lutien sighs and closes " + LutienMF("his","her") + " book.\n\n");
				outputText("\"<i>You learn about as fast as I'd expect any other elf, which is to say slowly and with bits of distraction every now and then but at least you are making progress. I would give you homeworks but I'm afraid");
				outputText(" you would just forget about doing it. For now just stick to practicing what I've already taught you and come back later for more.</i>\"\n\n");
				outputText("You nod and leave Lutien to " + LutienMF("his","her") + " study.\n\n");
				if (!player.hasStatusEffect(StatusEffects.KnowsBriarthorn)) {
					outputText("<b>Gained new green spell: Briarthorn.</b>");
					player.createStatusEffect(StatusEffects.KnowsBriarthorn, 0, 0, 0, 0);
				}
				if (WoodElfMagicTranerSex < 2) WoodElfMagicTranerSex = 2;
				hasTrainedToday = true;
			}
			else if (player.inte >= 200 && WoodElfMagicTraining == QUEST_STAGE_MAGICTRAINING5 && !hasTrainedToday){
				WoodElfMagicTraining = QUEST_STAGE_MAGICTRAINING6;
				outputText("After a few hours spent directing the discussion and answering your questions, Lutien smile and closes " + LutienMF("his","her") + " book.\n\n");
				outputText("\"<i>I hate to admit that you actually got skill for this. I sadly won't be able to teach you "+(player.isRace(Races.WOODELF)?"much":"any")+" longer. You learned next to everything I could teach you already.</i>\"\n\n");
				outputText("There must still be something Lutien can teach you though.\n\n");
				if (player.isRace(Races.WOODELF)) {
					outputText("\"<i>There is however I will first ask that you do something that goes directly against everything I've told you to do so far. I need you to go out there and get yourself laid… a LOT.</i>\"\n\n");
					outputText("Wait what?\n\n");
					outputText("\"<i>You heard right go out there and get yourself fucked silly by everything and anything until you've acquired a suffisent mastery of your charms and resilience to pleasure. Funnily, this is something the others can absolutely assist you with. Heck, even that cow Chelsea could be helpful at this point.</i>\"\n\n");
					outputText("Lutien and Chelsea don't seem to get along. You ask " + LutienMF("him","her") + " why is that?\n\n");
					outputText("\"<i>Isn't that obvious? She's a nymphomaniac who only thinks about sex and pleasurable sensations. Why would I respect someone like that? Anyway, once you've achieved a suffisent mastery, I need you to go through one last step… That is to have sex with an alraune of great power. This might sound ludicrous but they are the closest ");
					outputText("thing to an avatar of the deity marae. Well, of course, if you could have sex with Marae herself that would work too but Marae, last I heard, has no interest in that, unlike her floral and lustful daughters. Once your holes have been plugged full of greenery and stamens, we can go with our final lesson.</i>\"\n\n");
				}
				else {
					outputText("\"<i>Sadly no, and that's because you aren't complete or rather… you never made a covenant with the blessed tree. This last spell taps directly in the power of the covenant and thus cannot be learned by someone with no connection. Thus this is our final lesson</i>\"\n\n");
				}
				outputText("You nod and leave Lutien to " + LutienMF("his","her") + " study.\n\n");
				if (!player.hasStatusEffect(StatusEffects.KnowsDeathBlossom)) {
					outputText("<b>Gained new green spell: Death Blossom.</b>");
					player.createStatusEffect(StatusEffects.KnowsDeathBlossom, 0, 0, 0, 0);
				}
				hasTrainedToday = true;
			}
			else if (player.inte >= 400 && WoodElfMagicTraining == QUEST_STAGE_MAGICTRAINING6 && !hasTrainedToday && player.isRace(Races.WOODELF) && WoodElfMagicTranerGetLaid){
				WoodElfMagicTraining = QUEST_STAGE_MAGICTRAINING7;
				outputText("After a few hours spent directing the discussion and answering your questions, Lutien smile and closes " + LutienMF("his","her") + " book.\n\n");
				outputText("\"<i>Congratulations, [name]. You have effectively learned everything I could teach you and even mastered that one last trick. I guess this means the end of our lessons. However, if you wish to revise less serious subjects with me… just know I will be available anytime. It's rare to find someone so smart and at the same time… ");
				outputText("so attractive.</i>\" " + LutienMF("He","She") + " blushes but quickly realizes " + LutienMF("he","she") + "'s wide open and moves " + LutienMF("his","her") + " eyes back to " + LutienMF("his","her") + " book dismissing you.\n\n");
				if (!player.hasStatusEffect(StatusEffects.KnowsGreenCovenant)) {
					outputText("<b>Gained new magic special: Green Covenant.</b>");
					player.createStatusEffect(StatusEffects.KnowsGreenCovenant, 0, 0, 0, 0);
				}
				hasTrainedToday = true;
			}
			else {
				outputText("You would just like to revise theory with Lutien today. On this " + LutienMF("he","she") + " close " + LutienMF("his","her") + " book and sigh.\n\n");
				outputText("\"<i>Well I suppose I can give you a list of practical tests to do should at least be a break from my research. Let's see how well you've learned this far.</i>\"\n\n");
				outputText("You spend the 5 hour studying with Lutien and finish feeling far more confident in your ability to use magic.\n\n");
				hasTrainedToday = true;
			}
			player.trainStat("int", 2 + rand(4), player.trainStatCap("int",100));
			CoC.instance.timeQ = 3;
			explorer.stopExploring();
			doNext(camp.returnToCampUseTwoHours);
		}
		public function LutienMainSex():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You ask Lutien if " + LutienMF("he","she") + " feels like getting intimate with you.\n\n");
			if (WoodElfMagicTraner) {
				outputText("Lutien eyes you intently, \"<i>I will not object to the idea. Do you know what you want?</i>\"\n\n");
				outputText("You pause momentarily to think about it.\n\n");
			}
			else {
				outputText("Lutien eyes you warily, \"<i>I will not object to the idea, though, have you not realized that I am not like the other sisters? More than just my affinity for magic, I am not a woman like the masses.</i>\"\n\n");
				outputText("Wait, really? There are elves that aren’t girls? But he looks so…\n\n");
				outputText("He sighs, \"<i>Yes, I am well aware, but not every elf is made the same. I am sterile, thankfully. The things they’d do to me if they knew I could help produce offspring for them. Still, are you still willing to take up some more… personal time together?</i>\"\n\n");
				outputText("You think about it.\n\n");
				WoodElfMagicTraner = true;
			}
			menu();
			if (WoodElfMagicTranerSex >= 1)
				addButton(0, "Bondage", LutienBondage)
						.hint("Something about his presence is enthralling… let him take control");
			if (WoodElfMagicTranerSex >= 2)
				addButton(1, "Fuck Bussy", LutienFuckBussy)
						.hint(silly()? "Fuck it. A hole is a hole.":"Does it matter if he’s not a girl? He’s still as pretty as any other elf.")
						.disableIf(!player.hasCock(), "You need a penis");
			addButton(2, "Nevermind", LutienMainSexNevermind);
		}
		public function LutienMainSexNevermind():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("Yea nevermind you ain't in the mood for that right now.\n\n");
			outputText("Lutien sigh. \"<i>Yea I figured you must've just been joking. Well, either way, is there anything else I can help you with?</i>\"\n\n");
			doNext(LutienMain);
		}
		private function LutienBondage():void {
			clearOutput();
			outputText("You continue eyeing Lutien's form, something about the soft, gentle feminity wrapped around the form of a male is alluring. His gentle frame continues grasping your attention with a force unwilling to let you go.[pg]");
			outputText("He seems to give you a faint, yet knowing grin, \"<i>I see you've been taking a little more interest in me lately, have you? I don't suppose that could be the effects of the forest taking a pull at you, is it?</i>\"[pg]");
			outputText("Before you can collect yourself, you find your legs gently being wrapped by soft, thin vines. You take a small breath, it's far from a disquieting feeling.[pg]");
			outputText("\"<i>Oh, but it will be more than just the forest, now won't it? After all, if one was so inclined, they can use their magic for... something a tad more salacious.</i>\"[pg]");
			outputText("Something about being bound by vines and left to submit before the femboy calls to you, you find yourself growing comfortable with the idea.[pg]");
			outputText("\"<i>I'm sure you've had thoughts about creative ways to use elven magic. There's always a hint of lewdness deep within, even myself, though I tend not to delve into these fantasies.</i>\"[pg]");
			outputText("He draws himself closer to you, pressing his index finger against the underside of your chin, \"<i>Yet, bondage is such a fun way to abuse your strength as it inhibits your victim's ability to move away.</i>\"[pg]");
			outputText("[if (hasarmor) \"The vines slowly grasp at your garments, tugging them away until you are left barred from any clothes. \"]The flora moves at his whim, a sweet scent washes over you as the vines steadily wrap around you, cradling you with care, yet firm enough to keep you unable to fight back.[pg]");
			outputText("His fingers gingerly trace around your form, admiring the shape of your body. \"<i>Could this be a lesson in magic, one might wonder? Possibly, there's a certain amount of control you must have when using magic deliberately in a non-detrimental way. I have been practicing for ages, so I know you are far from being in any danger from my vines.</i>\"[pg]");
			outputText("The vines continue contorting around you, squeezing at your body gently with loving grasps. Lutien slowly reaches a hand down to stroke your [if (hascock) \"steadily rising erection\"][if (hasvagina && !hascock) \"clit\"][if (!hascock && !hasvagina) \"thigh\"].");
			outputText("\"<i>Can you feel the warmth? There's so much heat growing between us. Perhaps it's the friction of the vines?</i>\"[pg]");
			outputText("He leans closer, his breath barely grazing your face, \"<i>Something more?</i>\"[pg]");
			outputText("The scent of the vines is intoxicating. You can see petals blooming off of them, filling the air with hazy pollen that only further clouds your mind. You're unable to do anything but relax, cradled by the floral embrace as the petals dance around your skin.[pg]");
			outputText("\"<i>I can't remember the last time I had my magic flourish like this. I'm glad I could share it with you.</i>\"[pg]");
			outputText("Lutien shifts toward you, gently pressing his soft lips against yours. The peck is fleeting as he pulls away, leaving you breathless. Maybe it's all the pollen in the air, but it's far from irritating. Moreso, the pollen only adds to heighten your senses.[pg]");
			outputText("He traces his slender digits across your jaw, caressing your face with his soft, feminine hands. \"<i>You know, I don't think I've ever enjoyed myself so much with anyone as much as I am with you right now... </i>\"[pg]");
			outputText("He pulls himself closer, giving you another gentle peck on the lips, \"<i>Are you enjoying it as much as I am?</i>\"[pg]");
			if (player.hasCock()) outputText("The vines slowly grope at your erection, causing you to drool precum as they slowly work away at your resistance.[pg]");
			if (player.hasVagina()) outputText("The vines slowly trace around your labia, prodding at your clit, yet refusing to penetrate you as it works away at your resistance.[pg]");
			outputText("You can feel a familiar pressure building up within your loins as your body tenses within the loving cradle of vines. Lutien continues gently caressing your face, slowly working down to your torso, admiring your chest before bringing his fingers up to your lips.[pg]");
			outputText("\"<i>Hold yourself just a little longer, for me... </i>\"[pg]");
			outputText("He pulls down his finger as he reaches for a final kiss. His presence is soft and delicate. He doesn't give in fully, yet the embrace betrays nothing but passion and genuine interest.[pg]");
			outputText("Unable to take it any longer, you finally hit your climax.[if (hascock) \" Your throbbing erection shooting several waves of seed before him as the vines prod at your cumslit.\"][if (hasvagina) \" You can feel a trail of girlcum gently leak down your thigh as the vines gently pull back from your clit.\"][if (!hascock && !hasvagina) \"he high still not as intense as it could be, yet the gentle presence of the vines still serves to fulfill your desires.\"][pg]");
			outputText("Lutien smiles softly as he pulls back, allowing the vines to recede, laying you on the ground as you slowly catch your breath.[pg]");
			outputText("He reaches a hand toward you to lift you from the earth, \"<i>Was it as good for you as it was for me?</i>\"[pg]");
			outputText("You can't say it was an unpleasurable experience.[pg]");
			outputText("He smiles warmly, \"<i>Good, I hope we can try this again later... I'll be seeing you around, then.</i>\"[pg]");
			player.sexReward();
			endEncounter();
		}
		private function LutienFuckBussy():void {
			clearOutput();
			var x:int = player.longestCock();
			outputText("You continue eyeing Lutien's form. His soft, boyish hips. His petite figure and silky locks of blonde hair. He's gorgeous, to say the least. His glance moves to meet yours as you continue examining him.[pg]");
			outputText("\"<i>Enraptured, are you? Perhaps you'd like to get to know me on a more personal level? I wouldn't object, it'd be quite a new experience for me.</i>\"[pg]");
			outputText("You decide to take up on the offer as you approach him[if (hasarmor) \", discarding your (armor) until there's nothing left to hold you back\"]. Your body is free to take in the open air, to be one with nature, right? Lutien follows your steps, pulling back his hood as he removes the light garments holding back his frame as your bare figure makes contact with him.");
			outputText("[if (tallness <= 4*12) \" Despite how much taller he is, you're still going to let him know what it means to be topped.\"]"+(player.cocks[x].cockLength >= 7 ?" His tiny manhood pales in comparison to your [cock].":"")+"[pg]");
			outputText("\"<i>Come on, show me everything you're made of. Take me, hold me tightly as I submit. I want to feel you inside me.</i>\"[pg]");
			outputText("Without hesitation, you lift him against the bark of a nearby tree as he reflexively wraps his legs around your waist. His small dick erecting in anticipation as you align your girth to his petite underside. His bussy seems to be quite lubricated already. Before you can question it, he gives you a small wink.[pg]");
			outputText("You pull him in for a kiss, his soft, delicate lips pressing against you as you hold his head, admiring the silkiness of his fine hair before you begin thrusting.[pg]");
			outputText("His hole tightens around you, gripping eagerly in an attempt to coax more of your rod into him."+(player.cocks[x].cockLength >= 7 ?" His breathing staggers at the intake, clearly not used to something of this magnitude. ":"") + "He pulls back slightly, \"<i>Ahh... a warmth like no other... I... I could get used to this, [name].</i>\"[pg]");
			outputText("You buck into the elf's ass again[if (hasballs)\", your balls hitting his underside with each forceful thrust\"]. You're going to make sure he remembers you as you pull him in deeper into another kiss, causing him to moan into your embrace.[pg]");
			outputText("His hole tightens intently as his legs wrap tighter around you. His high-pitched moaning rings through the kiss as he cums, spraying traces of cum around your [chest]. You can feel yourself quickly reaching orgasm as his hole rhythmically clenches around you, desperate for you to fill him with your seed.[pg]");
			outputText("Moaning back softly, you can feel your cock twitch ardently. You force the elf on the ground as you give him a final thrust, digging your [cock "+x+1+"] as deep into him as possible as you elicit another moan from the elf. You finally cum, unloading every ounce of cum you have into his waiting hole.[pg]");
			outputText("Lutien breathes softly, exhausted as you pull out your deflating erection. \"<i>Hah... that was... definitely an experience like no other... I wouldn't argue about looking into it again if you were ever to ask... </i>\"[pg]");
			outputText("He brushes himself off, cum still leaking out of his bussy. \"<i>I'll get us cleaned up, then you can return to other matters.</i>\"[pg]");
			player.sexReward();
			endEncounter();
		}

		public function Chelsea():void {
			if (WoodElfSeductionTraining == QUEST_STAGE_SEDUCTIONTRAINING0) ChelseaIntro();
			else ChelseaMain();
		}
		public function ChelseaIntro():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("As you explore the elven village you run into a sister you haven't met before, well at least not personally. She looks like all of your other sisters at a first glance, golden hairs, green eyes and white clothes but what sets her apart is her sheer tallness as well as the prodigious size of her breast. Easily 7 feet tall she towers above everyone else. The big sister notices your attention and chuckles.[pg]");
			outputText("\"<i>Oh my if it ain't sister [name] we haven't been acquainted since you hang all the time with Merisiel, Allysa or Elenwen. Not that I blame them, my appearance is somewhat intimidating for an elf in more ways than one.</i>\" She punctuates her sentence by holding her J cup breasts with both hands to pass the point across. Any elf would feel intimidated by the sheer size of those orbs. How is she not developing back problems in the first place![pg]");
			outputText("\"<i>Eyes up not down sister.</i>\" The busty elf laughs and you realise you've been staring. \"<i>Names Chelsea and I'm the village resident blacksmith. About every gear from weapons to armor is made by me. I overheard you used to be human or something heck you even got your memory back. Me? Well I was told I used to be a lacta bovine surely that'd explain the ridiculous size of my chest. I forgot everything about my past self post awakening so can't "+
						"confirm if this is true, not that it matters. As it happens, the sacred tree doesn't discriminate; it can turn about just anything into an elf, provided it's not too big, has a soul, and is somewhat sentient. If it's a guy, it makes a girl out of it, though we've seen rare cases where even the tree was powerless to fully genderbend a man. Regardless, I heard you're on some grand quest, or something about saving the land. Maybe even purify the tree... well now "+
						"THAT would be great though looking at you I can't really see how you plan to defeat the demon army all by yourself.</i>\"[pg]");
			outputText("Sure you plan to defeat the demons. Is she assuming you lack the conviction to do it or something?[pg]");
			outputText("\"<i>Oh not at all though if you're so keen to defeat the fiends I could teach you one or two things about seduction.</i>\"*[pg]");	//TODO Ask about asterisk in doc
			outputText("You raise an eyebrow coughing as you process the last sentence, did she just say seduction?[pg]");
			outputText("\"<i>Do understand sister demons greatest weapon is sex and desire but it's also their biggest weakness. While you should avoid fighting demons on their own terms you will inevitably have to win a few battles through the power of guile, seduction and a few frustrated dicks. Thankfully your body like mine was made for temptation.</i>\"[pg]");
			outputText("What is she getting at? You're perfectly adept at sex just as any elf is![pg]");
			outputText("\"<i>Yes but not necessarily at teasing. Do trust me, I've developed and made many new techniques even the demons would spontaneously cum at. Want me to teach you some of them?</i>\"[pg]");

			menu();
			addButton(1, "Sure Sis", ChelseaTraining1);
			addButton(3, "Nah", ChelseaTraining1No);
		}
		public function ChelseaTraining1():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("Chelsea disrobes, encouraging you to do the same as she heads toward her tent letting you in.[pg]");
			outputText("\"<i>First things first, we need to train your endurance, wouldn't want you to end up with weak shaking legs because a demon nibbled on your ear tips. You need to be in perfect control of your own pleasure rather than let it control you.</i>\"[pg]");
			outputText("Without surprise she goes directly for your weak spot licking your pointy ear tip. You're about to jump her in a lust induced frenzy when she calmly reminds you \"<i>You need to endure and control your lust sister. I can see you're boiling with needs but improving your resistance is the very purpose of this training.</i>\"[pg]");
			outputText("Begrudgingly you temper your desire her touch however is like a wave crashing down on the sandcastle that is your crumbling countenance and before long you beg her to fuck you one way or another.[pg]");
			outputText("\"<i>Well sister I see you've done your best and will reward you for it. Go ahead and lose yourself in your big sister's lovely pillows.</i>\"[pg]");
			outputText("She lay on her back into the grass and opens her arms to you, welcoming you to her bosom and you gladly take on her offer resting your head against her prodigious chest as she pulls her hand toward your aching pussy, a finger expertly exploring your drooling cunny. You moan loudly as your eldest gently massages your hole all the way toward a full peak causing you to cum gracefully on her hand with some of your juice splashing on the nearby grass. ");
			outputText("You ride this orgasm for a few seconds, losing yourself in the bright green of the eyes of your partner before slowly matching your excited breath back down to the rhythm of the ambient natural world.[pg]");
			outputText("Chelsea comments as you both redress \"<i>Not a bad effort for a first time. Still do come back to me later you definitely could use improved self control especially if you plan to take the demons down. Don't you worry sis I will train you into a pillar of willpower and stamina even demons charm won't be able to overcome.</i>\"[pg]");
			outputText("On this you wave goodbye and head back to camp.[pg]");
			hasTrainedToday = true;
			player.SexXP((5+player.level) * 10);
			player.trainStat("lib", 4, player.trainStatCap("lib",100));
			WoodElfSeductionTraining = QUEST_STAGE_SEDUCTIONTRAINING2;
			endEncounter();
		}
		public function ChelseaTraining1No():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You decline Chelsea offer fully confident in your own skills.[pg]");
			outputText("\"<i>Well if you ever need your big sister assistance just come to me and ill teach ya everything there is to sex and controlling your desires.</i>\"[pg]");
			WoodElfSeductionTraining = QUEST_STAGE_SEDUCTIONTRAINING1;
			endEncounter();
		}
		public function ChelseaMain():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You visit Chelsea hoping to improve your self control. The busty elf is busy gathering flowers in the nearby meadow but deposits her basket the moment she sees you.[pg]");
			outputText("\"<i>Good day [name] you came at just the right time I was about done here. Have you come to train or are you just here for a chat?</i>\"")

			menu();
			if (WoodElfSeductionTraining == QUEST_STAGE_SEDUCTIONTRAINING1)
				addButton(1, "Sure Sis", ChelseaTraining1);
			else
				addButton(1, "Train", ChelseaTrainingRandom);
			addButton(3, "See Ya", ChelseaTrainingNo);
		}
		public function ChelseaTrainingNo():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			outputText("You tell her you just wanted to say hello really. You two talk of everything and nothing before you say your goodbye and head back to the elven commons. Chelsea waves you goodbye before you go.[pg]");
			outputText("\"<i>Come back anytime, I will be right here.</i>\"[pg]");
			endEncounter();
		}
		public function ChelseaTrainingRandom():void {
			clearOutput();
			spriteSelect(SpriteDb.s_WoodElves);
			var randomTrain:int = rand(2);
			if (randomTrain == 0) ChelseaRandomTrain0();
			else if (randomTrain == 1) ChelseaRandomTrain1();
		}
		public function ChelseaRandomTrain0():void {
			outputText("Chelsea disrobe and encourage you to do the same as she heads toward her tent letting you in.[pg]");
			outputText("\"<i>Today we will first train your endurance, wouldn't want you to end up with weak shaking legs because a demon nibbled on your ear tips. You need to be in perfect control of your own pleasure rather than let it control you.</i>\" [pg]");
			outputText("Without surprise she goes directly for your weak spot licking your pointy ear tip. You're about to jump her in a lust induced frenzy when she calmly reminds you \"<i>You need to endure and control your lust sister. I can see you're boiling with needs but improving your resistance is the very purpose of this training.</i>\"[pg]");
			outputText("Begrudgingly you temper your desire her touch however is like a wave crashing down on the sandcastle that is your crumbling countenance and before long you beg her to fuck you one way or another.[pg]");
			outputText("\"<i>Well sister I see you've done your best and will reward you for it. Go ahead and lose yourself in your big sister's lovely pillows.</i>\"[pg]");
			outputText("She lay on her back into the grass and opens her arms to you, welcoming you to her bosom and you gladly take on her offer resting your head against her prodigious chest as she pulls her hand toward your aching pussy, a finger expertly exploring your drooling cunny. You moan loudly as your eldest gently massages your hole all the way toward a full peak. You ain't sure if it's just her technique, her past life experience or just the fact she is an "+
						"elf far older than you but her fingers do magic even the best cock would fail to, her precise movement causing you to cum gracefully on her hand with some of your juice splashing on the nearby grass. You ride this orgasm for a few seconds, losing yourself in the bright green of the eyes of your partner before slowly matching your excited breath back down to the rhythm of the ambient natural world.[pg]");
			outputText("Chelsea comments as you both redress \"<i>Not a bad effort it's definitely better than the last time. Still do come back to me later you definitely could use more self control especially if you plan to take the demons down. Don't you worry sis I will train you into a pillar of willpower and stamina even demons charm won't be able to overcome.</i></i>\"[pg]");
			outputText("On this you wave goodbye and head back to camp.[pg]");
			hasTrainedToday = true;
			player.SexXP((5+player.level) * 10);
			player.trainStat("lib", 4, player.trainStatCap("lib",100));
			endEncounter();
		}
		public function ChelseaRandomTrain1():void {
			outputText("Chelsea disrobe and encourage you to do the same as she heads toward her tent letting you in.[pg]");
			outputText("\"<i>Today we will train your empathy. You need to be receptive to your partner or opponent's reaction. It might come to you as no surprise but in battle most opponents won't act honest and when they do it can be difficult to pinpoint whether your performance was bad or not. By reading the subtle hints in their expression and movement you can improve and refine your skill as a seducter or just make yourself better at lovemaking. "+
						"Your willing partners will thank you for it, some of the unwilling ones too.</i>\"[pg]");
			outputText("She takes your hand and guides you to the bed, laying down next to you.[pg]");
			outputText("\"<i>Your other sisters likely taught you to play some musical instruments or do other refined things. Sex is like a melody, and the partner is your instrument, her moans the note. To draw out the most honest and clear notes, you need to play your partner with care. Today is girl-on-girl, but a penis is just a different instrument; you simply need to be attentive to the notes you play, and the music will come out naturally.</i>\"[pg]");
			outputText("She insert a finger into your quivering flower making you gasp as she move your hand to hers sliding your digit into her pussy.[pg]");
			outputText("\"<i>The bee girls have a similar game to this one however for you this is training. For each good note you draw from me today I will reciprocate to you. Pay attention to the response so you can reproduce it.</i>\"[pg]");
			outputText("Tentatively you begin fondling your teacher, using whatever skill you accumulated this far to find her good spot and draw out a moan. She rewards your attention with a moan of your own each time you hit a good spot. Seeking out her highs so to increase your own pleasure you manage to progressively adjust and improve your touch until eventually Chelsea grants you an amazing orgasm. It plays out like this for a fair hour until, utterly spent, "+
						"you close your eyes and rest in Chelsea's arms using her breast as your pillow. Your big sister caresses your forehead the whole time singing a slow lullaby, guess she doesn't get those moments all that often.[pg]");
			outputText("Later when you wake up Chelsea comments as you both redress \"<i>Not a bad effort it's definitely better than the last time. Still do come back to me later you definitely could use more empathy training especially if you plan to take the demons down. Don't you worry sis I will train you until your senses are as sharp as the edge of an elven glaive.</i>\"[pg]");
			outputText("On this you wave goodbye and head back to camp.[pg]");
			player.SexXP((5+player.level) * 10);
			player.trainStat("lib", 4, player.trainStatCap("lib",100));
			if (player.hasPerk(PerkLib.GracefulBeauty) && !player.hasPerk(PerkLib.SweepDefenses) && !hasTrainedToday && player.lib >= 200) {
				player.createPerk(PerkLib.SweepDefenses,0,0,0,0);
				outputText("\n\nBetter refining of your charms allowed you to learn a new technique. <b>Gained Perk: Sweep Defenses</b>");
				hasTrainedToday = true;
			}
			else if (player.hasPerk(PerkLib.FueledByDesire) && !player.hasPerk(PerkLib.GracefulBeauty)  && !hasTrainedToday && player.lib >= 150) {
				player.createPerk(PerkLib.GracefulBeauty,0,0,0,0);
				outputText("\n\nBetter refining of your charms allowed you to learn a new technique. <b>Gained Perk: Graceful Beauty</b>");
				hasTrainedToday = true;
			}
			else if (!player.hasPerk(PerkLib.FueledByDesire) && player.lib >= 100  && !hasTrainedToday) {
				player.createPerk(PerkLib.FueledByDesire,0,0,0,0);
				outputText("\n\nBetter refining of your charms allowed you to learn a new technique. <b>Gained Perk: Fueled by Desire</b>");
				hasTrainedToday = true;
			}
			else {
				hasTrainedToday = true;
			}
			//New Legendary Armor: Forest Mage Dress	//TODO special effect with green magic, other effects complete
			//Type: Light
			//Armor: 0
			//Effect: Slutty Seduction 10, Wizard Endurance 60. Increase tease total damage by x 2 when worn by a wood elf. Inflicting Tease damage reduces the wielder's own lust by a small amount.
			//The wearer of this dress desire and pleasure is no longer vexed by the limitations of mortal flesh allowing one to keep control over their lust long enough to claim victory by diluting their own lust within the ambiant natural world for a time. So long as a Green Magic spell was cast within the 5 previous rounds the user of this dress effectively is able to maintain their focus and mind entirely to the task at hand at the cost of potentialy turning into a lecherous sex maniac due to all the dilluted lust merging back with the user at the end of combat. There is a small chance for this to backfire instead causing the ambiant flora to turn on and rape the wearer of the dress.

			endEncounter();
		}

		public function CaptureGoblin():void {
			clearOutput();
			outputText("You eye down the defeated goblin pondering the question for a moment before a sinister shaded smile makes way on your beautiful elven face.[pg]");
			outputText("\"<i>Uh girl, why are you looking at me like that? I can feel the bad vibe all the way here!</i>\"[pg]");
			outputText("She might be a few feet short but that's nothing the sacred tree can't fix if anything she will just make for a smaller one. You grab the nearest blunt object you can find and promptly knock the goblin out before hoisting her on your shoulder. It's a little way from here and you don't want the green pest to struggle.[pg]");
			outputText("You begin walking all the way to the nearest sacred tree holding the unconscious goblin on your shoulder. You instinctively know which tree is what thanks to their leaf coloration and patterns and it doesn't take you long to find the elven territory border. You grab the goblin by waist and offer it to the nearest tree which hungrily open up, its tentacle like vines seizing the offering just as the goblin finally wakes up in time for a cute panicked scream. You can feel the comforting approval within its groaning bark as the goblin is gobbled up, you are a good daughter.[pg]");
			outputText("A few seconds later silence reigns again in the forest and you can all too well imagine all the delight your newest sister is experiencing right now behind the bark lid. After all, you did get to experience it firsthand. A little hot from the whole imagery you lie next to the tree bark and begin feverishly masturbating when the new elf is finally expelled from the tree womb through the wooden knot you now know to be the tree vaginal lips, guess your own fun can wait for later. [pg]");
			outputText("The new girl is barely above 4 feet tall which is altogether within expectation seeing as new elves tend to keep some remaining traces of their original race attributes. You came out average thanks to your very high compatibility for transformation, which is less than can be said for her. With a few reassuring words you gently grab the hands of the new girl and guide her all the way to the village. Merisiel sees you walk around with a new sister in tow and comes over to you.[pg]");
			outputText("\"<i>Oh my! You actually found a new one, And shes so tiny and cute! Want me to pick her up for you?</i>~♥\"[pg]");
			outputText("You know her well, she just can't resist a new girl, especially when she's cute. Sure she can have her, though that means she's taking responsibility for taking care of her for the first few weeks until the ceremony.[pg]");
			outputText("\"<i>Why this is no problem sister. Feel free to bring more like her here, we will take good care of them.</i>\"[pg]");
			outputText("With a sense of duty accomplished you leave back for your camp. The fruit of your labor will probably come apparent only within a few days when the new sister formally joins the community. For now it's off to adventures with you![pg]");
			CapturedSisters.push(7);
			cleanupAfterCombat();
		}
		public function CaptureCultist():void {
			clearOutput();
			outputText("You eye the defeated cultist, pondering the question for a moment before a sinister shaded smile makes its way on your beautiful elven face. Yep she/he is the ideal size and proportion. The cultist, unsure about your creepy attitude, tries and awkwardly opens the conversation.[pg]");
			outputText("\"<i>So uh we having sex now or what?</i>\"[pg]");
			outputText("Sex? Nah… better. Way better! You grab the nearest blunt object you can find and promptly knock the human out before hoisting him/her on your shoulder. It's a little way from here and you don't want the crazy to struggle.[pg]");
			CaptureANewSisterMerge();
		}
		public function CaptureCowgirl():void {
			clearOutput();
			outputText("You eye down the defeated cowgirl pondering the question for a moment. She's quite taller than the common morph or human, which may result in something weird happening but you brush off the concern as you do remember that such anomalies do already exist, your big sister Chelsea is an example of it. A sinister shaded smile makes way on your beautiful elven face.[pg]");
			outputText("Yep she is the ideal size and proportion. The cowgirl, unsure about your creepy attitude, tries and awkwardly opens the conversation.[pg]");
			outputText("\"<i>So uh, are you planning on milking me or not?</i>\"[pg]");
			outputText("Milking? Nah… better way better! You grab the nearest blunt object you can find and promptly knock the cow out before hoisting her on your shoulder. It's a little way from here and you don't want the crazy to struggle.[pg]");
			CaptureANewSisterMerge();
		}
		public function CaptureMinotaur():void {
			clearOutput();
			outputText("A weird idea comes to your mind. Why not test out if the sacred tree can process a [monster name] and if so would the result be a big dicked elf herm?[pg]");
			outputText("Licking your lips you knock the defeated [monster name] out and get to moving the massive hunk of a beast toward the woods.[pg]");
			outputText("Traveling with the [monster name] is a massive pain and sometimes you ponder if riding a horse format elf dong is worth the effort but everytime the oaf wakes up you bring him back unconscious and fantasize about it.[pg]");
			outputText("Eventually in the forest, you instinctively know which tree is what thanks to their leaf coloration and patterns and it doesn't take you long to find the elven territory border. You pull up the [monster name] and offer it to the nearest tree which hungrily opens up, its tentacle like vines seizing the offering just as the bull finally wakes up in time for a panicked final struggle. You can feel the comforting approval within its groaning bark as the [monster name] is dragged kicking and screaming, you are a good daughter.[pg]");
			outputText("A few seconds later silence reigns again in the forest and you can all too well imagine all the delight your newest sister is experiencing right now behind the bark lid. After all, you did get to experience it firsthand. A little hot from the whole imagery you lie next to the tree bark and begin feverishly masturbating when the new elf is finally expelled from the tree womb through the wooden knot you now know to be the tree vaginal lips, guess your own fun can wait for later.[pg]");
			outputText("The new girl comes out eventually and to your absolute disappointment the former minotaur's amazing tool is all but nearly gone. All that's left of it is a 6 inch human shaped penis sitting on a somewhat amazonesque hermaphrodite elven body. She's seven feet tall and could pass for Chelsea's close relative if not for the tiny dong hanging between her legs. With a few reassuring words you gently grab the hands of the new girl and guide her all the way to the village. Merisiel sees you walk around with a new sister in tow, come over to you.[pg]");
			outputText("\"<i>Well what did you get us this time sis? Sorry to disappoint you but it's not the first time someone tried that idea. Eh better luck next time as they say…</i>\"[pg]");
			outputText("Despite how the newcomer turned out you want her to be well taken care of. Merisiel sighs at this.[pg]");
			outputText("\"<i>Sure I will handle the big girl for you but really next time I'd prefer you got someone smaller.</i>\"[pg]");
			outputText("She takes the hand of the herm elf and heads toward the village tent. A little disappointed by the result you leave back for your camp. The fruit of your labor will probably come apparent only within a few days when the new sister formally joins the community. For now it's off to adventures with you![pg]");
			CapturedHerms.push(7);
			cleanupAfterCombat();
		}
		public function CaptureANewSister():void {
			clearOutput();
			outputText("You eye the defeated [monster name], pondering the question for a moment before a sinister shaded smile makes its way on your beautiful elven face. Yep she/he is the ideal size and proportion. [Themonster], unsure about your creepy attitude, tries and awkwardly opens the conversation.[pg]");
			outputText("\"<i>So uh we having sex now or what?</i>\"[pg]");
			outputText("Sex? Nah… better. Way better! You grab the nearest blunt object you can find and promptly knock the [monster name] out before hoisting him/her on your shoulder. It's a little way from here and you don't want the crazy to struggle.[pg]");
			CaptureANewSisterMerge();
		}
		public function CaptureANewSisterMerge():void {
			outputText("You begin walking all the way to the nearest sacred tree holding the unconscious [monster guy] on your shoulder. You instinctively know which tree is what thanks to their leaf coloration and patterns and it doesn't take you long to find the elven territory border. You pull up the human and offer it to the nearest tree which hungrily opens up, its tentacle like vines seizing the offering just as [themonster] finally wakes up in time for a panicked scream. You can feel the comforting approval within its groaning bark as [themonster] is dragged kicking and screaming, you are a good daughter.[pg]");
			outputText("A few seconds later silence reigns again in the forest and you can all too well imagine all the delight your newest sister is experiencing right now behind the bark lid. After all, you did get to experience it firsthand. A little hot from the whole imagery you lie next to the tree bark and begin feverishly masturbating when the new elf is finally expelled from the tree womb through the wooden knot you now know to be the tree vaginal lips, guess your own fun can wait for later.[pg]");
			outputText("The new girl comes out just right heck if not for a few variations she could very well be a copy of you. With a few reassuring words you gently grab the hands of the new girl and guide her all the way to the village. Merisiel sees you walk around with a new sister in tow, come over to you.[pg]");
			outputText("\"<i>Oh my! You actually found a new one! Want me to pick her up for you?</i>~♥\"[pg]");
			outputText("You know her well, she just can't resist a new girl, especially when she's cute. Sure she can have her, though that means she's taking responsibility for taking care of her for the first few weeks until the ceremony.[pg]");
			outputText("\"<i>Why this is no problem sister. Feel free to bring more like her here, we will take good care of them.</i>\"[pg]");
			outputText("With a sense of duty accomplished you leave back for your camp. The fruit of your labor will probably come apparent only within a few days when the new sister formally joins the community. For now it's off to adventures with you![pg]");
			CapturedSisters.push(7);
			cleanupAfterCombat();
		}
		public function ConvertNewSisters():Boolean {
			var needNext:Boolean;
			for (var sister:int = CapturedSisters.length-1; sister >= 0; sister--) {
				if (--CapturedSisters[sister] <= 0){
					ConvertedSisters++;
					CapturedSisters.removeAt(sister);
					outputText("\nYou sense one of your new elf sisters has completed the covenant.\n");
					needNext = true;
				}
			}
			for (var herm:int = CapturedHerms.length-1; herm >= 0; herm--) {
				if (--CapturedHerms[herm] == 0){
					ConvertedHerms++;
					CapturedHerms.removeAt(herm);
					outputText("\nYou sense one of your new elf sisters has completed the covenant.\n");
					needNext = true;
				}
			}
			if (needNext) {
				if (!player.hasPerk(PerkLib.OneWiththeForest)) {
					outputText("<b>You acquired the Perk One with the forest</b>.");
					player.createPerk(PerkLib.OneWiththeForest, 1, 0, 0, 0);
					player.statStore.addBuffObject({
						"str.mult": 0.01,
						"tou.mult": 0.01,
						"spe.mult": 0.01,
						"int.mult": 0.01,
						"wis.mult": 0.01,
						"lib.mult": 0.01
					}, 'Elf Sisters', {text: 'Elf Sisters'});
				}
				player.ElfSistersBonus();
			}
			return needNext;
		}
	}
}