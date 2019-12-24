/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.display.SpriteDb;
	import classes.Scenes.UniqueSexScenes;
	
	public class ElectraFollower extends NPCAwareContent
	{
		public var uniquuuesexscene:UniqueSexScenes = new UniqueSexScenes();
		
		public function ElectraFollower() 
		{}
		
//flag ELECTRA_TALKED_ABOUT_HER]: 0,1 - not know her name, 3 - know her name, 2/4+ - male sex scene variant for knowing or not what pour it all out mean ^^

public function electraAffection(changes:Number = 0):Number
{
	flags[kFLAGS.ELECTRA_AFFECTION] += changes;
	if (flags[kFLAGS.ELECTRA_AFFECTION] < 0) flags[kFLAGS.ELECTRA_AFFECTION] = 0;
	if (flags[kFLAGS.ELECTRA_AFFECTION] > 100) flags[kFLAGS.ELECTRA_AFFECTION] = 100;
	return flags[kFLAGS.ELECTRA_AFFECTION];
}

public function firstEnc():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("As you wander the mountain you hear the sound of echoing thunder though this time around it clearly didn’t come from the sky. You see multiple imps and even a minotaur run away from the spot where the sound was heard. As you go there to see what’s going on you come upon a single girl with animal morph features. She's panting on the ground with a hand under her dress.\n\n");
	outputText("\"<i>Ahhhh someone... someone help me get rid of this maddening desire... rape me... fuck me, I don’t care how you do it. Gah why are they all fleeing!...come back! Come back so I can get rid of my itches... Come back so we can FUCK!</i>\"\n\n");
	outputText("She suddenly realizes you are there and her eyes glimmer with a hint of barely contained madness. She stands up, still playing with her pussy, and eyes you up with a manic smile on her face as electricity starts to dance in the air around her.\n\n");
	outputText("\"<i>You will be my lightning rod!!!!</i>\"");
	outputText("\n\nYou are under attack by a Raiju!");
	if (flags[kFLAGS.CODEX_ENTRY_RAIJU] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_RAIJU] = 1;
		outputText("\n\n<b>New codex entry unlocked: Raiju!</b>")
	}
	startCombat(new Electra());
	doNext(playerMenu);
}
public function repeatMountainEnc():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("As you wander the mountain you hear the sound of echoing thunder though this time around it clearly didn’t come from the sky. You see multiple imps and even a minotaur run away from the spot where the sound was heard. ");
	repeatElectraEnc();
}
public function repeatPlainsEnc():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("As you wander the plains you hear the sound of echoing thunder though this time around it clearly didn’t come from the sky. You see multiple imps and even a satyr run away from the spot where the sound was heard. ");
	repeatElectraEnc();	
}
public function repeatDeepwoodsEnc():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("As you wander the woods you hear the sound of echoing thunder though this time around it clearly didn’t come from the sky. You see multiple imps and even a satyr run away from the spot where the sound was heard. ");
	repeatElectraEnc();
}
public function repeatElectraEnc():void {
	outputText("As you go there to see what’s going on you come upon ");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
	else outputText("the Raiju girl");
	outputText(" again. She's panting on the ground with a hand under her dress and masturbating like there is no tomorrow.\n\n");
	outputText("\"<i>Ahhhh someone... someone help me get rid of this maddening desire... rape me... fuck me I don’t care how you do it. Gah why are they all fleeing!...come back! Come back so I can get rid of my itches... Come back so we can FUCK!</i>\"\n\n");
	if (player.raijuScore() >= 10) repeatEncAsRaijuPC();
	else {
		outputText("Shit! If she sees you now she will definitely attack but just as you are about to leave she suddenly realizes you are there and her eyes glimmer with a hint of barely contained madness. She stands up, still playing with her pussy, and eyes you up with a manic smile on her face as electricity starts to dance in the air around her.\n\n");
		outputText("\"<i>Just who I need for relief!  Now stay still, I will make it short!!!</i>\"");
		outputText("\n\nYou are under attack by ");
		if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
		else outputText("a Raiju");
		outputText(" again!");
		startCombat(new Electra());
		doNext(playerMenu);
	}
}
public function repeatEncAsRaijuPC():void {
	outputText("Not having made any effort to hide from her she swiftly takes notice of your presence. She stands up, still playing with her pussy, and eyes you up for a second before sighing.\n\n");
	outputText("\"<i>I just can’t find anyone to fuck the voltage out of me. And of course the only person that’d be willing to make out is another Raiju. Ain’t looking like either of us will get a discharge today.</i>\"");
	menu();
	addButton(1, "Relieve her", repeatEncAsRaijuPCRelieveHer);
	addButton(3, "No thanks", repeatEncAsRaijuPCNoThanks);
}
public function repeatEncAsRaijuPCNoThanks():void {
	outputText("Can’t get her charge out? Too bad because you have enough of yours to manage as it is. You bid her good luck then head back to camp.\n\n");
	doNext(camp.returnToCampUseOneHour);
}
public function repeatEncAsRaijuPCRelieveHer():void {
	outputText("You don’t exactly find her bad on the eyes for a kinswoman so why not help her? You offer to draw out her discharge for her. The raiju lights up, teary eyed at your offer and very appreciative.\n\n");
	outputText("\"<i>Tha...Thank you so much, I won’t forget this!</i>\"\n\n");
	ElectraSeXChargeUp();
}

