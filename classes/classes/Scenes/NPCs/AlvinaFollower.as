/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Useable;
import classes.display.SpriteDb;

use namespace CoC;

public class AlvinaFollower extends NPCAwareContent
	{
		
		public function AlvinaFollower() 
		{}

public function isAlvinaBirthday():Boolean {
	return date.month == 7;
}

public function alvinaFirstEncounter():void
{
	//spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("As you travel you meet with a woman in robes with black hair. You didn’t expect to see a fellow human around in Mareth, which is a relief. Perhaps you aren’t alone in this quest. You ask if she could give you directions, as you have no idea what to expect in this realm. As a champion, your job is to fight the demons, but you can’t fight them if you have no idea where to look.\n\n");
	outputText("\"<i>Directions and demons, hm? There are many places you could visit. If I were you, I would go to the lake and look for a peculiar island at its center. That said, be respectful of whomever you meet there.</i>\"");
	outputText("You nod and prepare to leave, but ask her who she is in case you should ever see her again.\n\n");
	outputText("\"<i>Me? I am a person of no consequence.</i>\"");
	outputText("As you turn over to question her on her wording, you find out she is no longer there. Well, that was a strange encounter.\n\n");
	flags[kFLAGS.ALVINA_FOLLOWER] = 1;
	doNext(camp.returnToCampUseOneHour);
}

public function alvinaSecondEncounter():void
{
	//spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("As you pass by the road you spot the woman from before sitting on a nearby wooden log. You sit right next to her, she closes her book in response. You thank her for the information regarding Marae’s whereabouts");
	if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) outputText(" though it ended in disaster, thanks to your actions");
	outputText(". That said you are still looking for ways to fight the demons.\n\n");
	outputText("\"<i>Fighting the demons? Well... You could try and find their leader’s fortress on your own, however, how do you plan to find a demon willing to risk everything to betray the mastermind above?</i>\"\n\n");
	outputText("You admit that you have no idea.\n\n");
	outputText("\"<i>There is a demon lair located somewhere in the deep woods ran by a greater imp who apparently lost the demon queen’s favor. Perhaps you could coax him into divulging the information you seek. Oh, and you should know my name is Alvina. It’s a pleasure to formally meet you.</i>\"\n\n");
	outputText("On those words, she picks up her book and adjusts her glasses, as she resumes reading. You could talk to her and perhaps get some information from her about the place, she seems very knowledgeable.\n\n");
	flags[kFLAGS.ALVINA_FOLLOWER] = 9;
	alvinaSecondEncounterLeave();
}
public function alvinaSecondEncounterLeave():void
{
	menu();
	addButton(0, "Talk", alvinaSecondEncounterTalk);
	addButton(4, "Leave", camp.returnToCampUseOneHour);
}
public function alvinaSecondEncounterTalk():void
{
	outputText("Alvina lowers her book to look at you for a moment, adjusting her glasses in front of her embery eyes.\n\n");
	outputText("\"<i>Still want to know more, do you? Sure, I can share the knowledge but be quick with your queries, I still have a book to read.</i>\"\n\n");
	menu();
	addButton(0, "Her", alvinaSecondEncounterTalkHer);
	addButton(1, "Hobby", alvinaSecondEncounterTalkHobby);
	addButton(4, "Leave", camp.returnToCampUseOneHour);
}
public function alvinaSecondEncounterTalkHer():void
{
	outputText("So, who is she exactly? Is she native to Mareth?\n\n");
	outputText("\"<i>I know what you’re thinking, a human on Mareth is something next to nobody sees. There are other humans across the world. I hear the hidden city Tel'adre has several true humans. I myself am a breakaway from the sand witch coven. I didn’t like the weird turn in the practice of late, so I left and used some hummus to properly revert any possible changes.</i>\"\n\n");
	outputText("Well, that explains a lot. So she was born with two set of breasts and a second vagina?\n\n");
	outputText("\"<i>You could say it like that, yes, though I had these traits corrected since.</i>\"\n\n");
	if (player.inte > 150) outputText("There’s something she’s not telling you, likely it is related to her relation with the sand witches. She probably left in very bad terms. Regardless, you find it more prudent to talk about something else.\n\n");
	doNext(alvinaSecondEncounterTalk);
}
public function alvinaSecondEncounterTalkHobby():void
{
	outputText("Those books she reads look very interesting, what language is that? You can’t understand a single word of it save for a few letters.\n\n");
	outputText("\"<i>These are advanced arcanic texts meant for the adept only. If you were better at magic, perhaps you would understand the symbols and patterns in them. You may think you have mastered spellcasting after your first whitefire, but magic is way more complicated than that. To most students, it takes years to achieve true mastery. Perhaps if you try hard enough, someday I will teach you.</i>\"\n\n");
	outputText("That’s something you will have to consider, for now, you decide to change the subject.\n\n");
	doNext(alvinaSecondEncounterTalk);
}

