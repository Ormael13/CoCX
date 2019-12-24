package classes.Scenes.NPCs 
{
	/**
	 * ...
	 * @author Ormael
	 */
	
	import classes.*;
	import classes.BodyParts.Arms;
	import classes.BodyParts.Eyes;
	import classes.BodyParts.Face;
	import classes.BodyParts.Horns;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.Tail;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Monsters.Imp;
	import classes.Items.Armor;
	import classes.Items.ArmorLib;
	import classes.Items.Shield;
	import classes.Items.ShieldLib;
	import classes.Items.Undergarment;
	import classes.Items.UndergarmentLib;
	import classes.Items.Weapon;
	import classes.Items.WeaponLib;
	import classes.Items.WeaponRange;
	import classes.Items.WeaponRangeLib;
	
	public class EvangelineFollower extends NPCAwareContent
	{	
		public function EvangelineFollower() 
		{
		}

	public function evangelineAffection(changes:Number = 0):Number
		{
			flags[kFLAGS.EVANGELINE_AFFECTION] += changes;
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 11 && flags[kFLAGS.EVANGELINE_AFFECTION] > 70) flags[kFLAGS.EVANGELINE_AFFECTION] = 70;
			else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 10 && flags[kFLAGS.EVANGELINE_AFFECTION] > 65) flags[kFLAGS.EVANGELINE_AFFECTION] = 65;
			else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 9 && flags[kFLAGS.EVANGELINE_AFFECTION] > 60) flags[kFLAGS.EVANGELINE_AFFECTION] = 60;
			else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 8 && flags[kFLAGS.EVANGELINE_AFFECTION] > 55) flags[kFLAGS.EVANGELINE_AFFECTION] = 55;
			else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 7 && flags[kFLAGS.EVANGELINE_AFFECTION] > 50) flags[kFLAGS.EVANGELINE_AFFECTION] = 50;
			else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 6 && flags[kFLAGS.EVANGELINE_AFFECTION] > 40) flags[kFLAGS.EVANGELINE_AFFECTION] = 40;
			else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 5 && flags[kFLAGS.EVANGELINE_AFFECTION] > 35) flags[kFLAGS.EVANGELINE_AFFECTION] = 35;
			else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 4 && flags[kFLAGS.EVANGELINE_AFFECTION] > 30) flags[kFLAGS.EVANGELINE_AFFECTION] = 30;
			else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 3 && flags[kFLAGS.EVANGELINE_AFFECTION] > 25) flags[kFLAGS.EVANGELINE_AFFECTION] = 25;
			else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 2 && flags[kFLAGS.EVANGELINE_AFFECTION] > 20) flags[kFLAGS.EVANGELINE_AFFECTION] = 20;
			else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 1 && flags[kFLAGS.EVANGELINE_AFFECTION] > 15) flags[kFLAGS.EVANGELINE_AFFECTION] = 15;
			else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 0 && flags[kFLAGS.EVANGELINE_AFFECTION] > 10) flags[kFLAGS.EVANGELINE_AFFECTION] = 10;
			else if (flags[kFLAGS.EVANGELINE_AFFECTION] < 0) flags[kFLAGS.EVANGELINE_AFFECTION] = 0;
			return flags[kFLAGS.EVANGELINE_AFFECTION];
		}
	
public function enterTheEvangeline():void
{
	clearOutput();
	flags[kFLAGS.EVANGELINE_AFFECTION] = 1;
	outputText("You head out to explore the area when a scream surprises you.\n\n");
	outputText("\"<i>H-help!!</i>\"\n\n");
	outputText("You turn around only for a woman to suddenly flings herself into your arms. She looks like she’s has been roughed up a bit - her simple peasant’s robes have been torn and frayed, and her forehead is streaked with dirt, as if she was dragged through it.\n\n");
	outputText("\"<i>Th-thank gods! Please, you must help me!</i>\" she cries, darting behind you as if to hide. \"<i>I was wandering over the wasteland trying to find a safe place to hide, and, and... the wretched, terrible little things attacked me!</i>\"\n\n");
	outputText("On top of everything, you’re worried that this happened a bit too soon after you left your camp, and you’re about to question her, but you're interrupted as an imp flies out of the sky, growling and clawing at you menacingly. If not for the closeness to your camp you would not care too much, but better to deal with this demon spawn now than later see a whole swarm of them storming your camp. At the moment you were about to charge the enemy you felt a strange wetness on your neck’s nape...or so you thought you felt it.");
	if (flags[kFLAGS.CODEX_ENTRY_IMPS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_IMPS] = 1;
		outputText("\n\n<b>New codex entry unlocked: Imps!</b>")
	}
	player.createStatusEffect(StatusEffects.EzekielCurse, 0, 0, 0, 0);
	startCombat(new Imp());
	doNext(playerMenu);
}