public function ElectraRecruiting():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You run into Electra again this time around though she ain't chasing after the locals for sex, instead she walks straight up to you, looking somewhat troubled as if she desperately needs to say something.\n\n");
	outputText("\"<i>Hi, I have been looking for you");
	if (player.raijuScore() >= 10) outputText(""+player.mf("kinsman","kinswoman")+"");
	outputText(". I'm kind of sorry for coming up to you like that all the time. Don't worry, I already discharged myself, this isn't what I wanted to see you for. See uh as it is I've been considering my position and yours, you've been helping me out so often by now I've become dependant on your touch. ");
	outputText("When I see you I can feel the surge running down my spine, the fondness of every attention you gave me imprinted in my mind and I… can I have your name please?</i>\"\n\n");
	outputText("You tell her your name and that you are the Ingnam champion sent to Mareth to defeat the demons.\n\n");
	outputText("\"<i>Ah… and a nice person too. Well I can't delay it anymore, I need to spell it out, I'm in love with you. I'd like to ask you but would you be okay with a girlfriend or a new girlfriend for that matter? I'm sure someone as nice as you must've got a harem by now.</i>\"\n\n");
	outputText("Well that declaration sure fell down like thunder. What would you answer her?\n\n");
	menu();
	addButton(1, "Sure", ElectraRecruitingSure);
	addButton(3, "Nah", ElectraRecruitingNah);
}
public function ElectraRecruitingSure():void {
	outputText("You help up Electra to your camp. Ironically or perhaps luckily enemies stay clear from you during the travel, Electra acting as a natural repellent. You finally arrive at camp, the weasel insisting on wanting to see everything"+(camp.hasCompanions() ? " and meeting everyone" : "")+".\n\n");
	if (player.hasStatusEffect(StatusEffects.PureCampJojo)) {
		outputText("Jojo notices her quite fast, waving a warm welcome.\n\n");
		outputText("\"<i>Hey it's that Raiju from the mountain, how did the meditation attempt go?</i>\"\n\n");
		outputText("Electra sighs, embarrassed.\n\n");
		outputText("\"<i>Poorly, I did try to meditate but by the time I finally managed to stand still I was too charged up to think straight anymore. Curse my hyperactivity.</i>\"\n\n");
		outputText("This doesn't seem to worry Jojo that much.\n\n");
		outputText("\"<i>Spend some time with me on the side and we'll find a way to teach you meditation.</i>\"\n\n");
	}
	if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) {
		outputText("Amily notices Electra from the corner of her eyes and slowly begins to sneak away from the camp toward the closest hiding place. Electra isn't letting her go without formal talks however.\n\n");
		outputText("\"<i>Hey you! Where are you going like that, it’s not like I'm about to zap you.</i>\"\n\n");
		outputText("Amily aware that sneaking out is no longer an option addresses the problem directly.\n\n");
		outputText("\"<i>Hey [name] I know you are kind and all but this is a raiju. She's basically a ticking bomb waiting to explode in lust inducing thunderbolts. I seriously hope you intend to take full charge of her, I don't fancy myself getting shocked and turned into a wet mess.</i>\"\n\n");
		outputText("You promise Amily you will keep Electra’s needs in check.\n\n");
	}
	if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && !player.hasStatusEffect(StatusEffects.EtnaOff)) {
		outputText("Etna flies over from her current location to meet you both.\n\n");
		outputText("\"<i>Hey if it isn't you thunder girl, ain't seen you around ever since you decided to make the other side of the mountains your territory. Geeze you scared a lot of the minotaurs down there back to mine, not that I complain about it. It's just a wild guess but did [name] tame you into coming here?</i>\"\n\n");
		outputText("Electra responds with middle annoyance.\n\n");
		outputText("\"<i>Nothing about taming here Etna, I'm not some wild beast you can hold on a leash. [name] just happened to be on my path when I needed "+player.mf("him","her")+" the most, willing to help of "+player.mf("his","her")+" own volition.</i>\"\n\n");
	}
	outputText("(<b>Electra has been added to the Lovers menu!</b>)\n\n");
	flags[kFLAGS.ELECTRA_FOLLOWER] = 2;
	flags[kFLAGS.ELECTRA_LVL_UP] = 1;
	flags[kFLAGS.ELECTRA_DEFEATS_COUNTER] = 0;
	flags[kFLAGS.ELECTRA_DAILY_STORM_JEWEL] = 0;
	doNext(playerMenu);
}
public function ElectraRecruitingNah():void {
	outputText("You apologizes to her but for now you aren't exactly ready to make space for someone in your life. Electra nods, she's on the verge of tears but accepts your decision to turn her down, walking away.\n\n");
	flags[kFLAGS.ELECTRA_FOLLOWER] = 1;
	electraAffection(-100);
	doNext(camp.returnToCampUseOneHour);
}
public function ElectraRecruitingAgain():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You run into Electra again this time around though she ain't chasing after the locals for sex, instead she walks straight up to you, you know what she’s going to say before she says it.\n\n");
	outputText("\"<i>[name] please, I hope you would reconsider! It’s very clear to me that we are meant to be together as a couple! Why else would you keep helping me up like that, my heart beat with yours. I really want it so badly for you to say that you will take me with you this time around.</i>\"\n\n");
	outputText("Guess you are at that crossroad again, what is your choice?\n\n");
	menu();
	addButton(1, "Sure", ElectraRecruitingSure);
	addButton(3, "Nah", ElectraRecruitingNah);
}