public function alvinaSecondBonusEncounter():void
{
	//spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("As you explore Mareth you come again upon Alvina. Her back is facing you as she gazes to the horizon beyond.\n\n");
	outputText("\"<i>I overheard that you defeated Queen Lethice... Most impressive, champion of Ingnam.</i>\"\n\n");
	outputText("You awkwardly reply that you only did your duty, really.\n\n");
	outputText("\"<i>Is that so? Even then, what keeps you on Mareth still? Shouldn’t you have gone back to your homeland already? Perhaps it is something else that you seek. Regardless, if purging Mareth of the remaining corruption is your goal, you should go to the blight ridge. The area is dangerous and filled with demons, but surely the bane of Lethice should be able to get by without any issues?</i>\"\n\n");
	outputText("She chuckles as a gust of wind throws dust at you, causing you to shield your eyes. The moment you look back at her, she is gone.\n\n");
	flags[kFLAGS.ALVINA_FOLLOWER] = 10;
	alvinaSecondEncounterLeave();
}

public function alvinaThirdEncounter():void
{
	//spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("As you wander the blight ridges, you stumble upon what looks to be a cave. Bright purple lights flash in its depths and various magical runes are etched onto the entrance. Do you dare enter? It looks like whatever lies in this cave is extremely dangerous.\n\n");
	menu();
	addButton(0, "No", alvinaThirdEncounterNo);
	addButton(4, "Yes", alvinaThirdEncounterYes);
}
public function alvinaThirdEncounterNo():void
{
	outputText("This is a very bad place, better not linger here. You decide to head back to camp.\n\n");
	flags[kFLAGS.ALVINA_FOLLOWER] = 11;
	doNext(camp.returnToCampUseOneHour);
}
public function alvinaThirdEncounterYes():void
{
	outputText("Against your better judgment, you enter the cave. You proceed down into the depths, getting ever closer to the source of the lights.\n\nYou finally reach a large room filled with what looks to be various magical implements. ");
	outputText("This is clearly the laboratory of a wizard and not the good kind. Pentagrams are etched everywhere. There's clearly humanoid bones on a table, and the room itself is decorated with quite a few Lethicite crystals -- proof of its owner's fiendish successes. You turn to leave the room, having seen more than enough, when you bump into a wall that wasn’t there earlier.\n\n");
	outputText("\"<i>Leaving so soon [name]? I didn’t give you permission yet.</i>\"\n\n");
	outputText("At the other side of the laboratory stands Alvina. She's smiling under her hood.\n\n");
	outputText("\"<i>I see you finally made it here [name], you did… An excellent job. I can only applaud your competence. ");
	if (flags[kFLAGS.LETHICE_DEFEATED] > 0) outputText("You even defeated Lethice for me, which I will admit is highly convenient. ");
	outputText("Though you had no idea that I set you on this path on purpose all along, did you? You could have gone anywhere, or got defeated by a random fiend and lost yourself, but you gladly acted like a perfect pawn and did everything just as I had planned.</i>\"\n\n");
	outputText("The woman laughs, her chuckling slowly turning increasingly youthful as she shrinks in size. The hooded woman is gone, replaced by a small demoness that stands before you. She doesn’t sport the usual features of a succubus, but is clearly a demon nonetheless. Her body looks mostly human in shape, save for her large hooves and furry clawed hands. A small pair of demonic wings spread from ");
	outputText("between her shoulders, hidden by her long abyssal black hair. A goat's tail adorns her backside, and her horns curve backwards - just like a goat. She looks like some kind of demon despite the odd mix. Her subtle A cup breasts fit her 3 and a half feet tall body perfectly, although you would expect a succubus to have at least an E cup. Her eyes don’t exactly look like those of most succubi either, ");
	outputText("as they shine with an inner malice even other demons might find disturbing. Her black sclera and glowing fiendish ember iris only making the intimidating appearance worse. She wears a pair of glasses and a somewhat revealing armor, which is unusual considering most demons prefer to wander around naked.\n\n");
	outputText("\"<i>So… Done sizing up my perfect features? Sorry to disappoint, but if you thought I was human, that was a lie all along. In truth, I have stopped being human for several decades. Now, less about me and more about you. ");
	if (!player.hasStatusEffect(StatusEffects.PlayerPhylactery)) outputText("I’m amazed a being still carrying a soul would achieve what you did. ");
	outputText("Your prowess thus far have more than earned my interest. Perhaps you were just lucky... Or perhaps, like me, you are destined to a greater calling. Regardless, you served my goals well until now and I am highly interested in seeing what else you can accomplish.</i>\"\n\n");
	outputText("A greater calling? Like what?\n\n");
	outputText("\"<i>Power, pure and simple. You desire power, and to further increase it, the only proper path is to beseech those that possess it. Most academics seek to obtain true mastery of magic, although most are not willing to sacrifice everything for their study. After many years of researching forbidden knowledge, performing tedious experiments and depraved rituals, I came to one conclusion: ");
	outputText("The demons came very close to harnessing true power but ultimately failed, turning into insatiable creatures unable to satisfy their endless thirst for souls and sex, in the end, they lack a soul entirely. To achieve perfection and immortality one needs their soul to be attached to its body so to… Regardless, this is nothing you should concern yourself with yet.</i>\"\n\n");
	outputText("Ok so why does it matter? It’s not like you have anything to do with this right?\n\n");
	outputText("\"<i>On the contrary, you coming here is no hazard. You seek forbidden knowledge and I, Alvina Shadowmantle, founder of what is today black magic seek someone to impart it… For a price. So how about joining me and becoming my apprentice? You have proven way more than a mere pawn, so surely you are worthy of my time.</i>\"\n\n");
	menu();
	if (flags[kFLAGS.SIEGWEIRD_FOLLOWER] >= 4) addButtonDisabled(0, "Sure", "There's no way you would be able to have HER in your camp at the same time as Siegweird. He'd kill her or she'd kill him.");
	else addButton(0, "Sure", alvinaThirdEncounterYesSure);
	addButton(4, "Never", alvinaThirdEncounterYesNever);
}
public function alvinaThirdEncounterYesSure():void
{
	outputText("Learning black magic straight from the source? Where's the dark contract so you can sign it!? You shake hands with Alvina right away, sealing the deal.\n\n");
	outputText("\"<i>Excellent. I will pack up my things then head out for that place you call your camp. Just give me a second.</i>\"\n\n");
	outputText("Alvina gets a bag out and raises a hand. All of her tools and instruments fly into the bag, which keeps the same size despite the volume of things moving into it. Once everything is packed up, she looks back at you, smiling.\n\n");
	outputText("\"<i>Well, let us be on our way… You have a lot to learn, and staying here won’t help your studies.</i>\"\n\n");
	outputText("You head back to camp, Alvina following you.\n\n");
	outputText("<b>Alvina has joined you as a follower.</b>\n\n");
	flags[kFLAGS.ALVINA_FOLLOWER] = 13;
	flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 3;
	doNext(camp.returnToCampUseOneHour);
}
public function alvinaThirdEncounterYesNever():void
{
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
	outputText("This is a battle you cannot win. This woman is likely stronger than Lethice herself, and sports godlike power you have no chance to stand against! As you look for a possible way to flee, you notice a detail that has escaped your attention up till now. While Alvina has not taken even a single apparent wound, ");
	outputText("she has been actively protecting a crystalline pendant around her neck. Alvina suddenly looks worried, realizing that you are staring at her necklace.\n\n");
	outputText("\"<i>Hey, why are you looking at my breasts you idiot?! Look me in the face before you die!</i>\"\n\n");
	outputText("That does it, she definitely is afraid. In a desperate last attempt, you strike at the succubus one final time, striking directly at the pendant hanging from her neck. Alvina screams in horror as the crystal shatters.\n\n");
	outputText("\"<i>My phylactery! No! What have you done to my phylactery!!!!!</i>\"\n\n");
	outputText("Her body starts to bloat as the immense powers she used to control overwhelms her. Alvina makes one last anguished scream before exploding in a conflagration of arcane magic turning to ashes.\n\n");
	outputText("You turn your eyes away, nauseated at the scene… This is what happens to those who play with forbidden powers, quite a fitting end. You leave the cave feeling like you have rid Mareth of a powerful villain.\n\n");
	outputText("<b>Found Alvina's Shattered Phylactery</b>\n\n");
	player.createKeyItem("Alvina's Shattered Phylactery", 0, 0, 0, 0);
	flags[kFLAGS.ALVINA_FOLLOWER] = 12;
	doNext(camp.returnToCampUseSixHours);
}
public function alvinaThirdEncounterYesNeverLost():void
{
	outputText("You wake up, somewhat horny, in the middle of the blight ridge.\n\n");
	outputText("It would seem Alvina already took the liberty of disposing of your soul. All in all, she was quite merciful to only turn you into a demon and not rip you apart or worse, turn you into a lab rat. Well, at least you're still alive and well, right? You proceed to spend the rest of your life in the same way most demons do, ");
	outputText("heading back to the portal to start collecting slaves, beginning with the next Champion, to amass power and eventually claim revenge. After many years of harvest, your power rises up to rival Alvina's own and you challenge her again. Whether you won or lost, however, was and will never be known to anyone.\n\n");
	EventParser.gameOver();
}

