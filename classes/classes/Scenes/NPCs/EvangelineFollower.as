/**
 * ...
 * @author Ormael
 */

package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Eyes;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Items.Armor;
import classes.Items.HeadJewelry;
import classes.Items.HeadJewelryLib;
import classes.Items.Shield;
import classes.Items.Undergarment;
import classes.Items.Weapon;
import classes.Items.WeaponRange;
import classes.Scenes.Monsters.Imp;
import classes.internals.SaveableState;

import coc.view.ButtonDataList;

public class EvangelineFollower extends NPCAwareContent implements SaveableState
	{
		public static var EvangelinePeepTalkOnInternalMutations:Number;
		public static var EvangelineGemsPurse:Number;
		public static var EvangelineTalks:Number;
		public static var EvangelineAffectionMeter:Number;
		public static var EvangelineFollowerStage:Number;
		public static var EvangelineVirginity:Boolean;
		public static var EvangelineSex1:Boolean;
		public static var EvangelineCuringArigeanInfection:Number;

		public function stateObjectName():String {
			return "EvangelineFollower";
		}

		public function resetState():void {
			EvangelinePeepTalkOnInternalMutations = 0;
			EvangelineGemsPurse = 0;
			EvangelineTalks = 0;
			EvangelineAffectionMeter = 0;
			EvangelineFollowerStage = 0;
			EvangelineVirginity = false;
			EvangelineSex1 = false;
			EvangelineCuringArigeanInfection = 0;
		}

		public function saveToObject():Object {
			return {
				"EvangelinePeepTalkOnInternalMutations": EvangelinePeepTalkOnInternalMutations,
				"EvangelineGemsPurse": EvangelineGemsPurse,
				"EvangelineTalks": EvangelineTalks,
				"EvangelineAffectionMeter": EvangelineAffectionMeter,
				"EvangelineFollowerStage": EvangelineFollowerStage,
				"EvangelineVirginity": EvangelineVirginity,
				"EvangelineSex1": EvangelineSex1,
				"EvangelineCuringArigeanInfection": EvangelineCuringArigeanInfection
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				EvangelinePeepTalkOnInternalMutations = o["EvangelinePeepTalkOnInternalMutations"];
				EvangelineGemsPurse = o["EvangelineGemsPurse"];
				EvangelineTalks = o["EvangelineTalks"];
				EvangelineAffectionMeter = o["EvangelineAffectionMeter"];
				EvangelineFollowerStage = o["EvangelineFollowerStage"];
				EvangelineVirginity = valueOr(o["EvangelineVirginity"], false);
				EvangelineSex1 = valueOr(o["EvangelineSex1"], false);
				EvangelineCuringArigeanInfection = valueOr(o["EvangelineCuringArigeanInfection"], 0);
			} else {
				// loading from old save
				resetState();
			}
		}

		public function EvangelineFollower()
		{
			Saves.registerSaveableState(this);
		}

public function evangelineAffection(changes:Number = 0):Number
{
	EvangelineAffectionMeter += changes;
	var AffCap:Number = 40;
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 5) AffCap += 20;
	if (flags[kFLAGS.EVANGELINE_LVL_UP] < 5 && EvangelineAffectionMeter > AffCap) EvangelineAffectionMeter = AffCap;
	else if (EvangelineAffectionMeter < 0) EvangelineAffectionMeter = 0;
	return EvangelineAffectionMeter;
}

public function enterTheEvangeline():void
{
	clearOutput();
	EvangelineAffectionMeter = 1;
	outputText("You head out to explore the area when a scream surprises you.\n\n");
	outputText("\"<i>H-help!!</i>\"\n\n");
	outputText("You turn around only for a woman to suddenly flings herself into your arms. She looks like she’s has been roughed up a bit - her simple peasant’s robes have been torn and frayed, and her forehead is streaked with dirt, as if she was dragged through it.\n\n");
	outputText("\"<i>Th-thank gods! Please, you must help me!</i>\" she cries, darting behind you as if to hide. \"<i>I was wandering over the wasteland trying to find a safe place to hide, and, and... the wretched, terrible little things attacked me!</i>\"\n\n");
	outputText("On top of everything, you’re worried that this happened a bit too soon after you left your camp, and you’re about to question her, but you're interrupted as an imp flies out of the sky, growling and clawing at you menacingly. If not for the closeness to your camp you would not care too much, but better to deal with this demon spawn now than later see a whole swarm of them storming your camp.");
	camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_IMPS);
	startCombat(new Imp());
	doNext(playerMenu);
}

public function winEvangelineImpFight():void
{
	clearOutput();
	outputText("\"<i>Is it safe now?</i>\" Right after you showed that imp who is the champion here, the woman who was standing still while watching you fight from the side asks if it’s safe. After you assure her that it is, she relaxes. After a moment you start asking her about what happened.\n\n");
	outputText("\"<i>I had gone out to find some supplies when I met this creature,</i>\" she says, still casting glances to her sides, \"<i>And then not thinking much, I started to run towards my hiding place, hoping I’d be faster than my pursuer, but he was quite persistent and chased me almost the whole way back. I was so scared he would find that place and then call for his friends. But at the moment I was about to risk it and hide there, you showed up.</i>\"\n\n");
	outputText("As she talks you realize something, did she mention her hiding place is near here? Isn’t that dangerous? Someone you don’t know practically admitted that she is living very close to the portal that you said you would defend. What if she is a demon? Wishing to make things clear you wait till she’s finished talking and ask her directly where she lives. First she seems to be surprised, then becomes confused, and then after that a slight hint of fear before finally answering.\n\n");
	outputText("\"<i>It’s just moment away from your...</i>\" she casts a glance over your shoulder \"<i>...camp. Suprising that anyone wish to stay here as i heard it's a cursed piece of land that anyone even demons avoids, but for someone like me it gives a good cover and scares off potential scavengers. Still I've been reconsidering moving myself somewhere else, maybe to that desert city or to a different place, as those lil assholes been recently more active around this area. But...moving all my stuff would take a lot of time. ");
	outputText("Especially all my alchemical equipment that those little red devils didn’t find or smash.</i>\"\n\nAlchemical equipment? Looking at her you wouldn’t have guessed she was an alchemist. You ask her about this and she seems to brighten up and starts talking happily about various experiments she made in the past for no discernible reason. And just when you start to ponder about how to interrupt her she suddenly ceases talking, but only for a short moment.\n\n");
	outputText("\"<i>I know you don’t know me and likely don’t trust me, but could you let me live near your camp? Since you're here it may be bit safer to stay here unless you also belive in that cursed land rumors. I could help you in case you somehow...transform too much or in some way you don't want to, return to your previous form, or grant you new ones, stronger and more fitted to survive here,</i>\" for a moment you seem to see a gleam in her eye, \"<i>so what do you think? By the way my name’s Evangeline.</i>\"");
	cleanupAfterCombat();
	menu();
	addButton(0, "Move In", Tak);
	addButton(1, "Leave", Nie);
}

public function Tak():void
{
	clearOutput();
	outputText("She may be a suspicious person, but you could say the same about everyone else you’ve met in this realm so far. And after looking at her more closely and how she is now not looking around nervously anymore, you notice that she has got these weird looking eyes, like two cat-like slits crossing in the middle to form a X over the middle of her pupil. If you don’t take this into account she passes for a normal human. Out of curiosity, you casually ask her about her eyes, since normal people don’t have such eyes like this.\n\n");
	outputText("\"<i>My eyes..? Ohh that.</i>\" The mention of her eyes seem to make her nervous again. \"<i>You could say it’s the effect of me living in this tainted realm. Some get some 'extras' when born and I just merely gained these weird eyes. Although they have not bestowed me with night vision like for those cat-morphs.</i>\"\n\n");
	outputText("After that you two start to talk for some time about various things. It turns out she’s one of the few remaining humans that have not been taken prisoner or have been already turned into demons. After a long time spent chatting with Evangeline, you change subject to the one of her hideouts. Since you decided to give her a chance it won’t be good if she still stays quite far away from the camp perimeter. So you mention that she can move within your camp borders.\n\n");
	outputText("\"<i>Thank you so much. I will go to my old cave and take my essentials.</i>\" After this Evangeline walks toward a group of large stones, and by moving one of them reveals a cave entrance hidden behind it. Shortly after disappearing your new camp member comes out carrying a bedroll and a small chest. Then despite your protests she picks the spot almost at the edge of the camp as her own.\n\n");
	outputText("\"<i>I didn’t bring any alchemical reagents with me, so if you will need something made I will still need to venture to my old place. But do not worry, those rocks will mask the entrance well... unless some very powerful demon comes here by chance.</i>\" she chuckles and seeing your concerned face quickly reassures that chances for a strong demon to casually wander by are slim.\n\n");
	outputText("\"<i>I’m sorry there’s something important near your camp I must keep watch on so I had to invovle you earlier while been chased by the imp. Any help was better than no help, right? Have this fruit as an apology it should be very useful to you.</i>\"\n\n");
	outputText("With all her things organized she heads out of your camp right away out to 'look for more stuff' for alchemical experiments.\n\n");
	outputText("(<b>Evangeline has been added to the Followers menu!</b>)\n\n");
	EvangelineAffectionMeter = 3;
	EvangelineFollowerStage = 1;
	if (player.hasKeyItem("Radiant shard") >= 0) player.addKeyValue("Radiant shard",1,+1);
	else player.createKeyItem("Radiant shard", 1,0,0,0);
	outputText("\n\n<b>Before fully settling in your camp as if remembering something Evangeline pulls a shining shard from her inventory and hand it over to you as a gift. You acquired a Radiant shard!</b>");
	flags[kFLAGS.EVANGELINE_LVL_UP] = 0;
	flags[kFLAGS.EVANGELINE_SPELLS_CASTED] = 0;
	//if (player.hasStatusEffect(StatusEffects.EzekielCurse)) player.removeStatusEffect(StatusEffects.EzekielCurse);
	inventory.takeItem(consumables.EZEKFRU, explorer.done);
}

public function Nie():void
{
	clearOutput();
	outputText("You don’t know her just as she pointed it out. So without veiling anything you say she needs to move her hideout somewhere else.\n\n");
	outputText("\"<i>So that’s how it is? I just wanted to be nice and friendly but you just outright reject my offer.</i>\" She sighs, before slowly turning around. While starting to walk away you still hear her utter few last words. \"<i>Having someone who can help you keep transformations under control would be useful whoever you are. I will soon move out but in case you find some 'unexpected' troubles I will linger around this area for a little bit. Until we meet again stranger.</i>\"\n\n");
	outputText("After rejecting Evangeline’s offer of joining camp you feel satisfied. She could have been just another demoness that was trying to lure you away from your quest. But...those last words somehow were odd. Unexpected troubles?\n\n");
	EvangelineAffectionMeter = 2;
	endEncounter();
}

public function alternativEvangelineRecruit():void
{
	clearOutput();
	outputText("Just after leaving the camp you notice a familiar figure strolling casually nearby. It’s Evangeline, which after seeing you stops to let you close the distance between you two.\n\n");
	outputText("\"<i>We meet again [name]. Did you give second thoughts to my proposition? Or do you still think having the help of someone knowing a lot about transformations and other negative ailments or positive health of the body isn’t worth the risk?</i>\" This time she seems less bent on convincing you, and recalling your past days situation it only works in her favor. Will you let her stay under your watchful eye in camp or still decline?\n\n");
	menu();
	addButton(0, "Stay", Tak);
	addButton(1, "No", Nie2);
}

public function Nie2():void
{
	clearOutput();
	outputText("After moment of hesitation you once again decline her offer. Saying something about doing pretty well so far, you leave her be. Still your next hour is wasted on wandering around without any actual purpose.\n\n");
	endEncounter();
}

public function meetEvangeline():void {
	clearOutput();
	if (ZenjiScenes.isLover() && rand(4) == 0) {
		outputText("You call your transformations expert, Evangeline, but you get no response. After a moment you decide to head over to her.\n\n");
		outputText("When you arrive, you already see Zenji hovering over her shoulder, his tail nervously coiling around himself. Evangeline is showing Zenji what the transformations do and ensuring him that it will cause no harm to any imbibers.\n\n");
		outputText("Zenji seems somewhat unconvinced at her assurance. \"<i>If dat is what you say so, but if you dare harm [name], just know dat I will be de first to know.</i>\"\n\n");
		outputText("Evangeline mumbles something under her breath, a little perturbed by his presence."+(player.isHavingEnhancedHearing() ? " \"<i>Is everything going to be my fault now..? I'm just trying to help, but my work is not the same as yours...</i>\"":"")+"\n\n");
		outputText("Zenji sighs, \"<i>I guess I’m being too hard on ya, you’re right…</i>\" He says, giving her a gentle pat on the shoulder.\n\n");
		outputText("Evangeline seems slightly comforted by that statement.\n\n");
		outputText("\"<i>Well, if you have no other questions it looks like [name] wants to talk to me now.</i>\" She mumbles again.\n\n");
		outputText("Zenji nods and gives you a brief hug before leaving you alone with Evangeline.\n\n");
	}
	else outputText("Deciding to visit your camp’s transformation expert you called Evangeline. Shortly after that she slowly walks toward you.\n\n");
	if (player.hasStatusEffect(StatusEffects.ArigeanInfected) && player.statusEffectv3(StatusEffects.ArigeanInfected) == 0) curingArigean1();
	if (!player.hasStatusEffect(StatusEffects.ArigeanInfected) && player.statusEffectv3(StatusEffects.ArigeanInfected) == 0 && player.tailType == Tail.ARIGEAN_GREEN) curingArigean2();
	if (!player.hasStatusEffect(StatusEffects.ArigeanInfected) && player.statusEffectv3(StatusEffects.ArigeanInfected) == 0 && player.tailType == Tail.ARIGEAN_RED) curingArigean3();
	if (!player.hasStatusEffect(StatusEffects.ArigeanInfected) && player.statusEffectv3(StatusEffects.ArigeanInfected) == 0 && player.tailType == Tail.ARIGEAN_YELLOW) curingArigean4();
	outputText("\"<i>Hi [name]! Anything I can help you with?</i>\"");
	// [Appearan] [ Talk   ] [   Sex  ] [ Spar   ] [GiveGems]
	// [Alchemy ] [Ingreds ] [        ] [I.Mutati] [Experime]
	// [Arigean ] [Wendigo ] [Jiangshi] [Soul Gem] [ Back   ]
	menu();
	addButton(0, "Appearance", evangelineAppearance).hint("Examine Evangeline's detailed appearance.");
	addButton(1, "Talk", evangelineTalkMenu).hint("Ask Evangeline about something.");
	if (EvangelineAffectionMeter >= 50) addButton(2, "Sex", evangelineSexMenu).hint("Have some sex with the demonic chimera girl.");//godess
	if (EvangelineAffectionMeter >= 5) {
		addButton(3, "Spar", evangelineSparMenu).hint("Get into a quick battle with Evangeline!")
			.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 2, "You need a good sparring ring for that.");
		if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 1) addButton(4, "Give Gems", LvLUp).hint("Give Evangeline some gems to cover her expenses on getting stronger.");
		else addButtonDisabled(4, "Give Gems", "Req. sparring with Evangeline at least once.");
		addButton(8, "I.Mutations", InternalMutations).hint("Check on what internal mutations Evangeline can grant you.");
	}
	else {
		addButtonDisabled(3, "Spar", "Req. 5%+ affection and built sparring ring.");
		addButtonDisabled(4, "Give Gems", "Req. 5%+ affection and sparring with Evangeline at least once.");
		addButtonDisabled(8, "I.Mutations", "Req. 5%+ affection.");
	}
	addButton(5, "Alchemy", evangelineAlchemyMenu).hint("Ask Evangeline to make some transformation item.");
	addButton(6, "Ingredients", ingredientsMenu).hint("Ask Evangeline to make some alchemy ingredients");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 5) addButton(9, "Experiments", Experiments).hint("Check on what experiments Evangeline can work on.");//menu do eksperymentow alchemicznych jak tworzenie eksperymentalnych TF lub innych specialnych tworow evangeline typu specjalny bimbo liq lub tonik/coskolwiek nazwane wzmacniajace postacie do sparingu w obozie
	else addButtonDisabled(9, "???", "Req. Evangeline been lvl 16+.");
	if (player.hasStatusEffect(StatusEffects.ArigeanInfected) || player.tailType == Tail.ARIGEAN_GREEN || player.tailType == Tail.ARIGEAN_RED || player.tailType == Tail.ARIGEAN_YELLOW || player.tailType == Tail.ARIGEAN_PRINCESS) addButton(10, "Arigean I.", curingArigeanMain);
	else addButtonDisabled(10, "???", "Req. to be infected by Arigean.");
	if (player.hasPerk(PerkLib.WendigoCurse)) {
		if (player.perkv1(PerkLib.WendigoCurse) > 0) {
			if (player.hasItem(consumables.PURPEAC, 5) && player.hasItem(consumables.PPHILTR, 5)) addButton(11, "Wendigo", curingWendigo);
			else addButtonDisabled(11, "Wendigo", "Req. five pure peaches and five purity philters to fix your 'issue'.");
		}
		else addButton(11, "Wendigo", curingWendigo);
	}
	else addButtonDisabled(11, "???", "Req. to be cursed by Wendigo.");
	if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 2 || flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 3) {
		if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 2) addButton(12, "Jiangshi", curingJiangshi);
		else if (player.hasItem(consumables.VITAL_T, 5) && player.hasItem(consumables.PPHILTR, 5)) addButton(12, "Jiangshi", curingJiangshi);
		else addButtonDisabled(12, "Jiangshi", "Req. five vitality tinctures and five purity philters to fix your 'issue'.");
	}
	else addButtonDisabled(12, "???", "Req. to be Jiangshi.");
	if (player.hasKeyItem("Soul Gem Research") >= 0) {
		if (player.statusEffectv1(StatusEffects.SoulGemCrafting) == 0)  addButton(13, "Soul Gem", receivingCraftedSoulGem).hint("Pick up crafted Soul Gem.");
		if (!player.hasStatusEffect(StatusEffects.SoulGemCrafting)) addButton(13, "Soul Gem", craftingSoulGem).hint("Ask Evangeline for crafting Soul Gem.");
	}
	else addButtonDisabled(13, "???", "Req. to acquire Soul Gem Research materials first.");
	addButton(14, "Back", camp.campFollowers);
}