public function winEvangelineImpFight():void
{
	clearOutput();
	outputText("\"<i>Is it safe now?</i>\" Right after you showed that imp who is the champion here, the woman who was standing still while watching you fight from the side asks if it’s safe. After you assure her that it is, she relaxes. After a moment you start asking her about what happened.\n\n");
	outputText("\"<i>I had gone out to find some supplies when I met this creature,</i>\" she says, still casting glances to her sides, \"<i>And then not thinking much, I started to run towards my hiding place, hoping I’d be faster than my pursuer, but he was quite persistent and chased me almost the whole way back. I was so scared he would find that place and then call for his friends. But at the moment I was about to risk it and hide there, you showed up.</i>\"\n\n");
	outputText("As she talks you realize something, did she mention her hiding place is near here? Isn’t that dangerous? Someone you don’t know practically admitted that she is living very close to the portal that you said you would defend. What if she is a demon? Wishing to make things clear you wait till she’s finished talking and ask her directly where she lives. First she seems to be surprised, then becomes confused, and then after that a slight hint of fear before finally answering.\n\n");
	outputText("\"<i>It’s just moment away from your...</i>\" she casts a glance over your shoulder \"<i>...camp. Still I could move it somewhere else, maybe to that desert city or to a different place. But...moving all my stuff would take a lot of time. Especially all my alchemical equipment that those little red devils didn’t find or smash.</i>\"\n\n");
	outputText("Alchemical equipment? Looking at her you wouldn’t have guessed she was an alchemist. You ask her about this and she seems to brighten up and starts talking happily about various experiments she made in the past for no discernible reason. And just when you start to ponder about how to interrupt her she suddenly ceases talking, but only for a short moment.\n\n");
	outputText("\"<i>I know you don’t know me and probably don’t trust me, but could you let me live near your camp? I could help you in case you somehow...transform too much or in some way you don't want to, return to your previous form, or grant you new ones, stronger and more fitted to survive here,</i>\" for a moment you seem to see a gleam in her eye, \"<i>so what do you think? By the way my name’s Evangeline.</i>\"");
	cleanupAfterCombat();
	menu();
	addButton(0, "Move In", Tak);
	addButton(1, "Leave", Nie);
}

public function Tak():void
{
	clearOutput();
	outputText("She may be a suspicious person, but you could say the same about everyone else you’ve met in this realm so far. And after looking at her more closely and how she is now not looking around nervously anymore, you notice that she has got these weird looking eyes, like two cat-like slits crossing in the middle to form a X over the middle of her pupil. If you don’t take this into account she passes for a normal human. Out of curiosity, you casually ask her about her eyes, since normal people don’t have such eyes like this.\n\n");
	outputText("\"<i>My eyes..? ohh that.</i>\" The mention of her eyes seem to make her nervous again. \"<i>You could say it’s the effect of me living in this tainted realm. Some get some 'extras' when born and I just merely gained these weird eyes. Although they have not bestowed me with night vision like for those cat-morphs.</i>\"\n\n");
	outputText("After that you two start to talk for some time about various things. It turns out she’s one of the few remaining humans that have not been taken prisoner or have been already turned into demons. After a long time spent chatting with Evangeline, you change subject to the one of her hideouts. Since you decided to give her a chance it won’t be good if she still stays quite far away from the camp perimeter. So you mention that she can move within your camp borders.\n\n");
	outputText("\"<i>Thank you so much. I will go to my old cave and take my essentials.</i>\" After this Evangeline walks toward a group of large stones, and by moving one of them reveals a cave entrance hidden behind it. Shortly after disappearing your new camp member comes out carrying a bedroll and a small chest. Then despite your protests she picks the spot almost at the edge of the camp as her own.\n\n");
	outputText("\"<i>I didn’t bring any alchemical reagents with me, so if you will need something made I will still need to venture to my old place. But do not worry, those rocks will mask the entrance well... unless some very powerful demon comes here by chance.</i>\" she chuckles and seeing your concerned face quickly reassures that chances for a strong demon to casually wander by are slim.\n\n");
	outputText("Before leaving she stops as if having forgot something and heads to you.\n\n");
	outputText("\"<i>I’m sorry there’s something important near your camp I must keep watch on so I had to curse you to make sure you would let me in. I removed the curse now so you should be all right. Have this fruit as an apology it should be very useful to you.</i>\"\n\n");
	outputText("With all her things organized she heads out of your camp right away out to 'look for more stuff' for alchemical experiments.\n\n");
	outputText("(<b>Evangeline has been added to the Followers menu!</b>)\n\n");
	flags[kFLAGS.EVANGELINE_AFFECTION] = 3;
	flags[kFLAGS.EVANGELINE_FOLLOWER] = 1;
	flags[kFLAGS.EVANGELINE_LVL_UP] = 0;
	flags[kFLAGS.EVANGELINE_GEMS_PURSE] = 0;
	flags[kFLAGS.EVANGELINE_SPELLS_CASTED] = 0;
	flags[kFLAGS.EVANGELINE_TALKS] = 0;
	if (player.hasStatusEffect(StatusEffects.EzekielCurse)) player.removeStatusEffect(StatusEffects.EzekielCurse);
	inventory.takeItem(consumables.EZEKFRU, camp.returnToCampUseOneHour);
}

