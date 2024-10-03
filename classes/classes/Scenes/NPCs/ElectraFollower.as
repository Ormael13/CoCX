/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.SaveableBodyPart;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;
import classes.internals.SaveableState;

public class ElectraFollower extends NPCAwareContent implements SaveableState, TimeAwareInterface
{
	public static var ElectraSonsNum:Number;
	public static var ElectraDaughtersNum:Number;
	public static var ElectraHermKidsNum:Number;
	public static var ElectraTotalKidsNum:Number;

	public function stateObjectName():String {
		return "ElectraFollower";
	}

	public function resetState():void {
		ElectraSonsNum = 0;
		ElectraDaughtersNum = 0;
		ElectraHermKidsNum = 0;
		ElectraTotalKidsNum = 0;
	}

	public function saveToObject():Object {
		return {
			"ElectraSonsNum": ElectraSonsNum,
			"ElectraDaughtersNum": ElectraDaughtersNum,
			"ElectraHermKidsNum": ElectraHermKidsNum,
			"ElectraTotalKidsNum": ElectraTotalKidsNum
		}
	}

	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o) {
			ElectraSonsNum = o["ElectraSonsNum"];
			ElectraDaughtersNum = o["ElectraDaughtersNum"];
			ElectraHermKidsNum = o["ElectraHermKidsNum"];
			ElectraTotalKidsNum = o["ElectraTotalKidsNum"];
			
		} else {
			// loading from old save
			resetState();
		}
	}

//flag ELECTRA_TALKED_ABOUT_HER]: 0,1 - not know her name, 3 - know her name, 2/4+ - male sex scene variant for knowing or not what pour it all out mean ^^

public function electraAffection(changes:Number = 0):Number
{
	flags[kFLAGS.ELECTRA_AFFECTION] += changes;
	if (flags[kFLAGS.ELECTRA_AFFECTION] < 0) flags[kFLAGS.ELECTRA_AFFECTION] = 0;
	if (flags[kFLAGS.ELECTRA_AFFECTION] > 100) flags[kFLAGS.ELECTRA_AFFECTION] = 100;
	return flags[kFLAGS.ELECTRA_AFFECTION];
}

public var pregnancy:PregnancyStore;

	public function timeChange():Boolean {
		pregnancy.pregnancyAdvance();
		return false;
	}

	public function timeChangeLarge():Boolean {
		if (pregnancy.isPregnant) {
			switch (pregnancy.eventTriggered()) {
				case 1: //
					ElectraPregAnnouncement();
					return true;
				case 2:
				ElectraPregProgression1();
					return true;
				case 3:
				 ElectraPregProgression2();
					return true;
				case 4:
					outputText("Electra's rubbing her stomach, which has grown significantly. You notice, however, that your Raiju lover seems more tired than usual. She waves at you weakly, smiling despite her weakened state. As you turn away, she looks down at her stomach, a dreamy expression on her face.");
					return true;
				case 5:
					ElectraPregProgression3();
					return true;
			}
		}
		if (pregnancy.isPregnant && pregnancy.incubation == 0) {
			ElectraDeliversRaijuBabies();
			pregnancy.knockUpForce(); //Clear Pregnancy
			return true;
		}
		return false;
	}

	public function ElectraFollower() {
		pregnancy = new PregnancyStore(kFLAGS.ELECTRA_PREGNANCY_TYPE, kFLAGS.ELECTRA_INCUBATION, 0, 0);
		pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER,  240, 200, 150, 100, 50);
		EventParser.timeAwareClassAdd(this);
		Saves.registerSaveableState(this);
	}

