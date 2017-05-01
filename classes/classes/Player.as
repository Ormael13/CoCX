package classes
{
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Items.Armor;
import classes.Items.ArmorLib;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Items.Jewelry;
import classes.Items.JewelryLib;
import classes.Items.Shield;
import classes.Items.ShieldLib;
import classes.Items.Undergarment;
import classes.Items.UndergarmentLib
import classes.Items.WeaponRange;
import classes.Items.WeaponRangeLib;
import classes.Scenes.Areas.Forest;
import classes.Scenes.Areas.Forest.KitsuneScene;
import classes.Scenes.Places.TelAdre.UmasShop;

use namespace kGAMECLASS;

	/**
	 * ...
	 * @author Yoffy
	 */
	public class Player extends Character {
		
		public function Player() {
			//Item things
			itemSlot1 = new ItemSlotClass();
			itemSlot2 = new ItemSlotClass();
			itemSlot3 = new ItemSlotClass();
			itemSlot4 = new ItemSlotClass();
			itemSlot5 = new ItemSlotClass();
			itemSlot6 = new ItemSlotClass();
			itemSlot7 = new ItemSlotClass();
			itemSlot8 = new ItemSlotClass();
			itemSlot9 = new ItemSlotClass();
			itemSlot10 = new ItemSlotClass();
			itemSlots = [itemSlot1, itemSlot2, itemSlot3, itemSlot4, itemSlot5, itemSlot6, itemSlot7, itemSlot8, itemSlot9, itemSlot10];
		}
		
		protected final function outputText(text:String, clear:Boolean = false):void
		{
			game.outputText(text, clear);
		}
		
		public var startingRace:String = "human";
		
		public var soulforce:Number = 0;
		
		//Autosave
		public var slotName:String = "VOID";
		public var autoSave:Boolean = false;

		//Lust vulnerability
		//TODO: Kept for backwards compatibility reasons but should be phased out.
		public var lustVuln:Number = 1;

		//Teasing attributes
		public var teaseLevel:Number = 0;
		public var teaseXP:Number = 0;
		
		//Prison stats
		public var hunger:Number = 0; //Also used in survival and realistic mode
		public var obey:Number = 0;
		public var esteem:Number = 0;
		public var will:Number = 0;
		
		public var obeySoftCap:Boolean = true;
		
		//Perks used to store 'queued' perk buys
		public var perkPoints:Number = 0;
		public var statPoints:Number = 0;
		public var ascensionPerkPoints:Number = 0;
		
		public var tempStr:Number = 0;
		public var tempTou:Number = 0;
		public var tempSpe:Number = 0;
		public var tempInt:Number = 0;
		public var tempWis:Number = 0;
		public var tempLib:Number = 0;
		//Number of times explored for new areas
		public var explored:Number = 0;
		public var exploredForest:Number = 0;
		public var exploredDesert:Number = 0;
		public var exploredMountain:Number = 0;
		public var exploredLake:Number = 0;

		//Player pregnancy variables and functions
		override public function pregnancyUpdate():Boolean {
			return game.updatePregnancy(); //Returns true if we need to make sure pregnancy texts aren't hidden
		}

		// Inventory
		public var itemSlot1:ItemSlotClass;
		public var itemSlot2:ItemSlotClass;
		public var itemSlot3:ItemSlotClass;
		public var itemSlot4:ItemSlotClass;
		public var itemSlot5:ItemSlotClass;
		public var itemSlot6:ItemSlotClass;
		public var itemSlot7:ItemSlotClass;
		public var itemSlot8:ItemSlotClass;
		public var itemSlot9:ItemSlotClass;
		public var itemSlot10:ItemSlotClass;
		public var itemSlots:Array;
		
		public var prisonItemSlots:Array = [];
		public var previouslyWornClothes:Array = []; //For tracking achievement.
		
		private var _weapon:Weapon = WeaponLib.FISTS;
		private var _weaponRange:WeaponRange = WeaponRangeLib.NOTHING;
		private var _armor:Armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
		private var _jewelry:Jewelry = JewelryLib.NOTHING;
		private var _shield:Shield = ShieldLib.NOTHING;
		private var _upperGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _lowerGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _modArmorName:String = "";

		//override public function set armors
		override public function set armorValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorValue.");
		}

		override public function set armorName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorName.");
		}

		override public function set armorDef(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorDef.");
		}

		override public function set armorPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorPerk.");
		}

		//override public function set weapons
		override public function set weaponName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponName.");
		}

		override public function set weaponVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponVerb.");
		}

		override public function set weaponAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponAttack.");
		}

		override public function set weaponPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponPerk.");
		}

		override public function set weaponValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponValue.");
		}

		//override public function set weapons
		override public function set weaponRangeName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeName.");
		}

		override public function set weaponRangeVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeVerb.");
		}

		override public function set weaponRangeAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeAttack.");
		}

		override public function set weaponRangePerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangePerk.");
		}

		override public function set weaponRangeValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.weaponRangeValue.");
		}

		//override public function set jewelries
		override public function set jewelryName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryName.");
		}
		
		override public function set jewelryEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectId.");
		}
		
		override public function set jewelryEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectMagnitude.");
		}
				
		override public function set jewelryPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryPerk.");
		}
		
		override public function set jewelryValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryValue.");
		}

		//override public function set shields
		override public function set shieldName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldName.");
		}
		
		override public function set shieldBlock(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldBlock.");
		}
		
		override public function set shieldPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldPerk.");
		}
		
		override public function set shieldValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.shieldValue.");
		}
		
		//override public function set undergarments
		override public function set upperGarmentName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentName.");
		}
		
		override public function set upperGarmentPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentPerk.");
		}
		
		override public function set upperGarmentValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.upperGarmentValue.");
		}

		override public function set lowerGarmentName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentName.");
		}
		
		override public function set lowerGarmentPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentPerk.");
		}
		
		override public function set lowerGarmentValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.lowerGarmentValue.");
		}
		
		
		public function get modArmorName():String
		{
			if (_modArmorName == null) _modArmorName = "";
			return _modArmorName;
		}

		public function set modArmorName(value:String):void
		{
			if (value == null) value = "";
			_modArmorName = value;
		}

		//override public function get armors
		override public function get armorName():String {
			if (_modArmorName.length > 0) return modArmorName;
			else if (_armor.name == "nothing" && lowerGarmentName != "nothing") return lowerGarmentName;
			else if (_armor.name == "nothing" && lowerGarmentName == "nothing") return "gear";
			return _armor.name;
		}
		override public function get armorDef():Number {
			var armorDef:Number = _armor.def;
			armorDef += upperGarment.armorDef;
			armorDef += lowerGarment.armorDef;
			//Blacksmith history!
			if(armorDef > 0 && (findPerk(PerkLib.HistorySmith) >= 0 || findPerk(PerkLib.PastLifeSmith) >= 0)) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			//Skin armor perk
			if(findPerk(PerkLib.ThickSkin) >= 0) {
				armorDef += (2 * (1 + newGamePlusMod()));
			}
			//Stacks on top of Thick Skin perk.
			if(skinType == SKIN_TYPE_PARTIAL_FUR) armorDef += (1 + newGamePlusMod());
			if(skinType == SKIN_TYPE_FUR || skinType == SKIN_TYPE_PARTIAL_CHITIN) armorDef += (2 * (1 + newGamePlusMod()));
			if(skinType == SKIN_TYPE_PARTIAL_SCALES) armorDef += (3 * (1 + newGamePlusMod()));
			if(skinType == SKIN_TYPE_CHITIN || skinType == SKIN_TYPE_PARTIAL_BARK) armorDef += (4 * (1 + newGamePlusMod()));//bee-morph (), mantis-morph (), scorpion-morph (wpisane), spider-morph (wpisane)
			if(skinType == SKIN_TYPE_SCALES) armorDef += (6 * (1 + newGamePlusMod()));
			if(skinType == SKIN_TYPE_BARK) armorDef += (8 * (1 + newGamePlusMod()));//może do 10 podnieść jak doda sie scales dla smoków?
			if(skinType == SKIN_TYPE_STONE) armorDef += (8 * (1 + newGamePlusMod()));//może do 10 podnieść jak doda sie scales dla smoków?
			//'Thick' dermis descriptor adds 1!
			if (skinAdj == "smooth") armorDef += (1 * (1 + newGamePlusMod()));
			//Plant score bonuses
			if (plantScore() >= 4) {
				if (plantScore() >= 7) armorDef += (10 * (1 + newGamePlusMod()));
				else if (plantScore() == 6) armorDef += (8 * (1 + newGamePlusMod()));
				else if (plantScore() == 5) armorDef += (4 * (1 + newGamePlusMod()));
				else armorDef += (2 * (1 + newGamePlusMod()));
			}
			//Bonus defense
			if (armType == ARM_TYPE_YETI) armorDef += (1 * (1 + newGamePlusMod()));
			if (armType == ARM_TYPE_SPIDER || armType == ARM_TYPE_MANTIS || armType == ARM_TYPE_BEE || armType == ARM_TYPE_SALAMANDER) armorDef += (2 * (1 + newGamePlusMod()));
			if (armType == ARM_TYPE_GARGOYLE) armorDef += (8 * (1 + newGamePlusMod()));
			if (tailType == TAIL_TYPE_SPIDER_ADBOMEN || tailType == TAIL_TYPE_MANTIS_ABDOMEN || tailType == TAIL_TYPE_BEE_ABDOMEN) armorDef += (2 * (1 + newGamePlusMod()));
			if (tailType == TAIL_TYPE_GARGOYLE) armorDef += (8 * (1 + newGamePlusMod()));
			if (wingType == WING_TYPE_GARGOYLE_LIKE_LARGE) armorDef += (8 * (1 + newGamePlusMod()));
			if (lowerBody == LOWER_BODY_TYPE_YETI) armorDef += (1 * (1 + newGamePlusMod()));
			if (lowerBody == LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS || lowerBody == LOWER_BODY_TYPE_BEE || lowerBody == LOWER_BODY_TYPE_MANTIS || lowerBody == LOWER_BODY_TYPE_SALAMANDER) armorDef += (2 * (1 + newGamePlusMod()));
			if (lowerBody == LOWER_BODY_TYPE_DRAGON) armorDef += (3 * (1 + newGamePlusMod()));
			if (lowerBody == LOWER_BODY_TYPE_DRIDER_LOWER_BODY) armorDef += (4 * (1 + newGamePlusMod()));
			if (lowerBody == LOWER_BODY_TYPE_GARGOYLE) armorDef += (8 * (1 + newGamePlusMod()));
			//Soul Cultivators bonuses
			if(findPerk(PerkLib.BodyCultivator) >= 0) {
				armorDef += (1 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.FleshBodyApprenticeStage) >= 0) {
				if (findPerk(PerkLib.SoulApprentice) >= 0) armorDef += 2 * (1 + newGamePlusMod());
				if (findPerk(PerkLib.SoulPersonage) >= 0) armorDef += 2 * (1 + newGamePlusMod());
				if (findPerk(PerkLib.SoulWarrior) >= 0) armorDef += 2 * (1 + newGamePlusMod());
			}
			if (findPerk(PerkLib.FleshBodyWarriorStage) >= 0) {
				if (findPerk(PerkLib.SoulSprite) >= 0) armorDef += 3 * (1 + newGamePlusMod());
				if (findPerk(PerkLib.SoulExalt) >= 0) armorDef += 3 * (1 + newGamePlusMod());
				if (findPerk(PerkLib.SoulOverlord) >= 0) armorDef += 3 * (1 + newGamePlusMod());
			}
			if (findPerk(PerkLib.FleshBodyOverlordStage) >= 0) {
				if (findPerk(PerkLib.SoulTyrant) >= 0) armorDef += 4 * (1 + newGamePlusMod());
				if (findPerk(PerkLib.SoulKing) >= 0) armorDef += 4 * (1 + newGamePlusMod());
				if (findPerk(PerkLib.SoulEmperor) >= 0) armorDef += 4 * (1 + newGamePlusMod());
			}
//			if (findPerk(PerkLib.FleshBodyTyrantStage) >= 0) {
//				if (findPerk(PerkLib.SA) >= 0) armorDef += 5 * (1 + newGamePlusMod());
//				if (findPerk(PerkLib.SS) >= 0) armorDef += 5 * (1 + newGamePlusMod());
//				if (findPerk(PerkLib.SS) >= 0) armorDef += 5 * (1 + newGamePlusMod());
//			}
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) armorDef += 6 * (1 + newGamePlusMod());
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) armorDef += 9 * (1 + newGamePlusMod());
			//Agility boosts armor ratings!
			var speedBonus:int = 0;
			if(findPerk(PerkLib.Agility) >= 0) {
				if (armorPerk == "Light" || _armor.name == "nothing") {
					speedBonus += Math.round(spe / 10);
				}
				else if (armorPerk == "Medium") {
					speedBonus += Math.round(spe / 25);
				}
			}
			armorDef += speedBonus
			//Acupuncture effect
			if (findPerk(PerkLib.ChiReflowDefense) >= 0) armorDef *= UmasShop.NEEDLEWORK_DEFENSE_DEFENSE_MULTI;
			if (findPerk(PerkLib.ChiReflowAttack) >= 0) armorDef *= UmasShop.NEEDLEWORK_ATTACK_DEFENSE_MULTI;
			armorDef = Math.round(armorDef);
			//Berzerking removes armor
			if(findStatusAffect(StatusAffects.Berzerking) >= 0 && findPerk(PerkLib.ColdFury) < 1) {
				armorDef = 0;
			}
			if(findStatusAffect(StatusAffects.Lustzerking) >= 0) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			armorDef += Math.round(statusAffectv1(StatusAffects.ChargeArmor));
			if (kGAMECLASS.monster.findStatusAffect(StatusAffects.TailWhip) >= 0) {
				armorDef -= kGAMECLASS.monster.statusAffectv1(StatusAffects.TailWhip);
				if(armorDef < 0) armorDef = 0;
			}
			armorDef = Math.round(armorDef);
			return armorDef;
		}
		public function get armorBaseDef():Number {
			return _armor.def;
		}
		override public function get armorPerk():String {
			return _armor.perk;
		}
		override public function get armorValue():Number {
			return _armor.value;
		}
		//override public function get weapons
		override public function get weaponName():String {
			return _weapon.name;
		}
		override public function get weaponVerb():String {
			return _weapon.verb;
		}
		override public function get weaponAttack():Number {
			var attack:Number = _weapon.attack;
			if (findPerk(PerkLib.JobBarbarian) >= 0 && weaponPerk == "Large") {
				if (findPerk(PerkLib.WeaponMastery) >= 0 && str >= 100) {
					if (findPerk(PerkLib.WeaponGrandMastery) >= 0 && str >= 140) attack *= 2;
					else attack *= 1.5;
				}
				else attack *= 1.25;
			}
			if (findPerk(PerkLib.WeaponGrandMastery) >= 0 && weaponPerk == "Dual Large" && str >= 140) {
				attack *= 2;
			}
			if (findPerk(PerkLib.HiddenMomentum) >= 0 && weaponPerk == "Large" && str >= 75 && spe >= 50) {
				attack += (((str + spe) - 100) * 0.1);
			}//30-70-110
			if (findPerk(PerkLib.HiddenDualMomentum) >= 0 && weaponPerk == "Dual Large" && str >= 150 && spe >= 100) {
				attack += (((str + spe) - 200) * 0.1);
			}//20-60-100
			if(findPerk(PerkLib.LightningStrikes) >= 0 && spe >= 60 && (weaponPerk != "Large" || weaponPerk != "Dual Large")) {
				attack += ((spe - 50) * 0.3);//czy dodać wyjątek dla pieści?//dodać wyjąte dla dual weapons na pewno//wyjątek potem dodać dla daggers i innych assasins weapons i dać im lepszy przelicznik
			}//45-105-165
			if(findPerk(PerkLib.IronFistsI) >= 0 && str >= 50 && (weaponName == "fists" || weaponName == "hooked gauntlets" || weaponName == "spiked gauntlet")) {
				attack += 10;
			}
			if(findPerk(PerkLib.IronFistsII) >= 0 && str >= 65 && (weaponName == "fists" || weaponName == "hooked gauntlets" || weaponName == "spiked gauntlet")) {
				attack += 10;
			}
			if(findPerk(PerkLib.IronFistsIII) >= 0 && str >= 80 && (weaponName == "fists" || weaponName == "hooked gauntlets" || weaponName == "spiked gauntlet")) {
				attack += 10;
			}
			if(findPerk(PerkLib.IronFistsIV) >= 0 && str >= 95 && (weaponName == "fists" || weaponName == "hooked gauntlets" || weaponName == "spiked gauntlet")) {
				attack += 10;
			}
			if(findPerk(PerkLib.IronFistsV) >= 0 && str >= 110 && (weaponName == "fists" || weaponName == "hooked gauntlets" || weaponName == "spiked gauntlet")) {
				attack += 10;
			}
			if(findPerk(PerkLib.JobBrawler) >= 0 && str >= 60 && (weaponName == "fists" || weaponName == "hooked gauntlets" || weaponName == "spiked gauntlet")) {
				attack += (5 * (1 + newGamePlusMod()));
			}
			if(armType == ARM_TYPE_MANTIS && weaponName == "fists") {
				attack += (15 * (1 + newGamePlusMod()));
			}
			if(armType == ARM_TYPE_YETI && weaponName == "fists") {
				attack += (5 * (1 + newGamePlusMod()));
			}
			if(kGAMECLASS.unarmedAttack() > 0 && weaponName == "fists") {
				attack += kGAMECLASS.unarmedAttack();
			}
			if(findStatusAffect(StatusAffects.Berzerking) >= 0) attack += (15 + (15 * (1 + newGamePlusMod())));
			if(findStatusAffect(StatusAffects.Lustzerking) >= 0) attack += (15 + (15 * (1 + newGamePlusMod())));
			attack += Math.round(statusAffectv1(StatusAffects.ChargeWeapon));//zrobić modyfikacje na przypadek single/dual weapon charged tj. 2x wiecej bonusu za dual ale też koszt rzucania powinien wzrosnąć 2x
			attack = Math.round(attack);
			return attack;
		}
		public function get weaponBaseAttack():Number {
			return _weapon.attack;
		}
		override public function get weaponPerk():String {
			return _weapon.perk || "";
		}
		override public function get weaponValue():Number {
			return _weapon.value;
		}
		//override public function get weapons
		override public function get weaponRangeName():String {
			return _weaponRange.name;
		}
		override public function get weaponRangeVerb():String {
			return _weaponRange.verb;
		}
		override public function get weaponRangeAttack():Number {
			var rangeattack:Number = _weaponRange.attack;
			if (findPerk(PerkLib.Sharpshooter) >= 0 && weaponRangePerk != "Bow") {
				if (inte < 201) rangeattack *= (1 + (inte / 200));
				else rangeattack *= 2;
			}
		/*	if(findPerk(PerkLib.LightningStrikes) >= 0 && spe >= 60 && weaponRangePerk != "Large") {
				rangeattack += Math.round((spe - 50) / 3);
			}
			if(findPerk(PerkLib.IronFistsI) >= 0 && str >= 50 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(findPerk(PerkLib.IronFistsII) >= 0 && str >= 65 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(findPerk(PerkLib.IronFistsIII) >= 0 && str >= 80 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(findPerk(PerkLib.IronFistsIV) >= 0 && str >= 95 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(findPerk(PerkLib.IronFistsV) >= 0 && str >= 110 && weaponRangeName == "fists") {
				rangeattack += 10;
			}
			if(findPerk(PerkLib.JobBrawler) >= 0 && str >= 60 && weaponRangeName == "fists") {
				rangeattack += (5 * (1 + newGamePlusMod()));
			}
			if(armType == ARM_TYPE_MANTIS && weaponRangeName == "fists") {
				rangeattack += (15 * (1 + newGamePlusMod()));
			}
			if(findStatusAffect(StatusAffects.Berzerking) >= 0) rangeattack += (30 + (15 * newGamePlusMod()));
			if(findStatusAffect(StatusAffects.Lustzerking) >= 0) rangeattack += (30 + (15 * newGamePlusMod()));
			if(findPerk(PerkLib.) >= 0) rangeattack += Math.round(statusAffectv1(StatusAffects.ChargeWeapon));
		*/	rangeattack = Math.round(rangeattack);
			return rangeattack;
		}
		public function get weaponRangeBaseAttack():Number {
			return _weaponRange.attack;
		}
		override public function get weaponRangePerk():String {
			return _weaponRange.perk || "";
		}
		override public function get weaponRangeValue():Number {
			return _weaponRange.value;
		}
		
		//override public function get jewelries.
		override public function get jewelryName():String {
			return _jewelry.name;
		}
		override public function get jewelryEffectId():Number {
			return _jewelry.effectId;
		}
		override public function get jewelryEffectMagnitude():Number {
			return _jewelry.effectMagnitude;
		}
		override public function get jewelryPerk():String {
			return _jewelry.perk;
		}
		override public function get jewelryValue():Number {
			return _jewelry.value;
		}
		
		//override public function get shields
		override public function get shieldName():String {
			return _shield.name;
		}
		override public function get shieldBlock():Number {
			var block:Number = _shield.block;
			//miejce na sposoby boostowania block value like perks or status effects
			
			block = Math.round(block);
			return block;
		}
		override public function get shieldPerk():String {
			return _shield.perk;
		}
		override public function get shieldValue():Number {
			return _shield.value;
		}
		public function get shield():Shield
		{
			return _shield;
		}

		//override public function get undergarment
		override public function get upperGarmentName():String {
			return _upperGarment.name;
		}
		override public function get upperGarmentPerk():String {
			return _upperGarment.perk;
		}
		override public function get upperGarmentValue():Number {
			return _upperGarment.value;
		}
		public function get upperGarment():Undergarment
		{
			return _upperGarment;
		}
		
		override public function get lowerGarmentName():String {
			return _lowerGarment.name;
		}
		override public function get lowerGarmentPerk():String {
			return _lowerGarment.perk;
		}
		override public function get lowerGarmentValue():Number {
			return _lowerGarment.value;
		}
		public function get lowerGarment():Undergarment
		{
			return _lowerGarment;
		}
		
		public function get armor():Armor
		{
			return _armor;
		}
		
		public function setArmor(newArmor:Armor):Armor {
			//Returns the old armor, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldArmor:Armor = _armor.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newArmor == null) {
				CoC_Settings.error(short + ".armor is set to null");
				newArmor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			_armor = newArmor.playerEquip(); //The armor can also choose to equip something else - useful for Ceraph's trap armor
			return oldArmor;
		}
		
		/*
		public function set armor(value:Armor):void
		{
			if (value == null){
				CoC_Settings.error(short+".armor is set to null");
				value = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			}
			value.equip(this, false, false);
		}
		*/

		// in case you don't want to call the value.equip
		public function setArmorHiddenField(value:Armor):void
		{
			this._armor = value;
		}

		public function get weapon():Weapon
		{
			return _weapon;
		}
		
		public function get weaponRange():WeaponRange
		{
			return _weaponRange;
		}

		public function setWeapon(newWeapon:Weapon):Weapon {
			//Returns the old weapon, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeapon:Weapon = _weapon.playerRemove(); //The weapon is responsible for removing any bonuses, perks, etc.
			if (newWeapon == null) {
				CoC_Settings.error(short + ".weapon (melee) is set to null");
				newWeapon = WeaponLib.FISTS;
			}
			_weapon = newWeapon.playerEquip(); //The weapon can also choose to equip something else
			return oldWeapon;
		}
		
		/*
		public function set weapon(value:Weapon):void
		{
			if (value == null){
				CoC_Settings.error(short+".weapon is set to null");
				value = WeaponLib.FISTS;
			}
			value.equip(this, false, false);
		}
		*/

		// in case you don't want to call the value.equip
		public function setWeaponHiddenField(value:Weapon):void
		{
			this._weapon = value;
		}
		
		public function setWeaponRange(newWeaponRange:WeaponRange):WeaponRange {
			//Returns the old shield, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldWeaponRange:WeaponRange = _weaponRange.playerRemove();
			if (newWeaponRange == null) {
				CoC_Settings.error(short + ".weapon (range) is set to null");
				newWeaponRange = WeaponRangeLib.NOTHING;
			}
			_weaponRange = newWeaponRange.playerEquip();
			return oldWeaponRange;
		}
		
		// in case you don't want to call the value.equip
		public function setWeaponRangeHiddenField(value:WeaponRange):void
		{
			this._weaponRange = value;
		}
		
		//Jewelry, added by Kitteh6660
		public function get jewelry():Jewelry
		{
			return _jewelry;
		}

		public function setJewelry(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField(value:Jewelry):void
		{
			this._jewelry = value;
		}
		
		public function setShield(newShield:Shield):Shield {
			//Returns the old shield, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldShield:Shield = _shield.playerRemove(); //The shield is responsible for removing any bonuses, perks, etc.
			if (newShield == null) {
				CoC_Settings.error(short + ".shield is set to null");
				newShield = ShieldLib.NOTHING;
			}
			_shield = newShield.playerEquip(); //The shield can also choose to equip something else.
			return oldShield;
		}
		
		// in case you don't want to call the value.equip
		public function setShieldHiddenField(value:Shield):void
		{
			this._shield = value;
		}

		public function setUndergarment(newUndergarment:Undergarment, typeOverride:int = -1):Undergarment {
			//Returns the old undergarment, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldUndergarment:Undergarment = UndergarmentLib.NOTHING;
			if (newUndergarment.type == UndergarmentLib.TYPE_UPPERWEAR || typeOverride == 0) { 
				oldUndergarment = _upperGarment.playerRemove(); //The undergarment is responsible for removing any bonuses, perks, etc.
				if (newUndergarment == null) {
					CoC_Settings.error(short + ".upperGarment is set to null");
					newUndergarment = UndergarmentLib.NOTHING;
				}
				_upperGarment = newUndergarment.playerEquip(); //The undergarment can also choose to equip something else.
			}
			else if (newUndergarment.type == UndergarmentLib.TYPE_LOWERWEAR || typeOverride == 1) { 
				oldUndergarment = _lowerGarment.playerRemove(); //The undergarment is responsible for removing any bonuses, perks, etc.
				if (newUndergarment == null) {
					CoC_Settings.error(short + ".lowerGarment is set to null");
					newUndergarment = UndergarmentLib.NOTHING;
				}
				_lowerGarment = newUndergarment.playerEquip(); //The undergarment can also choose to equip something else.
			}
			return oldUndergarment;
		}
		
		// in case you don't want to call the value.equip
		public function setUndergarmentHiddenField(value:Undergarment, type:int):void
		{
			if (type == UndergarmentLib.TYPE_UPPERWEAR) this._upperGarment = value;
			else this._lowerGarment = value;
		}
		
		public function reduceDamage(damage:Number):Number {
			var damageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) damageMultiplier /= 2;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) damageMultiplier *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) damageMultiplier *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) damageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) damageMultiplier *= 2;
			
			//Opponents can critical too!
			var crit:Boolean = false
			var critChanceMonster:int = 5;
			if (kGAMECLASS.monster.findPerk(PerkLib.Tactician) >= 0 && kGAMECLASS.monster.inte >= 50) {
				if (kGAMECLASS.monster.inte <= 100) critChanceMonster += (kGAMECLASS.monster.inte - 50) / 5;
				if (kGAMECLASS.monster.inte > 100) critChanceMonster += 10;
			}
			if (kGAMECLASS.monster.findPerk(PerkLib.VitalShot) >= 0 && kGAMECLASS.monster.inte >= 50) critChanceMonster += 10;
			if (rand(100) < critChanceMonster) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (findStatusAffect(StatusAffects.Shielding) >= 0) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			//Apply damage resistance percentage.
			damage *= damagePercent() / 100;
			if (damageMultiplier < 0.2) damageMultiplier = 0;
			return int(damage * damageMultiplier);
		}

		public function takeDamage(damage:Number, display:Boolean = false):Number{
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				//game.HPChange(-damage, display);
				HP -= damage
				if (display) {
					if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>", false)
					else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>", false)
				}
				game.mainView.statsView.showStatDown('hp');
				game.dynStats("lus", 0); //Force display arrow.
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					game.dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP<=0){
					HP = 0;
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}

		/**
		 * @return 0: did not avoid; 1-3: avoid with varying difference between
		 * speeds (1: narrowly avoid, 3: deftly avoid)
		 */
		public function speedDodge(monster:Monster):int{
			var diff:Number = spe - monster.spe;
			var rnd:int = int(Math.random() * ((diff / 4) + 80));
			if (rnd<=80) return 0;
			else if (diff<8) return 1;
			else if (diff<20) return 2;
			else return 3;
		}

		//Body Type
		public function bodyType():String
		{
			var desc:String = "";
			//OLD STUFF
			//SUPAH THIN
			if (thickness < 10)
			{
				//SUPAH BUFF
				if (tone > 90)
					desc += "a lithe body covered in highly visible muscles";
				else if (tone > 75)
					desc += "an incredibly thin, well-muscled frame";
				else if (tone > 50)
					desc += "a very thin body that has a good bit of muscle definition";
				else if (tone > 25)
					desc += "a lithe body and only a little bit of muscle definition";
				else
					desc += "a waif-thin body, and soft, forgiving flesh";
			}
			//Pretty thin
			else if (thickness < 25)
			{
				if (tone > 90)
					desc += "a thin body and incredible muscle definition";
				else if (tone > 75)
					desc += "a narrow frame that shows off your muscles";
				else if (tone > 50)
					desc += "a somewhat lithe body and a fair amount of definition";
				else if (tone > 25)
					desc += "a narrow, soft body that still manages to show off a few muscles";
				else
					desc += "a thin, soft body";
			}
			//Somewhat thin
			else if (thickness < 40)
			{
				if (tone > 90)
					desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 75)
					desc += "a thinner-than-average frame and great muscle definition";
				else if (tone > 50)
					desc += "a somewhat narrow body and a decent amount of visible muscle";
				else if (tone > 25)
					desc += "a moderately thin body, soft curves, and only a little bit of muscle";
				else
					desc += "a fairly thin form and soft, cuddle-able flesh";
			}
			//average
			else if (thickness < 60)
			{
				if (tone > 90)
					desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 75)
					desc += "an average-sized frame and great musculature";
				else if (tone > 50)
					desc += "a normal waistline and decently visible muscles";
				else if (tone > 25)
					desc += "an average body and soft, unremarkable flesh";
				else
					desc += "an average frame and soft, untoned flesh with a tendency for jiggle";
			}
			else if (thickness < 75)
			{
				if (tone > 90)
					desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 75)
					desc += "a body that's a little bit wide and has some highly-visible muscles";
				else if (tone > 50)
					desc += "a solid build that displays a decent amount of muscle";
				else if (tone > 25)
					desc += "a slightly wide frame that displays your curves and has hints of muscle underneath";
				else
					desc += "a soft, plush body with plenty of jiggle";
			}
			else if (thickness < 90)
			{
				if (tone > 90)
					desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 75)
					desc += "a burly form and plenty of muscle definition";
				else if (tone > 50)
					desc += "a solid, thick frame and a decent amount of muscles";
				else if (tone > 25)
					desc += "a wide-set body, some soft, forgiving flesh, and a hint of muscle underneath it";
				else
				{
					desc += "a wide, cushiony body";
					if (gender >= 2 || biggestTitSize() > 3 || hipRating > 7 || buttRating > 7)
						desc += " and plenty of jiggle on your curves";
				}
			}
			//Chunky monkey
			else
			{
				if (tone > 90)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 75)
					desc += "a very wide body and enough muscle to make you look like a tank";
				else if (tone > 50)
					desc += "an extremely substantial frame packing a decent amount of muscle";
				else if (tone > 25)
				{
					desc += "a very wide body";
					if (gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10)
						desc += ", lots of curvy jiggles,";
					desc += " and hints of muscle underneath";
				}
				else
				{
					desc += "a thick";
					if (gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10)
						desc += ", voluptuous";
					desc += " body and plush, ";
					if (gender >= 2 || biggestTitSize() > 4 || hipRating > 10 || buttRating > 10)
						desc += " jiggly curves";
					else
						desc += " soft flesh";
				}
			}
			return desc;
		}

		public function race():String
		{
			//Determine race type:
			var race:String = "human";
			if (catScore() >= 4) 
			{
				if (isTaur() && lowerBody == LOWER_BODY_TYPE_CAT) {
					race = "cat-taur";
					if (faceType == 0)
						race = "sphinx-morph"; // no way to be fully feral anyway
				}
				else {
					race = "cat-morph";
					if (faceType == 0)
						race = "cat-" + mf("boy", "girl");
				}
			}
			if (lizardScore() >= 4)
			{
				if (lizardScore() >= 8) {
					if (isTaur()) race = "lizan-taur";
					else race = "lizan";
				}
				else {
					if (isTaur()) race = "half lizan-taur";
					else race = "half lizan";
				}
			}
			if (dragonScore() >= 4)
			{
				if (dragonScore() >= 8) {
					if (isTaur()) race = "dragon-taur";
					else {
						race = "dragon";
						if (faceType == 0)
							race = "dragon-" + mf("man", "girl");
					}
				}
				else {
					if (isTaur()) race = "half-dragon-taur";
					else {
						race = "half-dragon";
						if (faceType == 0)
							race = "half-dragon-" + mf("man", "girl");
					}
				}
			}
			if (raccoonScore() >= 4)
			{
				race = "raccoon-morph";
				if (balls > 0 && ballSize > 5)
					race = "tanuki";
			}
			if (dogScore() >= 4)
			{
				if (isTaur() && lowerBody == LOWER_BODY_TYPE_DOG)
					race = "dog-taur";
				else {
					race = "dog-morph";
					if (faceType == 0)
						race = "dog-" + mf("man", "girl");
				}
			}
			if (wolfScore() >= 4)
			{
				if (isTaur() && lowerBody == LOWER_BODY_TYPE_WOLF)
					race = "wolf-taur";
				else if (wolfScore() >= 10)
					race = "Fenrir";
				else if (wolfScore() >= 7 && furColor == "glacial white")
					race = "winter wolf";
				else if (wolfScore() >= 6)
					race = "wolf-morph";
				else
					race = "wolf-" + mf("boy", "girl");
			}
			if (foxScore() >= 4)
			{
				if (foxScore() >= 7 && isTaur() && lowerBody == LOWER_BODY_TYPE_FOX)
					race = "fox-taur";
				else if (foxScore() >= 7)
					race = "fox-morph";
				else
					race = "half fox";
			}
			if (ferretScore() >= 4)
			{
				if (skinType == 1)
					race = "ferret-morph";
				else
					race = "ferret-" + mf("morph", "girl");
			}
			if (kitsuneScore() >= 5)
			{
				if (tailType == 13 && tailCount >= 2 && kitsuneScore() >= 6) {
					if (kitsuneScore() >= 12) {
						if (tailCount == 9 && isTaur()) {
							race = "nine tailed kitsune-taur";
						}
						else if (tailCount == 9) {
							race = "nine tailed kitsune";
						}
						else {
							race = "kitsune";
						}
					}
					else {
						if (isTaur()) {
							race = "kitsune-taur";
						}
						else {
							race = "kitsune";
						}
					}
				}
				else {
					race = "half kitsune";
				}
			}
			if (kitshooScore() >= 6)
			{
				if (isTaur()) race = "kitshoo-taur";
				else {
					race = "kitshoo";
				}
			}
			//if (
			if (horseScore() >= 4)
			{
				if (isTaur())
					race = "centaur";
				else
					race = "equine-morph";
			}
			if (unicornScore() >= 5)
			{
				if (isTaur()) race = "unicorn-taur";
				else {
					race = "unicorn";
				}
			}
			if (alicornScore() >= 6)
			{
				if (isTaur()) race = "alicorn-taur";
				else {
					race = "alicorn";
				}
			}
			if (mutantScore() >= 5 && race == "human")
				race = "corrupted mutant";
			if (minoScore() >= 4)
				race = "minotaur";
			if (cowScore() >= 4)
			{
				race = "cow-";
				race += mf("morph", "girl");
			}
			if (beeScore() >= 5) {
				if (beeScore() >= 9) {
					race = "bee-morph";
				}
				else {
					race = "half bee-morph";
				}
			}
			if (goblinScore() >= 4)
				race = "goblin";
			if (humanScore() >= 5 && race == "corrupted mutant")
				race = "somewhat human mutant";
			if (demonScore() >= 5)
			{
				if (demonScore() >= 11) {
					if (isTaur()) {
						race = "";
						race += mf("incubi-kintaur", "succubi-kintaur");
					}
					else {
						race = "";
						race += mf("incubi-kin", "succubi-kin");
					}
				}
				else {
					if (isTaur()) {
						race = "half ";
						race += mf("incubus-taur", "succubus-taur");
					}
					else {
						race = "half ";
						race += mf("incubus", "succubus");
					}
				}
			}
			if (sharkScore() >= 4)
			{
				if (sharkScore() >= 9 && vaginas.length > 0 && cocks.length > 0) {
					if (isTaur()) race = "tigershark-taur";
					else {
						race = "tigershark-morph";
					}
				}
				else if (sharkScore() >= 8) {
					if (isTaur()) race = "shark-taur";
					else {
						race = "shark-morph";
					}
				}
				else {
					if (isTaur()) race = "half shark-taur";
					else {
						race = "half shark-morph";
					}
				}
			}
			if (orcaScore() >= 6)
			{
				if (orcaScore() >= 12) {
					if (isTaur()) race = "orca-taur";
					else {
						race = "orca-morph";
					}
				}
				else {
					if (isTaur()) race = "half orca-taur";
					else {
						race = "half orca-";
						race += mf("boy", "girl");
					}
				}
			}
			if (bunnyScore() >= 4)
				race = "bunny-" + mf("boy", "girl");
			if (harpyScore() >= 4)
			{
				if (harpyScore() >= 8) {
					if (gender >= 2) {
						race = "harpy";
					}
					else {
						race = "avian";
					}
				}
				else {
					if (gender >= 2) {
						race = "half harpy";
					}
					else {
						race = "half avian";
					}
				}
			}
			if (spiderScore() >= 4)
			{
				if (spiderScore() >= 7) {
					race = "spider-morph";
					if (mf("no", "yes") == "yes")
						race = "spider-girl";
					if (isDrider())
						race = "drider";
				}
				else {
					race = "half spider-morph";
					if (mf("no", "yes") == "yes")
						race = "half spider-girl";
					if (isDrider())
						race = "half drider";
				}
			}
			if (kangaScore() >= 4)
				race = "kangaroo-morph";
			if (mouseScore() >= 3)
			{
				if (isTaur()) race = "mouse-taur";
				else {
					if (faceType != 16)
					race = "mouse-" + mf("boy", "girl");
					else
						race = "mouse-morph";
				}
			}
			if (scorpionScore() >= 4)
			{
				if (isTaur()) race = "scorpion-taur";
				else {
					race = "scorpion-morph";
				}
			}
			if (mantisScore() >= 5)
			{
				if (isTaur()) race = "mantis-taur";
				else {
					race = "mantis-morph";
				}
			}
			if (salamanderScore() >= 4)
			{
				if (salamanderScore() >= 7) {
					if (isTaur()) race = "salamander-taur";
					else race = "salamander";
				}
				else {
					if (isTaur()) race = "half salamander-taur";
					else race = "half salamander";
				}
			}
			if (yetiScore() >= 6)
			{
				if (yetiScore() >= 12) {
					if (isTaur()) race = "yeti-taur";
					else race = "yeti";
				}
				else {
					if (isTaur()) race = "half yeti-taur";
					else race = "half yeti";
				}
			}
			if (couatlScore() >= 11)
			{
				if (isTaur()) race = "couatl-taur";
				else {
					race = "couatl";
				}
			}
			if (vouivreScore() >= 11)
			{
				if (isTaur()) race = "vouivre-taur";
				else {
					race = "vouivre";
				}
			}
			if (gorgonScore() >= 11)
			{
				if (isTaur()) race = "gorgon-taur";
				else {
					race = "gorgon";
				}
			}
			if (lowerBody == 3 && nagaScore() >= 4)
			{
				if (nagaScore() >= 8) race = "naga";
				else race = "half-naga";
			}
				
			if (phoenixScore() >= 10)
			{
				if (isTaur()) race = "phoenix-taur";
				else race = "phoenix";
			}
			if (scyllaScore() >= 5)
			{
				race = "scylla";
			}
			if (plantScore() >= 4)
			{
				if (isTaur()) {
					if (plantScore() >= 6 && lowerBody == 34) race = "Alraune";
					else if (plantScore() >= 6) race = mf("treant-taur", "dryad-taur");
					else race = "plant-taur";
				}
				else {
					if (plantScore() >= 6) race = mf("treant", "dryad");
					else race = "plant-morph";
				}
			}
			//<mod>
			if (pigScore() >= 4) 
			{
				race = "pig-morph";
				if (faceType == 0)
					race = "pig-" + mf("boy", "girl");
				if (faceType == 20)
					race = "boar-morph";
			}
			if (satyrScore() >= 4)
			{
				race = "satyr";
			}
			if (rhinoScore() >= 4)
			{
				race = "rhino-morph";
				if (faceType == 0) race = "rhino-" + mf("man", "girl");
			}
			if (echidnaScore() >= 4)
			{
				race = "echidna";
				if (faceType == 0) race = "echidna-" + mf("boy", "girl");
			}
			if (deerScore() >= 4)
			{
				if (isTaur()) race = "deer-taur";
				else {
					race = "deer-morph";
					if (faceType == 0) race = "deer-" + mf("morph", "girl");
				}
			}
			//Special, bizarre races
			if (dragonneScore() >= 6)
			{
				if (isTaur()) race = "dragonne-taur";
				else {
					race  = "dragonne";
					if (faceType == 0)
						race = "dragonne-" + mf("man", "girl");
				}
			}
			if (manticoreScore() >= 5)
			{
				if (isTaur() && lowerBody == LOWER_BODY_TYPE_LION) {
					if (manticoreScore() < 10)
						race = "half manticore-taur";
					if (manticoreScore() >= 10)	
						race = "manticore-taur";
				}
				else if (manticoreScore() >= 10)
					race = "manticore";
				else
					race = "half manticore";
			}
			if (sirenScore() >= 10)
			{
				if (isTaur()) race = "siren-taur";
				else race = "siren";
			}
			if (gargoyleScore() >= 6)
			{
				race = "gargoyle";
			}
			//</mod>
			if (lowerBody == LOWER_BODY_TYPE_HOOFED && isTaur()) {
				if (wingType == WING_TYPE_FEATHERED_LARGE) race = "pegataur";
				else race = "centaur";
			}
			
			if (lowerBody == LOWER_BODY_TYPE_PONY)
				race = "pony-kin";

			if (gooScore() >= 4)
			{
				if (gooScore() >= 8) {
					race = "goo-";
					race += mf("boi", "girl");
				}
				else {
					race = "half goo-";
					race += mf("boi", "girl");
				}
			}
			
			if (chimeraScore() >= 3)
			{
				race = "chimera";
			}
			
			if (grandchimeraScore() >= 3)
			{
				race = "grand chimera";
			}
			
			return race;
		}

		//Determine Human Rating
		public function humanScore():Number
		{
			var humanCounter:Number = 0;
			if (skinType == 0 && skinTone != "slippery")
				humanCounter++;
			if (faceType == 0)
				humanCounter++;
			if (eyeType == 0)
				humanCounter++;
			if (earType == 0)
				humanCounter++;
			if (tongueType == 0)
				humanCounter++;
			if (gillType == 0)
				humanCounter++;
			if (antennae == 0)
				humanCounter++;
			if (horns == 0)
				humanCounter++;
			if (wingType == 0)
				humanCounter++;
			if (tailType == 0)
				humanCounter++;
			if (armType == 0)
				humanCounter++;
			if (lowerBody == 0)
				humanCounter++;
			if (normalCocks() >= 1 || (hasVagina() && vaginaType() == 0))
				humanCounter++;
			if (breastRows.length == 1 && skinType == 0 && skinTone != "slippery")
				humanCounter++;
			if (findPerk(PerkLib.BlackHeart) < 0)
				humanCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) < 0)
				humanCounter++;
			if (findPerk(PerkLib.DraconicLungs) < 0)
				humanCounter++;
			if (findPerk(PerkLib.GorgonsEyes) < 0)
				humanCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGland) < 0)
				humanCounter++;
			if (findPerk(PerkLib.LizanMarrow) < 0)
				humanCounter++;
			if (findPerk(PerkLib.ManticoreMetabolism) < 0)
				humanCounter++;
			if (findPerk(PerkLib.MantislikeAgility) < 0)
				humanCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlands) < 0)
				humanCounter++;
			if (findPerk(PerkLib.ScyllaInkGlands) < 0)
				humanCounter++;
			if (findPerk(PerkLib.TrachealSystem) < 0)
				humanCounter++;
			return humanCounter;
		}
		
		//Determine Chimera Race Rating
			public function chimeraScore():Number
		{
			var chimeraCounter:Number = 0;
			if (catScore() >= 4)
				chimeraCounter++;
			if (lizardScore() >= 4)
				chimeraCounter++;
			if (dragonScore() >= 4)
				chimeraCounter++;
			if (raccoonScore() >= 4)
				chimeraCounter++;
			if (dogScore() >= 4)
				chimeraCounter++;
			if (wolfScore() >= 6)
				chimeraCounter++;
			if (foxScore() >= 4)
				chimeraCounter++;
			if (ferretScore() >= 4)
				chimeraCounter++;
			if (kitsuneScore() >= 5)
				chimeraCounter++;
			if (horseScore() >= 4)
				chimeraCounter++;
			if (unicornScore() >= 5)	//coś pomyśleć aby bycie alicornem nie liczyło byciem chimerą od razu
				chimeraCounter++;
			if (alicornScore() >= 6)	//coś pomyśleć aby bycie alicornem nie liczyło byciem chimerą od razu
				chimeraCounter++;
			if (minoScore() >= 4)
				chimeraCounter++;
			if (cowScore() >= 4)
				chimeraCounter++;
			if (beeScore() >= 5)
				chimeraCounter++;
			if (goblinScore() >= 4)
				chimeraCounter++;
			if (demonScore() >= 5)
				chimeraCounter++;
			if (sharkScore() >= 4)
				chimeraCounter++;
			if (orcaScore() >= 6)
				chimeraCounter++;
			if (bunnyScore() >= 4)
				chimeraCounter++;
			if (harpyScore() >= 4)
				chimeraCounter++;
			if (spiderScore() >= 4)
				chimeraCounter++;
			if (kangaScore() >= 4)
				chimeraCounter++;
			if (mouseScore() >= 3)
				chimeraCounter++;
			if (scorpionScore() >= 4)
				chimeraCounter++;
			if (mantisScore() >= 5)
				chimeraCounter++;
			if (salamanderScore() >= 4)
				chimeraCounter++;
			if (nagaScore() >= 4)
				chimeraCounter++;
			if (phoenixScore() >= 10)
				chimeraCounter++;
			if (scyllaScore() >= 5)
				chimeraCounter++;
			if (plantScore() >= 6)
				chimeraCounter++;
			if (pigScore() >= 4)
				chimeraCounter++;
			if (satyrScore() >= 4)
				chimeraCounter++;
			if (rhinoScore() >= 4)
				chimeraCounter++;
			if (echidnaScore() >= 4)
				chimeraCounter++;
			if (deerScore() >= 4)
				chimeraCounter++;
			if (manticoreScore() >= 5)
				chimeraCounter++;
			if (sirenScore() >= 10)
				chimeraCounter++;
			if (yetiScore() >= 6)
				chimeraCounter++;
			if (gargoyleScore() >= 6)
				chimeraCounter++;
			if (gooScore() >= 4)
				chimeraCounter++;
			return chimeraCounter;
		}
		
		//Determine Grand Chimera Race Rating
			public function grandchimeraScore():Number
		{
			var grandchimeraCounter:Number = 0;
//			if (catScore() >= 4)
//				grandchimeraCounter++;
			if (lizardScore() >= 8)
				grandchimeraCounter++;
			if (dragonScore() >= 8)
				grandchimeraCounter++;
/*			if (raccoonScore() >= 4)
				grandchimeraCounter++;
			if (dogScore() >= 4)
				grandchimeraCounter++;
			if (wolfScore() >= 6)
				grandchimeraCounter++;*/
			if (foxScore() >= 7)
				grandchimeraCounter++;
//			if (ferretScore() >= 4)
//				grandchimeraCounter++;
			if (kitsuneScore() >= 6 && tailType == 13 && tailCount >= 2)
				grandchimeraCounter++;	
/*			if (horseScore() >= 4)
				grandchimeraCounter++;
			if (unicornScore() >= 5)	//coś pomyśleć aby bycie alicornem nie liczyło byciem chimerą od razu
				grandchimeraCounter++;
			if (alicornScore() >= 6)	//coś pomyśleć aby bycie alicornem nie liczyło byciem chimerą od razu
				grandchimeraCounter++;
			if (minoScore() >= 4)
				grandchimeraCounter++;
			if (cowScore() >= 4)
				grandchimeraCounter++;*/
			if (beeScore() >= 9)
				grandchimeraCounter++;
//			if (goblinScore() >= 4)
//				grandchimeraCounter++;
			if (demonScore() >= 11)
				grandchimeraCounter++;
			if (sharkScore() >= 8)
				grandchimeraCounter++;
			if (orcaScore() >= 12)
				grandchimeraCounter++;
//			if (bunnyScore() >= 4)
//				grandchimeraCounter++;
			if (harpyScore() >= 8)
				grandchimeraCounter++;
			if (spiderScore() >= 7)
				grandchimeraCounter++;
/*			if (kangaScore() >= 4)
				grandchimeraCounter++;
			if (mouseScore() >= 3)
				grandchimeraCounter++;
			if (scorpionScore() >= 4)
				grandchimeraCounter++;
			if (mantisScore() >= 5)
				grandchimeraCounter++;*/
			if (salamanderScore() >= 7)
				grandchimeraCounter++;
			if (nagaScore() >= 8)
				grandchimeraCounter++;
			if (gorgonScore() >= 11)
				grandchimeraCounter++;
			if (vouivreScore() >= 11)
				grandchimeraCounter++;
			if (couatlScore() >= 11)
				grandchimeraCounter++;
			if (phoenixScore() >= 10)
				grandchimeraCounter++;
/*			if (scyllaScore() >= 5)
				grandchimeraCounter++;
			if (plantScore() >= 6)
				grandchimeraCounter++;
			if (pigScore() >= 4)
				grandchimeraCounter++;
			if (satyrScore() >= 4)
				grandchimeraCounter++;
			if (rhinoScore() >= 4)
				grandchimeraCounter++;
			if (echidnaScore() >= 4)
				grandchimeraCounter++;
			if (deerScore() >= 4)
				grandchimeraCounter++;*/
			if (manticoreScore() >= 10)
				grandchimeraCounter += 2;
			if (sirenScore() >= 10)
				grandchimeraCounter++;
			if (yetiScore() >= 12)
				grandchimeraCounter++;
//			if (gargoyleScore() >= 6)
//				grandchimeraCounter++;
			if (gooScore() >= 8)
				grandchimeraCounter++;
			return grandchimeraCounter;
		}
		
		//Determine Inner Chimera Score
			public function internalChimeraScore():Number
		{
			var internalChimeraCounter:Number = 0;
			if (findPerk(PerkLib.BlackHeart) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.DraconicLungs) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.GorgonsEyes) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGland) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.LizanMarrow) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.ManticoreMetabolism) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.MantislikeAgility) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlands) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.ScyllaInkGlands) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.TrachealSystem) >= 0)
				internalChimeraCounter++;
		//	if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		internalChimeraCounter++;
		//	if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		internalChimeraCounter++;
		//	if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		internalChimeraCounter++;
			return internalChimeraCounter;
		}
		
		//Determine Inner Chimera Rating
			public function internalChimeraRating():Number
		{
			var internalChimeraRatingCounter:Number = 0;
			if (findPerk(PerkLib.BlackHeart) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.DraconicLungs) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.GorgonsEyes) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGland) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.LizanMarrow) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.ManticoreMetabolism) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.MantislikeAgility) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlands) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.ScyllaInkGlands) >= 0)
				internalChimeraRatingCounter++;
			if (findPerk(PerkLib.TrachealSystem) >= 0)
				internalChimeraRatingCounter++;
		//	if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		internalChimeraRatingCounter++;
		//	if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		internalChimeraRatingCounter++;
		//	if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		internalChimeraRatingCounter++;
			if (findPerk(PerkLib.ChimericalBodyInitialStage) >= 0)
				internalChimeraRatingCounter--;
			if (findPerk(PerkLib.ChimericalBodyBasicStage) >= 0)
				internalChimeraRatingCounter--;
			if (findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				internalChimeraRatingCounter -= 2;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				internalChimeraRatingCounter -= 2;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				internalChimeraRatingCounter -= 4;
			return internalChimeraRatingCounter;
		}

		//determine demon rating
		public function demonScore():Number
		{
			var demonCounter:Number = 0;
			if (hornType == 1 && horns > 0)
				demonCounter++;
			if (cor >= 50 && hornType == 1 && horns > 4)
				demonCounter++;
			if (tailType == 3)
				demonCounter++;
			if (wingType == 6)
				demonCounter++;
			if (wingType == 7)
				demonCounter += 2;
			if (wingType == 13)
				demonCounter += 4;
			if (tongueType == 2)
				demonCounter++;
			if (cor >= 50 && skinType == 0 && skinTone != "slippery")
				demonCounter++;
			if (cor >= 50 && faceType == 0)
				demonCounter++;
			if (cor >= 50 && armType == 0)
				demonCounter++;
			if (lowerBody == 5 || lowerBody == 6)
				demonCounter++;
			if (demonCocks() > 0)
				demonCounter++;
			if (findPerk(PerkLib.BlackHeart) >= 0)
				demonCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && demonCounter >= 5)
				demonCounter += 1;
			if (findPerk(PerkLib.BlackHeart) >= 0 && findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				demonCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				demonCounter += 10;
			return demonCounter;
		}

		//Determine minotaur rating
		public function minoScore():Number
		{
			var minoCounter:Number = 0;
			if (faceType == 3)
				minoCounter++;
			if (earType == 3)
				minoCounter++;
			if (tailType == 4)
				minoCounter++;
			if (hornType == 2)
				minoCounter++;
			if (lowerBody == 1 && minoCounter > 0)
				minoCounter++;
			if (tallness > 80 && minoCounter > 0)
				minoCounter++;
			if (cocks.length > 0 && minoCounter > 0)
			{
				if (horseCocks() > 0)
					minoCounter++;
			}
			if (vaginas.length > 0)
				minoCounter--;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				minoCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && minoCounter >= 3)
				minoCounter += 1;
			return minoCounter;
		}

		public function get minotaurScore():Number
		{
			return this.minoScore();
		}

		//Determine cow rating
		public function cowScore():Number
		{
			var minoCounter:Number = 0;
			if (faceType == 0)
				minoCounter++;
			if (faceType == 3)
				minoCounter--;
			if (earType == 3)
				minoCounter++;
			if (tailType == 4)
				minoCounter++;
			if (hornType == 2)
				minoCounter++;
			if (lowerBody == 1 && minoCounter > 0)
				minoCounter++;
			if (tallness >= 73 && minoCounter > 2)
				minoCounter++;
			if (vaginas.length > 0 && minoCounter > 2)
				minoCounter++;
			if (biggestTitSize() > 4 && minoCounter > 2)
				minoCounter++;
			if (biggestLactation() > 2 && minoCounter > 2)
				minoCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				minoCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && minoCounter >= 3)
				minoCounter += 1;
			return minoCounter;//dodać punkt do wyniku jak ma futro?
		}

		public function sandTrapScore():int
		{
			var counter:int = 0;
			if (findStatusAffect(StatusAffects.BlackNipples) >= 0)
				counter++;
			if (findStatusAffect(StatusAffects.Uniball) >= 0)
				counter++;
			if (hasVagina() && vaginaType() == 5)
				counter++;
			if (eyeType == 2)
				counter++;
			if (wingType == 12)
				counter++;
			if (findStatusAffect(StatusAffects.Uniball) >= 0)
				counter++;
			return counter;
		}

		//Determine Bee Rating
		public function beeScore():Number
		{
			var beeCounter:Number = 0;
			if (hairColor == "shiny black")
				beeCounter++;
			if (hairColor == "black and yellow")
				beeCounter += 2;
			if (antennae == 2)
			{
				beeCounter++;
				if (faceType == 0)
					beeCounter++;
			}
			if (armType == 4)
				beeCounter++;
			if (lowerBody == 7)
			{
				beeCounter++;
				if (vaginas.length == 1)
					beeCounter++;
			}
			if (tailType == 6)
				beeCounter++;
			if (wingType == 1)
				beeCounter++;
			if (wingType == 2)
				beeCounter += 2;
			if (beeCounter > 0 && findPerk(PerkLib.TrachealSystem) >= 0)
				beeCounter++;
		//	if (beeCounter > 0 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		beeCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				beeCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && beeCounter >= 3)
				beeCounter += 1;
			return beeCounter;
		}
		//Determine Ferret Rating!
		public function ferretScore():Number
		{
			var counter:int = 0;
			if (faceType == FACE_FERRET_MASK) counter++;
			if (faceType == FACE_FERRET) counter+=2;
			if (earType == EARS_FERRET) counter++;
			if (tailType == TAIL_TYPE_FERRET) counter++;
			if (lowerBody == LOWER_BODY_TYPE_FERRET) counter++;
			if (skinType == SKIN_TYPE_FUR && counter > 0) counter++;
			return counter;
		}
		//Determine Dog Rating
		public override function dogScore():Number
		{
			var dogCounter:Number = 0;
			if (faceType == 2)
				dogCounter++;
			if (earType == 2)
				dogCounter++;
			if (tailType == 2)
				dogCounter++;
			if (lowerBody == 2)
				dogCounter++;
			if (dogCocks() > 0)
				dogCounter++;
			if (breastRows.length > 1)
				dogCounter++;
			if (breastRows.length == 3)
				dogCounter++;
			if (breastRows.length > 3)
				dogCounter--;
			//Fur only counts if some canine features are present
			if (skinType == 1 && dogCounter > 0)
				dogCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				dogCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && dogCounter >= 3)
				dogCounter += 1;
			return dogCounter;
		}

		public function mouseScore():Number
		{
			var coonCounter:Number = 0;
			if (earType == 12)
				coonCounter++;
			if (tailType == 16)
				coonCounter++;

			if (faceType == 15)
				coonCounter++;
			if (faceType == 16)
				coonCounter += 2;
			//Fur only counts if some canine features are present
			if (skinType == 1 && coonCounter > 0)
				coonCounter++;

			if (tallness < 55 && coonCounter > 0)
				coonCounter++;
			if (tallness < 45 && coonCounter > 0)
				coonCounter++;
			return coonCounter;
		}

		public function raccoonScore():Number
		{
			var coonCounter:Number = 0;
			if (faceType == 13)
				coonCounter++;
			if (faceType == 14)
				coonCounter += 2;
			if (earType == 11)
				coonCounter++;
			if (tailType == 15)
				coonCounter++;
			if (lowerBody == 19)
				coonCounter++;
			if (coonCounter > 0 && balls > 0)
				coonCounter++;
			//Fur only counts if some canine features are present
			if (skinType == 1 && coonCounter > 0)
				coonCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				coonCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && coonCounter >= 3)
				coonCounter += 1;
			return coonCounter;
		}

		//Determine Fox Rating
		public override function foxScore():Number
		{
			var foxCounter:Number = 0;
			if (faceType == 11)
				foxCounter++;
			if (eyeType == 7)
				foxCounter++;
			if (earType == 9)
				foxCounter++;
			if (tailType == 13)
				foxCounter++;
			if (tailType == 13 && tailCount >= 2)
				foxCounter -= 7;
			if (armType == 13)
				foxCounter++;
			if (lowerBody == 17)
				foxCounter++;
			if (foxCocks() > 0 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length > 1 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length == 3 && foxCounter > 0)
				foxCounter++;
			if (breastRows.length == 4 && foxCounter > 0)
				foxCounter++;
			//Fur only counts if some canine features are present
			if (skinType == 1 && foxCounter > 0)
				foxCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				foxCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && foxCounter >= 3)
				foxCounter += 1;
			return foxCounter;
		}

		//Determine cat Rating
		public function catScore():Number
		{
			var catCounter:Number = 0;
			if (faceType == 6)
				catCounter++;
			if (eyeType == 3)
				catCounter++;
			if (earType == 5)
				catCounter++;
			if (tongueType == 5)
				catCounter++;
			if (tailType == 8)
				catCounter++;
			if (lowerBody == 9)
				catCounter++;
			if (catCocks() > 0)
				catCounter++;
			if (breastRows.length > 1 && catCounter > 0)
				catCounter++;
			if (breastRows.length == 3 && catCounter > 0)
				catCounter++;
			if (breastRows.length > 3)
				catCounter -= 2;
			//Fur only counts if some canine features are present
			if (skinType == 1 && catCounter > 0)
				catCounter++;
			if (hornType == HORNS_DEMON || hornType == HORNS_DRACONIC_X2 || hornType == HORNS_DRACONIC_X4_12_INCH_LONG)
					catCounter -= 2;
			if (wingType == WING_TYPE_BAT_LIKE_TINY || wingType == WING_TYPE_DRACONIC_SMALL || wingType == WING_TYPE_BAT_LIKE_LARGE || wingType == WING_TYPE_DRACONIC_LARGE || WING_TYPE_BAT_LIKE_LARGE_2 || WING_TYPE_DRACONIC_HUGE)
					catCounter -= 2;
			if (findPerk(PerkLib.Flexibility) > 0)
				catCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) > 0)
				catCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				catCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && catCounter >= 3)
				catCounter += 1;
			return catCounter;
		}

		//Determine lizard rating
		public function lizardScore():Number
		{
			var lizardCounter:Number = 0;
			if (faceType == 7)
				lizardCounter++;
			if (earType == 6)
				lizardCounter++;
			if (eyeType == 8)
				lizardCounter++;
			if (tailType == 9)
				lizardCounter++;
			if (armType == 14)
				lizardCounter++;
			if (lowerBody == 10)
				lizardCounter++;
			if (horns > 0 && (hornType == 3 || hornType == 4))
				lizardCounter++;
			if (skinType == 2)
				lizardCounter++;
			if (lizardCocks() > 0)
				lizardCounter++;
			if (lizardCounter > 0 && findPerk(PerkLib.LizanRegeneration) >= 0)
				lizardCounter++;
			if (findPerk(PerkLib.LizanMarrow) >= 0)
				lizardCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				lizardCounter += 10;
			if (findPerk(PerkLib.LizanMarrow) >= 0 && findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				lizardCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && lizardCounter >= 4)
				lizardCounter += 1;
			return lizardCounter;
		}

		public function spiderScore():Number
		{
			var spiderCounter:Number = 0;
			if (eyeType == 1)
				spiderCounter++;
			if (faceType == 10)
				spiderCounter++;
			if (armType == 2)
				spiderCounter++;
			if (lowerBody == 15)
				spiderCounter++;
			if (lowerBody == 16)
				spiderCounter += 2;
			if (tailType == 5)
				spiderCounter++;
			if (skinType != 5 && spiderCounter > 0)
				spiderCounter--;
			if (skinType == 5)
				spiderCounter++;
			if (spiderCounter > 0 && findPerk(PerkLib.TrachealSystem) >= 0)
				spiderCounter++;
		//	if (spiderCounter > 0 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		spiderCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				spiderCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && spiderCounter >= 3)
				spiderCounter += 1;
			return spiderCounter;
		}

		//Determine Horse Rating
		public function horseScore():Number
		{
			var horseCounter:Number = 0;
			if (faceType == 1)
				horseCounter++;
			if (earType == 1)
				horseCounter++;
			if (tailType == 1)
				horseCounter++;
			if (lowerBody == 1 || lowerBody == 4)
				horseCounter++;
			if (horseCocks() > 0)
				horseCounter++;
			if (hasVagina() && vaginaType() == 1)
				horseCounter++;
			//Fur only counts if some equine features are present
			if (skinType == 1 && horseCounter > 0)
				horseCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				horseCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && horseCounter >= 3)
				horseCounter += 1;
			return horseCounter;
		}

		//Determine kitsune Rating
		public function kitsuneScore():Number
		{
			var kitsuneCounter:int = 0;
			if (eyeType == 7)
				kitsuneCounter++;
			if (earType == EARS_FOX)
				kitsuneCounter++;
			//If the character has ears other than fox ears, -1
			if (earType != EARS_FOX)
				kitsuneCounter--;
			if (tailType == TAIL_TYPE_FOX && tailCount >= 2 && tailCount < 4)
				kitsuneCounter++;
			if (tailType == TAIL_TYPE_FOX && tailCount >= 4 && tailCount < 6)
				kitsuneCounter += 2;
			if (tailType == TAIL_TYPE_FOX && tailCount >= 6 && tailCount < 9)
				kitsuneCounter += 3;
			if (tailType == TAIL_TYPE_FOX && tailCount == 9)
				kitsuneCounter += 4;
			if (tailType != TAIL_TYPE_FOX || (tailType == TAIL_TYPE_FOX && tailCount < 2))
				kitsuneCounter -= 7;
			if (skinType == SKIN_TYPE_TATTOED || skinType == SKIN_TYPE_FUR)
				kitsuneCounter++;
			//If the character has fur, scales, or gooey skin, -1
		//	if (skinType == SKIN_TYPE_FUR && !InCollection(furColor, KitsuneScene.basicKitsuneFur) && !InCollection(furColor, KitsuneScene.elderKitsuneColors))
		//		kitsuneCounter--;
			if (skinType == SKIN_TYPE_SCALES || skinType == SKIN_TYPE_CHITIN)
				kitsuneCounter -= 2;
			if (skinType == SKIN_TYPE_GOO)
				kitsuneCounter -= 3;
			if (armType == 0 || armType == 12)
				kitsuneCounter++;
			if (lowerBody == LOWER_BODY_TYPE_FOX || lowerBody == LOWER_BODY_TYPE_HUMAN)
				kitsuneCounter++;
			if (lowerBody != LOWER_BODY_TYPE_HUMAN && lowerBody != LOWER_BODY_TYPE_FOX)
				kitsuneCounter--;
			//If the character has a 'vag of holding', +1
			if (vaginalCapacity() >= 8000)
				kitsuneCounter++;
			if (faceType == FACE_HUMAN || faceType == FACE_FOX)
				kitsuneCounter++;
			if (faceType != FACE_HUMAN && faceType != FACE_FOX)
				kitsuneCounter--;
			//If the character has "blonde","black","red","white", or "silver" hair, +1
		//	if (kitsuneCounter > 0 && (InCollection(furColor, KitsuneScene.basicKitsuneHair) || InCollection(furColor, KitsuneScene.elderKitsuneColors)))
		//		kitsuneCounter++;
			if (findPerk(PerkLib.StarSphereMastery) >= 0)
				kitsuneCounter++;
			//When character get Hoshi no tama
			if (findPerk(PerkLib.KitsuneThyroidGland) >= 0)
				kitsuneCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && kitsuneCounter >= 5)
				kitsuneCounter += 1;
			if (findPerk(PerkLib.KitsuneThyroidGland) >= 0 && findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				kitsuneCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				kitsuneCounter += 10;
			return kitsuneCounter;
		}

		//Determine Dragon Rating
		public function dragonScore():Number
		{
			var dragonCounter:Number = 0;
		//	if (faceType == 12)
		//		dragonCounter++;
			if (eyeType == 10)
				dragonCounter++;
			if (earType == 10)
				dragonCounter++;
			if (tailType == 14)
				dragonCounter++;
			if (tongueType == 3)
				dragonCounter++;
			if (wingType == 10)
				dragonCounter++;
			if (wingType == 11)
				dragonCounter += 2;
			if (wingType == 14)
				dragonCounter += 4;
			if (lowerBody == 18)
				dragonCounter++;
			if (armType == 15)
				dragonCounter++;
		//	if (tallness > 120 && dragonCounter > 0)
		//		dragonCounter++;
		//	if (skinType == 2 && dragonCounter > 0)
		//		dragonCounter++;
			if (hornType == HORNS_DRACONIC_X4_12_INCH_LONG)
				dragonCounter += 2;
			if (hornType == HORNS_DRACONIC_X2)
				dragonCounter++;
		//	if (dragonCocks() > 0)
		//		dragonCounter++;
		//	if (findPerk(PerkLib.DragonFireBreath) >= 0)
		//		dragonCounter++;
		//	if (findPerk(PerkLib.DragonIceBreath) >= 0)
		//		dragonCounter++;
			if (findPerk(PerkLib.DraconicLungs) >= 0)
				dragonCounter++;
		//	if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
		//		dragonCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && dragonCounter >= 4)
				dragonCounter += 1;
			return dragonCounter;
		}

		//Goblin score
		public function goblinScore():Number
		{
			var goblinCounter:Number = 0;
			if (skinTone == "pale yellow" || skinTone == "grayish-blue" || skinTone == "green" || skinTone == "dark green") {	
				if (tallness < 48 && goblinCounter > 0)
					goblinCounter++;
				if (faceType == 0)
					goblinCounter++;
				if (hasVagina())
					goblinCounter++;
				if (lowerBody == 0)
					goblinCounter++;
			}
			if (earType == 4)
				goblinCounter++;
			if (skinTone == "pale yellow" || skinTone == "grayish-blue" || skinTone == "green" || skinTone == "dark green")
				goblinCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && goblinCounter >= 3)
				goblinCounter += 1;
			return goblinCounter;
		}

		//Goo score
		public function gooScore():Number
		{
			var gooCounter:Number = 0;
			if (hairType == 3)
				gooCounter++;
			if (skinType == 3 && skinAdj == "slimy") {
				gooCounter++;
				if (faceType == 0)
					gooCounter++;
				if (armType == 0)
					gooCounter++;
			}
			if (wingType == 0)
				gooCounter++;
			if (lowerBody == 8)
				gooCounter += 2;
			if (vaginalCapacity() > 9000)
				gooCounter++;
			if (findStatusAffect(StatusAffects.SlimeCraving) >= 0)
				gooCounter++;
			if (findPerk(PerkLib.SlimeCore) >= 0)
				gooCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				gooCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && gooCounter >= 4)
				gooCounter += 1;
			return gooCounter;
		}

		//Naga score
		public function nagaScore():Number
		{
			var nagaCounter:Number = 0;
			if (isNaga())
				nagaCounter += 2;
			if (tongueType == 1)
				nagaCounter++;
			if (faceType == 5)
				nagaCounter++;
			if (armType == 0)
				nagaCounter++;
			if (skinType == 11)
				nagaCounter++;
			if (eyeType == 9)
				nagaCounter++;
			if (earType == 22)
				nagaCounter++;
			if (gorgonScore() > 10 || vouivreScore() > 10 || couatlScore() > 10)
				nagaCounter -= 6;
		//	if (wingType != 0)
		//		nagaCounter -= 6;
		//	if (eyeType == 4)
		//		nagaCounter -= 3;
		//	if (hairType == 6)
		//		nagaCounter -= 3;
			return nagaCounter;
		}
		//Gorgon score
		public function gorgonScore():Number
		{
			var gorgonCounter:Number = 0;
			if (isNaga())
				gorgonCounter += 2;
			if (tongueType == 1)
				gorgonCounter++;
			if (faceType == 5)
				gorgonCounter++;
			if (armType == 0)
				gorgonCounter++;
			if (skinType == 2 || skinType == 11)
				gorgonCounter++;
			if (earType == 22)
				gorgonCounter++;
			if (eyeType == 9)
				gorgonCounter++;
			if (eyeType == 4)
				gorgonCounter += 2;
			if (hairType == 6)
				gorgonCounter += 2;
			if (findPerk(PerkLib.GorgonsEyes) >= 0)
				gorgonCounter++;
			if (antennae != 0)
				gorgonCounter -= 3;
			if (wingType != 0)
				gorgonCounter -= 3;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				gorgonCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && gorgonCounter >= 3)
				gorgonCounter += 1;
			return gorgonCounter;
		}
		//Vouivre score
		public function vouivreScore():Number
		{
			var vouivreCounter:Number = 0;
			if (isNaga())
				vouivreCounter += 2;
			if (tongueType == 1)
				vouivreCounter++;
			if (faceType == 5)
				vouivreCounter++;
			if (armType == 0)
				vouivreCounter++;
			if (skinType == 2 || skinType == 11)
				vouivreCounter++;
			if (eyeType == 9)
				vouivreCounter++;
			if (earType == 10)
				vouivreCounter++;
			if (hornType == HORNS_DRACONIC_X4_12_INCH_LONG || hornType == HORNS_DRACONIC_X2)
				vouivreCounter++;
			if (wingType == 10 || wingType == 11 || wingType == 14)
				vouivreCounter += 2;
			if (findPerk(PerkLib.DragonFireBreath) >= 0)
				vouivreCounter++;
			if (findPerk(PerkLib.DragonIceBreath) >= 0)
				vouivreCounter++;
			if (findPerk(PerkLib.DraconicLungs) >= 0)
				vouivreCounter++;
			return vouivreCounter;
		}
		//Couatl score
		public function couatlScore():Number
		{
			var couatlCounter:Number = 0;
			if (isNaga())
				couatlCounter += 2;
			if (tongueType == 1)
				couatlCounter++;
			if (faceType == 5)
				couatlCounter++;
			if (armType == 1)
				couatlCounter++;
			if (skinType == 2 || skinType == 11)
				couatlCounter++;
			if (earType == 22)
				couatlCounter++;
			if (eyeType == 9)
				couatlCounter++;
			if (hairType == 1)
				couatlCounter++;
			if (wingType == 9)
				couatlCounter += 2;
			return couatlCounter;
		}

		//Bunny score
		public function bunnyScore():Number
		{
			var bunnyCounter:Number = 0;
			if (faceType == 8)
				bunnyCounter++;
			if (tailType == 10)
				bunnyCounter++;
			if (earType == 7)
				bunnyCounter++;
			if (lowerBody == 12)
				bunnyCounter++;
			//More than 2 balls reduces bunny score
			if (balls > 2 && bunnyCounter > 0)
				bunnyCounter--;
			//Human skin on bunmorph adds
			if (skinType == 0 && bunnyCounter > 1 && skinTone != "slippery")
				bunnyCounter++;
			//No wings and antennae a plus
			if (bunnyCounter > 0 && antennae == 0)
				bunnyCounter++;
			if (bunnyCounter > 0 && wingType == 0)
				bunnyCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				bunnyCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && bunnyCounter >= 3)
				bunnyCounter += 1;
			return bunnyCounter;
		}

		//Harpy score
		public function harpyScore():Number
		{
			var harpy:Number = 0;
			if (armType == 1)
				harpy++;
			if (hairType == 1)
				harpy++;
			if (wingType == 9)
				harpy += 2;
			if (tailType == 11)
				harpy++;
			if (tailType == 7 || tailType == 25)
				harpy -= 5;
			if (armType == 1)
				harpy++;
			if (lowerBody == 13)
				harpy++;
			if (lowerBody == 25)
				harpy--;
			if (harpy >= 2 && faceType == 0)
				harpy++;
			if (faceType == 4)
				harpy--;
			if (harpy >= 2 && (earType == 0 || earType == 4))
				harpy++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				harpy += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && harpy >= 3)
				harpy += 1;
			return harpy;
		}

		//Kanga score
		public function kangaScore():Number
		{
			var kanga:Number = 0;
			if (kangaCocks() > 0)
				kanga++;
			if (earType == 8)
				kanga++;
			if (tailType == 12)
				kanga++;
			if (lowerBody == 14)
				kanga++;
			if (faceType == 9)
				kanga++;
			if (kanga >= 2 && skinType == 1)
				kanga++;
			return kanga;
		}

		//shark score
		public function sharkScore():Number
		{
			var sharkCounter:Number = 0;
			if (faceType == 4)
				sharkCounter++;
			if (gillType == 2)
				sharkCounter++;
			if (rearBody == 6)
				sharkCounter++;
			if (wingType == 9)
				sharkCounter -= 7;
			if (armType == 8)
				sharkCounter++;
			if (lowerBody == 29)
				sharkCounter++;
			if (tailType == 7)
				sharkCounter++;
			if (hairType == 0 && hairColor == "silver")
				sharkCounter++;
			if (skinType == 2 && (skinTone == "rough gray" || skinTone == "orange and black"))
				sharkCounter++;
			if (eyeType == 0 && hairType == 0 && hairColor == "silver" && skinType == 2 && (skinTone == "rough gray" || skinTone == "orange and black"))
				sharkCounter++;
			if (vaginas.length > 0 && cocks.length > 0)
				sharkCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				sharkCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && sharkCounter >= 3)
				sharkCounter += 1;
			return sharkCounter;
		}

		//Orca score
		public function orcaScore():Number
		{
			var orcaCounter:Number = 0;
			if (earType == EARS_ORCA)
				orcaCounter++;
			if (tailType == TAIL_TYPE_ORCA)
				orcaCounter++;
			if (faceType == FACE_ORCA)
				orcaCounter++;
			if (lowerBody == LOWER_BODY_TYPE_ORCA)
				orcaCounter++;
			if (armType == ARM_TYPE_ORCA)
				orcaCounter++;
			if (rearBody == REAR_BODY_ORCA_BLOWHOLE)
				orcaCounter++;
			if (skinType == 0 && skinAdj == "glossy")
				orcaCounter++;
			if (skinTone == "white and black")
				orcaCounter++;
			if (wingType == 0)
				orcaCounter += 2;
			if (eyeType == 0)
				orcaCounter++;
			if (tallness >= 84)
				orcaCounter++;
			return orcaCounter;
		}
		
		//Determine Mutant Rating
		public function mutantScore():Number
		{
			var mutantCounter:Number = 0;
			if (faceType > 0)
				mutantCounter++;
			if (skinType > 0)
				mutantCounter++;
			if (tailType > 0)
				mutantCounter++;
			if (cockTotal() > 1)
				mutantCounter++;
			if (hasCock() && hasVagina())
				mutantCounter++;
			if (hasFuckableNipples())
				mutantCounter++;
			if (breastRows.length > 1)
				mutantCounter++;
			if (faceType == 1)
			{
				if (skinType == 1)
					mutantCounter--;
				if (tailType == 1)
					mutantCounter--;
			}
			if (faceType == 2)
			{
				if (skinType == 1)
					mutantCounter--;
				if (tailType == 2)
					mutantCounter--;
			}
			return mutantCounter--;
		}
		
		//scorpion score
		public function scorpionScore():Number
		{
			var scorpionCounter:Number = 0;
			if (skinType == 5)
				scorpionCounter++;
			if (tailType == TAIL_TYPE_SCORPION)
				scorpionCounter++;
			if (scorpionCounter > 0 && findPerk(PerkLib.TrachealSystem) >= 0)
				scorpionCounter++;
		//	if (scorpionCounter > 0 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		scorpionCounter++;
			return scorpionCounter;
		}
		
		//Mantis score
		public function mantisScore():Number
		{
			var mantisCounter:Number = 0;
			if (skinType == 5)
				mantisCounter++;
			if (antennae == 1)
			{
				mantisCounter++;
				if (faceType == 0)
					mantisCounter++;
			}
			if (armType == 3)
				mantisCounter++;
			if (lowerBody == 27)
				mantisCounter++;
			if (tailType == 27)
				mantisCounter++;
			if (wingType == 17)
				mantisCounter++;
			if (wingType == 18)
				mantisCounter += 2;
			if (mantisCounter > 0 && findPerk(PerkLib.TrachealSystem) >= 0)
				mantisCounter++;
		//	if (mantisCounter > 0 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		mantisCounter++;
			if (findPerk(PerkLib.MantislikeAgility) >= 0)
				mantisCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				mantisCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && mantisCounter >= 3)
				mantisCounter += 1;
			return mantisCounter;
		}
		
		//Salamander score
		public function salamanderScore():Number
		{
			var salamanderCounter:Number = 0;
			if (skinType == 11)
				salamanderCounter++;
			if (faceType == 26)
				salamanderCounter++;
			if (earType == 0 && faceType == 26)
				salamanderCounter++;
			if (eyeType == 8)
				salamanderCounter++;
			if (armType == 5)
				salamanderCounter++;
			if (lowerBody == 25)
				salamanderCounter++;
			if (tailType == TAIL_TYPE_SALAMANDER)
				salamanderCounter++;
			if (lizardCocks() > 0)
				salamanderCounter++;
			if (findPerk(PerkLib.Lustzerker) >= 0)
				salamanderCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlands) >= 0)
				salamanderCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				salamanderCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && salamanderCounter >= 3)
				salamanderCounter += 1;
			return salamanderCounter;
		}
		
		//Yeti score
		public function yetiScore():Number
		{
			var yetiCounter:Number = 0;
			if (skinTone == "dark")
				yetiCounter++;
			if (eyeType == 0)
				yetiCounter++;
			if (lowerBody == 36)
				yetiCounter++;
			if (armType == 16)
				yetiCounter++;
			if (earType == 20)
				yetiCounter++;
			if (faceType == 27)
				yetiCounter++;
			if (hairType == 8)
				yetiCounter++;
			if (hairColor == "white")
				yetiCounter++;
			if (skinType == 10)
				yetiCounter++;
			if (furColor == "white")
				yetiCounter++;
			if (tallness >= 78)
				yetiCounter++;
			if (buttRating >= 10)
				yetiCounter++;
			return yetiCounter;
		}
		
		//Centaur score
		public function centaurScore():Number
		{
			var centaurCounter:Number = 0;
			if (isTaur()) {
				if (lowerBody == 1 || lowerBody == 21)
					centaurCounter += 2;
				if (tailType == 1 && (lowerBody == 1 || lowerBody == 21))
					centaurCounter++;
				if (skinType == 0 && (lowerBody == 1 || lowerBody == 21))
					centaurCounter++;
				if (armType == 0 && (lowerBody == 1 || lowerBody == 21))
					centaurCounter++;
				if (earType == 0 && (lowerBody == 1 || lowerBody == 21))
					centaurCounter++;
				if (faceType == 0 && (lowerBody == 1 || lowerBody == 21))
					centaurCounter++;
			}
			if (antennae != 0)
				centaurCounter--;
			if (faceType != 0)
				centaurCounter--;
			if (wingType != 0)
				centaurCounter--;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				centaurCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && centaurCounter >= 3)
				centaurCounter += 1;
			return centaurCounter;
		}
		
		//Determine Unicorn Rating
		public function unicornScore():Number
		{
			var unicornCounter:Number = 0;
			if (faceType == 1)
				unicornCounter++;
			if (earType == 1)
				unicornCounter++;
			if (tailType == 1)
				unicornCounter++;
			if (lowerBody == 1)
				unicornCounter++;
			if (hornType == 7 && horns < 6)
				unicornCounter++;
			if (hornType == 7 && horns >= 6)
				unicornCounter += 2;
			if (horseCocks() > 0)
				unicornCounter++;
			if (hasVagina() && vaginaType() == 1)
				unicornCounter++;
			//Fur and hair color only counts if some unicorn features are present and it's white colored
			if (unicornCounter > 0 && skinType == 1 && furColor == "white")
				unicornCounter++;
			if (unicornCounter > 0 && hairColor == "white")
				unicornCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				unicornCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && unicornCounter >= 3)
				unicornCounter += 1;
			return unicornCounter;
		}
		
		//Determine Alicorn Rating
		public function alicornScore():Number
		{
			var alicornCounter:Number = 0;
			if (faceType == 1)
				alicornCounter++;
			if (earType == 1)
				alicornCounter++;
			if (tailType == 1)
				alicornCounter++;
			if (lowerBody == 1)
				alicornCounter++;
			if (hornType == 7 && horns < 6)
				alicornCounter++;
			if (hornType == 7 && horns >= 6)
				alicornCounter += 2;
			if (wingType == 16)
				alicornCounter += 2;
			if (wingType != 16)
				alicornCounter -= 2;
			if (horseCocks() > 0)
				alicornCounter++;
			if (hasVagina() && vaginaType() == 1)
				alicornCounter++;
			//Fur and hair color only counts if some alicorn features are present and it's white colored
			if (alicornCounter > 0 && skinType == 1 && furColor == "white")
				alicornCounter++;
			if (alicornCounter > 0 && hairColor == "white")
				alicornCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				alicornCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && alicornCounter >= 3)
				alicornCounter += 1;
			return alicornCounter;
		}
		
		//Determine Phoenix Rating
		public function phoenixScore():Number
		{
			var phoenixCounter:Number = 0;
			if (hairType == 1) {
				if (hairType == 1)
					phoenixCounter++;
				if (faceType == 0 && phoenixCounter > 2)
					phoenixCounter++;
				if (earType == 0 && phoenixCounter > 2)
					phoenixCounter++;
			}
			if (eyeType == 8)
				phoenixCounter++;
			if (wingType == 15)
				phoenixCounter++;
			if (armType == 6)
				phoenixCounter++;
			if (lowerBody == 25)
				phoenixCounter++;
			if (tailType == TAIL_TYPE_SALAMANDER)
				phoenixCounter++;
			if (lizardCocks() > 0)
				phoenixCounter++;
		//	if (findPerk(PerkLib.SalamanderAdrenalGlands) >= 0)
		//		phoenixCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				phoenixCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && phoenixCounter >= 3)
				phoenixCounter += 1;
			return phoenixCounter;
		}
		
		//Scylla score
		public function scyllaScore():Number
		{
			var scyllaCounter:Number = 0;
			if (faceType == 0)
				scyllaCounter++;
			if (faceType != 0)
				scyllaCounter--;
			if (earType == EARS_ELFIN)
				scyllaCounter++;
			if (skinType == 0 && skinAdj == "slippery")
				scyllaCounter++;
			if (isScylla())
				scyllaCounter += 2;
			if (findPerk(PerkLib.InkSpray) >= 0)
				scyllaCounter++;
			if (findPerk(PerkLib.ScyllaInkGlands) >= 0)
				scyllaCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				scyllaCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && scyllaCounter >= 3)
				scyllaCounter += 1;
			return scyllaCounter;
		}//potem tentacle dick lub scylla vag też bedą sie liczyć do wyniku)
		
		//Determine Kitshoo Rating
		public function kitshooScore():Number
		{
			var kitshooCounter:int = 0;
			//If the character has fox ears, +1
			if (earType == EARS_FOX)
				kitshooCounter++;
			//If the character has a fox tail, +1
		//	if (tailType == TAIL_TYPE_FOX)
		//		kitshooCounter++;
			//If the character has two to eight fox tails, +2
		//	if (tailType == TAIL_TYPE_FOX && tailCount >= 2 && tailCount < 9)
		//		kitshooCounter += 2;
			//If the character has nine fox tails, +3
		//	if (tailType == TAIL_TYPE_FOX && tailCount == 9)
		//		kitshooCounter += 3;
			//If the character has tattooed skin, +1
			//9999
			//If the character has a 'vag of holding', +1
		//	if (vaginalCapacity() >= 8000)
		//		kitshooCounter++;
			//If the character's kitshoo score is greater than 0 and:
			//If the character has a normal face, +1
			if (kitshooCounter > 0 && (faceType == FACE_HUMAN || faceType == FACE_FOX))
				kitshooCounter++;
			//If the character's kitshoo score is greater than 1 and:
			//If the character has "blonde","black","red","white", or "silver" hair, +1
			if (kitshooCounter > 0 && (InCollection(furColor, KitsuneScene.basicKitsuneHair) || InCollection(furColor, KitsuneScene.elderKitsuneColors)))
				kitshooCounter++;
			//If the character's femininity is 40 or higher, +1
		//	if (kitshooCounter > 0 && femininity >= 40)
		//		kitshooCounter++;
			//If the character has fur, chitin, or gooey skin, -1
		//	if (skinType == SKIN_TYPE_FUR && !InCollection(furColor, KitsuneScene.basicKitsuneFur) && !InCollection(furColor, KitsuneScene.elderKitsuneColors))
		//		kitshooCounter--;
		//	if (skinType == SKIN_TYPE_SCALES)
		//		kitshooCounter -= 2; - czy bedzie pozytywny do wyniku czy tez nie?
			if (skinType == SKIN_TYPE_CHITIN)
				kitshooCounter -= 2;
			if (skinType == SKIN_TYPE_GOO)
				kitshooCounter -= 3;
			//If the character has abnormal legs, -1
		//	if (lowerBody != LOWER_BODY_TYPE_HUMAN && lowerBody != LOWER_BODY_TYPE_FOX)
		//		kitshooCounter--;
			//If the character has a nonhuman face, -1
		//	if (faceType != FACE_HUMAN && faceType != FACE_FOX)
		//		kitshooCounter--;
			//If the character has ears other than fox ears, -1
		//	if (earType != EARS_FOX)
		//		kitshooCounter--;
			//If the character has tail(s) other than fox tails, -1
		//	if (tailType != TAIL_TYPE_FOX)
		//		kitshooCounter--;
			//When character get one of 9-tail perk
		//	if (kitshooCounter >= 3 && (findPerk(PerkLib.EnlightenedNinetails) >= 0 || findPerk(PerkLib.CorruptedNinetails) >= 0))
		//		kitshooCounter += 2;
			//When character get Hoshi no tama
		//	if (findPerk(PerkLib.KitsuneThyroidGland) >= 0)
		//		kitshooCounter++;
		//	if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
		//		kitshooCounter += 10;
			return kitshooCounter;
		}
		
		//plant score
		public function plantScore():Number
		{
			var plantCounter:Number = 0;
			if (faceType == 0)
				plantCounter++;
			if (faceType == 29)
				plantCounter--;
			if (hornType == 9 || hornType == 11)
				plantCounter++;
			if (earType == 4)
				plantCounter++;
			if (hairType == 7 && hairColor == "green")
				plantCounter++;
			if (skinType == 0 && (skinTone == "leaf green" || skinTone == "lime green" || skinTone == "turquoise"))
				plantCounter++;
		//	if (skinType == 6)/zielona skóra +1, bark skin +2
		//		plantCounter += 2;
			if (armType == 7)
				plantCounter++;
			if (lowerBody == 31 || lowerBody == 32) {
				if (tentacleCocks() > 0) {
					plantCounter++;
				}
				plantCounter++;
			}
			if (lowerBody == 34)
				plantCounter += 3;
			if (wingType == WING_TYPE_PLANT)
				plantCounter++;
		//	if (scorpionCounter > 0 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		plantCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && plantCounter >= 3)
				plantCounter += 1;
			return plantCounter;
		}
		
		public function yggdrasilScore():Number
		{
			var yggdrasilCounter:Number = 0;
			if (faceType == 29)
				yggdrasilCounter += 2;
			if (armType == 7 || armType == 18)
				yggdrasilCounter++;
			//claws?
			
			if (wingType == WING_TYPE_PLANT)
				yggdrasilCounter++;
			//skin(fur(moss), scales(bark))
			
			if (tentacleCocks() > 0 || stamenCocks() > 0)
				yggdrasilCounter++;
			if (lowerBody == 38)
				yggdrasilCounter++;
			if (tailType == 32)
				yggdrasilCounter++;
			return yggdrasilCounter;
		}
		
		//Wolf/Fenrir score
		public function wolfScore():Number
		{
			var wolfCounter:Number = 0;
			if (faceType == 24)
				wolfCounter++;
			if (eyeType == 5)
				wolfCounter++;
			if (earType == 18)
				wolfCounter++;
			if (armType == 10)
				wolfCounter++;
			if (lowerBody == 33)
				wolfCounter++;
			if (tailType == 29)
				wolfCounter++;
			if (skinType == 1)
				wolfCounter++;
			if (hairColor == "glacial white" && furColor == "glacial white")
				wolfCounter++;
			if (rearBody == 3)
				wolfCounter++;
			if (wolfCocks() > 0 && wolfCounter > 0)
				wolfCounter++;
			if (findPerk(PerkLib.FreezingBreath) >= 0)
				wolfCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && eyeType == 5)
				wolfCounter += 1;
			return wolfCounter;
		}
		
		public function sirenScore():Number 
		{
			var sirenCounter:Number = 0;
			if (faceType == 4)
				sirenCounter++;
			if (hairType == 1)
				sirenCounter++;
			if (hairColor == "silver")
				sirenCounter++;
			if (tailType == 7)
				sirenCounter++;
			if (wingType == WING_TYPE_FEATHERED_LARGE)
				sirenCounter += 2;
			if (armType == ARM_TYPE_HARPY)
				sirenCounter++;
			if (lowerBody == 29)
				sirenCounter++;
			if (skinType == 2 && (skinTone == "rough gray" || skinTone == "orange and black"))
				sirenCounter++;
			if (gillType == 2) 
				sirenCounter++;
			if (eyeType == 0)
				sirenCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				sirenCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && sirenCounter >= 3)
				sirenCounter += 1;
			return sirenCounter;
		}
		
		public function pigScore():Number
		{
			var pigCounter:Number = 0;
			if (earType == EARS_PIG)
				pigCounter++;
			if (tailType == TAIL_TYPE_PIG)
				pigCounter++;
			if (faceType == FACE_PIG || FACE_BOAR)
				pigCounter++;
			if (lowerBody == LOWER_BODY_TYPE_CLOVEN_HOOFED)
				pigCounter += 2;
			if (pigCocks() > 0)
				pigCounter++;
			return pigCounter;
		}
		
		public function satyrScore():Number
		{
			var satyrCounter:Number = 0;
			if (lowerBody == LOWER_BODY_TYPE_HOOFED)
				satyrCounter++;
			if (tailType == TAIL_TYPE_GOAT)
				satyrCounter++;
			if (satyrCounter >= 2) {
				if (earType == EARS_ELFIN)
					satyrCounter++;
				if (faceType == FACE_HUMAN)
					satyrCounter++;
				if (countCocksOfType(CockTypesEnum.HUMAN) > 0)
					satyrCounter++;
				if (balls > 0 && ballSize >= 3)
					satyrCounter++;
			}
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				satyrCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && satyrCounter >= 3)
				satyrCounter += 1;
			return satyrCounter;
		}
		
		public function rhinoScore():Number
		{
			var rhinoCounter:Number = 0;
			if (earType == EARS_RHINO)
				rhinoCounter++;
			if (tailType == TAIL_TYPE_RHINO)
				rhinoCounter++;
			if (faceType == FACE_RHINO)
				rhinoCounter++;
			if (hornType == HORNS_RHINO)
				rhinoCounter++;
			if (rhinoCounter >= 2 && skinTone == "gray")
				rhinoCounter++;
			if (rhinoCounter >= 2 && hasCock() && countCocksOfType(CockTypesEnum.RHINO) > 0)
				rhinoCounter++;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0)
				rhinoCounter += 10;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && rhinoCounter >= 3)
				rhinoCounter += 1;
			return rhinoCounter;
		}
		
		public function echidnaScore():Number
		{
			var echidnaCounter:Number = 0;
			if (earType == EARS_ECHIDNA)
				echidnaCounter++;
			if (tailType == TAIL_TYPE_ECHIDNA)
				echidnaCounter++;
			if (faceType == FACE_ECHIDNA)
				echidnaCounter++;
			if (tongueType == TONUGE_ECHIDNA)
				echidnaCounter++;
			if (lowerBody == LOWER_BODY_TYPE_ECHIDNA)
				echidnaCounter++;
			if (echidnaCounter >= 2 && skinType == SKIN_TYPE_FUR)
				echidnaCounter++;
			if (echidnaCounter >= 2 && countCocksOfType(CockTypesEnum.ECHIDNA) > 0)
				echidnaCounter++;
			return echidnaCounter;
		}
		
		public function deerScore():Number
		{
			var deerCounter:Number = 0;
			if (earType == EARS_DEER)
				deerCounter++;
			if (tailType == TAIL_TYPE_DEER)
				deerCounter++;
			if (faceType == FACE_DEER)
				deerCounter++;
			if (lowerBody == LOWER_BODY_TYPE_CLOVEN_HOOFED || lowerBody == LOWER_BODY_TYPE_DEERTAUR)
				deerCounter++;
			if (hornType == HORNS_ANTLERS && horns >= 4)
				deerCounter++;
			if (deerCounter >= 2 && skinType == SKIN_TYPE_FUR)
				deerCounter++;
			if (deerCounter >= 3 && countCocksOfType(CockTypesEnum.HORSE) > 0)
				deerCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && deerCounter >= 3)
				deerCounter += 1;
			return deerCounter;
		}
		
		//Dragonne
		public function dragonneScore():Number
		{
			var dragonneCounter:Number = 0;
			if (faceType == FACE_CAT)
				dragonneCounter++;
			if (earType == EARS_CAT)
				dragonneCounter++;
			if (tailType == TAIL_TYPE_CAT)
				dragonneCounter++;
			if (tongueType == TONUGE_DRACONIC)
				dragonneCounter++;
			if (wingType == WING_TYPE_DRACONIC_LARGE)
				dragonneCounter += 2;
			if (wingType == WING_TYPE_DRACONIC_SMALL)
				dragonneCounter++;
			if (lowerBody == LOWER_BODY_TYPE_CAT)
				dragonneCounter++;
			if (skinType == 2 && dragonneCounter > 0)
				dragonneCounter++;
			return dragonneCounter;
		}
		
		//Manticore
		public function manticoreScore():Number
		{
			var manticoreCounter:Number = 0;
			if (faceType == FACE_MANTICORE)
				manticoreCounter++;
			if (eyeType == EYES_MANTICORE)
				manticoreCounter++;
			if (earType == EARS_LION)
				manticoreCounter++;
			if (tailType == TAIL_TYPE_MANTICORE_PUSSYTAIL)
				manticoreCounter += 2;
			if (rearBody == REAR_BODY_LION_MANE)
				manticoreCounter++;
			if (armType == ARM_TYPE_LION)
				manticoreCounter++;
			if (lowerBody == LOWER_BODY_TYPE_LION)
				manticoreCounter++;
		//	if (manticoreCounter >= 4) {
		//		if (hornType == HORNS_DEMON || hornType == HORNS_DRACONIC_X2 || hornType == HORNS_DRACONIC_X4_12_INCH_LONG)
		//			manticoreCounter++;
			if (wingType == WING_TYPE_MANTICORE_LIKE_SMALL)
					manticoreCounter++;
			if (wingType == WING_TYPE_MANTICORE_LIKE_LARGE)
					manticoreCounter += 2;
		//		if (wingType == WING_TYPE_BAT_LIKE_LARGE_2 || wingType == WING_TYPE_DRACONIC_HUGE)
		//			manticoreCounter += 3;
		//	}
			//Fur only counts if some canine features are present
		//	if (skinType == 1 && manticoreCounter > 2)
		//		manticoreCounter++;
			if (findPerk(PerkLib.ManticoreMetabolism) >= 0)
				manticoreCounter++;
			if (cocks.length > 0)
				manticoreCounter -= 3;
			if (findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0 && findPerk(PerkLib.ManticoreMetabolism) >= 0 && manticoreCounter >= 5)
				manticoreCounter += 1;
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0 && findPerk(PerkLib.ManticoreMetabolism) >= 0 && manticoreCounter >= 6)
				manticoreCounter += 1;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0 && findPerk(PerkLib.ManticoreMetabolism) >= 0 && manticoreCounter >= 7)
				manticoreCounter += 1;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && manticoreCounter >= 3)
				manticoreCounter += 1;
			return manticoreCounter;
		}
		
		//Gargoyle
		public function gargoyleScore():Number
		{
			var gargoyleCounter:Number = 0;
			if (skinType == 7)
				gargoyleCounter++;
			if (hornType == 10)
				gargoyleCounter++;
			if (armType == 9)
				gargoyleCounter++;
			if (tailType == 30)
				gargoyleCounter++;
			if (wingType == 20)
				gargoyleCounter++;
			if (lowerBody == LOWER_BODY_TYPE_GARGOYLE)
				gargoyleCounter++;
			return gargoyleCounter;
		}
		
		public function maxPrestigeJobs():Number
		{
			var prestigeJobs:Number = 1;
			if (findPerk(PerkLib.PrestigeJobArcaneArcher) >= 0)
				prestigeJobs--;
			if (findPerk(PerkLib.PrestigeJobBerserker) >= 0)
				prestigeJobs--;
			if (findPerk(PerkLib.PrestigeJobSeer) >= 0)
				prestigeJobs--;
			if (findPerk(PerkLib.PrestigeJobSoulArcher) >= 0)
				prestigeJobs--;
			if (findPerk(PerkLib.JobMunchkin) >= 0)
				prestigeJobs++;
		//	if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		prestigeJobs++;
		//	if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		prestigeJobs++;
			return prestigeJobs;
		}
		
		public function lactationQ():Number
		{
			if (biggestLactation() < 1)
				return 0;
			//(Milk production TOTAL= breastSize x 10 * lactationMultiplier * breast total * milking-endurance (1- default, maxes at 2.  Builds over time as milking as done)
			//(Small – 0.01 mLs – Size 1 + 1 Multi)
			//(Large – 0.8 - Size 10 + 4 Multi)
			//(HUGE – 2.4 - Size 12 + 5 Multi + 4 tits)
			var total:Number;
			if (findStatusAffect(StatusAffects.LactationEndurance) < 0)
				createStatusAffect(StatusAffects.LactationEndurance, 1, 0, 0, 0);
			total = biggestTitSize() * 10 * averageLactation() * statusAffectv1(StatusAffects.LactationEndurance) * totalBreasts();
			if (findPerk(PerkLib.MilkMaid) >= 0)
				total += 200 + (perkv1(PerkLib.MilkMaid) * 100);
			if (statusAffectv1(StatusAffects.LactationReduction) >= 48)
				total = total * 1.5;
			if (total > int.MAX_VALUE)
				total = int.MAX_VALUE;
			return total;
		}
		
		public function isLactating():Boolean
		{
			if (lactationQ() > 0) return true;
			return false;
		}

		public function cuntChange(cArea:Number, display:Boolean, spacingsF:Boolean = false, spacingsB:Boolean = true):Boolean {
			if (vaginas.length==0) return false;
			var wasVirgin:Boolean = vaginas[0].virgin;
			var stretched:Boolean = cuntChangeNoDisplay(cArea);
			var devirgined:Boolean = wasVirgin && !vaginas[0].virgin;
			if (devirgined){
				if(spacingsF) outputText("  ");
				outputText("<b>Your hymen is torn, robbing you of your virginity.</b>", false);
				if(spacingsB) outputText("  ");
			}
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(display && stretched) {
				//Virgins get different formatting
				if(devirgined) {
					//If no spaces after virgin loss
					if(!spacingsB) outputText("  ");
				}
				//Non virgins as usual
				else if(spacingsF) outputText("  ");
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LEVEL_CLOWN_CAR) outputText("<b>Your " + Appearance.vaginaDescript(this,0)+ " is stretched painfully wide, large enough to accommodate most beasts and demons.</b>");
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched so wide that it gapes continually.</b>");
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " painfully stretches, the lips now wide enough to gape slightly.</b>");
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LOOSE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now very loose.</b>", false);
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_NORMAL) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now a little loose.</b>", false);
				if(vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_TIGHT) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched out to a more normal size.</b>");
				if(spacingsB) outputText("  ");
			}
			return stretched;
		}

		public function buttChange(cArea:Number, display:Boolean, spacingsF:Boolean = true, spacingsB:Boolean = true):Boolean
		{
			var stretched:Boolean = buttChangeNoDisplay(cArea);
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if(stretched && display) {
				if (spacingsF) outputText("  ");
				buttChangeDisplay();
				if (spacingsB) outputText("  ");
			}
			return stretched;
		}

		/**
		 * Refills player's hunger. 'amnt' is how much to refill, 'nl' determines if new line should be added before the notification.
		 * @param	amnt
		 * @param	nl
		 */
		public function refillHunger(amnt:Number = 0, nl:Boolean = true):void {
			if (flags[kFLAGS.HUNGER_ENABLED] > 0 || flags[kFLAGS.IN_PRISON] > 0)
			{
				
				var oldHunger:Number = hunger;
				var weightChange:int = 0;
				
				hunger += amnt;
				if (hunger > maxHunger())
				{
					while (hunger > (maxHunger() + 10) && !game.prison.inPrison) {
						weightChange++;
						hunger -= 10;
					}
					modThickness(100, weightChange);
					hunger = maxHunger();
				}
				if (hunger > oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) kGAMECLASS.mainView.statsView.showStatUp('hunger');
				//game.dynStats("lus", 0, "resisted", false);
				if (nl) outputText("\n");
				//Messages
				if (hunger < 10) outputText("<b>You still need to eat more. </b>");
				else if (hunger >= 10 && hunger < 25) outputText("<b>You are no longer starving but you still need to eat more. </b>");
				else if (hunger >= 25 && hunger < 50) outputText("<b>The growling sound in your stomach seems to quiet down. </b>");
				else if (hunger >= 50 && hunger < 75) outputText("<b>Your stomach no longer growls. </b>");
				else if (hunger >= 75 && hunger < 90) outputText("<b>You feel so satisfied. </b>");
				else if (hunger >= 90) outputText("<b>Your stomach feels so full. </b>");
				if (weightChange > 0) outputText("<b>You feel like you've put on some weight. </b>");
				kGAMECLASS.awardAchievement("Tastes Like Chicken ", kACHIEVEMENTS.REALISTIC_TASTES_LIKE_CHICKEN);
				if (oldHunger < 1 && hunger >= 100) kGAMECLASS.awardAchievement("Champion Needs Food Badly ", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD);
				if (oldHunger >= 90) kGAMECLASS.awardAchievement("Glutton ", kACHIEVEMENTS.REALISTIC_GLUTTON);
				if (hunger > oldHunger) kGAMECLASS.mainView.statsView.showStatUp("hunger");
				game.dynStats("lus", 0, "resisted", false);
				kGAMECLASS.statScreenRefresh();
			}
		}
		
		/**
		 * Damages player's hunger. 'amnt' is how much to deduct.
		 * @param	amnt
		 */
		public function damageHunger(amnt:Number = 0):void {
			var oldHunger:Number = hunger;
			hunger -= amnt;
			if (hunger < 0) hunger = 0;
			if (hunger < oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) kGAMECLASS.mainView.statsView.showStatDown('hunger');
			game.dynStats("lus", 0, "resisted", false);
		}
		
		public function corruptionTolerance():int {
			var temp:int = perkv1(PerkLib.AscensionTolerance) * 5;
			if (flags[kFLAGS.MEANINGLESS_CORRUPTION] > 0) temp += 100;
			return temp;
		}
		
		public function newGamePlusMod():int {
			var temp:int = flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			//Constrains value between 0 and 4.
			if (temp < 0) temp = 0;
			if (temp > 4) temp = 4;
			return temp;
		}
		
		public function buttChangeDisplay():void
		{	//Allows the test for stretching and the text output to be separated
			if (ass.analLooseness == 5) outputText("<b>Your " + Appearance.assholeDescript(this) + " is stretched even wider, capable of taking even the largest of demons and beasts.</b>");
			if (ass.analLooseness == 4) outputText("<b>Your " + Appearance.assholeDescript(this) + " becomes so stretched that it gapes continually.</b>", false);
			if (ass.analLooseness == 3) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now very loose.</b>");
			if (ass.analLooseness == 2) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now a little loose.</b>");
			if (ass.analLooseness == 1) outputText("<b>You have lost your anal virginity.</b>", false);
		}

		public function slimeFeed():void{
			if(findStatusAffect(StatusAffects.SlimeCraving) >= 0) {
				//Reset craving value
				changeStatusValue(StatusAffects.SlimeCraving,1,0);
				//Flag to display feed update and restore stats in event parser
				if(findStatusAffect(StatusAffects.SlimeCravingFeed) < 0) {
					createStatusAffect(StatusAffects.SlimeCravingFeed,0,0,0,0);
				}
			}
			if(findPerk(PerkLib.Diapause) >= 0) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228] += 3 + rand(3);
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] = 1;
			}

		}

		public function minoCumAddiction(raw:Number = 10):void {
			//Increment minotaur cum intake count
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00340]++;
			//Fix if variables go out of range.
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 0;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;

			//Turn off withdrawal
			//if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 1;
			//Reset counter
			flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] = 0;
			//If highly addicted, rises slower
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 60) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 80) raw /= 2;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 90) raw /= 2;
			if(findPerk(PerkLib.MinotaurCumResistance) >= 0 || findPerk(PerkLib.ManticoreCumAddict) >= 0) raw *= 0;
			//If in withdrawl, readdiction is potent!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) raw += 10;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) raw += 5;
			raw = Math.round(raw * 100)/100;
			//PUT SOME CAPS ON DAT' SHIT
			if(raw > 50) raw = 50;
			if(raw < -50) raw = -50;
			if(findPerk(PerkLib.ManticoreCumAddict) < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] += raw;
			//Recheck to make sure shit didn't break
			if(findPerk(PerkLib.MinotaurCumResistance) >= 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0; //Never get addicted!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;

		}

		public function hasSpells():Boolean
		{
			return spellCount()>0;
		}

		public function spellCount():Number
		{
			return [StatusAffects.KnowsArouse,StatusAffects.KnowsHeal,StatusAffects.KnowsMight,StatusAffects.KnowsCharge,StatusAffects.KnowsBlind,StatusAffects.KnowsWhitefire,StatusAffects.KnowsChargeA,StatusAffects.KnowsBlink,StatusAffects.KnowsBlizzard,StatusAffects.KnowsIceSpike,StatusAffects.KnowsFireStorm,StatusAffects.KnowsIceRain]
					.filter(function(item:StatusAffectType,index:int,array:Array):Boolean{
						return this.findStatusAffect(item)>=0;},this)
					.length;
		}

		public function armorDescript(nakedText:String = "gear"):String
		{
			var textArray:Array = [];
			var text:String = "";
			//if (armor != ArmorLib.NOTHING) text += armorName;
			//Join text.
			if (armor != ArmorLib.NOTHING) textArray.push(armor.name);
			if (upperGarment != UndergarmentLib.NOTHING) textArray.push(upperGarmentName);
			if (lowerGarment != UndergarmentLib.NOTHING) textArray.push(lowerGarmentName);
			if (textArray.length > 0) text = formatStringArray(textArray);
			//Naked?
			if (upperGarment == UndergarmentLib.NOTHING && lowerGarment == UndergarmentLib.NOTHING && armor == ArmorLib.NOTHING) text = nakedText;
			return text;
		}
		
		public function clothedOrNaked(clothedText:String, nakedText:String = ""):String
		{
			return (armorDescript() != "gear" ? clothedText : nakedText);
		}
		
		public function clothedOrNakedLower(clothedText:String, nakedText:String = ""):String
		{
			return (armorName != "gear" && (armorName != "lethicite armor" && lowerGarmentName == "nothing") && !isTaur() ? clothedText : nakedText);
		}
		
		public function addToWornClothesArray(armor:Armor):void {
			for (var i:int = 0; i < previouslyWornClothes.length; i++) {
				if (previouslyWornClothes[i] == armor.shortName) return; //Already have?
			}
			previouslyWornClothes.push(armor.shortName);
		}
		
		public function shrinkTits(ignore_hyper_happy:Boolean=false):void
		{
			if (flags[kFLAGS.HYPER_HAPPY] && !ignore_hyper_happy)
			{
				return;
			}
			if(breastRows.length == 1) {
				if(breastRows[0].breastRating > 0) {
					//Shrink if bigger than N/A cups
					var temp:Number;
					temp = 1;
					breastRows[0].breastRating--;
					//Shrink again 50% chance
					if(breastRows[0].breastRating >= 1 && rand(2) == 0 && findPerk(PerkLib.BigTits) < 0) {
						temp++;
						breastRows[0].breastRating--;
					}
					if(breastRows[0].breastRating < 0) breastRows[0].breastRating = 0;
					//Talk about shrinkage
					if(temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your breasts have shrunk!  With a quick measure, you determine they're now " + breastCup(0) + "s.", false);
					if(temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are much smaller!  With a quick measure, you determine they're now " + breastCup(0) + "s.", false);
				}
			}
			else if(breastRows.length > 1) {
				//multiple
				outputText("\n", false);
				//temp2 = amount changed
				//temp3 = counter
				var temp2:Number = 0;
				var temp3:Number = breastRows.length;
				while(temp3 > 0) {
					temp3--;
					if(breastRows[temp3].breastRating > 0) {
						breastRows[temp3].breastRating--;
						if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
						temp2++;
						outputText("\n", false);
						if(temp3 < breastRows.length - 1) outputText("...and y", false);
						else outputText("Y", false);
						outputText("our " + breastDescript(temp3) + " shrink, dropping to " + breastCup(temp3) + "s.", false);
					}
					if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
				}
				if(temp2 == 2) outputText("\nYou feel so much lighter after the change.", false);
				if(temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.", false);
				if(temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.", false);
			}
		}

		public function growTits(amount:Number, rowsGrown:Number, display:Boolean, growthType:Number):void
		{
			if(breastRows.length == 0) return;
			//GrowthType 1 = smallest grows
			//GrowthType 2 = Top Row working downward
			//GrowthType 3 = Only top row
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Chance for "big tits" perked characters to grow larger!
			if(findPerk(PerkLib.BigTits) >= 0 && rand(3) == 0 && amount < 1) amount=1;

			// Needs to be a number, since uint will round down to 0 prevent growth beyond a certain point
			var temp:Number = breastRows.length;
			if(growthType == 1) {
				//Select smallest breast, grow it, move on
				while(rowsGrown > 0) {
					//Temp = counter
					temp = breastRows.length;
					//Temp2 = smallest tits index
					temp2 = 0;
					//Find smallest row
					while(temp > 0) {
						temp--;
						if(breastRows[temp].breastRating < breastRows[temp2].breastRating) temp2 = temp;
					}
					//Temp 3 tracks total amount grown
					temp3 += amount;
					trace("Breastrow chosen for growth: " + String(temp2) + ".");
					//Reuse temp to store growth amount for diminishing returns.
					temp = amount;
					if (!flags[kFLAGS.HYPER_HAPPY])
					{
						//Diminishing returns!
						if(breastRows[temp2].breastRating > 3)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=1.5;
							else
								temp /=1.3;
						}

						// WHy are there three options here. They all have the same result.
						if(breastRows[temp2].breastRating > 7)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 9)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=2;
							else
								temp /=1.5;
						}
						if(breastRows[temp2].breastRating > 12)
						{
							if(findPerk(PerkLib.BigTits) < 0)
								temp /=2;
							else
								temp  /=1.5;
						}
					}

					//Grow!
					trace("Growing breasts by ", temp);
					breastRows[temp2].breastRating += temp;
					rowsGrown--;
				}
			}

			if (!flags[kFLAGS.HYPER_HAPPY])
			{
				//Diminishing returns!
				if(breastRows[0].breastRating > 3) {
					if(findPerk(PerkLib.BigTits) < 0) amount/=1.5;
					else amount/=1.3;
				}
				if(breastRows[0].breastRating > 7) {
					if(findPerk(PerkLib.BigTits) < 0) amount/=2;
					else amount /= 1.5;
				}
				if(breastRows[0].breastRating > 12) {
					if(findPerk(PerkLib.BigTits) < 0) amount/=2;
					else amount /= 1.5;
				}
			}
			/*if(breastRows[0].breastRating > 12) {
				if(hasPerk("Big Tits") < 0) amount/=2;
				else amount /= 1.5;
			}*/
			if(growthType == 2) {
				temp = 0;
				//Start at top and keep growing down, back to top if hit bottom before done.
				while(rowsGrown > 0) {
					if(temp+1 > breastRows.length) temp = 0;
					breastRows[temp].breastRating += amount;
					trace("Breasts increased by " + amount + " on row " + temp);
					temp++;
					temp3 += amount;
					rowsGrown--;
				}
			}
			if(growthType == 3) {
				while(rowsGrown > 0) {
					rowsGrown--;
					breastRows[0].breastRating += amount;
					temp3 += amount;
				}
			}
			//Breast Growth Finished...talk about changes.
			trace("Growth amount = ", amount);
			if(display) {
				if(growthType < 3) {
					if(amount <= 2)
					{
						if(breastRows.length > 1) outputText("Your rows of " + breastDescript(0) + " jiggle with added weight, growing a bit larger.", false);
						if(breastRows.length == 1) outputText("Your " + breastDescript(0) + " jiggle with added weight as they expand, growing a bit larger.", false);
					}
					else if(amount <= 4)
					{
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your rows of " + breastDescript(0) + " expand significantly.", false);
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.", false);
					}
					else
					{
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your " + breastDescript(0) + " tingle strongly, growing disturbingly large.", false);
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.", false);
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .5;
					}
				}
				else
				{
					if(amount <= 2) {
						if(breastRows.length > 1) outputText("Your top row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.", false);
						if(breastRows.length == 1) outputText("Your row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.", false);
					}
					if(amount > 2 && amount <= 4) {
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your top row of " + breastDescript(0) + " expand significantly.", false);
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.", false);
					}
					if(amount > 4) {
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your top row of " + breastDescript(0) + " tingle strongly, growing disturbingly large.", false);
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.", false);
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .5;
					}
				}
			}
		}

		//Determine minimum lust
		public function minLust():Number
		{
			var min:Number = 0;
			var minCap:Number = 100;
			//Bimbo body boosts minimum lust by 40
			if(findStatusAffect(StatusAffects.BimboChampagne) >= 0 || findPerk(PerkLib.BimboBody) >= 0 || findPerk(PerkLib.BroBody) >= 0 || findPerk(PerkLib.FutaForm) >= 0) {
				if(min > 40) min += 10;
				else if(min >= 20) min += 20;
				else min += 40;
			}
			//Omnibus' Gift
			if(findPerk(PerkLib.OmnibusGift) >= 0) {
				if(min > 40) min += 10;
				else if(min >= 20) min += 20;
				else min += 35;
			}
			//Nymph perk raises to 30
			if(findPerk(PerkLib.Nymphomania) >= 0) {
				if(min >= 40) min += 10;
				else if(min >= 20) min += 15;
				else min += 30;
			}
			//Oh noes anemone!
			if(findStatusAffect(StatusAffects.AnemoneArousal) >= 0) {
				if(min >= 40) min += 10;
				else if(min >= 20) min += 20;
				else min += 30;
			}
			//Hot blooded perk raises min lust!
			if(findPerk(PerkLib.HotBlooded) >= 0) {
				if(min > 0) min += perk(findPerk(PerkLib.HotBlooded)).value1 / 2;
				else min += perk(findPerk(PerkLib.HotBlooded)).value1;
			}
			if(findPerk(PerkLib.LuststickAdapted) > 0) {
				if(min < 50) min += 10;
				else min += 5;
			}
			if(findStatusAffect(StatusAffects.Infested) >= 0) {
				if(min < 50) min = 50;
			}
			//Add points for Crimstone
			min += perkv1(PerkLib.PiercedCrimstone);
			//Subtract points for Icestone!
			min -= perkv1(PerkLib.PiercedIcestone);
			min += perkv1(PerkLib.PentUp);
			//Cold blooded perk reduces min lust, to a minimum of 20! Takes effect after piercings. This effectively caps minimum lust at 80.
			if (findPerk(PerkLib.ColdBlooded) >= 0) {
				if (min >= 20) {
					if (min <= 40) min -= (min - 20);
					else min -= 20;
				}
				minCap -= 20;
			}
			//Purity Blessing perk reduce min lust, to a minimum of 10! Takes effect after piercings. This effectively caps minimum lust at 90.
			if (findPerk(PerkLib.PurityBlessing) >= 0) {
				if (min >= 10) {
					if (min <= 20) min -= (min - 10);
					else min -= 10;
				}
				minCap -= 10;
			}
			//Harpy Lipstick status forces minimum lust to be at least 50.
			if(min < 50 && findStatusAffect(StatusAffects.Luststick) >= 0) min = 50;
			//SHOULDRA BOOSTS
			//+20
			if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -168 && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75) {
				min += 20;
				if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -216)
					min += 30;
			}
			//cumOmeter
			if (tailType == TAIL_TYPE_MANTICORE_PUSSYTAIL && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25) {
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 20) min += 10;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 20 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 15) min += 20;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 15 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 10) min += 30;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 10 && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 5) min += 40;
				if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 5) min += 50;
			}
			//SPOIDAH BOOSTS
			if(eggs() >= 20) {
				min += 10;
				if(eggs() >= 40) min += 10;
			}
			//Jewelry effects
			if (jewelryEffectId == JewelryLib.MODIFIER_MINIMUM_LUST)
			{
				min += jewelryEffectMagnitude;
				if (min > (minCap - jewelryEffectMagnitude) && jewelryEffectMagnitude < 0)
				{
					minCap += jewelryEffectMagnitude;
				}
			}
			if (min < 30 && armorName == "lusty maiden's armor") min = 30;
			if (min < 20 && armorName == "tentacled bark armor") min = 20;
			//Constrain values
			if (min < 0) min = 0;
			if (min > 95) min = 95;
			if (min > minCap) min = minCap;
			return min;
		}
		
		public function getMaxStats(stats:String):int {
			var maxStr:int = 100;
			var maxTou:int = 100;
			var maxSpe:int = 100;
			var maxInt:int = 100;
			var maxWis:int = 100;
			var maxLib:int = 100;
			
			//Alter max speed if you have oversized parts. (Realistic mode)
			if (flags[kFLAGS.HUNGER_ENABLED] >= 1)
			{
				//Balls
				var tempSpeedPenalty:Number = 0;
				var lim:int = isTaur() ? 9 : 4;
				if (ballSize > lim && balls > 0) tempSpeedPenalty += Math.round((ballSize - lim) / 2);
				//Breasts
				lim = isTaur() ? BREAST_CUP_I : BREAST_CUP_G;
				if (hasBreasts() && biggestTitSize() > lim) tempSpeedPenalty += ((biggestTitSize() - lim) / 2);
				//Cocks
				lim = isTaur() ? 72 : 24;
				if (biggestCockArea() > lim) tempSpeedPenalty += ((biggestCockArea() - lim) / 6)
				//Min-cap
				var penaltyMultiplier:Number = 1;
				penaltyMultiplier -= str * 0.1;
				penaltyMultiplier -= (tallness - 72) / 168;
				if (penaltyMultiplier < 0.4) penaltyMultiplier = 0.4;
				tempSpeedPenalty *= penaltyMultiplier;
				maxSpe -= tempSpeedPenalty;
				if (maxSpe < 50) maxSpe = 50;
			}
			//Perks ahoy
			if (findPerk(PerkLib.BasiliskResistance) >= 0 && findPerk(PerkLib.GorgonsEyes) >= 0)
			{
				maxSpe -= (5 * (1 + newGamePlusMod()));
			}
			//Uma's Needlework affects max stats. Takes effect BEFORE racial modifiers and AFTER modifiers from body size.
			//Caps strength from Uma's needlework. 
			if (findPerk(PerkLib.ChiReflowSpeed) >= 0)
			{
				if (maxStr > UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP)
				{
					maxStr = UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP;
				}
			}
			//Caps speed from Uma's needlework.
			if (findPerk(PerkLib.ChiReflowDefense) >= 0)
			{
				if (maxSpe > UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP)
				{
					maxSpe = UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP;
				}
			}
			//Alter max stats depending on race (+10-20 za 4 pkt, +30-40 za 5 pkt i +50-60 za 6 pkt)
			if (minoScore() >= 4) {
				maxStr += (20 * (1 + newGamePlusMod()));
				maxTou += (10 * (1 + newGamePlusMod()));
				maxInt -= (10 * (1 + newGamePlusMod()));
			}//+20/10-20
			if (cowScore() >= 4) {
				maxStr += (15 * (1 + newGamePlusMod()));
				maxTou += (5 * (1 + newGamePlusMod()));
			}//+20/10-20
			if (lizardScore() >= 4) {
				if (lizardScore() >= 8) {
					maxTou += (70 * (1 + newGamePlusMod()));
					maxInt += (50 * (1 + newGamePlusMod()));
				}
				else {
					maxTou += (40 * (1 + newGamePlusMod()));
					maxInt += (20 * (1 + newGamePlusMod()));
				}
			}//+10/10-20
			if (dragonScore() >= 4) {
				if (dragonScore() >= 16) {
				maxStr += (80 * (1 + newGamePlusMod()));
				maxTou += (80 * (1 + newGamePlusMod()));
				maxSpe += (30 * (1 + newGamePlusMod()));
				maxInt += (50 * (1 + newGamePlusMod()));
				}
				else if (dragonScore() >= 12 && dragonScore() < 16) {
				maxStr += (60 * (1 + newGamePlusMod()));
				maxTou += (60 * (1 + newGamePlusMod()));
				maxSpe += (20 * (1 + newGamePlusMod()));
				maxInt += (40 * (1 + newGamePlusMod()));
				}
				else if (dragonScore() >= 8 && dragonScore() < 12) {
				maxStr += (50 * (1 + newGamePlusMod()));
				maxTou += (30 * (1 + newGamePlusMod()));
				maxSpe += (10 * (1 + newGamePlusMod()));
				maxInt += (30 * (1 + newGamePlusMod()));
				}
				else {
				maxStr += (30 * (1 + newGamePlusMod()));
				maxTou += (15 * (1 + newGamePlusMod()));
				maxInt += (15 * (1 + newGamePlusMod()));
				}
			}//+60/50-60
			if (dogScore() >= 4) {
				maxSpe += (15 * (1 + newGamePlusMod()));
				maxInt -= (5 * (1 + newGamePlusMod()));
			}//+10/10-20
			if (wolfScore() >= 4) {
				if (wolfScore() >= 10) {
					maxStr += (60 * (1 + newGamePlusMod()));
					maxTou += (30 * (1 + newGamePlusMod()));
					maxSpe += (60 * (1 + newGamePlusMod()));
					maxInt -= (10 * (1 + newGamePlusMod()));
				}
				else if (wolfScore() >= 7 && furColor == "glacial white") {
					maxStr += (30 * (1 + newGamePlusMod()));
					maxTou += (20 * (1 + newGamePlusMod()));
					maxSpe += (30 * (1 + newGamePlusMod()));
					maxInt -= (10 * (1 + newGamePlusMod()));
				}
				else if (wolfScore() >= 6) {
					maxStr += (30 * (1 + newGamePlusMod()));
					maxTou += (10 * (1 + newGamePlusMod()));
					maxSpe += (30 * (1 + newGamePlusMod()));
					maxInt -= (10 * (1 + newGamePlusMod()));
				}
				else {
					maxStr += (15 * (1 + newGamePlusMod()));
					maxSpe += (10 * (1 + newGamePlusMod()));
					maxInt -= (10 * (1 + newGamePlusMod()));
				}
			}//+15(60)((70))(((140)))/10-20(50-60)((70-80))(((130-140)))
			if (foxScore() >= 4) {
				if (foxScore() >= 7) {
					maxStr -= (30 * (1 + newGamePlusMod()));
					maxSpe += (80 * (1 + newGamePlusMod()));
					maxInt += (55 * (1 + newGamePlusMod()));
				}
				else {
					maxStr -= (5 * (1 + newGamePlusMod()));
					maxSpe += (40 * (1 + newGamePlusMod()));
					maxInt += (25 * (1 + newGamePlusMod()));
				}
			}//+10/10-20
			if (catScore() >= 4) {
				if (findPerk(PerkLib.Flexibility) > 0) maxSpe += (20 * (1 + newGamePlusMod()));
				else maxSpe += (10 * (1 + newGamePlusMod()));
			}//+10/10-20
			if (bunnyScore() >= 4) {
				maxSpe += (10 * (1 + newGamePlusMod()));
			}//+10/10-20
			if (raccoonScore() >= 4) {
				maxSpe += (15 * (1 + newGamePlusMod()));
			}//+15/10-20
			if (horseScore() >= 4) {
				maxSpe += (15 * (1 + newGamePlusMod()));
				maxTou += (10 * (1 + newGamePlusMod()));
				maxInt -= (10 * (1 + newGamePlusMod()));
			}//+15/10-20
			if (goblinScore() >= 4) {
				maxInt += (20 * (1 + newGamePlusMod()));
			}//+20/10-20
			if (gooScore() >= 4) {
				if (gooScore() >= 8) {
					maxTou += (80 * (1 + newGamePlusMod()));
					maxSpe -= (40 * (1 + newGamePlusMod()));
					maxLib += (80 * (1 + newGamePlusMod()));
				}
				else {
					maxTou += (40 * (1 + newGamePlusMod()));
					maxSpe -= (20 * (1 + newGamePlusMod()));
					maxLib += (40 * (1 + newGamePlusMod()));
				}
			}//+20/10-20
			if (kitsuneScore() >= 5) {
				if (kitsuneScore() >= 12 && tailType == 13 && tailCount == 9) {
					maxStr -= (40 * (1 + newGamePlusMod()));;
					maxSpe += (60 * (1 + newGamePlusMod()));;
					maxInt += (100 * (1 + newGamePlusMod()));;
					maxLib += (40 * (1 + newGamePlusMod()));;
				}
				else {
					maxStr -= (40 * (1 + newGamePlusMod()));
					maxSpe += (20 * (1 + newGamePlusMod()));
					maxInt += (50 * (1 + newGamePlusMod()));
					maxLib += (40 * (1 + newGamePlusMod()));
				}
			}//+50/50-60
		/*	if (kitshooScore() >= 6) {
				if (tailType == 26) {
					if (tailCount == 1) {
						maxStr -= (2 * (1 + newGamePlusMod()));
						maxSpe += (2 * (1 + newGamePlusMod()));
						maxInt += (4 * (1 + newGamePlusMod()));
					}
					else if (tailCount >= 2 && tailCount < 9) {
						maxStr -= ((tailCount + 1) * (1 + newGamePlusMod()));
						maxSpe += ((tailCount + 1) * (1 + newGamePlusMod()));
						maxInt += (((tailCount/2) + 2) * (1 + newGamePlusMod()));
					}
					else if (tailCount >= 9) {
						maxStr -= (10 * (1 + newGamePlusMod()));;
						maxSpe += (10 * (1 + newGamePlusMod()));;
						maxInt += (20 * (1 + newGamePlusMod()));;
					}
				}
			}
		*/	if (beeScore() >= 5) {
				if (beeScore() >= 9) {
					maxTou += (50 * (1 + newGamePlusMod()));
					maxSpe += (50 * (1 + newGamePlusMod()));
					maxInt += (35 * (1 + newGamePlusMod()));
				}
				else {
					maxTou += (30 * (1 + newGamePlusMod()));
					maxSpe += (30 * (1 + newGamePlusMod()));
					maxInt += (15 * (1 + newGamePlusMod()));
				}
			}//+40/30-40
			if (spiderScore() >= 4) {
				if (spiderScore() >= 7) {
					maxStr -= (20 * (1 + newGamePlusMod()));
					maxTou += (50 * (1 + newGamePlusMod()));
					maxInt += (75 * (1 + newGamePlusMod()));
				}
				else {
					maxStr -= (10 * (1 + newGamePlusMod()));
					maxTou += (30 * (1 + newGamePlusMod()));
					maxInt += (40 * (1 + newGamePlusMod()));
				}
			}//+10/10-20
			if (kangaScore() >= 4) {
				maxTou += (5 * (1 + newGamePlusMod()));
				maxSpe += (15 * (1 + newGamePlusMod()));
			}//+20/10-20
			if (sharkScore() >= 4) {
				if (sharkScore() >= 9 && vaginas.length > 0 && cocks.length > 0) {
					maxStr += (60 * (1 + newGamePlusMod()));
					maxSpe += (70 * (1 + newGamePlusMod()));
					maxLib += (20 * (1 + newGamePlusMod()));
				}
				else if (sharkScore() >= 8) {
					maxStr += (40 * (1 + newGamePlusMod()));
					maxSpe += (70 * (1 + newGamePlusMod()));
					maxLib += (10 * (1 + newGamePlusMod()));
				}
				else {
					maxStr += (20 * (1 + newGamePlusMod()));
					maxSpe += (40 * (1 + newGamePlusMod()));
				}
			}//+10/10-20
			if (harpyScore() >= 4) {
				if (harpyScore() >= 8) {
					maxTou -= (20 * (1 + newGamePlusMod()));
					maxSpe += (80 * (1 + newGamePlusMod()));
					maxLib += (60 * (1 + newGamePlusMod()));
				}
				else {
					maxTou -= (10 * (1 + newGamePlusMod()));
					maxSpe += (40 * (1 + newGamePlusMod()));
					maxLib += (30 * (1 + newGamePlusMod()));
				}
			}//+10/10-20
			if (sirenScore() >= 10) {
				maxStr += (40 * (1 + newGamePlusMod()));
				maxSpe += (70 * (1 + newGamePlusMod()));
				maxInt += (40 * (1 + newGamePlusMod()));
			}//+20/10-20
			if (orcaScore() >= 6) {
				if (orcaScore() >= 12) {
					maxStr += (70 * (1 + newGamePlusMod()));
					maxTou += (40 * (1 + newGamePlusMod()));
					maxSpe += (70 * (1 + newGamePlusMod()));
				}
				else {
					maxStr += (35 * (1 + newGamePlusMod()));
					maxTou += (20 * (1 + newGamePlusMod()));
					maxSpe += (35 * (1 + newGamePlusMod()));
				}
			}//+10/10-20
			if (demonScore() >= 5) {
				if (demonScore() >= 11) {
					maxSpe += (30 * (1 + newGamePlusMod()));
					maxInt += (35 * (1 + newGamePlusMod()));
					maxLib += (100 * (1 + newGamePlusMod()));
				}
				else {
					maxSpe += (15 * (1 + newGamePlusMod()));
					maxInt += (15 * (1 + newGamePlusMod()));
					maxLib += (45 * (1 + newGamePlusMod()));
				}
			}//+60/50-60
			if (rhinoScore() >= 4) {
				maxStr += (15 * (1 + newGamePlusMod()));
				maxTou += (15 * (1 + newGamePlusMod()));
				maxSpe -= (10 * (1 + newGamePlusMod()));
				maxInt -= (10 * (1 + newGamePlusMod()));
			}//+10/10-20
			if (satyrScore() >= 4) {
				maxStr += (5 * (1 + newGamePlusMod()));
				maxSpe += (5 * (1 + newGamePlusMod()));
			}//+10/10-20
			if (manticoreScore() >= 5) {
				if (manticoreScore() >= 10) {
					maxSpe += (80 * (1 + newGamePlusMod()));
					maxInt += (20 * (1 + newGamePlusMod()));
					maxLib += (50 * (1 + newGamePlusMod()));
				}
				else {
					maxSpe += (40 * (1 + newGamePlusMod()));
					maxInt += (10 * (1 + newGamePlusMod()));
					maxLib += (25 * (1 + newGamePlusMod()));
				}
			}//+60/50-60
			if (mantisScore() >= 5) {
				maxStr -= (25 * (1 + newGamePlusMod()));
				maxSpe += (50 * (1 + newGamePlusMod()));
				maxInt += (10 * (1 + newGamePlusMod()));
			}//+35/30-40
			if (salamanderScore() >= 4) {
				if (salamanderScore() >= 7) {
					maxStr += (25 * (1 + newGamePlusMod()));
					maxTou += (25 * (1 + newGamePlusMod()));
					maxLib += (40 * (1 + newGamePlusMod()));
				}
				else {
					maxStr += (15 * (1 + newGamePlusMod()));
					maxTou += (15 * (1 + newGamePlusMod()));
					maxLib += (30 * (1 + newGamePlusMod()));
				}
			}//+15/10-20
			if (unicornScore() >= 5) {
				maxSpe += (5 * (1 + newGamePlusMod()));
				maxInt += (10 * (1 + newGamePlusMod()));
			}//+(15)30/(10-20)30-40
			if (alicornScore() >= 6) {
				maxSpe += (5 * (1 + newGamePlusMod()));
				maxInt += (20 * (1 + newGamePlusMod()));
			}//+(30)55/(30-40)50-60
			if (phoenixScore() >= 10) {
				maxStr += (20 * (1 + newGamePlusMod()));
				maxTou += (20 * (1 + newGamePlusMod()));
				maxSpe += (70 * (1 + newGamePlusMod()));
				maxLib += (40 * (1 + newGamePlusMod()));
			}//+30/30-40
			if (scyllaScore() >= 5) {
				maxStr += (20 * (1 + newGamePlusMod()));
				maxInt += (10 * (1 + newGamePlusMod()));
			}//+30/30-40
			if (plantScore() >= 4) {
				if (plantScore() >= 7) {
					maxStr += (25 * (1 + newGamePlusMod()));
					maxTou += (100 * (1 + newGamePlusMod()));
					maxSpe -= (50 * (1 + newGamePlusMod()));
				}
				else if (plantScore() == 6) {
					maxStr += (20 * (1 + newGamePlusMod()));
					maxTou += (80 * (1 + newGamePlusMod()));
					maxSpe -= (40 * (1 + newGamePlusMod()));
				}
				else if (plantScore() == 5) {
					maxStr += (10 * (1 + newGamePlusMod()));
					maxTou += (50 * (1 + newGamePlusMod()));
					maxSpe -= (20 * (1 + newGamePlusMod()));
				}
				else {
					maxTou += (30 * (1 + newGamePlusMod()));
					maxSpe -= (10 * (1 + newGamePlusMod()));
				}
			}//+20(40)(60)(75)/10-20(30-40)(50-60)(70-80)
			if (yggdrasilScore() >= 10) {
				maxTou += (30 * (1 + newGamePlusMod()));
				maxSpe -= (10 * (1 + newGamePlusMod()));
				maxInt += (30 * (1 + newGamePlusMod()));
				maxLib -= (10 * (1 + newGamePlusMod()));
			}
			if (deerScore() >= 4) {
				maxSpe += (20 * (1 + newGamePlusMod()));
			}//+20/10-20
			if (yetiScore() >= 6) {
				if (yetiScore() >= 12) {
					maxStr += (60 * (1 + newGamePlusMod()));
					maxTou += (80 * (1 + newGamePlusMod()));
					maxSpe += (50 * (1 + newGamePlusMod()));
					maxInt -= (60 * (1 + newGamePlusMod()));
					maxLib += (50 * (1 + newGamePlusMod()));
				}
				else {
					maxStr += (30 * (1 + newGamePlusMod()));
					maxTou += (40 * (1 + newGamePlusMod()));
					maxSpe += (25 * (1 + newGamePlusMod()));
					maxInt -= (30 * (1 + newGamePlusMod()));
					maxLib += (25 * (1 + newGamePlusMod()));
				}
			}
			if (couatlScore() >= 11) {
				maxStr += (40 * (1 + newGamePlusMod()));
				maxTou += (25 * (1 + newGamePlusMod()));
				maxSpe += (100 * (1 + newGamePlusMod()));
			}//+30/30-40
			if (vouivreScore() >= 11) {
				maxStr += (10 * (1 + newGamePlusMod()));
				maxSpe += (35 * (1 + newGamePlusMod()));
			}//+30/30-40
			if (gorgonScore() >= 11) {
				maxStr += (50 * (1 + newGamePlusMod()));
				maxTou += (45 * (1 + newGamePlusMod()));
				maxSpe += (70 * (1 + newGamePlusMod()));
			}//+30/30-40
			if (nagaScore() >= 4)
			{
				if (nagaScore() >= 8) {
					maxStr += (40 * (1 + newGamePlusMod()));
					maxTou += (20 * (1 + newGamePlusMod()));
					maxSpe += (60 * (1 + newGamePlusMod()));
				}
				else {
					maxStr += (20 * (1 + newGamePlusMod()));
					maxSpe += (40 * (1 + newGamePlusMod()));
				}
			}
			if (centaurScore() >= 5) {
				maxTou += (10 * (1 + newGamePlusMod()));
				maxSpe += (30 * (1 + newGamePlusMod()));
			}//+40/30-40
			if (isNaga()) {
				maxStr += (15 * (1 + newGamePlusMod()));
				maxSpe += (15 * (1 + newGamePlusMod()));
			}
			if (isTaur()) {
				maxSpe += (20 * (1 + newGamePlusMod()));
			}
			if (isDrider()) {
				maxTou += (15 * (1 + newGamePlusMod()));
				maxSpe += (15 * (1 + newGamePlusMod()));
			}
			if (isScylla()) {
				maxStr += (30 * (1 + newGamePlusMod()));
			}
			if (gargoyleScore() >= 6) {
				if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) {
					maxStr += (80 * (1 + newGamePlusMod()));
					maxTou += (80 * (1 + newGamePlusMod()));
				}
				if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) {
					maxTou += (80 * (1 + newGamePlusMod()));
					maxInt += (80 * (1 + newGamePlusMod()));
				}
			}
			if (findPerk(PerkLib.SalamanderAdrenalGlands) > 0) {
				maxTou += (5 * (1 + newGamePlusMod()));
				maxLib += (5 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.ScyllaInkGlands) > 0) {
				maxStr += (10 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.MantislikeAgility) > 0) {
				if (skinType == SKIN_TYPE_CHITIN && findPerk(PerkLib.ThickSkin) >= 0) maxSpe += (20 * (1 + newGamePlusMod()));
				if (skinType == SKIN_TYPE_SCALES && findPerk(PerkLib.ThickSkin) >= 0) maxSpe += (15 * (1 + newGamePlusMod()));
				if (skinType == SKIN_TYPE_CHITIN) maxSpe += (15 * (1 + newGamePlusMod()));
				if (skinType == SKIN_TYPE_SCALES) maxSpe += (10 * (1 + newGamePlusMod()));
				if (findPerk(PerkLib.ThickSkin) >= 0) maxSpe += (5 * (1 + newGamePlusMod()));
			}
			if (humanScore() == 25) {
				maxStr += (60 * (1 + newGamePlusMod()));
				maxTou += (60 * (1 + newGamePlusMod()));
				maxSpe += (60 * (1 + newGamePlusMod()));
				maxInt += (65 * (1 + newGamePlusMod()));
				maxWis += (65 * (1 + newGamePlusMod()));
				maxLib += (65 * (1 + newGamePlusMod()));
			}
			if (humanScore() == 24) {
				maxStr += (50 * (1 + newGamePlusMod()));
				maxTou += (50 * (1 + newGamePlusMod()));
				maxSpe += (50 * (1 + newGamePlusMod()));
				maxInt += (55 * (1 + newGamePlusMod()));
				maxWis += (55 * (1 + newGamePlusMod()));
				maxLib += (55 * (1 + newGamePlusMod()));
			}
			if (humanScore() == 23) {
				maxStr += (40 * (1 + newGamePlusMod()));
				maxTou += (40 * (1 + newGamePlusMod()));
				maxSpe += (40 * (1 + newGamePlusMod()));
				maxInt += (45 * (1 + newGamePlusMod()));
				maxWis += (45 * (1 + newGamePlusMod()));
				maxLib += (45 * (1 + newGamePlusMod()));
			}
			if (humanScore() == 22) {
				maxStr += (30 * (1 + newGamePlusMod()));
				maxTou += (30 * (1 + newGamePlusMod()));
				maxSpe += (30 * (1 + newGamePlusMod()));
				maxInt += (35 * (1 + newGamePlusMod()));
				maxWis += (35 * (1 + newGamePlusMod()));
				maxLib += (35 * (1 + newGamePlusMod()));
			}
			if (humanScore() == 21) {
				maxStr += (20 * (1 + newGamePlusMod()));
				maxTou += (20 * (1 + newGamePlusMod()));
				maxSpe += (20 * (1 + newGamePlusMod()));
				maxInt += (25 * (1 + newGamePlusMod()));
				maxWis += (25 * (1 + newGamePlusMod()));
				maxLib += (25 * (1 + newGamePlusMod()));
			}
			if (humanScore() == 20) {
				maxStr += (10 * (1 + newGamePlusMod()));
				maxTou += (10 * (1 + newGamePlusMod()));
				maxSpe += (10 * (1 + newGamePlusMod()));
				maxInt += (15 * (1 + newGamePlusMod()));
				maxWis += (15 * (1 + newGamePlusMod()));
				maxLib += (15 * (1 + newGamePlusMod()));
			}
			if (humanScore() == 19) {
		//		maxStr += (0 * (1 + newGamePlusMod()));
		//		maxTou += (0 * (1 + newGamePlusMod()));
		//		maxSpe += (0 * (1 + newGamePlusMod()));
				maxInt += (5 * (1 + newGamePlusMod()));
				maxWis += (5 * (1 + newGamePlusMod()));
				maxLib += (5 * (1 + newGamePlusMod()));
			}
		/*	if (humanScore() == 18) {
				maxStr += (0 * (1 + newGamePlusMod()));
				maxTou += (0 * (1 + newGamePlusMod()));
				maxSpe += (0 * (1 + newGamePlusMod()));
				maxInt += (5 * (1 + newGamePlusMod()));
				maxWis += (5 * (1 + newGamePlusMod()));
				maxLib += (5 * (1 + newGamePlusMod()));
			}
		*/	if (internalChimeraScore() >= 1) {
				maxStr += (5 * internalChimeraScore() * (1 + newGamePlusMod()));
				maxTou += (5 * internalChimeraScore() * (1 + newGamePlusMod()));
				maxSpe += (5 * internalChimeraScore() * (1 + newGamePlusMod()));
				maxInt += (5 * internalChimeraScore() * (1 + newGamePlusMod()));
				maxWis += (5 * internalChimeraScore() * (1 + newGamePlusMod()));
				maxLib += (5 * internalChimeraScore() * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.ChimericalBodyInitialStage) > 0) {
				maxTou += (5 * (1 + newGamePlusMod()));
				maxLib += (5 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.ChimericalBodyBasicStage) > 0) {
				maxStr += (5 * (1 + newGamePlusMod()));
				maxSpe += (5 * (1 + newGamePlusMod()));
				maxInt += (5 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.ChimericalBodyAdvancedStage) > 0) {
				maxStr += (5 * (1 + newGamePlusMod()));
				maxSpe += (5 * (1 + newGamePlusMod()));
				maxInt += (5 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.ChimericalBodyPerfectStage) > 0) {
				maxStr += (5 * (1 + newGamePlusMod()));
				maxSpe += (5 * (1 + newGamePlusMod()));
				maxInt += (5 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) > 0) {
				maxStr += (5 * (1 + newGamePlusMod()));
				maxSpe += (5 * (1 + newGamePlusMod()));
				maxInt += (5 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.EzekielBlessing) > 0) {
				maxStr += (5 * (1 + newGamePlusMod()));
				maxTou += (5 * (1 + newGamePlusMod()));
				maxSpe += (5 * (1 + newGamePlusMod()));
				maxInt += (5 * (1 + newGamePlusMod()));
				maxWis += (5 * (1 + newGamePlusMod()));
				maxLib += (5 * (1 + newGamePlusMod()));
			}
			//Perks
			if (findPerk(PerkLib.JobAllRounder) >= 0) {
				maxStr += (10 * (1 + newGamePlusMod()));
				maxTou += (10 * (1 + newGamePlusMod()));
				maxSpe += (10 * (1 + newGamePlusMod()));
				maxInt += (10 * (1 + newGamePlusMod()));
				maxWis += (10 * (1 + newGamePlusMod()));
				maxLib += (6 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.JobHunter) >= 0) {
				maxSpe += (10 * (1 + newGamePlusMod()));
				maxInt += (5 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.JobBarbarian) >= 0) maxStr += (10 * (1 + newGamePlusMod()));
			if (findPerk(PerkLib.JobBrawler) >= 0) maxStr += (10 * (1 + newGamePlusMod()));
			if (findPerk(PerkLib.JobDervish) >= 0) maxSpe += (10 * (1 + newGamePlusMod()));
			if (findPerk(PerkLib.JobDefender) >= 0) maxTou += (15 * (1 + newGamePlusMod()));
			if (findPerk(PerkLib.JobEnchanter) >= 0) maxInt += (15 * (1 + newGamePlusMod()));
			if (findPerk(PerkLib.JobEromancer) >= 0) {
				maxInt += (5 * (1 + newGamePlusMod()));
				maxLib += (5 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.JobGuardian) >= 0) maxTou += (5 * (1 + newGamePlusMod()));
			if (findPerk(PerkLib.JobKnight) >= 0) maxTou += (10 * (1 + newGamePlusMod()));
			if (findPerk(PerkLib.JobMunchkin) >= 0) {
				maxStr += (25 * (1 + newGamePlusMod()));
				maxTou += (25 * (1 + newGamePlusMod()));
				maxSpe += (25 * (1 + newGamePlusMod()));
				maxInt += (25 * (1 + newGamePlusMod()));
				maxWis += (25 * (1 + newGamePlusMod()));
				maxLib += (15 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.JobRanger) >= 0) maxSpe += (5 * (1 + newGamePlusMod()));
			if (findPerk(PerkLib.JobSeducer) >= 0) maxLib += (5 * (1 + newGamePlusMod()));
			if (findPerk(PerkLib.JobSorcerer) >= 0) maxInt += (5 * (1 + newGamePlusMod()));
			if (findPerk(PerkLib.JobSoulCultivator) >= 0) maxWis += (5 * (1 + newGamePlusMod()));
			if (findPerk(PerkLib.JobWarrior) >= 0) maxStr += (5 * (1 + newGamePlusMod()));
			if (findPerk(PerkLib.PrestigeJobArcaneArcher) >= 0) {
				maxSpe += (40 * (1 + newGamePlusMod()));
				maxInt += (40 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.PrestigeJobBerserker) >= 0) {
				maxStr += (60 * (1 + newGamePlusMod()));
				maxTou += (20 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.PrestigeJobSeer) >= 0) {
				maxInt += (60 * (1 + newGamePlusMod()));
				maxWis += (20 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.PrestigeJobSoulArcher) >= 0) {
				maxSpe += (40 * (1 + newGamePlusMod()));
				maxWis += (40 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.WeaponMastery) >= 0) maxStr += (5 * (1 + newGamePlusMod()));
			if (findPerk(PerkLib.WeaponGrandMastery) >= 0) maxStr += (10 * (1 + newGamePlusMod()));
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) {
				maxStr += (10 * (1 + newGamePlusMod()));
				maxTou += (10 * (1 + newGamePlusMod()));
				maxSpe += (10 * (1 + newGamePlusMod()));
				maxInt += (10 * (1 + newGamePlusMod()));
				maxWis += (10 * (1 + newGamePlusMod()));
				maxLib += (10 * (1 + newGamePlusMod()));
			}
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) {
				maxStr += (15 * (1 + newGamePlusMod()));
				maxTou += (15 * (1 + newGamePlusMod()));
				maxSpe += (15 * (1 + newGamePlusMod()));
				maxInt += (15 * (1 + newGamePlusMod()));
				maxWis += (15 * (1 + newGamePlusMod()));
				maxLib += (15 * (1 + newGamePlusMod()));
			}
	/*		if (findPerk(PerkLib.SoulPersonage) >= 0) {
				maxStr += 5;
				maxTou += 5;
				maxSpe += 5;
				maxInt += 5;
				maxLib += 3;
			}
			if (findPerk(PerkLib.SoulWarrior) >= 0) {
				maxStr += 5;
				maxTou += 5;
				maxSpe += 5;
				maxInt += 5;
				maxLib += 3;
			}
			if (findPerk(PerkLib.SoulSprite) >= 0) {
				maxStr += 5;
				maxTou += 5;
				maxSpe += 5;
				maxInt += 5;
				maxLib += 3;
			}
			if (findPerk(PerkLib.SoulExalt) >= 0) {
				maxStr += 5;
				maxTou += 5;
				maxSpe += 5;
				maxInt += 5;
				maxLib += 3;
			}
			if (findPerk(PerkLib.SoulOverlord) >= 0) {
				maxStr += 5;
				maxTou += 5;
				maxSpe += 5;
				maxInt += 5;
				maxLib += 3;
			}
			if (findPerk(PerkLib.SoulTyrant) >= 0) {
				maxStr += 5;
				maxTou += 5;
				maxSpe += 5;
				maxInt += 5;
				maxLib += 3;
			}
			if (findPerk(PerkLib.SoulKing) >= 0) {
				maxStr += 5;
				maxTou += 5;
				maxSpe += 5;
				maxInt += 5;
				maxLib += 3;
			}
			if (findPerk(PerkLib.SoulEmperor) >= 0) {
				maxStr += 5;
				maxTou += 5;
				maxSpe += 5;
				maxInt += 5;
				maxLib += 3;
			}
	*/		if (findPerk(PerkLib.CarefulButRecklessAimAndShooting) >= 0 && findPerk(PerkLib.ColdAim) < 0) maxTou -= (15 * (1 + newGamePlusMod()));
			//Apply New Game+
			maxStr += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxTou += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxSpe += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxInt += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxWis += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxLib += 5 * perkv1(PerkLib.AscensionTranshumanism);
			//Might
			if (findStatusAffect(StatusAffects.Might) >= 0) {
				maxStr += statusAffectv1(StatusAffects.Might);
				maxTou += statusAffectv2(StatusAffects.Might);
			}
			//Blink
			if (findStatusAffect(StatusAffects.Blink) >= 0) {
				maxSpe += statusAffectv1(StatusAffects.Blink);
			}
			if (findStatusAffect(StatusAffects.AndysSmoke) >= 0) {
				maxSpe -= statusAffectv2(StatusAffects.AndysSmoke);
				maxInt += statusAffectv3(StatusAffects.AndysSmoke);
			}
			if (findStatusAffect(StatusAffects.FeedingEuphoria) >= 0) {
				maxSpe += statusAffectv2(StatusAffects.FeedingEuphoria);
			}
			if (findStatusAffect(StatusAffects.UnderwaterCombatBoost) >= 0) {
				maxStr += statusAffectv1(StatusAffects.UnderwaterCombatBoost);
				maxSpe += statusAffectv2(StatusAffects.UnderwaterCombatBoost);
			}
			if (stats == "str" || stats == "strength") return maxStr;
			else if (stats == "tou" || stats == "toughness") return maxTou;
			else if (stats == "spe" || stats == "speed") return maxSpe;
			else if (stats == "inte" || stats == "int" || stats == "intelligence") return maxInt;
			else if (stats == "wis" || stats == "wisdom") return maxWis;
			else if (stats == "lib" || stats == "libido") return maxLib;
			else return 100;
		}
		
		public function requiredXP():int {
			var temp:int = level * 100;
			if (temp > 15000) temp = 15000;
			return temp;
		}
		
		public function minotaurAddicted():Boolean {
			return findPerk(PerkLib.MinotaurCumResistance) < 0 && findPerk(PerkLib.ManticoreCumAddict) < 0 && (findPerk(PerkLib.MinotaurCumAddict) >= 0 || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1);
		}
		public function minotaurNeed():Boolean {
			return findPerk(PerkLib.MinotaurCumResistance) < 0 && findPerk(PerkLib.ManticoreCumAddict) < 0 && flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1;
		}

		public function clearStatuses(visibility:Boolean):void
		{
			if (findStatusAffect(StatusAffects.DriderIncubusVenom) >= 0)
			{
				str += statusAffectv2(StatusAffects.DriderIncubusVenom);
				removeStatusAffect(StatusAffects.DriderIncubusVenom);
				kGAMECLASS.mainView.statsView.showStatUp('str');
			}
			while(findStatusAffect(StatusAffects.Web) >= 0) {
				spe += statusAffectv1(StatusAffects.Web);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusAffect(StatusAffects.Web);
			}
			if(findStatusAffect(StatusAffects.Shielding) >= 0) removeStatusAffect(StatusAffects.Shielding);
			if(findStatusAffect(StatusAffects.HolliConstrict) >= 0) removeStatusAffect(StatusAffects.HolliConstrict);
			if(findStatusAffect(StatusAffects.LustStones) >= 0) removeStatusAffect(StatusAffects.LustStones);
			if(kGAMECLASS.monster.findStatusAffect(StatusAffects.Sandstorm) >= 0) kGAMECLASS.monster.removeStatusAffect(StatusAffects.Sandstorm);
			if(findStatusAffect(StatusAffects.Sealed) >= 0) {
				removeStatusAffect(StatusAffects.Sealed);
			}
			if(findStatusAffect(StatusAffects.Berzerking) >= 0) {
				removeStatusAffect(StatusAffects.Berzerking);
			}
			if(findStatusAffect(StatusAffects.Lustzerking) >= 0) {
				removeStatusAffect(StatusAffects.Lustzerking);
			}
			if(kGAMECLASS.monster.findStatusAffect(StatusAffects.TailWhip) >= 0) {
				kGAMECLASS.monster.removeStatusAffect(StatusAffects.TailWhip);
			}
			if(findStatusAffect(StatusAffects.UBERWEB) >= 0) removeStatusAffect(StatusAffects.UBERWEB);
			if(findStatusAffect(StatusAffects.DriderKiss) >= 0) removeStatusAffect(StatusAffects.DriderKiss);
			if(findStatusAffect(StatusAffects.WebSilence) >= 0) removeStatusAffect(StatusAffects.WebSilence);
			if(findStatusAffect(StatusAffects.GooArmorSilence) >= 0) removeStatusAffect(StatusAffects.GooArmorSilence);
			if(findStatusAffect(StatusAffects.Bound) >= 0) removeStatusAffect(StatusAffects.Bound);
			if(findStatusAffect(StatusAffects.GooArmorBind) >= 0) removeStatusAffect(StatusAffects.GooArmorBind);
			if(findStatusAffect(StatusAffects.WolfHold) >= 0) removeStatusAffect(StatusAffects.WolfHold);
			if(findStatusAffect(StatusAffects.Whispered) >= 0) removeStatusAffect(StatusAffects.Whispered);
			if(findStatusAffect(StatusAffects.AkbalSpeed) >= 0) {
				kGAMECLASS.dynStats("spe", statusAffectv1(StatusAffects.AkbalSpeed) * -1);
				removeStatusAffect(StatusAffects.AkbalSpeed);
			}
			if(findStatusAffect(StatusAffects.AmilyVenom) >= 0) {
				kGAMECLASS.dynStats("str", statusAffectv1(StatusAffects.AmilyVenom),"spe", statusAffectv2(StatusAffects.AmilyVenom));
				removeStatusAffect(StatusAffects.AmilyVenom);
			}
			while(findStatusAffect(StatusAffects.Blind) >= 0) {
				removeStatusAffect(StatusAffects.Blind);
			}
			if(findStatusAffect(StatusAffects.SheilaOil) >= 0) {
				removeStatusAffect(StatusAffects.SheilaOil);
			}
			if(kGAMECLASS.monster.findStatusAffect(StatusAffects.TwuWuv) >= 0) {
				inte += kGAMECLASS.monster.statusAffectv1(StatusAffects.TwuWuv);
				kGAMECLASS.statScreenRefresh();
				kGAMECLASS.mainView.statsView.showStatUp( 'inte' );
			}
			if(findStatusAffect(StatusAffects.NagaVenom) >= 0) {
				spe += statusAffectv1(StatusAffects.NagaVenom);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				//stats(0,0,statusAffectv1(StatusAffects.NagaVenom),0,0,0,0,0);
				removeStatusAffect(StatusAffects.NagaVenom);
			}
			if(findStatusAffect(StatusAffects.MedusaVenom) >= 0) {
				str += statusAffectv1(StatusAffects.MedusaVenom);
				tou += statusAffectv2(StatusAffects.MedusaVenom);
				spe += statusAffectv3(StatusAffects.MedusaVenom);
				inte += statusAffectv4(StatusAffects.MedusaVenom);
				kGAMECLASS.mainView.statsView.showStatUp( 'str' );
				kGAMECLASS.mainView.statsView.showStatUp( 'tou' );
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				kGAMECLASS.mainView.statsView.showStatUp( 'inte' );
				//stats(0,0,statusAffectv1(StatusAffects.NagaVenom),0,0,0,0,0);
				removeStatusAffect(StatusAffects.MedusaVenom);
			}
			if(findStatusAffect(StatusAffects.Frostbite) >= 0) {
				str += statusAffectv1(StatusAffects.Frostbite);
				kGAMECLASS.mainView.statsView.showStatUp( 'str' );
				//stats(0,0,statusAffectv1(StatusAffects.Frostbite),0,0,0,0,0);
				removeStatusAffect(StatusAffects.Frostbite);
			}
			if(findStatusAffect(StatusAffects.TentacleBind) >= 0) removeStatusAffect(StatusAffects.TentacleBind);
			if(findStatusAffect(StatusAffects.NagaBind) >= 0) removeStatusAffect(StatusAffects.NagaBind);
			if(findStatusAffect(StatusAffects.StoneLust) >= 0) {
				removeStatusAffect(StatusAffects.StoneLust);
			}
			removeStatusAffect(StatusAffects.FirstAttack);
			if(findStatusAffect(StatusAffects.TemporaryHeat) >= 0) removeStatusAffect(StatusAffects.TemporaryHeat);
			if(findStatusAffect(StatusAffects.NoFlee) >= 0) removeStatusAffect(StatusAffects.NoFlee);
			if(findStatusAffect(StatusAffects.Poison) >= 0) removeStatusAffect(StatusAffects.Poison);
			if(findStatusAffect(StatusAffects.IsabellaStunned) >= 0) removeStatusAffect(StatusAffects.IsabellaStunned);
			if(findStatusAffect(StatusAffects.Stunned) >= 0) removeStatusAffect(StatusAffects.Stunned);
			if(findStatusAffect(StatusAffects.Confusion) >= 0) removeStatusAffect(StatusAffects.Confusion);
			if(findStatusAffect(StatusAffects.ThroatPunch) >= 0) removeStatusAffect(StatusAffects.ThroatPunch);
			if(findStatusAffect(StatusAffects.KissOfDeath) >= 0) removeStatusAffect(StatusAffects.KissOfDeath);
			if(findStatusAffect(StatusAffects.AcidSlap) >= 0) removeStatusAffect(StatusAffects.AcidSlap);
			if(findStatusAffect(StatusAffects.GooBind) >= 0) removeStatusAffect(StatusAffects.GooBind);
			if(findStatusAffect(StatusAffects.HarpyBind) >= 0) removeStatusAffect(StatusAffects.HarpyBind);
			if(findStatusAffect(StatusAffects.CalledShot) >= 0) {
				spe += statusAffectv1(StatusAffects.CalledShot);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speDown.visible = false;
				// speUp.visible = true;
				removeStatusAffect(StatusAffects.CalledShot);
			}
			if(findStatusAffect(StatusAffects.DemonSeed) >= 0) {
				removeStatusAffect(StatusAffects.DemonSeed);
			}
			if(findStatusAffect(StatusAffects.ParalyzeVenom) >= 0) {
				str += statusAffect(findStatusAffect(StatusAffects.ParalyzeVenom)).value1;
				spe += statusAffect(findStatusAffect(StatusAffects.ParalyzeVenom)).value2;
				removeStatusAffect(StatusAffects.ParalyzeVenom);
			}
			if(findStatusAffect(StatusAffects.lustvenom) >= 0) {
				removeStatusAffect(StatusAffects.lustvenom);
			}
			if(findStatusAffect(StatusAffects.InfestAttempted) >= 0) {
				removeStatusAffect(StatusAffects.InfestAttempted);
			}
			if(findStatusAffect(StatusAffects.Flying) >= 0) {
				removeStatusAffect(StatusAffects.Flying);
				if(findStatusAffect(StatusAffects.FlyingNoStun) >= 0) {
					removeStatusAffect(StatusAffects.FlyingNoStun);
					removePerk(PerkLib.Resolute);
				}
			}
			if(findStatusAffect(StatusAffects.ChanneledAttack) >= 0) {
				removeStatusAffect(StatusAffects.ChanneledAttack);
			}
			if(findStatusAffect(StatusAffects.Might) >= 0) {
				kGAMECLASS.dynStats("str", -statusAffectv1(StatusAffects.Might),"tou", -statusAffectv2(StatusAffects.Might));
				removeStatusAffect(StatusAffects.Might);
			}
			if(findStatusAffect(StatusAffects.Blink) >= 0) {
				kGAMECLASS.dynStats("spe", -statusAffectv1(StatusAffects.Blink));
				removeStatusAffect(StatusAffects.Blink);
			}
			if(findStatusAffect(StatusAffects.ChargeWeapon) >= 0) {
				removeStatusAffect(StatusAffects.ChargeWeapon);
			}
			if(findStatusAffect(StatusAffects.ChargeArmor) >= 0) {
				removeStatusAffect(StatusAffects.ChargeArmor);
			}
			if(findStatusAffect(StatusAffects.Blizzard) >= 0) {
				removeStatusAffect(StatusAffects.Blizzard);
			}
			if(findStatusAffect(StatusAffects.UnderwaterCombatBoost) >= 0) {
				kGAMECLASS.dynStats("str", -statusAffectv1(StatusAffects.UnderwaterCombatBoost),"spe", -statusAffectv2(StatusAffects.UnderwaterCombatBoost));
				removeStatusAffect(StatusAffects.UnderwaterCombatBoost);
			}
			if(findStatusAffect(StatusAffects.VioletPupilTransformation) >= 0) {
				removeStatusAffect(StatusAffects.VioletPupilTransformation);
			}
			if(findStatusAffect(StatusAffects.EzekielCurse) >= 0 && flags[kFLAGS.EVANGELINE_AFFECTION] >= 3 && findPerk(PerkLib.EzekielBlessing) >= 0) {
				removeStatusAffect(StatusAffects.EzekielCurse);
			}
			if(findStatusAffect(StatusAffects.CooldownInkSpray) >= 0) {
				removeStatusAffect(StatusAffects.CooldownInkSpray);
			}
			if(findStatusAffect(StatusAffects.CooldownTailSmack) >= 0) {
				removeStatusAffect(StatusAffects.CooldownTailSmack);
			}
			if(findStatusAffect(StatusAffects.CooldownStoneClaw) >= 0) {
				removeStatusAffect(StatusAffects.CooldownStoneClaw);
			}
			if(findStatusAffect(StatusAffects.CooldownTailSlam) >= 0) {
				removeStatusAffect(StatusAffects.CooldownTailSlam);
			}
			if(findStatusAffect(StatusAffects.CooldownWingBuffet) >= 0) {
				removeStatusAffect(StatusAffects.CooldownWingBuffet);
			}
			if(findStatusAffect(StatusAffects.CooldownIllusion) >= 0) {
				removeStatusAffect(StatusAffects.CooldownIllusion);
			}
			if(findStatusAffect(StatusAffects.CooldownTerror) >= 0) {
				removeStatusAffect(StatusAffects.CooldownTerror);
			}
			if(findStatusAffect(StatusAffects.CooldownFascinate) >= 0) {
				removeStatusAffect(StatusAffects.CooldownFascinate);
			}
			if(findStatusAffect(StatusAffects.CooldownCompellingAria) >= 0) {
				removeStatusAffect(StatusAffects.CooldownCompellingAria);
			}
			if(findStatusAffect(StatusAffects.Disarmed) >= 0) {
				removeStatusAffect(StatusAffects.Disarmed);
				if (weapon == WeaponLib.FISTS) {
//					weapon = ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon;
//					(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon).doEffect(this, false);
					setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
				}
				else {
					flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID];
				}
			}
			if(findStatusAffect(StatusAffects.AnemoneVenom) >= 0) {
				str += statusAffectv1(StatusAffects.AnemoneVenom);
				spe += statusAffectv2(StatusAffects.AnemoneVenom);
				//Make sure nothing got out of bounds
				kGAMECLASS.dynStats("cor", 0);

				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				kGAMECLASS.mainView.statsView.showStatUp( 'str' );
				// speUp.visible = true;
				// strUp.visible = true;
				removeStatusAffect(StatusAffects.AnemoneVenom);
			}
			if(findStatusAffect(StatusAffects.GnollSpear) >= 0) {
				spe += statusAffectv1(StatusAffects.GnollSpear);
				//Make sure nothing got out of bounds
				kGAMECLASS.dynStats("cor", 0);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusAffect(StatusAffects.GnollSpear);
			}
			if(findStatusAffect(StatusAffects.BasiliskCompulsion) >= 0) removeStatusAffect(StatusAffects.BasiliskCompulsion);
			if(findStatusAffect(StatusAffects.BasiliskSlow) >= 0) {
				spe += statusAffectv1(StatusAffects.BasiliskSlow);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusAffect(StatusAffects.BasiliskSlow);
			}
			if (findStatusAffect(StatusAffects.GiantGrabbed) >= 0) removeStatusAffect(StatusAffects.GiantGrabbed);
			if (findStatusAffect(StatusAffects.GiantBoulder) >= 0) removeStatusAffect(StatusAffects.GiantBoulder);
			if (findStatusAffect(StatusAffects.GiantStrLoss) >= 0) {
				str += statusAffectv1(StatusAffects.GiantStrLoss);
				removeStatusAffect(StatusAffects.GiantStrLoss);
			}
			if (findStatusAffect(StatusAffects.LizanBlowpipe) >= 0) {
				str += statusAffectv1(StatusAffects.LizanBlowpipe);
				tou += statusAffectv2(StatusAffects.LizanBlowpipe);
				spe += statusAffectv3(StatusAffects.LizanBlowpipe);
				sens -= statusAffectv4(StatusAffects.LizanBlowpipe);
				removeStatusAffect(StatusAffects.LizanBlowpipe);
			}
			while (findStatusAffect(StatusAffects.IzmaBleed) >= 0) removeStatusAffect(StatusAffects.IzmaBleed);
			if (findStatusAffect(StatusAffects.GardenerSapSpeed) >= 0)
			{
				spe += statusAffectv1(StatusAffects.GardenerSapSpeed);
				kGAMECLASS.mainView.statsView.showStatUp('spe');
				removeStatusAffect(StatusAffects.GardenerSapSpeed);
			}
			if (findStatusAffect(StatusAffects.KnockedBack) >= 0) removeStatusAffect(StatusAffects.KnockedBack);
			if (findStatusAffect(StatusAffects.RemovedArmor) >= 0) removeStatusAffect(StatusAffects.KnockedBack);
			if (findStatusAffect(StatusAffects.JCLustLevel) >= 0) removeStatusAffect(StatusAffects.JCLustLevel);
			if (findStatusAffect(StatusAffects.MirroredAttack) >= 0) removeStatusAffect(StatusAffects.MirroredAttack);
			if (findStatusAffect(StatusAffects.Tentagrappled) >= 0) removeStatusAffect(StatusAffects.Tentagrappled);
			if (findStatusAffect(StatusAffects.TentagrappleCooldown) >= 0) removeStatusAffect(StatusAffects.TentagrappleCooldown);
			if (findStatusAffect(StatusAffects.ShowerDotEffect) >= 0) removeStatusAffect(StatusAffects.ShowerDotEffect);
			if (findStatusAffect(StatusAffects.GardenerSapSpeed) >= 0)
			{
				spe += statusAffectv1(StatusAffects.GardenerSapSpeed);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				removeStatusAffect(StatusAffects.GardenerSapSpeed);
			}
			if (findStatusAffect(StatusAffects.VineHealUsed) >= 0) removeStatusAffect(StatusAffects.VineHealUsed);
			if (findStatusAffect(StatusAffects.DriderIncubusVenom) >= 0)
			{
				str += statusAffectv2(StatusAffects.DriderIncubusVenom);
				removeStatusAffect(StatusAffects.DriderIncubusVenom);
			}
			if (findStatusAffect(StatusAffects.TaintedMind) >= 0) removeStatusAffect(StatusAffects.TaintedMind);
			if (findStatusAffect(StatusAffects.PurpleHaze) >= 0) removeStatusAffect(StatusAffects.PurpleHaze);
			if (findStatusAffect(StatusAffects.MinotaurKingMusk) >= 0) removeStatusAffect(StatusAffects.MinotaurKingMusk);
			if (findStatusAffect(StatusAffects.MinotaurKingsTouch) >= 0) removeStatusAffect(StatusAffects.MinotaurKingsTouch);
			if (findStatusAffect(StatusAffects.LethicesRapeTentacles) >= 0) removeStatusAffect(StatusAffects.LethicesRapeTentacles);
			if (findStatusAffect(StatusAffects.OnFire) >= 0) removeStatusAffect(StatusAffects.OnFire);
			if (findStatusAffect(StatusAffects.LethicesShell) >= 0) removeStatusAffect(StatusAffects.LethicesShell);
			if (findStatusAffect(StatusAffects.WhipSilence) >= 0) removeStatusAffect(StatusAffects.WhipSilence);
			if (findStatusAffect(StatusAffects.PigbysHands) >= 0) removeStatusAffect(StatusAffects.PigbysHands);
		}

		public function consumeItem(itype:ItemType, amount:int = 1):Boolean {
			if (!hasItem(itype, amount)) {
				CoC_Settings.error("ERROR: consumeItem attempting to find " + amount + " item" + (amount > 1 ? "s" : "") + " to remove when the player has " + itemCount(itype) + ".");
				return false;
			}
			//From here we can be sure the player has enough of the item in inventory
			var slot:ItemSlotClass;
			while (amount > 0) {
				slot = getLowestSlot(itype); //Always draw from the least filled slots first
				if (slot.quantity > amount) {
					slot.quantity -= amount;
					amount = 0;
				}
				else { //If the slot holds the amount needed then amount will be zero after this
					amount -= slot.quantity;
					slot.emptySlot();
				}
			}
			return true;
/*			
			var consumed:Boolean = false;
			var slot:ItemSlotClass;
			while (amount > 0)
			{
				if(!hasItem(itype,1))
				{
					CoC_Settings.error("ERROR: consumeItem in items.as attempting to find an item to remove when the has none.");
					break;
				}
				trace("FINDING A NEW SLOT! (ITEMS LEFT: " + amount + ")");
				slot = getLowestSlot(itype);
				while (slot != null && amount > 0 && slot.quantity > 0)
				{
					amount--;
					slot.quantity--;
					if(slot.quantity == 0) slot.emptySlot();
					trace("EATIN' AN ITEM");
				}
				//If on slot 5 and it doesn't have any more to take, break out!
				if(slot == undefined) amount = -1

			}
			if(amount == 0) consumed = true;
			return consumed;
*/
		}

		public function getLowestSlot(itype:ItemType):ItemSlotClass
		{
			var minslot:ItemSlotClass = null;
			for each (var slot:ItemSlotClass in itemSlots) {
				if (slot.itype == itype) {
					if (minslot == null || slot.quantity < minslot.quantity) {
						minslot = slot;
					}
				}
			}
			return minslot;
		}
		
		public function hasItem(itype:ItemType, minQuantity:int = 1):Boolean {
			return itemCount(itype) >= minQuantity;
		}
		
		public function itemCount(itype:ItemType):int {
			var count:int = 0;
			for each (var itemSlot:ItemSlotClass in itemSlots){
				if (itemSlot.itype == itype) count += itemSlot.quantity;
			}
			return count;
		}

		// 0..5 or -1 if no
		public function roomInExistingStack(itype:ItemType):Number {
			for (var i:int = 0; i<itemSlots.length; i++){
				if(itemSlot(i).itype == itype && itemSlot(i).quantity != 0 && itemSlot(i).quantity < 5)
					return i;
			}
			return -1;
		}

		public function itemSlot(idx:int):ItemSlotClass
		{
			return itemSlots[idx];
		}

		// 0..5 or -1 if no
		public function emptySlot():Number {
		    for (var i:int = 0; i<itemSlots.length;i++){
				if (itemSlot(i).isEmpty() && itemSlot(i).unlocked) return i;
			}
			return -1;
		}


		public function destroyItems(itype:ItemType, numOfItemToRemove:Number):Boolean
		{
			for (var slotNum:int = 0; slotNum < itemSlots.length; slotNum += 1)
			{
				if(itemSlot(slotNum).itype == itype)
				{
					while(itemSlot(slotNum).quantity > 0 && numOfItemToRemove > 0)
					{
						itemSlot(slotNum).removeOneItem();
						numOfItemToRemove--;
					}
				}
			}
			return numOfItemToRemove <= 0;
		}

		public function lengthChange(temp2:Number, ncocks:Number):void {

			if (temp2 < 0 && flags[kFLAGS.HYPER_HAPPY])  // Early return for hyper-happy cheat if the call was *supposed* to shrink a cock.
			{
				return;
			}
			//DIsplay the degree of length change.
			if(temp2 <= 1 && temp2 > 0) {
				if(cocks.length == 1) outputText("Your " + cockDescript(0) + " has grown slightly longer.", false);
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("One of your " + multiCockDescriptLight() + " grows slightly longer.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("Some of your " + multiCockDescriptLight() + " grow slightly longer.", false);
					if(ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " seem to fill up... growing a little bit larger.", false);
				}
			}
			if(temp2 > 1 && temp2 < 3) {
				if(cocks.length == 1) outputText("A very pleasurable feeling spreads from your groin as your " + cockDescript(0) + " grows permanently longer - at least an inch - and leaks pre-cum from the pleasure of the change.", false);
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A very pleasurable feeling spreads from your groin as your " + multiCockDescriptLight() + " grow permanently longer - at least an inch - and leak plenty of pre-cum from the pleasure of the change.", false);
					if(ncocks == 1) outputText("A very pleasurable feeling spreads from your groin as one of your " + multiCockDescriptLight() + " grows permanently longer, by at least an inch, and leaks plenty of pre-cum from the pleasure of the change.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("A very pleasurable feeling spreads from your groin as " + num2Text(ncocks) + " of your " + multiCockDescriptLight() + " grow permanently longer, by at least an inch, and leak plenty of pre-cum from the pleasure of the change.", false);
				}
			}
			if(temp2 >=3){
				if(cocks.length == 1) outputText("Your " + cockDescript(0) + " feels incredibly tight as a few more inches of length seem to pour out from your crotch.", false);
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("Your " + multiCockDescriptLight() + " feel incredibly tight as one of their number begins to grow inch after inch of length.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("Your " + multiCockDescriptLight() + " feel incredibly number as " + num2Text(ncocks) + " of them begin to grow inch after inch of added length.", false);
					if(ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " feel incredibly tight as inch after inch of length pour out from your groin.", false);
				}
			}
			//Display LengthChange
			if(temp2 > 0) {
				if(cocks[0].cockLength >= 8 && cocks[0].cockLength-temp2 < 8){
					if(cocks.length == 1) outputText("  <b>Most men would be overly proud to have a tool as long as yours.</b>", false);
					if(cocks.length > 1) outputText("  <b>Most men would be overly proud to have one cock as long as yours, let alone " + multiCockDescript() + ".</b>", false);
				}
				if(cocks[0].cockLength >= 12 && cocks[0].cockLength-temp2 < 12) {
					if(cocks.length == 1) outputText("  <b>Your " + cockDescript(0) + " is so long it nearly swings to your knee at its full length.</b>", false);
					if(cocks.length > 1) outputText("  <b>Your " + multiCockDescriptLight() + " are so long they nearly reach your knees when at full length.</b>", false);
				}
				if(cocks[0].cockLength >= 16 && cocks[0].cockLength-temp2 < 16) {
					if(cocks.length == 1) outputText("  <b>Your " + cockDescript(0) + " would look more at home on a large horse than you.</b>", false);
					if(cocks.length > 1) outputText("  <b>Your " + multiCockDescriptLight() + " would look more at home on a large horse than on your body.</b>", false);
					if (biggestTitSize() >= BREAST_CUP_C) {
						if (cocks.length == 1) outputText("  You could easily stuff your " + cockDescript(0) + " between your breasts and give yourself the titty-fuck of a lifetime.", false);
						if (cocks.length > 1) outputText("  They reach so far up your chest it would be easy to stuff a few cocks between your breasts and give yourself the titty-fuck of a lifetime.", false);
					}
					else {
						if(cocks.length == 1) outputText("  Your " + cockDescript(0) + " is so long it easily reaches your chest.  The possibility of autofellatio is now a foregone conclusion.", false);
						if(cocks.length > 1) outputText("  Your " + multiCockDescriptLight() + " are so long they easily reach your chest.  Autofellatio would be about as hard as looking down.", false);
					}
				}
				if(cocks[0].cockLength >= 20 && cocks[0].cockLength-temp2 < 20) {
					if(cocks.length == 1) outputText("  <b>As if the pulsing heat of your " + cockDescript(0) + " wasn't enough, the tip of your " + cockDescript(0) + " keeps poking its way into your view every time you get hard.</b>", false);
					if(cocks.length > 1) outputText("  <b>As if the pulsing heat of your " + multiCockDescriptLight() + " wasn't bad enough, every time you get hard, the tips of your " + multiCockDescriptLight() + " wave before you, obscuring the lower portions of your vision.</b>", false);
					if(cor > 40 && cor <= 60) {
						if(cocks.length > 1) outputText("  You wonder if there is a demon or beast out there that could take the full length of one of your " + multiCockDescriptLight() + "?", false);
						if(cocks.length ==1) outputText("  You wonder if there is a demon or beast out there that could handle your full length.", false);
					}
					if(cor > 60 && cor <= 80) {
						if(cocks.length > 1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your " + multiCockDescriptLight() + " to their hilts, milking you dry.\n\nYou smile at the pleasant thought.", false);
						if(cocks.length ==1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your " + cockDescript(0) + " to the hilt, milking it of all your cum.\n\nYou smile at the pleasant thought.", false);
					}
					if(cor > 80) {
						if(cocks.length > 1) outputText("  You find yourself fantasizing about impaling nubile young champions on your " + multiCockDescriptLight() + " in a year's time.", false);
					}
				}
			}
			//Display the degree of length loss.
			if(temp2 < 0 && temp2 >= -1) {
				if(cocks.length == 1) outputText("Your " + multiCockDescriptLight() + " has shrunk to a slightly shorter length.", false);
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " have shrunk to a slightly shorter length.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your " + multiCockDescriptLight() + " have shrunk to a slightly shorter length.", false);
					if(ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your " + multiCockDescriptLight() + " has shrunk to a slightly shorter length.", false);
				}
			}
			if(temp2 < -1 && temp2 > -3) {
				if(cocks.length == 1) outputText("Your " + multiCockDescriptLight() + " shrinks smaller, flesh vanishing into your groin.", false);
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
					if(ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
				}
			}
			if(temp2 <= -3) {
				if(cocks.length == 1) outputText("A large portion of your " + multiCockDescriptLight() + "'s length shrinks and vanishes.", false);
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A large portion of your " + multiCockDescriptLight() + " recedes towards your groin, receding rapidly in length.", false);
					if(ncocks == 1) outputText("A single member of your " + multiCockDescriptLight() + " vanishes into your groin, receding rapidly in length.", false);
					if(ncocks > 1 && cocks.length > ncocks) outputText("Your " + multiCockDescriptLight() + " tingles as " + num2Text(ncocks) + " of your members vanish into your groin, receding rapidly in length.", false);
				}
			}
		}

		public function killCocks(deadCock:Number):void
		{
			//Count removal for text bits
			var removed:Number = 0;
			var temp:Number;
			//Holds cock index
			var storedCock:Number = 0;
			//Less than 0 = PURGE ALL
			if (deadCock < 0) {
				deadCock = cocks.length;
			}
			//Double loop - outermost counts down cocks to remove, innermost counts down
			while (deadCock > 0) {
				//Find shortest cock and prune it
				temp = cocks.length;
				while (temp > 0) {
					temp--;
					//If anything is out of bounds set to 0.
					if (storedCock > cocks.length - 1) storedCock = 0;
					//If temp index is shorter than stored index, store temp to stored index.
					if (cocks[temp].cockLength <= cocks[storedCock].cockLength) storedCock = temp;
				}
				//Smallest cock should be selected, now remove it!
				removeCock(storedCock, 1);
				removed++;
				deadCock--;
				if (cocks.length == 0) deadCock = 0;
			}
			//Texts
			if (removed == 1) {
				if (cocks.length == 0) {
					outputText("<b>Your manhood shrinks into your body, disappearing completely.</b>", false);
					if (findStatusAffect(StatusAffects.Infested) >= 0) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
				}
				if (cocks.length == 1) {
					outputText("<b>Your smallest penis disappears, shrinking into your body and leaving you with just one " + cockDescript(0) + ".</b>", false);
				}
				if (cocks.length > 1) {
					outputText("<b>Your smallest penis disappears forever, leaving you with just your " + multiCockDescriptLight() + ".</b>", false);
				}
			}
			if (removed > 1) {
				if (cocks.length == 0) {
					outputText("<b>All your male endowments shrink smaller and smaller, disappearing one at a time.</b>", false);
					if (findStatusAffect(StatusAffects.Infested) >= 0) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
				}
				if (cocks.length == 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with just your " + cockDescript(0) + ".", false);
				}
				if (cocks.length > 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with " + multiCockDescriptLight() + ".", false);
				}
			}
			//remove infestation if cockless
			if (cocks.length == 0) removeStatusAffect(StatusAffects.Infested);
			if (cocks.length == 0 && balls > 0) {
				outputText("  <b>Your " + sackDescript() + " and " + ballsDescriptLight() + " shrink and disappear, vanishing into your groin.</b>", false);
				balls = 0;
				ballSize = 1;
			}
		}
		public function modCumMultiplier(delta:Number):Number
		{
			trace("modCumMultiplier called with: " + delta);
		
			if (delta == 0) {
				trace( "Whoops! modCumMuliplier called with 0... aborting..." );
				return delta;
			}
			else if (delta > 0) {
				trace("and increasing");
				if (findPerk(PerkLib.MessyOrgasms) >= 0) {
					trace("and MessyOrgasms found");
					delta *= 1.5
				}
			}
			else if (delta < 0) {
				trace("and decreasing");
				if (findPerk(PerkLib.MessyOrgasms) >= 0) {
					trace("and MessyOrgasms found");
					delta *= 0.5
				}
			}

			trace("and modifying by " + delta);
			cumMultiplier += delta;
			return delta;
		}

		public function increaseCock(cockNum:Number, lengthDelta:Number):Number
		{
			var bigCock:Boolean = false;
	
			if (findPerk(PerkLib.BigCock) >= 0)
				bigCock = true;

			return cocks[cockNum].growCock(lengthDelta, bigCock);
		}
		
		public function increaseEachCock(lengthDelta:Number):Number
		{
			var totalGrowth:Number = 0;
			
			for (var i:Number = 0; i < cocks.length; i++) {
				trace( "increaseEachCock at: " + i);
				totalGrowth += increaseCock(i as Number, lengthDelta);
			}
			
			return totalGrowth;
		}
		
		// Attempts to put the player in heat (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if she is already pregnant or is a he.
		// 
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the 
		// duration and intensity. Defaults to 1.
		public function goIntoHeat(output:Boolean, intensity:int = 1):Boolean {
			if(!hasVagina() || pregnancyIncubation != 0) {
				// No vagina or already pregnant, can't go into heat.
				return false;
			}
			
			//Already in heat, intensify further.
			if (inHeat) {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Despite already being in heat, the desire to copulate constantly grows even larger.", false);
				}
				var temp:Number = findStatusAffect(StatusAffects.Heat);
				statusAffect(temp).value1 += 5 * intensity;
				statusAffect(temp).value2 += 5 * intensity;
				statusAffect(temp).value3 += 48 * intensity;
				game.dynStats("lib", 5 * intensity, "resisted", false, "noBimbo", true);
			}
			//Go into heat.  Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
			else {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Your hands begin stroking your body from top to bottom, your sensitive skin burning with desire.  Fantasies about bending over and presenting your needy pussy to a male overwhelm you as <b>you realize you have gone into heat!</b>", false);
				}
				createStatusAffect(StatusAffects.Heat, 10 * intensity, 15 * intensity, 48 * intensity, 0);
				game.dynStats("lib", 15 * intensity, "resisted", false, "noBimbo", true);
			}
			return true;
		}
		
		// Attempts to put the player in rut (or deeper in heat).
		// Returns true if successful, false if not.
		// The player cannot go into heat if he is a she.
		// 
		// First parameter: boolean indicating if function should output standard text.
		// Second parameter: intensity, an integer multiplier that can increase the 
		// duration and intensity. Defaults to 1.
		public function goIntoRut(output:Boolean, intensity:int = 1):Boolean {
			if (!hasCock()) {
				// No cocks, can't go into rut.
				return false;
			}
			
			//Has rut, intensify it!
			if (inRut) {
				if(output) {
					outputText("\n\nYour " + cockDescript(0) + " throbs and dribbles as your desire to mate intensifies.  You know that <b>you've sunken deeper into rut</b>, but all that really matters is unloading into a cum-hungry cunt.", false);
				}
				
				addStatusValue(StatusAffects.Rut, 1, 100 * intensity);
				addStatusValue(StatusAffects.Rut, 2, 5 * intensity);
				addStatusValue(StatusAffects.Rut, 3, 48 * intensity);
				game.dynStats("lib", 5 * intensity, "resisted", false, "noBimbo", true);
			}
			else {
				if(output) {
					outputText("\n\nYou stand up a bit straighter and look around, sniffing the air and searching for a mate.  Wait, what!?  It's hard to shake the thought from your head - you really could use a nice fertile hole to impregnate.  You slap your forehead and realize <b>you've gone into rut</b>!", false);
				}
				
				//v1 - bonus cum production
				//v2 - bonus libido
				//v3 - time remaining!
				createStatusAffect(StatusAffects.Rut, 150 * intensity, 5 * intensity, 100 * intensity, 0);
				game.dynStats("lib", 5 * intensity, "resisted", false, "noBimbo", true);
			}
			
			return true;
		}
		
		public function setFurColor(colorArray:Array):void {
			if (skinType == SKIN_TYPE_FUR) {
				furColor = colorArray[rand(colorArray.length)];
			}
		}
	}
}
