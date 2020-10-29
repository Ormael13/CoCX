/**
 * ...
 * @author Pyromania
 */
package classes.Scenes.NPCs 
{
import classes.*;
//import classes.BodyParts.Tongue;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;
import coc.view.ButtonDataList;
	
	public class ZenjiScenes extends NPCAwareContent
	{
		
		public function ZenjiScenes() 
		{}
	
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
	outputText("\"<i>Heheh, If you want to enter I don't ask for much, ya see?</i>\" He chuckles, \"<i>You can pay  a toll for de troll, 25 gems to enter, or perhaps you have something else to offer, something dat could require a lot from you if you tink you can take de challenge.</i>\"\n\n");
	outputText("You sigh, it's pretty much the same thing, all anybody asks for in this land is either sex or gems and this alleged troll as he called himself seems no different. You consider if giving him proper payment is worth it.\n\n");
	if (flags[kFLAGS.CODEX_ENTRY_TROLLS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_TROLLS] = 1;
		outputText("\n\n<b>New codex entry unlocked: Trolls!</b>");
	}
	menu();
	if (player.gems >= 25) addButton(0, "Pay w Gems", part1TrollEncounterPayWithGems);
	else addButtonDisabled(0, "Pay w Gems", "You not have enough gems!");
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
	else addButtonDisabled(0, "Pay w Gems", "You not have enough gems!");
	addButton(2, "Challenge", part1TrollEncounterChallange);
	addButton(3, "Fight", part1TrollEncounterFight);
	addButton(4, "Leave", part1TrollEncounterLeave);
}

public function part1TrollEncounterLeave():void {
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	outputText("You return back to your camp following the path that you made along your way.\n\n");
	doNext(camp.returnToCampUseOneHour);
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
		outputText("\"<i>Get off of me!</i>\" He shouts, throwing you to the ground. You hit the ground and the world grows dim before you black out.\n\n");
	}
	cleanupAfterCombat();
}

public function part1TrollEncounterFightZenjiDefeated():void {
	clearOutput();
	outputText("The troll staggers backward, unable to fight anymore. \"<i>Heh... ya bested me...</i>\" He coughs, \"<i>Go on, ya can enter... I jus need a break...</i>\"\n\n");
	outputText("He struggles a moment before he tumbles away, nowhere to be seen.\n\n");
	zenjiPerspectiveOnPlayer(4);
	menu();
	if (player.cor >= 50) addButton(1, "Hunt him", part1TrollEncounterFightZenjiDefeatedHuntHim).hint("He’s not getting away that easily!");
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
		outputText("A minute passes before he breaks the silence, \"<i>Come to finish me off?</i>\" He says with a growl.\n\n");
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
		if (player.cor < 90) {
			outputText("\"<i>Qué lástima</i>\" He growls, \"<i>Not even worth my time.</i>\"\n\n");
			outputText("He walks off, nowhere to be seen. The world grows hazy as you pass out from exhaustion.\n\n");
			cleanupAfterCombat();
		}
		else {
			outputText("\"<i>Vile creature.</i>\" He growls, \"<i>It’s time ta rid dis world of filth like you. One. By. One.</i>\" He picks up his spear, lining up the tip to your throat before impaling you with one swift motion. You choke, gasping for air, reaching up in desperation. The world grows hazy as you feel reality release its grip on you. The last thing you see is his spear going in for a coup de grâce.\n\n");
			EventParser.gameOver();
		}
	}
	else {
		outputText("You fall to the ground, too aroused to fight any longer, your senses overwhelm you before the masculine scent of his dense musk.\n\n");
		outputText("\"<i>Pathetic.</i>\" He mutters, \"<i>Dat’s all demons like you want, I’d best kill you before you bother someone else.</i>\"\n\n");
		outputText("He picks up his spear, lining up the tip to your throat before impaling you with one swift motion. You choke, gasping for air, reaching up in desperation. The world grows hazy as you feel reality release its grip on you. The last thing you see is his spear going in for a coup de grâce.\n\n");
		EventParser.gameOver();
	}
}