public function firstEnc():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("As you wander the mountain you hear the sound of echoing thunder though this time around it clearly didn’t come from the sky. You see multiple imps and even a minotaur run away from the spot where the sound was heard. As you go there to see what’s going on you come upon a single girl with animal morph features. She's panting on the ground with a hand under her dress.\n\n");
	outputText("\"<i>Ahhhh someone... someone help me get rid of this maddening desire... rape me... fuck me, I don’t care how you do it. Gah, why are they all fleeing!...come back! Come back so I can get rid of my itches... Come back so we can FUCK!</i>\"\n\n");
	outputText("She suddenly realizes you are there and her eyes glimmer with a hint of barely contained madness. She stands up, still playing with her pussy, and eyes you up with a manic smile on her face as electricity starts to dance in the air around her.\n\n");
	outputText("\"<i>You will be my lightning rod!!!!</i>\"");
	outputText("\n\nYou are under attack by a Raiju!");
	camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_RAIJU);
	startCombat(new Electra());
	doNext(playerMenu);
}
public function repeatMountainEnc():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("As you wander the mountain you hear the sound of echoing thunder...But the rains have long since been stopped here. You see multiple imps and even a minotaur run away from the spot where the sound was heard. ");
	repeatElectraEnc();
}
public function repeatPlainsEnc():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("As you wander the plains you hear the sound of echoing thunder...But the rains have long since been stopped here. You see multiple imps and even a satyr run away from the spot where the sound was heard. ");
	repeatElectraEnc();
}
public function repeatDeepwoodsEnc():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("As you wander the woods you hear the sound of echoing thunder...But the rains have long since been stopped here. You see multiple imps and even a satyr run away from the spot where the sound was heard. ");
	repeatElectraEnc();
}
public function repeatDesertEnc():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("As you wander the desert you hear the sound of echoing thunder...But the rains have long since been stopped here. You see multiple imps and even an apophis run away from the spot where the sound was heard. ");
	repeatElectraEnc();
}
public function repeatElectraEnc():void {
	outputText("As you go to see what’s going on you come upon ");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
	else outputText("the Raiju girl");
	outputText(" again. She's panting on the ground with a hand under her dress and masturbating like there is no tomorrow.\n\n");
	outputText("\"<i>Ahhhh someone... someone help me get rid of this maddening desire... rape me... fuck me I don’t care how you do it. Gah, why are they all fleeing!...come back! Come back so I can get rid of my itches... Come back so we can FUCK!</i>\"\n\n");
	if (player.isRace(Races.RAIJU, 1, false) || player.isRace(Races.THUNDERBIRD, 1, false) || player.isRace(Races.KIRIN, 1, false)) repeatEncAsRaijuPC();
	else {
		outputText("Shit! If she sees you now she will definitely attack. Just as you are about to leave, she realizes you're there and her eyes glimmer with a hint of barely contained madness. She stands up, still playing with her pussy, and eyes you up with a manic smile on her face as electricity starts to dance in the air around her.\n\n");
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
	outputText("Not having made any effort to hide from her, she swiftly notices you. She stands up, still playing with her pussy, and eyes you up for a second before sighing.\n\n");
	outputText("\"<i>I just can’t find anyone to fuck the voltage out of me. And of course the only person that’d be willing to make out is");
	if (player.isRace(Races.RAIJU, 1, false))outputText(" another Raiju.");
	if (player.isRace(Races.THUNDERBIRD, 1, false))outputText(" a Thunderbird.");
	if (player.isRace(Races.KIRIN, 1, false))outputText(" a Kirin.");
	outputText(" Neither of us are discharging today.</i>\"");
	menu();
	addButton(1, "Relieve her", repeatEncAsRaijuPCRelieveHer);
	addButton(3, "No, thanks", repeatEncAsRaijuPCNoThanks);
}
public function repeatEncAsRaijuPCNoThanks():void {
	outputText("Can’t get her charge out? Too bad, because you have enough of yours to manage as it is. You bid her good luck then head back to camp.\n\n");
	endEncounter();
}
public function repeatEncAsRaijuPCRelieveHer():void {
	outputText("You don’t exactly find her bad on the eyes for a kinswoman so why not help her? You offer to draw out her discharge for her. The raiju lights up, teary eyed at your offer and very appreciative.\n\n");
	outputText("\"<i>Tha...Thank you so much, I won’t forget this!</i>\"\n\n");
	ElectraSeXChargeUp();
}

public function ElectraRecruiting():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You run into Electra again this time around. Shockingly, she ain't chasing after the locals for sex. Instead she walks straight up to you, looking somewhat troubled. While she isn't sparking, she fidgets. It's almost as if she needs to say something to you.\n\n");
	outputText("\"<i>I've have been looking for you");
	if (player.isRace(Races.RAIJU, 1, false)) outputText(""+player.mf("kinsman","kinswoman")+"");
	outputText(". I'm kind of sorry for coming up to you like that all the time. Don't worry, I already discharged myself, this isn't what I wanted to see you for. See uh as it is I've been considering...us. you've been helping me out so often by now I've become dependent on your touch. ");
	outputText("When I see you I can feel the surge running down my spine, the fondness of every attention you gave me imprinted in my mind and I… can I have your name please?</i>\"\n\n");
	outputText("You tell her your name and that you are the Champion of Ignam, sent to protect your realm from demon invasion.\n\n");
	outputText("\"<i>Ah… With a noble goal too. Well I can't delay it anymore, I need to spell it out, I'm in love with you. I'd like to ask you...Would you be okay with a girlfriend? It doesn't matter to me if you have someone else... I'm sure someone as nice as you must have someone else by now... But I want you. </i>\"\n\n");
	outputText("Well that declaration sure fell down like thunder. What do you say?\n\n");
	menu();
	addButton(1, "Sure", ElectraRecruitingSure);
	addButton(3, "Nah", ElectraRecruitingNah);
}
public function ElectraRecruitingSure():void {
    clearOutput();
	outputText("You help up Electra to your camp. Ironically, or perhaps luckily, enemies stay clear from you during the travel, Electra acting as a natural repellent. You finally arrive at camp, the weasel insisting on wanting to see everything"+(camp.hasCompanions() ? " and meeting everyone" : "")+".\n\n");
	if (player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] != 3) {
		outputText("Jojo notices her quite fast, waving a warm welcome.\n\n");
		outputText("\"<i>Hello again...Electra, right? How did the meditation attempt go?</i>\"\n\n");
		outputText("Electra sighs, embarrassed.\n\n");
		outputText("\"<i>Poorly. I did try to meditate but by the time I finally managed to stand still, I was too charged up to think straight anymore.</i>\"\n\n");
		outputText("This doesn't seem to worry Jojo that much.\n\n");
		outputText("\"<i>Spend some time with me on the side and we'll find a way to teach you meditation.</i>\"\n\n");
	}
	if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) {
		outputText("Amily notices Electra from the corner of her eyes and slowly begins to sneak away from the camp toward the closest hiding place. Electra isn't letting her go without talking, however.\n\n");
		outputText("\"<i>Hey you! Where are you going like that, it’s not like I'm about to zap you.</i>\"\n\n");
		outputText("Amily, aware that sneaking out is no longer an option, turns to face Electra.\n\n");
		outputText("\"<i>Hey [name], I know you are kind and all but this is a raiju. She's basically a ticking bomb waiting to explode in lust inducing thunderbolts. I seriously hope you intend to take full charge of her. I don't fancy myself getting shocked and turned into a wet mess.</i>\"\n\n");
		outputText("You promise Amily you will keep Electra’s needs in check.\n\n");
	}
	if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && !player.hasStatusEffect(StatusEffects.EtnaOff)) {
		outputText("Etna flies over from her current location to meet you both.\n\n");
		outputText("\"<i>Hey if it isn't thunder girl! ain't seen you around ever since you decided to make the other side of the mountains your territory. Geeze you scared a lot of the minotaurs down there back to mine, not that I'm complaining. It's just a wild guess but you're here, so... did [name] tame you?</i>\"\n\n");
		outputText("Electra responds with clear annoyance.\n\n");
		outputText("\"<i>Nothing about taming here Etna, I'm not some wild beast you can hold on a leash. [name] just happened to be on my path when I needed "+player.mf("him","her")+" the most, willing to help of "+player.mf("his","her")+" own volition.</i>\"\n\n");
	}
	outputText("<b>Before setting in, as if remembering something, Electra pulls a shining shard from her inventory and hand it over to you as a gift. You acquired a Radiant shard!</b>");
	if (player.hasKeyItem("Radiant shard") >= 0){
		player.addKeyValue("Radiant shard",1,+1);
	}
	outputText("\n\n(<b>Electra has been added to the Lovers menu!</b>)\n\n");
	flags[kFLAGS.ELECTRA_FOLLOWER] = 2;
	flags[kFLAGS.ELECTRA_LVL_UP] = 1;
	flags[kFLAGS.ELECTRA_DEFEATS_COUNTER] = 0;
	flags[kFLAGS.ELECTRA_DAILY_STORM_JEWEL] = 0;
	explorer.stopExploring();
	doNext(playerMenu);
}
public function ElectraRecruitingNah():void {
    clearOutput();
	outputText("You apologize to her but for now you aren't exactly ready to make space for someone in your life. Electra nods. She's on the verge of tears but accepts your decision to turn her down, walking away.\n\n");
	flags[kFLAGS.ELECTRA_FOLLOWER] = 1;
	electraAffection(-100);
	endEncounter();
}
public function ElectraRecruitingAgain():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("You run into Electra again this time around. Shockingly, she ain't chasing after the locals for sex. Instead she walks straight up to you, looking somewhat troubled. While she isn't sparking, she fidgets. You know why she's approaching you. \n\n");
	outputText("\"<i>[name] please, I hope you would reconsider! It’s very clear to me that we are meant to be together as a couple! Why else would you keep helping me up like that, my heart beat with yours. I really want it so badly for you to say that you will take me with you this time around.</i>\"\n\n");
	outputText("Guess you are at that crossroad again, what is your choice?\n\n");
	menu();
	addButton(1, "Sure", ElectraRecruitingSure);
	addButton(3, "Nah", ElectraRecruitingNah);
}

public function ElectraCampMainMenu():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if (flags[kFLAGS.KIHA_FOLLOWER] == 1 && KihaFollower.ElectraInteractionHappened && rand(10) == 0) {
		kihaFollower.electraInteraction(true);
	}
	else {
		outputText("You almost feel the static in the air as you head up to Electra. She perks up at your presence, ears on end.\n\n");
		outputText("\"<i>Hey [name] good afternoon! I have been generating a lot of current lately, it's always difficult to keep it under control but since you"+(camp.hasCompanions() ? " and your friends...</i>\" She pauses licking her lips naughtily at the thought. This should be an alarm to you but so far no one complained. \"<i>..." : "")+"");
		outputText("are here I can keep a lust free lucidity all the time, it's so nice to be able to think straight all the time.");
		outputText("" + (player.hasStatusEffect(StatusEffects.CampRathazul) ? " The old rat regularly come over for plasma samples, don't know what he does with it though. Lightning in a bottle maybe? You should check out whatever he's been doing with my lightning, it might be worth your while." : "") + "");
		outputText(" Anyway, did you come over to talk...or for some shock therapy?</i>\"\n\n");
		outputText("The ambient energy in the air almost doubles as she says that. Who can say whether she is aroused or not right now.");
	}
	menu();
	addButton(0, "Appearance", electraAppearance).hint("Examine Electra's detailed appearance.");
	addButton(1, "Talk", electraTalk).hint("Ask Electra about something.");
	addButton(2, "Sex", electraSex).hint("Have some sex with Electra");
	if (flags[kFLAGS.ELECTRA_DAILY_STORM_JEWEL] > 0) addButtonDisabled(3, "Req. Jewel", "You already asked her for a jewel today.");
	else addButton(3, "Req. jewel", electraStromJewel).hint("Ask Electra for a storm jewel.");
	addButton(4, "Spar", electraSpar).hint("Ask Electra for a mock battle with sex for the winner.")
		.disableIf(flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] < 2, "You need a good sparring ring for that.");
	addButton(14, "Back", camp.campLoversMenu);
}

