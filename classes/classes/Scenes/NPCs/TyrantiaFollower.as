/**
 * ...
 * @author Canadian Snas
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.BlightRidge.DemonPackBlightRidge;
import classes.Scenes.SceneLib;
import classes.internals.SaveableState;

import coc.view.ButtonDataList;

public class TyrantiaFollower extends NPCAwareContent implements SaveableState
	{
		public static var TyraniaIsRemovedFromThewGame:Boolean;
		public static var TyraniaPostFinalKissScene:Boolean;
		public static var TyraniaSeenFlitzy:Boolean;
		public static var TyraniaAndIzumi:Boolean;
		public static var TyrantiaAffectionMeter:Number;
		public static var TyrantiaFollowerStage:Number;
		public static var TyrantiaTrainingSessions:Number;
		public static var TyraniaThePhalluspear:Boolean;
		public static var TyraniaDriderJuggernautPlate:Boolean;
		public static var TyraniaCorrupteedLegendaries:Number;

		public function stateObjectName():String {
			return "TyrantiaFollower";
		}

		public function resetState():void {
			TyraniaIsRemovedFromThewGame = false;
			TyraniaPostFinalKissScene = false;
			TyraniaSeenFlitzy = false;
			TyraniaAndIzumi = false;
			TyrantiaAffectionMeter = 0;
			TyrantiaFollowerStage = 0;
			TyrantiaTrainingSessions = 0;
			TyraniaThePhalluspear = false;
			TyraniaDriderJuggernautPlate = false;
			TyraniaCorrupteedLegendaries = 0;
		}

		public function saveToObject():Object {
			return {
				"TyraniaIsRemovedFromThewGame": TyraniaIsRemovedFromThewGame,
				"TyraniaPostFinalKissScene": TyraniaPostFinalKissScene,
				"TyraniaSeenFlitzy": TyraniaSeenFlitzy,
				"TyraniaAndIzumi": TyraniaAndIzumi,
				"TyrantiaAffectionMeter": TyrantiaAffectionMeter,
				"TyrantiaFollowerStage": TyrantiaFollowerStage,
				"TyrantiaTrainingSessions": TyrantiaTrainingSessions,
				"TyraniaThePhalluspear": TyraniaThePhalluspear,
				"TyraniaDriderJuggernautPlate": TyraniaDriderJuggernautPlate,
				"TyraniaCorrupteedLegendaries": TyraniaCorrupteedLegendaries
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				TyraniaIsRemovedFromThewGame = o["TyraniaIsRemovedFromThewGame"];
				TyraniaPostFinalKissScene = o["TyraniaPostFinalKissScene"];
				TyraniaSeenFlitzy = o["TyraniaSeenFlitzy"];
				TyraniaAndIzumi = o["TyraniaAndIzumi"];
				TyrantiaAffectionMeter = o["TyrantiaAffectionMeter"];
				TyrantiaFollowerStage = o["TyrantiaFollowerStage"];
				TyrantiaTrainingSessions = o["TyrantiaTrainingSessions"];
				TyraniaThePhalluspear = o["TyraniaThePhalluspear"];
				TyraniaDriderJuggernautPlate = o["TyraniaDriderJuggernautPlate"];
				TyraniaCorrupteedLegendaries = valueOr(o["TyraniaCorrupteedLegendaries"], 0);
			} else {
				// loading from old save
				resetState();
			}
		}

		public function TyrantiaFollower()
		{
			Saves.registerSaveableState(this);
		}

public static function isLover():Boolean {
	return TyrantiaFollowerStage >= 4;
}

public function tyraniaAffection(changes:Number = 0):Number {
	TyrantiaAffectionMeter += changes;
	if (TyrantiaAffectionMeter > 100) TyrantiaAffectionMeter = 100;
	else if (TyrantiaAffectionMeter < 0) TyrantiaAffectionMeter = 0;
	return TyrantiaAffectionMeter;
}

public function firstEncounter():void {
	clearOutput();
	outputText("You decide to visit the ruined battlefield. The great, ruined land is much quieter than normal, and you take the opportunity to look around more than usual. Iron pipes, remains of arcane-looking devices, and bodies...Lots of bodies. This place reminds you of ghost stories from Ignam: Two gods fighting in a God’s battleground, equally matched. They kill each other, and all the spirits of their dead followers remain to settle the score.\n\n");
	outputText("A harsh laugh rings through the air, coupled with the screech of shattering stone. Instinctively, you crouch behind the remains of a shattered wall. Do you investigate?");
	menu();
	addButton(1, "Yes", firstEncounterYes);
	addButton(3, "No", firstEncounterNo);
}
public function firstEncounterYes():void {
	clearOutput();
	outputText("You decide to peek over the wall, and what you see is strange, even for Mareth. What appears to be a spider-mech holding a dick-bladed spear is tearing a group of golems apart. The smaller stone constructs rush the spider-mech, but their arms bounce off the juggernaut’s armor. Upon closer inspection, the spider-mech’s humanoid front is covered with two pairs of giant metal tits, complete with embossed nipples.\n\n");
	outputText("Almost absently, two of its metal legs sink into two downed golems, metal blades cracking the stone with shocking ease. A stone flies past your hiding spot, and you flinch. The rubble under your feet grinds, and as the final golem falls, its head snapped clean off by the giant spider...Woman? She growls, in a low voice.\n\n");
	outputText("\"<i>Okay, Tyrantia, stop playing around with your food. Find that demon cunt who’s been summoning them.</i>\" As she turns towards you, you see the first indication of organic life under all that steel. She wears a half-helm, and her fangs gleam in the sunlight. ");
	outputText("Five purple eyes shine under the helm, wary and alert. Twin horns poke out from holes in her helmet, black as night. She’s clearly heard you move, but as she looks back and forth, she doesn’t seem to know where you are yet.\n\n");
	TyrantiaFollowerStage = 1;
	flags[kFLAGS.TYRANTIA_LVL_UP] = 1;
	flags[kFLAGS.TYRANTIA_DEFEATS_COUNTER] = 0;
	menu();
	addButton(1, "Hide", firstEncounterYesHide);
	addButton(3, "No Hiding", firstEncounterYesNoHiding);
}
public function firstEncounterYesHide():void {
	clearOutput();
	outputText("\"<i>Who’s there?</i>\" She demands, brandishing her Dick from side to side. \"<i>I know you’re here, summoner. Come on out, or I’ll smash more of your toys...then you.</i>\" She sniffs the air, and walks the opposite direction from where you’re hiding. You breathe a sigh of relief, but as you do, you hear the scuttling of arachnid footsteps. Your hiding place, the section of wall, is ripped from the ground, tossed to one side.\n\n");
	outputText("\"<i>So...Who are you?</i>\" Her voice is low, for a woman, but she’s clearly a female...Then again, Mareth has taught you the foolishness of such assumptions.\n\n");
	menu();
	addButton(1, "Fight", firstEncounterYesHideFight);
	addButton(3, "Surrender", firstEncounterYesHideSurrender);
}
public function firstEncounterYesHideFight():void {
	clearOutput();
	outputText("You ready your [weapon], and she sighs. \"<i>Really?</i>\" she shakes her head. \"<i>Fine. Let’s rumble.</i>\"\n\n");
	startCombat(new Tyrantia());
	doNext(playerMenu);
}
public function firstEncounterYesHideSurrender():void {
	clearOutput();
	outputText("You raise your hands, explaining that you don’t want a fight, and that you weren’t the one controlling the golems.\n\n");
	outputText("\"<i>A likely story. You act as if I haven’t fought your kind of cowardly builder-types before.</i>\" She folds her arms, lowering her spear…\n\n");
	outputText("and dodges to one side as another golem comes hurtling through the space her upper body had been in before. She grabs it before it can hit you, spinning the hundreds of pounds of stone like a toy before slamming it into the ground, where it shatters.\n\n");
	outputText("She looks at the golem leg in her hands, looks at you, looks back at the leg...then shrugs. \"<i>Okay, fair enough. Stupid thing wanted to hit you too.</i>\" A demon incubus claws his way out of the ruins, but the spider-giant turns, whipping the golem’s arm at the creature. It crushes the luckless demon’s skull, and she turns back to you, completely unphased.\n\n");
	outputText("\"<i>So...who are you?</i>\" You tell her your name, that you’re a champion from Ingnam, and that you’re no fan of demons either. \"<i>No Kiddin’? Well shit. Name’s Tyrantia. Sorry. I’m a bit busy right now, so why don’t you come back another time, and we’ll get a fresh start, okay?</i>\"\n\n");
	tyraniaAffection(5);
	endEncounter();
}
public function firstEncounterYesNoHiding():void {
	clearOutput();
	outputText("You pop out and hold your hand out. You yell at her to freeze. Surprisingly, she stops in her tracks, tilting her head and staring at you curiously. \"<i>Why?</i>\"\n\n");
	menu();
	addButton(1, "Dunno", firstEncounterYesNoHidingDunno);
	addButton(2, "T. Police", firstEncounterYesNoHidingTPolice).hint("Say you're captain of Titty Police!");
	addButton(3, "Fight", firstEncounterYesNoHidingFight);
}
public function firstEncounterYesNoHidingDunno():void {
	clearOutput();
	outputText("You shrug, not really knowing why you’d do that. She looks at you, dumbfounded, for a second, before bursting into uproarious laughter. A bit of black energy pulses around her, making your cheeks flush, but the laughter dies down quickly. \"<i>Y’know, for a little "+player.mf("guy","gal")+", you have some balls.</i>\" ");
	outputText("You tell her that you’re [name], a Champion from Ignam, but she wheels about. A single demon crawls out from underneath a pillar and she turns, running after him. \"<i>Hey, I’ll talk to you another time!</i>\"\n\n");
	tyraniaAffection(5);
	endEncounter();
}
public function firstEncounterYesNoHidingTPolice():void {
	clearOutput();
	outputText("You declare yourself captain of the titty police. You insist that explosives are illegal and that she turn herself in for having two sets of bomb-ass titties. She drops her Phallus-spear in surprise, looks down at her massive quad breasts, then proceeds to wipe a single tear out of her one non-functioning eye before mustering up a chuckle.\n\n");
	outputText("\"<i>Heh. Heh.</i>\" Her tittering starts slow as it builds into full-on hysterics.\n\n");
	outputText("With the absurdity of the situation, even in a land like Mareth, this is the most amusement you have had in awhile; you can not help but join in. You fall to your knees, laughing so hard your breath escapes from you. As a demon frantically scrambles out from a pillar, throwing itself skyward and away, the two of you laugh even harder, the sight of a seasoned Demon warrior pissing himself as he flees a novel one even for you. She speaks up.\n\n");
	outputText("\"<i>Y’know, you cost me a bounty, shorty.</i>\" She reaches down, ruffling your [hair], \"<i>But I’m not even mad. That was fucking hilarious. I’m Tyrantia, but who are you?</i>\"\n\n");
	outputText("You tell her that you’re [name], a champion from Ignam, and her five functioning eyes light up. \"<i>Oh?</i>\" She gives you a slap on the back. \"<i>Well, you’ve gotta show me what you can do sometime.</i>\" She sobers up a bit. ");
	outputText("\"<i>But not today. I need to find me another demon to fight, and you, "+player.mf("mister","miss")+" ‘titty police’ should find someone else to arrest</i>\" She picks up her spear, giving you a sarcastic salute before striding away.\n\n");
	tyraniaAffection(10);
	endEncounter();
}
public function firstEncounterYesNoHidingFight():void {
	clearOutput();
	outputText("You declare that you came here to find a worthy fight. She blinks, looking down at you in surprise. Behind her, a scrawny-looking demon incubus claws his way out from underneath a ruined pillar, taking to the sky. The spider-woman facepalms, inhaling deeply through her nose.\n\n");
	outputText("\"<i>You just cost me a bounty. I hope you’re ready to pay me back.</i>\" You ready your weapon, and she shakes her head. \"<i>Fine. Have it your way, then. I am Tyrantia, little one.</i>\"\n\n");
	startCombat(new Tyrantia());
	doNext(playerMenu);
}
public function firstEncounterNo():void {
	clearOutput();
	outputText("You decide that anyone having fun in this kind of horrid landscape might not be someone you want to meet. Camp is sounding very good right now, and you sneak away while the sounds of grinding stone echo behind you. ");
	endEncounter();
}

public function postFightOptions(hpVictory:Boolean):void {
	clearOutput();
	if (hpVictory) {
		outputText("The giant Drider falls with a massive <i>thud</i> of impact, her legs splayed out around her. She glares at you, but despite the fire in her gaze, she can’t stand.\n\n");
		outputText("She heaves a breath before speaking up, \"<i>Well…</i>\" Once more, she tries to lever herself up, using her spear as a crutch, but even then, she can’t do much more than get a few legs underneath her before falling again. \"<i>You...Beat me.</i>\" Her upper body is still upright, but her eyes are half-closed. Clearly she gave her all. \"<i>...What now?</i>\"\n\n");
	}
	else {
		outputText("Tyrantia’s shaking legs finally give out, and she drops her phallic spear, both of her meaty hands dropping to her cunt-flap. Ignoring you entirely, she begins to grab at the flap, pulling the steel up and revealing a large-labed, drooling cunny. Wasting no time, she begins jilling herself off, breathing heavily from both exhaustion and arousal.\n\n");
		outputText("\"<i>Fuck, no. Not now, you…</i>\" She moans, her armored chest heaving. Her black aura is nearly gone, but you can see a pink glow coming from her eyes. \"<i>What do you want?</i>\"\n\n");
	}
	LevelingHerself();
	tyraniaAffection(5);
	menu();
	addButton(0, "Heal", postFightOptionsHeal);
	addButton(1, "Kiss", postFightOptionsKiss);
	addButton(4, "Leave", cleanupAfterCombat);
}
public function postFightOptionsHeal():void {
	clearOutput();
	outputText("You shake your head, sitting down beside her massive drider body. Peeling back the armor on one leg, she shudders as you put your hand to her injury. \"<i>No, wait...What are you doing?</i>\" ");
	outputText("She squirms a little, and you pat her leg, encouraging her to stay still. You focus your magic into a basic healing spell, and the chitin begins to knit itself shut. You bring yourself back to her upper body, cupping her chin in your hands. You tell her that since you made her injuries, it only seems fair you fix them.\n\n");
	outputText("\"<i>Really? You’re…?</i>\" She turns her head away from you. \"<i>Why?</i>\"\n\n");
	menu();
	addButton(1, "Nice Person", postFightOptionsHealNicePerson);
	addButton(3, "Sex", postFightOptionsHealSex);
}
public function postFightOptionsHealNicePerson():void {
	clearOutput();
	outputText("You tell her that you didn’t want to hurt her, or leave her unable to defend herself.\n\n");
	outputText("\"<i>...Who says I can’t fight?</i>\" You stifle your response, turning back towards her other injuries. After about an hour, she stands, looking down at you with a conflicted look on her face.");
	outputText("\"<i>...Thanks...You might want to get looked at for Corruption though.</i>\" You give her a questioning look, and she turns away.\n\n");
	tyraniaAffection(10);
	cleanupAfterCombat();
}
public function postFightOptionsHealSex():void {
	clearOutput();
	outputText("You tell her that there are plenty of demons who’d love to get their hands on her body, and that you’d rather keep her to yourself.\n\n");
	outputText("\"<i>Horndog,</i>\" she complains. \"<i>...Thank you, I guess.</i>\" After about an hour, she stands, looking down at you with a conflicted look on her face. ");
	outputText("\"<i>...Thanks...You might want to get looked at for Corruption though.</i>\" You give her a questioning look, and she turns away.\n\n");
	tyraniaAffection(5);
	cleanupAfterCombat();
}
public function postFightOptionsKiss():void {
	clearOutput();
	outputText("You lean in, and kiss the Drider full on the lips. Her eyes widen in shock, but she returns the gesture with surprising gentleness.\n\n");
	if (TyrantiaAffectionMeter > 40) {
		outputText("\"<i>...[name]...</i>\" She greedily kisses you back, her fangs scraping your cheeks, cool against the warmth of her lips, and for a moment, she smiles, almost happy. As you smile back, her horse ears flick, and she leans back, looking away.\n\n");
		outputText("\"<i>[name]...I…</i>\" Her voice is surprisingly soft, almost affectionate. \"<i>Why do you do this?</i>\" She clenches her fists. \"<i>I can’t do this. I just can’t.</i>\" She forces herself to her feet. ");
		outputText("\"<i>[name]...You’re great and all...But I can’t be what you want me to be...Not without hurting you.</i>\" She stands, groaning from her injured legs. \"<i>Just...Stop torturing me with what can’t be.</i>\" You call out to your spider-lady, but she flees,faster than you’ve ever seen her move before. You pick yourself up, try to run after her, but Tyrantia’s gone.\n\n");
		TyrantiaFollowerStage = 1.5;
		endEncounter();
	}
	else if (TyrantiaAffectionMeter > 20) {
		outputText("\"<i>Look...This is cute and all, but I’ve got...things to do.</i>\" She doesn’t push you away, though, and you hold on, slipping your finger underneath her metal plates. A clasp gives way, and she blushes bright red, too weak to pull away, but clearly uncomfortable.\n\n");
		outputText("\"<i>Look...I don’t…</i>\" She shivers at your touch, clearly uncomfortable. \"<i>Just...Stop, okay? Please?</i>\"\n\n");
		menu();
		addButton(1, "Stop", postFightOptionsKissStop);
		addButton(3, "Keep going", postFightOptionsKissKeepGoing);
	}
	else {
		outputText("\"<i>Look, [name], I...Don’t want this, no offense.</i>\" She tries to push back, and you back away. \"<i>Thanks. Look, I’ll be fine. I’ve got shit to do, and…</i>\" She tries to rise, unsuccessfully, and glares at you. \"<i>Just let me be.</i>\"\n\n");
		outputText("You decide to leave the Drider Giantess alone, and give her a gentle goodbye as you head back to camp.\n\n");
		tyraniaAffection(3);
		cleanupAfterCombat();
	}
}
public function postFightOptionsKissStop():void {
	outputText("She sighs in relief, none of her eyes meeting yours. \"<i>Look…[name]. I...I have...Reasons for pushing you away. I’m sorry, I just…</i>\" The giantess looks close to tears, and you find yourself staring at her eyes. ");
	outputText("\"<i>Don’t look at me like that. It’s not you. Marae knows it’s not you.</i>\" She lies there, still, and for a while, says and does nothing while several waves of black energy pours from her horn.\n\n");
	tyraniaAffection(5);
	cleanupAfterCombat();
}
public function postFightOptionsKissKeepGoing():void {
	outputText("You tell her that whatever’s wrong, she can tell you. You kiss her again, and she pushes you away, this time strong enough to dislodge you. She tries to stand, to stagger away, roaring in anger. \"<i>Weak! Stupid!</i>\" She falls again, staying down. ");
	outputText("\"<i>Just LEAVE ME BE!</i>\" She blindly fires a black web at you, missing by a mile. You decide it’s time to leave, and the sobbing giant’s tears fade away behind you as you walk back towards camp.\n\n");
	tyraniaAffection(-5);
	cleanupAfterCombat();
}

public function repeatEncounterBattlefield():void {
	clearOutput();
	outputText("You take a stroll around the battlefield, when a familiar whistle fills your ear. You flatten yourself to the ground as a crude golem, missing several limbs, comes flying past, where your head had been. A familiar battle-cry greets your ears, and you poke your head up to see a familiar, armor-clad Giant Drider going to town on a small group of demons. ");
	outputText("You watch for a minute or so as she stabs, stomps and disembowels with an honest to Gods smile on her face. After she finishes, she sniffs the air, looking over at you. \"<i>Oh...Hey [name]...Did you see that?</i>\"\n\n");
	outputText("You nod, and she looks down at the carnage, then back to you. \"<i>Well...Oh, how rude of me.</i>\" She mock-curtseys, holding an Imp’s arm out for you. \"<i>Here I was enjoying a delicious meal, and I didn’t offer you any.</i>\" ");
	outputText("You raise one eyebrow, asking her if she really eats that shit, and she makes a barfing noise, tossing the arm over one shoulder. \"<i>Hell no. They taste like burnt silk that’s been out in the sun.</i>\"\n\n");
	outputText("You ask how she knows that, and she blushes, waving it off. \"<i>I don’t, I just have an imagination.</i>\" You say nothing, and she blushes more. \"<i>Okay, okay. I tried catching bugs as a kid, took a match to it by accident, and got hungry. It was natural curiosity!</i>\"\n\n");
	outputText("You smile, chuckling at her embarrassment. \"<i>Sure, laugh it up, chucklehead.</i>\" Despite her words, she smiles, fangs out. As intimidating as her visage is, her smile is strangely wholesome, in a weird way. \"<i>Okay, what did you want, [name]? Don’t think you came out here for nothing.</i>\"\n\n");
	if (TyrantiaFollowerStage > 2 && !TyraniaPostFinalKissScene) TyraniaPostFinalKissScene = true;
	if (flags[kFLAGS.IZUMI_MET] > 0 && !TyraniaAndIzumi) TyraniaAndIzumi = true;
	menu();
	if (TyrantiaAffectionMeter > 40) {
		if (TyraniaPostFinalKissScene) addButtonDisabled(0, "KISS", "Maybe time to think on making your base a bit more crowded? ;)");
		else addButton(0, "KISS", postFightOptionsKiss);
	}
	else addButton(0, "Kiss", postFightOptionsKiss);
	addButton(1, "Talk", repeatEncounterBattlefieldTalk);
	if (TyrantiaAffectionMeter >= 15) addButton(2, "Spar", TyrantiaSpar);
	else addButtonDisabled(2, "???", "Req. 15%+ affection.");
	if (TyrantiaTrainingSessions >= 40) addButtonDisabled(3, "Training", "You finished all training session with her.");
	else addButton(3, "Training", TyrantiaTraining);
	if (TyraniaPostFinalKissScene) addButton(4, "Sex", TyrantiaSexMenu);
	else addButtonDisabled(4, "Sex", "Req. special scene after reaching 40%+ affection.");
	if (TyraniaPostFinalKissScene && TyrantiaFollowerStage < 4) addButton(9, "LiveWithMe", TyrantiaLiveWithMe).hint("Take the Spooder home. Do it NOW ^^");
	else if (isLover()) addButtonDisabled(9, "LiveWithMe","She's already in your camp!");
	else addButtonDisabled(9, "???", "Req. special scene after reaching 40%+ affection.");
	addButton(14, "Leave", explorer.done);
}
public function repeatEncounterBattlefieldRe():void {
	clearOutput();
	outputText("The giant Drider laughs. <i>\"Changed your mind, did ya?\"</i> She shrugs, leaning down a little. <i>\"What did you want then?\"</i>\n\n");
	menu();
	if (TyrantiaAffectionMeter > 40) {
		if (TyraniaPostFinalKissScene) addButtonDisabled(0, "KISS", "Maybe time to think on making your base a bit more crowded? ;)");
		else addButton(0, "KISS", postFightOptionsKiss);
	}
	else addButton(0, "Kiss", postFightOptionsKiss);
	addButton(1, "Talk", repeatEncounterBattlefieldTalk);
	if (TyrantiaAffectionMeter >= 15) addButton(2, "Spar", TyrantiaSpar);
	else addButtonDisabled(2, "???", "Req. 15%+ affection.");
	if (TyrantiaTrainingSessions >= 40) addButtonDisabled(3, "Training", "You finished all training session with her.");
	else addButton(3, "Training", TyrantiaTraining);
	if (TyraniaPostFinalKissScene) addButton(4, "Sex", TyrantiaSexMenu);
	else addButtonDisabled(4, "Sex", "Req. special scene after reaching 40%+ affection.");
	if (TyrantiaFollowerStage < 4) addButton(9, "LiveWithMe", TyrantiaLiveWithMe)
		.hint("Take the Spooder home. Do it NOW ^^")
		.disableIf(!TyraniaPostFinalKissScene, "Req. special scene after reaching 40%+ affection.");
	addButton(14, "Leave", explorer.done);
}
public function repeatEncounterBattlefieldTalk():void {
	clearOutput();
	menu();
	//0 - Lab
	addButton(1, "Self", repeatEncounterBattlefieldTalkSelf);
	if (TyrantiaTrainingSessions > 0) addButtonDisabled(2, "FightStyle", "You already can train with her.");
	else addButton(2, "FightStyle", repeatEncounterBattlefieldTalkFightingStyle);
	if (isLover()) {
		if (flags[kFLAGS.TIMES_MET_KIHA] > 0) addButton(3, "Kiha", repeatEncounterBattlefieldTalkKiha);
		else addButtonDisabled(3, "???", "Perhaps if you look around the swamps, you might find someone she might also know...");
		if (DivaScene.instance.status != 0) addButton(4, "Diva", repeatEncounterBattlefieldTalkDiva);
		else addButtonDisabled(4,"???", "Perhaps if you look around the mountains, you might find someone she might also know...");
	}
	addButton(5, "Her", repeatEncounterBattlefieldTalkHer);
	if (isLover() && !TyraniaThePhalluspear && flags[kFLAGS.KONSTANTIN_FOLLOWER] >= 2 && !player.hasStatusEffect(StatusEffects.KonstantinOff)) addButton(10, "ThePhalluspear", talkThePhalluspear);
	if (isLover()) {
		if (flags[kFLAGS.SLEEP_WITH] != "Tyrantia") addButton(12, "Sleep With", TyrantiaSleepToggle);
		else addButton(12, "Sleep Alone", TyrantiaSleepToggle);
	}
	if (isLover()) addButton(14, "Back", TyrantiaAtCamp);
	else addButton(14, "Back", repeatEncounterBattlefieldRe);
}
public function repeatEncounterBattlefieldTalkSelf():void {
	clearOutput();
	outputText("You ask the Drider-Giant what she thinks of you. She tilts her head, folding her legs underneath her. \"<i>Well...You’re fairly small, but strong. I like that. You’re unafraid to fight for what you believe in, and you have no fear of demons or corruption.</i>\" She looks down and away. \"<i>You’re a stand-up person, [name], and don’t forget it.</i>\"\n\n");
	outputText("You thank Tyrantia for her kind words, and take your leave.\n\n");
	endEncounter();
}
public function repeatEncounterBattlefieldTalkFightingStyle():void {
	clearOutput();
	outputText("You ask Tyrantia about her...unique method of fighting. You note that while fighting, she seems to be even stronger than you’ve come to expect from her.\n\n");
	if (TyrantiaAffectionMeter > 30) {
		outputText("\"<i>“Honestly, I was wondering when you’d ask about that.”</i> Tyrantia scratches at her manelike hair with one hand. <i>“Honestly, it’s pretty hard to explain...but I’ll try.”</i>\"\n\n");
		outputText("She takes a fighting stance, holding her Dick out in front of her. \"<i>Ever since I became like this, it’s been a struggle to contain my libido. You know what it’s like around here.</i>\" You nod, and she smiles, swinging her Dick \"<i>One of the ways I’ve found to...reduce the effects of it on my mind...is to indulge...But it’s not the only way.</i>\" Her black aura flares, and she narrows her eyes. \"<i>Taking that lust, that need, and diverting it elsewhere...That’s the key.</i>\" ");
		outputText("She clenches her fists hard, sending quivers up her spear’s length. \"<i>Not ignoring the need in your loins, not trying to let it slide off you...But taking that lust and channeling it into your arms, your legs…</i>\" She takes two steps, punching a rock with her bare hand. The boulder splinters, shattering into shards. \"<i>Do it right, and you’ll be much stronger.</i>\"\n\n");
		outputText("Tyrantia looks down at you, and smiles. \"<i>Did that clear it up for you?</i>\"\n\n");
		outputText("You ask her if the mental training she went through could be used to enhance those not in her unique circumstances. She puts a hand on her chin, humming slightly.\n\n");
		outputText("\"<i>Maybe. Might not be as effective for you as me, but hey, why not?</i>\" She shrugs her shoulders. \"<i>Alright...The first thing you need to do is think dirty...and think</i> really <i>dirty. You need to be able to sustain that for a while...and during fights as well.</i>\" Tyrantia runs you through a series of mental exercises more akin to mental porn than meditation, but taken with the same meticulous, organized manner.\n\n");
		outputText("You thank Tyrantia for her time, and excuse yourself, heading back to camp.\n\n");
		TyrantiaTrainingSessions = 0.5;
		endEncounter();
	}
	else {
		outputText("\"<i>No offense [name], but I don’t really want to talk about it. My fighting style is...Odd. Can we talk about something else?</i>\"\n\n");
		doNext(repeatEncounterBattlefieldTalk);
	}
}
public function repeatEncounterBattlefieldTalkKiha():void {
	clearOutput();
	outputText("<i>“Oh, you wanted to know about her?”</i> Tyrantia shrugs. <i>“We interacted a few times while we were both labrats. Some of the sickos working there had a perversion revolving around their ‘pets’ getting along. So...Yeah, we’ve done some things to each other. None of it was voluntary, but…”</i> She winces. <i>“Honestly, a part of me was genuinely happy when she made her escape...But she also didn’t come back. Can’t really blame her though.”</i> Tyrantia rolls her shoulders. <i>“She’s one hell of a fighter, too. That axe of hers may make it easy to counterattack if she misses, but if her strike lands...say goodbye to whatever limb got hit.”</i>\"\n\n");
	//affection gains (0)
	endEncounter();
}
public function repeatEncounterBattlefieldTalkDiva():void {
	clearOutput();
	outputText("\"<i>“I’d heard about the “Drama Queen” prototype for the Demon’s airforce. Never really thought she’d be so…prissy.”</i> Tyrantia shrugs. <i>“I mean, me and the other prototype…We’re fighters, so you’d expect us to kick some ass and escape…but she acts like an actor in a really bad traveling play.”</i> She chuckles. <i>“Other than that, she’s alright, but the blood-drinking kinda weirds me out.”</i>\"\n\n");
	//affection gains (0)
	endEncounter();
}
public function repeatEncounterBattlefieldTalkHer():void {
	clearOutput();
	outputText("\"<i>Okay...Don’t think I’m that interesting, but...whatever. What do ya wanna know?</i>\"\n\n");
	menu();
	if (isLover() && (LilyFollower.LilyFollowerState || BelisaFollower.BelisaInCamp)) addButton(0, "H U D?", repeatEncounterBattlefieldTalkHerHowUDoing).hint("How U doing?");
	else addButton(0, "L.B.D.", repeatEncounterBattlefieldTalkHerLifeBeforeDemons).hint("Life Before Demons");
	addButton(1, "NoHerm?", repeatEncounterBattlefieldTalkHerNoHerm);
	addButton(2, "Different Parts", repeatEncounterBattlefieldTalkHerDifferentParts);
	if (TyraniaSeenFlitzy) addButton(3, "Goblin", repeatEncounterBattlefieldTalkHerGoblin);
	if (TyraniaAndIzumi) addButton(4, "Izumi", repeatEncounterBattlefieldTalkHerIzumi);
	if (TyrantiaFollowerStage == 4 && DriderTown.DriderTownComplete && TyrantiaAffectionMeter >= 50) addButton(5, "Kids", talkHerKids);
	if (TyrantiaFollowerStage < 4) addButton(6, "LotB", repeatEncounterBattlefieldTalkHerLifeOnTheBattlefield).hint("Life on the Battlefield");
	addButton(14, "Back", repeatEncounterBattlefieldTalk);
}
public function repeatEncounterBattlefieldTalkHerHowUDoing():void {
	outputText("\"<i>Oh…</i>\" Tyrantia gives you a big fuzzy hug. \"<i>I never thought I’d find my family again…But you’re just a miracle worker, aren’t you?</i>\" She chuckles.\n\n");
	if (LilyFollower.LilyFollowerState) {
		outputText("\"<i>Lily’s different…But I can’t really blame her. Apparently she got free from the demons before they corrupted her entirely, but she still…Can be a bit much sometimes. Her preferences are…Kind of deviant for Driders.</i>\" She chuckles. \"<i>Even before the demons, we didn’t tend to be…submissive. Not the women, at least. But at least I know she’s in trustworthy hands.</i>\"\n\n");
		if (DriderTown.LilyKidsPC > 0) {
			outputText("\"<i>Lily’s podlings are rambunctious, to say the least. Sometimes it takes more than one of us to deal with them.</i>\" She thinks for a second.\n\n");
			var choice:Array = [];
			choice[choice.length] = 0;
			choice[choice.length] = 1;
			choice[choice.length] = 2;
			if (player.hasStatusEffect(StatusEffects.CampRathazul)) choice[choice.length] = 3;
			if (flags[kFLAGS.SIDONIE_FOLLOWER] >= 1) choice[choice.length] = 4;
            if (SceneLib.izmaScene.totalIzmaChildren() > 0) choice[choice.length] = 5;
            if (SceneLib.kihaFollower.totalKihaChildren() > 0) choice[choice.length] = 6;
            if (SceneLib.amilyScene.amilyFollower()) choice[choice.length] = 7;
            if (flags[kFLAGS.CAMP_UPGRADES_FISHERY] >= 1) choice[choice.length] = 8;
			switch (choice[rand(choice.length)]) {
				case 0:
					outputText("\"<i>Just the other day, one of them tried to organize an “Imp Fight Club”. Stupid kids captured a few imps, then tried to use the sparring ring to have them fight to the death.</i>\"\n\n");
					break;
				case 1:
					outputText("\"<i>We had an incident where one of them trapped some goblins in their webs, then tried to sneak the little sluts into camp. Apparently they wanted to ‘make a public toilet’ in camp.</i>\" Tyrantia rolls her eyes. \"<i>So yeah, we confiscated Lily’s doujin collection for a while.</i>\"\n\n");
					break;
				case 2:
					outputText("\"<i>So…Apparently putting soap in the campfire is a really bad idea. One of her kids thought it would be funny.</i>\" She winces. \"<i>We had to wash out SO many people’s eyes.</i>\"\n\n");
					break;
				case 3:
					outputText("\"<i>One of them tried to use Ralthazul’s still to make alcohol. Nearly blew the damn thing up.</i>\"\n\n");
					break;
				case 4:
					outputText("\"<i>Some of them got into Sidonie’s wood collection and tried to make a bow. Last I checked, Sidonie was still spanking that one.</i>\"\n\n");
					break;
				case 5:
					outputText("\"<i>Yesterday, they tried to pick a fight with the shark-girl’s kids. It took me, Lily, and Izma"+(flags[kFLAGS.IZMA_BROFIED] == 1?"el":"")+" to break it up, and even then, they wanted to keep going. One of her kids bit me on the ass!</i>\"\n\n");
					break;
				case 6:
					outputText("\"<i>One of them got one of Kiha’s brats mad, and that dragonkin torched some of the silk lines, with our laundry on it!</i>\" Tyrantia rolls her eyes. \"<i>At least Kiha has a good sense of discipline.</i>\"\n\n");
					break;
				case 7:
					outputText("\"<i>Your mouse-girl’s pretty pissed at Lily’s kids right now. Apparently one of them got into the poison she keeps for her darts, and tried to use it on one of those lake cultists.</i>\" Tyrantia laughs. \"<i>Lily sent three of the kids to help Amily find some more herbs for the poison, but she’s still not happy.</i>\"\n\n");
					break;
				case 8:
					outputText("\"<i>One of the kids is working the fishery as a punishment. Apparently they stole one of the nets, and were trying to catch an imp with it.</i>\"\n\n");
					break;
				default:
					outputText("You have encounterd a BUG and i not mean drider-bug but just... BUG. Report to Ormale/Aimozg this (not at all drider) BUG.");
			}
		}
	}
	if (BelisaFollower.BelisaInCamp) {
		outputText("\"<i>Belisa’s exactly the same as I remember. It’s good to see at least one of us wasn’t…changed so much.</i>\" The giantess smiles a little, looking at the ground. \"<i>She still weaves some of the most beautiful things…I never really cared much for weaving, but ever since our hometown was destroyed…It’s nice to know that some of the tribe’s culture survived in her.</i>\"\n\n");
		if (DriderTown.BelisaKids > 0) outputText("\"<i>Belisa’s kids are small, but nimble. I’ve been trying to teach some of them how to fight, but most of them are more interested in learning their mother’s craft.</i>\" She smiles. \"<i>She’s rebuilding the tribe, thanks to you.</i>\"\n\n");
	}
	outputText("Tyrantia pauses, looking up at the sky. \"<i>As for me…? I think I’ve finally found my purpose again. My family, as long as I live, won’t need to fear the demons, or their influence.</i>\" She sighs. \"<i>I’m better at that now, at least. Those fuckheads might have been evil, but they knew how to make a supersoldier.</i>\"\n\n");
	if ((DriderTown.TyrantiaFemaleKids + DriderTown.TyrantiaMaleKids) > 0) {
		outputText("\"<i>...Our kids are happy and safe.</i>\" She gives you a big hug, a single tear going down her face. \"<i>I might be corrupt, but they…They’re not. This meadow formed nearby, and they…Every time I visit them, play with our kids, I feel…Cleaner. I don’t think it’ll cure me, not by a long shot…But they’re counteracting my corrupt aura. As they grow, they’ll only get stronger…</i>\" She looks down at your children, playing in their meadow. \"<i>...Even if I can’t be cured, they’ll make up for my corruption…Just by existing.</i>\" You assure your giantess that she doesn’t need to ‘make up’ for anything. That her corruption aura isn’t her fault.\n\n");
		outputText("\"<i>I know…</i>\" She lets you go, gently shoving you back towards camp. \"<i>Go on, my champion. Make the world a better place, eh?</i>\"\n\n");
	}
	advanceMinutes(15);
	doNext(repeatEncounterBattlefieldTalkHer);
}
public function repeatEncounterBattlefieldTalkHerLifeBeforeDemons():void {
	clearOutput();
	if (TyrantiaAffectionMeter < 30) {
		outputText("\"<i>...Look. I’d rather not talk about that. It’s...A touchy subject.</i>\" Her hands twitch, and she holds them together. \"<i>Can we talk about literally anything else?</i>\"\n\n");
		doNext(repeatEncounterBattlefieldTalk);
	}
	else {
		outputText("\"<i>...I had a family. Look...I don’t like talking about it, cuz I get all sappy...and sappy makes you weak, and...I can’t afford to be weak. Not anymore.</i>\" Her eyes are full of unshed tears. \"<i>[name], You get it, right?</i>\"\n\n");
		menu();
		addButton(1, "Yeah", repeatEncounterBattlefieldTalkHerLifeBeforeDemonsYeah);
		addButton(3, "No", repeatEncounterBattlefieldTalkHerLifeBeforeDemonsNo);
	}
}
public function repeatEncounterBattlefieldTalkHerLifeBeforeDemonsYeah():void {
	outputText("You nod once, putting a hand on her shoulder. You tell your Drider friend that you understand it all too well. You’re the champion of Ignam, and you have a responsibility to the people back home, even if you’ll never see them again, to keep fighting.\n\n");
	outputText("\"<i>I knew you’d get it,</i>\" she says, relieved. \"<i>I’m sorry. Here I am, blathering on, when you’ve lost people too.</i>\"You shake your head, waving it off, and the two of you begin to exchange stories of your adventures. This cheers her up a little, but you can tell her mind is elsewhere. You turn to leave, and she stands as well, wrapping her warm, floofy arms around you.\n\n");
	outputText("\"<i>[name]...Come back sometime, okay? Battlefield seems a bit more bearable when your tiny ass comes around.</i>\" Her eyes watch you leave. \"<i>I L-</i>\" She cuts herself off. \"<i>I left an imp skull back at the rock! Fuck!</i>\" She rushes off into the battlefield.\n\n");
	tyraniaAffection(5);
	endEncounter();
}
public function repeatEncounterBattlefieldTalkHerLifeBeforeDemonsNo():void {
	outputText("\"<i>The fuck do you mean ‘no’?</i>\" Tyrantia seems taken aback. \"<i>You have people at home, back through the portal you guard. You should understand perfectly. What, were you one of those shut-ins who couldn’t stand others or something?!</i>\"\n\n");
	outputText("You shake your head, saying that’s not it.\n\n");
	outputText("\"<i>What is it then?</i>\" She asks, growing frustrated.\n\n");
	outputText("You step in, putting a finger on her lips. During the second or so of shocked silence, you ask her to let you explain. She nods, and sits there, waiting as you tell her about the others you’ve met along your travels. The friends and lovers you’ve made, the burdens that were made easier when they were shared.\n\n");
	outputText("After you finish, she looks down, closing her eyes tight against a wave of tears. \"<i>...Promise me something.</i>\" She looks at you, all five eyes tearing up, and her furry arms wrapped tightly around herself. You take her hands, asking her what she wanted of you. \"<i>Promise me you won’t...Think less of me. I’m still an asskicking, demonslaying badass, okay?!</i>\" ");
	outputText("You nod, holding her hands tight, and she begins to speak, her voice cracking. You occasionally stop to comfort her, or to let her cry it out, but she chokes her way through her story.\n\n");
	outputText("\"<i>I had two little sisters. Both little Driders, like me. I was never this freakishly large, but I was the biggest, oldest and strongest of my clutch. Only a few of our clutches survive, and from a young age, the oldest Drider in the clutch is expected to help look after their little siblings.</i>\" She begins to hiccup, and hesitates. ");
	outputText("\"<i>Momma Oaklee taught us how to weave, to use the silk we made to trade with other settlements...I was never any good at that, my silk always came out a bit...Goopy.</i>\" She smiles down at the ground. \"<i>Belisa was the youngest. She was the best at weaving. She made the nicest...umm...Underwear.</i>\"\n\n");
	outputText("You smile, but she shrugs. \"<i>Hey, Silk underwear was basically a sack full of gems if it was made right.</i>\" Her top half shivers, as if cold, and you insert yourself up close, slipping the latch on her armored top and sliding it aside. You hug the distressed Drider-girl, and she leans her torso into you, hugging you close with her muscular, furry arms.\n\n");
	outputText("\"<i>When a Drider comes of age, we were supposed to go to the ancient egg-cave and breathe in the fumes from the great Deep. After our visions, we would emerge, our shells covered with a darker shade, and we’d be adults in the colony.</i>\" She hugs you tighter, creaking your ribs.\n\n");
	outputText("\"<i>I was going to be a warrior, ready to defend the colony from invaders. Lily? A Huntress, lithe and beautiful, to feed us all when the winter’s cold stopped our farms.</i>\" She begins to cry again, clutching onto you like a drowning woman. \"<i>And Belisa, poor, sweet Belisa...She was going to be our mana weaver. Mom and the elders had been grooming her for years.</i>\"\n\n");
	outputText("You gently press on. And then the demons came?\n\n");
	outputText("\"<i>...Yeah. They came, alright. They came all over the walls, the ceilings, the web-lines, everything.</i>\" Her bad joke does little to ease her mood, and she loosens her grip on you a bit. \"<i>When they broke the gates, half the warriors had already succumbed to the spooge-throwers, jerking themselves off like monkeys. I told Lily to run, to grab Belisa and flee...But it was too little, too late. Lily was taken, right in front of me, as I tried desperately to keep fighting. They came in waves, great, terrible waves that just…</i>\"\n\n");
	outputText("She takes a moment to breathe. \"<i>They tied me down, slathered me in their juices, and made me beg for it...But I never fell all the way, like some of the others. That got some of them thinking. They wanted to turn me into a war machine, wind me up and unleash me onto the world...They got some of that right.</i>\"\n\n");
	if (TyrantiaFollowerStage > 1) {
		outputText("Tyrantia shakes herself, armor pieces clattering loudly. \"<i>But anyways, that’s in the past. Now I’m here…With you.</i>\" She gives you a grin.\n\n");
		advanceMinutes(15);
		endEncounter();
	}
	else {
		outputText("She looks at you, tears in her eyes. \"<i>[name], they...did such terrible things.</i>\" She finally breaks down, and you comfort the desolate Drider any way you can. Ultimately, you can only wait out the tears. After it dies down, and Tyrantia sinks into a shallow, sad sleep, you untie yourself from her grip, intent on going home...until a whisper comes from the ground where you left her.\n\n");
		outputText("\"<i>[name]...please stay? Just for one night?</i>\"\n\n");
		menu();
		addButton(1, "No", repeatEncounterBattlefieldTalkHerLifeBeforeDemonsNoNo);
		addButton(3, "Yes", repeatEncounterBattlefieldTalkHerLifeBeforeDemonsNoYes);
	}
}
public function repeatEncounterBattlefieldTalkHerLifeBeforeDemonsNoNo():void {
	outputText("You gently explain that you have to go back to the portal. Tyrantia cries into her makeshift pillow, but ultimately lets you go. You hear her bitter tears as you head back to your camp.\n\n");
	tyraniaAffection(5);
	endEncounter();
}
public function repeatEncounterBattlefieldTalkHerLifeBeforeDemonsNoYes():void {
	outputText("You lie down beside Tyrantia’s upper half, and she takes your hands in hers. \"<i>Thank you,</i>\"she whispers, kissing you on the lips. Her fangs are out of the way, and you kiss back, a gentle, slow thing. You tell her that you’d never leave her alone like this. This gets a smile from the spider-girl, and she hums a gentle tune as she drifts off to sleep.\n\n");
	tyraniaAffection(10);
	camp.cheatSleepUntilMorning();
	doNext(playerMenu);
}
public function repeatEncounterBattlefieldTalkHerNoHerm():void {
	clearOutput();
	outputText("\"<i>...Herms were almost unheard of before the Demons came.</i>\" She looks down at herself. \"<i>I...of all the insane shit I’ve had to deal with...At least I didn’t become one of them.</i>\" \"<i>Not that there’s anything wrong with that, but...I like not having a second head, y’know?</i>\" She looks at her spear, rolling her eyes. \"<i>Well...A third head.</i>\"\n\n");
	outputText("You grin, cracking a joke about how she still waves her Dick around, and she gives you a laugh, her eyes glistening. \"<i>Okay, ya got me there.</i>\" She rubs the shaft with one finger, the hair on her arms standing up. \"<i>Demons and imps run more often if you run at them screaming ‘I’m gonna shove m’dick down your throat!’, then if you threaten to kill them. Fucking Crazy, the lot of them!</i>\"\n\n");
	outputText("She laughs, but you notice that the laughter doesn’t quite reach her eyes. You idly chat with your Drider comrade for a while, and when you leave, she seems a bit happier than before.\n\n");
	tyraniaAffection(5);
	endEncounter();
}
public function repeatEncounterBattlefieldTalkHerLifeOnTheBattlefield():void {
	clearOutput();
	outputText("\"<i>Honestly, it’s about what you’d expect. Demons all over the place, imps everywhere, those rocky fuckers popping up if there’s even a decent-sized rock left intact...Honestly, it’s a great place to let off steam...Even if it is a bit corrupted.</i>\"\n\n");
	if (TyraniaPostFinalKissScene) outputText("\"<i>Things have slowed down a lot lately…Apparently keeping me busy was their goal.</i>\" She shudders at the thought. \"<i>Now they’re not constantly coming at me, I have…too much time to think.</i>\"\n\n");
	else outputText("Tyrantia rolls her shoulders. \"<i>I don’t even know why the demons come here. There’s stuff to salvage, sure, but nothing worth sending people to die.</i>\" She taps her back legs against the ground. \"<i>At least it keeps me busy, eh?</i>\"\n\n");
	//affection gains
	endEncounter();
}
public function repeatEncounterBattlefieldTalkHerDifferentParts():void {
	clearOutput();
	outputText("You ask about her non-spider parts, and Tyrantia sighs, her horse-ears folding. \"<i>Look, it’s not something I like to discuss. Suffice to say, Demons happened. I trust you not to fuck me when I’m not with it, but…</i>\" She looks down, glaring at the ground, and whispers, so low you can barely make it out. \"<i>I can’t…</i>\"\n\n");
	outputText("You apologize to your Drider friend, patting her leg sympathetically. You tell her that if she isn’t comfortable with it, you won’t pry. You give her leg a hug before heading back to camp.\n\n");
	tyraniaAffection(5);
	endEncounter();
}
public function repeatEncounterBattlefieldTalkHerGoblin():void {
	clearOutput();
	outputText("<i>“Oh, Flitzy? She’s one of the Salon Bitch’s many daughters. Found her wandering around the mountains. ‘Taur tried to rape her, she didn’t want it, and I...Well, you know what I do.”</i> Tyrantia looks mildly embarrassed. <i>“Saved her ass, and we’ve kinda become friends. Gobbos don’t usually care about...Anything besides getting knocked up, but whatever, y’know?”</i> You get the feeling she was going to say something else, but you decide to leave it alone. You thank her for the time, and head back to camp.\n\n");
	tyraniaAffection(5);
	endEncounter();
}
public function repeatEncounterBattlefieldTalkHerIzumi():void {
	clearOutput();
	outputText("<i> “Oh, her? Yeah, she’s a blast! Go up to the mountains sometimes to get eggs if I feel in the mood, and ran into her beating the shit out of a Taur. We hit it off, and she’s the best kind of mate to party with.”</i> She shrugs her massive shoulders. <i>“Sometimes you need a friend to beat the crap out of you, or to lean on, y’know? And there aren’t many people I can lean on.”</i> She smiles. <i>“Some more than others.”</i> She brings a single finger down, touching the tip of your nose. <i>“Boop.”</i>\n\n");
	tyraniaAffection(5);
	endEncounter();
}
public function talkHerKids():void {
	clearOutput();
	outputText("You ask your giantess if she’d ever thought about having a family. She looks down at you, her expression a mix between sadness, amusement, and annoyance. Tyrantia tilts her head, bringing one hand to her chin. You wait patiently for her answer, but you don’t have to wait long.\n\n");
	outputText("\"<i>...Yeah, I have.</i>\" She admits. \"<i>Honestly, I’ve thought about it a lot, the last little while.</i>\" She smiles sadly down at you. \"<i>It’s all your fault, really.\"</i> The giantess sits down on the ground, folding her spider-legs underneath her massive frame. You instinctively hug the giant Drider-girl, and she lets out her little \"<i>Tk-tk-tk</i>\" laugh that she shares with her sisters.\n\n");
	outputText("\"<i>...Look, [name]. I love you...I’d love nothing more than to lay your eggs, watch over them till they hatch, and bring up a new generation of Driders with you.</i>\" Evidently she’s thought about this a lot. \"<i>...I’d really like that.</i>\" Her voice is a bare whisper, and bitter tears begin to fall from her eyes. \"<i>...But I can’t allow it</i>\".\n\n");
	outputText("Surprised, you ask her why not, and she shakes her head, pointing at her horns. \"<i>Look at these, look at me, and then ask yourself why I wouldn’t be willing to have kids.\"</i> You blink, sighing as it clicks.\n\n");
	outputText("\"<i>Yeah. I have a hard enough time dealing with my own shit, [name]. I’m not gonna force that situation on a kid. They…don’t deserve that.</i>\" You reluctantly agree, then a thought occurs to you. You ask Tyrantia about her eggs, how they are specifically. The giantess blushes. \"<i>Well...They’re squishy and soft, not like the Lizans or Harpies. Our people’s eggs were way more susceptible to corruption. That’s why we ended up corrupt in the first place.</i>\" She closes her eyes. \"<i>[name], when I told you I couldn’t be what you wanted me to be, what did you think I meant?</i>\" You hold her close, and you promise Tyrantia that you’ll try to make this work. You tell her that even if you can’t have a family, that you’ll stay with her.\n\n");
	outputText("She sniffles, wrapping her furry arms around you. \"<i>Thank you.</i>\" She gives you a brave smile. \"<i>Hey, if anyone can make this work, it’ll be you, ‘champ’.</i>\" You mock protest at the jab, but you know she’s just kidding. Walking away from your Drider lover, you think of a few people you could see.\n\n");
	if (player.hasStatusEffect(StatusEffects.CampRathazul)) {
		outputText("Ralthazul, the mousey alchemist, is one.\n\n");
		TyrantiaFollowerStage = 5;
	}
	if (player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] != 3) outputText("Jojo could be of some assistance, perhaps.\n\n");
	if (arianScene.arianFollower()) outputText("Arian has purification powers.\n\n");
	tyraniaAffection(5);
	advanceMinutes(15);
	doNext(repeatEncounterBattlefieldTalk);
}
public function talkThePhalluspear():void {
	clearOutput();
	outputText("You ask Tyrantia about her weapon. She takes it in both hands, giving it a once-over. \"<i>Honestly, I hadn’t thought about it that much. I kinda stole it from the demons when I escaped.</i>\" She chuckles. \"<i>Why? Were you interested in trying it out or something?</i>\"\n\n");
	outputText("You tell her that you were interested in obtaining your own Phalluspear. Noting the weapon’s potential for both pain and pleasure, you note it’s a very flexible weapon to have in Mareth.\n\n");
	outputText("\"<i>Well…Normally I wouldn’t encourage people to take after me…But in this case, I kinda get it.</i>\" She looks over towards camp, where Konstantine sits, idly grinding a sword. \"<i>I have no idea how to remake this thing…But maybe he could?</i>\"\n\n");
	outputText("You nod, and the two of you head over to where your resident blacksmith sits. As you approach, Konstantine looks up at the two of you. \"<i>Oh, Tyrantia! How have you been?</i>\"\n\n");
	outputText("She explains that this isn’t a social call, and that the two of you had been looking for a way to recreate her Phalluspear. Konstantine holds his hand out, and your giant lover hands him the weapon.\n\n");
	outputText("\"<i>Ah. This weapon is quite interesting!</i>\" Konstantine declares. \"<i>Yes, I can make it for you…But I’ll need some materials and assistance to do so.</i>\" He ponders for a moment. \"<i>I’ll need 5 LustDrafts, to start. The basis of this weapon’s poison is the same.</i>\" He flicks the weapon’s head, and he nods. \"<i>Two…No…Three metal plates, and some tough silk to make the mechanism. I’ll also need a base to work with. A simple spear should do the trick.</i>\"\n\n");
	TyraniaThePhalluspear = true;
	advanceMinutes(15);
	doNext(playerMenu);
}
public function TyraniaAndFlitzyScene():void {
	clearOutput();
	outputText("As you walk through the forest, you can hear the gurgling of a stream, and the sounds of...voices? Just talking? In Mareth? As you get closer, you begin to pick out the two voices. As you get closer, you can hear the gentle splatter of a waterfall, and two people bathing.\n\n");
	if (TyraniaSeenFlitzy) {
		outputText("You call out, and the Goblin lets out a little ‘eep’. Tyrantia calms her down, and you step out from the foliage. \"<i>Hey [name].</i>\" Tyrantia calls out. \"<i>You have the best timing! Come on down!</i>\"\n\n");
		outputText("The Goblin lets out a little ‘eep’, but as you reveal yourself, they seem to relax a little. You introduce yourself to the naked goblin, telling her that you’re a friend of Tyrantia.\n\n");
		outputText("\"<i>Well, if you’re good with her, then… Then "+(player.hasCock()?"you’re alright with me, stud. Come on in":"I guess you can’t be so bad")+".</i>\"\n\n");
		outputText("You undress "+(player.hasCock()?"getting a lusty grin from the goblin, ":"")+"and join the two ladies in the stream. The stream is quite warm, and you make a comment about it.\n\n");
		outputText("\"<i>Oh yeah, this place is the best!</i>\" Flitzy says, leaning back and stretching her arms. \"<i>The stream’s fed from an underground hot spring about a hundred feet or so thataway.</i>\" She leans back in the water, letting her natural buoyancy keep her afloat as she lounges. \"<i>It’s the kind of place I like to keep to myself…well…except for a few people.</i>\"\n\n");
		outputText("You, Tyrantia and Flitzy make some small talk, until the goblin ducks her head under the water. She comes up with a tube, like a big straw, and launches a stream of water at your face. Taken by surprise, you cover your mouth, and both ladies start laughing. Oh, it’s ON.\n\n");
		outputText("You bring your hands in, splashing Flitzy in retaliation, only to get a burst of water from Tyrantia. Your bath quickly devolves into a splash fight. All three of you, soaking wet and laughing, spend quite some time just playing in the river. Unfortunately, Flitzi hops out of the water, wringing her hair.\n\n");
		outputText("\"<i>Sorry you two. I gotta head back to the Salon. Mom gets pissy if we’re gone for too long.</i>\" You bid your new goblin friend farewell, and as she skips off into the forest, Tyrantia turns to you, a lazy grin on her face.\n\n");
		outputText("\"<i>Gotta say, I like seeing you all wet.</i>\" Your drider giantess seems in the mood for some fun. What do you say?\n\n");
		menu();
		if (TyraniaPostFinalKissScene) {
			if (player.gender > 0) addButton(2, "Sex", TyrantiaSexMenu);
			else addButtonDisabled(2, "Sex", "Not for genderless ones.");
		}
		else addButtonDisabled(2, "Sex", "Req. special scene after reaching 40%+ affection.");
		if (TyrantiaAffectionMeter >= 40) addButton(3, "Flirt", TyraniaAndFlitzySceneFlirt);
		else addButtonDisabled(3, "Flirt", "Req. 40%+ affection.");
		addButton(4, "Leave", explorer.done);
	}
	else {
		TyraniaSeenFlitzy = true;
		outputText("\"<i>And the bitch thinks that just because she birthed me, that she owns me. I mean, the Salon’s not a bad life, all considered, but...There’s more to life than getting knocked up. There just has to be.</i>\" The voice is clearly goblin, and as you crest a small hill, you push through the foliage to behold a bubbling spring in the fork of a river. A goblin stands on a rock on one side of the water, bathing herself in the stream.\n\n");
		outputText("\"<i>Well, if there isn’t, I’m not really living.</i>\" The low voice, the chittering, and the sheer size of the woman leaves no doubt in your mind who’s sharing a bath with this goblin. Tyrantia’s out of her armor for once, leaving her smooth, tan skin on full display. Her entire body is glistening with moisture from the waterfall, and for once, her lips are drawn into something like a smile. She watches her goblin companion hop on one foot, rubbing her other leg with some sort of pad or abrasion.\n\n");
		outputText("She holds a leg out for the goblin woman to hold onto, like a rail, and the goblin takes it happily.\n\n");
		outputText("\"<i>Jeez, I know my life isn’t the greatest, but I keep forgetting...You doing okay?</i>\"\n\n");
		outputText("Tyrantia sighs. \"<i>Well, I met someone else who doesn’t care about...You know.</i>\"\n\n");
		outputText("\"<i>That’s Great!</i>\" The goblin springs towards Tyrantia, trying to hug her...and only ends up hugging one of her massive mammaries. \"<i>I’m happy for you.</i>\" The goblin seems to realize where they are, and turns back to a nearby rock, pulling out a razor. She turns her back towards you, but her stance tells you exactly where she’s shaving: The bush around her goblin pussy. \"<i>I swear, though, Every time She tells me to shave, I want to punch her right in her pregnant belly.</i>\"\n\n");
		outputText("Tyrantia sighs, producing a razor of her own. \"<i>Don’t even get me started on that, Flitz. Don’t complain about shaving around me.</i>\" She begins to run the razor down her spider legs, wincing occasionally. \"<i>Try shaving eight spider legs.</i>\"\n\n");
		outputText("The goblin finishes her task, wincing suddenly. \"<i>I’ve got to go! Mother’s expecting everyone back at the Salon today for a meeting!</i>\" She throws on a set of goblin straps only slightly less revealing than the nakedness she displayed before, sprinting away into the woods.\n\n");
		outputText("Tyrantia continues shaving for a moment, before sniffing the air. \"<i>Okay, pervert. Show yourself.</i>\"\n\n");
		outputText("You decide to come closer, raising your hands in surrender. Seeing you, Tyrantia’s eyes widen, and she covers her waterfall dampened pussy with one hand. \"<i>Y-you?!</i>\" She glares at you, less intimidating than usual, but her size makes up for the compromising situation. \"<i>Why are you-? Why would you-?</i>\" She is clearly very flustered, and the normally serious warrior is on the back-foot.\n\n");
		menu();
		addButton(0, "Apologize", TyraniaAndFlitzySceneApologize);
		if (TyraniaPostFinalKissScene) {
			if (player.gender > 0) addButton(2, "Sex", TyrantiaSexMenu);
			else addButtonDisabled(2, "Sex", "Not for genderless ones.");
		}
		else addButtonDisabled(2, "Sex", "Req. special scene after reaching 40%+ affection.");
		if (TyrantiaAffectionMeter >= 40) addButton(3, "Flirt", TyraniaAndFlitzySceneFlirt);
		else addButtonDisabled(3, "Flirt", "Req. 40%+ affection.");
		addButton(4, "Leave", explorer.done);
	}
}
public function TyraniaAndFlitzySceneApologize():void {
	outputText("You keep your hands up, telling her that you didn’t mean to intrude, and that you were here patrolling, since your camp isn’t far from here. Your explanation seems to pacify the big woman, and she looks you up and down. \"<i>Y’know...Not sure I believe you.</i>\" She shrugs, not caring so much. \"<i>Look...I don’t mind so much if you wanna look. I know I’m sexy.</i>\" She laughs a little, her breasts shaking and sending droplets every which way. \"<i>But Flitzi doesn’t really want to be disturbed while she’s bathing. So thanks for waiting until she’s gone.</i>\"\n\n");
	outputText("You nod, and she flicks her hand. \"<i>Alright, ya lil’ perv. I need to finish up here, and you probably have shit y’need to do. So leave me, please.</i>\" You decide that annoying the giant bathing drider probably isn’t in your best interest, and you excuse yourself, heading back to camp.\n\n");
	endEncounter();
}
public function TyraniaAndFlitzySceneFlirt():void {
	outputText("You tell your Drider-friend that she looks much better without the armor. Her tan face flushes red, and she seems happy with the complement. \"<i>Uh...thanks, [name]. I…</i>\"\n\n");
	outputText("You wade over, still watching your giantess’s reaction. Her voice trails off, watching you intently, blushing as you near her. You run your hand along her shaven leg, commenting on how shiny and smooth it is.\n\n");
	outputText("\"<i>You like it that way?</i>\" She blushes more at your touch. \"<i>...Hey, it’s a bit sensitive right after I shave.</i>\" In response, you move on to the second leg, unshaven. It’s fuzzy, and even though you’re in a waterfall spring, the fur stands on end. Surprisingly, the fur is soft and warm to the touch. Tyrantia fidgets, and you pull your hand away. \"<i>...Do you...Like the fur, [name]? I was thinking of keeping it.</i>\"\n\n");
	menu();
	addButton(1, "Fuzzy", TyraniaAndFlitzySceneFlirtFuzzy);
	addButton(3, "Smooth", TyraniaAndFlitzySceneFlirtSmooth);
	addButton(7, "You Choose", TyraniaAndFlitzySceneFlirtYouChoose);
}
public function TyraniaAndFlitzySceneFlirtFuzzy():void {
	outputText("You tell your Drider lover that you love the warm fuzzy feeling of her arms, and that more of that would be nice. This gets a blush from her, and a sound like chitin on stone as her back legs tap the rock happily. \"<i>Okay.</i>\" She pulls you into a warm, fuzzy hug, rubbing her chin on your forehead...and smooshing your face into her top pair of G boobs.\n\n");
	outputText("\"<i>Well...Anything else you want?</i>\" Tyrantia asks, giving you a warm, almost pure, smile.\n\n");
	menu();
	addButton(1, "Hug", TyraniaAndFlitzySceneHug);
	if (TyraniaPostFinalKissScene) {
		if (player.gender > 0) addButton(2, "Sex", TyrantiaSexMenu);
		else addButtonDisabled(2, "Sex", "Not for genderless ones.");
	}
	else addButtonDisabled(2, "Sex", "Req. special scene after reaching 40%+ affection.");
	addButton(4, "Leave", explorer.done);
}
public function TyraniaAndFlitzySceneFlirtSmooth():void {
	outputText("You say that you like your lovers like you like your pick-up lines. Smooth, silky, and ready to have fun. Tyrantia nods once, and resumes her shaving. For a while, you relax until she’s finished. When she calls, you walk back over, and you run your hands up her silky-smooth legs, getting a shudder every time you touch. ");
	outputText("You ask her, teasingly, whether she’s thinking about something else as well, and she pulls her leg away from you, turning so her naked upper half is facing you head on. Her pussy is soaked, with more than just water, and her nipples are clearly erect. She looms over you, gently pulling your hand to her needy quim. \"<i>What do you think, my little friend?</i>\" She coos. Your Drider giantess is clearly in the mood for some fun. What do you want to do?\n\n");
	menu();
	addButton(1, "Hug", TyraniaAndFlitzySceneHug);
	if (TyraniaPostFinalKissScene) {
		if (player.gender > 0) addButton(2, "Sex", TyrantiaSexMenu);
		else addButtonDisabled(2, "Sex", "Not for genderless ones.");
	}
	else addButtonDisabled(2, "Sex", "Req. special scene after reaching 40%+ affection.");
	addButton(4, "Leave", explorer.done);
}
public function TyraniaAndFlitzySceneFlirtYouChoose():void {
	outputText("You gently push her leg aside, standing on a rock so that you’re face to face with her. \"<i>[name], what are you doing?</i>\" You lean in, putting your forehead against hers, looking into her eyes. You tell her that the choice is hers. That you shouldn’t have a say. Her body is her own. She almost laughs at that. \"<i>Sometimes...I almost believe that.</i>\" You ask her what she means by that, but the Giantess puts a finger on your lips. ");
	outputText("\"<i>[name], you’re so sweet. Thank you. Just...Let me hold you for a bit, okay? No talking.</i>\" You fall silent, and for a time, the only sounds you hear are the gentle burbling of flowing water, the rustle of the leaves...and her heartbeat. After an hour, you pull yourself out of her arms. You tell your spider-lover that you need to get back to the portal. She nods, watching your [ass] as you leave.\n\n");
	tyraniaAffection(10);
	endEncounter();
}
public function TyraniaAndFlitzySceneHug():void {
	outputText("You reach up, wrapping your arms around your Drider giantess.\n\n");
	outputText("\"<i>...[name]?</i>\" Tyrantia’s cheeks are bright red, and she blinks twice before wrapping her furry arms around you. Her muscles are hardened, but the soft fur makes it a surprisingly cozy embrace. Tyrantia holds you tight, slowly edging towards the waterfall. You lean in, bringing your lips to hers as she backs into the flowing water, soaking you both. She sighs, looking into your eyes as she brings you in behind the flowing water. There’s a small cave behind the waterfall, and despite the water dripping from your [skin], it’s warm, almost hot. Your Drider lover is barely able to stand in this place, but she pulls you in, sighing happily.\n\n");
	outputText("\"<i>You know…I honestly didn’t think I’d find someone to bring here.</i>\" She says simply. \"<i>But…I trust you.</i>\" She tightens her grip, sighing heavily as she buries her face in your neck. \"<i></i>\"\n\n");
	endEncounter();
}
public function TyraniaAndIzumiScene():void {
	outputText("You peek inside Izumi’s lair, expecting a fight. You clench your fists, parting the Curtain...and blink your [eyes] in surprise. Sitting there in front of you is Izumi and Tyrantia, the big Oni sitting at her table, the massive spider-lady standing beside the table. The two are sipping a fragrant tea, but at the table is a half-empty bottle of Oni's sake, and some other concoctions. Izumi pours herself more of the tea, mixing a half-cup of rice-wine in with it.\n\n");
	outputText("\"<i>I’m glad you came,</i>\" Izumi says to Tyrantia. \"<i>Not gonna lie, it gets boring up here with just the harpies and ‘Taurs.</i>\"\n\n");
	outputText("\"<i>You’re kidding, right? Better than demons and rocks.</i>\" Tyrantia fires back. \"<i>Besides...You’re one of the only people who has a brain and won’t run from me.</i>\"\n\n");
	outputText("\"<i>You kidding? You look badass, girl!</i>\" Izumi slaps her knee. \"<i>I’m pretty sure you’d be able to make that bitch Sophie forget about egg-laying for a month if you just walked by her!</i>\"\n\n");
	outputText("The two giant women are having a lovely chat over tea and booze. Do you intrude?\n\n");
	menu();
	addButton(1, "Yes", TyraniaAndIzumiSceneYes);
	addButton(3, "No", TyraniaAndIzumiSceneNo);
}
public function TyraniaAndIzumiSceneYes():void {
	outputText("You knock on the stone wall, and both women turn their heads. Izumi grabs her sake bottle, ready to throw, and Tyrantia grabs her Dick, propped up on the wall beside her. Both giant ladies see you. Tyrantia smiles, Izumi smirks, and they lower their weapons. \"<i>Oh, you know Izumi, too?</i>\" Tyrantia asks, and Izumi nods.\n\n");
	outputText("\"<i>Yeah, [name] here has a knack for just walking into trouble.</i>\" She chuckles. \"<i>Walked right into my cave, no cares at all.</i>\" Izumi pulls out a stool for you. \"<i>Come on, [name], I won’t bite...This time.</i>\"\n\n");
	outputText("\"<i>I make no such promises.</i>\" Tyrantia interjects, and the two giant ladies start laughing.\n\n");
	outputText("Despite yourself, you find yourself joining in on the merriment, taking a seat by Izumi’s table. The Oni pours you a cup of tea, and Tyrantia slides over a biscuit.\n\n");
	outputText("The conversation is full of jokes, both bawdy and normal(ish), and the three of you talk about your adventures, leading to a kill-count contest between you and Tyrantia that goes nowhere, leading to an argument over whether or not temporary golems count as kills. After an hour or so, you excuse yourself.\n\n");
	outputText("\"<i>Ah, yes, the brave champion needs to guard their portal.</i>\" Izumi says. \"<i>Well, if you feel the need, go on. I enjoyed this.</i>\"\n\n");
	outputText("\"<i>Me too,</i>\" Tyrantia adds. \"<i>All this talk of battle has made my blood boil. Thank you for the time, Izumi. Always nice to chat.</i>\"\n\n");
	outputText("You head back to camp, a small smile on your face.\n\n");
	tyraniaAffection(5);
	endEncounter();
}
public function TyraniaAndIzumiSceneNo():void {
	outputText("You are content knowing that the giantess has friends to enjoy more than just sexy times with, a valuable and rare thing in Mareth these days. You head back down the mountain and to camp.\n\n");
	endEncounter();
}
public function TyrantiaSleepToggle():void {
	clearOutput();
	if(flags[kFLAGS.SLEEP_WITH] != "Tyrantia") {
		outputText("You ask Tyrantia if she enjoys your hugs. She doesn’t say anything, simply stepping in, wrapping her warm, fuzzy tree trunk-sized arms around you, holding you against her breast.\n\n");
		outputText("\"<i>That good enough answer for ya?</i>\" She asks playfully. You smile, hugging her back, and you ask if she’d be willing to share her bedroll with you. She blinks, one eye at a time, and you smile, asking her if she’d like to wrap her warm arms around you and fall asleep at night.\n\n");
		outputText("You tell Tyrantia that you’d love to wake up and see her face in the morning. This actually gets a blush from the giantess, and she puts you down. \"<i>I...Gosh, that’d be awesome, [name]. Just come by my hutch when you’re feeling sleepy. My door’s always open for my favorite [race].</i>\"\n\n");
		flags[kFLAGS.SLEEP_WITH] = "Tyrantia";
	}
	else {
		outputText("You tell your Drider Giantess that you feel like sleeping alone for now. She gives you a saddened look, nodding once. \"<i>If that’s what you want, [name].</i>\" You thank her for understanding.\n\n");
		flags[kFLAGS.SLEEP_WITH] = "";
	}
	menu();
	addButton(0,"Next", repeatEncounterBattlefieldTalk);
}
public function TyrantiaLiveWithMe():void {
	clearOutput();
	outputText("You ask her about the life she has on the Battlefield. She tells you the usual, mentioning the ‘cave’ you two found, and how she’s taken to living there.\n\n");
	outputText("<i>“It’s a bit cold without you, [name].”</i> She says this with a sultry smile on her face, and you notice that one of her hands is rubbing her armor, flicking the hatch you know leads to her surprisingly tight fuckhole.\n\n");
	outputText("You ask her to kneel down a bit, so you can talk to her properly. She smiles, doing so with a little <i>“tk-tk-tk-tk”</i>. You put a hand on her cheek, and ask her if she’d like to come live with you, by the portal. Her spider eyes blink, one after the other, and she freezes in place. For about a minute, you stand there, patiently waiting for her to process what you just said.\n\n");
	outputText("<i>“Did...Did you just ask…?”</i> She points at you, and you nod. <i>“You just asked me...to…”</i> You nod again, somewhat amused by her reaction. <i>“You want me...to come live with you? In your camp?”</i> You nod again. <i>“You mean...Even after all that bullshit with the demons, and knowing I’m corrupt, and…”</i> Her cheeks flush bright red, and she looks down at you, a big grin starting to form on her face. <i>“You want me to join you at your camp.”</i>\n\n");
	outputText("You nod once more, and she squeals like a little girl, picking you up by the shoulders and squeezing you tight. <i>“This...This is the best day! This is the best day ever!”</i> She runs over to the ‘cave’, tossing her Dick over one shoulder, grabbing a simple bag, stuffed full of survival gear, armor polish and assorted knickknacks, and tossing it onto her shoulder as well. The bag’s around ten feet long, but she just lashes it onto her spider-half like a saddlebag. She spends the next few minutes rushing around, seeing if she’s missing something, rummaging through her hair and generally freaking out. You grab her hand as she passes, asking if she’s alright, and Tyrantia blinks again, realizing that you’ve been waiting.\n\n");
	outputText("<i>“Sorry”</i>, she says sheepishly. <i>“I’m just...You’ve been really great to me, and I don’t want to fuck it up, y’know?”</i> You give her a smile, patting her on the shoulder, and you tell her that she doesn’t need to worry about it. They won’t be alone together. This seems to disappoint her for a moment, but she brightens up quickly.\n\n");
	outputText("<i>“You mean...Even if you’re not there, I won’t be alone?”</i> You smile, cupping her cheek, and you tell your busty spider-lover that she’ll never be alone again, not if you have anything to say about it.\n\n");
	outputText("<i>“[name] ...I’ll never be able to pay you back. I’ll always owe you.”</i> She shakes her head. <i>“If you need me...For anything at all…”</i> She gives you a very direct look. <i>“Anything...You call me, alright?”</i> You nod, and she smiles, her fangs showing clear. The smile on her face is from ear to ear as you take her hand, leading your amazoness spider home.\n\n");
	doNext(TyrantiaReactions);
}
public function TyrantiaReactions():void {
	clearOutput();
	outputText("Tyrantia causes quite the stir among your followers.\n\n");
	if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) AmilyReaction();
	else TyrantiaReactions2();
}
public function TyrantiaReactions2():void {
	if (followerKiha()) {
		outputText("Kiha’s eyes widen in recognition upon seeing the giant Drider. She takes a step forward, but seems to think better of it. Tyrantia sees Kiha, nodding once at the dragon-woman. Kiha looks down, her eyes burning with...Shame? Kiha flies away, her massive wings beating somewhat irregularly. You look up at Tyrantia, and she shakes her head. <i>“I’ll need to talk with her,”</i> she whispers to you. <i>“I’m glad you found her, she needs to stop beating herself up.”</i> You tell her that it’s Kiha. She always is too hard on herself.\n\n");
		outputText("<i>“Heh...Some things never change.”</i> You want to ask more, but you change your mind. If the giantess wants to tell you, she will.\n\n");
	}
	if (DivaScene.instance.status == -1) {
		outputText("Your vampire lover pokes her head out of the tent, catching sight of Tyrantia. The pale woman’s jaw drops, and she covers her mouth. Your Drider lover sees the vampire, and she blinks twice.\n\n");
		outputText("<i>“Drama Queen, that you?”</i>\n\n");
		outputText("Diva shakes her head. <i>“...Don’t call me that.”</i> She turns away. <i>“Thou knowest mine name.”</i>\n\n");
		outputText("<i>“Sorry Diva.”</i> Tyrantia appears genuinely sorry about her slight. <i>“I’m...glad you made it out.”</i>\n\n");
		outputText("Confused, you look between the two ladies. Neither of them seems particularly interested in explaining, but eventually Tyrantia taps you on the shoulder.\n\n");
		outputText("<i>“Come on, I’ll explain later.”</i> You follow Tyrantia away from Diva’s section of camp before the giant Drider woman speaks again. <i>“I’m sure she’s already told you at least a little about her run-in with the demons.”</i> Tyrantia shrugs. <i>“We were held at the same facility. Different projects, but...Our cells were right next to each other.”</i> She doesn't elaborate further.\n\n");
	}
	if (BelisaFollower.BelisaInCamp) {
		outputText("As you lead Tyrantia towards camp, she catches sight of Belisa’s orb of spider-silk. She blinks, eyes widening. The giantess looks at you, shocked speechless. You smile, reaching up to pat her on the hip. She picks you up, placing you on her spider-back. She turns her upper body around to face you, her eyes wet, but a smile on her face.\n\n");
		outputText("<i>“[name], you didn’t tell me one of my people was already living with you.”</i> She doesn’t seem to recognize the dwelling, and you smile, recognizing the opportunity. You ask her if she’d like to meet her, and Tyrantia nods, clearly ecstatic. She bobs up and down on her spider legs, not unlike an overexcited child.\n\n");
		outputText("You lead Tyrantia down to the water’s edge, and call out for your little drider companion. As Belisa rises from the water, she turns to face you, a smile on her face...and both Drider sisters freeze where they are. Belisa forgets to tread water, and her mouth sinks back underneath the river’s surface, breaking the moment as she coughs the water out.\n\n");
		outputText("<i>“Ackpth! Tk-tk-Tk-Tyr!”</i> She struggles to get the word out, still coughing up water as she makes a beeline for the shore. <i>“Tyrantia!”</i>\n\n");
		outputText("Tyrantia, on the other hand, is frozen, as if paralyzed by a basilisk. Her eyes are wide, jaw dropped and her furry arms at her sides. She stares, unbelieving, as Belisa trips over the river’s edge, barely righting herself before taking an adorable faceplant. The comparatively tiny spider-girl rushes towards the two of you, leaping into the air at the last minute.\n\n");
		outputText("She hits Tyrantia at full speed, wrapping both her arms and front spider-legs around her much-larger sister with a massive splat-clang of impact. Despite her incredible speed and massive leap, the impact doesn’t even seem to budge the much larger woman. <i>“Tyrantia? Is that you?! Oh dear sister, I was so worried, I thought I’d never see you again!”</i> Belisa rests her two front limbs on Tyrantia’s spider-half, scuttling closer to gain a bit of extra height. <i>“Tyrra? Sis?! Are you okay?!”</i>\n\n");
		outputText("Tyrantia finally wraps her burly, furry arms around Belisa, her massive chest heaving as she struggles to breathe. She falls to her knees, giving Belisa a chance to finally reach up and remove her older sister’s helmet...and see the changes in her face. <i>“...Belisa…?”</i> The Giantess reaches one arm to touch her sister’s face, her eyes unfocused and distant, lost in some memory. <i>“You...Is this real? Or just another…”</i> Tyrantia seems afraid, and her black horns sputter with tainted energy.\n\n");
		outputText("<i>“No, sister. It’s me. I’m here. I escaped the demons. I ran and hid underwater, just like you taught me.”</i> Belisa can feel the corruption, but doesn’t seem to care, taking her sister’s hand in both of hers. <i>“Remember the little pattern I taught you? The ‘magic’ one?”</i> Tyrantia shudders, taking her other hand and holding her palm out. Tyrantia gently bends her sister’s fingers towards the palm, pinky first.\n\n");
		outputText("<i>“Home in five...Hearth in three...Eggs in one...and the rest…”</i>\n\n");
		outputText("<i>“For me.”</i> Belisa whispers, tenderly. <i>“Sis...You’re home now.”</i> Belisa turns her eyes to you. She begins to tear up herself, but her smile is bigger than you’ve ever seen it, her head bobbing from side to side and her back four legs doing a little happy dance. <i>“This...Means more to me than you could possibly imagine, sweet [name].”</i> She turns back to Tyrantia, wiping the tears from her sister’s eyes. <i>“Let me get her settled, okay? I know you’re busy, and...We have a lot to catch up on.”</i>\n\n");
		outputText("Tyrantia shrugs out of her armor, undoing the clasps of her massive steel plates and letting her black carapace, spider-legs and most interesting to you, her massive quadruple breasts and enticing hole, show to the world. She rolls her shoulders, looking at the river in front of her, the sizable silk orb, and she surveys the camp, her five working eyes glittering with hope.\n\n");
		outputText("<i>“Yeah…”</i> She looks back at you, her eyes shining. <i>“I’m gonna need a bit of time, love...But...This is so much better than I could have dreamed.”</i> She turns back to her sister, wrapping one fuzzy arm around her head, and drags her knuckles along the smaller Drider’s scalp.\n\n");
		outputText("<i>“Gah! Sis! Stop that! Stop the noogie! No! Bad sis!”</i> Despite the words, both sisters are doing little tap-dances with their back spider legs, and they walk off towards the river, hand in hand. It’s moments like these that make you truly feel like a champion.\n\n");
		BelisaFollower.BelisaEncounternum = 5;
	}
	TyrantiaFollowerStage = 4;
	outputText("<b>Tyrantia has joined you as a lover.</b>\n\n");
	if (player.hasKeyItem("Radiant shard") >= 0) player.addKeyValue("Radiant shard",1,+1);
	else player.createKeyItem("Radiant shard", 1,0,0,0);
	outputText("\n\n<b>Before fully settling in your camp, as if remembering something, Tyrantia pulls a shining shard from her inventory and hands it over to you as a gift. You acquired a Radiant shard!</b>");
	endEncounter();
}
public function AmilyReaction():void {
	clearOutput();
	outputText("You come to camp, and see your giant drider standing on the boundary of camp, a very angry mouse-morph standing on a wooden stool, trying to get into her face. <i>“Look, you overgrown insect, you’re not welcome here! I can feel the corruption coming from you!”</i> Amily seethes, ready to throw a dart, but Tyrantia isn’t even mad yet.\n\n");
	outputText("<i>“Look...Just talk to [name]. I don’t really care if you like me, just get out from under my feet.”</i>\n\n");
	outputText("<i>“Under your feet?! Oh, you wish I was there, don’t you, all jizzed up, you demon-spawn?”</i> At that, the first signs of anger appear on Tyrantia’s face. Her five eyes narrow, and her fangs quiver a bit.\n\n");
	outputText("<i>“I am not a demon, rat.”</i> She looms over Amily, lower lip quivering. <i>“I’ve done more to stop the hordes than you, I’d bet. How many demons have you killed?”</i> She hoists her Dick. <i>“I’ve killed Five, seventeen imps, and...shit...How many Golems?”</i> She shrugs. <i>“Fuck it. A lot. And that was today.”</i> She points her Dick at Amily. <i>“Back the fuck off, bitch, or I’ll…”</i> Her black aura flares, and Tyrantia sees you. Her eyes widen, and the Drider flinches. She holds her head, making a visible effort to keep her corrupt aura inside.\n\n");
	outputText("<i>“Just leave me be. You’re lucky that [name] cares about you.”</i> She stomps off towards the battlefield again, and Amily sits down on a log, wiping sweat off her brow.\n\n");
	outputText("<i>“Oh, hey [name]”</i> She calls, seeing you walking towards her. <i>“We need to talk.”</i>\n\n");
	menu();
	addButton(1, "Anger", AmilyAnger);
	addButton(2, "Explain", AmilyExplain);
	addButton(3, "KickTyr", MakeTheSpoodLeaveYouMotherFucker);
}
public function AmilyAnger():void {
	outputText("You stride towards Amily, anger in your gaze. She looks at you, puzzled, but you start to tell Amily off, loudly and angrily. Her eyes widen, and she brings her hand to her mouth, but you continue. You tell Amily that Tyrantia’s here to stay, whether she likes it or not, and that she should be polite to your friends.\n\n");
	outputText("\"<i>She’s Corrupt, worse than any demon I’ve ever seen!</i>\" Amily protests, but you cut her off. You tell her that you know, and that there’s a reason for what you did. Amily backs away sadly, shaking her head.\n\n");
	outputText("\"<i>She’s corrupted you too, hasn’t she?</i>\" Amily looks down at the ground. \"<i>I’m leaving, [name]. Don’t come looking for me.</i>\"\n\n");
	flags[kFLAGS.AMILY_FOLLOWER] = 0;
	flags[kFLAGS.AMILY_CORRUPT_FLIPOUT] = 1;
	flags[kFLAGS.AMILY_VILLAGE_ENCOUNTERS_DISABLED] = 0;
	if (player.pregnancyType == PregnancyStore.PREGNANCY_AMILY) player.knockUpForce(PregnancyStore.PREGNANCY_MOUSE, player.pregnancyIncubation);
	if (player.pregnancy2Type == PregnancyStore.PREGNANCY_AMILY) player.knockUpForce(PregnancyStore.PREGNANCY_MOUSE, player.pregnancy2Incubation, 1);
	doNext(TyrantiaReactions2);
}
public function AmilyExplain():void {
	outputText("You sit down beside Amily, eyes closed. She asks you what’s wrong, and you shake your head. You tell Amily that her words hurt.\n\n");
	outputText("\"<i>What? You’re taking her side? [name], she’s a demon!</i>\"\n\n");
	outputText("You stop Amily there. You tell Amily that no, she’s not a demon, that the Drider-giant is pure at heart, and that’s all that matters.\n\n");
	outputText("\"<i>...That’s a lie, and you know it. I can feel my fur crawl whenever I get anywhere near her! She’s permeated with demon-taint!</i>\"\n\n");
	outputText("You tell Amily that Tyrantia is more than a friend to you. That despite her corruption, she’s never made any unwanted advances, and that she’s earned your respect. You inform Amily that not all those taken by the demons were lucky enough to die on the battlefield.\n\n");
	outputText("\"<i>I know that, all too well! Why do you feel the need to…</i>\" The penny drops, and the mouse-girl looks at you, her cheeks a little green. \"<i>So...The horns and the...Boobs and…</i>\"\n\n");
	outputText("You tell Amily that it’s not your place to tell. That Tyrantia told you what happened to her in confidence, and that you won’t betray her trust...Just as you wouldn’t betray Amily’s. You tell Amily that Tyrantia struggles more than she realizes, and how her words hurt the giant spider-girl a lot because of it.\n\n");
	outputText("\"<i>I’ll...Can we really trust her?</i>\" You remind Amily that the first time you met, she nearly shot a dart at your face, and she looks down and away.\n\n");
	outputText("\"<i>Okay...If you trust her...Then I guess I can at least give her a chance.</i>\" Amily gives you a level glare. \"<i>But if I suddenly find that stupid-looking spear of hers anywhere near my ass, I’m leaving!</i>\" She walks towards Tyrantia’s hutch, a conflicted look on her face. You watch as Amily knocks on the door, and Tyrantia opens it, tears running down her face. Amily’s eyes widen, and you watch as she produces a handkerchief from a pocket in her raggedy clothing, giving it to the giant Drider. The two begin to talk, and you turn away, confident that they at least won’t start killing each other.\n\n");
	doNext(TyrantiaReactions2);
}
public function MakeTheSpoodLeaveYouMotherFucker():void {
	outputText("You nod, telling Amily that if she bothers her that much, she has to go. You tell Amily that she matters to you a lot. Amily hugs you happily.\n\nYou go over to Tyrantia’s hutch, a frown on your face. She sees this, and closes her eyes. \"<i>You want me gone...don’t you?</i>\" You protest, but her corruption Aura flares. ");
	outputText("\"<i>Don’t LIE to me!</i>\" You take a step back, instinctive fear, and this, more than anything else, seems to break the giantess. \"<i>so...All that time...All the help you gave me...You didn’t really want me. Not as someone you could stay with, or trust, or…</i>\" Tyrantia packs up her saddlebags, leaving her spear in the hutch. \"<i>Don’t say anything, [name]. You won’t be bothered by my face again.</i>\" She walks out into the wilderness, heading right back towards the battlefield...Without her weapon. You realize that you can see her carapace, she’s not wearing her armor, either. She runs into Mareth, leaving you behind. You know you’ll never see her again.\n\n");
	TyraniaIsRemovedFromThewGame = true;
	endEncounter();
}

public function TyrantiaSpar():void {
	clearOutput();
	outputText("Tyrantia looks down at you in mild disbelief. She seems to take a few seconds to understand what you’ve just asked.\n\n");
	outputText("<i>“Look, [name]...Look at me.”</i> She gives you a stare, somewhat concerned, as she spreads her arms wide. The fur on her arms can’t fully conceal the massive muscles you know are there. Her metal leg-spikes, still on, leave indents in the ground where she moves. Tyrantia stands over fourteen feet tall, and the twin horns on her head buzz with the corrupt aura you know she keeps suppressed. Despite her intimidating stature, her five purple eyes are soft, unsure. <i>“...I don’t want to hurt you. I know you can handle yourself against those demon filth, but...They made me stronger, and…”</i> Tyrantia closes her eyes. <i>“Are you sure you want me to fight you?”</i>\n\n");
	menu();
	addButton(1, "Yes", TyrantiaSparYes);
	addButton(2, "No", isLover() ? TyrantiaAtCamp : repeatEncounterBattlefieldRe);
}

public function TyrantiaSparYes():void {
	clearOutput();
	outputText("You tell her that you want to get stronger, and if that means fighting someone like her, then so be it. She glances down, and you smile up at her, adding that you trust her more than she realizes.\n\n");
	outputText("<i>“Very well…But one more question. I can fight you like we’re sparring…or if you really feel like you can take it…We can go all out.”</i> Tyrantia really doesn’t seem to like the second option, but she offers it, nonetheless.\n\n");
	menu();
	addButton(1, "Spar", TyrantiaHoldsBack);
	addButton(2, "Fight", TyrantiaAllOut);
}

public function TyrantiaHoldsBack():void {
	clearOutput();
	if (isLover()) {
		outputText("Tyrantia nods, her full lips set into a line. She strides over to her hutch, and comes back out carrying her Dick. Her quadruple tits are hidden once more behind a layer of thick black steel, and she levels the phallic spear at you. You can see the pinkish venom pooling on the tip, and she brandishes the weapon with smooth, swift movements.\n\n");
		outputText("<i>“Come on then, [name], show me what you’re made of!”</i>\n\n");
	}
	else {
		outputText("Tyrantia points to a nearby flat area, the rocks swept aside. You join her there, and her eyes glow as she levels her spear, spreading her legs out into a wide stance. You notice she isn’t putting much weight on her front legs, and you suspect she’s just as ready to strike with those as with her Phallic Spear.\n\n");
		outputText("<i>“Show me what you’ve got!”</i>\n\n");
	}
	player.createStatusEffect(StatusEffects.SparingTyrantia,0,0,0,0);
	startCombat(new Tyrantia());
	doNext(playerMenu);
}

public function TyrantiaAllOut():void {
	clearOutput();
	if (isLover()) outputText("Your Drider companion sighs heavily. <i>“Well…Don’t say I didn’t warn you.”</i> She leads you out of camp, back to the battlefield, not far from where you’d first met her.\n\n");
	else {
		outputText("Tyrantia points to a nearby flat area, the rocks swept aside. You join her there, and her eyes glow as she levels her spear, spreading her legs out into a wide stance. You notice she isn’t putting much weight on her front legs, and you suspect she’s just as ready to strike with those as with her Phallic Spear.\n\n");
		outputText("<i>“Show me what you’ve got!”</i>\n\n");
	}
	player.createStatusEffect(StatusEffects.SparingTyrantia,1,0,0,0);
	startCombat(new Tyrantia());
	doNext(playerMenu);
}

public function TyrantiaLostSparring(hpVictory:Boolean):void {
	clearOutput();
	if (hpVictory) outputText("Tyrantia is driven back by your last attack, and she holds up a single hand in a classic ‘stop’ gesture. Her armor battered, she sighs heavily. <i>“That’s enough.”</i> Her black aura flickers, and Tyrantia shudders. <i>“I…Don’t want to continue.”</i> She takes her head in both hands, letting her spear fall to the ground.");
	else {
		outputText("The giantess groans, her spider-legs shaking. Now drooling from her cunt-flap, she slowly falls, resting her lower-half on the ground. She shakes her helmet off, cheeks bright red as she flicks her flap aside.\n\n");
		outputText("<i>“Gods…Damn it…”</i> She whispers, looking at you. <i>“Stupid Sexy asshole.”</i> Another full-body shudder wracks your giantess. <i>“Well…If you’re going to fight like this…Least you could do is help me deal with it after.”</i>\n\n");
	}
	LevelingHerself();
	cleanupAfterCombat();
}
private function LevelingHerself():void {
	if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
		if (flags[kFLAGS.TYRANTIA_DEFEATS_COUNTER] >= 1) flags[kFLAGS.TYRANTIA_DEFEATS_COUNTER]++;
		else flags[kFLAGS.TYRANTIA_DEFEATS_COUNTER] = 1;
		if (flags[kFLAGS.TYRANTIA_LVL_UP] < 4 && flags[kFLAGS.TYRANTIA_DEFEATS_COUNTER] >= flags[kFLAGS.TYRANTIA_LVL_UP] + 9) {
			var addToV1:Number = player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * flags[kFLAGS.TYRANTIA_DEFEATS_COUNTER];
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers5)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers5, 1, addToV1);
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers5, addToV1, 0, 0, 0);
			flags[kFLAGS.TYRANTIA_DEFEATS_COUNTER] = 0;
			++flags[kFLAGS.TYRANTIA_LVL_UP];
		}
	}
}

public function TyrantiaTraining():void {
	clearOutput();
	outputText("You ask Tyrantia to teach you more of her odd mental training. She nods, lowering her spider back-half to the ground and beckoning you over.\n\n");
	outputText("\"<i>Alright...So here’s what we’re going to do.</i>\" Tyrantia hefts a massive rock in each of her meaty palms. \"<i>You’re going to take these, and follow me, holding your arms out like this.</i>\" She holds her arms out to the sides, and you mimic the motion. Satisfied, the giantess puts her rocks down, rummaging about for a moment.\n\n");
	outputText("She puts two smaller rocks into your hands, and you immediately begin to feel your arms burn. \"<i>Now, you’re going to close your eyes. Start in your head, the image of a perfect sex partner.</i>\" You hear Tyrantia’s steel-clad feet scuttling in closer. \"<i>The look on their face is clear what they want from you.</i>\" You nod, eyes still closed. \"<i>They have no intention of letting you leave…</i>\"\n\n");
	if (player.gender == 3) {
		outputText("\"<i>As they get closer to you...Which do they go for?</i>\"\n\n");
		menu();
		addButton(1, "Dick", TyrantiaTrainingDick);
		addButton(3, "Pussy", TyrantiaTrainingPussy);
	}
	else {
		if (player.hasCock()) TyrantiaTrainingDick();
		else TyrantiaTrainingPussy();
	}
}
public function TyrantiaTrainingDick():void {
	outputText("\"<i>Your partner kneels in front of you, lowering your [armor] to the floor. They take your mighty tool...Gripping it in both hands...Wait…</i>\" You open your eyes, to see Tyrantia, hands on your [cock].\n\n");
	outputText("\"<i>Part of the training,</i>\" she says sheepishly. \"<i>Easier to keep your mind in the gutter.</i>\"You suspect that Tyrantia just wanted to get some action, but you mentally shrug, closing your eyes again. Almost immediately, you feel your [cock] being pumped, slowly but firmly. Your mental image pops back into place...but the burning in your arms blurs your partner, making it extremely hard to concentrate. You begin to go flaccid, the pain in your arms overwhelming, but Tyrantia’s lips wrap around your [cockhead].\n\n");
	outputText("Your mental image all but lost, you grunt, struggling to keep your arms up and your [cock] hard, but even with your Drider-trainer’s lips running up and down you, the pink haze in your mind is quickly overwhelmed by the red of pain. You gasp, snapping back to reality, dropping the rocks and gasping for air.\n\n");
	outputText("As you open your eyes, Tyrantia lets out a disappointed groan around your [cock], pulling her lips off you. Clear pre oozes from your [cockhead], but no release.\n\n");
	TyrantiaTraining2();
}
public function TyrantiaTrainingPussy():void {
	outputText("\"<i>Your partner gives you a wicked smirk, eyes smoldering. You feel them yank your [armor] down, and you feel their head slide between your [legs], finding your [pussy]. You feel them slide a long tongue past your labia, your clit trembling at the moist entrance…</i>\" You open your eyes. Did Tyrantia just go down on you? You look down, and to your surprise, you can see her shoulders rubbing gently against your thighs.\n\n");
	outputText("\"<i>Stay standing.</i>\" Tyrantia says firmly. \"<i>This is part of the training.</i>\"You can feel her tongue move inside you, and you shudder, closing your eyes again. Your arms, still held out, are burning...but so is your pussy, as Tyrantia nibbles your clit. Your knees shake, and your breathing quickens, but Tyrantia grabs your thighs, holding them as she ravages your cunt with her tongue. Your mental image all but shattered, you groan, trying to remain standing, the rocks on your arms slowly forcing them down. You let out a girly cry, arms finally dropping, and Tyrantia immediately stops eating you out.\n\n");
	outputText("You lean against a nearby rock, breathing heavily, and Tyrantia stands back up, clear fluid on her lips. She licks it off, but her expression isn’t lustful, it’s...almost clinical.\n\n");
	TyrantiaTraining2();
}
public function TyrantiaTraining2():void {
	if (TyrantiaTrainingSessions == 4 || TyrantiaTrainingSessions == 9 || TyrantiaTrainingSessions == 14 || TyrantiaTrainingSessions == 19 || TyrantiaTrainingSessions == 24 || TyrantiaTrainingSessions == 29 || TyrantiaTrainingSessions == 34 || TyrantiaTrainingSessions == 39) {
		outputText("Tyrantia nods approvingly. \"<i>Good job. I think you’re ready for the next technique.</i>\" Tyrantia sits down with you, the two of you both activating your Overlust. She takes you through several drills, and focusing on them and not her is extremely difficult. At the end, however, you notice your black and pink aura has thickened a bit.\n\n");
		if (TyrantiaTrainingSessions == 4) {
			outputText("<b>You have learned: Tyrant State ability.</b>\n\n");
			player.createStatusEffect(StatusEffects.KnowsTyrantState,0,0,0,0);
		}
		if (TyrantiaTrainingSessions == 9) outputText("<b>Tyrant State bonus to melee damage increased by 20%.</b>\n\n");
		if (TyrantiaTrainingSessions == 14) outputText("<b>You have gained new magic special: False Weapon - costs 10% of your max Lust and 100 Fatigue and lasts until the end of combat.</b>\n\n");
		if (TyrantiaTrainingSessions == 19) outputText("<b>You can now use toggle to turn on/off auto-cast of Tyrant State at the combat start.</b>\n\n");
		if (TyrantiaTrainingSessions == 24) outputText("<b>You have gained ability to take less physical and lust damage the closer you're to the maximum lust. (20% at 50% Max Lust, up to 70% at max)</b>\n\n");
		if (TyrantiaTrainingSessions == 29) outputText("<b>You can delay your own defeat by Lust for two turns. Reducing your own Lust below the max will reset the timer.</b>\n\n");
		if (TyrantiaTrainingSessions == 34) outputText("<b>Constant Buildup - If you are in Rut or Heat, halve the lust DoT you take from it, and deal an additional 20% physical damage while under the effects.</b>\n\n");
		if (TyrantiaTrainingSessions == 39) {
			outputText("<b>Mental Bastion - The effects of Tyrant State are doubled: While active, you take 30% less damage from magic. You count as either pure or corrupt (whichever is better) for equipment. (Pure for the Beautiful weapons etc, corrupt for corrupt weapons)</b>\n\n");
			
		}
	}
	else {
		outputText("Tyrantia considers your state, shaking her head.\n\n");
		outputText("\"<i>It’s a good effort, [name], but you’re having trouble keeping yourself centered.</i>\" She smiles. \"<i>I’m sure you’ll get it soon...but I’d also get that lust seen to. It doesn’t pay to go around pent up.</i>\"\n\n");
	}
	if (TyrantiaTrainingSessions == 0.5) TyrantiaTrainingSessions = 1;
	else TyrantiaTrainingSessions += 1;
	player.lust += Math.round(player.maxLust() * 0.3);
	player.dynStats("sen", -1);
	player.dynStats("cor", 1);
	statScreenRefresh();
	endEncounter();
}

public function encounterBattlefieldAfter40Affection():void {
	clearOutput();
	outputText("You walk to the battlefield, heart heavy. It’s been a while, but the battlefield is even more quiet than usual, clouds hanging low in the sky. You sit down inside one of the ruined slabs of odd stone, taking a break from your walk, when you hear footsteps. A lot of footsteps. You instinctively hide under one of the slabs of ruined stone.\n\n");
	outputText("<i>“Company...HALT!”</i> You peek your head out and see two demons, an Incubus in a lab coat and a Succubus in revealing armor, leading a platoon of similarly clad demons. <i>“Alright, what’s the sitch, bitch?”</i> He asks into an odd square device he pulls from his belt. A female, high pitched voice speaks from the boxy thing. <i>“We found her, sir. Project Screwed Earth is not only alive, but she’s the one who’s been tearing apart our summoners here.”</i>\n\n");
	outputText("<i>“That Bitch. How big is she now?”</i> He grins at the news, however, a sickly satisfied smirk.\n\n");
	outputText("<i>“At least Fourteen feet. Tall.”</i> The voice from the other end is a mix between scared, impressed and lustful. The commander of the demons grins. <i>“So...It worked. Hah! Lethice will be pleased.”</i> Lethice?! Now you HAVE to know what’s going on, even if it wasn’t about who you think it is. But...Project Screwed Earth? What did those demons DO to her? The demons move out, and you stealthily follow them. Apparently, these are not the first demons to come after her today. You hear roars of anger, the clash of steel, and the moans of the debilitatingly aroused. You peer owlishly at the battleground, and what you see isn’t surprising, but it still takes you aback.\n\n");
	outputText("Over three dozen demons lie dead, in various states of dismemberment. Another two-dozen form a circle around their target, black magics on their fingertips. Even more roll around on the ground, masturbating feverishly as they can’t hold on.\n\n");
	outputText("Lust spills from the giant being in the center, in sickening black waves. A dick-shaped spear clutched in both hands, Tyrantia, her helmet gone, her scarred face splattered with blood, pants heavily. Thin trails of moisture drip from the armor-flap on her front, and her violet eyes are partly closed.\n\n");
	outputText("<i>“I must say, I’m impressed.”</i> The scientist walks slowly towards the ring. <i>“You’ve come a long way since the project’s start.”</i> He smiles. <i>“That aura, that corruption..and that strength. Truly a work of art!”</i>\n\n");
	outputText("<i>“Pr-project?”</i> Tyrantia’s eyes focus on the demon. <i>“N-no...Not you. Anyone but…”</i>\n\n");
	outputText("The demon commander grins lecherously, spreading his labcoat’s front and revealing what looks like a cross between a throbbing demon erection and a tail. He swings it like another limb, spreading pre-cum around him. <i>“So, you remember me? Not surprising. You and I had such fun together, remember?”</i>\n\n");
	outputText("<i>“No. You...You hurt me. You…”</i> Your Drider giantess is backing up, fear on her face.\n\n");
	outputText("<i>“And here I remember you asking for it...Begging for it. Do you still want it, Tyrantia?”</i> He pulls his pants down. Tyrantia licks her lips, the flap covering her pussy quivering, but snaps out of it.\n\n");
	outputText("<i>“No! I broke free! Get away from me!”</i> Tyrantia backs up, her hands shaking.\n\n");
	outputText("The demon scientist laughs at that. <i>“Oh, my dear, you think you broke free? Then why did you never stray far from the battleground? You think you were ever out of our grasp?”</i> The demon scientist smiles. <i>“We let you free, to see what you’d do. You performed exactly as we expected. You killed some schmucks, corrupted the landscape around you...And you even made some of Mareth’s pure-hearted champions feel sorry for you. Were they enough to satisfy that thirst we gave you? Even close?”</i>\n\n");
	outputText("The fire in your Drider friend’s eyes begins to die down. Her legs shake, and she looks down at the ground. Between the lust magic covering her, the cuts and bruises, she looks about to give up. Her arousal leaks down the sides of her frontmost legs in a near-constant stream.\n\n");
	outputText("<i>“That’s it, my pet. Return to your rightful place. You’ll get the reward you want, too.”</i>\n\n");
	menu();
	addButton(1, "StayHidden", TyrantiaLetDieYouMonster);
	addButton(3, "JumpIn", TyrantiaSaveFight);
}

public function TyrantiaLetDieYouMonster():void {
	clearOutput();
	outputText("You watch as the fiery light that was always in your Drider companion’s eyes leave them for good. The commander demon’s dick expands, moving like a third arm as it flicks aside the hatch covering her spider-pussy. He begins pistoning in and out, and as Tyrantia silently orgasms, her legs folding, a blackened piece of lethicite, nearly as large as one of her boobs, comes out with it. The commander demon sighs happily, taking it and swallowing the crystal. The demons walk away, leaving Tyrantia’s body lying there on the battleground. As you watch, her body turns jet-black, then begins to dissolve, fading into powder, blowing away in the breeze.\n\n");
	TyraniaIsRemovedFromThewGame = true;
	endEncounter();
}

public function TyrantiaSaveFight():void {
	clearOutput();
	outputText("With a roar of rage, you jump from hiding, bowling through the shocked demons. The commander turns, too late, as you draw your [weapon], striking him hard enough to snap his neck with a single blow. Shocked, the demons take a step back as their commanding officer falls, dead. You turn, putting your back to Tyrantia.\n\n");
	outputText("<i>“[name], what are you doing here?!”</i> She snaps back, alert once more. <i>“Leave me. I’m not worth your life. You...You heard what they said?”</i> You call her an idiot. You tell her that your life is yours to live, and yours to spend. You remind her that she has her mission as well, to find her sisters, and that she can’t do that from the end of a demon’s dick. She looks at you, five eyes focusing, and she grits her teeth in raw anger, her armour visibly rippling as she looks down at her fists.\n\n");
	outputText("<i>“Argh!”</i> She punches the ground, sending tremors through it. Nearby demons lose their footing, but she punches again, cracking the stone of the battlefield and sending stone shards flying. Her cunt drools faster, and the black energy emitting from her stops, reversing its course and covering her body. <i>“Stupid!”</i> The earth shakes again as she slams her fist through a stone the size of your head. <i>“Weak-willed!”</i> She stands, shattering the stone by flexing her wrist. <i>“I’ve...Had...ENOUGH!”</i> Her roars of rage echo throughout the battlefield, and as you watch, in utter awe, her helmet flies from the ground, planting itself back on her head.\n\n");
	outputText("The aura that had once flowed from her, in pulsing waves, now clings tight to her body. Her violet eyes shine brighter, and her black armor pulses with brown light. Tyrantia motions with one hand, and the stones on the battleground form into more spears, complete with the crude phalluses on the tips. <i>“YOU WANNA GET FUCKED?!”</i> She roars, her new, odd aura flaring, the spears rotating, aiming at the demon horde. <i>“LETS FUCKING GO!”</i>\n\n");
	outputText("You notice that there are still a hundred or so demons left, but the one-woman army at your back looks like she could take on the whole damn horde...Something you find surprisingly arousing. You smile at the incoming demons, letting out your own, much quieter, less dramatic war cry, and you charge the demon horde together.\n\n");
	TyrantiaFollowerStage = 2;
	var strTyrantia:Number = 295;
	var meleeAtkTyrantia:Number = 150;
	var intTyrantia:Number = 150;
	strTyrantia *= (1 + (0.2 * player.newGamePlusMod()));
	strTyrantia = Math.round(strTyrantia);
	intTyrantia *= (1 + (0.2 * player.newGamePlusMod()));
	intTyrantia = Math.round(intTyrantia);
	meleeAtkTyrantia += (1 + (int)(meleeAtkTyrantia / 5)) * player.newGamePlusMod();
	player.createStatusEffect(StatusEffects.CombatFollowerTyrantia, strTyrantia, meleeAtkTyrantia, intTyrantia, 0);
	flags[kFLAGS.PLAYER_COMPANION_0] = "Tyrantia";
	startCombat(new DemonPackBlightRidge());
}

public function TyrantiaAfterMainFightLost():void {
	clearOutput();
	outputText("You feel sudden, sharp pain as <i>something</i> hits you in the back of the head. Staggering, you fall, darkness taking your vision.\n\n");
	outputText("You don’t know how much time has passed as you open your eyes, stars floating in your vision. To your groggy shock, you’re still on the battlefield, and the sounds of combat are still ringing. You stagger upright, shaking your head, and what you see surprises you.\n\n");
	TyrantiaAfterMainFightWon2();
}
public function TyrantiaAfterMainFightWon():void {
	clearOutput();
	TyrantiaAfterMainFightWon2();
}
public function TyrantiaAfterMainFightWon2():void {
	clearOutput();
	TyrantiaFollowerStage = 3;
	flags[kFLAGS.PLAYER_COMPANION_0] = "";
	player.removeStatusEffect(StatusEffects.CombatFollowerTyrantia);
	outputText("Only a few demons remain alive, the rest have either fled, and been cut down, or trampled if they try to stand. Lust spell after lust spell bounces off your giantess ally to seemingly no effect. Arrows, whip-cracks, they seem to anger her more than anything else. You cut down an incubus with your [weapon], and turn around. Tyrantia’s lost her armor, her breasts flying free as the metal plate falls...But with no targets left, she’s charging towards you, Dick held high.\n\n");
	menu();
	addButton(1, "Dodge", TyrantiaAfterMainFightDodge);
	addButton(2, "Call Out", TyrantiaAfterMainFightTalk);
}

public function TyrantiaAfterMainFightDodge():void {
	clearOutput();
	outputText("You roll aside, and her spear flashes past, narrowly missing your body. You stand, but she’s already turned around. She charges back towards you, roaring her anger. This time, you sidestep the spear, and before she can react, you jump into the air, wrapping your arms around her upper body. You hug her, clinging on with both arms and [legs], nearly suffocating in her breasts. Slowly, she stops, and as she falls to her knees, you set your feet on the wasted ground.\n\n");
	outputText("<i>“[name]...Are you...Insane?”</i> Despite her words, the Drider-girl is crying, whole body shaking. <i>“What...What if I’d killed you?”</i> You hold tighter, wiping a tear from her eyes. You tell her that you knew she wouldn’t hurt you. Because you trust her. At this, she cries harder, wrapping her furry arms around you and holding you rib-creakingly tight.\n\n");
	outputText("<i>“You...Mean that.”</i> She kisses you, initiating for the first time, and you can all but taste the conflicting feelings in her. <i>“You heard...You heard what they said about me...I corrupt everything I touch. I…”</i> She sags, unable to stay upright. <i>“[name]...I can’t hurt you. Not now…”</i> Her tears fall, bitter, and the battlefield’s overcast skies churn as the wind begins to howl. In the distance, you notice a whirling cloud coming from the desert…A sandstorm? <i>“[name], just being around me could...turn you into one of them. So...Why?”</i>\n\n");
	outputText("You tell her that you don’t care. She opens her mouth, but you kiss her again, shutting her up. You tell her that you said before, your life is yours to spend. And the time you spend together is precious to you, too precious to lose. Tyrantia seems to notice the whirling storm, and you wince as a few grains of sand begin to hit you both.\n\n");
	outputText("The giant shudders, tears falling again, but her lips are curled up into a weak smile. She doesn’t say anything, but as she runs her fangs along the side of your neck, you trust her, not turning away. The scraping of her fangs are gentle, and surprisingly intimate. <i>“Well…”</i> She shivers, the sand bouncing off her carapace. <i>“Where do we go?”</i>\n\n");
	menu();
	addButton(1, "Cave", TyrantiaLovinCave);
	addButton(2, "Camp", TyrantiaCantmakeitRN);
}

public function TyrantiaAfterMainFightTalk():void {
	clearOutput();
	outputText("You hold out a hand, calling out her name as loud as you can. She doesn’t slow down, and you try again, closing your eyes as her Dick stops, mere inches from your chest. Her five working eyes are wide in shock and fear, and her arms are shaking. You gently grab the shaft of her spear, pushing it aside. She tries to back up, holding her arms out, but as you throw your [weapon] aside, she’s not quick enough to avoid you. Your arms wrap around her, and as her knees fold, you pull her head down to yours. You stare, her five eyes to yours, and you smile slightly, reassuringly.\n\n");
	outputText("<i>“[name]...Are you...Insane?”</i> Despite her words, the Drider-girl is crying, whole body shaking. <i>“What...What if I’d killed you?”</i> You hold tighter, wiping a tear from her eyes. You tell her that you knew she wouldn’t hurt you. Because you trust her. At this, she cries harder, wrapping her furry arms around you and holding you rib-creakingly tight.\n\n");
	outputText("<i>“You...Mean that.”</i> She kisses you, initiating for the first time, and you can all but taste the conflicting feelings in her. <i>“You heard...You heard what they said about me...I corrupt everything I touch. I…”</i> She sags, unable to stay upright. <i>“[name]...I can’t hurt you. Not now…”</i> Her tears fall, bitter, and the battlefield’s overcast skies churn as the wind begins to howl. In the distance, you notice a whirling cloud coming from the desert…A sandstorm? <i>“[name], just being around me could...turn you into one of them. So...Why?”</i>\n\n");
	outputText("You tell her that you don’t care. She opens her mouth, but you kiss her again, shutting her up. You tell her that you said before, your life is yours to spend. And the time you spend together is precious to you, too precious to lose. Tyrantia seems to notice the whirling storm, and you wince as a few grains of sand begin to hit you both.\n\n");
	outputText("The giant shudders, tears falling again, but her lips are curled up into a weak smile. She doesn’t say anything, but as she runs her fangs along the side of your neck, you trust her, not turning away. The scraping of her fangs are gentle, and surprisingly intimate. <i>“Well…”</i> She shivers, the sand bouncing off her carapace. <i>“Where do we go?”</i>\n\n");
	menu();
	addButton(1, "Cave", TyrantiaLovinCave);
	addButton(2, "Camp", TyrantiaCantmakeitRN);
}
public function TyrantiaLovinCave():void {
	clearOutput();
	outputText("You notice a nearby cave, made of the odd battlefield stone, more of a stone tent than a cave, but any shelter in a storm. You point, and she nods. Despite her weakness, she’s able to stagger her way to the shelter. Now out of the whirling sand, she collapses, breathing hard. You voice your concern, but her only reaction is to smile. <i>“You’re cute when you’re worried.”</i> She blushes a little, tossing her helmet to one side. <i>“Well...More than usual.”</i> She shivers, and you get to work, building a small fire to warm your improvised shelter. Tyrantia grabs a slab of stone, pulling it across the only entrance. The sandstorm begins to rage outside, battering the improvised door, and she holds her hands to the flames. <i>“Thank you.”</i>\n\n");
	outputText("You shiver as the flame runs low on fuel almost immediately. The whirling sands show no sign of stopping, and she reaches out, pulling you towards her. You don’t resist, and between her frontmost spider legs, her massive, furry arms, and her four giant breasts, almost your entire body is covered by hers. It’s not an unpleasant sensation, and you quickly begin to warm back up.\n\n");
	outputText("<i>“You’re good at holding heat.”</i> She whispers, and you sink into her, soft, warm tits acting as a damn comfortable pillow. You fall asleep in her arms, waiting for the storm to stop.\n\n");
	outputText("The world is silent when you wake. The sandstorm has finally stopped, and outside, the clouds have gone away, leaving a light cropping of sand over nearly every surface. Your giant spider-girl still holds you, looking away into the distance.\n\n");
	outputText("<i>“[name], I’ve had some time to think. I...I need to tell you some things.”</i> She keeps looking into the distance. I...I’ve tried to turn myself back into a Drider. Like, properly. They never worked.”</i> She closes all but two of her eyes. <i>“...They did things to me, [name]. Things that I can’t fix. I pushed you away because...Because I put out corruption. I can hold it back most of the time, but...I...I don’t know how long I can...:”</i> She takes a deep breath. <i>“[name], you saved my life today. It’s been years on my own. Everyone else just runs from me, or wants to fuck me.”</i>\n\n");
	outputText("She shudders. <i>“I want to find my sisters...But I don’t know what I’d even do if they’re dead...or worse, like me.”</i> She licks her lips, looking back at you. <i>“I don’t want to...do anything to you that you don’t want, but…”</i> Her arm walks down your back. <i>“Whatever that power was...It really...did something to me. I want you. Like, now...But…”</i>\n\n");
	outputText("You bring your hand to her pussy, and it’s sopping wet, dripping with her fluids and shivering at your touch. Even the slightest touch causes your giant lover to moan, biting her lip. <i>“It’s always been bad, but...I need you. Please?”</i> The giant, almost scary spider-woman, legs shaking and five eyes filled with need, vulnerable without her armor, is completely different here. Her carapace shines black, shining in the light of the dying fire, and she smells vaguely of sugar and vinegar.\n\n");
	menu();
	addButton(1, "NoThx", TyrantiaButYTho);
	if (player.gender > 0) addButton(3, "Sex", TyrantiaSexMenu);
	else addButtonDisabled(3, "Sex", "Not for genderless ones.");
}
public function TyrantiaButYTho():void {
	clearOutput();
	outputText("You aren’t really in the mood for sex, and you give her a chaste kiss on the forehead before pulling yourself from the giantess’s grasp. She lets you go, but there’s sadness in her eyes as you head back to camp. As you leave, she grabs her spear, up against the wall, and sighs, turning the shaft of the phallus-tip and hiding the blade inside. <i>“Well...Just me and my Dick again.”</i>\n\n");
	endEncounter();
}

public function TyrantiaCantmakeitRN():void {
	clearOutput();
	outputText("<i>“That’s sweet, love...But I can’t make it that far right now.”</i> She shivers. <i>“We need to get inside, before the sandstorm hits.”</i>\n\n");
	tyraniaAffection(10);
	menu();
	addButton(1, "Next", TyrantiaLovinCave);
}

public function TyrantiaSexMenu():void {
	clearOutput();
	if (TyraniaPostFinalKissScene) outputText("The Drider woman eyes you up and down, a poorly disguised smile on her face. <i>“Well...Since you asked nicely, I guess I wouldn’t mind.”</i> Her spider half bobs from side to side, and she runs her hands along the outside of her armor...rubbing where the nipples are in an obvious attempt to draw your gaze to her massive pairs of jugs. <i>“What are you thinking?”</i>\n\n");
	else {
		outputText("You slide your hand a bit deeper into her soaking chasm, spreading your fingers inside. You slowly rotate your hand, getting a deeper, more guttural moan. You smile up at her, sinking into her up to your wrist, and she shudders from head to leg tips. She grasps at the top of your [armor], gently, slowly pulling it off of you, while you slowly, surely pick up the pace, sliding your digits in and out of her soaking-wet honeypot. As you get fully naked, she makes a little tk-tk-tk-tk-tk sound with her lips, looking at you with a ravenous look on her face.\n\n");
		outputText("<i>“I hope you’re as horny as I am, [name],”</i> she hisses, looming over you. <i>“Because I have every intention of sating my thirst today.”</i>\n\n");
		TyraniaPostFinalKissScene = true;
	}
	menu();
	if (player.hasCock()) {
		addButton(1, "DickSex", TyrantiaFuck);
		addButton(2, "TitJob", TyrantiaTitJob);
		if (player.isTaur() || player.isDrider()) {
			addButtonDisabled(3, "HugFuck", "Not for Taurs or Driders.");
			addButtonDisabled(4, "C.Fuck", "Not for Taurs or Driders.");
		}
		else {
			addButton(3, "HugFuck", TyrantiaHugFuck);
			addButton(4, "C.Fuck", TyrantiaCavFuck);
		}
	}
	if (player.hasVagina()) addButton(5, "P.Spear", GetPhallustuffed);
	if (isLover()) addButton(14, "Back", TyrantiaAtCamp);
}

public function TyrantiaFuck():void {
	clearOutput();
	tyraniaAffection(5);
	outputText("Your [cock] is already rock hard from the foreplay, and your giant lover licks her lips. She plants her front two legs on either side of your hips, bringing one hand to your cheek. <i>“Oh, you are just a treat.”</i>\n\n");
	outputText("She lowers herself onto your [cockhead], her black lips parting easily. As you enter her, she stops, giving you a little smile before wordlessly, suddenly slamming down, sinking you balls-deep into her. Struck by the sudden sensation, you gasp, only for your massive lover to bring her face to yours, all five of her eyes amused.\n\n");
	outputText("<i>“Mmm...That feels...right.”</i> Tyrantia slowly begins to pull herself up, letting you slowly, torturously feel the folds of her surprisingly tight chasm cling to you, the warmth of her damp passage giving way to cold open air. <i>“Doesn’t it feel right to you?”</i> You nod, and she impales herself on your rod again, the sudden warmth delicious on your sensitive shaft. You sit back for a while as Tyrantia sets a slow, steady pace, your [cock] sliding into and out of her. While she starts out silent, your Drider giantess is clearly enjoying this slower, gentler pace.\n\n");
	outputText("Struck by a sudden urge, you take one of her massive mammaries, digging your [finger] into the soft, pillowy flesh. This gets a grunt from Tyrantia, and her cheeks flush a bright red for the first time during your lovemaking. You grab another of her breasts, and she begins to pick up the pace, resting her upper body on top of you and smothering your torso with her massive tits.\n\n");
	outputText("One of her hands drops to her cunt, and you reach around her massive chest, taking her hand before she can rub her clit. You gently slap her hand aside, and she smiles above you, guiding your hand to her button.\n\n");
	outputText("The moment you touch the Drider woman’s clit, she groans, entire body shuddering. Her pussy clamps down on your length, and you roll the nub with your fingers, getting another low moan. She shudders again, and you thrust up, tweaking her as you bottom out inside. <i>“Oh, fuck yes.”</i> Her voice is low, barely audible, but you grin, picking up the pace. You feel her fuzzy arms wrap around your chest, her hug surprisingly warm, and you look into her eyes, your [cock] leaking pre into her thirsty quim. Her eyes meet yours, and the giantess leans in, her full lips locking with yours.\n\n");
	outputText("You buck your hips, and as your Drider lover arches her back, she lets out a much higher moan. Her walls wriggle, massaging your [cock] inside her. Finally, truly lost in the moment, Tyrantia slams herself down onto you, gasping for air like a drowning woman. Her walls clamp down, and you feel a gush of warmth hit your legs as she cums hard, her weight almost painful on your pelvis.\n\n");
	outputText("<i>“Cmon, [name], I can’t just feel good myself.”</i> The giantess comes down from her high quickly, but her walls are just as tight as before. You can feel your [cock] twitch inside her, but you hold on, slamming yourself as deep into the Drider as you can.\n\n");
	outputText("<i>“Come for me.”</i> Her low, smoky voice, followed by her tightening her furry grip on you, brings your face to one of her jugs. <i>“[name], do it. Fuck me. Cum for me.”</i> Her gentle urging finally pushes you over the edge. You roar, slamming yourself in as you cum, almost violently. She slams down onto you, pinning you to the floor as you buck, spurting your seed into her thirsty cunt.\n\n");
	outputText("You come down from your orgasmic high, only to see the giantess still leaning on you, grinding her hips as your [cock] deflates inside her. <i>“Not a bad first round, lover.”</i> She whispers seductively, running a finger down your chest. <i>“But...After all that...I’m not quite satisfied.”</i> She leans in, kissing your shoulder, then running a trail of them up to your neck. There, she stops, pulling her mouth back. <i>“You trust me, right?”</i> You tell her that you do, and she chuckles. You feel twin pricks on your neck, and you know that she’s bitten you. It isn’t painful, she hasn’t sunken her fangs in far at all...Blood rushes to your [cock]"+(player.hasVagina()?", and your cooter begins to drool once more":"")+". Lurid pink thoughts fill your mind, and you eye her cunt greedily, taking in the lubricants covering your lower body.\n\n");
	outputText("You get your [legs] underneath you, and you slide out from underneath your Drider lover. Your [cock] slides most of the way out, and she gasps, but you stand, bringing your meaty shaft back in with a loud slap. The giantess, her front legs bent, gives you a gasp and a moan as you wrap your arms as far around her as they’ll go, using them as leverage as you fuck her standing up.\n\n");
	outputText("You lose track of how many times you and Tyrantia change positions and bring each other to orgasm, but even with the venom keeping you aroused, the Drider woman is insatiable. Eventually, you fall to the cave floor with a wet splat, your Drider lover staying with you as you fall. Your eyes begin to close, your [cock] still erect as she pumps herself on it. Your back is soaked with your mixed love juices, but you’re too tired to care, passing out.\n\n");
	outputText("You wake up on the floor, still covered in a sticky mixture of your combined love juices. Despite the cold floor, you’re surprisingly warm.You try to move your arms, but you’re completely immobilized. You open your eyes in panic, to see a familiar face right next to yours.\n\n");
	outputText("Tyrantia’s five eyes are closed, and her lips are drawn into a childlike smile. She holds your body like a child would a teddy bear, her surprisingly soft cheek rubbing yours. Your [cock] aches, and your [legs] feel like jelly. For the life of you, you can’t bring yourself to move, or even try to wake the giantess. So for a few minutes, you lie there, her steady heartbeat strong in your ears. She inhales, and you can feel her breathing, even through the cushion of flesh that is her breasts. Her furry arms are warm, and you drift back to sleep, the gentle snoring of Tyrantia in your ears.\n\n");
	outputText("You wake again, sitting up off the sticky cave floor and groaning as you stretch your tired limbs. <i>“Oh, you’re awake.”</i> Tyrantia says happily. <i>“Good.”</i> Your giantess lover seems happy, and you stand, rubbing your aching [cock]. She winces at that, turning her head. <i>“Sorry about that...It’s been forever since I had someone I could...Trust, y’know?”</i> She scratches the back of her head sheepishly. <i>“Trust to fuck me...and not fuck me over.”</i>\n\n");
	outputText("You inhale, telling her that you understand. You add that she doesn’t seem like the nympho type, but that she’d give anyone on Mareth an endurance challenge for the ages. <i>“Well...Yeah…”</i> She seems embarrassed by this fact. <i>“Driders were known for being...enduring lovers, even before...and whatever the demons did to me jacked up my libido something fierce. I can control it for the most part, but once I finally get a release, it just...pours out of me.”</i> You raise an eyebrow at that, looking around at the cave, soaked floor, walls, and...is that a bit of her cum on the ceiling?\n\n");
	outputText("<i>“Not like that, [name]!”</i> Tyrantia protests, then looks up, seeing the glob of girlcum on the roof of the cave. <i>“Oh...Wow...Maybe like that as well.”</i> She blushes, laughing. <i>“What can I say? You were great.”</i> Suddenly, she surges forward, hugging your naked body again. Unlike before, this isn’t a sexy grip, but a giant, fuzzy, warm bear hug. <i>“I’m really glad I met you.”</i> This warmth, both emotional and physical, reminds you so much of home, despite the oddity of the woman. You hug the giantess back, as much as you can. The moment passes, and she lets you go. <i>“I’m just glad nothing tried to join the fun...But we should probably arm up. No need to tempt fate, yeah?”</i>\n\n");
	outputText("You gather up the pieces of your [armor] scattered around the cave, and turn back to watch as you dress. You watch as Tyrantia slowly, methodically slides the steel plates over her spider half, then covers herself. You watch as the gentle giant of a lover you know slowly covers herself back up, becoming the imposing, frankly terrifying figure you saw on the battlefield.\n\n");
	outputText("<i>“I know, I like this less, too.”</i> Comes her low voice, her fangs menacingly poking out from her helm. <i>“But it’s more practical, these days.”</i> You pull yourself from the cave, waving goodbye to the Drider woman. You roll your shoulders, forcing your aching legs to work as you head back to camp.\n\n");
	if (TyrantiaFollowerStage >= 6) {
		knockUpTyrantia();
	}
	player.sexReward("vaginalFluids","Dick");
	cleanupAfterCombat();
}

public function TyrantiaTitJob():void {
	clearOutput();
	tyraniaAffection(5);
	outputText("You look at your Drider lover’s chest, and she gives a smirk, crossing an arm over each pair of her gargantuan breasts. You smile up at her as she flicks her bras, her massive, G-cups popping free. You feel yourself stiffen, blood rushing to your oversized [cock]. This doesn’t escape Tyrantia’s notice, and she saunters over. She reaches down, between your legs, and she smiles.\n\n");
	outputText("\"<i>Did I do that?</i>\" She asks, low and smoldering. She knows full well what you want, however, and she wastes no more time, quickly freeing your [cock] from your gear. Your glorious rod springs free, and she blinks twice.\n\n");
	outputText("\"<i>Nice.</i>\" She says, a giant hand wrapping around your glans. Her fingers are warm, but dry, and she slowly moves the hand down your shaft, tickling the sensitive skin.\n\n");
	outputText("She leans in, planting her front two legs on either side of you, and as she brings her fingers back up your shaft, she pushes herself forward, one leg against the back of your [legs]. She gently bends you backwards, and you let her guide you to the ground. Your drider lover licks her lips, fangs and eyes shining, as she wraps your shaft in both sets of soft, G-cup titflesh.\n\n");
	outputText("\"<i>Not many are big enough for this.</i>\" She comments, smiling as she uses both arms to squeeze her massive mammaries. She begins moving, and you shudder, letting your muscles relax. Her breasts are sublime, warm and soft, and the slow pace is relaxing. You close your eyes, letting your [cock] twitch in Tyrantia’s warm embrace.\n\n");
	outputText("She begins to pick up the pace, and you let a soft groan escape your mouth as the tip of your rod enters something warm and wet. You open one eye, to see your [cockhead] poking out from the top of Tyrantia’s breasts, and your Drider lover’s lips around the tip. She gives you a wink, tongue lolling out from her mouth and down your shaft as she starts moving again.\n\n");
	outputText("With your eyes closed, you can hear your lover’s flesh on yours, the scrape of her legs…and her soft gasp, the air cool on your [cockhead] for a moment as Tyrantia inhales a deep breath. Suddenly, she tightens her grip, picking up the pace as she brings her mouth down, fangs scraping the underside of your shaft as she throats the top five inches. Groaning, you open your eyes to see her lips suckered around your rod, and you can’t help but buck your hips as she picks up the pace.\n\n");
	outputText("It doesn’t take long for your cock to start twitching, and you moan, trying to hold your orgasm back. As your rod starts twitching, Tyrantia lets go of her tits, bringing her hands to your tool. She lunges down, taking a full foot of your length into her throat, gagging as her hands jerk off the rest of your manhood.\n\n");
	outputText("You can’t hold it back any longer! With a groan, your mast throbs, your aching balls twitching as you cum, spurting your load down your Drider lover’s throat.\n\n");
	outputText("\"Tyrantia, to your shock, barely even gags as she slides herself down all the way, her fangs now touching your sack. Her throat works, tightening around you, and with this extra stimulation, your orgasm keeps going…and going… Your lover gulps it down, her five eyes looking up at your face, half-closed. Finally, your orgasm ends, and she slowly pulls her head back, your sensitive [cock] still twitching. As your [cockhead] passes her lips, she gently takes your tool in her hands, kissing your head before gently letting your cock rest.\n\n");
	outputText("\"<i>Good to the last drop, lover.</i>\" She says, breathing heavily. <i>“I’d ask if you enjoyed it…but I think we both know you did.”</i> Once you’ve recovered, you thank Tyrantia for the titjob. She waves it off, smiling.\n\nYou redress and head your separate ways, but you make a note to come back to "+(TyrantiaFollowerStage >= 6 ? "Tyrantia’s part of camp more often":"the Battlefield more frequently. This was <i>definitely</i> worth the trip")+".\n\n");
	player.sexReward("no", "Dick");
	cleanupAfterCombat();
}

public function TyrantiaHugFuck():void {
	clearOutput();
	tyraniaAffection(5);
	outputText("You tell the giantess that you want to have some fun, but you want to mix it up a bit. Tyrantia tilts her head, nodding appreciatively as you strip. Your [cock] is already upright, raring to go "+(player.hasVagina()?", your cooter dripping with arousal":"")+".\n\n");
	outputText("<i>“So, what’s on your pretty brain, lover?”</i> You leer as Tyrantia returns the favor, peeling her armor off, and wiggling her hips as she peels her bras off. Her sizable pussy isn’t just damp, it’s positively dripping with lust, and she blushes, covering herself. <i>“H-hey, I can’t help it, okay? They...Made me like this.”</i> You decide to distract your suddenly bashful giant lover, running at her naked, full speed. You yell at her to catch you, leaping up and wrapping your arms around her, burying your [face] into her love-pillows.\n\n");
	outputText("You feel her warm, furry arms wrap around you, below your shoulders, and pull you up. She smiles, her eyes shining as she rubs her nose into yours. <i>“What was that?”</i> She asks as you wrap your [legs] around her waist, rubbing your [cock] against her chitin-covered leg.\n\n");
	outputText("You tell Tyrantia that it’s funny, and kind of arousing, her being so bashful. She freezes, and you kiss her cheek, telling her that you’re happy that she’s so wet for you. The red fills her face, and Tyrantia’s voice gets husky. She brings her lips to your ears, running the side of her fangs against your vulnerable neck as she whispers. <i>“Are you going to stick that [cock] of yours into me, or what?”</i>\n\n");
	outputText("At that, you’re more than happy to oblige. Trusting Tyrantia’s massive, fuzzy arms to support you, you take one hand from around her, guiding your [cock] past her blackened folds and deep into Tyrantia’s sopping depths. Tyrantia shudders as you begin to move, using your [legs] to give you leverage as you rub your [cockhead] into her folds. <i>“Ngh...Where to now, my little [race]?”</i>\n\n");
	outputText("You tell Tyrantia that you don’t particularly care, as long as you get to keep yourself inside her. She gives you a warm smile, biting her lower lip as you begin moving again. You sink your [face] into Tyrantia’s massive breasts, nicking the pillowy mounds with your teeth, paddling them with your nose, and pulling on her nipples as your lover’s fuzzy arms rub alongside your [skin] back, warm and soft...and comforting. You build up to a slightly quicker pace as she runs faster, and are rewarded by a low moan as your Drider-lover arches her back slightly.\n\n");
	outputText("<i>“Sh-shit, you’re good.”</i> Her stride is slightly uneven, and you feel her contract, hard. You grin, tweaking her swollen button, and the giantess groans. <i>“S-stop, [name]...For one sec?”</i> It seems your Drider lover was on the edge. You stop for a few seconds, and slowly start moving again, your lover’s pussy so thoroughly soaked that you barely even have to try and move. Despite this, her pussy clamps down tightly, giving you a slick, wet ride.\n\n");
	outputText("<i>“Thanks...Didn’t want to drop you...and I don’t want to end this yet.”</i> Tyrantia stops, and you look up, somewhat reluctantly, from her bountiful breasts. She ducks, and you recognize the place as the cavelike structure in the Battlefield, where you first made love to your giantess.\n\n");
	outputText("<i>“...I just...Wanted to have you here.”</i> The giantess explains. <i>“[name], I’ve fucked a lot of things, a lot of people...But I love you. Here was where...You made me feel special.”</i> Still holding you close, she walks to the very back of the cave, supporting your [ass] between the wall and her front Drider legs. Tyrantia looks into your eyes, and you wonder, for a moment, why you ever found this beautiful woman scary. <i>“Well, [name]...Make me feel that way again, would you please?”</i> She leans in to kiss you, slowly. <i>“Remind me of the night that made my life worth living.”</i>\n\n");
	outputText("Her lips and yours lock, beads of her bittersweet venom mixing with her sugary saliva. You greedily swallow the mixture, your erection hardening back up within her slippery pussy. Her hands drop to the curve of your [ass], fingers prodding at the entrance to your pucker as you buck your hips, sinking your [cock] balls-deep into your Drider lover. You’re rewarded by a surprisingly high-pitched moan, Tyrantia bringing one of her furry hands to support your head as she slams you into the wall.\n\n");
	outputText("You keep your [legs] wrapped firmly around Tyrantia, the two of you howling together in shared pleasure. Her depths contract, the slick folds trying desperately to tighten, to keep you in, but you piston in and out, your [cockhead] heating up, despite the rather absurd amount of lubricant dripping from your lover’s cunt. Her fuzzy arms, one hand on the back of your head, run along your back. You bury your [face] into her breasts, pulling at the flesh as you lick her cross-shaped cleavage, burying your face in titty heaven. You motorboat her, bringing yet another tone higher out of Tyrantia’s tortured voice.\n\n");
	outputText("<i>“Oh...Fuck...Yes! Yes! [Name], you horny fucking beast!”</i> She howls, legs shaking underneath you as she clamps down on your shaft, pussy walls milking you for all they’re worth. <i>“Cumming!”</i> As her juices flow, you reach up with one hand, pulling her head down into a passionate french kiss. You pick up the pace, her legs shaking uncontrollably as you pound her sensitive quim.\n\n");
	outputText("Tyrantia’s legs begin to collapse, and you barely get your [legs] underneath you in time, now holding her upper body up. Her eyes wide, tongue lolling out of her mouth, Tyrantia bucks her hips like a beast, arms still latched onto you as your [cock] twitches inside her, begging for release. Your Drider lover squeals with delight as you slam your [hips] into hers, bottoming out inside her.\n\n");
	outputText("<i>“Yes. Yes, yesyesyesYES!”</i> Drowning in pleasure, the Drider’s barely focused eyes roll around wildly. <i>“[name], do it. Cum for me.”</i> She slides up and down you recklessly, pinning you down against the ground. You hold on as long as you can, but sadly, all things must come to an end. You howl, your [cock] shaking madly inside her, spraying your baby batter into Tyrantia’s needy cunt. She slides up and down your shaft, tongue lolling out, and your vision blackens around the edges as your [cock] spurts again, then again. Your orgasm just seems to roll on, and eventually, your eyes are too heavy for you to keep open. The last thing you feel is a crushing weight as Tyrantia’s upper half collapses on top of you.\n\n");
	outputText("When you come to, the weight is reduced...But still there. You and Tyrantia are both lying on the stone floor, her upper body draped over you and your [cock] still firmly lodged inside her. Tyrantia’s breathing is heavy. She’s out cold, but her lips are drawn into a pure smile, her cheek rubbing yours with every breath she takes. Despite the stone floor, you’re surprisingly comfortable, and you find yourself just savoring the afterglow.\n\n");
	outputText("<i>“Mine.”</i> She whispers in her sleep. You sigh, content, shifting slightly, so that you’re a bit more comfortable. You rest your head on her fuzzy hand, closing your eyes again.\n\n");
	outputText("You wake as Tyrantia shifts around you. <i>“...aw…”</i> She seems disappointed as you wake up. <i>“You’re cute when you’re asleep.”</i> She sits up, pulling your [cock] out of her with a sticky Schlurp sound. You look at her lower body, soaked and sticky with the results of your lovemaking.\n\n");
	outputText("Reluctantly, you tell Tyrantia that you need to get back to camp. She nods, picking you up in her arms. <i>“I love you.”</i> This is a bare whisper, a lot more vulnerable than you’d expect from a woman who’s literally picked you up like it’s nothing. You tell Tyrantia that you love her back, and this gets you another happy little noise from your giantess.\n\n");
	outputText("<i>“Umm...I just realized something.”</i> She says, blushing. You tilt your head, confused, and she scratches her head. <i>“...We left our clothes back at camp.\" </i> You facepalm, realizing that neither of you thought about the aftermath of your little sexcapade.\n\n");
	outputText("<i>“Well...I know how we could keep ourselves...Kind of covered.”</i> She grins, putting you down. <i>“But it might be a bit...Stimulating.”</i>\n\n");
	if (TyrantiaFollowerStage >= 6) {
		knockUpTyrantia();
	}
	menu();
	addButton(1, "Yes", TyrantiaHugFuckCover);
	addButton(2, "No", TyrantiaHugFuckLolno);
}

public function TyrantiaHugFuckCover():void {
	clearOutput();
	outputText("You hop into her arms, covering both of your genitals by wrapping your [legs] around your lover. This leaves your ass completely exposed, a problem quickly rectified by Tyrantia, who wraps one furry arm around your [ass], covering you with a layer of muscle and fur. You give Tyrantia a peck on the cheek, and she carries you back to camp. Your [cock] slaps against her still-sticky chitin, but you both go your separate ways when you reach camp. <i>“Thank you for this.”</i> she says before you part ways. <i>“...As hard as things can get...You make it a lot easier for me, when we make love.”</i>\n\n");
	player.sexReward("vaginalFluids","Dick");
	cleanupAfterCombat();
}

public function TyrantiaHugFuckLolno():void {
	clearOutput();
	outputText("You give Tyrantia a sly smile, asking her what the problem is. Getting your [legs] beneath you, you stand, and then rush back towards camp, laughing as your Drider giantess gets over her shock, chasing after you. Laughing, you see her pussy dripping your love juices, her legs slippery with mixed fluids as she chases after you. The two of you run back to camp, and she catches you as you enter the camp grounds.\n\n");
	outputText("<i>“You are a naughty one, aren’t you?”</i> Tyrantia asks. You don’t respond verbally, but you drop your hand to her soaked lips, rubbing her labia with one hand. You remark that Tyrantia seemed to enjoy running around naked.\n\n");
	outputText("<i>“I-it was dangerous of you to do that.”</i> Tyrantia says sternly. <i>“What if something had gotten ideas?”</i> You shrug, reminding your giantess that she was right there, after all. You notice she hasn’t pulled back from your hand, and you tweak her clit, getting a low groan from Tyrantia. You ask your lover whether she has an exhibitionist streak, being so turned on right now. This gets an immediate reaction, and she pulls back.\n\n");
	outputText("<i>“No. It’s not my fault you’ve got such a nice ass. Teasing me all the way back.”</i> Tyrantia slaps you on the [ass], hard. <i>“I’ll deal with it. You should get back to your work, I guess.”</i> She strides back towards her hutch, and you follow, reminding her that your gear is there.\n\n");
	outputText("<i>“...Oh. Right.”</i> Tyrantia leads you back to her hutch, and stays outside as you put your clothes back on. You head back to your part of camp, leaving Tyrantia looking down at the ground, a confused look on her face.\n\n");
	player.sexReward("vaginalFluids","Dick");
	cleanupAfterCombat();
}

public function TyrantiaCavFuck():void {
	clearOutput();
	outputText("You smile up at the giant Drider, telling her that you remember a particular fun fact about Drider Biology, and you’re curious about how she’d handle it. <i>“Oh yeah?”</i> She tilts her head. <i>“Well, you’ve got me curious, [name], so why don’t you tell me what your idea is?”</i>\n\n");
	outputText("You ask her if she trusts you, and she gives you an almost insulted look back. <i>“[name], if I didn’t trust you, I wouldn’t keep your [ass] around.”</i> She leans down, patting you on the head. <i>“Come on, what’s your idea?”</i>\n\n");
	outputText("You tell her it’d be easier to show her, and you ask her to lower her Drider body to the ground. She complies, still watching you as you climb onto her Drider half. You gently shift your weight on her, shimmying forward so you’re sitting right behind her upper body.\n\n");
	outputText("You wrap your arms around her waist, pulling yourself in, and she hums, apparently not minding the feeling of you on her like this. You slide your [cock] out, and apparently she hasn’t noticed yet. She stands slowly, letting you adjust, and she chuckles, a little <i>“Tk-tk-tk”</i> sound escaping her lips.\n\n");
	outputText("<i>“Was that all, [name]? Did you just want a ride on the spider express-?!”</i> You slide your [cock] forward, into the plump curves of ass where her womanly half meets the Drider, and without warning, you prod at the entrance of her rear.\n\n");
	outputText("<i>“...Fucking...Cavalry.”</i> She turns her upper body to face you, and her five working eyes are lit up. <i>“Why the fuck didn’t I think of that?!”</i> You smile, bringing a palm to her cheek, and you propose a game. She raises an eyebrow, and you continue. You want her to run, to leap and jump as much as she can...and you’ll be on her back, your dick inside her ass. For emphasis, you wrap your legs around her womanly waist, sinking your [cock] an inch or so into her warm, somewhat moist asshole.\n\n");
	outputText("<i>“Hooooly...Fuuuck.”</i> She moans. <i>“That’s...That’s a feeling, alright.”</i> You jokingly tell her that you should make it a contest. You get to tease her, your cock in her ass, and she can’t stop running, but can make it as rough on your ass as she wants. Whoever lasts longer wins.\n\n");
	outputText("She leans her upper body forward, and laughs as your eyes widen. You grab at her shoulders, and she gamely offers you her hands. You take them, her fingers entwined with yours as she takes off, rushing across Mareth like a champion racehorse. Quickly, you realize two things: One, that her spider carapace isn’t exactly soft, and two: You just challenged Tyrantia to a contest akin to a fight and a fuck at the same time.\n\n");
	outputText("Surprisingly, the ride isn’t as bumpy as a horse’s gallop, despite being faster than any horse you’d ridden back home in Ignam. Knowing this, you grin,letting go of her hands and reaching around to Tyrantia’s moist spider-pussy. You run your fingers along her womanhood, and her regular breathing catches in her throat.\n\n");
	outputText("She runs, her every movement sending your [cock] in her ass moving, stirring her insides. Now more comfortable in your position on her back, you begin to tease her as best you can, rubbing her labia, sticking your fingers inside her and tweaking her massive nipples.\n\n");
	outputText("You’re rewarded by several gasps, then moans as Tyrantia struggles to maintain her pace. She sprints over the plains, then goes up the mountainside, trying her best to bruise your [ass] as hard as she can. Despite her best efforts, the more she runs, the more your cock moves inside her. Her walls are tight, clenching with each movement she makes. As you sink your [cock] deeper into her inviting depths, you can feel the muscles contract around you every time she flexes her abdomen, or brings her legs forward. This useful...and somewhat arousing...info helps you cling on, and as her muscles clench around your member, you renew your attack on her pussy as she tries (and fails) to throw you off.\n\n");
	outputText("You grin, waiting for her to land a particularly hard landing, then you suddenly attack, pinching her clit and sinking your hand into her pussy up to the wrist. She bucks under you, and you’re rewarded by a great roar from your Drider lover, clear fluids flowing from her cunt. You redouble your efforts, bucking your hips and you let out a shuddering cry yourself, painting your Drider lover’s insides white. She lets out a rather girlish cry for such a large woman, and she finally falls, her legs falling limp as fluids slowly leak from both her holes. She pants, with both physical and sexual exhaustion, and pats the ground in front of her, indicating for you to join her.\n\n");
	outputText("<i>“...Wow...That was awesome.”</i> Your cum leaks out her asshole, and you give her butt a playful smack. <i>“Hmmm....You like it back there.”</i> You smile, informing her that she has a nice ass. <i>“Damn right I do.”</i>\n\n");
	outputText("She breathes heavily, grinning as you get off her, walking around to her front. She leans her upper-half against a rock, resting against her hand, but as you come around, she takes you by the hand, pulling you into her twin pairs of massive mammaries. Her mouth is wide open, yours for the taking, and you french-kiss your drider lover, running your hands along the sensitive nubs and reveling in the moans you get from her. <i>“That was awesome [name], but I need more.”</i> You’re slightly taken aback, but she smiles, showing you her sopping cunt. <i>“Your fingers were great, but...I want a bit more, y’know?”</i>\n\n");
	player.sexReward("Default","Dick");
	player.trainStat("str",1,player.trainStatCap("str",100));
	player.trainStat("tou",1,player.trainStatCap("tou",100));
	player.trainStat("lib",1,player.trainStatCap("lib",100));
	player.removeCurse("sens", 5, 2);
	menu();
	if (player.hasCock()) {
		addButton(1, "DickSex", TyrantiaFuck);
		addButton(2, "TitJob", TyrantiaTitJob);
		if (player.isTaur() || player.isDrider()) addButtonDisabled(3, "HugFuck", "Not for Taurs or Driders.");
		else addButton(3, "HugFuck", TyrantiaHugFuck);
	}
	if (player.hasVagina()) addButton(5, "P.Spear",GetPhallustuffed);
}

public function GetPhallustuffed():void {
	clearOutput();
	tyraniaAffection(5);
	outputText("Your gaze is drawn to the phallus-shaped tip of Tyrantia’s spear, and she follows your eyes, giving you a chuckle.\n\n");
	outputText("\"<i>You like what you see, huh?</i>\" She takes the weapon off her back, and looking right at you, twists the penis-tip so that the blade is hidden. Still maintaining eye contact, her five eyes to yours, Tyrantia opens her mouth, stretching her long, flat tongue out and licking the end of her phalluspear.\n\n");
	outputText("\"<i>Can’t say I blame you.</i>\" Tyrantia moans, her massive breasts shivering, as she slowly slides the lubricated shaft down the center of her jugs, pushing the soft flesh aside and trailing a thin trail of her own saliva down to her belly.\n\n");
	outputText("\"<i>Not gonna lie, this thing has saved my ass almost as many times as it’s stirred it.</i>\"\n\n");
	outputText("You ask the giantess if she wouldn’t mind sharing her toys, and the giantess grins, sliding her pink panties aside as she runs the shaft of the phalluspear along the edge of her lips, grinning as you watch her arousal.\n\n");
	outputText("\"<i>Of course not, lover.</i>\" She walks right up to you, one hand on her dick, the other on your shoulder. \"<i>But...If I’m going to be doing something nice for you…</i>\" She walks two fingers down your flank, and you shiver at the giantess’s touch. \"<i>I want to see my lover…completely.</i>\"\n\n");
	outputText("She plants her spear into the ground, butt-first, and takes hold of your [armor]. You play along, letting her slowly undress you, and as she starts to reveal your lower half, you reach in with one arm, sliding her damp panties aside. With full access to her dripping cunt, you rub her lips, teasingly letting a finger slip in, one knuckle deep, barely even inside, before withdrawing it. Your Drider lover’s clit is already hard, the nub standing out against her swollen lips.\n\n");
	outputText("The moment your [lowergarment] hits the ground, Tyrantia’s already in motion. She steps in close, her violet eyes raking up and down your naked frame. You ask her if she’s enjoying the view, and she nods once, one rough, calloused hand taking hold of your [breasts]. She leans in, kissing your neck as her hand runs from your breasts, down to your stomach. Her other hand gropes your [ass], and you lean in, holding her close as she explores your body.\n\n");
	outputText("Your pussy dripping, "+(player.hasCock()?"and your [cock] hardening against her stomach, ":"")+"you indulge in her warm embrace, the gentle scraping of her fangs against your neck and shoulder. You latch onto Tyrantia’s breast with your lips, suckling and nicking the sensitive skin with your teeth. You feel her run one hand down your leg, and she leans in, whispering to you.\n\n");
	outputText("\"<i>Come on up, babe. Let’s get this party started.</i>\"She drops her hands to either one of your [ass], slowly lifting you up. You wrap your [legs] around her hips, and she grins, strong spider legs lifting you up off the ground.\n\n");
	outputText("You wrap your arms around her, but Tyrantia’s fuzzy arms are like a coat, warm and soft. A few moments pass, and you let one arm loose, rubbing her breast as you playfully bite another of her pillowy tits. She slowly lowers you, and you feel a hard, lubricated head part your lower lips. You gasp as it pushes through, deeper, and a wet heat fills you from the inside.\n\n");
	outputText("\"<i>Yeah...It’s got a little extra kick to it.</i>\" Tyrantia smolders, lowering you further. You know it’s only in a few inches, but it feels so much longer. It’s like your walls have just...expanded, feeling more and more with each fold of your pussy! You shudder as the wooden head twists inside you, finally stopping at your womb...You think.\n\n");
	outputText("\"<i>Enjoying yourself?</i>\" Tyrantia leans in, sinking her teeth into your shoulder. Your shoulder heats up, your pussy clenching on the thick, smooth wood inside you as your giantess lover kneads your asscheeks. Slowly, tortorously, she lifts you back up, the head scraping your folds as you shiver, holding on. The head slips past your folds, and you let a little moan escape your mouth, tongue out as you look up into her eyes. \"<i>Well, then make me feel good too, my lover.</i>\" She chides, gently guiding your hand to her own sopping wet pussy.\n\n");
	outputText("You slip into a slow, almost trancelike pace, the Phalluspear sinking into your deepest parts, Tyrantia’s lips on your shoulders, and her warm embrace equal parts relaxing and enticing. She begins picking up the pace, and you gasp, your breathing uneven, your heart slowly pounding, your pussy throbbing with need. You tighten your [legs] around her, stomach clenching as she locks lips with you, your orgasm so close. She pulls the Phalluspear out, and you shudder, anticipating the entry, the lubricated wood, the...\n\n");
	outputText("You open your eyes, to see Tyrantia licking the wood that had been inside you moments before. She licks her lips, clearly enjoying the flavor, but you groan, grinding your hips. She looks down, smiling, and puts the spear back down, outside your field of view. You smile, tweaking her clit in thanks, but Tyrantia lowers you down...and moans as the wooden spear enters her own pussy. You can feel it, as tight against her as you are. She slowly, tortorously bottoms out, rotating her hips, before sliding it out of her. She lowers you again, and this time, you sigh, the Phalluspear sliding past your labia...And down to your womb in a single stroke. ");
	outputText("You bury your face into the giantess’s bosom, muffling your moans in her bountiful boobs. Unlike the last time, Tyrantia picks up the pace, skewering you on the weapon as fast as she can. Overwhelmed, it’s all you can do to hold on as she runs you through over and over, your pussy on fire, your tongue lolling out and tears streaking down your face.\n\n");
	outputText("Finally, your orgasm comes, drenching your [legs], Tyrantia’s chitin, and the ground. She doesn’t stop either, your now sensitive folds ravaged even as your femspunk pours onto the ground. Gasping for air, barely able to keep your eyes open, you fall limp in Tyrantia’s arms.\n\n");
	outputText("You come to, still held, Tyrantia’s moans filling your ears. You shake yourself, realizing...You’re not done yet! Your giantess is currently impaled on her weapon, holding you like a teddy bear while she ravages her own cunt. You drop your hand to your lover’s pussy, and tweak her little black button. She gasps, locking eyes with you, and Tyrantia loosens her grip on you.\n\n");
	outputText("\"<i>Can’t...Get off it.</i>\" She manages, still pumping herself up and down. You slither out of her arms, dropping to the floor and covering yourself in your mixed fluids. You stride over to your lover’s back half, where all but one of her legs has lost the spear. It sits, held in place by one last leg. ");
	outputText("\"<i>Pull it…</i>\" Tyrantia’s clearly on the edge, and you smile, yanking the weapon clear out of her pussy in one go. Your giantess lover wails, but you’re not done. Coming back around to her front, you shove your face into her crotch, shoving your tongue in as far as it will go.\n\n");
	outputText("This brings Tyrantia to orgasm, and a deluge of femspunk hits you right in the face. You close your eyes, coughing as the sweet fluid enters your mouth and nose. Tyrantia finally falls, and you hug her upper half, letting the giantess rest it on you for a bit.\n\n");
	outputText("\"<i>Gods...Damn, I love you.</i>\" Your Drider lover starts snoring, and you gently lower her exhausted upper body to the floor. She’ll reek like sex for quite some time, but you don’t think the giantess will mind that much.\n\n");
	player.sexReward("Default","Vaginal");
	cleanupAfterCombat();
}

private function chanceToFail():Number {
	var chance:Number = 10;
	chance += Math.min(player.cumQ() / 25,40);
	chance += Math.min(player.virilityQ() * 100, 50);
	return chance;
}
private function knockUpTyrantia():void {
	if (DriderTown.TyrantiaPregnancy == 0 && rand(100) < chanceToFail()) {
		DriderTown.TyrantiaPregnancy = 72;
		if (flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS]) outputText("\n<b>Tyrantia is pregnant!</b>");
	}
	if (TyrantiaFollowerStage >= 7) TyrantiaFollowerStage = 7;
}

public function TyrantiaAtCamp():void {
	clearOutput();
	if (flags[kFLAGS.KIHA_FOLLOWER] == 1 && rand(10) == 0) kihaFollower.tyrantiaInteraction(true);
	else {
		outputText("You decide to go see your Drider Giantess. As you walk over to her hutch, Tyrantia comes out from her dwelling, her phallic spear over one shoulder. She looks down at you, arching her back and sending the soft scraping of steel up your spine.\n\n");
		outputText("\"<i>Oh, hey.</i>\" She rests her spider-half on the ground, so you don’t have to look up" + (player.tallness < 108 ? "" : " as much") + ". \"<i>Do you need something? Or did you just come over to see me?</i>\"\n\n");
	}
	menu();
	addButton(0, "Looks", TyrantiaAppearance);
	addButton(1, "Talk", repeatEncounterBattlefieldTalk);
	addButton(2, "Spar", TyrantiaSpar)
		.disableIf((flags[kFLAGS.PLAYER_COMPANION_1] == "Tyrantia" || flags[kFLAGS.PLAYER_COMPANION_2] == "Tyrantia"), "You can't fight against her as long she's in your team.")
		.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 2, "You need a good sparring ring for that.");
	if (TyrantiaTrainingSessions >= 40) addButtonDisabled(3, "Training", "You finished all training session with her.");
	else addButton(3, "Training", TyrantiaTraining);
	addButton(4, "Sex", TyrantiaSexMenu);
	if (player.hasPerk(PerkLib.BasicLeadership) && TyrantiaAffectionMeter >= 60) addButton(5, "JoinMe", TyrantiaHenchmanOption);
	else addButtonDisabled(5, "JoinMe", "You need to have at least Basic Leadership and 60% affection to form a team.");
	if ((DriderTown.TyrantiaMaleKids + DriderTown.TyrantiaFemaleKids) > 0) addButton(6, "Kidplay", TyrantiaKidPlayTime).hint("Play with your Unirider kids");
	if (TyraniaCorrupteedLegendaries >= 1) addButton(10, "Items", itemImproveMenuCorrupt);
	if (DriderTown.DriderTownComplete) addButton(13, "Back", SceneLib.dridertown.DriderTownEnter).hint("Return to main DriderTown menu.");
	addButton(14, "Leave", camp.campLoversMenu);
}

public function TyrantiaKidPlayTime():void {
	clearOutput();
	outputText("You tell Tyrantia that you want to spend some time with your kids. Your giantess’s eyes light up, and she grins, taking your hand and running over to the meadow.\n\n"); 
	outputText("Several of your children perk up as you draw near, and both you and your giantess are quickly engulfed in a group hug, one of your kids’ horns rubbing against your [leg].\n\n");
	outputText("\"<i>“What’re you up to, munchkins?”</i> Tyrantia asks, and the kids take your hands, pulling you over to the center of the meadow.\n\n");
	var menu:Number = rand(3);
	if (menu == 0) outputText("\"<i>“We were having a tea party!”</i> One of your little girls declares proudly. Somehow, they’ve procured a small table, and they’ve carved some wooden cups. They only have water, and their ‘cake’ is mud with flowers on top, but you can’t bring yourself to rain on their parade. You spend some time with your daughters ‘eating’ some cake and chuckling to yourself as they try to imitate a high society tea. Eventually, they grow bored of the tea party, running off as some odd bug catches their attention.\n\n");
	if (menu == 1) {
		outputText("\"<i>“We’re having a race!”</i> This from one of your boys, who begins drawing a line on the ground with a stick. Chuckling, you stand by the starting line, and Tyrantia draws another line by Lily’s tree. You line your children up, playfully slapping one of your boys upside the head as he tries to edge forward, and start the race.\n\n");
		outputText("Unsurprisingly, your children are extremely fast. Each of them have eight legs, after all. The race is close, but Tyrantia picks up a slender Unirider, holding them over her head and declaring a winner. Slightly upset, one of your kids demands a rematch. You and Tyrantia roll your eyes at each other, but you repeat the race a few times before your Unirider spawn are distracted by something down by the river. You and Tyrantia take the opportunity to slip away while they're poking at the water with sticks.\n\n");
	}
	if (rand(3) == 2) {
		outputText("\"<i>“We were gonna go for a swim!”</i> As you watch, a few of your kids throw their clothes away, rushing to the river and leaping off into the water. You grin at your giantess, who takes one kid in each arm, to their surprise, and runs at the water herself. A few little heads poke up from the water, just in time to see their mother, roaring as she leaps, clearing nearly half the river before she splashes down, sending waves back to shore. The giantess comes back up, laughing maniacally as she grabs one of the first swimmers, picking them up and blowing raspberries on their stomach.\n\n");
		outputText("\"<i>“Come on, "+player.mf("dad","mom")+", Join us!”</i> come cries from the water. You pretend to think for a moment, sidling up to the water’s edge before leaping in yourself. The kids are rowdy, but none more so than Tyrantia herself, who frequently picks up your Drider kids, hoisting them over her head before lobbing them back into the water. The squeals of delight, coupled with the flailing limbs, make you smile, cracking into laughter as one of your spawn lands next to you, splashing your face with the river water. You begin splashing the offending kid, and a splash-fight ensues. You laugh and play with your children, without a care in the world…until someone puts a hand on your shoulder.\n\n");
		outputText("\"<i>“[name]…do you see that?”</i> Tyrantia points across the river. You can’t see anything, but her voice is serious. \"<i>“What do you think we should do?”</i> You strain your eyes to see, but as you feel her other arm around your [leg], you realize you’ve been duped. Your cheeks flush red, and you groan internally. Did Tyrantia really just get you with that?\n\n");
		outputText("Your Giantess roars with delight, picking you up and hoisting you over her head like a trophy. \"<i>“Aaaaaand up we go!”</i> She yells, lobbing you bodily into the air. You try to twist in midair, but you splash down into the middle of the river, back-first. Sputtering, you get back to the surface, only to hear your kids with Tyrantia laughing at the sight of you.\n\n");
		if (DriderTown.BelisaKids > 0) {
			outputText("You notice a familiar figure beneath you, rising to the surface. Belisa pops her head up, and a few of your smaller Drider children join her, staring at the swimming Uniriders.\n\n");
			outputText("\"<i>“Mooom, can we go play?”</i> One of them asks. \"<i>“All the fish swam away.”</i> Belisa sighs, looking at you.\n\n");
			outputText("\"<i>“Ask your "+player.mf("dad","mom")+".”</i> The kids look at you expectantly, and you nod once. With a splash and a roar, Belisa’s kids swim in, launching themselves at their much-larger…siblings? Cousins? You decide not to think about it.\n\n");
			outputText("Belisa gives you a stern look…or at least she tries to. \"<i>“Well, that’s one fishing lesson ruined.”</i> She joins you, treading water as she joins the rapidly growing mob of children in the water. \"<i>“I’ll take it up with their mother.”</i> She eyes Tyrantia, who’s standing near the shore, grabbing the closest Drider kid and lobbing them into the water.\n\n");
			outputText("You watch as Belisa elbows her way to the front of the line, assuring the mob that she’s not trying to skip. Belisa whacks Tyrantia’s tit, and you can barely hear her over the chaos.\n\n");
			outputText("\"<i>“Sister, I told you that I was using the river today! You scared all the-! HEY!”</i>\n\n");
			outputText("Grinning, Tyrantia grabs her little sister, just like she had all the kids prior, and spins, lobbing Belisa to the other end of the river. She hits the water, spluttering.\n\n");
			outputText("\"<i>“Oh, sorry sis!”</i> Tyrantia says, a shit-eating grin on her face. \"<i>“Thought you wanted a ride!”</i>\n\n");
		}
		if (DriderTown.LilyKidsPC > 0) {
			outputText("\"<i>“Someone’s having a river-party and didn’t invite us?!”</i> One of your kids with Lily declares, mock-insult on her face. \"<i>“You know what THAT means!”</i>\n\n");
			outputText("\"<i>“CHARGE!”</i> Your kids with Lily stampede towards the river, grinning as they wade in, tackling a few of your other kids and tumbling into the water with them. Belisa and Tyrantia look at each-other, exchanging looks as they move to try and contain the fresh chaos that Lily's Drider kids bring to this impromptu swim.\n\n");
			outputText("Lily slips into the water behind her spawn, shrugging at her sisters. \"<i>“What do you want me to do?”</i> Tyrantia scowls, walking over to her sister and putting a hand on her shoulder.\n\n");
			outputText("\"<i>“I want you…”</i> Tyrantia grins, and you know exactly where this is going. \"<i>“To GET IN THERE!”</i> Lily realizes, too late, where this is going as Tyrantia picks her up, bodily lobbing her over her head and into the water, bowling over several of your Drider-kids as she lands.\n\n");
		}
		outputText("Laughter, the sound of children playing, and the odd, party-like atmosphere…It’s soothing. For once, the portal doesn’t even enter your mind, as you move from child to child, playing, laughing and generally having a good time.\n\n"); 
		outputText("An hour or so in, you find yourself next to Tyrantia, who’s simply watching, a smile on her face. You take her hand, and she guides you to the base of Lily’s tree. You sit, side by side, watching as your children wind down, one by one filing back towards the longhouse. You lean against her, and she puts a hand on your head.\n\n");
		outputText("\"<i>“Gem for your thoughts?”</i> Your giantess asks. You tell her that when you came through the portal, you’d never have thought this was in your future. Spilling blood, killing demons, saving pretty maidens…Yeah, but wholesome family playtime?\n\n");
		outputText("\"<i>“Am I your pretty maiden?”</i> Tyrantia asks teasingly. You think about it, and simply lean in, placing your head on her soft breast.\n\n");
		if (DriderTown.BelisaKids > 0) outputText("\"<i>“I think, if any of us fits that bill, it’s me, dear sister,”</i> teases Belisa, laying down on the other side of you.\n\n");
		if (DriderTown.LilyKidsPC > 0) outputText("\"<i>“No comment,”</i> Lily adds from behind you. Your Drider kids are heading in, and Belisa and Lily laugh, leaving Tyrantia and you alone for a few moments.\n\n");
		outputText("\"<i>“...You make me feel like one.”</i> Tyrantia whispers. \"<i>“A pretty maiden.”</i> She stretches, groaning slightly. \"<i>“And…I never would’ve thought this was my future, either. But I’m happy it is.”</i> You hear Lily’s annoyed voice coming from the longhouse, and Tyrantia’s ears perk up. \"<i>“Uh, I should probably deal with that.”</i> You excuse yourself, and she smiles. \"<i>“Fair enough.”</i> You head back to the center of camp. Something about this...You feel cleaner than before.\n\n");
	}
	dynStats("cor", -5);
	doNext(camp.returnToCampUseOneHour);
}


public function TyrantiaAppearance():void {
	clearOutput();
	outputText("Tyrantia is a Drider, but is far larger than the rest of her kind. Her spider-half alone stands over seven feet tall, and over fifteen feet long. Her carapace is black, with brown splotches spread throughout the thorax. Each of her spider-legs is thicker than a small tree, and a little bit of fuzzy hair sticks through in places. Her Spinnerets twitch regularly, and occasionally a bead of ebony liquid drips from it, turning the plants it lands on brown. Her skin is perfectly bronzed, almost brown.\n\n");
	outputText("A thin scar runs down the left side of her face, going clear through one of her six eyes. The scar tissue is pale, standing out sorely among her darker skin. Her lips are black and full, almost pouty. Her five remaining eyes are violet, and they look at you squarely. Twin horns poke out from her forehead, just above her eyes. The dark spikes emit an aura of lust comparable to that nightmare in the woods, and her horse ears flick occasionally, swiveling to pick up any sounds. Black, manelike hair speckled with silver runs from her scalp and hangs down to the small of her back.\n\n");
	if (TyrantiaAffectionMeter < 80) {
		outputText("She wears heavy-looking steel that wouldn’t look out of place on a building, thick slabs of blackened metal covering her entire upper-body and most of her spider-half as well. The upper part of her armor is unable to conceal her twin pairs of G-cup, massive breasts, the armor molded to fit her. Whenever she steps, a thin piece of metal sinks into the ground, the vicious-looking steel spikes covering her spider feet.\n\n");
		outputText("She holds her black and red half-helmet at her side with one hand, holding a...rather Phallus shaped spear with the other. Despite its obvious perversion, the weapon itself appears rather formidable, with a pink-tipped blade that perpetually leaks a fluid of the same color. Just sniffing it sets your heart beating a little faster. Tyrantia notices the color in your cheeks, and her lips curl upwards a little bit. She blows you a kiss, smirking.\n\n");
	}
	else outputText("Her armor laid aside, you can see more of your Drider giantess's body. Tyrantia’s heavily muscled frame is mostly obscured from the front by her massive quadruple breasts. They’re all pierced, but unlike most driders, she hasn’t chained them up, instead binding them with two massive pink silk bras.  Several old scars criss cross her arms, and as she catches you looking, she flexes one rippling bicep.\n\n");
	if (DriderTown.TyrantiaPregnancy > 1) outputText("She holds her egg-swollen belly, occasionally looking down at it and smiling. Looking at you, Tyrantia waves bashfully, the expression looking out of place on the giantess.\n\n");
	else outputText("On the front of her lower body is a moist twat barely covered by a skimpy silk set of embroidered panties, dripping with moisture, and as you look, Tyrantia smiles, flexing her abdomen and arching her back, giving you a little show as she slides the panties to one side.\n\n");
	doNext(TyrantiaAtCamp);
}

public function TyrantiaHenchmanOption():void {
	menu();
	if (flags[kFLAGS.PLAYER_COMPANION_1] == "") {
		if (flags[kFLAGS.PLAYER_COMPANION_2] == "Tyrantia" || flags[kFLAGS.PLAYER_COMPANION_3] == "Tyrantia") addButtonDisabled(0, "JoinMe (1)", "You already have Tyrantia accompany you.");
		else addButton(0, "JoinMe (1)", TyrantiaHenchmanOption2, 1).hint("Ask Tyrantia to join you in adventures outside camp.");
	}
	else {
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Tyrantia") addButton(5, "JoinMe (1)", TyrantiaHenchmanOption2, 21).hint("Ask Tyrantia to stay in camp.");
		else addButtonDisabled(5, "JoinMe (1)", "You already have other henchman accompany you as first party member. Ask him/her to stay at camp before you talk with Tyrantia about accompaning you as first party member.");
	}
	if (player.hasPerk(PerkLib.IntermediateLeadership)) {
		if (flags[kFLAGS.PLAYER_COMPANION_2] == "") {
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Tyrantia" || flags[kFLAGS.PLAYER_COMPANION_3] == "Tyrantia") addButtonDisabled(1, "JoinMe (2)", "You already have Tyrantia accompany you.");
			else addButton(1, "JoinMe (2)", TyrantiaHenchmanOption2, 2).hint("Ask Tyrantia to join you in adventures outside camp.");
		}
		else {
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Tyrantia") addButton(6, "JoinMe (2)", TyrantiaHenchmanOption2, 22).hint("Ask Tyrantia to stay in camp.");
			else addButtonDisabled(6, "JoinMe (2)", "You already have other henchman accompany you as second party member. Ask him/her to stay at camp before you talk with Tyrantia about accompaning you as second party member.");
		}
	}
	else {
		addButtonDisabled(1, "JoinMe (2)", "Req. Intermediate Leadership.");
		addButtonDisabled(6, "JoinMe (2)", "Req. Intermediate Leadership.");
	}
	addButton(14, "Back", TyrantiaAtCamp);

}
public function TyrantiaHenchmanOption2(slot:Number = 1):void {
	clearOutput();
	if (slot < 21) {
		outputText("You ask Tyrantia if she’d be willing to follow you on your adventures. She looks back at her hutch, then back to you. \"<i>And miss all this?</i>\" She grins, her five eyes sparkling. \"<i>[name]...After all you’ve done for me? I’d…</i>\" She smiles, wrapping you in a big fuzzy hug. \"<i>I’d die for you.</i>\"\n\n");
		if (!player.isDrider() && !player.isTaur() && !player.isInNonGoblinMech() && !player.isInGoblinMech()) outputText("She kisses you on the cheek, picking you up and putting you on her Drider back. \"<i>Just tell me where to go, my sweet [race], and I’ll make sure we get there safely.</i>\"\n\n");
		outputText("Tyrantia is now following you around.\n\n");
		var strTyrantia:Number = 295;
		var intTyrantia:Number = 150;
		var meleeAtkTyrantia:Number = 150;
		if (flags[kFLAGS.TYRANTIA_LVL_UP] >= 2) {
			strTyrantia += 20 * (flags[kFLAGS.TYRANTIA_LVL_UP] - 1);
			intTyrantia += 10 * (flags[kFLAGS.TYRANTIA_LVL_UP] - 1);
			meleeAtkTyrantia += 10 * (flags[kFLAGS.TYRANTIA_LVL_UP] - 1);
		}
		strTyrantia *= (1 + (0.2 * player.newGamePlusMod()));
		strTyrantia = Math.round(strTyrantia);
		intTyrantia *= (1 + (0.2 * player.newGamePlusMod()));
		intTyrantia = Math.round(intTyrantia);
		meleeAtkTyrantia += (1 + (int)(meleeAtkTyrantia / 5)) * player.newGamePlusMod();
		player.createStatusEffect(StatusEffects.CombatFollowerTyrantia, strTyrantia, meleeAtkTyrantia, intTyrantia, 0);
		if (slot == 2) flags[kFLAGS.PLAYER_COMPANION_2] = "Tyrantia";
		if (slot == 1) flags[kFLAGS.PLAYER_COMPANION_1] = "Tyrantia";
	}
	else {
		outputText("You ask your Drider ally to stay at camp for now. She gives you a surprised look, but nods. \"<i>Alright.</i>\"\n\n");
		player.removeStatusEffect(StatusEffects.CombatFollowerTyrantia);
		if (slot == 22) flags[kFLAGS.PLAYER_COMPANION_2] = "";
		if (slot == 21) flags[kFLAGS.PLAYER_COMPANION_1] = "";
	}
	doNext(TyrantiaHenchmanOption);
	cheatTime(1/12);
}

public function unlockingCorruptLegendariesOption():void {
	clearOutput();
	outputText("As you head back into camp, you pass by Tyrantia’s Hutch. Your giantess waves you over, and as you get closer, you notice the trough full of bubbling, black liquid. She looks down at it intensely, and as you watch, she plunges her hand into the mixture, her horns glowing black as she pulls a dagger from the ooze. The dagger’s a double-ended instrument, with a spike on one end, and…A pommel that looks like Anal beads, nearly as long as the dagger itself.\n\n");
	outputText("\"<i>Huh…That’s weird.</i>\" She puts the dagger down, and she looks up at you. \"<i>...This was a normal iron dagger. But…</i>\" She looks at the perverse spike she’s created. \"<i>It’s…much stronger now, but corrupted. It’s almost like the demon weapons I saw them make in the lab…</i>\" She blinks. \"<i>Okay.</i>\" She looks up at you, scratching her ass with one hand. \"<i>So…According to one of Lily’s books, Unicorns could use their inherent magic to enchant weapons, making them into legendary armaments.</i>\" She looks down at the dagger. \"<i>Bicorns, according to some of the demon’s lab notes, can do the same, but…with different effects.</i>\"\n\n");
	outputText("You can clearly see Tyrantia straining to think, eyeing the dagger in her hands. \"<i>From what I can tell…I can do the same thing. This dagger is clearly changed…Stronger, tougher, but obviously corrupt.</i>\" She sighs, putting the dagger down carefully. \"<i>Well…I’m still learning how to use this ability, but I’m sure that it could be useful. Making your weapons stronger, or more damaging could save your life in a fight.</i>\" She stomps her back legs awkwardly. \"<i>Well…With great power and all that. I’m sure I can find a use for it.</i>\"\n\n");
	outputText("You ask if she’d be willing to upgrade your weapons, and she nods. \"<i>But I can’t do much with it right now. Give me some time to figure it out.</i>\"\n\n");
	TyraniaCorrupteedLegendaries = 1;
	doNext(playerMenu);
	advanceMinutes(5);
}
public function itemImproveMenuCorrupt():void {
	var improvableItems:Array = [
		[weapons.BFSWORD, weapons.NPHBLDE, weapons.EBNYBLD],
		[weapons.DBFSWO, weapons.T_HEART, weapons.DORSOUL],
		[weapons.MASTGLO, weapons.KARMTOU, weapons.YAMARG],
		[weapons.KATANA, weapons.MASAMUN, weapons.BLETTER],
		[weapons.W_STAFF, weapons.U_STAFF, weapons.N_STAFF],
		[weapons.DEMSCYT, weapons.LHSCYTH, weapons.HELRAIS],
		[weapons.UGATANA, weapons.MOONLIT, weapons.C_BLADE],
		[weapons.L__AXE, weapons.WG_GAXE, weapons.DE_GAXE],
		[weapons.SPEAR, weapons.SESPEAR, weapons.DSSPEAR],
		[weapons.JRAPIER, weapons.Q_GUARD, weapons.B_WIDOW],
		[weapons.OTETSU, weapons.POCDEST, weapons.DOCDEST],
		[weapons.BFTHSWORD, weapons.ARMAGED, weapons.CHAOSEA],
		[weapons.A_WAND, weapons.OCCULUS, weapons.ECLIPSE],
		[weapons.PFLUTTE, weapons.ELYSIUM, weapons.HELLCAL],
		[weaponsrange.BOWLONG, weaponsrange.ARTEMIS, weaponsrange.WILDHUN],
		[weaponsrange.SHUNHAR, weaponsrange.KSLHARP, weaponsrange.LEVHARP],
		[weaponsrange.SIXSHOT, weaponsrange.GOODSAM, weaponsrange.BADOMEN],
		[shields.SANCTYN, shields.SANCTYL, shields.SANCTYD],
		[armors.LMARMOR, armors.BMARMOR, armors.S_ARMOR],
		[armors.BLKIMONO, armors.IBKIMO, armors.TCKIMO],
		[armors.BKIMONO, armors.IBKIMO, armors.TCKIMO],
		[armors.PKIMONO, armors.IBKIMO, armors.TCKIMO],
		[armors.RKIMONO, armors.IBKIMO, armors.TCKIMO],
		[armors.WKIMONO, armors.IBKIMO, armors.TCKIMO],
		[armors.SPKIMO, armors.OEKIMO, armors.OTKIMO],
		[armors.CTPALAD, armors.CTHPALA, armors.CTBGUAR],
		[armors.LTHRPNT, null, armors.CGUNSLI],
		[armors.DEATHPO, null, armors.DEATHPGA],
		[armors.B_QIPAO, armors.SFLAREQ, null],
		[armors.G_QIPAO, armors.SFLAREQ, null],
		[armors.P_QIPAO, armors.SFLAREQ, null],
		[armors.R_QIPAO, armors.SFLAREQ, null]
	];
	clearOutput();
	outputText("You ask your Drider lover if she’d be willing to upgrade a piece of your gear. She nods simply, bringing out a trough on wheels, filled with ebony liquid that bubbles, despite being under no heat.\n\n");// legendary
	outputText("\"<i>If you want this.</i>\" She says simply. \"<i>I will enchant something for you…But in order to do it right, I’ll need some materials.</i>\" She idly chews a nail, pointing at the vat. ");
	if (TyraniaCorrupteedLegendaries == 2) {
		outputText("\"<i>But I’ll need three 'Radiant Shards' and 20,000 Gems.</i>\"");
	}
	else {
		outputText("\"<i>But I’ll need something called a 'Radiant Shard'.</i>\" She stops chewing, then blinks. \"<i>No, I’ll need three of them, and 20,000 Gems.</i>\" You give Tyrantia a shocked look, and she shrugs. \"<i>I’m going off some kind of residual species memory right now.</i>\"");
		TyraniaCorrupteedLegendaries = 2;
	}
	outputText("\n\n<b>You currently have " + player.keyItemvX("Radiant shard", 1) + " radiant shards.</b>");
	var selectfrom:int = 2;
	var selectMenu:ButtonDataList = new ButtonDataList();
	for (var i:int = 0; i < improvableItems.length; i++) {
		if (improvableItems[i][selectfrom] == null) {/*do nothing*/
		}
		else {
			var item:ItemType = improvableItems[i][selectfrom];
			var from:ItemType = improvableItems[i][0];
			selectMenu.add(item.id, curry(improveItem, item, from)).disableIf(!player.hasItem(from),"You need "+from.longName+" as a base to create this item")
			.disableIf(player.keyItemvX("Radiant shard", 1) < 3,"You need at least three radiant shards in order to create this item.")
			.disableIf(player.gems < 20000,"You need at least 20 000 gems in order to create this item");
		}
	}
	submenu(selectMenu, TyrantiaAtCamp);

	function improveItem(item:ItemType, from:ItemType):void {
		clearOutput();
		outputText("\"<i>You sure about this?”</i>\" Tyrantia asks, hesitant. You nod, and she sighs, relieved. \"<i>Okay, just making sure.</i>\" You hand her the base item, and she takes it in her meaty hands, turning it over. Tyrantia closes her eyes, a black aura growing from her horns. It focuses, darkening further, until with a grunt, Tyrantia’s horns fire twin beams of black energy, converging on the item in her hands.\n\n");
		outputText("Tyrantia sets her jaw, the black energy thickening, until the piece of equipment in her hands is covered in a black miasma, so thick you can barely see the outline of it. Opening her eyes, your Drider lover lowers it into her vat of ebony goo, submerging it completely. The stream of energy from her horns stops, and she cracks her knuckles, squaring up, glaring at the vat of goo as if it had wronged her somehow. Her horns begin to glow, and you can feel the magical power building in the air, Tyrantia’s black and pink aura flaring as she places her palms on the surface of the tarlike liquid.\n\n");
		outputText("With a roar of effort, she plants her feet, magical energy bursting from her horn. Immediately, the goo bubbles, as if boiling, and a disgusting stench, like burning hair and cheese, wafts from it. The ooze bubbles over, clouds of dark vapor escaping into the air…Until a pink bubble stops the cascade of smoke, forcing it back down into the improvised cauldron. A few seconds pass, Tyrantia pouring more and more energy into the vat…until the pink skein of magic breaks, sending a small explosion of black vapor into the air.\n\n");
		outputText("It takes a while for the smoke to clear, but when it does, you can see Tyrantia, peering owlishly into her vat. When you walk over, all the ooze is gone, turned to smoke in this strange, almost ritualistic process. But on the bottom of the vat is your new item.\n\n");
		outputText("Tyrantia picks it up gingerly, handing it to you. \"<i>I hope this helps you on your travels…Gods know I’ve done wrong if it doesn’t.</i>\" She seems to feel slightly nauseous, and you voice concern.\n\n");
		outputText("\"<i>Oh, it’s nothing…</i>\" Your Drider lover burps, wincing. \"<i>Casting spells was never easy for me, that’s all…and magical abilities aren’t any different.</i>\" She flexes one arm. \"<i>There’s a reason I prefer my Dick.</i>\"\n\n");
		if(player.keyItemvX("Radiant shard", 1) == 3) player.removeKeyItem("Radiant shard");
		else player.addKeyValue("Radiant shard",1,-3);
		player.gems -= 20000;
		player.destroyItems(from, 1);
		inventory.takeItem(item, explorer.done);
	}
}
/*
public function JojoReaction():void {
		clearOutput();
		//This is to play the evening after Tyrantia is brought in.
		outputText("You wake up to a commotion in your camp. Getting out of bed, you see a very angry Jojo facing off against Tyrantia, fists upheld. He sees you, and is very clearly relieved. <i>“[name], grab your weapon! One of the demons made it into our camp!”</i> He’s clearly nervous, staring up at the Drider Giantess with fear in his eyes. Tyrantia gives you a loaded look, like <i>“You’ve got to be kidding me.”</i>\n\n");
		outputText("<i>“I’m going to grab something to eat. If you want something, come by my hut later, okay?”</i> She simply ignores Jojo and his objections, calmly walking away.\n\n");
		outputText("<i>“Marae Above, that...Was terrifying.”</i> Jojo looks at you, expectantly. <i>“[name]...Is that corrupted...Demon...Staying?!”</i>\n\n");
		outputText("You tell Jojo that Tyrantia is a person, not a demon. You inform Jojo that despite her corruption, Tyrantia’s proven herself to be a valuable warrior against the demon hordes many times over, a caring friend...and a surprisingly gentle soul, despite appearances. You tell Jojo that his meditation and holy practices may prove helpful to someone like her. Your words seem to hit a chord within Jojo and the monk nods.\n\n");
		outputText("<i>“Ah...It seems that I misjudged her. My apologies''. He bows his head, looking towards Tyrantia’s hutch. <i>“I...Will attempt to make amends''. He walks quickly towards the hutch, catching Tyrantia as she’s about to leave. You see her back up a step, but as Jojo talks to her, she smiles, looking back up towards you for a second. You nod, and she scratches the back of her head as Jojo talks. You’re too far away to make out the conversation, but Jojo and Tyrantia head off towards the woods together, and appear to be making small talk.\n\n");
doNext(camp.returnToCamp);
}*/
}
}