public function part1TrollEncounterFightTOTHEDEATHZenjiDefeated():void {
	clearOutput();
	outputText("The troll falls to the ground, severely wounded, unable to fight any longer. He struggles to regain his footing, desperately clinging onto the spear he has impaled to the ground.\n\n");
	outputText("\"<i>I will not wither!</i>\" He grunts, \"<i>I WILL NOT FALL!</i>\" His voice trembles as he struggles to stand up before you, adopting a fighting stance. His legs buckle as he collapses, blood rushes down his face as he’s bleeding out, despite his attempts to regenerate.\n\n");
	outputText("You grin in satisfaction, considering what you want to do with your prey in his final moments.\n\n");
	menu();
	addButton(1, "Kill him", part1TrollEncounterFightTOTHEDEATHZenjiDefeatedKillHim).hint("He doesn’t deserve to live anymore");
	addButton(2, "Torment", part1TrollEncounterFightTOTHEDEATHZenjiDefeatedTorment).hint("Let him know his place");
	addButton(3, "Leave him", part1TrollEncounterFightTOTHEDEATHZenjiDefeatedLeaveHim).hint("Leave him to rot");
}
public function part1TrollEncounterFightTOTHEDEATHZenjiDefeatedKillHim():void {
	clearOutput();
	outputText("You smirk in satisfaction, has he learned his lesson yet or does he need one final example? Cowards never get to hide, now you can claim your prize once and for all.\n\n");
	outputText("You approach him, he looks toward you with bleak defiance. \"<i>I… won't… give up..!</i>\" He sputters, choking on his blood. \"<i>You will die, scum like you does not deserve to live!</i>\"\n\n");
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
		outputText("\"<i>Ahahah, you are a weak little one, try harda next time.</i>\" He says dropping to the ground.\n\n");
		outputText("Bested by his strength, you decide to return home.\n\n");
		zenjiPerspectiveOnPlayer(-4);
		doNext(camp.returnToCampUseOneHour);
	}
	else if (player.str < (145 + (player.newGamePlusMod() * 29))) {
		outputText("You hold on with all your might, after a while you begin to grow tired and begin rocking back and forth to support yourself. You look over and you see the troll beginning to strain, it appears he's beginning to have trouble supporting himself as well.\n\n");
		outputText("After a few moments, you can't support yourself anymore and drop down to the ground.\n\n");
		outputText("\"<i>Heheh, you are a weak little one, you gotta do better dan dat next time.</i>\" He says dropping to the ground.\n\n");
		outputText("Bested by his strength, you decide to return home.\n\n");
		zenjiPerspectiveOnPlayer(-4);
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		outputText("You hold on with all your might, after a while your arms start to grow weary. You look over to the troll and notice him straining to keep his composure. After a moment he drops with an exasperated breath, and you drop down after him.\n\n");
		outputText("\"<i>Hah... you are strong... stronger dan I expected, I'll let you pass, you can enter.</i>\" He says breathlessly.\n\n");
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
	outputText("He grabs a rock and places it at his foot, \"<i>I want ya ta hold dis rock high above your head wit only two arms, as high as your arms can reach, first one to drop loses.</i>\"\n\n");
	outputText("Seems simple enough, you wait for his command and on queue, you hold the rock high above your head as high as your arms will let you.\n\n");
	if (player.tou < (115 + (player.newGamePlusMod() * 23))) {
		outputText("After some time of holding the rock above your head, your arms begin to grow weary, the rock, despite not being too heavy, is beginning to put a burden on your arms as its weight begins to feel like it's increasing. You look over to the troll who seems to be having no trouble carrying his rock above his head.\n\n");
		outputText("Unable to support the rock anymore, you drop in on the ground and give your tired arms a chance to rest.\n\n");
		outputText("\"<i>Heheh, you are a weak little one, try harda next time.</i>\" He says dropping the rock onto the ground.\n\n");
		outputText("Bested by his toughness, you decide to return home.\n\n");
		zenjiPerspectiveOnPlayer(-4);
		doNext(camp.returnToCampUseOneHour);
	}
	else if (player.tou < (140 + (player.newGamePlusMod() * 28))) {
		outputText("After some time of holding the rock above your head, your arms begin to grow weary, the rock, despite not being too heavy, is beginning to put a burden on your arms as its weight begins to feel like it's increasing. You look over to the troll who seems to be showing signs of struggle holding the rock over his head.\n\n");
		outputText("Unable to support the rock anymore, you drop in on the ground and give your tired arms a chance to rest.\n\n");
		outputText("\"<i>Heheh, you are a weak little one, you gotta do better dan dat next time.</i>\" He says dropping the rock onto the ground.\n\n");
		outputText("Bested by his toughness, you decide to return home.\n\n");
		zenjiPerspectiveOnPlayer(-4);
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		outputText("After some time of holding the rock above your head, your arms begin to grow weary, the rock starting to put a burden on your arms. You look over to the troll who's struggling to support the rock with his arms.\n\n");
		outputText("After a moment he drops to rock to the ground.\n\n");
		outputText("\"<i>Hah... You are tough... tougher dan I expected, I'll let you pass, you can enter.</i>\" He says breathlessly.\n\n");
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
		outputText("\"<i>Heheh, you are a weak little one, try harda next time.</i>\" He says leaning back against the tree.\n\n");
		outputText("Bested by his speed, you decide to return home.\n\n");
		zenjiPerspectiveOnPlayer(-4);
		doNext(camp.returnToCampUseOneHour);
	}
	else if (player.spe < (155 + (player.newGamePlusMod() * 31))) {
		outputText("You sprint over to the tree as fast as you can, you stay close to the troll, but he's just faster than you are, it's close, but he beats you to the tree by a few seconds.\n\n");
		outputText("\"<i>Heheh, you are a weak little one, you gotta do better dan dat next time.</i>\" He says leaning back against the tree.\n\n");
		outputText("Bested by his speed, you decide to return home.\n\n");
		zenjiPerspectiveOnPlayer(-4);
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		outputText("You sprint over to the tree as fast as you can, you steadily succeed the troll, you're faster than he is and you beat him to the tree.\n\n");
		outputText("\"<i>Hah... Ya fast... faster dan I expected, I'll let you pass, you can enter.</i>\" He says breathlessly.\n\n");
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
		outputText("\"<i>Heheh, you are a weak little one, try harda next time.</i>\" He says, straightening his back.\n\n");
		outputText("Bested by his intelligence, you decide to return home.\n\n");
		zenjiPerspectiveOnPlayer(-4);
		doNext(camp.returnToCampUseOneHour);
	}
	else if (player.inte < (125 + (player.newGamePlusMod() * 25))) {
		outputText("He pauses for a moment and attempts to strike you with the branch, you deflect his oncoming attack, but you do not let your guard down, he's ready for you to strike, and you are not so keen on giving him an opening. You wait for his next strike, ready to deflect him, but he fakes you out and strikes you from the other side.\n\n");
		outputText("\"<i>Heheh, you are a weak little one, you've gotta do better dan dat next time.</i>\" He says, straightening his back.\n\n");
		outputText("Bested by his intelligence, you decide to return home.\n\n");
		zenjiPerspectiveOnPlayer(-4);
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		outputText("He pauses for a moment and attempts to strike you with the branch, you deflect his oncoming attack. He's quite predictable, read like an open book. He likes to strike and expose your weakness if you go for a counter attack, and his fake outs are easy to notice.\n\n");
		outputText("You wait for a good opening and strike before he lands a hit on you. You manage to hit him before you do, he seems stunned for a moment.\n\n");
		outputText("\"<i>Hah... Ya smart... smarter dan I expected, I’ll let you pass, you can enter.</i>\" He says breathlessly.\n\n");
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
		outputText("\"<i>Heheh, not the wisest little one, try harda next time.</i>\" He says.\n\n");
		zenjiPerspectiveOnPlayer(-4);
		doNext(camp.returnToCampUseOneHour);
	}
	else if (player.wis < (135 + (player.newGamePlusMod() * 27))) {
		outputText("You inspect the rocks, remembering what he said about how the moss can be poisonous if dry, you feel around for the dampest rock, and when you think you've found the best one, you tell the troll that you're ready to compare results.\n\n");
		outputText("The troll looks over and you flip the rock, there are not as many insects as you would've hoped.\n\n");
		outputText("Sure enough, when the troll flips over the rock he's chosen there are noticeably some more bugs than what was under yours.\n\n");
		outputText("\"<i>Heheh, not the wisest little one, you gotta do better dan dat next time.</i>\" He says.\n\n");
		zenjiPerspectiveOnPlayer(-4);
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		outputText("You inspect the rocks, remembering what he said about how the moss can be poisonous if dry, you inspect the rocks carefully, making sure to peel the moss back to make sure it's damp all the way through. Once you've found the ideal rock, you tell the troll you're ready to compare results.\n\n");
		outputText("The troll looks over and you flip the rock, there's definitely plenty of insects.\n\n");
		outputText("When the troll flips over the rock he's chosen there are definitely not as many insects as you have under yours.\n\n");
		outputText("\"<i>Hah... ya are quite wise... wiser dan I expected, I'll let you pass, you can enter.</i>\" He says bowing before you.\n\n");
		zenjiPerspectiveOnPlayer(4);
		part1TrollEncounterRewards();
	}
}

