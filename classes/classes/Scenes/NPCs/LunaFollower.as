/**
 * ...
 * @author Liandri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.BodyParts.Antennae;
	import classes.BodyParts.Arms;
	import classes.BodyParts.Ears;
	import classes.BodyParts.Eyes;
	import classes.BodyParts.Face;
	import classes.BodyParts.Horns;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.RearBody;
	import classes.BodyParts.Skin;
	import classes.BodyParts.Tail;
	import classes.BodyParts.Tongue;
	import classes.BodyParts.Wings;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	import classes.Items.MutationsHelper;
	import classes.display.SpriteDb;
	
	public class LunaFollower extends NPCAwareContent
	{
		public var mutations:MutationsHelper = new MutationsHelper();
		
		public function LunaFollower() 
		{}
		//luna follower flag: 2 - kicked post moon event, 3 seen her dead in forest, 4,5 - pre full moon event, 6 jelly pre full moon, 7,8 - post moon unchained, 9,10 - post moon chained, 11,12 - unchained post moon accepted (PC no WW), 13,14 - unchained post moon accepted and talked about lycantrophy (PC no WW), 15,16 - unchained post moon accepted (PC WW)
		public function lunaAffection(changes:Number = 0):Number
		{
			flags[kFLAGS.LUNA_AFFECTION] += changes;
			if (flags[kFLAGS.LUNA_AFFECTION] > 100) flags[kFLAGS.LUNA_AFFECTION] = 100;
			return flags[kFLAGS.LUNA_AFFECTION];
		}
		public function lunaJealousy(changes:Number = 0):Number
		{
			flags[kFLAGS.LUNA_JEALOUSY] += changes;
			if (flags[kFLAGS.LUNA_JEALOUSY] > 400) flags[kFLAGS.LUNA_JEALOUSY] = 400;
			if (flags[kFLAGS.LUNA_JEALOUSY] < 0) flags[kFLAGS.LUNA_JEALOUSY] = 0;
			return flags[kFLAGS.LUNA_JEALOUSY];
		}
		
		public function mainLunaMenu():void {
			spriteSelect(SpriteDb.s_luna_maid);
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
			if (flags[kFLAGS.LUNA_AFFECTION] >= 50) {
				if (flags[kFLAGS.SLEEP_WITH] != "Luna") addButton(5, "Sleep With", lunaSleepToggle);
				else addButton(5, "Sleep Alone", lunaSleepToggle);
			}
			if (flags[kFLAGS.LUNA_FOLLOWER] > 10) {
				if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) addButton(2, "Spar", sparLuna);
				addButton(6, "Sex", sexMenuMain);
			}
			if (flags[kFLAGS.LUNA_FOLLOWER] == 9 || flags[kFLAGS.LUNA_FOLLOWER] == 10) addButton(7, "Unchain", lunaChainToggle).hint("Unchain Luna and see what happens.");
			if (flags[kFLAGS.LUNA_FOLLOWER] == 7 || flags[kFLAGS.LUNA_FOLLOWER] == 8) addButton(7, "Chain", lunaChainToggle).hint("Chain Luna.");
			addButton(14, "Leave", camp.campFollowers);
		}
		
		public function LunaAppearance():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			if (flags[kFLAGS.LUNA_FOLLOWER] < 7) {
				outputText("Luna is a human maid. She wears the classic maid uniform and bonnet at all times. Her golden eyes always look to you, paying close attention, waiting for any potential orders. That said, her face is not bad to look at and she could pass for cute. Her ashen hair fits her perfectly.\n\n");
				outputText("Luna’s body looks average, with a modest C cup breast size and generally decent female proportions. Her thighs are about that which you would expect of an ordinary human woman. She wears a pair of tidy black shoes on her delicate feet.\n\n");
			}
			else {
				outputText("Luna is a werewolf. While she spends most of the day as a regular human maid, at night or when she’s angry, she turns into a hybrid between human and beast. She normally wears the classic maid uniform and bonnet at all times but prefers to go naked, especially on full moon nights when she risks accidentally destroying her clothes. Her golden eyes ever look at you with attention, waiting for any potential order. ");
				outputText("You know better and can sometimes spot the flash of a green glow, which is the only warning of the beast within when she assumes human shape. That said, her face is not bad to look at and she could pass for cute, even when she flashes a pair of canines more fitting a wolf than a human or, even that panting tongue of hers. Her ashen hair fits her perfectly, and she makes sure to carefully brush it after a full moon. ");
				outputText("Her ears right now look human but migrate to the top of her head when she assumes beast form.\n\nMost of the time, Luna’s body looks about average with a modest C cup breast size and generally decent female proportions. However, on the night of a full moon, her body changes to a shape more befitting her tainted nature. With DD size breasts and an hourglass shape that would make any jaw drop. ");
				outputText("Her thighs are about the size that you’d expect of an ordinary human woman, at least when the moon isn’t full. She wears a pair of tidy black shoes on her delicate feet but removes them at night, so as to prevent them from exploding when her feet turn into clawed paws.\n\n");
			}
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function talkMenuLuna():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You tell Luna you would like to discuss a few things with her.\n\n");
			outputText("\"<i>How may I be of help, " + player.mf("Master","Mistress") + "?</i>\"\n\n");
			menu();
			addButton(0, "Her", talkMenuLunaHer);
			addButton(1, "What", talkMenuLunaWhatCanSheDo).hint("Ask what she can do.");
			addButton(2, "Human", talkMenuLunaHuman);
			addButton(3, "Camp", talkMenuLunaCampThoughts);
			if (flags[kFLAGS.LUNA_FOLLOWER] > 6) addButton(4, "Lycanthropy", talkMenuLunaLycanthropy);
			else addButtonDisabled(4, "???", "You need to know her better for this.");
			if ((flags[kFLAGS.LUNA_FOLLOWER] == 13 || flags[kFLAGS.LUNA_FOLLOWER] == 14) && (!player.hasPerk(PerkLib.Lycanthropy) || !player.hasPerk(PerkLib.LycanthropyDormant))) addButton(9, "Bite Me", talkMenuBiteMe);
			addButton(14, "Back", mainLunaMenu);
		}
		public function talkMenuLunaHer():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("How long has she worked as a maid?\n\n");
			outputText("\"<i>Um... it’s  been a while. I recall entering the service at a very young age and bounced from master to master several times. I don’t think that event at the magic shop counts, however.</i>\"\n\n");
			outputText("You don’t push the subject, deciding instead to ask her how it feels to be a maid?\n\n");
			outputText("\"<i>Wonderful actually! I get a person I get to take care of in every possible way and I get tons of resources to do it. Ah, [name], that smile on my master’s face while eating a perfectly cooked meal, that relieved sigh you make when I ease your rest, that peaceful look in your face when you sleep...</i>\"\n\n");
			outputText("You are starting to ask yourself whether Luna is a maid, or a complete stalker, but then realise that all of this is also part of her job.");
			if (flags[kFLAGS.LUNA_FOLLOWER] > 6) outputText(" You did however spot a beastly green flash in her eyes as she spoke, so perhaps she is using her job as an excuse to stalk you after all.");
			lunaJealousy(-100);
			lunaAffection(2);
			doNext(camp.returnToCampUseOneHour);
		}
		public function talkMenuLunaWhatCanSheDo():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("Just what can she do for you, exactly? No one in Ingnam was rich enough to employ a maid, and you barely understand what the job exactly entails.\n\n");
			outputText("\"<i>Well, I am a maid. I do cleaning, cooking, nursing, and even a few side jobs you don’t want to think about, like washing the dishes and pest control. That said, if you ever need anything from me just ask.");
			if (flags[kFLAGS.LUNA_FOLLOWER] > 6) outputText(" Also, I...I suppose I wouldn’t mind relieving you of any “needs” you may have, that's also part of my job!");
			outputText("</i>\"\n\nWell, you will make sure to make proper use of her services.\n\n");
			if (flags[kFLAGS.LUNA_FOLLOWER] < 5) flags[kFLAGS.LUNA_FOLLOWER] = 5;
			lunaJealousy(-100);
			lunaAffection(2);
			doNext(camp.returnToCampUseOneHour);
		}
		public function talkMenuLunaHuman():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			if (flags[kFLAGS.LUNA_FOLLOWER] > 6) {
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
			lunaJealousy(-100);
			lunaAffection(2);
			doNext(camp.returnToCampUseOneHour);
		}
		public function talkMenuLunaCampThoughts():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("What does she think of your camp?\n\n");
			if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 10) outputText("\"<i>I can’t say your home is as big as the ones I’m used to dwelling in. Perhaps one day the good " + player.mf("master","mistress") + " will consider expanding it?</i>\"\n\n");
			else outputText("\"<i>By all means, you should build a proper house. It would be so much easier to clean.</i>\"\n\n");
			lunaJealousy(-100);
			lunaAffection(2);
			doNext(camp.returnToCampUseOneHour);
		}
		public function talkMenuLunaLycanthropy():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("So what's it exactly like to be a werewolf? Aside from it making you howl at the moon.\n\n");
			outputText("\"<i>Well, my hormonal system is totally messed up as the lunar cycle causes me to go into heat.The closer we lycanthropes get to the full moon, the hornier we get, until we all turn into sex crazed beasts willing to go so far as to rape innocent people for a good fuck. That said, sex is not all there is to it. We are all gifted with the ability to change form at will, and I know for a fact that we’re also faster, ");
			outputText("stronger, and sturdier than any normal morph or human. There is no known permanent cure to lycanthropy. The truth is that, while I could change into something different using transformatives, I think that so long as whatever I transform into is an animal I would still go mad during a full moon. Even worse, my bite can turn about anyone into a lycanthrope the same as me.</i>\"\n\n");
			outputText("Guess she really is more than just a cute pup.\n\n");
			if (flags[kFLAGS.LUNA_FOLLOWER] == 11) flags[kFLAGS.LUNA_FOLLOWER] = 13;
			else flags[kFLAGS.LUNA_FOLLOWER] = 14;
			lunaJealousy(-100);
			lunaAffection(2);
			doNext(camp.returnToCampUseOneHour);
		}
		public function talkMenuBiteMe():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("It occurs to you that you could gain the same kind of powers as Luna if you asked her. That said, is that what you truly want?\n\n");
			menu();
			addButton(0, "Yes", talkMenuBiteMeYes);
			addButton(1, "No", talkMenuLuna);
		}
		public function talkMenuBiteMeYes():void {
			outputText("You ask Luna the one thing she likely never expected, would she mind biting you? Luna almost panics the moment you request it, though she also blushes.\n\n");
			outputText("\"<i>" + player.mf("Master","Mistress") + " I...This is a very important choice you are making here, did you truly think it through? I mean once you are cursed there's no removing it, you will truly be just like me.</i>\"\n\n");
			outputText("You don’t mind it, truthfully if this can tie the both of you together better, you will do it all the more. Luna nods and undresses as she changes shape. You hold your arm before her and she lose all form of restraint biting you with just the required strength to draw blood. At first it hurts like crazy but then the pain recedes, replaced with spreading pleasure as the wounds begin to throb. ");
			outputText("Your" + (player.hasCock() ? " [cock] goes fully erect" : "") + "" + (player.gender == 3 ? " and your" : "") + "" + (player.hasVagina() ? " pussy starts moistening" : "") + " from this weird feeling, something's not right.\n\n");
			outputText("" + (player.humanScore() < 30 ? "Your body starts changing, and to your surprise, its features warp back to their former human features. You begin to think she may have purged you of the transformations that afflicted you, but that's not exactly it. " : "") + "Heat begins to spread from your wound and you start panting, trying to vent out the pleasure and the hot feeling in your body as something fundamental about you changes.\n\n");
			outputText("Fur begins to grow on various point of your body, namely your arms and legs. Your nails sharpen and curve, turning into a full set of claws as your hands and feet reshape into 5 digit paws. You groan in pleasure, revealing your forming canines as your spine extends into a furry tail while your ears migrate to the top of your head, covering in fur and changing into triangular points like those of a wolf. You pant in pleasure at the change, revealing a moist dog like tongue");
			if (player.hasCock()) outputText(" as you feel a tightness near the base of your cock where your skin seems to be bunching up. A canine-looking sheath begins forming around your cock’s base, tightening and pulling your penis inside its depths. A hot feeling envelops your member as it surges out and starts throbbing, the crown now a point. The sensations are too much for you.  You throw back your head and howl as the transformation completes, your pointed shaft erupting with intense force");
			outputText(".\n\n");
			player.lowerBody = LowerBody.WOLF;
			if (player.legCount != 2) player.legCount = 2;
			player.tailType = Tail.WOLF;
			if (player.tailCount != 1) player.tailCount = 1;
			player.rearBody.type = RearBody.WOLF_COLLAR;
			player.arms.type = Arms.WOLF;
			player.faceType = Face.WOLF_FANGS;
			player.ears.type = Ears.WOLF;
			player.eyes.type = Eyes.FERAL;
			player.tongue.type = Tongue.DOG;
			player.wings.type = Wings.NONE;
			player.antennae.type = Antennae.NONE;
			player.horns.type = Horns.NONE;
			player.skin.growCoat(Skin.FUR, {color:player.hairColor}, Skin.COVERAGE_LOW);
			if (player.hasCock() && player.wolfCocks() < 1) {
				var selectedCockValue:int = -1;
				for (var indexI:int = 0; indexI < player.cocks.length; indexI++)
				{
					if (player.cocks[indexI].cockType != CockTypesEnum.WOLF)
					{
						selectedCockValue = indexI;
						break;
					}
				}
				if (selectedCockValue != -1) {
					player.cocks[selectedCockValue].cockType = CockTypesEnum.WOLF;
					player.cocks[selectedCockValue].knotMultiplier = 1.1;
					player.cocks[selectedCockValue].thickenCock(2);
				}
			}
			var bonusStats:Number = 0;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3 || flags[kFLAGS.LUNA_MOON_CYCLE] == 5) bonusStats += 10;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2 || flags[kFLAGS.LUNA_MOON_CYCLE] == 6) bonusStats += 20;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1 || flags[kFLAGS.LUNA_MOON_CYCLE] == 7) bonusStats += 30;
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) bonusStats += 40;
			player.createPerk(PerkLib.Lycanthropy,bonusStats,0,0,0);
			player.dynStats("str", (bonusStats * (player.newGamePlusMod() + 1)), "tou", (bonusStats * (player.newGamePlusMod() + 1)), "spe", (bonusStats * (player.newGamePlusMod() + 1)), "cor", 20);
			statScreenRefresh();
			outputText("Barely satiated your eyes now focus back on Luna, lust overwhelming your cursed body. You must have her... NOW!\n\n");
			doNext(sexMenuDominateHer);
		}
		
		public function sparLuna():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You ask Luna if she wouldn’t mind sparring with you.\n\n");
			outputText("\"<i>" + player.mf("Master", "Mistress") + ", we both know it is best not to awaken my instincts during the day. I am a pitiful woman.</i>\"\n\n");
			outputText("Well it's exactly because she is both strong and dangerous that you need her help to become so yourself.\n\n");
			outputText("\"<i>If this is the " + player.mf("Master's", "Mistress'") + " wish, I will comply.</i>\"\n\n");
			outputText("You both head to the ring and get ready for a brawl. She removes her dress and gets stark naked before you " + (camp.companionsCount() >= 2 ? "to the consternation of everyone who’s looking, " : "") + "before starting to pant as she changes shape. You recognise the green glow of crazed desire in her eyes now and almost regret your choice. Losing to her will likely result into you both having sex whether you like it or not.\n\n");
			startCombat(new Luna());
		}
		public function sparLunaWon():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("Luna sit down like a good well behaved dog to admit defeat.\n\n");
			outputText("\"<i>I yield " + player.mf("Master", "Mistress") + ". You win this one. I hope this warm up was worth your time.</i>\"\n\n");
			outputText("You thank Luna for helping you with your training and give her freedom to resume duty which she gladly do.\n\n");
			if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2) {
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] >= 1) flags[kFLAGS.LUNA_DEFEATS_COUNTER]++;
				else flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 1;
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 2 && flags[kFLAGS.LUNA_LVL_UP] == 0) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 12);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 12, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 1;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 3 && flags[kFLAGS.LUNA_LVL_UP] == 1) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 18);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 18, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 2;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 4 && flags[kFLAGS.LUNA_LVL_UP] == 2) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 24);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 24, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 3;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 5 && flags[kFLAGS.LUNA_LVL_UP] == 3) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 30);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 30, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 4;
				}
				if (flags[kFLAGS.LUNA_DEFEATS_COUNTER] == 6 && flags[kFLAGS.LUNA_LVL_UP] == 4) {
					if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers3)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers3, 1, 36);
					else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers3, 36, 0, 0, 0);
					flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
					flags[kFLAGS.LUNA_LVL_UP] = 5;
				}
			}
			cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}
		public function sparLunaLost():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("Luna pounces on you with a hungry growl. Guess you had it coming when you asked her to spar you.\n\n");
			outputText("\"<i>You lost " + player.mf("Master", "Mistress") + ", therefore I’m entitled to do whatever I want with you. Well I don’t care what it is as long as we do it now.</i>\"\n\n");
			monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
			cleanupAfterCombat();
			doNext(sexMenuDominateHer);
		}
		
		public function mealLuna():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You ask Luna if today's meal is ready.\n\n");
			if (flags[kFLAGS.LUNA_MEAL] == 1) {
				outputText("\"<i>I apologize for the inconvenience " + player.mf("master", "mistress") + ", I haven’t had the time to gather food and ingredients for a meal. Please ask again tomorrow.</i>\"\n\n");
				doNext(mainLunaMenu);
			}
			else {
				outputText("\"<i>Yes, " + player.mf("Master","Mistress") + ", I finished it just in time, just for you. Would you like a cup of tea first?</i>\"\n\n");
				outputText("You nod and Luna comes back with your meal and drink. It is a mystery as to where and how she finds this food, but she uses her mess kit with such professionalism you can’t help but think many nobles in Tel’Adre don’t eat this well. Finishing your plate, you thank her for the meal, feeling satiated.\n\n");
				outputText("\"<i>It is my greatest pleasure to serve you a dish everyday, " + player.mf("master","mistress") + ".</i>\"\n\n");
				player.hunger = player.maxHunger();
				HPChange(Math.round(player.maxHP() * .1), true);
				player.mana += Math.round(player.maxMana() * 0.1);
				if (player.mana > player.maxMana()) player.mana = player.maxMana();
				EngineCore.changeFatigue(-(Math.round(player.maxFatigue() * 0.1)));
				flags[kFLAGS.LUNA_MEAL] = 1;
				lunaJealousy(-100);
				lunaAffection(10);
				doNext(camp.returnToCampUseOneHour);
			}
		}
		
		public function nurseLuna():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You ask the maid if she could heal you.\n\n");
			outputText("\"<i>I will tend to your wounds at once.</i>\"\n\n");
			outputText("Luna casts a few healing spells on you to help your recovery. She traces your skin with her fingers, closing wounds wherever they pass. This treatment is highly effective, but leaves you somewhat aroused.\n\n");
			dynStats("lus", 33);
			lunaJealousy(-100);
			lunaAffection(5);
			HPChange(Math.round(player.maxHP() * .5), true);
			if (flags[kFLAGS.LUNA_FOLLOWER] > 10) {
				outputText("\nLuna is giving a knowing smile, likely hoping you will jump at the opportunity, maybe she even did it on purpose. Do you take her here and now?\n\n");
				menu();
				addButton(0, "Yes", sexMenuMain);
				addButton(1, "No", nurseLunaEnd);
			}
			else doNext(camp.returnToCampUseFourHours);
		}
		public function nurseLunaEnd():void {
			outputText("You decide to leave her hanging. If she wants you to fuck her, she will have to do better than that. She’s a little frustrated by your lack of an erotic response, but does not comment on it.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function lunaSleepToggle():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			if(flags[kFLAGS.SLEEP_WITH] != "Luna") {
				outputText("You ask Luna if she would mind sleeping with you.\n\n");
				outputText("\"<i>Not at all " + player.mf("Master","Mistress") + " [name]. It would be my greatest pleasure to safeguard your dreams.</i>\"\n\n");
				flags[kFLAGS.SLEEP_WITH] = "Luna";
			}
			else {
				outputText("You tell Luna you need some time on your own for various reasons.\n\n");
				outputText("\"<i>As you wish " + player.mf("Master","Mistress") + "... just tell me when you want me close to you. You know I’m happy to always safeguard your dreams to the best of my ability.</i>\"\n\n");
				flags[kFLAGS.SLEEP_WITH] = "";
			}
			menu();
			addButton(0,"Next", mainLunaMenu);
		}
		private function sleepWith(arg:String = ""):void {
			flags[kFLAGS.SLEEP_WITH] = arg;
		}
		private function lunaChainToggle():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			if (flags[kFLAGS.LUNA_FOLLOWER] == 9 || flags[kFLAGS.LUNA_FOLLOWER] == 10) {
				outputText("Luna is currently free to roam at night.\n\n");
				if (flags[kFLAGS.LUNA_FOLLOWER] == 9) flags[kFLAGS.LUNA_FOLLOWER] = 7;
				if (flags[kFLAGS.LUNA_FOLLOWER] == 10) flags[kFLAGS.LUNA_FOLLOWER] = 8;
			}
			else {
				outputText("Luna is chained before every full moon night as a safety measure.\n\n");
				if (flags[kFLAGS.LUNA_FOLLOWER] == 7) flags[kFLAGS.LUNA_FOLLOWER] = 9;
				if (flags[kFLAGS.LUNA_FOLLOWER] == 8) flags[kFLAGS.LUNA_FOLLOWER] = 10;
			}
			menu();
			addButton(0,"Next", mainLunaMenu);
		}
		public function sleepingFullMoon():void {
			outputText("You would close your eyes, but you know Luna has other plans tonight, you can spot the telltale green glow in her eyes announcing an impending full moon and she smirks knowingly. Yep, you ain't going to bed without some sex first as Luna intends to bang you one way or another. Without much surprise, her already naked form indeed takes on a beastial shape. She sits in a waiting position, reminiscent of a good dog waiting on its treat.\n\n");
			outputText("\"<i>Well " + player.mf("Master","Mistress") + ", you already know my mood, so let's get wild ok?</i>\"\n\n");
			flags[kFLAGS.LUNA_MOONING] = 2;
			menu();
			addButton(0, "Dominate", sexMenuDominateHer);
		}
		
		public function warrningAboutJelously():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			if (flags[kFLAGS.LUNA_FOLLOWER] == 5) flags[kFLAGS.LUNA_FOLLOWER] = 6;
			else if (flags[kFLAGS.LUNA_FOLLOWER] == 7) flags[kFLAGS.LUNA_FOLLOWER] = 8;
			else if (flags[kFLAGS.LUNA_FOLLOWER] == 9) flags[kFLAGS.LUNA_FOLLOWER] = 10;
			else if (flags[kFLAGS.LUNA_FOLLOWER] == 11) flags[kFLAGS.LUNA_FOLLOWER] = 12;
			else if (flags[kFLAGS.LUNA_FOLLOWER] == 13) flags[kFLAGS.LUNA_FOLLOWER] = 14;
			else flags[kFLAGS.LUNA_FOLLOWER] = 16;
			outputText("Luna come over to you.\n\n");
			outputText("\"<i>" + player.mf("Master","Mistress") + " you haven’t been using my services in some time. I came to remind you that should you need anything, and by that I truly mean anything you desire, all you need to do is call me. It is always my greatest pleasure to serve you.</i>\"\n\n");
			outputText("She walk away to prepare today's food and clean which reminds you that you indeed hadn’t had her food in a while.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function fullMoonEvent():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			if (flags[kFLAGS.LUNA_FOLLOWER] == 7 || flags[kFLAGS.LUNA_FOLLOWER] == 8) {
				outputText("Luna is smirking, a green glint in her eyes.\n\n");
				outputText("\"<i>Sorry [name] I can’t hold myself anymore.</i>\"\n\n");
				outputText("Oh no it's happening again! Luna is totally going to jump you, you can already see her beginning to transform as she prepare to make a second attempt.\n\n");
			}
			else {
				outputText("You are woken up by something forcefully pinning you down. What you see takes you entirely by surprise. Luna is standing over you, staring at you like some kind of predator.\n\n");
				outputText("\"<i>I can’t hold it anymore, " + player.mf("Master","Mistress") + ". I tried to but the things you do to me... the things I wish you would do to me... it's been intolerable. It's all your fault, after all you pushed me to do this.</i>\"\n\n");
				outputText("What the hell is she talking about, you’ve done nothing of the sort.\n\n");
				outputText("\"<i>Oh, but yes you did. Every time you made me cook a meal, every time I healed your wounds my desire for you grew, yet you wouldn’t use me fully... is my body not to your liking, " + player.mf("Master","Mistress") + "? Don’t worry, now that the moon is at its peak I’m finally ready, ready to make you realise how much you love me. You can’t deny us anymore, [name]!</i>\"\n\n");
				outputText("A green flash appears in her brown eyes as they turn increasingly bestial. Her naked body shivers as fur begins to cover it, her hands and feet turn into paws her irises glow fluorescent green. Fur swiftly cover her arms up to a little under the shoulders and her legs up to the tight. The transformation ends with a bushy tail and a pair of animal ears at the top of her head. ");
				outputText("She pants in delight at the pleasure of the change, revealing a dog like tongue and canines way too long and sharp to belong on any humans. Just what is she!?\n\n");
				outputText("\"<i>See? I’m a werewolf, [name]. A fiend created by demonic magic that changes between hybrid and human shape at will. This is the second reason my former master fired me for. I’m a monster. At first I tried to hide it, for your sake, but you’ve been teasing me for so long now I can’t hold it in anymore, especially with the coming full moon.</i>\"\n\n");
				outputText("This is quickly going to get out of hand. How will you answer to her advances?\n\n");
			}
			menu();
			addButton(0, "Accept", fullMoonEventAccept);
			if (player.dogScore() > 5 || player.wolfScore() > 5) addButtonDisabled(1, "Resist", "Your canine instincts kicks in, there is no way you can resist her advances.");
			else addButton(1, "Resist", fullMoonEventResist);
		}
		public function fullMoonEventAccept():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You declare that you won’t fight her.\n\n");
			outputText("\"<i>Wait, what? You.. you're just going to give in? Like this?</i>\"\n\n");
			outputText("Well of course. Had she made her needs clear in the first place you would have helped her with them. There was no need for her to hide her desires. That aside, you already thought of her as more than just a maid. You just didn’t know how to tell her. You don’t care if she thinks she is a monster. From your point of view, even in this form she remains cute. To her utter surprise you");
			if (!player.isNaked()) outputText(" get rid of your own clothes and");
			outputText(" display your naked body, telling her she will get exactly what she wants.\n\n");
			if (flags[kFLAGS.LUNA_FOLLOWER] == 5 || flags[kFLAGS.LUNA_FOLLOWER] == 7 || flags[kFLAGS.LUNA_FOLLOWER] == 9) flags[kFLAGS.LUNA_FOLLOWER] = 11;
			if (flags[kFLAGS.LUNA_FOLLOWER] == 6 || flags[kFLAGS.LUNA_FOLLOWER] == 8 || flags[kFLAGS.LUNA_FOLLOWER] == 10) flags[kFLAGS.LUNA_FOLLOWER] = 12;
			flags[kFLAGS.LUNA_MOONING] = 2;
			doNext(sexMenuVaginal);
		}
		public function fullMoonEventResist():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You shove her with all your strength and get ready for a fight.\n\n");
			outputText("\"<i>I knew you would need some convincing but it's all right, [name], I’m more than glad to help you with that.</i>\"\n\n");
			outputText("She growls as she falls on all fours, her wolf tail trailing on the ground and her ears flattening on her head. There's nothing left of your cute maid here, just a feral beast ready to tear you to shreds, and with those sharp claws and fangs it's clearly something she’s more than able to do.\n\n");
			outputText("\"<i>I will help you see my point of view once I’ve made sure you're no longer in any state to fight back. Once again it's all your fault if you end up getting hurt.</i>\"\n\n");
			startCombat(new Luna());
			doNext(playerMenu);
		}
		public function fullMoonEventResistWin():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("Luna falls to the ground in defeat. You swiftly proceed to tie her up so she does not cause further mayhem.\n\n");
			outputText("\"<i>" + player.mf("Master","Mistress") + "... I am so sorry...on these nights I have no control over myself. Please do not fire me.</i>\"\n\n");
			outputText("Apologies will come later for now you need to neutralize her for the night. To your surprise you conveniently find two large chain and manacles in her belongings and swiftly apply them to her to prevent her from harming you or anyone else. Finally sure that she won’t cause more trouble you sit next to her and discuss her future. You could indeed fire her, but she's been so nice and useful during the day, you are sure you would regret doing so. ");
			outputText("On the other hand you could keep her but make sure she is chained at night. What will you do? All choices considered, however, all she truly ever wanted was to have sex with you, perhaps if you voiced your accord this entire issue would be solved.\n\n");
			monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
			cleanupAfterCombat();
			menu();
			addButton(0, "Fire Her", fullMoonEventResistWinFireHer);
			addButton(1, "Accept", fullMoonEventAccept);
			addButton(2, "Chain Her", fullMoonEventResistWinChainHer);
		}
		public function fullMoonEventResistWinFireHer():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("Luna looks at you as if her world is breaking apart.\n\n");
			outputText("\"<i>[name], y..you’re firing me?</i>\"\n\n");
			outputText("You have been clear, she should scram now. Luna looks at you for a split second before running off in the woods. You have a bad feeling about this.\n\n");
			flags[kFLAGS.LUNA_FOLLOWER] = 2;
			flags[kFLAGS.LUNA_MOONING] = 1;
			if (model.time.hours >= 21) CoC.instance.timeQ = 24 - model.time.hours;
			else CoC.instance.timeQ = 0;
			CoC.instance.timeQ += 6;
			doNext(camp.sleepWrapper);
		}
		public function fullMoonEventResistWinFireHerForest():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("As you explore the forest you come upon a gruesome sight. You thought Luna would've made it back to Tel’Adre but it seems that she didn’t. She’s right there in front of you… hanging from a rope tied to a tree. That she'd fall into such despair didn’t occur to you when you kicked her out of your camp. You leave the gruesome scene, still shaken by her lifeless expression. You can’t help but think deep down, that this was all your fault.\n\n");
			flags[kFLAGS.LUNA_FOLLOWER] = 3;
			doNext(camp.returnToCampUseOneHour);
		}
		public function fullMoonEventResistWinChainHer():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You resolve to chain her to a tree every full moon from now on, though you suspect it'll be hard on her.\n\n");
			flags[kFLAGS.LUNA_FOLLOWER] = 9;
			flags[kFLAGS.LUNA_MOONING] = 1;
			if (model.time.hours >= 21) CoC.instance.timeQ = 24 - model.time.hours;
			else CoC.instance.timeQ = 0;
			CoC.instance.timeQ += 6;
			doNext(camp.sleepWrapper);
		}
		public function fullMoonEventResistDefeat():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You are too weak to keep fighting and Luna senses it. Before you can react she pounces on you. You’re back to the position you were in earlier and this time you are in no way capable of putting up a fight.\n\n");
			outputText("\"<i>It's ok, [name], the pain will only last for a few seconds and then...</i>\"\n\n");
			outputText("Before you can ask her what she means by that she lunges and bites right into your shoulder. At first it hurts like crazy but then the pain recedes, replaced with spreading pleasure as the wounds begin to throb. Your" + (player.hasCock() ? " [cock] goes fully erect" : "") + "" + (player.gender == 3 ? " and your" : "") + "" + (player.hasVagina() ? " pussy starts moistening" : "") + " from this weird feeling, something's not right.\n\n");
			outputText("" + (player.humanScore() < 30 ? "Your body starts changing, and to your surprise, its features warp back to their former human features. You begin to think she may have purged you of the transformations that afflicted you, but that's not exactly it. " : "") + "Heat begins to spread from your wound and you start panting, trying to vent out the pleasure and the hot feeling in your body as something fundamental about you changes.\n\n");
			outputText("Fur begins to grow on various point of your body, namely your arms and legs. Your nails sharpen and curve, turning into a full set of claws as your hands and feet reshape into 5 digit paws. You groan in pleasure, revealing your forming canines as your spine extends into a furry tail while your ears migrate to the top of your head, covering in fur and changing into triangular points like those of a wolf. You pant in pleasure at the change, revealing a moist dog like tongue");
			if (player.hasCock()) outputText(" as you feel a tightness near the base of your cock where your skin seems to be bunching up. A canine-looking sheath begins forming around your cock’s base, tightening and pulling your penis inside its depths. A hot feeling envelops your member as it surges out and starts throbbing, the crown now a point. The sensations are too much for you.  You throw back your head and howl to the moon as the transformation completes, your pointed shaft erupting with intense force");
			outputText(".\n\n");
			player.lowerBody = LowerBody.WOLF;
			if (player.legCount != 2) player.legCount = 2;
			player.tailType = Tail.WOLF;
			if (player.tailCount != 1) player.tailCount = 1;
			player.rearBody.type = RearBody.WOLF_COLLAR;
			player.arms.type = Arms.WOLF;
			player.faceType = Face.WOLF_FANGS;
			player.ears.type = Ears.WOLF;
			player.eyes.type = Eyes.FERAL;
			player.tongue.type = Tongue.DOG;
			player.wings.type = Wings.NONE;
			player.antennae.type = Antennae.NONE;
			player.horns.type = Horns.NONE;
			player.skin.growCoat(Skin.FUR, {color:player.hairColor}, Skin.COVERAGE_LOW);
			if (player.hasCock() && player.wolfCocks() < 1) {
				var selectedCockValue:int = -1;
				for (var indexI:int = 0; indexI < player.cocks.length; indexI++)
				{
					if (player.cocks[indexI].cockType != CockTypesEnum.WOLF)
					{
						selectedCockValue = indexI;
						break;
					}
				}
				if (selectedCockValue != -1) {
					player.cocks[selectedCockValue].cockType = CockTypesEnum.WOLF;
					player.cocks[selectedCockValue].knotMultiplier = 1.1;
					player.cocks[selectedCockValue].thickenCock(2);
				}
			}
			player.createPerk(PerkLib.Lycanthropy,40,0,0,0);
			player.dynStats("str", (40 * (player.newGamePlusMod() + 1)), "tou", (40 * (player.newGamePlusMod() + 1)), "spe", (40 * (player.newGamePlusMod() + 1)), "cor", 20);
			statScreenRefresh();
			outputText("Barely satiated your eyes now focus back on Luna, lust overwhelming your cursed body. You must have her... NOW!\n\n");
			monster.createPerk(PerkLib.NoGemsLost, 0, 0, 0, 0);
			cleanupAfterCombat();
			doNext(sexMenuDominateHer);
		}
		
		public function sexMenuMain():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You feel really hot right now and mention it to Luna, who blushes.\n\n");
			outputText("\"<i>I...It would be my pride to attend to your needs... Any needs you may have, " + player.mf("Master","Mistress") + ". What would you wish of me?</i>\"\n\n");
			menu();
			if (player.lust > 33 && player.gender > 0) {
				addButton(0, "Vaginal", sexMenuVaginalIntro);
				addButton(4, "DominateHer", sexMenuDominateHerIntro);
				if (player.hasCock()) {
					addButton(1, "Spear P.", sexMenuSpearPolishing);
					if (player.cockArea(player.biggestCockIndex()) > 15) addButton(2, "Boobjob", sexMenuBoobjob);
					addButton(3, "Doggy T.", sexMenuDoggyTreats);
					if (flags[kFLAGS.AYANE_FOLLOWER] >= 2 && flags[kFLAGS.LUNA_AFFECTION] == 100) addButton(6, "Sandwich", sexMenuSandwichWithAyane);
					else addButtonDisabled(6, "???", "Req. Ayane in camp and 100 affection.");
				}
			}
			if (player.cor >= 30) addButton(10, "Headpat", sexMenuHeadpat);
			else addButtonDisabled(10, "Headpat", "You're too pure for that!");
			addButton(14, "Back", mainLunaMenu);
		}
		public function sexMenuHeadpat():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("Luna is so cute, you can’t help yourself from patting her head! At first she's surprised but, soon after, she closes her eyes in delight as her ears take on their wolfish appearance. Her tail pops out and wags from side to side as she sighs in happiness. She realises only a few second later that she’s transforming and swiftly puts an end to it, masking her animalistic features.\n\n");
			outputText("\"<i>Uhhhh, sorry, " + player.mf("master","mistress") + ". I don’t know what took hold of me.</i>\"\n\n");
			outputText("She walks away, her tail still wagging, and you warn her about it. She swiftly hides it and runs off to do her chores.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		public function sexMenuVaginalIntro():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("Your body aches from your time out adventuring. It seems your constant expeditions have taken a toll on you,  unable to even bring yourself to a full smile in the presence of your devoted maid and instead settle for a small one. Your body language worries Luna and she rushes to your side, placing a hand on your chest and looking deeply into your eyes.\n\n");
			outputText("\"<i>" + player.mf("Master","Mistress") + ", are you well? Have you been injured while on your journeys?</i>\"\n\n");
			outputText("You assure her you’re fine, just a little tired and stressed. You’ve been fighting with the less than hospitable denizens of Mareth for so long now you’ve forgotten to take proper care of yourself it seems. The enemies you’ve faced have also taken a toll on your... self control, shall we say, and while you’ve resisted the urge to fall to your baser needs, it’s as if the land itself is acting against you in this regard. It’s fine, though. You just need to rest a while and you’ll be back in fighting conditi-\n\n");
			outputText("The sudden lip lock initiated by Luna comes as a shock to you, your natural reaction being to push her away before stopping yourself and choosing instead to fall deeper into the kiss. Her sweet tongue breaks through your lips and intertwines with yours, and you lose yourself to her expert ministrations as her tongue gently dances with yours. Time practically stops in lieu of the kiss, the feelings of love and affection translated through the embrace is so overpowering you almost lose your sense of balance as your knees buckle under you, and you fall into Luna’s loving embrace.\n\n");
			outputText("Kiss broken, ");
			if (player.cor < 50) outputText("you move your lips to apologize but a single finger is placed on your lips, halting your apology.");
			else outputText("you ready some dirty talk but a single finger is placed on your lips, halting your sentence.");
			outputText("\n\n\"<i>Shhh, " + player.mf("Master","Mistress") + ". There is no need to say anything. You’re incredibly stressed and tense, I can see it. Please, allow me to take care of you and your needs.</i>\"\n\n");
			outputText("After a moment of contemplation you nod to Luna, feeling slightly guilty that you’re burdening another with your stress but you quickly dismiss those negative thoughts, reminding yourself that she’s your maid and even wants to help you relieve this tension. ");
			if (!player.isNaked()) {
				outputText("Softly laying you down, Luna proceeds to remove your [armor] piece by piece and places them off to the side");
				if (player.weaponName != "fists") outputText(" along with your [weapon]");
				outputText(". ");
			}
			outputText("She then moves onto her own clothing, stripping away her finely woven outfit and revealing her supple body for your pleasure. You happily drink in the sight of such beauty, those captivating golden eyes, perfectly sized lips gracing her beautiful visage, her smooth skin inviting your touch, modest C cups with erect nipples begging to be played with, that soft chest and those squeezable thighs gets your mind racing.\n\n");
			doNext(sexMenuVaginal);
		}
		public function sexMenuVaginal():void {
			if (player.hasCock()) {
				outputText("Your cock begins to rise as your thoughts become increasingly carnal, your desire for her now taking over your thoughts. Luna smiles at your reaction before mounting you, grabbing your cock in her soft grip and stroking it calmly. She leans in for another kiss and this time you take the lead, breaking through her lips and dominating her tongue relating your want for her.\n\n");
				outputText("She aligns your [cock] with her moist cunt and sinks down onto it. She wraps both her arms around your neck and pulls you in, moaning as you stretch her walls. Your hips connect and Luna savors the feeling of being filled by you before she raises her hips once more, slowly bringing her ass down again, a soft clap from the contact is made. ");
				outputText("Her yielding vaginal walls mold around your cock, squeezing down softly as you make love. Moans of pleasure and groans of rapture are traded between you two, lips churning against one another, tongues continuing their loving dance.\n\n");
				outputText("A warm feeling spreads throughout your body, temporarily making you forget about the pain of your stressed joints. You start to return Luna’s thrusts with some of your own passion filled ones. Claps of skin become louder as you both move in unison, moans growing in volume and pitch. Your arms move to the pliant flesh of her behind, grabbing handfuls of those enticing mounds while speeding up your thrusts.\n\n");
				outputText("Her moans turn to high pitched mewls at your ministrations, only further enticing you and your fervent thrusts become more passionate. Your tongue becomes ravenous, attacking every corner of Luna’s mouth. You soon feel that familiar feeling at the base of your cock, and with the last of your strength you rapidly thrust into Luna before exploding, her greedy hole taking in all you give her. ");
				outputText("Luna shivers above you before her walls clamp down and a flood of girlcum washes over your cock. You finally break the kiss with a sigh of relief, a string of spittle still connecting both of you. Closing your eyes, your arms wrap around Luna in a protective embrace, and she lays her head against your chest in bliss. You both eventually drift off to sleep in the loving embrace, content with the other in your arms.\n\n");
			}
			else {
				outputText("Your pussy lips begin puffing up, blood pumping through to them as thoughts of making fervent love to your maid. Luna smiles, almost knowingly, at your reaction before mounting you, teasingly running her hands over your chest before leaning in for a kiss. ");
				outputText("Her hands play around on your body, fingers drag up your arms, dance across your chest, squeeze your [breasts] and lightly pinch your areolas. Tongue breaking through your lips and intertwining with yours, she swallows every mewl of pleasure you make, the sensations coaxing the sweetest moans from your lips.\n\n");
				outputText("Eventually, Luna moves down, breaking the kiss you were sharing only to nip at your neck. She lightly pulls and licks the skin lovingly, serving to garner more moans from you. More kisses are placed along your collarbone, then she licks down between the valley of your mounds, coating the region with a generous amount of saliva, before rising to play with your breasts. ");
				outputText("The soft pink organ runs across your breasts, circling the flesh near the areola before its owner leans in to consume the hardened peak, suckling on it and then moving to do the same with your others breast flesh. Once your tits have been thoroughly teased, Luna continues her campaign of pleasure and moves down, kissing and licking around your chest.\n\n");
				outputText("Finally reaching her goal, Luna squeezes your thighs to get you to part them and you indulge her request, revealing [pussy], its lips fully engorged thanks to Luna’s ministrations. Luna immediately gets to work, she leans down and practically devours your lust, her mouth fully enveloping your lower lips and penetrating you with her long tongue. You arch in response to the sudden sensations, a single gasp leaving your lips as Luna spears your g-spot directly, her knowledge of your body surpassing your expectations.\n\n");
				outputText("Going about her work, Luna’s lips move in a steady rhythm with her tongue, thrusting the appendage forward while swirling it around and suckling on your lips, before pulling back and releasing your sex only to repeat her actions a moment later. She repeatedly attacks your weak points, favouring your g-spot as she works; your constant moans and jolts only tell her to continue. Mini orgasm after mini orgasm wrack your body, your nerve endings alight with nearly maddening amounts of pleasure, yet it’s still not enough. You NEED just a little bit more to finally push you over the edge.\n\n");
				outputText("Losing yourself to the search for pleasure, you put your hands on Luna’s head and push her down while desperately bucking your hips, trying to finally attain your desired release. Luna is more than happy to oblige your rather rough request and grips your [ass] as she begins zealously working away at your lust. Under her passionate assault you stand no hope of lasting against her, a loud moan signalling your impending release.\n\n");
				outputText("Finally, and with a great cry, you release your lust into your maid’s waiting mouth, her tongue still working away to prolong your orgasm. You fall back as she finishes the last of your girlcum, licking her lips before laying beside you and wrapping her arms around you. You return her sweet gesture, pulling her close and falling asleep in her arms.\n\n");
			}
			lunaJealousy(-100);
			lunaAffection(2);
			player.orgasm();
			if (flags[kFLAGS.LUNA_MOONING] == 2) {
				flags[kFLAGS.LUNA_MOONING] = 1;
				if (model.time.hours >= 21) CoC.instance.timeQ = 24 - model.time.hours;
				else CoC.instance.timeQ = 0;
				CoC.instance.timeQ += 6;
				doNext(camp.sleepWrapper);
			}
			else doNext(camp.returnToCampUseOneHour);
		}
		public function sexMenuSpearPolishing():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			var x:int = player.cockThatFits(36, "length");
			outputText("You request Luna to pleasure you with her mouth.\n\n");
			outputText("At your request she simply nods. \"<i>It would be my pleasure, " + player.mf("Master","Mistress") + ". Please, relax yourself and allow me to indulge your request.</i>\"\n\n");
			outputText("You relax, allowing Luna to remove your [armor], freeing you from the confines of your armor. Your maid finishes placing your [armor] in a neat pile off to the side before removing the top portion of her dress, revealing her modest C cups and soft skin. Approaching you again and locking lips, her hand dancing across your torso");
			if(player.biggestTitSize() > 0) outputText(" and playing with your [breasts]");
			outputText(".\n\She breaks the kiss and plants loving pecks down the center of your chest before planting herself on her knees in front of your cock. Grabbing the tool, she jerks it to life in a few pumps. A smile on her lips, she proceeds to kiss your cock, planting a trail of light smooches from tip to base");
			if (player.balls > 0) outputText(", paying special attention to your " + (player.balls == 2 ? "pair" : "quartet") + ", lathering them up with her tongue till their dripping with saliva ");
			if (player.balls > 0 && player.hasVagina()) outputText("and ");
			if (player.hasVagina()) outputText("thrusts two fingers into your waiting snatch, curling her finger to stimulate your most sensitive areas ");
			outputText("before she licks her way back to the tip.\n\n");
			outputText("Her tongue circles your glands, pressing down and circling the soft head of your cock forcing a groan from your lips. Once your cockhead has been thorougly teased she engulfs the head, taking it into her warm wet mouth, suckling on the tip. Moving her hand to the base of your cock, she starts taking your [cock] into her mouth, inch by pleasurable inch.");
			if (player.cocks.length > 1) outputText(" her other hand moves to your [cock biggest2] and gently pumps the meat in time with her own oral movements.\n\n");
			outputText("Luna takes you to the hilt, calmly sucking your meat before pulling back to the tip and plunging down, engulfing all length again.");
			if (player.cocks[x].cockLength >= 7) outputText(" Hitting the back of her throat, Luna pulls back slightly then pushes forward, forcing your cock into her tight throat and hilting all [cock] in her velvety confines before pulling back to the tip of your cock and plunging down engulfing all length again.");
			outputText("\n\nYou moan and groan, immensely enjoying her ministrations. You place a hand atop her head to guide her as she begins speeding up. Your knees begin feeling weak as she pleasures you, the rapid movements of her head and heat of her moist mouth is almost too much to bear for you. Muttering a quick warning, your cock throbs with your impending release and a few more moments you explode. Luna takes you to the hilt in her mouth again, making sure to drink down every bit of your delicious spooge");
			if (player.cocks.length > 1) outputText(" while your other tool" + (player.cocks.length == 2 ? "" : "s") + " unload their payloads");
			outputText(".\n\nMaking sure that she’s swallowed every last bit of cum");
			if (player.cumQ() >= 2000) outputText(", your massive load making her look a couple months into pregnancy (end)");
			else if (player.cumQ() >= 1000) outputText(", her belly slightly inflated from the impressive load you just fed her");
			outputText(", she pulls back and bows her head.\n\n");
			outputText("\"<i>Was that pleasing, " + player.mf("Master","Mistress") + "?</i>\" You pat her on the head and tell her it was magnificent, thanking her for the pleasant session.\n\n");
			outputText("You re-equip your [armor], turning to thank Luna once more, before you continue on with your day.\n\n");
			lunaJealousy(-100);
			lunaAffection(2);
			player.sexReward("saliva");
			doNext(camp.returnToCampUseOneHour);
		}
		public function sexMenuBoobjob():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("Your eyes can’t help but rove over Luna’s form, focusing on those modest C cups she sports. Lost in your lustful thoughts, you imagine many different ways you could pleasure yourself with teets such as hers, your cock" + (player.cocks.length == 1 ? "" : "s") + " aching in need as a result.\n\n");
			outputText("Luna searches your face for a moment, before nodding knowingly. \"<i>Master, would you like to relieve yourself using my body?</i>\" You compliment her for her intuition, you’d indeed enjoy relieving yourself with her lovely body. A single nod with a knowing smile is her response. She moves to undress you, removing your [armor] " + (player.weaponName == "fists" ? "" : "and [weapon] ") + "laying them down beside you before removing her own clothing. ");
			outputText("Your cock" + (player.cocks.length == 1 ? "" : "s") + " are already standing at full mast, eagerly awaiting the touch of your maid. Your mind wanders as your eyes roam her form before fixating on those modest C cups, imagining the soft flesh enveloping your member, Luna softly working away at on the tip with her mouth.\n\n");
			outputText("The thought of such pleasure makes your cock" + (player.cocks.length == 1 ? "" : "s") + " throbs with need, and you can’t help but chuckle at the reaction. You order Luna to use those magnificent peaks on your member, she silently nods and cups her chest, bringing it to the base of your cock. Kissing the tip, she places your member between her breasts, wrapping an arm around the globes and squeezing them so the yielding flesh molds perfectly around your cock, a pleasured sigh escapes your lips.\n\n");
			outputText("Pushing her breasts to the base of your tool, she swallows the sensitive tip and begins dragging her breasts along your [cock], her flesh igniting every sensitive area along your pecker oh so perfectly. Your maid speeds up, applying more pressure to her tits and hastening her movements along your cock, sucking harder on the tip and her tongue movements becoming more vigorous. She starts swallowing more of your dick while pumping the base of your shaft vigorously.\n\n");
			outputText("Moaning at her zealous treatment, and placing your hands on her head to steady yourself, you work in time with Luna’s actions, thrusting your shaft deeper into the silken vice of her breasts and shoving more into her heavenly oral cavern. The soft clap of flesh rebounds off your thighs as you both work vehemently towards your orgasm.\n\n");
			outputText("Cock twitching; ready to unload its payload, you push as deep as you possibly can into Luna’s velvety restraints. A single throb is all the warning Luna receives before your cock unloads its contents, warm cum filling her mouth and throat. Unphased, she drinks down every drop. After you finish rewarding your maid, she takes it upon herself to engulf the entirety of your cock, running her tongue over every bit of flesh and sucking on it again, your still sensitive shaft depositing a few more strings of cum, before she pulls away, leaving every inch of your [cock] glistening with her spit.\n\n");
			outputText("Taking in a deep breath, you thank Luna for her work, patting her on the head, before re-dressing and moving on with your day.\n\n");
			lunaJealousy(-100);
			lunaAffection(2);
			player.sexReward("Default", "Default",true,false);
			doNext(camp.returnToCampUseOneHour);
		}
		public function sexMenuDoggyTreats():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You wouldn't mind her giving in to her less human instincts while the two of you have sex, so long as she keeps it under control. Heck, right now, you would really like to check out that cute butt of hers.\n\n");
			outputText("Your reply has an immediate effect on Luna and she licks her lips with a seductive stare, slowly taking off her clothes. It does not take long before she is entirely naked and you see the telltale signs of her body shapeshifting. Her eyes begin to take on a glowing green hue and fur begins to grow out of her limbs.\n\n");
			outputText("\"<i>Mmmmm, " + player.mf("master","mistress") + ", you sure are giving me a treat today. I’m afraid I might have a very hard time controlling myself. I guess you could say that your servant is a very bad girl.</i>\"\n\n");
			outputText("Bad girl, eh? Well the way her tail is swishing from side to side to present her ass is certainly not something you’re going to say no to. You swiftly grab her from behind and push her on all fours as your [cock] goes rock hard. You’re not sure if you’ve shoved your cock into her plump ass, or if she pushed herself onto your length, maybe both but before you know it you’re deep inside of her. She can’t help but howl as you begin to work her pucker.\n\n");
			outputText("\"<i>AwoOOOOO! Now this is true mating!!! Fuck my ass until it’s full, [name]!</i>\"\n\n");
			outputText("You slap her butt hard, reminding her that you are her master and that therefore she will address you as such. She doesn’t seem to mind, if anything it only drives her deeper into her frenzied lust as her ass practically hugs your crotch, looking for attention. You play a little with her tail, using your free hand as you fuck the wolf slut harder, her pucker tightening around your prick just like a cunt. Truth be told you wouldn't be surprised if the changes to her body made her capable of savoring as much pleasure from her ass as from her pussy, ");
			outputText("what with doggystyle being one of her favorite positions. Regardless, her ass molds to your cock just as good as a vagina, and the pleasure you feel from it is good enough for you to feel your [cock] starting to twitch in delight. Luna growls in pleasure from each thrust, and this only drives you further on. Eventually, you can’t hold it anymore and lose control of your [cock], Luna howling in pleasure as you flood her asshole with your cum, the excess puddling on the ground between her legs. ");
			outputText("You fall limply on her back, needing some rest and she is all too happy to pull you into her embrace for a while, hugging snuggly to you and getting a full whiff of your scent.\n\n");
			outputText("You rest like this for a moment before lifting back up and resuming your duties. Luna has regained her human form since then and is already starting to put back on her maid uniform.\n\n");
			lunaJealousy(-100);
			lunaAffection(2);
			player.sexReward("Default", "Default",true,false);
			doNext(camp.returnToCampUseOneHour);
		}
		public function sexMenuSandwichWithAyane():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("As you mull over your options. Ayane comes over to do her report and stare at you both with wide eyes.\n\n");
			outputText("\"<i>No way! You’re going to reward the mutt over your devoted priestess? I will have none of that! Luna, I challenge you to a duel to see who makes [name] cum first!</i>\"\n\n");
			outputText("Luna give her a playful grin in response. \"<i>Challenge accepted, but you cannot hope to win against my spear polishing techniques!</i>\"\n\n");
			outputText("Ayane cross her arms under her breast. \"<i>Do not underestimate the talents of the kitsunes, we have been at it since Taoth created us! I’m going to fill my belly full of that meal.</i>\"\n\n");
			outputText("Whoa, since when did these two get so competitive?! You decide the best way to stop their argument is to order them both to pleasure your [cock] at the same time.\n\n");
			outputText("They both turn over at the same time yelling \"<i>Can do!</i>\" before throwing off their clothes in one swift motion and getting into position; Ayane under and Luna on top, their pussy and ass aligned together to perfectly sandwich your prick between them. Well now this is a hole you cannot refuse! Your [cock] hardens at the prospect of fucking this new hole just as you finish undressing. While you were busy, you didn’t notice the pair drooling in anticipation of your incoming pole" + (player.cocks.length == 1 ? "" : "s") + ". Foxes and wolves, you guess they're all canid after all. ");
			outputText("You start to slide your tool" + (player.cocks.length == 1 ? "" : "s") + " between their waiting holes, their joined pussies having done an excellent job of lubricating the whole thing; the two of them moaning as your " + (player.cocks.length == 1 ? "cock grinds" : "cocks grind") + " on their puffed up vaginal flesh. ");
			if (player.cocks.length == 1) outputText("You pump your cock in and out of the duo. Sometime sliding in either hole before coming back in between. ");
			if (player.cocks.length == 2 || player.cocks.length == 3) outputText("Why fuck only one girl when you can fuck both! Having more than one penis has its advantages and you gladly insert yourself into their two well aligned pussies, fucking Ayane and Luna at the same time. ");
			if (player.cocks.length >= 4) outputText("Why fuck only one girl when you can fuck both! Having more than one penis has its advantages and you gladly insert yourself into their two well aligned pussies, fucking Ayane and Luna at the same time. That said, you got enough cocks to fill their ass too, and gladly insert yourself in their waiting holes. Luna howls with delight as you break past her pucker. ");
			outputText("The pair, already lost between heaven and hells, lock into a passionate kiss as both of their pussy lips hug and mold around your cock" + (player.cocks.length == 1 ? "" : "s") + " like attention starved animals. Ayane uses her body to its full extent, moving her tail to leave trails of blue fire on your ");
			if (player.balls > 0) outputText("balls which only cause them to churn with a massive supply of cum; this is going to be one hell of a mess!");
			else outputText("sensitive skin.");
			outputText(" Luna’s own tail is out and is busy circling your anal ring with its tip which only drives you crazier.\n\n");
			outputText("Their combined affection and skill eventually make short work of your restraint; " + (player.cocks.length > 1 ? "you pull out of their holes, " : "") + "cum flowing " + (player.balls > 0 ? "out of your balls and " : "") + "through your [cock], splattering the space between them up to their combined breasts with a massive load of semen. Fully satisfied, the pair lick their lips as they untangle from your cock, a large puddle forming on the ground. ");
			outputText("They head for the spring to clean themselves giving you a pair of playful winks before leaving you to rest. Well, now that you think of it, they both won and you lost. But who cares; what a good time you had!\n\n");
			outputText("You decide to take a nap to recover some energy. A few hour later, you wake up ready to resume adventuring.\n\n");
			lunaJealousy(-100);
			lunaAffection(2);
			player.sexReward("Default", "Default",true,false);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function sexMenuDominateHerIntro():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You ask the maid how she feels about giving in to her beastly desire. The green glimmer in her eyes is all you need to see how much she desires it before she begins to shapeshift into her beast form.\n\n");
			flags[kFLAGS.LUNA_MOONING] = 1;
			doNext(sexMenuDominateHer);
		}
		public function sexMenuDominateHer():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("You grab at the werewolf girl’s exposed chest and begin tugging, making her moan in delight at your forceful attention.\n\n");
			outputText("\"<i>Ooooh " + player.mf("Master","Mistress") + ", I knew you loved me! Please make me your bitch for the night!</i>\"\n\n");
			outputText("You're way too horny to stop now. You will use her however you want and that starts with satisfying your desire.\n\n");
			if (player.gender == 1) {
				outputText("You're going to get a taste of that doggy pussy right now. The wolf girl doesn’t  even begin to protest as you grab her hips forcing her on all fours. You move behind her and shove your [cock] right into her hot cunt");
				if (player.hasKnot()) outputText(", knotting her just fine");
				outputText(".\n\n\"<i>Awoooooooo, that's just the right size master! Use me!!! Use me more!!!</i>\"\n\n");
				outputText("You're just beginning however, and start to pound the bitch in earnest. If being dominated by an Alpha male is her thing you are more than happy to oblige. The bitch pants, drool falling on the dirt as you fuck her, your crotch slapping against her well shaped backside with each thrust. Gosh her cunt is like a vice" + (flags[kFLAGS.LUNA_MOON_CYCLE] % 7 == 0 ? ", is she actually in heat every single full moon?" : ".") + " ");
				outputText("If that's the case you’re going to abuse that wanting cunt every time the lunar disc is complete. Her tail is wagging from side to side as you fuck her for several minutes, soothing her " + (player.inRut ? "and your " : "") + "feral urges!\n\n");
				outputText("Finally you reach your climax " + ((player.dogScore() > 5 || player.wolfScore() > 5) ? "howling in tandem with her" : "roaring in tandem with her howl") + " as you paint her cunt white like the moon with your hot seed. She sighs in relief, turning over without unplugging you from her cunt to embrace you.\n\n");
				lunaJealousy(-100);
				lunaAffection(2);
				player.sexReward("vaginalFluids","Dick");
				if (flags[kFLAGS.LUNA_MOONING] == 1) {
					outputText("You rest a moment in her arms before breaking the hug. As much as your savage lover would like you to dom her all day you’ve got other things to do. The both of you redress before resuming normal activities.\n\n");
					doNext(camp.returnToCampUseOneHour);
				}
				else {
					outputText("You keep painting her cunt several times under the moonlight until dawn finally breaks, the two of you resting a few hours before resuming activity. Luna give you a parting wink before adding.\n\n");
					outputText("\"<i>I knew you had it in you [name] please just make sure to use me regularly.</i>\"\n\n");
					if (flags[kFLAGS.LUNA_FOLLOWER] < 7 && player.werewolfScore() > 6) {
						outputText("Yes for sure! You're going to make sure to use her as often as necessary to imprint your scent on her from now on. She’s your beta and no one else’s.");
						flags[kFLAGS.LUNA_FOLLOWER] = 15;
					}
					flags[kFLAGS.LUNA_MOONING] = 1;
					if (model.time.hours >= 21) CoC.instance.timeQ = 24 - model.time.hours;
					else CoC.instance.timeQ = 0;
					CoC.instance.timeQ += 10;
					doNext(camp.sleepWrapper);
				}
			}
			else {
				outputText("You sure are making her your bitch tonight, you're the alpha female here and as such you deserve proper tribute! You begin by brutally shoving her down on the ground to assert your dominance and make your positions clear. Now that she's on her back you sit on her face and yip your first order of the " + (flags[kFLAGS.LUNA_MOONING] == 2 ? "night" : "day") + ".\n\n");
				outputText("\"<i>Lick me clean " + (player.hasCock() ? "and get to pumping my tool" : "") + "!</i>\"\n\n");
				outputText("She doesn’t protest and swiftly get to it making you growl in satisfaction as her dog tongue slithers in " + (player.hasCock() ? "and her paws jerks your [cock]" : "") + ". Beta or not Luna deserves some reward, however. You bring your " + (player.haveNaturalClaws() ? "paw" : "hand") + " to her cunt and begin playing inside while you use your other " + (player.haveNaturalClaws() ? "paw" : "hand") + " to grab her left breast, squeezing it firmly. Luna seems to be enjoying herself, her tail wagging from side to side which is fine, so long as YOU remain on top and reach satisfaction first. ");
				outputText("Whenever you feel she's getting more pleasure than you, you deny her until you've caught up, making sure you are always ahead. " + (player.werewolfScore() >= 12 ? "The both of you are" : "She’s") + " panting in desire like " + (player.werewolfScore() >= 12 ? "beasts" : "a beast") + " growling between gasps of pleasure.\n\n");
				outputText("Finally you cum, flooding her thirsty mouth with your girl juices");
				if (player.hasCock()) outputText(" as your cock explodes, covering her chest up to her belly in semen" + (player.werewolfScore() >= 12 ? " while you howl to the moon, savoring your mind blowing orgasm" : "") + "");
				outputText(". The waters flooding your fingers a few seconds later are the only telltale sign your beta finally reached her climax, but you think it’s more than enough of a reward for her.\n\n");
				lunaJealousy(-100);
				lunaAffection(2);
				player.sexReward("saliva");
				if (flags[kFLAGS.LUNA_MOONING] == 1) {
					outputText("Satisfied, you rest a moment in her arms before breaking up. As much as your savage lover would like you to dom her all day you got other things to do. The both of you redress before resuming activity.\n\n");
					doNext(camp.returnToCampUseOneHour);
				}
				else {
					outputText("That said, you are far from done. The moment you recover, you resume fucking with her like a beast several time under the moonlight until dawn finally breaks, the two of you resting a few hours before resuming activity. Luna give you a parting wink before adding.\n\n");
					outputText("\"<i>I knew you had it in you [name] please just make sure to use me regularly.</i>\"\n\n");
					if (flags[kFLAGS.LUNA_FOLLOWER] < 7 && player.werewolfScore() > 6) {
						outputText("Yes for sure! You're going to make sure to use her as often as necessary to imprint your scent on her from now on. She’s your beta and no one else’s.");
						flags[kFLAGS.LUNA_FOLLOWER] = 15;
					}
					flags[kFLAGS.LUNA_MOONING] = 1;
					if (model.time.hours >= 21) CoC.instance.timeQ = 24 - model.time.hours;
					else CoC.instance.timeQ = 0;
					CoC.instance.timeQ += 10;
					doNext(camp.sleepWrapper);
				}
			}
		}
		/*
		public function sexMenuSpearPolishing():void {
			spriteSelect(SpriteDb.s_luna_maid);
			clearOutput();
			outputText("WIP\n\n");
			outputText("\"<i>WIP</i>\"\n\n");
			doNext(talkMenuLuna);
		}*/
	}
}