/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumable;
import classes.Scenes.Holidays;
import classes.display.SpriteDb;
import classes.internals.SaveableState;

use namespace CoC;

public class AlvinaFollower extends NPCAwareContent implements TimeAwareInterface, SaveableState
{
	public var JojoDevilPurification:int;
	public var DefeatedAlvinaFirstStage:Boolean;
	public var GaveAlvinaFafnirTear:Boolean;
	public var GaveAlvinaFlowers:Boolean;
	public var GaveAlvinaChocolate:Boolean;
	public var GaveAlvinaMrPaw:Boolean;
	public var GaveAlvinaWand:Boolean;
	public var MetAlvinaAtBar:Boolean;
	public var GiftCooldown:int;
	public var WandCooldown:int;
	public var DateFailed:Boolean;
	public var FirstDateSuccess:Boolean;
	public var SecondDateSuccess:Boolean;
	public var FightForAlvina:Boolean;
	public var AlvinaFightingToCorruptYou:Boolean;
	public var AlvinaDied:Boolean;
	public var AlvinaPurified:Boolean;
	public var AlvinaInfernalOilAsked:Boolean;
	public var AlvinaInfernalOilCooldown:int;
	public var AlvinaGaveScroll:Boolean;

	public function stateObjectName():String {
		return "AlvinaFollower";
	}
	public function resetState():void {
		JojoDevilPurification = 0;
		DefeatedAlvinaFirstStage = false;
		GaveAlvinaFafnirTear = false;
		GaveAlvinaFlowers = false;
		GaveAlvinaChocolate = false;
		GaveAlvinaMrPaw = false;
		GaveAlvinaWand = false;
		MetAlvinaAtBar = false;
		GiftCooldown = 0;
		WandCooldown = 0;
		DateFailed = false;
		FirstDateSuccess = false;
		SecondDateSuccess = false;
		FightForAlvina = false;
		AlvinaFightingToCorruptYou = false;
		AlvinaDied = false;
		AlvinaPurified = false;
		AlvinaInfernalOilAsked = false;
		AlvinaInfernalOilCooldown = 0;
		AlvinaGaveScroll = false;
	}

	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o) {
			JojoDevilPurification = valueOr(o["JojoDevilPurification"], 0);
			DefeatedAlvinaFirstStage = valueOr(o["DefeatedAlvinaFirstStage"], false);
			GaveAlvinaFafnirTear = valueOr(o["GaveAlvinaFafnirTear"], false);
			GaveAlvinaFlowers = valueOr(o["GaveAlvinaFlowers"], false);
			GaveAlvinaChocolate = valueOr(o["GaveAlvinaChocolate"], false);
			GaveAlvinaMrPaw = valueOr(o["GaveAlvinaMrPaw"], false);
			GaveAlvinaWand = valueOr(o["GaveAlvinaWand"],false);
			MetAlvinaAtBar = valueOr(o["MetAlvinaAtBar"], false);
			GiftCooldown = valueOr(o["GiftCooldown"], 0);
			WandCooldown = valueOr(o["WandCooldown"], 0);
			DateFailed = valueOr(o["DateFailed"], false);
			FirstDateSuccess = valueOr(o["FirstDateSuccess"], false);
			SecondDateSuccess = valueOr(o["SecondDateSuccess"], false);
			FightForAlvina = valueOr(o["FightForAlvina"], false);
			AlvinaFightingToCorruptYou = valueOr(o["AlvinaFightingToCorruptYou"], false);
			AlvinaDied = valueOr(o["AlvinaDied"], false);
			AlvinaPurified = valueOr(o["AlvinaPurified"], false);
			AlvinaInfernalOilAsked = valueOr(o["AlvinaInfernalOilAsked"], false);
			AlvinaInfernalOilCooldown = valueOr(o["AlvinaInfernalOilCooldown"], 0);
			AlvinaGaveScroll = valueOr(o["AlvinaGaveScroll"],false);
		} else resetState();
	}

	public function saveToObject():Object {
		return {
			"JojoDevilPurification": JojoDevilPurification,
			"DefeatedAlvinaFirstStage": DefeatedAlvinaFirstStage,
			"GaveAlvinaFafnirTear": GaveAlvinaFafnirTear,
			"GaveAlvinaFlowers": GaveAlvinaFlowers,
			"GaveAlvinaChocolate": GaveAlvinaChocolate,
			"GaveAlvinaMrPaw": GaveAlvinaMrPaw,
			"GaveAlvinaWand": GaveAlvinaWand,
			"MetAlvinaAtBar": MetAlvinaAtBar,
			"GiftCooldown": GiftCooldown,
			"WandCooldown": WandCooldown,
			"DateFailed": DateFailed,
			"FirstDateSuccess": FirstDateSuccess,
			"SecondDateSuccess": SecondDateSuccess,
			"FightForAlvina": FightForAlvina,
			"AlvinaFightingToCorruptYou": AlvinaFightingToCorruptYou,
			"AlvinaDied" : AlvinaDied,
			"AlvinaPurified": AlvinaPurified,
			"AlvinaInfernalOilAsked": AlvinaInfernalOilAsked,
			"AlvinaInfernalOilCooldown": AlvinaInfernalOilCooldown,
			"AlvinaGaveScroll": AlvinaGaveScroll
		}
	}

	public function timeChange():Boolean {
		if (time.hours == 6){
			if (GiftCooldown > 0) GiftCooldown--;
			if (WandCooldown > 0) WandCooldown--;
			if (AlvinaInfernalOilCooldown > 0) AlvinaInfernalOilCooldown--;
		}
		return false;
	}

	public function timeChangeLarge():Boolean {
		return false;
	}

	public function AlvinaFollower() {
		EventParser.timeAwareClassAdd(this);
		Saves.registerSaveableState(this);
	}

//ALVINA_FOLLOWER [2684] flag states
// 1: Met first time during explore
// 2~8: days since factory cleared
// 9: Met second time on Mountain
// 10: Second time BonusEncounter
// 11: Knows about Alvina cave dungeon
// 12: Alvina kiled
// 13~16: At camp; CanTrain
// 16: Can Confess
// 17: Confessed; Can Encounter Quest chimera in EbonLab
// 18: Defeat Chimera in EbonLab; Can Confess again
// 19: Lover status
// 20: Made Love; Can Propose
// 21: Married

public function alvinaFirstEncounter():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
	clearOutput();
	outputText("Along your travels, you meet a woman in robes with black hair. You expected to find at least a few humans in Mareth, if nothing else, the previous champions, so to find another human in this realm is a relief. You ask if she could give you directions, as you have no idea what to expect in this realm. As a champion, your job is to fight the demons, but you can’t fight them if you have no idea where to look.\n\n");
	outputText("\"<i>Directions and demons, hm? There are many places you could visit. If I were you, I would go to the lake and look for a peculiar island at its center. That said, be respectful of whomever you meet there.</i>\"\n\n");
	outputText("You nod and prepare to leave, but ask her who she is in case you should ever see her again.\n\n");
	outputText("\"<i>Me? I am a person of no consequence.</i>\"\n\n");
	outputText("As you turn back to question her, you notice that she's vanished without a trace. You're not sure whether to be relieved...or concerned by this.\n\n");
	flags[kFLAGS.ALVINA_FOLLOWER] = 1;
	endEncounter();
}

public function alvinaSecondEncounter():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
	clearOutput();
	outputText("As you pass by the road you spot the woman from before sitting on a nearby wooden log. You sit right next to her, and she closes her book in response. You thank her for the information regarding Marae’s whereabouts");
	if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) outputText(" though it ended in disaster, thanks to your actions");
	outputText(". That said you are still looking for ways to fight the demons.\n\n");
	outputText("\"<i>Fighting the demons? Well... You could try and find their leader’s fortress on your own, however, how do you plan to find a demon willing to risk everything to betray the mastermind above?</i>\"\n\n");
	outputText("You admit that you have no idea.\n\n");
	outputText("\"<i>There is a demon lair located somewhere in the deep woods ran by a greater imp who apparently lost the demon queen’s favor. Perhaps you could coax him into divulging the information you seek. Oh, and you should know my name is Alvina. It’s a pleasure to formally meet you.</i>\"\n\n");
	outputText("On those words, she picks up her book and adjusts her glasses, as she resumes reading. You could talk to her and perhaps get some information from her about the place, she seems very knowledgeable.\n\n");
	flags[kFLAGS.ALVINA_FOLLOWER] = 9;
	menu();
	addButton(0, "Talk", alvinaSecondEncounterTalk);
	addButton(4, "Leave", explorer.done);
}
public function alvinaSecondEncounterTalk():void
{
	clearOutput();
	outputText("Alvina lowers her book to look at you for a moment, adjusting her glasses in front of her embery eyes.\n\n");
	outputText("\"<i>Still want to know more, do you? Sure, I can share the knowledge but be quick with your queries, I still have a book to read.</i>\"\n\n");
	menu();
	addButton(0, "Her", alvinaSecondEncounterTalkHer, alvinaSecondEncounterTalk);
	addButton(1, "Hobby", alvinaSecondEncounterTalkHobby, alvinaSecondEncounterTalk);
	addButton(4, "Leave", explorer.done);
}
public function alvinaSecondEncounterTalkHer(next:Function):void
{
	clearOutput();
	outputText("So, who is she exactly? Is she native to Mareth?\n\n");
	outputText("\"<i>I know what you’re thinking, a human on Mareth is something next to nobody sees. There are other humans across the world. I hear the hidden city Tel'adre has several true humans. I myself am a breakaway from the sand witch coven. I didn’t like the weird turn in the practice of late, so I left and used some hummus to properly revert any possible changes.</i>\"\n\n");
	outputText("Well, that explains a lot. So she was born with two set of breasts and a second vagina?\n\n");
	outputText("\"<i>You could say it like that, yes, though I had these traits corrected since.</i>\"\n\n");
	if (player.inte > 150) outputText("There’s something she’s not telling you, likely it being related to her relation with the sand witches. She probably left in very bad terms. Regardless, you find it more prudent to talk about something else.\n\n");
	doNext(next);
}
public function alvinaSecondEncounterTalkHobby(next:Function):void
{
	clearOutput();
	outputText("Those books she reads look very interesting, what language is that? You can’t understand a single word of it save for a few letters.\n\n");
	outputText("\"<i>These are advanced arcanic texts meant for the adept only. If you were better at magic, perhaps you would understand the symbols and patterns in them. You may think you have mastered spellcasting after your first whitefire, but magic is way more complicated than that. To most students, it takes years to achieve true mastery. Perhaps if you try hard enough, someday I will teach you.</i>\"\n\n");
	outputText("That’s something you will have to consider, for now, you decide to change the subject.\n\n");
	doNext(next);
}

public function alvinaSecondBonusEncounter():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
	clearOutput();
	outputText("As you explore Mareth you come again upon Alvina. Her back is facing you as she gazes to the horizon beyond.\n\n");
	outputText("\"<i>I overheard that you defeated Queen Lethice... Most impressive, champion of Ingnam.</i>\"\n\n");
	outputText("You awkwardly reply that you only did your duty, really.\n\n");
	outputText("\"<i>Is that so? Even then, what keeps you on Mareth still? Shouldn’t you have gone back to your homeland already? Perhaps it is something else that you seek. Regardless, if purging Mareth of the remaining corruption is your goal, you should go to the blight ridge. The area is dangerous and filled with demons, but surely the bane of Lethice should be able to get by without any issues?</i>\"\n\n");
	outputText("She chuckles as a gust of wind throws dust at you, causing you to shield your eyes. The moment you look back at her, she is gone.\n\n");
	flags[kFLAGS.ALVINA_FOLLOWER] = 10;
	endEncounter();
}

