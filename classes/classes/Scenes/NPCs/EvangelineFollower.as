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
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Monsters.Imp;
	import classes.Items.Armor;
	import classes.MutationsLib;
	import classes.Items.Shield;
	import classes.Items.ShieldLib;
	import classes.Items.HeadJewelry;
	import classes.Items.HeadJewelryLib;
	import classes.Items.Undergarment;
	import classes.Items.UndergarmentLib;
	import classes.Items.Weapon;
	import classes.Items.WeaponLib;
	import classes.Items.WeaponRange;
	import classes.Items.WeaponRangeLib;
	import classes.internals.SaveableState;

	public class EvangelineFollower extends NPCAwareContent implements SaveableState
	{
		public static var EvangelinePeepTalkOnInternalMutations:Number;
		public static var EvangelineGemsPurse:Number;
		public static var EvangelineTalks:Number;
		public static var EvangelineAffectionMeter:Number;
		public static var EvangelineFollowerStage:Number;

		public function stateObjectName():String {
			return "EvangelineFollower";
		}

		public function resetState():void {
			EvangelinePeepTalkOnInternalMutations = 0;
			EvangelineGemsPurse = 0;
			EvangelineTalks = 0;
			EvangelineAffectionMeter = 0;
			EvangelineFollowerStage = 0;
		}

		public function saveToObject():Object {
			return {
				"EvangelinePeepTalkOnInternalMutations": EvangelinePeepTalkOnInternalMutations,
				"EvangelineGemsPurse": EvangelineGemsPurse,
				"EvangelineTalks": EvangelineTalks,
				"EvangelineAffectionMeter": EvangelineAffectionMeter,
				"EvangelineFollowerStage": EvangelineFollowerStage
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				EvangelinePeepTalkOnInternalMutations = o["EvangelinePeepTalkOnInternalMutations"];
				EvangelineGemsPurse = o["EvangelineGemsPurse"];
				EvangelineTalks = o["EvangelineTalks"];
				EvangelineAffectionMeter = o["EvangelineAffectionMeter"];
				EvangelineFollowerStage = o["EvangelineFollowerStage"];
			} else {
				// loading from old save
				resetState();
			}
		}

		public function EvangelineFollower()
		{
			Saves.registerSaveableState(this);
		}

public function isEvangelineBirthday():Boolean {
	return date.month == 8;
}

public function evangelineAffection(changes:Number = 0):Number
{
	EvangelineAffectionMeter += changes;
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 11 && EvangelineAffectionMeter > 70) EvangelineAffectionMeter = 75;
	else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 10 && EvangelineAffectionMeter > 65) EvangelineAffectionMeter = 70;
	else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 9 && EvangelineAffectionMeter > 60) EvangelineAffectionMeter = 67;
	else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 8 && EvangelineAffectionMeter > 55) EvangelineAffectionMeter = 60;
	else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 7 && EvangelineAffectionMeter > 50) EvangelineAffectionMeter = 56;
	else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 6 && EvangelineAffectionMeter > 40) EvangelineAffectionMeter = 50;
	else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 5 && EvangelineAffectionMeter > 35) EvangelineAffectionMeter = 45;
	else if (flags[kFLAGS.EVANGELINE_LVL_UP] < 5 && EvangelineAffectionMeter > 40) EvangelineAffectionMeter = 40;//current cap
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
	if (flags[kFLAGS.CODEX_ENTRY_IMPS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_IMPS] = 1;
		outputText("\n\n<b>New codex entry unlocked: Imps!</b>")
	}
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
	flags[kFLAGS.EVANGELINE_LVL_UP] = 0;
	flags[kFLAGS.EVANGELINE_SPELLS_CASTED] = 0;
	//if (player.hasStatusEffect(StatusEffects.EzekielCurse)) player.removeStatusEffect(StatusEffects.EzekielCurse);
	inventory.takeItem(consumables.EZEKFRU, camp.returnToCampUseOneHour);
}