public function electraAppearance():void {
	clearOutput();
	outputText("Electra is a raiju. Her hair is long, wild and unkempt, the strands running in front of her face twisting out and glowing at the tip like actual lightning bolts. Her green slitted eyes are similar to a weasel's, always staring with barely contained lust. Her mouth looks human, though underneath those lips hide ");
	outputText("two small fangs, sharper than the others. Her furry weasel ears are well protected from extreme sound, otherwise she'd be constantly putting her hand over them when discharging thunder.\n\nElectra’s arms are human although her nails are sharp as claws and regularly flashing with telltale sign of a potent electric charge. ");
	outputText("Speaking of those, you know for a fact that when she’s not looking at you, she regularly sneaks in a claw to masturbate... Not that this does her any good as raiju are unable to achieve true release on their own. Her fur alters between purple, black, blue and white, the color of lightning. Her legs, unlike her arms ");
	outputText("have fur up to the middle of her thighs. Her neck is hidden by a fluffy collar of black and white fur, with lightning reliefs. Up her shapely ass she has a fluffy wild tail which puffs up when she becomes overcharged. It is spiky in appearance, the telltale sign of current running through as her fur rises up.\n\n");
	outputText("Electra is well-endowed with a pair of E cup breasts well contained within her kimono."+(player.inte > 50 ? " You idly ponder if she stores electricity in there like opposed polarity magnets." : "")+"\n\n");
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
	outputText("No, as in is she a weasel, a dog, a cat, some other morph you've never heard about.\n\n");
	outputText("\"<i>As I said a raiju, we are our own species really, Sleipnir our patron god created us as is. And before you ask then yes being horny was also part of our original self. Hell if I know, maybe the sky god just thought it'd be funny or he did this while jerking his massive horsecock and the resulting orgasm created us. ");
	outputText("The only confirmed fact is we were born of thunders and clouds and that like clouds when we are oversaturated we turn violent.</i>\"\n\n");
	doNext(electraTalk);
	cheatTime(1/4);
}
public function electraTalkLocals():void {
	clearOutput();
	outputText("So why are all the locals fleeing from her anyway, you thought everyone on Mareth was drunk on sex?\n\n");
	outputText("\"<i>Sure they’re all drunk on sex but no one enjoys being stuck in the pre orgasm phase until they find a cunt to fuck or get their ass fucked, let alone being on the receiving end. As a result I'm forced into chasing those so-called sexual apex predators for a fuck.</i>\"\n\n");
	outputText("Come to think of it that explains why her passage causes a mass exodus of minotaurs and imps, fleeing the region.\n\n");
	doNext(electraTalk);
	cheatTime(1/4);
}
public function electraTalkMasturbating():void {
	clearOutput();
	outputText("You regularly catch her in the act of masturbating, is it because she just can't stop, or is it because she likes it too much. Last you checked, raiju can't cum on their own. Electra sighs in discouragement before responding.\n\n");
	outputText("\"<i>Ugh, I should be more discreet about that, but yea, it's really because I can't help it. My body unconsciously seeks out its next orgasm so my hands machinaly reach for my privates when I'm not concentrating. It's... kind of embarrassing. ");
	outputText("Besides, it only makes the next time I frenzy that much closer. Maybe its like you say and I'm just a crazy nympho.</i>\"\n\n");
	outputText("You never said she was crazy. Just that she needs help, and you're more than happy to provide it.\n\n");
	doNext(electraTalk);
	cheatTime(1/4);
}

public function electraStromJewel():void {
	clearOutput();
	outputText("You ask if Electra could produce a storm jewel for you. She concentrates, pursing her lips, and focuses electricity into her palm, making one near instantaneously.\n\n");
	outputText("\"<i>Sure have one but be careful, they are highly unstable.</i>\"\n\n");
	flags[kFLAGS.ELECTRA_DAILY_STORM_JEWEL]++;
	inventory.takeItem(consumables.VOLTTOP, ElectraCampMainMenu);
	cheatTime(1/4);
}

public function electraSpar():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("Electra chuckles as you mention you would like to spar with her, heading for the ring.\n\n");
	outputText("\"<i>Really? Well you know how it works right? If I win, I get to dump it all out inside you.</i>\"\n\n");
	startCombat(new Electra());
	doNext(playerMenu);
}

//outputText("\n\n");
//outputText("\"<i></i>\"\n\n");