public function part1TrollEncounterSex():void {
	outputText("You eye him once more, he's tall, easily standing over 8 feet, he's only dressed in a loin cloth and some fur bracers as the rest of his muscular body is covered in light green fuzz. It could be worse, his chiseled face definitely is rather handsome.\n\n");
	outputText("You take him on his offer and decide that you're willing to pay his toll with your body.\n\n");
	outputText("\"<i>Ehhh, what?</i>\" He raises an eyebrow at you, \"<i>Now, now, don't be hasty, I didn' offer dat.</i>\"\n\n");
	outputText("You're not sure what to say, he's actually declining an offering for sex?\n\n");
	outputText("\"<i>Ya know, you really are bold, I'll tell ya what,</i>\" He says as he hops off the tree, \"<i>If you can best me in one of the challenges of my choosing, I’ll let ya pass, it's a good deal, no?</i>\"\n\n");
	menu();
	addButton(1, "Challenge?", part1TrollEncounterChallange);
	addButton(3, "Leave", part1TrollEncounterLeave);
}

public function part1TrollEncounterPayWithGems():void {
	player.gems -= 25;
	outputText("You pull out 25 gems from your gem pouch, as you do so he hops down from the tree. He holds out a four-fingered palm, awaiting your payment and you fork the gems over. The entire time he looks directly into your eyes, but at the same time there seems to be a tinge of disappointment within his.\n\n");
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
	outputText("You spend some more time looking around the area and stumble upon " + itype + ".\n\n");
	outputText("You decide to head back home afterwards as there doesn't appear to be anything else of interest right now.\n\n");
	inventory.takeItem(itype, camp.returnToCampUseOneHour);
}

//PART 2

public function part2TrollEncounterFirst():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("As you are maneuvering your way through the dense bog, careful not to let the wildlife best you at your adventure, you hear a familiar voice ring through the trees.\n\n");
	outputText("\"<i>Ahaha! It’s you again! Welcome, welcome!</i>\" A male voice rings through the thicket and a familiar troll leaps down from the trees, \"<i>Me temo que no nos hemos presentado adecuadamente.</i>\"\n\n");
	outputText("He holds a hand over his chest. \"<i>Me llamo Zenji, and who am I gifted ta meet again once more?</i>\" He says leaning close and raising an eyebrow toward you.\n\n");
	outputText("You state your name.\n\n");
	if (player.cor >= 50) outputText("enji gives you a sideways glance, almost as if he doesn't trust you. \"<i>If dat is de truth, it's nice ta meet you, [name]</i>\"\n\n");
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
	doNext(camp.returnToCampUseOneHour);
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
		outputText("\"<i>It’s you again, [name].</i>\" Zenji welcomes, but there’s concern in his words, \"<i>Are ya doing well? Maybe… Er… I guess we can still train or spar..?</i>\"\n\nZenji seems very unsure of his words, as he wants to offer something else but refuses to. He shakes his head, as if to clear a thought from his mind as he returns to a more neutral stance.\n\n");
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
	doNext(camp.returnToCampUseOneHour);
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
	doNext(camp.returnToCampUseOneHour);
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
		if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] < 30) outputText("\"<i>[name]... Are you okay..? Would it help if I went easier? You don’ have ta fight me if you aren’t ready… Please, get some rest./i>\"\n\n");
		else outputText("\"<i>Das all ya got?</i>\" Zenji shakes his head, \"<i>Ya gotta try harder dan dat next time. Ya be safe out dere now.</i>\"\n\n");
		zenjiPerspectiveOnPlayer(-4);
	}
	else {
		if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] < 30) outputText("Zenji blushes, noticing your apparent arousal, \"<i>[name]... Do… Do you like me…? ¿Es mi jale tan fuerte?</i>\"\n\n");
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
	if (player.fatigue > player.maxFatigue() * 0.5) {
		outputText("You try to do as many pull-ups as you can, but your tired arms can't support you, and you are worn out after barely doing one.\n\n");
		if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] < 30) outputText("\"<i>Are... are sure you’re okay? Dere's... You don' have ta train wit me if ya don' wanna. Dere's oda ways to...</i>\" Zenji shakes his head, \"<i>Ya should go home and get some rest, I'll tink of sometin lata.</i>\"\n\n");
		else outputText("\"<i>Das all ya got? Maybe dere's an easier ting I got next time, ya should go home and rest for a moment so I can prepare for next time.</i>\"\n\n");
		player.fatigue += Math.round(player.maxFatigue() * 0.2);
		zenjiPerspectiveOnPlayer(-3);
	}
	else {
		outputText("Some time passes and you can't do anymore, but you feel that this exercise was worth the effort and return to camp after dismissing yourself.\n\n");
		player.trainStat("str",2,75);
		player.fatigue += Math.round(player.maxFatigue() * 0.35);
		zenjiPerspectiveOnPlayer(3);
	}
	doNext(camp.returnToCampUseOneHour);
}

