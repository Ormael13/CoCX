package classes
{
	import classes.GlobalFlags.kGAMECLASS;
	import flash.system.System;
	
	public class PregnancyStore extends Object
	{
		//Pregancy types. Both butt and normal. Each type represents the father of this baby.
		public static const PREGNANCY_IMP:int                   =   1;
		public static const PREGNANCY_MINOTAUR:int              =   2;
		public static const PREGNANCY_MOUSE:int                 =   4;
		public static const PREGNANCY_OVIELIXIR_EGGS:int        =   5; //Also caused by Phoenixes apparently
		public static const PREGNANCY_HELL_HOUND:int            =   6;
		public static const PREGNANCY_CENTAUR:int               =   7;
		public static const PREGNANCY_MARBLE:int                =   8;
		public static const PREGNANCY_BUNNY:int                 =   9;
		public static const PREGNANCY_ANEMONE:int               =  10;
		public static const PREGNANCY_AMILY:int                 =  11;
		public static const PREGNANCY_IZMA:int                  =  12;
		public static const PREGNANCY_SPIDER:int                =  13;
		public static const PREGNANCY_BASILISK:int              =  14;
		public static const PREGNANCY_DRIDER_EGGS:int           =  15;
		public static const PREGNANCY_GOO_GIRL:int              =  16;
		public static const PREGNANCY_EMBER:int                 =  17;
		public static const PREGNANCY_BENOIT:int                =  18;
		public static const PREGNANCY_SATYR:int                 =  19;
		public static const PREGNANCY_COTTON:int                =  20;
		public static const PREGNANCY_URTA:int                  =  21;
		public static const PREGNANCY_SAND_WITCH:int            =  22;
		public static const PREGNANCY_FROG_GIRL:int             =  23;
		public static const PREGNANCY_FAERIE:int                =  24; //Indicates you are carrying either a phouka or faerie baby. Which one is determined by the PREGNANCY_CORRUPTION flag
		public static const PREGNANCY_PLAYER:int                =  25; //The player is the father. Will be used when an NPC is able to have children from multiple different fathers.
		public static const PREGNANCY_BEE_EGGS:int              =  26;
		public static const PREGNANCY_SANDTRAP_FERTILE:int      =  27;
		public static const PREGNANCY_SANDTRAP:int              =  28;
		public static const PREGNANCY_JOJO:int                  =  29; //So we can track them separately from other mouse pregnancies
		public static const PREGNANCY_KELT:int                  =  30; //So we can track them separately from other centaur pregnancies
		public static const PREGNANCY_TAOTH:int                 =  31;
		public static const PREGNANCY_GOO_STUFFED:int           =  32; //Used to fill the player's ass and/or vagina when Valeria has a goo girl take up residence. This prevents any other
																	   //form of pregnancy from taking hold. Does not respond to ovielixirs.
		public static const PREGNANCY_WORM_STUFFED:int          =  33; //Used to fill the player's vagina when the worms take up residence. This prevents any other form of
																	   //pregnancy from taking hold. Does not respond to ovielixirs.
		public static const PREGNANCY_MINERVA:int				=  34;
		public static const PREGNANCY_BEHEMOTH:int				=  35;
		public static const PREGNANCY_PHOENIX:int				=  36;
		public static const PREGNANCY_ANDY:int                  =  37; //This is functionally the same as Satyr but less corrupt. 10% chance of fauns, if ever implemented.
		
		public static const PREG_NOT_PREGANT:int                =   0; //The PREG_* consts are returned by the size function
		public static const PREG_NO_SIGNS_UNKNOWN:int           =   1; //NPC has conceived but doesn’t know she’s pregnant, no visible signs
		public static const PREG_NO_SIGNS_KNOWN:int             =   2; //NPC is in the first trimester, knows she’s pregnant
		public static const PREG_START_BULGE:int                =   3; //NPC is in the first trimester, belly is just starting to bulge
		public static const PREG_SWOLLEN:int                    =   4; //NPC is in the second trimester, belly is small but definitely swollen
		public static const PREG_SIZEABLE:int                   =   5; //NPC is in the second trimester, belly is now sizable
		public static const PREG_BLATANT:int                    =   6; //NPC is in the third trimester, belly is blatantly bulging
		public static const PREG_FULL_TERM:int                  =   7; //NPC is in the third trimester, belly is big as it will get for a normal pregnancy
		public static const PREG_OVERDUE:int                    =   8; //NPC is overdue. Usually means a centaur baby, twins or some similar condition. Effectively looks 10 months pregnant
		public static const PREG_VERY_OVERDUE:int               =   9; //NPC is very overdue. Probably triplets or more. Effectively looks 11 months pregnant
//Old Value, replaced in Saves.unFuckSave()		public static const PREGNANCY_BUTT_BEE:int              =   2;
//Old Value, replaced in Saves.unFuckSave()		public static const PREGNANCY_BUTT_DRIDER:int           =   3;
//Old Value, replaced in Saves.unFuckSave()		public static const PREGNANCY_BUTT_SANDTRAP_FERTILE:int =   4;
//Old Value, replaced in Saves.unFuckSave()		public static const PREGNANCY_BUTT_SANDTRAP:int         =   5; //Sandtrap did not have fertilized eggs

		public static const INCUBATION_IMP:int                  = 432; //Time for standard imps. Imp lords, Ceraph, Lilium and the imp horde cause slightly faster pregnancies
		public static const INCUBATION_MINOTAUR:int             = 432;
		public static const INCUBATION_MOUSE:int                = 350;
		public static const INCUBATION_OVIELIXIR_EGGS:int       =  50;
		public static const INCUBATION_HELL_HOUND:int           = 352;
		public static const INCUBATION_CENTAUR:int              = 420;
		public static const INCUBATION_MARBLE:int               = 368;
		public static const INCUBATION_BUNNY_BABY:int           = 200;
		public static const INCUBATION_BUNNY_EGGS:int           = 808; //High time indicates neon egg pregnancy
		public static const INCUBATION_ANEMONE:int              = 256;
		public static const INCUBATION_IZMA:int                 = 300;
		public static const INCUBATION_SPIDER:int               = 400;
		public static const INCUBATION_BASILISK:int             = 250;
		public static const INCUBATION_DRIDER:int               = 400;
		public static const INCUBATION_GOO_GIRL:int             =  85;
		public static const INCUBATION_EMBER:int                = 336;
		public static const INCUBATION_SATYR:int                = 160;
		public static const INCUBATION_COTTON:int               = 350;
		public static const INCUBATION_URTA:int                 = 515;
		public static const INCUBATION_SAND_WITCH:int           = 360;
		public static const INCUBATION_FROG_GIRL:int            =  30;
		public static const INCUBATION_FAERIE:int               = 200;
		public static const INCUBATION_BEE:int                  =  48;
		public static const INCUBATION_SANDTRAP:int             =  42;
		public static const INCUBATION_HARPY:int                = 168;
		public static const INCUBATION_SHIELA:int               =  72;
		public static const INCUBATION_SALAMANDER:int           = 336;
		public static const INCUBATION_MINERVA:int           	= 216; 
		public static const INCUBATION_BEHEMOTH:int           	=1440; //Sorry Behemoth, but Isabella wins.
		public static const INCUBATION_PHOENIX:int           	= 168; 
		public static const INCUBATION_KIHA:int                 = 384;
		public static const INCUBATION_ISABELLA:int             =2160; //Longest pregnancy ever. 
		
		private static const MAX_FLAG_VALUE:int                 = 2999;
		private static const PREG_TYPE_MASK:int                 = 0x0000FFFF; //Should be safe with 65535 different pregnancy types
		private static const PREG_NOTICE_MASK:int               = 0x7FFF0000; //Use upper half to store the latest stages of pregnancy the player has noticed
		
		private var _pregnancyTypeFlag:int;
		private var _pregnancyIncubationFlag:int;
		private var _buttPregnancyTypeFlag:int;
		private var _buttPregnancyIncubationFlag:int;
		private var _pregnancyEventValue:Vector.< Vector.<int> >; //Using a vector of vectors so that each different pregnancy type can have its own set of events
		private var _buttPregnancyEventValue:Vector.< Vector.<int> >;
		
		//All the flags are passed through the constructor so that they can be different in every class that uses PregnancyStore but the pregnancy code remains the same
		public function PregnancyStore(pregType:int, pregInc:int, buttPregType:int, buttPregInc:int) {
			_pregnancyTypeFlag = pregType;
			_pregnancyIncubationFlag = pregInc;
			_buttPregnancyTypeFlag = buttPregType;
			_buttPregnancyIncubationFlag = buttPregInc;
			_pregnancyEventValue = new Vector.< Vector.<int> >();
			_buttPregnancyEventValue = new Vector.< Vector.<int> >();
			if (pregType < 0 || pregType > MAX_FLAG_VALUE || pregInc < 0 || pregInc > MAX_FLAG_VALUE || buttPregType < 0 || buttPregType > MAX_FLAG_VALUE || buttPregInc < 0 || buttPregInc > MAX_FLAG_VALUE || pregType == buttPregType || pregInc == buttPregInc) {
				trace("Error: PregnancyStore created with invalid values for its flags. PregnancyStore(" + pregType + ", " + pregInc + ", " + buttPregType + ", " + buttPregInc + ")");
			}
		}
	
		public function get type():int { return (_pregnancyTypeFlag == 0 ? 0 : kGAMECLASS.flags[_pregnancyTypeFlag] & PREG_TYPE_MASK); }

		public function get incubation():int { return (_pregnancyIncubationFlag == 0 ? 0 : kGAMECLASS.flags[_pregnancyIncubationFlag]); }

		public function get buttType():int { return (_buttPregnancyTypeFlag == 0 ? 0 : kGAMECLASS.flags[_buttPregnancyTypeFlag] & PREG_TYPE_MASK); }

		public function get buttIncubation():int { return (_buttPregnancyIncubationFlag == 0 ? 0 : kGAMECLASS.flags[_buttPregnancyIncubationFlag]); }
		
		public function get isPregnant():Boolean { return type != 0; } //At birth the incubation can be zero so a check vs. type is safer

		public function get isButtPregnant():Boolean { return buttType != 0; } //At birth the incubation can be zero so a check vs. type is safer
		
		/* Using this function adds a series of events which happen during the pregnancy. They must be added in descending order (ex. 500, 450, 350, 225, 100, 25)
		   to work properly. For NPCs who have multiple pregnancy types each type has its own set of events. Events can be used to see how far along the NPC
		   is in her pregnancy with the event property. They can also be checked using the eventTriggered() function. This checks to see which was the latest event
		   the player noticed. The eventTriggered() function only triggers once per event per pregnancy. */
		public function addPregnancyEventSet(pregType:int, ... pregStage):void
		{
			var pregVector:Vector.<int> = new Vector.<int>(pregStage.length + 2);
			pregVector[0] = pregType; //First element is the pregnancy type
			for (var i:int = 0; i < pregStage.length; i++) pregVector[i + 1] = pregStage[i];
			pregVector[pregVector.length - 1] = -1; //Make last element -1 to ensure there is always a match
			_pregnancyEventValue.push(pregVector);
		}

		//Same as addPregnancyEventSet, but for butts
		public function addButtPregnancyEventSet(buttPregType:int, ... buttPregStage):void
		{
			var pregVector:Vector.<int> = new Vector.<int>(buttPregStage.length + 1);
			pregVector[0] = buttPregType; //First element is the butt pregnancy type
			for (var i:int = 0; i < buttPregStage.length; i++) pregVector[i + 1] = buttPregStage[i];
			pregVector[pregVector.length - 1] = -1; //Make last element -1 to ensure there is always a match
			_buttPregnancyEventValue.push(pregVector);
		}
		
		public function knockUp(newPregType:int = 0, newPregIncubation:int = 0):void
		{
			if (!isPregnant) knockUpForce(newPregType, newPregIncubation);
		}
		
		public function knockUpForce(newPregType:int = 0, newPregIncubation:int = 0):void
		{
			if (_pregnancyTypeFlag == 0 || _pregnancyIncubationFlag == 0) return; //Check that these variables were provided by the containing class
			if (newPregType != 0) newPregType = (kGAMECLASS.flags[_pregnancyTypeFlag] & PREG_NOTICE_MASK) + newPregType;
				//If a pregnancy 'continues' an existing pregnancy then do not change the value for last noticed stage
			kGAMECLASS.flags[_pregnancyTypeFlag] = newPregType;
			kGAMECLASS.flags[_pregnancyIncubationFlag] = (newPregType == 0 ? 0 : newPregIncubation); //Won't allow incubation time without pregnancy type
		}
	
		public function buttKnockUp(newPregType:int = 0, newPregIncubation:int = 0):void
		{
			if (!isButtPregnant) buttKnockUpForce(newPregType, newPregIncubation);
		}
		
		public function buttKnockUpForce(newPregType:int = 0, newPregIncubation:int = 0):void
		{
			if (_buttPregnancyTypeFlag == 0 || _buttPregnancyIncubationFlag == 0) return; //Check that these variables were provided by the containing class
			if (newPregType != 0) newPregType = (kGAMECLASS.flags[_buttPregnancyTypeFlag] & PREG_NOTICE_MASK) + newPregType;
				//If a pregnancy 'continues' an existing pregnancy then do not change the value for last noticed stage
			kGAMECLASS.flags[_buttPregnancyTypeFlag] = newPregType;
			kGAMECLASS.flags[_buttPregnancyIncubationFlag] = (newPregType == 0 ? 0 : newPregIncubation); //Won't allow incubation time without pregnancy type
		}

		//The containing class is responsible for calling pregnancyAdvance, usually once per timeChange()
		public function pregnancyAdvance():void //Separate function so it can be called more often than timeChange if neccessary
		{
			if (incubation != 0) {
				kGAMECLASS.flags[_pregnancyIncubationFlag]--;
				if (kGAMECLASS.flags[_pregnancyIncubationFlag] < 0) kGAMECLASS.flags[_pregnancyIncubationFlag] = 0;
			}
			if (buttIncubation != 0) {
				kGAMECLASS.flags[_buttPregnancyIncubationFlag]--;
				if (kGAMECLASS.flags[_buttPregnancyIncubationFlag] < 0) kGAMECLASS.flags[_buttPregnancyIncubationFlag] = 0;
			}
		}

		/* Many NPCs go through several events during their pregnancies. This function returns the latest event the NPC qualifies for.
		   When the NPC is not pregnant this always returns 0, when pregnant it will return at least 1. The further along the NPC is the larger the value. Each NPC
		   is free to have as many event as desired. They must be added using the addPregnancyEventSet function and are unique to each pregnancy type. */
		public function get event():int
		{
			var pregType:int = type;
			if (pregType == 0) return 0; //Not pregnant
			var incubationValue:int = incubation;
			var pregEventVector:Vector.<int> = null;
			for (var i:int = 0; i < _pregnancyEventValue.length; i++) {
				pregEventVector = _pregnancyEventValue[i];
				if (pregEventVector[0] == pregType) {
					for (var j:int = 1; j < pregEventVector.length; j++) { //Skip element zero, the pregnancy type
						if (incubationValue > pregEventVector[j]) return j; //Will always find a value that is < incubationValue as last value is -1
					}
				}
			}
			return 1; //If there are no pregnancy events for this type of pregnancy then return 1
		}
		
		//The same event system as for vaginal pregnacies, but for butts
		public function get buttEvent():int
		{
			var pregType:int = buttType;
			if (pregType == 0) return 0; //Not pregnant
			var incubationValue:int = buttIncubation;
			var pregEventVector:Vector.<int> = null;
			for (var i:int = 0; i < _buttPregnancyEventValue.length; i++) {
				pregEventVector = _buttPregnancyEventValue[i];
				if (pregEventVector[0] == pregType) {
					for (var j:int = 1; j < pregEventVector.length; j++) { //Skip element zero, the pregnancy type
						if (incubationValue > pregEventVector[j]) return j; //Will always find a value that is < incubationValue as last value is -1
					}
				}
			}
			return 1; //If there are no pregnancy events for this type of pregnancy then return 1
		}

		//Returns either zero - for no change - or the value of the new pregnancy event which the player has not yet noticed
		//This function updates the noticed pregnancy event, so it only triggers once per event per pregnancy.
		public function eventTriggered():int
		{
			var currentStage:int = event;
			var lastNoticed:int = kGAMECLASS.flags[_pregnancyTypeFlag] & PREG_NOTICE_MASK;
			if (currentStage * 65536 == lastNoticed) return 0; //Player has already noticed this stage
			kGAMECLASS.flags[_pregnancyTypeFlag] = (kGAMECLASS.flags[_pregnancyTypeFlag] & PREG_TYPE_MASK) + (currentStage * 65536);
				//Strip off the old noticed value by ANDing with PREG_TYPE_MASK
			return currentStage;
		}

		//Same as eventTriggered, but for butts
		public function buttEventTriggered():int
		{
			var currentStage:int = buttEvent;
			var lastNoticed:int = kGAMECLASS.flags[_buttPregnancyTypeFlag] & PREG_NOTICE_MASK;
			if (currentStage * 65536 == lastNoticed) return 0; //Player has already noticed this stage
			kGAMECLASS.flags[_buttPregnancyTypeFlag] = (kGAMECLASS.flags[_buttPregnancyTypeFlag] & PREG_TYPE_MASK) + (currentStage * 65536);
				//Strip off the old noticed value by ANDing with PREG_TYPE_MASK
			return currentStage;
		}

		public function get size():int {
			//This function exists to provide consistency across different NPC's pregnancies. This is most useful when trying to write descriptions of different belly sizes
			//in threesomes, where the author might not be familiar with how the different pregnancy events relate to belly size.
			return PREG_NOT_PREGANT;
		}
	}
}