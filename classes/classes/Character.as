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
			if (!hasPerk(PerkLib.Androgyny))
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
				if (hasPerk(PerkLib.SpiderOvipositor) || hasPerk(PerkLib.BeeOvipositor))
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

		/**
		 * Returns key item instance by name, or null if no such key item possessed.
		 */
		public function getKeyItem(keyName:String):KeyItemClass {
			for (var i:int = 0; i<keyItems.length; i++) {
				if (keyItems[i].keyName == keyName) return keyItems[i];
			}
			return null;
		}

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
			if (hasPerk(PerkLib.Diehard)) {
				min -= maxHP() * 0.02;
				min -= (600 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (hasPerk(PerkLib.ImprovedDiehard)) {
				min -= maxHP() * 0.04;
				min -= (1200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (hasPerk(PerkLib.GreaterDiehard)) {
				min -= maxHP() * 0.06;
				min -= (1800 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (hasPerk(PerkLib.EpicDiehard)) {
				min -= maxHP() * 0.08;
				min -= (2400 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}//nastepny diehard to 10% i 3000 a potem 12% i 3600
			if (hasPerk(PerkLib.LizanMarrowFinalForm)) min -= maxHP() * 0.05;
			if (hasPerk(PerkLib.OrcAdrenalGlandsFinalForm) || game.player.orcScore() >= 11) {
				if (hasPerk(PerkLib.Ferocity)) min -= maxHP() * 0.07;
				if (hasPerk(PerkLib.OrcAdrenalGlands)) min -= maxHP() * 0.01;
				if (hasPerk(PerkLib.OrcAdrenalGlandsEvolved)) min -= maxHP() * 0.02;
			}
			if (hasPerk(PerkLib.DeityJobMunchkin)) {
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
			if (game.player.dragonScore() >= 24) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.dragonScore() >= 32) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.foxScore() >= 7) max += (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.kitsuneScore() >= 5) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.kitsuneScore() >= 9 && game.player.tailType == 13 && game.player.tailCount >= 2) {
				max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (game.player.kitsuneScore() >= 16 && game.player.tailCount == 9) {
					max += (200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
					if (game.player.kitsuneScore() >= 21 && hasPerk(PerkLib.NinetailsKitsuneOfBalance)) {
						max += (200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
						if (game.player.kitsuneScore() >= 26) max += (500 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
					}
				}
			}
			if (game.player.lizardScore() >= 4) max += (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.unicornScore() >= 10) max += (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.ArchersStaminaI)) max += Math.round(spe);
			if (hasPerk(PerkLib.ArchersStaminaII)) max += Math.round(spe);
			if (hasPerk(PerkLib.ArchersStaminaIII)) max += Math.round(spe);
			if (hasPerk(PerkLib.ArchersStaminaIV)) max += Math.round(spe);
			if (hasPerk(PerkLib.ArchersStaminaV)) max += Math.round(spe);
			if (hasPerk(PerkLib.ArchersStaminaVI)) max += Math.round(spe);
			if (hasPerk(PerkLib.DancersVitalityI)) max += Math.round(spe*1.5);
			if (hasPerk(PerkLib.DancersVitalityII)) max += Math.round(spe*1.5);
			if (hasPerk(PerkLib.DancersVitalityIII)) max += Math.round(spe*1.5);
			if (hasPerk(PerkLib.DancersVitalityIV)) max += Math.round(spe*1.5);
			if (hasPerk(PerkLib.DancersVitalityV)) max += Math.round(spe*1.5);
			if (hasPerk(PerkLib.DancersVitalityVI)) max += Math.round(spe*1.5);
			if (hasPerk(PerkLib.NaturesSpringI)) max += 20;
			if (hasPerk(PerkLib.NaturesSpringII)) max += 20;
			if (hasPerk(PerkLib.NaturesSpringIII)) max += 20;
			if (hasPerk(PerkLib.NaturesSpringIV)) max += 20;
			if (hasPerk(PerkLib.NaturesSpringV)) max += 20;
			if (hasPerk(PerkLib.NaturesSpringVI)) max += 20;
			if (hasPerk(PerkLib.BasicEndurance)) max += 30;
			if (hasPerk(PerkLib.HalfStepToImprovedEndurance)) max += 50;
			if (hasPerk(PerkLib.ImprovedEndurance)) max += 80;
			if (hasPerk(PerkLib.HalfStepToAdvancedEndurance)) max += 120;
			if (hasPerk(PerkLib.AdvancedEndurance)) max += 200;
			if (hasPerk(PerkLib.HalfStepToSuperiorEndurance)) max += 320;
			if (hasPerk(PerkLib.SuperiorEndurance)) max += 500;
			if (hasPerk(PerkLib.HalfStepToPeerlessEndurance)) max += 700;
			if (hasPerk(PerkLib.PeerlessEndurance)) max += 1000;
			if (hasPerk(PerkLib.HalfStepToInhumanEndurance)) max += 1500;
			if (hasPerk(PerkLib.InhumanEndurance)) max += 2000;
			if (hasPerk(PerkLib.HalfStepToEpicEndurance)) max += 3000;
			if (hasPerk(PerkLib.EpicEndurance)) max += 4500;
			if (hasPerk(PerkLib.HalfStepToLegendaryEndurance)) max += 7000;
			if (hasPerk(PerkLib.LegendaryEndurance)) max += 10000;
			if (hasPerk(PerkLib.HalfStepToMythicalEndurance)) max += 15000;
			if (hasPerk(PerkLib.MythicalEndurance)) max += 20000;
			if (hasPerk(PerkLib.JobHunter)) max += 50;
			if (hasPerk(PerkLib.JobRanger)) max += 5;
			if (hasPerk(PerkLib.JobGunslinger)) max += 10;
			if (hasPerk(PerkLib.PrestigeJobArcaneArcher)) max += 600;
			if (hasPerk(PerkLib.PrestigeJobSoulArcher)) max += 150;
			if (hasPerk(PerkLib.PrestigeJobSeer)) max += 900;
			if (hasPerk(PerkLib.RapidReload)) max += 15;
			if (hasPerk(PerkLib.LightningReload)) max += 25;
			if (hasPerk(PerkLib.EromancyBeginner)) max += Math.round(lib);
			if (hasPerk(PerkLib.EromancyExpert)) max += Math.round(lib*2);
			if (hasPerk(PerkLib.EromancyMaster)) max += Math.round(lib*2);
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) max += (150 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) max += (200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) max += (250 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.AscensionEndurance)) max += perkv1(PerkLib.AscensionEndurance) * 30;
			max += level * 5;
			if (level <= 6) max += level * 5;
			if (hasPerk(PerkLib.UnlockEndurance)) max += level * 5;
			if (hasPerk(PerkLib.UnlockEndurance2ndStage)) max += level * 5;
			if (hasPerk(PerkLib.UnlockEndurance3rdStage)) max += level * 5;
			if (hasPerk(PerkLib.UnlockEndurance4thStage)) max += level * 5;
			if (hasPerk(PerkLib.AscensionUnlockedPotential)) max += level * 6;
			if (hasPerk(PerkLib.AscensionUnlockedPotential3rdStage)) max += level * 6;
			var multimax:Number = 1;
			if (hasPerk(PerkLib.ZenjisInfluence1)) multimax += 0.1;
			if (hasPerk(PerkLib.LimitBreakerHeart1stStage)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerHeart2ndStage)) multimax += 0.1;
			if (hasPerk(PerkLib.DeityJobMunchkin)) multimax += 0.1;
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
			if (hasPerk(PerkLib.InsightfulResourcesI)) max += Math.round(wis*3);
			if (hasPerk(PerkLib.InsightfulResourcesII)) max += Math.round(wis*3);
			if (hasPerk(PerkLib.InsightfulResourcesIII)) max += Math.round(wis*3);
			if (hasPerk(PerkLib.InsightfulResourcesIV)) max += Math.round(wis*3);
			if (hasPerk(PerkLib.InsightfulResourcesV)) max += Math.round(wis*3);
			if (hasPerk(PerkLib.InsightfulResourcesVI)) max += Math.round(wis*3);
			if (hasPerk(PerkLib.PrestigeJobSoulArcher)) max += 1000;
			if (hasPerk(PerkLib.PrestigeJobSeer)) max += 500;
			if (hasPerk(PerkLib.DaoistCultivator)) max += 25;
			if (hasPerk(PerkLib.DaoistApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) max += 30;
				if (hasPerk(PerkLib.SoulPersonage)) max += 30;
				if (hasPerk(PerkLib.SoulWarrior)) max += 30;
			}
			if (hasPerk(PerkLib.DaoistWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) max += 40;
				if (hasPerk(PerkLib.SoulScholar)) max += 40;
				if (hasPerk(PerkLib.SoulElder)) max += 40;
			}
			if (hasPerk(PerkLib.DaoistElderStage)) {
				if (hasPerk(PerkLib.SoulExalt)) max += 50;
				if (hasPerk(PerkLib.SoulOverlord)) max += 50;
				if (hasPerk(PerkLib.SoulTyrant)) max += 50;
			}
			if (hasPerk(PerkLib.DaoistOverlordStage)) {
				if (hasPerk(PerkLib.SoulKing)) max += 60;
				if (hasPerk(PerkLib.SoulEmperor)) max += 60;
				if (hasPerk(PerkLib.SoulAncestor)) max += 60;
			}
			if (flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] > 0) max += flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING];//+310
			if (hasPerk(PerkLib.AscensionSoulPurity)) max += perkv1(PerkLib.AscensionSoulPurity) * 50;
			if (jewelryEffectId == JewelryLib.MODIFIER_SF) max += jewelryEffectMagnitude;//+100
			if (jewelryEffectId2 == JewelryLib.MODIFIER_SF) max += jewelryEffectMagnitude2;//+100
			if (jewelryEffectId3 == JewelryLib.MODIFIER_SF) max += jewelryEffectMagnitude3;//+100
			if (jewelryEffectId4 == JewelryLib.MODIFIER_SF) max += jewelryEffectMagnitude4;//+100
			if (necklaceName == "soulmetal necklace") max += necklaceEffectMagnitude;//+100
			max += level * 5;
			if (level <= 6) max += level * 5;
			if (hasPerk(PerkLib.UnlockSpirit)) max += level * 5;
			if (hasPerk(PerkLib.UnlockSpirit2ndStage)) max += level * 5;
			if (hasPerk(PerkLib.UnlockSpirit3rdStage)) max += level * 5;
			if (hasPerk(PerkLib.UnlockSpirit4thStage)) max += level * 5;
			if (hasPerk(PerkLib.AscensionUnlockedPotential2ndStage)) max += level * 6;
			if (hasPerk(PerkLib.AscensionUnlockedPotential4thStage)) max += level * 6
			var multimax:Number = 1;
			if (game.player.alicornScore() >= 12) multimax += 0.2;
			if (game.player.kitsuneScore() >= 5) multimax += 0.1;
			if (game.player.kitsuneScore() >= 9 && game.player.tailType == 13 && game.player.tailCount >= 2) {
				multimax += 0.1;
				if (game.player.kitsuneScore() >= 16 && game.player.tailCount == 9) {
					multimax += 0.2;
					if (game.player.kitsuneScore() >= 21 && hasPerk(PerkLib.NinetailsKitsuneOfBalance)) {
						multimax += 0.25;
						if (game.player.kitsuneScore() >= 26) multimax += 0.35;
					}
				}
			}
			if (game.player.nekomataScore() >= 10) multimax += 0.1;
			if (game.player.nekomataScore() >= 12 && game.player.tailType == 8 && game.player.tailCount == 2) multimax += 0.2;
			if (game.player.unicornScore() >= 10) multimax += 0.1;
			if (hasPerk(PerkLib.HistoryCultivator) || hasPerk(PerkLib.PastLifeCultivator)) multimax += 0.1;
			if (hasPerk(PerkLib.Wizened)) multimax += 0.1;
			if (hasPerk(PerkLib.PathOfEnlightenment)) multimax += 0.1;
			if (hasPerk(PerkLib.Embodiment)) multimax += 0.1;
			if (hasPerk(PerkLib.InControl)) multimax += 0.1;
			if (hasPerk(PerkLib.Metamorphable)) multimax += 0.1;
			if (hasPerk(PerkLib.SoulPowered)) multimax += 0.1;
			if (hasPerk(PerkLib.AllSeeing)) multimax += 0.1;
			if (hasPerk(PerkLib.DeityJobMunchkin)) multimax += 0.1;
			if (hasPerk(PerkLib.JobSoulCultivator)) {//8005-9005 soulforce na razie przed liczeniem mnożnika jest
				if (hasPerk(PerkLib.Dantain)) {
					if (hasPerk(PerkLib.JobSoulCultivator)) multimax += 0.1;
					if (hasPerk(PerkLib.SoulApprentice)) multimax += 0.1;
					if (hasPerk(PerkLib.SoulPersonage)) multimax += 0.1;
					if (hasPerk(PerkLib.SoulWarrior)) multimax += 0.1;
					if (hasPerk(PerkLib.SoulSprite)) multimax += 0.15;
					if (hasPerk(PerkLib.SoulScholar)) multimax += 0.15;
					if (hasPerk(PerkLib.SoulElder)) multimax += 0.15;
					if (hasPerk(PerkLib.SoulExalt)) multimax += 0.2;
					if (hasPerk(PerkLib.SoulOverlord)) multimax += 0.2;
					if (hasPerk(PerkLib.SoulTyrant)) multimax += 0.2;
					if (hasPerk(PerkLib.SoulKing)) multimax += 0.25;
					if (hasPerk(PerkLib.SoulEmperor)) multimax += 0.25;
					if (hasPerk(PerkLib.SoulAncestor)) multimax += 0.25;
				}
				if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) multimax += 0.1;
				if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) multimax += 0.15;
				if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) multimax += 0.2;
				if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) multimax += 0.25;
				//if (flags[kFLAGS.UNLOCKED_MERIDIANS] > 0) multimax += flags[kFLAGS.UNLOCKED_MERIDIANS] * 0.05;
				//if (hasPerk(PerkLib.Ascension)) multimax += perkv1(PerkLib.Ascension) * 0.01;
				
			}
			if (hasPerk(PerkLib.LimitBreakerSoul1stStage)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerSoul2ndStage)) multimax += 0.1;
			max *= multimax;
			max = Math.round(max);
			if (max > 1499999) max = 1499999;
			return max;
		}
		
		public override function maxWrath():Number
		{
			var max:Number = 500;
			if (hasPerk(PerkLib.DoubleAttack)) max += 50;
			if (hasPerk(PerkLib.TripleAttack)) max += 50;
			if (hasPerk(PerkLib.QuadrupleAttack)) max += 50;
			if (hasPerk(PerkLib.PentaAttack)) max += 50;
			if (hasPerk(PerkLib.HexaAttack)) max += 50;
			if (hasPerk(PerkLib.DoubleAttackLarge)) max += 100;
			if (hasPerk(PerkLib.TripleAttackLarge)) max += 100;
			if (hasPerk(PerkLib.FeralArmor)) max += 100;
			if (hasPerk(PerkLib.ClawTraining)) max += 100;
			if (hasPerk(PerkLib.ExtraClawAttack)) max += 150;
			if (hasPerk(PerkLib.MultiClawAttack)) max += 200;
			if (hasPerk(PerkLib.ClawingFlurry)) max += 250;
			if (hasPerk(PerkLib.BasicTranquilness)) max += 75;
			if (hasPerk(PerkLib.HalfStepToImprovedTranquilness)) max += 125;
			if (hasPerk(PerkLib.ImprovedTranquilness)) max += 200;
			if (hasPerk(PerkLib.HalfStepToAdvancedTranquilness)) max += 300;
			if (hasPerk(PerkLib.AdvancedTranquilness)) max += 500;
			if (hasPerk(PerkLib.HalfStepToSuperiorTranquilness)) max += 800;
			if (hasPerk(PerkLib.SuperiorTranquilness)) max += 1250;
			if (hasPerk(PerkLib.HalfStepToPeerlessTranquilness)) max += 1750;
			if (hasPerk(PerkLib.PeerlessTranquilness)) max += 2500;
			if (hasPerk(PerkLib.HalfStepToInhumanTranquilness)) max += 3750;
			if (hasPerk(PerkLib.InhumanTranquilness)) max += 5000;
			if (hasPerk(PerkLib.HalfStepToEpicTranquilness)) max += 7500;
			if (hasPerk(PerkLib.EpicTranquilness)) max += 11250;
			if (hasPerk(PerkLib.HalfStepToLegendaryTranquilness)) max += 17500;
			if (hasPerk(PerkLib.LegendaryTranquilness)) max += 25000;
			if (hasPerk(PerkLib.HalfStepToMythicalTranquilness)) max += 37500;
			if (hasPerk(PerkLib.MythicalTranquilness)) max += 50000;
			if (hasPerk(PerkLib.JobSwordsman)) max += 100;
			if (hasPerk(PerkLib.JobBeastWarrior)) max += 100;
			if (hasPerk(PerkLib.JobDervish)) max += 100;
			if (hasPerk(PerkLib.JobWarlord)) max += 100;
			if (hasPerk(PerkLib.JobWarrior)) max += 50;
			if (hasPerk(PerkLib.ImprovedCrinosShape)) max += 200;
			if (hasPerk(PerkLib.GreaterCrinosShape)) max += 400;
			if (hasPerk(PerkLib.MasterCrinosShape)) max += 800;
			if (hasPerk(PerkLib.Berzerker)) max += 500;
			if (hasPerk(PerkLib.ColdFury)) max += 250;
			if (hasPerk(PerkLib.ColderFury)) max += 375;
			if (hasPerk(PerkLib.Lustzerker)) max += 500;
			if (hasPerk(PerkLib.ColdLust)) max += 250;
			if (hasPerk(PerkLib.ColderLust)) max += 375;
			if (hasPerk(PerkLib.PrestigeJobBerserker)) max += 1000;
			if (hasPerk(PerkLib.Rage)) max += 1500;
			if (hasPerk(PerkLib.Anger)) max += 2000;
			if (hasPerk(PerkLib.FuelForTheFire)) max += 2500;
			if (hasPerk(PerkLib.TooAngryToDie)) max += 3000;
			if (hasPerk(PerkLib.PrestigeJobTempest)) max += 500;
			if (hasPerk(PerkLib.WarMageNovice)) max += 50;
			if (hasPerk(PerkLib.WarMageApprentice)) max += 50;
			if (hasPerk(PerkLib.WarMageAdept)) max += 150;
			if (hasPerk(PerkLib.AscensionFury)) max += perkv1(PerkLib.AscensionFury) * 100;
			if (jewelryEffectId == JewelryLib.MODIFIER_WR) max += jewelryEffectMagnitude;//+75 to +175
			if (jewelryEffectId2 == JewelryLib.MODIFIER_WR) max += jewelryEffectMagnitude2;//+75 to +175
			if (jewelryEffectId3 == JewelryLib.MODIFIER_WR) max += jewelryEffectMagnitude3;//+75 to +175
			if (jewelryEffectId4 == JewelryLib.MODIFIER_WR) max += jewelryEffectMagnitude4;//+75 to +175
			if (jewelryName == "Undefeated King's Signet" || jewelryName3 == "Undefeated King's Signet") max += 150;
			max += level * 5;
			if (level <= 6) max += level * 5;
			else max += 30;
			if (hasPerk(PerkLib.UnlockId)) max += level * 5;
			if (hasPerk(PerkLib.UnlockId2ndStage)) max += level * 5;
			if (hasPerk(PerkLib.UnlockId3rdStage)) max += level * 5;
			if (hasPerk(PerkLib.UnlockId4thStage)) max += level * 5;
			if (hasPerk(PerkLib.AscensionUnlockedPotential2ndStage)) max += level * 10;
			if (hasPerk(PerkLib.AscensionUnlockedPotential4thStage)) max += level * 10;//~194,455
			var multimax:Number = 1;
			if (game.player.orcScore() >= 5) multimax += 0.1;
			if (game.player.orcScore() >= 11) multimax += 0.1;
			if (hasPerk(PerkLib.PrimalFuryI)) multimax += 0.05;
			if (hasPerk(PerkLib.PrimalFuryII)) multimax += 0.05;
			if (hasPerk(PerkLib.PrimalFuryIII)) multimax += 0.05;
			if (hasPerk(PerkLib.PrimalFuryIV)) multimax += 0.05;
			if (hasPerk(PerkLib.PrimalFuryV)) multimax += 0.05;
			if (hasPerk(PerkLib.PrimalFuryVI)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerBody1stStage)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerBody2ndStage)) multimax += 0.1;
			if (hasPerk(PerkLib.DeityJobMunchkin)) multimax += 0.2;
			if (hasPerk(PerkLib.ICastAsuraFist)) multimax += 0.5;
			if (vehiclesName == "Giant Slayer Mech") {
				multimax += 0.1;
				//if (upgrade mecha) multimax += 0.1;
				//if (upgrade mecha) multimax += 0.1;
				//if (upgrade mecha) multimax += 0.1;
				//if (upgrade mecha) multimax += 0.1;
			}
			max *= multimax;//~245%
			max = Math.round(max);//476 414,75
			if (max > 476999) max = 476999;
			return max;
		}
		public override function maxOverWrath():Number {
			var max1:Number = maxWrath();
			var max2:Number = 1;
			if (hasPerk(PerkLib.HiddenJobAsura)) max2 += 0.1;
			if (hasPerk(PerkLib.AbsoluteStrength)) max2 += 0.1;
			if (hasPerk(PerkLib.LikeAnAsuraBoss)) max2 += 0.1;
			if (hasPerk(PerkLib.ICastAsuraFist)) max2 += 0.1;
			if (hasPerk(PerkLib.AsuraStrength)) max2 += 0.1;
			//
			if (hasPerk(PerkLib.AsuraToughness)) max2 += 0.1;
			//
			if (hasPerk(PerkLib.AsuraSpeed)) max2 += 0.1;
			max1 *= max2;//~170%
			max1 = Math.round(max1);//~809 905,5
			if (max1 > 809999) max1 = 809999;
			return max1;
		}
		public function maxSafeWrathMagicalAbilities():Number {
			var max1:Number = 0;
			if (hasPerk(PerkLib.ICastAsuraFist)) max1 += maxOverWrath();
			else max1 += maxWrath();
			var max2:Number = 0.8;
			if (flags[kFLAGS.GAME_DIFFICULTY] < 2) max2 += 0.2;
			//if (hasPerk(PerkLib.)) max2 += 0.1;
			max1 *= max2;
			max1 = Math.round(max1);
			return max1;
		}
		public function maxSafeWrathSpellcasting():Number {
			var max1:Number = 0;
			if (hasPerk(PerkLib.ICastAsuraFist)) max1 += maxOverWrath();
			else max1 += maxWrath();
			var max2:Number = 0.6;
			if (flags[kFLAGS.GAME_DIFFICULTY] < 2) max2 += 0.4;
			if (hasPerk(PerkLib.MagesWrath)) max2 += 0.05;
			if (hasPerk(PerkLib.MagesWrathEx)) max2 += 0.05;
			if (hasPerk(PerkLib.WarMageNovice)) max2 += 0.05;
			if (hasPerk(PerkLib.WarMageApprentice)) max2 += 0.05;
			if (hasPerk(PerkLib.WarMageAdept)) max2 += 0.05;
			if (hasPerk(PerkLib.WarMageExpert)) max2 += 0.05;
			if (hasPerk(PerkLib.WarMageMaster)) max2 += 0.05;
			max1 *= max2;
			max1 = Math.round(max1);
			return max1;
		}
		
		public override function maxMana():Number
		{
			var max:Number = 300;
			if (hasPerk(PerkLib.MindOverBodyI)) max += Math.round(inte*6);
			if (hasPerk(PerkLib.MindOverBodyII)) max += Math.round(inte*6);
			if (hasPerk(PerkLib.MindOverBodyIII)) max += Math.round(inte*6);
			if (hasPerk(PerkLib.MindOverBodyIV)) max += Math.round(inte*6);
			if (hasPerk(PerkLib.MindOverBodyV)) max += Math.round(inte*6);
			if (hasPerk(PerkLib.MindOverBodyVI)) max += Math.round(inte*6);
			if (hasPerk(PerkLib.ArcanePoolI)) {
				max += Math.round(inte*3);
				max += Math.round(wis*3);
			}
			if (hasPerk(PerkLib.ArcanePoolII)) {
				max += Math.round(inte*3);
				max += Math.round(wis*3);
			}
			if (hasPerk(PerkLib.ArcanePoolIII)) {
				max += Math.round(inte*3);
				max += Math.round(wis*3);
			}
			if (hasPerk(PerkLib.ArcanePoolIV)) {
				max += Math.round(inte*3);
				max += Math.round(wis*3);
			}
			if (hasPerk(PerkLib.ArcanePoolV)) {
				max += Math.round(inte*3);
				max += Math.round(wis*3);
			}
			if (hasPerk(PerkLib.ArcanePoolVI)) {
				max += Math.round(inte*3);
				max += Math.round(wis*3);
			}
			if (hasPerk(PerkLib.BasicSpirituality)) max += 135;
			if (hasPerk(PerkLib.HalfStepToImprovedSpirituality)) max += 225;
			if (hasPerk(PerkLib.ImprovedSpirituality)) max += 360;
			if (hasPerk(PerkLib.HalfStepToAdvancedSpirituality)) max += 540;
			if (hasPerk(PerkLib.AdvancedSpirituality)) max += 900;
			if (hasPerk(PerkLib.HalfStepToSuperiorSpirituality)) max += 1440;
			if (hasPerk(PerkLib.SuperiorSpirituality)) max += 2250;
			if (hasPerk(PerkLib.HalfStepToPeerlessSpirituality)) max += 3150;
			if (hasPerk(PerkLib.PeerlessSpirituality)) max += 4500;
			if (hasPerk(PerkLib.HalfStepToInhumanSpirituality)) max += 6750;
			if (hasPerk(PerkLib.InhumanSpirituality)) max += 9000;
			if (hasPerk(PerkLib.HalfStepToEpicSpirituality)) max += 13500;
			if (hasPerk(PerkLib.EpicSpirituality)) max += 20250;
			if (hasPerk(PerkLib.HalfStepToLegendarySpirituality)) max += 31500;
			if (hasPerk(PerkLib.LegendarySpirituality)) max += 45000;
			if (hasPerk(PerkLib.HalfStepToMythicalSpirituality)) max += 67500;
			if (hasPerk(PerkLib.MythicalSpirituality)) max += 90000;
			if (hasPerk(PerkLib.Archmage) && inte >= 100) max += 180;
			if (hasPerk(PerkLib.Channeling) && inte >= 60) max += 90;
			if (hasPerk(PerkLib.GrandArchmage) && inte >= 125) max += 225;
			if (hasPerk(PerkLib.GrandArchmage2ndCircle) && inte >= 150) max += 270;
			if (hasPerk(PerkLib.GrandArchmage3rdCircle) && inte >= 175) max += 315;
			if (hasPerk(PerkLib.GrandMage) && inte >= 75) max += 135;
			if (hasPerk(PerkLib.GreyArchmage) && inte >= 225) max += 600;
			if (hasPerk(PerkLib.GreyMage) && inte >= 200) max += 450;
			if (hasPerk(PerkLib.Mage) && inte >= 50) max += 90;
			if (hasPerk(PerkLib.Spellpower) && inte >= 50) max += 45;
			if (hasPerk(PerkLib.JobSorcerer)) max += 45;
			if (hasPerk(PerkLib.JobHealer)) max += 90;
			if (hasPerk(PerkLib.SpellpowerHealing) && wis >= 50) max += 90;
			if (hasPerk(PerkLib.EromancyBeginner)) max += Math.round(inte*3);
			if (hasPerk(PerkLib.EromancyExpert)) max += Math.round(inte*3);
			if (hasPerk(PerkLib.EromancyMaster)) max += Math.round(inte*6);
			var multimax:Number = 1;
			if (game.player.elfScore() >= 5) multimax += 0.1;
			if (game.player.elfScore() >= 11) multimax += 0.1;
			if (hasPerk(PerkLib.HistoryScholar) || hasPerk(PerkLib.PastLifeScholar)) multimax += 0.1;
			if (hasPerk(PerkLib.Studious)) multimax += 0.1;
			if (hasPerk(PerkLib.Teacher)) multimax += 0.1;
			if (hasPerk(PerkLib.Professor)) multimax += 0.1;
			if (hasPerk(PerkLib.Principle)) multimax += 0.1;
			if (hasPerk(PerkLib.Dean)) multimax += 0.1;
			if (hasPerk(PerkLib.President)) multimax += 0.1;
			if (hasPerk(PerkLib.Nerd)) multimax += 0.1;
			if (hasPerk(PerkLib.ArcaneRegenerationMinor) && inte >= 50) {
				multimax += 0.05;
				if (hasPerk(PerkLib.ArcaneRegenerationMajor) && inte >= 75) multimax += 0.1;
				if (hasPerk(PerkLib.ArcaneRegenerationEpic) && inte >= 100) multimax += 0.15;
				if (hasPerk(PerkLib.ArcaneRegenerationLegendary) && inte >= 125) multimax += 0.2;
				if (hasPerk(PerkLib.ArcaneRegenerationMythical) && inte >= 150) multimax += 0.25;
			}
			if (hasPerk(PerkLib.ManaAffinityI)) multimax += 0.03;
			if (hasPerk(PerkLib.ManaAffinityII)) multimax += 0.03;
			if (hasPerk(PerkLib.ManaAffinityIII)) multimax += 0.03;
			if (hasPerk(PerkLib.ManaAffinityIV)) multimax += 0.03;
			if (hasPerk(PerkLib.ManaAffinityV)) multimax += 0.03;
			if (hasPerk(PerkLib.ManaAffinityVI)) multimax += 0.03;
			if (hasPerk(PerkLib.ZenjisInfluence1)) multimax += 0.1;
			if (hasPerk(PerkLib.ManaCore)) {
				if (hasPerk(PerkLib.Archmage) && inte >= 100) multimax += 0.15;
				if (hasPerk(PerkLib.GrandArchmage) && inte >= 125) multimax += 0.15;
				if (hasPerk(PerkLib.GrandArchmage2ndCircle) && inte >= 150) multimax += 0.15;
				if (hasPerk(PerkLib.GrandArchmage3rdCircle) && inte >= 175) multimax += 0.15;
				if (hasPerk(PerkLib.GrandMage) && inte >= 75) multimax += 0.1;
				//if (hasPerk(PerkLib.GreyArchmage) && inte >= 225) max += 600;
				//if (hasPerk(PerkLib.GreyMage) && inte >= 200) max += 450;
				if (hasPerk(PerkLib.Mage) && inte >= 50) multimax += 0.1;
				if (hasPerk(PerkLib.JobSorcerer)) multimax += 0.1;
			}
			if (hasPerk(PerkLib.AscensionInnerPower)) max += perkv1(PerkLib.AscensionInnerPower) * 120;
			if (jewelryEffectId == JewelryLib.MODIFIER_MP) max += jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_MP) max += jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_MP) max += jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_MP) max += jewelryEffectMagnitude4;
			max += level * 10;
			if (level <= 6) max += level * 10;
			if (hasPerk(PerkLib.UnlockForce)) max += level * 10;
			if (hasPerk(PerkLib.UnlockForce2ndStage)) max += level * 10;
			if (hasPerk(PerkLib.UnlockForce3rdStage)) max += level * 10;
			if (hasPerk(PerkLib.UnlockForce4thStage)) max += level * 10;
			if (hasPerk(PerkLib.AscensionUnlockedPotential2ndStage)) max += level * 12;
			if (hasPerk(PerkLib.AscensionUnlockedPotential4thStage)) max += level * 12;
			if (hasPerk(PerkLib.LimitBreakerSoul1stStage)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerSoul2ndStage)) multimax += 0.1;
			if (hasPerk(PerkLib.DeityJobMunchkin)) multimax += 0.1;
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
			if (hasPerk(PerkLib.ImprovedVenomGland)) maxven += 100;
			if (hasPerk(PerkLib.VenomGlands)) maxven += 25;
			if (hasPerk(PerkLib.VenomGlandsEvolved)) maxven += 100;
			if (hasPerk(PerkLib.VenomGlandsFinalForm)) {
				maxven += 175;
				multimaxven += 1;
			}
			if (hasPerk(PerkLib.JobSoulCultivator)) {
				if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) multimaxven += 0.1;
				if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) multimaxven += 0.15;
				if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) multimaxven += 0.2;
				if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) multimaxven += 0.25;
			}
			if (hasPerk(PerkLib.ArachnidBookLung)) multimaxven += 1;
			if (hasPerk(PerkLib.ArachnidBookLungEvolved)) multimaxven += 1;
			if (hasPerk(PerkLib.ArachnidBookLungFinalForm)) multimaxven += 1;
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
			if (game.player.dragonScore() >= 16) max += 50;
			if (game.player.dragonScore() >= 24) max += 50;
			if (game.player.pigScore() >= 5) max += 10;
			if (game.player.pigScore() >= 10) max += 15;
			if (game.player.pigScore() >= 15) max += 20;
			if (game.player.orcaScore() >= 6) max += 15;
			if (game.player.orcaScore() >= 14) max += 20;
			if (game.player.orcaScore() >= 20) max += 25;
			if (hasPerk(PerkLib.EzekielBlessing)) max += 50;
			if (hasPerk(PerkLib.DisplacerMetabolismEvolved)) max += 50;
			if (hasPerk(PerkLib.ManticoreMetabolismEvolved)) max += 50;
			if (hasPerk(PerkLib.PigBoarFat)) max += 5;
			if (hasPerk(PerkLib.PigBoarFatEvolved)) max += 10;
			if (hasPerk(PerkLib.PigBoarFatFinalForm)) max += 20;
			if (hasPerk(PerkLib.WhaleFat)) max += 5;
			if (hasPerk(PerkLib.WhaleFatEvolved)) max += 10;
			if (hasPerk(PerkLib.WhaleFatFinalForm)) max += 20;
			// (hasPerk(PerkLib.) && game.player.humanScore() < 5) max += 100;
			// jak bedzie mieć chimeryczna nature to kolejny boost to max hunger moze...150 lub nawet 200 ^^
			if (hasPerk(PerkLib.IronStomach)) max += 50;
			if (hasPerk(PerkLib.IronStomachEx)) max += 100;
			if (hasPerk(PerkLib.IronStomachSu)) max += 200;
			// (hasPerk(PerkLib.Overeating)) max += Math.round(level/6);42
			// (hasPerk(PerkLib.Overeating)) max += Math.round(level/3);72
			// (hasPerk(PerkLib.Overeating)) max += level;102
			// (hasPerk(PerkLib.Satiation lub Gluttony)) max += level;nastepny tier
			// (hasPerk(PerkLib.Satiation lub Gluttony)) max += level;nastepny tier
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) max += 20;
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) max += 30;
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) max += 40;
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) max += 50;
			if (max > 2030) max = 2030;//obecnie max to 2030
			return max;
		}


	}

}