//Prisoner Mod WIP
package classes.Scenes.Places 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	import classes.Scenes.Places.Prison.*
	
	import coc.view.MainView;
	
	public class Prison extends BaseContent implements TimeAwareInterface
	{
		//Link to class files.
		public var prisonLetter:PrisonLetters = new PrisonLetters();
		//NPCs
		public var prisonCaptor:PrisonCaptor = new PrisonCaptor();
		public var prisonGuard:PrisonGuard = new PrisonGuard();
		public var ellyScene:EllyScene = new EllyScene();
		public var scruffyScene:ScruffyScene = new ScruffyScene();
		public var billieScene:BillieScene = new BillieScene();
		//Punishments & Trainings
		public var punishments:Punishments = new Punishments();
		public var trainingPet:TrainingPet = new TrainingPet();
		public var trainingFeed:TrainingFeeding = new TrainingFeeding();
		
		//Variables
		public var prisonCombat:Boolean = false;
		public var prisonCombatAutoLose:Boolean = false;
		public var prisonCombatWinEvent:Function = null;
		public var prisonCombatLoseEvent:Function = null;
		
		public var prisonItemEventCheck:Boolean = false;

		//Random events cooldowns
		private var heardPrisonerScreamCooldown:int = 6;
		private var randomCooldownRoomCheck:int = 6;
		private var randomCooldownPunishment:int = 12;
		private var randomCooldownRestraintCheck:int = 12;
		
		//Training
		private var randomCooldownFeed:int = 4;
		private var randomCooldownPet:int = 10;
		private var randomCooldownPetDream:int = 4;
		
		//NPCs
		public var randomCooldownScruffy:int = 10;
		private var randomCooldownBillie:int = 10;
		private var randomCooldownGuard:int = 12;
		
		public function get inPrison():Boolean { return flags[kFLAGS.IN_PRISON] > 0; }
		
		public function Prison() {
			CoC.timeAwareClassAdd(this);
		}
		
		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			var needNext:Boolean = false;
			//Show events
			if (flags[kFLAGS.IN_PRISON] > 0) {
				//Increment dirtiness level
				if (player.statusEffectv2(StatusEffects.PrisonCaptorEllyStatus) < 100) player.addStatusValue(StatusEffects.PrisonCaptorEllyStatus, 2, 1);
				//Tick cooldowns
				if (flags[kFLAGS.PRISON_EVENT_TIMEOUT] > 0) flags[kFLAGS.PRISON_EVENT_TIMEOUT]--;
				if (heardPrisonerScreamCooldown > 0) heardPrisonerScreamCooldown--;
				if (randomCooldownRoomCheck > 0) randomCooldownRoomCheck--;
				if (randomCooldownPunishment > 0) randomCooldownPunishment--;
				if (randomCooldownRestraintCheck > 0) randomCooldownRestraintCheck--;
				
				if (randomCooldownBillie > 0) randomCooldownBillie--;
				if (randomCooldownScruffy > 0) randomCooldownScruffy--;
				if (randomCooldownGuard > 0) randomCooldownGuard--;
				
				if (randomCooldownFeed > 0) randomCooldownFeed--;
				if (randomCooldownPet > 0) randomCooldownPet--;
				if (randomCooldownPetDream > 0) randomCooldownPetDream--;
				
				if (player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) > 0) player.addStatusValue(StatusEffects.PrisonCaptorEllyStatus, 3, -1);
				//Fire events
				if (heardPrisonerScreamCooldown <= 0 && rand(10) == 0) {
					heardPrisonerScreamCooldown = 9 + rand(4);
					prisonCaptorRandomEventSounds();
					needNext = true;
					return needNext;
				}
				if ((flags[kFLAGS.PRISON_DIRT_ENABLED] > 0 && model.time.hours == 16 && randomCooldownRoomCheck <= 0) || (player.statusEffectv2(StatusEffects.PrisonCaptorEllyStatus) >= 50 && flags[kFLAGS.PRISON_DIRT_ENABLED] == 0)) {
					randomCooldownRoomCheck = 6 + rand(18);
					prisonCaptorRandomEventCleaningCheck();
					needNext = true;
					return needNext;
				}
				if (randomCooldownRestraintCheck <= 0 && rand(10) == 0) {
					randomCooldownRestraintCheck = 4 + rand(8);
					prisonCaptorRestraintCheckEvent();
					needNext = true;
					return needNext;
				}
				prisonCaptorWaitEvents();
			}
			if (trainingFeed.prisonCaptorFeedingQuestTrainingExists()) {
				//Decrement quest timer
				if (player.statusEffectv2(StatusEffects.PrisonCaptorEllyQuest) > 0) player.addStatusValue(StatusEffects.PrisonCaptorEllyQuest, 2, -1);
			}
			prisonCombatAutoLose = false;
			//Tick
			return needNext;
		}
		
		public function timeChangeLarge():Boolean {
			return prisonCaptorRoomEvents();
			//return false;
		}
		//End of Interface Implementation
		
		//------------
		// STATS
		//------------
		/**
		 * Change the player's self-esteem.
		 * @param	amount How much to add or deduct.
		 */
		public function changeEsteem(amount:int = 0, display:Boolean = false):void {
			trace("Changing esteem");
			var oldEsteem:Number = player.esteem;
			player.esteem += amount;
			if (player.esteem > 100) player.esteem = 100;
			if (player.esteem < 0) player.esteem = 0;
			//Bring up message.
			if (display)
			{
				if (oldEsteem >= 15 && player.esteem < 15)
				{
					outputText("\n<b>Your self-esteem is now extremely low. Your ability to recover your willpower is greatly diminished, your complete lack of self-worth makes you easily swayed by the criticisms and demands of others, and your ",false);
					if (player.cor < 20) outputText("rare");
					else if (player.cor >= 20 && player.cor < 40) outputText("occasional", false);
					else if (player.cor >= 40 && player.cor < 60) outputText("frequent", false);
					else if (player.cor >= 60 && player.cor < 80) outputText("near constant", false);
					else if (player.cor >= 80) outputText("constant", false);
					outputText(" corrupt thoughts inspire you to give up your pride and be more subservient to those who would dominate you.</b>\n",false);
				}
				if (oldEsteem >= 40 && player.esteem < 40 || oldEsteem < 15 && player.esteem >= 15)
				{
					outputText("\n<b>Your self-esteem is now low. Your ability to recover your willpower is somewhat diminished, your crumbling sense of self-worth makes you more susceptible to the criticisms and demands of others, and your ",false);
					if (player.cor < 20) outputText("rare");
					else if (player.cor >= 20 && player.cor < 40) outputText("occasional", false);
					else if (player.cor >= 40 && player.cor < 60) outputText("frequent", false);
					else if (player.cor >= 60 && player.cor < 80) outputText("near constant", false);
					else if (player.cor >= 80) outputText("constant", false);
					outputText(" corrupt thoughts increasingly linger on how good it feels to obey the directions of those who would dominate you.</b>\n",false);
				}
				if (oldEsteem >= 60 && player.esteem < 60 || oldEsteem < 40 && player.esteem >= 40)
				{
					outputText("\n<b>Your self-esteem is now normal. You recover your willpower at an average rate and your reactions to the criticisms and demands of others are reasonable.</b>\n",false);
				}
				if (oldEsteem >= 85 && player.esteem < 85 || oldEsteem < 60 && player.esteem >= 60)
				{
					outputText("\n<b>Your self-esteem is now high. Your ability to recover your willpower is somewhat increased, your strong sense of self-worth makes it easy to shrug off the criticisms and demands of others, and your intelligence slowly works to undo any submissive tendencies you may have.</b>\n",false);
				}
				if (oldEsteem < 85 && player.esteem >= 85)
				{
					outputText("\n<b>Your self-esteem is now very high. Your ability to recover your willpower is greatly increaed, your powerful sense of self-worth makes ignoring the criticisms and demands of others second nature, and your intelligence greatly aids you in the process of unlearning any submissive tendencies you may have.</b>\n",false);
				}
			}
			if (player.esteem > oldEsteem) showStatUp("esteem");
			if (player.esteem < oldEsteem) showStatDown("esteem");
			dynStats("lus", 0, "resisted", false);
			statScreenRefresh();
		}
		/**
		 * Change the player's willpower.
		 * @param	amount How much to add or deduct.
		 */
		public function changeWill(amount:int = 0, display:Boolean = false):void {
			var oldWill:Number = player.will;
			player.will += amount;
			if (player.will > 100) player.will = 100;
			if (player.will < 0) player.will = 0;
			if (player.will > oldWill) showStatUp("will");
			if (player.will < oldWill) showStatDown("will");
			dynStats("lus", 0, "resisted", false);
			statScreenRefresh();
		}
		/**
		 * Change the player's obedience.
		 * @param	amount How much to add or deduct.
		 */
		public function changeObey(amount:int = 0, display:Boolean = false):void {
			var oldObey:Number = player.obey;
			player.obey += amount;
			//Constrain values.
			if (player.obey > 100) player.obey = 100;
			if (player.obey < 0) player.obey = 0;
			if (player.obey > 50 && player.obeySoftCap == true) player.obey = 50;
			//Bring up message.
			if (display)
			{
				if (oldObey >= 10 && player.obey < 10)
				{
					outputText("\n<b>You now have a strong ability to resist the demands of those who would dominate you.</b>\n",false);
				}
				if (oldObey >= 25 && player.obey < 25 || oldObey < 10 && player.obey >= 10)
				{
					outputText("\n<b>Your ability to resist the demands of those who would dominate you is now weakened. While you still have a strong innate distaste for being ordered around, you are are finding it hard to see the point in resisting the smaller things.  It's better to conserve your willpower to fight against the truly heinous and demeaning commands... isn't it?</b>\n",false);
				}
				if (oldObey >= 45 && player.obey < 45 || oldObey < 25 && player.obey >= 25)
				{
					outputText("\n<b>Your ability to resist the demands of those who would dominate you is now all but broken. The concept of being subservient to another being is still abhorrent to you, but in practice you are finding it far easier to swallow your pride and do as you are told than to face the consequences of resisting.</b>\n",false);
				}
				if (oldObey >= 70 && player.obey < 70 || oldObey < 45 && player.obey >= 45)
				{
					outputText("\n<b>Your ability to resist the demands of those who would dominate you is now essentially nonexistent. It still brings you great shame to give up agency over your actions, but you find yourself starting to crave that shame. While you manage to exert the willpower to resist an order from time to time, you are begining to wonder if you are doing so out of a genuine desire for self determinance, or simply because the experience of being punished is becoming exciting to you.</b>\n",false);
				}
				if (oldObey >= 90 && player.obey < 90 || oldObey < 70 && player.obey >= 70)
				{
					outputText("\n<b>Your ability to resist the demands of those who would dominate you is now a faint memory. You understand that other people have the ability to determine their own fate, but you instead relish the sweet, shameful, all consuming simplicity of obedience. While you can manage to exert the willpower to resist an order from time to time, you know it is only so that you can experience the thrill of being put back in your rightful place.</b>\n",false);
				}
				if (oldObey < 90 && player.obey >= 90)
				{
					outputText("\n<b>The ability to resist the demands of those who would dominate you is now a foreign concept. You are a creature of submission and obedience that exists only to serve at the whim of your betters. On rare occasion you may exert the willpower to resist an order, but you only do so because you fear being forgotten by your masters. You crave the overwhelming rush of joy that comes when they punish you, reinforcing the shameful (delightful?) knowledge that you are nothing more than property, and that pleasure comes from being used.</b>\n",false);
				}
			}
			if (player.obey > oldObey) showStatUp("obey");
			if (player.obey < oldObey) showStatDown("obey");
			dynStats("lus", 0, "resisted", false);
			statScreenRefresh();
		}
		
		public function prisonWillCostDescript(baseVal:Number):String
		{
			return "(requires " + Math.round(prisonWillCost(baseVal)) + " of your " + Math.round(player.will) + " willpower)";
			//return "(requires " + Math.round(prisonWillCost(baseVal)) + "; you have " + Math.round(player.will) + "/100 willpower)";
		}
		
		public function prisonWillCost(baseVal:Number):Number
		{
			var retVal:int = 0;
			retVal = baseVal + player.obey * 0.015;
			retVal = retVal + player.cor * 0.01;
			if (player.esteem >= 50)
			{
				retVal = retVal - (player.esteem - 50) * 0.05;
			}
			else if (player.esteem < 50)
			{
				retVal = retVal - (player.esteem - 50) * 0.02;
			}
			
			retVal = retVal - player.inte * 0.005;
			retVal = retVal - player.tou * 0.005;
			return retVal;
		}
		
		//------------
		// RESTRAINTS
		//------------
		public function prisonRestraintLevel():Number
		{
			var restraintLevel:int = 0;
			if (player.statusEffectv4(StatusEffects.PrisonRestraints) > 0)
			{
				restraintLevel++;
			}
			else if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 0)
			{
				restraintLevel = restraintLevel + player.statusEffectv2(StatusEffects.PrisonRestraints);
			}
			else if (player.statusEffectv3(StatusEffects.PrisonRestraints) > 0)
			{
				restraintLevel = restraintLevel + player.statusEffectv3(StatusEffects.PrisonRestraints);
			}
			
			return restraintLevel;
		}
		
		public function prisonRestraintMouthLevel():Number
		{
			var restraintLevel:int = 0;
			restraintLevel = player.statusEffectv4(StatusEffects.PrisonRestraints);
			return restraintLevel;
		}
		
		public function prisonRestraintBodyLevel():Number
		{
			var restraintLevel:int = 0;
			restraintLevel = player.statusEffectv2(StatusEffects.PrisonRestraints);
			return restraintLevel;
		}
		
		public function prisonRestraintArmLevel():Number
		{
			var restraintLevel:int = 0;
			restraintLevel = player.statusEffectv2(StatusEffects.PrisonRestraints);
			return restraintLevel;
		}
		
		public function prisonRestraintReduction(reduceLevels:Number = 1):void
		{
			while(reduceLevels > 0)
			{
				if (player.statusEffectv4(StatusEffects.PrisonRestraints) > 0)
				{
					player.changeStatusValue(StatusEffects.PrisonRestraints,4,0);
				}
				else if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 1)
				{
					player.changeStatusValue(StatusEffects.PrisonRestraints,2,1);
				}
				else if (player.statusEffectv3(StatusEffects.PrisonRestraints) > 0)
				{
					player.changeStatusValue(StatusEffects.PrisonRestraints,3,0);
				}
				else if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 0)
				{
					player.changeStatusValue(StatusEffects.PrisonRestraints,2,0);
				}
				reduceLevels--;
			}
		}
		
		public function prisonRestraintText(longOutput:Boolean = false):void
		{
			//outputText("\n\n", false);
			/*if (prisonCaptor.restraintDescriptionsV1[player.statusEffectv1(StatusEffects.PrisonRestraints)])
			{
				outputText(prisonCaptor.restraintDescriptionsV1[player.statusEffectv1(StatusEffects.PrisonRestraints)],false);
			}
			else
			{
				outputText(prisonCaptor.restraintDescriptionsV1[1],false);
			}*/
			//Locked door
			if (flags[kFLAGS.PRISON_DOOR_UNLOCKED] == 0) {
				outputText("\n\nThe door is locked securely.");
			}
			//Body restraints
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 0) {
				outputText("\n\n");
				if (player.statusEffectv2(StatusEffects.PrisonRestraints) == 1) {
					outputText("Your legs are fettered and chained securely to the wall.");
				}
				else if (player.statusEffectv2(StatusEffects.PrisonRestraints) >= 2) {
					outputText("You are hogtied and chained to the wall. ");
					if (longOutput) {
						outputText(" You find this demoralizing and fatiguing");
						if (player.cor > 40 || player.obey > 45) outputText(", but also arousing",false);
						outputText(".", false);
					}
				}
			}
			//Legs restraints
			if (player.statusEffectv3(StatusEffects.PrisonRestraints) > 0) {
				outputText("\n\n");
				outputText("Your arms are bound behind your back.");
			}
			//Mouth restraints
			if (player.statusEffectv4(StatusEffects.PrisonRestraints) > 0) {
				outputText("\n\n");
				outputText("Your jaw is forced open by the large ring gag that is locked and fastened around your head. Your tongue lolls about obscenely, but at least you can still eat and drink.");
				if (longOutput) {
					if (player.statusEffectv4(StatusEffects.PrisonRestraints) == 2)
					{
						outputText(" You find this demoralizing",false);
						if (player.cor > 40 || player.obey > 45)
						{
							outputText(", but also arousing",false);
						}
						outputText(".",false);
					}
					if (player.statusEffectv4(StatusEffects.PrisonRestraints) > 2)
					{
						outputText(" You find this exceptionally demoralizing and fatiguing",false);
						if (player.cor > 40 || player.obey > 45)
						{
							outputText(", but also very arousing",false);
						}
						outputText(".",false);
					}
				}
			}
			//OLD CODE
			/*if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 0)
			{
				if (longOutput)
				{
					outputText("\n",false);
				}
				if (prisonCaptor.restraintDescriptionsV2[player.statusEffectv2(StatusEffects.PrisonRestraints)])
				{
					outputText("\n" + prisonCaptor.restraintDescriptionsV2[player.statusEffectv2(StatusEffects.PrisonRestraints)],false);
				}
				else
				{
					outputText("\n" + prisonCaptor.restraintDescriptionsV2[1],false);
				}
			}
			if ((longOutput) && player.statusEffectv2(StatusEffects.PrisonRestraints) > 1)
			{
				outputText(" You find this demoralizing and fatiguing",false);
				if (player.cor > 40 || player.obey > 45)
				{
					outputText(", but also arousing",false);
				}
				outputText(".",false);
			}
			if (player.statusEffectv3(StatusEffects.PrisonRestraints) > 0)
			{
				if (longOutput)
				{
					outputText("\n",false);
				}
				if (prisonCaptor.restraintDescriptionsV3[player.statusEffectv3(StatusEffects.PrisonRestraints)])
				{
					outputText("\n" + prisonCaptor.restraintDescriptionsV3[player.statusEffectv3(StatusEffects.PrisonRestraints)],false);
				}
				else
				{
					outputText("\n" + prisonCaptor.restraintDescriptionsV3[1],false);
				}
			}
			if (player.statusEffectv4(StatusEffects.PrisonRestraints) > 0)
			{
				if (longOutput)
				{
					outputText("\n",false);
				}
				if (prisonCaptor.restraintDescriptionsV4[player.statusEffectv4(StatusEffects.PrisonRestraints)])
				{
					outputText("\n" + prisonCaptor.restraintDescriptionsV4[player.statusEffectv4(StatusEffects.PrisonRestraints)],false);
				}
				else
				{
					outputText("\n" + prisonCaptor.restraintDescriptionsV4[1],false);
				}
			}
			if ((longOutput) && player.statusEffectv4(StatusEffects.PrisonRestraints) == 2)
			{
				outputText(" You find this demoralizing",false);
				if (player.cor > 40 || player.obey > 45)
				{
					outputText(", but also arousing",false);
				}
				outputText(".",false);
			}
			if ((longOutput) && player.statusEffectv4(StatusEffects.PrisonRestraints) > 2)
			{
				outputText(" You find this exceptionally demoralizing and fatiguing",false);
				if (player.cor > 40 || player.obey > 45)
				{
					outputText(", but also very arousing",false);
				}
				outputText(".",false);
			}*/
		}
		
		public function prisonIsRestrained():Boolean
		{
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 0 || player.statusEffectv3(StatusEffects.PrisonRestraints) > 0 || player.statusEffectv3(StatusEffects.PrisonRestraints) > 0)
			{
				return true;
			}
			return false;
		}
		
		public function prisonCanMasturbate(verbose:Boolean = true):Boolean
		{
			if (player.statusEffectv3(StatusEffects.PrisonRestraints) > 1 || player.statusEffectv2(StatusEffects.PrisonRestraints) > 1)
			{
				if (verbose)
				{
					outputText("Because of the way you are restrained you are unable to masturbate.",true);
				}
				return false;
			}
			return true;
		}
		
		public function prisonCanRestraintBreakDoor(verbose:Boolean = true):Boolean
		{
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 0)
			{
				if (verbose)
				{
					outputText("Because of the way you are restrained you are unable to reach the door.",true);
				}
				return false;
			}
			return true;
		}
		
		public function prisonCanRestraintBreakMouth(verbose:Boolean = true):Boolean
		{
			if (player.statusEffectv3(StatusEffects.PrisonRestraints) > 1 || player.statusEffectv2(StatusEffects.PrisonRestraints) > 0)
			{
				if (verbose)
				{
					outputText("Because of the way you are restrained you would be unable to reach your gag.",true);
				}
				return false;
			}
			return true;
		}
		
		public function prisonRestraintsMenu():void
		{
			clearOutput();
			if (player.statusEffectv1(StatusEffects.PrisonRestraints) == 0 && player.statusEffectv2(StatusEffects.PrisonRestraints) == 0 && player.statusEffectv3(StatusEffects.PrisonRestraints) == 0 && player.statusEffectv4(StatusEffects.PrisonRestraints) == 0)
			{
				outputText("You aren't restrained in any way.",false);
			}
			else
			{
				outputText("You consider whether you might be able to escape your restraints.");
			}
			prisonRestraintText(true);
			if (player.statusEffectv1(StatusEffects.PrisonRestraints) > 0 || player.statusEffectv2(StatusEffects.PrisonRestraints) > 0 || player.statusEffectv3(StatusEffects.PrisonRestraints) > 0 || player.statusEffectv4(StatusEffects.PrisonRestraints) > 0)
			{
				outputText("\n\nDo you want to attempt to free yourself from any of your restraints? " + prisonWillCostDescript(10) + "\n\n");
			}
			//prisonRestraintChoices(choiceEvents, choiceTexts);
			menu();
			if (player.statusEffectv1(StatusEffects.PrisonRestraints) > 0) addButton(0, "Door", doPrisonRestraintsDoor);
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 0) addButton(1, "Body", doPrisonRestraintsBody);
			if (player.statusEffectv3(StatusEffects.PrisonRestraints) > 0) addButton(2, "Arms", doPrisonRestraintsArms);
			if (player.statusEffectv4(StatusEffects.PrisonRestraints) > 0) addButton(3, "Mouth", doPrisonRestraintsMouth);
			addButton(14, "Back", playerMenu);
		}
		
		//Check restraints
		public function doPrisonRestraintsDoor():void
		{
			var nextNeeded:* = false;
			if (!debug && !prisonCanRestraintBreakDoor())
			{
				doNext(playerMenu);
				return;
			}
			nextNeeded = true;
			outputText("You examine the door.\n\n",true);
			if (player.will > prisonWillCost(10))
			{
				changeWill(-prisonWillCost(10));
				nextNeeded = prisonRestraintBreakDoor();
			}
			else
			{
				outputText("\n\nTry as you might you can't work up the resolve to tamper with it.",false);
			}
			
			if (nextNeeded)
			{
				doNext(camp.returnToCampUseOneHour);
			}
		}
		
		public function doPrisonRestraintsBody():void
		{
			var nextNeeded:* = false;
			nextNeeded = true;
			outputText("You inspect the restraints on your body.\n\n",true);
			if (debug)
			{
				if (player.statusEffectv2(StatusEffects.PrisonRestraints) >= 2)
				{
					player.changeStatusValue(StatusEffects.PrisonRestraints,2,0);
				}
				else
				{
					player.changeStatusValue(StatusEffects.PrisonRestraints,2,player.statusEffectv2(StatusEffects.PrisonRestraints) + 1);
				}
			}
			else if (player.will > prisonWillCost(10))
			{
				changeWill(-prisonWillCost(10));
				nextNeeded = prisonRestraintBreakBody();
			}
			else
			{
				outputText("\n\nTry as you might you can't work up the resolve to tamper with them.",false);
			}
			
			if (nextNeeded)
			{
				doNext(camp.returnToCampUseOneHour);
			}
		}
		
		public function doPrisonRestraintsArms():void
		{
			var nextNeeded:* = false;
			nextNeeded = true;
			outputText("You inspect the restraints on your arms.\n\n",true);
			if (debug)
			{
				if (player.statusEffectv3(StatusEffects.PrisonRestraints) >= 2)
				{
					player.changeStatusValue(StatusEffects.PrisonRestraints,3,0);
				}
				else
				{
					player.changeStatusValue(StatusEffects.PrisonRestraints,3,player.statusEffectv3(StatusEffects.PrisonRestraints) + 1);
				}
			}
			else if (player.will > prisonWillCost(10))
			{
				changeWill(-prisonWillCost(10));
				nextNeeded = prisonRestraintBreakArms();
			}
			else
			{
				outputText("\n\nTry as you might you can't work up the resolve to tamper with them.",false);
			}
			
			if (nextNeeded)
			{
				doNext(camp.returnToCampUseOneHour);
			}
		}
		
		public function doPrisonRestraintsMouth():void
		{
			var nextNeeded:* = false;
			nextNeeded = true;
			if (!debug && !prisonCanRestraintBreakMouth())
			{
				doNext(playerMenu);
				return;
			}
			outputText("You inspect the gag in your mouth.\n\n",true);
			if (debug)
			{
				if (player.statusEffectv4(StatusEffects.PrisonRestraints) >= 4)
				{
					player.changeStatusValue(StatusEffects.PrisonRestraints,4,0);
				}
				else
				{
					player.changeStatusValue(StatusEffects.PrisonRestraints,4,player.statusEffectv4(StatusEffects.PrisonRestraints) + 1);
				}
			}
			else if (player.will > prisonWillCost(10))
			{
				changeWill(-prisonWillCost(10));
				nextNeeded = prisonRestraintBreakMouth();
			}
			else
			{
				outputText("\n\nTry as you might you can't work up the resolve to tamper with it.",false);
			}
			
			if (nextNeeded)
			{
				doNext(camp.returnToCampUseOneHour);
			}
		}
		
		//Break restraints
		public function prisonRestraintBreakDoor():Boolean
		{
			/*if (prisonCaptor.restraintBreakDoorFunc != "NOFUNC")
			{
				if (this[prisonCaptor.restraintBreakDoorFunc]())
				{
					return false;
				}
			}*/
			if (rand(100) < player.obey * 0.75 - player.esteem * 0.5)
			{
				outputText("You manage to work up the courage to approach the door and spend a few minutes of examining the lock. But before long you find yourself overwhelmed by the hopelessness of your situation and with fear of what your " + prisonCaptor.captorTitle + " would do if you were caught in the act of trying to escape. You quickly decide not to press your luck any further.",false);
				return true;
			}
			if (player.statusEffectv1(StatusEffects.PrisonRestraints) > 1)
			{
				outputText("Since the door is both locked and barred, you don't even attempt to pick the lock. ",false);
			}
			else if (player.statusEffectv3(StatusEffects.PrisonRestraints) > 1)
			{
				outputText("Since your arms are bound in a way that makes your hands unusable, you don't even attempt to try to pick the lock. ",false);
			}
			else
			{
				outputText("You decide to try to pick the lock, ",false);
				if (rand(player.inte + player.spe + 40) > 120)
				{
					outputText("and after a great deal of trial and error your wits and dexterity prevail over the lock.",false);
					player.changeStatusValue(StatusEffects.PrisonRestraints, 1, 0);
					flags[kFLAGS.PRISON_DOOR_UNLOCKED] = 1;
					return true;
				}
				outputText("but no matter how you fumble at it your wits and dexterity are unable to conquer the lock. ",false);
				if (rand(100) < player.obey * 0.75 - player.esteem * 0.5)
				{
					outputText("You briefly consider trying to open the door with brute force, but before long you find yourself overwhelmed by the hopelessness of your situation and with fear of what your " + prisonCaptor.captorTitle + " would do if you were caught in the act of trying to escape. You quickly decide not to press your luck any further.",false);
					return true;
				}
				outputText("You grow more frustrated, but you aren't quite ready to give up yet. ",false);
			}
			
			outputText("Instead you decide to try to apply brute force, ",false);
			if (rand(100) < prisonGuard.guardNoiseDetectionChance)
			{
				prisonLoadGuard(true);
				outputText(" and begin hammering at the door, only to regret the decision instantly.\n\nAn enraged " + prisonGuard.guardType + " guard enters the room and quickly secures the door behind " + prisonGuard.guardPronoun2 + ", then turns towards you clearly meaning to punish you for your escape attempt.\n\n",false);
				prisonGuard.prisonGuardAttack();
				return false;
			}
			if (rand(player.tou + player.str + 60) > 120 + 10 * player.statusEffectv1(StatusEffects.PrisonRestraints))
			{
				outputText("and after a great deal of pounding your power and endurance win out and the door breaks open.",false);
				player.changeStatusValue(StatusEffects.PrisonRestraints, 1, 0);
				flags[kFLAGS.PRISON_DOOR_UNLOCKED] = 1;
				return true;
			}
			outputText("but no matter how hammer yourself against the door it simply will not budge. ",false);
			return true;
		}
		
		public function prisonRestraintBreakBody():Boolean
		{
			var successChance:int = 5 + rand(5);
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) == 1) {
				successChance += (player.str + player.tou) * 0.5;
				successChance -= (player.statusEffectv3(StatusEffects.PrisonRestraints) * 10);
			}
			else {
				successChance += (player.spe + player.tou) * 0.5;
				successChance -= (5 * player.statusEffectv2(StatusEffects.PrisonRestraints)) + (5 * player.statusEffectv3(StatusEffects.PrisonRestraints));
			}
			if (successChance < 5) successChance = 5;
			
			/*if (prisonCaptor.restraintBreakBodyFunc != "NOFUNC")
			{
				if (this[prisonCaptor.restraintBreakBodyFunc]())
				{
					return false;
				}
			}*/
			if (rand(100) < player.obey * 0.75 - player.esteem * 0.5)
			{
				outputText("You spend a few minutes struggling with your bindings, but before long you find yourself overwhelmed by the hopelessness of your situation and with fear of what your " + prisonCaptor.captorTitle + " would do if you were caught in the act of trying to escape. You quickly decide not to press your luck any further.",false);
				return true;
			}
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) == 1)
			{
				outputText("The only thing you can think to try to free your [legs] is brute force, ",false);
				if (rand(100) < prisonGuard.guardNoiseDetectionChance)
				{
					prisonLoadGuard(true);
					outputText(" and so you begin hammering at the your bindings, only to regret the decision instantly.\n\nAn enraged " + prisonGuard.guardType + " guard enters the room and quickly secures the door behind " + prisonGuard.guardPronoun2 + ", then turns towards you clearly meaning to punish you for your escape attempt. \n\n",false);
					prisonGuard.prisonGuardAttack();
					return false;
				}
				if (rand(100) < successChance)
				{
					outputText("and after a great deal of hammering and smashing and tearing your power and endurance win out and the restraints come free.",false);
					player.changeStatusValue(StatusEffects.PrisonRestraints,2,0);
					return true;
				}
				outputText("but no matter how go about hammering at your restraints, they simply won't come free. ",false);
			}
			else
			{
				outputText("Your body is bound up in such a complex way that it's a bit overwhelming to even begin contemplating freeing yourself. For now, you decide to just focus on freeing your arms. ",false);
				if (rand(100) < successChance)
				{
					outputText(" It requires an almost supernatural feat of strength and dexterity, but somehow you manage to squirm free of your bindings. Now only your leg restraints and the chain to the wall remain.",false);
					player.changeStatusValue(StatusEffects.PrisonRestraints,2,1);
					player.changeStatusValue(StatusEffects.PrisonRestraints,3,0);
					return true;
				}
				outputText(" Unfortunately, no matter how you twist and turn and struggle, your strength and dexterity just aren't up to the task of freeing yourself. ",false);
			}
			return true;
		}
		
		public function prisonRestraintBreakArms():Boolean
		{
			var successChance:int = 5 + rand(5);
			successChance += (player.spe + player.str) * 0.5;
			successChance -= (5 * player.statusEffectv2(StatusEffects.PrisonRestraints)) + (5 * player.statusEffectv3(StatusEffects.PrisonRestraints));
			if (successChance < 5) successChance = 5;
			/*if (prisonCaptor.restraintBreakArmsFunc != "NOFUNC")
			{
				if (this[prisonCaptor.restraintBreakArmsFunc]())
				{
					return false;
				}
			}*/
			if (rand(100) < player.obey * 0.75 - player.esteem * 0.5)
			{
				outputText("You spend a few minutes struggling with your bindings, but before long you find yourself overwhelmed by the hopelessness of your situation and with fear of what your " + prisonCaptor.captorTitle + " would do if you were caught in the act of trying to escape. You quickly decide not to press your luck any further.",false);
				return true;
			}
			if (rand(100) < successChance)
			{
				outputText("It requires an almost supernatural feat of strength and dexterity, but somehow you manage to squirm free of your bindings.",false);
				if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 1)
				{
					player.changeStatusValue(StatusEffects.PrisonRestraints,2,1);
				}
				player.changeStatusValue(StatusEffects.PrisonRestraints,3,0);
				return true;
			}
			outputText("No matter how you twist and turn and struggle, your strength and dexterity just aren't up to the task of freeing yourself. ",false);
			return true;
		}
		
		public function prisonRestraintBreakMouth():Boolean
		{
			var successChance:int = 5 + rand(5);
			successChance += (player.inte + player.spe) * 0.5;
			if (successChance < 5) successChance = 5;
			/*if (prisonCaptor.restraintBreakMouthFunc != "NOFUNC")
			{
				if (this[prisonCaptor.restraintBreakMouthFunc]())
				{
					return false;
				}
			}*/
			if (rand(100) < player.obey * 0.75 - player.esteem * 0.5)
			{
				outputText("You spend a few minutes struggling with your gag, but before long you find yourself overwhelmed by the hopelessness of your situation and with fear of what your " + prisonCaptor.captorTitle + " would do if you were caught in the act of trying to escape. You quickly decide not to press your luck any further.",false);
				return true;
			}
			if (player.statusEffectv4(StatusEffects.PrisonRestraints) == 1 && player.statusEffectv2(StatusEffects.PrisonRestraints) < 2 && player.statusEffectv3(StatusEffects.PrisonRestraints) < 2)
			{
				outputText("With your arms able to reach your mouth, it doesn't take too much effort to remove your simple gag.",false);
				player.changeStatusValue(StatusEffects.PrisonRestraints, 4, 0);
			}
			else if (player.statusEffectv2(StatusEffects.PrisonRestraints) < 2 && player.statusEffectv3(StatusEffects.PrisonRestraints) < 2)
			{
				outputText("You fumble about at the complex locking straps and bindings that are holding your gag in place, ",false);
				if (rand(100) < successChance)
				{
					outputText("and after a great deal of trial and error your wits and dexterity prevail and you are able to remove it from your head.",false);
					player.changeStatusValue(StatusEffects.PrisonRestraints, 4, 0);
				}
				else
				{
					outputText("but no matter what you try your wits and dexterity are unable to remove it from your mouth. ",false);
				}
			}
			else
			{
				outputText("With your arms bound as they are, try as you might you are unable to find a way to ungag yourself.",false);
			}
			
			return true;
		}
		
		//------------
		// ESCAPE
		//------------
		public function prisonCanEscapeFight(verbose:Boolean = true):Boolean
		{
			if (player.statusEffectv3(StatusEffects.PrisonRestraints) > 0 || player.statusEffectv2(StatusEffects.PrisonRestraints) > 0)
			{
				if (verbose)
				{
					outputText("Because of the way you are restrained you would be unable to fight your guard.",true);
				}
				return false;
			}
			return true;
		}
		
		public function prisonCanEscapeSeduce():Boolean
		{
			if (player.statusEffectv4(StatusEffects.PrisonRestraints) > 0)
			{
				outputText("You consider trying to seduce your guard, but you realize you wouldn't be able to communicate gagged as you are.",true);
				return false;
			}
			return true;
		}
		
		public function prisonCanEscapeBribe():Boolean
		{
			if (player.statusEffectv4(StatusEffects.PrisonRestraints) > 0)
			{
				outputText("You consider trying to bribe your guard, but you realize you wouldn't be able to communicate gagged as you are.",true);
				return false;
			}
			return true;
		}
		
		public function prisonCanEscapeSneak():Boolean
		{
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 0)
			{
				outputText("Because of the way you are restrained you would be unable carry out a stealthy escape.",true);
				return false;
			}
			return true;
		}
		
		public function prisonCanEscapeRun():Boolean
		{
			if (player.statusEffectv1(StatusEffects.PrisonRestraints) > 0)
			{
				outputText("The door is locked, so simply running is not an option.",true);
				return false;
			}
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 0)
			{
				outputText("Even though the door is unlocked, without the free use of your legs simply running away is not an option.",true);
				return false;
			}
			return true;
		}
		
		public function prisonCanTrainWorkout():Boolean
		{
			if (player.statusEffectv3(StatusEffects.PrisonRestraints) > 0 || player.statusEffectv2(StatusEffects.PrisonRestraints) > 1)
			{
				outputText("Without the free use of your arms, you are unable to do strength training.",true);
				return false;
			}
			return true;
		}
		
		public function prisonCanTrainCardio():Boolean
		{
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 0)
			{
				outputText("Without the free use of your [legs], you are unable to do cardio training.",true);
				return false;
			}
			return true;
		}
		
		public function prisonCanUseItem(item:Useable):Boolean
		{
			if (inPrison && (item is Consumable) && !prisonCanEat())
			{
				return false;
			}
			else if (inPrison && (item is Useable))
			{
				return true;
			}
			else if (inPrison && (item is Armor || item is Weapon || item is Shield) && !prisonCanEquip())
			{
				return false;
			}
			return true;
		}
		
		public function prisonCanEat():Boolean
		{
			if (player.statusEffectv4(StatusEffects.PrisonRestraints) > 0 && !(player.statusEffectv4(StatusEffects.PrisonRestraints) == 4))
			{
				outputText("Because your mouth is gagged you are unable to eat at this time.",true);
				return false;
			}
			return true;
		}
		
		public function prisonCanEquip():Boolean
		{
			if (player.statusEffectv3(StatusEffects.PrisonRestraints) > 1 || player.statusEffectv2(StatusEffects.PrisonRestraints) > 1)
			{
				outputText("Because of the way your arms are bound you are unable to equip items at this time.",true);
				return false;
			}
			return true;
		}
		
		//------------
		// SCENES
		//------------
		
		//Intro
		public function goDirectlyToPrisonDoNotPassGoDoNotCollect200Gems():void {
			clearOutput();
			outputText("You peer around the corner of a tent. You are unsurprised to see a collection of beast men around a cookfire, but you find yourself far more interested in the cage wagon beyond them. You become so wrapped up in trying to identify the lumpy shapes in the shadowy interior that the sound of twigs snapping behind you doesn't immediately trigger alarm bells in your mind, and before you can properly respond you are knocked unconscious by a brutal blow to the back of your head.");
			doNext(prisonIntro);
		}
		
		public function goBackToPrisonBecauseQuestTimeIsUp():void {
			outputText("\nSomething inside your mind tells you that you should return to the prison. Mistress Elly would probably get angry if you wander the realms and abandon her. ");
			if (camp.companionsCount() > 0) outputText("You leave a note in the camp to let anyone know that you're making your departure. ");
			menu();
			addButton(0, "Next", prisonIntro, false);
		}
		
		public function prisonIntro(involuntary:Boolean = true):Boolean
		{
			//Set flags
			flags[kFLAGS.IN_PRISON] = 1;
			if (involuntary) flags[kFLAGS.PRISON_CAPTURE_COUNTER]++;
			player.createStatusEffect(StatusEffects.PrisonRestraints, 1, 0, 0, 0);
			//Scene GOOOOOOOOOOO!
			clearOutput();
			if (involuntary) {
				outputText("While you were unconscious you were captured by slavers, stripped of your items and equipment, and thrown into a locked cell.",false);
				if (prisonCaptor.captorName != "Elly")
				{
					outputText("\n\nThe door opens and a guard tosses a pathetic piece of bread at your feet.",false);
					outputText("\n\n\"<i>" + prisonCaptor.captorTitle + " " + prisonCaptor.captorName + " sends " + prisonGuard.guardPronoun3 + " regards,</i>\" the guard says brusquely, and slams the door shut.\n\n",false);
					inventory.takeItem(consumables.P_BREAD, camp.returnToCampUseOneHour);
					return false;
				}
				outputText("\n\nShortly after you wake, the door opens and a captivating omnibus enters the room. While her physique is impressive -- long, shapely legs in laced, thigh-high, spike-heeled leather boots; a powerful, athletic but curvy frame; a pair of perky C-cups spilling out of a tight-fitting leather corset -- your eyes focus on her charismatic face. She is possessed of exotic and delicate features, enticingly framed by side swept bangs that have escaped the loosely bound ponytail atop her head. The striking contrast of her fire red hair against her smooth olive skin completes the effect, suggesting that her countenance could shift from intoxicatingly arousing to overwhelmingly intimidating to soft and comforting at any moment.",false);
				outputText("\n\nShe carries little evidence of demonic taint besides a pair of cute, curled horns sprouting from her temples and an agile, spade-tipped tail that flicks about above her muscular, heart-shaped ass. Her preternatural aura of poise, charm, and command, however, betray that she must be a very powerful demon indeed. She looks you over appraisingly while absentmindedly trailing her lithe fingers up and down her semi-erect but rather imposing cock. You notice that she wears long, laced leather sleeves, covering her shoulder to wrist. They strap around her middle fingers, but leave her hands conspicuously ungloved. It would seem that she prefers her subjects to feel her soft, silky skin when she touches them.", false);
			}
			else {
				outputText("You make your journey back to the prison. The guards give you a nod of approval as you walk into the prison entrance.");
				outputText("\n\nYou leave your belongings in a chest before you walk back to your cell. The familiar omnibus, Mistress Elly, enters the room.");
			}
			//Empty items
			if (player.armor != ArmorLib.NOTHING) flags[kFLAGS.PRISON_STORAGE_ARMOR] = player.armor.id; //prisonItemSlotArmor = player.armor;
			if (player.weapon != WeaponLib.FISTS) flags[kFLAGS.PRISON_STORAGE_WEAPON] = player.weapon.id; //prisonItemSlotWeapon = player.weapon;
			if (player.shield != ShieldLib.NOTHING) flags[kFLAGS.PRISON_STORAGE_SHIELD] = player.shield.id;
			player.setArmor(ArmorLib.NOTHING);
			player.setWeapon(WeaponLib.FISTS);
			player.setShield(ShieldLib.NOTHING);
			player.prisonItemSlots = [];
			for (var i:int = 0; i < 10; i++) {
				player.prisonItemSlots.push(player.itemSlot(i).itype.id);
				player.prisonItemSlots.push(player.itemSlot(i).quantity);
				//player.prisonItemSlots.push(new ItemSlotClass());
				//player.prisonItemSlots[i].setItemAndQty(player.itemSlot(i).itype, player.itemSlot(i).quantity);
				//trace(player.prisonItemSlots[i].itype);
				player.itemSlot(i).emptySlot();
			}
			flags[kFLAGS.PRISON_DOOR_UNLOCKED] = 0;
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyStatus) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyStatus,0,0,0,0);
			}
			
			if ((trainingFeed.prisonCaptorFeedingQuestTrainingExists()) && ((trainingFeed.prisonCaptorFeedingQuestTrainingIsComplete()) || (trainingFeed.prisonCaptorFeedingQuestTrainingIsTimeUp())))
			{
				outputText("\n\n(Placeholder) Mistress Elly wecomes you back from your slutty adventures in the outside world.\n\n");
				trainingFeed.prisonCaptorFeedingQuestTrainingResolve();
				return false;
			}
			if ((trainingFeed.prisonCaptorFeedingQuestTrainingExists()) && !trainingFeed.prisonCaptorFeedingQuestTrainingIsTimeUp())
			{
				outputText("\n\n(Placeholder) Mistress Elly enters the room and chastises you for not being out working on her quest.\n\n");
				inventory.takeItem(consumables.C_BREAD, camp.returnToCampUseOneHour);
				return true;
			}
			if (player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus) > 0)
			{
				outputText("\n\nMomentarily she breaks her piercing stare and speaks. \"<i>Welcome back, slave</i>\" she intones in a voice every bit as beautiful and compelling as her face, \"<i>I take it your field education went well. Did you give yourself a lesson about fighting back by letting a few nice minotaurs rape you? Or maybe you went for some 'archery lessons' with that centaur fellow.</i>\" She leans in close to you gives your " + player.assDescript() + " a fierce but playful slap. \"<i>You could certainly learn some useful things from him.</i>\" She closes the distance further, and her natural, musky, alluring scent washes over you. For a moment you aren't sure if you want to fall to your knees and embrace her or cower pitifully in the shadow of her overpowering presence. Your gaze becomes transfixed on the mesmerizing movements of her deliciously pouty crimson lips.",false);
				outputText("\n\n\"<i>Whatever you may have been doing, I'm pleased that you've decided to come back and continue your formal education with me. I know you are eager for it to be complete, but rememeber it takes time to understand that you are...</i>\" Defying all reason, she somehow moves even closer to you.",false);
				outputText("\n\n\"<i>a pliable...</i>\" Her strawberry tongue traces the contours of her lips as she purrs the word, then darts out to tease yours. Shivers run down your spine.",false);
				outputText("\n\n\"<i>obedient...</i>\" The fingers of her right hand gently caress your " + player.chestDesc() + ".",false);
				outputText("\n\n\"<i>servile...</i>\" The fingers of her left hand forcefully probe your " + player.assholeDescript() + ".",false);
				outputText("\n\n\"<i>piece of flesh...</i>\" Her now fully erect cock grinds against your ",false);
				if (player.cocks.length == 0)
				{
				  outputText(player.clitDescript() + ".",false);
				}
				else if (player.cocks.length == 1)
				{
				  outputText(player.cockDescript(0) + ".",false);
				}
				else
				{
				  outputText(player.multiCockDescriptLight() + ".",false);
				}
				
				outputText("\n\n\"<i>whose only reason to exist is to entertain and please others.</i>\" She abruptly shoves you to the ground, and in the sudden absence of her closeness ",false);
				if (player.obey < 45)
				{
				  outputText("you are overcome by an unwelcome rush of desire to do whatever it takes to get it back. ",false);
				}
				else
				{
				  outputText("you are filled with lament at its loss and a consuming desire to learn whatever lessons your Mistress wishes to teach you.",false);
				}
				outputText("\n\nShe moves back towards the door. \"<i>Since you have been disobedient I shouldn't be giving you any food at all until you earn it. But I have a soft spot for you, little slave, so I suppose we can just think of this a homecoming gift of sorts.</i>\" Out of thin air she produces a pitiful loaf of bread and crumbles it into a bowl. With a smile of supreme satisfaction, she begins to milk her cock into it. Before long, the bowl is overflowing with her sticky seed. She sets it on the ground and gives you a playful wink before leaving you alone in the cell.\n\n",false);
				changeObey(3, true);
				inventory.takeItem(consumables.C_BREAD, camp.returnToCampUseOneHour);
				return false;
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,1);
			//flags[kFLAGS.PRISON_TRAINING_LEVEL] = 0;
			outputText("\n\nAfter an uncomfortable period of being <i>examined</i>, you watch the demon's violet, almond eyes finally settle -- on your own. Her gaze is beyond piercing, seeming to both physically and mentally enfeeble you. You find yourself unable to escape it, and your fortitude steadily wanes. The moment begins to extend into a dense, stifling eternity, when suddenly -- she speaks. \"<i>Hello, Champion.</i>\" To your almost embarrassing surprise, her voice is every bit as beautiful and compelling as her face, and you barely notice that her eyes have moved on.  \"<i>I am your new owner. My name is Elly, but <b>you</b> will call me Mistress.</i>\" She says it with impartial conviction, as if it were a trivial matter of fact, and for an eerie moment, your mind absorbs it as truth. ",false);
			outputText("\n\n\"<i>By now, any number of monsters and demons must have tried to make you their property, so you no doubt assume that my intentions are the same. In one sense they surely are. The others wanted to own your body, as I now do.</i>\" She emphasizes this point by kicking you onto your back and resting her spiked boot on your [chest]. \"<i>The difference is that where they aim to merely destroy your mind so they can claim your body, I will instead own your mind and you will willingly give me your body. The process of you learning that you are my property will be slow, subtle, and humiliating... but when it is complete, you will beg me to let you experience it again.</i>\" Smiling wickedly, she slides her foot down your torso and begins using her boot covered toe to gently caress your ",false);
			if (player.cocks.length == 0)
			{
				outputText(player.clitDescript() + ".",false);
			}
			else if (player.cocks.length == 1)
			{
				outputText(player.cockDescript(0) + ".",false);
			}
			else
			{
				outputText(player.multiCockDescriptLight() + ".",false);
			}
			
			outputText("\n\n\"<i>But you <b>will</b> learn.</i>\"",false);
			outputText("\n\n\"<i>You will dream about every time one of my guards taught you a lesson in obedience by raping you, and you will wake up masturbating.</i>\"",false);
			outputText("\n\n\"<i>You will salivate at the very thought of licking a pool of jizz off your cell floor, and consider every drop of cum deposited in or on your body to be a gift you are unworthy of.</i>\"",false);
			outputText("\n\n\"<i>You will feel jealousy every time you hear the screams of another slave being taught their place. You will envy the fact that they will soon enjoy the wonderful epiphany of understanding what they really are. And, quite likely, you will stage fake rebellions simply to enjoy the rush of having your bad behavior corrected.</i>\"",false);
			outputText("\n\n\"<i>Finally, you will think back on the times when you genuinely tried to resist your true nature -- a pliable, obedient, servile piece of flesh whose only reason to exist is to entertain and please others -- and you will feel grateful that your kind Mistress found you and saved you from your foolish ways.</i>\"",false);
			outputText("\n\nShe emphasizes this final point by turning and walking to the door, then adding, almost as an afterthought, \"<i>Please do resist all you like, by the way, and even escape if you can. Don't worry, it usually doesn't take long catch you again, and more often than not you'll just come back to me on your own. In any case, your resistance creates useful, teachable moments. You can only learn how wrong you are about yourself if you have the opportunity to have your behaviors corrected, after all.</i>\"",false);
			outputText("\n\n\"<i>Here, a special meal to help you get comfortable. Remember how good it tastes, since you'll need to earn it in the future.</i>\" She throws a pitiful looking loaf of bread on the floor next to you, and abruptly leaves you alone in your cell. ",false);
			if (player.obey < 45 && player.cor < 70)
			{
				outputText("You find yourself unsettled by ",false);
			}
			else
			{
				outputText("You find yourself aroused and compelled by ",false);
			}
			outputText("how long Mistress Elly's arresting presence lingers in your mind, and by the depth of the effect her words seemed to have on your psyche.\n\n",false);
			changeObey(2, true);
			if (flags[kFLAGS.PRISON_CAPTURE_COUNTER] == 0) {
				player.obeySoftCap = true;
				player.obey = 0;
				player.esteem = 50;
				player.will = 80;
			}
			inventory.takeItem(consumables.P_BREAD, camp.returnToCampUseOneHour);
			return false;
		}
		
		//------------
		// PRISON ACTIONS
		//------------
		public function prisonRoom(allowsEvents:Boolean = true):void {
			//Workaround to force update prison door. The old prison code surely was messy.
			if (player.statusEffectv1(StatusEffects.PrisonRestraints) > 0) flags[kFLAGS.PRISON_DOOR_UNLOCKED] = 0;
			else flags[kFLAGS.PRISON_DOOR_UNLOCKED] = 1;
			//Start!
			hideUpDown();
			showStats();
			clearOutput();
			outputText(images.showImage("prison-cell"), false);
			switch(flags[kFLAGS.PRISON_PUNISHMENT]) {
				case 0: //Default cell
					outputText("You are in a dimly lit but spacious cell. However, the size of the room is little comfort to you as it is filled with all manner of restraints and torture devices. Eylets, metal rings, bars and hooks are scattered around the ceiling, floor and walls providing a near endless variety of ways to restrain a person. A wooden stockade is installed in the center of the room, a whipping post and a rack stand in one corner, and in another there is a large and ominous floor to ceiling stone box. \n\n");
					break;
				case 1: //Stockades
					outputText("You are in a dimly lit but spacious cell. However, the size of the room is little comfort to you as it is filled with all manner of restraints and torture devices. Eyelets, metal rings, bars and hooks are scattered around the ceiling, floor and walls providing a near endless variety of ways to restrain a person. A whipping post and a rack stand in one corner, and in another there is a large and ominous floor to ceiling stone box. \n\n");
					outputText("You are confined to the stockades as part of your lesson. A hollow plug has been forced into your ass, curving upward in a hook-like shape and attached to the ceiling. You are bound in such a way that should your [legs] go slack even the slightest bit, the entire weight of your torso would be suspended by your asshole. \n\n");
					break;
				case 2: //Confinement
					outputText("You are confined in a dark stone box. You can't move more than an inch in either direction, but you can stand up or sit down. A collection of monstrous dildos extend from the horizontal bar directly underneath you, doing their best to demoralize you. A small slit in the panel allows you to see the cell. \n\n");
					break;
				case 3: //BJ Trainer
					outputText("You are in a dimly lit but spacious cell. However, the size of the room is little comfort to you as it is filled with all manner of restraints and torture devices. Eylets, metal rings, bars and hooks are scattered around the ceiling, floor and walls providing a near endless variety of ways to restrain a person. A wooden stockade is installed in the center of the room, a whipping post and a rack stand in one corner, and in another there is a large and ominous floor to ceiling stone box. \n\n");
					punishments.prisonCaptorPunishmentBJTrainerDescribeStatus(true);
					break;
				case 4: //Training Crate
					outputText("(Placeholder) You are confined to the training crate as part of your lesson.");
					break;
				default:
					outputText("You are in a dimly lit but spacious cell. However, the size of the room is little comfort to you as it is filled with all manner of restraints and torture devices. Eylets, metal rings, bars and hooks are scattered around the ceiling, floor and walls providing a near endless variety of ways to restrain a person. A wooden stockade is installed in the center of the room, a whipping post and a rack stand in one corner, and in another there is a large and ominous floor to ceiling stone box. \n\n");
			}
			if (model.time.hours >= 6 && model.time.hours <= 20) outputText("Mercifully, fresh air and sunlight can enter the room through narrow slit windows opposite the door.");
			else outputText("You can see the blood-red moon contrasting against black sky through the narrow slit windows.");
			prisonRestraintText();
			if (flags[kFLAGS.PRISON_DIRT_ENABLED] > 0) {
				outputText("\n\nThe room is ",false);
				var cleanlinessLevel:int = Math.floor(player.statusEffectv2(StatusEffects.PrisonCaptorEllyStatus) / 25);
				switch(cleanlinessLevel)
				{
					case 0:
						outputText("about as clean as it is going to get.",false);
						break;
					case 1:
						outputText("a bit messy.",false);
						break;
					case 2:
						outputText("<b>unpleasantly dirty</b>.",false);
						break;
					case 3:
					case 4:
					default:
						outputText("<b>extremely filthy</b>.",false);
				}
			}
			if (kGAMECLASS.timeQ > 0)
			{
				/*if (!kGAMECLASS.campQ)
				{
					outputText("More time passes...\n", true);
					goNext(kGAMECLASS.timeQ, false);
					return;
				}*/
				if (model.time.hours < 6 || model.time.hours > 20)
				{
					camp.doSleep();
					return;
				}
				camp.rest();
				return;
			}
			//Expire punishment.
			if (player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) <= 0)
			{
				if (flags[kFLAGS.PRISON_PUNISHMENT] == 1)
				{
					punishments.prisonCaptorPunishmentStockadesFreedom();
					return;
				}
				if (flags[kFLAGS.PRISON_PUNISHMENT] == 2)
				{
					punishments.prisonCaptorPunishmentConfinementFreedom();
					return;
				}
				if (flags[kFLAGS.PRISON_PUNISHMENT] == 3)
				{
					punishments.prisonCaptorPunishmentBJTrainerTimesup();
					return;
				}
			}
				
			//Random events
			if (flags[kFLAGS.PRISON_EVENT_TIMEOUT] == 0 && model.time.hours >= 8) {
				flags[kFLAGS.PRISON_EVENT_TIMEOUT] = 2;
				trace("Firing prison event");
				var petPlayRarity:int = 10;
				petPlayRarity -= (trainingPet.prisonCaptorPetScore() - 25) / 5;
				if (petPlayRarity < 2) petPlayRarity = 2;
				var chooser:int = rand(8);
				trace(chooser);
				switch(chooser)
				{
					case 1:
						if (randomCooldownScruffy <= 0 &&!scruffyScene.prisonCaptorScruffyOptedOut()) {
							randomCooldownScruffy = 6 + rand(6);
							scruffyScene.prisonCaptorRandomEventJizzJanitor();
							return;
						}
						break;
					case 2:
						if (randomCooldownGuard <= 0) {
							randomCooldownGuard = 12 + rand(60);
							prisonGuard.prisonCaptorRandomEventAbuse();
							return;
						}
						break;
					case 3:
					case 4:
						if (randomCooldownFeed <= 0 && player.hunger < 80) {
							randomCooldownFeed = 4 + rand(4);
							trainingFeed.prisonCaptorFeedingEvent();
							return;
						}
					case 5:
					case 6:
						if (randomCooldownPet <= 0 && rand(petPlayRarity) == 0 && !trainingPet.prisonCaptorPetOptedOut()) {
							randomCooldownPet = 4 + rand(4);
							trainingPet.prisonCaptorPetEvent();
							return;
						}
						break;
					case 7:
						if (randomCooldownPet <= 0 && rand(petPlayRarity) == 0 && trainingPet.prisonCaptorPetScore() >= 30 && !trainingPet.prisonCaptorPetOptedOut()) {
							randomCooldownPet = 6 + rand(4);
							if (trainingPet.prisonCaptorPetTier() == 2) trainingPet.prisonCaptorPetTrainingOffer();
							else if (trainingPet.prisonCaptorPetTier() == 3) trainingPet.prisonCaptorPetTrainingDemand();
							return;
						}
						break;
					default:
						break;
				}
			}
			//if (prisonRoomEvents())
			//{
			//	return;
			//}
			mainView.showMenuButton( MainView.MENU_NEW_MAIN );
			mainView.showMenuButton( MainView.MENU_DATA );
			mainView.showMenuButton( MainView.MENU_STATS );
			mainView.showMenuButton( MainView.MENU_PERKS );
			mainView.showMenuButton( MainView.MENU_APPEARANCE );
			mainView.setMenuButton( MainView.MENU_NEW_MAIN, "Main Menu", kGAMECLASS.mainMenu );
			mainView.newGameButton.toolTipText = "Return to main menu.";
			mainView.newGameButton.toolTipHeader = "Main Menu";
			//Level up
			if (camp.setLevelButton()) return;
			mainView.statsView.hideLevelUp();
			//Set menus
			menu();
			addButton(0, "Train", prisonTrainMenu, null, null, null, "Train to improve your body.");
			addButton(1, "Study", prisonStudyMenu, null, null, null, "Study to improve your mind.");
			addButton(2, "Restraints", prisonRestraintsMenu, null, null, null, "Try to break free from restraints if you have any.");
			if (flags[kFLAGS.PRISON_DIRT_ENABLED] > 0) addButton(3, "Clean", prisonCaptorCleanRoom, null, null, null, "Clean the cell.");
			if (flags[kFLAGS.PRISON_DOOR_UNLOCKED] > 0) addButton(4, "Escape", prisonEscapeMenu, null, null, null, "Make an escape attempt.");
			//addButton(5, "Trigger Billie", billieScene.prisonCaptorBilliePunishmentFuck);
			addButton(7, "Inventory", inventory.inventoryMenu);
			//Check lust
			if (player.lust >= 30) {
				if (player.lust >= player.maxLust()) {
					outputText("\n\n<b>You are debilitatingly aroused, and can think of doing nothing other than masturbating.</b>", false);
					removeButton(0);
					removeButton(4);
				}
				addButton(8, "Masturbate", getGame().masturbation.masturbateMenu);
				if (((player.findPerk(PerkLib.HistoryReligious) >= 0 && player.cor <= 66) || (player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < 10)) && !(player.findStatusEffect(StatusEffects.Exgartuan) >= 0 && player.statusEffectv2(StatusEffects.Exgartuan) == 0) || flags[kFLAGS.SFW_MODE] >= 1) addButton(8, "Meditate", getGame().masturbation.masturbateMenu);
			}
			//Alter menu depending on punishment.
			if (flags[kFLAGS.PRISON_PUNISHMENT] == 1) {
				menu();
				addButton(5, "Call Out", punishments.prisonCaptorPunishmentStockadesCallout, null, null, null, "Call for someone to get to you.");
				addButton(7, "Break Stockade", punishments.prisonCaptorPunishmentStockadeBreak, null, null, null, "Attempt to break the stockade.\n\n" + prisonWillCostDescript(10));
			}
			if (flags[kFLAGS.PRISON_PUNISHMENT] == 2) {
				punishments.prisonCaptorPunishmentConfinementDescribeStatus();
				menu();
				addButton(5, "Stand Up", punishments.prisonCaptorPunishmentConfinementStandup, null, null, null, "Try to stand up while inside the box.");
				addButton(6, "Rest Legs", punishments.prisonCaptorPunishmentConfinementRestlegs, null, null, null, "Try to rest your legs while inside the box.");
				addButton(7, "Break Box", punishments.prisonCaptorPunishmentConfinementBreak, null, null, null, "Attempt to break the box.\n\n" + prisonWillCostDescript(10));
				if (player.lust >= 30) addButton(8, "Masturbate", punishments.prisonCaptorPunishmentConfinementMasturbate);
			}
			if (flags[kFLAGS.PRISON_PUNISHMENT] == 3) {
				outputText("\n\n");
				addButton(5, "Suck Dildo", punishments.prisonCaptorPunishmentBJTrainerSuck, null, null, null, "Suck on the dildo and try to fill the basin to get the key.");
			}
			if (flags[kFLAGS.PRISON_PUNISHMENT] == 4) {
				menu();
				addButton(0, "Behave", trainingPet.prisonCaptorPetTrainingCrateBehave);
				if (player.will >= prisonWillCost(10)) addButton(1, "Misbehave", trainingPet.prisonCaptorPetTrainingCrateMisbehave, null, null, null, prisonWillCostDescript(10));
				addButton(2, "Call Out", trainingPet.prisonCaptorPetTrainingCrateCallOut);
				addButton(3, "Leash", trainingPet.prisonCaptorPetTrainingCrateLeash);
				//addButton(7, "Break Cage", trainingPet.prisonCaptorPetTrainingCrateBreak, null, null, null, "Attempt to break the cage?\n\n" + prisonWillCostDescript(10));
				if (player.lust >= 70) addButton(8, "Masturbate", trainingPet.prisonCaptorPetTrainingCrateMasturbate);
			}
			//Show wait/rest/sleep depending on conditions.
			addButton(9, "Wait", camp.doWait);
			if (player.fatigue > 40 || player.HP / player.maxHP() <= .9) addButton(9, "Rest", getGame().camp.rest);
			if (model.time.hours >= 21 || model.time.hours < 6) {
				removeButton(0);
				removeButton(1);
				removeButton(2);
				removeButton(3);
				addButton(9, "Sleep", getGame().camp.doSleep);
			}
		}
		
		//------------
		// TRAIN
		//------------
		private function prisonTrainMenu():void {
			hideMenus();
			clearOutput();
			outputText("You consider ways to use your time to improve your body.\n\n");
			menu();
			addButton(0, "Workout", doPrisonTrainWorkout, null, null, null, "Do some workout to improve your strength and toughness.");
			addButton(1, "Cardio", doPrisonTrainCardio, null, null, null, "Do some exercise to improve your toughness and speed.");
			if (flags[kFLAGS.PRISON_TRAIN_SELF_CONTROL_UNLOCKED] > 0) addButton(5, "Self-Control", prisonCaptorTrainSelfControl, null, null, null, "Improve your self-control.");
			if (flags[kFLAGS.PRISON_TRAIN_ANAL_CAPACITY_UNLOCKED] > 0) addButton(6, "Anal Capacity", prisonCaptorTrainAnalCapcity, null, null, null, "Train to increase your anal capacity.");
			if (flags[kFLAGS.PRISON_TRAIN_PUPPY_TRICKS_UNLOCKED] > 0) addButton(7, "Puppy Tricks", prisonCaptorTrainPuppyTricks, null, null, null, "Practice behaving like a dog.");
			addButton(14, "Back", prisonRoom);
		}
		
		private function doPrisonTrainWorkout():void 
		{
			clearOutput();
			if (!prisonCanTrainWorkout())
			{
				doNext(playerMenu);
				return;
			}
			if (player.fatigue > player.maxFatigue() - 25)
			{
				outputText("<b>There's no way you could exercise right now - you're exhausted!</b>  ", false);
				doNext(playerMenu);
				return;
			}
			player.changeFatigue(25);
			outputText("You decide to pass the time with a workout regimen of pushups, situps, makeshift pull ups and other activities to improve your strength and endurance. ", false);
			if (player.str < 25)
			{
				outputText("You only manage a few reps of each, but even so, you manage to work up a good burn and a modest sweat.",false);
			}
			else if (player.str < 40)
			{
				outputText("You push yourself a bit harder than you expected to.  It doesn't take you long to work up a sweat, but you push on through a variety of exercises that leave your body feeling sore and exhausted.",false);
			}
			else if (player.str < 60)
			{
				outputText("You smile when you lose track of your reps while doing your fourth set of pushups.  With a start, you realize you're probably stronger now than Ingnam's master blacksmith, Ben.  Wow!  This realization fuels you to push yourself even harder, and you spend nearly two hours doing various strength-building exercises.",false);
			}
			else if (player.str < 80)
			{
				outputText("You confidently push your way through set after set of strength-building exercises.  It doesn't take long for you to work up a lather of sweat and feel the burn thrumming through your slowly tiring form.  The workout takes about two hours, but you feel you made some good progress today.",false);
			}
			else if (player.str < 90)
			{
				outputText("You find yourself losing track of both reps and sets as you push yourself beyond your limits.  Standing up, you flex and marvel at yourself – you could probably arm wrestle a minotaur or two and come out victorious!",false);
			}
			else
			{
				outputText("There is really no challenge left to be had in your regimen, but you power your way through anyway.  By the time two hours have passed, you've worked up a good sweat, but without some other method of exercise you probably won't get any stronger.",false);
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
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function doPrisonTrainCardio():void 
		{
			clearOutput();
			if (!prisonCanTrainCardio())
			{
				doNext(playerMenu);
				return;
			}
			if (player.fatigue > player.maxFatigue() - 30)
			{
				outputText("<b>There's no way you could exercise right now - you're exhausted!</b>  ", false);
				doNext(playerMenu);
				return;
			}
			player.changeFatigue(30);
			outputText("You decide to pass the time with a cardio training regimen of jumping jacks, jogging in circles, and other calisthenics to improve your speed and endurance ",false);
			if (player.tou < 25)
			{
				outputText("but you get so winded you have to stop after a few minutes.  Determined to improve, you force yourself to jog a few more laps around the room.",false);
			}
			else if (player.tou < 40)
			{
				outputText("but your performance isn't that great.  You nearly stop jogging a few times but manage to push through until you're completely exhausted.",false);
			}
			else if (player.tou < 60)
			{
				outputText("and you do quite well.  You jog around for nearly an hour, working up a healthy lather of sweat, then run though an exhaustive regimen of calisthenics.  Even your " + player.legs() + " tingle and burn with exhaustion.",false);
			}
			else if (player.tou < 80)
			{
				outputText("and it doesn't faze you in the slightest.  You lose count of the number of jumping jacks you've done and then run in circles for just as long, working yourself until you're soaked with sweat and fairly tired.",false);
			}
			else if (player.tou < 90)
			{
				outputText("and you have a terrific time.  You can keep yourself working out at a fever pitch the entire time, though you work up a huge amount of sweat in the process.",false);
			}
			else
			{
				outputText("and it barely challenges you.  No matter how many jumping jacks you do or circles you run around the room you never tire out.  Still, you do manage to burn a lot of calories.",false);
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
			doNext(camp.returnToCampUseOneHour);
		}
		
		//Special training
		public function prisonCaptorTrainSelfControl():void
		{
			outputText("(Placeholder) You decide to spend some time working on your sexual self control -- i.e., masturbating without orgasming. \n\nVarious scenes will play out depending on your esteem, obedience, and corruption, as well as randomized factors, and you will receive stat boosts as appropriate to the scene. For now, this placeholder just gives you a small increase to your obedience, a small hit to your self esteem,.and an increase to lust.\n\n",false);
			dynStats("lus", 20);
			changeObey(1,inPrison);
			changeEsteem(-1,inPrison);
			doNext(camp.returnToCampUseTwoHours);
		}
		
		public function prisonCaptorTrainAnalCapcity():void
		{
			var lustChange:int = 0;
			outputText("(Placeholder) You decide to spend some time working on your anal capacity and endurance -- i.e., working fingers, hands, and other props into yourself to increase your ability to perform anal sex. \n\nVarious scenes will play out depending on your esteem, obedience, and corruption, as well as randomized factors, and you will receive stat boosts as appropriate to the scene. For now, this placeholder just gives you a small increase to your obedience, a small hit to your self esteem, and an increase to lust.\n\n",false);
			dynStats("lus", 20);
			changeObey(1, inPrison);
			changeEsteem( -1, inPrison);
			if (player.findStatusEffect(StatusEffects.BonusACapacity) < 0) {
				player.createStatusEffect(StatusEffects.BonusACapacity, 2, 0, 0, 0);
			}
			else {
				if (player.statusEffectv1(StatusEffects.BonusACapacity) < 20) {
					player.addStatusValue(StatusEffects.BonusACapacity, 1, 2);
				}
				else if (player.statusEffectv1(StatusEffects.BonusACapacity) < 35) {
					player.addStatusValue(StatusEffects.BonusACapacity, 1, 1);
				}
				else if (player.statusEffectv1(StatusEffects.BonusACapacity) < 50) {
					player.addStatusValue(StatusEffects.BonusACapacity, 1, 0.5);
				}
			}
			doNext(camp.returnToCampUseTwoHours);
		}
		
		public function prisonCaptorTrainPuppyTricks():void
		{
			outputText("(Placeholder) You decide to practice behaving like a dog -- crawling, sitting, begging, posing as if in heat with high corruption. \n\nVarious scenes will play out depending on your esteem, obedience, and corruption, as well as your state of restraint and other random factors, and you will receive stat boosts as appropriate to the scene. For now, this placeholder just gives you a small increase to your obedience and a small boost to your self esteem.\n",false);
			changeObey(1,inPrison);
			changeEsteem(1,inPrison);
			doNext(camp.returnToCampUseTwoHours);
		}
		
		
		//------------
		// STUDY
		//------------
		public function prisonStudyMenu():void
		{
			clearOutput();
			outputText("You consider ways to use your time to improve your mind.\n\n",false);
			menu();
			addButton(0, "Inner Peace", doPrisonStudyInnerpeace, null, null, null, "Calm your nerves and bring balance to your emotions to improve your self esteem.");
			addButton(1, "Determination", doPrisonStudyDetermination, null, null, null, "Improve your determination and hone your intelligence.");
			addButton(2, "Self Pity", doPrisonStudySelfpity, null, null, null, "Attempt to calm your nerves.");
			addButton(3, "Discipline", doPrisonStudyDiscipline, null, null, null, "Attempt to improve your determination and increase your obedience.");
			if (flags[kFLAGS.PRISON_STUDY_MANNERS_UNLOCKED] > 0) addButton(5, "Manners", prisonCaptorStudyManners, null, null, null, "Improve your manners.");
			if (flags[kFLAGS.PRISON_STUDY_BREATHING_UNLOCKED] > 0) addButton(6, "Breathing", prisonCaptorStudyBreathing, null, null, null, "Work on holding your breath.");
			addButton(14, "Back", prisonRoom);
		}
		
		public function doPrisonStudyInnerpeace():void
		{
			outputText("You turn your thoughts inward in an attempt to calm your nerves and bring balance to your emotions.\n",false);
			if (player.lust > 60)
			{
				dynStats("lus", -3);
			}
			if (player.lib > 40)
			{
				dynStats("lib", -0.5);
			}
			changeEsteem(5, inPrison);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function doPrisonStudyDetermination():void
		{
			outputText("You turn your thoughts inward in an attempt to improve your determination and strength of will.\n",false);
			if (player.cor > 50)
			{
				dynStats("cor", -0.3);
			}
			if (player.inte < 60)
			{
				dynStats("inte", 0.5);
			}
			if (silly() && player.inte >= 60 && player.cor <= 50) outputText("You are filled with DETERMINATION.");
			changeObey(-5,inPrison);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function doPrisonStudySelfpity():void
		{
			outputText("You turn your thoughts inward in an attempt to calm your nerves and bring balance to your emotions, but end up wallowing in self pity over your hopeless situation instead.\n",false);
			changeEsteem(-5,inPrison);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function doPrisonStudyDiscipline():void
		{
			outputText("You turn your thoughts inward in an attempt to improve your determination, but end up daydreaming about how pleasant it is to be told what to do rather than having to think for yourself.\n",false);
			changeObey(5,inPrison);
			doNext(camp.returnToCampUseOneHour);
		}
		
		//Special study
		public function prisonCaptorStudyManners():void
		{
			outputText("(Placeholder) You decide to spend some time working on your manners -- i.e., conditioning yourself to think of your captor as [captorTitle] and to use the proper form of address when speaking to her. \n\n Various scenes will play out depending on your esteem, obedience, and corruption, as well as randomized factors, and you will receive stat boosts as appropriate to the scene. For now, this placeholder just gives you a small increase to your obedience and a small hit to your self esteem.\n\n",false);
			changeObey(1,inPrison);
			changeEsteem(-1,inPrison);
			doNext(camp.returnToCampUseTwoHours);
		}
		
		public function prisonCaptorStudyBreathing():void
		{
			outputText("(Placeholder) You decide to spend some time working on your breathing -- i.e., working on holding your breath, practicing rhythmic breathing, and if corruption is high enough and props are available (the dildo bat weapon, the dildo rack, or your own very long penis), using said props to aid in this endeavor. \n\nVarious scenes will play out depending on your esteem, obedience, and corruption, as well as randomized factors, and you will receive stat boosts as appropriate to the scene. For now, this placeholder just gives you a small increase to your obedience and a small boost to your self esteem.\n\n",false);
			changeObey(1,inPrison);
			changeEsteem(1,inPrison);
			doNext(camp.returnToCampUseTwoHours);
		}
		
		public function prisonCaptorCleanRoom():void
		{
			clearOutput();
			var newCleanliness:int = 0;
			outputText("You decide to spend some time cleaning your cell, fearing what your " + prisonCaptor.captorTitle + " might do if you let it get too messy.",false);
			newCleanliness = player.statusEffectv2(StatusEffects.PrisonCaptorEllyStatus) - 5;
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 1)
			{
				outputText(" Since you can barely move and are forced to find creative ways to mash the sponge around the floor, you hardly achieve anything at all. On top of that, you feel particularly undignified while making the attempt.",false);
				changeEsteem(-1,inPrison);
			}
			else if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 0 || player.statusEffectv3(StatusEffects.PrisonRestraints) > 1)
			{
				outputText(" Since your range of motion is somewhat restricted, you don't manage to clean nearly as much as you had hoped to.",false);
				newCleanliness = newCleanliness - 10;
			}
			else
			{
				newCleanliness = newCleanliness - 20;
			}
			
			if (player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus) > 2 && rand(player.lust + player.cor - player.esteem) > 125 || player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus) > 4 && rand(player.lust + player.cor - player.esteem) > 75)
			{
				outputText("\n\n(Placeholder) You encounter a pool of cum on the floor, and you can't help but feel aroused daydreaming about how it came to be there. A thought strikes you: your " + prisonCaptor.captorTitle + " wouldn't be pleased if you wasted it by simply mopping it up with your sponge, and before your mind can react your instincts kick in and you find yourself licking the pool of cum off the floor",false);
				player.slimeFeed();
				changeEsteem(-3,inPrison);
				changeObey(1,inPrison);
			}
			if (newCleanliness < 0)
			{
				newCleanliness = 0;
			}
			player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,2,newCleanliness);
			changeObey(0.2,inPrison);
			doNext(camp.returnToCampUseTwoHours);
		}
		
		//------------
		// ESCAPE
		//------------
		public function prisonEscapeMenu():void
		{
			var fight:Function = doPrisonEscapeFight;
			var seduce:Function = doPrisonEscapeSeduce;
			var bribe:Function = doPrisonEscapeBribe;
			var sneak:Function = doPrisonEscapeSneak;
			var run:Function = doPrisonEscapeRun;
			var quest:Function = doPrisonEscapeQuestRun;
			clearOutput();
			outputText("You look around you and think about how you might be able to free yourself from captivity.\n\n", false);
			if (player.gems < 500) {
				bribe = null;
			}
			if (!trainingFeed.prisonCaptorFeedingQuestTrainingExists()) {
				quest = null;
			}
			/*prisonEscapeChoices(choiceEvents,choiceTexts);
			var i:int = 1;
			while(i < 10)
			{
				if (choiceEvents[i] != 0)
				{
					choiceFound = true;
					switch(choiceTexts[i])
					{
						case "Fight":
							outputText("You think you might be able to win if you fought your guard. " + prisonWillCostDescript(20) + "\n",false);
							break;
						case "Seduce":
							outputText("It occurs to you that if you seduce your guard you could get away afterwards. " + prisonWillCostDescript(10) + "\n",false);
							break;
						case "Bribe":
							outputText("Given that your sizable stack of gems is probably with your gear you consider trying to pay for your freedom. " + prisonWillCostDescript(10) + "\n",false);
							break;
						case "Sneak":
							outputText("If you were quick and quiet enough you think you might be able to sneak out when a guard enters the room. " + prisonWillCostDescript(15) + "\n",false);
							break;
						case "Run":
							outputText("Maybe you could just walk out the door? " + prisonWillCostDescript(5) + "\n",false);
							break;
						case "Do Quest":
							outputText("You've been given a task to do, so you can just walk out the door. \n",false);
							break;
					}
				}
				i++;
			}*/
			if (fight != null) outputText("You think you might be able to win if you fought your guard. " + prisonWillCostDescript(20) + "\n",false);
			if (seduce != null) outputText("It occurs to you that if you seduce your guard you could get away afterwards. " + prisonWillCostDescript(10) + "\n",false);
			if (bribe != null) outputText("Given that your sizable stack of gems is probably with your gear you consider trying to pay for your freedom. " + prisonWillCostDescript(10) + "\n",false);
			if (sneak != null) outputText("If you were quick and quiet enough you think you might be able to sneak out when a guard enters the room. " + prisonWillCostDescript(15) + "\n",false);
			if (run != null) outputText("Maybe you could just walk out the door? " + prisonWillCostDescript(5) + "\n",false);
			if (quest != null) outputText("You've been given a task to do, so you can just walk out the door. \n",false);
			
			//if (choiceFound)
			//{
				outputText("\n\nWill you make an escape attempt?", false);
				menu();
				addButton(0, "Fight", fight);
				addButton(1, "Seduce", seduce);
				addButton(2, "Bribe", bribe);
				addButton(3, "Sneak", sneak);
				addButton(4, "Run", run);
				addButton(5, "Quest", quest);
				addButton(14, "Nevermind", playerMenu);
			/*}
			else
			{
				outputText("\n\nSince no viable options present themselves, you decide to forget about escape for now.",false);
				doNext(playerMenu);
			}*/
		}
		
		public function doPrisonEscapeFight():void
		{
			if (!prisonCanEscapeFight())
			{
				doNext(playerMenu);
				return;
			}
			outputText("",true);
			if (player.will < prisonWillCost(20))
			{
				outputText("You simply don't have the willpower to try to fight your way to freedom right now.",false);
				doNext(playerMenu);
				return;
			}
			changeWill(-prisonWillCost(20));
			prisonEscapeFight();
		}
		
		public function doPrisonEscapeFightLoss():void
		{
			outputText("\n\nYou'll probably come to your senses in eight hours or so, and when you do you'll have an increased understanding of the futility of challenging the power of your captors.",false);
			changeEsteem(-4,inPrison);
			changeObey(1,inPrison);
		}
		
		public function doPrisonEscapeFightWin():void
		{
			outputText("\n\nYou step over the unconscious body of your former guard and head towards the door.\n", false);
			changeEsteem(1,inPrison);
			changeObey(-3,inPrison);
			prisonEscapeSuccessText();
			prisonEscapeFinalePart1();
			//doYesNo(prisonEscapeFinalePart1, playerMenu);
		}
		
		public function doPrisonEscapeSeduce():void
		{
			if (!prisonCanEscapeSeduce())
			{
				doNext(playerMenu);
				return;
			}
			outputText("",true);
			if (player.will < prisonWillCost(10))
			{
				outputText("You simply don't have the willpower to try to seduce your guard right now.",false);
				doNext(playerMenu);
				return;
			}
			changeWill(-prisonWillCost(10));
			prisonEscapeSeduce();
		}
		
		public function doPrisonEscapeBribe():void
		{
			if (!prisonCanEscapeBribe())
			{
				doNext(playerMenu);
				return;
			}
			outputText("",true);
			if (player.will < prisonWillCost(10))
			{
				outputText("You find that you don't have the willpower needed to try to bribe your way free.",false);
				doNext(playerMenu);
				return;
			}
			changeWill(-prisonWillCost(10));
			prisonEscapeBribe();
		}
		
		public function doPrisonEscapeSneak():void
		{
			if (!prisonCanEscapeSneak())
			{
				doNext(playerMenu);
				return;
			}
			outputText("",true);
			if (player.will < prisonWillCost(15))
			{
				outputText("The subterfuge needed to sneak past your guard requires more willpower to execute than you have right now.",false);
				doNext(playerMenu);
				return;
			}
			changeWill(-prisonWillCost(15));
			prisonEscapeSneak();
		}
		
		public function doPrisonEscapeRun():void
		{
			if (!prisonCanEscapeRun())
			{
				doNext(playerMenu);
				return;
			}
			outputText("",true);
			if (player.will < prisonWillCost(5))
			{
				outputText("You don't even have enough willpower at the moment to stand up and walk out the door.",false);
				doNext(playerMenu);
				return;
			}
			changeWill(-prisonWillCost(5));
			prisonEscapeRun();
		}
		
		public function doPrisonEscapeQuestRun():void
		{
			if (!prisonCanEscapeRun())
			{
				doNext(playerMenu);
				return;
			}
			outputText("",true);
			outputText("Knowing you have a task to complete, you work up the courage to take advantage of your completely unrestrained state and cautiously slip out the door when no one is watching.\n",false);
			prisonEscapeSuccessText();
			doNext(prisonEscapeFinalePart1);
		}
		
		public function prisonEscapeFight():void
		{
			/*if (prisonCaptor.escapeFightFunc != "NOFUNC")
			{
				if (this[prisonCaptor.escapeFightFunc]())
				{
					return;
				}
			}*/
			if (rand(100) < player.obey * 0.75 - player.esteem * 0.5)
			{
				outputText("You spend a few minutes trying to steel yourself for your escape attempt but before long you find yourself overwhelmed by the hopelessness of your situation and with fear of what your " + prisonCaptor.captorTitle + " would do if you were caught in the act. You quickly decide not to press your luck any further.",false);
				return;
			}
			prisonLoadGuard(true);
			outputText("You pound on the door for what feels like an eternity.  Just as you are beginining to lose hope that anyone will hear you, the sound of footsteps comes echoing down the hallway.\n\n",false);
			outputText(prisonGuard.guardCaptitalA + " " + prisonGuard.guardType + " bursts through the door but before " + prisonGuard.guardPronoun1 + " can react you jump at " + prisonGuard.guardPronoun2 + " in rage.\n",false);
			prisonEscapeFightStart();
		}
		
		public function prisonEscapeSeduce():void
		{
			var sexyScore:int = 0;
			/*if (prisonCaptor.escapeSeduceFunc != "NOFUNC")
			{
				if (this[prisonCaptor.escapeSeduceFunc]())
				{
					return;
				}
			}*/
			if (rand(100) < player.obey * 0.75 - player.esteem * 0.5)
			{
				outputText("You spend a few minutes trying to steel yourself for your escape attempt but before long you find yourself overwhelmed by the hopelessness of your situation and with fear of what your " + prisonCaptor.captorTitle + " would do if you were caught in the act. You quickly decide not to press your luck any further.",false);
				return;
			}
			prisonLoadGuard(true);
			outputText("You call out for your guard for what feels like an eternity.  Just as you are beginining to lose hope that anyone will hear you, the sound of footsteps comes echoing down the hallway.\n\n",false);
			outputText("As the " + prisonGuard.guardType + " enters the room, " + prisonGuard.guardPronoun1 + " sees you kneeling on all fours presenting your " + player.buttDescript() + " to him like a bitch in heat. As seductively as you can, you ask " + prisonGuard.guardPronoun2 + " how long it has been since " + prisonGuard.guardPronoun1 + " had a good fuck and offer " + prisonGuard.guardPronoun2 + " one in exchange for your freedom.\n\n",false);
			sexyScore = rand(100);
			sexyScore = sexyScore + prisonGuard.guardEscapeSeduceBonus;
			sexyScore = sexyScore + player.cor * 0.25;
			sexyScore = sexyScore + player.lib * 0.25;
			sexyScore = sexyScore + rand(player.lust * 0.5);
			sexyScore = sexyScore + rand(player.inte * 0.1);
			if (sexyScore > 100)
			{
				outputText("Overcome with arousal by your display the " + prisonGuard.guardType + " communicates " + prisonGuard.guardPronoun3 + " agreement with a nod and approaches confidently.",false);
				dynStats("lus", 25);
				prisonEscapeSuccessText();
				doNext(prisonEscapeFinalePart1);
			}
			else if (sexyScore > 50)
			{
				outputText("Obviously aroused by your display the " + prisonGuard.guardType + " definitely seems interested in fucking you, but less so in letting such a pliable slave out of " + prisonGuard.guardPronoun3 + " charge. You brace yourself for punishment as " + prisonGuard.guardPronoun1 + " approaches menacingly.",false);
				dynStats("lus", 100);
				prisonEscapeFightAutoLose();
			}
			else
			{
				outputText("The " + prisonGuard.guardType + " seems completely uninterested in your offer, and walks back out the door.",false);
				doNext(playerMenu);
			}
			
		}
		
		public function prisonEscapeBribe():void
		{
			var charmScore:* = NaN;
			var bribeCost:* = NaN;
			/*if (prisonCaptor.escapeBribeFunc != "NOFUNC")
			{
				if (this[prisonCaptor.escapeBribeFunc]())
				{
					return;
				}
			}*/
			if (rand(100) < player.obey * 0.75 - player.esteem * 0.5)
			{
				outputText("You spend a few minutes trying to steel yourself for your escape attempt but before long you find yourself overwhelmed by the hopelessness of your situation and with fear of what your " + prisonCaptor.captorTitle + " would do if you were caught in the act. You quickly decide not to press your luck any further.",false);
				return;
			}
			prisonLoadGuard(true);
			outputText("You call out for your guard for what feels like an eternity.  Just as you are beginining to lose hope that anyone will hear you, the sound of footsteps comes echoing down the hallway.\n\n",false);
			outputText("As the " + prisonGuard.guardType + " enters the room, you quickly start talking. As cleverly as you can, you point out that there is a large sum of gems sitting with your gear somewhere just outside the door, and offer " + prisonGuard.guardPronoun2 + " as much as " + prisonGuard.guardPronoun1 + " wants in exchange for your freedom.\n\n",false);
			charmScore = rand(100);
			charmScore = charmScore + prisonGuard.guardEscapeBribeBonus;
			charmScore = charmScore + player.cor * 0.25;
			charmScore = charmScore + player.inte * 0.75;
			if (charmScore > 100)
			{
				bribeCost = 1000 + Math.round((player.gems - 1000) / 2);
				player.gems = player.gems - bribeCost;
				outputText("Overcome with greed, the " + prisonGuard.guardType + " communicates " + prisonGuard.guardPronoun3 + " agreement with a nod and leaves the room. When " + prisonGuard.guardPronoun1 + " returns " + prisonGuard.guardPronoun1 + " has a bag that contains somewhere around " + bribeCost + " of your gems. Keeping up " + prisonGuard.guardPronoun3 + " end of the bargain " + prisonGuard.guardPronoun1,false);
				if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 0 || player.statusEffectv3(StatusEffects.PrisonRestraints) > 0 || player.statusEffectv4(StatusEffects.PrisonRestraints) > 0)
				{
					outputText(" removes your restraints and ",false);
					player.changeStatusValue(StatusEffects.PrisonRestraints,2,0);
					player.changeStatusValue(StatusEffects.PrisonRestraints,3,0);
					player.changeStatusValue(StatusEffects.PrisonRestraints,4,0);
				}
				outputText(" gives you a key, then leaves you to your own devices.",false);
				prisonEscapeSuccessText();
				doNext(prisonEscapeFinalePart1);
			}
			else if (charmScore > 50)
			{
				player.gems = player.gems - 100;
				outputText("The " + prisonGuard.guardType + " definitely seems interested in your gems, but more so in teaching you a lesson for thinking you could subvert the " + prisonCaptor.captorTitle + "'s power with mere bribery. You suspect that the " + prisonGuard.guardType + " will probably take some (100) of your gems anyway, but instead of freeing you " + prisonGuard.guardPronoun1 + "'s going to fuck you in trade. You brace yourself for punishment as " + prisonGuard.guardPronoun1 + " approaches menacingly.",false);
				prisonEscapeFightStart();
			}
			else
			{
				outputText("The " + prisonGuard.guardType + " seems completely uninterested in your offer, and walks back out the door.",false);
				doNext(playerMenu);
			}
			
		}
		
		public function prisonEscapeSneak():void
		{
			var stealthScore:int = 0;
			/*if (prisonCaptor.escapeSneakFunc != "NOFUNC")
			{
				if (this[prisonCaptor.escapeSneakFunc]())
				{
					return;
				}
			}*/
			prisonLoadGuard(true);
			if (rand(100) < player.obey * 0.75 - player.esteem * 0.5)
			{
				outputText("You spend a few minutes trying to steel yourself for your escape attempt but before long you find yourself overwhelmed by the hopelessness of your situation and with fear of what your " + prisonCaptor.captorTitle + " would do if you were caught in the act. You quickly decide not to press your luck any further.",false);
				return;
			}
			outputText("You pound on the door for what feels like an eternity.  Just as you are beginining to lose hope that anyone will hear you, the sound of footsteps comes echoing down the hallway.\n\n",false);
			outputText(prisonGuard.guardCaptitalA + " " + prisonGuard.guardType + " bursts through the door and briefly looks around in confusion.\n\n",false);
			stealthScore = rand(100);
			stealthScore = stealthScore + prisonGuard.guardEscapeSneakBonus;
			stealthScore = stealthScore + player.spe * 0.25;
			stealthScore = stealthScore + player.inte * 0.25;
			if (stealthScore > 140)
			{
				outputText("When " + prisonGuard.guardPronoun1 + " doesn't see you, " + prisonGuard.guardPronoun1 + " walks further into the room leaving the door open in " + prisonGuard.guardPronoun3 + " befuddlement. You take this opportunity to quickly and quietly slip out of the shadowed corner where you were hiding and pull the door shut behind you, locking the " + prisonGuard.guardType + " inside. ",false);
				prisonEscapeSuccessText();
				doNext(prisonEscapeFinalePart1);
			}
			else if (stealthScore > 50)
			{
				outputText("When " + prisonGuard.guardPronoun1 + " doesn't see you, he takes a step further into the room continuing to search for " + prisonGuard.guardPronoun3 + " seemingly missing charge. Seeing that the door is still open behind " + prisonGuard.guardPronoun2 + " you decide this is your moment to slip past, and crawl from the shadowed corner where you were hiding. The " + prisonGuard.guardType + " hears you immediately and you brace yourself for punishment as " + prisonGuard.guardPronoun1 + " approaches menacingly.",false);
				prisonEscapeFightStart();
			}
			else
			{
				outputText("The " + prisonGuard.guardType + " immediately sees you crouching stupidly in a corner, and assumes you are cowering in fear. Perplexed, " + prisonGuard.guardPronoun1 + " turns around and leaves the room",false);
				doNext(playerMenu);
			}
			
		}
		
		public function prisonEscapeRun():void
		{
			/*if (prisonCaptor.escapeRunFunc != "NOFUNC")
			{
				if (this[prisonCaptor.escapeRunFunc]())
				{
					return;
				}
			}*/
			prisonLoadGuard(true);
			if (rand(100) < player.obey * 0.75 - player.esteem * 0.5)
			{
				outputText("You spend a few minutes trying to steel yourself for your escape attempt but before long you find yourself overwhelmed by the hopelessness of your situation and with fear of what your " + prisonCaptor.captorTitle + " would do if you were caught in the act. You quickly decide not to press your luck any further.",false);
				return;
			}
			outputText("You work up the courage to take advantage of your completely unrestrained state and cautiously slip out the door when no one is watching.\n",false);
			prisonEscapeSuccessText();
			doNext(prisonEscapeFinalePart1);
		}
		
		public function prisonEscapeSuccessText():void
		{
			outputText("\n\nAs you leave your former cell, ",false);
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) > 0 || player.statusEffectv3(StatusEffects.PrisonRestraints) > 0 || player.statusEffectv4(StatusEffects.PrisonRestraints) > 0)
			{
				outputText("you hastily remove your remaining restraints. Nearby ",false);
			}
			outputText("you notice a conspicuous looking chest. Upon opening it you are relieved to see that it contains your old items and gear, which you reclaim.\n\n",false);
		}
		
		public function prisonEscapeFinalePart1():void
		{
			var textArray:Array = [];
			player.removeStatusEffect(StatusEffects.PrisonRestraints);
			prisonItemsRetrieve();
			if (flags[kFLAGS.PRISON_STORAGE_ARMOR] != 0) {
				textArray.push(prisonArmorRetrieve());
				//return;
			}
			if (flags[kFLAGS.PRISON_STORAGE_WEAPON] != 0) {
				textArray.push(prisonWeaponRetrieve());
				//return;
			}
			if (flags[kFLAGS.PRISON_STORAGE_SHIELD] != 0) {
				textArray.push(prisonShieldRetrieve());
				//return;
			}
			if (textArray.length > 0) outputText("You equip your " + formatStringArray(textArray) + ".\n\n");
			prisonEscapeFinalePart2();
			return;
		}
		
		public function prisonEscapeFinalePart2():void
		{
			flags[kFLAGS.IN_PRISON] = 0;
			outputText("Having retrieved your old items, you quietly make your way out of your captor's stronghold and head back towards your camp.");
			if (!flags[kFLAGS.PRISON_CAPTURE_CHANCE] || flags[kFLAGS.PRISON_CAPTURE_CHANCE] <= 0)
			{
				doNext(captorChanceChoose);
			}
			else
			{
				doNext(camp.returnToCampUseOneHour);
			}
			return;
		}
		
		//Retrieval
		public function prisonItemsRetrieve():void
		{
			for (var i:int = 0; i < 10; i++) {
				if (player.prisonItemSlots[i*2] != undefined) {
					player.itemSlot(i).setItemAndQty(ItemType.lookupItem(player.prisonItemSlots[i*2]), player.prisonItemSlots[(i*2) +1]);
				}
			}
			player.prisonItemSlots = []; //CLEAR!
		}
		public function prisonArmorRetrieve():String
		{
			var temp:String = "";
			if (flags[kFLAGS.PRISON_STORAGE_ARMOR] != 0) {
				var tempArmor:* = ItemType.lookupItem(flags[kFLAGS.PRISON_STORAGE_ARMOR]);
				if (tempArmor != null) player.setArmor(tempArmor);
				temp = player.armorName;
				//inventory.takeItem(ItemType.lookupItem(flags[kFLAGS.PRISON_STORAGE_ARMOR]), prisonEscapeFinalePart1);
			}
			flags[kFLAGS.PRISON_STORAGE_ARMOR] = 0;
			return temp;
		}
		public function prisonWeaponRetrieve():String
		{
			var temp:String = "";
			if (flags[kFLAGS.PRISON_STORAGE_WEAPON] != 0) {
				var tempWeapon:* = ItemType.lookupItem(flags[kFLAGS.PRISON_STORAGE_WEAPON]);
				if (tempWeapon != null) player.setWeapon(tempWeapon);
				temp = player.weaponName;
				//inventory.takeItem(ItemType.lookupItem(flags[kFLAGS.PRISON_STORAGE_WEAPON]), prisonEscapeFinalePart1);
			}
			flags[kFLAGS.PRISON_STORAGE_WEAPON] = 0;
			return temp;
		}
		public function prisonShieldRetrieve():String
		{
			var temp:String = "";
			if (flags[kFLAGS.PRISON_STORAGE_SHIELD] != 0) {
				var tempShield:* = ItemType.lookupItem(flags[kFLAGS.PRISON_STORAGE_SHIELD]);
				if (tempShield != null) player.setShield(tempShield);
				temp = player.shieldName;
				//inventory.takeItem(ItemType.lookupItem(flags[kFLAGS.PRISON_STORAGE_SHIELD]), prisonEscapeFinalePart1);
			}
			flags[kFLAGS.PRISON_STORAGE_SHIELD] = 0;
			return temp;
		}
		
		//Conclusion
		public function captorChanceChoose():void {
			clearOutput();
			outputText("As you make your way back to camp, you can't help but think about how easy it is to find yourself knocked unconscious and left helpless in the wilderness of Mareth. While slave hunters have never plucked you off the ground in such a state before, now that you've bumbled into being captured by them you consider that they might come hunting for you now that you've escaped. You give it a moment's thought. Are you now in danger of being recaptured should you be defeated in combat?",false);
			simpleChoices("Likely", chooseLikelyChance, "Maybe", chooseMaybeChance, "Never", chooseNeverChance, "", null, "", null);
		}
		
		public function chooseLikelyChance():void
		{
			outputText("\n\nYou realize that " + prisonCaptor.captorTitle + " " + prisonCaptor.captorName + " isn't going to be happy about losing " + prisonCaptor.captorPronoun3 + " new toy, and that if you don't pick and choose your battles wisely it will only be a matter of time before you are back in " + prisonCaptor.captorPronoun3 + " dungeons.",false);
			if (player.obey < 10)
			{
				outputText(" The thought of it chills you to the bone.",false);
			}
			else if (player.obey < 25)
			{
				outputText(" The thought of it unsettles you.",false);
			}
			else if (player.obey < 45)
			{
				outputText(" The thought of it fills you with an uncomfortable mixture of terror and anticipation.",false);
			}
			else if (player.obey < 70)
			{
				outputText(" The thought of it is actually exciting and comforting.",false);
			}
			else
			{
				outputText(" The thought of it fills you with a desire to run to the mountains and let the minotaurs beat and fuck you over and over again. It would serve you right for daring to defy your " + prisonCaptor.captorTitle + ", and it would hasten your inevitable return to " + prisonCaptor.captorPronoun3 + " dominion.",false);
			}
			outputText("\n\n<b>Of course, you could always return to the prison anytime from the Places menu.</b>");
			flags[kFLAGS.PRISON_CAPTURE_CHANCE] = 50;
			doNext(camp.returnToCampUseOneHour);
			return;
		}
		public function chooseMaybeChance():void
		{
			outputText("\n\nWhile " + prisonCaptor.captorTitle + " " + prisonCaptor.captorName + " isn't going to be happy about losing " + prisonCaptor.captorPronoun3 + " new toy, Mareth is a big place. If you don't pick and choose your battles wisely you might find yourself back in " + prisonCaptor.captorPronoun3 + " dungeons, but depending on your luck you might just avoid being found by slave hunters.",false);
			if (player.obey < 10)
			{
				outputText(" Still, the thought of being caught again chills you to the bone.",false);
			}
			else if (player.obey < 25)
			{
				outputText(" Still, the thought of being caught again unsettles you.",false);
			}
			else if (player.obey < 45)
			{
				outputText(" Still, the thought of being caught again fills you with an uncomfortable mixture of terror and anticipation.",false);
			}
			else if (player.obey < 70)
			{
				outputText(" Still, the thought of being caught again is actually exciting and comforting.",false);
			}
			else
			{
				outputText(" Still, the thought of being caught again fills you with a desire to run to the mountains and let the minotaurs beat and fuck you over and over again. It would serve you right for daring to defy your " + prisonCaptor.captorTitle + ", and it would hasten your inevitable return to " + prisonCaptor.captorPronoun3 + " dominion.",false);
			}
			outputText("\n\n<b>Of course, you could always return to the prison anytime from the Places menu.</b>");
			flags[kFLAGS.PRISON_CAPTURE_CHANCE] = 15;
			doNext(camp.returnToCampUseOneHour);
			return;
		}
		public function chooseNeverChance():void
		{
			outputText("\n\n" + prisonCaptor.captorTitle + " " + prisonCaptor.captorName + " definitely isn't going to be happy about losing " + prisonCaptor.captorPronoun3 + " new toy, but you doubt that " + prisonCaptor.captorPronoun1 + " really cares enough to devote resources to hunting you down.",false);
			if (player.obey < 25)
			{
				outputText(" As long as you avoid dark alleys in unsavory places, you will never have to see the inside of that dungeon again.",false);
			}
			else if (player.obey < 45)
			{
				outputText(" You are discomforted to realize that a good part of you is dissapointed by this fact, and somewhere in the back of your mind you find yourself considering exploring a few dark alleys the next time you visit the more unsavory corners of Mareth.",false);
			}
			else if (player.obey < 70)
			{
				outputText(" Suddenly you are overcome with dissapointment by this fact, and you find yourself actively fantasizing about exploring dark alleys the next time you visit the more unsavory corners of Mareth.",false);
			}
			else
			{
				outputText(" This horrifies you, and you already crave punishment for daring to defy your " + prisonCaptor.captorTitle + ". Perhaps submitting to the whims of every monster you encounter might begin to suffice, but you know that sooner or later you're just going to have to seek out the slavers again and throw yourself at their mercy. Perhaps you can begin by exploring a few dark alleys the next time you visit one of the more unsavory corners of Mareth.",false);
			}
			outputText("\n\n<b>Of course, you could always return to the prison anytime from the Places menu.</b>");
			flags[kFLAGS.PRISON_CAPTURE_CHANCE] = -1;
			doNext(camp.returnToCampUseOneHour);
			return;
		}
		
		public function prisonEscapeFightStart(combatID:Monster = null):void
		{
			if (!combatID)
			{
				var combatID:Monster = prisonGuard.guardCombatID;
			}
			prisonCombat = true;
			prisonCombatLoseEvent = doPrisonEscapeFightLoss;
			prisonCombatWinEvent = doPrisonEscapeFightWin;
			startCombat(combatID);
		}
		
		public function prisonEscapeFightAutoLose(combatID:Monster = null):void
		{
			if (!combatID)
			{
				var combatID:Monster = prisonGuard.guardCombatID;
			}
			prisonCombat = true;
			prisonCombatAutoLose = true;
			prisonCombatLoseEvent = doPrisonEscapeFightLoss;
			prisonCombatWinEvent = doPrisonEscapeFightWin;
			startCombat(combatID);
		}
		
		public function prisonEscapeSeduceAutoLose(combatID:Monster = null):void
		{
			if (!combatID)
			{
				var combatID:Monster = prisonGuard.guardCombatID;
			}
			prisonCombat = true;
			prisonCombatAutoLose = true;
			prisonCombatLoseEvent = doPrisonEscapeFightLoss;
			prisonCombatWinEvent = doPrisonEscapeFightWin;
			startCombat(combatID);
		}
		
		public function prisonCaptorWaitRestraintStatChange():Boolean
		{
			var fatigueChange:Number = 0;
			var willChange:Number = 0;
			var lustChange:Number = 0;
			var needNext:Boolean = false;
			if (player.statusEffectv4(StatusEffects.PrisonRestraints) < 1)
			{
				willChange = willChange - (0.3 - player.obey * 0.005);
				if (player.cor > 40)
				{
					lustChange = lustChange + 0.3;
				}
				if (player.obey > 45)
				{
					lustChange = lustChange + player.obey * 0.005;
				}
			}
			if (player.statusEffectv4(StatusEffects.PrisonRestraints) < 2)
			{
				willChange = willChange - 0.2;
				if (player.obey > 70)
				{
					lustChange = lustChange + player.obey * 0.005;
				}
				fatigueChange = fatigueChange + 0.01;
			}
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) < 1)
			{
				willChange = willChange - (0.3 - player.obey * 0.005);
				if (player.cor > 40)
				{
					lustChange = lustChange + 0.3;
				}
				if (player.obey > 45)
				{
					lustChange = lustChange + player.obey * 0.005;
				}
				fatigueChange = fatigueChange + 0.01;
			}
			changeWill(willChange);
			player.changeFatigue(fatigueChange);
			dynStats("lus", lustChange);
			return needNext;
		}
		
		public function prisonCaptorWaitUpdates():Boolean
		{
			var needNext:Boolean = false;
			var newVal:int = 0;
			var newCleanliness:int = 0;
			var statusVal:int = 0;
			if (flags[kFLAGS.PRISON_DIRT_ENABLED] > 0)
			{
				newCleanliness = player.statusEffectv2(StatusEffects.PrisonCaptorEllyStatus) + 1;
				if (newCleanliness > 100)
				{
					newCleanliness = 100;
				}
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus, 2, newCleanliness);
			}
			if (flags[kFLAGS.PRISON_PUNISHMENT] > 0 && flags[kFLAGS.PRISON_PUNISHMENT] <= 3)
			{
				newVal = player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) - 1;
				if (newVal < 0)
				{
					newVal = 0;
				}
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,3,newVal);
			}
			if (flags[kFLAGS.PRISON_PUNISHMENT] == 4)
			{
				newVal = player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus);
				if (newVal < 0)
				{
					newVal++;
				}
				else if (newVal > 0)
				{
					newVal--;
				}
				
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus, 3, newVal);
			}
			if (flags[kFLAGS.PRISON_PUNISHMENT] == 2)
			{
				statusVal = player.statusEffectv4(StatusEffects.PrisonCaptorEllyStatus);
				if (statusVal <= 3)
				{
					player.changeFatigue((20 - statusVal) * 0.35);
				}
				else if (statusVal <= 7)
				{
					player.changeFatigue(statusVal * 0.4);
					dynStats("lus", statusVal * 0.2);
				}
				else if (statusVal <= 17)
				{
					player.changeFatigue(statusVal * 0.4);
					dynStats("lus", statusVal * 0.4);
				}
				else
				{
					player.changeFatigue(statusVal * 0.4);
					dynStats("lus", statusVal * 0.5);
				}
				
			}
			return needNext;
		}
		
		public function prisonCaptorWaitEvents():Boolean
		{
			var eventOccurred:* = undefined;
			eventOccurred = false;
			if (flags[kFLAGS.PRISON_PUNISHMENT] == 1)
			{
				if (rand(8) == 0)
				{
					prisonCaptor.updateNextWaitRandomEvent(model.time.hours, model.time.days);
					punishments.prisonCaptorPunishmentStockadesVisitor();
					return true;
				}
			}
			if (flags[kFLAGS.PRISON_PUNISHMENT] == 2)
			{
				if (rand(100) + player.fatigue * 0.5 + player.lust * 0.5 - (player.str + player.tou) * 0.2 > 50)
				{
					prisonCaptor.updateNextWaitRandomEvent(model.time.hours, model.time.days);
					outputText("\n\nYour [legs] give in to lust and fatigue and you impale yourself a bit further on the dildos below you. ",false);
					punishments.prisonCaptorPunishmentConfinementRestlegs();
					return true;
				}
			}
			if (randomCooldownPetDream <= 0 && rand(100) < 30 + trainingPet.prisonCaptorPetScore() && prison.trainingPet.prisonCaptorPetTier() >= 2 && !prisonCaptor.roomEventOverride[flags[kFLAGS.PRISON_PUNISHMENT]] && !prison.trainingPet.prisonCaptorPetOptedOut())
			{
				eventOccurred = trainingPet.prisonCaptorPetDreamStart();
				if (eventOccurred)
				{
					prisonCaptor.updateNextWaitRandomEvent(model.time.hours, model.time.days);
				}
			}
			return eventOccurred;
		}
		
		public function prisonCaptorRandomEventSounds():Boolean
		{
			outputText("\nThe muffled screams and moans of one of your fellow prisoners being punished penetrate the thick walls of your cell and echo in the air.",false);
			if (player.obey > 45)
			{
				if (player.obey > 70)
				{
					outputText(" You are consumed with jealousy and arousal ",false);
					dynStats("lus", 10);
				}
				else
				{
					outputText(" To your great shame you can't help but feel aroused ",false);
					dynStats("lus", 5);
				}
				outputText("wishing that it was you being subjected to whatever treatment is eliciting that response.",false);
				changeEsteem(-1,inPrison);
				changeWill(-10);
			}
			else if (player.cor > 50)
			{
				outputText(" The sound is so deliciously exciting that you can't help but wish you were the one being tortured.",false);
				dynStats("lus", 5);
				changeWill(-5);
				changeObey(1,inPrison);
			}
			else
			{
				outputText(" The sound reminds you of the hopelessness of your situation.",false);
				changeWill(-15);
			}
			
			outputText("\n",false);
			doNext(playerMenu);
			return true;
		}
		
		public function prisonCaptorRoomEvents():Boolean
		{
			if (flags[kFLAGS.IN_PRISON] == 0) return false; //Make sure events don't proc!
			var eventOccurred:Boolean = false;
			if ((flags[kFLAGS.PRISON_PUNISHMENT] == 0 || flags[kFLAGS.PRISON_PUNISHMENT] == 3) && player.lust >= player.maxLust() && rand(3) == 0)
			{
				//prisonCaptor.updateNextRoomRandomEvent(model.time.hours, model.time.days);
				//Wild Dildo Rack appears!
				if (rand(2) == 1 && !prisonCanMasturbate(false) && flags[kFLAGS.PRISON_DILDO_RACK] == 0)
				{
					trace("Dildo rack");
					outputText(prisonCaptor.captorTitle + " " + prisonCaptor.captorName + " enters the room to find you writhing on the floor with unmanageable lust and is clearly amused by your pathetic state of affairs. After a moment's thought " + prisonCaptor.captorPronoun1 + " comes to a decision and says, \"<i>Even naughty " + player.mf("boy", "girl") + "s deserve to have a special friend at times like this, and I happen to have a friend that should help you learn the value of good behavior while solving your current dilemma.</i>\" A wry smirk crosses " + prisonCaptor.captorPronoun3 + " face as " + prisonCaptor.captorPronoun1 + " leaves the room. A few minutes later an imp guard drags a strange object into the room, sets it beside you, then leaves you to ponder it alone.\n\n",false);
					outputText("Your new \"friend\" appears to be a four foot tall round post with a wide variety of dildos sticking out at every imaginable height and angle. While the tower and its appendages are made of some sort of slick black latex-like material, the entire construction radiates a strange energy, almost as though it could come alive at any moment. It occurs to you that in an odd way it resembles a pine tree, since the dildos become progressively larger the closer they are to the ground. You are puzzled for a second, then suddenly you understand.\n\n",false);
					outputText("A horny slave who was able to move about freely could reach the most pleasant and appealing looking dongs near the top: modestly sized, generally human looking phalluses with mild ribs, bumps and other features designed to give extra pleasure to the user. You notice that there are even several metal rings hanging from the ceiling above the post which could facilitate more creative positions for using the highest of the dildos.\n\n",false);
					outputText("A mildly restrained slave who could still stand or squat, however, would only be able to reach the middle tier of simulated cocks. While none of these look too unpleasant, they are all of a size that would challenge even a well-practiced pussy or asshole. Many of them look like oversized dog and cat dicks, but others have more esoteric shapes and designs, with shocking twists, bumps, and spurs that would make fucking them a bit of an adventure, to say the least.\n\n",false);
					outputText("Finally, a slave whose bad behavior had earned them restraints that kept them from doing more than kneeling or crawling would have no choice but to impale themself on the world shattering monstrosities near the base of the dildo rack if they wanted to relieve their pent up sexual energy. The sight of these tremendous equine members, frightening demonic rods, and other indescribable oversized shafts leaves no uncertainty about what kind of lessons your " + prisonCaptor.captorTitle + " expects you to learn from your new cellmate.\n\n",false);
					if (player.obey > 45)
					{
						outputText("An overwhelming need to subject yourself to this new form of punishment as soon as possible washes over you.",false);
					}
					else if (player.cor > 50)
					{
						outputText("You can't help but feel a sense of gratitude to your captor for giving you such an exciting new toy, and look forward to making use of it.",false);
					}
					else
					{
						outputText("You aren't sure what is more demoralizing: the fact that you now have to share you living space with this unholy thing, or the fact that you almost certainly will be making use of it given your current state of arousal and restraint.",false);
					}
					
					flags[kFLAGS.PRISON_DILDO_RACK] = 1;
					return true;
				}
				//Wild Billie appears!
				if (billieScene.prisonCaptorBillieMet() > 0 && rand(5) < billieScene.prisonCaptorBillieEvent())
				{
					trace("Billie");
					billieScene.prisonCaptorBillieEventSet(1);
					billieScene.prisonCaptorBilliePityFuck();
					return true;
				}
				billieScene.prisonCaptorBillieEventChange(1);
				trace("Elly");
				outputText(prisonCaptor.captorTitle + " " + prisonCaptor.captorName + " enters the room to find you writhing on the floor with unmanageable lust and is clearly amused by your pathetic state of afairs. After a moment's thought " + prisonCaptor.captorPronoun1 + " comes to a decision and says, \"<i>Beg me to fuck you, and I might take pity on you.</i>\"\n\n",false);
				outputText("Do you give in to your lust and beg your " + prisonCaptor.captorTitle + " to fuck you, or do you try to resist? " + prisonWillCostDescript(15),false);
				simpleChoices("Beg",prisonCaptorBegSubmit,"Resist",prisonCaptorBegResist,"",null,"",null,"",null);
				return true;
			}
			//Pet dreams
			var petDreamRarity:int = 8;
			petDreamRarity -= trainingPet.prisonCaptorPetScore() / 5;
			if (petDreamRarity < 2) petDreamRarity = 2;
			if (randomCooldownPetDream <= 0 && rand(petDreamRarity) == 0 && !trainingPet.prisonCaptorPetOptedOut()) {
				randomCooldownPetDream = 8 + rand(8);
				if (trainingPet.prisonCaptorPetScore() == 0) trainingPet.prisonCaptorPetDreamIntro();
				else if (trainingPet.prisonCaptorPetScore() < 5) trainingPet.prisonCaptorPetDreamLazy();
				else if (trainingPet.prisonCaptorPetScore() < 10) trainingPet.prisonCaptorPetDreamModest();
				else if (trainingPet.prisonCaptorPetScore() < 25) trainingPet.prisonCaptorPetDreamExcited();
				else trainingPet.prisonCaptorPetPlayOffer();
				return true;
			}
			//Punishments
			if (flags[kFLAGS.PRISON_PUNISHMENT] == 1)
			{
				if (player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) == 0)
				{
					punishments.prisonCaptorPunishmentStockadesFreedom();
					return true;
				}
			}
			if (flags[kFLAGS.PRISON_PUNISHMENT] == 2)
			{
				if (player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) == 0)
				{
					punishments.prisonCaptorPunishmentConfinementFreedom();
					return true;
				}
			}
			if (flags[kFLAGS.PRISON_PUNISHMENT] == 3)
			{
				if (player.statusEffectv3(StatusEffects.PrisonCaptorEllyStatus) == 0)
				{
					punishments.prisonCaptorPunishmentBJTrainerTimesup();
					return true;
				}
			}
			return eventOccurred;
		}
		
		public function prisonCaptorRandomEventCleaningCheck():void
		{
			hideMenus();
			clearOutput();
			var cleanlinessLevel:int = 0;
			outputText(prisonCaptor.captorTitle + " " + prisonCaptor.captorName + " enters the room and begins to inspect its level of cleanliness. ",false);
			if (flags[kFLAGS.PRISON_DIRT_ENABLED] == 0)
			{
				outputText("\"<i>A worthless piece of meat such as yourself has no reason to care if they live in filth -- you should simply be grateful to have a roof over your head and a " + prisonCaptor.captorTitle + " to give you a purpose in life. However, you should certainly be concerned with offending your " + prisonCaptor.captorTitle + " with that filth.</i>\" As the words fill the room, " + prisonCaptor.captorPronoun3 + " displeasure is almost palpable.",false);
				outputText("\n\n\"<i>Mark my words, slave: you <b>will</b> keep this room clean.</i>\" Nothing more needs to be said for you to understand that there will be consequences if you don't.", false);
				outputText("\n\n<b>From now on, Elly will check your cell every day at 4pm.</b>");
				flags[kFLAGS.PRISON_DIRT_ENABLED] = 1;
				prisonCaptorTrainingStatusUpdate();
				player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,2,51);
				doNext(playerMenu);
				return;
			}
			outputText("From the look on " + prisonCaptor.captorPronoun3 + " face you know immediately that ",false);
			cleanlinessLevel = Math.floor(player.statusEffectv2(StatusEffects.PrisonCaptorEllyStatus) / 25);
			switch(cleanlinessLevel)
			{
				case 0:
					outputText(prisonCaptor.captorPronoun1 + " is satisfied with what [captorhe] sees.",false);
					doNext(playerMenu);
					return;
				case 1:
					outputText(prisonCaptor.captorPronoun1 + " is a bit annoyed with what [captorhe] sees, but not overly upset.\n\n",false);
					prisonPunishment(100);
					return;
				case 2:
					outputText(prisonCaptor.captorPronoun1 + " is furious over what [captorhe] sees, and that you are in trouble.\n\n",false);
					prisonPunishment(50);
					return;
				case 3:
				case 4:
				default:
					outputText("you are about to suffer [captorhis] wrath.\n\n",false);
					prisonPunishment(0);
					return;
			}
			doNext(playerMenu);
		}
		
		public function prisonCaptorPunishmentRestrain():void
		{
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) == 0)
			{
				player.changeStatusValue(StatusEffects.PrisonRestraints,2,1);
			}
			else if (player.statusEffectv3(StatusEffects.PrisonRestraints) < 2)
			{
				player.changeStatusValue(StatusEffects.PrisonRestraints,3,player.statusEffectv2(StatusEffects.PrisonRestraints) + 1);
			}
			else if (player.statusEffectv4(StatusEffects.PrisonRestraints) == 0)
			{
				player.changeStatusValue(StatusEffects.PrisonRestraints,4,0);
			}
			else if (player.statusEffectv2(StatusEffects.PrisonRestraints) < 2)
			{
				player.changeStatusValue(StatusEffects.PrisonRestraints,2,2);
			}
			else if (player.statusEffectv4(StatusEffects.PrisonRestraints) < 3)
			{
				player.changeStatusValue(StatusEffects.PrisonRestraints,4,player.statusEffectv4(StatusEffects.PrisonRestraints) + 1);
			}
			else
			{
				prisonPunishment(0);
				return;
			}
			
			outputText("(Placeholder) [captorTitle] [captorName] reaches a decision. \"<i>Perhaps having your freedoms a bit more restricted for a while will help you show some respect,</i>\" " + prisonCaptor.captorPronoun1 + " says as " + prisonCaptor.captorPronoun1 + " adjusts your restraints.",false);
			doNext(playerMenu);
		}
	  
		public function prisonCaptorRestraintCheckEvent():Boolean
		{
			if (player.statusEffectv2(StatusEffects.PrisonRestraints) == 0 && player.statusEffectv3(StatusEffects.PrisonRestraints) == 0 && player.statusEffectv4(StatusEffects.PrisonRestraints) == 0)
			{
				if (player.obey >= 95 && player.statusEffectv1(StatusEffects.PrisonRestraints) > 0)
				{
					outputText("\nYour " + prisonCaptor.captorTitle + " enters the room and looks pensive for a moment, then " + prisonCaptor.captorPronoun1 + " declares decisively, \"<i>I don't think we need to bother keeping the door locked anymore. Even if you do somehow work up the nerve to walk out the door, you'll soon find your way back to where you know you belong.</i>\"\n",false);
					player.changeStatusValue(StatusEffects.PrisonRestraints, 1, 0);
					flags[kFLAGS.PRISON_DOOR_UNLOCKED] = 1;
					doNext(playerMenu);
					return true;
				}
				return false;
			}
			if (true || !(prisonCaptor.captorName == "Elly"))
			{
				outputText("\n" + prison.prisonCaptor.captorTitle + " " + prisonCaptor.captorName + " enters the room and looks pensive for a moment, then " + prisonCaptor.captorPronoun1 + " declares decisively, \"<i>I think you might be learning your lesson. As a reward, I'll loosen your bindings a bit.</i>\"\n",false);
				prisonRestraintReduction(1);
				doNext(playerMenu);
				return true;
			}
			return false;
		}
		
		public function prisonLoadGuard(randomGuard:Boolean, guardID:String = "default"):void
		{
			prisonGuard.prisonCaptorLoadGuard(randomGuard,guardID);
		}
		
		public function prisonPunishment(lightChance:Number):void
		{
			prisonCaptor.selectPunishmentEvent(lightChance);
		}
		
		public function prisonCaptorBegSubmit():void
		{
			clearOutput();
			outputText("Unable to control yourself, you grovel on the floor begging your " + prisonCaptor.captorTitle + " to fuck you.\n\n",false);
			prisonCaptorSubmitFuck();
		}
		
		public function prisonCaptorBegResist():void
		{
			clearOutput();
			if (player.will < prisonWillCost(15))
			{
				outputText("While you'd like to preserve a bit of your dignity, you simply don't have the willpower to resist right now. \n\n",false);
				changeEsteem(2,inPrison);
				prisonCaptorSubmitFuck();
				return;
			}
			outputText("(Placeholder) You manage to resist the urge to beg your " + prisonCaptor.captorTitle + " to fuck you for now, but you aren't sure how much longer you can hold out.",false);
			changeEsteem(5,inPrison);
			changeObey(-1,inPrison);
			changeWill(-prisonWillCost(15));
			doNext(playerMenu);
		}
		
		public function prisonCaptorSubmitFuck():void
		{
			var selector:* = undefined;
			selector = 0;
			if (player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus) < 3)
			{
				selector = rand(3);
			}
			else
			{
				selector = rand(10);
				if (player.findStatusEffect(StatusEffects.Heat) >= 0)
				{
					selector = 6;
				}
			}
			switch(selector)
			{
				case 0:
				case 1:
				case 2:
					if (player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus) < 3)
					{
						outputText("(Placeholder) \"<i>You haven't yet earned the privilege of getting fucked by my cock.");
					}
					else
					{
						outputText("(Placeholder) \"<i>Being fucked by my cock would be too much of a reward given your recent behavior.");
					}
					outputText(" Perhaps you will be worthy of it next time. But don't worry, we'll still have plenty of fun.</i>\" She directs you to grab hold of a ring hanging above your head, and expertly teases your erogenous zones with her skillful hands until you become weak in the knees, lose your grip, and collapse to the floor. She then makes you lie on your back and hold your ankles, and she works the fingers on one hand into your [asshole] while teasing your genitals with the other. \n\n");
					outputText("Eventually she squeezes her entire hand inside and allows you to orgasm.");
					if (player.hasCock())
					{
						outputText("Thanks to her stimulation of your prostate you cum buckets, painting your [fullChest] and [face] with your sticky goo.");
					}
					if ((player.hasVagina()) && player.wetness() >= 4)
					{
						if (player.hasCock())
						{
							outputText("At the same time, your");
						}
						else
						{
							outputText("Your");
						}
						outputText(" abdomen is wracked with spasms of pleasure as a fountain of clear, viscous fluid erupts from your [cunt] and coats your Mistress' head and torso. She allows herself to indulge in a moment of ecstasy, rubbing your juices into her firm, shapely tits with her left hand while using them to massage her dick with her right. Despite being lost in your own pleasure, you cannot help but feel gratifed watching her face, eyes closed, head tilted back, mouth agape, fiery red bangs haphazardly scattered across her face in sticky strands. Then the moment passes, and she speaks.");
					}
					outputText("\"<i>Do you understand now, slave? Your body craves my abuse. Embrace it -- once you do, your life will become an unending river of pleasure</i>\"");
					//buttChange(12,true,true,false); //Doesn't count as it would be a waste of virginity.
					break;
				case 3:
				case 4:
				case 5:
					billieScene.prisonCaptorBilliePunishmentFuck("choose");
					return;
				case 6:
					if (player.hasVagina())
					{
						outputText("(Placeholder) \"<i>You're going to get a special treat today, [boy], but first you need to beg me to put a baby in your dirty [cunt].</i>\" After a brief hesitation, you do so. She makes you present yourself like a bitch in heat while continuing to beg. Finally she gives you want you want, and fills your womb with her potent seed.\n\n");
						player.knockUp(PregnancyStore.PREGNANCY_IMP, 350, 50);
						player.cuntChange(32,true,true,false);
						break;
					}
				case 7:
				case 8:
				case 9:
				default:
					outputText("(Placeholder) You assume a submissive position and your " + prisonCaptor.captorTitle + " has " + prisonCaptor.captorPronoun3 + " way with you, pounding your [asshole] mercilessly until you orgasm from the shameful stimulation. \"<i>Do you understand now, slave? I don't even have to touch your ",false);
					if (player.hasCock())
					{
						outputText("pathetic [cock]");
					}
					else if (player.hasVagina())
					{
						outputText("dirty [cunt]");
					}
					else
					{
						outputText("silly little mound");
					}
					
					outputText(" to make you spurt. Your body wants to be used by my dick and filled with my seed. You are a cocksucking, anal loving, cum-slut. Accept it.</i>\"");
					player.buttChange(32,true,true,false);
			}
			player.slimeFeed();
			changeObey(1,inPrison);
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorResistFuck():void
		{
			var selector:* = undefined;
			selector = 0;
			if (player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus) < 3)
			{
				selector = rand(3);
			}
			else
			{
				selector = rand(10);
				if (player.findStatusEffect(StatusEffects.Heat) >= 0)
				{
					selector = 6;
				}
			}
			switch(selector)
			{
				case 0:
				case 1:
				case 2:
					if (player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus) < 3)
					{
						outputText("(Placeholder) \"<i>You haven't yet earned the privilege of getting fucked by my cock.");
					}
					else
					{
						outputText("(Placeholder) \"<i>Being fucked by my cock would be too much of a reward given your recent behavior.");
					}
					outputText(" Perhaps you will be worthy of it next time. But don't worry, we'll still have plenty of fun.</i>\" She directs you to grab hold of a ring hanging from the ceiling, but you petulantly remain seated. This angers her, and she quickly binds your hands above your head and hangs you from a hook. She then expertly teases your erogenous zones with her skillful hands until you become weak in the knees and find yourself trying to support your weight any way you can. She allows you to struggle for a bit, then coerces you into begging for help. \n\n");
					outputText("When you do, she wraps straps around your knees, fastens then to nearby hooks, and draws them up so that you are half reclined with your legs drawn upward and outward beside your torso and you swing uncomfortably from your three supports. With you completely at her mercy, she begins to works the fingers of one hand into your [asshole] while teasing your genitals with the other. \n\n");
					if (player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus) > 2 && rand(2) == 1)
					{
						outputText("With four fingers in your bum and you teetering on the agonizing edge of orgasm, she decides to give you a second chance. She gives you a chance to beg her for her cock, and you take it. She then stands between your legs, replaces the fingers in your ass with the tip of her enormous cock. However, instead of fucking you, she tells you that you will need to show your contrition and fuck yourself. Overwhelmed by lust, you immediately respond, clumsily shifting your weight forward and backward until you find your self swinging wildly, stuffing yourself brutally with her fleshy shaft. Before long your exertion pays off and you orgasm.\n\n");
						player.buttChange(32,true,true,false);
					}
					else
					{
						outputText("Eventually she squeezes her entire hand inside. She holds it still, and begins to push your body back and forth so that the swinging motion forces her fist in and out of your sphincter, all the while continuing to expertly hold you at the edge of orgasm. Only after minutes of this agonizing treatment does she allow you to orgasm.");
						//buttChange(20,true,true,false); //Must have phallus for anal virginity! Therefore this doesn't count.
					}
					if (player.hasCock())
					{
						outputText(" Thanks to her stimulation of your prostate you cum buckets, painting your [fullChest] and [face] with your sticky goo.");
					}
					if ((player.hasVagina()) && player.wetness() >= 4)
					{
						if (player.hasCock())
						{
							outputText(" At the same time, your");
						}
						else
						{
							outputText(" Your");
						}
						outputText(" abdomen is wracked with spasms of pleasure as a fountain of clear, viscous fluid erupts from your [cunt] and coats your Mistress' head and torso. She allows herself to indulge in a moment of ecstasy, rubbing your juices into her firm, shapely tits with her left hand while using them to massage her dick with her right. Despite being lost in your own pleasure, you cannot help but feel gratifed watching her face, eyes closed, head tilted back, mouth agape, fiery red bangs haphazardly scattered across her face in sticky strands. Then the moment passes, and she speaks.");
					}
					outputText("\" <i>Do you understand now, slave? Your body craves my abuse. Embrace it -- once you do, your life will become an unending river of pleasure</i>\"");
					break;
				case 3:
				case 4:
				case 5:
				case 6:
					if (player.hasVagina())
					{
						outputText("(Placeholder) \"<i>You're going to get a special treat today, [boy], but first you need to beg me to put a baby in your dirty [cunt].</i>\" You petulantly refuse, ");
						if (player.findStatusEffect(StatusEffects.Heat) >= 0)
						{
							outputText("but she simply laughs, walks up to you, and begins to stroke her dick in your face. In a matter of seconds your raging hormones get the better of you and you coyly acquiesce, and ask her to fuck your [pussy]. She makes you present yourself like a bitch in heat while continuing to beg. Finally she gives you want you want, and fills your womb with her potent seed.\n\n");
						}
						else
						{
							outputText(" and in response she binds your arms tightly behind your back, affixes a wide spreader bar between your knees, and shove your [face] to the floor. \"<i>You misunderstand, slave. You have no choice. I will be filling your sweet little baby hole with cum, but first you <b>will</b> beg me to do it.</i>\" She then begins to finger your [clit], quickly filling you with unmanagable lust. [if (esteem < 40) \"It's not long before your willpower drains\"][if (esteem >= 40) \"You hold out as long as you can, but eventually you cave to your lust\"] and beg her to fuck your [pussy] and make you her breeder bitch. She does so, and you cum explosively the moment you feel her warm juices begin to fill your womb.");
						}
						player.cuntChange(32,true,true,false);
						player.knockUp(PregnancyStore.PREGNANCY_IMP, 350, 70);
						break;
					}
				case 7:
				case 8:
				case 9:
				default:
					outputText("(Placeholder) She directs you to lie down and spread your legs for her but you refuse. Before you know it you are face down bent over the rack, arms tied to the wheel at the far end and ankles bound wide to the legs of the table. She then pounds at your [asshole] mercilessly until you orgasm from the shameful stimulation. \"<i>Do you understand now, slave? I don't even have to touch your ",false);
					if (player.hasCock())
					{
						outputText("pathetic cock");
					}
					else if (player.hasVagina())
					{
						outputText("dirty cunt");
					}
					else
					{
						outputText("silly little mound");
					}
					
					outputText(" to make you spurt. Your body wants to be used by my dick and filled with my seed. You are a cocksucking, anal loving, cum-slut. Accept it.</i>\"");
					player.buttChange(32,true,true,false);
			}
			outputText("(Placeholder) Afterwards, " + prisonCaptor.captorPronoun1 + " leaves you hogtied to help you remember to obey in the future. ",false);
			player.slimeFeed();
			player.changeStatusValue(StatusEffects.PrisonRestraints,2,2);
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function prisonCaptorPunishmentFuck():void
		{
			outputText("[captorTitle] [captorName] wears a beguiling half smile while studying you intently with [captorhis] piercing eyes, then reaches a decision. \"<i>A good fucking should suffice; whether you try to resist or not, your own body is going to correct your bad behavior today. Either way we're both going to enjoy this, so the only question is how hard you want to make it for yourself?</i>\"[if (lust > 75) \" You wonder if [captorhe] can see just how horny you currently are as you consider how to respond.\"]\n\n");
			outputText("Do you give in and take your punishment submissively, or do you make an effort to resist?");
			simpleChoices("Submit", prisonCaptorPunishmentFuckSubmit, "Resist", prisonCaptorPunishmentFuckResist, "", null, "", null, "", null);
		}
		
		public function prisonCaptorPunishmentFuckSubmit():void
		{
			outputText("You decide to submit to whatever sexual activity your [captorTitle] has in mind[if (lust > 75) \"-- you are just too aroused to do otherwise\"].\n\n");
			this[prisonCaptor.submitFuckFunc]();
		}
		
		public function prisonCaptorPunishmentFuckResist():void
		{
			outputText("You decide to do your best to resist whatever sexual activity your [captorTitle] has in store for you[if (lust > 75) \", in spite of the lust currently burning within you\"].\n\n");
			this[prisonCaptor.resistFuckFunc]();
		}
		
		/*public function prisonItemSpecialEvent(item:Useable, previousEvent:Function):Boolean
		{
			if (item == consumables.C_BREAD && trainingPet.prisonCaptorPetTier() > 0 && !trainingPet.prisonCaptorPetOptedOut())
			{
				trainingPet.prisonCaptorPetLickCumBowl("choose", previousEvent);
				return true;
			}
			return false;
		}*/
		
		public function prisonItemBread(cumBread:Boolean, lickPrompt:Boolean = true):void
		{
			clearOutput();

			if (cumBread)
			{
				if (lickPrompt && trainingPet.prisonCaptorPetTier() > 0 && !trainingPet.prisonCaptorPetOptedOut())
				{
					trainingPet.prisonCaptorPetLickCumBowl("choose");
					return;
				}
				outputText("You look at the bowl full of cum with bits of soggy bread floating in it. ",false);
				if (player.obey < 25)
				{
					outputText("The thought of consuming such a thing ",false);
					if (player.cor < 50)
					{
						outputText("disgusts and horrifies you, but ",false);
					}
					else
					{
						outputText("is disgusting but also a bit arousing. In any case, ",false);
						dynStats("lus", 10);
					}
					outputText("you know you must eat if it you are going to keep your strength and willpower reserves up. It fills you with shame, but you slowly consume the sticky soup.",false);
				}
				else if (player.obey < 45)
				{
					outputText("You know you are expected to eat it without complaint ",false);
					if (player.cor < 50)
					{
						outputText("but you still find the experience disgusting. ",false);
					}
					else
					{
						outputText("but you can't help feeling an uncomfortable mixture of disgust and arousal at the thought. ",false);
						dynStats("lus", 10);
					}
					outputText("In any case, you must eat if it you are going to keep your strength and willpower reserves up. It fills you with shame, but you dutifully consume the sticky soup.",false);
				}
				else if (player.obey < 70)
				{
					outputText("You know you are expected to eat it without complaint and it is almost second nature to do so despite the foul ",false);
					if (player.cor < 50)
					{
						outputText("",false);
					}
					else
					{
						outputText("yet arousing ",false);
						dynStats("lus", 10);
					}
					outputText("experience of doing so.  You are filled with a welcome shame as you dutifully consume the sticky soup",false);
				}
				else
				{
					outputText("You know you are expected to eat it without complaint and your only desire is to relish the humilation of doing so. You are filled with a wonderful mixture of arousal and shame as you dutifully consume the sticky soup.",false);
					dynStats("lus", 10);
				}
				prisonItemBreadHeatEffect();
				changeEsteem(-2,inPrison);
				if (rand(100) < player.cor || rand(50) > player.esteem)
				{
					outputText("\n\nAfterwards you find yourself overcome by ",false);
					if (player.obey < 45)
					{
						outputText("an uncomfortable ",false);
					}
					else
					{
						outputText("a familiar ",false);
					}
					outputText("sense of satisfaction at having committed the submissive and demeaning act.",false);
					changeObey(1,inPrison);
				}
				player.refillHunger(20);
			}
			else
			{
				outputText("You eat the stale, flavorless brick of bread. It satisfies your hunger, but not much else.", false);
				player.refillHunger(40);
			}
			doNext(inventory.inventoryMenu);
		}
		
		public function prisonItemBreadHeatEffect(bonusResist:Number = 0):void
		{
			if ((!(player.race() == "human") || player.catScore() > 1 || player.dogScore() > 1 || player.foxScore() > 1 || player.horseScore() > 1 || player.minoScore() > 1 || player.cowScore() > 4 || player.bunnyScore() > 1 || player.kangaScore() > 1) && rand(player.obey) > 20 + bonusResist)
			{
				outputText("\n\nAs you eat, the submissive nature of the act stirs an animalistic response in your mutated body. ");
				if (player.hasVagina())
				{
					if (player.pregnancyIncubation == 0)
					{
						if (player.findStatusEffect(StatusEffects.Heat) >= 0)
						{
							outputText("Your mind clouds as your " + player.vaginaDescript(0) + " moistens.  Despite already being in heat, the desire to copulate constantly grows even larger.",false);
							temp = player.findStatusEffect(StatusEffects.Heat);
							if (player.statusEffectv1(StatusEffects.Heat) < 100) player.addStatusValue(StatusEffects.Heat, 1, 10);
							if (player.statusEffectv2(StatusEffects.Heat) < 100) player.addStatusValue(StatusEffects.Heat, 2, 10);
							if (player.statusEffectv3(StatusEffects.Heat) < 720) player.addStatusValue(StatusEffects.Heat, 3, 96);
							dynStats("lib", 10);
						}
						if (player.findStatusEffect(StatusEffects.Heat) < 0)
						{
							outputText("Your mind clouds as your " + player.vaginaDescript(0) + " moistens.  Your hands begin stroking your body from top to bottom, your sensitive skin burning with desire.  Fantasies about bending over and presenting your needy pussy to a male overwhelm you as you realize <b>you have gone into heat</b>!", false);
							player.createStatusEffect(StatusEffects.Heat, 20, 20, 96, 0);
							dynStats("sens", 10);
						}
					}
					else
					{
						outputText("You feel a stirring in your belly, and you are overcome by a queer feeling of contentedness.");
					}
				}
				else
				{
					outputText("Strange fantasies about bending over and presenting a needy pussy to a male overwhelm you, and for a moment you find yourself wishing you had the proper equipment to act them out.");
				}
			}
		}
		
		public function prisonCaptorTrainingStatusUpdate():void
		{
			if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyStatus) < 0)
			{
				player.createStatusEffect(StatusEffects.PrisonCaptorEllyStatus,1,0,0,0);
			}
			switch(player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus))
			{
				case 0:
				case 1:
					break;
				case 2:
					if (player.obey < 10)
					{
						player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,1);
						if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 0)
						{
							flags[kFLAGS.PRISON_TRAINING_LEVEL] = -1;
						}
						else
						{
							flags[kFLAGS.PRISON_TRAINING_LEVEL] = 4;
						}
					}
					break;
				case 3:
					if (player.obey < 25)
					{
						player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,2);
						if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 0)
						{
							flags[kFLAGS.PRISON_TRAINING_LEVEL] = -1;
						}
						else
						{
							flags[kFLAGS.PRISON_TRAINING_LEVEL] = 5;
						}
					}
					break;
				case 4:
					if (player.obey < 45)
					{
						player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,3);
						if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 0)
						{
							flags[kFLAGS.PRISON_TRAINING_LEVEL] = -1;
						}
						else
						{
							flags[kFLAGS.PRISON_TRAINING_LEVEL] = 5;
						}
					}
					break;
				case 5:
					if (player.obey < 70)
					{
						player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,4);
						if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 0)
						{
							flags[kFLAGS.PRISON_TRAINING_LEVEL] = -1;
						}
						else
						{
							flags[kFLAGS.PRISON_TRAINING_LEVEL] = 5;
						}
					}
					break;
				case 6:
					if (player.obey < 90)
					{
						player.changeStatusValue(StatusEffects.PrisonCaptorEllyStatus,1,5);
						if (flags[kFLAGS.PRISON_TRAINING_LEVEL] > 0)
						{
							flags[kFLAGS.PRISON_TRAINING_LEVEL] = -1;
						}
						else
						{
							flags[kFLAGS.PRISON_TRAINING_LEVEL] = 5;
						}
					}
					break;
			}
		}
		
		public function displayPrisonStats():void
		{
			var trainingLevelCounter:* = undefined;
			if (flags[kFLAGS.IN_PRISON] > 0)
			{
				outputText("\n<b><u>Mental State</u></b>\n",false);
				outputText("<b>Willpower:</b> " + Math.round(player.will) + " / 100\n",false);
				//outputText("<b>Hunger:</b> " + Math.round(player.hunger) + " / 100\n",false); //Shows in Body Stats
				outputText("<b>Self-Esteem:</b> " + Math.round(player.esteem) + " / 100 (",false);
				if (player.esteem < 15)
				{
					outputText("Very Low");
				}
				else if (player.esteem < 40)
				{
					outputText("Low");
				}
				else if (player.esteem < 60)
				{
					outputText("Normal");
				}
				else if (player.esteem < 85)
				{
					outputText("High");
				}
				else
				{
					outputText("Very High");
				}
				outputText(")\n",false);
				outputText("<b>Obedience:</b> " + Math.round(player.obey) + " / " + (player.obeySoftCap ? 50 : 100) + " (", false);
				if (player.obey < 10)
				{
					outputText("Strong Willed");
				}
				else if (player.obey < 25)
				{
					outputText("Agreeable");
				}
				else if (player.obey < 45)
				{
					outputText("Submissive");
				}
				else if (player.obey < 70)
				{
					outputText("Highly Submissive");
				}
				else if (player.obey < 90)
				{
					outputText("Willing Slave");
				}
				else
				{
					outputText("Perfect Slave");
				}
				if (player.obey >= 50 && player.obeySoftCap == true)
				{
					outputText(") (Growth halted)\n",false);
				}
				else
				{
					outputText(")\n",false);
				}
			}
			if (flags[kFLAGS.PRISON_CAPTURE_COUNTER] > 0)
			{
				outputText("\n",false);
				outputText("<b><u>Prisoner Stats</u></b>\n",false);
				outputText("<b>Times Captured by Slavers: </b>" + flags[kFLAGS.PRISON_CAPTURE_COUNTER] + "\n",false);
				outputText("<b>Capture After Combat Loss Chance: </b>",false);
				if (flags[kFLAGS.PRISON_CAPTURE_CHANCE] <= 0)
				{
					outputText("None");
				}
				else if (flags[kFLAGS.PRISON_CAPTURE_CHANCE] < 30)
				{
					outputText("Low");
				}
				else
				{
					outputText("Normal");
				}
				outputText("\n",false);
				if (player.findStatusEffect(StatusEffects.PrisonCaptorEllyStatus) > 0)
				{
					outputText("<b>Mistress Elly Training Level: </b>" + player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus) + " (",false);
					switch(player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus))
					{
						case 0:
						case 1:
							outputText("Untrained",false);
							break;
						case 2:
							outputText("Respectful",false);
							break;
						case 3:
							outputText("Cock Sucker",false);
							break;
						case 4:
							outputText("Orgasm Toy",false);
							break;
						case 5:
							outputText("Anal Slut",false);
							break;
						case 6:
						default:
							outputText("Elly's Bitch",false);
					}
					outputText(")\n",false);
				}
				trainingLevelCounter = flags[kFLAGS.PRISON_TRAINING_LEVEL] - 1;
				if (trainingLevelCounter > 0)
				{
					switch(player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus))
					{
						case 0:
						case 1:
							outputText("<b>Displayed Manners: </b>",false);
							break;
						case 2:
							outputText("<b>Given head willingly: </b>",false);
							break;
						case 3:
							outputText("<b>Orgasmed on command: </b>",false);
							break;
						case 4:
							outputText("<b>Accepted anal sex: </b>",false);
							break;
						case 5:
							outputText("<b>Performed quests willingly: </b>",false);
							break;
						case 6:
						default:
							outputText("<b>Performed quests without question: </b>",false);
					}
					outputText(trainingLevelCounter + " time");
					if (trainingLevelCounter == 1)
					{
						outputText("\n",false);
					}
					else
					{
						outputText("s\n",false);
					}
					
					billieScene.prisonCaptorBillieStatusText();
				}
				if (trainingPet.prisonCaptorPetTier() > 0 && !trainingPet.prisonCaptorPetOptedOut()) 
					trainingPet.prisonCaptorPetStatusText();
				if (trainingFeed.prisonCaptorFeedingQuestTrainingExists()) 
					trainingFeed.prisonCaptorFeedingQuestTrainingStatusText();
				if (trainingFeed.prisonCaptorFeedingQuestOptedOut()) 
					outputText("<b>Quests Disabled</b>\n");
				outputText("",false);
			}
		}
		
	}
}