public function alvinaThirdEncounter():void
{
	clearOutput();
	outputText("As you wander the blight ridges, you stumble upon what looks to be a cave. Bright purple lights flash in its depths and various magical runes are etched onto the entrance. Do you dare enter? It looks like whatever lies in this cave is extremely dangerous.\n\n");
	if (SecondDateSuccess) outputText("You have a feeling Marae's Pure Pearl could be useful here.")
	menu();
	addButton(0, "No", alvinaThirdEncounterNo);
	addButton(4, "Yes", alvinaThirdEncounterYes);
}
public function alvinaThirdEncounterNo():void
{
	outputText("This is a very bad place, better not linger here. You decide to head back to camp.\n\n");
	flags[kFLAGS.ALVINA_FOLLOWER] = 11;
	endEncounter();
}
public function alvinaThirdEncounterYes():void
{
	clearOutput();
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
	outputText("Against your better judgment, you enter the cave. You proceed down into the depths, getting ever closer to the source of the lights.\n\nYou finally reach a large room filled with what looks to be various magical implements. ");
	outputText("This is clearly the laboratory of a wizard and not the good kind. Pentagrams are etched everywhere. There's clearly humanoid bones on a table, and the room itself is decorated with quite a few Lethicite crystals -- proof of its owner's fiendish successes. You turn to leave the room, having seen more than enough, when you bump into a wall that wasn’t there earlier.\n\n");
	outputText("\"<i>Leaving so soon [name]? I didn’t give you permission yet.</i>\"\n\n");
	outputText("At the other side of the laboratory stands Alvina. She's smiling under her hood.\n\n");
	outputText("\"<i>I see you finally made it here [name], you did… An excellent job. I can only applaud your competence. </i>");
	if (flags[kFLAGS.DEFEATED_ZETAZ] > 0) {
		outputText("<i>Though you had no idea that I set you on this path on purpose all along, did you? You could have gone anywhere, or got defeated by a random fiend and lost yourself, but you gladly acted like a perfect pawn and did everything just as I had planned, shuting down the factory and</i>");
		if (flags[kFLAGS.MET_MARAE_CORRUPTED] > 0) {
			outputText("<i> corrupted Marae into a demon.</i>");
		}
		else
		{
			outputText("<i> saved that stupid tree god bitch</i>");
		}
		outputText("<i> setting up the stage for my plans.</i>");
	}
	if (flags[kFLAGS.LETHICE_DEFEATED] > 0) outputText("<i>You even defeated Lethice for me, which I will admit is highly convenient. She was way too hardheaded for me to properly redirect as I pleased.</i>");
	outputText("\"");
	doNext(alvinaThirdEncounterYesContinue);
}
public function alvinaThirdEncounterYesContinue():void
{
	clearOutput();
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	outputText("The woman laughs, her chuckling slowly turning increasingly youthful as she shrinks in size. The tall hooded woman is gone, replaced by a small demoness that stands before you. She doesn’t sport the usual features of a succubus, but is clearly a demon nonetheless. Her body looks mostly human in shape, save for her large hooves and furry clawed hands. A pair of demonic wings spread from ");
	outputText("between her shoulders, hidden by her long abyssal black hair. A goat's tail adorns her backside, and her horns curve backwards - just like a goat. She looks like some kind of demon despite the odd mix. Her subtle A cup breasts fit her 4 and a half feet tall body perfectly, although you would expect a succubus to have at least an E cup. Her eyes don’t exactly look like those of most succubi either, ");
	outputText("as they shine with an inner malice even other demons might find disturbing. Her black sclera and glowing fiendish ember iris only making the intimidating appearance worse. She wears a pair of glasses and a somewhat revealing armor, which is unusual considering most demons prefer to wander around naked.\n\n");
	outputText("\"<i>So… Done sizing up my perfect features? Sorry to disappoint, but if you thought I was human, that was a lie all along. In truth, I have stopped being human for several decades. Now, less about me and more about you. ");
	if (!player.hasPerk(PerkLib.Phylactery)) outputText("I’m amazed a being still carrying a soul would achieve what you did. ");
	outputText("Your prowess thus far have more than earned my interest. Perhaps you were just lucky... Or perhaps, like me, you are destined to a greater calling. Regardless, you served my goals well until now and I am highly interested in seeing what else you can accomplish.</i>\"\n\n");
	outputText("A greater calling? Like what?\n\n");
	outputText("\"<i>Power, pure and simple. You desire power, and to further increase it, the only proper path is to beseech those that possess it. Most academics seek to obtain true mastery of magic, although most are not willing to sacrifice everything for their study. After many years of researching forbidden knowledge, performing tedious experiments and depraved rituals, I came to one conclusion: ");
	outputText("The demons came very close to harnessing true power but ultimately failed, turning into insatiable creatures unable to satisfy their endless thirst for souls and sex, in the end, they lack a soul entirely. To achieve perfection and immortality one needs their soul to be attached to its body so to… Regardless, this is nothing you should concern yourself with yet.</i>\"\n\n");
	outputText("Ok, so why does it matter? It’s not like you have anything to do with this right?\n\n");
	outputText("\"<i>On the contrary, you coming here is no hazard. You seek forbidden knowledge and I, Alvina Shadowmantle, founder of what is today black magic seek someone to impart it… For a price. So how about joining me and becoming my apprentice? You have proven to be way more than a mere pawn, so surely you are worthy of my time.</i>\"\n\n");
	camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_DEVIL);
	menu();
	if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] >= 4) addButtonDisabled(0, "Sure", "There's no way you would be able to have HER in your camp at the same time as Siegweird. He'd kill her or she'd kill him.");
	else addButton(0, "Sure", alvinaThirdEncounterYesSure);
	if (SecondDateSuccess) addButton(3, "Stop It!", alvinaDontFight);
	addButton(4, "Never", alvinaThirdEncounterYesNever);
}
public function alvinaThirdEncounterYesSure():void
{
	clearOutput();
	outputText("Learning black magic straight from the source? Where's the dark contract so you can sign it!? You shake hands with Alvina right away, sealing the deal.\n\n");
	outputText("\"<i>Excellent. I will pack up my things then head out for that place you call your camp. Just give me a second.</i>\"\n\n");
	outputText("Alvina gets a bag out and raises a hand. All of her tools and instruments fly into the bag, which keeps the same size despite the volume of things moving into it. Once everything is packed up, she looks back at you, smiling.\n\n");
	outputText("\"<i>Well, let us be on our way… You have a lot to learn, and staying here won’t help your studies.</i>\"\n\n");
	outputText("You head back to camp, Alvina following you.\n\n");
	outputText("<b>Alvina has joined you as a follower.</b>\n\n");
	flags[kFLAGS.ALVINA_FOLLOWER] = 13;
	flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 3;
	explorer.stopExploring();
	doNext(camp.returnToCampUseOneHour);
}
public function alvinaThirdEncounterYesNever():void
{
	clearOutput();
	if (player.statusEffectv1(StatusEffects.SiegweirdTraining2) == 2) outputText("You're here to kill this witch. There is no way you’d ever accept her offer. ");
	outputText("The demonic goat girl laughs.\n\n");
	outputText("\"<i>How amusing, I didn’t think you had the willpower to deny my gracious offer. I imagine you expect I will simply let you go? Well that’s too bad… You see, while an apprentice would have been a useful pawn, willing subjects are on shortage these days.  I’m afraid you aren’t going anywhere.</i>\"\n\n");
	outputText("You charge at the girl, " + (player.isFistOrFistWeapon() ? "and try to punch her in the face. However, she catches your fist in her paw, blocking your blow with disheartening ease" : "and attempt to strike her with your [weapon], but Alvina proves stronger than you, catching and holding your [weapon] in place with only two fingers") + ". Or is she? ");
	outputText("While Alvina holds your weapon, you see from the corner of your eye that a second Alvina is behind you, sitting casually in a chair and observing you, like a cat observing a mouse. When you look back, you realize your weapon is no longer being held. Did she just not only block your blow but also make a fool of you all along using illusory magic? ");
	outputText("She smirks, walking up to you, and brings her paw to your face. She then brutally sends you flying away to the nearest wall with but a flick of her finger.\n\n");
	player.HP -= player.maxHP() * 0.01;
	outputText("\"<i>Is that all you’ve got? I expected better.</i>\"\n\n");
	outputText("She adjusts her glasses and retrieves a large scythe from a nearby table, slowly moving towards you. You feel a massive amount of magical energy gather around her. She smiles confidently, the very space around her seems to distort with the sheer amount of energy she’s releasing. She is not like the opponents you faced before, the difference in power is worlds apart!\n\n");
	outputText("\"<i>Tell me ‘Hero’… How does fear taste?</i>\"\n\n");
	startCombat(new Alvina());
}
public function alvinaThirdEncounterYesNeverWon():void
{
    clearOutput();
	if (!DefeatedAlvinaFirstStage) {
		outputText("This is a battle you cannot win. This woman is likely stronger than Lethice herself, and sports godlike power you have no chance to stand against! As you look for a possible way to flee, you notice a detail that has escaped your attention up till now. While Alvina has not taken even a single apparent wound, ");
		outputText("she has been actively protecting a crystalline pendant around her neck. Alvina suddenly looks worried, realizing that you are staring at her necklace.\n\n");
		outputText("\"<i>Hey, why are you looking at my breasts you idiot?! Look me in the face before you die!</i>\"\n\n");
		//outputText("That does it, she definitely is afraid. In a desperate last attempt, you strike at the succubus one final time, striking directly at the pendant hanging from her neck. Alvina screams in horror as the crystal shatters.\n\n");
		//outputText("\"<i>My phylactery! No! What have you done to my phylactery!!!!!</i>\"\n\n");
		//outputText("Her body starts to bloat as the immense powers she used to control overwhelms her. Alvina makes one last anguished scream before exploding in a conflagration of arcane magic before being reduced to nothing more than ashes.\n\n");
		//outputText("You turn your eyes away, nauseated at the scene… This is what happens to those who play with forbidden powers, quite a fitting end. You leave the cave feeling like you have rid Mareth of a powerful villain.\n\n");
		outputText("Alvina smiles dejectfully.\n\n");
		outputText("\"<i>So you figured it out [Name], just as expected of the [man] I'd choose for a pupil, you have great insight. Sure I'm absolutely immortal and cannot die or be defeated by anything short of someone damaging this pendant, however since the charade is over...</i>\"\n\n");
		outputText("She weaves a sign enveloping her pendant inside a shield of magical energy.\n\n");
		outputText("\"<i>I normally wouldn't go through such obvious measures to protect my phylactery, opting for more subtle magical wards against accidental areas of effects, as this would just reveal its position to anyone with a keen enough mind but you… you are no god [name]. I've killed and drank a deity once already and there is no way you could pack that kind of power. With my phylactery out of harm's way now, how exactly do you plan on winning you poor fool?</i>\"\n\n");
		outputText("Alvina mocks you but the truth is laid bare before you, she's afraid. For the first time since this being acquired her pseudo immortality she got matched with someone who figured her out and CAN win. YOU are dangerous and she acknowledges it. With renewed resolve you ready for battle taking aim at the demoness guarded weak point.");
		DefeatedAlvinaFirstStage = true;
		startCombat(new Alvina());
	}

	else if (FightForAlvina) alvinaDontFightWon();
	else if (player.level == 185) {
		outputText("Alvina backs away terrified as you beat on her, attack after attack unleashing powers not meant to be used by mortals hand against the confused archdemon who in panic replies.\n\n");
		outputText("\"<i>Who are you… WHAT are you?! These are no abilities a simple mortal should ever be able to wear just what is this monstrous power! This is ridiculous, completely absurd! I am stronger than a god. I should be able to topple a little insect like you with ease so why...WHY AM I LOSING?!</i>\"\n\n");
		outputText("With one more attack you send Alvina flying across the room. She tries to reply with a spell of her own but it fizzles right out when striking you with little effect. Now you tower over the demoness' helpless form as she stares at you in confusion and terror, a feeling she clearly was not meant to ever have again.\n\n");
		outputText("\"<i>Your body… it might even hold the key!? Was I wrong all along? [name] take pity on me. I have no idea how you attained such ridiculous powers but I'm knowledgeable and skilled, surely you could see a use for that amongst your servants! Yes I'm willing to serve you of all people, there's no way I can die when I'm so close to finishing my research, the god of that damn blasted universe depends on it!</i>\"\n\n");
		addButton(0, "Put her out of her misery", alvinaThirdEncounterPutHerOutOfHerMisery);
		addButton(4, "Take Her", alvinaThirdEncounterTakeHer);
	}
	else {
		outputText("In a desperate last attempt, you aim at the succubus shield one final time, striking directly at the pendant hanging from her neck and causing the mana shield protecting it to explode, your hit going through and reaching the pendant. Alvina stares in disbelief then acceptance as the crystal shatters. She desperately tries to hold the shards of the pendant together in a last ditch to preserve her now fleeting life.\n\n");
		outputText("“<i>Checkmates uh… I guess that's just what I deserve for all the things I've done... tsk some justice this world has. Mother... Dad... I'm coming home at last.\"</i>\n\n");
		outputText("Her shape starts to bloat with light as the immense powers she used to control overwhelms her. Alvina seems to silently accept death before exploding in a conflagration of arcane magic turning to ashes.\n\n");
		outputText("You turn your eyes away, nauseated at the scene… This is what happens to those who play with forbidden powers, quite a fitting end. You prepare to leave the cave feeling like you have rid Mareth of a powerful villain but before you do you grab the shattered remains of Alvina phylactery with you. Someone is bound to know what to do with this.\n\n");
		explorer.stopExploring();
		alvinaDies(camp.returnToCampUseSixHours);
	}
}
private function alvinaDies(next:Function):void {
	outputText("\n<b>Found Alvina's Shattered Phylactery</b>\n\n");
	player.createKeyItem("Alvina's Shattered Phylactery", 0, 0, 0, 0);
	flags[kFLAGS.ALVINA_FOLLOWER] = 12;
	AlvinaDied = true;
	awardAchievement("The end and the beginning", kACHIEVEMENTS.GENERAL_THE_END_AND_THE_BEGINNING);
	if (flags[kFLAGS.GAME_DIFFICULTY] >= 4)
		awardAchievement("Beyond gods and mortals", kACHIEVEMENTS.GENERAL_BEYOND_GODS_AND_MORTALS);
	if (flags[kFLAGS.GAME_DIFFICULTY] >= 2)
		inventory.takeItem(weapons.ATWINSCY, next);
	else doNext(next);
}
public function alvinaThirdEncounterYesNeverLost():void
{
	clearOutput();
	if (AlvinaFightingToCorruptYou) {
		outputText("You wake up with Alvina towering over you.[pg]");
		outputText("\"<i>You are really hopeless aren't you… it's fine I'll fix your mess for you this one time, but don't do that ever again or I will end you.</i>\"");
		outputText("Forcefully taking your phylactery into her clawed grasp, she pours a torrent of corruption into you straight through your soul. The effect is instantanious, stripping you of your defiance, with the added effect of healing the scar left by the artifact in the purification ritual.[pg]");
		outputText("\"<i>You don't need purity, moral conduct or a sense of justice concieved by others, all you need is me, [name].</i>\"[pg]");
		outputText("And you guess she's right, and she always was. As such you take the decision not to disappoint her again.");
		player.removeStatusEffect(StatusEffects.DevilPurificationScar);
		player.dynStats("cor", 100);
		explorer.stopExploring();
		doNext(camp.returnToCampUseEightHours);
	}
	outputText("You wake up, somewhat horny, in the middle of the blight ridge.\n\n");
	outputText("It would seem Alvina already took the liberty of disposing of your soul. All in all, she was quite merciful to only turn you into a demon and not rip you apart or worse, turn you into a lab rat. Well, at least you're still alive and well, right? You proceed to spend the rest of your life in the same way most demons do, ");
	outputText("heading back to the portal to start collecting slaves, beginning with the next Champion, to amass power and eventually claim revenge. After many years of harvest, your power rises up to rival Alvina's own and you challenge her again. Whether you won or lost, however, was and will never be known to anyone.\n\n");
	EventParser.gameOver();
}
public function alvinaThirdEncounterYesNeverLostNightmare():void
{
	outputText("You watch Alvina casually stroll over to you, her scythe sliding on the ground like an executioner’s axe as she readies the final blow.\n\n");
	outputText("“<i>Such a pity… you held so much promise but you had to squander it all and for what? False ideals? Some half hearted promise to a town of idiots who readily abandoned you?</i>”\n\n");
	outputText("You see a brief flash of steel before everything goes black mixed with red.\n\n");
	outputText("When you wake up you realize you are in a brighter place where winged people casually stroll about. Stranger even is how you never hunger, suffer or simply get horny anymore. You decide to sit on one of those weird cloud-like mats and take a nap, it’s not like you have any idea where the heck you are, you just don’t care.\n\n");
	outputText("Mareth seems to be a distant place now that you look at it and this is way too much of a pleasant area to leave… Perhaps you simply can’t.\n\n");
	EventParser.gameOver();

}
public function alvinaThirdEncounterPutHerOutOfHerMisery():void
{
	outputText("With one decisive strike you stomp on Alvina's chest causing the pendant at her neck to crack and break into so many shards of purple crystals. Alvina's body, as if unable to sustain further damage, simply explodes into a shower of ashes and embers. You prepare to leave the cave feeling like you have rid Mareth of a powerful villain but before you do you grab the shattered remains of Alvina phylactery with you. Someone is bound to know what to do with this.");
	explorer.stopExploring();
	alvinaDies(camp.returnToCampUseSixHours);
}
public function alvinaThirdEncounterTakeHer():void
{
	outputText("CURRENT PATH DOES NOT EXIST\n\nSo you kill her instead... Such is the injustice of the world.\n\nIn future wil unlock a variant of Alvina that is sub to PC.");
	doNext(alvinaThirdEncounterPutHerOutOfHerMisery);
}

	//Bar enconuter scenes
	public function alvinaCanMeetAtBar():Boolean {
		return GiftCooldown <= 0 && !DateFailed && !SecondDateSuccess && flags[kFLAGS.ALVINA_FOLLOWER] >= 1 && flags[kFLAGS.ALVINA_FOLLOWER] < 13 && !AlvinaDied;
	}
	public function alvinaOnGiftCooldown():Boolean {
		return (GiftCooldown > 0);
	}
	public function alvinaGiftCooldownDescription():void {
		outputText("\n\nYou wonder why Alvina ran out of the bar like she did and when you will see her again.")
	}
	public function alvinaWaitingAtRavine():Boolean {
		return SecondDateSuccess && !AlvinaPurified && flags[kFLAGS.ALVINA_FOLLOWER] == 12;
	}
	public function alvinaWaitingAtRavineDescription():void {
		outputText("\n\nAlvina told you to find her at the Defiled Ravine, you suppose that means the end of her meeting you here at the bar.")
	}
	public function alvinaBarDescription():void {
		if (!MetAlvinaAtBar) outputText("\n\nA tall but slim figure in a hooded robe sits by the bar reading a book while nursing a mug of ale.");
		else outputText("\n\nYou spot Alvina sitting by the bar in her usual robes, reading a book as usual while nursing a mug of ale.");
	}
	public function alvinaMeetAtBar():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		if (!MetAlvinaAtBar){
			MetAlvinaAtBar = true;
			outputText("You approach the cloaked figure and recognise her from before. It's Alvina the wanderer you met out in the wild. She is currently busy reading a book but is swift to acknowledge your presence when you sit right next to her. Adjusting her glasses and turning her green gaze toward you with an amused smile.[pg]");
			outputText("\"<i>Oh you again? I did half expect you to find your way here but it is a nice surprise. So tell me how is your adventuring going?</i>\"[pg]");
			outputText("You provide Alvina with all the details of your recent exploration.[pg]");
			outputText("\"<i>Not bad, you might just make it out there. So [name], anything I can do for you today?</i>\"[pg]");
		}
		else
			outputText("You sit right next to her, and she closes her book in response, turning to you.\n\n");
		if (gaveAnyPresent()) outputText("\"<i>Ah [name], how nice to see you. ");
		else outputText("\"Ah [name], a welcome sight indeed. ");
		outputText("What can I do for you today?</i>\"\n\n");

		if (GaveAlvinaWand && WandCooldown == 0)
			alvinaGiveWandBack();

		function gaveAnyPresent():Boolean { return GaveAlvinaFlowers || GaveAlvinaFafnirTear || GaveAlvinaChocolate || GaveAlvinaMrPaw || GaveAlvinaWand; }

		menu();
		addButton(0, "Talk", alvinaSecondEncounterTalk);
		addButton(1, "Gift", alvinaBarGiftOptions);
		if (gaveAllPresents() && !DateFailed && !FirstDateSuccess)
			addButton(1, "Date", alvinaDate);
		if (FirstDateSuccess && flags[kFLAGS.LETHICE_DEFEATED] > 0)
			addButton(1, "Date", alvinaSecondDate);
		function gaveAllPresents():Boolean { return GaveAlvinaFafnirTear && GaveAlvinaChocolate && GaveAlvinaMrPaw && GaveAlvinaWand && WandCooldown < 0; }
		addButton(14, "Leave", telAdre.telAdreMenu);

	}
	public function alvinaBarGiftOptions():void {
		menu();
		//if has Fafnir Tear
		if (!GaveAlvinaFafnirTear && hasFlowers())
				addButton(0, "Give Flower", alvinaGiveAFlower).disableIf(!hasFlowers(), "You might want to give her a flower");
		if (!GaveAlvinaChocolate && player.hasItem(consumables.CHOCBOX))
			addButton(1, "Give Chocolate", alvinaGiveChocolate).disableIf(!player.hasItem(consumables.CHOCBOX), "You want to give her something sweet, maybe those Phouka in the bog might have something?");
		if (!GaveAlvinaMrPaw && player.hasItem(useables.TEDDY))
			addButton(2, "Give MrPaw", alvinaGiveMrPaw).disableIf(!player.hasItem(useables.TEDDY), "You need a gift to give to her, maybe check the Oddities shop?", "???");
		if (!GaveAlvinaWand && player.hasItem(weapons.O_WAND))
			addButton(3, "Give Wand", alvinaGiveWand).disableIf(!player.hasItem(weapons.O_WAND), "You need a gift to give to her, maybe check the Oddities shop?", "???");
		addButton(4, "Back", alvinaMeetAtBar);

		function hasFlowers():Boolean {
			return player.hasItem(consumables.F_TEAR) || player.hasItem(consumables.DRAKHRT) || player.hasItem(consumables.STRFLOW) || player.hasItem(consumables.SNAKEBANE);
		}
		}

	public function alvinaGiveAFlower():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		var flowers:Array = [];
		if (player.hasItem(consumables.F_TEAR)) flowers.push(consumables.F_TEAR)
		else {
			if (player.hasItem(consumables.DRAKHRT)) flowers.push(consumables.DRAKHRT)
			if (player.hasItem(consumables.STRFLOW)) flowers.push(consumables.STRFLOW)
			if (player.hasItem(consumables.SNAKEBANE)) flowers.push(consumables.SNAKEBANE)
		}
		var flower:Consumable = randomChoice(flowers);
		outputText("You open your inventory and pull "+flower.longName+" out. It's still in perfect condition just the same as when it was picked up. Would you like to offer the flower to Alvina?");

		menu();
		if (flower.shortName == consumables.F_TEAR.shortName) addButton(0, "Yes", alvinaGiveFafnirTear);
		else addButton(0, "Yes", alvinaGiveFlower, flower);
		addButton(1, "No", alvinaMeetAtBar);
	}
	public function alvinaGiveFafnirTear():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		outputText("Alvina eyes grows wide as she stares at the flower, her hand shaking for a second before she gently takes the offered flowers with utmost care as if afraid her mere touch might damage the petals. Her eyes betray her distress.\n\n");
		outputText("\"<i>Those are my mom's favorites! She used to grow them in a garden behind our house, that was until…</i>\"\n\n");
		outputText("Alvina slowly recollects herself, it's as if for a moment she was about to cry and now she was perfectly fine.\n\n");
		outputText("\"<i>Thank you for bringing me this. I will keep it safe at home.</i>\"\n\n");
		outputText("You note from the sound of it, her mother must've been a very important person to her.\n\n");
		outputText("\"<i>My mother and my father were the world to me. Sadly they passed on early in my life due to illness leaving me alone to fend for and raise my little sister, well at least until I attended school.</i>\"\n\n");
		outputText("That is very unfortunate, you apologize if it brought back painful memories.\n\n");
		outputText("\"<i>No it's fine I just thought I had left all of that far behind me. Once you've fought as long as I have you begin to forget what it is you fought for in the first place. You'd do well, champion of Ingnam, to never forget why and what you fight for lest you take a wrong turn. Still as much as it pains me to remember her, I'm glad that I did.</i>\"\n\n");
		outputText("Suddenly Alvina falls off to the ground near her stool as if in pain holding a hand firmly to her chest. You ask her if she's going to be okay.\n\n");
		outputText("\"<i>It's fine… it's an old illness of mine… shows up once in a while I can take care of myself but for now I have to go.</i>\"\n\n");
		outputText("She makes a beeline for the bar exit door and leaves you alone to your own thoughts.");
		player.destroyItems(consumables.F_TEAR, 1);
		GaveAlvinaFafnirTear = true;
		GiftCooldown = 7;
		endEncounter();
	}
	public function alvinaGiveFlower(flower:Consumable):void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		outputText("Alvina smiles at the flower as you offer it to her. \n\n");
		outputText("\"<i>Oh my! How kind. Most people around here would either ask a lady out for a date or litteraly request sex on the first day, I'm glad to see romance isn't completely dead in Mareth.</i>\"\n\n");
		outputText("She straps the flower to her bag then looks back to you expectantly.\n\n");
		outputText("\"Well, anything else you wanted to talk about?\"");
		GaveAlvinaFlowers = true;
		player.destroyItems(flower, 1);
		alvinaBarGiftOptions();
	}
	public function alvinaGiveMrPaw():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		outputText("You pull out the teddy bear from your backpack and show it to Alvina who reacts with wide eyes backing off as if struck by lightning. She stares at the thing stunned for a brief moment before collecting herself and laughing.\n\n");
		outputText("\"<i>Ahaha it's just an old teddy bear. Come to think of it though I do recall I did like those when I was younger. It's all dirty though, maybe you should wash it up.</i>\"\n\n");
		outputText("Actually you wanted to gift it to her though from her reaction you're worried that you may have triggered something bad.\n\n");
		outputText("\"<i>No… No of course not! Thank you very much [Name] I will hold on to this little guy from now on.</i>\"\n\n");
		outputText("You tell her he supposedly has a name and that'd be mister paw. She seems to be lost in thought for a few seconds before replying.\n\n");
		outputText("\"<i>Well… well… sure he can be called Mister Paw then, it's a nice name too...</i>\"\n\n");
		outputText("She put the teddy in her backpack with extreme care before turning back to you.\n\n");
		outputText("\"<i>Anything else you wanted to talk to me about [Name]?</i>\"\n\n");
		player.destroyItems(useables.TEDDY, 1);
		GaveAlvinaMrPaw = true;
		alvinaBarGiftOptions();
	}
	public function alvinaGiveWand():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		outputText("You tell Alvina you found an old wand and ask her if she could fix it for your own use. She looks at you at first puzzled then something in her eyes changes as she sees the item.\n\n");
		outputText("\"<i>Where oh where did you find this… Nevermind that sure yes I could fix that wand for you. Could use something to do anyway between my reads. See me tomorrow and I will have it back working.</i>\"\n\n");
		outputText("She picks up the wand with care and wrap it into a cloth.");
		outputText("\"Well, anything else you wanted to talk about?\"");
		player.destroyItems(weapons.O_WAND, 1);
		GaveAlvinaWand = true;
		WandCooldown = 1;
		alvinaBarGiftOptions();
	}
	public function alvinaGiveChocolate():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		outputText("You tell Alvina you brought a small gift for her, a small box of chocolate. She looks at you puzzled then smile a few seconds later. \n\n");
		outputText("\"<i>Well how kind, romance in mareth is kind of dead. I'm surprised someone here still use the old ways to courtship well unless you had different motives?</i>\"\n\n");
		outputText("No of course not, you really just felt like giving her a gift.\n\n");
		outputText("\"<i>Really… well I greatly appreciate it, no one else would have gone through such lengths to UGHH...</i>\"\n\n");
		outputText("She suddenly drop from her chair to the ground a hand on her chest as if trying to hold blood from a fatal wound. You're about to help her out, maybe try some basic medical skills of yours but she get back up on her own.\n\n");
		outputText("\"<i>It's nothing… must've been something wrong with the drinks. I need to go and take care of my health. Be safe [name] and until next time.</i>\"\n\n");
		outputText("She quickly dumps gems on the corner to pay her tab and storm out of the wet bitch. While you stare blankly still pondering what just happened.\n\n");
		player.destroyItems(consumables.CHOCBOX, 1);
		GaveAlvinaChocolate = true;
		GiftCooldown = 1;
		endEncounter();
	}
	public function alvinaGiveWandBack():void {
		outputText("You ask how it went with the magical tool, and she hands the wand to you fully repaired.\n\n");
		outputText("\"<i>Good as new. Though you are not the original owner, it will still work quite well, though probably not quite as well as if itd been custom made for you. Blast off some imps with that for practice if you need to.</i>\"\n\n");
		WandCooldown = -1;
		inventory.takeItem(weapons.R_WAND, alvinaBarGiftOptions);
	}

	public function alvinaDate():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		outputText("You ask out Alvina for a date.\n\n");
		outputText("\"<i>What the? Are you sure you are interested in me? I mean I'm a shut in goggle eyed wizard nothing else surely there's plenty of others around you could fancy?</i>\"\n\n");
		outputText("No, you indeed are asking HER out. Is there a problem with that?\n\n");
		outputText("Alvina is shocked and confused but decides to nod to your invitation regardless. The two of you go out sightseeing the entire city for the next few hours and even stop at the bakery to share desserts. At the end of the day you climb up a building and take a look at the sky.\n\n");
		outputText("\"<i>Well I had forgotten how beautiful the stars are with the clouds covering the sky and what not. You clearing the factory that was spraying cloudy fumes all over the place is a blessing.</i>\"\n\n");
		outputText("You agree that seeing the star is definitively less depressing than the clouds but that it wouldn't be as great if you were alone doing it. Doing things with her today made everything better.\n\n");
		outputText("Alvina seems lost in thought for a moment before replying \"<i>Everything we see here is impermanent… Those folks will die one day and the food will be consumed or will spoil and rot on its own. Even this city… There's no telling when It'll become a ghost town and be forgotten by everyone and everything. People die [name] because they are bound by a set of laws they can't escape. It kind of sucks because this also creates loss, the other inevitability. One day inevitably you will lose things dear to you… how will you react to it? What's the point of getting attached to things that may be gone tomorrow? Maybe we should just let the demon's win so everyone can live on forever.</i>\"\n\n");

		menu();
		addButton(0, "None", alvinaDateNone).hint("There is no point it's all going to be gone either way.");
		addButton(1, "Precious", alvinaDatePrecious).hint("Mortality and fleetingness is what makes every moment precious.");
	}
	public function alvinaDateNone():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		outputText("There is no point it's all going to be gone either way.\n\n");
		outputText("Alvina laughs then declares \"<i>Ah told you so! Yes everything is fleeting and will likely be gone one day so why are you fighting so hard for them my poor [name] you should just give up on your quest and try to live for yourself not something as hopeless as this because even if you win your reward will be to just die one day. The demons may just have the right side of this conflict.</i>\"\n\n");
		outputText("She excuses herself then heads back down the building bidding you good night.");
		DateFailed = true;
		explorer.stopExploring();
		doNext(camp.returnToCampUseFourHours);
	}
	public function alvinaDatePrecious():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		outputText("Mortality and fleetingness is what makes every moment precious. To discover new things to marvel at and live like every day is your last is what makes us human. If everything was eternal then things would inevitably become boring. To live forever also means you'll eventually run out of things to do, learn and see then what? You get bored and just wish to die either way. \n\n");
		outputText("Alvina stares at you then nod.\n\n");
		outputText("\"<i>I hadn't considered this… to me the only solution to solving every problem of life was to make everything permanent but you are right the lack of new stimulation would be no different from being dead forever perhaps worse. What of emotions and feelings? They hold our mind hostage and mess up any logical decision. To think with your heart can only lead to inevitable ruin.</i>\"\n\n");

		menu();
		addButton(0, "Yes", alvinaDatePreciousYes)
		addButton(1, "No", alvinaDatePreciousNo)
	}
	public function alvinaDatePreciousYes():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		outputText("She's probably right. \n\n");
		outputText("Alvina laughs then declares \"<i>Ah told you so! Yes feelings are pointless and only good at hindering your good judgment! Who needs those anyway.</i>\"\n\n");
		outputText("She excuses herself then heads back down the building bidding you good night.");
		DateFailed = true;
		explorer.stopExploring();
		doNext(camp.returnToCampUseFourHours);
	}
	public function alvinaDatePreciousNo():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		outputText("No, because the heart is what drives people forward with dreams and ideals. How can one have ideals to strive for if they cannot feel in the first place? Hope and yearning for better are feelings too. If you fight to solve an injustice it's because your heart told you so otherwise you would be no different from a mindless golem serving a master who tells you what he wants you to do.\n\n");
		outputText("Alvina stays quiet after your answer but tentatively grabs your left arms gently snuggling up toward you. However she never fully touches you, breaking away as she realizes what she's doing. \n\n");
		outputText("\"<i>It is late, I have to get going. [name] you better live up to those ideals of yours because… because I will not forgive you if you don't not after such a big moving speech!</i>\"\n\n");
		outputText("She jumps down slowing her fall with a spell before heading down the street. Before she goes though, you spot the glimpse of pain in her expression. Did something you said wounded her? Guess you should head back to camp yourself.\n\n");
		FirstDateSuccess = true;
		explorer.stopExploring();
		doNext(camp.returnToCampUseFourHours);
	}

	public function alvinaSecondDate():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		outputText("You ask Alvina out for a date.\n\n");
		outputText("\"<i>The savior of Mareth and slayer of Lethice [herself] ask me out on a date? Are you sure you're not trying to drive all the free partners in Tel'adre red with jealousy? Wh am I kidding, sure ill accept.</i>\"\n\n");
		outputText("The two of you go out sightseeing the entire city for the next few hours and even stop at the bakery to share desserts. At the end of the day you climb up a building and take a look at the sky while holding her hand.\n\n");
		outputText("\"<i>I still remember the last time we climbed this building… You showed me the stars and we talked about philosophy of all things. After all this adventure, you still came back to me, the goggles eyed shut in. Why?</i>\"\n\n");

		menu();
		addButton(0, "Love", alvinaSecondDateLove);
		addButton(1, "Like", alvinaSecondDateLike);
	}
	public function alvinaSecondDateLike():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		outputText("You just happen to like her company. Is that wrong in itself? Surely she wouldn't mind tagging along with you on your adventures sometime?\n\n");
		outputText("Alvina replies by the negative. \"<i>Afraid I can't, my health condition as you've seen would probably put me and even you in danger. You are much better off fighting what remains of the demons on your own [name].</i>\"\n\n");
		outputText("She excuses herself then heads back down the building bidding you good night. Despite this you got the feeling deep down that perhaps this isn't what Alvina truly wanted to hear.\n\n");

		DateFailed = true;
		endEncounter();
	}
	public function alvinaSecondDateLove():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		outputText("You fell in love with her from the moment you two first met. In this world filled with hundreds of nymphomaniac partners the one you wish for is her, the rational yet cute so called goggled eyed shut in.\n\n");
		outputText("Alvina stares at you, back up as shock, agonizing pain and finally sadness quickly flit one after another over her face. \"<i>That's impossible [name] I'm… I'm bound to another, surely you can understand… you have to understand my feelings are...</i>\"\n\n");
		outputText("What of it? This is Mareth. If she has another lover then she could just let herself be shared? Tons of people do it around here.\n\n");
		outputText("She falls silenct, staring at the emptiness before her, hood over her eyes as if trying to mask the storm of emotions assailing her heart. \n\n");
		outputText("\"<i>Find the defiled ravine and look for a cave with magical wards that's my field laboratory… we shall meet there.</i>\"\n\n");
		outputText("With this Alvina squeezes your hand tightly before letting go almost regretfully and running off, vanishing into the night. What could be the reason for her running away like this? It looks like you will find out at the defiled ravine.\n\n");
		SecondDateSuccess = true;
		doNext(camp.returnToCampUseFourHours);
	}
	public function alvinaDontFight():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2Concealed_16bit);
		clearOutput();
		if (flags[kFLAGS.ALVINA_DIARY] >= 4) {
			outputText("You tell her to stop it. Drop the act. Alvina is lying to herself trying to act tough right now but in reality you already know on what soil she bases her conviction. She can feel like you, think like you! She also has a soul like you.");
			//outputText("(not included pre crammed school dungeon)You've been to the crammed school you've seen everything she's lived through.(end of cut)");	//TODO Cram school?
			if (FirstDateSuccess) outputText(" You also saw her reactions to the flower and the teddy bear. ");
			outputText("Why is she still trying to pretend she's the villain in the story?!\n\n");
			outputText("\"<i>You idiot! I killed and manipulated hundreds of people for my goals, made pacts with fiends and did unethical experiments on folks in my pursuit for immortality and power. My quest gave birth to black magic and even the demon's. I was the one who advised Lethice into researching it in the first place yet YOU still can't see all the blood dripping from my clawed hands?! I'm far from a good person [name] but I transcended death and mortality so that I could set everything in this messed up world right! I am PERFECT and you COULD be too! Just become my apprentice and live forever at my side! You won't even need to feel, those feelings make you imperfect, they make you weak like all those sex crazed demons out there! My perfect [name] would never be like that!</i>\"\n\n");
			outputText("Is this really what she wants? She can't possibly think that even now. ");
			if (SecondDateSuccess) outputText("Not after she recoiled when you told her the beauty of impermanence and living like every day was your last. ");
			outputText("What about her feelings? She pretends she can't feel but clearly she likes you and that's a feeling in itself; heck come to think of it, hasn't she been shadowing you this whole time for this very reason? Everytime you hit a wall in your search she was there to give you hints.\n\n");
			outputText("\"<i>That's because I needed you to take Lethice down! With that moron out of the picture I can finally proceed toward phase two of my plan for a perfect world. A world of immortal beings that need not to love nor hate! A world without death or pain!</i>\"\n\n");
			outputText("Does she truly believe that? You can tell her whole argument is self contradictory and flawed. Who is she even trying to convince anymore? A world without emotion would be no better than dead. You know that, and most of all she knows that.\n\n");
			outputText("She laughs but it sounds hollow… empty like all strength and will to argue has left her.\n\n");
			outputText("\"<i>You are right indeed, however I am the beginning and the end of your quest [name], the one who started it all… you're right, I have been lying so hard to myself, desperately clinging to this final escape to my reality… I'm far too tired of this existence [name]… I've just been desperately trying to delude myself into believing that I'm not… those past two hundred years… my only remaining sibling was the price for them and only now do I truly regret everything. I may as well have spent that time in hell. This pendant right here is all that ties me to this world.</i>\"\n\n");
			outputText("Alvina clutches her necklace firmly, then staring at you with determination, grabs her weapon.\n\n");
			outputText("\"<i>I'm too far gone to go back on my ways now [name]. If your ideals are worth dying for… then fight for them. I would hate to put you down, but for the sake of my own goals I have to put you to the test. Show me the strength of your resolve and the power of all that which you believe in! If your ideals are so great that you are willing to die for them then back up your words with actions!</i>\"\n\n");
			outputText("On these words Alvina's aura flares with a pillar of raw magic power, transforming into a whole new form easily over 10 ft tall, her wings unfold as the magic from her aura spreads to the ground beneath her and catches fire setting the whole room ablaze. Amidst this vision of hell, Alvina stands proudly, her weapon split into a pair of battle scythes which she holds in each hand.");
			outputText(player.tallness < 9*12 ? " She's practically towering above you.\n\n":"\n\n");
			outputText("\"<i>Come [name] let us settle this debate once and for all...</i>\"\n\n");
			outputText("She might be the strongest opponent you've faced yet but for your and her sake you have to stop her.\n\n\n");
		} else {
			outputText("You tell her to stop it. Drop the act. Alvina is lying to herself trying to act tough right now but in reality you already know on what soil she bases her conviction. She can feel like you, think like you! She also has a soul like you.");
			outputText(" You also saw her reactions to the flower and the teddy bear. Why is she still trying to pretend she's the villain in the story?!\n\n");
			outputText("\"<i>You idiot! I'm a demon, clearly the very thing you've been fighting against this whole time. The only thing you know about me is the girl you met at the bar in Tel Adre' yet still claims to know me? You fool, don't you realize I've literally used you all this time to my benefits? I'm far from the good person [name] you depict me as. I transcended death and mortality so that I could set everything in this messed up world right! I am PERFECT and you COULD be too! Just become my apprentice and I will make sure that you live forever at my side! You won't even need to feel, those feelings make you imperfect, they make you weak like all those sex crazed demons out there! My perfect [name], would never be like that!</i>\"\n\n");
			outputText("Is this really what she wants? She can't just pretend she has no feelings. Not after she recoiled when you told her the beauty of impermanence and living like every day was your last. What about her feelings? As much as she wanted to hide them clearly she felt something. She pretends she can't feel but clearly she likes you, and that's a feeling in itself; heck come to think of it, hasn't she been shadowing you this whole time for this very reason? Everytime you hit a wall in your search she was there to give you hints.\n\n");
			outputText("\"<i>That's because I needed you to take Lethice down! With that moron out of the picture I can finally proceed toward phase two of my plan for a perfect world. A world of immortal beings that need not to love nor hate! A world without death or pain!</i>\"\n\n");
			outputText("Does she truly believe that? You can tell her whole argument is self contradictory and flawed. Who is she even trying to convince anymore? A world without emotion would be no better than dead. You know that, and most of all she knows that. Every sentence she spills betrays her feelings for you, let alone that obvious possessiveness of hers.\n\n");
			outputText("She laughs but it sounds hollow… empty like all strength and will to argue has left her.\n\n");
			outputText("\"<i>You are right indeed, however I am the beginning and the end of your quest [name], the one who started it allll. I'm not just any demon [name], I'm the fool who created them in the first place and thus the responsibility of every single hardship that befell you is mine to bear. You're right, I have been lying so hard to myself, desperately clinging to this final escape to my reality… I'm far too tired of this existence [name]… I've just been desperately trying to delude myself into believing that I'm not… those past two hundred years… my only remaining sibling was the price for them and only now do I truly regret everything. I may as well have spent that time in hell. This pendant right here is all that ties me to this world.</i>\"\n\n");
			outputText("Alvina clutches her necklace firmly, then staring at you with determination, grabs her weapon.\n\n");
			outputText("\"<i>I'm too far gone to go back on my ways now [name]. If your ideals are worth dying for… then fight for them. I would hate to put you down, but for the sake of my own goals I have to put you to the test. Show me the strength of your resolve and the power of all that which you believe in! If your ideals are so great that you are willing to die for them then back up your words with actions!</i>\"\n\n");
			outputText("On these words Alvina's aura flares with a pillar of raw magic power, transforming into a whole new form easily over 10 ft tall, her wings unfold as the magic from her aura spreads to the ground beneath her and catches fire setting the whole room ablaze. Amidst this vision of hell, Alvina stands proudly, her weapon split into a pair of battle scythes which she holds in each hand.");
			outputText(player.tallness < 9*12 ? " She's practically towering above you.\n\n":"\n\n");
			outputText("\"<i>Come [name] let us settle this debate once and for all, just you and me, champion and demon; this is as it was meant to be.</i>\"\n\n");
			outputText("She might be the strongest opponent you've faced yet but for your and her sake you have to stop her.\n\n\n");
		}
		FightForAlvina = true;
		startCombat(new Alvina());
	}

	public function alvinaDontFightWon():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
		clearOutput();
		outputText("Alvina backs off, her body is covered with wounds inflicted by you yet they all seems to heal endlessly, just what is the limit to her regeneration.\n\n");
		outputText("\"<i>You fought back with all you had and even forced me to unleash a parcel of my true powers.. however you cannot defeat me through sheer might and endurance that which I have in abundance. I won't die to a mere weapon or to a whitefire but it's a flawed immortality… You likely already know the source of my power yet you have purposely been avoiding striking it the whole time. What were you even trying to prove? We could fight for thousands of years and I would never tire out.</i>\"\n\n");
		outputText("What do you want to prove? The strength of your conviction of course! Still, proving that you are right is not enough, you want to save this one lost girl from herself. \n\n");
		outputText("This reply seems to anger Alvina \"<i>I'm through with this shit… Save me? Seriously? You think I can be SAVED? Give me a break, the last thing I deserve is your mercy! If you won't do it then I WILL</i>\"\n\n");
		outputText("Alvina suddenly grabs her necklace and tosses it on the ground in front of her. You can see the scene going in slow motion as the fallen archmage grabs her scythe with both hands and prepares to smash the pendant with all her might.\n\n");
		menu();
		addButton(0, "Stop her", alvinaDestroyPhylactoryStopHer)
			.disableIf(player.spe100 < 80, "You are simply not fast enough to stop her.")
			.disableIf(!player.hasItem(consumables.P_PEARL), "You were warned to bring the pearl along, now it is too late!");
		addButton(1, "Watch", alvinaDestroyPhylactoryWatch);
	}
	public function alvinaDestroyPhylactoryStopHer():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
		clearOutput();
		outputText("You intercept the blow at the last second by shielding the pendant with your own body as the scythe cuts right through you.\n\n");
		outputText("Seeing you take that direct and bloody hit causes Alvina to drop down on her knee, her scythe falling on the ground with a loud metallic clank.\n\n");
		outputText("\"<i>Why… WHY!?!? WHY DID YOU STOP ME!? You IDIOT! Everything would have finally been over! Are you actually so naive as to risk your own life to save an enemy?! Didn't this thrice damned land teach you anything about this kind of foolishness! Are you living in a pipe dream or something?! Did you hit your head on a rock!</i>\"\n\n");
		outputText("Because she deserves a second chance, like everyone else. It's never too late to change back. You wouldn't be the champion if you didn't try and save her. The other reason though you don't tell her outright is that you may need her help to end the demon's advance once and for all.\n\n");
		outputText("\"<i>Gibberish! Utter nonsense! This whole champion thing was bullshit from the very start. You were sent here to be sacrificed just like I was to be cast away and used as a sacrifice by my first mentor! Don't you resent the demons and me by extension for having caused this?! Shouldn't you thoroughly despise me?!</i>\"\n\n");
		outputText("She was a victim of circumstance, lost things dear to her and it eventually corrupted and twisted her into what she is today. It's not too late for her to redeem herself and help undo every harm she has done. She knows more about the origin of demonkind than anyone else. She can use that knowledge to save Mareth. What if instead of denying the emotions she tried so hard to bury down she embraced them back?\n\n");
		outputText("\"<i>Release my emotions? Repent? I'm a demon [name] do I have to spell it for you? D E M O N! Do you realise that me becoming human again would require nothing short of a damn miracle?!? What are you going to do? Purge the corruption out of me?</i>\"\n\n");
		outputText("From your pocket you pull out the Marae pearl. Purity manifest, the immaculate pearl shines before Alvina eyes which tremble before it.\n\n");
		outputText("\"<i>Pure… immaculate… the will of the tree goddess in the form of a gem. Did you actually plan for this all along?</i>\"\n\n");
		outputText("She might pretend she's a demon but her soul still exists albeit outside her body. While she is indeed deeply corrupted there's no telling that a powerful purifying agent couldn't fix her up so long as she genuinely wishes to change, her demonic nature as a natural shapeshifter should play itself up and assist it, though you have no idea of what a purified demon would look like. \n\n");
		outputText("\"<i>The very notion is ludicrous, absurd. You're telling me that if I reject my own corrupted nature hard enough it will just work? What kind of whimsical way of thinking is that?! Do you hear yourself talk here?! Well know what, just to humor you I'll try, and if I fail I can always just off myself as I had originally planned.</i>\"\n\n");
		outputText("Alvina grabs the pearl from your hands, her fell eyes reflecting on the surface before she gulps it down. She begin to focus, closing her eyes and at first nothing seems to happen. You're about to sigh in disappointment when the tips of her pitch black hair strands begin to bleach, growing increasingly pale. At first the white gains a few centimeters before the black slightly swallows it back, but it is like pushing back against a tidal wave as the white begins creeping all the way up to the root. While she doesn't exactly become human again, many of her fiendish traits are revised into something more natural and noble, turning her into some kind of new chimeric hybrid. Her demon tail writhes and changes shape before covering in immaculate white fur and draconic scales. Finally Alvina's skin tone lightens up slightly as her fleshy wings membranes melt and change, covered with feathers of pure white. Alvina opens her formerly embery, now golden horizontal slitted eyes in absolute confusion marveling as her entire body is reshaped.\n\n");
		outputText("\"<i>I… I am one with myself and the world, I've seen the depths of wants but also acquired the understanding to use it with control and restraint. This feeling [name], it's like staring at the world first the first time, a dimension beneath the dimensions where all rules of creation converge. It's like I stand as a grain of sand in the middle of everything so small but capable of altering the fabrics of reality so long as it keep flowing harmoniously with the natural order. Is this godhood? No it is not… gods are limited in what they can do… their wants are restrained by their own petty desires and lack of imagination. To see what I see right now [name]. I have to concentrate not to lose myself into the sea of possible past futures and alternatives. It is as you first said, Mareth is damaged… wounded but not beyond repair. The gods can't fix this, heck if no one does anything the wound will only get worse. But I can… I and my descendents can fix this wound caused by the corruption. </i>\"\n\n");
		outputText("\"<i>Removing the demon's will not fix Mareth; the corruption has run too deep; it's literally in the mind of the denizens now. Even if we remove the plant and kill all the demon's new demons could easily arise from the remaining corrupted roots. All it takes is for a particularly lusty mortal to go on a lust craze and spontaneously lose their soul and we will be back to square one. As for you [name], you may think you are but a human, but within you rests a spark capable of rewriting history as we see it.</i>\"\n\n");
		outputText("\"<i>The power to beat impossible odds and change yourself infinitely, to rewrite your own mistakes into success to the desired outcome and change the future… only… are you even aware of your own power? Maybe you use it subconsciously to begin with. You are an anomaly [name], one of the few beings capable of changing their own fates and that of others at will. I see now what I must do, and it starts by pledging my body and souls to you so as to ensure that you may accomplish everything you set your goals upon. Undo past mistakes and put Mareth onto the right track. You embody everything I've worked so hard to see.</i>\"\n\n");
		outputText("She kneels in front of you, her golden eyes staring directly into yours, you see her unshakable determination firsthand. However you didn't wan't Alvina to be your servant, what you did was out of love for her.\n\n");
		outputText("\"<i>I am unworthy of your praise [name], this form I have now is but the fruit of your own labor to unshackle me from my mistakes and free me from my torment. I just know it… I have seen all the alternatives and where they inevitably lead. If anything, it's possible you have threaded them all already, you just don't remember it.</i>\"\n\n");
		outputText("Still you would prefer she stood up and walked alongside you as a partner, a lover and not as a servant. \n\n");
		outputText("\"<i>This path leads to a happy ending… I am not sure whether I deserve it but if this is what you choose, who am I to deny you fatebreaker? Fine then, I Alvina, first of my new species which I shall call Azazel, pledge myself to you.</i>\" \n\n");
		outputText("Suddenly her eyes light up as if remembering something and she giggles as she catches your hand into her pawed fingers.\n\n");
		outputText("\"<i>[name] I've been fighting it hard until now, pride and everything blinding me to my own feelings but I would like you to take me… here and now, please make me yours.</i>\"\n\n");
		outputText("You know where this is going ahead of time. This is a story eternally retold in Mareth. Except maybe this one will be slightly different.\n\n");
		AlvinaPurified = true;
		player.consumeItem(consumables.P_PEARL);
		outputText("You head back to camp, Alvina following you.\n\n");
		outputText("<b>Alvina has joined you as a follower.</b>\n\n");
		flags[kFLAGS.ALVINA_FOLLOWER] = 12;
		awardAchievement("Dawn chasing away the night", kACHIEVEMENTS.GENERAL_DAWN_CHASING_AWAY_THE_NIGHT);
		if (flags[kFLAGS.GAME_DIFFICULTY] >= 4)
			awardAchievement("Beyond gods and mortals", kACHIEVEMENTS.GENERAL_BEYOND_GODS_AND_MORTALS);

		alvinaMakeLovePure();
	}
	public function alvinaDestroyPhylactoryWatch():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
		clearOutput();
		outputText("Alvina's scythe buries right into the pendant which cracks and shatters.\n\n");
		outputText("She then looks at you and gives you a genuine and sorry smile.\n\n");
		outputText("\"<i>I am not long for this world. My body will soon break apart but if I have regrets now there may only be one and it's that we never became true lovers. After I lost everything I thought I would never feel again but you proved me wrong. I cannot keep on living and eventually lose you too… it would break whatever is left of my sense of self. If we are to forever be on opposing sides then so be it I want you to win, because this what the [name] I believe in would do. Could you.. could you hold my hand… one last time?</i>\"\n\n");
		outputText("Her body begins collapsing into lights of mana as you swiftly take her hand and apologize to her.\n\n");
		outputText("\"<i>What are you even apologizing for? I only regret that you didn't appear in this world sooner and catched me before I slipped.</i>\"\n\n");
		outputText("Alvina suddenly takes the initiative and kisses you for the first and last time before her body completely vanishes. The proof of a love found and then just as swiftly lost. The only thing remaining of the fallen archmage is her broken phylactery, a reminder that Alvina Shadowmantle the witch from which the demon calamity began once upon a time did live on Mareth.\n\n");
		outputText("With a heavy heart you pick up the broken pendant if only as a memento. She deserved better than this.\n\n");
		explorer.stopExploring();
		alvinaDies(camp.returnToCampUseSixHours);
	}
	public function alvinaMakeLovePure():void {
		menu();
		addButton(0, "Take Her", curry(sceneHunter.callBigSmall, alvinaPureTakeHer, 20, 10, "length"))
				.disableIf(!player.hasCock(), "You need a penis to do this");
		addButton(1, "Let Her", alvinaPureLetHerTakeYou)
				.disableIf(!player.hasVagina(), "You need a vagina to do this");
		addButton(2, "Make Out", alvinaPureMakeOut)
				.disableIf(!player.hasVagina(), "You need to have a vagina to do this");

		addButton(14, "Later", playerMenu);
	}



