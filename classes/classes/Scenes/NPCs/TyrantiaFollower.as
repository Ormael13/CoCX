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
		public static var TyrantiaTalks:Number;
		public static var TyrantiaAffectionMeter:Number;
		public static var TyrantiaFollowerStage:Number;

		public function stateObjectName():String {
			return "TyrantiaFollower";
		}

		public function resetState():void {
			TyrantiaTalks = 0;
			TyrantiaAffectionMeter = 0;
			TyrantiaFollowerStage = 0;
		}

		public function saveToObject():Object {
			return {
				"TyrantiaTalks": TyrantiaTalks,
				"TyrantiaAffectionMeter": TyrantiaAffectionMeter,
				"TyrantiaFollowerStage": TyrantiaFollowerStage
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				TyrantiaTalks = o["TyrantiaTalks"];
				TyrantiaAffectionMeter = o["TyrantiaAffectionMeter"];
				TyrantiaFollowerStage = o["TyrantiaFollowerStage"];
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
	if (TyrantiaAffectionMeter > 100) TyrantiaAffectionMeter = 100;
	else if (TyrantiaAffectionMeter < 0) TyrantiaAffectionMeter = 0;
	return TyrantiaAffectionMeter;
}
public function tyraniaAffection2(changes:Number = 0):Number {
	TyrantiaAffectionMeter += changes;
	if (TyrantiaAffectionMeter > 60) TyrantiaAffectionMeter = 60;
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
	tyraniaAffection2(5);
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
	tyraniaAffection2(5);
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
	tyraniaAffection2(10);
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
	tyraniaAffection2(5);
	menu();
	addButton(1, "Heal", postFightOptionsHeal);
	addButton(2, "Kiss", postFightOptionsKiss);
	addButton(3, "Rape", postFightOptionsRape);
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
	tyraniaAffection2(6);
	cleanupAfterCombat();
}
public function postFightOptionsHealSex():void {
	clearOutput();
	outputText("You tell her that there are plenty of demons who’d love to get their hands on her body, and that you’d rather keep her to yourself.\n\n");
	outputText("\"<i>Horndog,</i>\" she complains. \"<i>...Thank you, I guess.</i>\" After about an hour, she stands, looking down at you with a conflicted look on her face. ");
	outputText("\"<i>...Thanks...You might want to get looked at for Corruption though.</i>\" You give her a questioning look, and she turns away.\n\n");
	tyraniaAffection2(3);
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
		tyraniaAffection2(2);
		cleanupAfterCombat();
	}
}
public function postFightOptionsKissStop():void {
	outputText("She sighs in relief, none of her eyes meeting yours. \"<i>Look…[name]. I...I have...Reasons for pushing you away. I’m sorry, I just…</i>\" The giantess looks close to tears, and you find yourself staring at her eyes. ");
	outputText("\"<i>Don’t look at me like that. It’s not you. Marae knows it’s not you.</i>\" She lies there, still, and for a while, says and does nothing while several waves of black energy pours from her horn.\n\n");
	tyraniaAffection2(4);
	cleanupAfterCombat();
}
public function postFightOptionsKissKeepGoing():void {
	outputText("You tell her that whatever’s wrong, she can tell you. You kiss her again, and she pushes you away, this time strong enough to dislodge you. She tries to stand, to stagger away, roaring in anger. \"<i>Weak! Stupid!</i>\" She falls again, staying down. ");
	outputText("\"<i>Just LEAVE ME BE!</i>\" She blindly fires a black web at you, missing by a mile. You decide it’s time to leave, and the sobbing giant’s tears fade away behind you as you walk back towards camp.\n\n");
	tyraniaAffection2(-2);
	cleanupAfterCombat();
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
	addButton(4, "Leave", camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldTalk():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	menu();
	addButton(4, "Leave", camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldTalk1():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	//affection gains
	doNext(camp.returnToCampUseOneHour);
}
public function repeatEncounterBattlefieldTalk2():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	//affection gains
	doNext(camp.returnToCampUseOneHour);
}
	}
}