private function evangelineAppearance():void {
	clearOutput();
	outputText("Evangeline is ");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 10) outputText("eight feet");
	else outputText("seven and a half feet");
	outputText(" tall.\n\n");
	outputText("Oddly despite living in Mareth she looks like a human aside from her eyes that have uncanny pupils, which after narrowing looks like two cat slits that forms an X shape over her golden eyes. Her ");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 5) outputText("crimson platinum ");
	else outputText("red ");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 10) outputText("hair are ass-length along with breats that could easily fill a F-cup bra, expansive ass and fertile hips.\n\n");
	else if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 5) outputText("hair are ass-length along with breats that could easily fill a E-cup bra, jiggly ass and curvy hips is quite a change that resulted from her drinking bimbo liquer personaly modified by her.\n\n");
	else outputText("hair short along with breasts not bigger than A cup, almost non-existent butt and boyish hips cause her to look quite tomboyish.\n\n");
	//outputText(".\n\n");
	outputText("She's wearing ");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 8) outputText("a skimpy chain bikini that barely qualifies as armor. The chain is made from links much finer and lighter than normal, so fine that it feels almost silken under fingertips. A simple seal in the g-string-like undergarment states, \"Virgins only.\"");
	else if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 3) outputText("a suit of steel 'armor' which have two round disks that barely cover her nipples, a tight chainmail bikini, and circular butt-plates.");
	else outputText("a simple peasant’s robe that’s torn and frayed in a few places.");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 3) outputText("\n\nBetween collarbones there is a medium sized purple crystal sticking out of her skin that sometimes gently glows.");
	doNext(meetEvangeline);
}

private function evangelineTalkMenu():void {
	clearOutput();
	outputText("What would you like to discuss with Evangeline?");
	menu();
	addButton(0, "Your Eyes", TalkYourEyes).hint("Talk about her unusual eyes.");
	if (EvangelineTalks >= 1) addButton(1, "Demons", TalkDemons).hint("Ask about demons in general.");
	else addButtonDisabled(1, "???", "???");
	if (EvangelineTalks >= 2) addButton(2, "Past Life", TalkPastLife1).hint("Talk about her past before meeting you.");
	else addButtonDisabled(2, "???", "???");
	if (EvangelineTalks >= 3) {
		if (EvangelineAffectionMeter >= 30) addButton(3, "Father", TalkYourFather).hint("Talk about her father.");
		else addButtonDisabled(3, "???", "Req. 30%+ affection");
	}
	else addButtonDisabled(3, "???", "???");
	//if (EvangelineTalks >= 4) addButton(4, "4", ).hint("");her soul? - jak sie PC dowie o byciu demonicą przez nią?
	//if (EvangelineTalks >= 5) addButton(5, "5", ).hint("");
	addButton(14, "Back", meetEvangeline);
}
private function TalkYourEyes():void {
	clearOutput();
	outputText("At first you exchange a few casual word with Evangeline and then you change the subject to her eyes. She has very unusual X shaped irises, and if not for them she could pass for another human. She pauses for a moment before replying.\n\n");
	if (EvangelineTalks >= 1) outputText("\"<i>So you once again want talk about it? Let it be,</i>\"");
	else outputText("\"<i>I was kinda expecting that you would ask about them eventually,</i>\"");
	outputText(" she laughs, her gaze casting toward the ground for a moment. \"<i>Most people ask me the same question sooner or later. To tell you the truth I believe I inherited them from my father, since he had the same eyes too.</i>\" There is a clear sadness in her eyes as she says this.\n\n");
	outputText("\"<i>They are not giving me any benefit I know about, beside making me look like a freak. Well at least all the humans I met before told me this. And some even felt constantly uneasy around me thinking I'm some kind of abomination. Well at least until...</i>\" suddenly she stops and when you question the reason she giving you a gaze saying 'I don't wanna talk about it'. Well looks like they are just a rare trait. But she mentioned something about her father. Changing subject you ask about him.\n\n");
	outputText("\"<i>My father...</i>\" she pauses for a moment before shaking her head. \"<i>No I do not want to talk about him now either. Sorry can you leave me alone for a while?</i>\"");
	evangelineAffection(1);
	if (EvangelineTalks == 0) EvangelineTalks = 1;
	doNext(evangelineTalkMenu);
	advanceMinutes(15);
}
private function TalkDemons():void {
	clearOutput();
	outputText("This time you chat with her about demons in general, like what types of them she’s seen so far or some details about them. Knowing that you’re gonna spend some time in this realm, maybe even the rest of your life, anyone who could help you in your quest would be very useful and she seems like she may know something.\n\n");
	outputText("It turns out Evangeline knows quite a bit about demons. Most of what she knows you already figured out on your own or could have guessed ");
	if (EvangelineTalks >= 2) outputText("but one or two thing are still new to you");
	else outputText("but a few things you’re hearing for the first time");
	outputText(". Large parts of your conversation is spent on discussing the structure of chain of command amongst demons. Feeling satisfied after learning something new you thank her after you finish talking.");
	evangelineAffection(1);
	if (EvangelineTalks == 1) EvangelineTalks = 2;
	doNext(evangelineTalkMenu);
	advanceMinutes(15);
}
private function TalkPastLife1():void {
	clearOutput();
	outputText("This time you ask Evangeline about the time you both met. What she’s been doing or how she managed to avoid demons. For a really long moment she remained silent.\n\n");
	outputText("\"<i>I’m not a champion like you. I have just been living day after day, escaping to the hideouts I made when any of the demons noticed me.</i>\"\n\nOnce again there’s a hint of sadness in her voice.\n\n\"<i>But they were quite persistent in searching for me, always finding each hideout quite fast. With time I wouldn’t get a chance to eat much, so I would get weaker and weaker till one day I would probably be too weak to escape them.</i>\"\n\n");
	outputText("So she was running away from them but that makes you curious to what was the reason she was chased for. She never mentioned anything about demons being so 'organized' and overcoming their typical 'fuck everything' attitude.\n\n");
	outputText("\"<i>Well there’s some reason for that.</i>\"\n\nEvangeline casts her gaze down as she continues.\n\n\"<i>Even demons can go wild for some 'things' like lethicite or other things that could make them stronger in any way.</i>\"\n\n");
	outputText("So it looks like she may have had something that caused all those demons to pursue her for so long. Probably something that is as valuable as this ‘lethicite’.\n\n");
	outputText("\"<i>Yes you could say that. But I hid it before and only by catching me would they know where it’s hidden. Luckily for me they won’t get me now when you’re here, right champion?</i>\" She gives you one of those rare smiles in which you nod to. Sadly further attempts to find out what she hid ");
	if (EvangelineTalks >= 3) outputText("once again fails");
	else outputText("turns out to be futile");
	outputText(". She talks about many things and some may or may not be lies, about this 'treasure' and how you only know it’s well hidden and the demons will never find it without her pointing to the place.");
	evangelineAffection(1);
	if (EvangelineTalks == 2) EvangelineTalks = 3;
	doNext(evangelineTalkMenu);
	advanceMinutes(15);
}
private function TalkYourFather():void {
	clearOutput();
	outputText("It's been some time she have been living here. Maybe she would tell you a bit more about herself, her past or 'the treasure' she hidden? You ask her if she could tell you something about her father.\n\n");
	if (EvangelineTalks >= 4) outputText("\"<i>Hahahaha, so you want hear that stories about me and my father again? Well, not like I got so 'much more important' things to do now.</i>\"\n\n");
	else outputText("\"<i>Hmmm. My father...</i>\" Evangeline muses to herself when she hears your reason to finding her today. \"<i>Well I've been living pretty good here for some time, and you seem to be not so untrustworthy like many others... fine.</i>\"\n\n");
	outputText("After you find a comfortable place to sit, she stays silent for a while before starting to talk. It mainly consists of stories that nearly any kid would tell, like how their father took them on a stroll or played with them. They focus much more on the places they both visited while not telling not much about her father himself.\n\n");
	outputText("\"<i>...and a few times my father took me to this old shrine. I'm not sure why we had to visit that place. It looked more like a place where devoted believers or similar people would go and...</i>\"\n\n");
	outputText("Listening to her talk, you notice some interesting facts. Of all places she been taken by her father, there was one where she wasn't allowed to run freely around. One where she had been strictly forbidden from acting in any other way than her father told her. You ask her to tell a bit more about this place.\n\n");
	outputText("\"<i>That place?</i>\" Evangeline goes silent for a moment. \"<i>It's not a good place. Even forgetting that it was located in an area where there was a massive battle between two armies, it's a place that not many people would find interesting to visit.</i>\" She seems to be bit flustered when talking about it, and excuses herself to work on something in her alchemic lab.\n\n");
	if (flags[kFLAGS.DILAPIDATED_SHRINE_UNLOCKED] < 1) flags[kFLAGS.DILAPIDATED_SHRINE_UNLOCKED] = 1;
	evangelineAffection(1);
	if (EvangelineTalks == 3) EvangelineTalks = 4;
	doNext(evangelineTalkMenu);
	advanceMinutes(15);
}/*
private function TalkPastLife2():void {
	clearOutput();
	outputText("Placeholder text.\n\n");po tym jak sie dowie PC iż jest ona demonicą ^^
	outputText("Placeholder text.\n\n");
	evangelineAffection(1);zajmie miejsce PastTalk1 w menu
	if (EvangelineTalks == 0) EvangelineTalks += 1;
	doNext(evangelineTalkMenu);
	advanceTimeNoEvents(15);
}
private function TalkPastLife3():void {
	clearOutput();
	outputText("Placeholder text.\n\n");po tym jak sie dowie PC iż jest ona boginią ^^
	evangelineAffection(1);zajmie miejsce PastTalk2 w menu
	if (EvangelineTalks == 0) EvangelineTalks += 1;//ustalić na jakiej wartości flagi bedzie sie pokazywać
	doNext(evangelineTalkMenu);
	advanceTimeNoEvents(15);
}
private function TalkYourEyes():void {
	clearOutput();
	outputText("Placeholder text.");
	evangelineAffection(1);
	if (EvangelineTalks == 4) EvangelineTalks += 1;//ustalić na jakiej wartości flagi bedzie sie pokazywać
	doNext(evangelineTalkMenu);
	advanceTimeNoEvents(15);
}
private function TalkYourEyes():void {
	clearOutput();
	outputText("Placeholder text.");
	evangelineAffection(1);
	if (EvangelineTalks == 5) EvangelineTalks += 1;//ustalić na jakiej wartości flagi bedzie sie pokazywać
	doNext(evangelineTalkMenu);
	advanceTimeNoEvents(15);
}
private function TalkYourEyes():void {
	clearOutput();
	outputText("Placeholder text.");
	evangelineAffection(1);
	if (EvangelineTalks == 6) EvangelineTalks += 1;//ustalić na jakiej wartości flagi bedzie sie pokazywać
	doNext(evangelineTalkMenu);
	advanceTimeNoEvents(15);
}
*/
private function evangelineSexMenu():void {
	clearOutput();
	outputText("Placeholder text.");
	menu();
	//addButton(0, "", ).hint("");
	//addButton(1, "", ).hint("");
	//addButton(2, "", ).hint("");
	addButton(14, "Back", meetEvangeline);
}

private function evangelineSparMenu():void {
	clearOutput();
	if (EvangelineAffectionMeter >= 50) {
		outputText("You suggest a sparring session.  Evangeline asks, \"<i>How should we fight?  Would you rather we spar light or fight like the creatures of this world?</i>\"");
		outputText("\n\n(Do you spar 'light' with no consequences for losing, or would you rather spar 'hard' (with full consequences for loss/win)?)");
	}
	else outputText("You suggest a sparring session.  Evangeline after a moment of hesistation nod in agreement.");
	menu();
	addButton(0, "Light", LightSpar);
	if (EvangelineAffectionMeter >= 50) addButton(1, "Hard", HardSpar);
	addButton(14, "Back", meetEvangeline);
}

