//Prisoner Mod WIP
package classes.Scenes.Places 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.*;
	
	import coc.view.MainView;
	
	public class Prison extends BaseContent
	{
		
		public function Prison() 
		{
		}
		
		//Stats changes and modules
		public function changeSelfEsteem(amount:int = 0):void {
			flags[kFLAGS.PRISON_STAT_SELFESTEEM] += amount;
			if (flags[kFLAGS.PRISON_STAT_SELFESTEEM] > 100) flags[kFLAGS.PRISON_STAT_SELFESTEEM] = 100;
			if (flags[kFLAGS.PRISON_STAT_SELFESTEEM] < 0) flags[kFLAGS.PRISON_STAT_SELFESTEEM] = 0;
		}
		public function changeWillpower(amount:int = 0):void {
			flags[kFLAGS.PRISON_STAT_WILLPOWER] += amount;
			if (flags[kFLAGS.PRISON_STAT_WILLPOWER] > 100) flags[kFLAGS.PRISON_STAT_WILLPOWER] = 100;
			if (flags[kFLAGS.PRISON_STAT_WILLPOWER] < 0) flags[kFLAGS.PRISON_STAT_WILLPOWER] = 0;
		}
		public function changeObedience(amount:int = 0):void {
			flags[kFLAGS.PRISON_STAT_OBEDIENCE] += amount;
			if (flags[kFLAGS.PRISON_STAT_OBEDIENCE] > 100) flags[kFLAGS.PRISON_STAT_OBEDIENCE] = 100;
			if (flags[kFLAGS.PRISON_STAT_OBEDIENCE] < 0) flags[kFLAGS.PRISON_STAT_OBEDIENCE] = 0;
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
		/*public function prisonCanUseItem(newGameText:String) : Boolean
		{
			this.inPrison;
			if(this.inPrison && itemIsFood(newGameText) && !prisonCanEat())
			{
				return false;
			}
			this.inPrison;
			if(this.inPrison && !itemIsFood(newGameText) && !prisonCanEquip())
			{
				return false;
			}
			return true;
		}
		public function prisonCanEat() : Boolean
		{
			if(!(player.statusAffectv4("prisonRestraint") > 0 && player.statusAffectv4("prisonRestraint") == 4))
			{
				outputText("Because your mouth is gagged you are unable to eat at this time.", true);
				return false;
			}
			return true;
		}
		public function prisonCanEquip() : Boolean
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
		
		private function prisonIntro():void {
			clearOutput();
			outputText("While you were unconscious you were captured by slavers, stripped of your items and equipment, and thrown into a locked cell.");
			outputText("\n\nShortly after you wake, the door opens and a captivating omnibus enters the room. While her physique is impressive -- long, shapely legs in laced, thigh-high, spike-heeled leather boots; a powerful, athletic but curvy frame; a pair of perky C-cups spilling out of a tight-fitting leather corset -- your eyes focus on her charismatic face. She is possessed of exotic and delicate features, enticingly framed by side swept bangs that have escaped the loosely bound ponytail atop her head. The striking contrast of her fire red hair against her smooth olive skin completes the effect, suggesting that her  countenance could shift from intoxicatingly arousing to overwhelmingly intimidating to soft and comforting at any moment.");
			outputText("\n\nShe carries little evidence of demonic taint besides a pair of cute, curled horns sprouting from her temples and an agile, spade-tipped tail that flicks about above her muscular, heart-shaped ass. Her preternatural aura of poise, charm, and command, however, betray that she must be a very powerful demon indeed. She looks you over appraisingly while absentmindedly trailing her lithe fingers up and down her semi-erect but rather imposing cock. You notice that she wears long, laced leather sleeves, covering her shoulder to wrist. They strap around her middle fingers, but leave her hands conspicuously ungloved. It would seem that she prefers her subjects to feel her soft, silky skin when she touches them.");
			outputText("\n\nAfter an uncomfortable period of being examined, you watch the demon's violet, almond eyes finally settle -- on your own. Her gaze is beyond piercing, seeming to both physically and mentally enfeeble you. You find yourself unable to escape it, and your fortitude steadily wanes. The moment begins to extend into a dense, stifling eternity, when suddenly -- she speaks. \"<i>Hello, Champion.</i>\" To your almost embarrassing surprise, her voice is every bit as beautiful and compelling as her face, and you barely notice that her eyes have moved on.  \"<i>I am your new owner. My name is Elly, but you will call me Mistress.</i>\" She says it with impartial conviction, as if it were a trivial matter of fact, and for an eerie moment, your mind absorbs it as truth. ");
			outputText("\n\n\"<i>By now, any number of monsters and demons must have tried to make you their property, so you no doubt assume that my intentions are the same. In one sense they surely are. The others wanted to own your body, as I now do.</i>\" She emphasizes this point by kicking you onto your back and resting her spiked boot on your chest. \"<i>The difference is that where they aim to merely destroy your mind so they can claim your body, I will instead own your mind and you will willingly give me your body. The process of you learning that you are my property will be slow, subtle, and humiliating... but when it is complete, you will beg me to let you experience it again.</i>\" Smiling wickedly, she slides her foot down your torso and begins using her boot covered toe to gently caress your ");
			if (player.hasCock()) outputText(player.cockDescript());
			if (player.hasCock() && player.hasVagina()) outputText(" and ");
			if (player.hasVagina()) outputText(player.vaginaDescript());
			if (player.gender == 0) outputText("groin");
			outputText(".");
			outputText("\n\n\"<i>But you will learn.</i>\"");
			outputText("\n\n\"<i>You will dream about every time one of my guards taught you a lesson in obedience by raping you, and you will wake up masturbating.</i>\"");
			outputText("\n\n\"<i>You will salivate at the very thought of licking a pool of jizz off your cell floor, and consider every drop of cum deposited in or on your body to be a gift you are unworthy of.</i>\"");
			outputText("\n\n\"<i>You will feel jealousy every time you hear the screams of another slave being taught their place. You will envy the fact that they will soon enjoy the wonderful epiphany of understanding what they really are. And, quite likely, you will stage fake rebellions simply to enjoy the rush of having your bad behavior corrected.</i>\"");
			outputText("\n\n\"<i>Finally, you will think back on the times when you genuinely tried to resist your true nature -- a pliable, obedient, servile piece of flesh whose only reason to exist is to entertain and please others -- and you will feel grateful that your kind Mistress found you and saved you from your foolish ways.<i>\"");
			outputText("\n\nShe emphasizes this final point by turning and walking to the door, then adding, almost as an afterthought, \"<i>Please do resist all you like, by the way, and even escape if you can. Don't worry, it usually doesn't take long catch you again, and more often than not you'll just come back to me on your own. In any case, your resistance creates useful, teachable moments. You can only learn how wrong you are about yourself if you have the opportunity to have your behaviors corrected, after all.</i>\"");
			outputText("\n\n\"<i>Here, a special meal to help you get comfortable. Remember how good it tastes, since you'll need to earn it in the future.</i>\" She throws a pitiful looking loaf of bread on the floor next to you, and abruptly leaves you alone in your cell. You find yourself unsettled by how long Mistress Elly's arresting presence lingers in your mind, and by the depth of the effect her words seemed to have on your psyche.\n\n");
			inventory.takeItem(consumables.P_BREAD, prisonRoom);
		}
		
		public function prisonRoom():void {
			clearOutput();
			outputText("You are in a dimly lit but spacious cell. However, the size of the room is little comfort to you as it is filled with all manner of restraints and torture devices. Eylets, metal rings, bars and hooks are scattered around the ceiling, floor and walls providing a near endless variety of ways to restrain a person. A wooden stockade is installed in the center of the room, a whipping post and a rack stand in one corner, and in another there is a large and ominous floor to ceiling stone box. Mercifully, fresh air and sunlight can enter the room through narrow slit windows opposite the door.\n\n");
			if (flags[kFLAGS.PRISON_DOOR_UNLOCKED] == 0) outputText("The door is locked securely.\n");
			else outputText("The door is unlocked.\n");
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
					eventParser(41);
					return;
				}
				eventParser(11);
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
			if (player.lust >= 30) {
				if (player.lust >= 100) {
					outputText("\n\n<b>You are debilitatingly aroused, and can think of doing nothing other than masturbating.</b>", false);
					removeButton(0);
					removeButton(4);
				}
				addButton(8, "Masturbate", eventParser, 10);
				if (((player.findPerk(PerkLib.HistoryReligious) >= 0 && player.cor <= 66) || (player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < 10)) && !(player.findStatusAffect(StatusAffects.Exgartuan) >= 0 && player.statusAffectv2(StatusAffects.Exgartuan) == 0) || flags[kFLAGS.SFW_MODE] >= 1) addButton(8, "Meditate", eventParser, 10);
			}
			//Show wait/rest/sleep depending on conditions.
			addButton(9, "Wait", eventParser, 40);
			if (player.fatigue > 40 || player.HP / player.maxHP() <= .9) addButton(9, "Rest", eventParser, 11);
			if (model.time.hours >= 21 || model.time.hours < 6) addButton(9, "Sleep", eventParser, 41);
			hideUpDown();
			menu();
			addButton(0, "Train", trainMenu);
			addButton(1, "Study", studyMenu);
			addButton(2, "Restraints", eventParser, 9999, null, null, "Not implemented yet.");
			addButton(3, "Clean", eventParser, 9999, null, null, "Not implemented yet.");
			addButton(4, "Escape", placeholderEscape);
			addButton(7, "Inventory", inventory.inventoryMenu);
			addButton(8, "Masturbate", eventParser, 10);
			addButton(9, "Wait", eventParser, 40);
			if (player.fatigue > 40 || player.HP / player.maxHP() <= .9) addButton(9, "Rest", eventParser, 11);
			if (model.time.hours >= 21 || model.time.hours < 6) {
				removeButton(0);
				removeButton(1);
				removeButton(2);
				removeButton(4);
				addButton(9, "Sleep", eventParser, 41);
			}
			//prisonRoomText(/Volumes/Disk Image/CoC_Prison/startUp.as);
			//prisonRestraintText();
			//prisonRoomChoices(_loc_2, _loc_3);
			//choices(_loc_3[1], _loc_2[1], _loc_3[2], _loc_2[2], _loc_3[3], _loc_2[3], _loc_3[4], _loc_2[4], _loc_3[5], _loc_2[5], _loc_3[6], _loc_2[6], _loc_3[7], _loc_2[7], _loc_3[8], _loc_2[8], _loc_3[9], _loc_2[9], _loc_3[10], _loc_2[10]);

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
				doNext(1);
				return;
			}
			if(player.fatigue > 75)
			{
				outputText("<b>There's no way you could exercise right now - you're exhausted!</b>  ", false);
				doNext(1);
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
				doNext(1);
				return;
			}
			if(player.fatigue > 70)
			{
				outputText("<b>There's no way you could exercise right now - you're exhausted!</b>  ", false);
				doNext(1);
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
			addButton(2, "Self Pity", eventParser, 9999, null, null, "Not implemented yet.");
			addButton(3, "Discipline", eventParser, 9999, null, null, "Not implemented yet.");
			addButton(4, "Manners", eventParser, 9999, null, null, "Not implemented yet.");
			addButton(14, "Back", prisonRoom);
		}
		
		private function studyInnerPeace():void {
			outputText("You turn your thoughts inward in an attempt to calm your nerves and bring balance to your emotions.");
			changeSelfEsteem(5);
			doNext(camp.returnToCampUseTwoHours);
		}
		
		private function studyDetermination():void {
			outputText("You turn your thoughts inward in an attempt to improve your determination and strength of will.");
			//Increase intelligence.
			if (player.inte < 20) dynStats("inte", 0.5);
			if (player.inte < 40) dynStats("inte", 0.4);
			if (player.inte < 60) dynStats("inte", 0.3);
			if (player.inte < 80) dynStats("inte", 0.2);
			if (player.inte < 90) dynStats("inte", 0.1);
			doNext(camp.returnToCampUseTwoHours);
		}
		
		private function placeholderEscape():void {
			outputText("Since the prisoner mod is not finished, you will return to your camp.");
			if (player.findStatusAffect(StatusAffects.PrisonRestraints) >= 0) player.removeStatusAffect(StatusAffects.PrisonRestraints);
			flags[kFLAGS.IN_PRISON] = 0;
			doNext(camp.returnToCampUseOneHour);
		}
	}

}