public function alvinaMainCampMenu():void
{
	if (AlvinaPurified) spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle_Pure_16bit);
	else spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("You head out to meet Alvina in her hidden camp. She is in the middle of an experiment, as usual.\n\n");
	if (player.hasStatusEffect(StatusEffects.DevilPurificationScar)) {
		alvinaFreaksDevilPurification();
		return;
	}
	outputText("\"<i>Well hello [name], what brings you to me today?</i>\"\n\n");
	menu();
	addButton(0, "Appearance", alvinaMainCampMenuAppearance).hint("Examine Alvina detailed appearance.");
	if (flags[kFLAGS.ALVINA_DIARY] < 5) addButton(1, "Diary", alvinaMainCampMenuDiary);
	if (flags[kFLAGS.ALVINA_DIARY] == 5) addButton(1, "Diary", alvinaMainCampMenuDiaryAreYouSure);
	if (flags[kFLAGS.ALVINA_DIARY] == 6) addButtonDisabled(1, "Diary", "You've already read it.");
	if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 4 && flags[kFLAGS.ALVINA_FOLLOWER] >= 16) {
		if (flags[kFLAGS.ALVINA_FOLLOWER] >= 19) addButton(2, "Sex", alvinaMainCampSexMenu)
			.disableIf(player.isGenderless(), "Not. For. Genderless!");
		if (flags[kFLAGS.ALVINA_FOLLOWER] == 16 || flags[kFLAGS.ALVINA_FOLLOWER] == 18) addButton(2, "Confession", alvinaMainCampMenuConfession).hint("If you don't know what this means... I have lost faith in your intelligence."); //Just cleaning this up.
		if (flags[kFLAGS.ALVINA_FOLLOWER] < 21) addButton(3, "Proposal", alvinaProposal)
			.disableIf(player.isGenderless(), "Not. For. Genderless!")
			.disableIf(flags[kFLAGS.ALVINA_TIMES_FUCKED] < 4, "You doubt it is mutual. You don't even have sex with her often enough!")
			.disableIf(!flags[kFLAGS.MICHIKO_TALK_MARRIAGE], "You don't know something important about Mareth yet. Check later.", "???")
			.disableIf(flags[kFLAGS.ALVINA_DIARY] < 6, "You still don't know her well enough... maybe her diary could help?", "???")
			.disableIf(flags[kFLAGS.ALVINA_FOLLOWER] < 20, "You should know her better for this", "???")
			.disableIf(!sceneHunter.canMarry(), "You have already married someone else.");
		if (sceneHunter.married("Alvina")) {
			if (flags[kFLAGS.SLEEP_WITH] == "Alvina") addButton(4, "Sleep Alone", noSleep);
			else addButton(4, "Sleep WIth", sleepWith).hint("Ask Alvina to sleep with her.");
		} else addButtonDisabled(4, "???", "See the button to the left? Make it work :)");
	}
	else addButtonDisabled(2, "???", "You need to finish Advanced Study to unlock this option.");
	if (flags[kFLAGS.ALVINA_FOLLOWER] >= 19) {
		if (player.hasPerk(PerkLib.BasicLeadership)) addButton(5, "Team", alvinaHenchmanOption);
		else addButtonDisabled(5, "Team", "You need to have at least Basic Leadership to form a team.");
	}
	if (player.hasStatusEffect(StatusEffects.AlvinaTraining)) addButtonDisabled(10, "Study", "You have already completed basic Study.");
	else addButton(10, "Study", alvinaCampStudy);
	if (player.hasStatusEffect(StatusEffects.AlvinaTraining) && player.statusEffectv1(StatusEffects.AlvinaTraining2) < 2) addButton(11, "Advanced Study", alvinaCampAdvancedStudy);
	else {
		if (player.hasStatusEffect(StatusEffects.AlvinaTraining) && player.statusEffectv1(StatusEffects.AlvinaTraining2) == 2) {
			if (player.hasItem(useables.AMETIST, 1) && player.hasItem(consumables.L_DRAFT, 5) && player.hasItem(useables.SOULGEM, 5) && (player.hasKeyItem("Marae's Lethicite") >= 0 && player.keyItemvX("Marae's Lethicite", 1) > 0 || player.hasKeyItem("Stone Statue Lethicite") >= 0)) addButton(11, "Advanced Study", alvinaCampAdvancedStudy);
			else addButtonDisabled(11, "Advanced Study", "You need to gather a flawless Amethyst necklace, five lust drafts, five soul gems, and a piece of very powerful Lethicite before you can progress.");
		}
		if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3) {
			if (player.hasKeyItem("Siegweird's holy symbol") >= 0) addButton(11, "Advanced Study", alvinaCampAdvancedStudy);
			else addButtonDisabled(11, "Advanced Study", "You need to go kill a certain annoying paladin in Blight Ridge.");
		}
		if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 4) addButtonDisabled(11, "Advanced Study", "You have already completed Advanced Study.");
	}
	if (flags[kFLAGS.ALVINA_FOLLOWER] >= 20) addButton(14, "Back", camp.campLoversMenu);
	else addButton(14, "Back", camp.campFollowers);
}