private function LightSpar():void {
	outputText("\n\nEvangeline adjusts her ");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 8) outputText("lusty maiden's armor");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 3 && flags[kFLAGS.EVANGELINE_LVL_UP] < 8) outputText("practically indecent steel armor");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] < 3) outputText("rags");
	outputText(" and after stretching a few times she’s finished her warm up.  You raise your [weapon] and prepare to fight.  It's on!");
	startCombat(new Evangeline1());
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 0) flags[kFLAGS.EVANGELINE_LVL_UP] = 1;
	evangelineAffection(3);
	monster.XP = Math.round(monster.XP / 2);
}
private function HardSpar():void {
	outputText("\n\nEvangeline adjusts her practically indecent steel armor and after stretching few times she finished her warm up.  This time she won't hold back.  You raise your [weapon] and prepare to fight.  It's on!");
	startCombat(new Evangeline1());
	evangelineAffection(10);
}

private function evangelineAlchemyMenu(page:int = 1):void {
	clearOutput();
	outputText("\"<i>So you do want another transformational item made by me?</i>\" She asked after hearing what potion you want to purpose to her this time, at which you simply nod. Without wasting time she walks, with you closely behind, toward a entrance to a small cave right outside the camp's border, in which she keep her equipment.\n\n\"<i>So what you want this time for me to make?</i>\" Stopping at the edge of the entrance to lab Evangeline glance in your direction.");
	menu();
	if (page == 1) {
		// [Gorgon  ] [Vouivre ] [Couatl  ] [Nocello ] [Unicorn ]
		// [RubyCrys] [        ] [        ] [        ] [Alicorn ]
		// [GreyInk ] [WhiteInk] [InfernWn] [  -2-   ] [Back    ]
		addButton(0, "Gorgon Oil", MakingGorgonPotion).hint("Ask her to brew a special potion that could aid in becoming a gorgon. \n\nCost: 10 Gems \nNeeds 1 Snake Oil and 1 Reptilum.");
		addButton(1, "Vouivre Oil", MakingVouivrePotion).hint("Ask her to brew a special potion that could aid in becoming a vouivre. \n\nCost: 15 Gems \nNeeds 1 Snake Oil and 1 Drake Heart.");
		addButton(2, "Couatl Oil", MakingCouatlPotion).hint("Ask her to brew a special potion that could aid in becoming a couatl. \n\nCost: 10 Gems \nNeeds 1 Snake Oil and 1 Golden Seed.");
		addButton(3, "Nocello Liq", MakingNocelloLiqueur).hint("Ask her to brew a special potion that could aid in becoming a phoenix. \n\nCost: 10 Gems \nNeeds 1 Golden Seed and 1 Salamander Firewater.");//Hybryd race TF
		addButton(4, "Unicornum", MakingUnicornumPotion).hint("Ask her to brew a special potion that could aid in becoming a unicorn. \n\nCost: 20 Gems \nNeeds 1 Equinum and 4 Low-grade Soulforce Recovery Pills.");//1st stage Soul evolution race TF
		addButton(5, "RubyCrystal", MakingRubyCrystal).hint("Ask her to brew a special potion that could aid in becoming a kitsumori. \n\nCost: 10 Gems \nNeeds 1 Fox Jewel and 1 Salamander Firewater.");//Hybryd race TF
		//6
		//addButton(7, "", ).hint(".");siren TF//Hybryd race TF
		//8
		addButton(9, "Alicornum", MakingAlicornumPotion).hint("Ask her to brew a special potion that could aid in becoming an alicorn. \n\nCost: 50 Gems \nNeeds 1 Unicornum and 20 Low-grade Soulforce Recovery Pills/2 bottles of Low-grade Soulforce Recovery Pills.");//2nd stage Soul evolution race TF
		addButton(10, "Grey Ink", MakingGreyInkPotion).hint("Grey Ink for Herm Scylla form. \n\nCost: 10 Gems \nNeeds 1 vial of Black Ink and 1 sealed bottle of behemoth cum.");
		addButton(11, "White Ink", MakingWhiteInkPotion).hint("White Ink for Male Scylla form. \n\nCost: 20 Gems \nNeeds 1 vial of Black Ink and 2 sealed bottles of behemoth cum.");
		addButton(12, "InferWine", MakingInfernalWinePotion).hint("Ask her to brew a special potion that could aid in becoming a infernal goat/devil. \n\nCost: 480 Gems \nNeeds 1 Satyr Wine, 1 Succubi milk and 1 Incubi draft.");
		addButton(13, "-2-", evangelineAlchemyMenu, page + 1);
		addButton(14, "Back", meetEvangeline);
	}
	if (page == 2) {
		// [Centaur ] [Thunderb] [Sphinx  ] [        ] [        ]
		// [Leviathn] [        ] [        ] [        ] [        ]
		// [GreyAInk] [WhiteAIn] [        ] [  -1-   ] [ Back   ]
		addButton(0, "Centaurinum", MakingCentaurPotion).hint("Ask her to brew a special potion that could aid in becoming a centaur. \n\nCost: 10 Gems \nNeeds 1 Equinum and 1 Minotaur Blood.");
		addButton(1, "Storm Seed", MakingStormSeed).hint("Ask her to brew a special potion that could aid in becoming a thunderbird. \n\nCost: 10 Gems \nNeeds 1 Magically-enhanced Golden Seed and 1 Voltage topaz.");//Hybryd race TF
		addButton(2, "Enigmanium", MakingEnigmaniumPotion).hint("Ask her to brew a special potion that could aid in becoming a sphinx. \n\nCost: 30 Gems \nNeeds 1 Centarium, 1 Golden Seed and 1 Whisker Fruit.");
		//3
		//4
		addButton(5, "LeviSun", MakingLevisunPotion).hint("Ask her to brew a special potion that could aid in becoming a sea dragon. \n\n\nCost: 100 Gems \nNeeds 1 Drake flower and 1 Orca sunscreen.");
		//6
		//7
		//8
		//9
		addButton(10, "Grey A. Ink", MakingGreyAbyssalInkPotion).hint("Grey Abyssal Ink for Herm Kraken form. \n\nCost: 10 Gems \nNeeds 1 vial of Abyssal Ink and 1 sealed bottle of behemoth cum.");
		addButton(11, "White A. Ink", MakingWhiteAbyssalInkPotion).hint("White Abyssal Ink for Male Kraken form. \n\nCost: 20 Gems \nNeeds 1 vial of Abyssal Ink and 2 sealed bottles of behemoth cum.");
		//12
		addButton(13, "-1-", evangelineAlchemyMenu, page - 1);
		addButton(14, "Back", meetEvangeline);
	}
}

private function MakingGorgonPotion():void {
	clearOutput();
	if (player.gems < 10) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.SNAKOIL, 1) && player.hasItem(consumables.REPTLUM, 1))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need vial of Snake Oil and vial of Reptilum,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.SNAKOIL, 1);
	player.destroyItems(consumables.REPTLUM, 1);
	player.gems -= 10;
	statScreenRefresh();
	outputText("You hand over one vial of Snake Oil, one vial of Reptilum and ten gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a vial filled with an oily, greenish liquid.  ");
	inventory.takeItem(consumables.GORGOIL, curry(evangelineAlchemyMenu, 1));
	cheatTime(1/6);
}
private function MakingVouivrePotion():void {
	clearOutput();
	if (player.gems < 15) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.SNAKOIL, 1) && player.hasItem(consumables.DRAKHRT, 1))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need vial of Snake Oil and Drake Heart,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.SNAKOIL, 1);
	player.destroyItems(consumables.DRAKHRT, 1);
	player.gems -= 15;
	statScreenRefresh();
	outputText("You hand over one vial of Snake Oil, one Drake Heart and fifteen gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a vial filled with an oily, purple liquid.  ");
	inventory.takeItem(consumables.VOUIOIL, curry(evangelineAlchemyMenu, 1));
	cheatTime(1/6);
}
private function MakingCouatlPotion():void {
	clearOutput();
	if (player.gems < 10) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.SNAKOIL, 1) && player.hasItem(consumables.GLDSEED, 1))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need vial of Snake Oil and Golden Seed,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.SNAKOIL, 1);
	player.destroyItems(consumables.GLDSEED, 1);
	player.gems -= 10;
	statScreenRefresh();
	outputText("You hand over one vial of Snake Oil, one Golden Seed and ten gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a vial filled with an oily, red liquid.  ");
	inventory.takeItem(consumables.COUAOIL, curry(evangelineAlchemyMenu, 1));
	cheatTime(1/6);
}
private function MakingUnicornumPotion():void {
	clearOutput();
	if (player.gems < 20) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.EQUINUM, 1) && player.hasItem(consumables.LG_SFRP, 4))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need vial of Equinum and four Low-grade Soulforce Recovery Pills,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.EQUINUM, 1);
	player.destroyItems(consumables.LG_SFRP, 4);
	player.gems -= 20;
	statScreenRefresh();
	outputText("You hand over one vial of Equinum, four Low-grade Soulforce Recovery Pills and twenty gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a vial labeled \"Unicornum\".  ");
	inventory.takeItem(consumables.UNICORN, curry(evangelineAlchemyMenu, 1));
	cheatTime(1/6);
}
private function MakingNocelloLiqueur():void {
	clearOutput();
	if (player.gems < 10) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.GLDSEED, 1) && player.hasItem(consumables.SALAMFW, 1))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need Golden Seed and hip flask of Salamander Firewater,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.GLDSEED, 1);
	player.destroyItems(consumables.SALAMFW, 1);
	player.gems -= 10;
	statScreenRefresh();
	outputText("You hand over one Golden Seed, one hip flask of Salamander Firewater and ten gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a bottle labeled \"Nocello\".  ");
	inventory.takeItem(consumables.NOCELIQ, curry(evangelineAlchemyMenu, 1));
	cheatTime(1/6);
}
private function MakingAlicornumPotion():void {
	clearOutput();
	if (player.gems < 50) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.UNICORN, 1) && (player.hasItem(consumables.LG_SFRP, 20) || (player.hasItem(consumables.LGSFRPB, 2))))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need vial of Unicornum and two bottles of Low-grade Soulforce Recovery Pills. In case you don't have two bottles then twenty Low-grade Soulforce Recovery Pills would work too,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.UNICORN, 1);
	player.gems -= 50;
	statScreenRefresh();
	outputText("You hand over one vial of Unicornum, ");
	if (player.hasItem(consumables.LGSFRPB, 2)) {
		outputText("two bottles of");
		player.destroyItems(consumables.LGSFRPB, 2);
	}
	else {
		outputText("twenty");
		player.destroyItems(consumables.LG_SFRP, 20);
	}
	outputText(" Low-grade Soulforce Recovery Pills and fifty gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a vial labeled \"Alicornum\".  ");
	inventory.takeItem(consumables.ALICORN, curry(evangelineAlchemyMenu, 1));
	cheatTime(1/6);
}
private function MakingRubyCrystal():void {
	clearOutput();
	if (player.gems < 10) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.FOXJEWL, 1) && player.hasItem(consumables.SALAMFW, 1))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need Fox Jewel and hip flask of Salamander Firewater,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.FOXJEWL, 1);
	player.destroyItems(consumables.SALAMFW, 1);
	player.gems -= 10;
	statScreenRefresh();
	outputText("You hand over one Fox Jewel, one hip flask of Salamander Firewater and ten gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a ruby crystal.  ");
	inventory.takeItem(consumables.RUBYCRY, curry(evangelineAlchemyMenu, 1));
	cheatTime(1/6);
}
private function MakingGreyInkPotion():void {
	clearOutput();
	if (player.gems < 10) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.BLACKIN, 1) && player.hasItem(consumables.BHMTCUM, 1))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need vial of Black Ink and one sealed bottle of behemoth cum,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.BLACKIN, 1);
	player.destroyItems(consumables.BHMTCUM, 1);
	player.gems -= 10;
	statScreenRefresh();
	outputText("You hand over one vial of Black Ink, one sealed bottle of behemoth cum and fifty gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a vial of Grey Ink.  ");
	inventory.takeItem(consumables.GREYINK, curry(evangelineAlchemyMenu, 1));
	cheatTime(1/6);
}
private function MakingWhiteInkPotion():void {
	clearOutput();
	if (player.gems < 20) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.BLACKIN, 1) && player.hasItem(consumables.BHMTCUM, 2))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need vial of Black Ink and two sealed bottle of behemoth cum,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.BLACKIN, 1);
	player.destroyItems(consumables.BHMTCUM, 2);
	player.gems -= 20;
	statScreenRefresh();
	outputText("You hand over one vial of Black Ink, two sealed bottles of behemoth cum and fifty gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a vial of White Ink.  ");
	inventory.takeItem(consumables.WHITEIN, curry(evangelineAlchemyMenu, 1));
	cheatTime(1/6);
}
private function MakingInfernalWinePotion():void {
	clearOutput();
	if (player.gems < 480) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.SATYR_W, 1) && player.hasItem(consumables.SUCMILK, 1) && player.hasItem(consumables.INCUBID, 1))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need bottle of Satyr Wine, bottle of Succubi milk and Incubi draft,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.SATYR_W, 1);
	player.destroyItems(consumables.SUCMILK, 1);
	player.destroyItems(consumables.INCUBID, 1);
	player.gems -= 480;
	statScreenRefresh();
	outputText("You hand over one bottle of Satyr Wine, bottle of Succubi milk, Incubi draft and four hundred eighty gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a bottle of infernal wine.  ");
	inventory.takeItem(consumables.INFWINE, curry(evangelineAlchemyMenu, 1));
	cheatTime(1/4);
}

