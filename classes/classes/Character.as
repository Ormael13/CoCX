package classes
{
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Items.JewelryLib;
import classes.Items.NecklaceLib;
import classes.Scenes.NPCs.Forgefather;

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

		private var _pregnancyTypeList:Array = ['None','Imp','Minotaur','Cockatrice','Mouse','Ovielixer eggs','Hellhound','Centaur','Marble','Bunny','Anemone','Amily','Izma','Spider eggs','Basilisk','Drider eggs','Goo girl','Ember','Benoit Eggs','Satyr','Cotton','Urta','Sand Witch','Frog girl','Faerie','Player','Bee Eggs','Sandtrap Fertilized','Sandtrap','Jojo','Kelt','Taoth','Goo Stuffed','Worm Stuffed','Minerva','Behemoth','Quasi Phoenix','Andy (Satyr)','Alraune','Celess','Goblin','Zenji','Ayane','Ant Eggs','Mantis Eggs','Harpy Eggs','Harpy Egg Hatching','Loppe'];
		public function get pregnancyTypeText():String { return _pregnancyTypeList[_pregnancyType]; }

		private var _pregnancyIncubation:int = 0;
		public function get pregnancyIncubation():int { return _pregnancyIncubation; }

		private var _pregnancy2Type:int = 0;
		public function get pregnancy2Type():int { return _pregnancy2Type; }

		public function get pregnancy2TypeText():String { return _pregnancyTypeList[_pregnancy2Type]; }

		private var _pregnancy2Incubation:int = 0;
		public function get pregnancy2Incubation():int { return _pregnancy2Incubation; }

		private var _buttPregnancyType:int = 0;
		public function get buttPregnancyType():int { return _buttPregnancyType; }
		public function get buttPregnancyTypeText():String { return _pregnancyTypeList[_buttPregnancyType]; }

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



		public function modThickness(goal:Number, strength:int = 1):String
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


	public function hasBeard():Boolean{ return facePart.hasBeard(); }
	public function beard():String{ return facePart.beard(); }
	public function hasMuzzle():Boolean{ return facePart.hasMuzzle(); }
	public function hasBeak():Boolean{ return facePart.hasBeak(); }
	public function face():String { return facePart.describe(); }
	public function faceDesc():String { return facePart.describeMF(); }
	public function faceDescArticle():String { return facePart.describeMF(true); }
	public function hasLongTail():Boolean { return tail.isLong(); }

		public function isPregnant():Boolean { return _pregnancyType > 0 || _pregnancy2Type > 0; }
		public function canGetPregnant():Boolean { return (vaginas.length > 0 && _pregnancyType == 0) || (vaginas.length > 1 && _pregnancy2Type == 0); }
		public function hasVisiblePregnancy():Boolean { return ((pregnancyIncubation > 0 && pregnancyIncubation <= 180) || (pregnancy2Incubation > 0 && pregnancy2Incubation <= 180))}
		public function hasVeryVisiblePregnancy():Boolean { return ((pregnancyIncubation > 0 && pregnancyIncubation <= 100) || (pregnancy2Incubation > 0 && pregnancy2Incubation <= 100))}
		public function hasNonVisiblePregnancy():Boolean { return ((pregnancyIncubation > 180) && (pregnancy2Incubation > 180)) || ((pregnancyIncubation > 180) && (pregnancy2Incubation == 0)) || ((pregnancyIncubation == 0) && (pregnancy2Incubation > 180)) }

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
			var bonus:int = 0;
			//If arg = 1 (always pregnant), bonus = 9000
			if (arg >= 1)
				bonus = 9000;
			if (arg <= -1)
				bonus = -9000;
			//If unpregnant and fertility wins out:
			if (canGetPregnant() && totalFertility() + bonus > Math.floor(Math.random() * beat) && hasVagina())
			{
				var womb:int = (pregnancyIncubation == 0 ? 0:1);
				knockUpForce(type, incubation, womb);
				trace("PC Knocked up with pregnancy type: " + type + " for " + incubation + " incubation.");
				if (flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS]) EngineCore.outputText("\n<b>You are pregnant from "+(womb == 0? pregnancyTypeText:pregnancy2TypeText)+"!</b>");
			}
			//Chance for eggs fertilization - ovi elixir and imps excluded!
			if (type != PregnancyStore.PREGNANCY_IMP && type != PregnancyStore.PREGNANCY_OVIELIXIR_EGGS && type != PregnancyStore.PREGNANCY_ANEMONE)
			{
				if (hasPerk(PerkLib.SpiderOvipositor) || hasPerk(PerkLib.BeeOvipositor) || hasPerk(PerkLib.MantisOvipositor) || hasPerk(PerkLib.AntOvipositor))
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
		public function knockUpForce(type:int = 0, incubation:int = 0, womb:int = 0):void
		{
			if (womb == 0) {
				_pregnancyType = type;
				_pregnancyIncubation = (type == 0 ? 0 : incubation); //Won't allow incubation time without pregnancy type
			} else {
				_pregnancy2Type = type;
				_pregnancy2Incubation = (type == 0 ? 0 : incubation); //Won't allow incubation time without pregnancy type
			}
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
			if (_pregnancy2Incubation > 0) _pregnancy2Incubation--;
			if (_pregnancy2Incubation < 0) _pregnancy2Incubation = 0;
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
				CoC_Settings.error("KeyItem could not be removed because player has no key items.");
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

		public function addKeyValue(keyItemName:String, statusValueNum:Number = 1, newNum:Number = 0):void
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				CoC_Settings.error("Looking for keyitem '" + keyItemName + "' to change value " + statusValueNum + ", and player has no key items.");
				return;
			}
			while (counter > 0)
			{
				counter--;
				//Find it, change it, quit out
				if (keyItems[counter].keyName == keyItemName)
				{
					if (statusValueNum < 1 || statusValueNum > 4)
					{
						CoC_Settings.error("ERROR: AddKeyValue called with invalid key value number.");
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
			CoC_Settings.error("Looking for key item '" + keyItemName + "' to change value " + statusValueNum + ", and player does not have the key item.");
		}

		public function keyItemvX(keyItemName:String, keyValue:int):Number{
			if (keyItems.length <= 0){	//If there's nothing, then it shouldn't be considered an error to report. Code handles it fine.
				trace("ERROR: Looking for keyItem '" + keyItemName + "', and player has no key items.");
				if (CoC.instance.debug){
					EngineCore.outputText("ERROR: Looking for keyItem '" + keyItemName + "', and player has no key items.");
				}
			}
			else{
				var kItem:int = -1;
				var counter:int = keyItems.length
				while (counter > 0){
					counter--;
					if(keyItems[counter].keyName == keyItemName) {
						kItem = counter;
						break;
					}
				}
				if (kItem != -1){
					switch (keyValue){
						case 1:
							return keyItems[kItem].value1;
						case 2:
							return keyItems[kItem].value2;
						case 3:
							return keyItems[kItem].value3;
						case 4:
							return keyItems[kItem].value4;
						default:
							CoC_Settings.error("ERROR: Invalid keyValue requested for item " + keyItemName + ".");
					}
				}
			}
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
			if (hasPerk(PerkLib.GreaterDiehardEx)) {
				min -= maxHP() * 0.18;
				min -= (5400 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (hasPerk(PerkLib.EpicDiehard)) {
				min -= maxHP() * 0.08;
				min -= (2400 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}//nastepny diehard to 10% i 3000 a potem 12% i 3600
			if (perkv1(IMutationsLib.LizanMarrowIM) >= 3) min -= maxHP() * 0.05;
			if (perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 3 || game.player.isRace(Races.ORC)) {
				if (hasPerk(PerkLib.Ferocity)) min -= maxHP() * 0.07;
				if (perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 1) min -= maxHP() * 0.01;
				if (perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 2) min -= maxHP() * 0.02;
				//if (perkv1(IMutationsLib.OrcAdrenalGlandsIM) >= 4) min -= maxHP() * 0.05;
			}
			if (perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 1 && game.player.racialScore(Races.HUMAN) > 17) {
				min -= maxHP() * 0.05;
				if (perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 2) min -= maxHP() * 0.05;
				if (perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 3) min -= maxHP() * 0.15;
				if (perkv1(IMutationsLib.HumanAdrenalGlandsIM) >= 4) min -= maxHP() * 0.25;
			}
			if (hasPerk(PerkLib.Rage)) min -= maxHP() * 0.05;
			if (hasPerk(PerkLib.TooAngryToDie)) min -= maxWrath();
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
			if (hasPerk(PerkLib.SPSurvivalTrainingX)) {
				var limit:Number = perkv1(PerkLib.SPSurvivalTrainingX) * 10;
				var bonus:Number = Math.round((level - 1) / 3);
				if (bonus > limit) bonus = limit;
				min -= (maxHP() * 0.01 * bonus);
			}
			min = Math.round(min);
			return min;
		}

		public override function maxFatigue():Number
		{
			var max:Number = maxFatigueBaseStat.value;
			var multimax:Number = maxFatigueMultStat.value;
			max += maxFatiguePerSpeStat.value*spe;
			if (hasPerk(PerkLib.EromancyBeginner)) max += Math.round(lib);
			if (hasPerk(PerkLib.EromancyExpert)) max += Math.round(lib*2);
			if (hasPerk(PerkLib.EromancyMaster)) max += Math.round(lib * 2);
			if (isGargoyle() && Forgefather.material == "sandstone")
			{
				if (Forgefather.refinement == 0) multimax += (.15);
				if (Forgefather.refinement == 1) multimax += (.25);
				if (Forgefather.refinement == 2 || Forgefather.refinement == 3) multimax += (.35);
				if (Forgefather.refinement == 4) multimax += (.5);
			}
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) max += (150 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) max += (200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) max += (250 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) max += (300 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.AscensionEndurance)) max += perkv1(PerkLib.AscensionEndurance) * 30;
			max += level * maxFatiguePerLevelStat.value;
			if (level <= 6) max += level * maxFatiguePerLevelStat.value;
			else max += 6 * maxFatiguePerLevelStat.value;
			max *= multimax;
			max = Math.round(max);
			if (max > 1499999) max = 1499999;
			return max;
		}

		public override function maxSoulforce():Number
		{
			var max:Number = maxSfBaseStat.value;
			var multimax:Number = maxSfMultStat.value;
			var ratioW:Number = 1;
			if (perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 3) ratioW += 1;
			if (perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 4) ratioW += 1;
			max += maxSfPerWisStat.value*ratioW*wis;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 1) max += 30 * flags[kFLAGS.SOUL_CULTIVATION];//Soul Apprentice
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 4) max += 15 * (flags[kFLAGS.SOUL_CULTIVATION] - 3);//Soul Personage
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 7) max += 15 * (flags[kFLAGS.SOUL_CULTIVATION] - 6);//Soul Warrior
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 10) max += 30 * (flags[kFLAGS.SOUL_CULTIVATION] - 9);//Soul Sprite
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 13) max += 30 * (flags[kFLAGS.SOUL_CULTIVATION] - 12);//Soul Scholar
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 16) max += 30 * (flags[kFLAGS.SOUL_CULTIVATION] - 15);//Soul Grandmaster
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 19) max += 60 * (flags[kFLAGS.SOUL_CULTIVATION] - 18);//Soul Elder
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 23) max += 60 * (flags[kFLAGS.SOUL_CULTIVATION] - 22);//Soul Exalt
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 27) max += 60 * (flags[kFLAGS.SOUL_CULTIVATION] - 26);//Soul Overlord
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 31) max += 90 * (flags[kFLAGS.SOUL_CULTIVATION] - 30);//Soul Tyrant
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 35) max += 90 * (flags[kFLAGS.SOUL_CULTIVATION] - 34);//Soul King
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 39) max += 90 * (flags[kFLAGS.SOUL_CULTIVATION] - 38);//Soul Emperor
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 43) max += 150 * (flags[kFLAGS.SOUL_CULTIVATION] - 42);//Soul Ancestor
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 48) max += 150 * (flags[kFLAGS.SOUL_CULTIVATION] - 47);//Soul Sage
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 53) max += 150 * (flags[kFLAGS.SOUL_CULTIVATION] - 52);//Soul Sovereign
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 58) max += 210 * (flags[kFLAGS.SOUL_CULTIVATION] - 57);//Soul Saint
			//if (flags[kFLAGS.SOUL_CULTIVATION] >= ) max += 210 * (flags[kFLAGS.SOUL_CULTIVATION] - 57);//Soul Paragon
			//if (flags[kFLAGS.SOUL_CULTIVATION] >= ) max += 0 * (flags[kFLAGS.SOUL_CULTIVATION] - 57);//Soul Immortal
			if (hasPerk(PerkLib.FlyingSwordPath)) max += (50 * (1 + perkv1(PerkLib.FlyingSwordPath)));
			if (hasPerk(PerkLib.DemonicLethicite)) max += Math.round(lib);
			if (hasPerk(PerkLib.Metamorph)) max += (50 * (1 + perkv1(PerkLib.Metamorph)));
			if (hasPerk(PerkLib.MetamorphEx)) max += (50 + (100 * perkv1(PerkLib.MetamorphEx)));
			//if (hasPerk(PerkLib.MetamorphMastery)) max += (50 + (100 * perkv1(PerkLib.MetamorphMastery)));
			if (hasPerk(PerkLib.DaoistApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) max += 50;
				if (hasPerk(PerkLib.SoulPersonage)) max += 50;
				if (hasPerk(PerkLib.SoulWarrior)) max += 50;
				multimax += 0.05;
			}
			if (hasPerk(PerkLib.DaoistWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) max += 100;
				if (hasPerk(PerkLib.SoulScholar)) max += 100;
				if (hasPerk(PerkLib.SoulGrandmaster)) max += 100;
				multimax += 0.05;
			}
			if (hasPerk(PerkLib.DaoistElderStage)) {
				if (hasPerk(PerkLib.SoulElder)) max += 200;
				if (hasPerk(PerkLib.SoulExalt)) max += 200;
				if (hasPerk(PerkLib.SoulOverlord)) max += 200;
				multimax += 0.1;
			}
			if (hasPerk(PerkLib.DaoistOverlordStage)) {
				if (hasPerk(PerkLib.SoulTyrant)) max += 300;
				if (hasPerk(PerkLib.SoulKing)) max += 300;
				if (hasPerk(PerkLib.SoulEmperor)) max += 300;
				//if (hasPerk(PerkLib.SoulAncestor)) max += 300;
				multimax += 0.1;
			}
			if (hasPerk(PerkLib.AscensionSoulPurity)) max += perkv1(PerkLib.AscensionSoulPurity) * 50;
			if (jewelryEffectId == JewelryLib.MODIFIER_SF) max += jewelryEffectMagnitude;//+100
			if (jewelryEffectId2 == JewelryLib.MODIFIER_SF) max += jewelryEffectMagnitude2;//+100
			if (jewelryEffectId3 == JewelryLib.MODIFIER_SF) max += jewelryEffectMagnitude3;//+100
			if (jewelryEffectId4 == JewelryLib.MODIFIER_SF) max += jewelryEffectMagnitude4;//+100
			if (necklaceEffectId == NecklaceLib.MODIFIER_SF) max += necklaceEffectMagnitude;//+100	 necklaceName == "soulmetal necklace"
			max += level * ratioW * maxSfPerLevelStat.value;
			if (level <= 6) max += level * ratioW * maxSfPerLevelStat.value;
			else max += 6 * ratioW * maxSfPerLevelStat.value;
			if (isGargoyle() && Forgefather.material == "marble")
			{
				if (Forgefather.refinement == 0) multimax += (.15);
				if (Forgefather.refinement == 1) multimax += (.25);
				if (Forgefather.refinement == 2 || Forgefather.refinement == 3) multimax += (.35);
				if (Forgefather.refinement == 4) multimax += (.5);
			}
			if (hasPerk(PerkLib.HistoryCultivator) || hasPerk(PerkLib.PastLifeCultivator)) multimax += 0.1;
			if (hasPerk(PerkLib.JobSoulCultivator)) {//8005-9005 soulforce na razie przed liczeniem mnożnika jest
				if (hasPerk(PerkLib.Dantain)) {
					if (hasPerk(PerkLib.JobSoulCultivator)) multimax += 0.1;
					if (hasPerk(PerkLib.SoulApprentice)) multimax += 0.1;
					if (hasPerk(PerkLib.SoulPersonage)) multimax += 0.1;
					if (hasPerk(PerkLib.SoulWarrior)) multimax += 0.1;
					if (hasPerk(PerkLib.SoulSprite)) multimax += 0.15;
					if (hasPerk(PerkLib.SoulScholar)) multimax += 0.15;
					if (hasPerk(PerkLib.SoulGrandmaster)) multimax += 0.15;
					if (hasPerk(PerkLib.SoulElder)) multimax += 0.2;
					if (hasPerk(PerkLib.SoulExalt)) multimax += 0.2;
					if (hasPerk(PerkLib.SoulOverlord)) multimax += 0.2;
					if (hasPerk(PerkLib.SoulTyrant)) multimax += 0.25;
					if (hasPerk(PerkLib.SoulKing)) multimax += 0.25;
					if (hasPerk(PerkLib.SoulEmperor)) multimax += 0.25;
					if (hasPerk(PerkLib.SoulAncestor)) multimax += 0.3;
				}
				if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) multimax += 0.1;
				if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) multimax += 0.15;
				if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) multimax += 0.2;
				if (hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) multimax += 0.25;
				if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) multimax += 0.3;
				if (flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] > 0) multimax += (flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]) * 0.01;
				//if (flags[kFLAGS.UNLOCKED_MERIDIANS] > 0) multimax += flags[kFLAGS.UNLOCKED_MERIDIANS] * 0.05;
				//if (hasPerk(PerkLib.Ascension)) multimax += perkv1(PerkLib.Ascension) * 0.01;
			}
			max *= multimax;
			max = Math.round(max);
			if (hasPerk(PerkLib.Soulless) || max < 0) max = 0;
			if (max > 1499999) max = 1499999;
			return max;
		}
		public override function maxOverSoulforce():Number {
			var max1:Number = maxSoulforce();
			var max2:Number = 1;
			if (hasPerk(PerkLib.MunchkinAtWork)) max2 += 0.1;
			if (perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 4) max2 += 0.2;
			max1 *= max2;//~110%
			max1 = Math.round(max1);
			if (max1 > 1699999) max1 = 1699999;
			return max1;
		}

		public override function maxWrath():Number
		{
			var max:Number = maxWrathBaseStat.value;
			var multimax:Number = maxWrathMultStat.value;
			if (hasPerk(PerkLib.AscensionFury)) max += perkv1(PerkLib.AscensionFury) * 100;
			if (jewelryEffectId == JewelryLib.MODIFIER_WR) max += jewelryEffectMagnitude;//+75 to +175
			if (jewelryEffectId2 == JewelryLib.MODIFIER_WR) max += jewelryEffectMagnitude2;//+75 to +175
			if (jewelryEffectId3 == JewelryLib.MODIFIER_WR) max += jewelryEffectMagnitude3;//+75 to +175
			if (jewelryEffectId4 == JewelryLib.MODIFIER_WR) max += jewelryEffectMagnitude4;//+75 to +175
			if (jewelryName == "Undefeated King's Signet" || jewelryName3 == "Undefeated King's Signet") max += 150;
			max += level * maxWrathPerLevelStat.value;
			if (level <= 6) max += level * maxWrathPerLevelStat.value;
			else max += 6 * maxWrathPerLevelStat.value;
			//~194,455
			if (game.player.isRace(Races.ORC)) multimax += 0.2;
			if (vehiclesName == "Giant Slayer Mech") {
				multimax += 0.1;
				//if (upgrade mecha) multimax += 0.1;
				//if (upgrade mecha) multimax += 0.1;
				//if (upgrade mecha) multimax += 0.1;
				//if (upgrade mecha) multimax += 0.1;
			}
			if (isGargoyle() && Forgefather.material == "ebony")
			{
				if (Forgefather.refinement == 0) multimax += (.15);
				if (Forgefather.refinement == 1) multimax += (.25);
				if (Forgefather.refinement == 2 || Forgefather.refinement == 3) multimax += (.35);
				if (Forgefather.refinement == 4) multimax += (.5);
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
			if (hasPerk(PerkLib.AsuraStrength)) max2 += 0.1;
			if (hasPerk(PerkLib.ICastAsuraFist)) max2 += 0.1;
			if (hasPerk(PerkLib.LikeAnAsuraBoss)) max2 += 0.1;
			//
			if (hasPerk(PerkLib.AsuraToughness)) max2 += 0.1;
			//
			if (hasPerk(PerkLib.AsuraSpeed)) max2 += 0.1;
			if (hasPerk(PerkLib.MunchkinAtWork)) max2 += 0.1;
			max1 *= max2;//~180%
			max1 = Math.round(max1);//~857 546,5
			if (max1 > 859999) max1 = 859999;
			return max1;
		}
		public function maxSafeWrathMagicalAbilities():Number {
			var max1:Number = 0;
			if (hasPerk(PerkLib.ICastAsuraFist)) max1 += maxOverWrath();
			else max1 += maxWrath();
			var max2:Number = 0.75;
			if (flags[kFLAGS.GAME_DIFFICULTY] < 2 || necklaceName == "Wrathless") max2 += 0.25;
			max1 *= max2;
			max1 = Math.round(max1);
			return max1;
		}
		public function maxSafeWrathSpellcasting():Number {
			var max1:Number = 0;
			if (hasPerk(PerkLib.ICastAsuraFist)) max1 += maxOverWrath();
			else max1 += maxWrath();
			var max2:Number = 0.5;
			if (flags[kFLAGS.GAME_DIFFICULTY] < 2 || necklaceName == "Wrathless") max2 += 0.5;
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
			var max:Number = maxManaBaseStat.value;
			var multimax:Number = maxManaMultStat.value;
			max += maxManaPerIntStat.value*inte;
			max += maxManaPerWisStat.value*wis;
			if (hasPerk(PerkLib.Archmage) && inte >= 100) max += 180;
			if (hasPerk(PerkLib.ArchmageEx) && inte >= 100) max += 600;
			if (hasPerk(PerkLib.Channeling) && inte >= 60) max += 90;
			if (hasPerk(PerkLib.GrandArchmage) && inte >= 125) max += 225;
			if (hasPerk(PerkLib.GrandArchmage2ndCircle) && inte >= 150) max += 270;
			if (hasPerk(PerkLib.GrandArchmage3rdCircle) && inte >= 175) max += 315;
			if (hasPerk(PerkLib.GrandGreyArchmage) && inte >= 225) max += 600;
			if (hasPerk(PerkLib.GrandGreyArchmage2ndCircle) && inte >= 275) max += 900;
			if (hasPerk(PerkLib.GrandMage) && inte >= 75) max += 135;
			if (hasPerk(PerkLib.GreyArchmage) && inte >= 175) max += 450;
			if (hasPerk(PerkLib.GreyMage) && inte >= 125) max += 300;
			if (hasPerk(PerkLib.GreyMageApprentice) && inte >= 75) max += 150;
			if (hasPerk(PerkLib.Mage) && inte >= 50) max += 90;
			if (hasPerk(PerkLib.JobSorcerer)) max += 45;
			if (hasPerk(PerkLib.JobHealer)) max += 90;
			if (hasPerk(PerkLib.Spellpower) && inte >= 50) max += 45;
			if (hasPerk(PerkLib.SpellpowerGrey) && inte >= 50) max += 75;
			if (hasPerk(PerkLib.SpellpowerHealing) && wis >= 50) max += 90;
			if (hasPerk(PerkLib.EromancyBeginner)) max += Math.round(inte*3);
			if (hasPerk(PerkLib.EromancyExpert)) max += Math.round(inte*3);
			if (hasPerk(PerkLib.EromancyMaster)) max += Math.round(inte*6);
			if (hasPerk(PerkLib.HistoryScholar) || hasPerk(PerkLib.PastLifeScholar)) multimax += 0.1;
			if (hasPerk(PerkLib.ArcaneRegenerationMinor) && inte >= 50) {
				multimax += 0.05;
				if (hasPerk(PerkLib.ArcaneRegenerationMajor) && inte >= 75) multimax += 0.1;
				if (hasPerk(PerkLib.ArcaneRegenerationEpic) && inte >= 100) multimax += 0.15;
				if (hasPerk(PerkLib.ArcaneRegenerationLegendary) && inte >= 125) multimax += 0.2;
				if (hasPerk(PerkLib.ArcaneRegenerationMythical) && inte >= 150) multimax += 0.25;
			}
			if (hasPerk(PerkLib.ManaCore)) {
				if (hasPerk(PerkLib.Archmage) && inte >= 100) multimax += 0.15;
				if (hasPerk(PerkLib.ArchmageEx) && inte >= 100) multimax += 0.5;
				if (hasPerk(PerkLib.GrandArchmage) && inte >= 125) multimax += 0.15;
				if (hasPerk(PerkLib.GrandArchmage2ndCircle) && inte >= 150) multimax += 0.15;
				if (hasPerk(PerkLib.GrandArchmage3rdCircle) && inte >= 175) multimax += 0.15;
				if (hasPerk(PerkLib.GrandGreyArchmage) && inte >= 225) multimax += 0.25;
				if (hasPerk(PerkLib.GrandGreyArchmage2ndCircle) && inte >= 275) multimax += 0.3;
				if (hasPerk(PerkLib.GrandMage) && inte >= 75) multimax += 0.1;
				if (hasPerk(PerkLib.GreyArchmage) && inte >= 175) multimax += 0.2;
				if (hasPerk(PerkLib.GreyMage) && inte >= 125) multimax += 0.15;
				if (hasPerk(PerkLib.GreyMageApprentice) && inte >= 75) multimax += 0.1;
				if (hasPerk(PerkLib.Mage) && inte >= 50) multimax += 0.1;
				if (hasPerk(PerkLib.JobSorcerer)) multimax += 0.1;
			}
			if (isGargoyle() && Forgefather.material == "alabaster")
			{
				if (Forgefather.refinement == 0) multimax += (.15);
				if (Forgefather.refinement == 1) multimax += (.25);
				if (Forgefather.refinement == 2 || Forgefather.refinement == 3) multimax += (.35);
				if (Forgefather.refinement == 4) multimax += (.5);
			}
			if (hasPerk(PerkLib.AscensionInnerPower)) max += perkv1(PerkLib.AscensionInnerPower) * 120;
			if (jewelryEffectId == JewelryLib.MODIFIER_MP) max += jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_MP) max += jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_MP) max += jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_MP) max += jewelryEffectMagnitude4;
			max += level * maxManaPerLevelStat.value;
			if (level <= 6) max += level * maxManaPerLevelStat.value;
			else max += 6 * maxManaPerLevelStat.value;
			max *= multimax;
			max = Math.round(max);
			if (max < 0) max = 0;
			if (max > 2499999) max = 2499999;
			return max;
		}
		public override function maxOverMana():Number {
			var max1:Number = maxMana();
			var max2:Number = 1;
			if (hasPerk(PerkLib.PrestigeJobGreySage)) max2 += 0.1;
			if (hasPerk(PerkLib.Equilibrium)) max2 += 0.1;
			if (hasPerk(PerkLib.GreySageIntelligence)) max2 += 0.1;
			if (hasPerk(PerkLib.HyperCasting)) max2 += 0.1;
			if (hasPerk(PerkLib.MunchkinAtWork)) max2 += 0.1;
			max1 *= max2;//~130%
			max1 = Math.round(max1);
			if (max1 > 3299999) max1 = 3299999;
			return max1;
		}

		public function maxVenom():Number
		{
			var maxven:Number = 0;
			var multimaxven:Number = 1;
			if (CoC.instance.transformations.FaceSnakeFangs.isPresent()) maxven += 200;
			if (CoC.instance.transformations.FaceSpiderFangs.isPresent()) maxven += 200;
			if (CoC.instance.transformations.FaceJabberwocky.isPresent()) maxven += 200;
			if (game.player.tailType == Tail.BEE_ABDOMEN) maxven += 300;
			if (game.player.tailType == Tail.SPIDER_ADBOMEN) maxven += 300;
			if (game.player.tailType == Tail.SCORPION) maxven += 300;
			if (game.player.tailType == Tail.MANTICORE_PUSSYTAIL) maxven += 400;
			if (game.player.lowerBody == LowerBody.HYDRA) maxven += 400;
			if (game.player.lowerBody == LowerBody.SANDWORM) maxven += 400;
			if (game.player.lowerBody == LowerBody.ATLACH_NACHA) maxven += 1200;
			if (hasPerk(PerkLib.ImprovedVenomGland)) maxven += 100;
			if (hasPerk(PerkLib.ImprovedVenomGlandEx)) maxven += 200;
			if (hasPerk(PerkLib.ImprovedVenomGlandSu)) maxven += 400;
			if (perkv1(IMutationsLib.VenomGlandsIM) >= 1) maxven += 100;
			if (perkv1(IMutationsLib.VenomGlandsIM) >= 2) maxven += 400;
			if (perkv1(IMutationsLib.VenomGlandsIM) >= 3) {
				maxven += 700;
				multimaxven += 1;
			}
			if (perkv1(IMutationsLib.VenomGlandsIM) >= 4) {
				maxven += 1000;
				multimaxven += 1.5;
			}
			if (hasPerk(PerkLib.VenomousAdiposeTissue)) {
				if (tou > 20000) maxven += 1000;
				else if (tou > 10000) maxven += 900;
				else if (tou > 5000) maxven += 800;
				else if (tou > 2000) maxven += 700;
				else if (tou > 1000) maxven += 600;
				else if (tou > 500) maxven += 500;
				else if (tou > 200) maxven += 400;
				else if (tou > 100) maxven += 300;
				else if (tou > 50) maxven += 200;
				else maxven += 100;
				if (thickness > 150) maxven += 200;
				else if (thickness > 100) maxven += 150;
				else if (thickness > 50) maxven += 100;
				else maxven += 50;
			}
			if (hasPerk(PerkLib.JobSoulCultivator)) {
				if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) multimaxven += 0.1;
				if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) multimaxven += 0.15;
				if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) multimaxven += 0.2;
				if (hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) multimaxven += 0.25;
				if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) multimaxven += 0.3;
			}
			if (perkv1(IMutationsLib.ArachnidBookLungIM) > 0) multimaxven += perkv1(IMutationsLib.ArachnidBookLungIM);
			if (game.player.hasKeyItem("Sky Poison Pearl") >= 0) maxven += 300;
			if (hasPerk(PerkLib.AscensionSkyPoisonPearlMasteryStageX)) multimaxven += perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX);
			maxven *= multimaxven;
			maxven = Math.round(maxven);
			return maxven;
		}

		public function maxHunger():Number
		{
			var max:Number = 100;
			var tier:int;
			if (hasPerk(PerkLib.JobSoulCultivator)) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 1) max += 20 * flags[kFLAGS.SOUL_CULTIVATION];//Soul Apprentice
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 4) max += 1 * (flags[kFLAGS.SOUL_CULTIVATION] - 3);//Soul Personage
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 7) max += 1 * (flags[kFLAGS.SOUL_CULTIVATION] - 6);//Soul Warrior
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 10) max += 2 * (flags[kFLAGS.SOUL_CULTIVATION] - 9);//Soul Sprite
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 13) max += 2 * (flags[kFLAGS.SOUL_CULTIVATION] - 12);//Soul Scholar
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 16) max += 2 * (flags[kFLAGS.SOUL_CULTIVATION] - 15);//Soul Grandmaster
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 19) max += 4 * (flags[kFLAGS.SOUL_CULTIVATION] - 18);//Soul Elder
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 23) max += 4 * (flags[kFLAGS.SOUL_CULTIVATION] - 22);//Soul Exalt
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 27) max += 4 * (flags[kFLAGS.SOUL_CULTIVATION] - 26);//Soul Overlord
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 31) max += 6 * (flags[kFLAGS.SOUL_CULTIVATION] - 30);//Soul Tyrant
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 35) max += 6 * (flags[kFLAGS.SOUL_CULTIVATION] - 34);//Soul King
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 39) max += 6 * (flags[kFLAGS.SOUL_CULTIVATION] - 38);//Soul Emperor
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 43) max += 8 * (flags[kFLAGS.SOUL_CULTIVATION] - 42);//Soul Ancestor
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 48) max += 8 * (flags[kFLAGS.SOUL_CULTIVATION] - 47);//Soul Sage
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 53) max += 8 * (flags[kFLAGS.SOUL_CULTIVATION] - 52);//Soul Sovereign
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 58) max += 10 * (flags[kFLAGS.SOUL_CULTIVATION] - 57);//Soul Saint
			//if (flags[kFLAGS.SOUL_CULTIVATION] >= ) max += 10 * (flags[kFLAGS.SOUL_CULTIVATION] - );//Soul Paragon
			//if (flags[kFLAGS.SOUL_CULTIVATION] >= ) max += 10 * (flags[kFLAGS.SOUL_CULTIVATION] - );//Soul Immortal
			tier = game.player.racialTier(Races.DRAGON);
			if (tier == 1) max += 50;
			else if (tier == 2) max += 100;
			else if (tier >= 3) max += 150;
			tier = game.player.racialTier(Races.PIG);
			if (tier == 1) max += 25;
			else if (tier >= 2) max += 45;
			tier = game.player.racialTier(Races.ORCA);
			if (tier == 1) max += 35;
			else if (tier >= 2) max += 60;
			tier = game.player.racialTier(Races.ABYSSAL_SHARK);
			if (tier == 1) max += 150;
			else if (tier == 2) max += 300;
			else if (tier >= 3) max += 450;
			if (hasPerk(PerkLib.EzekielBlessing)) max += 50;
			if (perkv1(IMutationsLib.DisplacerMetabolismIM) >= 2) max += 50;
			if (perkv1(IMutationsLib.ManticoreMetabolismIM) >= 2) max += 50;
			if (perkv1(IMutationsLib.PigBoarFatIM) >= 1) max += 5;
			if (perkv1(IMutationsLib.PigBoarFatIM) >= 2) max += 10;
			if (perkv1(IMutationsLib.PigBoarFatIM) >= 3) max += 20;
			if (perkv1(IMutationsLib.WhaleFatIM) >= 1) max += 5;
			if (perkv1(IMutationsLib.WhaleFatIM) >= 2) max += 10;
			if (perkv1(IMutationsLib.WhaleFatIM) >= 3) max += 20;
			if (perkv1(IMutationsLib.HumanFatIM) >= 3 && game.player.racialScore(Races.HUMAN) > 17) max += 50;
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
			if (hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) max += 50;
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) max += 60;
			if (max > 3370) max = 3370;//obecnie max to 3378
			return max;
		}
	}
}