public function alvinaMainCampMenu():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("You head out to meet Alvina in her hidden camp. She is in the middle of an experiment, as usual.\n\n");
	outputText("\"<i>Well hello [name], what brings you to me today?</i>\"\n\n");
	menu();
	addButton(0, "Appearance", alvinaMainCampMenuAppearance).hint("Examine Alvina detailed appearance.");
	if (player.hasStatusEffect(StatusEffects.AlvinaTraining)) addButtonDisabled(10, "Study", "You already completed basic Study.");
	else addButton(10, "Study", alvinaCampStudy);
	if (player.hasStatusEffect(StatusEffects.AlvinaTraining) && player.statusEffectv1(StatusEffects.AlvinaTraining2) < 2) addButton(11, "Advanced Study", alvinaCampAdvancedStudy);
	else {
		if (player.hasStatusEffect(StatusEffects.AlvinaTraining) && player.statusEffectv1(StatusEffects.AlvinaTraining2) == 2 && player.hasItem(useables.AMETIST, 1) && player.hasItem(consumables.L_DRAFT, 5) && player.hasItem(useables.SOULGEM, 10) && (player.hasKeyItem("Marae's Lethicite") >= 0 || player.hasKeyItem("Stone Statue Lethicite") >= 0)) addButton(11, "Advanced Study", alvinaCampAdvancedStudy);
		else addButtonDisabled(11, "Advanced Study", "You need to gather a flawless Amethyst necklace, five lust drafts, ten soul gems, and a piece of very powerful Lethicite before you can progress.");
		if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3) {
			if (player.hasKeyItem("Siegweird's holy symbol") >= 0) addButton(11, "Advanced Study", alvinaCampAdvancedStudy);
			else addButtonDisabled(11, "Advanced Study", "You need to go kill certain annoying paladin in Blight Ridge.");
		}
		if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 4) addButtonDisabled(11, "Advanced Study", "You already completed Advanced Study.");
	}
	addButton(14, "Back", camp.campFollowers);
}

