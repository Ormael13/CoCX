/**
 * ...
 * @author Liandri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	
	public class LunaFollower extends NPCAwareContent
	{
		
		public function LunaFollower() 
		{
			
		}
		//luna foll 2 - kicked post moon event, 3 seen her dead in forest
		
		public function lunaAffection(changes:Number = 0):Number
		{
			flags[kFLAGS.LUNA_AFFECTION] += changes;
			if (flags[kFLAGS.LUNA_AFFECTION] > 100) flags[kFLAGS.LUNA_AFFECTION] = 100;
			return flags[kFLAGS.LUNA_AFFECTION];
		}
		public function lunaJealousy(changes:Number = 0):Number
		{
			flags[kFLAGS.LUNA_JEALOUSY] += changes;
			if (flags[kFLAGS.LUNA_JEALOUSY] > 100) flags[kFLAGS.LUNA_JEALOUSY] = 100;
			if (flags[kFLAGS.LUNA_JEALOUSY] < 0) flags[kFLAGS.LUNA_JEALOUSY] = 0;
			return flags[kFLAGS.LUNA_JEALOUSY];
		}
		
		public function meetingLunaFirstTime():void {
			clearOutput();
			outputText("As you wander the streets of Tel'Adre, you see a woman being brutally thrown out of a house along with her belongings. The crowd seems to be ignoring her.  Curious, you walk up to her just in time to see her start to cry. She wears what looks like a formal maid dress. Under her white bonnet, the maid sports short, ashen hair. You decide to break the ice and ask her what's going on. By all means she looks human, which is a surprise to you.\n\n");
			outputText("\"<i>Why, this is terrible... I’m masterless, and out of job! What am I going to do?</i>\"\n\n");
			outputText("What did she do to be fired to begin with?\n\n");
			outputText("\"<i>Master William’s wife is a liar. She didn’t like me around her husband, so she broke his favorite vase and framed me for it.</i>\"\n\n");
			outputText("Well... Talk about unfair treatment. Aren’t there any other people she could work for in town?\n\n");
			outputText("\"<i>Once a servant is cast out, everyone in town is going to learn about it. My life as a servant is ruined. What am I going to do? Work as a whore at the penthouse? I could never do such a thing.</i>\"\n\n");
			outputText("You could help her or leave her be. What will you do?\n\n");
			menu();
			addButton(0, "Help", meetingLunaFirstTimeHelp);
			addButton(1, "Leave", meetingLunaFirstTimeLeave);
		}
		public function meetingLunaFirstTimeLeave():void {
			outputText("Sadly you see no way you could help her out. You leave, wishing her the best of luck.\n\n");
			flags[kFLAGS.LUNA_FOLLOWER] = 1;
			doNext(camp.returnToCampUseOneHour);
		}
		public function meetingLunaFirstTimeHelp():void {
			outputText("Now that you think about it, life at camp would be infinitely easier if you had a person like her helping around. How about she come over to live with you at your camp?\n\n");
			outputText("\"<i>You.. you would hire me? Even after I have been kicked out? Oh this is wonderful! Thank you so much!!</i>\"\n\n");
			doNext(meetingLunaCamp);
		}
		public function meetingLunaRepated():void {
			clearOutput();
			outputText("As you walk the streets of Tel’Adre, you spot the human maid from before. She's holding an empty can and using it to beg for money as she sits on the side of the street. Seeing the former servant girl reduced to this state makes you feel terribly sorry for her. It is not too late to revise your decision, will you help her out?\n\n");
			menu();
			addButton(0, "Yes", meetingLunaRepatedYes);
			addButton(1, "No", meetingLunaRepatedNo);
		}
		public function meetingLunaRepatedNo():void {
			outputText("There is nothing you can do for her. You leave her be, for now.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		public function meetingLunaRepatedYes():void {
			outputText("Now that you think about it, life at camp would be infinitely easier if you had a person like her helping. How about she come over to live with you at your camp? You walk to her and tell her that while you don’t own much, you would gladly take her.\n\n");
			outputText("The maid, now beggar, looks at you with tears in her eyes, as if snapping out of a bad dream, then stands up as she replies.\n\n");
			outputText("\"<i>You.. you would hire me? Even after I have been kicked out? Oh this is wonderful, thank you so much!!</i>\"\n\n");
			doNext(meetingLunaCamp);
		}
		public function meetingLunaCamp():void {
			outputText("The two of you head back to camp. The maid doesn’t comment on the fact you only have a cabin for a house");
			if (camp.companionsCount() > 2) outputText(", let alone the many people camping next to you");
			outputText(". In fact, she is practically overjoyed.\n\n");
			outputText("As the two of you reach the middle of the camp, you finally introduce yourself as [name] champion of Ingnam. She swiftly realises she hasn’t presented herself yet and does so with reverence.\n\n");
			outputText("\"<i>I’ve forgotten to introduce myself, please forgive me. My name is Luna. As you have probably figured out, I am a maid. Please allow me to call you " + player.mf("Master","Mistress") + " [name] from now on, I will serve you to the best of my abilities.</i>\"\n\n");
			outputText("(<b>Luna has been added to the Followers menu!</b>)\n\n");
			flags[kFLAGS.LUNA_FOLLOWER] = 4;
			flags[kFLAGS.LUNA_LVL_UP] = 0;
			flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function mainLunaMenu():void {
			clearOutput();
			outputText("You call out to Luna and the maid comes over as fast as she can.\n\n");
			outputText("\"<i>Good ");
			if (model.time.hours >= 6 && model.time.hours <= 11) outputText("morning");
			else if (model.time.hours <= 18) outputText("afternoon");
			else outputText("evening");
			outputText(" " + player.mf("Master","Mistress") + ". How can I be of assistance, if any? Just tell me what you may need.</i>\"\n\n");
			menu();
			addButton(0, "Appearance", LunaAppearance);
			addButton(1, "Talk", talkMenuLuna);
			if (flags[kFLAGS.LUNA_FOLLOWER] > 4) {
				addButton(3, "Meal", mealLuna);
				if (player.HP >= player.maxHP()) addButtonDisabled(4, "Nurse", "You are currently in perfect health.");
				else addButton(4, "Nurse", nurseLuna);
			}
			//addButton(5, "Sex", SidonieSexMenu);
			addButton(14, "Leave", camp.campFollowers);
		}
		
		public function LunaAppearance():void {
			clearOutput();
			if (flags[kFLAGS.LUNA_FOLLOWER] < 6) {
				outputText("Luna is a human maid. She wears the classic maid uniform and bonnet at all times. Her golden eyes always look to you, paying close attention, waiting for any potential orders. That said, her face is not bad to look at and she could pass for cute. Her ashen hair fits her perfectly.\n\n");
				outputText("Luna’s body looks average, with a modest C cup breast size and generally decent female proportions. Her thighs are about that which you would expect of an ordinary human woman. She wears a pair of tidy black shoes on her delicate feet.\n\n");
			}
			else {
				outputText("Luna is a werewolf. While she spends most of the day as a regular human maid, at night or when she is angry, she turns into a hybrid between human and beast. She normally wears the classic maid uniform and bonnet at all times but prefers to go naked, especially on full moon nights when she risks accidentally destroying her clothes. Her golden eyes ever look at you with attention, waiting for any potential order. ");
				outputText("You know better and can sometimes spot the flash of a green glow, which is the only warning of the beast within when she assumes human shape. That said, her face is not bad to look at and she could pass for cute, even when she flashes a pair of canines more fitting a wolf than a human or, even that panting tongue of hers. Her ashen hair fits her perfectly, and she makes sure to carefully brush it after a full moon. ");
				outputText("Her ears right now look human but migrate to the top of her head when she assumes beast form.\n\nMost of the time, Luna’s body looks about average with a modest C cup breast size and generally decent female proportion. However, on the night of a full moon, her body changes to a shape more befitting her tainted nature. With DD size breasts and an hourglass shape that would make any jaw drop. ");
				outputText("Her thighs are about the size that you’d expect of an ordinary human woman, at least when the moon isn’t full. She wears a pair of tidy black shoes on her delicate feet but removes them at night, so as to prevent them from exploding when her feet turn into clawed paws.\n\n");
			}
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function talkMenuLuna():void {
			clearOutput();
			outputText("You tell Luna you would like to discuss a few things with her.\n\n");
			outputText("\"<i>How may I be of help, " + player.mf("Master","Mistress") + "?</i>\"\n\n");
			menu();
			addButton(0, "Her", talkMenuLunaHer);
			addButton(1, "What", talkMenuLunaWhatCanSheDo).hint("Ask what she can do.");
			addButton(2, "Human", talkMenuLunaHuman);
			addButton(3, "Camp", talkMenuLunaCampThoughts);
			if (flags[kFLAGS.LUNA_FOLLOWER] > 5) addButton(4, "Lycanthropy", talkMenuLunaLycanthropy);
			else addButtonDisabled(4, "???", "You need to know her better for this.");
			addButton(14, "Back", mainLunaMenu);
		}
		public function talkMenuLunaHer():void {
			clearOutput();
			outputText("How long has she worked as a maid?\n\n");
			outputText("\"<i>Um... it’s  been a while. I recall I entered service at a very young age and changed from master to master several times. I don’t think that event at the magic shop counts, however.</i>\"\n\n");
			outputText("You don’t push the subject, deciding instead to ask her how it feels to be a maid?\n\n");
			outputText("\"<i>Wonderful, actually! I get a person I get to take care of in every possible way and I get tons of resources to do it. Ah, [name], that smile on my master’s face while eating a perfectly cooked meal, that relieved sigh you make when I ease your rest, that peaceful look in your face when you sleep...</i>\"\n\n");
			outputText("You are starting to ask yourself whether Luna is a maid, or a complete stalker, but then realise that all of this is also part of her job.");
			if (flags[kFLAGS.LUNA_FOLLOWER] > 5) outputText(" You did however spot a beastly green flash in her eyes as she spoke, so perhaps she is using her job as an excuse to stalk you after all.");
			lunaJealousy(-50);
			lunaAffection(1);
			doNext(talkMenuLuna);
		}
		public function talkMenuLunaWhatCanSheDo():void {
			clearOutput();
			outputText("Just what can she do for you, exactly? No one in Ingnam was rich enough to employ a maid, and you barely understand what the job exactly entails.\n\n");
			outputText("\"<i>Well, I am a maid. I do cleaning, cooking, nursing, and even a few side jobs you don’t want to think about, like washing the dishes and pest control. That said, if you ever need anything from me just ask.");
			if (flags[kFLAGS.LUNA_FOLLOWER] > 5) outputText(" Also, I...I suppose I wouldn’t mind relieving you of any “needs” you may have, that's also part of my job!");
			outputText("</i>\"\n\nWell, you will make sure to make proper use of her services.\n\n");
			if (flags[kFLAGS.LUNA_FOLLOWER] < 5) flags[kFLAGS.LUNA_FOLLOWER] = 5;
			lunaJealousy(-50);
			lunaAffection(1);
			doNext(talkMenuLuna);
		}
		public function talkMenuLunaHuman():void {
			clearOutput();
			if (flags[kFLAGS.LUNA_FOLLOWER] > 5) {
				outputText("She lied to you when she said she was human. Why?\n\n");
				outputText("\"<i>I used to be human. Or rather... well, it’s very complicated.</i>\"\n\n");
				outputText("You tell her to go on.\n\n");
				outputText("\"<i>I came from a different world, not unlike this one. After I landed in Mareth by accident while cleaning the shop, I had to survive in the wild. On one night, a werewolf, not unlike me, attacked me and turned me into the monster I am now. I suspect the original werewolves to be demonic creations engineered to spread this magical disease everywhere. ");
				outputText("I believe the demons intend to replace the various morphs and any remaining humans like me in Mareth with sex crazed animal hybrids.The disease isn’t limited to the form of a wolf either, as I know that there are werecats out there.</i>\"\n\n");
			}
			else {
				outputText("Are your eyes deceiving you, or is she truly a genuine human?\n\n");
				outputText("\"<i>Well, of course I’m human, I came from a different world. That said, it was an accident, I didn’t come here because I wanted to. See, I used to work cleaning things in a magic shop and accidentally triggered some arcane device that looked like a mirror, it sucked me in and next thing I knew I was in this dimension.</i>\"\n\n");
			}
			lunaJealousy(-50);
			lunaAffection(1);
			doNext(talkMenuLuna);
		}
		public function talkMenuLunaCampThoughts():void {
			clearOutput();
			outputText("What does she think of your camp?\n\n");
			if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10) outputText("\"<i>I can’t say your home is as big as the ones I’m used to dwelling in. Perhaps one day the good " + player.mf("master","mistress") + " will consider expanding it?</i>\"\n\n");
			else outputText("\"<i>By all means, you should build a proper house. It would be so much easier to clean.</i>\"\n\n");
			lunaJealousy(-50);
			lunaAffection(1);
			doNext(talkMenuLuna);
		}
		public function talkMenuLunaLycanthropy():void {
			clearOutput();
			outputText("So what's it exactly like to be a werewolf? Aside from it making you howl at the moon.\n\n");
			outputText("\"<i>Well, my hormonal system is totally messed up as the lunar cycle causes me to go into heat.The closer we lycanthropes get to the full moon, the hornier we get, until we all turn into sex crazed beasts willing to go so far as to rape innocent people for a good fuck. That said, sex is not all there is to it. We are all gifted with the ability to change form at will, and I know for a fact that we’re also faster, ");
			outputText("stronger, and sturdier than any normal morph or human. There is no known permanent cure to lycanthropy. The truth is that, while I could change into something different using transformatives, I think that so long as whatever I transform into is an animal I would still go mad during a full moon. Worse, my bite can turn about anyone into a lycanthrope the same as me.</i>\"\n\n");
			outputText("Guess she really is more than a cute pup.\n\n");
			lunaJealousy(-50);
			lunaAffection(1);
			doNext(talkMenuLuna);
		}
		
		public function mealLuna():void {
			clearOutput();
			outputText("You ask Luna if today's meal is ready.\n\n");
			if (flags[kFLAGS.LUNA_MEAL] == 1) {
				outputText("\"<i>I apologize for the inconvenience " + player.mf("master", "mistress") + ", I haven’t had the time to gather food and ingredients for a meal. Please ask again tomorrow.</i>\"\n\n");
				doNext(mainLunaMenu);
			}
			else {
				outputText("\"<i>Yes, " + player.mf("master","mistress") + ", I finished it just in time just for you. Would you like a cup of tea first?</i>\"\n\n");
				outputText("You nod and Luna comes back with your meal and drink. It is a mystery as to where and how she finds this food, but she uses her mess kit with such professionalism you can’t help but think many nobles in Tel’Adre don’t eat this well. Finishing your plate, you thank her for the meal, feeling satiated.\n\n");
				outputText("\"<i>It is my greatest pleasure to serve you a dish everyday, " + player.mf("master","mistress") + ".</i>\"\n\n");
				player.hunger = player.maxHunger();
				HPChange(Math.round(player.maxHP() * .1), true);
				player.mana += Math.round(player.maxMana() * 0.1);
				if (player.mana > player.maxMana()) player.mana = player.maxMana();
				EngineCore.changeFatigue(-(Math.round(player.maxFatigue() * 0.1)));
				flags[kFLAGS.LUNA_MEAL] = 1;
				lunaJealousy(-50);
				lunaAffection(1);
				doNext(camp.returnToCampUseOneHour);
			}
		}
		
		public function nurseLuna():void {
			clearOutput();
			outputText("You ask the maid if she could heal you.\n\n");
			outputText("\"<i>I will tend to your wounds at once.</i>\"\n\n");
			outputText("Luna casts a few healing spells on you to help your recovery. She traces your skin with her fingers, closing wounds wherever they pass. This treatment is highly effective, but leaves you somewhat aroused.");
			dynStats("lus", 33);
			lunaJealousy(-50);
			lunaAffection(1);
			HPChange(Math.round(player.maxHP() * .5), true);
			if (flags[kFLAGS.LUNA_FOLLOWER] > 5) {
				outputText(" Luna is giving a knowing smile, likely hoping you will jump at the opportunity, maybe she even did it on purpose. Do you take her here and now?\n\n");
				menu();
				//addButton(0, "Yes", );
				addButton(0, "No", nurseLunaEnd);
			}
			else doNext(camp.returnToCampUseFourHours);
		}
		public function nurseLunaEnd():void {
			outputText("You decide to leave her hanging. If she wants you to fuck her, she will have to do better than that. She’s a little frustrated by your lack of erotic response, but does not comment on it.");
			doNext(camp.returnToCampUseOneHour);
		}
		/*
		public function talkMenuLunaLycanthropy():void {
			clearOutput();
			outputText("WIP\n\n");
			outputText("\"<i>WIP</i>\"\n\n");
			doNext(talkMenuLuna);
		}
		
		public function talkMenuLunaLycanthropy():void {
			clearOutput();
			outputText("WIP\n\n");
			outputText("\"<i>WIP</i>\"\n\n");
			doNext(talkMenuLuna);
		}*/
	}
}