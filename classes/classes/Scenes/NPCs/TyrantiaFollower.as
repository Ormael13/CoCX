/**
 * ...
 * @author Canadian Snas
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.internals.SaveableState;

	public class TyrantiaFollower extends NPCAwareContent implements SaveableState
	{
		public static var TyraniaIsRemovedFromThewGame:Boolean;
		public static var TyraniaPostFinalKissScene:Boolean;
		public static var TyraniaSeenFlitzy:Boolean;
		public static var TyraniaAndIzumi:Boolean;
		public static var TyrantiaAffectionMeter:Number;
		public static var TyrantiaFollowerStage:Number;
		public static var TyrantiaTrainingSessions:Number;

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
		}

		public function saveToObject():Object {
			return {
				"TyraniaIsRemovedFromThewGame": TyraniaIsRemovedFromThewGame,
				"TyraniaPostFinalKissScene": TyraniaPostFinalKissScene,
				"TyraniaSeenFlitzy": TyraniaSeenFlitzy,
				"TyraniaAndIzumi": TyraniaAndIzumi,
				"TyrantiaAffectionMeter": TyrantiaAffectionMeter,
				"TyrantiaFollowerStage": TyrantiaFollowerStage,
				"TyrantiaTrainingSessions": TyrantiaTrainingSessions
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
			} else {
				// loading from old save
				resetState();
			}
		}

		public function TyrantiaFollower() 
		{
			Saves.registerSaveableState(this);
		}

public function tyraniaAffection(changes:Number = 0):Number {
	TyrantiaAffectionMeter += changes;
	if (TyrantiaAffectionMeter > 40) {
		if (TyrantiaFollowerStage > 1 && TyrantiaAffectionMeter > 100) TyrantiaAffectionMeter = 100;
		else if (TyraniaPostFinalKissScene > 0 && TyrantiaAffectionMeter > 60) TyrantiaAffectionMeter = 60;
		else TyrantiaAffectionMeter = 40;
	}
	else if (TyrantiaAffectionMeter < 0) TyrantiaAffectionMeter = 0;
	return TyrantiaAffectionMeter;
}

public function firstEncounter():void {
	clearOutput();
	outputText("You decide to visit the ruined battlefield. The great, ruined land is much quieter than normal, and you take the opportunity to look around more than usual. Iron pipes, remains of arcane-looking devices, and bodies...Lots of bodies. This place reminds you of ghost stories from Ignam: Two gods fighting in a God’s battleground, equally matched. They kill each other, and all the spirits of their dead followers remain to settle the score.\n\n");
	outputText("A harsh laugh rings through the air, coupled with the screech of shattering stone.Instinctively, you crouch behind the remains of a shattered wall. Do you investigate?");
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
	outputText("\"<i>So...who are you?</i>\" You tell her your name, that you’re a champion from Ignam, and that you’re no fan of demons either. \"<i>No Kiddin’? Well shit. Name’s Tyrantia. Sorry. I’m a bit busy right now, so why don’t you come back another time, and we’ll get a fresh start, okay?</i>\"\n\n");
	tyraniaAffection(5);
	doNext(camp.returnToCampUseOneHour);
}
public function firstEncounterYesNoHiding():void {
	clearOutput();
	outputText("You pop out and hold your hand out. You yell at her to freeze. Surprisingly, she stops in her tracks, tilting her head and staring at you curiously. \"<i>Why?</i>\"\n\n");
	menu();
	addButton(1, "Dunno", firstEncounterYesNoHidingDunno);
	addButton(2, "T. Police", firstEncounterYesNoHidingTPolice);
	addButton(3, "Fight", firstEncounterYesNoHidingFight);
}
public function firstEncounterYesNoHidingDunno():void {
	clearOutput();
	outputText("You shrug, not really knowing why you’d do that. She looks at you, dumbfounded, for a second, before bursting into uproarious laughter. A bit of black energy pulses around her, making your cheeks flush, but the laughter dies down quickly. \"<i>Y’know, for a little "+player.mf("guy","gal")+", you have some balls.</i>\" ");
	outputText("You tell her that you’re [name], a Champion from Ignam, but she wheels about. A single demon crawls out from underneath a pillar and she turns, running after him. \"<i>Hey, I’ll talk to you another time!</i>\"\n\n");
	tyraniaAffection(5);
	doNext(camp.returnToCampUseOneHour);
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
	doNext(camp.returnToCampUseOneHour);
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
	doNext(camp.returnToCampUseOneHour);
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
	tyraniaAffection(5);
	menu();
	addButton(1, "Heal", postFightOptionsHeal);
	addButton(2, "Kiss", postFightOptionsKiss);
	//addButton(3, "Rape", postFightOptionsRape);
	addButton(4, "Leave", postFightOptionsLeave);
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
		outputText("\"<i></i>\"\n\n");
		
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
		if (combat.inCombat) cleanupAfterCombat();
		else doNext(camp.returnToCampUseOneHour);
	}
}
public function postFightOptionsKissStop():void {
	outputText("She sighs in relief, none of her eyes meeting yours. \"<i>Look…[name]. I...I have...Reasons for pushing you away. I’m sorry, I just…</i>\" The giantess looks close to tears, and you find yourself staring at her eyes. ");
	outputText("\"<i>Don’t look at me like that. It’s not you. Marae knows it’s not you.</i>\" She lies there, still, and for a while, says and does nothing while several waves of black energy pours from her horn.\n\n");
	tyraniaAffection(5);
	if (combat.inCombat) cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}
public function postFightOptionsKissKeepGoing():void {
	outputText("You tell her that whatever’s wrong, she can tell you. You kiss her again, and she pushes you away, this time strong enough to dislodge you. She tries to stand, to stagger away, roaring in anger. \"<i>Weak! Stupid!</i>\" She falls again, staying down. ");
	outputText("\"<i>Just LEAVE ME BE!</i>\" She blindly fires a black web at you, missing by a mile. You decide it’s time to leave, and the sobbing giant’s tears fade away behind you as you walk back towards camp.\n\n");
	tyraniaAffection(-2);
	if (combat.inCombat) cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}
public function postFightOptionsRape():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	cleanupAfterCombat();
}
public function postFightOptionsLeave():void {
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
	menu();
	addButton(0, "Talk", repeatEncounterBattlefieldTalk);
	//1 - Spar
	//2 - Hunt
	addButton(3, "Kiss", postFightOptionsKiss);
	//Training and Sex where?
	addButton(5, "Leave", camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldRe():void {
	clearOutput();
	outputText("\"The giant Drider laughs. <i>\"Changed your mind, did ya?\"</i> She shrugs, leaning down a little. <i>\"What did you want then?\"</i>\n\n");
	menu();
	addButton(0, "Talk", repeatEncounterBattlefieldTalk);
	//1 - Spar
	//2 - Hunt
	addButton(3, "Kiss", postFightOptionsKiss);
	//addButton(4, "Training", repeatEncounterBattlefieldTrain);
	addButton(5, "Sex", repeatEncounterBattlefieldSex);
	addButton(6, "Leave", camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldTalk():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	menu();
	//0 - Lab
	addButton(1, "Self", repeatEncounterBattlefieldTalkSelf);
	//2 - Fighting Style
	addButton(3, "Kiha", repeatEncounterBattlefieldTalkKiha);
	addButton(4, "Diva", repeatEncounterBattlefieldTalkDiva);
	addButton(5, "Her", repeatEncounterBattlefieldTalkHer);
	addButton(14, "Back", repeatEncounterBattlefieldRe);
}
public function repeatEncounterBattlefieldTalkLab():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	//affection gains
	doNext(camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldTalkSelf():void {
	clearOutput();
	outputText("You ask the Drider-Giant what she thinks of you. She tilts her head, folding her legs underneath her. \"<i>Well...You’re fairly small, but strong. I like that. You’re unafraid to fight for what you believe in, and you have no fear of demons or corruption.</i>\" She looks down and away. \"<i>You’re a stand-up person, [name], and don’t forget it.</i>\"\n\n");
	outputText("You thank Tyrantia for her kind words, and take your leave.\n\n");
	doNext(camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldTalkFightingStyle():void {
	clearOutput();
	outputText("\"<i>“Honestly, I was wondering when you’d ask about that.”</i> Tyrantia scratches at her manelike hair with one hand. <i>“Honestly, it’s pretty hard to explain...but I’ll try.”</i>\"\n\n");
	outputText(" \n\n"); 
	//affection gains (5)
	doNext(camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldTalkKiha():void {
	clearOutput();
	outputText("<i>“Oh, you wanted to know about her?”</i> Tyrantia shrugs. <i>“We interacted a few times while we were both labrats. Some of the sickos working there had a perversion revolving around their ‘pets’ getting along. So...Yeah, we’ve done some things to each other. None of it was voluntary, but…”</i> She winces. <i>“Honestly, a part of me was genuinely happy when she made her escape...But she also didn’t come back. Can’t really blame her though.”</i> Tyrantia rolls her shoulders. <i>“She’s one hell of a fighter, too. That axe of hers may make it easy to counterattack if she misses, but if her strike lands...say goodbye to whatever limb got hit.”</i>\"\n\n");
	//affection gains (0)
	doNext(camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldTalkDiva():void {
	clearOutput();
	outputText("\"<i>“I’d heard about the “Drama Queen” prototype for the Demon’s airforce. Never really thought she’d be so…prissy.”</i> Tyrantia shrugs. <i>“I mean, me and the other prototype…We’re fighters, so you’d expect us to kick some ass and escape…but she acts like an actor in a really bad traveling play.”</i> She chuckles. <i>“Other than that, she’s alright, but the blood-drinking kinda weirds me out.”</i>\"\n\n");
	//affection gains (0)
	doNext(camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldTalkHer():void {
	clearOutput();
	outputText("\"<i>Okay...Don’t think I’m that interesting, but...whatever. What do ya wanna know?</i>\"\n\n");
	menu();
	//0 - Life Before Demons
	addButton(1, "NoHerm?", repeatEncounterBattlefieldTalkHerNoHerm);
	//2 - Life on the Battlefield
	addButton(3, "Different Parts", repeatEncounterBattlefieldTalkHerDifferentParts);
	//4 - Goblin
	//5 - Izumi
	//6 - Kids
	addButton(14, "Back", repeatEncounterBattlefieldTalk);
}
public function repeatEncounterBattlefieldTalkHerLifeBeforeDemons():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	//affection gains
	doNext(camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldTalkHerNoHerm():void {
	clearOutput();
	outputText("\"<i>...Herms were almost unheard of before the Demons came.</i>\" She looks down at herself. \"<i>I...of all the insane shit I’ve had to deal with...At least I didn’t become one of them.</i>\" \"<i>Not that there’s anything wrong with that, but...I like not having a second head, y’know?</i>\" She looks at her spear, rolling her eyes. \"<i>Well...A third head.</i>\"\n\n");
	outputText("You grin, cracking a joke about how she still waves her Dick around, and she gives you a laugh, her eyes glistening. \"<i>Okay, ya got me there.</i>\" She rubs the shaft with one finger, the hair on her arms standing up. \"<i>Demons and imps run more often if you run at them screaming ‘I’m gonna shove m’dick down your throat!’, then if you threaten to kill them. Fucking Crazy, the lot of them!</i>\"\n\n");
	outputText("She laughs, but you notice that the laughter doesn’t quite reach her eyes. You idly chat with your Drider comrade for a while, and when you leave, she seems a bit happier than before.\n\n");
	//tyraniaAffection(2);
	doNext(camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldTalkHerLifeOnTheBattlefield():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	//affection gains
	doNext(camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldTalkHerDifferentParts():void {
	clearOutput();
	outputText("You ask about her non-spider parts, and Tyrantia sighs, her horse-ears folding. \"<i>Look, it’s not something I like to discuss. Suffice to say, Demons happened. I trust you not to fuck me when I’m not with it, but…</i>\" She looks down, glaring at the ground, and whispers, so low you can barely make it out. \"<i>I can’t…</i>\"\n\n");
	outputText("You apologize to your Drider friend, patting her leg sympathetically. You tell her that if she isn’t comfortable with it, you won’t pry. You give her leg a hug before heading back to camp.\n\n");
	//tyraniaAffection(5);
	doNext(camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldTalkHerGoblin():void {
	clearOutput();
	outputText("<i>“Oh, Flitzy? She’s one of the Salon Bitch’s many daughters. Found her wandering around the mountains. ‘Taur tried to rape her, she didn’t want it, and I...Well, you know what I do.”</i> Tyrantia looks mildly embarrassed. <i>“Saved her ass, and we’ve kinda become friends. Gobbos don’t usually care about...Anything besides getting knocked up, but whatever, y’know?”</i> You get the feeling she was going to say something else, but you decide to leave it alone. You thank her for the time, and head back to camp. </i>\"\n\n");
	//affection gains (5)
	doNext(camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldTalkHerKids():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	//affection gains
	doNext(camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldSex():void {
	clearOutput();
	//if (TyraniaAffection > 24) {
	//outputText("The Drider woman eyes you up and down, a poorly disguised smile on her face. “Well...Since you asked nicely, I guess I wouldn’t mind.” Her spider half bobs from side to side, and she runs her hands along the outside of her armor...rubbing where the nipples are in an obvious attempt to draw your gaze to her massive pairs of jugs. “What are you thinking?\" \n\n");

	//menu();
	//addButton (1, "Titjob", );
	//addButton (2, "Hugfuck", );
	//addButton (3, "Get Phallustuffed", );
	//addButton (4, "Cav.Fuck", );
	//}
	//else {
	outputText("The giantess's eyes narrow, and she gives you a stern glare. \"Yeah, I don't exactly know you well, shorty\", she says roughly. \"Being around you is one thing, but having you between my legs? Trust like that is earned. \" \n\n");
	doNext(camp.returnToCampUseOneHour);
	//}
}

public function encounterBattlefieldAfterFinalKiss():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	//affection gains
	doNext(camp.returnToCampUseOneHour);
}
//Requires DriderTown, no kids, 80% affection.
public function TyrantiaTalkKids():void {
		clearOutput();
		outputText("You ask your giantess if she’d ever thought about having a family. She looks down at you, her expression a mix between sadness, amusement, and annoyance. Tyrantia tilts her head, bringing one hand to her chin. You wait patiently for her answer, but you don’t have to wait long.  \n\n");
		outputText("<i>“...Yeah, I have.”</i> She admits. <i>“Honestly, I’ve thought about it a lot, the last little while.”</i> She smiles sadly down at you. <i>“It’s all your fault, really.”</i> The giantess sits down on the ground, folding her spider-legs underneath her massive frame. You instinctively hug the giant Drider-girl, and she lets out her little <i>“Tk-tk-tk”</i> laugh that she shares with her sisters.  \n\n"); 
		outputText("<i>“...Look, [name]. I love you...I’d love nothing more than to lay your eggs, watch over them till they hatch, and bring up a new generation of Driders with you”</i>. Evidently she’s thought about this a lot. <i>“...I’d really like that”</i>. Her voice is a bare whisper, and bitter tears begin to fall from her eyes. <i>“...But I can’t allow it”</i>. \n\n"); 
		outputText("Surprised, you ask her why not, and she shakes her head, pointing at her horns. <i>“Look at these, look at me, and then ask yourself why I wouldn’t be willing to have kids”</i>. You blink, sighing as it clicks.  \n\n"); 
		outputText("<i>“Yeah. I have a hard enough time dealing with my own shit, [name]. I’m not gonna force that situation on a kid. They…don’t deserve that.”</i> You reluctantly agree, then a thought occurs to you. You ask Tyrantia about her eggs, how they are specifically. The giantess blushes. <i>“Well...They’re squishy and soft, not like the Lizans or Harpies. Our people’s eggs were way more susceptible to corruption. That’s why we ended up corrupt in the first place.”</i> She closes her eyes. <i>“[name], when I told you I couldn’t be what you wanted me to be, what did you think I meant?”</i> You hold her close, and you promise Tyrantia that you’ll try to make this work. You tell her that even if you can’t have a family, that you’ll stay with her.  \n\n"); 
		outputText("She sniffles, wrapping her furry arms around you. <i>“Thank you”</i>. She gives you a brave smile. <i>“Hey, if anyone can make this work, it’ll be you, ‘champ’”</i>. You mock protest at the jab, but you know she’s just kidding. Walking away from your Drider lover, you think of a few people you could see. Ralthazul, the mousey alchemist, is one, Jojo could be of some assistance, Arian has purification powers, and Marae is a Goddess. If anyone could help you, it would be her! \n\n"); 
//Starts the egg purification quest
}

public function TyrantiaPreg():void {
		clearOutput();
		outputText("You get back to camp, and you see your giantess lover. She stands near your [tent/cabin], and as she sees you, the giantess puts a hand on her slightly swollen belly.  \n\n");
		outputText("<i>“Oh...Hey [name].”</i> She fidgets. <i>“Look...There’s something I need to tell you.”</i> She walks towards you, taking your hands and bringing them to her slightly swollen belly. <i>“I’m...My eggs were fertilized. By you.”</i> She blinks, wincing. <i>“Not that I would...You’re the only one I love, [name]”</i>. She wraps her arms around you, hugging you close. <i>“Tomorrow, I’ll lay the eggs. Can you be there?”</i> You nod, and Tyrantia exhales, relieved.  \n\n"); 
		outputText("<i>“I love you.”</i> She lets go of you, going back to her hutch. <i>“Even though you made it so I can’t fight for another day.”</i> She rubs the top of your head. <i>“Asshole.”</i> Her smile takes the sting entirely out of those words. You can tell that, despite everything, your Drider giantess is very happy.  \n\n"); 
		outputText(" \n\n"); 
		outputText(" \n\n"); 
doNext(camp.returnToCamp);
}

public function TyrantiaEggLay():void {
		clearOutput();
		outputText("You hear an almost orgasmic moan coming from Tyrantia’s Hutch. You walk over, and inside the longhouse, Tyrantia’s standing over a trough made of wood and silk. The giantess’s cheeks are bright red, and seeing you, she waves you over.  \n\n");
		outputText("<i>“The eggs are coming”</i>, she moans, and you ask her if there’s anything you can do. <i>“Just...Take my hand. It’ll be easier if I have something to hold onto”</i>. You nod, taking your giant lover’s hand. You rub her swollen belly, and Tyrantia groans, this time much more pleasurably. You hear a slight plop as a few silvery orbs fall from your Drider-girl’s leaking twat and into the trough. Speeding up your belly rubs, you try to hold Tyrantia steady as more eggs begin to fall, one or two at a time. On the other side of her, you see Lily rush over. Tyrantia wraps a fuzzy arm around Lily, leaning slightly on her younger sister as the eggs drop. \n\n"); 
		outputText("In a few minutes, it’s over. A dozen translucent orbs fill the trough. Tyrantia shudders, falling to her knees, and both you and Lily can’t hold the giantess up. <i>“I’ll put these in your nursery nook, sister”</i>, Lily soothes. <i>“You did a great job. They look healthy so far”</i>. Lily leaves you two alone, and you put a hand on Tyrantia’s cheek, telling her that she did great.  \n\n"); 
		outputText("<i>“...Not done yet, [name]”</i>, she says weakly. <i>“They need to grow, to hatch...to…”</i> Her eyes are closing, and you tell her that she just delivered. That she needs to rest. Tyrantia looks like she wants to protest, but Belisa walks in, putting a hand on Tyrantia’s shoulder.  \n\n"); 
		outputText("<i>“Sister, [name] is right. Egg-laying is tiring. Close your eyes, dear sister. We’ll make sure nothing happens to your little ones.”</i> Belisa and Lily help Tyrantia stagger over to the bed, the giantess flopping face-down into it. Belisa and Lily give you warm smiles, Lily taking Tyrantia’s eggs while Belisa puts a hand on your shoulder.  \n\n"); 
		outputText("<i>“We’ll make sure she rests.”</i> Belisa smiles. <i>“Do what you need to, sweet [name]. We’ll look after her.”</i> You nod, heading back to your part of camp.  \n\n"); 
		outputText(" \n\n"); 
doNext(camp.returnToCampUseOneHour);
}

public function TyrantiaHatching():void {
		clearOutput();
		outputText("You hear a worried cry from Dridertown. <i>“[name], [name]! Come quickly!”</i> Belisa runs over to you, taking your hand. <i>“Tyrantia’s in the egg nook right now. Your podlings are hatching!”</i> You follow Belisa’s lead, sprinting as fast as you can to be by Tyrantia’s side. Belisa leads you into the longhouse, then down a crude set of stairs into an underground, cave-like structure lined with little nooks and crannies. In the back, you see tyrantia, nervously standing over three eggs. There much less than before, but before you can ask, the giantess puts a finger over your mouth.  \n\n"); 
		outputText("As you watch, one of the eggs begins to tear, a curved horn piercing it from the inside. Fluids drip from the egg, and a tiny head pokes out, horse-ears waggling. Unlike Tyrantia, this little one has white hair, and a single horn poking out. It pulls its spider legs out, one at a time, but quickly slips. Lunging forward, Tyrantia gently takes the newborn by the Drider-half, picking...her up. Her silk-spinners are covered in some sort of skin, and Tyrantia nods, assuring you that it’s normal for Driders to come out like that. Their spinnerets aren’t quite formed yet.  \n\n"); 
		outputText("She looks at the horn and horse-ears nervously, but you put a hand on your lover’s shoulder, assuring her that as long as they’re not corrupt, it doesn’t matter. A second Drider-baby breaks through their egg, shocking both of you out of your thoughts. This time, you take charge, gently picking your newborn up and holding them in your arms. This one’s a male, and his six eyes look at you, wide-eyed and mouth open. You hold him for a moment, before Tyrantia holds out her hands for her baby boy. You oblige, and as soon as you pass him over, the baby latches onto Tyrantia’s teat, suckling for all he’s worth.  \n\n");
		outputText("This Pod had (3-4 Drider babies, 50% male or female after the first two). You help Tyrantia carry your newborns over to one of the cubbies built into the wall. She swaddles them in blankets made from Belisa’s silk, and you lay them to rest.  \n\n"); 
		outputText("<i>“They won’t be like this for long,”</i> she says, clearly not liking that fact. <i>“But...They’re so beautiful.”</i> You agree, putting a hand on Tyrantia’s shoulder as you watch your babies go to sleep.  \n\n"); 
		//if first time, extra text below
		outputText("(If first time) You ask her about the rest of the eggs, and Tyrantia shrugs, a somewhat pained expression on her face. <i>“Oh, that’s normal”</i>. She shrugs. <i>“Not all eggs either get fertilized, something goes wrong, or they just got punctured on the way out. Three to Ten seems to be the norm for us. Honestly, I expected less than three...all things considered”</i>. You nod, happy that at least something is normal.  \n\n"); 
		outputText("<i>“...They’ve only got one horn though.”</i> Tyrantia seems nervous. <i>“Did something go wrong?”</i> You assure her that no, nothing went wrong. You tell the nervous mother of your kids that if anything, that’s a great sign.  \n\n"); 
		outputText("<i>“How so?”</i> She seems nervous. <i>“I would’ve thought no horns at all would be best”</i>. You shake your head, telling her that Unicorns are known for their purity. Who knows, if your kids really are part-unicorn, they might have an aura that’s the opposite of Tyrantia’s. \n\n"); 
		outputText("<i>“What, you mean like some sort of...Purity Aura?”</i> This seems to give her pause. <i>“...I hope you’re right. If you are, maybe I’m...Maybe...”</i> She seems to look at you and change her mind about what she’s saying. <i>“I love you”</i>. She hugs you tight, smiling at the little Uni-riders as they struggle with their swaddlings.  \n\n"); 
if (rand(2) == 0) {
  a TyrantiaFollower.TyrantiaKids += 3
} else {
  b TyrantiaFollower.TyrantiaKids += 4;	
	}
}

public function encounterBattlefieldAfterFinalKiss():void {
	clearOutput();
	outputText("\"You walk to the battlefield, heart heavy. It’s been a while, but the battlefield is even more quiet than usual, clouds hanging low in the sky. You sit down inside one of the ruined slabs of odd stone, taking a break from your walk, when you hear footsteps. A lot of footsteps. You instinctively hide under one of the slabs of ruined stone.   \"\n\n");
	outputText("\"<i>“Company...HALT!”</i> You peek your head out and see two demons, an Incubus in a lab coat and a Succubus in revealing armor, leading a platoon of similarly clad demons. <i>“Alright, what’s the sitch, bitch?”</i> He asks into an odd square device he pulls from his belt. A female, high pitched voice speaks from the boxy thing. <i>“We found her, sir. Project Screwed Earth is not only alive, but she’s the one who’s been tearing apart our summoners here”</i>.   \"\n\n");
	outputText("\"<i>“That Bitch. How big is she now?”</i> He grins at the news, however, a sickly satisfied smirk.   \"\n\n");
	outputText("\"<i>“At least Fourteen feet. Tall.”</i> The voice from the other end is a mix between scared, impressed and lustful. The commander of the demons grins. <i>“So...It worked. Hah! Lethice will be pleased.”</i> Lethice?! Now you HAVE to know what’s going on, even if it wasn’t about who you think it is. But...Project Screwed Earth? What did those demons DO to her? The demons move out, and you stealthily follow them. Apparently, these are not the first demons to come after her today. You hear roars of anger, the clash of steel, and the moans of the debilitatingly aroused. You peer owlishly at the battleground, and what you see isn’t surprising, but it still takes you aback.   \"\n\n");
	outputText("\" Over three dozen demons lie dead, in various states of dismemberment. Another two-dozen form a circle around their target, black magics on their fingertips. Even more roll around on the ground, masturbating feverishly as they can’t hold on.  \"\n\n");
	outputText("\"Lust spills from the giant being in the center, in sickening black waves. A dick-shaped spear clutched in both hands, Tyrantia, her helmet gone, her scarred face splattered with blood, pants heavily. Thin trails of moisture drip from the armor-flap on her front, and her violet eyes are partly closed.   \"\n\n");
	outputText("\"<i>“I must say, I’m impressed”</i>. The scientist walks slowly towards the ring. <i>“You’ve come a long way since the project’s start”</i>. He smiles. <i>“That aura, that corruption..and that strength. Truly a work of art!”</i>  \"\n\n");
	outputText("\" <i>“Pr-project?”</i> Tyrantia’s eyes focus on the demon. <i>“N-no...Not you. Anyone but…”</i>  \"\n\n");
	outputText("\"The demon commander grins lecherously, spreading his labcoat’s front and revealing what looks like a cross between a throbbing demon erection and a tail. He swings it like another limb, spreading pre-cum around him. <i>“So, you remember me? Not surprising. You and I had such fun together, remember?”</i>   \"\n\n");
	outputText("\"<i>“No. You...You hurt me. You…”</i> Your Drider giantess is backing up, fear on her face.  \"\n\n");
	outputText("\" <i>“And here I remember you asking for it...Begging for it. Do you still want it, Tyrantia?”</i> He pulls his pants down. Tyrantia licks her lips, the flap covering her pussy quivering, but snaps out of it. \"\n\n");
	outputText("\" <i>“No! I broke free! Get away from me!”</i> Tyrantia backs up, her hands shaking. \"\n\n");
	outputText("\" The demon scientist laughs at that. <i>“Oh, my dear, you think you broke free? Then why did you never stray far from the battleground? You think you were ever out of our grasp?”</i> The demon scientist smiles. We let you free, to see what you’d do. You performed exactly as we expected. You killed some schmucks, corrupted the landscape around you...And you even made some of Mareth’s pure-hearted champions feel sorry for you. Were they enough to satisfy that thirst we gave you? Even close?”</i>  \"\n\n");
	outputText("\" The fire in your Drider friend’s eyes begins to die down. Her legs shake, and she looks down at the ground. Between the lust magic covering her, the cuts and bruises, she looks about to give up. Her arousal leaks down the sides of her frontmost legs in a near-constant stream.  \"\n\n");
	outputText("\" <i>“That’s it, my pet. Return to your rightful place. You’ll get the reward you want, too”</i>.  \"\n\n");
	outputText("\"  \"\n\n");
	outputText("\"  \"\n\n");
	menu();
addButton (1, "JumpIn", TyrantiaSaveFight);
addButton (2, "StayHidden", TyrantiaLetDieYouMonster);
}

public function TyrantiaSaveFight():void {
		clearOutput();
		outputText("With a roar of rage, you jump from hiding, bowling through the shocked demons. The commander turns, too late, as you draw your [weapon], striking him hard enough to snap his neck with a single blow. Shocked, the demons take a step back as their commanding officer falls, dead. You turn, putting your back to Tyrantia.  \n\n");
		outputText("<i>“[name], what are you doing here?!”</i> She snaps back, alert once more. <i>“Leave me. I’m not worth your life. You...You heard what they said?”</i> You call her an idiot. You tell her that your life is yours to live, and yours to spend. You remind her that she has her mission as well, to find her sisters, and that she can’t do that from the end of a demon’s dick. She looks at you, five eyes focusing, and she grits her teeth in raw anger, her armour visibly rippling as she looks down at her fists. \n\n"); 
		outputText("<i>“Argh!”</i> She punches the ground, sending tremors through it. Nearby demons lose their footing, but she punches again, cracking the stone of the battlefield and sending stone shards flying. Her cunt drools faster, and the black energy emitting from her stops, reversing its course and covering her body. <i>“Stupid!”</i> The earth shakes again as she slams her fist through a stone the size of your head. <i>“Weak-willed!”</i> She stands, shattering the stone by flexing her wrist. <i>“I’ve...Had...ENOUGH!”</i> Her roars of rage echo throughout the battlefield, and as you watch, in utter awe, her helmet flies from the ground, planting itself back on her head.  \n\n"); 
		outputText("The aura that had once flowed from her, in pulsing waves, now clings tight to her body. Her violet eyes shine brighter, and her black armor pulses with brown light. Tyrantia motions with one hand, and the stones on the battleground form into more spears, complete with the crude phalluses on the tips. <i>“YOU WANNA GET FUCKED?!”</i> She roars, her new, odd aura flaring, the spears rotating, aiming at the demon horde. <i>“LETS FUCKING GO!”</i>  \n\n"); 
		outputText("You notice that there are still a hundred or so demons left, but the one-woman army at your back looks like she could take on the whole damn horde...Something you find surprisingly arousing. You smile at the incoming demons, letting out your own, much quieter, less dramatic war cry, and you charge the demon horde together.  \n\n"); 
//Tyrantia Save Fight here
}

public function TyrantiaLetDieYouMonster():void {
		clearOutput();
		outputText("You watch as the fiery light that was always in your Drider companion’s eyes leave them for good. The commander demon’s dick expands, moving like a third arm as it flicks aside the hatch covering her spider-pussy. He begins pistoning in and out, and as Tyrantia silently orgasms, her legs folding, a blackened piece of lethicite, nearly as large as one of her boobs, comes out with it. The commander demon sighs happily, taking it and swallowing the crystal. The demons walk away, leaving Tyrantia’s body lying there on the battleground. As you watch, her body turns jet-black, then begins to dissolve, fading into powder, blowing away in the breeze. \n\n"); 
		TyraniaIsRemovedFromThewGame = true;
		doNext(camp.returnToCampUseOneHour);
}


public function TyrantiaAfterMainFight():void {
		clearOutput();
		outputText("Only a few demons remain alive, the rest have either fled, and been cut down, or trampled if they try to stand. Lust spell after lust spell bounces off your giantess ally to seemingly no effect. Arrows, whip-cracks, they seem to anger her more than anything else. You cut down an incubus with your [weapon], and turn around. Tyrantia’s lost her armor, her breasts flying free as the metal plate falls...But with no targets left, she’s charging towards you, Dick held high.  \n\n"); 
		TyraniaPostFinalKissScene = true;
		menu();
addButton (1, "Dodge", TyrantiaAfterMainFightDodge);
addButton (2, "Call Out", TyrantiaAfterMainFightTalk);
}

public function TyrantiaAfterMainFightDodge():void {
		clearOutput();
		outputText("You roll aside, and her spear flashes past, narrowly missing your body. You stand, but she’s already turned around. She charges back towards you, roaring her anger. This time, you sidestep the spear, and before she can react, you jump into the air, wrapping your arms around her upper body. You hug her, clinging on with both arms and [legs], nearly suffocating in her breasts. Slowly, she stops, and as she falls to her knees, you set your feet on the wasted ground.  \n\n");
		outputText("<i>“[name]...Are you...Insane?”</i> Despite her words, the Drider-girl is crying, whole body shaking. <i>“What...What if I’d killed you?”</i> You hold tighter, wiping a tear from her eyes. You tell her that you knew she wouldn’t hurt you. Because you trust her. At this, she cries harder, wrapping her furry arms around you and holding you rib-creakingly tight.  \n\n");
		outputText("<i>“You...Mean that.”</i> She kisses you, initiating for the first time, and you can all but taste the conflicting feelings in her. <i>“You heard...You heard what they said about me...I corrupt everything I touch. I…”</i> She sags, unable to stay upright. <i>“[name]...I can’t hurt you. Not now…”</i> Her tears fall, bitter, and the battlefield’s overcast skies churn as the wind begins to howl. In the distance, you notice a whirling cloud coming from the desert…A sandstorm? <i>“[name], just being around me could...turn you into one of them. So...Why?”</i>  \n\n");
		outputText("You tell her that you don’t care. She opens her mouth, but you kiss her again, shutting her up. You tell her that you said before, your life is yours to spend. And the time you spend together is precious to you, too precious to lose. Tyrantia seems to notice the whirling storm, and you wince as a few grains of sand begin to hit you both. \n\n");
		outputText("The giant shudders, tears falling again, but her lips are curled up into a weak smile. She doesn’t say anything, but as she runs her fangs along the side of your neck, you trust her, not turning away. The scraping of her fangs are gentle, and surprisingly intimate. <i>“Well…”</i> She shivers, the sand bouncing off her carapace. <i>“Where do we go?”</i>  \n\n");
menu();
addButton (1, "Cave", TyrantiaLovinCave);
addButton (2, "Camp", TyrantiaCantmakeitRN);
}

public function TyrantiaAfterMainFightTalk():void {
		clearOutput();
		outputText("You hold out a hand, calling out her name as loud as you can. She doesn’t slow down, and you try again, closing your eyes as her Dick stops, mere inches from your chest. Her five working eyes are wide in shock and fear, and her arms are shaking. You gently grab the shaft of her spear, pushing it aside. She tries to back up, holding her arms out, but as you throw your [weapon] aside, she’s not quick enough to avoid you. Your arms wrap around her, and as her knees fold, you pull her head down to yours. You stare, her five eyes to yours, and you smile slightly, reassuringly. \n\n");
		outputText("<i>“[name]...Are you...Insane?”</i> Despite her words, the Drider-girl is crying, whole body shaking. <i>“What...What if I’d killed you?”</i> You hold tighter, wiping a tear from her eyes. You tell her that you knew she wouldn’t hurt you. Because you trust her. At this, she cries harder, wrapping her furry arms around you and holding you rib-creakingly tight.  \n\n");
		outputText("<i>“You...Mean that.”</i> She kisses you, initiating for the first time, and you can all but taste the conflicting feelings in her. <i>“You heard...You heard what they said about me...I corrupt everything I touch. I…”</i> She sags, unable to stay upright. <i>“[name]...I can’t hurt you. Not now…”</i> Her tears fall, bitter, and the battlefield’s overcast skies churn as the wind begins to howl. In the distance, you notice a whirling cloud coming from the desert…A sandstorm? <i>“[name], just being around me could...turn you into one of them. So...Why?”</i>  \n\n");
		outputText("You tell her that you don’t care. She opens her mouth, but you kiss her again, shutting her up. You tell her that you said before, your life is yours to spend. And the time you spend together is precious to you, too precious to lose. Tyrantia seems to notice the whirling storm, and you wince as a few grains of sand begin to hit you both. \n\n");
		outputText("The giant shudders, tears falling again, but her lips are curled up into a weak smile. She doesn’t say anything, but as she runs her fangs along the side of your neck, you trust her, not turning away. The scraping of her fangs are gentle, and surprisingly intimate. <i>“Well…”</i> She shivers, the sand bouncing off her carapace. <i>“Where do we go?”</i>  \n\n");
		outputText(" \n\n");
menu();
addButton (1, "Cave", TyrantiaLovinCave);
addButton (2, "Camp", TyrantiaCantmakeitRN);
}

public function TyrantiaLovinCave():void {
		clearOutput();
		outputText("You notice a nearby cave, made of the odd battlefield stone, more of a stone tent than a cave, but any shelter in a storm. You point, and she nods. Despite her weakness, she’s able to stagger her way to the shelter. Now out of the whirling sand, she collapses, breathing hard. You voice your concern, but her only reaction is to smile. <i>“You’re cute when you’re worried.”</i> She blushes a little, tossing her helmet to one side. <i>“Well...More than usual.”</i> She shivers, and you get to work, building a small fire to warm your improvised shelter. Tyrantia grabs a slab of stone, pulling it across the only entrance. The sandstorm begins to rage outside, battering the improvised door, and she holds her hands to the flames. <i>“Thank you.”</i>  \n\n");
		outputText("You shiver as the flame runs low on fuel almost immediately. The whirling sands show no sign of stopping, and she reaches out, pulling you towards her. You don’t resist, and between her frontmost spider legs, her massive, furry arms, and her four giant breasts, almost your entire body is covered by hers. It’s not an unpleasant sensation, and you quickly begin to warm back up. \n\n");
		outputText("<i>“You’re good at holding heat.”</i> She whispers, and you sink into her, soft, warm tits acting as a damn comfortable pillow. You fall asleep in her arms, waiting for the storm to stop.  \n\n");
		outputText("The world is silent when you wake. The sandstorm has finally stopped, and outside, the clouds have gone away, leaving a light cropping of sand over nearly every surface. Your giant spider-girl still holds you, looking away into the distance. \n\n");
		outputText(" <i>“[name], I’ve had some time to think. I...I need to tell you some things.”</i> She keeps looking into the distance. I...I’ve tried to turn myself back into a Drider. Like, properly. They never worked.”</i> She closes all but two of her eyes. <i>“...They did things to me, [name]. Things that I can’t fix. I pushed you away because...Because I put out corruption. I can hold it back most of the time, but...I...I don’t know how long I can...:”</i> She takes a deep breath. <i>“[name], you saved my life today. It’s been years on my own. Everyone else just runs from me, or wants to fuck me.”</i>  \n\n");
		outputText("She shudders. <i>“I want to find my sisters...But I don’t know what I’d even do if they’re dead...or worse, like me.”</i> She licks her lips, looking back at you. <i>“I don’t want to...do anything to you that you don’t want, but…”</i> Her arm walks down your back. <i>“Whatever that power was...It really...did something to me. I want you. Like, now...But…”</i> \n\n");
		outputText("You bring your hand to her pussy, and it’s sopping wet, dripping with her fluids and shivering at your touch. Even the slightest touch causes your giant lover to moan, biting her lip. <i>“It’s always been bad, but...I need you. Please?”</i> The giant, almost scary spider-woman, legs shaking and five eyes filled with need, vulnerable without her armor, is completely different here. Her carapace shines black, shining in the light of the dying fire, and she smells vaguely of sugar and vinegar.  \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
menu();
addButton (1, "Sex", TyrantiaSexMenu);
addButton (2, "Sex", TyrantiaSexMenu);
addButton (3, "Sex", TyrantiaSexMenu);
addButton (4, "NoThx", TyrantiaButYTho);
}

public function TyrantiaCantmakeitRN():void {
		clearOutput();
		outputText("<i>“That’s sweet, love...But I can’t make it that far right now.”</i> She shivers. <i>“We need to get inside, before the sandstorm hits.”</i> \n\n"); 
		tyraniaAffection(10);
		menu();
addButton (1, "Next", TyrantiaLovinCave);
}


public function TyrantiaButYTho():void {
		clearOutput();
		outputText("You aren’t really in the mood for sex, and you give her a chaste kiss on the forehead before pulling yourself from the giantess’s grasp. She lets you go, but there’s sadness in her eyes as you head back to camp. As you leave, she grabs her spear, up against the wall, and sighs, turning the shaft of the phallus-tip and hiding the blade inside. <i>“Well...Just me and my Dick again”</i>.  \n\n");
doNext(camp.returnToCampUseOneHour);
}

public function TyrantiaSexMenu():void {
		clearOutput();
		if TyrantiaFollowerStage = 2 {
		outputText("The Drider woman eyes you up and down, a poorly disguised smile on her face. <i>“Well...Since you asked nicely, I guess I wouldn’t mind.”</i> Her spider half bobs from side to side, and she runs her hands along the outside of her armor...rubbing where the nipples are in an obvious attempt to draw your gaze to her massive pairs of jugs. <i>“What are you thinking?  \n\n");
		}
		else {
		outputText("You slide your hand a bit deeper into her soaking chasm, spreading your fingers inside. You slowly rotate your hand, getting a deeper, more guttural moan. You smile up at her, sinking into her up to your wrist, and she shudders from head to leg tips. She grasps at the top of your [armor], gently, slowly pulling it off of you, while you slowly, surely pick up the pace, sliding your digits in and out of her soaking-wet honeypot. As you get fully naked, she makes a little tk-tk-tk-tk-tk sound with her lips, looking at you with a ravenous look on her face. \n\n");
		outputText("<i>“I hope you’re as horny as I am, [name],”</i> she hisses, looming over you. <i>“Because I have every intention of sating my thirst today”</i>. \n\n");
		
		}
menu();
if (player.hasCock()) {
addButton (1, "DickSex", TyrantiaFuck);
addButton (2, "TitJob", TyrantiaTitJob);
addButton (3, "HugFuck", TyrantiaHugFuck);
addButton (4, "C.Fuck", TyrantiaCavFuck);
}
if (player.hasPussy()) {
addButton (5, "P.Spear",GetPhallustuffed);
	}
}

public function TyrantiaFuck():void {
		clearOutput();
		outputText("Your [cock] is already rock hard from the foreplay, and your giant lover licks her lips. She plants her front two legs on either side of your hips, bringing one hand to your cheek. <i>“Oh, you are just a treat.”</i>  \n\n");
		outputText("She lowers herself onto your [cockhead], her black lips parting easily. As you enter her, she stops, giving you a little smile before wordlessly, suddenly slamming down, sinking you balls-deep into her. Struck by the sudden sensation, you gasp, only for your massive lover to bring her face to yours, all five of her eyes amused. \n\n");
		outputText("<i>“Mmm...That feels...right.”</i> Tyrantia slowly begins to pull herself up, letting you slowly, torturously feel the folds of her surprisingly tight chasm cling to you, the warmth of her damp passage giving way to cold open air. <i>“Doesn’t it feel right to you?”</i> You nod, and she impales herself on your rod again, the sudden warmth delicious on your sensitive shaft. You sit back for a while as Tyrantia sets a slow, steady pace, your [cock] sliding into and out of her. While she starts out silent, your Drider giantess is clearly enjoying this slower, gentler pace.  \n\n");
		outputText("Struck by a sudden urge, you take one of her massive mammaries, digging your [hand] into the soft, pillowy flesh. This gets a grunt from Tyrantia, and her cheeks flush a bright red for the first time during your lovemaking. You grab another of her breasts, and she begins to pick up the pace, resting her upper body on top of you and smothering your torso with her massive tits.  \n\n");
		outputText("One of her hands drops to her cunt, and you reach around her massive chest, taking her hand before she can rub her clit. You gently slap her hand aside, and she smiles above you, guiding your hand to her button. \n\n");
		outputText("The moment you touch the Drider woman’s clit, she groans, entire body shuddering. Her pussy clamps down on your length, and you roll the nub with your fingers, getting another low moan. She shudders again, and you thrust up, tweaking her as you bottom out inside. <i>“Oh, fuck yes.”</i> Her voice is low, barely audible, but you grin, picking up the pace. You feel her fuzzy arms wrap around your chest, her hug surprisingly warm, and you look into her eyes, your [cock] leaking pre into her thirsty quim. Her eyes meet yours, and the giantess leans in, her full lips locking with yours.  \n\n");
		outputText("You buck your hips, and as your Drider lover arches her back, she lets out a much higher moan. Her walls wriggle, massaging your [cock] inside her. Finally, truly lost in the moment, Tyrantia slams herself down onto you, gasping for air like a drowning woman. Her walls clamp down, and you feel a gush of warmth hit your legs as she cums hard, her weight almost painful on your pelvis.  \n\n");
		outputText("<i>“Cmon, [name], I can’t just feel good myself.”</i> The giantess comes down from her high quickly, but her walls are just as tight as before. You can feel your [cock] twitch inside her, but you hold on, slamming yourself as deep into the Drider as you can.  \n\n");
		outputText("<i>“Come for me.”</i> Her low, smoky voice, followed by her tightening her furry grip on you, brings your face to one of her jugs. <i>“[name], do it. Fuck me. Cum for me.”</i> Her gentle urging finally pushes you over the edge. You roar, slamming yourself in as you cum, almost violently. She slams down onto you, pinning you to the floor as you buck, spurting your seed into her thirsty cunt.  \n\n");
		outputText("You come down from your orgasmic high, only to see the giantess still leaning on you, grinding her hips as your [cock] deflates inside her. <i>“Not a bad first round, lover.”</i> She whispers seductively, running a finger down your chest. <i>“But...After all that...I’m not quite satisfied.”</i> She leans in, kissing your shoulder, then running a trail of them up to your neck. There, she stops, pulling her mouth back. <i>“You trust me, right?”</i> You tell her that you do, and she chuckles. You feel twin pricks on your neck, and you know that she’s bitten you. It isn’t painful, she hasn’t sunken her fangs in far at all...Blood rushes to your [cock], (if vagina) and your cooter begins to drool once more. Lurid pink thoughts fill your mind, and you eye her cunt greedily, taking in the lubricants covering your lower body.  \n\n");
		outputText("You get your [legs] underneath you, and you slide out from underneath your Drider lover. Your [cock] slides most of the way out, and she gasps, but you stand, bringing your meaty shaft back in with a loud slap. The giantess, her front legs bent, gives you a gasp and a moan as you wrap your arms as far around her as they’ll go, using them as leverage as you fuck her standing up.  \n\n");
		outputText("You lose track of how many times you and Tyrantia change positions and bring each other to orgasm, but even with the venom keeping you aroused, the Drider woman is insatiable. Eventually, you fall to the cave floor with a wet splat, your Drider lover staying with you as you fall. Your eyes begin to close, your [cock] still erect as she pumps herself on it. Your back is soaked with your mixed love juices, but you’re too tired to care, passing out.  \n\n");
		outputText("You wake up on the floor, still covered in a sticky mixture of your combined love juices. Despite the cold floor, you’re surprisingly warm.You try to move your arms, but you’re completely immobilized. You open your eyes in panic, to see a familiar face right next to yours.  \n\n");
		outputText("Tyrantia’s five eyes are closed, and her lips are drawn into a childlike smile. She holds your body like a child would a teddy bear, her surprisingly soft cheek rubbing yours. Your [cock] aches, and your [legs] feel like jelly. For the life of you, you can’t bring yourself to move, or even try to wake the giantess. So for a few minutes, you lie there, her steady heartbeat strong in your ears. She inhales, and you can feel her breathing, even through the cushion of flesh that is her breasts. Her furry arms are warm, and you drift back to sleep, the gentle snoring of Tyrantia in your ears.  \n\n");
		outputText("You wake again, sitting up off the sticky cave floor and groaning as you stretch your tired limbs. <i>“Oh, you’re awake.”</i> Tyrantia says happily. <i>“Good.”</i> Your giantess lover seems happy, and you stand, rubbing your aching [cock]. She winces at that, turning her head. <i>“Sorry about that...It’s been forever since I had someone I could...Trust, y’know?”</i> She scratches the back of her head sheepishly. <i>“Trust to fuck me...and not fuck me over.”</i>  \n\n");
		outputText("You inhale, telling her that you understand. You add that she doesn’t seem like the nympho type, but that she’d give anyone on Mareth an endurance challenge for the ages. <i>“Well...Yeah…”</i> She seems embarrassed by this fact. <i>“Driders were known for being...enduring lovers, even before...and whatever the demons did to me jacked up my libido something fierce. I can control it for the most part, but once I finally get a release, it just...pours out of me.”</i> You raise an eyebrow at that, looking around at the cave, soaked floor, walls, and...is that a bit of her cum on the ceiling?  \n\n");
		outputText("<i>“Not like that, [name]!”</i> Tyrantia protests, then looks up, seeing the glob of girlcum on the roof of the cave. <i>“Oh...Wow...Maybe like that as well.”</i> She blushes, laughing. <i>“What can I say? You were great.”</i> Suddenly, she surges forward, hugging your naked body again. Unlike before, this isn’t a sexy grip, but a giant, fuzzy, warm bear hug. <i>“I’m really glad I met you.”</i> This warmth, both emotional and physical, reminds you so much of home, despite the oddity of the woman. You hug the giantess back, as much as you can. The moment passes, and she lets you go. <i>“I’m just glad nothing tried to join the fun...But we should probably arm up. No need to tempt fate, yeah?”</i> \n\n");
		outputText("You gather up the pieces of your [clothing] scattered around the cave, and turn back to watch as you dress. You watch as Tyrantia slowly, methodically slides the steel plates over her spider half, then covers herself. You watch as the gentle giant of a lover you know slowly covers herself back up, becoming the imposing, frankly terrifying figure you saw on the battlefield.  \n\n");
		outputText("<i>“I know, I like this less, too.”</i> Comes her low voice, her fangs menacingly poking out from her helm. <i>“But it’s more practical, these days.”</i> You pull yourself from the cave, waving goodbye to the Drider woman. You roll your shoulders, forcing your aching legs to work as you head back to camp.  \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
doNext(camp.returnToCampUseOneHour);
}

public function TyrantiaTitJob():void {
		clearOutput();
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
doNext(camp.returnToCampUseOneHour);
}

public function TyrantiaHugFuck():void {
		clearOutput();
		outputText("You tell the giantess that you want to have some fun, but you want to mix it up a bit. Tyrantia tilts her head, nodding appreciatively as you strip. Your [cock] is already upright, raring to go, (if herm) your damp cooter drips with arousal.  \n\n");
		outputText("<i>“So, what’s on your pretty brain, lover?”</i> You leer as Tyrantia returns the favor, peeling her armor off, and wiggling her hips as she peels her bras off. Her sizable pussy isn’t just damp, it’s positively dripping with lust, and she blushes, covering herself. <i>“H-hey, I can’t help it, okay? They...Made me like this.”</i> You decide to distract your suddenly bashful giant lover, running at her naked, full speed. You yell at her to catch you, leaping up and wrapping your [arms] around her, burying your [face] into her love-pillows.  \n\n");
		outputText("You feel her warm, furry arms wrap around you, below your shoulders, and pull you up. She smiles, her eyes shining as she rubs her nose into yours. <i>“What was that?”</i> She asks as you wrap your [legs] (or coils) around her waist, rubbing your [cock] against her (slick/furry) chitin-covered leg.  \n\n");
		outputText("You tell Tyrantia that it’s funny, and kind of arousing, her being so bashful. She freezes, and you kiss her cheek, telling her that you’re happy that she’s so wet for you. The red fills her face, and Tyrantia’s voice gets husky. She brings her lips to your ears, running the side of her fangs against your vulnerable neck as she whispers. <i>“Are you going to stick that [cock] of yours into me, or what?”</i>  \n\n");
		outputText("At that, you’re more than happy to oblige. Trusting Tyrantia’s massive, fuzzy arms to support you, you take one hand from around her, guiding your [cock] past her blackened folds and deep into Tyrantia’s sopping depths. Tyrantia shudders as you begin to move, using your [legs] to give you leverage as you rub your [cockhead] into her folds. <i>“Ngh...Where to now, my little [race]?”</i>  \n\n");
		outputText("You tell Tyrantia that you don’t particularly care, as long as you get to keep yourself inside her. She gives you a warm smile, biting her lower lip as you begin moving again. You sink your [face] into Tyrantia’s massive breasts, nicking the pillowy mounds with your teeth, paddling them with your nose, and pulling on her nipples as your lover’s fuzzy arms rub alongside your [skintype] back, warm and soft...and comforting. You build up to a slightly quicker pace as she runs faster, and are rewarded by a low moan as your Drider-lover arches her back slightly. \n\n");
		outputText("<i>“Sh-shit, you’re good.”</i> Her stride is slightly uneven, and you feel her contract, hard. You grin, tweaking her swollen button, and the giantess groans. <i>“S-stop, [name]...For one sec?”</i> It seems your Drider lover was on the edge. You stop for a few seconds, and slowly start moving again, your lover’s pussy so thoroughly soaked that you barely even have to try and move. Despite this, her pussy clamps down tightly, giving you a slick, wet ride.  \n\n");
		outputText("<i>“Thanks...Didn’t want to drop you...and I don’t want to end this yet.”</i> Tyrantia stops, and you look up, somewhat reluctantly, from her bountiful breasts. She ducks, and you recognize the place as the cavelike structure in the Battlefield, where you first made love to your giantess.  \n\n");
		outputText("<i>“...I just...Wanted to have you here.”</i> The giantess explains. <i>“[name], I’ve fucked a lot of things, a lot of people...But I love you. Here was where...You made me feel special.”</i> Still holding you close, she walks to the very back of the cave, supporting your [ass] between the wall and her front Drider legs. Tyrantia looks into your eyes, and you wonder, for a moment, why you ever found this beautiful woman scary. <i>“Well, [name]...Make me feel that way again, would you please?”</i> She leans in to kiss you, slowly. <i>“Remind me of the night that made my life worth living.”</i>  \n\n");
		outputText("Her lips and yours lock, beads of her bittersweet venom mixing with her sugary saliva. You greedily swallow the mixture, your erection hardening back up within her slippery pussy. Her hands drop to the curve of your [ass], fingers prodding at the entrance to your pucker as you buck your hips, sinking your [cock] balls-deep into your Drider lover. You’re rewarded by a surprisingly high-pitched moan, Tyrantia bringing one of her furry hands to support your head as she slams you into the wall.  \n\n");
		outputText("You keep your [legs] wrapped firmly around Tyrantia, the two of you howling together in shared pleasure. Her depths contract, the slick folds trying desperately to tighten, to keep you in, but you piston in and out, your [cockhead] heating up, despite the rather absurd amount of lubricant dripping from your lover’s cunt. Her fuzzy arms, one hand on the back of your head, run along your back. You bury your [face] intowintoweđ her breasts, pulling at the flesh as you lick her cross-shaped cleavage, burying your face in titty heaven. You motorboat her, bringing yet another tone higher out of Tyrantia’s tortured voice.  \n\n");
		outputText("<i>“Oh...Fuck...Yes! Yes! [Name], you horny fucking beast!”</i> She howls, legs shaking underneath you as she clamps down on your shaft, pussy walls milking you for all they’re worth. <i>“Cumming!”</i> As her juices flow, you reach up with one hand, pulling her head down into a passionate french kiss. You pick up the pace, her legs shaking uncontrollably as you pound her sensitive quim.  \n\n");
		outputText("Tyrantia’s legs begin to collapse, and you barely get your [legs] underneath you in time, now holding her upper body up. Her eyes wide, tongue lolling out of her mouth, Tyrantia bucks her hips like a beast, arms still latched onto you as your [cock] twitches inside her, begging for release. Your Drider lover squeals with delight as you slam your [hips] into hers, bottoming out inside her. \n\n");
		outputText("<i>“Yes. Yes, yesyesyesYES!”</i> Drowning in pleasure, the Drider’s barely focused eyes roll around wildly. <i>“[name], do it. Cum for me.”</i> She slides up and down you recklessly, pinning you down against the ground. You hold on as long as you can, but sadly, all things must come to an end. You howl, your [cock] shaking madly inside her, spraying your baby batter into Tyrantia’s needy cunt. She slides up and down your shaft, tongue lolling out, and your vision blackens around the edges as your [cock] spurts again, then again. Your orgasm just seems to roll on, and eventually, your eyes are too heavy for you to keep open. The last thing you feel is a crushing weight as Tyrantia’s upper half collapses on top of you.  \n\n");
		outputText("When you come to, the weight is reduced...But still there. You and Tyrantia are both lying on the stone floor, her upper body draped over you and your [cock] still firmly lodged inside her. Tyrantia’s breathing is heavy. She’s out cold, but her lips are drawn into a pure smile, her cheek rubbing yours with every breath she takes. Despite the stone floor, you’re surprisingly comfortable, and you find yourself just savoring the afterglow.  \n\n");
		outputText("<i>“Mine.”</i> She whispers in her sleep. You sigh, content, shifting slightly, so that you’re a bit more comfortable. You rest your head on her fuzzy hand, closing your eyes again.  \n\n");
		outputText("You wake as Tyrantia shifts around you. <i>“...aw…”</i> She seems disappointed as you wake up. <i>“You’re cute when you’re asleep.”</i> She sits up, pulling your [cock] out of her with a sticky Schlurp sound. You look at her lower body, soaked and sticky with the results of your lovemaking.  \n\n");
		outputText("Reluctantly, you tell Tyrantia that you need to get back to camp. She nods, picking you up in her arms. <i>“I love you.”</i> This is a bare whisper, a lot more vulnerable than you’d expect from a woman who’s literally picked you up like it’s nothing. You tell Tyrantia that you love her back, and this gets you another happy little noise from your giantess.  \n\n");
		outputText("<i>“Umm...I just realized something.”</i> She says, blushing. You tilt your head, confused, and she scratches her head. <i>“...We left our clothes back at camp. You facepalm, realizing that neither of you thought about the aftermath of your little sexcapade.  \n\n");
		outputText("<i>“Well...I know how we could keep ourselves...Kind of covered.”</i> She grins, putting you down. <i>“But it might be a bit...Stimulating.”</i>  \n\n");
		menu();
addButton (1, "Yes", TyrantiaHugFuckCover);
addButton (2, "No", TyrantiaHugFuckLolno);
}

public function TyrantiaHugFuckCover():void {
		clearOutput();
		outputText("You hop into her arms, covering both of your genitals by wrapping your [legs] around your lover. This leaves your ass completely exposed, a problem quickly rectified by Tyrantia, who wraps one furry arm around your [ass], covering you with a layer of muscle and fur. You give Tyrantia a peck on the cheek, and she carries you back to camp. Your [cock] slaps against her still-sticky chitin, but you both go your separate ways when you reach camp. <i>“Thank you for this.”</i> she says before you part ways. <i>“...As hard as things can get...You make it a lot easier for me, when we make love.”</i>  \n\n");
		outputText(" \n\n");
		doNext(camp.returnToCampUseOneHour);

}

public function TyrantiaHugFuckLolno():void {
		clearOutput();
		outputText("You give Tyrantia a sly smile, asking her what the problem is. Getting your [legs] beneath you, you stand, and then rush back towards camp, laughing as your Drider giantess gets over her shock, chasing after you. Laughing, you see her pussy dripping your love juices, her legs slippery with mixed fluids as she chases after you. The two of you run back to camp, and she catches you as you enter the camp grounds.  \n\n");
		outputText("<i>“You are a naughty one, aren’t you?”</i> Tyrantia asks. You don’t respond verbally, but you drop your hand to her soaked lips, rubbing her labia with one hand. You remark that Tyrantia seemed to enjoy running around naked.  \n\n");
		outputText("<i>“I-it was dangerous of you to do that.”</i> Tyrantia says sternly. <i>“What if something had gotten ideas?”</i> You shrug, reminding your giantess that she was right there, after all. You notice she hasn’t pulled back from your hand, and you tweak her clit, getting a low groan from Tyrantia. You ask your lover whether she has an exhibitionist streak, being so turned on right now. This gets an immediate reaction, and she pulls back.  \n\n");
		outputText("<i>“No. It’s not my fault you’ve got such a nice ass. Teasing me all the way back.”</i> Tyrantia slaps you on the [ass], hard. <i>“I’ll deal with it. You should get back to your work, I guess.”</i> She strides back towards her hutch, and you follow, reminding her that your gear is there. \n\n");
		outputText("<i>“...Oh. Right.”</i> Tyrantia leads you back to her hutch, and stays outside as you put your clothes back on. You head back to your part of camp, leaving Tyrantia looking down at the ground, a confused look on her face. \n\n");
		outputText(" \n\n");
doNext(camp.returnToCampUseOneHour);
}


public function TyrantiaCavFuck():void {
		clearOutput();
		outputText("You smile up at the giant Drider, telling her that you remember a particular fun fact about Drider Biology, and you’re curious about how she’d handle it. <i>“Oh yeah?”</i> She tilts her head. <i>“Well, you’ve got me curious, [name], so why don’t you tell me what your idea is?”</i>  \n\n");
		outputText("You ask her if she trusts you, and she gives you an almost insulted look back. <i>“[name], if I didn’t trust you, I wouldn’t keep your [ass] around.”</i> She leans down, patting you on the head. <i>“Come on, what’s your idea?”</i>  \n\n");
		outputText("You tell her it’d be easier to show her, and you ask her to lower her Drider body to the ground. She complies, still watching you as you climb onto her Drider half. You gently shift your weight on her, shimmying forward so you’re sitting right behind her upper body.  \n\n");
		outputText("You wrap your arms around her waist, pulling yourself in, and she hums, apparently not minding the feeling of you on her like this. You slide your [cock] out of your [undergarments], and apparently she hasn’t noticed yet. She stands slowly, letting you adjust, and she chuckles, a little <i>“Tk-tk-tk”</i> sound escaping her lips.  \n\n");
		outputText("<i>“Was that all, [name]? Did you just want a ride on the spider express-?!”</i> You slide your [cock] forward, into the plump curves of ass where her womanly half meets the Drider, and without warning, you prod at the entrance of her rear.  \n\n");
		outputText("<i>“...Fucking...Cavalry.”</i> She turns her upper body to face you, and her five working eyes are lit up. <i>“Why the fuck didn’t I think of that?!”</i> You smile, bringing a palm to her cheek, and you propose a game. She raises an eyebrow, and you continue. You want her to run, to leap and jump as much as she can...and you’ll be on her back, your dick inside her ass. For emphasis, you wrap your legs around her womanly waist, sinking your [cock] an inch or so into her warm, somewhat moist asshole.  \n\n");
		outputText("<i>“Hooooly...Fuuuck.”</i> She moans. <i>“That’s...That’s a feeling, alright.”</i> You jokingly tell her that you should make it a contest. You get to tease her, your cock in her ass, and she can’t stop running, but can make it as rough on your ass as she wants. Whoever lasts longer wins. \n\n");
		outputText("She leans her upper body forward, and laughs as your eyes widen. You grab at her shoulders, and she gamely offers you her hands. You take them, her fingers entwined with yours as she takes off, rushing across Mareth like a champion racehorse. Quickly, you realize two things: One, that her spider carapace isn’t exactly soft, and two: You just challenged Tyrantia to a contest akin to a fight and a fuck at the same time.  \n\n");
		outputText("Surprisingly, the ride isn’t as bumpy as a horse’s gallop, despite being faster than any horse you’d ridden back home in Ignam. Knowing this, you grin,letting go of her hands and reaching around to Tyrantia’s moist spider-pussy. You run your fingers along her womanhood, and her regular breathing catches in her throat.  \n\n");
		outputText("She runs, her every movement sending your [dick] in her ass moving, stirring her insides. Now more comfortable in your position on her back, you begin to tease her as best you can, rubbing her labia, sticking your fingers inside her and tweaking her massive nipples.  \n\n");
		outputText("You’re rewarded by several gasps, then moans as Tyrantia struggles to maintain her pace. She sprints over the plains, then goes up the mountainside, trying her best to bruise your [ass] as hard as she can. Despite her best efforts, the more she runs, the more your cock moves inside her. Her walls are tight, clenching with each movement she makes. As you sink your [cock] deeper into her inviting depths, you can feel the muscles contract around you every time she flexes her abdomen, or brings her legs forward. This useful...and somewhat arousing...info helps you cling on, and as her muscles clench around your member, you renew your attack on her pussy as she tries (and fails) to throw you off.  \n\n");
		outputText("You grin, waiting for her to land a particularly hard landing, then you suddenly attack, pinching her clit and sinking your hand into her pussy up to the wrist. She bucks under you, and you’re rewarded by a great roar from your Drider lover, clear fluids flowing from her cunt. You redouble your efforts, bucking your hips and you let out a shuddering cry yourself, painting your Drider lover’s insides white. She lets out a rather girlish cry for such a large woman, and she finally falls, her legs falling limp as fluids slowly leak from both her holes. She pants, with both physical and sexual exhaustion, and pats the ground in front of her, indicating for you to join her.  \n\n");
		outputText("<i>“...Wow...That was awesome.”</i> Your cum leaks out her asshole, and you give her butt a playful smack. <i>“Hmmm....You like it back there.”</i> You smile, informing her that she has a nice ass. <i>“Damn right I do.”</i>  \n\n");
		outputText("She breathes heavily, grinning as you get off her, walking around to her front. She leans her upper-half against a rock, resting against her hand, but as you come around, she takes you by the hand, pulling you into her twin pairs of massive mammaries. Her mouth is wide open, yours for the taking, and you french-kiss your drider lover, running your [hands] along the sensitive nubs and reveling in the moans you get from her. <i>“That was awesome [name], but I need more.”</i> You’re slightly taken aback, but she smiles, showing you her sopping cunt. <i>“Your fingers were great, but...I want a bit more, y’know?”</i>  \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
doNext(camp.returnToCampUseOneHour);
}

public function TyrantiaAtCamp():void {
		clearOutput();
		outputText(" \n\n"); 
menu();
addButton(0, "Talk", repeatEncounterBattlefieldTalk);
	//1 - Spar addButton(1, "Spar", TyrantiaSpar);
	//2 - JoinMe addButton(2, "JoinMe", TyrantiaFollowerOptions);
	addButton(3, "Kiss", postFightOptionsKiss);
	if (TyrantiaTrainingSessions >0 ){
	addButton(4, "Training", TyrantiaTraining);
	}
	addButton(5, "Sex", TyrantiaSexMenu);
	addButton(6, "Looks", TyrantiaAppearance);
	addButton(7, "Leave", camp.returnToCamp);
}

public function TyrantiaAppearance():void {
		clearOutput();
		outputText("Tyrantia is a Drider, but is far larger than the rest of her kind. Her spider-half alone stands over seven feet tall, and over fifteen feet long. Her carapace is black, with brown splotches spread throughout the thorax. Each of her spider-legs is thicker than a small tree, and a little bit of fuzzy hair sticks through in places. Her Spinnerets twitch regularly, and occasionally a bead of ebony liquid drips from it, turning the plants it lands on brown. Her skin is perfectly bronzed, almost brown.  \n\n");
		outputText("A thin scar runs down the left side of her face, going clear through one of her six eyes. The scar tissue is pale, standing out sorely among her darker skin. Her lips are black and full, almost pouty. Her five remaining eyes are violet, and they look at you squarely. Twin horns poke out from her forehead, just above her eyes. The dark spikes emit an aura of lust comparable to that nightmare in the woods, and her horse ears flick occasionally, swiveling to pick up any sounds. Black, manelike hair speckled with silver runs from her scalp and hangs down to the small of her back.  \n\n"); 
		if TyrantiaAffectionMeter < 80 {
		outputText("She wears heavy-looking steel that wouldn’t look out of place on a building, thick slabs of blackened metal covering her entire upper-body and most of her spider-half as well. The upper part of her armor is unable to conceal her twin pairs of G-cup, massive breasts, the armor molded to fit her. Whenever she steps, a thin piece of metal sinks into the ground, the vicious-looking steel spikes covering her spider feet.  \n\n"); 
		outputText("She holds her black and red half-helmet at her side with one hand, holding a...rather Phallus shaped spear with the other. Despite its obvious perversion, the weapon itself appears rather formidable, with a pink-tipped blade that perpetually leaks a fluid of the same color. Just sniffing it sets your heart beating a little faster. Tyrantia notices the color in your cheeks, and her lips curl upwards a little bit. She blows you a kiss, smirking. \n\n"); 
		}
		else {
		outputText("Her armor laid aside, you can see more of your Drider giantess's body. Tyrantia’s heavily muscled frame is mostly obscured from the front by her massive quadruple breasts. They’re all pierced, but unlike most driders, she hasn’t chained them up, instead binding them with two massive pink silk bras.  Several old scars criss cross her arms, and as she catches you looking, she flexes one rippling bicep. \n\n"); 
		//if She's not pregnant
		outputText("On the front of her lower body is a moist twat barely covered by a skimpy silk set of embroidered panties, dripping with moisture, and as you look, Tyrantia smiles, flexing her abdomen and arching her back, giving you a little show as she slides the panties to one side.  \n\n"); 
		//if she is
		outputText("She holds her egg-swollen belly, occasionally looking down at it and smiling. Looking at you, Tyrantia waves bashfully, the expression looking out of place on the giantess.  \n\n"); 
		}
}

public function TyrantiaLiveWithMe():void {
		clearOutput();
		outputText("You ask her about the life she has on the Battlefield. She tells you the usual, mentioning the ‘cave’ you two found, and how she’s taken to living there.  \n\n");
		outputText("<i>“It’s a bit cold without you, [name]”</i>. She says this with a sultry smile on her face, and you notice that one of her hands is rubbing her armor, flicking the hatch you know leads to her surprisingly tight fuckhole.   \n\n"); 
		outputText("You ask her to kneel down a bit, so you can talk to her properly. She smiles, doing so with a little <i>“tk-tk-tk-tk”</i>. You put a hand on her cheek, and ask her if she’d like to come live with you, by the portal. Her spider eyes blink, one after the other, and she freezes in place. For about a minute, you stand there, patiently waiting for her to process what you just said.  \n\n"); 
		outputText("<i>“Did...Did you just ask…?”</i> She points at you, and you nod. <i>“You just asked me...to…”</i> You nod again, somewhat amused by her reaction. <i>“You want me...to come live with you? In your camp?”</i> You nod again. <i>“You mean...Even after all that bullshit with the demons, and knowing I’m corrupt, and…”</i> Her cheeks flush bright red, and she looks down at you, a big grin starting to form on her face. <i>“You want me to join you at your camp”</i>.  \n\n"); 
		outputText("You nod once more, and she squeals like a little girl, picking you up by the shoulders and squeezing you tight. <i>“This...This is the best day! This is the best day ever!”</i> She runs over to the ‘cave’, tossing her Dick over one shoulder, grabbing a simple bag, stuffed full of survival gear, armor polish and assorted knickknacks, and tossing it onto her shoulder as well. The bag’s around ten feet long, but she just lashes it onto her spider-half like a saddlebag. She spends the next few minutes rushing around, seeing if she’s missing something, rummaging through her hair and generally freaking out. You grab her hand as she passes, asking if she’s alright, and Tyrantia blinks again, realizing that you’ve been waiting.  \n\n"); 
		outputText("<i>“Sorry”</i>, she says sheepishly. <i>“I’m just...You’ve been really great to me, and I don’t want to fuck it up, y’know?”</i> You give her a smile, patting her on the shoulder, and you tell her that she doesn’t need to worry about it. They won’t be alone together. This seems to disappoint her for a moment, but she brightens up quickly.  \n\n");
		outputText("<i>“You mean...Even if you’re not there, I won’t be alone?”</i> You smile, cupping her cheek, and you tell your busty spider-lover that she’ll never be alone again, not if you have anything to say about it.  \n\n");
		outputText("<i>“[name] ...I’ll never be able to pay you back. I’ll always owe you”</i>. She shakes her head. <i>“If you need me...For anything at all…”</i> She gives you a very direct look. <i>“Anything...You call me, alright?”</i> You nod, and she smiles, her fangs showing clear. The smile on her face is from ear to ear as you take her hand, leading your amazoness spider home.  \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
TyrantiaFollowerStage = 1;
addButton(0, "Next", TyrantiaReactions);
}

public function TyrantiaReactions():void {
		clearOutput();
		//If Kiha is in camp
		outputText("Kiha’s eyes widen in recognition upon seeing the giant Drider. She takes a step forward, but seems to think better of it. Tyrantia sees Kiha, nodding once at the dragon-woman. Kiha looks down, her eyes burning with...Shame? Kiha flies away, her massive wings beating somewhat irregularly. You look up at Tyrantia, and she shakes her head. <i>“I’ll need to talk with her,”</i> she whispers to you. <i>“I’m glad you found her, she needs to stop beating herself up.”</i> You tell her that it’s Kiha. She always is too hard on herself.  \n\n"); 
		outputText("<i>“Heh...Some things never change.”</i> You want to ask more, but you change your mind. If the giantess wants to tell you, she will.  \n\n"); 
		//If Diva is in camp
		outputText("Your vampire lover pokes her head out of the tent, catching sight of Tyrantia. The pale woman’s jaw drops, and she covers her mouth. Your Drider lover sees the vampire, and she blinks twice.  \n\n"); 
		outputText("<i>“Drama Queen, that you?”</i>  \n\n"); 
		outputText("Diva shakes her head. <i>“...Don’t call me that.”</i> She turns away. <i>“Thou knowest mine name.”</i> \n\n");
		outputText("<i>“Sorry Diva.”</i> Tyrantia appears genuinely sorry about her slight. <i>“I’m...glad you made it out.”</i> \n\n"); 
		outputText("Confused, you look between the two ladies. Neither of them seems particularly interested in explaining, but eventually Tyrantia taps you on the shoulder.  \n\n"); 
		outputText("<i>“Come on, I’ll explain later.”</i> You follow Tyrantia away from Diva’s section of camp before the giant Drider woman speaks again. <i>“I’m sure she’s already told you at least a little about her run-in with the demons.”</i> Tyrantia shrugs. <i>“We were held at the same facility. Different projects, but...Our cells were right next to each other.”</i> She doesn't elaborate further. \n\n"); 
		//If Belisa is in camp
		outputText("As you lead Tyrantia towards camp, she catches sight of Belisa’s orb of spider-silk. She blinks, eyes widening. The giantess looks at you, shocked speechless. You smile, reaching up to pat her on the hip. She picks you up, placing you on her spider-back. She turns her upper body around to face you, her eyes wet, but a smile on her face.  \n\n"); 
		outputText("<i>“[name], you didn’t tell me one of my people was already living with you.”</i> She doesn’t seem to recognize the dwelling, and you smile, recognizing the opportunity. You ask her if she’d like to meet her, and Tyrantia nods, clearly ecstatic. She bobs up and down on her spider legs, not unlike an overexcited child.  \n\n"); 
		outputText("You lead Tyrantia down to the water’s edge, and call out for your little drider companion. As Belisa rises from the water, she turns to face you, a smile on her face...and both Drider sisters freeze where they are. Belisa forgets to tread water, and her mouth sinks back underneath the river’s surface, breaking the moment as she coughs the water out.  \n\n");
		outputText("<i>“Ackpth! Tk-tk-Tk-Tyr!”</i> She struggles to get the word out, still coughing up water as she makes a beeline for the shore. <i>“Tyrantia!”</i>  \n\n"); 
		outputText("Tyrantia, on the other hand, is frozen, as if paralyzed by a basilisk. Her eyes are wide, jaw dropped and her furry arms at her sides. She stares, unbelieving, as Belisa trips over the river’s edge, barely righting herself before taking an adorable faceplant. The comparatively tiny spider-girl rushes towards the two of you, leaping into the air at the last minute.  \n\n"); 
		outputText("She hits Tyrantia at full speed, wrapping both her arms and front spider-legs around her much-larger sister with a massive splat-clang of impact. Despite her incredible speed and massive leap, the impact doesn’t even seem to budge the much larger woman. <i>“Tyrantia? Is that you?! Oh dear sister, I was so worried, I thought I’d never see you again!”</i> Belisa rests her two front limbs on Tyrantia’s spider-half, scuttling closer to gain a bit of extra height. <i>“Tyrra? Sis?! Are you okay?!”</i>  \n\n"); 
		outputText("Tyrantia finally wraps her burly, furry arms around Belisa, her massive chest heaving as she struggles to breathe. She falls to her knees, giving Belisa a chance to finally reach up and remove her older sister’s helmet...and see the changes in her face. <i>“...Belisa…?”</i> The Giantess reaches one arm to touch her sister’s face, her eyes unfocused and distant, lost in some memory. <i>“You...Is this real? Or just another…”</i> Tyrantia seems afraid, and her black horns sputter with tainted energy.  \n\n");
		outputText("<i>“No, sister. It’s me. I’m here. I escaped the demons. I ran and hid underwater, just like you taught me.”</i> Belisa can feel the corruption, but doesn’t seem to care, taking her sister’s hand in both of hers. <i>“Remember the little pattern I taught you? The ‘magic’ one?”</i> Tyrantia shudders, taking her other hand and holding her palm out. Tyrantia gently bends her sister’s fingers towards the palm, pinky first.  \n\n");
		outputText("<i>“Home in five...Hearth in three...Eggs in one...and the rest…”</i> \n\n");
		outputText("<i>“For me.”</i> Belisa whispers, tenderly. <i>“Sis...You’re home now.”</i> Belisa turns her eyes to you. She begins to tear up herself, but her smile is bigger than you’ve ever seen it, her head bobbing from side to side and her back four legs doing a little happy dance. <i>“This...Means more to me than you could possibly imagine, sweet [name].”</i> She turns back to Tyrantia, wiping the tears from her sister’s eyes. <i>“Let me get her settled, okay? I know you’re busy, and...We have a lot to catch up on.”</i>  \n\n");
		outputText("Tyrantia shrugs out of her armor, undoing the clasps of her massive steel plates and letting her black carapace, spider-legs and most interesting to you, her massive quadruple breasts and enticing hole, show to the world. She rolls her shoulders, looking at the river in front of her, the sizable silk orb, and she surveys the camp, her five working eyes glittering with hope.  \n\n");
		outputText("<i>“Yeah…”</i> She looks back at you, her eyes shining. <i>“I’m gonna need a bit of time, love...But...This is so much better than I could have dreamed.”</i> She turns back to her sister, wrapping one fuzzy arm around her head, and drags her knuckles along the smaller Drider’s scalp. \n\n");
		outputText("<i>“Gah! Sis! Stop that! Stop the noogie! No! Bad sis!”</i> Despite the words, both sisters are doing little tap-dances with their back spider legs, and they walk off towards the river, hand in hand. It’s moments like these that make you truly feel like a champion.  \n\n");
		outputText(" \n\n");

}

public function AmilyReaction():void {
		clearOutput();
		//If Pure Amily is in camp, an hour or so after Tyrantia's brought in.
		outputText("You come to camp, and see your giant drider standing on the boundary of camp, a very angry mouse-morph standing on a wooden stool, trying to get into her face. <i>“Look, you overgrown insect, you’re not welcome here! I can feel the corruption coming from you!”</i> Amily seethes, ready to throw a dart, but Tyrantia isn’t even mad yet.  \n\n");
		outputText("<i>“Look...Just talk to [name]. I don’t really care if you like me, just get out from under my feet”</i>. \n\n"); 
		outputText("<i>“Under your feet?! Oh, you wish I was there, don’t you, all jizzed up, you demon-spawn?”</i> At that, the first signs of anger appear on Tyrantia’s face. Her five eyes narrow, and her fangs quiver a bit.  \n\n"); 
		outputText("<i>“I am not a demon, rat”</i>. She looms over Amily, lower lip quivering. <i>“I’ve done more to stop the hordes than you, I’d bet. How many demons have you killed?”</i> She hoists her Dick. <i>“I’ve killed Five, seventeen imps, and...shit...How many Golems?”</i> She shrugs. <i>“Fuck it. A lot. And that was today”</i>. She points her Dick at Amily. <i>“Back the fuck off, bitch, or I’ll…”</i> Her black aura flares, and Tyrantia sees you. Her eyes widen, and the Drider flinches. She holds her head, making a visible effort to keep her corrupt aura inside.  \n\n"); 
		outputText("<i>“Just leave me be. You’re lucky that [name] cares about you”</i>. She stomps off towards the battlefield again, and Amily sits down on a log, wiping sweat off her brow.  \n\n"); 
		outputText("<i>“Oh, hey [name]”</i> She calls, seeing you walking towards her. <i>“We need to talk”</i>. \n\n");  
menu();
addButton (1, "Anger", AmilyAnger);
addButton (2, "Explain", AmilyExplain);
addButton (3, "KickTyr", MakeTheSpoodLeaveYouMotherFucker);
}

public function JojoReaction():void {
		clearOutput();
		//This is to play the evening after Tyrantia is brought in. 
		outputText("You wake up to a commotion in your camp. Getting out of bed, you see a very angry Jojo facing off against Tyrantia, fists upheld. He sees you, and is very clearly relieved. <i>“[name], grab your weapon! One of the demons made it into our camp!”</i> He’s clearly nervous, staring up at the Drider Giantess with fear in his eyes. Tyrantia gives you a loaded look, like <i>“You’ve got to be kidding me.”</i> \n\n");
		outputText("<i>“I’m going to grab something to eat. If you want something, come by my hut later, okay?”</i> She simply ignores Jojo and his objections, calmly walking away. \n\n");
		outputText("<i>“Marae Above, that...Was terrifying.”</i> Jojo looks at you, expectantly. <i>“[name]...Is that corrupted...Demon...Staying?!”</i>  \n\n");
		outputText("You tell Jojo that Tyrantia is a person, not a demon. You inform Jojo that despite her corruption, Tyrantia’s proven herself to be a valuable warrior against the demon hordes many times over, a caring friend...and a surprisingly gentle soul, despite appearances. You tell Jojo that his meditation and holy practices may prove helpful to someone like her. Your words seem to hit a chord within Jojo and the monk nods.  \n\n");
		outputText("<i>“Ah...It seems that I misjudged her. My apologies''. He bows his head, looking towards Tyrantia’s hutch. <i>“I...Will attempt to make amends''. He walks quickly towards the hutch, catching Tyrantia as she’s about to leave. You see her back up a step, but as Jojo talks to her, she smiles, looking back up towards you for a second. You nod, and she scratches the back of her head as Jojo talks. You’re too far away to make out the conversation, but Jojo and Tyrantia head off towards the woods together, and appear to be making small talk.  \n\n");
doNext(camp.returnToCamp);
}

public function TyrantiaSpar():void {
		clearOutput();
		outputText("Tyrantia looks down at you in mild disbelief. She seems to take a few seconds to understand what you’ve just asked.  \n\n"); 
		outputText("<i>“Look, [name]...Look at me”</i>. She gives you a stare, somewhat concerned, as she spreads her arms wide. The fur on her arms can’t fully conceal the massive muscles you know are there. Her metal leg-spikes, still on, leave indents in the ground where she moves. Tyrantia stands over fourteen feet tall, and the twin horns on her head buzz with the corrupt aura you know she keeps suppressed. Despite her intimidating stature, her five purple eyes are soft, unsure. <i>“...I don’t want to hurt you. I know you can handle yourself against those demon filth, but...They made me stronger, and…”</i> Tyrantia closes her eyes. <i>“Are you sure you want me to fight you?”</i> \n\n");
		
menu();
addButton (1, "Yes", TyrantiaSparYes);
addButton (2, "No", TyrantiaSparNo);
}



public function TyrantiaSparYes():void {
		clearOutput();
		outputText("You tell her that you want to get stronger, and if that means fighting someone like her, then so be it. She glances down, and you smile up at her, adding that you trust her more than she realizes.  \n\n"); 
		outputText("<i>“Very well…But one more question. I can fight you like we’re sparring…or if you really feel like you can take it…We can go all out.”</i> Tyrantia really doesn’t seem to like the second option, but she offers it, nonetheless.  \n\n");
menu();
addButton (1, "Spar", TyrantiaHoldsBack);
addButton (2, "Fight", TyrantiaAllOut);
}

public function TyrantiaHoldsBack():void {
		clearOutput();
		if (TyrantiaFollowerStage > 0) {
		outputText("Tyrantia nods, her full lips set into a line. She strides over to her hutch, and comes back out carrying her Dick. Her quadruple tits are hidden once more behind a layer of thick black steel, and she levels the phallic spear at you. You can see the pinkish venom pooling on the tip, and she brandishes the weapon with smooth, swift movements.  \n\n"); 
		outputText("<i>“Come on then, [name], show me what you’re made of!”</i> \n\n");
		}
		else {
		outputText("Tyrantia points to a nearby flat area, the rocks swept aside. You join her there, and her eyes glow as she levels her spear, spreading her legs out into a wide stance. You notice she isn’t putting much weight on her front legs, and you suspect she’s just as ready to strike with those as with her Phallic Spear. \n\n");
		outputText("<i>“Show me what you’ve got!”</i>  \n\n");
//Tyrantia Fight here
}

public function TyrantiaAllOut():void {
		clearOutput();
		if (TyrantiaFollowerStage > 0) {
		outputText("Your Drider companion sighs heavily. <i>“Well…Don’t say I didn’t warn you.”</i> She leads you out of camp, back to the battlefield, not far from where you’d first met her.  \n\n"); 
		}
		outputText("Tyrantia points to a nearby flat area, the rocks swept aside. You join her there, and her eyes glow as she levels her spear, spreading her legs out into a wide stance. You notice she isn’t putting much weight on her front legs, and you suspect she’s just as ready to strike with those as with her Phallic Spear. \n\n");
		outputText("<i>“Show me what you’ve got!”</i> \n\n");
//Tyrantia Fight, with her corruption aura
}
}
}
