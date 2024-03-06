/**
 * ...
 * @author Pyromania
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Forest.CorruptedGlade;
import classes.Scenes.Places.TrollVillage;
import classes.display.SpriteDb;
import classes.internals.SaveableState;

import coc.view.ButtonDataList;

public class ZenjiScenes extends NPCAwareContent implements SaveableState
	{
		public static var Z1stKid:String;
		public static var Z2ndKid:String;
		public static var ZenjiNightWatch:Number;
		public static var ZenjiFood:Boolean;
		public static var ZenjiMarae:Boolean;
		public static var ZenjiHolli:Boolean;
		public static var ZenjiMarried:Boolean;
		public static var ZenjiFigMulti:Number;
		public static var ZenjiSleepCount:int;
		public static var ZenjiLoverDays:int;
		public static var ZenjiLoverDaysTracker:int;
		public static var ZenjiTalkCount:int;


		public function stateObjectName():String {
			return "ZenjiScenes";
		}

		public function resetState():void {
			Z1stKid = "";
			Z2ndKid = "";
			ZenjiNightWatch = 0;
			ZenjiFood = false;
			ZenjiMarae = false;
			ZenjiHolli = false;
			ZenjiMarried = false;
			ZenjiFigMulti = 0;
			ZenjiSleepCount = 0;
			ZenjiLoverDays = 0;
			ZenjiLoverDaysTracker = 0;
			ZenjiTalkCount = 0;
		}

		public function saveToObject():Object {
			return {
				"Z1stKid": Z1stKid,
				"Z2ndKid": Z2ndKid,
				"ZenjiNightWatch": ZenjiNightWatch,
				"ZenjiFood": ZenjiFood,
				"ZenjiMarae": ZenjiMarae,
				"ZenjiHolli": ZenjiHolli,
				"ZenjiMarried": ZenjiMarried,
				"ZenjiFigMulti": ZenjiFigMulti,
				"ZenjiSleepCount": ZenjiSleepCount,
				"ZenjiLoverDays": ZenjiLoverDays,
				"ZenjiLoverDaysTracker" : ZenjiLoverDaysTracker,
				"ZenjiTalkCount": ZenjiTalkCount
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				Z1stKid = o["Z1stKid"];
				Z2ndKid = o["Z2ndKid"];
				ZenjiNightWatch = o["ZenjiNightWatch"];
				ZenjiFood = o["ZenjiFood"];
				ZenjiMarae = o["ZenjiMarae"];
				ZenjiHolli = o["ZenjiHolli"];
				ZenjiMarried = o["ZenjiMarried"];
				ZenjiFigMulti = valueOr(o["ZenjiFigMulti"], 0);
				ZenjiSleepCount = valueOr(o["ZenjiSleepCount"], 0);
				ZenjiLoverDays = valueOr(o["ZenjiLoverDays"], 0);
				ZenjiLoverDaysTracker = valueOr(o["ZenjiLoverDaysTracker"], 0);
				ZenjiTalkCount = valueOr(o["ZenjiTalkCount"], 0);
			} else {
				// loading from old save
				resetState();
			}
		}

		public function ZenjiScenes()
		{
			Saves.registerSaveableState(this);
		}

		public function zenjiPerspectiveOnPlayer(changes:Number = 0):Number
		{
			if (flags[kFLAGS.ZENJI_PROGRESS] < 7) flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] += changes;
			if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] > 100) flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] = 100;
			if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] < 0) flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] = 0;
			return flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER];
		}

		private var spellBookButtons:ButtonDataList = new ButtonDataList();

		//PART 1

		public function part1TrollEncounter():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] = 50;
			flags[kFLAGS.ZENJI_PROGRESS] = 1;
			outputText("As you are trekking your way through the foliage of the bog, clearing a path through the flora and making sure to watch your step, you are suddenly halted by a deep, brassy voice coming from nearby.\n\n");
			outputText("\"<i>Ahaha, ¿Que eres? A new one steps into my grounds.</i>\" The voice speaks with a slight lisp and a vaguely spanish accent.\n\n");
			outputText("You turn to your left and see what looks to be a tall, muscular humanoid. He is easily over 8 feet tall, standing on a tree branch and hanging onto one above him with his muscular arms over his head. He's covered head to toe in dense fuzz with a fairly long tail sprouting behind him. He is supporting a very large and intimidatingly muscular physique. You’re not quite sure who or what he could be."+(flags[kFLAGS.ROGAR_PHASE] > 0 ? " You think that perhaps he’s an orc like Ro’Gar, but he doesn’t have the same body shape, completely different facial structure and has far more fur on his body.":"")+"\n\n");
			outputText("\"<i>Heheh, If you want to enter I don't ask for much, ya see?</i>\" he chuckles, \"<i>You can pay  a toll for de troll, 25 gems to enter, or perhaps you have something else to offer, something dat could require a lot from you if you tink you can take de challenge.</i>\"\n\n");
			outputText("You sigh, it's pretty much the same thing, all anybody asks for in this land is either sex or gems and this alleged troll as he called himself seems no different. You consider if giving him proper payment is worth it.\n\n");
			camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_TROLLS);
			menu();
			if (player.gems >= 25) addButton(0, "Pay w Gems", part1TrollEncounterPayWithGems);
			else addButtonDisabled(0, "Pay w Gems", "You don't have enough gems!");
			addButton(1, "Sex", part1TrollEncounterSex);
			addButton(2, "Challenge", part1TrollEncounterChallange);
			addButton(3, "Fight", part1TrollEncounterFight);
			addButton(4, "Leave", part1TrollEncounterLeave);
		}
		public function part1TrollEncounterRepeat():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			flags[kFLAGS.ZENJI_PROGRESS]++;
			outputText("You turn to your left and see the self proclaimed troll again resting on the tree. He hops down, standing a couple feet away from you.\n\n");
			outputText("\"<i>Same deal as last time, care to pay up..?</i>\"\n\n");
			outputText("You think for a moment on how you want to deal with the situation.\n\n");
			menu();
			if (player.gems >= 25) addButton(0, "Pay w Gems", part1TrollEncounterPayWithGems);
			else addButtonDisabled(0, "Pay w Gems", "You don't have enough gems!");
			addButton(2, "Challenge", part1TrollEncounterChallange);
			addButton(3, "Fight", part1TrollEncounterFight);
			addButton(4, "Leave", part1TrollEncounterLeave);
		}

		public function part1TrollEncounterLeave():void {
			outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
			outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" he chuckles, \"<i>Your loss.</i>\"\n\n");
			outputText("You return back to your camp following the path that you made along your way.\n\n");
			endEncounter();
		}

		public function part1TrollEncounterFight():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			flags[kFLAGS.ZENJI_PROGRESS] += 0.1;
			outputText("You raise your [weapon] and adopt a fighting stance.\n\n");
			outputText("\"<i>Are ya ready ta fight den? Good, show me whatcha got!</i>\"\n\n");
			startCombat(new Zenji());
			doNext(playerMenu);
		}

		public function part1TrollEncounterFightPCDefeated():void {
			clearOutput();
			zenjiPerspectiveOnPlayer(-4);
			if (player.HP <= player.minHP()) {
				outputText("The troll looks down on you, bruised and beaten. \"<i>Ahaha, dat was fun, but it looks like someone couldn’t handle me. I’ll be gettin ma payment now if ya don't mind.</i>\"\n\n");
				outputText("You see him rifling through your gem pouch as you black out.\n\n");
			}
			else {
				outputText("The troll looks down at you, \"<i>Qué lástima. Now dat is a sorry sight…</i>\"\n\n");
				outputText("You see him rifling through your gem pouch. His fur is so soft as it tickles your skin. You’re desperate for his touch, you want him so badly as you lean closer to him.\n\n");
				outputText("\"<i>Get off of me!</i>\" he shouts, throwing you to the ground. You hit the ground and the world grows dim before you black out.\n\n");
			}
			cleanupAfterCombat();
		}

		public function part1TrollEncounterFightZenjiDefeated():void {
			clearOutput();
			outputText("The troll staggers backward, unable to fight anymore. \"<i>Heh... ya bested me...</i>\" he coughs, \"<i>Go on, ya can enter... I jus need a break...</i>\"\n\n");
			outputText("He struggles a moment before he tumbles away, nowhere to be seen.\n\n");
			zenjiPerspectiveOnPlayer(4);
			menu();
			if (player.cor >= 50 - player.corruptionTolerance) addButton(1, "Hunt him", part1TrollEncounterFightZenjiDefeatedHuntHim).hint("He’s not getting away that easily!");
			else addButtonDisabled(1, "???", "Need 50+ corruption.");
			addButton(3, "Leave", cleanupAfterCombat);
		}

		public function part1TrollEncounterFightZenjiDefeatedHuntHim():void {
			if (player.spe < 180 && player.wis < 180) {
				outputText("You chase after the troll, unwilling to let your prey elude you. Afterall, what’s the point in a little combat if you can’t claim your spoils by slaying your foe?\n\n");
				outputText("You attempt to track him by the strong scent you remember him giving off, following the trail through the dense swamp, past the thicket of bog flora. After several minutes you decide to give up, he’s long gone, much too fast for you to catch up to. You head home, after wasting your time.\n\n");
				cleanupAfterCombat();
			}
			else {
				outputText("You chase after the troll, unwilling to let your prey elude you. Afterall, what’s the point in a little combat if you can’t claim your prize by slaying your foe?\n\n");
				outputText("You attempt to track him by the strong scent you remember him giving off, following the trail through the dense swamp, past the thicket of bog flora. After several minutes you notice that the scent is starting to grow stronger, and the markings of disturbed and displaced life as well as objects become more apparent. He is close, your prize is nigh.\n\n");
				outputText("You see the troll tending to his wounds atop a tree, almost completely recovered from the last ordeal. His ears twitch as he turns to look at you.\n\n");
				outputText("He says nothing as he peers toward you, eyeing you carefully, sensing the danger he’s in. He didn’t actually think he’d be able to escape you, did he?\n\n");
				outputText("A minute passes before he breaks the silence, \"<i>Come to finish me off?</i>\" he asks with a growl.\n\n");
				outputText("You adopt a fighting stance, that was your intention afterall.\n\n");
				outputText("\"<i>I shoulda just killed you last time we met, I guess I was still blinded by my past, running away from my problems... I won’t hesitate.</i>\"\n\n");
				cleanupAfterCombat(part1TrollEncounterFightZenjiDefeatedHuntHim2);
			}
		}
		public function part1TrollEncounterFightZenjiDefeatedHuntHim2():void {
			flags[kFLAGS.ZENJI_PROGRESS] = -1;
			startCombat(new Zenji());
			doNext(playerMenu);
		}

		public function part1TrollEncounterFightTOTHEDEATHPCDefeated():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (player.HP <= player.minHP()) {
				outputText("You fall to the ground, bruised and beaten, wounds too severe for you to walk off right now.\n\n");
				if (player.cor < 90 + player.corruptionTolerance) {
					outputText("\"<i>Qué lástima,</i>\" he growls, \"<i>Not even worth my time.</i>\"\n\n");
					outputText("He walks off, nowhere to be seen. The world grows hazy as you pass out from exhaustion.\n\n");
					cleanupAfterCombat();
				}
				else {
					outputText("\"<i>Vile creature,</i>\" he growls, \"<i>It’s time ta rid dis world of filth like you. One. By. One.</i>\" He picks up his spear, lining up the tip to your throat before impaling you with one swift motion. You choke, gasping for air, reaching up in desperation. The world grows hazy as you feel reality release its grip on you. The last thing you see is his spear going in for a coup de grâce.\n\n");
					EventParser.gameOver();
				}
			}
			else {
				outputText("You fall to the ground, too aroused to fight any longer, your senses overwhelm you before the masculine scent of his dense musk.\n\n");
				outputText("\"<i>Pathetic,</i>\" he mutters, \"<i>Dat’s all demons like you want, I’d best kill you before you bother someone else.</i>\"\n\n");
				outputText("He picks up his spear, lining up the tip to your throat before impaling you with one swift motion. You choke, gasping for air, reaching up in desperation. The world grows hazy as you feel reality release its grip on you. The last thing you see is his spear going in for a coup de grâce.\n\n");
				EventParser.gameOver();
			}
		}

		public function part1TrollEncounterFightTOTHEDEATHZenjiDefeated():void {
			clearOutput();
			outputText("The troll falls to the ground, severely wounded, unable to fight any longer. He struggles to regain his footing, desperately clinging onto the spear he has impaled to the ground.\n\n");
			outputText("\"<i>I will not wither!</i>\" he grunts, \"<i>I WILL NOT FALL!</i>\" His voice trembles as he struggles to stand up before you, adopting a fighting stance. His legs buckle as he collapses, blood rushes down his face as he’s bleeding out, despite his attempts to regenerate.\n\n");
			outputText("You grin in satisfaction, considering what you want to do with your prey in his final moments.\n\n");
			menu();
			addButton(1, "Kill him", part1TrollEncounterFightTOTHEDEATHZenjiDefeatedKillHim).hint("He doesn’t deserve to live anymore");
			addButton(2, "Torment", part1TrollEncounterFightTOTHEDEATHZenjiDefeatedTorment).hint("Let him know his place");
			addButton(3, "Leave him", part1TrollEncounterFightTOTHEDEATHZenjiDefeatedLeaveHim).hint("Leave him to rot");
		}
		public function part1TrollEncounterFightTOTHEDEATHZenjiDefeatedKillHim():void {
			clearOutput();
			outputText("You smirk in satisfaction, has he learned his lesson yet or does he need one final example? Cowards never get to hide, now you can claim your prize once and for all.\n\n");
			outputText("You approach him, he looks toward you with bleak defiance. \"<i>I… won't… give up..!</i>\" he sputters, choking on his blood. \"<i>You will die, scum like you does not deserve to live!</i>\"\n\n");
			outputText("Such bold words for a coward, after all he was the one who ran away first. You notice one of his tusks is covered in a series of rings, it must be special to him so you forcefully grip onto it. His eyes tremble in fear as he tries to shake you off. He is at your mercy, desperately looking toward you, practically begging for his life with his wordless glance. You ponder how much a troll tusk would be worth if you pawn it, perhaps it’s easier to hold it as a trophy.\n\n");
			outputText("You tighten your grip on it, twisting it around slowly. He howls in agony as you draw more blood from his jaw. It doesn’t take long with the constant twisting, turning and yanking on your prize before you pry it from his maw with an audible snap. The troll howls in pain, tears streaming down his face as you have detached his pride and honor.\n\n");
			outputText("You figure with just how sharp it seems, it’d be a fitting way to end him, with something he seemingly is so fond of. You slide down your trophy down his throat, circling his jugular before impaling him in one swift motion. He gasps, struggling for air as he attempts to pry your hands away from him. Blood pours out from his vain struggling as you press the tusk deeper through his skin. Eventually, his efforts die down before his arms grow limp. You withdraw the tusk, it’s engorged in troll blood, another spoil of war. The troll lies dead beneath you, a shame he didn’t put up more of a fight.\n\n");
			inventory.takeItem(useables.TROLL_T, cleanupAfterCombat);
		}
		public function part1TrollEncounterFightTOTHEDEATHZenjiDefeatedTorment():void {
			clearOutput();
			outputText("You approach the troll, spitting on his face. A true fool, hiding from his problems, not everything can be run from, especially you.\n\n");
			outputText("You pick up the spear that he’s dropped, batting the side of his body, forcing him to roll over. He gives a pained groan each time you ram the length of his spear against him. You flip over the spear, so that the sharp head is against his skin.\n\n");
			outputText("You have a closer look at him, he seems young, slightly soft features and no signs of age at all. What a naive little creature, so bold, so needy to be put in his place. Thankfully you have already done so.\n\n");
			outputText("Naughty trolls don’t deserve to live, you say mock. Such a young troll he is, he should know better than to run from his problems. The troll seems visibly distressed at you calling him a child. You circle the sharp tip along his cheek, drawing blood as you press his spear against him, puncturing his skin. He howls in agony as you relish in his pain.\n\n");
			outputText("It’s so clear now, trolls are cowards, trying to escape from the inevitable. Marae is dead and who’s to blame for that? If only a strong, valiant race that was gifted by her magic were able to save her. Alas, it is too late now.\n\n");
			outputText("The troll begins weeping before you as his body relaxes. His will to fight on falters as his eyes begin to close from exhaustion and blood loss. His last moments were of humiliation and sorrow. He lies motionless, dead beneath your feet.\n\n");
			outputText("A shame you couldn’t toy with him more, at least now you can take your prize with ease.\n\n");
			outputText("You reach down, gripping the tusks covered in rings tightly between your fingers, twisting it around slowly. His lifeless body doesn’t react to what otherwise would be an agonizing experience. It doesn’t take long, twisting, turning, and yanking on your prize before you pry it from his maw.\n\n");
			inventory.takeItem(useables.TROLL_T, cleanupAfterCombat);
		}
		public function part1TrollEncounterFightTOTHEDEATHZenjiDefeatedLeaveHim():void {
			clearOutput();
			outputText("Has he learned his lesson yet? Cowards never get to hide, they only delay the inevitable. Judging by the pool of blood puddled beneath him he doesn’t have too long before he bleeds out. A slow, painful and lonely death for the most cowardly race to exist, not even goblins run away from their problems like trolls do.\n\n");
			outputText("You spend a moment admiring his futility, his hands glow with a gentle light before fizzling before him, his attempts at inducing his innate regeneration are futile. His injuries are far too severe for him to passively heal. He’ll bleed out before tomorrow you figure, but it’s lovely watching him cough and sputter up blood. You decide to head back home, you know you’ll never see him again.\n\n");
			outputText("\"<i>I… will neva die..! I will hunt you down! I… I will…</i>\" His voice rings through the thicket before dying out slowly. Words are meaningless when it comes from the dirt beneath you anyway.\n\n");
			cleanupAfterCombat();
		}

		public function part1TrollEncounterChallange():void {
			outputText("You look up to him and ask just what did he mean by 'challenge'?\n\n");
			outputText("He hops down from the tree, standing just over a foot away from you. \"<i>Heheh, I challenge you to a battle of skill, if you can beat me at ma own game, den I’ll let you pass.</i>\"\n\n");
			outputText("\"<i>So, which will it be, do you prefer to compete against me in a battle of wits, power or speed? I will test you inside, but don't ya go snoopin.</i>\"\n\n");
			outputText("He gestures for you to follow and you do so. Once inside, you consider just what do you want to challenge him on.\n\n");
			menu();
			addButton(0, "Strength", part1TrollEncounterChallangeStrength);
			addButton(1, "Toughness", part1TrollEncounterChallangeToughness);
			addButton(2, "Speed", part1TrollEncounterChallangeSpeed);
			addButton(3, "Intelligence", part1TrollEncounterChallangeIntelligence);
			addButton(4, "Wisdom", part1TrollEncounterChallangeWisdom);
			addButton(7,"Take it Easy", part1TrollEncounterChallangeTakeItEasy).hint("Let the troll have his fun. You know he wouldn't stand a chance against you anyway."+(flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] <= 30? " He seems to be growing quite fond of you. Perhaps he secretly enjoys watching you fail?":"")+"");
		}
		public function part1TrollEncounterChallangeStrength():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You decide that your best chance at besting him would be to challenge your strength against his.\n\n");
			outputText("\"<i>Ahaha, so you tink you can best me at ma strength? I will see just how strong you are.</i>\"\n\n");
			outputText("He leads you to a pile of rocks within the area of the bog, there lies a bunch of rocks of different shapes and sizes, he guides you to a bunch of rocks supporting a wooden pole, seemingly resembling a pull-up bar.\n\n");
			outputText("\"<i>Strength can be measured better than just thrusting one's power over the other, strength is about how strong you are at supporting yourself.</i>\" The troll walks over to one of the bars as wraps his fingers around the pole. \"<i>Der's another one next ta ya, I want you to hang from it, use your strength ta support yourself, keep ya chin above the bar, first one ta fall loses. I will start us.</i>\"\n\n");
			outputText("Seems simple enough, you walk over to the pull-up bar he mentioned and latch on, he grabs onto his once you do and on his mark, the test of strength starts.\n\n");
			if (player.str < (120 + (player.newGamePlusMod() * 24))) {
				outputText("You hold on with all your might, after some time you grow tired and begin kicking your legs in an attempt to get the blood flowing back into you. You look over to the troll who's hanging on with no signs of struggle.\n\n");
				outputText("Tired, you drop, unable to support yourself anymore.\n\n");
				outputText("\"<i>Ahahah, you are a weak little one, try harda next time,</i>\" he says, dropping to the ground.\n\n");
				outputText("Bested by his strength, you decide to return home.\n\n");
				zenjiPerspectiveOnPlayer(-4);
				endEncounter();
			}
			else if (player.str < (145 + (player.newGamePlusMod() * 29))) {
				outputText("You hold on with all your might, after a while you begin to grow tired and begin rocking back and forth to support yourself. You look over and you see the troll beginning to strain, it appears he's beginning to have trouble supporting himself as well.\n\n");
				outputText("After a few moments, you can't support yourself anymore and drop down to the ground.\n\n");
				outputText("\"<i>Heheh, you are a weak little one, you gotta do better dan dat next time,</i>\" he says, dropping to the ground.\n\n");
				outputText("Bested by his strength, you decide to return home.\n\n");
				zenjiPerspectiveOnPlayer(-4);
				endEncounter();
			}
			else {
				outputText("You hold on with all your might, after a while your arms start to grow weary. You look over to the troll and notice him straining to keep his composure. After a moment he drops with an exasperated breath, and you drop down after him.\n\n");
				outputText("\"<i>Hah... you are strong... stronger dan I expected, I'll let you pass, you can enter,</i>\" he states breathlessly.\n\n");
				zenjiPerspectiveOnPlayer(4);
				part1TrollEncounterRewards();
			}
		}
		public function part1TrollEncounterChallangeToughness():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You decide that your best chance at besting him would be to challenge your toughness against his.\n\n");
			outputText("\"<i>Ahaha, so you tink you can best me at ma toughness? I will see just how tough you are.</i>\"\n\n");
			outputText("He leads you to a pile of rocks within the area, there he gestures to a large boulder, \"<i>Toughness be about he resilient one is, how much can you handle, how much can you take before ya break?</i>\"\n\n");
			outputText("The troll eyes you carefully, then walks over to the pile of rocks and places it by your feet, \"<i>Dis rock looks like a good size for ya.</i>\"\n\n");
			outputText("He grabs a rock and places it at his foot, \"<i>I want ya ta hold dis rock high above your head wit only two arms as high as your arms can reach, first one to drop loses.</i>\"\n\n");
			outputText("Seems simple enough, you wait for his command and on queue, you hold the rock high above your head as high as your arms will let you.\n\n");
			if (player.tou < (115 + (player.newGamePlusMod() * 23))) {
				outputText("After some time of holding the rock above your head, your arms begin to grow weary, the rock, despite not being too heavy, is beginning to put a burden on your arms as its weight begins to feel like it's increasing. You look over to the troll who seems to be having no trouble carrying his rock above his head.\n\n");
				outputText("Unable to support the rock anymore, you drop in on the ground and give your tired arms a chance to rest.\n\n");
				outputText("\"<i>Heheh, you are a weak little one, try harda next time,</i>\" he says dropping the rock onto the ground.\n\n");
				outputText("Bested by his toughness, you decide to return home.\n\n");
				zenjiPerspectiveOnPlayer(-4);
				endEncounter();
			}
			else if (player.tou < (140 + (player.newGamePlusMod() * 28))) {
				outputText("After some time of holding the rock above your head, your arms begin to grow weary, the rock, despite not being too heavy, is beginning to put a burden on your arms as its weight begins to feel like it's increasing. You look over to the troll who seems to be showing signs of struggle holding the rock over his head.\n\n");
				outputText("Unable to support the rock anymore, you drop in on the ground and give your tired arms a chance to rest.\n\n");
				outputText("\"<i>Heheh, you are a weak little one, you gotta do better dan dat next time,</i>\" he says dropping the rock onto the ground.\n\n");
				outputText("Bested by his toughness, you decide to return home.\n\n");
				zenjiPerspectiveOnPlayer(-4);
				endEncounter();
			}
			else {
				outputText("After some time of holding the rock above your head, your arms begin to grow weary, the rock starting to put a burden on your arms. You look over to the troll who's struggling to support the rock with his arms.\n\n");
				outputText("After a moment he drops to rock to the ground.\n\n");
				outputText("\"<i>Hah... You are tough... tougher dan I expected, I'll let you pass, you can enter,</i>\" he states breathlessly.\n\n");
				zenjiPerspectiveOnPlayer(4);
				part1TrollEncounterRewards();
			}
		}
		public function part1TrollEncounterChallangeSpeed():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You decide that your best chance at besting him would be to challenge your speed against his.\n\n");
			outputText("\"<i>Ahaha, so you tink you can best me at ma speed? I will see just how fast you are.</i>\"\n\n");
			outputText("He leads you to an open clearing in the area, \"<i>Aha, dis be an easy one, all you gotta do is beat me to that tree on the other side.</i>\" He points to the isolated tree just over 50 yards away from you.\n\n");
			outputText("Seems simple enough, you wait for his command, and on his queue, you race over to the tree.\n\n");
			if (player.spe < (135 + (player.newGamePlusMod() * 27))) {
				outputText("You sprint over to the tree as fast as you can, but the troll is obviously much faster than you are, he beats you to the tree by a considerable amount of time.\n\n");
				outputText("\"<i>Heheh, you are a weak little one, try harda next time,</i>\" he says leaning back against the tree.\n\n");
				outputText("Bested by his speed, you decide to return home.\n\n");
				zenjiPerspectiveOnPlayer(-4);
				endEncounter();
			}
			else if (player.spe < (155 + (player.newGamePlusMod() * 31))) {
				outputText("You sprint over to the tree as fast as you can, you stay close to the troll, but he's just faster than you are, it's close, but he beats you to the tree by a few seconds.\n\n");
				outputText("\"<i>Heheh, you are a weak little one, you gotta do better dan dat next time,</i>\" he says leaning back against the tree.\n\n");
				outputText("Bested by his speed, you decide to return home.\n\n");
				zenjiPerspectiveOnPlayer(-4);
				endEncounter();
			}
			else {
				outputText("You sprint over to the tree as fast as you can, you steadily succeed the troll, you're faster than he is and you beat him to the tree.\n\n");
				outputText("\"<i>Hah... Ya fast... faster dan I expected, I'll let you pass, you can enter,</i>\" he says breathlessly.\n\n");
				zenjiPerspectiveOnPlayer(4);
				part1TrollEncounterRewards();
			}
		}
		public function part1TrollEncounterChallangeIntelligence():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You decide that your best chance at besting him would be to challenge your intelligence against his.\n\n");
			outputText("\"<i>Ahaha, so you tink you can best me at ma smarts? I will see just how smart you are.</i>\"\n\n");
			outputText("The troll leads you to into an open clearing within the area, \"<i>To be smart is to know what to do in any situation and de best way to do it, often times it can also be using your smarts ta out tink ya opponent. Look for an opening and use it to ya advantage.</i>\"\n\n");
			outputText("He passes you a branch covered in moss and grabs one for himself too, \"<i>All you gotta do is hit me wit da stick before I hit you.</i>\"\n\n");
			outputText("Seems simple enough, you grab the stick and prepare to duel him on his command.\n\n");
			if (player.inte < (100 + (player.newGamePlusMod() * 20))) {
				outputText("He pauses for a moment and attempts to strike you with the branch, you start by deflecting him, and do your best to deliver an overhead counter strike, but he already saw your attack coming and strikes you from below.\n\n");
				outputText("\"<i>Heheh, you are a weak little one, try harda next time,</i>\" he says, straightening his back.\n\n");
				outputText("Bested by his intelligence, you decide to return home.\n\n");
				zenjiPerspectiveOnPlayer(-4);
				endEncounter();
			}
			else if (player.inte < (125 + (player.newGamePlusMod() * 25))) {
				outputText("He pauses for a moment and attempts to strike you with the branch, you deflect his oncoming attack, but you do not let your guard down, he's ready for you to strike, and you are not so keen on giving him an opening. You wait for his next strike, ready to deflect him, but he fakes you out and strikes you from the other side.\n\n");
				outputText("\"<i>Heheh, you are a weak little one, you've gotta do better dan dat next time,</i>\" he says, straightening his back.\n\n");
				outputText("Bested by his intelligence, you decide to return home.\n\n");
				zenjiPerspectiveOnPlayer(-4);
				endEncounter();
			}
			else {
				outputText("He pauses for a moment and attempts to strike you with the branch, you deflect his oncoming attack. He's quite predictable, read like an open book. He likes to strike and expose your weakness if you go for a counter attack, and his fake outs are easy to notice.\n\n");
				outputText("You wait for a good opening and strike before he lands a hit on you. You manage to hit him before you do, he seems stunned for a moment.\n\n");
				outputText("\"<i>Hah... Ya smart... smarter dan I expected, I’ll let you pass, you can enter,</i>\" he says breathlessly.\n\n");
				zenjiPerspectiveOnPlayer(4);
				part1TrollEncounterRewards();
			}
		}
		public function part1TrollEncounterChallangeWisdom():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You decide that your best chance at besting him would be to challenge your wisdom against his.\n\n");
			outputText("\"<i>Ahaha, so you tink you can best me at ma wisdom? I will see just how wise you are.</i>\"\n\n");
			outputText("The troll leads you to into an open clearing within the area, \"<i>To be wise is to be able to apply your smarts in a situa'tin, it comes wit experience and is not always connected to ya smarts. Wisdom is de experience dat comes wit da knowledge of someting.</i>\"\n\n");
			outputText("He leads you to an area of the swamp covered in moss. \"<i>Ya see dis moss, it be good food, colorful, dries quickly from de inside, poison when dry, see? De bugs love de moss and hide under da rock, whoever can find the most bugs unda one of dese rocks wins.</i>\"\n\n");
			outputText("Seems simple enough, you look over at the many different rocks covered in moss, some small, others large, but each covered in moss.\n\n");
			outputText("\"<i>Say when you're ready, I will see who has de most bugs unda da rock. Trust me, it ain't as easy as it looks.</i>\"\n\n");
			if (player.wis < (115 + (player.newGamePlusMod() * 22))) {
				outputText("You inspect the rocks, it's likely the biggest rock would harbor the most insects, so that would be your best guess. You tell the troll that you're ready to compare results.\n\n");
				outputText("The troll looks over and you flip the rock, but there's hardly anything under the rock, you're surprised that such a large rock harbored such few insects.\n\n");
				outputText("Sure enough, when the troll flips over the rock he's chosen there's far more insects than what was under yours.\n\n");
				outputText("\"<i>Heheh, not the wisest little one, try harda next time,</i>\" he says.\n\n");
				zenjiPerspectiveOnPlayer(-4);
				endEncounter();
			}
			else if (player.wis < (135 + (player.newGamePlusMod() * 27))) {
				outputText("You inspect the rocks, remembering what he said about how the moss can be poisonous if dry, you feel around for the dampest rock, and when you think you've found the best one, you tell the troll that you're ready to compare results.\n\n");
				outputText("The troll looks over and you flip the rock, there are not as many insects as you would've hoped.\n\n");
				outputText("Sure enough, when the troll flips over the rock he's chosen there are noticeably some more bugs than what was under yours.\n\n");
				outputText("\"<i>Heheh, not the wisest little one, you gotta do better dan dat next time,</i>\" he says.\n\n");
				zenjiPerspectiveOnPlayer(-4);
				endEncounter();
			}
			else {
				outputText("You inspect the rocks, remembering what he said about how the moss can be poisonous if dry, you inspect the rocks carefully, making sure to peel the moss back to make sure it's damp all the way through. Once you've found the ideal rock, you tell the troll you're ready to compare results.\n\n");
				outputText("The troll looks over and you flip the rock, there's definitely plenty of insects.\n\n");
				outputText("When the troll flips over the rock he's chosen there are definitely not as many insects as you have under yours.\n\n");
				outputText("\"<i>Hah... ya are quite wise... wiser dan I expected, I'll let you pass, you can enter,</i>\" he says bowing before you.\n\n");
				zenjiPerspectiveOnPlayer(4);
				part1TrollEncounterRewards();
			}
		}
		public function part1TrollEncounterChallangeTakeItEasy():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You eye the troll up and down. Sure, he may be physically imposing... Perhaps it's an ego thing for him to challenge any passersby.\n\n");
			outputText("His gaze focuses on you, \"<i>Have ya made ya mind yet? Don't just stand around. You could bring unwanted attention.</i>\"\n\n");
			outputText("So be it. You'll take the alleged troll on one of his challenges then. Perhaps you'll get a good show out of watching him.\n\n");
			outputText("He hops down from the tree, \"<i>A battle of skill it is den! If you can beat me at my own game, den I’ll let you pass.</i>\"\n\n");
			outputText("He gestures for you to follow him inside, \"<i>So, which will it be, do you prefer to compete against me in a battle of wits, power or speed? I will test you inside, but don't ya go snoopin'.</i>\"\n\n");
			outputText("You shrug, letting him decide on the challenge. After all, you're a guest in his place, it's only fair he decides the method of skill.\n\n");
			outputText("\"<i>Ah, trying to be smart, are ya? Alright, alright.</i>\" He pauses as he surveys his surroundings. He slowly starts to speak up, you’re hardly listening to what he has to say.\n\n");
			switch(rand(5)) {
				case 0:
					outputText("His voice drags on as he leads you a few paces inward. He mentions something about strength, which only leads you to imagine how easy it'd be to best him at something physically demanding.\n\n");
					outputText("It shouldn't be that hard, right? There's no possible way.\n\n");
					outputText("You look up toward a pull up bar and he has already lept up, doing several pullups before you.\n\n");
					outputText("\"<i>Hah, impressed?</i>\" he asks. \"<i>Don't be shy, let's see if ya can hold your weight.</i>\"\n\n");
					outputText("You know you're more than capable, but why not let him have this? Before you grab onto the pull up bar you can't help but stop and admire the chiseled abs hanging right above you.\n\n");
					outputText("He's incredibly fuzzy, yet his abs have incredible definition.\n\n");
					outputText("You direct your attention back to the makeshift pull up bar, leaping up and pulling your weight over his.\n\n");
					outputText("You give it only a few minutes before you get bored of holding yourself up. It seems the troll is slowly starting to wear himself out. Better let him think he has a bigger advantage over you.\n\n");
					outputText("You drop from the bar, feigning defeat. The troll's face widens into a smug grin,");
					break;
				case 1:
					outputText("His voice drags on as he leads you a few paces inward. He mentions something about toughness, which only leads you to imagine how easy it'd be to best him at something that'd really test your endurance.\n\n");
					outputText("It shouldn't be that hard, right? There's no possible way.\n\n");
					outputText("You glance at the troll as he holds onto a rock between his torso and arm as he passes you another, \"<i>Come on, ya gotta hold dis above ya head. See how long ya can last.</i>\"\n\n");
					outputText("Seems oddly simply, yet... You pause for the moment, admiring his thick, chiseled outstretched arm. You can barely see the faint lining of his veins beneath his fur.\n\n");
					outputText("You shrug, grabbing onto the rock and holding it above your head. You hold the position for a few minutes until you start to get bored. It seems the troll is starting to wear himself out, better give in while he still has his ego.\n\n");
					outputText("You drop the rock to the ground, feigning exhaustion as the troll tosses his rock with a smug grin plastered across his face,");
					break;
				case 2:
					outputText("His voice drags on as he leads you a few paces inward. He mentions something about speed, which only leads you to imagine how easy it'd be to best him at something that truly calls for quick timing.\n\n");
					outputText("It shouldn't be that hard, right? There's no possible way.\n\n");
					outputText("You glance at the troll as he gestures toward a tree before stretching down to draw a line in the grass.\n\n");
					outputText("You pause for a moment to admire his... taut... strong back"+(silly()?" and well, like his ass, obviously, but that was IMPLIED!":".")+"\n\n");
					outputText("He turns toward you, \"<i>One lap. Back and forth, ready?</i>\"\n\n");
					outputText("Oh, already? You wait for his queue.\n\n");
					outputText("The two of you race for the tree, yet you remain only paces behind him. You like admiring his form. He's lean, but noticeably built. So perfectly chiseled. It's honestly rather beautiful.\n\n");
					outputText("The distance between the two of you widens as he passes you with a taunting grin as he runs back to the start.\n\n");
					outputText("You roll your eyes, you're not even trying, but you let him have his fun.\n\n");
					outputText("You finally return to the finish as the troll has his arms stretched into a smug shrug,");
					break;
				case 3:
					outputText("His voice drags on as he leads you a few paces inward. He mentions something about smarts, which only leads you to imagine how easy it'd be to best him at something that calls for true intellect.\n\n");
					outputText("It shouldn't be that hard, right? There's no possible way.\n\n");
					outputText("He tosses you a moss covered branch as he explains the rules. You only partially pay attention, focusing more on his pectorals right in front of your face. They bounce and shift slightly with the movements of his arms as he shows a few demonstrations with his makeshift pole.\n\n");
					outputText("\"<i>All you gotta do is hit me wit da stick before I hit you.</i>\"\n\n");
					outputText("Oh, this is just too easy, but you'll let him win this one. You ready a defensive stance with the stick as he readies himself as well.\n\n");
					outputText("He pauses before giving you a nod, signaling that the game begins. You don't bother, fixating on his almost overwhelming masculinity before you. You're only in it for the inadvertent show he's giving you anyhow.\n\n");
					outputText("You give a half attempt to hit him as he parries your strike and jabs you with his branch.\n\n");
					outputText("He drops his stick, giving you a smug grin,");
					break;
				case 4:
					outputText("His voice drags on as he leads you a few paces inward. He mentions something about wisdom, which only leads you to imagine how easy it'd be to best him at something that calls for a true test of wit.\n\n");
					outputText("It shouldn't be that hard, right? There's no possible way.\n\n");
					outputText("You gaze at several moss covered rocks within the bog before turning your attention back to him. You only partially pay attention, focusing more on his arms right in front of your face. His biceps and triceps are huge, and clearly defined. They shift and bounce slightly while he moves his arms, explaining the rules of the game.\n\n");
					outputText("\"<i>Say when you're ready, I will see who has de most bugs unda da rock. Trust me, it ain't as easy as it looks.</i>\"\n\n");
					outputText("Whatever, you'll let him go first and you'll kick over the nearest rock. It's not like it's worth putting in any effort anyway.\n\n");
					outputText("The troll meanders through the rubble, inspecting the rocks but not flipping them over.\n\n");
					outputText("He glances toward you, signaling that he's made his decision.\n\n");
					outputText("You kick over the nearest rock, it's hardly covered in moss. Not a single insect.\n\n");
					outputText("The troll snickers softly as he flips over his rock, several insects crawl beneath.\n\n");
					outputText("He gives a smug shrug,");
					break;
			}
			outputText(" \"<i>Hah, I knew I'd win. How'd ya like dat?</i>\"\n\n");
			outputText("You give him a few claps, applauding his skill to reinforce his ego.\n\n");
			outputText("\"<i>Yeah, dat's right. Now, get outta here, I'm done wit dese games. Come back when you're better at dis!</i>\"\n\n");
			outputText("Oh, maybe you will... It's almost endearing to watch his ego inflate.\n\n");
			zenjiPerspectiveOnPlayer(-6);
			endEncounter();
		}

		public function part1TrollEncounterSex():void {
			outputText("You eye him once more, he's tall, easily standing over 8 feet, he's only dressed in a loin cloth and some fur bracers as the rest of his muscular body is covered in light green fuzz. It could be worse, his chiseled face definitely is rather handsome.\n\n");
			outputText("You take him on his offer and decide that you're willing to pay his toll with your body.\n\n");
			outputText("\"<i>Ehhh, what?</i>\" He raises an eyebrow at you, \"<i>Now, now, don't be hasty, I didn' offer dat.</i>\"\n\n");
			outputText("You're not sure what to say, he's actually declining an offering for sex?\n\n");
			outputText("\"<i>Ya know, you really are bold, I'll tell ya what,</i>\" he says as he hops off the tree, \"<i>If you can best me in one of the challenges of my choosing, I’ll let ya pass, it's a good deal, no?</i>\"\n\n");
			menu();
			addButton(1, "Challenge?", part1TrollEncounterChallange);
			addButton(3, "Leave", part1TrollEncounterLeave);
		}

		public function part1TrollEncounterPayWithGems():void {
			player.gems -= 25;
			outputText("You pull out 25 gems from your gem pouch as you do so he hops down from the tree. He holds out a four-fingered palm, awaiting your payment and you fork the gems over. The entire time he looks directly into your eyes, but at the same time there seems to be a tinge of disappointment within his.\n\n");
			outputText("As you enter the opening in the bog you search around the area and wonder what makes it so special that he wanted to guard it against you.\n\n");
			part1TrollEncounterRewards();
		}

		public function part1TrollEncounterRewards():void {
			var event:Number = rand(10);
			var itype:ItemType;
			if(event < 2) itype = consumables.REPTLUM;
			else if(event < 4) itype = consumables.REDUCTO;
			else if(event < 6) itype = consumables.GROPLUS;
			else if(event < 8) itype = consumables.COAL___;
			else if(event < 10) itype = useables.T_SSILK;
			outputText("You spend some more time looking around the area and stumble upon " + itype.shortName + ".\n\n");
			outputText("You decide to head back home afterwards as there doesn't appear to be anything else of interest right now.\n\n");
			inventory.takeItem(itype, explorer.done);
		}

		//PART 2

		public function part2TrollEncounterFirst():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("As you are maneuvering your way through the dense bog, careful not to let the wildlife best you at your adventure, you hear a familiar voice ring through the trees.\n\n");
			outputText("\"<i>Ahaha! It’s you again! Welcome, welcome!</i>\" A male voice rings through the thicket and a familiar troll leaps down from the trees, \"<i>Me temo que no nos hemos presentado adecuadamente.</i>\"\n\n");
			outputText("He holds a hand over his chest. \"<i>Me llamo Zenji, and who am I gifted ta meet again once more?</i>\" he says leaning close and raising an eyebrow toward you.\n\n");
			outputText("You state your name.\n\n");
			if (player.cor >= 50 + player.corruptionTolerance) outputText("enji gives you a sideways glance, almost as if he doesn't trust you. \"<i>If dat is de truth, it's nice ta meet you, [name]</i>\"\n\n");
			else outputText("\"<i>Ahah, [name], so dat is your name, a pleasure ta get to really know ya.</i>\" He replies.\n\n");
			outputText("\"<i>So, you've been around here a lot, I see, what really brings ya here? Why do you like de bog enough ta come here all de time?</i>\" He asks the question, seeking a response, but before you can even answer he's already cut you off. \"<i>It don' really matta, it's been a while since I had some good company, ya know? I mean, I know you know dat I am not de only troll out here, but dey don't come dis far from de outskirts of our land like I do.</i>\" ");
			outputText("He states, \"<i>Dey're all a buncha cowards and liars. Afraid of what really is out der, afraid of competition, but I like a good challenge, ya see?</i>\"\n\n");
			if (flags[kFLAGS.ZENJI_PROGRESS] == 4) {
				outputText("\"<i>So I ask ya, I want ta fight ya, not to de death, or out of malice, but I want ta see how good you can put up fo' ya self. Ya in? Cause I won't ask for dis again.</i>\"\n\n");
				menu();
				addButton(1, "Fight", part2TrollEncounterFirstFight);
				addButton(3, "Decline", part2TrollEncounterFirstDecline);
			}
			else {
				flags[kFLAGS.ZENJI_PROGRESS] = 6;
				outputText("Zenji smirks, \"<i>And ya really put up a fight last time, I can see the fire in ya eyes, so I want ta know if ye be willing ta face me again, or do ya want to practice some training wit me ta become stronga?</i>\"\n\n");
				menu();
				addButton(1, "Fight", part2TrollEncounterFirstFight);
				addButton(2, "Train", part2TrollEncounterTrain);
				addButton(3, "Leave", part2TrollEncounterLeave);
			}
		}

		public function part2TrollEncounterFirstDecline():void {
			flags[kFLAGS.ZENJI_PROGRESS] = -1;
			outputText("\"<i>Ah, so be it den, I shall go somewhere else for a real challenge, all I see here are cowards.</i>\" Zenji leans back and climbs on top of a nearby tree, he quickly vanishes into the canopy where you can't see him anymore.\n\n");
			endEncounter();
		}

		public function part2TrollEncounterFirstFight():void {
			if (flags[kFLAGS.ZENJI_PROGRESS] < 5) flags[kFLAGS.ZENJI_PROGRESS] = 5;
			outputText("If he really wants a fight, then so be it, who knows, it could be fun after all.\n\n");
			startCombat(new Zenji());
			doNext(playerMenu);
		}

		public function part2TrollEncounterFirstFightPCDefeated():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			zenjiPerspectiveOnPlayer(-12);
			if (flags[kFLAGS.ZENJI_PROGRESS] < 6) flags[kFLAGS.ZENJI_PROGRESS] = 6;
			outputText("\"<i>Ahah... So... dat's why ya didn' want ta fight? Perhap I shouldn’ta fought so hard on ya... Forgive me, I just didn' expect someone out here in de bog to be so weak.</i>\" He shakes his head, \"<i>Ya be safe now, I don' want ya ta get hurt out dere.</i>\"\n\n");
			cleanupAfterCombat();
		}

		public function part2TrollEncounterFirstFightZenjiDefeated():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			zenjiPerspectiveOnPlayer(12);
			if (flags[kFLAGS.ZENJI_PROGRESS] < 6) flags[kFLAGS.ZENJI_PROGRESS] = 6;
			outputText("\"<i>Hah...</i>\" He chuckles, out of breath, \"<i>Ya put up a strong fight, I can see da fire in ya eyes. I tink we can train more later, but I need a moment...</i>\" Zenji sits down by a tree, pressing his back against it. \"<i>I just need a moment ta rest, ya go off now, I will still be here later.</i>\"\n\n");
			outputText("You make your way back to camp as the troll takes a moment to rest.\n\n");
			cleanupAfterCombat();
		}

		public function part2TrollEncounterRepeat():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("As you are traversing in the bog, you note that you’re near the clearing where Zenji usually resides.\n\n");
			outputText("It doesn't take long until he hops down to greet you, seemingly out of nowhere.\n\n");
			if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] <= 30) {
				outputText("\"<i>It’s you again, [name], my friend.</i>\" Zenji welcomes, but there’s concern in his words, \"<i>I… I kinda missed you… Are ya doing well? Maybe… Er… I guess we can still train or spar..?</i>\"\n\nZenji seems very unsure of his words as if he wants to offer something else but refuses to. He shakes his head as if to clear a thought from his mind as he returns to a more neutral stance.\n\n");
			}
			else outputText("\"<i>Ah, [name],</i>\" he welcomes, \"<i>What brings ya here? Didja want to train or perhaps go for anoda sparring match?</i>\"\n\nYou consider the few options, it appears he doesn’t want to talk about anything else.\n\n");
			menu();
			addButton(1, "Fight", part2TrollEncounterRepeatFight);
			addButton(2, "Train", part2TrollEncounterTrain);
			if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] <= 30) addButton(3, "Talk", part2TrollEncounterTalk);
			addButton(4, "Leave", part2TrollEncounterLeave);
		}

		public function part2TrollEncounterLeave():void {
			outputText("You tell Zenji that you are not in the mood for sticking around with him at the moment.\n\n");
			outputText("\"<i>Eh? Then whatcha here for? Go on den, no reason to stay if ya don' wanna be here.</i>\"\n\n");
			endEncounter();
		}

		public function part2TrollEncounterTalk():void {
			outputText("Zenji seems hesitant while near you, perhaps there’s something he wants to talk about?\n\n");
			outputText("You continue to eye him, causing his stoic exterior to collapse again. \"<i>[name], is everything alright? I just…</i>\"\n\n");
			outputText("You assure him that you’re feeling fine.\n\n");
			outputText("\"<i>I know, it’s just dat I keep thinking about you, and it’s just… Are you doing okay? You seem so… I just want you to be safe out there.</i>\"\n\n");
			outputText("You assure him that you’re fine, why is he so worried about you?\n\n");
			outputText("Zenji’s tail coils around his leg nervously, \"<i>It’s… Just… No, I mean… If you ever need anything... I’ll be here...</i>\"\n\n");
			outputText("He seems a little… unsure? About himself? There’s something he’s keeping away from you, but for the time being, you decide not to press the issue. Zenji seems very conflicted with his emotions.\n\n");
			outputText("You decide to head back to your camp, but you’re halted by Zenji touching your shoulder.\n\n");
			outputText("He quickly jumps back, his gaze slowly shying away from you, \"<i>Just… Be careful out dere…</i>\"\n\n");
			zenjiPerspectiveOnPlayer(-3);
			endEncounter();
		}

		public function part2TrollEncounterRepeatFight():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("\"<i>Ahaha, I was hoping ya be willing to put up anoda fight, be ready now.</i>\"\n\n");
			startCombat(new Zenji());
			doNext(playerMenu);
		}

		public function part2TrollEncounterRepeatFightPCDefeated():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (player.HP <= player.minHP()) {
				if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] < 30) outputText("\"<i>[name]... Are you okay..? Would it help if I went easier? You don’ have ta fight me if you aren’t ready… Please, get some rest.</i>\"\n\n");
				else outputText("\"<i>Das all ya got?</i>\" Zenji shakes his head, \"<i>Ya gotta try harder dan dat next time. Ya be safe out dere now.</i>\"\n\n");
				zenjiPerspectiveOnPlayer(-4);
			}
			else {
				if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] < 30) {
					outputText("Zenji blushes, noticing your apparent arousal, \"<i>[name]... Do… Do you like me…? ¿Es mi jale tan fuerte?</i>\"\n\n");
					outputText("He spends a moment standing completely still, giving you a flustered glance, \"<i>I… I need t’ go, I’m sorry…</i>\"\n\n");
					outputText("Zenji leaves you alone with your lust, it looked as if he wanted to say something but was too afraid to.\n\n");
				}
				else outputText("\"<i>Uh… Geez, I’ve been told I am handsome by de chameleon girl, but...</i>\" Zenji shakes his head, \"<i>Yeah, Im gonna act like dis didn’t happen.</i>\"\n\n");
				zenjiPerspectiveOnPlayer(-2);
			}
			cleanupAfterCombat();
		}

		public function part2TrollEncounterRepeatFightZenjiDefeated():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			zenjiPerspectiveOnPlayer(4);
			outputText("\"<i>Hah... ya be strong I say, go on now, I just need a moment to rest before I see you again.</i>\"\n\n");
			outputText("Zenji leans back against a tree and sits down, he rubs his hands along his tusks as if they were sore from combat.\n\n");
			cleanupAfterCombat();
		}

		public function part2TrollEncounterTrain():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("\"<i>So ya want ta train wit me? All right, It’s been a while from da last time someone want ta train wit me. Whatcha wanna do?</i>\"\n\n");
			menu();
			addButton(1, "Strength", part2TrollEncounterTrainStrength);
			addButton(2, "Toughness", part2TrollEncounterTrainToughness);
			addButton(3, "Speed", part2TrollEncounterTrainSpeed);
		}

		public function part2TrollEncounterTrainStrength():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("Zenji leads you over to a pile of rocks of different shapes and sizes.\n\n");
			outputText("\"<i>Ya may remember da challenge I put up against ya, it not be hard ta practice and become stronga, all you gotta do is prepare ya self for your next task and ta overcome it.</i>\" He guides you to a pull up bar that he presumably crafted himself.\n\n");
			outputText("\"<i>Keep ya hand ova da bar or unda it, you pick, but I want ya to pull yourself ova the bar as many times as you can, try to go for as many as ya can.</i>\"\n\n");
			outputText("You decide to try your hardest at doing as many pull-ups as you can, the Troll has a bar that he practices on as well.\n\n");
			if (player.fatigue > player.maxOverFatigue() * 0.5) {
				outputText("You try to do as many pull-ups as you can, but your tired arms can't support you, and you are worn out after barely doing one.\n\n");
				if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] < 30) outputText("\"<i>Are... are sure you’re okay? Dere's... You don' have ta train wit me if ya don' wanna. Dere's oda ways to...</i>\" Zenji shakes his head, \"<i>Ya should go home and get some rest, I'll tink of sometin lata.</i>\"\n\n");
				else outputText("\"<i>Das all ya got? Maybe dere's an easier ting I got next time, ya should go home and rest for a moment so I can prepare for next time.</i>\"\n\n");
				player.fatigue += Math.round(player.maxOverFatigue() * 0.2);
				zenjiPerspectiveOnPlayer(-3);
			}
			else {
				outputText("Some time passes and you can't do anymore, but you feel that this exercise was worth the effort and return to camp after dismissing yourself.\n\n");
				player.trainStat("str",2,player.trainStatCap("str",90));
				player.fatigue += Math.round(player.maxOverFatigue() * 0.35);
				zenjiPerspectiveOnPlayer(3);
			}
			endEncounter();
		}

		public function part2TrollEncounterTrainToughness():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("Zenji leads you over to a pile of rocks of different shapes and sizes.\n\n");
			outputText("\"<i>Ya may remember da challenge I put up against ya, toughness is not about being strong, it about endurance, and tenathity, how much can ya take before ya break?</i>\" He guides you to a pile of rocks.\n\n");
			outputText("\"<i>Don't actually break yaself, dis is for training. All I want you ta do is start by stretching, ya don't want ta hurt yaself, do ya?</i>\" He extends his arm over himself and repeats with the other arm, stretching himself as far out as he can, you follow in his lead. \"<i>Now, follow my lead.</i>\"\n\n");
			outputText("Zenji lowers himself to the ground and begins planking, \"<i>Simple, no? Keep dis stance until ya can't take it anymore, endure it, don't break unda de pressure.</i>\"\n\n");
			if (player.fatigue > player.maxOverFatigue() * 0.5) {
				outputText("You try to hold the plank for as long as you can, but you feel too weak to hold it much longer than nearly half a minute and collapse to the ground.\n\n");
				if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] < 30) outputText("\"<i>Are... are sure you’re okay? Dere's... You don' have ta train wit me if ya don' wanna. Dere's oda ways to...</i>\" Zenji shakes his head, \"<i>Ya should go home and get some rest, I'll tink of sometin lata.</i>\"\n\n");
				else outputText("\"<i>Dat’s all ya got? Maybe dere's an easier ting I got next time, ya should go home and rest for a moment so I can prepare for next time.</i>\"\n\n");
				player.fatigue += Math.round(player.maxOverFatigue() * 0.2);
				zenjiPerspectiveOnPlayer(-3);
			}
			else {
				outputText("You begin planking, a few minutes pass and your arms start feeling weak, you figure you've been planking for enough time and relax. You feel that the exercise was worth the time and return to camp after dismissing yourself.\n\n");
				player.trainStat("tou",1,player.trainStatCap("tou",90))
				player.fatigue += Math.round(player.maxOverFatigue() * 0.35);
				zenjiPerspectiveOnPlayer(3);
			}
			endEncounter();
		}

		public function part2TrollEncounterTrainSpeed():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("Zenji leads you to a clearing in the bog, it's a more open area, ideal for an exercise that requires space.\n\n");
			outputText("\"<i>Ya may remember da challenge I put up against ya, it not be hard ta practice and work on ya speed, train and aim for da goal, each time a little quicka dan before.</i>\" He guides you to the edge of the clearing. \"<i>Ya see dat tree ova der? All you gotta do is make good speed from here ta der. Ya don't have ta go too fast, just ta make yaself feel da effort.</i>\"\n\n");
			if (player.fatigue > player.maxOverFatigue() * 0.5) {
				outputText("You start at a slow pace, sure that you can work up slowly from there.\n\n");
				outputText("\"<i>Dat's ya top speed? Come on, ya can afford a little more dan dat.</i>\"\n\n");
				outputText("You're unsure if you can go much faster in your fatigued state and tell him so.\n\n");
				if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] < 30) outputText("\"<i>Are... are sure you’re okay? Dere's... You don' have ta train wit me if ya don' wanna. Dere's oda ways to...</i>\" Zenji shakes his head, \"<i>Ya should go home and get some rest, I'll tink of sometin lata.</i>\"\n\n");
				else outputText("\"<i>Das all ya got? Maybe dere's an easier ting I got next time, ya should go home and rest for a moment so I can prepare for next time.</i>\"\n\n");
				player.fatigue += Math.round(player.maxOverFatigue() * 0.2);
				zenjiPerspectiveOnPlayer(-3);
			}
			else {
				outputText("You begin at a brisk pace, jogging from the tree and back to Zenji.\n\n");
				outputText("\"<i>Das a good start, try ta go fasta each time.</i>\"\n\n");
				outputText("You jog back and forth with the troll, making sure to keep a good pace. You feel that the exercise was worth the time and return to camp after dismissing yourself.\n\n");
				player.trainStat("spe",2,player.trainStatCap("spe",90));
				player.fatigue += Math.round(player.maxOverFatigue() * 0.35);
				zenjiPerspectiveOnPlayer(3);
			}
			endEncounter();
		}

		//ZENJI FOLLOWER

		public function followerZenjiFirstTimeOffer():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("As you are wandering through the dense bog, a familiar voice rings through the trees, you immediately recognize it as Zenji the troll as he jumps down from a tree.\n\n");
			outputText("\"<i>Ahahah! It is you again! Welcome friend! I hoped ta see ya again, ya be a worthy ally in training and fighting.</i>\" He exclaims. \"<i>Listen, I was wondering if you are willing to let me accompany ya back in ya home? Dis bog... not really a good place ta keep home, all dem phouka keep messing wit ma stuff no matter how many times I give 'em a lesson. I will make it worth ya while, I will show you a special technique for training yaself even betta.</i>\"\n\n");
			outputText("You think for a moment, do you want to move the troll to your camp to have easier access to your trainer?\n\n");
			menu();
			addButton(1, "Yes", followerZenjiOfferYes);
			addButton(3, "No", followerZenjiOfferNo);
		}

		public function followerZenjiRepeatOffer():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("\"<i>[name] Good ta see ya... Did you want me to join your camp... or just here ta train?</i>\"\n\n");
			menu();
			addButton(1, "Fight", part2TrollEncounterRepeatFight);
			addButton(2, "Train", part2TrollEncounterTrain);
			addButton(4, "Leave", part2TrollEncounterLeave);
			addButton(7, "Yes", followerZenjiOfferYes);
		}

		public function followerZenjiOfferNo():void {
			outputText("You tell Zenji that you don't want him to hang out around your camp.\n\n");
			outputText("\"<i>Ah, dat is a shame, if ya don't want ta, I undastand, I still got all dis land to maself at least.</i>\"\n\n");
			flags[kFLAGS.ZENJI_PROGRESS]++;
			endEncounter();
		}

		public function followerZenjiOfferYes():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you would enjoy having him around your camp.\n\n");
			outputText("\"<i>Ahaha! Da's great, Lead da way, I’ll be right behind ya.</i>\"\n\n");
			outputText("Upon entering your camp, Zenji looks around curiously, \"<i>Some place ya got here, I'll be settled on ma own, don't worry.</i>\"\n\n");
			outputText("<b>Zenji has joined you as a follower.</b>\n\n");
			player.createStatusEffect(StatusEffects.ZenjiTrainingsCounters1,0,0,0,0);
			player.createStatusEffect(StatusEffects.ZenjiTrainingsCounters2,0,0,0,0);
			flags[kFLAGS.ZENJI_PROGRESS] = 8;
			endEncounter();
		}

		public function followerZenjiMainCampMenu():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You approach Zenji, he looks up at you while you approach, raising an eyebrow.\n\n");
			menu();
			addButton(0, "Appearance", followerZenjiMainCampMenuAppearance).hint("Examine Zenji.");
			addButton(1, "Talk", followerZenjiTalks).hint("Talk to Zenji.");
			if (player.lust > 33) addButton(2, "Sex", followerZenjiSex).hint("Perhaps the hunk could be open to share an intimate moment with you.");
			if (CorruptedGlade.canBeDestroyed()) addButton(3, "Glades", followerZenjiGlades).hint("Ask Zenji for help in destroying the corrupted glades.");
			addButton(4, "Training", followerZenjiMainCampMenuTraining).hint("Train with Zenji to increase your stats.");
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) addButton(5, "Spar", followerZenjiSpar).hint("Spar with Zenji.");
			else addButtonDisabled(5, "Spar", "You can spar with him, but you need to build a sparring ring first!");
			addButton(14, "Leave", followerZenjiMainCampMenuLeave);
		}

		public function followerZenjiMainCampMenuAppearance():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("Zenji is a troll to your knowledge, at least that’s what he calls himself.\n\n");
			outputText("He is 8’2\", covered head to toe in green fur, the top of his head is crowned with a shaggy, pale green mohawk. All things considered, his face is rather handsome, with good symmetry, strong brows and a chiseled jawline. He has deep set eyes with ashen green irises. His nose is pronounced and elongated. As your eyes wander down his face, you can see 2 ivory tusks protrude from his mouth, each about 7 inches long, his left tusk is covered in a series of rings hanging from the tip to the midsection. ");
			outputText("Between those tusks his lower two canines stick out slightly past his lips. Darker colored hair wraps around his mouth, emphasizing the scruffy beard that covers his lower face. His beard is fairly dense, you could easily get your fingers lost beneath it. His ears are long and pointed, similar to that of an elf, fuzzy like the rest of him.\n\n");
			outputText("Zenji’s physique is imposing, chiseled and very muscular. He wears a beaded necklace over his neck. He has broad shoulders with long, very muscular and toned arms that extend past his waist. His arms are human shaped with large four fingered hands. His elbows are covered in darker colored hair that hangs out slightly. He wears fur bracers that cover his wrists. He has 2 manly pecs with a tuft of hair sticking out between them. His midriff is covered in fuzz, hiding his abs.\n\n");
			outputText("He currently is only wearing a loincloth over his waist, tied by an animal fur pelt as his fur covers his entire body. Sprouting from the base of his spine is a long, fuzzy tail at least 3 feet long with a large tuft of fur at the tip. Beneath that, he has 2 long, muscular legs that ends in four toed, furry feet.\n\n");
			outputText("Zenji peers at you while you examine him.\n\n");
			menu();
			addButton(14, "Back", followerZenjiMainCampMenu);
		}

		public function followerZenjiMainCampMenuTraining():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("Zenji is a troll to your knowledge, at least that’s what he calls himself.\n\n");
			if (player.fatigue >= player.maxOverFatigue() * .75) {
				outputText("Zenji shakes his head, \"<i>[name], go get some rest, ya look exhausted, and it’s neva a good idea ta hurt yaself. Even a trained mind will struggle ta concentrate when tired.</i>\"\n\n");
				menu();
				addButton(14, "Back", followerZenjiMainCampMenu);
			}
			else {
				outputText("Zenji nods, \"<i>Glad ta help, [name]. Just tell me whatcha wanna do.</i>\"\n\n");
				menu();
				addButton(0, "Strength", followerZenjiMainCampMenuTrainingStrength);
				addButton(1, "Toughness", followerZenjiMainCampMenuTrainingToughness);
				addButton(2, "Speed", followerZenjiMainCampMenuTrainingSpeed);
				addButton(3, "Intelligence", followerZenjiMainCampMenuTrainingIntelligence);
				addButton(4, "Wisdom", followerZenjiMainCampMenuTrainingWisdom);
			}
		}

		public function followerZenjiMainCampMenuTrainingStrength():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you want his help to become stronger.\n\n");
			outputText("\"<i>Strength is mostly about physical power, but not all power is from de muscles. If you can’t carry your own weight, den you wont be able to surmount de weight of anotha task.</i>\" Zenji says as he leads you over to a pile of rocks of different shapes and sizes.\n\n");
			outputText("\"<i>Ya may remember da challenge I put up against ya. It wont be hard ta practice and become stronga. All you gotta do is prepare yaself for your next task and ta overcome it.</i>\" He guides you to a pull up bar that he presumably crafted himself.\n\n");
			outputText("\"<i>Keep ya hand ova da bar or unda it, you pick, but I want ya to pull yourself ova the bar as many times as you can, try to go for as many as ya can.</i>\"\n\n");
			outputText("You decide to try your hardest at doing as many pull-ups as you can, the Troll has a bar that he practices on as well, he helps guide you on good form as he trains with you.\n\n");
			outputText("Once you’re done, you feel that this exercise was worth the effort. You thank Zenji before dismissing yourself.\n\n");
			if (player.statusEffectv1(StatusEffects.ZenjiTrainingsCounters1) < 3) player.addStatusValue(StatusEffects.ZenjiTrainingsCounters1, 1, 1);
			player.trainStat("str",(4 - player.statusEffectv1(StatusEffects.ZenjiTrainingsCounters1)),player.trainStatCap("str",100));
			outputText(player.modTone(player.maxToneCap(), 1));
			player.fatigue += Math.round(player.maxOverFatigue() * 0.2);
			followerZenjiMainCampMenuTrainingPerks();
			endEncounter();
		}

		public function followerZenjiMainCampMenuTrainingToughness():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you want his help to become tougher.\n\n");
			outputText("\"<i>Toughness is mostly about endurance. To withstand and remain, othawise you will break when put unda stress.</i>\" Zenji says as he leads you over to a pile of rocks of different shapes and sizes.\n\n");
			outputText("\"<i>Ya may remember da challenge I put up against ya, toughness is not about being strong, it about endurance, and tenathity, how much can ya take before ya break?</i>\" Zenji says as he guides you to a pile of rocks.\n\n");
			outputText("\"<i>Don't actually break yaself, dis is for training. All I want you ta do is start by stretching, ya don't want ta hurt yaself, do ya?</i>\" He extends his arm over himself and repeats with the other arm, stretching himself as far out as he can, you follow in his lead. \"<i>Now, follow my lead.</i>\"\n\n");
			outputText("Zenji lowers himself to the ground and begins planking, \"<i>Simple, no? Keep dis stance until ya can't take it anymore, endure it, don't break unda de pressure.</i>\"\n\n");
			outputText("You begin planking, a few minutes pass and your arms start feeling weak. Zenji helps you and planks beside you, teaching you about endurance, form and technique.\n\n");
			outputText("Once you’re done you feel that the exercise was worth the time. You thank Zenji before dismissing yourself.\n\n");
			if (player.statusEffectv2(StatusEffects.ZenjiTrainingsCounters1) < 3) player.addStatusValue(StatusEffects.ZenjiTrainingsCounters1, 2, 1);
			player.trainStat("tou",(4 - player.statusEffectv2(StatusEffects.ZenjiTrainingsCounters1)),player.trainStatCap("tou",100));
			outputText(player.modThickness(0, 1));
			outputText(player.modTone(player.maxToneCap(), 1));
			player.fatigue += Math.round(player.maxOverFatigue() * 0.2);
			followerZenjiMainCampMenuTrainingPerks();
			endEncounter();
		}

		public function followerZenjiMainCampMenuTrainingSpeed():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you want his help to become quicker.\n\n");
			outputText("\"<i>Speed is mostly about de ability ta remain quick on ya feet, agile and ready ta make ya next move.</i>\" Zenji says as he leads you to a clearing in the camp, it's a more open area, ideal for an exercise that requires space.\n\n");
			outputText("\"<i>Ya may remember da challenge I put up against ya, it not be hard ta practice and work on ya speed, train and aim for da goal, each time a little quicka dan before.</i>\" He guides you to the edge of the clearing. \"<i>Ya see dat tree ova der? All you gotta do is make good speed from here ta der. Ya don't have ta go too fast, just ta make yaself feel da effort.</i>\"\n\n");
			outputText("You begin at a brisk pace, jogging from the tree and back to Zenji.\n\n");
			outputText("\"<i>Dats a good start, try ta go fasta each time.</i>\"\n\n");
			outputText("You jog back and forth with the troll, making sure to keep a good pace. Zenji soon joins you and instructs you on good form and technique.\n\n");
			outputText("Once you’re done, you feel that the exercise was worth the time. You thank Zenji before dismissing yourself.\n\n");
			if (player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters1) < 3) player.addStatusValue(StatusEffects.ZenjiTrainingsCounters1, 3, 1);
			player.trainStat("spe",(4 - player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters1)),player.trainStatCap("spe",100));
			outputText(player.modThickness(0, 1));
			player.fatigue += Math.round(player.maxOverFatigue() * 0.2);
			followerZenjiMainCampMenuTrainingPerks();
			endEncounter();
		}

		public function followerZenjiMainCampMenuTrainingIntelligence():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you want his help to become smarter.\n\n");
			outputText("Zenji gestures for you to sit down with him. \"<i>Intelligence is about sharpness of mind, de ability ta focus ya efforts into a single or many tasks and your ability ta do dem.</i>\"\n\n");
			outputText("Zenji grabs a flat rock from nearby. \"<i>Keep dis on ya head, don’t let it fall.</i>\"\n\n");
			outputText("You follow his instructions and place the flat rock on your head, shifting around slightly until you feel it’s stable on the top of your head.\n\n");
			outputText("\"<i>A smart person knows deir limits and what dey’re capable of. But dey also know dat it may not be easy ta do everyting. Consider what needs ta be done first, but know what you are capable of doing.</i>\"\n\n");
			outputText("Zenji stands up, but he gestures for you to remain seated. After a moment he returns with a book. You can’t say you actively see him read, but he must have some way he’s gotten his intelligence.\n\n");
			outputText("\"<i>I wantcha ta read dis, not de entire ting, just dis page,</i>\" he says as he opens the book for you.\n\n");
			outputText("You being looking over the page, it’s about somatic components for casting spells and ways to strengthen spells as you cast them. As you read the page, you almost forget about the rock you’re trying to support. You quickly catch yourself and keep it up before it slips down. Is this what he was talking about with knowing your limits?\n\n");
			outputText("\"<i>Now, I want ya ta focus your mind, try ta focus some magic into your hands.</i>\"\n\n");
			outputText("You focus your efforts into conjuring a spell with some help from the book all while keeping the stone balanced on top of your head. You take a deep breath, but it’s not terribly difficult, even if you have to constantly shift your head to keep the stone steady. The magic you’re trying to conjure is unstable as you’re trying to focus your efforts in keeping the stone stead.\n\n");
			outputText("\"<i>Focus, [name], ya gotta keep dese tasks steady and unda control.</i>\"\n\n");
			outputText("Once you feel the rhythm and find a good balance with the stone, the magic you’ve conjured steadies and Zenji applauds.\n\n");
			outputText("\"<i>Strength of mind requires balance and strategy. Know your limits and how much you are capable of.</i>\"\n\n");
			if (player.statusEffectv1(StatusEffects.ZenjiTrainingsCounters2) < 3) player.addStatusValue(StatusEffects.ZenjiTrainingsCounters2, 1, 1);
			player.trainStat("int",(4 - player.statusEffectv1(StatusEffects.ZenjiTrainingsCounters2)),player.trainStatCap("int",100));
			player.fatigue += Math.round(player.maxOverFatigue() * 0.2);
			followerZenjiMainCampMenuTrainingPerks();
			endEncounter();
		}

		public function followerZenjiMainCampMenuTrainingWisdom():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you want his help to become wiser.\n\n");
			outputText("Zenji gestures for you to sit down with him. \"<i>Wisdom is about de application of knowledge and de ability ta keep ya senses intact. A smart person is not always a wise person. If ya don’t know how ta use de smarts ya have, den it will not be of good use ta you.</i>\"\n\n");
			outputText("Zenji holds out a small ball of energy within his hands. \"<i>Now, I may not be de best magic user, or use it very often, but magic and mental strength are closely related.</i>\"\n\n");
			outputText("Zenji instructs you to hold out your hand as well and you follow his teachings.\n\n");
			outputText("\"<i>Now concentrate, [name], Tink about de power ya have witin yaself."+(spellBookButtons.length < 3 ? " I know ya have some magic witin yaself, even if ya don’ know it.":"")+"</i>\"\n\n");
			outputText("You focus your efforts into conjuring a ball of magic energy within your palm.\n\n");
			outputText("\"<i>Good, good, [name]. Keep dat up. I want ya ta concentrate on dat energy.</i>\" Zenji says as he stands up. \"<i>No matta what happens, keep ya mind focused on concentrating onto dat energy.</i>\"\n\n");
			outputText("You hear rustling as a shower of leaves falls from above you, presumably from Zenji in an attempt to distract you.\n\n");
			outputText("You keep your mind focused, remaining calm and collected.\n\n");
			outputText("Suddenly you feel a quick gust of wind as a spear lands only inches away from you, impaling the ground. You almost flinch, which would break your channeled spell, but your mind was so concentrated on holding onto the energy that you don’t break focus.\n\n");
			outputText("\"<i>Well done, [name]. Keep dat keenness and focus of mind.</i>\" Zenji says with small applause.\n\n");
			outputText("\"<i>Remember everting you’ve learned, wisdom is about how ya use de knowledge ya have.</i>\"\n\n");
			if (player.statusEffectv2(StatusEffects.ZenjiTrainingsCounters2) < 3) player.addStatusValue(StatusEffects.ZenjiTrainingsCounters2, 2, 1);
			player.trainStat("wis",(4 - player.statusEffectv2(StatusEffects.ZenjiTrainingsCounters2)),player.trainStatCap("wis",100));
			player.fatigue += Math.round(player.maxOverFatigue() * 0.2);
			followerZenjiMainCampMenuTrainingPerks();
			endEncounter();
		}

		public function followerZenjiMainCampMenuTrainingPerks():void {
			if (player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters2) < 30) player.addStatusValue(StatusEffects.ZenjiTrainingsCounters2, 3, 1);
			if (player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters2) == 5 || player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters2) == 15 || player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters2) == 30) outputText("After you're done training, you feel different, you can't explain it, but something has surely changed, almost as if the training you've done with Zenji is really speaking to you.\n\n");
			if (player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters2) == 5 && !player.hasPerk(PerkLib.ZenjisInfluence1)) {
				outputText("(<b>Gained Perk: Zenji's influence 1</b>)\n\n");
				player.createPerk(PerkLib.ZenjisInfluence1,0,0,0,0);
			}
			if (player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters2) == 15 && !player.hasPerk(PerkLib.ZenjisInfluence2)) {
				outputText("(<b>Gained Perk: Zenji's influence 2</b>)\n\n");
				player.createPerk(PerkLib.ZenjisInfluence2,0,0,0,0);
			}
			if (player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters2) == 30 && !player.hasPerk(PerkLib.ZenjisInfluence3)) {
				outputText("(<b>Gained Perk: Zenji's influence 3</b>)\n\n");
				player.createPerk(PerkLib.ZenjisInfluence3,0,0,0,0);
			}
		}

		public function followerZenjiSpar():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("\"<i>Ya want ta spar wit me? Alright den, I wont hold back!</i>\"\n\n");
			startCombat(new Zenji());
			doNext(playerMenu);
		}

		public function followerZenjiSparPCDefeated():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (player.HP <= player.minHP()) {
				outputText("You hold up your hand and tell him that you can't fight him anymore.\n\n");
				outputText("\"<i>Ya did good, but I know ya can do betta next time. Here, I know a trick ta help ya recova.</i>\" Zenji examines you for any wounds he may have caused and holds his hand over you, you feel a little better after he's done. \"<i>Give it a moment, you may want ta see if ya can do anything about it personally, 'cause I don’t usually use my tricks to help othas.</i>\"\n\n");
			}
			else {
				outputText("You fall to your knees, you’ve turned yourself on too much to fight him anymore. He really is just so handsome...\n\n");
				outputText("Zenji looks at you with concern in his eyes, \"<i>¿Es mi jale tan fuerte?</i>\" He shakes his head and leaves you to your business.\n\n");
			}
			cleanupAfterCombat();
		}

		public function followerZenjiSparZenjiDefeated():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("Zenji crouches down and holds up a hand, \"<i>Enough! Enough... you are too good at dis.</i>\" He tries to catch his breath, \"<i>Don' worry 'bout me, I learned a few tricks to recova.</i>\" Zenji takes a deep breath and stands up. \"<i>Dat was fun, we should do it again lata, no?</i>\"\n\n");
			outputText("You tell Zenji you'd need a moment before you could consider fighting him again.\n\n");
			cleanupAfterCombat();
		}

		public function followerZenjiTalks():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji you just want to talk and get to know him better.\n\n");
			outputText("\"<i>Interested in trolls are ya? Well, what d'ya wanna talk about?</i>\"\n\n");
			menu();
			addButton(0, "Himself", followerZenjiTalksHimself).hint("Talk to Zenji about himself.");
			addButton(1, "Trolls", followerZenjiTalksTrolls).hint("Talk to Zenji about trolls.");
			addButton(2, "Yourself", followerZenjiTalksYourself).hint("Talk to Zenji about yourself.");
			if (TrollVillage.ZenjiTrollVillageTimeChk == -1 ) {
				if (TrollVillage.ZenjiVillageStage < 4) addButton(3, "His Problems", zenjiVillageProblems);
				else addButton(3, "His Problems", zenjiVillageProblems2);
			}

			addButton(14, "Back", followerZenjiMainCampMenu);
		}

		public function followerZenjiTalksHimself():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell him you want to know more about him and why he was in the bog in the first place.\n\n");
			outputText("\"<i>Dat's easy, de trolls back home are cowards, dey didn't starve for adventure, only thinking about how they could get enough food, or worry about otha boring tings. I couldn't stand it, I wanna explore, I needed to get out of der, dey were just so boring, not wanting to train or fight, just scavenge and stick close ta home, ya know? It didn't take much time to get out of der, nobody stopped me, and I was free... I know dey probably wanted me gone, I caused a lotta trouble when I was there… dere was also dis one person…</i>\"\n\n");
			outputText("Zenji pauses for a moment, sighing softly.\n\n");
			outputText("\"<i>But da's beside da point, I needed to do tings on ma own, live life on ma own without dem always watching over my every action. De bog was a nice place when I saw it, and dat area ya found me in was great for stretching and training wit people who wanted ta, like you when you came along. Eventually da people who I usually saw stopped coming, I don' know why, but I was starting ta get lonely, if there was one thing I missed about ma troll village, is all the people did care. Even if it was boring, der was still people everywhere. Den you came along, you fought with vigor, trained with passion, der was someting about ya, and I didn't want ta be alone out der anymore, so I wanted ta join you here in ya camp, I've even gotten ta meet some new friends, so dat's nice.</i>\"\n\n");
			outputText("Zenji spends the rest of the hour talking about new experiences in the camp and other things about himself that he can recall.\n\n");
			endEncounter();
		}

		public function followerZenjiTalksTrolls():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You ask Zenji what he can tell you about trolls. After all, that’s what he commonly refers to himself as.\n\n");
			outputText("\"<i>Dere's many kinda trolls, tink of it like alraune, each one may be simila way back den, but now dey've split into different kinds, ya know? My troll village grew used to da jungle we lived in, plenty of shade and cold nights, ma fuzz is great at keeping warm and hiding in da trees of da jungle, da oda trolls never saw me coming haha!</i>\"\n\n");
			outputText("He pauses for a moment, \"<i>But de other trolls in my village didn't like me too much, I caused trouble, I sought competition, when dey wanted peace and quiet, so I left. I didn't see many oda trolls out dere, but they’re probably not in de bog where I spent most’ve ma time.</i>\"\n\n");
			outputText("Zenji spends the rest of the hour talking about trolls and other nuances about his kind from the other trolls.\n\n");
			endEncounter();
		}

		public function followerZenjiTalksYourself():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji you wanted to talk a little bit about yourself and what he thinks of you.\n\n");
			outputText("Zenji raises an eyebrow at you, \"<i>If dat's what ya want ta talk about, den alright. What's dere to talk about.</i>\"\n\n");
			outputText("You tell Zenji about your past and how you were selected as the champion of Ingnam. Zenji doesn't give much more than a \"<i>Mhmm</i>\" here and there.\n\n");
			outputText("You ask what he thinks about you though.\n\n");
			outputText("\"<i>Well, ya be a good friend here, good fighter, with vigor and strength. In de bog almost nobody could beat me in a fight, but you are something different, ya fight with unrivaled passion dat dey could neva compete with. Da's what I like about ya, ya don't give up, ya only fight harder.</i>\"\n\n");
			outputText("You spend the rest of the hour talking about yourself and sharing old stories back in Ingnam with Zenji.\n\n");
			endEncounter();
		}

		public function followerZenjiSex():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (flags[kFLAGS.ZENJI_PROGRESS] == 9) {
				outputText("You ask Zenji if his stance on you has changed at all. Is he ready to get to know the rest of you?\n\n");
				outputText("Zenji shakes his head, \"<i>No, I still would rather not.</i>\"\n\n");
			}
			else {
				outputText("You ask Zenji if he's feeling comfortable enough to get a little closer to you.\n\n");
				outputText("Zenji shrugs and shuffles a slightly closer to you, \"<i>What, are ya cold?</i>\" He replies, raising an eyebrow.\n\n");
				outputText("You tell him that you want to get intimate with him.\n\n");
				outputText("\"<i>Ah... I... I don't see ya dat way, ya be a good friend, but I don't tink I want ta get personal with ya like dat... I... I just don't tink I could see maself with you, I don' wanna be rude, but I can't see us like dat.</i>\"\n\n");
				outputText("You frown in disappointment, but don't press the matter further.\n\n");
				flags[kFLAGS.ZENJI_PROGRESS] = 9;
			}
			doNext(followerZenjiMainCampMenu);
		}

		public function followerZenjiGlades():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (flags[kFLAGS.ZENJI_DESTROYING_CORRUPTED_GLADES] == 0) {
				outputText("You ask Zenji for him to help you tear down the corrupted glades that plague the land.\n\n");
				outputText("Zenji gives you a knowing grin, \"<i>Dis sounds like someting I can do! I will help destroy de corruption.</i>\"\n\n");
				flags[kFLAGS.ZENJI_DESTROYING_CORRUPTED_GLADES] = 1;
			}
			else {
				outputText("You tell Zenji that you no longer require his assistance in destroying the glades.\n\n");
				outputText("Zenji peers at you curiously, \"<i>Uh… Okay den…</i>\"\n\n");
				flags[kFLAGS.ZENJI_DESTROYING_CORRUPTED_GLADES] = 0;
			}
			doNext(followerZenjiMainCampMenu);
		}

		public function followerZenjiMainCampMenuLeave():void {
			outputText("You realize that you don’t have anything you need from him at this moment, you apologize and take your leave.\n\n");
			outputText("Zenji gives you a small nod as he dismisses you.\n\n");
			doNext(camp.campFollowers);
		}

		//ZENJI LOVER

		public function loverZenjiFirstTimeOffer():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("As you are wandering through the dense bog, a familiar voice rings through the trees, you immediately recognize it as Zenji, the troll as he jumps down from a tree.\n\n");
			outputText("\"<i>Heheh... [name], It good ta see ya again... Are... are you alright, I-I jus’... I couldn' stop tinking about you and... De time I spent sparring and training wit ya... H-how have ya made it this far being so weak? I mean, you’re not weak, you still have a lot of improving to do… I want to be there for you.</i>\"\n\n");
			outputText("You try to speak up but he cuts you off.\n\n");
			outputText("\"<i>Dere's someting about ya that I just can't get outta my head, I-I want ta get closer to you, I've never felt dis way about anyone before... but... but I just want to be dere for you, I want ta protect ya from the world, I want ta be wit ya. I-I want ta get closer to you... get to know you… to help you with everything ya need… If you’d let me… If you want me, that is...</i>\"\n\n");
			outputText("You can feel his tail gently caress your body as he speaks. You're not sure what to say, Zenji is clearly interested in you. Do you accept him as your lover?\n\n");
			menu();
			addButton(1, "Yes", loverZenjiOfferYes);
			addButton(3, "No", loverZenjiOfferNo);
		}

		public function loverZenjiRepeatOffer():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("\"<i>[name] Good ta see ya... Did you want me to join your camp... or..?</i>\"\n\n");
			menu();
			addButton(1, "Fight", part2TrollEncounterRepeatFight);
			addButton(2, "Train", part2TrollEncounterTrain);
			addButton(4, "Leave", part2TrollEncounterLeave);
			addButton(7, "Yes", loverZenjiOfferYes);
		}

		public function loverZenjiOfferNo():void {
			outputText("Zenji's eyes grow watery, \"<i>You are a brave soul, I tell ya dat.</i>\" He slowly moves closer to you and puts his hands on your shoulders. \"<i>Stay safe out dere, I will remain here if ya need me.</i>\"\n\n");
			flags[kFLAGS.ZENJI_PROGRESS] = 10;
			endEncounter();
		}

		public function loverZenjiOfferYes():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("Zenji gives a weak smile as he looks toward you longingly, \"<i>I was hoping you'd say dat, I can't stand de fact dat you've been alone out dere fending fa yourself, I want ta be der for ya, I don' wanna be so far away from you all de time.</i>\" He moves in closer");
			if (player.tallness < 54) outputText(", picking you up and wrapping you in his warm, fuzzy embrace");
			else if (player.tallness < 68) outputText(" to you and wraps you within his warm, fuzzy embrace, resting his chin atop your head");
			else outputText(" to you and wraps you within his warm fuzzy embrace");
			outputText(". He lets go of you after a moment, \"<i>Lead de way, I won't leave ya side no matta what.</i>\"\n\n");
			outputText("You lead Zenji back to your camp, once he’s settled Zenji sighs softly, \"<i>Back at my old home, tings were difficult fa me… It was difficult fa me to get over my problems back den, but… With you, I feel like you are a part of me. It’s like I feel… complete with you… Like de horrible tings dat happened back home neva happened... I wanna be dere for you, [name]. I wanna be here wit ya, always, mi corazón.</i>\"\n\n");
			outputText("<b>Zenji has joined you as a lover.</b>\n\n");
			player.createStatusEffect(StatusEffects.ZenjiModificationsList,0,0,15,7);
			player.createStatusEffect(StatusEffects.ZenjiPreparationsList,0,0,0,0);
			player.createStatusEffect(StatusEffects.ZenjiZList,0,0,0,0);
			flags[kFLAGS.ZENJI_PROGRESS] = 11;
			endEncounter();
		}

		public function loverZenjiMainCampMenu2():void {
			if (!player.hasStatusEffect(StatusEffects.LunaOff) && !player.hasStatusEffect(StatusEffects.LunaWasWarned)) {
				if ((flags[kFLAGS.LUNA_JEALOUSY] > 200 && rand(10) < 4) || (flags[kFLAGS.LUNA_JEALOUSY] > 300 && rand(10) < 8)) mishapsLunaZenji();
				else loverZenjiMainCampMenu();
			}
			else loverZenjiMainCampMenu();
		}

		public function loverZenjiMainCampMenu():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (player.statusEffectv1(StatusEffects.ZenjiModificationsList) > 23) {
				outputText("You approach Zenji, he seems a little distressed. He seems sweaty, has he been working out… more than usual?\n\n");
				outputText("\"<i>[name]... where have ya been..?</i>\" He shifts around nervously, \"<i>I’ve been…. Getting a little lonely withoutcha…</i>\"\n\n");
				outputText("He musters up a small smile, \"<i>Well, you’re here now, knowing dat you’re safe makes me feel better... What didja want? I’ll always be here for ya, [name].</i>\"\n\n");
				var reset:Number = player.statusEffectv1(StatusEffects.ZenjiModificationsList);
				player.addStatusValue(StatusEffects.ZenjiModificationsList, 1, -reset);
			}
			else {
				if (player.lust > player.maxLust() * 0.75) {
					outputText("You approach Zenji as he eyes you carefully, \"<i>[name]. I see dat look in ya eye… Dere’s someting you want from me, isn’t der?</i>\"\n\n");
					outputText("He moves closer to you, wrapping you within his strong arms and giving you a disarming grin, \"<i>Well, am I wrong?</i>\"\n\n");
					outputText("You look up at him, giving him a coy smile before you grope his toned ass. You tell him that maybe there is something special you want from him.\n\n");
					outputText("He playfully sticks his tongue out at you in response, giving you a good look at his long, grey tongue.\n\n");
				}
				else {
					if (player.pregnancyType == PregnancyStore.PREGNANCY_ZENJI || player.pregnancy2Type == PregnancyStore.PREGNANCY_ZENJI) {
						outputText("You approach Zenji and he eyes your form. He seems almost mesmerized by your figure.\n\n");
						outputText("You ask Zenji if he’s alright.\n\n");
						outputText("Zenji blinks softly as he reaches a hand out to your form, \"<i>[name]... you’re… you’re just so beautiful… You’re everyting to me, [name]. I’m yours forever, don’ you forget it.</i>\" He finally breaks away from his trance, looking you in the eyes, \"<i>But… is der someting you wanted?</i>\"\n\n");
					}
					else if (player.cor < 1 ) {
						outputText("You approach Zenji and he greets you with a warm smile.\n\n");
						outputText("\"<i>If it isn’t my precious little sweetheart.</i>\" he croons, giving you an affectionate head pat. \"<i>Is there something you wanted?</i>\"\n\n");
					}
					else outputText("You approach Zenji and he looks down at you, raising an eyebrow, \"<i>¿Si, "+(player.thickness <= 50 ? ""+player.mf("flaco","flaca")+"":"gordita")+"?</i>\"\n\n");
				}
			}
			menu();
			addButton(0, "Appearance", loverZenjiMainCampMenuAppearance).hint("Examine Zenji.");
			addButton(1, "Talk", loverZenjiTalks).hint("Talk to Zenji.");
			addButton(2, "Sex", loverZenjiSex).hint("Perhaps the hunk could be open to share an intimate moment with you.");
			if (CorruptedGlade.canBeDestroyed()) addButton(3, "Glades", loverZenjiGlades).hint("Have Zenji help you in destroying the corrupted glades.");
			addButton(4, "Nightwatch", loverZenjiNightWatch).hint("Toggle Zenji’s night watch on or off.");
			if (player.hasPerk(PerkLib.BasicLeadership)) addButton(5, "Assist Me", zenjiHenchmanOption);
			else addButtonDisabled(5, "Assist Me", "You need to have at least Basic Leadership to form a team.");
			addButton(6, "Give Item", loverZenjiGiveItem);//.hint("Talk to Zenji.")
			if (flags[kFLAGS.SLEEP_WITH] != "Zenji") addButton(7, "Sleep With", zenjiSleepToggle).hint("Spend your nights with Zenji.");
			else addButton(7, "Sleep Alone", zenjiSleepToggle).hint("Stop sleeping with Zenji.");
			addButton(14, "Leave", loverZenjiMainCampMenuLeave);
		}

		public function loverZenjiMainCampMenuAppearance():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("Zenji is a troll to your knowledge, at least that’s what he calls himself.\n\n");
			outputText("He is 8’2\", covered head to toe in soft, cuddly green fur. The top of his head is crowned with a shaggy, pale green mohawk. His face is very handsome, with good symmetry, strong brows, and a chiseled jawline. He has deep-set eyes complimented by ashen green irises. His nose is pronounced and elongated. As your eyes wander down his face, you can see 2 ivory "+(player.statusEffectv4(StatusEffects.ZenjiModificationsList) == 7 ? "tusks protrude from his mouth, each about 7 inches long. His left tusk is covered in a series of rings hanging from the tip to the midsection" : "nibblers protrude from his mouth, barely an inch long")+". ");
			outputText("Between those tusks, his lower two canines stick out slightly past his lips. Darker colored hair wraps around his mouth, emphasizing the scruffy beard that covers his lower face. His beard is fairly dense, you could easily get your fingers lost beneath it. He has pointed ears similar to that of an elf, fuzzy like the rest of him. They twitch every so often, provoked easily by any sound that could bring a problem.\n\n");
			outputText("Zenji’s physique is imposing, chiseled, and very muscular. He wears a beaded necklace over his neck. He has broad shoulders with long, very muscular and toned arms that extend past his waist. His elbows are covered in darker colored hair that hangs out slightly. His arms are human-shaped with large four-fingered hands. He wears fur bracers that cover his wrists. He has 2 manly pecs with a tuft of hair sticking out between them. He has firm, well-defined abs, hidden behind his fur. He currently is only wearing a loincloth over his waist, tied by an animal fur pelt as his fur covers his entire body.  ");
			outputText("Sprouting from the base of his spine is his fuzzy tail, it is about 3 feet long with a larger tuft of hair at the tip, it sways slowly behind him.\n\nHe has 2 long, muscular legs that end in four-toed, furry feet. His ass is perfectly round, muscular and symmetrical, it is by far one of the best-looking behinds you will or have ever witnessed in your life. His tight backdoor is nestled between his cheeks where it belongs. Hiding behind his loincloth is his uncut humanoid penis. You know that he’s a grower, when fully erect he is ");
			if (player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 15) outputText("7.5 inches long and 2.2");
			if (player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 24) outputText("12 inches long and 2.4");
			if (player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32) outputText("16 inches long and 2.6");
			outputText(" inches thick, the only part of him not covered in hair. Below that is his fuzzy pair of gonads, swaying beneath him, each normally about 3 inches across.");
			if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 998700) outputText(" He produces so much cum now that he is permanently leaking a steady stream of cum from his tip. Somehow you know a part of him is loving every moment of the lewdness.");
			outputText("\n\nZenji remains fixated on surveying your camp as you examine him, \"<i>If ya want to get a little closer ya don' hafta ask,</i>\" he says giving you a gentle pat on the shoulder.\n\n");
			menu();
			addButton(14, "Back", loverZenjiMainCampMenu);
		}

		public function loverZenjiTalks():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji you just want to talk with him for a while.\n\n");
			outputText("Zenji nods softly, \"<i>Me gusta tenerte cerca, flaca. I’m always happy to talk ta ya. Now, what do ya want ta talk about?</i>\"\n\n");
			menu();
			addButton(0, "Himself", loverZenjiTalksHimself).hint("Get to know him a little more.");
			addButton(1, "Trolls", loverZenjiTalksTrolls).hint("Get to know a little more about trolls.");
			addButton(2, "Yourself", loverZenjiTalksYourself).hint("Tell Zenji more about yourself.");
			if (flags[kFLAGS.ZENJI_KIDS] > 0) addButton(3, "Children", loverZenjiTalksChildren).hint("Talk to Zenji about your children.");
			addButton(5, "Showoff", loverZenjiShowoff).hint("Have Zenji display his strength for you to admire.");
			addButton(6, "Comfort", loverZenjiComfort).hint("Spend a tender moment with him. Now with free headpats.");
			addButton(7, "Food", loverZenjiFood).hint("Zenji seems like he has something he wants to give you.");
			button(7).disableIf(ZenjiFood, "Zenji does not have any more food to offer you right now, ask again tomorrow.");
			if (TrollVillage.ZenjiTrollVillageTimeChk == -1 ) {
				if (TrollVillage.ZenjiVillageStage < 4) addButton(3, "His Problems", zenjiVillageProblems);
				else addButton(3, "His Problems", zenjiVillageProblems2);
			}
			if (ZenjiMarriagePreCheck()) {
				if (player.hasItem(jewelries.ENDGRNG, 1)){
					addButton (9, "Propose", ZenjiProposalScene).hint("Zenji seems to have strong feelings for you, perhaps you should propose with the engagement ring you have?\n");
				}
				else{
					addButtonDisabled(9, "Propose", "Zenji seems to have strong feelings for you, but you cannot propose without a proper engagement ring!\n");
				}
			}
			else{
				addButtonDisabled(9, "Propose", "Somehow, when you look into Zenji’s eyes, you know he’s not ready for marriage. Perhaps another time?\n");
			}
			addButton(14, "Back", loverZenjiMainCampMenu);
		}

		public function loverZenjiTalksHimself():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell him you want to know more about him and why he was in the bog in the first place.\n\n");
			outputText("\"<i>Dat's easy, de trolls back home are cowards, dey didn't starve for adventure, only thinking about how they could get enough food, or worry about otha boring tings. I couldn't stand it, I wanna explore, I needed to get out of der, they were just so boring, not wanting to train or fight, just scavenge and stick close ta home, ya know? It didn't take much time to get out of der, nobody stopped me and I was free... I know dey probably wanted me gone, I caused a lotta trouble when I was there, but dat's beside de point, I needed to do things on my own, live life on my own without dem always watching over my every action. ");
			outputText("De bog was a nice place when I saw it and dat area ya found me in is great for stretching and training wit people who wanted ta. Eventually, da people who I usually saw stopped coming, I don' know why, but I was starting ta get lonely, if there was one thing I missed about ma troll village, is all the people did care, even if it was boring, der was still people everywhere. You have been someting different, I needed to protect ya, so I wanted ta join you here in ya camp, I want ta always be here for ya.</i>\"\n\n");
			outputText("Zenji takes a deep sigh, \"<i>Dere was dis… one girl… Before I met you, she caught me within her hands, she… she only wanted me for what I was… my body... She did not care fa who I was… But… Dat’s behind me now. When I am wit you de tings she did ta me doesn’t hurt as much anymore and I just want ta protect you so dat you never hafta be hurt or abused like I once was.</i>\"\n\n");
			outputText("Zenji spends the rest of the hour talking about new experiences in the camp and other things about himself that he can recall.\n\n");
			if (player.statusEffectv1(StatusEffects.ZenjiPreparationsList) < 15) player.addStatusValue(StatusEffects.ZenjiPreparationsList, 1, 1);
			ZenjiTalkCount++;
			endEncounter();
		}

		public function loverZenjiTalksTrolls():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You ask Zenji what he can tell you about trolls, he doesn’t resemble the ones you’ve read from any books.\n\n");
			outputText("\"<i>Dere's many kinda trolls, tink of it like alraune, each one may be similar way back den, but know dey've split into different kinds, ya know? My troll village grew used to da jungle we lived in, plenty of shade and cold nights, ma fuzz is great at keeping warm and hiding in de trees of da jungle, da other trolls never saw me coming haha!</i>\"\n\n");
			outputText("He pauses for a moment, \"<i>But de other trolls in my village didn't like me too much, I caused trouble, I sought competition, when dey wanted peace and quiet, so I left. I didn't see many oda trolls out dere, but they’re probably not in de bog where I spent most of my time.</i>\"\n\n");
			outputText("Zenji spends the rest of the hour talking about trolls and other nuances about his kind from the other trolls.\n\n");
			if (player.statusEffectv1(StatusEffects.ZenjiPreparationsList) < 15) player.addStatusValue(StatusEffects.ZenjiPreparationsList, 1, 1);
			ZenjiTalkCount++;
			endEncounter();
		}

		public function loverZenjiTalksYourself():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji you wanted to talk a little bit about yourself and what he thinks of you.\n\n");
			outputText("Zenji looks at you intently, \"<i>Dere's someting special about ya, I can't shake de feeling of it, but when ya tried ta train wit me in de bog, I jus had ta do something different. But tell me, what's dere ya want to talk about?</i>\"\n\n");
			outputText("You tell Zenji about your past and how you were selected as the champion of Ignam. Zenji doesn't give much more than an 'Mhmm' here and there.\n\n");
			outputText("You ask what he thinks about you though.\n\n");
			outputText("\"<i>I just had ta be wit you, dere's no oda way to say it, I need ta be close ta ya, I hafta protect you, you are just so... so helpless, you are special ta me, I want ta be dere fa ya.</i>\" He places a hand on your shoulder, \"<i>I don't ever want to leave you [name].</i>\"\n\n");
			outputText("You spend the rest of the hour talking about yourself and sharing old stories back in Ingnam with Zenji.\n\n");
			if (player.statusEffectv1(StatusEffects.ZenjiPreparationsList) < 15) player.addStatusValue(StatusEffects.ZenjiPreparationsList, 1, 1);
			ZenjiTalkCount++;
			endEncounter();
		}

		public function loverZenjiTalksChildren():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You ask Zenji how the children are doing.\n\n");
			outputText("Zenji smiles softly, \"<i>De baby is doing fine, dey grow up so fast, I can already see de tusks coming in.</i>\"\n\n");
			outputText("Zenji leads you to his bedroll, your "+(flags[kFLAGS.ZENJI_KIDS] == 1 ? ""+Z1stKid+" is":"children are")+" sleeping peacefully in a nest of herbs.\n\n");
			outputText("Zenji leans close to whisper to you, \"<i>Best not ta wake dem up, it takes forever to get them to sleep,</i>\" he states, wrapping an arm around you. \"<i>Dey are truly our precious child, I cannot tank ya enough for helping me do dis. I'm sure you'll enjoy raising dem wit me.</i>\" Zenji lets out a content sigh, \"<i>It'll be a moment for their hair ta come in, so keep close, and make sure dey're warm so dey can grow up loved properly, any child dat doesn't get enough love won’t be a good adult.</i>\" Zenji pulls you in for a soft peck on the lips, \"<i>And I know we got enough love to share,</i>\" he croons, caressing your face.\n\n");
			outputText("You smile at him as you spend some time with your children, Zenji is a very tender father as you’ve grown to expect. His gruff exterior can mask just how caring and gentle he truly is. His presence is soft as the two of you play with your children. Despite his masculine figure and beefy body, he has a gentle touch and it shows with the way he treats your children.\n\n");
			outputText("After nearly an hour of spending time with your children, you decide it’s best to continue with your day for now, but you’ll be sure that Zenji won't be a lonely father to the children.\n\n");
			if (player.statusEffectv1(StatusEffects.ZenjiPreparationsList) < 15) player.addStatusValue(StatusEffects.ZenjiPreparationsList, 1, 1);
			ZenjiTalkCount++;
			endEncounter();
		}

		public function loverZenjiShowoff():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You eye Zenji’s form up and down. At just 8’2\", he stands proud as ever, his impressive, chiseled musculature and tall stature stands with very little clothing obstructing your view.\n\n");
			outputText("You know he works out, enjoying the feeling of breaking a sweat from time to time, but perhaps he’d be willing to try a little more if you were to ask.\n\n");
			outputText("Zenji notices you eyeing him, to which he replies by bending forward slightly, flexing for you.  \"<i>"+(player.thickness < 70 ? "Ya like whatcha see..?":"Does my chubby friend like what they see? Ya like how big I am, don’tcha?")+"</i>\"\n\n");
			outputText("You nod, perhaps that was obvious given how much you’ve been staring at him. But there’s more to it, just how often does he work out anyway? What got him into pushing his body and perfecting his physique. Zenji pauses to think as you ask him about this.\n\n");
			outputText("\"<i>Hmm… I’ve always liked de idea of just working out… I dunno, it’s something to do when I was bored, it’s kinda fun to me at least. I remember my mom told me if I ate well I’d grow up big and strong like my dad... I knew I could do better, I mean, don’ get me wrong, my dad is very strong, but he’s not as trained as I am now.</i>\"\n\n");
			outputText("Zenji raises a single, massive arm, flexing for you once more, \"<i>I mean, very few can compare, right?</i>\"\n\n");
			outputText("Zenji is quite the behemoth when it comes to just how built he is, he seems much stronger and more agile than virtually everything you’ve encountered so far. With everything from his powerful arms to his thick thighs and chiseled calves, he is truly a fine troll.\n\n");
			outputText("\"<i>I kinda like working up a little sweat, it reminds me dat I still have a long way to go each time I wipe my brow. I am not perfect, I am weak in my own ways, but dat doesn’t mean I can’t work on my strengths. I mean, look at you… I’m so lucky to have someone like you with me.</i>\"\n\n");
			outputText("You give him a smile in response, it’s warming to know that he enjoys your presence. Having him around will always bring a little joy to your day.\n\n");
			outputText("He gives you a coy smirk as he slides his fur bracers up his biceps. The threads keeping it together begin to strain from the sheer size of his arms. They seem more like a band as he shifts, giving you a show of his toned triceps as well. \"<i>I bet you’ve been waiting for me ta do someting like dis.</i>\"\n\n");
			outputText("With both bracers now tightly wrapped around his biceps, he brings his arms in front of him, flexing once more. The fur bracers strain even more, barely managing to hold together.\n\n");
			outputText("Zenji chuckles softly, \"<i>Ah, perhaps I’m not big enough yet… dat or…</i>\"\n\n");
			outputText("He raises his arms to a double bicep pose, flexing his massive arms again for you. Soon he places a hand on his hip as he focuses all of his efforts into tearing apart one bracer with the force of his biceps alone. The fabric strains before ripping with a satisfying popping sound as the seams burst.\n\n");
			outputText("\"<i>Yeah! Dat’s what I’m talking about!</i>\"\n\n");
			outputText("He places the arm on his hip before doing the same thing to his last bracer.\n\n");
			outputText("\"<i>Noting can contain de might of Zenji! Take a good look [name], I can do dis all day!</i>\"\n\n");
			outputText("The fur bracer snaps again from the strain of his bulk, falling flat on the ground after being ripped apart.\n\n");
			outputText("He flexes in triumph, \"<i>Ha! Torn ta pieces!</i>\"\n\n");
			outputText("Once he’s done, Zenji takes an extended glance at the shredded pieces of fur. \"<i>I can always mend dem back together… Or just hunt some more animals ta make another pair... I really should do dat soon… I like ta store tings in de little pockets I make within dem.</i>\"\n\n");
			outputText("After a brief pause, Zenji eyes you up and down once more, \"<i>Well, I know ya wanna get closer,</i>\" He states, showing off several poses for you. Making sure nothing is obstructed from view. From his toned back, muscular traps, thick arms, and legs, Zenji makes sure to show off every inch of his massively muscular body. \"<i>So why don’t I give ya front row seats to my next workout?</i>\"\n\n");
			if (player.statusEffectv1(StatusEffects.ZenjiPreparationsList) < 15) player.addStatusValue(StatusEffects.ZenjiPreparationsList, 1, 1);
			ZenjiTalkCount++;
			menu();
			addButton(1, "Yes", loverZenjiShowoffYes);
			addButton(3, "No", loverZenjiShowoffNo);
		}
		public function loverZenjiShowoffNo():void {
			outputText("You tell Zenji that you’d rather not take up on the offer.\n\n");
			outputText("\"<i>Ah, well, I’ll always be here if ya need anything… </i>\" He replies.\n\n");
			outputText("You decide to take your leave for the time being.\n\n");
			endEncounter();
		}
		public function loverZenjiShowoffYes():void {
			outputText("The thought is interesting, but what does he mean exactly by \"front row seats\"?\n\n");
			outputText("Zenji smirks, \"<i>Oh? Can’t ya see? I’ll be de seat for ya ta rest on.</i>\" He states before quickly hopping down to a push-up position.\n\n");
			outputText("He doesn’t waste any time, starting with several push-ups in perfect form.");
			outputText("\"<i>Hop on when you’re ready, [name]. I hope you are liking what ya see.</i>\"\n\n");
			outputText("He always seems to enjoy showing off for you when given the chance. You decide to play along and approach. His back, just like the rest of him is perfectly chiseled and muscular, showing perfect definition even beneath his layer of fluff. His tail coils around his left leg for support as he continues with the pushups\n\n");
			outputText("You lean down and take a rest on his perfectly muscular back.\n\n");
			outputText("\"<i>Ha!</i>\" Zenji laughs once you’re seated on him, \"<i>It’s time ta show you what I’m made of! I can do dis all day for ya, [name]!</i>\"\n\n");
			if (player.tallness < 48) {
				outputText("Zenji effortlessly continues with his push-ups for several minutes as you bounce on top of him, your weight is seemingly completely insignificant to him. Your weight shifts on top of him as he shifts his hands, now alternating arms with his single-handed push-ups. He claps each time he lifts himself into the air, he’s most assuredly enjoying himself.\n\n");
				outputText("\"<i>Ya still dere, [name]? Haha! I almost forgot!</i>\"\n\n");
			}
			else if (player.tallness < 84) {
				outputText("Zenji effortlessly continues with his push-ups for several minutes. He shows little to no signs of wear, your weight is seemingly insignificant to him. Your weight shifts on top of him as he proceeds with alternating his arms, now doing single-handed pushups.\n\n");
				outputText("\"<i>Having fun? I still have all day ta keep it up.</i>\"\n\n");
			}
			else if (player.tallness < 132) {
				outputText("Zenji continues with his push-ups for several minutes. He is barely showing any signs of wear, completely able to support your weight on top of him.\n\n");
				outputText("\"<i>Now ya see what I’m made of! I hope you’re comfortable, cause we still have plenty of time remaining.</i>\"\n\n");
			}
			else {
				outputText("Zenji continues with his push-ups for several minutes. He is starting to show signs of wear, but still able to support your weight on top of him.\n\n");
				outputText("\"<i>Still got more ta go! I can do dis! I WILL SHOW YOU JUST HOW MUCH I CAN TAKE!</i>\"\n\n");
			}
			outputText("Zenji begins breaking a sweat, faint droplets are trapped beneath his layer of hair. His masculine scent grows more apparent as he hardly shows any signs of slowing down his workout. His form is still perfect despite going at it for several minutes, he sure does seem to be sweating a lot more noticeably.\n\n");
			outputText("Once he’s seemed to have worn himself out, he sinks, wiping the sweat from his brow. \"<i>Ha, now we move to de legs.</i>\"\n\n");
			outputText("You climb off of him as he stands up.\n\n");
			outputText("\"<i>Don’t be shy, hop on.</i>\" He states as he leans down, helping you onto his shoulders.\n\n");
			if (player.tallness < 48) {
				outputText("He picks up your insignificant weight, holding you on his shoulders as you wrap around him.\n\n");
				outputText("He then proceeds with his squats. Just like his push-ups, he has perfect form. To show off even more, with each rise, he jumps as high as he can into the air. He goes at it for several more minutes with an effortless display of endurance.\n\n");
				outputText("\"<i>Hold on tight! I’m not stopping any time soon!</i>\"\n\n");
			}
			else if (player.tallness < 84) {
				outputText("Once you’re on his shoulders, he proceeds with his squats. Just like his push-ups, he has perfect form. Even jumping from time to time, just to show off his strength. He keeps up the tempo for several more minutes in a tremendous display of endurance.\n\n");
				outputText("\"<i>Having fun? Good, why don’tcha help wipe off de sweat from my head.</i>\"\n\n");
			}
			else if (player.tallness < 132) {
				outputText("Once you’re on his shoulders, he proceeds with his squats. Just like his push-ups, he has perfect form. Even with your weight on him, he displays his incredible stamina, continuing with seemingly unstoppable strength for several minutes.\n\n");
				outputText("\"<i>Now ya see what I’m made of! I still got time ta keep at it!</i>\"\n\n");
			}
			else {
				outputText("Once you’re on his shoulders, he proceeds with his squats. Just like his push-ups, he has perfect form. Despite your weight on him, he doesn’t relent. He begins showing signs of weariness a few minutes in, but that doesn’t seem to deter him.\n\n");
				outputText("\"<i>I AM UNSTOPPABLE! I WILL NOT BREAK!</i>\" He shouts as he persists through the squats.\n\n");
			}
			outputText("After several more minutes of continued squats with your weight on his shoulders, he begins to slow down. He is panting harder from all the heat he’s built up, sweating fairly heavily. His workout winds down as you slip off of his shoulders, but you’re not free yet. Zenji holds onto you tightly as he lies down. After a brief pause to collect himself, he begins to bench press you.\n\n");
			if (player.tallness < 48) {
				outputText("He continues mostly with ease, giving you several bench presses.\n\n");
				outputText("Zenji grunts, \"<i>Light as a feather…</i>\"\n\n");
			}
			else if (player.tallness < 84) {
				outputText("He continues with relative ease, giving you several bench presses.\n\n");
				outputText("Zenji grunts, \"<i>Ha, still going strong…</i>\"\n\n");
			}
			else if (player.tallness < 132) {
				outputText("He continues with slight weariness, giving you several bench presses.\n\n");
				outputText("Zenji grunts, \"<i>I am made of pure troll power, [name]!</i>\"\n\n");
			}
			else {
				outputText("He continues, his arms begin to shake slightly from your weight, but he still manages to give you several bench presses.\n\n");
				outputText("\"<i>I am unbroken! FEAR MY ROAR!</i>\" Zenji grunts before roaring with tremendous vigor as he gives you a few more bench presses.\n\n");
			}
			outputText("He continues at it for a few more minutes. Before he seems ready to give out, Zenji lowers you down as you slip off of him. Once you’re free, he brings his arms behind his head. His fur glistens with the beads of sweat trapped within as he bounces his biceps and pectorals softly, displaying his perfectly built body to you. Afterward, he does some light stretching to cool himself off.\n\n");
			outputText("\"<i>Ha! Dat really was some workout…</i>\" He sighs, almost breathlessly. \"<i>Whew… Ya really are a good partner fa dis, perhaps we could do it again later?</i>\"\n\n");
			outputText("You’ll have to think about it.\n\n");
			outputText("\"<i>Ah, I just need ta get cleaned off, I’m so sweaty.</i>\" He states, bringing his arms down, but not without one last flex.\n\n");
			outputText("You can clean him off before he goes, it’d be a shame for him to wash off his sweat and musk without you… But he probably has his rituals for cleaning himself, after all, it must take a lot of effort to keep his coat so perfectly soft all the time.\n\n");
			menu();
			addButton(1, "\"Clean\"", loverZenjiShowoffYesClean);
			addButton(3, "Leave him", loverZenjiShowoffYesLeaveHim);
		}
		public function loverZenjiShowoffYesLeaveHim():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You decide to let Zenji clean himself off, after all, he knows how to maintain himself like nobody else.\n\n");
			endEncounter();
		}
		public function loverZenjiShowoffYesClean():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You ask Zenji if he wouldn’t mind giving you the chance to clean him off this time.\n\n");
			outputText("Zenji chuckles softly, \"<i>Oh, ya wanna get all close to me now dat I’m all hot and sweaty? Hmm? I gotta say, all dis working out really gets me worked up. How about ya put dat tongue to good use..?</i>\"\n\n");
			outputText("Looks like it’s settled, you’re going to clean him off with your tongue.\n\n");
			outputText("Zenji remains lying on the ground, giving you a disarming grin. His hairy armpits are now exposed, the droplets of sweat all over his body and underarm glisten slightly beneath the light, begging to be cleaned.\n\n");
			outputText("Zenji puffs his chest out as he waits, \"<i>Well… I’m all sweaty, dis is whatcha wanted, right? Go ahead, ya can spend a moment ta admire, I don’t mind.</i>\"\n\n");
			outputText("You draw closer to him, even lying down, his body is still massive. You trail your hand along his abs. His damp, sweaty fur parts slightly beneath your [finger] as you grace along his skin. You take a moment to admire his manly musk. The usual scent of purified herbs, rain, grass, and sweat hits your nostrils. The saltiness of his sweat only further enhances the intensity of his natural scent.\n\n");
			outputText("You bring your face down, dragging your [tongue] along the creases of his firm abs. His stomach flexes slightly from your presence as you lick up the drips of sweat trapped within his fur.\n\n");
			outputText("Zenji gives a soft purr of appreciation as his chest heaves. He brings an arm up to your head, rubbing your nape gently as you continue licking up along his chiseled stomach.\n\n");
			outputText("You crawl further up his body, giving his hefty pectorals a gentle squeeze. His muscular pecs bounce slightly at your grasp, soft and pliable, but just sturdy enough to emphasize their definition. You bring your tongue closer, lapping up more faint drips of sweat as your tongue circles his areola hidden beneath a small layer of fuzz. Wanting to get a little friskier, you give his thick pecs a few nibbles. Zenji flinches slightly as you force a small chortle from him. You smile in satisfaction as you continue teasing him.\n\n");
			outputText("Zenji gives you a low growl of affection as you prod your tongue along his chest. His musk is so intense; it’s almost overwhelming. You hungrily lap over his firm pecs, holding onto him tightly as he purrs affectionately. Your grip on his fur tightens, the soft strands are clenched within your grasp as you bring your face to meet his. You lie on top of your sweaty troll, making out with him hungrily. He smells so wonderful, is this what trolls are normally like? Perhaps he should work out more often so that you can have more chances to admire his musky aroma. You break the kiss for a moment, biting gently on his lower lip as trails of saliva link the two of you together.\n\n");
			outputText("Do you completely give in to his scent, or resist just enough to not lose sight of who you are? His underarms are definitely where the most intense smell is coming from...\n\n");
			menu();
			addButton(1, "Give in", loverZenjiShowoffYesCleanGiveIn);
			addButton(3, "Resist", loverZenjiShowoffYesCleanResist);
		}
		public function loverZenjiShowoffYesCleanResist():void {
			outputText("You decide his armpits aren’t worth it right now. You look up to meet his gaze, to which Zenji replies with a cheeky grin.\n\n");
			doNext(loverZenjiShowoffYesCleanEnding);
		}
		public function loverZenjiShowoffYesCleanGiveIn():void {
			outputText("You take a deep inhale of his scent, his overwhelming pheromones never fail to entice you further. Drawn towards his musk, you slowly move over to his armpits. Zenji lifts his arm for you as you breathe in his herbal, salty musk. He smells so delicious, you even drool slightly at the thought of his delicious body and even sweeter scent.\n\n");
			outputText("The darker hair of his pits are coated even more thoroughly in sweat, the warmth of his body is more intense as well. You press your nose into his pit, sniffing deeply at his tantalizing musk. The dampness of his hair only serves to cling onto you slightly. You press your [tongue] out, pressing down on his fur until your tongue makes contact with the firmness of his body.\n\n");
			outputText("Trapped within the embrace of his muscular arm and torso, you continue licking away at his sweaty pits. You continue lapping away at his underarm until it’s completely cleansed of sweat. Without thinking, you quickly shift over to his other arm. Splayed across his torso, you continue making out with his armpit. You make sure that this armpit gets the same treatment as the last one, cleaning until not even an ounce of sweat is remaining.\n\n");
			outputText("Your eyes are drawn to his burly chest, his bulk is magnificent as ever. You cusp the heft of his manly pecs in your hands, bringing your face into his dense chest. You lick away at his fuzzy chest, making sure to savor the moment before you lower your tongue to the areolas hidden beneath the layer of hair. Zenji moans softly as you prod your tongue at his nipple, making sure to take in the lingering salty taste of his sweat.\n\n");
			outputText("Zenji brings his hand up to the back of your head, forcefully shoving your face deeper into his chest. Sinking into his body, you continue making out with his pecs, licking away and biting softly as Zenji responds with gentle moans of affection.\n\n");
			outputText("You hold onto his thick, muscular hands for a moment, bringing them to your face and licking between his fingers. While not as sweaty, his hands have a tinge of saltiness to them. Once you’re sated with his upper body, you follow your nose to his nether regions.\n\n");
			outputText("You quickly dart down, unveiling his loincloth to reveal his flaccid penis. He is a grower as his manhood is only a fraction of his normal size."+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? " Which is saying a lot considering how massive he is right now.":"")+"\n\n");
			outputText("You shift his flaccid dick to the side, pressing your face into his crotch as you inhale the sweaty musk of his sack. His balls are full and heavy, the sight and smell of it all only further enhances your arousal. You lift them gently, they churn slightly from the pent up load he has in store for his next release.\n\n");
			outputText("Lowering your face, you lick away at his sweaty and very fuzzy balls, making sure to give them a thorough cleaning just as you’ve done with his upper body. You gently suckle on the orbs, savoring the salty taste of him. Drops of pre leak out of his still flaccid girth, his balls practically overstuffed with cum, he can’t help but continually leak.\n\n");
			outputText("Zenji moans softly, his chest heaving with the force of his slow, heavy breaths. You continue lapping away at each orb, making sure not an inch of them is free from your aggressive licks.\n\n");
			outputText("Zenji grips the earth beneath him, bucking up against you with a lazy thrust. \"<i>Mmm… [name].. I can’t tell ya how good ya are at dis... Keep it up, I love dese cleanings…</i>\"\n\n");
			outputText("You lap away at his balls with your tongue, causing Zenji to give out a low moan in response. Perhaps too tired to become fully erect, his flaccid girth shoots out a heavy load of seed. While not as powerful as normal, the sheer volume is still intense.\n\n");
			outputText("\"<i>Mmph… now ya got another mess ta clean up…</i>\"\n\n");
			outputText("You breathe in his sweaty musk, now combined with the aroma of his steady stream of cum. You make sure to thoroughly clean up the cum, savoring the salty taste of his seed before shifting back onto his torso.\n\n");
			doNext(loverZenjiShowoffYesCleanEnding);
		}
		public function loverZenjiShowoffYesCleanEnding():void {
			outputText("Now satisfied, you caress his face gently, nuzzling against him softly. Zenji growls affectionately, contented with your thorough cleaning of him.\n\n");
			outputText("After a deep breath, Zenji speaks up, \"<i>I just need a moment ta rest… I’d love ta do dis again sometime…</i>\"\n\n");
			outputText("You smile, it is an option to consider again for later.\n\n");
			outputText("You decide to take your leave in accordance with his wishes.");
			if (silly()) {
				outputText(" As you get off of him, a devious thought crosses your mind. You quickly make a break for it, grabbing his loincloth and prying it off of his body.\n\n");
				outputText("\"<i>H-hey!</i>\" Zenji shouts, trying to sit up. \"<i>Ughhhh, just take it…</i>\" He states breathlessly, falling back down, now completely naked.\n\n");
				outputText("You smirk, dropping his loincloth just a few feet away from him. His naked body now on display for everyone to see, with his loincloth so close and yet just out of reach.");
			}
			outputText("\n\n");
			endEncounter();
		}

		public function loverZenjiComfort():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (player.tallness < 54) {
				outputText("For a moment you look up at him. You lose your train of thought, forgetting what you wanted to talk about. His indomitable stature stands before you, and for a moment, you feel helpless before him. All you want is to be held within his grasp.\n\n");
				outputText("Zenji looks down at you, \"<i>¿Pasa algo malo, flaca?</i>\" He asks, \"<i>It’s alright, I’m here. I will always be here for ya.</i>\"\n\n");
				outputText("He kneels before you, wrapping you within his big, strong arms. \"<i>Everyting will be alright, for as long as I am with you.</i>\" Zenji sweeps you off the ground, cradling you with paternal gentleness.\n\n");
				outputText("For a fleeting moment, you feel that everything truly will be alright as long as he’s here. You rest your head against his muscular torso as Zenji gently rocks you back and forth. He begins humming softly, his deep voice reverberates through you.\n\n");
			}
			else if (player.tallness < 68) {
				outputText("For a moment you look up at him. You lose your train of thought, forgetting what you wanted to talk about. His indomitable stature stands before you, and for a moment, you feel helpless before him.\n\n");
				outputText("Zenji looks down at you, \"<i>¿Pasa algo malo, flaca?</i>\" He asks, \"<i>It’s alright... I’m here, I will always be here for ya.</i>\"\n\n");
				outputText("He moves in closer, wrapping you within his big, strong arms. \"<i>Everyting will be alright, for as long as I am with you.</i>\" Zenji sweeps you off the ground, cradling you with paternal gentleness.\n\n");
				outputText("For a fleeting moment, you feel that everything truly will be alright as long as he’s here. You wrap your arms around his neck as you rest against his muscular torso, returning the embrace. He begins humming softly, his deep voice reverberates through you.\n\n");
			}
			else {
				outputText("For a moment your gaze locks with his, your train of thought escapes you as you stare into his ashen green eyes. Something about his gaze towards you speaks to you, his stare is almost intimidating, and for a moment, you feel helpless before him.\n\n");
				outputText("You almost didn’t notice his lips move, but you’re shaken into reality when you hear his voice, \"<i>¿Pasa algo malo, flaca?</i>\" He asks, \"<i>It’s alright... I’m here, I will always be here for ya.</i>\"\n\n");
				outputText("He moves in closer, wrapping you within his big, strong arms. \"<i>Everyting will be alright, for as long as I am with you.</i>\"\n\n");
				outputText("For a fleeting moment, you feel that everything truly will be alright as long as he’s here as you return the embrace, gently pressing against him as he clutches you tighter. He begins humming softly, his deep voice reverberates through you.\n\n");
			}
			outputText("After a moment of being held within his protective grasp, Zenji gently rests you on the ground as he gives you an affectionate headpat.\n\n");
			outputText("\"<i>Stay strong, [name]. I know you are one of a kind, you are unbeatable, even if ya just don’t know it.</i>\"\n\n");
			outputText("He leans close, rubbing his tusk affectionately along your face as his soft tail gently wraps around you. He holds himself close to you with a contented sigh before speaking up, \"<i>If ya ever need anything from me, I’ll always be here.</i>\"\n\n");
			outputText("You thank him before dismissing yourself. The warmth of his presence echoes within your body, reminding you of your connection with him.\n\n");
			dynStats("cor", -0.5);
			if (player.statusEffectv1(StatusEffects.ZenjiPreparationsList) < 15) player.addStatusValue(StatusEffects.ZenjiPreparationsList, 1, 1);
			ZenjiTalkCount++;
			doNext(loverZenjiTalks);
			advanceMinutes(5);
		}

		public function loverZenjiFood():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("Before you can start, Zenji has already cut you off. \"<i>Ya know, I've been doin’ some huntin’ around ya camp... I got some food for ya.</i>\"\n\n");
			outputText("Zenji grabs your wrists with gentle dominance, the soft furry texture of his hands tickle you slightly as he places something wrapped within leaves into your palm.\n\n");
			outputText("\"<i>Just a little meat I cooked fa ya. Algo especial para ti, flaca.</i>\"\n\n");
			outputText("You're at a loss for words, you didn't expect such a nice gesture. You thank him for his gift and be sure to repay the favor.\n\n");
			outputText("\"<i>Nah, ya don' have to worry about it, I'd do anything for you, [name]. Remember that I'll always be here for ya.</i>\" He pulls you in for a gentle kiss on the lips, he leaves you be once he ends the embrace.\n\n");
			if (player.statusEffectv1(StatusEffects.ZenjiPreparationsList) < 15) player.addStatusValue(StatusEffects.ZenjiPreparationsList, 1, 1);
			ZenjiFood = true;
			inventory.takeItem(consumables.ZENJI_H, loverZenjiTalks);
			ZenjiTalkCount++;
			advanceMinutes(5);
		}

		public function loverZenjiGiveItem():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you want to give him something.\n\n");
			outputText("Zenji raises an eyebrow, \"<i>Have someting to share whit me, do ya?</i>\"\n\n");
			outputText("You nod and search through your pockets, ready to pull out a gift for him.\n\n");
			menu();
			if (player.hasItem(consumables.CLEARLN) || player.hasItem(consumables.ROUGHLN) || player.hasItem(consumables.SEXY_LN) || player.hasItem(consumables.SMTH_LN)) addButton(0, "Lotion", loverZenjiGiveItemLotion).hint("Give him some lotion to smooth out his cozy fur.");
			else addButtonDisabled(0, "Lotion", "Need 1 of any Lotion bought at Rathazul shop. (wip tooltip)");
			if (player.hasItem(consumables.GROPLUS)) addButton(1, "GroPlus", loverZenjiGiveItemGroPlus).hint("Increase the size of certain parts.");
			else addButtonDisabled(1, "GroPlus", "You do not have this item to offer.");
			if (player.hasItem(consumables.REDUCTO)) addButton(2, "Reducto", loverZenjiGiveItemReducto);
			else addButtonDisabled(2, "Reducto", "You do not have this item to offer.");
			if (player.hasItem(consumables.TROLFIG)) addButton(3, "TrollFig", loverZenjiGiveItemTrollFig).hint("Give Zenji a troll fig, he must like them, right?");
			else addButtonDisabled(3, "TrollFig", "You do not have this item to offer");
			addButton(4, "Back", loverZenjiGiveItemBack);
		}

		public function loverZenjiGiveItemLotion():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (player.hasItem(consumables.CLEARLN)) player.consumeItem(consumables.CLEARLN);
			else if (player.hasItem(consumables.ROUGHLN)) player.consumeItem(consumables.ROUGHLN);
			else if (player.hasItem(consumables.SEXY_LN)) player.consumeItem(consumables.SEXY_LN);
			else if (player.hasItem(consumables.SMTH_LN)) player.consumeItem(consumables.SMTH_LN);
			outputText("You reveal a small bottle of oil and tell him it's a special lotion for his hair.\n\n");
			outputText("Zenji raises his eyebrow at you inquisitively as you show him the bottle. \"<i>My hair is naturally soft, it just is de way most trolls are. I mean, of course, I do take good care of my hair as well.</i>\"\n\n");
			outputText("You nod your head and tell him this will give him that extra edge for being cuddly.\n\n");
			outputText("Zenji gives you a soft smile as he nods back, signifying that he's ready for the oil. You uncork the bottle of lotion, lathering some on your hands before gently applying the contents onto his soft hair.\n\n");
			outputText("He snickers softly as you lather his hair in the lotion. \"<i>Ha, ahaha! Careful!</i>\" He squirms slightly, obviously a bit ticklish, but his face tells you that he's enjoying it. You make way with lathering the lotion all over his body, coating his hair in the slick salve, and thoroughly rubbing it in.\n\n");
			outputText("You slide your fingers across his muscular arm. It can be hard to notice sometimes, but you can see and feel his bicep veins underneath all the hair. You continue massaging the lotion into his hair, getting a feel for his toned triceps and dense biceps. As you move to his other arm, he raises it for you, flexing his massive biceps, showing off just how muscular he is. As you rub your fingers through his solid arm he gives you a smug grin, hoping to entice you with just the size of his body alone. \"<i>Yeah, I have been working out as ya can see…</i>\"\n\n");
			outputText("You smirk in response, he can be such a showoff sometimes, but it is kind of cute.\n\n");
			outputText("You rub your hands along his shoulders before working towards his manly pectorals. You feel his pecs twitch slightly at your touch as you apply the cool lotion.\n\n");
			outputText("As your hands reach his collar, you clasp your fingers around the colorful beaded necklace around his neck. It’s simple and doesn’t seem like it’s made with anything too expensive.\n\n");
			outputText("Zenji gives you a gentle smile, \"<i>My mother made dat for me when I was younger, you may touch it, but be careful. It means a lot to me, and I’m lettin’ ya touch it because ya mean a lot to me as well.</i>\"\n\n");
			outputText("You rub beneath his necklace for a moment before you continue groping at his strong, manly pectorals, digging your fingers beneath his soft hair. You search around, you’re not sure if he even has nipples, if he does they’re well hidden behind his hair. You eventually roam your fingers and find the unmistakable form of his areola, you tweak at them gently.\n\n");
			outputText("Zenji flinches, his pectorals twitching in response to your handsy approach, \"<i>Ah! Ten c-cuidado conmigo, flaca. Gentilmente por favor... C-careful...</i>\"\n\n");
			outputText("You gently lower your grasp, but he lifts your hand back to his nipple, \"<i>I didn’t tell ya ta stop though…</i>\"\n\n");
			outputText("You snicker in response, gently kneading at his pectorals. Eventually, you continue to his firm abs, they’re denser than stone. You spend a moment, slowly inching down his navel, stroking the darker colored hair just above his groin. Zenji blushes slightly before you move on. You work towards his thick, muscular back. You make a stop beneath his armpits, rubbing your hands through his soft hair.\n\n");
			outputText("Something about his underarms is intriguing to you. Do you want to give his pits a little more attention?\n\n");
			menu();
			addButton(1, "Yes", loverZenjiGiveItemLotionYes);
			addButton(3, "No", loverZenjiGiveItemLotionNo);
		}
		public function loverZenjiGiveItemLotionYes():void {
			outputText("You rub your fingers beneath his underarms. He brings his hands up behind his head, flexing both of his arms for you.\n\n");
			outputText("\"<i>Ya seem ta like dat, dontcha..?</i>\" Before you can react Zenji has forcefully shoved your face into his armpit. You struggle briefly but quickly come to accept him. \"<i>Go ahead, take a sniff, [name]. Ya know ya want to, I see de way you’ve been eyeing me.</i>\"\n\n");
			outputText("You bury your head deeper into his pits, they’re so dense, muscular, and fuzzy. Something about his gentle musk is enthralling. It’s a mix of sweat, rain, and grass, combined into a pleasant earthy aroma. It's intoxicating, you can't resist getting in closer to the faint beads of sweat trapped within his fur.\n\n");
			outputText("You press your nose against his fur, he lowers his flexing arm to pull you closer to him, locking you beneath his pit. You feel a little dizzy from his overwhelmingly masculine aroma. You continue sniffing him, it’s almost too intense and his aura has gotten you even more flustered. You need him more than you ever had before. His presence has you completely enraptured.");
			outputText("\"<i>Hah, dis is de price ya pay fa being a curious little tease. Ya better like it, because you’re trapped here now.</i>\"\n\n");
			outputText("Zenji shifts you around beneath his hairy underarm as you breathe in his scent. His muscular arms hold onto you, keeping you locked beneath him. His tail curls around you as well, gently stroking your lower back.\n\n");
			outputText("You stick your [tongue] out onto his dense fur. You can taste the faint salt of his sweat at the very tip of his hair.\n\n");
			outputText("You feel his voice reverberate through you in a low growl, \"<i>Yeah… give it a lick, ya want dis, don’tcha..? Taking it all in… Worship your big bad troll...</i>\"\n\n");
			outputText("You give his dense armpits a soft lick, the extra tuft of fur beneath his pit is earthy and salty. Zenji exhales slowly as you play around with him a little more.\n\n");
			outputText("After a moment of breathing in his scent and giving his pits the love and attention it deserves, Zenji releases you to continue the massage, but not before giving you a brief pat on the head.\n\n");
			doNext(loverZenjiGiveItemLotionNo);
		}
		public function loverZenjiGiveItemLotionNo():void {
			outputText("As you continue massaging him, you sometimes forget just how toned he is beneath all that hair, he’s not just thick, he’s chiseled. You run your fingers over his burly form before you move towards his back. It truly is a beautifully chiseled back, you can’t help but take a moment to admire his impressive musculature.\n\n");
			outputText("You feel his normally tense body relax for a moment as you gently massage him, your arms roaming over his form. He gives a soft sigh in your ministrations, his gaze fixated on you, licking his lips slowly. Despite the silence between you two, his eyes say more than he ever could. The longing he has for you, the affection he wants to give you, and the unyielding protection he will give you within arms reach. Before you're finished coating the rest of his hair in the lotion, he abruptly pulls you in for a hug, his hair even softer than before.\n\n");
			outputText("\"<i>Neva change [name]... You complete me, I will always love you.</i>\" He pulls you closer into his embrace. His kiss is slow and firm, filled with the passion of someone who would take their life for you. You run your fingers through his beard as his hands roam around your form for a moment. He gives you a loving squeeze before breaking the link, \"<i>I'm with you [name], don't you forget it, there is always someone out there for you in dis world.</i>\"\n\n");
			outputText("You grin at him softly, but you’re not finished yet. Zenji smiles at you in response. Your hands roam behind him, groping his perfectly shaped behind as your hands work to his tail. His tail sways softly in your grasp, gently worming around in barely contained excitement. You pull on his tail slightly, feeding your hands down his length as you make sure to coat the rest of his tail in the oil. You make sure to gently close your fingers around the tuft of hair at the tip of his tail. It’s incredibly soft and inviting.\n\n");
			outputText("Once his tail is finished, you work down his toned legs, making sure not to neglect any inch of his toned, hairy body. Zenji flexes his legs softly for you as you work your way down to his muscular calves. Once you’re finished coating every last inch of his legs you look up at him, asking if he likes the present you gave him as you stand up.\n\n");
			outputText("He gently strokes the top of your head, his longing gaze set on your eyes. \"<i>Thank you for de lotion, it was a nice present.</i>\" He rubs a hand through his chest tuft, \"<i>I can feel de change already, I like it.</i>\" He grabs your hand, gliding you over his chest as well, \"<i>I hope you'll enjoy it more dan I will though...</i>\" he remarks, giving a soft smirk.\n\n");
			outputText("You tell him that is something for a little later as you slowly pull away from him.\n\n");
			outputText("Alright, alright, jus' tell me when ya want ta do someting later, Dere's someting I need ta check up on. \"\n\n");
			doNext(loverZenjiGiveItem);
		}

		public function loverZenjiGiveItemGroPlus():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You pull out a small needle filled with a blue liquid, \"GroPlus\" written on the label of it. You tell Zenji that if he's not against it, you'd like to spice up a few things between the two of you.\n\n");
			outputText("Zenji raises an eyebrow as he examines the needle, \"<i>And jus' what didja wanna change?</i>\"\n\n");
			outputText("You consider that for a moment.\n\n");
			menu();
			addButton(1, "Penis", loverZenjiGiveItemGroPlusPenis);
			addButton(2, "Tusks", loverZenjiGiveItemGroPlusTusks);
			addButton(4, "Never mind", loverZenjiGiveItemGroPlusNevermind);
		}
		public function loverZenjiGiveItemGroPlusPenis():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You give him a sultry smile as you stroke his legs, telling him that you think he could be a little bigger downstairs.\n\n");
			if (silly()) {
				outputText("Zenji blushes softly, \"<i>Now, now… You don’t know how hard it is, being a troll looking de way I do…</i>\"\n\n");
				outputText("You tell him that he doesn’t know how hard it is, being a champion looking at a troll looking the way he does.\n\n");
				outputText("\"<i>I can’t help it…\" He replies, \"I’m not bad… I’m just… written dis way…</i>\"\n\n");
			}
			else outputText("Zenji gives a small chuckle, \"<i>Of course dat's what you'd want, Alright, so be it.</i>\"\n\n");
			if (player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32) {
				outputText("Zenji shakes his head, \"<i>Ay, Dios mio, [name], I am already big enough. If dis gets bigger, den I won’t be able ta handle it.</i>\"\n\n");
				outputText("Zenji has his mind set, you know you can’t get him to grow any larger.\n\n");
			}
			else {
				outputText("Zenji pulls down his loincloth, revealing all " + (player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 15 ? "7 and a half inches of his glory":"12 inches of his manhood") + ". He injects the needle into the base of his shaft, he grits his teeth slightly as he does so. You wince at the sight of it all, but the change is instant, you see him twitch slightly before his shaft swells, growing in length and girth. You gently grab his length, it's about "+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 15 ? "12 inches long and 2.4 inches wide now":"16 inches long and 2.6 inches wide now")+".\n\n");
				if (player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 15) outputText("\"<i>Happy?</i>\" He asks, looking softly into your eyes, \"<i>Dis be some weird stuff, but I don't care, I just wanna be there fa ya.</i>\" He pulls back his loincloth over his length, \"<i>I suppose you'll find out how much ya like it next time we get closer... But for now, I just want ta be left alone, dis doesn’t feel right, but I know it'll be fine in a bit.</i>\"\n\n");
				else outputText("Zenji’s brow furrows as he bites his lower lip in slight disgust, \"<i>I hope you’re happy with da choices you’ve made.</i>\" He shakes his head softly, scolding himself slightly. \"<i>Please, leave me alone, I need… I need some time ta myself… Sorry for de outburst.</i>\"\n\n");
				outputText("Zenji gives you a quick peck on the lips before dismissing you, you pack up your things and leave him alone as per his wishes.\n\n");
				outputText("You can’t help but turn back to look at him. His loincloth now too short to hide his manhood.\n\n");
				if (player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 15) player.addStatusValue(StatusEffects.ZenjiModificationsList, 3, 9);
				else player.addStatusValue(StatusEffects.ZenjiModificationsList, 3, 8);
				player.consumeItem(consumables.GROPLUS);
			}
			doNext(loverZenjiGiveItem);
		}
		public function loverZenjiGiveItemGroPlusTusks():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (player.statusEffectv4(StatusEffects.ZenjiModificationsList) == 1) {
				outputText("You tell Zenji that you miss his old, larger tusks and want to feel the safety of them once more.\n\n");
				outputText("\"<i>Really?</i>\" he asks, giving you an inquisitive look, \"<i>Sure... If that's what you want, then so be it. I was kinda missing my old tusks anyway.</i>\" Zenji reaches a hand up to his lips, pulling them back as he takes the needle in the other hand and injects the liquid into the base of his tusks. He takes a sharp breath as he does so.\n\n");
				outputText("It doesn't take long before you notice his small nibblers grow back into his much larger, original tusk length. You see him shake his head briefly.\n\n");
				outputText("\"<i>Back to my big tusks again!/i>\" He gives you a longing look, \"<i>Is dis what you like? You like my tusks big and strong like dis?</i>\"\n\n");
				outputText("You nod, why else would you have asked him for this?\n\n");
				outputText("Zenji gives you a small smile before giving you a loving hug, \"<i>Always full of surprises...</i>\" He whispers as he gently strokes your back. He pulls back slightly, resting his chin on your head. \"<i>Dis'll take some time ta get used to, if ya need me though, I'll be here.</i>\"\n\n");
				outputText("Zenji releases you from his embrace and you dismiss yourself, packing up your things, ready to continue your day.\n\n");
				outputText("As you’re leaving, you see Zenji placing his rings back on his tusks.\n\n");
				player.addStatusValue(StatusEffects.ZenjiModificationsList, 4, 6);
				player.consumeItem(consumables.GROPLUS);
			}
			else outputText("Zenji shakes his head, \"<i>Now, now [name], I know deep down dat ma tusks are fine de way dey are, any bigger and it’ll hurt ma neck keeping it up all de time.</i>\"\n\n");
			doNext(loverZenjiGiveItem);
		}
		public function loverZenjiGiveItemGroPlusNevermind():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("After a second thought, you decide that you don’t want to increase the size of anything personal to him. You put it away, stating that you’ve decided against it.\n\n");
			outputText("Zenji nods respectfully.\n\n");
			doNext(loverZenjiGiveItem);
		}

		public function loverZenjiGiveItemReducto():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You pull out a foul-smelling salve, he recoils immediately from the stench. You tell him that this will reduce the size of some of the things in your way.\n\n");
			outputText("Zenji raises his eyebrow at you, \"<i>And just what d’ya mean by dat?</i>\"\n\n");
			menu();
			addButton(1, "Penis", loverZenjiGiveItemReductoPenis);
			addButton(2, "Tusks", loverZenjiGiveItemReductoTusks);
			addButton(4, "Never mind", loverZenjiGiveItemReductoNevermind);
		}
		public function loverZenjiGiveItemReductoPenis():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 15) {
				outputText("Zenji nods softly, \"<i>Now, now [name] I really don tink dat’s a good idea…</i>\"\n\n");
				outputText("You peer at him searchingly but he is intent on not being any smaller.\n\n");
			}
			else {
				outputText("You tell him that you'd rather his length be smaller, you like it better that way.\n\n");
				outputText("Zenji gives a soft sigh, \"<i>Alright, if dat's what ya want, den so be it.</i>\"\n\n");
				outputText("He grabs the foul scented salve as he pulls down his loincloth. He lathers the cream over his length, rubbing it in. It doesn't take long before his length reduces in size, returning to being "+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? "12 inches long and 2.4 inches wide":"7.5 inches long and 2.2 inches wide")+".\n\n");
				outputText("\"<i>Like dis, [name]?</i>\" He asks, examining his shaft.\n\n");
				outputText("You nod, exactly how you wanted him.\n\n");
				outputText("Zenji gives you a small pat on the head, \"<i>Ya gotta keep ya mind set, I don' wanna be changing all de time, but I will for you, of course.</i>\" He pulls you in for a brief hug.\n\n");
				outputText("You break his embrace and dismiss yourself as you pack up your things, ready to continue your day.\n\n");
				if (player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32) player.addStatusValue(StatusEffects.ZenjiModificationsList, 3, -8);
				else player.addStatusValue(StatusEffects.ZenjiModificationsList, 3, -9);
				player.consumeItem(consumables.REDUCTO);
			}
			doNext(loverZenjiGiveItem);
		}
		public function loverZenjiGiveItemReductoTusks():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (player.statusEffectv4(StatusEffects.ZenjiModificationsList) == 7) {
				outputText("You tell Zenji that you'd think you'd be able to enjoy him more if his tusks weren't so obstructive.\n\n");
				outputText("Zenji gives you a shocked glance, blushing before rubbing his tusks in shame, \"<i>Dey... Dey're dat bad?</i>\"\n\n");
				outputText("You tell him it's not like that, but you think you could be a little closer to him if you could feel closer to him.\n\n");
				outputText("Zenji gives you a pained smile, \"<i>If dat’s... If dat is what you want... Den I'll do it... for you.</i>\"\n\n");
				outputText("Zenji spends a moment removing the rings from his left tusk.\n\n");
				outputText("He grabs the foul scented salve before quickly lathering the cream over his tusks. The change is quick as his tusks retreat, shrinking down to short one inch nibblers peeking just outside his mouth.\n\n");
				outputText("Zenji bits his lips briefly, before rolling his tongue in his mouth, \"<i>Do... Do you like me better like this? Do you think I look better like this, with small tusks?</i>\" He asks, his lisp not as apparent anymore.\n\n");
				outputText("You give him an affectionate caress on the cheek, you've always loved him, you think he'll always look good, but now you can finally do this.\n\n");
				outputText("You pull him in, kissing him witlessly, he is shocked for a moment, but after your advance he pulls you closer to him, returning the favor. Soon he presses you onto the ground.\n\n");
				outputText("\"<i>You know I love you too… I've always wanted to do something like this...</i>\"\n\n");
				outputText("He lifts your [armor] before giving you a loving lick over your stomach, his tongue is wet and sticky, you shudder in delight as he makes his way up to your chest. He moves upward and gives you a peck on the cheek.\n\n");
				outputText("\"<i>I guess there's always a reason to look for the good things when given a chance,</i>\" he states with a content smile.\n\n");
				outputText("You give him a small laugh, glad he's enjoying his new tusks. Zenji helps you up before giving you a small nuzzle. \"<i>Thank you, [name], this will be interesting, I'm glad ya could help me discover something new.</i>\"\n\n");
				outputText("He presses his forehead against yours before standing up, bringing you with him. After a moment together you’re ready to continue your day.\n\n");
				player.addStatusValue(StatusEffects.ZenjiModificationsList, 4, -6);
				player.consumeItem(consumables.REDUCTO);
			}
			else outputText("Zenji gives you an inquisitive look, \"<i>Now then, [name], I like my tusks. They’re pretty small, I’m not just gonna get rid of them.</i>\"\n\n");
			doNext(loverZenjiGiveItem);
		}
		public function loverZenjiGiveItemReductoNevermind():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("After a second thought, you decide that you don’t want to decrease the size of anything personal to him. You put it away, stating that you’ve decided against it.\n\n");
			outputText("Zenji nods respectfully.\n\n");
			doNext(loverZenjiGiveItem);
		}

		public function loverZenjiGiveItemBack():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("As you search through your pockets you realize that you don't have anything of interest to offer. You apologize for raising his hopes.\n\n");
			outputText("Zenji gives you a sideways glance, \"<i>Alright den, if ya change your mind or find someting special fa me, I'll be here.</i>\" He pulls you in for a hug, \"<i>I'll always be here for you...</i>\" He whispers before releasing you.\n\n");
			doNext(loverZenjiMainCampMenu);
		}

		public function loverZenjiGiveItemTrollFig():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			player.consumeItem(consumables.TROLFIG);
			player.addStatusValue(StatusEffects.ZenjiModificationsList, 2, (250 + ZenjiFigMulti));
			ZenjiFigMulti += 25;
			outputText("You tell Zenji that you found something a little more special that you think he’d be interested in.\n\n");
			outputText("Zenji raises an eyebrow inquisitively, \"<i>Ah..? Someting... special ya say?</i>\"\n\n");
			outputText("You nod as you reach into your pockets and pull out a small, hairy fig. Zenji’s eyes light up as soon as he sees the piece of fruit.\n\n");
			outputText("\"<i>[name], is dat… Where did ya get dat?</i>\"\n\n");
			outputText("You nod, it’s a fig, you tell him that it doesn’t matter where you got it, what matters is being able to share something he likes with him and to make him happy.\n\n");
			outputText("Zenji gives you a soft smile, \"<i>[name]... I dunno what ta say… Tank you. You know dey say, ‘Don’t feed da troll’, but I like it when ya give me food. Dis is really kind of ya. It was so hard fa me ta find any of dese on my own, but ya really seem ta have an eye fa finding interesting tings.</i>\"\n\n");
			outputText("You tell Zenji to bring "+(player.tallness < 78 ? "you up so you can feed him. He wraps you within his strong arms, pulling you close to him. You gently caress his cheek once you’re finally pressed against him":"his face to you so you can feed him. He gives you a gentle smile as he draws closer. Once he’s near, you gently caress his cheek")+".\n\n");
			outputText("He opens his mouth for you, awaiting the treat as you gently press it onto his tongue. He happily closes his mouth, staring directly at you with trusting eyes. After chewing for a moment he finally swallows. \"<i>Ya found a juicy one, dey’re de best ones.</i>\" He states. \"<i>Dat’s de good stuff, thank you, [name].</i>\"\n\n");
			outputText("Zenji pulls you in for a hug, \"<i>Neva change, you are always filled with surprises.</i>\" He gives you a warm smile before pulling you into a soft kiss.\n\n");
			outputText("You tell him that you’re always happy to make him happy.\n\n");
			if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 998700) {
				outputText("You can feel even more cum run down your [legs]. You look up and Zenji is panting softly as he tries to give you a cheeky grin.\n\n");
				outputText("Zenji moans softly, \"<i>I… I tink I’m at my limit, [player]... I can’t hold it anymore...</i>\"\n\n");
				outputText("There is so much cum, it quickly pools at your [feet]. You have turned him into a non-stop geyser of cum, it looks like Zenji will never stop at this point.\n\n");
				awardAchievement("Virility God", kACHIEVEMENTS.GENERAL_VIRILITY_GOD, true, true);
			}
			else if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 98700) {
				outputText("You feel something dribble along your [legs]. You look up to Zenji giving you a coy grin.\n\n");
				outputText("\"<i>Well, ya can’t tell me dis isn’t whatcha wanted, right?</i>\"\n\n");
				outputText("You look at his flaccid length, it is dribbling a steady stream of precum.\n\n");
				outputText("\"<i>I don’t tink it’s eva gonna stop, but… Well… I tink we’ll get used t’ it, right?</i>\"\n\n");
			}
			else if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 1700) {
				outputText("As he pulls away, Zenji looks down at his groin expectantly, \"<i>Mmm, it feels so warm… I know you love dis, don’tcha? Dis is exactly what ya wanted, right?</i>\"\n\n");
				outputText("You nod, it is a pleasant benefit from giving him a nice treat.\n\n");
			}
			else outputText("As he pulls away, Zenji looks down at his groin, \"<i>Aha, I didn’t expect someting like dis from you, [name]. Dat’s one of de weird, wild figs…</i>\" He chuckles softly before looking back at you, \"<i>Let’s just say you’ll be in for a little surprise later…</i>\"\n\n");
			doNext(loverZenjiGiveItem);
		}

		public function loverZenjiSex():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You ask Zenji if he's willing to get a little intimate with you.\n\n");
			if (player.statusEffectv3(StatusEffects.ZenjiZList) > 3) {
				outputText("\"<i>¡Qué conchudo! Can’t keep yaself away from me, can ya, [name]?</i>\" Zenji replies teasingly.\n\n");
				outputText("\"<i>I take it you really want dis, you rascal. You want your big bad troll all to yaself. Perhaps I can put you in your place dis time.</i>\" he states with a taunting grin.\n\n");
			}
			else {
				if (player.hasCock() && !player.hasVagina()) outputText("\"<i>You’d like dat, wouldn’tcha, you want to be dominated by me. You need a big strong troll with you, don’t deny it. Gotta say, I’ve been resisting dese feelings for another man for some time now, nothing better than claiming a nice guy like you…</i>\"\n\n");
				else if (player.lib >= 85) {
					outputText("Zenji sniffs the air intently around you, not paying attention to what you just said. \"<i>[name]...\" He croons, \"Dat smell you give off…</i>\" He leans in closer, pressing his massive frame against your body, pinning you beneath him. \"<i>You smell so good… I need ta get ta know you more…</i>\"\n\n");
					outputText("Zenji gives you a long, loving lick across your cheek, \"<i>I know you need it just as much as I do, I need you so badly, [name]... You smell so good… Please [name], I need you now, right now.</i>\" He looks into your eyes with overeagerness, his tail wraps around you in anticipation.\n\n");
					outputText("His breath stutters, he’s desperate to take you now, you can tell that he wants to breed you, claim you as his. You’ve pushed him into a rut with your very presence. What do you want to do with him?\n\n");
				}
				else outputText("He eyes the camp warily before giving a small chuckle, \"<i>When I first met you… I never thought I’d want to get this close to you… but all dat training, all dose spars…</i>\" Zenji’s eyes stray for a moment before returning to yours, \"<i>Well, your beauty is captivating, [name].</i>\" Zenji pauses for a moment, taking in a small breath, \"<i>What didja have in mind?</i>\" he asks, gently caressing your cheek.\n\n");
			}
			menu();
			addButton(3, "Blow Him", loverZenjiSexBlowHim).hint("Perform fellatio on Zenji");
			addButton(4, "Cuddle", loverZenjiSexCuddle).hint("Spend an intimate moment with Zenji");
			if ((player.isBiped() || player.isNaga()) && player.lib >= 85) addButton(11, "Tease", loverZenjiSexTease).hint("Subdue Zenji beneath your heel (or tail) and make a mockery out of his lust ridden state.");
			else {
				if (player.lib < 85) addButtonDisabled(11, "Tease", "You aren't lewd enough to consider mocking him right now.");
				else addButtonDisabled(11, "Tease", "You do not have the correct lower body for this scene.");
			}
			addButton(14, "Never mind", loverZenjiSexNevermind).hint("Decide that you do not want to have sex anymore.");
			if (player.lust > 33) {
				addButton(0, "Take Anal", loverZenjiTakeAnal).hint("Have Zenji penetrate you anally.");
				if (player.hasVagina()) addButton(1, "Take Vaginal", loverZenjiTakeVaginal).hint("Have Zenji penetrate you vaginally.");
				else addButtonDisabled(1, "Take Vaginal", "You need a vagina for this scene.");
				if (player.smallestCockArea() < 46) addButton(2, "Pitch Anal", loverZenjiPitchAnal).hint("Penetrate Zenji anally");
				else addButtonDisabled(10, "Get Blown", "Your dick is too big for him.\n\nZenji is a big guy, but even he has his limits!");
				if (player.isPregnant()) addButton(5, "Pregnant Sex", loverZenjiPregnantSex).hint("Zenji seems to eye your pregnant form with interest.");
				else addButtonDisabled(5, "Pregnant Sex", "You need to be pregnant for this.");
				if (flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] >= 4) addButton(6, "Hot Spring", loverZenjiHotSpring).hint("Enter the hot spring with Zenji.");
				else addButtonDisabled(6, "Hot Spring", "You have not yet built a Hot Spring.");
				if (player.hasVagina()) addButton(7, "Get Fingered", loverZenjiSexGetFingered).hint("Have Zenji put his thick fingers to good use.");
				else addButtonDisabled(7, "Get Fingered", "You need a vagina for this scene.");
				if (player.hasCock()) addButton(8, "Get Handjob", loverZenjiSexGetHandjob).hint("His hands are so luxuriously soft, put them to good use.");
				else addButtonDisabled(8, "Get Handjob", "You need a penis for this scene.");
				if (player.statusEffectv4(StatusEffects.ZenjiModificationsList) == 1) {
					if (player.hasVagina()) addButton(9, "Get Licked", loverZenjiSexGetLicked).hint("Have Zenji put that long tongue to good use.");
					else addButtonDisabled(9, "Get Licked", "You need a vagina for this scene.");
					if (player.hasCock()) {
						if (player.smallestCockArea() < 40) addButton(10, "Get Blown", loverZenjiSexGetBlown).hint("Have Zenji put his mouth to good use.");
						else addButtonDisabled(10, "Get Blown", "Your cock is too big.");
					}
					else addButtonDisabled(10, "Get Blown", "You need a penis for this scene.");
				}
				else {
					addButtonDisabled(9, "Get Licked", "Zenji's tusks are too big for this scene.");
					addButtonDisabled(10, "Get Blown", "Zenji's tusks are too big for this scene.");
				}
			}
			else {
				addButtonDisabled(0, "Take Anal", "You aren't turned on enough to consider this.");
				addButtonDisabled(1, "Take Vaginal", "You aren't turned on enough to consider this.");
				addButtonDisabled(2, "Pitch Anal", "You aren't turned on enough to consider this.");
				addButtonDisabled(5, "Pregnant Sex", "You aren't turned on enough to consider this.");
				addButtonDisabled(6, "Hot Spring", "You aren't turned on enough to consider this.");
				addButtonDisabled(7, "Get Fingered", "You aren't turned on enough to consider this.");
				addButtonDisabled(8, "Get Handjob", "You aren't turned on enough to consider this.");
				addButtonDisabled(9, "Get Licked", "You aren't turned on enough to consider this.");
				addButtonDisabled(10, "Get Blown", "You aren't turned on enough to consider this.");
			}
		}

		public function loverZenjiTakeAnal():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you want him inside you, you want to feel every inch of him in your backdoor.\n\n");
			if (player.ass.analLooseness == 0) {
				outputText("You tell him that he'll be the first one to take you.\n\n");
				outputText("Zenji raises an eyebrow, \"<i>You've waited dis long for someone special? Dat's some dedication, I am honored to do dis wit ya.</i>\"\n\n");
			}
			outputText("Zenji smiles softly as he takes off his loincloth, his manhood already semi-erect."+(player.isNaked() ? "":" He slowly helps you undress, his fuzzy fingers gently tickle your [skin] until you are fully naked.")+"\n\n");
			outputText(""+(player.isNaked() ? "He":"Once you've been stripped down, he")+" pulls you closer to him as he stares longingly into your eyes. You sink beneath his gaze, enjoying the feeling of his firm hand grope at your backside. You keep your body pressed tightly against his muscular torso as he gently slips a finger into your asshole. ");
			if (player.ass.analLooseness == 0) outputText("\"<i>We will go nice and slow, don’t worry…</i>\"\n\n");
			else outputText("\"<i>Don' worry, I will make dis special.</i>\""+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? " Zenji’s brow furrows at you, \"<i>I can’t believe you’re dat eager to take me when I’m dis huge... I guess since you want me big like dis so bad I’ll just have ta give ya exactly what you want.</i>\"":"")+"\n\n");
			outputText("He gently toys with your rear for a moment before shifting you around, setting your hands and knees on the ground.");
			if (player.tallness > 108) outputText(" Despite the fact that Zenji is smaller than you, he still acts like he’s the one with complete control.");
			if (player.tallness < 60) outputText(" His massive stature completely encompasses you.");
			outputText("\n\nYou don’t resist as his strong arms set you down, you’re ready for his entrance. You tell Zenji that you want him more than ever, you’re his now and he can do whatever he wants to your body.\n\n");
			outputText("Zenji can’t help but blush slightly at your words, getting even more flustered. He growls softly, positioning himself behind you. He spends a moment holding onto your waist before he grips the cheeks of your behind, groping you softly before splaying you out before him with a soft growl. His tail gently brushes against you as he gets closer.\n\n");
			outputText("His foreskin retracts as he becomes fully erect, precum leaking from his shaft. He gently places his fingers over his slit to lubricate his cock with his pre, aligning the tip of his length with your backdoor. He slowly presses into you as his hands roam back to your hips.\n\n");
			if (player.analCapacity() < 7) outputText("His lengthy shaft presses its way deep inside of your tight backdoor, you feel yourself stretch over his considerable manhood."+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? " Maybe making him so huge wasn’t the best idea.":"")+"\n\n");
			else if (player.analCapacity() < 7) outputText("His lengthy shaft presses into you, you can feel him accommodating your [ass] as he pushes further and further with each thrust.");
			else outputText("His lengthy shaft presses into you, you can feel him push into your roomy backside as he goes deeper into you with each thrust.");
			player.buttChange(15,true,true,false);
			outputText("\n\n\"<i>Dat's a good champion… Taking it all in one go.</i>\"\n\n");
			outputText("Zenji begins breathing heavily as he slowly thrusts into you, he does not keep the slow rhythm for long as he begins picking up the pace with each thrust. You can feel his toned legs press against you as he rocks your body with each thrust. His powerful body protectively over you, crashing against you with each pump.\n\n");
			outputText("You squirm in pleasure, but his dense hands keep you locked in place beneath him, you lean back, grabbing one of his fuzzy hands and guiding it to your chest and he follows, gently teasing your pecs with his soft fingers. You ");
			if (player.hasCock()) outputText("bring your grasp down as you begin masturbating yourself");
			else outputText("rub your fingers against your clit and begin fingering yourself in tandem with his thrusts");
			outputText(".\n\nYou sigh in pleasure as he tenderly fondles you, tweaking softly at your nipples with his soft, furry fingers. His muscular arm grazes your stomach, his pounding becomes more frantic as he steadily reaches his climax, you can feel yourself reaching the edge as well.\n\n");
			outputText("Zenji leans down further, his abs pressed against your back, completely wrapping you within his arms as he thrusts into you with tremendous vigor. You cry in delight as you finally climax, ");
			if (player.hasCock()) outputText("shooting ropes of cum all over the ground beneath you");
			else outputText(" girl cum leaking from your lips, sliding down your body");
			outputText(". Zenji isn't finished yet, he displays his superior endurance as he continues thrusting into you.\n\n");
			outputText("\"<i>Not. done. yet...</i>\" he says, gritting through his teeth.\n\n");
			outputText("He keeps pounding away at you, thrusting with firm strokes. You can feel his hefty balls brush up against you with each stroke as he lets loose a low growl. He's so close now, you beg for him to cum, you want to feel him, you need his seed inside you. Zenji is completely out of it, fucking you with complete wanton desire, desperate to fill you with his cum. Finally, with a tremendous howl and one last powerful thrust, Zenji climaxes within your ass. Your body quakes from the force of his impact as his dick throbs intensely, desperate to stuff your hole with everything he has to give. He lets out a deep sigh as he relaxes. ");
			if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 18700) outputText("You can feel yourself inflate from the warm seed flowing into you. Zenj holds onto you tighter, forcing you to take as much as possible. His growls grow louder as you’re filled well beyond your limit, excess cum pouring out onto the bedroll beneath you.");
			else if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 4700) outputText("He is pumping so much cum into you, it leaks out as you feel your stomach distend slightly from the copious load he has to offer as the rest stills out onto the bedroll beneath you.");
			else outputText("His load is dense, you feel yourself being filled by the sheer amount he has to offer.\n\n");
			outputText("\n\nZenji pulls out of you, copious strings of cum still leaking from the tip of his length as he pulls you around to face him. He stares longingly into your eyes once more as he leans forward, his tusks gently graze your cheeks as he plants a kiss on your lips. With no other choice, you fall into his caress. After a moment he breaks the embrace, but he still holds you tightly in his dense arms. He spends another minute embracing you before letting you go. He cleans you up before helping you get dressed.\n\n");
			outputText("\"<i>Don' hesitate to ask me for a favor like dis, I will always have de time for you,</i>\" he states as he stands up, ready to continue the day.\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 3, 1);
			player.sexReward("cum","Anal");
			endEncounter();
		}

		public function loverZenjiTakeVaginal():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you want him inside you, you want to feel every inch of him in your womanhood."+(player.hasVirginVagina() ? " ":"\n\n")+"");
			if (player.hasVirginVagina()) {
				outputText("You tell him that he'll be the first one to take you.\n\n");
				outputText("Zenji raises an eyebrow, \"<i>You've waited dis long for someone special?"+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? "</i>\" His eyes widen, \"<i>[name]! Are… are you sure you can handle dis?</i>\" You nod in reassurance, you wanted to make sure it will be something you can never forget.":"Dat's some dedication, I am honored to do dis wit ya.</i>\"")+"\n\n");
			}
			outputText("Zenji smiles softly as he takes off his loincloth, his manhood already semi-erect."+(player.isNaked() ? "":" He slowly helps you undress, his fuzzy fingers gently tickle your [skin] until you are fully naked.")+"\n\n");
			outputText("He pulls you close to him, your back pressed against his manly chest, seating you in his furry embrace. He leans down closer to you, giving your head a small sniff as he brings a finger up to his mouth, gently coating his finger in saliva before he reaches his hand down to your slick nether region. His other hand, still gently rubbing the underside of your chin, slowly makes its way down to your breasts as he teases you with just his hands alone. ");
			outputText("His hand rubs along the underside of your [allbreasts], gently roaming around your form and testing the limits of your own body. Soon the hand roaming down your body finds its way to your clit, gently fondling and toying around with you. You tremble beneath him, beads of lubricant drips down your [vagina] as he toys with you mercilessly. You can't take it anymore, you're squirming beneath his touch, you need him inside you now.\n\n");
			outputText("Zenji obliges to your silent wishes and turns you to face him, your hips pressed against his raging erection, straddled on his waist. ");
			if (player.tallness < 60) outputText("He wraps his toned arms around your form, cradling you within his massive presence as he pulls you up to his face for a gentle kiss.");
			else if (player.tallness < 108) outputText("He wraps his toned arms around your [skin] and pulls you in for a kiss, his tusks barely touch your cheeks as his tongue explores your mouth.");
			else outputText("He attempts to wrap his toned arms around your massive body as you lean down to kiss him, allowing his tongue to explore your mouth.");
			outputText("\n\nWithout breaking the kiss, he pulls you above his length, finally giving him a chance to penetrate you.\n\n");
			if (player.vaginalCapacity() < 10) {
				outputText("His manhood presses into your tight snatch, gently stretching out your walls. He feels so big inside you as he presses deeper, gently bucking into you."+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? " His shaft is so painfully large. Maybe making him so huge wasn’t the best idea.":"")+"\n\n");
				outputText("Zenji breaks the tender kiss for a moment, \"<i>So small, [name], you will grow to like it, don' worry, I will make sure of dat,</i>\" he says in a soft growling tone as his tail gently caresses your figure.\n\n");
			}
			else if (player.vaginalCapacity() < 80) outputText("His manhood presses into your moist snatch, gently pressing his way into you. He feels so good inside you as he presses deeper, gently bucking into you.\n\n");
			else outputText("His manhood presses into your moist snatch, gently digging his way into you. It doesn't take long before he starts bucking into you.\n\n");
			outputText("Zenji growls softly as he presses his way further into you. He moves in for another kiss, locking his lips with you, ensuring you’re tightly bound within his embrace."+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? " He is so huge, you can even see his length bulging through your stomach.":"")+"\n\n");
			player.cuntChange(15,true,true,false);
			outputText("Your breaths become gasps as you break the kiss with him, but he refuses to let you go and pulls you in. He holds you tightly, pressing you closer to him. You grasp onto the fuzz covering his arms as he thrusts into you with reckless abandon. His rhythm rocks you to your core, you can't help but moan in pleasure. Unable to take it anymore, you quickly approach your climax. You urge him to keep going. Zenji gives a soft growl in response as he picks up the pace slightly. ");
			if (player.hasCock()) outputText(" You finally cum, spewing jizz all over his muscular chest.");
			else outputText("You finally climax as your girlcum slowly leaks out of your vagina, further lubricating him.");
			outputText("\n\nZenji's breaths become shorter, but he doesn't change pace, he places a large hand on the back of your head and pulls you in for another kiss, careful not to let his tusks get in the way. You can feel his length twitch inside of you as he nears the edge. His grip on the back of your head tightens as he pulls you deeper into the kiss, hungrily making out with you. His erection pulses within you, twitching madly, desperate to breed and claim you as his. He groans loudly as before he gives you one last powerful thrust, cumming into your awaiting womb. His strong arms wrap around you, clutching you tightly against his muscular body, making sure you’re able to absorb as much of his cum as possible.  You can feel the warmth of his seed jet its way into you. ");
			if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 18700) outputText("You can feel yourself inflate from the warm seed flowing into you. Zenj holds onto you tighter, forcing you to take as much as possible. His growls grow louder as you’re filled well beyond your limit, excess cum pouring out onto the bedroll beneath you.");
			else if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 4700) outputText("His load is tremendous, you couldn’t hope to contain all the seed he’s unleashing as your stomach distends slightly as the rest spills out onto the bedroll beneath you.");
			else outputText("His load is dense, you feel yourself being filled by all the cum he’s pumping into you.");
			outputText(" Zenji finally lays down on his back as you're forced down with him. He spends a moment taking long breaths as you're heaved with the rhythm of his breathing atop his chest.\n\n");
			outputText("Spent, you spend a moment lying atop him, basking in the warmth of his soft fuzz. Zenji pulls out, still leaking cum as he slowly moves you over beside him as he shifts around to spoon you. His head resting just above yours as he pulls you close to him, \"<i>Ya really be someting, [name]. I'm glad ta be here wit ya... You are special to me, never forget it.</i>\"\n\n");
			outputText("You take the time in his afterglow, reveling in his soft touch before you decide that it's best to get ready to continue your day, despite what you may wish, you can't spend forever wrapped within your lover's embrace.\n\n");
			outputText("Zenji releases you, helping you clean up from the mess of his huge orgasm and get dressed. Finally, you are ready to continue your day.\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 3, 1);
			player.sexReward("cum", "Vaginal");
			if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
			else player.knockUp(PregnancyStore.PREGNANCY_ZENJI, PregnancyStore.INCUBATION_ZENJI);
			endEncounter();
		}

		public function loverZenjiPitchAnal():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			var x:int = player.cockThatFits(46, "area");
			outputText("You ask Zenji if he’s willing to let you pitch anal.\n\n");
			outputText("Zenji raises an eyebrow, \"<i>Are you… are you asking dat I take it from behind?</i>\"\n\n");
			outputText("You nod, if he’s okay with it, that is.\n\n");
			if (player.statusEffectv4(StatusEffects.ZenjiZList) > 0) outputText("Zenji glances around slightly nervously, \"<i>Sure… I won’t say dat I don’t like it.</i>\"\n\n");
			else {
				outputText("Zenji takes a deep breath \"<i>You’ll be de first one… I… Yes, dis is what I want, I want you to take me, [name].</i>\"\n\n");
				player.addStatusValue(StatusEffects.ZenjiZList, 4, 1);
			}
			outputText("Zenji kneels on his bedroll, \"<i>I… I’m ready for ya, [name].</i>\"\n\n");
			if (player.tallness < 60) outputText("You follow behind him, mounting his massive body to the best of your abilities while getting a good grasp of his frame. Your erection rises to full mast as you align it to his rear.");
			else if (player.tallness < 108) outputText("You follow behind him, your manhood already reaching full length as you align yourself with his rear. You ask him if he’s ready, he gives a quiet nod. You take a firm grasp on his muscular rear.");
			else outputText("Even kneeling, your sheer size towers over him. You coax your erection to full mast before aligning it to his rear.");
			outputText(" His ass is toned, sculpted, and perfectly symmetrical. You’re a little jealous of how perfect it is.\n\n");
			outputText("You slowly bring yourself to penetrate him, he breathes a deep sigh as you slide into his backdoor with little resistance. You place your hands on his hips as you continue thrusting. Zenji is mostly still for the encounter, unsure of what he should be doing.\n\n");
			outputText("You press yourself further into him. You"+(player.cocks[x].cockLength < 6 ? "’re unable to reach his prostate, but he seems to be enjoying himself nonetheless":"r length shaft prods at his prostate, he groans softly as you thrust into him")+".\n\n");
			outputText("You reach around over him, grabbing his throbbing manhood as you begin to jerk him off. You dig a finger underneath his foreskin, toying with his glans.\n\n");
			outputText("\"<i>Ah! [name]... D-don’t stop…</i>\" Zenji moans, his tail reflexively coils around your waist, holding onto you for support.\n\n");
			outputText("You obey his request as you continue jerking off his shaft. Zenji buries his face into his pillow, growling softly.\n\n");
			outputText("You continue thrusting, his ass is fairly tight as he slowly bucks against you, trying to get a feel for your length.\n\n");
			outputText("Trying to see if you can awaken something deeper within him, you buck into him as hard as you can.\n\n");
			outputText("Zenji yelps in response as you feel a surge of pre leak down onto your fingers.\n\n");
			outputText("You laugh at his vulnerability, he seems to enjoy it when you go rough, so you continue bucking into him with greater vigor. It doesn’t last long though as you feel yourself nearing your climax.\n\n");
			outputText("Zenji growls louder this time, his manhood throbbing even harder as you feel him shoot jets of cum onto his bedroll. "+(player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 4700 ? "So much cum is being released by him, practically painting the ground beneath in a massive pool of his seed. ":"")+"A familiar pressure builds within your loins as he tries to milk you of everything you’re worth. ");
			outputText("You groan loudly as you cum inside of his awaiting hole."+(player.cumQ() >= 3500 ? " Your load is massive as you continuously pump more cum into him. Zenji moans softly as his stomach distends slightly from the force of your efforts.":"")+"\n\n");
			outputText("\"<i>I need a bath…</i>\" Zenji whispers to himself.\n\n");
			outputText("The two of your slump down as Zenji pulls you closer to him, \"<i>Dis is nice, [name]...</i>\"\n\n");
			outputText("You tell him that you’re glad he’s enjoying himself.\n\n");
			outputText("After spending some time within his embrace you decide you should return to your day. Despite his wonderful ass, you can’t spend all day buried within him.\n\n");
			outputText("Zenji blushes slightly… \"<i>Ah… tanks [name]...</i>\"\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 3, 1);
			player.sexReward("no", "Dick");
			endEncounter();
		}

		public function loverZenjiSexBlowHim():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you think a special reward is in order for him, and you have just the gift for the occasion.\n\n");
			outputText("Zenji raises an eyebrow, \"<i>Ya safety and presence here wit me be reward enough, but I don' mind a little someting extra if you are feeling generous.</i>\"\n\n");
			outputText("You grin as you gesture for him to lean closer to you. As he does so, you pull him in, Zenji gasps slightly at your sudden approach. You run your fingers through his beard as you make out with him. He breaks the kiss as you fondle his beard, tilting his head back affectionately as you weave your fingers through his facial hair. You see a dopey grin spread across his face. He’s putty in your hands, definitely enjoying having his beard rubbed by you. It doesn’t take long before he tents his loincloth. Your hands roam upward to gently stroke your fingers through his mohawk before you think you’ve teased him enough.\n\n");
			outputText("You tell him to relax and lie down, you can take care of it from here. He follows your command and leans down, propping himself against a nearby tree. Once he's settled, you struggle briefly to pull down his loincloth over his solid erection, you hear a satisfying thud as his manhood slaps against his abs after being uncloaked.\n\n");
			outputText("You glide a finger down his shaft, the only part of him not covered in fur, but his balls are dense and fuzzy. You spend a moment toying with his soft, heavy balls. He’s virile as ever, just waiting for the chance to dump his next load on you. You spend a moment getting closer to his warm, fuzzy balls. You gently rub a finger along his fuzzy sac before leaning in closer, letting loose your breath onto him. You bring your mouth closer, gently licking his sack. The musky scent of his dick is more intense from so far beneath him as you lick his balls. His balls are loose and bobble slightly from your [tongue] pressing against him. Zenji’s soft moans reassure you that he’s enjoying the foreplay. There’s some enjoyment in pleasing him despite the dense fuzz on your [tongue].\n\n");
			outputText("Once you’ve played enough with his sack, you shift up his length hovering just above his manhood, breathing softly onto his skin. The natural scent of him is even more intense down here. Zenji squirms slightly, he is very turned on by your performance. You place your lips at the head of his penis, the salty taste of his pre reaches your [tongue] as you gently tease at his tip.\n\n");
			if (player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32) outputText("Zenji blushes softly, \"<i>[name]... Are… are you sure ya can handle dis..? I… I fear I am too big for ya…</i>\" You reply with a determined glance. You made him this big for a reason, if you can’t give him the worship he deserves then what’s the point? You put your efforts into licking around his shaft. Zenji sits awkwardly, unsure of what to do with such a large length.\n\n");
			else outputText("\"<i>Da's some reward ya got for me,</i>\" he says as you make your way down his length. He gently starts moving his hips to try to push more of himself into you, but he refrains from being too aggressive.\n\n");
			outputText("You start with your head at the side of his shaft, rubbing your hand across the tip as you lick around his base.\n\n");
			outputText("\"<i>You’re so good at dis, [name]...</i>\" he says as he gently thrusts against you, pressing his palm against your head, pushing your face into his crotch. Your face is nestled into his treasure trail, his pubic hair is very dense. \"<i>Yeah… breathe it all in for me, [name].</i>\"\n\n");
			outputText("You continue licking up his pre and inhaling his earthy musk while bobbing up and down his shaft. As you do so, you feel him buck a little harder against you. You spend more time wrapping your [tongue] around him, trying to get a taste of every last inch he has to offer. You move your head to the tip of his erection. You gently pry your [tongue] underneath his foreskin. Zenji squirms at your intrusion as you shift your [tongue] around his tip. You give him a sly grin as you lick around his salty tip.\n\n");
			outputText("You press your lips over his girth, wrapping your mouth completely around him as you continue moving up and down his shaft, his stamina is greater than you expected. You look up at your lover, his eyes closed in pleasure as you suddenly get a taste of pre. His small grunts of pleasure inspire you, but he doesn't seem close to finished.\n\n");
			outputText("You keep a steady pace, bobbing your head up and down for what feels like ages, wrapping your [tongue] around his length, doing your best to pleasure him. You look up at him again for reassurance, his gaze locks with yours as he gives you an affectionate rub on the head with his strong hands. His masculine features are illuminated from the lower angle, you can’t help but feel slightly more aroused at the sight of such a handsome face. Your jaw begins to grow tired, but then his erection begins to twitch as he nears his climax.\n\n");
			outputText("Zenji takes a sharp inhale, \"<i>Don' stop now... Almost... Der..!</i>\"\n\n");
			outputText("His words of encouragement motivate you to continue as you wrap your arm around his waist, awaiting his orgasm.\n\n");
			outputText("Zenji groans a sigh of relief as he cums. ");
			if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 3700) {
				outputText("Waves of jizz surge into your mouth as you do your best to take in everything he has to offer. Fierce determination washes over you as you swallow his load, gulping down to your best ability. His orgasm never seems to end, there’s so much cum. ");
				if (silly()) outputText("You have created a monster, a ravishingly handsome, virile monster! ");
				outputText("Tears well up in your eyes as you choke on his load. You gag and sputter, the load he’s just unleashed into you spills out from your mouth. You try to clear your throat before swallowing more of his seed. You feel so full, you can’t believe you managed to take in as much of his cum as you did, even if most of it spilled out nearly everywhere else besides your mouth. You can feel that your stomach has distended slightly from the sheer amounts of seed you’ve just drunk. Copious amounts of seed have spilled back onto him and onto the ground beneath the two of you.\n\n");
				outputText("\"<i>Ya took it like a real champion, [name],</i>\" Zenji says with a satisfied grin. \"<i>I couldn’t ask for anyone betta.</i>\"");
			}
			else if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 700) {
				outputText("Waves of jizz shoot into your mouth as you do your best to take in what he has to offer. There is so much cum, you feel like he isn’t going to stop. ");
				if (player.lib < 100) {
					outputText("You gag and choke up his seed, you did your best, but you couldn’t take it all in for him.\n\n");
					outputText("Zenji gives you a gentle smile at you, \"<i>Ya did your best, champion.</i>\"");
				}
				else {
					outputText("Like that is a problem for you. You make sure not to let any drop of cum escape as you happily swallow wave after wave of his seed.\n\n");
					outputText("Zenji gives you a contented grin, \"<i>Now dat is a champion!</i>\"");
				}
			}
			else {
				outputText("Waves of jizz shoot into your mouth as you do your best to take in every drop he has to offer. ");
				if (player.lib < 100) outputText("Unfortunately his load is too much for you to take in. It escapes from your mouth onto the ground beneath you.");
				else outputText("You happily swallow every last drop of seed he pours into you.");
			}
			outputText("\n\nOnce he’s finished his orgasm he gives you an affectionate head rub as a token of gratitude. He lifts you, almost as if you were a child, bringing you closer to his face. Once you're on top of his torso, he affectionately rubs his beard against your face, despite his load still dripping from your face.\n\n");
			outputText("\"<i>Don' eva change,</i>\" He whispers, \"<i>you are perfect de way you are, and I will always love ya no matta what.</i>\"\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 3, 1);
			player.refillHunger(10 + ((player.statusEffectv2(StatusEffects.ZenjiModificationsList) + 1300) / 100));
			player.sexReward("cum","Lips", false);
			dynStats("lust", 25);
			endEncounter();
		}

		public function loverZenjiSexCuddle():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you want to spend some quality time with him and enjoy his presence.\n\n");
			outputText("\"<i>If dat's ya wish, go ahead, I like spendin' time whit ya too.</i>\"\n\n");
			outputText("You take off your [armor] until you are "+(player.isNaked2() ? "completely naked":"left in your underwear")+". Zenji keeps his loincloth on, but it does a poor job at hiding his affection for you.\n\n");
			outputText("Before you cuddle with him, you consider what exactly you want to do.\n\n");
			menu();
			addButton(1, "Big Spoon", loverZenjiSexCuddleBigSpoon);
			addButton(3, "Little Spoon", loverZenjiSexCuddleLittleSpoon);
		}
		public function loverZenjiSexCuddleLittleSpoon():void {
			outputText("You ask Zenji if he could lie down on his bedroll so that you can join him, he does so and reaches an arm out to you, awaiting your entrance. You take his furry hand as he pulls you close to him, your back pressed tightly against his firm abs, the soft texture of him is soothing as you sink into his embrace. Zenji holds onto you affectionately with his muscular arms, keeping you safe in his protective grasp. His tail protectively wraps around you, rubbing against you softly.\n\n");
			outputText("Enthralled by the warmth of your lover, you take in a small sigh as you truly begin to relax in his arms. Slowly your consciousness fades as you drift off to sleep in his cozy embrace. You are vaguely aware of him stroking your back as he coddles you.\n\n");
			outputText("You wake up about an hour later, face buried in Zenji's muscular chest as he gently strokes the top of your head. His musk is gentle and sedating.\n\n");
			outputText("\"<i>Was it a good nap?</i>\" Zenji asks, noticing that you've awakened.\n\n");
			outputText("You tell him that indeed it was before asking if he took a nap as well.\n\n");
			outputText("\"<i>It was nice resting with ya, but I didn’t sleep, you are all I could eva need… Besides, I didn' wanna take ma eyes off ya.</i>\" He replies with a smile.\n\n");
			loverZenjiSexCuddle2();
		}
		public function loverZenjiSexCuddleBigSpoon():void {
			outputText("You ask Zenji if he could lie down on his bedroll so that you can hold him.\n\n");
			outputText("Zenji blushes softly, \"<i>You… ah… I see…</i>\" Zenji obliges, lying down on the bedroll as you lie down beside him.\n\n");
			outputText("You wrap your arms around your beefy troll lover. His hair is soft and cozy, making him very huggable. Zenji holds your hands once they’re wrapped around him. \"<i>Dis is nice… I’ve never done it like dis before I met you…</i>\" You stroke his soft cheek in response. It’s nice to be the little spoon sometimes, he deserves to know that.\n\n");
			outputText("Zenji gives a small sigh as he relaxes into your embrace. You can feel his tail flit between the two of you. His coziness is soothing and you find yourself drifting to sleep with him.\n\n");
			outputText("You wake up nearly an hour later, Zenji is breathing slowly and heavily. It would seem he’s fallen asleep with you. That’s new, Zenji normally doesn’t lower his guard, but being with you like this has allowed him to relax.\n\n");
			outputText("Zenji yawns softly, \"<i>Wh- I… I fell asleep, wow… [name]... I didn’t even realize dat... Tank you, [name]. Dis was really nice, I enjoyed spending time wit ya like dis.</i>\"\n\n");
			outputText("You tell him that it’s always good to spend time with those you love, letting your guard down with someone you love is not a sign of weakness, rather a sign of compassion.\n\n");
			outputText("Zenji chuckles softly.\n\n");
			loverZenjiSexCuddle2();
		}
		public function loverZenjiSexCuddle2():void {
			outputText("Rested, Zenji helps you up and assists in getting you dressed as you prepare to take on the day.\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 3, 1);
			fatigue(-(Math.round(player.maxOverFatigue() * 0.15)));
			dynStats("lust", 15);
			dynStats("cor", -0.25);
			endEncounter();
		}

		public function loverZenjiPregnantSex():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (player.pregnancyType == PregnancyStore.PREGNANCY_ZENJI ||player.pregnancyType == PregnancyStore.PREGNANCY_ZENJI) {
				outputText("Before you can consider what you want to do, Zenji cuts you off, \"<i>You are very beautiful, have I told you dis, [name]?</i>\" he says, giving you a toothy grin, his tone almost predatory.\n\n");
				outputText("\"<i>If you don’ mind, I know exactly what I wanna do,</i>\" he says, leaning in, giving you a loving lick across the cheek.\n\n");
			}
			else if (InCollection(player.pregnancyType, PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, PregnancyStore.PREGNANCY_SPIDER, PregnancyStore.PREGNANCY_DRIDER_EGGS, PregnancyStore.PREGNANCY_FROG_GIRL) ||
				InCollection(player.pregnancy2Type, PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, PregnancyStore.PREGNANCY_SPIDER, PregnancyStore.PREGNANCY_DRIDER_EGGS, PregnancyStore.PREGNANCY_FROG_GIRL)) {
				outputText("You tell Zenji that you want him to be gentle, you may be pregnant, but you still crave the touch of your lover.\n\n");
				outputText("Zenji gives you a gentle smile, \"<i>You are still beautiful to me, no matta what,</i>\" he reassures, stroking your pregnancy bulge. His cheeks blush slightly as he strokes his hand over you. \"<i>Someting about you like dis though… It’s making me want you even more…</i>\" he says, growing even more flushed.\n\n");
			}
			else {
				outputText("You tell Zenji that you want him to be gentle with you this time, despite your pregnancy, you still want him as much as you did before.\n\n");
				outputText("Zenji seems a little dejected at the thought, \"<i>[name] Ya still want me, despite dat I'm not de father?</i>\" He shakes his head softly. His gaze averts, he is hurt. He gently pushes your face away with a fuzzy palm as he begins weeping softly, biting his fingers with his other hand. \"<i>I... I just...</i>\"\n\n");
				outputText("You lower down his arm, bringing yourself closer to him. You explain to him that even though he is not the biological father to the child, you still want him to be the father you know he can be. You did not intend to not bear his child, but you still love him, and you want him to know how much you love him by having him with you during your trying times.\n\n");
				outputText("Zenji shakes his head softly again. \"<i>I...</i>\" He takes a deep breath, finally taking in the strength to look you in the eyes again, \"<i>I'll do it... for you... for us, [name].</i>\"\n\n");
			}
			outputText("Zenji stands at your side, helping you get out of your [armor] with slow deliberate motions, carefully gliding his hands around your pregnant frame. The soft hair on his hands tickles you gently as his tender touch undresses you. His tail reaches around, gently rubbing the underside of your pregnancy bulge. He blushes when he touches your pregnancy bulge, he is very much attracted to you like this, not like he could hide his affection for you beneath his loincloth anyway.\n\n");
			outputText("Once you're fully undressed, Zenji takes off his loincloth as well, he struggles to pull it down past his erection. Once he’s taken it off you take a glimpse at his balls, definitely a bit larger than usual. He places a finger into his mouth, lathering his index finger in saliva. He leans closer to you, gently teasing your clit as he toys with you, blushing softly.\n\n");
			outputText("\"<i>I can't tell ya just how beautiful you are like dis...</i>\" he says, \"<i>Are ya ready for ya big bad troll ta show you how much he loves you?</i>\"\n\n");
			outputText("You squirm beneath his touch, ready for him, desperate for his warmth.\n\n");
			outputText("He stops playing with your moist box as he slowly pulls you down with him, placing you in his lap as he rests his back against a tree. You are comfortably nestled within his fuzzy embrace, he spends a little more time toying with your rosebud, teasing you gently as his free hand fondles your breasts. His dick is firmly pressed against your backside, foreskin pulled back slightly from his stiff erection, aching for its entry. Finally, you tell him you can't handle it anymore. Zenji nuzzles your head softly with his beard as he gently lifts you, his tip barely grazing your labia, almost as if it were mocking you. Slowly, he lowers you down onto him, spearing you on his prick as he gives a low, hungry growl.\n\n");
			if (player.vaginalCapacity() < 10) outputText("His manhood presses into your tight snatch, gently stretching out your walls. Despite being pregnant, he still feels huge inside of you."+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? " He is massive, you grow concerned for your unborn child.":"")+"\n\n");
			else if (player.vaginalCapacity() < 80) outputText("His manhood presses into your moist snatch, gently pressing his way into you. He feels so good inside you as he presses deeper, pushing against your walls, his pace slow and gentle.\n\n");
			else outputText("His manhood presses into your moist snatch, gently pressing his way into you. While he may not be the biggest you've had, he is skilled and you couldn't wish for anyone better.\n\n");
			outputText("Zenji gently strokes at your baby bulge, sniffing you intently as he slowly pumps into you, mindful of the child you're carrying.\n\n");
			player.cuntChange(15,true,true,false);
			outputText("\"<i>[name],</i>\" he whispers in a shallow tone, \"<i>I can't tell you how hot you're making me... Ya really are a beautiful mother... there are no words to tell you how much I love you.</i>\"\n\n");
			outputText("You lean back into his embrace, content in basking within the comfort of your lover's affection. You urge him to go a little faster.\n\n");
			outputText("Zenji growls softly as he picks up the pace, tenderly brushing his face against yours while fondling your body with his hands. You can feel his length twitching within you, he's nearing the edge, but you're not ready yet. Zenji groans in desperation, unwilling to release so quickly as he loses his pace, but his shaft still pulses with need."+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? " He is so huge, the outline of his bulge shows through your stomach.":"")+"\n\n");
			outputText("Zenji reaches his hand down to your clit, frigging you as he slowly pumps into your moist cunt, desperately trying to get you off first. You can feel how hard he is blushing from this, is he ashamed that he’s about to get off first? He's leaking so much pre he might as well be cumming. Slowly he picks up the pace once more. His pants become strained, aching for release, but he is determined not to cum just yet.\n\n");
			outputText("Zenji starts pumping into you with increased vigor, he grits his teeth as you feel his hot breath across your cheek. You moan softly as he presses deeper into you, cramming your canal with his manhood. Soon enough a familiar pressure builds up within your loins as you quickly approach the edge. You beg him to go harder, you want to feel everything he has to offer, you're so close now.\n\n");
			outputText("Zenji grunts with force as he grabs onto your hips, pulling you down with his thrusts, the force he rocks you with finally pushes you over the edge as you catch the release you so crave. Zenji howls into your ear as he finally cums, the warmth of his seed spilling past your cervix. So much cum is leaking from him, you're surprised he held so much as it seeps out past your lips. Zenji doesn’t stop thrusting, his grunts become more aggressive as he continues pumping into you, still in orgasm. ");
			outputText("You feel him heave, panting wildly as he groans softly. His hands roam around your form, clutching you closer, making sure that you can take in every last drop of cum he has to offer. There’s far too much for you to handle and it continuously leaks out past your netherlips, spilling onto his legs, trickling down to the floor beneath him.\n\n");
			outputText("Zenji growls softly as he deflates from within you, his shaft slides out, still leaking copious amounts of cum, but he doesn’t go completely flaccid.\n\n");
			outputText("\"<i>Dat was...</i>\" Zenji is still panting, unable to make out his words, \"<i>When a male troll is with dey’re mate, especially when dey’re pregnant we jus’... I get all dese feelings for you, I need you even more, I can’t tink straight when I’m around ya,</i>\" he says, catching his breath.\n\n");
			outputText("You are touched by his words and you tell him that you're honored to be able to have a family together.\n\n");
			outputText("You spend a moment within his embrace as he fondles your body, tenderly stroking your stomach.\n\n");
			outputText("You notice Zenji has gotten hard again, his shaft still leaking cum and twitching with need, desperate to stuff you again… has he even finished his first orgasm?\n\n");
			outputText("You feel this tip of his length prod at your slicked cunt, he’s not done yet. Without any confirmation from you, he aligns himself with your sex.\n\n");
			outputText("\"<i>I can’t take it anymore! I need ya again now!</i>\" He growls. To your delight, he thrusts himself into you again, his presence is firm and unyielding as he pumps into you again and again. You couldn’t hope to take in the amount of cum he has to offer as he doesn’t seem to be close to stopping any time soon. He feels so good inside you, you wish it never has to end. You’re almost worried for your child with how rough he’s being. But all that worry quickly fades as you feel pressure building up within your loins, on the brink of another orgasm.\n\n");
			outputText("You cry out, but Zenji quickly presses his fingers into your mouth, silencing you with a soft growl. You moan softly into his fingers, getting railed into oblivion as you’re brought to the height of another orgasm. The world feels hazy as you can only think about being bred by your troll lover, the overwhelming scent of his musk being the only thing you can concentrate on.\n\n");
			outputText("After what feels like ages of being bred like animals in heat, Zenji finally begins to slow down. Your stomach has distended noticeably from all the cum he’s been flooding inside you. A notable river of cum has pooled beneath you as you feel his manhood deflate, slipping out of you, completely flaccid.\n\n");
			outputText("Zenji gives an exhausted moan as he removes his fingers from your mouth. Zenji looks down at the river of cum beneath him, \"<i>I got a little carried away dere, didn’t I..? It’s jus’... I couldn’t take my mind off of ya… I’ve neva had a true mate before…</i>\"\n\n");
			outputText("You give him a reassuring nod, you can’t say you’ve ever felt more loved in your entire life.\n\n");
			outputText("Zenji gives you a soft grin in reply.\n\n");
			outputText("Zenji helps clean you up before redressing you, you spend some time with him until you finally muster the strength to walk again, ready to continue with your day.\n\n");
			outputText("\"<i>You will make a fine mother, dis I know. There's nobody I'd rather have to take care of our children dan you. You are everyting to me [name].</i>\"\n\n");
			outputText("You spend some more time with your hunky troll lover before he cleans you off and helps you get ready to continue your day.\n\n");
			player.sexReward("cum", "Vaginal");
			endEncounter();
		}

		public function loverZenjiHotSpring():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that since you have a hot spring now, you were wondering if he would like to join you in it.\n\n");
			outputText("Zenji gives you a wary grin, \"<i>De hot spring? Not really my ting, but of course I’d love ta join ya,</i>\" he states, reaching out his hand. You grab hold of him as he walks you to the hot spring.\n\n");
			outputText("Zenji slowly dips himself into the water, \"<i>Sure is warm…</i>\"\n\n");
			if (player.isNaked()) outputText("You slide into the water beside him.\n\n");
			else {
				outputText("You undress in front of him before sliding into the hot spring beside him.\n\n");
				outputText("\"<i>Oh, you’re taking off all ya clothes?</i>\" he asks.\n\n");
				outputText("You give him a cheeky wink.\n\n");
			}
			outputText("Zenji pulls you closer to him, \"<i>De hot spring is nice and all, but what I really love about it is having ya here wit me.</i>\" You lean against him, telling him that it just wouldn’t be the same without him.\n\n");
			outputText("He gently places his hand under your chin as he pulls your face towards him, planting a gentle kiss on your lips. You are enthralled by the heat of your lover and the warmth of the water. You spend a moment being subdued by his passion before breaking the kiss. You know you could have sex with him here, it’s not like he’s going to stop you, but maybe it’d be better if you just spend some time relaxing with him.\n\n");
			menu();
			addButton(1, "Relax", loverZenjiHotSpringRelax);
			addButton(2, "Ride Anal", loverZenjiHotSpringRideAnal);
			if (player.hasVagina()) addButton(3, "Ride Vaginal", loverZenjiHotSpringRideVaginal);
			else addButtonDisabled(3, "Ride Vaginal", "You need a vagina for this scene.");
		}
		public function loverZenjiHotSpringRelax():void {
			outputText("You sink into Zenji’s warm fur, being carried gently by the warm bubbling water. Zenji leans his head onto yours.\n\n");
			outputText("\"<i>I know I said hot springs aren’t my ting, but I could get used ta dis,</i>\" he remarks softly.\n\n");
			outputText("You spend some time relaxing in the hot spring with Zenji. The warmth of your lover and the heat of the water is calming. Zenji gently strokes your head before wrapping his arm around you and pulling you closer to him. He rests his head against you before slowly closing his eyes, getting drowsy from the heat. You decide that all you want to do right now is just spend some quality time beside him. You spend the rest of the hour sitting beside Zenji.\n\n");
			outputText("Zenji stirs softly, you notice he’s sweating a lot, \"<i>I tink it’s about time we get outta de spring, I don’t wanna spend too much time in da water.</i>\" Zenji waits for your affirmation, in which you agree.\n\n");
			outputText("Zenji picks you up out of the water as he steps out with you in his arms. Zenji is soaked, from his midriff and lower, his hair drips slightly from the weight of the water.\n\n");
			outputText("\"<i>Dat was nice,</i>\" he says, placing you down and wiping the sweat from his brow, \"<i>We should do it again sometime.</i>\"\n\n");
			outputText("You agree, the hot spring is surely a lot hotter with him in it.\n\n");
			outputText("Zenji chuckles softly before sitting next to you, drying the two of you off with a towel. Once both of you are dried up Zenji pulls you in for a hug. \"<i>Dried off and ready ta continue da day!</i>\"\n\n");
			outputText("You smile back at Zenji, with his support you feel like nothing can get in your way.\n\n");
			fatigue(-(Math.round(player.maxOverFatigue() * 0.25)));
			endEncounter();
		}
		public function loverZenjiHotSpringRideAnal():void{
			outputText("You look up at Zenji with a sly smirk.\n\n");
			outputText("Zenji gives you a slightly concerned look, \"<i>I know dat look, ya are up ta someting, [name].</i>\"\n\n");
			outputText("You inch closer to him, telling him that he’s even hotter than the water right now. You rest yourself on his lap, [butt] pressed against his crotch.\n\n");
			outputText("Zenji raises his hands in the air defensively, \"<i>Ah, [name], you… if you wanted ta cuddle ya don’t have ta be so…</i>\" Zenji gives a small chuckle, \"<i>Dat’s just like you, gettin what ya want when ya want it.</i>\"\n\n");
			outputText("You tilt your head back, reaching a hand up to caress his face, running your fingers through his beard.\n\n");
			outputText("Zenji lowers his hands, wrapping them around your torso. \"<i>Looks like you’re all mine now, [name]. You’re not getting away dis time,</i>\" he croons as he leans closer, your back pressed against his firm abs.\n\n");
			outputText("You lower your free hand toward his crotch, gently lifting his loincloth as you shake your hips for him. Zenji flinches slightly at your intrusion, \"<i>Handsy, ain’tcha?</i>\"\n\n");
			outputText("You give a small snicker in response, but Zenji is not hiding his arousal. You lift yourself above his lap, allowing the water to carry you as you slide his loincloth down his legs.\n\n");
			outputText("Zenji blushes softly, \"<i>[name]... you really know how to tease a troll…</i>\" he mutters in a husky whisper. Zenji seems to be warming up to the idea of penetrating you right here as his manhood rises, pressing against your rear. His strong hands grab you by the hips.\n\n");
			outputText("\"<i>I can’t take it anymore if ya are gonna toy around wit me like dis… So I betta take you first!</i>\" Zenji aligns himself with your backdoor, the bubbling water surrounds you as he pulls you down, spearing you over his length.\n\n");
			if (player.analCapacity() < 7) outputText("His lengthy shaft presses its way deep inside of your tight anus, you feel yourself stretch over his considerable manhood."+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? " The water makes it a bit easier to adjust to his intense size.":"")+"\n\n");
			else if (player.analCapacity() < 56) outputText("His lengthy shaft presses into you, you can feel him accommodating your [ass] as he presses further and further with each thrust.\n\n");
			else outputText("His lengthy shaft presses into you, you can feel him push into your roomy backside as he presses deeper into you with each thrust.\n\n");
			outputText("\"<i>So hot…</i>\" Zenji groans in a husky voice as he gently thrusts into you."+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? " The outline of his massive manhood bulges through your stomach.":"")+"\n\n");
			player.buttChange(15,true,true,false);
			outputText("You make way with doing your best to ride him, the water splashes around the two of you as you bounce up and down on his length. You can feel his heavy balls graze against your underside as you press down against him. It’s heavy and virile as ever, almost cushiony, ready to pump you full of his love.\n\n");
			outputText("Zenji is breathing heavily, completely lost in the heat of the moment, the water crashes harder onto you as you’re desperately trying to fit more of his length inside of you. Zenji ");
			if (player.gender == 0) outputText("tenderly allows his hand to roam along your barren taint as his soft fur sends tingles up your spine to which you reflexively press against him");
			else outputText("reaches his hand down to your loins, "+(player.hasCock() ? "gently stroking your shaft":"gently reaching his finger down to your netherlips, teasing your clit and probing your vagina")+"");
			outputText(". His other hand is still holding you tightly around the waist. You moan softly in response to his ministrations as you continue riding his length.\n\nYou can feel the pressure building up within your loins as you near climax. Zenji’s length begins twitching within your backside as he starts growling softly. You moan out in pleasure as you finally hit your climax. ");
			if (player.gender == 0) outputText("You press yourself tightly against him, trying to feel as much of his body against yours");
			else if (player.hasCock()) outputText("Girlcum drips out past your lips, mixing into the bubbling water");
			else outputText("Girlcum drips out past your lips, mixing into the bubbling water");
			outputText(" as you try to milk his dick of everything it’s worth.\n\n");
			outputText("Zenji grabs onto you tightly with a stern hiss as he finally cums within your rear, his erection pulsing with need as he unloads everything he has. His grip loosens as he pumps several loads into your awaiting backdoor, the cum out slightly into the hot spring due to the sheer volume.\n\n");
			outputText("Zenji finally relaxes as you rest above him, being carried gently by the water. You notice he’s sweating profusely.\n\n");
			outputText("\"<i>So… hot… it’s so hot, [name]. Let’s get out of de hotspring…</i>\" He pants exasperatedly as he reaches for his loincloth. Zenji stands up as he grabs onto your hand. He climbs out of the hotspring before pulling you up with him. He pulls you over his stomach as he lies on the ground briefly with you.\n\n");
			outputText("You rest on top of him for a moment, wiping the sweat from his face, moving down and rubbing his hot and sweaty arms before you decide to dry off with him. His tail swishes along the ground beneath affectionately you while you scrape off his sweat.\n\n");
			outputText("Zenji gently strokes your [hair] as the two of you dry off, \"<i>Dat was nice. If you really want ta do it again... I don’ mind.</i>\"\n\n");
			outputText("Zenji helps you redress as he puts his loincloth back on.\n\n");
			outputText("Zenji looks down at his soaked loincloth, \"<i>Ugh… I did not tink dis through, I need ta get another piece of cloth.</i>\"\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 3, 1);
			player.sexReward("cum","Anal");
			endEncounter();
		}
		public function loverZenjiHotSpringRideVaginal():void{
			outputText("You look up at Zenji with a sly smirk.\n\n");
			outputText("Zenji gives you a slightly concerned look, \"<i>I know dat look, ya are up ta someting, [name].</i>\"\n\n");
			outputText("You inch closer to him, telling him that he’s definitely hotter than the water right now. You rest yourself on his lap, your hips pressed against his.\n\n");
			outputText("Zenji raises his hands in the air defensively, \"<i>Ah, [name], you… if you wanted ta cuddle ya don’t have ta be so…</i>\" Zenji gives a small chuckle, \"<i>Dat’s just like ya, gettin what ya want when ya want it.</i>\"\n\n");
			outputText("You look up at him, gazing longingly into his eyes.\n\n");
			outputText("Zenji lowers his hands, wrapping them around your torso. \"<i>If you keep giving me dat look I won’t be able ta resist you anymore...</i>\" he says, pulling you closer to him.\n\n");
			outputText("You can feel something poke at you from underneath the water, you give him a taunting grin as Zenji blushes softly. You reach a hand down, pulling his loincloth down his legs as it is carried off by the hotspring. Once it’s out of the way, you shift around and wrap your legs around his waist.\n\n");
			outputText("Zenji blushes harder, \"<i>[name]... you really know how to tease a troll…</i>\" he mutters in a husky whisper. Zenji seems to be warming up to the idea of penetrating you right here as his manhood rises, pressed against you. His strong hands grab you by the hips. \"<i>You are really asking fa dis… and now you’re mine, [name].</i>\" You feel his fuzzy hand lower slightly to gently grope at your [ass] as he gives you a soft growl. Soon you can feel him prod the tip of his length against your lips before finally bringing himself to penetrate you.\n\n");
			if (player.vaginalCapacity() <= 9) outputText("His manhood presses into your tight snatch, gently stretching out your walls. He is so big, but you need him now even more."+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? "The water makes it easier to adjust to his intense size.":"")+"\n\n");
			else if (player.vaginalCapacity() < 79) outputText("His manhood presses into your moist snatch, gently pressing his way into you. He feels so good inside you as he presses deeper, his pace slow and gentle.\n\n");
			else outputText("His manhood presses into your moist snatch, gently pressing his way into you. While he may not be the biggest you've had, he is skilled and you couldn't wish for anyone better.\n\n");
			outputText("You sigh softly, the feeling of being filled consumes you as the water crashes against your back. You rock back and forth up his length, trying to match the rhythm of his gentle thrusting. "+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? "The outline of his massive manhood bulges through your stomach. ":"")+"His dense balls scrape your underside, they’re so large and full of his virile seed, you can tell he’s more than ready to take you.\n\n");
			player.cuntChange(15,true,true,false);
			outputText("You grasp onto his shoulders, allowing yourself to grind yourself against him with more ease as he continues holding you by the hips. "+(player.tallness < 72 ? "You look up towards him, he tilts his head down to meet your gaze, giving you a gentle smirk followed by a soft, seductive growl":"You look down at Zenji, his eyes are closed in pleasure as he continues growling softly")+".\n\n");
			outputText("You hold onto him as if at any moment the water will carry you away from his embrace. Zenji begins to pick up the pace, trying to fit more of his length into your womb. You rest your head onto his neck as he pounds away at you. You can feel the force of his growl reverberate through both of you while you’re pressed up so close to him.\n\n");
			outputText("Soon enough you can feel a familiar pressure build within your loins as you clutch onto him tighter. As if sensing your impending orgasm, Zenji tilts your chin to meet his face as he pulls you in for a kiss. His tongue explores your mouth as you moan softly into his embrace. It doesn’t take long before your orgasm hits, rocking you to your core. You cum over his shaft, further lubricating yourself for him beneath the water."+(player.hasCock() ? " Your erection reacts as well, pulsing desperately and shooting ropes of cum towards his chest as it is carried off by the water.":"")+"\n\n");
			outputText("Zenji growls harder as his length twitches desperately within you. With a loud howl he finally orgasms, unleashing loads of cum into your awaiting womb, you couldn’t hope to contain it all as some of it leaks out into the water. \"<i>So hot…</i>\" He whispers. It’s impossible to ignore his profuse sweating.\n\n");
			outputText("Zenji is panting from the intense heat, \"<i>Let’s get outta de water. It’s so hot…</i>\" Zenji stands up, holding onto you tightly as he lifts you out of the hotspring, placing you on the ground as he lifts himself out as well, picking up his loincloth on the way out. Once you’re out you reach up and caress his sweaty face. His tail swishes along the ground affectionately as you fondle him.\n\n");
			outputText("Zenji grins, reaching a hand to you, gently stroking your [hair] as the two of you dry off, \"<i>Dat was nice, if you really want ta do it again I don’ mind.</i>\"\n\n");
			outputText("Zenji helps you redress as he puts his loincloth back on.\n\n");
			outputText("Zenji looks down at his soaked loincloth, \"<i>Ugh… I did not tink dis through, I need ta get another piece of cloth.</i>\"\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 3, 1);
			player.sexReward("cum", "Vaginal");
			if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
			else player.knockUp(PregnancyStore.PREGNANCY_ZENJI, PregnancyStore.INCUBATION_ZENJI);
			endEncounter();
		}

		public function loverZenjiSexGetFingered():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you want him to show you how good he is with his hands.\n\n");
			outputText("You shift around so that your back is pressed against his abs. You bring his strong, dense hands down to your loins, guiding his hands to your lips.\n\n");
			if (!player.isNaked()) outputText("You pull down your [armor], giving Zenji room to finger you.\n\n");
			outputText("\"<i>Ah, I see how it is… You like a hands-on approach...</i>\" Zenji says as he pulls his fingers up to his mouth, lathering them briefly before returning to your clit. His free hand roams around your torso as his other hand gets down to work on your rosebud. You squirm softly beneath his touch, he is far more skilled at this than anyone should be.\n\n");
			outputText("\"<i>Haha, ya really like dis, don’tcha?</i>\" he says teasingly. \"<i>Tell me, you like being held by ya big bad troll, right [name]?</i>\" His tail lifts to your vagina, teasing you slightly before gently caressing your form.\n\n");
			outputText("You give a sharp breath in response, getting caught up in his deft hands. Zenji continues teasing your clit, fondling you in steady circular motions as his other fingers prod past your lips, exploring the walls of your vagina. You moan softly as his other hand reaches up to your chin, holding you tightly, pressing his chest to your back.\n\n");
			outputText("\"<i>Now... Now, you are mine…</i>\" he growls as he leans closer to you, giving your cheek a long, loving lick as he continues fingering you. You quiver in delight at his tongue."+(player.isBiped() ? " Zenji sensually strokes your thighs, teasing you gently.":"")+"\n\n");
			outputText("Zenji crooks his finger within your vagina, testing your limits and seeing how far he can dig his large finger into you. He spends time slowly rubbing your clit with his thumb and continually fingering you.\n\n");
			outputText("You moan softly again as he gently caresses your face. You can’t take the teasing anymore as you feel pressure building up within your loins, you’re ready to come for him again. Your legs grow weary as Zenji holds onto your form tightly. You cry out in pleasure as you cum into his awaiting fingers, girlcum drips past your lips down his fingers.\n\n");
			outputText("\"<i>Didja like dat, [name]?</i>\" he asks, knowing very well the answer.\n\n");
			outputText("You nod softly as Zenji turns you around to face him. He pulls you in, planting a hungry kiss onto your lips. \"<i>Good…</i>\" he croons after breaking the link, strands of saliva drip from the two of you as he pulls away.\n\n");
			if (!player.isNaked()) outputText("Zenji helps pull your clothes back up once you’ve recovered from your high.\n\n");
			outputText("\"<i>Now den… As much as I do like spending time wit ya, dere’s other tings I need ta attend to.</i>\" Zenji says, giving you a gentle kiss on the cheek before leaving.\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 3, 1);
			player.sexReward("no", "Vaginal");
			endEncounter();
		}

		public function loverZenjiSexGetHandjob():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you want him to show you how good he is with his hands.\n\n");
			outputText("You shift around so that your back is pressed against his abs. You bring his strong, dense hands down to your loins, guiding his hands to your shaft.\n\n");
			if (!player.isNaked()) outputText("You pull down your [armor], giving Zenji room to give you a handjob.\n\n");
			outputText("\"<i>Ah, I see how it is… If ya want ya reward, den ya betta get ta work first.</i>\" Zenji says as he pulls his fingers up to your mouth. You wrap your [tongue] around his hands, licking them briefly, lubing up his fingers for him. His free hand roams around your torso as his other hand reaches down to get to work on your length. Your length rests comfortably in his large hands. Something about getting a handjob from his soft hands is fascinating. You can’t say that you’ve seen him jerk off within your camp, how is he so good at this?\n\n");
			outputText("He continues stroking your shaft in long repeated strokes, \"<i>Ya really enjoy dis, I can tell, [name].</i>\" You groan softly in response as his other hand reaches up to your chin, holding you tightly, pressing his chest to your back.\n\n");
			outputText("\"<i>You’re not getting off dat easily, [name]...</i>\" he says, smirking softly as he leans closer to you, giving your cheek a long, loving lick as he continues stroking your manhood. His tail reaches up to your erection as he uses the tip of his tail to tease your sensitive manhood. He continues working his tail around the tip of your shaft, teasing you softly before his tail lowers to caress your form.\n\n");
			outputText("You breathe softly as he gently caresses your face. You can’t take the teasing anymore as you feel pressure building up within your loins, your shaft begins twitching within his grasp. Sensing your impending orgasm, Zenji’s grip on you tightens as his strokes become faster. Your legs grow weary as Zenji holds onto your form tightly. Grinding against his crotch softly, you cry out in pleasure. Finally cumming into his awaiting fingers, ropes of cum shoot into the air, eventually dribbling down to his fingers.\n\n");
			outputText("\"<i>Didja like dat, [name]?</i>\" He asks, knowing the answer very well.\n\n");
			outputText("You nod softly as Zenji turns you around to face him. He pulls you in, planting a hungry kiss onto your lips. \"<i>Good…</i>\" he says after breaking the link, stands of saliva drip from the two of you as he pulls away.\n\n");
			if (!player.isNaked()) outputText("Zenji helps pull your clothes back up once you’ve recovered from your high.\n\n");
			outputText("\"<i>Now den… As much as I do like spending time wit ya, dere’s other tings I need ta attend to.</i>\" Zenji says, giving you a gentle kiss on the cheek before leaving.\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 3, 1);
			player.sexReward("no", "Dick");
			endEncounter();
		}

		public function loverZenjiSexGetLicked():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You ask Zenji that now since he has smaller tusks if he's willing to give you a little treat in return.\n\n");
			outputText("Zenji gives a small chuckle, \"<i>Is that de only reason ya wanted me to have small tusks? Well, I can imagine what ya want and I can't lie, I’ve been wanting ta do the same.</i>\"\n\n");
			outputText("You lie down on the ground as Zenji pulls down your [armor] as he unveils your [vagina].\n\n");
			outputText("He leans close, you can feel his breath on your labia as he bends closer, he starts by gently licking your outer walls, teasing your box with his long tongue. He gently presses his ashen tongue against your clit before sliding his way past your netherlips.\n\n");
			outputText("You shudder at his ministrations, how is he so talented at this despite his lack of experience? He doesn't stop as he presses deeper into your womb, licking his way into you as he eats you out.\n\n");
			outputText("His mouth is pressed against your lips as he drags his tongue around your canals, making sure to cover the parts of you that he's neglected. You can feel the pressure building up within your loins, you beg him to continue, you're so close now. He keeps going at you, licking his way around you before you finally find yourself cumming. ");
			outputText("You bite your lips and clench your [legs], trapping him beneath your hips. "+(player.hasCock() ? "Your cock twitches and shoots several ropes of cum across your chest. ":"")+"Zenji stays there for a moment, enjoying the taste of your girlcum. He takes a sharp breath as he emerges from your lips, your feminine juices dripping down from his chin.\n\n");
			outputText("\"<i>Enjoyed that, [name]?</i>\" He asks, giving you a longing stare.\n\n");
			outputText("You nod, you're surprised how good he is with how little experience he should have.\n\n");
			outputText("He leers at you, \"<i>I have my ways...</i>\" He replies as he crawls up to you. He turns your face to him as he lies down on his side adjacent to you. \"<i>I'm glad we can do this now, I'm glad you liked it, you're really special to me, don't you forget it.</i>\"\n\n");
			outputText("Zenji helps you up and redresses you. Soon enough you're ready to continue your day.\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 3, 1);
			player.sexReward("no", "Vaginal");
			endEncounter();
		}

		public function loverZenjiSexGetBlown():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You ask Zenji that now since he has smaller tusks if he's willing to give you a special treat in return.\n\n");
			outputText("Zenji gives a small chuckle, \"<i>Is that the only reason ya wanted me to have small tusks? Well, I can Imagine what ya want and I can't lie, I’ve been wanting ta do the same.</i>\"\n\n");
			outputText("Zenji kneels in front of you as he pulls down your [armor] unveiling your manhood which is already rising before him. He places his long tongue at the tip of your shaft, his presence firm and sultry.\n\n");
			outputText("You groan softly as he licks the tip of your length, slowly working his way down your cock. Zenji gently bobs his head as he presses deeper, you feel his tongue toy around with you, exploring every last inch of your manhood, making sure not to neglect a single inch of you.\n\n");
			outputText("You moan softly from his touch, he's surprisingly good at this given his supposed lack of experience.\n\n");
			outputText("You feel his nose pressed up against your skin as he envelopes your entire length within him. Zenji starts picking up the tempo, blowing you with greater vigor as his tongue rubs against your shaft, coaxing a little pre from you. Soon enough a familiar pressure builds up within your loins, you tell Zenji that you're so close now.\n\n");
			outputText("Zenji gives a small grin before he tries to swallow as much of you as he can, his actions push you over the edge and you find yourself cumming inside of him.\n\n");
			if (player.cumQ() >= 3000) {
				outputText("His eyes widen at such an intense load. He quickly withdraws as to not choke on your cum. Your load shoots into the air, \"<i>[name]... by Marae…</i>\" Zenji says in slight shock, \"<i>Well, it is impressive, but didja really tink I’d be able ta swallow all of dat..? Either way, let me getcha cleaned up den….</i>\"\n\n");
				outputText("Zenji spends some time licking up the excess cum you’ve erupted around him. There’s a lot of cum, Zenji spends some time doing his best to clean you up with his tongue.\n\n");
			}
			else if (player.cumQ() >= 700) {
				outputText("His eyes widen at such an intense load. He quickly withdraws as to not choke on your cum. Your load shoots into the air, \"<i>[name]... dat’s… dat’s some… power ya got dere… almost as much as me. Well, let me getcha cleaned up den…</i>\"\n\n");
				outputText("Zenji spends some time licking up the excess cum you’ve erupted around him until there’s hardly a trace of anything.\n\n");
			}
			else outputText("His eyebrows furrow for a brief moment before he swallows what you have to offer.\n\n");
			outputText("Zenji stands up, ");
			if (player.tallness > 82) outputText("reaching eye level with you");
			else if (player.tallness > 60) outputText("his height towering over you");
			else outputText("picking you up with him");
			outputText(". \"<i>Did ya like that [name]?</i>\" he says, giving you a longing gaze as he wraps his arms over you.\n\n");
			outputText("You nod, telling him he did better than you imagined. Zenji gives a small chuckle at your response.\n\n");
			outputText("\"<i>Well, I hope ya would be willing to return the favor later, hmm?</i>\" he teases, giving a taunting grin.\n\n");
			outputText("You tell him you'll consider it. You give him a brief kiss before you gently break out of his embrace, ready to start your day again.\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 3, 1);
			player.sexReward("no", "Dick");
			endEncounter();
		}

		public function loverZenjiSexTease():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you’d need to consider it, maybe you’re just not in the mood right now.\n\n");
			outputText("Zenji looks crestfallen, his ears droop as he looks at you with pleading eyes, \"<i>[name]... please… I need you so badly, please [name], don’t do dis to me...</i>\"\n\n");
			outputText("He falls to his knees, addled by lust, \"<i>I need you so badly [name]...</i>\" He takes a deep sigh, his burly chest heaves from his breath, his massive arm lowers to his groin, pressed down his erection, \"<i>Can’t you see what you’re doing ta me..? I need you now more dan ever…</i>\"\n\n");
			outputText("Zenji gives a pained sigh, grunting softly as he touches his throbbing erection. His tail flails against the ground, desperate and aching with need.\n\n");
			outputText("You grin in satisfaction as you approach him. His girth has pushed aside his loincloth and is already leaking a steady stream of precum. You gently cop a feel from him moving his hand away. Zenji moans in pleasure, thrusting against the palm of your hand.\n\n");
			outputText("You flick his ear with your [finger], Zenji flinches softly. You tell him that he should be still or his nose is next. Zenji whimpers in desperation, his ears droop in shame. His erection throbs beneath you, needy for more of your touch.\n\n");
			outputText("\"<i>Please…\" He begs, \"Don’t stop… so good… More… please...</i>\" he whimpers. You can feel his hot breath on you begin to strain, you’re barely even touching him and he seems ready to cum at any given moment.\n\n");
			outputText("You push Zenji onto his back, his toned and muscular body splayed onto the ground, his firm abs are almost beckoning you to mount him, but you have over things in mind as you shift your gaze to his throbbing erection. Perhaps you could tease him in another way.\n\n");
			if (player.isNaga()) {
				outputText("You slither closer, wrapping your tail around his length, teasing him with light touches. Zenji restrains from thrusting into you, he groans loudly with need, desperate for your scaly embrace. You glide the slender tip of your tail across his length, drifting yourself around the tip of his head. You continue sliding around his length, teasing him as he whimpers with need. You lift his heavy sack with your tail before letting it fall back to his crotch with a small thud.\n\n");
				outputText("You slowly wrap your tail around his girthy erection, the volumes of pre he’s already leaked onto himself gives you easier access to sliding your tail up and down his shaft. Zenji’s chest heaves, panting with greater need. He reaches his strong hands down to his girth, grabbing onto the base of your tail as he desperately humps into you, trying to get himself off by using you.\n\n");
				outputText("Not wanting him to forget who’s in charge you quickly slip out of his strong grip easily due to the sheer amount of pre that’s coated your tail. You whip your tail up to his face, flicking his nose causing him to flinch as you scold him again for being a naughty troll. Zenji’s mouth is agape, panting slowly and heavily as he lowers his hands submissively, letting you take control of him again. It appears he’s finally figured out who’s in charge now. ");
				outputText("You coil around his body, shifting around him and making sure he can’t move within your grasp, once he’s firmly trapped within beneath you, you continue working yourself around him. His thick erection pulsates within your grasp. Zenji grunts with need, gripping the earth beneath him, digging up the ground with his fists. More pre leaks out onto your tail. You can feel his length twitch, he’s ready to cum, do you let him?\n\n");
				menu();
				addButton(1, "Yes", loverZenjiSexTeaseNagaYes);
				addButton(3, "No", loverZenjiSexTeaseNagaNo);
			}
			if (player.isBiped()) {
				outputText("You inch closer, hovering your toes around his length, teasing him with light touches. Zenji restrains from thrusting into you, he groans loudly with need, desperate for your embrace. You glide your toes across his length, clenching around his girthy shaft drifting yourself around the tip of his head, sliding up and down his length, teasing him as he whimpers with need. You press your toes against his large sack, teasing him gently. You shift your presence underneath him as you lift his balls, letting them fall back against his crotch with a small thud.\n\n");
				outputText("You slowly clench your toes around his girthy erection, the volumes of pre he’s already leaked onto himself gives you easier access to sliding your foot up and down his shaft. Zenji’s chest heaves, panting with greater need. He reaches his strong hands down to his girth, grabbing onto your foot as he desperately humps into you, trying to get himself off by using you.\n\n");
				outputText("Not wanting him to forget who’s in charge you quickly slip out of his strong grip easily due to the sheer amount of pre that’s coated your foot. You whip your foot up to his face, flicking his nose with your toes, causing him to flinch as you scold him again for being a naughty troll. Zenji’s mouth is agape, panting slowly and heavily as he lowers his hands submissively, letting you take control of him again. It appears he’s finally figured out who’s in charge now. You continue working yourself around him, his erection pulsating within your grasp. Zenji grunts with need, gripping the earth beneath him, digging up the ground with his fists. More pre leaks out onto your toes. You can feel his length twitch, he’s ready to cum, do you let him?\n\n");
				menu();
				addButton(1, "Yes", loverZenjiSexTeaseBipedalYes);
				addButton(3, "No", loverZenjiSexTeaseBipedalNo);
			}
		}
		public function loverZenjiSexTeaseNagaYes():void {
			outputText("You grin in satisfaction as you continue your tailjob, your lover is fixing to burst and you’re ready for the waterworks, you can almost feel how massive his load is going to be. Zenji moans loudly, thrusting into your tail, his length twitches and convulses as he shoots ropes of cum into the air. Strings of seed jets continuously, Zenji is virile as ever and the teasing and torment you’ve inflicted on him only seems to heighten his orgasm. You watch in awe as each rope reaches slightly higher than the last shot before. Zenji moans softly as his body relaxes and each wave grows shorter. After at least a minute of cumming he finally calms down, breathing softly, drenched in a bath of his seed.\n\n");
			outputText("You ask if such a naughty troll had a good time beneath the coils of your scales. Zenji gives you a pleading look, silently begging for more.\n\n");
			outputText("You decide that he’s gotten enough foreplay, he better get himself cleaned up if he wants to have fun again. You bring your cum coated tail to his lips, he reflexively licks your scales as you slide your tail around his face. He laps up the cum until he’s licked your tail clean. Once you’re done teasing your hunky troll, you uncoil your tail around him, deciding to leave him alone with his pool of cum for the time being.\n\n");
			loverZenjiSexTeaseEnd();
		}
		public function loverZenjiSexTeaseNagaNo():void {
			outputText("You grin deviously as you uncoil your grip on his body. He whines with need, grunting with dismay as his orgasm is so close, but being denied before him. His face clenches, his expression is pained as he desperately tries to hump the air, trying to get himself off to no avail. His fists dig up more dirt as he clenches his body.\n\n");
			outputText("\"<i>Please, please, please, please, please! D-don’t stop!</i>\" He growls, distressed by your lack of affection.\n\n");
			outputText("It’s satisfying watching your hunky troll grovel, desperate for your presence. You slide your cumslicked tail up to his face, gently caressing his cheek with the base of your tail before abandoning him with his lust.\n\n");
			outputText("You can hear him whimpering with need as you leave him.\n\n");
			loverZenjiSexTeaseEnd();
		}
		public function loverZenjiSexTeaseBipedalYes():void {
			outputText("You grin in satisfaction as you continue your footjob, your lover is fixing to burst and you’re ready for the waterworks, you can almost feel how massive his load is going to be. Zenji moans loudly, thrusting into your foot, his length twitches and convulses as he shoots ropes of cum into the air. Strings of seed jets continuously, Zenji is virile as ever and the teasing and torment you’ve inflicted on him only seems to heighten his orgasm. You watch in awe as each rope reaches slightly higher than the last shot before. Zenji moans softly as his body relaxes and each wave grows shorter. After at least a minute of cumming he finally calms down, breathing softly, drenched in a bath of his seed.\n\n");
			outputText("You ask if such a naughty troll had a good time beneath the grip of your toes. Zenji gives you a pleading look, silently begging for more.\n\n");
			outputText("You decide that he’s gotten enough foreplay, he better get himself cleaned up if he wants to have fun again. You bring your cum coated foot to his lips, he reflexively licks your skin as you slide your foot around his face. He laps up the cum until he’s licked your sole clean. Once you’re done teasing your hunky troll, you decide to leave him alone with his pool of cum for the time being.\n\n");
			loverZenjiSexTeaseEnd();
		}
		public function loverZenjiSexTeaseBipedalNo():void {
			outputText("You grin deviously as you unclench your grip on him. He whines with need, grunting with dismay as his orgasm is so close, but being denied before him. His face clenches, his expression is pained as he desperately tries to hump the air, trying to get himself off to no avail. His fists dig up more dirt as he clenches his body.\n\n");
			outputText("\"<i>Please, please, please, please, please! D-don’t stop!</i>\" He growls, distressed by your lack of affection.\n\n");
			outputText("It’s satisfying watching your hunky troll grovel, desperate for your presence. You slide your cumslick foot up to his face, gently caressing his cheek with the back of your nails before abandoning him with his lust.\n\n");
			outputText("You can hear him whimpering with need as you leave him.\n\n");
			loverZenjiSexTeaseEnd();
		}
		public function loverZenjiSexTeaseEnd():void {
			player.addStatusValue(StatusEffects.ZenjiZList, 3, 1);
			endEncounter();
		}

		public function loverZenjiSexNevermind():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You blush softly, telling him that after some consideration you aren’t really up to having sex with him right now.\n\n");
			if (player.lib < 200) {
				outputText("Zenji smiles at you softly, wrapping you within his embrace. He sighs deeply as he strokes your head. He seems intent on just being with you for a moment. After a little bit of being cradled by him, Zenji gives you a gentle caress across the cheek, \"<i>It’s okay [name], don’ force yaself to do someting you don’ want. If you ever need anyting from me, don’ hesitate to ask.</i>\"\n\n");
				outputText("Zenji lets go of you and you’re free to decide what to do now.\n\n");
			}
			else {
				outputText("Zenji looks crestfallen, his ears droop as he looks at you with pleading eyes, \"<i>[name]... please… I need you so badly, please [name], don’t do dis to me...</i>\"\n\n");
				outputText("He falls to his knees, addled by lust, \"<i>I need you so badly [name]...</i>\" He takes a deep sigh, his burly chest heaves from his breathing, his massive arm lowers to his groin, pressed down his erection, \"<i>Can’t you see what you’re doing ta me..? I need you now more dan ever…</i>\"\n\n");
				outputText("You apologize, but you just can’t right now.\n\n");
				outputText("Zenji gives a pained sigh, grunting softly as he touches his throbbing erection, already leaking copious amounts of pre. He falls to his back, panting softly. His erection is at full mast, cutting into the air as he groans with unsteady breaths.\n\n");
				outputText("You leave him alone for the time being, who knows what he may do while he waits though.\n\n");
			}
			doNext(loverZenjiMainCampMenu);
		}

		private function zenjiSleepToggle():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if(flags[kFLAGS.SLEEP_WITH] != "Zenji") {
				outputText("You ask Zenji if he wouldn't mind spending the nights with you; after all, you feel much safer within his presence.\n\n");
				outputText("Zenji gives you a gentle smile, \"<i>Of course, I will always be beside you, [name].</i>\" He grabs your hands, holding them gently, \"<i>Whenever you're ready to call it a night, don' hesitate t' ask me ta spend it with ya.</i>\"\n\n");
				flags[kFLAGS.SLEEP_WITH] = "Zenji";
			}
			else {
				outputText("You tell Zenji that you don't want to sleep with him for now.\n\n");
				outputText("Zenji nods respectfully, but his cheeky smile shines through, \"<i>Of course, my independent champion.</i>\"\n\n");
				flags[kFLAGS.SLEEP_WITH] = "";
			}
			menu();
			addButton(0,"Next", loverZenjiMainCampMenu);
		}

		public function loverZenjiSleepWithMorning():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You awaken the next morning, still wrapped in his embrace. You feel rested thanks to Zenji’s comfort. As your eyes open you come to realize that you’re resting on his chest tuft between his strong, manly pectorals. Despite being dense and muscular, it’s still very comfortable to rest against him considering his luxuriously soft fur.\n\n");
			outputText("\"<i>Good morning [name]. Sleep well?</i>\" He asks, gently caressing your face.\n\n");
			outputText("You assure him that you did, it’s nice spending the night with him.\n\n");
			outputText("\"<i>We got a whole day ahead of us now, best ta get to it.</i>\" He replies, disentangling his tail from you while helping you get up, ready to start the day.\n\n");
			outputText("You nod, ready to start the day, but now you have the support of your lover backing you up. You tell him as you reach your [finger] up and give him a scratch behind his ear.\n\n");
			outputText("Zenji sighs softly as he sinks into your ministrations, he’s like putty in your hands. \"<i>R-right dere, [name]... yeah… dat’s de spot…</i>\" he says with his eyes closed as his ears twitch slightly. You can hear his tail swishing happily behind him like an excited puppy.\n\n");
			outputText("You laugh, you’re not used to this side of him. It would seem his ears are quite the soft spot for him.\n\n");
			outputText("As much as you enjoy toying with him you decide that you must continue with your day. You finally break the trance you’ve brought him in.\n\n");
			outputText("Zenji seems visibly disheartened when you remove your [finger] from his ear before he blushes softly. Before you can say anything, he reaches his hand out to hold yours, \"<i>Let's get on wit de day den.</i>\"\n\n");
			outputText("You spend a moment looking into his eyes, holding your hand with his. You know you can take on any challenge with him by your side. The day ahead waits for you to put that thought to the test.");
			ZenjiSleepCount += 1;
			doNext(playerMenu);
		}
		public function loverZenjiSleepWithGetPenetrated(timeQ:Number):void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you want to spend the night closer to him"+(player.isNaked() ? "":" you say as you take off your underwear")+".\n\n");
			outputText("Zenji gives you a toothy grin, \"<i>Dat's why I wanna sleep wit ya tonight.</i>\"\n\n");
			outputText("You caress his strong, masculine arms, desiring his touch. His tail wraps around you affectionately, but you slip out of his grasp. You lie down on your bed, telling him that he doesn't need an invitation to join you. You want him to take you right here on the bed.\n\n");
			outputText("Zenji gives you a small laugh, but he can't hide his arousal for you as he's already at full mast, leaking copious amounts of pre from the tip of his length. He creeps up onto the bed, kneeling above you.\n\n");
			outputText("He places the length of his penis along the lips of your box, gently teasing you with his manhood as he rubs himself against you. You wrap your [leg] around his waist as he drags the tip of his length across your lips, drooling precum all over you.\n\n");
			outputText("\"<i>Ya like dat?</i>\" he teases, placing his hands next to your shoulders.\n\n");
			outputText("You nod as you stare into his eyes. His smug aura hovers over you as he gives you a charming, yet toothy grin.\n\n");
			outputText("He leans down, pressing his lips against yours"+(player.statusEffectv4(StatusEffects.ZenjiModificationsList) == 7 ? ", careful not to get his tusks caught in the bed":"")+" as he gradually begins humping you. His heavy balls press against your [leg], full and ready to unleash his load within you. You can feel yourself getting so wet, desperate for him to penetrate you.\n\n");
			outputText("You break away from his kiss, unable to take it anymore, you need him in you. You tell him you want him in you now.\n\n");
			outputText("\"<i>Now den, dat's no way to talk ta ya big bad troll, ask nicely.</i>\"\n\n");
			outputText("You squirm under him, pleading for him to stop teasing you and just put it in for you. You need your hunky troll lover more than anything else.\n\n");
			outputText("\"<i>Dat's better...</i>\" He croons as he slides his cumslicked manhood into you.\n\nHis shaft presses into your ");
			if (player.vaginalCapacity() <= 9) outputText("tight snatch, gently stretching out your walls. He feels so big inside you as he makes his way into you."+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? " Maybe making him so huge wasn’t the best idea.":"")+"");
			else if (player.vaginalCapacity() < 79) outputText("moist snatch, gently pressing his way into you. He feels so good inside you as he pushes deeper, gently bucking into you.");
			else outputText("moist snatch, gently pressing his way into you. While he may not be the biggest you've had, he is skilled and you couldn't wish for anyone better.\n\n");
			outputText("\n\nZenji gives a hungry growl as he slowly thrusts into you. His pace is agonizing, teasing you with the sluggish pace. He notices your strain beneath him and he places his palm across your face, rubbing his thumb across your cheek affectionately"+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? ". The outline of his massive manhood bulges through your stomach":"")+".\n\n");
			player.cuntChange(15,true,true,false);
			outputText("\"<i>Too slow fa ya?</i>\" He laughs. \"<i>Want me ta go faster?</i>\" He asks tauntingly.\n\n");
			outputText("You breathe sharply before nodding.\n\n");
			outputText("\"<i>Haha, you can beg betta dan dat.</i>\"\n\n");
			outputText("You grab hold of his larger hand, caressing your face with him, giving his fuzzy finger a small lick before pleading, you need him to go faster, you want him to go faster, you're desperate for his touch, for him, you need him now more than ever, you need to be bred with every ounce of love he has to offer.\n\n");
			outputText("\"<i>Much betta...</i>\" He whispers. Your words of desperation are more than enough for him as he begins picking up the pace. Zenji growls softly as he buries himself deeper into your womb, thrusting with greater passion. You feel your body rocked to the very core as he presses his hips against you, trying to bury his length as deep as it will go within you, making sure not to leave a single inch of your inner walls unscratched. It doesn't take long before a familiar pressure builds up within your loins. ");
			outputText("You moan softly and beg him not to stop. You throw your head back as you find yourself cumming over him, your [legs] squeeze around him harder as your vagina clamps tightly around him, trying to milk his dick of everything he has.\n\n");
			outputText("Zenji gives you a cocky smile as he slowly pulls out, his lack of presence within you is agony. \"<i>We're not done until I'm done...</i>\" he growls. \"<i>Sit up an' open wide,</i>\" he states, patting your head gently, \"<i>It’s time for a little treat...</i>\"\n\n");
			outputText("You crawl up to your knees and he pulls his length up, ready for you to blow him. You desperately place your lips at the tip of his rock hard length, licking up all the precum he has to offer. \"<i>Ya really are good at dis...</i>\" he says between moans. He grabs the back of your head and presses you into him. You ");
			if (player.gender == 0) outputText("slowly fondle your body as you blow Zenji");
			else outputText(""+(player.hasCock() ? "stroke at your length as you blow him, trying to get the most out of the situation":"gently finger yourself, playing with your clit and probing your box")+"");
			outputText(". The scent of his musk is overpowering, his arousal for you is so dense; it’s dizzying.\n\n");
			outputText("You are met with him suddenly pulling away from your face before Zenji firmly pushes you back onto the bed. He pulls your legs out from under you as he quickly positions himself above your slick vagina, teasing your lips with his manhood before sliding back in. You almost get whiplash by how quickly you’re tossed down beneath him.\n\n");
			outputText("Zenji starts panting, \"<i>Not... Finished... Yet..!</i>\" He growls, picking up the pace further. You can feel him thrusting with greater passion before finally howling as he cums inside you, his erection pulses with need, desperate to stuff you with his children. You ");
			if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 18700) outputText("can feel yourself inflate from the warm seed flowing into you. Zenj holds onto you tighter, forcing you to take as much as possible. His growls grow louder as you’re filled well beyond your limit, excess cum pouring out onto the bed beneath you. Somehow the mess doesn’t concern you too much");
			else if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 4700) outputText("can feel his load surge through your womb, tremendous as ever, filling you up past your limits as your stomach bulges outward, spilling out onto the bed beneath you as well");
			else outputText("feel the warmth of his seed surge inside you, being filled by his warm, gooey love");
			outputText(". Zenji finally begins to relax, careful not to put all of his weight on you. He pulls out, cum leaking from his tip as he shifts over, lying beside you as he pulls you face-first into his burly chest. The scent of him lingers as he holds you tightly, cradling you in his fuzzy embrace. Exhausted from the rough sex, you find yourself getting dizzy from his musky aroma as you fall out of consciousness for the night. The last thing you hear is his soft-spoken words.\n\n");
			outputText("\"<i>Dat... was amazing...</i>\" He whispers as his tail coils around you, \"<i>Sleep tight, [name]...</i>\"\n\n");
			outputText("Zenji gently strokes your back as he curls up with you.\n\n");
			outputText("You plan on sleeping for " + num2Text(timeQ) + " hours.\n\n");
			player.sexReward("cum", "Vaginal");
			if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
			else player.knockUp(PregnancyStore.PREGNANCY_ZENJI, PregnancyStore.INCUBATION_ZENJI);
			player.addStatusValue(StatusEffects.ZenjiZList, 2, 1);
			ZenjiSleepCount += 1;
			menu();
			addButton(0,"Next",camp.sleepWrapper);
		}
		public function loverZenjiSleepWithCatchAnal(timeQ:Number):void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You tell Zenji that you want to spend the night closer to him"+(player.isNaked() ? "":" you say as you take off your underwear")+".\n\n");
			outputText("Zenji gives you a toothy grin, \"<i>Dat's why I wanna sleep wit ya tonight.</i>\"\n\n");
			outputText("You caress his masculine arms, desiring his touch, you position yourself so that you're facing away, you shake your rear teasingly, waiting for his entrance.\n\n");
			outputText("Zenji gives you a small laugh, but he can't hide his arousal for you as he's already at full mast. He creeps up onto the bed, kneeling above you.\n\n");
			outputText("He slides the length of his penis along your backdoor, taunting you with his manhood, \"<i>Ya want dis, dontcha?</i>\"\n\n");
			outputText("You moan softly in response, you want it more than ever.\n\n");
			outputText("Zenji gives you a taunting chuckle, \"<i>Now den, dat's no way to talk ta ya big bad troll, ya gotta want it. Show me how much ya want it, [name].</i>\"\n\n");
			outputText("You plead, you need his touch, you crave him now more than ever, you're desperate for everything he has to offer, you need your hunky troll lover more than anything else.\n\n");
			outputText("\"<i>Dat's better...</i>\" He growls softly as he slides his precum coated dick inside your backdoor.\n\n");
			if (player.analCapacity() < 7) outputText("His lengthy shaft presses its way deep inside of your tight anus, you feel yourself stretch over his considerable manhood"+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? " Maybe making him so huge wasn’t the best idea":"")+".\n\n");
			else if (player.analCapacity() < 56) outputText("His lengthy shaft presses into you, you can feel him accommodating your [ass] as he presses further and further with each thrust.\n\n");
			else outputText("His lengthy shaft presses into you, you can feel him press into your roomy backside as he pushes deeper into you with each thrust.\n\n");
			outputText("Zenji moans softly as he slowly thrusts into you. His balls press against your behind with each slow thrust, large, fuzzy, and virile as ever. His pace is agonizing, teasing you with the snail-like pace. He notices your strain beneath him and he places his palm across your face, rubbing his thumb across your cheek affectionately"+(player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32 ? " The outline of his massive manhood bulges through your stomach":"")+".\n\n");
			player.buttChange(15,true,true,false);
			outputText("\"<i>Too slow fa ya?</i>\" He laughs. \"<i>Want me ta go faster?</i>\" he asks tauntingly.\n\n");
			outputText("You breathe sharply before nodding.\n\n");
			outputText("\"<i>Haha, ya can beg betta dan dat.</i>\"\n\n");
			outputText("You grab hold of his larger hand, caressing your face with him, giving his fuzzy finger a small lick before pleading, you need him to go faster, you want him to go faster, you're desperate for his touch, for him, you need him now more than ever. You need to be filled with every ounce of love he could ever give you.\n\n");
			outputText("Your words of desperation are more than enough for him as he begins picking up the pace. Zenji gives a low, hungry growl as he buries himself deeper into your sphincter. It doesn't take long before a familiar pressure builds up within your loins. Zenji continues pounding away, his hips constantly clash against your own, rocking your entire body with each powerful thrust. You moan softly and beg him not to stop. You "+(player.hasCock() ? "groan as your shoot your load all over the bed below you":"")+((player.hasVagina() && !player.hasCock()) ? "tilt your head back and moan as you cum, girlcum trickling down your [legs]":"")+". You try to milk his dick with your asshole, but he's still going strong.\n\n");
			outputText("Zenji’s tail reaches down from under you, gently teasing the underside of your taint. He reaches over, ");
			if (player.gender == 0) outputText(" gently fondling the underside of your taint");
			else outputText(""+(player.hasCock() ? "gently grasping your throbbing shaft as he strokes it for":"")+((player.hasVagina() && !player.hasCock()) ? "gently teasing your clit as he slowly fingers":"")+" you, his tail joins in the fun as well");
			outputText(". \"<i>Ya got some weak endurance, how about ya come again for me?</i>\" His other hand reaches over, grabbing at your chest, slowly tweaking at your nipples with a single large finger. He toys around with you, coaxing further arousal as you lose your senses beneath him.\n\n");
			outputText("Zenji slowly bucks into your [ass] as he toys around with you. You squirm beneath his softy hairy touch, desperate for more, desperate for his silky grace. He doesn't lose the gentle pace of simultaneously plowing you and giving you a gentle handjob. It doesn't take long before you can't take it anymore, the sensation is too much for you and you find yourself cumming into his hands.\n\n");
			outputText("Zenji picks up the pace as he starts panting, \"<i>Not... Finished... Yet..!</i>\" He growls, picking up the pace further. His erection pulses with need, desperate to fill your hole with his seed, ready to unleash all of his pent up need into you. You can feel him thrusting with greater passion before finally howling as he cums inside you. You feel the warmth of his seed race inside you. \n\n");
			if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 18700) outputText("You can feel yourself inflate from the warm seed flowing into you. Zenj holds onto you tighter, forcing you to take as much as possible. His growls grow louder as you’re filled well beyond your limit, excess cum pouring out onto the bed beneath you. Somehow the mess doesn’t concern you too much");
			else if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 4700) outputText("So much cum is flooding into your back door, to the point where your stomach distends slightly as the rest pours out onto the bed beneath you");
			else outputText("You feel the warmth of his seed race inside you, being filled by the sheer amount he has to offer");
			outputText(".\"<i>Dat… really was someting...</i>\" He whispers as his tail coils around you, \"<i>Sleep tight, [name]...</i>\"\n\n");
			outputText("Zenji gently caresses your face as he curls up with you.\n\n");
			outputText("You plan on sleeping for " + num2Text(timeQ) + " hours.\n\n");
			player.sexReward("cum","Anal");
			player.addStatusValue(StatusEffects.ZenjiZList, 2, 2);
			ZenjiSleepCount += 1;
			menu();
			addButton(0,"Next",camp.sleepWrapper);
		}
		public function loverZenjiSleepWithNoSex(timeQ:Number):void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You decide that you don't want to work yourself before getting a good night's sleep with your lover. You tell Zenji that you just want to feel his embrace for now and relax in his arms.\n\n");
			outputText("Zenji gives you a toothy smile as he moves the covers over, sliding into bed as you join him. You press up against his toned frame, his powerful body encompassing you as he wraps his fuzzy arms over you, ardently pulling you close into the warmth of his fur.");
			if (player.tailType != Tail.NONE) outputText(" You feel his tail coil around you, you reflexively bring your [tail] to tangle with his, the two of you locking tails with each other.");
			else outputText(" You can feel his tail fondly stroke your body with tender caresses.");
			if (player.tailType == Tail.FOX) outputText(" You hate to admit it, but Zenji’s tail just might almost kind of rival yours in terms of how soft and cuddly it is.");
			outputText("\n\nHis erection is pressed up against you, but he doesn't press the matter further, seemingly content on sniffing you from time to time. The world becomes hazy and your consciousness drifts as you fall asleep in Zenji's soft embrace.\n\n");
			outputText("You plan on sleeping for " + num2Text(timeQ) + " hours.\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 2, 3);
			ZenjiSleepCount += 1;
			menu();
			addButton(0,"Next",camp.sleepWrapper);
		}
		public function loverZenjiSleepWithGetPenetratedMorning():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You wake up the next morning. As you open your eyes your face is still nestled in Zenji's chest tuft between his manly pectorals. You feel a soothing sense of comfort as you awaken. Zenji is gently rubbing your back with slow and repeated motions. Daylight pours into the room and you give a small yawn and look up at Zenji, his eyes are rested upon your face.\n\n");
			outputText("\"<i>Good morning [name]. Sleep well?</i>\" He asks, giving you a gentle smile.\n\n");
			outputText("You tell him that indeed you did and are hoping to do this again with him.\n\n");
			outputText("Zenji strokes the top of your head, \"<i>Dis is nice, spending da night together, I'm glad ya enjoyed it as much as I did</i>\" He pulls you closer to him for a peck on the lips.\n\n");
			outputText("Zenji finally releases his grasp on you to stretch, liberating you from his enticing musk. You take the moment of deliverance to stretch.\n\n");
			outputText("You look down, remembering just how hefty of a load Zenji poured out onto you, you’re not sure how or when exactly, but at some point, Zenji has cleaned the two of you off.\n\n");
			outputText("Zenji helps you get dressed as he puts his loincloth on. \"<i>Ya ready for another day, champion?</i>\"\n\n");
			outputText("You nod, ready for sure, but now you have the support of your lover backing you up. You tell him as you reach your [finger] up and give him a scratch behind his ear.\n\n");
			outputText("Zenji sighs softly as he sinks into your ministrations, he’s like putty in your hands. \"<i>R-right dere, [name]... yeah… dat’s de spot…</i>\" he states with his eyes closed as his ears twitch slightly. You can hear his tail swishing happily behind him like an excited puppy.\n\n");
			outputText("You laugh, you’re not used to this side of him. It would seem his ears are quite the soft spot for him.\n\n");
			outputText("As much as you enjoy toying with him you decide that you must continue with your day. You finally break the trance you’ve brought him in.\n\n");
			outputText("Zenji seems visibly disheartened when you remove your [finger] from his ear before he blushes softly. \"<i>D-dat… dat was nice… I-I can’t believe you had me under ya fingers like dat…</i>\" He scratches behind his ear softly. \"<i>Let's get on wit de day den.</i>\"\n\n");
			outputText("You give him a knowing smile, maybe you’ll find another time to mess with him.");
			player.addStatusValue(StatusEffects.ZenjiZList, 2, -1);
			ZenjiSleepCount += 1;
			doNext(playerMenu);
		}
		public function loverZenjiSleepWithCatchAnalMorning():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You wake up the next morning, the almost aggressive scent of sweat and grass hits you. You immediately recognize it as Zenji’s musk. You feel a soothing sense of comfort as you awaken. Zenji is gently rubbing your back with slow and repeated motions. As you open your eyes your face is still nestled in Zenji's chest tuft between his muscular pecs. Daylight pours into the room and you give a small yawn and look up at Zenji, his eyes are rested upon your face.\n\n");
			outputText("\"<i>Good morning [name]. Sleep well?</i>\" He asks, giving you a gentle smile.\n\n");
			outputText("You tell him that indeed you did and are hoping to do this again with him.\n\n");
			outputText("Zenji strokes the top of your head, \"<i>Dis is nice, spending da night together, I'm glad ya enjoyed it as much as I did.</i>\" He pulls you closer to him for a peck on the lips.\n\n");
			outputText("Zenji finally releases his grasp on you to stretch, liberating you from his enticing musk. You take the moment of deliverance to stretch.\n\n");
			outputText("You look down, remembering just how hefty of a load Zenji poured out onto you, you’re not sure how or when exactly, but at some point, Zenji has cleaned the two of you off.\n\n");
			outputText("Zenji helps you get dressed as he puts his loincloth on. \"<i>Ya ready for another day, champion?</i>\"\n\n");
			outputText("You nod, ready for sure, but now you have the support of your lover backing you up. You tell him as you reach your [finger] up and give him a scratch behind his ear.\n\n");
			outputText("Zenji sighs softly as he sinks into your ministrations, he’s like putty in your hands. \"<i>R-right dere, [name]... yeah… dat’s de spot…</i>\" he states with his eyes closed as his ears twitch slightly. You can hear his tail swishing happily behind him like an excited puppy.\n\n");
			outputText("You laugh, you’re not used to this side of him. It would seem his ears are quite the soft spot for him.\n\n");
			outputText("As much as you enjoy toying with him you decide that you must continue with your day. You finally break the trance you’ve brought him in.\n\n");
			outputText("Zenji seems visibly disheartened when you remove your [finger] from his ear before he blushes softly. \"<i>D-dat… dat was nice… I-I can’t believe you had must under ya fingers like dat…</i>\" He scratches behind his ear softly. \"<i>Let's get on wit de day den.</i>\"\n\n");
			outputText("You give him a knowing smile, maybe you’ll find another time to mess with him.");
			player.addStatusValue(StatusEffects.ZenjiZList, 2, -2);
			ZenjiSleepCount += 1;
			doNext(playerMenu);
		}
		public function loverZenjiSleepWithNoSexMorning():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You awaken and attempt to stretch, but you are firmly locked in place. You give a small yawn and open your eyes. Daylight pours into your room as you look down and see Zenji's arms still firmly around you. You feel something poking at your rear, it must be his morning wood. Zenji stirs softly before awakening with a yawn.\n\n");
			outputText("\"<i>Good morning, [name]. Sleep well?</i>\" He asks, \"<i>It’s been some time since I last slept so well...</i>\"\n\n");
			outputText("You turn around and face him, giving him a sincere smile, you tell him that you'll always enjoy spending quality time with him. You pull his face closer to yours and plant a kiss firmly on his lips. You pull away, Zenji seems stunned for a moment, he obviously wasn't prepared for your advancement.\n\n");
			outputText("\"<i>Always full of surprises...</i>\" he remarkes, laughing softly to himself. \"<i>It’s why I love you so much…</i>\"\n\n");
			outputText("Zenji reaches a hand to your face, gently caressing your cheek. He leans close to you, rubbing his soft beard against your face affectionately. You sink into his comfort as Zenji nuzzles you. After a moment together Zenji tilts your face to look him in the eyes. He gives you a gentle smile before giving you a soft kiss on the lips.\n\n");
			outputText("\"<i>You’re everyting to me, [name]. Don’t forget it. Now, let’s get on wit de day.</i>\"\n\n");
			outputText("Zenji helps you get dressed, soon enough you're ready to start your day; refreshed and ready to take on whatever will be thrown at you.");
			player.addStatusValue(StatusEffects.ZenjiZList, 2, -3);
			ZenjiSleepCount += 1;
			doNext(playerMenu);
		}

		public function loverZenjiGlades():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (flags[kFLAGS.ZENJI_DESTROYING_CORRUPTED_GLADES] == 0) {
				outputText("You ask Zenji for him to help you tear down the corrupted glades that plague the land.\n\n");
				outputText("Zenji gives you a gentle smile, \"<i>Anyting ta help ya rest easy.</i>\"\n\n");
				flags[kFLAGS.ZENJI_DESTROYING_CORRUPTED_GLADES] = 1;
			}
			else {
				outputText("You tell Zenji that you no longer require his assistance in destroying the glades.\n\n");
				outputText("Zenji peers at you curiously, \"<i>If dat is what you want.</i>\"\n\n");
				flags[kFLAGS.ZENJI_DESTROYING_CORRUPTED_GLADES] = 0;
			}
			doNext(loverZenjiMainCampMenu);
		}

		public function loverZenjiNightWatch():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (ZenjiNightWatch == 0) {
				outputText("You tell Zenji that you want him to watch over the camp at night.\n\n");
				outputText("Zenji pats his chest with his fist before giving you a half salute, \"<i>Te protegeré con mi vida, flaca.</i>\"\n\n");
				ZenjiNightWatch = 1;
			}
			else {
				outputText("You tell Zenji you don't want him to watch over the camp at night, he deserves some rest after all.\n\n");
				outputText("Zenji shakes his head softly, \"<i>If dat be ya wish, so be it, but I won't hesitate to kill anyone who threatens you.</i>\"\n\n");
				ZenjiNightWatch = 0;
			}
			doNext(loverZenjiMainCampMenu);
		}

		public function zenjiHenchmanOption():void {
			menu();
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "") {
				if (flags[kFLAGS.PLAYER_COMPANION_2] == "Zenji" || flags[kFLAGS.PLAYER_COMPANION_3] == "Zenji") addButtonDisabled(0, "Assist Me (1)", "You already have Zenji accompany you.");
				else addButton(0, "Assist Me (1)", zenjiHenchmanOption2, false, 1).hint("Ask Zenji to join you in adventures outside camp.");
			}
			else {
				if (flags[kFLAGS.PLAYER_COMPANION_1] == "Zenji") addButton(5, "Assist Me (1)", zenjiHenchmanOption2, false, 21).hint("Ask Zenji to stay in camp.");
				else addButtonDisabled(5, "Assist Me (1)", "You already have other henchman accompany you as first party member. Ask him/her to stay at camp before you talk with Zenji about accompaning you as first party member.");
			}
			if (player.hasPerk(PerkLib.IntermediateLeadership)) {
				if (flags[kFLAGS.PLAYER_COMPANION_2] == "") {
					if (flags[kFLAGS.PLAYER_COMPANION_1] == "Zenji" || flags[kFLAGS.PLAYER_COMPANION_3] == "Zenji") addButtonDisabled(1, "Assist Me (2)", "You already have Zenji accompany you.");
					else addButton(1, "Assist Me (2)", zenjiHenchmanOption2, false, 2).hint("Ask Zenji to join you in adventures outside camp.");
				}
				else {
					if (flags[kFLAGS.PLAYER_COMPANION_2] == "Zenji") addButton(6, "Assist Me (2)", zenjiHenchmanOption2, false, 22).hint("Ask Zenji to stay in camp.");
					else addButtonDisabled(6, "Assist Me (2)", "You already have other henchman accompany you as second party member. Ask him/her to stay at camp before you talk with Zenji about accompaning you as second party member.");
				}
			}
			else {
				addButtonDisabled(1, "Assist Me (2)", "Req. Intermediate Leadership.");
				addButtonDisabled(6, "Assist Me (2)", "Req. Intermediate Leadership.");
			}
			addButton(14, "Back", loverZenjiMainCampMenu);
		}
		public function zenjiHenchmanOption2(textBypass:Boolean =false, slot:Number = 1):void
		{
			if (!textBypass) clearOutput();
			if (slot < 21) {
				if (!textBypass) {
					outputText("Zenji readies his spear before flexing his arms, \"<i>¡Vamanos, flaca!</i>\"\n\n");
					outputText("Zenji is now following you around.\n\n");
				}
				var strZenji:Number = 50;
				var meleeAtkZenji:Number = 145;
				if (player.level > 25 && player.level < 185) {
					strZenji += 29 * Math.round((player.level - 20) / 5) * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					meleeAtkZenji += 5 * Math.round((player.level - 20) / 5) * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				}
				else if (player.level >= 185) {
					strZenji += 957 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					meleeAtkZenji += 165 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				}
				strZenji *= (1 + (0.2 * player.newGamePlusMod()));
				strZenji = Math.round(strZenji);
				meleeAtkZenji += (1 + (int)(meleeAtkZenji / 5)) * player.newGamePlusMod();
				player.createStatusEffect(StatusEffects.CombatFollowerZenji, strZenji, meleeAtkZenji, 0, 0);
				if (slot == 2) flags[kFLAGS.PLAYER_COMPANION_2] = "Zenji";
				if (slot == 1) flags[kFLAGS.PLAYER_COMPANION_1] = "Zenji";
			}
			else {
				if (!textBypass){
					outputText("You tell Zenji that you don't want him to assist you in combat anymore.\n\n");
					outputText("Zenji raises an eyebrow at you, \"<i>If dat's whatchu want, I will guard de camp, but you stay safe out dere.</i>\"\n\n");
					outputText("Zenji is no longer following you around.\n\n");
				}
				player.removeStatusEffect(StatusEffects.CombatFollowerZenji);
				if (slot == 22) flags[kFLAGS.PLAYER_COMPANION_2] = "";
				if (slot == 21) flags[kFLAGS.PLAYER_COMPANION_1] = "";
			}
			doNext(loverZenjiMainCampMenu);
			cheatTime(1/12);
		}

		public function loverZenjiMainCampMenuLeave():void {
			outputText("You realize that you don’t have anything you need from him at this moment, you apologize and take your leave.\n\n");
			outputText("Zenji gives you a small nod as he dismisses you.\n\n");
			doNext(camp.campLoversMenu);
		}

		public function loverZenjiHalloweenEvent():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You wake up feeling rested, but suddenly you feel the presence of someone near you.\n\n");
			outputText("You shift around and notice Zenji sitting beside you, he appears disconcerted.\n\n");
			outputText("\"<i>[name]!</i>\" Zenji says, \"<i>I… I’m glad ya are safe, it just dat… Dese are strange times for me… De time of da year and all… Many trolls back at my home know dis to be de time when de dead become restless.</i>\"\n\n");
			outputText("He shifts around uneasily, \"<i>I never actually knew if dis was real, but de thought of it scared me when I was a child.</i>\"\n\n");
			outputText("You rub the sleep from your eyes and take a proper look at him. His face shows genuine concern for you, but you realize that he’s wearing face paint. Before waking you up he seems to have covered his face with burgundy and white patterns.\n\n");
			outputText("\"<i>When de dead rise up from de ground, dey know dey haven’t eaten since forever. Dese dead are after someting, anyting to eat… Any troll knows not ta hurt another troll, but de dead only see dead trolls as trolls… We would crush up some of de leaves we had around da jungle and mix water to make de face paint. De paint would make us look dead and dey would ignore us.</i>\"\n\n");
			outputText("Zenji places two wooden bowls of paint beside you, one white and the other burgundy.\n\n");
			outputText("Zenji brings you in for a brief embrace, \"<i>Dat’s why I’m here, to protect ya [name].</i>\"\n\n");
			outputText("He pulls aways and dips his fingers into the bowl, \"<i>Don’ worry, it’s just crushed up leaves and water, I’m wearin’ some right now. It won’t stain or dry out, I made sure of dat.</i>\"\n\n");
			outputText("You get up to your knees and consider for a moment, do you want to be wearing face paint like this for a while?\n\n");
			menu();
			addButton(1, "Yes", loverZenjiHalloweenEventYes);
			addButton(3, "No", loverZenjiHalloweenEventNo);
		}
		public function loverZenjiHalloweenEventYes():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("Zenji continues uninterrupted, his right hand now carrying a small coating of burgundy paint.");
			outputText("With paternal gentleness, he rubs his thumb across your face, creating a series of ceremonial markings. His hands have less fur, you can feel the gentle warmth of his skin press against your face\n\n");
			outputText("You watch him work his way around you, his mouth unconsciously slightly agape has he focuses all of his attention on you.\n\n ");
			outputText("He coats his left hand in the white paint, continuing drawing markings over your face, he pauses for a moment, his green eyes fixate onto yours.");
			outputText("\"<i>Even behind de mask of death, your beauty shines through.</i>\"\n\n");
			outputText("You can't help but smile at his compliment as he continues rubbing his fingers along your face, the warmth of his touch along with the cool pain is refreshing.");
			outputText("It doesn't take long until he's finished, making sure not to omit even the slightest detail.");
			outputText("He glances over your face, now covered by his ceremonial paint. \"<i>It’s a good look on ya [name], maybe I did a betta job on you dan I did ta myself.</i>\"");
			outputText("He gives a soft chuckle, eying you before speaking up once more, \"<i>I love you, [name]... I'm happy ya let me do dis wit ya.</i>\"\n\n");
			outputText("<b><i>Face Paint gives +10% magic resistance</i></b>\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 4, 2);
			endEncounter();
		}
		public function loverZenjiHalloweenEventNo():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You hold up a hand, telling Zenji that while you appreciate the offer, you are sure you can take care of yourself and don’t need the face paint.\n\n");
			outputText("Zenji seems hurt by your request, completely at a loss for words.\n\n");
			outputText("\"<i>I…</i>\" He shakes his head, \"<i>Dere is bravery, dere is ‘uperstition, but dis… I can’t protect ya from de dead when ya aren’t handled for it, but you said you’re a champion and… I… I will do anything for you, even if I disagree.</i>\"\n\n");
			outputText("He packs up the bowls of paint and leaves you to get ready for the morning.\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 4, 1);
			endEncounter();
		}
		public function loverZenjiHalloweenEventEnding():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("Zenji walks up to you, he seems less tense than he has been lately.\n\n");
			outputText("\"<i>[name], de time of de dead is ova, we can wash off de paint now, lest we invite death to dis camp,</i>\" he says, rubbing a hand over his chin.\n\n");
			outputText("Zenji guides you to the stream, he climbs down into it. He reaches a hand toward you, beckoning for you to join him.\n\n");
			outputText("You take off your outerwear before holding his hand as he brings you into the cool water. \"<i>It’s nice to be in de stream sometimes, ya know, [name]?</i>\"\n\n");
			outputText("You nod, it does feel nice to be carried by the water.\n\n");
			outputText("Zenji crouches down, bringing himself closer to the water, \"<i>I’m gonna wash dis paint off you now.</i>\"\n\n");
			outputText("He brings a hand out of the water, his fur now completely soaked. He uses his hand almost like an impromptu rag, gently rubbing away the paint from your face. He rubs his thumb across your cheek affectionately, \"<i>No matta what, your beauty has always shone through.</i>\"\n\n");
			outputText("He looks into your eyes with intent, longing to be with you. You spend a moment being cradled by him before you feel something prod at your [legs]. You jump slightly at the intrusion.\n\n");
			outputText("\"<i>Ah, sorry [name]...</i>\" Zenji says, blushing, \"<i>It’s just… It’s been some time since I had such a clear view of your face, you were always stunning… but now…</i>\" Zenji shakes himself out of it, \"<i>No, let’s finish getting dis paint off before we do anyting. Besides, it looks like I’m done cleaning you up, now it’s my turn.</i>\"\n\n");
			outputText("Zenji submerges his head into the stream before rising back out. His mohawk flops down and the short fur on his face droops from the weight of the water.\n\n");
			outputText("You spend some time cleaning off the paint from him, it’s surprisingly easy to remove and it doesn’t take long before you’re done.\n\n");
			outputText("Zenji caresses your face gently before smothering you into his chest. He’s still bulging through his loincloth.\n\n");
			outputText("Zenji looks down at you, \"<i>Let’s get outta de water, okay?</i>\"\n\n");
			outputText("It’d be a shame to just get out of the water so soon, do you want to reward him for helping you out with such a dangerous time?\n\n");
			menu();
			addButton(1, "Blow Him", loverZenjiHalloweenEventEndingBlowHim);
			addButton(3, "Dry Off", loverZenjiHalloweenEventEndingDryOff);
		}
		public function loverZenjiHalloweenEventEndingBlowHim():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You stop him right there as you have something else in mind you want to do before leaving the stream.\n\n");
			outputText("You tell Zenji to sit on the edge of the stream, you have a special reward for him since he kept you safe during such a dangerous time.\n\n");
			outputText("He does so, his legs still within the water as you walk up to him. You pull down his loincloth, revealing the troll’s manhood.\n\n");
			outputText("Zenji gives a small smirk, \"<i>Just can’t keep away can ya? I feel de same way…</i>\"\n\n");
			outputText("You kneel before him, the water going up to your torso. You glide a finger up his shaft, leaning in close to smell his musk. The usual scent of his musk has been washed away, but it’s not completely gone.\n\n");
			outputText("You place your lips at the head of his penis, the salty taste of his pre reaches your [tongue] as you gently tease at his tip. Zenji growls softly at your ministrations as water slides down from his toned abs onto your face. Zenji gently wipes the water away as you continue doing your best to grab hold of every last inch of him within your mouth.\n\n");
			outputText("You continue slurping up his pre and bobbing up and down his shaft when you feel him buck a little harder against you. He grabs hold onto the back of your head and pushes you down onto him. He growls softly with pent up need.\n\n");
			outputText("You try to back up, but he’s intent on getting himself off, losing his control over you.\n\n");
			outputText("\"<i>D-don stop [name]! So close… So good…</i>\" He thrusts himself into you slightly, desperate to get as much out of this as he can. You do your best to make sure that you don’t neglect any part of him.\n\n");
			outputText("He pushes you back slightly as he stands up. You feel the water around you stir as you wrap your arms around his legs for support. Zenji continues thrusting into your mouth with complete abandon.\n\n");
			outputText("He lets loose a low moan as you feel his length throb on your [tongue]. His climax hits hard as you feel "+(player.statusEffectv2(StatusEffects.ZenjiModificationsList) < 700 ? "rivers of spunk jet directly down your throat":"waves and waves of punk surge directly down your throat. You choke slightly at the sheer force of his seed, but you do your best to swallow as much as you can before coughing out the rest. Zenji continues cumming onto you before his orgasm finally dies down")+".\n\n");
			outputText("Zenji strokes your head affectionately, \"<i>Got a little carried away dere… Ya are getting really good at this…</i>\"\n\n");
			outputText("You look up to meet his gaze and give him a sly smile.\n\n");
			outputText("Zenji lifts you completely out of the water. You are supported only by his strong arms as he carefully places you on the ground outside the stream. He lifts himself out to join you on the ground.\n\n");
			outputText("Zenji pats himself down, rubbing some of the water off his fur, \"<i>Gonna be wet for some time now, water doesn’ come out easily from troll fur.</i>\" He gives you a longing glance, \"<i>But dat’s okay, I got you ta keep me company.</i>\" He lifts your chin to his and plants a soft kiss onto your lips.\n\n");
			outputText("You spend some time relaxing with him before you’ve dried off, ready to continue your day.\n\n");
			player.refillHunger(15);
			player.addStatusValue(StatusEffects.ZenjiZList, 4, -2);
			endEncounter();
		}
		public function loverZenjiHalloweenEventEndingDryOff():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			outputText("You nod, ready to leave the stream’s embrace.\n\n");
			outputText("Zenji lifts you completely out of the water. You are supported only by his strong arms as he carefully places you on the ground outside the stream. He lifts himself out to join you on the ground.\n\n");
			outputText("Zenji pats himself down, rubbing some of the water off his fur, \"<i>Gonna be wet for some time now, water doesn’ come out easily from troll fur.</i>\" He gives you a longing glance, \"<i>But dat’s okay, I got you ta keep me company.</i>\" He lifts your chin to his and plants a soft kiss onto your lips.\n\n");
			outputText("You spend some time relaxing with him before you’ve dried off, ready to continue your day.\n\n");
			player.addStatusValue(StatusEffects.ZenjiZList, 4, -2);
			endEncounter();
		}

		public function birthScene():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			if (flags[kFLAGS.ZENJI_PROGRESS] == -1) applyZenjikidName3();
			else {
				outputText("It's finally time, you feel yourself losing balance as your cervix begins convulsing, this baby is coming out, now! You cry in pain as you start to feel contractions as your abdominal muscles attempt to push out your child.\n\n");
				outputText("In no time Zenji is already by your side, \"<i>¡Ay miércoles! [name]! I'm here! I can tell someting was up. The baby is coming, I can feel it.</i>\"\n\n");
				outputText("You groan in pain, ready to give birth, hoping for a healthy child. Zenji has placed you on his bedroll, cushioned out with an assortment of different herbs.");
				outputText("\"<i>Relax, just focus on pressing out de baby, you got dis.</i>\"\n\n");
				outputText("You spread your legs, intent on pushing the child out.\n\n");
				outputText("\"<i>Feel de rhythm of ya body, push with the convulsions, I know you can do dis.</i>\" Zenji's words of assurance help you concentrate.\n\n");
				outputText("You lie down, screaming as Zenji kneels beside you, awaiting the child that you're about to bring into this world.\n\n");
				outputText("After an hour of pain and screaming, you've finally released the child from your womb.\n\n");
				outputText("Zenji cheers as he gently strokes your stomach, \"<i>I never doubted ya for a second [name],</i>\" he says before he cuts the umbilical cord from the baby with his tusks. \"<i>Tradition states dat de father always cuts de cord wit his tusks. I hope ya don' mind.</i>\"\n\n");
				outputText("You're thankful he's here, but now you want to see the child you've brought into this world together.\n\n");
				outputText("Zenji gently picks up the baby in his arms, inspecting them, \"<i>Yep, it’s a "+(!Z1stKid ? "boy":"girl")+" alright. De tusks haven't grown in yet, so it is best ta nurse dem while ya can so dey can grow big strong tusks like me.</i>\" He places your child on your chest, you pull "+(!Z1stKid ? "him":"her")+" closer so that they can latch onto you. Maternal pride overwhelms you as you begin crying tears of joy. Zenji leans down and nuzzles his face against yours, rubbing his beard affectionately against you, \"<i>Ya will be a fine mother, [name] I'm glad dat we can raise a family together… I love you [name]. Do ya know what ya wanna name dem..?</i>\"\n\n");
				if (flags[kFLAGS.ZENJI_KIDS] > 1) doNext(applyZenjikidName2);
				else {
					mainView.nameBox.text = "";
					menu();
					addButton(0,"Next",applyZenjikidName);
				}
			}
		}
		private function applyZenjikidName():void {
			spriteSelect(SpriteDb.s_zenji);
			if (CoC.instance.testingBlockExiting)
			{
				// We're running under the testing script.
				// Stuff a name in the box and go go go
				mainView.nameBox.text = "Zenji kiddo";
			}
			else if (mainView.nameBox.text == "" || mainView.nameBox.text == "0" || mainView.nameBox.text == "Zenji")
			{
				clearOutput();
				if (mainView.nameBox.text == "" || mainView.nameBox.text == "0") outputText("<b>You must select a name.</b>");
				else if (mainView.nameBox.text == "Zenji") outputText("\"<i>I'm honored, but dey can’t have my name! Pick another.</i>\"");
				mainView.nameBox.text = "";
				mainView.nameBox.visible = true;
				mainView.nameBox.width = 165;
				menu();
				mainView.nameBox.x = mainView.mainText.x + 5;
				mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
				addButton(0,"Next",applyZenjikidName);
				return;
			}
			if (Z1stKid == "") {
				Z1stKid = mainView.nameBox.text;
				flags[kFLAGS.ZENJI_KIDS] = 1;
			}
			else {
				Z2ndKid = mainView.nameBox.text;
				flags[kFLAGS.ZENJI_KIDS]++;
			}
			mainView.nameBox.text = "";
			mainView.nameBox.visible = false;
			clearOutput();
			outputText("\"<i>"+(Z2ndKid ? ""+Z2ndKid+"":""+Z1stKid+"")+"... I like dat name…'</i>\" he states with a smile.\n\n");
			outputText("Zenji relaxes by your side as you drift off to sleep within his protection, exhausted from giving birth.");
			endEncounter(120);
		}
		private function applyZenjikidName2():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			flags[kFLAGS.ZENJI_KIDS]++;
			outputText("Zenji gives you a gentle stare as he gently caresses your child, \"<i>Actually, Ya know... I was thinkin’, and I thought I should name dem dis time.</i>\"\n\n");
			outputText("He scoops up your baby once they detach from your breast. \"<i>What will daddy name you?</i>\" he croons, taking his child to his nest.\n\n");
			endEncounter(120);
		}
		private function applyZenjikidName3():void {
			spriteSelect(SpriteDb.s_zenji);
			clearOutput();
			flags[kFLAGS.ZENJI_KIDS]++;
			outputText("It's finally time for your pregnancy to come to an end. You feel yourself falling over as your cervix slowly dilates in preparation. This baby is coming out now! Your cry in pain as you start to feel the contractions as your abdominal muscles attempt to push out your child.\n\n");
			outputText("You glance around for... for the father. Zenji... he is truly a deadbeat husband. He couldn't handle you for yourself, so he doesn't deserve to have this child.\n\n");
			outputText("You groan in pain as you spread your legs, ready to give birth, hoping for a healthy child.\n\n");
			outputText("After an hour of pain and screaming, you successfully give birth to your child. She is doing just fine, taking her first breath as she cries.\n\n");
			outputText("Maternal pride overwhelms you. You manage to collect yourself enough to bring your baby to your breast to comfort her. She latches on reflexively as you take a moment to rest.\n\n");
			endEncounter(120);
		}

		public function mishapsLunaZenji():void {
			clearOutput();
			outputText("You notice Zenji surveying the camp for potential danger. As he hops off the tree he usually resides on top of, you notice a rope trap quickly close in on his ankle. Zenji is swept clean off his feet from the ground and hung upside down.\n\n");
			outputText("You notice a figure not too far off, trying to hold the rope up. You can’t quite see who it is from the bushes. Unfortunately, they must have underestimated just how much Zenji weighs as the rope slips from their hands.\n\n");
			outputText("Zenji screams in terror as he drops several feet from the air, crashing down on his head. You wince the moment he crashes into the ground. Your gaze narrows on the figure hiding in the bushes, but they’ve already run away. You could’ve sworn you saw a made outfit or something, but it couldn’t have been Luna, right? It doesn’t matter as you rush to Zenji to make sure he’s alright.\n\n");
			outputText("You inspect Zenji. He’s knocked completely unconscious but breathing steadily. It looks like he’ll be out of it for the time being.\n\n");
			if (player.hasStatusEffect(StatusEffects.CampLunaMishaps3)) player.addStatusValue(StatusEffects.CampLunaMishaps3, 1, 1);
			else player.createStatusEffect(StatusEffects.CampLunaMishaps3, 1, 0, 0, 0);
			if (!player.hasStatusEffect(StatusEffects.LunaWasCaugh)) player.createStatusEffect(StatusEffects.LunaWasCaugh, 1, 0, 0, 0);
			else player.addStatusValue(StatusEffects.LunaWasCaugh, 1, 1);
			if (player.statusEffectv1(StatusEffects.LunaWasCaugh) == 3) outputText("<b>That's it, you're sure of it now, it's all Luna's doing!</b>\n\n");
			doNext(playerMenu);
		}

		public function zenjiVillageProblems():void{
			clearOutput();
			outputText("You ask Zenji if he’s ready to talk about his problems with you.\n" +
					"\n" +
					"Zenji’s gaze shies away from you as he turns to stone. \"I…\" He mutters after a brief pause.\n" +
					"\n" +
					"You stop him before he can argue. He’s not going to push you away as he’s done everyone else. You tell him that he is your lover as much as you are his. Nobody should hold all of the problems to themself, it’s okay to show emotions, it’s okay to be vulnerable. Having the ability to communicate how you’re feeling isn’t a sign of weakness, it’s a sign of emotional maturity and mental strength.\n" +
					"\n" +
					"Zenji gives you a weak smile as he turns to face you again. \"You’re right…\" he replies, flexing his massive arms and gesturing to his musculature. \"Guess dese muscles won’t help me fight de problems in my head, will dey?\"\n" +
					"\n" +
					"You give him a gentle laugh and Zenji gives a slightly disheartened laugh as well.\n" +
					"\n" +
					"There’s a brief pause before he finally speaks up again, \"Thank you [name]... For everyting… I needed ta hear dis… It’s just… I guess I’ve always felt like I had to take care of all de problems wit myself alone while also helping you… It’s like… Dat’s what’s expected of me as a man. I gotta keep everyone safe while also being strong and stoic. I am also scared dat if I share my feelings I would be branded as a wuss or inferior.\"\n" +
					"\n" +
					"You tell Zenji that everyone gets hurt, it’s impossible to keep someone safe forever. As a man, he shouldn’t be the one to take the burden for everything and remain silent about it. Hurting will only feel worse when you do it alone. It’s okay to be hurt, it will happen to everyone. At least then one will be able to know the good times and have something to look forward to. Being a man doesn’t mean he has to be stoic, being a man means being strong with others, and nobody should ridicule him for expressing himself.\n" +
					"\n" +
					"\"It’s not just dat, [name]... I need to be a strong man… for you. I wanna protect ya, I need ta be able to be dere for you.\"\n" +
					"\n" +
					"You tell him that he can, but he shouldn’t let that cloud his judgment or isolate himself from you, himself, or others. He will always be your man, no matter what. You assure him that expressing how he feels and talking to you about his problems will never make him less of a man. He doesn’t need to push others away to keep himself safe.\n" +
					"\n" +
					"Zenji gives you a soft smile, \"You’re right. You’re everyting I have ta look forward to, [name]. I love you so much. I may be a man, and at least I know now dat I am your man. I will try ta be a little more open, I promise I will. I shouldn’t hide from myself, nor should I hide myself from you. And I guess I can be a little less harsh to some of the other people around...\"\n" +
					"\n" +
					"He pulls you into his strong arms, clutching you closely against his chiseled body as his tail wraps around you. \"You have so much ta teach me, and I have so much ta learn about myself… Thank you…\" He whispers.\n");
			TrollVillage.ZenjiVillageStage = 4;
			doNext(playerMenu);
		}

		public function zenjiVillageProblems2():void{
			clearOutput();
			outputText("You ask Zenji if he's feeling better after venting to you.\n" +
					"\n" +
					"The burly troll sighs softly, \"Yes, [name]... I feel a bit better, thanks.\"\n" +
					"\n" +
					"He gives you a sincere grin, the sight warms you to your core. You feel like you can breathe a little easier as well knowing he's taken a weight off his chest.");
			doNext(playerMenu);
		}

		//ZENJI MARRIAGE
		public function ZenjiMarriagePreCheck():Boolean{
			return player.hasKeyItem("Jabala's Charm") > 0 && TrollVillage.ZenjiVillageStage > 0 && ZenjiSleepCount >= 5 && ZenjiTalkCount >= 15 && ZenjiLoverDays >= 20;
		}

		public function ZenjiProposalScene():void{
			if (!sceneHunter.canMarry()){
				outputText("You call Zenji to you, to which he immediately approaches you with a stride in his step. His deep voice rings to you as he stands in front of you, \"<i>You called?</i>\"\n" +
						"\n" +
						"You grab Zenji by his wrists. Zenji holds onto you gently, eyeing you carefully, unsure of where you’re going with this, \"<i>Mi costilla... someting wrong?</i>\"\n" +
						"\n" +
						"You reach for Zenji's soft hand, admiring the fuzzy feeling of it within your grasp as you lower yourself to one knee. You tell Zenji that he means a lot to you, and with all the crazy havoc, sinister beings, and harm that could be brought at any moment. You know deep down that you want to spend the rest of your life with him.  With everything you’ve been through together, there is nobody more deserving of being your husband than he is.\n" +
						"\n" +
						"You say this as you pull out the charm Jabala has given to you.\n" +
						"\n" +
						"Zenji looks at you unsurely before pushing your hand down with his.\n" +
						"\n" +
						"\"<i>[name]... I’m honored, but you’re already married… I can’t do dis to you. My heart aches for you... I want to love you… But… I cannot… Your heart already belongs to another, it is not mine to take… I’m sorry [name], but I cannot do this to you or them.</i>\"\n" +
						"\n" +
						"His rejection stings, but his words carry meaning.\n" +
						"\n" +
						"Zenji rests a hand on your shoulder, \"<i>Never disgrace love, [name],</i>\" he states before leaving you alone for the time being.");
				advanceMinutes(15);
				doNext(loverZenjiTalks);
			}
			else{
				player.destroyItems(jewelries.ENDGRNG, 1);
				outputText("You call Zenji to you, to which he immediately approaches you with a stride in his step. His deep voice rings to you as he stands in front of you, \"You called?\"\n" + "\n");
				if (player.mf("m", "f") == "f"){
					outputText("You grab Zenji by his wrists. Zenji holds onto you gently, eyeing you carefully, unsure of where you’re going with this, \"<i>Mi costilla... someting wrong?</i>\"\n" +
							"\n" +
							"You reach for Zenji's soft hand, admiring the fuzzy feeling of it within your grasp as you lower yourself to one knee. You tell Zenji that he means a lot to you, and with all the crazy havoc, sinister beings, and harm that could be brought at any moment. You know deep down that you want to spend the rest of your life with him. You pull out the wedding ring.\n" +
							"\n" +
							"Zenji is blushing in awe as you slide it onto his finger, it’s a perfect fit.\n" +
							"\n" +
							"With everything you’ve been through together, there is nobody more deserving of being your husband than he is. You say this as you pull out the charm Jabala has given to you.\n" +
							"\n" +
							"Zenji turns completely red, you’ve never seen anyone blush so hard before. \"<i>I… [name]... I was going ta ask ya soon... when de moment was perfect… but…</i>\" He’s at a loss for words, completely embarrassed.\n" +
							"\n" +
							"You stand up before gently grabbing onto his necklace, tying the charm onto it as a memento. You then reach your hand up and grasp onto his beard, pulling his face closer to yours as you lock your lips with his. His body is frozen, but his tail wraps around you, pulling you closer to him.\n" +
							"\n" +
							"Zenji’s humiliation turns to shock before he relaxes, wrapping his strong arms around you, returning the embrace. Tears of joy well up in his eyes, \"Oh, [name]. You have made me de happiest troll on Mareth, you’ve done so much for me…\"\n" +
							"\n" +
							"You feel the ground slip beneath you as you’re swept clean off your [feet]. \"<i>Well, if we’re going to get married, we best tell ma parents about de news. After all, with all you’ve done for me, I’m sure dey’ll be delighted to hear de news.</i>\"\n");
				}
				else{
					outputText("You grab Zenji by his wrists. Zenji holds onto you gently, eyeing you carefully, unsure of where you’re going with this, \"Mi corazón... someting wrong?</i>\"\n" +
							"\n" +
							"You reach for Zenji's soft hand, admiring the fuzzy feeling of it within your grasp as you lower yourself to one knee. You tell Zenji that he means a lot to you, and with all the crazy havoc, sinister beings, and harm that could be brought at any moment. You know deep down that you want to spend the rest of your life with him. You pull out the wedding ring.\n" +
							"\n" +
							"Zenji is blushing in awe as you slide it onto his finger, it’s a perfect fit.\n" +
							"\n" +
							"With everything you’ve been through together, there is nobody more deserving of being your husband than he is. You say this as you pull out the charm Jabala has given to you.\n" +
							"\n" +
							"Zenji recoils slightly before blushing softly, \"<i>[name]... I… I…</i>\" He’s at a loss for words. Zenji pauses for a moment, taking in a deep sigh, \"<i>Of course I will marry you, [name]. I just… I wanted ta be the one t’ propose… I was going to soon, I just was waiting for de perfect chance…</i>\"\n" +
							"\n" +
							"You stand up before gently grabbing onto his necklace, tying the charm onto it as a memento. You then reach your hand up and hold onto his beard, pulling his face close to yours as you lock your lips with his. His tail wraps around you, pulling you closer to him.\n" +
							"\n" +
							"Zenji returns the embrace, wrapping his strong arms around you. Tears of joy well up in his eyes, \"<i>Oh, [name]. You have made me de happiest troll on Mareth, you’ve done so much for me…</i>\"\n" +
							"\n" +
							"You feel the ground slip beneath you as you’re swept clean off your feet, \"<i>Well, if we’re going to get married, we best tell ma parents about de news. After all, with all you’ve done for me, I’m sure dey’ll be delighted to hear de news.</i>\"\n");
				}
				doNext(ZenjiMarriageSceneUno);
			}
		}

		private function ZenjiMarriageSceneUno():void{
			clearOutput();
			outputText("Zenji guides you back to the troll village, holding your hand tightly in a mix of love and anticipation. He guides you to his parent’s home, knocking on the door when he finally reaches the hut.\n" +
					"\n" +
					"Halkano slides the door open, \"<i>Zenji! Back so soon?</i>\" he asks jovially.\n" +
					"\n" +
					"Zenji is practically beaming as he pulls you closer, \"Get motha out here, I have some important news ta share.</i>\"\n" +
					"\n" +
					"Halkano smiles, \"<i>Sure ting, she’s out in de garden right now. Take a seat on de couch, I’ll be back soon.</i>\"\n" +
					"\n" +
					"Zenji guides you to the couch, the two of you sit patiently while Halkano goes to the back of the hut.\n" +
					"\n" +
					"Zenji pulls you in for a brief kiss during the idle time, \"<i>I can’t wait to see deir faces when I share de news. Let’s both say it at de same time, alright?</i>\" he asks after breaking the kiss.\n" +
					"\n" +
					"You give him a gentle smile in return as you nod your head, you’re sure they’ll be excited.\n" +
					"\n" +
					"You hear some idle chatter outside for a moment, but you’re unsure of what exactly they are talking about.\n" +
					"\n" +
					"Zenji turns to you, he pulls your face towards him, \"<i>I know I have not said it enough times, but… Dere’s someting I really like about your eyes… [eyecolor] is a really good look on ya, [name]. I could just spend all day staring into dem.</i>\"\n" +
					"\n" +
					"You look back into his deep-set, ashen green eyes. His gaze is strong, giving off a sense of comfort and safety. Zenji gently caresses your face for a moment before you hear the door open and close followed by footsteps.\n" +
					"\n" +
					"Halkano returns with Jabala, she is currently wearing a straw hat over her long, lime hair. Halkano sits on his seat as Jabala rests on his lap. Halkano wraps his arms and tail around her.\n" +
					"\n" +
					"\"<i>Halkano tells me there’s something you wanted to tell us?</i>\" Jabala inquires.\n" +
					"\n" +
					"Zenji gestures toward you as both of you exclaim, \"<i>We’re getting married!</i>\"\n" +
					"\n" +
					"Jabala tries to leap up for joy, but she is firmly held in place by Halkano, his jaw agape in awe.\n" +
					"\n" +
					"Jabala slips out before rushing toward the two of you, pulling you in for a group hug.\n" +
					"\n" +
					"\"<i>My little Zinny is all grown up and getting married!</i>\" she exclaims, tears streaming from her face. Despite her tears of joy, she musters up a knowing nod toward you.\n" +
					"\n" +
					"Zenji chuckles softly as Halkano stands up, wiping a tear from his face, \"I was worried dis day would never come, but ma boy is all grown up and here ta tell us!\"\n" +
					"\n" +
					"Jabala gives Halkano a wink, \"<i>I think you know what needs to be done now.</i>\"\n" +
					"\n" +
					"Halkano chuckles briefly, \"<i>I thought de day would neva come.</i>\" Halkano walks toward Zenji, \"<i>We need ta choose what ta wear for ya wedding! Come wit me, Zenji dere’s no going back now, I know dis is what ya wanted because ya came here.</i>\"\n" +
					"\n" +
					"Zenji doesn’t resist, \"<i>Ya know me too well, I do want ta get married here.</i>\"\n" +
					"\n" +
					"Halkano and Zenji exit the hut.\n" +
					"\n" +
					"Jabala grins before taking your hand, \"<i>Let’s go, [name]. We can figure out what you want to wear. Tell me, do you want a suit or a dress?</i>\" she asks, eyeing your form.\n");
			menu();
			addButton(0,"Wedding Dress", ZenjiMarriageSceneDos,1);
			addButton(1,"Wedding Suit", ZenjiMarriageSceneDos, 2);
		}

		private function ZenjiMarriageSceneDos(dressType:int):void{
			clearOutput();
			TrollVillage.ZenjiMarriageDress = dressType;
			if (dressType == 1){
				outputText("You tell Jabala that you’re interested in wearing a wedding dress.\n" +
						"\n" +
						"Jabala is smiling from ear to ear in barely contained excitement. She guides you out of the house as the two of you walk through the community towards a hut that’s decorated in flowers and petals.\n" +
						"\n" +
						"Jabala quickly pushes the door to the side without any regard for it. \"My son is getting married, and [name] is going to be the beautiful bride!\"\n" +
						"\n" +
						"The seamstress there cheers in excitement for you, \"<i>That’s wonderful! Come, come! I need to get your dress prepared.</i>\"\n" +
						"\n" +
						"You follow the seamstress as Jabala speaks up, \"Don’t worry, I’ll pay for the dress, consider it my wedding gift.</i>\"\n" +
						"\n" +
						"The seamstress speaks up as she guides you to a platform where she takes your measurements. \"</i>Only the finest silk is used for dresses here, after all, it is your day and we want to make sure you are as beautiful on the outside as you are on the inside.</i>\"\n" +
						"\n" +
						"Once she is done measuring your body, she inspects your head and feet. \"<i>Spider silk is durable and soft with a shiny sheen. You will be radiant.</i>\"\n" +
						"\n" +
						"After taking the rest of your measurements Jabala reaches out a hand and you step off the platform and the seamstress steps away for a minute. Jabala speaks up again, \"<i>We work on our clothes very quickly here, so don’t worry,</i>\" she states. \"<i>Apparently there’s also been a lot of talking going on within the town. If you ask me, Zenji has been planning this for some time now… I was so buried within my garden that I hardly noticed that it was my Zinny!</i>\"\n" +
						"\n" +
						"The seamstress returns with some silk, sewing tools, and some bases for the dress.\n");
				if (player.isNaked()){
					outputText("You’re already naked, so she quickly goes to work on making the dress.\n");
				}
				else{
					outputText("She instructs you to undress to your undergarments and you do. Once you’re in your underwear, she begins tailoring the dress around you with precision and nimble fingers.\n");
				}
				outputText("You’re astonished at how quick she is with her work, the comfort of the silk dress accents your pleasant features well. The silky white gown is being made before your own eyes. She weaves around you with practiced ease, quickly spooling more thread, it’s magical how magnificent her tailoring is.\n" +
						"\n" +
						"It doesn’t take long before your dress is finished. Jabala sheds another tear, \"<i>You are beautiful, [name]. You remind me of me on my wedding day…</i>\" Jabala sighs softly, \"<i>My little Zinny is all grown up, getting married… I am glad to know that you will be with him, I hope he enjoyed the little gift I gave to you.</i>\"\n" +
						"\n" +
						"You turn around to look at yourself in the mirror. What a sight, the layers of silken fabric, the strapless dress molds to your form accenting your features incredibly. The seamstress passes you a tiara with a silken veil, white gloves, and flats. Jabala helps put the silken flats on your feet, once you’re fully dressed the seamstress places the tiara over your head as the veil flows over your face.\n" +
						"\n" +
						"\"<i>You are ready,</i>\" the seamstress states. \"<i>Truly a beautiful sight, I’m sure your partner will be excited to see such beauty.</i>\"\n" +
						"\n" +
						"Jabala wipes her tears from her face, \"<i>Follow me, [name] we will get you prepared for the ceremony.</i>\"\n");
			}
			else {
				outputText("You tell Jabala that you’re interested in wearing a wedding tuxedo.\n" +
						"\n" +
						"Jabala is smiling from ear to ear in barely contained excitement. She guides you out of the house as the two of you walk through the community towards a hut that’s decorated in flowers and petals.\n" +
						"\n" +
						"Jabala quickly pushes the door to the side without any regard for it. \"My son is getting married, and [name] is going to be the handsome bride!\"\n" +
						"\n" +
						"The seamstress there cheers in excitement for you, \"<i>That’s wonderful! Come, come! I need to get your suit prepared.</i>\"\n" +
						"\n" +
						"You follow the seamstress as Jabala speaks up, \"<i>Don’t worry, I’ll pay for the suit, consider it my wedding gift.</i>\"\n" +
						"\n" +
						"The seamstress speaks up as she guides you to a platform where she takes your measurements. \"Only the finest silk is used for suits here, after all, it is your day and we want to make sure you are as beautiful on the outside as you are on the inside.\"\n" +
						"\n" +
						"Once she is done measuring your body she inspects your head and feet. \"<i>Spider silk is durable and soft with a shiny sheen. You will be radiant.</i>\"\n" +
						"\n" +
						"After taking the rest of your measurements Jabala reaches out a hand and you step off the platform and the seamstress steps away for a minute. Jabala speaks up again, \"<i>We work on our clothes very quickly here, so don’t worry,</i>\" she states. \"<i>Apparently there’s also been a lot of talking going on within the town. If you ask me, Zenji has been planning this for some time now… I was so buried within my garden that I hardly noticed that it was my Zinny!</i>\"\n" +
						"\n" +
						"The seamstress returns with some silk, sewing tools, and some bases for the tuxedo. \n");
				if (player.isNaked()){
					outputText("You’re already naked, so she quickly goes to work on making the suit.\n");
				}
				else{
					outputText("She instructs you to undress to your undergarments and you do. Once you’re in your underwear she begins tailoring the suit around you with precision and nimble fingers.\n");
				}
				outputText("You’re astonished how quick she is with her work, the comfort of the silk tuxedo accents your pleasant features well. The silky white tuxedo is being made before your own eyes. She weaves around you with practiced ease, quickly spooling more thread, it’s magical how magnificent her tailoring is. Once she’s finished with your shirt, she quickly gets to work on your jacket before getting to business on your pants.\n" +
						"\n" +
						"It doesn’t take long before your tuxedo is finished. Jabala sheds another tear, \"<i>You are beautiful, [name]. You almost remind me of me on my wedding day…</i>\" Jabala sighs softly, \"<i>My little Zinny is all grown up, getting married… I am glad to know that you will be with him.</i>\"\n" +
						"\n" +
						"You turn around to look at yourself in the mirror. What a sight, the layers of silken fabric, the white tuxedo molds to your form accenting your features incredibly. The seamstress passes you a pair of short white gloves and dress shoes. Jabala puts the bowtie around you once you slip into your shoes. Once you’re fully dressed the seamstress eyes you carefully.\n" +
						"\n" +
						"\"<i>You are ready,</i>\" the seamstress states, \"<i>Truly a beautiful sight, I’m sure your partner will be excited to see such beauty.</i>\"\n" +
						"\n" +
						"Jabala wipes her tears from her face, \"<i>Follow me, [name] we will get you prepared for the ceremony.</i>\"\n");
			}
			doNext(ZenjiMarriageSceneTres);
		}

		private function ZenjiMarriageSceneTres():void{
			clearOutput();
			outputText("Jabala guides you towards a tall chapel. It’s decorated in ivory paint and depictions of Marae.\n" +
					"\n" +
					"Jabala takes a deep sigh, \"<i>I remember when I got married… It all happened so quickly and before I knew it Zenji was with us… I wouldn’t trade that day for the world… I hope today will be just as magical for you, [name], if not more.</i>\"\n" +
					"\n" +
					"You can already hear conversations within as Jabala guides you to the front door. \"<i>I know you may not feel prepared [name], but trust me, follow your heart because this here, right now, is your moment. There is magic in the suddenness of a moment.</i>\"\n" +
					"\n" +
					"Jabala opens the door as some music starts playing. Rows of seats are filled with trolls and you see everyone from your camp within the audience. Zenji seems to have been preparing this for some time now.\n" +
					"\n" +
					"Jabala walks you towards the altar as you hear the cheers and claps of your friends that you’ve made along the way.\n");
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1 && flags[kFLAGS.MARAE_QUEST_COMPLETE] >= 1){	//Pure Marae
				outputText("You even see Marae, you’re surprised to meet her here. The goddess stands out, shining radiantly, her body appearing within the wooden walls of the church to greet you.\n" +
						"\n" +
						"\"<i>I have heard that my champion was going to be wed on this day,</i>\" she states. \"<i>After all you've done, It would be a shame if I didn’t formally give you my blessing.</i>\"\n" +
						"\n" +
						"You thank her, glad to know that even Marae will make time for her people.\n");
			}
			outputText("You finally get a good view of Zenji waiting for you at the altar, his face is beaming. He is wearing a black silk tuxedo jacket with a white silken shirt underneath. He has a black bowtie and white gloves. His black pants places the perfect amount of emphasis on his firm rear and toned legs. There is a hole in his pants to make room for his tail. You can see his black dress shoes underneath. He is the most handsome troll you have ever seen before and now you’re about to be with him forever.\n" +
					"\n" +
					"You stand before the celebrant as Zenji picks up your hands. His grip is soft but firm. You look up at him as he mouths, \"You are beautiful, [name]\".\n" +
					"\n" +
					"The entire room fades out as you link eyes with Zenji. The world deafens and the only thing you can think about is him with you at this very moment.\n" +
					"\n" +
					"You can barely hear the celebrant speak, everything else feels so distant as you stand with Zenji. It’s as if the entire world consists of only you and him now.\n" +
					"\n" +
					"Zenji speaks up, his voice like hope in the moonlight, \"<i>When I first met you, [name]. I thought you were just another person in the bog, perhaps an outcast, or someone trying to fend off corruption. But you taught me humility and how ta accept my feelings instead of hiding from dem. I know now dat I can’t run from my problems, you’ve taught me so much more about myself than I ever even knew. You revealed to me what it means to be vulnerable, being vulnerable isn’t a weakness, it’s a sign of emotional capacity. I know you are strong, [name], you’ve shown me dat strength is far more than just physical power or mental knowledge. I wish to be yours, [name]. That’s why I’m here now, dat’s why Marae brought us together, to love each other. Tell me you wish the same. Tell me you love me with every fiber of your very being in the same way I do to you.</i>\"\n" +
					"\n" +
					"The celebrant passes two golden rings to Zenji, Zenji slides one onto his finger as he holds the other to you.\n" +
					"\n" +
					"You feel your heart pounding inside of you, is this truly what you want?\n");
			menu();
			addButton(0, "Yes", ZenjiMarriageSceneCuatro, 1);
			addButton(1,"No", ZenjiMarriageSceneCuatro, 2);
		}

		private function ZenjiMarriageSceneCuatro(choice:int):void{
			var spchk:Boolean = false;
			if (choice == 2){
				if (player.isPregnant()){
					if (silly()){
						outputText("It's all coming to plan, oooh, the tax benefits will be so good! You tell him you want a divorce, you're keeping the children, and he's paying for your child support.\n" +
								"\n" +
								"Zenji gasps, \"<i>[name]..! You... I... What?</i>\"\n" +
								"\n" +
								"You nod your head, reaching a hand toward him, commanding him to pay up.\n" +
								"\n" +
								"Zenji begrudgingly passes you some gems.\n" +
								"\n" +
								"You slap them from his hand, stating that you're strong and independent. You're a person who needs no man in your life, and you definitely don’t need no charity from this jerk!\n" +
								"\n" +
								"The crowd cheers for you as you take your leave.\n" +
								"\n" +
								"\"HE DON’T LISTEN TO YOU!\"\n" +
								"\n" +
								"\"You go, girl!\"\n" +
								"\n" +
								"\"That’s a real champion!\"\n" +
								"\n" +
								"\"YASSS QUEEN! SLAY!\n" +
								"\n" +
								"\"You don’t need no man! YOU DON’T NEED NO MAN!\"\n" +
								"\n" +
								" With your head held high, you leave the venue, leaving your deadbeat husband behind.\n");
						spchk = true;
					}
					else{
						outputText("With your mind set, everything has built up to this moment of heartbreak for him. The hopes of being a father will be all the more enjoyable when you take that reality from him. You tell him that an insipid, clingy, immature idiot like him could never be a good father. You take pride in the fact that you know he'll never see the child the two of you will make. All the more to let him know that fatherhood is something he should never know the satisfaction of having.\n" +
								"\n" +
								"You take your leave without another word.\n");
					}
				}
				else if (player.isRace(Races.DEMON, 1, false)||player.isRace(Races.IMP, 1, false)){
					outputText("With your mind set, you speak up. \"I do,\" you reply.\n" +
							"\n" +
							"Tears begin to stream down his face as you smile at him. You look toward Zenji with faux reassurance as you hold out your hand for him.\n" +
							"\n" +
							"Zenji leans in for a kiss, but before his lips connect you violently shove him away with a taunting grin. Zenji stumbles back, falling to the ground.\n" +
							"\n" +
							"The audience gasps in horror.\n" +
							"\n" +
							"You slip the ring off your finger, throwing it at his face before asking him if he really thought you’d stoop down to the level of some insipid idiot that has no right to be as clingy as he is. He only clutches onto you for emotional support like a cowardly parasite.\n" +
							"\n" +
							"Zenji is mortified as he lies on the ground, defensively raising an arm to protect himself from you.\n");
					if (silly()){
						outputText("With a flip of your [hair] you snap your fingers in a Z formation. You spin around, the clicking of your heels trail beneath you.\n");
					}
				}
				else if (player.cor < 50){
					outputText("Everything feels dulled as you glance around, looking at all the faces in the audience, all the people excited for your marriage. Perhaps you had it planned all along, perhaps you now truly know that it was not meant to be, either way, you reject Zenji.\n");
				}
				else{
					outputText("With your mind set, you smirk, he really is a clingy, foolish troll. He valued you so highly, it’s only that much more satisfying to break him. You give him the cold shoulder, completely disregarding him as you face away from him.\n");
				}
				if (!spchk){
					outputText("He is more than shocked at your resistance, but before you can give him any more time to react, you walk away from the altar. You hear Zenji call out for you, \"<i>[name]! Wait, c-come back! [name]! PLEASE D-DON’T GO!</i>\" \n" +
							"\n" +
							"You leave as the audience stares at you in shock.\n" +
							"\n" +
							"You bump into Yenza along the way, you don’t even care what she has to say. You push her back as she falls to the ground. she’s not important anyhow, none of this was ever important to you. Zenji will be completely heartbroken. After all, you built him up so high that having everything crumble before him will only hurt more.\n" +
							"\n" +
							"You finally reach your camp after the journey through the jungle. He is gone, Zenji will never bother you again and you don’t have to think about him either. He was too clingy for it to ever be justified.\n");
				}
				outputText("<b>Troll Village and Zenji have been removed from the game.</b>\n");
				TrollVillage.ZenjiVillageStage = -1;
				flags[kFLAGS.ZENJI_PROGRESS] = -1;
			}else{
				outputText("\"I do.\"\n" +
						"\n" +
						"Tears begin to stream down his face as you smile at him. You look toward Zenji reassuringly as you hold out your hand for him. Whispering to him that it’s okay.\n" +
						"\n" +
						"The audience coos as Zenji sheds tears of joy.\n" +
						"\n" +
						"\"<i>I’m just… so happy…</i>\" he squeaks through his tears. \"<i>You’ve taught me so much about myself… there’s nobody better I could’ve asked for, I just can’t believe dis is happening…</i>\"\n" +
						"\n" +
						"He musters up the strength to put the ring over your finger.\n" +
						"\n" +
						"The celebrant speaks up, \"<i>With the power invested in me, by the elders and Marae, I hereby pronounce you soul mates.</i>\"\n" +
						"\n" +
						"Suddenly the door to the room slams open, Yenza is standing at the doorway, tears streaming down her face, completely infuriated.\n" +
						"\n" +
						"\"<i>YOU FUCKING BITCH! ZENJI IS SUPPOSED TO BE MINE! WHO DO YOU THINK YOU ARE? TAKING MY HUSBAND AWAY FROM ME?</i>\"\n" +
						"\n" +
						"There is a long awkward silence, the air is so thick you may choke on it.\n" +
						"\n" +
						"Jabala speaks up, \"<i>Zenji is with [name] now! Go home Yenza! You’re not needed nor wanted here!</i>\"\n" +
						"\n" +
						"The rest of the trolls boo at her, causing Yenza to back away slightly.\n" +
						"\n" +
						"Tears continue to cascade down her face, \"<i>FUCK YOU, ALL OF YOU ARE CUNTS! THIS WAS SUPPOSED TO BE MY DAY, ZENJI IS SUPPOSED TO BE MINE, THIS WAS ALL MINE AND YOU TOOK IT AWAY FROM ME!</i>\"\n" +
						"\n" +
						"With an enraged scream, she charges down the aisle. Several trolls quickly attempt to pin her down, she kicks and screams violently, clawing away at her aggressors, knocking them aside as she finally reaches you.\n" +
						"\n" +
						"You’re not going to let your perfect day be ruined by the same skank that raped your husband. SHE’S. GOING. DOWN.\n" +
						"\n" +
						"You approach her in the aisle, ready to teach her a lesson.\n");
				//startCombat(new YenzaEnemy());
				outputText("WARNING: COMBAT NOT READY. YOU GET A FREE PASS FOR THIS UNTIL ENEMY IS SET UP.");
				doNext(ZenjiMarriageSceneCinco);
			}
		}

		public function ZenjiMarriageSceneCinco():void{
			clearOutput();
			if (!recalling) {
				flags[kFLAGS.ZENJI_PROGRESS] = 12; //for SH tracking
				sceneHunter.marry("Zenji");
				outputText("<b>New scene is unlocked in 'Recall' menu!</b>\n\n");
			}
			outputText("Once Yenza is defeated the trolls quickly escort her out.\n"+
			"Zenji looks mortified, but you stand back on the altar before gently caressing his face. His expression eases and his body relaxes. You tell him that she will no longer bother him, this time you know as a fact. It's just you and him now, nothing could ever undo the love you two share.\n" +
					"\n" +
					"\"<i>Thank you, [name]. I love you...</i>\" He whispers before gazing longingly into your eyes.\n");
			if (TrollVillage.ZenjiMarriageDress == 1){
				outputText("Zenji lifts your veil over your tiara. ");
			}
			outputText("The entire world seems like it freezes as Zenji leans in closer to you. This is it. The culmination of your relationship with him. Everything you've done ever since you met him has been leading up to this moment. Zenji wraps his strong, manly arms around you as you place your hands on his hips. You close your eyes as you lean into him. Your lips finally connect, the comforting warmth he is exuding onto you, you can feel his passion. This is the moment he’s waited for ever since he started opening up to you.\n" +
					"\n" +
					"You can feel his fuzzy beard gently scratch against you, his lips are soft and gentle as they press onto you. His hold on you tightens softly as you fall deeper into his passionate embrace. For a second, you feel almost as if everything will be perfect from now on. You hope that this moment never has to end.\n" +
					"\n" +
					"The world truly has stopped for the two of you as you hear the cheers of the audience. Zenji breaks the soft kiss between the two of you as you open your eyes. You see his face, glowing, grinning from ear to ear. You can’t help but laugh softly with him, his elation is contagious.\n" +
					"\n" +
					"\"<i>We are no longer alone together, we are ours forever.</i>\"\n" +
					"\n" +
					"The two of you turn to the audience as you walk down the altar. Your arms intertwined as you walk through the rows of people.\n" +
					"\n" +
					"Zenji speaks up, \"<i>The wedding isn’t over just yet, we still have de party to attend!</i>\"\n" +
					"\n" +
					"Zenji opens the door for you as you walk outside. The delicious smell of food permeates the air as you walk outside. The moment you step outdoors you hear an orchestra begin playing. Strings and woodwinds fill the air in a melodic symphony.\n" +
					"\n" +
					"Zenji grabs your hand, \"<i>Follow me, I will cut de wedding cake for us.</i>\"\n" +
					"\n" +
					"It doesn’t take long before the rest of the guests arrive outside, chattering amongst each other.\n" +
					"\n" +
					"Your eyes are drawn to the food buffet, there’s several roasts, salads, a large assortment of fruits, vegetables, and sauces. Your eyes zone in on the wedding cake, 3 layers each about half a foot tall coated in silvery marzipan and decorated with white frosting.\n" +
					"\n" +
					"Zenji speaks up, \"<i>Dis will be a day ta remember, de day, I, Zenji, got married ta my ");
			if (flags[kFLAGS.MALE_OR_FEMALE] == 0 && player.gender == 2 || flags[kFLAGS.MALE_OR_FEMALE] == 2){
				outputText("beautiful ");
			}
			else if (flags[kFLAGS.MALE_OR_FEMALE] == 0 && player.gender == 1 || flags[kFLAGS.MALE_OR_FEMALE] == 1){
				outputText("handsome ");
			}
			else{
				switch (rand(2)){
					case 0:
						outputText("beautiful ");
						break;
					default:
						outputText("handsome ");
				}
			}
			switch (player.gender){
				case 1:
					outputText("husband");
					break;
				case 2:
					outputText("wife");
					break;
				default:
					outputText("spouse");
					break;
			}
			outputText(", [name]!</i>\" Zenji cuts a slice of the wedding cake before passing it to you with a spoon. The crowd cheers once more. \n\nZenji gives you a disarming smile. \"<i>I am so glad we can share dis day, [name].</i>\"\n" +
					"\n" +
					"You give him a gentle smile in return. You take a spoonful of frosting from your cake before bopping him on the nose with it. You hear a few people in the audience chuckle as Zenji wipes it off with his fingers before licking them. \"¡Cómo te atreves, gordita! You’re gonna pay fa dis later.\" He says teasingly.\n" +
					"\n" +
					"You spend the rest of the night dancing with Zenji, eating delicious food, and socializing with your friends and the new family you’ve made with your troll husband.\n" +
					"\n" +
					"Later that night, Jabala approaches you, she is wearing a silken dress, \n");
			if(flags[kFLAGS.ZENJI_KIDS] != 0){
				outputText("and is currently cradling your kids. ");
			}
			outputText("\"<i>Oh, [name]. You’ve made me the happiest mother on Mareth! This was just like my own wedding with Halkano. Why don’t you spend the night with us before you go home?</i>\"\n" +
					"\n" +
					"Halkano approaches, in a grey tuxedo, \"<i>Haha, Jabala, if dey’re gonna spend de night, we betta give dem some… privacy.</i>\"\n" +
					"\n" +
					"Jabala turns toward him, \"<i>Alright, I just want to be with my son one more time before he becomes a man. You’re just growing up so fast…</i>\"\n" +
					"\n" +
					"Halkano gently pulls her close to him, \"<i>It was going to happen one day, I’m just glad he was here wit us.</i>\"\n" +
					"\n" +
					"Zenji looks up toward the night sky, \"<i>It is getting late, we’d best spend da night wit ya.</i>\"\n" +
					"\n" +
					"The ceremony slowly simmers down and Zenji leads you to his parent’s home.\n" +
					"\n" +
					"Zenji guides you to his room, the bed is big enough to support the two of you. Zenji slowly takes off his tuxedo jacket and undoes his bowtie as it hangs loosely around his neck. \"<i>I really liked de suit, but it’s not really my thing, ya know, [name]?</i>\"\n" +
					"\n" +
					"Well, he surely is extremely handsome in a tuxedo.\n" +
					"\n" +
					"\"<i>Dat’s why getting out if it is dat much betta…</i>\" he replies. Zenji begins to unbutton his shirt. You can see his large, firm biceps pressed tightly against the fabric. \"<i>Dis shirt is so tight… I could just…</i>\" Zenji hunches forward slightly as he flexes his massive arms. You hear the seams of the shirt start to come apart as the distinguishable sound of ripping fabric hits your ears. \"<i>Ngh, I’ve been waiting to do dat all night.</i>\"\n" +
					"\n" +
					"Now that’s impressive, considering that the entirety of his tuxedo is made out of spider silk. You’re a little surprised he hasn’t torn it sooner considering just how tightly it molds against his muscular form, wound up against his thick biceps and triceps\n" +
					"\n" +
					"\"<i>Oh, it was a struggle not ta break out of it sooner, lemme tell ya,</i>\" Zenji replies. \"<i>It’s so satisfying ta just…</i>\" Zenji raises his arms and flexes his arms as hard as he can. You can hear the fabric strain as his biceps burst through his sleeves. \"<i>Spider silk holds no grounds against my might! These arms were not meant ta be contained!</i>\"\n" +
					"\n" +
					"Zenji grabs his completely shredded sleeve as he tears his shirt off of him. Scraps of fabric litter the floor as Zenji undoes his belt buckle, letting his pants fall to the ground. His loincloth is pushed out of the way as his erection pokes through. He quickly tears it off as well.\n");
			if (TrollVillage.ZenjiMarriageDress == 1) {
				outputText("You decide to give him a small tease in return for the tremendous display. You wriggle out of your undergarments, tossing them aside once you’ve taken them off.\n");
				if(player.lowerBodyPart.legCount >= 2){
					outputText("Once they’re out of the picture, you loosen your gown before slowly sliding the strapless gown down your torso as it falls to the floor.\n");
				}
				else{
					outputText("You loosen your gown, untying the threads that keep it clasped around your body. The beautiful fabric unravels as it falls to the ground before you like an undone ribbon.");
				}
				if (player.hasBreasts()){
					outputText("You turn around and ask Zenji if he could take off your bra for you. Zenji approaches, gently cupping your breasts as he removes your bra with soft, nimble fingers.");
				}
			}
			else{
				outputText("You decide to give him a small tease in return for the tremendous display. You slide out of your jacket before slowly unbuttoning each clasp.");
				if (player.lowerBodyPart.legCount >= 2){
					outputText("You make way with leaving your chest exposed as you undo your belt buckle, slowly sliding it out of its socket as your pants fall to the floor.");
				}
				else{
					outputText("You give him a moment to admire the view of your exposed chest through the unbuttoned shirt.");
				}
				outputText("You playfully strip off your shirt")
				if (player.hasBreasts() && player.upperGarmentName.indexOf("bra") >= 0){
					outputText(" and bra");
				}
				outputText(", leaving you completely naked.");
			}
			outputText("Zenji pulls you close to him, wrapping you within a warm hug before groping your behind, \"<i>Now dat de clothes are out of de way, why don’tcha get on de bed and I’ll show you how to end da night properly…</i>\" Zenji says with a cheeky smirk.\n" +
					"\n" +
					"You consider what you want to do before you get onto his bed.\n");
			menu();
			addButton(0,"Catch Anal", ZenjiMarriageSexTime, 1, -9000,-9000, "Zenji will give your ass the ride of its life.");
			if (player.hasVagina()){
				addButton(1,"Get Penetrated", ZenjiMarriageSexTime, 2, -9000, -9000, "Have your husband stuff you the way a troll should breed his wife\n");
			}
			else{
				addButtonDisabled(1, "Get Penetrated", "You don't have a vagina to take him!");
			}
			if (player.cockThatFits(45) > 0){
				addButton(2, "Pitch Anal", ZenjiMarriageSexTime, 3, -9000, -9000, "Tooltip: Mount your husband on yourself the way he was meant to be");
			}
			else if (player.hasCock()){
				addButtonDisabled(2, "Pitch Anal", "Your dick(s) is too big to fit in your husband!");
			}
			else{
				addButtonDisabled(2, "Pitch Anal", "You need a dick for this!");
			}
		}

		private function ZenjiMarriageSexTime(options:int):void{
			clearOutput();
			if (options == 1){
				outputText("You give Zenji a knowing smile, giving him a gentle kiss on the cheek before climbing onto his bed, you position yourself so that you're facing away, you shake your rear teasingly, waiting for his entrance. You tell Zenji that you want him to take you from behind.\n");
				if (player.ass.analLooseness == AssClass.LOOSENESS_VIRGIN){
					outputText("You have been waiting for someone you truly loved before giving it all away.");
				}
				outputText("Zenji gives a contented smile, \"<i>I’ve been waiting all night for ya [name]. I love you, and now I’m gonna show you just how much I mean by dat.</i>\" He licks his hand seductively before lathering his length in his spit, then aligning his manhood with your rear. His strong hand gropes at your cheeks, getting you prepared for his entrance.\n");
				if (player.analCapacity() < 7){
					if (player.ass.analLooseness == AssClass.LOOSENESS_VIRGIN){
						outputText("\"You have waited your entire life for dis, [name]... Dat takes some real dedication. Now I will show you how a real troll makes love.\"\n");
					}
					outputText("His lengthy shaft presses its way deep inside of your tight anus, you feel yourself stretch over his considerable manhood. \n");
				}
				else if (player.analCapacity() < 55){
					outputText("His lengthy shaft presses into you, you can feel him accommodating your [ass] as he presses further and further with each thrust\n");
				}
				else{
					outputText("His lengthy shaft presses into you, you can feel him press into your roomy backside as he pushes deeper into you with each thrust.\n");
				}
				outputText("Zenji moans softly as he slowly thrusts into you. His swollen balls slap against you, desperate to fill you with every ounce of cum he has to offer. He notices your strain beneath him and he places his palm across your face, rubbing his thumb across your cheek affectionately.\n" +
						"\n" +
						"\"<i>Time for my mate ta see what it’s truly like ta have a husband.</i>\"\n" +
						"\n" +
						"You moan softly, ready for what he has to offer.\n" +
						"\n" +
						"Zenji slowly begins picking up the pace, moaning softly as he buries himself deeper into your sphincter. Zenji rails you like a troll in heat should, it doesn't take long before a familiar pressure builds up within your loins. His tail wraps around you, almost as if he were claiming you as his. You clench yourself around his meaty girth, his shaft throbs within your backdoor, desperate to give you the proper treatment you deserve. You moan softly and beg him not to stop. As if he was going to. Zenji redoubles his efforts, thrusting into you with greater force, his impacts rock you to your very core as he buries himself deeper with each thrust. \n");
				if (player.hasCock()){
					outputText("You groan as you shoot your load all over the bed below you.");
				}
				else if (player.hasVagina()){
					outputText("You tilt your head back and moan as you cum, girlcum trickling down your [legs].");
				}
				outputText("You try to milk his dick with your asshole, but he's still going strong.\n" +
				"Zenji reaches over, ");
				if (player.hasCock()){
					outputText(" gently grasping your throbbing shaft as he strokes it for you");
				}
				else if (player.hasVagina()){
					outputText(" gently teasing your clit as he slowly fingers you");
				}
				outputText(". \"<i>I’m not done with ya yet, [name]</i>\"\n");
				outputText("Zenji bucks into your ass with slower and firm strokes as he toys around with you. You squirm beneath his softy hairy touch, desperate for more, desperate for his silky grace. He doesn't lose the gentle pace of simultaneously plowing you and giving you a gentle handjob. It doesn't take long before you can't take it anymore, the sensation is too much for you and you find yourself cumming into his hands. Waves of euphoria jolt through you, but Zenji still hasn’t stopped. The overwhelming scent of his masculinity assaunts your nose as the only thing you can think about is being railed by your newlywed husband\n" +
						"\n" +
						"Zenji picks up the pace as he starts panting, \"<i>Not... Finished... Yet..!</i>\" he growls, picking up the pace further. His girthy erection pulsates within your loins, desperate to fill you with every ounce of love he has to offer. You can feel him thrusting with greater passion before finally howling as he cums inside you. You feel the warmth of his seed race inside you as he begins to relax, careful not to put all of his weight on you. Zenji leans close, nuzzling his head against yours as he slumps down onto the bed, dragging you with him. You're forced into his fuzzy embrace as he holds you tightly. \n" +
						"\n" +
						"You notice his tail reaching up to caress the underside of your chin, \"<i>If marriage will always be like dis, den I could neva wish for a betta soulmate</i>\"\n" +
						"\n" +
						"Zenji gently caresses your face as he curls up with you, bringing his tail around your body.\n" +
						"\n" +
						"\"<i>Sleep tight, [name].</i>\"\n" +
						"\n" +
						"You plan on sleeping for the rest of the night, wrapped within the warmth of your husband’s embrace.\n");
			}
			else if (options == 2){
				outputText("You give Zenji a knowing smile, giving him a gentle kiss on the cheek before climbing onto his bed, lying down. You tell Zenji that you want him to make love to you, you want to make sure that you will be pregnant tonight. ");
				if (player.hasVirginVagina()){
					outputText("You’ve waited this long for him, you want tonight to be everything you hoped it’d be.");
				}
				outputText("Zenji gives you a small laugh, but he can't hide his arousal for you as he's already at full mast. He creeps up onto the bed, kneeling above you. ");
				if (player.hasVirginVagina()){
					outputText(" \"<i>You’ve waited dis long for a true husband, dat’s some dedication. I am glad dat I can share de experience wit ya.</i>\"");
				}
				outputText("He places the length of his penis atop your box, gently teasing you with his manhood as he rubs his length against you, you wrap your [legs] around his waist.\n" +
						"\n" +
						"\"<i>Oh, I will show you how a real troll gets deir mate pregnant. I will make sure you will be full of my little children tonight.</i>\" He starts by gently fondling your form with a single hand, stroking your breasts before reaching up to your face, giving you a soft caress. His tail caresses the side of your torso as well, almost as if he were claiming you as his.\n" +
						"\n" +
						"You quiver in anticipation beneath his touch. Zenji slowly begins humping you, teasing you, toying with you to get you warmed up.\n" +
						"\n" +
						"You take in a deep sigh, you’ve waited all night for this moment, and now you have your husband all to yourself. Your lips are already more than wet, ready for entry.\n" +
						"\n" +
						"Zenji aligns his shaft just above your sex, slowly rubbing his girth against your lips. His length twitches occasionally in anticipation. You squirm beneath him, desperate for his manhood. After what feels like an eternity of continued teasing, Zenji finally presses his tip against your lips.\n");
				if (player.vaginalCapacity() <= 9){
					outputText("His manhood presses into your tight snatch, gently stretching out your walls. He feels so big inside you as he makes his way into you.\n");
				}
				else if (player.vaginalCapacity() < 79){
					outputText("His manhood presses into your moist snatch, gently pressing his way into you. He feels so good inside you as he presses deeper, gently bucking into you.\n");
				}
				else{
					outputText("His manhood presses into your moist snatch, gently pressing his way into you. While he may not be the biggest you've had, he is skilled and you couldn't wish for anyone better.\n");
				}
				outputText("Zenji moans softly as he slowly thrusts into you. His massive balls press against your body, desperate to fill you with every ounce of cum he has to offer. He notices your strain beneath him and he places his palm across your face, rubbing his thumb across your cheek affectionately.\n" +
						"\n" +
						"\"<i>I tink it’s time ta go fasta, you are gonna be bred tonight, but ya don’t seem ta want it... You’re mine, [name], now beg.</i>\"\n" +
						"\n" +
						"You breathe sharply before nodding.\n" +
						"\n" +
						"\"<i>If ya really want ta be bred like a real wife den you’re gonna have ta beg harder dan dat.</i>\"\n" +
						"\n" +
						"You grab hold of his large hand, caressing your face with him, giving his fuzzy finger a small lick before pleading, you need him to go faster, you want him to go faster, you're desperate for his touch, for him. You need your husband to truly make love to you tonight.\n" +
						"\n" +
						"\"<i>Much betta...</i>\" he whispers. Your words of desperation are more than enough for him as he begins picking up the pace. Zenji growls softly as he buries himself deeper into your womb, his shaft twitches every so often, ready to fill you to the brim with his love. He plows you as a troll in heat should, railing you into oblivion. You tremble beneath his strong presence, desperate to take in more of everything he has to offer. Each thrust puts in more of his length each time as his hips crash against your body. It doesn't take long before a familiar pressure builds up within your loins. You moan softly and beg him not to stop. Zenji responds with a low, affectionate growl. Unable to take it anymore, you throw your head back as you find yourself cumming over him, your [legs] squeeze around him harder, trying to milk his dick of everything he has.\n" +
						"\n" +
						"Zenji gives you a cocky smile, \"<i>We're not done until I'm done...</i>\" he growls.\n" +
						"\n" +
						"Zenji grabs your legs as he thrusts into you with greater passion. You’re pressed beneath him as he fucks you like an animal in heat.\n" +
						"\n" +
						"You hear wood begin to crack as the frame gives out. The world seems to fall for a moment, but Zenji has you locked beneath him, safely within his grasp. He doesn’t even seem to care that he just broke the bed. The only thing that matters to him is knocking you up right now. The world spins and you feel dizzy, the overwhelming scent of his masculinity clouds your thoughts as the only thing you can think about is being bred by your husband.\n" +
						"\n" +
						"Zenji continues growling softly, \"<i>Almost… dere…</i>\" You feel him thrust into you with greater effort. His manhood throbbing within your moist walls, with a howl he finally cums, triggering your orgasm again. Waves of euphoria flow through you as you feel his seed race into your womb. Zenji slowly relaxes as he lies beside you.\n" +
						"\n" +
						"You notice his tail reaching up to caress the underside of your chin, \"If marriage will always be like dis, den I could neva wish for a betta soulmate\"\n" +
						"\n" +
						"Zenji gently strokes your back as he curls up with you, bringing his tail around your body.\n" +
						"\n" +
						"\"<i>Sleep tight, [name]</i>\"\n" +
						"\n" +
						"You plan on sleeping for the rest of the night, wrapped within the warmth of your husband’s embrace.\n");
				if (player.hasUniquePregnancy()) player.impregnationRacialCheck();
				else player.knockUp(PregnancyStore.PREGNANCY_ZENJI, PregnancyStore.INCUBATION_ZENJI);
			}
			else if (options == 3){
				var pCockSize:int = player.cocks[player.cockThatFits(45)].cockLength
				outputText("You tell Zenji that you’ve been thinking that he should lie on the bed this time, on his knees specifically.\n" +
						"\n" +
						"Zenji raises an eyebrow, \"<i>Are you… are you asking dat I take it from behind?</i>\"\n" +
						"\n" +
						"You nod, if he’s okay with it, that is.\n" +
						"\n" +
						"Zenji glances around slightly nervously, \"<i>I can’t lie, I’ve been wondering if I really wanted to, but… Well, you are my husband, aren’tcha? It’d be a shame if I neva gave you a chance.</i>\n");
				if (player.statusEffectv4(StatusEffects.ZenjiZList) > 0){
					outputText("You were de first one ta take me dere,");
				}
				else{
					outputText("You will be de first one ta take me down here,");
				}
				outputText("not like I would have it any other way.\"\n" +
						"\n" +
						"Zenji climbs on top of the bed, kneeling, ready for your entrance.\n" +
						"\n" +
						"You follow behind him, your manhood already reaching full length as you align yourself with his rear. You ask him if he’s ready, he gives a quiet nod. You take a firm grasp on his muscular rear. His ass is toned, sculpted, and perfectly symmetrical. You’re a little jealous of how perfect it is.\n" +
						"\n" +
						"You slowly bring yourself to penetrate him, he breathes a deep sigh as you slide into his backdoor with little resistance. You place your hands on his hips as you continue thrusting. Zenji is mostly still for the encounter, unsure of what he should be doing.\n" +
						"\n" +
						"You press yourself further into him \n");
				if (pCockSize < 5){
					outputText("You’re unable to reach his prostate, but he seems to be enjoying himself nonetheless.\n");
				}
				else{
					outputText("Your lengthy shaft prods at his prostate, he groans softly as you thrust into him.\n");
				}
				outputText("You reach around over him, grabbing his throbbing manhood as you begin to jerk him off. You dig a finger underneath his foreskin, toying with his glans.\n" +
						"\n" +
						"\"Ah! [name]... D-don’t stop…</i>\" Zenji moans.\n" +
						"\n" +
						"You obey his request as you continue jerking off his shaft. Zenji buries his face into his pillow, growling softly.\n" +
						"\n" +
						"You continue thrusting, his ass is so tight, but he’s mostly static, just taking you in without doing much else. It’s very apparent he’s not sure what to do.\n" +
						"\n" +
						"Trying to see if you can awaken something deeper within him, you buck into him as hard as you can.\n" +
						"\n" +
						"Zenji yelps in response as you feel a surge of pre leak down onto your fingers as he clenches around your manhood.\n" +
						"\n" +
						"You laugh at his vulnerability, he seems to enjoy it when you go rough, so you continue bucking into him with greater vigor. It doesn’t last long though as you feel yourself nearing your climax.\n" +
						"\n" +
						"Zenji growls louder this time, his manhood throbbing even harder as you feel him shoot jets of cum onto his bedroll. \n");
				if (player.statusEffectv2(StatusEffects.ZenjiModificationsList) >= 6000){	//This was supposed to be volume based (6L), but due to Orm's black magic, I can only guess... unless that number is the actual volume. ¯\_(ツ)_/¯ //Haha, good luck everyone -Pyromania
					outputText("So much cum is being released by him, practically painting the bed beneath him white.");
				}
				outputText(" A familiar pressure builds within your loins as he tries to milk you of everything you’re worth. You groan loudly as you cum inside of his awaiting hole.\n");
				if (player.cumCapacity() > 3500){
					outputText(" Your load is massive as you continuously pump more cum into him. Zenji moans softly as his stomach distends slightly from the force of your efforts.\n" +
							"\n" +
							"\n" +
							"You slump over his soft furry back as Zenji lies down, he pulls you close to him, \"I’m glad to have done dis wit ya, [name].\"\n" +
							"\n" +
							"You tell him that you enjoyed it as well. Zenji pulls you closer to him as he begins spooning you.\n" +
							"\n" +
							"You notice his tail reach up to caress the underside of your chin, \"<i>If marriage will always be like dis, den I could neva wish for a betta soulmate. Sleep tight, [name].</i>\"\n" +
							"\n" +
							"You plan on sleeping for the rest of the night, wrapped within the warmth of your husband’s embrace.\n");
				}
			}
			doNext(ZenjiMarriageSexTime2, options);
		}

		private function ZenjiMarriageSexTime2(options:int):void{
			clearOutput();
			if (options == 1){
				outputText("You wake up in the middle of the night to the sound of faint conversation.\n" +
						"\n" +
						"\"<i>Jabala… are you sure..? Dey’re sleeping.</i>\"\n" +
						"\"<i>Halkano… I… I need you now more than ever… I need my big strong bear… please..?</i>\"\n" +
						"You hear faint chuckling, \"<i>Anyting for you, sweetheart. Besides, I've been smelling ya all night.</i>\"\n" +
						"\n" +
						"It doesn’t take long before you hear the shaking of wood, almost like a rocking chair.\n" +
						"\n" +
						"Jabala is so quiet, you can barely hear her at all over Halkano’s soft growling from the other room... Like father like son?\n" +
						"\n" +
						"You laugh quietly to yourself, is this what they heard earlier from you two? It’s nice to know that Zenji’s parents still have that fire in their relationship, you hope that your relationship will remain strong like theirs.\n" +
						"\n" +
						"You turn to face Zenji, he unconsciously pulls you closer to him as you drift back to sleep in his embrace.\n");
			}
			else if (options == 2){
				outputText("You wake up in the middle of the night to the sound of faint conversation.\n" +
						"\n" +
						"\"<i>Jabala… are you sure..? Dey’re sleeping.</i>\"\n" +
						"\"<i>Halkano… I… I need you now more than ever… I need my big strong bear… please..?</i>\"\n" +
						"You hear faint chuckling, \"<i>Anyting for you, sweetheart. Besides, I've been smelling ya all night.</i>\"\n" +
						"\n" +
						"It doesn’t take long before you hear the shaking of wood, almost like a rocking chair.\n" +
						"\n" +
						"Jabala is so quiet, you can barely hear her at all over Halkano’s soft growling from the other room... Like father like son?\n" +
						"\n" +
						"You laugh quietly to yourself, is this what they heard earlier from you two? It’s nice to know that Zenji’s parents still have that fire in their relationship, you hope that your relationship will remain strong like theirs.\n" +
						"\n" +
						"You turn to face Zenji, he unconsciously pulls you closer to him as you drift back to sleep in his embrace.\n");
			}
			else if (options == 3){
				outputText("You wake up in the middle of the night to the sound of faint conversation.\n" +
						"\n" +
						"\"<i>Jabala… are you sure..? Dey’re sleeping.</i>\"\n" +
						"\"<i>Halkano… I… I need you now more than ever… I need my big strong bear… please..?</i>\"\n" +
						"You hear faint chuckling, \"<i>Anyting for you, sweetheart. Besides, I've been smelling ya all night.</i>\"\n" +
						"\n" +
						"It doesn’t take long before you hear the shaking of wood, almost like a rocking chair.\n" +
						"\n" +
						"Jabala is so quiet, you can barely hear her at all over Halkano’s soft growling from the other room... Like father like son?\n" +
						"\n" +
						"You laugh quietly to yourself, is this what they heard earlier from you two? It’s nice to know that Zenji’s parents still have that fire in their relationship, you hope that your relationship will remain strong like theirs.\n" +
						"\n" +
						"You turn to face Zenji, he unconsciously pulls you closer to him as you drift back to sleep in his embrace.\n");
			}
			doNext(ZenjiMarriageSexTime3, options);
		}

		private function ZenjiMarriageSexTime3(options:int):void{
			clearOutput();
			outputText("<b>Next Morning</b>");
			if (options == 1){
				outputText("You wake up the next morning, as you open your eyes your face is still nestled in Zenji's chest tuft. Daylight pours into the room and you give a small yawn and look up at Zenji, his eyes are already resting upon your face.\n" +
						"\n" +
						"\"<i>Good morning [name] Sleep well?</i>\" he asks, giving you a gentle smile.\n" +
						"\n" +
						"You tell him that indeed you did. You’re glad to spend the night with your husband.\n" +
						"\n" +
						"Zenji strokes the top of your head, \"<i>You know... I really hope we didn’t bother my parents wit all de noise. I’m just glad I didn’t wake ya up when I cleaned us off</i>\"\n" +
						"\n" +
						"You’re thankful that he cares enough to help clean you up after such a rough night.\n" +
						"\n" +
						"Zenji plants a kiss on your lips. \"<i>Are ya ready ta say goodbye and go home, [name]?</i>\"\n" +
						"\n" +
						"You nod your head, you look around and ask Zenji where your clothes are.\n" +
						"\n" +
						"Zenji sits up, \"<i>Wait… uh… I didn’t tink dis through…</i>\"\n" +
						"\n" +
						"You hear a knocking on the door, \"<i>I have your clothes right here!</i>\" Jabala shouts.\n" +
						"\n" +
						"\"<i>Ah, motha! Were you eavesdropping?</i>\"\n" +
						"\n" +
						"\"No! I was… just… gardening!</i>\"\n" +
						"\n" +
						"\"<i>You were gardening… inside..?</i>\"\n" +
						"\n" +
						"\"<i>Yes! I’m tending to the shade plants!</i>\"\n" +
						"\n" +
						"Zenji snickers before returning to her, \"<i>Whateva…</i>\" He gets up, you feel cold without your husband’s warmth as he opens the door to retrieve your clothes.\n" +
						"\n" +
						"You hear Jabala speak up, \"<i>I’ll hold onto ya wedding clothes and…</i>\" Jabala unleashes an audible gasp. \"<i>Zinny! What did you do to your shirt?!</i>\"\n" +
						"\n" +
						"Zenji blushes softly, \"<i>I… uh… Thanks for de clothes mom.</i>\" Zenji replies as he closes the door.\n" +
						"\n" +
						"Zenji passes you your [armor] as he puts on a loincloth.\n" +
						"\n" +
						"You say your goodbyes to Jabala and Halkano, assuring them that you will return soon as you return to your camp, ready to live your life with your husband.\n");
			}
			else if (options == 2){
				outputText("You wake up the next morning, as you open your eyes your face is still nestled in Zenji's chest tuft between his manly pectorals. Daylight pours into the room and you give a small yawn and look up at Zenji, his eyes are already resting upon your face.\n" +
						"\n" +
						"\"<i>Good morning [name]. Sleep well?</i>\" he asks, giving you a gentle smile.\n" +
						"\n" +
						"You tell him that indeed you did. You’re glad to spend the night with your husband.\n" +
						"\n" +
						"Zenji strokes the top of your head, \"<i>You know I really hope we didn’t bother my parents wit all de noise. I’m just glad I didn’t wake ya up when I cleaned us off</i>\"\n" +
						"\n" +
						"You’re thankful that he cares enough to help clean you up after such a rough night.\n" +
						"\n" +
						"Zenji plants a kiss on your lips. \"<i>Are ya ready ta say goodbye and go home, [name]?</i>\"\n" +
						"\n" +
						"You nod your head, looking around before you ask Zenji where your clothes are.\n" +
						"\n" +
						"Zenji sits up, \"Wait… uh… I didn’t tink dis through…</i>\"\n" +
						"\n" +
						"\"<i>Don' worry, I gotcha clothes right here.</i>\" You hear Halkano reply\n" +
						"\n" +
						"\"<i>Ah, fatha! Were you eavesdropping?</i>\"\n" +
						"\n" +
						"\"<i>Yep.</i>\"\n" +
						"\n" +
						"\"<i>Ugh… fatha… dis is embarrassing.</i>\"\n" +
						"\n" +
						"\"<i>Well, come getcha clothes.</i>\"\n" +
						"\n" +
						"Zenji snickers before returning to him, \"<i>Blunt as always…</i>\" He gets up, you feel cold without your husband’s warmth as he opens the door to retrieve your clothes.\n" +
						"\n" +
						"You hear Halkano speak up, \"<i>Jabala will come ta hold onto ya wedding clothes and…</i>\" Halkano gives Zenji a knowing smirk. \"<i>Dat’s my son, look at whatcha did ta dat poor bed! I don’t know what you did to dat poor girl, but I hope she’s alright!</i>\"\n" +
						"\n" +
						"Zenji blushes softly, \"<i>I… uh… Tanks for de clothes dad.</i>\" Zenji replies as he closes the door.\n" +
						"\n" +
						"Zenji passes you your [armor] as he puts on a loincloth.\n" +
						"\n" +
						"You say your goodbyes to Jabala and Halkano, assuring them that you will return soon as you return to your camp, ready to live your life with your newlywed husband.\n");
			}
			else if (options == 3){
				outputText("You wake up the next morning, as you open your eyes your face is resting against Zenji’s muscular pecs, comfortably nestled within his chest tuft. Daylight pours into the room and you give a small yawn and look up at Zenji, his eyes are resting upon your face.\n" +
						"\n" +
						"\"<i>Good morning [name]. Sleep well?</i>\" he asks, giving you a gentle smile.\n" +
						"\n" +
						"You tell him that indeed you did. You’re glad to spend the night with your husband.\n" +
						"\n" +
						"Zenji strokes the top of your head, \"<i>You know I really hope we didn’t bother my parents wit all de noise.</i>\"\n" +
						"\n" +
						"Zenji plants a kiss on your lips. \"<i>Are ya ready ta say goodbye and go home, [name]?</i>\"\n" +
						"\n" +
						"You nod your head, looking around before asking Zenji where your clothes are.\n" +
						"\n" +
						"Zenji sits up, \"<i>Wait… uh… I didn’t tink dis through…</i>\"\n" +
						"\n" +
						"You hear a knocking on the door, \"<i>I have your clothes right here!</i>\" Jabala shouts.\n" +
						"\n" +
						"\"<i>Ah, motha! Were you eavesdropping?</i>\"\n" +
						"\n" +
						"\"<i>No! I was… just… gardening!</i>\"\n" +
						"\n" +
						"\"<i>You were gardening… inside..?</i>\"\n" +
						"\n" +
						"\"<i>Yes! I’m tending to the shade plants!</i>\"\n" +
						"\n" +
						"Zenji snickers before returning to her, \"Whuteva…</i>\" He gets up, you feel cold without your husband’s warmth as he opens the door to retrieve your clothes.\n" +
						"\n" +
						"You hear Jabala speak up, \"<i>I’ll hold onto ya wedding clothes and…</i>\" Jabala unleashes an audible gasp. \"<i>Zinny! What did you do to your shirt?!</i>\"\n" +
						"\n" +
						"Zenji blushes softly, \"<i>I… uh… Tanks for de clothes mom.</i>\" Zenji replies as he closes the door.\n" +
						"\n" +
						"Zenji passes you your [armor] as he puts on a loincloth.\n" +
						"\n" +
						"You say your goodbyes to Jabala and Halkano, assuring them that you will return soon as you return to your camp, ready to live your life with your newlywed husband.\n");
			}
			if (!recalling) {
				var timeShift:int = (24 - time.hours) + 8;
				explorer.stopExploring();
				doNext(createCallBackFunction(camp.returnToCamp, timeShift));
			} else doNext(recallWakeUp);
		}

		public static function isLover():Boolean {
			return flags[kFLAGS.ZENJI_PROGRESS] >= 11;
		}
	}
}