public function electraSex():void {
	clearOutput();
	outputText("Electra is smiling wide with that weaselly, naughty grin of hers.\n\n");
	outputText("\"<i>Oh my… so how do you plan to take me?"+(!(player.isRace(Races.RAIJU, 1, false) || player.isRace(Races.THUNDERBIRD, 1, false)) ? " Keep in mind any bodily contact will result in a discharge, I can't help it." : "")+"</i>\"");
	menu();
	addButton(0, "Charge up", ElectraSeXChargeUp)
		.disableIf(!player.isRace(Races.RAIJU, 1, false) && !player.isRace(Races.THUNDERBIRD, 1, false), "Only available to Raijus and Thunderbirds.");
	addButton(1, "Volt Transfer", ElectraVoltTransfer)
		.disableIf(!player.isRace(Races.RAIJU, 1, false) && !player.isRace(Races.THUNDERBIRD, 1, false), "Only available to Raijus and Thunderbirds.");
	addButton(2, "Headpat", ElectraSeXHeadpat);
	addButton(3, "Lets just fuck", ElectraSeXYes);
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
	outputText(", the electricity sends all your pleasure nerves into overdrive as your sensitivity skyrockets. You barely see her taking her leave as you faint from the pleasure overdose.\n\n");
	outputText("You wake up in a pool of your own fluids. After such mind wracking pleasure, your entire body feels sensitive and aches to be touched from the slowly receding voltage. You wince, knowing that indulging would be a bad idea. \n\n");
	if (player.hasStatusEffect(StatusEffects.RaijuLightningStatus))
		player.removeStatusEffect(StatusEffects.RaijuLightningStatus);
	player.createStatusEffect(StatusEffects.RaijuLightningStatus,25,0,0,0);
	electraAffection(5);
	player.orgasm();
	cleanupAfterCombat();
}
public function PlayerSexElectraPostSpar():void {
	if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
		if (flags[kFLAGS.ELECTRA_DEFEATS_COUNTER] >= 1) flags[kFLAGS.ELECTRA_DEFEATS_COUNTER]++;
		else flags[kFLAGS.ELECTRA_DEFEATS_COUNTER] = 1;
		if (flags[kFLAGS.ELECTRA_LVL_UP] < 12) {
			if (flags[kFLAGS.ELECTRA_DEFEATS_COUNTER] == 4 + flags[kFLAGS.ELECTRA_LVL_UP]) {
				if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers4)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers4, 3, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 4 + flags[kFLAGS.ELECTRA_LVL_UP]));
				else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers4, 0, 0, (player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * 4 + flags[kFLAGS.ELECTRA_LVL_UP]), 0);
				flags[kFLAGS.ELECTRA_DEFEATS_COUNTER] = 0;
				flags[kFLAGS.ELECTRA_LVL_UP]++;
			}
		}
	}
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
		outputText("\"<i>Ah, you’re quite something... My name is Electra by the way. Nice to meet you again... Can we get to the fucking already?</i>\"\n\n");
		flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] = 3;
	}
	else {
		outputText("As you look over your defeated opponent you swiftly notice that she’s panting with desire just from looking at you.\n\n");
		outputText("\"<i>Please FUCK ME!... I don’t care how you do it, just fuck me so I can be free of my lust! It’s been days...</i> She pouts, eyes wide. \"\n\n");
		outputText("There's something fishy about this, but do you fuck her anyways?");
		flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] = 1;
	}
	menu();
	addButton(0, "Yea Sure", ElectraSeXYes).disableIf(player.lust < 33, "Not horny enough!")
		.disableIf(player.isGenderless(), "Not for genderless!");
	addButton(1, "No Way", ElectraSeXNo);
	addButton(2, "Headpat", ElectraSeXHeadpat);
	SceneLib.uniqueSexScene.pcUSSPreChecksV2(PlayerSexElectra);
}
public function ElectraSeXYes():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
	else outputText("The raiju");
	outputText(" surprises you by jumping on top of you before you can even finish your sentence.\n\n");
	outputText("\"<i>Let's not waste any time then!</i>\"");
	outputText("She swiftly takes ahold of your clothes and starts methodically stripping you. Briefly, you think she's turning the tables on you, but the genuine smile and excitement in her eyes gives her away. She's just so happy to finally get laid.\n\n");
	sceneHunter.selectGender(ElectraSeXYesM, player.hasVagina() ? ElectraSeXYesF : null);
}
public function ElectraSeXYesM():void {
	outputText("\"<i>Ahhh gimme that lighting rod, please put it in!</i>\"");
	outputText("She begins flaunting her pussy like a target. Well, if she wants it that badly you won’t be the one to disappoint her. You grab her hips and slowly but surely pull her down on your [cock]. The girl screams in joy as you finally hit the bottom of her pussy. She moans, hips rolling, rocking up and down without you having to ask. There's something odd about this.\n\n");
	outputText("\"<i>Ahhhn we're plugged! We're plugged! I’m going to pour it all out!!!!</i>\"");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] == 2 || flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 4) outputText("Well here you go again... You brace yourself for the incoming jolt as");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] == 1 || flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] == 3) {
		outputText("Wait what?! Before you can ask what she means by that");
		flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER]++;
	}
	outputText(" you hear a humming, the odd sound intensifying, building for a few seconds before your entire body is struck by ");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
	else outputText("the raiju");
	outputText("’s lightning. The voltage is flowing out of her pussy straight to your dick! You moan as the current sets every one of your pleasure nerves into overdrive, causing you to reach orgasm almost instantly if not several times over and pump the raiju with your cum. The girl seems lost in the sensations of her pussy, tongue out and eyes rolling, as she gushes around your twitching cock. ");
	outputText("This rapid fire set of orgasms lasts for a fair minute before both of you fall on each other and lose consciousness.\n\nYou wake up with the raiju next to you. The ground is still a massive pool of cum, but for some reason you feel satisfied.\n\n");
	outputText("\"<i>Good morning, I was wondering when you would wake up. Thank you so much for helping me get rid of that energy...It's hard to deal with sometimes.</i>\"");
	outputText(" She slowly slides off your cock with a satisfied smile. ");
	player.sexReward("vaginalFluids","Dick");
	if ((flags[kFLAGS.ELECTRA_AFFECTION] >= 100) && (flags[kFLAGS.ELECTRA_FOLLOWER] == 2)) {
	ElectraPregChance();
	}
	afterYes();
}
public function ElectraSeXYesF():void {
	outputText("Before you can protest, she begins to grind her pussy against your own, making you moan. Her soft E sized teats are bouncing as something not unlike static electricity begins to form between you. No wait...it is electricity! You are immediately zapped, your pussy gushing with fluids and your eyes widening as your pleasure buzzers are all set alight by the raiju’s electric current. You try to pull back, but your brain isn't responding, the buzz of the current rocketing through your body.");
	outputText("She seems to be riding the orgasm of her life as her own pussy juices are mixing with yours, electricity dancing in the air around you two. You cum and cum again at such a speed you have no idea how you still manage to retain some semblance of consciousness from the mind-numbing pleasure in your switch. Both of you finally lose consciousness as the electric flow ebbs, your tongues lolling out from the intense pleasure.\n\n");
	outputText("You wake up with the raiju next to you. The ground is still a massive pool of girl cum, but for some reason you feel satisfied.\n\n");
	outputText("\"<i>Good morning, I was wondering when you would wake up. Thank you so much, you helped me release all the stockpiled energy I had.</i>\"");
	outputText("She slowly pulls away from your pussy, looking at your lower-half with a satisfied smile. ");
	player.sexReward("vaginalFluids", "Vaginal");
	afterYes();
}

public function afterYes():void {
	if (flags[kFLAGS.ELECTRA_FOLLOWER] < 2) {
		outputText("Where's the crazy girl from before?\n\n");
		outputText("\"<i>I have to go, but here. Take this jewel and these gems for your trouble. I hope we see each other again.</i>\"");
		outputText("She hands you a yellow jewel and a good amount of gems before leaving. ");
		if (player.isRace(Races.RAIJU, 1, false)) outputText("Well your own energy management isn't getting any better, seems you will have to expel that on someone else.\n\n");
		else outputText("As for you, your entire body feels sensitive and achesto be touched. Something however tells you that indulging yourself would be a bad idea.\n\n");
	} else {
		outputText("Electra sighs in absolute relief, a happy look in her eyes as she grips your shoulders.\n\n");
		outputText("\"<i>You have no idea how satisfying that was [name] thanks again for helping me get relief.</i>\"");
		outputText("Well you're no better than she was earlier, but you're glad you could be of some help. You redress and ready back for your adventures. Ugh, where are those goblin sluts when you need one?\n\n");
	}
	if (!player.isRace(Races.RAIJU)) {
		if (player.hasStatusEffect(StatusEffects.RaijuLightningStatus))
			player.removeStatusEffect(StatusEffects.RaijuLightningStatus);
		player.createStatusEffect(StatusEffects.RaijuLightningStatus,169,0,0,0);
	}
	afterSex();
}

public function afterSex():void {
	electraAffection(10);
	if (flags[kFLAGS.ELECTRA_FOLLOWER] < 2) {
		monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
		inventory.takeItem(consumables.VOLTTOP, cleanupAfterCombat);
	} else {
		if (CoC.instance.inCombat) {
			monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
			inventory.takeItem(consumables.VOLTTOP, cleanupAfterCombat);
		}
		inventory.takeItem(useables.RPLASMA, cleanupAfterCombat); // = returnOneHour if not combat
	}
}