public function Nie():void
{
	clearOutput();
	outputText("You don’t know her just as she pointed it out. So without veiling anything you say she needs to move her hideout somewhere else.\n\n");
	outputText("\"<i>So that’s how it is? I just wanted to be nice and friendly but you just outright reject my offer.</i>\" She sighs, before slowly turning around. While starting to walk away you still hear her utter few last words. \"<i>Having someone who can help you keep transformations under control would be useful whoever you are. I will soon move out but in case you find some 'unexpected' troubles I will linger around this area for a little bit. Until we meet again stranger.</i>\"\n\n");
	outputText("After rejecting Evangeline’s offer of joining camp you feel satisfied. She could have been just another demoness that was trying to lure you away from your quest. But...those last words somehow were odd. Unexpected troubles? <b>As she leaves, your neck starts burning with latent pain. You check your reflection in a puddle and notice a weird symbol where she touched you... did she actually curse you?</b>\n\n");
	flags[kFLAGS.EVANGELINE_AFFECTION] = 2;
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
	outputText("Deciding to visit your camp’s transformation expert you called Evangeline. Shortly after that she slowly walks toward you.\n\n");
	outputText("\"<i>Hi [name]! Anything I can help you with?</i>\"");
	menu();
	addButton(0, "Appearance", evangelineAppearance).hint("Examine Evangeline's detailed appearance.");
	addButton(1, "Talk", evangelineTalkMenu).hint("Ask Evangeline about something.");
	if (flags[kFLAGS.EVANGELINE_AFFECTION] >= 50) addButton(2, "Sex", evangelineSexMenu).hint("Have some sex with the demonic chimera girl.");//godess
	if (flags[kFLAGS.EVANGELINE_AFFECTION] >= 5 && flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) addButton(3, "Spar", evangelineSparMenu).hint("Get into a quick battle with Evangeline!");
	addButton(4, "Alchemy", evangelineAlchemyMenu).hint("Ask Evangeline to make some transformation item.");
	if (flags[kFLAGS.EVANGELINE_AFFECTION] >= 5 && flags[kFLAGS.EVANGELINE_LVL_UP] >= 1) addButton(5, "Give Gems", LvLUp).hint("Give Evangeline some gems to cover her expenses on getting stronger.");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 7) addButton(9, "Experiments", Experiments).hint("Check on what experiments Evangeline can work on.");//menu do eksperymentow alchemicznych jak tworzenie eksperymentalnych TF lub innych specialnych tworow evangeline typu specjalny bimbo liq lub tonik/coskolwiek nazwane wzmacniajace postacie do sparingu w obozie
	if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 2) addButton(12, "Jiangshi", curingJiangshi);
	if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 3) {
		if (player.hasItem(consumables.VITAL_T, 5) && player.hasItem(consumables.PPHILTR, 5)) addButton(12, "Jiangshi", curingJiangshi);
		else addButtonDisabled(12, "Jiangshi", "Req. five vitality tinctures and five purity philters to fix your 'issue'.");
	}
	if (player.hasKeyItem("Soul Gem Research") >= 0) {
		if (player.statusEffectv1(StatusEffects.SoulGemCrafting) == 0)  addButton(13, "Soul Gem", recivingCraftedSoulGem).hint("Pick up crafted Soul Gem.");
		if (!player.hasStatusEffect(StatusEffects.SoulGemCrafting)) addButton(13, "Soul Gem", craftingSoulGem).hint("Ask Evangeline for crafting Soul Gem.");
	}
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
	else if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 7) outputText("platinum blonde "); 
	else outputText("red ");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 10) outputText("hair are ass-length along with breats that could easily fill a F-cup bra, expansive ass and fertile hips.\n\n");
	else if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 7) outputText("hair are ass-length along with breats that could easily fill a E-cup bra, jiggly ass and curvy hips is quite a change that resulted from her drinking bimbo liquer personaly modified by her.\n\n");
	else outputText("hair short along with breasts not bigger than A cup, almost non-existent butt and boyish hips cause her to look quite tomboyish.\n\n");
	//outputText(".\n\n");
	outputText("She's wearing ");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 8) outputText("a skimpy chain bikini that barely qualifies as armor. The chain is made from links much finer and lighter than normal, so fine that it feels almost silken under fingertips. A simple seal in the g-string-like undergarment states, \"Virgins only.\"");
	else if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 5) outputText("a suit of steel 'armor' which have two round disks that barely cover her nipples, a tight chainmail bikini, and circular butt-plates.");
	else outputText("a simple peasant’s robe that’s torn and frayed in a few places.");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 5) outputText("\n\nBetween collarbones there is a medium sized purple crystal sticking out of her skin that sometimes gently glows.");
	doNext(meetEvangeline);
}