public function Nie():void
{
	clearOutput();
	outputText("You don’t know her just as she pointed it out. So without veiling anything you say she needs to move her hideout somewhere else.\n\n");
	outputText("\"<i>So that’s how it is? I just wanted to be nice and friendly but you just outright reject my offer.</i>\" She sighs, before slowly turning around. While starting to walk away you still hear her utter few last words. \"<i>Having someone who can help you keep transformations under control would be useful whoever you are. I will soon move out but in case you find some 'unexpected' troubles I will linger around this area for a little bit. Until we meet again stranger.</i>\"\n\n");
	outputText("After rejecting Evangeline’s offer of joining camp you feel satisfied. She could have been just another demoness that was trying to lure you away from your quest. But...those last words somehow were odd. Unexpected troubles?\n\n");
	EvangelineAffectionMeter = 2;
	doNext(camp.returnToCampUseOneHour);
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
	doNext(camp.returnToCampUseOneHour);
}

public function meetEvangeline():void {
	clearOutput();
	if (flags[kFLAGS.ZENJI_PROGRESS] == 11 && rand(4) == 0) {
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
	outputText("\"<i>Hi [name]! Anything I can help you with?</i>\"");
	menu();
	addButton(0, "Appearance", evangelineAppearance).hint("Examine Evangeline's detailed appearance.");
	addButton(1, "Talk", evangelineTalkMenu).hint("Ask Evangeline about something.");
	if (EvangelineAffectionMeter >= 50) addButton(2, "Sex", evangelineSexMenu).hint("Have some sex with the demonic chimera girl.");//godess
	if (EvangelineAffectionMeter >= 5) {
		if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) addButton(3, "Spar", evangelineSparMenu).hint("Get into a quick battle with Evangeline!");
		else addButtonDisabled(3, "Spar", "Req. built sparring ring.");
		if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 1) addButton(5, "Give Gems", LvLUp).hint("Give Evangeline some gems to cover her expenses on getting stronger.");
		else addButtonDisabled(5, "Give Gems", "Req. sparring with Evangeline at least once.");
		addButton(8, "I.Mutations", InternalMutations).hint("Check on what internal mutations Evangeline can grant you.");
	}
	else {
		addButtonDisabled(3, "Spar", "Req. 5%+ affection and built sparring ring.");
		addButtonDisabled(5, "Give Gems", "Req. 5%+ affection and sparring with Evangeline at least once.");
		addButtonDisabled(8, "I.Mutations", "Req. 5%+ affection and Evangeline been lvl 6+.");
	}
	addButton(4, "Alchemy", evangelineAlchemyMenu).hint("Ask Evangeline to make some transformation item.");
	//if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 5) addButton(9, "Experiments", Experiments).hint("Check on what experiments Evangeline can work on.");//menu do eksperymentow alchemicznych jak tworzenie eksperymentalnych TF lub innych specialnych tworow evangeline typu specjalny bimbo liq lub tonik/coskolwiek nazwane wzmacniajace postacie do sparingu w obozie
	//addButtonDisabled(9, "???", "Req. Evangeline been lvl 15+.");
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
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 9) outputText("crimson platinum ");
	else if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 5) outputText("platinum blonde ");
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
		if (EvangelineAffectionMeter >= 30) addButton(3, "Father", TalkYourFather).hint("");
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
	eachMinuteCount(15);
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
	eachMinuteCount(15);
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
	eachMinuteCount(15);
}
private function TalkYourFather():void {
	clearOutput();
	outputText("It's been some time she have been living here. Maybe she would tell you a bit more about herself, her past or 'the tresure' she hidden? You asks her if she could tell you something about her father.\n\n");
	if (EvangelineTalks >= 4) outputText("\"<i>Hahahaha so you want hear that stories about me and my father again? Well not like i got so 'much more important' things to do now.</i>\"\n\n");
	else outputText("\"<i>Hmmm. My father...</i>\" Evangeline muse to herself when she heard your reason to finsing her today. \"<i>Well i been living pretty good here for some time and you seems not so untrusty like many others... fine.</i>\"\n\n");
	outputText("After you finds a comfortbale place to sit she stay silent for a while before starting to talking. It manly consists of some shorter or longer sotries that whould be nearly any kid tell how their father took them on a stroll or played with them. They focus much more on the places they both visited with telling not much about her father itself.\n\n");
	outputText("\"<i>...and few times my father took me to this old shrine. I not sure why we had to visit that place. It looked more like place where would some devoted belivers or similar people come and...</i>\"\n\n");
	outputText("Listening to her talk you noticed some interesting fact. Of all places she been taken by her father there was one where she wasn't allowed to run freely around. One where she been strictly forbidden from acting in any way that her father told her. You asks her to tell a bit more about this place.\n\n");
	outputText("\"<i>This place?</i>\" Evangeline goes silent for a moment. \"<i>It's not good place. Even forgetting that it was located in area where was massive battle between two armies it's not good to go there, it's place where not many people would find interesting to visit.</i>\" She seems to be bit flustered when talking about and excusing herself she walks away to work on something in her alchemic lab.\n\n");
	if (flags[kFLAGS.DILAPIDATED_SHRINE_UNLOCKED] < 1) flags[kFLAGS.DILAPIDATED_SHRINE_UNLOCKED] = 1;
	evangelineAffection(1);
	if (EvangelineTalks == 3) EvangelineTalks = 4;
	doNext(evangelineTalkMenu);
	eachMinuteCount(15);
}/*
private function TalkPastLife2():void {
	clearOutput();
	outputText("Placeholder text.\n\n");po tym jak sie dowie PC iż jest ona demonicą ^^
	outputText("Placeholder text.\n\n");
	evangelineAffection(1);zajmie miejsce PastTalk1 w menu
	if (EvangelineTalks == 0) EvangelineTalks += 1;
	doNext(evangelineTalkMenu);
	eachMinuteCount(15);
}
private function TalkPastLife3():void {
	clearOutput();
	outputText("Placeholder text.\n\n");po tym jak sie dowie PC iż jest ona boginią ^^
	evangelineAffection(1);zajmie miejsce PastTalk2 w menu
	if (EvangelineTalks == 0) EvangelineTalks += 1;//ustalić na jakiej wartości flagi bedzie sie pokazywać
	doNext(evangelineTalkMenu);
	eachMinuteCount(15);
}
private function TalkYourEyes():void {
	clearOutput();
	outputText("Placeholder text.");
	evangelineAffection(1);
	if (EvangelineTalks == 4) EvangelineTalks += 1;//ustalić na jakiej wartości flagi bedzie sie pokazywać
	doNext(evangelineTalkMenu);
	eachMinuteCount(15);
}
private function TalkYourEyes():void {
	clearOutput();
	outputText("Placeholder text.");
	evangelineAffection(1);
	if (EvangelineTalks == 5) EvangelineTalks += 1;//ustalić na jakiej wartości flagi bedzie sie pokazywać
	doNext(evangelineTalkMenu);
	eachMinuteCount(15);
}
private function TalkYourEyes():void {
	clearOutput();
	outputText("Placeholder text.");
	evangelineAffection(1);
	if (EvangelineTalks == 6) EvangelineTalks += 1;//ustalić na jakiej wartości flagi bedzie sie pokazywać
	doNext(evangelineTalkMenu);
	eachMinuteCount(15);
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
	if (flags[kFLAGS.EVANGELINE_LVL_UP] < 7) startCombat(new Evangeline1());
	else if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 7 && flags[kFLAGS.EVANGELINE_LVL_UP] < 12) startCombat(new Evangeline2());
	else startCombat(new Evangeline3());
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 0) flags[kFLAGS.EVANGELINE_LVL_UP] = 1;
	evangelineAffection(3);
	monster.XP = Math.round(monster.XP / 2);
}
//może jak bedzie mieć bimbo body to uaktywnić hard spar a w light spar zmienić odnośnik na Evangeline2?
private function HardSpar():void {
	outputText("Evangeline adjusts her lusty maiden's armor and after stretching few times she finished her warm up.  You raise your [weapon] and prepare to fight.  It's on!");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] < 12) startCombat(new Evangeline2());
	else startCombat(new Evangeline3());
	evangelineAffection(10);
}

private function evangelineAlchemyMenu(page:int = 1):void {
	clearOutput();
	outputText("\"<i>So you do want another transformational item made by me?</i>\" She asked after hearing what potion you want to purpose to her this time, at which you simply nod. Without wasting time she walks, with you closely behind, toward a entrance to a small cave right outside the camp's border, in which she keep her equipment.\n\n\"<i>So what you want this time for me to make?</i>\" Stopping at the edge of the entrance to lab Evangeline glance in your direction.");
	menu();
	if (page == 1) {
		addButton(0, "Gorgon Oil", MakingGorgonPotion).hint("Ask her to brew a special potion that could aid in becoming a gorgon. \n\nCost: 10 Gems \nNeeds 1 Snake Oil and 1 Reptilum.");
		addButton(1, "Vouivre Oil", MakingVouivrePotion).hint("Ask her to brew a special potion that could aid in becoming a vouivre. \n\nCost: 15 Gems \nNeeds 1 Snake Oil and 1 Drake Heart.");
		addButton(2, "Couatl Oil", MakingCouatlPotion).hint("Ask her to brew a special potion that could aid in becoming a couatl. \n\nCost: 10 Gems \nNeeds 1 Snake Oil and 1 Golden Seed.");
		addButton(3, "Nocello Liq", MakingNocelloLiqueur).hint("Ask her to brew a special potion that could aid in becoming a phoenix. \n\nCost: 10 Gems \nNeeds 1 Golden Seed and 1 Salamander Firewater.");//Hybryd race TF
		addButton(4, "Unicornum", MakingUnicornumPotion).hint("Ask her to brew a special potion that could aid in becoming a unicorn. \n\nCost: 20 Gems \nNeeds 1 Equinum and 4 Low-grade Soulforce Recovery Pills.");//1st stage Soul evolution race TF
		//addButton(5, "", ).hint(".");kitsune/salamander TF//Hybryd race TF
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
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need vial of Unicornum and two bottles of Low-grade Soulforce Recovery Pills. In case you not have two bottles then twenty Low-grade Soulforce Recovery Pills would work too,</i>\" Evangeline says.");
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
	//if (flags[kFLAGS.EVANGELINE_LVL_UP] == 4 && EvangelineGemsPurse >= 400) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (flags[kFLAGS.EVANGELINE_LVL_UP] == 5 && EvangelineGemsPurse >= 640) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 6 && flags[kFLAGS.EVANGELINE_LVL_UP] == 6 && EvangelineGemsPurse >= 1250 && player.hasStatusEffect(StatusEffects.CampRathazul)) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
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
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 5) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 4;
		EvangelineGemsPurse -= ;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 4) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 5;
		EvangelineGemsPurse -= ;
	}*/
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

