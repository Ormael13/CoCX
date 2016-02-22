package classes.Scenes.Places.Prison 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.internals.WeightedDrop;
	import classes.Scenes.Areas.Plains.Gnoll;
	import classes.Scenes.Areas.Plains.GnollSpearThrower;
	import classes.Scenes.Areas.Plains.Satyr;
	import classes.Scenes.Areas.Mountain.Minotaur;
	import classes.Scenes.Monsters.Goblin;
	import classes.Scenes.Monsters.Imp;
	
	public class PrisonGuard extends BaseContent
	{
		private var randomGuardList:Array = ["imp", "goblin", "gnoll", "gnoll spear-thrower", "minotaur", "satyr"];
		
		public var guardType:String;
		public var guardPronoun1:String;
		public var guardPronoun2:String;
		public var guardPronoun3:String;
		public var guardA:String;
		public var guardCaptitalA:String;
		public var guardCombatID:Monster;
		public var guardEscapeSeduceBonus:int;
		public var guardEscapeBribeBonus:int;
		public var guardEscapeSneakBonus:int;
		
		public function PrisonGuard() {}
		
		public function get guardNoiseDetectionChance():int {
			return 10;
		}
		
		public function prisonCaptorRandomEventAbuse():Boolean
		{
			hideMenus();
			clearOutput();
			if (flags[kFLAGS.PRISON_TRAINING_LEVEL] == 0 && player.statusEffectv1(StatusEffects.PrisonCaptorEllyStatus) <= 1)
			{
				return prison.prisonCaptorRandomEventSounds();
			}
			prisonCaptorLoadGuard(true);
			outputText("You are startled by the sound of the door opening, and quickly find yourself wishing you hadn't heard it at all. " + guardCaptitalA + " " + guardType + " guard enters the room and quickly secures the door behind " + guardPronoun2 + ", then turns towards you with the clear intent of fucking you and showing you your place.\n\n",false);
			return prisonGuardAttack();
		}
		
		public function prisonGuardAttack():Boolean
		{
			if (prison.prisonCanEscapeFight(false))
			{
				outputText("It occurs to you that if you were to resist you just might get the better of your guard and make good an escape. ",false);
				if (rand(100) < player.obey - (player.level + player.esteem * 0.25))
				{
					if (player.obey < 45)
					{
						outputText("However, something deep inside you tells you that this is not the right moment to make a stand. Instead you cower meekly as your guard looms over you.\n",false);
					}
					else if (player.obey < 75)
					{
						outputText("However, your conditioning gets the better of your desire for freedom and you fall to your knees submissively as the " + guardPronoun1 + " looms over you.\n",false);
						dynStats("lus", 100);
					}
					else
					{
						outputText("However, you have no desire to fight back; to the contrary, your only desire is to absorb every ounce of punishment " + guardPronoun1 + " has in mind, and you silently communicate as much by bending over and assuming the most secuctively submissive stance you can manage.\n",false);
						dynStats("lus", 100);
					}
					
					prison.prisonEscapeFightAutoLose();
				}
				else
				{
					outputText("Do you make an escape attempt? " + prison.prisonWillCostDescript(15),false);
					outputText("\n",false);
					doYesNo(prisonGuardAttackFight, prisonGuardAttackSubmit);
					if (player.will >= prison.prisonWillCost(10)) {
						outputText("\nYou could tell the " + guardType + " to fuck off and leave you alone. " + prison.prisonWillCostDescript(10));
						addButton(2, "Fuck Off", giveGuardTheFinger);
					}
					return true;
				}
			}
			else
			{
				if (player.obey < 45)
				{
					outputText("Unfortunately for you,",false);
				}
				else if (player.obey < 75)
				{
					outputText("Something inside you is relieved that",false);
					dynStats("lus", 15);
				}
				else
				{
					outputText("It gives you pleasure when you realize that",false);
					dynStats("lus", 30);
				}
				
				outputText(" your restraints prevent you from putting up any significant fight",false);
				if (player.lust > 80)
				{
					outputText(" -- not that you'd last long in a fight with your current state of arousal anyway.  Seeing this fact written on your face, the " + guardType + " chuckles and temporarily removes your bindings.\n",false);
				}
				else
				{
					outputText(". As you struggle ineffectually, the " + guardType + " beats you senseless then temporarily removes your bindings.\n",false);
				}
				doNext(prison.prisonEscapeFightAutoLose);
				if (player.will >= prison.prisonWillCost(10)) {
					outputText("\nYou could tell the " + guardType + " to fuck off and leave you alone. " + prison.prisonWillCostDescript(10));
					addButton(2, "Fuck Off", giveGuardTheFinger);
				}
				return true;
			}
			doNext(playerMenu);
			return true;
		}
		
		public function prisonGuardAttackFight():void
		{
			if (player.will > prison.prisonWillCost(15))
			{
				outputText("\n\nYou steel yourself for combat, feeling a sudden rush of self confidence.",false);
				prison.changeWill(-prison.prisonWillCost(15));
				prison.prisonEscapeFightStart();
			}
			else
			{
				outputText("\n\nYou make a valiant effort to prepare for combat, but ultimately your will gives out and you collapse in front of the advancing " + guardType + ".",false);
				prison.changeEsteem(2, prison.inPrison);
				prison.prisonEscapeFightAutoLose();
			}
		}
		
		public function prisonGuardAttackSubmit():void
		{
			outputText("\n\n",false);
			if (player.obey < 45)
			{
				outputText("Something deep inside you tells you that this is not the right moment to make a stand. Instead you cower meekly as the " + guardType + " looms over you.\n",false);
			}
			else if (player.obey < 75)
			{
				outputText("Your conditioning gets the better of your desire for freedom and you fall to your knees submissively as the " + guardType + " looms over you.\n",false);
				dynStats("lus", 100);
			}
			else
			{
				outputText("However, you have no desire to fight back; to the contrary, your only desire is to absorb every ounce of punishment this " + guardType + " has in mind, and you silently communicate as much bending over and assuming the most secuctively submissive stance you can manage.\n",false);
				dynStats("lus", 100);
			}
			
			prison.changeObey(1, prison.inPrison);
			prison.prisonEscapeFightAutoLose();
		}
		
		public function giveGuardTheFinger():void {
			clearOutput();
			prison.changeWill(-prison.prisonWillCost(10));
			outputText("You flip the bird to the " + guardType + " to put a warning signal that you do not want " + guardPronoun2 + " to mess with you. You WANT Elly, not some random guards messing with your body.");
			outputText("\n\nThe " + guardType + " gets angry and storms off, leaving your cell and locking the cell door.");
			if (flags[kFLAGS.PRISON_DOOR_UNLOCKED] > 0) flags[kFLAGS.PRISON_DOOR_UNLOCKED] = 0;
			player.changeStatusValue(StatusEffects.PrisonRestraints, 1, 1);
			doNext(playerMenu);
		}
		
		public function prisonCaptorLoadGuard(randomGuard:Boolean, guardID:String = "default"):void
		{
			if (randomGuard)
			{
				var guardID:String = randomGuardList[rand(randomGuardList.length)];
			}
			switch(guardID)
			{
				case "imp":
					guardType = "imp";
					guardPronoun1 = "he";
					guardPronoun2 = "him";
					guardPronoun3 = "his";
					guardA = "an";
					guardCaptitalA = "An";
					guardCombatID = new Imp();
					guardEscapeSeduceBonus = 15;
					guardEscapeBribeBonus = 15;
					guardEscapeSneakBonus = 5;
					break;
				case "goblin":
					guardType = "goblin";
					guardPronoun1 = "she";
					guardPronoun2 = "her";
					guardPronoun3 = "her";
					guardA = "a";
					guardCaptitalA = "A";
					guardCombatID = new Goblin();
					guardEscapeSeduceBonus = 15;
					guardEscapeBribeBonus = 15;
					guardEscapeSneakBonus = 5;
					break;
				case "gnoll":
					guardType = guardID;
					guardPronoun1 = "she";
					guardPronoun2 = "her";
					guardPronoun3 = "her";
					guardA = "a";
					guardCaptitalA = "A";
					guardCombatID = new Gnoll();
					guardEscapeSeduceBonus = 15;
					guardEscapeBribeBonus = 20;
					guardEscapeSneakBonus = 5;
					break;
				case "gnoll spear-thrower":
					guardType = guardID;
					guardPronoun1 = "she";
					guardPronoun2 = "her";
					guardPronoun3 = "her";
					guardA = "a";
					guardCaptitalA = "A";
					guardCombatID = new GnollSpearThrower();
					guardEscapeSeduceBonus = 15;
					guardEscapeBribeBonus = 20;
					guardEscapeSneakBonus = 5;
					break;
				case "minotaur":
					guardType = guardID;
					guardPronoun1 = "he";
					guardPronoun2 = "him";
					guardPronoun3 = "his";
					guardA = "a";
					guardCaptitalA = "A";
					guardCombatID = new Minotaur();
					guardEscapeSeduceBonus = 20;
					guardEscapeBribeBonus = 10;
					guardEscapeSneakBonus = 15;
				case "satyr":
					guardType = guardID;
					guardPronoun1 = "he";
					guardPronoun2 = "him";
					guardPronoun3 = "his";
					guardA = "a";
					guardCaptitalA = "A";
					guardCombatID = new Satyr();
					guardEscapeSeduceBonus = 20;
					guardEscapeBribeBonus = 10;
					guardEscapeSneakBonus = 15;
				case "default":
				default:
					guardType = guardID;
					guardPronoun1 = "he";
					guardPronoun2 = "him";
					guardPronoun3 = "his";
					guardA = "a";
					guardCaptitalA = "A";
					guardCombatID = new Minotaur();
					guardEscapeSeduceBonus = 20;
					guardEscapeBribeBonus = 10;
					guardEscapeSneakBonus = 15;
			}
			guardCombatID.drop = new WeightedDrop();
		}
	}

}