public function part2TrollEncounterTrainToughness():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("Zenji leads you over to a pile of rocks of different shapes and sizes.\n\n");
	outputText("\"<i>Ya may remember da challenge I put up against ya, toughness is not about being strong, it about endurance, and tenathity, how much can ya take before ya break?</i>\" He guides you to a pile of rocks.\n\n");
	outputText("\"<i>Don't actually break yaself, dis is for training. All I want you ta do is start by stretching, ya don't want ta hurt yaself, do ya?</i>\" He extends his arm over himself and repeats with the other arm, stretching himself as far out as he can, you follow in his lead. \"<i>Now, follow my lead.</i>\"\n\n");
	outputText("Zenji lowers himself to the ground and begins planking, \"<i>Simple, no? Keep dis stance until ya can't take it anymore, endure it, don't break unda de pressure.</i>\"\n\n");
	if (player.fatigue > player.maxFatigue() * 0.5) {
		outputText("You try to hold the plank for as long as you can, but you feel too weak to hold it much longer than nearly half a minute and collapse to the ground.\n\n");
		if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] < 30) outputText("\"<i>Are... are sure you’re okay? Dere's... You don' have ta train wit me if ya don' wanna. Dere's oda ways to...</i>\" Zenji shakes his head, \"<i>Ya should go home and get some rest, I'll tink of sometin lata.</i>\"\n\n");
		else outputText("\"<i>Dat’s all ya got? Maybe dere's an easier ting I got next time, ya should go home and rest for a moment so I can prepare for next time.</i>\"\n\n");
		player.fatigue += Math.round(player.maxFatigue() * 0.2);
		zenjiPerspectiveOnPlayer(-3);
	}
	else {
		outputText("You begin planking, a few minutes pass and your arms start feeling weak, you figure you've been planking for enough time and relax. You feel that the exercise was worth the time and return to camp after dismissing yourself.\n\n");
		player.trainStat("tou",1,100)
		player.fatigue += Math.round(player.maxFatigue() * 0.35);
		zenjiPerspectiveOnPlayer(3);
	}
	doNext(camp.returnToCampUseOneHour);
}

public function part2TrollEncounterTrainSpeed():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("Zenji leads you to a clearing in the bog, it's a more open area, ideal for an exercise that requires space.\n\n");
	outputText("\"<i>Ya may remember da challenge I put up against ya, it not be hard ta practice and work on ya speed, train and aim for da goal, each time a little quicka dan before.</i>\" He guides you to the edge of the clearing. \"<i>Ya see dat tree ova der? All you gotta do is make good speed from here ta der. Ya don't have ta go too fast, just ta make yaself feel da effort.</i>\"\n\n");
	if (player.fatigue > player.maxFatigue() * 0.5) {
		outputText("You start at a slow pace, sure that you can work up slowly from there.\n\n");
		outputText("\"<i>Dat's ya top speed? Come on, ya can afford a little more dan dat.</i>\"\n\n");
		outputText("You're unsure if you can go much faster in your fatigued state and tell him so.\n\n");
		if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] < 30) outputText("\"<i>Are... are sure you’re okay? Dere's... You don' have ta train wit me if ya don' wanna. Dere's oda ways to...</i>\" Zenji shakes his head, \"<i>Ya should go home and get some rest, I'll tink of sometin lata.</i>\"\n\n");
		else outputText("\"<i>Das all ya got? Maybe dere's an easier ting I got next time, ya should go home and rest for a moment so I can prepare for next time.</i>\"\n\n");
		player.fatigue += Math.round(player.maxFatigue() * 0.2);
		zenjiPerspectiveOnPlayer(-3);
	}
	else {
		outputText("You begin at a brisk pace, jogging from the tree and back to Zenji.\n\n");
		outputText("\"<i>Das a good start, try ta go fasta each time.</i>\"\n\n");
		outputText("You jog back and forth with the troll, making sure to keep a good pace. You feel that the exercise was worth the time and return to camp after dismissing yourself.\n\n");
		player.trainStat("spe",2,75);
		player.fatigue += Math.round(player.maxFatigue() * 0.35);
		zenjiPerspectiveOnPlayer(3);
	}
	doNext(camp.returnToCampUseOneHour);
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
	doNext(camp.returnToCampUseOneHour);
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
	doNext(camp.returnToCampUseOneHour);
}

