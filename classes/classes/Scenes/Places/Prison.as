//Prisoner Mod WIP
package classes.Scenes.Places 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.*;
	import classes.Scenes.Places.Prison.*
	
	import coc.view.MainView;
	
	public class Prison extends BaseContent implements TimeAwareInterface
	{
		public var ellyScene:EllyScene = new EllyScene();
		//public var scruffyScene:ScruffyScene = new ScruffyScene();
		//public var billieScene:BillieScene = new BillieScene();
		
		private var heardPrisonerScreamCooldown:int = 0;
		
		public function Prison() {
			CoC.timeAwareClassAdd(this);
		}
		
		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			if (heardPrisonerScreamCooldown <= 0 && rand(10) == 0) {
				heardPrisonerScreamCooldown = 10;
				hopelessPrisoner();
			}
			if (heardPrisonerScreamCooldown > 0) heardPrisonerScreamCooldown--;
			var needNext:Boolean = false;
			return needNext;
		}
		
		public function timeChangeLarge():Boolean{
			return false;
		}
		//End of Interface Implementation
		
		//Stats changes and modules
		/**
		 * Change the player's self-esteem.
		 * @param	amount How much to add or deduct.
		 */
		public function changeSelfEsteem(amount:int = 0, display:Boolean = false):void {
			var oldEsteem:Number = flags[kFLAGS.PRISON_STAT_SELFESTEEM];
			flags[kFLAGS.PRISON_STAT_SELFESTEEM] += amount;
			if (flags[kFLAGS.PRISON_STAT_SELFESTEEM] > 100) flags[kFLAGS.PRISON_STAT_SELFESTEEM] = 100;
			if (flags[kFLAGS.PRISON_STAT_SELFESTEEM] < 0) flags[kFLAGS.PRISON_STAT_SELFESTEEM] = 0;
			//Bring up message.
			if(display)
			{
				if(oldEsteem >= 15 && flags[kFLAGS.PRISON_STAT_SELFESTEEM] < 15)
				{
					outputText("\n<b>Your self-esteem is now extremely low. Your ability to recover your willpower is greatly diminished, your complete lack of self-worth makes you easily swayed by the criticisms and demands of others, and your ",false);
					if (player.cor < 20) outputText("rare");
					else if (player.cor >= 20 && player.cor < 40) outputText("occasional", false);
					else if (player.cor >= 40 && player.cor < 60) outputText("frequent", false);
					else if (player.cor >= 60 && player.cor < 80) outputText("near constant", false);
					else if (player.cor >= 80) outputText("constant", false);
					outputText(" corrupt thoughts inspire you to give up your pride and be more subservient to those who would dominate you.</b>\n",false);
				}
				if(oldEsteem >= 40 && flags[kFLAGS.PRISON_STAT_SELFESTEEM] < 40 || oldEsteem < 15 && flags[kFLAGS.PRISON_STAT_SELFESTEEM] >= 15)
				{
					outputText("\n<b>Your self-esteem is now low. Your ability to recover your willpower is somewhat diminished, your crumbling sense of self-worth makes you more susceptible to the criticisms and demands of others, and your ",false);
					if (player.cor < 20) outputText("rare");
					else if (player.cor >= 20 && player.cor < 40) outputText("occasional", false);
					else if (player.cor >= 40 && player.cor < 60) outputText("frequent", false);
					else if (player.cor >= 60 && player.cor < 80) outputText("near constant", false);
					else if (player.cor >= 80) outputText("constant", false);
					outputText(" corrupt thoughts increasingly linger on how good it feels to obey the directions of those who would dominate you.</b>\n",false);
				}
				if(oldEsteem >= 60 && flags[kFLAGS.PRISON_STAT_SELFESTEEM] < 60 || oldEsteem < 40 && flags[kFLAGS.PRISON_STAT_SELFESTEEM] >= 40)
				{
					outputText("\n<b>Your self-esteem is now normal. You recover your willpower at an average rate and your reactions to the criticisms and demands of others are reasonable.</b>\n",false);
				}
				if(oldEsteem >= 85 && flags[kFLAGS.PRISON_STAT_SELFESTEEM] < 85 || oldEsteem < 60 && flags[kFLAGS.PRISON_STAT_SELFESTEEM] >= 60)
				{
					outputText("\n<b>Your self-esteem is now high. Your ability to recover your willpower is somewhat increased, your strong sense of self-worth makes it easy to shrug off the criticisms and demands of others, and your intelligence slowly works to undo any submissive tendencies you may have.</b>\n",false);
				}
				if(oldEsteem < 85 && flags[kFLAGS.PRISON_STAT_SELFESTEEM] >= 85)
				{
					outputText("\n<b>Your self-esteem is now very high. Your ability to recover your willpower is greatly increaed, your powerful sense of self-worth makes ignoring the criticisms and demands of others second nature, and your intelligence greatly aids you in the process of unlearning any submissive tendencies you may have.</b>\n",false);
				}
			}
			statScreenRefresh();
		}
		/**
		 * Change the player's willpower.
		 * @param	amount How much to add or deduct.
		 */
		public function changeWillpower(amount:int = 0, display:Boolean = false):void {
			flags[kFLAGS.PRISON_STAT_WILLPOWER] += amount;
			if (flags[kFLAGS.PRISON_STAT_WILLPOWER] > 100) flags[kFLAGS.PRISON_STAT_WILLPOWER] = 100;
			if (flags[kFLAGS.PRISON_STAT_WILLPOWER] < 0) flags[kFLAGS.PRISON_STAT_WILLPOWER] = 0;
			statScreenRefresh();
		}
		/**
		 * Change the player's obedience.
		 * @param	amount How much to add or deduct.
		 */
		public function changeObey(amount:int = 0, display:Boolean = false):void {
			var oldObey:Number = flags[kFLAGS.PRISON_STAT_OBEDIENCE];
			flags[kFLAGS.PRISON_STAT_OBEDIENCE] += amount;
			if (flags[kFLAGS.PRISON_STAT_OBEDIENCE] > 100) flags[kFLAGS.PRISON_STAT_OBEDIENCE] = 100;
			if (flags[kFLAGS.PRISON_STAT_OBEDIENCE] < 0) flags[kFLAGS.PRISON_STAT_OBEDIENCE] = 0;
			//Bring up message.
			if(display)
			{
				if(oldObey >= 10 && flags[kFLAGS.PRISON_STAT_OBEDIENCE] < 10)
				{
					outputText("\n<b>You now have a strong ability to resist the demands of those who would dominate you.</b>\n",false);
				}
				if(oldObey >= 25 && flags[kFLAGS.PRISON_STAT_OBEDIENCE] < 25 || oldObey < 10 && flags[kFLAGS.PRISON_STAT_OBEDIENCE] >= 10)
				{
					outputText("\n<b>Your ability to resist the demands of those who would dominate you is now weakened. While you still have a strong innate distaste for being ordered around, you are are finding it hard to see the point in resisting the smaller things.  It's better to conserve your willpower to fight against the truly heinous and demeaning commands... isn't it?</b>\n",false);
				}
				if(oldObey >= 45 && flags[kFLAGS.PRISON_STAT_OBEDIENCE] < 45 || oldObey < 25 && flags[kFLAGS.PRISON_STAT_OBEDIENCE] >= 25)
				{
					outputText("\n<b>Your ability to resist the demands of those who would dominate you is now all but broken. The concept of being subservient to another being is still abhorrent to you, but in practice you are finding it far easier to swallow your pride and do as you are told than to face the consequences of resisting.</b>\n",false);
				}
				if(oldObey >= 70 && flags[kFLAGS.PRISON_STAT_OBEDIENCE] < 70 || oldObey < 45 && flags[kFLAGS.PRISON_STAT_OBEDIENCE] >= 45)
				{
					outputText("\n<b>Your ability to resist the demands of those who would dominate you is now essentially nonexistent. It still brings you great shame to give up agency over your actions, but you find yourself starting to crave that shame. While you manage to exert the willpower to resist an order from time to time, you are begining to wonder if you are doing so out of a genuine desire for self determinance, or simply because the experience of being punished is becoming exciting to you.</b>\n",false);
				}
				if(oldObey >= 90 && flags[kFLAGS.PRISON_STAT_OBEDIENCE] < 90 || oldObey < 70 && flags[kFLAGS.PRISON_STAT_OBEDIENCE] >= 70)
				{
					outputText("\n<b>Your ability to resist the demands of those who would dominate you is now a faint memory. You understand that other people have the ability to determine their own fate, but you instead relish the sweet, shameful, all consuming simplicity of obedience. While you can manage to exert the willpower to resist an order from time to time, you know it is only so that you can experience the thrill of being put back in your rightful place.</b>\n",false);
				}
				if(oldObey < 90 && flags[kFLAGS.PRISON_STAT_OBEDIENCE] >= 90)
				{
					outputText("\n<b>The ability to resist the demands of those who would dominate you is now a foreign concept. You are a creature of submission and obedience that exists only to serve at the whim of your betters. On rare occasion you may exert the willpower to resist an order, but you only do so because you fear being forgotten by your masters. You crave the overwhelming rush of joy that comes when they punish you, reinforcing the shameful (delightful?) knowledge that you are nothing more than property, and that pleasure comes from being used.</b>\n",false);
				}
			}
			statScreenRefresh();
		}
		
		public function prisonCanTrainWorkout():Boolean
		{
			if(player.statusAffectv3(StatusAffects.PrisonRestraints) > 0 || player.statusAffectv2(StatusAffects.PrisonRestraints) > 1)
			{
				outputText("Without the free use of your arms, you are unable to do strength training.", true);
				return false;
			}
			return true;
		}
		public function prisonCanTrainCardio():Boolean
		{
			if(player.statusAffectv2(StatusAffects.PrisonRestraints) > 0)
			{
				outputText("Without the free use of your [legs], you are unable to do cardio training.", true);
				return false;
			}
			return true;
		}
		/*public function prisonCanUseItem(newGameText:String):Boolean
		{
			inPrison;
			if(inPrison && itemIsFood(newGameText) && !prisonCanEat())
			{
				return false;
			}
			inPrison;
			if(inPrison && !itemIsFood(newGameText) && !prisonCanEquip())
			{
				return false;
			}
			return true;
		}
		public function prisonCanEat():Boolean
		{
			if(!(player.statusAffectv4("prisonRestraint") > 0 && player.statusAffectv4("prisonRestraint") == 4))
			{
				outputText("Because your mouth is gagged you are unable to eat at this time.", true);
				return false;
			}
			return true;
		}
		public function prisonCanEquip():Boolean
		{
			if(player.statusAffectv3("prisonRestraint") > 1 || player.statusAffectv2("prisonRestraint") > 1)
			{
				outputText("Because of the way your arms are bound you are unable to equip items at this time.", true);
				return false;
			}
			return true;
		}*/
		
		
		//Intro
		public function goDirectlyToPrisonDoNotPassGoDoNotCollect200Gems():void {
			clearOutput();
			outputText("You peer around the corner of a tent. You are unsurprised to see a collection of beast men around a cookfire, but you find yourself far more interested in the cage wagon beyond them. You become so wrapped up in trying to identify the lumpy shapes in the shadowy interior that the sound of twigs snapping behind you doesn't immediately trigger alarm bells in your mind, and before you can properly respond you are knocked unconscious by a brutal blow to the back of your head.");
			flags[kFLAGS.IN_PRISON] = 1;
			player.createStatusAffect(StatusAffects.PrisonRestraints, 0, 0, 0, 0);
			doNext(prisonIntro);
		}
		
		public function prisonIntro():Boolean
		{
			clearOutput();
			outputText("While you were unconscious you were captured by slavers, stripped of your items and equipment, and thrown into a locked cell.",false);
			/*if(prisonCaptor.captorName != "Elly")
			{
				outputText("\n\nThe door opens and a guard tosses a pathetic piece of bread at your feet.",false);
				outputText("\n\n\"<i>" + prisonCaptor.captorTitle + " " + prisonCaptor.captorName + " sends " + prisonCaptor.guardPronoun3 + " regards,</i>\" the guard says brusquely, and slams the door shut.\n\n",false);
				inventory.takeItem(consumables.P_BREAD, camp.returnToCampUseOneHour);
				return false;
			}*/
			outputText("\n\nShortly after you wake, the door opens and a captivating omnibus enters the room. While her physique is impressive -- long, shapely legs in laced, thigh-high, spike-heeled leather boots; a powerful, athletic but curvy frame; a pair of perky C-cups spilling out of a tight-fitting leather corset -- your eyes focus on her charismatic face. She is possessed of exotic and delicate features, enticingly framed by side swept bangs that have escaped the loosely bound ponytail atop her head. The striking contrast of her fire red hair against her smooth olive skin completes the effect, suggesting that her  countenance could shift from intoxicatingly arousing to overwhelmingly intimidating to soft and comforting at any moment.",false);
			outputText("\n\nShe carries little evidence of demonic taint besides a pair of cute, curled horns sprouting from her temples and an agile, spade-tipped tail that flicks about above her muscular, heart-shaped ass. Her preternatural aura of poise, charm, and command, however, betray that she must be a very powerful demon indeed. She looks you over appraisingly while absentmindedly trailing her lithe fingers up and down her semi-erect but rather imposing cock. You notice that she wears long, laced leather sleeves, covering her shoulder to wrist. They strap around her middle fingers, but leave her hands conspicuously ungloved. It would seem that she prefers her subjects to feel her soft, silky skin when she touches them.",false);
			if(player.findStatusAffect(StatusAffects.PrisonCaptorEllyStatus) < 0)
			{
				player.createStatusAffect(StatusAffects.PrisonCaptorEllyStatus,0,0,0,0);
			}
			/*
			if((prisonCaptorFeedingQuestTrainingExists()) && ((prisonCaptorFeedingQuestTrainingIsComplete()) || (prisonCaptorFeedingQuestTrainingIsTimeUp())))
			{
				outputText("\n\n(Placeholder) Mistress Elly wecomes you back from your slutty adventures in the outside world.\n\n");
				prisonCaptorFeedingQuestTrainingResolve();
				return false;
			}
			if((prisonCaptorFeedingQuestTrainingExists()) && !prisonCaptorFeedingQuestTrainingIsTimeUp())
			{
				outputText("(Placeholder) Mistress Elly enters the room and chastises you for not being out working on her quest.\n\n");
				return true;
			}*/
			if(player.statusAffectv1(StatusAffects.PrisonCaptorEllyStatus) > 0)
			{
				outputText("\n\nMomentarily she breaks her piercing stare and speaks. \"<i>Welcome back, slave</i>\" she intones in a voice every bit as beautiful and compelling as her face, \"<i>I take it your field education went well. Did you give yourself a lesson about fighting back by letting a few nice minotaurs rape you? Or maybe you went for some 'archery lessons' with that centaur fellow.</i>\" She leans in close to you gives your " + assDescript() + " a fierce but playful slap. \"<i>You could certainly learn some useful things from him.</i>\" She closes the distance further, and her natural, musky, alluring scent washes over you. For a moment you aren't sure if you want to fall to your knees and embrace her or cower pitifully in the shadow of her overpowering presence. Your gaze becomes transfixed on the mesmerizing movements of her deliciously pouty crimson lips.",false);
				outputText("\n\n\"<i>Whatever you may have been doing, I'm pleased that you've decided to come back and continue your formal education with me. I know you are eager for it to be complete, but rememeber it takes time to understand that you are...</i>\" Defying all reason, she somehow moves even closer to you.",false);
				outputText("\n\n\"<i>a pliable...</i>\" Her strawberry tongue traces the contours of her lips as she purrs the word, then darts out to tease yours. Shivers run down your spine.",false);
				outputText("\n\n\"<i>obedient...</i>\" The fingers of her right hand gently caress your " + chestDesc() + ".",false);
				outputText("\n\n\"<i>servile...</i>\" The fingers of her left hand forcefully probe your " + assholeDescript() + ".",false);
				outputText("\n\n\"<i>piece of flesh...</i>\" Her now fully erect cock grinds against your ",false);
				if(player.cocks.length == 0)
				{
				  outputText(clitDescript() + ".",false);
				}
				else if(player.cocks.length == 1)
				{
				  outputText(cockDescript(0) + ".",false);
				}
				else
				{
				  outputText(multiCockDescriptLight() + ".",false);
				}
				
				outputText("\n\n\"<i>whose only reason to exist is to entertain and please others.</i>\" She abruptly shoves you to the ground, and in the sudden absence of her closeness ",false);
				if(flags[kFLAGS.PRISON_STAT_OBEDIENCE] < 45)
				{
				  outputText("you are overcome by an unwelcome rush of desire to do whatever it takes to get it back. ",false);
				}
				else
				{
				  outputText("you are filled with lament at its loss and a consuming desire to learn whatever lessons your Mistres wishes to teach you.",false);
				}
				outputText("\n\nShe moves back towards the door. \"<i>Since you have been disobedient I shouldn't be giving you any food at all until you earn it. But I have a soft spot for you, little slave, so I suppose we can just think of this a homecoming gift of sorts.</i>\" Out of thin air she produces a pitiful loaf of bread and crumbles it into a bowl. With a smile of supreme satisfaction, she begins to milk her cock into it. Before long, the bowl is overflowing with her sticky seed. She sets it on the ground and gives you a playful wink before leaving you alone in the cell.\n\n",false);
				changeObey(3, true);
				inventory.takeItem(consumables.C_BREAD, camp.returnToCampUseOneHour);
				return false;
			}
			player.changeStatusValue(StatusAffects.PrisonCaptorEllyStatus,1,1);
			//flags[1002] = 0;
			outputText("\n\nAfter an uncomfortable period of being <i>examined</i>, you watch the demon's violet, almond eyes finally settle -- on your own. Her gaze is beyond piercing, seeming to both physically and mentally enfeeble you. You find yourself unable to escape it, and your fortitude steadily wanes. The moment begins to extend into a dense, stifling eternity, when suddenly -- she speaks. \"<i>Hello, Champion.</i>\" To your almost embarrassing surprise, her voice is every bit as beautiful and compelling as her face, and you barely notice that her eyes have moved on.  \"<i>I am your new owner. My name is Elly, but <b>you</b> will call me Mistress.</i>\" She says it with impartial conviction, as if it were a trivial matter of fact, and for an eerie moment, your mind absorbs it as truth. ",false);
			outputText("\n\n\"<i>By now, any number of monsters and demons must have tried to make you their property, so you no doubt assume that my intentions are the same. In one sense they surely are. The others wanted to own your body, as I now do.</i>\" She emphasizes this point by kicking you onto your back and resting her spiked boot on your [chest]. \"<i>The difference is that where they aim to merely destroy your mind so they can claim your body, I will instead own your mind and you will willingly give me your body. The process of you learning that you are my property will be slow, subtle, and humiliating... but when it is complete, you will beg me to let you experience it again.</i>\" Smiling wickedly, she slides her foot down your torso and begins using her boot covered toe to gently caress your ",false);
			if(player.cocks.length == 0)
			{
				outputText(clitDescript() + ".",false);
			}
			else if(player.cocks.length == 1)
			{
				outputText(cockDescript(0) + ".",false);
			}
			else
			{
				outputText(multiCockDescriptLight() + ".",false);
			}
			
			outputText("\n\n\"<i>But you <b>will</b> learn.</i>\"",false);
			outputText("\n\n\"<i>You will dream about every time one of my guards taught you a lesson in obedience by raping you, and you will wake up masturbating.</i>\"",false);
			outputText("\n\n\"<i>You will salivate at the very thought of licking a pool of jizz off your cell floor, and consider every drop of cum deposited in or on your body to be a gift you are unworthy of.</i>\"",false);
			outputText("\n\n\"<i>You will feel jealousy every time you hear the screams of another slave being taught their place. You will envy the fact that they will soon enjoy the wonderful epiphany of understanding what they really are. And, quite likely, you will stage fake rebellions simply to enjoy the rush of having your bad behavior corrected.</i>\"",false);
			outputText("\n\n\"<i>Finally, you will think back on the times when you genuinely tried to resist your true nature -- a pliable, obedient, servile piece of flesh whose only reason to exist is to entertain and please others -- and you will feel grateful that your kind Mistress found you and saved you from your foolish ways.</i>\"",false);
			outputText("\n\nShe emphasizes this final point by turning and walking to the door, then adding, almost as an afterthought, \"<i>Please do resist all you like, by the way, and even escape if you can. Don't worry, it usually doesn't take long catch you again, and more often than not you'll just come back to me on your own. In any case, your resistance creates useful, teachable moments. You can only learn how wrong you are about yourself if you have the opportunity to have your behaviors corrected, after all.</i>\"",false);
			outputText("\n\n\"<i>Here, a special meal to help you get comfortable. Remember how good it tastes, since you'll need to earn it in the future.</i>\" She throws a pitiful looking loaf of bread on the floor next to you, and abruptly leaves you alone in your cell. ",false);
			if(flags[kFLAGS.PRISON_STAT_OBEDIENCE] < 45 && player.cor < 70)
			{
				outputText("You find yourself unsettled by ",false);
			}
			else
			{
				outputText("You find yourself aroused and compelled by ",false);
			}
			outputText("how long Mistress Elly's arresting presence lingers in your mind, and by the depth of the effect her words seemed to have on your psyche.\n\n",false);
			changeObey(2, true);
			flags[kFLAGS.PRISON_CAPTURE_COUNTER]++;
			inventory.takeItem(consumables.P_BREAD, camp.returnToCampUseOneHour);
			return false;
		}
		
		public function prisonRoom():void {
			clearOutput();
			outputText(images.showImage("prison-cell"), false);
			outputText("You are in a dimly lit but spacious cell. However, the size of the room is little comfort to you as it is filled with all manner of restraints and torture devices. Eylets, metal rings, bars and hooks are scattered around the ceiling, floor and walls providing a near endless variety of ways to restrain a person. A wooden stockade is installed in the center of the room, a whipping post and a rack stand in one corner, and in another there is a large and ominous floor to ceiling stone box. Mercifully, fresh air and sunlight can enter the room through narrow slit windows opposite the door.\n\n");
			if (flags[kFLAGS.PRISON_DOOR_UNLOCKED] == 0) outputText("The door is locked securely.\n\n");
			else outputText("The door is unlocked.\n\n");
			if (flags[kFLAGS.PRISON_DIRT_LEVEL] < 25) outputText("The room is about as clean as it is going to get.");
			else if (flags[kFLAGS.PRISON_DIRT_LEVEL] >= 25 && flags[kFLAGS.PRISON_DIRT_LEVEL] < 50) outputText("The room is a bit messy.");
			else if (flags[kFLAGS.PRISON_DIRT_LEVEL] >= 50 && flags[kFLAGS.PRISON_DIRT_LEVEL] < 75) outputText("The room is <b>unpleasantly dirty</b>.");
			else outputText("The room is <b>extremely filthy</b>");
			if(kGAMECLASS.timeQ > 0)
			{
				/*if(!kGAMECLASS.campQ)
				{
					outputText("More time passes...\n", true);
					goNext(kGAMECLASS.timeQ, false);
					return;
				}*/
				if(model.time.hours < 6 || model.time.hours > 20)
				{
					camp.doSleep();
					return;
				}
				camp.rest();
				return;
			}
			//if(prisonRoomEvents())
			//{
			//	return;
			//}
			mainView.showMenuButton( MainView.MENU_NEW_MAIN );
			mainView.showMenuButton( MainView.MENU_DATA );
			mainView.showMenuButton( MainView.MENU_STATS );
			mainView.showMenuButton( MainView.MENU_PERKS );
			mainView.showMenuButton( MainView.MENU_APPEARANCE );
			showStats();
			mainView.setMenuButton( MainView.MENU_NEW_MAIN, "Main Menu", kGAMECLASS.mainMenu );
			if (player.lust >= 30) {
				if (player.lust >= player.maxLust()) {
					outputText("\n\n<b>You are debilitatingly aroused, and can think of doing nothing other than masturbating.</b>", false);
					removeButton(0);
					removeButton(4);
				}
				addButton(8, "Masturbate", getGame().masturbation.masturbateGo);
				if (((player.findPerk(PerkLib.HistoryReligious) >= 0 && player.cor <= 66) || (player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < 10)) && !(player.findStatusAffect(StatusAffects.Exgartuan) >= 0 && player.statusAffectv2(StatusAffects.Exgartuan) == 0) || flags[kFLAGS.SFW_MODE] >= 1) addButton(8, "Meditate", getGame().masturbation.masturbateGo);
			}
			
			hideUpDown();
			menu();
			addButton(0, "Train", trainMenu);
			addButton(1, "Study", studyMenu);
			addButton(2, "Restraints", null, null, null, null, "Not implemented yet.");
			if (flags[kFLAGS.PRISON_DIRT_LEVEL] > 0) addButton(3, "Clean", cleanCell, null, null, null, "Clean the cell.");
			addButton(4, "Escape", placeholderEscape);
			addButton(7, "Inventory", inventory.inventoryMenu);
			addButton(8, "Masturbate", getGame().masturbation.masturbateGo);
			//Show wait/rest/sleep depending on conditions.
			addButton(9, "Wait", camp.doWait);
			if (player.fatigue > 40 || player.HP / player.maxHP() <= .9) addButton(9, "Rest", getGame().camp.rest);
			if (model.time.hours >= 21 || model.time.hours < 6) {
				removeButton(0);
				removeButton(1);
				removeButton(2);
				removeButton(4);
				addButton(9, "Sleep", getGame().camp.doSleep);
			}
			//prisonRoomText(/Volumes/Disk Image/CoC_Prison/startUp.as);
			//prisonRestraintText();
			//prisonRoomChoices(_loc_2, _loc_3);
			//choices(_loc_3[1], _loc_2[1], _loc_3[2], _loc_2[2], _loc_3[3], _loc_2[3], _loc_3[4], _loc_2[4], _loc_3[5], _loc_2[5], _loc_3[6], _loc_2[6], _loc_3[7], _loc_2[7], _loc_3[8], _loc_2[8], _loc_3[9], _loc_2[9], _loc_3[10], _loc_2[10]);

		}
		
		private function hopelessPrisoner():void {
			outputText("\n\nThe muffled screams and moans of one of your fellow prisoners being punished penetrate the thick walls of your cell and echo in the air. The sound reminds you of the hopelessness of your situation.");
		}
		
		//Train physically
		private function trainMenu():void {
			hideMenus();
			clearOutput();
			outputText("You consider ways to use your time to improve your body.\n\n");
			menu();
			addButton(0, "Workout", trainWorkout, null, null, null, "Do some workout to improve your strength and toughness.");
			addButton(1, "Cardio", trainCardio, null, null, null, "Do some exercise to improve your toughness and speed.");
			addButton(14, "Back", prisonRoom);
		}
		
		private function trainWorkout():void {
			clearOutput();
			if(!prisonCanTrainWorkout())
			{
				doNext(playerMenu);
				return;
			}
			if(player.fatigue > 75)
			{
				outputText("<b>There's no way you could exercise right now - you're exhausted!</b>  ", false);
				doNext(playerMenu);
				return;
			}
			fatigue(25);
			outputText("You decide to pass the time with a workout regimen of pushups, situps, makeshift pull ups and other activities to improve your strength and endurance. ", false);
			if(player.str < 25)
			{
				outputText("You only manage a few reps of each, but even so, you manage to work up a good burn and a modest sweat.", false);
			}
			else
			{
				if (player.str < 40)
				{
					outputText("You push yourself a bit harder than you expected to.  It doesn't take you long to work up a sweat, but you push on through a variety of exercises that leave your body feeling sore and exhausted.", false);
				}
				else
				{
					if (player.str < 60)
					{
						outputText("You smile when you lose track of your reps while doing your fourth set of pushups.  With a start, you realize you're probably stronger now than Ingnam's master blacksmith, Ben.  Wow!  This realization fuels you to push yourself even harder, and you spend nearly two hours doing various strength-building exercises.", false);
					}
					else
					{
						if (player.str < 80) {
							outputText("You confidently push your way through set after set of strength-building exercises.  It doesn't take long for you to work up a lather of sweat and feel the burn thrumming through your slowly tiring form.  The workout takes about two hours, but you feel you made some good progress today.", false);
						}
						else
						{
							if (player.str < 90) outputText("You find yourself losing track of both reps and sets as you push yourself beyond your limits.  Standing up, you flex and marvel at yourself; you could probably arm wrestle a minotaur or two and come out victorious!", false);
							else outputText("There is really no challenge left to be had in your regimen, but you power your way through anyway.  By the time two hours have passed, you've worked up a good sweat, but without some other method of exercise you probably won't get any stronger.", false);
						}
					}
				}
			}			
			//Increase strength.
			if (player.str < 20) dynStats("str", 0.5);
			if (player.str < 40) dynStats("str", 0.4);
			if (player.str < 60) dynStats("str", 0.3);
			if (player.str < 80) dynStats("str", 0.2);
			if (player.str < 90) dynStats("str", 0.1);
			//Increase toughness
			if (player.tou < 20) dynStats("tou", 0.5);
			if (player.tou < 40) dynStats("tou", 0.4);
			if (player.tou < 60) dynStats("tou", 0.3);
			if (player.tou < 80) dynStats("tou", 0.2);
			if (player.tou < 90) dynStats("tou", 0.1);			
			//Increase muscles.
			if (player.tone < 60) outputText(player.modTone(85, 5 + rand(5)), false);
			else outputText(player.modTone(85, 1 + rand(4)), false);
			doNext(camp.returnToCampUseTwoHours);
		}
		private function trainCardio():void {
			clearOutput();
			if(!prisonCanTrainCardio())
			{
				doNext(playerMenu);
				return;
			}
			if(player.fatigue > 70)
			{
				outputText("<b>There's no way you could exercise right now - you're exhausted!</b>  ", false);
				doNext(playerMenu);
				return;
			}
			fatigue(30);
			outputText("You decide to pass the time with a cardio training regimen of jumping jacks, jogging in circles, and other calisthenics to improve your speed and endurance ", false);
			if(player.tou < 25)
			{
				outputText("but you get so winded you have to stop after a few minutes.  Determined to improve, you force yourself to jog a few more laps around the room.", false);
			}
			else
			{
				if(player.tou < 40)
				{
					outputText("but your performance isn't that great.  You nearly stop jogging a few times but manage to push through until you're completely exhausted.", false);
				}
				else
				{
					if(player.tou < 60)
					{
						outputText("and you do quite well.  You jog around for nearly an hour, working up a healthy lather of sweat, then run though an exhaustive regimen of calisthenics.  Even your " + player.legs() + " tingle and burn with exhaustion.", false);
					}
					else
					{
						if(player.tou < 80)
						{
							outputText("and it doesn't faze you in the slightest.  You lose count of the number of jumping jacks you've done and then run in circles for just as long, working yourself until you're soaked with sweat and fairly tired.", false);
						}
						else
						{
							if(player.tou < 90) outputText("and you have a terrific time.  You can keep yourself working out at a fever pitch the entire time, though you work up a huge amount of sweat in the process.", false);
							else outputText("and it barely challenges you.  No matter how many jumping jacks you do or circles you run around the room you never tire out.  Still, you do manage to burn a lot of calories.", false);
						}
					}
				}
			}			
			//Increase toughness
			if (player.tou < 20) dynStats("tou", 0.5);
			if (player.tou < 40) dynStats("tou", 0.4);
			if (player.tou < 60) dynStats("tou", 0.3);
			if (player.tou < 80) dynStats("tou", 0.2);
			if (player.tou < 90) dynStats("tou", 0.1);
			//Increase speed.
			if (player.spe < 20) dynStats("spe", 0.5);
			if (player.spe < 40) dynStats("spe", 0.4);
			if (player.spe < 60) dynStats("spe", 0.3);
			if (player.spe < 80) dynStats("spe", 0.2);
			if (player.spe < 90) dynStats("spe", 0.1);
			//Decrease thickness.
			if (player.thickness > 40) outputText(player.modThickness(1, 5 + rand(2)), false);
			else outputText(player.modThickness(1, 2 + rand(2)), false);
			doNext(camp.returnToCampUseTwoHours);
		}
		
		//Study mentally
		private function studyMenu():void {
			hideMenus();
			clearOutput();
			outputText("You consider ways to use your time to improve your mind.\n\n");
			menu();
			addButton(0, "Inner Peace", studyInnerPeace, null, null, null, "Calm your nerves and bring balance to your emotions to improve your self esteem.");
			addButton(1, "Determination", studyDetermination, null, null, null, "Improve your determination and hone your intelligence.");
			addButton(2, "Self Pity", studySelfpity, null, null, null, "Attempt to calm your nerves.");
			addButton(3, "Discipline", studyDiscipline, null, null, null, "Attempt to improve your determination and increase your obedience.");
			//addButton(5, "Manners", studyManners, null, null, null, "Not implemented yet.");
			addButton(14, "Back", prisonRoom);
		}
		
		private function studyInnerPeace():void {
			outputText("You turn your thoughts inward in an attempt to calm your nerves and bring balance to your emotions.");
			changeSelfEsteem(5);
			doNext(camp.returnToCampUseTwoHours);
		}
		
		private function studyDetermination():void {
			outputText("You turn your thoughts inward in an attempt to improve your determination and strength of will.");
			changeObey(-5, true);
			//Increase intelligence.
			if (player.inte < 20) dynStats("inte", 0.5);
			if (player.inte < 40) dynStats("inte", 0.4);
			if (player.inte < 60) dynStats("inte", 0.3);
			if (player.inte < 80) dynStats("inte", 0.2);
			if (player.inte < 90) dynStats("inte", 0.1);
			doNext(camp.returnToCampUseTwoHours);
		}
		
		private function studySelfpity():void {
			outputText("You turn your thoughts inward in an attempt to calm your nerves and bring balance to your emotions, but end up wallowing in self pity over your hopeless situation instead.");
			changeSelfEsteem(-5);
			doNext(camp.returnToCampUseTwoHours);
		}
		
		private function studyDiscipline():void {
			outputText("You turn your thoughts inward in an attempt to improve your determination, but end up daydreaming about how pleasant it is to be told what to do rather than having to think for yourself.");
			changeObey(5, true);
			doNext(camp.returnToCampUseTwoHours);
		}
		
		private function studyManners():void {
			
		}
		
		private function cleanCell():void {
			clearOutput();
			outputText("You decide to spend some time cleaning your cell, fearing what your Mistress might do if you let it get too messy.");
			flags[kFLAGS.PRISON_DIRT_LEVEL] -= 25;
			if (flags[kFLAGS.PRISON_DIRT_LEVEL] < 1) flags[kFLAGS.PRISON_DIRT_LEVEL] = 1;
			doNext(camp.returnToCampUseTwoHours);
		}
		private function placeholderEscape():void {
			clearOutput();
			outputText("Since the prisoner mod is not finished, you will return to your camp.");
			if (player.findStatusAffect(StatusAffects.PrisonRestraints) >= 0) player.removeStatusAffect(StatusAffects.PrisonRestraints);
			flags[kFLAGS.IN_PRISON] = 0;
			doNext(camp.returnToCampUseOneHour);
		}
	}

}