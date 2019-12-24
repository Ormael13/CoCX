/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Tongue;
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
	menu();
	addButton(0, "Talk", alvinaSecondEncounterTalk);
	addButton(4, "Leave", camp.returnToCampUseOneHour);
}
public function alvinaSecondEncounterTalk():void
{
	clearOutput();
	outputText("Alvina lowers her book to look at you for a moment, adjusting her glasses in front of her embery eyes.\n\n");
	outputText("\"<i>Still want to know more, do you? Sure, I can share the knowledge but be quick with your queries, I still have a book to read.</i>\"\n\n");
	menu();
	addButton(0, "Her", alvinaSecondEncounterTalkHer);
	addButton(1, "Hobby", alvinaSecondEncounterTalkHobby);
	addButton(4, "Leave", camp.returnToCampUseOneHour);
}
public function alvinaSecondEncounterTalkHer():void
{
	clearOutput();
	outputText("So, who is she exactly? Is she native to Mareth?\n\n");
	outputText("\"<i>I know what you’re thinking, a human on Mareth is something next to nobody sees. There are other humans across the world. I hear the hidden city Tel'adre has several true humans. I myself am a breakaway from the sand witch coven. I didn’t like the weird turn in the practice of late, so I left and used some hummus to properly revert any possible changes.</i>\"\n\n");
	outputText("Well, that explains a lot. So she was born with two set of breasts and a second vagina?\n\n");
	outputText("\"<i>You could say it like that, yes, though I had these traits corrected since.</i>\"\n\n");
	if (player.inte > 150) outputText("There’s something she’s not telling you, likely it is related to her relation with the sand witches. She probably left in very bad terms. Regardless, you find it more prudent to talk about something else.\n\n");
	doNext(alvinaSecondEncounterTalk);
}
public function alvinaSecondEncounterTalkHobby():void
{
	clearOutput();
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
	doNext(camp.returnToCampUseOneHour);
}

public function alvinaThirdEncounter():void
{
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
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
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
	clearOutput();
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
	if (flags[kFLAGS.ALVINA_DIARY] < 5) addButton(1, "Diary", alvinaMainCampMenuDiary);
	if (flags[kFLAGS.ALVINA_DIARY] == 5) addButton(1, "Diary", alvinaMainCampMenuDiaryAreYouSure);
	if (flags[kFLAGS.ALVINA_DIARY] == 6) addButtonDisabled(1, "Diary", "You already readed it.");
	if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 4 && flags[kFLAGS.ALVINA_FOLLOWER] >= 16) {
		if (flags[kFLAGS.ALVINA_FOLLOWER] >= 19) addButton(2, "Sex", alvinaMainCampSexMenu);
		if (flags[kFLAGS.ALVINA_FOLLOWER] == 16 || flags[kFLAGS.ALVINA_FOLLOWER] == 18) addButton(2, "Confession", alvinaMainCampMenuConfession).hint("If you not know what it mean then... whatever I lost faith in your player intelligance.");
	}
	else addButtonDisabled(2, "???", "Need to finish Advanced Study to unlock this option.");
	if (player.hasPerk(PerkLib.BasicLeadership) && flags[kFLAGS.ALVINA_FOLLOWER] >= 19) {
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "") addButton(4, "Team", alvinaHenchmanOption).hint("Ask Alvina to join you in adventures outside camp.");
		else if (flags[kFLAGS.PLAYER_COMPANION_1] == "Alvina") addButton(4, "Team", alvinaHenchmanOption).hint("Ask Alvina to stay in camp.");
		else addButtonDisabled(4, "Team", "You already have other henchman accompany you. Ask him/her to stay at camp before you talk with Alvina about accompaning you.");
	}
	if (player.hasStatusEffect(StatusEffects.AlvinaTraining)) addButtonDisabled(10, "Study", "You already completed basic Study.");
	else addButton(10, "Study", alvinaCampStudy);
	if (player.hasStatusEffect(StatusEffects.AlvinaTraining) && player.statusEffectv1(StatusEffects.AlvinaTraining2) < 2) addButton(11, "Advanced Study", alvinaCampAdvancedStudy);
	else {
		if (player.hasStatusEffect(StatusEffects.AlvinaTraining) && player.statusEffectv1(StatusEffects.AlvinaTraining2) == 2) {
			if (player.hasItem(useables.AMETIST, 1) && player.hasItem(consumables.L_DRAFT, 5) && player.hasItem(useables.SOULGEM, 5) && (player.hasKeyItem("Marae's Lethicite") >= 0 || player.hasKeyItem("Stone Statue Lethicite") >= 0)) addButton(11, "Advanced Study", alvinaCampAdvancedStudy);
			else addButtonDisabled(11, "Advanced Study", "You need to gather a flawless Amethyst necklace, five lust drafts, five soul gems, and a piece of very powerful Lethicite before you can progress.");
		}
		if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3) {
			if (player.hasKeyItem("Siegweird's holy symbol") >= 0) addButton(11, "Advanced Study", alvinaCampAdvancedStudy);
			else addButtonDisabled(11, "Advanced Study", "You need to go kill certain annoying paladin in Blight Ridge.");
		}
		if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 4) addButtonDisabled(11, "Advanced Study", "You already completed Advanced Study.");
	}
	if (flags[kFLAGS.ALVINA_FOLLOWER] >= 20) addButton(14, "Back", camp.campLoversMenu);
	else addButton(14, "Back", camp.campFollowers);
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
	if (flags[kFLAGS.ALVINA_FOLLOWER] < 19) outputText(" I have little time for games as you know all too well.");
	outputText("</i>\"\n\n");
	menu();
	addButton(14, "Back", alvinaMainCampMenu);
}