public function followerZenjiMainCampMenu():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("You approach Zenji, he looks up at you while you approach, raising an eyebrow.\n\n");
	menu();
	addButton(0, "Appearance", followerZenjiMainCampMenuAppearance).hint("Examine Zenji.");
	addButton(1, "Talk", followerZenjiTalks).hint("Talk to Zenji.");
	if (player.lust > 33) addButton(2, "Sex", followerZenjiSex).hint("Perhaps the hunk could be open to share an intimate moment with you.");
	if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] > 0 && flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] < 100) addButton(3, "Glades", followerZenjiGlades).hint("Ask Zenji for help in destroying the corrupted glades.");
	addButton(4, "Training", followerZenjiMainCampMenuTraining).hint("Train with Zenji to increase your stats.");
	if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) addButton(5, "Spar", followerZenjiSpar).hint("Spar with Zenji.");
	else addButtonDisabled(5, "Spar", "You can spar with him, but you need to build a sparring ring first!");
	addButton(14, "Leave", followerZenjiMainCampMenuLeave);
}

public function followerZenjiMainCampMenuAppearance():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("Zenji is a troll to your knowledge, at least that’s what he calls himself.\n\n");
	outputText("He is 8’2”, covered head to toe in green fur, the top of his head is crowned with a shaggy, pale green mohawk. All things considered, his face is rather handsome, with good symmetry, strong brows and a chiseled jawline. He has deep set eyes with ashen green irises. His nose is pronounced and elongated. As your eyes wander down his face, you can see 2 ivory tusks protrude from his mouth, each about 7 inches long, his left tusk is covered in a series of rings hanging from the tip to the midsection. ");
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
	if (player.fatigue >= player.maxFatigue() * .75) {
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
	dynStats("str", (4 - player.statusEffectv1(StatusEffects.ZenjiTrainingsCounters1)), "scale", false);
	outputText(player.modTone(player.maxToneCap(), 1));
	player.fatigue += Math.round(player.maxFatigue() * 0.2);
	followerZenjiMainCampMenuTrainingPerks();
	doNext(camp.returnToCampUseOneHour);
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
	dynStats("tou", (4 - player.statusEffectv2(StatusEffects.ZenjiTrainingsCounters1)), "scale", false);
	outputText(player.modThickness(0, 1));
    outputText(player.modTone(player.maxToneCap(), 1));
	player.fatigue += Math.round(player.maxFatigue() * 0.2);
	followerZenjiMainCampMenuTrainingPerks();
	doNext(camp.returnToCampUseOneHour);
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
	dynStats("spe", (4 - player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters1)), "scale", false);
	outputText(player.modThickness(0, 1));
    player.fatigue += Math.round(player.maxFatigue() * 0.2);
	followerZenjiMainCampMenuTrainingPerks();
	doNext(camp.returnToCampUseOneHour);
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
	outputText("\"<i>I wantcha ta read dis, not de entire ting, just dis page.</i>\" He says as he opens the book for you.\n\n");
	outputText("You being looking over the page, it’s about somatic components for casting spells and ways to strengthen spells as you cast them. As you read the page, you almost forget about the rock you’re trying to support. You quickly catch yourself and keep it up before it slips down. Is this what he was talking about with knowing your limits?\n\n");
	outputText("\"<i>Now, I want ya ta focus your mind, try ta focus some magic into your hands.</i>\"\n\n");
	outputText("You focus your efforts into conjuring a spell with some help from the book all while keeping the stone balanced on top of your head. You take a deep breath, but it’s not terribly difficult, even if you have to constantly shift your head to keep the stone steady. The magic you’re trying to conjure is unstable as you’re trying to focus your efforts in keeping the stone stead.\n\n");
	outputText("\"<i>Focus, [name], ya gotta keep dese tasks steady and unda control.</i>\"\n\n");
	outputText("Once you feel the rhythm and find a good balance with the stone, the magic you’ve conjured steadies and Zenji applauds.\n\n");
	outputText("\"<i>Strength of mind requires balance and strategy. Know your limits and how much you are capable of.</i>\"\n\n");
	if (player.statusEffectv1(StatusEffects.ZenjiTrainingsCounters2) < 3) player.addStatusValue(StatusEffects.ZenjiTrainingsCounters2, 1, 1);
	dynStats("inte", (4 - player.statusEffectv1(StatusEffects.ZenjiTrainingsCounters2)), "scale", false);
	player.fatigue += Math.round(player.maxFatigue() * 0.2);
	followerZenjiMainCampMenuTrainingPerks();
	doNext(camp.returnToCampUseOneHour);
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
	dynStats("wis", (4 - player.statusEffectv2(StatusEffects.ZenjiTrainingsCounters2)), "scale", false);
	player.fatigue += Math.round(player.maxFatigue() * 0.2);
	followerZenjiMainCampMenuTrainingPerks();
	doNext(camp.returnToCampUseOneHour);
}