private function curingWendigo():void {
	clearOutput();
	if (player.hasItem(consumables.PURPEAC, 5) && player.hasItem(consumables.PPHILTR, 5)) {
		player.destroyItems(consumables.PURPEAC, 5);
		player.destroyItems(consumables.PPHILTR, 5);
		outputText("Evangeline nods as you bring her the ingredients, getting to work. As soon as the potion is finished she pours it over your chest. For the first time since you were cursed you finally can feel the gnawing hunger becoming more tolerable as your form becomes more malleable again provided you transform you might even be able to get rid of it entirely. Sure you still look like a wendigo but now you can actually do something about your appearance, you just need to get some transformatives first.\n\n");
		outputText("<b>(Lost Perks: Halted vitals, Super strength, Poison nails, Rigidity, Life leech, Undeath, Energy dependent)</b>\n\n");
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
		eachMinuteCount(15);
	}
}

private function curingJiangshi():void {
	clearOutput();
	if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 3) {
		player.destroyItems(consumables.VITAL_T, 5);
		player.destroyItems(consumables.PPHILTR, 5);
		outputText("Evangeline nods as you bring her the ingredients, getting to work. As soon as the potion is finished she pours it over your cursed talisman, causing it to smoke and crumble. The first thing you do as the nasty thing peels off is head back to He’Xin’Dao and look for your gear. Thankfully it doesn't take you long to find it in a chest not too far from the table on which the crazy cat messed you up. Gosh, it feels good to be alive, like REALLY alive.\n\n");
		if (player.weapon == WeaponLib.FISTS && flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] < 1 && flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] != 0) {
			player.setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
			flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = 0;
		}
		if (player.weaponRange == WeaponRangeLib.NOTHING && flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] != 0) {
			player.setWeaponRange(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID]) as WeaponRange);
			flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] = 0;
		}
		if (player.shield == ShieldLib.NOTHING && flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] != 0) {
			if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] < 1) player.setShield(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_SHIELD_ID]) as Shield);
			flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID] = 0;
		}
		if (player.armor == armors.TRADITC && flags[kFLAGS.PLAYER_DISARMED_ARMOR_ID] != 0) {
			player.setArmor(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_ARMOR_ID]) as Armor);
			flags[kFLAGS.PLAYER_DISARMED_ARMOR_ID] = 0;
		}
		if (player.lowerGarment == UndergarmentLib.NOTHING && flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_BOTTOM_ID] != 0) {
			player.setUndergarment(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_BOTTOM_ID]) as Undergarment, UndergarmentLib.TYPE_LOWERWEAR);
			flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_BOTTOM_ID] = 0;
		}
		if (player.upperGarment == UndergarmentLib.NOTHING && flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_UPPER_ID] != 0) {
			player.setUndergarment(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_UPPER_ID]) as Undergarment, UndergarmentLib.TYPE_UPPERWEAR);
			flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_UPPER_ID] = 0;
		}
		if (player.headJewelry == HeadJewelryLib.NOTHING && flags[kFLAGS.PLAYER_DISARMED_HEAD_ACCESORY_ID] != 0) {
			player.setHeadJewelry(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_HEAD_ACCESORY_ID]) as HeadJewelry);
			flags[kFLAGS.PLAYER_DISARMED_HEAD_ACCESORY_ID] = 0;
		}
		flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
		player.skinTone = "light";
		CoC.instance.transformations.FaceHuman.applyEffect(false);
		player.eyes.type = Eyes.HUMAN;
		player.horns.type = Horns.NONE;
		player.horns.count = 0;
		player.arms.type = Arms.HUMAN;
		player.lowerBody = LowerBody.HUMAN;
		if (player.hasPerk(PerkLib.CursedTag)) {
			player.removePerk(PerkLib.CursedTag);
			player.perkPoints += 1;
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
		player.strtouspeintwislibsenCalculation2();
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
		eachMinuteCount(15);
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
	outputText("<b>Acquired Soul Gem</b>\n\n");
	if (flags[kFLAGS.GARGOYLE_QUEST] == 3) flags[kFLAGS.GARGOYLE_QUEST]++;
	player.removeStatusEffect(StatusEffects.SoulGemCrafting);
	inventory.takeItem(useables.SOULGEM, meetEvangeline);
}