public function ElectraSeXChargeUp():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	if (player.hasCock()) {
		outputText("You lay down on top of ");
		if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
		else outputText("the female raiju");
		outputText(" and gently begin rubbing the glans of your hardening penis against her labia. You can feel your rod buzzing with delicious static. The electricity moves around your shaft like a tesla coil, thunder roaring in the back of your mind as you slowly sheath yourself with her electrically charged lips. ");
		if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
		else outputText("She");
		outputText(" gasps in delight as you plug yourself in inch by inch, drawing out her charge into yourself, you are connected now. The first thrust makes her pussy gush as if having been edged for months,");
		outputText(" awaiting an orgasm that never came, until now that is. Her nail gently tingles your back as she discharges electricity, enjoying the intense plugging between her legs as you keep moving inside.\n\n");
		outputText("You tense, your cock feeling tortured as you deny yourself your orgasm. You allow her to transfer her excess lust in you through her cunt. She screams, a thunderous roar, her pussy gushes again with a torrent of girl rain. Your lightning rod is, by now, harder than steel, kept rigid by the sheer amount of lust-filled electricity stored within it.\n\n");
	}
	else {
		outputText("You lay down on top of ");
		if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
		else outputText("the raiju");
		outputText(" and gently begin rubbing your pussy against hers, drawing in her current. ");
		if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
		else outputText("She");
		outputText(" moans in delight as her current slowly passes to you, stacking your lust on top of your own. In an effort to coax her climax faster you lean down and suckle on her positive and negative nipples in turn, coaxing the current right out of her. She moans in delight, eyelids fluttering with the pleasure. ");
		outputText("You are well aware, most of the unfortunate one-timers she meets are too busy jerking on the ground to actually take care of her. Her voltage transfer intensifies and you moan in pleasure as lightning arcs visibly between your Raiju lover's pussy and your genitals, ");
		if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra's");
		else outputText("the raiju");
		outputText(" pussy gushing its fluid right unto yours. She finally cums, her juice and charge flowing out of her and unto you like current through a cable.\n\n");
	}
	outputText("You pant in desire, your body now saturated with your combined electricity. You’re so horny now it takes greats effort from you not to pin her down and fuck the charge back into her. You'll need to find a different partner to empty your charge before you go lustzerk. ");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
	else outputText("The raiju");
	outputText(" notice your predicament and nods, appreciative of your efforts.\n\n");
	outputText("\"<i>It’s okay, go zap the brains out of someone else, I'll be fine now. It's been so long since last I had my mind clear of the haze, thank you so much.");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] < 3) {
		outputText(" Not many of my kin would go out of their way to help a girl like me, you’re quite sweet… My name is Electra, I really hope to see you again around these parts.");
		flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] = 3;
	}
	outputText("</i>\"\n\n");
	if (flags[kFLAGS.ELECTRA_FOLLOWER] < 2) outputText("You don't wait for her to tell you twice and run off back to camp.\n\n");
	electraAffection(10);
	if (player.lust100 < 90) player.lust = player.maxLust() * 0.9;
	if (flags[kFLAGS.ELECTRA_FOLLOWER] < 2) endEncounter();
	else inventory.takeItem(useables.RPLASMA, explorer.done);
}
public function ElectraVoltTransfer():void {
	clearOutput();
	outputText("You look down at your defeated opponent, your body overflowing with static. You quickly decide to get rid of this excess energy. Your opponent shudders as you grab her by the neck.\n\n");
	outputText("\"<i>Do you know how charged I am right now? I’ll need to get rid of that before I lose my mind. Thankfully you came along at the perfect moment.</i>\"\n\n");
	outputText("Electra only understands what you mean when you kiss her, your static starting to lick her skin, leaving a tingle of pleasure and arousal as you start to vent your electricity out.\n\n");
	outputText("Voltage rushes out of your body as it transfers to your victim, massaging the shape of her E cup breasts, licking the entrance of her pussy and spreading across the rest of her skin. You smile in contentment as the haze of lust progressively clears from your mind... the opposite of what your victim is currently experiencing. The excess of your static slowly passes into Electra's prone form ");
	outputText("and you almost achieve climax from the relief as you purge all of this lustful energy.\n\nYour victim, however, is not so lucky. As you pour in your lust she begins to completely lose control, attempting to fiercely masturbate this excess of desire out, to no avail. As you are close to done your partner is a wrecked mess on the floor, desperate to gain release but unable ");
	outputText("to achieve it fully as the supernatural electricity keeps building, obliterating self-restraint and pride along the way. You move away from Electra just as her hands begin to draw fluids out of her lust filled endowment. You stay clear as your victim’s lust explodes, spewing girlcum and milk everywhere in the vicinity. ");
	outputText("You can see the pulse of your statics as a small glow in every thrust of her hips as she keeps fiercely masturbating in an attempt to expel the lust.\n\n");
	outputText("You leave your lust receptacle there, it's unlikely Electra will stop masturbating anytime soon.");
	player.sexReward("Default","Default",true,false);
	endEncounter();
}
public function ElectraSeXHeadpat():void {
	outputText("For reasons unknown you feel like head patting ");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 3) outputText("Electra");
	else outputText("the raiju");
	outputText(". At first, she looks at you, somewhat confused, before a dopey smile starts breaking out on her face.\n\n");
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
		outputText("I have to go now, but here take this jewel and these gems for your trouble. I hope we see each other again.</i>\"");
		outputText("She hands you a yellow jewel and a good amount of gems before leaving. As for you, your entire body still feels sensitive and aches to be touched. Something tells you that indulging yourself would be a bad idea.\n\n");
	}
	else {
		outputText("People on Mareth can't seem to appreciate the simplicity and kindness of a simple caress, pat on the head or hug nowaday. Those simple displays of affections are more direct and personal than any sex or kiss would be here.</i>\"");
		outputText("You tell her it’s all fine, everyone needs a nice pat on the back or a comforting hug every now and then.\n\n");
	}
	if (player.hasStatusEffect(StatusEffects.RaijuLightningStatus))
		player.removeStatusEffect(StatusEffects.RaijuLightningStatus);
	player.createStatusEffect(StatusEffects.RaijuLightningStatus, 169, 0, 0, 0);
	player.sexReward("Default","Default",true,false);
	afterSex();
}
public function ElectraSeXNo():void {
	spriteSelect(SpriteDb.s_electra);
	clearOutput();
	outputText("After she tried to rape you, she's begging for a favor? Yeah, no. You walk away, heading back to your camp, barely hearing the echoes of her cries as the crazy girl begs for you to fuck her brains out.\n\n");
	electraAffection(2);
	cleanupAfterCombat();
}

private function ElectraPregChance():void {
		//Get out if already pregged.
		if (pregnancy.isPregnant) return;
		var preg:Boolean = false;
		//1% chance per 100mLs of cum, max 15%
		var score:Number = Math.min(player.cumQ()/100,5);
		score += player.virilityQ() * 200;
	outputText("Electra checking virility score " + score);
		if((player.cumQ() > (score >= rand(100)) || player.hasPerk(PerkLib.PilgrimsBounty))) {
			preg = true;
		}
		if (preg) {
			pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_ELECTRA);
			sceneHunter.print("\n<b>Electra is pregnant!</b>");
		}
	}

//----------Electra Preg Stuff---------------

public function ElectraPregAnnouncement():void {
		clearOutput();
       if (ElectraTotalKidsNum == 0) {
		outputText("As you return to camp, you notice Electra sitting by your [cabin]. As she notices you, she stands. You notice, to your discomfort, she has an imp tied up at her feet. Upon further inspection, her hands are sparking, and that the imp’s cock is ramrod straight, despite the small pool of cum around him. \n\n");
		outputText("She drags the imp behind her, and as she gets closer, you notice that he’s tied up, not with rope, but with a copper cable. She sighs, annoyed, and the imp flails as blue electricity arcs down her wire, through him.  \n\n");
		outputText("You ask about her…toy, and Electra shakes her head, looking at you as if it’s your fault. \"<i>Well, for the next little while, I’m going to be producing more electricity.</i>\" She gives you a little shake of her tail, dropping the imp. \"<i>I’m…Going to be making electricity for two.</i>\"  \n\n");
		outputText("She lets the silence hang for a few seconds. \"<i>...Yeah. I’m…Pregnant.</i>\" She looks down and away, to your shock, she’s actually blushing. \"<i>Normally we Raiju don’t get pregnant. Not if we don’t want it.</i>\" Her tail wraps around herself, and she hugs it, unusually bashful. \"<i>It’s not something we…consciously control, but our bodies just seem to…know when it means more to us than release.</i>\"  \n\n");
		outputText("Electra grabs her coiled imp, releasing another bolt of electricity, before opening her arms wide. \"<i>...Look, I won’t shock you, but…Could you come here for a bit?</i>\" She’s not showing her pregnancy yet, but her feet are tilted inwards, and her fluffy tail wags behind her.  \n\n");
		outputText("You see no reason to deny her, and as you step into her arms, Electra buries her head into your [chest]. True to her word, you don’t even feel the usual sparks or hair-raising charge that usually comes with contact with your Raiju lover. Her hug is warm, the fur on her neck tickling you. After a minute or so, Electra sighs happily, releasing you.  \n\n");
        outputText("\"<i>It’s nice…Having someone who’s more than just a plug.</i>\" She looks down at her belly, a smile on her face. \"<i>...This won’t change my feelings for you.</i>\"  \n\n");
	   } else {
        if (ElectraTotalKidsNum != 0) {
		outputText("You find Electra waiting for you at the entrance to camp. She sees you, sparks flying from her claws as you approach.  \n\n");
		outputText("\"<i>Good morning</i>\" She says meekly, rubbing her belly. You know what she’s about to say. \"<i>We’re going to have more children. I…Just wanted you to know that.</i>\" You give your Raiju lover a reassuring smile and a quick hug, and she wraps her arms around you, claws digging slightly into your [back].  \n\n");
        outputText("\"<i>Feel free to join me in the charging hut.</i>\" She says with a wink, before skipping back to her part of camp, whistling a happy tune. \n\n");
		outputText(" \n\n");
	   }
doNext(playerMenu);
	}
}