public function followerZenjiMainCampMenuTrainingPerks():void {
	if (player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters2) < 30) player.addStatusValue(StatusEffects.ZenjiTrainingsCounters2, 3, 1);
	if (player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters2) == 5 || player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters2) == 15 || player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters2) == 30) outputText("After you're done training, you feel different, you can't explain it, but something has surely changed, almost as if the training you've done with Zenji is really speaking to you.\n\n");
	if (player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters2) == 5) {
		outputText("(<b>Gained Perk: Zenji's influence 1</b>)\n\n");
		player.createPerk(PerkLib.ZenjisInfluence1,0,0,0,0);
	}
	if (player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters2) == 15) {
		outputText("(<b>Gained Perk: Zenji's influence 2</b>)\n\n");
		player.createPerk(PerkLib.ZenjisInfluence2,0,0,0,0);
	}
	if (player.statusEffectv3(StatusEffects.ZenjiTrainingsCounters2) == 30) {
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
	outputText("Zenji crouches down and holds up a hand, \"<i>Enough! Enough... you are too good at dis.</i>\" He says breathlessly, \"<i>Don' worry 'bout me, I learned a few tricks to recova.</i>\" Zenji takes a deep breath and stands up. \"<i>Dat was fun, we should do it again lata, no?</i>\"\n\n");
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
	doNext(camp.returnToCampUseOneHour);
}

public function followerZenjiTalksTrolls():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("You ask Zenji what he can tell you about trolls. After all, that’s what he commonly refers to himself as.\n\n");
	outputText("\"<i>Dere's many kinda trolls, tink of it like alraune, each one may be simila way back den, but now dey've split into different kinds, ya know? My troll village grew used to da jungle we lived in, plenty of shade and cold nights, ma fuzz is great at keeping warm and hiding in da trees of da jungle, da oda trolls never saw me coming haha!</i>\"\n\n");
	outputText("He pauses for a moment, \"<i>But de other trolls in my village didn't like me too much, I caused trouble, I sought competition, when dey wanted peace and quiet, so I left. I didn't see many oda trolls out dere, but they’re probably not in de bog where I spent most’ve ma time.</i>\"\n\n");
	outputText("Zenji spends the rest of the hour talking about trolls and other nuances about his kind from the other trolls.\n\n");
	doNext(camp.returnToCampUseOneHour);
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
	doNext(camp.returnToCampUseOneHour);
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
	outputText("\"<i>Heheh... [name], It good ta see ya again... Are... are you alright, I-I jus’... I couldn' stop tinking about you and... De time I spent sparring and training wit ya... H-how have ya made it this far being so weak?</i>\"\n\n");
	outputText("You try to speak up but he cuts you off.\n\n");
	outputText("\"<i>It doesn’ matta now. [name], der's someting about ya that I just can't get outta my head, I-I want ta get closer to you, I've never felt dis way about anyone before... but... but I just want to be dere for you, I want ta protect ya from the world, I want ta be wit ya. I-I want ta get closer to you... get to know you...</i>\" You can feel his tail gently caress your body as he speaks.\n\n");
	outputText("You're not sure what to say, do you want this troll to join you at your camp as a guardian/protector?\n\n");
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
	doNext(camp.returnToCampUseOneHour);
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
	flags[kFLAGS.ZENJI_PROGRESS] = 11;
	doNext(camp.returnToCampUseOneHour);
}

public var loadVolume:Number = 1300;

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
	else outputText("You approach Zenji, he looks up at you while you approach, raising an eyebrow.\n\n");
	menu();
	addButton(0, "Appearance", loverZenjiMainCampMenuAppearance).hint("Examine Zenji.");
	addButton(1, "Talk", loverZenjiTalks).hint("Talk to Zenji.");
	addButtonDisabled(2, "Sex", "NYI");
	//if (player.lust > 33) addButton(2, "Sex", followerZenjiSex).hint("Perhaps the hunk could be open to share an intimate moment with you.");
	if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] > 0 && flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] < 100) addButton(3, "Glades", loverZenjiGlades).hint("Have Zenji help you in destroying the corrupted glades.");
	addButtonDisabled(4, "Nightwatch", "NYI");
	addButtonDisabled(5, "Team", "NYI");
	addButton(6, "Give Item", loverZenjiGiveItem);//.hint("Talk to Zenji.")
	addButtonDisabled(7, "Sleep With", "NYI");
	addButton(14, "Leave", loverZenjiMainCampMenuLeave);
}

public function loverZenjiMainCampMenuAppearance():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("Zenji is a troll to your knowledge, at least that’s what he calls himself.\n\n");
	outputText("He is 8’2”, covered head to toe in soft, cuddly green fur. The top of his head is crowned with a shaggy, pale green mohawk. His face is very handsome, with good symmetry, strong brows, and a chiseled jawline. He has deep-set eyes complimented by ashen green irises. His nose is pronounced and elongated. As your eyes wander down his face, you can see 2 ivory "+(player.statusEffectv4(StatusEffects.ZenjiModificationsList) == 7 ? "tusks protrude from his mouth, each about 7 inches long. His left tusk is covered in a series of rings hanging from the tip to the midsection" : "nibblers protrude from his mouth, barely an inch long")+". ");
	outputText("Between those tusks, his lower two canines stick out slightly past his lips. Darker colored hair wraps around his mouth, emphasizing the scruffy beard that covers his lower face. His beard is fairly dense, you could easily get your fingers lost beneath it. He has pointed ears similar to that of an elf, fuzzy like the rest of him. They twitch every so often, provoked easily by any sound that could bring a problem.\n\n");
	outputText("Zenji’s physique is imposing, chiseled, and very muscular. He wears a beaded necklace over his neck. He has broad shoulders with long, very muscular and toned arms that extend past his waist. His elbows are covered in darker colored hair that hangs out slightly. His arms are human-shaped with large four-fingered hands. He wears fur bracers that cover his wrists. He has 2 manly pecs with a tuft of hair sticking out between them. He has firm, well-defined abs, hidden behind his fur. He currently is only wearing a loincloth over his waist, tied by an animal fur pelt as his fur covers his entire body.  ");
	outputText("Sprouting from the base of his spine is his fuzzy tail, it is about 3 feet long with a larger tuft of hair at the tip, it sways slowly behind him.\n\nHe has 2 long, muscular legs that end in four-toed, furry feet. His ass is perfectly round, muscular and symmetrical, it is by far one of the best-looking behinds you will or have ever witnessed in your life. His tight backdoor is nestled between his cheeks where it belongs. Hiding behind his loincloth is his uncut humanoid penis. You know that he’s a grower, when fully erect he is ");
	if (player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 15) outputText("7.5 inches long and 2.2");
	if (player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 24) outputText("12 inches long and 2.4");
	if (player.statusEffectv3(StatusEffects.ZenjiModificationsList) == 32) outputText("16 inches long and 2.6");
	outputText(" inches thick, the only part of him not covered in hair. Below that is his fuzzy pair of gonads, swaying beneath him, each normally about 3 inches across.\n\n");
	outputText("Zenji remains fixated on surveying your camp as you examine him, \"<i>If ya want to get a little closer ya don' hafta ask.</i>\" He says giving you a gentle pat on the shoulder.\n\n");
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
	addButton(5, "Showoff", loverZenjiShowoff).hint("Have Zenji display his strength for you to admire.");
	addButton(6, "Comfort", loverZenjiComfort).hint("Spend a tender moment with him. Now with free headpats.");
	if (player.statusEffectv1(StatusEffects.ZenjiModificationsList) == 0) addButton(7, "Food", loverZenjiFood).hint("Zenji seems like he has something he wants to give you.");
	else addButtonDisabled(7, "Food", "Zenji does not have any more food to offer you right now, ask again tomorrow.");
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
	doNext(camp.returnToCampUseOneHour);
}