public function alvinaMainCampMenuDiary():void
{
	clearOutput();
	if (flags[kFLAGS.ALVINA_DIARY] == 4) {
		outputText("While Alvina is busy out of view you open her diary and keep on reading curiosity getting the better of you.\n\n");
		outputText("<i>Day 120 year 84\n\n");
		outputText("Thanks to working actively with the fiend I discovered a new form of magic. A source so far prohibited that draws on the power of desires, lust and the soul itself. It is powerful… So powerful it could actually change spellcasting as we know it. I knew my quest was not in vain and with this new discovery I am one step closer to my goal. I shall make many spells designed around it and develop ");
		outputText("it to its full extent. This year the king died and his daughter, Lethice took over the throne. She should be easy to manipulate in order to justify any measure I need to take for my researches. Once me and her are ‘best friends’ it will be simple to convince her to assist me in anything I need or want.\n\n");
		outputText("Day 135 year 89\n\n");
		outputText("It has been five year since I began my research but I am this close to uncovering the secret of true immortality and power. Lust and desire seems to draw the soul temporarily closer to the heart before stressing it into producing a massive amount of energy. I need to find a way to reproduce this reaction infinitely and, to this end, ");
		outputText("more live test subject will be needed. It doesn't matter anymore how many die in the process, I’m about to realise my greatest dream!\n\n");
		outputText("Day 170 year 91\n\n");
		outputText("After two years of experimentations I finally created an immortal. However the demon as I call it lacks a moral compass and is obsessed with sex. It is a curious creature. It does not hunger, thirst or even seem to age.It also seems to naturally have an affinity for magic. The stone produced out of the subject seems to be a source of immense powers and so I took it with me in order to research it. ");
		outputText("However it seems the test subject’s condition is highly contagious and might destroy the entire kingdom if allowed to roam, as I already lost two apprentices to him, it clearly cannot be contained without resorting to force. For this reason I caged the fiend and my now transformed apprentices in order to study the condition further. Truth be told I am genuinely intrigued by this development.\n\n");
		outputText("Day 171 year 91\n\n");
		outputText("Just as I suspected, this experiment is a failure. While powerful, the creature I now call demon cannot draw on the power of a soul to bolster his black magic as he lacks one entirely. Black magic when used at its maximum output begins to melt the soul out of the body as it tries to escape its container. ");
		outputText("I need to find a way to attain the maximum pleasure and power without losing my soul like him in order to obtain the power I seek. Perhaps encasing the soul in an artificial countainment from which It won’t be able to escape is the solution.\n\n");
		outputText("Day 170 year 125\n\n");
		outputText("Dear journal, It has been many years since I fled the capital city. And I did so just in time, as my creations began to rampage after some idiot let them out of their cages. Fools are all obsessed with sex and lust now, clear signs of black magic abuse! I told those idiots that without further researches black magic would destroy them and did they listen? No! ");
		outputText("Even Lethice seem to have fell prey to this madness as she started calling BDSM and fetishes the new trend. Therefore I fled the capital as everything was going to hell. Regardless, I have made a breakthrough! After separating one of these furry savages from its soul, I found how to bind it to an object that I will call a phylactery. ");
		outputText("I intend to bind mine soon in order to achieve the power of the demons along with the perfect clarity of mind I need to control my new powers without falling prey to this weird madness that has clouded my colleagues judgements.\n\n");
		outputText("Day 150 year 130\n\n");
		outputText("Dear journal, after much calculation and experimentation I created a new form of fiend. My creation shall be small and combine the characteristic of the wise revered goat with those of the current demon model. I thought I would be less inclined to carnal activity and wastes of time if I used a body closer to my purpose as a wizard and I was right all along, this form will suit me well. ");
		outputText("I shall call this new breed of Demon the Devils. Devils got what my first creation, the demons don’t have despite all their power and that's restraint. With the power to shape the world around them, live forever and actually overcome any trials my new breed of fiend should be able to achieve my dream of a perfect world ruled by immortals. ");
		outputText("What I have left to do however is to create an easier ritual as the creation of devils seems to be a difficult one. That said I’m definitely going to perform the ritual for myself.\n\n");
		outputText("Day 170 year 130\n\n");
		outputText("Dear journal, I finally achieved what I sought for all those years. True immortality, however it did not come for free. In order to achieve the ritual I had to corrupt my own body in order to facilitate the soul passage to the phylactery. I realised all too late as I became a devil that despite keeping my head clear I would soon lose the ability to process morality, ");
		outputText("what made me human in the first place. Bah, who need theses anyway, morality is just a tether in the way of progress and true advancement can only be achieved by discarding it. Did I ever even have a moral code in the first place? Well I guess I somewhat did but I have chosen to ignore it, otherwise I wouldn't have gotten this far.</i>\n\n");
		outputText("The journal continues and Alvina is nowhere in sight, you are anxious to see what's inside the diary beyond these page. Do you resume reading and throw caution out the window?\n\n");
		flags[kFLAGS.ALVINA_DIARY] = 5;
		cheatTime2(30);
		menu();
		addButton(1, "No", alvinaMainCampMenuDiaryNo);
		addButton(3, "Yes", alvinaMainCampMenuDiaryYes);
	}
	else if (flags[kFLAGS.ALVINA_DIARY] == 3) {
		outputText("While Alvina is busy out of view you open her diary and keep on reading. The journal continues detailing Alvina vile progress toward wizardhood but, uninterested in the next sixty years which consist mostly of laboratory log and magical experiment, you skip a few pages.\n\n");
		outputText("<i>Day 213 Year 70\n\n");
		outputText("I finally found what I needed as a final ingredient and my sister conveniently happens to have it within her bosom. Only blood can call to blood and in the current case her heart is the component I need in order to get young again so I can continue on my work. That said I considered my options time and time again. In the end it's my life or hers and I am not ready to die just yet, ");
		outputText("she might just be 2 years younger than me but she will do regardless. Am I a monster? No... It's the world around me that is cruel and so long as I don’t find a way to fix it, sacrifices will need to be made. Stopping here and now would make the deaths of everyone who willingly or unwillingly gave their life for me to get this far be in vain.\n\n");
		outputText("Day 215 year 71\n\n");
		outputText("Elizabeth proved little of a challenge for my magic… I stormed her house and ran right to her. What does she have to lose? 65 years old, her kids are gone and she lived happily, she is likely going to die anyway in a few years from a common disease so might as well sacrifice her so I can become young again right? It didn’t go that well. ");
		outputText("At first I tried to end her life in the most humanly possible way but these words... Those horrible words she and her husband threw at me. I am not a monster and I didn’t kill mom and dad! How dare she tell me this?! In that moment, something snapped in me and I lost all pretence of restraint. ");
		outputText("I ripped the bitch’s heart out once her head was no more. For me to recover all those years I have lost researching untold magic I need to perform this ritual and in order to extend my remaining time I need her heart. It is a sacrifice I am willing to make in the name of accomplishing my dreams.\n\n");
		outputText("Day 216 year 71\n\n");
		outputText("I did it, I’m young again as If I was 18. Now all I need is the financial support to resume my experiments as I look toward a more permanent solution to this silly disease called aging. That said the fiend I previously summoned offered to train me further in the magical arts. Perhaps I can learn from him something even the best wizards ignore.\n\n");
		outputText("Day 170 year 72\n\n");
		outputText("This is all too perfect. That idiotic court mage up at the king's stronghold took me in as an apprentice. Soon I will have unlimited access to the royal library and of course the old bastard own notes. That said he has very little useful information to give. The people here are way to pious and pure it reminds me of that old teacher I killed so long ago. ");
		outputText("I have seen the power of darkness firsthand and clearly those fools know nothing about true magic.</i>\n\n");
		outputText("You skip a few pages to see what happened.\n\n");
		outputText("<i>Day 102 year 80\n\n");
		outputText("I was finally named archmage out of all the fools at the palace. Truth be told, poisoning the old codgers with undetectable toxins turned out to be perfect because most people think the wizards died from aging. I can now fully devote my time to my research using all the old man had at his disposal.</i>\n\n");
		outputText("Alvina almost catches you this time but you manage to act like you didn't open her diary or read in it. This is starting to become dangerous maybe you should stop your reading now? You head back to camp.\n\n");
		flags[kFLAGS.ALVINA_DIARY] = 4;
		doNext(camp.campFollowers);
		cheatTime2(20);
	}
	else if (flags[kFLAGS.ALVINA_DIARY] == 2) {
		outputText("While Alvina is busy out of view you open her diary and keep on reading.\n\n");
		outputText("<i>Day 10 Year 7\n\n");
		outputText("I am an orphan. Father and mother died of illness 5 years ago. Despite the money I brought home for them to be cured, nothing worked and the doctor said no amount of money would matter now. I have nothing left but my now 8 year old sister still at the orphanage we were sent to and this strange power ever growing inside of me. This year I left the orphanage because I decided to attend magic studies. ");
		outputText("Fact is I was selected amongst many to become a wizard due to my high intelligence, though no one suspected I still heard the voice of Mephi from time to time in my mind. However the school where I study is so boring and way too strict. The teachers are stubborn and close minded… Restricted area they say? ");
		outputText("There's no such thing as a restricted area in the library for me… What if a ritual to revive papa and mama was in there? Sooner or later I will find these secret books.\n\n");
		outputText("Day 35 Year 7\n\n");
		outputText("I finally deciphered a ritual in the books and just in time too! The teacher had it confiscated but not before I managed to transcribe a copy. I finally found how to summon that creature I met five years ago. This is very creepy magic but I’m willing to pay any price to have my parent back and if that Mephi thing can help I will seek him out. ");
		outputText("Heck the teacher is likely just jealous or afraid I will actually surpass him thanks to Mephi’s help, how short sighted!\n\n");
		outputText("Day 65 Year 7\n\n");
		outputText("Mephi killed a few students, said it was the price of my debt and that either I had to pay it or they would, I took the wise option. He offered to mentor me but only in exchange for an even greater sacrifice, I am not willing to do such a thing just yet. Since Mephi won’t help without me paying even more I decided not to rely on him for now although he said I would inevitably call him again ");
		outputText("in due time. I need to continue researching for a way to revive my parent so I will keep looking over these books. At worse I could also revive those dead students so long as I have their corpse right? The teachers are none the wiser, they think someone accidentally summoned that creature in the school and that it started going on a rampage. ");
		outputText("They know little of the fact I traded the lives of my comrades to him in order to gain the information I wanted.\n\n");
		outputText("Day 110 Year 7\n\n");
		outputText("How dare they! I got expelled from the mage school just as I finally found what I needed. The principal called me an undisciplined little witch while the bullies laughed behind my back, well fine I will show them how much of a witch I am! Tonight I will summon Mephi like I did several months ago and this time I will let it feast on everyone. ");
		outputText("Once they are all dead I will pick up the tome the teacher took from me and attempt this resurrection ritual.\n\n");
		outputText("Day 111 Year 7\n\n");
		outputText("Mephi killed everyone as predicted and even allowed me to forge a true pact after he sated himself on the souls of those jerks. The teacher proved to be an annoying challenge but with my newfound knowledge and new otherworldly assistant, dispatching the old scholar was an easy task. Mephi is interesting and willing to help, perhaps I should learn how to harness such powers from him? ");
		outputText("However to my dismay when I went to attempt the revival ritual for my parents and came for their corpses I discovered to my horror that they had already been disposed of by cremation. Tonight I truly am an orphan for good… I will make my peace with this dream of mine and mourn them then move on.\n\n");
		outputText("Day 160 Year 7\n\n");
		outputText("They are still investigating the incident at the school but as I predicted I am far away now and with the entirety of the forbidden collection. It is unlikely they will find out anything about what happened let alone trace it back to me. I also left them a parting gift and should someone try and visit the school in the following years they will have a nasty surprise.</i>\n\n");
		outputText("You decide to close the book before Alvina catches you reading it. This is getting creepier the more you know about her. Thankfully she didn’t notice and so you head back to camp.\n\n");
		flags[kFLAGS.ALVINA_DIARY] = 3;
		doNext(camp.campFollowers);
		cheatTime2(20);
	}
	else if (flags[kFLAGS.ALVINA_DIARY] == 1) {
		outputText("While Alvina is busy out of view you open her diary and keep on reading.\n\n");
		outputText("<i>Day 335 Year 2\n\n");
		outputText("I have begun to hear voices.. terrifying voices calling my name. I don’t know how to reply to them however and I am scared. The man is getting increasingly impatient as if waiting for something. Daddy and mommy are ok for now, praise lady Marae, they have stabilised but this could change at any time.\n\n");
		outputText("Day 348 Year 2\n\n");
		outputText("The man is evil, he wants to hurt me. I heard him talk about sacrificing me if things don’t happen within time. The voices are still there too, desperate for me to reach them. I hope this all ends soon. Daddy and mommy look terrible now why did Sis ever open the window!\n\n");
		outputText("Day 349 Year 2\n\n");
		outputText("Blood, there was blood everywhere. When the man tried to hit me with a knife, I screamed and something out of my worst nightmare appeared. The man bowed to it but the creature who in my mind told me to be the lord of the pacts, Mephi-something, killed him turning him into a disturbing mess of gore and blood on the ground before me. I screamed but the monster didn’t kill me too, ");
		outputText("instead he just walked to me and pat me on the head. At that moment I felt strange… as if hot water poured into my body drop by drop, it felt so horribly wrong yet so great. He left saying he would be back in a few years when whatever he did to me would have grown enough that I would be able to call him again, he also said I am indebted to him now but I guess since he saved my life it is not so bad right?</i>\n\n");
		outputText("You decide to close the book before Alvina catches you reading it. This is getting creepier the more you learn about her. Thankfully she didn’t notice, so you head back to camp.\n\n");
		flags[kFLAGS.ALVINA_DIARY] = 2;
		doNext(camp.campFollowers);
		cheatTime2(10);
	}
	else {
		outputText("As you look in Alvina’s things you notice a small book that was left on a table. Curious you take it with you while she is busy and proceed to read it.\n\n");
		outputText("<i>Day 1\n\n");
		outputText("Hello, my name is Alvina and I am seven years old. Daddy bought me this journal for my birthday saying I should write once in a while about what I think.</i>\n\n");
		outputText("A small drawing of a bunny and a cute goat are on the left side of the page. So far it looks like the diary of a young child, but a few pages later the tone of the content changes dramatically.\n\n");
		outputText("<i>Day 316 Year 2\n\n");
		outputText("Mommy and daddy fell sick. The doctor said only the gods can save them but I’m sure he’s lying. He knows we don’t have the money to buy medicine and I heard a weird man in the neighborhood has offered to help me gather the money so I will seek him out and make do on whatever he wants to save mommy and daddy!\n\n");
		outputText("Day 322 Year 2\n\n");
		outputText("It hurts… it hurts so much. But the man said I have to endure it if I want the money. I heard people who actively accept to work for him have a tendency to disappear and I am scared. Today he used me as part of some strange thing he call a summoning ritual. ");
		outputText("He said he's desperate to talk to someone and needs me for it. My arm is still in pain from the hot iron he marked me with to inscribe some weird drawing into my skin.</i>\n\n");
		outputText("You decide to close the book before Alvina catches you reading it. Thankfully she didn’t notice and so you head back to camp.\n\n");
		flags[kFLAGS.ALVINA_DIARY] = 1;
		doNext(camp.campFollowers);
		cheatTime2(10);
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
	outputText("Damn it all! I should have known this couldn't be perfect. My body is safe but if my soul was to be destroyed I would disappear into nothingness undone by the very powers that keeps me alive. No one shall ever learn of this weakness. I need to protect the....</i>\n\n");
	if (player.statusEffectv1(StatusEffects.AlvinaTraining2) > 2) {
		outputText("Bah you read the rest but can’t find anything useful in her journal to grow any more powerful. Alvina, of course, left most of the details of her weaknesses in the shadow though, since she discussed it with you, you already know the full details of what it is.\n\n");
		outputText("\"<i>Had a good read?</i>\"\n\n");
		outputText("Alvina is standing behind you as you expected, her current smirk could pass for creepy. You simply tell her the journal was pretty much useless though you did show much interest into knowing how the mighty Alvina became Mareth’s greatest mage.\n\n");
		outputText("\"<i>Flatterer. You are lucky to already be in on the secret otherwise I would have to destroy you in order to keep you silenced.</i>\"\n\n");
		outputText("She picks up her journal and packs it up back in her bag.\n\n");
		flags[kFLAGS.ALVINA_DIARY] = 6;
		doNext(camp.campFollowers);
		cheatTime2(5);
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
		outputText("\"<i>I wasn’t sure you would come back alive and with the rose no less, but you did fulfill your end of the bargain and I will fulfill mine. I haven’t had proper sex in a century, so fine, I will give you a try, let’s see what you're made off.</i>\"\n\n");
		flags[kFLAGS.ALVINA_FOLLOWER] = 19;
		if (player.lib > 50) {
			outputText("You smile perversely and offer to do it right here and right now on your "+(flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed" : "bedroll")+".\n\n");
			outputText("\"<i>Bah! That bed is for amateurs, I recall teaching you bigger than that. Watch this!</i>\"\n\n");
			outputText("She chants an arcane line and a closed door appears out of the ether, seemingly standing on nothing. You ask her what she’s up to when she opens the door. Beyond the cadre, you see what looks like a magnificent bedroom with a large bed fit for an empress and decorated with translucent purple drapes. ");
			outputText("There are various decorations all the more arousing, as well as a cupboard filled with various toys. More than hyped up, you pick up Alvina’s hand and guide her to the bed.\n\n");
			outputText("\"<i>");
			//outputText("(If married with Alvina) It’s been so long since last we consummated our love. I’m quite glad you asked, as you know(End of cut) ");
			outputText("I can spice things up for you, depending on your tastes, by summoning a malefice, so what will it be?</i>\"\n\n");
			outputText("Alvina licks her lips in anticipation, for once interested in something else than her scholarly researches.");
			//outputText(" (If married) Not that you mind. Since the wedding, Alvina has been doing less research on how to bend the universe and more on how for the both of you to have the best mind-blowing sex, an initiative you greatly appreciate.(end of cut)");
			outputText("\n\n");
			flags[kFLAGS.ALVINA_FOLLOWER] = 20;
			alvinaMainCampSexMenu2();
		}
		else {
			outputText("It's barely been an hour and Alvina has already become quite bored. She shakes her head negatively and removes herself from you.\n\n");
			outputText("\"<i>You lack both originality and talent even for a demon. Just where’s your libido?! I’m quite disappointed, so nah, I don’t think you're worth my while on this field. Now if you would excuse me I have my stuff to pack up.</i>\"\n\n");
			doNext(camp.campFollowers);
			cheatTime2(45);
		}
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
		outputText("Fact is, the black rose is the facet of a long lost deity related to death by natural causes and aging. I want to acquire it to study its properties. Bring me the rose and I will offer you a place in my bed.</i>\"\n\n");
		flags[kFLAGS.ALVINA_FOLLOWER] = 17;
		doNext(camp.campFollowers);
		cheatTime2(5);
	}
}
public function alvinaMainCampSexMenu():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("You tell Alvina you improved on your bed skills and offer her to try you up again.\n\n");
	outputText("\"<i>Ugh if you werent my pupil I wouldn't even consider the idea. Fine then, lets see if you make for a decent lover now.</i>\"\n\n");
	if (player.lib > 50) {
		outputText("You smile perversely and offer to do it right here and right now on your "+(flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed" : "bedroll")+".\n\n");
		outputText("\"<i>Bah! That bed is for amateurs, I recall teaching you bigger than that. Watch this!</i>\"\n\n");
		outputText("She chants an arcane line and a closed door appears out of the ether, seemingly standing on nothing. You ask her what she’s up to when she opens the door. Beyond the cadre, you see what looks like a magnificent bedroom with a large bed fit for an empress and decorated with translucent purple drapes. ");
		outputText("There are various decorations all the more arousing, as well as a cupboard filled with various toys. More than hyped up, you pick up Alvina’s hand and guide her to the bed.\n\n");
		outputText("\"<i>");
		//outputText("(If married with Alvina) It’s been so long since last we consummated our love. I’m quite glad you asked, as you know(End of cut) ");
		outputText("I can spice things up for you, depending on your tastes, by summoning a malefice, so what will it be?</i>\"\n\n");
		outputText("Alvina licks her lips in anticipation, for once interested in something else than her scholarly researches.");
		//outputText(" (If married) Not that you mind. Since the wedding, Alvina has been doing less research on how to bend the universe and more on how for the both of you to have the best mind-blowing sex, an initiative you greatly appreciate.(end of cut)");
		outputText("\n\n");
		alvinaMainCampSexMenu2();
	}
	else {
		outputText("It's barely been an hour and Alvina has already become quite bored. She shakes her head negatively and removes herself from you.\n\n");
		outputText("\"<i>You lack both originality and talent even for a demon. Just where’s your libido?! I’m quite disappointed, so nah, I don’t think you're worth my while on this field. Now if you would excuse me I have my stuff to pack up.</i>\"\n\n");
		doNext(camp.campFollowers);
		cheatTime2(45);
	}
}
public function alvinaMainCampSexMenu2():void
{
	menu();
	if (player.hasCock()) addButton(0, "Pride of Lucifer", alvinaMainCampSexMenuPrideOfLucifer);
	else addButtonDisabled(0, "Pride of Lucifer", "Need to be Male or Herm for this.");
	addButtonDisabled(1, "Greed of Mammon", "Still unwritten.");
	if (player.hasVagina()) addButton(2, "Blaspheme of Baphomet", alvinaMainCampSexMenuBlasphemeOfBaphomet);
	else addButtonDisabled(2, "Blaspheme of Baphomet", "Need to have pussy for this.");
	if (player.hasVagina()) addButton(3, "Contract of Mephistopheles", alvinaMainCampSexMenuContractOfMephistopheles);
	else addButtonDisabled(3, "Contract of Mephistopheles", "Need to have pussy for this.");
	if (player.hasVagina()) addButton(4, "Gluttony of Beelzebub", alvinaMainCampSexMenuGluttonyOfBeelzebub).hint("Warning this one is weird");
	else addButtonDisabled(4, "Gluttony of Beelzebub", "Not yet coded.");
	addButton(14, "Back", alvinaMainCampMenu);
}
public function alvinaMainCampSexMenuPrideOfLucifer():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	//outputText("(If Married) You suggest Alvina takes charge this time around and she replies to you with a smug grin. (end of cut) ");
	outputText("You grab the girl by the shoulder and pull her to you for a kiss, Alvina replies in the same way. For someone with such a small looking body, Alvina is way more experienced than she looks. You wrestle for several minutes trying to catch each other’s tongue, but it doesn't end there as Alvina suddenly casts a spell.\n\n");
	outputText("Her form suddenly changes as shadows cover her small frame. She gets taller, up to 6 feet, her breast swelling up as her firm backside fills into a shape closer to that of a standard succubus. Her twilight black hair grows as well, reaching ass length. Finally, her wings also get slightly larger now, stretching wide enough to encompass both sides of the bed. ");
	outputText("Gods above, the perfect hourglass shape, sensual mouth with those perfect cock pillows, juicy pussy dripping with excitement, and generous bosom of your infernal princess look like they were made to tempt and corrupt the hearts of men. She sashays to you, winking playfully at your reaction.\n\n");
	//outputText("\"<i>I know you love this form a lot, so today...</i>\"");(if married) 
	outputText("\"<i>You thought I couldn't change my shape to that of a proper succubus? Think again, because I’m going to show you all the delightful things this perfect temptress body can do.</i>\"");
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
		outputText("Alvina licks her lips as she glares down at the forest of meat, looking ready to pounce and devour each meat rod in a moment. Her hot breath washes over the sensitive tips, making them throb with a desire for touch. \"<i>My my my...how ever will I choose which of these cocks to wring dry first? They all looks so delicious, so <i>full</i>! I simply can’t decide which ");
		outputText("I want to devour first.</i>\" The heavy tone of desire carried her voice is shared by her visage; a twisted, voracious smile on her lips, extensive tongue rolling against those plush lips. \"<i>I must congratulate you, [name]. You have finally managed to impress me! Such a depraved individual, hosting such a delectable forest of meat...</i>\" ");
		outputText("she pulls the mass of throbbing mounds flush against her luscious pillows, brushing her lips against the tips and playfully teasing the engorged heads, \"<i>and all of it for me~. Mmm~.</i>\" A veteran huntress, eyes wild, frenzied, burning alight as the scent of her prey, of fear, of you, fills her nostrils.");
	}
	outputText("\n\n");
	outputText("Those fiendish eyes, infernal irises encompassing slitted pupils are firmly locked onto your own [eyes]. And in that moment, every ounce of want, need, desire, longing, hunger, every wild surge, primal instincts claiming precedence; every fibre of your being tormented by raging lust. In a moment, every ounce of passion Alvina is afflicted by is transferred through a single look.\n\n");
	outputText("Before you can blink, she is already on top of you. Her claws digging into your arms, restraining you. A massive grin, teeth bared, displaying the rows of perfect, shining white fangs ready to sink themselves deep into your flesh. The devil sorceress leans down, your faces nearly touching, your vision taken by those feral orbs. You feel a faint pressure against your lips, ");
	outputText("the fleeting taste of her left on your lips. She seamlessly drifts across your body, tormenting your skin with such expertise even the most salacious demons would be astonished. Every flick, caress, pinch and stroke perfect; each enthralling touch mesmerizing; your body gladly submitting to your dark mistress above, falling into each skilled brush of her skin against yours.\n\n");
	outputText("You feel her fur sliding sensually on your legs as she climbs up into position, wrapping her immaculate E cup breasts around your [cock]. Pressing your tool against her chest, holding it snuggling between her two massive globes, she coats your trapped member in her infernal saliva. Her hellish saliva cascades down your member, the liquid intensifying every sensation felt tenfold. ");
	outputText("Relishing in that look of helplessness on your face for a few moments longer, she finally leans down and starts to lick your tip. You moan as a blinding ray of colors explodes across your vision as she plays with your [cockhead], and you arc into her motions as your body now demands more. She only ever stopping so you can catch your breath, toying with your twitching form. Her tongue ");
	outputText("is just as dexterous as her hand, gently prodding your urethra while tracing your veins making you shiver in agonizing pleasure, thrusting you to the brink of consciousness only to rip you back; unrelenting excruciating ecstasy coursing through every vein. She could get you off within seconds if she wanted but instead, she delays the orgasm with just the right pace to keep you hanging.\n\n");
	outputText("\"<i>I could make you cum like a virgin if I wanted");
	//outputText("(if pc is virgin) and hell you are one, I can taste it(end of cut)");
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
	alvinaMainCampSexMenu3();
}
public function alvinaMainCampSexMenuGreedOfMammon():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("You find Alvina somewhat busy packing up her gear. You're surprised she’s leaving this early.\n\n");
	outputText("\"<i>There's no point in me staying here, you successfully learned all I know and did all I asked. I have no further need or interest for you.</i>\"\n\n");
	alvinaMainCampSexMenu3();
}
public function alvinaMainCampSexMenuBlasphemeOfBaphomet():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("You grab the devil girl by the shoulders, pulling her into a deep kiss. Alvina all too eager to reciprocate. Your tongues dance for a few minutes, the infernal venom coating her orifice igniting your passions, your hands exploring her form greedily but this is not enough. ");
	outputText("You really could use a fucking right now and ask your twilight princess if she has any sex toys in reserve for that.\n\n");
	outputText("\"<i>Oh, a toy won’t be necessary. I can arrange that just fine, it has been some time since last used this spell anyway.</i>\"\n\n");
	outputText("Alvina slowly pulls you down on the bed sitting on your lap and exposing her lovely pussy to your face. It drools a few drops of corrupt femjuice over your chest, the accursed substance making your skin tingle with delight.\n\n");
	outputText("\"<i>To awaken this magic");
	//outputText("(if married), as you know already(end of cut)");
	outputText(", I need to be more aroused than this. So if you would please show me your talents…</i>\"\n\n");
	outputText("She doesn’t have to tell you twice, diving head first towards her infernal cunt, you begin to lick her lunchbox, tasting the juices of your girl-fiend, delivering the pleasure she desires. Indulging in more of her infernal juices has stirred something deep within, now an unquenchable desire for her pleasure plagues your mind, clouding your thoughts in a thick haze of lust. ");
	outputText("You ravenously attack her cunt, your tongue darting around near sporadically as you try to hit every sensitive spot to bring the naughty devil to orgasm. Her girl juice ignites fires along your tongue, pleasure courses through your form.");
	if (player.tongue.type == Tongue.DEMONIC) outputText(" That said, your demon tongue is perfectly capable of bringing the both of you to orgasm and you ravenously play with her cunt using your unique appendage, easily able to stimulate every sensitive area, your prowess aptly exemplified. From above,  you can hear Alvina gasp in delight.");
	outputText("\n\n\"<i>OHHhhh yes [name] keep it up I feel the magic building…!”</i>\"\n\n");
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
	outputText("You can’t control yourself and you scream for her to fuck your soul out of your succubus pussy and heck, if your soul wasn’t already out of your body you think it would have flowed out by now from the sheer power of pleasure you are receiving. You begin to buck your hips in an attempt to stimulate your partner and Alvina moans in pleasure as the both of you begin to slide in and out ");
	outputText("of each other, her horsecock hitting your clitoris on every strike. Before you know it you are orgasming several times, your pussy gushing corrupted juice which only arouses Alvina more, fucking your pussy until you can’t cum anymore. Speaking of cum, no matter how many time the demoness fills your cunt with strands of white sponge her cock simply won't deflate. ");
	outputText("It goes for so long that the bed itself becomes soaked with your combined fluids.\n\nYou pass out from the overstimulation as your pussy gush yet again, losing track of time and space, only recovering awareness several hours later, still getting fucked by Alvina but utterly satisfied. She gives you a gentle kiss before whispering in your ear.\n\n");
	outputText("\"<i>Finally satisfied lover…? Your pussy just wouldn’t let go. You sure are a thirsty one aren’t you? ");
	//outputText("(Married) This is one of the things I love so much about you.");
	outputText("I like that in a girl.");
	outputText("</i>\"\n\nThe dimension fades as the two of you reappear in camp feeling energized. She’s god damn right and you sure would do it again.\n\n");
	dynStats("lib", 2 + rand(3));
	dynStats("str", 2 + rand(3));
	dynStats("inte", 2 + rand(3));
	alvinaMainCampSexMenu3();
}
public function alvinaMainCampSexMenuContractOfMephistopheles():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("Alvina makes an impish smile as she readies the malefice and the entire room suddenly starts to fade, turning into what looks like a fleshy cavern. You aren’t that sure of what’s going on until the walls suddenly turn alive with tentacles slithering out from them. Alvina doesn’t seem to be scared, heck she is already caressing one of the things like a well-loved pet ");
	outputText("and it wriggles in her hand coiling for further affection.\n\n\"<i>You ought to admit, you always were curious about what an eternity of getting fucked by tentacle beasts must feel like. Truthfully, I sometimes lock myself in this secret pleasure room of mine for entire days. Just lay back and enjoy, though I must warn you, they tend to get carried away. Their contract is clear, ");
	outputText("they will fuck the both of us until we lie as broken and drooling messes on the ground... think you can endure it?</i>\"\n\nThe tentacles get to work, slowly coiling around Alvina’s body, as some stretches to yours. Truth be told, even if you wanted to repel them now, without a weapon or armor it would be a difficult battle. Furthermore, you believe Alvina is in complete control ");
	outputText("of this pocket dimension and wouldn’t let her pupil suffer a slimy end at their ministrations. As the fleshy things coil around your legs, you move to Alvina, embracing her body along with the tentacles coiling around her. The slithering flesh of the tentacles slides around your skin and hers groping at your and Alvina’s breasts and masterfully squeezing them. Your eyes open wide ");
	outputText("in surprise as the things pull your two legs away holding you in the air for a tentacle to wildly ram itself into your pussy sliding in up to your womb where it starts to wriggle wildly. Another tentacle finds your ass making you gasp as it stretches your pucker wide. Alvina’s cheeks are already bright red from the fucking as she smashes her breast with yours trying to increase ");
	outputText("the tentacles stimulations. A tentacle decides to help you both by sliding between the sandwich of your tits.\n\n");
	outputText("\"<i>See? You're making such a wonderful face right now. These creatures respond to pleasure and the more you will allow them the more they will take. Oooooh fuuuck YES!!! Do me! Do me more!!!...</i>\"\n\n");
	outputText("You moan and spasm at the crazy fuck, your very innards coming to life and just as you open your mouth to scream your delirious pleasure in a slutty moan, you feel your stomach churning and your eyes rolling as the tentacle in your bowel finally finish its course, slithering out of your throat and gagging you, as it rushes into Alvina’s waiting mouth connecting the both of you ");
	outputText("into a perverse kiss. You barely register the tentacle surging out of her anus in a gush of cum as the both of you are fucked silly, your stomachs bulging and squirming with the tentacles inside. Your pussy has gone crazy, your anus has gone crazy, your entire body has gone crazy, you’ve gone crazy. ");
	if (player.hasCock()) {
		outputText("Just as you thought it couldn't get better, you feel your cock being grabbed by something as a tentacle equipped with a fleshy suction cup plugs you in and begins to suck up all of your leaking precum. Soon, you’re cumming a constant river into the tube as shattering pleasure rushes to your mind like a tidal wave, as your pussy and cock takes on a mind of their own and betray you, ");
		outputText("forcing your body to buck up in tandem with the tentacles movement. ");
	}
	outputText("You slowly lose the concept of time as the tentacles fuck you, drenches you in cum, and wrecks your spasming body again and again. A tentacle even forced its way into Alvina’s ass and surged back out of her mouth and shoved itself right into yours, exploring your body up to the exit and cumming out of your anus. ");
	outputText("The ground is constantly soaked with your fluids, which you barely register being drunk by some kind of weird orifice.\n\n");
	outputText("You pass out from the overstimulation abandoning yourself to the wild fucking of the tentacles.\n\n");
	alvinaMainCampSexMenu3();
}
public function alvinaMainCampSexMenuGluttonyOfBeelzebub():void
{
	spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("You grab the girl by the shoulder and pull her in for a kiss as your girl-fiend replies in the same way. For someone with such a small, immature looking body, Alvina is way more experienced than she looks. You wrestle for several minutes, suckling on each other’s tits, fingering and grinding pussies, but it doesn't end there, as Alvina suddenly casts a spell. ");
	outputText("Before you know it the bed turned into a living mass of cock shaped larvae looking for an orifice. You gasp in surprise and delight when some of them enter your pussy, filling your holes and squirming inside. Alvina isn’t spared either her vagina is already squirming with the penis shaped larvae.\n\n");
	outputText("\"<i>Ahhhn! Beelzebub's couch is quite a lovely spell, I could never get rid of it. These larvae feed on fluids and are quite smart, do you feel it… all up to your cervix? Do let them satisfy their endless gluttony.</i>\"\n\n");
	outputText("Oh yes, you can feel them… it's like the larvae are all working together to bring you to climax! You cum once, twice, thrice! Each time you cum the worms squirming intensify as they rush into your vagina to be the first to get a drop, making a constant maelstrom in your pussy as they all push into your clit. You can’t hold it anymore, your eyes rolling as you lock in a hug with Alvina, ");
	outputText("mindlessly bucking your hips in the air as the inside of your hole is filled with squirming madness. The both of you begin to grind your pussies against each other to increase the maddening pleasure and, not content with simply driving your inside insane, the larvae begin to flood from your pussy to Alvina’s and backward sliding between the two of you and connecting your cunts ");
	outputText("with a slimy double dildo made of squirming bugs. You keep bucking your hips as your pussies touch then part ways linked by a chain of squirming larvae. Your vagina suddenly fills up with cum as the dick-larvae all starts to bottom out inside your pussy, cuming in all directions and painting your inner walls. That done the larvae all proceed to leave your cunt one by one. ");
	outputText("This is way too much and you start orgasming consecutively each time one slides out, your pussy spewing them out with a torrent of cum as you begin to babble and drool. Alvina is in a similar state smiling with an ecstatic expression as the larvae flood out of her drenching pussy. Once outside, they merge back in the bed, disappearing in whatever dimensional hole they came from.\n\n");
	outputText("The both of you stay entangled in one another still tired after the crazy ordeal.\n\n");
	alvinaMainCampSexMenu3();
}
public function alvinaMainCampSexMenu3():void
{
	if (flags[kFLAGS.ALVINA_FOLLOWER] >= 20) {
		outputText("A while later you wake up. Alvina is sitting next to you yawning as she dresses up.\n\n");
		outputText("\"<i>Always a delight to have a good time with you, lover. We will resume for another round a different time because for now, I have experiments and researches to continue.");
		//outputText("(If married) You know all too well I ought to find better ways to improve our pleasure because in all honesty sex with you is one of my biggest joys in life.(end of cut)");
		outputText("</i>\"\n\nYou get dressed and part with her as you head back to your things.\n\n");
	}
	else {
		outputText("A while later you wake up. Alvina is sitting next to you yawning as she begins to re-dress in her usual somewhat minimalist bikini mage armor.\n\n");
		outputText("\"<i>You ain’t that bad of a demon. I expected you to freak out or perhaps even die from the stimulation but you endured it, so I guess I'll keep you as my lover for a while. See me in camp if you're interested in some fun big "+player.mf("boy","girl")+".</i>\"\n\n");
		outputText("You re-dress and part with her as you head back to your things.\n\n");
		outputText("<b>Alvina is now your lover.</b>\n\n");
		flags[kFLAGS.ALVINA_FOLLOWER] = 20;
	}
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}

