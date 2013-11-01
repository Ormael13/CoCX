//CoC Creature.as
package classes
{
	//import classes.cockClass;
	import classes.Cock;
	import classes.vaginaClass;
	import classes.breastRowClass;
	import classes.assClass;
	import classes.perkClass;
	import classes.statusAffectClass;
	import classes.keyItemClass;
	
	public class creature
	{	
		//Variables
		
		//Short refers to player name and monster name. BEST VARIABLE NAME EVA!
		//"a" refers to how the article "a" should appear in text. 
		public var short:String = "You";
		public var a:String = "a ";
		
		//Clothing/Armor
		public var armorName:String = "";
		public var weaponName:String = "";
		public var weaponVerb:String = "";
		public var armorDef:Number = 0;
		public var armorPerk:String = "";
		public var weaponAttack:Number = 0;
		public var weaponPerk:String = "";
		public var weaponValue:Number = 0;
		public var armorValue:Number = 0;
		
		//Primary stats
		public var str:Number = 0;
		public var tou:Number = 0;
		public var spe:Number = 0;
		public var inte:Number = 0;
		public var lib:Number = 0;
		public var sens:Number = 0;
		public var cor:Number = 0;
		public var fatigue:Number = 0;
		
		//Combat Stats
		public var HP:Number = 0;
		public var lust:Number = 0;		
		
		//Level Stats
		public var XP:Number = 0;
		public var level:Number = 0;
		public var gems:Number = 0;
				
		//Appearance Variables
		//Gender 1M, 2F, 3H
		public var gender:Number = 0;
		public var tallness:Number = 0;
		
		/*Hairtype
		0- normal
		1- feather
		2- ghost
		3- goo!
		4- anemononeoenoeneo!*/
		public var hairType:Number = 0;
		public var hairColor:String = "no";
		public var hairLength:Number = 0;
		
		/*Skintype
		0 - skin
		1 - furry
		2 - scaley
		3 - goopey*/
		public var skinType:Number = 0;
		public var skinTone:String = "albino";
		public var skinDesc:String = "skin";
		public var skinAdj:String = "";
		
/*		Facetype:
		0 - human
		1 - horse
		2 - dogface
		3 - cowface
		4 - sharkface-teeth
		5 - Human w/Naga fangz
		6 - kittah face
		7 - lizard face (durned argonians!)
		8 - bunnah faceahhh bunbun
		9 - kangaface
		10 - spidah-face (humanish)
		11 - foxface!
		12 - dragon face
		13 - Halfcoon
		14 - fullcoon
		15 - halfmouse
		16 - fullmouse*/
		public var faceType:Number = 0;
		
		/*EarType
		-1 - none!
		0 - human
		1 - horse
		2 - dog
		3 - cow
		4 - elf
		5 - catzilla
		6 - Snakezilla
		7 - Bunbunz
		8 - Roo Ears
		9 - fox ears
		10 - dragon
		11 - coon
		12 - mouse*/
		public var earType:Number = 0;
		public var earValue:Number = 0;
		
		/*Horntype
		1 - demonic
		2 - minotaur (cowlike)
		3 - Draconic/Lizard
		4 - Double draconic
		5 - Antlers*/
		public var hornType:Number = 0;
		
		/*Wingtype
		0 - none
		1 - bee
		2 - large bee
		3 - faerie?
		4 - avian
		5 - dragoooon?
		6 - demon/bat
		7 - large demon/bat
		8 - shark wing lolololol
		9 - harpy
		10 - small dagron
		11 - trogdor wings
		12 - sandtrap wings*/
		public var wingType:Number = 0;
		public var wingDesc:String = "non-existant";
		
		/* lowerBody:
		0 - normal
		1 - hooves
		2 - paws
		3 - snakelike body
		4 - centaur!
		5 - demonic heels
		6 - demon foot-claws
		7 - bee legs
		8 - goo mound
		9 - catfeet
		10 - lizardfeet
		11 - MLP.
		12 - DAH BUNNY!
		13 - Harpah Legz
		14 - Roo feet!
		15 - Spider Legz
		16 - Drider Legs
		17 - foxpaws
		18 - dragonfeet
		19 - raccoonfeet*/
		public var lowerBody:Number = 0;
		
		/*tailType:
		0 - none
		1 - horse
		2 - dog
		3 - demon
		4 - cow!
		5 - spider!
		6 - bee!
		7 - shark tail!
		8 - catTAIIIIIL
		9 - lizard tail
		10 - bunbuntail
		11 - harpybutt
		12 - rootail
		13 - foxtail
		14 - dagron tail
		15 - raccoon tail
		16 - mousetail*/
		public var tailType:Number = 0;
		
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		public var tailVenom:Number = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		public var tailRecharge:Number = 5;
		
		/*hipRating
		0 - boyish
		2 - slender
		4 - average
		6 - noticable/ample
		10 - curvy//flaring
		15 - child-bearing/fertile
		20 - inhumanly wide*/
		public var hipRating:Number = 0;
		
		/*buttRating
		0 - buttless
		2 - tight
		4 - average
		6 - noticable
		8 - large
		10 - jiggly
		13 - expansive
		16 - huge
		20 - inconceivably large/big/huge etc*/
		public var buttRating:Number = 0;
		
		//Piercings
		//TODO: Pull this out into it's own class and enum.
		public var nipplesPierced:Number = 0;
		public var nipplesPShort:String = "";
		public var nipplesPLong:String = "";
		public var lipPierced:Number = 0;
		public var lipPShort:String = "";
		public var lipPLong:String = "";
		public var tonguePierced:Number = 0;
		public var tonguePShort:String = "";
		public var tonguePLong:String = "";
		public var eyebrowPierced:Number = 0;
		public var eyebrowPShort:String = "";
		public var eyebrowPLong:String = "";
		public var earsPierced:Number = 0;
		public var earsPShort:String = "";
		public var earsPLong:String = "";
		public var nosePierced:Number = 0;
		public var nosePShort:String = "";
		public var nosePLong:String = "";
		
		//Sexual Stuff		
		//MALE STUFF
		//public var cocks:Array;
		//TODO: Tuck away into Male genital class?
		public var cocks:Vector.<Cock>;
		//balls
		public var balls:Number = 0;
		public var cumMultiplier:Number = 1;
		public var ballSize:Number = 0;
		public var hoursSinceCum:Number = 0;
		
		//FEMALE STUFF
		//TODO: Box into Female genital class?
		public var vaginas:Array;
		//Fertility is a % out of 100. 
		public var fertility:Number = 10;
		public var clitLength:Number = .5;
		public var nippleLength:Number = .25;
		public var breastRows:Array;
		public var ass:assClass = new assClass();		
		
		//Monsters have few perks, which I think should be a status effect for clarity's sake.
		//TODO: Move perks into monster status effects.
		public var perks:Array;
		//Current status effects. This has got very muddy between perks and status effects. Will have to look into it.
		//Someone call the grammar police!
		//TODO: Move monster status effects into perks. Needs investigation though.
		public var statusAffects:Array;
		
		//Constructor
		public function creature()
		{
			//cocks = new Array();
			//The world isn't ready for typed Arrays just yet.
			cocks = new Vector.<Cock>();
			vaginas = new Array();
			//vaginas: Vector.<Vagina> = new Vector.<Vagina>();
			breastRows = new Array();
			perks = new Array();
			statusAffects = new Array();
			//keyItems = new Array();
		}
		
		//Functions			
		//Create a perk
		public function createPerk(keyName:String, value1:Number, value2:Number, value3:Number, value4:Number, desc:String = ""):void
		{
			var newKeyItem:perkClass = new perkClass();
			//used to denote that the array has already had its new spot pushed on.
			var arrayed:Boolean = false;
			//used to store where the array goes
			var keySlot:Number = 0
			var counter:Number = 0
			//Start the array if its the first bit
			if (perks.length == 0)
			{
				//trace("New Perk Started Array! " + keyName);
				perks.push(newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//If it belongs at the end, push it on
			if (perks[perks.length - 1].perkName < keyName && !arrayed)
			{
				//trace("New Perk Belongs at the end!! " + keyName);
				perks.push(newKeyItem);
				arrayed = true;
				keySlot = perks.length - 1;
			}
			//If it belongs in the beginning, splice it in
			if (perks[0].perkName > keyName && !arrayed)
			{
				//trace("New Perk Belongs at the beginning! " + keyName);
				perks.splice(0, 0, newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//Find the spot it needs to go in and splice it in.
			if (!arrayed)
			{
				//trace("New Perk using alphabetizer! " + keyName);
				counter = perks.length;
				while (counter > 0 && !arrayed)
				{
					counter--;
					//If the current slot is later than new key
					if (perks[counter].perkName > keyName)
					{
						//If the earlier slot is earlier than new key && a real spot
						if (counter - 1 >= 0)
						{
							//If the earlier slot is earlier slot in!
							if (perks[counter - 1].perkName <= keyName)
							{
								arrayed = true;
								perks.splice(counter, 0, newKeyItem);
								keySlot = counter;
							}
						}
						//If the item after 0 slot is later put here!
						else
						{
							//If the next slot is later we are go
							if(perks[counter].perkName <= keyName) {
								arrayed = true;
								perks.splice(counter, 0, newKeyItem);
								keySlot = counter;
							}
						}
					}
				}
			}
			//Fallback
			if (!arrayed)
			{
				//trace("New Perk Belongs at the end!! " + keyName);
				perks.push(newKeyItem);
				arrayed = true;
				keySlot = perks.length - 1;
			}
			
			perks[keySlot].perkName = keyName;
			perks[keySlot].value1 = value1;
			perks[keySlot].value2 = value2;
			perks[keySlot].value3 = value3;
			perks[keySlot].value4 = value4;
			perks[keySlot].perkDesc = desc;
			//trace("NEW PERK FOR PLAYER in slot " + keySlot + ": " + perks[keySlot].perkName);
		}
		
		//Remove perk
		public function removePerk(perkName:String):void
		{
			var counter:Number = perks.length;
			//Various Errors preventing action
			if (perks.length <= 0)
			{
				//trace("ERROR: Perk could not be removed because player has no perks.");
				return;
			}
			while (counter > 0)
			{
				counter--;
				if (perks[counter].perkName == perkName)
				{
					perks.splice(counter, 1);
					//trace("Attempted to remove \"" + perkName + "\" perk.");
					counter = 0;
				}
			}
		}
		
		//has perk?
		public function hasPerk(perkName:String):Number
		{
			var counter:Number = perks.length;
			if (perks.length <= 0)
				return -2;
			while (counter > 0)
			{
				counter--;
				if (perks[counter].perkName == perkName)
					return counter;
			}
			return -1;
		}
		
		//Duplicate perk
		//Deprecated?
		public function perkDuplicated(perkName:String):Boolean
		{
			var counter:Number = perks.length;
			var timesFound:int = 0;
			if (perks.length <= 0)
				return false;
			while (counter > 0)
			{
				counter--;
				if (perks[counter].perkName == perkName)
					timesFound++;
			}
			return (timesFound > 1);
		}
		
		//remove all perks
		public function removePerks():void
		{
			var counter:Number = perks.length;
			while (counter > 0)
			{
				counter--;
				perks.splice(counter, 1);
			}
		}
		
		public function addPerkValue(statusName:String, statusValueNum:Number = 1, newNum:Number = 0)
		{
			var counter:Number = perks.length;
			//Various Errors preventing action
			if (perks.length <= 0)
			{
				return;
					//trace("ERROR: Looking for perk '" + statusName + "' to change value " + statusValueNum + ", and player has no perks.");
			}
			while (counter > 0)
			{
				counter--;
				//Find it, change it, quit out
				if (perks[counter].perkName == statusName)
				{
					if (statusValueNum < 1 || statusValueNum > 4)
					{
						//trace("ERROR: ChangePerkValue called with invalid perk value number.");
						return;
					}
					if (statusValueNum == 1)
						perks[counter].value1 += newNum;
					if (statusValueNum == 2)
						perks[counter].value2 += newNum;
					if (statusValueNum == 3)
						perks[counter].value3 += newNum;
					if (statusValueNum == 4)
						perks[counter].value4 += newNum;
					return;
				}
			}
			//trace("ERROR: Looking for perk '" + statusName + "' to change value " + statusValueNum + ", and player does not have the perk.");
			return;
		}
		
		public function changePerkValue(statusName:String, statusValueNum:Number = 1, newNum:Number = 0)
		{
			var counter:Number = perks.length;
			//Various Errors preventing action
			if (perks.length <= 0)
			{
				return;
					//trace("ERROR: Looking for perk '" + statusName + "' to change value " + statusValueNum + ", and player has no perks.");
			}
			while (counter > 0)
			{
				counter--;
				//Find it, change it, quit out
				if (perks[counter].perkName == statusName)
				{
					if (statusValueNum < 1 || statusValueNum > 4)
					{
						//trace("ERROR: ChangePerkValue called with invalid perk value number.");
						return;
					}
					if (statusValueNum == 1)
						perks[counter].value1 = newNum;
					if (statusValueNum == 2)
						perks[counter].value2 = newNum;
					if (statusValueNum == 3)
						perks[counter].value3 = newNum;
					if (statusValueNum == 4)
						perks[counter].value4 = newNum;
					return;
				}
			}
			//trace("ERROR: Looking for perk '" + statusName + "' to change value " + statusValueNum + ", and player does not have the perk.");
			return;
		}
		
		public function perkv1(statusName:String):Number
		{
			var counter:Number = perks.length;
			//Various Errors preventing action
			if (perks.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for perk '" + statusName + "', and player has no perks.");
			}
			while (counter > 0)
			{
				counter--;
				if (perks[counter].perkName == statusName)
					return perks[counter].value1;
			}
			//trace("ERROR: Looking for perk '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function perkv2(statusName:String):Number
		{
			var counter:Number = perks.length;
			//Various Errors preventing action
			if (perks.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for perk '" + statusName + "', and player has no perks.");
			}
			while (counter > 0)
			{
				counter--;
				if (perks[counter].perkName == statusName)
					return perks[counter].value2;
			}
			//trace("ERROR: Looking for perk '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function perkv3(statusName:String):Number
		{
			var counter:Number = perks.length;
			//Various Errors preventing action
			if (perks.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for perk '" + statusName + "', and player has no perks.");
			}
			while (counter > 0)
			{
				counter--;
				if (perks[counter].perkName == statusName)
					return perks[counter].value3;
			}
			//trace("ERROR: Looking for perk '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function perkv4(statusName:String):Number
		{
			var counter:Number = perks.length;
			//Various Errors preventing action
			if (perks.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for perk '" + statusName + "', and player has no perks.");
			}
			while (counter > 0)
			{
				counter--;
				if (perks[counter].perkName == statusName)
					return perks[counter].value4;
			}
			//trace("ERROR: Looking for perk '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		//{region StatusEffects
		//Create a status
		public function createStatusAffect(statusName:String, value1:Number, value2:Number, value3:Number, value4:Number):void
		{
			var newStatusAffect = new statusAffectClass();
			statusAffects.push(newStatusAffect);
			statusAffects[statusAffects.length - 1].statusAffectName = statusName;
			statusAffects[statusAffects.length - 1].value1 = value1;
			statusAffects[statusAffects.length - 1].value2 = value2;
			statusAffects[statusAffects.length - 1].value3 = value3;
			statusAffects[statusAffects.length - 1].value4 = value4;
			//trace("NEW STATUS APPLIED TO PLAYER!: " + statusName);
		}
		
		//Remove a status
		public function removeStatusAffect(statusName:String):void
		{
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if (statusAffects.length <= 0)
			{
				//trace("ERROR: Status Affect could not be removed because player has no statuses.");
				return;
			}
			while (counter > 0)
			{
				counter--;
				if (statusAffects[counter].statusAffectName == statusName)
				{
					statusAffects.splice(counter, 1);
					//trace("Attempted to remove \"" + statusName + "\" status.");
					counter = 0;
				}
			}
		}
		
		
		public function hasStatusAffect(statusName:String):Number
		{
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if (statusAffects.length <= 0)
				return -2;
			while (counter > 0)
			{
				counter--;
				if (statusAffects[counter].statusAffectName == statusName)
					return counter;
			}
			return -1;
		}
		//}endregion
		
		
		public function changeStatusValue(statusName:String, statusValueNum:Number = 1, newNum:Number = 0)
		{
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if (statusAffects.length <= 0)
			{
				return;
					//trace("ERROR: Looking for status '" + statusName + "' to change value " + statusValueNum + ", and player has no status affects.");
			}
			while (counter > 0)
			{
				counter--;
				//Find it, change it, quit out
				if (statusAffects[counter].statusAffectName == statusName)
				{
					if (statusValueNum < 1 || statusValueNum > 4)
					{
						//trace("ERROR: ChangeStatusValue called with invalid status value number.");
						return;
					}
					if (statusValueNum == 1)
						statusAffects[counter].value1 = newNum;
					if (statusValueNum == 2)
						statusAffects[counter].value2 = newNum;
					if (statusValueNum == 3)
						statusAffects[counter].value3 = newNum;
					if (statusValueNum == 4)
						statusAffects[counter].value4 = newNum;
					return;
				}
			}
			//trace("ERROR: Looking for status '" + statusName + "' to change value " + statusValueNum + ", and player does not have the status affect.");
			return;
		}
		
		public function addStatusValue(statusName:String, statusValueNum:Number = 1, newNum:Number = 0)
		{
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if (statusAffects.length <= 0)
			{
				return;
					//trace("ERROR: Looking for status '" + statusName + "' to change value " + statusValueNum + ", and player has no status affects.");
			}
			while (counter > 0)
			{
				counter--;
				//Find it, change it, quit out
				if (statusAffects[counter].statusAffectName == statusName)
				{
					if (statusValueNum < 1 || statusValueNum > 4)
					{
						//trace("ERROR: ChangeStatusValue called with invalid status value number.");
						return;
					}
					if (statusValueNum == 1)
						statusAffects[counter].value1 += newNum;
					if (statusValueNum == 2)
						statusAffects[counter].value2 += newNum;
					if (statusValueNum == 3)
						statusAffects[counter].value3 += newNum;
					if (statusValueNum == 4)
						statusAffects[counter].value4 += newNum;
					return;
				}
			}
			//trace("ERROR: Looking for status '" + statusName + "' to change value " + statusValueNum + ", and player does not have the status affect.");
			return;
		}
		
		public function statusAffectv1(statusName:String):Number
		{
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if (statusAffects.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for status '" + statusName + "', and player has no status affects.");
			}
			while (counter > 0)
			{
				counter--;
				if (statusAffects[counter].statusAffectName == statusName)
					return statusAffects[counter].value1;
			}
			//trace("ERROR: Looking for status '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function statusAffectv2(statusName:String):Number
		{
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if (statusAffects.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for status '" + statusName + "', and player has no status affects.");
			}
			while (counter > 0)
			{
				counter--;
				if (statusAffects[counter].statusAffectName == statusName)
					return statusAffects[counter].value2;
			}
			//trace("ERROR: Looking for status '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function statusAffectv3(statusName:String):Number
		{
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if (statusAffects.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for status '" + statusName + "', and player has no status affects.");
			}
			while (counter > 0)
			{
				counter--;
				if (statusAffects[counter].statusAffectName == statusName)
					return statusAffects[counter].value3;
			}
			//trace("ERROR: Looking for status '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function statusAffectv4(statusName:String):Number
		{
			var counter:Number = statusAffects.length;
			//Various Errors preventing action
			if (statusAffects.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for status '" + statusName + "', and player has no status affects.");
			}
			while (counter > 0)
			{
				counter--;
				if (statusAffects[counter].statusAffectName == statusName)
					return statusAffects[counter].value4;
			}
			//trace("ERROR: Looking for status '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function removeStatuses():void
		{
			var counter:Number = statusAffects.length;
			while (counter > 0)
			{
				counter--;
				statusAffects.splice(counter, 1);
			}
		}		
		
		public function biggestTitSize():Number
		{
			if (breastRows.length == 0)
				return -1;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (breastRows[index].breastRating < breastRows[counter].breastRating)
					index = counter;
			}
			return breastRows[index].breastRating;
		}
		
		public function cockArea(cockNum:Number):Number
		{
			if (cockNum >= cocks.length || cockNum < 0)
				return 0;
			return (cocks[cockNum].cockThickness * cocks[cockNum].cockLength);
		}
		
		public function biggestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			return cocks[biggestCockIndex()].cockLength;
		}
		
		public function biggestCockArea():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			return cockArea(index);
		}
		
		//Find the second biggest dick and it's area.
		public function biggestCockArea2():Number
		{
			if (cocks.length <= 1)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = -1;
			//Find the biggest
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//Is this spot claimed by the biggest?
				if (counter != index)
				{
					//Not set yet?
					if (index2 == -1)
						index2 = counter;
					//Is the stored value less than the current one?
					if (cockArea(index2) < cockArea(counter))
					{
						index2 = counter;
					}
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2)
				return 0;
			return cockArea(index2);
		}
		
		public function longestCock():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockLength < cocks[counter].cockLength)
					index = counter;
			}
			return index;
		}
		
		public function longestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockLength < cocks[counter].cockLength)
					index = counter;
			}
			return cocks[index].cockLength;
		}
		
		public function longestHorseCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if ((cocks[index].cockType != CockTypesEnum.HORSE && cocks[counter].cockType == CockTypesEnum.HORSE) || (cocks[index].cockLength < cocks[counter].cockLength && cocks[counter].cockType == CockTypesEnum.HORSE))
					index = counter;
			}
			return cocks[index].cockLength;
		}
		
		public function twoDickRadarSpecial(width:int):Boolean
		{
			//No two dicks?  FUCK OFF
			if (cockTotal() < 2)
				return false;
			
			//Set up vars
			//Get thinnest, work done already
			var thinnest:int = thinnestCockIndex();
			var thinnest2:int = 0;
			//For ze loop
			var temp:int = 0;
			//Make sure they arent the same at initialization
			if (thinnest2 == thinnest)
				thinnest2 = 1;
			//Loop through to find 2nd thinnest
			while (temp < cocks.length)
			{
				if (cocks[thinnest2].cockThickness > cocks[temp].cockThickness && temp != thinnest)
					thinnest2 = temp;
				temp++;
			}
			//If the two thicknesses added together are less than the arg, true, else false
			if (cocks[thinnest].cockThickness + cocks[thinnest2].cockThickness < width)
				return true;
			else
				return false;
		}
		
		public function totalCockThickness():Number
		{
			var thick:Number = 0;
			var counter:Number = cocks.length;
			while (counter > 0)
			{
				counter--;
				thick += cocks[counter].cockThickness;
			}
			return thick;
		}
		
		public function thickestCock():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockThickness < cocks[counter].cockThickness)
					index = counter;
			}
			return index;
		}
		
		public function thickestCockThickness():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockThickness < cocks[counter].cockThickness)
					index = counter;
			}
			return cocks[index].cockThickness;
		}
		
		public function thinnestCockIndex():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockThickness > cocks[counter].cockThickness)
					index = counter;
			}
			return index;
		}
		
		public function smallestCockIndex():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) > cockArea(counter))
				{
					index = counter;
				}
			}
			return index;
		}
		
		public function smallestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			return cocks[smallestCockIndex()].cockLength;
		}
		
		public function shortestCockIndex():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockLength > cocks[counter].cockLength)
					index = counter;
			}
			return index;
		}
		
		public function shortestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cocks[index].cockLength > cocks[counter].cockLength)
					index = counter;
			}
			return cocks[index].cockLength;
		}
		
		//Find the biggest cock that fits inside a given value
		public function cockThatFits(fits:Number = 0, type:String = "area"):Number
		{
			if (cocks.length <= 0)
				return -1;
			var counter:Number = cocks.length;
			//Current largest fitter
			var index:Number = -1;
			while (counter > 0)
			{
				counter--;
				if (type == "area")
				{
					if (cockArea(counter) <= fits)
					{
						//If one already fits
						if (index >= 0)
						{
							//See if the newcomer beats the saved small guy
							if (cockArea(counter) > cockArea(index))
								index = counter;
						}
						//Store the index of fitting dick
						else
							index = counter;
					}
				}
				else if (type == "length")
				{
					if (cocks[counter].cockLength <= fits)
					{
						//If one already fits
						if (index >= 0)
						{
							//See if the newcomer beats the saved small guy
							if (cocks[counter].cockLength > cocks[index].cockLength)
								index = counter;
						}
						//Store the index of fitting dick
						else
							index = counter;
					}
				}
			}
			return index;
		}
		
		//Find the 2nd biggest cock that fits inside a given value
		public function cockThatFits2(fits:Number = 0):Number
		{
			if (cockTotal() == 1)
				return -1;
			var counter:Number = cocks.length;
			//Current largest fitter
			var index:Number = -1;
			var index2:Number = -1;
			while (counter > 0)
			{
				counter--;
				//Does this one fit?
				if (cockArea(counter) <= fits)
				{
					//If one already fits
					if (index >= 0)
					{
						//See if the newcomer beats the saved small guy
						if (cockArea(counter) > cockArea(index))
						{
							//Save old wang
							if (index != -1)
								index2 = index;
							index = counter;
						}
						//If this one fits and is smaller than the other great
						else
						{
							if ((cockArea(index2) < cockArea(counter)) && counter != index)
							{
								index2 = counter;
							}
						}
						if (index >= 0 && index == index2)
							trace("FUCK ERROR COCKTHATFITS2 SHIT IS BROKED!");
					}
					//Store the index of fitting dick
					else
						index = counter;
				}
			}
			return index2;
		}
		
		public function smallestCockArea():Number
		{
			if (cockTotal() == 0)
				return -1;
			return cockArea(smallestCockIndex());
		}
		
		public function smallestCock():Number
		{
			return cockArea(smallestCockIndex());
		}
		
		public function biggestCockIndex():Number
		{
			if (cocks.length == 0)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			return index;
		}
		
		//Find the second biggest dick's index.
		public function biggestCockIndex2():Number
		{
			if (cocks.length <= 1)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = 0;
			//Find the biggest
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//Make sure index2 doesn't get stuck
				//at the same value as index1 if the
				//initial location is biggest.
				if (index == index2 && counter != index)
					index2 = counter;
				//Is the stored value less than the current one?
				if (cockArea(index2) < cockArea(counter))
				{
					//Make sure we don't set index2 to be the same
					//as the biggest dick.
					if (counter != index)
						index2 = counter;
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2)
				return 0;
			return index2;
		}
		
		public function smallestCockIndex2():Number
		{
			if (cocks.length <= 1)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = 0;
			//Find the smallest
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) > cockArea(counter))
					index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//Make sure index2 doesn't get stuck
				//at the same value as index1 if the
				//initial location is biggest.
				if (index == index2 && counter != index)
					index2 = counter;
				//Is the stored value less than the current one?
				if (cockArea(index2) > cockArea(counter))
				{
					//Make sure we don't set index2 to be the same
					//as the biggest dick.
					if (counter != index)
						index2 = counter;
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2)
				return 0;
			return index2;
		}
		
		//Find the third biggest dick index.
		public function biggestCockIndex3():Number
		{
			if (cocks.length <= 2)
				return 0;
			var counter:Number = cocks.length;
			var index:Number = 0;
			var index2:Number = -1;
			var index3:Number = -1;
			//Find the biggest
			while (counter > 0)
			{
				counter--;
				if (cockArea(index) < cockArea(counter))
					index = counter;
			}
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//If this index isn't used already
				if (counter != index)
				{
					//Has index been set to anything yet?
					if (index2 == -1)
						index2 = counter;
					//Is the stored value less than the current one?
					else if (cockArea(index2) < cockArea(counter))
					{
						index2 = counter;
					}
				}
			}
			//If it couldn't find a second biggest...
			if (index == index2 || index2 == -1)
				index2 = 0;
			//Reset counter and find the next biggest
			counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//If this index isn't used already
				if (counter != index && counter != index2)
				{
					//Has index been set to anything yet?
					if (index3 == -1)
						index3 = counter;
					//Is the stored value less than the current one?
					else if (cockArea(index3) < cockArea(counter))
					{
						index3 = counter;
					}
				}
			}
			//If it fails for some reason.
			if (index3 == -1)
				index3 = 0;
			return index3;
		}
		
		protected function rand(max:Number):Number
		{
			return int(Math.random() * max);
		}
		
		public function cockDescript(cockIndex:Number):String
		{

			//trace("WRONG COCKDESCRIPT FUNCTION CALLED");
			if (totalCocks() == 0)
				return "<b>ERROR: CockDescript Called But No Cock Present</b>";
			if (cockTotal() <= cockIndex && cockIndex != 99)
				return "<b>ERROR: CockDescript called with index of " + cockIndex + " - out of BOUNDS</b>";
			//Cocknum 99 to default to boring descriptions!
			if (cockIndex != 99)
			{
				if (rand(2) == 0)
					descript += cockAdjective(cockIndex) + ", ";
				descript += Appearance.cockNoun(cocks[cockIndex].cockType);
			}
			else
				cockIndex = 0;
			var descript:String = "";
			//50% of the time add a descriptor
			if (rand(2) == 0)
				descript += cockAdjective(cockIndex) + " ";
			var rando:Number = 0;
			rando = int(Math.random() * 10)
			if (rando >= 0 && rando <= 4)
				descript += "cock";
			if (rando == 5 || rando == 6)
				descript += "prick";
			if (rando == 7)
				descript += "pecker";
			if (rando > 7)
				descript += "shaft";
			
			return descript;
		}
		
		
		//New cock adjectives.  The old one sucked dicks
		public function cockAdjective(cockIndex:Number = -1):String
		{
			var descript:String = "";
			var rando:Number = 0;
			var multi:Boolean = false;
			//If used for multiple cocks, set multi flag
			if (cockIndex < 0)
			{
				//Since we have multi dicks lets talk about the biggest!
				cockIndex = biggestCockIndex();
				multi = true;
			}
			//Pierced - 1/5 chance
			if (!multi && rand(5) == 0 && cocks[cockIndex].isPierced == true)
			{
				descript += "pierced";
			}
			//Goo - 1/4 chance
			else if (skinType == 3 && rand(4) == 0)
			{
				rando = rand(3);
				if (rando == 0)
					descript += "goopey";
				else if (rando == 1)
					descript += "gooey";
				else
					descript += "slimy";
			}
			//Length 1/3 chance
			else if (rand(3) == 0)
			{
				if (cocks[cockIndex].cockLength < 3)
				{
					rando = rand(4);
					if (rando == 0)
						descript = "little";
					else if (rando == 1)
						descript = "toy-sized";
					else if (rando == 2)
						descript = "mini";
					else if (rando == 3)
						descript = "budding";
					else
						descript = "tiny";
				}
				else if (cocks[cockIndex].cockLength < 5)
				{
					rando = rand(2);
					if (rando == 0)
						descript = "short";
					else
						descript = "small";
				}
				else if (cocks[cockIndex].cockLength < 7)
				{
					rando = rand(2);
					if (rando == 0)
						descript = "fair-sized";
					else
						descript = "nice";
				}
				else if (cocks[cockIndex].cockLength < 9)
				{
					rando = rand(3);
					if (rando == 0)
					{
						if (cocks[cockIndex].cockType == CockTypesEnum.HORSE)
							descript = "pony-sized";
						else
							descript = "long";
					}
					else if (rando == 1)
					{
						if (cocks[cockIndex].cockType == CockTypesEnum.HORSE)
							descript = "colt-like";
						else
							descript = "lengthy";
					}
					else
						descript = "sizable";
				}
				else if (cocks[cockIndex].cockLength < 13)
				{
					rando = rand(3);
					if (rando == 0)
						descript = "huge";
					else if (rando == 1)
					{
						if (cocks[cockIndex].cockType == CockTypesEnum.DOG)
							descript = "mastiff-like";
						else
							descript = "cucumber-length";
					}
					else
						descript = "foot-long";
				}
				else if (cocks[cockIndex].cockLength < 18)
				{
					rando = rand(3);
					if (rando == 0)
						descript = "massive";
					else if (rando == 1)
						descript = "knee-length";
					else
						descript = "forearm-length";
				}
				else if (cocks[cockIndex].cockLength < 30)
				{
					rando = rand(3);
					if (rando == 0)
						descript = "enormous";
					else if (rando == 1)
						descript = "giant";
					else
						descript = "arm-like";
				}
				else
				{
					rando = rand(4);
					if (cocks[cockIndex].cockType == CockTypesEnum.TENTACLE && rand(4) == 0)
						descript = "coiled ";
					else
					{
						if (rando == 0)
							descript = "towering";
						else if (rando == 1)
							descript = "freakish";
						else if (rando == 2)
							descript = "monstrous";
						else
							descript = "massive";
					}
				}
			}
			//Hornyness 1/2
			else if (lust > 75 && rand(2) == 0)
			{
				//Uber horny like a baws!
				if (lust > 90)
				{
					//Weak as shit cum
					if (cumQ() < 50)
					{
						if (rand(2) == 0)
							descript += "throbbing";
						else
							descript += "pulsating";
					}
					//lots of cum? drippy.
					else if (cumQ() < 200)
					{
						rando = rand(3);
						if (rando == 0)
							descript += "dribbling";
						else if (rando == 1)
							descript += "drooling";
						else
							descript += "leaking";
					}
					//Tons of cum
					else
					{
						rando = rand(5);
						if (rando == 0)
							descript += "very drippy";
						else if (rando == 1)
							descript += "pre-gushing";
						else if (rando == 2)
							descript += "cum-bubbling";
						else if (rando == 3)
							descript += "pre-slicked";
						else
							descript += "pre-drooling";
					}
				}
				//A little less lusty, but still lusty.
				else if (lust > 75)
				{
					if (cumQ() < 50)
					{
						rando = rand(5);
						if (rando == 0)
							descript += "turgid";
						else if (rando == 1)
							descript += "blood-engorged";
						else if (rando == 2)
							descript += "rock-hard";
						else if (rando == 3)
							descript += "stiff";
						else
							descript += "eager";
					}
					//A little drippy
					else if (cumQ() < 200)
					{
						rando = rand(10);
						if (rando == 0)
							descript += "turgid";
						else if (rando == 1)
							descript += "blood-engorged";
						else if (rando == 2)
							descript += "rock-hard";
						else if (rando == 3)
							descript += "stiff";
						
						else if (rando == 4)
							descript += "eager";
						else if (rando < 7)
							descript += "fluid-beading";
						else
							descript += "slowly-oozing";
					}
					//uber drippy
					else
					{
						rando = rand(4);
						if (rando == 0)
							descript += "dribbling";
						else if (rando == 1)
							descript += "drooling";
						else if (rando == 2)
							descript += "fluid-leaking";
						else
							descript += "leaking";
					}
				}
			}
			//Girth - fallback
			else
			{
				if (cocks[cockIndex].cockThickness <= .75)
				{
					rando = rand(3);
					if (rando == 0)
						descript += "thin";
					else if (rando == 1)
						descript += "slender";
					else
						descript += "narrow";
				}
				else if (cocks[cockIndex].cockThickness <= 1.2)
				{
					descript += "ample";
				}
				else if (cocks[cockIndex].cockThickness <= 1.4)
				{
					rando = rand(2);
					if (rando == 0)
						descript += "ample";
					else
						descript += "big";
				}
				else if (cocks[cockIndex].cockThickness <= 2)
				{
					rando = rand(3);
					if (rando == 0)
						descript += "broad";
					else if (rando == 1)
						descript += "girthy";
					else
						descript += "meaty";
				}
				else if (cocks[cockIndex].cockThickness <= 3.5)
				{
					rando = rand(3);
					if (rando == 0)
						descript += "fat";
					else if (rando == 1)
						descript += "wide";
					else
						descript += "distended";
				}
				else if (cocks[cockIndex].cockThickness > 3.5)
				{
					rando = rand(3);
					if (rando == 0)
						descript += "inhumanly distended";
					else if (rando == 1)
						descript += "bloated";
					else
						descript += "monstrously thick";
				}
			}
			return descript;
		}
		
		public function wetness():Number
		{
			if (vaginas.length == 0)
				return 0;
			else
				return vaginas[0].vaginalWetness;
		}
		
		public function vaginaType(newType:int = -1):int
		{
			if (!hasVagina())
				return -1;
			if (newType != -1)
			{
				vaginas[0].type = newType;
			}
			return vaginas[0].type;
		}
		
		public function looseness(vag:Boolean = true):Number
		{
			if (vag)
			{
				if (vaginas.length == 0)
					return 0;
				else
					return vaginas[0].vaginalLooseness;
			}
			else
			{
				return ass.analLooseness;
			}
		}
		
		public function vaginalCapacity():Number
		{
			//If the player has no vaginas
			if (vaginas.length == 0)
				return 0;
			var total:Number = 0;
			var bonus:Number = 0;
			//Centaurs = +50 capacity
			if (lowerBody == 4)
				bonus = 50;
			//Naga = +20 capacity
			else if (lowerBody == 3)
				bonus = 20;
			//Wet pussy provides 20 point boost
			if (hasPerk("Wet Pussy") >= 0)
				bonus += 20;
			if (hasPerk("History: Slut") >= 0)
				bonus += 20;
			if (hasPerk("One Track Mind") >= 0)
				bonus += 10;
			if (hasPerk("Cornucopia") >= 0)
				bonus += 30;
			if(hasPerk("Fera's Boon - Wide Open") >= 0) 
				bonus += 25;
			if(hasPerk("Fera's Boon - Milking Twat") >= 0) 
				bonus += 40;
			total = (bonus + statusAffectv1("Bonus vCapacity") + 8 * vaginas[0].vaginalLooseness * vaginas[0].vaginalLooseness) * (1 + vaginas[0].vaginalWetness / 10);
			return total;
		}
		
		public function analCapacity():Number
		{
			var total:Number = 0;
			var bonus:Number = 0;
			//Centaurs = +30 capacity
			if (lowerBody == 4)
				bonus = 30;
			if (hasPerk("History: Slut") >= 0)
				bonus += 20;
			if (hasPerk("Cornucopia") >= 0)
				bonus += 30;
			if (hasPerk("One Track Mind") >= 0)
				bonus += 10;
			if (ass.analWetness > 0)
				bonus += 15;
			return ((bonus + statusAffectv1("Bonus aCapacity") + 6 * ass.analLooseness * ass.analLooseness) * (1 + ass.analWetness / 10));
		}
		
		public function hasFuckableNipples():Boolean
		{
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (breastRows[counter].fuckable)
					index = counter;
			}
			if (breastRows[index].fuckable)
				return true;
			return false;
		}
		
		public function hasBreasts():Boolean
		{
			if (breastRows.length > 0)
			{
				if (biggestTitSize() >= 1)
					return true;
			}
			return false;
		}
		
		public function hasNipples():Boolean
		{
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (breastRows[counter].nipplesPerBreast > 0)
					index = counter;
			}
			if (breastRows[index].nipplesPerBreast > 0)
				return true;
			return false;
		}
		
		public function lactationSpeed():Number
		{
			//Lactation * breastSize x 10 (milkPerBreast) determines scene
			return biggestLactation() * biggestTitSize() * 10;
		}
		
		//Hacky code till I can figure out how to move appearance code out.
		//TODO: Get rid of this 
		public virtual function dogScore():Number {
			throw new Error("Not implemented. BAD");
		}
		
		//Hacky code till I can figure out how to move appearance code out.
		//TODO: Get rid of this
		public virtual function foxScore():Number {
			throw new Error("Not implemented. BAD");
		}
		
		public function biggestLactation():Number
		{
			if (breastRows.length == 0)
				return 0;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				if (breastRows[index].lactationMultiplier < breastRows[counter].lactationMultiplier)
					index = counter;
			}
			return breastRows[index].lactationMultiplier;
		}
		
		public function boostLactation(todo:Number):Number
		{
			if (breastRows.length == 0)
				return 0;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			var changes:Number = 0;
			var temp2:Number = 0;
			//Prevent lactation decrease if lactating.
			if (todo >= 0)
			{
				if (hasStatusAffect("Lactation Reduction") >= 0)
					changeStatusValue("Lactation Reduction", 1, 0);
				if (hasStatusAffect("Lactation Reduc0") >= 0)
					removeStatusAffect("Lactation Reduc0");
				if (hasStatusAffect("Lactation Reduc1") >= 0)
					removeStatusAffect("Lactation Reduc1");
				if (hasStatusAffect("Lactation Reduc2") >= 0)
					removeStatusAffect("Lactation Reduc2");
				if (hasStatusAffect("Lactation Reduc3") >= 0)
					removeStatusAffect("Lactation Reduc3");
			}
			if (todo > 0)
			{
				while (todo > 0)
				{
					counter = breastRows.length;
					todo -= .1;
					while (counter > 0)
					{
						counter--;
						if (breastRows[index].lactationMultiplier > breastRows[counter].lactationMultiplier)
							index = counter;
					}
					temp2 = .1;
					if (breastRows[index].lactationMultiplier > 1.5)
						temp2 /= 2;
					if (breastRows[index].lactationMultiplier > 2.5)
						temp2 /= 2;
					if (breastRows[index].lactationMultiplier > 3)
						temp2 /= 2;
					changes += temp2;
					breastRows[index].lactationMultiplier += temp2;
				}
			}
			else
			{
				while (todo < 0)
				{
					counter = breastRows.length;
					index = 0;
					if (todo > -.1)
					{
						while (counter > 0)
						{
							counter--;
							if (breastRows[index].lactationMultiplier < breastRows[counter].lactationMultiplier)
								index = counter;
						}
						//trace(biggestLactation());
						breastRows[index].lactationMultiplier += todo;
						if (breastRows[index].lactationMultiplier < 0)
							breastRows[index].lactationMultiplier = 0;
						todo = 0;
					}
					else
					{
						todo += .1;
						while (counter > 0)
						{
							counter--;
							if (breastRows[index].lactationMultiplier < breastRows[counter].lactationMultiplier)
								index = counter;
						}
						temp2 = todo;
						changes += temp2;
						breastRows[index].lactationMultiplier += temp2;
						if (breastRows[index].lactationMultiplier < 0)
							breastRows[index].lactationMultiplier = 0;
					}
				}
			}
			return changes;
		}
		
		public function averageLactation():Number
		{
			if (breastRows.length == 0)
				return 0;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0)
			{
				counter--;
				index += breastRows[counter].lactationMultiplier;
			}
			return Math.floor(index / breastRows.length);
		}
		
		//Calculate bonus virility rating!
		//anywhere from 5% to 100% of normal cum effectiveness thru herbs!
		public function virilityQ():Number
		{
			if (!hasCock())
				return 0;
			var percent:Number = 0.01;
			if (cumQ() >= 250)
				percent += 0.01;
			if (cumQ() >= 800)
				percent += 0.01;
			if (cumQ() >= 1600)
				percent += 0.02;
			if (hasPerk("Bro Body") >= 0)
				percent += 0.05;
			if (hasPerk("Marae's Gift - Stud") >= 0)
				percent += 0.15;
			if (hasPerk("Fera's Boon - Alpha") >= 0)
				percent += 0.10;
			if (perkv1("Elven Bounty") > 0)
				percent += 0.05;
			if (hasPerk("Fertility+") >= 0)
				percent += 0.03;
			if (hasPerk("Pierced: Fertite") >= 0)
				percent += 0.03;
			if (hasPerk("One Track Mind") >= 0)
				percent += 0.03;
			if (hasPerk("Magical Virility") >= 0)
				percent += 5;
			//Messy Orgasms?
			if (hasPerk("Messy Orgasms") >= 0)
				percent += 0.03;
			if (percent > 1)
				percent = 1;
			return percent;
		}
		
		//Calculate cum return
		public function cumQ():Number
		{
			if (!hasCock())
				return 0;
			var quantity:Number = 0;
			//Base value is ballsize*ballQ*cumefficiency by a factor of 2.
			//Other things that affect it: 
			//lust - 50% = normal output.  0 = half output. 100 = +50% output.
			//trace("CUM ESTIMATE: " + int(1.25*2*cumMultiplier*2*(lust + 50)/10 * (hoursSinceCum+10)/24)/10 + "(no balls), " + int(ballSize*balls*cumMultiplier*2*(lust + 50)/10 * (hoursSinceCum+10)/24)/10 + "(withballs)");
			var lustCoefficient:Number = (lust + 50) / 10;
			//Pilgrim's bounty maxxes lust coefficient
			if (hasPerk("Pilgrim's Bounty") >= 0)
				lustCoefficient = 150 / 10;
			if (balls == 0)
				quantity = int(1.25 * 2 * cumMultiplier * 2 * lustCoefficient * (hoursSinceCum + 10) / 24) / 10;
			else
				quantity = int(ballSize * balls * cumMultiplier * 2 * lustCoefficient * (hoursSinceCum + 10) / 24) / 10;
			if (hasPerk("Bro Body") >= 0)
				quantity *= 1.3;
			if (hasPerk("Fertility+") >= 0)
				quantity *= 1.5;
			if (hasPerk("Messy Orgasms") >= 0)
				quantity *= 1.5;
			if (hasPerk("One Track Mind") >= 0)
				quantity *= 1.1;
			if (hasPerk("Marae's Gift - Stud") >= 0)
				quantity += 350;
			if (hasPerk("Fera's Boon - Alpha") >= 0)
				quantity += 200;
			if (hasPerk("Magical Virility") >= 0)
				quantity += 200;
			if(hasPerk("Fera's Boon - Seeder") >= 0) 
				quantity += 1000;
			//if(hasPerk("Elven Bounty") >= 0) quantity += 250;;
			quantity += perkv1("Elven Bounty");
			if (hasPerk("Bro Body") >= 0)
				quantity += 200;
			quantity += statusAffectv1("rut");
			quantity *= (1 + (2 * perkv1("Pierced: Fertite")) / 100);
			//trace("Final Cum Volume: " + int(quantity) + "mLs.");
			if (quantity < 0)
				//trace("SOMETHING HORRIBLY WRONG WITH CUM CALCULATIONS");
			if (quantity < 2)
				quantity = 2;
			return quantity;
		}
		
		//How many tentaclecocks?
		public function tentacleCocks():Number
		{
			var tentacleCockC:Number = 0;
			var counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				if (cocks[counter].cockType == CockTypesEnum.TENTACLE)
					tentacleCockC++;
			}
			return tentacleCockC;
		}
		
		//How many demoncocks?
		public function demonCocks():Number
		{
			var demonCockC:Number = 0;
			var counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				if (cocks[counter].cockType == CockTypesEnum.DEMON)
					demonCockC++;
			}
			return demonCockC;
		}
		
		//How many cat-cocks?
		public function catCocks():Number
		{
			var catCockC:Number = 0;
			var counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				if (cocks[counter].cockType == CockTypesEnum.CAT)
					catCockC++;
			}
			return catCockC;
		}
		
		//How many lizard/snake-cocks?
		public function lizardCocks():Number
		{
			var lizCockC:Number = 0;
			var counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				if (cocks[counter].cockType == CockTypesEnum.LIZARD)
					lizCockC++;
			}
			return lizCockC;
		}
		
		public function findFirstCockType(type:CockTypesEnum):Number
		{
			var index:Number = 0;
			if (cocks[index].cockType == type)
				return index;
			while (index < cocks.length)
			{
				index++;
				if (cocks[index].cockType == type)
					return index;
			}
			//trace("creature.findFirstCockType ERROR - searched for cocktype: " + type + " and could not find it.");
			return 0;
		}
		
		/*public function findFirstCockType(type:Number = 0):Number
		{
			var index:Number = 0;
			if (cocks[index].cockType == type)
				return index;
			while (index < cocks.length)
			{
				index++;
				if (cocks[index].cockType == type)
					return index;
			}
			//trace("creature.findFirstCockType ERROR - searched for cocktype: " + type + " and could not find it.");
			return 0;
		}*/
		
		public function displacerCocks():Number
		{
			var displacerWang:Number = 0;
			var counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				if (cocks[counter].cockType == CockTypesEnum.DISPLACER)
					displacerWang++;
			}
			return displacerWang;
		}
		
		//How many kangawangs
		public function kangaCocks():Number
		{
			var kangaWang:Number = 0;
			var counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				if (cocks[counter].cockType == CockTypesEnum.KANGAROO)
					kangaWang++;
			}
			return kangaWang;
		}
		
		//How many horsecocks?
		public function horseCocks():Number
		{
			var horseCockC:Number = 0;
			var counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				if (cocks[counter].cockType == CockTypesEnum.HORSE)
					horseCockC++;
			}
			return horseCockC;
		}
		
		//How many anemonecocks?
		public function anemoneCocks():Number
		{
			var anemoneCockC:Number = 0;
			var counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				if (cocks[counter].cockType == CockTypesEnum.ANEMONE)
					anemoneCockC++;
			}
			return anemoneCockC;
		}
		
		//Change first normal cock to horsecock!
		//Return number of affected cock, otherwise -1
		public function addHorseCock():Number
		{
			var counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				//Human - > horse
				if (cocks[counter].cockType == CockTypesEnum.HUMAN)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
				//Dog - > horse
				if (cocks[counter].cockType == CockTypesEnum.DOG)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
				//Tentacle - > horse
				if (cocks[counter].cockType == CockTypesEnum.TENTACLE)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
				//Demon -> horse
				if (cocks[counter].cockType == CockTypesEnum.DEMON)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
				//Catch-all
				if (cocks[counter].cockType.Index > 4)
				{
					cocks[counter].cockType = CockTypesEnum.HORSE;
					return counter;
				}
			}
			return -1;
		}
		
		//How many dogCocks
		public function dogCocks():Number
		{
			var dogCockC:Number = 0;
			var counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				if (cocks[counter].cockType == CockTypesEnum.DOG)
					dogCockC++;
			}
			return dogCockC;
		}
		
		//How many dragonCocks
		public function dragonCocks():Number
		{
			var dragonCockC:Number = 0;
			var counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				if (cocks[counter].cockType == CockTypesEnum.DRAGON)
					dragonCockC++;
			}
			return dragonCockC;
		}
		
		//How many normalCocks
		public function normalCocks():Number
		{
			var normalCockC:Number = 0;
			var counter = cocks.length;
			while (counter > 0)
			{
				counter--;
				if (cocks[counter].cockType == CockTypesEnum.HUMAN)
					normalCockC++;
			}
			return normalCockC;
		}
		
		//How many cocks?
		public function cockTotal():Number
		{
			return (cocks.length);
		}
		
		//Alternate
		public function totalCocks():Number
		{
			return (cocks.length);
		}
		
		//BOolean alternate
		public function hasCock():Boolean
		{
			if (cocks.length >= 1)
				return true;
			return false;
		}
		
		public function hasSockRoom():Boolean
		{
			var index:int = cockTotal();
			while (index > 0)
			{
				index--;
				if (cocks[index].sock == "")
					return true;
			}
			return false
		}
		
		public function hasSock(arg:String = ""):Boolean
		{
			var index:int = cockTotal();
			while (index > 0)
			{
				index--;
				if (cocks[index].sock != "")
				{
					if (arg == "" || cocks[index].sock == arg)
						return true;
				}
			}
			return false
		}
		
		public function canAutoFellate():Boolean
		{
			if (!hasCock())
				return false;
			return (cocks[0].cockLength >= 20);
		}
		
		//Deprecated
		public function canSelfSuck():Boolean
		{
			return canAutoFellate();
		}
		
		//PC can fly?
		public function canFly():Boolean
		{
			//web also makes false!
			if (hasStatusAffect("Web") >= 0)
				return false;
			if (wingType == 2 || wingType == 7 || wingType == 9 || wingType == 11 || wingType == 12)
				return true;
			return false;
		}
		
		//check for vagoo
		public function hasVagina():Boolean
		{
			if (vaginas.length > 0)
				return true;
			return false;
		}
		
		public function hasVirginVagina():Boolean
		{
			if (vaginas.length > 0)
				return vaginas[0].virgin;
			return false;
		}
		
		public function manWoman(caps:Boolean = false):String
		{
			//Dicks?
			if (totalCocks() > 0)
			{
				if (hasVagina())
				{
					if (caps)
						return "Futa";
					else
						return "futa";
				}
				else
				{
					if (caps)
						return "Man";
					else
						return "man";
				}
			}
			else
			{
				if (hasVagina())
				{
					if (caps)
						return "Woman";
					else
						return "woman";
				}
				else
				{
					if (caps)
						return "Eunuch";
					else
						return "eunuch";
				}
			}
		}
		
		public function guyGirl(caps:Boolean = false):String
		{
			//Dicks?
			if (totalCocks() > 0)
			{
				if (hasVagina())
				{
					if (caps)
						return "Girl";
					else
						return "girl";
				}
				else
				{
					if (caps)
						return "Guy";
					else
						return "guy";
				}
			}
			else
			{
				if (hasVagina())
				{
					if (caps)
						return "Girl";
					else
						return "girl";
				}
				else
				{
					if (biggestTitSize() >= 3)
					{
						if (caps)
							return "Girl";
						else
							return "girl";
					}
					if (caps)
						return "Guy";
					else
						return "guy";
				}
			}
		}
		
		public function mfn(male:String, female:String, neuter:String):String
		{
			if (gender == 0)
				return neuter;
			else
				return mf(male, female);
		}
		
		public function mf(male:String, female:String):String
		{
			//Dicks?
			if (totalCocks() > 0)
			{
				if (hasVagina())
					return female;
				else
					return male;
			}
			else
			{
				if (hasVagina())
					return female;
				else
				{
					if (biggestTitSize() >= 3)
						return female;
					else
						return male;
				}
			}
		}
		
		public function boyGirl(caps:Boolean = false):String
		{
			//Dicks?
			if (totalCocks() > 0)
			{
				if (hasVagina())
				{
					if (caps)
						return "Girl";
					else
						return "girl";
				}
				else
				{
					if (caps)
						return "Boy";
					else
						return "boy";
				}
			}
			else
			{
				if (hasVagina())
				{
					if (caps)
						return "Girl";
					else
						return "girl";
				}
				else
				{
					if (biggestTitSize() >= 3)
					{
						if (caps)
							return "Girl";
						else
							return "girl";
					}
					if (caps)
						return "Boy";
					else
						return "boy";
				}
			}
		}
		
		public function heShe(caps:Boolean = false):String
		{
			//Dicks?
			if (totalCocks() > 0)
			{
				if (hasVagina())
				{
					if (caps)
						return "She";
					else
						return "she";
				}
				else
				{
					if (caps)
						return "He";
					else
						return "he";
				}
			}
			else
			{
				if (hasVagina())
				{
					if (caps)
						return "She";
					else
						return "she";
				}
				else
				{
					if (biggestTitSize() >= 3)
					{
						if (caps)
							return "She";
						else
							return "she";
					}
					if (caps)
						return "It";
					else
						return "it";
				}
			}
		}
		
		public function himHer(caps:Boolean = false):String
		{
			//Dicks?
			if (totalCocks() > 0)
			{
				if (hasVagina())
				{
					if (caps)
						return "Her";
					else
						return "her";
				}
				else
				{
					if (caps)
						return "Him";
					else
						return "him";
				}
			}
			else
			{
				if (hasVagina())
				{
					if (caps)
						return "Her";
					else
						return "her";
				}
				else
				{
					if (biggestTitSize() >= 3)
					{
						if (caps)
							return "Her";
						else
							return "her";
					}
					if (caps)
						return "Him";
					else
						return "him";
				}
			}
		}
		
		public function maleFemale(caps:Boolean = false):String
		{
			//Dicks?
			if (totalCocks() > 0)
			{
				if (hasVagina())
				{
					if (caps)
						return "Female";
					else
						return "female";
				}
				else
				{
					if (caps)
						return "Male";
					else
						return "male";
				}
			}
			else
			{
				if (hasVagina())
				{
					if (caps)
						return "Female";
					else
						return "female";
				}
				else
				{
					if (biggestTitSize() >= 3)
					{
						if (caps)
							return "Female";
						else
							return "female";
					}
					if (caps)
						return "Male";
					else
						return "male";
				}
			}
		}
		
		public function hisHer(caps:Boolean = false):String
		{
			//Dicks?
			if (totalCocks() > 0)
			{
				if (hasVagina())
				{
					if (caps)
						return "Her";
					else
						return "her";
				}
				else
				{
					if (caps)
						return "Him";
					else
						return "him";
				}
			}
			else
			{
				if (hasVagina())
				{
					if (caps)
						return "Her";
					else
						return "her";
				}
				else
				{
					if (biggestTitSize() >= 3)
					{
						if (caps)
							return "Her";
						else
							return "her";
					}
					if (caps)
						return "Him";
					else
						return "him";
				}
			}
		}
		
		//sir/madam
		public function sirMadam(caps:Boolean = false):String
		{
			//Dicks?
			if (totalCocks() > 0)
			{
				//herm
				if (hasVagina())
				{
					//Boy unless has tits!
					if (biggestTitSize() >= 2)
					{
						if (caps)
							return "Madam";
						else
							return "madam";
					}
					else
					{
						if (caps)
							return "Sir";
						else
							return "sir";
					}
				}
				//Dude
				else
				{
					if (caps)
						return "Sir";
					else
						return "sir";
				}
			}
			//No dicks
			else
			{
				//Girl
				if (hasVagina())
				{
					if (caps)
						return "Madam";
					else
						return "madam";
				}
				//Eunuch!
				else
				{
					//Called girl if has tits!
					if (biggestTitSize() >= 2)
					{
						if (caps)
							return "Madam";
						else
							return "madam";
					}
					//Called dude with no tits
					else
					{
						if (caps)
							return "Sir";
						else
							return "sir";
					}
				}
			}
		}
		
		//Create a cock
		public function createCock(clength:Number = 5.5, cthickness:Number = 1):Boolean
		{
			trace("createCock called. clength = " + clength + ", cthickness = " + cthickness);
			if (cocks.length >= 10)
				return false;
			var newCock:Cock = new Cock(clength, cthickness);
			//var newCock:cockClass = new cockClass();
			trace("New cock info. Length = " + newCock.cockLength + ", Thickness = " + newCock.cockThickness + ", Type = " + newCock.cockType);
			cocks.push(newCock);
			cocks[cocks.length-1].cockThickness = cthickness;
			cocks[cocks.length-1].cockLength = clength;
			return true;
		}
		
		//create vagoo
		public function createVagina():Boolean
		{
			if (vaginas.length >= 2)
				return false;
			var newVagina:vaginaClass = new vaginaClass();
			vaginas.push(newVagina);
			return true;
		}
		
		//create a row of breasts
		public function createBreastRow():Boolean
		{
			if (breastRows.length >= 10)
				return false;
			var newBreastRow:breastRowClass = new breastRowClass();
			breastRows.push(newBreastRow);
			return true;
		}
		
		public function genderCheck():void
		{
			if (hasCock() && hasVagina())
				gender = 3;
			else if (hasCock())
				gender = 1;
			else if (hasVagina())
				gender = 2;
			else
				gender = 0;
		}
		
		//Remove cocks
		public function removeCock(arraySpot:int, totalRemoved:int):void
		{
			//Various Errors preventing action
			if (arraySpot < 0 || totalRemoved <= 0)
			{
				//trace("ERROR: removeCock called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if (cocks.length == 0)
			{
				//trace("ERROR: removeCock called but cocks do not exist.");
			}
			else
			{
				if (arraySpot > cocks.length - 1)
				{
					//trace("ERROR: removeCock failed - array location is beyond the bounds of the array.");
				}
				else
				{
					cocks.splice(arraySpot, totalRemoved);
					//trace("Attempted to remove " + totalRemoved + " cocks.");
				}
			}
			genderCheck();
		}
		
		//REmove vaginas
		public function removeVagina(arraySpot:int = 0, totalRemoved:int = 1):void
		{
			//Various Errors preventing action
			if (arraySpot < -1 || totalRemoved <= 0)
			{
				//trace("ERROR: removeVagina called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if (vaginas.length == 0)
			{
				//trace("ERROR: removeVagina called but cocks do not exist.");
			}
			else
			{
				if (arraySpot > vaginas.length - 1)
				{
					//trace("ERROR: removeVagina failed - array location is beyond the bounds of the array.");
				}
				else
				{
					vaginas.splice(arraySpot, totalRemoved);
					//trace("Attempted to remove " + totalRemoved + " vaginas.");
				}
			}
			genderCheck();
		}
		
		//Remove a breast row
		public function removeBreastRow(arraySpot:int, totalRemoved:int):void
		{
			//Various Errors preventing action
			if (arraySpot < -1 || totalRemoved <= 0)
			{
				//trace("ERROR: removeBreastRow called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if (breastRows.length == 0)
			{
				//trace("ERROR: removeBreastRow called but cocks do not exist.");
			}
			else
			{
				if (arraySpot > breastRows.length - 1)
				{
					//trace("ERROR: removeBreastRow failed - array location is beyond the bounds of the array.");
				}
				else
				{
					breastRows.splice(arraySpot, totalRemoved);
					//trace("Attempted to remove " + totalRemoved + " breastRows.");
				}
			}
		}
	}
}