private function MakingCentaurPotion():void {
	clearOutput();
	if (player.gems < 10) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.EQUINUM, 1) && player.hasItem(consumables.MINOBLO, 1))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need vial of Equinum and vial of Minotaur blood,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.EQUINUM, 1);
	player.destroyItems(consumables.MINOBLO, 1);
	player.gems -= 10;
	statScreenRefresh();
	outputText("You hand over one vial of Equinum, one vial of Minotaur Blood and ten gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a vial labeled \"Centaurinum\".  ");
	inventory.takeItem(consumables.CENTARI, curry(evangelineAlchemyMenu, 2));
	cheatTime(1/6);
}
private function MakingStormSeed():void {
	clearOutput();
	if (player.gems < 10) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.MAGSEED, 1) && player.hasItem(consumables.VOLTTOP, 1))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need Magically-enhanced Golden Seed and Voltage topaz,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.MAGSEED, 1);
	player.destroyItems(consumables.VOLTTOP, 1);
	player.gems -= 10;
	statScreenRefresh();
	outputText("You hand over one Magically-enhanced Golden Seed, one Voltage topaz and ten gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a magical seed that radiate a faint aura of static as if struck by lightning.  ");
	inventory.takeItem(consumables.SRMSEED, curry(evangelineAlchemyMenu, 2));
	cheatTime(1/6);
}
private function MakingEnigmaniumPotion():void {
	clearOutput();
	if (player.gems < 30) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.CENTARI, 1) && player.hasItem(consumables.GLDSEED, 1) && player.hasItem(consumables.W_FRUIT, 1))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need vial of Centaurinum, Golden Seed and Whisker Fruit,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.CENTARI, 1);
	player.destroyItems(consumables.GLDSEED, 1);
	player.destroyItems(consumables.W_FRUIT, 1);
	player.gems -= 30;
	statScreenRefresh();
	outputText("You hand over one vial of Centaurinum, one Golden Seed, one Whisker Fruit and thirty gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a vial labeled \"Enigmanium\".  ");
	inventory.takeItem(consumables.ENIGMANIUM, curry(evangelineAlchemyMenu, 2));
	cheatTime(1/6);
}
private function MakingLevisunPotion():void {
	clearOutput();
	if (player.gems < 100) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.ORCASUN, 1) && player.hasItem(consumables.DRAKHRT, 1))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need a vial of Orca sunscreen and a drake heart flower,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.ORCASUN, 1);
	player.destroyItems(consumables.DRAKHRT, 1);
	player.gems -= 100;
	statScreenRefresh();
	outputText("You hand over one vial of Orca sunscreen, a drake heart flower and a hundred gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a vial labeled \"Leviathan Sunscreen\".  ");
	inventory.takeItem(consumables.LEVISUN, curry(evangelineAlchemyMenu, 2));
	cheatTime(1/6);
}
private function MakingGreyAbyssalInkPotion():void {
	clearOutput();
	if (player.gems < 10) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.ABYSSIN, 1) && player.hasItem(consumables.BHMTCUM, 1))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need vial of Abyssal Ink and one sealed bottle of behemoth cum,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.ABYSSIN, 1);
	player.destroyItems(consumables.BHMTCUM, 1);
	player.gems -= 10;
	statScreenRefresh();
	outputText("You hand over one vial of Abyssal Ink, one sealed bottle of behemoth cum and fifty gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a vial of Grey Abyssal Ink.  ");
	inventory.takeItem(consumables.ABYSGIN, curry(evangelineAlchemyMenu, 2));
	cheatTime(1/6);
}
private function MakingWhiteAbyssalInkPotion():void {
	clearOutput();
	if (player.gems < 20) {
		outputText("\"<i>I'm sorry but you don't have the gems for this potion,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	else if (!(player.hasItem(consumables.ABYSSIN, 1) && player.hasItem(consumables.BHMTCUM, 2))) {
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need vial of Abyssal Ink and two sealed bottle of behemoth cum,</i>\" Evangeline says.");
		doNext(evangelineAlchemyMenu);
		return;
	}
	player.destroyItems(consumables.ABYSSIN, 1);
	player.destroyItems(consumables.BHMTCUM, 2);
	player.gems -= 20;
	statScreenRefresh();
	outputText("You hand over one vial of Abyssal Ink, two sealed bottles of behemoth cum and fifty gems to Evangeline, which she gingerly takes them and proceeds to make potion for you.");
	outputText("\n\nAfter a while, she hands you a vial of White Abyssal Ink.  ");
	inventory.takeItem(consumables.ABYSWIN, curry(evangelineAlchemyMenu, 2));
	cheatTime(1/6);
}

	private function ingredientsMenu():void {
		clearOutput();
		menu();
		var emptySlot:int = player.emptySlot();
		addButton(0, "D.E-Ichor", MakeDEIchor)
				.hint("Ask Evangeline to prepare a diluted version of E-Ichor")
				.disableIf(!player.hasItem(useables.E_ICHOR), "++\n\n<b>You don't have any E-Ichor!</b>")
				.disableIf(emptySlot < 0, "++\n\n<b>You don't have free space in your inventory!</b>")
		addButton(14, "Back", meetEvangeline);
	}
	private function MakeDEIchor():void {
		clearOutput();
		outputText("You hand over the "+useables.E_ICHOR.longNameBase+" to Evangeline and wait for her to dilute it.");
		outputText("\n\nAfter a while, she hands you ten vials of "+useables.D_E_ICHOR.longNameBase+" and you carefully put them into your inventory.");
		player.destroyItems(useables.E_ICHOR, 1);
		inventory.tryAddMultipleItemsToPlayer(useables.D_E_ICHOR, 10);
		doNext(ingredientsMenu);
	}

private function LvLUp():void {
	clearOutput();
	outputText("\"<i>So [name] how much gems will you give me this time for my recovery or new experiments?</i>\" Asks Evangeline waiting for your decision.");
	outputText("\n\nEvangeline gem purse: " + EvangelineGemsPurse + " gems");
	menu();
	if (player.gems > 1) addButton(0, "1 gem", Give1Gem).hint("Give Evangeline 1 gem.");
	if (player.gems > 10) addButton(1, "10 gems", Give10Gems).hint("Give Evangeline 10 gems.");
	if (player.gems > 100) addButton(2, "100 gems", Give100Gems).hint("Give Evangeline 100 gems.");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 1 && EvangelineGemsPurse >= 150) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 2 && EvangelineGemsPurse >= 450) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 3 && EvangelineGemsPurse >= 800) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 4 && EvangelineGemsPurse >= 800) {
		if (player.hasStatusEffect(StatusEffects.CampRathazul)) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
		else addButtonDisabled(5, "Just Do It???", "IF you had Rathazul in camp you could JUST DO IT!");
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 5 && EvangelineGemsPurse >= 400) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 6 && flags[kFLAGS.EVANGELINE_LVL_UP] == 6 && EvangelineGemsPurse >= 1250) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 7 && flags[kFLAGS.EVANGELINE_LVL_UP] == 7 && EvangelineGemsPurse >= 400) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 8 && flags[kFLAGS.EVANGELINE_LVL_UP] == 8 && EvangelineGemsPurse >= 150) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 9 && flags[kFLAGS.EVANGELINE_LVL_UP] == 9 && EvangelineGemsPurse >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 11 && flags[kFLAGS.EVANGELINE_LVL_UP] == 10 && EvangelineGemsPurse >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 12 && flags[kFLAGS.EVANGELINE_LVL_UP] == 11 && EvangelineGemsPurse >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 14 && flags[kFLAGS.EVANGELINE_LVL_UP] == 12 && EvangelineGemsPurse >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 15 && flags[kFLAGS.EVANGELINE_LVL_UP] == 13 && EvangelineGemsPurse >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 17 && flags[kFLAGS.EVANGELINE_LVL_UP] == 14 && EvangelineGemsPurse >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 18 && flags[kFLAGS.EVANGELINE_LVL_UP] == 15 && EvangelineGemsPurse >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 20 && flags[kFLAGS.EVANGELINE_LVL_UP] == 16 && EvangelineGemsPurse >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 5) addButton(13, "Experiments", Experiments).hint("Check on what experiments Evangeline can work on.");
	addButton(14, "Back", meetEvangeline);//lvl-up 9: cow TF effects
}//lvl-up 11: succubus TF effects (skrzydła 3 stopien zmiany, rogi jedna para i ogon, moze zmiana odcienia skóry na purpurowy, błekity, różowy lub czerwony)
//koszt vitality tincture, scholar tea i sucubus milk to 6 gems (1 VT to +2 str i tou a 1 ST to +2 do jej statów)
private function Give1Gem():void {
	clearOutput();
	outputText("Reaching into your purse you take out a single gem and hands over it to her.");
	outputText("\n\n\"<i>So stingy...</i>\" she mumbles.");
	player.gems -= 1;
	EvangelineGemsPurse += 1;
	outputText("\n\nEvangeline gem purse: " + EvangelineGemsPurse + " gems");
	statScreenRefresh();
	doNext(LvLUp);
}

private function Give10Gems():void {
	clearOutput();
	outputText("Reaching into your purse you take out a few gems and hands over it to her.");
	outputText("\n\n\"<i>Thanks...</i>\" she mumbles.");
	player.gems -= 10;
	EvangelineGemsPurse += 10;
	outputText("\n\nEvangeline gem purse: " + EvangelineGemsPurse + " gems");
	statScreenRefresh();
	doNext(LvLUp);
}

private function Give100Gems():void {
	clearOutput();
	outputText("Reaching into your purse you take out around a hundred gems and hands over it to her.");
	outputText("\n\n\"<i>Thank you,</i>\" she mumbles.");
	player.gems -= 100;
	EvangelineGemsPurse += 100;
	outputText("\n\nEvangeline gem purse: " + EvangelineGemsPurse + " gems");
	statScreenRefresh();
	doNext(LvLUp);
}

private function JustDoIt():void {
	clearOutput();
	outputText("This time instead of giving her gems you ask if she gathered enough of them for the next stage of her recovery. After a moment of thinking she smiles wide and rush toward her chest with her personal stuff near the bedroll.");
	outputText("\n\n\"<i>I will come back as soon as possible after buying a few needed items. Please don't touch any of my belonging in the meantime,</i>\" you hear her saying before she excitedly rush out of the camp. After watching her leave in a rush you return to your own matter hoping that she will come back soon.");
	/*if (flags[kFLAGS.EVANGELINE_LVL_UP] == 16) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		EvangelineGemsPurse -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 15) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		EvangelineGemsPurse -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 14) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		EvangelineGemsPurse -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 13) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		EvangelineGemsPurse -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 12) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		EvangelineGemsPurse -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 11) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		EvangelineGemsPurse -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 10) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		EvangelineGemsPurse -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 9) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		EvangelineGemsPurse -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 8) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		EvangelineGemsPurse -= 150;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 7) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 4;
		EvangelineGemsPurse -= 400;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 6) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 4;//12 lub 18 lub 24 z powodu wypicia zmodyf bimbo liquer bo musi kupic itemy na modyf jego też
		EvangelineGemsPurse -= 1250;
	}*/
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 5) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 6;
		EvangelineGemsPurse -= 400;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 4) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 12;
		EvangelineGemsPurse -= 800;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 3) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 10;
		EvangelineGemsPurse -= 800;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 2) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 8;
		EvangelineGemsPurse -= 450;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 1) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 6;
		EvangelineGemsPurse -= 150;
	}
	doNext(camp.returnToCampUseOneHour);
}