public function alvinaMainCampMenuAppearance():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("From your knowledge Alvina is of a rare demonic offshoot known as devils. While you are aware that, like most demons, she has advanced shapeshifting abilities, Alvina favors the appearance of a little girl several centuries younger than her true age, mostly for convenience. Alvina’s raven black hair is parted by two heavy goat horns and small furry ears, you ponder at the time why ");
	outputText("demons and devils develop such variants in their physiognomy. Beneath her hair, two pupils glowing like molten embers stare back at you from behind a pair of glasses, or at least they do when she's not busy reading some dusty arcane text. Her smug, playful lips hides fangs better suited to a beast than a human and a practiced tongue who has spent centuries wording out some of the most powerful incantations in the realm. \n\n");
	outputText("Beneath her neck Alvina’s body is somewhat human-like however her forearms ends in furry four fingered claws while her legs are those of a goat. On her back rests a pair of folded demon wings she doesn't use that often, mainly because flying magically or levitating is, as a general rule more convenient. Beneath her wings is her tail, unlike demons, ");
	outputText("devils tend to have goat tails instead of the sinuous spade and Alvina’s own goat tail motion reflects her state of mind, becoming agitated during unrest or when she loses her patience.\n\n");
	outputText("Alvina’s breasts are, surprisingly for a female demon, only an A cup. Anytime you would ask her why she keeps them so small she replies it's because, while a prodigious chest assist in the powers of lust and temptation based spells, a smaller chest is more practical both for the body and the spirit as a larger pair tend to obscure view, ");
	outputText("weighs the body down and consume an excess amount of energy, maintenance she has no interest in spending. Mirroring this, her ass only has the bare minimum size to denote her as a female.\n\n");
	outputText("Between those goat legs of hers is her vagina which, like most demon can likely wrinkle a cock dry within seconds if she decides to use it. This said, Alvina is as a general rule more interested in magic than sex and, unlike most succubi that are natural squirters, Alvina’s vagina looks about as standard as one of a human woman would be, both in the moistness and size.\n\n");
	outputText("Alvina is perfectly aware that you are analysing her, but, as usual, is more concerned about whatever lecture she is on than about you sizing her up.\n\n");
	outputText("\"<i>Well then, when you are done sizing my body up, maybe you can tell me what you are here for?");
	if (flags[kFLAGS.ALVINA_FOLLOWER] < 19) outputText(" I have little time for games as you know all too well.");
	outputText("</i>\"\n\n");
	menu();
	addButton(14, "Back", alvinaMainCampMenu);
}

public function alvinaFreaksDevilPurification():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("You walk to Alvina with renewed resolve. You put up with her shenanigans because you loved her, going all the way down to becoming like her and nearly losing yourself.[pg]");
	outputText("Alvina closes her book, acknowledging your presence.[pg]");
	outputText("\"<i>So you've decided to go against it eh [name]? You know your whole fight is meaningless. Why battle corruption at all? You're weakening yourself, hurting yourself, all for a concept of virtues established by others. For this I cannot forgive them.</i>\"[pg]");
	outputText("Oh so she's stopped acting tough all of a sudden?[pg]");
	outputText("\"<i>That you would try and purify yourself never crossed my mind, let alone the fact I didn't plan for this.</i>\"[pg]");
	outputText("Instead of lamenting that you managed to fix yourself, how about she considered to do the opposite? With her powers and a bit of good will she could part ways with her own corruption too.[pg]");
	outputText("\"<i>That's foolish, completely mad cap! If you intend to be like that then I'll just break your phylactery!</i>\"[pg]");
	outputText("She won't do it though, you call her out on that.[pg]");
	outputText("\"<i>Oh and why is that? Tell me what's stopping me from killing you here and now?</i>\"[pg]");
	outputText("Because while she try to pretend otherwise she's been in love with you since the day you two met. You feel the same way which is the very reason you became a demon in order to follow in her footsteps and get closer to her but this was a mistake. Instead of changing for her you should've found ways to help her out. To kill you now would be no different from hurting herself all over again. The very reason she's so afraid of her emotions in the first place that she would seal most of them away in a pendant![pg]");
	outputText("\"<i>I'm not running away, you're the one distancing yourself from me, you idiot!</i>\"[pg]");
	outputText("Alvina grabs her scythe and sigh \"<i>Looks like the only way I have to cure you of your own stupidity is through brute force. Don't worry it won't hurt, I'll just beat you unconscious then pour corruption into your body until I'm sure you will never break on me again.</i>\"[pg]");
	outputText("So what, her whole ideology was flawed from the start and you had to experience it first hand to know it yourself. Whats the point of eternal life if the two of you are cursed to never be able to fully love one another! Her so-called perfect world utopia was never gonna be a thing in the first place. It will just end up as a world with no joy, no sadness, no love, no hate and most of all likely no life because those are all two sides of the same coin![pg]");
	outputText("\"<i>It will work… I guarantee it!</i>\"[pg]");
	outputText("Does she truly believe that? Who is she even trying to convince anymore?[pg]");
	outputText("She laughs but it sounds hollow… empty like all strength and will to argue has left her.[pg]");
	outputText("\"<i>You are right indeed, however, I am the beginning and the end of your quest [name], the one who started it all… you're right I've been lying so hard to myself desperately clinging to this final escape to my reality… I'm far too tired of this existence [name]… I've just been desperately trying to delude myself into believing that I'm not… those past two hundred years… my only remaining sibling was the price for them and only now do I truly regret everything. I may as well have spent them in hell. This pendant right here is all that ties me to this world.</i>\"[pg]");
	outputText("Alvina clutches her necklace firmly then stare at you with determination, grabbing her weapon.[pg]");
	outputText("\"<i>I'm too far gone to go back on my ways now [name] if your ideals are worth dying for… then fight for them. You think redemption is possible even for us soulless bodies then prove it! For the sake of my own goals however I will put you to the test. Show me the strength of your resolve and the power of all that which you believe in! That so-called power you claim is stronger than all of which I have sought.\"</i>[pg]");
	outputText("On these world Alvina aura flares with a pillar of raw magic power as she transforms into a whole new form easily over 10 ft tall, her wings unfolding as the magic from her aura spreads to the ground beneath her and catch fire setting the whole area ablaze. Amidst this vision of hell Alvina stands proudly, her scythe having split into two sickles of which she holds one in each hand."+(player.basetallness < 9*12 ? " She practically towers above you.":"")+"[pg]");
	outputText("\"<i>Fixing me, hah! You're the one who needs to be fixed. Trust me you will thank me for it later.</i>\"[pg]");
	outputText("She's your teacher and lover as well as the most powerful opponent you've ever faced, but for your sake and hers, you have to stop her. There's no holding back now.[pg]");

	FightForAlvina = true;
	startCombat(new Alvina());
}

public function alvinaMainCampMenuDiary():void
{
	clearOutput();
	if (flags[kFLAGS.ALVINA_DIARY] == 4) {
		outputText("While Alvina is busy out of view you open her diary and keep on reading, curiosity getting the better of you.\n\n");
		outputText("<i>Day 120 year 84\n\n");
		outputText("Thanks to working actively with the fiend I discovered a new form of magic. A source so far prohibited that draws on the power of desires, lust and the soul itself. It is powerful… So powerful it could actually change spellcasting as we know it. I knew my quest was not in vain and with this new discovery I am one step closer to my goal. I shall make many spells designed around it and develop ");
		outputText("it to its full extent. This year the king died and his daughter, Lethice took over the throne. She should be easy to manipulate in order to justify any measure I need to take for my researches. Once me and her are ‘best friends’ it will be simple to convince her to assist me in anything I need or want.\n\n");
		outputText("Day 135 year 89\n\n");
		outputText("It has been five years since I began my research but I am this close to uncovering the secret of true immortality and power. Lust and desire seems to draw the soul temporarily closer to the heart before stressing it into producing a massive amount of energy. I need to find a way to reproduce this reaction infinitely and, to this end, ");
		outputText("more live test subjects will be needed. It doesn't matter anymore how many die in the process, I’m about to realise my greatest dream!\n\n");
		outputText("Day 170 year 91\n\n");
		outputText("After two years of experimentation, I have finally created an immortal. However the \"demon\" as I call it lacks a moral compass and is obsessed with sex. It is a curious creature. It does not hunger, thirst or even seem to age. It also seems to naturally have an affinity for magic. The stone produced out of the subject seems to be a source of immense powers and so I took it with me in order to research it. ");
		outputText("However it seems the test subject’s condition is highly contagious and might destroy the entire kingdom if allowed to roam, and as I have already lost two apprentices to him, it clearly cannot be contained without resorting to force. For this reason I caged the fiend and my now transformed apprentices in order to study the condition further. Truth be told, I am genuinely intrigued by this development.\n\n");
		outputText("Day 171 year 91\n\n");
		outputText("Just as I suspected, this experiment is a failure. While powerful, the creature I now call demon cannot draw on the power of a soul to bolster his black magic as he lacks one entirely. Black magic when used at its maximum output begins to melt the soul out of the body as it tries to escape its container. ");
		outputText("I need to find a way to attain the maximum pleasure and power without losing my soul like him in order to obtain the power I seek. Perhaps encasing the soul in an artificial containment from which it won’t be able to escape is the solution.\n\n");
		outputText("Day 170 year 125\n\n");
		outputText("Dear journal, It has been many years since I fled the capital city. And I did so just in time, as my creations began to rampage after some idiot let them out of their cages. Fools are all obsessed with sex and lust now, clear signs of black magic abuse! I told those idiots that without further research black magic would destroy them and did they listen? No! ");
		outputText("Even Lethice seems to have fallen prey to this madness as she started calling BDSM and fetishes the new trend. Therefore I fled the capital as everything was going to hell. Regardless, I have made a breakthrough! After separating one of these furry savages from its soul, I found how to bind it to an object that I will call a phylactery. ");
		outputText("I intend to bind mine soon in order to achieve the power of the demons along with the perfect clarity of mind I need to control my new powers without falling prey to this weird madness that has clouded my colleagues judgements.\n\n");
		outputText("Day 150 year 130\n\n");
		outputText("Dear journal, after much calculation and experimentation I created a new form of fiend. My creation shall be small and combine the characteristics of the wise revered goat with those of the current demon model. I thought I would be less inclined to carnal activity and wastes of time if I used a body closer to my purpose as a wizard and I was right all along, this form will suit me well. ");
		outputText("I shall call this new breed of Demon the Devils. Devils got what my first creation, the demons don’t have despite all their power and that's restraint. With the power to shape the world around them, live forever and actually overcome any trials my new breed of fiend should be able to achieve my dream of a perfect world ruled by immortals. ");
		outputText("What I have left to do however is to create an easier ritual as the creation of devils seems to be a difficult one. That said, I’m definitely going to perform the ritual for myself.\n\n");
		outputText("Day 170 year 130\n\n");
		outputText("Dear journal, I finally achieved what I sought for all those years. True immortality, however it did not come for free. In order to achieve the ritual I had to corrupt my own body in order to facilitate the soul passage to the phylactery. I realised all too late as I became a devil that despite keeping my head clear I would soon lose the ability to process morality, ");
		outputText("what has made  me human in the first place. Bah, who need theses anyway, morality is just a tether in the way of progress and true advancement can only be achieved by discarding it. Did I ever even have a moral code in the first place? Well I guess I somewhat did but I have chosen to ignore it, otherwise I wouldn't have gotten this far.</i>\n\n");
		outputText("The journal continues and Alvina is nowhere in sight, you are anxious to see what's inside the diary beyond these page. Do you resume reading and throw caution out the window?\n\n");
		flags[kFLAGS.ALVINA_DIARY] = 5;
		advanceMinutes(30);
		menu();
		addButton(1, "No", alvinaMainCampMenuDiaryNo);
		addButton(3, "Yes", alvinaMainCampMenuDiaryYes);
	}
	else if (flags[kFLAGS.ALVINA_DIARY] == 3) {
		outputText("While Alvina is busy out of view you open her diary and keep on reading. The journal continues detailing Alvina vile progress toward wizardhood but, uninterested in the next sixty years which consist mostly of laboratory log and magical experiment, you skip a few pages.\n\n");
		outputText("<i>Day 213 Year 70\n\n");
		outputText("I finally found what I needed as a final ingredient and my sister conveniently happens to have it within her bosom. Only blood can call to blood and in the current case her heart is the component I need in order to become young again so I can continue on my work. That said I considered my options time and time again, not without great anguish, how could I kill my own sibling? Yet in the end it's my life or hers and I am not ready to die just yet, ");
		outputText("she might just be 2 years younger than me but she will do regardless. Am I a monster? No... It's the world around me that is cruel and so long as I don’t find a way to fix it, sacrifices will need to be made. Stopping here and now would make the deaths of everyone who willingly or unwillingly gave their lives for me to get this far be in vain.\n\n");
		outputText("Day 215 year 71\n\n");
		outputText("Elizabeth proved little of a challenge for my magic… I stormed her house and ran right to her. What does she have to lose? 65 years old, her kids are gone and she lived happily, she is likely going to die anyway in a few years from a common disease so might as well sacrifice her so I can become young again right? It didn’t go that well. ");
		outputText("At first, I tried to end her life in the most humanly possible way but these words... Those horrible words she and her husband threw at me. I am not a monster and I didn’t kill mom and dad! How dare she tell me this?! At that moment, something snapped in me and I lost all pretense of restraint. ");
		outputText("I ripped the bitch’s heart out once her head was no more. For me to recover all those years I have lost researching untold magic I need to perform this ritual and in order to extend my remaining time I need her heart. It is a sacrifice I am willing to make in the name of accomplishing my dreams.\n\n");
		outputText("Day 216 year 71\n\n");
		outputText("I did it, I’m young again as if I was 18. Now all I need is the financial support to resume my experiments as I look toward a more permanent solution to this silly disease called ageing. That said the fiend I previously summoned offered to train me further in the magical arts. Perhaps I can learn from him something even the best wizards ignore, for a few sacrifices of course, but there’s plenty of trash out in the city street whose presence won't be missed.\n\n");
		outputText("Day 170 year 72\n\n");
		outputText("This is all too perfect. That idiotic court mage up at the king's stronghold took me in as an apprentice. Soon I will have unlimited access to the royal library, and of course the old bastard's own notes. That said he has very little useful information to give. The people here are way too pious and pure, it reminds me of that old teacher I killed so long ago. ");
		outputText("I have seen the power of darkness firsthand and clearly those fools know nothing about true magic.</i>\n\n");
		outputText("You skip a few pages to see what happened.\n\n");
		outputText("<i>Day 102 year 80\n\n");
		outputText("I was finally named archmage out of all the fools at the palace. Truth be told, poisoning the old codgers with undetectable toxins turned out to be perfect because most people think the wizards died from ageing. I can now fully devote my time to my research using all the old man had at his disposal.</i>\n\n");
		outputText("Alvina almost catches you this time but you manage to act like you didn't open her diary or read it. This is starting to become dangerous. Maybe you should stop your reading now? You head back to camp.\n\n");
		flags[kFLAGS.ALVINA_DIARY] = 4;
		doNext(camp.campFollowers);
		advanceMinutes(20);
	}
	else if (flags[kFLAGS.ALVINA_DIARY] == 2) {
		outputText("While Alvina is busy out of view you open her diary and keep on reading.\n\n");
		outputText("<i>Day 10 Year 7\n\n");
		outputText("I am an orphan. Father and mother died of illness 5 years ago. Despite the money I brought home for them to be cured, nothing worked and the doctor said no amount of money would matter now. Once in a while I visit mom's grave with a bouquet of Fafnir tears, she loved those flowers so much. I have nothing left but my now 8-year-old sister still at the orphanage we were sent to and this strange power ever-growing inside of me. This year I left the orphanage because I decided to attend magic studies. ");
		outputText("Fact is I was selected amongst many to become a wizard due to my high intelligence, though no one suspected I still heard the voice of Mephi from time to time in my mind. However the school where I study is so boring and way too strict. The teachers are stubborn and close minded… Restricted area they say? ");
		outputText("There's no such thing as a restricted area in the library for me… What if a ritual to revive papa and mama was in there? Sooner or later I will find these secret books.\n\n");
		outputText("Day 35 Year 7\n\n");
		outputText("I finally deciphered a ritual in the books and just in time too! The teacher had it confiscated but not before I managed to transcribe a copy. I finally found how to summon that creature I met five years ago. This is very creepy magic but I’m willing to pay any price to have my parents back; and if that Mephi thing can help I will seek him out. ");
		outputText("Heck, the teacher is likely just jealous or afraid I will actually surpass him thanks to Mephi’s help, how short-sighted!\n\n");
		outputText("Day 65 Year 7\n\n");
		outputText("Mephi killed a few students, said it was the price of my debt and that either I had to pay it or they would, I took the wise option. He offered to mentor me but only in exchange for an even greater sacrifice, I am not willing to do such a thing just yet. Since Mephi won’t help without me paying even more I decided not to rely on him for now although he said I would inevitably call him again ");
		outputText("in due time. I need to continue researching for a way to revive my parents so I will keep looking over these books. At worse, I could also revive those dead students so long as I have their corpse right? The teachers are none the wiser, they think someone accidentally summoned that creature in the school and that it started going on a rampage. ");
		outputText("They know little of the fact I traded the lives of my classmates to him in order to gain the information I wanted.\n\n");
		outputText("Day 110 Year 7\n\n");
		outputText("How dare they! I got expelled from the mage school just as I finally found what I needed. The principal called me an undisciplined little witch while the bullies laughed behind my back, well fine I will show them how much of a witch I am! Tonight I will summon Mephi like I did several months ago and this time I will let it feast on everyone. ");
		outputText("Once they are all dead I will pick up the book the teacher took from me and attempt this resurrection ritual.\n\n");
		outputText("Day 111 Year 7\n\n");
		outputText("Mephi killed everyone as predicted and even allowed me to forge a true pact after he gorged himself on the souls of those jerks. The teacher proved to be an annoying challenge but with my newfound knowledge and new otherworldly assistant, dispatching the old scholar was an easy task. Mephi is interesting and willing to help, perhaps I should learn how to harness such powers from him? ");
		outputText("However to my dismay when I went to attempt the revival ritual for my parents and dug up their corpses I discovered to my horror that they had already been disposed of by cremation, only the urn remains and I need an at least partially complete or decaying corpse to perform this magic. Tonight I truly am an orphan for good… I will make my peace with this dream of mine and mourn them then move on.\n\n");
		outputText("Day 160 Year 7\n\n");
		outputText("They are still investigating the incident at the school, but as I predicted I am far away now and with the entirety of the forbidden collection. It is unlikely they will find out anything about what happened, let alone trace it back to me, because for all they know there were no survivors. I also left them a parting gift, and should someone try and visit the school in the following years they will have a nasty surprise.</i>\n\n");
		outputText("You decide to close the book before Alvina catches you reading it. This is getting creepier the more you know about her. Thankfully she didn’t notice and so you head back to camp.\n\n");
		flags[kFLAGS.ALVINA_DIARY] = 3;
		doNext(camp.campFollowers);
		advanceMinutes(20);
	}
	else if (flags[kFLAGS.ALVINA_DIARY] == 1) {
		outputText("While Alvina is busy out of view you open her diary and keep on reading.\n\n");
		outputText("<i>Day 335 Year 2\n\n");
		outputText("I have begun to hear voices.. terrifying voices calling my name. I don’t know how to reply to them however and I am scared. The man is getting increasingly impatient as if waiting for something. Daddy and mommy are ok for now, praise lady Marae, they have stabilised but this could change at any time.\n\n");
		outputText("Day 348 Year 2\n\n");
		outputText("The man is evil, he wants to hurt me. I heard him talk about sacrificing me if things don’t happen in time. The voices are still there too, desperate for me to reach them. I hope this all ends soon. Daddy and mommy look terrible now why did Sis ever open the window!\n\n");
		outputText("Day 349 Year 2\n\n");
		outputText("Blood, there was blood everywhere. When the man tried to hit me with a knife, I screamed and something out of my worst nightmare appeared. The man bowed to it but the creature who in my mind told me to be the lord of the pacts, Mephi-something, killed him turning him into a disturbing mess of gore and blood on the ground before me. I screamed but the monster didn’t kill me too, ");
		outputText("instead he just walked to me and pat me on the head. At that moment I felt strange… as if hot water poured into my body drop by drop, it felt so horribly wrong yet so great. He left saying he would be back in a few years when whatever he did to me would have grown enough that I would be able to call him again, he also said I am indebted to him now but I guess since he saved my life it is not so bad right?</i>\n\n");
		outputText("You decide to close the book before Alvina catches you reading it. This is getting creepier the more you learn about her. Thankfully she didn’t notice, so you head back to camp.\n\n");
		flags[kFLAGS.ALVINA_DIARY] = 2;
		doNext(camp.campFollowers);
		advanceMinutes(10);
	}
	else {
		outputText("As you look in Alvina’s things you notice a small book that was left on a table. Curious you take it with you while she is busy and proceed to read it.\n\n");
		outputText("<i>Day 1\n\n");
		outputText("Hello, my name is Alvina and I am seven years old. Daddy bought me this journal for my birthday saying I should write once in a while about what I think.</i>\n\n");
		outputText("A small drawing of a bunny and a cute goat are on the left side of the page. So far it looks like the diary of a young child, but a few pages later the tone of the content changes dramatically.\n\n");
		outputText("<i>Day 316 Year 2\n\n");
		outputText("Mommy and daddy fell sick. The doctor said only the gods can save them but I’m sure he’s lying. He knows we don’t have the money to buy medicine and I heard a weird man in the neighborhood has offered to help me gather the money so I will seek him out and make do on whatever he wants to save mommy and daddy!\n\n");
		outputText("Day 322 Year 2\n\n");
		outputText("It hurts… it hurts so much. But the man said I have to endure it if I want the money. I heard people who actively accept to work for him have a tendency to disappear and I am scared. Today he used me as part of some strange thing he called a summoning ritual. ");
		outputText("He said he's desperate to talk to someone and needs me for it. My arm is still in pain from the hot iron he marked me with to inscribe some weird drawing into my skin.</i>\n\n");
		outputText("You decide to close the book before Alvina catches you reading it. Thankfully she didn’t notice and so you head back to camp.\n\n");
		flags[kFLAGS.ALVINA_DIARY] = 1;
		doNext(camp.campFollowers);
		advanceMinutes(10);
	}
}
public function alvinaMainCampMenuDiaryNo():void
{
	outputText("You close the book and head back to camp feeling strangely relieved.\n\n");
	doNext(camp.campFollowers);
}
public function alvinaMainCampMenuDiaryAreYouSure():void
{
	clearOutput();
	outputText("Do you resume reading the diary and throw caution out the window?\n\n");
	menu();
	addButton(1, "No", alvinaMainCampMenuDiaryNo);
	addButton(3, "Yes", alvinaMainCampMenuDiaryYes);
}
public function alvinaMainCampMenuDiaryYes():void
{
	outputText("You resume reading the book, whatever is in there you need to know.\n\n");
	outputText("<i>Day 234 year 131\n\n");
	outputText("Damn it all! I should have known this couldn't be perfect. My body is safe but if my soul was to be destroyed I would disappear into nothingness, undone by the very powers that keeps me alive. No one shall ever learn of this weakness. I need to protect the....</i>\n\n");
	if (player.statusEffectv1(StatusEffects.AlvinaTraining2) > 2) {
		outputText("Bah, you read the rest but can’t find anything useful in her journal to grow any more powerful. Alvina, of course, left most of the details of her weaknesses in the shadow though, since she discussed it with you, you already know the full details of what it is.\n\n");
		outputText("\"<i>Had a good read?</i>\"\n\n");
		outputText("Alvina is standing behind you as you expected, her current smirk could pass for creepy. You simply tell her the journal was pretty much useless though you did show much interest into knowing how the mighty Alvina became Mareth’s greatest mage.\n\n");
		outputText("\"<i>Flatterer. You are lucky to already be in on the secret otherwise I would have to destroy you in order to keep you silenced.</i>\"\n\n");
		outputText("She picks up her journal and packs it up back in her bag.\n\n");
		flags[kFLAGS.ALVINA_DIARY] = 6;
		doNext(camp.campFollowers);
		advanceMinutes(5);
	}
	else {
		outputText("\"<i>You know what they say about curiosity [name]?</i>\"\n\n");
		outputText("You turn in time to see Alvina right in front of you smirking sadistically. It's only now that you realize how terrifying she is and caught with her journal in hand all the more so!\n\n");
		outputText("\"<i>It’s soooo sad… You had so much potential but you had to waste it by meddling in my affairs.</i>\"\n\n");
		outputText("She is carrying a scythe you don’t recall seeing before and now that you do see it, you greatly regret reading her journal!\n\n");
		outputText("\"<i>Time to die…</i>\"\n\n");
		startCombat(new Alvina());
	}
}