public function ElectraPregProgression1():void {
		clearOutput();
		outputText("Electra isn’t showing yet, but you can feel a slight crackle in the air when you get closer to her. She’s eating more, but her fur is all standing up.  \n\n"); 
		if (ElectraTotalKidsNum != 0) {
        outputText("You notice her heading into the charging hut and she gives you a wave, blushing slightly. \"<i>Feel free to join me</i>\". She enters, winking. You decide to keep moving for now, as tempting as that offer is. \n\n"); 
		doNext(playerMenu);
		}
		else if (ElectraTotalKidsNum == 0) {
        //first time
		outputText("The poor imp has been replaced by another. You see her talking to Ralthazul, who seems to have an idea. As you get closer, you can hear their discussion. \n\n");
		outputText("\"<i>-been studying how the flow of electricity works, and I may be able to provide you a more…humane way to…release, as it were.</i>\" Electra seems interested, and Ralthazul continues. \"<i>Electricity, in its natural state, flows into the earth. I may be able to make something to allow you to discharge without the need for a…partner.</i>\"  \n\n");
		outputText("\"<i>Well…I have [name] for that.</i>\" Electra says, smiling slightly. Ralthazul seems unamused at this, but continues.  \n\n");
		outputText("\"<i>And what about your children?</i>\" Ralthazul asks. \"<i>Who’s going to deal with their ‘needs’? He frowns.  \n\n");
        outputText("\"<i>...I suppose you’re right.</i>\" Electra says. \"<i>...I’ll go hunting tomorrow, scrounge up some gems. What do you need to…make the device?</i>\" \n\n");
		outputText("Ralthazul thinks for a moment. \"<i>I need some metal scraps, rubber from those darkwood trees, the copper wiring you have on that imp, and…An imprint of something you need for…release.</i>\"  \n\n");
		outputText("Electra looks confused at that. \"<i>An…Imprint?</i>\" The old mouse looks slightly annoyed. \"<i>...In order for you to achieve…Results…With the device, you’ll want to have an…erm…Plug…That you know will work for you.</i>\" He looks over and sees you. \"<i>I’m assuming you’d have an easier time with an imprint from [name]</i>\".  \n\n");
		outputText("Electra blinks, realising what he means by an imprint. \"<i>Oh.</i>\" \n\n");
        outputText("You decide to make yourself known, and come over, telling Electra that you were just checking up on her. She zaps her imp, getting a low groan, before giving you a fuzzy hug. You ask what she’s doing with Ralthazul, and the old alchemist gives you a slight smile.  \n\n");
		outputText("\"<i>Oh, just doing a little problem-solving, my friend. With the…New Raijus on the way, the thought of how to deal with their…Emissions…Came up.</i>\" He looks at you. \"<i>I have an idea, but it requires a little…innovation, and input from you.</i>\" He holds out a container, filled with plaster. \"<i>If you would go somewhere private, and…Imprint?</i>\" As you take it and walk away, he turns his head. \"<i>It needs to be erect!</i>\" \n\n");
		outputText("You nod, and Electra brings you to your ([Cabin]). Electra looks down at your groin wistfully, rubbing her stomach. \"<i>Well…You heard the rat.</i>\" You strip, and she steps in, rubbing your [cock], letting little sparks tingle across your girth. You harden quickly, and Electra sighs in disappointment, girding your member with the liquid plaster. It’s not the most comfortable of feelings, nor the most arousing, and you feel yourself starting to soften. Electra, realising your predicament, steps in, rubbing herself against you. She leans in, kissing you on the lips, running her claws along your back, and moaning in arousal at your touch.  \n\n");
        outputText("Ten minutes pass in a blur, and Electra drops her hands to your plaster-clad [cock]. Gently, slowly, she carves a groove in the plaster, then slowly peels the mould off.  \n\n");
		outputText("Electra leaves for a moment, presumably to drop the finished mould off with Ralthzul, before coming back, hips swaying. She has a bowl of water and a cloth, and she smiles, looking down at your [cock]. You realise that some of the plaster is still there, on your [cock], and bits of it have splashed on your [legs]. \n\n");
		outputText("\"<i>Thank you for this.</i>\" Electra says. \"<i>But…There’s still some left on you.</i>\" She gets on her knees, putting the bowl in front of her. \n\n");
menu();
addButton (1, "MouthWash", ElectraCleanBJ);
addButton (2, "JustAClean", ElectraCleanNoSex);
addButton (3, "Nah", ElectraCleanYourself);
	}
}

public function ElectraPregProgression2():void {
		clearOutput();
		if (ElectraTotalKidsNum == 0) {
        //first time pregnant Electra
		outputText("You see Electra, her stomach noticeably bulging, talking to Ralthazul. Behind her, you can see a steel pole, firmly planted in the ground, with several small ‘branches’ off of them. A small mechanical device is at the base of each metal ‘branch’, and you notice Electra holding what appears to be a clear dildo with a copper wire through it…A cock you recognize.  \n\n"); 
		outputText("\"<i>-The…Model works</i>\", Electra says, a blush on her face. \"<i>And the wire seems to…erm…’plug’ properly.</i>\"  \n\n");
		outputText("\"<i>That’s wonderful news.</i>\" Ralthazul seems pleased. \"<i>So, the device will run off your own power, and provide you with a way to release your charge without the need to trouble anyone.</i>\" He grins with what you can only describe as a ‘mad scientist’ grin. \"<i>But, there is one thing you should know.</i>\"  \n\n");
		outputText("\"<i>What is that?</i>\" Electra seems confused, and Ralthazul rubs his hands together.  \n\n");
		outputText("\"<i>You’ll also be helping us around the camp.</i>\" His smile grows into something more genuine. \"<i>Using the Plasma samples you’ve kindly provided, I was able to figure out how your race stores electric energy so efficiently.</i>\" He flourishes a small, metal box. \"<i>This is my first attempt, a device that uses a similar process as your own biology to store electricity!</i>\"  \n\n");
		outputText("Electra looks even more confused at that, and he smiles, shaking his head. \"<i>No need to worry, my dear. Suffice to say that with a bit more work, both you and your children will be able to rest easy, knowing that this encampment is safer with your help.</i>\"  \n\n");
        outputText("Electra looks at the device, then around at the camp. \"<i>...Before you celebrate…Perhaps we should make…Walls? Around the thing?</i>\" She sees you, and blushes slightly. \"<i>I don’t exactly want to give everyone here a regular show…Especially the kids.</i>\"  \n\n");
		outputText("\"<i>Ah, yes. I suppose that would be a good idea.</i>\" Ralthazul says sheepishly.  \n\n");
		outputText("You approach, and Electra winces slightly, rubbing her belly. \"<i>Oh, hey.</i>\" Ralthazul nods respectfully, heading back to his part of camp. \"<i>I was just…Working with the old rat.</i>\" You see sparks fly across the surface of her stomach, and Electra winces slightly, flinching.  \n\n");
        outputText("You step in, gently rubbing her stomach, and the sparks fade. Electra takes your hand, smiling, before gently pushing you away. \"<i>Thanks for calming them down, but I’ve got some things I need to do before they get here.</i>\"  \n\n");
		outputText("You nod, putting a hand on her shoulder, and Electra nuzzles your arm affectionately. You decide to let Electra and Ralthazul have time to work out their odd...mechanical problems, heading back to camp. \n\n");
		} else if (ElectraTotalKidsNum != 0) {
		//Subsequent times
        outputText("You see Electra as she exits the \"<i>charging booth</i>\", a tired smile on her face and one hand on her clearly pregnant stomach. As you get closer, her stomach moves, and she winces as electric sparks play across her claws.  \n\n");
        outputText("\"<i>Oh, I’m okay.</i>\" She says reassuringly. \"<i>They’re just producing more electricity now that they’re more developed.</i>\" Electra opens her arms, giving you a hug that makes your [hair] stand up on end. \"<i>Hmm…</i>\" She gently grabs the back of your head, sandwiching your head between her magnificent breasts.  \n\n");
		outputText("You hug Electra back for a few moments, letting her rub her cheek against yours, before asserting that you need to leave. Electra nods, letting go, and you head back to your part of camp. \n\n");
		outputText(" \n\n");
		}
doNext(playerMenu);
}