public function alvinaHenchmanOption():void
{
	clearOutput();
	if (flags[kFLAGS.PLAYER_COMPANION_1] == "") {
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
		flags[kFLAGS.PLAYER_COMPANION_1] = "Alvina";
	}
	else {
		outputText("Alvina is no longer following you around.\n\n");
		player.removeStatusEffect(StatusEffects.CombatFollowerAlvina);
		flags[kFLAGS.PLAYER_COMPANION_1] = "";
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
		if (player.inte > 70 && player.lib > 70 && flags[kFLAGS.ALVINA_FOLLOWER] == 15) {
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
	if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3 && player.hasKeyItem("Siegweird's holy symbol") >= 0) {
		player.removeKeyItem("Siegweird's holy symbol");
		outputText("You hand over the holy symbol to Alvina, who smirks as if a long drawn out battle was finally over.\n\n");
		outputText("\"<i>That concludes our business. I took the liberty of writing this spell in a scroll. So here, you can have it.</i>\"\n\n");
		outputText("She throws a scroll at you and begins to pack up her things.\n\n");
		outputText("<b>You gained a scroll of Polar Midnight.</b>\n\n");
		player.addStatusValue(StatusEffects.AlvinaTraining2, 1, 1);
		inventory.takeItem(consumables.POL_MID, camp.campFollowers);
		cheatTime2(5);
	}
	else if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 2 && player.hasItem(useables.AMETIST, 1) && player.hasItem(consumables.L_DRAFT, 5) && player.hasItem(useables.SOULGEM, 5) && (player.hasKeyItem("Marae's Lethicite") >= 0 || player.hasKeyItem("Stone Statue Lethicite") >= 0)) {
		player.destroyItems(useables.AMETIST, 1);
		player.destroyItems(consumables.L_DRAFT, 5);
		player.destroyItems(useables.SOULGEM, 5);
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
				outputText("You ask Alvina if this form will work, giving her a nice view, putting your [chest] and your [pussy] on display.\n\n");
				outputText("\"<i>A slutty succubus fits you perfectly.</i>\"\n\n");
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

}