private function InternalMutations():void {
	clearOutput();
	if (EvangelinePeepTalkOnInternalMutations == 0) {
		outputText("You ask Evangeline about ways to further make your body like that of a specific creature. Evangeline raises an eyebrow before replying.\n\n");
		outputText("\"<i>It's possible to further improve yourself through internal mutations, however such changes would cause stress upon your body. You also won't be able to get inner mutations from transformations alone, I would need to craft something special. As a human or former human your anatomy wasn't made to host foreign organs and thus might react unfavorably to the change causing your health to suffer degeneration. ");
		outputText("I can create the mutagens required to transform your insides but don't you say I didn't warn you about the after effects. Oh and before you ask, no this isn't something a regular transformative can do. While eating food on Mareth can conform your body to that of any race if not literally make you almost like a member of said species at a first glance, it doesn't go deep enough to strip everything human out of you, else you would lose the ability to transform at all. ");
		outputText("Inner mutation requires something more advanced than just eating random food you find across the wilderness. Did you understand all of that?</i>\"");
		menu();
		addButton(1, "No", InternalMutationsNie);
		addButton(3, "Yes", InternalMutationsTak);
	}
	else if (EvangelinePeepTalkOnInternalMutations == 1) {
		outputText("Your confused look annoys Evangeline to no end.\n\n");
		outputText("\"<i>Gosh how did human civilization even become a serious thing out of Mareth when it's made out of people like you. As I just said It's possible to further improve yourself through internal mutations however doing so will cause your body to endure an ever increasing amount of stress due to degeneration. While there are ways to fully become one's race to do so will make you cease to be human. ");
		outputText("For you chimerism is the safest route even if it forces you to constantly seek out the assistance of a skilled medic or daily healing magic treatment. And don't you just try poping those mutations naturaly by eating a hundred of ingrediants the only thing you will get is fat. You need a specialised transformative or straith out primal magic to transform your insides and I can only craft the first. Was this simple enough for you?</i>\"");
		menu();
		addButton(1, "No", InternalMutationsNie);
		addButton(3, "Yes", InternalMutationsTak);
	}
	else if (EvangelinePeepTalkOnInternalMutations == 2) {
		outputText("\"<i>Did you bring gems or find a vial of the mutagen?</i>\" she asks.\n\n");
		outputText("Her eyes briefly graze your form, \"<i>It looks like the only that way we can do anything about that 'unhealthy drive' of yours is with a little mutation.</i>\" She snickers softly as she waits for your response.");
		menu();
		addButton(0, "Back", meetEvangeline);
		if (player.gems >= 500) addButton(2, "Gems", InternalMutationsGemsOrMutagen);
		else addButtonDisabled(2, "Gems", "Gotta get that 500 gems first.");
		if (player.hasItem(useables.E_ICHOR, 1)) addButton(4, "Mutagen", InternalMutationsGemsOrMutagen);
		else addButtonDisabled(4, "Mutagen", "Gotta get that vial of mutagen first.");
	}
}
private function InternalMutationsNie():void {
	outputText("\n\nYour confused look annoys Evangeline to no end.");
	outputText("\n\n\"<i>That's fine, but trust me, you really will want my help on this, eventually.</i>\"");
	EvangelinePeepTalkOnInternalMutations = 1;
	doNext(meetEvangeline);
}
private function InternalMutationsTak():void {
	outputText("\n\nEvangeline sighs in relief.");
	outputText("\n\n\"<i>Glad to hear you at least are smarter than a minotaur. Anyways, there are means to reduce the stress on your body from internal mutations. With proper training you can develop the Chimera Corpus Exocell, or in common terms, the chimera body adaptation. This will allow your body to adapt to stress and slowly negate the drawbacks. Of course the lazy route would be to acquire regeneration from a species' inner mutation and thus negate the need to train entirely.</i>\"");
	EvangelinePeepTalkOnInternalMutations = 2;
	doNext(meetEvangeline);
}
private function InternalMutationsGemsOrMutagen():void {
	outputText("\n\nEvangeline prepares her alchemy lab as she sterilizes a syringe.\n\n\"<i>I can craft a mutagen out of common material or use the one you found to alter one of your organs. The change will be difficult to reverse, though. You'd better make sure this is what you want. Which mutagen would you like me to craft?</i>\"");
	InternalMutations0();
}
private function InternalMutations0(page:int = 0):void {
	menu();
	var menuItems:Array = [];
	menuItems.push("Heart", InternalMutationsHeart, "Heart Mutations");
	menuItems.push("Muscle", InternalMutationsMuscle, "Muscle Mutations");
	menuItems.push("Mouth", InternalMutationsMouth, "Mouth Mutations");
	menuItems.push("Adrenal Glands",InternalMutationsAdrenals, "Adrenals Mutations");
	menuItems.push("Bloodstream",InternalMutationsBloodstream, "Bloodstream Mutations");
	menuItems.push("Fat and Tissue", InternalMutationsFaTissue, "FaT Mutations");
	menuItems.push("Lungs",InternalMutationsLungs, "Lungs Mutations");
	menuItems.push("Metabolism", InternalMutationsMetabolism, "Metabolism Mutations");
	menuItems.push("Ovaries", InternalMutationsOvaries, "Ovaries Mutations");
	menuItems.push("Testicles", InternalMutationsTesticles, "Testicles Mutations");
	menuItems.push("Eyes", InternalMutationsEyes, "Eyes Mutations");
	menuItems.push("Bone/Marrow", InternalMutationsBoneMarrow, "Bone Mutations");
	//Next Page
	menuItems.push("Nerv/Sys", InternalMutationsPNervSys, "Nerv-Sys Mutations");
	menuItems.push("Thyroid Gland", InternalMutationsThyroidGlands, "Thyroid Mutations");
	menuItems.push("Parathyroid Gland", InternalMutationsParathyroid, "Parathyroid Mutations");
	menuItems.push("Adaptations", InternalMutationsAdaptations, "Adaptation Mutations");
	menuGen(menuItems, page, meetEvangeline);

	function InternalMutationsHeart():void{
		var btnNum:int = 0
		menu();
		//Heart Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("Heart")){
			mutationsAssistant(mutate, btnNum++, "heart");
		}
		addButton(14, "Back", InternalMutations0);
	}

	function InternalMutationsMuscle():void{
		var btnNum:int = 0;
		menu();
		//Muscle Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("Muscle")){
			mutationsAssistant(mutate, btnNum++, "muscle");
		}
		addButton(14, "Back", InternalMutations0);
	}

	function InternalMutationsMouth():void{
		var btnNum:int = 0
		menu();
		//Mouth Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("Mouth")){
			mutationsAssistant(mutate, btnNum++, "mouth");
		}
		addButton(14, "Back", InternalMutations0);
	}

	function InternalMutationsAdrenals():void{
		var btnNum:int = 0
		menu();
		//Adrenal Glands Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("Adrenals")){
			mutationsAssistant(mutate, btnNum++, "adrenals");
		}
		addButton(14, "Back", InternalMutations0);
	}

	function InternalMutationsBloodstream():void{
		var btnNum:int = 0
		menu();
		//Bloodstream Mutations, not bloodsteam, unless you're boiling blood.
		for each (var mutate:Array in MutationsLib.mutationsArray("Bloodstream")){
			mutationsAssistant(mutate, btnNum++, "bloodstream");
		}
		addButton(14, "Back", InternalMutations0);
	}

	function InternalMutationsFaTissue():void{
		var btnNum:int = 0
		menu();
		//Fat tissue Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("FaT")){
			mutationsAssistant(mutate, btnNum++, "fat and tissue");
		}
		addButton(14, "Back", InternalMutations0);
	}

	function InternalMutationsLungs():void{
		var btnNum:int = 0
		menu();
		//Lungs Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("Lungs")){
			mutationsAssistant(mutate, btnNum++, "lungs");
		}
		addButton(14, "Back", InternalMutations0);
	}

	function InternalMutationsMetabolism():void{
		var btnNum:int = 0
		menu();
		//Metabolism Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("Metabolism")){
			mutationsAssistant(mutate, btnNum++, "metabolism");
		}
		addButton(14, "Back", InternalMutations0);
	}

	function InternalMutationsOvaries():void{
		var btnNum:int = 0
		menu();
		//Ovaries Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("Ovaries")){
			mutationsAssistant(mutate, btnNum++, "ovaries");
		}
		addButton(14, "Back", InternalMutations0);
	}

	function InternalMutationsTesticles():void{
		var btnNum:int = 0
		menu();
		//Testicle Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("Testicles")){
			mutationsAssistant(mutate, btnNum++, "testicles");
		}
		addButton(14, "Back", InternalMutations0);
	}

	function InternalMutationsEyes():void {
		var btnNum:int = 0
		menu();
		//Eyes Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("Eyes")){
			mutationsAssistant(mutate, btnNum++, "eyes");
		}
		addButton(14, "Back", InternalMutations0);
	}

	function InternalMutationsBoneMarrow():void{
		var btnNum:int = 0
		menu();
		//Bones and Marrow Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("Bone")){
			mutationsAssistant(mutate, btnNum++, "bone marrow");
		}
		addButton(14, "Back", InternalMutations0);
	}

	function InternalMutationsPNervSys():void{
		var btnNum:int = 0
		menu();
		//Peripheral/NervSys Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("Nerv/Sys")){
			mutationsAssistant(mutate, btnNum++, "nerv-sys");
		}
		addButton(14, "Back", curry(InternalMutations0, 1));
	}

	function InternalMutationsThyroidGlands():void{
		var btnNum:int = 0
		menu();
		//Thyroid Glands Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("Thyroid")){
			mutationsAssistant(mutate, btnNum++, "thyroid glands");
		}
		addButton(14, "Back", curry(InternalMutations0, 1));
	}

	function InternalMutationsParathyroid():void{
		var btnNum:int = 0
		menu();
		//ParaThyroid Glands Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("PThyroid")){
			mutationsAssistant(mutate, btnNum++, "parathyroid glands");
		}
		addButton(14, "Back", curry(InternalMutations0, 1));
	}

	function InternalMutationsAdaptations():void{
		var btnNum:int = 0
		menu();
		//Adaptations Mutations
		for each (var mutate:Array in MutationsLib.mutationsArray("Adaptations")){
			mutationsAssistant(mutate, btnNum++, "adaptations");
		}
		addButton(14, "Back", curry(InternalMutations0, 1));
	}

	function InternalMutationsText():void {
		
	}

	function mutationsAssistant(perkName:Array, menuButton:int, partSwap:String):void {
		var perkCount:int = 0
		for each(var perkTier:PerkType in perkName) {
			if (!(player.hasPerk(perkTier))) {
				if (perkTier.available(player)) {
					addButton(menuButton, perkName[0].name(), perkChoice, perkTier, partSwap, -9000, "Next Perk: " + perkTier.name())
				} else {
					addButtonDisabled(menuButton, perkName[0].name(), "Requirements not met. Check MutationsDB.");
				}
				break;
			}
			perkCount++
		}
		if (perkCount == perkName.length) {
			addButtonDisabled(menuButton, perkName[0].name(), "Highest Tier obtained!");
		}
	}

	function mutationsAssistant2(perkName:Array, menuButton:int, partSwap:String):void {
		var perkCount:int = 0
		if (!(player.hasPerk(perkName[0]))) {
			if (perkName[0].available(player)) {
				addButton(menuButton, perkName[0].name(), perkChoice2, perkName, partSwap, -9000, "Next Perk: " + perkName[0].name())
			} else {
				addButtonDisabled(menuButton, perkName[0].name(), "Requirements not met. Check MutationsDB.");
			}
		}
		perkCount++
		if (perkCount == perkName[1]) {
			addButtonDisabled(menuButton, perkName[0].name(), "Highest Tier obtained!");
		}
	}

	function perkChoice(perkTier:PerkType, partSwap:String):void {
		clearOutput();
		if (player.hasItem(useables.E_ICHOR, 1)) player.destroyItems(useables.E_ICHOR, 1);
		else player.gems -= 500;
		outputText("Evangeline gets to brewing the mutagen. An half hour later, the injection is ready. She has you laid down into a makeshift seat.\n\n");
		outputText("\"<i>This might sting a little… bear it with me [name].</i>\"\n\n");
		outputText("You don't have the time to gasp before she pushes the injection in. The transformative in the wound burns at first but then spreads to your " + partSwap + " as it slowly changes to acquire new inhuman property. The transformation was successful. You now have "+ perkTier.name() +"!");
		player.createPerk(perkTier, 0, 0, 0, 0);
		eachMinuteCount(30);
		doNext(InternalMutations);
	}

	function perkChoice2(perkTier:Array, partSwap:String):void {
		clearOutput();
		if (player.hasItem(useables.E_ICHOR, 1)) player.destroyItems(useables.E_ICHOR, 1);
		else player.gems -= 500;
		outputText("Evangeline gets to brewing the mutagen. An half hour later, the injection is ready. She has you laid down into a makeshift seat.\n\n");
		outputText("\"<i>This might sting a little… bear it with me [name].</i>\"\n\n");
		outputText("You don't have the time to gasp before she pushes the injection in. The transformative in the wound burns at first but then spreads to your " + partSwap + " as it slowly changes to acquire new inhuman property. The transformation was successful. You now have "+ perkTier.name() +"!");
		if (player.hasPerk(perkTier[0])) player.setPerkValue(perkTier[0],1,player.perkv1(perkTier[0]) + 1);
		else player.createPerk(perkTier[0], 1, 0, 0, 0);
		eachMinuteCount(30);
		doNext(InternalMutations);
	}
}

private function Experiments():void {
	clearOutput();
	outputText("\"<i>So [name] what project you think should be handled first? Or maybe you want another vial of mixture from one of the finished project?</i>\" Asks Evangeline waiting for your decision. \"<i>Since you covered all expenses it's your choice.</i>\"");
	outputText("\n\nEvangeline gem purse: " + EvangelineGemsPurse + " gems");
	menu();
	addButtonDisabled(0, "BL/BB Plus", "Bimbo Liquer Plus / Bro Brew Plus");
	addButtonDisabled(1, "Amazon L.", "Amazon Liquer");
	addButton(13, "Give Gems", LvLUp).hint("Give Evangeline some gems to cover her experiments expenses.");
	addButton(14, "Back", meetEvangeline);
}
	}
}