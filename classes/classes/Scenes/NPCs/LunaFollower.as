/**
 * ...
 * @author Liandri, edited by Scary Dragon Mom
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.Items.MutationsHelper;
import classes.Stats.Buff;
import classes.display.SpriteDb;
import classes.internals.SaveableState;

public class LunaFollower extends NPCAwareContent implements SaveableState
	{
		public var mutations:MutationsHelper = new MutationsHelper();
		public static var Nursed:Boolean;
		public static var NursedCooldown:int;
		public static var Sated:Boolean;
		public static var SatedCooldown:int;

		public function stateObjectName():String {
			return "LunaFollower";
		}

		public function resetState():void {
			Nursed = false;
			NursedCooldown = 0;
			Sated = false;
			SatedCooldown = 0;
		}

		public function saveToObject():Object {
			return {
				"LunaNursed": Nursed,
				"LunaNursedCooldown": NursedCooldown,
				"LunaSated": Sated,
				"LunaSatedCooldown": SatedCooldown
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				Nursed = o["LunaNursed"];
				Sated = o["LunaSated"];
				if ("LunaNursedCooldown" in o) {
					// new save, can load
					NursedCooldown = o["LunaNursedCooldown"];
				} else {
					// old save, still need to set NursedCooldown  to something
					NursedCooldown = 0;
				}
				if ("LunaSatedCooldown" in o) {
					// new save, can load
					SatedCooldown = o["LunaSatedCooldown"];
				} else {
					// old save, still need to set NursedCooldown  to something
					SatedCooldown = 0;
				}
			} else {
				// loading from old save
				resetState();
			}
		}

		public function LunaFollower()
		{
			Saves.registerSaveableState(this);
		}
		//luna follower flag: 2 - kicked post moon event, 3 seen her dead in forest, 4,5 - pre full moon event, 6 jelly pre full moon, 7,8 - post moon unchained, 9,10 - post moon chained, 11,12 - unchained post moon accepted (PC no WW), 13,14 - unchained post moon accepted and talked about lycantrophy (PC no WW), 15,16 - unchained post moon accepted (PC WW)
		public function lunaAffection(changes:Number = 0):Number
		{
			flags[kFLAGS.LUNA_AFFECTION] += changes;
			if (flags[kFLAGS.LUNA_AFFECTION] > 100) flags[kFLAGS.LUNA_AFFECTION] = 100;
			return flags[kFLAGS.LUNA_AFFECTION];
		}
		public function lunaJealousy(changes:Number = 0):Number
		{
			flags[kFLAGS.LUNA_JEALOUSY] += changes;
			if (flags[kFLAGS.LUNA_JEALOUSY] > 400) flags[kFLAGS.LUNA_JEALOUSY] = 400;
			if (flags[kFLAGS.LUNA_JEALOUSY] < 0) flags[kFLAGS.LUNA_JEALOUSY] = 0;
			return flags[kFLAGS.LUNA_JEALOUSY];
		}

		public function mainLunaMenu():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			if (isNightTime && flags[kFLAGS.LUNA_MOON_CYCLE] == 8 && flags[kFLAGS.LUNA_FOLLOWER] >= 7 && flags[kFLAGS.LUNA_JEALOUSY] >= 400) {
				SceneLib.lunaFollower.fullMoonEvent(true,true);
			} else {
				outputText("You call out to Luna, who immediately stops what she's doing and trots over to you as quickly as her professional dignity permits. She straightens her skirt and addresses you with a polite bow.\n\n" +
						"\"<i>Good </i>");
				if (model.time.hours >= 6 && model.time.hours <= 11) outputText("<i>morning</i>");
				else if (model.time.hours <= 18) outputText("<i>afternoon</i>");
				else outputText("<i>evening</i>");
				outputText(" <i>" + player.mf("Master","Mistress") + ", I await your orders with pleasure.</i>\"\n\n");
				menu();
				addButton(0, "Appearance", LunaAppearance);
				addButton(1, "Talk", talkMenuLuna);
				if (flags[kFLAGS.LUNA_FOLLOWER] > 4) {
					addButton(3, "Meal", mealLuna);
					addButton(4, "Nurse", nurseLuna);
					button(4).disableIf(player.HP >= player.maxOverHP() && !player.statStore.hasBuff("Curse"), "You are currently in perfect health.");
					button(4).disableIf(Nursed, "Luna needs time to recharge her Mana before she can heal you again. Try tomorrow.");
				}
				if (flags[kFLAGS.LUNA_AFFECTION] >= 50) {
					if (flags[kFLAGS.SLEEP_WITH] != "Luna") addButton(5, "Sleep With", lunaSleepToggle);
					else addButton(5, "Sleep Alone", lunaSleepToggle);
				}
				if (flags[kFLAGS.LUNA_FOLLOWER] > 10) {
					if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) addButton(2, "Spar", sparLuna);
					addButton(6, "Sex", sexMenuMain);
				}
				if (flags[kFLAGS.LUNA_FOLLOWER] == 9 || flags[kFLAGS.LUNA_FOLLOWER] == 10) addButton(7, "Unchain", lunaChainToggle).hint("Unchain Luna, if you dare.");
				if (flags[kFLAGS.LUNA_FOLLOWER] == 7 || flags[kFLAGS.LUNA_FOLLOWER] == 8) addButton(7, "Chain", lunaChainToggle).hint("Chain Luna before it's too late.");
				addButton(14, "Leave", camp.campFollowers);
			}
		}

		public function LunaAppearance():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			if (flags[kFLAGS.LUNA_FOLLOWER] < 7) {
				outputText("Luna is a human maid. She wears a black regency dress with a frilly white apron and hairband. Her large, golden eyes are trained on you, watching you almost unblinkingly for the first sign of need or inconvenience. Intensity aside, her face is more sweet than classically beautiful, with small features and a cute smile that shines through at odd moments");
				if (camp.companionsCount() > 1) outputText(", though you could swear you see her making a different expression sometimes when you visit your other companion");
				if (camp.companionsCount() > 2) outputText("s");
				if (camp.companionsCount() > 1) outputText(" in the camp");
				outputText(". Her ashen hair, partially concealed beneath her white hairband, perfectly completes her look.\n\n" +
						"Luna’s body is average-sized, with modest but shapely C cup breasts and refreshingly normal proportions, after seeing so many distorted, oversexual forms in this world. Her thighs are modest, but plump up very pleasingly above her long white stockings when you manage to glimpse them under her dress. She wears a pair of tidy black shoes on her small feet; how she keeps them so perfectly shiny and unscuffed out here in the rocky campsite is a mystery.\n\n");
			}
			else {
				outputText("Luna is a werewolf maid. While she spends most of the day as a human, at night or when agitated she assumes a large wolf-morph shape. When human she wears a black regency dress with a frilly white apron and hairband, but prefers to go naked on full moon nights to avoid accidentally destroying her clothes. You know better and can sometimes spot the flash of a green glow, which is the only warning of the beast within when she assumes human shape." +
						"Her large, golden eyes are trained on you, watching you, almost unblinkingly, for the first sign of need or inconvenience. Intensity aside, her face is more sweet than classically beautiful, with small features and cute smile that shines through at odd moments");
				if (camp.companionsCount() > 1) outputText(", though you could swear you see her making a different expression sometimes when you visit your other companion");
				if (camp.companionsCount() > 2) outputText("s");
				if (camp.companionsCount() > 1) outputText(" in the camp");
				outputText(". Her ashen hair, partially concealed beneath her white hairband, perfectly completes her look, and is always carefully brushed after a full moon or other... accident, as formality demands.\n\n" +
						"As a human, Luna’s body is average-sized, with modest but shapely C cup breasts and refreshingly normal proportions, after seeing so many distorted, oversexual forms in this world. Her thighs are modest, but plump up very pleasingly above her long white stockings when you manage to glimpse them under her dress. She wears a pair of tidy black shoes on her small feet; how she keeps them so perfectly shiny and unscuffed out here in the rocky campsite is a mystery. However, on the night of a full moon, she becomes a seven-foot tall wolf-morph with firm DD breasts, washboard abs, wide hips and a taut, shapely ass beneath her muscular waist, and thighs you're sure could crack walnuts. The paws at the ends of her muscular arms and legs are large and padded, with claws as big as a bear's, but her ears and tail are delightfully fuzzy. You're too polite, or perhaps afraid, to ask her to keep her stockings on during her transformation to see what her feet would look like bursting out of the ends of them, but you can and do imagine it.\n\n");
			}
			doNext(camp.returnToCampUseOneHour);
		}

		public function talkMenuLuna():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You tell Luna you have some questions for her.\n\n");
			outputText("\"<i>Certainly, " + player.mf("Master","Mistress") + ". What do you wish to know?</i>\"\n\n");
			menu();
			addButton(0, "Her", talkMenuLunaHer).hint("Ask Luna a bit more about herself - how she came to Mareth and ended up in Tel'Adre.");
			addButton(1, "Service", talkMenuLunaWhatCanSheDo).hint("Ask what she can do for you.");
			addButton(2, "Human", talkMenuLunaHuman).hint("Humans seem pretty rare her in Mareth, you've noticed.");
			addButton(3, "Camp", talkMenuLunaCampThoughts).hint("Ask her her thoughts on her new place of work.");
			if (flags[kFLAGS.LUNA_FOLLOWER] > 6) addButton(4, "Lycanthropy", talkMenuLunaLycanthropy).hint("Yeah, humans <b>are</b> pretty rare huh? Find out more about Luna's condition.");
			else addButtonDisabled(4, "???", "You need to know her better for this.");
			if (player.statusEffectv1(StatusEffects.LunaWasCaugh) >= 3)addButton(7, "Accuse", talkMenuLunaStopJealousy).hint("You know it was her, and it needs to stop now.");
			if ((flags[kFLAGS.LUNA_FOLLOWER] == 13 || flags[kFLAGS.LUNA_FOLLOWER] == 14) && !player.hasPerk(PerkLib.Lycanthropy) && !player.hasPerk(PerkLib.LycanthropyDormant)) addButton(9, "Bite Me", talkMenuBiteMe).hint("This is a terrible idea!");
			addButton(14, "Back", mainLunaMenu);
		}
		public function talkMenuLunaHer():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You ask her how long she has worked as a maid.\n\n");
			outputText("\"<i>Of course, " + player.mf("Master","Mistress") + ". I entered the service of my first mistress as an apprentice at the age of ten, and worked in a few other noble houses before completing my training as a young woman. The incident at the magic shop which brought me here occurred at my fifth assignment, when I was twenty-one, and that was six months ago.</i>\"\n\n");
			outputText("Does she enjoy the work?\n\n");
			outputText("\"<i>I do," + player.mf("Master","Mistress") + ", very much so! Getting to care for " + player.mf("Master","Mistress") + ", in every <b>possible</b> way, with everything I need to do it available to me... ahhhh, the smile on " + player.mf("Master","Mistress") + "'s face while eating a perfectly cooked meal, " + player.mf("his","her") + " contented sigh after I nurse " + player.mf("him","her") + " wounds... " + player.mf("his","her") + " perfect, helpless sleeping face when I-</i>\"\n\n");
			outputText("Luna suddenly cuts off her increasingly impassioned speech as she looks up at you for a moment, eyebrow twitching slightly.\n\n");
			outputText("\"<i><b>Ahem,</b></i>\" she quietly coughs as she recomposes herself, before resuming her normal tone of stoic professionalism. \"<i>Suffice to say, yes, I find my work quite satisfying, so please be at ease and make <b>full</b> use of my services, " + player.mf("Master","Mistress") + ".</i>\n\n");
			if (flags[kFLAGS.LUNA_FOLLOWER] > 6) outputText("You could swear you see the faintest flash of green in her eyes as she finishes, but perhaps it was your imagination?\n\n");
			if (player.cor >= 60) outputText("Of course, it's those tantalizing glimpses of her true, corrupted nature that make her so cute, you think to yourself happily... definitely happily, not nervously at all.\n\n");
			lunaJealousy(-100);
			lunaAffection(2);
			doNext(camp.returnToCampUseOneHour);
		}
		public function talkMenuLunaWhatCanSheDo():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("Just what can she do for you, exactly? Your upbringing in rural, backwoods Ingnam hardly gave you much of a chance to meet domestic servants.\n\n" +
					"\"<i>Why, " + player.mf("Master","Mistress") + ", what <b>can't</b> I do for you would be easier to answer! I'm highly trained in the obvious duties of cooking and cleaning, naturally, but I also have experience in medicine, massage therapy, interior decoration, sewing and tailoring, minor repairs, bookkeeping, cryptography, corporate espionage, wetworks, and... pest control.</i>\"\n\n" +
					"She smiles at you with the face of innocence itself. \"<i>Indeed please do not worry about troubling me with any request you might have, no matter what.</i>\"\n\n");
			if (flags[kFLAGS.LUNA_FOLLOWER] > 6) outputText("She glances down slightly, her face flushing a bit. \"<i>Even your most... intimate needs... i-if it's your wish, I would never turn you down, " + player.mf("Master","Mistress") + "...</i>\"\n\n");
			outputText("You can think of absolutely no potential problems with this.\n\n");
			if (flags[kFLAGS.LUNA_FOLLOWER] < 5)flags[kFLAGS.LUNA_FOLLOWER] = 5;
			lunaJealousy(-100);
			lunaAffection(2);
			doNext(camp.returnToCampUseOneHour);
		}
		public function talkMenuLunaHuman():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			if (flags[kFLAGS.LUNA_FOLLOWER] > 6) {
				outputText("She lied to you when she said she was human. Why?\n\n" +
						"\"<i>Well, I used to be human. I still feel human, mostly. Or rather... I-I'm sorry, " + player.mf("Master","Mistress") + ", it's all so complicated. I never wanted to deceive you, I swear.</i>\"\n\n" +
						"You tell her to go on.\n\n" +
						"\"<i>...I came from a different world, just like " + player.mf("Master","Mistress") + " did, after all. When the cursed mirror in my former place of work dropped me here, I also had to survive alone in the wild, and one night a werewolf... attacked me and turned me into the monster I am now. I believe werewolves to be demonic creations engineered to spread bestial corruption to populated areas in secret; we are perfectly suited to it, and our instincts... well, I'm lucky to have gotten off with merely a bite, I should say.</i>\n\n" +
						"She looks uncomfortable for a few seconds, then continues. " +
						"\"<i>I believe the goal of creating us is to replace remaining civilized beast-morphs and the few remaining humans in Mareth with sex crazed therianthropes. I know that there are werecats out there, at the very least, so the condition isn't just restricted to wolf forms.</i>\"\n\n" +
						"What about the part when she came to town?\n\n" +
						"\"<i>That was as I told you before, save that I did not actually run the entire time. My... new found abilities allowed me to deal with most of the creatures that threatened me on my own terms." +
						" I can hardly say I made a compelling maid by the time I arrived in Tel'Adre, still, covered in filth with my clothes in tatters</i>\" she admits ruefully. \"<i>But I used the few gems I acquired from my encounters on the way to purchase a new work uniform, and cleaned up as best my circumstances permitted." +
						" Following that I soon found myself employed, working as a maid by day and... indulging myself on nights of the full moon, usually safely outside the town walls, but sometimes with companions I, er, <b>found</b> inside, one way or another. Such was the case with my previous Master, William." +
						" He was the first employer in Tel'Adre to discover my condition, and to my surprise he found it alluring after the initial shock. Unfortunately, his wife got wind of her husband's interest, and she moved against me quite swiftly." +
						" On a day she had planned a long shopping trip, Master William had me tie him up in his bed, with the help of some pharmaceutical encouragement I added to his tea that morning. As we were satisfying each other, his wife came back unexpectedly, without the servants she had left with." +
						" She fired me on behalf of her husband, who was still indisposed, and warned me not to try working in Tel'Adre again or she would tell the Town Watch about my condition. I suppose she thought she was being merciful... the real mercy is that I didn't decorate the hallway with the bitch's insides on my way out. I have never resisted a stronger temptation.</i>\"" +
						" Her eyes take on a dangerous green glint as she finishes her story.\n\n" +
						"As fascinating as her tale was, you find yourself hung up on the detail about drugging her master's tea. Surely she hasn't been supplementing your meals in a similar way?\n\n" +
						"She giggles cutely, the very picture of innocence, at your suggestion. \"<i>Of course not, " + player.mf("Master","Mistress") + ", don't be silly. Why would I need to do that?</i>\"");
				if(flags[kFLAGS.MARRIAGE_FLAG] == 0)outputText("She narrows her eyes slightly. \"<i>You don't have any <b>pesky</b> spouse to get between us and make you... inhibited.</i>\"\n\n");
				outputText("\"<i>You already know my body is yours to use, any time, any <b>way</b> you desire it, " + player.mf("Master","Mistress") + ",</i>\" she says, her tone changing to a sultry half-whisper as her eyes begin to glaze over. \"<i>And <b>I</b> already know how <b>much</b> you want it...</i>\"\n\n" +
						"In a move that somehow feels shockingly bold despite what you've seen her do in her beast form, she suddenly runs a finger along your chest teasingly, gazing squarely at you with lust, or perhaps hunger-filled eyes. \"<i>Why would I need chemicals when you already give me all your love? When all you have to do is nod and I'll give... you... <b>everything.</b></i>\"\n\n" +
						"Her smile is predatory, and her golden eyes can barely contain the green glow straining to break through them. There may be no containing that beast inside her, but at least you feel better knowing she won't drug and tie you. Probably. You think. You make a mental note to hide the rope later on when she's busy with something else.");
			}
			else {
				outputText("You ask her if she is truly a full-blooded, \"pure\" human, the first you've found besides yourself in Mareth.\n\n" +
						"\"<i>Yes, " + player.mf("Master","Mistress") + ", I am indeed human. Like " + player.mf("Master","Mistress") + ", I came from a different world, though in my case it was misfortune rather than duty that brought me. My employer at the time ran a magic shop out of her first floor, and part of my duty was to clean it after hours. One night as I was doing so, some thieves attempted to break in. As I was in the process of dealing with them, one of the clumsy fools managed to break a large, enchanted mirror with his ugly, stupid face, and in a burst of dark magic the cursed thing sucked the both of us in. When I awoke I was in a forest clearing, and soon discovered I was no longer in my old world.</i>\"\n\n" +
						"What happened afterward?\n\n" +
						"\"<i>Of course I ran, " + player.mf("Master","Mistress") + ". It seemed no matter I went there were people or... things, trying to molest me, or worse. Truly, I should have met a sad fate were it not for a strangely dressed woman with black hair who kindly directed me toward Tel'Adre, where I eventually met you. I am ever grateful to her for that, though I don't know where she went, or even her name; nor have I seen her since.</i>\"\n\n" +
						"Noticing a pertinent detail she seems to have omitted, you ask what became of the would-be thief who arrived with her.\n\n" +
						"She laughs airily and offers you a reassuring smile. " +
						"\"<i>Oh, do not worry, " + player.mf("Master","Mistress") + ", he won't be troubling <b>anyone.</b></i>\"");

			}
			lunaJealousy(-100);
			lunaAffection(2);
			doNext(camp.returnToCampUseOneHour);
		}
		public function talkMenuLunaCampThoughts():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("What does she think of your camp?\n\n");
			if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10) outputText("\"<i>While I can’t say your home is as... grand as those of my prior employers, it is truly charming in its rustic way. Perhaps one day " + player.mf("Master","Mistress") + " will consider expanding it? I could greatly expand my services to you with a larger home.</i>\"\n\n");
			else outputText("\"<i>While I would never impose upon " + player.mf("Master","Mistress") + ", I will admit it would be far easier to clean if there were a proper dwelling here. I would greatly enjoy the wider scope for my services a cabin would provide.</i>\"\n\n");
			lunaJealousy(-100);
			lunaAffection(2);
			doNext(camp.returnToCampUseOneHour);
		}
		public function talkMenuLunaStopJealousy():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("Luna trots elegantly over to you as usual, but her greeting dies on her lips as she sees the expression on your face. After staring blankly for two seconds, she hastily recovers and manages to address you with only a slight twitch at the side of her mouth." +
					"\n\n\"<i>Ah ha ha ha, is something on " + player.mf("Master","Mistress") + "'s mind? How may I serve you today?</i>\"\n\n" +
					"The hell there is, you reply, and mention the various \"accidents\" that seem to have befallen your other campmates of late.\n\n" +
					"\"<i>I... but, I, er...</i>\" she stammers, before giving up and admitting the truth. \"<i>I apologize, " + player.mf("Master","Mistress") + ". I have no excuse' I just couldn't contain myself after being ignored for so long.</i> ");
			if (flags[kFLAGS.LUNA_FOLLOWER] > 6) outputText("<i>Though my love for you is unconditional,</i> ")
			outputText("<i>I am still but an employee, here to serve you just the same wherever your attentions may wander. What are my feelings as a person in the face of my duty? I will endeavor to be more professional and suppress my emotions more fully to be a better servant to you.</i>\" She bows much more deeply than usual, concealing her face.\n\n");
			if (flags[kFLAGS.LUNA_FOLLOWER] < 6) outputText("You admit that underneath the drama she has a point, but even so you can't disregard your other companions either; after all, she is a maid, not a consort... unless she'd prefer that? Either way, you offer to spend more time with her in the future, so long as these acts of passive aggression end now. She grimaces but nods obediently. ");
			else outputText("Inwardly you wince. Despite the dramatic presentation, her complaint hits home; she really does do a great deal for you every day without complaint or compensation besides the attention you spare her, and that attention has decreased of late, though it's hard to help when you have so many companions demanding your time. You promise Luna you will spend more time with her soon, but tell her to stop these acts of passive aggression against your campmates; if anything she should be angry with you, not them, for your inconsideration. With tears in her eyes she nods obediently, but the green glint you see glimmering in the wet drops indicates that you will likely be held to that, should you forget.");
			player.createStatusEffect(StatusEffects.LunaWasWarned, 0,0,0,0);
			player.removeStatusEffect(StatusEffects.LunaWasCaugh);
			lunaJealousy(-100);
			lunaAffection(2);
			doNext(camp.returnToCampUseOneHour);
		}
		public function talkMenuLunaLycanthropy():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You ask her what it's like to be a werewolf, besides the monthly lunacy, as it were.\n\n" +
					"\"<i>Well... it's embarrassing to admit, but even more than the hunting instincts it's like being in heat all the time, and especially as the full moon draws near. The closer we therianthropes get to the full moon, the... well, the hornier we get, to put it bluntly, until we almost can't help but take our satisfaction from the nearest convenient target... Oh!</i>\"" +
					" she suddenly cries, then adds " +
					"\"<i>But of course, " + player.mf("Master","Mistress") + ", I would <b>never</b> do such a thing now! My body belongs only to you.</i>\"" +
					" She blushes faintly as she looks in your eyes, then continues.\n\n" +
					"\"<i>But there are upsides as well. We are gifted with the ability to change form at will, and we are faster, stronger, and sturdier than any normal beast-morph or human.</i>\"\n\n" +
					"She sighs sadly. " +
					"\"<i>Still, it is a curse, and a terrible one. There is no cure to therianthropy as far as I know. While I could change my appearance into something different using transformatives the same as " + player.mf("Master","Mistress") + ", I think that short of fully abandoning my animal nature I would still go mad during a full moon, and still suffer the same... urges. Worse, my bite can turn nearly anyone into a lycanthrope as well, spreading the curse further.</i>\"\n\n" +
					"She really is more than just a cute pup, then, though you'd hardly dared to hope otherwise. As you ponder the dangers of having her around camp Luna tries to reassure you right away.\n\n" +
					"\"<i>Please do not worry " + player.mf("Master","Mistress") + ", I am not dangerous. Well, not to you at least, so long as you have me under your care. But, I can't control my urges as well if I'm left alone for too long. It becomes easier for me to lose control and do... things.</i>\"\n\n" +
					"You don't feel especially reassured.\n\n");
			if (flags[kFLAGS.LUNA_FOLLOWER] == 11) flags[kFLAGS.LUNA_FOLLOWER] = 13;
			else flags[kFLAGS.LUNA_FOLLOWER] = 14;
			lunaJealousy(-100);
			lunaAffection(2);
			doNext(camp.returnToCampUseOneHour);
		}
		public function talkMenuBiteMe():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("It occurs to you that you could gain the same kind of powers as Luna if you asked her. But are you really sure?\n\n");
			menu();
			addButton(0, "Yes", talkMenuBiteMeYes).hint("What fun is life in Mareth without terrible ideas?");
			addButton(1, "No", talkMenuLuna).hint("Yeah, maybe not after all. It is a pretty terrible idea.");
		}
		public function talkMenuBiteMeYes():void {
			outputText("You call Luna aside to a quiet corner of the camp and place your hands on her shoulders. She looks at you wide-eyed as you very seriously ask her to do something she never expected: bite you. Luna nearly panics and tries to dissuade you the moment you request it, though you notice she also blushes.\n\n" +
					"\"<i>" + player.mf("Master","Mistress") + ", I can't, you... this is a terrible, permanent thing you are asking! Did you truly think it through? Once you are cursed there is no going back; you will be just... just like me...</i>\"\n\n" +
					"You insist that you have indeed thought it through, and that the prospect of being tied even more closely to her makes it all the more attractive. For a moment Luna is speechless, blushing furiously with wide, wet gold... no, green eyes. " +
					"\"<i>Oh, " + player.mf("Master","Mistress") + "...</i>\"" +
					" she begins, and then begins undressing in order to transform. She maintains eye contact with you as she strips, a mixed expression of fear, hunger, adoration, and embarrassment on her face; the display is unintentionally erotic and you feel your own predatory instincts rising at the sight. Once she is fully naked and has assumed her wolf form, you hold your arm before her. Even with her blood surely boiling, she still you gently, lovingly, only just enough to draw blood, her long muzzle lingering against your skin, tasting you. It hurts at first, her hot breath and long, wet tongue like fire against your broken skin, but then the pain recedes, replaced with spreading pleasure as the wounds begin to throb, then close up. " +
					"Your" + (player.hasCock() ? " [cock] suddenly springs erect" : "") + "" + (player.gender == 3 ? " and your" : "") + "" + (player.hasVagina() ? " pussy begins dripping with moisture" : "") + ", your breath quickens, and your skin begins to flush; you feel aroused but also sick, as if you were having an allergic or toxic reaction.\n\n" +
					"As your panic rises, Luna pulls you into an embrace, speaking into your ear in a voice wet with emotion. \"<i>" + player.mf("Master","Mistress") + "... no, [name], my love, my everything, you don't know how much this means to me. I will never, ever leave you, never; you won't have to endure this alone, as I did, or anything else, ever again. I am yours, completely and utterly, your mate, your pack, your possession, for all eternity. Just endure a little while, I will hold you until it's over. I love you so much, [name], so, so much more than you can know, and I will never, ever let you forget it. Just a little while longer, and it will all be over.</i>\" You feel tears falling onto your neck and shoulder as she shakes you gently with suppressed sobs.\n\n" +
					"But you don't have time to respond properly to her outpouring of emotion as " + (player.humanScore() < 30 ? "your body starts changing, and to your surprise, its features warp back to their old human appearance. For an instant think she may have somehow restored your already lost humanity, but it isn't so, not exactly, you realize, as " : "") + "fresh, new heat begins to spread from your rapidly healing tooth-marks and you start panting, trying to vent out the pleasure and the hot feeling in your body as something fundamental inside you begins to twist and warp.\n\n" +
					"You half-shout, half-moan as fur begins to grow on your arms and legs. Your nails sharpen and curve into lethal-looking claws as your hands and feet reshape into padded, lupine paws. You groan in pain and pleasure, opening your mouth to reveal your lengthening canines as your spine extends into a furry tail while your ears migrate to the top of your head, sprouting smooth fur and changing into triangular points like those of a wolf. As your tongue lolls out of your slack jaw it rests against Luna's chest, and you realize that she is holding you closely, supporting you gently in her arms as you succumb, granting you a mercy and kindness in the midst of this terrifying, mesmerizing process that she must have wanted and been denied.\"\n\n");
			if (player.hasCock()) outputText("As your thoughts turn to her you feel a tightness near the base of your cock, where your skin bunches and folds inward into a canine sheath, tightening and pulling your still-erect, straining length inside its hot depths before it once again surges out with a burst of pain and pleasure. Your dick is now blood-red, the base swollen into a grotesque, vein-covered knot, and the tip pointed. The sensations are too much for you, and you throw back your head and howl as your new lupine member erupts in a spray of hot cum against your lover, your pack-mate, your curse.\n\n");
			player.lowerBody = LowerBody.WOLF;
			if (player.legCount != 2) player.legCount = 2;
			player.tailType = Tail.WOLF;
			if (player.tailCount != 1) player.tailCount = 1;
			player.rearBody.type = RearBody.WOLF_COLLAR;
			player.arms.type = Arms.WOLF;
			player.faceType = Face.WOLF_FANGS;
			player.ears.type = Ears.WOLF;
			player.eyes.type = Eyes.FERAL;
			player.tongue.type = Tongue.DOG;
			player.wings.type = Wings.NONE;
			player.antennae.type = Antennae.NONE;
			player.horns.type = Horns.NONE;
			player.skin.growCoat(Skin.FUR, {color:player.hairColor}, Skin.COVERAGE_LOW);
			if (player.hasCock() && player.wolfCocks() < 1) {
				var selectedCockValue:int = -1;
				for (var indexI:int = 0; indexI < player.cocks.length; indexI++)
				{
					if (player.cocks[indexI].cockType != CockTypesEnum.WOLF)
					{
						selectedCockValue = indexI;
						break;
					}
				}
				if (selectedCockValue != -1) {
					player.cocks[selectedCockValue].cockType = CockTypesEnum.WOLF;
					player.cocks[selectedCockValue].knotMultiplier = 1.1;
					player.cocks[selectedCockValue].thickenCock(2);
				}
			}
			var bonusStats:Number = 0;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3 || flags[kFLAGS.LUNA_MOON_CYCLE] == 5) bonusStats += 10;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2 || flags[kFLAGS.LUNA_MOON_CYCLE] == 6) bonusStats += 20;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1 || flags[kFLAGS.LUNA_MOON_CYCLE] == 7) bonusStats += 30;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) bonusStats += 40;
			if (player.findPerk(PerkLib.Lycanthropy) < 0) player.createPerk(PerkLib.Lycanthropy,bonusStats,0,0,0);
			player.statStore.replaceBuffObject({ 'str': bonusStats,'tou': bonusStats,'spe': bonusStats}, 'Lycanthropy', { text: 'Lycanthropy'});
			player.strStat.core.value += 5;
			player.touStat.core.value += 5;
			player.speStat.core.value += 5;
			player.libStat.core.value += 5;
			player.dynStats("cor", 20);
			statScreenRefresh();
			outputText("The process complete, you begin seething with newfound strength, of body and of lust. You push out of Luna's embrace, reeling backward, but quickly lunge at her again. She emits a half-frightened, half-aroused yip as you bowl her over, with you on top. Your pack-mate, your bitch... you must take her, make her yours... NOW!\n\n");
			doNext(sexMenuDominateHer);
		}

		public function sparLuna():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You ask Luna if she would like to spar with you.\n\n" +
					"\"<i>" + player.mf("Master", "Mistress") + ", it is best not to awaken my instincts during the day. I am a pitiful woman who cannot control her impulses...</i>\"\n\n" +
					"You counter that her being a strong and dangerous opponent is exactly what you need if you are to train to survive in this harsh world.\n\n" +
					"She bows obediently. " +
					"\"<i>If " + player.mf("Master", "Mistress") + " so desires, I will not refuse.</i>\"\n\n" +
					"You head to the ring and get ready for the match. She briskly removes her clothing with professional efficiency, though you think you see her blushing" + (camp.companionsCount() >= 2 ? ", along with several of your other companions who stopped by to watch" : "") + ". The impromptu, deadpan striptease is short-lived, though, as she quickly assumes her voluptuous, muscular werewolf form. You recognise the green glow of crazed desire in her eyes now and realize with a tinge of too-late regret that losing to her now will not likely be the end of the match. There are worst fates, you suppose, but your groin already feels sore in protest.\n\n");
			startCombat(new Luna());
		}
		public function sparLunaWon():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("Luna falls submissively to all fours in defeat.\n\n" +
					"\"<i>I yield " + player.mf("Master", "Mistress") + ". The victory is yours. I hope this weak servant's efforts were satisfactory.</i>\"\n\n" +
					"You thank Luna for helping you with your training. After resuming her human form and re-dressing, she bows and continues her duties.\n\n");
			if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] >= 1) flags[kFLAGS.LUNA_DEFEATS_COUNTER]++;
				else flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 1;
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 2 && flags[kFLAGS.LUNA_LVL_UP] == 0) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 12);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 12, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 1;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 3 && flags[kFLAGS.LUNA_LVL_UP] == 1) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 18);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 18, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 2;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 4 && flags[kFLAGS.LUNA_LVL_UP] == 2) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 24);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 24, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 3;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 5 && flags[kFLAGS.LUNA_LVL_UP] == 3) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 30);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 30, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 4;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 6 && flags[kFLAGS.LUNA_LVL_UP] == 4) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 36);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 36, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 5;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 7 && flags[kFLAGS.LUNA_LVL_UP] == 5) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 42);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 42, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 6;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 8 && flags[kFLAGS.LUNA_LVL_UP] == 6) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 48);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 48, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 7;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 9 && flags[kFLAGS.LUNA_LVL_UP] == 7) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 54);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 54, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 8;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 10 && flags[kFLAGS.LUNA_LVL_UP] == 8) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 60);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 60, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 9;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 11 && flags[kFLAGS.LUNA_LVL_UP] == 9) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 66);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 66, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 10;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 12 && flags[kFLAGS.LUNA_LVL_UP] == 10) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 72);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 72, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 11;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 13 && flags[kFLAGS.LUNA_LVL_UP] == 11) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 78);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 78, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 12;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 14 && flags[kFLAGS.LUNA_LVL_UP] == 12) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 84);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 84, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 13;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 15 && flags[kFLAGS.LUNA_LVL_UP] == 13) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 90);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 90, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 14;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 16 && flags[kFLAGS.LUNA_LVL_UP] == 14) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 96);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 96, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 15;
				}
			}
			cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}
		public function sparLunaLost():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			outputText("Luna pounces on you with a hungry growl. Oh well, you think, no one to blame but yourself.\n\n" +
					"\"<i>You lost " + player.mf("\"Master\"", "\"Mistress\"") + ", so I'll be taking your body. I don’t care how, you can decise, just give it to me <b>now</b>, and don't stop until I'm satisfied. After all, <b>you asked for it</b>, hee hee hee...</i>\" Revealing her tastes, rather than ravishing you from her position of dominance she assumes a submissive position in front of you, her torso against the ground and her rear with its dripping, musky sex up in the air and facing you. Her tail is curled over her back for maximum exposure as she wiggles her backside at you. You're sure she won't stay submissive for long if you try to deny her, though, and you don't have the energy to try to flee.\n\n");
			monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
			cleanupAfterCombat();
			doNext(sexMenuDominateHer);
		}
		public function MooningLunaLost():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			outputText("Luna pounces on you with a hungry growl. Oh well, that's just how Mareth works.\n\n" +
					"\"<i>You lost " + player.mf("\"Master\"", "\"Mistress\"") + ", so I'll be taking your body. I don’t care how, you can decide, just give it to me <b>now</b>, and don't stop until I'm satisfied, if you like your face where it is on your head.</i>\"" +
					" The way she's baring her fangs, you're not entirely sure it's an empty threat, and, curiously, the thought doesn't make you feel any less turned on. Revealing her tastes, rather than ravishing you from her position of dominance she assumes a submissive position in front of you, her torso against the ground and her rear with its dripping, musky sex up in the air and facing you. Her tail is curled over her back for maximum exposure as she wiggles her backside at you. You're sure she won't stay submissive for long if you try to deny her, though, and you don't have the energy to try to flee.\n\n");
			monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
			cleanupAfterCombat();
			doNext(sexMenuDominateHer);
		}

		public function mealLuna():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You ask Luna if today's meal is ready.\n\n");
			if (flags[kFLAGS.LUNA_MEAL] == 1) {
				outputText("\"<i>I deeply apologize for my failure, " + player.mf("Master", "Mistress") + ", but I have not managed yet to gather food and ingredients for another meal. I will do so at the nearest possible time my other duties permit, but I doubt I will be able to serve you another meal until tomorrow unless you manage to hire more maids.</i>\" The slight edge you hear in her tone and the dangerous twinkle in her eyes as she mentions the prospect of coworkers makes you feel like the suggestion is not meant earnestly; not that you know of any more maids you could hire in the first place.\n\n");
				doNext(mainLunaMenu);
			}
			else {
				outputText("\"<i>Indeed, " + player.mf("Master","Mistress") + ", it is nearly finished, just awaiting the finishing touches. May I serve you a cup of tea first? The leaves are from He'Xin'Dao, a very refined and gentle blend sure to stimulate the appetite.</i>\"\n\n" +
						"You nod and Luna comes back with your tea, and then in a moment your meal. You have no idea where she's finding the ingredients, but so great is her culinary skill even with your crude mess kit and a campfire that you doubt most of Tel'Andre is eating so well. You finish with gusto, feeling fully satisfied, and thank Luna for the magnificent meal. She nods, blushing endearingly with honest, innocent pride at your praise.\n\n" +
						"\"<i>It is my pride and my pleasure to serve you, " + player.mf("Master","Mistress") + ". Your praise is all I could desire and more.</i>\"\n\n");
				player.hunger = player.maxHunger();
				HPChange(Math.round(player.maxHP() * .1), true);
				player.mana += Math.round(player.maxMana() * 0.1);
				if (player.mana > player.maxMana()) player.mana = player.maxMana();
				player.buff("WellFed").setStats({"str.mult":0.05,"tou.mult":0.05,"spe.mult":0.05}).forDays(1).withText("Well Fed");
				EngineCore.changeFatigue(-(Math.round(player.maxFatigue() * 0.1)));
				flags[kFLAGS.LUNA_MEAL] = 1;
				lunaJealousy(-100);
				lunaAffection(10);
				doNext(camp.returnToCampUseOneHour);
			}
		}

		public function nurseLuna():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You ask the maid if is able to tend to your inuries.\n\n" +
					"\"<i>Of course, " + player.mf("Master","Mistress") + ", please undress and I shall do so at once.</i>\"\n\n" +
					"Luna casts a few healing spells on you to help your recovery. She traces your skin up and down, gently, with her slender, clean fingers, soothing your pains and closing your cuts and scrapes as she does. Her treatment is highly effective, but also a bit arousing; the young maid's touch feels loving and warm, and you soon find yourself flushed with lust under her tender caresses.\n\n");
			dynStats("lus", 33);
			for each (var stat:String in ["str","spe","tou","int","wis","lib","sens"]){
				player.removeCurse(stat, 10);
				if (stat != "sens")
				{
					player.removeCurse(stat+".mult", 0.10);
				}
			}
			lunaJealousy(-100);
			lunaAffection(5);
			HPChange(Math.round(player.maxHP() * .5), true);
			Nursed = true;
			NursedCooldown = 24;
			if (flags[kFLAGS.LUNA_FOLLOWER] > 10) {
				outputText("\nThe treatment complete, she breaks contact and her expression melts into a more coy smile. Doubtless she knows what effect she's had on you, and fully intended it. Do you take her here and now?\n\n");
				menu();
				addButton(0, "Yes", sexMenuMain);
				addButton(1, "No", nurseLunaEnd);
			}
			else doNext(camp.returnToCampUseFourHours);
		}
		public function nurseLunaEnd():void {
			outputText("A bit regretfully you decline her unspoken offer and leave her hanging; much as you wouldn't mind some closer contact with your cute maid you have other duties to perform. She smiles graciously as you thank her and begin dressing, nearly but not quite suppressing the frustrated twitch in her eyebrow. Maybe next time.");
			doNext(camp.returnToCampUseOneHour);
		}

		private function lunaSleepToggle():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			if (flags[kFLAGS.SLEEP_WITH] != "Luna") {
				outputText("You ask Luna if she would mind sleeping with you.\n\n" +
						"Her golden eyes open wide as she blushes adorably. " +
						"\"<i>" + player.mf("Master","Mistress") + ", why, I mean... that is... I never thought... yes, yes! It would be my honor to safeguard your dreams!</i>\"" +
						" She bows so quickly and so low in her excitement that her headband nearly falls off.\n\n");
				flags[kFLAGS.SLEEP_WITH] = "Luna";
			}
			else {
				outputText("You tell Luna you wish to sleep alone for a while.\n\n" +
						"Luna bows solemnly. \"<i>As you wish " + player.mf("Master","Mistress") + "... please let me know when you desire me once more. I am ever happy to safeguard your dreams.</i>\"\n\n");
				flags[kFLAGS.SLEEP_WITH] = "";
			}
			menu();
			addButton(0,"Next", mainLunaMenu);
		}
		private function sleepWith(arg:String = ""):void {
			flags[kFLAGS.SLEEP_WITH] = arg;
		}
		private function lunaChainToggle():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			if (flags[kFLAGS.LUNA_FOLLOWER] == 9 || flags[kFLAGS.LUNA_FOLLOWER] == 10) {
				outputText("Luna is currently free to roam at night because... you like getting jumped in bed?\n\n");
				if (flags[kFLAGS.LUNA_FOLLOWER] == 9) flags[kFLAGS.LUNA_FOLLOWER] = 7;
				if (flags[kFLAGS.LUNA_FOLLOWER] == 10) flags[kFLAGS.LUNA_FOLLOWER] = 8;
			}
			else {
				outputText("Luna is chained before every full moon night as a safety measure.\n\n");
				if (flags[kFLAGS.LUNA_FOLLOWER] == 7) flags[kFLAGS.LUNA_FOLLOWER] = 9;
				if (flags[kFLAGS.LUNA_FOLLOWER] == 8) flags[kFLAGS.LUNA_FOLLOWER] = 10;
			}
			menu();
			addButton(0,"Next", mainLunaMenu);
		}
		public function sleepingFullMoon():void {
			outputText("You suppress the urge to close your eyes, knowing that Luna has other plans tonight. You can spot the telltale green glow in her eyes before the full moon, and she smiles coyly as she notices your gaze. She slips out of her clothes and her trim, naked form takes on a beastial shape as she sits on all fours, waiting like a dog expecting its treat.\n\n" +
					"\"<i>"+ player.mf("Master","Mistress") + ", there's no need for words. You know what we both want, so let's get wild tonight, mmm?</i>\"\n\n");
			flags[kFLAGS.LUNA_MOONING] = 2;
			menu();
			addButton(0, "Dominate", sexMenuDominateHer);
		}

		public function warrningAboutJelously():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			if (flags[kFLAGS.LUNA_FOLLOWER] == 5) flags[kFLAGS.LUNA_FOLLOWER] = 6;
			else if (flags[kFLAGS.LUNA_FOLLOWER] == 7) flags[kFLAGS.LUNA_FOLLOWER] = 8;
			else if (flags[kFLAGS.LUNA_FOLLOWER] == 9) flags[kFLAGS.LUNA_FOLLOWER] = 10;
			else if (flags[kFLAGS.LUNA_FOLLOWER] == 11) flags[kFLAGS.LUNA_FOLLOWER] = 12;
			else if (flags[kFLAGS.LUNA_FOLLOWER] == 13) flags[kFLAGS.LUNA_FOLLOWER] = 14;
			else flags[kFLAGS.LUNA_FOLLOWER] = 16;
			outputText("Luna comes over to you.\n\n" +
					"\"<i>" + player.mf("Master","Mistress") + " I know that you are busy with important work, but it's been a long time since you accepted my service. I wish to remind you that should you need anything, truly <b>anything</b>, all you need to do is call me. My greatest pleasure is to serve you.</i>\"\n\n" +
					"With that she leaves to prepare today's food, which you that you indeed have not enjoyed recently. You feel a little guilty thinking of all the work she does for you. Perhaps you should spare her an hour today.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}

		public function fullMoonEvent(PCIsAwake:Boolean = false, PCWalkedToLunaAtmaxJealousy:Boolean = false):void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			flags[kFLAGS.LUNA_JEALOUSY] = 0;
			if (flags[kFLAGS.LUNA_FOLLOWER] > 6) {
				if (player.hasStatusEffect(StatusEffects.LunaWasWarned)){
					if (PCIsAwake){
						outputText("Just as you are about to rest, Luna approaches you, already naked and tossing her clothes to the side, eyes sparkling a menacing green.\n\n");
					} else {
						outputText("The sound of footsteps rouses you from a light slumber; you are not alone. A second later Luna looms above you, already naked and grinning, eyes glowing green in the dim firelight.\n\n");
					}
					outputText("\"<i>" + player.mf("Master","Mistress") + ", I cannot hold it back anymore. If you refuse to take me, I'll just have to take you!</i>\"\n\n" +
							"As she speaks she is already transforming, growing in size until you can see nothing but her muscular, curvaceous form covering you, just like it did that first night you learned her secret.\n\n" +
							"Before things get out of hand, how will you answer her advances?\n\n");
				}
				else{
					if (PCIsAwake) {
						if (PCWalkedToLunaAtmaxJealousy) {
							outputText("As you approach Luna she sighs resignedly, rising from the stone she was resting upon and pulling off her dress.\n\n" +
									"\"<i>" + player.mf("Master","Mistress") + ", I did warn you I can only hold myself back so long. Tonight I will not take 'no' for an answer.</i>\"\n\n" +
									"GThere's nothing for it; already ");
						}else{
						
						
							outputText("You were about to take a break, but you turn at the sound of footsteps and see that Luna has other plans tonight; ");
						}
					} else {
						outputText("Just as you are about to sleep, the sound of footsteps alerts you to the fact that Luna has other plans tonight; ");
					}
					outputText("the green light in her eyes shows her intentions quite clearly. Seems you won't be going ");
					if (PCIsAwake) outputText("anywhere ");
					else outputText("to bed ");
					outputText("before she's satisfied. Perhaps you have been neglecting her a bit lately, you think ruefully. " +
							"She slips out of her clothes and her trim, naked form takes on a beastial shape as she sits on all fours, waiting like a dog expecting its treat.\n\n");
					if (PCIsAwake)outputText("\"<i>We can do this two ways, " + player.mf("Master","Mistress") + ": the hard way, where you resist and I take you by force until I'm happy, or the easy way, where you fuck me raw in a loving, consensual way. What is your pleasure, " + player.mf("Master","Mistress") + "?</i>\"\n\n");
					else outputText(player.mf("Master","Mistress") + ", there's no need for words. You know what I both want, so let's get wild. I've been waiting so patiently for this, so eagerly, and you've denied me so long.</i>\"\n\n");
				}
			}
			else if (player.hasStatusEffect(StatusEffects.LunaWasWarned)) {
				if (PCIsAwake){
					outputText("Just as you are about to rest, Luna approaches you, already naked and tossing her clothes to the side, eyes sparkling a menacing green. Before you can react, she leaps on you, pinning you down.\n\n");
				} else {
					outputText("The sound of footsteps rouses you from a light slumber; you are not alone. A second later Luna looms above you, pinning you down. She is naked and grinning, eyes glowing green in the dim firelight.\n\n");
				}
				outputText("\"<i>I can’t control it anymore, " + player.mf("Master","Mistress") + ". I tried, I tried so hard, but the things you did to me, the things you <b>wouldn't</b> do to me, it's been intolerable! It's all your fault, <b>you</b> pushed me to this!</i>\"\n\n" +
						"You vehemently deny doing anything of the sort, and ask what she's talking about.\n\n" +
						"\"<i>Cruel, wicked " + player.mf("Master","Mistress") + ", pretending to know nothing when you've been ignoring and neglecting me again, despite your promise! I love you, I love you <b>so much</b> but you still hurt me. Is my service not enough? Is my body not enough? I offered it to you every day, every night, and yet you turned away, " + player.mf("Master","Mistress") + " But it's all ok now, now that the moon is at its peak! I’m finally ready, ready to make you realize how <b>much</b> you truly love me. Even if it's only for a few minutes I will <b>make</b> you love me! You can’t deny us anymore, [name]!</i>\"\n\n" +
						"Her golden eyes turn fully fluorescent green, drawing your vision as her naked body begins to transform over you. She shivers and moans in bliss, or pain, or both, as fur begins to cover the skin of her arms and legs, and even as they pin you down you feel her hands and feet change to great, bestial paws with long, deadly claws. Her breasts and hips swell and fill out to the voluptuous curves you recognize on every corrupted female creature in this mad world, and as the transformation ends a bushy tail sprouts from her curvy, muscular buttocks and her ears shift and grow into pointed canine ears atop her head. She pants in orgasmic ecstasy at the pleasure of the change, revealing a dog like tongue and canines far too long and sharp for any human. You feel a few drops of drool begin to fall on you, from both of her mouths.\n\n" +
						"\"<i>See? You see, " + player.mf("Master","Mistress") + "?! I’m a werewolf! A beast, a filthy demonic beast wearing human skin! This is the real reason my last master fired me, the terrible secret he learned! I’m a monster! I tried to hide it, for your sake, but you’ve been teasing me for so long now I can’t hold it in anymore. But it's all okay, " + player.mf("Master","Mistress") + ", because I'm going to make you mine, now!</i>\"" +
						" She finishes by rearing back her head and releasing a feral howl that echoes through the night, screaming her madness and her passion to the blood red, full moon that looks down on this scene of insanity.\n\n" +
						"Before things get even more out of hand, how will you answer her advances?\n\n");
			}
			else {
				if (PCIsAwake){
					outputText("You were about to take a break but out of nowhere something leaps out of the shadow and forcefully pins you down to the ground. What you see takes you entirely by surprise. Luna is standing over you, staring at you like some kind of predator.\n\n");
				} else {
					outputText("You are woken up by something forcefully pinning you down. What you see takes you entirely by surprise. Luna is standing over you, staring at you like some kind of predator.\n\n");
				}
				outputText("\"<i>I can’t control it anymore, " + player.mf("Master","Mistress") + ". I tried, I tried so hard, but the things you did to me, the things you <b>wouldn't</b> do to me, it's been intolerable! It's all your fault, <b>you</b> pushed me to this!</i>\"\n\n" +
						"You vehemently deny doing anything of the sort, and ask what she's talking about.\n\n" +
						"\"<i>Cruel, wicked " + player.mf("Master","Mistress") + ", pretending to know nothing when you've been seducing me with your need every day and night! Every meal I made for you, every wound I nursed on your sweet body, every stone I cleaned from under your bedroll, you <b>made</b> me love you, more and more, oh and more! Do you not want my service? Is my body not beautiful, not tempting enough? I offered it to you every day, every night, and yet you turned away, " + player.mf("Master","Mistress") + " But it's all ok now, now that the moon is at its peak! I’m finally ready, ready to make you realize how <b>much</b> you love me back. Even if it's only for a few minutes I will <b>make</b> you love me! You can’t deny us anymore, [name]!</i>\"\n\n" +
						"Her golden eyes turn fully fluorescent green, drawing your vision as her naked body begins to transform over you. She shivers and moans in bliss, or pain, or both, as fur begins to cover the skin of her arms and legs, and even as they pin you down you feel her hands and feet change to great, bestial paws with long, deadly claws. Her breasts and hips swell and fill out to the voluptuous curves you recognize on every corrupted female creature in this mad world, and as the transformation ends a bushy tail sprouts from her curvy, muscular buttocks and her ears shift and grow into pointed canine ears atop her head. She pants in orgasmic ecstasy at the pleasure of the change, revealing a dog like tongue and canines far too long and sharp for any human. You feel a few drops of drool begin to fall on you, from both of her mouths.\n\n" +
						"\"<i>See? You see, " + player.mf("Master","Mistress") + "?! I’m a werewolf! A beast, a filthy demonic beast wearing human skin! This is the real reason my last master fired me, the terrible secret he learned! I’m a monster! I tried to hide it, for your sake, but you’ve been teasing me for so long now I can’t hold it in anymore. But it's all okay, " + player.mf("Master","Mistress") + ", because I'm going to make you mine, now!</i>\"" +
						" She finishes by rearing back her head and releasing a feral howl that echoes through the night, screaming her madness and her passion to the blood red, full moon that looks down on this scene of insanity.\n\n" +
						"Before things get even more out of hand, how will you answer her advances?\n\n");
			}
			Sated = true;
			SatedCooldown = 24;
			menu();
			if (flags[kFLAGS.LUNA_FOLLOWER] > 6) addButton(0, "Accept", fullMoonEventAccept2);
			else addButton(0, "Accept", fullMoonEventAccept);
			if (player.dogScore() > 5 || player.wolfScore() > 5) addButtonDisabled(1, "Resist", "The smell of a female wolf in heat drives your canine instincts into a frenzy. You ");
			else addButton(1, "Resist", fullMoonEventResist);
		}
		public function fullMoonEventAccept():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			outputText("You declare that you won’t fight her.\n\n" +
					"She looks at you blankly, her mad mood suddenly gone, like a pricked bubble or a nightmare forgotten on waking, and she releases her hold on you to lean back in shock. \"<i>What? You.. you're just going to give in? Just like that, " + player.mf("Master","Mistress") + "?</i>\"\n\n" +
					"Of course, you explain. You would never have denied her needs if you had known of them. There was no need for her to hide her desires; gods know you've dealt with far crazier ones by now. And, you say, she is already more than just a maid to you. You just didn’t know how to tell her. You don’t care if she's a monster; she's a beautiful monster. To her utter surprise you");
			if (!player.isNaked()) outputText(" stand and take off your own clothes, and");
			outputText(" display your naked body, telling her she will get exactly what she wants. She grabs you and kisses you passionately, her long, wolfish tongue invading your mouth, and soon you return it, exchanging saliva and feelings with your lupine maid, before you pull apart for the main event.\n\n");
			if (flags[kFLAGS.LUNA_FOLLOWER] == 5 || flags[kFLAGS.LUNA_FOLLOWER] == 7 || flags[kFLAGS.LUNA_FOLLOWER] == 9) flags[kFLAGS.LUNA_FOLLOWER] = 11;
			if (flags[kFLAGS.LUNA_FOLLOWER] == 6 || flags[kFLAGS.LUNA_FOLLOWER] == 8 || flags[kFLAGS.LUNA_FOLLOWER] == 10) flags[kFLAGS.LUNA_FOLLOWER] = 12;
			flags[kFLAGS.LUNA_MOONING] = 2;
			doNext(sexMenuVaginalWW);
		}
		public function fullMoonEventAccept2():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			outputText("You apologize for playing hard to get, even if you didn't intend it, and tell her you'll play nice. Luna's posture goes from hostile to docile as if you had flipped a switch, and she drops to all fours awaiting her treat with a big, wolfish grin.\n\n" +
					"\"<i>" + player.mf("Master","Mistress") + ",</i>\"" +
					" Luna complains poutily, " +
					"\"<i>if you only were so kind the rest of the time I wouldn't have to jump you in the middle of the night like this. I always feel so terrible afterward, you know. Cruel, teasing " + player.mf("Master","Mistress") + ".</i>\"\n\n" +
					"Moved by a naughty impulse you respond that perhaps you <b>like</b> being jumped, then");
			if (!player.isNaked()) outputText(" take off your clothes and");
			outputText(" display your own naked body, visibly aroused and ready for sex. She responds with palpable ecstasy, panting and drooling with lust from both her wolfish mouths, eager for what comes next but waiting patiently on her " + player.mf("Master","Mistress") + ", just like the well-trained bitch in heat you know she is.\n\n");
			if (flags[kFLAGS.LUNA_FOLLOWER] == 5 || flags[kFLAGS.LUNA_FOLLOWER] == 7 || flags[kFLAGS.LUNA_FOLLOWER] == 9) flags[kFLAGS.LUNA_FOLLOWER] = 11;
			if (flags[kFLAGS.LUNA_FOLLOWER] == 6 || flags[kFLAGS.LUNA_FOLLOWER] == 8 || flags[kFLAGS.LUNA_FOLLOWER] == 10) flags[kFLAGS.LUNA_FOLLOWER] = 12;
			flags[kFLAGS.LUNA_MOONING] = 2;
			doNext(sexMenuVaginalWW);
		}
		public function fullMoonEventResist():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			outputText("You shove her with all your strength and get ready for a fight.\n\n" +
					"Luna growls menacingly at you. \"<i>I knew you would need some convincing, [name], but it's all right. I’m <b>more</b> than glad to help you with that.</i>\"\n\n" +
					"She falls on all fours, not in submission but ready to leap at your throat; her wolf tail trails on the ground, balancing her stance, and her ears flatten against her head. There's nothing left of your cute maid here, just a hungry wolf ready to tear you apart, and with her claws and fangs it's clearly something she’s capable of.\n\n" +
					"\"<i>You'll see things my way once you're no longer in any state to fight back. It's not my fault if you get hurt, " + player.mf("Master","Mistress") + ". I would <b>never</b> hurt you, " + player.mf("Master","Mistress") + "!</i>\"\n\n");
			player.createStatusEffect(StatusEffects.LunaMoonAttack, 0,0,0,0);
			startCombat(new Luna());
			doNext(playerMenu);
		}
		public function fullMoonEventResistWin():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			outputText("Luna falls to the ground in defeat, fully submitting to you. You swiftly tie her so she can't cause further trouble.\n\n" +
					"\"<i>" + player.mf("Master","Mistress") + "...</i>\" She whines at you, her voice weak and trembling like a scolded dog's. \"<i>I'm so, so sorry... I have no control over myself under the full moon. Please, " + player.mf("Master","Mistress") + ", I'm begging you, please, beat me, rape me, hate me, kill me... whatever you say I deserve, but please, " + player.mf("Master","Mistress") + ", please, please don't fire me. I'm begging you.</i>\"" +
					" Tears spill from her eyes as she sobs out her plea, leaving pale streaks in the dirt staining her mutated face.\n\n" +
					"Apologies can wait, you decide. Securing the camp matters more. Surprisingly, her own belongings include a heavy chain and manacles, hidden at the bottom of her things; perhaps she has encountered such a situation before? You use them to prevent her from harming you or anyone else, chaining, or maybe leashing her to a tree at the edge of the camp. Finally sure that she won’t cause more trouble you sit next to her and consider her future." +
					" Firing her had certainly occurred to you, but no matter how terrifying her attack, in her present state, weeping quietly with her face to the ground, you find it hard to muster any anger against her." +
					" You could keep her but make sure she is chained on nights of the full moon, you suppose, at least as a test. And it occurs to you, maybe a bit late in the game, that the issue could be resolved to everyone's satisfaction by giving her the attention and affection she craves, or at least as much of it as you can spare. What will you do?\n\n");
			monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
			cleanupAfterCombat();
			menu();
			addButton(0, "Fire Her", fullMoonEventResistWinFireHer);
			addButton(1, "Chain Her", fullMoonEventResistWinChainHer);
			addButton(2, "Accept", fullMoonEventAccept);
		}
		public function fullMoonEventResistWinFireHer():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			outputText("After you remove her chains and tell her your decision, Luna looks at you as if her world is breaking apart.\n\n" +
					"\"<i>" + player.mf("Master","Mistress") + ", I... no, you... you’re firing me?</i>\"\n\n" +
					"You harden your heart and repeat yourself. Luna grabs her head in her paws, claws drawing blood on her face, then looks at you for a split second more before running off into the woods." +
					" You feel a terrible, aching knot in your chest over the matter, but the safety of the camp and your quest comes first.\n\n");
			flags[kFLAGS.LUNA_FOLLOWER] = 2;
			flags[kFLAGS.LUNA_MOONING] = 1;
			if (!player.isNightCreature())
			{
				doNext(camp.sleepWrapper);
			}
			else doNext(camp.returnToCampUseOneHour);
		}
		public function fullMoonEventResistWinFireHerForest():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			outputText("As you explore the forest you come upon a terrible scene. You had hoped Luna would make it back to Tel’Adre, or somewhere safe, but it wasn't so. She’s in front of you, hanging from a rope tied to a tree, her naked human form looking frail and tiny against the demon-tainted woods. You should have known this would happen; you should have seen it in her face. You leave the gruesome scene, still shaken by her lifeless expression. Perhaps it really was your fault, perhaps not, but nothing can be done now.\n\n");
			flags[kFLAGS.LUNA_FOLLOWER] = 3;
			doNext(camp.returnToCampUseOneHour);
		}
		public function fullMoonEventResistWinChainHer():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			outputText("You tell Luna your decision: she can stay, but you will chain her to a tree every full moon from now on. It will be hard on her, but the safety of the camp and your quest comes first. She grimaces, but bows her head obediently - relieved, perhaps, that your decision was not the one she feared most.\n\n");
			flags[kFLAGS.LUNA_FOLLOWER] = 9;
			flags[kFLAGS.LUNA_MOONING] = 1;
			if (!player.isNightCreature())
			{
				doNext(camp.sleepWrapper);
			}
			else doNext(camp.returnToCampUseOneHour);
		}
		public function fullMoonEventResistDefeat():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			outputText("You collapse, unable to continue the fight. Before you can blink Luna is on you, and you’re back where you started this crazy night, pinned underneath your maid's giant wolf paws as she slavers hungrily over you. But this time, there's no escape and, you fear, no more talking your way out. Luna will decide your fate.\n\n" +
					"\"<i>" + player.mf("Master","Mistress") + ", sweet, wonderful [name], it's ok,</i>\"" +
					" she says, gently, motherly, as she leans closer and closer until her breath comes hot and wet against your face. " +
					"\"<i>Everything will be ok now. The pain will only last for a few seconds and then... then...</i>\"\n\n" +
					"Giving you no chance to question her, she lunges and bites right into your shoulder. At first it hurts like crazy but then, as she promised, the pain recedes, replaced with spreading pleasure as the wounds begin to throb and, to your surprise, close. Your" + (player.hasCock() ? " [cock] suddenly springs erect" : "") + "" + (player.gender == 3 ? " and your" : "") + "" + (player.hasVagina() ? " pussy begins dripping" : "") + ", your breath quickens, and your skin begins to flush; you feel aroused but also sick, as if you were having an allergic or toxic reaction.\n\n" +
					"\"<i>I'm sorry, " + player.mf("Master","Mistress") + ". You may hate me at first, but to ensure that we'll always, always be together this is a price worth paying. I know you'll agree with me when it's over, that you'll love me the way you should. I'll be right here with you, I'll stay with you forever and ever. You won't have to endure it alone the way I did.</i>\" You realize that tears are falling from here large, phosphorescent green eyes onto you as she speaks in a voice wet with emotion, her face a twisted mask of love and guilt and agony.\n\n" +
					"But before you can process the emotions she's expressing, or perceive your own, " + (player.humanScore() < 30 ? "your body starts changing, and to your surprise, its features warp back to their old human appearance. For an instant you think she may have somehow restored your already lost humanity, but it isn't so, not exactly, you realize, as " : "") + "fresh, new heat begins to spread from your rapidly healing tooth-marks and you start panting, trying to vent out the pleasure and the hot feeling in your body as something fundamental inside you begins to twist and warp.\n\n" +
					"You half-shout, half-moan as fur begins to grow on your arms and legs. Your nails sharpen and curve into lethal-looking claws as your hands and feet reshape into padded, lupine paws. You groan in pain and pleasure, opening your mouth to reveal your lengthening canines as your spine extends into a furry tail while your ears migrate to the top of your head, sprouting smooth fur and changing into triangular points like those of a wolf. " +
					"As your tongue lolls out of your slack jaw it rests against Luna's chest, and you realize that she is holding you closely, supporting you gently in her arms as you succumb, granting you a mercy and kindness in the midst of this terrifying, mesmerizing process that she must have wanted and been denied.\"\n\n");
			if (player.hasCock()) outputText("As your thoughts turn to her you feel a tightness near the base of your cock, where your skin bunches and folds inward into a canine sheath, tightening and pulling your still-erect, straining length inside its hot depths before it once again surges out with a burst of pain and pleasure. Your dick is now blood-red, the base swollen into a grotesque, vein-covered knot, and the tip pointed. The sensations are too much for you, and you throw back your head and howl as your new lupine member erupts in a spray of hot cum against your lover, your pack-mate, your curse");
			player.lowerBody = LowerBody.WOLF;
			if (player.legCount != 2) player.legCount = 2;
			player.tailType = Tail.WOLF;
			if (player.tailCount != 1) player.tailCount = 1;
			player.rearBody.type = RearBody.WOLF_COLLAR;
			player.arms.type = Arms.WOLF;
			player.faceType = Face.WOLF_FANGS;
			player.ears.type = Ears.WOLF;
			player.eyes.type = Eyes.FERAL;
			player.tongue.type = Tongue.DOG;
			player.wings.type = Wings.NONE;
			player.antennae.type = Antennae.NONE;
			player.horns.type = Horns.NONE;
			player.skin.growCoat(Skin.FUR, {color:player.hairColor}, Skin.COVERAGE_LOW);
			if (player.hasCock() && player.wolfCocks() < 1) {
				var selectedCockValue:int = -1;
				for (var indexI:int = 0; indexI < player.cocks.length; indexI++)
				{
					if (player.cocks[indexI].cockType != CockTypesEnum.WOLF)
					{
						selectedCockValue = indexI;
						break;
					}
				}
				if (selectedCockValue != -1) {
					player.cocks[selectedCockValue].cockType = CockTypesEnum.WOLF;
					player.cocks[selectedCockValue].knotMultiplier = 1.1;
					player.cocks[selectedCockValue].thickenCock(2);
				}
			}
			player.createPerk(PerkLib.Lycanthropy,40,0,0,0);
			player.dynStats("cor", 20);
			statScreenRefresh();
			outputText("The process complete, you begin seething with newfound strength, of body and of lust. You push out of Luna's embrace, reeling backward, but quickly lunge at her again. She emits a half-frightened, half-aroused yip as you bowl her over, with you on top. Your pack-mate, your bitch... you must take her, make her yours... NOW!\n\n");
			monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
			cleanupAfterCombat();
			doNext(sexMenuDominateHer);
		}
		public function sexMenuMain():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You mention to Luna that you are feeling certain needs, and desire her help. She blushes furiously and looks away for a moment, though you're sure she's smiling.\n\n" +
					"\"<i>Oh, " + player.mf("Master","Mistress") + "... I would be proud to attend you in any way you desire. What do you wish of your servant?</i>\"\n\n");
			menu();
			if (player.cor >= 15) addButton(0, "Headpat", sexMenuHeadpat).hint("You know it's lewd, you know it's wrong, but you just can't help it.");
			else addButtonDisabled(0, "Headpat", "That's lewd! How could you even think of such a thing??");
			addButton(1, "Human", sexMenuDomesticService).hint("Get some intimate domestic service from your cute maid Luna.");
			if (player.gender > 0 && player.lust > 33) addButton(2, "Werewolf", sexMenuDoggyTreats).hint("Take a walk on the wild side and give your doggy a treat.");
			else if (player.gender == 0) addButtonDisabled(2, "Werewolf", "You're going to need some special equipment to play with this pup.");
			else if (player.lust <= 33) addButtonDisabled(2, "Werewolf", "Bringing the beast out in Luna when you're not up for sex is too terrible of an idea even for you. Please reconsider.");
			if (player.lust > 33 && player.gender > 0) {
				if (flags[kFLAGS.AYANE_FOLLOWER] >= 2 && flags[kFLAGS.LUNA_AFFECTION] == 100 && player.hasCock()) addButton(3, "Fox&Hound", sexMenuSandwichWithAyane).hint("Some group action could be fun, and you bet Ayane would be up for it too.");
				else if (flags[kFLAGS.AYANE_FOLLOWER] >= 2) addButtonDisabled(3, "Fox&Hound", "Some group action could be fun if you were sure Luna would do it, but you don't want to push your luck. You know how jealous she gets... Of course to even do 'that' you would also need a penis.");
				else addButtonDisabled(3, "???", "Get a certain other fluffy-tailed follower to join your camp and maybe you can have some group fun.");
			}
			addButton(14, "Back", mainLunaMenu);	
		}
		/*
		public function sexMenuMain():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You mention to Luna that you are feeling certain needs, and desire her help. She blushes furiously and looks away for a moment, though you're sure she's smiling.\n\n");
			outputText("\"<i>Oh, " + player.mf("Master","Mistress") + "... I would be proud to attend you in any way you desire. What do you wish of your servant?</i>\"\n\n");
			menu();
			if (player.lust > 33 && player.gender > 0) {
				addButton(0, "Vaginal", sexMenuVaginalIntro);
				addButton(4, "DominateHer", sexMenuDominateHerIntro);
				if (player.hasCock()) {
					addButton(1, "Spear P.", sexMenuSpearPolishing);
					if (player.cockArea(player.biggestCockIndex()) > 15) addButton(2, "Boobjob", sexMenuBoobjob);
					addButton(3, "Doggy T.", sexMenuDoggyTreats);
					if (flags[kFLAGS.AYANE_FOLLOWER] >= 2 && flags[kFLAGS.LUNA_AFFECTION] == 100) addButton(6, "Sandwich", sexMenuSandwichWithAyane);
					else addButtonDisabled(6, "???", "Req. Ayane in camp and 100 affection.");
				}
			}
			if (player.cor >= 30) addButton(10, "Headpat", sexMenuHeadpat);
			else addButtonDisabled(10, "Headpat", "You're too pure for that!");
			addButton(14, "Back", mainLunaMenu);			
		}
		*/
		public function sexMenuDomesticService():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You ask Luna if there's anywhere you can go where she can service your needs more privately. She nods understandingly and leads you to an out of the way corner of the camp." +
					" There is a mat woven from soft rushes laying on a patch of grass, and a shady tree and a large boulder with a smooth, flat side create a comfortable and secluded atmosphere. You hear the stream running nearby, giving the entire scene a peaceful, rustic atmosphere. It's quite charming and intimate feeling, and you wonder when and why she found time to set this up. Was she anticipating this?\n\n" +
					"Luna awaits your command, her hands joined demurely in front of her abdomen and her head lowered deferentially. How will you make use of her?");
			menu();
			addButtonDisabled(0, "JustCuddle", "NYI - Scary Dragon Mom hasn't written the scene yet. Get on her!" );
			if (player.lust > 33 && player.gender > 0) addButton(1, "Vaginal", sexMenuVaginalIntro).hint("Have Luna soothe and pleasure you with her (currently, at least) normal human pussy; sometimes simple is best, and your cute maid can still be the best even when she isn't the beast.");
			else if (player.lust > 33 && player.gender == 0) addButtonDisabled(1, "Vaginal", "You need to have genitals if you want Luna to use her own on them!");
			else if (player.lust <= 33) addButtonDisabled(1, "Vaginal", "You're not up for sex at the moment, though you're sure Luna can find a way to fix that.");
			if (player.lust > 33 && player.hasCock()) addButton(2, "SprPolish", sexMenuSpearPolishing).hint("She may not have scales or a tail, but you still have a spear and she's still a maid; you're pretty sure you can make this work somehow.");
			else if (player.lust > 33 && !player.hasCock()) addButtonDisabled(2, "SprPolish", "Your maid can't polish a spear you don't have!");
			else if (player.lust <= 33) addButtonDisabled(2, "SprPolish", "Your spear isn't feeling hard enough for a good polishing right now. Come back when you're in a more in ... stabby mood.");
			if (player.lust > 33 && player.hasCock()) addButton(3, "Titfuck", sexMenuBoobjob).hint("Luna will give you a nice cock massage with her pert C-cups if you ask politely. She'll still do it if you ask rudely, but you're feeling nice today.");
			else if (player.lust > 33 && !player.hasCock()) addButtonDisabled(3, "Titfuck", "You're sure Luna would love to wrap her nice, hand-sized tits around your cock, if only you had one.");
			else if (player.lust <= 33) addButtonDisabled(3, "Titfuck", "Luna's breasts look very nice under her dress and apron, but you're not turned on enough for anything but aesthetic appreciation just now.");
			addButton(14, "Back", mainLunaMenu).hint("Actually, never mind, sex is overrated. You've got cooler things to do.");
		}
		public function sexMenuHeadpat():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			outputText("Luna is so cute you can’t help yourself; you just start patting and rubbing her head! She makes a noise of surprise and objection but before long her eyes close and her face melts with delight as her ears morph into their wolfish appearance - which you promptly begin scritching, increasing her bliss even further. Her tail pops out and wags from side to side as she sighs in bliss, and you hear her foot tapping the ground. A little line of drool starts trailing down from her slack mouth." +
					" Eventually, who knows how, she realizes through her mesmerized state that she’s starting to change and swiftly collects herself, pulling back her animalistic features with embarrassed tears in her eyes.\n\n" +
					"\"<i>I'm so sorry, " + player.mf("Master","Mistress") + ", I-I don’t know what happened, it just felt so good and I... I... I have to go finish my chores!</i>\"\n\n" +
					"\"<i>How could youuuuu?</i>\" She trots away with a retreating accusation, her tail still out and wagging like a giant gray feather duster, which you point out. She swiftly hides it and rushes off to continue her work with a scarlet face, glancing at you resentfully every few seconds until she moves out of your view.\n\n" +
					"...you pervert.");
			doNext(camp.returnToCampUseOneHour);
		}
		public function sexMenuVaginalIntro():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			sexMenuVaginalIntro2()
		}
		public function sexMenuVaginalIntroWW():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			sexMenuVaginalIntro2()
		}
		public function sexMenuVaginalIntro2():void {
			outputText("Long hours spent fighting, exploring, and engaging in other... rough activities, have left your body aching and fatigued, and even though it was you that propositioned her in the first place you're having a hard time mustering up any enthusiasm. Luna easily picks up on your discomfort and moves forward to embrace you gently.\n\n" +
					"\"<i>" + player.mf("Master","Mistress") + ", are you well? Have your travels left you weary?</i>\"" +
					" she asks you in a voice filled with care and concern.\n\n" +
					"You assure her you’re fine, just a little tired and sore, though the opponents you've faced and the very environment of this tainted land have left you pent up as well. Still, perhaps some simple rest would be better after all...\n\n" +
					"Before you can finish your thought Luna pulls herself up into a kiss, starting gently to quiet your murmered complains, then deepening into a passionate, lover's kiss. You return it, and your tongues intertwine, passionately but gently, as she winds one arm around your back while the other softly massages the nape of your neck.\n\n" +
					"When she finally breaks the kiss and her soft, golden eyes meet yours ");
			if (player.cor < 50) outputText("you begin to thank her for the care and affection she alwyas shows you,");
			else outputText("you are about to tell her to strip for you,");
			outputText(" but she places a finger gently on your lips, still wet from your mixed saliva, and quietly, soothingly shushes you. " +
					"\"<i>Shhh. No more words, " + player.mf("Master","Mistress") + ". I already understand everything. Just let your cute maid Luna take care of you now. I'll handle everything for you, so just relax.</i>\"\n\n" +
					"You find yourself powerless to resist her gentle exhortation, and merely nod. ");
			if (!player.isNaked()) {
				outputText("Luna removes your equipment with a practiced, gentle touch, taking the opportunity to rub your aching muscles with her soft, warm hands as she strips you naked. ");
			}
			outputText("You sit down at her direction, your back to a smooth, cool boulder, tired but already flushed with arousal, and she calmly removes her dress, revealing her slender, modest figure framed by cute white lingerie, matching her stockings and headband. She unhooks and slips off her bra; her breasts are shapely and firm, the nipples on the front pink and petite, not exaggerated and bloated like so many of the corrupted creatures you've faced. The sight refreshes your spirit even as your lust builds, drawing your gaze down to her shapely hips and soft thighs as she removes her panties and stockings. She leaves her headband and stockings on, framing her naked body with white ribbons and frills. Her sex is flushed and moist with anticipation, but without the drooling, gaping look of the hungry female maws constantly threatening to devour you during your adventures the sight feels nearly innocent. If you didn't know she was a werewolf you would think she was a sweet girl from your old world, a rosy-cheeked, cute lover you might have dreamed of as a teenager in Ingnam. With an angelic smile she keeps her loving, golden eyes locked with yours as she kneels in front of you.\n\n");
			doNext(sexMenuVaginal);
		}

		public function sexMenuVaginal():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			sexMenuVaginal2();
		}
		public function sexMenuVaginalWW():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			sexMenuVaginal2();
		}

		public function sexMenuVaginal2():void {
			if (player.hasCock()) {
				outputText("Luna reaches out with her small, delicate hands and begins gently stroking your already throbbing cock with smooth, sensual motions that feel soothing, peaceful; even as your aching need for release builds you feel the rest of your body relaxing, and you sigh in bliss. She leans forward and plants a gentle kiss on your mouth, then your chin, neck, chest, and on down until her mouth is in front of your flushed tip, already leaking heavily under her ministrations." +
						" There she begins kissing and licking it as well, still oh so softly, gently, like a mother cat grooming its kitten, no hunger or need in her movements as she worships your engorged member with the most loving, almost motherly care you recall it ever receiving. Before long little gasps and moans are escaping your rapidly melting body as her small movements bring you outsized pleasure.\n\n" +
						"Before you reach climax she gradually eases her movements, merely cradling your length in her hands, then raises her head to kiss you gently on the lips once more; her mouth tastes of salt and sex and her own sweet saliva, and when she breaks it she whispers in your ear. " +
						"\"<i>You see, Master, no one knows what you need better than Luna. No one loves you like your sweet maid Luna. Just relax and let your maid handle everything. Luna will take care of you, as much as you need, as many times as you need, until everything is perfect. Shhhhhhhhh, don't speak. Just let me feel your love, your love for your cute little maid who loves you more... than anyone... else... mmmmmmmmmMMMaaaahhhahaha... </i>\"\n\n" +
						"As she ends her hypnotic, whispered exhortation, you realize she has already aligned your cock with her own soft, wet sex, and with a little gasp of delight that bubbles into an adorable giggle, she slowly hilts herself, then places her now free hands on your shoulders. Her small, pearly teeth are visible as she softly bites her own lower lip in ecstasy, but her golden eyes are fully locked with your own as she begins slowly moving up and down, back and forth, her moist, warm walls cradling and massaging your throbbing length in an indescribable way; soft, sweet, calm, gentle, but sending electric shocks of pleasure up through your hips and torso with every gradual change in direction and movement.\n\n" +
						"You are almost embarrassed by how little time you last inside her; your seated position, the sweet relaxation she's brought to your aching muscles, and the completely unguarded, intimate feeling of her loving gyrations on and against you have left you completely unable to resist the orgasm that forces its way through your hips. With a stuttering gasp, almost a sob, of pleasure you release inside her, burning cum painting her insides white as you empty yourself, almost spiritually so, in her comforting depths.");
				if (player.cumQ() <= 500) outputText("By the time the orgasm subsides you feel scrubbed out, clean, like the pale gray sky after a summer storm. Luna softly moans in pleasure as your passion fills her, and without pulling you out of herself she tightens her hold on you into a close, intimate embrace. Your head rests comfortably against her shoulder, and she slowly runs a hand up and down the back of your neck and head, gently petting you as she whispers in your ear again. \"<i>Mmmmmmmmm... that's right, " + player.mf("Master","Mistress") + ", just let everything go. Luna will take care of you. Just rest. I'll never, ever let you go, " + player.mf("Master","Mistress") + ", never. I'll hold you like this forever, until everything is okay again, so just close your eyes and rest. Everything you want, everything you need, Luna will give you. As long as you love only your cute maid, you don't need anyone else.</i>\" Drowsily you realize she hasn't reached orgasm herself yet, but the thought doesn't feel urgent or strong enough to rouse you from the soft, sleepy bliss, of her embrace. Still inside Luna, her hot, wet walls softly massaging your length even at rest, still wrapped in her gentle, loving arms, the world fades out until it seems like the only reality you've ever known is here, swaddled in Luna's love. Your last, blurry thought is that maybe she's right, maybe you don't need anyone else.\n\n");
				else if (player.cumQ() <= 1000) outputText("The orgasm lasts what feels like almost a minute as you keep spurting into Luna's softly squeezing insides. She moans in pleasure as she expertly manipulates her groin and abdominal muscles to milk you gently, prolonging the climax without urgency, and you collapse forward into her arms helplessly as she pulls you into an embrace. \"<i>Mmmmmmmmm... ahhhh... that's right " + player.mf("Master","Mistress") + ", just let it all out. Let everything go in my pussy... all your fatigue, all your stress, all your worries. Luna will take care of you. Just let go and relax. I'll never, ever let you go, " + player.mf("Master","Mistress") + ", never. I'll hold you like this forever, until everything is okay again, so just close your eyes and rest. Everything you want, everything you need, Luna will give you. As long as you love only your cute maid, you don't need anyone else.</i>\" Your prolonged orgasm ends as she murmurs in your ear, cum dripping from her pussy as she keeps gently squeezing you, softly massaging your length until the last few spurts been pushed out. She keeps you inside her, still softly massaging your flagging member with her muscles even at rest, the world fades away until it seems like the only reality you've ever known is here, swaddled in Luna's love. Your last, blurry thought is that maybe she's right, maybe you don't need anyone else.\n\n");
				else if (player.cumQ() <= 2000) outputText("The orgasm seems to last forever; unlike the explosive, hose-like ejaculations you've become accustomed to since the corrupted magic in this land warped your body, this one feels easy, almost gentle, except that it won't stop; your hips twitch faintly as you spurt over and over again into her warm, wet depths as she softly massages you with pelvic and abdominal muscles that would do a dancer proud. Before long you collapse forward into Luna's arms in slack, mindless bliss, resting your head on her shoulder and cumming for minutes on end while she gently milks your cock and murmurs softly in your ear. \"<i>Mmmmmmmmm... haaaa, haaaa, mmmmm... yes, yes " + player.mf("Master","Mistress") + ", that's right, don't stop. Let everything go in my pussy... all your fatigue, all your stress, all your worries, I'll take everything for you. Just close your eyes and relax, and Luna will take care of you. Everything you want, everything you need, Luna will give you. As long as you love only your cute maid, you don't need anyone else.</i>\" Finally your extended release into her welcoming depths comes to a sputtering end. Cum is pouring from her pussy as it wraps softly around your flagging member, dripping down your hips and thighs and soaking the ground around you, and like a puppet with its strings cut consciousness leaves you, still inside Luna, her arms still wrapped around you; it feels like this is the only reality you've ever known. Your last, blurry thought is that maybe she's right, maybe you don't need anyone else.");
				else outputText("The orgasm never ends as you spurt over and over and over into Luna's pussy, quickly filling her wet tunnel and womb and spilling out in cascading waves around your hips and thighs. Unlike the geyser-like ejaculations you've become accustomed to since the corrupted magic of this land changed you, this one is almost normal, save that it keeps going and going. You quickly lose control of your body under the relentless, gentle pleasure and fall forward into Luna's arms, which she wraps around you in a blissful embrace, gently rubbing your back and head while your hips twitch as you empty your bottomless load into her welcoming depths. \"<i>Ahhhhhhhhnnnnnn... mmmmmmmmmmhhhh... oh, yes, yes " + player.mf("Master","Mistres") + ", don't stop. I want all of it, let everything go in my pussy... all your fatigue, all your stress, all your worries, everything, I'll take everything. Just relax and let Luna take care of you. Everything you want, everything you need, Luna will give you. You don't... haaaahhh, haaaaahh, mmmmmmmmhhh... you don't need anyone else, not as long as you love your cute maid... oh gods..... it isn't stopping... mmmmmMMMMMMMmmm...</i>\" Luna's pussy contracts around your still spurting cock suddenly as she reaches her own climax, and the pleasure sends your already over-stimulated brain into shutdown mode. Your world fades to white as you sit there, still cumming into Luna while she moans softly in your ear, her arms still wrapped around you, your head still on her shoulder, your mixed fluids pooling into a small lake around the two of you. As your malfunctioning brain shuts down, your last confused thought is that she's right, you don't need anyone else.");
				outputText("You awaken an hour later to find yourself still leaning back against the boulder, a feeling of blissful looseness in your body. It seems Luna placed a soft cloth behind you and covered your naked legs and groin with another before resuming her duties. As much as you feel like remaining there, the feeling of her warm body still somehow fresh against you, you have things to accomplish and get yourself ready for more adventuring. As you finish you catch sight of Luna, dressed neatly in her uniform once more and busy airing out the camp's laundry and bedrolls. She notices you and, breaking from her usual professional stoicism, gives you a knowing smile and a soft look through half-lidded eyes, and as you turn to leave the one blushing furiously is you, for once.");
				}
			else {
				outputText("Luna leans forward, bracing herself against the boulder behind you with one hand and bringing her face to yours and once more kissing you, this time tickling your lips with short pecks over and over, sometimes gently nibbling or sucking on your lip, varying the pace and intensity, though never frenetic or rough; always soft, loving, tender. Meanwhile her free hand traces slowly down your side, fingers brushing teasingly down to your hip, across your thigh, and back up until she begins to graze your labia, wetness already leaking between your engorged labia. She slowly circles your sex, sometimes skipping across your lips or grazing your sensitive clit, until you find yourself bucking your hips forward for stronger contact; but she breaks off her oral ministrations to tell you quietly " +
						"\"<i>Shhhhhhh. No, " + player.mf("Master","Mistress") + " just relax. I promise your sweet Luna will give you everything you need.</i>\"" +
						" You nod meekly at the gentle remonstrance and try to relax yourself, and she resumes her loving kisses for a moment before she leans back, still softly stimulating your cunt with one hand while she begins to stimulate herself with the other. In a moment both of you are emitting little gasps and moans of pleasure." +
						"Pausing her teasing movements for a moment, Luna giggles cutely between heavy, flushed breaths, gazing into your eyes with her own golden ones, filled with love and care. She places her soft, warm, and now damp hands on your upper arms and leans forward once more to kiss your mouth, then moves down to your chin, your neck, your collarbone, before moving on to your sensitive nipples; while her hands gently keep your arms at rest she licks, kisses, and gently suckles your hardened nubs, eliciting moans of pleasure." +
						" After a short while of that she removes her hands from you once more and scoots in closer, lifting one of your legs up so she can bring her hips to yours, and you feel her hot, wet vagina pressing against your own longing hole." +
						"With that contact achieved she reaches out and pulls you into a close, loving embrace; you feel her soft skin press against you, her breasts spreading on your chest, her own nipples, petite, stiff little nubs, grind sensuously against you as she begins moving her hips up and down, back and forth. The feeling is so intimate, so sweet and loving, that you can't help but melt against her, and placing your own arms around her you rest your head comfortably on your shoulder and give in entirely to the pleasure of her touch. She whispers softly into your ear, " +
						"\"<i>That's right, " + player.mf("Master","Mistress") + " just let Luna do her magic. No one knows what you need like your cute maid, no one loves you like her. Just let me handle everything, and let yourself go. I'll hold you like this until everything's right again. I'll never, ever, ever let " + player.mf("Master","Mistress") + " go, never. All I want in return is to feel your love for me, who loves you better... than anyone... else... mmmmmmmmmaaahahaaaa...</i>\"\n\n" +
						"As she murmers her hypnotic, honeyed words into your ear she gradually increases the intensity of her movements against you, eventually breaking into a sweet, breathy moan that gives way to pleasured gasps that match the ones you've been making yourself, and you both submit to her motions entirely. Her engorged clit and labia rub slickly against your own, the mixed fluids of your shared pleasure lubricating and intensifying the sensations until they're jolting up your hips and stomach with electrifying pleasure." +
						" After a while you begin to lose sense of time and place, until it feels like your entire being occupies the shared points of contact between the two of you." +
						" Your world begins and ends where your body presses against hers, where her arms warmly press and massage your back and shoulders, her breasts and stomach caress yours, her mouth presses to yours, again and again in impassioned, oral worship, and her hot sex rubs and presses and gently prys yours open and closed, until you both reach a gasping, prolonged orgasm. Luna's arms pull you in even closer as you both peak, and her sweet, gasping moans sound directly into your ear." +
						" Your bodies jerk and spasm against each other in ecstasy, further prolonging the climax, until finally your shared, gasping orgasms subside and your nerveless arms slide down her back to rest beside you." +
						" You feel utterly spent, but also blissfully relaxed and peaceful, the same way you felt as a child in Ingnam after a good hard cry, and Luna keeps holding you tightly against her, giggling a bit and softly kissing your neck." +
						"\"<i>Yes, " + player.mf("Master","Mistress") + ", that's it... you don't have to worry about anything. Your loving maid Luna is here, and I'll hold you just like this until it's all better. Just close your eyes and sleep. You don't have to worry about a thing. All you need is right here. Your Luna will give you everything, everything you want, everything you need, as long as you love only me.</i>\"" +
						" The blissful feeling of release and relaxation work together with her soft, soothing voice and lull you into unconsciousness, your head still resting on her delicate shoulder, her arms still around your back, her breasts and hips still pressed into yours. Swaddled in your cute maid's love, the last blurry thought you have is that maybe she's right, maybe you don't need anyone else.\n\n" +
						"You awaken an hour later to find yourself leaning back once more against the boulder, a feeling of blissful looseness in your body. It seems Luna placed a soft cloth behind you and covered your naked legs and groin with another before resuming her duties. As much as you feel like remaining there, the feeling of her warm body still somehow fresh against you, you have things to accomplish." +
						" Groaning a a bit in protest, you get yourself prepared for more adventuring. As you finish you catch sight of Luna, dressed neatly in her uniform once more and busy airing out the camp's laundry and bedrolls. She notices you and, breaking from her usual professional stoicism, gives you a knowing smile and a soft look through half-lidded eyes, and as you turn to leave the one blushing furiously is you, for once.\n\n");
				}
			lunaJealousy(-100);
			lunaAffection(2);
			player.orgasm();
			if (flags[kFLAGS.LUNA_MOONING] == 2) {
				flags[kFLAGS.LUNA_MOONING] = 1;
				if (!player.isNightCreature())
				{
					doNext(camp.sleepWrapper);
				}
				else doNext(camp.returnToCampUseOneHour);
			}
			else doNext(camp.returnToCampUseOneHour);
		}
		public function sexMenuSpearPolishing():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			var x:int = player.cockThatFits(36, "length");
			outputText("You ask your charming maid Luna if she wouldn't mind pleasuring you orally today.\n\n" +
					"At your request she simply nods. " +
					"\"<i>I am always happy to oblige " + player.mf("Master","Mistress") + " however you desire. Please, relax and let me take care of your needs.</i>\"" +
					" So replying, she takes your hand and leads you to a nearby boulder with a smooth, comfortable surface on its side. ");
			if (!player.isNaked()) {
				outputText("She removes your equipment with a practiced, gentle touch, taking the opportunity to gently massage your body with her soft, warm hands as she strips you naked");
				if(player.biggestTitSize() > 0) outputText(", particularly your [breasts], you note - not that you have any objection to her skilled, teasing caresses");
				outputText(". Once you are naked, ");
			}
			outputText("Luna requests that you sit with your back to the boulder. You readily comply, and she begins removing her own clothing, shedding her dress and undershirt, until she is wearing only her headband, stockings, and lingerie, which are white and frilly to match. The sight of her dainty, trim figure so framed and just barely concealed is adorable, and stimulating enough to bring you to full mast all by itself." +
					" Briefly you wonder where she got such nice undergarments and how she keeps them so clean and fluffy-looking out here in the wilderness with all the other work she does, but her next actions soon dispel your idle musings." +
					"Locking her golden eyes with yours, she walks toward you, seductively swaying her modest but shapely hips. When she is directly in front of you she kneels down, and without breaking eye contact she takes your throbbing length in her small, soft hands and begins stroking it gently, gradually working your length until your erection is straining against its natural limits and your cock is as hard as the rock you are resting against. She gives you a gentle, knowing smile, then finally breaks eye contact as she closes her eyes and bends forward to kiss you.\n\n" +
					"At first, the kiss is dainty and chaste, but soon she pries your lips open and invades your mouth with her little tongue; you allow her in and soon she is curling it around yours and noisily exchanging saliva with you until it dribbles down both of your mouths. At the same time her hands work your member faster and faster, though still gently, until you nearly feel an orgasm building." +
					" Then she stops, and with an exaggerating slurping sound she sucks up all the saliva between your mouths into her own and breaks the kiss, bending down and releasing it on your already drooling tip in a single, slow dribble, slowly resuming her caressing in order to spread the warm, sticky liquid all over your cock. She looks up at you one last time with a predatory smirk and the most sensuous bedroom eyes you've ever seen her make, and begins to lick and kiss and gently nibble your throbbing pole, starting from the tip and working her way down to the base");
			if (player.balls > 0) outputText(", then down to your full, aching " + (player.balls == 2 ? "pair" : "quartet") + ", lavishing your tender orbs with her soft, wet lips and tongue until they are dripping with your mixed fluids");
			if (player.balls > 0 && player.hasVagina()) outputText("; then, after that, with her hands taking over for her mouth on your twitching manhood, she moves her oral worship even further");
			if (player.balls == 0 && player.hasVagina()) outputText(", and past that");
			if (player.hasVagina()) outputText("to tease your engorged, sensitive clitoris and gently pry open your lower lips, teasing and kissing and nibbling until you are squirming in alarmed ecstasy");
			outputText(" before she licks and kisses her way once more back to your tip, now practically weeping precum, which she gleefully uses her hands and mouth to spread and mix onto the rest of your length until your groin and her face are a sopping mess.\n\n" +
					"Next, after pulling away from one last loving nibble on your head with a wet 'pop', she giggles and moves her hands slowly, slowly, to the base of your penis, where she begins using her thumbs to gently, slowly massage the very bottom where it emerges from your body. The feeling is indescribable, but before you can fully appreciate you gasp in redoubled pleasure as she takes you to the hilt in her mouth in a single, swift motion, her soft mouth and her tight throat stroking and massaging it the moment you are inside, and before the shock of pleasure can subside she extends it by beginning a steady pumping with her neck, letting you almost out and then forcing you back in, her lips keeping a tight seal around your member.");
			if (player.cocks.length > 1) outputText("Ever too much the devoted servant to leave your [cock biggest2] lonely and unattended, she frees her hands from their gentle root massage and uses them on it, pumping up and down in time with her oral movements on your other one.");
			if (player.cocks[x].cockLength >= 7) outputText(" She soon reaches a pace, hilting you and then pulling up, your swollen tip feeling the back of her throat and then the tight seal of her lips, one after the other, over and over until you are moaning loudly in sticky, melty bliss.");
			outputText("As her movements settle into a steady rhythm you place your hands on the back of her head to guide her pace more closely. You gasp and pant in pleasure as her expert blowjob quickens and intensifies until you finally tell her you're about to cum and release her head from your grip. Instead of pulling back, she pushes your length even further down into her warm, wet mouth and you cry out in orgasm while she takes your hot load with strong, gulping swallows");
			if (player.cocks.length > 1) outputText(" while your other cock" + (player.cocks.length == 2 ? "" : "s") + " explodes messily, painting the top of her head and your own torso with spurt after spurt of white, sticky cum");
			outputText(".");
			if (player.cumQ() >= 2000) {
				outputText("By the time your massive ejaculation is finally finished and only a few more weak strings are spurting still from your mostly spent member, ");
				if (player.cocks.length > 1) outputText("your free [cock biggest2] has painted both of you and much of the surrounding area with the fruit of your orgasm, while ");
				outputText("Luna's belly is visibly distended from the amount of your cream she has hungrily sucked down.");
			}
			else if (player.cumQ() >= 1000) {
				outputText("By the time your prolonged ejaculation finally ends and only a little cum still dribbles from your spent member");
				if (player.cocks.length > 1) outputText("your free [cock biggest2] has covered both of you in sticky, hot cum, and ");
				outputText(" Luna has a full-looking tummy resting over her shapely hips from everything she swallowed.");
			}
			outputText(".\n\n");
			outputText("With one last noisy 'pop' she finally pulls her mouth from your now drooping length, licks a few stray dribbles from around her lips and off her fingertips. Then she smiles at you lovingly and says, in an exaggeratedly sugary tone " +
					"\"<i>Oh my, " + player.mf("Master","Mistress") + "if I'd known you were going to feed me such a sumptuous snack I wouldn't have prepared my own meal today~. You must really love your cute maid Luna to offer her such a delicious treat~. I'll have to make your dinner <b>extra</b> special tonight to thank you~!</i>\"" +
					" She kisses you one more time and then collects her dress, heading to the river to clean off before she resumes her work. You wait for a few moments, still panting in spent, shivering bliss, before you rise and follow her to do the same.");
			lunaJealousy(-100);
			lunaAffection(2);
			player.sexReward("saliva");
			doNext(camp.returnToCampUseOneHour);
		}
		public function sexMenuBoobjob():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You find your eyes drawn to Luna's modest chest. You know that what she's sporting under that frilly apron aren't the largest, softest, or most versatile mammories in Mareth, ");
			if (player.biggestTitSize() > 3) {
				outputText("or even between the two of you, to be frank, ");
			}
			else if (followerKiha() || isabellaFollower() || sophieFollower() || followerHel()) {
				outputText("or even in a hundred foot radius, really, ");
			}
			outputText("but even so you decide that right now they're ideal. As you quietly finish your lusty calculation, Luna tilts her head quizzically under your evaluating gaze. Having made up your mind, you ask her if she would be so kind as to stroke your cock to climax between her breasts.\n\n" +
					"Luna widens her eyes and blinks at your request, then immediately recovers and nods obediently. " +
					"\"<i>Of course, " + player.mf("Master","Mistress") + ", I am always delighted to aid. My body is ever yours to use as you please.</i>\"\n\n" +
					"Luna gently takes your hand and leads you to a secluded area of the camp where a soft mat of woven grasses has been laid out. Did she anticipate this? Before you can ask, she");
			if (!player.isNaked()) outputText(" requests that you remove your clothing, which you do eagerly. As you do so she");
			outputText(" begins to expose her chest, first untying the neck of her apron from behind her shoulder-length ash-brown hair, letting it fall forward supported by its waist-strap. She then unbuttons the front of her modest black dress, her slender fingers undoing each button quickly but carefully one at a time as you watch, mesmerized. She notices your attention and smiles, slowing her movements somewhat to draw out your anticipation, and you feel yourself becoming aroused, your member stiffening even before you've seen so much as the skin on her shoulders. With the last button above her waist undone, she slowly, deliberately opens the front to reveal her frilly white bra, which matches her headband, stockings, and apron perfectly. Then she pulls one arm, then the other, through the arms of her black dress and lets it fall back, supported also by the waist strap of her apron. Finally, she undoes the clasp at the front of her bra and opens it, slipping it over her shoulders and letting her modest, cream-skinned breasts spill out; pert and firm, with adorable pink nipples and just the right amount of jiggle. You find yourself unable to hold back anymore and rush her, kissing her and fondling her perfect breasts in your hands - they're just the right size." +
					"She squeaks in surprise at your sudden attack, stiffening for a moment but then quickly relaxing, placing her arms around your hips and leaning back to let you have your fun." +
					" She returns your kiss, opening her mouth slightly to invite your tongue, which you happily provide, and after a brief moment of passionate kissing, with her gasping every so often directly into your mouth as your hands massage her sensitive mounds, she breaks off and gazes lovingly at you. " +
					"\"<i>Mmmmmhmhm... goodness gracious, " + player.mf("Master","Mistress") + ",</i>\"" +
					" she says affectionately, " +
					"\"<i>aren't you eager today? You make your cute little maid feel so loved; I'll have to give you extra service today as thanks.</i>\"\n\n" +
					"She gently pulls your hands away from her twins and leads you to the rush mat, where she guides you down until you are laying on it, face-up. She then kneels, straddling your legs and covering them with her dress. She smiles and begins softly massaging your thighs and hips for a moment, loosening your muscles and joints, making you sigh in relaxation." +
					" Then, once you are thorougly comfortable, she bends down and begins gently stroking your member with her hands for a moment to bring it back to full mast before she takes a deep breath and takes it in her mouth, almost to the hilt right away. The shock of pleasure makes you buck your hips involuntarily, but Luna gently presses down on your hips to hold them in place as she moves her head up and down on your shaft, soaking it thorougly with her saliva and your own freely flowing pre-cum." +
					"You're ready to give up on your original plan and just let it become a blowjob when she suddenly stops. Opening her mouth she lifts her head off your throbbing cock, leaving it sopping wet with saliva and your own juices, and then, after wiping her mouth with the back of her hand, she leans just a bit further forward and sandwiches your length between her breasts, pressing in on them with her hands to squeeze it beautifully in the soft flesh of her chest." +
					" Then she begins moving her torso and her hands in tandem to stroke your full length with them, up and down, slowly at first but increasing in speed and pressure over the next moment, until your hips once more begin bucking up as your lower half seeks increased pleasure on its own, driven purely by nervous instinct. Your breaths begin to come hot and heavy as the pleasure overwhelms your senses.\n\n" +
					"\"<i>Are you enjoying my breasts, " + player.mf("Master","Mistress") + "? Your cute maid's breasts are exposed and squished together around your cock... how disgraceful. Such a lewd maid must be disciplined, no matter how sweet and adorable she is, don't you agree, " + player.mf("Master","Mistress") + "?</i>\"" +
					" As Luna begins her dirty talk she suddenly varies her movements; now moving her breasts out of sync, up and down alternately. The sensation is completely different; where her breasts were a soft, tight sleeve for your cock a moment ago now you very acutely feel the texture of her skin as it exerts an almost shearing sensation across your member. Enhancing this feeling is the fact that the saliva formerly lubricating you is becoming sticky, causing the skin on her breasts to catch and pull at your cock in places here and there as she slides up and down.\n\n" +
					"Before you can properly respond with anything besides a pleasured moan at the redoubled stimulation she suddenly continues her monologue. " +
					"\"<i>I know just how you can punish your naughty, slutty maid, " + player.mf("Master","Mistress") + "</i>\"" +
					", she says, lowering her voice to a sultry contralto as she leans forward even further, her breath hot against your chest and your cock dragged mercilessly forward against your abdomen as the sticky orbs trapping it shift. Over your own ragged breaths you can feel her voice resonating in your chest as she continues speaking. " +
					"\"<i>You should spray her right in the face, just like a bad dog caught with its nose in the pantry, " + player.mf("Master","Mistress") + ". Spray her good, so she knows she's been naughty, until she can't even breathe or see.</i>\"\n\n" +
					"With that she suddenly rears back up and, smiling dangriously, begins pumping her breasts up and down furiously, bringing your bubbling orgasm almost immediately to a head. You buck your hips up and scream as the pleasure hits you all at once, spraying Luna directly in the face with");
			if (player.cumQ() <= 500) outputText(" ropes of white, sticky cum that cling to her face and hair as she laughs playfully, gently milking you for all you have with her breasts until you are spent and panting.\n\n");
			else if (player.cumQ() <=1000) outputText(" thick spurts of thick cum that paint her entire face white and change her playful laughing into sputters; by the time she has finished gently but firmly milking you dry with her breasts it is dripping from her chin and eyelashes and onto your still heaving chest as you pant and moan in spent pleasure.\n\n");
			else if (player.cumQ() <= 2000) outputText(" a near-constant spray of cum shooting fast and hard from your spasming member, painting her face, hair, chest, into a white, sticky mess. She barely has time to laugh playfully before her face is too covered in your seed to breathe properly, and even as she coughs and sputters you keep coming while she dutifully milks you dry with her breasts, now freshly lubricated along with everything else. Finally your enormous orgasm ceases, and your body goes slack with relaxed pleasure.\n\n");
			else outputText(" a deluge of cum; almost immediately you and she are drenched in seed, your spasming cock spewing a roiling, foamy geyser almost as if she had shaken a beer barrel and pulled out the tap. Screaming in your crazed pleasure you cum, and cum, and cum, until you are laying in a pool of your issue and Luna is completely drenched from head to toe, coughing and sputtering as she tries to catch her breath. Even so, she dutifully milks you with her breasts until nothing more than a trickle remains and your taut muscles come unstrung, leaving you utterly spent and unable to move.\n\n");
			outputText("Luna gives you a moment to catch your breath, and to wipe off enough of her face to see and speak clearly, then says \"<i>My goodness, " + player.mf("Master","Mistress") + ", that was some <b>incredible</b> discipline. I am thoroughly chastened, and I promise you I won't misbehave again.</i>\" She stands up and bows, your seed still dripping off her in places, her breasts still glistening and sticky with your and her fluids, and turns to go clean herself off in the river. Just as she does, though, she turns back and adds, \"<i>Until you ask me to, of course.</i>\" Then she winks, disappears behind a nearby boulder. You remain laying for a moment to catch your breath and give your muscles time to regain their strength before you rise and follow to do the same, extremely happy you decided to act on your whim. An hour or so later you are clean and refreshed, ready to continue your day.");
			lunaJealousy(-100);
			lunaAffection(2);
			player.sexReward("Default", "Default",true,false);
			doNext(camp.returnToCampUseOneHour);
		}
		/*
		public function sexMenuDoggyTreats():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You walk straight up to Luna and, gently but firmly, place your hands on her shoulders to turn her around and push her down into a kneeling position, telling her that what you want isn't your cute maid Luna, but your horny, wet bitch Luna. She gasps in surprise, and then, in a voice more delighted than any you've heard from her in quite some time she replies \"<i>Oh, yes, <b>yes</b> " + player.mf("Master","Mistress") + ", please!</i>\"\n\n");
			outputText("Without another word she begins stripping, hastily and roughly, without bothering to turn around or even stand back up. At first you take the opportunity to");
			if !player.IsNaked() outputText(" expose your own lower half and");
			outputText(" begin stroking your already half-erect member");
			if player.cocks.length > 1 outputText("s");
			outputText(", enjoying the artless strip show Luna puts on for you. She undoes her apron straps and tosses it aside, then hastily pulls her dress over her head without bothering with buttons. That gone, she fumbles with the clasp on the front of her frilly white bra while her hips, covered in their cute white panties, visibly squirm in anticipation. You can already see a trickle running down her thighs. As she tosses her bra on top of the rest of her garments she looks back at you, not with a sultry grin but a look of anxious need, and when she sees your meaty pole");
			if player.cocks.length > 1 outputText("s");
			outputText(" already exposed she smiles excitedly, and her crazed eyes begin glowing a familiar, phosphorescent green as her lust begins to boil over. \"<i>Oh no,</i>\" she says, \"<i>I'm already tranforming... need to get the rest off before- EEEEEEEP!</i>\" She cuts her muttering off with a surprised, horny shriek as you take the initiative by grabbing her legs, in their cute white stockings, just above the ankles and pulling them from under her, causing her to pitch forward and catch herself on her hands. You quickly peel the stockings off for her, taking the opportunity to shift yourself closer to her palpably warm crotch in the process. Already fur is sprouting from her legs and arms.\n\n");
			outputText("\"<i>Ahhh... nnnhhh... haa... h-hurry, " + player.mf("Master","Mistress") + ", I... I'm almost... I don't ha-have many spare pantiEEEEEEEEEE-</i>\" Again she cuts off in a horny scream as you kneel between her legs and grab the sides of her panties to yank them down her hips, which are already visibly swelling from her transformation. She lifts her rear off the ground to ease your task, and as you yank them down you see a string of clear, slimy drool stretch between them and her dripping snatch, thick and drooping until it finally snaps and splashes in drops to the ground to join the trickles already running down her thighs and pubis. The hot, musky smell of a bitch in heat causes a nearly crazed reaction in your body - your cock");
			if player.cocks.length > 1 outputText("s are");
			else outputText(" is");
			outputText(" now screamingly hard and your vision goes pink at the edges. You finish pulling her panties off one leg, noting that her foot is already warping into a heavy lupine paw, and decide that will have to be enough - because it's time to bury your face in Luna's steaming, wet pussy and ass and help speed her transformation along. You begin lapping, sucking, and nibbling voraciously at her dripping snatch, burying your face between her swelling cheeks and breathing in her sex-drenched, animalistic smell as she screams and thrashes in your grip. You're holding her ass up to your face by her hips, with her legs flailing ecstatically beside your head and her arms desperately trying to hold her face above the ground as you eat her out during her werewolf transformation.\n\n");
			outputText("You feel a fuzzy protrusion press out against your forehead and realize her tail is growing in. Just as it does, Luna starts screaming. \"<i>HaaaaaaAAAA... haaaaaaaa... aaaaaaaaHHHNNNNMMmmmmmmmmohhhh god oh oh god oh GODS [name]... this is... I can't... I'm cummaaaAAAAAAAAAAAOOOOOOOOOOOOOOOOOO!</i>\" Luna's words fail a third time and she howls bestially under your furious assault. You know from experience her transformation already inflicts corrupted, orgasmic pleasure on her body, and just as it peaks your own famished, greedy lapping at her flooded pussy brings her to a more natural one. She spasms violently; her thighs squeeze and slam against the side of your head , and her pussy sprays your face with enough liquid to fill your waterskin. Then she faceplants into the ground as her arms give out from under her. You hold her hips down to your kneeling thighs while she thrashes in her mindless ecstasy, afraid she might actually hurt one of you, and her climax lasts a good ten seconds before she finally goes limp.");
			outputText("She is fully lupine now. Ashen fur covers her arms and legs, fading to a lighter fuzz over the rest of her curvy butt and hips, her melon-sized breasts, and her tight, muscular stomach. Her frilly headband, forgotten in your sudden attack, still sits absurdly behind her lupine ears over her now ruined hair, and her white panties are still wrapped around one of her back paws like a lewd, cum-soaked anklet. You gently massage her hips and rear as she gasps and moans, and occasionally twitches again with a small aftershock after the earth-shattering orgasm you just inflicted on her. Finally with a heaving groan she manages to get back on her hands and knees, albeit shakily. \"<i>Haaaa... haaaa... [name], you're even more of a beast than <b>I</b> am... haaaaaa.... that was <b>incredible</b>.</i>\" she gasps out in a lusty moan between panting, ragged breaths.\n\n");
			outputText("Smiling deviously you give her a couple hard slaps on the ass just beside where her tail emerges, eliciting a satisfying <i>yip</i> from your already well-fucked bitch. You remind her sternly to call you " + player.mf("Master","Mistress") + ", as she has forgotten to do twice now. Then you tell her you're happy she's enjoying herself, because you're <b>just getting started</b>. As soon as you scold her she begins making quiet whining sounds, and she submissively lowers her front half to the ground until her pillowy breasts are squished into the grass. Her rear is still sticking up at you. Despite her dejected posture and tone, however, you can clearly see she her wolf-cunt drooling even harder than before. Her clit sticks out a good half-inch from her folds, which are splayed open and puffy, revealing her wet depths visibly throbbing and squeezing, begging for her " + player.mf("Master","Mistress") + "'s rod inside it. She wriggles her behind at you, her tail curled saucily over her back, in as clear a 'come hither' as you've ever seen, and you're more than ready to oblige...\n\n");
			
			doNext(sexMenuDoggyTreats2);
		}
		*/
		public function sexMenuDoggyTreats():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You walk straight up to Luna and, gently but firmly, place your hands on her shoulders to turn her around and push her down into a kneeling position, telling her that what you want isn't your cute maid Luna, but your horny, wet bitch Luna. She gasps in surprise, and then, in a voice more delighted than any you've heard from her in quite some time she replies " +
					"\"<i>Oh, yes, <b>yes</b> " + player.mf("Master","Mistress") + ", please!</i>\"\n\n" +
					"Without another word she begins stripping, hastily and roughly, without bothering to turn around or even stand back up. At first you take the opportunity to");
			if (!player.isNaked()) outputText(" expose your own lower half and");
			if (player.hasCock()) {
				outputText(" begin stroking your already half-erect member");
				if (player.cocks.length > 1) outputText("s");
				if (player.hasVagina()) outputText(" and");
				}
			if (player.hasVagina()) outputText(" fingering your increasingly wet pussy");
			outputText(", enjoying the artless strip show Luna puts on for you. She undoes her apron straps and tosses it aside, then hastily pulls her dress over her head without bothering with buttons. That gone, she fumbles with the clasp on the front of her frilly white bra while her hips, covered in their cute white panties, visibly squirm in anticipation. You can already see a trickle running down her thighs. As she tosses her bra on top of the rest of her garments she looks back at you, not with a sultry grin but a look of anxious need, and when she sees your meaty pole");
			if (player.cocks.length > 1) outputText("s");
			outputText(" already exposed she smiles excitedly, and her crazed eyes begin glowing a familiar, phosphorescent green as her lust begins to boil over. " +
					"\"<i>Oh no,</i>\"" +
					" she says, " +
					"\"<i>I'm already tranforming... need to get the rest off before- EEEEEEEP!</i>\"" +
					" She cuts her muttering off with a surprised, horny shriek as you take the initiative by grabbing her legs, in their cute white stockings, just above the ankles and pulling them from under her, causing her to pitch forward and catch herself on her hands. You quickly peel the stockings off for her, taking the opportunity to shift yourself closer to her palpably warm crotch in the process. Already fur is sprouting from her legs and arms.\n\n" +
					"\"<i>Ahhh... nnnhhh... haa... h-hurry, " + player.mf("Master", "Mistress") + ", I... I'm almost... I don't ha-have many spare pantiEEEEEEEEEE-</i>\"" +
					" Again she cuts off in a horny scream as you kneel between her legs and grab the sides of her panties to yank them down her hips, which are already visibly swelling from her transformation. She lifts her rear off the ground to ease your task, and as you yank them down you see a string of clear, slimy drool stretch between them and her dripping snatch, thick and drooping until it finally snaps and splashes in drops to the ground to join the trickles already running down her thighs and pubis. The hot, musky smell of a bitch in heat causes a nearly crazed reaction in your body - ");
			if (player.hasCock()) {
				outputText("your cock");
				if (player.cocks.length > 1) outputText("s are");
				else outputText(" is");
				outputText(" now screamingly hard, ");
			}
			if (player.hasVagina()) outputText("your pussy is dripping down your thighs in anticipation, ");
			outputText("and your vision is pink at the edges. You finish pulling her panties off one leg, noting that her foot is already warping into a heavy lupine paw, and decide that will have to be enough - because it's time to bury your face in Luna's steaming, wet pussy and ass and help speed her transformation along. You begin lapping, sucking, and nibbling voraciously at her dripping snatch, burying your face between her swelling cheeks and breathing in her sex - drenched, animalistic smell as she screams and thrashes in your grip. You're holding her ass up to your face by her hips, with her legs flailing ecstatically beside your head and her arms desperately trying to hold her face above the ground as you eat her out during her werewolf transformation.\n\n" +
					"You feel a fuzzy protrusion press out against your forehead and realize her tail is growing in. Just as it does, Luna starts screaming. " +
					"\"<i>HaaaaaaAAAA... haaaaaaaa... aaaaaaaaHHHNNNNMMmmmmmmmmohhhh god oh oh god oh GODS [name]... this is... I can't... I'm cummaaaAAAAAAAAAAAOOOOOOOOOOOOOOOOOO!</i>\"" +
					" Luna's words fail a third time and she howls bestially under your furious assault. You know from experience her transformation already inflicts corrupted, orgasmic pleasure on her body, and just as it peaks your own famished, greedy lapping at her flooded pussy brings her to a more natural one. She spasms violently; her thighs squeeze and slam against the side of your head , and her pussy sprays your face with enough liquid to fill your waterskin. Then she faceplants into the ground as her arms give out from under her. You hold her hips down to your kneeling thighs while she thrashes in her mindless ecstasy, afraid she might actually hurt one of you, and her climax lasts a good ten seconds before she finally goes limp.\n\n" +
					"She is fully lupine now. Ashen fur covers her arms and legs, fading to a lighter fuzz over the rest of her curvy butt and hips, her melon-sized breasts, and her tight, muscular stomach. Her frilly headband, forgotten in your sudden attack, still sits absurdly behind her lupine ears over her now ruined hair, and her white panties are still wrapped around one of her back paws like a lewd, cum-soaked anklet. You gently massage her hips and rear as she gasps and moans, and occasionally twitches again with a small aftershock after the earth-shattering orgasm you just inflicted on her. Finally with a heaving groan she manages to get back on her hands and knees, albeit shakily. " +
					"\"<i>Haaaa... haaaa... [name], you're even more of a beast than <b>I</b> am... haaaaaa.... that was <b>incredible</b>.</i>\"" +
					" she gasps out in a lusty moan between panting, ragged breaths.\n\n" +
					"Smiling deviously you give her a couple hard slaps on the ass just beside where her tail emerges, eliciting a satisfying <i>yip</i> from your already well-fucked bitch. You remind her sternly to call you " + player.mf("Master","Mistress") + ", as she has forgotten to do twice now. Then you tell her you're happy she's enjoying herself, because you're <b>just getting started</b>." +
					" As soon as you scold her she begins making quiet whining sounds, and she submissively lowers her front half to the ground until her pillowy breasts are squished into the grass. Her rear is still sticking up at you. Despite her dejected posture and tone, however, you can clearly see she her wolf-cunt drooling even harder than before. Her clit sticks out a good half-inch from her folds, which are splayed open and puffy, revealing her wet depths visibly throbbing and squeezing, begging for her " + player.mf("Master","Mistress") + "'s rod inside it. She wriggles her behind at you, her tail curled saucily over her back, in as clear a 'come hither' as you've ever seen, and you're more than ready to oblige...\n\n");
			menu();
			addButtonDisabled(0, "Cuddle", "That's a good joke, you think to yourself, dismissing the idea the instant it occurs to you.");
			addButton(1, "Dominate", sexMenuDominateHer).hint("Take your bitch as rough as you want until you've had enough. It'll do her good.");
			if (player.hasCock()) addButton(2, "Surprise", sexMenuDoggyTreats2).hint("You're feeling a little saucy, and Luna's asshole looks too tempting to pass up.");
			else addButtonDisabled(2, "Surprise", "As tempting as Luna's ass looks, you're going to need a cock to take advantage of it.");
			addButtonDisabled(3, "Press Luck", "NYI - Scary Dragon Mom hasn't written the scene yet! Get on her!" );
			addButtonDisabled(14, "Back", "You know perfectly well you're not getting out of this now.");
		}
		public function sexMenuDoggyTreats2():void {
			clearOutput();
			outputText("\"<i>Aiyeeeee?!?</i>\n\n" +
					"...but on <b>your</b> terms, you think to yourself gleefully, as you thrust one of your already well-lubricated thumbs into her tight, muscular anus instead, twisting and working it about to loosen her puckered sphincter as you bring your hips closer to hers.\n\n" +
					"\"<i>" + player.mf("M-m-m-master...","M-m-m-mistress...") + " w-what are youUUUhhhhhhhnnnnnnnn...</i>\"" +
					" Refusing to allow her to get her bearings, you begin running the length of your throbbing, aching cock");
			if (player.cocks.length > 1) outputText("s");
			outputText(" between the swollen lips of her pussy, teasing her clitoris and thoroughly coating you in her slick juices. She moans in the mixed pleasure of your two actions while you thrust and finger for a moment, then, deciding that you've prepared the two of you enough, you inform her that your bitch won't be pleasuring you with her pussy today; what if you accidentally pumped her full of puppies? A fresh gush of drool rushes from her sex at the mere mention of impregnation even while she whines in protest at your denial, but she quickly stops her bitching, holding her breath in anticipation as you lean back and line the tip of your");
			if (player.cocks.length > 1) outputText(" lower member with her fleshy, round anus while your upper one presses its way between her soft, fluffy cheeks under her tail.");
			else outputText(" member with her fleshy, round anus.");
			outputText(" Then, all at once, you hilt yourself in Luna's asshole, causing both of you to squeal at the rough, intense stimulation. Her ridged, muscular insides squeeze you so tightly it feels like she's going to cut off your circulation. If she hadn't involuntarily offered you so much of her natural lubricant you're sure her walls would've taken some of your skin off as you went in, they're so tight. She spasms, her abdomen instinctively trying to force you back out of her but succeeding only in massaging your throbbing pole");
			if (player.cocks.length > 1) outputText("s with both her clenching, shuddering cheeks and rhythmically squeezing colon.\n\n");
			else outputText(" with her rhythmic squeezing.\n\n");
			outputText("For a moment you enjoy the sensations, then begin thrusting in and out, slowly at first to tame and relax her unruly, spasming muscles, then faster and faster. Soon her asshole is loose enough for you to thrust yourself tip to root over and over as you piston-bang her ass. Luna quickly becomes a moaning, drooling mess. Her face lays slack against the ground and her long, canine tongue lolls out freely as she yips and moans insensately." +
					" One of her arms has found its way to her pussy, and she is stimulating herself there as you ram into her backside again and again. You can feel her clench into little orgasms several times as she brainlessly mewls and whimpers under your assault." +
					"Your own pleasure mounts as well, and a powerful orgasm starts moving through your hips. Her ass has loosened, but it's not <b>that</b> loose; you're pretty sure she could crack an imp in half with her hip and thigh muscles and they haven't yet gone limp with her rectum, instead treating your length to soft, pulsing squeezes as you press your sensitive places against the ridges and folds of her nethers.");
			if (player.cocks.length > 1) outputText(" By contrast, your other member is receiving a wonderful massage from her fluffy buttocks, soft and round but with a core of iron-hard muscle. Every time you hilt your lower member in her rear your upper one gets flexed backward against her crevasse, and your sensitive tip brushes the stiff hairs at the base of her tail. The sensation is both comfortable and ticklish by turns, and you find yourself twitching in overstimulation. Your upper cock drools enough precum now to replace the lubricant you've already lost to the soft fur of her ass, and the base of her tail is a sodden mess.\n\n");
			outputText("\n\nLuna begins moaning louder, your attacks on her rear working with her desperate self-pleasuring to bring her to another massive climax. Feeling your own peak approaching you decide to match hers, and start fucking her in earnest, letting your own gasping moans join hers as you pump faster and faster toward your own release. Finally, you both scream as you hilt yourself inside her and the two of you cum hard together. ");
			if (player.cumQ() <= 500) {
				outputText("You fire off several thick ropes of cum into her greedy hole, which clamps down on you so hard it almost denies your orgasm. Your cock burns with the effort of pushing its load into her against the resistance until your shuddering release ends.");
				if (player.cocks.length > 1) outputText(" Meanwhile, your other cock fires jets of cum onto her tail and back, leaving sticky white trails along her gray fur that glisten as she writhes under you.");
			}
			else if (player.cumQ() <= 1000) {
				outputText("You fire a big load into her greedy hole, which clamps down on you so hard it nearly denies your orgasm. Your cock burns with the effort of pushing your release into her against the resistance, and by the end you feel backsplash against your tip as her guts try to force your seed back out.");
				if (player.cocks.length > 1) outputText(" Meanwhile, your other cock fires messily onto her tail and back, painting it with jagged streaks and splotches of glistening white against her gray fur while she thrashes in the throes of her own ecstasy.");
			}
			else if (player.cumQ() <= 2000) {
				outputText("You hose her insides with seed; as hard as she clamps down on you in the middle of her own orgasm it isn't enough to stop the coming flood, and your own meat is sandwiched between the pressure of your pumping and her squeezing, prolonging the orgasm until her belly is visibly swollen with cum.");
				if (player.cocks.length > 1) outputText(" Meanwhile, your other cock explodes into the air, held upright by her tight cheeks, and the thick spurts that rocket several feet into the air with the force of your pleasure land on her back, tail, and head, as well as on you and the surrounding area. Before long you are both well painted with your cum.");
			}
			else {
				outputText("A flood of cum explodes from your cock; her abdominal muscles, spasming from her own orgasm, are utterly helpless to stop the deluge, and her belly swells and distends with your seed until it can't anymore, and cum spurts out in little sprays here and there as the pressure overcomes the force of her contraction. You hear her choke a little in front of you as some of it washes through her system into her throat.");
				if (player.cocks.length > 1) outputText("Meanwhile, your other cock imitates a perverted fountain, framed and held upright by her sculpted cheeks. Cum geysers up nearly six feet in the air to fall back down in messy splatters all over her, you, and the surrounding several feet, until you are both sitting in a pool of cum.");
			}
			outputText(" You collapse forward onto Luna and the two of you become a gasping, moaning tangle of limbs and mingled fluids. After a moment you pull your flagging length out from her, prompting a wet sound and");
			if (player.cumQ() <= 1000) outputText(" a dribble of your seed from her gaping, distended ring.");
			else outputText("a spout of cum from her gaping, distended ring as her insides resume their proper shape and size, forcing it out in pulsing spurts." +
					" It also seems that you have fucked the curse out of your maid, at least for the moment. She begins shrinking, her hips and bust returning to their normal, demure proportions as her fur, ears, and tail shrink back into her. You lay on top of her for a few seconds longer and then shift to the side, rolling her back to you into a loving embrace.\n\n" +
					"\"<i>Ah? " + player.mf("M-master,","M-mistress,") + " I should-</i>\"" +
					" she begins to say in protest, but you shush her gently and tell her that she's more than just a servant to you, and you'll pamper her if you please. You pet her head softly for a few seconds, thanking her and telling her she did an amazing job helping you with your needs, and after a moment of stiffness you feel her relax into you. " +
					"\"<i>I... I'm glad, " + player.mf("Master","Mistress") + ". Thank you.</i>\"" +
					" She giggles tiredly and settles her smooth back against your chest. Soon you feel her breaths soften and even out into relaxed, peaceful sleep. Her warmth and softness soon lulls you into a light sleep as well, and as you drift off you hear her muttering something softly.\n\n" +
					"\"<i>...love... you...</i>\"\n\n" +
					"You awaken about an hour later, alone. Luna has placed a soft pillow under your head and a blanket over your torso");
			if (!player.isNaked()) outputText(", and you see your equipment neatly folded and piled a few feet away");
			outputText(". Rising stiffly, you yawn and stretch, and head to the river to clean off and prepare for whatever the day brings next.");
			lunaJealousy(-100);
			lunaAffection(2);
			player.sexReward("Default", "Default",true,false);
			doNext(camp.returnToCampUseOneHour);
		}
		public function sexMenuSandwichWithAyane():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("As you mull over your options. Ayane comes over to do her report and stare at you both with wide eyes.\n\n" +
					"\"<i>No way! You’re going to reward the mutt over your devoted priestess? I will have none of that! Luna, I challenge you to a duel to see who makes [name] cum first!</i>\"\n\n" +
					"Luna gives her a playful grin in response. " +
					"\"<i>Challenge accepted, but you cannot hope to win against my spear polishing techniques!</i>\"\n\n" +
					"Ayane crosses her arms under her breast. \"<i>Do not underestimate the talents of the kitsunes, we have been at it since Taoth created us! I’m going to fill my belly full of that meal.</i>\"\n\n" +
					"Whoa, since when did these two get so competitive?! You decide the best way to stop their argument is to order them both to pleasure your [cock] at the same time.\n\n" +
					"They both turn over at the same time yelling " +
					"\"<i>Can do!</i>\"" +
					" before throwing off their clothes in one swift motion and getting into position; Ayane under and Luna on top, their pussy and ass aligned together to perfectly sandwich your prick between them. Well now this is a hole you cannot refuse! Your [cock] hardens at the prospect of fucking this new hole just as you finish undressing. While you were busy, you didn’t notice the pair drooling in anticipation of your incoming pole" + (player.cocks.length == 1 ? "" : "s") + ". Foxes and wolves, you guess they're all canid after all. " +
					"You start to slide your tool" + (player.cocks.length == 1 ? "" : "s") + " between their waiting holes, their joined pussies having done an excellent job of lubricating the whole thing; the two of them moaning as your " + (player.cocks.length == 1 ? "cock grinds" : "cocks grind") + " on their puffed up vaginal flesh. ");
			if (player.cocks.length == 1) outputText("You pump your cock in and out of the duo. Sometime sliding in either hole before coming back in between. ");
			if (player.cocks.length == 2 || player.cocks.length == 3) outputText("Why fuck only one girl when you can fuck both! Having more than one penis has its advantages and you gladly insert yourself into their two well aligned pussies, fucking Ayane and Luna at the same time. ");
			if (player.cocks.length >= 4) outputText("Why fuck only one girl when you can fuck both! Having more than one penis has its advantages and you gladly insert yourself into their two well aligned pussies, fucking Ayane and Luna at the same time. That said, you got enough cocks to fill their ass too, and gladly insert yourself in their waiting holes. Luna howls with delight as you break past her pucker. ");
			outputText("The pair, already lost between heaven and hells, lock into a passionate kiss as both of their pussy lips hug and mold around your cock" + (player.cocks.length == 1 ? "" : "s") + " like attention starved animals. Ayane uses her body to its full extent, moving her tail to leave trails of blue fire on your ");
			if (player.balls > 0) outputText("balls which only cause them to churn with a massive supply of cum; this is going to be one hell of a mess!");
			else outputText("sensitive skin.");
			outputText(" Luna’s own tail is out and is busy circling your anal ring with its tip which only drives you crazier.\n\n" +
					"Their combined affection and skill eventually make short work of your restraint; " + (player.cocks.length > 1 ? "you pull out of their holes, " : "") + "cum flowing " + (player.balls > 0 ? "out of your balls and " : "") + "through your [cock], splattering the space between them up to their combined breasts with a massive load of semen. Fully satisfied, the pair lick their lips as they untangle from your cock, a large puddle forming on the ground. " +
					"They head for the spring to clean themselves giving you a pair of playful winks before leaving you to rest. Well, now that you think of it, they both won and you lost. But who cares; what a good time you had!\n\n" +
					"You decide to take a nap to recover some energy. A few hour later, you wake up ready to resume adventuring.\n\n");
			lunaJealousy(-100);
			lunaAffection(2);
			player.sexReward("Default", "Default",true,false);
			doNext(camp.returnToCampUseOneHour);
		}

		public function sexMenuDominateHerIntro():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			outputText("You ask the maid how she feels about giving in to her beastly desire. The green glimmer in her eyes is all you need to see how much she desires it before she begins to shapeshift into her beast form.\n\n");
			flags[kFLAGS.LUNA_MOONING] = 1;
			doNext(sexMenuDominateHer);
		}
		public function sexMenuDominateHer():void {
			clearOutput();
			//if player.werewolfScore() > 6 || player.wolfScore > 6 || player.dogScore > 6 {
				//planned special variant scenes for you giving in completely to your bestial nature as you breed her like an animal, with variations for knotting or lesbian sex with enlarged clitoris should player possess either
			//}
			spriteSelect(SpriteDb.s_Luna_Mooning);
			if (player.hasCock()) {
				if (player.cocks.length > 1) {
					outputText("Not one to pass up such a pleasing offer, you waste no time. Grabbing Luna's hips roughly you pull her back toward you and shove your cocks between her thighs, running them back and forth across her dripping slit until they are thorougly coated in her slippery juice. As she moans shamelessly at the feel of your lengths stroking her drooling lower lips and clit, you take one of your already well-lubricated thumbs and jam it in her ass to start loosening it up; she yips in surprise but makes no effor to pull back; she's already far too gone to resist whatever you have in store for her. Once you're lubricated and she's loosened, you carefully line yourself up with both of her holes and thrust in all at once.\n\n" +
							"Both of you howl at the sudden onrush of stimulation, and Luna screams " +
							"\"<i>AAAAAAAOOOOOOOOOOOOOHH! " + player.mf("Master","Mistress") + ", yes, yes! This is true mating! Take me, " + player.mf("Master","Mistress") + ", pound my holes until I can't see straight! Fuck your dirty bitch into the ground!</i>\"" +
							" Her dirty talk electrifies you into motion and you begin mercilessly pounding her two greedy holes, your hips slamming roughly into her ass every time you hilt her, fluids splashing wetly from her sopping pussy every time you pull out. Almost immediately Luna orgasms again, spasming and falling to the ground in front of you once more." +
							" Only your hands are holding her hips up as you continue to piston into her; her torso rocks back and forth on the soft flesh of her breasts and her head lays helplessly on the ground, her long, canine tongue lolled out brainlessly as it drags. The only sound she makes now is a sort of loose \"<i>arp</i>\" that comes out each time your hips slam into her cusiony ass, faster and faster as you seek to increase your own pleasure.\n\n" +
							"Luna's pussy is wet and tight, and the little bumps and folds are exquisitely rubbing against your lower cock. Meanwhile her asshole is so tight it feels like it's nearly cutting off your circulation, and the ridged surface stimulates your sensitive places so strongly it's nearly painful. You keep it up for a moment until you feel an orgasm just beginning to approach, then slow your movements, looking to prolong your enjoyment. Finally, with a wet sucking noise you pull your throbbing members free of Luna's gaping holes. " +
							"\"<i>Aaahhhhhhhhhaaahhhhhhhnnnnnnnn...eeeep!?</i>\"" +
							" Luna moans insensately at first, then yips in confusion as you suddenly flip her over onto her back, having decided you want a full view of her before you pump her full of cum. Her legs splay out in front of her, giving you a spectacular view of her two pulsing, squeezing orifices begging you to reinsert." +
							"Luna pants and moans as you run your cocks across her pussy once more, but you lean over her and cut off her ragged breaths with a fierce, sucking kiss, to which she responds by pressing her tongue into your mouth for you to suck and nibble on. This goes on for a moment until you've adequately lubricated yourself again and Luna is gasping for air against you; then you raise yourself back up, giving her breasts a good squeeze in the process as she yelps again in pleasure." +
							"Once more you line up your cocks with her two holes and thrust in, far more easily this time. The sensations are reversed from before; her gripping, pulsating asshole now massages your lower cock while her drenched, spasming pussy wraps itself around your upper cock. You can see her breasts jiggling up and down as you pound her now, the sight adding a nice visual punctuation to each thrust. Her face is completely slack; her eyes are rolled up into her head and her tongue is flopping against her cheeks. Every now and then you feel her cum again, a little spasm running through her otherwise limp body. You've lost count of how many times it's happened. Meanwhile your own pleasure begins peaking again, and you start thrusting faster again. The increased speed and sensation pulls Luna out of her daze just enough to say " +
							"\"<i>Haaa... haaa... " + player.mf("M-master","M-mistress") + "...  p-please...</i>");
					if (player.hasKnot()) outputText("<i>knot me... please... I need it... I need to feel you filling me up...</i>\"");
					else outputText("<i>cum inside me... please... I need it... I need to feel you filling me up...</i>\"");
					outputText("You grin maliciously and suddenly even out your pace, causing your orgasm to plateau momentarily. Luna whines as she realizes you're teasing her, but you tell her that she can't tell you what to do; a horny bitch doesn't get");
					if (player.hasKnot()) outputText(" knotted");
					else outputText(" filled");
					outputText(" until she begs for it. Tears in her eyes, Luna pleads with you even more desperately. \"<i>" + player.mf("Master","Misterss") + ", please, I'm begging you, please</i>");
					if (player.hasKnot()) outputText("<i> knot</i>");
					else outputText("<i> cum inside</i>");
					outputText("<i> your horny, needy bitch, " + player.mf("Master","Mistress") + "... </i>");
					if (player.hasKnot()) outputText("<i>lock me and </i>");
					outputText("<i>fill me with your seed, I beg you, fill me up until I'm pregnant with your puppies... please, " + player.mf("Master","Mistress") + ", I need your puppies... I want to give you puppies... please please please please please...</i>\"" +
							" You have no idea how serious she is about that, but you figure it's good enough, and as she devolves into mindlessly repeating the word 'please' you grab her thighs and press them against her chest, speeding up once more, thrusting yourself furiously into her until she begins moaning and gasping with an approaching climax of her own." +
							"You reach your climaxes together. After minutes of moaning and panting brainlessly, too dazed even to react to the numerous orgasms she's had, Luna suddenly begins gasping and screaming the same way she did when you gave her her first one of the day, then begins spasming almost epileptically as the pleasure overwhelms her already pleasure-fried brain one time too many. The sensation of her holes squeezing and pulsing as she cums is just enough to push you over the edge as well, and with a bestial grunt you hilt yourself one last time into her and release.");
					if (player.hasKnot()) outputText(" Your knot swells to its full size, locking you in place until nature has run its course; not that you had any plans of pulling out anyway.");
					if (player.cumQ() <= 500) outputText(" Your two cocks begin spurting thick ropes of cum into Luna's pussy and ass. She gives a ragged cry of relief, as if you had doused a fire inside her with your fluids; then, your passion spent, ");
					else if (player.cumQ() <= 1000) outputText(" Your two cocks begin pouring cum inside Luna's pussy and ass, quickly filling them until you can feel the warm liquid splashing back against your tips as it seeks another way out. Luna gives out a ragged cry of relief, as if you had doused a fire inside her with your plentiful fluids. By the time your ejaculation is finished there are little drizzles of cum running back down your shafts; then, your passion spent, ");
					else if (player.cumQ()<= 2000) outputText(" Your two cocks begin spraying enormous amounts of cum into Luna's greedy holes; almost immediately her colon and womb have taken all they can take and begin resisting further intrusion. But her pussy and asshole are clamped down too tightly on you to allow full relief of the pressure, and as you continue to cum inside her her belly swells until she looks almost pregnant. Despite the obvious discomfort of being filled past capacity Luna gives a ragged cry of relief, as if your inhuman ejaculation had put out a fire that was raging inside her; then, your passion spent, ");
					else outputText(" Your two cocks begin hosing her insides with cum at inhuman velocity; almost immediately she begins swelling up, unable to contain your issue without stretching her guts and womb. In a moment she looks like she has a belly full of puppies already, and the sprays of cum leaking out around your two shafts are nowhere near enough to offset the copious amounts you continue to pump into her as your intense orgasm continues. She cries out in a mix of pain and relief, as if you had doused a fire inside her with your fluids only to replace the crisis with a flood - her voice begins to gurgle slightly as your liquid washes back into her throat, her stomach no longer able to contain it. Finally your orgasm subsides and, your passion spent, ");
					outputText("you collapse on top of Luna, gasping and moaning in shared ecstasy, sometimes twitching with a small aftershock of one or the other of your powerful orgasms.");
					if (player.hasKnot()) outputText(" It takes several minutes before your knot softens and you unlock from her; you reflect on how your body itself is treating her as your breeding bitch, keeping you together to ensure she can't reject your fertile union. With slight difficulty you pull yourself free of her with a noisy 'pop', your knot still resisting your separation somewhat, and");
					else outputText(" You pull your lengths free of her with a wet squelching noise, and");
					if (player.cumQ() <= 1000) outputText(" immediately a dribble of cum begins to fall from her anus. Her pussy remains clenched enough to hold your seed deep inside her as the breeding instincts you seem to have awoken continue to exert control and keep your seed locked inside her to ensure a pregnancy.\n\n");
					else outputText(" immediately cum begins pouring out of her gaping nether ring as her guts begin their instinctive work of emptying themselves. Before long a small puddle of your fluid has formed between her legs, and the flow shows no signs of slowing. Meanwhile her pussy spurts a little spray of cum every few seconds as it strains to contain everything you pumped into her, the breeding instincts you seem to have awoken not quite able to handle your unnatural volume. Still, until her body relaxes a bit it seems Luna will be looking a little puffy as her body attempts to ensure pregnancy.\n\n");
				}
				else {
					outputText("Not one to pass up such a pleasing offer, you waste no time. Grabbing Luna's hips roughly you pull her back toward you and shove your cocks between her thighs, running it back and forth across her dripping slit until they are thorougly coated in her slippery juice. She moans shamelessly at the feel of your length stroking her drooling lower lips and clit. Once you're lubricated and she's loosened, you carefully line yourself up with her dripping pussy and hilt yourself.\n\n" +
							"Both of you howl at the sudden onrush of stimulation, and Luna screams " +
							"\"<i>AAAAAAAOOOOOOOOOOOOOHH! " + player.mf("Master","Mistress") + ", yes, yes! Fuck me, " + player.mf("Master","Mistress") + ", pound my pussy until I can't see straight! Fuck your dirty bitch into the ground!</i>\"" +
							" Her dirty talk electrifies you into motion and you begin mercilessly pounding her, your hips slamming roughly into her ass every time you hilt her, fluids splashing wetly from her sopping pussy every time you pull out. Almost immediately Luna orgasms again, spasming and falling to the ground in front of you once more. Only your hands are holding her hips up as you continue to piston into her; her torso rocks back and forth on the soft flesh of her breasts and her head lays helplessly on the ground, her long, canine tongue lolled out brainlessly as it drags. The only sound she makes now is a sort of loose " +
							"\"<i>arp</i>\"" +
							" that comes out each time your hips slam into her cusiony ass, faster and faster as you seek to increase your own pleasure.\n\n" +
							"Luna's pussy is wet and tight, and the little bumps and folds are exquisitely rubbing against your cock. You keep up your frantic pleasure-seeking for a moment until you feel an orgasm just beginning to approach, then slow your movements, looking to prolong your enjoyment. Finally, with a wet sucking noise you pull your throbbing members free of Luna's gaping snatch, a little spray of her cum celebrating your departure. " +
							"\"<i>Aaahhhhhhhhhaaahhhhhhhnnnnnnnn...eeeep!?</i>\"" +
							" Luna moans insensately at first, then yips in confusion as you suddenly flip her over onto her back, having decided you want a full view of her before you pump her full of cum. Her legs splay out in front of her, giving you a spectacular view of her squeezing pussy begging you to come back in." +
							"Luna pants and moans as you run your cock across her pussy once more, but you lean over her and cut off her ragged breaths with a fierce, sucking kiss, to which she responds by pressing her tongue into your mouth for you to suck and nibble on. This goes on for a moment until you've adequately lubricated yourself again and Luna is gasping for air against you; then you raise yourself back up, giving her breasts a good squeeze in the process as she yelps again in pleasure." +
							"Once more you line up your cock and thrust it in, far more easily this time. The sensations are different in this missionary position; her dripping, spasming pussy is hitting you in entirely new places on your throbbing cock, providing a fresh excitement to your thrusts and speeding your climax. You can see her breasts jiggling up and down as you pound her now, the sight adding a nice visual punctuation to each thrust. Her face is completely slack; her eyes are rolled up into her head and her tongue is flopping against her cheeks." +
							" Every now and then you feel her cum again, a little spasm running through her otherwise limp body. You've lost count of how many times it's happened. Meanwhile your own pleasure begins peaking again, and you start thrusting faster. The increased speed and sensation pulls Luna out of her daze just enough to say " +
							"\"<i>Haaa... haaa... " + player.mf("M-master","M-mistress") + "...  p-please...</i>");
					if (player.hasKnot()) outputText("<i>knot me... please... I need it... I need to feel you filling me, locking me, claiming me...</i>\"\n\n");
					else outputText("<i>cum inside me... please... I need it... I need to feel your hot stuff filling me...</i>\"\n\n");
					outputText("You grin maliciously and suddenly even out your pace, causing your orgasm to plateau momentarily. Luna whines as she realizes you're teasing her, but you tell her that she can't tell you what to do; a horny bitch doesn't get");
					if (player.hasKnot()) outputText(" knotted");
					else outputText(" filled");
					outputText(" until she begs. Tears in her eyes, Luna pleads with you even more desperately. " +
							"\"<i>" + player.mf("Master","Mistress") + ", please, I'm begging you, please</i>");
					if (player.hasKnot()) outputText("<i> knot</i>");
					else outputText("<i> cum inside</i>");
					outputText("<i> your horny, needy bitch, " + player.mf("Master","Mistress") + "... </i>");
					if (player.hasKnot()) outputText("<i>lock me and </i>");
					outputText("<i>fill me with your seed, I beg you, fill me up until I'm pregnant with your puppies... please, " + player.mf("Master","Mistress") + ", I need your puppies... I want to give you puppies... please please please please please...</i>\"" +
							" You have no idea how serious she is about that, but you figure it's good enough, and as she devolves into mindlessly repeating the word 'please' you grab her thighs and press them against her chest, speeding up once more, thrusting yourself furiously into her until she begins moaning and gasping with an approaching climax of her own." +
							"You reach your climaxes together. After minutes of moaning and panting brainlessly, too dazed even to react to the numerous orgasms she's had, Luna suddenly begins gasping and screaming the same way she did when you gave her her first one of the day, then begins spasming almost epileptically as the pleasure overwhelms her already pleasure-fried brain one time too many." +
							" The sensation of her holes squeezing and pulsing as she cums is just enough to push you over the edge as well, and with a bestial grunt you hilt yourself one last time into her and release.");
					if (player.hasKnot()) outputText(" Your knot swells to its full size, locking you in place until nature has run its course; not that you had any plans of pulling out anyway.");
					if (player.cumQ() <= 500) outputText(" Your cock begins spurting thick ropes of cum into Luna's spasming pussy. She gives a ragged cry of relief, as if you had doused a fire inside her with your fluids; then, your passion spent, ");
					else if (player.cumQ() <= 1000) outputText(" Your cock begins pouring cum inside Luna's pussy, quickly filling it until you can feel the warm liquid splashing back against your tip as it seeks another way out. Luna gives out a ragged cry of relief, as if you had doused a fire inside her with your plentiful fluids. By the time your ejaculation is finished there are little drizzles of cum running back down your shaft; then, your passion spent, ");
					else if (player.cumQ() <= 2000) outputText(" Your cock begin spraying enormous amounts of cum into Luna's greedy hole; almost immediately her spasming tunnel and womb have taken all they can take and begin resisting further intrusion. But she has clamped down too tightly on you to allow full relief of the pressure, and as you continue to cum inside her her belly swells until she looks almost pregnant. Despite the obvious discomfort of being filled past capacity Luna gives a ragged cry of relief, as if your inhuman ejaculation had put out a fire that was raging inside her; then, your passion spent, ");
					else outputText(" Your cock begins hosing her insides with cum at an inhuman velocity; almost immediately she begins swelling up, unable to contain your issue without stretching her womb. In a moment she looks like she has a belly full of puppies already, and the sprays of cum leaking out around your shaft are nowhere near enough to offset the copious amounts you continue to pump into her as your intense orgasm continues. She cries out in a mix of pain and relief, as if you had doused a fire inside her with your fluids only to replace the crisis with a flood. Finally your orgasm subsides and, your passion spent, ");
					outputText("you collapse on top of Luna, gasping and moaning in shared ecstasy, sometimes twitching with a small aftershock of one or the other of your powerful orgasms.");
					if (player.hasKnot()) outputText(" It takes several minutes before your knot softens and you unlock from her; you reflect on how your body itself is treating her as your breeding bitch, keeping you together to ensure she can't reject your fertile union. With slight difficulty you pull yourself free of her with a noisy 'pop', your knot still resisting your separation somewhat, and");
					else outputText(" You pull yourself free of her with a wet 'squelch', and");
					if (player.cumQ() <= 1000) outputText(" no more than a single trickle of cum leaves her pussy afterward; the breeding instincts you seem to have awoken with your rough treatment are still exerting influence over her body as it seeks to hold your seed inside her to ensure a pregnancy.\n\n");
					else outputText(" her pussy spurts out a little bit of your cum every few seconds as it strains to contain everything you pumped into her, the breeding instincts you seem to have awoken not quite able to handle your unnatural volume. Still, until her body relaxes a bit it seems Luna will be looking a little puffy as her instincts attempt to ensure pregnancy in spite of her.\n\n");
				}
			if (flags[kFLAGS.LUNA_MOONING] == 1) {
				outputText("Luna manages to pull her arms around you and the two of you lay together for a moment, catching your breath and slowly coming down from the high of your rather extreme sex, then you feel Luna begin to shrink under you. Not wanting to hurt her as her body resumes its normal human shape you slide off her to one side and pull her into an embrace, facing you. You watch as her ears return to their human shape and place and her tail shrinks back into her spine; then the fur retreats on her paws as they return to being her usual delicate human hands and feet, and as she finishes transforming her head has moved to the level of your chest thanks to her reduction in height. With a sigh she buries her face in your chest, and you pull her in even tighter." +
						"\"<i>" + player.mf("Master", "Mistress") + "... that was <b>incredible</b>. No one's ever satisfied me like that before. You're amazing... I... I'm so glad you hired me...</i>\"" +
						" You begin running a hand lazily over her mussed up hair as she talks, smiling down at her, and you tell her that she did an amazing job as well, and you're equally glad you hired her. She nuzzles her head against your chest with a happy little noise, then suddenly stiffens as she realizes what she's doing. " +
						"\"<i>Ah! I'm so sorry, I didn't mean- I'm just a- I should be getting back to-</i>\"" +
						"You cut off her panicked squeaking by pulling her head into your chest, muffling her into incoherent babbling that resonates into your body until she quiets down and goes limp. You tell her to shush, that she may be a maid, but that she's long been more than just a servant to you and if you want to cuddle for a while you will. She looks up at you with big golden eyes and nods. You smile at her, and despite her best efforts she smiles back, then buries her face in your chest once more, this time relaxing against you until you can feel every contour of her body against yours, peaceful and warm. Then she stiffens once more as you ask her if she was serious about wanting puppies." +
						"\"<i>Ohhhh... oh no... I'm so sorry, " + player.mf("Master","Mistress") + ", this is so embarrassing. That was the heat talking; I couldn't help myself. I wanted it in the moment, so badly, but I take an herb to make sure I won't actually get pregnant. I know that as a servant I musn't bear the " + player.mf("Master's","Mistress's") + "-</i>\"" +
						" Once more you cut her off, this time with a finger on her pink lips, and tell her again that she's more than a servant, much more, and if she really does desire children that's something you're willing to discuss; not as master and servant but as lovers." +
						"You see tears streaming down Luna's face as she looks up at you with shining eyes. " + player.mf("Master","Mistress") + ", I mean, no... [name], my love, I...</i>\" she trails off for a second and closes her eyes as she sorts her thoughts and emotions. Finally she opens her eyes again and looks directly at you. \"<i>I would love to carry your children if I were ready, but I don't think I am yet. I... I still have things that I need to work through, I think, before I could be as good a mother as your children deserve. I hope I haven't disappointed you, " + player.mf("Master","Mistress") + " if it was your desire, but if it is your wish to leave part of the decision to me I would prefer to wait.</i>\" You nod, and pet her head while you tell her that that's entirely why you asked her, and that if she ever changes her mind she should feel free to speak with you about it.");
			}
			//else text for you continuing to fuck Luna as her corrupted, moon-fueled lust infects you
			}
			else {
				outputText("Luna's submissive posture is all the motivation you need to give her the dominance she craves. You grab her hips and flip her onto her back as she yelps and whimpers, and once settled she obediently splays her legs open, presenting herself to you in meek anticipation. You begin by fingering her wet, gaping slit for a while, periodically slipping a finger down to her lower ring for a quick tease, and soon she is once more howling in pleasure. But you're not here to pleasure your bitch all " + (flags[kFLAGS.LUNA_MOONING] == 2 ? "night" : "day") + "; the time has come to get yours. After you've got Luna properly panting you stand up, step over her, and turn around to straddle her directly over her face. Then you get back down on your hands and kneees, your own drooling opening inches from her mouth. " +
						"\"<i>Lick,</i>\"" +
						" you command once in a curt, no-nonsense voice, and Luna immediately and gleefully complies.\n\n" +
						"Her long, wolfish tongue lapping and poking at your sensitive lips and clit quickly has you gasping in pleasure, and it's a good half a minute before you are acclimated enough to the stimulation to return your own attention to her steaming pussy, now directly under you. You begin giving her the same treatement and are rewarded by a low, throaty moan from her that vibrates into your pussy as she continues to obediently service you. This continues for a moment, the two of you pleasuring and being pleasured, her breasts pushing sensuously into your abdomen as it twitches and bucks with pleasure at her lapping");
				if (player.biggestTitSize() > 1) outputText(", while her own hips buck upward and massage yours every time you give her a new jolt of pleasure with your lips and tongue");
				outputText(". Soon, however, you find yourself wanting more as your pleasure begins to plateau, and you bark out another order to your sub: " +
						"\"<i>Deeper.</i>\"" +
						" Luna hears you and begins probing more deeply into your dripping hole with her tongue, sucking and nibbling with her canine lips, and even gently prying you open at times with her paws to get better access. You find yourself gasping and moaning again as the pleasure redoubles, and you reward your bitch with new ministrations of your own, plunging a well-lubed thumb into her anus and poking it in and out while you push your own [tongue] as deep as it will go into her flooded canal. This in turn prompts her to even more frenzied efforts, in a virtous cycle of increased pleasure until you find yourself hanging just on the edge of a massive orgasm. " +
						"\"<i><b>Deeper,</b></i>\"" +
						" you repeat, and Luna, her tongue already strained to its full length inside you, has only once choice to obey. You gasp as you feel her invade your pussy with her lips, straining her face against your rear until she is fully compressed against you, her nose nearly inside your asshole. Her long wolf-tongue reaches nearly to your womb now, and she wiggles it as she extends it fully inside you.\n\n" +
						"Of course, this can't go on for very long: obviously your poor sub is completely unable to breathe with both of her air-holes buried completely in your backside. Fortunately, it doesn't need to; you redouble your efforts at Luna's own gaping sex, fingering her anus and nibbling at her lips and clit while your tongue stimulates her depth even more frantically, and that combined with her progressively more severe anoxia as her chest heaves under your pelvis, desperate for air, brings her to a second massive orgasm just as your own pleasure peaks. She opens her fanged mouth in a pleasured scream that echoes inside you as she pulls her face free, pushing you over the edge into your own massive orgasm, and you both cry out in ecstacy as you buck and twitch against each other, you on top and Luna on bottom, until finally your bodies relax into a heap.");
				if (flags[kFLAGS.LUNA_MOONING] == 1) outputText("You lay on top of Luna like that until you feel her transformation begin to reverse underneath you, at which time you pick yourself up and turn around to lay beside her. Just as she finishes reverting to her human form you pull her into an embrace, her head against your chest, and she rests her tired face against your [breasts], sighing and giving a tired but satisfied little moan as she snuggles against you. \"<i>Oh, " + player.mf("Master","Mistress") + ", that was <b>incredible</b>.</i>\" she murmurs against you, and you give her a little squeeze of agreement.");
				//else text for you and Luna resuming your fucking as her corrupted, moon-fueled lust infects you
			}
			lunaJealousy(-100);
			lunaAffection(2);
			player.sexReward("saliva");
			if (flags[kFLAGS.LUNA_MOONING] == 1) {
				outputText("She speaks up again after a moment. " +
						"\"<i>Really," + player.mf("Master","Mistress") + ", thank you so much for this. I've never had a master or mistress who... accepted me, the way you do; not even before I came to Mareth and became... what I am. It means so much to me that you accept all of me, and that you take such good care of my needs... even if I wish you would stop relying on other people so often when I'm here for you.</i>\"" +
						" You decide to ignore the note she ended on to avoid spoiling the mood, and give her another squeeze, at which she moans contentedly and snuggles even closer. Soon  her breath evens out as she drifts into a doze, and you soon follow, falling asleep with your cute maid snuggled up in your arms." +
						"You awaken an hour later to find that Luna has woken up ahead of you and placed a little pillow under your head, and a blanket over your naked body.");
				if (!player.isNaked()) outputText(" Your equipment is neatly folded up nearby.");
				outputText(" A bit regretfully you force yourself to get up and prepare for whatever adventures await you next before the day ends.");
				doNext(camp.returnToCampUseOneHour);
			}
			else {
				//text for you and Luna continuing your rough, animalistic sex throughout the night
				if (flags[kFLAGS.LUNA_FOLLOWER] < 7 && player.werewolfScore() > 6) {
					//text for Luna being your bitch whom you intend to use freely until every dog in a ten mile radius knows she belongs only to you
					flags[kFLAGS.LUNA_FOLLOWER] = 15;
				}
				flags[kFLAGS.LUNA_MOONING] = 1;
				if (!player.isNightCreature()) doNext(camp.sleepWrapper);
				else doNext(camp.returnToCampUseOneHour);
			}

		}
		/*
		public function sexMenuDominateHer():void {
			spriteSelect(SpriteDb.s_Luna_Mooning);
			clearOutput();
			outputText("You grab at the werewolf girl’s exposed chest and begin tugging, making her moan in delight at your forceful attention.\n\n");
			outputText("\"<i>Ooooh " + player.mf("Master","Mistress") + ", I knew you loved me! Please make me your bitch for the night!</i>\"\n\n");
			outputText("You're way too horny to stop now. You will use her however you want and that starts with satisfying your desire.\n\n");
			if (player.gender == 1) {
				outputText("You're going to get a taste of that doggy pussy right now. The wolf girl doesn’t  even begin to protest as you grab her hips forcing her on all fours. You move behind her and shove your [cock] right into her hot cunt");
				if (player.hasKnot()) outputText(", knotting her just fine");
				outputText(".\n\n\"<i>Awoooooooo, that's just the right size master! Use me!!! Use me more!!!</i>\"\n\n");
				outputText("You're just beginning however, and start to pound the bitch in earnest. If being dominated by an Alpha male is her thing you are more than happy to oblige. The bitch pants, drool falling on the dirt as you fuck her, your crotch slapping against her well shaped backside with each thrust. Gosh her cunt is like a vice" + (flags[kFLAGS.LUNA_MOON_CYCLE] % 7 == 0 ? ", is she actually in heat every single full moon?" : ".") + " ");
				outputText("If that's the case you’re going to abuse that wanting cunt every time the lunar disc is complete. Her tail is wagging from side to side as you fuck her for several minutes, soothing her " + (player.inRut ? "and your " : "") + "feral urges!\n\n");
				outputText("Finally you reach your climax " + ((player.dogScore() > 5 || player.wolfScore() > 5) ? "howling in tandem with her" : "roaring in tandem with her howl") + " as you paint her cunt white like the moon with your hot seed. She sighs in relief, turning over without unplugging you from her cunt to embrace you.\n\n");
				lunaJealousy(-100);
				lunaAffection(2);
				player.sexReward("vaginalFluids","Dick");
				if (flags[kFLAGS.LUNA_MOONING] == 1) {
					outputText("You rest a moment in her arms before breaking the hug. As much as your savage lover would like you to dom her all day you’ve got other things to do. The both of you redress before resuming normal activities.\n\n");
					doNext(camp.returnToCampUseOneHour);
				}
				else {
					outputText("You keep painting her cunt several times under the moonlight until dawn finally breaks, the two of you resting a few hours before resuming activity. Luna give you a parting wink before adding.\n\n");
					outputText("\"<i>I knew you had it in you [name] please just make sure to use me regularly.</i>\"\n\n");
					if (flags[kFLAGS.LUNA_FOLLOWER] < 7 && player.werewolfScore() > 6) {
						outputText("Yes for sure! You're going to make sure to use her as often as necessary to imprint your scent on her from now on. She’s your beta and no one else’s.");
						flags[kFLAGS.LUNA_FOLLOWER] = 15;
					}
					flags[kFLAGS.LUNA_MOONING] = 1;
					if (!player.isNightCreature())
					{
						doNext(camp.sleepWrapper);
					}
					else doNext(camp.returnToCampUseOneHour);
				}
			}
			else {
				outputText("You sure are making her your bitch tonight, you're the alpha female here and as such you deserve proper tribute! You begin by brutally shoving her down on the ground to assert your dominance and make your positions clear. Now that she's on her back you sit on her face and yip your first order of the " + (flags[kFLAGS.LUNA_MOONING] == 2 ? "night" : "day") + ".\n\n");
				outputText("\"<i>Lick me clean " + (player.hasCock() ? "and get to pumping my tool" : "") + "!</i>\"\n\n");
				outputText("She doesn’t protest and swiftly get to it making you growl in satisfaction as her dog tongue slithers in " + (player.hasCock() ? "and her paws jerks your [cock]" : "") + ". Beta or not Luna deserves some reward, however. You bring your " + (player.haveNaturalClaws() ? "paw" : "hand") + " to her cunt and begin playing inside while you use your other " + (player.haveNaturalClaws() ? "paw" : "hand") + " to grab her left breast, squeezing it firmly. Luna seems to be enjoying herself, her tail wagging from side to side which is fine, so long as YOU remain on top and reach satisfaction first. ");
				outputText("Whenever you feel she's getting more pleasure than you, you deny her until you've caught up, making sure you are always ahead. " + (player.werewolfScore() >= 12 ? "The both of you are" : "She’s") + " panting in desire like " + (player.werewolfScore() >= 12 ? "beasts" : "a beast") + " growling between gasps of pleasure.\n\n");
				outputText("Finally you cum, flooding her thirsty mouth with your girl juices");
				if (player.hasCock()) outputText(" as your cock explodes, covering her chest up to her belly in semen" + (player.werewolfScore() >= 12 ? " while you howl to the moon, savoring your mind blowing orgasm" : "") + "");
				outputText(". The waters flooding your fingers a few seconds later are the only telltale sign your beta finally reached her climax, but you think it’s more than enough of a reward for her.\n\n");
				lunaJealousy(-100);
				lunaAffection(2);
				player.sexReward("saliva");
				if (flags[kFLAGS.LUNA_MOONING] == 1) {
					outputText("Satisfied, you rest a moment in her arms before breaking up. As much as your savage lover would like you to dom her all day you got other things to do. The both of you redress before resuming activity.\n\n");
					doNext(camp.returnToCampUseOneHour);
				}
				else {
					outputText("That said, you are far from done. The moment you recover, you resume fucking with her like a beast several time under the moonlight until dawn finally breaks, the two of you resting a few hours before resuming activity. Luna give you a parting wink before adding.\n\n");
					outputText("\"<i>I knew you had it in you [name] please just make sure to use me regularly.</i>\"\n\n");
					if (flags[kFLAGS.LUNA_FOLLOWER] < 7 && player.werewolfScore() > 6) {
						outputText("Yes for sure! You're going to make sure to use her as often as necessary to imprint your scent on her from now on. She’s your beta and no one else’s.");
						flags[kFLAGS.LUNA_FOLLOWER] = 15;
					}
					flags[kFLAGS.LUNA_MOONING] = 1;
					if (!player.isNightCreature())
					{
						doNext(camp.sleepWrapper);
					}
					else doNext(camp.returnToCampUseOneHour);
				}
			}
		}
		*/
		/*
		public function sexMenuSpearPolishing():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("WIP\n\n");
			outputText("\"<i>WIP</i>\"\n\n");
			doNext(talkMenuLuna);
		}*/
	}
}