private function curingArigeanMain():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.ArigeanInfected)) addButtonIfTrue(0, "Arigean I.", curingArigeanYes, "Req. 750 gems.", player.gems >= 750);
	else {
		addButtonIfTrue(1, "Arigean I.", curingArigean2a, "Req. 1000 gems and 3 spring waters.", (player.gems >= 1000 && player.hasItem(consumables.S_WATER, 3) && player.tailType == Tail.ARIGEAN_GREEN));
		addButtonIfTrue(2, "Arigean I.", curingArigean3a, "Req. 1250 gems, 4 pure honey and 4 spring waters.", (player.gems >= 1250 && player.hasItem(consumables.PURHONY, 4) && player.hasItem(consumables.S_WATER, 4) && player.tailType == Tail.ARIGEAN_RED));
		addButtonIfTrue(3, "Arigean I.", curingArigean4a, "Req. 2000 gems, 5 pure honey and 5 spring waters.", (player.gems >= 2000 && player.hasItem(consumables.PURHONY, 5) && player.hasItem(consumables.S_WATER, 5) && player.tailType == Tail.ARIGEAN_YELLOW));
		addButtonIfTrue(4, "Arigean I.", curingArigean5a, "Req. to be Arigean Princess.", player.tailType == Tail.ARIGEAN_PRINCESS);
	}
	addButton(14, "Back", meetEvangeline);
}
private function curingArigean1():void {
	outputText("\"<i>Hey [name]! Is everything alright? You're looking a little pale, would you mind if I looked you over?</i>\" Her tone showing worry before she continues. \"<i>It should only take a quick moment of your time.</i>\"\n\n");
	outputText("Clearly she has your best health in mind, and you have been feeling a little under the weather as of late. It’s just a small look over, so what’s the worst that could happen?\n\n");
	outputText("\"<i>Alright [name] just dress down, and sit right there. I need to go grab something so i’ll be right back!</i>\" She shouts as she jogs somewhere towards the camp’s border.\n\n");
	outputText("After roughly a few minutes of you idly thinking about what you plan to do for the rest of the day, Evangeline approaches you with a handful of instruments and tools.\n\n");
	outputText("\"<i>Okay [name] i'm going to need you to stand up straight, and hold out your arms.</i>\" She instructs as she goes to probing parts of your body, and sticking one of her instruments in your mouth.\n\n");
	if (player.tailType == Tail.ARIGEAN_GREEN) {
		outputText("\"<i>WHAT IN MARAE IS THAT!</i>\" She yelps while making sure there's more than enough distance from your new hitchhikers and herself.\n\n");
		outputText("\"<i>Those popped up overnight, I don’t have any control over them.</i>\"\n\n");
		outputText("She wearily takes a few curious steps forward with her eyes never leaving your new ‘friends’.\n\n");
		outputText("\"<i>It seems you have some sort of parasite attached to you. However due to it not being on you for too long it should be relatively easy to remove.</i>\" She grabs a paper and quill and starts writing a list down on it.\n\n");
	}
	else {
		outputText("\"<i>What’s this black spot right here?</i>\" you feel her press into a spot on your spine just above your [butt], earning a hiss from the soreness it causes. She grabs the instrument giving it a look before a frown appears on her face.\n\n");
		outputText("\"<i>It seems you have some parasites in your system. It shouldn’t take too much to remove them from your system, and I recommend you do so before your case worsens.</i>\" She grabs a paper and quill and starts writing down a list on it.\n\n");
	}
	outputText("\"<i>750 gems should be enough to cover the costs of the materials needed. I highly recommend we do this now before your case gets any worse.</i>\" She says taking a seat while waiting for you to make up your mind.\n\n");
	player.addStatusValue(StatusEffects.ArigeanInfected, 3, 1);
	menu();
	addButtonIfTrue(1, "Yes", curingArigeanYes, "Req. 750 gems.", player.gems >= 750);
	addButton(3, "No", curingArigeanNo);
}
private function curingArigeanYes():void {
	clearOutput();
	outputText("You present her with her payment, and she responds by grabbing it before hurriedly jogging off to grab some things from her encampment. After waiting for about 10 minutes she returns with a vial in hand.\n\n");
	outputText("\"<i>Here you go [name]! Don’t mind the smell… or taste.</i>\" She presents you the vial which holds a foul smelling, yellow liquid that you can’t help but gag upon smelling it.\n\n");
	outputText("\"<i>Down the hatch.</i>\" you murmur as you attempt to drink down the foul liquid all in one go while not throwing it back up.\n\n");
	if (player.tailType == Tail.ARIGEAN_GREEN) {
		outputText("A burning sensation crawling up your spine is all you feel as the creature attached to you starts screeching viscously before detaching from you, and withering away on the floor. leaving a nasty gash in its wake. <b>You no longer have a parasite attached to you.</b>\n\n");
		if (EvangelineCuringArigeanInfection == 0) EvangelineCuringArigeanInfection += 1;
		player.tailType = Tail.NONE;
	}
	else outputText("A burning sensation makes you feel like your stomach is attempting to digest itself, and before long you can no longer keep it down as you hack up a thick, black, Viscous liquid. <b>It seems you're no longer a host to a parasite.</b>\n\n");
	player.gems -= 750;
	statScreenRefresh();
	player.removeStatusEffect(StatusEffects.ArigeanInfected);
	doNext(camp.campFollowers);
	advanceMinutes(15);
}
private function curingArigeanNo():void {
	outputText("\"<i>Suit yourself, but it’s going to cost much more to remove it should your case worsen.</i>\"\n\n");
	doNext(meetEvangeline);
}
private function curingArigean2():void {
	outputText("\"<i>Eh… [name]? It looks like your condition has worsened a bit, it should still be relatively easy to remove, but i'm going to need you to find a few exotic materials for me.</i>\" She takes out a piece of paper and quill, writing a small list down. \"<i>Bring me… 3 bottles of pure spring water and 1000 gems.</i>\"\n\n");
	doNext(meetEvangeline);
}
private function curingArigean2a():void {
	clearOutput();
	outputText("You present her with her payment, items, and she responds by grabbing them before hurriedly jogging off to grab some things from her encampment. After waiting for about 10 minutes she returns with a vial in hand.\n\n");
	outputText("\"<i>Here you go [name]! Don’t mind the smell… or taste.</i>\" She presents you the vial which holds a foul smelling, purple liquid that you can’t help but gag upon smelling it.\n\n");
	outputText("\"<i>Down the hatch.</i>\" you murmur as you attempt to drink down the foul liquid all in one go while not throwing it back up.\n\n");
	outputText("A burning sensation crawling up your spine is all you feel as the creature attached to you starts screeching viscously before detaching from you, and withering away on the floor, leaving a nasty gash in its wake. You can’t help but feel a little saddened at the sight. <b>You no longer have a parasite attached to you.</b>\n\n");
	if (EvangelineCuringArigeanInfection == 0) EvangelineCuringArigeanInfection += 1;
	if (flags[kFLAGS.THE_TRENCH_ENTERED] >= 1) flags[kFLAGS.THE_TRENCH_ENTERED] = 0;
	player.destroyItems(consumables.S_WATER, 3);
	player.removePerk(PerkLib.MiracleMetal);
	player.tailType = Tail.NONE;
	player.gems -= 1000;
	statScreenRefresh();
	doNext(camp.campFollowers);
	advanceMinutes(15);
}
private function curingArigean3():void {
	outputText("\"<i>Uh...[name]...there is...fog, all around you, I don't think you should go back to...whatever place did this to you.</i>\" She takes out a piece of paper, quill and begins writing a list down. \"<i>Your condition has worsened, and it’s going to be even harder than before to remove your parasite. I need you to bring me 4 jars of purified bee honey, 4 bottles of pure spring water, and 1250 gems to cover materials.</i>\"\n\n");
	doNext(meetEvangeline);
}
private function curingArigean3a():void {
	clearOutput();
	outputText("You present her with her payment, items, and she responds by grabbing them before hurriedly jogging off to grab some things from her encampment. After waiting for about 10 minutes she returns with a vial in hand.\n\n");
	outputText("\"<i>Here you go [name]! Don’t mind the smell… or taste.</i>\" She presents you the vial which holds a foul smelling, light blue liquid that you can’t help but gag upon smelling it.\n\n");
	outputText("\"<i>Down the hatch.</i>\" you murmur as you attempt to drink down the foul liquid all in one go while not throwing it back up.\n\n");
	outputText("A burning sensation crawling up your spine is all you feel as the creature attached to you starts screeching viscously before detaching from you, and withering away on the floor. leaving a nasty gash in its wake. An immense feeling of guilt grips your heart as you watch your former partner dissolve into nothingness. <b>You no longer have a parasite attached to you.</b>\n\n");
	if (EvangelineCuringArigeanInfection == 0) EvangelineCuringArigeanInfection += 1;
	if (flags[kFLAGS.THE_TRENCH_ENTERED] >= 1) flags[kFLAGS.THE_TRENCH_ENTERED] = 0;
	player.destroyItems(consumables.S_WATER, 4);
	player.destroyItems(consumables.PURHONY, 4);
	player.removePerk(PerkLib.MiracleMetal);
	player.rearBody.type = RearBody.NONE;
	player.tailType = Tail.NONE;
	player.gems -= 1250;
	statScreenRefresh();
	doNext(camp.campFollowers);
	advanceMinutes(15);
}
private function curingArigean4():void {
	outputText("\"<i>[name]?.. Is that still you in there?</i>\" she nervously takes a few steps back, attempting to keep a safe distance from you. \"<i>You’ve been acting very strange as of late, and everyone's a little worried.</i>\" A tinge of fear evident in her voice.\n\n");
	outputText("You attempt to reassure her that you're still very much you, and the reason you wanted to speak to her was to see if your condition is still curable.\n\n");
	outputText("\"<i>I'm surprised you still have the willpower to even want to be cured,</i>\" she seems to have eased up a bit, but you feel she still doesn’t entirely trust you. \"<i>It’s not going to be easy, however.</i>\" She takes out a piece of paper, a quill and begins writing a long list. \"<i>I'm going to need you to fetch me 5 jars of Purified bee honey, 5 bottles of pure spring water, and 2000 gems to cover the cost of other materials.</i>\"\n\n");
	doNext(meetEvangeline);
}
private function curingArigean4a():void {
	clearOutput();
	outputText("You present her with her payment, items, and she responds by grabbing them before hurriedly jogging off to grab some things from her encampment. After waiting for about 10 minutes she returns with a vial in hand.\n\n");
	outputText("\"<i>Here you go [name]! Don’t mind the smell… or taste..</i>\" She presents you the vial which holds a foul-smelling, indigo liquid that you can’t help but gag upon smelling it.\n\n");
	outputText("\"<i>Down the hatch,</i>\" you murmur as you attempt to drink down the foul liquid all in one go while not throwing it back up.\n\n");
	outputText("A burning sensation crawling up your spine is all you feel as the creature attached to you starts screeching viscously before detaching from you and withering away on the floor. leaving a nasty gash in its wake. You can’t help but look on in horror as your former friend ceases it’s movements and slowly dissolves away, leaving you with a numb feeling in your chest, was this the right choice? <b>You no longer have a parasite attached to you.</b>\n\n");
	if (EvangelineCuringArigeanInfection == 0) EvangelineCuringArigeanInfection += 1;
	if (flags[kFLAGS.THE_TRENCH_ENTERED] >= 1) flags[kFLAGS.THE_TRENCH_ENTERED] = 0;
	player.destroyItems(consumables.S_WATER, 5);
	player.destroyItems(consumables.PURHONY, 5);
	player.removePerk(PerkLib.MiracleMetal);
	player.rearBody.type = RearBody.NONE;
	player.tailType = Tail.NONE;
	player.gems -= 2000;
	statScreenRefresh();
	doNext(camp.campFollowers);
	advanceMinutes(15);
}
private function curingArigean5a():void {
	outputText("\"<i>Ah [name]?.. Is something troubling you?</i>\" She takes a couple of steps back as the fear becomes evident in her voice. \"<i>You look quite different, would you mind if I checked you over?</i>\" It’s obvious she doesn’t feel too safe around you in your new form.\n\n");
	outputText("You attempt to give her a reassuring smile to help ease her nerves as you tell her you wouldn’t mind. But a part of you still thinks she may be frightened.\n\n");
	outputText("\"<i>Just wait here, and I’ll be right back.</i>\" She hurriedly jogs off to where you presume her original encampment is, this may take a little.\n\n");
	outputText("You sit back on your tail-like mouth to pass the time, and now that you actually take a moment to think about it, why is she so afraid of you? It’s not like you’ve harmed or threatened her in any way, she also seems to be quite uncomfortable around Grayda as well. Has she had some previous encounter with your kind before? ");
	outputText("Or does she just find you intimidating? Have you really changed so much as to put people on edge by your very presence? What would your loved ones say if they were to see you now, would they also be afraid?\n\n");
	outputText("\"<i>Princess? Is everything alright over here?</i>\" Grayda seems to have somehow picked up on your internal distress. Whether this is just her intuition or some sort of signal you're giving off is anyone’s guess at this point.\n\n");
	outputText("You tell her your fine, just waiting for Evangeline so she can give you an examination.\n\n");
	outputText("\"<i>If you don’t mind, my princess, would you allow me to watch?</i>\"\n\n");
	outputText("You tell her you don’t mind, she has your best intentions in mind after all.\n\n");
	outputText("After a few moments of idling Evangeline returns with the items she needs, and begins her examination with simple probing and inspecting your magnificent new maw. Her attention seems focused on where it connects to your hip, however, and after several ticklish pokes and rubs, she turns to face you with a small glass vial.\n\n");
	outputText("\"<i>[name] I'm going to need a small amount of your blood.</i>\" Her face and tone hold a great air of seriousness as she offers you a knife. It’s just a little blood, what’s the worst that could happen?\n\n");
	outputText("You use the knife to cut the palm of your hand, while Evangeline moves the vial under your hand to catch any blue ichor that escapes the wound. After a sufficient amount of it has been collected she adds a few drops of a white liquid to it with seemingly no results, which draws a look of concern on Evangeline’s face.\n\n");
	outputText("\"<i>I don’t think there’s any way I can fix your condition without it being lethal, but do you even want to turn back at this point?</i>\"\n\n");
	outputText("The answer to you was quite obvious, why would you want to turn back to how you were before? Why give up so many advantageous benefits in a hostile land like Mareth? Why remove the very part of you that makes you, you? That which makes you royalty amongst your kind?\n\n");
	outputText("\"<i>I see… But [name], just know you’ve changed drastically from the person you once were</i>\" and with that Evangeline goes to return her retrieved items back to her encampment as you try to gesture Grayda to follow you with a friendly nod of your head.\n\n");
	if (silly()) {
		outputText("However much to your shock at the sudden action. Grayda swiftly stabs Evangeline with the end of her staff. Causing her to fall with an abrupt scream.\n\n");
		outputText("\"<i>What the hell, Grayda?!</i>\"\n\n");
		outputText("\"<i>But… you nodded the “stabbing nod”, my Princess.</i>\"\n\n");
		outputText("\"<i>There’s a nod for stabbing people?!</i>\"\n\n");
		outputText("\"<i>Yes, my Princess.</i>\"\n\n");
		outputText("As you bandage up the surprisingly shallow wound, you consider it might be best to not nod so often, lest you accidentally start a war you don’t want. She should wake up soon, hopefully with no memory of this crazed incident. Maybe Grayda should educate you on the various different nods in the future.\n\n");
	}
	doNext(camp.campFollowers);
	advanceMinutes(15);
}

private function curingWendigo():void {
	clearOutput();
	if (player.hasItem(consumables.PURPEAC, 5) && player.hasItem(consumables.PPHILTR, 5)) {
		player.destroyItems(consumables.PURPEAC, 5);
		player.destroyItems(consumables.PPHILTR, 5);
		outputText("Evangeline nods as you bring her the ingredients, getting to work. As soon as the potion is finished she pours it over your chest. For the first time since you were cursed you finally can feel the gnawing hunger becoming more tolerable as your form becomes more malleable again provided you transform you might even be able to get rid of it entirely. Sure you still look like a wendigo but now you can actually do something about your appearance, you just need to get some transformatives first.\n\n");
		outputText("<b>(Lost Perk: Wendigo Curse)</b>\n\n");
		player.removePerk(PerkLib.WendigoCurse);
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("Evangeline barely turns to look at you before jumping in surprise.\n\n");
		outputText("\"<i>Oh god, what has happened to you [name]! There clearly is an obvious issue with your body, it looks as though a curse has taken hold of your soul!</i>\"\n\n");
		outputText("You explain your situation to her somewhat.\n\n");
		outputText("\"<i>Look, I will need five pure peaches and five purity philters to fix this up, how you get the two is up to you.</i>\"\n\n");
		player.addPerkValue(PerkLib.WendigoCurse, 1, 1);
		doNext(camp.campFollowers);
		advanceMinutes(15);
	}
}

private function curingJiangshi():void {
	clearOutput();
	if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 3) {
		player.destroyItems(consumables.VITAL_T, 5);
		player.destroyItems(consumables.PPHILTR, 5);
		outputText("Evangeline nods as you bring her the ingredients, getting to work. As soon as the potion is finished she pours it over your cursed talisman, causing it to smoke and crumble. The first thing you do as the nasty thing peels off is head back to He’Xin’Dao and look for your gear. Thankfully it doesn't take you long to find it in a chest not too far from the table on which the crazy cat messed you up. Gosh, it feels good to be alive, like REALLY alive.\n\n");
		if (player.weapon.isNothing && flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] < 1 && flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] != 0) {
			player.setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
			flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = 0;
		}
		if (player.weaponRange.isNothing && flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] != 0) {
			player.setWeaponRange(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID]) as WeaponRange);
			flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] = 0;
		}
		if (player.shield.isNothing && flags[kFLAGS.PLAYER_DISARMED_SHIELD_ID] != 0) {
			if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] < 1) player.setShield(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_SHIELD_ID]) as Shield);
			flags[kFLAGS.PLAYER_DISARMED_SHIELD_ID] = 0;
		}
		if (player.armor == armors.TRADITC && flags[kFLAGS.PLAYER_DISARMED_ARMOR_ID] != 0) {
			player.setArmor(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_ARMOR_ID]) as Armor);
			flags[kFLAGS.PLAYER_DISARMED_ARMOR_ID] = 0;
		}
		if (player.lowerGarment.isNothing && flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_BOTTOM_ID] != 0) {
			player.setUnderBottom(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_BOTTOM_ID]) as Undergarment);
			flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_BOTTOM_ID] = 0;
		}
		if (player.upperGarment.isNothing && flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_UPPER_ID] != 0) {
			player.setUnderTop(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_UPPER_ID]) as Undergarment);
			flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_UPPER_ID] = 0;
		}
		if (player.headJewelry == HeadJewelryLib.NOTHING && flags[kFLAGS.PLAYER_DISARMED_HEAD_ACCESORY_ID] != 0) {
			player.setHeadJewelry(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_HEAD_ACCESORY_ID]) as HeadJewelry);
			flags[kFLAGS.PLAYER_DISARMED_HEAD_ACCESORY_ID] = 0;
		}
		flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
		player.skinColor                                 = "light";
		CoC.instance.transformations.FaceHuman.applyEffect(false);
		player.eyes.type = Eyes.HUMAN;
		player.horns.type = Horns.NONE;
		player.horns.count = 0;
		player.arms.type = Arms.HUMAN;
		player.lowerBody = LowerBody.HUMAN;
		if (player.hasPerk(PerkLib.CursedTag)) {
			player.removePerk(PerkLib.CursedTag);
			player.perkPoints += 1;
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll1)) player.removeStatusEffect(StatusEffects.AlterBindScroll1);
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll2)) player.removeStatusEffect(StatusEffects.AlterBindScroll2);
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll3)) player.removeStatusEffect(StatusEffects.AlterBindScroll3);
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll4)) player.removeStatusEffect(StatusEffects.AlterBindScroll4);
			if (player.hasStatusEffect(StatusEffects.AlterBindScroll5)) player.removeStatusEffect(StatusEffects.AlterBindScroll5);
		}
		if (player.hasPerk(PerkLib.ImprovedCursedTag)) {
			player.removePerk(PerkLib.ImprovedCursedTag);
			player.perkPoints += 1;
		}
		if (player.hasPerk(PerkLib.GreaterCursedTag)) {
			player.removePerk(PerkLib.GreaterCursedTag);
			player.perkPoints += 1;
		}
		player.removePerk(PerkLib.HaltedVitals);
		player.removePerk(PerkLib.SuperStrength);
		player.removePerk(PerkLib.PoisonNails);
		player.removePerk(PerkLib.Rigidity);
		player.removePerk(PerkLib.LifeLeech);
		player.removePerk(PerkLib.Undeath);
		player.removePerk(PerkLib.EnergyDependent);
		player.statStore.removeBuffs("Energy Vampire");
		player.statStore.removeBuffs("Jiangshi Curse Tag");
		outputText("Done with this place you head back to camp.\n\n");
		outputText("<b>(Lost Perks: Halted vitals, Super strength, Poison nails, Rigidity, Life leech, Undeath, Energy dependent"+(player.hasPerk(PerkLib.CursedTag)?", Cursed Tag":"")+")</b>\n\n");
		player.updateRacialAndPerkBuffs();
		flags[kFLAGS.CURSE_OF_THE_JIANGSHI]++;
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("Evangeline barely turns to look at you before jumping in surprise.\n\n");
		outputText("\"<i>Oh god, what has happened to you [name]! There clearly is an obvious issue with your vitality.</i>\"\n\n");
		outputText("You explain your situation to her somewhat.\n\n");
		outputText("\"<i>Look, I will need five vitality tinctures and five purity philters to fix this up, how you get the two is up to you.</i>\"\n\n");
		flags[kFLAGS.CURSE_OF_THE_JIANGSHI]++;
		doNext(camp.campFollowers);
		advanceMinutes(15);
	}
}