private function evangelineTalkMenu():void {
	clearOutput();
	outputText("What would you like to discuss with Evangeline?");
	menu();
	addButton(0, "Your Eyes", TalkYourEyes).hint("Talk about her unusual eyes.");
	if (flags[kFLAGS.EVANGELINE_TALKS] >= 1) addButton(1, "Demons", TalkDemons).hint("Ask about demons in general.");
	if (flags[kFLAGS.EVANGELINE_TALKS] >= 2) addButton(2, "Past Life", TalkPastLife1).hint("Talk about her past before meeting you.");
	//if (flags[kFLAGS.EVANGELINE_TALKS] >= 3) addButton(3, "3", ).hint("");her father? - na X affection score odblokowywane?
	//if (flags[kFLAGS.EVANGELINE_TALKS] >= 4) addButton(4, "4", ).hint("");her soul? - jak sie PC dowie o byciu demonicą przez nią?
	//if (flags[kFLAGS.EVANGELINE_TALKS] >= 5) addButton(5, "5", ).hint("");
	addButton(14, "Back", meetEvangeline);
}

private function TalkYourEyes():void {
	clearOutput();
	outputText("At first you exchange a few casual word with Evangeline and then you change the subject to her eyes. She has very unusual X shaped irises, and if not for them she could pass for another human. She pauses for a moment before replying.\n\n");
	if (flags[kFLAGS.EVANGELINE_TALKS] >= 1) outputText("\"<i>So you once again want talk about it? Let it be,</i>\"");
	else outputText("\"<i>I was kinda expecting that you would ask about them eventually,</i>\"");
	outputText(" she laughs, her gaze casting toward the ground for a moment. \"<i>Most people ask me the same question sooner or later. To tell you the truth I believe I inherited them from my father, since he had the same eyes too.</i>\" There is a clear sadness in her eyes as she says this.\n\n");
	outputText("\"<i>They are not giving me any benefit I know about, beside making me look like a freak. Well at least all the humans I met before told me this. And some even felt constantly uneasy around me thinking I'm some kind of abomination. Well at least until...</i>\" suddenly she stops and when you question the reason she giving you a gaze saying 'I don't wanna talk about it'. Well looks like they are just a rare trait. But she mentioned something about her father. Changing subject you ask about him.\n\n");
	outputText("\"<i>My father...</i>\" she pauses for a moment before shaking her head. \"<i>No I do not want to talk about him now either. Sorry can you leave me alone for a while?</i>\"");
	evangelineAffection(1);
	if (flags[kFLAGS.EVANGELINE_TALKS] == 0) flags[kFLAGS.EVANGELINE_TALKS]++;
	doNext(evangelineTalkMenu);
	cheatTime2(15);
}

private function TalkDemons():void {
	clearOutput();
	outputText("This time you chat with her about demons in general, like what types of them she’s seen so far or some details about them. Knowing that you’re gonna spend some time in this realm, maybe even the rest of your life, anyone who could help you in your quest would be very useful and she seems like she may know something.\n\n");
	outputText("It turns out Evangeline knows quite a bit about demons. Most of what she knows you already figured out on your own or could have guessed ");
	if (flags[kFLAGS.EVANGELINE_TALKS] >= 2) outputText("but one or two thing are still new to you");
	else outputText("but a few things you’re hearing for the first time");
	outputText(". Large parts of your conversation is spent on discussing the structure of chain of command amongst demons. Feeling satisfied after learning something new you thank her after you finish talking.");
	evangelineAffection(1);
	if (flags[kFLAGS.EVANGELINE_TALKS] == 1) flags[kFLAGS.EVANGELINE_TALKS]++;
	doNext(evangelineTalkMenu);
	cheatTime2(15);
}