public function ElectraCampMainMenu():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You almost feel the static in the air as you head up to Electra who perks up at your presence.\n\n");
	outputText("\"<i>Hey [name] good afternoon! I have been generating a lot of current lately, it's always difficult to keep it under control but since you"+(camp.hasCompanions() ? " and your friends...</i>\" She pauses licking her lips naughtily at the thought. This should be an alarm to you but so far no one complained. \"<i>..." : "")+"");
	outputText("are here I can keep a lust free lucidity all the time, it is supremely agreeable.");
	outputText("" + (player.hasStatusEffect(StatusEffects.CampRathazul) ? " The old rat regularly come over for plasma sample, don't know what he does with it though. Lightning in a bottle maybe? You should check out whatever he's been doing with my lightning, it might be worth your while." : "") + "");
	outputText(" Anyway you came over to talk or for shock therapy?</i>\"\n\n");
	outputText("The ambient energy in the air almost doubles as she says that. Who can say whether she is aroused or not right now.");
	menu();
	addButton(0, "Appearance", electraAppearance).hint("Examine Electra's detailed appearance.");
	addButton(1, "Talk", electraTalk).hint("Ask Electra about something.");
	addButton(2, "Sex", electraSex).hint("Have some sex with Electra");
	if (flags[kFLAGS.ELECTRA_DAILY_STORM_JEWEL] > 0) addButtonDisabled(3, "Req. Jewel", "You already asked her for a jewel today.");
	else addButton(3, "Req. jewel", electraStromJewel).hint("Ask Electra for a storm jewel.");
	if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) addButton(4, "Spar", electraSpar).hint("Ask Electra for a mock battle with sex for the winner.");/*
	if (player.hasPerk(PerkLib.BasicLeadership)) {
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "") addButton(5, "Team", etnaHenchmanOption).hint("Ask Etna to join you in adventures outside camp.");
		else if (flags[kFLAGS.PLAYER_COMPANION_1] == "Etna") addButton(5, "Team", etnaHenchmanOption).hint("Ask Etna to stay in camp.");
		else addButtonDisabled(5, "Team", "You already have other henchman accompany you. Ask him/her to stay at camp before you talk with Etna about accompaning you.");
	}*/
	addButton(14, "Back", camp.campLoversMenu);
}

public function electraAppearance():void {
	clearOutput();
	outputText("Electra is a raiju. Her hair is long, wild and unkempt, the strands running in front of her face twisting out and glowing at the tip like actual lightning bolts. Her green slitted eyes are similar in outlook to a weasel, always starring with barely contained lust. Her mouth look human though underneath those lips hide ");
	outputText("two teeth sharper than the others. Her furry weasel ears are well protected from extreme sound else she'd be constantly putting her hand over them when discharging thunder.\n\nElectra’s arms are human although her nails are sharp as claws and regularly flashing with telltale sign of electric current. ");
	outputText("Speaking of those, you know for a fact that when she’s not looking at you she regularly sneaks in a claw to masturbate not that this does her any good as raiju are unable to achieve true release on their own. Her fur alters between purple, black, blue and white, the color of lightning. Her legs unlike her arms ");
	outputText("have fur up to the middle of her thighs. Her neck is hidden by a fluffy collar of black and white fur, with lightning reliefs. Up her shapely ass she has a fluffy wild tail which puffs up when she becomes overcharged. It is spiky in appearance the telltale sign of current running through as her fur rises up.\n\n");
	outputText("Electra is well endowed with a pair of E cup breasts well contained within her kimono."+(player.inte > 50 ? " You idly ponder if she stores electricity in there like opposed polarity magnets." : "")+"\n\n");
	outputText("Her pussy is unsurprisingly trained albeith still tight as she tends to plug with males when in need to discharge. It's always drooling in anticipation of sex, it’s just a matter of how horny she is at the time.");
	menu();
	addButton(14, "Back", ElectraCampMainMenu);
}