public function ElectraPregProgression3():void {
		clearOutput();
		outputText("Electra stands in front of (first time) a small wooden building, (otherwise) the charging hut, (split end) looking up at its roof and lightning rod with more than a little nervousness. Seeing her, you walk over, wrapping an arm around her waist.  \n\n"); 
		outputText("\"<i>Oh, hey.</i>\" Electra says softly. Her belly is swollen, far more than before, and she leans on you. There’s small bags under her eyes, and you notice that she’s walking a little funny. You ask if she’s alright, and she nods, resting her chin on your shoulder.  \n\n");
		outputText("\"<i>I’ll be fine. Your kids are burning up a ton of food though</i>\", she complains. \"<i>And once they produce the electricity, I need to burn it off again.</i>\" You notice that other than her belly, Electra’s looking a bit more thin than usual. You comment that, and she nods. \"<i>Raiju tend to lose weight during pregnancy. I’ll put it back on in a few days.</i>\" She smiles a little, seeming happy at your concern. \n\n");
doNext(playerMenu);
}
public function ElectraDeliversRaijuBabies():void {
		clearOutput();
		outputText("As you walk towards camp, you notice that the otherwise clear sky is…black over your section of camp. Dark clouds rumble every so often, and you see a bolt of lightning strike the charging hut. Far fainter, you hear a woman’s cry…It’s Electra! \n\n"); 
		outputText("You rush into camp, heading straight for the charging hut. You hear Electra inside, yelping in pain, and you shoulder open the door. Inside, Electra’s panting, eyes wide as she dangles from one of the charging outlets, her ‘plug’ up her ass. Her water’s already broken, and she hisses in pain with each breath.  \n\n");
		outputText("Thankfully, she disabled the machine, but you have more pressing concerns. She looks over and sees you, but as she does, more electricity shoots out of her, up the machine and into the lightning rod. You wait, counting the seconds, and as soon as her lightning fades, you grab Electra’s shoulders, pulling her up and off the ‘plug’.  \n\n");
		outputText("You gently lay her down, then rush over to a small cabinet on the far side of the hut. You grab a towel, a rubber mat, and some water, getting Electra as comfortable as you can. Between bursts of static, you remove her kimono, get the towel under her head, and spread her legs, making sure that Electra’s comfortable. \n\n");
		outputText("\"<i>[Name]...The baby’s…Ngh…Coming.</i>\" You gently tell Electra that you know, you’re here, and that she should just focus on pushing. You grab another towel, and as you position yourself in front of Electra’s love hole, you notice the telltale sign of Electra’s arousal. Pink lightning arcs from her clit, and you narrowly avoid getting hit.  \n\n");
		outputText("\"<i>S-sorry…</i>\" Electra says weakly.  \n\n");
        outputText("It takes an hour or two of gentle coaxing, avoiding or enduring lightning strikes, and lots of water, but you eventually see a spiky-haired little head poke out from between Electra’s lips. You tell Electra to push, that she’s almost done…And as you hold out the towel, waiting for your newborn, you have to close your eyes, as a bright light emerges, blinding you. You feel a numb, burning sensation, and feel a sudden *thump* of impact as a small, soft projectile hits you in the chest… \n\n");
		outputText("You open your eyes to see green, slitted eyes staring up at you. Purple fur covers the little one’s body from head to toe, and you quickly wrap them in the towel, wiping some embryonic fluid away from their mouth.  \n\n");
        outputText("Looking back at Electra, you see her stomach flattening back down, as the last of the birthing fluid gushes out. She weakly pulls her legs together, tail limp from exhaustion. Her E-cup breasts are leaking milk, and the little one starts to cry. Gently, you help Electra into a sitting position, leaning her against the wall, and pass your little one over to her.  \n\n");
		outputText("Electra coos, taking your baby into her arms, letting them suckle. Soon, both mother and baby are asleep, snoring gently. You leave a bucket of water and a cup by her side, kissing Electra’s hand before you quietly leave the charging hut. \n\n");

	switch (rand(3)) {
  case 0:
outputText("Electra calls out to you, \"<i>[Name]...It's a beautiful girl.</i>\" You smile to yourself, going back for a moment, kissing Electra on the forehead before you leave. Mother and daughter are already asleep, exhausted from the ordeal.\n\n");
ElectraTotalKidsNum += 1;
ElectraSonsNum += 1;
    break;
  case 1:
outputText("Electra calls out to you, \"<i>[Name]...It's a boy.</i>\" You smile to yourself, going back for a moment, kissing Electra on the forehead. Your son cries out, eyes wide, and stares at you, his spiky hair already filled with static. You ruffle his hair, getting a coo from both mother and baby. You spend a few minutes with Electra before excusing yourself. \n\n");
ElectraTotalKidsNum += 1;
ElectraDaughtersNum += 1;
    break;
  case 2:
  outputText("Electra calls out to you, \"<i>[Name]...It's a Herm.</i>\" You head back to Electra, who seems a little nervous. \"<i>They'll have an easier time plugging, it's just...A little nerve-wracking.</i>\" You reassure Electra that it's alright. Hell, herms might be more common than men at this point. This doesn't really reassure her, but she reaches up, weakly taking your hand. You bring her hand to your cheek, closing your eyes and basking in her presence, before leaving her to nurse your child. \n\n");
   ElectraHermKidsNum +=1;
   ElectraTotalKidsNum += 1;
}
doNext(playerMenu);
}

