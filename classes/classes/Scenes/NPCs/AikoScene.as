/**
 * ...
 * @author Zakanard
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.Aiko;

	public class AikoScene extends NPCAwareContent
	{
		
		public function AikoScene() 
		{}
		
public function aikoAffection(changes:Number = 0):Number
{
	flags[kFLAGS.AIKO_AFFECTION] += changes;
	if (flags[kFLAGS.AIKO_AFFECTION] > 100) flags[kFLAGS.AIKO_AFFECTION] = 100;
	return flags[kFLAGS.AIKO_AFFECTION];
}

public function aikoCorruption(changes:Number = 0):Number
{
	flags[kFLAGS.AIKO_CORRUPTION] += changes;
	if (flags[kFLAGS.AIKO_CORRUPTION] > 100) flags[kFLAGS.AIKO_CORRUPTION] = 100;
	if (flags[kFLAGS.AIKO_CORRUPTION] < 0) flags[kFLAGS.AIKO_CORRUPTION] = 0;
	return flags[kFLAGS.AIKO_CORRUPTION];
}

public function firstDeepWoodEncounter():void {
	clearOutput();
	outputText("As you walk deeper into the forest, it feels as though the dense foliage is creeping in even closer, while the thick canopy of leaves overhead threatens to blot out your view of the sky. By what little light manages to filter down through the trees, you can see that the rough-hewn dirt path you have been following dwindles down to almost nothing ahead, in the late stages of being reclaimed by the untamed wilderness.\n\n");
	outputText("Wherever you are, you are certain that you have never explored here before, and while you are mindful of this land’s dangers, you are curious what secrets this part of the forest might hold. You press on, trudging through the weed-choked trail, doing your best to keep your wits about you as you march onwards into the darkness.\n\n");
	outputText("Just as you are considering turning back, you see a faint light coming from somewhere up ahead. Stumbling through the undergrowth, you locate the source of the light—in front of you stands a massive, ancient-looking tree, with little wisps of blue flame dancing among the leaves, and an old, weathered sign hanging at the base. The writing on the sign is peeling and faded, but what few characters remain legible appear to be written in a strange language anyway.\n\n");
	outputText("You turn around, ready to go back the way you came, only to find that the trail that led you here has disappeared! You give an involuntary shudder as you hear the sound of ghostly feminine laughter echoing through the forest, sounding as though it’s coming from all around you.\n\n");
	outputText("Running into the undergrowth, you search for the path, but suddenly find yourself stumbling back out into the clearing once again. Wondering how you could have been turned around so badly, you march back into the forest, wandering around for a few more minutes before emerging into a clearing again, stopping in your tracks as the same ghostly tree looms in front of you once more.\n\n");
	outputText("One of the flames breaks from the group, gently wafting down to float in front of your face. It dances about your arms, sending a cool tingling sensation across your limbs, and then flies away, disappearing behind the trunk of the tree. You follow it, chasing it around the tree, but trip on one of the exposed roots. As you stand, rubbing your jaw tenderly, you notice a small, featureless white ball resting in a cavity in the tree, and curiously reach out to grab it.\n\n");
	outputText("The clearing is suddenly bathed in a brilliant flash, forcing you to shield your eyes. When you open them again, you are greeted with the sight of something monstrously huge emerging from the underbrush, far too large to have been hiding there. A giant! You can’t be sure, but you estimate that it must be at least fifty feet tall, and it is clad in brightly-colored metal armor from head to toe.\n\n");
	outputText("You ready your [weapon], wondering how you could possibly fight something so huge, as the giant locks its glowing green eyes onto you, it raises its enormous armored foot, and you close your eyes, using the last few moments you have left to reflect on your life before being crushed beneath this impossible being’s heel.\n\n");
	outputText("When the impending death never arrives, you open your eyes, and shuffle back a bit in surprise, as standing before you now is not a 50-foot armored monstrosity, but a beautiful woman with a short mane of silver-blonde hair, parted by a pair of large triangular ears. She is dressed in a set of revealing blue and white robes that show off her girlish curves, her breasts squashed tightly into a cloth chest wrap. ");
	outputText("The pale blue flames dance around her, casting an eerie light across her features, and you can see that she has some red markings on her face, her lips curled into a perpetual smirk. Behind her, a group of seven luxuriously fluffy fox tails sways to and fro’ in time with an unheard melody.\n\n");
	outputText("\"<i>You should have seen the look on your face!</i>\" she says, laughing at you. \"<i>You actually thought you were going to be crushed, didn’t you?</i>\"\n\n");
	outputText("You find yourself at a loss for words, your mouth hanging agape.\n\n");
	outputText("Giggling lightly, the fox-eared woman walks up to you, pushing your lower jaw up with her index finger and walking around you, as if sizing you up. \"<i>Hmm...It’s been a long time since I’ve seen a newcomer around here,</i>\" she said, nodding slowly to herself. \"<i>You must be the one that everyone’s talking about.</i>\"\n\n");
	outputText("Everyone? What is she talking about? Finally, you come to your senses and ask her who she is, and what just happened to the giant.\n\n");
	if (player.tailType == 13 && player.tailCount == 9 && player.kitsuneScore() >= 12) {
		outputText("\"<i>I'm Aiko, the guardian of this woo-</i>\" she suddenly stops and wides her eyes, noting the swishy wheel of nine tails behind you. Gritting her teeth, she immediately falls on her knees, biting her lower lip much to your confusion. \"<i>Please accept my deepest apologies! I... i didn't think you were nine-tails, my " + player.mf("lord","lady") + "! I'm so sorry!</i>\"\n\n");
		outputText("Confused, you rub your fingers into your [hair], speechless. After some time, your recall Ayane's description of nine-tailed kitsunes, you are supposed to be nobility into the kitsune race, but you give a playful smile and tell her to not worry about that since it's your first meeting, offering her a hand.\n\n");
		outputText("Embarrassed, she lower her ears in shame and accepts your help, moving nervously her seven swishy tails. \"<i>I-I just can't resist playing with newcomers, but since you fell into my prank, I thought you were some kind of illusionist with your tails!</i>\" ");
		outputText("Giving a very nervous laugh, she successfully tries to mask her embarrassed blush. \"<i>My name is Aiko, the guardian of this woods. My village didn't inform me that a nine-tails was on " + player.mf("his","her") + " way to visit us.. can I ask yours, my " + player.mf("lord","lady") + "?</i>\"\n\n");
		outputText("You calmly give her your name, she's a very interesting fellow, at least she's not trying to rape you like half of Mareth. You add that you only recently became a nine-tailed kitsune and you are still learning about their culture, telling her she shouldn't be so formal.\n\n");
		outputText("\"<i>" + player.mf("Lord","Lady") + " [name]... no... [name]... It can be a bit sudden.. but can I ask you my ball back, please? You know how important is for us, probably you have one of your own, too.</i>\" The sheep girl approach your defeated form and knock you out with a rock.\n\n");
		outputText("\"<i>Even if I'm strong, I don't know if I can match the power of a High " + player.mf("Priest", "Priestess") + " of our god... but if I have to, I can get pretty rough... so tell me, [name], do I have to get rough?</i>\"\n\n");
	}
	else if (player.tailType == 13 && player.tailCount >= 2 && player.kitsuneScore() >= 6) {
		outputText("\"<i>I'm Aiko, the guardian of this woods, i see that you are one of my kind, but you are not from my village. So, are other clans still unaffected by the corruption?</i>\"\n\n");
		outputText("Calmly, you explain that you only recently have become a kitsune via the magic that lurks in Mareth. She gives a playful nod and laughs slightly. \"<i>I just can't resist, it was so easy to trick you, you need to improve if you want to be a full-fledged kitsune!</i>\" she says with a playful grin, you can't help to be a bit embarrassed for this.\n\n");
		outputText("\"<i>Anyhow, what's your name, fellow kitsune? We don't get visits often since the Demons came.</i>\" she asks, folding her arms under her D-cup giggling breasts.\n\n");
		outputText("You give her your name, somewhat relieved to find another resident of this world that is interested in more than beating you into submission and raping you—at least, so far.\n\n");
		outputText("\"<i>[name], huh? Well, [name], would it be too much trouble for you to give me back my Ball? You know how important is for us since you're my kind.</i>\" Politely, she asks her ball back. You know how important the sphere is for a kitsune, but before you can take the decision, she cuts you off. \"<i>Of course, I'm not afraid to get rough when I need to, tell me, [name], do I have to get rough?</i>\"\n\n");
	}
	else {
		outputText("\"<i>I am Aiko, guardian of these woods. You’re trespassing in kitsune territory. Didn’t you see the sign?</i>\"\n\n");
		outputText("You explain to her that you couldn’t read the sign, but even when you tried to leave, you ended up getting turned around again and again.\n\n");
		outputText("\"<i>Oh. Right...</i>\" Aiko says, making a show of trying to look innocent. \"<i>“What can I say, I just couldn’t resist! Like I said, you’re the first newcomer I’ve seen in quite some time. There’s only so much amusement to be found when your only company is a tree. So then, newcomer, I’ve given you my name, why don’t you tell me yours?</i>\"\n\n");
		outputText("You give her your name, somewhat relieved to find another resident of this world that is interested in more than just beating you into submission and raping you—at least so far.\n\n");
		outputText("\"<i>[name], huh? Well, [name], would it be terribly too much trouble for you to give me back my Ball?</i>\" she says, pointing to the white ball in your hand. Wary of simply taking anything at face value, you ask her why it’s so important to her, and what exactly she’s guarding all the way out here in the wilderness.\n\n");
		outputText("\"<i>As the chosen guardian of my clan, it’s my duty to protect these woods, and all the kitsune who reside in it,</i>\" she explains, gesturing around. \"<i>It’s not as glamorous as it all sounds,</i>\" she assures you. \"<i>I mostly just use my illusions to scare off imps, other demonic vermin and tourists. Like you!</i>\"\n\n");
		outputText("You are a little irritated about being called a “tourist” of all things, ");
		if (player.cor > 20 ) outputText("and tell her as much with a slight scowl, ");
		outputText("but you nod");
		if (player.cor <= 20) outputText(" politely");
		outputText(", now understanding that the giant was merely an illusion cast by this girl.\n\n");
		outputText("\"<i>Of course, I’m not afraid to get rough when I have to. So tell me, [name], do I have to get rough?</i>\"\n\n");
	}
	flags[kFLAGS.AIKO_CORRUPTION] = 0;
	flags[kFLAGS.AIKO_AFFECTION] = 50;
	flags[kFLAGS.AIKO_QUEST] = 1;
	menu();
	addButton(0, "Yes", firstDeepWoodEncounterYes);
	addButton(1, "No", firstDeepWoodEncounterNo);
}
public function firstDeepWoodEncounterYes():void {
	clearOutput();
	outputText("You ask her if that was a threat, stowing the ball and readying your [weapon]. You’re certain that she’s trying to trick you somehow, and you won’t stand for it!\n\n");
	outputText("\"<i>Heheh... well... you know, maybe I was hasty. Perhaps we could strike a deal? What do you say? My Ball in exchange for anything your heart desires. Riches, power... I could help take the edge off things, if you know what I mean,</i>\" she says coyly, wiggling her hips seductively.\n\n");
	outputText("Whatever this ball is for, it seems like it is very important to her. Maybe you should reconsider-you could probably get her to do anything... but it might be a trick. What will you ask for?\n\n");
	menu();
	addButton(0, "Riches", firstDeepWoodEncounterRiches);
	addButton(1, "Power", firstDeepWoodEncounterPower);
	addButton(2, "TouchFluffyTail", firstDeepWoodEncounterTouchFluffyTail);
	//addButton(3, "Nothing", firstDeepWoodEncounterNothing);
	//addButton(4, "Sex", firstDeepWoodEncounterSex);
	//addButton(5, "Fight", firstDeepWoodEncounterFight);
}
public function firstDeepWoodEncounterNo():void {
	clearOutput();
	outputText("You wonder if you should take that as a threat for a moment, until Aiko lets out a snorting laugh. \"<i>Nah, I’m just kidding. You seem legit. But seriously, gimme back my Ball.</i>\"\n\n");
	outputText("You give her a hesitant grin, laughing along awkwardly. Just your luck—even if she isn’t overly aggressive, you can’t help but feel that Aiko has a few screws loose upstairs. Then again, perhaps this is normal for her kind?\n\n");
	outputText("\"<i>Okay, listen up, I’ll tell you what. I like you, so I’m willing to make a deal with you. Besides, it was fun messing with you, so... What’ll it take to get my Ball back, hm? Riches? Power? Maybe a little... release?</i>\" she says coyly, turning around and slapping her own plump, juicy rear playfully, revealing two spiral-shaped tattoos on her buttocks.\n\n");
	outputText("Whatever this ball is for, it seems like it is very important to her. You could probably get her to do just about anything… What will you ask for?\n\n");
	menu();
	addButton(0, "Riches", firstDeepWoodEncounterRiches);
	addButton(1, "Power", firstDeepWoodEncounterPower);
	addButton(2, "TouchFluffyTail", firstDeepWoodEncounterTouchFluffyTail);
	//addButton(3, "Nothing", firstDeepWoodEncounterNothing);
	//addButton(4, "Sex", firstDeepWoodEncounterSex);
}
public function firstDeepWoodEncounterRiches():void {
	clearOutput();
	outputText("You consider her offer for a moment, and then tell her that you could always use a few extra gems.\n\n");
	outputText("\"<i>Avaricious little scamp, aren’t you?</i>\" Aiko teases, smirking. \"<i>Alright, come with me,</i>\" she says, beckoning you to follow her to the base of the tree. \"<i>Wait right here,</i>\" she tells you, before adding, \"<i>And no peeking!</i>\"\n\n");
	outputText("She gestures for you to turn around, and you consider protesting, but obey with a shrug when she shoots you a stern glance. You turn around when you hear her coughing, and find her standing there with a small wooden chest in her hand, waving her other hand to clear away a cloud of smoke that is rising from the chest.\n\n");
	outputText("Aiko, with a grin, thrusts the chest into your hands, bouncing girlishly. At her behest, you open it, finding it filled to the brim with gems! Pleased with your transaction, you honor your end of the bargain, tossing the ball to her and bidding her farewell.\n\n");
	outputText("\"<i>Oh, don’t even mention it. My pleasure entirely,</i>\" she says with a wink, and you can’t help but feel like she knows something you don’t. Shrugging it off, you make your way back to camp, your new bounty in tow...\n\n");
	outputText("...Upon your return to camp, you set the chest down to count your newly-acquired riches, hearing a hollow thump! Wait, that’s not right. Wasn’t this chest a lot heavier just a little while ago? You open the chest hastily, and find that the contents have turned to a pile of leaves!\n\n");
	outputText("You’ve been had! It appears Aiko has gotten the better of you...\n\n");
	if (player.hasKeyItem("Camp - Chest") < 0) {
		outputText("Well, maybe you could use the chest for storage...\n\n");
		for (var i:int = 0; i < 6; i++) {
			inventory.createStorage();
		}
		player.createKeyItem("Camp - Chest", 0, 0, 0, 0);
	}
	else outputText("Before your eyes, the chest transforms into a white piece of paper with a cartoonish face drawn on it, blowing you the raspberry.\n\n");
	aikoAffection(1);
	doNext(camp.returnToCampUseOneHour);
}
public function firstDeepWoodEncounterPower():void {
	clearOutput();
	outputText("After a little thought, you tell her that a little more power could go a long way toward helping you on your quest.\n\n");
	outputText("\"<i>Teehee... Alright " + player.mf("Mr", "Mrs") + ". Hero, your wish is my command,</i>\" Aiko teases, grinning mischievously. She thinks for a minute and then appears to be struck with inspiration, her face lighting up as she runs off, shouting to you, \"<i>Stay right here! Don’t move!</i>\"\n\n");
	outputText("You wait patiently, wondering just what she is up to. A minute passes, and Aiko returns with a bundle in her arms, holding it aloft as she runs toward you. \"<i>Check it out! I wrapped it and everything! C’mon, open it!</i>\" she shouts, handing you the long bundle, wrapped in a purple cloth and tied with gold cord.\n\n");
	outputText("You blink, a little taken aback by her enthusiasm, and begin to unwrap the bundle. As you pull the purple cloth away, you find that it contains a shining golden sword with runic symbols engraved in the blade.\n\n");
	outputText("\"<i>It’s a sword! I found it in the woods!</i>\" she exclaims, grinning widely. \"<i>It’s magical though, check out the blade!</i>\"\n\n");
	outputText("When you take the sword’s hilt into your hands, you feel the blade hum with magical energy. The engravings begin to glow, and the sword suddenly bursts into flames!\n\n");
	outputText("Once you figure out how to power the sword down, you wrap it back up and thank Aiko. Pleased with your transaction, you honor your end of the bargain, tossing the ball back to her and bidding her farewell.\n\n");
	outputText("\"<i>Oh, don’t even mention it. My pleasure entirely,</i>\" she says with a wink, and you can’t help but feel like she knows something you don’t. Shrugging it off, you make your way back to camp, your new bounty in tow...\n\n");
	outputText("...Upon your return to camp, you sit down to take a closer look at your new sword. You hastily unwrap the bundle, only to find that it has been replaced with a plain Lead Pipe! Attached to it is a small piece of paper with a cartoonish face drawn on it, blowing you the raspberry.\n\n");
	outputText("You’ve been had! It appears Aiko has gotten the better of you... Well, if you swing it hard enough, the pipe may still do some damage...\n\n");
	aikoAffection(1);
	inventory.takeItem(weapons.PIPE, camp.returnToCampUseOneHour);
}
public function firstDeepWoodEncounterTouchFluffyTail():void {
	clearOutput();
	outputText("\"<i>Wh-what?!</i>\" Aiko shouts, a deep crimson blush on her cheeks.\n\n");
	outputText("You calmly repeat that you’d like to pet her fluffy tails, which only seems to deepen her blush.\n\n");
	outputText("\"<i>O-oh... th-that’s what I thought you said,</i>\" she says, trying to hide her blush with her hands, looking ");
	if (player.tallness > 60) outputText("up");
	else outputText("down");
	outputText(" at you cutely between her fingers. \"<i>W-well... I suppose... you could touch my tails... for just a little while...</i>\"\n\n");
	outputText("You aren’t sure what about your request prompted such a drastic change in behavior from her, but the way she suddenly began acting so shy is quite cute. Aiko meekly strolls over to you, and politely instructs you to sit down, fidgeting apprehensively. You obey her request, lowering yourself down to the ground, and Aiko gently turns around, her many fluffy tails stroking along your body as she does so. ");
	outputText("She reaches back and pulls the bundle aside, which gives you a perfect line of sight to her gorgeous, voluptuous ass and the bright red spiral tattoos that adorn it, just before she daintily drops herself ");
	if (player.tallness < 48 || !player.isBiped) outputText("onto the ground next to you");
	else outputText("into your lap");
	outputText(".\n\n\"<i>O-okay... please be gentle... it’s my first time,</i>\" she says, drawing the soft and bushy cluster of tails into her lap where you can reach them easily.\n\n");
	outputText("You have no idea what she’s talking about, but who cares, fluffy tails! Your hands move down to gently caress them, and a giddy grin crosses your lips as you begin to stroke each tail, feeling the luxurious softness tickle your palms as your fingers slide along the silvery fur. In your oblivious excitement, you barely register as Aiko’s head thuds heavily against your ");
	if (player.tallness < 60 || !player.isBiped) outputText("shoulder");
	else outputText("chest");
	outputText(". You are entirely engrossed in how incredibly soft these tails are, gently sliding your hand from base to tip over and over again, even occasionally lifting one up to rub your cheek against it.\n\n");
	outputText("When you finally take a moment to look at Aiko, you are shocked to find her practically comatose, her eyes rolled back in pleasure and a thin trail of spittle dripping down her chin. \"<i>nn... don’t stop...</i>\" she whispers, gently sucking the spittle back into her mouth, her fingers softly clawing at your chest.\n\n");
	outputText("Understanding dawns on you now as you take her tails into your hands once more, running your fingertips through the fur and grinning a little. It seems Aiko is enjoying this a lot more than you would have thought! You can hardly complain, cradling the cute fox girl and her many tails in your arms and stroking them as you laugh lightly, one hand moving to gently scratch her ears.\n\n");
	outputText("You continue to pet her for the better part of an hour, feeling as if the weight of this world’s corruption is being lifted from your shoulders. Finally, sadly, you tell her that you need to return and check up on your camp. Honoring your end of the bargain, you place her ball back into her hands and begin on your way.\n\n");
	outputText("\"<i>...come back soon...</i>\"\n\n");
	aikoAffection(15);
	dynStats("cor", -5, "lust", (10 + rand (10)));
	doNext(camp.returnToCampUseOneHour);
}
public function firstDeepWoodEncounterNothing():void {
	clearOutput();
	outputText("You don’t know if it’s because you’re feeling charitable, or because of some nagging suspicion, but after some consideration, you decide to return her ball without asking for anything in return. You hand it to her and tell her as much, watching her face light up with surprise as she reaches out to retrieve it from you.\n\n");
	outputText("\"<i>You’re... serious? You’re just giving it to me?</i>\" she says, taking it from you softly and stowing it in her cleavage. \"<i>I... don’t know what to say. I mean, you have NO idea how grateful I am, but... honestly, I’m shocked.</i>\"\n\n");
	outputText("She turns to walk away, but stops and puts her index fingers together on her lips, seeming to be deep in thought for a moment.\n\n");
	outputText("\"<i>Look... I don’t normally do this, but... you seem nice, and now I feel a little conflicted.</i>\"\n\n");
	outputText("Strolling up to you, she grabs the back of your head and pulls you into a kiss before you can react. As she exhales into your mouth, you can taste wintergreen cascading over your tongue. When she pulls away, she gives you a smirk, and a little puff of blue flame escapes your lips.\n\n");
	outputText("\"<i>Don’t get any ideas, now... I only did that to repay my debt, you hear me?</i>\"\n\n");
	outputText("Despite her claims, she walks away with a clear smile on her face, her seven tails swishing to and fro’ as she disappears into the woods.\n\n");
	outputText("As you turn back toward camp, you still have the faint taste of wintergreen on your tongue, and you can’t help but feel a renewed vigor toward your quest.\n\n");
	outputText("Aiko’s fiery kiss has left your body and mind feeling invigorated!\n\n");
	aikoAffection(5);
	dynStats("cor", -5, "lust", (10 + rand (10)));
	switch(rand(5)) {
		case 0:
			outputText("You feel like you could arm-wrestle a minotaur, your muscles rippling with new reserves of strength!\n\n");
			dynStats("str", 3);
			break;
		case 1:
			outputText("You feel like you could brush off a blow from even the strongest demon, your body feeling more resilient!\n\n");
			dynStats("tou", 3);
			break;
		case 2:
			outputText("You feel like you could outrun a centaur, as you fill with newfound energy!\n\n");
			dynStats("spe", 3);
			break;
		case 3:
			outputText("You feel like you could memorize an entire library’s worth of books, your mind becoming noticeably sharper!\n\n");
			dynStats("inte", 3);
			break;
		case 4:
			outputText("You feel like you have done a trip you never remembered of before, you have become more experienced!\n\n");
			dynStats("wis", 3);
			break;
		default:
			outputText("You feel like you have done a trip you never remembered of before, you have become more experienced!\n\n");
			dynStats("wis", 3);
	}
	doNext(camp.returnToCampUseOneHour);
}
public function firstDeepWoodEncounterSex():void {
	clearOutput();
	outputText("\"<i>I guess my grounds below to you now hunter.</i>\"\n\n");
	outputText("The sheep girl approach your defeated form and knock you out with a rock.\n\n");
	doNext(camp.returnToCampUseOneHour);
}
public function firstDeepWoodEncounterFight():void {
	clearOutput();
	outputText("\"<i>I guess my grounds below to you now hunter.</i>\"\n\n");
	outputText("The sheep girl approach your defeated form and knock you out with a rock.\n\n");
	startCombat(new Aiko());
}

public function secondDeepWoodEncounter():void {
	clearOutput();
	outputText("The sheep girl approach your defeated form and knock you out with a rock.\n\n");
}

public function thirdDeepWoodEncounter():void {
	clearOutput();
	outputText("The sheep girl approach your defeated form and knock you out with a rock.\n\n");
}

public function fourthAndOnDeepWoodEncounter():void {
	clearOutput();
	outputText("The sheep girl approach your defeated form and knock you out with a rock.\n\n");
}/*
Corruption & Affection
Aiko has two scales that determine her demeanor; Corruption and Affection. Corruption is from 0-100, with a starting value of 0, “Pure”. Affection ranges from 0-100, with a starting value of 50, as “Neutral”.
Player interactions with her will affect these scales, and getting them to the appropriate levels is necessary in order to advance Aiko’s mini quest line. Whenever a choice has an effect on these scales, this will be denoted in colored text to the right of the header, as follows:

[Choice]    X Affection    X/Y Corruption

Corruption increases listed in parentheses (+X) will only be applied when the PC’s corruption is HIGHER than Aiko’s. All other +/- values are applied regardless of the PC’s corruption.

For corruption increases listed as +X/Y Corruption, use the X value normally, and the Y value if the PC possesses the Sadist perk.

The meaning of the Affection scale’s value differs depending on her Corruption value. When pure, 0 reflects a severe dislike for the PC on Aiko’s part, while 100 indicates that she is very enamored with the player.
At Corruption 50 or higher, Aiko develops a severe sadomasochistic streak; reflecting this, Affection values of 0 now represent positive (if somewhat unhealthy) feelings toward the PC, and at 100, she finds the player to be a boring goody two-shoes.
*/
	}
}