public function electraTalk():void {
	clearOutput();
	outputText("Electra shrugs as you ask to talk.\n\n");
	outputText("\"<i>Yeah sure I'm fine with a chat, what's the topic?</i>\"\n\n");
	menu();
	addButton(0, "Raiju", electraTalkRaiju);
	addButton(1, "Locals", electraTalkLocals);
	addButton(2, "Masturbating?", electraTalkMasturbating);
	addButton(14, "Back", ElectraCampMainMenu);
}
public function electraTalkRaiju():void {
	clearOutput();
	outputText("So seriously what kind of species she hails from.\n\n");
	outputText("\"<i>I'm a raiju?</i>\"\n\n");
	outputText("No as in is she a weasel, a dog, a cat, some other morph you've never heard about.\n\n");
	outputText("\"<i>As I said a raiju, we are our own species really, Sleipnir our patron god created us as is. And before you ask then yes being horny was also part of our original self. Hell if I know, maybe the sky god just thought it'd be funny or he did this while jerking his massive horsecock and the resulting orgasm created us. ");
	outputText("The only confirmed fact is we were born of thunders and clouds and that like clouds when we are oversaturated we turn violent.</i>\"\n\n");
	doNext(electraTalk);
	cheatTime(1/4);
}
public function electraTalkLocals():void {
	clearOutput();
	outputText("So why are all the locals fleeing for her anyway, you thought everyone on Mareth was drunk on sex?\n\n");
	outputText("\"<i>Sure they’re all drunk on sex but no one enjoys being stuck in the pre orgasm phase until they find a cunt to fuck or get their ass fucked by someone else let alone being on the receiving end. As a result I'm forced into chasing those so called sexual apex predators for a fuck.</i>\"\n\n");
	outputText("Come to think of it that explain why her passage causes mass exodus of minotaurs and imps in the region.\n\n");
	doNext(electraTalk);
	cheatTime(1/4);
}
public function electraTalkMasturbating():void {
	clearOutput();
	outputText("You regularly catches her in the act of masturbating is it because she just can't stop or is it because she likes it too much. Last you checked raiju can't cum on their own. Electra sighs in discouragement before responding.\n\n");
	outputText("\"<i>Ugh I should be more discreet about that but yea it's really because I can't help it. My body unconsciously seeks out its next orgasm so my hands machinaly reaches for my privates when I'm not concentrating on keeping it away. It's kind of embarrassing. ");
	outputText("Beside it only makes the next time I frenzy that much closer. Maybe its like you say and I'm just a crazy nympho.</i>\"\n\n");
	outputText("You never said she was crazy. Just that she needs help, and you're more than happy to provide it.\n\n");
	doNext(electraTalk);
	cheatTime(1/4);
}

public function electraStromJewel():void {
	clearOutput();
	outputText("You ask if Electra could produce a storm jewel for you. She concentrates and focuses electricity into her palm, making one near instantaneously.\n\n");
	outputText("\"<i>Sure have one but be careful, they are highly unstable.</i>\"\n\n");
	flags[kFLAGS.ELECTRA_DAILY_STORM_JEWEL]++;
	inventory.takeItem(consumables.VOLTTOP, ElectraCampMainMenu);
	cheatTime(1/4);
}

public function electraSpar():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("Electra chuckle as you mention you would like to spar with her, heading for the ring.\n\n");
	outputText("\"<i>Really? Well you know how it works right? If I win I get to dump it all out in you.</i>\"\n\n");
	startCombat(new Electra());
	doNext(playerMenu);
}

//outputText("\n\n");
//outputText("\"<i></i>\"\n\n");

public function electraSex():void {
	clearOutput();
	outputText("Electra is smiling wide with that weaselly, naughty grin of hers.\n\n");
	outputText("\"<i>Oh my… so how do you plan to take me?"+((player.raijuScore() < 10 || player.thunderbirdScore() < 12) ? " Keep in mind any bodily contact will result in a discharge, I can't help it." : "")+"</i>\"");
	menu();
	if (player.raijuScore() >= 10) {
		addButton(0, "Charge up", ElectraSeXChargeUp);
		addButton(1, "Volt Transfer", ElectraVoltTransfer);
	}
	else {
		addButtonDisabled(0, "Charge up", "Need to be Raiju for this scene");
		addButtonDisabled(1, "Volt Transfer", "Need to be Raiju for this scene");
	}
	addButton(2, "Headpat", ElectraSeXHeadpat);
	addButton(3, "Lets just fuck", ElectraSeXYes);
	//if (player.tailType == 28)  addButton(4, "Share a Drink", etnaShareDrink);
	addButton(14, "Back", ElectraCampMainMenu);
}