public function alvinaMainCampMenuAppearance():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("From your knowledge Alvina is of a rare demonic offshoot known as devils. While you are aware that, like most demons, she has advanced shapeshifting abilities, Alvina favors the appearance of a little girl several centuries younger than her true age, mostly for convenience. Alvina’s raven black hair are parted by two heavy goat horns and small furry ears, you ponder at the time why ");
	outputText("demons and devils got such variants in their physiognomy. Beneath her hair, two pupils glowing like molten embers stare back at you from behind a pair of glasses or at least they do when she's not busy reading some dusty arcane text. Her smug, playful lips hides fangs better suited to a beast than a human and a practiced tongue who has spent centuries wording out some of the most powerful incantations in the realm. \n\n");
	outputText("Beneath her neck Alvina’s body is somewhat human-like however her forearms ends in furry four fingered claws while her legs are those of a goat. On her back rests a pair of folded demon wings she doesn't use that often, mainly because flying magically or levitating is, as a general rule more convenient. Beneath her wings is her tail, unlike demons, ");
	outputText("devils tend to have goat tails instead of the sinuous spade and Alvina’s own goat tail motion reflects her state of mind, becoming agitated during unrest or when she loses her patience.\n\n");
	outputText("Alvina’s breasts are, surprisingly for a female demon, only an A cup. Anytime you would ask her why she keeps them so small she replies it's because, while a prodigious chest assist in the powers of lust and temptation based spells, a smaller chest is more practical both for the body and the spirit as a larger pair tend to obscure view, ");
	outputText("weighs the body down and consume an excess amount of energy maintenance she has no interest in spending. Mirroring this, her ass only has the bare minimum size to denote her as a female.\n\n");
	outputText("Between those goat legs of hers is her vagina which, like most demon can likely wrinkle a cock dry within seconds if she decides to use it. This said, Alvina is as a general rule more interested in magic than sex and, unlike most succubi that are natural squirters, Alvina’s vagina looks about as standard as one of a human woman would be, both in the moistness and size.\n\n");
	outputText("Alvina is perfectly aware that you are analysing her but, as usual, is more concerned about whatever lecture she is on then about you sizing her up.\n\n");
	outputText("\"<i>Well then, when you are done sizing my body up, maybe you can tell me what you are here for?");
	outputText(" I have little time for games as you know all too well.");//(If pc isn't in couple with her)
	outputText("</i>\"\n\n");
	menu();
	addButton(14, "Back", alvinaMainCampMenu);
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
					if (rand(2) == 0 && date.month == 7) {
						outputText("\"<i>Did you know that Lethicite can be used as icing for cakes? A decent demon should have a frozen soul on every dessert really. I also heard only Lethice can afford such a delicacy daily. My birthday is in a few days so I hadn’t considered until now whether I want a cake or not.</i>\" You back away before she considers using yours.");
						if (!player.hasStatusEffect(StatusEffects.PlayerPhylactery)) outputText(" You back away before she considers using yours.");
						outputText("\n\n");
					}
					else {
						if (rand(2) == 0 && flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText("\"<i>Umph I read the latest news, apparently you shut down the factory… nice job, the overseer there was an incompetent slut who deserved to get fired anyway.</i>\" Well getting praised for your heroic acts is one thing, but the way she casually talks about it makes it sounds like you didn’t accomplish anything of serious relevance.\n\n");
						else outputText("\"<i>Did you know bee girls actually aren’t immune to corruption? I caught and used a few handmaidens as test subjects for some new spells before releasing them back to their hive. Apparently, you can create an entire army of demons just by corrupting a few and letting them spread mayhem and lust back home, very fascinating.</i>\"\n\n");
					}
				}
			}
		}
		doNext(camp.campFollowers);
		cheatTime2(5);
	}
	else {
		outputText("Strangely, despite being a demon, Alvina makes for a great teacher. She corrects your posture when you miss a movement and helps you learn faster than you would by just reading books.\n\n");
		outputText("\"<i>Still daydreaming in the middle of my lectures [name]?</i>\"\n\n");
		outputText("You quickly jerk back into action to show you're listening. Alvina resumes explaining the universal principle of how to channel desire into power. You learn a lot, but the way she flaunts her body, and the many innuendos she punctuates the lesson with, make you flush red in arousal.  During the entire lesson, your teacher is teasing you, ");
		outputText("and there's nothing you can do about it but wait patiently for the end of the lecture. By the time you get to doing something practical, you are so aroused you feel your lust rise uncontrollably just from casting those spells as wild fantasies assault your mind.\n\n");
		if (player.inte > 70 && player.lib > 70 && flags[kFLAGS.ALVINA_FOLLOWER] == 14) {
			outputText("You finally achieved complete mastery over your lust, conquering your arousal and turning it into a weapon to use against your foe as you unleash a massive blast of black magic on the target dummy.\n\n");
			outputText("\"<i>Very good [name], you finally achieved mastery of the theory. Tomorrow we will discuss more advanced principles.</i>\" She dismisses you with these congratulations as you head back to camp feeling both sexy and powerful.\n\n");
			player.createStatusEffect(StatusEffects.AlvinaTraining, 0, 0, 0, 0);
			dynStats("inte", 10, "lib", 10, "cor", 3);
			flags[kFLAGS.ALVINA_FOLLOWER] = 16;
		}
		else if (player.inte > 35 && player.lib > 35 && flags[kFLAGS.ALVINA_FOLLOWER] == 14) {
			outputText("Against all odds, you manage to hold your lust in check and cast the spells properly.\n\n");
			outputText("\"<i>That will be all for today [name], we will continue tomorrow.</i>\" You head back to camp feeling extremely pent up, but also smarter.\n\n");
			dynStats("inte", 7, "lib", 7, "cor", 2);
			flags[kFLAGS.ALVINA_FOLLOWER] = 15;
		}
		else {
			outputText("Unable to hold back any longer, you orgasm as you cast the spell. Alvina is amused by your lack of endurance.\n\n");
			outputText("\"<i>Well aren’t you the lewd student. Regardless, you will need to practice until you develop some resilience. Come back tomorrow to resume your training.</i>\" She dismisses you, leaving you to clean up your mess. At least you learned a few new things.\n\n");
			dynStats("inte", 4, "lib", 4, "cor", 1);
			flags[kFLAGS.ALVINA_FOLLOWER] = 14;
		}
		doNext(camp.returnToCampUseSixHours);
	}
}