public function alvinaMainCampMenuConfession():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	if (flags[kFLAGS.ALVINA_FOLLOWER] == 18) {
		outputText("You present the flower to Alvina who blushes in surprise. Delicately taking the flower from your hand, she places it in a glass display case.\n\n");
		outputText("\"<i>I wasn’t sure you would come back alive and with the rose no less, but you did fulfill your end of the bargain and I will fulfill mine. I haven’t had proper sex in a century, so fine, I will give you a try, let’s see what you're made of.</i>\"\n\n");
		flags[kFLAGS.ALVINA_FOLLOWER] = 19;
		alvinaMainCampSexMenu2();
	}
	if (flags[kFLAGS.ALVINA_FOLLOWER] == 16) {
		outputText("You find Alvina somewhat busy packing up her gear. You're surprised she’s leaving this early.\n\n");
		outputText("\"<i>There's no point in me staying here, you successfully learned all I know and did all I asked. I have no further need or interest for you.</i>\"\n\n");
		outputText("Perhaps, but isn’t she at heart a proper succubus? Doesn’t she want to at least give you a try before ditching you and going back to her boring experiments?\n\n");
		outputText("\"<i>Boring? I will have you know I aim to conquer creation itself through magical mastery! As for sharing my bed, good luck with that. I have no interest in love or matters of the flesh. Why do you think I exiled myself away from Lethice’s court when I had power and influence? ");
		outputText("Yes, I’m a succubus, but I’m very picky about my partners. I’m two hundred years too old to just pick up the first poor bastard who happens to cross my path.</i>\"\n\n");
		outputText("How about she steps out of her research for a moment and actually give you a chance to prove your worth?\n\n");
		outputText("At first, she looks at you like she’s about to kill you and you realize she might indeed do just that. However, her expression softens into an amused smile instead.\n\n");
		outputText("\"<i>Um… Perhaps… There is indeed a way you could prove yourself… That is if you can obtain the black rose for me.</i>\"\n\n");
		outputText("The black rose? Just what is she going on about?\n\n");
		outputText("\"<i>Deep underground, in one of Mareth’s labyrinthine dungeons, grows a fabled rose with petals as black as midnight. This flower is said to grant true immortality to whoever possesses it. Thousands of fools died trying to acquire it, either to the plant’s fatal poisonous spikes or to the horrors that guard it, it’s probably just a fairy tale. ");
		outputText("Fact is, the black rose is the facet of a long-lost deity related to death by natural causes and aging. I want to acquire it to study its properties. Bring me the rose and I will offer you a place in my bed.</i>\"\n\n");
		flags[kFLAGS.ALVINA_FOLLOWER] = 17;
		doNext(camp.campFollowers);
		advanceMinutes(5);
	}
}

public function alvinaMainCampSexMenu():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("You tell Alvina you improved on your bed skills and offer her to try you up again.\n\n");
	outputText("\"<i>Ugh if you weren't my pupil, I wouldn't even consider the idea. Fine then, lets see if you make for a decent lover now.</i>\"\n\n");
	alvinaMainCampSexMenu2();
}

public function alvinaMainCampSexMenu2():void
{
	if (player.lib > 50) {
		if (flags[kFLAGS.ALVINA_FOLLOWER] == 19) flags[kFLAGS.ALVINA_FOLLOWER] = 20;
		outputText("You smile perversely and offer to do it right here and right now on your "+(flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed" : "bedroll")+".\n\n");
		outputText("\"<i>Bah! That bed is for amateurs, I recall teaching you bigger than that. Watch this!</i>\"\n\n");
		outputText("She chants an arcane line and a closed door appears out of the ether, seemingly standing on nothing. You ask her what she’s up to when she opens the door. Beyond the cadre, you see what looks like a magnificent bedroom with a large bed fit for an empress and decorated with translucent purple drapes. ");
		outputText("There are various decorations all the more arousing, as well as a cupboard filled with various toys. More than hyped up, you pick up Alvina’s hand and guide her to the bed.\n\n");
		outputText("\"<i>");
		if (sceneHunter.married("Alvina")) outputText(" It’s been so long since last we consummated our love. I’m quite glad you asked, as you know. ");
		outputText("I can spice things up for you, depending on your tastes, by summoning a malefice, so what will it be?</i>\"\n\n");
		outputText("Alvina licks her lips in anticipation, for once interested in something else than her scholarly researches.");
		if (sceneHunter.married("Alvina")) outputText(" Not that you mind. Since the wedding, Alvina has been doing less research on how to bend the universe and more on how for both of you to have the best mind-blowing sex, an initiative you greatly appreciate.");
		//sex menu
		menu();
		if (player.hasCock()) addButton(0, "Pride of Lucifer", alvinaMainCampSexMenuPrideOfLucifer);
		else addButtonDisabled(0, "Pride of Lucifer", "Need to be Male or Herm for this.");
		//addButtonDisabled(1, "Greed of Mammon", "Still unwritten.");
		if (player.hasVagina()) addButton(2, "Blaspheme of Baphomet", alvinaMainCampSexMenuBlasphemeOfBaphomet);
		else addButtonDisabled(2, "Blaspheme of Baphomet", "Need to have pussy for this.");
		if (player.hasVagina()) addButton(3, "Contract of Mephistopheles", alvinaMainCampSexMenuContractOfMephistopheles);
		else addButtonDisabled(3, "Contract of Mephistopheles", "Need to have pussy for this.");
		if (player.hasVagina()) addButton(4, "Gluttony of Beelzebub", alvinaMainCampSexMenuGluttonyOfBeelzebub).hint("Warning this one is weird");
		else addButtonDisabled(4, "Gluttony of Beelzebub", "Not yet coded.");
		addButton(14, "Back", alvinaMainCampMenu);
	} else {
		outputText("It's barely been an hour and Alvina has already become quite bored. She shakes her head negatively and removes herself from you.\n\n");
		outputText("\"<i>You lack both originality and talent even for a demon. Just where’s your libido?! I’m quite disappointed, so nah, I don’t think you're worth my while on this field. Now if you would excuse me I have my stuff to pack up.</i>\"\n\n");
		doNext(camp.campFollowers);
		advanceMinutes(45);
	}
}

private function sexBuffs():void {
	dynStats("lib", 2 + rand(3));
	dynStats("str", 2 + rand(3));
	dynStats("inte", 2 + rand(3));
	player.trainStat("str",2,player.trainStatCap("str",100));
	player.trainStat("int",2,player.trainStatCap("int",100));
	player.trainStat("lib",2,player.trainStatCap("lib",100));
	++flags[kFLAGS.ALVINA_TIMES_FUCKED];
}

public function alvinaMainCampSexMenuPrideOfLucifer():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	if (sceneHunter.married("Alvina")) outputText("You suggest Alvina takes charge this time around and she replies to you with a smug grin. ");
	outputText("You grab the girl by the shoulder and pull her to you for a kiss, Alvina replies in the same way. For someone with such a small looking body, Alvina is way more experienced than she looks. You wrestle for several minutes trying to catch each other’s tongue, but it doesn't end there as Alvina suddenly casts a spell.\n\n");
	outputText("Her form suddenly changes as shadows cover her small frame. She gets taller, up to 6 feet, her breast swelling up as her firm backside fills into a shape closer to that of a standard succubus. Her twilight black hair grows as well, reaching ass length. Finally, her wings also get slightly larger now, stretching wide enough to encompass both sides of the bed. ");
	outputText("Gods above, the perfect hourglass shape, sensual mouth with those perfect cock pillows, juicy pussy dripping with excitement, and generous bosom of your infernal princess look like they were made to tempt and corrupt the hearts of men. She sashays to you, winking playfully at your reaction.\n\n");
	if (sceneHunter.married("Alvina")) outputText("\"<i>I know you love this form a lot, so today");
	else outputText("\"<i>You thought I couldn't change my shape to that of a proper succubus? Think again, because");
	outputText(" I’m going to show you all the delightful things this perfect temptress body can do.</i>\"");
	if (player.tallness > 48) outputText(" pressing her immaculate form against you, your mind fully enveloped by the rush of elation from her erect teets boring into your chest, her soft cheek pressing against yours as those plush lips whisper a tantalizing promise ");
	else outputText(" pressing her immaculate form against you, your head fully enveloped by those plump mounds, intoxicating sweet fragrance mingling with her natural titillating musk and light coat of alluring spice. Her form envelops yours, her chin pressed atop of your cranium, she curls down so her lips rest against the tip of your ear, warm breath cascading over the sensitive skin, ");
	outputText("\"<i>I’m going to ravish you with it.</i>\"\n\n");
	outputText("You barely have the time to register her sentence as her bestial paw hands slowly but firmly push you down on the bed, but your primal instincts are stirred, Alvina leering as her prize stands at full mast beneath her. Your [cocks] draws her attentions, paw gliding against the base and teasing along the veins towards the tip. ");
	outputText("A claw pokes at the entrance of your urethra, threatening to penetrate the cum-tunnel. She pulls her paw away moments later, grinning down eagerly as she advances along your enthralled form. ");
	if (player.cockTotal() == 2) {
		outputText("Alvina leers at her pair of prizes, each one throbbing eagerly, desperate to steal her attentions away from the other. \"<i>Only two, [name]? Just enough to satisfy me, but nowhere close to impressing me.</i>\" She leans down, wrapping an arm around the stiff pair, she holds them flush against her bosom. Leering at the thick meat rods as the wolf does to the ");
		outputText("prized calf, fattened and ripe. Languidly dragging her dexterous tongue along the tip, the devil queen purrs in delight. \"<i>But I suppose you deserve a reward for paltry display.</i>\" Releasing your members from her grasp, she crawls over your enthralled form, tormenting the tips with her infernal skin as she moves past.");
	}
	if (player.cockTotal() == 3) {
		outputText("Alvina smirks at the distended set, playing a claw along each head, rocking her head back and forth. \"<i>What have you been indulging in, [name]? Very few denizens of this insignificant plane can even hope to take this many fat cocks into their wanting holes. Or were you just trying to impress me? Have you been practicing with a few of the beasts you’ve ");
		outputText("decided are worthy, reveling in their hapless cries?.</i>\" She leans in, planting a deep kiss on each of the heads, \"<i>It is...cute to see your attempts to leave me in awe, [name]. Maybe a few more and you may just make my black heart beat.</i>\" Surging forwards, you find yourself face to face with Alvina, her paws pinning your down, eyes boring into your own. ");
		outputText("She leans in, pressing her cheek against yours as whispers into your ear, \"<i>But until then, I will take great pleasure in wringing the rapture from your bones until you are nothing but a writhing heap beneath me.</i>\"");
	}
	if (player.cockTotal() == 4) {
		outputText("A light chuckle escapes those plush lips as she teases the quartet of bitch-breakers at her mercy. \"<i>Mmm, look at you, [name]. Come prepared with enough equipment to fill my holes. Such a sweet "+player.mf("boy","girl")+". I’ll be sure to show you just how much I appreciate your gifts.</i>\" She leans in, planting a deep, sensual kiss along the base of your ");
		outputText("[cock largest], moaning at the delicious flavor of your meat. Languidly licking her way from base to tip, she flows over your group of distended shafts, being sure to tease the tips with a fleeting caress as she advances upon your form.");
	}
	if (player.cockTotal() >= 4) {
		outputText("Alvina licks her lips as she glares down at the forest of meat, looking ready to pounce and devour each meat rod in a moment. Her hot breath washes over the sensitive tips, making them throb with a desire for touch. \"<i>My my my...how ever will I choose which of these cocks to wring dry first? They all look so delicious, so <i>full</i>! I simply can’t decide which ");
		outputText("I want to devour first.</i>\" The heavy tone of desire carried her voice is shared by her visage; a twisted, voracious smile on her lips, extensive tongue rolling against those plush lips. \"<i>I must congratulate you, [name]. You have finally managed to impress me! Such a depraved individual, hosting such a delectable forest of meat...</i>\" ");
		outputText("she pulls the mass of throbbing mounds flush against her luscious pillows, brushing her lips against the tips and playfully teasing the engorged heads, \"<i>and all of it for me~. Mmm~.</i>\" A veteran huntress, eyes wild, frenzied, burning alight as the scent of her prey, of fear, of you, fills her nostrils.");
	}
	outputText("\n\n");
	outputText("Those fiendish eyes, infernal irises encompassing slitted pupils are firmly locked onto your own [eyes]. And at that moment, every ounce of want, need, desire, longing, hunger, every wild surge, primal instincts claiming precedence; every fibre of your being tormented by raging lust. In a moment, every ounce of passion Alvina is afflicted by is transferred through a single look.\n\n");
	outputText("Before you can blink, she is already on top of you. Her claws digging into your arms, restraining you. A massive grin, teeth bared, displaying the rows of perfect, shining white fangs ready to sink themselves deep into your flesh. The devil sorceress leans down, your faces nearly touching, your vision taken by those feral orbs. You feel a faint pressure against your lips, ");
	outputText("the fleeting taste of her left on your lips. She seamlessly drifts across your body, tormenting your skin with such expertise even the most salacious demons would be astonished. Every flick, caress, pinch and stroke perfect; each enthralling touch mesmerizing; your body gladly submitting to your dark mistress above, falling into each skilled brush of her skin against yours.\n\n");
	outputText("You feel her fur sliding sensually on your legs as she climbs up into position, wrapping her immaculate E cup breasts around your [cock]. Pressing your tool against her chest, holding it snuggling between her two massive globes, she coats your trapped member in her infernal saliva. Her hellish saliva cascades down your member, the liquid intensifying every sensation felt tenfold. ");
	outputText("Relishing in that look of helplessness on your face for a few moments longer, she finally leans down and starts to lick your tip. You moan as a blinding ray of colors explodes across your vision as she plays with your [cockhead], and you arc into her motions as your body now demands more. She's only ever stopping, so you can catch your breath, toying with your twitching form. Her tongue ");
	outputText("is just as dexterous as her hand, gently prodding your urethra while tracing your veins making you shiver in agonizing pleasure, thrusting you to the brink of consciousness only to rip you back; unrelenting excruciating ecstasy coursing through every vein. She could get you off within seconds if she wanted but instead, she delays the orgasm with just the right pace to keep you hanging.\n\n");
	outputText("\"<i>I could make you cum like a virgin if I wanted");
	if (player.hasVirginVagina()) outputText(" and hell you are one, I can taste it");
	outputText(". Honestly though, I want to lengthen the torments of your penis longer then that so that you’re mewling in my arms, just as you should be.</i>\"\n\n");
	outputText("As if to prove her point, she begins shifting her flawless bust along your cock.  Agonizing pleasure flows through your form, plush breasts pressing against every vein and igniting every neuron as she moves. Her succubus mouth teases you for a few more minutes, her delectable tits on full display, begging for your touch. ");
	outputText("You manage to grab hold of her unrivaled tits with shaky hands. Groping the cushiony flesh of her breast, you coax a delighted sigh from Alvina as you help her titfuck your cock until your burst. But just as you are about to blow, she retires just in time to deny your release.\n\n");
	outputText("\"<i>You are being very selfish, lover. what about ‘my’ pleasure?</i>\"\n\n");
	outputText("Your frustration doesn't last long as she approaches with the true prize, her slavering pussy, towards your throbbing cock on the verge of orgasm. Expertly wrapping her wonderful vagina around your [cock] she slides down your tool, her impeccable pussy throttling your meat, wrenching you from hitting your peak of pleasure, easily keeping the orgasm at bay. ");
	outputText("She points at your crotch with her clawed hand, a small jolt of magic striking at your penis. You only understand what she’s done a second later as she smirks.\n\n");
	outputText("\"<i>It would be a shame if we didn’t cum together, right? Your delicious cock won’t erupt before I reach an orgasm myself and trust me, I’m very hard to satisfy.</i>\"\n\n");
	outputText("Your pleasure starts peaking again as she begins to slide on your length in earnest, her pussy walls massaging your length with an expertise worth of a hundred years of sexual training! But to your complete dismay, no matter how much pleasure you get, no matter how tightly her pussy clamps down on your tool or how quickly she bounces atop your form you just can’t cum. ");
	outputText("Her expert pussy torments your cock like a master torturer, pleasing you beyond the threshold, way above human tolerance! So measured are her movements, so precise her motions that not even a drop of precum escapes your member; her torturous movements racking your afflicted form with agonizing pleasure.\n\n");
	outputText("Your eyes roll as you begin drooling like a beast, your mind a chaotic haze teetering on the brink of madness, the only clear demand amidst the disarray is to achieve gratification. To cum. Entirely focused on your pleasure addled cock, screaming for release as your hips betray you, your desperation finally reaching its pinnacle. Your body hopelessly pumps into her sex, ");
	outputText("faster and harder than ever before! But, no matter how hard you fight to reach your peak, you remain ever hopeless in the wake of her torments, never achieving the sweet orgasm they so crave.\n\n");
	outputText("Your balls churn with more and more cum, ripening to Alvina’s taste. She finally reaches her long-awaited peak, screaming your name as your tortured cock explodes in a torrent of cum. Every inch of your cock"+(player.cockTotal() > 1 ? "s" : "")+" burns alight with a galvanizing myriad of ecstasies, ");
	outputText("Alvina’s womb quickly overflowing from the relentless torrent of cum that streams from your cock"+(player.cockTotal() > 1 ? "s" : "")+" is unable to contain the excess, pulling away from you,  leaving you and the bed to be showered in your spooge. Alvina, however, is not done as she grabs your still erupting cock.\n\n");
	outputText("\"<i>Mmmmmm... time for my treat. This looks just about ripe.</i>\"\n\n");
	outputText("She licks her lips in delight and to make sure not to lose a drop, as she starts to suck on your drooling penis, drinking the cum as it comes out and prolonging your orgasm. You faint against her as the rush of pleasure overloads your brain, your cock still twitching in her grasp.\n\n");
	sexBuffs();
	player.sexReward("saliva", "Dick");
	doNext(alvinaAfterSex);
}
/*
public function alvinaMainCampSexMenuGreedOfMammon():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("TOO DO\n\n");
	player.trainStat("str",2,player.trainStatCap("str",100))
	player.trainStat("int",2,player.trainStatCap("int",100))
	player.trainStat("lib",2,player.trainStatCap("lib",100))
	alvinaMainCampSexMenu3();
}
*/
public function alvinaMainCampSexMenuBlasphemeOfBaphomet():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("You grab the devil girl by the shoulders, pulling her into a deep kiss. Alvina all too eager to reciprocate. Your tongues dance for a few minutes, the infernal venom coating her orifice igniting your passions, your hands exploring her form greedily but this is not enough. ");
	outputText("You really could use a fucking right now and ask your twilight princess if she has any sex toys in reserve for that.\n\n");
	outputText("\"<i>Oh, a toy won’t be necessary. I can arrange that just fine, it has been some time since last used this spell anyway.</i>\"\n\n");
	outputText("Alvina slowly pulls you down on the bed sitting on your lap and exposing her lovely pussy to your face. It drools a few drops of corrupt femjuice over your chest, the accursed substance making your skin tingle with delight.\n\n");
	outputText("\"<i>To awaken this magic");
	if (sceneHunter.married("Alvina")) outputText(", as you know already");
	outputText(", I need to be more aroused than this. So if you would please show me your talents…</i>\"\n\n");
	outputText("She doesn’t have to tell you twice, diving head first towards her infernal cunt, you begin to lick her lunchbox, tasting the juices of your girl-fiend, delivering the pleasure she desires. Indulging in more of her infernal juices has stirred something deep within, now an unquenchable desire for her pleasure plagues your mind, clouding your thoughts in a thick haze of lust. ");
	outputText("You ravenously attack her cunt, your tongue darting around near sporadically as you try to hit every sensitive spot to bring the naughty devil to orgasm. Her girl juice ignites fires along your tongue, pleasure courses through your form.");
	if (player.tongue.type == Tongue.DEMONIC) outputText(" That said, your demon tongue is perfectly capable of bringing both of you to orgasm and you ravenously play with her cunt using your unique appendage, easily able to stimulate every sensitive area, your prowess aptly exemplified. From above,  you can hear Alvina gasp in delight.");
	outputText("\n\n\"<i>OHHhhh yes [name] keep it up I feel the magic building…!\"</i>\"\n\n");
	outputText("Her pussy gushes with juices, coating your gluttonous maw in her infernal ichor.  To your surprise, her clit begins to pulse as it engorges and grows, flecks of violet demonic energy dances across the engorged flesh. Her enlarging clit notably becomes...sweeter, juicier. Your continued attention enriching the sudden growth, and enthralling you. The unholy, addicting taste ");
	outputText("of her growing appendage pulls your mind away, stealing your will and conforming it to her own demands for pleasure. Growing longer and thicker, her clit occasionally pulses with energy until it turns into something that might as well be a cock. The 15.6 inches long beast of demonic flesh rests happily between her pussy lips, as if jutting out of a sheath, the tip flared ");
	outputText("like that of a horse.\n\nAn intoxicating smell rises from Alvina’s newly grown equine cock, a dollop of pre-cum emerging from the slit. You can’t help but lurch forwards, gripping her new tool between your hands and pulling it to your mouth, vehemently devouring her meaty crown, savoring the flavor of the corrupting fluid. Hells under, her clitcock tastes so good! You need ");
	outputText("this cock! You need this luscious tool to satiate you! You need that cream! Every single drop must be yours!\n\n");
	outputText("Alvina looks down at your form, barely reacting to your worship. Her only sign of acknowledgment, the passive stare in her eyes as she looks at you knowingly.\n\n");
	outputText("\"<i>Can’t resist, right? I bet that's the best cock you’ve ever seen up close, let alone tasted. As with any greater demon, my endowments are charged full of corruption and will drive even the most pious of man insane with desire. Anyone who even dares to stare too long may find themselves enthralled. And while your worship is quite pleasant…!</i>\"\n\n");
	outputText("A clawed hand comes down, latching onto your skull and squeezing down. Searing pain rips through your skull, Alvina’s astounding strength made known in an instant, stalling your ministrations. Her monstrous tool still partially lodged in your maw, its essence still dripping onto your tongue, blessing your taste buds with its addictive juice. ");
	outputText("\"<i>Your worship is pathetic, champion. Here, allow me.</i>\"\n\nYou cannot fight her wishes, your mind enthralled by her precum, ");
	outputText("head held in her grip, her cock lodged inside your mouth, and Alvina herself clearly craving more pleasure. Panic wells in your eyes as they widen, Alvina now forcing more of her pseudo-member into your mouth. It’s much thicker than you had first realized, only now as your jaw is forced to accommodate her girth do you understand that fact.\n\n");
	outputText("Peering through her claws, you note your devil-girl’s visage to be one of pure rapture. Eyes fluttering rapidly, bottom lip bit barely holding back her moans, Alvina finally seems to be enjoying your ministrations. It is then that she peers down at you, those fiendish irises locking onto your own. A shift in her countenance, no longer one of bliss but domination. ");
	outputText("A massive grin now on her face, her rows of fangs now visible to the world as she relishes in the growing apprehension suffusing your form.\n\n");
	outputText("A sudden jerk of your cranium is all the warning you receive before that behemoth is shoved against the entrance of your throat. Alvina shivers, her body racked by pleasure before pulling back slightly, readying herself to conquer your throat. Knowing her exact intentions, you place a "+(player.haveNaturalClaws() ? "claw":"hand")+" against her knee, ");
	outputText("begging her to stop or at the very least take you slowly. Yet this only seems to invigorate your partner, her eyes glowing with malicious glee as her grin widens.\n\n");
	outputText("She slams herself forwards, taking your throat in a single thrust. You sputter and gag, choking on the sudden protrusion buried deep within your gullet, while Alvina arcs into your form, pressing your head into her crotch as she lets out a cry of ecstasy. Her cries for more are the only thing you can even remotely register. Foregoing any cautionary thoughts, you force down ");
	outputText("more and more of her captivating flesh, now graciously deep throating her beguiling member all of your own will. Alvina joins your motions, now moving her hips, thrusting more of that mind-blowing meat down your gullet until her entire length is coated in a thin sheen of saliva. She abruptly pulls her cock away, depositing a few delicious drops of corrupt precum in your mouth.\n\n");
	outputText("She taunts you with her bewitching cock, only allowing you a minute to sample what you crave, what you desire and what you need. A piteous cry of longing flies from your battered throat as you attempt to pounce at your mistress, driven by your insatiable thirst for her seed. A sudden spark flares in Alvina’s eyes as her lip curls in loathing at your actions.\n\n");
	outputText("Tendrils of malicious arcane seep from her fingertips; shadowy flames running through her veins, her infernal blood running black as her claw slams onto your head. Her disdain in light of your actions now made known, her incredible strength bearing down upon your skull, threatening to shatter your frail cranium.  Forcing you to look into her eyes, her seething glare piercing ");
	outputText("through your petrified peer.\n\n\"<i>You overstep your bounds, you worthless "+player.mf("bastard","cunt")+". I blessed you with my cock, allowed you to slather my tool in your detestable juices, and the moment I remove myself for a reprieve from your paltry administrations, you dare attempt to overpower me? Such a boorish excuse of a pet you are, champion. No control, ");
	outputText("no restraint, no respect.</i>\"\n\nShe squeezes down on your skull for but a moment, sending a jolt of excruciating pain through your head, forcing a yelp of anguish from your lips.\n\n");
	outputText("\"<i>Seeing as you are so adamant on worshipping my glorious member, I will grace you with every single inch of your desire.</i>\" Her voice low, the malicious undertone heralding a callous reply.\n\n");
	outputText("Her moist meat rod breaks through your lips once more, her grip tightens, ripping you forwards. Her cock slides down your throat with ease, your head slamming into her crotch in a single thrust, her monstrous strength coercing your lips into an intimate relationship with the thick base of her shaft. ");
	outputText("\"<i>There, champion. All the cock you could ever want.</i>\"\n\n");
	outputText("While this "+(player.hasPerk(PerkLib.Masochist) ? "":", minus the pain")+", is exactly what you want, there is a glaring issue with this scenario: air.\n\n");
	outputText("Alvina’s cock now holds absolute dominion over your airways, and you can already feel your lungs burning up, begging for fresh air. You tap your demonic partner’s thighs, yet she still keeps you pressed against her groin.\n\n\"<i>What’s the matter, champion? ");
	outputText("Isn’t this what you wanted? Your throat is now utterly filled with my cock! Isn’t it wonderful? Oh? You want me to pull out again? Because of what? Fresh air? How could I ever be so cruel as to leave my champion without its favorite meal. Certainly not before you make me cum? If you want your precious air to fill your lungs, my cock cream fills your throat first.</i>\"\n\n");
	outputText("With an unrelenting grip, Alvina forces your head flush against her crotch, refuting any of your attempts to pull away. Luckily, judging from the constant throbbing of her shaft, you can tell she’s nearing her climax. All your previous efforts to worship her magnificent tool affording you a modicum of hope, however minor it may be. The frequency of her cock pulses ");
	outputText("thankfully relays that she’s at least halfway there! You’ve got a chance at getting her off before running out of air!\n\n");
	outputText("Your tongue remains crushed under her massive cock rammed down your throat. Her scorching rod incinerates your tongue’s surface, tears streaming down your face due to the pain of being forced to suffer such excruciating heat. And yet, the lust that burns through your veins and clouds your mind in a dense fog ignite your passions, masochistic pleasure taking command of your actions. ");
	outputText("It hurts, but it hurts oh so well! You want more of this unbearable heat, more of this ravenous flame, more of this overbearing inferno!\n\n");
	outputText("Enthralled by your lust, enslaved by your needs you waste no time. Tongue crushed under her thick tool, lips mashed against her base, your ministrations are heavily impeded. Alvina’s haughty glare never shifts. You try to pull some sort of visible pleasure from the demoness, dragging the tip of your [tongue] along the base of her cock, outlining the pulsing veins that are within ");
	outputText("your reach, manage to choke out meek moans, sending out pleasing shocks along her demonic tool. Her distended member lodged deep in your throat, nearly defiling the inner sanctum of your stomach with its foul presence, dribbles a sparse sample of unholy blessing.\n\n");
	outputText("Alvina moans as the drop of cum slides down your tight throat. The burning drop running down your esophagus adding to the lustful pyre ignited by her musk, her sweet juices, and her utter dominance of your form. It’s so wrong to love it, to love this blatant abuse, her claws squeezing your head painfully as she watches you choke on her cock. But every moment you spend suffocating ");
	outputText("on that beast of a tool, every meager drop of cum given for your work, every scorching sensation that torments your tongue as you please your rightful mistress compels you further along your journey into depravity. What toll is too great to pay for such blasphemous ecstasies?\n\n");
	outputText("Tears stream down your face as your body screams for air. Alvina’s grip on your head tightens as she begins to drizzle that sweet, corrupting ichor down your throat. The sensations of such delectable cream going down your throat while your consciousness slowly fades away with each labored breath are exhilarating! ");
	outputText("You keep moaning meekly, sending shocks of pleasure through your mistress’ delicious cock, being rewarded with a steady stream of cum.\n\n");
	outputText("Alvina is getting close! Mistress will feed you her cum! Just a bit more an-\n\n");
	outputText("Alvina abruptly pulls her cock out of your throat, causing you to fall forwards sputtering and hacking, desperately sucking in as much air as possible. Eyes still on her bitch-breaker, its payload steadily leaking out of her cumslit. You make to crawl forwards, desperate to devour the dribbling stream going to waste. Yet the ominous glare Alvina fixes you with halts you in your tracks.\n\n");
	if (player.biggestTitSize() >= 2) outputText("She gropes your lovely [breasts] teasing your nipples as she gets into position, using your globes for handles. ");
	outputText("Alvina begins to part your pussy lips with her flared tip, smearing corrupted pre around your entrance which tingle and puff up right away in delight at the liquid corruption. You moan deliriously, pleading her to go in and fill you full of her demonic horseflesh. Alvina smirks cutely, showing her fangs, as she slowly inserts her cock inch by inch in your [pussy], ");
	outputText("her veins pulsing against your walls. She is purposely making the initial insertion as long as possible to torment you and hell this is exactly how you like to be treated. Her pulsing flesh molds your cunt around her cock naturally either because your pussy is made for it or because her cock is the perfect tool capable of fitting any vagina to its shape. ");
	outputText("You can’t control yourself and you scream for her to fuck your soul out of your succubus pussy and heck, if your soul wasn’t already out of your body you think it would have flowed out by now from the sheer power of pleasure you are receiving. You begin to buck your hips in an attempt to stimulate your partner and Alvina moans in pleasure as both of you begin to slide in and out ");
	outputText("of each other, her horsecock hitting your clitoris on every strike. Before you know it you are orgasming several times, your pussy gushing corrupted juice which only arouses Alvina more, fucking your pussy until you can’t cum anymore. Speaking of cum, no matter how many times the demoness fills your cunt with strands of white sponge her cock simply won't deflate. ");
	outputText("It goes for so long that the bed itself becomes soaked with your combined fluids.\n\nYou pass out from the overstimulation as your pussy gush yet again, losing track of time and space, only recovering awareness several hours later, still getting fucked by Alvina but utterly satisfied. She gives you a gentle kiss before whispering in your ear.\n\n");
	outputText("\"<i>Finally satisfied lover…? Your pussy just wouldn’t let go. You sure are a thirsty one, aren’t you? ");
	if (sceneHunter.married("Alvina")) outputText("This is one of the things I love so much about you.");
	else outputText("I like that in a girl.");
	outputText("</i>\"\n\nThe dimension fades as the two of you reappear in camp feeling energized. She’s god-damn right and you sure would do it again.\n\n");
	sexBuffs();
	player.sexReward("cum", "Vaginal");
	doNext(alvinaAfterSex);
}
public function alvinaMainCampSexMenuContractOfMephistopheles():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("Alvina makes an impish smile as she readies the malefice and the entire room suddenly starts to fade, turning into what looks like a fleshy cavern. You aren’t that sure of what’s going on until the walls suddenly turn alive with tentacles slithering out from them. Alvina doesn’t seem to be scared, heck she is already caressing one of the things like a well-loved pet ");
	outputText("and it wriggles in her hand coiling for further affection.\n\n\"<i>You ought to admit, you always were curious about what an eternity of getting fucked by tentacle beasts must feel like. Truthfully, I sometimes lock myself in this secret pleasure room of mine for entire days. Just lay back and enjoy, though I must warn you, they tend to get carried away. Their contract is clear, ");
	outputText("they will fuck both of us until we lie as broken and drooling messes on the ground... think you can endure it?</i>\"\n\nThe tentacles get to work, slowly coiling around Alvina’s body, as some stretches to yours. Truth be told, even if you wanted to repel them now, without a weapon or armor it would be a difficult battle. Furthermore, you believe Alvina is in complete control ");
	outputText("of this pocket dimension and wouldn’t let her pupil suffer a slimy end at their ministrations. As the fleshy things coil around your legs, you move to Alvina, embracing her body along with the tentacles coiling around her. The slithering flesh of the tentacles slides around your skin and hers groping at your and Alvina’s breasts and masterfully squeezing them. Your eyes open wide ");
	outputText("in surprise as the things pull your two legs away holding you in the air for a tentacle to wildly ram itself into your pussy sliding in up to your womb where it starts to wriggle wildly. Another tentacle finds your ass making you gasp as it stretches your pucker wide. Alvina’s cheeks are already bright red from the fucking as she smashes her breast with yours trying to increase ");
	outputText("the tentacles stimulations. A tentacle decides to help you both by sliding between the sandwich of your tits.\n\n");
	outputText("\"<i>See? You're making such a wonderful face right now. These creatures respond to pleasure and the more you will allow them the more they will take. Oooooh fuuuck YES!!! Do me! Do me more!!!...</i>\"\n\n");
	outputText("You moan and spasm at the crazy fuck, your very innards coming to life and just as you open your mouth to scream your delirious pleasure in a slutty moan, you feel your stomach churning and your eyes rolling as the tentacle in your bowel finally finish its course, slithering out of your throat and gagging you, as it rushes into Alvina’s waiting mouth connecting both of you ");
	outputText("into a perverse kiss. You barely register the tentacle surging out of her anus in a gush of cum as both of you are fucked silly, your stomachs bulging and squirming with the tentacles inside. Your pussy has gone crazy, your anus has gone crazy, your entire body has gone crazy, you’ve gone crazy. ");
	if (player.hasCock()) {
		outputText("Just as you thought it couldn't get better, you feel your cock being grabbed by something as a tentacle equipped with a fleshy suction cup plugs you in and begins to suck up all of your leaking precum. Soon, you’re cumming a constant river into the tube as shattering pleasure rushes to your mind like a tidal wave, as your pussy and cock takes on a mind of their own and betray you, ");
		outputText("forcing your body to buck up in tandem with the tentacles' movement. ");
	}
	outputText("You slowly lose the concept of time as the tentacles fuck you, drenches you in cum, and wrecks your spasming body again and again. A tentacle even forced its way into Alvina’s ass and surged back out of her mouth and shoved itself right into yours, exploring your body up to the exit and cumming out of your anus. ");
	outputText("The ground is constantly soaked with your fluids, which you barely register being drunk by some kind of weird orifice.\n\n");
	outputText("You pass out from the overstimulation abandoning yourself to the wild fucking of the tentacles.\n\n");
	sexBuffs();
	player.sexReward("cum", "Vaginal");
	doNext(alvinaAfterSex);
}
public function alvinaMainCampSexMenuGluttonyOfBeelzebub():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("You grab the girl by the shoulder and pull her in for a kiss as your girl-fiend replies in the same way. For someone with such a small, immature looking body, Alvina is way more experienced than she looks. You wrestle for several minutes, suckling on each other’s tits, fingering and grinding pussies, but it doesn't end there, as Alvina suddenly casts a spell. ");
	outputText("Before you know it the bed turned into a living mass of cock shaped larvae looking for an orifice. You gasp in surprise and delight when some of them enter your pussy, filling your holes and squirming inside. Alvina isn’t spared either her vagina is already squirming with the penis shaped larvae.\n\n");
	outputText("\"<i>Ahhhn! Beelzebub's couch is quite a lovely spell, I could never get rid of it. These larvae feed on fluids and are quite smart, do you feel it… all up to your cervix? Do let them satisfy their endless gluttony.</i>\"\n\n");
	outputText("Oh yes, you can feel them… it's like the larvae are all working together to bring you to climax! You cum once, twice, thrice! Each time you cum the worms squirming intensify as they rush into your vagina to be the first to get a drop, making a constant maelstrom in your pussy as they all push into your clit. You can’t hold it anymore, your eyes rolling as you lock in a hug with Alvina, ");
	outputText("mindlessly bucking your hips in the air as the inside of your hole is filled with squirming madness. Both of you begin to grind your pussies against each other to increase the maddening pleasure and, not content with simply driving your inside insane, the larvae begin to flood from your pussy to Alvina’s and backward sliding between the two of you and connecting your cunts ");
	outputText("with a slimy double dildo made of squirming bugs. You keep bucking your hips as your pussies touch then part ways linked by a chain of squirming larvae. Your vagina suddenly fills up with cum as the dick-larvae all starts to bottom out inside your pussy, cuming in all directions and painting your inner walls. That done the larvae all proceed to leave your cunt one by one. ");
	outputText("This is way too much and you start orgasming consecutively each time one slides out, your pussy spewing them out with a torrent of cum as you begin to babble and drool. Alvina is in a similar state smiling with an ecstatic expression as the larvae flood out of her drenching pussy. Once outside, they merge back in the bed, disappearing in whatever dimensional hole they came from.\n\n");
	outputText("Both of you stay entangled in one another still tired after the crazy ordeal.\n\n");
	sexBuffs();
	player.sexReward("cum", "Vaginal");
	doNext(alvinaAfterSex);
}
public function alvinaAfterSex():void
{
	if (flags[kFLAGS.ALVINA_FOLLOWER] >= 20) {
		outputText("A while later you wake up. Alvina is sitting next to you yawning as she dresses up.\n\n");
		outputText("\"<i>Always a delight to have a good time with you, lover. We will resume for another round a different time because for now, I have experiments and researches to continue.");
		if (sceneHunter.married("Alvina")) outputText(" You know all too well I ought to find better ways to improve our pleasure because in all honesty sex with you is one of my biggest joys in life.");
		outputText("</i>\"\n\nYou get dressed and part with her as you head back to your things.\n\n");
	}
	else {
		outputText("A while later you wake up. Alvina is sitting next to you yawning as she begins to re-dress in her usual somewhat minimalist bikini mage armor.\n\n");
		outputText("\"<i>You ain’t that bad of a demon. I expected you to freak out or perhaps even die from the stimulation but you endured it, so I guess I'll keep you as my lover for a while. See me in camp if you're interested in some fun big "+player.mf("boy","girl")+".</i>\"\n\n");
		outputText("You re-dress and part with her as you head back to your things.\n\n");
		outputText("<b>Alvina is now your lover.</b>\n\n");
		flags[kFLAGS.ALVINA_FOLLOWER] = 20;
	}
	endEncounter();
}