private function craftingSoulGem():void {
	clearOutput();
	outputText("\"<i>Wait, you want me to craft a soul gem!? What do you even intend to do with it? These things are used to capture and hold souls!</i>\"\n\n");
	outputText("You remind her that it’s your business, telling her that in the end it will serve a greater purpose.\n\n");
	if (player.hasItem(consumables.S_WATER, 1) && player.hasItem(consumables.ECTOPLS, 1) && player.gems >= 2500) {
		player.destroyItems(consumables.S_WATER, 1);
		player.destroyItems(consumables.ECTOPLS, 1);
		player.gems -= 2500;
		statScreenRefresh();
		outputText("\"<i>I hope you know what you're doing. Hand me the recipe and materials, and I will get to work.</i>\"");
		player.createStatusEffect(StatusEffects.SoulGemCrafting,24,0,0,0);
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		outputText("\"<i>Regardless, I can’t craft a soul gem without the proper materials. Gather me Ectoplasm, vial of Pure Spring Water, and 2500 gems for the miscellaneous reagents.</i>\"");
		doNext(meetEvangeline);
	}
}

private function receivingCraftedSoulGem():void {
	clearOutput();
	outputText("As you check on Evangeline she hands a purplish crystal to you.\n\n");
	outputText("\"<i>Here's your soul gem. Please use this responsibly, they are very hard to craft, and quite dangerous.</i>\"\n\n");
	outputText("<b>Acquired a Soul Gem!</b>\n\n");
	player.removeStatusEffect(StatusEffects.SoulGemCrafting);
	inventory.takeItem(useables.SOULGEM, meetEvangeline);
}

private function Experiments():void {
	clearOutput();
	outputText("\"<i>So [name] what project you think should be handled first? Or maybe you want another vial of mixture from one of the finished project?</i>\" Asks Evangeline waiting for your decision. \"<i>Since you covered all expenses it's your choice.</i>\"");
	outputText("\n\nEvangeline gem purse: " + EvangelineGemsPurse + " gems");
	menu();
	if (flags[kFLAGS.GALIA_LVL_UP] < 1) addButtonDisabled(0, "BL/BB Plus", "Progress require sacrif... test subjects. Like feral imps...");
	else addButton(0, "BL/BB Plus", ExperimentsBLBBPlus).hint("Bimbo Liquer Plus / Bro Brew Plus");
	//addButtonDisabled(1, "Amazon L.", "Amazon Liquer");
	//addButtonDisabled(10, "F.B.TF", "Full body transformation items.");
	addButton(13, "Give Gems", LvLUp).hint("Give Evangeline some gems to cover her experiments expenses.");
	addButton(14, "Back", meetEvangeline);
}

private function ExperimentsBLBBPlus():void {
	clearOutput();
	if (flags[kFLAGS.GALIA_AFFECTION] == 1) {
		outputText("Evangeline seems to be more excited than usual as you approach. She seems to have been working fiercely on a new concoction.\n\n");
		outputText("Her eyes light eagerly, \"<i>Great, [name], you're just in time for me to test out my altered bimbo formula. If you could just supply me with a bimbo liqueur or a bro brew, I should have a solution that'll give you the body without sacrificing a hint of your mental status.</i>\" She pauses briefly, mumbling, \"<i>If you'd like, you could be my subject, or my newest friend will be, if you’re not as pertained to such transformations.</i>\"\n\n");
		outputText("You can see the captive imp within the cage behind her. Seems she has quite a lot planned already.\n\n");
		menu();
		if (EvangelineGemsPurse >= 500) addButton(1, "Imp Subject", ExperimentsBLBBPlusImpSubject).hint("Find out what happens to another creature.");
		else addButtonDisabled(1, "Imp Subject", "Req. Evangeline having over 500 gems in her purse.");
		if (player.hasItem(consumables.BIMBOLQ, 1) || player.hasItem(consumables.BROBREW, 1)) addButton(2, "Yourself", ExperimentsBLBBPlusYourself).hint("See what’s in store for yourself.");
		else addButtonDisabled(2, "Yourself", "You need something to transform yourself with!");
		addButton(3, "Ignore", Experiments).hint("Maybe later");
	}
	else {
		outputText("You ask Evangeline if she can make another concoction for the brews.\n\n");
		outputText("Evangeline nods eagerly, \"<i>Yes, of course. I can do that, you have to supply me with the ingredients, of course.</i>\"\n\n");
		menu();
		if (player.hasItem(consumables.BIMBOLQ, 1)) {
			if (player.hasPerk(PerkLib.BroBody) || player.hasPerk(PerkLib.FutaForm)) addButtonDisabled(1, "Bimbo", "Can't have Bro Body/Futa Form.");
			else addButton(1, "Bimbo", ExperimentsBLBBPlusBimbo).hint("Ask Evangeline if she can make a new sample of that special drink.");
		}
		if (player.hasItem(consumables.BROBREW, 1)) {
			if (player.hasPerk(PerkLib.BimboBody) || player.hasPerk(PerkLib.FutaForm)) addButtonDisabled(2, "Bro", "Can't have Bimbo Body/Futa Form.");
			else addButton(2, "Bro", ExperimentsBLBBPlusBro).hint("Ask Evangeline if she can make a new sample of that special drink.");
		}
		addButton(3, "Nevermind", Experiments);
	}
}

private function ExperimentsBLBBPlusImpSubject():void {
	clearOutput();
	outputText("You ask Evangeline what her plans are with the captive imp she has caged behind her.\n\n");
	outputText("Evangeline tilts her head up slightly as she speaks, \"<i>Yes, that imp, such a unique specimen to see a female one. My goal is to run a few tests to see how well such a creature would respond to a more dramatic change. Smaller creatures may not handle changes as easily as you could. You're made of a much harder material…</i>\"\n\n");
	outputText("Evangeline pulls out a vial as she heads toward the cage. The imp already has her claws around the bar, shaking the metal poles violently. Evangeline glances back at you, \"<i>I will need your help, such feral creatures won’t just let me work on them without putting up a bit of a fight, first.</i>\"\n\n");
	outputText("You follow her to the cage as she reaches for her keyring. The imp scratches and claws at the metallic cage. Evangeline nods toward you then back at the cage, mumbling something under her breath. "+(player.sens >= 100 ? "\"<i>Go, make sure it doesn’t escape when I release it.</i>\" ":"")+"You brace yourself for the imp to attempt to fly out once she opens the cage.\n\n");
	outputText("The keys jingle as the lock clicks. Evangeline opens the cage for you as you quickly attempt to seize the imp. Evangeline responds immediately, uncorking the liqueur before forcing it down the imp’s throat, making sure she’s forced to swallow every last drop possible.\n\n");
	outputText("You hold onto the imp tightly, waiting for something to happen, but it still struggles, spittle running down her mouth as she hisses at you. Her wings flap violently as she wriggles, trying to escape. Evangeline glances at the bottle before mumbling again, \"<i>Maybe it wasn’t a strong enough dosage? Or is the imp unsuitable for such a change…</i>\"\n\n");
	outputText("Before she can assess the situation further, suddenly, you notice the imp’s hair shift to a more platinum blonde. Despite her otherwise slim and short stature, her hips do begin to flare out, widening into a more hourglass figure as her bust develops into a pleasant pair of DD cups. Her hair grows longer in luxurious silky strands.. ");
	outputText("She resembles the same voluptuous form from a bimbo you’d expect, only much shorter than most people that walk Maereth. The feral glance in her eyes seems to fade, sparked by a new sense of wonder and curiosity. Then… seething hatred, a burning passion of wrath.\n\n");
	outputText("Evangeline shudders briefly at the glowerbefore the imp attempts to spit at her, to which she narrowly avoids in her anticipation. The imp’s shrill voice rings through your ears, \"<i>No, what the fuck?! First, you feed me the most foul tasting gruel I’ve ever had the displeasure to consume, then you forcibly transform me against my will into… this?!</i>\"\n\n");
	outputText("Evangeline grins in delight, taking a small sigh of relief, \"<i>Yes, it worked! Blessed Marae… Thank the stars, it worked! No longer a feral beast!</i>\"\n\n");
	outputText("You keep the imp pinned as she attempts to point an accusing finger at you, \"<i>And you… you’re the one helping this… this mad bitch?! Why?!</i>\"\n\n");
	outputText("Evangeline turns her attention back to you, \"<i>Think of all the things we could do with this, now. There’s so much more research to do, I must run more tests and get to know about this imp some more, t-</i>\"\n\n");
	outputText("The imp cuts her off with a loud retort, \"<i>It’s Galia, you fucking whore, at least take the decency to learn my name after such an unwholesome welcome!</i>\"\n\n");
	outputText("Evangeline turns back to the imp, \"<i>Oh, I’m sorry, little one, were you saying something? I was a little sidetracked.</i>\"\n\n");
	outputText("The imp is fuming as she screams from the top of her lungs, \"<i><b>GALIA! THE NAME IS GALIA!</b></i>\"\n\n");
	outputText("Evangeline nods, \"<i>I see, thank you.</i>\"\n\n");
	outputText("Galia turns back to you, \"<i>You can let me go, this fat ass is too heavy to fly with my wings as it is. Just… leave me alone in the cage, could you give me that much decency?</i>\"\n\n");
	outputText("You oblige as Evangeline nods, gesturing back to the cage as she closes the door behind Galia.\n\n");
	outputText("It would seem Evangeline has plenty of work left ahead of her, and a new experiment to mess with.\n\n");
	outputText("(<b>Galia has been added to the Slaves menu!</b>)\n\n");
	flags[kFLAGS.GALIA_AFFECTION] = 2;
	EvangelineGemsPurse -= 500;
	doNext(Experiments);
	advanceMinutes(10);
}

private function ExperimentsBLBBPlusYourself():void {
	clearOutput();
	outputText("Rifling through your inventory, you wonder how you should partake in such an event…\n\n");
	outputText("Evangeline looks toward you earnestly, \"<i>I’m excited for the chance… but you’re positive you’re ready for this, correct” She mumbles softly to herself, “I would want you to take more than you’re ready for, or you know.</i>\"\n\n");
	menu();
	if (player.hasItem(consumables.BIMBOLQ, 1)) addButton(1, "Bimbo", ExperimentsBLBBPlusYourselfBimbo).disableIf((player.hasPerk(PerkLib.BroBody) || player.hasPerk(PerkLib.FutaForm)), "Can't have Bro Body/Futa Form.");
	if (player.hasItem(consumables.BROBREW, 1)) addButton(2, "Bro", ExperimentsBLBBPlusYourselfBro).disableIf((player.hasPerk(PerkLib.BimboBody) || player.hasPerk(PerkLib.FutaForm)), "Can't have Bimbo Body/Futa Form.");
	addButton(3, "Nevermind", ExperimentsBLBBPlusYourselfNevermind);
}

private function ExperimentsBLBBPlusYourselfBimbo():void {
	clearOutput();
	player.destroyItems(consumables.BIMBOLQ, 1);
	outputText("You offer Evangeline a bimbo liqueur, telling her you’re ready. You want to see what she’s learned and are willing to be a test dummy for her.\n\n");
	outputText("She grins softly, swiftly taking the bottle from you as she paces back to her lab. In a flurry of movements, she mixes several other fluids into the bottle as you’re hit with an absolutely foul scent, you flinch in reflex at the stench as it reaches your nostrils. Then, almost immediately, hints of sweet vanilla, fresh wine and herbs as Evangeline begins mixing all the ingredients. Whatever she’s mixing, it certainly is the concoction.\n\n");
	outputText("\"<i>Finally,</i>\" she states. \"<i>The…</i>\" She pauses before mumbling, \"<i>smart… bimbo… something, I don’t pay myself to make names for all of these, anyway.</i>\"\n\n");
	ExperimentsBLBBPlusBimbo1();
	outputText("Evangeline nods,\"<i>You look good, [name]. How are you feeling? You should be mentally intact, if not a little smarter…</i>\"\n\n");
	outputText("Nothing feels off to you, aside from adjusting to your new height and looks, that is.\n\n");
	outputText("\"<i>Anything… else?</i>\" she asks warily. \"<i>If not, then… well, I can call it a success.</i>\"\n\n");
	menu();
	addButton(1, "Get Dirty", ExperimentsBLBBPlusYourselfBimboGetDirty).hint(""+(silly()?"Lesbians… LESBIANS?! …Lesbians…":"Take your new body on a whole new trip with Evangeline.")+"");
	addButton(3, "Remain Clean", ExperimentsBLBBPlusYourselfRemainClean).hint("Best not to get dirty.");
}

private function ExperimentsBLBBPlusBimbo1():void {
	if (player.hasPerk(PerkLib.BimboBody)) {
		outputText("She sighs softly before mumbling again, \"<i>This’ll surely remedy some of those… issues you’ve been having with your head… I’m sure, now go on… take a drink.</i>\"\n\n");
		outputText("You oblige, after all, what’s the worst that could happen, right? With only a sip, you feel a sudden resurgence in your mind. Your head thrums as you take more, delicately taking in every last drop of Evangeline’s concoction.\n\n");
		outputText("You breathe a sigh of relief as clarity returns to your head. You feel proper again. You also still have a beautifully voluptuous body to compliment your head as well. It’s a win-win already.\n\n");
		if (player.hasPerk(PerkLib.BimboBrains)) player.removePerk(PerkLib.BimboBrains);
	}
	else {
		outputText("She sighs softly before mumbling again, \"<i>Go on… take a drink.</i>\"\n\n");
		outputText("You oblige, after all, what’s the worst that could happen, right? Being a bimbo isn’t a terrible fate, is it? With only a sip, you feel a tingling in your body, heat rises to your loins as your legs nearly buckle.\n\n");
		outputText("Everything about you begins to shift, sending you off balance after you finish the concoction. Your breasts develop into a beautiful rack of DD cups with soft, pliable skin. Your hips form into a wide base, perfectly complimenting your body into a pinnacle of beauty with your hourglass curves. You give your hips a slight waggle, admiring the jiggle of your entire body.\n\n");
		outputText("You can feel your vagina clench slightly, it’s a weird sensation, but you’ve never felt so ripe and fertile before. Your [vagina] is moist and tingly, you almost would touch it if not for Evangeline studying you so heavily.\n\n");
		outputText("Your hair develops with the rest of you into long locks of silky platinum blonde hair that reach just above your full ass.\n\n");
		outputText("You examine your body, every inch of you is radiant. Soft, smooth skin. A supple, voluptuous build and fine strands of platinum blonde hair. You have the look of a perfect bimbo, yet your mind is wholly intact. You look at Evangeline, she is blushing slightly, gaze averting from you.\n\n");
		player.createPerk(PerkLib.BimboBody,0,0,0,0);
		if (player.hairLength < 36) player.hairLength = 36;
		if (!player.hasVagina()) {
			CoC.instance.transformations.VaginaHuman().applyEffect(false);
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_SLICK;
		}
		if (player.breastRows[0].breastRating < 10) player.breastRows[0].breastRating += 5 + rand(5);
		if (player.hips.type < 12) player.hips.type = 12;
		if (player.butt.type < 12) player.butt.type = 12;
		if (player.tone > 0) player.tone = 0;
		player.MutagenBonus("lib", 5);
		player.modFem(100, 100);
	}
}