private function ElectraCleanBJ():void {
		clearOutput();
		outputText("You nod, and Electra takes the bowl, gently pouring some of the warm water on your shaft, before bringing the cloth up, wiping some of the plaster off. Bit by bit, she repeats this, gently removing the grime from your glorious tool. Unbeknownst to your Raiju lover, however, you intend to use more than her hands to clean you.  \n\n"); 
		outputText("Electra frequently rubs her head against cleaned parts of you, nuzzling your length, and when she’s worked her way up to your head, you make your move. As she kisses your tip, you take her head in both hands, pushing an inch or so of your tool past Electra’s lips.  \n\n");
		outputText("She looks up at you, giving you a mischievous wink, and tightens her lips around your shaft. You push yourself in, making Electra gag slightly, but she’s still looking up at you, and gives you a thumbs-up. You need no further encouragement, and thrust your [hips] forward, pulling Electra’s head in as you sink yourself balls deep in her throat.  \n\n");
		outputText("You feel Electra’s throat tighten, and you pull back, tip at her lips, letting her breathe, before slamming yourself back in. Electra’s eyes well up, but as she gags, you can see her eyes, still looking back up at you. She’s clearly enjoying this. \n\n");
		outputText("You begin at a moderate pace, your hands gripping your Raiju lover’s hair as you throat-fuck her. Electra’s silent at first, except for the occasional wet sound of breathing when your cock leaves her airway, but as you continue, she begins moaning, sending shivers of pleasure up your shaft. Electra picks up the pace, pulling at your hands, throating your [cock] as fast as she can. \n\n");
		outputText("You get the message. Holding her head in place, you slam yourself to the base as fast as you can, ignoring Electra’s gagging.  \n\n");
        outputText("\"<i>MmM! *slurp* \"<i>MMMMM!</i>\" Electra nicks you with her teeth, sending a literal bolt of pleasure up your shaft. Despite your best efforts, your [cock] twitches, weakening your [legs] and your grip on Electra’s head. Your Raiju lover feels this, and tightens her cock-swollen throat even more, looking you in the eyes as her lips touch your [leg].  \n\n"); 
		outputText("Despite your best efforts, you groan, aching cock releasing violently.  \n\n");
		if(player.cumQ() <= 100) {
        outputText("Electra greedily gulps down your cum, slowly pulling back until only your tip remains in her mouth. She messily begins jerking you off as your orgasm slows, claws almost painful against your tender shaft. Your orgasm stops, and you feel a draining feeling as Electra keeps her lips on your tip, sucking the last drops from your urethra.  \n\n");
		outputText("She opens her mouth as you look down, lightheaded, and you notice a bit of your cum still on her tongue. Electra gives you a languid smile, then swallows.  \n\n");
		outputText("\"<i>Now THAT…Was satisfying.</i>\" Electra says, equal parts tired and content. \"<i>Good to the last drop.</i>\" She looks down at herself, then slaps you playfully on the ass. \"<i>Let’s wash up, okay?</i>\" \n\n");
		} else if(player.cumQ() <= 400) {
        //Medium Volume
		outputText("Electra greedily gulps down your cum, slowly pulling back until only your tip remains in her mouth. As your [cock] twitches, you notice her throat working, as she jerks you off with both hands, working your tool like a spigot. You notice her eyes starting to roll back, and she gags a little, but the Raiju manages to swallow it all. Electra looks up at you with glazed eyes, no small amount of your spooge still in her mouth, a bit of it trailing from her tongue as it lolls from her mouth. She pants for a few breaths, before bringing her tongue back in, and swallowing what was left. \n\n");
        outputText("\"<i>Mmm…</i>\" Electra moans, kissing your shaft. \"<i>No wonder you managed to knock me up.</i>\"  \n\n"); 
		outputText("You decide to help Electra to her feet. \"<i>...We’re even messier now.</i>\" Electra says, eyes still half-lidded. \"<i>Let’s go down to the river and clean up.</i>\"  \n\n"); 
		} else if (player.cumQ() >= 400) {
        //high volume
		outputText("Electra buries her head into you, her throat bulging as you cum. She makes a wet gurgling sound after a few seconds, pulling you out of her until only your tip remains in her mouth. Despite her clear lack of air, Electra keeps swallowing, stomach beginning to swell with your seed. She brings her hands to your shaft, keeping your orgasm going, but as her cheeks begin turning white, her eyes rolling back into her head, Electra finally gives up, gasping for air as your still twitching member fires sticky strands into her face. She’s still jerking you off, but five or so salvos in, you feel yourself start to soften, your cum drooling down her face and onto her generous tits.  \n\n");
		outputText("Electra, now looking the part of an expectant mother, falls forward at your feet, on her hands and knees, still gasping for air.  \n\n");
		outputText("\"<i>H-holy shit.</i>\" She sighs, running her cum-soaked hands through her hair. \"<i>Th-that was amazing.</i>\" You decide to let yourself join her on the ground, feeling quite a bit dizzy after losing that much fluid. \n\n");
		outputText("\"<i>Oh, yeah…</i>\" Electra notices your dizziness, and helps you to your feet. \"<i>Let’s get you washed off first, okay?</i>\" \n\n");
		} else if(player.cumQ() >= 700) {
        //VERY high volume
        outputText("Electra’s eyes widen as she feels your orgasm coming, your cum rocketing down your shaft and into her stomach. She latches on, wrapping her arms around your [legs] as her throat bulges. You feel your [legs] weaken as load after hot load rushes down her throat, and her stomach begins to noticeably grow. Electra gags, and you notice that she’s got droplets of your jizz coming out her nose. Electricity arcs off your Raiju lover, and you feel yourself tense up, barely able to move as your balls churn, dumping more and more through your [cock] and into Electra’s stomach.  \n\n");
		outputText("Her moans begin to get higher, more intense, and you notice that tears are falling down Electra’s face. Her eyes are wide open, and her pale face is losing its colour. You realise that she’s trying to pull herself off you. Stiffly, through the electricity coursing through you, you manage to take her head in both hands, helping Electra pull your shaft out of her throat. Your orgasm rolls on, and as your [cockhead] exits her mouth with a loud *pop*, you’re still cumming.  \n\n");
		outputText("Electra, barely conscious, closes one eye as your thick ropes cover that side of her face, falling backwards into a rapidly growing puddle. Trails of your hot load splatter her tits, then stomach.  \n\n");
        outputText("Now that her electricity isn’t hampering your movements, you instinctively grab your [cock], jerking yourself off as you aim your loads lower, covering Electra’s fuzzy legs and enticing entrance in your cum. Eventually, slowly, your orgasm slows, then stops, and you look down on your handiwork.  \n\n");
		outputText("On her back, unable to rise, Electra coughs, clearing some of your spooge from her lungs. Her tits bounce enticingly as she heaves, her eyes glazed over, unfocused. Barely able to stand yourself, you kneel beside her, drunkenly asking if she’s okay. \n\n");
		outputText("Electra moans, cheeks bright red, and she gives you a thumbs-up. She seems barely conscious, and you flop down beside her, suddenly very, VERY dizzy.  \n\n");
        outputText("You wake up to see a still sperm-soaked Electra sitting up, groaning slightly as she rubs her jaw. \"<i>Whoa…</i>\" She looks down at herself, almost laughing. \"<i>D-did I go to the Bazaar?</i>\" Then she sees you, and puts two and two together.  \n\n");
		outputText("\"<i>Oh…Wow. You really hosed me down, huh?</i>\" Electra says. \"<i>Let’s get down to the river, before this crusts over.</i>\" \n\n");
		}
        doNext(ElectraPregBJCleanup);
}

private function ElectraPregBJCleanup():void {
		clearOutput();
		outputText("You and Electra shakily head down to the river, getting some side-eye from your companions, but you don’t really care. Electra and you reek of sex, and as you enter the river, Electra is a surprisingly attentive bathing companion, helping you with your [hair], back and of course, paying attention to your [cock]. She brings some clean-smelling soap that she happily shares, and before long, you’re completely clean.  \n\n"); 
        if(player.cumQ() >= 100) {
		outputText("\"<i>Would you mind helping me out a bit?</i>\" Electra asks, motioning to her cum-soaked hair. You nod, and take a position just behind her. You run your hands through Electra’s hair, applying the soap, then move down to her breasts, kneading her soft skin…and as you do, you can feel your [cock] rising again, rubbing her inner thigh.  \n\n");
		outputText("You return the favour, taking the soap and running your hands along Electra’s back. You step in, pressing yourself against her, and Electra shivers slightly as you knead her breasts, rubbing her areolae. \n\n");
		}
        //split end
		outputText("\"<i>As much as I would enjoy another round…I want to stay clean for at least an hour or so.</i>\" Electra says, turning around to face you. Her suds-covered breasts press softly into your [chest], and she smiles. \"<i>Thanks for this. I wouldn’t mind doing that again sometime.</i>\"  \n\n");
		outputText("You nod, leaving your Raiju lover to finish up. You dry yourself off, redress, and head back to camp. \n\n");
		doNext(playerMenu);
}

public function ElectraCleanNoSex():void {
		clearOutput();
		outputText("You nod, and Electra takes the bowl, gently pouring some of the warm water on your shaft, before bringing the cloth up, wiping some of the plaster off. Despite the sensation, and Electra’s gentle, stimulating touch, when your shaft is clean, you redress, giving Electra a chaste kiss on the forehead, before heading back out.  \n\n"); 
doNext(playerMenu);
}

public function ElectraCleanYourself():void {
		clearOutput();
		outputText("You thank Electra for the offer, but decide to go clean yourself off on your own. Going down to the river, you clean yourself off and head back to camp.  \n\n"); 
		doNext(playerMenu);
}

	}
}