public function alvinaHenchmanOption():void {
	menu();
	if (flags[kFLAGS.PLAYER_COMPANION_1] == "") {
		if (flags[kFLAGS.PLAYER_COMPANION_2] == "Alvina" || flags[kFLAGS.PLAYER_COMPANION_3] == "Alvina") addButtonDisabled(0, "Team (1)", "You already have Alvina accompany you.");
		else addButton(0, "Team (1)", alvinaHenchmanOption2, 1).hint("Ask Alvina to join you in adventures outside camp.");
	}
	else {
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Alvina") addButton(5, "Team (1)", alvinaHenchmanOption2, 21).hint("Ask Alvina to stay in camp.");
		else addButtonDisabled(5, "Team (1)", "You already have other henchman accompany you as first party member. Ask him/her to stay at camp before you talk with Alvina about accompaning you as first party member.");
	}
	if (player.hasPerk(PerkLib.IntermediateLeadership)) {
		if (flags[kFLAGS.PLAYER_COMPANION_2] == "") {
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Alvina" || flags[kFLAGS.PLAYER_COMPANION_3] == "Alvina") addButtonDisabled(1, "Team (2)", "You already have Alvina accompany you.");
			else addButton(1, "Team (2)", alvinaHenchmanOption2, 2).hint("Ask Alvina to join you in adventures outside camp.");
		}
		else {
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Alvina") addButton(6, "Team (2)", alvinaHenchmanOption2, 22).hint("Ask Alvina to stay in camp.");
			else addButtonDisabled(6, "Team (2)", "You already have other henchman accompany you as second party member. Ask him/her to stay at camp before you talk with Alvina about accompaning you as second party member.");
		}
	}
	else {
		addButtonDisabled(1, "Team (2)", "Req. Intermediate Leadership.");
		addButtonDisabled(6, "Team (2)", "Req. Intermediate Leadership.");
	}
	addButton(14, "Back", alvinaMainCampMenu);

}
public function alvinaHenchmanOption2(slot:Number = 1):void
{
	clearOutput();
	if (slot < 21) {
		outputText("\"<i>Such sloth, you truly do ask me to fight for you? Well I might just humor you and practice my more ‘experimental’ magic on your enemies. New spells requires experiments and I am always eager for new ‘living’ test subjects.</i>\"\n\n");
		outputText("Alvina is now following you around.\n\n");
		var strAlvina:Number = 375;
		var inteAlvina:Number = 480;
		var libAlvina:Number = 375;
		strAlvina *= (1 + (0.2 * player.newGamePlusMod()));
		strAlvina = Math.round(strAlvina);
		inteAlvina *= (1 + (0.2 * player.newGamePlusMod()));
		inteAlvina = Math.round(inteAlvina);
		libAlvina *= (1 + (0.2 * player.newGamePlusMod()));
		libAlvina = Math.round(libAlvina);
		player.createStatusEffect(StatusEffects.CombatFollowerAlvina, strAlvina, inteAlvina, libAlvina, 0);
		if (slot == 2) flags[kFLAGS.PLAYER_COMPANION_2] = "Alvina";
		if (slot == 1) flags[kFLAGS.PLAYER_COMPANION_1] = "Alvina";
	}
	else {
		outputText("Alvina is no longer following you around.\n\n");
		player.removeStatusEffect(StatusEffects.CombatFollowerAlvina);
		if (slot == 22) flags[kFLAGS.PLAYER_COMPANION_2] = "";
		if (slot == 21) flags[kFLAGS.PLAYER_COMPANION_1] = "";
	}
	doNext(alvinaMainCampMenu);
	cheatTime(1/12);
}