private function ExperimentsBLBBPlusYourselfBimboGetDirty():void {
	clearOutput();
	outputText("You tell Evangeline there is something you need to get off your mind… As you state this, you bring your hips into a seductive sway as you take a few strides toward her.\n\n");
	outputText("She looks at you earnestly, face still flushing with hints of red hue before her voice rises into a soft mumble, \"<i>And what is that… exactly?</i>\"\n\n");
	outputText("You meet her gaze, standing directly in front of her. Her cross-shaped pupils are quivering in place. You tell her you want her, and you can tell she’s feeling the same.\n\n");
	outputText("Evangeline huffs softly, not denying the thought. \"<i>What did… you want to do?</i>\" she mumbles.\n\n");
	outputText("You slowly shift her out of her robes, revealing her soft skin to the open air"+(player.isNaked()?"":" as you undress yourself with her, tossing your [armor] to the side")+". You slowly run your fingers along her side, while her form is more tomboyish, the contrast of your physiques only add to her flustered state.\n\n");
	outputText("She mumbles again, \"<i>Ah… is this… really happening? I feel like I’m in some fantasy… you’re so… perfect… [name].</i>\" You remind her that it surely is happening, and it’s too late to stop what’s already in motion.\n\n");
	outputText("You slowly push her down to the ground, the grass gently caressing your legs as you kneel over her. Her mouth is slightly agape as she takes a deep breath, she brings a hand to her chest, almost defensively as she braces herself before she slowly leans into you. You press yourself slowly against her as well breathing in her scent, a mixture of sweet herbs and faint spices. Your lips locking together as your voluminous breasts press against hers, your bodies now pressed tightly together as she wraps her delicate arms around you in an eager embrace.\n\n");
	outputText("She breathes heavily between kisses as she reaches up to grope and massage your breasts. You bring a hand down to admire her slender physique as well as you continue to explore each other's bodies, reveling in the warmth of each other as your lips remain in contact, not wanting to leave her touch.\n\n");
	outputText("Your hand slowly drives down her ample hips, grazing her vulva as you press your fingers lightly against her labia, spreading her lips slightly. She’s already moist and drooling beads of girlcum. You circle your finger around her labia again, causing her to shiver before you drag your finger back to her clit, rubbing it gently as you toy with her more.\n\n");
	outputText("\"<i>[name]...</i>\" she mumbles, hardly able to bring her words together. You silence her with another kiss. Her hands slowly roam around your form, admiring the fullness of your body, groping your bust once more before her hand slides down your figure, admiring you even more before her finger finds your clit. She follows your lead, rubbing your clit in slow motions as the two of you share the moment together.\n\n");
	outputText("Bodies pressed together, the warmth of each other to keep company, you close your eyes as you go in for another kiss. You slowly dig your fingers into her, crooking up as she does the same. You clamp tighter on her slender finger feeling yourself reach closer to the finish. Finally, with a shrill cry, you cum, lubricating her finger further as you cling onto her.\n\n");
	outputText("Evangeline’s breaths grow rapid as her chest heaves, brushing further against your breasts until she cums as well, gripping your finger with all her might. As the height of your orgasm dies, you slowly disentangle yourself from her, beads of saliva dripping from your lips as your coated finger slides out of her.\n\n");
	outputText("Evangeline takes a deep breath, ");
	if (EvangelineSex1) {
		outputText("\"<i>Wow… ah… just as great as I remember it…</i>\"\n\n");
		outputText("You smile knowingly, glad she enjoyed herself with you.\n\n");
	}
	else {
		outputText("\"<i>Wow… ah… first time for everything, that was…</i>\"\n\n");
		outputText("You can only hope she enjoyed it as much as you did.\n\n");
	}
	outputText("She nods softly, mumbling again, \"<i>Yeah… it was great… thanks…</i>\"\n\n");
	outputText("Giving her a gentle grope, you decide to get ready to continue the day again.\n\n");
	if (!EvangelineSex1) EvangelineSex1 = true;
	player.sexReward("Default", "Vaginal", true, false);
	doNext(camp.returnToCampUseOneHour);
}

private function ExperimentsBLBBPlusYourselfRemainClean():void {
	outputText("A success it is! Off to your normal life once more. At least as normal you can call it here.\n\n");
	doNext(Experiments);
	advanceMinutes(10);
}

private function ExperimentsBLBBPlusYourselfBro():void {
	clearOutput();
	player.destroyItems(consumables.BROBREW, 1);
	outputText("You offer Evangeline a bro brew, telling herself you’re ready. You want to see what she’s learned and are willing to be a test dummy for her.\n\n");
	outputText("She grins softly, swiftly taking the can from you as she paces back to her lab. In a flurry of movements, she mixes several other fluids into the bottle as you’re hit with an absolutely foul scent, you flinch in reflex at the stench as it reaches your nostrils. Then, almost immediately, hints of sweet vanilla, fresh beer and something gamey but pleasantly spiced as Evangeline begins mixing all the ingredients. Whatever she’s mixing, it certainly is the concoction.\n\n");
	outputText("\"<i>Finally,</i>\" she states. \"<i>The…</i>\" She pauses before mumbling, \"<i>smart… bro… something, I don’t pay myself to make names for all of these, anyway.</i>\"\n\n");
	ExperimentsBLBBPlusBro1();
	outputText("Evangeline nods, \"<i>You look good, [name]. How are you feeling? You should be mentally intact, if not a little smarter…</i>\"\n\n");
	outputText("Nothing feels off to you, aside from adjusting to your new height and looks, that is.\n\n");
	outputText("\"<i>Anything… else?</i>\" she asks warily. \"<i>If not, then… well, I can call it a success.</i>\"\n\n");
	menu();
	addButton(1, "Get Dirty", ExperimentsBLBBPlusYourselfBroGetDirty).hint(""+(silly()?"Imagine a really funny line here for silly mode. <i>Did you think of one yet? Cool!</i>":"Take your new body on a whole new trip with Evangeline.")+"");
	addButton(3, "Remain Clean", ExperimentsBLBBPlusYourselfRemainClean).hint("Best not to get dirty.");
}

private function ExperimentsBLBBPlusBro1():void {
	if (player.hasPerk(PerkLib.BroBody)) {
		outputText("She sighs softly before mumbling again, \"<i>This’ll surely remedy some of those… issues you’ve been having with your head… I’m sure, now go on… take a drink.</i>\"\n\n");
		outputText("You oblige, after all, what’s the worst that could happen, right? With only a sip, you feel a sudden resurgence in your mind. Your head thrums as you take more, delicately taking in every last drop of Evangeline’s concoction.\n\n");
		outputText("You breathe a sigh of relief as clarity returns to your head. You feel proper again. You also still have a powerful and manly body to compliment your head as well. It’s a win-win already.\n\n");
		if (player.hasPerk(PerkLib.BroBrains)) player.removePerk(PerkLib.BroBrains);
	}
	else {
		outputText("She sighs softly before mumbling again, \"<i>Go on… take a drink.</i>\"\n\n");
		outputText("You oblige, after all, what’s the worst that could happen, right? Being a bro isn’t a terrible fate, is it? With only a sip, you feel a tingling in your body, heat rises to your loins as your legs nearly buckle.\n\n");
		outputText("You can feel your body shift and adjust, quickly shaping up as you raise your back, standing tall as you shake off your arms. Your biceps are massive, you can’t help but raise your arms into a powerful flex to admire the peak of your muscles. Your shoulders are broad and strapping, your back is strong and hard. You glance down and run your fingers through your washboard abs. Everything about you is looking perfect.\n\n");
		outputText("Your chest is strong and manly, with a pair of powerful pectorals that you can bounce rhythmically with an effortless ease. You give your pecs another generous grope, admiring the shapeliness and definition of your forearms as you do so. Everything is so defined. Obliques, abdominals, pectorals, your torso is the pinnacle of perfection.\n\n");
		outputText("Heat slowly rises in your loins as you feel your girthy erection begin to rise. Your balls feel full, fuller than they’ve ever been, begging and aching for release. You thrust your hips slightly as a dribble of precum drools out of your dick as your balls slap against your thick thighs. Your legs are powerfully built and sturdy, the contour of your thighs rigid with pronounced muscle, and your calves are mighty slabs of pure power, supporting the rest of your build effortlessly.\n\n");
		outputText("You examine your body, you are the image of pinnacle masculinity, a rippling body, broad, chiseled form, strapping and imposing, you can’t help but grin, enjoying the changes. All of this, and your mind is intact, too. You’re the perfect package… in more ways than one. You glance at Evangeline, to which she immediately blushes, her gaze averting from you.\n\n");
		player.createPerk(PerkLib.BroBody,0,0,0,0);
		if (!player.hasCock()) {
            transformations.CockHuman(0, 10, 2).applyEffect(false);
            if (player.balls == 0) {
                transformations.BallsDuo.applyEffect(false);
                player.ballSize = 3;
            }
        } else if (player.balls == 0) {
            transformations.BallsDuo.applyEffect(false);
            player.ballSize = 3;
        }
        if (player.biggestTitSize() >= 1) transformations.BreastsShrinkToNothing.applyEffect();
        if (player.hasCock()) {
            if (player.cocks[0].cockLength < 10) {
                if (player.cocks[0].cockThickness < 2.75) player.cocks[0].cockThickness = 2.75;
                player.cocks[0].cockLength = 10;
            }
            if (!player.hasBalls()) {
                transformations.BallsDuo.applyEffect(false);
                player.ballSize = 3;
            }
        }
        else {
            transformations.CockHuman(0, 12, 3).applyEffect(false);
            if (player.balls == 0) {
                transformations.BallsDuo.applyEffect(false);
                player.ballSize = 3;
            }
        }
        if (player.hasVagina()) player.removeVagina(0, 1);
        if (player.femininity > 0) player.modFem(0, 100);
        player.modTone(player.maxToneCap(), player.maxToneCap());
        player.modThickness(player.maxThicknessCap(), (player.maxThicknessCap() * 0.5));
        dynStats("str", 35, "tou", 35, "lib", 5, "lus", 40);
	}
}

private function ExperimentsBLBBPlusYourselfBroGetDirty():void {
	clearOutput();
	outputText("You can’t help but meet her gaze, her cross-shaped pupils are quivering in place, it’s clear she’s interested in your form. "+(player.isNaked()?"":"You take off your [armor] revealing your thick, masculine pecs to her in all its bare glory. ")+"Your hands shift to your hips as you press your chest outward slightly for her as you begin to bounce your pecs for her amusement.\n\n");
	outputText("Evangeline squirms in place softly, brushing her legs together as she tries to avert her gaze once more, but it’s clear she can no longer take her eyes off you. With her rapt attention, you bring your hands above your head, proudly presenting your hulking arms as you continue rhythmically bouncing your pecs for her.\n\n");
	outputText("You can’t help but ask if she’s enjoying what she sees, knowing clear the answer by now.\n\n");
	outputText("She nods softly, \"<i>[name]... you’re… stellar… to put it lightly…</i>\"\n\n");
	outputText("Perhaps she’d enjoy a taste of what you have to offer?\n\n");
	outputText("She takes a deep breath as her face grows red, \"<i>You mean… can I touch..?</i>\"\n\n");
	outputText("It’s a start, you’d gladly give her a chance. With the offer, Evangeline doesn’t waste the moment, taking slow, determined steps toward you as her fingers grace your forms, admiring your chiseled body. Her hands roam around your pecs, carrying the weight of them in her palms as she moves her hand over to rub your bulging arms, admiring the thickness of your biceps and triceps. Even with both of her hands, she can’t wrap the entirety of her hands around your husky arms.\n\n");
	outputText("You lower your arms as she continues to admire you, wrapping them around her waist as you lift her up effortlessly, her weight is practically nonexistent with your strength, comparable to a single blade of grass beneath your feet.\n\n");
	outputText("\"<i>So… huge…</i>\" she mumbles, entranced by your form. As she speaks, you bring a hand to her face, still lifting her effortlessly with a single hand. You brush the hair from her face as you lean in for a gentle kiss, locking your lips together as she practically melts in your embrace. Her hands brush against your pecs, before her fingers gently glide through each ridge of your abdominals. ");
	outputText("You can feel your erection slowly stir from your loins"+(!player.lowerGarment.isNothing?"":" stretching out your underwear through the sheer length and girth of your [cock]")+". Evangeline takes a deep, exaggerated breath as she can feel your presence below her.\n\n");
	outputText("She mumbles again, \"<i>Ah… is this… really happening? I feel like I’m in some fantasy… you’re so… perfect… [name].</i>\" You remind her that it surely is happening, and it’s too late to stop what’s already in motion.\n\n");
	outputText((player.isNaked()?"Your erection brushes against her underside":"You discard the last bits of your [armor], kicking it away as your erection brushes against her underside")+". With a single hand, you help her out of her clothes as she shuffles out of them, still caught against you.\n\n");
	outputText("Barred from clothing, she supports herself by wrapping her legs around your firm waist as her hands reach up to hold onto your shoulders for support. You can’t help but laugh slightly, your firm pecs are rivaling her breasts in size. Your hands roam along her lithe frame, admiring her gentle form before you reach down to cup her ass, giving her a gentle squeeze, eliciting a small gasp from her lips before you silence her with a passionate kiss.\n\n");
	outputText("Her hands fail to stop roaming your form, still clinging onto you for support as they lower down your shoulders, admiring your arms again before shifting to your obliques and brushing your abs. As you break the kiss, she gives you an eager hug, breathing in your manly scent. You take the chance to give her hair a gentle whiff as you clutch tighter onto her. She smells faintly of vanilla and a bevy of herbs.\n\n");
	outputText("Your erection is growing harder, twitching softly as it drools several drops of precum beneath her, staining the grass below you. \"<i>Please,</i>\" she mumbles. \"<i>I want you… give it to me, [name].</i>\"\n\n");
	outputText("You guide your pre-leaking erection to her labia, smearing it across her lips as you slowly lube her up with your natural essence. One of her hands grips you tightly as the other reaches down to assist you eagerly, aligning it with her snatch in a desperate attempt for more.\n\n");
	outputText("You give her womanly ass another teasing squeeze before giving a rocking thrust, driving your rod into her as she heaves a delighted squeal. She grips your dick tightly with every ounce of force she can muster as she rests her head on your chest in a moment of unfiltered bliss.\n\n");
	outputText("Heaving a low moan, you buck into her again, thrusting deeper as you work against her resistance. With each thrust, her legs clutch tighter around you, holding onto you as if her life depended on it. Her arms squeeze you tighter, nails almost digging into your back as she mewls softly, lost in the throes of ecstasy. You can feel her relax for you, allowing you deeper entry as you press further into her, she’s hardly able to take you all, yet, desperately, she wants more as she whispers your name.\n\n");
	outputText("Finally, with a soft croon, she cums, once again gripping you with an inhuman force, desperately trying to milk your cock of every last ounce you have to offer. You continue pumping into her at a steady pace, your balls brushing against her underside at the peak of each thrust as her girlcum lubricates you further, allowing even easier access into her tunnel.\n\n");
	outputText("Evangeline gives you pecs a loving lick, lost in your embrace before she weakly manages to tilt her head up to meet your gaze. Her chin rests just above your chest, eyes begging for more as you lean down, lifting her head up slightly, holding her by the cheek to meet her lips with a welcoming kiss. Your loins stir, spurned on by her enthusiasm as your [cock] twitches madly, pulsating within her as you can feel yourself growing closer to the edge.\n\n");
	outputText("With a loud moan, you thrust into her once more, clenching yourself softly as you unload wave after wave of your seed into her waiting womb. ");
	if (player.cumQ() >= 10000) outputText("She gags slightly as she holds onto you for dear life, \"<i>Gosh… so… much… cum… how do you..?</i>\" ");
	else if (player.cumQ() >= 3000) outputText("Her stomach distends slightly from the sheer volume of your massive load. ");
	outputText("You chest heaves, carrying her slightly with the rhythm of your breaths before you relax as your erection deflates, slipping out of her as your cum flows out past her lips, Evangeline unable to hold it all in.\n\n");
	outputText("You slowly take her down to the ground, pinning her beneath your massive frame. Evangeline takes a deep breath, ");
	if (EvangelineSex1) {
		outputText("\"<i>Wow… ah… just as great as I remember…</i>\"\n\n");
		outputText("As you stroke her hair, you’re glad she enjoyed herself.\n\n");
	}
	else {
		outputText("\"<i>Wow… ah… first time for everything, that was…</i>\"\n\n");
		outputText("As you stroke her hair, you can only hope she enjoyed it as much as you did.\n\n");
	}
	outputText("She nods softly, mumbling again as her legs disentangle from your waist, her limbs falling lazily to the floor, \"<i>Yeah… it was great… thanks…</i>\"\n\n");
	outputText("Giving her a gentle grope, you decide to get ready to continue the day again.\n\n");
	player.sexReward("vaginalFluids", "Dick");
	if (!EvangelineSex1) EvangelineSex1 = true;
	if (!EvangelineVirginity) EvangelineVirginity = true;
	doNext(camp.returnToCampUseOneHour);
}

