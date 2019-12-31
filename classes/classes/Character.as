package classes 
{
import classes.BodyParts.Face;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Items.JewelryLib;

/**
	 * Character class for player and NPCs. Has subclasses Player and NonPlayer.
	 * @author Yoffy
	 */
	public class Character extends Creature
	{
		//BEARDS! Not used anywhere right now but WHO WANTS A BEARD?
		//Kitteh6660: I want a beard! I'll code in obtainable beard. (DONE!)

		//Used for hip ratings
		public var thickness:Number = 0;
		
		//Body tone i.e. Lithe, stocky, etc
		public var tone:Number = 0;
		
		private var _pregnancyType:int = 0;
		public function get pregnancyType():int { return _pregnancyType; }

		private var _pregnancyIncubation:int = 0;
		public function get pregnancyIncubation():int { return _pregnancyIncubation; }

		private var _buttPregnancyType:int = 0;
		public function get buttPregnancyType():int { return _buttPregnancyType; }

		private var _buttPregnancyIncubation:int = 0;
		public function get buttPregnancyIncubation():int { return _buttPregnancyIncubation; }


		
		//Key items
		public var keyItems:Array;
		
		public function Character()
		{
			keyItems = [];
		}
		
		//Return bonus fertility

		//return total fertility

		
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
					/*if (hasBeard())
					{
						output += "  As if that wasn't bad enough, your " + beard() + " falls out too!";
						beardLength = 0;
						beardStyle = 0;
					}*/
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
					/*if (hasBeard())
					{
						output += "  As if that wasn't bad enough, your " + beard() + " falls out too!";
						beardLength = 0;
						beardStyle = 0;
					}*/
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
				/*if (femininity > 40 && hasBeard())
				{
					output += "\n<b>Your beard falls out, leaving you with " + faceDesc() + ".</b>\n";
					beardLength = 0;
					beardStyle = 0;
				}*/
			}
			/*if (gender != 1 && hasBeard())
			{
				output += "\n<b>Your beard falls out, leaving you with " + faceDesc() + ".</b>\n";
				beardLength = 0;
				beardStyle = 0;
			}*/
			return output;
		}

	public function hasBeard():Boolean{ return facePart.hasBeard(); }
	public function beard():String{ return facePart.beard(); }
	public function hasMuzzle():Boolean{ return facePart.hasMuzzle(); }
	public function hasBeak():Boolean{ return facePart.hasBeak(); }
	public function face():String { return facePart.describe(); }
	public function faceDesc():String { return facePart.describeMF(); }
	public function hasLongTail():Boolean { return tail.isLong(); }

		public function isPregnant():Boolean { return _pregnancyType != 0; }

		public function isButtPregnant():Boolean { return _buttPregnancyType != 0; }
	
		//fertility must be >= random(0-beat)
		//If arg == 1 then override any contraceptives and guarantee fertilization
		public function knockUp(type:int = 0, incubation:int = 0, beat:int = 100, arg:int = 0):void
		{
			//Contraceptives cancel!
			if (hasStatusEffect(StatusEffects.Contraceptives) && arg < 1)
				return;
			//Gargoyle cancel!
			if (isGargoyle())
				return;
//			if (hasStatusEffect(StatusEffects.GooStuffed)) return; //No longer needed thanks to PREGNANCY_GOO_STUFFED being used as a blocking value
			var bonus:int = 0;
			//If arg = 1 (always pregnant), bonus = 9000
			if (arg >= 1)
				bonus = 9000;
			if (arg <= -1)
				bonus = -9000;
			//If unpregnant and fertility wins out:
			if (pregnancyIncubation == 0 && totalFertility() + bonus > Math.floor(Math.random() * beat) && hasVagina())
			{
				knockUpForce(type, incubation);
				trace("PC Knocked up with pregnancy type: " + type + " for " + incubation + " incubation.");
			}
			//Chance for eggs fertilization - ovi elixir and imps excluded!
			if (type != PregnancyStore.PREGNANCY_IMP && type != PregnancyStore.PREGNANCY_OVIELIXIR_EGGS && type != PregnancyStore.PREGNANCY_ANEMONE)
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

		//The more complex knockUp function used by the player is defined above
		//The player doesn't need to be told of the last event triggered, so the code here is quite a bit simpler than that in PregnancyStore
		public function knockUpForce(type:int = 0, incubation:int = 0):void
		{
			_pregnancyType = type;
			_pregnancyIncubation = (type == 0 ? 0 : incubation); //Won't allow incubation time without pregnancy type
		}
	
		//fertility must be >= random(0-beat)
		public function buttKnockUp(type:int = 0, incubation:int = 0, beat:int = 100, arg:int = 0):void
		{
			//Contraceptives cancel!
			if (hasStatusEffect(StatusEffects.Contraceptives) && arg < 1)
				return;
			//Gargoyle cancel!
			if (isGargoyle())
				return;
			var bonus:int = 0;
			//If arg = 1 (always pregnant), bonus = 9000
			if (arg >= 1)
				bonus = 9000;
			if (arg <= -1)
				bonus = -9000;
			//If unpregnant and fertility wins out:
			if (buttPregnancyIncubation == 0 && totalFertility() + bonus > Math.floor(Math.random() * beat))
			{
				buttKnockUpForce(type, incubation);
				trace("PC Butt Knocked up with pregnancy type: " + type + " for " + incubation + " incubation.");
			}
		}

		//The more complex buttKnockUp function used by the player is defined in Character.as
		public function buttKnockUpForce(type:int = 0, incubation:int = 0):void
		{
			_buttPregnancyType = type;
			_buttPregnancyIncubation = (type == 0 ? 0 : incubation); //Won't allow incubation time without pregnancy type
		}

		public function pregnancyAdvance():Boolean {
			if (_pregnancyIncubation > 0) _pregnancyIncubation--;
			if (_pregnancyIncubation < 0) _pregnancyIncubation = 0;
			if (_buttPregnancyIncubation > 0) _buttPregnancyIncubation--;
			if (_buttPregnancyIncubation < 0) _buttPregnancyIncubation = 0;
			return pregnancyUpdate();
		}

		public function pregnancyUpdate():Boolean { return false; }

		//Create a keyItem
		public function createKeyItem(keyName:String, value1:Number, value2:Number, value3:Number, value4:Number):void
		{
			var newKeyItem:KeyItemClass = new KeyItemClass();
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
		
		public function hasKnot(arg:int = 0):Boolean
		{
			if (arg > cockTotal() - 1 || arg < 0)
				return false;
			return cocks[arg].hasKnot();
		}
		
		public override function minHP():Number
		{
			var min:Number = 0;
			if (findPerk(PerkLib.Diehard) >= 0) {
				min -= maxHP() * 0.02;
				min -= (200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (findPerk(PerkLib.ImprovedDiehard) >= 0) {
				min -= maxHP() * 0.04;
				min -= (400 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (findPerk(PerkLib.GreaterDiehard) >= 0) {
				min -= maxHP() * 0.06;
				min -= (600 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (findPerk(PerkLib.EpicDiehard) >= 0) {
				min -= maxHP() * 0.08;
				min -= (800 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}//nastepny diehard to 5% i 1000
			if (findPerk(PerkLib.OrcAdrenalGlandsFinalForm) >= 0 || game.player.orcScore() >= 11) {
				if (findPerk(PerkLib.Ferocity) >= 0) min -= maxHP() * 0.07;
				if (findPerk(PerkLib.OrcAdrenalGlands) >= 0) min -= maxHP() * 0.01;
				if (findPerk(PerkLib.OrcAdrenalGlandsEvolved) >= 0) min -= maxHP() * 0.02;
			}
			if (findPerk(PerkLib.DeityJobMunchkin) >= 0) {
				min -= str;
				min -= tou;
				min -= spe;
				min -= inte;
				min -= wis;
				min -= lib;
				min -= sens;
			}
			if (headjewelryName == "Crown of the Undefeated King") {
				min -= maxHP() * 0.05;
				min -= (500 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			min = Math.round(min);
			return min;
		}
		
		public override function maxFatigue():Number
		{
			var max:Number = 150;
			if (game.player.alicornScore() >= 12) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.dragonScore() >= 20) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.dragonScore() >= 28) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.foxScore() >= 7) max += (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.kitsuneScore() >= 5 && game.player.tailType == 13 && game.player.tailCount >= 2 && game.player.tailCount < 9) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.kitsuneScore() >= 12 && game.player.tailType == 13 && game.player.tailCount == 9) max += (300 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.lizardScore() >= 4) max += (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.unicornScore() >= 10) max += (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (findPerk(PerkLib.ArchersStaminaI) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.ArchersStaminaII) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.ArchersStaminaIII) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.ArchersStaminaIV) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.ArchersStaminaV) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.ArchersStaminaVI) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.DancersVitalityI) >= 0) max += Math.round(spe*1.5);
			if (findPerk(PerkLib.DancersVitalityII) >= 0) max += Math.round(spe*1.5);
			if (findPerk(PerkLib.DancersVitalityIII) >= 0) max += Math.round(spe*1.5);
			if (findPerk(PerkLib.DancersVitalityIV) >= 0) max += Math.round(spe*1.5);
			if (findPerk(PerkLib.DancersVitalityV) >= 0) max += Math.round(spe*1.5);
			if (findPerk(PerkLib.DancersVitalityVI) >= 0) max += Math.round(spe*1.5);
			if (findPerk(PerkLib.NaturesSpringI) >= 0) max += 20;
			if (findPerk(PerkLib.NaturesSpringII) >= 0) max += 20;
			if (findPerk(PerkLib.NaturesSpringIII) >= 0) max += 20;
			if (findPerk(PerkLib.NaturesSpringIV) >= 0) max += 20;
			if (findPerk(PerkLib.NaturesSpringV) >= 0) max += 20;
			if (findPerk(PerkLib.NaturesSpringVI) >= 0) max += 20;
			if (findPerk(PerkLib.BasicEndurance) >= 0) max += 30;
			if (findPerk(PerkLib.HalfStepToImprovedEndurance) >= 0) max += 50;
			if (findPerk(PerkLib.ImprovedEndurance) >= 0) max += 80;
			if (findPerk(PerkLib.HalfStepToAdvancedEndurance) >= 0) max += 120;
			if (findPerk(PerkLib.AdvancedEndurance) >= 0) max += 200;
			if (findPerk(PerkLib.HalfStepToSuperiorEndurance) >= 0) max += 320;
			if (findPerk(PerkLib.SuperiorEndurance) >= 0) max += 500;
			if (findPerk(PerkLib.HalfStepToPeerlessEndurance) >= 0) max += 700;
			if (findPerk(PerkLib.PeerlessEndurance) >= 0) max += 1000;
			if (findPerk(PerkLib.HalfStepToInhumanEndurance) >= 0) max += 1500;
			if (findPerk(PerkLib.InhumanEndurance) >= 0) max += 2000;
			if (findPerk(PerkLib.HalfStepToEpicEndurance) >= 0) max += 3000;
			if (findPerk(PerkLib.EpicEndurance) >= 0) max += 4500;
			if (findPerk(PerkLib.HalfStepToLegendaryEndurance) >= 0) max += 7000;
			if (findPerk(PerkLib.LegendaryEndurance) >= 0) max += 10000;
			if (findPerk(PerkLib.HalfStepToMythicalEndurance) >= 0) max += 15000;
			if (findPerk(PerkLib.MythicalEndurance) >= 0) max += 20000;
			if (findPerk(PerkLib.JobHunter) >= 0) max += 50;
			if (findPerk(PerkLib.JobRanger) >= 0) max += 5;
			if (findPerk(PerkLib.JobGunslinger) >= 0) max += 10;
			if (findPerk(PerkLib.DeityJobMunchkin) >= 0) max += 100;
			if (findPerk(PerkLib.PrestigeJobArcaneArcher) >= 0) max += 600;
			if (findPerk(PerkLib.PrestigeJobSoulArcher) >= 0) max += 150;
			if (findPerk(PerkLib.PrestigeJobSeer) >= 0) max += 900;
			if (findPerk(PerkLib.RapidReload) >= 0) max += 15;
			if (findPerk(PerkLib.LightningReload) >= 0) max += 25;
			if (findPerk(PerkLib.EromancyBeginner) >= 0) max += Math.round(lib);
			if (findPerk(PerkLib.EromancyExpert) >= 0) max += Math.round(lib*2);
			if (findPerk(PerkLib.EromancyMaster) >= 0) max += Math.round(lib*2);
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) max += (150 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (findPerk(PerkLib.FclassHeavenTribulationSurvivor) >= 0) max += (200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (findPerk(PerkLib.AscensionEndurance) >= 0) max += perkv1(PerkLib.AscensionEndurance) * 30;
			max += level * 5;
			if (findPerk(PerkLib.UnlockEndurance) >= 0) max += level * 5;
			if (findPerk(PerkLib.UnlockEndurance2ndStage) >= 0) max += level * 5;
			if (findPerk(PerkLib.UnlockEndurance3rdStage) >= 0) max += level * 5;
			if (findPerk(PerkLib.UnlockEndurance4thStage) >= 0) max += level * 5;
			if (findPerk(PerkLib.AscensionUnlockedPotential) >= 0) max += level * 6;
			var multimax:Number = 1;
			if (findPerk(PerkLib.LimitBreakerHeart1stStage) >= 0) multimax += 0.05;
			if (findPerk(PerkLib.LimitBreakerHeart2ndStage) >= 0) multimax += 0.1;
			max *= multimax;
			max = Math.round(max);
			if (max > 1499999) max = 1499999;
			return max;
		}
		
		public override function maxSoulforce():Number
		{
			var max:Number = 50;
			if (hasPerk(PerkLib.DemonicLethicite)) max += Math.round(lib);
			if (hasPerk(PerkLib.Metamorph)) max += (50 * (1 + perkv1(PerkLib.Metamorph)));
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 2) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 3) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 4) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 5) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 6) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 7) max += 40;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 8) max += 40;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 9) max += 40;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 10) max += 50;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 11) max += 50;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 12) max += 50;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 13) max += 60;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 14) max += 60;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 15) max += 60;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 16) max += 70;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 17) max += 70;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 18) max += 70;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 19) max += 80;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 20) max += 80;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 21) max += 80;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 22) max += 90;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 23) max += 90;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 24) max += 90;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 25) max += 100;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 26) max += 100;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 27) max += 100;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 28) max += 110;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 29) max += 110;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 30) max += 110;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 31) max += 120;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 32) max += 120;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 33) max += 120;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 34) max += 130;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 35) max += 130;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 36) max += 130;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 37) max += 140;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 38) max += 140;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 39) max += 140;
			if (findPerk(PerkLib.InsightfulResourcesI) >= 0) max += Math.round(wis*3);
			if (findPerk(PerkLib.InsightfulResourcesII) >= 0) max += Math.round(wis*3);
			if (findPerk(PerkLib.InsightfulResourcesIII) >= 0) max += Math.round(wis*3);
			if (findPerk(PerkLib.InsightfulResourcesIV) >= 0) max += Math.round(wis*3);
			if (findPerk(PerkLib.InsightfulResourcesV) >= 0) max += Math.round(wis*3);
			if (findPerk(PerkLib.InsightfulResourcesVI) >= 0) max += Math.round(wis*3);
			if (findPerk(PerkLib.PrestigeJobSoulArcher) >= 0) max += 1000;
			if (findPerk(PerkLib.PrestigeJobSeer) >= 0) max += 500;
			if (findPerk(PerkLib.DaoistCultivator) >= 0) max += 25;
			if (findPerk(PerkLib.DaoistApprenticeStage) >= 0) {
				if (findPerk(PerkLib.SoulApprentice) >= 0) max += 30;
				if (findPerk(PerkLib.SoulPersonage) >= 0) max += 30;
				if (findPerk(PerkLib.SoulWarrior) >= 0) max += 30;
			}
			if (findPerk(PerkLib.DaoistWarriorStage) >= 0) {
				if (findPerk(PerkLib.SoulSprite) >= 0) max += 40;
				if (findPerk(PerkLib.SoulScholar) >= 0) max += 40;
				if (findPerk(PerkLib.SoulElder) >= 0) max += 40;
			}
			if (findPerk(PerkLib.DaoistElderStage) >= 0) {
				if (findPerk(PerkLib.SoulExalt) >= 0) max += 50;
				if (findPerk(PerkLib.SoulOverlord) >= 0) max += 50;
				if (findPerk(PerkLib.SoulTyrant) >= 0) max += 50;
			}
			if (findPerk(PerkLib.DaoistOverlordStage) >= 0) {
				if (findPerk(PerkLib.SoulKing) >= 0) max += 60;
				if (findPerk(PerkLib.SoulEmperor) >= 0) max += 60;
				if (findPerk(PerkLib.SoulAncestor) >= 0) max += 60;
			}
			if (flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] > 0) max += flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING];//+310
			if (findPerk(PerkLib.AscensionSoulPurity) >= 0) max += perkv1(PerkLib.AscensionSoulPurity) * 50;
			if (jewelryEffectId == JewelryLib.MODIFIER_SF) max += jewelryEffectMagnitude;//+100
			if (jewelryEffectId2 == JewelryLib.MODIFIER_SF) max += jewelryEffectMagnitude2;//+100
			if (jewelryEffectId3 == JewelryLib.MODIFIER_SF) max += jewelryEffectMagnitude3;//+100
			if (jewelryEffectId4 == JewelryLib.MODIFIER_SF) max += jewelryEffectMagnitude4;//+100
			if (necklaceName == "soulmetal necklace") max += necklaceEffectMagnitude;//+100
			if (findPerk(PerkLib.UnlockSpirit) >= 0) max += level * 5;
			if (findPerk(PerkLib.UnlockSpirit2ndStage) >= 0) max += level * 5;
			if (findPerk(PerkLib.UnlockSpirit3rdStage) >= 0) max += level * 5;
			if (findPerk(PerkLib.UnlockSpirit4thStage) >= 0) max += level * 5;
			if (findPerk(PerkLib.AscensionUnlockedPotential2ndStage) >= 0) max += level * 6;
			var multimax:Number = 1;
			if (game.player.alicornScore() >= 12) multimax += 0.2;
			if (game.player.dragonScore() >= 20) multimax += 0.1;
			if (game.player.dragonScore() >= 28) multimax += 0.1;
			if (game.player.kitsuneScore() >= 5 && game.player.tailType == 13 && game.player.tailCount >= 2 && game.player.tailCount < 9) multimax += 0.2;
			if (game.player.kitsuneScore() >= 12 && game.player.tailType == 13 && game.player.tailCount == 9) multimax += 0.4;
			if (game.player.nekomataScore() >= 10) multimax += 0.1;
			if (game.player.nekomataScore() >= 12 && game.player.tailType == 8 && game.player.tailCount == 2) multimax += 0.2;
			if (game.player.unicornScore() >= 10) multimax += 0.1;
			if (findPerk(PerkLib.HistoryCultivator) >= 0 || findPerk(PerkLib.PastLifeCultivator) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.Wizened) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.PathOfEnlightenment) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.Embodiment) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.InControl) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.Metamorphable) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.SoulPowered) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.AllSeeing) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.DeityJobMunchkin) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.JobSoulCultivator) >= 0) {//8005-9005 soulforce na razie przed liczeniem mnożnika jest
				if (findPerk(PerkLib.Dantain) >= 0) {
					if (findPerk(PerkLib.JobSoulCultivator) >= 0) multimax += 0.1;
					if (findPerk(PerkLib.SoulApprentice) >= 0) multimax += 0.1;
					if (findPerk(PerkLib.SoulPersonage) >= 0) multimax += 0.1;
					if (findPerk(PerkLib.SoulWarrior) >= 0) multimax += 0.1;
					if (findPerk(PerkLib.SoulSprite) >= 0) multimax += 0.15;
					if (findPerk(PerkLib.SoulScholar) >= 0) multimax += 0.15;
					if (findPerk(PerkLib.SoulElder) >= 0) multimax += 0.15;
					if (findPerk(PerkLib.SoulExalt) >= 0) multimax += 0.2;
					if (findPerk(PerkLib.SoulOverlord) >= 0) multimax += 0.2;
					if (findPerk(PerkLib.SoulTyrant) >= 0) multimax += 0.2;
					if (findPerk(PerkLib.SoulKing) >= 0) multimax += 0.25;
					if (findPerk(PerkLib.SoulEmperor) >= 0) multimax += 0.25;
					if (findPerk(PerkLib.SoulAncestor) >= 0) multimax += 0.25;
				}
				if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) multimax += 0.1;
				if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) multimax += 0.15;
				if (findPerk(PerkLib.FclassHeavenTribulationSurvivor) >= 0) multimax += 0.2;
				//if (flags[kFLAGS.UNLOCKED_MERIDIANS] > 0) multimax += flags[kFLAGS.UNLOCKED_MERIDIANS] * 0.05;
				//if (findPerk(PerkLib.Ascension) >= 0) multimax += perkv1(PerkLib.Ascension) * 0.01;
				
			}
			if (findPerk(PerkLib.LimitBreakerSoul1stStage) >= 0) multimax += 0.05;
			if (findPerk(PerkLib.LimitBreakerSoul2ndStage) >= 0) multimax += 0.1;
			max *= multimax;
			max = Math.round(max);
			if (max > 1499999) max = 1499999;
			return max;
		}
		
		public override function maxWrath():Number
		{
			var max:Number = 250;
			if (findPerk(PerkLib.DoubleAttack) >= 0) max += 10;
			if (findPerk(PerkLib.TripleAttack) >= 0) max += 10;
			if (findPerk(PerkLib.QuadrupleAttack) >= 0) max += 10;
			if (findPerk(PerkLib.PentaAttack) >= 0) max += 10;
			if (findPerk(PerkLib.HexaAttack) >= 0) max += 10;
			if (findPerk(PerkLib.DoubleAttackLarge) >= 0) max += 20;
			if (findPerk(PerkLib.TripleAttackLarge) >= 0) max += 20;
			if (findPerk(PerkLib.PrimalFuryI) >= 0) max += 10;
			if (findPerk(PerkLib.PrimalFuryII) >= 0) max += 10;
			if (findPerk(PerkLib.PrimalFuryIII) >= 0) max += 10;
			if (findPerk(PerkLib.PrimalFuryIV) >= 0) max += 10;
			if (findPerk(PerkLib.PrimalFuryV) >= 0) max += 10;
			if (findPerk(PerkLib.PrimalFuryVI) >= 0) max += 10;
			if (findPerk(PerkLib.FeralArmor) >= 0) max += 20;
			if (findPerk(PerkLib.ClawTraining) >= 0) max += 20;
			if (findPerk(PerkLib.ExtraClawAttack) >= 0) max += 30;
			if (findPerk(PerkLib.MultiClawAttack) >= 0) max += 40;
			if (findPerk(PerkLib.ClawingFlurry) >= 0) max += 50;
			if (findPerk(PerkLib.BasicTranquilness) >= 0) max += 15;
			if (findPerk(PerkLib.HalfStepToImprovedTranquilness) >= 0) max += 25;
			if (findPerk(PerkLib.ImprovedTranquilness) >= 0) max += 40;
			if (findPerk(PerkLib.HalfStepToAdvancedTranquilness) >= 0) max += 60;
			if (findPerk(PerkLib.AdvancedTranquilness) >= 0) max += 100;
			if (findPerk(PerkLib.HalfStepToSuperiorTranquilness) >= 0) max += 160;
			if (findPerk(PerkLib.SuperiorTranquilness) >= 0) max += 250;
			if (findPerk(PerkLib.HalfStepToPeerlessTranquilness) >= 0) max += 350;
			if (findPerk(PerkLib.PeerlessTranquilness) >= 0) max += 500;
			if (findPerk(PerkLib.HalfStepToInhumanTranquilness) >= 0) max += 750;
			if (findPerk(PerkLib.InhumanTranquilness) >= 0) max += 1000;
			if (findPerk(PerkLib.HalfStepToEpicTranquilness) >= 0) max += 1500;
			if (findPerk(PerkLib.EpicTranquilness) >= 0) max += 2250;
			if (findPerk(PerkLib.HalfStepToLegendaryTranquilness) >= 0) max += 3500;
			if (findPerk(PerkLib.LegendaryTranquilness) >= 0) max += 5000;
			if (findPerk(PerkLib.HalfStepToMythicalTranquilness) >= 0) max += 7500;
			if (findPerk(PerkLib.MythicalTranquilness) >= 0) max += 10000;
			if (findPerk(PerkLib.JobSwordsman) >= 0) max += 20;
			if (findPerk(PerkLib.JobBeastWarrior) >= 0) max += 20;
			if (findPerk(PerkLib.JobDervish) >= 0) max += 20;
			if (findPerk(PerkLib.JobWarlord) >= 0) max += 20;
			if (findPerk(PerkLib.JobWarrior) >= 0) max += 10;
			if (findPerk(PerkLib.ImprovedCrinosShape) >= 0) max += 40;
			if (findPerk(PerkLib.GreaterCrinosShape) >= 0) max += 80;
			if (findPerk(PerkLib.MasterCrinosShape) >= 0) max += 160;
			if (findPerk(PerkLib.Berzerker) >= 0) max += 100;
			if (findPerk(PerkLib.ColdFury) >= 0) max += 50;
			if (findPerk(PerkLib.ColderFury) >= 0) max += 75;
			if (findPerk(PerkLib.Lustzerker) >= 0) max += 100;
			if (findPerk(PerkLib.ColdLust) >= 0) max += 50;
			if (findPerk(PerkLib.ColderLust) >= 0) max += 75;
			if (findPerk(PerkLib.PrestigeJobBerserker) >= 0) max += 200;
			if (findPerk(PerkLib.Rage) >= 0) max += 300;
			if (findPerk(PerkLib.Anger) >= 0) max += 400;
			if (findPerk(PerkLib.FuelForTheFire) >= 0) max += 500;
			if (findPerk(PerkLib.TooAngryToDie) >= 0) max += 600;
			if (findPerk(PerkLib.PrestigeJobTempest) >= 0) max += 100;
			if (findPerk(PerkLib.AscensionFury) >= 0) max += perkv1(PerkLib.AscensionFury) * 20;
			if (jewelryEffectId == JewelryLib.MODIFIER_WR) max += jewelryEffectMagnitude;//+75 to +175
			if (jewelryEffectId2 == JewelryLib.MODIFIER_WR) max += jewelryEffectMagnitude2;//+75 to +175
			if (jewelryEffectId3 == JewelryLib.MODIFIER_WR) max += jewelryEffectMagnitude3;//+75 to +175
			if (jewelryEffectId4 == JewelryLib.MODIFIER_WR) max += jewelryEffectMagnitude4;//+75 to +175
			if (jewelryName == "Undefeated King's Signet" || jewelryName3 == "Undefeated King's Signet") max += 150;
			if (findPerk(PerkLib.UnlockId) >= 0) max += level;
			if (findPerk(PerkLib.UnlockId2ndStage) >= 0) max += level;
			if (findPerk(PerkLib.UnlockId3rdStage) >= 0) max += level;
			if (findPerk(PerkLib.UnlockId4thStage) >= 0) max += level;
			if (findPerk(PerkLib.AscensionUnlockedPotential2ndStage) >= 0) max += level * 2;//~35,730
			var multimax:Number = 1;
			if (game.player.orcScore() >= 5) multimax += 0.1;
			if (game.player.orcScore() >= 11) multimax += 0.1;
			if (findPerk(PerkLib.LimitBreakerBody1stStage) >= 0) multimax += 0.05;
			if (findPerk(PerkLib.LimitBreakerBody2ndStage) >= 0) multimax += 0.1;
			max *= multimax;
			max = Math.round(max);
			if (max > 69999) max = 69999;
			return max;
		}
		
		public override function maxMana():Number
		{
			var max:Number = 200;
			if (findPerk(PerkLib.ManaAffinityI) >= 0) max += 35;
			if (findPerk(PerkLib.ManaAffinityII) >= 0) max += 35;
			if (findPerk(PerkLib.ManaAffinityIII) >= 0) max += 35;
			if (findPerk(PerkLib.ManaAffinityIV) >= 0) max += 35;
			if (findPerk(PerkLib.ManaAffinityV) >= 0) max += 35;
			if (findPerk(PerkLib.ManaAffinityVI) >= 0) max += 35;
			if (findPerk(PerkLib.MindOverBodyI) >= 0) max += Math.round(inte*2);
			if (findPerk(PerkLib.MindOverBodyII) >= 0) max += Math.round(inte*2);
			if (findPerk(PerkLib.MindOverBodyIII) >= 0) max += Math.round(inte*2);
			if (findPerk(PerkLib.MindOverBodyIV) >= 0) max += Math.round(inte*2);
			if (findPerk(PerkLib.MindOverBodyV) >= 0) max += Math.round(inte*2);
			if (findPerk(PerkLib.MindOverBodyVI) >= 0) max += Math.round(inte*2);
			if (findPerk(PerkLib.ArcanePoolI) >= 0) {
				max += Math.round(inte);
				max += Math.round(wis);
			}
			if (findPerk(PerkLib.ArcanePoolII) >= 0) {
				max += Math.round(inte);
				max += Math.round(wis);
			}
			if (findPerk(PerkLib.ArcanePoolIII) >= 0) {
				max += Math.round(inte);
				max += Math.round(wis);
			}
			if (findPerk(PerkLib.ArcanePoolIV) >= 0) {
				max += Math.round(inte);
				max += Math.round(wis);
			}
			if (findPerk(PerkLib.ArcanePoolV) >= 0) {
				max += Math.round(inte);
				max += Math.round(wis);
			}
			if (findPerk(PerkLib.ArcanePoolVI) >= 0) {
				max += Math.round(inte);
				max += Math.round(wis);
			}
			if (findPerk(PerkLib.BasicSpirituality) >= 0) max += 45;
			if (findPerk(PerkLib.HalfStepToImprovedSpirituality) >= 0) max += 75;
			if (findPerk(PerkLib.ImprovedSpirituality) >= 0) max += 120;
			if (findPerk(PerkLib.HalfStepToAdvancedSpirituality) >= 0) max += 180;
			if (findPerk(PerkLib.AdvancedSpirituality) >= 0) max += 300;
			if (findPerk(PerkLib.HalfStepToSuperiorSpirituality) >= 0) max += 480;
			if (findPerk(PerkLib.SuperiorSpirituality) >= 0) max += 750;
			if (findPerk(PerkLib.HalfStepToPeerlessSpirituality) >= 0) max += 1050;
			if (findPerk(PerkLib.PeerlessSpirituality) >= 0) max += 1500;
			if (findPerk(PerkLib.HalfStepToInhumanSpirituality) >= 0) max += 2250;
			if (findPerk(PerkLib.InhumanSpirituality) >= 0) max += 3000;
			if (findPerk(PerkLib.HalfStepToEpicSpirituality) >= 0) max += 4500;
			if (findPerk(PerkLib.EpicSpirituality) >= 0) max += 6750;
			if (findPerk(PerkLib.HalfStepToLegendarySpirituality) >= 0) max += 10500;
			if (findPerk(PerkLib.LegendarySpirituality) >= 0) max += 15000;
			if (findPerk(PerkLib.HalfStepToMythicalSpirituality) >= 0) max += 22500;
			if (findPerk(PerkLib.MythicalSpirituality) >= 0) max += 30000;
			if (findPerk(PerkLib.Archmage) >= 0 && inte >= 100) max += 60;
			if (findPerk(PerkLib.Channeling) >= 0 && inte >= 60) max += 30;
			if (findPerk(PerkLib.GrandArchmage) >= 0 && inte >= 125) max += 75;
			if (findPerk(PerkLib.GrandArchmage2ndCircle) >= 0 && inte >= 150) max += 90;
			if (findPerk(PerkLib.GrandArchmage3rdCircle) >= 0 && inte >= 175) max += 105;
			if (findPerk(PerkLib.GrandMage) >= 0 && inte >= 75) max += 45;
			if (findPerk(PerkLib.GreyArchmage) >= 0 && inte >= 225) max += 200;
			if (findPerk(PerkLib.GreyMage) >= 0 && inte >= 200) max += 150;
			if (findPerk(PerkLib.Mage) >= 0 && inte >= 50) max += 30;
			if (findPerk(PerkLib.Spellpower) >= 0 && inte >= 50) max += 15;
			if (findPerk(PerkLib.JobSorcerer) >= 0) max += 15;
			if (findPerk(PerkLib.JobHealer) >= 0) max += 30;
			if (findPerk(PerkLib.SpellpowerHealing) >= 0 && wis >= 50) max += 30;
			if (findPerk(PerkLib.EromancyBeginner) >= 0) max += Math.round(inte);
			if (findPerk(PerkLib.EromancyExpert) >= 0) max += Math.round(inte);
			if (findPerk(PerkLib.EromancyMaster) >= 0) max += Math.round(inte*2);
			var multimax:Number = 1;
			if (game.player.elfScore() >= 5) multimax += 0.1;
			if (game.player.elfScore() >= 11) multimax += 0.1;
			if (findPerk(PerkLib.HistoryScholar) >= 0 || findPerk(PerkLib.PastLifeScholar) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.Studious) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.Teacher) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.Professor) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.Principle) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.Dean) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.President) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.Nerd) >= 0) multimax += 0.1;
			if (findPerk(PerkLib.ArcaneRegenerationMinor) >= 0 && inte >= 50) {
				multimax += 0.1;
				if (findPerk(PerkLib.ArcaneRegenerationMajor) >= 0 && inte >= 75) multimax += 0.2;
				if (findPerk(PerkLib.ArcaneRegenerationEpic) >= 0 && inte >= 100) multimax += 0.3;
				if (findPerk(PerkLib.ArcaneRegenerationLegendary) >= 0 && inte >= 125) multimax += 0.4;
			}
			if (findPerk(PerkLib.AscensionInnerPower) >= 0) max += perkv1(PerkLib.AscensionInnerPower) * 40;
			if (jewelryEffectId == JewelryLib.MODIFIER_MP) max += jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_MP) max += jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_MP) max += jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_MP) max += jewelryEffectMagnitude4;
			max += level * 10;
			if (findPerk(PerkLib.UnlockForce) >= 0) max += level * 10;
			if (findPerk(PerkLib.UnlockForce2ndStage) >= 0) max += level * 10;
			if (findPerk(PerkLib.UnlockForce3rdStage) >= 0) max += level * 10;
			if (findPerk(PerkLib.UnlockForce4thStage) >= 0) max += level * 10;
			if (findPerk(PerkLib.AscensionUnlockedPotential2ndStage) >= 0) max += level * 12;
			if (findPerk(PerkLib.LimitBreakerSoul1stStage) >= 0) multimax += 0.05;
			if (findPerk(PerkLib.LimitBreakerSoul2ndStage) >= 0) multimax += 0.1;
			max *= multimax;
			max = Math.round(max);
			if (max > 2499999) max = 2499999;
			return max;
		}
		
		public function maxVenom():Number
		{
			var maxven:Number = 0;
			var multimaxven:Number = 1;
			if (game.player.faceType == Face.SNAKE_FANGS) maxven += 100;
			if (game.player.faceType == Face.SPIDER_FANGS) maxven += 100;
			if (game.player.tailType == Tail.BEE_ABDOMEN) maxven += 150;
			if (game.player.tailType == Tail.SPIDER_ADBOMEN) maxven += 150;
			if (game.player.tailType == Tail.SCORPION) maxven += 150;
			if (game.player.tailType == Tail.MANTICORE_PUSSYTAIL) maxven += 200;
			if (findPerk(PerkLib.ImprovedVenomGland) >= 0) maxven += 100;
			if (findPerk(PerkLib.VenomGlands) >= 0) maxven += 25;
			if (findPerk(PerkLib.VenomGlandsEvolved) >= 0) maxven += 100;
			if (findPerk(PerkLib.VenomGlandsFinalForm) >= 0) {
				maxven += 175;
				multimaxven += 0.2;
			}
			if (findPerk(PerkLib.JobSoulCultivator) >= 0) {
				if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) multimaxven += 0.1;
				if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) multimaxven += 0.15;
				if (findPerk(PerkLib.FclassHeavenTribulationSurvivor) >= 0) multimaxven += 0.2;
			}
			maxven *= multimaxven;
			maxven = Math.round(maxven);
			return maxven;
		}
		
		public function maxHunger():Number
		{
			var max:Number = 100;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 2) max += 10;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 3) max += 10;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 4) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 5) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 6) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 7) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 8) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 9) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 10) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 11) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 12) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 13) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 14) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 15) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 16) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 17) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 18) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 19) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 20) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 21) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 22) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 23) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 24) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 25) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 26) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 27) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 28) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 29) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 30) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 31) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 32) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 33) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 34) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 35) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 36) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 37) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 38) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 39) max += 35;
			if (game.player.dragonScore() >= 20) max += 50;
			if (game.player.dragonScore() >= 28) max += 50;
			//if (game.player.dragonScore() >= 11) max += 25;//pig races having max hunger bonus too?
			if (findPerk(PerkLib.EzekielBlessing) >= 0) max += 50;
			if (findPerk(PerkLib.ManticoreMetabolismEvolved) >= 0) max += 50;
			// (findPerk(PerkLib.) >= 0 && game.player.humanScore() < 5) max += 100;
			// jak bedzie mieć chimeryczna nature to kolejny boost to max hunger moze...150 lub nawet 200 ^^
			if (findPerk(PerkLib.IronStomach) >= 0) max += 50;
			if (findPerk(PerkLib.IronStomachEx) >= 0) max += 100;
			if (findPerk(PerkLib.IronStomachSu) >= 0) max += 200;
			// (findPerk(PerkLib.Overeating) >= 0) max += Math.round(level/6);42
			// (findPerk(PerkLib.Overeating) >= 0) max += Math.round(level/3);72
			// (findPerk(PerkLib.Overeating) >= 0) max += level;102
			// (findPerk(PerkLib.Satiation lub Gluttony) >= 0) max += level;nastepny tier
			// (findPerk(PerkLib.Satiation lub Gluttony) >= 0) max += level;nastepny tier
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) max += 20;
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) max += 30;
			if (findPerk(PerkLib.FclassHeavenTribulationSurvivor) >= 0) max += 40;
			if (max > 1759) max = 1759;//obecnie max to 1750
			return max;
		}


	}

}
