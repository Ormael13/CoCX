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
	
	public class ZenjiScenes extends NPCAwareContent
	{
		
		public function ZenjiScenes() 
		{}
	
public function zenjiPerspectiveOnPlayer(changes:Number = 0):Number
{
	flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] += changes;
	if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] > 99) flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] = 99;
	if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] < 1) flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] = 1;
	return flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER];
}

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
	outputText("You turn to your left and see the self proclaimed troll again resting on the tree. He hops down, standing on a couple feet away from you.\n\n");
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
	outputText("You raise your [weapon] and adopt a fighting stance.\n\n");
	outputText("\"<i>Are ya ready ta fight den? Good, show me whatcha got!</i>\"\n\n");
	startCombat(new Zenji());
	doNext(playerMenu);
}

public function part1TrollEncounterFightPCDefeated():void {
	clearOutput();
	zenjiPerspectiveOnPlayer(-4);
	if (player.HP < player.minHP()) {
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
	clearOutput();
	if (player.HP < player.minHP()) {
		outputText("You fall to the ground, bruised and beaten, wounds too severe for you to walk off right now.\n\n");
		if (player.cor < 90) {
			outputText("\"<i>Qué lástima</i>\" He growls, \"<i>Not even worth my time.</i>\"\n\n");
			outputText("He walks off, nowhere to be seen. The world grows hazy as you pass out from exhaustion.\n\n");
			cleanupAfterCombat();
		}
		else {
			outputText("\"<i>Vile creature.</i>\" He growls, \"<i>It’s time ta rid dis world of filth like you. One. By. One.</i>\" He picks up his spear, lining up the tip to your throat before impaing you with one swift motion. You choke, gasping for air, reaching up in desperation. The world grows hazy as you feel reality release its grip on you. The last thing you see is his spear going in for a coup de grâce.\n\n");
			EventParser.gameOver();
		}
	}
	else {
		outputText("You fall to the ground, too aroused to fight any longer, your senses overwhelm you before the masculine scent of his dense musk.\n\n");
		outputText("\"<i>Pathetic.</i>\" He mutters, \"<i>Dat’s all demons like you want, I’d best kill you before you bother someone else.</i>\"\n\n");
		outputText("He picks up his spear, lining up the tip to your throat before impaing you with one swift motion. You choke, gasping for air, reaching up in desperation. The world grows hazy as you feel reality release its grip on you. The last thing you see is his spear going in for a coup de grâce.\n\n");
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
	outputText("You approach him, he looks toward you with bleak defiance. \"<i>I… won't… give up..!</i>\" He sputters, choking on his own blood. \"<i>You will die, scum like you does not deserve to live!</i>\"\n\n");
	outputText("Such bold words for a coward, afterall he was the one who ran away first. You grab him by his tusk, the one covered in a series of rings. His eyes tremble in fear as he tries to shake you off. He is at your mercy, desperately looking toward you, practically begging for mercy with his wordless glance. You ponder how much a troll tusk would be worth if you pawn it, perhaps it’s easier to hold it as a trophy. ");
	outputText("You grip it tightly between your fingers, twisting it around slowly. He howls in agony as you draw more blood from his jaw. It doesn’t take long, twisting, turning and yanking on your prize before you pry it from his maw with an audible snap. The troll howls in pain, tears streaming down his face as you have detached his pride and honor.\n\n");
	outputText("You figure with just how sharp it seems, it’d be a fitting way to end him, with something he seemingly is so fond of. You slide down your trophy down his throat, circling his jugular before impaling him in one swift motion. You withdraw the tusk, it’s engorged in troll blood, another spoil of war. The troll lies dead beneath you, a shame he didn’t put up more of a fight.\n\n");
	inventory.takeItem(useables.TROLL_T, cleanupAfterCombat);
}
public function part1TrollEncounterFightTOTHEDEATHZenjiDefeatedTorment():void {
	clearOutput();
	outputText("You approach the troll, spitting on his face. A true fool, hiding from his problems, not everything can be run from, especially you.\n\n");
	outputText("You pick up the spear that he’s dropped, batting the side of his body, forcing him to roll over. He gives a pained groan each time you ram the length of his own spear against him. You flip over the spear, so that the sharp head is against his skin.\n\n");
	outputText("You have a closer look at him, he definitely seems young, slightly soft features and no signs of age at all. What a naive little creature, so bold, so needy to be put in his place. Thankfully you have already done so.\n\n");
	outputText("You mock him, such a bad and naughty child does not deserve to live. What a young troll he is, he should know better than to run from his problems. The troll seems visibly distressed at you calling him a child. You circle the sharp tip along his cheek, drawing blood as you press his own spear against him, puncturing his skin. He howls in agony as you relish in his pain.\n\n");
	outputText("It’s so clear now, trolls really are cowards, trying to escape from the inevitable. Marae is dead and who’s to blame for that? If only a strong, valiant race that was gifted by her magic were able to save her. Alas it is too late now.\n\n");
	outputText("The troll begins weeping before you as his body relaxes. His will to fight on falters as his eyes begin to close from exhaustion and blood loss. His last moments were of humiliation and sorrow. He lies motionless, dead beneath your feet.\n\n");
	outputText("A shame you couldn’t toy with him more, at least now you can take your prize with ease.\n\n");
	outputText("You reach down, gripping the tusks covered in rings tightly between your fingers, twisting it around slowly. His lifeless body doesn’t react to what otherwise would be an agonizing experience. It doesn’t take long, twisting, turning and yanking on your prize before you pry it from his maw.\n\n");
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

public function part2TrollEncounter1():void {
	
}

public function part2TrollEncounter2():void {
	
}

public function part2TrollEncounter3():void {
	
}

public function part2TrollEncounter4():void {
	
}

public function part2TrollEncounter5():void {
	
}

public function part2TrollEncounter6():void {
	
}

public function part2TrollEncounter7():void {
	
}

		
	}
}