public function ElectraSexPlayer():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You fall to the ground, unable to continue fighting. The girl however seems to be really happy about this.\n\n");
	outputText("\"<i>FINALLY!!!.. FUCKING FINALLY!!! I found someone to discharge my electricity! I felt like I was going to go mad!</i>\"\n\n");
	outputText("For all you care she is already mad. The girl moves to you, smiling wide with a lust crazed expression and you can feel electricity gather around her as she touches you and transfers it all into your body, her eyes rolling and her pussy gushing as she finally achieves the true release she so craved.\n\n");
	outputText("You on the other hand fare poorly. She just zapped you with several orgasms worth of accumulated desire and your body is wracked by pleasure as the static makes you cum over and over again in rapid succession. The ground under you swiftly turns into a pool made out of your own fluid as you see white from your overcharged genitals");
	if (player.hasBreasts()) outputText(" and milk gushing nipples");
	outputText(", the electricity setting all your pleasure nerves into overdrive as your sensitivity skyrocket. You barely see her taking her leave as you faint from the pleasure overdose.\n\n");
	outputText("You wake up in a pool of your own fluids. After such mind wracking pleasure, your entire body feels sensitive and aches to be touched from the slowly receding voltage. Something however tells you that indulging yourself would be a bad idea.\n\n");
	if (player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
		player.removeStatusEffect(StatusEffects.RaijuLightningStatus);
		player.createStatusEffect(StatusEffects.RaijuLightningStatus,25,0,0,0);
	}
	else player.createStatusEffect(StatusEffects.RaijuLightningStatus,25,0,0,0);
	electraAffection(5);
	player.orgasm();
	cleanupAfterCombat();
	return;
}
public function PlayerSexElectraPostSpar():void {
	/*if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
		if (flags[kFLAGS.ELECTRA_DEFEATS_COUNTER] >= 1) flags[kFLAGS.ELECTRA_DEFEATS_COUNTER]++;
		else flags[kFLAGS.ELECTRA_DEFEATS_COUNTER] = 1;
		if (flags[kFLAGS.ELECTRA_DEFEATS_COUNTER] == 5 && flags[kFLAGS.ELECTRA_LVL_UP] == 1) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 3, 30);
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, 0, 30, 0);
			flags[kFLAGS.ELECTRA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ELECTRA_LVL_UP] = 2;
		}
		if (flags[kFLAGS.ELECTRA_DEFEATS_COUNTER] == 6 && flags[kFLAGS.ELECTRA_LVL_UP] == 2) {
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 3, 36);
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, 0, 36, 0);
			flags[kFLAGS.ELECTRA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ELECTRA_LVL_UP] = 3;
		}
	}*/
	PlayerSexElectra();
}
public function PlayerSexElectra():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) {
		outputText("Electra falls to the ground defeated again.\n\n");
		outputText("\"<i>Gosh you sure do fight well... Can we get to the fucking already?</i>\"\n\n");
	}
	else if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] == 1 || flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] == 2) {
		outputText("The raiju falls to the ground defeated again.\n\n");
		outputText("\"<i>Ah, you’re quite something... My name is Electra by the way. Nice to meet you again, so yea... Can we get to the fucking already?</i>\"\n\n");
		flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] = 3;
	}
	else {
		outputText("As you look over your defeated opponent you swiftly notice that she’s panting with desire just from looking at you.\n\n");
		outputText("\"<i>Please FUCK ME!... I don’t care how you do it, just fuck me so I can be free of my lust! It’s been days...</i>\"\n\n");
		outputText("There's something fishy about this, but do you fuck her anyways?");
		flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] = 1;
	}
	menu();
	if (player.lust >= 33) addButton(0, "Yea Sure", ElectraSeXYes);
	addButton(1, "No Way", ElectraSeXNo);
	addButton(2, "Headpat", ElectraSeXHeadpat);
	if (player.pcCanUseUniqueSexScene()) addButton(13, "U. Sex Scenes", uniquuuesexscene.pcUniqueSexScenesChoiceMenu).hint("Other non typical sex scenes.");
}
public function ElectraSeXYes():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
	else outputText("The raiju");
	outputText(" surprises you by jumping on top of you before you can even finish your sentence.\n\n");
	outputText("\"<i>Let's not waste any time then!</i>\"");
	outputText("She swiftly takes a hold of your clothes and starts methodically stripping you. If you weren't any wiser you would think she is actually turning the tables on you but actually she is just so excited to finally get laid that she no longer holds any of her inhibitions in.\n\n");
	if (player.hasCock()) ElectraSeXYesM();
	else ElectraSeXYesF();
}
public function ElectraSeXYesM():void {
	outputText("\"<i>Ahhh gimme that lighting rod, please put it in!</i>\"");
	outputText("She begins flaunting her pussy like a target. Well if she wants it that badly you won’t be the one to disappoint her. You grab her hips and slowly but surely pull her down on your [cock]. The girl screams in joy as you finally hit the bottom of her pussy and start rocking up and down without you having to ask anything. There's something odd about this.\n\n");
	outputText("\"<i>Ahhhn we're plugged! We're plugged! I’m going to pour it all out!!!!</i>\"");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] == 2 || flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 4) outputText("Well here you go again... You get ready to get jolted as");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] == 1 || flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] == 3) {
		outputText("Wait what?! Before you can ask what she means by that");
		flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER]++;
	}
	outputText(" you hear a sound not unlike that of electricity in live wires a few second before your entire body is struck by ");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
	else outputText("the raiju");
	outputText("’s lightning. The voltage is flowing out of her pussy straight to your dick! You moan as the current sets every one of your pleasure nerves into overdrive, causing you to reach orgasm almost instantly if not several times over and pump the raiju with your cum. The girl seems lost in the sensations of her pussy, tongue out and eyes rolling, as she gushes around your twitching cock. ");
	outputText("This rapid fire set of orgasms lasts for a fair minute before the both of you fall on each other and lose consciousness.\n\nYou wake up with the raiju next to you. The ground is still a massive pool of cum but for some reason you feel satisfied.\n\n");
	outputText("\"<i>Good morning, I was wondering when you would wake up. I must thank you, you helped me release all the stockpiled energy I had.</i>\"");
	outputText("She slowly slides off your cock with a satisfied smile. ");
	if (flags[kFLAGS.ELECTRA_FOLLOWER] < 2) {
		outputText("Where's the crazy girl from before?\n\n");
		outputText("\"<i>I have to go but here, take this jewel and these gems for your trouble. I hope we see each other again.</i>\"");
		outputText("She hands you a yellow jewel and a good amount of gems before leaving. ");
		if (player.raijuScore() >= 10) outputText("Welp your own energy management isn't getting any better, seems you will have to expel that on someone else.\n\n");
		else {
			outputText("As for you, your entire body feels sensitive and aches for touch from the slowly receding voltage. Something however tells you that indulging yourself would be a bad idea.\n\n");
			player.orgasm();
			if (player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
				player.removeStatusEffect(StatusEffects.RaijuLightningStatus);
				player.createStatusEffect(StatusEffects.RaijuLightningStatus,169,0,0,0);
			}
			else player.createStatusEffect(StatusEffects.RaijuLightningStatus,169,0,0,0);
		}
	}
	else {
		outputText("Electra sighs in absolute relief, thankful.\n\n");
		outputText("\"<i>You have no idea how satisfying that was [name] thanks again for helping me get relief.</i>\"");
		outputText("Well you're in no better than she was earlier but your glad you could be of some help. You redress and ready back for your adventures. Ugh where are those goblin sluts when you need one.\n\n");
		if (player.raijuScore() < 10) {
			player.orgasm();
			if (player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
				player.removeStatusEffect(StatusEffects.RaijuLightningStatus);
				player.createStatusEffect(StatusEffects.RaijuLightningStatus,169,0,0,0);
			}
			else player.createStatusEffect(StatusEffects.RaijuLightningStatus,169,0,0,0);
		}
	}
	electraAffection(10);
	if (flags[kFLAGS.ELECTRA_FOLLOWER] < 2) {
		monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
		inventory.takeItem(consumables.VOLTTOP, cleanupAfterCombat);
	}
	else {
		if (CoC.instance.inCombat) {
			monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
			inventory.takeItem(consumables.VOLTTOP, cleanupAfterCombat);
		}
		inventory.takeItem(useables.RPLASMA, camp.returnToCampUseOneHour);
	}
}
public function ElectraSeXYesF():void {
	outputText("Before you can issue a protest, she begins to grind her pussy against your own, making you moan. Her nice E sized teats are bouncing as something not unlike static electricity begins to form between you. No wait it totally is electricity! You are immediately zapped, your pussy gushing with fluids and your brain going mushy as your pleasure buzzers are all set alight by the raiju’s electric current. ");
	outputText("She seems to be riding the orgasm of her life as her own pussy juices are melding with yours, electricity dancing in the air around you two. You cum and cum again at such a speed you have no idea how you still manage to retain some semblance of consciousness from the mind numbing pleasure in your switch. Both of you finally lose consciousness as the electric flow ebbs your tongues loling out from the intense pleasure.\n\n");
	outputText("You wake up with the raiju next to you. The ground is still a massive pool of girl cum, but for some reason you feel satisfied.\n\n");
	outputText("\"<i>Good morning, I was wondering when you would wake up. I must thank you, you helped me release all the stockpiled energy I had.</i>\"");
	outputText("She slowly parts away from your pussy with a satisfied smile. ");
	if (flags[kFLAGS.ELECTRA_FOLLOWER] < 2) {
		outputText("Where's the crazy girl from before?\n\n");
		outputText("\"<i>I have to go but here, take this jewel and these gems for your trouble. I hope we see each others again.</i>\"");
		outputText("She hands you a yellow jewel and a good amount of gems before leaving. ");
		if (player.raijuScore() >= 10) outputText("Welp your own energy management isn't getting any better, seems you will have to expel that on someone else.\n\n");
		else {
			outputText("As for you, your entire body feels sensitive and aches for touch from the slowly receding voltage. Something however tells you that indulging yourself would be a bad idea.\n\n");
			player.orgasm();
			if (player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
				player.removeStatusEffect(StatusEffects.RaijuLightningStatus);
				player.createStatusEffect(StatusEffects.RaijuLightningStatus,169,0,0,0);
			}
			else player.createStatusEffect(StatusEffects.RaijuLightningStatus,169,0,0,0);
		}
	}
	else {
		outputText("Electra sighs in absolute relief, thankful.\n\n");
		outputText("\"<i>You have no idea how satisfying that was [name] thanks again for helping me get relief.</i>\"");
		outputText("Well you're in no better than she was earlier but your glad you could be of some help. You redress and ready back for your adventures. Ugh where are those goblin sluts when you need one.\n\n");
		if (player.raijuScore() < 10) {
			player.orgasm();
			if (player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
				player.removeStatusEffect(StatusEffects.RaijuLightningStatus);
				player.createStatusEffect(StatusEffects.RaijuLightningStatus,169,0,0,0);
			}
			else player.createStatusEffect(StatusEffects.RaijuLightningStatus,169,0,0,0);
		}
	}
	electraAffection(10);
	if (flags[kFLAGS.ELECTRA_FOLLOWER] < 2) {
		monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
		inventory.takeItem(consumables.VOLTTOP, cleanupAfterCombat);
	}
	else {
		if (CoC.instance.inCombat) {
			monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
			inventory.takeItem(consumables.VOLTTOP, cleanupAfterCombat);
		}
		inventory.takeItem(useables.RPLASMA, camp.returnToCampUseOneHour);
	}
}
public function ElectraSeXChargeUp():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if (player.hasCock()) {
		outputText("You lay down on top of ");
		if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
		else outputText("the female raiju");
		outputText(" and gently begin rubbing the glan of your hardening penis against her labia. You can feel your rod covering up with delicious static like a tesla coil, thunder roaring in the back of your mind as you slowly sheath yourself with her electricity. ");
		if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
		else outputText("She");
		outputText(" gasps in delight as you plug yourself in inch by inch, drawing out her charge into yourself, you are connected now. The first thrust makes her pussy gush as if having been edged for months on end");
		outputText(" awaiting an orgasm that never came, until now that is. Her nail gently tingles your back as she discharges electricity, enjoying the intense plugging between her legs as you keep moving inside.\n\n");
		outputText("You tense eventually, your cock feeling tortured as you deny yourself orgasm allowing her to transfer her excess lust in you through her cunt, as she screams a roar not unlike thunder, her pussy gushing again with the torrent of girl rain that accompanies her thunderous orgasm. Your lightning rod is, by now, harder than steel by the sheer amount of lust capacitance stored within it.\n\n");
	}
	else {
		outputText("You lay down on top of ");
		if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
		else outputText("the raiju");
		outputText(" and gently begin rubbing your pussy against hers, drawing in her current. ");
		if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
		else outputText("She");
		outputText(" moans in delight as her current slowly passes on to you, stacking on top of your own. In an effort to coax her climax faster you move down and suckle on her positive and negative nipples in turns, coaxing the current right out of her. She moans in delight as you please her like no partner would. ");
		outputText("You are well aware mostly of the unfortunate one timers she meets are too busy jerking on the ground to actually take care of her. Her voltage transfer intensifies and you moan in pleasure as your genitals becomes linked by a visible set of lightning arcs, ");
		if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra's");
		else outputText("the raiju");
		outputText(" pussy gushing its fluid right unto yours. She finally cums, her juice and charge flowing out of her and unto you like current through a cable.\n\n");
	}
	outputText("You pant in desire, your body now saturated with your combined electricity. You’re so horny now it takes greats effort from you not to pin her down and fuck the charge back into her. Guess it’s time to find a different partner to actually empty it out before you go lustzerk. ");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
	else outputText("The raiju");
	outputText(" notice your predicament and nods, appreciative of your efforts.\n\n");
	outputText("\"<i>It’s okay, go zap the brain out of someone else, I will be all right now, geez it's been so long since last I had my mind clear of the haze, thanks again.");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] < 3) {
		outputText(" Not many a kin would go out of their way to help a girl like me, you’re quite sweet… My name is Electra, I really hope to see you again around these parts.");
		flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] = 3;
	}
	outputText("</i>\"\n\n");
	if (flags[kFLAGS.ELECTRA_FOLLOWER] < 2) outputText("You don't wait for her to tell you twice and run off back to camp.\n\n");
	electraAffection(10);
	if (player.lust100 < 90) player.lust = player.maxLust() * 0.9;
	if (flags[kFLAGS.ELECTRA_FOLLOWER] < 2) doNext(camp.returnToCampUseOneHour);
	else inventory.takeItem(useables.RPLASMA, camp.returnToCampUseOneHour);
}
public function ElectraVoltTransfer():void {
	clearOutput();
	outputText("You ponder what to do with your defeated opponent then realize your body is overflowing with static. Your opponent shudders as you grab her by the neck.\n\n");
	outputText("\"<i>Do you know how charged I am right now? I’ll need to get rid of that before I lose my mind. Thankfully you came along at the perfect moment.</i>\"\n\n");
	outputText("Electra only understands what you mean when you kiss her, your static starting to lick her skin, leaving a tingle of pleasure and arousal as you start to vent your electricity out.\n\n");
	outputText("Voltage rushes out of your body as it transfers to your victim massaging the shape of her E cup breasts, licking the entrance of her pussy and spreading across the rest of her skin. You smile in contentment as the haze of lust progressively clears from your mind which is the opposite of what can be said for your victim. The excess of your static slowly passes into Electra prone form ");
	outputText("and you almost achieve climax from the relief as you purge all of this bad energy out of yourself.\n\nYour victim, however, is not so lucky. As you pour in your lust she begins to completely lose control, attempting to fiercely masturbate this excess of desire out, to no avail. As you are close to done your partner is a wrecked mess on the floor, desperate to gain release but unable ");
	outputText("to achieve it fully as the supernatural electricity keeps building her desire way beyond normal, obliterating self-restraint and pride along the way. You move away from Electra just as her hands begin to draw fluids out of her lust filled endowment. You stay clear as your victim’s lust explodes, spewing girlcum and milk everywhere in the vicinity. ");
	outputText("You can see the pulse of your statics as a small glow in every thrust of her hips as she keep fiercely masturbating in an attempt to expel the lust.\n\n");
	outputText("You leave your lust receptacle there, it's unlikely Electra will stop masturbating anytime soon.");
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}
public function ElectraSeXHeadpat():void {
	outputText("For reasons unknown you feel like head patting ");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
	else outputText("the raiju");
	outputText(". At first she looks at you, somewhat confused, before a dopey smile starts breaking out on her face.\n\n");
	outputText("You proceed to gently rub her hairs then her ears, something not unlike static electricity slowly charging beneath your fingers. As the static transfer from her body to yours it begins focusing down between your legs, your");
	if (player.hasCock()) {
		outputText(" cock fully reaching its full erect state within no time");
		if (player.hasVagina()) outputText(", as your pussy gushes with tingling pleasure and anticipation");
	}
	if (player.hasVagina()) outputText(" pussy gushing with tingling pleasure and anticipation");
	outputText(". The raiju seems to be deeply enjoying this gentle treatment, her pussy discharging small leaks of plasma as her body transfers its static through your caring hand. Only as her charge is fully transferred do you reach your own orgasm, your cum mixing up with the plasma already on the ground.\n\n");
	outputText("The raiju’s eyes seem clearer now, more focused and she stutters an apology as you slowly remove your still tingling hand.\n\n");
	outputText("\"<i>Thank you so much for that, I really needed it. ");
	if (flags[kFLAGS.ELECTRA_FOLLOWER] < 2) {
		outputText("I have to go now but here take this jewel and these gems for your trouble. I hope we see each other again.</i>\"");
		outputText("She hands you a yellow jewel and a good amount of gems before leaving. As for you, your entire body still feels sensitive and aches for touch from the slowly receding voltage. Something however tells you that indulging yourself would be a bad idea.\n\n");
	}
	else {
		outputText("People on Mareth can't seem to appreciate the simplicity and kindness of a simple caress, pat on the head or hug nowaday. Those simple displays of affections are more direct and personal than any sex or kiss would be here.</i>\"");
		outputText("You tell her it’s all fine, everyone needs a nice pat on the back or a comforting hug every now and then.\n\n");
	}
	if (player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
		player.removeStatusEffect(StatusEffects.RaijuLightningStatus);
		player.createStatusEffect(StatusEffects.RaijuLightningStatus,169,0,0,0);
	}
	else player.createStatusEffect(StatusEffects.RaijuLightningStatus, 169, 0, 0, 0);
	electraAffection(10);
	player.orgasm();
	if (flags[kFLAGS.ELECTRA_FOLLOWER] < 2) {
		monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
		inventory.takeItem(consumables.VOLTTOP, cleanupAfterCombat);
	}
	else {
		if (CoC.instance.inCombat) {
			monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
			inventory.takeItem(consumables.VOLTTOP, cleanupAfterCombat);
		}
		doNext(camp.returnToCampUseOneHour);
	}
}
public function ElectraSeXNo():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("No, you ain't going to give her satisfaction after she tried to rape you. You walk away, heading back to your camp, barely hearing the echoes of her cries as the crazy girl begs for you to fuck her brains out.\n\n");
	electraAffection(2);
	cleanupAfterCombat();
}
	}
}