public function alvinaCampAdvancedStudy():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3 && player.hasKeyItem("Siegweird holy symbol") >= 0) {
		player.removeKeyItem("Siegweird's holy symbol");
		outputText("You hand over the holy symbol to Alvina, who smirks as if a long drawn out battle was finally over.\n\n");
		outputText("\"<i>That concludes our business. I took the liberty of writing this spell in a scroll. So here, you can have it.</i>\"\n\n");
		outputText("She throws a scroll at you and begins to pack up her things.\n\n");
		outputText("<b>You gained a scroll of Polar Midnight.</b>\n\n");
		player.addStatusValue(StatusEffects.AlvinaTraining2, 1, 1);
		inventory.takeItem(consumables.POL_MID, camp.campFollowers);
		cheatTime2(5);
	}
	else if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 2 && player.hasItem(useables.AMETIST, 1) && player.hasItem(consumables.L_DRAFT, 5) && player.hasItem(useables.SOULGEM, 10) && (player.hasKeyItem("Marae's Lethicite") >= 0 || player.hasKeyItem("Stone Statue Lethicite") >= 0)) {
		player.destroyItems(useables.AMETIST, 1);
		player.destroyItems(consumables.L_DRAFT, 5);
		player.destroyItems(useables.SOULGEM, 10);
		if (player.hasKeyItem("Stone Statue Lethicite") >= 0) player.removeKeyItem("Stone Statue Lethicite");
		else {
			if (player.keyItemv1("Marae's Lethicite") > 1) player.addKeyValue("Marae's Lethicite", 1, -1);
			else player.removeKeyItem("Marae's Lethicite");
		}
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
		outputText("Wait WHAT!!! the phylactery has such a fatal flaw!? Couldn’t she had told it to you sooner! Now you will have to live with the terror of knowing your life is tied to an item and that alone is terrifying in itself. Alvina, however, does not seem bothered.\n\n");
		outputText("\"<i>And now for the last test... if you want to learn that one final spell I need you to kill someone.</i>\"\n\n");
		outputText("Wait, kill someone? Who?\n\n");
		outputText("\"<i>You heard me right. I need you to kill a paladin by the name of Siegweird who patrols the Blighted Ridge. Bring me back his holy symbol as proof of your deed and I will teach you the greatest spell in my arsenal.</i>\"\n\n");
		outputText("She jumps to sit on a nearby stool and crosses her legs, tapping her chin as she’s seemingly remembering something important.\n\n");
		outputText("\"<i>Oh! That's right, a last warning. In case you had ‘fantasies’ of rebellion against me... I had a few extra components inserted into the spell used to create your phylactery. Should you attempt anything ‘out of line’ I can force it to explode as easily as snapping my finger.</i>\"\n\n");
		outputText("You realize Alvina has your very life in the palm of that cute paw of hers. It's a terrible realization but at the same time, it dawns on you that you have no reason to antagonize her. Truth be told, having a good relation with a font of power like her could only prove beneficial could it not?\n\n");
		player.createStatusEffect(StatusEffects.PlayerPhylactery, 0, 0, 0, 0);
		player.addStatusValue(StatusEffects.AlvinaTraining2, 1, 1);
		if (player.cor < 100) player.cor = 100;
		doNext(camp.returnToCampUseSixHours);
	}
	else if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 1) {
		if (player.devilkinScore() >= 11 || (player.demonScore() >= 11 && player.gender > 0)) {
			if (player.devilkinScore() >= 11) {
				outputText("You ask Alvina if this form will work, and she looks at you, amused.\n\n");
				outputText("\"<i>Well, I didn't expect you to like my form that much. How flattering. I guess you didn’t want to be part of the common rabble, did you? You just had to go a special path? Oh well, like apprentice like master I guess?</i>\"\n\n");
			}
			else if (player.demonScore() >= 11 && player.gender == 1) {
				outputText("You ask Alvina if this form will work, swinging your [cock] for her to admire.\n\n");
				outputText("\"<i>A slavering incubus fits you perfectly.</i>\"\n\n");
			}
			else if (player.demonScore() >= 11 && player.gender == 2) {
				outputText("You ask Alvina if this form will work, giving her a nice view, putting your [breast] and your [pussy] on display.\n\n");
				outputText("\"<i>A slutty succubus fits you perfectly.</i>\"\n\n");
			}
			else {
				outputText("You ask Alvina if this form will work, giving her a nice look, putting your [breast] on display and swinging your [cock] above your [pussy] around so she can admire both.\n\n");
				outputText("\"<i>Couldn’t make a choice? Well, an omnibus fits you perfectly. I was never very interested in having all the possible endowments, however.</i>\"\n\n");
			}
			outputText("Alvina circles you for a moment, examining you thoroughly.\n\n");
			outputText("\"<i>You look demonic alright, but you still lack the power, a power only a soulless body can provide. First, we need to create the soul prison. Get me a flawless Amethyst necklace, five lust drafts, ten soul gems, and a piece of very powerful Lethicite then we can begin.</i>\"\n\n");
			player.addStatusValue(StatusEffects.AlvinaTraining2, 1, 1);
		}
		else outputText("\"<i>You are still way too pure for us to proceed further. Corrupt your body with some demonic transformatives and we will continue.</i>\"\n\n");
		doNext(camp.campFollowers);
		cheatTime2(5);
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
		cheatTime2(5);
	}
	else {
		if (player.cor >= 50) {
			outputText("You ask your mentor for more advanced applications of black magic. Alvina sizes you up and nods.\n\n");
			outputText("\"<i>Your soul is plenty corrupted enough to understand this theory. Regardless, sending your lust at an opponent is one thing, but what of the opponent's own lust? To arouse an opponent with a spell is nice, but it works even better if you mess with the enemy's mind, using his own desires against him. I taught you about controlling your desire, now you need to learn about controlling the desires of others.</i>\"\n\n");
			outputText("She goes on for several hours, but eventually, you learn how to inspire even more lust with your spells. Smiling maliciously at the idea of trying this out.\n\n");
			player.createStatusEffect(StatusEffects.AlvinaTraining2, 0, 0, 0, 0);
			doNext(camp.returnToCampUseSixHours);
		}
		else {
			outputText("You ask your mentor for more advanced applications of black magic but she replies in the negative.\n\n");
			outputText("\"<i>While I could attempt to teach you many things, there is little you could learn without darkening your soul further. Advanced black magic is for the corrupt. Without the proper mindset, there is no way you could even comprehend it. Go get fucked by a few imps or take some transformatives and we will talk about this again.</i>\"\n\n");
			doNext(camp.campFollowers);
			cheatTime2(5);
		}
	}
}
/*
public function alvinaMaincampMenu():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("Ayane's ears perk up as you mention your interest. She takes on a seductive pose, setting up the mood.\n\n");
	outputText("\"<i>Anything I can do for you " + player.mf("lord", "lady") + " [name]?</i>\"\n\n");
	menu();
	addButton(14, "Back", camp.campFollowers);
}

public function alvinaMaincampMenu():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("Ayane's ears perk up as you mention your interest. She takes on a seductive pose, setting up the mood.\n\n");
	outputText("\"<i>Anything I can do for you " + player.mf("lord", "lady") + " [name]?</i>\"\n\n");
	menu();
	addButton(14, "Back", camp.campFollowers);
}

public function alvinaMaincampMenu():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("Ayane's ears perk up as you mention your interest. She takes on a seductive pose, setting up the mood.\n\n");
	outputText("\"<i>Anything I can do for you " + player.mf("lord", "lady") + " [name]?</i>\"\n\n");
	menu();
	addButton(14, "Back", camp.campFollowers);
}
*/
	}

}