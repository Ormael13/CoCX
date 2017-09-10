//CoC Creature.as
package classes
{
	import classes.BodyParts.Claws;
	import classes.BodyParts.Face;
	import classes.BodyParts.IOrifice;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.Skin;
	import classes.BodyParts.SkinLayer;
	import classes.BodyParts.Tail;
	import classes.BodyParts.UnderBody;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	import classes.PerkType;
	import classes.StatusEffectType;
	import classes.Items.JewelryLib;
	import classes.internals.Utils;
	import classes.VaginaClass;
	import classes.Scenes.Places.TelAdre.UmasShop;
	import flash.display.InteractiveObject;
	import flash.errors.IllegalOperationError;

	public class Creature extends Utils
	{

		include "../../includes/appearanceDefs.as";

		public function get game():CoC {
			return kGAMECLASS;
		}
		public function get flags():DefaultDict {
			return game.flags;
		}

		//Variables
		
		//Short refers to player name and monster name. BEST VARIABLE NAME EVA!
		//"a" refers to how the article "a" should appear in text.
		private var _short:String = "You";
		private var _a:String = "a ";
		public function get short():String { return _short; }
		public function set short(value:String):void { _short = value; }
		public function get a():String { return _a; }
		public function set a(value:String):void { _a = value; }
		public function get capitalA():String {
			if (_a.length == 0) return "";
			return _a.charAt(0).toUpperCase() + _a.substr(1);
		}

		//Weapon melee
		private var _weaponName:String = "";
		private var _weaponVerb:String = "";
		private var _weaponAttack:Number = 0;
		private var _weaponPerk:String = "";
		private var _weaponValue:Number = 0;
		public function get weaponName():String { return _weaponName; }
		public function get weaponVerb():String { return _weaponVerb; }
		public function get weaponAttack():Number { return _weaponAttack; }
		public function get weaponPerk():String { return _weaponPerk; }
		public function get weaponValue():Number { return _weaponValue; }
		public function set weaponName(value:String):void { _weaponName = value; }
		public function set weaponVerb(value:String):void { _weaponVerb = value; }
		public function set weaponAttack(value:Number):void { _weaponAttack = value; }
		public function set weaponPerk(value:String):void { _weaponPerk = value; }
		public function set weaponValue(value:Number):void { _weaponValue = value; }
		//Weapon range
		private var _weaponRangeName:String = "";
		private var _weaponRangeVerb:String = "";
		private var _weaponRangeAttack:Number = 0;
		private var _weaponRangePerk:String = "";
		private var _weaponRangeValue:Number = 0;
		public function get weaponRangeName():String { return _weaponRangeName; }
		public function get weaponRangeVerb():String { return _weaponRangeVerb; }
		public function get weaponRangeAttack():Number { return _weaponRangeAttack; }
		public function get weaponRangePerk():String { return _weaponRangePerk; }
		public function get weaponRangeValue():Number { return _weaponRangeValue; }
		public function set weaponRangeName(value:String):void { _weaponRangeName = value; }
		public function set weaponRangeVerb(value:String):void { _weaponRangeVerb = value; }
		public function set weaponRangeAttack(value:Number):void { _weaponRangeAttack = value; }
		public function set weaponRangePerk(value:String):void { _weaponRangePerk = value; }
		public function set weaponRangeValue(value:Number):void { _weaponRangeValue = value; }
		//Clothing/Armor
		private var _armorName:String = "";
		private var _armorDef:Number = 0;
		private var _armorPerk:String = "";
		private var _armorValue:Number = 0;
		public function get armorName():String { return _armorName; }
		public function get armorDef():Number { return _armorDef; }
		public function get armorPerk():String { return _armorPerk; }
		public function get armorValue():Number { return _armorValue; }
		public function set armorValue(value:Number):void { _armorValue = value; }
		public function set armorName(value:String):void { _armorName = value; }
		public function set armorDef(value:Number):void { _armorDef = value; }
		public function set armorPerk(value:String):void { _armorPerk = value; }
		//Jewelry!
		private var _jewelryName:String = "";
		private var _jewelryEffectId:Number = 0;
		private var _jewelryEffectMagnitude:Number = 0;
		private var _jewelryPerk:String = "";
		private var _jewelryValue:Number = 0;
		public function get jewelryName():String { return _jewelryName; }
		public function get jewelryEffectId():Number { return _jewelryEffectId; }
		public function get jewelryEffectMagnitude():Number { return _jewelryEffectMagnitude; }
		public function get jewelryPerk():String { return _jewelryPerk; }
		public function get jewelryValue():Number { return _jewelryValue; }
		public function set jewelryValue(value:Number):void { _jewelryValue = value; }
		public function set jewelryName(value:String):void { _jewelryName = value; }
		public function set jewelryEffectId(value:Number):void { _jewelryEffectId = value; }
		public function set jewelryEffectMagnitude(value:Number):void { _jewelryEffectId = value; }
		public function set jewelryPerk(value:String):void { _jewelryPerk = value; }
		//Shield!
		private var _shieldName:String = "";
		private var _shieldBlock:Number = 0;
		private var _shieldPerk:String = "";
		private var _shieldValue:Number = 0;
		public function get shieldName():String { return _shieldName; }
		public function get shieldBlock():Number { return _shieldBlock; }
		public function get shieldPerk():String { return _shieldPerk; }
		public function get shieldValue():Number { return _shieldValue; }
		public function set shieldValue(value:Number):void { _shieldValue = value; }
		public function set shieldName(value:String):void { _shieldName = value; }
		public function set shieldBlock(value:Number):void { _shieldBlock = value; }
		public function set shieldPerk(value:String):void { _shieldPerk = value; }
		//Undergarments!
		private var _upperGarmentName:String = "";
		private var _upperGarmentPerk:String = "";
		private var _upperGarmentValue:Number = 0;
		public function get upperGarmentName():String { return _upperGarmentName; }
		public function get upperGarmentPerk():String { return _upperGarmentPerk; }
		public function get upperGarmentValue():Number { return _upperGarmentValue; }
		public function set upperGarmentName(value:String):void { _upperGarmentName = value; }
		public function set upperGarmentPerk(value:String):void { _upperGarmentPerk = value; }
		public function set upperGarmentValue(value:Number):void { _upperGarmentValue = value; }
		
		private var _lowerGarmentName:String = "";
		private var _lowerGarmentPerk:String = "";
		private var _lowerGarmentValue:Number = 0;
		public function get lowerGarmentName():String { return _lowerGarmentName; }
		public function get lowerGarmentPerk():String { return _lowerGarmentPerk; }
		public function get lowerGarmentValue():Number { return _lowerGarmentValue; }
		public function set lowerGarmentName(value:String):void { _lowerGarmentName = value; }
		public function set lowerGarmentPerk(value:String):void { _lowerGarmentPerk = value; }
		public function set lowerGarmentValue(value:Number):void { _lowerGarmentValue = value; }
		//Primary stats
		public var str:Number = 0;
		public var tou:Number = 0;
		public var spe:Number = 0;
		public var inte:Number = 0;
		public var wis:Number = 0;
		public var lib:Number = 0;
		public var sens:Number = 0;
		public var cor:Number = 0;
		public var fatigue:Number = 0;
		public var mana:Number = 0;
		public var soulforce:Number = 0;
		
		//Combat Stats
		public var HP:Number = 0;
		public var lust:Number = 0;
		public var wrath:Number = 0;
		
		//Level Stats
		public var XP:Number = 0;
		public var level:Number = 0;
		public var gems:Number = 0;
		public var additionalXP:Number = 0;
				
		//Appearance Variables
		//Gender 1M, 2F, 3H
		public function get gender():int {
			if (hasCock() && hasVagina()) return GENDER_HERM;
			if (hasCock()) return GENDER_MALE;
			if (hasVagina()) return GENDER_FEMALE;
			return GENDER_NONE;
		}
		private var _tallness:Number = 0;
		public function get tallness():Number { return _tallness; }
		public function set tallness(value:Number):void { _tallness = value; }

		/*Hairtype
		0- normal
		1- feather
		2- ghost
		3- goo!
		4- anemononeoenoeneo!*/
		public var hairType:Number = HAIR_NORMAL;
		public var hairColor:String = "no";
		public var hairLength:Number = 0;

		public function get coatColor():String {
			if (!skin.hasCoat()) trace("[WARNING] get coatColor() called with no coat");
			return skin.coat.color;
		}
		public function set coatColor(value:String):void {
			if (!skin.hasCoat()) trace("[WARNING] set coatColor() called with no coat");
			skin.coat.color = value;
		}

		public var beardStyle:Number = BEARD_NORMAL;
		public var beardLength:Number = 0;
				
		public var skin:Skin;
		public function get skinType():Number { return skin.type; }
	//	[Deprecated]
		public function set skinType(value:Number):void {
			trace("[DEPRECATED] set skinType");
			skin.type = value;
		}
		public function get skinTone():String { return skin.tone; }
		public function hasCoat():Boolean { return skin.hasCoat(); }
		public function hasFullCoat():Boolean { return skin.hasFullCoat(); }
		/**
		 * @return -1 if hasCoat(), skin.coat.type otherwise
		 */
		public function coatType():int { return skin.coatType(); }
		public function hasCoatOfType(...types:Array):Boolean { return skin.hasCoatOfType(types); }
		public function hasFullCoatOfType(...types:Array):Boolean { return skin.hasFullCoatOfType(types); }
	//	[Deprecated]
		public function set skinTone(value:String):void {
			trace("[DEPRECATED] set skinTone");
			if (skin.coverage >= Skin.COVERAGE_HIGH) skin.coat.color = value;
			else skin.base.color = value;
		}
		public function get skinDesc():String { return skin.desc; }
	//	[Deprecated]
		public function set skinDesc(value:String):void {
			trace("[DEPRECATED] set skinDesc");
			if (skin.coverage >= Skin.COVERAGE_HIGH) skin.coat.desc = value;
			else skin.base.desc = value;
		}
		public function get skinAdj():String { return skin.adj; }
	//	[Deprecated]
		public function set skinAdj(value:String):void {
			trace("[DEPRECATED] set skinAdj");
			if (skin.coverage >= Skin.COVERAGE_HIGH) skin.coat.adj = value;
			else skin.base.adj = value;
		}
		
		public var facePart:Face;
		public function get faceType():Number { return facePart.type; }
		public function set faceType(value:Number):void { facePart.type = value; }

		// <mod name="Predator arms" author="Stadler76">
		public var clawsPart:Claws;
		public function get clawTone():String { return this.clawsPart.tone; }
		public function set clawTone(value:String):void { this.clawsPart.tone = value; }
		public function get clawType():int{ return this.clawsPart.type ; }
		public function set clawType(value:int):void { this.clawsPart.type = value; }
		// </mod>
		public var underBody:UnderBody;

		public var earType:Number = EARS_HUMAN;
		public var earValue:Number = 0;
		public var hornType:Number = HORNS_NONE;
		public var horns:Number = 0;
		private var _wingType:Number = WING_TYPE_NONE;
		public var wingDesc:String = "non-existant";
		public function get wingType():Number { return _wingType; }
		public function set wingType(value:Number):void { _wingType = value; }

		/* lowerBody: see LOWER_BODY_TYPE_ */
		public var lowerBodyPart:LowerBody;
		public function get lowerBody():int { return lowerBodyPart.type; }
		public function set lowerBody(value:int):void { lowerBodyPart.type = value; }
		public function get legCount():int { return lowerBodyPart.legCount; }
		public function set legCount(value:int):void{ lowerBodyPart.legCount = value; }

		public var tail:Tail;
		public function get tailType():int { return tail.type; }
		public function get tailVenom():int { return tail.venom; }
		public function get tailCount():Number { return tail.count; }
		public function get tailRecharge():Number { return tail.recharge; }
		public function set tailType(value:int):void { tail.type = value; }
		public function set tailVenom(value:int):void { tail.venom = value; }
		public function set tailCount(value:Number):void { tail.count = value; }
		public function set tailRecharge(value:Number):void { tail.recharge = value; }
		
		/*hipRating
		0 - boyish
		2 - slender
		4 - average
		6 - noticable/ample
		10 - curvy//flaring
		15 - child-bearing/fertile
		20 - inhumanly wide*/
		public var hipRating:Number = HIP_RATING_BOYISH;
		
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
		public var buttRating:Number = BUTT_RATING_BUTTLESS;
		
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

		//Head ornaments. Definitely need to convert away from hard coded types.
		public var antennae:Number = ANTENNAE_NONE;

		//Eyetype
		public var eyeType:Number = EYES_HUMAN;
		public var eyeColor:String = "brown";

		//TongueType
		public var tongueType:Number = TONGUE_HUMAN;

		//ArmType
		public var armType:Number = ARM_TYPE_HUMAN;

		//GillType
		public var gillType:int = GILLS_NONE;
		public function hasGills():Boolean { return gillType != GILLS_NONE; }
		
		//RearBody
		public var rearBody:Number = REAR_BODY_NONE;

		//Sexual Stuff		
		//MALE STUFF
		//public var cocks:Array;
		//TODO: Tuck away into Male genital class?
		public var cocks:Array;
		//balls
		public var balls:Number = 0;
		public var cumMultiplier:Number = 1;
		public var ballSize:Number = 0;
		
		private var _hoursSinceCum:Number = 0;
		public function get hoursSinceCum():Number { return _hoursSinceCum; }
		public function set hoursSinceCum(v:Number):void {
			/*if (v == 0)
			{
				trace("noop");
			}*/
			_hoursSinceCum = v;
		}
		
		//FEMALE STUFF
		//TODO: Box into Female genital class?
		public var vaginas:Vector.<VaginaClass>;
		//Fertility is a % out of 100.
		public var fertility:Number = 10;
		public var nippleLength:Number = .25;
		public var breastRows:Array;
		public var ass:AssClass = new AssClass();

		public function get clitLength():Number {
			if (vaginas.length==0) {
				trace("[ERROR] get clitLength called with no vaginas present");
				return VaginaClass.DEFAULT_CLIT_LENGTH;
			}
			return vaginas[0].clitLength;
		}

		public function set clitLength(value:Number):void {
			if (vaginas.length==0) {
				trace("[ERROR] set clitLength called with no vaginas present");
				return;
			}
			vaginas[0].clitLength = value;
		}

		//Constructor
		public function Creature()
		{
			skin = new Skin(this);
			underBody = new UnderBody(this);
			lowerBodyPart = new LowerBody(this);
			clawsPart = new Claws(this);
			facePart = new Face(this);
			tail = new Tail(this);
			//cocks = new Array();
			//The world isn't ready for typed Arrays just yet.
			cocks         = [];
			vaginas       = new Vector.<VaginaClass>();
			ass           = new AssClass();
			ass.host      = this;
			breastRows    = [];
			_perks        = [];
			statusEffects = [];
			//keyItems = new Array();
		}

		/**
		 * Check if the Creature has a vagina. If not, throw an informative Error.
		 * This should be more informative than the usual RangeError (Out of bounds).
		 * @throws IllegalOperationError if no vagina is present
		 */
		private function checkVaginaPresent():void {
			if (!hasVagina()) {
				throw new IllegalOperationError("Creature does not have vagina.")
			}
		}

		/**
		 * Change the clit length by the given amount. If the resulting length drops below 0, it will be set to 0 instead.
		 * @param	delta the amount to change, can be positive or negative
		 * @param	vaginaIndex the vagina whose clit will be changed
		 * @return the updated clit length
		 * @throws IllegalOperationError if the Creature does not have a vagina
		 * @throws RangeError if the selected vagina cannot be found
		 */
		public function changeClitLength(delta:Number, vaginaIndex:int = 0):Number {
			checkVaginaPresent();
			var newClitLength:Number = vaginas[vaginaIndex].clitLength += delta;
			return newClitLength < 0 ? 0 : newClitLength;
		}

		private var _femininity:Number = 50;
		public function get femininity():Number {
			var fem:Number                 = _femininity;
			const effect:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (effect != null && effect.value1 == UmasShop.MASSAGE_MODELLING_BONUS) {
				fem += effect.value2;
			}
			if (fem > 100)
				fem = 100;
			return fem;
		}
		public function set femininity(value:Number):void
		{
			if (value > 100)
				value = 100;
			else if (value < 0)
				value = 0;
			_femininity = value;
		}

		public function validate():String
		{
			var error:String = "";
			// 2. Value boundaries etc
			// 2.1. non-negative Number fields
			error += Utils.validateNonNegativeNumberFields(this,"Monster.validate",[
				"balls", "ballSize", "cumMultiplier", "hoursSinceCum",
				"tallness", "hipRating", "buttRating", "lowerBody", "armType",
				"hairLength", "hairType",
				"faceType", "earType", "tongueType", "eyeType",
				"str", "tou", "spe", "inte", "wis", "lib", "sens", "cor",
				// Allow weaponAttack to be negative as a penalty to strength-calculated damage
				// Same with armorDef, bonusHP, additionalXP
				"weaponValue", "armorValue",
				"lust", "fatigue", "soulforce", "mana", "wrath",
				"level", "gems",
				"tailCount", "tailVenom", "tailRecharge", "horns",
				"HP", "XP"
			]);
			// 2.2. non-empty String fields
			error += Utils.validateNonEmptyStringFields(this,"Monster.validate",[
				"short",
				"skinDesc", "eyeColor",
				"weaponName", "weaponVerb", "armorName"
			]);
			// 3. validate members
			for each (var cock:Cock in cocks) {
				error += cock.validate();
			}
			for each (var vagina:VaginaClass in vaginas) {
				error += vagina.validate();
			}
			for each (var row:BreastRowClass in breastRows) {
				error += row.validate();
			}
			error += ass.validate();
			// 4. Inconsistent fields
			// 4.1. balls
			if (balls>0 && ballSize<=0){
				error += "Balls are present but ballSize = "+ballSize+". ";
			}
			if (ballSize>0 && balls<=0){
				error += "No balls but ballSize = "+ballSize+". ";
			}
			// 4.2. hair
			if (hairLength <= 0) {
				if (hairType != HAIR_NORMAL) error += "No hair but hairType = " + hairType + ". ";
			}
			// 4.3. tail
			if (tailType == TAIL_TYPE_NONE) {
				if (tailCount != 0) error += "No tail but tailCount = "+tailCount+". ";
			}
			// 4.4. horns
			if (hornType == HORNS_NONE){
				if (horns>0) error += "horns > 0 but hornType = HORNS_NONE. ";
			} else {
				if (horns==0) error += "Has horns but their number 'horns' = 0. ";
			}
			return error;
		}
		
		//Monsters have few perks, which I think should be a status effect for clarity's sake.
		//TODO: Move perks into monster status effects.
		private var _perks:Array;
		public function perk(i:int):PerkClass{
			return _perks[i];
		}
		public function get perks():Array {
			return _perks;
		}
		public function get numPerks():int {
			return _perks.length;
		}
		//Current status effects. This has got very muddy between perks and status effects. Will have to look into it.
		//Someone call the grammar police!
		//TODO: Move monster status effects into perks. Needs investigation though.
		public var statusEffects:Array;


		//Functions

		//Create a perk
		public function createPerk(ptype:PerkType, value1:Number, value2:Number, value3:Number, value4:Number):void
		{
			var newKeyItem:PerkClass = new PerkClass(ptype);
			//used to denote that the array has already had its new spot pushed on.
			var arrayed:Boolean = false;
			//used to store where the array goes
			var keySlot:Number = 0;
			var counter:Number = 0;
			//Start the array if its the first bit
			if (perks.length == 0)
			{
				//trace("New Perk Started Array! " + keyName);
				perks.push(newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//If it belongs at the end, push it on
			if (perk(perks.length - 1).perkName < ptype.name && !arrayed)
			{
				//trace("New Perk Belongs at the end!! " + keyName);
				perks.push(newKeyItem);
				arrayed = true;
				keySlot = perks.length - 1;
			}
			//If it belongs in the beginning, splice it in
			if (perk(0).perkName > ptype.name && !arrayed)
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
					if (perk(counter).perkName > ptype.name)
					{
						//If the earlier slot is earlier than new key && a real spot
						if (counter - 1 >= 0)
						{
							//If the earlier slot is earlier slot in!
							if (perk(counter - 1).perkName <= ptype.name)
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
							if (perk(counter).perkName <= ptype.name) {
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
				keySlot = perks.length - 1;
			}
			
			perk(keySlot).value1 = value1;
			perk(keySlot).value2 = value2;
			perk(keySlot).value3 = value3;
			perk(keySlot).value4 = value4;
			//trace("NEW PERK FOR PLAYER in slot " + keySlot + ": " + perk(keySlot).perkName);
		}

		/**
		 * Remove perk. Return true if there was such perk
		 */
		public function removePerk(ptype:PerkType):Boolean
		{
			var counter:Number = perks.length;
			//Various Errors preventing action
			if (perks.length <= 0)
			{
				return false;
			}
			if (perkv4(ptype) > 0)
			{
				// trace('ERROR! Attempted to remove permanent "' + ptype.name + '" perk.');
				return false;
			}
			while (counter > 0)
			{
				counter--;
				if (perk(counter).ptype == ptype)
				{
					perks.splice(counter, 1);
					//trace("Attempted to remove \"" + perkName + "\" perk.");
					return true;
				}
			}
			return false;
		}

		//has perk?
		public function findPerk(ptype:PerkType):Number
		{
			if (perks.length <= 0)
				return -2;
			for (var counter:int = 0; counter<perks.length; counter++)
			{
				if (perk(counter).ptype == ptype)
					return counter;
			}
			return -1;
		}
		public function hasPerk(ptype:PerkType):Boolean {
			return findPerk(ptype) >= 0;
		}

		//Duplicate perk
		//Deprecated?
		public function perkDuplicated(ptype:PerkType):Boolean
		{
			var timesFound:int = 0;
			if (perks.length <= 0)
				return false;
			for (var counter:int = 0; counter<perks.length; counter++)
			{
				if (perk(counter).ptype == ptype)
					timesFound++;
			}
			return (timesFound > 1);
		}

		//remove all perks
		public function removePerks():void
		{
			_perks = [];
		}

		public function addPerkValue(ptype:PerkType, valueIdx:Number = 1, bonus:Number = 0): void
		{
			var counter:int = findPerk(ptype);
			if (counter < 0) {
				trace("ERROR? Looking for perk '" + ptype + "' to change value " + valueIdx + ", and player does not have the perk.");
				return;
			}
			if (valueIdx < 1 || valueIdx > 4) {
				CoC_Settings.error("addPerkValue(" + ptype.id + ", " + valueIdx + ", " + bonus + ").");
				return;
			}
			if (valueIdx == 1)
				perk(counter).value1 += bonus;
			if (valueIdx == 2)
				perk(counter).value2 += bonus;
			if (valueIdx == 3)
				perk(counter).value3 += bonus;
			if (valueIdx == 4)
				perk(counter).value4 += bonus;
		}

		public function setPerkValue(ptype:PerkType, valueIdx:Number = 1, newNum:Number = 0): void
		{
			var counter:Number = findPerk(ptype);
			//Various Errors preventing action
			if (counter < 0) {
				trace("ERROR? Looking for perk '" + ptype + "' to change value " + valueIdx + ", and player does not have the perk.");
				return;
			}
			if (valueIdx < 1 || valueIdx > 4)
			{
				CoC_Settings.error("setPerkValue(" + ptype.id + ", " + valueIdx + ", " + newNum + ").");
				return;
			}
			if (valueIdx == 1)
				perk(counter).value1 = newNum;
			if (valueIdx == 2)
				perk(counter).value2 = newNum;
			if (valueIdx == 3)
				perk(counter).value3 = newNum;
			if (valueIdx == 4)
				perk(counter).value4 = newNum;
		}

		public function perkv1(ptype:PerkType):Number
		{
			var counter:Number = findPerk(ptype);
			if (counter < 0)
			{
				// trace("ERROR? Looking for perk '" + ptype + "', but player does not have it.");
				return 0;
			}
			return perk(counter).value1;
		}

	public function perkv2(ptype:PerkType):Number
	{
		var counter:Number = findPerk(ptype);
		if (counter < 0)
		{
			// trace("ERROR? Looking for perk '" + ptype + "', but player does not have it.");
			return 0;
		}
		return perk(counter).value2;
	}

	public function perkv3(ptype:PerkType):Number
	{
		var counter:Number = findPerk(ptype);
		if (counter < 0)
		{
			trace("ERROR? Looking for perk '" + ptype + "', but player does not have it.");
			return 0;
		}
		return perk(counter).value3;
	}

	public function perkv4(ptype:PerkType):Number
	{
		var counter:Number = findPerk(ptype);
		if (counter < 0)
		{
			// trace("ERROR? Looking for perk '" + ptype + "', but player does not have it.");
			return 0;
		}
		return perk(counter).value4;
	}

		//{region StatusEffects
		//Create a status
		public function createStatusEffect(stype:StatusEffectType, value1:Number, value2:Number, value3:Number, value4:Number):void
		{
			var newStatusEffect:StatusEffectClass = new StatusEffectClass(stype,value1,value2,value3,value4);
			statusEffects.push(newStatusEffect);
			//trace("createStatusEffect -> "+statusEffects.join(","));
			//trace("NEW STATUS APPLIED TO PLAYER!: " + statusName);
		}

		//Remove a status
		public function removeStatusEffect(stype:StatusEffectType):void
		{
			var counter:Number = indexOfStatusEffect(stype);
			if (counter < 0) return;
			statusEffects.splice(counter, 1);
			//trace("removeStatusEffect -> "+statusEffects.join(","));
		}
		public function indexOfStatusEffect(stype:StatusEffectType):int {
			for (var counter:int = 0; counter < statusEffects.length; counter++) {
				if ((statusEffects[counter] as StatusEffectClass).stype == stype)
					return counter;
			}
			return -1;
		}
		public function statusEffectByType(stype:StatusEffectType):StatusEffectClass {
			var idx:int = indexOfStatusEffect(stype);
			return idx<0 ? null : statusEffects[idx];
		}
		public function hasStatusEffect(stype:StatusEffectType):Boolean {
			return indexOfStatusEffect(stype) >= 0;
		}
		//}endregion


		public function changeStatusValue(stype:StatusEffectType, statusValueNum:Number = 1, newNum:Number = 0):void
		{
			if (statusValueNum < 1 || statusValueNum > 4) {
				CoC_Settings.error("ChangeStatusValue called with invalid status value number.");
				return;
			}
			var sac:StatusEffectClass = statusEffectByType(stype);
			//Various Errors preventing action
			if (!sac)return;
			if (statusValueNum == 1) sac.value1 = newNum;
			if (statusValueNum == 2) sac.value2 = newNum;
			if (statusValueNum == 3) sac.value3 = newNum;
			if (statusValueNum == 4) sac.value4 = newNum;
		}

		public function addStatusValue(stype:StatusEffectType, statusValueNum:Number = 1, bonus:Number = 0):void
		{
			if (statusValueNum < 1 || statusValueNum > 4) {
				CoC_Settings.error("ChangeStatusValue called with invalid status value number.");
				return;
			}
			var sac:StatusEffectClass = statusEffectByType(stype);
			//Various Errors preventing action
			if (!sac)return;
			if (statusValueNum == 1) sac.value1 += bonus;
			if (statusValueNum == 2) sac.value2 += bonus;
			if (statusValueNum == 3) sac.value3 += bonus;
			if (statusValueNum == 4) sac.value4 += bonus;
		}

		public function statusEffectByIndex(idx:int):StatusEffectClass {
			return statusEffects[idx];
		}

		public function statusEffectv1(stype:StatusEffectType):Number
		{
			var sac:StatusEffectClass = statusEffectByType(stype);
			return sac?sac.value1:0;
		}

		public function statusEffectv2(stype:StatusEffectType):Number
		{
			var sac:StatusEffectClass = statusEffectByType(stype);
			return sac?sac.value2:0
		}

		public function statusEffectv3(stype:StatusEffectType):Number
		{
			var sac:StatusEffectClass = statusEffectByType(stype);
			return sac?sac.value3:0
		}

		public function statusEffectv4(stype:StatusEffectType):Number
		{
			var sac:StatusEffectClass = statusEffectByType(stype);
			return sac?sac.value4:0
		}

		public function removeStatuses():void
		{
			statusEffects = [];
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

		public function cockArea(i_cockIndex:Number):Number
		{
			if (i_cockIndex >= cocks.length || i_cockIndex < 0)
				return 0;
			return (cocks[i_cockIndex].cockThickness * cocks[i_cockIndex].cockLength);
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
			return cocks[thinnest].cockThickness + cocks[thinnest2].cockThickness < width;
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

		//Find the biggest cock that fits inside a given range
		public function cockThatFits(i_fits:Number, type:String = "area", i_min:Number = 0):Number
		{
			if (cocks.length <= 0)
				return -1;
			var i:int = cocks.length;
			//Current largest fitter
			var best:int = -1;
			while (i > 0)
			{
				i--;
				var ival:Number;
				var bestval:Number;
				if (type == "area") {
					ival   = cockArea(i);
					bestval = best==-1?0:cockArea(best);
				} else if (type == "length") {
					ival = cocks[i].cockLength;
					bestval = best==-1?0:cocks[best].cockLength;
				}
				if (i_min <= ival && ival <= i_fits)
				{
					//If one already fits
					if (best >= 0)
					{
						//See if the newcomer beats the saved small guy
						if (ival > bestval)
							best = i;
					}
					//Store the index of fitting dick
					else
						best = i;
				}
			}
			return best;
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


		public function cockDescript(cockIndex:int = 0):String
		{
			return Appearance.cockDescript(this, cockIndex);
		}

		public function cockAdjective(index:Number = -1):String {
			if (index < 0) index = biggestCockIndex();
			var isPierced:Boolean = (cocks.length == 1) && (cocks[index].isPierced); //Only describe as pierced or sock covered if the creature has just one cock
			var hasSock:Boolean = (cocks.length == 1) && (cocks[index].sock != "");
			var isGooey:Boolean = (skin.type == SKIN_TYPE_GOO);
			return Appearance.cockAdjective(cocks[index].cockType, cocks[index].cockLength, cocks[index].cockThickness, lust, cumQ(), isPierced, hasSock, isGooey);
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
			var total:Number;
			var bonus:Number = 0;
			//Centaurs = +50 capacity
			if (isTaur())
				bonus = 50;
			//Naga = +20 capacity
			else if (lowerBody == 3)
				bonus = 20;
			//Wet pussy provides 20 point boost
			if (findPerk(PerkLib.WetPussy) >= 0)
				bonus += 20;
			if (findPerk(PerkLib.HistorySlut) >= 0 || findPerk(PerkLib.PastLifeSlut) >= 0)
				bonus += 20;
			if (findPerk(PerkLib.OneTrackMind) >= 0)
				bonus += 10;
			if (findPerk(PerkLib.Cornucopia) >= 0)
				bonus += 30;
			if(findPerk(PerkLib.FerasBoonWideOpen) >= 0)
				bonus += 25;
			if(findPerk(PerkLib.FerasBoonMilkingTwat) >= 0)
				bonus += 40;
			total = (bonus + statusEffectv1(StatusEffects.BonusVCapacity) + 8 * vaginas[0].vaginalLooseness * vaginas[0].vaginalLooseness) * (1 + vaginas[0].vaginalWetness / 10);
			return total;
		}

		public function analCapacity():Number
		{
			var bonus:Number = 0;
			//Centaurs = +30 capacity
			if (isTaur())
				bonus = 30;
			if (findPerk(PerkLib.HistorySlut) >= 0 || findPerk(PerkLib.PastLifeSlut) >= 0)
				bonus += 20;
			if (findPerk(PerkLib.Cornucopia) >= 0)
				bonus += 30;
			if (findPerk(PerkLib.OneTrackMind) >= 0)
				bonus += 10;
			if (ass.analWetness > 0)
				bonus += 15;
			return ((bonus + statusEffectv1(StatusEffects.BonusACapacity) + 6 * ass.analLooseness * ass.analLooseness) * (1 + ass.analWetness / 10));
		}

		public function hasFuckableNipples():Boolean
		{
			var counter:Number = breastRows.length;
			while (counter > 0)
			{
				counter--;
				if (breastRows[counter].fuckable)
					return true;
			}
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
			while (counter > 0)
			{
				counter--;
				if (breastRows[counter].nipplesPerBreast > 0)
					return true;
			}
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
		public function milked():void
		{
			if (hasStatusEffect(StatusEffects.LactationReduction))
				changeStatusValue(StatusEffects.LactationReduction, 1, 0);
			if (hasStatusEffect(StatusEffects.LactationReduc0))
				removeStatusEffect(StatusEffects.LactationReduc0);
			if (hasStatusEffect(StatusEffects.LactationReduc1))
				removeStatusEffect(StatusEffects.LactationReduc1);
			if (hasStatusEffect(StatusEffects.LactationReduc2))
				removeStatusEffect(StatusEffects.LactationReduc2);
			if (hasStatusEffect(StatusEffects.LactationReduc3))
				removeStatusEffect(StatusEffects.LactationReduc3);
			if (findPerk(PerkLib.Feeder) >= 0)
			{
				//You've now been milked, reset the timer for that
				addStatusValue(StatusEffects.Feeder,1,1);
				changeStatusValue(StatusEffects.Feeder, 2, 0);
			}
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
				if (hasStatusEffect(StatusEffects.LactationReduction))
					changeStatusValue(StatusEffects.LactationReduction, 1, 0);
				if (hasStatusEffect(StatusEffects.LactationReduc0))
					removeStatusEffect(StatusEffects.LactationReduc0);
				if (hasStatusEffect(StatusEffects.LactationReduc1))
					removeStatusEffect(StatusEffects.LactationReduc1);
				if (hasStatusEffect(StatusEffects.LactationReduc2))
					removeStatusEffect(StatusEffects.LactationReduc2);
				if (hasStatusEffect(StatusEffects.LactationReduc3))
					removeStatusEffect(StatusEffects.LactationReduc3);
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
			if (findPerk(PerkLib.BroBody) >= 0)
				percent += 0.05;
			if (findPerk(PerkLib.MaraesGiftStud) >= 0)
				percent += 0.15;
			if (findPerk(PerkLib.FerasBoonAlpha) >= 0)
				percent += 0.10;
			if (perkv1(PerkLib.ElvenBounty) > 0)
				percent += 0.05;
			if (findPerk(PerkLib.FertilityPlus) >= 0)
				percent += 0.03;
			if (findPerk(PerkLib.FertilityMinus) >= 0 && lib < 25) //Reduces virility by 3%.
				percent -= 0.03;
			if (findPerk(PerkLib.PiercedFertite) >= 0)
				percent += 0.03;
			if (findPerk(PerkLib.OneTrackMind) >= 0)
				percent += 0.03;
			if (findPerk(PerkLib.MagicalVirility) >= 0)
				percent += 0.05 + (perkv1(PerkLib.MagicalVirility) * 0.01);
			//Messy Orgasms?
			if (findPerk(PerkLib.MessyOrgasms) >= 0)
				percent += 0.03;
			//Satyr Sexuality
			if (findPerk(PerkLib.SatyrSexuality) >= 0)
				percent += 0.10;
			//Fertite ring bonus!
			if (jewelryEffectId == JewelryLib.MODIFIER_FERTILITY)
				percent += (jewelryEffectMagnitude / 100);
			if (findPerk(PerkLib.AscensionVirility) >= 0)
				percent += perkv1(PerkLib.AscensionVirility) * 0.05;
			if (percent > 1)
				percent = 1;
			if (percent < 0)
				percent = 0;

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
			//If realistic mode is enabled, limits cum to capacity.
			if (flags[kFLAGS.HUNGER_ENABLED] >= 1)
			{
				lustCoefficient = (lust + 50) / 5;
				if (findPerk(PerkLib.PilgrimsBounty) >= 0) lustCoefficient = 30;
				var percent:Number = 0;
				percent = lustCoefficient + (hoursSinceCum + 10);
				if (percent > 100)
					percent = 100;
				if (quantity > cumCapacity())
					quantity = cumCapacity();
				return (percent / 100) * cumCapacity();
			}
			//Pilgrim's bounty maxes lust coefficient
			if (findPerk(PerkLib.PilgrimsBounty) >= 0)
				lustCoefficient = 150 / 10;
			if (balls == 0)
				quantity = int(1.25 * 2 * cumMultiplier * 2 * lustCoefficient * (hoursSinceCum + 10) / 24) / 10;
			else
				quantity = int(ballSize * balls * cumMultiplier * 2 * lustCoefficient * (hoursSinceCum + 10) / 24) / 10;
			if (findPerk(PerkLib.BroBody) >= 0)
				quantity *= 1.3;
			if (findPerk(PerkLib.FertilityPlus) >= 0)
				quantity *= 1.5;
			if (findPerk(PerkLib.FertilityMinus) >= 0 && lib < 25)
				quantity *= 0.7;
			if (findPerk(PerkLib.MessyOrgasms) >= 0)
				quantity *= 1.5;
			if (findPerk(PerkLib.OneTrackMind) >= 0)
				quantity *= 1.1;
			if (findPerk(PerkLib.MaraesGiftStud) >= 0)
				quantity += 350;
			if (findPerk(PerkLib.FerasBoonAlpha) >= 0)
				quantity += 200;
			if (findPerk(PerkLib.MagicalVirility) >= 0)
				quantity += 200 + (perkv1(PerkLib.MagicalVirility) * 100);
			if(findPerk(PerkLib.FerasBoonSeeder) >= 0)
				quantity += 1000;
			if (findPerk(PerkLib.ProductivityDrugs) >= 0)
				quantity += (perkv3(PerkLib.ProductivityDrugs));
			//if(hasPerk("Elven Bounty") >= 0) quantity += 250;;
			quantity += perkv1(PerkLib.ElvenBounty);
			if (findPerk(PerkLib.BroBody) >= 0)
				quantity += 200;
			if (findPerk(PerkLib.SatyrSexuality) >= 0)
				quantity += 50;
			quantity += statusEffectv1(StatusEffects.Rut);
			quantity *= (1 + (2 * perkv1(PerkLib.PiercedFertite)) / 100);
			if (jewelryEffectId == JewelryLib.MODIFIER_FERTILITY)
				quantity *= (1 + (jewelryEffectMagnitude / 100));
			//trace("Final Cum Volume: " + int(quantity) + "mLs.");
			//if (quantity < 0) trace("SOMETHING HORRIBLY WRONG WITH CUM CALCULATIONS");
			if (quantity < 2)
				quantity = 2;
			if (quantity > int.MAX_VALUE)
				quantity = int.MAX_VALUE;
			return quantity;
		}

		//Limits how much cum you can produce. Can be altered with perks, ball size, and multiplier. Only applies to realistic mode.
		public function cumCapacity():Number
		{
			if (!hasCock()) return 0;
			var cumCap:Number = 0;
			//Alter capacity by balls.
			var balls:Number = this.balls;
			var ballSize:Number = this.ballSize;
			if (balls == 0) {
				balls = 2;
				ballSize = 1;
			}
			cumCap += Math.pow(((4 / 3) * Math.PI * (ballSize / 2)), 3) * balls;// * cumMultiplier
			// * cumMultiplier
			//Alter capacity by perks.
			if (findPerk(PerkLib.BroBody) >= 0) cumCap *= 1.3;
			if (findPerk(PerkLib.FertilityPlus) >= 0) cumCap *= 1.5;
			if (findPerk(PerkLib.FertilityMinus) >= 0 && lib < 25) cumCap *= 0.7;
			if (findPerk(PerkLib.MessyOrgasms) >= 0) cumCap *= 1.5;
			if (findPerk(PerkLib.OneTrackMind) >= 0) cumCap *= 1.1;
			if (findPerk(PerkLib.MaraesGiftStud) >= 0) cumCap += 350;
			if (findPerk(PerkLib.FerasBoonAlpha) >= 0) cumCap += 200;
			if (findPerk(PerkLib.MagicalVirility) >= 0) cumCap += 200;
			if (findPerk(PerkLib.FerasBoonSeeder) >= 0) cumCap += 1000;
			cumCap += perkv1(PerkLib.ElvenBounty);
			if (findPerk(PerkLib.BroBody) >= 0) cumCap += 200;
			cumCap += statusEffectv1(StatusEffects.Rut);
			cumCap *= (1 + (2 * perkv1(PerkLib.PiercedFertite)) / 100);
			//Alter capacity by accessories.
			if (jewelryEffectId == JewelryLib.MODIFIER_FERTILITY) cumCap *= (1 + (jewelryEffectMagnitude / 100));

			cumCap *= cumMultiplier;
			cumCap = Math.round(cumCap);
			if (cumCap > int.MAX_VALUE)
				cumCap = int.MAX_VALUE;
			return cumCap;
		}

		public function countCocksOfType(type:CockTypesEnum):int {
			if (cocks.length == 0) return 0;
			var counter:int = 0;
			for (var x:int = 0; x < cocks.length; x++) {
				if (cocks[x].cockType == type) counter++;
			}
			return counter;
		}

		public function anemoneCocks():int { //How many anemonecocks?
			return countCocksOfType(CockTypesEnum.ANEMONE);
		}

		public function catCocks():int { //How many catcocks?
			return countCocksOfType(CockTypesEnum.CAT);
		}

		public function demonCocks():int { //How many demoncocks?
			return countCocksOfType(CockTypesEnum.DEMON);
		}

		public function displacerCocks():int { //How many displacerCocks?
			return countCocksOfType(CockTypesEnum.DISPLACER);
		}

		// Note: DogCocks/FoxCocks are functionally identical. They actually change back and forth depending on some
		// of the PC's attributes, and this is recaluculated every hour spent at camp.
		// As such, delineating between the two is kind of silly.
		public function dogCocks():int { //How many dogCocks
			if (cocks.length == 0) return 0;
			var counter:int = 0;
			for (var x:int = 0; x < cocks.length; x++) {
				if (cocks[x].cockType == CockTypesEnum.DOG || cocks[x].cockType == CockTypesEnum.FOX || cocks[x].cockType == CockTypesEnum.WOLF) counter++;
			}
			return counter;
		}

		public function dragonCocks():int { //How many dragonCocks?
			return countCocksOfType(CockTypesEnum.DRAGON);
		}

		public function foxCocks():int { //How many foxCocks
			return countCocksOfType(CockTypesEnum.FOX);
		}

		public function wolfCocks():int { //How many wolfCocks
			return countCocksOfType(CockTypesEnum.WOLF);
		}

		public function horseCocks():int { //How many horsecocks?
			return countCocksOfType(CockTypesEnum.HORSE);
		}

		public function kangaCocks():int { //How many kangawangs?
			return countCocksOfType(CockTypesEnum.KANGAROO);
		}

		public function lizardCocks():int { //How many lizard/snake-cocks?
			return countCocksOfType(CockTypesEnum.LIZARD);
		}

		public function pigCocks():int { //How many lizard/snake-cocks?
			return countCocksOfType(CockTypesEnum.PIG);
		}

		public function normalCocks():int { //How many normalCocks?
			return countCocksOfType(CockTypesEnum.HUMAN);
		}

		public function tentacleCocks():int { //How many tentaclecocks?
			return countCocksOfType(CockTypesEnum.TENTACLE);
		}

		public function stamenCocks():int { //How many stamencocks?
			return countCocksOfType(CockTypesEnum.STAMEN);
		}

		public function findFirstCockType(ctype:CockTypesEnum):Number
		{
			var index:Number = 0;
			//if (cocks[index].cockType == ctype)
			//	return index;
			for (index = 0; index < cocks.length; index++) {
				if (cocks[index].cockType == ctype)
					return index;
			}
			//trace("Creature.findFirstCockType ERROR - searched for cocktype: " + ctype + " and could not find it.");
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
			//trace("Creature.findFirstCockType ERROR - searched for cocktype: " + type + " and could not find it.");
			return 0;
		}*/

		//Change first normal cock to horsecock!
		//Return number of affected cock, otherwise -1
		public function addHorseCock():Number
		{
			var counter:Number = cocks.length;
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
				//Wolf - > horse
				if (cocks[counter].cockType == CockTypesEnum.WOLF)
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

		//TODO Seriously wtf. 1500+ calls to cockTotal, 340+ call to totalCocks. I'm scared to touch either.
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
			return cocks.length >= 1;

		}

		public function hasSockRoom():Boolean
		{
			var index:int = cocks.length;
			while (index > 0)
			{
				index--;
				if (cocks[index].sock == "")
					return true;
			}
			return false
		}

	//	[Deprecated]
		public function hasSock(arg:String = ""):Boolean
		{
			var index:int = cocks.length;

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
		public function countCockSocks(type:String):int
		{
			var count:int = 0;

			for (var i:Number = 0; i < cocks.length; i++) {
				if (cocks[i].sock == type) {
					count++
				}
			}
			//trace("countCockSocks found " + count + " " + type);
			return count;
		}

		public function canAutoFellate():Boolean
		{
			if (!hasCock())
				return false;
			return (cocks[0].cockLength >= 20);
		}

		public static const canFlyWings:Array = [
			WING_TYPE_BEE_LIKE_LARGE,
			WING_TYPE_BAT_LIKE_LARGE,
			WING_TYPE_BAT_LIKE_LARGE_2,
			WING_TYPE_FEATHERED_LARGE,
			WING_TYPE_FEATHERED_PHOENIX,
			WING_TYPE_DRACONIC_LARGE,
			WING_TYPE_DRACONIC_HUGE,
			WING_TYPE_GIANT_DRAGONFLY,
			WING_TYPE_MANTIS_LIKE_LARGE,
			WING_TYPE_MANTIS_LIKE_LARGE_2,
			WING_TYPE_MANTICORE_LIKE_LARGE,
			//WING_TYPE_IMP_LARGE,
		];

		//PC can fly?
		public function canFly():Boolean
		{
			//web also makes false!
			if (hasStatusEffect(StatusEffects.Web))
				return false;
			return canFlyWings.indexOf(_wingType) != -1;

		}

		//PC can swim underwater?
		public function canSwimUnderwater():Boolean
		{
			if (gillType != GILLS_NONE)
				return true;	//dodać jeszcze trzeba bdzie tu efekt of itemów i inne opcje dające oddych. pod wodą
			return false;
		}

		//Artifacts Bows
		public function isArtifactBow():Boolean
		{
			if (game.player.weaponRange == game.weaponsrange.BOWGUID)
				return true;
			return false;
		}

		//Wrath Weapons
		public function isLowGradeWrathWeapon():Boolean
		{
			if (game.player.weapon == game.weapons.BFSWORD || game.player.weapon == game.weapons.DBFSWO || game.player.weapon == game.weapons.OTETSU || game.player.weapon == game.weapons.CNTWHIP)
				return true;
			return false;
		}

		//Fists and fist weapons
		public function isFistOrFistWeapon():Boolean
		{
			if (game.player.weaponName == "fists" || game.player.weapon == game.weapons.S_GAUNT || game.player.weapon == game.weapons.H_GAUNT)
				return true;
			return false;
		}

		//Weapons for Whirlwind
		public function isWeaponForWhirlwind():Boolean
		{
			if (game.player.weapon == game.weapons.BFSWORD || game.player.weapon == game.weapons.CLAYMOR || game.player.weapon == game.weapons.URTAHLB || game.player.weapon == game.weapons.KIHAAXE || game.player.weapon == game.weapons.L__AXE || game.player.weapon == game.weapons.L_HAMMR || game.player.weapon == game.weapons.TRASAXE || game.player.weapon == game.weapons.WARHAMR
			 || game.player.weapon == game.weapons.OTETSU || game.player.weapon == game.weapons.NODACHI || game.player.weapon == game.weapons.WGSWORD || game.player.weapon == game.weapons.DBFSWO || game.player.weapon == game.weapons.D_WHAM_ || game.player.weapon == game.weapons.DL_AXE_ || game.player.weapon == game.weapons.DSWORD_)// || game.player.weapon == game.weapons.
				return true;
			return false;
		}

		//Weapons for Whipping
		public function isWeaponsForWhipping():Boolean
		{
			if (game.player.weapon == game.weapons.FLAIL || game.player.weapon == game.weapons.L_WHIP || game.player.weapon == game.weapons.SUCWHIP || game.player.weapon == game.weapons.PSWHIP || game.player.weapon == game.weapons.WHIP || game.player.weapon == game.weapons.PWHIP || game.player.weapon == game.weapons.NTWHIP || game.player.weapon == game.weapons.CNTWHIP
			 || game.player.weapon == game.weapons.RIBBON || game.player.weapon == game.weapons.ERIBBON)
				return true;
			return false;
		}

		//Using Tome
		public function isUsingTome():Boolean
		{
			if (game.player.weaponRangeName == "nothing" || game.player.weaponRangeName == "Inquisitor’s Tome" || game.player.weaponRangeName == "Sage’s Sketchbook")
				return true;
			return false;
		}

		//Natural Jouster perks req check
		public function isMeetingNaturalJousterReq():Boolean
		{
			if ((((game.player.isTaur() || game.player.isDrider()) && game.player.spe >= 60) && game.player.findPerk(PerkLib.Naturaljouster) >= 0 && (game.player.findPerk(PerkLib.DoubleAttack) < 0 || (game.player.findPerk(PerkLib.DoubleAttack) >= 0 && kGAMECLASS.flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)))
			 || (game.player.spe >= 150 && game.player.findPerk(PerkLib.Naturaljouster) >= 0 && game.player.findPerk(PerkLib.DoubleAttack) >= 0 && (game.player.findPerk(PerkLib.DoubleAttack) < 0 || (game.player.findPerk(PerkLib.DoubleAttack) >= 0 && kGAMECLASS.flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0))))
				return true;
			return false;
		}
		public function isMeetingNaturalJousterMasterGradeReq():Boolean
		{
			if ((((game.player.isTaur() || game.player.isDrider()) && game.player.spe >= 180) && game.player.findPerk(PerkLib.NaturaljousterMastergrade) >= 0 && (game.player.findPerk(PerkLib.DoubleAttack) < 0 || (game.player.findPerk(PerkLib.DoubleAttack) >= 0 && kGAMECLASS.flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)))
			 || (game.player.spe >= 450 && game.player.findPerk(PerkLib.NaturaljousterMastergrade) >= 0 && game.player.findPerk(PerkLib.DoubleAttack) >= 0 && (game.player.findPerk(PerkLib.DoubleAttack) < 0 || (game.player.findPerk(PerkLib.DoubleAttack) >= 0 && kGAMECLASS.flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0))))
				return true;
			return false;
		}

		//1H Weapons
		public function isOneHandedWeapons():Boolean
		{
			if (game.player.weaponPerk != "Dual Large" && game.player.weaponPerk != "Dual" && game.player.weaponPerk != "Staff" && game.player.weaponPerk != "Large")
				return true;
			return false;
		}

		//Naked
		public function isNaked():Boolean
		{
			if (game.player.armorName == "nothing" && game.player.upperGarmentName == "nothing" && game.player.lowerGarmentName == "nothing")
				return true;
			return false;
		}

		//Crit immunity
		public function isImmuneToCrits():Boolean
		{
			if (game.monster.findPerk(PerkLib.EnemyConstructType) >= 0)
				return true;//potem inne typy wrogów dodać tutaj: goo, żywiołaki, rośliny, nieumarli/duchy
			return false;
		}

		//check for vagoo
		public function hasVagina():Boolean
		{
			return vaginas.length > 0;

		}

		public function hasVirginVagina():Boolean
		{
			if (vaginas.length > 0)
				return vaginas[0].virgin;
			return false;
		}

		//GENDER IDENTITIES
		public function genderText(male:String = "man", female:String = "woman", futa:String = "herm", eunuch:String = "eunuch"):String
		{
			if (vaginas.length > 0) {
				if (cocks.length > 0) return futa;
				return female;
			}
			else if (cocks.length > 0) {
				return male;
			}
			return eunuch;
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

		public function mfn(male:String, female:String, neuter:String):String
		{
			if (gender == 0)
				return neuter;
			else
				return mf(male, female);
		}
		public function looksMale():Boolean {
			return !looksFemale();
		}
		
		public function looksFemale():Boolean {
			var tits:Number = biggestTitSize();
			switch(gender) {
				case GENDER_HERM:
                case GENDER_NONE:
                    return ((tits >= 3 || tits == 2 && femininity >= 15 || tits == 1 && femininity >= 40 || femininity >= 65) && (flags[kFLAGS.MALE_OR_FEMALE] == 0 || flags[kFLAGS.MALE_OR_FEMALE] == 2));
				case GENDER_MALE:
                    return ((tits >= 3 && femininity >= 5 || tits == 2 && femininity >= 35 || tits == 1 && femininity >= 65 || femininity >= 95) && (flags[kFLAGS.MALE_OR_FEMALE] == 0 || flags[kFLAGS.MALE_OR_FEMALE] == 2));
                case GENDER_FEMALE:
                    return ((tits > 1 || tits == 1 && femininity >= 15 || femininity >= 45) && (flags[kFLAGS.MALE_OR_FEMALE] == 0 || flags[kFLAGS.MALE_OR_FEMALE] == 2));
				default: return false;
			}
		}
		//Rewritten!
		public function mf(male:String, female:String):String
		{
			return looksMale() ? male : female;
		}
		
		public function maleFemaleHerm(caps:Boolean = false):String
		{
			switch (gender) {
				case GENDER_NONE:   return caps ? mf("Genderless", "Fem-genderless") : mf("genderless", "fem-genderless");
				case GENDER_MALE:   return caps ? mf("Male", biggestTitSize() > BREAST_CUP_A ? "Shemale" : "Femboy")             : mf("male", biggestTitSize() > BREAST_CUP_A ? "shemale" : "femboy");
				case GENDER_FEMALE: return caps ? mf("Cuntboy", "Female")            : mf("cuntboy", "female");
				case GENDER_HERM:   return caps ? mf("Maleherm", "Hermaphrodite")    : mf("maleherm", "hermaphrodite");
				default: return "<b>Gender error!</b>";
			}
		}
		
		/**
		 * Checks if the creature is technically male: has cock but not vagina.
		 */
		public function isMale():Boolean
		{
			return gender == GENDER_MALE;
		}
		
		/**
		 * Checks if the creature is technically female: has vagina but not cock.
		 */
		public function isFemale():Boolean
		{
			return gender == GENDER_FEMALE;
					}

		/**
		 * Checks if the creature is technically herm: has both cock and vagina.
		 */
		public function isHerm():Boolean
					{
			return gender == GENDER_HERM;
					}

		/**
		 * Checks if the creature is technically genderless: has neither cock nor vagina.
		 */
		public function isGenderless():Boolean
				{
			return gender == GENDER_NONE;
				}

		/**
		 * Checks if the creature is technically male or herm: has at least a cock.
		 */
		public function isMaleOrHerm():Boolean
			{
			return (gender & GENDER_MALE) != 0;
				}

		/**
		 * Checks if the creature is technically female or herm: has at least a vagina.
		 */
		public function isFemaleOrHerm():Boolean
				{
			return (gender & GENDER_FEMALE) != 0;
					}

		//Create a cock. Default type is HUMAN
		public function createCock(clength:Number = 5.5, cthickness:Number = 1,ctype:CockTypesEnum=null):Boolean
		{
			if (ctype == null) ctype = CockTypesEnum.HUMAN;
			if (cocks.length >= 10)
				return false;
			var newCock:Cock = new Cock(clength, cthickness,ctype);
			newCock.host = this;
			//var newCock:cockClass = new cockClass();
			cocks.push(newCock);
			cocks[cocks.length-1].cockThickness = cthickness;
			cocks[cocks.length-1].cockLength = clength;
			return true;
		}

		//create vagoo
		public function createVagina(virgin:Boolean = true, vaginalWetness:Number = 1, vaginalLooseness:Number = 0):Boolean
		{
			if (vaginas.length >= 2)
				return false;
			var newVagina:VaginaClass = new VaginaClass(vaginalWetness,vaginalLooseness,virgin);
			newVagina.host = this;
			vaginas.push(newVagina);
			return true;
		}

		//create a row of breasts
		public function createBreastRow(size:Number=0,nipplesPerBreast:Number=1):Boolean
		{
			if (breastRows.length >= 10)
				return false;
			var newBreastRow:BreastRowClass = new BreastRowClass();
			newBreastRow.breastRating = size;
			newBreastRow.nipplesPerBreast = nipplesPerBreast;
			breastRows.push(newBreastRow);
			return true;
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
					try
					{
						var cock:Cock = cocks[arraySpot];
						if (cock.sock == "viridian")
						{
							removePerk(PerkLib.LustyRegeneration);
						}
						else if (cock.sock == "cockring")
						{
							var numRings:int = 0;
							for (var i:int = 0; i < cocks.length; i++)
							{
								if (cocks[i].sock == "cockring") numRings++;
							}

							if (numRings == 0) removePerk(PerkLib.PentUp);
							else setPerkValue(PerkLib.PentUp, 1, 5 + (numRings * 5));
						}
						cocks.splice(arraySpot, totalRemoved);
					}
					catch (e:Error)
					{
						trace("Argument error in Creature[" + this._short + "]: " + e.message);
					}
					//trace("Attempted to remove " + totalRemoved + " cocks.");
				}
			}
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
			else if (breastRows.length == 1 || breastRows.length - totalRemoved < 1)
			{
				//trace("ERROR: Removing the current breast row would break the Creature classes assumptions about breastRow contents.");
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

		// This is placeholder shit whilst I work out a good way of BURNING ENUM TO THE FUCKING GROUND
		// and replacing it with something that will slot in and work with minimal changes and not be
		// A FUCKING SHITSTAIN when it comes to intelligent de/serialization.
		public function fixFuckingCockTypesEnum():void
		{
			if (this.cocks.length > 0)
			{
				for (var i:int = 0; i < this.cocks.length; i++)
				{
					this.cocks[i].cockType = CockTypesEnum.ParseConstantByIndex(this.cocks[i].cockType.Index);
				}
			}
		}

		public function buttChangeNoDisplay(cArea:Number):Boolean {
			var stretched:Boolean = false;
			//cArea > capacity = autostreeeeetch half the time.
			if(cArea >= analCapacity() && rand(2) == 0) {
				if(ass.analLooseness >= 5) {}
				else ass.analLooseness++;
				stretched = true;
				//Reset butt stretchin recovery time
				if(hasStatusEffect(StatusEffects.ButtStretched)) changeStatusValue(StatusEffects.ButtStretched,1,0);
			}
			//If within top 10% of capacity, 25% stretch
			if(cArea < analCapacity() && cArea >= .9*analCapacity() && rand(4) == 0) {
				ass.analLooseness++;
				stretched = true;
			}
			//if within 75th to 90th percentile, 10% stretch
			if(cArea < .9 * analCapacity() && cArea >= .75 * analCapacity() && rand(10) == 0) {
				ass.analLooseness++;
				stretched = true;
			}
			//Anti-virgin
			if(ass.analLooseness == 0) {
				ass.analLooseness++;
				stretched = true;
			}
			//Delay un-stretching
			if(cArea >= .5 * analCapacity()) {
				//Butt Stretched used to determine how long since last enlargement
				if(!hasStatusEffect(StatusEffects.ButtStretched)) createStatusEffect(StatusEffects.ButtStretched,0,0,0,0);
				//Reset the timer on it to 0 when restretched.
				else changeStatusValue(StatusEffects.ButtStretched,1,0);
			}
			if(stretched) {
				trace("BUTT STRETCHED TO " + (ass.analLooseness) + ".");
			}
			return stretched;
		}

		public function cuntChangeNoDisplay(cArea:Number):Boolean{
			if(vaginas.length == 0) return false;
			var stretched:Boolean = false;
			if(findPerk(PerkLib.FerasBoonMilkingTwat) < 0 || vaginas[0].vaginalLooseness <= VAGINA_LOOSENESS_NORMAL) {
			//cArea > capacity = autostreeeeetch.
			if(cArea >= vaginalCapacity()) {
				if(vaginas[0].vaginalLooseness >= VAGINA_LOOSENESS_LEVEL_CLOWN_CAR) {}
				else vaginas[0].vaginalLooseness++;
				stretched = true;
			}
			//If within top 10% of capacity, 50% stretch
			else if(cArea >= .9 * vaginalCapacity() && rand(2) == 0) {
				vaginas[0].vaginalLooseness++;
				stretched = true;
			}
			//if within 75th to 90th percentile, 25% stretch
			else if(cArea >= .75 * vaginalCapacity() && rand(4) == 0) {
				vaginas[0].vaginalLooseness++;
				stretched = true;
				}
			}
			//If virgin
			if(vaginas[0].virgin) {
				vaginas[0].virgin = false;
			}
			//Delay anti-stretching
			if(cArea >= .5 * vaginalCapacity()) {
				//Cunt Stretched used to determine how long since last enlargement
				if(!hasStatusEffect(StatusEffects.CuntStretched)) createStatusEffect(StatusEffects.CuntStretched,0,0,0,0);
				//Reset the timer on it to 0 when restretched.
				else changeStatusValue(StatusEffects.CuntStretched,1,0);
			}
			if(stretched) {
				trace("CUNT STRETCHED TO " + (vaginas[0].vaginalLooseness) + ".");
			}
			return stretched;
		}

		public function get inHeat():Boolean {
			return hasStatusEffect(StatusEffects.Heat);
		}

		public function get inRut():Boolean {
			return hasStatusEffect(StatusEffects.Rut);
		}

		public function bonusFertility():Number
		{
			var counter:Number = 0;
			if (inHeat)
				counter += statusEffectv1(StatusEffects.Heat);
			if (findPerk(PerkLib.FertilityPlus) >= 0)
				counter += 15;
			if (findPerk(PerkLib.FertilityMinus) >= 0 && lib < 25)
				counter -= 15;
			if (findPerk(PerkLib.MaraesGiftFertility) >= 0)
				counter += 50;
			if (findPerk(PerkLib.FerasBoonBreedingBitch) >= 0)
				counter += 30;
			if (findPerk(PerkLib.MagicalFertility) >= 0)
				counter += 10 + (perkv1(PerkLib.MagicalFertility) * 5);
			counter += perkv2(PerkLib.ElvenBounty);
			counter += perkv1(PerkLib.PiercedFertite);
			if (jewelryEffectId == JewelryLib.MODIFIER_FERTILITY)
				counter += jewelryEffectMagnitude;
			counter += perkv1(PerkLib.AscensionFertility) * 5;
			return counter;
		}

		public function totalFertility():Number
		{
			return (bonusFertility() + fertility);
		}

		public function hasScales():Boolean { return skin.hasScales(); }
		public function hasReptileScales():Boolean { return skin.hasReptileScales(); }
		public function hasDragonScales():Boolean { return skin.hasDragonScales(); }
		public function hasLizardScales():Boolean { return skin.hasLizardScales(); }
		public function hasNonLizardScales():Boolean { return skin.hasNonLizardScales(); }
		public function hasFur():Boolean { return skin.hasFur(); }
		public function hasMostlyPlainSkin():Boolean { return skin.hasMostlyPlainSkin(); }
		public function hasPlainSkinOnly():Boolean { return skin.hasPlainSkinOnly(); }
		public function hasPartialCoat(coat_type:int):Boolean { return skin.hasPartialCoat(coat_type); }
		public function hasPlainSkin():Boolean { return skin.hasPlainSkin(); }
		public function hasGooSkin():Boolean { return skin.hasGooSkin(); }
		public function isGargoyle():Boolean { return skin.hasBaseOnly(SKIN_BASE_STONE); }
		public function skinDescript():String { return skin.describe('basic'); }
		public function skinFurScales():String { return skin.describe('cover'); }

		// <mod name="Predator arms" author="Stadler76">
		public function claws():String { return clawsPart.descriptionFull(); }
		// </mod>

		public function legs():String { return lowerBodyPart.legs(); }
		public function leg():String { return lowerBodyPart.leg(); }
		public function feet():String { return lowerBodyPart.feet(); }
		public function foot():String { return lowerBodyPart.foot(); }
		public function isDrider():Boolean { return lowerBodyPart.isDrider(); }
		public function isGoo():Boolean { return lowerBodyPart.isGoo(); }
		public function isBiped():Boolean { return lowerBodyPart.isBiped(); }
		public function isNaga():Boolean { return lowerBodyPart.isNaga(); }
		public function isTaur():Boolean { return lowerBodyPart.isTaur(); }
		public function isScylla():Boolean { return lowerBodyPart.isScylla(); }
		public function isAlraune():Boolean { return lowerBodyPart.isAlraune(); }

		public function canOvipositSpider():Boolean
		{
			if (eggs() >= 10 && findPerk(PerkLib.SpiderOvipositor) >= 0 && isDrider() && tail.type == TAIL_TYPE_SPIDER_ADBOMEN)
				return true;
			return false;
		}

		public function canOvipositBee():Boolean
		{
			if (eggs() >= 10 && findPerk(PerkLib.BeeOvipositor) >= 0 && tail.type == TAIL_TYPE_BEE_ABDOMEN)
				return true;
			return false;
		}

		public function canOviposit():Boolean
		{
			if (canOvipositSpider() || canOvipositBee())
				return true;
			return false;
		}

		public function eggs():int
		{
			if (findPerk(PerkLib.SpiderOvipositor) < 0 && findPerk(PerkLib.BeeOvipositor) < 0)
				return -1;
			else if (findPerk(PerkLib.SpiderOvipositor) >= 0)
				return perkv1(PerkLib.SpiderOvipositor);
			else
				return perkv1(PerkLib.BeeOvipositor);
		}

		public function addEggs(arg:int = 0):int
		{
			if (findPerk(PerkLib.SpiderOvipositor) < 0 && findPerk(PerkLib.BeeOvipositor) < 0)
				return -1;
			else {
				if (findPerk(PerkLib.SpiderOvipositor) >= 0) {
					addPerkValue(PerkLib.SpiderOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.SpiderOvipositor, 1, 50);
					return perkv1(PerkLib.SpiderOvipositor);
				}
				else {
					addPerkValue(PerkLib.BeeOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.BeeOvipositor, 1, 50);
					return perkv1(PerkLib.BeeOvipositor);
				}
			}
		}

		public function dumpEggs():void
		{
			if (findPerk(PerkLib.SpiderOvipositor) < 0 && findPerk(PerkLib.BeeOvipositor) < 0)
				return;
			setEggs(0);
			//Sets fertile eggs = regular eggs (which are 0)
			fertilizeEggs();
		}

		public function setEggs(arg:int = 0):int
		{
			if (findPerk(PerkLib.SpiderOvipositor) < 0 && findPerk(PerkLib.BeeOvipositor) < 0)
				return -1;
			else {
				if (findPerk(PerkLib.SpiderOvipositor) >= 0) {
					setPerkValue(PerkLib.SpiderOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.SpiderOvipositor, 1, 50);
					return perkv1(PerkLib.SpiderOvipositor);
				}
				else {
					setPerkValue(PerkLib.BeeOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.BeeOvipositor, 1, 50);
					return perkv1(PerkLib.BeeOvipositor);
				}
			}
		}

		public function fertilizedEggs():int
		{
			if (findPerk(PerkLib.SpiderOvipositor) < 0 && findPerk(PerkLib.BeeOvipositor) < 0)
				return -1;
			else if (findPerk(PerkLib.SpiderOvipositor) >= 0)
				return perkv2(PerkLib.SpiderOvipositor);
			else
				return perkv2(PerkLib.BeeOvipositor);
		}

		public function fertilizeEggs():int
		{
			if (findPerk(PerkLib.SpiderOvipositor) < 0 && findPerk(PerkLib.BeeOvipositor) < 0)
				return -1;
			else if (findPerk(PerkLib.SpiderOvipositor) >= 0)
				setPerkValue(PerkLib.SpiderOvipositor, 2, eggs());
			else
				setPerkValue(PerkLib.BeeOvipositor, 2, eggs());
			return fertilizedEggs();
		}

		public function breastCup(rowNum:Number):String
		{
			return Appearance.breastCup(breastRows[rowNum].breastRating);
		}

		public function bRows():Number
		{
			return breastRows.length;
		}

		public function totalBreasts():Number
		{
			var counter:Number = breastRows.length;
			var total:Number = 0;
			while (counter > 0) {
				counter--;
				total += breastRows[counter].breasts;
			}
			return total;
		}

		public function totalNipples():Number
		{
			var counter:Number = breastRows.length;
			var total:Number = 0;
			while (counter > 0) {
				counter--;
				total += breastRows[counter].nipplesPerBreast * breastRows[counter].breasts;
			}
			return total;
		}

		public function smallestTitSize():Number
		{
			if (breastRows.length == 0)
				return -1;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breastRating > breastRows[counter].breastRating)
					index = counter;
			}
			return breastRows[index].breastRating;
		}

		public function smallestTitRow():Number
		{
			if (breastRows.length == 0)
				return -1;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breastRating > breastRows[counter].breastRating)
					index = counter;
			}
			return index;
		}

		public function biggestTitRow():Number
		{
			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breastRating < breastRows[counter].breastRating)
					index = counter;
			}
			return index;
		}

		public function averageBreastSize():Number
		{
			var counter:Number = breastRows.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += breastRows[counter].breastRating;
			}
			if (breastRows.length == 0)
				return 0;
			return (average / breastRows.length);
		}

		public function averageCockThickness():Number
		{
			var counter:Number = cocks.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += cocks[counter].cockThickness;
			}
			if (cocks.length == 0)
				return 0;
			return (average / cocks.length);
		}

		public function averageNippleLength():Number
		{
			var counter:Number = breastRows.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += (breastRows[counter].breastRating / 10 + .2);
			}
			return (average / breastRows.length);
		}

		public function averageVaginalLooseness():Number
		{
			var counter:Number = vaginas.length;
			var average:Number = 0;
			//If the player has no vaginas
			if (vaginas.length == 0)
				return 2;
			while (counter > 0) {
				counter--;
				average += vaginas[counter].vaginalLooseness;
			}
			return (average / vaginas.length);
		}

		public function averageVaginalWetness():Number
		{
			//If the player has no vaginas
			if (vaginas.length == 0)
				return 2;
			var counter:Number = vaginas.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += vaginas[counter].vaginalWetness;
			}
			return (average / vaginas.length);
		}

		public function averageCockLength():Number
		{
			var counter:Number = cocks.length;
			var average:Number = 0;
			while (counter > 0) {
				counter--;
				average += cocks[counter].cockLength;
			}
			if (cocks.length == 0)
				return 0;
			return (average / cocks.length);
		}

		public function canTitFuck():Boolean
		{
			if (breastRows.length == 0) return false;

			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breasts < breastRows[counter].breasts && breastRows[counter].breastRating > 3)
					index = counter;
			}
			if (breastRows[index].breasts >= 2 && breastRows[index].breastRating > 3)
				return true;
			return false;
		}

		public function mostBreastsPerRow():Number
		{
			if (breastRows.length == 0) return 2;

			var counter:Number = breastRows.length;
			var index:Number = 0;
			while (counter > 0) {
				counter--;
				if (breastRows[index].breasts < breastRows[counter].breasts)
					index = counter;
			}
			return breastRows[index].breasts;
		}

		public function averageNipplesPerBreast():Number
		{
			var counter:Number = breastRows.length;
			var breasts:Number = 0;
			var nipples:Number = 0;
			while (counter > 0) {
				counter--;
				breasts += breastRows[counter].breasts;
				nipples += breastRows[counter].nipplesPerBreast * breastRows[counter].breasts;
			}
			if (breasts == 0)
				return 0;
			return Math.floor(nipples / breasts);
		}

		public function allBreastsDescript():String
		{
			return Appearance.allBreastsDescript(this);
		}

		//Simplified these cock descriptors and brought them into the creature class
		public function sMultiCockDesc():String {
			return (cocks.length > 1 ? "one of your " : "your ") + cockMultiLDescriptionShort();
		}

		public function SMultiCockDesc():String {
			return (cocks.length > 1 ? "One of your " : "Your ") + cockMultiLDescriptionShort();
		}

		public function oMultiCockDesc():String {
			return (cocks.length > 1 ? "each of your " : "your ") + cockMultiLDescriptionShort();
		}

		public function OMultiCockDesc():String {
			return (cocks.length > 1 ? "Each of your " : "Your ") + cockMultiLDescriptionShort();
		}

		private function cockMultiLDescriptionShort():String {
			if (cocks.length < 1) {
				CoC_Settings.error("<b>ERROR: NO WANGS DETECTED for cockMultiLightDesc()</b>");
				return "<b>ERROR: NO WANGS DETECTED for cockMultiLightDesc()</b>";
			}
			if (cocks.length == 1) { //For a songle cock return the default description
				return Appearance.cockDescript(this, 0);
			}
			switch (cocks[0].cockType) { //With multiple cocks only use the descriptions for specific cock types if all cocks are of a single type
				case CockTypesEnum.ANEMONE:
				case CockTypesEnum.WOLF:
				case CockTypesEnum.CAT:
				case CockTypesEnum.DEMON:
				case CockTypesEnum.DISPLACER:
				case CockTypesEnum.DRAGON:
				case CockTypesEnum.HORSE:
				case CockTypesEnum.KANGAROO:
				case CockTypesEnum.LIZARD:
				case CockTypesEnum.PIG:
				case CockTypesEnum.TENTACLE:
					if (countCocksOfType(cocks[0].cockType) == cocks.length) return Appearance.cockNoun(cocks[0].cockType) + "s";
					break;
				case CockTypesEnum.DOG:
				case CockTypesEnum.FOX:
					if (dogCocks() == cocks.length) return Appearance.cockNoun(CockTypesEnum.DOG) + "s";
			}
			return Appearance.cockNoun(CockTypesEnum.HUMAN) + "s";
		}

		public function hasSheath():Boolean {
			if (cocks.length == 0) return false;
			for (var x:int = 0; x < cocks.length; x++) {
				switch (cocks[x].cockType) {
					case CockTypesEnum.CAT:
					case CockTypesEnum.DISPLACER:
					case CockTypesEnum.DOG:
					case CockTypesEnum.WOLF:
					case CockTypesEnum.FOX:
					case CockTypesEnum.HORSE:
					case CockTypesEnum.KANGAROO:
					case CockTypesEnum.AVIAN:
					case CockTypesEnum.ECHIDNA:
						return true; //If there's even one cock of any of these types then return true
					default:
				}
			}
			return false;
		}

		public function sheathDescription():String {
			if (hasSheath()) return "sheath";
			return "base";
		}

		public function vaginaDescript(idx:int = 0):String
		{
			return Appearance.vaginaDescript(this, 0);
		}
		public function assholeDescript():String{
			return Appearance.assholeDescript(this);
		}

		public function nippleDescript(rowIdx:int):String
		{
			return Appearance.nippleDescription(this, rowIdx);
		}

		public function chestDesc():String
		{
			if (biggestTitSize() < 1) return "chest";
			return Appearance.biggestBreastSizeDescript(this);
//			return Appearance.chestDesc(this);
		}

		public function allChestDesc():String {
			if (biggestTitSize() < 1) return "chest";
			return allBreastsDescript();
		}

		public function clitDescript():String {
			return Appearance.clitDescription(this);
		}

		public function cockHead(cockNum:int = 0):String {
			if (cockNum < 0 || cockNum > cocks.length - 1) {
				CoC_Settings.error("");
				return "ERROR";
			}
			switch (cocks[cockNum].cockType) {
				case CockTypesEnum.CAT:
					if (rand(2) == 0) return "point";
					return "narrow tip";
				case CockTypesEnum.DEMON:
					if (rand(2) == 0) return "tainted crown";
					return "nub-ringed tip";
				case CockTypesEnum.DISPLACER:
					switch (rand(5)) {
						case  0: return "star tip";
						case  1: return "blooming cock-head";
						case  2: return "open crown";
						case  3: return "alien tip";
						default: return "bizarre head";
					}
				case CockTypesEnum.DOG:
				case CockTypesEnum.WOLF:
				case CockTypesEnum.FOX:
					if (rand(2) == 0) return "pointed tip";
					return "narrow tip";
				case CockTypesEnum.HORSE:
					if (rand(2) == 0) return "flare";
					return "flat tip";
				case CockTypesEnum.KANGAROO:
					if (rand(2) == 0) return "tip";
					return "point";
				case CockTypesEnum.LIZARD:
					if (rand(2) == 0) return "crown";
					return "head";
				case CockTypesEnum.TENTACLE:
					if (rand(2) == 0) return "mushroom-like tip";
					return "wide plant-like crown";
				case CockTypesEnum.PIG:
					if (rand(2) == 0) return "corkscrew tip";
					return "corkscrew head";
				case CockTypesEnum.RHINO:
					if (rand(2) == 0) return "flared head";
					return "rhinoceros dickhead";
				case CockTypesEnum.ECHIDNA:
					if (rand(2) == 0) return "quad heads";
					return "echidna quad heads";
				default:
			}
			if (rand(2) == 0) return "crown";
			if (rand(2) == 0) return "head";
			return "cock-head";
		}

		//Short cock description. Describes length or girth. Supports multiple cocks.
		public function cockDescriptShort(i_cockIndex:int = 0):String
		{
			// catch calls where we're outside of combat, and eCockDescript could be called.
			if (cocks.length == 0)
				return "<B>ERROR. INVALID CREATURE SPECIFIED to cockDescriptShort</B>";

			var description:String = "";
			var descripted:Boolean = false;
			//Discuss length one in 3 times
			if (rand(3) == 0) {
				if (cocks[i_cockIndex].cockLength >= 30)
					description = "towering ";
				else if (cocks[i_cockIndex].cockLength >= 18)
					description = "enormous ";
				else if (cocks[i_cockIndex].cockLength >= 13)
					description = "massive ";
				else if (cocks[i_cockIndex].cockLength >= 10)
					description = "huge ";
				else if (cocks[i_cockIndex].cockLength >= 7)
					description = "long ";
				else if (cocks[i_cockIndex].cockLength >= 5)
					description = "average ";
				else
					description = "short ";
				descripted = true;
			}
			else if (rand(2) == 0) { //Discuss girth one in 2 times if not already talked about length.
				//narrow, thin, ample, broad, distended, voluminous
				if (cocks[i_cockIndex].cockThickness <= .75) description = "narrow ";
				if (cocks[i_cockIndex].cockThickness > 1 && cocks[i_cockIndex].cockThickness <= 1.4) description = "ample ";
				if (cocks[i_cockIndex].cockThickness > 1.4 && cocks[i_cockIndex].cockThickness <= 2) description = "broad ";
				if (cocks[i_cockIndex].cockThickness > 2 && cocks[i_cockIndex].cockThickness <= 3.5) description = "fat ";
				if (cocks[i_cockIndex].cockThickness > 3.5) description = "distended ";
				descripted = true;
			}
//Seems to work better without this comma:			if (descripted && cocks[i_cockIndex].cockType != CockTypesEnum.HUMAN) description += ", ";
			description += Appearance.cockNoun(cocks[i_cockIndex].cockType);

			return description;
		}

		public function assholeOrPussy():String
		{
			return Appearance.assholeOrPussy(this);
		}

		public function multiCockDescriptLight():String
		{
			return Appearance.multiCockDescriptLight(this);
		}

		public function multiCockDescript():String
		{
			return Appearance.multiCockDescript(this);
		}

		public function ballsDescriptLight(forcedSize:Boolean = true):String
		{
			return Appearance.ballsDescription(forcedSize, true, this);
		}

		public function sackDescript():String
		{
			return Appearance.sackDescript(this);
		}

		public function breastDescript(rowNum:int):String {
			//ERROR PREVENTION
			if (breastRows.length - 1 < rowNum) {
				CoC_Settings.error("");
				return "<b>ERROR, breastDescript() working with invalid breastRow</b>";
			}
			if (breastRows.length == 0) {
				CoC_Settings.error("");
				return "<b>ERROR, breastDescript() called when no breasts are present.</b>";
			}
			return BreastStore.breastDescript(breastRows[rowNum].breastRating, breastRows[rowNum].lactationMultiplier);
		}

		private function breastSize(val:Number):String
		{
			return Appearance.breastSize(val);
		}

		/**
		 * Echidna 1 ft long (i'd consider it barely qualifying), demonic 2 ft long, draconic 4 ft long
		 */
		public function hasLongTongue():Boolean {
			return tongueType == TONGUE_DEMONIC || tongueType == TONGUE_DRACONIC || tongueType == TONGUE_ECHIDNA;
		}

		public function damageToughnessModifier(displayMode:Boolean = false):Number {
			var temp:Number = 0;
			if (tou < 25) temp = (tou * 0.4);
			else if (tou < 50) temp = 10 + ((tou-25) * 0.3);
			else if (tou < 75) temp = 17.5 + ((tou-50) * 0.2);
			else if (tou < 100) temp = 22.5 + ((tou-75) * 0.1);
			else temp = 25;
			//displayMode is for stats screen.
			if (displayMode) return temp;
			else return rand(temp);
		}

		public function damagePercent(displayMode:Boolean = false, applyModifiers:Boolean = false):Number {
			var mult:Number = 100;
			var armorMod:Number = armorDef;
			//--BASE--
			//Toughness modifier.
			if (!displayMode) {
				mult -= damageToughnessModifier();
				if (mult < 75) mult = 75;
			}
			//Modify armor rating based on weapons.
			if (applyModifiers) {
				if (game.player.weapon == game.weapons.JRAPIER || game.player.weapon == game.weapons.SPEAR || game.player.weapon == game.weapons.LANCE || game.player.weaponName.indexOf("staff") != -1 && game.player.findPerk(PerkLib.StaffChanneling) >= 0) armorMod = 0;
				if (game.player.weapon == game.weapons.KATANA) armorMod -= 5;
				if (game.player.findPerk(PerkLib.LungingAttacks) >= 0) armorMod /= 2;
				if (armorMod < 0) armorMod = 0;
			}
			mult -= armorMod;

			//--PERKS--
			//Take damage you masochist!
			if (findPerk(PerkLib.Masochist) >= 0 && lib >= 60) {
				mult *= 0.8;
				if (short == game.player.short && !displayMode) game.dynStats("lus", (2 * (1 + game.player.newGamePlusMod())));
			}
			if (findPerk(PerkLib.FenrirSpikedCollar) >= 0) {
				mult *= 0.85;
			}
			if (findPerk(PerkLib.Juggernaut) >= 0 && tou >= 100 && armorPerk == "Heavy") {
				mult *= 0.9;
			}
			if (findPerk(PerkLib.ImmovableObject) >= 0 && tou >= 75) {
				mult *= 0.9;
			}
			if (findPerk(PerkLib.AyoArmorProficiency) >= 0 && tou >= 75 && armorPerk == "Ayo") {
				mult *= 0.9;
			}
			if (findPerk(PerkLib.HeavyArmorProficiency) >= 0 && tou >= 75 && armorPerk == "Heavy") {
				mult *= 0.9;
			}
			if (findPerk(PerkLib.ShieldHarmony) >= 0 && tou >= 100 && shieldName != "nothing" && !hasStatusEffect(StatusEffects.Stunned)) {
				mult *= 0.9;
			}
			if (findPerk(PerkLib.NakedTruth) >= 0 && spe >= 75 && lib >= 60 && (armorName == "arcane bangles" || armorName == "practically indecent steel armor" || armorName == "revealing chainmail bikini" || armorName == "slutty swimwear" || armorName == "barely-decent bondage straps" || armorName == "nothing")) {
				mult *= 0.9;
			}

			//--STATUS AFFECTS--
			//Black cat beer = 25% reduction!
			if (statusEffectv1(StatusEffects.BlackCatBeer) > 0) {
				mult *= 0.75;
			}
			if (statusEffectv1(StatusEffects.OniRampage) > 0) {
				mult *= 0.8;
			}
			//Defend = 50-(99)% reduction
			if (hasStatusEffect(StatusEffects.Defend)) {
				if (findPerk(PerkLib.DefenceStance) >= 0 && tou >= 80) {
					if (findPerk(PerkLib.MasteredDefenceStance) >= 0 && tou >= 120) {
						if (findPerk(PerkLib.PerfectDefenceStance) >= 0 && tou >= 160) mult *= 0.05;
						else mult *= 0.25;
					}
					else mult *= 0.4;
				}
				else mult *= 0.5;
			}
			// Uma's Massage bonuses
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac && sac.value1 == UmasShop.MASSAGE_RELAXATION) {
				mult *= sac.value2;
			}
			//Round things off.
			mult = Math.round(mult);
			//Caps damage reduction at 95/99%.
			if (hasStatusEffect(StatusEffects.Defend) && findPerk(PerkLib.PerfectDefenceStance) >= 0 && tou >= 160 && mult < 1) mult = 1;
			if (!hasStatusEffect(StatusEffects.Defend) && mult < 5) mult = 5;
			return mult;
		}

		/**
		* Look into perks and special effects and @return summery extra chance to avoid attack granted by them.
		*/
		public function getEvasionChance():Number
		{
			var chance:Number = 0;
			if (findPerk(PerkLib.Evade) >= 0) chance += 10;
			if (findPerk(PerkLib.Flexibility) >= 0) chance += 6;
			if (findPerk(PerkLib.Misdirection) >= 0 && armorName == "red, high-society bodysuit") chance += 10;
			if (findPerk(PerkLib.Unhindered) >= 0 && (armorName == "arcane bangles" || armorName == "practically indecent steel armor" || armorName == "revealing chainmail bikini" || armorName == "slutty swimwear" || armorName == "barely-decent bondage straps" || armorName == "nothing")) chance += 10;
			if (hasStatusEffect(StatusEffects.Illusion)) chance += 10;
			if (hasStatusEffect(StatusEffects.Flying)) chance += 20;
			if (hasStatusEffect(StatusEffects.BladeDance)) chance += 30;
			return chance;
		}

		public const EVASION_SPEED:String = "Speed"; // enum maybe?
		public const EVASION_EVADE:String = "Evade";
		public const EVASION_FLEXIBILITY:String = "Flexibility";
		public const EVASION_MISDIRECTION:String = "Misdirection";
		public const EVASION_UNHINDERED:String = "Unhindered";
		public const EVASION_ILLUSION:String = "Illusion";
		public const EVASION_FLYING:String = "Illusion";

		/**
	    * Try to avoid and @return a reason if successfull or null if failed to evade.
		*
		* If attacker is null then you can specify attack speed for enviromental and non-combat cases. If no speed and attacker specified and then only perks would be accounted.
		*
		* This does NOT account blind!
	    */
		public function getEvasionReason(useMonster:Boolean = true, attackSpeed:int = int.MIN_VALUE):String
		{
			// speed
			if (useMonster && game.monster != null && attackSpeed == int.MIN_VALUE) attackSpeed = game.monster.spe;
			if (attackSpeed != int.MIN_VALUE && spe - attackSpeed > 0 && int(Math.random() * (((spe - attackSpeed) / 4) + 80)) > 80) return "Speed";
			//note, Player.speedDodge is still used, since this function can't return how close it was

			var roll:Number = rand(100);

			// perks
			if (findPerk(PerkLib.Evade) >= 0 && (roll < 10))
			return "Evade";
			if (findPerk(PerkLib.Flexibility) >= 0 && (roll < 6)) return "Flexibility";
			if (findPerk(PerkLib.Misdirection) >= 0 && armorName == "red, high-society bodysuit" && (roll < 10)) return "Misdirection";
			if (findPerk(PerkLib.Unhindered) >= 0 && (armorName == "arcane bangles" || armorName == "practically indecent steel armor" || armorName == "revealing chainmail bikini" || armorName == "slutty swimwear" || armorName == "barely-decent bondage straps" || armorName == "nothing") && (roll < 10)) return "Unhindered";
			if (hasStatusEffect(StatusEffects.Illusion) && (roll < 10)) return "Illusion";
			if (hasStatusEffect(StatusEffects.Flying) && (roll < 20)) return "Flying";
			if (hasStatusEffect(StatusEffects.BladeDance) && (roll < 30)) return "Blade Dance";
			return null;
		}

		public function getEvasionRoll(useMonster:Boolean = true, attackSpeed:int = int.MIN_VALUE):Boolean
		{
			return getEvasionReason(useMonster, attackSpeed) != null;
		}

		public function get vagorass():IOrifice {
			return hasVagina() ? vaginas[0] : ass;
		}
	}
}