public function loverZenjiTalksTrolls():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("You ask Zenji what he can tell you about trolls, he doesn’t resemble the ones you’ve read from any books.\n\n");
	outputText("\"<i>Dere's many kinda trolls, tink of it like alraune, each one may be similar way back den, but know dey've split into different kinds, ya know? My troll village grew used to da jungle we lived in, plenty of shade and cold nights, ma fuzz is great at keeping warm and hiding in de trees of da jungle, da other trolls never saw me coming haha!</i>\"\n\n");
	outputText("He pauses for a moment, \"<i>But de other trolls in my village didn't like me too much, I caused trouble, I sought competition, when dey wanted peace and quiet, so I left. I didn't see many oda trolls out dere, but they’re probably not in de bog where I spent most of my time.</i>\"\n\n");
	outputText("Zenji spends the rest of the hour talking about trolls and other nuances about his kind from the other trolls.\n\n");
	if (player.statusEffectv1(StatusEffects.ZenjiPreparationsList) < 15) player.addStatusValue(StatusEffects.ZenjiPreparationsList, 1, 1);
	doNext(camp.returnToCampUseOneHour);
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
	doNext(camp.returnToCampUseOneHour);
}

public function loverZenjiShowoff():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("You eye Zenji’s form up and down. At just 8’2”, he stands proud as ever, his impressive, chiseled musculature and tall stature stands with very little clothing obstructing your view.\n\n");
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
	menu();
	addButton(1, "Yes", loverZenjiShowoffYes);
	addButton(3, "No", loverZenjiShowoffNo);
}
public function loverZenjiShowoffNo():void {
	outputText("You tell Zenji that you’d rather not take up on the offer.\n\n");
	outputText("\"<i>Ah, well, I’ll always be here if ya need anything… </i>\" He replies.\n\n");
	outputText("You decide to take your leave for the time being.\n\n");
	doNext(camp.returnToCampUseOneHour);
}
public function loverZenjiShowoffYes():void {
	outputText("The thought is interesting, but what does he mean exactly by “front row seats”?\n\n");
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
	addButton(1, "“Clean”", loverZenjiShowoffYesClean);
	addButton(3, "Leave him", loverZenjiShowoffYesLeaveHim);
}
public function loverZenjiShowoffYesLeaveHim():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("You decide to let Zenji clean himself off, after all, he knows how to maintain himself like nobody else.\n\n");
	doNext(camp.returnToCampUseOneHour);
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
	doNext(camp.returnToCampUseOneHour);
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
	doNext(loverZenjiTalks);
	cheatTime2(5);
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
	player.addStatusValue(StatusEffects.ZenjiModificationsList, 1, 1);
	inventory.takeItem(consumables.ZENJI_H, loverZenjiTalks);
	cheatTime2(5);
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
	else addButtonDisabled(1, "GroPlus", "Need 1 GroPlus. (wip tooltip)");
	if (player.hasItem(consumables.REDUCTO)) addButton(2, "Reducto", loverZenjiGiveItemReducto);
	else addButtonDisabled(2, "Reducto", "Need 1 Reducto. (wip tooltip)");
	addButtonDisabled(3, "TrollFig", "NYI");
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
	outputText("You slide your fingers across his muscular arm. It can be hard to notice sometimes, but you can see and feel his bicep veins underneath all the hair. You continue massaging the lotion into his hair, getting a feel for his toned triceps and dense biceps. As you move to his other arm, he raises it for you, flexing his massive biceps, showing off just how muscular he is. As you rub your fingers through his solid arm he gives you a smug grin, hoping to entice you with just the size of his body alone. \"<i>Yeah, I have been working out, as ya can see…</i>\"\n\n");
	outputText("You smirk in response, he can be such a showoff sometimes, but it is kind of cute.\n\n");
	outputText("You rub your hands along his shoulders before working towards his manly pectorals. You feel his pecs twitch slightly at your touch as you apply the cool lotion.\n\n");
	outputText("As your hands reach his collar, you clasp your fingers around the colorful beaded necklace around his neck. It’s simple and doesn’t seem like it’s made with anything too expensive.\n\n");
	outputText("Zenji gives you a gentle smile, \"<i>My mother made dat for me when I was younger, you may touch it, but be careful. It means a lot to me, and I’m lettin’ ya touch it because ya mean a lot to me as well.</i>\"\n\n");
	outputText("You rub beneath his necklace for a moment before you continue groping at his strong, manly pectorals, digging your fingers beneath his soft hair. You search around, you’re not sure if he even has nipples, if he does they’re well hidden behind his hair. You eventually roam your fingers and find the unmistakable form of his areola, you tweak at them gently.\n\n");
	outputText("Zenji flinches, his pectorals twitching in response to your handsy approach, \"<i>Ah! Ten c-cuidado conmigo, flaca. Gentilmente por favor... C-careful...</i>\"\n\n");
	outputText("You gently lower your grasp, but he lifts your [hand] back to his nipple, \"<i>I didn’t tell ya ta stop though…</i>\"\n\n");
	outputText("You snicker in response, gently kneading at his pectorals. Eventually, you continue to his firm abs, they’re denser than stone. You spend a moment, slowly inching down his navel, stroking the darker colored hair just above his groin. Zenji blushes slightly before you move on. You work towards his thick, muscular back. You make a stop beneath his armpits, rubbing your hands through his soft hair.\n\n");
	outputText("Something about his underarms is intriguing to you. Do you want to give his pits a little more attention?\n\n");
	menu();
	addButton(1, "Yes", loverZenjiGiveItemLotionYes);
	addButton(3, "No", loverZenjiGiveItemLotionNo);
}
public function loverZenjiGiveItemLotionYes():void {
	outputText("You rub your fingers beneath his underarms. He brings his hands up behind his head, flexing both of his arms for you.\n\n");
	outputText("\"<i>Ya seem ta like dat, dontcha..?</i>\" Before you can react Zenji has forcefully shoved your face into his armpit. You struggle briefly but quickly come to accept him. \"<i>Go ahead, take a sniff, [player]. Ya know ya want to, I see de way you’ve been eyeing me.</i>\"\n\n");
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
	outputText("He gently strokes the top of your head, his longing gaze set on your eyes. \"<i>Thank you for de lotion, it was a nice present.</i>\" He rubs a hand through his chest tuft, \"<i>I can feel de change already, I like it.</i>\" He grabs your hand, gliding you over his chest as well, \"<i>I hope you'll enjoy it more dan I will though...</i>\" He says giving a soft smirk.\n\n");
	outputText("You tell him that is something for a little later as you slowly pull away from him.\n\n");
	outputText("Alright, alright, jus' tell me when ya want ta do someting later, Dere's someting I need ta check up on. \"<i>Now, what do ya want ta talk about?</i>\" He says, dismissing you.\n\n");
	doNext(loverZenjiGiveItem);
}