public function alvinaCampStudy():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	if (player.gems < 50 || player.lust < 50) {
		outputText("Alvina looks up at you and sighs in annoyance.\n\n");
		if (player.gems < 50) outputText("\"<i>It’s 50 gems for each session, the training materials don’t come cheap you know and I won’t pay for their expenses.</i>\"\n\n");
		else outputText("\"<i>I can’t teach you the dark arts if you are not suitably aroused! Black magic is the art of giving shape to your desires, and without any desires of your own, there is no way you will be able to learn anything. Come back later when you have the correct mindset.</i>\"\n\n");
		outputText("She dismisses you, adjusts her glasses, and resumes reading one of her many hentai comics.\n\n");
		if (rand(2) == 0) outputText("\"<i>Hmm...I wonder if you could really fit a pineapple in your ass...</i>\" She ponders this weird question as you back away.\n\n");
		else {
			if (rand(2) == 0) outputText("\"<i>Do you think, if I tried hard enough, I could fit this chair inside me [name]?</i>\" You try not to think about this weird question as you back away.\n\n");
			else {
				if (rand(2) == 0) outputText("\"<i>Various recipes for cooking lethicite mmm… perhaps I should try that one with fellblooms.</i>\" You back away before she considers using yours for it.\n\n");
				else {
					if (rand(2) == 0 && Holidays.isAlvinaBirthday()) {
						outputText("\"<i>Did you know that Lethicite can be used as icing for cakes? A decent demon should have a frozen soul on every dessert really. I also heard only Lethice can afford such a delicacy daily. My birthday is in a few days so I hadn’t considered until now whether I want a cake or not.</i>\" You back away before she considers using yours.");
						if (!player.hasPerk(PerkLib.Phylactery)) outputText(" You back away before she considers using yours.");
						outputText("\n\n");
					} else {
						if (rand(2) == 0 && flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText("\"<i>Umph I read the latest news, apparently you shut down the factory… nice job, the overseer there was an incompetent slut who deserved to get fired anyway.</i>\" Well getting praised for your heroic acts is one thing, but the way she casually talks about it makes it sounds like you didn’t accomplish anything of serious relevance.\n\n");
						else outputText("\"<i>Did you know bee girls actually aren’t immune to corruption? I caught and used a few handmaidens as test subjects for some new spells before releasing them back to their hive. Apparently, you can create an entire army of demons just by corrupting a few and letting them spread mayhem and lust back home, very fascinating.</i>\"\n\n");
					}
				}
			}
		}
		doNext(camp.campFollowers);
		advanceMinutes(5);
	} else {
		outputText("Strangely, despite being a demon, Alvina makes for a great teacher. She corrects your posture when you miss a movement and helps you learn faster than you would by just reading books.\n\n");
		outputText("\"<i>Still daydreaming in the middle of my lectures [name]?</i>\"\n\n");
		outputText("You quickly jerk back into action to show you're listening. Alvina resumes explaining the universal principle of how to channel desire into power. You learn a lot, but the way she flaunts her body, and the many innuendos she punctuates the lesson with, make you flush red in arousal.  During the entire lesson, your teacher is teasing you, ");
		outputText("and there's nothing you can do about it but wait patiently for the end of the lecture. By the time you get to doing something practical, you are so aroused you feel your lust rise uncontrollably just from casting those spells as wild fantasies assault your mind.\n\n");
		if (player.intStat.train.value > 80 && player.libStat.train.value > 80 && flags[kFLAGS.ALVINA_FOLLOWER] == 15) {
			outputText("You finally achieved complete mastery over your lust, conquering your arousal and turning it into a weapon to use against your foe as you unleash a massive blast of black magic on the target dummy.\n\n");
			outputText("\"<i>Very good [name], you finally achieved mastery of the theory. Tomorrow we will discuss more advanced principles.</i>\" She dismisses you with these congratulations as you head back to camp feeling both sexy and powerful.\n\n");
			player.createStatusEffect(StatusEffects.AlvinaTraining, 0, 0, 0, 0);
			dynStats("inte", 4, "lib", 4, "cor", 3);
			player.trainStat("int",4,player.trainStatCap("int",100))
			player.trainStat("lib",4,player.trainStatCap("lib",100))
			flags[kFLAGS.ALVINA_FOLLOWER] = 16;
		} else if (player.intStat.train.value > 50 && player.libStat.train.value > 50 && flags[kFLAGS.ALVINA_FOLLOWER] == 14) {
			outputText("Against all odds, you manage to hold your lust in check and cast the spells properly.\n\n");
			outputText("\"<i>That will be all for today [name], we will continue tomorrow.</i>\" You head back to camp feeling extremely pent-up, but also smarter.\n\n");
			dynStats("inte", 7, "lib", 7, "cor", 2);
			player.trainStat("int",7,player.trainStatCap("int",100))
			player.trainStat("lib",7,player.trainStatCap("lib",100))
			flags[kFLAGS.ALVINA_FOLLOWER] = 15;
		} else {
			outputText("Unable to hold back any longer, you orgasm as you cast the spell. Alvina is amused by your lack of endurance.\n\n");
			outputText("\"<i>Well aren’t you the lewd student. Regardless, you will need to practice until you develop some resilience. Come back tomorrow to resume your training.</i>\" She dismisses you, leaving you to clean up your mess. At least you learned a few new things.\n\n");
			dynStats("inte", 10, "lib", 10, "cor", 10);
			player.trainStat("int",10,player.trainStatCap("int",100))
			player.trainStat("lib",10,player.trainStatCap("lib",100))
			flags[kFLAGS.ALVINA_FOLLOWER] = 14;
		}
		explorer.stopExploring();
		doNext(camp.returnToCampUseSixHours);
	}
}

public function alvinaCampAdvancedStudy():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3 && player.hasKeyItem("Siegweird's holy symbol") >= 0) {
		player.removeKeyItem("Siegweird's holy symbol");
		outputText("You hand over the holy symbol to Alvina, who smirks as if a long-drawn-out battle was finally over.\n\n");
		outputText("\"<i>That concludes our business. I took the liberty of writing this spell in a scroll. So here, you can have it.</i>\"\n\n");
		outputText("She throws a scroll at you and begins to pack up her things.\n\n");
		outputText("<b>You gained a scroll of Polar Midnight.</b>\n\n");
		player.addStatusValue(StatusEffects.AlvinaTraining2, 1, 1);
		inventory.takeItem(consumables.POL_MID, camp.campFollowers);
		AlvinaGaveScroll = true;
		advanceMinutes(5);
	}
	else if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 2 && player.hasItem(useables.AMETIST, 1) && player.hasItem(consumables.L_DRAFT, 5) && player.hasItem(useables.SOULGEM, 5) && (player.hasKeyItem("Marae's Lethicite") >= 0 && player.keyItemvX("Marae's Lethicite", 1) > 0 || player.hasKeyItem("Stone Statue Lethicite") >= 0)) {
		player.destroyItems(useables.AMETIST, 1);
		player.destroyItems(consumables.L_DRAFT, 5);
		player.destroyItems(useables.SOULGEM, 5);
		if (player.hasKeyItem("Stone Statue Lethicite") >= 0) player.removeKeyItem("Stone Statue Lethicite");
		else player.addKeyValue("Marae's Lethicite", 1, -1);
		outputText("You show up with all the required items and the demoness smiles.\n\n");
		outputText("\"<i>Good, I wasn’t expecting you to collect those items so quickly. Once again you’ve exceeded my expectations.</i>\"\n\n");
		outputText("She arranges the soul gemes on the ground to form a magic circle, cutting herself with a dagger to draw the lines using her own blood she then hands you over the knife.\n\n");
		outputText("\"<i>To properly remove the soul without it turning to Lethicite we will need to extract some of your flesh as a temporary vessel. I trust you have the resolve...</i>\"\n\n");
		outputText("You don’t need her repeating herself and cut straight into your side, wincing as you cut a fairly sized chunk, healing the wound afterward. Alvina takes the freshly cut morsel of skin and chant the spell, the organic matter sinking in the gem of the necklace where it won’t risk decaying. When all preparations are done, she has you silently rehearse the line repeatedly so you don't mess up.\n\n");
		outputText("\"<i>Wouldn’t want to accidentally lose your soul because of a failed ritual right, [name]? Repeat after me…</i>\"\n\n");
		outputText("You repeat it a few times, then finally, ready for the real one. As instructed, you stand in the middle of the circle, holding the items next to your heart and start incanting after drinking the five lust draft in one go.\n\n");
		outputText("\"<i>Ahgn akoshor fisfis arci gorshaness firnklir gorash nok arokis severis...</i>\"\n\n");
		outputText("You hold yourself back from cumming several times; knowing full well that if you do, your soul is forfeit. A ghostly thread starts to form between your chest and the necklace, as the thread stabilizes, you see something being extracted bit by bit from you in the form of white mist, which is swiftly absorbed by the chunk of flesh in the amulet. ");
		outputText("You continue incanting until the white mist has been entirely absorbed, then sigh in relief now that the incantation is complete. Allowing yourself to masturbate to satisfaction. Alvina eyes you up and down then congratulates you on your success.\n\n");
		outputText("\"<i>Congratulations, for not only are you now a true demon, you’ve kept your soul intact. A small piece of advice: don't lose that pendant or you will die. I suggest you keep it next to you at all times. ");
		outputText("If a demon got ahold of it, he could likely drink it in the same way as Lethicite and you would wind up soulless like all the other idiots. Depending on the way your opponent uses the pendant, you could end up dead as well.</i>\"\n\n");
		outputText("Wait WHAT!!! The phylactery has such a fatal flaw!? Couldn’t she had told it to you sooner! Now you will have to live with the terror of knowing your life is tied to an item and that alone is terrifying in itself. Alvina, however, does not seem bothered.\n\n");
		outputText("\"<i>And now for the last test... if you want to learn that one final spell I need you to kill someone.</i>\"\n\n");
		outputText("Wait, kill someone? Who?\n\n");
		outputText("\"<i>You heard me right. I need you to kill a paladin by the name of Siegweird who patrols the Blighted Ridge. Bring me back his holy symbol as proof of your deed and I will teach you the greatest spell in my arsenal.</i>\"\n\n");
		outputText("She jumps to sit on a nearby stool and crosses her legs, tapping her chin as she’s seemingly remembering something important.\n\n");
		outputText("\"<i>Oh! That's right, a last warning. In case you had ‘fantasies’ of rebellion against me... I had a few extra components inserted into the spell used to create your phylactery. Should you attempt anything ‘out of line’ I can force it to explode as easily as snapping my finger.</i>\"\n\n");
		outputText("You realize Alvina has your very life in the palm of that cute paw of hers. It's a terrible realization but at the same time, it dawns on you that you have no reason to antagonize her. Truth be told, having a good relation with a font of power like her could only prove beneficial could it not?\n\n");
		player.addStatusValue(StatusEffects.AlvinaTraining2, 1, 1);
		player.createPerk(PerkLib.Phylactery, 0, 0, 0, 0);
		if (player.cor < 100) player.cor = 100;
		explorer.stopExploring();
		doNext(camp.returnToCampUseSixHours);
	}
	else if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 1) {
		if (player.isRace(Races.DEVIL, 1, false) || ((player.isRace(Races.DEMON, 1, false)||player.isRace(Races.IMP, 1, false)) && player.gender > 0)) {
			if (player.isRace(Races.DEVIL, 1, false)) {
				outputText("You ask Alvina if this form will work, and she looks at you, amused.\n\n");
				outputText("\"<i>Well, I didn't expect you to like my form that much. How flattering. I guess you didn’t want to be part of the common rabble, did you? You just had to go a special path? Oh well, like apprentice like master I guess?</i>\"\n\n");
			}
			else if ((player.isRace(Races.DEMON, 1, false)) && player.gender == 1) {
				outputText("You ask Alvina if this form will work, swinging your [cock] for her to admire.\n\n");
				outputText("\"<i>A slavering incubus fits you perfectly.</i>\"\n\n");
			}
			else if (player.isRace(Races.DEMON, 1, false) && player.gender == 2) {
				outputText("You ask Alvina if this form will work, giving her a nice view, putting your [chest] and your [pussy] on display.\n\n");
				outputText("\"<i>A slutty succubus fits you perfectly.</i>\"\n\n");
			}
			else if (player.isRace(Races.IMP, 1, false) ) {
				outputText("You ask Alvina if this form will work, giving her a nice view of your impish body.\n\n");
				outputText("\"<i>Not my first choice, though I suppose an imp qualifies.</i>\"\n\n");
			}
			else {
				outputText("You ask Alvina if this form will work, giving her a nice look, putting your [chest] on display and swinging your [cock] above your [pussy] around so she can admire both.\n\n");
				outputText("\"<i>Couldn’t make a choice? Well, an omnibus fits you perfectly. I was never very interested in having all the possible endowments, however.</i>\"\n\n");
			}
			outputText("Alvina circles you for a moment, examining you thoroughly.\n\n");
			outputText("\"<i>You look demonic alright, but you still lack the power, a power only a soulless body can provide. First, we need to create the soul prison. Get me a flawless Amethyst necklace, five lust drafts, five soul gems, and a piece of very powerful Lethicite then we can begin.</i>\"\n\n");
			player.addStatusValue(StatusEffects.AlvinaTraining2, 1, 1);
		}
		else outputText("\"<i>You are still way too pure for us to proceed further. Corrupt your body with some demonic transformatives and we will continue.</i>\"\n\n");
		doNext(camp.campFollowers);
		advanceMinutes(5);
	}
	else if (player.hasStatusEffect(StatusEffects.AlvinaTraining2)) {
		outputText("You ask your teacher if there is nothing else she can teach you.\n\n");
		if (player.cor >= 100) {
			outputText("\"<i>To fully gain power from black magic your human body will no longer be enough, truth be told your soul is currently holding you back. Without the body of a demon, you will not be able to attain further power.</i>\"\n\n");
			outputText("Frustrated you ask if this is the end of the lessons?\n\n");
			outputText("\"<i>I said you need to become a demon. I never said that you had to forfeit your soul to do it. So stop making that disappointed face and hear me out. While most demons are created when they cum their soul out, an uncontrolled release which crystallizes the soul into lethicite; your goal is to extract your soul from your body, ");
			outputText("while magically maintaining its link to your mind so that only your body ends up soulless. For this, you will need a phylactery! With this little item, you should be truly immortal, something the lesser demons could only dream of obtaining.</i>\"\n\n");
			outputText("You always thought there was something peculiar about her and now you realize why, Alvina always acted so coolly and relaxed despite being a demon, as if sex is the last thing on her mind. So this item she calls a phylactery is what helps her keep a cool head to begin with.\n\n");
			outputText("\"<i>Start by using transformatives to change yourself into whatever demonic form you prefer,  then we will resume this lesson.</i>\"\n\n");
			player.addStatusValue(StatusEffects.AlvinaTraining2, 1, 1);
		}
		else {
			outputText("You ask your mentor for more advanced applications of black magic but she replies in the negative.\n\n");
			outputText("\"<i>While there is one last thing I could teach you in the dark arts, I'm afraid you are still too pure for this knowledge. Come back when your soul is fully stained.</i>\"\n\n");
		}
		doNext(camp.campFollowers);
		advanceMinutes(5);
	}
	else {
		if (player.cor >= 50) {
			outputText("You ask your mentor for more advanced applications of black magic. Alvina sizes you up and nods.\n\n");
			outputText("\"<i>Your soul is plenty corrupted enough to understand this theory. Regardless, sending your lust at an opponent is one thing, but what of the opponent's own lust? To arouse an opponent with a spell is nice, but it works even better if you mess with the enemy's mind, using his own desires against him. I taught you about controlling your desire, now you need to learn about controlling the desires of others.</i>\"\n\n");
			outputText("She goes on for several hours, but eventually, you learn how to inspire even more lust with your spells. Smiling maliciously at the idea of trying this out.\n\n");
			player.createStatusEffect(StatusEffects.AlvinaTraining2, 0, 0, 0, 0);
			explorer.stopExploring();
			doNext(camp.returnToCampUseSixHours);
		}
		else {
			outputText("You ask your mentor for more advanced applications of black magic but she replies in the negative.\n\n");
			outputText("\"<i>While I could attempt to teach you many things, there is little you could learn without darkening your soul further. Advanced black magic is for the corrupt. Without the proper mindset, there is no way you could even comprehend it. Go get fucked by a few imps or take some transformatives and we will talk about this again.</i>\"\n\n");
			doNext(camp.campFollowers);
			advanceMinutes(5);
		}
	}
}

private function alvinaProposal():void {
	clearOutput();
	outputText("Alvina looks at you for a moment as if trying to peer at the depths of your soul and perhaps she would have had it not been sealed out in a phylactery.  She sighs in discouragement.\n"
		+ "\n"
		+ "“I used to be a girl like everyone, with hopes and dreams. But that was long ago, I stopped being that when the two people I cared the most about were brutally torn away from me. What is fate? What are the God's plans? What crazy heartless mechanism gave rise to this situation, I do not know. Tell me [name], tell me why all of this ever had to happen to me in the first place, why nobody helped me and why the so-called gods of Mareth did NOTHING, nothing at all from their seats while I was suffering? I prayed every night to the altar of Marae for a full month when my mom and dad fell ill. My Dad said Mom and him would be ok, that everything would go well and that I just needed to stay strong and keep praying… Yet they died! I never managed to get my parents back, and since that day I swore I would seek to master and control magic, achieving immortality for me and my peers so that no one would have to suffer the way I did. What is good... what is evil... in the end all I saw in the multiverse after those two hundred and fifty years I have lived was pain and suffering created by the actions of both mortals and immortals. Those I killed to get to this goal, those I manipulated and betrayed, all of them are only meaningless casualties in my war for a better world. As far as I care now everyone should be a demon. What do you lose really? Demons do not age, they are self-sufficient, they do not die, they are perfect beings living outside the cycle who can look after themselves and don’t need the help of some trashy god to save them! Sure there's been a few errors in my initial calculations but I solved them afterward and now I am so close. So close to creating perfection at last. Something even the gods could not. Who in their right mind would oppose such utopia? Would you [name]?”\n"
		+ "\n"
		+ "A demon with feelings? What about love and compassion? Did these sentiments die in her?\n"
		+ "\n"
		+ "“Compassion… love… these are tethers. I cannot allow myself to feel pity for anything that would stand in my way of creating a perfect world. As for love… it is a dangerous feeling. One day you live in a dream close to someone… the day after it is brutally torn away from you.”\n"
		+ "\n"
		+ "So what if some idiots refuse to accept that the demons are the good guys in this conflict? You do agree with her that a world of demons without war and suffering would be perfect. What's more, you would gladly help her do it, for the idea of someone working against her noble goal disgusts you to the core, however, corrupted it may be. Heck, it's not about demons, petty magic or any of those stupid things anymore, you simply are in love with her and as such request her hand in marriage.\n"
		+ "\n"
		+ "“You gotta be joking…");
	if (player.hasPerk(PerkLib.Phylactery)) outputText(" You say this because I hold control over your phylactery. Your very life in the depths of my paw.");
	outputText(" And yet… I sense sincerity in your words.”\n"
		+ "\n"
		+ "She mumbles to herself, sighing helplessly.\n"
		+ "\n"
		+ "“And so it is that the cat fell in love with the lion, yet the lion could not bring itself to kill the cat, for this cat had shown it understanding, empathy, and closeness no one else would. You must be someone very messed up to fall in love with me, yet I know of what you lived through [name] I saw it through my divination spells. Since you emerged from the portal I knew you were special. Cast out of your village as a sacrifice, yet escaping by chance? Fighting for your life in this world you do not belong to? You overcame every challenge that came your way. I have been following your progress from the beginning out of curiosity and I was not disappointed. The great do not live by the rules, they create them and you, [name], are clearly destined to achieve great things.”\n"
		+ "\n"
		+ "You note and mention to her that all lions start off as harmless cubs, all too often smaller than even the cat. Given some time you will eventually become someone as powerful as she is. You have laid down your life several times for her to the point that she now holds yours within her palm. Does she have any reason for fearing that you may betray her?\n"
		+ "\n"
		+ "“I do not...And so I will allow myself this small exception, for you are a person of exception that breaks all the rules, aren’t you [name]?”\n");
	menu();
	addButton(0, "Wedding", alvinaWedding);
}

private function alvinaWedding():void {
	//skip one month
	if (!recalling) {
		if (flags[kFLAGS.DAYS_PER_YEAR] <= 0 || flags[kFLAGS.DAYS_PER_YEAR] == 365) model.time.days += 30;
		else model.time.days += flags[kFLAGS.DAYS_PER_YEAR] / 12;
	}
	clearOutput();
	outputText("It’s been one long month of preparations involving a fair share of actions good and bad you will not name. Alvina being a demon it made sense such an event could not be held in any holy place and as such, she contacted a priest of the church of the fetish for the job.\n"
		+ "\n"
		+ "The church of the fetish cathedral was indeed the ideal place for such a rare event as most demons see no benefit in a thing such as permanent partners let alone attaching themselves to a specific mate. \n"
		+ "\n"
		+ "Alvina magically dressed herself for the occasion in a mesmerizing twilight black wedding dress which in a sense contradict the normal principle of the pure white in a wedding. Again, this wedding is no such thing as normal either. There weren't many people you could invite here as most marethians would see this wedding as blasphemy.");
	if (vapulaSlave()) outputText(" Vapula and her horde are attending. Mostly because she is in your service though she did develop a liking for you over time.");
	if (ceraphIsFollower()) outputText(" Notable in the crowd, Ceraph brought with her some of her slaves as guests.");
	if (campCorruptJojo()) outputText(" Jojo is there on a bench selecting his pick out of the many slut banquet to fuck and fiercely masturbating in anticipation. You gave him free rein for the duration of your happy day and he's sure to enjoy the use of his dick.");
	if (amilyScene.amilyCorrupt()) outputText(" Amily is there right at your side as the maid of honor her spaded tail twitching with excitement. She is so happy for you, it’s almost like she is about to burst.");
	if (bimboSophie()) outputText(" While Sophie is too much of a birdbrain to realize she is surrounded with demons and utterly corrupted creatures, she did have the common sense to at least hold her instinct in check, waiting for the end before jumping the nearest dick in the crowd.");
	if (flags[kFLAGS.SHEILA_DEMON]) outputText(" Sheila being one of your lovers is attending. She’s clearly jealous of your pick but so long as the two of you can keep having sex she doesn’t seem to mind.");
	if (flags[kFLAGS.ETNA_FOLLOWER] > 0 && !player.hasStatusEffect(StatusEffects.EtnaOff)) outputText(" Etna looks somewhat like a bored cat right now. She wants the ceremony to be over already so she can get to part two.");
	if (flags[kFLAGS.ELECTRA_FOLLOWER] > 1 && !player.hasStatusEffect(StatusEffects.ElectraOff)) outputText(" Electra has the telltale sign of a surge although for the moment she manages to contain herself.");
	outputText(" The fetish priest is already at the altar patiently waiting for you two to pronounce your vows so the orgy that will follow afterward can begin.\n"
		+ "\n"
		+ "“Do you swear to love, have mind-blowing sex and if necessary get pregnant should your mate grow a cock now and forever?”\n"
		+ "\n"
		+ "Alvina nods.\n"
		+ "\n"
		+ "“I do now and till the end of time.”\n"
		+ "\n"
		+ "The priest turns towards you next.\n"
		+ "\n"
		+ "“Do you swear to love, have mind-blowing sex and if necessary get pregnant should your mate grow a cock now and forever?”\n"
		+ "\n"
		+ "You give your agreement.\n"
		+ "\n"
		+ "“If anyone should oppose let that person be heard!”\n"
		+ "\n"
		+ "The door of the cathedral flies open with a loud crash. A large knight clad in divine armor that looks like it went through hell and back is standing at the door. His blood stained holy greatsword trails on the ground as he slowly walks into the building. A twisted holy aura surrounds the revenant, divine fury swarming around him as he approaches with slow and heavy footsteps. His armor is dyed red with demon blood and seeing his face is difficult, but within the small hole in his helm you see two shining red lights. The knight speaks with a loud, deep earth shaking voice, the sound of a fallen angel, twisted and bent on enacting vengeance. You instantly recognize him for who he is or was.\n"
		+ "\n"
		+ "“There is no such thing as a happy ending for demons… I will slaughter you all… starting with... YOU!”");
	if (silly()) outputText("\n\nA black message box appears and flashes below your field of vision, saying ‘Invaded by dark spirit Siegweird of Catelyna!’");
	outputText("\n\n<b>You are fighting Siegweird of Catelyna!</b>");
	if (!recalling) startCombat(new SiegweirdBoss());
	else doNext(marriagePostFight);
}

public function marriagePostFight():void {
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	if (!recalling) {
		cleanupAfterCombat();
		flags[kFLAGS.ALVINA_FOLLOWER] = 21;
		sceneHunter.marry("Alvina");
	}
	clearOutput();
	outputText("You decapitate the vengeful revenant, making sure he stays dead for good, though Alvina incinerates the corpse to make sure it doesn’t rise a third time as the wedding resumes. The priest tries and recovers his countenance at such violence, but decides it's better to have some blood on the church’s unholy ground then for everyone here to die. This is particularly true as Alvina gives him a death stare for not resuming the ceremony right away.\n"
		+ "\n"
		+ "“I declare you both to be wed, may you two find eternal bliss together.”\n"
		+ "\n"
		+ "Alvina practically jumps to kiss you the moment he's done speaking. The festivities are about to begin, and the attention and excitement swiftly make your ");
	if (player.hasCock()) outputText("[cock] rise to full mast");
	if (player.isHerm()) outputText(", not to mention that your ");
	if (player.hasVagina()) outputText("[pussy] is as wet with anticipation as hers");
	outputText(".\n"
		+ "\n"
		+ "You lay your wife on the altar as everyone else in the cathedral gets to the fun part. Alvina’s eyes gleam like embers with barely contained desire.\n"
		+ "\n"
		+ "“Let us make love, [name].”\n");
	sceneHunter.passCheckOnce();
	sceneHunter.selectGender(marriageSexMale, marriageSexFemale);
}

