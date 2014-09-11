package classes 
{
import classes.Scenes.Places.TelAdre.UmasShop;

/**
	 * Character class for player and NPCs. Has subclasses Player and NonPlayer.
	 * @author Yoffy
	 */
	public class Character extends Creature 
	{
		private var _femininity:Number = 50;

		// This is the easiest way I could think of to apply "flat" bonuses to certain stats without having to write a whole shitload of crazyshit
		// I think a better long-term solution may be to hang function references off the end of the statusAffect class and move all of the value
		// calculation into methods of ContentClasses, so rather than having walls of logic, we just call the method reference with a value, and get back the modified value.
		// It's still shitty, but it would possibly be an improvement.
		public function get femininity():Number
		{
			var fem:Number = _femininity;
			var statIndex:int = this.findStatusAffect(StatusAffects.UmasMassage);

			if (statIndex >= 0)
			{
				if (this.statusAffect(statIndex).value1 == UmasShop.MASSAGE_MODELLING_BONUS)
				{
					fem += this.statusAffect(statIndex).value2;
				}
			}
			
			if (fem > 100)
			{
				fem = 100;
			}
			
			return fem;
		}
		
		public function set femininity(value:Number):void
		{
			if (value > 100)
			{
				value = 100;
			}
			else if (value < 0)
			{
				value = 0;
			}
			
			_femininity = value;
		}

		//BEARDS! Not used anywhere right now but WHO WANTS A BEARD?
		public var beardLength:Number = 0;
		public var beardStyle:Number = 0;
		
		//Used for hip ratings
		public var thickness:Number = 0;
		
		//Body tone i.e. Lithe, stocky, etc
		public var tone:Number = 0;
		
		//Pregancy types. Both butt and normal.
		public const PREGNANCY_IMP:int                   =   1;
		public const PREGNANCY_MINOTAUR:int              =   2;
		public const PREGNANCY_MOUSE:int                 =   4;
		public const PREGNANCY_OVIELIXIR_EGGS:int        =   5; //Also caused by Phoenixes apparently
		public const PREGNANCY_HELL_HOUND:int            =   6;
		public const PREGNANCY_CENTAUR:int               =   7;
		public const PREGNANCY_MARBLE:int                =   8;
		public const PREGNANCY_BUNNY:int                 =   9;
		public const PREGNANCY_ANEMONE:int               =  10;
		public const PREGNANCY_AMILY:int                 =  11;
		public const PREGNANCY_IZMA:int                  =  12;
		public const PREGNANCY_SPIDER:int                =  13;
		public const PREGNANCY_BASILISK:int              =  14;
		public const PREGNANCY_DRIDER:int                =  15;
		public const PREGNANCY_GOO_GIRL:int              =  16;
		public const PREGNANCY_EMBER:int                 =  17;
		public const PREGNANCY_BENOIT:int                =  18;
		public const PREGNANCY_SATYR:int                 =  19;
		public const PREGNANCY_COTTON:int                =  20;
		public const PREGNANCY_URTA:int                  =  21;
		public const PREGNANCY_SAND_WITCH:int            =  22;
		public const PREGNANCY_FROG_GIRL:int             =  23;
		public const PREGNANCY_FAERIE:int                =  24; //Indicates you are carrying either a phouka or faerie baby. Which one is determined by the PREGNANCY_CORRUPTION flag

		public const PREGNANCY_BUTT_BEE:int              =   2;
		public const PREGNANCY_BUTT_DRIDER:int           =   3;
		public const PREGNANCY_BUTT_SANDTRAP_FERTILE:int =   4;
		public const PREGNANCY_BUTT_SANDTRAP:int         =   5; //Sandtrap did not have fertilized eggs

		public const INCUBATION_IMP:int                  = 432; //Time for standard imps. Imp lords, Ceraph, Lilium and the imp horde cause slightly faster pregnancies
		public const INCUBATION_MINOTAUR:int             = 432;
		public const INCUBATION_MOUSE:int                = 350;
		public const INCUBATION_OVIELIXIR_EGGS:int       =  50;
		public const INCUBATION_HELL_HOUND:int           = 352;
		public const INCUBATION_CENTAUR:int              = 420;
		public const INCUBATION_MARBLE:int               = 368;
		public const INCUBATION_BUNNY_BABY:int           = 200;
		public const INCUBATION_BUNNY_EGGS:int           = 808; //High time indicates neon egg pregnancy
		public const INCUBATION_ANEMONE:int              = 256;
		public const INCUBATION_IZMA:int                 = 300;
		public const INCUBATION_SPIDER:int               = 400;
		public const INCUBATION_BASILISK:int             = 250;
		public const INCUBATION_DRIDER:int               = 400;
		public const INCUBATION_GOO_GIRL:int             =  85;
		public const INCUBATION_EMBER:int                = 336;
		public const INCUBATION_SATYR:int                = 160;
		public const INCUBATION_COTTON:int               = 350;
		public const INCUBATION_URTA:int                 = 515;
		public const INCUBATION_SAND_WITCH:int           = 360;
		public const INCUBATION_FROG_GIRL:int            =  30;
		public const INCUBATION_FAERIE:int               = 200;
		
		public const INCUBATION_BUTT_BEE:int             =  48;
		public const INCUBATION_BUTT_DRIDER:int          = 200;
		public const INCUBATION_BUTT_SANDTRAP:int        =  42;

		public var pregnancyType:Number = 0;
		public var pregnancyIncubation:Number = 0;
		
		//2 = bee
		public var buttPregnancyType:Number = 0;
		public var buttPregnancyIncubation:Number = 0;
		
		//Key items
		public var keyItems:Array;
		
		public function Character()
		{
			keyItems = [];
		}
		
		//Return bonus fertility

		//return total fertility

		public function faceDesc():String
		{
			var faceo:String = "";
			//0-10
			if (femininity < 10)
			{
				faceo = "a square chin";
				if (!hasBeard())
					faceo += " and chiseled jawline";
				else
					faceo += ", chiseled jawline, and " + beard();
			}
			//10+ -20
			else if (femininity < 20)
			{
				faceo = "a rugged looking " + face() + " ";
				if (hasBeard())
					faceo += "and " + beard();
				faceo += "that's surely handsome";
			}
			//21-28
			else if (femininity < 28)
				faceo = "a well-defined jawline and a fairly masculine profile";
			//28+-35 
			else if (femininity < 35)
				faceo = "a somewhat masculine, angular jawline";
			//35-45
			else if (femininity < 45)
				faceo = "the barest hint of masculinity on its features";
			//45-55
			else if (femininity <= 55)
				faceo = "an androgynous set of features that would look normal on a male or female";
			//55+-65
			else if (femininity <= 65)
				faceo = "a tiny touch of femininity to it, with gentle curves";
			//65+-72
			else if (femininity <= 72)
				faceo = "a nice set of cheekbones and lips that have the barest hint of pout";
			//72+-80
			else if (femininity <= 80)
				faceo = "a beautiful, feminine shapeliness that's sure to draw the attention of males";
			//81-90
			else if (femininity <= 90)
				faceo = "a gorgeous profile with full lips, a button nose, and noticeable eyelashes";
			//91-100
			else
				faceo = "a jaw-droppingly feminine shape with full, pouting lips, an adorable nose, and long, beautiful eyelashes";
			return faceo;
		}
		
		//Modify femininity!
		public function modFem(goal:Number, strength:Number = 1):String
		{
			var output:String = "";
			var old:String = faceDesc();
			var oldN:Number = femininity;
			var Changed:Boolean = false;
			//If already perfect!
			if (goal == femininity)
				return "";
			//If turning MANLYMAN
			if (goal < femininity && goal <= 50)
			{
				femininity -= strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (femininity < goal)
					femininity = goal;
				Changed = true;
			}
			//if turning GIRLGIRLY, like duh!
			if (goal > femininity && goal >= 50)
			{
				femininity += strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (femininity > goal)
					femininity = goal;
				Changed = true;
			}
			//Fix if it went out of bounds!
			if (findPerk(PerkLib.Androgyny) < 0)
				fixFemininity();
			//Abort if nothing changed!
			if (!Changed)
				return "";
			//See if a change happened!
			if (old != faceDesc())
			{
				//Gain fem?
				if (goal > oldN)
					output = "\n\n<b>Your facial features soften as your body becomes more feminine. (+" + strength + ")</b>";
				if (goal < oldN)
					output = "\n\n<b>Your facial features harden as your body becomes more masculine. (+" + strength + ")</b>";
			}
			//Barely noticable change!
			else
			{
				if (goal > oldN)
					output = "\n\nThere's a tingling in your " + face() + " as it changes imperceptibly towards being more feminine. (+" + strength + ")";
				else if (goal < oldN)
					output = "\n\nThere's a tingling in your " + face() + " as it changes imperciptibly towards being more masculine. (+" + strength + ")";
			}
			return output;
		}
		
		public function modThickness(goal:Number, strength:Number = 1):String
		{
			if (goal == thickness)
				return "";
			//Lose weight fatty!
			if (goal < thickness && goal < 50)
			{
				thickness -= strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (thickness < goal)
					thickness = goal;
			}
			//Sup tubby!
			if (goal > thickness && goal > 50)
			{
				thickness += strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (thickness > goal)
					thickness = goal;
			}
			trace("MOD THICKNESS FIRE");
			//DIsplay 'U GOT FAT'
			if (goal >= thickness && goal >= 50)
				return "\n\nYour center of balance changes a little bit as your body noticeably widens. (+" + strength + " body thickness)";
			//GET THIN BITCH
			else if (goal <= thickness && goal <= 50)
				return "\n\nEach movement feels a tiny bit easier than the last.  Did you just lose a little weight!? (+" + strength + " thin)";
			return "";
		}
		
		public function modTone(goal:Number, strength:Number = 1):String
		{
			if (goal == tone)
				return "";
			//Lose muscle visibility!
			if (goal < tone && goal < 50)
			{
				tone -= strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (tone < goal)
				{
					tone = goal;
					return "\n\nYou've lost some tone, but can't lose any more this way. (-" + strength + " muscle tone)";
				}
			}
			//MOAR hulkness
			if (goal > tone && goal > 50)
			{
				tone += strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (tone > goal)
				{
					tone = goal;
					return "\n\nYou've gained some muscle tone, but can't gain any more this way. (+" + strength + " muscle tone)";
				}
			}
			//DIsplay BITCH I WORK OUT
			if (goal >= tone && goal > 50)
				return "\n\nYour body feels a little more solid as you move, and your muscles look slightly more visible. (+" + strength + " muscle tone)";
			//Display DERP I HAVE GIRL MUSCLES
			else if (goal <= tone && goal < 50)
				return "\n\nMoving brings with it a little more jiggle than you're used to.  You don't seem to have gained weight, but your muscles look less visible. (-" + strength + " muscle tone)";
			return "";
		}
		
		//Run this every hour to 'fix' femininity.
		public function fixFemininity():String
		{
			var output:String = "";
			//Genderless/herms share the same bounds
			if (gender == 0 || gender == 3)
			{
				if (femininity < 20)
				{
					output += "\n<b>Your incredibly masculine, chiseled features become a little bit softer from your body's changing hormones.";
					if (hasBeard())
					{
						output += "  As if that wasn't bad enough, your " + beard() + " falls out too!";
						beardLength = 0;
						beardStyle = 0;
					}
					output += "</b>\n";
					femininity = 20;
				}
				else if (femininity > 85)
				{
					output += "\n<b>You find your overly feminine face loses a little bit of its former female beauty due to your body's changing hormones.</b>\n";
					femininity = 85;
				}
			}
			//GURLS!
			else if (gender == 2)
			{
				if (femininity < 30)
				{
					output += "\n<b>Your incredibly masculine, chiseled features become a little bit softer from your body's changing hormones.";
					if (hasBeard())
					{
						output += "  As if that wasn't bad enough, your " + beard() + " falls out too!";
						beardLength = 0;
						beardStyle = 0;
					}
					output += "</b>\n";
					femininity = 30;
				}
			}
			//BOIZ!
			else if (gender == 1)
			{
				if (femininity > 70)
				{
					output += "\n<b>You find your overly feminine face loses a little bit of its former female beauty due to your body's changing hormones.</b>\n";
					femininity = 70;
				}
				if (femininity > 40 && hasBeard())
				{
					output += "\n<b>Your beard falls out, leaving you with " + faceDesc() + ".</b>\n";
					beardLength = 0;
					beardStyle = 0;
				}
			}
			if (gender != 1 && hasBeard())
			{
				output += "\n<b>Your beard falls out, leaving you with " + faceDesc() + ".</b>\n";
				beardLength = 0;
				beardStyle = 0;
			}
			return output;
		}
		
		public function hasBeard():Boolean
		{
			return beardLength > 0;
		}
		
		public function beard():String
		{
			if (hasBeard())
				return "beard";
			else
			{
				//CoC_Settings.error("");
				return "ERROR: NO BEARD! <b>YOU ARE NOT A VIKING AND SHOULD TELL FEN IMMEDIATELY.</b>";
			}
		}
		
		public function skin(noAdj:Boolean = false, noTone:Boolean = false):String
		{
			var skinzilla:String = "";
			//Only show stuff other than skinDesc if justSkin is false
			if (!noAdj)
			{
				//Adjectives first!
				if (skinAdj != "")
				{
					skinzilla += skinAdj;
					if (noTone)
						skinzilla += " ";
					else
						skinzilla += ", ";
				}
			}
			if (!noTone)
				skinzilla += skinTone + " ";
			//Fur handled a little differently since it uses
			//haircolor
			if (skinType == 1)
				skinzilla += "skin";
			else
				skinzilla += skinDesc;
			return skinzilla;
		}
		
		public function hasMuzzle():Boolean
		{
			if (faceType == 1 || faceType == 2 || faceType == 6 || faceType == 7 || faceType == 9 || faceType == 11 || faceType == 12)
				return true;
			return false;
		}
		
		public function face():String
		{
			var stringo:String = "";
			//0 - human
			//5 - Human w/Naga fangz
			//8 - bunnah faceahhh bunbun
			//10 - spidah-face (humanish)
			if (faceType == 0)
				return "face";
			//1 - horse
			//2 - dogface
			//6 - kittah face
			//9 - kangaface
			if (faceType == 9 || faceType == 6 || faceType == 2 || faceType == 1 || faceType == 11)
			{
				if (int(Math.random() * 2) == 0)
					return "muzzle";
				if (int(Math.random() * 3) == 0 && faceType == 1)
					stringo = "long ";
				if (int(Math.random() * 3) == 0 && faceType == 6)
					stringo = "feline ";
				return stringo + "face";
			}
			//3 - cowface
			if (faceType == 3)
			{
				if (Math.floor(Math.random() * 4) == 0)
					stringo = "bovine ";
				if (int(Math.random() * 2) == 0)
					return "muzzle";
				return stringo + "face";
			}
			//4 - sharkface-teeth
			if (faceType == 4)
			{
				if (Math.floor(Math.random() * 4) == 0)
					stringo = "angular ";
				return stringo + "face";
			}
			//7 - lizard face (durned argonians!)
			if (faceType == 7 || faceType == 12)
			{
				if (Math.floor(Math.random() * 4) == 0)
					stringo = "reptilian ";
				if (Math.floor(Math.random() * 4) == 0)
					return stringo + "muzzle";
				if (Math.floor(Math.random() * 4) == 0)
					return stringo + "snout";
				return stringo + "face";
			}
			return "face";
		}
		
		public function hasLongTail():Boolean
		{
			//7 - shark tail!
			//8 - catTAIIIIIL
			//9 - lizard tail
			//10 - bunbuntail
			//11 - harpybutt
			//12 - rootail
			//13 - foxtail
			//14 - dagron tail
			if (isNaga())
				return true;
			if (tailType == 2 || tailType == 3 || tailType == 4 || tailType == 7 || tailType == 8 || tailType == 9 || tailType == 12 || tailType == 13 || tailType == 14)
				return true;
			return false;
		}

		public function isPregnant():Boolean {
			return pregnancyIncubation != 0;

		}
		//fertility must be >= random(0-beat)
		public function knockUp(type:int = 0, incubation:int = 0, beat:int = 100, arg:int = 0):void
		{
			//Contraceptives cancel!
			if (findStatusAffect(StatusAffects.Contraceptives) >= 0 && arg < 1)
				return;
			if (findStatusAffect(StatusAffects.GooStuffed) >= 0)
				return;
			var bonus:int = 0;
			//If arg = 1 (always pregnant), bonus = 9000
			if (arg >= 1)
				bonus = 9000;
			if (arg <= -1)
				bonus = -9000;
			//If unpregnant and fertility wins out:
			if ((arg == 2 || (pregnancyIncubation == 0)) && totalFertility() + bonus > Math.floor(Math.random() * beat) && hasVagina())
			{
				pregnancyType = type;
				pregnancyIncubation = incubation;
				trace("PC Knocked up with pregnancy type: " + type + " for " + incubation + " incubation.");
			}
			//Chance for eggs fertilization - ovi elixir and imps excluded!
			if (type != 1 && type != 5 && type != 10)
			{
				if (findPerk(PerkLib.SpiderOvipositor) >= 0 || findPerk(PerkLib.BeeOvipositor) >= 0)
				{
					if (totalFertility() + bonus > Math.floor(Math.random() * beat))
					{
						fertilizeEggs();
					}
				}
			}
		}
		
		//fertility must be >= random(0-beat)
		public function buttKnockUp(type:int = 0, incubation:int = 0, beat:int = 100, arg:int = 0):void
		{
			//Contraceptives cancel!
			if (findStatusAffect(StatusAffects.Contraceptives) >= 0 && arg < 1)
				return;
			var bonus:int = 0;
			//If arg = 1 (always pregnant), bonus = 9000
			if (arg >= 1)
				bonus = 9000;
			if (arg <= -1)
				bonus = -9000;
			//If unpregnant and fertility wins out:
			if ((arg == 2 || (buttPregnancyIncubation == 0)) && totalFertility() + bonus > Math.floor(Math.random() * beat))
			{
				buttPregnancyType = type;
				buttPregnancyIncubation = incubation;
				trace("PC Knocked up with pregnancy type: " + type + " for " + incubation + " incubation.");
			}
		}

		//Create a keyItem
		public function createKeyItem(keyName:String, value1:Number, value2:Number, value3:Number, value4:Number):void
		{
			var newKeyItem:* = new KeyItemClass();
			//used to denote that the array has already had its new spot pushed on.
			var arrayed:Boolean = false;
			//used to store where the array goes
			var keySlot:Number = 0;
			var counter:Number = 0;
			//Start the array if its the first bit
			if (keyItems.length == 0)
			{
				//trace("New Key Item Started Array! " + keyName);
				keyItems.push(newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//If it belongs at the end, push it on
			if (keyItems[keyItems.length - 1].keyName < keyName && !arrayed)
			{
				//trace("New Key Item Belongs at the end!! " + keyName);
				keyItems.push(newKeyItem);
				arrayed = true;
				keySlot = keyItems.length - 1;
			}
			//If it belongs in the beginning, splice it in
			if (keyItems[0].keyName > keyName && !arrayed)
			{
				//trace("New Key Item Belongs at the beginning! " + keyName);
				keyItems.splice(0, 0, newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//Find the spot it needs to go in and splice it in.
			if (!arrayed)
			{
				//trace("New Key Item using alphabetizer! " + keyName);
				counter = keyItems.length;
				while (counter > 0 && !arrayed)
				{
					counter--;
					//If the current slot is later than new key
					if (keyItems[counter].keyName > keyName)
					{
						//If the earlier slot is earlier than new key && a real spot
						if (counter - 1 >= 0)
						{
							//If the earlier slot is earlier slot in!
							if (keyItems[counter - 1].keyName <= keyName)
							{
								arrayed = true;
								keyItems.splice(counter, 0, newKeyItem);
								keySlot = counter;
							}
						}
						//If the item after 0 slot is later put here!
						else
						{
							//If the next slot is later we are go
							if (keyItems[counter].keyName <= keyName)
							{
								arrayed = true;
								keyItems.splice(counter, 0, newKeyItem);
								keySlot = counter;
							}
						}
					}
				}
			}
			//Fallback
			if (!arrayed)
			{
				//trace("New Key Item Belongs at the end!! " + keyName);
				keyItems.push(newKeyItem);
				keySlot = keyItems.length - 1;
			}
			
			keyItems[keySlot].keyName = keyName;
			keyItems[keySlot].value1 = value1;
			keyItems[keySlot].value2 = value2;
			keyItems[keySlot].value3 = value3;
			keyItems[keySlot].value4 = value4;
			//trace("NEW KEYITEM FOR PLAYER in slot " + keySlot + ": " + keyItems[keySlot].keyName);
		}
		
		//Remove a key item
		public function removeKeyItem(itemName:String):void
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				//trace("ERROR: KeyItem could not be removed because player has no key items.");
				return;
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == itemName)
				{
					keyItems.splice(counter, 1);
					trace("Attempted to remove \"" + itemName + "\" keyItem.");
					counter = 0;
				}
			}
		}
		
		public function addKeyValue(statusName:String, statusValueNum:Number = 1, newNum:Number = 0):void
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return;
					//trace("ERROR: Looking for keyitem '" + statusName + "' to change value " + statusValueNum + ", and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				//Find it, change it, quit out
				if (keyItems[counter].keyName == statusName)
				{
					if (statusValueNum < 1 || statusValueNum > 4)
					{
						//trace("ERROR: AddKeyValue called with invalid key value number.");
						return;
					}
					if (statusValueNum == 1)
						keyItems[counter].value1 += newNum;
					if (statusValueNum == 2)
						keyItems[counter].value2 += newNum;
					if (statusValueNum == 3)
						keyItems[counter].value3 += newNum;
					if (statusValueNum == 4)
						keyItems[counter].value4 += newNum;
					return;
				}
			}
			//trace("ERROR: Looking for keyitem '" + statusName + "' to change value " + statusValueNum + ", and player does not have the key item.");
		}
		
		public function keyItemv1(statusName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == statusName)
					return keyItems[counter].value1;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function keyItemv2(statusName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == statusName)
					return keyItems[counter].value2;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function keyItemv3(statusName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == statusName)
					return keyItems[counter].value3;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function keyItemv4(statusName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == statusName)
					return keyItems[counter].value4;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function removeKeyItems():void
		{
			var counter:Number = keyItems.length;
			while (counter > 0)
			{
				counter--;
				keyItems.splice(counter, 1);
			}
		}
		
		public function hasKeyItem(keyName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
				return -2;
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == keyName)
					return counter;
			}
			return -1;
		}
		
		//Grow

		//BreastCup

		/*OLD AND UNUSED
		   public function breastCupS(rowNum:Number):String {
		   if(breastRows[rowNum].breastRating < 1) return "tiny";
		   else if(breastRows[rowNum].breastRating < 2) return "A";
		   else if(breastRows[rowNum].breastRating < 3) return "B";
		   else if(breastRows[rowNum].breastRating < 4) return "C";
		   else if(breastRows[rowNum].breastRating < 5) return "D";
		   else if(breastRows[rowNum].breastRating < 6) return "DD";
		   else if(breastRows[rowNum].breastRating < 7) return "E";
		   else if(breastRows[rowNum].breastRating < 8) return "F";
		   else if(breastRows[rowNum].breastRating < 9) return "G";
		   else if(breastRows[rowNum].breastRating < 10) return "GG";
		   else if(breastRows[rowNum].breastRating < 11) return "H";
		   else if(breastRows[rowNum].breastRating < 12) return "HH";
		   else if(breastRows[rowNum].breastRating < 13) return "HHH";
		   return "massive custom-made";
		 }*/
		public function viridianChange():Boolean
		{
			var count:int = cockTotal();
			if (count == 0)
				return false;
			while (count > 0)
			{
				count--;
				if (cocks[count].sock == "amaranthine" && cocks[count].cockType != CockTypesEnum.DISPLACER)
					return true;
			}
			return false;
		}
		
		public function hasSheath():Boolean
		{
			return dogCocks() > 0 || horseCocks() > 0 || catCocks() > 0 || kangaCocks() > 0 || displacerCocks() > 0;

		}
		
		public function hasKnot(arg:int = 0):Boolean
		{
			if (arg > cockTotal() - 1 || arg < 0)
				return false;
			return (cocks[arg].cockType == CockTypesEnum.DOG || cocks[arg].cockType == CockTypesEnum.FOX || cocks[arg].cockType == CockTypesEnum.DISPLACER);
		}


		public function maxHP():Number
		{
			var max:Number = 0;
			max += int(tou * 2 + 50);
			if (findPerk(PerkLib.Tank) >= 0) max += 50;
			if (findPerk(PerkLib.Tank2) >= 0) max += Math.round(tou);
			if (findPerk(PerkLib.ChiReflowDefense) >= 0) max += UmasShop.NEEDLEWORK_DEFENSE_EXTRA_HP;
			if (level <= 20) max += level * 15;
			else max += 20 * 15;
			if (jewelryEffectId == 5) max += jewelryEffectMagnitude
			max = Math.round(max);
			if (max > 999) max = 999;
			return max;
		}

		public function buttDescript():String
		{
			return Appearance.buttDescription(this);
		}


	}

}