private function ExperimentsBLBBPlusYourselfNevermind():void {
	outputText("You decide maybe another time.\n\n");
	doNext(Experiments);
}

private function ExperimentsBLBBPlusBimbo():void {
	clearOutput();
	outputText("You offer Evangeline a bimbo liqueur, telling her to make another one with the liqueur.\n\n");
	outputText("She grins softly, swiftly taking the bottle from you as she paces back to her lab. In a flurry of movements, she mixes several other fluids into the bottle as you’re hit with an absolutely foul scent, you flinch in reflex at the stench as it reaches your nostrils. Then, almost immediately, hints of sweet vanilla, fresh wine and herbs as Evangeline begins mixing all the ingredients. Whatever she’s mixing, it certainly is the concoction.\n\n");
	outputText("She mumbles softly to herself, \"<i>Ah… still no name, but go on… drink up.</i>\"\n\n");
	ExperimentsBLBBPlusBimbo1();
	outputText("Evangeline nods,\"<i>You look good, [name]. Still mentally intact, I see</i>\"\n\n");
	outputText("Nothing feels off to you.\n\n");
	outputText("\"<i>Anything… else?</i>\" she asks warily. \"<i>If not, then… well, glad I could do business...</i>\"\n\n");
	menu();
	addButton(1, "Get Dirty", ExperimentsBLBBPlusYourselfBimboGetDirty).hint(""+(silly()?"Lesbians… LESBIANS?! …Lesbians…":"Take your new body on a whole new trip with Evangeline.")+"");
	addButton(3, "Remain Clean", ExperimentsBLBBPlusYourselfRemainClean).hint("Best not to get dirty.");
}

private function ExperimentsBLBBPlusBro():void {
	clearOutput();
	outputText("You offer Evangeline a bro brew, telling her to make another one with the can.\n\n");
	outputText("She grins softly, swiftly taking the can from you as she paces back to her lab. In a flurry of movements, she mixes several other fluids into the bottle as you’re hit with an absolutely foul scent, you flinch in reflex at the stench as it reaches your nostrils. Then, almost immediately, hints of sweet vanilla, fresh beer and something gamey but pleasantly spiced as Evangeline begins mixing all the ingredients. Whatever she’s mixing, it certainly is the concoction.\n\n");
	outputText("She mumbles softly to herself, \"<i>Ah… still no name, but go on… drink up.</i>\"\n\n");
	ExperimentsBLBBPlusBro1();
	outputText("Evangeline nods, \"<i>You look good, [name]. Still mentally intact, I see?</i>\"\n\n");
	outputText("Nothing feels off to you.\n\n");
	outputText("\"<i>Anything… else?</i>\" she asks warily. \"<i>If not, then… well, glad I could do business...</i>\"\n\n");
	menu();
	addButton(1, "Get Dirty", ExperimentsBLBBPlusYourselfBroGetDirty).hint(""+(silly()?"Imagine a really funny line here for silly mode. <i>Did you think of one yet? Cool!</i>":"Take your new body on a whole new trip with Evangeline.")+"");
	addButton(3, "Remain Clean", ExperimentsBLBBPlusYourselfRemainClean).hint("Best not to get dirty.");
}

//IMutations
private var GoM:int = 0;

//GoM stands for Gems or Mutations.
private function InternalMutations():void {
	clearOutput();
	if (EvangelinePeepTalkOnInternalMutations == 0) {
		outputText("You ask Evangeline about ways to further make your body like that of a specific creature. Evangeline raises an eyebrow before replying.\n\n");
		outputText("\"<i>It's possible to further improve yourself through internal mutations, however such changes would cause stress upon your body. You also won't be able to get inner mutations from transformations alone, I would need to craft something special. As a human or former human, your anatomy wasn't made to host foreign organs and thus might react unfavorably to the change causing your health to suffer degeneration. ");
		outputText("I can create the mutagens required to transform your insides, but don't you say I didn't warn you about the after effects. Oh, and before you ask, no, this isn't something a regular transformative can do. While eating food on Mareth can conform your body to that of any race if not literally make you almost like a member of said species at a first glance, it doesn't go deep enough to strip everything human out of you, else you would lose the ability to transform at all. ");
		outputText("<b>Inner mutation requires something more advanced than just eating random food you find across the wilderness. Did you understand all of that?</b></i>\"");
		menu();
		addButton(1, "No", IMutationsYN, false);
		addButton(3, "Yes", IMutationsYN);
	}
	else if (EvangelinePeepTalkOnInternalMutations == 1) {
		outputText("Your confused look annoys Evangeline to no end.\n\n");
		outputText("\"<i>Gosh how did human civilization even become a serious thing out of Mareth when it's made out of people like you. As I just said It's possible to further improve yourself through internal mutations however doing so will cause your body to endure an ever increasing amount of stress due to degeneration. While there are ways to fully become one's race to do so will make you cease to be human. ");
		outputText("For you chimerism is the safest route even if it forces you to constantly seek out the assistance of a skilled medic or daily healing magic treatment. And don't you just try poping those mutations naturaly by eating a hundred of ingrediants the only thing you will get is fat. You need a specialised transformative or straith out primal magic to transform your insides and I can only craft the first. Was this simple enough for you?</i>\"");
		menu();
		addButton(1, "No", IMutationsYN, false);
		addButton(3, "Yes", IMutationsYN);
	}
	else if (EvangelinePeepTalkOnInternalMutations == 2) {
		//if (player.blockingBodyTransformations()){
		//	outputText("Evangeline examines you for a moment, before stating \"Uh, hey [name], your body is kind of tightly hard-wired up together, I don't think any Mutagens are going to be able to help you now. \"\n");
		//	outputText("It seems, because you're now transformatively immune, she won't be able to help you with your mutations.");
		//	doNext(meetEvangeline);
		//}
		//else{
		outputText("\"<i>Did you bring gems or find a vial of the mutagen?</i>\" she asks.\n\n");
		outputText("Her eyes briefly graze your form, \"<i>It looks like the only that way we can do anything about that 'unhealthy drive' of yours is with a little mutation.</i>\" She snickers softly as she waits for your response.");
		menu();
		addButton(1, "Gems", IMutationsGemsOrMutagen, 1).disableIf(player.gems < 500, "Gotta get that 500 gems first.");
		addButton(3, "Mutagen", IMutationsGemsOrMutagen, 2).disableIf(!player.hasItem(useables.E_ICHOR, 1), "Gotta get that vial of mutagen first.");
		addButton(14, "Back", meetEvangeline);
		//}
	}

	function IMutationsYN(yn:Boolean = true):void {
		if (yn) {
			outputText("\n\nEvangeline sighs in relief.");
			outputText("\n\n\"<i>Glad to hear you at least are smarter than a minotaur. Anyways, there are means to reduce the stress on your body from internal mutations. With proper training you can develop the Chimera Corpus Exocell, or in common terms, the chimera body adaptation. This will allow your body to adapt to stress and slowly negate the drawbacks. Of course the lazy route would be to acquire regeneration from a species' inner mutation and thus negate the need to train entirely.</i>\"");
			EvangelinePeepTalkOnInternalMutations = 2;
		} else {
			outputText("\n\nYour confused look annoys Evangeline to no end.");
			outputText("\n\n\"<i>That's fine, but trust me, you really will want my help on this, eventually.</i>\"");
			EvangelinePeepTalkOnInternalMutations = 1;
		}
		doNext(meetEvangeline);
	}

	function IMutationsGemsOrMutagen(costType:int = 0):void {
		outputText("\n\nEvangeline prepares her alchemy lab as she sterilizes a syringe.\n\n\"<i>I can craft a mutagen out of common material or use the one you found to alter one of your organs. The change will be difficult to reverse, though. You'd better make sure this is what you want. Which mutagen would you like me to craft?</i>\"");
		GoM = costType;
		IMutationsSelector(0);
	}
}

private function IMutationsSelector(page:int = 0):void {
	menu();
	var bd:ButtonDataList = new ButtonDataList();
	//Next Page
	bd.add("Heart", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_HEART))).hint("Heart Mutations");
	bd.add("Muscle", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_MUSCLE))).hint("Muscle Mutations");
	bd.add("Mouth", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_MOUTH))).hint("Mouth Mutations");
	bd.add("Adrenal Glands", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_ADRENALS))).hint("Adrenals Mutations");
	bd.add("Bloodstream", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_BLOODSTREAM))).hint("Bloodstream Mutations");
	bd.add("Fat and Tissue", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_FAT))).hint("FaT Mutations");
	bd.add("Lungs", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_LUNGS))).hint("Lungs Mutations");
	bd.add("Metabolism", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_METABOLISM))).hint("Metabolism Mutations");
	bd.add("Ovaries", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_OVARIES))).hint("Ovaries Mutations");
	bd.add("Testicles", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_TESTICLES))).hint("Testicles Mutations");
	bd.add("Eyes", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_EYES))).hint("Eyes Mutations");
	bd.add("Bone/Marrow", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_BONE))).hint("Bone Mutations");
	//Next Page
	bd.add("Nerv/Sys", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_NERVSYS), 1)).hint("Nerv-Sys Mutations");
	bd.add("Thyroid Gland", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_THYROID),1)).hint("Thyroid Mutations");
	bd.add("Parathyroid Gland", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_PARATHYROID),1)).hint("Parathyroid Mutations");
	bd.add("Adaptations", curry(mutationsAssistant, IMutationsLib.mutationsArray(IMutationPerkType.SLOT_ADAPTATIONS),1)).hint("Adaptation Mutations");
	submenu(bd, meetEvangeline, page, false);

	function mutationsAssistant(pArray:Array, menuButton:int = 0):void {
		var bd:ButtonDataList = new ButtonDataList();
		var bdFunc:*;
		var bdDesc:String;
		var target:* = player;
		for each (var mutations:IMutationPerkType in pArray){
			bdFunc = null;
			mutations.pReqs();
			//trace("" + mutations.name() + ": Checking requirements. v");
							  //If using Mutagen, and mutation is not available due to race/lvl reqirements, costs 2 mutagen, otherwise 1, and player has enough slots.
			var mutagenBypass:Boolean = (GoM == 2 && ((!mutations.available(target))? player.hasItem(useables.E_ICHOR, 2) : true) && (!player.blockingBodyTransformations()) && (target.hasMutation(mutations)? true:player.maxCurrentMutationsInSlot(mutations.slot)));
			if ((flags[kFLAGS.EVA_MUTATIONS_BYPASS] || mutations.available(target) || mutagenBypass) && mutations.maxLvl > target.perkv1(mutations)) {	//last bit retains the blocking max mutation level.
				//trace("Requirements met, adding in.");
				bdFunc = curry(mutations.acquireMutation, player, curry(costTaker, mutagenBypass))
				bdDesc = mutations.desc();
			} else if(mutations.maxLvl == target.perkv1(mutations)) {
				//trace("MaxTier acquired");
				bdDesc = "You already have the highest tier!"
			} else {
				if (mutations.requirements.length == 0){
					trace("Requirements empty.");
				}
				else{
					trace("Did not meet requirements.");
				}
				//trace("Unable to meet requirements/requirements borked.");
				//if (mutations.available(target)) trace("\nAvailable: True");
				//if (mutations.maxLvl > target.perkv1(mutations)) trace("MaxLvl: True");
				bdDesc = "You don't meet the requirements for this!";
			}
			if (bdFunc is Function) {
				bd.add(mutations.name(), bdFunc, bdDesc);
			} else {
				bd.add(mutations.name()).disable(bdDesc);
			}
		}
		submenu(bd,curry(IMutationsSelector, menuButton), 0, false)
	}

	function costTaker(mutagenBypassDoubledCost:Boolean):void{
		if (GoM == 1) player.gems -= 500
		else player.destroyItems(useables.E_ICHOR, (mutagenBypassDoubledCost)? 2 : 1);
		menu();
		clearOutput();
		outputText("Evangeline gets to brewing the mutagen. An half hour later, the injection is ready. She has you laid down into a makeshift seat.\n\n");
		outputText("\"<i>This might sting a little… bear it with me [name].</i>\"\n\n");
		outputText("You don't have the time to gasp before she pushes the injection in. The transformative in the wound burns at first but then spreads to your organ as it slowly changes to acquire new inhuman property. The transformation was successful.");
		advanceMinutes(15);
		doNext(InternalMutations);
	}
}
}
}