private function marriageSexMale(sleep:Boolean = false):void {
	clearOutput();
	outputText("Alvina takes on her more mature shape and gently pulls you to her, wrapping your cock in her mouth to properly lube you up. You moan in delight as her expert tongue licks your gland.\n"
		+ "\n"
		+ "“I normally use this form when I’m tired of looking like a midget but this time around I’m doing it just for you, [name], I like to think my more endowed body gets you off as much if not more than my smaller ones. So let me use my assets to please you properly.”\n"
		+ "\n"
		+ "Without a doubt, Alvina is by far one of the most beautiful succubi you have ever met, whether she takes on her smaller or mature appearance. You do not hesitate to compliment her about this.\n"
		+ "\n"
		+ "“Such a charmer… when you say it that way I can’t help but want to wrap my teats around this lovely staff of yours. Which I will do right away.”\n"
		+ "\n"
		+ "Alvina indeed gently switches places to be on top as she wraps her breasts around your dick and begins to massage your [cock], making you moan in pleasure as drops of corrupted pre begin to pearl at the tip of your corrupted [cock]. Alvina gives you a playful lick then resumes her ministrations until your cock is positively glistening with precum.\n"
		+ "\n"
		+ "“I think we are about ready. Please take me slowly this time around I want us to enjoy this together for as long as we can.”\n"
		+ "\n"
		+ "Alvina moves to align her soaking wet pussy with your hard cock, opening her lips with two furry fingers as she guides your cock into her impatient vagina. Oh, my! Your wife sure is pleased to have you inside as the way her vagina behaves can tell. Her demonic cunt feels just like a mouth as every side of her vaginal walls actively try to pleasure you. You do your best to hold and stockpile the cum for as long as possible to fill the goat girl’s mind full of pleasure.\n"
		+ "\n"
		+ "You and Alvina both scream in pleasure as you reach your peaks at the same time, her demonic cunt molding to the shape of your cock perfectly to hold and savor the thick ropes of corrupted cum you unload into her tainted pussy, feeding her so well she reaches a second orgasm from the powerful jet of cum splashing against her vaginal walls. Alvina caresses her belly taunting.\n"
		+ "\n"
		+ "“Lover, you filled me with so much cum I might easily get pregnant with imps, but considering it's you, I really don't mind. Please stay with me for a while.”\n"
		+ "\n"
		+ "You doze off together happily enjoying the remains of your shared orgasm. Later on, the two of you head back to camp highly satisfied and ready to resume your day-to-day life together.\n");
	if (!recalling) {
		player.sexReward("vaginalFluids", "Dick");
		sexBuffs();
		if (sleep) {

			doNext(camp.sleepWrapper, 2.0);
		} else endEncounter();
	} else doNext(recallWakeUp);
}

private function marriageSexFemale(sleep:Boolean = false):void {
	clearOutput();
	outputText(" You gently kiss Alvina as she casts a swift spell, her lovely horsecock sliding out of her juicy pussy like a sheath already lubricated by her own juices. You smile and gently caress her member with your vaginal lips, teasing her until a small dollop of demonic precum covers the flare. Alvina coos as you smear it all over your [pussy] moaning in delight as the corrupted fluid soaks into your tainted flesh. Done with the foreplay you slowly slide the delicious horse meat between your lips savoring it as it touches and fills every inch of your walls. Sex for a female demon is far more different than it is for a human, for instance, you can not only feel but also taste Alvina's dick with your vagina just like a mouth, licking your lips in delight as your hungry cunt sucks on her penis.\n"
		+ "\n"
		+ "“Ah, [name], you hungry girl… do not eat me so eagerly or I will end up cumming way before you do.”\n"
		+ "\n"
		+ "You reply to Alvina that you don’t mind. Each drop of cum she leaks is the sweetest nectar to you. That said, Alvina makes a playful smile.\n"
		+ "\n"
		+ "“Aw, who am I to deny the love of my life her sweetest treat, if you put it that way then I won’t hold back and will fill you with as much cream as you want.”\n"
		+ "\n"
		+ "This is enough to get you going; joyfully ride Alvina reverse cowgirl style" + (player.tailType == Tail.DEMONIC ? ", your spaded tail swinging from one side to another and drawing circles in the air" : "") + " as you moan like the succubus you are and what’s so wrong about it really? You’re enjoying yourself, Alvina is enjoying herself and whoever has a say against this deserves to burn. \n"
		+ "\n"
		+ "You and Alvina both scream in pleasure as you reach your peaks at the same time, your demonic cunt molding to the shape of her cock perfectly to hold and savor the thick ropes of corrupted cum Alvina unloads in your tainted pussy, feeding you so well you reach a second orgasm from the powerful jet of cum splashing against your vaginal walls. Alvina caresses your belly taunting.\n"
		+ "\n"
		+ "“If you get to be pregnant it will be with a dozen imps at least. I hope you don’t mind staying with me for a moment.” \n"
		+ "\n"
		+ "Why should you worry about pregnancy? The sex with her was totally worth it. You doze off together, happily enjoying the remains of your shared orgasm.\n"
		+ "The two of you head back to camp highly satisfied and ready to resume your day-to-day life together.\n");
	if (!recalling) {
		player.sexReward("cum", "Vaginal");
		sexBuffs();
		endEncounter();
	} else doNext(recallWakeUp);
}

private function sleepWith():void {
	flags[kFLAGS.SLEEP_WITH] = "Alvina";
	clearOutput();
	outputText("You ask Alvina if she would mind the two of you sleeping together.\n"
		+ "\n"
		+ "“You're being silly, why would I not want to sleep with my mate? We're together for life, I’m just surprised you didn't ask before.”\n");
	doNext(alvinaMainCampMenu);
}

private function noSleep():void {
	flags[kFLAGS.SLEEP_WITH] = "";
	clearOutput();
	outputText("<b>You are no longer sleeping with Alvina.</b>");
	doNext(alvinaMainCampMenu);
}

public function postMarriageSleep():void {
	if (AlvinaPurified) spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle_Pure_16bit);
	else spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("You head to Alvina’s place and wave at her.\n"
		+ "\n"
		+ "“Give me a moment to open the door, there's no way I'll let us sleep on the ground.”\n"
		+ "\n"
		+ "She summons a portal to the dimension that holds your decadent bedroom and invites you in, taking your hand and guiding you to the bed as she closes the portal to outside in order to grant you both some measure of privacy.");
	menu();
	addButton(0, "Sleep", reallySleep);
	addButton(1, "Sex", sleepySex).disableIf(player.isGenderless(), "You're genderless...");

	//=================================
	function reallySleep():void {
		clearOutput();
		outputText("Tonight you just want to sleep as you would rather hold your lust for later. Alvina nods in acceptance though this does not hold her from snuggling tightly with you all night long.");
		doNext(camp.sleepWrapper);
	}

	function sleepySex():void {
		clearOutput();

		outputText("“I have been making new spells to enhance the pleasure, but tonight I’d rather we both enjoyed something more vanilla. Don’t worry, I will still enhance our senses with a spell so we can be mushy by the end of the night.”\n"
			+ "\n"
			+ "You admit to being in the mood and seductively pull Alvina with you to the bed in order to enjoy some quality time with her.");
		sceneHunter.passCheckOnce();
		sceneHunter.selectGender(curry(marriageSexMale, true), curry(marriageSexFemale, true));
	}
}


	//Pure Alvina Camp content
	public function alvinaPureCampDescript():void {
		outputText("Alvina is writing down on a parchment at the side of the camp. She's likely writing down her thoughts, philosophy or perhaps trying to develop new spells to help your fight and contain the corruption across Mareth. The enthusiasm with which she does her research is commendable. She really seems to like what she does! "+
			//(if multiple children) Once in a while one of your many children walks up to her to ask a question to which she patiently answers with a smile. Whether her answer is a half truth or the full truth is always carefully spoken.
			"Through her sheer presence Alvina helps alleviate the ambiant corruption which is slowly burnt away from you and others near you.\n\n");
	}

	public function alvinaPureMainCampMenuAppearance():void
	{
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle_Pure_16bit);
		clearOutput();
		outputText("From your knowledge Alvina is of a rare demonic offshoot known as devils, though she has now been puified. While you are aware that, like most demons, she has advanced shapeshifting abilities, Alvina favors the appearance of a little girl several centuries younger than her true age, mostly for convenience. Alvina’s immaculate white hair is parted by two heavy goat horns and small furry ears, you ponder at the time why ");
		outputText("demons and devils develop such variants in their physiognomy. Beneath her hair, seeming like liquid gold stare back at you from behind a pair of glasses, or at least they do when she's not busy reading some dusty arcane text. Her innocent-looking face brings you joy every time she smiles, as though peace radiates from her.\n\n");
		outputText("Beneath her neck Alvina’s body is somewhat human-like however her forearms ends in furry four fingered claws while her legs are those of a goat. On her back rests a pair of folded white-feathered wings she doesn't use that often, mainly because flying magically or levitating is, as a general rule more convenient. Beneath her wings is her tail, having changed from her old goat-like tail, ");
		outputText("instead becoming longer and covered with immaculate white fur and draconic scales, her tail motion reflecting her state of mind, becoming agitated during unrest or when she loses her patience.\n\n");
		outputText("Alvina’s breasts are, surprisingly for a female demon, only an A cup. Anytime you would ask her why she keeps them so small she replies it's because, while a prodigious chest assist in the powers of lust and temptation based spells, a smaller chest is more practical both for the body and the spirit as a larger pair tend to obscure view, ");
		outputText("weighs the body down and consume an excess amount of energy, maintenance she has no interest in spending. Mirroring this, her ass only has the bare minimum size to denote her as a female.\n\n");
		outputText("Between those goat legs of hers is her vagina, though Alvina is, as a general rule more interested in magic than sex and Alvina’s vagina looks about as standard as one of a human woman would be, both in the moistness and size.\n\n");
		outputText("Alvina is perfectly aware that you are analysing her, but, as usual, is more concerned about whatever lecture she is on than about you sizing her up.\n\n");
		outputText("\"<i>Well then, when you are done sizing my body up, maybe you can tell me what you are here for?");
		if (flags[kFLAGS.ALVINA_FOLLOWER] < 19) outputText(" I have little time for games as you know all too well.");
		outputText("</i>\"\n\n");
		menu();
		addButton(14, "Back", alvinaPureMainCampMenu);
	}

	public function alvinaPureMainCampMenu():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle_Pure_16bit);
		clearOutput();
		outputText("You head over to Alvina in her part of camp. She is reading a book, as usual.\n\n");
		if (AlvinaInfernalOilCooldown > 0) {
			outputText("I am sorry [name], I cant talk to you while I am working on that potion for you.");
			doNext(playerMenu);
		}
		outputText("\"<i>Well hello [name], what brings you to me today?</i>\"\n\n")

		menu();
		addButton(0, "Appearance", alvinaPureMainCampMenuAppearance);
		addButton(1, "Talk", alvinaPureTalkOptions);
		addButton(2, "Infernal Oil", alvinaPureInfernalOil)
			//.disableIf(!player.hasPerk(PerkLib.Phylactery) || !player.hasPerk(PerkLib.Soulless), "Requires you to be soulless")
			.disableIf(!player.hasItem(consumables.INFWINE) && !AlvinaInfernalOilAsked, "You need this item to ask her about it DUH...")
			.disableIf(AlvinaInfernalOilCooldown > 0, "Alvina is stll busy making the potion");
		addButton(3, "Sex", alvinaPureSexMenu);
		addButton(14, "Back", camp.campLoversMenu);
	}

	public function alvinaPureInfernalOil():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle_Pure_16bit);
		clearOutput();
		if (!AlvinaInfernalOilAsked) {
			outputText("You hand over the potion to Alvina and ask her if she can do something with the item.\n\n");
			outputText("\"<i>The old custom devil formula right? Well… to an extent yes… there's a few things I can do though honestly I'm just tempted to throw it off a cliff.</i>\"\n\n");
			outputText("You tell her in no uncertain way this is not happening.\n\n");
			outputText("\"<i>Why would you even want this item [name]? It reeks of corruption.</i>\"\n\n");
			outputText("You never said you wanted it as is. Could she purify it for you?\n\n");
			outputText("\"<i>Wait you mean to say you… how flattering. Of all the possible shapes, you would like to look just like me. I would kiss you but you seem to be low on time. This is fine though, give me a day while I concentrate on altering this product and tadaa you will be an Azazel too in no time!</i>\"\n\n");
			AlvinaInfernalOilCooldown = 1;
			player.consumeItem(consumables.INFWINE);
			AlvinaInfernalOilAsked = true;
			advanceMinutes(15);
			doNext(playerMenu);
			return;
		}
		outputText("You ask Alvina about her progress with the potion.\n\n");
		outputText("\"<i>All finished, It took some effort but just like my form the reagent can be purified. Took me some great effort though, you wouldn't believe the places I had to go to get the reagents!</i>\"\n\n");
		outputText("She hands you the bottle.\n\n");
		outputText("\"<i>Don't abuse it… wouldn't want to get side effects or something... not that id know them. If anything I'm just telling you what my sister used to say all the time about medicine and its that too much of a good thing is a bad thing.</i>\"\n\n");
		AlvinaInfernalOilCooldown = 0;
		AlvinaInfernalOilAsked = false;
		advanceMinutes(15);
		inventory.takeItem(consumables.SAGEMED, playerMenu);	//Sage Medicine	//Azazel TF from
	}

	public function alvinaPureTalkOptions():void {
		menu();
		addButton(0, "Magic", alvinaTalkMagic);
		addButton(14, "Back", alvinaPureMainCampMenu);
	}

	private function alvinaTalkMagic():void {
		clearOutput();
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle_Pure_16bit);
		outputText("You ask Alvina if there's anything useful she could teach you.[pg]");
		outputText("Alvina lights up at your question and searches her belongings for something before answering \"<i>While most of my research is on the topic of black magic, something I wish you to use carefully and with restraints, I did devise a few powerful spells, though learning them requires an immense amount of talent.</i>\" [pg]");
		if (AlvinaGaveScroll) {
			outputText("\"<i>Although I have given you the only one I had on hand. I had another spell scroll called Meteor Storm but a thief stole it from me while I wasn't home. I could make a new scroll seeing as I know the spell but it would take a lot of time to transcribe. </i>\"");
		} else {
			outputText("She produces a scroll, handing it to you \"This here is Polar Midnight, one of my signature spells. It wasn't made to be handled by common mages and could very well kill you if misused, but seeing as you defeated me in combat, I believe you can handle it just fine. I had another spell scroll called Meteor Storm but a thief stole it from me while I wasn't home. I could make a new scroll seeing as I know the spell but it would take a lot of time to transcribe.</i>\"[pg]");
			if (player.hasStatusEffect(StatusEffects.KnowsPolarMidnight)) {
				outputText("You tell her that you already know this spell... \"<i>Oh, ahh I see, yes thats right I gave it to you sometime before our fight... How could I forget?</i>\"[pg]")
				doNext(camp.campFollowers);
			} else {
				outputText("<b>You gained a scroll of Polar Midnight.</b>\n\n");
				inventory.takeItem(consumables.POL_MID, camp.campFollowers);
			}
			AlvinaGaveScroll = true;
		}
		doNext(alvinaPureMainCampMenu);
	}

	public function alvinaPureSexMenu():void {
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle_Pure_16bit);
		clearOutput();
		outputText("Feeling Antsy you decide to ask Alvina out. She blush wildly but adjust her glasses.\n\n");
		outputText("\"<i>I mean [name] we are in the middle of the camp in front of everyone it's not that I don't want to but…</i>\"\n\n");
		outputText("She ponders before making a mischevious smile.\n\n");
		outputText("\"<i>Actually I just remembered something, give me a second.</i>\"\n\n");
		outputText("She prepares a spell and a white door appears.\n\n");
		outputText("\"<i>After you [name].</i>\"\n\n");
		outputText("Beyond the door is a beautiful bedroom with a large white silk bed. At the back is a balcony giving a view over what appears to be a cloudless sunlit blue sky and a field of white flowers, probably her favorites, which stretch all the way to the horizon. This tiny room radiates the warmth and joy of life, a defiant pocket of hope and light in the middle of the bleak realm that is Mareth.\n\n");
		outputText("\"<i>This, [name], is a reflection of utopia… well my dream world idea of it. Obviously this pocket dimension can only be truly perfect with you in it. Let us, if only for a few minutes, leave the war scarred world of Mareth behind. As you are the champion relentlessly fighting your way through corruption, I know you could use some time away from its black fume. Worry not, time will resume in Mareth where we left it once we are done.</i>\"\n\n");

		alvinaMakeLovePure();
	}

	private function alvinaPureTakeHer(x:int):void
	{  //Male or Herm
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle_Pure_16bit);
		clearOutput();
		outputText("You proceed to remove your gear and ");
		if (player.cocks[x].cockLength > 20) remarkTooBigCock();
		else if (player.cocks[x].cockLength < 10) remarkSmallCock();
		else remarkAverageCock();

		outputText("Blushing in excitement she gently guides you into her lap spreading her hooved legs appart to offer you access to her innermost precious place, her hands open so to catch and hold yours. Somehow this passionate, innocent pose of hers arouse you more than all the trice damned demons of mareth have, whereas their seduction is perverted and crude Alvina pure genuine and nurtured love for you makes her every gesture radiate with a cute and heartwarming factor unique to hers. "+
				"This isn't just about raw sex, this is about a conversation between you and her and sensual carresses and kisses are the word of love you two exchange. You place your hands into the palm of her open paws and align your "+player.cockDescript(x)+" with the entryway to Alvina sacred garden trusting past the gate for a taste of her heaven. You are not disappointed, since Alvina was formerly a succubus; her vagina is capable of amazing feats of motion control; she uses it to massage your cock slowly, letting you savor the pleasure for as long as possible. " +
				"All the while you two seek each other's mouth moving together to reach new pleasurable heights. As a demon Alvina only knew to take and never give in return her transformation actually led her to rediscover the pleasure of giving and receiving freely and through each pleasant ministration she dots your penis she gets to feel some of the pleasure back. You mean in genuine untarnished happiness as you passionately slide your penis down her canal seeking out all her sweet spots. You can't help but think your penis feels at home into her hole " +
				"and feel a little apologetic about all the other hole you've tried out before hers.\n\n");//cant check for penile virginity
		outputText("Alvina, unable to hold further, wraps her legs around you, pushing you deeper and triggering your climax. Pleasure overwhelm your penis as you shoot rope after rope into her warm welcoming folds. She smiles in happiness, eyes closed in bliss as you finish.\n\n");
		alvinaPureSexFertilityComment();
		player.sexReward("vaginalFluids", "Dick");
		endEncounter();

		function remarkTooBigCock():void {
			outputText("Alvina admits with a bit of worry \"<i>Well thats a mammoth your packing down here. Perhaps I should be thankful that my maximal vaginal capacity didn't downgrade from my transformation or this thing could inflict some serious damage. Seriously though you should consider shrinking it if only for the wellbeing of most of your partners.</i>\"\n\n");
		}
		function remarkAverageCock():void {
			outputText("Alvina sighs in relief as she takes in the size of your cock \"<i>Well I guess thats the average standards on Mareth, big and firm and just the right size for a good bit of pleasant fun.</i>\"\n\n");
		}
		function remarkSmallCock():void {
			outputText("Alvina sighs in relief as she takes in the size of your cock \"<i>Truth be told, with the craziness going around here I was worried I'd end up being pierced by a minotaur sized monster, you having a normal sized penis is the most relieving and cute thing ive seen in a long while. Don't you worry I can adapt my vagina to fit you just right, call it a vestige of my demonic shapeshifting powers if you will.</i>\"\n\n");
		}
	}
	private function alvinaPureLetHerTakeYou():void
	{  //Female or Herm
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle_Pure_16bit);
		clearOutput();
		outputText("At the suggestion Alvina makes an mischievous smile.\n\n");
		outputText("\"<i>Well under all normal law of reality, a girl cannot fuck another girl with a penis she outright lacks. Fortunately for us I happen to disagree with this, so with a little effort I can get us just the thing down here, though you will have to coax it out.</i>\"\n\n");
		outputText("Alvina lays down, legs spread open to grant you access to her folds. You lie next to her and tenderly begin to eat her out. As you do, her clit begins to engorge, becoming erect as it grows bigger and bigger. Just as Alvina swiftly reaches orgasm and rewards you with a spray of her juice, her clit finish its transformation, the skin molting brown and black into a fully grown, hard and twitching horsecock, her cheeks flushed with need now.\n\n");
		outputText("\"<i>Well I heard it's all the rage out there, so I grew one for you. I hope you like it. Pardon me but I'm all hot now and can hardly contain myself anymore!</i>\"\n\n");
		outputText("Truth be told you have been waiting for this the whole time and you gingerly open your legs up as Alvina lays down on your [chest], her breasts pressing against yours");
		if (player.biggestTitSize() > 2) outputText(" with just the right amount of quake to make you moan");
		outputText(". You feel the crown of her cock seeking out your passage before slowly inserting itself inches after inches inside. Alvina made it just right. It's the perfect size to fill you up entirely without hurting you. Well you would have expected no less from your kinky magician lover. As if reading your thought Alvina offers you a corner smile before commenting.\n\n");
		outputText("\"<i>I'm glad you like it but I'm just getting started you know?</i>\"\n\n");
		outputText("As she says this she begins trusting, you don't know if that's demon instinctual knowledge, but god is she good at this. She seems to instinctively know exactly in which direction to thrust to maximize your pleasure, and from the look of it she's also getting off from it, though with such a good fucking you will be cumming far ahead of her. You wrap your legs and clench the ground beneath you as you achieve orgasm, begging your lover to keep going, you just want to go again and again.\n\n");
		outputText("\"<i>Well that's a good thing [name] seeing as I haven't reached my peak yet.</i>\" She kisses you before promising softly. \"<i>Don't you worry I will keep stuffing you until you can't go on.</i>\"\n\n");
		outputText("Alvina's movement do not stop, indeed allowing you to reach and feel peaks you've never reached before. Alvina's technique is so good you can't think about anything but her dick in your vagina right now as your brain slowly turns to mush. Eventually though, even Alvina reaches her limit as she unloads rope after rope of cum, painting your thirsty vagina white.\n\n");
		alvinaPureSexFertilityComment();
		endEncounter();
	}
	private function alvinaPureSexFertilityComment():void
	{
		outputText("\"<i>You know I'm no longer a soulless body. Perhaps with a little luck we might even have a human child.</i>\"\n\n");
		outputText("The thought makes you smile, a new human generation in Mareth after all these years might not be a bad thing, at least not the way Marae made it out to sound. And with you two there to teach them, you could even rebuild them from scratch.\n\n");
		outputText("Spent, the two of you lie down next to one another, hugging tightly for a few minutes and whispering sweet nothings. It would be so easy to stay there with her forever, but you have things to do and Alvina understands that too.\n\n");
	}
	private function alvinaPureMakeOut():void
	{  //Girl on Girl
		spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle_Pure_16bit);
		clearOutput();
		outputText("Pending scene text");
		endEncounter();
	}
}

}