public function loverZenjiGiveItemGroPlus():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("You pull out a small needle filled with a blue liquid, “GroPlus” written on the label of it. You tell Zenji that if he's not against it, you'd like to spice up a few things between the two of you.\n\n");
	outputText("Zenji raises an eyebrow as he examines the needle, \"<i>And jus' what didja wanna change?</i>\"\n\n");
	outputText("You consider that for a moment.\n\n");
	menu();
	addButton(1, "Penis", loverZenjiGiveItemGroPlusPenis);
	addButton(2, "Tusks", loverZenjiGiveItemGroPlusTusks);
	addButton(4, "Nevermind", loverZenjiGiveItemGroPlusNevermind);
}
public function loverZenjiGiveItemGroPlusPenis():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("You give him a sultry smile as you stroke his legs, telling him that you think he could be a little bigger downstairs.\n\n");
	if (silly()) {
		outputText("Zenji blushes softly, \"<i>Now, now… You don’t know how hard it is, being a troll looking de way I do…</i>\"\n\n");
		outputText("You tell him that he doesn’t know how hard it is, being a champion looking at a troll looking the way he does.\n\n");
		outputText("\"<i>I can’t help it…” He replies, “I’m not bad… I’m just… written dis way…</i>\"\n\n");
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
		outputText("\"<i>Really?</i>\" He says, giving you an inquisitive look, \"<i>Sure... If that's what you want, then so be it. I was kinda missing my old tusks anyway.</i>\" Zenji reaches a hand up to his lips, pulling them back as he takes the needle in the other hand and injects the liquid into the base of his tusks. He takes a sharp breath as he does so.\n\n");
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
	addButton(4, "Nevermind", loverZenjiGiveItemReductoNevermind);
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
		outputText("\"<i>I guess there's always a reason to look for the good things when given a chance.</i>\" He says with a content smile.\n\n");
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

public function loverZenji1():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("Zenji nods softly, \"<i>Now, what do ya want ta talk about?</i>\"\n\n");
}

public function loverZenji2():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("Zenji nods softly, \"<i>Now, what do ya want ta talk about?</i>\"\n\n");
}

public function loverZenji3():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("Zenji nods softly, \"<i>Now, what do ya want ta talk about?</i>\"\n\n");
}

public function loverZenji4():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("Zenji nods softly, \"<i>Now, what do ya want ta talk about?</i>\"\n\n");
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

public function loverZenjiMainCampMenuLeave():void {
	outputText("You realize that you don’t have anything you need from him at this moment, you apologize and take your leave.\n\n");
	outputText("Zenji gives you a small nod as he dismisses you.\n\n");
	doNext(camp.campLoversMenu);
}

//ZENJI MARRIAGE

public function marryZenji1():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	
}

public function marryZenji2():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	
}

public function marryZenji3():void {
	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	
}

	}
}