private function TalkPastLife1():void {
	clearOutput();
	outputText("This time you ask Evangeline about the time you both met. What she’s been doing or how she managed to avoid demons. For a really long moment she remained silent.\n\n");
	outputText("\"<i>I’m not a champion like you. I have just been living day after day, escaping to the hideouts I made when any of the demons noticed me.</i>\"\n\nOnce again there’s a hint of sadness in her voice.\n\n\"<i>But they were quite persistent in searching for me, always finding each hideout quite fast. With time I wouldn’t get a chance to eat much, so I would get weaker and weaker till one day I would probably be too weak to escape them.</i>\"\n\n");
	outputText("So she was running away from them but that makes you curious to what was the reason she was chased for. She never mentioned anything about demons being so 'organized' and overcoming their typical 'fuck everything' attitude.\n\n");
	outputText("\"<i>Well there’s some reason for that.</i>\"\n\nEvangeline casts her gaze down as she continues.\n\n\"<i>Even demons can go wild for some 'things' like lethicite or other things that could make them stronger in any way.</i>\"\n\n");
	outputText("So it looks like she may have had something that caused all those demons to pursue her for so long. Probably something that is as valuable as this ‘lethicite’.\n\n");
	outputText("\"<i>Yes you could say that. But I hid it before and only by catching me would they know where it’s hidden. Luckily for me they won’t get me now when you’re here, right champion?</i>\" She gives you one of those rare smiles in which you nod to. Sadly further attempts to find out what she hid ");
	if (flags[kFLAGS.EVANGELINE_TALKS] >= 3) outputText("once again fails");
	else outputText("turns out to be futile");
	outputText(". She talks about many things and some may or may not be lies, about this 'treasure' and how you only know it’s well hidden and the demons will never find it without her pointing to the place.");
	evangelineAffection(1);
	if (flags[kFLAGS.EVANGELINE_TALKS] == 2) flags[kFLAGS.EVANGELINE_TALKS]++;
	doNext(evangelineTalkMenu);
	cheatTime2(15);
}
/*
private function TalkPastLife2():void {
	clearOutput();
	outputText("Placeholder text.");po tym jak sie dowie PC iż jest ona demonicą ^^
	evangelineAffection(1);zajmie miejsce PastTalk1 w menu
	if (flags[kFLAGS.EVANGELINE_TALKS] == 0) flags[kFLAGS.EVANGELINE_TALKS]++;
	doNext(evangelineTalkMenu);
	cheatTime2(15);
}

private function TalkPastLife3():void {
	clearOutput();
	outputText("Placeholder text.");po tym jak sie dowie PC iż jest ona boginią ^^
	evangelineAffection(1);zajmie miejsce PastTalk2 w menu
	if (flags[kFLAGS.EVANGELINE_TALKS] == 0) flags[kFLAGS.EVANGELINE_TALKS]++;//ustalić na jakiej wartości flagi bedzie sie pokazywać
	doNext(evangelineTalkMenu);
	cheatTime2(15);
}

private function TalkYourEyes():void {
	clearOutput();
	outputText("Placeholder text.");
	evangelineAffection(1);
	if (flags[kFLAGS.EVANGELINE_TALKS] == 3) flags[kFLAGS.EVANGELINE_TALKS]++;//ustalić na jakiej wartości flagi bedzie sie pokazywać
	doNext(evangelineTalkMenu);
	cheatTime2(15);
}

private function TalkYourEyes():void {
	clearOutput();
	outputText("Placeholder text.");
	evangelineAffection(1);
	if (flags[kFLAGS.EVANGELINE_TALKS] == 4) flags[kFLAGS.EVANGELINE_TALKS]++;
	doNext(evangelineTalkMenu);
	cheatTime2(15);
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
	if (flags[kFLAGS.EVANGELINE_AFFECTION] >= 50) {
		outputText("You suggest a sparring session.  Evangeline asks, \"<i>How should we fight?  Would you rather we spar light or fight like the creatures of this world?</i>\"");
		outputText("\n\n(Do you spar 'light' with no consequences for losing, or would you rather spar 'hard' (with full consequences for loss/win)?)");
	}
	else outputText("You suggest a sparring session.  Evangeline after a moment of hesistation nod in agreement.");
	menu();
	addButton(0, "Light", LightSpar);
	if (flags[kFLAGS.EVANGELINE_AFFECTION] >= 50) addButton(1, "Hard", HardSpar);
	addButton(14, "Back", meetEvangeline);
}

private function LightSpar():void {
	outputText("\n\n");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 8) outputText("Evangeline adjusts her lusty maiden's armor");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 5 && flags[kFLAGS.EVANGELINE_LVL_UP] < 8) outputText("Evangeline adjusts her practically indecent steel armor");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] < 5) outputText("Evangeline adjusts her rags");
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

private function evangelineAlchemyMenu():void {
	clearOutput();
	outputText("\"<i>So you do want another transformational item made by me?</i>\" She asked after hearing what potion you want to purpose to her this time, at which you simply nod. Without wasting time she walks, with you closely behind, toward a entrance to a small cave right outside the camp's border, in which she keep her equipment.\n\n\"<i>So what you want this time for me to make?</i>\" Stopping at the edge of the entrance to lab Evangeline glance in your direction.");
	menu();
	addButton(0, "Gorgon Oil", MakingGorgonPotion).hint("Ask her to brew a special potion that could aid in becoming a gorgon. \n\nCost: 10 Gems \nNeeds 1 Snake Oil and 1 Reptilum.");
	addButton(1, "Vouivre Oil", MakingVouivrePotion).hint("Ask her to brew a special potion that could aid in becoming a vouivre. \n\nCost: 15 Gems \nNeeds 1 Snake Oil and 1 Drake Heart.");
	addButton(2, "Couatl Oil", MakingCouatlPotion).hint("Ask her to brew a special potion that could aid in becoming a couatl. \n\nCost: 10 Gems \nNeeds 1 Snake Oil and 1 Golden Seed.");
	addButton(3, "Centaurinum", MakingCentaurPotion).hint("Ask her to brew a special potion that could aid in becoming a centaur. \n\nCost: 10 Gems \nNeeds 1 Equinum and 1 Minotaur Blood.");
	addButton(4, "Unicornum", MakingUnicornumPotion).hint("Ask her to brew a special potion that could aid in becoming a unicorn. \n\nCost: 20 Gems \nNeeds 1 Equinum and 4 Low-grade Soulforce Recovery Pills.");//1st stage Soul evolution race TF
	//addButton(5, "", ).hint(".");kitsune/salamander TF//Hybryd race TF
	addButton(6, "Nocello Liq", MakingNocelloLiqueur).hint("Ask her to brew a special potion that could aid in becoming a phoenix. \n\nCost: 10 Gems \nNeeds 1 Golden Seed and 1 Salamander Firewater.");//Hybryd race TF
	//addButton(7, "", ).hint(".");siren TF//Hybryd race TF
	addButton(8, "Storm Seed", MakingStormSeed).hint("Ask her to brew a special potion that could aid in becoming a thunderbird. \n\nCost: 10 Gems \nNeeds 1 Magically-enhanced Golden Seed and 1 Voltage topaz.");//Hybryd race TF
	addButton(9, "Enigmanium", MakingEnigmaniumPotion).hint("Ask her to brew a special potion that could aid in becoming a sphinx. \n\nCost: 30 Gems \nNeeds 1 Centarium, 1 Golden Seed and 1 Whisker Fruit.");
	addButton(10, "Alicornum", MakingAlicornumPotion).hint("Ask her to brew a special potion that could aid in becoming a unicorn. \n\nCost: 50 Gems \nNeeds 1 Unicornum and 20 Low-grade Soulforce Recovery Pills/2 bottles of Low-grade Soulforce Recovery Pills.");//2nd stage Soul evolution race TF
	addButton(11, "Scylla Ink", MakingScyllaInkPotion).hint("Ask her to brew a special potion based on Black Ink.");
	//addButton(12, "Abyssal Ink", ).hint("Ask her to brew a special potion based on Black Abbysal Ink.");
	addButton(13, "InferWine", MakingInfernalWinePotion).hint("Ask her to brew a special potion that could aid in becoming a infernal goat/devil. \n\nCost: 480 Gems \nNeeds 1 Satyr Wine, 1 Succubi milk and 1 Incubi draft.");
	addButton(14, "Back", meetEvangeline);
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
	inventory.takeItem(consumables.GORGOIL, evangelineAlchemyMenu);
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
	inventory.takeItem(consumables.VOUIOIL, evangelineAlchemyMenu);
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
	inventory.takeItem(consumables.COUAOIL, evangelineAlchemyMenu);
	cheatTime(1/6);
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
	inventory.takeItem(consumables.CENTARI, evangelineAlchemyMenu);
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
	inventory.takeItem(consumables.UNICORN, evangelineAlchemyMenu);
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
	inventory.takeItem(consumables.NOCELIQ, evangelineAlchemyMenu);
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
	inventory.takeItem(consumables.SRMSEED, evangelineAlchemyMenu);
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
	inventory.takeItem(consumables.ENIGMANIUM, evangelineAlchemyMenu);
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
		outputText("\"<i>I'm sorry but you don't have the materials I need. I need vial of Unicornum and four Mid-grade Soulforce Recovery Pills,</i>\" Evangeline says.");
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
	inventory.takeItem(consumables.ALICORN, evangelineAlchemyMenu);
	cheatTime(1/6);
}

private function MakingScyllaInkPotion():void {
	outputText("\n\n\"<i>So the grey or white ink this time?</i>\"");
	menu();
	addButton(0, "Grey Ink", MakingGreyInkPotion).hint("Grey Ink for Herm Scylla form. \n\nCost: 10 Gems \nNeeds 1 vial of Black Ink and 1 sealed bottle of behemoth cum.");
	addButton(1, "White Ink", MakingWhiteInkPotion).hint("White Ink for Male Scylla form. \n\nCost: 20 Gems \nNeeds 1 vial of Black Ink and 2 sealed bottles of behemoth cum.");
	addButton(4, "Back", evangelineAlchemyMenu);
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
	inventory.takeItem(consumables.GREYINK, evangelineAlchemyMenu);
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
	inventory.takeItem(consumables.WHITEIN, evangelineAlchemyMenu);
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
	inventory.takeItem(consumables.INFWINE, evangelineAlchemyMenu);
	cheatTime(1/4);
}

private function LvLUp():void {
	clearOutput();
	outputText("\"<i>So [name] how much gems will you give me this time for my recovery or new experiments?</i>\" Asks Evangeline waiting for your decision.");
	outputText("\n\nEvangeline gem purse: " + flags[kFLAGS.EVANGELINE_GEMS_PURSE] + " gems");
	menu();
	if (player.gems > 1) addButton(0, "1 gem", Give1Gem).hint("Give Evangeline 1 gem.");
	if (player.gems > 10) addButton(1, "10 gems", Give10Gems).hint("Give Evangeline 10 gems.");
	if (player.gems > 100) addButton(2, "100 gems", Give100Gems).hint("Give Evangeline 100 gems.");
	if (player.level >= 1 && flags[kFLAGS.EVANGELINE_LVL_UP] == 1 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 60) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	if (player.level >= 2 && flags[kFLAGS.EVANGELINE_LVL_UP] == 2 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 108) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	if (player.level >= 3 && flags[kFLAGS.EVANGELINE_LVL_UP] == 3 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 206) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	if (player.level >= 4 && flags[kFLAGS.EVANGELINE_LVL_UP] == 4 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 400) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	if (player.level >= 5 && flags[kFLAGS.EVANGELINE_LVL_UP] == 5 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 640) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 6 && flags[kFLAGS.EVANGELINE_LVL_UP] == 6 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 1250 && player.hasStatusEffect(StatusEffects.CampRathazul)) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 7 && flags[kFLAGS.EVANGELINE_LVL_UP] == 7 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 400) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 8 && flags[kFLAGS.EVANGELINE_LVL_UP] == 8 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 150) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 9 && flags[kFLAGS.EVANGELINE_LVL_UP] == 9 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 11 && flags[kFLAGS.EVANGELINE_LVL_UP] == 10 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 12 && flags[kFLAGS.EVANGELINE_LVL_UP] == 11 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 14 && flags[kFLAGS.EVANGELINE_LVL_UP] == 12 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 15 && flags[kFLAGS.EVANGELINE_LVL_UP] == 13 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 17 && flags[kFLAGS.EVANGELINE_LVL_UP] == 14 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 18 && flags[kFLAGS.EVANGELINE_LVL_UP] == 15 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	//if (player.level >= 20 && flags[kFLAGS.EVANGELINE_LVL_UP] == 16 && flags[kFLAGS.EVANGELINE_GEMS_PURSE] >= 0) addButton(5, "Just Do It!", JustDoIt).hint("JUST DO IT!");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] >= 7) addButton(13, "Experiments", Experiments).hint("Check on what experiments Evangeline can work on.");
	addButton(14, "Back", meetEvangeline);//lvl-up 9: cow TF effects
}//lvl-up 11: succubus TF effects (skrzydła 3 stopien zmiany, rogi jedna para i ogon, moze zmiana odcienia skóry na purpurowy, błekity, różowy lub czerwony)
//koszt vitality tincture, scholar tea i sucubus milk to 6 gems (1 VT to +2 str i tou a 1 ST to +2 do jej statów)
private function Give1Gem():void {
	clearOutput();
	outputText("Reaching into your purse you take out a single gem and hands over it to her.");
	outputText("\n\n\"<i>So stingy...</i>\" she mumble.");
	player.gems -= 1;
	flags[kFLAGS.EVANGELINE_GEMS_PURSE]++;
	outputText("\n\nEvangeline gem purse: " + flags[kFLAGS.EVANGELINE_GEMS_PURSE] + " gems");
	statScreenRefresh();
	doNext(LvLUp);
}

private function Give10Gems():void {
	clearOutput();
	outputText("Reaching into your purse you take out a few gems and hands over it to her.");
	outputText("\n\n\"<i>Not much but still something,</i>\" she mumble.");
	player.gems -= 10;
	flags[kFLAGS.EVANGELINE_GEMS_PURSE] += 10;
	outputText("\n\nEvangeline gem purse: " + flags[kFLAGS.EVANGELINE_GEMS_PURSE] + " gems");
	statScreenRefresh();
	doNext(LvLUp);
}

private function Give100Gems():void {
	clearOutput();
	outputText("Reaching into your purse you take out around a hundred gems and hands over it to her.");
	outputText("\n\n\"<i>Thank you,</i>\" she mumble.");
	player.gems -= 100;
	flags[kFLAGS.EVANGELINE_GEMS_PURSE] += 100;
	outputText("\n\nEvangeline gem purse: " + flags[kFLAGS.EVANGELINE_GEMS_PURSE] + " gems");
	statScreenRefresh();
	doNext(LvLUp);
}

private function JustDoIt():void {
	clearOutput();
	outputText("This time instead of giving her gems you ask if she gathered enough of them for the next stage of her recovery. After a moment of thinking she smiles wide and rush toward her chest with her personal stuff near the bedroll.");
	outputText("\n\n\"<i>I will come back as soon as possible after buying a few needed items. Please don't touch any of my belonging in the meantime,</i>\" you hear her saying before she excitedly rush out of the camp. After watching her leave in a rush you return to your own matter hoping that she will come back soon.");
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 16) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 15) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 14) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 13) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 12) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 11) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 10) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 9) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 0;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 8) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 150;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 7) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 4;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 400;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 6) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 4;//12 lub 18 lub 24 z powodu wypicia zmodyf bimbo liquer bo musi kupic itemy na modyf jego też
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 1250;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 5) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 4;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 640;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 4) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 5;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 400;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 3) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 6;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 206;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 2) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 7;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 108;
	}
	if (flags[kFLAGS.EVANGELINE_LVL_UP] == 1) {
		flags[kFLAGS.EVANGELINE_LVL_UP]++;
		flags[kFLAGS.EVANGELINE_WENT_OUT_FOR_THE_ITEMS] = 8;
		flags[kFLAGS.EVANGELINE_GEMS_PURSE] -= 60;
	}
	doNext(camp.returnToCampUseOneHour);
}

private function curingJiangshi():void {
	clearOutput();
	if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 3) {
		player.destroyItems(consumables.VITAL_T, 5);
		player.destroyItems(consumables.PPHILTR, 5);
		outputText("Evangeline nods as you bring her the ingredients, getting to work. As soon as the potion is finished she pours it over your cursed talisman, causing it to smoke and crumble. The first thing you do as the nasty thing peels off is head back to He’Xin’Dao and look for your gear. Thankfully it doesn't take you long to find it in a chest not to far from the table on which the crazy cat messed you up. Gosh, it feels good to be alive, like REALLY alive.\n\n");
		if (player.weapon == WeaponLib.FISTS || flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2) {
			player.setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
		}
		if (player.weaponRange == WeaponRangeLib.NOTHING) {
			player.setWeaponRange(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_R_ID]) as WeaponRange);
		}
		if (player.shield == ShieldLib.NOTHING || flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2) {
			player.setShield(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_SHIELD_ID]) as Shield);
		}
		if (player.armor == armors.TRADITC) {
			player.setArmor(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_ARMOR_ID]) as Armor);
		}
		if (player.lowerGarment == UndergarmentLib.NOTHING) {
			player.setUndergarment(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_BOTTOM_ID]) as Undergarment, UndergarmentLib.TYPE_LOWERWEAR);
		}
		if (player.upperGarment == UndergarmentLib.NOTHING) {
			player.setUndergarment(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_UNDERWEAR_UPPER_ID]) as Undergarment, UndergarmentLib.TYPE_UPPERWEAR);
		}
		flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
		player.skinTone = "light";
		player.faceType = Face.HUMAN;
		player.eyes.type = Eyes.HUMAN;
		player.horns.type = Horns.NONE;
		player.horns.count = 0;
		player.arms.type = Arms.HUMAN;
		player.lowerBody = LowerBody.HUMAN;
		player.removePerk(PerkLib.HaltedVitals);
		player.removePerk(PerkLib.SuperStrength);
		player.removePerk(PerkLib.PoisonNails);
		player.removePerk(PerkLib.Rigidity);
		player.removePerk(PerkLib.LifeLeech);
		player.removePerk(PerkLib.Undeath);
		player.removePerk(PerkLib.EnergyDependent);
		player.removeStatusEffect(StatusEffects.EnergyDependent);
		outputText("Done with this place you head back to camp.\n\n");
		outputText("<b>(Lost Perks: Halted vitals, Super strength, Poison nails, Rigidity, Life leech, Undeath, Energy dependent)</b>\n\n");
		flags[kFLAGS.CURSE_OF_THE_JIANGSHI]++;
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("Evangeline barely turns to look at you before jumping in surprise.\n\n");
		outputText("\"<i>Oh god just what happened to you [name]! There is a clear obvious issue with your vitality.</i>\"\n\n");
		outputText("You explain your situation to her somewhat.\n\n");
		outputText("\"<i>Look, I will need five vitality tinctures and five purity philters to fix this up, how you get the two is up you you.</i>\"\n\n");
		flags[kFLAGS.CURSE_OF_THE_JIANGSHI]++;
		doNext(camp.campFollowers);
		cheatTime2(15);
	}
}

private function craftingSoulGem():void {
	clearOutput();
	outputText("\"<i>Wait, you want me to craft a soul gem!? What do you even intend to do with it? These things are used to capture and hold souls!</i>\"\n\n");
	outputText("You remind her that it’s your business, telling her that in the end it will serve a greater purpose.\n\n");
	if (player.hasItem(consumables.S_WATER, 5) && player.hasItem(consumables.ECTOPLS, 5) && player.gems >= 2000) {
		player.destroyItems(consumables.S_WATER, 5);
		player.destroyItems(consumables.ECTOPLS, 5);
		player.gems -= 2000;
		statScreenRefresh();
		outputText("\"<i>I hope you know what you're doing. Hand me the recipe and materials, and I will get to work.</i>\"");
		player.createStatusEffect(StatusEffects.SoulGemCrafting,24,0,0,0);
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		outputText("\"<i>Regardless, I can’t craft a soul gem without the proper materials. Gather me 5 Ectoplasm, 5 vials of Pure Spring Water, and 2000 gems for the miscellaneous reagents.</i>\"");
		doNext(meetEvangeline);
	}
}
private function recivingCraftedSoulGem():void {
	clearOutput();
	outputText("As you check on Evangeline she hands a purplish crystal to you.\n\n");
	outputText("\"<i>Here's your soul gem. Please use this responsibly, they are very hard to craft, and quite dangerous.</i>\"\n\n");
	outputText("<b>Acquired Soul Gem</b>\n\n");
	if (flags[kFLAGS.GARGOYLE_QUEST] == 3) flags[kFLAGS.GARGOYLE_QUEST]++;
	player.removeStatusEffect(StatusEffects.SoulGemCrafting);
	inventory.takeItem(useables.SOULGEM, meetEvangeline);
}

private function Experiments():void {
	clearOutput();
	outputText("Placeholder Text.");
	outputText("\n\nEvangeline gem purse: " + flags[kFLAGS.EVANGELINE_GEMS_PURSE] + " gems");
	menu();
	addButton(13, "Give Gems", LvLUp).hint("Give Evangeline some gems to cover her experiments expenses.");
	addButton(14, "Back", meetEvangeline);
}
	}
}