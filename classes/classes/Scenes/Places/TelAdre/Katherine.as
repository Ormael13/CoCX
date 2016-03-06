package classes.Scenes.Places.TelAdre {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class Katherine extends TelAdreAbstractContent implements TimeAwareInterface {

//CAPACITY: 70
//const KATHERINE_UNLOCKED:int = 398;
//const KATHERINE_DICK_COUNT:int = 399;
//const KATHERINE_DICK_LENGTH:int = 400;
//const KATHERINE_KNOT_THICKNESS:int = 401;
//const KATHERINE_BALL_SIZE:int = 402;
//const KATHERINE_TIMES_SEXED:int = 403;

		public static const KBIT_CLOTHES_TATTERED:int           =     0; //These values are used for the KATHERINE_CLOTHES, KATHERINE_CLOTHES_PREF and KATHERINE_CLOTHES_WORN flags
		public static const KBIT_CLOTHES_UNIFORM:int            =     1;
		public static const KBIT_CLOTHES_C_CLOTH:int            =     2;
		public static const KBIT_CLOTHES_BODYSUIT:int           =     4;
		public static const KBIT_CLOTHES_B_DRESS:int            =     8;
		public static const KBIT_CLOTHES_SS_ROBE:int            =    16;
		public static const KBIT_CLOTHES_TUBETOP:int            =    32;
		public static const KBIT_CLOTHES_NURSECL:int            =    64;
		                                                          
		public static const KBIT_TRIED_RECEIVE_ANAL:int         =     1; //Used with the KATHERINE_SEXUAL_EXPERIENCE flag to track some forms of sex Kath has experienced.
		public static const KBIT_TRIED_RECEIVE_SUCK_N_FUCK:int  =     2; //This way scenes can have special text for the first time.
		public static const KBIT_TRIED_RECEIVE_ORAL:int         =     4;
		public static const KBIT_TRIED_GIVE_VAGINAL:int			=     8;
		public static const KBIT_TRIED_GIVE_ANAL:int			=    16;
		public static const KBIT_TRIED_GIVE_DOUBLE_PEN:int      =    32;
		public static const KBIT_TRIED_GIVE_SUCK_N_FUCK:int     =    64;
		public static const KBIT_TRIED_DOUBLE_HELIX:int         =   128;
		public static const KBIT_TRIED_BATH:int					=   256;
		public static const KBIT_TRIED_BEDROOM_BONDAGE:int      =   512;
		public static const KBIT_TRIED_DRUNK_BAR_FUCK:int       =  1024;
		
		public static const KBIT_MILK_TOLD_PLAYER_SHES_DRY:int  =     1; //Each time Kath runs out of milk she should only tell the player about it once
		public static const KBIT_MILK_SHARE_WITH_FRIENDS:int    =     2; //She should share with lovers and any old or new friends or acquaintances (includes all below)
		public static const KBIT_MILK_SHARE_WITH_OLD_GANG:int   =     4; //Share her milk with the vagrant cats (includes Helena)
		public static const KBIT_MILK_SHARE_WITH_HELENA:int     =     8; //The young cat morph girl from the vagrant cats
		public static const KBIT_MILK_SHARE_WITH_URTA:int       =    16;
		public static const KBIT_MILK_SHARE_WITH_VALA:int       =    32;
		
		public static const KBIT_SUB_HIGH_CUM:int               =     1; //Caused by double penetrate Kath scene
			//High Cum Corrupt Double Penetration (No submissiveness requirement but player must have a cock and produce 1500+ cum. Must have 75+ corruption for the first time)
		public static const KBIT_SUB_BED_BOND:int               =     2; //Caused by the bedroom bondage scene
			//Bedroom bondage and roleplaying (No submissiveness requirement)
		public static const KBIT_SUB_ORGASM_DENIAL:int          =     4; //Caused by the bath scene
			//Orgasm Denial (No submissiveness requirement but player must be a female or herm. Must have 75+ corruption for the first time)
		public static const KBIT_SUB_CALL_MASTER:int            =     8; //This bit is just an indicator, it does not count towards Katherine’s submissiveness
			//If set Kath will call the player either Master or Mistress (Requires submissiveness 4+)
		public static const KBIT_SUB_GROW_KNOT:int              =    16;
			//You have made Kath regrow her knot(s) to their original 6” diameter at least once after helping her shrink them (Requires submissiveness of 1 or more)
		public static const KBIT_SUB_CAT_DICK:int               =    32;
			//You have convinced Kath to change her cock(s) into cat cocks instead of canine cock(s) at least once (Requires submissiveness of 1 or more)
		public static const KBIT_SUB_GROW_BIG_BOOBS:int         =    64;
			//You have convinced Kath to supersize her breasts (E-Cups or EE-Cups) at least once (Requires submissiveness of 2 or more)
		public static const KBIT_SUB_GROW_BIG_DICK:int          =   128;
			//You have convinced Kath to supersize her cock (grow it larger than 16 inches long) at least once (Requires submissiveness of 2 or more)
		public static const KBIT_SUB_CAT_GIRL:int               =   256;
			//You have convinced Kath to change into a cat girl at least once (Requires submissiveness of 3 or more)
		public static const KBIT_SUB_HIGH_LACTATION:int         =   512;
			//You have convinced Kath to boost her lactation to abnormal levels at least once (Requires submissiveness of 3 or more) For later - Not implemented in this expansion
		public static const KBIT_SUB_REM_BALLS:int              =  1024;
			//You have convinced Kath to remove her balls using reducto and a pink egg at least once (Requires submissiveness of 3 or more)
		public static const KBIT_SUB_GROW_BIG_BALLS:int         =  2048;
			//You have convinced Kath to grow her balls larger than 5 inches across at least once (Requires submissiveness of 4 or more)
		public static const KBIT_SUB_PUBLIC_EXHIBITION:int      =  4096;
			//You have convinced Kath to strip down and perform in front of a crowd at least once (Requires submissiveness of 6 or more and the player must have 75+ corruption)
		public static const KBIT_SUB_REM_COCK:int				=  8192;
			//You have convinced Kath to lose her cock and become a woman (Requires submissiveness of 6 or more)
		public static const KBIT_SUB_START_LACTATION:int		= 16384;
			//You have convinced Kath to start lactating (No submissiveness requirement, but this flag doesn't count once Kath gets to a submissiveness of 4 or more)

		public static const KLOC_STREETS:int                    =     0; //Sex happens in a non-descript alleyway, possibly behind the Wet Bitch
		public static const KLOC_KATHS_APT:int                  =     1; //At her own home. After sex she will generally stay there
		public static const KLOC_URTAS_APT:int                  =     2; //Kath may stay here if she and Urta are fuckbuddies or lovers
		public static const KLOC_URTAS_HOME:int                 =     3; //Kath may stay here if she and Urta are fuckbuddies or lovers. They will stay all night.
		public static const KLOC_BAR:int                        =     4; //At the Wet Bitch. Returns here unless it's after 14:00 or you were last at her place, Urta's apt or Urta's home.
																			//During sex scenes this indicates the bar or a backroom at the bar depending on the scene.
		public static const KLOC_BAR_DRUNK:int                  =     5; //At the Wet Bitch. You got her to drink a lot of booze.
		public static const KLOC_BAR_URTA_REFUSED:int           =     6; //At the Wet Bitch. She's drunk and Urta has refused to have sex with her right now.
		public static const KLOC_LAKE:int                       =     7; //You take her out to the lake, either for training or for a date
		public static const KLOC_DESERT:int                     =     8; //You take her out into the desert for training
                                                                   
		public static const KDATE_LITTLE:int                    =     0; //Have sex together only in threesomes with you
		public static const KDATE_WHENEVER:int                  =     1; //Have sex together whenever they like
		public static const KDATE_LOTS:int                      =     2; //Have lots of sex together
                                                                   
		private static const KBIT_LOVER_AMILY:int               =     1;
		private static const KBIT_LOVER_COTTON:int              =     2;
		private static const KBIT_LOVER_EDRYN:int               =     4;
		private static const KBIT_LOVER_HELIA:int               =     8;
		private static const KBIT_LOVER_URTA:int                =    16;
		private static const KBIT_LOVER_VALA:int                =    32;

		private var _breasts:BreastStore;

		public function Katherine()
		{
			_breasts = new BreastStore(kFLAGS.KATHERINE_BREAST_SIZE);
			CoC.saveAwareClassAdd(_breasts);
			CoC.timeAwareClassAdd(this);
		}
		
		//Answers the simpler question 'Is Vala at the bar right now' rather than 'can Vala have sex with you right now'
		public function isValaAtBar():Boolean {
			return (flags[kFLAGS.FREED_VALA] != 0 && model.time.hours >= 12 && model.time.hours <= 21); 
		}
		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			if (breasts.lactationLevel <= breasts.preventLactationIncrease) {
				switch (model.time.hours) { //Suckling by all NPCs handled here. The player doesn't see this, but they meet up with Kath at different times of the day.
					case  8:	if (milkOption(KBIT_MILK_SHARE_WITH_FRIENDS) || (milkOption(KBIT_MILK_SHARE_WITH_OLD_GANG) && model.time.days % 2 == 0)) breasts.milked();
								break; //She shares with friends every day, or shares with the old gang once every two days
					case 11:	if (milkOption(KBIT_MILK_SHARE_WITH_FRIENDS | KBIT_MILK_SHARE_WITH_URTA) && model.time.days % 5 == 0) breasts.milked();
								break;
					case 14:	if (milkOption(KBIT_MILK_SHARE_WITH_FRIENDS) && model.time.days % 4 == 0) breasts.milked();
								break;
					case 16:	if (milkOption(KBIT_MILK_SHARE_WITH_FRIENDS | KBIT_MILK_SHARE_WITH_OLD_GANG | KBIT_MILK_SHARE_WITH_HELENA) && model.time.days % 3 == 0) breasts.milked();
								break;
					case 17:	if (milkOption(KBIT_MILK_SHARE_WITH_FRIENDS | KBIT_MILK_SHARE_WITH_VALA) && model.time.days % 5 == 2) breasts.milked();
					default:
				}
			}
			breasts.advanceTime();
			flags[kFLAGS.KATHERINE_HOURS_SINCE_CUM]++;
			if (flags[kFLAGS.KATHERINE_UNLOCKED] < 4) { //Before employment always returns to the alleyway behind Oswald’s after sex.
				flags[kFLAGS.KATHERINE_LOCATION] = KLOC_STREETS;
				return false; //She only has tattered clothes, so no need to deal with clothing either.
			}
			if (model.time.hours == 6) {
				flags[kFLAGS.KATHERINE_LOCATION] = KLOC_STREETS; //On duty
				flags[kFLAGS.KATHERINE_CLOTHES_WORN] = KBIT_CLOTHES_UNIFORM;
				if (flags[kFLAGS.KATHERINE_URTA_DATE] == KDATE_WHENEVER) {
					if (model.time.days % 4 == 0) katherineAndUrtaHadSex(false); //Roughly twice a week
				}
				else if (flags[kFLAGS.KATHERINE_URTA_DATE] == KDATE_LOTS) katherineAndUrtaHadSex(false); //They fuck at least once a day
				if (flags[kFLAGS.KATHERINE_VALA_DATE] == KDATE_WHENEVER) {
					if (model.time.days % 4 == 0) katherineAndValaHadSex(); //Roughly twice a week
				}
				else if (flags[kFLAGS.KATHERINE_VALA_DATE] == KDATE_LOTS) katherineAndValaHadSex(); //They fuck at least once a day
			}
			else if (model.time.hours == 10) { //Must select her civilian clothes for the day once her shift is over
				var clothesPref:Number = flags[kFLAGS.KATHERINE_CLOTHES_PREF];
				
				if (clothesPref < 0) { //She’s been told what to wear by the PC
					flags[kFLAGS.KATHERINE_CLOTHES_WORN] = -clothesPref;
				}
				else if (clothesPref > 0 && rand(3) != 0) { //You suggested you like one outfit. Kath will listen 3/4 of the time.
					flags[kFLAGS.KATHERINE_CLOTHES_WORN] = clothesPref;
				}
				else { //Kath picks an outfit for herself at random
					var clothes:Number = flags[kFLAGS.KATHERINE_CLOTHES];
					var clothesArray:Array = [];
					
					if (clothesPref != KBIT_CLOTHES_C_CLOTH) clothesArray.push(KBIT_CLOTHES_C_CLOTH); //Always owned
					if (clothesPref != KBIT_CLOTHES_BODYSUIT && (clothes & KBIT_CLOTHES_BODYSUIT) > 0) clothesArray.push(KBIT_CLOTHES_BODYSUIT); //Bodysuit
					if (clothesPref != KBIT_CLOTHES_B_DRESS && (clothes & KBIT_CLOTHES_B_DRESS) > 0) clothesArray.push(KBIT_CLOTHES_B_DRESS); //Long Dress
					if (clothesPref != KBIT_CLOTHES_SS_ROBE && (clothes & KBIT_CLOTHES_SS_ROBE) > 0) clothesArray.push(KBIT_CLOTHES_SS_ROBE); //Spid. Silk Robe
					if (clothesPref != KBIT_CLOTHES_TUBETOP && (clothes & KBIT_CLOTHES_TUBETOP) > 0) clothesArray.push(KBIT_CLOTHES_TUBETOP); //Tube Top
					if (clothesPref != KBIT_CLOTHES_NURSECL && (clothes & KBIT_CLOTHES_NURSECL) > 0) clothesArray.push(KBIT_CLOTHES_NURSECL); //Nurse’s Outfit
					flags[kFLAGS.KATHERINE_CLOTHES_WORN] = clothesArray[rand(clothesArray.length)];
				}
			}
			if (model.time.hours >= 14) {
				//Once employed Kath goes home from any encounter after 14:00 hours, unless they happened at either Urta’s apartment or Urta’s house.
				switch (flags[kFLAGS.KATHERINE_LOCATION]) {
					case KLOC_KATHS_APT:
					case KLOC_URTAS_HOME: break; //Already at final destination for the night
					case KLOC_URTAS_APT:
						if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] > 31) {
							if (rand(4) != 0) { //A three in four chance that Kath will stay with Urta once they've hooked up
								if (player.hasKeyItem("Spare Key to Urta's House") >= 0) flags[kFLAGS.KATHERINE_LOCATION] = KLOC_URTAS_HOME;
								break; //If Urta doesn't have a home to return to then she and Kath stay at the apartment
							}
						}
						else if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] >= 11 && flags[kFLAGS.KATHERINE_URTA_DATE] != KDATE_LITTLE) {
							if (rand(3) != 0) { //A two in three chance that Kath will stay with Urta if they're fuckbuddies
								if (player.hasKeyItem("Spare Key to Urta's House") >= 0) flags[kFLAGS.KATHERINE_LOCATION] = KLOC_URTAS_HOME;
								break; //If Urta doesn't have a home to return to then she and Kath stay at the apartment
							}
						} //else fall through to the default case, Kath goes home
					default: flags[kFLAGS.KATHERINE_LOCATION] = KLOC_KATHS_APT;
				}
			}
			else if (model.time.hours >= 10) {
				//Any time after 10:00 but before 14:00 Kath returns to the bar after encounters, though she will stay at her home if the encounter happened there.
				switch (flags[kFLAGS.KATHERINE_LOCATION]) {
					case KLOC_BAR:
					case KLOC_KATHS_APT: break;
					default: flags[kFLAGS.KATHERINE_LOCATION] = KLOC_BAR;
				}
			}
			return false;
		}
	
		public function timeChangeLarge():Boolean {
			return false;
		}
		//End of Interface Implementation

		public function initFlags():void
		{	//These are all the flags related to Kath that have a non-zero default value
//			flags[kFLAGS.KATHERINE_BREAST_SIZE]		= BREAST_CUP_B;
			breasts.cupSize							= CoC.BREAST_CUP_B;
			breasts.lactationLevel					= BreastStore.LACTATION_DISABLED;
			flags[kFLAGS.KATHERINE_DICK_COUNT]		= 1;
			flags[kFLAGS.KATHERINE_DICK_LENGTH]		= 8;
			flags[kFLAGS.KATHERINE_KNOT_THICKNESS]	= 6;
			flags[kFLAGS.KATHERINE_BALL_SIZE]		= 1;
			flags[kFLAGS.KATHERINE_HAIR_COLOR]		= "neon pink";
			flags[kFLAGS.KATHERINE_HOURS_SINCE_CUM] = 200; //Give her maxed out cum for that first time
			player.removeKeyItem("Silver Kitty-Bell"); //Silver Bell key item removed so any partial recruitment down the Scylla route is cancelled
		}

		public function get breasts():BreastStore { return _breasts; }

		public function get ballSize():int { return flags[kFLAGS.KATHERINE_BALL_SIZE]; }

		public function set ballSize(value:int):void { flags[kFLAGS.KATHERINE_BALL_SIZE] = value; }

//		public function get cupSize():int { return flags[kFLAGS.KATHERINE_BREAST_SIZE]; }

//		public function set cupSize(value:int):void { flags[kFLAGS.KATHERINE_BREAST_SIZE] = value; }

		public function get cockLength():Number { return flags[kFLAGS.KATHERINE_DICK_LENGTH]; }

		public function set cockLength(value:Number):void { flags[kFLAGS.KATHERINE_DICK_LENGTH] = value; }

		public function get cockNumber():int { return flags[kFLAGS.KATHERINE_DICK_COUNT]; }

		public function set cockNumber(value:int):void { flags[kFLAGS.KATHERINE_DICK_COUNT] = value; }

		public function get knotSize():int { return flags[kFLAGS.KATHERINE_KNOT_THICKNESS]; }

		public function set knotSize(value:int):void { flags[kFLAGS.KATHERINE_KNOT_THICKNESS] = value; }

		public function get fertile():Boolean { return false; }

		public function set fertile(value:Boolean):void {}

		public function get furry():Boolean { return flags[kFLAGS.KATHERINE_IS_CAT_GIRL] == 0; } //furry == true means she's a cat morph, furry == false means she's a cat girl

		public function set furry(value:Boolean):void { flags[kFLAGS.KATHERINE_IS_CAT_GIRL] = (value ? 0 : 1); }

		public function get hairColor():String { return flags[kFLAGS.KATHERINE_HAIR_COLOR]; }

		public function set hairColor(value:String):void { flags[kFLAGS.KATHERINE_HAIR_COLOR] = value; }

		public function cockWidth():Number { return (hasDogCock() ? 1.5 : 1); }

		public function cockArea():Number { return cockWidth() * cockLength; }

		public function hasBalls():Boolean { return flags[kFLAGS.KATHERINE_BALL_SIZE] > 0; }

		public function hasCock():Boolean { return flags[kFLAGS.KATHERINE_DICK_COUNT] > 0; }

		public function isAt(location:int):Boolean { return flags[kFLAGS.KATHERINE_LOCATION] == location; }

		public function hasClothing(clothing:int):Boolean { return (flags[kFLAGS.KATHERINE_CLOTHES] & clothing) > 0; }

		public function giveClothing(clothing:int):void {
			flags[kFLAGS.KATHERINE_CLOTHES] |= clothing;
			flags[kFLAGS.KATHERINE_CLOTHES_WORN] = clothing; //She always puts on her new outfit
		}

		public function cockMultiple(single:String, double:String):String { return (flags[kFLAGS.KATHERINE_DICK_COUNT] <= 1 ? single : double); }

		public function hasDogCock():Boolean { return flags[kFLAGS.KATHERINE_DICK_FORM] == 0; }

		public function cockType(dogText:String = "canine", catText:String = "feline"):String { return (flags[kFLAGS.KATHERINE_DICK_FORM] == 0 ? dogText : catText); }

		public function catGirl(isCatGirl:String, isCatMorph:String):String { return (flags[kFLAGS.KATHERINE_IS_CAT_GIRL] == 0 ? isCatMorph : isCatGirl); }

		public function hasAlready(sex:int):Boolean { return (flags[kFLAGS.KATHERINE_SEXUAL_EXPERIENCE] & sex) > 0; } //If false then it's her first time doing this

		public function experience(sex:int):void { flags[kFLAGS.KATHERINE_SEXUAL_EXPERIENCE] |= sex; } //Learned a new way to fuck

		public function milkOption(value:int):Boolean { return (flags[kFLAGS.KATHERINE_MILK_OPTIONS] & value) > 0; } //Check the status of one of Kath's milk options

		public function milkOptionClear(value:int):void { flags[kFLAGS.KATHERINE_MILK_OPTIONS] &= ~value; } //Set a single bit to zero

		public function milkOptionSet(value:int):void { flags[kFLAGS.KATHERINE_MILK_OPTIONS] |= value; } //Set a single bit to one

		public function cumQ():Number
		{	//Uses roughly the same calculations as for the player's cum production with cumMultiplier == 10, bonusCum == 300
			//For no balls: Min = 312, Average =  411, Max =  510 //Without any prostate boosting
			//For 1" balls: Min = 317, Average =  448, Max =  580
			//For 2" balls: Min = 333, Average =  596, Max =  860
			//For 3" balls: Min = 350, Average =  745, Max = 1140
			//For 4" balls: Min = 367, Average =  893, Max = 1420
			//For 5" balls: Min = 383, Average = 1041, Max = 1700 //Previous max size
			//For 6" balls: Min = 400, Average = 1190, Max = 1980
			//For 7" balls: Min = 416, Average = 1338, Max = 2260
			//For 8" balls: Min = 433, Average = 1486, Max = 2540
			//For 9" balls: Min = 450, Average = 1635, Max = 2820
			var quantity:Number = 40 * Math.min(168, flags[kFLAGS.KATHERINE_HOURS_SINCE_CUM] + 10) / 24;
			if (ballSize <= 0)
				quantity *= 0.75 + 0.25 * (-ballSize); //Values below zero indicate a prostate enhanced by Succubi's Delight
			else quantity *= ballSize;
			return quantity + 300;
		}

		public function orgasm():void { flags[kFLAGS.KATHERINE_HOURS_SINCE_CUM] = 0; }

		public function fertileText(fertileText:String, infertileText:String):String { return (fertile ? fertileText : infertileText); }

		public function pregSize():int { return 0; }

		public function ballAdj():String
		{
			switch (flags[kFLAGS.KATHERINE_BALL_SIZE]) {
				case 0:
				case 1: return "small";
				case 2:
				case 3: return "large";
				case 4:
				case 5: return "huge";
				case 6:
				case 7: return "massive";
				default: return "enormous";
			}
		}

/*
		public function breastAdj():String {
			switch (cupSize) {
				case BREAST_CUP_FLAT:		return "non-existent ";
				case BREAST_CUP_A:			return "small ";
				case BREAST_CUP_B:
				case BREAST_CUP_C:			return "palmable ";
				case BREAST_CUP_D:
				case BREAST_CUP_DD:			return "sizeable ";
				case BREAST_CUP_DD_BIG:
				case BREAST_CUP_E:
				case BREAST_CUP_E_BIG:
				case BREAST_CUP_EE:
				case BREAST_CUP_EE_BIG:
			}
			return(" ");
		}
*/

		public function cockAdj():String
		{
			switch (flags[kFLAGS.KATHERINE_DICK_LENGTH]) {
				case  0:
				case  1:
				case  2:
				case  3:
				case  4:
				case  5: return "little ";
				case  6:
				case  7: return " ";
				case  8:
				case  9:
				case 10: return "sizeable ";
				case 11:
				case 12:
				case 13:
				case 14: return "large ";
				case 15:
				case 16:
				case 17:
				case 18: return "huge ";
				default: return "enormous ";
			}
		}

		public function knotAdj():String {
			switch (flags[kFLAGS.KATHERINE_KNOT_THICKNESS]) {
				case 0:
				case 1:
				case 2:
				case 3: return "small";
				case 4:
				case 5: return "sizeable";
				default: return "huge";
			}
		}

		public function isMilky():Boolean { //Quick check to decide if we should mention her lactation in descriptions
			return (breasts.milkIsOverflowing() && breasts.lactationLevel >= BreastStore.LACTATION_MODERATE) || (breasts.milkIsFull() && breasts.lactationLevel >= BreastStore.LACTATION_HEAVY);
		}

		private function tightTopDescption():void {
			switch (breasts.cupSize) {
				case CoC.BREAST_CUP_FLAT:
				case CoC.BREAST_CUP_A:
				case CoC.BREAST_CUP_B: outputText("tight enough to showcase even her small breasts"); break
				case CoC.BREAST_CUP_C:
				case CoC.BREAST_CUP_D:
				case CoC.BREAST_CUP_DD: outputText("just able to hold her bountiful breasts in check"); break;
				default:
			}
			outputText("overflowing with her bountiful titflesh");
		}

		public function canWearMiniSkirt():Boolean { return cockLength <= 8 && ballSize < 3; }

		private function skirtDescription():String {
			if (canWearMiniSkirt())
				return "  It’s more than long enough to successfully conceal her masculine additions.";
			else if (cockLength < 18)
				return "  It doesn’t quite draw your eye away from the rather unlady-like bulge at her crotch.";
			else return "  It barely conceals the enormous bulge that tents the front.";
		}

		public function clothes():void { //Produces a few sentences which describe what Katherine is currently wearing
			var milky:Boolean = isMilky();
			switch (flags[kFLAGS.KATHERINE_CLOTHES_WORN]) {
				case KBIT_CLOTHES_UNIFORM: //Guard Uniform
					outputText("She’s wearing a suit of leather armor with some chainmail patches over a properly fitting pair of leggings and a tunic" + (hasCock() ? ", just tight enough to make it clear she’s a herm" : "") + ".  On one hip she sports a broadsword in a scabbard - nothing fancy, but clearly well-made and ready to be used.  On the other hip is her persuader, a leather wrapped wooden club." + (milky ? "  You detect the faint smell of milk in the air when she's near." : ""));
					break;
				case KBIT_CLOTHES_C_CLOTH: //Blouse and Skirt
					outputText("She’s wearing a clean, attractively colored blouse, which ");
					if (breasts.cupSize < CoC.BREAST_CUP_DD)
						outputText("is just tight enough at the chest to enhance her breasts without making things too obvious.");
					else outputText("strains to hold her bountiful breasts in check.");
					if (milky) outputText("  The blouse is a little damp thanks to leakage from her bountiful bosom.");
					outputText("  From the waist down, she wears a matching skirt that ends at her knees." + (hasCock() ? skirtDescription() : ""));
					break;
				case KBIT_CLOTHES_BODYSUIT: //Bodysuit
					outputText("She’s wearing the semi-transparent bodysuit you gave her with pride.  Its curve hugging fabric puts every inch of her flexible body on display while remaining technically decent.");
					if (milky) outputText("  The fabric over her chest is a little damp and even more transparent than the rest thanks to leakage from her bountiful bosom.");
					break;
				case KBIT_CLOTHES_B_DRESS: //Elegant Long Dress
					outputText("She’s wearing the ballroom dress you gave her with pride.  Its sequined bodice draws attention to her chest while the floor length skirts " + (hasCock() ? "completely conceal her masculine additions and " : "") + "draw the eye to her hips.");
					if (milky) outputText("  Despite some extra absorbent padding the fabric over her chest is a little damp thanks to leakage from her bountiful bosom.");
					break;
				case KBIT_CLOTHES_SS_ROBE: //Spider Silk Robe
					outputText("She’s wearing the spider silk robe you gave her with pride.  The soft fabric drapes over her features in a pleasing way.  The runes along the edges of the fabric draw your eye across Kath’s body.");
					if (milky) outputText("  The fabric over her chest has wicked up a great deal of Kath's cream and the wet silk cleaves to her bosom in a most attractive way.");
					break;
				case KBIT_CLOTHES_TUBETOP: //Tube Top
					outputText("She’s wearing the snug tube top you gave her, which is ");
					tightTopDescption();
					outputText((milky ? ", the thin fabric a little damp thanks to leakage from her bosom" : "") + ".  ");
					if (canWearMiniSkirt())
						outputText("From the waist down, she wears a pair of skintight shorts, which are " + (hasCock() ? "barely able to hold her unlady-like bulge in place." : "tight enough to prove to any passerby that she truly is a lady."));
					else outputText("From the waist down, she wears a matching skirt that ends at her knees." + (hasCock() ? skirtDescription() : ""));
					break;
				case KBIT_CLOTHES_NURSECL: //Nurse’s Outfit
					outputText("She’s wearing the scandalous white nurse’s outfit you gave her.  It bares her midriff, showing off her tight abs.  The top is ");
					tightTopDescption();
					outputText((milky ? ", the white fabric a little damp thanks to leakage from her bosom" : "") + ".  ");
					if (canWearMiniSkirt())
						outputText("From the waist down, she wears a tight white miniskirt that " + (hasCock() ? "barely conceals her unlady-like bulge." : "will flash her panties at passersby if she takes a long stride."));
					else outputText("From the waist down, she wears a matching white skirt that ends at her knees." + (hasCock() ? skirtDescription() : ""));
					outputText("  The outfit, and Kath herself, are topped off with the cute little white hat that sits between her fuzzy black ears.");
					break;
				default: //Tattered Clothes
					outputText("She wears weatherbeaten, somewhat ragged, clearly second-hand clothing, consisting of a too-large shirt and a very tight pair of shorts.");
			}
		}

		/*  This function will return whichever output is appropriate right now based on clothes worn. Saves using a switch statement every time we want to refer to her clothing.
			Note that any scenes which appear while Kath is on duty or which are available before she gets a home have to check if she's wearing a uniform or tattered clothes. */
		public function clothesChoice(comfortableClothesText:String, bodysuitText:String, dressText:String, robeText:String, tubeTopText:String, nurseClothesText:String):String
		{
			switch (flags[kFLAGS.KATHERINE_CLOTHES_WORN]) {
				case KBIT_CLOTHES_BODYSUIT: return bodysuitText;
				case KBIT_CLOTHES_B_DRESS: return dressText;
				case KBIT_CLOTHES_SS_ROBE: return robeText;
				case KBIT_CLOTHES_TUBETOP: return tubeTopText;
				case KBIT_CLOTHES_NURSECL: return nurseClothesText;
				default:
			}
			return comfortableClothesText;
		}

		/*  Because of Kath’s clothing choices there are now five different types of clothes she could be wearing on her lower body. That can be a pain to work with so this function
			will return whichever output is appropriate right now based on clothes worn. Saves using a switch statement every time we want to refer to her pants/skirt/robe/etc. */
		public function clothesLowerChoice(pantsText:String, skirtText:String, bodysuitText:String, dressText:String, robeText:String):String
		{
			switch (flags[kFLAGS.KATHERINE_CLOTHES_WORN]) {
				case KBIT_CLOTHES_C_CLOTH: return skirtText;
				case KBIT_CLOTHES_BODYSUIT: return bodysuitText;
				case KBIT_CLOTHES_B_DRESS: return dressText;
				case KBIT_CLOTHES_SS_ROBE: return robeText;
				case KBIT_CLOTHES_TUBETOP:
					if (canWearMiniSkirt()) return skirtText; //A large package needs a skirt to hide it
					break; //Smaller bulge can be concealed in tight pants
				case KBIT_CLOTHES_NURSECL: return skirtText;
				default:
			}
			return pantsText; //For tattered clothes, watch uniform & tube tops with a small package
		}

		/*  New function to calculate how submissive Katherine is, based on what kinds of things the PC has talked her into doing (or forced her into doing) already.
			Anything that Kath does against her own better judgement to make the PC happy should count towards this. */
		public function submissiveness():int {
			var subFlags:int = flags[kFLAGS.KATHERINE_SUB_FLAGS];
			var subCount:int = 0;
			if ((subFlags & KBIT_SUB_HIGH_CUM) > 0) subCount++;
			if ((subFlags & KBIT_SUB_BED_BOND) > 0) subCount++;
			if ((subFlags & KBIT_SUB_ORGASM_DENIAL) > 0) subCount++;
			//KBIT_SUB_CALL_MASTER doesn’t count - it just shows you told her to call you master
			if ((subFlags & KBIT_SUB_GROW_KNOT) > 0) subCount++;
			if ((subFlags & KBIT_SUB_CAT_DICK) > 0) subCount++;
			if ((subFlags & KBIT_SUB_GROW_BIG_BOOBS) > 0) subCount++;
			if ((subFlags & KBIT_SUB_GROW_BIG_DICK) > 0) subCount++;
			if ((subFlags & KBIT_SUB_CAT_GIRL) > 0) subCount++;
			if ((subFlags & KBIT_SUB_HIGH_LACTATION) > 0) subCount++;
			if ((subFlags & KBIT_SUB_REM_BALLS) > 0) subCount++;
			if ((subFlags & KBIT_SUB_GROW_BIG_BALLS) > 0) subCount++;
			if ((subFlags & KBIT_SUB_PUBLIC_EXHIBITION) > 0) subCount += 2; //Worth double
			if ((subFlags & KBIT_SUB_REM_COCK) > 0) subCount++;
			if (subCount < 4 && (subFlags & KBIT_SUB_START_LACTATION) > 0) subCount++;
			return subCount;
		}

		public function addSubmissive(behaviour:int):void { flags[kFLAGS.KATHERINE_SUB_FLAGS] |= behaviour; }

		public function doneSubmissive(behaviour:int):Boolean { return ((flags[kFLAGS.KATHERINE_SUB_FLAGS] & behaviour) > 0); }

		public function playerMaster():Boolean { return (flags[kFLAGS.KATHERINE_SUB_FLAGS] & KBIT_SUB_CALL_MASTER) > 0; }

		public function playerText():String
		{	//For the simplest case. Will not work properly at the start of sentences.
			if ((flags[kFLAGS.KATHERINE_SUB_FLAGS] & KBIT_SUB_CALL_MASTER) > 0) return("[master]");
			return player.short;
		}

		public function katherineAndUrtaHadSex(drunkSex: Boolean):void {
			//Every time they have sex they get a little closer, but this is limited to a max of 30
			//while still in training. Once Kath has a job they can tell you they love each other.
			//Only the two of them having sex sober can cause them to gain the last point.
			flags[kFLAGS.KATHERINE_URTA_TIMES_SEX]++;
			if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] >= 31) return;
			if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] == 30 && (drunkSex || flags[kFLAGS.KATHERINE_UNLOCKED] < 4 || flags[kFLAGS.KATHERINE_URTA_DATE] == KDATE_LITTLE)) return;
			//Kath and Urta can’t gain that last point and become lovers if Kath has not yet
			//completed her training, if this was alcohol fueled sex or if you told them to only
			//fuck each other when you were around.
			flags[kFLAGS.KATHERINE_URTA_AFFECTION]++;
		}

		public function katherineAndValaHadSex():void {
			//Every time they have sex they get a little closer, but this is limited to a max of 11.
			flags[kFLAGS.KATHERINE_VALA_TIMES_SEX]++;
			if (flags[kFLAGS.KATHERINE_VALA_AFFECTION] > 11) return;
			flags[kFLAGS.KATHERINE_VALA_AFFECTION]++;
		}

		public function needIntroductionFromScylla():Boolean {
			return model.time.hours > 8 && model.time.hours < 18 && player.hasKeyItem("Silver Kitty-Bell") >= 0;
		}
		
		public function katherineSprite(naked:Boolean = false):void {
			if (naked) {
				spriteSelect(127);
				return;
			}
			spriteSelect(128); //Currently returns this sprite.
		}
		
//If player has Silver Bell key item and is at Wet Bitch when Scylla is not busy with her Addicts Anonymous group
public function catMorphIntr():void {
	outputText("\n\nThe cum-drinking nun Scylla is here, apparently resting up between one of her missions.  Recalling the last 'mission' you went on, your hand unthinkingly touches the silver bell you received from that strange herm cat-morph.  Scylla could probably help you find her again.");
}

public function katherineGreeting():void {
	clearOutput();
	//[If Player chooses 'Scylla' button]
	outputText("Scylla smiles when she sees you approaching, and politely greets you.  “<i>Why, hello, " + player.short + "; it's good to see you.  Do you need something?</i>”\n\n", false);

	outputText("You tell her that you do, and, showing her the bell you have, you ask her if she remembers that little mission the two of you went on where she ended up ministering to those milk-hungry cats.\n\n", false);

	outputText("Scylla nods, a pleased expression and a soft blush blooming on her features.  “<i>Yes.  Poor things... to be so hungry as to do something like that.</i>”  Then she stops and her eyes focus on the bell, glittering with mirth.  “<i>I take it you want to see the friendly dear who gave you that bell again?</i>” she asks.  When you admit that is what you hoped she'd help you with, she promptly stands up, decisively.  “<i>Well then, let's go and re-introduce you two.</i>”  She smiles softly as she turns and walks away at a brisk pace, forcing you to hurry to catch up.\n\n", false);

	outputText("Scylla takes you on a very different route from the last time you 'encountered' the cat-morphs in question, leading you to a surprisingly seedy part of the city.  Strangely, despite all of the houses you know are empty and uninhabited from the people lost to the demons, there are myriad people around who are quite clearly vagrants.  Centaurs, dog-morphs, cat-morphs, mouse-morphs, fox-morphs, wolf-morphs, and stranger things beside - you think you see something that looks vaguely like a centaur/wolf-morph hybrid at one point.  Curious, you can't help but ask Scylla what you're doing here.\n\n", false);

	outputText("The towering nun suddenly calls out.  “<i>I did a little asking around after that first incident.  They told me that those cats in particular like to hang out in this part of town.  In fact... there!  Hello!  Mr. Kitty?  I want to talk with you and your friends...  Maybe, if you're thirsty, I can offer you a drink?</i>”\n\n", false);

	outputText("You're caught off-guard by Scylla's actions, but then spot a familiar-ish feline face peeking warily out from behind a corner.  You make a point of walking away from Scylla, and one of the male cats who basically mugged Scylla for her milk promptly slips out of hiding, the other eleven or so males and females quickly joining him.  The mutated nun, smiling with all three lips, is already innocently removing her habit to expose her huge, milk-filled breasts.  The cats barely hesitate before swarming towards her, pushing and shoving to be the first to start making out with her lipples and drinking their fill of creamy nun-milk.  You watch the situation dispassionately - it is, after all, a lot more voluntary on Scylla's part than it was the first time - and then pull out the silver bell, which you start idly jingling.\n\n", false);

	outputText("“<i>...Is that really you?  You actually came?</i>”  A voice from just off to the side sounds; quiet, hesitant, filled with hope, doubt and fear in equal parts.\n\n",false);

	outputText("Looking around, you quickly spot the lonely herm cat-morph, the reason behind your coming here.  Still dressed in her ragged clothes, her too-large shirt covers up her B-cup breasts, while her too-tight pants make her canine sheath and small balls stand out to a casual observer.  Under these calmer conditions, you can make out her eyes, a rather pretty shade of green, while her shoulder-length hair is neon pink, a stark contrast to her black fur.  Funny, you don't recall it being that color before... finally remembering that she's addressed you, you smile and agree.\n\n", false);

	outputText("She looks from you to the small milk-drinking orgy and then shyly indicates an alleyway nearby.  “<i>Do you want to talk somewhere more privately?</i>” she asks.  When you indicate your assent, she gives a relieved smile and leads you away.  Once you're out of sight of the other cats, she suddenly hugs you fiercely.  “<i>I can't believe you actually came!  Oh, I dreamed that this would happen!</i>”  She purrs, happily rubbing her cheek against you, then pulls away timidly, blushing brightly.  “<i>I'm sorry... It's just,  I've never had anyone show interest in me before.  Not with this...</i>”  She strokes the bulge of her puppy pecker meaningfully.  Then, a thought seems to occur to her and she turns a fearful look at you.  “<i>You - are - interested in me, aren't you?  You didn't come here just to tell me off for liking you?</i>”  From the tone of her voice, this last question was more a plea than an icebreaker.\n\n", false);

	outputText("You smile and assure her that you are interested... though you have to confess that more intimate conversations may have to wait for another time.  As if on cue, the happy purring of other cat-morphs reaches you in the alleyway as they start to finish up with Scylla.\n\n", false);

	outputText("The dog-dicked cat nods.  “<i>Right.... hey, there's a pawnshop in the main street - run by a golden retriever named Oswald?  You know it?</i>”  When you nod your head, she continues, “<i>Well, Oswald's a pretty nice guy, he buys things I find sometimes and always gives me a fair price even though it's obvious how desperate I am; these guys don't really care whether I'm here or not, so I'll start hanging around in the back alley behind his place.  We can meet up there - is that okay with you?</i>”\n\n", false);

	outputText("You tell her that sounds much better than needing to get Scylla to come here as a distraction each time.  The silver bell you return to her, with a coy remark that it looks better on her anyway.  Giving you a heartfelt smile, she gently takes it, then reattaches it to her leather collar.\n\n", false);

	outputText("As you walk away, she realizes something.  “<i>Oh!  My name's Katherine!  What's yours?</i>” she asks.  With another smile, you tell her. She mouths the name to herself, her eyes a-twinkle with happiness.\n\n", false);

	outputText("The other cats are lying sprawled in the street, swollen with the milk they've drunk from Scylla, who is merrily pulling her habit back on.  She gives you a knowing look but doesn't speak as she leads you back toward the main street.", false);
	outputText("\n\n<b>(Kath's Alley unlocked in Oswald's Pawn shop menu!)</b>", false);

	initFlags();
/*	flags[kFLAGS.KATHERINE_DICK_COUNT] = 1; //All in initFlags now
	flags[kFLAGS.KATHERINE_DICK_LENGTH] = 8;
	flags[kFLAGS.KATHERINE_KNOT_THICKNESS] = 6;
	flags[kFLAGS.KATHERINE_BALL_SIZE] = 1; */
	//Player can now encounter Katherine by using the Back Alley button at the Pawn Shop
	flags[kFLAGS.KATHERINE_UNLOCKED] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//Seeing Katherine
public function visitKatherine():void {
	clearOutput();
	katherineSprite();
	outputText(images.showImage("katherine-visit-alley"));
	if (flags[kFLAGS.KATHERINE_UNLOCKED] == 1) {
		if (telAdre.katherineEmployment.initiateTraining()) return;
	}
	//If Back Alley button is selected
	outputText("The back alley behind Oswald's pawnshop is quite unremarkable, except that it's reasonably clean.  A number of empty crates, old blankets and torn strips of cloth have been assembled into a makeshift “<i>nest</i>”, the kind of place that a homeless vagrant would use as a resting place.\n\n");
	katherineVisitNormal();
}

public function katherineVisitNormal(checkTraining:Boolean = true):void
{
	outputText("Katherine the cat is currently ");
	switch (rand(5)) {
		case  0: outputText("sitting in a corner"); break;
		case  1: outputText("pacing back and forth"); break;
		case  2: outputText("sipping furtively at a bottle of milk"); break;
		case  3: outputText("yawning and stretching"); break;
		default: outputText("waking up from a cat-nap");
	}
    if (flags[kFLAGS.KATHERINE_UNLOCKED] == 1) { //Regular menu
        outputText(", and she smiles when she sees you.  “<i>" + player.short + "!  Did you come to see me?</i>”");
		if (checkTraining && flags[kFLAGS.KATHERINE_TRAINING] > 2) { //You have talked to at least one of Edryn, Urta or the desk sargeant
			telAdre.katherineEmployment.talkToKath();
			return;
		}
        katherineMenu();
    }
    else { //You are training her alone
		outputText(".\n\n");
		if (flags[kFLAGS.KATHERINE_TRAINING] >= 100)
			telAdre.katherineEmployment.katherineTrainingComplete();
		else if (flags[kFLAGS.KATHERINE_TRAINING] >= 66)
			telAdre.katherineEmployment.katherineTrainingStage3();
		else if (flags[kFLAGS.KATHERINE_TRAINING] >= 33)
			telAdre.katherineEmployment.katherineTrainingStage2();
		else telAdre.katherineEmployment.katherineTrainingStage1(false);
    }	
}

public function visitAtHome():void { //You go to Kath's place alone - she may or may not be home
	clearOutput();
	if (isAt(KLOC_KATHS_APT)) {
		if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] == 31) { //Special event that happens only once
			katherineSprite();
			outputText("When you open the door to Kath’s place you see Kath and Urta both sitting together on the bed.  As soon as they spot you Kath crooks her finger and scoots over, leaving a space between her and Urta.\n\n");
			outputText("Once you’re seated Urta laughs and says, “<i>so your big plan worked.  You got us fucking, " + (flags[kFLAGS.KATHERINE_URTA_DATE] == KDATE_LOTS ? "hell you encouraged us to fuck every chance we got!  So" : "so") + " it should be no surprise that we’ve become close.</i>”\n\n");
			outputText("“<i>Really close,</i>” says Katherine, grinding her hip up against yours.\n\n");
			outputText("“<i>So anyway,</i>” Urta continues, “<i>we both still love you, especially since we only met each other because of you.  But now we love each other too.  I figure you must have expected this, so don’t pretend to be surprised.</i>”\n\n");
			outputText("“<i>How do you want to celebrate?</i>” asks Kath.  You can see the matching pair of " + (hasCock() ? "bulges" : "smiles") + ", one to each side.  They both put their arms around you, pressing their breasts against you deliberately.  But hey, who are you to argue?  A threesome seems like an awfully good idea.");
			flags[kFLAGS.KATHERINE_URTA_AFFECTION] = 32;
			var button:int = 0;
			menu();
			if (player.hasCock()) addButton(button++, "369", telAdre.katherineThreesome.threeSixtyNine);
			if (hasCock())
				addButton(button++, "Roast You", telAdre.katherineThreesome.roastYou);
			else addButton(button++, "Watch", telAdre.katherineThreesome.watch, false); //A non-drunk version of this scene deals with the difficult ones if Kath can't pound you
			if (player.hasCock() || player.hasVagina()) addButton(button++, "Spitr Kath", telAdre.katherineThreesome.spitroastKath);
		}
		else {
			katherineSprite();
			outputText("It looks like Kath heard you coming.  You find her waiting in her bedroom with a sexy smile that suggests she’s up for anything.");
			clothes();
			outputText("\n\nShe stands next to her bed, waiting for you to " + (playerMaster() ? "tell her what to do." : "make the first move."));
			katherineMenu();
		}
	}
	else if (model.time.hours < 10) {
		outputText("Kath's apartment is empty.  That shouldn't be surprising to you, at this time of the morning she's got to be out patrolling the market.\n\n");
		katherineApartmentEmptyLeave();
	}
	else if (isAt(KLOC_URTAS_APT) || isAt(KLOC_URTAS_HOME)) {
		outputText("The apartment is empty.  Unusual, but maybe Kath is staying over at Urta's place - you could always check for her there.");
		simpleChoices("Go to Urta's", katherineAtUrtas, "Leave", katherineApartmentEmptyLeave, "", null, "", null, "", null);
	}
	else {
		outputText("It looks like Kath is out somewhere.  She's probably still at the Wet Bitch.");
		doNext(telAdre.telAdreMenu);
	}
}

private function katherineApartmentLeave():void {
	clearOutput();
	outputText("You sigh and tell Kath that you just stopped by to see her.  Unfortunately you have to get going.  She gives you a sad look but nods and says “<i>");
	if (playerMaster())
		outputText("Yes [master].  Please come back soon.</i>”\n\n");
	else outputText("Alright " + player.short + " but next time I want to have some fun.</i>”\n\n");
	doNext(telAdre.telAdreMenu);
}

private function katherineApartmentEmptyLeave():void {
	outputText("You lock up and walk back toward the market, looking for something else to do while you wait for Katherine to finish her shift.");
	doNext(telAdre.telAdreMenu);
}

public function katherineAtUrtas():void {
	outputText("You lock up and walk over to Urta's ");
	if (isAt(KLOC_URTAS_APT)) { //This option happens if you and Urta have no children
		outputText("apartment.  A few knocks on the door and " + (hasCock() ? "a sheepish looking pair of herms" : "your sheepish lovers") + " answer the door.\n\n");
		outputText("“<i>" + player.short + ", speak of the devil,</i>” Urta says, sounding relieved.  “<i>For a second there I thought we had actually been loud enough that a neighbour came over to complain.</i>”\n\n");
		outputText("Kath says, “<i>We just finished cleaning up, so I was just about to head home for the night.  Where did you want to go?</i>”");
		simpleChoices("To Kath's", dateGotoKaths, "To the Lake", dateKathBath, "To the Bar", dateGotoBar, "", null, "Leave", telAdre.telAdreMenu);
	}
	else { //At Urta's House
		switch (rand(4)) {
			case 0:
				outputText("house.  Letting yourself in with the spare key you sneak upstairs and peek into the master bedroom.\n\n");
				outputText("You can smell the sex from the doorway.  On the bed you can see both your girls, " + (hasCock() ? "each bloated with the other's cum" : "Urta's horsecock still buried inside Kath; Kath's belly still bloated with Urta's seed") + ".  They're hugging each other tight and their tails are moving back and forth lazily.\n\n");
				outputText("You could say hello or you could just let yourself out quietly.");
				simpleChoices("Say Hello", urtaPlusKathCuddle, "", null, "", null, "", null, "Leave", telAdre.telAdreMenu);
				break;
			case 1:
				outputText("house.  Letting yourself in with the spare key you sneak upstairs and peek into the master bedroom.\n\n");
				outputText("You see Urta sitting with Kath in front of a large mirror.  It looks like she's helping dry Kath's hair with a towel while Katherine " + clothesChoice("finishes adjusting her blouse", "finishes strightening out her sheer bodysuit", "does up the last few buttons on her long dress", "fiddles with her spider silk robe, seemingly trying to find a way to show off more of her skin", "adjusts her tube top, making sure the outline of her bra shows through the tight fabric", "adjusts the sexy nurse's outfit you gave her and plays with the little white hat that's sitting on her lap") + ".\n\n");
				outputText("Kath spots you in the mirror and waves you in happily, trying to jump up and hug you.\n\n");
				outputText("Urta holds Kath in her seat while she picks up a comb and finishes working on Kath's " + hairColor + " locks.  “<i>Hold still you horny pussy, I'm almost done.  You want to look your best for " + player.short + ", don't you?</i>”\n\n");
				outputText("Urta gives each of you a kiss and shakes her head when Kath wraps herself around you.  “<i>Where do you get the energy Kath?</i>” she asks.  “<i>You want sex even more than I do.</i>”  You feel Kath blush a little at Urta's comment, but a quick scratch of her ears and she goes back to snuggling in your arms.\n\n");
				outputText("Urta walks over and hugs her from the other side, kissing each of you.  “<i>Much as I'd love to join you I need to rest up for tomorrow.  Have fun, but don't do anything I wouldn't do.</i>”\n\n");
				outputText("Kath snickers at the tired old saying and Urta swats her bum, then pushes both of you out the door.  “<i>Make sure to come by sometime soon.  I might not be in the mood now, but I guarantee it'll be a different story by tomorrow morning.</i>”");
				simpleChoices("To Kath's", takeKathHome, "To the Lake", dateKathBath, "To the Bar", takeKathToTheBar, "", null, "", null);
				break;
			default:
				outputText("house.  You step inside and find Kath sitting on the floor with ");
				var kids:int = kGAMECLASS.urtaPregs.urtaKids();
				if (kids == 1)
					outputText("your child.  " + (flags[kFLAGS.URTA_FIRSTBORN_GENDER] == 1 ? "He" : "She") + "'s sitting in Katherine's lap, head mashed against her breasts like " + (flags[kFLAGS.URTA_FIRSTBORN_GENDER] == 1 ? "he" : "she") + " hasn't got a care in the world.\n\n");
				else outputText((kids > 5 ? "a few of your kids" : "a pile of your children") + ".  They're lying all over Kath, playing with her ears and tail while she scratches their heads and gives them little kisses.");
				outputText("When Kath spots you she gives you a big smile and you hear “<i>" + (player.hasVagina() ? "Mommy" : "Daddy") + "!</i>” from your offspring, who " + (kids > 1 ? "run over and hug" : "runs over and hugs") + " your legs.\n\n");
				outputText("Kath comes over and hugs you too, whispering, “<i>");
				if (kids == 1) 
					outputText(flags[kFLAGS.URTA_FIRSTBORN_GENDER] == 1 ? "He's" : "She's");
				else outputText("They're");
				outputText(" so cute,</i>” in your ear.\n\n");
				outputText("Urta walks down from upstairs and tells ");
				if (kids == 1) 
					outputText(flags[kFLAGS.URTA_FIRSTBORN_GENDER] == 1 ? "him" : "her");
				else outputText("them");
				outputText("them, “<i>Okay, you've " + (kids == 1 ? "" : "all ") + "had fun with aunt Katherine, now move it.  Chores don't do themselves and I'm not going to raise a " + (kids == 1 ? "lazy fox" : "pack of lazy foxes") + ".</i>”  There's little grumbling as ");
				if (kids == 1) 
					outputText(flags[kFLAGS.URTA_FIRSTBORN_GENDER] == 1 ? "he races off to his room" : "she races off to her room");
				else outputText("they race off in different directions");
				outputText(" with the energy of youth.\n\n");
				outputText("Urta gives you both a quick hug and says “<i>Listen, I need to go check on some stuff - duty calls and all that.  Lianna's just had a break thanks to Kath, so she'll be able to keep up.</i>”  She gives you both a quick kiss and heads off towards the watch headquarters with a spring in her step.</i>”");
				simpleChoices("To Kath's", takeKathHome, "To the Lake", dateKathBath, "To the Bar", takeKathToTheBar, "", null, "", null);
		}
	}
}

private function urtaPlusKathCuddle():void {
	if (player.spe > 75) {
		outputText("\n\nYou creep over to the bed and stroke Kath's tail.  She and Urta both nearly jump out of their skin.  Urta gives you a good smack in the shoulder as soon as she realizes who you are and what you just did.  “<i>" + player.short + "!  Are you a frigging ghost or something?  Ow, gods, you just made Kath ");
		if (hasCock())
			outputText("yank her knot right out of me.</i>”\n\n");
		else outputText("dig her " + catGirl("nails", "claws") + " in.</i>”\n\n");
		outputText("Kath looks sheepish and says, “<i>Sorry, sorry, I thought it was ");
		if (kGAMECLASS.urtaPregs.urtaKids() == 1) 
			outputText(flags[kFLAGS.URTA_FIRSTBORN_GENDER] == 1 ? "your son" : "your daughter");
		else outputText("one of your kids");
		outputText(",</i>” while gently stroking Urta's ears.\n\n");
		outputText("Urta lets out a big sigh and returns the favour, garnering a constant deep purr from Kath as she relaxes again.\n\nKath mumbles, ");
	}
	else {
		outputText("\n\nYou creep over to the bed and stroke Kath's tail.  She and Urta both start giggling and Urta pats your hand, saying, “<i>Hey baby, nice try, but you're not as quiet as you think you are.  Care to join us?</i>”\n\n");
		outputText("Kath " + (hasCock() ? "gently removes her knot from Urta's pussy" : "slides off Urta's cock") + " and rolls on her back so she can see you.  “<i>I hope you don't mind - we've been taking care of each other.</i>”\n\n");
		outputText("As if you couldn't tell.  Still, you take a seat on the edge of the bed and give each of them scratches.\n\n");
		outputText("Kath twists and turns under your touch and says, ");
	}
	outputText("“<i>I'm feeling really good right now " + playerText() + ", but if you want to do something, I'm game.</i>”\n\n");
	outputText("Urta laughs and says, “<i>Oh yeah, and leave me with this mess, huh?</i>”  She scoops a little cum up from the bed and rubs it between her fingers.  “<i>I suppose I could take care of it tomorrow morning if it means you get a good dose of pussy, " + player.short + ".</i>”");
	simpleChoices("Back to Kath's", dateGotoKaths, "To the Lake", dateKathBath, "Back to the Bar", dateGotoBar, "", null, "Leave", telAdre.telAdreMenu);
}

public function katherineOnDuty():void {
	clearOutput();
	outputText("As you walk through the streets of Tel’Adre you notice a small group of Watch officers out on patrol.  One of them looks your way and you see a familiar face.  Kath says something to one of the other officers.  Soon enough Kath is headed your way while the others walk to a nearby cafe.\n\n");
	if (flags[kFLAGS.KATHERINE_UNLOCKED] == 4) { //First encounter since training
		outputText("“<i>" + player.short + "!</i>” she calls out, running straight into your arms.  “<i>I’ve been hoping to run into you - here,</i>” she says, thrusting a key into your hand.  “<i>I was so excited when I saw you at the gate; I completely forgot to give you this.  It's a key to my new place.</i>”  She beams proudly as she speaks the words.\n\n“<i>Please come by any time, that way we can get up to anything we want,</i>” she adds before kissing you and wrapping her tail around your waist.  She whispers the directions to her new place in your ear, then releases you and steps back.\n\n“<i>Now, as for right now, y");
		flags[kFLAGS.KATHERINE_UNLOCKED] = 5;
	}
	else { //Normal introduction
		outputText("When she reaches you Katherine skids to a stop.  “<i>" + (playerMaster() ? "[master]" : "Hi " + player.short) + "!</i>” she says, grinning ear to ear.  “<i>Y");
	}
	outputText("ou’ve got good timing.  We were due to take a break anyway.</i>”  Before she says any more Katherine stands up straight, casually places her hands behind her back and shifts her body to emphasize her breasts and the " + (hasCock() ? "bulge of her crotch" : "curve of her hips") + ".  “<i>So... how do I look?</i>” she asks with a purr.\n\n");

    katherinesAppearance(false); //This will output most of the encounter text
	outputText("Totally naked, tail waving with pleasure, Katherine stretches, giving you a very good show of all her most private parts.  “<i>Like what you see, my love?</i>” she purrs.\n\nYes, you do, you tell her.  Her uniform suits her just fine, and you can certainly appreciate her new flirty attitude.  You motion for her to give a little twirl.  The cat" + catGirl(" girl", "-morph") + " does as you indicate, pirouetting with surprising elegance in a slow circle, grinning at you as she resumes facing you.  “<i>You should really come and see me after work.</i>” she winks, even as she bends down and, with a wiggle of her ass, starts gathering her clothes up again.  You can’t help but feel a bit disappointed as she begins to redress.\n\n“<i>But... I still got a little time, if you maybe want to do something else...?</i>” she purrs with a sultry wink.\n\n");
	var getOral:Function = null;
	var penetratePussy:Function = null;
	var penetrateAss:Function = null;
	if (player.gender > 0) getOral = katherineGivesPCOralAllDayLongDotJPG;
	if (player.hasCock() && (player.cockThatFits(70) >= 0)) {
		penetratePussy = penetrateKatsVag;
		penetrateAss = pcPenetratesKatAnally;
	}
	//[Give Oral] [Kath Laps] [Fuck Her] [Anal] [Leave]
	simpleChoices("Give Oral", giveKatOralPenisWingWang,"Kath Laps", getOral,"Fuck Her", penetratePussy, "Anal", penetrateAss, "Leave", katherineOnDutyLeave);
}

private function katherineOnDutyLeave():void {
    outputText("It’s probably best that you don’t get Kath in trouble.  You bid her farewell, promising that you’ll come and see her once she’s off duty.\n\n");
	doNext(telAdre.telAdreMenu);
}

/* First, some assumptions I’ve made:
	Urta is in the bar from the 06:00 until 14:00. We can also meet her at home through the different kid interactions any time after 14:00 once she owns a house. She can potentially be drunk from 09:00 to 14:00, so we can assume that’s not during her shift. Since we also occasionally see Urta working during the day we can assume she’s a bit of a workaholic and makes trips back to the watch headquarters or to problem areas whenever there’s real trouble or she feels like surprising her subordinates. Lets say that Urta works on flex time and does a fixed half shift from 02:00 until 06:00 each day. Then she does paperwork in the bar, troubleshoots and puts out fires over the rest of the day. The early hours might be nice for a fox morph since foxes are nocturnal hunters.

	Edryn is easier. She’s is in the bar from 14:00 to 19:00 (or 14:00 to 16:00 with kids), so it’s likely she works an early shift - 06:00 to 14:00 and then chills out at the bar after work.

	< I’ve put too much thought into this, but I might as well take this to its logical conclusion >
	I’m going to assume the Tel’Adre watch has six eight hour shifts and thanks to Edryn’s quitting time it makes sense to organize them like this:
	A: 02:00 to 10:00,    B: 10:00 to 18:00,    C: 18:00 to 02:00,
	D: 06:00 to 14:00,    E: 14:00 to 22:00,    F: 22:00 to 06:00
	With this arrangement there’s never a time where criminals could surprise the watch during a shift change.

	Since Katherine is a new watch officer and also since cats usually have good night vision it would make sense for Urta to put her on the 02:00 to 10:00 shift. It means Urta gets to keep an eye on her during her own half shift. So at 10:00 Kath gets off work and being a cat morph likely takes numerous catnaps during the day rather than sleeping all at once. She also gets the chance to take a long nap from 20:00 or so till her shift starts at 02:00.


	So the player can meet Kath on the street, in uniform from 06:00 until 09:00. Then at 10:00 Kath goes to the Wet Bitch and stays there until 13:00. From 14:00 until night she’s at her apartment.

	In the bar Katherine will get her own table because she doesn’t like to get as drunk as Urta and also because Urta usually ends up meeting lots of people who come in with information, problems, etc.

	If Kath and Urta reach 31 affection (they are lovers), then there should be a chance each day that Kath hangs out at Urta’s table instead. If so it can be assumed that Kath will be as drunk as Urta is when the player walks in.*/
public function barDescription():void {
	outputText("\n\nYou see Katherine sitting alone in her usual booth, nursing something that " + (pregSize() == 0 ? "looks like a cream liqueur" : "is probably a milkshake") + ".  She’s wearing " + clothesChoice("a matching blouse and skirt", "her sheer bodysuit", "the elegant long dress", "her spider silk robe", "that revealing tube top", "the sexy nurse’s outfit") + (flags[kFLAGS.KATHERINE_CLOTHES_PREF] < 0 ? ", just like you told her to." : "."));
}

public function barApproach():void {
	clearOutput(); 
	katherineSprite();
	outputText("Kath sits up as you approach, preening herself and " + clothesChoice("adjusting her blouse", "stretching to show off the bodysuit", "adjusting her dress", "adjusting the spider silk robe", "smothing out the tube top", "adjusting her cute nurse’s hat") + " as you navigate your way to her table." + (isMilky() ? "  Her hands subconsciously move to her breasts and you note the damp spots over her nipples." : "") + "\n\n");
	outputText("When you sit down Kath asks you what you want to do and takes a sip of her drink.");
	katherineMenu();
}

public function barFirstEncounter():void {
	outputText("\n\nYou see a familiar feline lounging at one of the tables.  When she sees you Kath leaps up, nearly spilling her drink, and tackles you with a hug and a flurry of kisses.\n\n");
	outputText("She finally regains some composure and says, “<i>I’ve been waiting for you to turn up!  It feels like so much has happened these last few days.  Oh, I’m such a screwup - I told you I had an apartment but I didn’t say where.</i>”\n\n");
	outputText("She pulls a key and a scrap of paper out and hands them to you.  “<i>There we go.  A key to my place and directions.  Please come over and see me " + playerText() + ", I’ll be lonely if you don’t.</i>”\n\n");
	outputText("You laugh, give her a scratch behind the ear and let her lead you back to her table.");
	//Show the same menu options you would normally see if sitting with Kath
	flags[kFLAGS.KATHERINE_UNLOCKED] = 5; //She’s met you at the wet bitch and given you her apt key
	katherineMenu();
}

public function barKathUrtaLoveAnnounce():void {
	//Special event that happens on entering the bar when KATHERINE_URTA_AFFECTION == 31
	//and both Kath and (sober) Urta should be present in the bar at this time normally
	clearOutput();
	outputText("When you walk into the Wet Bitch you see Kath and Urta sitting together at Urta's table.  As soon as Kath spots you she waves you over enthusiastically.\n\n");
	outputText("Urta offers you the seat next to her and Kath shifts over so she's on your other side.  “<i>So your big plan worked,</i>” says Urta with a grin that runs from ear to ear.  “<i>You got us fucking, " + (flags[kFLAGS.KATHERINE_URTA_DATE] == KDATE_LOTS ? "hell you encouraged us to fuck every chance we got!  So" : "so") + " it should be no surprise that we’ve become close.</i>”\n\n");
	outputText("“<i>Really close,</i>” says Katherine, grinding her hip up against yours.\n\n");
	outputText("“<i>So anyway,</i>” Urta continues, “<i>we both still love you, especially since we only met each other because of you.  But now we love each other too.  I figure you must have expected this, so don’t pretend to be surprised.</i>”\n\n");
	outputText("“<i>How do you want to celebrate?</i>” asks Kath.  You can see the matching pair of " + (hasCock() ? "bulges" : "smiles") + ", one to each side.  They both put their arms around you, pressing their breasts against you deliberately.  But hey, who are you to argue?  A threesome seems like an awfully good idea.");
	flags[kFLAGS.KATHERINE_URTA_AFFECTION] = 32;
	var button:int = 0;
	menu();
	if (player.hasCock()) addButton(button++, "369", telAdre.katherineThreesome.threeSixtyNine);
	if (hasCock())
		addButton(button++, "Roast You", telAdre.katherineThreesome.roastYou);
	else addButton(button++, "Watch", telAdre.katherineThreesome.watch, false); //A non-drunk version of this scene deals with the difficult ones if Kath can't pound you
	if (player.hasCock() || player.hasVagina()) addButton(button++, "Spitr Kath", telAdre.katherineThreesome.spitroastKath);
}

//Main menu for Kath while she lives in the alley behind Oswald's
private function katherineMenu():void {
	//One menu to rule them all (so the code never gets confused about what it should go back to
	if (flags[kFLAGS.KATHERINE_UNLOCKED] < 4) { //Behind Oswald's pawn shop
		//[Sex] [Talk] [Appearance] [Give Item]
		simpleChoices("Sex", katherineSex, "Talk", talkToKatherine, "Appearance", katherinesAppearance, "Give Item", giveKatherineAnItem, "Back", telAdre.telAdreMenu);
	}
	else if (isAt(KLOC_KATHS_APT)) {
		choices("Appearance", katherinesAppearance, "Sex", katherineSex, "Give Item", giveKatherineAnItem, "", null, "Leave", katherineApartmentLeave,
			"Date", katherineDate, "Talk", talkToKatherine, "", null, "", null, "", null);
	}
	else {
		choices("Drink", (pregSize() == 0 ? katherineDrinkUp : null), "Sex", katherineSex, "", null, "", null, "Leave", telAdre.telAdreMenu,
			"Date", katherineDate, "Talk", talkToKatherine, "", null, "", null, "", null);
	}
}

//Talk
private function talkToKatherine():void {
	clearOutput();
	outputText("You tell Katherine that you'd like to talk.  ");
	if (isAt(KLOC_STREETS)) {
		outputText("The pink-haired black cat looks shy, but excited at that.  “<i>Okay... what do you want to talk about?</i>” she asks, nervously looking at her feet.");
		var employmentTalk:Function = null;
		if (flags[kFLAGS.KATHERINE_UNLOCKED] == 1 && flags[kFLAGS.KATHERINE_TRAINING] == 1) employmentTalk = telAdre.katherineEmployment.employmentTalk;
		//[Racial Tension] [Her History] [Gang] [Dog Cock] [Vagrancy] [Love & Lust]
		choices("RacialTension", katherineDefur, "Her History", katherinesHistory, "Gang", askKatherineAboutGang, "Dog Cock", askKatherineAboutDogCock, "Vagrancy", askKatherineAboutVagrancy, "LoveAndLust", askKatherineAboutLoveAndLust, "Employment", employmentTalk, "", null, "", null, "Back", katherineMenu);
		return;
	}
	outputText((isAt(KLOC_KATHS_APT) ? "She sits on the edge of the bed" : "She leans back in her chair") + " and says “<i>I’d love to talk.  What’s on your mind?</i>”");
	menu();
	addButton(0, "Gangs", talkGangs);
	addButton(1, "The Watch", talkWatch);
	addButton(2, "Her Home", talkHome);
	addButton(3, "The Bar", talkWetBitch);
	if (doneSubmissive(KBIT_SUB_CAT_GIRL)) addButton(4, "Cat Girl", talkCatGirl);
	if (isAt(KLOC_KATHS_APT) && flags[kFLAGS.KATHERINE_CLOTHES] >= 4) addButton(5, "Clothes", talkClothes); //All the special clothes have a value of 4 or more
	if (playerLovers() > 0) addButton(6, "Lovers", talkLovers);
	if (submissiveness() >= 4) addButton(7, "Master", talkMaster);
	if (breasts.lactating()) addButton(8, "Her Milk", talkMilk);
	addButton(9, "Back", katherineMenu);
}

//Talk Scenes
//Racial Tension
private function katherineDefur():void {
	clearOutput();
	outputText("You comment to Katherine that you can't help but notice that she and all of her... ah, 'friends' are cats, and the city seems to be mainly populated by dogs.  Does that have anything to do with her basically being a vagrant?\n\n");

	outputText("“<i>Ah... well, I wouldn't go so far as to say it's entirely to blame for us being on the streets, but I confess that it's definitely had a role to play.  Most of the watch are canines of some description and, well, they do tend to think the worst of any cats they suspect of causing trouble.</i>” Katherine shrugs.\n\n");

	outputText("You comment that you would have thought the demonic threat would make people forget about prejudices like that.\n\n");

	outputText("“<i>We're a lot more united now than we were before, but, honestly, old beliefs die hard, you know?  Horses are dumb, sex-crazed brutes, centaurs are horses with big egos and bad attitudes, dogs are dull-witted, wolves are savage, cats are lazy, mice are cowardly, foxes are shiftless... Well, you can see how it goes.</i>”  The herm cat-morph delivers this proclamation while airly waving one furry hand.  “<i>Besides, it's not as if there are demons beating on the walls day in and day out to remind us all of the greater threat every morning, you know?</i>”\n\n");

	outputText("You click your tongue reflexively.  Politely thanking Katherine for the talk, you turn and walk away.");
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	doNext(telAdre.telAdreMenu);
}

//Her History
private function katherinesHistory():void {
	clearOutput();
	outputText("You tell Katherine you're curious about her.  How did she end up on the streets?  Was she born there - or did she simply lose her family?\n\n");

	outputText("“<i>No, no, nothing quite so dramatic as that.</i>”  The cat-woman laughs.  “<i>My people basically all moved to Tel'Adre before I was born - mother used to complain I was kicking in her womb all the way - when our own cities were ransacked by the demons.  We had to settle in the bad parts of the city - we were lucky Tel'Adre had already lost a lot of people, or they might have turned us away.   I was born in the streets, and I've grown up here,</i>” she explains.\n\n");

	outputText("You ask if that means Katherine's entire family are street-people like she is?\n\n");

	outputText("“<i>No, no, nothing of the sort.</i>”  She looks sheepishly at her hands for a moment.  “<i>I... uh... it's actually kind of embarrassing.  All right, well... my mother and father always had a talent for dealing with people, getting them what they want and what they need for bargain prices.  So, it didn't take them long to set up and run this little shop together, off the main street.  I grew up living there; a bit cramped, but cozy - it was a quiet, safe life.  Unfortunately, I was what you'd call a rebellious teen; I used to hang out on the street all day long, and refused to go to school or learn a trade.  Then, one night, I decided I'd run away and live in the street full-time, because I heard them talking about sending me to join the Watch as a new recruit.</i>”\n\n");

	outputText("She grins.  “<i>Unfortunately, that means I've had to be a vagrant ever since; I don't dare go home as I have no intention of ever joining the Watch, but, well, I don't have a single way of earning myself an honest coin.</i>”\n\n");

	outputText("She sees the look you're giving her and hastily anticipates your reaction.  “<i>But don't worry, I actually like my life!  Nobody telling me what to do, I make my own hours... really, it's not so bad.</i>”\n\n");

	outputText("You're skeptical, but reason there's nothing you can do about it right now.  Politely thanking Katherine for the talk, you turn and walk away.");
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	doNext(telAdre.telAdreMenu);
}

//Gang
private function askKatherineAboutGang():void {
	clearOutput();
	outputText("You ask Katherine if she can tell you anything about the gang of cats you found her running with.\n\n");

	outputText("She looks around, as if expecting them to suddenly appear.  “<i>Okay... just, promise me you won't tell them anything I tell you?</i>”  When you give your word, she sighs softly.  “<i>Well, we're basically just what we look like; a bunch of homeless cats who figured out there was strength in numbers.  We're not really friends, exactly, we just know we can trust each other and we band together to do what we need to do.</i>”\n\n");

	outputText("You ask her just what they actually do");
	if (flags[kFLAGS.KATHERINE_UNLOCKED] == 1)
	{
		outputText(" after all, you did first meet them when they ambushed you ");
		if (flags[kFLAGS.KATHERINE_MET_SCYLLA])
			outputText("and Scylla ");
		outputText("to get at some milk.\n\n");
		
		outputText("Katherine flushes with embarrassment.  “<i>Yes, well... that's honestly not the first time they've done that.  ");
	} 
	else
	{
		outputText(".");
		outputText("\n\nKatherine flushes with embarrassment.  “<i>Well...  ");
	}

	outputText("We all like milk and sometimes have problems getting food, and so we go after lactating women and herms to feed on them - we don't usually mug people,</i>” she hastily appends, “<i>so the Watch aren't chasing us constantly.  Much as they may complain, milk thefts with no actual monetary damages generally aren't important enough for them to bother with.</i>”\n\n");

	outputText("You point out that, either way, attacking people for what is basically their bodily fluid has got to be a dangerous risk to take in this city.  A lot of the people around look like they can take care of themselves.\n\n");

	outputText("“<i>You're not wrong there,</i>” Katherine agrees.  “<i>We actually used to have another male cat named Joey in our gang, 'til he fell afoul of a 'victim' of ours.</i>”  Curious, especially by the way she's smiling at the recollection, you ask her to share the tale.\n\n");

	outputText("“<i>Well, he sees this mouse woman one day, dolled up in a long dress with milk seeping from nipples attached to breasts as big as her head, and decides to go after her without the rest of us.  He stumbled back to the gang later that day, gut swollen, face smeared with white, and looking very shocked.</i>”  She grins wickedly.  “<i>Turns out she was a hermaphrodite; had a horsecock this big,</i>”  Here she touches first her elbow, then the tip of her middle finger.  “<i>And two inches thick.  She apparently led him to a quiet place, acting like she was going to give him the milk he wanted, then she whipped out her dick, knocked him down and tied him up, then made him suck her off - and as she had balls as big and full as her tits under the dress, well...</i>”\n\n");

	outputText("You can't help but picture that in your head and chuckle softly, then ask what happened to him.\n\n");

	outputText("“<i>The others gave him such hell: mocking him for losing to a mouse, teasing him about liking dickgirls, and jeering that at least he got a meal anyway, that he vowed he'd get even; he went back after her again.  And again.  And kept losing.  He didn't always come home with a gut full of dick-milk, but she played with him sexually whenever she won, which was as often as he'd challenge her.  Funny thing was, she never actually raped him, per se - never tried sticking that horsecock up his ass... at least, not if he didn't want her to.  She seemed to think it was all a game and, to be honest, I think he started thinking that way too.  One day, he never came back; he's just shacked up with her permanently, I think.</i>”\n\n");

	outputText("<b>That</b> certainly wasn't the sort of ending you were expecting.  You press her to explain; did they really just move in together?\n\n");

	outputText("“<i>I've actually seen them a few times; they both look very happy, and he's even wearing a little heart tag with her name on it at his neck.</i>”  The cat-herm shakes her head and sighs.  “<i>The other cats never talk about him except to call him a wimp and a sellout.  Personally, I can't help but think he was the smart one.</i>”\n\n");

	outputText("Mulling that over, you remember what you were originally talking about and ask her what the gang does aside from milk-muggings.\n\n");

	outputText("She shrugs.  “<i>Panhandling, a little pickpocketing, some stall-robbing...  Mostly we're urban scavengers - you know, sneaking into abandoned homes and things to pick up stuff we can pawn for money.  It's not as easy as it sounds, and the law really cracks down on it, so if they catch us... it won't go easy.  We do that only when we're sure we can get away with it.</i>”\n\n");

	outputText("Politely thanking Katherine for the talk, you turn and walk away.\n\n");
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	doNext(telAdre.telAdreMenu);
}

//Dog Cock
private function askKatherineAboutDogCock():void {
	clearOutput();
	outputText("You confess to Katherine that you're curious about her dog cock.  How did a cat end up with a canine penis?\n\n");

	outputText("Katherine sighs softly.  “<i>I knew you would ask this eventually.  Well, to answer the obvious question right away, I was born a herm - and no, I never got any grief over it.  The other part happened not too long after I ran away from home to become a street-cat; I was starving hungry, and I was hanging around the markets - one of the traders had managed to bring a load of produce through, so I snuck in and grabbed the first crate of food I could carry on my own before running away.</i>”  She shrugs.  “<i>It was full of canine peppers, but my belly was growling, so I started tucking in... Unfortunately, I was too naive to realize that raw canine peppers have their transformative effects, and these were raw peppers. Native Marethians are resistant to interspecies transformation, but that didn't stop me from changing in my most vital part.</i>”\n\n");

	outputText("Your eyes unthinkingly go to her waist, and she nods.  “<i>I was scared, at first... but it felt so good. Plus, well...</i>”  She blushes.  “<i>It made me grow a bit bigger.</i>”  As you look questioningly, she sheepishly explains, “<i>You have to understand, big dicks aren't really what we cats are known for, and in this city, where a foot long seems to be the new average, well...</i>”  She wriggles in embarrassment.  “<i>So, I hit on what at the time seemed to be a great idea; eat canine peppers until I got as big as I wanted to be, then just steal and eat a whisker fruit to give myself a cat penis back.</i>”  She sighs.  “<i>Unfortunately, I didn't realize they weren't just any old peppers - they were knotty canine peppers. They don't make your canine penis grow, they make your knot grow. I ate the whole crate and all I ended up with for my troubles was an eight inch dick - double what I'd originally had, but entirely due to the initial transformation - a bellyache, and, as I was all too quick to find out, a knot so huge that even whores won't fuck me because it'd rip them apart.</i>”  She sighs lamely.\n\n");

	outputText("You ask why she never went with her plan and used a whisker fruit to change it back.\n\n");

	outputText("“<i>Because, soon afterwards, I found out the last trader who regularly brought whisker fruit into the city vanished.  We still get some in, but the big bakeries and restaurants snap them up - you never see them on sale in the market any more.</i>”  She then looks aside.  “<i>To be honest, I've kinda grown to like the cock itself... I just wish I could shrink the knot down.  But that would take Reducto salve, and that's incredibly rare and expensive.</i>”  This last remark is accompanied with a weak shrug.\n\n");

	outputText("Curious, you prod her with another question; would she ever change her dog-dick for something else, given the opportunity?\n\n");

	outputText("She shakes her head.  “<i>No... like I said, I'm accustomed to the dog-dick now, I even rather like it.  I just want to change the knot.  I'm not saying I want to get my hands on bulbous peppers or double peppers or anything like that.  Actually, I don't think I'd mind the bulbous peppers, and a double pepper might be interesting.  I definitely would like to get my hands on an overly large pepper or two...</i>”  She trails off murmuring, half to you, half to herself.\n\n");

	outputText("Politely thanking Katherine for the chat, you turn and walk away.");
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	doNext(telAdre.telAdreMenu);
}

//Vagrancy
private function askKatherineAboutVagrancy():void {
	clearOutput();
	outputText("You ask Katherine to explain to you how exactly she and her friends can be vagrants; with all the empty houses left in the city, you'd think it would be easy for them to find a house in.\n\n");

	outputText("Katherine scowls.  “<i>It's the government's idea.  Basically, they've repossessed all of the houses that are empty, and you can't get into them until and unless you prove you can make enough money to pay taxes and buy a lease.  No money, no house - that's why we, and many others like us, live on the street.  The Watch spends more time cracking vagrants over the head and expelling us from perfectly good empty houses than doing anything useful.</i>”\n\n");

	outputText("You can't help wondering how much of that is true and how much of that is prejudice.  Politely thanking Katherine for the talk, you turn and walk away.");
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	flags[kFLAGS.KATHERINE_TRAINING] = 1; //Now you can talk about Kath getting a job
	doNext(telAdre.telAdreMenu);
}

//Love & Lust
private function askKatherineAboutLoveAndLust():void {
	clearOutput();
	outputText("Trying to phrase your question politely, you ask why it was that Katherine wanted to see you again, particularly given the circumstances under which you met.\n\n");

	outputText("The dog-dicked herm cat blushes and scrapes one foot nervously along the ground in embarrassment.  “<i>Well, I... uh...  Truth be told?  You're basically the only person I've ever had sex with.</i>”\n\n");

	outputText("Automatically, your eyes are drawn to her crotch and you can't help asking if her canine member is really that off-putting to others.\n\n");

	outputText("“<i>It is, yeah.  Most cats can't get over it, most dogs can't get over the fact the rest of me is still a cat, and even centauresses are wary of letting me shove what is basically a melon in their cunts.</i>”  Katherine nods, sadly.  “<i>But then, you came along... I don't know why you did what you did, but I'm too happy to care.</i>”  A beatific expression covers her face.\n\n");

	outputText("Politely thanking Katherine for the talk, you turn and walk away.");
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	doNext(telAdre.telAdreMenu);
}

private function talkGangs():void {
	clearOutput();
	outputText("You ask Kath what she thinks of the city’s gangs now that she’s on the other side of the law.\n\n");
	outputText("She shakes her head and says, “<i>It can be really weird sometimes.  I know why the different gangs are doing what they do and I know why the watch does what it does.  I mean the law about not living in any of the abandoned houses - that makes no sense to anyone living on the street.  But it makes a lot of sense to someone working in the Watch.  Years ago some gangs fortified buildings and kept the watch out.  The leaders got drunk on power, some became corrupt - or maybe they were a little corrupt to begin with.  Anyway, they had to bring in some of the mages to clear them out and lots of innocent people got hurt.</i>”\n\n");
	outputText("She gets up and paces back and forth.  “<i>All the problems are like that.  I can understand why captain Urta drinks and I know why all the city aldermen go gray.  Limited food and water, dangerous items that can get into the city, people so lost in lust that they forget to eat - and those are just everyday problems.  The city needs people to pull their weight, otherwise the whole place will just turn into a huge orgy and everyone will die of thirst because nobody fixed the pumps that bring water up from the deep aquifer.</i>”\n\n");
	outputText("She walks over and cuddles against you.  “<i>Problem is I know what it looks like from the other side.  A bunch of stuck up assholes who ruin everyone’s day just cause they were here before the refugees arrived.  Mages who tell everyone what to do but won’t tell anyone what they’re doing - heck, they barely ever talk to anyone outside the watch and the aldermen.</i>”\n\n");
	outputText("Kath sighs and then continues, “<i>There’s a reason everyone says something difficult is like herding cats.  We, along with a few other races, tend to be a lot more independent.  We’re even a little proud that we don’t listen to someone just because they say they’re in charge.  New gangs are always forming because we’d rather follow someone we can see and deal with.  Sure, the gang leaders play favorites and take the best food and so on, but at least we know who they are any where it goes.  We know who to complain to when things go wrong.</i>”\n\n");
	outputText("“<i>The short version is that there are no easy answers, at least to Tel’Adre’s troubles.</i>”  She lets go of you and flops back " + (isAt(KLOC_KATHS_APT) ? "onto the bed" : "into her chair") + ".  “<i>Now that you’ve got me all wound up thinking about the city I hope you’re going to help me take my mind off it.</i>”");
	katSexMenu();
}

private function talkWatch():void {
	clearOutput();
	outputText("You ask Kath how things are going for her in the Watch.\n\n");
	outputText("She seems to give it some thought, then says, “<i>It’s been hard getting used to the early morning shift, but my sleep schedule was messed up before I joined.  It’s really strange walking around in uniform, seeing all the eyes out there trying not to look like they’re looking at me.  It’s kinda like getting checked out, except they’re worried about what I might see or what I’m about to do.</i>”\n\n");
	outputText("She puts her arms behind her head and stretches, giving you a great view.  “<i>Before you helped me get into the Watch I always thought most officers were thugs who liked pushing people around.  Now I’ve had a chance to meet them up close and it’s so different.  There are always bad apples, but their squad-mates keep them in line.</i>”\n\n");
	outputText("“<i>Oh, and the stuff some people pull!  One of the centaurs got a week old chamberpot thrown at him.  The perp was high up in a gang and they caught him - literally with his pants down.  He was visiting a herm he knew.  Since he knew he wasn’t getting away he tried to piss off the biggest guy there.  He wanted to get beaten.</i>”\n\n");
	outputText("“<i>I never heard about this before I got into the Watch, but if we beat someone up enough then it looks bad.  The gang leaders play it up, more people join the gang for protection and the perp’s boss makes sure he gets treated better in jail and pays off the fines fast so he gets to go free sooner.  They make it so it pays for their lieutenants to get beaten up.  How messed up is that?</i>”\n\n");
	outputText("Before you can answer Kath presses on.  “<i>I thought I would have a lot more trouble from other officers.  I’m probably the only cat of any kind in the watch.  Most of the officers are dog and fox morphs, there are a few lizards, horses and centaurs and I’ve met one bunny-morph who’s really built; but no cats.  So I was a little surprised.  Just a few comments here and there, and nothing really nasty.  I think everyone’s hoping I’m the first but not the last.  We really could use more recruits.  The fact I’m out there means somebody else doesn’t need to work overtime.</i>”\n\n");
	outputText("Katherine cuddles against you and says, “<i>I think I’m starting to settle in.  I was really dumb when I was younger; I should have listened to my parents when they tried to get me to join.  Thank goodness I finally did listen to you.  Thank you again for helping me.</i>”\n\n");
	if (isAt(KLOC_KATHS_APT))
		outputText("She presses");
	else if (player.isTaur())
		outputText("She gets up, walks slowly around the table and wraps her arms around your waist, rubbing your back right where it curves sharply. She presses");
	else outputText("She gets up, walks slowly around the table and sits " + (player.isNaga() ? "atop your tail" : "on your knee") + ". She wraps her arms around your neck, pressing");
	outputText(" her body up against yours and asks, “<i>Would you like me to show you just how much I appreciate you?</i>”");
	katSexMenu();
}

private function talkHome():void {
	clearOutput();
	outputText("You ask Kath about her home and she just beams.\n\n");
	outputText("“<i>It’s wonderful.  It’s everything I didn’t have out on the street.  I have a bed - my own bed!  I have a table where I can put together a meal, a wardrobe for my clothes, a big washbasin I can use to bathe whenever I want.  But the best thing of all is my door.  I can sleep without worrying if someone is going to try to steal my things or worse.\n\n");
	outputText("I know it’s just two little rooms, but it’s a slice of paradise next to an alleyway under the open sky.</i>”  ");
	if (isAt(KLOC_KATHS_APT))
		outputText("She gets up and walks around the room, drawing her hand across the freshly whitewashed walls.  “<i>This place is great and I owe it all to you.</i>”");
	else outputText("She leans back further and her foot brushes against your " + (player.isNaga() ? "tail" : "leg") + ".  “<i>You know, we could be there right now.  Just say the word and we could start testing how tight the cords under my bed are.</i>”");
	katSexMenu();
}

private function talkClothes():void {
	clearOutput();
	var optionBodysuit:Function		= (hasClothing(KBIT_CLOTHES_BODYSUIT) ? talkClothesBodysuit : null);
	var optionDress:Function 		= (hasClothing(KBIT_CLOTHES_B_DRESS) ? talkClothesDress : null);
	var optionSSRobe:Function 		= (hasClothing(KBIT_CLOTHES_SS_ROBE) ? talkClothesSSRobe : null);
	var optionTubeTop:Function 		= (hasClothing(KBIT_CLOTHES_TUBETOP) ? talkClothesTubeTop : null);
	var optionNurseOutfit:Function 	= (hasClothing(KBIT_CLOTHES_NURSECL) ? talkClothesNurseOutfit : null);
	if (optionBodysuit == null)
		outputText("Looking over your " + catGirl("cat girl", "feline") + " lover you wonder what it would look like if her lithe body were to be stuffed into one of those curve-hugging bodysuits.\n\n");
	if (optionDress == null)
		outputText("A ballroom dress would be a wonderful gift for your herm lover.  You suspect that Kath, with her quite girly outlook would cherish such feminine clothing.\n\n");
	if (optionSSRobe == null)
		outputText((optionBodysuit == null || optionDress == null ? "Another" : "A") + " strange thought crosses your mind: What if you got a really fine silk robe for her to wear?  Perhaps even spider silk?  The soft, lustrous fabric " + catGirl("sliding over her skin would drive her wild", "would compliment her fur nicely") + ".\n\n");
	if (optionTubeTop == null)
		outputText("What Kath needs for her wardrobe is a tube top.  All right - to be honest she doesn’t need that, but you would both enjoy the result.\n\n");
	if (optionNurseOutfit == null)
		outputText((flags[kFLAGS.GIVEN_AMILY_NURSE_OUTFIT] > 0 ? "You remember what happened when you gave your mouse-girl one of those sexy nurse outfits" : "Out there in the wilds you’ve seen those sexy nurse outfits here and there") + ". You shiver at the thought of combining that obscene clothing with your " + catGirl("cat girl", "feline") + " lover and her sex drive.\n\n");
	outputText("You decide to give Katherine a little input on her clothing choices.");
	choices("No Preference", talkClothesNoPreference, "Blouse", talkClothesBlouse, "Bodysuit", optionBodysuit, "Long Dress", optionDress, "", null,
		"Silk Robe", optionSSRobe, "Tube Top", optionTubeTop, "Nurse Outfit", optionNurseOutfit, "", null, "Back", katherineMenu);
}

private function talkClothesNoPreference():void {
	outputText("\n\nYou walk over to Kath and start playing with her tail.  She laughs and jumps into your arms, frisky and ready for fun.  You tell her that the next time she gets dressed she" + (submissiveness() > 1 ? "'s allowed to choose" : " should pick out") + " whatever she likes.  As far as you’re concerned, everything in her wardrobe looks great on her.  You, of course, prefer her completely naked.\n\n");
	outputText("Kath wiggles against your body and says, “<i>When you’re around I prefer naked too.  What a funny coincidence.  Oh, and since you bring it up...</i>”");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = 0;
	katSexMenu();
}

private function talkClothesBlouse():void {
	if (flags[kFLAGS.KATHERINE_CLOTHES_WORN] == KBIT_CLOTHES_C_CLOTH)
		outputText("\n\nYou complement Kath on the blouse she’s wearing.");
	else {
		outputText("\n\nKath pulls the blouse from her wardrobe.  She puts on a little show of undressing and redressing in front of you and in no time she's wearing the familiar blouse and skirt.");
		flags[kFLAGS.KATHERINE_CLOTHES_WORN] = KBIT_CLOTHES_C_CLOTH;
	}
	outputText("  She looks a little sheepish and says, “<i>It's not as nice as what you gave me.  It's just the first outfit I saw in the market that looked half-decent on me.</i>”");
	var insist:Function = (submissiveness() > 1 ? talkClothesBlouseInsist : null);
	simpleChoices("Compliment", talkClothesBlouseCompliment, "Suggest", talkClothesBlouseSuggest, "Insist", insist, "", null, "", null);
}

private function talkClothesBlouseCompliment():void {
	outputText("\n\nYou close the distance and give her a hug, stroking her ears until you see her tail swishing from side to side under the skirt.  You tell her she ought to give her own tastes a little more credit, she looks like a nice, innocent girl wearing that blouse.");
	outputText("Kath giggles and says, “<i>I guess it's good camouflage then.</i>”  ");
	if (hasCock())
		outputText("The bulge pressing against your " + (player.isNaga() ? "tail" : "leg") + " suggests how much she appreciates your compliments.");
	else outputText("She grinds her pelvis against your " + (player.isNaga() ? "tail" : "leg") + ", her tail curling around your waist.  Clearly your kitten loves compliments.");
	katSexMenu();
}

private function talkClothesBlouseSuggest():void {
	outputText("\n\nYou close the distance and give her a hug, stroking her ears until you see her tail swishing from side to side under the skirt.  You tell her she ought to give her own tastes a little more credit, she looks like a nice, innocent girl wearing that blouse.\n\n");
	outputText("Kath giggles and says, “<i>I guess it's good camouflage then.</i>”  ");
	if (hasCock())
		outputText("The bulge pressing against your " + (player.isNaga() ? "tail" : "leg") + " suggests how much she appreciates your compliments.");
	else outputText("She grinds her pelvis against your " + (player.isNaga() ? "tail" : "leg") + ", her tail curling around your waist.  Clearly your kitten loves compliments.");
	outputText("\n\nYou continue to massage her ears and tell her that you'd like to see her wearing it a little more often.\n\n");
	outputText("She nuzzles against your neck and says, “<i>" + (playerMaster() ? "Yes [master], I'll wear whatever you like" : "I'll wear whatever you like [name]") + ".</i>”");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = KBIT_CLOTHES_C_CLOTH;
	katSexMenu();
}

private function talkClothesBlouseInsist():void {
	outputText("\n\nYou close the distance and give her a hug, stroking her ears until you see her tail swishing from side to side under the skirt.  You tell her she ought to give her own tastes a little more credit, she looks like a nice, innocent girl wearing that blouse.\n\n");
	outputText("Kath giggles and says, “<i>I guess it's good camouflage then.</i>”  ");
	if (hasCock())
		outputText("The bulge pressing against your " + (player.isNaga() ? "tail" : "leg") + " suggests how much she appreciates your compliments.");
	else outputText("She grinds her pelvis against your " + (player.isNaga() ? "tail" : "leg") + ", her tail curling around your waist.  Clearly your kitten loves compliments.");
	outputText("\n\nYou continue to massage her ears and tell her that you want her to wear the blouse all the time.  If you want her to put on something else you'll tell her.\n\n");
	outputText("She nuzzles against your neck and says, “<i>" + (playerMaster() ? "Yes [master], I'll wear whatever you like" : "I'll wear whatever you tell me to [name]") + ".</i>”");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = -KBIT_CLOTHES_C_CLOTH;
	katSexMenu();
}

private function talkClothesBodysuit():void {
	if (flags[kFLAGS.KATHERINE_CLOTHES_WORN] == KBIT_CLOTHES_BODYSUIT)
		outputText("\n\nYou complement Kath on the bodysuit she’s currently wearing.  She stands up and models it for you, getting your pulse racing.");
	else {
		outputText("\n\nYou ask Kath about the bodysuit you gave her.  Kath grins and motions for you to wait.  She pops open her wardrobe and begins to change.  Soon enough she’s standing before you, proudly wearing the sheer bodysuit.");
		flags[kFLAGS.KATHERINE_CLOTHES_WORN] = KBIT_CLOTHES_BODYSUIT;
	}
	var insist:Function = (submissiveness() > 1 ? talkClothesBodysuitInsist : null);
	simpleChoices("Compliment", talkClothesBodysuitCompliment, "Suggest", talkClothesBodysuitSuggest, "Insist", insist, "", null, "", null);
}

private function talkClothesBodysuitCompliment():void {
	outputText("\n\nYou wrap your arms around her and tell her the bodysuit looks amazing on her.  It’s always a good day when you find her wearing it.\n\n");
	outputText("Kath snuggles up next to you with a happy little purr.  The " + (hasCock() ? "bulge in the" : "heat emanating") + " crotch of the bodysuit suggests how much she appreciates your compliments.");
	katSexMenu();
}

private function talkClothesBodysuitSuggest():void {
	outputText("\n\nYou wrap your arms around her and tell her the bodysuit looks amazing on her.  It’s always a good day when you find her wearing it.\n\n");
	outputText("As you stroke her ear you say that she should wear it more often - it’s a shame to leave it hanging in her wardrobe when she could be parading around town with it.  The bodysuit was built to show off her tight ass and perky breasts.  The sight of her bending over to inspect some produce in the market will make people’s days.  For a lovely girl like her wearing a nearly transparent bodysuit is a public service.\n\n");
	outputText("She hugs you close and purrs.  “<i>" + (playerMaster() ? "Yes [master]" : "Alright [name]") + ", if that’s what you like then you’ll be seeing a lot more of my sexy ass stuffed into this tight little number.</i>”");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = KBIT_CLOTHES_BODYSUIT;
	katSexMenu();
}

private function talkClothesBodysuitInsist():void {
	outputText("\n\nYou wrap your arms around her and tell her the bodysuit looks amazing on her.  It’s always a good day when you find her wearing it.\n\n");
	outputText("You run a hand through her hair and add that you expect to see her wearing it every chance she gets.  Kath’s eyes go wide, but she says nothing.  You smile and tell her that naughty kitties like her want to wear bodysuits that hug every curve they’ve got.  Whenever she’s not on duty you want her proudly strutting her stuff wherever she goes.\n\n");
	outputText("Kath looks a little unsure and a little turned on.  The second emotion quickly wins out and she looks at you hungrily.");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = -KBIT_CLOTHES_BODYSUIT;
	katSexMenu();
}

private function talkClothesDress():void {
	if (flags[kFLAGS.KATHERINE_CLOTHES_WORN] == KBIT_CLOTHES_B_DRESS)
		outputText("\n\nYou complement Kath on the elegant ballroom dress she’s currently wearing.  She twirls around the room, dancing to music you cannot hear and showing off her flexibility.  Every once in a while she looks your way to make sure you approve.");
	else {
		outputText("\n\nYou ask Kath about the ballroom dress you gave her.  Kath grins and motions for you to wait.  She pops open her wardrobe and begins to change.  It takes a while, with all the buttons, but it’s worth it.  In such fine clothing Kath seems to glow.");
		flags[kFLAGS.KATHERINE_CLOTHES_WORN] = KBIT_CLOTHES_B_DRESS;
	}
	var insist:Function = (submissiveness() > 1 ? talkClothesDressInsist : null);
	simpleChoices("Compliment", talkClothesDressCompliment, "Suggest", talkClothesDressSuggest, "Insist", insist, "", null, "", null);
}

private function talkClothesDressCompliment():void {
	outputText("\n\nYou take her hand and ask if the lady would allow you this dance.  Kath looks embarrassed and mumbles that she’s no lady, but you can tell she loves it when you say things like that.  She pulls you into a hug and ");
	if (hasCock())
		outputText("the rigid protrusion" + cockMultiple(" under her dress tells", "s under her dress tell") + " you she’d be willing to try some dancing as long as it’s the horizontal kind.");
	else outputText("her nipples rub against you.  She's so turned on they're standing out like the tips of two little hot peppers - and you know they'd taste much sweeter.");
	katSexMenu();
}

private function talkClothesDressSuggest():void {
	outputText("\n\nYou wrap your arms around her and tell her the dress looks amazing on her.  She should wear it more often - it’s a shame to leave it sitting in the wardrobe when she could be parading around town with it.  A cat " + catGirl("girl", "morph") + " lady like her is exactly what the people of Tel’Adre need to see to remind them how beautiful and elegant cats can be.\n\n");
	outputText("She hugs you close and purrs.  You know she’s going to wear her long dress wherever she goes, adding a little touch of class to the city.");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = KBIT_CLOTHES_B_DRESS;
	katherineMenu();
}

private function talkClothesDressInsist():void {
	outputText("\n\nYou wrap your arms around her and tell her the dress looks amazing on her.  Kath sighs and you place your hand against her exposed back, telling that you expect to see her wearing it every chance she gets.  Kath grins and nods enthusiastically.  You know she enjoys wearing this dress as much as you enjoy seeing her in it.");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = -KBIT_CLOTHES_B_DRESS;
	katherineMenu();
}

private function talkClothesSSRobe():void {
	if (flags[kFLAGS.KATHERINE_CLOTHES_WORN] == KBIT_CLOTHES_SS_ROBE)
		outputText("\n\nYou tell Kath that the spider silk robe she’s wearing suits her - even if she can’t cast any kind of magic.  She pulls at the edges of the silk robe, straightening some creases and smoothing the fabric over her chest.");
	else {
		outputText("\n\nYou ask Kath about the spider silk robe you gave her.  Kath grins and motions for you to wait.  She pops open her wardrobe, turns her back to you and slips off her old outfit.  She puts on the robe, making sure you see only a hint of her breasts before she cinches the belt around her waist.");
		flags[kFLAGS.KATHERINE_CLOTHES_WORN] = KBIT_CLOTHES_SS_ROBE;
	}
	var insist:Function = (submissiveness() > 1 ? talkClothesSSRobeInsist : null);
	simpleChoices("Compliment", talkClothesSSRobeCompliment, "Suggest", talkClothesSSRobeSuggest, "Insist", insist, "", null, "", null);
}

private function talkClothesSSRobeCompliment():void {
	outputText("\n\nYou brush your hands over the fine silk and Katherine purrs appreciatively at your attention.  You slip a hand inside the robe and ask if she’s ever thought of ditching her underwear and walking the streets with nothing more than this thin silk between her and the world.\n\n");
	outputText("Kath gives you a kiss and says “<i>You’re such a bad influence on me " + playerText() + ".</i>”");
	katSexMenu();
}

private function talkClothesSSRobeSuggest():void {
	outputText("\n\nYou brush your hands over the fine silk and tell her the robe looks wonderful, like it was built to hug her body.  You give her a kiss and ask if she could wear it a little more often.  You do love seeing her in silk.\n\n");
	outputText("Kath gives you a hug and says, “<i>I’m always willing to do things that make you happy " + playerText() + ".</i>”");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = KBIT_CLOTHES_SS_ROBE;
	katherineMenu();
}

private function talkClothesSSRobeInsist():void {
	outputText("\n\nYou put your fingers under Kath’s chin so that she’s looking into your eyes.  You ask her “<i>What’s the best thing about robes?</i>”\n\n");
	outputText("While she tries to think of something to say you tug on the belt, undoing it and letting the front of the robe fall open.  “<i>Easy access,</i>” you say, answering your own question.  You let your hand roam around between her skin and the robe and Kath’s pupils start to dilate.  You tell her that you want her to wear this robe all the time so that whenever and wherever you find her it takes only one tug to expose her.\n\n");
	outputText("Kath shivers and you feel the heat rising from " + (hasCock() ? "the large bulge in " : "") + "her panties.  It seems your sex kitten may have an exhibitionist streak.");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = -KBIT_CLOTHES_SS_ROBE;
	katSexMenu();
}

private function talkClothesTubeTop():void {
	if (flags[kFLAGS.KATHERINE_CLOTHES_WORN] == KBIT_CLOTHES_TUBETOP)
		outputText("\n\nYou tell Kath that the tube top she’s wearing really shows off her figure.  A bare midriff suits her.  " + (pregSize() > 0 ? "Katherine puts a hand to her belly, acting a little self-conscious.  Then she shakes it off," : "She") + " takes a few poses for you and does a little twirl.");
	else {
		outputText("\n\nYou ask Kath about the tube top you got for her.  Kath grins and motions for you to wait.  She pops open her wardrobe, turns her back to you and slips off her old outfit.  She slips into the tube top itself and then " + clothesLowerChoice("pulls on the tight shorts that came with it.", "rests her hand on the large bulge in her panties.  Her hand reaches over the folded short shorts and she pulls on the skirt that matches her blouse.", "", "", "") + (pregSize() > 0 ? "  Looking at herself in the mirror she puts her hand on her exposed belly for a moment, lost in thought." : ""));
		flags[kFLAGS.KATHERINE_CLOTHES_WORN] = KBIT_CLOTHES_TUBETOP;
	}
	var insist:Function = (submissiveness() > 1 ? talkClothesTubeTopInsist : null);
	simpleChoices("Compliment", talkClothesTubeTopCompliment, "Suggest", talkClothesTubeTopSuggest, "Insist", insist, "", null, "", null);
}

private function talkClothesTubeTopCompliment():void {
	outputText("\n\nYou take up position behind her and just hold her" + (pregSize() > 0 ? ", lacing your fingers over her belly and kissing" : " and kiss") + " the nape of her neck.  Kath breaks the silence first: “<i>I think this outfit makes me look a little slutty, but I like looking a little slutty for you.</i>”");
	katSexMenu();
}

private function talkClothesTubeTopSuggest():void {
	outputText("\n\nYou take up position behind her" + (pregSize() > 0 ? " and just hold her, lacing your fingers over her belly and kissing" : ", just hold her and kiss") + " the nape of her neck.  You ask if she could wear this outfit a little more often, she looks so young and sensual wearing clothes that bare so much " + catGirl("skin", "fur") + ".\n\n");
	outputText("Kath just purrs and says, “<i>I’d love to.</i>”");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = KBIT_CLOTHES_TUBETOP;
	katherineMenu();
}

private function talkClothesTubeTopInsist():void {
	outputText("\n\nYou take up position behind her" + (pregSize() > 0 ? " and just hold her, lacing your fingers over her belly and kissing" : ", just hold her and kiss") + " the nape of her neck.  You tell her you expect to see her wearing this all the time.  It shows off her body and lets everyone know what a sex fiend she is" + (pregSize() > 0 ? ", particularly now with her swollen belly" : "") + ".\n\n");
	outputText("Kath grinds her ass against you and says, “<i>" + (playerMaster() ? "Yes [master]" : "Sure thing lover") + ".  But right now I’d like a good reason to take these clothes off again.</i>”");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = -KBIT_CLOTHES_TUBETOP;
	katSexMenu();
}

private function talkClothesNurseOutfit():void {
	if (flags[kFLAGS.KATHERINE_CLOTHES_WORN] == KBIT_CLOTHES_NURSECL)
		outputText("\n\nYou tell Kath that the sexy nurse’s outfit she’s wearing really shows off her figure.  She puts her hands on her hips, spins and takes a few steps away from you, truly strutting her stuff.");
	else {
		outputText("\n\nYou ask Kath about the sexy nurse’s outfit and she grins, motioning for you to wait.  She pops open her wardrobe, turns her back to you and slips off her old outfit.  In no time at all she’s got the nurse’s outfit on.  She stops just long enough to adjust the little white hat on her head, then looks over her shoulder and wiggles her bum at you.");
		flags[kFLAGS.KATHERINE_CLOTHES_WORN] = KBIT_CLOTHES_NURSECL;
	}
	outputText("\n\nYou ask how many eyes follow her swaying ass and swishing tail as she struts down the street.\n\n");
	outputText("“<i>An awful lot,</i>” she says with a grin.");
	var insist:Function = (submissiveness() > 1 ? talkClothesNurseOutfitInsist : null);
	simpleChoices("Compliment", talkClothesNurseOutfitCompliment, "Suggest", talkClothesNurseOutfitSuggest, "Insist", insist, "", null, "", null);
}

private function talkClothesNurseOutfitCompliment():void {
	outputText("\n\nYou tickle her belly button and tell her no one could wear that outfit better.\n\n");
	outputText("She giggles at the tickling and then hugs you tight.");
	if (player.hasVagina()) outputText("  “<i>I can think of at least one other person I’d love to see in a nurse’s outfit</i>” she replies, tracing a finger down your back.");
	katSexMenu();
}

private function talkClothesNurseOutfitSuggest():void {
	outputText("\n\nYou take up position behind her and whisper in her ear that you like the sound of that.\n\n");
	outputText("She purrs and asks in a sultry tone, “<i>You like it when I show off my body in the streets?</i>”\n\n");
	outputText("You squeeze her breasts and tell her that you love knowing that she’s doing just that.\n\n");
	outputText("“<i>Alright then " + playerText() + ",</i>” she says, putting her hands over yours, “<i>I guess the people of Tel’Adre are going to be seeing more of me.</i>”");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = KBIT_CLOTHES_NURSECL;
	katherineMenu();
}

private function talkClothesNurseOutfitInsist():void {
	outputText("\n\nYou take up position behind her and whisper in her ear that you like the sound of that.\n\n");
	outputText("She purrs and asks in a sultry tone, “<i>You like it when I show off my body in the streets?</i>”\n\n");
	outputText("You squeeze her breasts and tell her that from now on you expect it.  Why fight it?  She was built to wear this slutty outfit everywhere.  Even to church, if she ever goes.  Even to visit her parents.\n\n");
	outputText("That draws a sharp intake of breath and you reach under that skirt to feel her wetness firsthand.\n\n");
	outputText("“<i>Yes " + playerText() + ", I understand.  I’ll put my body on display for everyone to see - they won’t know it’s all for you, but I don’t care.  I want to look like a slut for you.</i>”\n\n");
	outputText("Running your finger up and down her slit you try to decide what else you want to do with this sex kitten.");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = -KBIT_CLOTHES_NURSECL;
	katSexMenu();
}

private function talkLovers():void {
	clearOutput();
    //More can be added later
	var loverSet:int			= playerLovers();
	var loverCount:int			= 0;
	var optionAmily:Function	= null;
	var optionCotton:Function	= null;
	var optionEdryn:Function	= null;
	var optionHelia:Function	= null;
	var optionUrta:Function		= null;
	var optionVala:Function		= null;
	if ((loverSet & KBIT_LOVER_AMILY) != 0) {
		optionAmily = talkLoversAmily;
		loverCount++;
	}
	if ((loverSet & KBIT_LOVER_COTTON) != 0) {
		optionCotton = talkLoversCotton;
		loverCount++;
	}
	if ((loverSet & KBIT_LOVER_EDRYN) != 0) {
		optionEdryn = talkLoversEdryn;
		loverCount++;
	}
	if ((loverSet & KBIT_LOVER_HELIA) != 0) {
		optionHelia = talkLoversHelia;
		loverCount++;
	}
	if ((loverSet & KBIT_LOVER_URTA) != 0) {
		optionUrta = talkLoversUrta;
		loverCount++;
	}
	if ((loverSet & KBIT_LOVER_VALA) != 0) {
		optionVala = talkLoversVala;
		loverCount++;
	}
	outputText("Perhaps you should talk to Kath about ");
	if (loverCount > 1)
		outputText("one of your other lovers.");
	else if ((loverSet & KBIT_LOVER_AMILY) != 0)
		outputText("Amily.");
	else if ((loverSet & KBIT_LOVER_COTTON) != 0)
		outputText("Cotton.");
	else if ((loverSet & KBIT_LOVER_EDRYN) != 0)
		outputText("Edryn.");
	else if ((loverSet & KBIT_LOVER_HELIA) != 0)
		outputText("Helia.");
	else if ((loverSet & KBIT_LOVER_URTA) != 0)
		outputText("Urta.");
	else if ((loverSet & KBIT_LOVER_VALA) != 0)
		outputText("Vala.");
	choices("Amily", optionAmily, "Cotton", optionCotton, "Edryn", optionEdryn, "", null, "", null, 
		"Helia", optionHelia, "Urta", optionUrta, "Vala", optionVala, "", null, "Back", katherineMenu);
}

private function playerLovers():int {
	//This function exists so that both talkLovers and talkToKatherine can use the same code to determine who else the player is fucking.
	var loverSet:int = 0;
	if (flags[kFLAGS.AMILY_FOLLOWER] == 1) loverSet |= KBIT_LOVER_AMILY; //Not > 0; probably don’t want to admit having corrupt Amily follower to Katherine
	if (flags[kFLAGS.COTTON_MET_FUCKED] >= 2) loverSet |= KBIT_LOVER_COTTON;
	if ((flags[kFLAGS.EDRYN_NEVER_SEE_AGAIN] == 0) && (player.statusEffectv1(StatusEffects.Edryn) > 3)) loverSet |= KBIT_LOVER_EDRYN;
	if ((flags[kFLAGS.HELIA_FOLLOWER_DISABLED] != 1) && kGAMECLASS.helScene.followerHel()) loverSet |= KBIT_LOVER_HELIA;
	if (kGAMECLASS.urta.urtaFuckbuddy()) loverSet |= KBIT_LOVER_URTA;
	if (flags[kFLAGS.VALA_TIMES_CONSENSUAL_SEX] > 0) loverSet |= KBIT_LOVER_VALA;
	return loverSet;
}

private function knownLovers():int {
	return (flags[kFLAGS.KATHERINE_AMILY_AFFECTION] > 0 ? 1 : 0)
		+ (flags[kFLAGS.KATHERINE_COTTON_AFFECTION] > 0 ? 1 : 0)
		+ (flags[kFLAGS.KATHERINE_EDRYN_AFFECTION] > 0 ? 1 : 0)
		+ (flags[kFLAGS.KATHERINE_HELIA_AFFECTION] > 0 ? 1 : 0)
		+ (flags[kFLAGS.KATHERINE_URTA_AFFECTION] > 0 ? 1 : 0)
		+ (flags[kFLAGS.KATHERINE_VALA_AFFECTION] > 0 ? 1 : 0);
}

private function talkLoversAmily():void {
	clearOutput();
	if (flags[kFLAGS.KATHERINE_AMILY_AFFECTION] == 0) {
		var numLovers:int = knownLovers();
		outputText("You decide to tell Katherine about Amily.  After you explain things Katherine ");
		if (numLovers > 5)
			outputText("just shakes her head.  “<i>Where do you find the energy?  Cat morphs aren't exactly known for monogamy, but you take the cake.</i>”  She gives you a kiss and holds you close, whispering, “<i>I don't mind if you want to catch 'em all.  Just make sure I get the chance to enjoy you too.</i>”");
		else if (numLovers > 2)
			outputText("laughs and says, “<i>Another lover?  You are one busy champion.  Don’t worry about it, I’m certainly not going to leave you.</i>”");
		else outputText("gives you a worried look and asks what this means for the two of you.  When you tell her you have no intention of leaving she jumps into your arms and squeezes most of the air out of your lungs.");
		outputText("\n\nYou spend several minutes answering Kath’s many questions about Amily.  She seems impressed with the story of how you met and is amazed at how many children you’ve had together.  Before you leave Kath mentions that she might like to meet this mouse girl one day.  Cat morphs and mouse morphs didn’t always get along before the demons came, but nowadays no one cares about the old problems anymore.  She says it might be the only good thing the demons are responsible for.");
		flags[kFLAGS.KATHERINE_AMILY_AFFECTION] = 1;
	}
	else {
		outputText("You bring Kath up to date about things that have been happening at your camp.  You talk some more about Amily and Kath once again mentions she’d like to meet Amily in person.  You get the feeling Kath wants to see how she measures up.  Getting the two of them together might cause sparks or they might rub each other the right way.");
	}
	katherineMenu();
}

private function talkLoversCotton():void {
	clearOutput();
	if (flags[kFLAGS.KATHERINE_COTTON_AFFECTION] == 0) {
		var numLovers:int = knownLovers();
		outputText("You decide to tell Katherine about Cotton.  After you explain things Katherine ");
		if (numLovers > 5)
			outputText("just shakes her head.  “<i>Where do you find the energy?  Cat morphs aren't exactly known for monogamy, but you take the cake.</i>”  She gives you a kiss and holds you close, whispering, “<i>I don't mind if you want to catch 'em all.  Just make sure I get the chance to enjoy you too.</i>”");
		else if (numLovers > 2)
			outputText("laughs and says, “<i>Another lover?  You are one busy champion.  Don’t worry about it, I’m certainly not going to leave you.</i>”");
		else outputText("gives you a worried look and asks what this means for the two of you.  When you tell her you have no intention of leaving she jumps into your arms and squeezes most of the air out of your lungs.");
		outputText("\n\nYou spend several minutes answering Kath’s many questions about Cotton.  She doesn't seem too surprised at how the two of you met.  Kath smirks and says, “<i>Horse morphs have a certain reputation around Tel'Adre and it doesn't sound like Cotton is bucking that trend.  But hey, everyone's happy, so who cares if some old-timers from before the demons get their noses out of joint.</i>”");
		if (flags[kFLAGS.COTTON_KID_COUNT] > 0) {
			outputText("\n\nThen you mention the child" + (flags[kFLAGS.COTTON_KID_COUNT] > 1 ? "ren you've" : " you") + " had with Cotton.  Kath's jaw drops.  “<i>Whoa, really?  From what I've heard all those girls who work at the gym take really good care of their bodies - and that includes taking herbs or using magic to make sure they never get knocked up.  Most of them don't even want to think about what a baby will do to their abs.</i>”\n\n");
			outputText("You smile and tell her Cotton <b>was</b> using herbs.  Kath grins and says “<i>Lots of power in that package, huh?  Can't say I'm too surpised.  I guess I'm lucky my parents paid to get me full-blown magical protection.  They didn't want to wind up with a dozen grandkids the minute I figured out how good it feels to have sex.</i>”");
		}
		flags[kFLAGS.KATHERINE_COTTON_AFFECTION] = 1;
	}
	else {
		outputText("You talk about your recent gym visits and Kath suggests that she might be willing to try out a little yoga.  You get the feeling Kath wants to see how she measures up to Cotton.  That could certainly make for a fun evening.");
	}
	katherineMenu();
}

private function talkLoversEdryn():void {
	clearOutput();
	if (flags[kFLAGS.KATHERINE_EDRYN_AFFECTION] == 0) {
		var numLovers:int = knownLovers();
		var edrynKids:int = flags[kFLAGS.EDRYN_NUMBER_OF_KIDS];
		outputText("You decide to tell Katherine about Edryn.  After you explain things Katherine ");
		if (numLovers > 5)
			outputText("just shakes her head.  “<i>Where do you find the energy?  Cat morphs aren't exactly known for monogamy, but you take the cake.</i>”  She gives you a kiss and holds you close, whispering, “<i>I don't mind if you want to catch 'em all.  Just make sure I get the chance to enjoy you too.</i>”");
		else if (numLovers > 2)
			outputText("laughs and says, “<i>Another lover?  You are one busy champion.  Don’t worry about it, I’m certainly not going to leave you.</i>”");
		else outputText("gives you a worried look and asks what this means for the two of you.  When you tell her you have no intention of leaving she jumps into your arms and squeezes most of the air out of your lungs.");
		outputText("\n\nYou spend several minutes answering Kath’s many questions about Edryn.  She’s met her once or twice but hadn’t heard of Edryn’s habit of moonlighting after work.  You explain that it’s less prostitution and more that Edryn just needs cock.  She just felt that since centaur mares were in short supply she might as well make some gems while sating herself.  All that’s in the past anyway, since Edryn enjoys your company so much that she doesn’t charge you any more.");
		if (edrynKids > 0) outputText("  You tell Katherine that in fact you’ve fathered " + (edrynKids > 1 ? edrynKids + " children" : "a child") + " with Edryn.  “<i>She’s got " + (edrynKids > 1 ? edrynKids + " kids" : "a kid") + "?</i>” Kath blurts.  “<i>Wow - I’d never have guessed.</i>”");
		outputText("\n\nKatherine seems pleased with your frankness about the whole thing.  She’s obviously enjoying the fact that she knows a little secret about one of the girls at work.");
		flags[kFLAGS.KATHERINE_EDRYN_AFFECTION] = 1;
	}
	else {
		outputText("You talk to Kath about her work, steering the conversation toward her coworkers.  Kath is happy to spill the beans and tells you how she’s been noticing things about Edryn since you mentioned her, like how some mornings she comes in to work looking very pleased with herself, a certain looseness in her step.  Kath grins and says, “<i>I bet I know who’s responsible for that.</i>”");
	}
	katherineMenu();
}

private function talkLoversHelia():void {
	clearOutput();
	if (flags[kFLAGS.KATHERINE_HELIA_AFFECTION] == 0) {
		var numLovers:int = knownLovers();
		outputText("You decide to tell Katherine about Helia.  After you explain things Katherine ");
		if (numLovers > 5)
			outputText("just shakes her head.  “<i>Where do you find the energy?  Cat morphs aren't exactly known for monogamy, but you take the cake.</i>”  She gives you a kiss and holds you close, whispering, “<i>I don't mind if you want to catch 'em all.  Just make sure I get the chance to enjoy you too.</i>”");
		else if (numLovers > 2)
			outputText("laughs and says, “<i>Another lover?  You are one busy champion.  Don’t worry about it, I’m certainly not going to leave you.</i>”");
		else outputText("gives you a worried look and asks what this means for the two of you.  When you tell her you have no intention of leaving she jumps into your arms and squeezes most of the air out of your lungs.");
		outputText("\n\nYou have to explain what salamanders are like to Katherine as she’s never met one in person.  You tell her how you and Helia met out on the plains and how she moved in with you.  You think you sense a little jealousy from Kath until you describe just how many partners Helia seems to have had and her taste for threesomes of all kinds.");
		if (flags[kFLAGS.HELSPAWN_AGE] > 0) {
			if (flags[kFLAGS.HELSPAWN_DADDY] == 0)
				outputText("  Kath is a bit surprised to hear you’ve had a little salamander baby with Helia but she takes it well.  In fact she tells you she’s interested in meeting both your daughter and her mother.");
			else outputText("  Kath thinks the fact you’ve been helping Helia raise her little girl is cute and she shows an interest in meeting them both.");
		}
		flags[kFLAGS.KATHERINE_HELIA_AFFECTION] = 1;
	}
	else {
		outputText("You bring Kath up to date about things that have been happening at your camp.  You talk some more about Helia and Kath once again mentions she’d like to meet your salamander lover" + (flags[kFLAGS.HELSPAWN_AGE] > 0 ? " and her daughter" : "") + ".  It might be your imagination but you think Katherine wants to prove something to you.");
	}
	katherineMenu();
}

private function talkLoversUrta():void {
	clearOutput();
	if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] == 0) { //She doesn’t know about you and Urta
		var urtaKids:int = kGAMECLASS.urtaPregs.urtaKids();
		outputText("You decide to tell Katherine about Urta.  It’s amazing it hasn’t come up since they work together.  After you explain things Katherine " + (knownLovers() > 2 ? "laughs and says, “<i>You took Urta as a lover too?  You are one busy champion.  Don’t worry about it, I’m certainly not going to leave you.</i>”" : "gives you a worried look and asks what this means for the two of you.  When you tell her you have no intention of leaving she jumps into your arms and squeezes most of the air out of your lungs.") + "\n\n");
		outputText("You tell Kath the story of how Urta met you coming into Tel’Adre that first day and how later on the two of you ‘met’ in the alley behind this bar.  Once she’s heard the story Kath says, “<i>I know how she felt.  It really hurts when you think no one wants you.</i>”");
		if (urtaKids > 0)
			outputText("\n\nKath just about chokes when you tell her you and Urta " + (urtaKids == 1 ? "have a kid" : "have had " + urtaKids + " children together") + ".  “<i>You’re the mystery dad?  Everybody knows Urta " + (urtaKids == 1 ? "has a kid" : "has kids") + " but I never knew you were the " + player.genderText("father.", "mother.", "father?  Or mother?  Other parent, anyway.", "fathe... um... how did that work exactly?") + "</i>”");
		flags[kFLAGS.KATHERINE_URTA_AFFECTION] = 1;
	}
	else if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] == 1) //She knows about you and Urta
		outputText("You bring up Urta and Kath smiles.  “<i>Yeah, Urta and I have been talking about you.  It’s weird, I always thought I’d get really angry and go after any girl who’s been fucking my " + player.genderText("guy", "girl", "girl", "lover") + " but it just didn’t happen.  I actually feel just fine about you and her.</i>”");
	else if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] <= 10) //They’ve had some sex in training/while drunk
		outputText("You bring up Urta and Kath smiles.  “<i>I still don’t know if I should be sleeping with her or anything, but those times the three of us have got together, well they’ve been pretty damn good.  I’m not asking for a repeat or anything, but I know what you see in her and I don’t blame either of you.</i>”\n\n");
	else if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] <= 31) { //Fuckbuddies - they’ve had sex sober
		outputText("You bring up Urta and Kath sighs and gives you a big grin.  She truly looks like the cat that ate the canary, or in this case ate out the fox.  “<i>It’s your fault, you know.  I wasn’t aiming to get into my superior’s pants, but you just wouldn’t quit.  Now we share those looks in the hall and I’m always wondering if she’s just going to lead me somewhere if we’re both on break at the same time.  She hasn’t - but I’m always expecting it.  Maybe it’s just me and I need another good fucking.</i>”\n\n");
		outputText("She stretches before continuing, deliberately giving you a good view of her rack.  “<i>I have to say - I really enjoy our little get togethers.  The three of us can hit some notes that you can’t manage with just two.</i>”\n\n");
		outputText("You could tell Kath not to have sex with Urta except when you’re around, tell her it’s all right for them to have sex whenever they want or encourage them to fuck each other’s brains out.");
		simpleChoices("Don't Fuck", talkLoversUrtaDont, "Whenever", talkLoversUrtaWhenever, "Encourage", talkLoversUrtaEncourage, "", null, "", null);
		return;
	}
	else { //Kath has decided she loves Urta too
		outputText("When you mention Urta Kath gets up and gives you a hug.  “<i>I was a girl who never thought anyone was going to love her cause of a big doggie dick.  Now I’ve got you and you got me together with Urta too.  I’m so happy, everyday I get a workout - who needs a gym?  And I’ve always got someone I can go home with, someone I can talk to, someone I can just hug and hold on to.  Thank you so much " + playerText() + ".</i>”");
	}
	katherineMenu();
}

private function talkLoversUrtaDont():void {
	outputText("\n\nYou scratch Kath behind the ears and tell her that while you’re happy for her you’d really prefer if she waited for you to be around before banging Urta.  You feel a little left out.\n\n");
	outputText("Kath gives you a hug and tells you, “<i>I’ll be good, I promise.  But we do see each other all the time, so I hope you’re planning a lot of threesomes to release all our pent up energy.</i>”");
	flags[kFLAGS.KATHERINE_URTA_DATE] = KDATE_LITTLE;
	katherineMenu();
}

private function talkLoversUrtaWhenever():void {
	outputText("\n\nYou stroke Kath’s tail and tell her that you don’t mind if your favorite herms need to blow off a little steam together.  As long as they don’t wear each other out that is.\n\n");
	outputText("Kath giggles and says, “<i>That’s good - oh and you don’t have anything to worry about " + playerText() + ", we’re both so horny that we’re almost always up for some fun.</i>”");
	flags[kFLAGS.KATHERINE_URTA_DATE] = KDATE_WHENEVER;
	katherineMenu();
}

private function talkLoversUrtaEncourage():void {
	outputText("\n\nYou start rubbing the inside of Kath’s thighs.  Once she starts to moan and you start to feel some heat radiating from her crotch you tell her that you think it’s really hot that your lovers are ‘getting along’ so well.\n\n");
	outputText("“<i>You mean you want us to uh, spend more time together?</i>”\n\n");
	outputText("You let your fingers move a little closer to Kath’s ");
	if (hasCock()) outputText("cock" + cockMultiple("", "s") + " and ");
	outputText("pussy and then say that yes, you would like that.  You know that you aren’t always in town so whenever either of them needs to scratch an itch they should really get together.\n\n");
	outputText("Kath moans and her tail bats back and forth.\n\n");
	outputText("“<i>I want you to fuck so much you forget how to masturbate,</i>” you tell her.\n\n");
	outputText("“<i>Oh yeah!  I think we can manage that,</i>” she replies in a dreamy tone.");
	flags[kFLAGS.KATHERINE_URTA_DATE] = KDATE_LOTS;
	katherineMenu();
}

private function talkLoversVala():void {
	clearOutput();
	if (flags[kFLAGS.KATHERINE_VALA_AFFECTION] == 0) {
		outputText("You tell Katherine the story of how you saved Vala from the imps.  You leave out a lot of the details but Kath still shivers.  When you finish she says, “<i>Wow.  You really are a champion, saving girls left and right.  Strange that she ended up in Tel’Adre as a waitress, isn’t it?  I would have expected her to end up somewhere in the forests.</i>”\n\nKath ");
		if (isAt(KLOC_KATHS_APT))
			outputText("lies back on her bed and stares off into space for a while");
		else
			outputText("takes another sip of her drink and looks to see if Vala’s around somewhere" + (isValaAtBar() ? ".  Vala catches her looking and comes over to see if Kath needs another drink.  Kath, embarrassed at getting caught, orders another one" : "") );
		outputText(".\n\nAfter a long silence Kath says, “<i>So she’s new to town, she’s dealing with all sorts of issues and she probably doesn’t know many people here.  It’s a good thing no one took advantage of her.</i>”\n\n");
		if (flags[kFLAGS.TIMES_FUCKED_VALA_IN_DUNGEON] > 0) outputText("You decide it would be best not to mention " + (flags[kFLAGS.TIMES_FUCKED_VALA_IN_DUNGEON] == 1 ? "that time" : "those times") + " you took advantage of Vala, back when she was mindfucked and tied up.\n\n");
		if (isAt(KLOC_KATHS_APT))
			outputText("She puts her head in your lap and says");
		else
			outputText("She takes another sip of her drink and squeezes your hand, saying");
		outputText(", “<i>I wonder; maybe I should keep an eye on her.  What do you think " + playerText() + "?</i>”");
		flags[kFLAGS.KATHERINE_VALA_AFFECTION] = 1;
	}
	else {
		outputText("You mention Vala and Kath whispers that she’s kept a closer eye on the faerie waitress since you last mentioned her.  She thinks Vala is all right, overall, but there’s a little hint of sadness Kath sees every once in a while.  She suspects Vala needs a friend, that or some more visits from her champion.");
		if (flags[kFLAGS.KATHERINE_VALA_AFFECTION] > 10) {
			outputText("\n\nYou could tell Kath not to have sex with Vala except when you’re around, tell her it’s all right for them to have sex whenever they want or encourage them to fuck each other’s brains out.");
			simpleChoices("Don't Fuck", talkLoversValaDont, "Whenever", talkLoversValaWhenever, "Encourage", talkLoversValaEncourage, "", null, "", null);
			return;
		}
	}
	katherineMenu();
}

private function talkLoversValaDont():void {
	outputText("\n\nYou give Kath a kiss and tell her that while you’re happy that she and Vala get along so well you’d really prefer if she waited for you to be around before doing anything with the faerie waitress.  You feel a little left out.\n\n");
	outputText("Kath gives you a hug and tells you, “<i>I’ll be good, I promise.  But we do see each other almost every day at the bar, so I hope you’re planning a lot of threesomes to release all our pent up energy.</i>”");
	flags[kFLAGS.KATHERINE_VALA_DATE] = KDATE_LITTLE;
	katherineMenu();
}

private function talkLoversValaWhenever():void {
	outputText("\n\nYou stroke Kath’s tail and tell her that you don’t mind if she wants to blow off a little steam with Vala.  They’re both horny and they both need it.  As long as they don’t wear each other out that is.  You want to be sure they’ve got enough energy for threesomes with you.\n\n");
	outputText("Kath giggles and says, “<i>I’m glad you feel that way " + playerText() + ".  Some people get really possessive, but you know both of us are hooked on you.</i>”");
	flags[kFLAGS.KATHERINE_VALA_DATE] = KDATE_WHENEVER;
	katherineMenu();
}

private function talkLoversValaEncourage():void {
	outputText("\n\nYou start playing with Kath’s tail.  Once she starts to moan and grind her thighs together you tell her that you think it’s really nice that she wants to take care of Vala.\n\n");
	outputText("“<i>You mean you want us to uh, spend more time together?</i>”\n\n");
	outputText("You tell her the two of them need to be there, each for the other.  It's so much healthier for them to release all that tension that builds up.\n\n");
	outputText("Kath moans and you feel her tail twitching in your grasp.  You know she’ll follow your instructions - deep down it’s what she wants.");
	flags[kFLAGS.KATHERINE_VALA_DATE] = KDATE_LOTS;
	katherineMenu();
}

private function talkWetBitch():void {
	clearOutput();
	outputText("You ask Katherine why she hangs out at the Wet Bitch after work.\n\n");
	outputText("She smiles and replies that they make a mean plate of fries.  Then more seriously she says, “<i>There are a few other bars in Tel’Adre, but since Urta " + (isAt(KLOC_KATHS_APT) ? "goes there it's" : "comes here this is") + " sort of the unofficial watch bar.  For average people it means starting fights or robbing drunks is a bad idea but for Watch officers it means " + (isAt(KLOC_KATHS_APT) ? "it's" : "this is") + " a good place for gossip and stories or for just hanging out after work.</i>”\n\n");
	outputText((isAt(KLOC_KATHS_APT) ? "She scoots closer to you and says" : "She takes a sip from her mug and adds") + ", “<i>when I joined up I thought I would just head home and sleep after shifts but sometimes it helps, talking to people who have the same job as you.  Besides, it turns out it’s hard to get drinks at home in Tel’Adre.  The city worries so much about demonic liquors that only a few merchants can sell the stuff legally and they charge nearly as much as the bars.</i>”");
	katherineMenu();
}

private function talkCatGirl():void {
	clearOutput();
	if (furry) {
		outputText("You ask Kath how she feels now that she's back to being a cat morph.\n\n");
		outputText("“<i>I guess it really opened my eyes about transformative potions and items,</i>” she says.  “<i>My only other major transformation wasn't exactly a positive one.  Now I can understand people who chug potion after potion until they don't have the same genitals, skin or even body shape.</i>”\n\n");
		outputText("You ask her if that means she'd be up for more transformative fun.\n\n");
		outputText("“<i>I'm not saying I'm willing to change into a lizard morph or whatever, but as far as losing my fur?  Have to say I liked it.  First time in my life I've felt cold standing in the shade.  Being a full cat morph means fewer people look at me funny on the street, so there's that, but especially out here in the desert there are advantages to having less fur.  The only real downside is how everyone can tell when I'm embarrassed.</i>”");
		outputText("Is fewer people looking her way really an advantage?\n\n");
		outputText((isAt(KLOC_KATHS_APT) ? "Kath shifts her bum on the bed, her tail undulating slowly." : "Kath takes a long sip from her mug before giving you a guilty grin.") + "  “<i>I do kinda like it when strangers check me out,</i>” she admits, and you suspect under that fur she's blushing.  You give her thigh a little rub and tell her it's all right to show off.");
	}
	else {
		outputText("You ask Kath how’s she finding things as a cat girl.\n\n");
		outputText("She rubs her hands against her cheeks and grins at you.  “<i>It’s so different than I expected.  I really wasn’t sure I wanted this at first, but I’m glad you convinced me.  I mean there wasn’t anything wrong with being a cat-morph, but I like some of the advantages.</i>”\n\n");
		outputText("She takes a moment to " + (isAt(KLOC_KATHS_APT) ? "scoot backward on the bed and cross her legs" : "rearrange herself in her seat and take a sip of her drink") + " before continuing.  “<i>I’m not shedding anymore.  It sounds like nothing, but you try keeping an apartment clean when every day there are little black hairs all through your blankets and clothes.  Oh and clothes!  They feel so different now.  I finally see why so many hairless races value silk; it’s so smooth against my skin.  But the big thing is that my black fur always soaked up the sun.  That’s fine when you just want to relax but when you’re patrolling the streets it’s murder.</i>”\n\n");
		outputText("She gets a guilty look and adds, “<i>I like the attention too.  There are lots of cat morphs in this city but I’ve only seen a couple of cat girls, and both of them are like you, visitors from another world.  Anyway, it makes me feel special... and I kind of like knowing people are looking my way - not cause I might take their wallet but because they’re interested in me.  They’re wondering what I am, how I ended up looking like this, maybe what I’m like in bed.</i>”");
	}
	katherineMenu();
}

private function talkMaster():void {
	clearOutput();
	if ((flags[kFLAGS.KATHERINE_SUB_FLAGS] & KBIT_SUB_CALL_MASTER) > 0) {
		outputText("You tell Kath that while you appereciate her submissiveness and her loyalty you don't want her to call you [master] anymore.\n\n");
		outputText("She looks a little confused, so you explain that it might send the wrong message.\n\n");
		outputText("Katherine gives you a hug and says, “<i>Okay " + player.short + ", I won't call you [master] anymore... but I'm still up for just about anything.</i>” \n\n");
		outputText("You suck her tongue into your mouth and rub her ears appreciatively.  Looks like she'll still do exactly what you want - perfect.\n\n");
		flags[kFLAGS.KATHERINE_SUB_FLAGS] &= ~KBIT_SUB_CALL_MASTER;
	}
	else {
		outputText("You surprise Kath by pulling her into a kiss.  She goes limp in your arms and lets you do as you like.\n\n");
		outputText("As you stroke her tail you ask her what she wants.  She looks unsure, so you help he along and suggest that this is what she wants - she wants to curl up in your arms and give in to your desires, just like the submissive kitty she is.\n\n");
		outputText("Kath's eyes dilate and she hugs you tight.  In a voice so quiet only you can hear she says, “<i>Yes, my [master].</i>” \n\n");
		outputText("You reward her behavior with a few ear scratches and Kath purrs deeply.\n\n");
		flags[kFLAGS.KATHERINE_SUB_FLAGS] |= KBIT_SUB_CALL_MASTER;
	}
	katherineMenu();
}

private function talkMilk():void {
	clearOutput();
	outputText("You ask Kath about her breasts; does she enjoy making milk the way nature intended?\n\n");
	if (breasts.lactationLevel <= BreastStore.LACTATION_MODERATE) {
		outputText("“<i>I suppose I do,</i>” she says, “<i>I certainly enjoy it when I get some help unburdening them.  Why do you ask?</i>”\n\n");
	}
	else if (breasts.lactationLevel <= BreastStore.LACTATION_HEAVY) {
		outputText("“<i>I suppose, but I fill up so fast now.  It feels like I've always got a pair of lips wrapped around my nipples... not that that's a bad thing.</i>”\n\n");
	}
	else {
		outputText("“<i>I don't think anyone would say my breasts are working 'as nature intended'.  You've fed me so much lactaid they've turned into cream factories.  I spend a good part of every day with milk sloshing around inside these puppies, looking for some way to relieve the pressure.</i>”\n");
	}
	talkMilkMenu();
}

private function talkMilkMenu():void {
	outputText("\n\nYou would say that Kath's brests produce ");
	switch (breasts.lactationLevel) {
		case BreastStore.LACTATION_LIGHT:		outputText("only a small amount of cream.");
												break;
		case BreastStore.LACTATION_MODERATE:	outputText("about as much cream as a breastfeeding cat morph would.");
												break;
		case BreastStore.LACTATION_STRONG:		outputText("a large amount of cream, more than most breastfeeding women.");
												break;
		case BreastStore.LACTATION_HEAVY:		outputText("vast amounts of cream.  Only with magical aid did her mammaries begin churning out so much.");
												break;
		default:								outputText("an unnatural amount cream.  Her mammaries have been infused with so much lactaid that she can outdo some cow-morphs.");
	}
	if (breasts.milkIsOverflowing()) {
		outputText("  They're full to the brim and Kath must be desperate to feel someone relieve the pressure.");
	}
	else if (breasts.milkIsFull()) {
		outputText("  They're quite full at the moment, you're sure Kath would enjoy it if you emptied them.");
	}
	var canShareWithUrta:Boolean   = flags[kFLAGS.KATHERINE_URTA_AFFECTION] > 10;
	var canShareWithVala:Boolean   = flags[kFLAGS.KATHERINE_VALA_AFFECTION] > 10;
	var sharingWithFriends:Boolean = milkOption(KBIT_MILK_SHARE_WITH_FRIENDS);
	if (sharingWithFriends) {
		outputText("\n\n<b>Katherine shares her milk freely with her friends and acquaintances, as you instructed.</b>");
	}
	else {
		var sharingArray:Array = ["you"];
		if (milkOption(KBIT_MILK_SHARE_WITH_OLD_GANG))
			sharingArray.push("her old gang"); //Old gang includes Helena
		else if (milkOption(KBIT_MILK_SHARE_WITH_HELENA)) sharingArray.push("Helena");
		if (canShareWithUrta && milkOption(KBIT_MILK_SHARE_WITH_URTA)) sharingArray.push("Urta");
		if (canShareWithVala && milkOption(KBIT_MILK_SHARE_WITH_VALA)) sharingArray.push("Vala");
		outputText("\n\n<b>Right now Katherine only shares her milk with " + formatStringArray(sharingArray) + ".</b>");
	}
	menu();
	if (!sharingWithFriends && !milkOption(KBIT_MILK_SHARE_WITH_OLD_GANG)) addButton(0, "Helena", talkMilkShareWithHelena);
	if (!sharingWithFriends && canShareWithUrta) addButton(1, "Urta", talkMilkShareWithUrta);
	if (!sharingWithFriends && canShareWithVala) addButton(2, "Vala", talkMilkShareWithVala);
	addButton(4, "Limit", talkMilkLimitation);
	if (!sharingWithFriends) addButton(5, "Old Gang", talkMilkShareWithOldGang);
	if (submissiveness() >= 2) addButton(6, "Friends", talkMilkShareWithFriends);
	addButton(9, "Back", katherineMenu);
}

private function talkMilkShareWithHelena():void {
	clearOutput();
	if (milkOption(KBIT_MILK_SHARE_WITH_HELENA)) {
		outputText("You ask Kath if she could stop sharing her milky bounty with Helena.\n\n");
		outputText("“<i>I can, but... it really feels nice to help her.  Do I have to stop?</i>”");
		menu();
		addButton(0, "Yes", talkMilkShareWithHelenaAnswer, true);
		addButton(1, "Don't Stop", talkMilkShareWithHelenaAnswer, false);
	}
	else {
		outputText("You suggest to Kath that you can think of someone who could use an occasional extra meal.  How about that thin girl, Helena, from her old street gang?\n\n");
		outputText("Kath thinks about it and says, “<i>I don't suppose I'd have any trouble tracking her down.  And there's no way she'd turn down fresh cat milk.  If you don't mind then I'll gladly share my cream with Helena.</i>”");
		milkOptionSet(KBIT_MILK_SHARE_WITH_HELENA);
		talkMilkMenu();
	}
}

private function talkMilkShareWithHelenaAnswer(reallyStop:Boolean):void {
	if (reallyStop) {
		outputText("\n\nKath looks relieved.  “<i>Thank" + (playerMaster() ? " you [master]" : "s " + player.short) + ", you're the best.</i>”");
		milkOptionClear(KBIT_MILK_SHARE_WITH_HELENA);
	}
	else {
		outputText("\n\nKath nods and says, “<i>Okay, I'll stop.  I do feel sorry for Helena.</i>”");
	}
	talkMilkMenu();
}

private function talkMilkShareWithUrta():void {
	clearOutput();
	if (milkOption(KBIT_MILK_SHARE_WITH_URTA)) {
		outputText("You ask Kath to stop sharing her milk with Urta.  You want more for yourself.\n\n");
		outputText("“<i>Okay, I'll do it.  Just please be around, I'll need your help even more now.</i>”");
		milkOptionClear(KBIT_MILK_SHARE_WITH_URTA);
	}
	else {
		outputText("You tell Kath that if she's looking for some more help draining her mammaries she could always ask Urta to help.\n\n");
		outputText("Kath grins and says, “<i>Sounds like a plan!</i>”");
		milkOptionSet(KBIT_MILK_SHARE_WITH_URTA);
	}
	talkMilkMenu();
}

private function talkMilkShareWithVala():void {
	clearOutput();
	if (milkOption(KBIT_MILK_SHARE_WITH_VALA)) {
		outputText("You ask Kath to stop sharing her milk with Vala.  You want more for yourself.\n\n");
		outputText("“<i>Okay, I'll do it.  Just please be around, I'll need your help even more now.</i>”");
		milkOptionClear(KBIT_MILK_SHARE_WITH_VALA);
	}
	else {
		outputText("You tell Kath that if she's looking for some more help draining her mammaries there's always a certain faerie at the bar who could help her out.\n\n");
		outputText("Kath grins and says, “<i>I don't know if cream is really something faeries go for, but if Vala's game I'll let her suckle to her heart's content.</i>”");
		milkOptionSet(KBIT_MILK_SHARE_WITH_VALA);
	}
	talkMilkMenu();
}

private function talkMilkShareWithOldGang():void {
	clearOutput();
	if (milkOption(KBIT_MILK_SHARE_WITH_OLD_GANG)) {
		outputText("You tell Kath it's time she stopped feeding her old street gang.  You'd like more of her cream for yourself.\n\n");
		outputText("She lets out a long sigh and says, “<i>I know it's helped them, but I'm kinda glad.  Those milking sessions - they can be a real ride.  There's regular suckling and then there's suckling with a half dozen cat-morphs waiting their turn at your nipples.</i>”");
		milkOptionClear(KBIT_MILK_SHARE_WITH_OLD_GANG);
		talkMilkMenu();
	}
	else {
		outputText("You suggest Katherine should spread the wealth.  There's a whole gang out there who waylay travellers for their milk.\n\n");
		outputText("“<i>You want me to go and see the Vagrant Cats and feed them?  Aren't you afraid something might happen to me?</i>”\n\n");
		outputText("You point out that first, she's a trained Watch officer.  Second, when she was in the gang what would have happened to someone who drove off a willing source of kitty cream by being a jerk?  Oh, and if that's still not enough then why not bring a friend from the Watch?\n\n");
		outputText("Kath nods to herself and says, “<i>Okay, I suppose it's really a kind of crime prevention.  And it'll be fun seeing some of the old gang.  Maybe I can convince them not all Watch officers are assholes.  One thing though - if I give them as much cream as they want I'm sure my breasts are going to start producing more and more.  Do you want me to limit myself?  Keep my mammaries from producing enough cream for a few dozen babies?</i>”");
		milkOptionSet(KBIT_MILK_SHARE_WITH_OLD_GANG);
		talkMilkLimitation();
	}
}

private function talkMilkShareWithFriends():void {
	clearOutput();
	if (milkOption(KBIT_MILK_SHARE_WITH_FRIENDS)) {
		outputText("You tell Kath it's time she stopped sharing with all her friends.  You'd like a little more cream for yourself.\n\n");
		outputText("“<i>Okay, I'll stop right away.  I enjoyed it more than I thought I would, but it was always a little weird.  Just tell me if you want me to start sharing again.</i>”\n\n");
		outputText("Was that your imagination or was there a hint of eagerness in her voice?");
		milkOptionClear(KBIT_MILK_SHARE_WITH_FRIENDS);
		talkMilkMenu();
	}
	else {
		outputText("You tell Kath that you think her sweet, sweet milk is a lovely gift from the goddess.  The kind of gift that she should share with all her friends.  There have to be Watch officers and bar patrons who've looked longingly at her rack and there's a whole street gang out there she ought to share with too.\n\n");
		outputText("Kath puts a hand on her chest and asks, “<i>You want me to share with all my friends?  Wow... that's going to be a bit weird.</i>”\n\n");
		outputText("You laugh and tell her she'll enjoy it, you just know she will.  Besides, it doesn't pay to keep all that cream bottled up.  It's much better for her if she has it drawn out regularly.\n\n");
		outputText("Kath looks a little conflicted, but finally she says, “<i>Yes, yes " + playerText() + ", if that's what you want.  It'll be strange asking people if they want my milk, I mean that's not normal.</i>”\n\n");
		outputText("You say that you know she'll get the hang of it.  Just offer to the people she's sure want some; soon enough she'll be getting requests from her other friends who've secretly wanted a taste for a while.\n\n");
		outputText("Kath stays silent for a moment, thinking.  You're pretty sure she's getting into the idea; her nipples have hardened considerably.  At last she asks, “<i>Okay, but if I let my friends have as much as they like I'm sure my breasts are going to start producing more and more.  Do you want me to limit myself?  Keep my mammaries from producing enough cream for a few dozen babies?</i>”");
		milkOptionSet(KBIT_MILK_SHARE_WITH_FRIENDS);
		talkMilkLimitation();
	}
}

private function talkMilkLimitation():void {
	var doneHighLactation:Boolean = doneSubmissive(KBIT_SUB_HIGH_LACTATION);
	outputText("\n\n<b>At the moment Kath's been told ");
	switch (breasts.preventLactationIncrease) {
		case BreastStore.LACTATION_LIGHT:		outputText("to keep her breasts in check.  She won't allow more than light");
												break;
		case BreastStore.LACTATION_STRONG:		outputText("to keep her breasts in check.  She won't allow more than strong");
												break;
		case BreastStore.LACTATION_HEAVY:		outputText("to keep her breasts in check.  She won't allow more than heavy");
												break;
		case BreastStore.LACTATION_MODERATE:	if (doneHighLactation) {
													outputText("to keep her breasts in check.  She won't allow more than moderate");
													break;
												}
		default:
												outputText("not to keep her breasts in check.  There's no limit on her");
	}
	outputText(" lactation.</b>\n\nIn the future what should she limit herself to?");
	menu();
	if (breasts.preventLactationIncrease != BreastStore.LACTATION_LIGHT) addButton(0, "Light", talkMilkLimitationChange, BreastStore.LACTATION_LIGHT);
	if (doneHighLactation && breasts.preventLactationIncrease != BreastStore.LACTATION_MODERATE) addButton(1, "Moderate", talkMilkLimitationChange, BreastStore.LACTATION_MODERATE);
	if (doneHighLactation && breasts.preventLactationIncrease != BreastStore.LACTATION_STRONG) addButton(2, "Strong", talkMilkLimitationChange, BreastStore.LACTATION_STRONG);
	if (doneHighLactation && breasts.preventLactationIncrease != BreastStore.LACTATION_HEAVY) addButton(3, "Heavy", talkMilkLimitationChange, BreastStore.LACTATION_HEAVY);
	if (breasts.preventLactationIncrease != 0) addButton(4, "Unlimited", talkMilkLimitationChange, 0);
	addButton(9, "No Change", talkMilkMenu);
}

private function talkMilkLimitationChange(newLimit:int):void {
	clearOutput();
	if (newLimit == 0 && !doneSubmissive(KBIT_SUB_HIGH_LACTATION)) {
		breasts.preventLactationIncrease = BreastStore.LACTATION_MODERATE; //Kath can't go beyond moderate without more lactaid
	}
	else breasts.preventLactationIncrease = newLimit;
	switch (newLimit) {
		case BreastStore.LACTATION_LIGHT:		outputText("You tell Kath that from now on she's to keep her breasts from producing more than a little milk.");
												break;
		case BreastStore.LACTATION_MODERATE:	outputText("You tell Kath that from now on she's to keep her breasts from producing more than a moderate amount of milk.");
												break;
		case BreastStore.LACTATION_STRONG:		outputText("You tell Kath that from now on she's to keep her breasts from producing more than a large amount of milk.");
												break;
		case BreastStore.LACTATION_HEAVY:		outputText("You tell Kath that from now on she's to keep her breasts from producing more than a hefty amount of milk.");
												break;
		default:
												outputText("You tell Kath that from now on she's not to keep her breasts in check.  The sky's the limit.\n\n");
												outputText("Kath shakes her head and smiles, “<i>" + (playerMaster() ? "Yes [master], I guess you can't get enough?" : "Can't get enough?  Alright " + player.short + ",") + "I'll just let them make as much as they like.  But don't blame me if I get so full I try to force feed you.</i>”\n\n");
												talkMilkMenu();
												return;
	}
	outputText("\n\nKath smiles and says, “<i>" + (playerMaster() ? "Yes [master]" : "Alright " + player.short) + ", I'll do that.");
	if (breasts.lactationLevel > breasts.preventLactationIncrease) {
		outputText("  But since I'm making more cream than that right now it might take a while for my breasts to wind down to that level.");
	}
	outputText("</i>”");
	talkMilkMenu();
}

private function katherineDate():void {
	clearOutput(); //Urta's Place and Camp are not available in this expansion
	outputText("You decide that it might be an idea to lead Katherine somewhere.  Who knows what kind of fun you could get up to?");
	if (isAt(KLOC_KATHS_APT))
		simpleChoices("The Bar", dateGotoBar, "Urta's Place", null, "Bath", dateKathBath, "Camp", null, "Back", katherineMenu);
	else
		simpleChoices("Kath's Place", dateGotoKaths, "Urta's Place", null, "Bath", dateKathBath, "Camp", null, "Back", katherineMenu);
}

private function dateGotoKaths():void {
	if (isAt(KLOC_URTAS_APT)) {
		outputText("\n\nYou offer to walk her home.  Kath smiles at you, but before she steps out the door Urta grabs her from behind, giving the cat " + catGirl("girl", "morph") + " a big hug.  Then Urta steps out and gives you a hug too.\n\n");
		outputText("As she goes back inside Urta says, “<i>You take care of each other - and don't do anything I wouldn't do.</i>”");
	}
	else if (isAt(KLOC_URTAS_HOME)) {
		outputText("\n\nYou have to wait while Kath cleans herself up, but she tries to be quick about it.  You sit on the edge of the bed and rub the back of Urta's neck.  Urta groans and lies down flat in the puddle of cum, saying, “<i>Thanks " + player.short + ", I'll be fine.  I'm really comfy.</i>”\n\n");
		outputText("As Kath tracks down the last piece of her clothing you hear gentle snoring from Urta.  You and Kath tiptoe out, leaving Urta to her well deserved rest.");
	}
	else {
		outputText("\n\nYou ask Kath if she feels like going back to her place.\n\n");
		outputText("She downs the last of her drink and replies, “<i>Mmmm, I hope you have something in mind.  Preferably something naughty.</i>”");
	}
	doNext(takeKathHome);
}

private function takeKathHome():void { //You are bringing her home for sexy times
	outputText("\n\nThe two of you race through the streets heading for Kath's apartment.  You let her stay ahead of you most of the way so you get a nice view of her tight little ass.\n\n");
	outputText("Kath just about attacks the lock with her key.  As soon as the door opens she pulls you through eagerly, locking it behind you and leading you to the bedroom.\n\n");
	clothes();
	outputText("\n\nShe stands next to her bed, waiting for you to " + (playerMaster() ? "tell her what to do." : "make the first move."));
	flags[kFLAGS.KATHERINE_LOCATION] = KLOC_KATHS_APT;
	katherineMenu();
}

private function dateGotoBar():void {
	if (isAt(KLOC_URTAS_APT)) {
		outputText("\n\nYou offer to take Kath back to the Wet Bitch.  Kath smiles at you, but before she steps out the door Urta grabs her from behind, giving the cat " + catGirl("girl", "morph") + " a big hug.  Then Urta steps out and gives you a hug too.\n\n");
		outputText("As she goes back inside Urta says, “<i>You take care of each other - and don't do anything I wouldn't do.</i>”");
	}
	else if (isAt(KLOC_URTAS_HOME)) {
		outputText("\n\nYou have to wait while Kath cleans herself up, but she tries to be quick about it.  You sit on the edge of the bed and rub the back of Urta's neck.  Urta groans and lies down flat in the puddle of cum, saying, “<i>Thanks " + player.short + ", I'll be fine.  I'm really comfy.</i>”\n\n");
		outputText("As Kath tracks down the last piece of her clothing you hear gentle snoring from Urta.  You and Kath tiptoe out, leaving Urta to her well deserved rest.");
	}
	else {
		outputText("\n\nYou ask Kath if she feels like wandering back to the bar.\n\n");
		outputText("She says, “<i>There are fun things we could do right here.</i>”  Before you can reply she’s hopped into your arms and says, “<i>Of course I’m sure you’ve got something fun in mind when you suggested going there." + (pregSize() == 0 ? "  Or are you just planning to get me toasted so you can have your way with me?" : "") + "</i>”");
	}
	doNext(takeKathToTheBar);
}

private function takeKathToTheBar():void { //You are bringing her to the Wet Bitch
	outputText("\n\nThe two of you walk through the streets of Tel'Adre arm in arm.  Kath enjoys the walk while you think about what you'd like to do with her once you reach the bar.\n\n");
	outputText("When you walk through the doors of the Wet Bitch Kath stops at the bar and buys a " + (pregSize() > 0 ? "milkshake" : "brown, creamy looking drink with ice cubes in it") + ", which she starts sipping luxuriously.\n\n");
	outputText("Since it happens to be free you both take a seat at her usual booth and you feel Kath's leg rub against " + (player.isNaga() ? "yours." : "your tail."));
	flags[kFLAGS.KATHERINE_LOCATION] = KLOC_BAR;
	katherineMenu();
}

public function dateKathBath():void {
	outputText("\n\nYou ask Kath what she thinks of taking a trip out to the lake.\n\n");
	outputText("“<i>Oh, but I have nothing to wear,</i>” she says in a playful, seductive tone.  ");
	if (isAt(KLOC_STREETS))
		outputText("She hops up off her crate in a way that causes her breasts to bounce.  She");
	else if (isAt(KLOC_URTAS_APT) || isAt(KLOC_URTAS_HOME))
		outputText("She goes outside with you and");
	else ((isAt(KLOC_KATHS_APT) ? "She jumps up off the bed" : "She sucks up the last of her drink and hops out of her seat") + " in a way that causes her breasts to bounce.  She");
	outputText(" gets up close to you before adding, “<i>But I bet you knew that.  I’d love a naked swim, especially if it’s with you.</i>”");
	flags[kFLAGS.KATHERINE_LOCATION] = KLOC_LAKE;
	doNext(bathTime);
}

private function katherineDrinkUp():void {
	clearOutput();
	outputText("You sit across from Kath and ask her what she’s drinking.\n\n");
	outputText("She shows you a tumbler with some opaque light brown liquid in it.  “<i>They have this cream liqueur called Venusia.  It’s like drinking milk and booze at the same time.  It’s pretty strong but also girly - kinda like me.  I guess that’s why I like it a lot.</i>”\n\n");
	outputText("You ask if it’s strong enough to get drunk on.\n\n");
	outputText("“<i>I’ve already got drunk from this stuff by accident.  Like I said, it’s pretty strong.  My first day in the Watch lots of people bought me drinks.  I found out the hard way that I get a little horny when I’m drunk.  Urta spotted it and got me home before I did anything stupid, but now I make sure to only have one or two of these at a time.</i>”\n\n");
	outputText("You grin and tell Kath that since you’re here she can indulge.\n\n");
	outputText("She gives you a smile and waves over the waitress.  When the next tumbler arrives she takes a sip and says, “<i>I bet you’re just trying to get me drunk cause you think I’ll get horny.</i>”  You rub " + (player.isNaga() ? "the tip of your tail" : "your toe") + " against the inside of Katherine’s leg.  She tips back the tumbler, swallows, smiles and orders another.\n\n");
	outputText("In no time you see the telltale signs that your girlfriend is now wasted.");
	flags[kFLAGS.KATHERINE_LOCATION] = KLOC_BAR_DRUNK;
	katSexMenu();
}

//Katherine Appearance:
private function katherinesAppearance(clear:Boolean = true):void {
    if (clear) clearOutput();
    outputText(images.showImage("katherine-examine-her-appearance"));
    if (flags[kFLAGS.KATHERINE_UNLOCKED] < 4) { //Still unemployed
		outputText("Katherine stands before you, nervously watching as you scrutinize her form.  “<i>Um... do you like what you see?</i>”  Nervously trying to break the ice and amateurishly trying to flaunt her body, she strikes what might be a sexy pose... in her mind.\n\n");
	}
	else if (model.time.hours >= 10) { //She’s off duty (on duty doesn’t need intro text)
		//She’s at home (appearance function doesn’t get used at the bar)
		outputText("Katherine stands before you, beaming with pride.  She moves her fingers across her body, hoping to give you ideas.  “<i>Is there anything you’d like to do?</i>” she purrs.\n\n");
	}

	outputText("Katherine is a lean-built hermaphroditic cat ");
	if (furry) {
		outputText("morph, standing maybe 5' 2\" tall.  ");
		if (hairColor == "jet black")
			outputText("Both her fur and");
		else outputText("Her fur is black, but");
	}
	else outputText("girl, standing maybe 5' 2\" tall.  She has a pair of cat ears and a tail, both covered in black fur.  Her skin is milky white and");
	outputText(" her shoulder-length hair, often worn forward and obscuring one of her leaf-green eyes, " + (furry && hairColor == "jet black" ? "are " : "is "));
	if (!furry && hairColor == "jet black")
		outputText("just as black as the fur on her ears and tail.\n\n");
	else outputText(hairColor + ".\n\n");
	
	clothes(); //Outputs a full description of the clothes she’s currently wearing
	switch (flags[kFLAGS.KATHERINE_CLOTHES_WORN]) {
		case KBIT_CLOTHES_UNIFORM: //Guard Uniform
			outputText("\n\nYou mention that you’d like to take a closer look at her.  She eagerly leads you into a nearby alley and undresses herself so that you can do just that"); break;
		case KBIT_CLOTHES_C_CLOTH: //Blouse and Skirt
			outputText("  Before you can even ask she begins to strip off her clothes to give you a better look"); break;
		case KBIT_CLOTHES_BODYSUIT: //Bodysuit
			outputText("  As you watch she begins to wiggle out of the bodysuit in the sexiest way possible"); break;
		case KBIT_CLOTHES_B_DRESS: //Elegant Long Dress
			outputText("  She teases you by slowly undoing each button in turn before stepping out of the dress"); break;
		case KBIT_CLOTHES_SS_ROBE: //Spider Silk Robe
			outputText("  Kath smiles and steps out of the robes, leaving them to crumple to the floor while she strips off her underwear and poses her naked body for you"); break;
		case KBIT_CLOTHES_TUBETOP: //Tube Top
			outputText("  Before you can even ask she begins to peel off her clothes to give you a better look"); break;
		case KBIT_CLOTHES_NURSECL: //Nurse’s Outfit
			outputText("  Before you can even ask Kath unbuttons the tight top and slides off her skirt to give you a better look"); break;
		default: //Tattered Clothes
			outputText("  At your gesture, she meekly undresses herself so that you can get a better look at her");
	}
	outputText(".\n\n");

	outputText("Two " + breasts.adj() + " " + breasts.cup() + " breasts" + (breasts.milkIsFull() ? ", laden with cream," : "") + " sit on her chest" + (breasts.milkIsOverflowing() ? ".  Her nipples stand at attention, ready for milking" : ""));
	if (hasCock()) {
		outputText(", while just below her belly button sits the unmistakable form of an animalistic penis sheath.  Shyly, her " + cockMultiple("phallus begins ", "phalli begin ") + "to slip from its length; a " + cockMultiple("", "pair of ") + cockType() + " cock" + cockMultiple(" ", "s ") + cockWidth() +"\" thick and " + cockLength + "\" long reveal" + cockMultiple("s itself, with a ", " themselves, with ") + knotSize + "\" thick knot" + cockMultiple(" at its base.  ", "s at their bases.  "));
		if (ballSize == 0)
			outputText("Just beneath Kath’s " + cockMultiple("cock is", "twin cocks is"));
		else outputText("A pair of " + ballSize + "\" wide balls sway below her cock" + cockMultiple("", "s") + ", hanging just above");
	}
	else outputText(" and between her legs rests");
	outputText(" her wet, eager cunt.\n\n");
    
    if (flags[kFLAGS.KATHERINE_UNLOCKED] < 4) { //Still unemployed
		outputText("When you're finished looking at her she quickly redresses herself, flaunting her rear at you as if by accident and waiting to see what else you want, reassured by your lack of comments.");
		katherineMenu(); //Display default Katherine options
	}
	else if (model.time.hours >= 10) { //She’s at home (appearance function is never called at the bar). If time < 10 then she is on duty. See katherineOnDuty() for end of conversation & menu
		outputText("Totally naked, tail waving with pleasure, Katherine stretches, giving you a very good show of all her most private parts.  “<i>Like what you see, dearest?</i>” she purrs.\n\n");
		outputText("Oh yes, you tell her.  The clothes look good on her and what they hid is even better.  “<i>I do like the sound of that,</i>” she replies, “<i>but it is a bit chilly in here.</i>”  Her tail twitches with pent up energy and she slides her hands down her sides, " + catGirl("stroking her milky white skin", "smoothing her shiny fur coat") + " before asking, “<i>Can you think of a way to keep me warm?</i>”\n\n");
		outputText("She starts to collect her clothes, putting them back on almost as seductively as she removed them.\n\n");
		katherineMenu();
	}
}
	
//Give Item:
private function giveKatherineAnItem():void {
	clearOutput();
	outputText("You tell Katherine that you have a present for her.\n\n");
	outputText("The cat-morph's face lights up, but then she guiltily lowers her eyes.  “<i>I can't - you're too good to me already...</i>”  You cut her off, insisting that you want to give it to her.  “<i>Okay, if you're sure... what is it?</i>”\n\n");
	var hasJob:Boolean = flags[kFLAGS.KATHERINE_UNLOCKED] >= 4;
	var blackEgg:Boolean = player.hasItem(consumables.BLACKEG) || player.hasItem(consumables.L_BLKEG);
	var honey:Boolean = player.hasItem(consumables.BEEHONY) || player.hasItem(consumables.PURHONY);
	var pinkEgg:Boolean = player.hasItem(consumables.PINKEGG) || player.hasItem(consumables.L_PNKEG);
	var button:int = 0;
	menu();
	//Clothes
	if (hasJob && !hasClothing(KBIT_CLOTHES_BODYSUIT) && player.hasItem(armors.T_BSUIT)) addButton(button++, "Bodysuit", giveKatClothesBodysuit);
	if (hasJob && !hasClothing(KBIT_CLOTHES_B_DRESS) && player.hasItem(armors.B_DRESS)) addButton(button++, "Long Dress", giveKatClothesLongDress);
	if (hasJob && !hasClothing(KBIT_CLOTHES_NURSECL) && player.hasItem(armors.NURSECL)) addButton(button++, "NurseClothes", giveKatClothesNurseOutfit);
	if (hasJob && !hasClothing(KBIT_CLOTHES_SS_ROBE) && player.hasItem(armors.SS_ROBE)) addButton(button++, "Silk Robe", giveKatClothesSilkRobe);
	if (hasJob && !hasClothing(KBIT_CLOTHES_TUBETOP) && player.hasItem(armors.TUBETOP)) addButton(button++, "Tube Top", giveKatClothesTubeTop);
	//Transformatives
	if (player.hasItem(consumables.BULBYPP)) addButton(button++, "BulbPepper", giveKatABulbousPepper);
	if (player.hasItem(consumables.CANINEP)) addButton(button++, "Canine Pep", giveKatACaninePepper);
	if (hasJob && furry && blackEgg && player.hasItem(consumables.P_S_MLK) && player.hasItem(consumables.GLDSEED)) addButton(button++, "Defur", giveKatDefurFormula);
	if (player.hasItem(consumables.DBLPEPP)) addButton(button++, "DblPeppr", giveKatADoublePepper);
	if (hasJob && player.hasItem(consumables.KNOTTYP)) addButton(button++, "KnotPepp", giveKatAKnottyPepper);
	if (hasJob && player.hasItem(consumables.LACTAID)) addButton(button++, "Lactaid", giveKatTheGiftOFMilk);
	if (player.hasItem(consumables.LARGEPP)) addButton(button++, "LrgPepp", giveKatAOverlyLargePepper);
	if (hasJob && hasCock() && pinkEgg) addButton(button++, "Pink Egg", usePinkEggOnKath);
	if (hasJob && player.hasItem(consumables.P_DRAFT)) addButton(button++, (hasCock() ? consumables.P_DRAFT.shortName : "Grow Cock"), useIncubiDraftOnKath);
	if (hasJob && hasCock() && player.hasItem(consumables.PSDELIT)) addButton(button++, "P. Suc Delight", giveKatPureSuccubusDelight);
	if (hasJob && player.hasItem(consumables.P_S_MLK)) addButton(button++, "P. Suc Milk", giveKatPureSuccubusMilk);
	if (player.hasItem(consumables.REDUCTO)) addButton(button++, "Reducto", useReductoOnKat);
	if (hasJob && !furry && honey && player.hasItem(consumables.W_FRUIT) && player.hasItem(consumables.EXTSERM)) addButton(button++, "Refuzz", giveKatRefuzzFormula);
	if (hasJob && hasCock() && ballSize == 1 && pinkEgg && player.hasItem(consumables.REDUCTO)) addButton(button++, "Rem Balls", useReductoAndPinkEgg);
	if (hasJob && player.hasItem(consumables.W_FRUIT)) addButton(button++, "W. Fruit", giveKatWhiskerFruit);
	//Dyes
	if (hasJob && hairColor != "rich auburn" && player.hasItem(consumables.AUBURND)) addButton(button++, "Auburn Dye", giveKatDyeAuburn);
	if (hasJob && hairColor != "jet black" && player.hasItem(consumables.BLACK_D)) addButton(button++, "Black Dye", giveKatDyeBlack);
	if (hasJob && hairColor != "light blonde" && player.hasItem(consumables.BLOND_D)) addButton(button++, "Blonde Dye", giveKatDyeBlonde);
	if (hasJob && hairColor != "bright blue" && player.hasItem(consumables.BLUEDYE)) addButton(button++, "Blue Dye", giveKatDyeBlue);
	if (hasJob && hairColor != "lime green" && player.hasItem(consumables.GREEN_D)) addButton(button++, "Green Dye", giveKatDyeGreen);
	if (hasJob && hairColor != "vibrant orange" && player.hasItem(consumables.ORANGDY)) addButton(button++, "Orange Dye", giveKatDyeOrange);
	if (hasJob && hairColor != "neon pink" && player.hasItem(consumables.PINKDYE)) addButton(button++, "Pink Dye", giveKatDyePink);
	if (hasJob && hairColor != "deep purple" && player.hasItem(consumables.PURPDYE)) addButton(button++, "Purple Dye", giveKatDyePurple);
	if (hasJob && hairColor != "flaming red" && player.hasItem(consumables.RED_DYE)) addButton(button++, "Red Dye", giveKatDyeRed);
	if (hasJob && hairColor != "snow white" && player.hasItem(consumables.WHITEDY)) addButton(button++, "White Dye", giveKatDyeWhite);
	addButton(14, "Back", katherineMenu);
}

//Reducto
private function useReductoOnKat():void {
	clearOutput();
	var dickMin:int = (flags[kFLAGS.KATHERINE_UNLOCKED] >= 4 ? 6 : 8); //If she's employed she'll go as low as 6 inches
	if (cockLength <= dickMin && ballSize <= 1 && knotSize <= 2 && breasts.cupSize == BREAST_CUP_A) {
		//If min size on all Kat parts reached:
		outputText("She looks at the jar and then visibly thinks about it, but shakes her head.  “<i>I'm sorry, " + playerText() + ", but I don't think it's possible for that stuff to make any of my remaining parts shrink any more...");
		if (playerMaster())
			outputText("</i>”\n\nYou sigh and put the jar away.  ");
		else outputText("  Or rather, I should say I don't want to get any smaller than I am now, thank you.</i>”\n\nYou nod in understanding and put the jar away.  ");
		outputText("She looks apologetic.  “<i>Did you maybe want to do something else?</i>” she asks.");
		doNext(giveKatherineAnItem); //Display main Kat item menu
	}
	else {
		var knot:Function = (knotSize > 2 ? useRedoctoOnKatsKnot : null);
		var leng:Function = (cockLength > dickMin ? useReductoOnKatsKock : null);
		var balls:Function = (ballSize > 1 ? reductoBallSize : null);
		var breasts:Function = (breasts.cupSize > CoC.BREAST_CUP_A ? useRreductoOnKatsBreasts : null);
		outputText("You extract the small jar of salve and offer it to her.   Her face lights up in delight.  “<i>Reducto?!  For me?  It's so expensive!</i>”  At your nod, she yowls happily and snatches it up, " + clothesLowerChoice("yanking down her shorts", "raising her skirt and pulling down her panties", "opening the folds of her bodysuit", "raising her dress and pulling down her panties", "untying her robe and pulling down her panties") + " to expose her sheath.  All of a sudden, she stops abruptly and looks up at you, a dangerous gleam in her eye.  “<i>Would you like to... help me apply it?</i>” she asks, softly.  You nod your head");
		if (player.lib > 50) outputText(" with a salacious grin");
		outputText(" and she happily plunks down on ");
		if (isAt(KLOC_STREETS))
			outputText("a nearby crate, holding the precious jar of ointment and waiting for you to begin.\n\n");
		else //Kath is at her apartment
			outputText("her bed and strips off the rest of her clothes in a seductive little dance.  Then she hands you the precious jar of ointment and waits for you to begin.\n\n");
		outputText("You kneel before her, looking at her " + (isAt(KLOC_STREETS) ? "sheath " : "naked body "));
		if (player.lib > 50)
			outputText("and planning exactly what you're going to do to it.");
		else outputText("and wondering how to begin.");
		simpleChoices("Knot", knot, "Length", leng, "Balls", balls, "Breasts", breasts, "Back", giveKatherineAnItem);
    }
}

private function useRedoctoOnKatsKnot():void {
	clearOutput();
	outputText("You gently reach out and start to stroke her sheath up and down, feeling the long bone of ");
	if (cockNumber > 1)
		outputText("each of her " + cockType() + " cocks, and rubbing one finger across the exposed tips.  The cat wriggles and squirms, and quickly blooms under your care, until all " + cockLength + " inches of both shafts are exposed.  Her knots just barely visible as a bulge at the base of each cock, you start to stroke them next.  Katherine coos and moans as your fingers glide up and down, and the responsive flesh starts to swell like red, hard balloons.  They puff up and up, swelling to full size, " + knotSize + " inches in diameter.  With the subjects prepared, you stop, leaving Katherine hovering at the edge of release.\n\n");
	else outputText("her " + cockType() + " cock, and rubbing one finger across the exposed tip.  The cat wriggles and squirms, and quickly blooms under your care, until all " + cockLength + " inches of her shaft is exposed.  Knot just barely visible as a bulge at the base of her cock, you start to stroke it next.  Katherine coos and moans as your fingers glide up and down, and the responsive flesh starts to swell like a red, hard balloon.  It puffs up and up, swelling to full size, " + knotSize + " inches in diameter.  With the subject prepared, you stop, leaving Katherine hovering at the edge of release.\n\n");

	outputText("She is, however, too wound up to do anything, so you are forced to take the Reducto from her slack fingers and smear the foul-smelling gunk across her knot");
	if (cockNumber > 1) {
		outputText("s.  She gasps and suddenly lets out a yowl, her cocks visibly spasming as her knots shrink... and then promptly begins spurting cum, which you ");
		if (player.lib > 50) outputText("joyously attempt to catch in your mouth like rain");
		else outputText("narrowly dodge in surprise");
		outputText(", at the expense of dropping and spilling what's left of the salve.  The hard flesh shrinks until the width of each knot has dropped by two whole inches, at which point the salve's effects wear off and her climax finishes... though, given that her knots remain swollen and her cocks remain erect, you think she could probably go again.\n\n");
	}
	else {
		outputText(".  She gasps and suddenly lets out a yowl, her cock visibly spasming as her knot shrinks... and then promptly begins spurting cum, which you ");
		if (player.lib > 50) outputText("joyously attempt to catch in your mouth like rain");
		else outputText("narrowly dodge in surprise");
		outputText(", at the expense of dropping and spilling what's left of the salve.  The hard flesh shrinks until the width has dropped by two whole inches, at which point the salve's effects wear off and her climax finishes... though, given that her knot remains swollen and her cock remains erect, you think she could probably go again.\n\n");
	}

	outputText("She rewards you with a glowing, orgasmic smile.  “<i>That was... incredible.  Thank you so much for the present... did you want to do anything else?  Maybe... have a little fun?</i>” she asks, her voice low and husky with desire.\n\n");
	//use 1x Reducto, reduce Kat knot size by 2, increase PC lust value, go to Kat sex menu
	knotSize -= 2;
	if (knotSize < 2) knotSize = 2;
	dynStats("lus", 10 + player.lib / 20);
	player.consumeItem(consumables.REDUCTO);
	katSexMenu();
}

//[Cock Length] (unavailable unless Kat cocklength is >8, or >6 if she's employed)
private function useReductoOnKatsKock():void {
	clearOutput();
	outputText("With a gesture, you indicate for her to expose herself.  In obedience, she begins to stroke her sheath and expose its contents, bashfully at first but with increasing vigor as her erection takes hold.  Soon she's masturbating happily with her eyes closed and her head rolled back on her neck, having nearly forgotten what she was doing in the first place.  You ");
	if (player.lib > 50) outputText("allow her to continue until " + (ballSize > 0 ? "her scrotum tightens up and " : "") + "it looks like she'll blow her load with one more touch, and then ");
	outputText("clear your throat noisily to regain her focus.  Blushing " + catGirl("a brilliant red", "red underneath her sable fur") + ", she guiltily withdraws her hand from her shivering cock" + cockMultiple("", "s") + ".\n\n");

	outputText("With a playful eyebrow, you take a knee in front of the throbbing-hard member" + cockMultiple("", "s") + " and uncap the salve.  As if to tease, you dip into it and then, at a glacial pace, draw the paste closer to her shaft" + cockMultiple("", "s") + " while remarking how cold it is compared to the desert air.  She quivers at the comment, setting her " + cockMultiple("cock", "twin cocks") + " to bobbing");
	if (player.lib > 50) outputText(", then quivers again as the movement brings her a hair closer to her climax");
	outputText(".\n\n");

	outputText("Gingerly, you lift your unemployed hand up and tilt her " + cockType("puppy pecker", "kitty cock") + cockMultiple("", "s") + " toward her face and chest; she shivers as you touch the sensitive underside" + cockMultiple("", "s") + ".  As you hold her in that position, ");
	if (player.lib > 50) outputText("staring at Katherine with a lewd smirk as she trembles and tries to maintain control, ");
	outputText("you bring the occupied hand up and begin rubbing the paste into the shaft" + cockMultiple("", "s") + " proper with brisk up-and-down strokes.");
	if (player.lib > 50) outputText("  Barely any time has passed before Katherine, with a husky groan of protest and acquiescence mingled, begins unloading her steamy cargo; the first squirt  " + (isAt(KLOC_STREETS) ? "stains her shirt" : "coats her chest") + " while the later and more energetic ones after it reach all the way to her neck and spatter on her chin.");
	outputText("  Katherine trembles ");
	if (player.lib > 50) outputText("and her orgasm continues ");
	outputText("as you apply a goodly amount of paste, smearing it over every inch of the twitching cock" + cockMultiple("", "s") + " and mingling it with the copious pre-cum from her errant masturbation.  Suddenly a gasp interrupts the chorus of low moans from your felid companion, as the effects begin.  Her shaft" + cockMultiple(" spasms and shrinks, ", "s spasm and shrink, "));
	if (player.lib > 50) outputText("still pushing out the aftershocks of her climax onto her belly, ");
	outputText("ending up two inches shorter than before.\n\n");

	outputText("“<i>God, that was... uughh,</i>” Katherine groans, wiping her " + catGirl("skin", "fur") + ".  “<i>I'm still so hard and horny, too... feels like I'll never go soft now.  Do you maybe... wanna help me with that?</i>”  She turns a hopeful");
	if (player.lib > 50) outputText(", if fatigued,");
	outputText(" look on you.\n\n");

	//remove 2 inches from Kat's length, use 1x Reducto, increase PC lust value, go to Kat sex menu
	cockLength -= 2;
	var dickMin:int = (flags[kFLAGS.KATHERINE_UNLOCKED] >= 4 ? 6 : 8); //If she's employed she'll go as low as 6 inches
	if (cockLength < dickMin) cockLength = dickMin;
	dynStats("lus", 10 + player.lib / 20);
	player.consumeItem(consumables.REDUCTO);
	katSexMenu();
}

//[Ball Size](unavailable until Kat balls > 1")
private function reductoBallSize():void {
	clearOutput();
	if (isAt(KLOC_STREETS)) outputText("With a little help from you, she " + clothesLowerChoice("wriggles out of her shorts", "strips off her panties and raises her skirt", "strips off her bodysuit", "strips off her panties and raises her skirt", "unties her robe") + ", exposing her swollen testes.  ");
	outputText("You wonder for a moment if the " + catGirl("hair", "fur") + " on her " + (ballSize > 3 ? "distended" : "") + " sack will interfere with the process, then decide it can't hurt to try.  Uncertainly, you open the jar and begin smearing your fingers with the salve, which you then start painting across Katherine's balls.  The hermaphrodite " + catGirl("cat girl", "feline") + " shivers at your touch, but bites her lip and says nothing as you massage the shrinking cream into her semen-factories, rolling the globular orbs around in the palm of your hand to ensure a thorough, even coating.\n\n");

	outputText("You finish applying the salve and watch as they visibly shrink, contracting in on themselves until they have lost two inches in diameter.  It's at that point you realize the man-meat above them is jutting straight up from her sheath, pre-cum starting to bubble from the pointy tip" + cockMultiple("", "s") +".  “<i>Uh... I think shrinking my balls put their contents under pressure.  You wanna help me vent some?</i>” she meekly suggests, coloring and biting her lip in either embarrassment or anticipation.\n\n");
	//use 1x Reducto, reduce Kat ball size by two inches, increase PC lust by small value, go to Kat sex menu
	ballSize -= 2;
	if (ballSize < 1) ballSize = 1;
	dynStats("lus", 10 + player.lib / 20);
	player.consumeItem(consumables.REDUCTO);
	katSexMenu();
}

private function useRreductoOnKatsBreasts():void {
	clearOutput();
	outputText("You get on the bed next to Kath and place the jar on her belly.  As you coat your hands with the cool cream Kath closes her eyes and begins to purr.  There seems to be no change as you rub the ointment into her " + breasts.adj() + " " + breasts.cup() + " breasts.  Only when the jar is nearly exhausted do they start to firm up and contract.");
	if (breasts.lactating()) {
		outputText("  Kath's tail goes rigid and puffs up as her breasts shrink and you soon understand why.  ");
		if (breasts.milkIsOverflowing())
			outputText("Her cream is forced from her newly shrunken chest in long streams that almost reach the ceiling.  The whole bed is soggy and you have to wonder how many people can say they've had their girlfriend's milk rain down on them.  She seems to be fixed in place until it's over, then she unclenches her fists and lets out a deep sigh.");
		else if (breasts.milkIsFull())
			outputText("Her cream is forced from her newly shrunken chest in little squirts, drizzling onto Kath and the bed.  She grits her teeth and when it's over she unclenches her fists and lets out a deep sigh.");
		else outputText("Drops of cream fall from her newly shrunken bosom, leaving little trails on her chest.");
	}
	breasts.cupSize--;
	outputText("\n\nKath sits up and begins to play with her smaller and lighter rack.\n\n");
	if (breasts.cupSize == CoC.BREAST_CUP_A)
		outputText("“<i>These are so small people might think I’m a boy.  Guess I’ll just have to act even more girly to make up for it, right?</i>”");
	else if (breasts.cupSize == CoC.BREAST_CUP_B)
		outputText("“<i>Back to my natural size.  Nice, I’ve missed the balance I had when they were this big.  Thank you so much " + playerText() + ".</i>”");
	else if (breasts.cupSize == CoC.BREAST_CUP_DD_BIG)
		outputText("“<i>Oh, that’s better.  They’re a lot lighter.  It doesn’t feel like I’ve got a pair of watermelons tied to my chest anymore.</i>”");
	else if (breasts.cupSize > CoC.BREAST_CUP_DD_BIG)
		outputText("“<i>Oh thank Marae.  And thank you too " + playerText() + ".  I can feel some of the muscles in my lower back starting to relax.</i>”");
	else outputText("“<i>Yes, I think I’ll get used to these smaller sweater puppies pretty quickly.</i>”");
	outputText("\n\nShe lies back on the bed and spreads her legs wide, her cock" + cockMultiple("", "s") + " aimed at the ceiling.  “<i>Now since you’ve pawed my breasts and got me all excited I hope you aren’t planning on leaving anytime soon.</i>”");
	dynStats("lus", 10 + player.lib / 20);
	player.consumeItem(consumables.REDUCTO);
	katSexMenu();
}

//Bulbous Pepper
private function giveKatABulbousPepper():void {
	clearOutput();
	outputText("You hold out your bulbous canine pepper and ask if she'd like to eat it.\n\n");
	if (!hasCock()) {
		outputText("“<i>I'm pretty sure that won't have any effect on me,</i>” she replies.  “<i>But they do taste nice, so as long as you don't mind...</i>”  She smiles and and takes the pepper, munching it down.  With a moan she " + clothesLowerChoice("pushes a hand down her shorts", "hikes up her skirt", "opens the folds of her bodysuit", "hikes up her dress", "parts her robe") + " and starts rubbing her clit.\n\n");
		outputText("“<i>Oh please " + playerText() + ", don't leave me to deal with this feeling on my own.</i>”");
		dynStats("lus", 10 + player.lib / 20);
		player.consumeItem(consumables.BULBYPP);
		katSexMenu();
	}
	else if (!hasBalls()) {
		outputText("“<i>Funny, I was just getting used to not having them</i>” she replies.  She gives you a friendly wink and then takes the pepper, munching it down.  She moans and clutches her groin through her " + clothesLowerChoice("shorts", "skirt", "bodysuit", "dress", "robe") + "; as you watch her hand is forced away from her body as her testes regrow and descend.");
		if (!hasDogCock()) {
			if (cockNumber > 1)
				outputText(" At the same time her cocks stretch outwards, absorbing their barbs. In a few moments Kath is once again sporting a pair of " + cockAdj() + " canine cocks.");
			else outputText(" At the same time her cock stretches outwards, absorbing its barbs. In a few moments Kath is once again sporting a " + cockAdj() + " canine cock.");
			flags[kFLAGS.KATHERINE_DICK_FORM] = 0;
        }
		outputText("\n\nKath rubs her newly formed balls and you see a " + cockAdj() + "bulge developing as her " + cockMultiple("cock stands", "twin cocks stand") + " to attention.  She gives you a toothy smile and asks, “<i>So... you wanna give them a test run?</i>”\n\n");
		ballSize = 1;
		dynStats("lus", 10 + player.lib / 20);
		player.consumeItem(consumables.BULBYPP);
		katSexMenu();
	}
	else if (ballSize < 5) {
		outputText("“<i>Oh, sure, why not?  Bigger balls have got to be better, right?</i>” she replies.  Her tone is sarcastic, but she gives you a friendly wink and then takes the pepper, munching it down.  With a moan " + clothesLowerChoice("and an arched back, she produces a new swell in her tight shorts as you look on", "she raises her skirt, allowing you to watch as she produces a new swell in her tight panties", "and an arched back, she produces a new swell in the crotch of her semi-transparent bodysuit", "she raises her skirt, allowing you to watch as she produces a new swell in her tight panties", "she unties her robe, allowing you to watch as she produces a new swell in her tight panties") + ", her balls visibly growing.  They roughly double in size, then stop, leaving the cat herm panting.  ");
		if (!hasDogCock()) {
			if (cockNumber > 1)
				outputText(" At the same time her cocks stretch outwards, absorbing their barbs.  In a few moments Kath is once again sporting a pair of " + cockAdj() + " canine cocks.  ");
			else outputText(" At the same time her cock stretches outwards, absorbing its barbs.  In a few moments Kath is once again sporting a " + cockAdj() + " canine cock.  ");
			flags[kFLAGS.KATHERINE_DICK_FORM] = 0;
		}
		outputText("She throws you a sultry look.  “<i>So... you wanna give them a test run?</i>” she purrs.\n\n");
		ballSize += 2;
		if (ballSize > 5) ballSize = 5;
		dynStats("lus", 10 + player.lib / 20);
		player.consumeItem(consumables.BULBYPP);
		katSexMenu();
    }
	else if (submissiveness() >= 4 && ballSize < 9) {
		outputText("She looks at the bulbous pepper and then shakes her head.  “<i>No thank you.  Any bigger and I'm going to have trouble walking, and I think I make enough of a mess as it is.  Thank you for the offer, though.  Was there anything else?</i>” she adds, trying to be diplomatic.\n\n");
		outputText("You give Kath a big grin and tell her you’d like to see her grow larger.  Lots of people in Mareth have balls bigger than her and they can still move around.  You move closer and start to fondle her " + ballAdj() + " dangling orbs through her " + clothesLowerChoice("shorts", "skirt", "semi-transparent bodysuit", "dress", "robe") + ".\n\n");
		outputText("Kath pants as her " + cockMultiple("cock begins", "cocks begin") + " to swell.  “<i>I... I suppose I could try it.  As long as you still think I’m pretty.</i>”\n\n");
		outputText("You continue to massage her nuts and tell her that’s not enough.  She agreed so quickly that she must secretly want this.\n\n");
		outputText("Kath twists and turns in place, as if part of her wants to escape.  Finally, after a sharp intake of breath your obedient little " + catGirl("cat girl", "kitty") + " says, “<i>Yes.  Yes, " + playerText() + ", I want it.  If you want me to have bigger balls then I want them too.</i>”\n\n");
		outputText("You just smile and use your free hand to push the fat little pepper between Kath’s lips.  She tries to take it but you slide it in and out as if it’s a tiny cock.  You tell her to suck on it and she does.  When you finally release your grip Kath sucks the pepper into her mouth and munches on it hungrily.\n\n");
		outputText("It doesn’t take long before you feel her scrotum expand.  It throbs and pushes your fingers apart, each of her testes growing by about two inches.  ");
		if (!hasDogCock()) {
			if (cockNumber > 1)
				outputText("At the same time her cocks stretch outwards, absorbing their barbs.  In a few moments Kath is once again sporting a pair of " + cockAdj() + " canine cocks.  ");
			else outputText("At the same time her cock stretches outwards, absorbing its barbs.  In a few moments Kath is once again sporting a " + cockAdj() + " canine cock.  ");
			flags[kFLAGS.KATHERINE_DICK_FORM] = 0;
		}
		outputText("Katherine wraps her arms around you for support.  When the change seems to have run its course she spreads her legs to accommodate her " + ballAdj() + " ballsack and whispers in your ear, “<i>So... you wanna give them a test run?</i>”\n\n");
		addSubmissive(KBIT_SUB_GROW_BIG_BALLS); //Have made her supersize her balls at least once
		ballSize += 2;
		if (ballSize > 9) ballSize = 9;
		dynStats("lus", 10 + player.lib / 20);
		player.consumeItem(consumables.BULBYPP);
		katSexMenu();
	}
    else { //Too big
		if (submissiveness() >= 4) { //Too big even for submissive Kath
			outputText("She gets down on her knees and begs you.  “<i>Please " + playerText() + " - I already have problems whenever I try to chase criminals.  If they get any bigger I might lose my job.  Thank you for offering, but don’t these monsters make enough cum for us both?  Please can’t we do something else?</i>” she adds with a worried smile, trying to be diplomatic.");
			if (player.cor >= 75) {
				outputText("\n\nIt certainly would be fun to give your " + catGirl("cat girl", "feline") + " fucktoy such enormous balls that she wouldn’t be able to move.  On the other hand if she loses her job then you’ll have to take care of her.  Screw that - you still get all the sex you want from her as is and you don’t have to pay.\n\n");
				outputText("You scratch her ear and assure her it’s all right.  Kath purrs and presses against you, her cock" + cockMultiple(" beginning to slide from its sheath.", "s beginning to slide from their sheaths."));
			}
		}
		else {
			outputText("She looks at the bulbous pepper and then shakes her head.  “<i>No thank you.  Any bigger and I'm going to have trouble walking, and I think I make enough of a mess now as it is.  Thank you for the offer, though.  Was there anything else?</i>” she adds, trying to be diplomatic.\n\n");
			outputText("She did hesitate for a second... if you convince Kath to do a few other things she's unsure of she might be willing to munch on another pepper.");
		}
		katherineMenu();
	}
}

private function giveKatACaninePepper():void {
	clearOutput();
	outputText("You offer Katherine a canine pepper and ask if she'd like to have one for old times sake.\n\n");
	if (hasDogCock()) {
		outputText("“<i>I don't know.  I don't want to push my luck with those things.  I've already got a lot of them in my system and maybe just a few more would have me barking at the moon.</i>”\n\n");
		outputText("She takes your hand and says, “<i>It was a nice thought, and I do like the taste and smell.</i>”  At this she starts to sniff along the pepper's length.  “<i>They make me horny... do they make you horny?</i>”  She nuzzles against you and asks, “<i>Can you guess what's on my mind, love?</i>”\n\n");
	}
	else {
		outputText("“<i>It's sure to give me a " + cockMultiple("dog cock", "set of dog cocks") + " again.  That doesn't mean I'm saying no, I kinda got used to having one" + cockMultiple("", " and then two of 'em") + ".</i>”  At this she starts to sniff along the pepper's length.  “<i>I guess what I means is I like having a nice " + cockMultiple("hard cock", "pair of hard cocks") + " and somewhere to stuff " + cockMultiple("it", "them") + ".  Maybe that makes me a slutty herm, but I could care less.</i>”\n\n");
		outputText("You feed the canine pepper into her mouth and Kath rolls it around before snapping her jaws shut and giving you a spicy peck on the cheek.  Quickly, she " + clothesLowerChoice("slips off her pants", "raises her skirt and slips off her panties", "open the folds of her bodysuit", "raises her skirt and slips off her panties", "unties her robe and slips off her panties") + ", exposing her barbed prick" + cockMultiple("", "s") + ".\n\n");
		outputText("The pepper doesn't disappoint and you watch the magic stretch her cock" + cockMultiple("", "s") + " outwards, absorbing " + cockMultiple("its", "their") + " barbs.  Kath once again sports a " + cockMultiple("", "pair of") + cockAdj() + " canine cock" + cockMultiple("", "s") + " and a happy, horny grin to go with " + cockMultiple("it", "them") + ".");
		flags[kFLAGS.KATHERINE_DICK_FORM] = 0;
		player.consumeItem(consumables.CANINEP);
	}
	katSexMenu();
}

//Double Pepper
private function giveKatADoublePepper():void {
	clearOutput();
	if (!hasCock()) {
		outputText("You hold out your double canine pepper and ask if she'd like to eat it.\n\n");
		outputText("“<i>I'm pretty sure that won't have any effect on me,</i>” she replies.  “<i>But they do taste nice, so as long as you don't mind...</i>”  She smiles and and takes the pepper, munching it down.  With a moan she " + clothesLowerChoice("pushes a hand down her shorts", "hikes up her skirt", "opens the folds of her bodysuit", "hikes up her dress", "parts her robe") + " and starts rubbing her clit.\n\n");
		outputText("“<i>Oh please " + playerText() + ", don't leave me to deal with this feeling on my own.</i>”");
	}
	else if (cockNumber == 1) {
		outputText("You hold out your double canine pepper and ask if she'd like to eat it.\n\n");
		outputText("“<i>Double your fun, huh?  Okay... this is a really weird thing, but if it makes you happy,</i>” she notes.  She takes the pepper and, pausing only to " + clothesLowerChoice("slip her pants down", "raise her skirt and slip off her panties", "open the folds of her bodysuit", "raise her skirt and slip off her panties", "untie her robe and slip off her panties") + " to expose her sheath, polishes the pepper off with a smack of her lips for good measure.  “<i>Mmm... Not bad.  Oh!</i>”  She gasps and then arches her back suddenly.\n\n");
		outputText("Your gaze goes to her crotch, where her " + cockType("canine", "kitty") + " cock slides free with deceptive slowness, crowning itself at " + cockLength + " inches and filling its knot to " + knotSize + " inches thick as it pops free.  ");
		if (!hasDogCock()) {
			outputText("At the same time her cock stretches outwards, absorbing its barbs.  In a few moments Kath is once again sporting a " + cockAdj() + " canine cock.  ");
			flags[kFLAGS.KATHERINE_DICK_FORM] = 0;
		}
		outputText("Then the sheath's opening stretches even wider as a second distinctive tip pops up, sliding up and out until she is sporting two bulging dog-cocks, each exactly the same size as the other.  She reaches down and gently strokes one with each hand, casting you a come hither look.\n\n");
		cockNumber = 2;
	}
	else {
		outputText("Katherine looks at the twinned peppers with a puzzled expression.  ");
		if (!hasDogCock()) {
			outputText("“<i>You want me to go back to the way I was?</i>”\n\n");
			outputText("You tell her you think she looks good with either cat cocks or dog cocks and right now you’re in the mood for doggystyle - in a manner of speaking.  Besides, you know she loves peppers.  Kath takes the pepper and gives you a big smile.");
		}
		else {
			outputText("“<i>Uh... you do know that it won't make me grow any more cocks, right?  Two's the limit from this thing, as far as I know.</i>”\n\n");
			outputText("You tell her you think she could use a good meal, and you know how much she likes peppers.  The cat gives you a nervous smile and accepts the double pepper.");
		}
		outputText("She eats it daintily, swallows, and then develops a peculiar expression.  As she pants loudly, you can see her cocks starting to " + clothesLowerChoice("poke out of her pants", "lift the edge of her skirt", "stretch the thin fabric of her bodysuit", "lift the edge of her dress", "part the folds of her robe"));
		if (!hasDogCock()) {
			outputText(".  The tips begins to change, expanding and losing their feline barbs.  In a few moments Kath is once again sporting a set of twin " + cockAdj() + " canine cocks");
			flags[kFLAGS.KATHERINE_DICK_FORM] = 0;
		}
		outputText(".\n\n“<i>Oh dear...  I think that was maybe a bit too spicy.  You want to help me out with this?</i>” she purrs, already starting to stroke her twin shafts.\n\n");
	}
	dynStats("lus", 10 + player.lib / 20);
	player.consumeItem(consumables.DBLPEPP);
	katSexMenu();
}

//Overly Large Pepper
private function giveKatAOverlyLargePepper():void {
	clearOutput();
	var kathSubEnough:Boolean = submissiveness() >= 4 || (submissiveness() >= 2 && flags[kFLAGS.KATHERINE_URTA_TIMES_SEX] > 0); //May as well test this just once
	if (!hasCock()) {
		outputText("You wave an overly large canine pepper in front of Katherine's nose and she drinks in the spicy scent.\n\n");
		outputText("“<i>I'm pretty sure that won't have any effect on me,</i>” she says.  “<i>But they do taste nice, so as long as you don't mind...</i>”  She smiles and and takes the pepper, munching it down.  With a moan she " + clothesLowerChoice("pushes a hand down her shorts", "hikes up her skirt", "opens the folds of her bodysuit", "hikes up her dress", "parts her robe") + " and starts rubbing her clit.\n\n");
		outputText("“<i>Oh please " + playerText() + ", don't leave me to deal with this feeling on my own.</i>”");
		dynStats("lus", 10 + player.lib / 20);
		player.consumeItem(consumables.LARGEPP);
		katSexMenu();
	}
	else if (cockLength < 16) {
		outputText("You ask if Katherine would really like to make her cock bigger, holding up the overly large canine pepper from your inventory.\n\n");
		outputText("“<i>Yes!  Please!</i>” she says, clearly excited.  She snatches it from your hands and wolfs it down noisily, licking her fingers and then pulling her pants down with obvious excitement.  Her cock" + cockMultiple("", "s") + " immediately thrust" + cockMultiple("s", "") + " from her sheath, growing to full size and then a full two inches further before stopping.  ");
		if (!hasDogCock()) {
			if (cockNumber > 1)
				outputText("At the same time they stretch outwards, absorbing their barbs.  In a few moments Kath is once again sporting a pair of " + cockAdj() + " canine cocks.  ");
			else outputText("At the same time it stretches outwards, absorbing its barbs.  In a few moments Kath is once again sporting a " + cockAdj() + " canine cock.  ");
			flags[kFLAGS.KATHERINE_DICK_FORM] = 0;
		}
		outputText("She moans softly, licks her lips and smiles at you.  “<i>Care to have a test run?  Be a shame to let the chance go to waste...</i>” she purrs.\n\n");
		dynStats("lus", 10 + player.lib / 20);
		cockLength += 2;
		if (cockLength > 16) cockLength = 16;
		player.consumeItem(consumables.LARGEPP);
		katSexMenu();
	}
	else if (cockLength < 20 && kathSubEnough) {
		outputText("She looks at the pepper eagerly, then visibly reins herself in.  “<i>I'm sorry...  I really would like to eat it, but I have to be practical,</i>” she says.\n\n");
		outputText("You step forward, putting a finger on her lips to silence her.  You trace that finger down her body, slowly dragging it between her breasts and over her navel until it reaches the " + cockMultiple("root of her prick. A bit of gentle rubbing and her shaft begins", "little hollow between the roots of her pricks.  A bit of gentle rubbing and her shafts begin") + " to rise, drawing moans of pleasure from your lover.\n\n");
		if (flags[kFLAGS.KATHERINE_URTA_TIMES_SEX] > 0) {
			outputText("You ask Katherine if she thinks you love Urta.\n\n");
			outputText("She wriggles under your finger and answers, “<i>Yes, of course.  But I don’t need to be as big as Urta.</i>”\n\n");
			outputText("You keep rubbing and slowly push Kath back until she’s up against the wall.  You tell her Urta could use a friend in the Watch, someone who really understands what it’s like to have such a huge... burden.\n\n");
			outputText("Kath’s tail flicks against the wall.  She opens her mouth to say something and your free hand pops the pepper between her lips.  She freezes and you remind her how good it will taste, how nice it will feel when her " + cockMultiple("dick gets", "dicks get") + " even bigger.\n\n");
		}
		else {
			outputText("You tell Katherine that you've been right so far.  Every extra inch of cock has made her sexier.  You love that cute, embarrassed look on her face when she tries to hide her huge schlong" + cockMultiple("", "s") + " from view.\n\n");
			outputText("She wriggles under your finger and finally says, “<i>I guess I can do it... I'll do it for you.</i>”\n\n");
			outputText("You keep rubbing and slowly push Kath back until she’s up against the wall.  You tell her that you want her to do this for <b>her</b>.  You want her to see how much fun a " + cockMultiple("massive cock", "pair of massive cocks") + " can be.  Then you press the pepper against her lips until she opens her mouth and allows you to rub it against her tongue.\n\n");
		}
		outputText("She stares into your eyes and you say, “<i>I love you.</i>”\n\n");
		outputText("Kath crunches down on the pepper, pulls it from your fingers and wolfs it down.  Beneath her clothes you see the " + cockMultiple("bulge", "twin bulges") + " expanding.  Kath gives you a pained smile as her genitals balloon inside her panties.\n\n");
		outputText("With the transformation complete Kath quickly disrobes to get a better look at her new cock" + cockMultiple(".  It is", "s.  They are") + " indeed larger, having gained a good two inches in length.");
		if (!hasDogCock()) {
			outputText("  The effects of the pepper have also changed " + cockMultiple("it", "them") + " back into canine cocks.");
			flags[kFLAGS.KATHERINE_DICK_FORM] = 0;
		}
		outputText("  Kath smiles and strokes " + cockMultiple("her", "each") + cockAdj() + "shaft with one hand" + cockMultiple(" while straightening her tail with the other", "") + ".\n\n");
		outputText("“<i>I wasn’t sure I wanted this, but it feels good.  Do you like it?</i>” she asks, " + cockMultiple("pointing her cock", "leveling both her cocks") + " at you.  “<i>Maybe you could show me how much, hmmm?  Be a shame to let the chance go to waste...</i>” she purrs.\n\n");
		dynStats("lus", 10 + player.lib / 20);
		addSubmissive(KBIT_SUB_GROW_BIG_DICK); //Have made her supersize her cock(s) at least once
		cockLength += 2;
		if (cockLength > 20) cockLength = 20;
		player.consumeItem(consumables.LARGEPP);
		katSexMenu();
	}
	else if (kathSubEnough) { //Too big, even for submissive Kath
		outputText("She looks at the pepper and then looks down at her already enormous package.  “<i>Please " + playerText() + "</i>” she cries, getting to her knees.  “<i>I can’t get any bigger. I know you want me to have " + cockMultiple("a massive cock", "a pair of massive cocks") + " but I’m already so big.  I have to be careful when I stretch - otherwise I’ll topple forward into the ground.  If I smell whisker fruit or a woman in heat I start to feel faint!  I already grew as big as " + (flags[kFLAGS.KATHERINE_URTA_TIMES_SEX] > 0 ? "Urta" : "most centaurs") + " for you " + playerText() + ", please don’t make me grow any more.</i>”\n\n");
		outputText("She puts her arms around your legs and adds, “<i>I know I can satisfy you.  Let me show you.</i>”");
		katSexMenu();
	}
	else if (flags[kFLAGS.KATHERINE_UNLOCKED] >= 4) {
		outputText("She looks at the pepper eagerly, then visibly reins herself in.  “<i>I'm sorry...  I really would like to eat it, but I have to be practical.  I'm nearly a foot and a half long already!  Momma didn't raise me to be a size queen, and I’m almost as long as Urta.  I mean I like Urta, I just don’t think I need a cock quite that big,</i>” she says.\n\n");
		outputText("“<i>It is nice to know you’re thinking of me,</i>” she adds, quickly trying to make nice with you.");
		if (kGAMECLASS.urta.urtaFuckbuddy()) outputText("She did hesitate for a second... if you convince Kath to do a few other things she's unsure of she might be willing to munch on another pepper.");
		katherineMenu();
	}
	else {
		outputText("She looks at the pepper eagerly, then visibly reins herself in.  “<i>I'm sorry...  I really would like to eat it, but I have to be practical.  I'm nearly a foot and a half long already!  Momma didn't raise me to be a size queen, and if I get much longer I'll be like that poor sap who leads the guard - can't get a date because there's nobody big enough for me to stick my cock in,</i>” she declares, crossing her arms and looking firm.\n\n");
		outputText("“<i>Though if you have anything else you're thinking of giving, I'm sure we can salvage the gesture.  Otherwise, thank you for thinking of me,</i>” she adds, quickly trying to make nice with you.");
		katherineMenu();
    }
}

private function giveKatDefurFormula():void {
	clearOutput();
	outputText("You pull out the ingredients and lay them one by one on Katherine’s bed.  The succubus’ milk, the little golden seed and the deep black egg.  Kath watches with interest, finally asking, “<i>What’s all that for?</i>”\n\n");
	outputText("You explain that taken together these substances should alter her physique, making her look more human.\n\n");
	if (submissiveness() < 3) {
		outputText("Kath’s mouth falls open and puts a hand to her chest.  “<i>You want me to change what I am?  " + playerText() + ", I know you like me the way I am, otherwise why do you keep coming back?  I love you and I never asked you to change into a cat, even though I’ve heard humans can do that sort of thing.</i>”\n\n");
		outputText("She picks the items up and hands them back to you.  “<i>No, I love you a lot " + playerText() + ", but I don’t think I’m ready for that.  I’ll never be able to work up the courage to visit my parents if I’m not even their daughter anymore.</i>”\n\n");
		outputText("She takes your hands and rubs them against her face and whiskers, presses them to her breasts and then holds them to her hips.  “<i>Are you sure you don’t like me this way?</i>”");
		outputText("She did hesitate for a second... if you convince Kath to do a few other things she's unsure of she might be willing to shed her fur for you.");
		katSexMenu();
		return;
	}
	if (doneSubmissive(KBIT_SUB_CAT_GIRL)) //Already been changed to cat girl and changed back
		outputText("She hugs you and says, “<i>Mmmm, that’s what I thought.  Guess you need another taste of home, huh?  Well I did enjoy it last time, so why not?</i>”");
	else { //First time
		outputText("Kath’s mouth falls open and puts a hand to her chest.  “<i>You want me to change what I am?</i>”  You nod.\n\n");
		outputText("She asks, “<i>But " + playerText() + ", I know you like me the way I am, otherwise why do you keep coming back?</i>”  You tell her you do enjoy every minute you spend with her, but this could make things even better.\n\n");
		outputText("Tears well up in the corners of Kath’s eyes.  “<i>I love you and I never asked you to change into a cat, even though I’ve heard humans can do that sort of thing.</i>”  You ask her how many humans she’s run into in Tel’Adre?  Every day you see goblins, imps, bees, canines, cats, centaurs, equines... the list goes on.  But how often do you see anything that reminds you of your village and the world you came from?\n\n");
		outputText("Kath wipes away her tears.  “<i>I never thought of it like that.  Well... I guess I can do it for you.  If I start reminding you of home then that will make me feel special.</i>”  ");
		if (player.cor < 25)
			outputText("Now you have to wipe away some tears.  You’re so happy that Katherine is willing to do this for you.  You know you’re going to have to find ways to make it up to her.");
		else if (player.cor < 75)
			outputText("On the one hand you are a bit worried about what this will do to Kath, mentally as well as physically.  On the other hand the thought of seeing your little kitty humanized is really turning you on");
		else outputText("You work to hide how much this is turning you on.  You’re going to get this sweet little kitty to change what she <b>is</b>.  Her own family isn’t going to recognize her and the silly bitch is doing it for ‘luv’.");
	}
	outputText("\n\nYou ask for a rasp and some kind of container.  Kath fetches a rasp and a small drinking cup from the kitchen.  You crack the egg into the cup and then pour in some of the succubus’ milk.  You take the golden seed and scrape little shavings into the cup.  Finally you swish the cup around until the shavings dissolve and the mixture stops bubbling.\n\n");
	if (doneSubmissive(KBIT_SUB_CAT_GIRL))
		outputText("Kath strips off her clothes and walks to the corner of the room, swaying her hips ever so seductively.  She sits in the corner and waits for you to sit down next to her.  She takes the cup from you and tips it back like she’s finishing a shot of vodka.\n\n");
	else { //First time
		outputText("Meanwhile Kath has stripped off her clothes.  Kath takes the cup and sits on the bed.  Just before she takes a sip she stops.  “<i>This stuff is going to get rid of my fur, right?</i>”  She stands up and goes to a bare corner of the room.  “<i>If it all falls out I am never getting it out of the sheets.</i>”  She sits down on the floor and tips the drinking cup back like she’s finishing a shot of vodka.\n\n");
		outputText("You sit down next to her and wait for the changes.\n\n");
	}
	outputText("It doesn’t take long before Kath starts to rub her palms against each other.  She shudders and her paws reform, her digits lengthen and soon she has almost entirely human hands.\n\n");
	outputText("Kath is still staring at her new human fingernails when the fur starts to fall off her hands, then her arms, torso and legs.  She brushes herself off and you can see the fur has disappeared from everywhere except her ears, tail and groin.  The " + hairColor + " hair on her head is also unaffected by the concoction.\n\n");
	outputText("“<i>It feels so weird,</i>” she says in a whisper.  Instead of fur her body is now covered in milky white skin.  As she stares at her own arm another change begins.  “<i>Ahh,</i>” says Katherine as her nose twitches like that of a rabbit.  It warps as if being manipulated by some unseen sculptor.  When it finally stops twitching Kath has a human nose and beneath it a human mouth - only the little fangs give a clue that it was once different.\n\n");
	outputText("Once she’s convinced the changes are over Kath stands up carefully and brushes off the last errant clumps of her fur.  She walks over to the mirror as if in a trance and begins to study herself.  ");
	if (doneSubmissive(KBIT_SUB_CAT_GIRL)) {
		outputText("“<i>Even though I’ve done this before it’s hard to wrap my head around how different every little thing feels,</i>” she says, sliding her fingers over the skin of her naked breasts and down her belly.\n\n");
		outputText("She skips across the floor and throws herself into your arms.  “<i>Well " + playerText() + " I hope you enjoy another taste of home.  And I hope you want to make love to me again and again because my body might look human but my libido is all feline.</i>”\n\n");
	}
	else { //First time
		outputText("“<i>That’s so different,</i>” she says, twisting and turning in place and touching her still furry ears, “<i>and yet it’s still mostly the same.</i>”\n\n");
		outputText("Of course Katherine being Katherine she soon slides a hand over her newly naked breasts.  “<i>Oh we are going to have to do a lot of experimenting " + playerText() + ".  Everything feels so different!  Even...</i>” she sweeps her hand through the air, “<i>even the air feels different now.</i>”\n\n");
		outputText("She gives you a big hug and says, “<i>I’m going to have some explaining to do at work tomorrow.  And I’m going to have to get used to how all my clothes feel now.</i>”  She runs her hands down your back until she can squeeze your ass, then says, “<i>But right now I <b>really</b> want to find out how something else feels.</i>”\n\n");
	}
	furry = false;
	addSubmissive(KBIT_SUB_CAT_GIRL); //Have defurred her at least once
	dynStats("lus", 10 + player.lib / 20);
	player.consumeItem(consumables.P_S_MLK);
	player.consumeItem(consumables.GLDSEED);
	if (player.hasItem(consumables.BLACKEG))
		player.consumeItem(consumables.BLACKEG);
	else player.consumeItem(consumables.L_BLKEG);
	katSexMenu();
}

private function giveKatAKnottyPepper():void {
	//Kath can now regrow her knot. At first she’s willing to regrow it to 4", at submissiveness 1 she //will regrow it to its original 6" size.
	clearOutput();
	outputText("You show Kath the knotted canine pepper and ask if it brings back any memories.\n\n");
	if (!hasCock()) {
		outputText("“<i>I'm pretty sure that won't have any effect on me,</i>” she says.  “<i>But they do taste nice, so as long as you don't mind...</i>”  She smiles and and takes the pepper, munching it down.  With a moan she " + clothesLowerChoice("pushes a hand down her shorts", "hikes up her skirt", "opens the folds of her bodysuit", "hikes up her dress", "parts her robe") + " and starts rubbing her clit.\n\n");
		outputText("“<i>Oh please " + playerText() + ", don't leave me to deal with this feeling on my own.</i>”");
		dynStats("lus", 10 + player.lib / 20);
		player.consumeItem(consumables.KNOTTYP);
	}
	else if (knotSize >= 6) { //Original size - it won’t grow any further
		outputText("Kath gestures towards her cock" + cockMultiple("", "s") + " and says, “<i>I don’t think it can get any bigger.  I ate a ton of those peppers all at once and they never pushed me past this.</i>”\n\n");
		outputText("She takes the pepper and examines it more closely and then pops it in her mouth.  Once she’s finished chewing she adds, “<i>They do taste good.</i>”  She looks at you again and says, “<i>Thank you " + playerText() + "; even though I’m not starving in an alley anymore that sure hit the spot.</i>”\n\n");
		if (hasDogCock())
			outputText("Kath sits there and you watch for a short while, but the only indication that she just ate a magic imbued pepper " + cockMultiple("is her rock solid erection.", "are her rock solid twin erections."));
		else {
			outputText("Just as she finishes speaking Kath’s eyes go wide and she crosses her legs.  ");
			if (cockNumber > 1)
				outputText("Her cocks stretch outwards, absorbing their barbs and getting fatter along their whole length.  In a few moments Kath is once again sporting a pair of " + cockAdj() + " canine cocks.");
			else outputText("Her cock stretches outwards, absorbing its barbs and getting fatter along its whole length.  In a few moments Kath is once again sporting a " + cockAdj() + " canine cock.");
			flags[kFLAGS.KATHERINE_DICK_FORM] = 0;
		}
		dynStats("lus", 10 + player.lib / 20);
		player.consumeItem(consumables.KNOTTYP);
	}
	else if (knotSize >= 4) { //Need submissiveness 1+ to grow
		outputText("Kath takes the pepper a little uncertainly.  “<i>It brings back some good memories, from after I met you; it also brings back memories of being an outcast among my own kind.</i>”\n\n");
		outputText("She tries to give the pepper back but you close your hand around hers and tell her to concentrate on the good memories.  She knows you won’t think she’s ugly.  The two of you got along just fine when she had a massive knot.  In a way it’s what brought you two together." + (flags[kFLAGS.KATHERINE_URTA_AFFECTION > 10] ? "  Besides, wouldn’t it be fun to share it with Urta?" : "") + "\n\n");
		if (submissiveness() < 1) {
			outputText("Kath shakes her head and says, “<i>I don’t know if I’m ready for that.  I spent so long hating my giant knot.</i>”\n\n");
			outputText("You tease her 4\" knot" + cockMultiple("", "s") + " with your fingers.  Kath’s body wriggles and she smiles at you but she pushes the pepper back into your free hand.\n\n");
			outputText("“<i>Maybe some other time love,</i>” she says, “<i>right now I’ve got something else on my mind.</i>”\n\n");
			outputText("She did hesitate for a second... if you convince Kath to do a few other things she's unsure of she might be willing to munch on another pepper.");
		}
		else {
			outputText("Kath takes the pepper and then hugs you close.  “<i>Okay " + playerText() + ", I’m doing this for you.  If you think I’m more fun with a giant size knot...</i>” she slowly bites into the pepper and swallows it down, “<i>... then so be it.</i>”");
			if (!hasDogCock()) {
				outputText("\n\nJust as she finishes speaking Kath’s eyes go wide and she crosses her legs.  ");
				if (cockNumber > 1)
					outputText("Her cocks stretch outwards, absorbing their barbs and getting fatter along their whole length.  In a few moments Kath is once again sporting a pair of " + cockAdj() + " canine cocks.");
				else outputText("Her cock stretches outwards, absorbing its barbs and getting fatter along its whole length.  In a few moments Kath is once again sporting a " + cockAdj() + " canine cock.");
				flags[kFLAGS.KATHERINE_DICK_FORM] = 0;
			}
			outputText("\n\nIt takes almost a minute before Kath’s knot" + cockMultiple(" reacts", "s react") + " to the pepper.  When the change comes it happens quickly - her knot" + cockMultiple(" just inflates", "s just inflate") + " without any fanfare, gaining a few inches.\n\n");
			outputText("Kath watches it happen almost without any reaction.  You would guess she’s eaten so many her body has developed a resistance to the effects.  Apart from the knot" + cockMultiple(", which is throbbing slowly, the only indication that she just ate a magic imbued pepper is her rock solid erection.", "s, which are throbbing slowly, the only indications that she just ate a magic imbued pepper are her rock solid twin erections."));
			knotSize += 2;
			if (knotSize > 6) knotSize = 6;
			addSubmissive(KBIT_SUB_GROW_KNOT); //Have regrown her knot to full size at least once
			dynStats("lus", 10 + player.lib / 20);
			player.consumeItem(consumables.KNOTTYP);
		}
	}
	else { //Knot is < 4", Always willing to grow if you ask
		outputText("Kath takes the pepper and laughs.  “<i>How could I forget?  I don’t even remember how many of these I ate trying to make my cock just a bit bigger.</i>”  She rubs the base of " + cockMultiple("her cock", "one cock then the other") + " and says, “<i>You want me to fill out a bit more?  Does it feel good when I knot you?</i>”\n\n");
		outputText("You just smile and Kath licks the pepper experimentally.  “<i>I never thought I’d eat another one of these,</i>” she says.  She shakes her head before popping the pepper into her mouth.  Apart from her cock" + cockMultiple("", "s") + " standing to attention nothing seems to happen but Kath smiles and says, “<i>Yeah, I can feel it.  When " + cockMultiple("this bad boy kicks in my knot is", "these bad boys kick in my knots are each") + " going to puff out to the size of an apple.</i>”\n\n");
		if (!hasDogCock()) {
			outputText("Just as she finishes speaking Kath’s eyes go wide and she crosses her legs.  ");
			if (cockNumber > 1)
				outputText("Her cocks stretch outwards, absorbing their barbs and getting fatter along their whole length.  In a few moments Kath is once again sporting a pair of " + cockAdj() + " canine cocks.");
			else outputText("Her cock stretches outwards, absorbing its barbs and getting fatter along its whole length.  In a few moments Kath is once again sporting a " + cockAdj() + " canine cock.");
			flags[kFLAGS.KATHERINE_DICK_FORM] = 0;
		}
		outputText("It takes almost a minute before Kath’s knot" + cockMultiple(" reacts", "s react") + " to the pepper.  When the change comes it happens quickly - her knot" + cockMultiple(" just inflates", "s just inflate") + " without any fanfare, gaining a few inches.\n\n");
		outputText("Kath watches it happen almost without any reaction.  You would guess she’s eaten so many her body has developed a resistance to the effects.  Apart from the knot" + cockMultiple(", which is slowly shrinking, the only indication that she just ate a magic imbued pepper is her rock solid erection.", "s, which are slowly shrinking, the only indications that she just ate a magic imbued pepper are her rock solid twin erections."));
		knotSize += 2;
		if (knotSize > 4) knotSize = 4;
		dynStats("lus", 10 + player.lib / 20);
		player.consumeItem(consumables.KNOTTYP);
	}
	if (hasCock()) outputText("\n\nHer tail flicks against your leg.  She looks down at her erection" + cockMultiple("", "s") + ", looks to you and then looks back at her erection" + cockMultiple("", "s") + " again.");
	katSexMenu();
}

private function usePinkEggOnKath():void {
	clearOutput();
	if (cockNumber == 1) {
		outputText("You show Katherine the pink egg and tell her that eating it would make her all woman.\n\n");
		if (submissiveness() < 6) {
			outputText("Kath shakes her head and says, “<i>I don’t really want to lose this " + playerText() + ".  I hope you understand, I mean I was born a herm and it’s kind of part of me.</i>”\n\n");
			katherineMenu();
			return;
		}
		else {
			if (doneSubmissive(KBIT_SUB_REM_COCK)) {
				outputText("Kath strokes her cock fondly but she takes the egg without complaint.  She");
			}
			else {
				outputText("Kath shakes her head and says, “<i>I don’t really want to lose this " + playerText() + ".  I hope you understand, I mean I was born a herm and it’s kind of part of me.</i>”\n\n");
				outputText("You rub her ears and tell her that you know it's something she's never been without - but it's easy enough to grow back.  Purified incubus drafts have got to be one of the most common potions they sell in Tel'Adre's shops.  Plus, she'll finally get to find out what it's like to be a woman and just a woman.  You ask her how many times, growing up, did she wonder at how it might feel?\n\n");
				outputText("Kath doesn't answer immediately.  She strokes her cock fondly and finally says, “<i>I guess you're right... and I have always wondered.  I just figured it'd be too expensive.</i>”\n\n");
				outputText("You hand her the egg and tell her that today the cost of solving a lifetime of mystery is nothing at all.\n\n");
				outputText("Kath gives you a worried smile but takes the egg and looks it over.  Finally, she");
				addSubmissive(KBIT_SUB_REM_COCK); //Have removed her cock at least once
			}
			outputText(" cracks it open and gulps it down.  You both watch her semi-erect shaft for signs of a change.  Kath lets out a strangled “<i>Meyowr!</i>”  Her eyes squeeze shut and you smile as her cock retracts into her body" + (hasBalls() ? ", dragging her balls inward as it goes" : "") + ".  A huge spurt of wasted cum drenches the floor but Kath is so caught up in the transformation that she barely notices.  In seconds there's nothing left of her male half and her pussy shifts upwards slightly, becoming more prominent.  Katherine's legs fall open and her slit glistens invitingly.\n\n");
			outputText("When she recovers Kath pants, “<i>Well, I'm all woman, just like you wanted.  Now please, please take me!  I'm feeling super horny right now, like there's something I've got to get out of my system.</i>”");
			cockLength = 6; //This ensures it will pass all the small size checks for different outfits. Cock length should never be set to zero.
			cockNumber = 0;
			ballSize   = 0;
			knotSize   = 2;
		}
	}
	else {
		outputText("You show Katherine the pink egg and tell her it could be used to reduce her back to just one cock.\n\n");
		outputText("She takes the egg and thinks about it for a second before replying.  “<i>Okay, it always did feel a little weird having two cocks.  Sometimes it felt nice too, but if you think I look better with just one then I’ll give this a shot.</i>”\n\n");
		outputText("Kath carefully cracks open the egg and downs the contents in one gulp.  She has time to wipe her mouth and say, “<i>kind of sugary,</i>” before you hear a loud grumble from her belly.  Kath grabs the knots of her cocks as they both swell to full size.  The two knots seem to stick together like they’re coated with gum or resin.  Then, before your eyes they begin to knit back together.  Kath moans as the effect spreads up the length of her cocks.  In less than a minute Katherine is left with a single " + cockType("doggy dick", "kitty cock") + " where once there were two.\n\n");
		outputText("“<i>Wow - I thought that would hurt at least a little.  It just tickled like crazy and now it feels like someone’s been rubbing my cock.</i>”  Katherine smiles at you and adds, “<i>I could really use a hand getting this thing back under control " + playerText() + ".</i>”");
		cockNumber = 1;
	}
	if (player.hasItem(consumables.PINKEGG))
		player.consumeItem(consumables.PINKEGG);
	else player.consumeItem(consumables.L_PNKEG);
	katSexMenu();
}

private function useIncubiDraftOnKath():void {
	clearOutput();
	if (!hasCock()) {
		outputText("You show Kath the bottle of Incubi Draft and tell her that it’s been purified.  Kath takes it eagerly and examines the cloudy liquid.\n\n");
		outputText("“<i>Mmmm - I can't wait.  I don't even know what hole I want to fuck first.  Thank you so much " + playerText() + "</i>”\n\n");
		outputText("She strips off her clothes in record time and downs the bottle in a single swig.  She closes her eyes, uses her fingers to trace the outline of her pussy lips and says “<i>Not long now, I can feel it coming.</i>”\n\n");
		outputText("Her hips launch upward as a bulge forms in the skin above her slit.  Her pussy is pushed downward, making space as the bulge stretches and stretches, soon taking the form of an evil looking purple demon cock.  As Kath pants and recovers the cock changes shape.  For a moment it looks human, then it assumes a more familiar canine outline, with a knot puffing out near Katherine's groin.\n\n");
		flags[kFLAGS.KATHERINE_DICK_FORM] = 0;
		cockNumber = 1;
		outputText("The cock stands at about 6\" long and shows no signs of softening.  “<i>A doggie dick again?</i>” she says, “<i>Man I <b>really</b> ate a lot of those peppers.</i>”");
		if (!doneSubmissive(KBIT_SUB_REM_BALLS)) {
			addSubmissive(KBIT_SUB_REM_BALLS);
			outputText("  Kath strokes her brand new erection, then her eyes pop open and she says, “<i>Wait a minute - where are my balls?</i>”\n\n");
			outputText("  You have to laugh and remind her that many herms lack external testes.\n\n");
			outputText("  She rubs the bare skin below her cock but above her clit and says, “<i>That's going to take some getting used to.</i>”");
		}
		outputText("\n\nKath aims her shaft at you and asks, “<i>You have time to help me test this little pecker out, right?</i>”");
	}
	else {
		var kathSubEnough:Boolean = submissiveness() >= 4 || (submissiveness() >= 2 && flags[kFLAGS.KATHERINE_URTA_TIMES_SEX] > 0); //May as well test this just once
		outputText("You show Kath the bottle of Incubi Draft and tell her that it’s been purified.  A single bottle should be enough to add an inch or two to her " + cockType("canine member", "kitty cock") + ".  \n\n");
		if (cockLength < 16) {
			cockLength += 2;
			if (cockLength > 16) cockLength = 16;
			outputText("Kath takes it and eagerly examines the cloudy liquid.  “<i>Yes!  Please!</i>” she says, clearly excited.  She pops the cock, careful not to spill any of the strange liquid, then tips it back.  “<i>Mmmmm, salty!  But I can deal with that,</i>” she says suggestively.  She pulls down her pants so that you both have the chance to watch her shaft" + cockMultiple("", "s") + " twitch and stretch.  The magical fluid doesn't take long to do its work, and soon Kath is proudly rubbing her new " + cockLength + "\" shaft" + cockMultiple("", "s") + " between her fingers.  ");
			outputText("She moans and licks some of her precum off her fingertips.  In a low, seductive purr Kath says, “<i>" + playerText() + ", I think I got a bit of an incubus' appetite too.  Could we do something fun, maybe - oh, right now?</i>”");
		}
		else if (cockLength < 20 && kathSubEnough) {
			outputText("She looks at the bottle, rolling it from side to side in her hands, but then visibly reins herself in.  “<i>I'm sorry " + playerText() + "...  I have to be practical,</i>” she says, “<i>and on a little kitten like me a bigger cock is just going to be trouble.  I'll probably trip over myself.</i>”\n\n");
			outputText("You step forward and kiss her deeply to stop her.  You give her crotch a pat" + clothesLowerChoice(" through her tight shorts ", ", grinding her skirt against her concealed prick", " through her semi-transparent bodysuit", ", grinding her dress against her concealed prick", ", soon sliding your fingers inside her robe, allowing you to feel the swell developing in her tight panties") + " and say, “<i>Little kitten is overthinking this.  Bigger <b>is</b> better, at least where my lover's cock" + cockMultiple(" is", "s are") + " concerned.</i>”  A bit of gentle rubbing through her clothes and her shaft" + cockMultiple(" grows", "s grow") + " hot and stiff.\n\n");
			outputText("“<i>Too much,</i>” is her only reply.\n\n");
			if (flags[kFLAGS.KATHERINE_URTA_TIMES_SEX] > 0) {
				outputText("You ask Katherine if she thinks you love Urta.\n\n");
				outputText("She moans deeply and answers, “<i>Yes, of course.</i>”\n\n");
				outputText("You keep rubbing and slowly push Kath back until she’s up against the wall.  You tell her Urta could use a friend in the Watch, someone who really understands what it’s like to have such a huge... burden.\n\n");
				outputText("Kath’s tail flicks against the wall.  She opens her mouth to say something and you hold the bottle up in front of her eyes.  She freezes and you remind her how good it will taste, how nice it will feel when her " + cockMultiple("dick gets", "dicks get") + " even bigger.\n\n");
			}
			else {
				outputText("You tell Katherine that you've been right so far.  Every extra inch of cock has made her sexier.  You love that cute, embarrassed look on her face when she tries to hide her huge schlong" + cockMultiple("", "s") + " from view.\n\n");
				outputText("She wriggles under your finger and finally says, “<i>I guess I can do it... I'll do it for you.</i>”\n\n");
				outputText("You keep rubbing and slowly push Kath back until she’s up against the wall.  You tell her that you want her to do this for <b>her</b>.  You want her to see how much fun a " + cockMultiple("massive cock", "pair of massive cocks") + " can be.  Then you hold the bottle up in front of her eyes.\n\n");
			}
			cockLength += 2;
			if (cockLength > 20) cockLength = 20;
			addSubmissive(KBIT_SUB_GROW_BIG_DICK); //Have made her supersize her cock(s) at least once
			outputText("She stares at the thick, white fluid as though it's casting a spell on her.  She takes it, pops the cock and drinks it all.  She smiles and says, “<i>I love you.</i>”\n\n");
			outputText("You laugh and quickly strip off her clothes.  As her " + cockMultiple("cock comes", "twin shafts come") + " into view Kath gasps and you watch " + cockMultiple("it", "them") + " lengthen.  " + cockMultiple("It now sticks", "They now stick") + " out almost horizontally from Kath's crotch and you stroke " + cockMultiple("her shaft", "one, then the other") + " as Kath pants.  You would say she's now " + cockLength + "\" long" + cockMultiple("", "... twice over") + ".\n\n");
			outputText("Kath smiles and looks deep into your eyes, the hornyness written all over her face.  “<i>I wasn’t sure I wanted this, but it feels good.  Do you like it?</i>” she asks, “<i>maybe you could show me how much, hmmm?  Be a shame to let the chance go to waste...</i>”\n\n");
		}
		else if (kathSubEnough) { //Too big, even for submissive Kath
			outputText("She looks at the bottle and then looks down at her already enormous package.  “<i>Please " + playerText() + "</i>” she cries, getting to her knees.  “<i>I can’t get any bigger.  I know you want me to have " + cockMultiple("a massive cock", "a pair of massive cocks") + " but I’m already so big.  I have to be careful when I stretch - otherwise I’ll topple forward into the ground.  If I smell whisker fruit or a woman in heat I start to feel faint!  I already grew as big as " + (flags[kFLAGS.KATHERINE_URTA_TIMES_SEX] > 0 ? "Urta" : "most centaurs") + " for you " + playerText() + ", please don’t make me grow any more.</i>”\n\n");
			outputText("She puts her arms around your legs and adds, “<i>I know I can satisfy you.  Let me show you.</i>”");
			katSexMenu();
			return;
		}
		else if (flags[kFLAGS.KATHERINE_UNLOCKED] >= 4) {
			outputText("She looks at the bottle but closes her eyes and shakes her head.  “<i>I'm sorry...  I really would like a bigger " + cockMultiple("one", "pair") + ", but I have to be practical.  I'm nearly a foot and a half long already!  Momma didn't raise me to be a size queen, and I’m almost as long as Urta.  I mean I like Urta, I just don’t think I need a cock quite that big,</i>” she says.\n\n");
			outputText("“<i>It is nice to know you’re thinking of me,</i>” she adds, quickly trying to make nice with you.");
			outputText("She did hesitate for a second... if you convince Kath to do a few other things she's unsure of she might be willing to suck down another incubus draft.");
			katherineMenu();
			return;
		}
		else {
			outputText("She looks at the bottle but closes her eyes and shakes her head.  “<i>I'm sorry...  I really would like a bigger " + cockMultiple("one", "pair") + ", but I have to be practical.  I'm nearly a foot and a half long already!  Momma didn't raise me to be a size queen, and if I get much longer I'll be like that poor sap who leads the guard - can't get a date because there's nobody big enough for me to stick my cock in,</i>” she declares, crossing her arms and looking firm.\n\n");
			outputText("“<i>Though if you have anything else you're thinking of giving, I'm sure we can salvage the gesture.  Otherwise, thank you for thinking of me,</i>” she adds, quickly trying to make nice with you.");
			katherineMenu();
			return;
		}
	}
	dynStats("lus", 10 + player.lib / 20);
	player.consumeItem(consumables.P_DRAFT);
	katSexMenu();
}

private function giveKatPureSuccubusDelight():void {
	clearOutput();
	outputText("You show Kath the bottle of Succubi's Delight and tell her that it’s been purified.  Kath takes it and tips the bottle from side to side, examining the cloudy liquid inside.  ");
	if (!hasBalls()) {
		outputText("You tell her that now that she's without balls perhaps she could drink this to improve her sperm production.\n\n");
		outputText("She laughs.  “<i>As if I need it.  I already cum buckets, balls or no.</i>”  She takes another look at the bottle, pulls out the cork and sniffs it cautiously.  “<i>Well... I suppose there's no harm in giving this stuff a shot.</i>”\n\n");
		outputText("Kath tips back the bottle.  When there's no immediate effect she looks at you and shrugs.  Then her tail starts to go wild and Kath drops the bottle, grabbing her own ass.  “<i>Yeep!  Oh, oh boy - that tickles.  It feels like someone rubbed a peach against my prostate.</i>”\n\n");
		outputText("She shifts her ass from side to side, concentrating intently.  “<i>It does feel a bit bigger.  Not swollen, just naturally bigger.</i>”\n\n");
		outputText("You give her a light smack on the ass and she hops into your arms, snuggling against your neck. “<i>Thank you " + playerText() + ", I can't wait to try it out.  I mean I really can't wait,</i>” she says, grinding her hardening cock" + cockMultiple("", "s") + " against you.");
		ballSize--; //Already 0 or less, so go lower
	}
	else if (ballSize < 5) {
		outputText("You ask if she's ever wanted to shoot longer, thicker streams of cum.  This stuff will give her giant gonads and enough seed to fill a wash tub.\n\n");
		outputText("Laughing and smiling at your sales pitch she replies, “<i>Oh, sure, why not?  Bigger balls have got to be better, right?</i>”  She gives you a friendly wink and then takes the bottle, pops the top and downs it in one motion.  With a moan " + clothesLowerChoice("and an arched back, she produces a new swell in her tight shorts as you look on", "she raises her skirt, allowing you to watch as she produces a new swell in her tight panties", "and an arched back, she produces a new swell in the crotch of her semi-transparent bodysuit", "she raises her skirt, allowing you to watch as she produces a new swell in her tight panties", "she unties her robe, allowing you to watch as she produces a new swell in her tight panties") + ", her balls visibly growing.  They roughly double in size, then stop, leaving the cat herm panting.  ");
		outputText("She throws you a sultry look.  “<i>So... you wanna give them a test run?</i>” she purrs.");
		ballSize += 2;
		if (ballSize > 5) ballSize = 5;
    }
	else if (submissiveness() >= 4 && ballSize < 9) {
		addSubmissive(KBIT_SUB_GROW_BIG_BALLS); //Have made her supersize her balls at least once
		ballSize += 2;
		if (ballSize > 9) ballSize = 9;
		outputText("She looks at the bottle and then shakes her head.  “<i>No thank you.  Any bigger and I'm going to have trouble walking, and I think I make enough of a mess as it is.  Thanks for the offer, though.  Was there anything else?</i>” she adds, trying to be diplomatic.\n\n");
		outputText("You give Kath a big grin and tell her you’d like to see her grow larger.  Lots of people in Mareth have balls bigger than her and they can still move around.  You move closer and start to fondle her " + ballAdj() + " dangling orbs through her " + clothesLowerChoice("shorts", "skirt", "semi-transparent bodysuit", "dress", "robe") + ".\n\n");
		outputText("Kath pants as her " + cockMultiple("cock begins", "cocks begin") + " to harden.  “<i>I... I suppose I could try it.  As long as you still think I’m pretty.</i>”\n\n");
		outputText("You continue to massage her nuts and tell her that’s not enough.  She agreed so quickly that she must secretly want this.\n\n");
		outputText("Kath twists and turns in place, as if part of her wants to escape.  Finally, after a sharp intake of breath your obedient little " + catGirl("cat girl", "kitty") + " says, “<i>Yes.  Yes, " + playerText() + ", I want it.  If you want me to have bigger balls then I want them too.</i>”\n\n");
		outputText("You just smile and hand Kath the bottle.  She takes it and rips out the cork, drinking like she's dying of thirst.\n\n");
		outputText("It doesn’t take long before you feel her scrotum expand.  It throbs and pushes your fingers apart, each of her testes growing by about two inches.  They finally stop at " + ballSize + "\" across - each.  Bigger than even the stallions and bulls in your village.");
		outputText("Katherine wraps her arms around you for support.  When the change seems to have run its course she spreads her legs to accommodate her " + ballAdj() + " ballsack and whispers in your ear, “<i>So... you wanna give them a test run?</i>”");
	}
    else { //Too big
		if (submissiveness() >= 4) { //Too big even for submissive Kath
			outputText("She gets down on her knees and begs you.  “<i>Please " + playerText() + " - I already have problems whenever I try to chase criminals.  If they get any bigger I might lose my job.  Thank you for offering, but don’t these monsters make enough cum for us both?  Please can’t we do something else?</i>” she adds with a worried smile, trying to be diplomatic.");
			if (player.cor >= 75) {
				outputText("\n\nIt certainly would be fun to give your " + catGirl("cat girl", "feline") + " fucktoy such enormous balls that she wouldn’t be able to move.  On the other hand if she loses her job then you’ll have to take care of her.  Screw that - you still get all the sex you want from her as is and you don’t have to pay.\n\n");
				outputText("You scratch her ear and assure her it’s all right.  Kath purrs and presses against you, her cock" + cockMultiple(" beginning to slide from its sheath.", "s beginning to slide from their sheaths."));
			}
		}
		else {
			outputText("She looks at the bulbous pepper and then shakes her head.  “<i>No thank you.  Any bigger and I'm going to have trouble walking, and I think I make enough of a mess now as it is.  Thank you for the offer, though.  Was there anything else?</i>” she adds, trying to be diplomatic.\n\n");
			outputText("She did hesitate for a second... if you convince Kath to do a few other things she's unsure of she might be willing to take a drink.");
		}
		katherineMenu();
		return;
	}
	dynStats("lus", 10 + player.lib / 20);
	flags[kFLAGS.KATHERINE_HOURS_SINCE_CUM] += 24;
	player.consumeItem(consumables.PSDELIT);
	katSexMenu();
}

private function giveKatPureSuccubusMilk():void {
	clearOutput();
	var kathSubEnough:Boolean = submissiveness() >= 2;
	if (breasts.cupSize < CoC.BREAST_CUP_DD_BIG) { //She’s willing to go up to big DD-Cup normally
		outputText("You show Kath the bottle of Succubus’ Milk and tell her that it’s been purified.  Kath takes it and tips the bottle from side to side, examining the cloudy liquid inside.\n\n");
		outputText("“<i>So this stuff is supposed to make my breasts bigger.</i>”  She cups her " + breasts.adj() + " " + breasts.cup() + "s and asks “<i>");
		if (breasts.cupSize == CoC.BREAST_CUP_A)
			outputText("So you want me to go back to my natural size, huh?  Good stuff, I’m still not used to how small these mosquito bites are.");
		else if (breasts.cupSize == CoC.BREAST_CUP_D)
			outputText("What?  I’m <b>still</b> not big enough for you?");
		else outputText("I suppose I could try it.  If it’s been purified then there’s no harm in it, right?");
		outputText("</i>”\n\n");
		outputText("Kath quickly strips out of her clothes and stands in front of her mirror.  She grins at you and rips the cork out, downing the potion in one gulp.  She only has time to say, “<i>Oh, that tastes weird,</i>” before the magics of the milk reach her chest.\n\n");
		outputText("As if under the effects of a set of bellows her breasts balloon out, stretching her flesh taut.  After a few moments you see them soften, the skin magically expanding enough to accommodate its new contents.  Kath moans and feels her fuller, heavier rack.  “<i>");
		breasts.cupSize++;
		if (breasts.cupSize == CoC.BREAST_CUP_B) {
			outputText("Yes, yes, yes!  Oh does that ever feel good.</i>”\n\n");
			outputText("She turns and walks into your arms, hugging you against her new assets.  You feel her nipples start to harden and as you rub her back her tail begins to flick from side to side.\n\n");
		}
		else if (breasts.cupSize < CoC.BREAST_CUP_DD_BIG) {
			outputText("Mmmm yes, I always thought I could do with a bit more sand in the top of my hourglass.</i>”\n\n");
			outputText("Kath bounces up and down a few times and watches her new rack react to her motion.  She notices you watching, turns and walks into your arms, hugging you against her new assets.  You feel her nipples start to harden and as you rub her back her tail begins to flick from side to side.\n\n");
		}
		else { //She's now up to BREAST_CUP_DD_BIG
			outputText("Oof.  These puppies are a lot heavier" + (breasts.lactating() ? ", especially with the milk" : "") + ".  Now I understand why some girls complain about lower back problems.</i>”\n\n");
			outputText("She bounces up and down a few times and watches her new rack react to her motion.  “<i>Yeah, I can do this.  But I’ll need some stronger bras, that’s for sure.</i>”\n\n");
			outputText("She turns and walks into your arms, hugging you against her new assets.  “<i>The real question is how much I should adjust my clothes.  If I don’t alter them at least a little I’m going to pop right out of them.</i>”\n\n");
			outputText("You can feel Kath’s nipples starting to harden.  You point out that girls with big breasts do like to show them off, so maybe just enough changes to keep her from popping loose in public.\n\n");
			outputText("“<i>Okay " + playerText() + ", if you like the idea of your " + catGirl("girl", "feline lover") + " parading through town, drawing every eye, then I can certainly do that.</i>”\n\n");
			outputText("She starts to grind her breasts against you, then she shifts her hips forward and starts to grind her " + (hasCock() ? "cock" : "pussy") + " against you too.  She purrs and says, “<i>I’ve never had to push my hips this far forward to reach you.  I think I need to experiment a little to get the hang of it.</i>”\n\n");
		}
		outputText("Kath seems to be in a loving mood, why disappoint her?\n\n");
		dynStats("lus", 10 + player.lib / 20);
		player.consumeItem(consumables.P_S_MLK);
	}
	else if (breasts.cupSize < CoC.BREAST_CUP_EE && kathSubEnough) { //Allows E-Cup, big E-Cup and EE-Cup
		outputText("You tell Katherine to disrobe.  You have a present for her.  She hops on the bed and takes her clothes off slowly, giving you a nice little striptease.  When she’s finished you place the bottle of succubi’ milk in her hand.\n\n");
		outputText("“<i>But " + playerText() + " I’m so big ...</i>”\n\n");
		outputText("You cut her off by cupping her breasts in your hands.  She sucks in a breath as your thumbs begin to knead her nipples" + (breasts.lactating() ? ", drawing forth a few beads of cream" : "") + ".  You tell her that with every cup size she gets more attractive to you.  Kath squirms and moans but you keep rolling her engorged nipples around until you smell the girlcum beginning to drip from her vulva.\n\n");
		outputText("You tell her that deep down she wants to drink, she wants to see what will happen to her breasts with another dose.  Kath’s eyes open and she stares at you lustily.  Her hands move quickly, yanking the cork and dumping the milk into her mouth.\n\n");
		outputText("She swallows and asks, “<i>What have I done?</i>” before her " + (breasts.cupSize == CoC.BREAST_CUP_DD_BIG ? "tits" : "boobs") + " begin to swell beneath your fingers.  In just a few moments they " + (breasts.cupSize == CoC.BREAST_CUP_DD ? "are well and truly boobs" : "have expanded to epic proportions") + ".  “<i>Oh Marae!  I’m so top heavy.</i>”  Kath leans back and adjusts her posture to support her expanded rack.\n\n");
		outputText("You kiss her and work your fingers into her mammaries.  Kath mewls and asks, “<i>I suppose you want me to show these off, huh?</i>”  You squeeze a little harder" + (breasts.lactating() ? ", forcing out a bit more of her milk" : "") + ".  “<i>Okay " + playerText() + ".  When I’m off duty everyone in town will think I’m a big breasted slut.  Guys will try to hire me on the street.  But you’d better fuck me all the time, cause I’m going to be <b>horny</b>.</i>”\n\n");
		breasts.cupSize++;
		addSubmissive(KBIT_SUB_GROW_BIG_BOOBS); //Have grown her breasts to E-Cup or larger
		dynStats("lus", 10 + player.lib / 20);
		player.consumeItem(consumables.P_S_MLK);
	}
	else if (kathSubEnough) { //Too big, even for more submissive Kath
		outputText("You tell Katherine to disrobe.  You have a present for her.  She hops on the bed and takes her clothes off slowly, teasing you with her striptease.  When she’s finished you place the bottle of succubus’ milk in her hand.\n\n");
		outputText("“<i>But " + playerText() + " I’m so big ...</i>”\n\n");
		outputText("You try to cup her breasts but there’s so much titflesh you can’t even hold them in your hands.  Kath puts the succubus’ milk aside and says, “<i>See?  I’m so big you can’t even rub my whole chest at once.  Please don’t make me bigger " + playerText() + "; you’ll snap my spine.</i>”  She starts to peel off your clothes and adds, “<i>Let’s just pretend your " + (player.hasCock() ? "cock" : "love") + " was the present you wanted to give me.</i>”\n\n");
	}
	else { //Too big - she needs to be more submissive
		outputText("You show Kath the bottle of Succubus’ Milk and tell her that it’s been purified.  Kath takes it and tips the bottle from side to side, examining the cloudy liquid inside.\n\n");
		outputText("She cups her huge tits and says, “<i>I think maybe DD-cups are big enough.  Any more and I’m going to start looking like I spread my legs for a living.  Besides, even these puppies bounce like crazy whenever I have to chase criminals." + (breasts.lactating() ? "  I usually end up with my breastplate soaked by the time I catch them." : "") + "</i>”\n\n");
		outputText("Kath wraps her arms around you and rubs her whiskers against your face.  ");
		if (hasCock())
			outputText("You can feel her cock getting erect " + clothesLowerChoice("inside her pants", "under her skirt", "inside her bodysuit", "under her dress", "under her robe") + "; it");
		else outputText("It");
		outputText(" seems Kath appreciates the idea of the gift and wants to thank you in her usual way.\n\n");
		outputText("She did hesitate for a second... if you convince Kath to do a few other things she's unsure of she might be willing to suck down some more succubi's milk.");
	}
	katSexMenu();
}

private function giveKatTheGiftOFMilk():void {
	clearOutput();
	outputText("You pull out the small pink bottle of Lactaid and show it to Kath.  ");
	if (!doneSubmissive(KBIT_SUB_START_LACTATION)) {
		outputText("She takes the bottle gingerly and examines it carefully.  “<i>I don't know if I should... I know how desperate some cats can get for a taste of the real deal.  I've been trying to keep in touch with some people from the gang and that's going to get harder if I'm leaking cat milk.</i>”\n\n");
		outputText("You reach over, pull the cork from the lactaid bottle and gently push it towards her, telling Kath that you really want to find out what kind of ambrosia her breasts produce.\n\nKatherine sighs and says, “<i>If you want to try my milk that bad then I guess I can oblige.</i>”  ");
	}
	outputText("She " + clothesChoice("undoes her blouse", "opens the top half of her bodysuit", "undoes the upper half of her dress", "opens her robe", "lifts up her tube top", "undoes the buttons on her nurse's shirt") + " and removes her bra, exposing her breasts.\n\n");
	if (breasts.lactationLevel < BreastStore.LACTATION_MODERATE) { //Always willing to go up to moderate
		if (doneSubmissive(KBIT_SUB_START_LACTATION)) {
			outputText("“<i>You want more kitty milk?</i>” she asks playfully.  Taking the bottle and yanking the cork free she says, “<i>I suppose I can oblige, as long as you'll be here to take care of my needs.</i>”  With that she tips the bottle back and swallows the pink fluid in one gulp.\n\n");
		}
		else {
			outputText("Tossing back the bottle she adds, “<i>" + (submissiveness() >= 3 ? "Let's face it, I'm not very good at denying you anything" : "This will be different") + ",</i>” before looking down at her chest.\n\n");
			breasts.lactationLevel = BreastStore.LACTATION_NONE; //Initially Kath is at LACTATION_DISABLED. This way incrementing it will bring it to LACTATION_LIGHT
		}
		outputText("The two of you watch her breasts and it doesn't take long for the effects of the lactaid to kick in.  Kath's nipples engorge and her breasts plump up very slightly.  You cup them with your hands and feel a little extra weight.");
		if (breasts.cupSize < CoC.BREAST_CUP_D) {
			breasts.cupSize++;
			outputText("  You'd say she's a " + breasts.cup() + " now.");
		}
		outputText("  A few drops of thick white cream drip from Kath's nipples and she shudders involuntarily.\n\n");
		if (!doneSubmissive(KBIT_SUB_START_LACTATION)) {
			outputText("You collect a little with your finger and have a taste; it's rich and silky, like a fine cream that's teasing your tongue.\n\n");
			outputText("“<i>I hope you like it</i>”, says Kath.  “<i>I didn't think I'd be making milk until I had some kittens, but this could be fun.  My nipples are more sensitive, that's for sure - you feel like testing them out?</i>”\n\n");
		}
		addSubmissive(KBIT_SUB_START_LACTATION);
		milkOptionClear(KBIT_MILK_TOLD_PLAYER_SHES_DRY); //This resets the out of milk notification. If Kath runs out of milk she'll appologize to the player.
		if (breasts.lactationLevel == BreastStore.LACTATION_LIGHT && breasts.preventLactationIncrease == BreastStore.LACTATION_LIGHT) breasts.preventLactationIncrease = 0;
			//You're handing her the Lactaid, so obviously you want more milk
		if (!doneSubmissive(KBIT_SUB_HIGH_LACTATION)) breasts.preventLactationIncrease == BreastStore.LACTATION_MODERATE;
			//This limit will remain in place until you are able to feed her enough Lactaid to push her up to strong lactation.
		breasts.lactationLevel++;
		player.consumeItem(consumables.LACTAID);
	}
	else if (submissiveness() < 3) { //Not sub enough to go higher
		outputText("Kath cups her mammaries and gives them a gentle squeeze.  A few droplets of creamy liquid dribble from her nipples.  Kath sighs and wipes away the wetness with her fingers, saying, “<i>I don't think I should, " + playerText() + ".  I'm already so full all the time - even bumping into someone is enough for me to start leaking.  If I have any more of that stuff I'll smell like milk all the time, my bras will be soaked with it.  Any time I walk down the street I'll be a target for milk thieves.</i>”\n\n");
		outputText("Before you can reply she pushes your hand and the bottle against your chest and says, “<i>I bet I've got so much milk you can't drink it all,</i> in a sultry tone.”\n\n");
	}
	else if (breasts.lactationLevel == BreastStore.LACTATION_EPIC) {
		outputText("Kath cups her mammaries and gives them a gentle squeeze.  A stream of cream drips from her nipples, drenching her fingers and " + catGirl("running over", "soaking into the fur of") + " her belly before seeping into " + clothesLowerChoice("her pants", "her skirt", "the lower half of her bodysuit", "the lower half of her dress", "the lower half of her robe") + " and sheets.\n\n");
		outputText("“<i>I think it would be a waste of that bottle at this point,</i>” she says.  “<i>There's no way I could pump out more cream than I do now.  Speaking of which I've got two breasts here that are aching to be emptied; would you help a " + (hasCock() ? "herm" : "girl") + " out?</i>”\n\n");
	}
	else {
		switch (breasts.lactationLevel) { //You're handing her the Lactaid, so obviously you want more milk regardless of what you said previously
			case BreastStore.LACTATION_MODERATE:	if (breasts.preventLactationIncrease == BreastStore.LACTATION_MODERATE) breasts.preventLactationIncrease = 0;
													break;
			case BreastStore.LACTATION_STRONG:		if (breasts.preventLactationIncrease == BreastStore.LACTATION_STRONG) breasts.preventLactationIncrease = 0;
													break;
			case BreastStore.LACTATION_HEAVY:		if (breasts.preventLactationIncrease == BreastStore.LACTATION_HEAVY) breasts.preventLactationIncrease = 0;
			default:
		}
		breasts.lactationLevel++;
		player.consumeItem(consumables.LACTAID);
		if (!doneSubmissive(KBIT_SUB_HIGH_LACTATION)) { //First time turbocharging her mammaries
			outputText("Kath cups her mammaries and gives them a gentle squeeze.  A few droplets of creamy liquid dribble from her nipples.  Kath sighs and wipes away the wetness with her fingers, saying, “<i>I don't think I should, " + playerText() + ".  I'm already so full all the time - even bumping into someone is enough for me to start leaking.  If I have any more of that stuff I'll smell like milk all the time, my bras will be soaked with it.  Any time I walk down the street I'll be a target for milk thieves.</i>”\n\n");
			outputText("She tries to hand the bottle back but you ignore her and " + clothesLowerChoice("slide your hand under her belt and into her pants", "slip your hand under her skirt", "push your fingers into the crotch of her bodysuit", "slip your hand under her dress", "slide your hand inside her her robe") + ".  You start to play with her clit and find Kath's pussy is already wet.  She squirms at your touch and bites her lower lip.  You ask her if the idea of spilling milk everywhere is turning her on.\n\n");
			outputText("“<i>No,</i>” she purrs quietly.\n\n");
			outputText("Of course it does, you reply.  As you continue to play with her sensitive nub you tell Katherine that you really want to see her breasts fill with more cream.  You ask if she can do that for you.\n\n");
			outputText("Kath's eyes open part way and she looks at the bottle, then at you before ripping the cork free and gulping down the contents.  As soon as she swallows the last of it she says, “<i>Oh Marae - why?  Why did I just do that?  It's going to be so much trouble.</i>”\n\n");
			outputText("With your free hand you cup one of her breasts just in time to feel a great warmth develop inside it.  Her nipples produce a hefty spray of cream and Kath arches her back until her head is nearly touching the bed.\n\n");
			outputText("When the effects die down Katherine slumps into a pile and you hear deep, contented snoring.  You scratch her ears a few times, but when even that doesn't rouse her you decide to leave your favorite kitty to recover.\n\n");
			doNext(camp.returnToCampUseOneHour);
			addSubmissive(KBIT_SUB_HIGH_LACTATION);
			return;
		}
		else { //Sky's the limit
			outputText("Katherine puts the bottle aside, then takes your hands and places them against her chest.  “<i>Can't get enough of my cream?</i>” she asks with a wry smile.  “<i>Well OK, as long as you're always there to lick up every drop.</i>”\n\n");
			outputText("You laugh and rub her nipples.  Kath smiles and her tail wriggles at the attention.  She pops the cork and swallows the pink liquid, then tosses the bottle aside.\n\n");
			outputText("Again you feel that warmth from deep inside her breasts.");
			if (breasts.cupSize < CoC.BREAST_CUP_DD_BIG) {
				breasts.cupSize++;
				outputText("  They expand between your fingers, plumping up nicely.  They're as firm as ever, but you'd say Katherine's a " + breasts.cup() + " now.");
			}
			outputText("  Kath's cream dribbles uncontrollably from her nipples and she lets out a low moan.  Suddenly her hands grab your head and pull you in, mashing your face against her leaking breasts.\n\n");
			outputText("“<i>Please, pretty please, drink it all - or do something to take my mind off all this milk building up inside me!</i>”\n\n");
		}
	}
	katSexMenu();
}

private function giveKatRefuzzFormula():void {
	clearOutput();
	outputText("It’s time to make your cat girl back into a cat morph.  You pull out the ingredients and lay them one by one on Katherine’s bed.  The whisker fruit, the vial of hair extension serum and the honey from the bees of the forest.  Kath watches with interest, until you finally tell her this should regrow her fur and turn her back into a cat morph.\n\n");
	outputText("Kath fetches a drinking cup for you to mix the ingredients.  “<i>By the way " + playerText() + ", I’ve really enjoyed not having fur.  I didn’t expect it but it didn’t feel strange after a while.</i>”  She makes a show of undressing and runs her hands over her supple skin.  “<i>Are you sure you want to change me back?</i>”\n\n");
	simpleChoices("Change Her", giveKatRefuzzFormulaChange, "Don't Change", giveKatRefuzzFormulaDontChange, "", null, "", null, "", null);
}

private function giveKatRefuzzFormulaChange():void {
	clearOutput();
	outputText("You dump the honey and the hair serum into the cup and start squeezing the juice out of the whisker fruit.  As it dribbles into the cup Kath continues.  “<i>If you ever want me to be a cat girl - <b>your cat girl</b> - again, just ask.  I love the feeling of all those eyes on me, wondering what I am and what I’m like in bed.</i>”\n\n");
	outputText("The mixture in the cup begins to foam up and for a moment you worry it’s going to overflow.  The reaction dies down, but what’s left is a thick, clear paste.  Kath dips a finger in and says, “<i>It’s cool to the touch.</i>”  A few tiny hairs sprout from her fingertip.  “<i>I guess this is more of an ointment,</i>” she says, taking the cup.\n\n");
	outputText("Kath starts slathering the clear gel over her skin.  Thanks to her feline flexibility she’s capable of reaching every part of her body and she’s careful not to miss any spots.  By the time she’s finished the cup is almost empty and little black hairs have started to coat her body.  You see the ointment wick away, absorbed right into her skin.\n\n");
	outputText("Kath touches her face as her nose changes shape, turning back into the flat little muzzle she started life with.  Her hands change too, the fingernails drawing themselves down into her skin to form retractable claws, the palms reforming into little pads.\n\n");
	outputText("The fur takes longest to return but when it finally does Kath stands in front of you and does a sexy little dance.  “<i>Okay, I’m back to the way nature intended.  " + (hairColor == "jet black" ? "" : "She runs a hand through her " + hairColor + " hair.  Well, mostly.  ") + "Anyway, I hope you like what you see.</i>”\n\n");
	outputText("You sit down on her bed and scratch Kath’s newly grown fur.  She giggles, purrs and sits on your lap, her toned ass grinding against your ");
	if (player.hasCock())
		outputText("cock" + (player.cocks.length > 1 ? "s" : ""));
	else outputText("crotch");
	outputText((player.hasVagina() ? " and moistening your cunt" : "") + ".\n\n");
	outputText("“<i>Make me scream " + playerText() + ",</i>” she begs, “<i>show me how you love me.  Fuck my fuzzy, tight little ass 'til my ");
	if (hasCock()) outputText((hasBalls() ? "balls are" : "prostate's") + " empty and my ");
	outputText("pussy’s drenched.</i>”\n\n");
	furry = true;
	dynStats("lus", 10 + player.lib / 20);
	player.consumeItem(consumables.W_FRUIT);
	player.consumeItem(consumables.EXTSERM);
	if (player.hasItem(consumables.BEEHONY))
		player.consumeItem(consumables.BEEHONY);
	else player.consumeItem(consumables.PURHONY);
	katSexMenu();
}

private function giveKatRefuzzFormulaDontChange():void {
	clearOutput();
	outputText("You ask if she’s sure.\n\n");
	outputText("“<i>Yes. I like the feel of soft fabrics so much more now.  I can deal with the desert heat so much better I’ve even thought of telling other cats how good it feels.</i>”\n\n");
	outputText("She moves in close and kisses you on the lips, cheeks, neck and finally on your ear, which she nibbles slightly.  She whispers, “<i>But the best reason of all is that it gives you a little taste of home, a little something to look forward to when you come to town.  So please " + playerText() + ", take care of your favorite cat girl.  Make love to me 'til I can’t take any more.</i>”");
	katSexMenu();
}

private function useReductoAndPinkEgg():void {
	clearOutput();
	outputText("You show Katherine the pink egg and the jar of reducto.  “<i>What’s that for?</i>” she asks.  You tell her that you’ve met herms that have no balls.  You’re pretty sure that together the egg and the salve can make her like that.\n\n");
	if (!doneSubmissive(KBIT_SUB_REM_BALLS)) //First time doing this
		outputText("Kath reaches down and feels her balls.  Then she shakes her head and tells you, “<i>Maybe it would help when criminals try to kick me in the nuts, but I don’t know if it’s worth it.</i>”\n\n");
	if (submissiveness() < 3) {
		outputText("She did hesitate for a second... if you convince Kath to do a few other things she's unsure of she might be willing to trust you enough to lose her balls.");
		katherineMenu(); //Back to Katherine menu
	}
	else {
		outputText("You put the salve and the egg down and give Katherine a hug.  As you stroke her tail and massage her back Kath gets more and more excited.  When you feel her erection pressing hard against " + (player.isNaga() ? "the side of your tail" : "your thigh") + " you let go.\n\n");
		outputText("Kath strips off her clothes and jumps on the bed, lust in her eyes.  You climb in between her thighs, pressing both her knees to the bed.  A little attention to her cock" + cockMultiple("", "s") + " and she’s purring like a big kitten.\n\n");
		outputText("You take the jar of reducto and place it on Kath’s belly.  She opens her eyes and watches as you unscrew the lid.  You tell her that you <b>know</b> she would look more attractive without a scrotum dangling in front of her pussy.\n\n");
		if (!doneSubmissive(KBIT_SUB_REM_BALLS)) { //First time doing this
			outputText("She tries to respond but you put your finger on her lips and tell her to trust you.  Kath looks worried but finally nods and lays her head back on the pillow.  ");
			if (player.cor < 25)
				outputText("You feel a warmth in your heart knowing your lover is willing to trust in you, even on matters like these");
			else if (player.cor < 75)
				outputText("You’re glad that worked.  Now you just have to hope the salve and egg work as intended");
			else {
				outputText("Knowing that Kath is willing to put herself in your hands " + player.genderText("gives you wood", "makes you wet", "gives you wood and makes your pussy wet", "creates lusty feelings you are ill equipped to deal with") + ". You look forward to twisting this young slut’s body even more as time goes on");
			}
		}
		outputText(".\n\nYou crack the egg and slowly pour its contents into the jar.  As the liquid comes in contact with the salve it dissolves it, like fat melting on a hot skillet.  You’re left with a jar full of thick, bubbling off-white liquid.  You take Katherine’s dick" + cockMultiple("", "s") + " in one hand while you use the other to drizzle the mixture onto Kath’s scrotum where her skin absorbs it readily.\n\n");
		outputText("Kath says, “<i>Oh - it feels so cold,</i>” and her body squirms beneath you.  You toss aside the empty jar and wait for the results.  The flesh of her scrotum becomes smoother and begins to shrink.  You realize you can’t even make out her testicles any more.  As Kath moans her ballsack pulls inward and becomes completely flat.  It’s as if she never had balls.\n\n");
		outputText("Kath wriggles and squirms beneath you and moans, “<i>too much - too full!</i>” before thrusting her hips violently upwards.  Her knot" + cockMultiple(" balloons out to its fullest and her cock sprays semen against the ceiling.  You stroke her cock", "s balloon out to their fullest and her cocks spray semen against the ceiling.  You stroke her cocks") + " experimentally and are rewarded with another, smaller blast.\n\n");
		outputText("Kath begins to gently probe her crotch as drips of cum splat on the bed.  “<i>It’s so strange,</i>” she says, tiredness in her voice.  “<i>I still feel like a herm, sort of.  It’s just different.</i>”  She runs her finger over her pussy and strokes her deflating cock" + cockMultiple("", "s") + " and says, “<i>");
		if (!doneSubmissive(KBIT_SUB_REM_BALLS)) outputText("I really wasn’t sure, but I guess you were right.  ");
		outputText("Next time you come over I want to see how this works.</i>”  After mumbling something indecipherable and gently squeezing your hand Kath curls up and goes to sleep.\n\n");
		outputText("You let yourself out quietly, hoping she'll soon be ready for a trial run.");
		orgasm();
		ballSize = 0;
		player.consumeItem(consumables.PINKEGG);
		player.consumeItem(consumables.REDUCTO);
		addSubmissive(KBIT_SUB_REM_BALLS); //Have removed her balls at least once
		doNext(telAdre.telAdreMenu);
	}
}

private function giveKatWhiskerFruit():void {
	clearOutput();
	outputText("You offer Katherine the small, fuzzy fruit with a smile.  Kath’s pupils begin to dilate and you notice ");
	if (hasCock())
		outputText("a telltale swelling " + clothesLowerChoice("in her pants", "beneath her skirt", "in the crotch of her bodysuit", "beneath her dress", "beneath her robe") + ".\n\n");
	else outputText("her nipples have grow as hard as diamonds.\n\n");
	if (!hasCock() || !hasDogCock()) {
		outputText("She takes the fruit and gives you a big grin as she bites into it, sucking up all the juices.  Kath leans back on the bed and thrusts her chest toward you.  “<i>Oh Marae, do those ever put me in the mood.</i>”  She licks her lips seductively, closes her eyes and shudders with pent up energy.  In a barely controlled whisper she asks, “<i>How do you want me?</i>”");
		dynStats("lus", 10 + player.lib / 20);
		player.consumeItem(consumables.W_FRUIT);
		katSexMenu();
		return;
	}
	var doneBefore:Boolean = doneSubmissive(KBIT_SUB_CAT_DICK);
	outputText("Kath steps back and waves the fruit away.  “<i>Even the smell makes me horny, but if I eat one of those whisker fruits I’ll probably lose my dog cock");
	if (doneBefore)
		outputText(cockMultiple("", "s") + ".  Is that what you want, " + playerText() + "?</i>”");
	else {
		outputText(cockMultiple(".  It’s been with me so long I’ve really gotten used to having this big smooth tip and a knot to go with it", "s.  It... well, they’ve been with me so long I’ve really got used to having these big smooth tips and the knots to go with them") + ".</i>”\n\n");
		outputText("She rubs at her crotch absentmindedly as she continues.  “<i>When I first ate those peppers I thought of my cock, or at least the knot, as a curse.  You were the first person who didn’t run away screaming when you saw it.</i>”  She gives you a big smile and says, “<i>" + cockMultiple("It’s a", "They’re") + " part of me now.  Added by strange magic produce, but part of me nonetheless.</i>”\n\n");
		outputText("Her cock" + cockMultiple(" has", "s have") + " surely swollen to full size by now and Kath lets out a deep, rolling purr.  “<i>Now how about you put that fruit away and I show you once again just how much you mean to me?</i>”");
	}
	if (submissiveness() >= 1) {
		outputText("\n\nYou walk toward Kath, holding the fruit up under her nose.  She sniffs at it and begins to pull off her clothes.  Once she’s naked she sits on the edge of the bed, her legs spread wide and her cock" + cockMultiple("", "s") + " bouncing in time with her heartbeat.\n\n");
		if (!doneBefore) outputText("You remind her that eating any kind of pepper could give her a canine cock again.  ");
		outputText("As you wave the fruit under her nose her head starts to sway, almost like a pendulum, her dilated eyes following its every movement.");
		if (!doneBefore) outputText("  Doesn’t she want to try out a kitty cock?  See what sex is like with the cock nature intended her to have?");
		outputText("\n\nKath’s purring gets lower and lower in pitch.  Finally she bites down on the fruit, gently tugs it from your fingers and sucks on its juicy pulp.  When only the hard pit is left Kath flings it into the waste bin.  It sails right in and Kath pumps her fist.  She says, “<i>Nailed it,</i>” and then doubles over, clutching at her " + cockMultiple("member", "twin members") + ".\n\n");
		outputText("You watch, amazed, as Kath’s cock" + cockMultiple(" narrows along its entire length.  The tip  becomes", "s narrow along their entire length.  The tips become") + " more and more pointed and little protrusions form, developing into the barbs that will bring her mates ecstasy.  Her dick" + cockMultiple(" is", "s are") + " now only about an inch around" + (cockLength > 12 ? ", rather narrow for " + cockMultiple("its", "their") + " length" : "") + ".\n\n");
		outputText("Then the changes reach her knot");
		if (cockNumber > 1) {
			outputText("s.  They shrink down to nothing, then inflate again.  They do this several times, eliciting a deep moan of pleasure from Katherine each time.  Finally they stabilize, " + (knotSize == 2 ? "refusing to shrink any smaller than they were before" : "having lost a little of their previous girth"));
		}
		else {
			outputText(".  It shrinks down to nothing, then inflates again.  It does this several times, eliciting a deep moan of pleasure from Katherine each time.  Finally it stabilizes, " + (knotSize == 2 ? "refusing to shrink any smaller than it was before" : "having lost a little of its previous girth"));
		}
		outputText(".\n\n");
		outputText("When it's over Kath feels up and down her shaft" + cockMultiple("", "s") + ".  ");
		if (!doneBefore)
			outputText("“<i>That’s so weird.  How come I still have " + cockMultiple("a knot", "knots") + "?</i>”  She traces her " + catGirl("nails", "claws") + " along the soft bulge of her knot" + cockMultiple("", "s") + " and then smiles at you.  “<i>Guess I ate so many of those peppers that I get to keep " + cockMultiple("it", "them") + ".</i>”\n\n");
		outputText("She puts her arms around you and kisses you hard.  “<i>And now " + playerText() + ", do you feel like trying out your new pussy cat?  " + (doneBefore ? "Nubs and knot" + cockMultiple("", "s") + ", all in one" : "She’s got an all new kind of prick for you to test out") + ".</i>”");
		flags[kFLAGS.KATHERINE_DICK_FORM] = 1;
		addSubmissive(KBIT_SUB_CAT_DICK); //Have given her a cat dick at least once
		knotSize -= 2;
		if (knotSize < 2) knotSize = 2;
		dynStats("lus", 10 + player.lib / 20);
		player.consumeItem(consumables.W_FRUIT);
	}
	katSexMenu();
}

private function giveKatClothesBodysuit():void {
	clearOutput();
	outputText("You get Kath to stand in front of the mirror and tell her to close her eyes.  When she does you pull out the bodysuit and press it against her.\n\n");
	outputText("Kath’s eyes fly open and she feels the thin, sheer fabric with her fingers.  “<i>Oh " + playerText() + " it’s so nice.</i>”  She bites her lip as she studies herself in mirror.  Still totally flustered she speaks again.  “<i>I already know how much you love me " + playerText() + ", you don’t have to shower me with such lovely gifts to keep me - I’m already yours.  This must have been so expensive!</i>”\n\n");
	outputText("You walk up beside her and put an arm around her waist.  As you rub her side you tell her that the bodysuit is as much a gift for you as for her.  You’re looking forward to seeing it filled in by her toned body.  " + catGirl("Kath blushes a deep crimson and then", "You feel the heat of a blush under her fur before Kath") + " goes back to studying herself.\n\n");
	outputText("To get her started you " + clothesLowerChoice("run your finger inside the waist of her pants", "run your finger inside the waistband of her skirt", "", "tug gently on the straps of her dress", "run your finger along the low cut top of her robe") + ".  Kath takes the hint and starts undressing eagerly.  She slips into the bodysuit, which has a convenient little hole for her tail.  When she looks back in the mirror she gasps.  “<i>Oh... wow, I knew this would be a little see through, but you can see almost everything!</i>”\n\n");
	outputText("Of course you knew how thin the bodysuit was.  You slide a hand along the sheer fabric, tracing her curves right through her clothes.  ");
	if (hasCock()) outputText("A bulge begins to form between her legs.  ");
	outputText("The fabric prevents you from actually seeing Katherine’s ");
	if (hasCock())
		outputText("cock" + cockMultiple("", "s") + (ballSize > 3 ? " or " + ballAdj() + " balls" : ""));
	else outputText("pussy lips");
	outputText(" but it’s so taut that it outlines every detail" + (hasCock() ? "" : ", giving her a highly visible cameltoe") + ".\n\n");
	if (hasCock()) outputText("Trapped against her body the bulge grows higher and higher, the " + (pregSize() > 5 ? "tips climbing the curve of her pregnant belly" : "rising tip" + cockMultiple("", "s") + " getting nearer and nearer to her breasts") + ".  ");
	outputText("You tell Kath that the outfit really looks great and you look forward to seeing her parade around town in it.\n\n");
	outputText("Her tail swishes back and forth and Kath gives in to the feeling of your hands massaging her body.  Her nipples tent the gossamer fabric and you realize that you could probably make her cum while she’s still wearing the outfit.\n\n");
	outputText("“<i>Do you really want me to walk around town like this?</i>” she pants.  “<i>Everyone will " + (hasCock() ? "know I’m a herm" : "see everything") + ".</i>”");
	giveClothing(KBIT_CLOTHES_BODYSUIT);
	player.consumeItem(armors.T_BSUIT);
	simpleChoices("Yes", giveKatClothesBodysuitYes, "No", giveKatClothesBodysuitNo, "Always", (submissiveness() >= 2 ? giveKatClothesBodysuitAlways : null), "", null, "", null);
}

private function giveKatClothesBodysuitYes():void {
	clearOutput();
	outputText("You tell her that’s exactly what you want.  She has an incredible body and she should learn to show off a little.  The sight of her bending over to inspect some produce in the market will make people’s days.  For a lovely girl like her wearing a transparent bodysuit is a public service.\n\n");
	outputText("Kath sighs contentedly and says, “<i>" + (playerMaster() ? "Yes [master]" : "Alright " + player.short) + ", if that’s what you like then expect to see me wearing this a lot.  Now, if you don’t mind I think I should get undressed again because I think things are about to get messy.  After all I still need to thank you for this wonderful gift.</i>”");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = KBIT_CLOTHES_BODYSUIT;
	katSexMenu();
}

private function giveKatClothesBodysuitNo():void {
	clearOutput();
	outputText("You consider it but tell Kath that at least for now you want to keep the bodysuit as something that she might wear on special occasions, an outfit she only puts on once in a while when she wants to feel different.  Kath nods and you get the feeling she’s more comfortable with the idea of wearing the bodysuit in private.\n\n");
	outputText("“<i>Now,</i>” she says, like it’s time to get to work, “<i>I haven’t properly thanked you for this wonderful gift yet.</i>”");
	katSexMenu();
}

private function giveKatClothesBodysuitAlways():void {
	clearOutput();
	outputText("You nibble Kath’s ear, causing her to wriggle in your arms.  You tell her that she looks amazing in the bodysuit.  In fact you would say that it ‘suits’ her.  She moans, but you’re not sure if that’s due to your pun or the fact you’ve started to rub her nipples through the fabric.\n\n");
	outputText("You tell her that she has an incredible body and she should learn to show off a little.  The sight of her bending over to inspect some produce in the market will make people’s days.  For a lovely girl like her wearing a transparent bodysuit is a public service.\n\n");
	outputText("As you grope her breasts you add that when you’re out there fighting monsters you want to <b>know</b> that her perky breasts, her tight butt and her delightful ");
	if (hasCock())
		outputText("cock" + cockMultiple("", "s"));
	else outputText("pussy");
	outputText(" are on display.  Whenever she’s not on duty you want her proudly strutting her stuff wherever she goes.\n\n");
	outputText("Kath becomes putty in your arms and says, “<i>Yes!  I’ll do it all for you " + playerText() + ".  But right now I still have to thank you.  This bodysuit feels sooo good pressed against " + catGirl("my skin", "me") + ", but when you’re pressed against me it feels even better.</i>”");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = -KBIT_CLOTHES_BODYSUIT;
	katSexMenu();
}

private function giveKatClothesLongDress():void {
	clearOutput();
	outputText("You get Kath to stand in front of the mirror and tell her to close her eyes.  When she does you pull out the elegant ballroom dress and press it against her.\n\n");
	outputText("It takes Kath quite a while to find her voice.  When she does she hugs you tightly and says, “<i>It’s beautiful!</i>”  There are tears in her eyes and she’s starting to sniffle.  “<i>I’ll look like a princess in this dress,</i>” she says, slowly stroking the floor length skirt.  “<i>Oh, you can’t spend so much on me " + playerText() + " - you’ve already given me a whole new life!  I should be the one giving you presents.</i>”\n\n");
	outputText("You laugh and tell her she’s always giving you presents, you’re just providing a new kind of wrapping.  She grins and says, “<i>Awww " + playerText() + " you’re so good to me.</i>”  She undresses and redresses quite quickly, considering how long the numerous buttons on the dress take to get right.\n\n");
	outputText("“<i>I’ve never gone to a big party, but now I’ve got the perfect dress for it.  I think I was wrong before, princesses are going to be jealous,</i>” she says as she twirls left and right, watching the long dress flow in the mirror.  “<i>It’s perfect - it really is." + (hasCock() ? "  I bet even if I was rock hard under this gown no one could tell I’m a herm." : "") + "</i>”\n\n");
	outputText("She twirls a few more times before grabbing your arms and leading you in a silent dance.  “<i>" + (hasCock() ? "I am all woman, but in this dress I finally feel like it" : "In this dress I feel like I’m all woman, just like I wanted to be when I was really young and kids picked on me") + ".</i>”  You don’t know the slow dance she’s taking you through, but it doesn’t seem to matter.  Kath finally snaps out of her fantasy and says, “<i>This dress is so special; I don’t want anything to happen to it.  Maybe I should only put it on for special occasions.</i>”");
	giveClothing(KBIT_CLOTHES_B_DRESS);
	player.consumeItem(armors.B_DRESS);
	simpleChoices("Wear It", giveKatClothesDressWearIt, "Agree", giveKatClothesDressAgree, "Always Wear", (submissiveness() >= 2 ? giveKatClothesDressAlways : null), "", null, "", null);
}

private function giveKatClothesDressWearIt():void {
	clearOutput();
	outputText("You put your hands on Kath’s shoulders and tell her you bought this dress so she could enjoy it, not so that it could hang in her wardrobe all day.  She thinks it makes her look great and you couldn’t agree more.  She should wear it whenever she wants and show the people of Tel’Adre what a cat with class looks like.\n\n");
	outputText("Kath beams at your compliments and says, “<i>If you’re going to put it like that I’m not going to argue.  Now it’s time for me to start thanking you.  It’s going to take months before I feel I’ve showed you how much this means to me, but here’s how it’s going to start.  I’m going to sit on the bed and you can pick any way you want to open your present.</i>”\n\n");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = KBIT_CLOTHES_B_DRESS;
	katSexMenu();
}

private function giveKatClothesDressAgree():void {
	clearOutput();
	outputText("Kath is probably right.  It’s a shame, since it looks great on her.  You tell her if she’s too worried to take it out now then that’s okay, but you hope every once in a while she decides to wear it and show off to the neighbours.\n\n");
	outputText("Kath snuggles against your chest and says, “<i>Sounds good to me.  Now it’s time for me to start thanking you.  It’s going to take months before I feel I’ve showed you how much this means to me, but here’s how it’s going to start.  I’m going to sit on the bed and you can pick any way you want to open your present.</i>”\n\n");
	katSexMenu();
}

private function giveKatClothesDressAlways():void {
	clearOutput();
	outputText("You put your hands on Kath’s shoulders and tell her you bought this dress so you could both enjoy it, not so that it could hang in her wardrobe all day.  She thinks it makes her look great and you couldn’t agree more.  In fact she should wear it all the time and show the people of Tel’Adre what a cat with class looks like.\n\n");
	outputText("Kath smiles and asks, “<i>Do you insist?</i>”  You reach a little higher and play with her ears.  " + (hasCock() ? "You can’t see it, but you know that under the gown her shaft is hardening.  " : "") + "“<i>Oh yes,</i>” she says, falling into your arms, “<i>if you’re going to put it like that I’m not going to argue.  I promise I’ll wear it every day.  Now it’s time for me to start thanking you.  It’s going to take months before I feel I’ve showed you how much this means to me, but here’s how it’s going to start.  I’m going to sit on the bed and you can pick any way you want to open your present.</i>”\n\n");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = -KBIT_CLOTHES_B_DRESS;
	katSexMenu();
}

private function giveKatClothesNurseOutfit():void {
	clearOutput();
	outputText("You get Kath to stand in front of the mirror and tell her to close her eyes.  When she does you pull out the three pieces of the skimpy nurse outfit and press them against her.\n\n");
	outputText("Katherine takes each of the three pieces in turn and studies them.  “<i>This is really, really racy.  Oh sure, it covers everything; I won’t get in any trouble... but wow.</i>”  She holds the tiny white top against her " + breasts.cup() + "s and gives you a toothy smile.  “<i>");
	if (breasts.cupSize < CoC.BREAST_CUP_C)
		outputText("This top is going to make my teenie breasts look bigger, just because there’s so little fabric");
	else if (breasts.cupSize < CoC.BREAST_CUP_DD_BIG)
		outputText("This top will really show off my rack.  Everyone’s going to be staring");
	else
		outputText("I don’t know if these buttons will hold up.  I’ve got a huge load of titflesh for this itty bitty top to support");
	outputText(".</i>”\n\n");
	outputText("Next she puts the tiny white hat on her head, where it nestles between her black furred ears.  “<i>I don’t know why,</i>” she says, studying herself in the mirror, “<i>but this little cap is giving me all sorts of naughty ideas.</i>”\n\n");
	outputText("Lastly she picks up the outrageously short white miniskirt.  ");
	if (canWearMiniSkirt())
		outputText("“<i>This is going to be tricky.  It looks like it will <b>just</b> fit.  I am going to have to be so careful sitting down in this.</i>”\n\n");
	else outputText("“<i>I’m sorry " + playerText() + ", but there’s just no way.  It wouldn’t even cover me when I’m soft.  I think I’ll wear the skirt I’ve already got with this.  Otherwise I’ll expose myself with every step.</i>”\n\n");
	outputText("Katherine strips off her ");
	if (canWearMiniSkirt())
		outputText("clothes and then puts on the pieces of the skimpy nurse’s outfit one by one");
	else if (flags[kFLAGS.KATHERINE_CLOTHES_WORN] == KBIT_CLOTHES_C_CLOTH)
		outputText("blouse and puts on the skimpy top and tiny hat");
	else outputText("clothes, fetches her skirt from the wardrobe and then puts on all the pieces of her new outfit");
	outputText(".  When she’s finished a vision of naughtiness stands before you.\n\n");
	outputText("She walks toward you, her hips swaying from side to side.  “<i>I know it’s racy, skimpy, probably even outright slutty, but I love how it looks.  " + catGirl("It feels nice walking around with all this exposed skin", "I really like how the whiteness of the outfit contrasts with the blackness of my fur") + ".  She slides her arms around your waist and you feel a great deal of heat radiating from under that skirt.  Mmmm, you’re too good to me " + playerText() + ".  Let me show you how much I appreciate you...</i>”\n\n");
	giveClothing(KBIT_CLOTHES_NURSECL);
	player.consumeItem(armors.NURSECL);
	katSexMenu();
}

private function giveKatClothesSilkRobe():void {
	clearOutput();
	outputText("You get Kath to stand in front of the mirror and tell her to close her eyes.  When she does you pull out the spider silk robe and hold it against her.  It’s so soft and airy that you finally have to tell her to open her eyes.\n\n");
	outputText("She gawks at the robes, taking them gently and running her fingers over the fine silk and the embroidered runes.  She whispers, “<i>Where did you get this?  I’ve never seen anything like it.</i>”\n\n");
	outputText("You explain that the spiders of the swamp produce an amazingly strong form of silk and that this batch was treated and woven into these robes.  She tests the fabric and discovers its great strength.  “<i>It's so thin that it looks like it should just fall apart.</i>”  She tugs a little more forcefully.  “<i>If this is all spider silk then I guess a minotaur couldn’t tear it apart.</i>”\n\n");
	outputText("She asks about the runes and you tell her the robe is meant to improve spellcasting somehow, though you’re not sure how it does that.  “<i>I’m no sorcerer,</i>” she says, “<i>if I had any talent they would have tried recruiting me for the tower.  It’s almost a shame having me wear this.</i>”\n\n");
	outputText("You convince her to put it on anyway.  She strips and then pulls on the robe.  “<i>It’s so smooth!  It feels like the wind brushing against my " + catGirl("skin", "fur") + ".  It makes me feel like I’m completely naked.</i>”\n\n");
	outputText("Katherine strikes a commanding pose and looks at herself in the mirror, then she seems to deflate slightly.  Looking very shy she says, “<i>I don’t know if I should wear this around town.  It seems way too special.</i>”");
	giveClothing(KBIT_CLOTHES_SS_ROBE);
	player.consumeItem(armors.SS_ROBE);
	simpleChoices("Wear It", giveKatClothesRobeWear, "Don’t Wear", giveKatClothesRobeDontWear, "Always Wear", (submissiveness() >= 2 ? giveKatClothesRobeAlways : null), "", null, "", null);
}

private function giveKatClothesRobeWear():void {
	clearOutput();
	outputText("You tell Katherine that she’s special too.  These robes make her look a little exotic, but without her shapely body inside they’d be no more than a soft lump on the floor.  Knowing that she can feel everything you do right through the robe you hold her close and start to slide your hands down her spine.\n\n");
	outputText("Kath lets out a very pleased purr as you reach her ass.  You work the root of her tail between your hands and ");
	if (hasCock())
		outputText("her cock" + cockMultiple(" begins", "s begin") + " to press against " + (player.isNaga() ? "the front of your tail" : "your inner thighs"));
	else outputText("she begins to press her crotch against " + (player.isNaga() ? "the front of your tail" : "your legs"));
	outputText(".  Once she’s sufficiently aroused you tell her she should wear these clothes around town, get used to them, and treat the inhabitants of Tel’Adre to the fine view she’ll provide.\n\n");
	outputText("Kath gives you a quick kiss and says, “<i>You win " + playerText() + ", as always.  But I know these robes are very special indeed.  I can’t possibly repay you for everything you’ve done for me, except to keep loving you more and more each day.</i>”  She suddenly hops up and wraps her legs around you at waist level.  She holds your head against her breasts and adds, “<i>Now with that in mind...</i>”\n\n");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = KBIT_CLOTHES_SS_ROBE;
	katSexMenu();
}

private function giveKatClothesRobeDontWear():void {
	clearOutput();
	outputText("Since the robes are a bit exotic perhaps she should only wear them sparingly.  Kath seems happy to leave things there and moves closer to you before you can add any provisos or conditions.\n\n");
	outputText("Without warning she hops up and wraps her legs around you at waist level.  Her hands hold your head against her breasts.  Knowing that she can feel everything you do right through the robe you start to slide your hands down her spine.  Kath lets out a very pleased purr as you reach her ass.  You work the root of her tail between your hands and ");
	if (hasCock())
		outputText("her cock" + cockMultiple(" begins", "s begin") + " to press against " + (player.isNaga() ? "the front of your tail" : "your inner thighs"));
	else outputText("she begins to press her crotch against " + (player.isNaga() ? "the front of your tail" : "your legs"));
	outputText(".\n\nKath gives you a quick kiss and says, “<i>I can’t possibly repay you for everything you’ve done for me, except to keep loving you more and more each day.  Now with that in mind...</i>”\n\n");
	katSexMenu();
}

private function giveKatClothesRobeAlways():void {
	clearOutput();
	outputText("You tell Katherine that she’s special too.  These robes make her look a little exotic, but without her shapely body inside they’d be no more than a soft lump on the floor.  Knowing that she can feel everything you do right through the robe you hold her close and start to slide your hands down her spine.\n\n");
	outputText("Kath lets out a very pleased purr as you reach her ass.  You work the root of her tail between your hands and ");
	if (hasCock())
		outputText("her cock" + cockMultiple(" begins", "s begin") + " to press against " + (player.isNaga() ? "the front of your tail" : "your inner thighs"));
	else outputText("she begins to press her crotch against " + (player.isNaga() ? "the front of your tail" : "your legs"));
	outputText(".  Once she’s sufficiently aroused you tell her she should wear these clothes around town, get used to them, and treat the inhabitants of Tel’Adre to the fine view she’ll provide.\n\n");
	outputText("Kath continues to purr like a chainsaw and you decide to press for more.  You tell her that since silk is one of the best things to wear in the heat of the desert there’s no reason for her to ever <b>not</b> wear the robes.  In fact, you expect her to wear them all the time.  She tries to argue but you press a finger to her lips and tell her to promise.\n\n");
	outputText("Kath gives you a quick kiss and says, “<i>You win " + playerText() + ", as always.  But I know these robes are very special indeed.  I can’t possibly repay you for everything you’ve done for me, except to keep loving you more and more each day.</i>”  She suddenly hops up and wraps her legs around you at waist level.  She holds your head against her breasts and adds, “<i>Now with that in mind...</i>”\n\n");
	flags[kFLAGS.KATHERINE_CLOTHES_PREF] = -KBIT_CLOTHES_SS_ROBE;
	katSexMenu();
}

private function giveKatClothesTubeTop():void {
	clearOutput();
	outputText("You get Kath to stand in front of the mirror and tell her to close her eyes.  When she does you pull out the tube top and accompanying tight shorts and press them against her.\n\n");
	outputText("Kath takes the snug top and stretches it across her " + breasts.adj() + " breasts.  “<i>I’ve seen outfits like this in some of the shops around here.  Thank you " + playerText() + ", I’m sure it will look good on me.</i>”\n\n");
	outputText("She then takes the tight, stretchy shorts and holds them in front of her hips.  ");
	if (hasCock())
		outputText("“<i>These are so tight!  They remind me of the tight pants girls wear to the gym.</i>”\n\n");
	else if (canWearMiniSkirt())
		outputText("“<i>These are so tight!  I think I can fit my cock" + cockMultiple("", "s") + (hasBalls() ? " and balls" : "") + " inside them, but it will be a near thing.  And if I grow much bigger I’m going to have to start wearing a skirt just for comfort.</i>”\n\n");
	else
		outputText("“<i>These are so tight!  There’s no way I can fit my cock" + cockMultiple("", "s") + (hasBalls() ? " and balls" : "") + " inside them.  All it would take is a whiff of whisker fruit and my cock" + cockMultiple("", "s") + " would pop right out.</i>”  She " + (flags[kFLAGS.KATHERINE_CLOTHES_WORN] == KBIT_CLOTHES_C_CLOTH ? "gestures at the knee length skirt she’s currently wearing with her blouse." : "goes to her wardrobe and fetches the knee length skirt she usually wears with her blouse.") + "  “<i>I think I’ll wear this with it.  They even look like they go together.</i>”\n\n");
	outputText("She strips off her ");
	if (canWearMiniSkirt())
		outputText("clothes and then struggles in turn with both the tube top and the tight shorts.  She has to roll on the floor to force them up the last few inches of her thighs.  Then she hops up and starts posing in the mirror, her " + breasts.adj() + " breasts on display in the stretchy, clingy fabric and her " + (hasCock() ? "masculine additions" : "pussy") + " outlined by the form fitting shorts.");
	else outputText((flags[kFLAGS.KATHERINE_CLOTHES_WORN] == KBIT_CLOTHES_C_CLOTH ? "blouse" : "clothes, quickly slips on her knee length skirt") + " and then struggles with the tube top.  When it’s finally on right she starts posing in the mirror, her " + breasts.adj() + " breasts on display in the stretchy, clingy fabric.");
	outputText("\n\nYou come up behind her and rub her exposed" + (pregSize() > 4 ? ", bulging" : "") + " midriff.  Kath’s tail starts to dance and she falls back against you, purring.  “<i>Oh " + playerText() + ", I just got into this lovely outfit you gave me.  Do you want me out of it so soon?</i>”\n\n");
	giveClothing(KBIT_CLOTHES_TUBETOP);
	player.consumeItem(armors.TUBETOP);
	katSexMenu();
}

private function giveKatDyeBegin(dyeColor:String):void {
	clearOutput();
	outputText("You pull out the vial of hair dye and offer it to Katherine.\n\n");
	outputText("“<i>For me?</i>” she asks, surprised.  Kath takes the small bottle from your hand and examines it closely.  “<i>Well - only one way to see how it looks.</i>”\n\n");
	outputText("She dashes to the washbasin and rinses her hair before carefully applying the dye.  Over the next few minutes her " + hairColor + " hair changes gradually until her entire head is covered in " + dyeColor + " strands");
	hairColor = dyeColor; 
}

private function giveKatDyeEnd():void {
	outputText("She spins round and hugs you.  “<i>Thank you " + playerText() + ".  Does it look as good as you hoped?</i>”\n\n");
	outputText("You assure her it does but you get the feeling Kath would prefer it if you showed your approval more physically.");
	katSexMenu();
}

private function giveKatDyeAuburn():void {
	giveKatDyeBegin("rich auburn");
	player.consumeItem(consumables.AUBURND);
	outputText(".\n\nKath takes a look in the mirror and tries combing her hair several different ways.  “<i>It’s not that flashy, but it looks good on me.  There’s a nice contrast with my " + catGirl("skin", "fur") + ".</i>”\n\n");
	giveKatDyeEnd();
}

private function giveKatDyeBlack():void {
	giveKatDyeBegin("jet black");
	player.consumeItem(consumables.BLACK_D);
	outputText(", matching the fur ");
	if (furry) {
		outputText("that covers the rest of her body.\n\n");
		outputText("Kath takes a look in the mirror and puts her hands on her hips.  After combing her hair repeatedly she says, “<i>This is why I dyed my hair.  It’s so hard to make myself look different from every other cat out there.</i>”\n\n");
		outputText("You step up behind her and wrap your arms around her at waist level.  ");
		if (hasCock()) {
			outputText("You rub the insides of her thighs and soon her cock" + cockMultiple(" stands", "s stand") + " at attention.  You whisper in Katherine’s ear that there are still some things that make her stand out.\n\n");
			outputText("She grinds her ass against you and purrs.  “<i>Before I met you I had a hard time believing my huge cock and knot were a blessing - and now I feel like thanking you again for changing my mind.</i>”");
		}
		else outputText("Katherine sinks back into your arms and says, “<i>I love you so much " + playerText() + ",</i>” in a deep, happy purr.");
		katSexMenu();
	}
	else {
		outputText("on her ears and tail.\n\n");
		outputText("Kath takes a look in the mirror and runs her fingers through her hair.  “<i>Now when I was all feline this would have made me blend in with every other black cat in the city.  Now it’s kinda striking.  Skin like milk, hair like raven feathers... I could get used to this.</i>”\n\n");
		giveKatDyeEnd();
	}
}

private function giveKatDyeBlonde():void {
	giveKatDyeBegin("light blonde");
	player.consumeItem(consumables.BLOND_D);
	outputText(".\n\nKath takes a look in the mirror and tries combing her hair several different ways.  “<i>When I was a little kitty I was always jealous of felines with lighter colored fur.  " + catGirl("Now I’ve got blonde hair and no fur, except on my ears and tail.  They’re the ones who ought to be jealous now", "I think it looks good on me, especially since there’s such a contrast with my fur")  + ".</i>”\n\n");
	giveKatDyeEnd();
}

private function giveKatDyeBlue():void {
	giveKatDyeBegin("bright blue");
	player.consumeItem(consumables.BLUEDYE);
	outputText(".\n\nKath takes a look in the mirror and runs her fingers through her hair.  “<i>Wow.  Nice and bright.  Really appropriate for an officer who’s part of the thin blue line.</i>”  She giggles a bit and says, “<i>This is a color I always wanted to try and I think it looks great!</i>”\n\n");
	giveKatDyeEnd();
}

private function giveKatDyeOrange():void {
	giveKatDyeBegin("vibrant orange");
	player.consumeItem(consumables.ORANGDY);
	outputText(".\n\nKath takes a look in the mirror and runs her fingers through her hair.  “<i>Wow.  Nice and bright.  No one is going to miss me now.  This is almost the same color the Watch paints on doors to mark dangerously unstable houses.</i>”  She giggles a bit and says, “<i>I always wanted to try orange and I think it looks great on me!</i>”\n\n");
	giveKatDyeEnd();
}

private function giveKatDyePink():void {
	giveKatDyeBegin("neon pink");
	player.consumeItem(consumables.PINKDYE);
	outputText(".\n\nKath takes a look in the mirror and runs her fingers through her hair.  “<i>Back to the old classic.  Nothing wrong with hot pink.  I always used to wear it so people thought I was a girl, or at least a really girly herm.</i>”\n\n");
	giveKatDyeEnd();
}

private function giveKatDyePurple():void {
	giveKatDyeBegin("deep purple");
	player.consumeItem(consumables.PURPDYE);
	outputText(".\n\nKath takes a look in the mirror and tries combing her hair several different ways.  “<i>It’s not as bright as the colors I would have picked, but it looks does look good.  " + catGirl("I guess it’s the opposite of the black fur and bright pink hair I used to have.  Now I’ve got dark purple hair and light skin", "My fur is so dark the purple still stands out.  Not many girls could say that") + ".</i>”\n\n");
	giveKatDyeEnd();
}

private function giveKatDyeRed():void {
	giveKatDyeBegin("flaming red");
	player.consumeItem(consumables.RED_DYE);
	outputText(".\n\nKath looks in the mirror and starts to pose.  “<i>I don’t know about you, but I’m getting turned on.  Everyone says redheads have more fun.  Maybe it’s attitude, maybe it’s something in this dye.  But who cares why?  I just plan to prove them right.</i>”\n\n");
	giveKatDyeEnd();
}

private function giveKatDyeWhite():void {
	giveKatDyeBegin("snow white");
	player.consumeItem(consumables.WHITEDY);
	outputText(".\n\nKath takes a look in the mirror and tries combing her hair several different ways.  “<i>When I was a little kitty I was always jealous of felines with lighter colored fur.  " + catGirl("Now I’ve got snow white hair and only a little bit of black fur on my ears and tail.  They’re the ones who ought to be jealous now.  In this desert heat I win!", "I think it looks good on me but the contrast is something else.  It almost hurts my eyes looking at my shoulders and it’s going to be even worse in sunlight.  No one is going to walk into me now.") + "</i>”\n\n");
	giveKatDyeEnd();
}

private function giveKatDyeGreen():void {
	giveKatDyeBegin("lime green");
	player.consumeItem(consumables.GREEN_D);
	outputText(".\n\nKath takes a look in the mirror and runs her fingers through her hair.  “<i>That's something unique! There are no other cat" + catGirl("-girl", "") + " with green hair in whole Tel'Adre, and it looks great with my green eyes!</i>”\n\n");
	giveKatDyeEnd();
}

//Sex
public function katherineSex():void {
	clearOutput();
	if (getGame().urta.drainedByKath) {
			outputText("There are certainly a few things you can think to do with your horny kitten, especially after that display, so you lead her toward the rear exit.  Katherine paws at your belt, but you keep her under control until you're both out of sight of the other patrons.  You give Kath a quick kiss and realize you have only a moment to decide what you want to do with her before she takes matters into her own hands.");
	}
	else if (isAt(KLOC_BAR)) {
		outputText("You ask Kath if she’s in the mood to have a little fun.\n\n");
		outputText("“<i>What ever could you mean by that " + playerText() + "?</i>” she asks playfully.\n\n");
		outputText("You point out that there’s an alleyway behind the bar.  If she needed a refresher course on catching miscreants you could give her a hand." + (flags[kFLAGS.KATHERINE_URTA_AFFECTION] > 10 ? "  You glance over at Urta’s table and add that maybe you could go and talk to captain Urta about improper procedures." : "") + "\n\n");
	}
	else {
		outputText("You ask Katherine if she's in the mood to have sex.\n\n");
		outputText("The cat herm is visibly startled by your directness, then rallies and gives you an ear-to-ear grin.  “<i>Mmm...  am I ever...  Any particular preference?</i>” she asks, swishing her tail languidly from side to side.");
	}
	katSexMenu();
}

private function katSexMenu():void {
	katherineSprite(true);
	var penetrate:Function = null;
	var getPen:Function = null;
	var helix:Function = null;
	var suckle:Function = null;
	if (player.lust >= 33) { //No penetration or helix if you’re at low lust
		if (player.hasCock()) {
			if (player.cockThatFits(70) >= 0) penetrate = katPenetrate;
		}
		if (hasCock()) {
			getPen = letKatKnotYou;
			if (player.hasCock() && player.hasVagina() && player.cockThatFits(70) >= 0) helix = katDoubleHelixCraziness;
		}
	}
	if (player.lactationQ() > 0 && player.biggestLactation() >= 1 && player.biggestTitSize() >= 1) {
		if (doneSubmissive(KBIT_SUB_START_LACTATION))
			suckle = suckleMenu;
		else suckle = suckleTacularKats;
	}
	else if (doneSubmissive(KBIT_SUB_START_LACTATION)) suckle = suckleFromKath;
	
	if (isAt(KLOC_KATHS_APT)) {
		var bedBond:Function = (hasAlready(KBIT_TRIED_BEDROOM_BONDAGE) || player.gems >= 40 ? bedroomBondage : null);
		choices("Penetration", penetrate, "Oral", oralKatherineChoices, "Handjob", handjobbiesFurrDemCatFurries, "Bed Bondage", bedBond, "", null,
		"GetPenetrated", getPen, "DoubleHelix", helix, "Suckle", suckle, "", null, "Back", katherineMenu);
	}
	else { //Not yet employed or at the bar. Kath can't be on duty, since there's a special sex menu for on duty encounters
		var seeUrta:Function = null;
		var seeVala:Function = null;
		var backOpt:Function = katherineMenu;
		if (isAt(KLOC_BAR)) { //Check to see if her partners are comfortable fucking her sober
			if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] > 10 && getGame().urta.urtaAtBar() && getGame().urta.urtaAvailableForSex()) seeUrta = katherineSeeUrta;
			if (flags[kFLAGS.KATHERINE_VALA_AFFECTION] > 10 && isValaAtBar()) seeVala = katherineSeeVala;
		}
		else if (isAt(KLOC_BAR_DRUNK)) {
			suckle = null; //If she's drunk she wants sex, not suckling
			if (getGame().urta.urtaAtBar() && getGame().urta.urtaAvailableForSex() && !getGame().urta.drainedByKath) seeUrta = katherineDrunkSeeUrta; //Different conversation if Kath is sloshed
			if (isValaAtBar() && !getGame().urta.drainedByKath) seeVala = katherineSeeVala;
			backOpt = null; //Kath won't take no for an answer if she's sauced
		}
		else if (isAt(KLOC_BAR_URTA_REFUSED)) {
			if (isValaAtBar()) seeVala = katherineSeeVala;
			backOpt = null; //Kath won't take no for an answer if she's sauced
		}
		choices("Penetration", penetrate, "Oral", oralKatherineChoices, "Handjob", handjobbiesFurrDemCatFurries, "See Urta", seeUrta, "See Vala", seeVala,
		"GetPenetrated", getPen, "DoubleHelix", helix, "Suckle", suckle, "", null, "Back", backOpt);
	}
}

private function katherineDrunkSeeUrta():void {
	clearOutput();
	outputText("Now that you’ve lowered Kath’s inhibitions you suggest the two of you should go and talk to Urta.\n\n");
	outputText("“<i>Yeah, the captain looks like she could use some company.</i>”\n\n");
	outputText("You have to help Katherine get to Urta’s table, but once there Kath plops down into the seat next to Urta and gives her a big hug.\n\n");
	if (getGame().urta.urtaDrunk()) {
		outputText("Urta hugs Kath back and says, “<i>Hey there cutie,</i>” before groping Kath’s behind.\n\n");
		outputText("Kath purrs and buries her head in Urta’s bosom.\n\n");
		outputText("You get the feeling you are going to have to intervene quickly if you don’t want them to fuck right here and now.");
		var button:int = 0;
		menu();
		if (submissiveness() < 3) {
			addButton(button++, "Orgy", telAdre.katherineThreesome.orgy);
			outputText("\n\nYou");
		}
		else outputText("  On the other hand everyone enjoys an orgy.\n\nOtherwise you");
		if (player.gender == GENDER_NONE) {
			outputText(" could let the two of them fuck.  Unfortunately, you really aren't equipped for more than that.");
			addButton(button++, "Watch", telAdre.katherineThreesome.watchNoIntro, true);
		}
		else {
			outputText(" could let the two of them fuck and then help yourself or you and Urta could work together to fill Kath's needy holes.");
			addButton(button++, "Let 'em fuck", telAdre.katherineThreesome.doubleStuffKath);
			if (player.hasCock()) addButton(button++, "Dbl Pen Kath", telAdre.katherineThreesome.doublePenetrateKath);
		}
	}
	else if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] > 10) { //Willing to bang Kath (when sober)
		outputText("Urta hugs her back and asks, “<i>" + player.short + ", Kath - Looking to get in a little trouble?</i>” before scratching behind Kath’s ears.\n\n");
		outputText("Kath winks at you, gives Urta a kiss and says, “<i>only the best kind of trouble,</i>” in a slightly slurred voice.");
		simpleChoices("Lick Out", telAdre.katherineThreesome.kathLicksOutUrta, "Sandwich", (hasCock() ? telAdre.katherineThreesome.sandwich : null),
			"Knothole", (player.gender != GENDER_NONE && hasCock() ? telAdre.katherineThreesome.knothole : null), "", null, "", null); //Do not show knothole button for genderless
	}
	else { //Not willing to bang Kath (while sober) just yet
		outputText("Urta pushes Kath back gently.  “<i>Whoa - " + player.short + " I think someone’s had a bit much.</i>”\n\n");
		outputText("Kath smiles and her eyes wander downward, clearly checking out Urta’s chest and then her cock.  Her voice slightly slurred Kath says, “<i>I like you cap'n,</i>” before Urta can lift her up, haul her back to her booth and dump Katherine in her usual seat.\n\n");
		outputText("Urta turns to you and whispers, “<i>You’d better do something about her.  She’s going to start humping a table leg if you don’t give her some relief.  It’s a real shame, 'cause I could go for some relief from you too.</i>”" + (getGame().urta.pregnancy.isPregnant ? "  She rubs her pregnant belly absentmindedly as she stares at you and Kath." : "") + "\n\n");
		outputText("As she walks away Kath props her head up on her hands and looks at you dreamily.");
		flags[kFLAGS.KATHERINE_LOCATION] = KLOC_BAR_URTA_REFUSED; //Shows the same options as when you get her drunk, except no option to see Urta
		katSexMenu();
	}
}

private function katherineSeeUrta():void {
	clearOutput();
	if (kGAMECLASS.urta.urtaDrunk()) {
		outputText("Katherine looks over at Urta’s table and sees that the captain is obviously sloshed.  She finishes off her drink and whispers, “<i>Now " + playerText() + ", I think we both know that if I go over there Urta is going to pound me into the floor.</i>”\n\n");
		outputText("You smile and say, “<i>Only if you ask nicely.</i>”\n\n");
		outputText("Kath stands up and offers you her hand.  “<i>I guess I’d better bring you along.  I might need help and besides, you always have some fun ideas.</i>”\n\n");
		outputText("Urta looks up as the two of you cross the open floor, her horse cock rising rapidly.");
		menu();
		addButton(0, "Watch", telAdre.katherineThreesome.watch, true);
		if (hasCock()) addButton(1, "Pin & Fuck", telAdre.katherineThreesome.pinAndFuck);
	}
	else {
		outputText("Katherine looks over at Urta’s table.  Urta catches her looking and gestures for both of you to come over.\n\n");
		outputText("Kath offers you her hand and says, “<i>I guess we’d better get over there.  It looks like Urta’s really horny and I wouldn’t want to disappoint her.</i>”\n\n");
		outputText("Given the warmth you feel from Katherine’s body you think that she’s projecting some of her own feelings onto Urta.  It doesn’t matter much to you.  No matter how you play this you’re likely to wind up with a pair of hot, naked herms on your hands.  Life as the champion can be so tough sometimes.\n\n");
		menu();
		if (player.gender == GENDER_NONE) {
			if (hasCock())
				addButton(0, "Roast You", telAdre.katherineThreesome.roastYou);
			else addButton(0, "Watch", telAdre.katherineThreesome.watch, false); //A non-drunk version of this scene deals with the difficult ones if Kath can't pound you
		}
		else {
			addButton(0, "Circlejeck", telAdre.katherineThreesome.circlejerk);
			addButton(1, "Roast Kath", telAdre.katherineThreesome.spitroastKath);
			if (hasCock()) addButton(2, "Roast You", telAdre.katherineThreesome.roastYou);
			if (player.hasCock()) addButton(3, "369", telAdre.katherineThreesome.threeSixtyNine);
		}
	}
}

private function katherineSeeVala():void {
	clearOutput();
	outputText("Kath looks like she’s ready for some fun but before you get started something else catches your eye.  You note that Vala is sitting at one end of the bar, her tray propped up beside her.  It looks like a slow night and Vala seems bored.  " + (flags[kFLAGS.KATHERINE_VALA_AFFECTION] < 5 ? "You decide it’s time to expand their horizons and" : "You know they enjoy each other’s company so you") + " motion for her to come over.\n\n");
	outputText("Vala flies over quickly.  When she arrives you pat the seat next to you. You’re sitting between your submissive cat " + catGirl("girl", "morph") + " on one side and your supersized faerie on the other.  You certainly walked a strange path to wind up here.");
	menu();
	addButton(0, "Fist Them", telAdre.katherineThreesome.fistKathAndVala);
	if (hasCock()) { //All but the fisting scene require Kath be a herm
		addButton(1, "Eat Out", telAdre.katherineThreesome.eatOutVala);
		if (!player.isTaur() && player.hasCock()) addButton(2, "Dbl Stuff", telAdre.katherineThreesome.doubleStuffVala);
	}
}

//Penetrate
private function katPenetrate():void {
	clearOutput();
	if (isAt(KLOC_BAR) || isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED)) { //At the bar
		outputText("Kath's tail twitches excitedly and she polishes off her drink, eager to see what you have in mind.\n\n");
		outputText("You take her hand and lead her outside, to " + (flags[kFLAGS.TIMES_FUCKED_URTA] > 0 ? "that familiar" : "the") + " alleyway behind the Wet Bitch.\n\n");
		outputText("She looks a little worried about getting caught, but she's too excited to refuse you.\n\n");
		flags[kFLAGS.KATHERINE_LOCATION] = KLOC_STREETS;
	}
	outputText("You suggest that maybe you could try penetrating one of Katherine's holes.  Without further ado, she strips herself off until she's wearing nothing but a lecherous grin.  She then turns around and " + (isAt(KLOC_KATHS_APT) ? "perches on the edge of her bed" : "leans on a crate") + ", waving her tail to freely show off both her tailhole and her already-dripping cunt" + (hasBalls() ? " above her dangling balls" : "") + ".  “<i>So, come on in,</i>” she purrs.\n\n");
	var vagina:Function = penetrateKatsVag;
	var anus:Function = pcPenetratesKatAnally;
	var double:Function = pcPenetratesKatDoubly;
	var sucknFucks:Function = suckNFuck;
	if (player.cockThatFits2(70) < 0) double = null;
	if (!hasCock() || knotSize > 4) sucknFucks = null;
	simpleChoices("Vagina", vagina, "Anus", anus, "Both", double, "SucknFuck", sucknFucks, "Back", katSexMenu);
}

//PC Penetrates Kath: Vaginal (doin' a cat doggy-style)
public function penetrateKatsVag():void {
	//Scene can happen in the streets, at Kath's apartment or at the lake
	var x:Number = player.cockThatFits(70);
	clearOutput();
	outputText(images.showImage("katherine-fuck-her-vagoo"));
	outputText("You don't even need to think about it.  Your eyes are locked on the cat-herm's silken, sopping wet pussycat pussy, which is already dribbling femlube down her ");
	outputText((hasBalls() ? ballAdj() + " scrotum" : catGirl("milky white", "black, furry") + " thighs") + " and puddling it onto the ground in anticipation.  Slipping off your garments, you saunter forward and gently stroke her damp lips, stage-whispering to her that it seems an obvious choice which hole you should take.  Katherine gives a playful giggle, a mewl of arousal, and ");
	if (isAt(KLOC_STREETS))
		outputText("positions herself over a nearby barrel");
	else if (isAt(KLOC_KATHS_APT))
		outputText("kneels at the edge of her bed");
	else //At the lake
		outputText("gets down on all fours");
	outputText(" so that it's easier for her to support the two of you.\n\n");

	outputText("As soon as she's ready, you waste no time in sliding your " + player.cockDescript(x) + " home, causing her to yowl in delight at being filled.  Her slippery walls, soft and slick like greased velvet, seem to ripple as if to purposefully swallow your cock, eager to have you bury yourself to the hilt.  Sopping wet as they are they pose no resistance, allowing you to glide in smooth as butter, yet they grip you and try in vain to hold you in.  Your thrusts and surges elicit the lewdest squelches and slurps, her slobbering cunny drooling all over your shaft and ");
	if (player.balls > 0)
		outputText((hasBalls() ? "both sets of " : "") + "balls");
	else outputText((hasBalls() ? "her balls" : "her thighs"));
	outputText(".\n\n");

	outputText("“<i>Oh, yeah!  Yes - AH!  It feels so good!</i>” Katherine yowls mindlessly, babbling in her delight at your penetrations.  You, for your part, just grab her " + catGirl("supple skin", "silken fur") + ", hold onto her narrow hips and keep on thrusting.  While you may have started out firmly in charge, as the pace picks up the cat-herm is the one to take the lead; she pushes back against you, bucking and thrashing so wildly you find yourself having to hang on for dear life as she fucks you senseless.  If it weren't for how wet she is, she'd be rubbing your cock raw from friction and the vice-like grip around your shaft.  " + (hasCock() ? "You can just make out the way her cock" + cockMultiple(" flails", "s flail") + " around, stiff as iron with knot" + cockMultiple("", "s") + " swollen to full size - she" : "She") + " can't be much further from climax...\n\n");

	outputText("And, indeed, she's not.  Arching her back in a way that would break a human spine, she lets out an ear splitting scream of ecstasy, making you unconsciously recall nights of being woken up by courting cats back in Ingnam.  " + (hasCock() ? "Cum gushes like a river from her cock" + cockMultiple("", "s") + " and her" : "Her") + " cunny floods over with femspray, splattering you and soaking " + (hasCock() ? "the ground and" : "") + " everything from your waist down.  As if signalled by her orgasm, your own climax seizes you by surprise.  ");
	if (player.hasVagina()) outputText("Your " + player.vaginaDescript() + " releases its own girl-cum in sympathy, even as y");
	else outputText("Y");
	outputText("our cock discharges into her depths, flooding her inviting nethers with your spunk, her pussy-lips drinking every last drop you have to give with insatiable greed.");
	if (player.cumQ() >= 1500) outputText("  Her belly puffs up and out, swelling like an advancing pregnancy, until finally you have finished, leaving her with a barrel-sized balloon of a gut, cum audibly sloshing inside her as her motions churn the liquid.");
	outputText("  Gasping, having spent yourself, you pull out, letting her nethers drool their sexual fluids onto the ground undisturbed.\n\nKatherine ");
	if (isAt(KLOC_STREETS))
		outputText("sprawls against the barrel");
	else if (isAt(KLOC_KATHS_APT))
		outputText("sprawls across her bed");
	else //At the lake
		outputText("collapses onto the soft grass");
	outputText(", flicking her tail lazily and purring loudly.  “<i>Mmm... you have no idea how good you are, lover,</i>” she tells you, before patting her belly and giggling softly.  “<i>I'm not saying I want to be a mom just yet");
	if (player.cumQ() >= 1500) outputText(" - though, honestly, you may not give me much of a choice - ");
	outputText(" but I think your little boys and girls and herms will make people very, very happy when they come of age.</i>”\n\n");

	outputText("With a smile, you scratch her behind the ears in a way that the cats in your village loved, enjoy her contented purr, clean yourself ");
	if (isAt(KLOC_STREETS))
		outputText("off with some old rags that the cat laid aside, and then politely say goodbye, redressing yourself and heading back out into Tel'Adre.");
	else if (isAt(KLOC_KATHS_APT))
		outputText("off in Kath’s washbasin, and then politely say goodbye, redressing yourself and heading back out into Tel'Adre.");
	else { //At the lake
		outputText("and Kath off with some lake water and a towel Kath brought.  You would like to stay longer and enjoy the view but it’s much safer to head back to Tel’Adre before something investigates all the noise you two just made.");
		if (player.cumQ() >= 1500) outputText("\n\nOn the journey back to the city both you and Kath rub her cum bloated belly, leaving a trail of juices that stretch from the shores of the lake to the edge of the desert.");
	}
	//lust -100, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	player.orgasm();
	orgasm();
	dynStats("sen", -1);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	doNext(camp.returnToCampUseOneHour);
}

//PC Penetrates Kath: Anal
public function pcPenetratesKatAnally():void {
	//Scene can happen in the streets, at Kath's apartment or at the lake
	var x:Number = player.cockThatFits(70);
	clearOutput();
	outputText(images.showImage("katherine-fuck-her-bungholio"));
	outputText("Thinking it over, your gaze falls upon the cat's " + catGirl("inviting", "ebony") + " pucker, and you smile to yourself before telling Katherine that you want a shot at her back door.  ");
	if (hasAlready(KBIT_TRIED_RECEIVE_ANAL))
		outputText("Kath smirks and her tail raises a little.  “<i>Mmmm... it is kind of fun.  Naughty too.</i>”");
	else outputText("Her eyes widen and she swallows hard, then she nods.  “<i>O-Okay... if you're into that sort of thing...</i>”");

	outputText("\n\nShe turns her head back and around and repositions herself so that ");
	if (isAt(KLOC_STREETS))
		outputText("she's properly supporting herself on the crate, timidly waiting");
	else if (isAt(KLOC_KATHS_APT))
		outputText("her hips are pressed firmly against the side of her bed frame and she timidly waits");
	else //At the lake
		outputText("her head is pressed against the grass and her ass and tail are raised high in the air. She looks back at you, timidly waiting");
	outputText(" for your approach.  Confidently you saunter up behind her, taking the opportunity to appraise your partner.  It's true that she's nothing to write home about in terms of ass size or perkiness, but her lean butt is solidly muscled and covered ");
	if (flags[kFLAGS.KATHERINE_UNLOCKED] < 4)
		outputText("in surprisingly luxurious-looking fur considering her probably-irregular diet");
	else outputText(catGirl("with inviting pale flesh", "in luxurious-looking fur"));
	outputText(", and you take this opportunity to run your hands appreciatively " + catGirl("over that smooth bottom", "through the soft hair") + ".  She coos and wriggles in delight, drawing your attention back to the matter at hand.  Katherine's vagina is already drooling in anticipation, despite her nervousness, and it's a simple matter for you to expose yourself and gather up some of her juices in the palm of your hand.  You painstakingly rub the juices into your " + player.cockDescript(x) + ", bringing it to full mast even as you get it nice and slick.  Then, you start massaging what's left of your handful of girl-lube into Katherine's tight asshole, making her squeak and moan as you get her wet.  Finally, you ask if she's ready.\n\n");

	outputText("“<i>I-I am!</i>” she insists, visibly trying to relax.  “<i>Just... j-jam it in!</i>”\n\n");

	outputText("No further encouragement needed, you press forward and begin sinking yourself into her tight" + catGirl("", " black") + " tailhole.  She moans like a virgin, her " + (hasCock() ? cockAdj() + cockType(" dog-cock", " kitty-cock") + cockMultiple("", "s") + " visibly jolting and her " : "") + "empty kitty-cunt clenching in sympathy as you slide yourself in.  Her anal walls lock around you like a vice of heated silk, gripping you and squeezing as if already trying to wring every last drop of cum out of you.  But you forge on, sliding inch after inch into her bowels until you can slide no more.  Then, slowly, you try to extract yourself - fighting every inch of the way, as her virgin-tight ass tries to suck you back.  Finally drawing out most of what you put inside, you slide yourself home again, slamming harder and faster into her hips, then pulling out, repeating this over and over.\n\n");

	outputText((hasCock() ? "Your kitty" : "The herm cat") + " gasps and moans, thrusting her sparsely-fleshed ass back to try and meet your hips as you continue to push, her inner walls milking and squeezing.  “<i>Ah!  Do you - oh! - know what the - yeah, yeah, fuck me like that, fuck me there! - advantage of a " + (hasCock() ? "herm - yesyesyes! - girlfriend" : "- yesyesyes! - girlfriend who was a herm") + " is, " + playerText() + "?</i>” she manages to gasp out.\n\n");

	outputText("You grunt and hiss as you abuse her insides, but manage to spare the breath to admit you don't.\n\n");

	outputText("“<i>The advantage is - oh! ah! - " + (hasCock() ? "I've got both sets of bits, so - ah! ah! AH! - it's good for me, like it'd be good for a guy" : "I had the same bits, so - ah! ah! AH! - I know exactly what you like") + "!</i>”  She lets out an excited yowl of bliss as you thrust particularly hard.  “<i>Ohh... ");
	if (hasCock())
		outputText("You're squeezing my prostate, rubbing all the parts in my ass that make my cock" + cockMultiple("", "s") + " jump, it's so good back there... so hard, so hot!  Fuck me, fuck me like an animal!</i>” she screams, starting to jerk her own hips, knot-swollen cock" + cockMultiple("", "s") + " spewing pre-cum as she mock-humps");
	else outputText("it's so good back there... so hard, so hot!  Fuck me, fuck me like an animal!</i>” she screams, starting to jerk her hips, mock-humping");
	outputText(" the air.  She's gonna blow any second now...\n\n");
	outputText("But you beat her to the punch and, with a howl of your own, you cum inside her, flooding her bowels with your spunk");
	if (player.cumQ() >= 500) outputText(" until her belly begins to bulge from all you've dumped in her");
	if (player.cumQ() >= 1500) outputText(", swelling out and out until she looks like she could give birth soon and a part of you wonders if maybe she's going to start spouting your cum from her mouth");
	outputText(".  In the midst of your orgasm, her own yowling cry goes unnoticed as her cunt spasms, ");
	if (isAt(KLOC_STREETS))
		outputText("raining femcum down onto the ground below" + (hasCock() ? " and her " + cockMultiple("cock sprays", "cocks spray") + " cum all along the crate and ground" : ""));
	else if (isAt(KLOC_KATHS_APT))
		outputText("the rain of femcum " + (hasCock() ? "mixing with the sprays of semen from her cock" + cockMultiple("", "s") + ", soaking her belly," : "soaking her") + " sheets and bed");
	else //At the lake
		outputText("raining femcum down onto the ground below" + (hasCock() ? " and her " + cockMultiple("cock sprays", "cocks spray") + " cum all over the grass" : "") + ".  It gathers into a slow moving stream that flows to the shore and mixes with the already polluted waters of the lake");
	outputText(".  Finally, you are spent, and pull yourself wetly from your gasping lover's ass.\n\n");

	outputText("She slinks bonelessly to the ground, still quivering from the afterglow, then smiles dreamily up at you");
	if (player.cumQ() >= 1500) outputText(", absently cradling her distended belly");
	outputText(".  “<i>What a fuck... can't say I don't prefer it in my pussy, but I'll always be up for " + (hasAlready(KBIT_TRIED_RECEIVE_ANAL) ? "more of that" : "another go") + " if you want.</i>”");
	if (player.cumQ() >= 1500) outputText("  She looks at her gut and shakes her head in disbelief.  “<i>Sheesh... if they ever figure out a way to let folks get pregnant by taking it up the ass, you're gonna knock up every damn person you meet, aren't you, stud?</i>”");

	outputText("\n\nWith a smirk at her flattery, ");
	if (isAt(KLOC_STREETS))
		outputText("you give her a hand getting dressed, then dress yourself and head back out into the street.");
	else if (isAt(KLOC_KATHS_APT)) {
		if (player.cor < 25)
			outputText("you roll Kath off her cum soaked bed and change the sheets for her while she cleans herself up.  When you’re done you give Kath a long kiss and tell her you hope to see her soon.  She beams with happiness as you leave.");
		else if (player.cor < 75)
			outputText("you give Kath a kiss and tell her you hope to see her soon.  She moans as she stretches and pulls herself to her feet.  She’s got quite the cleanup ahead of her.");
        else
			outputText("you tell Kath that you want her to lick up all that " + (hasCock() ? "" : "fem") + "cum she just sprayed.  You’ve heard it’s good for keeping her " + catGirl("her skin soft and smooth", "fur nice and shiny") + ".  She looks unsure, but starts licking the sheets.  You rub the back of her neck to encourage her and soon Katherine is lapping away at her own juices.  Leaving Kath to her meal, you walk back out onto the streets of Tel’Adre.");
	}
	else { //At the lake
		outputText("you help Katherine to her feet and collect all your things.  You have a long walk back to Tel’Adre waiting for you");
		if (player.cumQ() >= 1500) outputText(" and it will be even longer for Katherine thanks to her sperm stuffed colon.  Still, judging how Kath holds you tight on the trip back to Tel’Adre you don’t think she’d have it any other way");
		outputText(".");
	}
	//lust -100, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	player.orgasm();
	orgasm();
	dynStats("sen", -1);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	experience(KBIT_TRIED_RECEIVE_ANAL);
	doNext(camp.returnToCampUseOneHour);
}

public function pcPenetratesKatDoubly():void {
	//Scene can happen in the streets, at Kath's apartment or at the lake
	clearOutput();
	var x:Number = player.cockThatFits(70);
	outputText("You unfasten your " + player.armorName + ", exposing " + (player.cocks.length == 2 ? "both your hardening cocks" : "your collection of hardening cocks"));
	if (isAt(KLOC_KATHS_APT))
		outputText(".  You toss your clothes on the floor and lift an eager Katherine onto her bed");
	else {
		if (model.time.hours < 12)
			outputText("to the morning breeze");
		else if (model.time.hours < 18)
			outputText("to the warm afternoon air");
		else
			outputText("to the cool evening air");
		if (isAt(KLOC_LAKE)) outputText("of the lakeshore");
	}
	outputText(".  While stroking Kath’s " + catGirl("soft skin", "fur") + " you tell her that she has two delectable holes and you want to fill them both.\n\n");

	outputText("Her eyes open wide but so do her thighs.  " + (hasCock() ? "Her cock" + cockMultiple(" strains", "s strain") + " against her " + clothesLowerChoice("pants", "skirt", "bodysuit", "dress", "robe") + ".  You" : "You tease her by rubbing them gently, then you") + " pull the clothes off your horny kitty and tell her you want her down on all fours.  Kath eagerly complies, kneeling ");
	if (isAt(KLOC_STREETS))
		outputText("in the soft dirt of the alley");
	else if (isAt(KLOC_KATHS_APT))
		outputText("on top of her bed");
	else //At the lake
		outputText("in the sand at the water’s edge");
	outputText(" and presenting her pussy and ass.\n\n");
	
	outputText("You start by stroking Katherine’s tail.  It swishes back and forth, seeming more excited than the rest of her.  When you probe her hot little pussy you find it dripping wet.  You slide your uppermost dick between Kath’s thighs, coating it with the copious supply of lube.\n\n");

	outputText("Kath’s hands ");
	if (isAt(KLOC_STREETS))
		outputText("dig into the dirt and s");
	else if (isAt(KLOC_KATHS_APT))
		outputText("tighten, bunching up her sheets. S");
	else //At the lake
		outputText("dig into the sand and s");
	outputText("he lets out a low, feral meow.  Taking that as your cue you raise your hips slightly and press your slick cockhead against her pucker. " + (player.cocks.length == 2 ? "Your lower cock" : "One of your other cocks") + " nestles between the pink folds of her pussy.\n\n");

	outputText("As soon as Kath feels both cocks seating against their targets she tries to push back.  You’re having none of it though.  You tighten your hands on her " + catGirl("smooth", "fuzzy") + " hips, stopping her and making it clear this fucking is going to happen at your pace.  Kath’s head sinks until her forehead rests on her balled up hands and she mewls plaintively, like a kitten begging for cream.\n\n");

	outputText("Your " + (player.balls > 0 ? "balls twitch" : "prostate twitches") + ", letting you know there’s plenty of cream for this sex kitten.\n\n");

	outputText("You ");
	if (player.cor < 25) {
		outputText("fight against your base urges and work to make sure Katherine enjoys this completely.  Ever so slowly you slide both your cocks into her waiting holes.  You shift your hips so the cock in her pussy is pressed hard against her clit.\n\n");

		outputText("Then, with tiny strokes - each only a little deeper than the last, you gently pry open Kath’s most sensitive parts.  As you do her mewling continues and you feel her whole body getting warmer.  You begin to increase the pace, never quite fast enough for Katherine’s liking, though you know that thanks to the slow speed she’s enjoying it immensely.");
	}
	else if (player.cor < 75) {
		outputText("press against Kath until both cockheads are inside her.  You stop, enjoying the feeling of being inside your lover twice over.  Then, in one slow continuous stroke you force both cocks in until they’re buried to the root.\n\n");

		outputText("Kath tries to make you go faster, both by trying to push her hips back and by whispering “<i>Yes, yes. More!</i>”  After the first stroke you’re willing to accommodate her.  You begin to increase the pace until you’re pistoning into Katherine’s moist holes.  Her loud mewls and screams of “<i>Yes!</i>” are testament to how much she’s enjoying this.");
	}
	else {
		outputText("make sure your grip is solid and your rock hard cocks are lined up perfectly.  Then you yank back on Kath while thrusting forward.  A piercing yelp fills the air, bringing a smile to your lips.  You want this to be a fucking Kath will remember.\n\n");

		outputText("You don’t give your feline fucktoy a chance to recover or adjust.  If she wants to present both her holes to you then you are going to fuck her twice as hard!  At first she tries to pull away, then she tries to slow you down.  You ignore it all, jackhammering into her most sensitive parts at the pace you desire.  After countless strokes you hear a long moan and you know Kath is finally into it.");
	}

	outputText("\n\nYou’re about to " + (hasCock() ? "reach down and give Kath’s cock" + cockMultiple("", "s") : "give Kath's nipples") + " some attention when you feel her tense and hear a squirting noise.  Looks like she managed to cum before you did.  ");
	if (hasCock())
		outputText("Against your uppermost cock you can feel the pounding of Kath’s prostate as " + (hasBalls() ? "she empties her balls" : "it forces out her load"));
	else outputText("Both Kath's holes attempt to crush your cocks, her inner folds pulsing and squeezing in a very pleasant way");
	outputText(".  Katherine’s body goes limp and only your hands on her hips and your cocks inside keep her ass in the air.\n\n");

	if (hasCock()) {
		if (isAt(KLOC_STREETS))
			outputText("The dirt beneath her is already turning into a sticky mud puddle");
		else if (isAt(KLOC_KATHS_APT))
			outputText("The bed sheets are soaked" + (cumQ() > 1500 ? ".  In fact Kath’s cum is pooling on the floor too," : ""));
		else //At the lake
			outputText("A good amount of gritty semen slides down the beach and into the lake");
		outputText(" so there’s no sense in stopping now.  In fact you hope you can " + (player.cor < 50 ? "encourage" : "force") + " your " + catGirl("pet cat girl", "feline friend") + " to add another helping to the mess.\n\n");
	}

	outputText("You continue to pound your cocks into Katherine’s slack body.  The only reason you know she’s still conscious is the soft purring that vibrates through her whole body.  You feel it in your hands and, more acutely through your cocks and that gives you an idea.\n\n");

	outputText("You thrust and thrust until you’re right on the edge of cumming.  Then you jamb both cocks deep inside Kath.  The resonance of her purring makes it feel like your cocks are rubbing against one another inside her.\n\n");

	var wombShot:Boolean = player.cocks[x].cockLength > 14 && pregSize() == 0; //Only available if you’re huge and she doesn’t have a bun in the oven
	if (wombShot) {
		var cockLength:int = Math.round(player.cocks[x].cockLength);
		outputText("You feel something amazing.  Inside Kath’s pussy there’s a tightness right at the tip of your cock.  It’s like a tiny donut is sliding over your cock head.  Then it gives way.  You hear a sharp intake of breath as your cock springs forward.  You realize " + (cockLength <= 16 ? "your cockhead is" : "the first " + (cockLength - 14) + " inches of your cock are") + " now nestled inside Katherine’s womb.\n\n");
	}

	outputText("The sensation overcomes you and your " + (player.balls > 0 ? "balls pull tight against your groin" : "engorged prostate squeezes") + " firing the first of many salvos into Katherine’s limp body.\n\n");

	outputText("You fire your load into both Kath’s holes");
	if (player.cocks.length > 2) outputText(" while at the same time your other cock" + (player.cocks.length > 3 ? "s " : " ") + (hasCock() ? (player.cocks.length > 3 ? "add" : "adds") + " to the" : "create a") + " mess beneath her");
	if (player.cumQ() < 500)
		outputText(".  The eruption is soon over, and with no outward signs.  Only your cocks, deep inside Kath’s " + (wombShot ? "womb" : "pussy") + " and colon can feel the pools of your sticky deposits.");
	else if (player.cumQ() < 1500)
		outputText(".  The eruption is soon over, and Kath’s belly bulges from your twin deposits.  Your cocks, deep inside Kath’s " + (wombShot ? "womb" : "pussy") + " and colon can feel the pools of hot, sticky liquid.  They’re under pressure, but still sealed in by your erections.");
	else {
		outputText(".  Again and again your " + (player.balls > 0 ? "balls contract" : "prostate contracts") + ", fighting ever greater resistance as every void inside Kath is packed with your juices.  You no longer have to support Katherine’s hips - her cum stuffed belly rests against the ");
		if (isAt(KLOC_STREETS))
			outputText((hasCock() ? "spermy" : "femcum soaked") + " mud");
		else if (isAt(KLOC_KATHS_APT))
			outputText((hasCock() ? "" : "fem") + "cum soaked sheets");
		else //At the lake
			outputText((hasCock() ? "spermy" : "femcum soaked") + " sand of the beach");
		outputText(".  Anyone would take her to be pregnant, days from delivering twins or triplets.\n\n");

		if (player.cumQ() >= 3000) {
			outputText("Even your iron erections are unable to hold back the flood from your unnaturally bountiful " + (player.balls > 0 ? "balls" : "prostate") + ". Kath’s skin is so taut " + catGirl("you can see stretch marks developing", "that her belly fur begins to lighten.  Looking closely you can see that each hair is being forced to stand on end") + ".\n\n");

			outputText("Then you feel the first trickles running back along your cocks.  Your " + (player.balls > 0 ? "balls pump" : "prostate pumps") + " again and the trickle becomes a torrent.  You now have to hold on to Kath’s hips just so she doesn’t launch off of you.\n\n");
		}

		outputText("Finally the torrent stops and ");
		if (wombShot) {
			if (doneSubmissive(KBIT_SUB_HIGH_CUM)) { //Repeats of this scene are allowed regardless of corruption
				outputText("you recall there's a fun way to ‘help’ her.");
				simpleChoices("Squeeze", pcPenetratesKatDoublyHighCumCorrupt, "Cuddle", pcPenetratesKatDoublyNormalEnd, "", null, "", null, "", null);
				return;
			}
			if (player.cor >= 75 || (player.findPerk(PerkLib.Pervert) >= 0 && player.cor >= 33) || player.findPerk(PerkLib.Sadist) >= 0) { //First time you have to be corrupt
				outputText("your perverse mind comes up with a way to ‘help’ her.");
				simpleChoices("Help", pcPenetratesKatDoublyHighCumCorrupt, "Cuddle", pcPenetratesKatDoublyNormalEnd, "", null, "", null, "", null);
				return;
			}
		}
		if (player.cor >= 25)
			outputText("you rub Kath’s back until she lets out a less than lady like burp.");
		else
			outputText("you gently massage Kath’s sides until her belly gurgles and she lets out a small belch.");
	}
	doNext(pcPenetratesKatDoublyNormalEnd); //If, for any reason, you don't qualify for the high cum corrupt ending then jump to this ending automatically
}

private function pcPenetratesKatDoublyNormalEnd():void {
	clearOutput();
	outputText("You’re not done with Kath yet.  With some effort you pull her up until she’s sitting on your lap" + (player.cumQ() >= 1500 ? ", her belly wobbling obscenely in front of you both" : "") + ". When you " + (hasCock() ? "take hold of " + cockMultiple("her flaccid cock", "both her flaccid cocks") : "firmly grip her clit") + " it snaps her out of her reverie.\n\n");

	outputText("“<i>Oh, that was so good,</i>” she says dreamily.  “<i>We have to do that again sometime.</i>”\n\n");

	outputText("You begin to work her " + (hasCock() ? "softening shaft" + cockMultiple("", "s") : "nub back and forth") + " and Kath squirms.  “<i>No, I didn’t mean now.  " + (hasCock() ? "I’m empty!" : "I just came!") + "</i>”\n\n");

	outputText("You keep " + (hasCock() ? "stroking her cock" + cockMultiple(",", "s,") : "playing with her clit, rolling it around ") + " faster and faster.  Kath pants and moans but she's too tired to get away.  " + (hasCock() ? "Her prick" + cockMultiple(" grows", "s grow") + " hard and hot in your hands" : "You feel the heat developing within her pussy and her ass") + ".\n\n");

	outputText("It takes many minutes of furious stroking to build Kath back to a point where she can cum.  All the while she writhes in your arms, lost in a mixture pain and pleasure.  When she does finally cum her hips thrust forward, " + (hasCock() ? "trying to bury her cock" + cockMultiple(" in an imaginary pussy", "s in a pair of imaginary pussies") + " but succeeding only in " : "") + "pulling her free of your cocks.\n\n");

	outputText("Kath lands in the puddle of " + (hasCock() ? "spooge" : "fluids") + " and begins to add to it" + (hasCock() ? " in almost every way possible.  Her cock" + cockMultiple(" blasts a stream", "s blast twin streams") + " into the air while" : ",") + " her pussy and pucker discharg" + (hasCock() ? "e" : "ing") + " the loads you provided earlier.\n\n");

	if (isAt(KLOC_STREETS))
		outputText("Completely spent, Kath falls to the muddy ground with a massive wet splat.  You give her a little pat on the head and promise you’ll see her soon.  All you get in reply is a contented murmur.");
	else if (isAt(KLOC_KATHS_APT))
		outputText("Completely spent, Kath collapses back onto the bed with a massive wet splat.  You give her a little pat on the head and promise you’ll see her soon.  All you get in reply is a contented murmur followed by some snoring.");
	else //At the lake
		outputText("When she recovers Kath washes herself off in a nearby stream and then the two of you begin the long march back to Tel’Adre.  When you reach the gates you put your arms around Kath, give her a long kiss and promise you’ll see her soon.");
	player.orgasm();
	orgasm();
	dynStats("sen", -1);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	doNext(camp.returnToCampUseOneHour);
}

private function pcPenetratesKatDoublyHighCumCorrupt():void {
	clearOutput();
	var firstTime:Boolean = !doneSubmissive(KBIT_SUB_HIGH_CUM);
	if (firstTime) {
		outputText("You grip her belly and squeeze hard, increasing the pressure even as Kath’s uncoordinated limbs flop around, trying to find some escape.  Kath wheezes in pain as you force the air from her lungs.\n\n");

		outputText("You enjoy her discomfort so much that your cocks stay hard, plugging the holes she’s desperate to open.  When you force your hands even deeper into her flesh, kneading her overfilled belly, you finally feel something give way.\n\n");

		outputText("The pressure in her gut lessens and you hear Kath cough wetly.  You laugh and give her a good slap on the ass as she coughs up several more mouthfuls of your seed.\n\n");

		outputText("Kath takes a few shallow breaths before angrily saying, “<i>I can’t believe you just did that.</i>”\n\n");

		outputText("You rub her sides and tell her that you know how much she loves the taste of your cum.  This way she doesn’t have to wait.\n\n");

		outputText("“<i>I... I don’t like the taste that much.  I like to suck your cock because it pleases you.</i>”\n\n");

		outputText("You tell her that this did please you and you hope she can please you like this again.  As you continue to rub her sides you tell her this is the best feeling for you.  The idea that you’ve filled her, end to end.  The feeling of being inside her - the hot, sticky full feeling, is so good you almost want to cum again.\n\n");

		outputText("“<i>Oh please don’t!  I couldn’t take it.</i>”\n\n");

		outputText("She doesn’t sound as pissed off as she did before.  You smile to yourself and begin tracing your fingers seductively " + catGirl("over her silky skin", "through her soft fur") + ".  Time to heap on some more praise.  You tell her you’ve never felt as satisfied as you do right now.  The sight of her cum filled form makes you want her all the more.  You press against her belly once again; Kath lowers her head and takes shallow breaths while she waits for you to finish.");
		addSubmissive(KBIT_SUB_HIGH_CUM);
	}
	else { //Repeat business
		outputText("You grip her belly and squeeze, ratcheting up the pressure that you know will overcome the involuntary resistance of her innards.  Kath mewls in a mixture of pain and pleasure, wiggling her hips and inadvertently keeping your cocks hard.  When you force your hands even deeper into her flesh, kneading her overfilled belly, you feel the familiar sensation of her inner sphincter giving way.\n\n");

		outputText("The pressure in her gut lessens.  Looking over Kath’s shoulder you can see her drooling thick ropes of your cum onto the " + (isAt(KLOC_KATHS_APT) ? "bed" : "ground") + ".  She smacks the ground with her fist a few times and you ease up, giving her a chance to recover.\n\n");

		outputText("Kath sucks in a lungful of air and you squeeze her once more.  Already weakened, her innards give way more easily and once again your cum bubbles out of her throat.  You repeat this a few more times, allowing her to breathe then forcing more of your sperm through her digestive tract in the wrong direction.\n\n");

		outputText("You only stop when your cocks soften enough that the load in her womb starts to leak out, relieving the pressure.  Kath coughs to clear her throat and you tell her she did well, she let you fill her whole body with cum like a good girl.  After catching her breath Kath replies, “<i>I’m glad you enjoyed it " + playerText() + ".  It’s such a strange ride for me.</i>”\n\n");

		outputText("As you continue to rub her sides you tell her again that this is the best feeling you’ve ever experienced.  The feeling of being inside her - of knowing how completely you filled her, is so good you almost want to cum again.\n\n");

		outputText("“<i>I don’t know - I’m already so full.  I probably won’t even eat dinner tonight.</i>”\n\n");

		outputText("You smile to yourself and begin tracing your fingers seductively " + catGirl("over her silky skin", "through her soft fur") + ", telling Kath that if she keeps talking like that she’ll get an encore for sure.  She purrs in reply - you can’t tell if she’s asking for another helping or just enjoying what your fingers are doing.");
	}
	outputText("\n\nWhen your cocks finally go completely soft you pull out and get dressed, waiting for your bloated ");
	if (player.cor < 25) outputText("mate");
	else if (player.cor < 75) outputText("partner");
	else outputText("cum dump");
	outputText(" to recover");
	if (isAt(KLOC_LAKE)) {
		outputText(", which takes far longer than you’d like.\n\n");

		outputText("Kath washes herself off in a nearby stream before the two of you begin the long march back to Tel’Adre.  When you reach the gates");
	}
	else {
   		outputText(".  Finally Kath stands on rubbery legs and");
	}
	outputText("you put your arms around her.  Katherine gives you a delighted smile and you tell her " + (firstTime ? "that it will be much easier and much sexier for her" : "you’re already looking forward to") + " next time.\n\n");
	
	outputText("She blushes and gives you a kiss.  On the way back to camp you wonder what other tricks you can teach your submissive " + catGirl("cat girl.", "kitty."));
	player.orgasm();
	orgasm();
	dynStats("sen", -1);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	doNext(camp.returnToCampUseOneHour);
}

//Suck 'n' Fuck (unavailable if knot > 4")
public function suckNFuck():void {
	//Scene can happen in the streets or at Kath's apartment
	var x:Number = player.cockThatFits(70);
	clearOutput();
	outputText(images.showImage("katherine-fuck-and-suck"));
	outputText("You think it over, then find your gaze drifting to Katherine's sheath and the " + cockType() + " cockflesh within.  ");
	if (hasAlready(KBIT_TRIED_RECEIVE_SUCK_N_FUCK))
		outputText("It's quite the sight when she curls up and swallows her own shaft, so you ask her if she'd like another suck 'n fuck.\n\nHer eyes light up and her cock" + cockMultiple("", "s") + " jump at the suggestion.  She absentmindedly runs a finger around her knot" + cockMultiple("", "s") + " and says, “<i>Sure, I'm game.</i>”");
	else outputText("Recalling how you helped the poor herm shrink down her monster knot" + cockMultiple("", "s") + ", and remembering the flexibility of the cats you've seen, you find a very kinky idea coming to you.  You ask Katherine if she'd be willing to try a suck 'n fuck.\n\n“<i>Excuse me?</i>” she asks, raising an eyebrow.  You quickly explain the idea: that you penetrate her vagina at the same time that she performs oral sex on her own cock, at which her eyes light up.  “<i>Sounds kinky - but also genius!  Sure, I'm game.</i>”");
	outputText("  She smiles, and ");
	if (isAt(KLOC_STREETS))
		outputText("turns around so that she is sitting on the crate instead of leaning on it");
	else //Kath’s Apartment
		outputText("sits down on her bed and spreads her legs");

	outputText(".\n\nStill smiling, she begins to gently stroke her sheath" + (hasBalls() ? ", balls" : "") + " and pussy, coaxing out her " + cockType("dog", "cat") + " cock" + cockMultiple("", "s") + ".  Making sure she's positioned so that she's not going to tumble off in mid-fuck, she takes hold of her thighs and bends over... and over... until she has practically pressed her nose into her own crotch.");
	if (player.findPerk(PerkLib.Flexibility) < 0) outputText("  The sight is enough to make your spine wince in sympathy.");
	//(player has Feline Flexibility:
	else outputText("  You watch how she does it, resolving to test your body and see if you can bend like that.");
	outputText("  Having loosened up, she straightens her back until her mouth is hovering in front of the tip of her " + cockMultiple("", "topmost ") + cockType("dog", "cat") + " cock.  Her cat-like tongue, long, flat, and bristly looking, reaches out to stroke the " + cockType("rubbery, conical", "narrow, barbed") + " tip, slurping around it and getting it nice and slick.  Then, she opens her mouth and starts bending forward again, gulping down all " + cockLength + " inches of " + cockType("dog", "cat") + " cock until she reaches the knot.  A moment's hesitation, to muster her courage, and then she engulfs it as well, pressing her nose flat against her own " + (hasBalls() ? "ballsack" : "taint") + ".\n\n");

	outputText("This is your moment, and you step forward, gently but firmly taking hold of her thighs, positioning your " + player.cockDescript(x) + " against her slavering cunt.  Certain you are in position, you slide it home.  She shudders and audibly slurps on her cock as you sheathe yourself in her slick, velvety, burning hot nether lips.  You pull back and thrust home again, even as she begins to bob her head.\n\n");

	outputText("It is awkward, at first, the two of you trying to set up mutually complementary rhythms.  She hums and rumbles in her throat, striving to coax the most pleasure from her male genitalia, even as your thrusts and bucks make her cunt slurp and squelch, her copious lubricants slopping across your dick");
	if (player.balls > 0) outputText(", your balls,");
	outputText(" and your inner thighs.  But, as you keep going, you get into the rhythm and it becomes more pleasurable.\n\n");

	outputText("It's impossible to describe just how kinky this is; her hot, wet walls wrapped like a silken vise around your cock, her head bobbing and gurgling on her own right in front of you" + cockMultiple("", ", and her lower shaft waving in the air between you as if to conduct the performance") + ".  You thrust into her harder and harder; you can feel your climax coming... but she's the one who comes first.  With a muffled yowl, she squirts femcum from her cunt, splattering your belly in her juices.  The cry is cut off and her lips and cheeks visibly bulge as her knot suddenly inflates, trapping her cock in her own mouth and forcing her to drink every last drop as her balls release their cargo into her.  ");
	//This was previously based on Kath's ball size
	var kathCum:Number = cumQ();
	var playerCum:Number = player.cumQ();
	if (kathCum <= 500)
		outputText("She gulps several times, loudly drinking until her balls are empty, but even so she remains locked in place, her knot trapping her until she's fully climaxed.");
	else if (kathCum <= 1500)
		outputText("She has to drink quickly to avoid choking on her own copious discharge, but finally, belly beginning to bulge, she's drunk it all.");
	else outputText("With a frantic look she swallows and swallows, and you can't help the frightening thought she may drown in her own spunk.  But, as her belly swells and she looks verifiably pregnant, her balls stop trembling and she's done, panting and taking deep, grateful breathes through her nose.");
	outputText("\n\n");

	outputText("And now, at last, it's your turn to cum, and with a loud moan you release into her.  ");
	if (playerCum <= 250)
		outputText("You spray everything you have into her sloppy, sopping-wet cunt, allowing it to join the other fluids already dripping from her gash.");
	else if (playerCum <= 750) {
		if (kathCum <= 500)
			outputText("  Her belly bulges as you flood her womb with your sperm, visibly distended from your efforts.");
		else outputText("  She looks heavily pregnant by the time you are done, her bellybutton beginning to brush against her chin.");
	}
	else {
		if (kathCum <= 500)
			outputText("  Your unnatural orgasm leaves her visibly bloated and distended, stomach swollen and round in the curve of her body.");
		else {
			outputText("  The cat herm looks panicked as you just keep pouring jet after jet into her body, her womb swelling and her skin already distended from her own massive discharge into her stomach.  Her belly swells out and out until it is visibly pushing against her neck and upper torso, her own body forming an impenetrable barrier that leaves it with nowhere to expand to, the pressure making your cum squirt out in jets that splatter all over the ");
			if (isAt(KLOC_STREETS))
				outputText("alley.");
			else //Kath’s Apartment
				outputText("floor of her apartment.");
		}
	}
	outputText("\n\n");

	outputText("Your climax finished, you pull out");
	if (playerCum > 250) outputText(", allowing a cascade of jism to flow like a perverse waterfall in miniature from her cunt,");
	outputText(" and step back to catch your breath.  Your smile at her, initially one of pleased relief, turns to wry grin as you realize she's still knotted up and plugged inside her own mouth.  She looks at you as best she can and blinks.  With a gentle expression you step close and reach out to stroke her ears; nothing sexual, just gentle and relaxing.  She closes her eyes and visibly leans into the caresses.\n\n");

	outputText("You stay like that until her knot shrinks down and, with a wet popping sound, she uncurls herself.  “<i>" + (hasAlready(KBIT_TRIED_RECEIVE_SUCK_N_FUCK) ? "By Marae, was that ever good" : "Boy, that was really something") + ",</i>” she declares in an amazed tone");
	if (kathCum > 500 || playerCum > 250) {
		outputText(", slapping her ");
		if (kathCum > 1500 || playerCum > 750) outputText("hugely ");
		outputText("swollen, cum-filled gut for emphasis");
	}
	outputText(".  “<i>I'm ready to try that again if ever you are.</i>”\n\n");

	outputText("You promise her you'll remember that.  Redressed, you bid her farewell and head back out into the streets of Tel'Adre.\n\n");
	//lust -100, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	player.orgasm();
	orgasm();
	dynStats("sen", -1);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	experience(KBIT_TRIED_RECEIVE_SUCK_N_FUCK);
	doNext(camp.returnToCampUseOneHour);
}

//Get Penetrated
private function letKatKnotYou():void {
	var x:Number;
	clearOutput();
	if (isAt(KLOC_BAR) || isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED)) { //At the bar
		outputText("As you wait for Katherine to finish off her drink you start rubbing " + (player.isNaga() ? "the tip of your tail" : "your toe") + " up and down her leg.\n\n");
		outputText("Kath shivers as you go over all the things you'd like to do with her, but you notice she's most excited when you talk about letting her feed her " + cockType() + " cock" + cockMultiple("", "s") + " into your body.\n\n");
	}
	else letKatKnotYouCommonDialogue(false); //Either at her apartment or behind Oswald's
	//[Vagina] [Anus] [Double Penetrate] [Sucked 'n' Fucked]
	var dubs:Function = null;
	if (cockNumber > 1 && player.hasVagina()) dubs = getDoublePennedByKat;
	var sukn:Function = null;
	var vag:Function = null;
	if (player.hasVagina()) vag = letKatKnotYourCuntPussyFuck;
	//This scene requires the PC has a penis and has fucked Kat at least once since moving her
	if (player.hasCock() && flags[kFLAGS.KATHERINE_TIMES_SEXED] > 0) sukn = suckedNFuckedByKat;
	var backroomFuck:Function = (isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED) ? drunkFuck : null);
	choices("Vagina", vag, "Anus", getPenetrated, "DblPenetr", dubs, "SuckNFuckd", sukn, "Backroom", backroomFuck, "", null, "", null, "", null, "", null, "Back", katSexMenu);
}

private function letKatKnotYouCommonDialogue(inAlleyBehindBar:Boolean):void {
	if (inAlleyBehindBar) {
		outputText("Kath glups down the last of her drink, grabs your hand and drags you toward the alley.\n\n");
		outputText("Once outside she gives you a big hug, her whole body flushed with excitement.  “<i>Now what was it you were saying back in the bar?  I was a little distracted.</i>”\n\n");
		flags[kFLAGS.KATHERINE_LOCATION] = KLOC_STREETS;
	}
	var hasPenetrated:Boolean = hasAlready(KBIT_TRIED_GIVE_VAGINAL | KBIT_TRIED_GIVE_ANAL | KBIT_TRIED_GIVE_DOUBLE_PEN | KBIT_TRIED_GIVE_SUCK_N_FUCK);
	outputText("You ask Katherine if she'd like to penetrate you.  She " + (hasPenetrated ? "" : "looks startled, then " ) + "grins like the proverbial cat that ate the canary.  “<i>Well, all right then...</i>” she declares, swiftly stripping off her clothes.  “<i>Get undressed, turn around and kneel on the " + (isAt(KLOC_KATHS_APT) ? "bed" : "ground") + ".</i>”  Her " + cockType() + " cock" + cockMultiple(" is", "s are") + " already starting to peek out of her sheath, as if to echo her instructions.\n\n");
	outputText("You do as you are told, but you can't resist teasing her about wanting 'doggy-style' sex.\n\n");
	outputText("The " + cockType("mismatched ", "") + "herm steps up behind you and gives you a playful slap on your " + player.buttDescript() + ".  “<i>Well, I");
	if (hasDogCock())
		outputText("'ve got " + cockMultiple("a dog dick", "dog dicks"));
	else outputText(" had " + cockMultiple("a dog dick", "dog dicks") + " for a long time");
	outputText(", so I'm just doing it the way nature intended,</i>” she cracks.");
	//(if player has anus & vagina:
	if (player.hasVagina()) outputText("  “<i>So, which hole do you want me to use?</i>”");
}

//Get Penetrated (Vaginal)
public function letKatKnotYourCuntPussyFuck():void {
	//Scene can happen in the streets or at Kath's apartment
	clearOutput();
	outputText(images.showImage("katherine-fucks-you-knottily-in-the-vagoo"));
	if (isAt(KLOC_BAR) || isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED)) letKatKnotYouCommonDialogue(true); //At the bar
	outputText("You indicate to Katherine that you want it in your " + player.vaginaDescript() + ".\n\n");

	outputText("Her furry hands promptly begin to rub possessively over your " + player.assDescript() + ", slowly moving up to take hold of your " + player.hipDescript() + ".  “<i>Well, all right... if that's what you want...</i>”  You feel her running " + cockMultiple("her ", "the topmost ") + cockLength + "\" cock against your sensitive pussy lips, letting you feel its " + cockType("rubbery-smooth", "barb-covered") + " length, then, drawing back her hips, she suddenly thrusts it home without any hesitation.");
	if (cockNumber > 1) {
		outputText("  Her second cock slaps lewdly against your ");
		if (player.hasCock()) outputText(player.multiCockDescriptLight());
		else if (player.balls > 0) outputText(player.sackDescript());
		else outputText("belly");
		outputText(".");
	}
	var cunt:Number = player.vaginas[0].vaginalLooseness;
	//(hymen check and stretching)
	player.cuntChange(cockArea(), true, true, false);
	outputText("\n\n");

	if (cunt < player.vaginas[0].vaginalLooseness) {
		outputText("You can't help but yelp in shock and look back over your shoulder at Katherine, who has the grace to appear apologetic.  “<i>Sorry!  But I need to penetrate fast - or would you rather wait until my knot's fully swollen?</i>”  You concede she has a point, but ask her to remember to be more gentle next time.\n\n");
	}

	outputText("Fingers digging into your hips, she begins to thrust back and forth inside of you");
	if (cockNumber > 1) outputText(", her second cock still slapping wetly against you and smearing trickles of pre-cum that stretch and dangle as it bounces");
	outputText(".  She grunts and groans.  “<i>Oh- Oh yeah, you're unbelievable!");
	if (player.harpyScore() >= 4 || player.sharkScore() >= 4 || player.catScore() >=4 || player.dogScore() >= 4 || player.bunnyScore() >= 4) outputText("  Mmm... yeah, that's it, moan for me, you little slut; who's the alpha, huh?  Katherine's your alpha - go on, say it!</i>” she yells, pounding herself into you with greater force, her claws extending just far enough to begin biting into your flesh, pinpricks of pain to counter the pleasure.");
	else outputText("</i>”");
	outputText("\n\n");

	outputText("You moan and gasp, thrusting your ass back into your feline lover's midriff to facilitate your fucking");
	if (player.isNaga() || player.tailType == TAIL_TYPE_LIZARD || player.tailType == TAIL_TYPE_DEMONIC) outputText(", snaking your tail up between her breasts and playfully stroking her cheek,");
	outputText(" and crying out her name.  You can feel her knot starting to swell inside you even as she picks up the pace with which she hammers into you.\n\n");

	outputText("“<i>Ohhh!  Gonna plug you up; fill you fulla kitty-cat spunk!</i>” Katherine moans, her knot growing to its maximum size inside of you, anchoring you together so that she can no longer pull out.");
	//(stretch check again)
	cunt = player.vaginas[0].vaginalLooseness;
	player.cuntChange(cockArea(), true, true, false);
	outputText("  She lunges forward and grabs your shoulders, trying to push her way in deeper.");
	//(if stretched:
	if (cunt < player.vaginas[0].vaginalLooseness) outputText("  The amount of swollen cockmeat she's stuffing inside you is on the border of being painful, but mostly it's pleasure that fills you.");
	else outputText("  Thanks to the glovelike fit your pussy has on her knot, it feels nothing but good to be plugged up like this.");
	outputText("\n\n");

	outputText("You shudder and gasp as your own climax suddenly rocks through you, femcum splashing from your " + player.vaginaDescript());
	if (player.hasCock()) {
		outputText(" and your cocks spurting ");
		if (player.cumQ() < 25) outputText("drops");
		else if (player.cumQ() < 100) outputText("splashes");
		else if (player.cumQ() < 250) outputText("puddles");
		else outputText("a veritable lake of spunk " + (isAt(KLOC_KATHS_APT) ? "onto the bed" : "into the alleyway"));
	}
	outputText(".\n\n");

	outputText("She suddenly arches her back and lets out a yowl of pleasure as her orgasm follows, rippling through her; she cums, groaning, inside you");
	if (cockNumber > 1) outputText(", with more spurting from her second cock to glaze your belly and the " + (isAt(KLOC_KATHS_APT) ? "sheets" : "ground") + " below");
	outputText(".  ");
	//These cum volumes were previously based on Kath's ball size
	if (cumQ() <= 500)
		outputText("She makes a surprisingly large amount of cum for " + (hasBalls() ? "such small balls" : "a herm without balls") + ", and you can feel it sloshing and slurping inside you, leaving you deliciously full of cat-cream.");
	else if (cumQ() <= 1500)
		outputText("Jet after jet of cum sprays inside you," + (pregSize() > 0 ? "" : " flooding all the way up into your womb;") + " by the time the " + cockType("dog-dicked cat", "barbed tip") + " stops, your belly is starting to bulge from all she's given you.");
	else {
		outputText("She cums and she cums and she cums; how can she hold this much spooge inside her " + (hasBalls() ? "balls" : "prostate") + "?  Your " + (pregSize() > 0 ? "pussy" : "womb") + " is flooded until by the time she finishes, you look certifiably pregnant and ");
		if (knotSize >= 6)
			outputText("only her huge knot is keeping everything plugged inside you.");
		else outputText("some of it actually starts leaking out around her knot.");
	}
	outputText("  Her load spent, she collapses bonelessly onto her back - thanks to her knot, though, she remains plugged inside you and you yelp in shock as her weight pulls you backward.\n\n");

	outputText("“<i>Oops.  Sorry,</i>” Katherine apologises.  ");
	if (knotSize >= 6) outputText("“<i>I'm afraid we're going to have to stay like this until I deflate - I don't want to think about how badly I'd hurt you trying to pull free.");
	else if (knotSize >= 4) outputText("“<i>Give me a little while and I should deflate enough that I can pull free of you.");
	else outputText("“<i>If you pull hard enough, I should pop right out of you.");
	outputText("</i>”\n\n");

	//[(PC is very loose)
	if (player.vaginalCapacity() >= 100 && isAt(KLOC_STREETS)) outputText("Nonplussed by the idea of waiting naked and penetrated in a back alley, and eager to see the look on Katherine's face, you pull apart anyway; your thoroughly stretched-out pussy relinquishes the knot with no more than a long sucking noise.  Free of her, you look back over your shoulder.  As you guessed, Katherine is sitting there wordlessly with her mouth open, staring alternately at the abused, cum-drooling lips of your pussy and at the enormous mass of flesh you just managed to pass through it.");
	else outputText("You tell her that it's all right; you'll stay here with her until nature takes its course.  Even though you can't really see her, given your respective positions, you know she's smiling.");
	outputText("\n\n");

	if (player.vaginalCapacity() < 100) outputText("About an hour later, she's deflated and y");
	else outputText("Y");
	outputText("ou get dressed, thank her, and head back to your camp.");
	//minus lust, slimefeed, Player returns to camp
	player.orgasm();
	orgasm(); 
	dynStats("sen", -1);
	player.slimeFeed();
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	experience(KBIT_TRIED_GIVE_VAGINAL);
	doNext(camp.returnToCampUseOneHour);
}

//Get Penetrated (Anal)
public function getPenetrated():void {
	//Scene can happen in the streets or at Kath's apartment
	clearOutput();
	outputText(images.showImage("katherine-fucks-you-knottily-in-the-bungholio"));
	if (isAt(KLOC_BAR) || isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED)) letKatKnotYouCommonDialogue(true); //At the bar
	outputText("You indicate to Katherine that you want it in your " + player.assholeDescript() + ".\n\n");

	outputText("“<i>Well, I can't say I'm a big fan of the idea, but okay...</i>”  Her" + catGirl("", " furry") + " hands promptly begin to rub possessively over your " + player.buttDescript() + ", slowly moving up to take hold of your " + player.hipDescript() + ".  “<i>... if that's what you want.</i>”  You feel her rubbing her " + cockMultiple("", "bottom-most ") + "cock against your anus, letting your cheeks feel its " + cockType("rubbery-smooth", "barb-covered") + " length, then, drawing back her hips, she suddenly thrusts it between them without any hesitation" + cockMultiple("", ", as her upper cock bounces along your back") + ".\n\n");

	outputText("“<i>Gonna - mmm - need just a bit of lube here...</i>” she mumbles, dragging her cock" + cockMultiple("", "s") + " between your buttcheeks.  As she says it, her body matches deed to her word and the " + cockType("puppy pecker", "kitty cock") + " begins drooling a slick, warm fluid into your asscrack" + cockMultiple("", ", as well as onto your cheeks, with the other bouncing around above them") + ".  With soft hands, she rubs the goo into your pucker and all over her pointed shaft, then there's a void of sensation as she pulls it from your asscheeks.  Before you can react, she pushes them open again and rams her cock into your anus!");
	//(butt hymen check + stretch check)
	var butts:Number = player.ass.analLooseness;
	player.buttChange(cockArea(), true, true, false);
	outputText("\n\n");

	if (butts > player.ass.analLooseness) outputText("You can't help but yelp in shock and look back over your shoulder at Katherine, who appears genuinely apologetic.  “<i>Sorry!  But I need to penetrate sooner rather than later - or would you rather wait until my knot's fully swollen?</i>”  You concede she has a point, but beg her to be more gentle if there's a next time.\n\n");

	outputText("Fingers digging into your hips, she begins to thrust back and forth inside you" + cockMultiple("", ", her secondary cock slapping wetly against your back") + ".  She grunts and groans, “<i>Oh- Oh yeah, you're unbelievable!");
	//[(player has high harpy/shark/cat/dog/bunny score)
	if (player.harpyScore() >= 4 || player.sharkScore() >= 4 || player.catScore() >=4 || player.dogScore() >= 4 || player.bunnyScore() >= 4)
		outputText("  Mmm... yeah, that's it, moan for me, you little slut; who's the alpha bitch, huh?  Katherine's your alpha - go on, say it!</i>” she yells out, pounding herself into you with greater force and her " + catGirl("sharp nails dig in", "claws extend") + " just far enough to begin biting into your flesh, pinpricks of pain to counter the pleasure.\n\n");
	else outputText("</i>”\n\n");

	outputText("You moan and gasp, thrusting your ass back into your feline lover's midriff to facilitate your fucking");
	if (player.isNaga() || player.tailType == TAIL_TYPE_LIZARD || player.tailType == TAIL_TYPE_DEMONIC) {
		outputText(",  snaking your tail up between her breasts and playfully stroking her cheek,");
	}
	outputText(" and crying out her name.  You can feel her knot starting to swell inside you even as she picks up the pace with which she hammers into you.\n\n");

	outputText("“<i>Ohhh!  Gonna plug you up; fill you fulla kitty-cat spunk!</i>” Katherine moans, her knot filling to its maximum size inside of you, anchoring you together so that she can no longer pull out.  She lunges forward and grabs your shoulders, trying to push her way in deeper.  ");
	if (knotSize >= 6)
		outputText("It feels like she's trying to shove a melon inside you; and you cry out in equal parts pain and pleasure at being stuffed so full.");
	else if (knotSize >= 4)
		outputText("The amount of swollen cockmeat she's stuffing inside you is on the border of being painful, but mostly it's sheer pleasure that fills you.");
	else outputText("Thanks to her relatively normal-sized knot, it feels nothing but good to be plugged up like this.");
	outputText("\n\n");

	outputText("You shudder and gasp as your own climax suddenly rocks through you");
	if (player.hasVagina()) outputText(", femcum splashing from your " + player.vaginaDescript());
	if (player.cockTotal() > 0) {
		outputText((player.hasVagina() ? " and " : ", ") + player.sMultiCockDesc() + " spurting ");
		if (player.cumQ() < 25) outputText("drops");
		else if (player.cumQ() < 100) outputText("splashes");
		else if (player.cumQ() < 250) outputText("puddles");
		else outputText("a veritable lake of spunk" + (isAt(KLOC_KATHS_APT) ? "onto the bed" : "into the alleyway"));
	}
	outputText(" as your asshole wrings the invader.\n\n");

	outputText("She suddenly arches her back and lets out a yowl of pleasure as her orgasm follows, rippling through her; she cums, groaning, inside you");
	if (cockNumber > 1) outputText(", with more spurting from her second cock to glaze your back and drool off onto the " + (isAt(KLOC_KATHS_APT) ? "sheets" : "ground") + " below you");
	outputText(".  ");
	//These cum volumes were previously based on Kath's ball size
	if (cumQ() <= 500)
		outputText("She makes a surprisingly large amount of cum for " + (hasBalls() ? "such small balls" : "a herm without balls") + ", and you can feel it sloshing and slurping inside you, leaving you deliciously full of cat-cream.");
	else if (cumQ() <= 1500)
		outputText("Jet after jet of cum sprays inside you, flooding all the way up into your bowels; by the time the " + cockType("dog-dicked cat", "barbed tip") + " stops, your belly is starting to bulge from all the cum she's given you.");
	else {
		outputText("She cums and she cums and she cums; how can she hold this much spooge inside her " + (hasBalls() ? "balls" : "prostate") + "?  Your stomach is flooded with cum until, by the time she finishes, you look certifiably pregnant and ");
		if (knotSize >= 6) outputText("only her huge knot is keeping everything plugged inside you");
		else outputText("some of it actually starts leaking out around her knot");
		outputText("; you stifle a belch and taste her salty spunk on the back of your tongue");
	}
	outputText(".  Her load spent, she collapses bonelessly onto her back - thanks to her knot, though, she remains plugged inside you and you yelp in shock as her weight pulls you backward.\n\n");

	outputText("“<i>Oops.  Sorry,</i>” Katherine apologizes.  ");
	if (knotSize >= 6)
		outputText("“<i>I'm afraid we're going to have to stay like this until I deflate - I don't want to think about how badly I'd hurt you trying to pull free.");
	else if (knotSize >= 4)
		outputText("“<i>Give me a little while and I should deflate enough that I can pull free of you.");
	else outputText("“<i>If you pull hard enough, I should pop right out of you.");
	outputText("</i>”\n\n");

	outputText("You tell her that it's all right; you'll stay here with her until nature takes its course.  Even though you can't really see her, given your respective positions, you know she's smiling.\n\n");

	outputText("About an hour later, she's deflated and you are able to get dressed, thank her, and head back to your camp.");
	//minus lust, slimefeed, Player returns to camp
	player.orgasm();
	orgasm();
	dynStats("sen", -1);
	player.slimeFeed();
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	experience(KBIT_TRIED_GIVE_ANAL);
	doNext(camp.returnToCampUseOneHour);
}

//Get Penetrated (Double)
public function getDoublePennedByKat():void {
	//Scene can happen in the streets or at Kath's apartment
	clearOutput();
	var doneBefore:Boolean = hasAlready(KBIT_TRIED_GIVE_DOUBLE_PEN);
	
	outputText(images.showImage("katherine-fucks-you-knottily-in-all-the-holes"));
	if (isAt(KLOC_BAR) || isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED)) letKatKnotYouCommonDialogue(true); //At the bar
	outputText("You indicate to Katherine that you want it in both holes.\n\n");

	outputText((doneBefore ? "She grins from ear to ear and says, " : "She starts in shock at the proposal, then slowly, she nods her head.  ") + "“<i>All right... if that's what you want.</i>”  " + (doneBefore ? "Her " : "Despite her tone, her ") + catGirl("soft", "furry") + " hands promptly begin to rub possessively over your " + player.assDescript() + ", slowly moving up to take hold of your " + player.hipDescript() + ".  “<i>Hmm... this is so kinky" + (doneBefore ? "" : ", but I think it just might work") + "...</i>” she murmurs, mostly to herself, and you feel her running her " + cockAdj() + "cocks against your sensitive pussy lips and your tingling anus, letting you feel their " + cockType("rubbery-smooth", "barb-covered") + " length, then, drawing back her hips, she suddenly thrusts the bottom one home without any hesitation.  The other slides along your asscrack harmlessly.");
	player.cuntChange(cockArea(), true, true, false);
	//[check vag hymen and stretch it]
	outputText("\n\n");

	outputText("You can't help but look back over your shoulder at Katherine, who appears rapt with concentration.  “<i>Sorry!  But this will be tricky... I need to penetrate fast, but I need some lube, too - unless you want to try and take my other knot completely dry!</i>”  She looks down and pushes the upper shaft between your buttcheeks.\n\n");

	outputText("Fingers digging into your hips, she begins to thrust back and forth inside of you, dragging one shaft through your pussy and the other through your cheeks.  “<i>Mmm, you're so good... I could come from this alone,</i>” she moans.  As if to echo the sentiment, a slow stream of pre-cum infiltrates your asscrack.  “<i>Ahh, here it comes...</i>”  She pulls her shafts out just as you feel a minute stiffening of the knots at their bases, and you can hear her smearing her pre-cum and your copious girl-lube along her lengths.  Your " + player.assholeDescript() + " does not go neglected either; after she's done rubbing herself to slickness, a palmful of warm gooeyness is pushed into it.  She must already be drooling a huge amount if she's got this much to donate!  Almost on cue, she confirms your hunch with a moan.  “<i>Ahhh, gotta put it in now!  I can't hold back anymore, I'm sorry!</i>”  A hot pressure on both holes is the only warning you get before her twin talents are forced into you, sliding easily into your already wet vagina and pushing past your ring by virtue of the tapered shape and the slickness.");
	player.buttChange(cockArea(), true, true, false);
	outputText("\n\n");

	outputText("She begins thrusting at once, grunting and groaning as if she were already near her peak.  “<i>Oh- Oh yeah, you're unbelievable!  " + (doneBefore ? "" : "It's so weird, ") + "I'm fucking two holes at once" + (doneBefore ? "; it's like I was born to do this" : ", but it's so good") + "!</i>” she cries out.  Her usually firm grip is shaky and unreliable, further evidence of the trouble she's having in controlling her climax.\n\n");

	outputText("You thrust your ass back toward your feline lover's midriff with an unseen, malicious smile, intent on forcing her to finish shamefully quickly, and cry out her name in your best bedroom voice.  You can feel her knots starting to swell inside you even as she picks up the pace, hammering into you.\n\n");

	outputText("“<i>Ohhh!  G-gonna plug you up; fill you fu-full...!</i>” Katherine moans distractedly, her knots filling to their maximum size inside of you and anchoring you together so that she can no longer pull out.  She lunges forward and grabs at your shoulders to push her way in deeper, but slips off weakly as her orgasm arrives.\n\n");

	outputText("She suddenly arches her back and lets out a yowl of pleasure as it ripples through her and she cums inside you.  ");
	//These cum volumes were previously based on Kath's ball size
	if (cumQ() <= 500)
		outputText("She makes a surprisingly large amount of cum for " + (hasBalls() ? "such small balls" : "a herm without balls") + ", and you can feel it sloshing and slurping inside you, leaving you deliciously full of cat-cream.");
	else if (cumQ() <= 1500)
		outputText("Jet after jet of cum sprays inside you, flooding all the way " + (pregSize() > 0 ? "inside, splattering against your cervix and filling your" : "up into your womb and") + " bowels; by the time the " + cockType("dog-dicked cat", "barbed tip") + " stops, your belly is starting to bulge from all the cum she's given you.");
	else {
		outputText("She cums and she cums and she cums; how can she hold this much spooge inside her " + (hasBalls() ? "balls" : "prostate") + "?  Your " + (pregSize() > 0 ? "pussy" : "womb") + " and your stomach are flooded with cum until, by the time she finishes, you look certifiably pregnant and ");
		if (knotSize >= 6) outputText("only her huge knots are keeping everything plugged inside you.");
		else outputText("some of it actually starts leaking out around her knots.");
	}
	outputText("  Her load spent, she collapses bonelessly onto her back - thanks to her knots, though, she remains plugged inside you and you yelp in shock as her weight pulls you backward until you're sitting on her.\n\n");

	outputText("“<i>Oops.  Sorry,</i>” Katherine apologises.  ");
	if (knotSize >= 6)
		outputText("“<i>I'm afraid we're going to have to stay like this until I deflate - I don't want to think about how badly I'd hurt you trying to pull free.");
	else if (knotSize >= 4)
		outputText("“<i>Give me a little while and I should deflate enough that I can pull free of you.");
	else outputText("“<i>If you pull hard enough, I should pop right out of you.");
	outputText("</i>”\n\n");

	outputText("You tell her that it's no matter if she can't pull out; you haven't gotten your own orgasm yet.  As you watch her face over your shoulder, her feline eyes widen.  “<i>Oh!  I'm so sorry... gods, I wasn't even thinking.  What... what are you gonna do?</i>”\n\n");

	outputText("Turning back to hide your wicked grin, you begin to bounce up and down on her knotted, still-hard shafts.");
	if (cumQ() > 500) outputText("  Her cum sloshes fluidly inside you, adding to the sensations assaulting your cervix and bowels.");
	outputText("\n\n");

	outputText("“<i>O-oh Marae!  It's too much!  Please stop, they're so sensitive right now!</i>” cries the cat-girl as you continue to ride her knotted shafts, reverse cowgirl style.  She paws at your hips as if to gain respite, but her slack, spent muscles can't keep you from completing your orgasm.  Fueled by her whimper-like moaning and the sensations inside you, it follows soon; as your anus and vagina squeeze her dicks in the throes of climax, a second burst from her follows, stretching your belly");
	if (cumQ() > 1500) outputText(" to its limit");
	outputText(" as she fills you with a smaller, second load of jizz.");
	if (player.hasCock()) outputText("  " + player.SMultiCockDesc() + (player.cocks.length > 1 ? " celebrate with arcs of their" : " celebrates with arcs of its") + " own semen, spraying them in a patter on her legs and the ground in front of you.");
	outputText("  The cat-woman gasps and twitches as her new ejaculation reverberates through her body, but forms no words, only looking up at the " + (isAt(KLOC_STREETS) ? "walls overhead." : "ceiling with a glazed expression."));
	outputText("\n\n");

	outputText("About an hour later, she's deflated and you are finally able to rise off of her, get dressed, and head back to your camp.\n\n");
	//minus lust, slimefeed, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	player.slimeFeed();
	player.orgasm();
	orgasm();
	dynStats("sen", -2);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	experience(KBIT_TRIED_GIVE_DOUBLE_PEN);
	doNext(camp.returnToCampUseOneHour);
}

//Sucked 'n' Fucked
//This scene requires the PC has a penis and has fucked Kat at least once since moving her
public function suckedNFuckedByKat():void {
	//Scene can happen in the streets or at Kath's apartment
	clearOutput();
	var doneBefore:Boolean	= hasAlready(KBIT_TRIED_GIVE_SUCK_N_FUCK);
	var x:Number			= player.biggestCockIndex();
	outputText(images.showImage("katherine-suck-and-fucks-you"));
	if (isAt(KLOC_BAR) || isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED)) letKatKnotYouCommonDialogue(true); //At the bar
	outputText("As you crouch, trying to figure out how you want your herm lover to take you, you start when you feel Katherine's fingers suddenly caressing your " + player.cockDescript(x) + ".\n\n");

	outputText("“<i>Hmm... I think you deserve a special treat, my sweet.  " + (isAt(KLOC_KATHS_APT) ? "Lie back on the bed" : "Roll over onto your back") + "...</i>” Katherine purrs, giving you a stroke to make you as stiff as possible before releasing you.\n\n");

	outputText((doneBefore ? "Knowing" : "Wondering") + " what she has in mind, you do as you are told, " + (isAt(KLOC_KATHS_APT) ? "lying back on the bed with your head on the pillow, your cock pointing at the ceiling" : "rolling onto your back and lying there with your prick aimed at the sky") + " and your " + (player.isNaga() ? "tail flat" : "legs spread") + ".  Katherine advances toward you and kneels down, reaching over your stomach and petting your " + player.chestDesc() + " with a smile.  “<i>You're very special to me, you know that?  Well, to prove it, I'm going to show you a real good time...</i>”  She grins, passing her tongue over her lips with exaggerated anticipation.\n\n");

	outputText("As you watch, she bends over from where she's sitting until she can lick your " + player.cockDescript(x) + ", her long, feline tongue running up and down its length, tickling the head.  The sensation is strange; bristly, but not sharp, so it's like being stroked by lots of little tongues at the same time.  Pre-cum begins flowing from your cock-tip like water bubbling from an underground spring, and your feline lover visibly savors the taste before leaning back upright, smacking her lips and smiling at your protest.\n\n");

	outputText("“<i>Naughty, naughty; have you forgotten who's fucking whom, this time?</i>” she purrs at you, one hand slipping forward to caress ");
	if (player.hasVagina()) outputText("your " + player.vaginaDescript());
	else outputText("between your asscheeks");
	outputText(".  Taking hold of your " + player.hipDescript() + ", she slides her cock" + cockMultiple("", "s") + " forward until she's hovering at the entrance to your ");
	if (cockNumber > 1 && player.hasVagina())
		outputText(player.vaginaDescript() + " and " + player.assholeDescript());
	else outputText(player.assholeOrPussy());
	outputText(".  Taking a bit of the pre-cum drooling from your prick, she slathers it over her cock" + cockMultiple("", "s") + ".  Then, without further ado, she slides herself into you.");
	if (player.hasVagina()) {
		if (cockNumber > 1) player.buttChange(cockArea(), true, true, false);
		player.cuntChange(cockArea(), true, true, false);
	}
	else player.buttChange(cockArea(), true, true, false);
	outputText("\n\n");

	outputText("“<i>Now, then, let's give this a shot...</i>” she murmurs to herself, beginning to slowly rock back and forth within you, sliding her cock" + cockMultiple("", "s") + " out and then thrusting home, her knot" + cockMultiple("", "s") + " starting to swell and stretching you out in all the right ways... if only she wasn't going so slow, this would be so great.  But any complaints about the pace are lost when she bends over again and starts to lap at your " + player.cockDescript(x) + ", running her tongue over and around it several times before she takes it into her mouth, swallowing inch after inch of your shaft until her nose is pressed flat into the base of your belly.  She lets out a muffled grunt that might be “<i>right</i>”, then tries to manage the task of picking up the pace of her thrusts while sucking and slurping on your " + player.cockDescript(x) + " at the same time.\n\n");
	
	outputText("You're in no position to complain.  This feels... incredible!  Her mouth around your cock is so hot and wet, her tongue sliding along the underside of your shaft and stroking in a sensation that no human could ever match, greedily sucking on you and hungry for everything you have.  At the same time, she's stretching your hole");
	if (player.hasVagina() && cockNumber > 1) outputText("s");
	outputText(" so deliciously full, knot");
	if (player.hasVagina() && cockNumber > 1) outputText("s");
	outputText(" flaring inside you and anchoring you together.  You rock back and forth, thrusting your hips awkwardly in an effort to fuck and be fucked as hard as possible, and feel the oh-so-sweet sensation of release boiling away ");
	if (player.balls > 0) outputText("in your " + player.ballsDescriptLight());
	else outputText("at the base of your spine");
	outputText("...\n\n");

	outputText("But it's Katherine who cums first.  With a muffled yowl of delight she floods your hole");
	if (player.hasVagina() && cockNumber > 1) outputText("s");
	outputText(" with her spunk, gushing hot kitty-kum into your depths.  Your belly begins to swell from the spunk, bulging into a visible paunch");
	if (cumQ() > 500) outputText(" and it doesn't stop, growing and growing until you look pregnant and ready to deliver");
	if (cumQ() > 1500) outputText(" and her " + (hasBalls() ? "swollen balls keep on going; by the time they finally run" : "massive prostate keeps on going; by the time it finally runs") + " dry, your belly is so heavy with deposited cum that you look like you're having triplets");
	outputText(".  She slumps forward with a groan of blissed-out relief, spent from her climax.\n\n");

	outputText("And then it's your turn to cum, flooding the startled, oblivious cat's mouth with your remembrance and making her swallow rapidly to keep it down.  ");
	//(Low/Normal:
	if (player.cumQ() <= 250) outputText("She drinks every last drop with gusto, popping wetly off of your cock and licking her lips as she audibly purrs with delight.");
	//(High:
	else if (player.cumQ() <= 600) outputText("She gulps it down desperately, stomach swelling with the influx of spunk, but manages to avoid spilling anything, popping her head free and gasping for breath as soon as she thinks you're done.");
	//(Very High:
	else outputText("You can see a hint of panic at the titanic cascade of fluids coming from your " + player.cockDescript(x) + ", but it's drowned out by sudden steely-eyed determination to drink every last drop.  Her belly swells out like a waterskin being held in a waterfall, rivulets of cum flooding from her overwhelmed mouth, but she manages to avoid pulling your cock out until you're finished.  Then she weakly manages to detach herself and gives you a triumphant expression, and a faint burp.\n\n");

	outputText("With a groan she allows herself to collapse atop you, ");
	if (cumQ() <= 500 ) {
		if (player.cumQ() <= 250) outputText(" leaving you lying belly-to-belly");
		else outputText(" her cum-bloated belly squishing audibly against your own flat torso");
	}
	else {
		if (player.cumQ() <= 250) outputText(" making your cum-swollen gut squelch wetly from the pressure");
		else outputText(" your mutually swollen bellies churning and rippling as they cushion the impact");
	}
	outputText(".  “<i>Quite an experience, wasn't it?</i>”  She grins, her hand tentatively inching towards yours.\n\n");

	outputText("You entwine her fingers with your own and agree that it was.\n\n");

	outputText("Once her knot");
	if (cockNumber > 1 && player.hasVagina()) outputText("s");
	outputText(" deflate and you detach, you clean yourself off, get dressed, and head back out" + (isAt(KLOC_KATHS_APT) ? ", leaving Kath passed out on her bed." : " into the street."));
	//lust -100, slimefeed, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	player.slimeFeed();
	player.orgasm();
	orgasm();
	dynStats("sen", -1);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	experience(KBIT_TRIED_GIVE_SUCK_N_FUCK);
	doNext(camp.returnToCampUseOneHour);
}

//Oral
private function oralKatherineChoices():void {
	clearOutput();
	if (isAt(KLOC_BAR) || isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED)) { //At the bar
		outputText("Kath's tail twitches excitedly and she polishes off her drink, eager to see what you have in mind.\n\n");
		outputText("You take her hand and lead her outside, to " + (flags[kFLAGS.TIMES_FUCKED_URTA] > 0 ? "that familiar" : "the") + " alleyway behind the Wet Bitch.\n\n");
		outputText("She looks a little worried about getting caught, but she's too excited to refuse you.\n\n");
		flags[kFLAGS.KATHERINE_LOCATION] = KLOC_STREETS;
	}
	outputText("With a smirk, you suggest a taste test.  Katherine blinks, then smiles. “<i>Fine by me... but who's going to be the taster?</i>”\n\n");
	menu();
	if (hasCock())
		addButton(0, "PC Sucks", giveKatOralPenisWingWang);
	else addButton(0, "PC Laps", giveKatOralPussyLicking);
	if (player.gender > 0) addButton(1, "Kath Laps", katherineGivesPCOralAllDayLongDotJPG);
	addButton(4, "Back", katSexMenu);
}

//Give Katherine Oral scene, single cock
public function giveKatOralPenisWingWang():void {
	//Scene can happen in the streets, at Kath's apartment or in the Desert
	clearOutput();
	var doneBefore:Boolean = hasAlready(KBIT_TRIED_RECEIVE_ORAL);
	outputText(images.showImage("katherine-give-her-blowjobs"));
	outputText("With a small grin, you tell Katherine that you wouldn't mind satisfying her orally.\n\n");
	if (doneBefore)
		outputText("“<i>Alright, I mean, if you're okay with the knot" + cockMultiple("", "s, and the twin cocks,") + " I'm okay with you giving me head...  I just feel bad leaving you with nothing.</i>”\n\n");
	else outputText("“<i>But... " + player.short + ", are you sure?  I mean, with the knot" + cockMultiple("", "s... I mean, now that I have two cocks") + ", that's a lot to work with...  And I don't want to leave you with nothing, either...</i>”\n\n");
	outputText("You reassure her that you don't mind at all - in fact, you want to do this and probably will like doing it.\n\n");

	outputText("Avoiding eye contact and " + catGirl("blushing bright red", "apparently blushing under the fur") + ", Katherine answers, “<i>Okay.  " + (doneBefore ? "If you want another dose, who am I to argue?  Just be careful," : "If this is really what you want.  Just please, be careful, especially") + " for your own good, okay?</i>”\n\n");

	if (isAt(KLOC_KATHS_APT)) {
		outputText("You motion for her to sit on ");
		if (!player.isTaur() && player.tallness < 102)
			outputText("the edge of her bed"); //Non-centaurs who are 8'6 or shorter
		else outputText("top of her dresser"); //Centaurs and those 8'6 or taller
	}
	else if (isAt(KLOC_DESERT)) {
		outputText("You motion for her to sit ");
		if (!player.isTaur() && player.tallness < 102)
			outputText("on top of a large sand dune"); //Non-centaurs who are 8'6 or shorter
		else outputText("near the top of a small sand dune"); //Centaurs and those 8'6 or taller
	}
	else { //Alleyway
		outputText("You motion for her to half-sit on a nearby ");
		if (!player.isTaur() && player.tallness < 102)
			outputText("empty crate"); //Non-centaurs who are 8'6 or shorter
		else outputText("broad stone wall"); //Centaurs and those 8'6 or taller
	}
	outputText(".  Contrary to what she said, she seems pretty eager and, in just a few moments, you have clear vision and access to " + cockMultiple("her cock and", "both her cocks as well as") + "her already-wet vagina" + (ballSize >= 5 ? " although her pendulous testicles obscure your view of it somewhat" : "") + ".\n\n");

	if (cockNumber == 1) {
		outputText("The puss' pussy is your first target, as you approach her sitting position; as your tongue slowly licks " + (hasBalls() ? "her balls you gently pull them upwards and to the side" : "the underside of her cock it rises higher and higher") + ", completely revealing her increasingly moist pussy.  You tease her about getting so excited but work to please nevertheless");
		if (player.cor >= 70) outputText(" - if only to prove your skill and make the kitten ever more dependent on you for release");
		outputText(".\n\n");

		outputText("With a teasing lick, you circle around her clit and slowly move away, then back towards it.  Her cock seems to grow even harder and starts to drip pre-cum, threatening to dirty " + (cockLength < 10 ? "your face" : "your hair") + ".  A loud, frustrated mewl from above prompts you to start gently sucking on her clit, rewarding you with a stifled moan and the twitching of the small cat-morph's thighs.  You continue your attentions without pause, slipping the tip of your tongue inside her pussy to taste the generously flowing juices.\n\n");

		outputText("Deciding this part had enough attention for the moment, y" + (hasBalls() ? "ou slowly move up to her balls, gently sucking each one inside your mouth.  Y" : "") + "ou allow your tongue to slide out and wrap about the lower part of her member, just below the barely recognizable thickening of her penis that marks the place where her knot will soon bulge" + (knotSize >= 6 ? " enormously" : "") + ".  ");
		outputText("Katherine moans again as you slowly trace the bottom side of her penis up towards the " + cockType("conical, pointy", "narrow, bumpy") + " head.  You gently suck on the tip before slipping one of your fingers inside the cat-morph's pussy.  She can't help herself and you feel her squirming, her thighs reflexively wrapping around your hand before she forcibly parts them.  Slowly, you bob your head up and down her cock" + (cockLength >= 14 ? ", experiencing minor problems actually deepthroating the thing" : "") + ".  All the while, you finger her pussy - your hands are positively soaked by her secretions.  Grabbing her cock with the same hand that is now coated in her own juices, you start to jerk her off as you go back down on her clit; your other hand slips inside the cat-morph.\n\n");
		outputText("She mewls again, clearly doing her best to resist and prolong the pleasure.  After a while of molesting her clit and cock simultaneously, you decide it's time to get somewhat more serious.\n\n");
		outputText("Deciding the girl's vagina is sufficiently teased for now, you move back to her erection, opening your mouth and slipping her inside.\n\n");

		//[Naga tongue]
		if (player.tongueType == TONGUE_SNAKE)
			outputText((hasBalls() ? "The hand that was so far fingering her pushes her balls to the side, as you slowly move down and down her erection.  You" : "You slowly move your tongue down and down her erection and") + " gently hum into it before going nearly all the way down to the base, Katherine's eyes opening wide.  Your long, flexible forked tongue slips out and down" + (hasBalls() ? ", sliding along the side of her left testicle" : "") + " before finding your target: the cat-girl's clitoris.  Your other hand starts to gently tease her lower lips as you slowly move it, mostly pleasing her with your throat muscles and long, flexible tongue.\n\n");
		// [Demonic tongue]
		else if (player.hasLongTongue())
			outputText((hasBalls() ? "The hand that was so far fingering her pushes her balls to the side, as you slowly move down and down her erection.  Stopping just before the place" : "You slowly move your tongue down and down her erection.  When it reaches the spot") + " where her knot usually pops out, you decide to give the girl a treat.  Slowly, your incredibly long flexible tongue moves towards your kittenish partner's pussy, giving it a long, sloppy lick.  Katherine's hips shiver and she only barely stops herself from pushing them forward.  Rewarding that show of self-control, you move your tongue up to wrap it around the very base of her penis just as the entire length of your inhuman muscle slips from your mouth; you manage to get the tip of it down, then brush it against the cat-girl's vagina.  Katherine just stares at you wide-eyed as you slip your demonic appendage inside her pussy, effectively pleasing nearly all of her lower's body erogenous zones at once.\n\n");
		//([Normal tongue]
		else outputText("Your hand remains in her pussy, however, adding to the multiple ways with which you please your lover.\n\n");

		outputText("After a while of slurping on her cock and ");
		if (player.tongueType == TONGUE_SNAKE) outputText("molesting her clit with your tongue");
		else if (player.hasLongTongue()) outputText("penetrating her with your tongue as you give her head");
		else outputText("fingering her");
		if (!hasBalls())
			outputText(", you pull away for a moment and");
		else {
			outputText(", you decide it's time to slightly change tactics in order not to humiliate the girl by making her blow her load too quickly.  The cat-herm's balls have been largely ignored so far, and you decide to amend that, slowly withdrawing from your blowjob and sinking your mouth down to her testicles.  You lick them softly before sucking one inside your mouth.\n\n");
			//([Snake tongue]
			if (player.tongueType == TONGUE_SNAKE) {
				outputText("Balls or no balls in the way, you find it pretty easy to mercilessly toy with the girl's pussy using your long tongue.  You can easily tease her clit and even slip the tip inside, flicking at the sides of her inner walls as she purrs with delight at the gentler attentions and occasionally releases a silent moan.  You stroke her cock at the base - this thing will have to wait for more attention.\n\n");
				outputText("You attend to the cat-girl's member while teasing the insides of her pussy with your inhuman tongue, all the while slurping on her testicles.  Katherine has a look of bliss on her face - you think it may be too cruel not to push her to orgasm a bit more quickly than planned.\n\n");
			}
			//[Demon Tongue]
			else if (player.hasLongTongue()) {
				outputText("You can feel Katherine shiver with helpless desire once she feels your excessively long tongue sliding over her balls.  You slide it upwards, teasing the knot area of her member, and then back down, oozing it over the poor kitten's clitoris and completely smothering it with your tongue.  Finally, you slip it inside as Katherine releases a loud scream of pleasure, then bites her own hand to silence herself.\n\n");

				outputText("You attend to the cat-girl's member while teasing the insides of her pussy with your inhuman tongue, all the while slurping on her testicles.  Katherine has a look of bliss on her face - you think it may be too cruel not to push her to orgasm a bit more quickly than planned.\n\n");
			}
			//{([Normal Tongue]
			else {
				if (ballSize <= 1) outputText("You find it pretty easy to slip your tongue out further and gently lick her clit almost all the time while you're doing it.");
				else if (ballSize <= 2) outputText("You can sometimes reach her pussy while toying with her balls, teasing it with your tongue.");
				else outputText("You hoped to play with her pussy too, but the cat-girl's balls are too sizeable to do so with your tongue.  You can almost feel, maybe even hear the semen sloshing inside the big things, ready to shoot out any second.");

				outputText("\n\nYou gently slide your fingers over the tip of her cock while teabagging her, but you don't want to give her an overload of sensations yet.\n\n");
			}
		}

		outputText("After molesting her with your tongue you pull away for a moment and announce that the cat-girl is very welcome to cum soon, " + (doneBefore ? "as you're happy to do this to her again and again" : "since this probably won't be a one time offer and she doesn't have to postpone things so desperately") + ".\n\n");

		outputText("“<i>Thank you,</i>” she gasps before mewling, a small trickle of drool running down her chin.  Somehow, she looks too adorable for you to point that out.  “<i>Ummm... I don't know how you want to finish, but... watch the knot, okay?  This is really amazing and it'd be such a waste if you were to harm yourself... I get the feeling that it'll start to bulge out really soon.</i>”\n\n");

		outputText("You nod, before considering how exactly you will seal the deal and have the cat-girl get off.\n\n");

		//([Naga tongue]
		if (player.tongueType == TONGUE_SNAKE) {
			outputText("With a smirk, you grab her cock around the base and lick your lips as Katherine shivers in anticipation.  Without much care for safety, you dive in, deep-throating the kitten up to the point where your lips meet your fingers.  It isn't the easiest thing you've ever done, but while having her deep down your throat you can extend your tongue far enough to lick her clit again.  The cat-girl is ecstatic at your simultaneous attentions.\n\n");

			outputText("Soon, you feel the telltale signs of her orgasm appearing.  Katherine is panting loudly, unable to control herself; her knot is bulging out and her pussy is getting wetter and wetter.");
			//([Katherine's knot is 6 inches wide]
			if (knotSize >= 6) outputText("  Regrettably, the cat-girl's bulging knot makes it a lot harder to please her pussy with your long tongue in this position than you'd hoped, and you have to give it up once she's completely swollen.");
			//([Player has a naga tail]
			if (player.isNaga()) outputText("  You decide to play the part of the snake to the very end and, not content to leave her pussy unattended, you slip the tip of your long tail inside her.  She groans in ecstasy, finally reaching orgasm.");
			else outputText("  Not content to let her pussy remain unattended, you slip two of your fingers inside her while teasing her clit with your knuckle.  She seems greatly pleased at your attention, as she shivers in orgasm moments afterwards.");

			outputText("\n\nYour " + (player.isNaga() ? "tail" : "fingers") + " get squeezed and drenched while you feel her erection twitch and pulse within your mouth.  You complete your motion, diving to the very verge of her knot and sucking on her intensely as she blows her seed into your mouth and down your throat.\n\n");

			outputText("You greedily swallow your hermaphrodite lover's semen; ");
			if (cumQ() <= 500) outputText("its quite a large amount given " + (hasBalls() ? "the size of her balls" : "that she doesn't have testicles") + ", substituting for a decent warm drink at least.");
			else if (cumQ() <= 1500) outputText("you can feel thick, generous ropes of her jizz flow into your mouth and down your throat between smaller trickles.  Her orgasm is rather intense and leaves you quite full.");
			else outputText((hasBalls() ? "as suggested by the size of her testicles," : "her prostate must have been working overtime, as") + " Katherine cums - a lot.  Wave after wave of semen gushes down your throat, filling your belly to the point of stretching.");
			outputText("  Slowly, you pull her cock out of your mouth while Katherine smiles at you and purrs gratefully.");
		}
		//(Demon tongue)
		else if (player.hasLongTongue()) {
			outputText("You separate the place where the knot should appear with your own fingers and dive down her shaft.  You're going to pleasure most of her anyway, as you repeat your trick, wrapping your " + (player.tongueType == TONGUE_DEMONIC ? "demonic" : "unhumanly long") + " appendage around the base of her cock with your other hand as your long tongue slides out to lick and play with her " + (hasBalls() ? "balls.  Sliding it along her testicles" : "clit.  That") + " seems to start igniting her orgasm - the bulge of her knot gets bigger, although it looks like you have a few moments.  You slide down further, " + (hasBalls() ? "rolling her balls and then lifting them to push" : "pushing") + " the tip of your tongue inside her pussy.  You can taste her feminine juices dripping out as her vagina starts to clench, her inner walls twitching and her knot bulging to full size");
			//([If 6 inches knot]
			if (knotSize >= 6) outputText(", even making it hard for you to keep your tongue buried all the way inside");
			outputText(".\n\n");

			outputText("With a loud yowl, she cums, her pussy clenching around your demonic appendage and her penis twitching in your mouth.\n\n");

			if (cumQ() <= 500) outputText("She practically thrashes around in orgasm as you tease her " + (hasBalls() ? "balls" : "clit") + " with your tongue, your mouth milking her and devouring the cum she releases quite easily.");
			else if (cumQ() <= 1500) outputText("Your tongue has no problems sliding across and teasing her " + (hasBalls() ? "balls" : "clit") + " as your mouth drinks her dick-milk.  There is quite a lot of it, but you don't complain.");
			else outputText("Katherine's " + (hasBalls() ? "large testicles quiver on your tongue as they discharge their" : "prostate must have been working overtime to produce such a massive") + " load.  You can feel it seeping inside you, slightly stretching your belly as you struggle to swallow it all.");
			outputText("  All the while, her pussy rhythmically squeezes your tongue and covers it with girl-cum.\n\n");

			outputText("Once she's done climaxing, you allow her member to slide out of your mouth before rolling your tongue along her pussy, drinking her feminine juices.  Her initial yowl turns into soft purring as you delicately finish her up.");
		}
		//([Normal tongue]
		else {
			outputText("Deciding to follow her advice, you dive down to the girl's soaking-wet vagina" + (hasBalls() ? ", gently fondling her testicles as you softly roll them in your hand" : "") + ".  You start eating her out, licking her insides, and teasing her clit as your other hand jerks your hermaphrodite cat lover off.\n\n");

			outputText("You can feel your hand starting to hit some resistance and you realize her knot is starting to surge with blood.  Taking advantage of the moment while you can, you drink her copious feminine juices while your tongue explores the inner walls of the kitty-cunt, then slightly increase your pace above.  With a lot of panting, a mewl and then a growl of ecstasy the cat-girl drenches your face as her pussy wraps tighter around your tongue, her semen flying out of her cock and landing all over your hair and your backside.  Her thighs shiver as she closes them around your head, unable to let you go.");
			if (cumQ() > 1500) outputText("  You can't help but giggle into the cat-girl's pussy as you feel her drench you with her seed, painting you white.");
		}
	}
	//Double Cock Scene
	else {
		outputText("Seeing one of her cocks bob and twitch as your face gets closer you decide to reward the eagerness and start with it.  You open your lips and lick the tip before slowly sliding down her crown and then lower, onto the shaft and down to the base.  Then, you pull your lips up, assaulting her with your tongue all along the way.  Her " + cockType() + " cock leaves your mouth with a loud slurp and you quickly go down the other one.  Katherine strokes your " + player.hairDescript() + ", very gently helping push you down her shaft.\n\n");

		outputText("Her hands are actually in the way of what you have planned; with a glare you quickly tell her to let you do it your way.  Katherine mewls apologetically as you grab her erections with both hands and rub them up, down, and together, licking the touching tips with your tongue.");
		if (player.tongueType == TONGUE_SNAKE || player.hasLongTongue()) outputText("  Said tongue wraps around one erection and then the other, stroking gently with its long, flexible length.");
		outputText("\n\n");

		outputText("Next you move down from her erections, ");
		if (hasBalls()) {
			outputText("giving her balls a teasing lick before sucking one of them inside your mouth.");
			if (player.tongueType == TONGUE_SNAKE || player.hasLongTongue()) outputText("  Your long, flexible tongue once again slides out as you gently lift her testes up, easily dipping inside her wet pussy and stroking her inner walls as you suck.");
			outputText("  You continue to minister to her balls, wrapping your fingers around her straining cocks, jerking them off slowly before nudging the balls up and diving into her wet pussy.\n\nYour");
		}
		else outputText("your");
		outputText(" work here starts with soft kisses on her lower lips, and then slowly moves up to her clit.  Katherine's thighs gently bend as her feet rest on your shoulders, egging you on to give more attention to her drenched pussy.  You humor her, tongue sliding inside her as you suck on her clit while slowly jerking off both of her erections.  Her feminine juices start flowing even more freely - you find yourself suffused with almost as much taste as sound from her soft panting and moaning.\n\n");

		//([Demon tongue]
		if (player.hasLongTongue()) outputText("The opportunity for some extra service doesn't escape you; you suck her clit in with your lips as the long, prehensile organ you house in your mouth slides up against " + (hasBalls() ? "her balls, rolling them and assaulting " : "") + "the base of one of her erections, slowly wrapping around it.  After getting a good tongue-grip on it, you slither further around and past it to do the same to her other cock.  Then, slowly, you start to stroke the twin canine penises with the wet muscle, causing Katherine to shake with helpless pleasure.  Continuing to suck on her clit meanwhile, your large flexible tongue also gives her twin penises a dream jerk-off.\n\n");

		outputText("Slowly, you draw away from her, admiring your handiwork.  Katherine's erections are leaking pre-cum generously, while her pussy is drenching her seat and trickling copious fluid onto " + (hasBalls() ? "the underside of her balls.  Her thighs" : "her thighs.  Those") + " are gently shaking and her stare lacks focus.\n\n");

		outputText("“<i>Umm... please, continue.  I'm so close...</i>”\n\n");

		outputText("You press your fingers against her pussy and start to finger her, at first gently, then at an increasing pace.  Then, you bend down to again suck on a throbbing erection as you gently stroke her members, alternating between one and the other.  You lift your lips from one penis and then dive down the other, going down and down, massaging her member with your throat muscles while sliding your tongue across the back of her penis.  While deepthroating, you suddenly feel something press against your jaw.  Quickly, you withdraw before the knot bulges out of control.  It swells as you pull out, but slows down, lacking the stimulation to reach ejaculation and therefore maximum size.\n\n");

		outputText("She pants and whimpers at the lost stimulation, hands barely restrained from grabbing the reins herself and capping your efforts.  “<i>P... please!  I'm almost there!</i>”  Not willing to make her suffer, you decide to finish the job and make your kitten cum.\n\n");

		//([Normal/Naga Tongue]
		if (!player.hasLongTongue()) {
			outputText("You wrap both your hands around her members just above the knot and start stroking her off, aiming them both at your mouth as you lick the tips.  Her knots swell to full size as she starts panting.");
			//([If the character has a naga lower body or a demon tail]
			if (player.isNaga() || player.tailType == TAIL_TYPE_DEMONIC) outputText("  Wanting to grant her maximum stimulation and complete release, you slip the tip of your tail inside the cat-girl, feeling her pussy gratefully squeeze it.");
			outputText("\n\n");

			outputText("Moments later, Katherine finally ejaculates, over your face and inside your mouth.");
			if (cumQ() > 1500) outputText("  There's quite a lot of it, so you manage to get both a kinky bath and a decent warm drink.");
		}
		else {
			outputText("Your tongue quickly slides out of your mouth, twitching sinuously as Katherine's eyes go wide at the sight of it easily wrapping around both her erections.  You" + (hasBalls() ? "r hand starts playing with her balls as the other fingers" : " start fingering") + " her dripping wet cunt, pumping in and out as you feel her knots swell larger under your tongue.\n\n");

			outputText("Her erections release in unison, and thick rivulets of semen cover your face, tongue and even the inside of your mouth.  Her " + (hasBalls() ? "testicles twitch and pulse in your hand as her" : "") + " cunt grabs tightly at your fingers, covering them with her girlcum.");
			if (cumQ() > 1500) outputText("  The two of you are liberally coated with her spunk, your stroking tongue unable to catch all of it as she shoots off.");
		}
	}
	// All scenes (both single and double cock) end here
	outputText("\n\nThe deed done, you straighten your back and wink at the cat-girl.  Katherine purrs as she jumps down next to you and pulls you in for a kiss.\n\n");
	outputText("“<i>You were amazing!</i>” she exclaims, still short on breath.  ");
	if (player.hasLongTongue()) outputText("She runs her fingers along your lips.  “<i>I think I might be falling in love with the monster inside that pretty cave.</i>”\n\n");
	else outputText("“<i>I hope that if I ever get to repay the favor, I can do as well as you.</i>”\n\n");

	outputText("She kisses you again, her hands running down your back.  You worry that if this keeps going you may end up going another round immediately; separating yourself from the cat-herm with a kiss, " + (isAt(KLOC_DESERT) ? "you pack up the supplies and prepare for the trip back to Tel’Adre." : "you go your separate ways."));
	orgasm(); //minus lust, slimefeed, Player returns to camp
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	experience(KBIT_TRIED_RECEIVE_ORAL);
	player.slimeFeed();
	dynStats("lus", 25);
	doNext(camp.returnToCampUseOneHour);
}

public function giveKatOralPussyLicking():void { //This version assumes Kath has no cock
	//Scene can happen in the streets, at Kath's apartment or in the Desert
	clearOutput();
	outputText("With a small grin, you tell Katherine that you wouldn't mind satisfying her orally.\n\n");
	outputText("“<i>Alright, I mean, it's not like I'm going to refuse.</i>”\n\n");

	if (isAt(KLOC_KATHS_APT)) {
		outputText("You motion for her to sit on ");
		if (!player.isTaur() && player.tallness < 102)
			outputText("the edge of her bed"); //Non-centaurs who are 8'6 or shorter
		else outputText("top of her dresser"); //Centaurs and those 8'6 or taller
	}
	else if (isAt(KLOC_DESERT)) {
		outputText("You motion for her to sit ");
		if (!player.isTaur() && player.tallness < 102)
			outputText("on top of a large sand dune"); //Non-centaurs who are 8'6 or shorter
		else outputText("near the top of a small sand dune"); //Centaurs and those 8'6 or taller
	}
	else { //Alleyway
		outputText("You motion for her to half-sit on a nearby ");
		if (!player.isTaur() && player.tallness < 102)
			outputText("empty crate"); //Non-centaurs who are 8'6 or shorter
		else outputText("broad stone wall"); //Centaurs and those 8'6 or taller
	}
	outputText(".  She seems pretty eager and, in just a few moments, you have clear vision and access to her already-wet vagina.\n\n");

	outputText("You attack the puss' pussy, your tongue slowly licking her outer lips, relaxing her increasingly moist pussy.  You tease her about getting so excited but work to please nevertheless");
	if (player.cor >= 70) outputText(" - if only to prove your skill and make the kitten ever more dependent on you for release");
	outputText(".\n\n");

	outputText("With a teasing lick, you circle around her clit and slowly move away, then back towards it.  A loud, frustrated mewl from above prompts you to start gently sucking on her clit, rewarding you with a stifled moan and the twitching of the small cat-morph's thighs.  You continue your attentions without pause, slipping the tip of your tongue inside her pussy to taste the generously flowing juices.\n\n");
	
	outputText("Your fingers pry open her thighs and then her tender pink passage, allowing you to push your tongue even deeper.  As her head rolls back and forth you slide your hands up her belly and gently massage her breasts.\n\n");

	outputText("She mewls again, clearly doing her best to resist and prolong the pleasure.  You decide it's time to get somewhat more serious.\n\n");

	if (player.tongueType == TONGUE_SNAKE || player.hasLongTongue())
		outputText("You finally make full use of your long, flexible tongue.  You tighten the abnormal muscles given to you by your transformation and slip it all the way in, the forked tip bumping against the back of her vagina even as the base of your tongue undulates against the underside of her clit.\n\n");
	else outputText("You press your tongue against the underside of her clit and rock it from side to side, your tastebuds dragging against her most sensitive flesh.\n\n");

	outputText("After molesting her clit with your tongue you pull away for a moment and announce that the cat-girl is very welcome to cum soon, as you're happy to do this to her again and again.\n\n");

	outputText("“<i>Thank you,</i>” she gasps before mewling, a small trickle of drool running down her chin.  Somehow, she looks too adorable for you to point that out.</i>”\n\n");

	outputText("Deciding it's time to finish her off, you dive down to the girl's soaking-wet vagina.  You start eating her out, licking her insides, and teasing her clit as your hands go back to rubbing her nipples.\n\n");

	outputText("With a lot of panting, a mewl and then a growl of ecstasy the cat-girl drenches your face as her pussy wraps tighter around your tongue.  Her thighs shiver as she closes them around your head, unable to let you go.");

	outputText("\n\nThe deed done, you straighten your back and wink at the cat-girl.  Katherine purrs as she jumps down next to you and pulls you in for a kiss.\n\n");
	outputText("“<i>You were amazing!</i>” she exclaims, still short on breath.  ");
	if (player.hasLongTongue()) outputText("She runs her fingers along your lips.  “<i>I think I might be falling in love with the monster inside that pretty cave.</i>”\n\n");
	else outputText("“<i>I hope that if I ever get to repay the favor, I can do as well as you.</i>”\n\n");

	outputText("She kisses you again, her hands running down your back.  You worry that if this keeps going you may end up going another round immediately; separating yourself from the cat-herm with a kiss, " + (isAt(KLOC_DESERT) ? "you pack up the supplies and prepare for the trip back to Tel’Adre." : "you go your separate ways."));
	orgasm(); //minus lust, slimefeed, Player returns to camp
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	player.slimeFeed();
	dynStats("lus", 25);
	doNext(camp.returnToCampUseOneHour);
}

//Katherine performs Oral on PC:
private function katherineGivesPCOralAllDayLongDotJPG():void {
	//Scene can happen in the streets or at Kath's apartment
	clearOutput();
	outputText("You tell Katherine you'd like to see what she can do with her tongue.  The black cat blinks in surprise, then grins widely.  “<i>Well, that can be arranged...</i>”  She purrs, taking you by the arm and " + (isAt(KLOC_KATHS_APT) ? "guiding you to her bed" : "leading you around to a specific crate") + ".  Once you are seated and both of you are naked, she kneels in front of you.  “<i>Now, let's see what you have, my dear...</i>” she says, tail waving in the way that only a happy cat's does.\n\n");
	if (player.hasCock() && (player.gender == 1 || rand(2) == 0)) doNext(katherineLicksAllTheBoyPenises);
	else doNext(katherineGoesDownOnTheGirlsOhYahBabyLesbo);
}

//[Female]
private function katherineGoesDownOnTheGirlsOhYahBabyLesbo():void {
	clearOutput();
	outputText(images.showImage("katherine-eats-out-your-vagoo"));
	outputText("She gently strokes the lips of your " + player.vaginaDescript() + ", then leans in and gives it a deep, wet lick.  You can't restrain a shiver at the sensation; Katherine's tongue is unlike anything you've seen in this world so far, broad and bristly, but not so hard that it hurts.  It's like lots of little tongues all licking you at the same time.\n\n");

	outputText("Without hesitation, she licks you again, and again, deep strokes that slide up from the very base of your cunny all the way to the tip, lingering on your " + player.clitDescript() + " and teasing your lovebutton.  You can't help but wrap your " + player.legs() + " around her head and pull her into your crotch, thrusting her face right into your cunt.\n\n");

	outputText("If this bothers Katherine, though, she gives no sign; she just keeps licking and lapping, eagerly slurping her way into your depths.  You buck and thrash at her ministrations; the sensations of that rough tongue all over your insides are indescribable; like rough fingertips but hundreds of times more probing!  Finally, you can't hold it any more and cry out as orgasm washes through you, deluging femcum into Katherine's thirsty maw, even as she strives to lap it up like a cat with a bowl of cream.\n\n");
	
	if (player.cocks.length > 0)
		outputText("At the same time your cock" + (player.cocks.length > 1 ? "s release their" : " releases its") + " load into the air, causing semen to rain down on the pair of you.\n\n");

	outputText("Your pleasure finished, you release her, gasping for breath as she daintly wipes her face clean with her fingers.  “<i>Was it good for you?</i>” she asks, mischief in her eyes.  When you reply, she smirks.  “<i>Did you expect a pussy to be good at eating a pussy?</i>”\n\n");

	outputText("You simply groan at the absolutely terrible pun and get back up, redressing yourself and heading back into the streets after a quick peck to thank her for the time.");
	doNext(camp.returnToCampUseOneHour);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	player.orgasm();
}

//[Male/Herm]
private function katherineLicksAllTheBoyPenises():void {
	var x:Number = player.biggestCockIndex();
	clearOutput();
	outputText(images.showImage("katherine-gives-you-blowjobs/"));
	outputText("She takes your shaft eagerly, gently stroking it with her fingers to coax it erect, then leaning in to lick the head with her softly bristled tongue, caressing and suckling at the " + player.cockHead(x) + ".");
	if (player.hasVagina()) {
		outputText("  One of her hands slides down your shaft");
		if (player.balls > 0) outputText(", past your " + player.ballsDescriptLight() + ",");
		outputText(" and gently begins to stroke your cunny, twiddling her fingers to heighten your pleasure by manipulating both sets of organs at once.");
	}
	outputText("\n\n");

	outputText("Once your pre starts to flow, she fully leans in and swallows as much of your shaft as she can, her inhuman tongue stroking and caressing in ways you couldn't have imagined.");
	if (player.hasVagina()) {
		outputText("  She plunges her fingers into your cunt at the same time, to heighten the experience.");
	}
	outputText("  With a surprising amount of skin in her mouth, she starts to bob and suckle, confining your member in the hot, tight, wetness, her tongue keeping up its ministrations.  She starts to purr with delight, sending the most delicious vibrations rippling through your member.");
	if (player.hasVagina()) {
		outputText("  Her fingers stroke and piston inside you with the synchronicity only another hermaphrodite could have perfected, rolling your " + player.clitDescript() + " and sending further sparks of pleasure coursing through your brain.");
	}
	outputText("\n\n");

	outputText("Your resistance is minimal in the face of such pleasure; all too soon, you feel your ");
	if (player.balls == 0) outputText("cock tingling");
	else outputText("balls tightening");
	outputText(" as your release becomes imminent.  Without further ado, you erupt inside the eager cat-herm's mouth, making her hungrily gulp down as much of your seed as she can.");
	if (player.cumQ() <= 250) outputText("  She drinks every last drop with relief, popping wetly off of your cock and licking her lips, audibly purring with delight.");
	else if (player.cumQ() <= 600) outputText("  She gulps it down desperately, stomach swelling with the influx of spunk, but manages to avoid spilling anything, popping her head free and gasping for breath as soon as she thinks you're done.");
	else outputText("  You can see a hint of panic in her eyes at the titanic cascade of fluids coming from your " + player.cockDescript(x) + ", but it's drowned out by her determination to drink every last drop.  Her belly swells out like a waterskin being held in a waterfall, rivulets of cum flooding from her overwhelmed mouth, but she manages to hold on without taking the cock out of her mouth before you're finished.  Afterward, she detaches herself breathlessly from your cock and gives you a triumphant expression, and a faint burp.");
	outputText("\n\n");

	outputText("Weakly, she collapses onto her " + catGirl("smooth", "furry") + "  behind on the ground, smiling up at you.  “<i>I take it you enjoyed that?</i>” she teases.  You admit she did very well, " + (isAt(KLOC_KATHS_APT) ? "gently stroking her hair in thanks" : "helping her up and to her own 'bed'") + ", then get dressed and head back out into Tel'Adre's streets.");
	//lust -100 regardless of sex, return to wherever
	player.orgasm();
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	doNext(camp.returnToCampUseOneHour);
}

//Double Helix
private function katDoubleHelixCraziness():void {
	//Scene can happen in the streets or at Kath's apartment
	var x:Number = player.cockThatFits(70);
	if (x < 0) x = 0;
	clearOutput();
	outputText(images.showImage("katherine-double-helix-fuck"));
	if (isAt(KLOC_BAR) || isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED)) { //At the bar
		outputText("Kath's tail twitches excitedly and she polishes off her drink, eager to see what you have in mind.\n\n");
		outputText("You take her hand and lead her outside, to " + (flags[kFLAGS.TIMES_FUCKED_URTA] > 0 ? "that familiar" : "the") + " alleyway behind the Wet Bitch.\n\n");
		outputText("She looks a little worried about getting caught, but she's too excited to refuse you.\n\nAs you stand there in the alley you ");
		flags[kFLAGS.KATHERINE_LOCATION] = KLOC_STREETS;
	}
	else outputText("You");
	//PC must have a cock and a vagina and not be a centaur
	outputText(" give the matter some thought... your partner here has both male and female sexual organs; which to choose...?  ");
	if (hasAlready(KBIT_TRIED_DOUBLE_HELIX))
		outputText("That double helix maneuver was a lot of fun, so you jokingly ask Kath if she's still flexible enough to give it a shot.");
	else outputText("Then, recalling you have the same sort of sex arrangement, you feel a kinky idea coming on.  Gently, you ask if Katherine thinks she's flexible enough to use both her parts at the same time.");

	outputText("\n\nKatherine grins and " + (isAt(KLOC_KATHS_APT) ? "stretches out on her bed" : "sits on the ground") + "; then bends over in a way that looks like she could lick her butt.  “<i>Flexible enough for you?</i>”\n\n");

	outputText("You can't resist a laugh; it looks like she is.  Carefully removing and setting your " + player.armorName + " aside, ");
	if (hasAlready(KBIT_TRIED_DOUBLE_HELIX)) {
		outputText("you position yourself the same as last time; Kath's legs wrapped around your lower body, her honeypot aligned with your own.  She carefully slides " + cockMultiple("one of ", "") + "her " + cockType() + "-pecker" + cockMultiple("", "s") + " towards your " + player.vaginaDescript() + ".  You do the same, pointing the tip of your " + player.cockDescript(x) + " to her drooling cunt.  You can hear her breathing softly, keeping herself calm, and you try to do the same.\n\n");
		outputText("Kath moans as the tips of both your cock and hers slip into place.  In a worried tone she says, “<i>um... after last time I don't think I'll be able to hold back.  We're probably going to wind up knotted like this.</i>”  Rather than replying you just shove your cock a little deeper.\n\nKatherine gives you a quick hug, then she");
	}
	else {
		outputText("you then realize the problem, and voice it aloud: how are you supposed to penetrate each other's pussy at the same time?\n\n");
		outputText("Katherine gets the cue and begins undressing herself.  “<i>Just lay down on your side and spread yourself for me.</i>”\n\n");
		outputText("You do as she says, ");
		if (player.isNaga()) outputText("curling your naga tail back");
		else if (player.isGoo()) outputText("shifting your gooey blob");
		else outputText("lifting your " + player.leg() + " up");
		outputText(" so she has access to both your " + player.vaginaDescript(0) + " and your " + player.cockDescript(x) + ".\n\n");
		outputText("Katherine lies down across from you and wraps her legs around your own lower body, her honeypot aligned with your own.  “<i>Okay... now push your dick down like this...</i>” she says, shoving " + cockMultiple("one of ", "") + "her own " + cockType() + "-pecker" + cockMultiple("", "s") + " towards your " + player.vaginaDescript() + ", slowly teasing you with the tip.\n\n");

		outputText("You repeat the gesture, pointing the tip of your " + player.cockDescript(x) + " to her drooling cunt.  You can hear her breathing softly, keeping herself calm, and try to do the same... which is when something occurs to you, and you ask her what the two of you are supposed to do about her knot.  You're not sure that the two of you tying yourselves in this position would be such a good idea, after all.\n\n");

		outputText("“<i>Oh, um... I guess it would be pretty awkward, yes... all right, I promise I won't push my knot in,</i>” she replies.\n\nKatherine");
	}
	outputText(" flexes her legs and pulls you inside her, penetrating you as well.  She yowls in pleasure as she feels the simultaneous pleasure of penetrating and being penetrated.  “<i>Ah... just move your hips - mmm - with me.</i>”\n\n");

	outputText("Shivering with delight as her hot, soaking wet walls envelop your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " and her " + cockType("rubbery, pointy dog", "narrow, barbed kitty") + "-cock slides into your " + player.vaginaDescript() + ", you need no further encouragement, eagerly pumping your hips against hers, trying to push into her and push her into you without letting either cock slip free of its appointed hole.  Katherine gyrates her hips, attempting to stimulate both your parts, panting in pleasure.\n\n");

	outputText("You whine and whimper at the stimulus, moving your own hips likewise in an effort to intensify the sensations without accidentally enveloping her knot in your cunt.  Katherine mewls and yowls in pleasure in response, voicing her approval and pulling you dangerously close to her knot in an attempt to feel more of you.  Barely comprehending what's happening, your world shrinks down to the feeling of cock in cunt... then with a wet SCHLUCK Katherine's half-swollen knot slips inside your pussy and your hips collide.");
	player.cuntChange(cockArea(), true, true, false);
	outputText("\n\n");

	outputText("You gasp as you find yourself filled so full, with your cock sheathed to the hilt in her hot, wet depths.  The sensations are almost overwhelming... but you manage to stave them off and gasp out that she's knotted you.\n\n");

	outputText("“<i>" + (hasAlready(KBIT_TRIED_DOUBLE_HELIX) ? "Mmmm" : "S-Sorry") + "...</i>” Katherine replies, holding back a moan and a thrust.  She pushes herself away just enough to let her knot slip free and continues gyrating her hips.  You resume working yours in turn, matching her pace so that her cock slides fully inside you and you can slide your cock fully inside her - at least, as fully as possible without once again taking in her knot... or not.  Katherine gasps and pulls you all the way inside her once more, once again slipping her knot inside you.  You cry out in pleasure; you can't bring yourself to care that you've been knotted once again, you're just too delighted to be truly full at last, to be fully sheathed at last - it's indescribable!\n\n");

	outputText("“<i>S-Sorry " + player.short + (hasAlready(KBIT_TRIED_DOUBLE_HELIX) ? ", but I'm not pulling out" : ", I just can't... ah... I promise I'll pull out before we tie") + ",</i>” Katherine says, doing her best to bump against you with all the strength she can muster.  You just automatically tell her it's all right, too lost in thrusting back against her with all your strength, mashing pelvis against pelvis with bestial desire, spurred on by instincts older than humanity.  With a final yowl of pleasure, you feel Katherine's knot swell inside you and her pussy clench around your " + player.cockDescript(x) + ".  Then a flood of feline cum and juices splashes in and against you, prompting a cry of your own; you surrender to your own climax, cum ");
	if (player.cumQ() <= 50) outputText("surging");
	else if (player.cumQ() <= 250) outputText("gushing");
	else outputText("thundering");
	outputText(" from your cock and femcum ");
	if (player.wetness() <= 3) outputText("drizzling");
	else if (player.wetness() <= 4) outputText("spurting");
	else outputText("gushing");
	outputText(" from your cunt, striving to milk your " + catGirl("cat girl", "anthropomorphic") + " lover and be milked by her in turn.\n\n");

	if (cumQ() <= 500)
		outputText("You feel your belly beginning to bloat slightly as Katherine dumps her load inside you.");
	else if (cumQ() <= 1500)
		outputText("You feel your belly beginning to bloat while Katherine fills you with her jism.  Her knot works to keep all of her cum inside you and as a result, by the time she's stopped you look at least a few months pregnant.");
	else
		outputText("You feel your belly beginning to rapidly bloat while Katherine fills you with her jism.  Not even her knot is equal to the task of keeping all of her cum inside you, as the backflow stretches your lips even wider to spill gouts of semen against Katherine's crotch.  By the time she's stopped cumming, you look like you're carrying multiple litters of kittens.");
	outputText("  ");
	//PC Medium Cum Amount)
	if (player.cumQ() <= 500) outputText("You pay Katherine back in kind though, dumping your considerable load inside the eager cat and giving her a round belly of her own as you spurt thick gobs of semen inside her.");
	//(PC High Cum Amount)
	else if (player.cumQ() <= 1500) outputText("You pay Katherine back in kind though, dumping your massive load inside the eager cat, bloating her belly until she looks a few months pregnant and is unable to take any more cum.  Some of it flows back to splatter against you, pooling beneath both of you in a messy pool of hot white jism.");
	//(PC Very High Cum Amount)
	else outputText("You pay Katherine back in kind though, dumping your massive load inside the eager cat, bloating her belly until she looks a several months pregnant and is unable to take any more cum.  Some of it flows back to splatter against you, pooling beneath both of you in a messy pool of hot white jism.  Yet it doesn't seem likely to stop anytime soon; if it weren't for Katherine's knot you're pretty sure you'd have sent the cat rocketing straight off of your cock.  Katherine trembles and her pussy walls clench as if to hold more of your cum inside her, and indeed she inflates beyond her capacity for a while, until she relaxes and your load pours out of her.");
	outputText("\n\n");

	outputText("You gasp for breath, mind still reeling from the earth-shaking pleasure you've experienced.  Your first instinct is to try to move, but you find you can't get up");
	if (cumQ() > 1500) outputText(", and not because your swollen stomach is weighing you down, either");
	outputText(".  Katherine's knotty cock has locked her into your " + player.vaginaDescript() + ", leaving you tied together like a dog and his bitch.  ");
	if (hasAlready(KBIT_TRIED_DOUBLE_HELIX)) {
		outputText("You gently rub one of Kath's nipples and ask her how she intends to make up for knotting you like this.\n\n");
		
		outputText("Kath pats your belly and says, “<i>I didn't hear you say 'Stop', and don't pretend you didn't enjoy it.  Anyway, you just wait 'til my knot shrinks down and I'll pay you back in spades.</i>”\n\n");
	}
	else {
		outputText("With roughly equal parts exasperation and amusement, you comment that you thought she'd promised to slip free before her knot bound you both together.\n\n");

		outputText("Katherine gulps audibly.  “<i>S-Sorry " + player.short + ".  It's just that... it felt so good... and I got carried away... sorry...</i>”  You tell her it's a bit disappointing, but you'll both live.  Besides, it's not as if it wasn't enjoyable.\n\n");

		outputText("Katherine smiles and says, “<i>Sorry... I promise I'll make it up to you somehow.</i>”  Propping yourself up on an elbow, you ask her with sincere curiosity what she has in mind.  “<i>Just wait for a while and let my knot shrink,</i>” she says, with a sly glance.  Seeing that she isn't going to talk, you settle back down and wait for just that to happen.\n\n");
	}
	outputText("With the sensation of your full pussy as your guide, it's easy to know when it's finally possible for her to slip free without hurting you; Katherine pulls away and stands on shaky feet.  The jism contained within you spills out in a satisfying cascade of white, that's when you feel a pair of lips touch your sensitive snatch.  Moments later a cat's tongue licks your labia and latches onto it, sucking the jism straight out of you.  You gasp in delight, but keep still, wondering what your lover has in mind.\n\n");

	outputText("Once she's done with your pussy, she moves on to your " + player.cockDescript(x) + ", taking the tip into her mouth and suckling on it to drain the last bits of cum from your shaft, then she lets go of your " + player.cockHead(x) + " and begins licking the shaft, cleaning you all the way from the base up");
	if (player.balls > 0) outputText(", and even licking your " + player.ballsDescriptLight() + " clean");
	outputText(".  You moan and shudder and buck your hips at her ministrations; your ");
	if (player.balls > 0) outputText("balls are still depleted");
	else outputText("cock is still almost totally empty");
	outputText(", but you're confident she could coax another orgasm from you if she keeps this up.\n\n");

	outputText("Realizing your cock is hardening up again, Katherine gives you a mischievous grin and opens her maw to take in all of you deep into her throat, giving your " + player.cockDescript(x) + " a loud, wet slurp before sucking on you sharply.\n\n");

	outputText("You voice a hollow groan; you didn't know she had this in her!  Reaching out with your hands, you take hold of her head just below the ears; too weak to push her down (not that it's necessary anyway), you settle for just holding her in place.\n\n");

	outputText("Of course, with the state you're in, it's barely minutes before you explode again, cum rushing from your oversensitive cock and into her suckling maw.  Katherine drinks you up, drawing all of your cum in and releasing your cock with a POP; leaving your throbbing mast sparkling with saliva.  “<i>So I take it you liked my little tongue-bath?</i>” she teases, licking her lips.\n\n");

	outputText("You can only nod weakly at her.\n\n");

	outputText("“<i>Want me to give you a more thorough one?</i>”\n\n");

	outputText("You nod again unthinkingly.\n\n");

	outputText("Katherine rolls you on your back and begins licking your belly, cleaning you of the sweat produced by your vigorous fucking earlier.  She moves through your " + player.chestDesc() + ", stopping shortly to give each of your " + player.nippleDescript(0) + "s a little peck.  Then she continues to your neck and face.\n\n");

	outputText("You simply lie back and enjoy her attentions; while pleasurable, they aren't as sexual as her previous efforts, and you find the experience more soothing than arousing. It takes a while, but finally with one last lick on ");
	if (player.isNaga() || player.tailType == TAIL_TYPE_DEMONIC) outputText("the tip of your tail");
	else outputText("your " + player.buttDescript());
	outputText(", she finishes.  Katherine grins and happily declares, “<i>There you go, you're clean now!" + (hasAlready(KBIT_TRIED_DOUBLE_HELIX) ? "" : " Sorry for breaking my promise and knotting you.") + "</i>”\n\n");

	outputText("Sitting up, you can't resist reaching over and ruffling her ears in a way that the cats you've met always liked, telling her that if this is how she'll apologize for " + (hasAlready(KBIT_TRIED_DOUBLE_HELIX) ? "knotting you, you don't mind her doing so again and again" : "it, you don't mind her doing so again") + ".\n\n");

	outputText("She leans against your hand, purring.  “<i>Hmm... I'll keep that in mind.</i>”\n\n");

	outputText("Righting and redressing yourself, you say goodbye to the charming kitty, then head back to camp, still feeling rather drained.\n\n");
	//Player returns to camp without his lust, slimefeed
	player.slimeFeed();
	player.orgasm();
	orgasm();
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	experience(KBIT_TRIED_DOUBLE_HELIX);
	dynStats("lib", -1, "sen", -1);
	doNext(camp.returnToCampUseOneHour);
}

//Suckle
private function suckleMenu():void {
	simpleChoices("She Suckles", suckleTacularKats, "You Suckle", suckleFromKath, "", null, "", null, "Back", katSexMenu);
}

private function suckleFromKath():void {
	//Scene can happen in the streets, in a backroom at the bar or at Kath's apartment
	clearOutput();
	outputText("You give Kath a smile and ask if there's anything she'd like to 'get off her chest'.\n\n");
	if (isAt(KLOC_BAR)) {
		outputText("She understands instantly and smiles back, her hands shifting subconsciously to cup her ");
	}
	else if (isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED)) {
		outputText("It takes a few seconds for her booze addled mind to figure out what you mean, at which point she grabs her ");
	}
	else if (isAt(KLOC_KATHS_APT)) {
		outputText("She grins and makes a show of cupping her ");
	}
	else { //She must have been on patrol
		outputText("She looks up and down the alley before sitting on a convenient crate.  Her hands shift subconsciously to cup her ");
	}
	
	if (breasts.lactationLevel == BreastStore.LACTATION_NONE) {
		outputText(breasts.adj() + " breasts.\n\n");
		if (!milkOption(KBIT_MILK_TOLD_PLAYER_SHES_DRY)) {
			outputText("“<i>I'm sorry " + playerText() + ", I've kind of run out.  I didn't even notice I was drying up and then one day my breasts just didn't feel as full.</i>”\n\n");
			outputText("She looks worried, probably afraid you'll be unhappy with her, but then she brightens up and adds, ");
			milkOptionSet(KBIT_MILK_TOLD_PLAYER_SHES_DRY); //Now she's apologized
		}
		outputText("“<i>I'm sure that if you suckle from me enough my breasts will get the hint and I'll start making cream for you again.</i>”\n\n");
	}
	else if (breasts.milkIsOverflowing()) {
		if (breasts.lactationLevel >= BreastStore.LACTATION_STRONG) {
			outputText(breasts.adj() + ", milk-laden breasts.\n\n");
			outputText("You can see the telltale stains from where Katherine's breasts have leaked some of their massive load.  Your favorite " + catGirl("cat girl", "kitty") + " even smells like cream.\n\n");
			outputText("“<i>Yes, yes, yes!  Oh, " + playerText() + " I'm so full.  I'm stuffed with cream and it's all because of you.  Please " + (playerMaster() ? "drain me, [master], don't leave me like this." : "help me.") + "</i>”\n\n");
		}
		else {
			outputText(breasts.adj() + ", milk-laden breasts.\n\n");
			outputText("“<i>Oh thank you!  I need this, I'm always so full.  If I had any more milk saved up I'd almost need to feed it to someone.</i>”\n\n");
		}
	}
	else if (breasts.milkIsFull()) {
		outputText(breasts.adj() + " breasts.\n\n");
		outputText("“<i>Mmmm - I've been hoping you'd stop by.  When my breasts fill up my nipples get stiff and sensitive, like they want some attention.</i>”\n\n");
	}
	else {
		outputText(breasts.adj() + " breasts.\n\n");
		outputText("“<i>I don't really <b>need</b> a milking... but I'll never turn you down" + (playerMaster() ? ", [master]" : "") + " - especially when you're offering to suck on my nipples.</i>”\n\n");
	}
	
	if (isAt(KLOC_BAR) || isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED)) {
		outputText("You get up and move to Katherine's side of the booth.  Before you can even sit down Kath has begun " + clothesChoice("sliping off her blouse", "wriggling out of the upper part of her bodysuit", "opening the bodice of her dress", "opening the top of her silk robe", "removing her tube top", "removing her nurse's top") + ".  The flicking of Kath's tail tells you how excited she is as she finally removes her bra and exposes her chest.\n\n");
	}
	else if (isAt(KLOC_KATHS_APT)) {
		outputText("Kath puts on a little show as she " + clothesChoice("slips off her blouse", "wriggles out of the upper part of her bodysuit", "opens the bodice of her dress", "opens the top of her silk robe", "removes her tube top", "removes her nurse's top") + ".  The flicking of Kath's tail tells you how excited she is as she finally removes her bra and exposes her chest.\n\n");
	}
	else { //She must have been on patrol
		outputText("Kath pulls off her breastplate and gives you another smile.  You can tell she's a little worried at being caught feeding you, even though this can't even be close to the raunchiest thing Tel'Adre's citizens have seen on their streets.  At last her bra comes off and her breasts hang free in the open air.\n\n");
	}
	
	if (player.cor < 25) {
		outputText("Gently, you guide Kath's hands to her sides.  She leans back, content to let you take the lead.  You hold her breasts in your hands and stroke her nipples with your thumbs.  They were erect to begin with, but now they turn a deeper pink, begging for more attention.  When you seal your lips against her " + (rand(2) == 0 ? "left" : "right") + " nipple Kath closes her eyes and purrs.\n\n");
		outputText("You massage her " + breasts.adj() + " mammaries, ");
		if (breasts.lactationLevel == BreastStore.LACTATION_NONE) {
			outputText("sucking gently and enjoying Katherine's thick, rich cream.  If you keep this up then hopefully someday soon Kath's breasts will fill with even more cream.");
		}
		else if ((breasts.milkIsOverflowing() && breasts.lactationLevel >= BreastStore.LACTATION_STRONG) || (breasts.milkIsFull() && breasts.lactationLevel >= BreastStore.LACTATION_EPIC)) {
			outputText("coaxing them to relax and release their thick, creamy treasure.  You keep drinking and drinking, amazed at the quantities of cream Katherine can produce.");
			if (breasts.lactationLevel >= BreastStore.LACTATION_HEAVY) outputText("  Sure that you'll be unable to drink it all you switch to her other nipple before the first has run dry.");
		}
		else {
			outputText("coaxing them to relax and release their thick, creamy treasure.  You keep drinking and drinking, trying to enjoy every drop Katherine can produce.");
		}
		if (breasts.lactationLevel >= BreastStore.LACTATION_LIGHT) player.refillHunger(breasts.lactationLevel * 15);
		outputText("\n\nFor her part Kath just purrs and enjoys your ministrations, oblivious to the world around her.\n\n");
	}
	else if (player.cor < 75) {
		outputText("Eager to begin you push Kath's hands away and replace them with your own.  She leans back, her eyes begging for more.  You rub her nipples and give her breasts a little squeeze" + (breasts.milkIsFull() ? ", watching the creamy droplets cascade from her bosom.  You give her a devilish grin and fix" : " before fixing") + " your lips to her " + (rand(2) == 0 ? "left" : "right") + " nipple.  Kath sighs as you begin to suckle.\n\n");
		outputText("You stroke her " + breasts.adj() + " mammaries");
		if (breasts.lactationLevel == BreastStore.LACTATION_NONE) {
			outputText(" and suck vigorously, keen to bring back her heavenly cream.\n\n");
		}
		else if ((breasts.milkIsOverflowing() && breasts.lactationLevel >= BreastStore.LACTATION_STRONG) || (breasts.milkIsFull() && breasts.lactationLevel >= BreastStore.LACTATION_EPIC)) {
			outputText(" and suck vigorously, keen to draw out every bit of her creamy goodness.  Katherine's heavy teats give you more than you can handle.");
			if (breasts.lactationLevel >= BreastStore.LACTATION_HEAVY) outputText("  Sure that you'll be unable to drink it all you switch to her other nipple before the first has run dry.");
		}
		else {
			outputText(" and suck vigorously, keen to draw out every bit of her creamy goodness.  Katherine's heavy teats give you all you desire and you use your tongue to show your appreciation.");
		}
		if (breasts.lactationLevel >= BreastStore.LACTATION_LIGHT) player.refillHunger(breasts.lactationLevel * 15);
		outputText("\n\nFor her part Kath just lets out little 'Oh's and 'Ah's when you're less gentle.  She's definitely enjoying herself and seems oblivious to the world around her.\n\n");
	}
	else {
		outputText("You grab her hands and press them against her sides, letting Kath know you're in charge.  ");
		if (breasts.lactationLevel == BreastStore.LACTATION_NONE) {
			outputText("So her body decided to stop making cream, did it?  You know how to fix that!  You start rolling her nipples between your thumbs and fingers, yanking and pinching hard enough to draw little mewls from Katherine.  You knead her titflesh to remind her what it's for.  Finally you latch on to her " + (rand(2) == 0 ? "left" : "right") + " nipple and begin to suck - hard.\n\n");
			outputText("You kneed her " + breasts.adj() + " mammaries, hoping that with enough abuse you can force them to start producing again.\n\n");
		}
		else if ((breasts.milkIsOverflowing() && breasts.lactationLevel >= BreastStore.LACTATION_STRONG) || (breasts.milkIsFull() && breasts.lactationLevel >= BreastStore.LACTATION_EPIC)) {
			outputText("You cup her heavy breasts and give them a squeeze to get things moving.  ");
			if (breasts.lactationLevel >= BreastStore.LACTATION_HEAVY) {
				outputText("A surprisingly large cascade of cream flows over your hands and dribbles down her front.  Kath mewls and you decide to see what these mammaries can do.  A harder and more deliberate squeeze yields another flood of cream, drenching Kath and her clothes.  You laugh and latch");
			}
			else {
				outputText("A decent stream of cream flows over your hands and dribbles down her front.  Kath mewls and you try a harder and more deliberate squeeze, but the results are no more impressive than before.  Still, it smells nice, so you give Kath's nipples a good hard pinch before latching");
			}
			outputText(" onto her " + (rand(2) == 0 ? "left" : "right") + " nipple, ready to begin your feast in earnest.\n\n");
			outputText("You kneed her " + breasts.adj() + " mammaries to force the creamy goodness into your mouth.");
			if (breasts.lactationLevel >= BreastStore.LACTATION_HEAVY) outputText("  You're pleased by Kath's milk production, her overactive mammaries hold more cream than you can handle.  You let the cream run from the corners of your mouth, draining every drop, encouraging Kath's breasts to keep up their good work.");
		}
		else {
			outputText("You cup her breasts and give them a squeeze to get things moving.  A few drops of kitty cream appear on the tips of her nipples which you lick off with your tongue.  Katherine sighs contentedly, so you give her nipples a good hard pinch to remind her who she's dealing with.  She lets out a cute little mewl and you latch onto her " + (rand(2) == 0 ? "left" : "right") + " nipple, ready to begin your feast in earnest.\n\n");
			outputText("You kneed her " + breasts.adj() + " mammaries to force the creamy goodness into your mouth and Kath's succulent nipples do not disappoint.");
		}
		if (breasts.lactationLevel >= BreastStore.LACTATION_LIGHT) player.refillHunger(breasts.lactationLevel * 15);
		outputText("\n\nKath squirms and mewls plaintively, but you won't slow down.  She needs to learn her place and besides, you know that feelings of pain and pleasure are intertwined.  After a while Kath relaxes and the tone of her mewls shifts down an octave.  You submissive kitten is finally enjoying herself, so you nibble on her teat to show your approval.\n\n");
	}
	var wasntLactating:Boolean = breasts.lactationLevel == BreastStore.LACTATION_NONE;
	if (breasts.milked() && wasntLactating) {
		outputText("Just as you're winding down you taste a hint of cream on your tongue.  After suckling a little longer you're sure; Katherine has started producing milk again.\n\n");
		outputText("In a drowsy, blissful tone Kath says, “<i>Mmmm, you wanted my cream?  I'm happy to oblige.</i>”\n\n");
		outputText("To make sure she doesn't dry up you suckle for a few more minutes, switching from nipple to nipple while your fingers tease the sensitive undersides of her " + breasts.adj() + " breasts.");
	}
	
	outputText("When you finally pull away Kath sighs contentedly.  “<i>Thank" + (playerMaster() ? " you [master]" : "s " + player.short));
	if (breasts.lactationLevel == BreastStore.LACTATION_NONE) {
		outputText(", I hope I start making milk again, it's a shame you don't get a reward for all that effort,</i>” she says, rubbing her sore nipples" + (isAt(KLOC_KATHS_APT) ? "" : " before covering herself up") + ".");
		if (isAt(KLOC_KATHS_APT)) outputText("It doesn't take long before her head starts to droop and her whole body follows it toward the mattress.\n\n");
	}
	else if (breasts.milkIsOverflowing()) {
		outputText(", that was just what I needed,</i>” she mumbles before falling asleep.");
		if (isAt(KLOC_BAR) || isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED)) {
			if (player.cor < 75)
				outputText("  You hug Kath close so she's not flashing her assets to everyone in the wet bitch.");
			else outputText("  You leave her breasts exposed and shift her shoulders so her chest is on display for all to see.  You get a few appreciative smiles and some raised glasses as the patrons commit Kath's " + breasts.adj() + " breasts to memory.");
			outputText("  After a little catnap she comes around and takes in the bar.  She puts " + clothesChoice("her bra and blouse back on", "on her bra and wriggles back into the bodysuit", "on her bra and does up the bodice of her dress", "her bra back on and closes up her robe", "her bra and tube top back on", "her bra and nurse's top back on") + (player.cor < 75 ? "" : ", looking a little sheepish") + ".\n\n");
		}
		else if (isAt(KLOC_KATHS_APT)) {
			outputText("\n\n");
		}
		else { //Alleyway, on duty
			outputText("  Since she's on duty you have to nudge her awake.  She looks confused and disoriented until you press her breastplate into her hands.  Realization dawns and Katherine quickly redresses in her uniform.\n\n");
		}
	}
	else if (breasts.milkIsFull()) {
		outputText(", that was just what I needed,</i>” she says, sounding tired but happy none the less.");
		if (!isAt(KLOC_KATHS_APT)) outputText("  After about a minute she remembers her modesty and covers herself up.\n\n");
	}
	else {
		outputText(", that was just what I wanted,</i>” she says, as she " + (isAt(KLOC_KATHS_APT) ? "" : "covers up and ") + "snuggles up against you.\n\n");
		if (isAt(KLOC_KATHS_APT)) outputText("It doesn't take long before her head starts to droop and her whole body follows it toward the mattress.\n\n");
	}
	
	if (isAt(KLOC_BAR) || isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED)) {
		if (model.time.hours >= 8 && model.time.hours <= 16 && flags[kFLAGS.NIAMH_STATUS] == 0)
			outputText("You notice " + (flags[kFLAGS.MET_NIAMH] == 0 ? "the huge breasted cat girl" : "Niamh") + " rubbing her own mammaries enviously.  ");
		outputText("Unfortunately you have places to be, portals to check on.  You give Katherine a kiss and her tail a little stroke before heading back to camp.");
	}
	else if (isAt(KLOC_KATHS_APT)) {
		outputText("You smile as your lover, still partially naked, slowly uncurls onto the bed.  She looks so peaceful and innocent.\n\n");
	}
	else { //Alleyway, on duty
		outputText("When she sees one of the other members of her patrol at the end of the alley she hops to her feet, grabs her stuff and gives you a quick peck on the cheek.  As she leaves she says, “<i>Gotta run - but thanks again.  Stop by at the bar, my place, somewhere, just please see me again soon.</i>”\n\n");
	}
	doNext(camp.returnToCampUseOneHour);
}

//PC must lactate to have this option
private function suckleTacularKats():void {
	//Scene can happen in the streets or at Kath's apartment
	clearOutput();
	outputText(images.showImage("katherine-suckles-you"));
	outputText("Feeling your " + player.chestDesc() + " and the milky goodness within, you ask Katherine if she likes milk the way her fellows do.  When the cat-morph gives you a puzzled look, you remove the upper part of your " + player.armorName + " and, fondling your tits with a smirk, tell her that you could use a little relief.\n\n");

	outputText("Katherine's eyes widen with shock, and she smiles in disbelieving delight, ");
	if (isAt(KLOC_BAR) || isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED)) { //At the bar
		outputText("moving to your side of the bench.  She cups your breasts and lifts them to get a sense of how much milk you've got stored up.  “<i>Of course I love milk.  What a silly question - and you know I love your milk most of all, " + playerText()  + "</i>”\n\n");
		outputText("Katherine starts to play with your nipples and runs her " + catGirl("smooth fingers", "finger pads") + " over your breasts, causing a trickle of milk to leak out.\n\n");
		outputText("Not wanting to wait any longer you");
	}
	else {
		outputText("quickly striding over and waiting, impatiently, as you " + (isAt(KLOC_KATHS_APT) ? "position yourself on her bed" : "find a comfortable position and sit down") + ".  Once you have, she wastes no time in plopping down in front of you.  She nuzzles her cheek against your breast but then, to your amazement, shyly backs away.\n\n");
		outputText("“<i>I... um... is this really okay?</i>” she asks, her voice barely above a whisper.  With a hint of exasperation you roll ");
		if (player.eyeType == EYES_FOUR_SPIDER_EYES) outputText("both sets of ");
		outputText("your eyes and");
	}
	outputText(" gently take her by the cheeks, insistently bringing her head close so that her lips are bumping right against your " + player.nippleDescript(0) + "s.  She takes the obvious hint and eagerly swallows it, eyes closing as she leans in and starts to suckle.  Purring with contentment, she sends the most delicious vibrations into your breasts, her rough, bristly tongue stroking and caressing to help coax your body into giving up its sweet, rich milk.\n\n");

	outputText("You're not sure how long you sit there with her in your arms, just listening to her purr as she quietly sucks and slurps, drinking everything you have to give.  She ");
	if (player.findPerk(PerkLib.Feeder) < 0 && player.lactationQ() < 1000) outputText("empties");
	else outputText("does her best to empty");
	outputText(" your first breast, and then moves to the next one.  Finally, she's drunk ");
	if (player.findPerk(PerkLib.Feeder) < 0 && player.lactationQ() < 1000) outputText("you dry");
	else outputText("so much of your seemingly inexhaustible supply of milk that she's physically incapable of drinking any more");
	outputText(", and she lets your nipple go with a loud pop.");
	if (player.lactationQ() < 500) {}
	else if (player.lactationQ() < 1000) outputText("  She is sporting an unmistakable milk-belly from all she's drunk.");
	else if (player.lactationQ() < 2000) outputText("  She looks almost pregnant with how much she's drunk, but she doesn't seem to care.");
	else outputText("  Katherine looks more like a balloon than a cat, her belly swollen hugely from her titanic liquid repast.  You can hear her stomach's contents sloshing softly around inside her when she moves and thusly jostles them.");
	outputText("  With a smirk, you ask if she feels good from having helped you with your little milk problem.\n\n");

	outputText("The cat herm stirs herself from your grip and cuddles up to you, nuzzling against your neck and tucking her chin into your shoulder.  Then she lets out a burp that echoes off the ");
	if (isAt(KLOC_KATHS_APT))
		outputText("bedroom walls");
	else if (isAt(KLOC_STREETS))
		outputText("alley walls");
	else { //At the bar
		outputText("walls of the bar");
		if (model.time.hours >= 8 && model.time.hours <= 16 && flags[kFLAGS.NIAMH_STATUS] == 0)
			outputText(".  You notice " + (flags[kFLAGS.MET_NIAMH] == 0 ? "the huge breasted cat girl" : "Niamh") + " rubbing her own mammaries enviously");
	}
	outputText(".  “<i>I feel great,</i>” Katherine tells you, totally unabashed.  “<i>I must say, I've drunk from people before... but nobody makes milk as wonderful as yours");
	if (flags[kFLAGS.KATHERINE_MET_SCYLLA])
		outputText("... except maybe that nun");
	outputText("!</i>”\n\n");

	outputText("Smiling at the flattery, you help the very well-fed cat out of your lap, then quietly put your top back on and head out into the streets.\n\n");
	//some lust loss, satisfy feeder, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	dynStats("sen", -2, "lus", -40);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	player.milked();
	doNext(camp.returnToCampUseOneHour);	
}

//With Quiet Browser and Adjatha’s permission I have been working on finishing Katherine’s Employment Expansion so that it can be coded into CoC. This document covers a part of that. It has been mentioned before that meeting Katherine is quite complex. Many have suggested having an alternate recruitment route. Since I’m writing even more content for Kath I decided to tackle the recruitment route too.
//There is a list of implementation details at the end of this file that, I hope, will help in cutting down on the amount of work needed to implement this expansion in-game.
//Implementation details written in code are in dark cyan. I used these where I had to refer to flags or where I had to show changes to an existing function. The existing code is from the Corruption-of-Champions GitHub. Each function has a block of red text describing the file it comes from and before and after blocks of code.

//Alternate Katherine Recruitment
//This provides a way to meet Katherine without meeting Scylla first. Being ambushed by the vagrant cats should be a rare event which can trigger when you enter Tel’Adre. I think it should be at least 4 times rarer than encountering Arian. Also, to keep things simple this event should not trigger if the PC has less than 35 gems.
//Also requires lactation, apparently!

//Ambush by Vagrant Cats
public function ambushByVagrantKittyKats():void
{
	clearOutput();
	outputText("As you walk through Tel’Adre, taking in the sights, you catch a glimpse of some cat morphs part way down an alley.  It looks like three cat morph men have a younger cat morph woman backed into a corner.  None of the men look to be armed.  The girl is wearing a tattered dress that could once have been white and she looks worried.");
	//[Get Help] [Intervene] [Leave]
	//Can’t leave if below 25 corruption - you’re a champion after all.
	//Can’t get help if at or above 75 corruption - you’re a perverted monster after all.
	menu();
	addButton(0,"Get Help",getHelpVsKittyKats);
	addButton(1,"Intervene",interveneWithKittyKats);
	addButton(4,"Leave",leaveKittyKatsLikeANeeeeeerrrrd);
}

//Get Help:
private function getHelpVsKittyKats():void
{
	clearOutput();
	outputText("Fighting three people at once is a lot harder than dealing with one opponent.  Still, from the look of them you could probably mop the floor with these three.  Out there in the wastes that would be the right thing to do, but Tel’Adre has its own laws and its own watch.  Since you’re an outsider you decide you’d be better off finding a patrol.");
	outputText("\n\nYou race to the nearest intersection and call out.  A tall lizard morph in a watch uniform pushes through a throng of people and asks you, “<i>What seems to be the problem?</i>”");
	outputText("\n\nYou explain what you saw and lead him back to the mouth of the alleyway.  It’s empty.  The lizard takes down your description of the situation and thanks you for doing the right thing.  He says, “<i>We’ve had a few similar reports in the past, though strangely it’s always the same woman.  I’ll get the description back to the Watch houses and all the officers will keep a sharp eye open.</i>”");
	outputText("\n\nFeeling you’ve done a good deed today you press on.");
	doNext(telAdre.telAdreMenu);
}

//Intervene:
private function interveneWithKittyKats():void
{
	clearOutput();
	outputText("Fighting three people at once is a lot harder than dealing with one opponent.  Still, from the look of them you could probably mop the floor with these three.  You square your shoulders and march down the alley.  If you look intimidating enough maybe they’ll just scatter.");
	outputText("\n\nAs you pass a few wrecked packing crates and barrels you see something leap up out of the debris that covers the earth in this alley.  Too late you recognize it to be a loop of thick cord.  You try to jump but the cord snaps tight around your ankles.");
	outputText("\n\nYou fall to the ground and the air is knocked out of you as half a dozen bodies land on top of you.  Something smacks the back of your skull and you see stars.  Half a brick lands in front of you and as the haze closes in your brain pieces together a single thought: “<i>Well this is embarrassing.</i>”");
	//[Next]
	//Leads Intervene (Part 2)
	doNext(interveneWithKittyKats2);
}

//Intervene (Part 2):
private function interveneWithKittyKats2():void
{
	clearOutput();
	outputText("You blink your eyes.  Ugh - even that hurts!  You can’t see anyone in front of you, but then you hear someone take a step towards you.  A male cat morph, perhaps even one of the ones who was threatening the younger woman, stands over you with a wooden plank in one hand.");
	outputText("\n\nA soft voice calls out, “<i>Don’t! You hit " + player.mf("him","her") + " awfully hard last time.  Evelyn will give you the boot if you kill " + player.mf("him","her") + ".</i>”");
	outputText("\n\nHe rolls his eyes, tosses the plank to the side and says, “<i>Fine - But if " + player.mf("he","she") + "’s awake " + player.mf("he","she") + " could get away.  You stay here and watch " + player.mf("him","her") + ".</i>”");
	outputText("\n\n“<i>You’ll put some milk aside for me, right?</i>” the voice asks, worried but hopeful.");
	outputText("\n\n“<i>Don’t worry, we’ll save you some,</i>” he says as he walks away.");
	outputText("\n\n“<i>Yeah, like last time,</i>” she mutters under her breath.");
	outputText("\n\nYou find that in addition to your feet you hands have been bound in front of you.  They didn’t gag you, presumably they expected you to stay unconscious a bit longer.");
	outputText("\n\nRolling onto your other side, you expect to see the young cat morph from before, but this girl is different.  Slightly more than 5 feet tall, she’s got jet black fur over her body and a mane of shoulder length hair that’s been dyed neon pink.  Her B-cup breasts stand out nicely on her lithe frame.  There’s a small silver bell attached to a collar around her neck.  It’s hard to gauge her age, but you think she has to be around 18 or 20.  Or rather, she would be if she were human.");
	outputText("\n\nYou can tell she’s a bit nervous thanks to the twitching of her slender tail.  It swishes back and forth the same way that a feral cat's might when agitated.  Since you can speak, you try to strike up a conversation with the girl.");
	//[Next]
	//Leads to Intervene (Part 3) 
	doNext(interveneWithKittyKats3);
}

//Intervene (Part 3):
private function interveneWithKittyKats3():void
{
	clearOutput();
	outputText("You ask her why she’s worried about the milk.  She looks down at you, seems to decide you aren’t much of a threat right now and sits down on the edge of a crate.");
	outputText("\n\n“<i>I probably shouldn’t be talking to you, but what’s the harm in it?</i>” she says, almost to herself.  Her stomach contributes to the conversation with some long, painful sounding gurgling noises.  She rubs her belly and sighs before continuing.");
	outputText("\n\n“<i>We need to eat, just like everyone else, and milk is the best kind of food.  All of us love milk.</i>”  Once again she stops to quiet a rumble from her stomach.  “<i>But milk goes off fast.  Last time they saved me some milk but it was almost cheese by the time it got to me.</i>”");
	//(remove 25 gems from inventory)
	player.gems -= 25;
	outputText("\n\nYou ask her why she’s the one guarding you.  “<i>I’m new at this so I get all the jobs from the bottom of the barrel.</i>”  She pulls a bundle up from inside the crate she’s sitting on.  “<i>All your stuff’s here except for a few gems.  Just enough for all of us to get a meal.</i>”  She lowers the bundle back into the crate.");
	outputText("\n\nYou ask her why the cats don’t just take everything.  Her response is almost a panic.  “<i>Then we’d get in real trouble! No, no, no.</i>”  She calms herself down and continues.  “<i>Most people won’t go all the way to a Watch house to report a handful of missing gems.  For a thousand gems or even a hundred?  Sure.  But with us they still have all their valuable stuff - armor, weapons, anything personal.  They know the Watch isn’t going to be able to find a handful of gems, so why bother?</i>”");
	outputText("\n\n“<i>Lots of gangs have stripped people bare.  They always get caught.  Other gangs killed their marks so they couldn’t tell the Watch who robbed them.  The Watch <b>really</b> stomped on them.  That’s why Evelyn’s plan works so well.  We’re not enough trouble for anyone to go after and we’re never the worst people on the street.</i>”");
	//[Next]
	//Leads to Intervene (Part 4) 
	doNext(interveneWithKittyKats4);
}

//Intervene (Part 4):
private function interveneWithKittyKats4():void
{
	clearOutput();
	outputText("For a while you lie still and she stares off into space.  She’s obviously distracted by her hunger, but how can you use that?  A plan forms and you ask her why, if cats love milk, did they just leave you here?");
	outputText("\n\nShe gives you a confused look and asks, “<i>What do you mean?</i>”");

	outputText("\n\nYou shift on the ground and reply that you’re lactating.  She gets up and kneels beside you, stomach growling once again.");
	//(if flat chested)
	if (player.biggestTitSize() < 3) outputText("\n\n“<i>But you barely even have breasts,</i>” she says, resting her hand gently on your chest.  You ask her if that means anything in Mareth.");
	else outputText("\n\nShe presses her hand gently against your chest and her pupils dilate.  “<i>No.  They... they must have checked, must have sniffed for it.</i>”");

	outputText("\n\nShe starts to fumble with your [armor], her hunger clearly overriding her better judgement.  That’s your opening.  You punch upward with your bound hands, catching her in the gut and knocking the wind out of her.");
	outputText("\n\nShe’s not much of a fighter, and in one move, the situation is reversed.  She’s flat on her back, gasping for air, and you’re sitting on top of her, ");
	if (player.isBiped()) outputText("holding her tightly between your knees"); 
	else if (player.isNaga()) outputText("your snake-like coils wraped around her");
	else outputText("holding her tightly");
	outputText(".  If she gets her wits about her she might still be able to escape, so you put your hands over her mouth and tell her to untie you in your most commanding tone.");
	outputText("\n\nShe freezes in place, staring into your eyes.  Then her fingers reach up and, after some fumbling, free your hands.  You remind her that considering she just robbed you calling out isn’t a good idea.  Then you take your hands away and ask what her name is.");
	//[Next]
	//Leads to Intervene (Part 5) 
	doNext(interveneWithKittyKats5);
}

//Intervene (Part 5):
private function interveneWithKittyKats5():void
{
	clearOutput();
	outputText("“<i>Kath - Katherine,</i>”  she blurts out.  That’s when you feel something growing between you.  A hot bump seems to have developed.  It dawns on you that this very feminine kitty is actually a herm, and from the size and pressure of that bump you’re guessing she’s packing a real monster down there.");
	outputText("\n\n“<i>P - Please - nooo!</i>” she cries, but it’s too late.  Her belt can’t cinch tight enough and her cock snakes through the gap between her tattered pants and her belly.  You suspect she’d be turning bright red if it weren’t for her fur.  Speaking of red, the cock is bright red and doesn’t belong on any kind of cat.  The continued swelling near the base confirms it.  Katherine has the cock of a canine, and that cock has a huge knot.");
	outputText("\n\nShe whimpers, “<i>I just wanted food,</i>” and tries to hide her cock by curling into a ball under you. ");
	outputText("\n\nIf you help Kath, it might pay off in more than karma... if you're into that sort of thing.  You could also turn your back on her, likely forever.");
	menu();
	addButton(0,"Help",helpKathAfterInterruptu);
	addButton(1,"Leave",leaveKathYouDontWantThatNastyHermCock);
}

private function leaveKathYouDontWantThatNastyHermCock():void
{
	clearOutput();
	outputText("You decide you’re better off not getting involved with some weird sort of hermaphroditic chimera.  She's obviously more trouble than she's worth and best avoided.");
	outputText("\n\nPutting it out of your mind you walk deeper into the city.  You’ve got things to take care of.");
	flags[kFLAGS.KATHERINE_RANDOM_RECRUITMENT_DISABLED] = 1;
	doNext(telAdre.telAdreMenu);
}

private function helpKathAfterInterruptu():void
{
	clearOutput();
	//(corruption <25)
	if (player.cor < 25) outputText("You feel you just have to do something for her.  She needs food and she’s ashamed of her own body.  That’s rare in this land, but it’s not a good way to live your life.");
	else if (player.cor < 75) outputText("Right now she needs food, no question.  If you help her out maybe she’ll be more willing to talk to you in future.  Maybe you can become a friend to her, maybe more.");
	else outputText("You could take her here and now, but her ‘friends’ might come back and help her.  Or a member of the Watch might find you.  Better to play the long game with this very fuckable kitty.");
	//(Set KATHERINE_UNLOCKED to -1)
	flags[kFLAGS.KATHERINE_UNLOCKED] = -1;
	
	//(remove 10 gems from inventory)
	player.gems -= 10;
	outputText("\n\nYou free your legs, go to the crate, and collect your gear.  Katherine remains on the ground, eyes squeezed shut.  She’s tucked her erection inside her shirt and she’s clutching it to herself, seemingly trying to force it to die down.  You count out 10 gems and press them into her hand.");
	outputText("\n\nHer eyes pop open and she stares at the gems.  “<i>But... but I... we... robbed you.</i>”  You give her a pat on the shoulder and tell her to get something to eat.  She springs up from the ground and hugs your [legs], whispering, “<i>Thank you thank you thank you.  I won’t tell anyone, thank you so much.</i>”");
	outputText("\n\nYou stride out of the alley, hoping that you’ll meet Katherine again.");
	//[Next]
	//Proceed to normal Tel’Adre menu
	doNext(camp.returnToCampUseOneHour);
}

//Leave:
private function leaveKittyKatsLikeANeeeeeerrrrd():void
{
	clearOutput();
	outputText("You decide you’re better off not getting involved.  After all, who knows what she’s done?  She’s obviously a stray and could have stolen something from one of the others.  Heck, with all the perverts you’ve seen in this land she could have a rape fetish.  Surely she would scream to attract the guard if she were in real trouble.");
	outputText("\n\nPutting it out of your mind you walk deeper into the city.  You’ve got things to take care of.");
	doNext(telAdre.telAdreMenu);
}

//Second Ambush - First time with Katherine
//This only happens if you intervened the first time (KATHERINE_UNLOCKED == -1)
//Otherwise you would just run into the first ambush once again. As with the first ambush this one should not trigger if the PC has less than 35 gems.
public function repeatAmbushKatherineRecruitMent():void
{
	clearOutput();
	outputText("As you walk the streets of Tel’Adre, a familiar sight catches your eye.  In a nearby alley, a young looking cat-morph is being backed into a corner by three larger cat-morph men.  Though you still don’t know the girl’s name you remember the setup.");
	outputText("\n\nYes, there are just enough dilapidated crates to conceal three or four more cats in ambush positions.  You can’t see Kath, but you");
	if (player.cor < 75) outputText(" hope she’s here so you can get to know her better.");
	else 
	{
		if (player.hasCock() && player.hasVagina()) outputText("r dick swells and your pussy moistens");
		else if (player.hasCock()) outputText("r dick swells");
		else if (player.hasVagina()) outputText("r pussy moistens");
		else outputText("r sphincter twitches");
		outputText(" at the thought of her flexible body and perky tits.");
	}
	outputText("  You’re a lot less keen about the idea of getting whacked across the head again.");

	outputText("\n\nWith that in mind you run into the alley but skid to a stop just short of the crates.  The snare pops up from the debris and snaps to the side.  Someone hiding inside one of the barrels says, “<i>Shit!</i>”  Speaking loudly enough that everyone in the alleyway should be able to hear, you let them know that they might as well come out.  You’ve seen this trick once before.");
	outputText("\n\nSince you haven’t drawn a weapon and don’t sound too angry, some cat morphs start coming out from inside different crates and barrels.  Some look wary, others a little sheepish.  Kath stands up, recognizes you, and tries to hide it.  She drops the cord she was holding and stares at her feet.");
	outputText("\n\nYou ask who’s in charge.  A middle-aged woman steps forward.  She’s got ginger colored fur and decent sized muscles for a cat morph.  She must be the Evelyn that Kath mentioned last time.  Her blue eyes study you carefully.");
	outputText("\n\nYou could try to bargain for some time with Kath, you could donate some gems to feed them, or you could try threatening her.");
	//[Bargain] [Donate] [Threaten]
	menu();
	addButton(0,"Bargain",bargainForKittahKatPussah);
	addButton(1,"Donate",donateToCatSlutsYouCatSlut);
	addButton(2,"Threaten",threatenCatSluts);
}

//Bargain:
private function bargainForKittahKatPussah():void
{
	clearOutput();
	outputText("Since sex is so prevalent in this land, you decide to try something that would have got you in a load of trouble back in Ingnam.  You tell Evelyn that you’d be willing to give the rest of them some gems in exchange for a little time with one of her friends.");
	outputText("\n\nEvelyn’s expression doesn’t change.  There are some murmurs from the cat morphs behind her, so you press on.  You look over the small crowd, letting your eyes linger here and there.  The younger girl in the tattered dress shrinks back under your gaze.");
	outputText("\n\nYou point at Katherine and hold out 25 gems.  You point out that it’s how much they would have taken anyway.  This way they don’t have to rush because nobody’s going to call the Watch, nobody’s going to report a theft.");
	//(remove 25 gems from inventory)
	player.gems -= 25;
	outputText("\n\nEvelyn seems to consider for a moment, then takes the gems.  She growls that it’s cruel to prey on people’s hunger, and she points at Kath, telling you she’d better not get hurt.  Then she and the others take off, probably making a beeline to the nearest milk vendor.");
	//[Next]
	//Leads to Bargain (Part 2)
	doNext(bargainForKittahKataPussah2);
}

//Bargain (Part 2):
private function bargainForKittahKataPussah2():void
{
	clearOutput();
	outputText("Kath’s shoulders sag, and she sits down heavily on a crate.  She looks up at you and says, “<i>I joined the vagrant cats so I wouldn’t have to sell myself.  Not that most people want me.  And now my ‘friends’ just sold my ass for a drink of milk.</i>”  She sniffs a little and adds, “<i>I won’t fight, there’s no point.  Just do whatever you want.</i>”");
	//(corruption <25)
	if (player.cor < 25) outputText("\n\nIt really breaks your heart.  She’s so crushed right now that you have got to find some way to help her, some way to lift her spirits.");
	else if (player.cor < 75) outputText("\n\nYou’re sure that right now Kath needs a shoulder to cry on.  A nastier part of you, a part with a strong connection to your groin, whispers that vulnerable girls love heroes.");
	else outputText("\n\nYou promised yourself you’d play the long game with this pussy.  It takes all you’ve got not to tear her clothes off and rape her every way possible.  You have visions of her violated body curled in a ball and covered in your seed.  Finally you snap out of it.");
	outputText("  She tenses as you put an arm around her shoulders.");

	outputText("\n\nYou point out that all you asked for was a little time with her.  Next, you ask if she’d like to take a walk with you.  You’re sure you saw a restaurant just down the street that would be a great place to take her on a date.  Her jaw opens and closes but no words come out.  Her stomach rumbles, trying to answer for her.");
	outputText("\n\nShe jumps to her feet and wipes the hint of tears from her eyes.  “<i>You really want to take <b>me</b> on a date?</i>”");
	outputText("\n\nYou ask if it’s illegal to take a pretty girl out on a date.  You can’t see her blush, but you can feel the warmth right through her fur.");
	//[Next] //Leads to Second Talk with Katherine
	doNext(secondTalkWithKatherine);
}

//Donate:
private function donateToCatSlutsYouCatSlut():void
{
	clearOutput();
	outputText("You tell the cat morphs that you know they’re just doing this because they’re hungry.  You say that last time they needed 25 gems and you stick your hand into your coinpurse, pulling out a handful of stones.");
	//(remove 25 gems from inventory)
	player.gems -= 25;

	outputText("\n\nEvelyn steps forward and takes the gems you’re offering.  She takes a long look at you and the gems, probably trying to decide if this is some strange kind of trap or trick.");
	outputText("\n\n“<i>Thank you stranger,</i>” she says, and you can tell she isn’t used to saying those words.  “<i>Now just to make sure you don’t run into any more trouble I’ll have one of my friends escort you wherever it is you’re going.</i>”  Of course that also means that if you went to the Watch someone could warn the others to lie low.");
	outputText("\n\nYou see Katherine is just about to pipe up when one of the others says, “<i>It’s Kath’s turn.</i>”  With milk on the menu, watching someone is the last thing most of them want to do.  She spins around, looking like she’s about to argue.  Her jaw snaps shut as she remembers that even if this is unfair it happens to be what she wants.");
	outputText("\n\nEvelyn nods and says, “<i>I suppose it is.  Just remember that makes it Reth’s turn next time.</i>”  Then she and the others take off, probably making a beeline to the nearest milk seller.");
	//[Next]
	//Leads to Donate (Part 2)
	doNext(donateToCatSlutsYouCatSlutPt2);
}

//Donate (Part 2):
private function donateToCatSlutsYouCatSlutPt2():void
{
	clearOutput();
	outputText("Kath leans against the wall and tries to flick some grime off her shirt.  Once the other cat morphs are out of the alley she quietly asks where you’re going.  You say that on the way here you saw a restaurant just down the street.  Would she like to accompany you?");
	outputText("\n\nHer head sinks a little and says, “<i>I don’t have any money.</i>”");
	outputText("\n\nYou walk over to her and take her hand, telling her that you’re buying.");
	outputText("\n\n“<i>Wait - doesn’t that almost make it a date?</i>” she asks.");
	outputText("\n\nYou ask if it’s illegal to take a pretty girl out on a date.  You can’t see her blush, but you can feel the warmth right through her fur.");
	outputText("\n\nShe pounces on you, wrapping her arms around you.  “<i>You really want to take <b>me</b> on a date?</i>” she asks, her voice filled with hope. ");
	//(corruption <25)
	if (player.cor < 25) outputText("You tell her that of course you want to.  She seems like a nice person, and you want to get to know her better.");
	else if (player.cor < 75) outputText("You say that yes, you would love to take her out on a date.  You don’t say that you’d like even more to press her vulnerable body against the wall and have your way with her.");
	else outputText("You promised yourself you’d play the long game with this pussy.  She already defers to you so quickly - with just a little work up front you could have a really submissive little fuck toy.");
	//[Next]
	//Leads to Second Talk with Katherine
	doNext(secondTalkWithKatherine);
}

//Threaten:
private function threatenCatSluts():void
{
	clearOutput();
	outputText("You cross your arms and tell Evelyn that her little ambush isn’t going to work a second time.  They can either scram, now, and set up in some other alley, or they can try and take you.");
	outputText("\n\nSome of the cats look like they’re sizing you up but Evelyn speaks quickly to keep them in line.  “<i>This one’s more trouble than " + player.mf("he","she") + "’s worth.  Grab the stuff and we'll set up somewhere else.  There’s more fish in the sea.</i>”");
	outputText("\n\nWhile she’s talking you see Kath wink at you.  You wait for the cat morph gang to clear out then walk out onto the street.  Soon enough you hear some footsteps behind you. Katherine is there, alone.  “<i>Hi,</i>” she says.  “<i>I, um, was wondering if I’d see you again.</i>”");

	//(corruption <25)
	if (player.cor < 25) outputText("The poor girl is desperate for a friend.  You hope you can be a good enough person and help her out.");
	else if (player.cor < 75) outputText("It’s a real shame Katherine is so lonely.  She shouldn’t be willing to trust a virtual stranger like you, but here she is and here you are.");
	else outputText("You can’t wait to twist this submissive thing around your finger.  She’s got almost no one, and that means almost no one to tell her what a bad influence you will be.  With just a little work up front you could have a really submissive little fuck toy.");
	outputText("  You give her a smile and take her hand, asking her if she might like any of the dishes at the restaurant just down the street.  It seemed like a good place for a date.");
	outputText("\n\nShe must be blushing because you can feel the warmth through her fur.  She tries to speak, but for a while no words come out.  Then finally she says, “<i>You really want to take <b>me</b> on a date?</i>”");
	outputText("\n\nYou ask if it’s illegal to take a pretty girl out on a date.  You didn’t walk into that ambush a second time for yourself.  You did it because you wanted to see her.  Katherine’s eyes light up and she squeezes you tight as though she wants to make sure this is real.");
	//[Next]
	//Leads to Second Talk with Katherine
	doNext(secondTalkWithKatherine);
}

//Second Talk with Katherine:
private function secondTalkWithKatherine():void
{
	clearOutput();
	outputText("A short walk takes you to the restaurant where you grab a table and ask Katherine what she’d like.  Without hesitation she says, “<i>A milkshake!  Oh, it’s been soooo long since I had one.</i>”");
	//(remove 10 gems from inventory)
	player.gems -= 10;
	outputText("You had hoped that you might be able to talk to her over food, but when the milkshake arrives Kath drinks it with gusto.  In under a minute the whole thing is gone and Kath looks at you sheepishly while rubbing away the little milk mustache she gave herself.  “<i>Sorry, I really needed that.</i>”  She looks around and adds, “<i>Besides, maybe we could talk somewhere else.</i>”");
	outputText("\n\nLooking around the restaurant you see what she means.  Her scruffy clothes are as distinctive as a watch badge.  Katherine and other vagrants aren’t really welcome, the restaurant is only putting up with her because you look respectable.");
	outputText("\n\nYou pay the bill quickly and Katherine leads you back into the streets.  For some reason she seems excited and nervous, though you aren’t sure why.  She soon finds a quiet corner in a bricked off alleyway between two buildings.  She sits on the edge of a broken desk and fidgets.");
	//[Next]
	//Leads to First Time with Katherine
	doNext(firstTimeWithKatherineUTerribleScrub);
}

//First Time with Katherine:
private function firstTimeWithKatherineUTerribleScrub():void
{
	clearOutput();
	outputText("You ask Katherine what’s wrong.  She looks at her feet and asks, “<i>Why are you being so nice to me?  I like you, but I don’t know why you like me and - and I don’t want to screw up.</i>”");
	outputText("\n\nYou sit next to her and tell her you like her because she seems nice; she’s really pretty and you want to give her a hand.");
	outputText("\n\n“<i>I’m pretty?</i>” she says.  “<i>You keep saying things like that but-</i>” she waves in the general direction of her crotch “<i>-you know what I am.  You know what I have down there.  I’ve got a knot bigger than any boy I’ve ever seen and I don’t even have the right <b>kind</b> of... penis.</i>”");

	if (player.cor < 25) 
	{
		outputText("\n\nYou tell her that love is blind.  So she has a dog cock.  If that bothered you then you wouldn’t be here, would you?  You want to get to know her because you like her, all of her.");
		outputText("\n\nKath just leans against you, not responding to any of what you’re saying.  She must think everyone secretly hates her cock, and she’ll never be able to get over the risk of rejection on her own.  You get the feeling that if you don’t take the lead, she will never be able to believe she’s worth anything.");
		outputText("\n\nYou ask her if she trusts you.  She nods ever so slightly, and you kiss her.  Her lips are trembling and her eyes are screwed shut.  You kiss her lips slowly and gently until you feel her begin to respond.");
		outputText("\n\nHer hand moves to her pants, trying to contain her growing erection.  Again you ask her to trust you, and you pull her hand away, letting the tip of her cock snake out into the open.");
		outputText("\n\nYou tell her that right now she needs to lie still and let you show her that you love her.  You take each of her hands in yours and press them against the wall on either side of her head.  She lets you and then you begin to run your hands up and down her sides, over her breasts, and across her belly.");
		outputText("\n\nWith each stroke, you see her cock slip further out of its sheath.");
	}
	else if (player.cor < 75)
	{
		outputText("\n\nYou tell her that you’ve travelled outside Tel’Adre.  You’ve seen many weird and wonderful things.  Is she really that terrible?  She’s clearly no demon, you would recognize that and so would the Watch.");
		outputText("\n\nKath just leans against you, not responding to any of what you’re saying.");
		outputText("\n\nYou tell her you can prove it to her.  You arm goes around her back and you start to gently rub the nape of her neck.  She tries to argue but you press a finger to her lips and wink.");
		outputText("\n\nThe excitement and nervousness from before boil over.  It’s like her mind just can’t decide what to do.  Her body, on the other hand, knows exactly what to do.  You see that python-sized cock begin to tent her pants.");
		outputText("\n\nShe reaches down, attempting to contain it, but you block her and take hold of her wrist.  The rest of her canine cock bursts free and you blow gently on the head, encouraging it to poke even further out of its sheath.");
	}
	else
	{
		outputText("\n\nYou tell Kath that you’re about to prove that you want her, and not just as a friend.  You use one arm to press her against the wall, taking the opportunity to grope those perky breasts.  Before she can react, you use your other hand to reach down into her pants and rub her big flaccid cock.");
		outputText("\n\nKath moans, and in seconds, her cock begins to slide from its sheath.  You make room so that it can escape from her trousers and stand proud in the open air.  She looks shocked and her mouth is slightly open, so you press your lips to hers.  She closes her eyes as you slide your tongue into her mouth, wrestling with Katherine’s own rough tongue for position.");
		outputText("\n\nMeanwhile, your hands have done their work.  Her nipples have begun to poke through the thin fabric of her shirt.  Her cock feels warm and hard; through your fingers you can feel her rapidly increasing heartbeat.");
		outputText("\n\nYou break the kiss and tell her, “<i>Kath - <b>you</b> want this.</i>”");
	}
	outputText("\n\nKatherine lets out a quiet, “<i>Yes,</i>” and that’s all you need.");
	//[Next]
	//Leads to the new handjob scene, described later in this document
	initFlags();
	doNext(handjobbiesFurrDemCatFurries);
}

//Handjob Scene
//This is used in the new recruitment path and is also available as a repeatable scene once
//Katherine is accessible in the alley behind the pawn shop. At the pawn shop I think this scene //should be available even if lust < 33, since you’re doing this for and to her.
//Makes use of katKnot(), a new helper function which is listed under implementation details.
public function handjobbiesFurrDemCatFurries():void
{
	//Scene can happen in the streets or at Kath's apartment
	clearOutput();
	if (isAt(KLOC_BAR) || isAt(KLOC_BAR_DRUNK) || isAt(KLOC_BAR_URTA_REFUSED)) { //At the bar
		outputText("Kath's tail twitches excitedly and she polishes off her drink, eager to see what you have in mind.\n\n");
		outputText("You take her hand and lead her outside, to " + (flags[kFLAGS.TIMES_FUCKED_URTA] > 0 ? "that familiar" : "the") + " alleyway behind the Wet Bitch.\n\n");
		outputText("She looks a little worried about getting caught, but she's too excited to refuse you.\n\n");
	}
	outputText("You pull Kath into your lap and she purrs.  Both your hands slide under her shirt and begin to ");
	if (player.cor < 25) outputText("slowly caress her tender breasts");
	else if (player.cor < 75) outputText("tease her lovely breasts");
	else outputText("roughly manhandle her knockers");
	if (flags[kFLAGS.KATHERINE_UNLOCKED] > 0 && breasts.milkIsFull()) outputText(".  Your fingers are soon coated in her cream and you offer them to Kath, who eagerly licks them clean");
	outputText(".  Her tail, trapped between your body and hers, flicks back and forth");
	if (player.hasCock()) outputText(", causing your " + player.multiCockDescriptLight() + " to rise to the occasion.");
	else if (player.hasVagina()) outputText(", teasing your hot little slit.");
	//(genderless)
	else outputText("in a seductive manner.");

	outputText("\n\nOnce Kath’s nipples are rock hard you slide your fingers down the soft " + catGirl("skin", "fur") + " of her belly until they find ");
	if (!hasCock()) {
		outputText("her hot, moist snatch.  A few strokes and you’ve spread her soft, wet lips.  While one hand slips inside to plumb her depths the other latches onto her clit and starts massaging the little nub.");
		outputText("\n\nThe heat is intense and Kath’s pussy dribbles at your ministrations.  Kath’s hips jerk forward, her body begging for a cock to fill her up.");
	}
	else if (cockNumber > 1) {
		outputText("the tips of her hot shafts.  A few strokes and you’ve spread her copious precum over both of her cocks.  While one hand continues to pleasure her pricks the other goes lower, slipping " + (flags[kFLAGS.KATHERINE_UNLOCKED] < 1 ? "under her belt and into her pants." : "into her moist snatch."));
		outputText("\n\nThe heat is intense and Kath’s " + knotAdj() + " knots swell at your ministrations.  Kath’s hips jerk forward, looking for a pussy or two to pack them into.");
	}
	else {
		outputText("the tip of her hot shaft.  A few strokes and you’ve spread her copious precum over most of her cock.  While one hand pleasures her prick the other goes lower, slipping " + (flags[kFLAGS.KATHERINE_UNLOCKED] < 1 ? "under her belt and into her pants." : "into her moist snatch."));
		outputText("\n\nThe heat is intense and Kath’s " + knotAdj() + " knot swells at your ministrations.  Kath’s hips jerk forward, looking for a pussy to pack it into.");
	}
	if (hasCock()) {
		outputText("\n\nKath’s next moan comes from the bottom of her lungs.  Thanks to you she’s already horny and now you decide to overload her senses.  Your fingers " + (hasBalls() ? "cup her balls" : "tease her clit") + " for just a moment before slipping " + (cockNumber < 2 ? "back " : "") + "into her dripping cunt.");
		outputText("\n\nHer head tilts back, and she tries to find your mouth with her own.  As your tongues entwine, you begin to slide your fingers in and out of her slit, making sure to rub hard against her tiny nub.  Your other hand ");
		if (cockNumber > 1) {
			outputText("works up and down her " + cockAdj() + "shafts, alternating from one to the other.  Soon you can feel them both twitching, ready to fire their loads into a pair of fertile pussies.");
			outputText("\n\nYou aim Katherine’s dicks");
		}
		else {	
			outputText("works up and down her " + cockAdj() + "shaft.  Soon you can feel it twitching, ready to fire its load into a fertile pussy.");
			outputText("\n\nYou aim Katherine’s dick");
		}
		outputText(" at the " + (isAt(KLOC_DESERT) ? "ground" : "wall") + ".  You pull your fingers from her pussy and rub her wetness over " + (hasBalls() ? "her fuzzy balls" : "her growing knot") + ".  Pulling your head back you tell Kath to cum for you.  She gasps and you feel " + (hasBalls() ? "that " + ballAdj() + " ballsack contract" : "her cock" + cockMultiple("", "s") + " twitch and harden") + " as Kath lets loose with who knows how much pent up cum.");
		outputText("\n\nYou’re not done with her yet.  As the first shot splatters against the ");
		if (isAt(KLOC_DESERT))
			outputText((model.time.hours <= 18 ? "hot" : "cool") + " sand");
		else outputText(isAt(KLOC_KATHS_APT) ? "plaster" : "brickwork");
		outputText(" you slip your fingers back to her cunt and attack her clit.  Despite already being in the midst of one orgasm, Kath’s body tenses up even more.  It feels like a cup of water gushes from her pussy and the next blast from her cock" + cockMultiple("", "s") + " is even stronger, " + (isAt(KLOC_DESERT) ? "arcing a good six inches further " : "hitting the wall a good six inches higher") + " than the first.");
	}
	else outputText("\n\nHer head tilts back, and she tries to find your mouth with her own.  As your tongues entwine, you push deeper than ever, massaging her inner walls and rubbing hard against her tiny nub.  Pulling your head back you tell Kath to cum for you.  She gasps and you feel a deluge inside her pussy.  Her muscles vice down on your fingers as if they want to keep them inside forever.");

	outputText("\n\nKath turns to liquid in your arms as several more orgasms wash over her like the aftershocks of an earthquake.  All she can do is look up into your eyes and smile.  ");
	if (player.cor < 25) outputText("You hold her in your arms while she recovers.  You really enjoy seeing the happiness and contentment in her face.");
	else if (player.cor < 75) outputText("While you wait for her to recover you pull her shirt up and play with her breasts a bit more.  By the time she can move again her nipples are sticking out like little berries.  She blushes, but clearly enjoys the attention.");
	else {
		outputText("Not one to pass up a helpless young " + (hasCock() ? "herm" : "girl") + " you " + (flags[kFLAGS.KATHERINE_UNLOCKED] < 1 ? "strip all Katherine’s clothes off.  You" : "") + " play with her tail, eventually growing bored and pushing the tip deep inside her pussy.\n\n");
		if (hasCock())
			outputText("Next you run your hand" + (isAt(KLOC_DESERT) ? cockMultiple(" along her cock", "s along her cocks") : " over the wall") + ", collect some of her still warm spunk");
		else outputText("Next you collect some of her femcum on your fingers");
		outputText(" and offer it to her.  Kath’s rough tongue licks every drop from your hand while you think of all the things you’d like to do with her body.");
	}
	if (isAt(KLOC_DESERT))
		outputText("\n\nWith training over for now you get Katherine to pack up her equipment and lead her back to Tel'Adre.  When you reach her alley Kath throws herself on the pile of softer scraps she's collected and says <i>“Please come back soon " + player.short + ", I'll do better next time.”</i>");
	orgasm();
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	dynStats("lus", 33);
	if (flags[kFLAGS.KATHERINE_UNLOCKED] == - 1) 
		doNext(firstTimeWithKatherinePartTwoUltraChampionshipEditionHyperTurbo);
	else doNext(camp.returnToCampUseOneHour);
}

//First Time with Katherine (Part 2):
private function firstTimeWithKatherinePartTwoUltraChampionshipEditionHyperTurbo():void
{
	clearOutput();
	outputText("You help Kath get to her feet and she gives you a big hug.  A few sniffles lead to some sobs before she pulls herself together enough to say, “<i>I didn’t believe anyone cared about me.</i>”");
	//(corruption <25)
	if (player.cor < 25) outputText("\n\nYou assure her that you do, and that you want to see her again.  In fact you hope to see her often and you would love to get to know her better.");
	//(corruption < 75)
	else if (player.cor < 75) outputText("\n\nYou assure her that you do, and that you want to see her again.  In fact, you hope to see her often, and you would love to get to know her better.  What you don’t add is that you mean ‘get to know her’ both in terms of friendship and carnally.");
	//(corruption >= 75)
	else outputText("\n\nYou debate just crushing her spirits right here and now, but she’s so delightfully submissive.  You can find (or make) an abused fucktoy just about anywhere in Mareth, but what are the chances of finding a naturally submissive, needy young herm with no friends or family?\n\nTickling her clit once more, you assure her that you want to see a lot more of her and you would love to introduce her to some new experiences.");
	outputText("\n\nKath beams and says, “<i>I don’t want you to risk getting ambushed every time you want to see me.  I know another gang got captured by the Watch.  They used to hang out behind one of the pawn shops.  It’s run by a retriever named Oswald.  I don’t know for how long, but right now nobody’s living there, so if you’re looking for me I’ll be there.  Besides, Oswald is a good guy, he doesn’t try to cheat people like me just cause we can’t sell things very easily.</i>”");
	outputText("\n\nYou ask her about her gang.  “<i>The vagrant cats?</i>”  She shakes her head.  “<i>They’ve always treated me like the runt of the litter because I don’t like hurting people or selling myself.  The only other person who they treat almost as bad is Helena.  You’ve seen her, she’s the young-looking one they put in the dress.</i>”");
	outputText("\n\nShe kicks aside a stone and says, “<i>I managed on my own for a while before I started running with a gang.  It wasn’t that I couldn’t find enough food, I was just lonely.</i>”");
	outputText("\n\nYou agree to meet up with her later, though you say that with your duties at the portal you don’t know how often or when you’ll be able to see her.");
	outputText("\n\n“<i>That’s okay, it’s more the fact I know you’ll come back... for me.</i>”  Then she says with a start, “<i>Oh, hey! I don’t even know your name.</i>”");
	outputText("\n\nYou smile and tell her.");
	outputText("\n\n“<i>[name]</i>” she says");
	if (player.short == "Kath" || player.short == "Katherine" || player.short == "Helena" || player.short == "Evelyn" || player.short == "Oswald") outputText(".  “<i>Well isn’t that a coincidence! All right, ");
	else outputText(", rolling the foreign word around in her mouth. “<i>Well, ");
	outputText("[name], that was an amazing first date.  I hope we can do some more things like that - and believe me, I’ve got some ideas!");
	
	//(Set KATHERINE_UNLOCKED to 1)
	flags[kFLAGS.KATHERINE_UNLOCKED] = 1; //If Kath was recruited through Scyllia then KATHERINE_MET_SCYLLA will be set to 1
	
/*	// Setup her cock defaults - No longer needed, all handled in firstTimeWithKatherineUTerribleScrub so the handjob scene works properly first time through
	flags[kFLAGS.KATHERINE_DICK_COUNT] = 1;
	flags[kFLAGS.KATHERINE_DICK_LENGTH] = 8;
	flags[kFLAGS.KATHERINE_KNOT_THICKNESS] = 6;
	flags[kFLAGS.KATHERINE_BALL_SIZE] = 1; */
	
	outputText("\n\n(<b>Katherine can now be encountered behind Oswald's!</b>)");
	doNext(camp.returnToCampUseOneHour);
}

public function bathTime():void {
	clearOutput();
	outputText("You don’t want to dive into the lust polluted lake but you do feel that Kath needs a little swim.  You just smile at Katherine and " + (player.isNaga() ? "slither" : player.mf("walk", "strut")) + " towards the nearest stream of clean mountain water.  On the way you peel off each piece of equipment and clothing in turn.  You can sense Kath’s eyes staring at you the whole way.\n\n");

	outputText("Now disrobed you enter the cold, clean water and turn around to see Katherine madly struggling out of her clothes.  She kicks off the last garment and then charges you with lust in her eyes.\n\n");

	outputText("Cats back in Ingnam weren’t too keen on water but Kath doesn’t seem to care.  She launches off the shore in a graceful arc and crashes into you in what is at once both flying tackle and hug.\n\n");

	outputText("The impact knocks you straight into the drink.  There’s cold, there’s water and when you break the surface for a breath there’s a grinning Kath right next to you.  She hugs you again, gently this time, providing the only source of heat in this glacial water.\n\n");

	outputText((player.balls > 0 ? "Your balls try to retract, y" : "Y") + "our nipples harden and you can tell Kath’s are doing the same.");
	if (hasCock()) {
		outputText("  Her cock" + cockMultiple(" refuses to go soft - it grinds ", "s refuse to go soft - they grind "));
		if (player.isNaga())
			outputText("against your scaly underbelly");
		else outputText("between your " + (player.isTaur() ? "front " : "") + " legs");
		outputText(" like a red hot poker.");
	}
	if (player.isTaur()) {
		if (player.cocks.length == 0) //Female or genderless
			doNext(bathTimeCentaurPenetrated);
		else simpleChoices("Ride", bathTimeCentaurRide, "GetPenetrated", bathTimeCentaurPenetrated, "", null, "", null, "", null);
	}
	else {
		if (player.cocks.length == 0) //Female or genderless
			doNext(hasCock() ? bathTimePenetrated : bathTimeFrustrated);
		else //Herm or Male
			simpleChoices("Penetrate", bathTimeFuckKath, "GetPenetrated", (hasCock() ? bathTimePenetrated : null), "", null, "", null, "", null);
	}
}

private function bathTimeCentaurRide():void {
	outputText("\n\nKath holds you for a while, just grinding against you slowly and laying kiss after kiss on your lips and neck.  Finally she lets go and walks along your flank.  She stops beside you, pets your side and jumps onto your back.  She reaches around your torso and " + (player.hasBreasts() ? "starts to play with your breasts" : "runs her hands over your manly chest") + ".  Not satisfied with just that Kath begins grinding against you, " + (hasCock() ? "the " + cockMultiple("tip of her cock", "tips of her cocks") : "her pussy") + " grinding against what would be your ass if you were a human.  As a centaur it’s the sensitive spot where your spine curves.  Her " + (hasCock() ? "cockhead" + cockMultiple(" keeps", "s keep") : "groin keeps") + " rubbing against the small depression there, creating lovely sensations that travel in both directions.  At one end of your body your cock" + (player.cocks.length > 1 ? "s grow" : " grows") + " even harder, at the other your throw your head back and start to moan.\n\n");

	outputText("Katherine puts a hand on your cheek and draws your head back for a deep kiss.  The angle is a bit difficult for both of you, so she releases you, her hands going back to tweaking your nipples.  Kath leans forward and her rough tongue begins to lick the nape of your neck, driving you wild.\n\n");

	outputText("You can feel Kath’s ");
	if (hasCock())
		outputText(cockAdj() + "prick" + cockMultiple(" ", "s ") + (hasBalls() ? "and her " + ballAdj() + " balls" : "") + " pressing against your back,");
	else outputText("pussy growing wetter");
	outputText(" as she gets closer and closer to cumming.  Meanwhile your own cock" + (player.cocks.length > 1 ? "s are resting" : " is resting") + " ignored in the glacial river water.  You hear a purr and then two warm feet close around your " + (player.cocks.length > 1 ? "upper " : "") + "shaft.  Kath is using her feline flexibility to give you a footjob while at the same moment she grinds her " + (hasCock() ? "cock" + cockMultiple("", "s") : "vulva") + " against your spine, strokes your chest and licks your neck.\n\n");

	outputText("Katherine’s feet begin to stroke your " + (player.cocks.length > 1 ? "cocks" : "manhood") + " rapidly; if it weren’t for the river she would probably be rubbing you raw.  Then you feel her ");
	if (hasCock())
		outputText((hasBalls() ? "balls contract" : "her thighs clench") + " and her cock" + cockMultiple(" sprays a copious load", "s spray copious loads") + " of hot cum");
	else outputText("thigh muscles tighten and her pussy releases a spray of hot femcum");
	outputText(" against your back.  Kath’s legs pump furiously, trying to drive you to orgasm before she runs out of energy.\n\n");

	outputText("She only just succeeds.  As she collapses forward onto your back" + (hasCock() ? ", slapping wetly into her own spunk," : "") + " her feet weakly slide down towards the base of your " + (player.cocks.length > 1 ? "largest " : "") + " cock one last time.  You’re so close that’s all you needed.\n\n");

	if (player.cumQ() <= 500)
		outputText("You stand there as your cock" + cockMultiple(" fires", "s fire") + " a few streams of your seed into the river" + (hasCock() && (player.cumQ() + 500 < cumQ()) ? ".  Compared to Kath’s excessive load your performance seems almost emasculating" : "") + ".\n\n");
	else if (player.cumQ() <= 1500)
		outputText("Jet after jet erupts into the river.  It leaves you feeling a little weak.  You reach behind you and give Kath’s ears a little scratch.\n\n");
	else if (player.cumQ() <= 3000)
		outputText("Your cum launches out of your cock" + (player.cocks.length > 1 ? "s" : "") + " so forcefully that you can feel its warmth licking against the backs of your front knees.  With nothing to contain " + (player.cocks.length > 1 ? "them your cocks bounce back and forth like out of control firehoses" : "it your penis bounces back and forth like an out of control firehose") + ".\n\n");
	else
		outputText("Your overproductive " + (player.balls > 0 ? "testes outdo themselves" : "prostate outdoes itself") + ".  Without an ass, mouth or vagina to contain " + (player.balls > 0 ? "their deluge they just keep" : "its deluge it just keeps") + " firing and contracting.  Your cock" + (player.cocks.length > 1 ? "s jerk and bounce" : " jerks and bounces") + " so violently that your belly will probably sport some bruises after this.  The water grows warm around you and changes color noticeably downstream.  You have to wonder just how much magic is used up each time you cum.\n\n");

	outputText("When you recover from your ‘bath’ you wake Katherine up.  It’s probably not safe to stick around, so the two of you collect your things and start the long walk back to Tel’Adre.  Katherine is smiling and giggling through most of the trip back.");
	if (!hasAlready(KBIT_TRIED_BATH)) outputText("  In fact she enjoyed this trip so much that you have a feeling these ‘baths’ will become quite popular.");
	player.orgasm();
	orgasm();
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	experience(KBIT_TRIED_BATH);
	doNext(camp.returnToCampUseOneHour);
}

private function bathTimeCentaurPenetrated():void {
	outputText("\n\nKath holds you for a while, just grinding slowly and laying kiss after kiss on your lips and neck.  Finally she lets go and walks along your flank, stroking your flesh with her fingers.  The water resists your movements, giving Katherine the edge.  For now she is the one controlling the pace.  She gets to your rear and strokes your tail.  It rises into the air all on its own, letting Kath know just how much your body wants this.\n\n");

	if (hasCock())
		outputText("You can feel her cock" + cockMultiple("", "s") + " sliding against your inner thighs while Kath’s fingers tease your [vagOrAss].  She waits until your legs begin to tremble before sinking " + cockMultiple("", "one of ") + "her " + cockAdj() + "shaft" + cockMultiple("", "s") + " into your [vagOrAss].\n\n");
	else outputText("She waits until your legs begin to tremble before gently forcing her fingers deep into your [vagOrAss].\n\n");

	outputText("Once Katherine’s " + (hasCock() ? "cock" : "fist") + " is inside you there’s no stopping her.  She starts to pound you and only the fact that she has to push the water from between your bodies keeps her from hurting you.  Your knees begin to quiver as Kath delivers a savage " + (hasCock() ? "fucking you thought only a minotaur could manage" : "fisting, almost as if she's trying to prove she can still fuck you") + ".  Perhaps this stream is a little bit more lust polluted than you first thought.\n\n");

	outputText("She’s so lost in lust that she doesn’t talk or moan, though you are moaning enough for both of you.  At last you collapse forward, powerless to stop her as she drives home with one last thrust, her " + (hasCock() ? "knot" : "arm") + " sinking into your [vagOrAss]" + (hasCock() ? "" : "all the way up to the elbow") + ".\n\n");

	if (hasCock()) {
		outputText("Your belly expands with each squirt as her " + (hasBalls() ? ballAdj() + "testicles empty" : "bountiful prostate empties") + " into your");
		if (player.hasVagina() && player.isPregnant()) {
			outputText("vagina, her semen gushing against your sealed cervix.  The pressure is so great you feel streams of it seeping out around her knot, jetting into the waters around you." + (cumQ() > 500 ? "  Her cum is under such pressure that you can feel a small second bump forming above your belly as the uppermost part of your vagina swells up with Kath’s cum." : ""));
		}
		else { //Can use common text for when Kath has big balls
			if (player.hasVagina()) //Non-pregnant female/herm
				outputText("vagina, her semen forcing its way into your womb.");
			else //Male or genderless
				outputText("rectum, her semen inflating inch after inch of your intestines.");
			if (cumQ() > 500) outputText("Your belly is soon pressed against the cool stream bed, inflated with your girlfriend’s cum." + (cumQ() > 1500 ? "  It starts to get painful as Kath’s titanic orbs do their best to fill her mate.  Any more and you’re sure the muscles of your abdomen would give out." : ""));
		}
		if (cockNumber > 1) outputText("  Katherine’s other cock, still rubbing between your legs, releases its share of the load, coating your belly with a layer of her hot sperm.");
	}

	outputText("\n\nThe sensation of your girlfriend’s ");
	if (hasCock())
		outputText("hot cock throbbing inside you");
	else outputText(player.hasVagina() ? "knucles grinding against the entrance to your womb" : "fingers flexing deep inside your colon");
	outputText(" is too much.  You gasp as your own orgasm overtakes you, your [vagOrAss] clenching on Kath’s " + (hasCock() ? "cock, milking out the last few drops." : "forearm."));
	if (player.hasCock()) {
		if (player.cumQ() <= 500)
			outputText("  Your own cock" + cockMultiple(" fires", "s fire") + " a few streams of your seed into the river." + ((player.cumQ() + 500 < cumQ()) ? "  Compared to Kath’s excessive load your performance seems almost emasculating." : ""));
		else if (player.cumQ() <= 1500)
			outputText("  Jet after jet erupts from your own cock" + cockMultiple("", "s") + " into the river.  It leaves you feeling a little weak.");
		else if (player.cumQ() <= 3000)
			outputText("  Your cum launches out of your cock" + (player.cocks.length > 1 ? "s" : "") + " so forcefully that you can feel its warmth licking against the backs of your front knees.  With nothing to contain " + (player.cocks.length > 1 ? "them your cocks bounce back and forth like out of control firehoses." : "it your penis bounces back and forth like an out of control firehose."));
		else outputText("  Your overproductive " + (player.balls > 0 ? "testes outdo themselves" : "prostate outdoes itself") + ".  Without an ass, mouth or vagina to contain " + (player.balls > 0 ? "their deluge they just keep" : "its deluge it just keeps") + " firing and contracting.  Your cock" + (player.cocks.length > 1 ? "s jerk and bounce" : " jerks and bounces") + " so violently that your belly will probably sport some bruises after this.  The water grows warm around you and changes color noticeably downstream.  You have to wonder just how much magic is used up each time you cum.");
	}
	
	if (hasCock()) {
		outputText("\n\nAfter depositing her load Kath loses almost all her strength, only keeping her head above water by grabbing hold of your back with her hands.\n\n");
	
		outputText("You know that staying here after producing that kind of racket is unwise.  Using the strength inherent in your centaur body you force yourself back to your feet.  It’s hard to walk with your cum-stuffed belly; harder still when you have to climb out of the river and the water no longer supports your " + (cumQ() > 500 ? "bulging stomach" : "weight") + ".\n\n");
	
		outputText("Katherine is no help at all.  She’s still locked to your [vagOrAss] and still in a post-orgasmic stupor.  You have to carefully bend down and collect all your clothes and equipment, and hers as well." + (cumQ() > 500 ? "  With every bend your overstuffed belly gurgles and complains." : "") + "\n\n");
	
		outputText("It’s only when you’ve begun walking back to Tel’Adre that Kath’s knot finally deflates enough to grant you some relief.  You haul her forward and get her dressed, then you both lean on each other for the rest of the trip back.");
	}
	else {
		outputText("\n\nAfter bringing you to orgasm Kath pulls her arm from your twitching [vagOrAss] and, after cleaning it off in the stream, walks around your body and gives you a hug.  She nibbles gently on one of your nipples and asks, “<i>Did I do a good job?</i>”\n\n");
		
		outputText("You have to laugh.  Here you are, your [vagOrAss] still tingling from the enthusiastic fisting she just gave you and she needs to ask?\n\n");
		
		outputText("You bend down and collect all your clothes and equipment, noticing the bounce in Kath's step as she pulls her clothes back on.  The funny thing is that even though Kath didn't cum she's so happy at having done well that it doesn't seem to matter - or perhaps it's just that the cold water has numbed her needy pussy.\n\n");
	}
	if (!hasAlready(KBIT_TRIED_BATH)) outputText("  In fact she enjoyed this trip so much that you have a feeling these ‘baths’ will become quite popular.");
	player.slimeFeed();
	player.orgasm();
	orgasm();
	player.changeFatigue(15); //Some extra fatigue for dragging your girlfriend's ass halfway home
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	experience(KBIT_TRIED_BATH);
	doNext(camp.returnToCampUseOneHour);
}

private function bathTimeFuckKath():void {
	outputText("\n\nThe sensation causes your " + (hasCock() ? "own " : "") + "cock" + (player.cocks.length > 1 ? "" : "s") + " to prod Kath’s belly" + (hasCock() && player.hasVagina() ? " and you roll your hips so that Kath’s cock sinks into your folds" : "") + ".  " + (hasCock() ? "She purrs and tries to drive her shaft deeper but you have other plans.\n\n" : ""));

	outputText("You turn Kath around and slip your cock between her legs, nestling it between her steaming inner thighs.  She tries to turn back around, but you seize her hips and ");
	if (player.cor < 75)
		outputText("let her know that for now you are going to lead");
	else
		outputText("make it clear that you are the one in charge here");
	outputText(".  Once Kath stops fighting back you turn your attention to her chest.  In this cold water her " + breasts.adj() + " breasts are slippery, firm and topped with hardened nubs.  You tweak her nipples and Kath’s tail wraps itself around " + (player.isNaga() ? "your tail" : "one of your legs") + ", begging for more.\n\n");

	outputText("The cold stream is starting to affect even your lust fueled shaft.  Before you go soft you slide your shaft into Kath’s hot little tunnel.  Immediately your prick springs back to life, your body feeding it a steady supply of hot blood and slippery precum.\n\n");

	outputText("Kath flexes the muscles of her perky ass and wonderful cunt and you enjoy every sensation as your " + catGirl("", "feline "));
	if (player.cor < 25)
		outputText("mate and lover");
	else if (player.cor < 75)
		outputText("partner");
	else
		outputText("fucktoy");
	outputText(" does her best to make you cum using only her love canal.\n\n");

	outputText((player.balls > 0 ? "Your balls have retracted as far as they will go and you decide it’s time.  " : "") + "You take Kath’s hands and place them on her head, lacing her fingers together.  You whisper to her that she has to stay perfectly still.  Then your hands slide down her body, over her soft " + catGirl("skin", "black fur") + ".  In turn you massage tha back of her neck, fondle her breasts and stroke her belly before firmly taking hold of her shapely hips once again.\n\n");

	outputText("Kath mewls and purrs, desperate for you to start fucking her.  You nibble at her ear and begin to slowly stroke in and out of her sex.  The pace isn’t enough to satisfy either of you, but you keep things slow, watching Kath’s knuckles tighten as she tries not to move.\n\n");

	outputText("The muscles inside her vagina do their level best to entice you, but you wait until Kath starts to plead for your cock.  “<i>Please" + (playerMaster() ? " [master]" : "") + " - take me, use me, fuck me!</i>” she moans.  Then she repeats it again and again as if it’s some kind of mantra.\n\n");

	if (player.cor < 25)
		outputText("You smile to yourself.  You’ve already driven your lover to the edge and she hasn’t cum yet.  With luck you’ll give her several orgasms before releasing your seed inside her.");
	else if (player.cor < 75)
		outputText("It’s a lovely sound.  You’re getting close to release yourself and you want Kath to enjoy this as much as you.  You start to time your thrusts with her calls.");
	else
		outputText("You have your slut right where you want her.  Right now she’s willing to do anything for another inch of cock.  You feel another blob of pre squirt from your cock as you dream of all the ways you can take advantage of this submissive bitch.");

	outputText("\n\nWhen you can hold back no longer you start to rut like a wild animal.  The sudden change of pace catches Kath by surprise and you feel her body tense as her first orgasm hits.  Once her legs give out it’s only your hands that hold her hips in place.  You take advantage of that, pulling her against you even faster.  The water provides some cushioning, but it’s still a violent, hard fuck.\n\n");

	outputText("Then you feel it, ");
	if (player.balls == 0)
		outputText("deep inside your body your warped prostate begins contracting");
	else {
		outputText("your ");
		if (player.ballSize >= 18)
			outputText("oversized ");
		else if (player.ballSize >= 12)
			outputText("watermelon-sized ");
		else if (player.ballSize >= 5)
			outputText("cantaloupe-sized ");
		outputText("balls start to retract");
	}
	outputText(" and the first stream of your boiling hot cum forces its way into Katherine’s pussy.  Her sex mantra ends abruptly as she feels your seed filling her.\n\n");

	if (player.cumQ() <= 500)
		outputText("You stand there as your cock fires a few more streams into her pussy.  Kath’s vagina milks you thoroughly and you feel her shudder with a second orgasm.  When it’s over you feel the hot liquid seeping out and warming the stream.");
	else if (player.cumQ() <= 1500)
		outputText("Jet after jet fires into Kath’s waiting pussy.  It leaves you feeling a little weak but Kath seems pleased.  Her body convulses as she cums a second time.  Quite a bit of your sperm must have forced its way deeper, as you can feel her belly expand slightly.");
	else {
		if (player.cumQ() > 3000)
			outputText("Your overproductive " + (player.balls > 0 ? "testes outdo themselves" : "prostate outdoes itself") + ".  ");
		outputText("Your cum launches out of your cock so forcefully that you have to hold Kath’s hips tightly to keep the two of your from being forced apart.  Your cum hammers against Kath’s cervix");
		if (pregSize() > 0)
			outputText(", but with nowhere to go it forces her vagina open and then coats both " + (player.isNaga() ? "her legs and your tail" : "your legs and hers") + " with warm, sticky semen");
		else
			outputText(" and forces it open.  Your hands can feel the flesh on Kath’s hips stretch and pull, trying to provide more skin for her rapidly expanding belly");
		outputText(".  Kath mewls at the feeling of being filled by so much seed." + (player.cumQ() > 3000 ? "  The water grows warm around you and changes color noticeably downstream.  You have to wonder just how much magic is used up each time you cum." : ""));
	}

	outputText("\n\nUntil you get too cold to stay in the water you just stand there, running your hands over Katherine’s ");
	if (pregSize() > 0)
		outputText("pregnant");
	else if (player.cumQ() >= 1500)
		outputText("cum stuffed");
	else
		outputText("taut");
	outputText(" belly and enjoying the sensation of her pussy wrapped around your slowly deflating cock.  Once it’s over you haul Katherine to the shore and she smiles at you contentedly.\n\n");

	outputText("On the long walk back to Tel’Adre she playfully asks when you’re going to take her for another swim.\n\n");
	player.orgasm();
	orgasm();
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	experience(KBIT_TRIED_BATH);
	doNext(camp.returnToCampUseOneHour);
}

private function bathTimeFrustrated():void { //You took away her cock. This is your fault
	clearOutput();
	outputText("Kath hugs you tight and you feel her fingers sliding across your " + (player.hasVagina() ? "clit" : "nipples") + ".  You return the favor, eager to please your lusty cat " + catGirl("girl", "morph") + ".\n\n");
	outputText("The two of you grind your breasts together and your fingers race to see who will jill the other off first.\n\n");
	outputText("Seconds become minutes and there's no end in sight.  You realize that the glacial stream is hindering your efforts.  You're so cold you can barely feel Kath's body pressing against yours.  Her fingers are still rubbing you" + (player.hasVagina() ? "r clit but even that bundle of nerves" : ", but every bit of your skin") + " is growing numb.  Your own hand is starting to cramp up and the only reason you're certain it's still rubbing against her pussy is that her thighs are keeping it in place.\n\n");
	outputText("You look at Kath's face and see that the lust in her eyes has faded - for once - and her lips are starting to turn blue.  From her expression you guess you're in no better shape.\n\n");
	outputText("By the time you drag yourself and Kath out of the frigid water and towel yourselves off any thoughts of lovemaking are pushed aside in favor of warmth.  You wrap your arms around Kath and the two of you shiver until you can sense your fingers and toes once more.\n\n");
	outputText("The sun has moved a decent distance across the sky and you decide that despite the unsatisfying expedition there's nothing for it but to return Kath to Tel'Adre and then head back to camp.\n\n");
	dynStats("lus", 20 + player.lib / 20);
	doNext(camp.returnToCampUseOneHour);
}

private function bathTimePenetrated():void {
	if (!player.hasVagina()) { //Genderless or Male - get this out of the way since it will be a little different
		if (player.hasCock()) {
			outputText("\n\nKath's " + cockMultiple("staff slides", "staves slide") + (player.isNaga() ? " against your scaly behind" : " between your legs") + ", leaving little streaks of precum" + (player.isNaga() ? "." : " on your inner thighs."));
			if (player.balls > 0) outputText("  " + (player.isNaga() ? "Her hands slide down your side and she wraps her fingers around" : "She slides her cock" + cockMultiple("", "s") + " back and forth, rubbing " + cockMultiple("it", "them") + " against") + " your scrotum, teasing you with her sharp " + catGirl("nails", "claws") + " until your cock" + (player.cocks.length > 1 ? "s are" : "is") + " standing fully erect.");
		}
		else
			outputText("\n\nMaddened by the " + (player.isNaga() ? "lack of genitals on your snake half you grind the upper part of your tail against" : "sensations from your flat, nearly featureless crotch you close your legs around") + " Kath’s " + cockMultiple("staff", "staves") + ".");
		outputText("  She purrs deeply and kisses you, then " + (player.isNaga() ? "her hands slide up and down your hips, tickling your scales" : "she shifts her hips, driving her cock" + cockMultiple("", "s") + " between your thighs") + " while her tail whips around your rear, almost as if it’s seeking out your asshole.\n\n");

		outputText("Kath presses herself against you and the feeling of her ");
		if (furry)
			outputText("slick fur rubbing against your " + (player.skinType == SKIN_TYPE_FUR ? "own" : "skin"));
		else
			outputText("wet skin " + (player.skinType == SKIN_TYPE_FUR ? "rubbing against your fur" : "sliding over your body"));
		outputText(" overloads your senses.  " + (player.cor < 75 ? "You close your eyes and lose yourself in the sensual feelings, the icy water forgotten." : "Your ability to fight back drains away and you curse your lack of planning - you’re so aroused that you can’t take advantage of Kath.  In fact she’s the one taking the lead!") + "\n\n");

		outputText("For a while you and Kath just enjoy the feeling of the water lazily drifting past and the slow and steady grinding.  When every part of you seems infused with desire you feel your asshole begin to loosen, your body begging for something to fill your needy hole.\n\n");

		outputText("\n\nThen " + cockMultiple("that lovely hot cock of hers disappears", "those lovely hot cocks of hers disappear") + (player.isNaga() ? ", no longer grinding against your tail" : " from between your legs") + ".  You open your eyes just as Kath wraps her arms around you tightly.  She spoons you and the tip of her " + cockMultiple("", "upper ") + "cock plants itself against your anus.\n\n");

		if (hasDogCock()) {
			outputText("Katherine starts to move her hips and cock" + cockMultiple("", "s") + " in small circular motions.  Gradually your pucker is forced open and finally Kath gets the head inside.  Wasting no time she tightens her grip on you, pulling your body back and forcing " + cockMultiple("her cock", "one of her cocks") + " deep into your colon");
			if (cockNumber > 1) outputText(" while the other continues to grind " + (player.isNaga() ? "against your scales" : "between your legs"));
		}
		else //Feline cock
			outputText("Katherine must have felt you relax.  She presses the narrow tip of her kitty cock against your sphincter.  In one slow stroke she drives it inside you.  You feel every little barb as it tickles the inside of your ass");
			
		outputText(".\n\nYou’re so relaxed and so horny that you don’t realize her whole cock is inside until you feel her partially inflated knot bumping against your cheeks.\n\n");

		outputText("You realize there’s a real danger.  You beg Kath not to knot you out here in the wild - who knows what might find you.  You feel her purr deeply and she thrusts a few times.  She whispers “<i>I’ll try</i>” before she drives her cock into you again.\n\n");

		outputText("Her hands alternate between teasing your hard nipples and stroking " + (player.isNaga() ? "the lower part of your belly" : "your groin") + ".  Sometimes she teases your pisshole with the tip of her finger.  It doesn’t take long before you forget all about the monsters that live in the lake.\n\n");

		outputText("She draws her cock back until only the head remains inside you, then she forces its hot length up your colon again" + cockType("", "its tiny barbs teasing your rectum") + ".  When she takes hold of your hips and yanks back hard you realize that the only reason she isn’t fucking you harder is that with each stroke she needs to push the water out of the way.\n\n");

		outputText("When Kath bottoms out her knot presses against your sphincter and you start to get off on the risk of being tied to your favorite cat " + catGirl("girl", "morph") + " out here.  You can feel her pounding heartbeat through her cock" + cockMultiple("", "s") + " and know she’s about to cum.\n\n");

		outputText("As Katherine’s cock withdraws you give it a little squeeze, trying to hold her inside you a little longer.  She gasps and you feel her legs lock up.  Streams of hot cum fill your rectum, courtesy of Kath’s ");
		if (hasBalls())
			outputText(ballAdj() + ((ballSize <= 3 && cumQ() > 500) ? "but prolific " : "") + "balls");
		else
			outputText("overactive prostate");
		outputText(".  Kath tries to force her knot inside, but your ass is already packed with her cream.\n\n");

		outputText("The throbbing sensation as each load of Kath’s cum forces its way past your sphincter drives you over the edge.");
		if (cumQ() > 500) {
			outputText("  You feel your belly expanding as your intestines stretch to accommodate the load Kath is depositing inside you.");
			if (cumQ() > 1500) outputText("  It’s painful and it seems like it takes forever before you feel Kath’s cum starting to leak out around the sides of her shaft.");
		}
		
		if (player.hasCock()) {
			outputText("\n\n");
			if (player.cumQ() <= 500)
				outputText("Your own cock" + cockMultiple(" fires", "s fire") + " a few streams of your seed into the river." + ((player.cumQ() + 500 < cumQ()) ? "  Compared to Kath’s excessive load your performance seems almost emasculating." : ""));
			else if (player.cumQ() <= 1500)
				outputText("Jet after jet erupts from your own cock" + cockMultiple("", "s") + " into the river.  It leaves you feeling a little weak.");
			else if (player.cumQ() <= 3000)
				outputText("Your cum launches out of your cock" + (player.cocks.length > 1 ? "s" : "") + " so forcefully that " + (player.cocks.length > 1 ? "your cocks bounce back and forth like out of control firehoses." : "your penis bounces back and forth like an out of control firehose."));
			else
				outputText("Your overproductive " + (player.balls > 0 ? "testes outdo themselves" : "prostate outdoes itself") + ".  Without an ass, mouth or vagina to contain " + (player.balls > 0 ? "their deluge they just keep" : "its deluge it just keeps") + " firing and contracting.  Your cock" + (player.cocks.length > 1 ? "s jerk and bounce" : " jerks and bounces") + " so violently that your belly will probably sport some bruises after this.  The water grows warm around you and changes color noticeably downstream.  You have to wonder just how much magic is used up each time you cum.");
		}
		
		outputText("\n\nHer knot presses against your ass but try as she might Kath just can’t force it in.  She cries in frustration, unable to tie herself to her mate.  Exhausted, she lets her arms slip from your hips and rests her head on your shoulder.\n\n");

		outputText("Without a knot to hold it in place Kath’s cock slides free, allowing her copious load to flow from your gaping asshole.  You feel the warmth dissipate as the cloud of cum is slowly washed downstream.  Soon enough it will join with all the other fluids that pollute the lake.\n\n");
	
		outputText("“<i>" + (playerMaster() ? "Thank you [master], I’m sorry if I got a bit carried away" : "Thanks [name], you’re the best") + ",</i>” she purrs.  You drag your sex kitten back to the river bank and gather your clothes in case you need to make a run for it." + (player.hasCock() ? "" : "  Despite your lack of endowments you feel sated.") + "  Kath is so relaxed she might qualify as a liquid");
		if (hasAlready(KBIT_TRIED_BATH))
			outputText(" and you know she'll always be up for another trip to the lake.");
		else
			outputText(", so you suspect these ‘baths’ will always be popular.");
		player.slimeFeed();
		player.orgasm();
		orgasm();
		flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
		experience(KBIT_TRIED_BATH);
		doNext(camp.returnToCampUseOneHour);
	}
	else { //Female or Herm
		outputText("\n\nIn response you roll your hips so that Kath’s " + cockMultiple("", "uppermost ") + " cock sinks into your folds.  She purrs and tries to drive her shaft deeper but you hold her still and smile at her.  You fully intend to take the reigns on this little outing and Kath is going to have to fall in line.\n\n");

		outputText("She gives you big lusty kitten eyes and tries to push again.  A few strokes of your fingers against Katherine’s hot pussy makes her far more cooperative.  She throws her head back and pants.  You wait until her knees lock up, then you take her hips and slowly draw your pussy down her throbbing shaft.\n\n");

		outputText("Now that she’s cooperating you decide it’s time to reward Katherine.  You turn your attention to her chest.  In this cold water her " + breasts.adj() + " breasts are slippery, firm and topped with hardened nubs.  You tweak her nipples and Kath’s tail wraps itself around " + (player.isNaga() ? "your tail" : "one of your legs") + ", begging for more.\n\n");

		if (player.hasCock()) {
			outputText("The cold stream is starting to affect even your lust fueled shaft" + (player.cocks.length > 1 ? "s" : "") + ".  It’s almost as if your body understands that right now your pussy is going to be doing all the work.  Your masculine member" + (player.cocks.length > 1 ? "s flag" : " flags") + " as more and more blood is diverted to the muscles of your love tunnel" + (player.isPregnant() ? "" : ", your estrogen soaked ovaries and the walls of your fertile womb") + ".\n\n");
		}

		outputText("Kath tenses the muscles of her hips and her cock" + cockMultiple(" rocks and shifts", "s rock and shift") + " inside you in a pleasing manner.  In return you run your fingers around the base of " + cockMultiple("her cock", "each of her cocks in turn") + " and then " + (hasBalls() ? "cup her " + ballAdj() + " balls.  Katherine sighs as you roll them between your fingers and gently tug them away from her body." : "slide your index and middle fingers inside her ass.  You find her cum-stuffed prostate and begin to massage the hot bump.  You swear you can almost feel it building up a larger load in response."));

		outputText("Your other hand clasps around " + cockMultiple("Kath’s heavy knot", "the heavy knot Kath has aimed at your pussy") + ".  Out here in the wild you just can’t afford to let her knot you, fun as it might be.  You kiss Kath deeply and start to grind your clit against the top of her knot.  Her tongue dives into your mouth as if it too is desperate to pull you closer.\n\n");

		outputText("With your hand in the way her cock can go no deeper.  You try to make it up to her by flexing your muscles, gently milking her " + cockAdj() + "erection.  Katherine throws her head back and starts to beg.  “<i>Oh please " + playerText() + "!  Please let me go, let me fuck you.  I need to go deeper.</i>”  Her cock" + cockMultiple(" is", "s are") + " throbbing and leaking globs of warm pre into your cunt" + cockMultiple(".", " and the stream."));
		
		if (flags[kFLAGS.KATHERINE_UNLOCKED] >= 4 && (player.cor >= 75 || (player.findPerk(PerkLib.Pervert) >= 0 && player.cor >= 33) || player.findPerk(PerkLib.Sadist) >= 0 || doneSubmissive(KBIT_SUB_ORGASM_DENIAL))) {
			outputText("\n\nYou lick your lips.  Your poor little slut is so horny she can’t even move.  She’s so close to cumming, but she can’t make it there on her own.  You could hold her like this for hours and probably drive her out of her mind.  Or you could pull away and give her a nasty case of blue balls.");
			simpleChoices("Let Her Cum", bathTimePenetratedNormalEnd, "Denial", bathTimePenetratedDenial, "", null, "", null, "", null);
		}
		else doNext(bathTimePenetratedNormalEnd);
	}
}

private function bathTimePenetratedNormalEnd():void {
	clearOutput();
	outputText("You’ve got Kath right on the edge of orgasm.  She can’t move, her legs are locked up and she needs you to help her finish.  You play with her a bit longer, keen to give her more of the wonderful sensations that must be coming from the cock she’s buried in your pussy.\n\n");

	outputText("You look into her dilated and lust filled pupils and decide that it’s time.  Holding your pussy and Katherine’s knot perfectly still you use your hands to make her cum.  You " + (hasBalls() ? "stroke her balls more vigorously than before while your" : "slip another finger inside her ass and start to milk her prostate with more energy than before.  Your") + " other hand rolls her inflated knot" + cockMultiple("", "s") + " from side to side.\n\n");

	outputText("Kath’s eyes roll back and you feel her " + (hasBalls() ? "balls yank upwards" : "prostate jump beneath your fingers") + ".  You press your sex against the front of Kath’s knot, knowing the first load is on the way.\n\n");

	outputText("Your sex kitten doesn’t disappoint.  Your " + (player.isPregnant() ? "cunt" : "cervix") + " is forced open as torrents of cum flow into you, " + (player.isPregnant() ? "rebounding off you sealed cervix and fountaining from your sex" : "filling your womb" + fertileText(" and seeking out your eggs", "")) + cockMultiple(".", ".  Her other dick coats your thighs in spunk as it squirts its seed into the stream.") + "\n\n");

	if (cumQ() <= 500)
		outputText("After a few blasts Kath goes limp in your arms. You");
	else if (cumQ() > 500)
		outputText("Kath goes limp in your arms after filling you with a hefty deposit" + (player.isPregnant() ? "" : " that makes you look like you’re four months pregnant") + ".  You");
	else if (cumQ() > 1500)
		outputText("Kath’s " + (hasBalls() ? "balls just keep" : "prostate just keeps") + " contracting, forcing buckets of sperm into your pussy.  The backflow " + cockMultiple("", "mixes with the stream from her free cock and ") + "warms the water around you" + (player.isPregnant() ? "" : " and your belly is stretched until you look seven months pregnant.  As the last of her load is forced inside your belly button pops out") + ".  With the eruption over, you");
	else if (cumQ() > 3000)
		outputText("You have to hold on to Kath to keep from being forced off by her high pressure cum.  " + (player.isPregnant() ? "" : "Kath’s huge load seems to fill your womb in an instant.  Then it expands your belly still further, forcing the air from your lungs.  In moments you look nine months pregnant and your belly button has become a hard nub that rubs against the " + catGirl("skin", "fur") + " of Katherine’s belly.  ") + "An amazing amount of Kath’s seed spills from your pussy" + cockMultiple("", ", mixing with the stream from her free cock") + ".  It doesn’t just warm the stream around you but makes it feel slightly sticky and colors the water downstream.  With the eruption over, you");
	outputText(" carry your spent " + (player.cor < 75 ? "girlfriend" : "fucktoy") + " to the shore and wait for her to recover.\n\n");

	if (player.hasCock())
		outputText("It's only when you flop onto the sandy ground that you realize your cock" + (player.cocks.length > 1 ? "s" : "") + " never fired a shot.  The icy water and lack of stimulation resulted in only your female half cumming.  You " + (player.balls > 0 ? "feel your balls.  Although they're" : "insert a finger and massage your prostate.  Although it's") + " still filled with cum you feel no particular desire to get off.  How strange.  Perhaps in future you'll find some way to take advantage of this weird situation.  ");
	outputText("Katherine purrs and hugs you close, asking, “<i>Did you like it?  Did it feel great for you too?</i>”\n\n");

	outputText("You assure her it was good for you too" + (player.hasCock() ? ", despite the fact you didn't cum" : "") + ", then you both get dressed and head back to Tel’Adre.");

	if (!hasAlready(KBIT_TRIED_BATH))
		outputText("  It looks like Kath enjoyed her bath, so you suspect if you ever ask her to come out to the lake she'll jump at the chance.");
	player.slimeFeed();
	dynStats("lus", 10 + player.lib / 20);
	orgasm();
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	experience(KBIT_TRIED_BATH);
	doNext(camp.returnToCampUseOneHour);
}

private function bathTimePenetratedDenial():void {
	clearOutput();
	outputText("With your fingers you slowly and carefully squeeze the cock inside you just beyond its knot.  You can feel her " + (hasBalls() ? "balls twitching, but they don’t fire" : "prostate twitching, but it doesn’t fire") + ".\n\n");

	outputText("You start to draw away from Kath, allowing her cock to slide out of your cunt and into the cold water.  She mewls and begs “<i>I’m sooo close.  Please" + (playerMaster() ? "[master]" : "") + "!</i>”\n\n");

	outputText("You have to laugh.  It’s such a beautiful sight.  Your lover is desperate, you hold the key to her ecstasy and she’s about to realize you aren’t planning to use it.\n\n");

	outputText("“<i>Please, please, please,</i>” is all she can say.  Through " + (hasBalls() ? "your hand you can feel her balls descending again" : "your fingers you can feel the muscles around her prostate softening") + ".  The glacial stream is doing its work quickly.  Her knot" + cockMultiple(" recedes", "s recede") + " and her cock" + cockMultiple(" starts", "s start") + " to shrivel.  Kath crosses her legs and clutches her " + (hasBalls() ? "balls" : "crotch") + ", rubbing desperately to try and make the pain of her aborted orgasm go away.\n\n");

	outputText("You take her by the shoulders and tell her that you’ve decided she has to wait.  But not to worry, sometime soon you’ll let her know she can cum.  You want her to build up a nice big load for you.\n\n");

	outputText("You drag Kath out of the stream and then ‘help’ her by " + (hasBalls() ? "rolling her " + ballAdj() + " balls around with your hands.  You think they’re a little heavier than they were before.  You keep rubbing" : "slipping your fingers back inside her ass.  You think her prostate has become slightly heavier than it was before.  You keep massaging it") + " until she starts to develop another " + cockMultiple("erection", "pair of erections") + ", then you stop.  Kath slams her fist into the ground in frustration and whimpers.\n\n");

	outputText("You hold her down until she’s got her lust under control, then you both get dressed and head back to Tel’Adre.  Only when the gates of the city are in view do you " + clothesLowerChoice("pull down her pants", "reach under her skirt", "slide your hand inside her bodysuit and free her cock" + cockMultiple("", "s"), "reach under her dress", "slip a hand inside her robe and free her cock" + cockMultiple("", "s")) + ".  You grab Katherine’s waist with your other hand and start " + cockMultiple("stroking her cock", "alternately stroking her cocks") + " furiously.\n\n");

	outputText("She whines and pants at the unexpected attention.  In seconds her cock" + cockMultiple(" is", "s are") + " rock hard.  You whisper in her ear that now she can cum for you.  Kath’s knees lock up again and you point her cock" + cockMultiple("", "s") + " at the desert sands.  ");
	if (cumQ() <= 500)
		outputText("After a few blasts Kath goes limp in your arms.  When she’s done there’s a small puddle of sandy cum a few foot in front of her.");
	else if (cumQ() <= 1500)
		outputText("Kath goes limp in your arms but her cock" + cockMultiple("", "s") + " continue to discharge their overdue payload.  Numerous shots of cum splatter the ground ahead, producing a large cum puddle.");
	else if (cumQ() <= 3000)
		outputText("Kath’s " + (hasBalls() ? "balls just keep contracting" : "prostate seems to produce an unending supply") + ", launching buckets of sperm onto the dry desert sand.  By the time she’s finished the cum has formed a pool on the sand, a pool that’s slowly sliding towards lower ground.");
	else
		outputText("Katherine’s sperm just keeps flowing from her cockhead" + cockMultiple(" in one continuous stream", "s in two continuous streams") + ".  You could probably have got her a job with Tel’Adre’s fire department, no training required.  When she finally finishes there’s a river of cum flowing across the dry sand.");

	outputText("\n\nYou have to carry her the rest of the way, but when you reach the gates Katherine gives you a kiss and tells you she wants you to come and see her soon.  You grin and shake your head - this girl is insatiable.\n\n");
	dynStats("lus", 10 + player.lib / 20);
	orgasm();
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	experience(KBIT_TRIED_BATH);
	addSubmissive(KBIT_SUB_ORGASM_DENIAL);
	doNext(camp.returnToCampUseOneHour);
}

private function bedroomBondage():void {
	//If this is the first time then the player needs to have at least 40 gems to buy stuff (10g per scarf)
	clearOutput();
	if (doneSubmissive(KBIT_SUB_BED_BOND)) {
		outputText("You walk over to Katherine’s wardrobe and soon find what you’re looking for.  You take the silk scarves in hand and walk back to Kath.  She’s got a big grin on her face and as you approach she turns her back to you, walking away so slowly you’re sure to catch up.\n\n");

		outputText("When you grab her and lock her arm behind her back she pretends to struggle and improvises a little roleplay, saying, “<i>" + clothesChoice("Hey!  I know I was making eyes at you back at the bar, but what kind of girl do you think I am?", "Please - I’m just a dancer, I work in the club down the street!", "Oh no, a ruffian!  Please don’t hurt me, I’m just coming home from the ball.", "I’m warning you - I’m a sorceress from the academy and if you don’t let go I’m going to use my magics on you.", "Hey!  I know I was making eyes at you back at the bar, but what kind of girl do you think I am?", "No, please!  I work down at the hospital, I take care of people!") + "</i>”  You laugh as you tie up your compliant pussy - it seems she likes this little game.\n\n");
	}
	else {
		outputText("You give Katherine a quick kiss and tell her to wait here, you have an idea.  You race through Tel’Adre’s streets, searching for one of the many vendors of sex toys and other items for the bedroom.\n\n");

		outputText("Not far from Kath’s you find a shop with what you need.  You pick out some silk scarves, quickly pay the merchant and make your way back to Kath’s.  She’s sitting on the edge of the bed, but springs to her feet as you return.\n\n");
		player.gems -= 40;

		outputText("“<i>What’s up " + playerText() + "?</i>” she asks, her ears swivelling toward you.\n\n");

		outputText("Rather than answering you walk up to her, spin her around and lock her arms behind her.\n\n");

		outputText("“<i>Oh!  " + playerText() + " - what are you doing?</i>”\n\n");

		outputText("You start tying her wrists together with one of the silk scarves.  Kath wriggles, but she’s not really trying to escape.  Her tail is flicking back and forth, smacking against your " + (player.isNaga() ? "tail" : "legs") + ", so she’s definitely excited.\n\n");
	}

	outputText("You push her onto the bed and flip her on her back" + clothesLowerChoice(".  It doesn’t take much effort to pull her pants and panties off", ", flip up her skirt and remove her panties", ", your fingers quickly locating the concealed slit in the crotch of her bodysuit", ", flip up her skirt and remove her panties", ", open the lower portion of her robe and relieve Kath of her panties") + ".  She keeps struggling playfully but you’ve soon tied her legs to opposite sides of the bedframe.  If she weren’t a cat " + catGirl("girl", "morph") + " doing the splits like this would be mildly uncomfortable.  Katherine obviously doesn’t mind and you can feel the heat radiating " + catGirl("from her skin", "through her fur") + " as she grows flushed with excitement.  At last you untie her wrists just long enough to re-tie them to the head of the bed.\n\n");

	outputText("You take a moment to appreciate what lies before you.  Katherine is spread - eagled on the bed, her legs and hips naked" + (hasCock() ? ", her hard cock" + cockMultiple("", "s") + " aimed at the ceiling" : "") + " and her pussy wet and glistening.  " + clothesChoice("Inside her blouse", "Through her sheer bodysuit", "Beneath the embroidery of her elegant dress", "Inside the folds of her silken robe", "Concealed only by her tight tube top", "Concealed only by the skimpy white nurse’s top") + " you can see her chest rising and falling, her nipples poking against the fabric.  ");
	if (doneSubmissive(KBIT_SUB_BED_BOND)) {
		outputText("You grin at Kath as she pretends to struggle.  You know this is one of her favorite bedroom games.\n\n");

		outputText("Keeping to her character Kath pants, “<i>" + clothesChoice("Just cause I brought you home doesn’t mean I put out on the first date.  You seem like a nice " + player.mf("guy", "girl") + ", let’s talk about this, huh?", "I just shake my ass for money " + player.mf("mister", "miss") + ".  I’m not really that much of a slut.  Please let me go, I’ll... I’ll give you free tickets to my next show!", "No, no, no.  I wanted to meet a " + player.mf("gentleman", "lady") + ".  A ruffian like you, you just can’t be my first!", "Don’t do this - I could teach you a spell to get off, I could pay for someone else to sleep with you, just don’t - uh - fuck me.", "Just cause I brought you home doesn’t mean I put out on the first date. You seem like a nice " + player.mf("guy", "girl") + ", let’s talk about this, huh?", "I know people say if you can’t get a date get a nurse, but they still expect you to ask me out.  I’m a really naughty nurse but I do expect a little romance.") + "</i>”\n\n");
	}
	else outputText("If Kath doesn’t already have a fetish for getting tied up like this you plan to give her one.\n\n");

	outputText("You laugh and blow on her " + (hasCock() ? "cock" + cockMultiple("", "s") : "clit") + ", causing Kath to strain against her bonds.  You tell her that she should consider her position.  She’s bound hand and foot to her own bed and only you can help her reach orgasm.  You take her tail and start gently stroking the underside.  Kath rolls her hips and purrs.  Then you stop, moving to stroke her still covered breasts and give her a kiss.  You ask her how it feels, being completely at your mercy.\n\n");

	if (doneSubmissive(KBIT_SUB_BED_BOND))
		outputText("“<i>" + clothesChoice("Oh " + player.mf("mister", "miss") + " - that feels good.  I never sleep with someone on the first date but I think I’ll make an exception for you.", "OK, OK!  " + (player.hasCock() && pregSize() == 0 ? "Just don’t knock me up.  I’ve still got to be able to spin around that pole or I’ll lose my job." : "I get so horny spinning around that pole - maybe you can help me let off some steam." + (pregSize() == 0 ? "  Just don’t let any guys fuck me, Kay?" : "")), "Let me go!  I was born to sleep with " + player.mf("lords and gentlemen", "baronesses and ladies") + ".  There is no way a dirty ruffian like you - hah! - can make me feel this good.", "It’s not fair, my magic just doesn’t work when I’m this horny.  I suppose I have no choice, I am at your mercy.  So please help me get off.  There won’t be any reprisals if you make it good for me.", "Oh " + player.mf("mister", "miss") + " - that feels good.  I never sleep with someone on the first date but I think I’ll make an exception for you.", "Mmmm, you’ve got me.  Okay hot stuff, let’s see if you’re as good at ‘digital exams’ as I am.") + "</i>”");
	else outputText("Kath just sighs.  Her pupils are fully dilated and you doubt you’re going to hear anything coherent from her until this is over.");

	outputText("\n\nAt first you barely touch her " + (hasCock() ? "cock" + cockMultiple("", "s") + " or " : "") + "pussy.  Instead you tease her by stroking her breasts and running your hands over her belly and thighs.  Kath wriggles in place and the bedframe creaks but the silk scarves are strong enough to hold her.\n\n");

	outputText("When you finally get back to blowing on her " + (hasCock() ? "cock" + cockMultiple("", "s") : "clit") + " Kath starts to beg for more.  You stop everything and sit next to her on the bed.  You stroke her ear and tell her that she’s broken your concentration - you can't even remember what you were doing just now.  Kath whimpers and bites her tongue.  After giving her another quick kiss you start over.\n\n");

	outputText("This time it’s even harder for Kath.  When you start blowing on her " + (hasCock() ? "cock" + cockMultiple("", "s") + " you see precum oozing from the tip" + cockMultiple("", "s") : "clit you see femcum oozing from her pussy") + " like a fountain.  " + (hasCock() ? "You could take her pulse by watching her knot" + cockMultiple("", "s") + " expanding and contracting.  " : "") + "Katherine must love being tied up - she’s so close to cumming that when you start massaging " + (hasCock() ? "the base of her knot" + cockMultiple(" it inflates and hardens", "s they inflate and harden") : "her inner labia her legs start to shiver") + " almost immediately.\n\n");

	outputText("You slow your pace once again and whisper in Katherine’s ear that you aren’t going to play with her " + (hasCock() ? "cock" + cockMultiple("", "s") + (hasBalls() ? ", her balls" : "") + " or her " : "") + "pussy.  You’re going to prove how much she loves this by making her cum some other way.  She whimpers and you see tears forming at the corners of her eyes.\n\n");

	outputText("You go back to her ears and start teasing them with your fingers.  " + (hasCock() ? "With every heartbeat her cock" + cockMultiple("", "s") + " jump but she doesn’t cum" : "Each time she takes a breath you hear her pussy dripping juice onto the sheets") + ".  You switch to rubbing her nipples and Kath lets out a deep moan.");
	if (breasts.lactating())
		outputText("  In no time " + clothesChoice("her blouse", "the upper part of her bodysuit", "the bodice of her dress", "the upper part of her robe", "her tube top", "her nurse's top") + "is soaked with rich, sugary cream and");
	else outputText("  By now");
	outputText(" her " + (hasCock() ? "cock" + cockMultiple(" is", "s are") : "pussy is") + " glazed from top to bottom with a thick coat of " + (hasCock() ? "pre" : "fem") + "cum." + (hasCock() ? "  " + cockMultiple("It continues to leak like a lazy volcano", "They continue to leak like lazy volcanoes") : "") + ".\n\n");

	outputText("If her ears won’t do it and her breasts don’t cut it there’s one part of Kath’s body you know will set her off.  You take her tail and start to stroke it.  When you rub the muscles near the base Kath’s hips launch upwards and you hear a " + (hasCock() ? "sound like a bucket of water being poured onto a wood floor.  The stream" + cockMultiple(" she fires is so powerful it hits the ceiling and spatters", "s she fires are so powerful they hit the ceiling and spatter") + " all over the place like a cum sprinkler system" : "scream that starts at high pitched before passing out of the range of human hearing") + ".\n\n");

	outputText((hasCock() ? "It takes several more shots to drain Katherine’s " + (hasBalls() ? ballAdj() + " balls" : "unnatural prostate") + ".  When it’s over the whole apartment is soaked in cum" : "Kath goes through several more orgasms before she's drained of energy.  When it's over the bedsheets are drenched") + " and Kath is panting and laughing like a crazy person.  " + (hasCock() ? "Her body, directly beneath the rain of cum dripping from the ceiling, is coated head to toe.  " : "") + "When she recovers enough to be sensible she looks over at you and says ");
	if (doneSubmissive(KBIT_SUB_BED_BOND))
		outputText("“<i>" + clothesChoice("Oh baby!  No one’s ever made me cum like that.  Just give me a few minutes to recover.  I want to pay you back, you’re a keeper.", "That was great.  You want a job?  Cause if I add this to my act I’ll get a lot more gems every show.", "You win, you rapscallion.  You made your point, you’ve forced me to cum.  If you untie me now all will be forgiven.  I must admit you have some skill in the art of lovemaking.", "I did promise no reprisals if you made me feel good, didn’t I?  I guess you got what you wanted.  Now let me go, I have to get cleaned up for tomorrow.", "Oh baby!  No one’s ever made me cum like that.  Just give me a few minutes to recover.  I want to pay you back, you’re a keeper.", "Too bad it’s over.  Ever thought of going professional?  You come to the hospital, we give you a cute little outfit like this.  There are a lot of patients, doctors and nurses who could use some relief.") + "</i>”");
	else
		outputText("“<i>Oh " + playerText()  + ", that was amazing.  I’m so... spent.  Let me up and I’ll try to find the strength to do something for you.</i>”");

	var x:int = player.cockThatFits(70);
	if (player.hasCock() && x > -1) { //Males and herms (with small enough junk to fit)
		var pcLen:int = player.cocks[x].cockLength;
		outputText("  You sit down astride Kath and ask her why she thinks you’re going to stop?  You’ve only just warmed her up.  Now she’s ready for the main course.  Her eyes go wide and she pulls at the scarves but there’s no escape.\n\n");
		
		outputText("You position yourself on the bed and line " + (player.cocks.length > 1 ? "up one of your dicks" : "your cock") + " with Kath’s slit.  " + (hasCock() ? "Her cum is still dripping on your back when you push inside her.  " : "") + "She’s incredibly wet and her pussy opens itself before you, " + (hasCock() ? "almost like it’s jealous of the treatment her male side received" : "begging for more even though she's shaking her head") + ".\n\n");

		outputText("Unlike Katherine you haven’t cum yet and your cocks are aching for release.  You stroke her ");
		if (pregSize() == 0) {
			outputText("flat tummy and ask her where she wants your seed.\n\n");
			if (doneSubmissive(KBIT_SUB_BED_BOND))
				outputText("“<i>" + clothesChoice("That’s what you wanted all along, isn’t it?  You want to knock up a dumb slut you found at the bar.  Well I can’t stop you, so do your best stud!", "Fuck!  You’ll ruin everything.  Everyone at the club is gonna see my big fat belly and I’ll wind up serving drinks 'til I pop.  But since I can’t stop you I’m gonna enjoy this.", "Oh no!  You’re going to fuck a bastard into me.  Oh, my life is going to be over, why does this have to feel so good?", "Mmmm, I guess my class is going to learn firsthand about pregnancy and babies.  Come on then, put a little apprentice inside me!", "That’s what you wanted all along, isn’t it?  You want to knock up a dumb slut you found at the bar.  Well I can’t stop you, so do your best stud!", "Oh yes!  All the girls at the hospital will be soooo jealous.  I can’t wait for all the doctors to start fighting over my pregnant cunt.  Unless you want to have me?  Every day, every night - I don’t care, just give me more of this!") + "</i>”");
			else outputText("“<i>Oh yes!  Fuck me!  Cum inside me, please!  I need it so bad,</i>” she whines.");
		}
		else { //Is pregnant
			outputText("pregnant belly and ask her if she does this often.\n\n");

			outputText("Her hips buck and some drool runs from the corner of her mouth.  ");
			if (doneSubmissive(KBIT_SUB_BED_BOND))
				outputText("“<i>" + clothesChoice("You know I do stud.  I love getting knocked up and parading my big belly around town.  I’m sure not going to bars for the drinks right now.  Mommy", "No, no.  This was an accident.  I have to stay fit for my job at the club.  But since I’m huge anyway please pump some more cum inside me.  Maybe it’ll help with the stretch marks.  Mommy", "Ugh!  This is a noble baby growing in my womb, but why am I wishing it was yours?  Oh, I hope my child learns to fuck like you do and not like his father.  Please don’t stop, mommy", "Yes, I do.  It’s my duty to produce more adepts for the tower.  You must find me when my womb is empty, I would like to carry your child.  Now fill me, mommy", "You know I do stud.  I love getting knocked up and parading my big belly around town.  I’m sure not going to bars for the drinks right now.  Mommy", "Mmmm, the doctors and the male nurses don’t let us go very long without a bun in the oven.  Hot little teases like me get fertility shots to make whole litters of new nurses!  Don’t you dare stop before you fill me, mommy") + " needs so much cum!</i>”");
			else outputText("“<i>Oh " + playerText()  + ", don’t stop now.  I need that cum.  I need your hot love inside me.</i>”");
		}
		outputText("  With your feline lover so wet and ready you waste no time and start to hammer into her hot cunt.  Kath goes wild and even tied up she does everything she can to try and force a little more of your cock inside.\n\n");

		outputText("You force it as deep as you can, " + (pcLen < 15 ? "trying to make it as good for her as it is for you" : "rubbing the tip against Kath’s cervix and causing her eyes to roll back in her skull") + ".  When you cum ");
		if (player.cumQ() <= 500)
			outputText("you feel a small pool of sperm form around the tip of your cock." + (pregSize() == 0 ? "  You’re sure you can feel Kath’s cervix sucking some of it in." : ""));
		else if (player.cumQ() <= 1500)
			outputText("your sperm streams from your cock and starts to pool inside Katherine.  " + (pregSize() == 0 ? "Her belly starts to swell and you give her formerly flat belly a little rub while Kath purrs." : "With her cervix blocking the way forward most of your cum bubbles back out of Kath’s pussy."));
		else if (player.cumQ() <= 3000) {
			outputText("your seed flows into Kath like a river.  ");
			if (pregSize() == 0) {
				outputText("Her cervix is forced open ");
				if (pcLen < 15)
					outputText("and the pressure around your cock lessens as your seed flows unimpeded into her womb");
				else
					outputText("and you sink into her a bit further as the " + (pcLen == 15 ? "tip" : "first " + (pcLen - 15) + " inches") + " of your cock slide into her womb");
				outputText(".  Kath’s belly grows larger and larger, taking all the cum you can give her until she looks five months pregnant and her belly button pops out, signaling that she can hold no more");
			}
			else outputText("Since her womb is already filled with a child it’s her vagina that takes the brunt of it.  Before your eyes a small hard bulge forms just above her cock" + cockMultiple("", "s") + " as the upper end of her birth canal is forced wide open by the flood from your " + (player.balls > 0 ? "balls" : "prostate"));
			outputText(".  The rest of your cum flows back around your cock, pouring out onto the bed.");
		}
		else {
			outputText("your " + (player.balls > 0 ? "overactive balls" : "unnatural prostate") + ", fueled by the strange magic of this world, inject" + (player.balls > 0 ? "" : "s") + " an impossible amount of sperm into your cat " + catGirl("girl", "morph") + " lover.  The breath is forced from Kath’s lungs and ");
			if (pregSize() == 0) {
				outputText("in an instant her cervix is forced open.  ");
				if (pcLen < 15)
					outputText("The pressure around your cock lessens as your seed flows unimpeded into her womb");
				else outputText("You sink into her a bit further as the " + (pcLen == 15 ? "tip" : "first " + (pcLen - 15) + " inches") + " of your cock slide into her womb");
				outputText(".  Kath’s belly grows larger and larger, taking in all the cum you can give her and growing by leaps and bounds.  She soon looks five or six months pregnant and her belly button pops out.  But your cum " + (player.balls > 0 ? "factories aren't" : "factory isn't") + " done.\n\n");

				outputText("Your " + (player.balls > 0 ? "balls fire" : "prostate fires") + " even higher pressure blasts, overcoming all resistance from Kath’s tortured belly and inflating her taut tummy until she looks nine months pregnant.   ");
				if (player.cor < 25)
					outputText("You hope you aren’t doing any permanent damage to Katherine with such a big load.");
				else if (player.cor < 75)
					outputText("You hope Kath is enjoying this as much as you are.");
				else
					outputText("Secretly you want to see just how far you can stretch out your kitty’s belly.  Even more, you want to see if you can get her addicted to the feeling of being overfilled.");

				outputText("\n\nKath whimpers, but her tail is wagging.  You’re pretty sure she’s enjoying herself - and if not, well she can’t do anything about it anyway.");
			}
			else
				outputText("the top of her birth canal balloons under the strain.  Somehow her cervix remains closed, protecting her offspring.  It feels like you stuck your cock in a waterfall.  There’s a powerful stream of cum blasting backward and hitting your groin hard enough that it almost forces you to pull out.");
		}

		outputText("\n\nWhen it’s over you collapse on top of your cat " + catGirl("girl", "morph") + " lover.  You feel completely spent and you enjoy the feeling of your sperm leaking slowly from inside her body.\n\n");

		outputText("As you lie there you " + (hasCock() ? "realize there’s a " + cockMultiple(" hot, hard bulge", "pair of hot, hard bulges") + " between the two of you.  " : "notice that Kath's nippes are rock hard once again") + "It looks like Kath enjoyed herself so much that she " + (hasCock() ? "wants round two" : "needs to cum again") + ".  You don’t want to disappoint so you roll off her and start to " + (hasCock() ? "stroke her cock" + cockMultiple(" and her knot", "s and knots") : "massage her throbbing clit") + ".\n\n");

		outputText("Kath realizes what you’re up to and starts to beg weakly - “<i>I don’t know if I can.  Let me rest for a minute, please.</i>”\n\n");

		if (player.cor < 25)
			outputText("You consider it, but you know Kath will end up loving it." + (doneSubmissive(KBIT_SUB_BED_BOND) ? "" : "  She’s obviously turned on from being tied up, from letting you take control.") + "  You give her a smile and continue to stroke her gently");
		else if (player.cor < 75)
			outputText("Of course she can.  And she’ll love it.  You’re about to prove that to her");
		else outputText("How does she think this works?  She’s tied to the bed, you’ve got her " + (hasCock() ? "cock" + cockMultiple("", "s") + " in hand" : "clit between your fingers") + ".  If you want her to cum then she’s going to cum!  You stop just long enough to give Kath a wicked smile and then you start to " + (hasCock() ? "jerk her cock" + cockMultiple("", "s") : "work her clit") + " in earnest");
		outputText(".  Kath moans and tries to escape but her tail sweeps from side to side, showing you she couldn’t be happier.  When her hips launch off the bed you " + (hasCock() ? "aim her cock" + cockMultiple("", "s") + " at the ceiling and once again she gets coated in a shower of her own cum" : "lean in and give her a long deep kiss") + ".\n\n");

		outputText("After that marathon Katherine is so tired that within a minute or two she starts to snore.  You gently untie her arms from the bed without waking her.  Cats need their naps after all.  She looks so content that you leave her soaking in a puddle of her own cum and let yourself out.");
	}
	else if (!hasCock()) { //She has no cock and you either don't have one or it's too big
		outputText("You stroke her hair and tell her not to worry.  You had lots of fun tying her up.  Kath laughs and says she can't wait to try this again, anytime you want.  Still, after that marathon Katherine is so tired that within a minute or two she starts to snore.  You gently untie her arms from the bed without waking her.  Cats need their naps after all.  She looks so content that you leave her be and let yourself out.");
	}
	else { //Female, Genderless or your cock is too big
		var dPen:Boolean = player.hasVagina() && cockNumber > 1;
		outputText("  You sit down astride Kath and ask her why she thinks you’re going to stop?  You’ve only just warmed her up.  Now she’s ready for the main course.  Her eyes go wide and she pulls at the scarves but there’s no escape.\n\n");
		
		outputText("You position yourself above Katherine and slowly lower your " + (player.hasVagina() ? "pussy" : "ass") + " onto her " + (dPen ? "upper shaft.  A moment later you feel her lower shaft start to force its way into your ass" : "shaft") + ".  Kath mewls as her oversensitive cock" + (dPen ? "s disappear into your holes" : " disappears into your cunt") + ".\n\n");

		if (doneSubmissive(KBIT_SUB_BED_BOND))
			outputText("“<i>" + clothesChoice("Oh " + player.mf("mister", "miss") + ", I’m never going to have to pick up at that bar again.  It’s love at first fuck but please, no more.", "No!  I can’t do it again!  I’ll dance for you all the time but don’t do this or I won’t be able to walk straight for a week.", "Ugh, untie me rogue!  I already admitted I enjoyed this - how much more must I suffer?  My rod" + cockMultiple("", "s") + " will not remain stiff for you long.", "Twice?  No " + player.mf("mister", "miss") + ", please - we can meet again, I would like that, but I have a class to teach in the morning.", "Oh " + player.mf("mister", "miss") + ", I’m never going to have to pick up at that bar again.  It’s love at first fuck but please, no more.", "I’m really tired, could we maybe have round two tomorrow?  Please, pretty please?  I’m a medical professional and I can tell you cocks aren’t supposed to cum again so soon.") + "</i>”");
		else outputText("“<i>" + playerText() + ", please don’t.  Not so soon.  I can’t cum anymore.  Just let me recover or my " + (hasBalls() ? "balls are" : "prostate is") + " going to turn inside out.</i>”");

		outputText("\n\nYou put an end to her babbling by kissing her while you allow your " + (dPen ? "holes to swallow her cocks" : (player.hasVagina() ? "pussy" : "rectum") + " to swallow up her cock") + ".  Kath’s hips weakly try to push more inside, but her hot and solid knot" + (dPen ? "s prevent" : " prevents") + " it.\n\n");

		outputText("You rock forward and back, enjoying the feeling of Katherine’s " + (dPen ? "staves grinding against one another inside you" : "staff probing your depths") + ".  Your hands roam over Kath’s breasts, the sperm soaked " + clothesChoice("blouse", "bodysuit", "dress", "robe", "tube top", "nurse’s uniform") + " doing little to conceal her " + breasts.adj() + " mounds.\n\n");

		outputText("Kath soon forgets her complaints and starts trying to move beneath you.  Although it’s difficult you pull yourself off her shaft" + (dPen ? "s" : "") + " and remind her that you and only you are going to decide when she gets to cum.  Kath lets out the most needy moan you’ve ever heard, but when you lower yourself again you find her hips have locked in place.\n\n");

		outputText("You’re starting to feel that familiar throbbing as you rock against Katherine’s knot" + (dPen ? "s" : "") + " and you decide it’s time to make this kitty blow her load.  Reaching underneath her cock you first rub your palm gently against her pussy.  Then you " + (hasBalls() ? "slide your hand upwards and take hold of her " + ballAdj() + " balls.  They’re" : "push your fingers past her sphincter and start to massage her prostate.  It’s") + " boiling hot - probably working overtime to rebuild Kath’s supplies of sperm.\n\n");

		outputText("As your fingers expertly massage her sperm " + (hasBalls() ? "factories" : "factory") + " you innocently ask, “<i>You said you couldn’t cum again.  Does it still feel that way, or was I right after all?</i>”  Kath seems to be lost in a dream world, so you try something else and yell out a command: “<i>Kath - CUM!</i>”\n\n");

		outputText("At that her body stiffens and her " + (hasBalls() ? "balls try to pull toward her body" : "prostate contracts") + ".  You decide to make things a little more intense and you " + (hasBalls() ? "hold her balls in place" : "pinch one end of her prostate") + ", making it harder for her to pump out her latest load.  Kath’s head starts thrashing from side to side and you feel her " + (hasBalls() ? "balls'" : "prostate’s") + " contractions go into overdrive as she fights for the chance to fill you.\n\n");

		orgasm(); //Kath has already cum once, so reduce her load to the minimum amount.
		outputText("Your belly starts to swell with Kath’s red hot seed but since she’s already emptied her " + (hasBalls() ? "balls" : "prostate") + " once tonight you don’t end up as completely stuffed as usual.  Kath gasps and pants like a fish out of water and with the last of your strength you untie her and press her hands to your " + (cumQ() > 500 ? "swollen " : "") + "belly.\n\n");

		outputText("“<i>It’s so hot,</i>” she says.  As she rubs your belly Kath mumbles, “<i>I must have just made all this.  You’re full of my fresh, hot cum.</i>”  You kiss her and tell her you really enjoy the feeling.  If there’s ever a chilly night you’ll have to remember this trick for keeping warm.\n\n");

		outputText("Katherine giggles and pulls you into a hug.  She’s so tired that within a minute or two she starts to snore.  She looks so content that you leave her soaking in a puddle of her own cum and let yourself out.");
		player.slimeFeed();
	}
	player.orgasm();
	orgasm();
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	addSubmissive(KBIT_SUB_BED_BOND);
	doNext(camp.returnToCampUseOneHour);
}

private function drunkFuck():void {
	outputText("The waitress brings over one last drink and Kath slams it back in one shot.  She’s got an obvious " + clothesLowerChoice("tent in her pants", "bulge under her skirt", "bulge in the crotch of her bodysuit", "bulge under her dress", "bulge inside her robe") + " and she gives you a crooked smile as she gets up.\n\n");

	outputText("You take her hand, but instead of heading for the alley as you expected Kath pulls you toward one of the empty backrooms.  She’s so excited she's practically skipping.  You get inside, lock the door and Kath pounces you.  She uses the very techniques you " + (flags[kFLAGS.KATHERINE_TRAINING] == 1 ? "and Urta " : "") + "taught her to pin your arm behind your back while she relieves you of your clothes, all the while giggling to herself.\n\n");

	outputText("Once you’re naked she " + (player.hasVagina() ? "starts roughly playing with your clit" : "jabs a finger and then two inside your ass") + ".  She’s not gentle, aiming only to get you hotter and hotter.  Kath leans in close and whispers, “<i>It’s my turn now.  You wanted me - so for now I’m callin the shots.</i>”  She ");
	if (player.hasVagina())
		outputText("keeps attacking your clit until you feel your juices running down your leg");
	else if (player.hasCock())
		outputText("keeps milking your prostate until you feel like you’re about to cum");
	else
		outputText("gets her whole hand inside your ass and rolls it around, knowing how much it takes to drive a genderless lover to distraction");

	outputText(".\n\nOnly when you’re having trouble even standing does Kath release your arm");
 	if (!player.hasVagina()) outputText(" and yank her " + (player.hasCock() ? "fingers" : "fist") + " from your ass");
	outputText(", and that’s just so she can " + clothesLowerChoice("undo her pants", "raise her skirt", "pull open the hidden slit in her bodysuit", "raise her dress", "open her robe") + ", pull aside her panties and grab your hips with both hands.  Just a moment later your ");
	var dPen:Boolean = cockNumber > 1 && player.hasVagina();
	if (dPen)
		outputText("cunt and ass get");
	else if (player.hasVagina())
		outputText("cunt gets");
	else outputText("ass gets");
	outputText(" split wide open as Kath pulls you back onto her shaft" + (dPen ? "s, burying herself to the hilt in both your holes" : ", burying herself to the hilt") + ".\n\n");

	outputText("You’ve never seen Kath acting this aggressive!  She doesn’t say anything; she concentrates entirely on dominating your ");
	if (dPen)
		outputText("pussy and your ass, making them");
	else if (player.hasVagina())
		outputText("pussy, making it");
	else outputText("ass, making it");
	outputText(" hers.  She bangs you against the door hard enough that everyone in the bar must know what’s going on in here.  ");
	if (player.hasCock())
		outputText("The constant battering overcomes you and " + (player.cocks.length > 1 ? "your cocks start" : "your cock starts") + " to spray, coating the door " + (player.cumQ() > 1000 ? "and then the floor " : "") + "with your sticky semen");
	else if (player.hasVagina())
		outputText("All that thrusting " + (player.isPregnant() && player.pregnancyIncubation < 100 ? "along with the bouncing of your huge belly " : "") + "overcomes you and the walls of your pussy " + (dPen ? "and ass " : "") + "clamp down on Kath’s spear");
	else outputText("All the nerves in your rectum start to fire and your sphincter spasms furiously, trying to expel the invader");
	
	outputText(".\n\nKath laughs like a madwoman and starts to hammer you even harder.  You feel her swollen knot" + (dPen ? "s" : "") + " fighting against your spasming passage" + (dPen ? "s, trying to force their" : ", trying to force its") + " way inside.  Katherine lets out a yowl and pulls back with all her strength.  Her knot" + (dPen ? "s, already near their final size, smash through your defenses, your muscles unable to hold them" : ", already near its final size, smashes through your defenses, your muscles unable to hold it") + " at bay.  At last Kath stops moving.  She must be enjoying the feeling as your ");
	if (dPen)
		outputText("pussy and rectum ripple");
	else if (player.hasVagina())
		outputText("pussy ripples");
	else outputText("ass ripples");
	outputText(" along the length of her shaft" + (dPen ? "s" : "") + ".\n\n");

	outputText("In a whisper so quiet you almost miss it Kath says, “<i>My turn!</i>”  Your knees buckle as your kitten’s cock" + (dPen ? "s discharge" : " discharges") + " a tidal wave of spooge into your ");
	if (player.hasVagina())
		outputText((player.isPregnant() ? "pussy" : "vacant womb") + (dPen ? " and colon" : ""));
	else outputText("colon");
	outputText((!dPen && cockNumber > 1) ? ".  Her other member, nestled between your thighs, spurts a stream of seed onto the floorboards" : "");
	outputText(".  After several long, hard blasts your belly has swollen up as Kath’s turbocharged " + (hasBalls() ? "testicles do their" : "prostate does its") + " best to change you into a balloon.  When she’s spent Kath falls backwards, dragging you with her.  You wind up " + (player.isTaur() ? "with your belly on the ground, all four legs splayed out," : "sitting in Kath’s lap") + " still feeling her heartbeat through the veins of her knot" + (dPen ? "s" : "") + ".\n\n");

	outputText("From behind you come a worried voice.  “<i>I’m sorry " + playerText() + ", I really went out of control there.  I shouldn’t have, but you got me so drunk and horny... anyway, I’m sorry.</i>”\n\n");

	if (player.cor < 25)
		outputText("You know it was your fault.  You look over your shoulder and smile, telling Kath that it’s all right, you wanted to enjoy yourself and you did.  She beams at the praise.");
	else if (player.cor < 75)
		outputText("You’d have a much easier time being mad or punishing your cat " + catGirl("girl", "morph") + " if that hadn’t been so enjoyable.");
	else
		outputText("It was fucking good.  It’s been a while since you got dominated like that and it’s so unlike Kath.  Secretly you wonder if you could get her to do this again, but out loud you tell her that you’re going to come up with some appropriate punishment for this.  Kath just nods her head.  Apparently fading alcohol and the orgasm have turned her back to her usual submissive self.");

	outputText("\n\nWhen the knot" + (dPen ? "s finally come" : " finally comes") + " free you get up, get dressed and walk out into the bar.  Several patrons, many sporting erections, give you applause.  Kath, still lying on the floor in a puddle of cum, tries to shrink down to nothing.  Even though she’s almost fully clothed she pulls a broken chair in front of her to try and hide from the bar.\n\n");

	if (player.cor < 25)
		outputText("You blow Kath a kiss, resulting in a few more cat calls.  Then you close the door mouthing ‘later’ to her.  She nods and starts to collect herself, happy to be out of the public eye right now.");
	else if (player.cor < 75)
		outputText("You take a bow and blow Kath a kiss.  The other patrons love it and you prop the door wide open so that Kath will be embarrassed long after you leave.");
	else {
		outputText("You give Katherine an evil grin and stride back into the room.  The other patrons watch, some stroking their erections or slipping fingers into their pussies.  “<i>" + playerText() + " - what are you doing?</i>” she asks, quite worried.  You pull her up in front of you and stand behind her, much as she stood behind you moments ago." + (player.hasCock() ? "  Your partially deflated cock rubs against her backside, but that’s not what she should be worried about." : ""));

		outputText("You put your arms under hers and " + clothesChoice("start to unbutton her blouse, exposing her bra", "begin to play with her breasts right through her sheer bodysuit.  Her nipples harden and stick out of the stretchy fabric", "pull down the front of her ballroom dress, exposing her bra", "pull the top of her robe open, exposing her bra", "lift her tube top up, exposing her bra", "undo the few buttons on the sexy nurse’s top, exposing her bra") + (breasts.milkIsFull() ? ".  You feel her creamy goodness leaking out and see a few grins and surprised expressions among the crowd" : "") + ".\n\n");

		outputText("Kath goes stiff in your arms, transfixed by all the stares from the bar patrons.  Meanwhile you start rolling her breasts around in your hands, enjoying your lover’s titflesh and embarrassment.  You say, “<i>Sorry Kath, I should have done this earlier - I completely neglected your lovely breasts.</i>”\n\n");

		outputText("“<i>No, no, no,</i>” she squeaks out.  ");
		if (submissiveness() < 6) {
			outputText("After a few minutes of playing with her you finally let Kath go.  There’s a definite feeling of disappointment from the bar, but you don’t think you could get Kath to do something in front of other people.  Maybe someday you’ll have her so enthralled that she’ll do it.\n\n");

			outputText("You give her a quick kiss and leave the bar, whistling.");
		}
		else {
			outputText("You ignore her of course.  " + (doneSubmissive(KBIT_SUB_PUBLIC_EXHIBITION) ? "You know your pet loves it when you force her to do things." : "It’s time for Kath to learn a new trick.  You’ve always thought her body could please a crowd, but after today’s behavior you’ve decided to prove it!"));

			outputText("\n\nYou step back and tell Kath this won’t do at all.  She pants and reaches to readjust her clothes.  Then you tell her, “<i>These people just applauded your performance Kath.  They expect an encore.</i>”  She freezes in place and then you tell her, “<i>They can’t get a good view with all those clothes in the way... you’re going to have to strip.</i>”\n\n");

			outputText("That gets some hoots and hollers from the crowd and you see a few patrons kicking off their pants or skirts in preparation for the show.  Katherine shudders but knows better than to argue when you use that tone of voice.  She starts to quickly take off her clothes until you tell her to stop.\n\n");

			outputText("She looks back, perhaps wondering if you’re about to tell her you were just kidding.  Instead you explain, “<i>Give them a show, strip like you’re doing this for money.</i>”\n\n");

			outputText("Kath gulps but turns back to the crowd and " + clothesChoice("starts unbuttoning her blouse slowly", "starts unlacing her bodysuit", "starts unlacing her long dress", "starts untying the knot of her robe", "starts running her fingers under the bottom edge of her tube top", "pulls the front of her nurse’s top open again") + ".  The crowd loves it and Kath, perhaps feeling a little bold thanks to the booze still in her system, starts to get into it and starts to sway back and forth, her cat-like flexibility allowing her hips to move through a hypnotic pattern that silences the crowd." + (isValaAtBar() ? "  You even see a certain faerie waitress paused mid-flight with a tray of drinks.  You see her eyes following every move that Kath’s hips make." : ""));

			outputText("\n\nYou have to smile watching Katherine dancing in front of all these people.  This is something she would never have done before you met her.  As her hips gyrate Kath " + clothesChoice("pulls off her blouse and starts to play with her breasts.  After a few cheers and cries of “<i>More!</i>” she removes the bra as well", "pulls her shoulders out of the unlaced top of her bodysuit.  Without missing a beat she gets her arms free and pushes the silky fabric down until the bodysuit covers only her legs, ass and belly", "finishes unlacing the dress and pulls her arms free, letting the top of the dress fall away.  She starts to play with her breasts and after a few cheers and cries of “<i>More!</i>” she removes the bra as well", "undoes the knot and opens the front of her robe, giving the audience a lovely view of her bra and panties", "pulls the tube top over her head and starts to play with her breasts.  After a few cheers and cries of “<i>More!</i>” she removes the bra as well", "slips out of the nurse’s top and starts to play with her breasts.  After a few cheers and cries of “<i>More!</i>” she removes the bra as well") + ".\n\n");

			outputText("With every eye in the place locked on her body Kath lets out a sexy purr " + clothesChoice(", loosens her skirt and slowly slides it over her hips.  She poses before kicking off her panties, leaving herself totally naked in front of the crowd", "and works the bodysuit down over her hips, leaving herself totally naked in front of the crowd", "and wiggles her body, working herself out of the dress and leaving herself totally naked in front of the crowd", "and allows the spider silk robe to slide off her shoulders and drop to the ground.  With a twirl she pulls off her bra and slides off her panties, leaving herself totally naked in front of the crowd", clothesLowerChoice("and slides the skintight shorts down her legs.  Her panties soon follow, ", ", loosens her skirt and slowly slides it over her hips.  She poses before kicking off her panties,", "", "", "") + " leaving herself totally naked in front of the crowd", "and unfastens the sexy nurse’s skirt, letting it drop to the floor.  She poses for the crowd, naked save for the little white nurse’s cap resting on her head") + ".\n\n");

			outputText("With Katherine nude and distracted you sneak up behind her and grab " + cockMultiple("her cock with both hands", "both her cocks") + ".  She lets out a surprised meow as you fondle her member" + (hasBalls() ? ", her balls" : "") + " and her dripping pussy.\n\n");

			outputText("The crowd starts to cheer as you smear Kath’s cock" + cockMultiple("", "s") + " with her own pussy juice.");
			if (isValaAtBar())
				outputText("   You notice Vala has put down her tray.  One of her hands is under her skirt and she has a zoned out happy look on her face as she watches you molest your " + catGirl("cat girl.", "feline lover."));
			outputText("  Katherine starts playing with her own breasts and grins at her audience" + (breasts.lactating() ? ".  Every time she gives them a little squeeze some cream leaks out and dribbles down her front.  She" : ".  Then she") + " closes her eyes and leans back against you, losing herself in the feeling of her fingers and yours as they pleasure the most sensitive areas of her body.\n\n");

			outputText("Having cum recently Kath is able to put on quite the show.  Even with your hands working her shaft" + cockMultiple("", "s") + " and occasionally dipping into her cunt it still takes minutes before you feel " + cockMultiple("that knot", "those knots") + " of hers firming up.  Kath’s hips jerk forward and you aim " + cockMultiple("her shaft toward the ceiling.  When Kath cums a thick stream of semen under high pressure blasts from the tip of her cock, striking the wall above the door and raining down in thick, heavy droplets", "her upper cock to the left and her lower cock to the right.  When Kath cums twin streams of semen under high pressure blast from the tips of her cocks - one striking the wall on the left of the door, one striking the wall on the right") + ".  The whole bar applauds as Katherine unloads.  As the final squirts bubble from her member" + cockMultiple("", "s") + " Kath falls to her knees and her tongue hangs from the side of her mouth.\n\n");

			outputText("You’re sure everyone in the bar appreciated that show but you don’t intend to leave a naked and near comatose Katherine in their hands.  You step out of the room and tell Kath you’ll see her later.  She makes a happy gurgling noise that you assume was an “<i>Okay!</i>” and then you close the door, making sure to slam it so the locking bar drops down on the inside.\n\n");

			outputText("You stride out of the bar" + (isValaAtBar() ? ", pausing only to pull Vala into your arms to quickly kiss her and grope her ass. She sighs, winks and tells you to come back later. You" : " and") + " head for home, knowing you’ve " + (doneSubmissive(KBIT_SUB_PUBLIC_EXHIBITION) ? "once again helped Kath see how much fun showing off can be." : "opened Kath up to some new possibilities."));
			addSubmissive(KBIT_SUB_PUBLIC_EXHIBITION);
		}
	}
	player.slimeFeed();
	player.orgasm();
	orgasm();
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	doNext(camp.returnToCampUseOneHour);
}

//Leave 'dese
	}
}


