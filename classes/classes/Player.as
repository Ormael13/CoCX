package classes
{
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.ISexyPart;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armor;
import classes.Items.ArmorLib;
import classes.Items.HeadJewelry;
import classes.Items.HeadJewelryLib;
import classes.Items.Jewelry;
import classes.Items.JewelryLib;
import classes.Items.Mutations;
import classes.Items.Necklace;
import classes.Items.NecklaceLib;
import classes.Items.Shield;
import classes.Items.ShieldLib;
import classes.Items.Undergarment;
import classes.Items.UndergarmentLib;
import classes.Items.Vehicles;
import classes.Items.VehiclesLib;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Items.WeaponRange;
import classes.Items.WeaponRangeLib;
import classes.Items.Undergarment;
import classes.Items.UndergarmentLib;
import classes.Scenes.Areas.Forest.KitsuneScene;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.Pregnancy;
import classes.Scenes.SceneLib;
import classes.StatusEffects.VampireThirstEffect;
import classes.internals.Utils;
import classes.lists.BreastCup;

use namespace CoC;

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
			itemSlot11 = new ItemSlotClass();
			itemSlot12 = new ItemSlotClass();
			itemSlot13 = new ItemSlotClass();
			itemSlot14 = new ItemSlotClass();
			itemSlot15 = new ItemSlotClass();
			itemSlot16 = new ItemSlotClass();
			itemSlot17 = new ItemSlotClass();
			itemSlot18 = new ItemSlotClass();
			itemSlot19 = new ItemSlotClass();
			itemSlot20 = new ItemSlotClass();
			itemSlots = [itemSlot1, itemSlot2, itemSlot3, itemSlot4, itemSlot5, itemSlot6, itemSlot7, itemSlot8, itemSlot9, itemSlot10, itemSlot11, itemSlot12, itemSlot13, itemSlot14, itemSlot15, itemSlot16, itemSlot17, itemSlot18, itemSlot19, itemSlot20];
		}
		
		protected final function outputText(text:String, clear:Boolean = false):void
		{
			if (clear) EngineCore.clearOutputTextOnly();
			EngineCore.outputText(text);
		}
		
		public var startingRace:String = "human";
		
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
		//public var superPerkPoints:Number = 0;	perk points for special perks buyable each 6 lvl's ???
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
		private var pregnancy:Pregnancy = new Pregnancy();
		override public function pregnancyUpdate():Boolean {
			return pregnancy.updatePregnancy(); //Returns true if we need to make sure pregnancy texts aren't hidden
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
		public var itemSlot11:ItemSlotClass;
		public var itemSlot12:ItemSlotClass;
		public var itemSlot13:ItemSlotClass;
		public var itemSlot14:ItemSlotClass;
		public var itemSlot15:ItemSlotClass;
		public var itemSlot16:ItemSlotClass;
		public var itemSlot17:ItemSlotClass;
		public var itemSlot18:ItemSlotClass;
		public var itemSlot19:ItemSlotClass;
		public var itemSlot20:ItemSlotClass;
		public var itemSlots:Array;
		
		public var prisonItemSlots:Array = [];
		public var previouslyWornClothes:Array = []; //For tracking achievement.
		
		private var _weapon:Weapon = WeaponLib.FISTS;
		private var _weaponRange:WeaponRange = WeaponRangeLib.NOTHING;
		private var _armor:Armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
		private var _headjewelry:HeadJewelry = HeadJewelryLib.NOTHING;
		private var _necklace:Necklace = NecklaceLib.NOTHING;
		private var _jewelry:Jewelry = JewelryLib.NOTHING;
		private var _jewelry2:Jewelry = JewelryLib.NOTHING;
		private var _jewelry3:Jewelry = JewelryLib.NOTHING;
		private var _jewelry4:Jewelry = JewelryLib.NOTHING;
		private var _shield:Shield = ShieldLib.NOTHING;
		private var _upperGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _lowerGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _vehicle:Vehicles = VehiclesLib.NOTHING;
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

		override public function set armorMDef(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.armorMDef.");
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

		//override public function set weapons range
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

		//override public function set head jewelries
		override public function set headjewelryName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryName.");
		}
		
		override public function set headjewelryEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryEffectId.");
		}
		
		override public function set headjewelryEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryEffectMagnitude.");
		}
				
		override public function set headjewelryPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryPerk.");
		}
		
		override public function set headjewelryValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.headjewelryValue.");
		}

		//override public function set necklaces
		override public function set necklaceName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklaceName.");
		}
		
		override public function set necklaceEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklaceEffectId.");
		}
		
		override public function set necklaceEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklaceEffectMagnitude.");
		}
				
		override public function set necklacePerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklacePerk.");
		}
		
		override public function set necklaceValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.necklaceValue.");
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
		override public function set jewelryName2(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryName2.");
		}
		
		override public function set jewelryEffectId2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectId2.");
		}
		
		override public function set jewelryEffectMagnitude2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryEffectMagnitude2.");
		}
				
		override public function set jewelryPerk2(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryPerk2.");
		}
		
		override public function set jewelryValue2(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.jewelryValue2.");
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

		//override public function set vehicles
		override public function set vehiclesName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesName.");
		}
		
		override public function set vehiclesEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesEffectId.");
		}
		
		override public function set vehiclesEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesEffectMagnitude.");
		}
				
		override public function set vehiclesPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesPerk.");
		}
		
		override public function set vehiclesValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set player.vehiclesValue.");
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
		public function isWearingArmor():Boolean {
			return armor != ArmorLib.COMFORTABLE_UNDERCLOTHES && armor != ArmorLib.NOTHING;
		}
		//Natural Armor (need at least to partialy covering whole body)
		public function haveNaturalArmor():Boolean
		{
			return findPerk(PerkLib.ThickSkin) >= 0 || skin.hasFur() || skin.hasChitin() || skin.hasScales() || skin.hasBark() || skin.hasDragonScales() || skin.hasBaseOnly(Skin.STONE);
		}
		//Unhindered related acceptable armor types
		public function meetUnhinderedReq():Boolean
		{
			return armorName == "arcane bangles" || armorName == "practically indecent steel armor" || armorName == "revealing chainmail bikini" || armorName == "slutty swimwear" || armorName == "barely-decent bondage straps" || armorName == "bimbo skirt" || armorName == "desert naga pink and black silk dress" || armor == ArmorLib.NOTHING;
		}
		//override public function get armors
		override public function get armorName():String {
			if (_modArmorName.length > 0) return modArmorName;
			else if (_armor.name == "nothing" && lowerGarmentName != "nothing") return lowerGarmentName;
			else if (_armor.name == "nothing" && lowerGarmentName == "nothing") return "gear";
			return _armor.name;
		}
		override public function get armorDef():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var armorDef:Number = _armor.def;
			armorDef += upperGarment.armorDef;
			armorDef += lowerGarment.armorDef;
			//Blacksmith history!
			if (armorDef > 0 && (findPerk(PerkLib.HistorySmith) >= 0 || findPerk(PerkLib.PastLifeSmith) >= 0)) {
				var smithPBonus:Number = 1.05;
				if (findPerk(PerkLib.Tongs) >= 0) smithPBonus += 0.05;
				if (findPerk(PerkLib.Bellows) >= 0) smithPBonus += 0.05;
				if (findPerk(PerkLib.Furnace) >= 0) smithPBonus += 0.05;
				if (findPerk(PerkLib.Hammer) >= 0) smithPBonus += 0.05;
				if (findPerk(PerkLib.Anvil) >= 0) smithPBonus += 0.05;
				if (findPerk(PerkLib.Weap0n) >= 0) smithPBonus += 0.05;
				if (findPerk(PerkLib.Arm0r) >= 0) smithPBonus += 0.05;
				armorDef = Math.round(armorDef * smithPBonus);
				armorDef += 1;
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinArmorPolishing)) {
				armorDef = Math.round(armorDef * (1 + (statusEffectv2(StatusEffects.KonstantinArmorPolishing) / 100)));
				armorDef += 1;
			}
			//Skin armor perk
			if (findPerk(PerkLib.ThickSkin) >= 0) {
				armorDef += (2 * newGamePlusMod);
			}
			//Stacks on top of Thick Skin perk.
			var p:Boolean = skin.isCoverLowMid();
			if (skin.hasFur()) armorDef += (p?1:2) * newGamePlusMod;
			if (hasGooSkin() && skinAdj == "slimy") armorDef += (2 * newGamePlusMod);
			if (skin.hasChitin()) armorDef += (p?2:4)*newGamePlusMod;
			if (skin.hasScales()) armorDef += (p?3:6)*newGamePlusMod; //bee-morph (), mantis-morph (), scorpion-morph (wpisane), spider-morph (wpisane)
			if (skin.hasBark() || skin.hasDragonScales()) armorDef += (p?4:8)*newGamePlusMod;
			if (skin.hasBaseOnly(Skin.STONE)) armorDef += (10 * newGamePlusMod);
			//'Thick' dermis descriptor adds 1!
			if (skinAdj == "smooth") armorDef += (1 * newGamePlusMod);
			//Plant races score bonuses
			if (plantScore() >= 4) {
				if (plantScore() >= 7) armorDef += (10 * newGamePlusMod);
				else if (plantScore() == 6) armorDef += (8 * newGamePlusMod);
				else if (plantScore() == 5) armorDef += (4 * newGamePlusMod);
				else armorDef += (2 * newGamePlusMod);
			}
			if (yggdrasilScore() >= 10 || alrauneScore() >= 10) armorDef += (10 * newGamePlusMod);
			//Dragon score bonuses
			if (dragonScore() >= 10) {
				if (dragonScore() >= 28) armorDef += (10 * newGamePlusMod);
				else if (dragonScore() >= 20) armorDef += (4 * newGamePlusMod);
				else armorDef += (1 * newGamePlusMod);
			}
			//Bonus defense
			if (arms.type == Arms.YETI) armorDef += (1 * newGamePlusMod);
			if (arms.type == Arms.SPIDER || arms.type == Arms.MANTIS || arms.type == Arms.BEE || arms.type == Arms.SALAMANDER) armorDef += (2 * newGamePlusMod);
			if (arms.type == Arms.HYDRA) armorDef += (4 * newGamePlusMod);
			if (tailType == Tail.SPIDER_ADBOMEN || tailType == Tail.MANTIS_ABDOMEN || tailType == Tail.BEE_ABDOMEN) armorDef += (2 * newGamePlusMod);
			if (lowerBody == LowerBody.YETI) armorDef += (1 * newGamePlusMod);
			if (lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS || lowerBody == LowerBody.BEE || lowerBody == LowerBody.MANTIS || lowerBody == LowerBody.SALAMANDER) armorDef += (2 * newGamePlusMod);
			if (lowerBody == LowerBody.DRAGON) armorDef += (3 * newGamePlusMod);
			if (lowerBody == LowerBody.DRIDER || lowerBody == LowerBody.HYDRA) armorDef += (4 * newGamePlusMod);
			if (rearBody.type == RearBody.YETI_FUR) armorDef += (4 * newGamePlusMod);
			if (findPerk(PerkLib.Lycanthropy) >= 0) armorDef += 10 * newGamePlusMod;
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) {
				if (arms.type == Arms.GARGOYLE || arms.type == Arms.GARGOYLE_2) armorDef += (10 * newGamePlusMod);
				if (tailType == Tail.GARGOYLE || tailType == Tail.GARGOYLE_2) armorDef += (10 * newGamePlusMod);
				if (lowerBody == LowerBody.GARGOYLE || lowerBody == LowerBody.GARGOYLE_2) armorDef += (10 * newGamePlusMod);
				if (wings.type == Wings.GARGOYLE_LIKE_LARGE) armorDef += (10 * newGamePlusMod);
				if (faceType == Face.DEVIL_FANGS) armorDef += (10 * newGamePlusMod);
			}
			//Soul Cultivators bonuses
			if (findPerk(PerkLib.BodyCultivator) >= 0) {
				armorDef += (1 * newGamePlusMod);
			}
			if (findPerk(PerkLib.FleshBodyApprenticeStage) >= 0) {
				if (findPerk(PerkLib.SoulApprentice) >= 0) armorDef += 2 * newGamePlusMod;
				if (findPerk(PerkLib.SoulPersonage) >= 0) armorDef += 2 * newGamePlusMod;
				if (findPerk(PerkLib.SoulWarrior) >= 0) armorDef += 2 * newGamePlusMod;
			}
			if (findPerk(PerkLib.FleshBodyWarriorStage) >= 0) {
				if (findPerk(PerkLib.SoulSprite) >= 0) armorDef += 3 * newGamePlusMod;
				if (findPerk(PerkLib.SoulScholar) >= 0) armorDef += 3 * newGamePlusMod;
				if (findPerk(PerkLib.SoulElder) >= 0) armorDef += 3 * newGamePlusMod;
			}
			if (findPerk(PerkLib.FleshBodyElderStage) >= 0) {
				if (findPerk(PerkLib.SoulExalt) >= 0) armorDef += 4 * newGamePlusMod;
				if (findPerk(PerkLib.SoulOverlord) >= 0) armorDef += 4 * newGamePlusMod;
				if (findPerk(PerkLib.SoulTyrant) >= 0) armorDef += 4 * newGamePlusMod;
			}
			if (findPerk(PerkLib.FleshBodyOverlordStage) >= 0) {
				if (findPerk(PerkLib.SoulKing) >= 0) armorDef += 5 * newGamePlusMod;
				if (findPerk(PerkLib.SoulEmperor) >= 0) armorDef += 5 * newGamePlusMod;
				if (findPerk(PerkLib.SoulAncestor) >= 0) armorDef += 5 * newGamePlusMod;
			}
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) armorDef += 6 * newGamePlusMod;
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) armorDef += 9 * newGamePlusMod;
			if (findPerk(PerkLib.FclassHeavenTribulationSurvivor) >= 0) armorDef += 12 * newGamePlusMod;
			//Agility boosts armor ratings!
			var speedBonus:int = 0;
			if (findPerk(PerkLib.Agility) >= 0) {
				if (armorPerk == "Light" || _armor.name == "nothing" || _armor.name == "some taur paladin armor" || _armor.name == "some taur blackguard armor") {
					speedBonus += Math.round(spe / 10);
				}
				else if (armorPerk == "Medium") {
					speedBonus += Math.round(spe / 25);
				}
			}
			if (findPerk(PerkLib.ArmorMaster) >= 0) {
				if (armorPerk == "Heavy") speedBonus += Math.round(spe / 50);
			}
			armorDef += speedBonus;
			//Feral armor boosts armor ratings!
			var toughnessBonus:int = 0;
			if (findPerk(PerkLib.FeralArmor) >= 0 && haveNaturalArmor() && meetUnhinderedReq()) {
				toughnessBonus += Math.round(tou / 20);
			}
			armorDef += toughnessBonus;
			if (findPerk(PerkLib.PrestigeJobSentinel) >= 0 && armorPerk == "Heavy") armorDef += _armor.def;
			if (findPerk(PerkLib.ShieldExpertise) >= 0 && shieldName != "nothing") {
				if (shieldBlock >= 4) armorDef += Math.round(shieldBlock);
				else armorDef += 1;
			}
			//Acupuncture effect
			if (findPerk(PerkLib.ChiReflowDefense) >= 0) armorDef *= UmasShop.NEEDLEWORK_DEFENSE_DEFENSE_MULTI;
			if (findPerk(PerkLib.ChiReflowAttack) >= 0) armorDef *= UmasShop.NEEDLEWORK_ATTACK_DEFENSE_MULTI;
			//Other bonuses
			if (findPerk(PerkLib.ToughHide) >= 0 && haveNaturalArmor()) armorDef += (2 * newGamePlusMod);
			if (findPerk(PerkLib.PigBoarFat) >= 0) armorDef += (1 * newGamePlusMod);
			if (findPerk(PerkLib.PigBoarFatEvolved) >= 0) armorDef += (2 * newGamePlusMod);
			if (findPerk(PerkLib.PigBoarFatFinalForm) >= 0) armorDef += (12 * newGamePlusMod);
			if (findPerk(PerkLib.GoblinoidBlood) >= 0) {
				var goblinbracerBonus:int = 0;
				if (hasKeyItem("Powboy") >= 0 && meetUnhinderedReq()) {
					goblinbracerBonus += Math.round(inte / 10);
					if (goblinbracerBonus > (10 * newGamePlusMod)) goblinbracerBonus = (10 * newGamePlusMod);
				}
				if (hasKeyItem("M.G.S. bracer") >= 0 && meetUnhinderedReq()) {
					goblinbracerBonus += Math.round(inte / 10);
					if (goblinbracerBonus > (20 * newGamePlusMod)) goblinbracerBonus = (20 * newGamePlusMod);
				}
				armorDef += goblinbracerBonus;
			}
			if (vehiclesName == "Goblin Mech Alpha") {
				armorDef += 10;
				if (hasKeyItem("Upgraded Armor plating 1.0") >= 0) armorDef += 5;
				if (hasKeyItem("Upgraded Armor plating 2.0") >= 0) armorDef += 10;
				if (hasKeyItem("Upgraded Armor plating 3.0") >= 0) armorDef += 15;
			}
			if (vehiclesName == "Goblin Mech Prime") {
				armorDef += 20;
				if (hasKeyItem("Upgraded Armor plating 1.0") >= 0) armorDef += 10;
				if (hasKeyItem("Upgraded Armor plating 2.0") >= 0) armorDef += 20;
				if (hasKeyItem("Upgraded Armor plating 3.0") >= 0) armorDef += 30;
			}
			armorDef = Math.round(armorDef);
			//Berzerking removes armor
			if (hasStatusEffect(StatusEffects.Berzerking) && findPerk(PerkLib.ColdFury) < 1) {
				armorDef = 0;
			}
			if (hasStatusEffect(StatusEffects.ChargeArmor) && (!isNaked() || (isNaked() && haveNaturalArmor() && findPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor) >= 0))) armorDef += Math.round(statusEffectv1(StatusEffects.ChargeArmor));
			if (hasStatusEffect(StatusEffects.CompBoostingPCArmorValue)) armorDef += (level * newGamePlusMod);
			if (hasStatusEffect(StatusEffects.StoneSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.StoneSkin));
			if (hasStatusEffect(StatusEffects.BarkSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.BarkSkin));
			if (hasStatusEffect(StatusEffects.MetalSkin)) armorDef += Math.round(statusEffectv1(StatusEffects.MetalSkin));
			if (CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				armorDef -= CoC.instance.monster.statusEffectv1(StatusEffects.TailWhip);
				if(armorDef < 0) armorDef = 0;
			}
			if (hasStatusEffect(StatusEffects.Lustzerking)) {
				if (jewelryName == "Flame Lizard ring" || jewelryName2 == "Flame Lizard ring" || jewelryName3 == "Flame Lizard ring" || jewelryName4 == "Flame Lizard ring") armorDef = Math.round(armorDef * 1.15);
				else armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			if (hasStatusEffect(StatusEffects.CrinosShape) && findPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor) >= 0) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			armorDef = Math.round(armorDef);
			return armorDef;
		}
		override public function get armorMDef():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var armorMDef:Number = _armor.mdef;
			armorMDef += upperGarment.armorMDef;
			armorMDef += lowerGarment.armorMDef;
			//Blacksmith history!
			if (armorDef > 0 && (findPerk(PerkLib.HistorySmith) >= 0 || findPerk(PerkLib.PastLifeSmith) >= 0)) {
				var smithMBonus:Number = 1.05;
				if (findPerk(PerkLib.Tongs) >= 0) smithMBonus += 0.05;
				if (findPerk(PerkLib.Bellows) >= 0) smithMBonus += 0.05;
				if (findPerk(PerkLib.Furnace) >= 0) smithMBonus += 0.05;
				if (findPerk(PerkLib.Hammer) >= 0) smithMBonus += 0.05;
				if (findPerk(PerkLib.Anvil) >= 0) smithMBonus += 0.05;
				if (findPerk(PerkLib.Weap0n) >= 0) smithMBonus += 0.05;
				if (findPerk(PerkLib.Arm0r) >= 0) smithMBonus += 0.05;
				armorMDef = Math.round(armorMDef * smithMBonus);
				armorMDef += 1;
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinArmorPolishing)) {
				armorMDef = Math.round(armorMDef * (1 + (statusEffectv2(StatusEffects.KonstantinArmorPolishing) / 100)));
				armorMDef += 1;
			}
			//Skin armor perk
			if (findPerk(PerkLib.ThickSkin) >= 0) {
				armorMDef += (1 * newGamePlusMod);
			}/*
			//Stacks on top of Thick Skin perk.
			var p:Boolean = skin.isCoverLowMid();
			if (skin.hasFur()) armorDef += (p?1:2)*newGamePlusMod;*/
			if (hasGooSkin() && skinAdj == "slimy") armorMDef += (2 * newGamePlusMod);/*
			if (skin.hasChitin()) armorDef += (p?2:4)*newGamePlusMod;
			if (skin.hasScales()) armorDef += (p?3:6)*newGamePlusMod; //bee-morph (), mantis-morph (), scorpion-morph (wpisane), spider-morph (wpisane)
			if (skin.hasBark() || skin.hasDragonScales()) armorDef += (p?4:8)*newGamePlusMod;*/
			if (skin.hasBaseOnly(Skin.STONE)) armorMDef += (10 * newGamePlusMod);
			//'Thick' dermis descriptor adds 1!
			if (skinAdj == "smooth") armorMDef += (1 * newGamePlusMod);/**//*
			//Plant score bonuses
			if (plantScore() >= 4) {
				if (plantScore() >= 7) armorDef += (10 * newGamePlusMod);
				else if (plantScore() == 6) armorDef += (8 * newGamePlusMod);
				else if (plantScore() == 5) armorDef += (4 * newGamePlusMod);
				else armorDef += (2 * newGamePlusMod);
			}
			if (yggdrasilScore() >= 10) armorDef += (10 * newGamePlusMod);
			//Dragon score bonuses
			if (dragonScore() >= 10) {
				if (dragonScore() >= 28) armorDef += (10 * newGamePlusMod);
				else if (dragonScore() >= 20) armorDef += (4 * newGamePlusMod);
				else armorDef += (1 * newGamePlusMod);
			}
			//Bonus defense
			if (arms.type == Arms.YETI) armorDef += (1 * newGamePlusMod);
			if (arms.type == Arms.SPIDER || arms.type == Arms.MANTIS || arms.type == Arms.BEE || arms.type == Arms.SALAMANDER) armorDef += (2 * newGamePlusMod);
			if (tailType == Tail.SPIDER_ADBOMEN || tailType == Tail.MANTIS_ABDOMEN || tailType == Tail.BEE_ABDOMEN) armorDef += (2 * newGamePlusMod);
			if (lowerBody == LowerBody.YETI) armorDef += (1 * newGamePlusMod);
			if (lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS || lowerBody == LowerBody.BEE || lowerBody == LowerBody.MANTIS || lowerBody == LowerBody.SALAMANDER) armorDef += (2 * newGamePlusMod);
			if (lowerBody == LowerBody.DRAGON) armorDef += (3 * newGamePlusMod);
			if (lowerBody == LowerBody.DRIDER) armorDef += (4 * newGamePlusMod);*/
			if (findPerk(PerkLib.Vulpesthropy) >= 0) armorMDef += 10 * newGamePlusMod;
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) {
				if (arms.type == Arms.GARGOYLE || arms.type == Arms.GARGOYLE_2) armorMDef += (10 * newGamePlusMod);
				if (tailType == Tail.GARGOYLE || tailType == Tail.GARGOYLE_2) armorMDef += (10 * newGamePlusMod);
				if (lowerBody == LowerBody.GARGOYLE || lowerBody == LowerBody.GARGOYLE_2) armorMDef += (10 * newGamePlusMod);
				if (wings.type == Wings.GARGOYLE_LIKE_LARGE) armorMDef += (10 * newGamePlusMod);
				if (faceType == Face.DEVIL_FANGS) armorMDef += (10 * newGamePlusMod);
			}
			//Soul Cultivators bonuses
			if (findPerk(PerkLib.FleshBodyApprenticeStage) >= 0) {
				if (findPerk(PerkLib.SoulApprentice) >= 0) armorMDef += 1 * newGamePlusMod;
				if (findPerk(PerkLib.SoulPersonage) >= 0) armorMDef += 1 * newGamePlusMod;
				if (findPerk(PerkLib.SoulWarrior) >= 0) armorMDef += 1 * newGamePlusMod;
			}
			if (findPerk(PerkLib.FleshBodyWarriorStage) >= 0) {
				if (findPerk(PerkLib.SoulSprite) >= 0) armorMDef += 2 * newGamePlusMod;
				if (findPerk(PerkLib.SoulScholar) >= 0) armorMDef += 2 * newGamePlusMod;
				if (findPerk(PerkLib.SoulElder) >= 0) armorMDef += 2 * newGamePlusMod;
			}
			if (findPerk(PerkLib.FleshBodyElderStage) >= 0) {
				if (findPerk(PerkLib.SoulExalt) >= 0) armorMDef += 3 * newGamePlusMod;
				if (findPerk(PerkLib.SoulOverlord) >= 0) armorMDef += 3 * newGamePlusMod;
				if (findPerk(PerkLib.SoulTyrant) >= 0) armorMDef += 3 * newGamePlusMod;
			}
			if (findPerk(PerkLib.FleshBodyOverlordStage) >= 0) {
				if (findPerk(PerkLib.SoulKing) >= 0) armorMDef += 4 * newGamePlusMod;
				if (findPerk(PerkLib.SoulEmperor) >= 0) armorMDef += 4 * newGamePlusMod;
				if (findPerk(PerkLib.SoulAncestor) >= 0) armorMDef += 4 * newGamePlusMod;
			}
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) armorMDef += 4 * newGamePlusMod;
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) armorMDef += 6 * newGamePlusMod;
			if (findPerk(PerkLib.FclassHeavenTribulationSurvivor) >= 0) armorMDef += 8 * newGamePlusMod;/*
			//Agility boosts armor ratings!
			var speedBonus:int = 0;
			if (findPerk(PerkLib.Agility) >= 0) {
				if (armorPerk == "Light" || _armor.name == "nothing") {
					speedBonus += Math.round(spe / 10);
				}
				else if (armorPerk == "Medium") {
					speedBonus += Math.round(spe / 25);
				}
			}
			if (findPerk(PerkLib.ArmorMaster) >= 0) {
				if (armorPerk == "Heavy") speedBonus += Math.round(spe / 50);
			}
			armorDef += speedBonus;
			//Feral armor boosts armor ratings!
			var toughnessBonus:int = 0;
			if (findPerk(PerkLib.FeralArmor) >= 0 && haveNaturalArmor() && meetUnhinderedReq()) {
				toughnessBonus += Math.round(tou / 20);
			}
			armorDef += toughnessBonus;
			if (findPerk(PerkLib.PrestigeJobSentinel) >= 0 && armorPerk == "Heavy") armorDef += _armor.def;
			if (findPerk(PerkLib.ShieldExpertise) >= 0 && shieldName != "nothing") {
				if (shieldBlock >= 4) armorDef += Math.round(shieldBlock);
				else armorDef += 1;
			}
			//Acupuncture effect
			if (findPerk(PerkLib.ChiReflowDefense) >= 0) armorDef *= UmasShop.NEEDLEWORK_DEFENSE_DEFENSE_MULTI;
			if (findPerk(PerkLib.ChiReflowAttack) >= 0) armorDef *= UmasShop.NEEDLEWORK_ATTACK_DEFENSE_MULTI;*/
			//Other bonuses
			if (findPerk(PerkLib.ToughHide) >= 0 && haveNaturalArmor()) armorMDef += (1 * newGamePlusMod);
			if (findPerk(PerkLib.PigBoarFat) >= 0) armorMDef += (1 * newGamePlusMod);
			if (findPerk(PerkLib.PigBoarFatEvolved) >= 0) armorMDef += (2 * newGamePlusMod);
			if (findPerk(PerkLib.PigBoarFatFinalForm) >= 0) armorMDef += (12 * newGamePlusMod);
			if (findPerk(PerkLib.GoblinoidBlood) >= 0) {
				var goblinbracerBonus:int = 0;
				if (hasKeyItem("Powboy") >= 0 && meetUnhinderedReq()) {
					goblinbracerBonus += Math.round(inte / 10);
					if (goblinbracerBonus > (10 * newGamePlusMod)) goblinbracerBonus = (10 * newGamePlusMod);
				}
				if (hasKeyItem("M.G.S. bracer") >= 0 && meetUnhinderedReq()) {
					goblinbracerBonus += Math.round(inte / 10);
					if (goblinbracerBonus > (20 * newGamePlusMod)) goblinbracerBonus = (20 * newGamePlusMod);
				}
				armorMDef += goblinbracerBonus;
			}
			if (vehiclesName == "Goblin Mech Alpha") {
				armorMDef += 10;
				if (hasKeyItem("Blueprint - Upgraded Armor plating 1.0") >= 0) armorMDef += 5;
				if (hasKeyItem("Blueprint - Upgraded Armor plating 2.0") >= 0) armorMDef += 10;
				if (hasKeyItem("Blueprint - Upgraded Armor plating 3.0") >= 0) armorMDef += 15;
			}
			if (vehiclesName == "Goblin Mech Prime") {
				armorMDef += 20;
				if (hasKeyItem("Blueprint - Upgraded Armor plating 1.0") >= 0) armorMDef += 10;
				if (hasKeyItem("Blueprint - Upgraded Armor plating 2.0") >= 0) armorMDef += 20;
				if (hasKeyItem("Blueprint - Upgraded Armor plating 3.0") >= 0) armorMDef += 30;
			}
			armorMDef = Math.round(armorMDef);
			//Berzerking/Lustzerking removes magic resistance
			if (hasStatusEffect(StatusEffects.Berzerking) && findPerk(PerkLib.ColderFury) < 1) {
				armorMDef = 0;
			}
			if (hasStatusEffect(StatusEffects.Lustzerking) && findPerk(PerkLib.ColderLust) < 1) {
				armorMDef = 0;
			}
			//if (hasStatusEffect(StatusEffects.ChargeArmor) && (!isNaked() || (isNaked() && haveNaturalArmor() && findPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor) >= 0))) armorDef += Math.round(statusEffectv1(StatusEffects.ChargeArmor));
			if (hasStatusEffect(StatusEffects.StoneSkin)) armorMDef += Math.round(statusEffectv1(StatusEffects.StoneSkin));
			if (hasStatusEffect(StatusEffects.BarkSkin)) armorMDef += Math.round(statusEffectv1(StatusEffects.BarkSkin));
			if (hasStatusEffect(StatusEffects.MetalSkin)) armorMDef += Math.round(statusEffectv1(StatusEffects.MetalSkin));/*
			if (CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				armorDef -= CoC.instance.monster.statusEffectv1(StatusEffects.TailWhip);
				if(armorDef < 0) armorDef = 0;
			}
			if (hasStatusEffect(StatusEffects.CrinosShape) && findPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor) >= 0) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}*/
			armorMDef = Math.round(armorMDef);
			return armorMDef;
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
		//Wing Slap compatibile wings + tiers of wings for dmg multi
		public function haveWingsForWingSlap():Boolean
		{
			return wings.type == Wings.BAT_LIKE_LARGE || wings.type == Wings.FEATHERED_LARGE || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.BAT_LIKE_LARGE_2 || wings.type == Wings.DRACONIC_HUGE || wings.type == Wings.FEATHERED_PHOENIX || wings.type == Wings.FEATHERED_ALICORN || wings.type == Wings.GARGOYLE_LIKE_LARGE || wings.type == Wings.MANTICORE_LIKE_LARGE
			 || wings.type == Wings.BAT_ARM || wings.type == Wings.VAMPIRE || wings.type == Wings.FEATHERED_AVIAN || wings.type == Wings.NIGHTMARE || wings.type == Wings.FEATHERED_SPHINX;
		}
		public function thirdtierWingsForWingSlap():Boolean
		{
			return wings.type == Wings.BAT_LIKE_LARGE_2 || wings.type == Wings.DRACONIC_HUGE;
		}
		//Natural Claws (arm types and weapons that can substitude them)
		public function haveNaturalClaws():Boolean
		{
			return arms.type == Arms.CAT || arms.type == Arms.DEVIL || arms.type == Arms.DISPLACER || arms.type == Arms.DRAGON || arms.type == Arms.FOX || arms.type == Arms.GARGOYLE || arms.type == Arms.LION || arms.type == Arms.WOLF
			 || arms.type == Arms.LIZARD || arms.type == Arms.RAIJU || arms.type == Arms.RAIJU_2 || arms.type == Arms.RED_PANDA || arms.type == Arms.SALAMANDER || arms.type == Arms.HYDRA || arms.type == Arms.JIANGSHI;
		}
		public function haveNaturalClawsTypeWeapon():Boolean
		{
			return weaponName == "gauntlet with claws" || weaponName == "gauntlet with an aphrodisiac-coated claws";
		}
		//Weapons for Whirlwind
		public function isWeaponForWhirlwind():Boolean
		{
			return isSwordTypeWeapon() || isAxeTypeWeapon() || weapon == game.weapons.URTAHLB || weapon == game.weapons.L_HAMMR || weapon == game.weapons.WARHAMR || weapon == game.weapons.OTETSU || weapon == game.weapons.POCDEST || weapon == game.weapons.DOCDEST || weapon == game.weapons.D_WHAM_ || weapon == game.weapons.HALBERD
			 || weapon == game.weapons.GUANDAO || weapon == game.weapons.UDKDEST || weapon == game.weapons.DEMSCYT;// || weapon == game.weapons.
		}
		//Weapons for Whipping
		public function isWeaponsForWhipping():Boolean
		{
			return weapon == game.weapons.FLAIL || weapon == game.weapons.L_WHIP || weapon == game.weapons.SUCWHIP || weapon == game.weapons.PSWHIP || weapon == game.weapons.WHIP || weapon == game.weapons.PWHIP || weapon == game.weapons.BFWHIP || weapon == game.weapons.DBFWHIP || weapon == game.weapons.NTWHIP || weapon == game.weapons.CNTWHIP
			 || weapon == game.weapons.RIBBON || weapon == game.weapons.ERIBBON || weapon == game.weapons.SNAKESW || weapon == game.weapons.DAGWHIP;
		}
		//1H Weapons
		public function isOneHandedWeapons():Boolean
		{
			return weaponPerk != "Dual Large" && weaponPerk != "Dual" && weaponPerk != "Dual Small" && weaponPerk != "Staff" && weaponPerk != "Large" && weaponPerk != "Massive";
		}
		//Non Large/Massive weapons
		public function isNoLargeNoStaffWeapon():Boolean
		{
			return weaponPerk != "Dual Large" && weaponPerk != "Large" && weaponPerk != "Massive" && !isStaffTypeWeapon();
		}
		//Wrath Weapons
		public function isLowGradeWrathWeapon():Boolean
		{
			return weapon == game.weapons.BFSWORD || weapon == game.weapons.NPHBLDE || weapon == game.weapons.EBNYBLD || weapon == game.weapons.OTETSU || weapon == game.weapons.POCDEST || weapon == game.weapons.DOCDEST || weapon == game.weapons.BFGAUNT || weapon == game.weapons.SKYPIER || weapon == game.weapons.DWARWA || weapon == game.weapons.BFWHIP
			 || weapon == game.weapons.UDKDEST || weapon == game.weapons.BFTHSWORD || weaponRange == game.weaponsrange.B_F_BOW;
		}
		public function isDualLowGradeWrathWeapon():Boolean
		{
			return weapon == game.weapons.DBFSWO || weapon == game.weapons.ANGSTD || weapon == game.weapons.DBFWHIP;
		}/*
		public function isMidGradeWrathWeapon():Boolean
		{
			return weapon == game.weapons.NTWHIP;
		}
		public function isDualMidGradeWrathWeapon():Boolean
		{
			return ;
		}
		public function isHighGradeWrathWeapon():Boolean
		{
			return weapon == game.weapons.CNTWHIP;
		}
		public function isDualHighGradeWrathWeapon():Boolean
		{
			return ;
		}*/
		//Fists and fist weapons
		public function isFistOrFistWeapon():Boolean
		{
			return weaponName == "fists" || weapon == game.weapons.S_GAUNT || weapon == game.weapons.H_GAUNT || weapon == game.weapons.MASTGLO || weapon == game.weapons.KARMTOU || weapon == game.weapons.YAMARG || weapon == game.weapons.CLAWS || weapon == game.weapons.L_CLAWS || weapon == game.weapons.BFGAUNT
			 || (shield == game.shields.AETHERS && flags[kFLAGS.AETHER_SINISTER_EVO] == 1 && weapon == game.weapons.AETHERD && flags[kFLAGS.AETHER_DEXTER_EVO] == 1);
		}
		//Sword-type weapons
		public function isSwordTypeWeapon():Boolean {
			return weapon == game.weapons.ACLAYMO || weapon == game.weapons.B_SCARB || weapon == game.weapons.B_SWORD || weapon == game.weapons.BFSWORD || weapon == game.weapons.BFTHSWORD || weapon == game.weapons.CLAYMOR || weapon == game.weapons.DBFSWO || weapon == game.weapons.DSWORD_ || weapon == game.weapons.EBNYBLD || weapon == game.weapons.EXCALIB
			 || weapon == game.weapons.HSWORDS || weapon == game.weapons.NODACHI || weapon == game.weapons.NPHBLDE || weapon == game.weapons.PRURUMI || weapon == game.weapons.RCLAYMO || weapon == game.weapons.S_BLADE || weapon == game.weapons.SCARBLD || weapon == game.weapons.SCIMITR || weapon == game.weapons.SCLAYMO || weapon == game.weapons.SNAKESW
			 || weapon == game.weapons.TCLAYMO || weapon == game.weapons.TRSTSWO || weapon == game.weapons.VBLADE || weapon == game.weapons.WDBLADE || weapon == game.weapons.WGSWORD || weapon == game.weapons.ZWNDER;
		}
		//Axe-type weapons
		public function isAxeTypeWeapon():Boolean {
			return weapon == game.weapons.DE_GAXE || weapon == game.weapons.DL_AXE_ || weapon == game.weapons.DWARWA || weapon == game.weapons.FRTAXE || weapon == game.weapons.KIHAAXE || weapon == game.weapons.L__AXE || weapon == game.weapons.TRASAXE || weapon == game.weapons.WG_GAXE;
		}
		//Mace/Hammer-type weapons
		public function isMaceHammerTypeWeapon():Boolean {
			return weapon == game.weapons.D_WHAM_ || weapon == game.weapons.DOCDEST || weapon == game.weapons.FLAIL || weapon == game.weapons.L_HAMMR || weapon == game.weapons.MACE || weapon == game.weapons.OTETSU || weapon == game.weapons.PIPE || weapon == game.weapons.POCDEST || weapon == game.weapons.WARHAMR || weapon == game.weapons.UDKDEST;
		}
		//Dueling sword-type weapons (rapier & katana)
		public function isDuelingTypeWeapon():Boolean {
			return weapon == game.weapons.BLETTER || weapon == game.weapons.B_WIDOW || weapon == game.weapons.DRAPIER || weapon == game.weapons.JRAPIER || weapon == game.weapons.KATANA || weapon == game.weapons.MASAMUN || weapon == game.weapons.Q_GUARD || weapon == game.weapons.RRAPIER || weapon == game.weapons.LRAPIER;
		}
		//Spear-type
		public function isSpearTypeWeapon():Boolean {
			return weapon == game.weapons.DSSPEAR || weapon == game.weapons.GUANDAO || weapon == game.weapons.HALBERD || weapon == game.weapons.LANCE || weapon == game.weapons.PTCHFRK || weapon == game.weapons.SESPEAR || weapon == game.weapons.SKYPIER || weapon == game.weapons.SPEAR || weapon == game.weapons.TRIDENT || weapon == game.weapons.URTAHLB;
		}
		//Scythe-type DEMSCYT LHSCYTH
		//Staff <<SCECOMM(scepter not staff)>>
		public function isStaffTypeWeapon():Boolean {
			return weapon == game.weapons.ASCENSU || weapon == game.weapons.DEPRAVA || weapon == game.weapons.E_STAFF || weapon == game.weapons.L_STAFF || weapon == game.weapons.N_STAFF || weapon == game.weapons.U_STAFF || weapon == game.weapons.W_STAFF || weapon == game.weapons.WDSTAFF;
		}
		//Ribbon ERIBBON RIBBON
		//bronie co nie jestem pewien co do klasyfikacji obecnie: FLYWHIS (dla Sword Immortal gra musi sprawdzić czy używa Sword type lub Dueling sword type weapons bo tak)
		//Weapons for Sneak Attack (Meele and Range)
		public function haveWeaponForSneakAttack():Boolean
		{
			return weaponPerk == "Small" || weaponPerk == "Dual Small";
		}
		public function haveWeaponForSneakAttackRange():Boolean
		{
			return weaponRangePerk == "Bow" || weaponRange == game.weaponsrange.M1CERBE || weaponRange == game.weaponsrange.SNIPPLE;
		}
		//Throwable melee weapons
		public function haveThrowableMeleeWeapon():Boolean
		{
			return weapon == game.weapons.FRTAXE || weapon == game.weapons.TDAGGER || weapon == game.weapons.CHAKRAM;//wrath large weapon that can be throwed or used in melee xD
		}
		//Cleave compatibile weapons
		public function haveWeaponForCleave():Boolean
		{
			return isAxeTypeWeapon() || isSwordTypeWeapon() || isDuelingTypeWeapon();
		}
		//No multishoot firearms
		public function noMultishootFirearms():Boolean
		{
			return weaponRange == game.weaponsrange.TRFATBI;//weaponRange == game.weaponsrange.TRFATBI || 
		}
		//Is in goblin mech
		public function isInGoblinMech():Boolean
		{
			return vehicles == game.vehicles.GOBMALP || vehicles == game.vehicles.GOBMPRI;
		}
		//Is using goblin mech friendly firearms
		public function isUsingGoblinMechFriendlyFirearms():Boolean
		{
			return weaponRange == game.weaponsrange.ADBSCAT || weaponRange == game.weaponsrange.ADBSHOT || weaponRange == game.weaponsrange.BLUNDER || weaponRange == game.weaponsrange.DESEAGL || weaponRange == game.weaponsrange.DUEL_P_ || weaponRange == game.weaponsrange.FLINTLK || weaponRange == game.weaponsrange.HARPGUN || weaponRange == game.weaponsrange.IVIARG_
			 || weaponRange == game.weaponsrange.M1CERBE || weaponRange == game.weaponsrange.TOUHOM3 || weaponRange == game.weaponsrange.TWINGRA || weaponRange == game.weaponsrange.TDPISTO || weaponRange == game.weaponsrange.DPISTOL;
		}
		//Is in ... mech (med sized races mech)(have upgrade option to allow smaller than medium races pilot it)
		//Is in ... mech (large sized races mech)(have upgrade option to allow smaller than large races pilot it)
		//Natural Jouster perks req check
		public function isMeetingNaturalJousterReq():Boolean
		{
			return (((isTaur() || isDrider() || canFly()) && spe >= 60) && hasPerk(PerkLib.Naturaljouster) && (findPerk(PerkLib.DoubleAttack) < 0 || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)))
             || (spe >= 150 && hasPerk(PerkLib.Naturaljouster) && hasPerk(PerkLib.DoubleAttack) && (findPerk(PerkLib.DoubleAttack) < 0 || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)));
		}
		public function isMeetingNaturalJousterMasterGradeReq():Boolean
		{
			return (((isTaur() || isDrider() || canFly()) && spe >= 180) && hasPerk(PerkLib.NaturaljousterMastergrade) && (findPerk(PerkLib.DoubleAttack) < 0 || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)))
             || (spe >= 450 && hasPerk(PerkLib.NaturaljousterMastergrade) && hasPerk(PerkLib.DoubleAttack) && (findPerk(PerkLib.DoubleAttack) < 0 || (hasPerk(PerkLib.DoubleAttack) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 0)));
		}
		public function haveWeaponForJouster():Boolean
		{
			return isSpearTypeWeapon() || weaponName == "demonic scythe";
		}
		//override public function get weapons
		override public function get weaponName():String {
			return _weapon.name;
		}
		override public function get weaponVerb():String {
			return _weapon.verb;
		}
		override public function get weaponAttack():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var attack:Number = _weapon.attack;
			if (findPerk(PerkLib.JobSwordsman) >= 0 && weaponPerk == "Large") {
				if (findPerk(PerkLib.WeaponMastery) >= 0 && str >= 100) {
					if (findPerk(PerkLib.WeaponGrandMastery) >= 0 && str >= 140) attack *= 2;
					else attack *= 1.5;
				}
				else attack *= 1.25;
			}
			if (findPerk(PerkLib.WeaponGrandMastery) >= 0 && weaponPerk == "Dual Large" && str >= 140) {
				attack *= 2;
			}
			if (findPerk(PerkLib.GigantGripEx) >= 0 && weaponPerk == "Massive") {
				if (findPerk(PerkLib.WeaponMastery) >= 0 && str >= 100) {
					if (findPerk(PerkLib.WeaponGrandMastery) >= 0 && str >= 140) attack *= 2;
					else attack *= 1.5;
				}
				else attack *= 1.25;
			}
			if (findPerk(PerkLib.HiddenMomentum) >= 0 && (weaponPerk == "Large" || (findPerk(PerkLib.GigantGripEx) >= 0 && weaponPerk == "Massive")) && str >= 75 && spe >= 50) {
				attack += (((str + spe) - 100) * 0.2);
			}//30-70-110
			if (findPerk(PerkLib.HiddenDualMomentum) >= 0 && weaponPerk == "Dual Large" && str >= 150 && spe >= 100) {
				attack += (((str + spe) - 200) * 0.2);
			}//20-60-100
			if (findPerk(PerkLib.LightningStrikes) >= 0 && spe >= 60 && (weaponPerk != "Massive" || weaponPerk != "Large" || weaponPerk != "Dual Large" || weaponPerk != "Small" || weaponPerk != "Dual Small" || !isFistOrFistWeapon())) {
				attack += ((spe - 50) * 0.3);
			}//45-105-165
			if (findPerk(PerkLib.StarlightStrikes) >= 0 && spe >= 60 && (weaponPerk == "Small" || weaponPerk == "Dual Small")) {
				attack += ((spe - 50) * 0.2);
			}
			if (findPerk(PerkLib.SteelImpact) >= 0) {
				attack += ((tou - 50) * 0.3);
			}
			if (isFistOrFistWeapon()) {
				if (findPerk(PerkLib.IronFistsI) >= 0 && str >= 50) {
					attack += 10;
				}
				if (findPerk(PerkLib.IronFistsII) >= 0 && str >= 65) {
					attack += 10;
				}
				if (findPerk(PerkLib.IronFistsIII) >= 0 && str >= 80) {
					attack += 10;
				}
				if (findPerk(PerkLib.IronFistsIV) >= 0 && str >= 95) {
					attack += 10;
				}
				if (findPerk(PerkLib.IronFistsV) >= 0 && str >= 110) {
					attack += 10;
				}
				if (findPerk(PerkLib.IronFistsVI) >= 0 && str >= 125) {
					attack += 10;
				}
				if (findPerk(PerkLib.JobBrawler) >= 0 && str >= 60) {
					attack += (5 * newGamePlusMod);
				}
				if (findPerk(PerkLib.MightyFist) >= 0 && isFistOrFistWeapon()) {
					attack += (5 * newGamePlusMod);
				}
				if (SceneLib.combat.unarmedAttack() > 0) {
					attack += SceneLib.combat.unarmedAttack();
				}
			}
			if (findPerk(PerkLib.PrestigeJobTempest) >= 0 && weaponPerk == "Dual") {
				attack += (5 * newGamePlusMod);
			}
			//Konstantine buff
			if (hasStatusEffect(StatusEffects.KonstantinWeaponSharpening) && weaponName != "fists") {
				attack *= 1 + (statusEffectv2(StatusEffects.KonstantinWeaponSharpening) / 100);
			}
			if (hasStatusEffect(StatusEffects.Berzerking) || hasStatusEffect(StatusEffects.Lustzerking)) {
				var zerkersboost:Number = 0;
				zerkersboost += (15 + (15 * newGamePlusMod));
				if (findPerk(PerkLib.ColdFury) >= 0 || findPerk(PerkLib.ColdLust) >= 0) zerkersboost += (5 + (5 * newGamePlusMod));
				if (findPerk(PerkLib.ColderFury) >= 0 || findPerk(PerkLib.ColderLust) >= 0) zerkersboost += (10 + (10 * newGamePlusMod));
				if (findPerk(PerkLib.SalamanderAdrenalGlandsFinalForm) >= 0) zerkersboost += (30 + (30 * newGamePlusMod));
				if (findPerk(PerkLib.Lustzerker) >= 0 && (jewelryName == "Flame Lizard ring" || jewelryName2 == "Flame Lizard ring" || jewelryName3 == "Flame Lizard ring" || jewelryName4 == "Flame Lizard ring")) zerkersboost += (5 + (5 * newGamePlusMod));
				if (hasStatusEffect(StatusEffects.Berzerking) && hasStatusEffect(StatusEffects.Lustzerking)) {
					if (findPerk(PerkLib.ColderFury) >= 0 || findPerk(PerkLib.ColderLust) >= 0) zerkersboost *= 4;
					else if (findPerk(PerkLib.ColderFury) >= 0 || findPerk(PerkLib.ColderLust) >= 0) zerkersboost *= 3;
					else zerkersboost *= 2.5;
				}
				attack += zerkersboost;
			}
			if (hasStatusEffect(StatusEffects.ChargeWeapon)) {
				if (weaponName == "fists" && findPerk(PerkLib.ImprovingNaturesBlueprintsNaturalWeapons) < 0) attack += 0;
				else attack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
			}
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
		//Artifacts Bows
		public function isArtifactBow():Boolean
		{
			return weaponRange == game.weaponsrange.BOWGUID || weaponRange == game.weaponsrange.BOWHODR;
		}
		//Using Tome
		public function isUsingTome():Boolean
		{
			return weaponRangeName == "nothing" || weaponRangeName == "Inquisitor’s Tome" || weaponRangeName == "Sage’s Sketchbook";
		}
		//Using Staff
		public function isUsingStaff():Boolean
		{
			return weaponPerk == "Staff" || weaponName == "demonic scythe";
		}
		//Using Wand
		public function isUsingWand():Boolean
		{
			return weaponPerk == "Wand";
		}
		//override public function get weapons
		override public function get weaponRangeName():String {
			return _weaponRange.name;
		}
		override public function get weaponRangeVerb():String {
			return _weaponRange.verb;
		}
		override public function get weaponRangeAttack():Number {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var rangeattack:Number = _weaponRange.attack;
			if (findPerk(PerkLib.PracticedShot) >= 0 && str >= 60 && (weaponRangePerk == "Bow" || weaponRangePerk == "Crossbow" || weaponRangePerk == "Throwing")) {
				if (findPerk(PerkLib.EagleEye) >= 0) rangeattack *= 2;
				else rangeattack *= 1.5;
			}
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
			}
			if(arms.type == MANTIS && weaponRangeName == "fists") {
				rangeattack += (15 * newGamePlusMod);
			}
			if(hasStatusEffect(StatusEffects.Berzerking)) rangeattack += (30 + (15 * newGamePlusMod));
			if(hasStatusEffect(StatusEffects.Lustzerking)) rangeattack += (30 + (15 * newGamePlusMod));
			if(findPerk(PerkLib.) >= 0) rangeattack += Math.round(statusEffectv1(StatusEffects.ChargeWeapon));
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
		public function get ammo():int {
			return flags[kFLAGS.FLINTLOCK_PISTOL_AMMO];
		}
		public function set ammo(value:int):void {
			flags[kFLAGS.FLINTLOCK_PISTOL_AMMO] = value;
		}
		
		//override public function get headjewelries.
		override public function get headjewelryName():String {
			return _headjewelry.name;
		}
		override public function get headjewelryEffectId():Number {
			return _headjewelry.effectId;
		}
		override public function get headjewelryEffectMagnitude():Number {
			return _headjewelry.effectMagnitude;
		}
		override public function get headjewelryPerk():String {
			return _headjewelry.perk;
		}
		override public function get headjewelryValue():Number {
			return _headjewelry.value;
		}
		
		//override public function get necklaces.
		override public function get necklaceName():String {
			return _necklace.name;
		}
		override public function get necklaceEffectId():Number {
			return _necklace.effectId;
		}
		override public function get necklaceEffectMagnitude():Number {
			return _necklace.effectMagnitude;
		}
		override public function get necklacePerk():String {
			return _necklace.perk;
		}
		override public function get necklaceValue():Number {
			return _necklace.value;
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
		override public function get jewelryName2():String {
			return _jewelry2.name;
		}
		override public function get jewelryEffectId2():Number {
			return _jewelry2.effectId;
		}
		override public function get jewelryEffectMagnitude2():Number {
			return _jewelry2.effectMagnitude;
		}
		override public function get jewelryPerk2():String {
			return _jewelry2.perk;
		}
		override public function get jewelryValue2():Number {
			return _jewelry2.value;
		}
		override public function get jewelryName3():String {
			return _jewelry3.name;
		}
		override public function get jewelryEffectId3():Number {
			return _jewelry3.effectId;
		}
		override public function get jewelryEffectMagnitude3():Number {
			return _jewelry3.effectMagnitude;
		}
		override public function get jewelryPerk3():String {
			return _jewelry3.perk;
		}
		override public function get jewelryValue3():Number {
			return _jewelry3.value;
		}
		override public function get jewelryName4():String {
			return _jewelry4.name;
		}
		override public function get jewelryEffectId4():Number {
			return _jewelry4.effectId;
		}
		override public function get jewelryEffectMagnitude4():Number {
			return _jewelry4.effectMagnitude;
		}
		override public function get jewelryPerk4():String {
			return _jewelry4.perk;
		}
		override public function get jewelryValue4():Number {
			return _jewelry4.value;
		}
		
		//override public function get vehicle.
		override public function get vehiclesName():String {
			return _vehicle.name;
		}
		override public function get vehiclesEffectId():Number {
			return _vehicle.effectId;
		}
		override public function get vehiclesEffectMagnitude():Number {
			return _vehicle.effectMagnitude;
		}
		override public function get vehiclesPerk():String {
			return _vehicle.perk;
		}
		override public function get vehiclesValue():Number {
			return _vehicle.value;
		}
		
		//Shields for Bash
		public function isShieldsForShieldBash():Boolean
		{
			return shield == game.shields.BUCKLER || shield == game.shields.GREATSH || shield == game.shields.KITE_SH || shield == game.shields.TRASBUC || shield == game.shields.TOWERSH || shield == game.shields.DRGNSHL || shield == game.shields.SANCTYN || shield == game.shields.SANCTYL || shield == game.shields.SANCTYD;
		}
		//override public function get shields
		override public function get shieldName():String {
			return _shield.name;
		}
		override public function get shieldBlock():Number {
			var block:Number = _shield.block;
			if (findPerk(PerkLib.JobKnight) >= 0) block += 3;
			if (shield == game.shields.AETHERS && weapon == game.weapons.AETHERD) block += 1;
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
		
		//Range Weapon, added by Ormael
		public function get weaponRange():WeaponRange
		{
			return _weaponRange;
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
		
		//Head Jewelry, added by Ormael
		public function get headJewelry():HeadJewelry
		{
			return _headjewelry;
		}

		public function setHeadJewelry(newHeadJewelry:HeadJewelry):HeadJewelry {
			//Returns the old head jewelery, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldHeadJewelry:HeadJewelry = _headjewelry.playerRemove();
			if (newHeadJewelry == null) {
				CoC_Settings.error(short + ".headjewelry is set to null");
				newHeadJewelry = HeadJewelryLib.NOTHING;
			}
			_headjewelry = newHeadJewelry.playerEquip(); //The head jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldHeadJewelry;
		}
		// in case you don't want to call the value.equip
		public function setHeadJewelryHiddenField(value:HeadJewelry):void
		{
			this._headjewelry = value;
		}
		
		//Necklace, added by Ormael
		public function get necklace():Necklace
		{
			return _necklace;
		}

		public function setNecklace(newNecklace:Necklace):Necklace {
			//Returns the old necklace, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldNecklace:Necklace = _necklace.playerRemove();
			if (newNecklace == null) {
				CoC_Settings.error(short + ".necklace is set to null");
				newNecklace = NecklaceLib.NOTHING;
			}
			_necklace = newNecklace.playerEquip(); //The necklace can also choose to equip something else - useful for Ceraph's trap armor
			return oldNecklace;
		}
		// in case you don't want to call the value.equip
		public function setNecklaceHiddenField(value:Necklace):void
		{
			this._necklace = value;
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
		
		public function get jewelry2():Jewelry
		{
			return _jewelry2;
		}

		public function setJewelry2(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry2.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry2 is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry2 = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField2(value:Jewelry):void
		{
			this._jewelry2 = value;
		}
		
		public function get jewelry3():Jewelry
		{
			return _jewelry3;
		}

		public function setJewelry3(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry3.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry2 is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry3 = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField3(value:Jewelry):void
		{
			this._jewelry3 = value;
		}
		
		public function get jewelry4():Jewelry
		{
			return _jewelry4;
		}

		public function setJewelry4(newJewelry:Jewelry):Jewelry {
			//Returns the old jewelry, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldJewelry:Jewelry = _jewelry4.playerRemove(); //The armor is responsible for removing any bonuses, perks, etc.
			if (newJewelry == null) {
				CoC_Settings.error(short + ".jewelry2 is set to null");
				newJewelry = JewelryLib.NOTHING;
			}
			_jewelry4 = newJewelry.playerEquip(); //The jewelry can also choose to equip something else - useful for Ceraph's trap armor
			return oldJewelry;
		}
		// in case you don't want to call the value.equip
		public function setJewelryHiddenField4(value:Jewelry):void
		{
			this._jewelry4 = value;
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
		
		//Vehicles, added by Ormael
		public function get vehicles():Vehicles
		{
			return _vehicle;
		}

		public function setVehicle(newVehicle:Vehicles):Vehicles {
			//Returns the old vehicle, allowing the caller to discard it, store it or try to place it in the player's inventory
			//Can return null, in which case caller should discard.
			var oldVehicle:Vehicles = _vehicle.playerRemove();
			if (newVehicle == null) {
				CoC_Settings.error(short + ".vehicle is set to null");
				newVehicle = VehiclesLib.NOTHING;
			}
			_vehicle = newVehicle.playerEquip(); //The vehicle can also choose to equip something else
			return oldVehicle;
		}
		// in case you don't want to call the value.equip
		public function setVehicleHiddenField(value:Vehicles):void
		{
			this._vehicle = value;
		}
		
		public override function lustPercent():Number {
			var lust:Number = 100;
			var minLustCap:Number = 25;
			
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//ADDITIVE REDUCTIONS
			//THESE ARE FLAT BONUSES WITH LITTLE TO NO DOWNSIDE
			//TOTAL IS LIMITED TO 75%!
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//Corrupted Libido reduces lust gain by 10%!
			if(findPerk(PerkLib.CorruptedLibido) >= 0) lust -= 10;
			//Acclimation reduces by 15%
			if(findPerk(PerkLib.Acclimation) >= 0) lust -= 15;
			//Purity blessing reduces lust gain
			if(findPerk(PerkLib.PurityBlessing) >= 0) lust -= 5;
			//Resistance = 10%
			if(findPerk(PerkLib.ResistanceI) >= 0) lust -= 5;
			if(findPerk(PerkLib.ResistanceII) >= 0) lust -= 5;
			if(findPerk(PerkLib.ResistanceIII) >= 0) lust -= 5;
			if(findPerk(PerkLib.ResistanceIV) >= 0) lust -= 5;
			if(findPerk(PerkLib.ResistanceV) >= 0) lust -= 5;
			if(findPerk(PerkLib.ResistanceVI) >= 0) lust -= 5;
			if(findPerk(PerkLib.PewWarmer) >= 0) lust -= 5;
			if(findPerk(PerkLib.Acolyte) >= 0) lust -= 5;
			if(findPerk(PerkLib.Priest) >= 0) lust -= 5;
			if(findPerk(PerkLib.Pastor) >= 0) lust -= 5;
			if(findPerk(PerkLib.Saint) >= 0) lust -= 5;
			if(findPerk(PerkLib.Cardinal) >= 0) lust -= 5;
			if(findPerk(PerkLib.Pope) >= 0) lust -= 5;
			if(findPerk(PerkLib.LactaBovinaOvariesEvolved) >= 0) lust -= 5;
			if(findPerk(PerkLib.MinotaurTesticlesEvolved) >= 0) lust -= 5;
			if((findPerk(PerkLib.UnicornBlessing) >= 0 && cor <= 20) || (findPerk(PerkLib.BicornBlessing) >= 0 && cor >= 80)) lust -= 10;
			if(findPerk(PerkLib.ChiReflowLust) >= 0) lust -= UmasShop.NEEDLEWORK_LUST_LUST_RESIST;
			if(jewelryEffectId == JewelryLib.MODIFIER_LUST_R) lust -= jewelryEffectMagnitude;
			if(jewelryEffectId2 == JewelryLib.MODIFIER_LUST_R) lust -= jewelryEffectMagnitude2;
			if(jewelryEffectId3 == JewelryLib.MODIFIER_LUST_R) lust -= jewelryEffectMagnitude3;
			if(jewelryEffectId4 == JewelryLib.MODIFIER_LUST_R) lust -= jewelryEffectMagnitude4;
			if(headjewelryEffectId == JewelryLib.MODIFIER_LUST_R) lust -= headjewelryEffectMagnitude;
			if(necklaceEffectId == JewelryLib.MODIFIER_LUST_R) lust -= necklaceEffectMagnitude;
			if(jewelryEffectId == JewelryLib.MODIFIER_LUST_R && jewelryEffectId2 == JewelryLib.MODIFIER_LUST_R && jewelryEffectId3 == JewelryLib.MODIFIER_LUST_R && jewelryEffectId4 == JewelryLib.MODIFIER_LUST_R && headjewelryEffectId == JewelryLib.MODIFIER_LUST_R && necklaceEffectId == JewelryLib.MODIFIER_LUST_R) lust -= 15;
			if(lust < minLustCap) lust = minLustCap;
			if(statusEffectv1(StatusEffects.BlackCatBeer) > 0) {
				if(lust >= 80) lust = 100;
				else lust += 20;
			}
			lust += Math.round(perkv1(PerkLib.PentUp)/2);
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//MULTIPLICATIVE REDUCTIONS
			//THESE PERKS ALSO RAISE MINIMUM LUST OR HAVE OTHER
			//DRAWBACKS TO JUSTIFY IT.
			//++++++++++++++++++++++++++++++++++++++++++++++++++
			//Bimbo body slows lust gains!
			if((hasStatusEffect(StatusEffects.BimboChampagne) || findPerk(PerkLib.BimboBody) >= 0) && lust > 0) lust *= .75;
			if(findPerk(PerkLib.BroBody) >= 0 && lust > 0) lust *= .75;
			if(findPerk(PerkLib.FutaForm) >= 0 && lust > 0) lust *= .75;
			//Omnibus' Gift reduces lust gain by 15%
			if(findPerk(PerkLib.OmnibusGift) >= 0) lust *= .85;
			//Fera Blessing reduces lust gain by 15%
			if(hasStatusEffect(StatusEffects.BlessingOfDivineFera)) lust *= .85;
			//Luststick reduces lust gain by 10% to match increased min lust
			if(findPerk(PerkLib.LuststickAdapted) >= 0) lust *= 0.9;
			if(hasStatusEffect(StatusEffects.Berzerking)) lust *= .6;
			if (findPerk(PerkLib.PureAndLoving) >= 0) lust *= 0.95;
			//Berseking reduces lust gains by 10%
			if (hasStatusEffect(StatusEffects.Berzerking)) lust *= 0.9;
			if (hasStatusEffect(StatusEffects.Overlimit)) lust *= 0.9;
			//Items
			if (jewelryEffectId == JewelryLib.PURITY) lust *= 1 - (jewelryEffectMagnitude / 100);
			if (armor == game.armors.DBARMOR) lust *= 0.9;
			if (weapon == game.weapons.HNTCANE) lust *= 0.75;
			if ((weapon == game.weapons.PURITAS) || (weapon == game.weapons.ASCENSU)) lust *= 0.9;
			// Lust mods from Uma's content -- Given the short duration and the gem cost, I think them being multiplicative is justified.
			// Changing them to an additive bonus should be pretty simple (check the static values in UmasShop.as)
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac)
			{
				if (sac.value1 == UmasShop.MASSAGE_RELIEF || sac.value1 == UmasShop.MASSAGE_LUST)
				{
					lust *= sac.value2;
				}
			}
			if(statusEffectv1(StatusEffects.Maleficium) > 0) {
				if (hasPerk(PerkLib.ObsidianHeartFinalForm)) {
					if (lust >= 70) lust = 100;
					else lust += 30;
				}
				else {
					if (lust >= 50) lust = 100;
					else lust += 50;
				}
			}
			lust = Math.round(lust);
			if (hasStatusEffect(StatusEffects.Lustzerking) && findPerk(PerkLib.ColdLust) < 1) lust = 100;
			if (hasStatusEffect(StatusEffects.BlazingBattleSpirit)) lust = 0;
			return lust;
		}

		public function bouncybodyDR():Number {
			var bbDR:Number = 0.25;
			if (hasPerk(PerkLib.NaturalPunchingBag)) bbDR += 0.05;
			if (hasPerk(PerkLib.NaturalPunchingBagEvolved)) bbDR += 0.1;
			if (hasPerk(PerkLib.NaturalPunchingBagFinalForm)) bbDR += 0.2;
			return bbDR;
		}
		public function wrathRatioToHP():Number {
			var ratioWH:Number = 10;
			return ratioWH;
		}
		public function wrathFromHPmulti():Number {
			var WHmulti:Number = 1;
			if (hasPerk(PerkLib.FuelForTheFire)) WHmulti *= 2;
			return WHmulti;
		}
		public override function damagePercent():Number {
			var mult:Number = 100;
			var armorMod:Number = armorDef;
			//--BASE--
			mult -= armorMod;
			if (mult < 20) mult = 20;
			//--PERKS--
			//Take damage you masochist!
			if (findPerk(PerkLib.Masochist) >= 0 && lib >= 60) {
				mult -= 20;
				dynStats("lus", (2 * (1 + game.player.newGamePlusMod())));
			}
			if (findPerk(PerkLib.FenrirSpikedCollar) >= 0) {
				mult -= 15;
			}
			if (findPerk(PerkLib.Juggernaut) >= 0 && tou >= 100 && armorPerk == "Heavy") {
				mult -= 10;
			}
			if (findPerk(PerkLib.ImmovableObject) >= 0 && tou >= 75) {
				mult -= 10;
			}
			if (findPerk(PerkLib.AyoArmorProficiency) >= 0 && tou >= 75 && armorPerk == "Ayo") {
				mult -= 10;
			}
			if (findPerk(PerkLib.HeavyArmorProficiency) >= 0 && tou >= 75 && armorPerk == "Heavy") {
				mult -= 10;
			}
			if (findPerk(PerkLib.ShieldHarmony) >= 0 && tou >= 100 && shieldName != "nothing" && !hasStatusEffect(StatusEffects.Stunned)) {
				mult -= 10;
			}
			if (findPerk(PerkLib.NakedTruth) >= 0 && spe >= 75 && lib >= 60 && meetUnhinderedReq()) {
				mult -= 10;
			}
			if (findPerk(PerkLib.FluidBody) >= 0 && meetUnhinderedReq()) {
				mult -= 50;
				dynStats("lus", (5 * (1 + game.player.newGamePlusMod())));
			}
			if (findPerk(PerkLib.HaltedVitals) >= 0) {
				mult -= 20;
			}
			//--STATUS AFFECTS--
			//Black cat beer = 25% reduction!
			if (statusEffectv1(StatusEffects.BlackCatBeer) > 0) {
				mult -= 25;
			}
			if (statusEffectv1(StatusEffects.OniRampage) > 0) {
				mult -= 20;
			}
			if (statusEffectv1(StatusEffects.EarthStance) > 0) {
				mult -= 30;
			}
			if (statusEffectv1(StatusEffects.AcidDoT) > 0) {
				mult += statusEffectv2(StatusEffects.AcidDoT);
			}
			//Defend = 35-95% reduction
			if (hasStatusEffect(StatusEffects.Defend)) {
				if (findPerk(PerkLib.DefenceStance) >= 0 && tou >= 80) {
					if (findPerk(PerkLib.MasteredDefenceStance) >= 0 && tou >= 120) {
						if (findPerk(PerkLib.PerfectDefenceStance) >= 0 && tou >= 160) mult -= 95;
						else mult -= 70;
					}
					else mult -= 50;
				}
				else mult -= 35;
			}
			// Uma's Massage bonuses
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac && sac.value1 == UmasShop.MASSAGE_RELAXATION) {
				mult -= 100 * sac.value2;
			}
			//Caps damage reduction at 80/99%
			if (hasStatusEffect(StatusEffects.Defend) && findPerk(PerkLib.PerfectDefenceStance) >= 0 && tou >= 160 && mult < 1) mult = 1;
			if (!hasStatusEffect(StatusEffects.Defend) && mult < 20) mult = 20;
			return mult;
		}
		public override function takePhysDamage(damage:Number, display:Boolean = false):Number{
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (hasStatusEffect(StatusEffects.ManaShield) && damage < mana) {
					mana -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('mana');
					dynStats("lus", 0); //Force display arrow.
				}
				else {
					damage = reducePhysDamage(damage);
					//Wrath
					var gainedWrath:Number = 0;
					gainedWrath += (Math.round(damage / wrathRatioToHP())) * wrathFromHPmulti();
					wrath += gainedWrath;
					if (wrath > maxWrath()) wrath = maxWrath();
					//game.HPChange(-damage, display);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				if (flags[kFLAGS.YAMATA_MASOCHIST] > 1 && flags[kFLAGS.AIKO_BOSS_COMPLETE] < 1) {
					dynStats("lus", int(damage / 8));
				}
				//Prevent negatives
				if (HP < minHP()){
					HP = minHP();
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}
		public function reducePhysDamage(damage:Number):Number {
			var damageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) damageMultiplier /= 2;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) damageMultiplier *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) damageMultiplier *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) damageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) damageMultiplier *= 2;
			
			//Opponents can critical too!
			var crit:Boolean = false;
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.findPerk(PerkLib.Tactician) >= 0 && CoC.instance.monster.inte >= 50) {
				if (CoC.instance.monster.inte <= 100) critChanceMonster += (CoC.instance.monster.inte - 50) / 5;
				if (CoC.instance.monster.inte > 100) critChanceMonster += 10;
			}
			if (CoC.instance.monster.findPerk(PerkLib.VitalShot) >= 0 && CoC.instance.monster.inte >= 50) critChanceMonster += 10;
			if (rand(100) < critChanceMonster) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (findPerk(PerkLib.BouncyBody) >= 0 && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply damage resistance percentage.
			damage *= damagePercent() / 100;
			if (damageMultiplier < 0.2) damageMultiplier = 0;
			return int(damage * damageMultiplier);
		}

		public override function damageMagicalPercent():Number {
			var mult:Number = 100;
			var armorMMod:Number = armorMDef;
			//--BASE--
			mult -= armorMMod;
			//--PERKS--
			if (findPerk(PerkLib.NakedTruth) >= 0 && spe >= 75 && lib >= 60 && (armorName == "arcane bangles" || armorName == "practically indecent steel armor" || armorName == "revealing chainmail bikini" || armorName == "slutty swimwear" || armorName == "barely-decent bondage straps" || armorName == "nothing")) {
				mult -= 10;
			}
			//--STATUS AFFECTS--
			if (statusEffectv1(StatusEffects.OniRampage) > 0) {
				mult -= 20;
			}
			//Defend = 35-95% reduction
			if (hasStatusEffect(StatusEffects.Defend)) {
				if (findPerk(PerkLib.DefenceStance) >= 0 && tou >= 80) {
					if (findPerk(PerkLib.MasteredDefenceStance) >= 0 && tou >= 120) {
						if (findPerk(PerkLib.PerfectDefenceStance) >= 0 && tou >= 160) mult -= 95;
						else mult -= 70;
					}
					else mult -= 50;
				}
				else mult -= 35;
			}
			// Uma's Massage bonuses
			var sac:StatusEffectClass = statusEffectByType(StatusEffects.UmasMassage);
			if (sac && sac.value1 == UmasShop.MASSAGE_RELAXATION) {
				mult -= 100 * sac.value2;
			}
			//Caps damage reduction at 80/99%
			if (hasStatusEffect(StatusEffects.Defend) && findPerk(PerkLib.PerfectDefenceStance) >= 0 && tou >= 160 && mult < 1) mult = 1;
			if (!hasStatusEffect(StatusEffects.Defend) && mult < 20) mult = 20;
			return mult;
		}
		public override function takeMagicDamage(damage:Number, display:Boolean = false):Number {
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (hasStatusEffect(StatusEffects.ManaShield) && (damage / 2) < mana) {
					mana -= damage / 2;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('mana');
					dynStats("lus", 0); //Force display arrow.
				}
				else {
					damage = reduceMagicDamage(damage);
					//Wrath
					var gainedWrath:Number = 0;
					gainedWrath += (Math.round(damage / wrathRatioToHP())) * wrathFromHPmulti();
					wrath += gainedWrath;
					if (wrath > maxWrath()) wrath = maxWrath();
					//game.HPChange(-damage, display);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP < minHP()){
					HP = minHP();
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}
		public function reduceMagicDamage(damage:Number):Number {
			var magicdamageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) magicdamageMultiplier /= 2;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) magicdamageMultiplier *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) magicdamageMultiplier *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) magicdamageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) magicdamageMultiplier *= 2;
			//Opponents can critical too!
			var crit:Boolean = false;
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.findPerk(PerkLib.MagiculesTheory) >= 0 && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (findPerk(PerkLib.BouncyBody) >= 0 && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply magic damage resistance percentage.
			damage *= damageMagicalPercent() / 100;
			if (magicdamageMultiplier < 0.2) magicdamageMultiplier = 0;
			return int(damage * magicdamageMultiplier);
		}

		public override function damageFirePercent():Number {
			var mult:Number = damageMagicalPercent();
			if (findPerk(PerkLib.FromTheFrozenWaste) >= 0 || findPerk(PerkLib.ColdAffinity) >= 0) mult += 100;
			if (findPerk(PerkLib.FireAffinity) >= 0) mult -= 50;
			if (hasStatusEffect(StatusEffects.ShiraOfTheEastFoodBuff1) && (statusEffectv2(StatusEffects.ShiraOfTheEastFoodBuff1) > 0)) mult -= statusEffectv2(StatusEffects.ShiraOfTheEastFoodBuff1);
			if (jewelryEffectId == JewelryLib.MODIFIER_FIRE_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_FIRE_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_FIRE_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_FIRE_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == JewelryLib.MODIFIER_FIRE_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == JewelryLib.MODIFIER_FIRE_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_FIRE_R && jewelryEffectId2 == JewelryLib.MODIFIER_FIRE_R && jewelryEffectId3 == JewelryLib.MODIFIER_FIRE_R && jewelryEffectId4 == JewelryLib.MODIFIER_FIRE_R && headjewelryEffectId == JewelryLib.MODIFIER_FIRE_R && necklaceEffectId == JewelryLib.MODIFIER_FIRE_R) mult -= 15;
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeFireDamage(damage:Number, display:Boolean = false):Number {
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (hasStatusEffect(StatusEffects.ManaShield) && (damage / 2) < mana) {
					mana -= damage / 2;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('mana');
					dynStats("lus", 0); //Force display arrow.
				}
				else {
					damage = reduceFireDamage(damage);
					//Wrath
					var gainedWrath:Number = 0;
					gainedWrath += (Math.round(damage / wrathRatioToHP())) * wrathFromHPmulti();
					wrath += gainedWrath;
					if (wrath > maxWrath()) wrath = maxWrath();
					//game.HPChange(-damage, display);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					if (hasPerk(PerkLib.HydraRegeneration) && !hasStatusEffect(StatusEffects.HydraRegenerationDisabled)) {
						createStatusEffect(StatusEffects.HydraRegenerationDisabled, 0, 0, 0, 0);
						outputText(" <b>The fire damage you took suddenly weakened your ability to regenerate!</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP < minHP()){
					HP = minHP();
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}
		public function reduceFireDamage(damage:Number):Number {
			var firedamageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) firedamageMultiplier /= 2;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) firedamageMultiplier *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) firedamageMultiplier *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) firedamageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) firedamageMultiplier *= 2;
			//Opponents can critical too!
			var crit:Boolean = false;
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.findPerk(PerkLib.MagiculesTheory) >= 0 && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (findPerk(PerkLib.BouncyBody) >= 0 && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply fire damage resistance percentage.
			damage *= damageFirePercent() / 100;
			if (firedamageMultiplier < 0.2) firedamageMultiplier = 0;
			return int(damage * firedamageMultiplier);
		}

		public override function damageIcePercent():Number {
			var mult:Number = damageMagicalPercent();
			if (findPerk(PerkLib.FromTheFrozenWaste) >= 0 || findPerk(PerkLib.ColdAffinity) >= 0) mult -= 50;
			if (findPerk(PerkLib.IcyFlesh) >= 0) mult -= 40;
			if (findPerk(PerkLib.FireAffinity) >= 0) mult += 100;
			if (upperGarmentName == "Fur bikini top") mult -= 10;
			if (lowerGarmentName == "Fur loincloth" || lowerGarmentName == "Fur panty") mult -= 10;
			if (necklaceName == "Blue Winter scarf") mult -= 20;
			if (jewelryEffectId == JewelryLib.MODIFIER_ICE_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_ICE_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_ICE_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_ICE_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == JewelryLib.MODIFIER_ICE_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == JewelryLib.MODIFIER_ICE_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_ICE_R && jewelryEffectId2 == JewelryLib.MODIFIER_ICE_R && jewelryEffectId3 == JewelryLib.MODIFIER_ICE_R && jewelryEffectId4 == JewelryLib.MODIFIER_ICE_R && headjewelryEffectId == JewelryLib.MODIFIER_ICE_R && necklaceEffectId == JewelryLib.MODIFIER_ICE_R) mult -= 15;
			if (hasStatusEffect(StatusEffects.ShiraOfTheEastFoodBuff1) && (statusEffectv3(StatusEffects.ShiraOfTheEastFoodBuff1) > 0)) mult -= statusEffectv3(StatusEffects.ShiraOfTheEastFoodBuff1);
			if (hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
				if (mouseScore() >= 12 && arms.type == Arms.HINEZUMI && lowerBody == LowerBody.HINEZUMI && (jewelryName == "Infernal Mouse ring" || jewelryName2 == "Infernal Mouse ring" || jewelryName3 == "Infernal Mouse ring" || jewelryName4 == "Infernal Mouse ring")) mult += 90;
				else mult += 100;
			}
			if (rearBody.type == RearBody.YETI_FUR) mult -= 20;
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeIceDamage(damage:Number, display:Boolean = false):Number {
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (hasStatusEffect(StatusEffects.ManaShield) && (damage / 2) < mana) {
					mana -= damage / 2;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('mana');
					dynStats("lus", 0); //Force display arrow.
				}
				else {
					damage = reduceIceDamage(damage);
					//Wrath
					var gainedWrath:Number = 0;
					gainedWrath += (Math.round(damage / wrathRatioToHP())) * wrathFromHPmulti();
					wrath += gainedWrath;
					if (wrath > maxWrath()) wrath = maxWrath();
					//game.HPChange(-damage, display);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP < minHP()){
					HP = minHP();
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}
		public function reduceIceDamage(damage:Number):Number {
			var icedamageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) icedamageMultiplier /= 2;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) icedamageMultiplier *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) icedamageMultiplier *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) icedamageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) icedamageMultiplier *= 2;
			//Opponents can critical too!
			var crit:Boolean = false;
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.findPerk(PerkLib.MagiculesTheory) >= 0 && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (findPerk(PerkLib.BouncyBody) >= 0 && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply ice damage resistance percentage.
			damage *= damageIcePercent() / 100;
			if (icedamageMultiplier < 0.2) icedamageMultiplier = 0;
			return int(damage * icedamageMultiplier);
		}

		public override function damageLightningPercent():Number {
			var mult:Number = damageMagicalPercent();
			if (armorName == "Goblin Technomancer clothes") mult -= 25;
			if (upperGarmentName == "Technomancer bra") mult -= 15;
			if (lowerGarmentName == "Technomancer panties") mult -= 15;
			if (jewelryEffectId == JewelryLib.MODIFIER_LIGH_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_LIGH_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_LIGH_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_LIGH_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == JewelryLib.MODIFIER_LIGH_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == JewelryLib.MODIFIER_LIGH_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_LIGH_R && jewelryEffectId2 == JewelryLib.MODIFIER_LIGH_R && jewelryEffectId3 == JewelryLib.MODIFIER_LIGH_R && jewelryEffectId4 == JewelryLib.MODIFIER_LIGH_R && headjewelryEffectId == JewelryLib.MODIFIER_LIGH_R && necklaceEffectId == JewelryLib.MODIFIER_LIGH_R) mult -= 15;
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeLightningDamage(damage:Number, display:Boolean = false):Number {
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (hasStatusEffect(StatusEffects.ManaShield) && (damage / 2) < mana) {
					mana -= damage / 2;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('mana');
					dynStats("lus", 0); //Force display arrow.
				}
				else {
					damage = reduceLightningDamage(damage);
					//Wrath
					var gainedWrath:Number = 0;
					gainedWrath += (Math.round(damage / wrathRatioToHP())) * wrathFromHPmulti();
					wrath += gainedWrath;
					if (wrath > maxWrath()) wrath = maxWrath();
					//game.HPChange(-damage, display);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP < minHP()){
					HP = minHP();
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}
		public function reduceLightningDamage(damage:Number):Number {
			var lightningdamageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) lightningdamageMultiplier /= 2;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) lightningdamageMultiplier *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) lightningdamageMultiplier *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) lightningdamageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) lightningdamageMultiplier *= 2;
			//Opponents can critical too!
			var crit:Boolean = false;
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.findPerk(PerkLib.MagiculesTheory) >= 0 && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (findPerk(PerkLib.BouncyBody) >= 0 && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply lightning damage resistance percentage.
			damage *= damageLightningPercent() / 100;
			if (lightningdamageMultiplier < 0.2) lightningdamageMultiplier = 0;
			return int(damage * lightningdamageMultiplier);
		}

		public override function damageDarknessPercent():Number {
			var mult:Number = damageMagicalPercent();
			if (jewelryEffectId == JewelryLib.MODIFIER_DARK_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_DARK_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_DARK_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_DARK_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == JewelryLib.MODIFIER_DARK_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == JewelryLib.MODIFIER_DARK_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_DARK_R && jewelryEffectId2 == JewelryLib.MODIFIER_DARK_R && jewelryEffectId3 == JewelryLib.MODIFIER_DARK_R && jewelryEffectId4 == JewelryLib.MODIFIER_DARK_R && headjewelryEffectId == JewelryLib.MODIFIER_DARK_R && necklaceEffectId == JewelryLib.MODIFIER_DARK_R) mult -= 15;
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takeDarknessDamage(damage:Number, display:Boolean = false):Number {
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (hasStatusEffect(StatusEffects.ManaShield) && (damage / 2) < mana) {
					mana -= damage / 2;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('mana');
					dynStats("lus", 0); //Force display arrow.
				}
				else {
					damage = reduceDarknessDamage(damage);
					//Wrath
					var gainedWrath:Number = 0;
					gainedWrath += (Math.round(damage / wrathRatioToHP())) * wrathFromHPmulti();
					wrath += gainedWrath;
					if (wrath > maxWrath()) wrath = maxWrath();
					//game.HPChange(-damage, display);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP < minHP()){
					HP = minHP();
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}
		public function reduceDarknessDamage(damage:Number):Number {
			var darknessdamageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) darknessdamageMultiplier /= 2;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) darknessdamageMultiplier *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) darknessdamageMultiplier *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) darknessdamageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) darknessdamageMultiplier *= 2;
			//Opponents can critical too!
			var crit:Boolean = false;
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.findPerk(PerkLib.MagiculesTheory) >= 0 && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (findPerk(PerkLib.BouncyBody) >= 0 && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply darkness damage resistance percentage.
			damage *= damageDarknessPercent() / 100;
			if (darknessdamageMultiplier < 0.2) darknessdamageMultiplier = 0;
			return int(damage * darknessdamageMultiplier);
		}

		public override function damagePoisonPercent():Number {
			var mult:Number = damageMagicalPercent();
			if (findPerk(PerkLib.VenomGlandsEvolved) >= 0) mult -= 5;
			if (findPerk(PerkLib.VenomGlandsFinalForm) >= 0) mult -= 10;
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R) mult -= jewelryEffectMagnitude4;
			if (headjewelryEffectId == JewelryLib.MODIFIER_POIS_R) mult -= headjewelryEffectMagnitude;
			if (necklaceEffectId == JewelryLib.MODIFIER_POIS_R) mult -= necklaceEffectMagnitude;
			if (jewelryEffectId == JewelryLib.MODIFIER_POIS_R && jewelryEffectId2 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId3 == JewelryLib.MODIFIER_POIS_R && jewelryEffectId4 == JewelryLib.MODIFIER_POIS_R && headjewelryEffectId == JewelryLib.MODIFIER_POIS_R && necklaceEffectId == JewelryLib.MODIFIER_POIS_R) mult -= 15;
			//Caps damage reduction at 100%
			if (mult < 0) mult = 0;
			return mult;
		}
		public override function takePoisonDamage(damage:Number, display:Boolean = false):Number {
			//Round
			damage = Math.round(damage);
			// we return "1 damage received" if it is in (0..1) but deduce no HP
			var returnDamage:int = (damage>0 && damage<1)?1:damage;
			if (damage>0){
				if (hasStatusEffect(StatusEffects.ManaShield) && (damage / 2) < mana) {
					mana -= damage / 2;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">Absorbed " + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">Absorbed " + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('mana');
					dynStats("lus", 0); //Force display arrow.
				}
				else {
					damage = reducePoisonDamage(damage);
					//Wrath
					var gainedWrath:Number = 0;
					gainedWrath += (Math.round(damage / wrathRatioToHP())) * wrathFromHPmulti();
					wrath += gainedWrath;
					if (wrath > maxWrath()) wrath = maxWrath();
					//game.HPChange(-damage, display);
					HP -= damage;
					if (display) {
						if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
						else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>");
					}
					game.mainView.statsView.showStatDown('hp');
					dynStats("lus", 0); //Force display arrow.
				}
				if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
					dynStats("lus", int(damage / 2));
				}
				//Prevent negatives
				if (HP < minHP()){
					HP = minHP();
					//This call did nothing. There is no event 5010: if (game.inCombat) game.doNext(5010);
				}
			}
			return returnDamage;
		}
		public function reducePoisonDamage(damage:Number):Number {
			var poisondamageMultiplier:Number = 1;
			//EZ MOAD half damage
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) poisondamageMultiplier /= 2;
			//Difficulty modifier flags.
			if (flags[kFLAGS.GAME_DIFFICULTY] == 1) poisondamageMultiplier *= 1.15;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) poisondamageMultiplier *= 1.3;
			else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) poisondamageMultiplier *= 1.5;
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) poisondamageMultiplier *= 2;
			//Opponents can critical too!
			var crit:Boolean = false;
			var critChanceMonster:int = 5;
			if (CoC.instance.monster.findPerk(PerkLib.MagiculesTheory) >= 0 && CoC.instance.monster.wis >= 50) {
				if (CoC.instance.monster.wis <= 100) critChanceMonster += (CoC.instance.monster.wis - 50) / 5;
				if (CoC.instance.monster.wis > 100) critChanceMonster += 10;
			}
			if (rand(100) < critChanceMonster) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (hasStatusEffect(StatusEffects.Shielding)) {
				damage -= 30;
				if (damage < 1) damage = 1;
			}
			if (findPerk(PerkLib.BouncyBody) >= 0 && damage > (maxHP() * 0.5)) {
				var dr:Number = damage * bouncybodyDR();
				damage -= dr;
				damage = Math.round(damage);
			}
			//Apply poison damage resistance percentage.
			damage *= damagePoisonPercent() / 100;
			if (poisondamageMultiplier < 0.2) poisondamageMultiplier = 0;
			return int(damage * poisondamageMultiplier);
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
				if (tone > 150)
					desc += "a lithe body covered in highly visible muscles";
				else if (tone > 100)
					desc += "a lithe body covered in highly visible muscles";
				else if (tone > 90)
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
				if (tone > 150)
					desc += "a thin body and incredible muscle definition";
				else if (tone > 100)
					desc += "a thin body and incredible muscle definition";
				else if (tone > 90)
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
				if (tone > 150)
					desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 100)
					desc += "a fit, somewhat thin body and rippling muscles all over";
				else if (tone > 90)
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
				if (tone > 150)
					desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 100)
					desc += "average thickness and a bevy of perfectly defined muscles";
				else if (tone > 90)
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
				if (tone > 150)
					desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 100)
					desc += "a somewhat thick body that's covered in slabs of muscle";
				else if (tone > 90)
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
				if (tone > 150)
					desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 100)
					desc += "a thickset frame that gives you the appearance of a wall of muscle";
				else if (tone > 90)
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
					if (gender >= 2 || biggestTitSize() > 3 || hips.type > 7 || butt.type > 7)
						desc += " and plenty of jiggle on your curves";
				}
			}
			//Chunky monkey
			else
			{
				if (tone > 150)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 100)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 90)
					desc += "an extremely thickset frame and so much muscle others would find you harder to move than a huge boulder";
				else if (tone > 75)
					desc += "a very wide body and enough muscle to make you look like a tank";
				else if (tone > 50)
					desc += "an extremely substantial frame packing a decent amount of muscle";
				else if (tone > 25)
				{
					desc += "a very wide body";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += ", lots of curvy jiggles,";
					desc += " and hints of muscle underneath";
				}
				else
				{
					desc += "a thick";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += ", voluptuous";
					desc += " body and plush, ";
					if (gender >= 2 || biggestTitSize() > 4 || hips.type > 10 || butt.type > 10)
						desc += " jiggly curves";
					else
						desc += " soft flesh";
				}
			}
			return desc;
		}

		//Camp Development Stage
		public function campDevelopmentStage():String
		{
			var descC:String = "";
			if (hasStatusEffect(StatusEffects.AdvancingCamp)) {
				/*if (statusEffectv1(StatusEffects.AdvancingCamp) ) descC = "city";
				else if (statusEffectv1(StatusEffects.AdvancingCamp) =) descC = "town";
				else if (statusEffectv1(StatusEffects.AdvancingCamp) ==) descC = "village";
				else */descC = "hamlet";
			}
			else descC = "camp";
			return descC;
		}

		public function race():String
		{
			//Determine race type:
			var race:String = "human";
			if (catScore() >= 4)
			{
				if (catScore() >= 8) {
					if (isTaur() && lowerBody == LowerBody.CAT) {
						race = "cat-taur";
					}
					else {
						race = "cat-morph";
						if (faceType == Face.HUMAN)
							race = "cat-" + mf("boy", "girl");
					}
				}
				else {
					if (isTaur() && lowerBody == LowerBody.CAT) {
						race = "half cat-taur";
						if (faceType == Face.HUMAN)
							race = "half sphinx-morph"; // no way to be fully feral anyway
					}
					else {
						race = " half cat-morph";
						if (faceType == Face.HUMAN)
							race = "half cat-" + mf("boy", "girl");
					}
				}
			}
			if (nekomataScore() >= 10)
			{
				if (tailType == 8 && tailCount >= 2 && nekomataScore() >= 12) race = "elder nekomata";
				else race = "nekomata";
			}
			if (cheshireScore() >= 11)
			{
				race = "cheshire cat";
			}
			if (hellcatScore() >= 10)
			{
				race = "hellcat";
			}
			if (displacerbeastScore() >= 14)
			{
				race = "displacer beast";
			}
			if (sphinxScore() >= 14)
			{
				race = "sphinx";
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
				if (dragonScore() >= 28) {
					if (isTaur()) race = "ancient dragon-taur";
					else {
						race = "ancient dragon";
						if (faceType == Face.HUMAN)
							race = "ancient dragon-" + mf("man", "girl");
					}
				}
				else if (dragonScore() >= 20) {
					if (isTaur()) race = " elder dragon-taur";
					else {
						race = "elder dragon";
						if (faceType == Face.HUMAN)
							race = "elder dragon-" + mf("man", "girl");
					}
				}
				else if (dragonScore() >= 10) {
					if (isTaur()) race = "dragon-taur";
					else {
						race = "dragon";
						if (faceType == Face.HUMAN)
							race = "dragon-" + mf("man", "girl");
					}
				}
				else {
					if (isTaur()) race = "half-dragon-taur";
					else {
						race = "half-dragon";
						if (faceType == Face.HUMAN)
							race = "half-dragon-" + mf("man", "girl");
					}
				}
			}
			if (jabberwockyScore() >= 10)
			{
				if (jabberwockyScore() >= 20) {
					if (isTaur()) race = "greater jabberwocky-taur";
					else race = "greater jabberwocky";
				}
				else {
					if (isTaur()) race = "jabberwocky-taur";
					else race = "jabberwocky";
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
				if (isTaur() && lowerBody == LowerBody.DOG)
					race = "dog-taur";
				else {
					race = "dog-morph";
					if (faceType == Face.HUMAN)
						race = "dog-" + mf("man", "girl");
				}
			}
			if (wolfScore() >= 4)
			{
				if (isTaur() && lowerBody == LowerBody.WOLF)
					race = "wolf-taur";
				else if (wolfScore() >= 10)
					race = "Fenrir";
				else if (wolfScore() >= 7 && hasFur() && coatColor == "glacial white")
					race = "winter wolf";
				else if (wolfScore() >= 6)
					race = "wolf-morph";
				else
					race = "wolf-" + mf("boy", "girl");
			}
			if (werewolfScore() >= 12)
			{
				//if (werewolfScore() >= 12)
				//	race = "Werewolf";
				//else
					race = "Werewolf";
			}
			if (foxScore() >= 4)
			{
				if (foxScore() >= 7 && isTaur() && lowerBody == LowerBody.FOX)
					race = "fox-taur";
				else if (foxScore() >= 7)
					race = "fox-morph";
				else
					race = "half fox";
			}
			if (ferretScore() >= 4)
			{
				if (hasFur())
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
			if (horseScore() >= 4)
			{
				if (horseScore() >= 7)
					race = "equine-morph";
				else
					race = "half equine-morph";
			}
			if (unicornScore() >= 10)
			{
				if (horns.type == Horns.UNICORN) {
					if (isTaur()) race = "unicorn-taur";
					else {
						race = "unicorn";
					}
				}
				else {
					if (isTaur()) race = "bicorn-taur";
					else {
						race = "bicorn";
					}
				}
			}
			if (alicornScore() >= 12)
			{
				if (horns.type == Horns.UNICORN) {
					if (isTaur()) race = "alicorn-taur";
					else {
						race = "alicorn";
					}
				}
				else {
					if (isTaur()) race = "nightmare-taur";
					else {
						race = "nightmare";
					}
				}
			}
			if (centaurScore() >= 8)
				race = "centaur";
			if (mutantScore() >= 5 && race == "human")
				race = "corrupted mutant";
			if (minotaurScore() >= 4)
				if (minotaurScore() >= 9) race = "minotaur";
				else race = "half-minotaur";
			if (cowScore() >= 4)
			{
				if (cowScore() >= 9) {
					race = "cow-";
					race += mf("morph", "girl");
				}
				else {
					race = "half cow-";
					race += mf("morph", "girl");
				}
			}
			if (beeScore() >= 5) {
				if (beeScore() >= 9) {
					race = "bee-morph";
				}
				else {
					race = "half bee-morph";
				}
			}
			if (goblinScore() >= 10)
				race = "goblin";
			if (humanScore() >= 5 && race == "corrupted mutant")
				race = "somewhat human mutant";
			if (demonScore() >= 5)
			{
				if (demonScore() >= 16 && hasStatusEffect(StatusEffects.PlayerPhylactery)) {
					if (isTaur()) {
						race = "";
						race += mf("incubi-taur", "succubi-taur");
					}
					else {
						race = "";
						race += mf("incubus", "succubus");
					}
				}
				else if (demonScore() >= 11) {
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
			if (devilkinScore() >= 7)
			{
				if (devilkinScore() >= 11) {
					if (devilkinScore() >= 16 && hasStatusEffect(StatusEffects.PlayerPhylactery))  {
						if (devilkinScore() >= 21) {
							if (isTaur()) race = "archdevil-taur";
							else race = "archdevil";
						}
						else {
							if (isTaur()) race = "devil-taur";
							else race = "devil";
						}
					}
					else {
						if (isTaur()) race = "devilkin-taur";
						else race = "devilkin";
					}
				}
				else {
					if (isTaur()) race = "half fiend-taur";
					else race = "half fiend";
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
			if (bunnyScore() >= 5)
			{
				if (bunnyScore() >= 10) race = "bunny-" + mf("boy", "girl");
				else race = "half bunny-" + mf("boy", "girl");
			}
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
			if (mouseScore() >= 4)
			{
				if (mouseScore() >= 12 && arms.type == Arms.HINEZUMI && lowerBody == LowerBody.HINEZUMI) {
					if (isTaur()) race = "hinezumi-taur";
					race = "hinezumi";
				}
				else if (mouseScore() >= 8) {
					if (isTaur()) race = "mouse-taur";
					race = "mouse-morph";
				}
				else {
					if (isTaur()) race = "mouse-" + mf("boy", "girl") + "-taur";
					else race = "mouse-" + mf("boy", "girl");
				}
			}
			if (scorpionScore() >= 4)
			{
				if (isTaur()) race = "scorpion-taur";
				else {
					race = "scorpion-morph";
				}
			}
			if (mantisScore() >= 6)
			{
				if (mantisScore() >= 12) {
					if (isTaur()) race = "mantis-taur";
					else {
						race = "mantis-morph";
					}
				}
				else {
					if (isTaur()) race = "half mantis-taur";
					else {
						race = "half mantis-morph";
					}
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
			if (cavewyrmScore() >= 5)
			{
				if (cavewyrmScore() >= 10) {
					if (isTaur()) race = "cave wyrm-taur";
					else race = "cave wyrm";
				}
				else {
					if (isTaur()) race = "half cave wyrm-taur";
					else race = "half cave wyrm";
				}
			}
			if (yetiScore() >= 7)
			{
				if (yetiScore() >= 14) {
					if (isTaur()) race = "yeti-taur";
					else race = "yeti";
				}
				else {
					if (isTaur()) race = "half yeti-taur";
					else race = "half yeti";
				}
			}
			if (yukiOnnaScore() >= 14)
			{
				race = "Yuki Onna";
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
			if (lowerBody == 51 && hydraScore() >= 14)
			{
				if (hydraScore() >= 29) race = "legendary hydra";
				else if (hydraScore() >= 24) race = "ancient hydra";
				else if (hydraScore() >= 19) race = "greater hydra";
				else race = "hydra";
			}
			if (lowerBody == 3 && nagaScore() >= 4)
			{
				if (nagaScore() >= 8) race = "naga";
				else race = "half-naga";
			}
			if (firesnailScore() >= 15)
			{
				race = "fire snail";
			}
			if (phoenixScore() >= 10)
			{
				if (isTaur()) race = "phoenix-taur";
				else race = "phoenix";
			}
			if (scyllaScore() >= 4)
			{
				if (scyllaScore() >= 12) race = "kraken";
				else if (scyllaScore() >= 7) race = "scylla";
				else race = "half scylla";
			}
			if (plantScore() >= 4)
			{
				if (isTaur()) {
					if (plantScore() >= 6) race = mf("treant-taur", "dryad-taur");
					else race = "plant-taur";
				}
				else {
					if (plantScore() >= 6) race = mf("treant", "dryad");
					else race = "plant-morph";
				}
			}
			if (alrauneScore() >= 10)
			{
				race = "Alraune";
			}
			if (yggdrasilScore() >= 10)
			{
				race = "Yggdrasil";
			}
			if (oniScore() >= 6)
			{
				if (oniScore() >= 12) {
					if (isTaur()) race = "oni-taur";
					else race = "oni";
				}
				else {
					if (isTaur()) race = "half oni-taur";
					else race = "half oni";
				}
			}
			if (elfScore() >= 5)
			{
				if (elfScore() >= 11) {
					if (isTaur()) race = "elf-taur";
					else race = "elf";
				}
				else {
					if (isTaur()) race = "half elf-taur";
					else race = "half elf";
				}
			}
			if (orcScore() >= 5) {
				if (orcScore() >= 11) {
					if (isTaur()) race = "orc-taur";
					else race = "orc";
				}
				else {
					if (isTaur()) race = "half orc-taur";
					else race = "half orc";
				}
			}
			if (raijuScore() >= 5)
			{
				if (raijuScore() >= 10) {
					if (isTaur()) race = "raiju-taur";
					else race = "raiju";
				}
				else {
					if (isTaur()) race = "half raiju-taur";
					else race = "half raiju";
				}
			}
			if (thunderbirdScore() >= 12)
			{
				race = "Thunderbird";
			}
			//<mod>
			if (pigScore() >= 5) 
			{
				if (pigScore() >= 15) {
					race = "boar-morph";
				}
				else if (pigScore() >= 10) {
					race = "pig-morph";
				}
				else {
					race = "half pig-morph";
				}
			}
			if (satyrScore() >= 4)
			{
				race = "satyr";
			}
			if (rhinoScore() >= 4)
			{
				race = "rhino-morph";
				if (faceType == Face.HUMAN) race = "rhino-" + mf("man", "girl");
			}
			if (echidnaScore() >= 4)
			{
				race = "echidna";
				if (faceType == Face.HUMAN) race = "echidna-" + mf("boy", "girl");
			}
			if (deerScore() >= 4)
			{
				if (isTaur()) race = "deer-taur";
				else {
					race = "deer-morph";
					if (faceType == Face.HUMAN) race = "deer-" + mf("morph", "girl");
				}
			}
			//Special, bizarre races
			if (dragonneScore() >= 6)
			{
				if (isTaur()) race = "dragonne-taur";
				else {
					race  = "dragonne";
					if (faceType == Face.HUMAN)
						race = "dragonne-" + mf("man", "girl");
				}
			}
			if (manticoreScore() >= 6)
			{
				if (isTaur() && lowerBody == LowerBody.LION) {
					if (manticoreScore() < 12)
						race = "half manticore-taur";
					if (manticoreScore() >= 12)
						race = "manticore-taur";
				}
				else if (manticoreScore() >= 12)
					race = "manticore";
				else
					race = "half manticore";
			}
			if (redpandaScore() >= 4)
			{
				if (redpandaScore() >= 8) {
					race = "red-panda-morph";
					if (faceType == Face.HUMAN)
						race = "red-panda-" + mf("boy", "girl");
					if (isTaur())
						race = "red-panda-taur";
				}
				else {
					race = "half red-panda-morph";
					if (faceType == Face.HUMAN)
						race = "half red-panda-" + mf("boy", "girl");
					if (isTaur())
						race = "half red-panda-taur";
				}
			}
			if (bearpandaScore() >= 5)
			{
				if (bearpandaScore() >= 10) {
					if (faceType == Face.PANDA) race = "panda-morph";
					else race = "bear-morph";
				}
				else {
					if (faceType == Face.PANDA) race = "half panda-morph";
					else race = "half bear-morph";
				}
			}
			if (sirenScore() >= 10)
			{
				if (isTaur()) race = "siren-taur";
				else race = "siren";
			}
			if (gargoyleScore() >= 20)
			{
				if (hasPerk(PerkLib.GargoylePure)) race = "pure gargoyle";
				else race = "corrupted gargoyle";
			}
			if (batScore() >= 6){
				race = batScore() >= 10? "bat":"half bat";
				race += mf("boy","girl");
			}
			if (vampireScore() >= 6){
				race = vampireScore() >= 10 ? "vampire" : "dhampir"
			}
			if (avianScore() >= 4)
			{
				if (avianScore() >= 9)
					race = "avian-morph";
				else
					race = "half avian-morph";
			}
			if (poltergeistScore() >= 6) {
				if (poltergeistScore() >= 18) race = "eldritch poltergeist";
				else if (poltergeistScore() >= 12) race = "poltergeist";
				else race = "phantom";
			}
			//</mod>
			if (lowerBody == LowerBody.HOOFED && isTaur() && wings.type == Wings.FEATHERED_LARGE) {
				race = "pegataur";
			}
			if (lowerBody == LowerBody.PONY)
				race = "pony-kin";
			if (gooScore() >= 5)
			{
				if (gooScore() >= 15) race = "slime queen";
				else if (gooScore() >= 11) {
					race = "slime ";
					race += mf("boi", "girl");
				}
				else {
					race = "half slime ";
					race += mf("boi", "girl");
				}
			}
			if (magmagooScore() >= 6)
			{
				if (magmagooScore() >= 17) race = "magma slime queen";
				else if (magmagooScore() >= 13) {
					race = "magma slime ";
					race += mf("boi", "girl");
				}
				else {
					race = "half magma slime ";
					race += mf("boi", "girl");
				}
			}
			if (darkgooScore() >= 6)
			{
				if (darkgooScore() >= 17) race = "dark slime queen";
				else if (darkgooScore() >= 13) {
					race = "dark slime ";
					race += mf("boi", "girl");
				}
				else {
					race = "half dark slime ";
					race += mf("boi", "girl");
				}
			}
			
			if (jiangshiScore() >= 20)
			{
				race = "Jiangshi";
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
		public function humanScore():Number {
			Begin("Player","racialScore","human");
			var humanCounter:Number = 0;
			if (hasPlainSkinOnly() && skinTone != "slippery")
				humanCounter++;
			if (hairType == Hair.NORMAL)
				humanCounter++;
			if (faceType == Face.HUMAN)
				humanCounter++;
			if (eyes.type == Eyes.HUMAN)
				humanCounter++;
			if (ears.type == Ears.HUMAN)
				humanCounter++;
			if (ears.type == Ears.ELVEN)
				humanCounter -= 7;
			if (tongue.type == 0)
				humanCounter++;
			if (gills.type == 0)
				humanCounter++;
			if (antennae.type == 0)
				humanCounter++;
			if (horns.count == 0)
				humanCounter++;
			if (wings.type == Wings.NONE)
				humanCounter++;
			if (tailType == 0)
				humanCounter++;
			if (arms.type == Arms.HUMAN)
				humanCounter++;
			if (lowerBody == LowerBody.HUMAN)
				humanCounter++;
			if (rearBody.type == RearBody.NONE)
				humanCounter++;
			if (normalCocks() >= 1 || (hasVagina() && vaginaType() == 0))
				humanCounter++;
			if (breastRows.length == 1 && hasPlainSkinOnly() && skinTone != "slippery")
				humanCounter++;
			if (skin.base.pattern == Skin.PATTERN_NONE)
				humanCounter++;
			humanCounter += (65 - internalChimeraScore());
			if (isGargoyle()) humanCounter = 0;
			End("Player","racialScore");
			return humanCounter;
		}
		public function humanMaxScore():Number {
			var humanMaxCounter:Number = 82;//17 + 65 z perków mutacyjnych (każdy nowy mutation perk wpisywać też do TempleOfTheDivine.as we fragmencie o zostaniu Gargoyle)
			return humanMaxCounter;
		}
		
		//Determine Inner Chimera Rating
		public function internalChimeraRating():Number {
			Begin("Player","racialScore","internalChimeraRating");
			var internalChimeraRatingCounter:Number = 0;
			if (internalChimeraScore() > 0)
				internalChimeraRatingCounter += internalChimeraScore();
			if (findPerk(PerkLib.ChimericalBodyInitialStage) >= 0)
				internalChimeraRatingCounter -= 2;//	 2
			if (findPerk(PerkLib.ChimericalBodySemiBasicStage) >= 0)
				internalChimeraRatingCounter -= 3;//	 5
			if (findPerk(PerkLib.ChimericalBodyBasicStage) >= 0)
				internalChimeraRatingCounter -= 4;//	 9
			if (findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				internalChimeraRatingCounter -= 5;//	14
			if (findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0)
				internalChimeraRatingCounter -= 6;//	20
			if (findPerk(PerkLib.ChimericalBodySemiSuperiorStage) >= 0)
				internalChimeraRatingCounter -= 7;//	27
			if (findPerk(PerkLib.ChimericalBodySuperiorStage) >= 0)
				internalChimeraRatingCounter -= 8;//	35
			if (findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				internalChimeraRatingCounter -= 9;//	44
			if (findPerk(PerkLib.ChimericalBodyPeerlessStage) >= 0)
				internalChimeraRatingCounter -= 10;//	54
			if (findPerk(PerkLib.ChimericalBodySemiEpicStage) >= 0)
				internalChimeraRatingCounter -= 11;//	65
			if (findPerk(PerkLib.ChimericalBodyEpicStage) >= 0)
				internalChimeraRatingCounter -= 12;//	77	90	104	119	135(potem legendary/mythical stages?)
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				internalChimeraRatingCounter -= 18;
			End("Player","racialScore");
			return internalChimeraRatingCounter;
		}//każdy nowy chimerical body perk wpisywać też do TempleOfTheDivine.as we fragmencie o zostaniu Gargoyle
		
		//Determine Inner Chimera Score
		public function internalChimeraScore():Number {
			Begin("Player","racialScore","internalChimeraScore");
			var internalChimeraCounter:Number = 0;
			if (findPerk(PerkLib.BlackHeart) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.BlackHeartEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.BlackHeartFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.DraconicLungs) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.DraconicLungsEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.DraconicLungsFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.ElvishPeripheralNervSys) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.ElvishPeripheralNervSysEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.ElvishPeripheralNervSysFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.FrozenHeart) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.FrozenHeartEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.FrozenHeartFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.GorgonsEyes) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.GorgonsEyesEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.HinezumiBurningBlood) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.HinezumiBurningBloodEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.HinezumiBurningBloodFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.HollowFangs) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.HollowFangsEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.HollowFangsFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGland) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGlandFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.LactaBovinaOvaries) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.LactaBovinaOvariesEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.LactaBovinaOvariesFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.LizanMarrow) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.LizanMarrowEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.ManticoreMetabolism) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.ManticoreMetabolismEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.MantislikeAgility) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.MantislikeAgilityEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.MinotaurTesticles) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.MinotaurTesticlesEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.MinotaurTesticlesFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.NaturalPunchingBag) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.NaturalPunchingBagEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.NaturalPunchingBagFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.ObsidianHeart) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.ObsidianHeartEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.ObsidianHeartFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.OniMusculature) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.OniMusculatureEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.OniMusculatureFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.OrcAdrenalGlands) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.OrcAdrenalGlandsEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.OrcAdrenalGlandsFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.PigBoarFat) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.PigBoarFatEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.PigBoarFatFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlands) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlandsEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlandsFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.ScyllaInkGlands) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.TrachealSystem) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.TrachealSystemEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.TrachealSystemFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.VampiricBloodsteam) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.VampiricBloodsteamEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.VampiricBloodsteamFinalForm) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.VenomGlands) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.VenomGlandsEvolved) >= 0)
				internalChimeraCounter++;
			if (findPerk(PerkLib.VenomGlandsFinalForm) >= 0)
				internalChimeraCounter++;
			
			End("Player","racialScore");
			return internalChimeraCounter;
		}
		
		//Determine Chimera Race Rating
		public function chimeraScore():Number {
			Begin("Player","racialScore","chimera");
			var chimeraCounter:Number = 0;
			if (catScore() >= 8)
				chimeraCounter++;
			if (nekomataScore() >= 12)
				chimeraCounter++;
			if (cheshireScore() >= 11)
				chimeraCounter++;
			if (hellcatScore() >= 10)
				chimeraCounter++;
			if (displacerbeastScore() >= 14)
				chimeraCounter++;
			if (lizardScore() >= 8)
				chimeraCounter++;
			if (dragonScore() >= 10)
				chimeraCounter++;
/*			if (raccoonScore() >= 4)
				chimeraCounter++;
			if (dogScore() >= 4)
				chimeraCounter++;
			if (wolfScore() >= 6)
				chimeraCounter++;
*/			if (werewolfScore() >= 12)
				chimeraCounter++;
			if (foxScore() >= 7)
				chimeraCounter++;
//			if (ferretScore() >= 4)
//				chimeraCounter++;
			if (kitsuneScore() >= 6 && tailType == 13 && tailCount >= 2)
				chimeraCounter++;	
			if (horseScore() >= 7)
				chimeraCounter++;
			if (unicornScore() >= 10)
				chimeraCounter++;
			if (alicornScore() >= 12)
				chimeraCounter++;	
			if (centaurScore() >= 8)
				chimeraCounter++;
			if (minotaurScore() >= 9)
				chimeraCounter++;
			if (cowScore() >= 9)
				chimeraCounter++;
			if (beeScore() >= 9)
				chimeraCounter++;
			if (goblinScore() >= 10)
				chimeraCounter++;
			if (demonScore() >= 11)
				chimeraCounter++;
			if (devilkinScore() >= 11)
				chimeraCounter++;
			if (sharkScore() >= 8)
				chimeraCounter++;
			if (orcaScore() >= 12)
				chimeraCounter++;
			if (oniScore() >= 12)
				chimeraCounter++;
			if (elfScore() >= 11)
				chimeraCounter++;
			if (orcScore() >= 11)
				chimeraCounter++;
			if (raijuScore() >= 10)
				chimeraCounter++;
			if (thunderbirdScore() >= 12)
				chimeraCounter++;
			if (bunnyScore() >= 10)
				chimeraCounter++;
			if (harpyScore() >= 8)
				chimeraCounter++;
			if (spiderScore() >= 7)
				chimeraCounter++;
//			if (kangaScore() >= 4)
//				chimeraCounter++;
			if (mouseScore() >= 8)
				chimeraCounter++;
//			if (scorpionScore() >= 4)
//				chimeraCounter++;
			if (mantisScore() >= 12)
				chimeraCounter++;
			if (salamanderScore() >= 7)
				chimeraCounter++;
			if (cavewyrmScore() >= 10)
				chimeraCounter++;
			if (nagaScore() >= 8)
				chimeraCounter++;
			if (gorgonScore() >= 11)
				chimeraCounter++;
			if (vouivreScore() >= 11)
				chimeraCounter++;
			if (couatlScore() >= 11)
				chimeraCounter++;
			if (lowerBody == 51 && hydraScore() >= 14)
				chimeraCounter++;
			if (firesnailScore() >= 15)
				chimeraCounter++;
			if (phoenixScore() >= 10)
				chimeraCounter++;
			if (scyllaScore() >= 7)
				chimeraCounter++;
//			if (plantScore() >= 6)
//				chimeraCounter++;
			if (alrauneScore() >= 10)
				chimeraCounter++;
			if (yggdrasilScore() >= 10)
				chimeraCounter++;
			if (pigScore() >= 10)
				chimeraCounter++;
/*			if (satyrScore() >= 4)
				chimeraCounter++;
			if (rhinoScore() >= 4)
				chimeraCounter++;
			if (echidnaScore() >= 4)
				chimeraCounter++;
			if (deerScore() >= 4)
				chimeraCounter++;
*/			if (manticoreScore() >= 12)
				chimeraCounter += 2;
			if (redpandaScore() >= 8)
				chimeraCounter++;
			if (bearpandaScore() >= 10)
				chimeraCounter++;
			if (sirenScore() >= 10)
				chimeraCounter++;
			if (yetiScore() >= 14)
				chimeraCounter++;
			if (yukiOnnaScore() >= 14)
				chimeraCounter++;
			if (batScore() >= 10)
				chimeraCounter++;
			if (vampireScore() >= 10)
				chimeraCounter++;
			if (jabberwockyScore() >= 10)
				chimeraCounter++;	
			if (avianScore() >= 9)
				chimeraCounter++;
			if (gargoyleScore() >= 20)
				chimeraCounter++;
			if (gooScore() >= 11)
				chimeraCounter++;
			if (magmagooScore() >= 13)
				chimeraCounter++;
			if (darkgooScore() >= 13)
				chimeraCounter++;
			
			End("Player","racialScore");
			return chimeraCounter;
		}
		
		//Determine Grand Chimera Race Rating
		public function grandchimeraScore():Number {
			Begin("Player","racialScore","grandchimera");
			var grandchimeraCounter:Number = 0;
			if (dragonScore() >= 20)
				grandchimeraCounter++;
			if (jabberwockyScore() >= 20)
				grandchimeraCounter++;
			if (wolfScore() >= 10)
				grandchimeraCounter++;
//			if (werewolfScore() >= 12)
//				grandchimeraCounter++;
			if (foxScore() >= 7)
				grandchimeraCounter++;
			if (ferretScore() >= 4)
				grandchimeraCounter++;
			if (kitsuneScore() >= 12 && tailType == 13 && tailCount == 9)
				grandchimeraCounter++;	
			if (demonScore() >= 16 && hasStatusEffect(StatusEffects.PlayerPhylactery))
				grandchimeraCounter++;
			if (devilkinScore() >= 16 && hasStatusEffect(StatusEffects.PlayerPhylactery))
				grandchimeraCounter++;
			if (sharkScore() >= 9 && vaginas.length > 0 && cocks.length > 0)
				grandchimeraCounter++;
			if (lowerBody == 51 && hydraScore() >= 19)
				grandchimeraCounter++;
/*			if (oniScore() >= 12)
				grandchimeraCounter++;
			if (elfScore() >= 11)
				grandchimeraCounter++;
			if (orcScore() >= 11)
				grandchimeraCounter++;
*/			if (mouseScore() >= 12 && arms.type == Arms.HINEZUMI && lowerBody == LowerBody.HINEZUMI)
				grandchimeraCounter++;
//			if (mantisScore() >= 12)
//				grandchimeraCounter++;
//			if (scyllaScore() >= 7)
//				grandchimeraCounter++;
			if (pigScore() >= 15)
				grandchimeraCounter++;
			if (gooScore() >= 15)
				grandchimeraCounter++;
			if (magmagooScore() >= 17)
				grandchimeraCounter++;
			if (darkgooScore() >= 17)
				grandchimeraCounter++;	
			
			End("Player","racialScore");
			return grandchimeraCounter;
		}

		//Determine Jiangshi Rating
		public function jiangshiScore():Number {
			Begin("Player","racialScore","jiangshi");
			var jiangshiCounter:Number = 0;
			if (hasPlainSkinOnly() && skinTone != "slippery")
				jiangshiCounter++;
			if (skinTone == "ghostly pale" || skinTone == "light blue")
				jiangshiCounter++;
			if (hairType == Hair.NORMAL)
				jiangshiCounter++;
			if (faceType == Face.JIANGSHI)
				jiangshiCounter++;
			if (eyes.type == Eyes.JIANGSHI)
				jiangshiCounter += 2;
			if (ears.type == Ears.HUMAN)
				jiangshiCounter++;
			if (tongue.type == 0)
				jiangshiCounter++;
			if (gills.type == 0)
				jiangshiCounter++;
			if (antennae.type == 0)
				jiangshiCounter++;
			if (horns.type == Horns.SPELL_TAG && horns.count > 0)
				jiangshiCounter++;
			if (wings.type == Wings.NONE)
				jiangshiCounter += 2;
			if (tailType == 0)
				jiangshiCounter++;
			if (arms.type == Arms.JIANGSHI)
				jiangshiCounter++;
			if (lowerBody == LowerBody.JIANGSHI)
				jiangshiCounter++;
			if (rearBody.type == RearBody.NONE)
				jiangshiCounter++;
			if (skin.base.pattern == Skin.PATTERN_NONE)
				jiangshiCounter++;
			if (findPerk(PerkLib.Undeath) >= 0)
				jiangshiCounter += 2;
			End("Player","racialScore");
			return jiangshiCounter;
		}

		//determine demon rating
		public function demonScore():Number {
			Begin("Player","racialScore","demon");
			var demonCounter:Number = 0;
			if (horns.type == Horns.DEMON && horns.count > 0)
				demonCounter++;
			if (tailType == Tail.DEMONIC)
				demonCounter++;
			if (wings.type == Wings.BAT_LIKE_TINY)
				demonCounter += 2;
			if (wings.type == Wings.BAT_LIKE_LARGE)
				demonCounter += 4;
			if (tongue.type == Tongue.DEMONIC)
				demonCounter++;
			if (lowerBody == LowerBody.DEMONIC_HIGH_HEELS || lowerBody == LowerBody.DEMONIC_CLAWS)
				demonCounter++;
			if (demonCocks() > 0)
				demonCounter++;
			if (cor >= 50) {
				if (horns.type == Horns.DEMON && horns.count > 4)
					demonCounter++;
				if (hasPlainSkinOnly() && skinTone != "slippery")
					demonCounter++;
				if (skinTone == "shiny black" || skinTone == "sky blue" || skinTone == "indigo" || skinTone == "ghostly white" || skinTone == "light purple" || skinTone == "purple" || skinTone == "red" || skinTone == "grey" || skinTone == "blue")
					demonCounter++;
				if (faceType == Face.HUMAN)
					demonCounter++;
				if (arms.type == Arms.HUMAN)
					demonCounter++;
			}
			if (hasStatusEffect(StatusEffects.PlayerPhylactery))
				demonCounter += 5;
			if (horns.type == Horns.GOAT)
				demonCounter -= 10;
			if (findPerk(PerkLib.BlackHeart) >= 0)
				demonCounter++;
			if (findPerk(PerkLib.BlackHeartEvolved) >= 0)
				demonCounter++;
			if (findPerk(PerkLib.BlackHeartFinalForm) >= 0)
				demonCounter++;
			if (findPerk(PerkLib.BlackHeart) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				demonCounter++;
			if (findPerk(PerkLib.BlackHeartEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				demonCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				demonCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && demonCounter >= 4)
				demonCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && demonCounter >= 8)
				demonCounter += 1;
			if (hasPerk(PerkLib.DemonicLethicite))
				demonCounter+=1;
			if (isGargoyle()) demonCounter = 0;
			End("Player","racialScore");
			return demonCounter;
		}

		//determine devil/infernal goat rating
		public function devilkinScore():Number {
			Begin("Player","racialScore","devil");
			var devilkinCounter:Number = 0;
			if (lowerBody == LowerBody.HOOFED)
				devilkinCounter++;
			if (tailType == Tail.GOAT || tailType == Tail.DEMONIC)
				devilkinCounter++;
			if (wings.type == Wings.BAT_LIKE_TINY || wings.type == Wings.BAT_LIKE_LARGE)
				devilkinCounter += 4;
			if (arms.type == Arms.DEVIL)
				devilkinCounter++;
			if (horns.type == Horns.GOAT)
				devilkinCounter++;
			if (ears.type == Ears.GOAT)
				devilkinCounter++;
			if (faceType == Face.DEVIL_FANGS)
				devilkinCounter++;
			if (eyes.type == Eyes.DEVIL)
				devilkinCounter++;
			if (tallness < 48)
				devilkinCounter++;
			if (cor >= 60)
				devilkinCounter++;
			if (hasStatusEffect(StatusEffects.PlayerPhylactery))
				devilkinCounter += 5;
			if (findPerk(PerkLib.ObsidianHeart) >= 0)
				devilkinCounter++;
			if (findPerk(PerkLib.ObsidianHeartEvolved) >= 0)
				devilkinCounter++;
			if (findPerk(PerkLib.ObsidianHeartFinalForm) >= 0)
				devilkinCounter++;
			if (findPerk(PerkLib.ObsidianHeart) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				devilkinCounter++;
			if (findPerk(PerkLib.ObsidianHeartEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				devilkinCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				devilkinCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && devilkinCounter >= 4)
				devilkinCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && devilkinCounter >= 8)
				devilkinCounter += 1;
			if (isGargoyle()) devilkinCounter = 0;
			End("Player","racialScore");
			return devilkinCounter;
		}

		//Determine cow rating
		public function cowScore():Number {
			Begin("Player","racialScore","cow");
			var cowCounter:Number = 0;
			if (ears.type == Ears.COW)
				cowCounter++;
			if (tailType == Tail.COW)
				cowCounter++;
			if (lowerBody == LowerBody.HOOFED)
				cowCounter++;
			if (horns.type == Horns.COW_MINOTAUR)
				cowCounter++;
			if (cowCounter >= 4) {
				if (faceType == Face.HUMAN || faceType == Face.COW_MINOTAUR)
					cowCounter++;
				if (arms.type == Arms.HUMAN)
					cowCounter++;
				if (hasFur() || hasPartialCoat(Skin.FUR))
					cowCounter++;
				if (biggestTitSize() > 4)
					cowCounter++;
				if (tallness >= 73)
					cowCounter++;
				if (cor >= 20)
					cowCounter++;
				if (vaginas.length > 0)
					cowCounter++;
				if (cocks.length > 0)
					cowCounter -= 8;
			}
			if (findPerk(PerkLib.LactaBovinaOvaries) >= 0)
				cowCounter++;
			if (findPerk(PerkLib.LactaBovinaOvariesEvolved) >= 0)
				cowCounter++;
			if (findPerk(PerkLib.LactaBovinaOvariesFinalForm) >= 0)
				cowCounter++;
			if (findPerk(PerkLib.LactaBovinaOvaries) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				cowCounter++;
			if (findPerk(PerkLib.LactaBovinaOvariesEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				cowCounter++;
			if (findPerk(PerkLib.MinotaursDescendant) >= 0 || findPerk(PerkLib.BloodlineMinotaur) >= 0)
				cowCounter += 2;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				cowCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && cowCounter >= 4)
				cowCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && cowCounter >= 8)
				cowCounter += 1;
			if (isGargoyle()) cowCounter = 0;
			End("Player","racialScore");
			return cowCounter;
		}

		//Determine minotaur rating
		public function minotaurScore():Number {
			Begin("Player","racialScore","minotaur");
			var minoCounter:Number = 0;
			if (ears.type == Ears.COW)
				minoCounter++;
			if (tailType == Tail.COW)
				minoCounter++;
			if (lowerBody == LowerBody.HOOFED)
				minoCounter++;
			if (horns.type == Horns.COW_MINOTAUR)
				minoCounter++;
			if (minoCounter >= 4) {
				if (faceType == Face.HUMAN || faceType == Face.COW_MINOTAUR)
					minoCounter++;
				if (arms.type == Arms.HUMAN)
					minoCounter++;
				if (hasFur() || hasPartialCoat(Skin.FUR))
					minoCounter++;
				if (cumQ() > 500)
					minoCounter++;
				if (tallness >= 81)
					minoCounter++;
				if (cor >= 20)
					minoCounter++;
				if (cocks.length > 0 && horseCocks() > 0)
					minoCounter++;
				if (vaginas.length > 0)
					minoCounter -= 8;
			}
			if (findPerk(PerkLib.MinotaurTesticles) >= 0)
				minoCounter++;
			if (findPerk(PerkLib.MinotaurTesticlesEvolved) >= 0)
				minoCounter++;
			if (findPerk(PerkLib.MinotaurTesticlesFinalForm) >= 0)
				minoCounter++;
			if (findPerk(PerkLib.MinotaurTesticles) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				minoCounter++;
			if (findPerk(PerkLib.MinotaurTesticlesEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				minoCounter++;
			if (findPerk(PerkLib.MinotaursDescendant) >= 0 || findPerk(PerkLib.BloodlineMinotaur) >= 0)
				minoCounter += 2;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				minoCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && minoCounter >= 4)
				minoCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && minoCounter >= 8)
				minoCounter += 1;
			if (isGargoyle()) minoCounter = 0;
			End("Player","racialScore");
			return minoCounter;
		}

		public function sandTrapScore():int {
			Begin("Player","racialScore","sandTrap");
			var counter:int = 0;
			if (hasStatusEffect(StatusEffects.BlackNipples))
				counter++;
			if (hasStatusEffect(StatusEffects.Uniball))
				counter++;
			if (hasVagina() && vaginaType() == VaginaClass.BLACK_SAND_TRAP)
				counter++;
			if (eyes.type == Eyes.BLACK_EYES_SAND_TRAP)
				counter++;
			if (wings.type == Wings.GIANT_DRAGONFLY)
				counter++;
			if (hasStatusEffect(StatusEffects.Uniball))
				counter++;
			if (isGargoyle()) counter = 0;
			End("Player","racialScore");
			return counter;
		}

		//Determine Bee Rating
		public function beeScore():Number {
			Begin("Player","racialScore","bee");
			var beeCounter:Number = 0;
			if (hairColor == "shiny black")
				beeCounter++;
			if (hairColor == "black and yellow") // TODO if hairColor2 == yellow && hairColor == black
				beeCounter += 2;
			if (antennae.type == Antennae.BEE)
			{
				beeCounter++;
				if (faceType == Face.HUMAN)
					beeCounter++;
			}
			if (arms.type == Arms.BEE)
				beeCounter++;
			if (lowerBody == LowerBody.BEE)
			{
				beeCounter++;
				if (vaginas.length == 1)
					beeCounter++;
			}
			if (tailType == Tail.BEE_ABDOMEN)
				beeCounter++;
			if (wings.type == Wings.BEE_LIKE_SMALL)
				beeCounter++;
			if (wings.type == Wings.BEE_LIKE_LARGE)
				beeCounter += 2;
			if (findPerk(PerkLib.BeeOvipositor) >= 0)
				beeCounter++;
			if (beeCounter > 0 && findPerk(PerkLib.TrachealSystem) >= 0)
				beeCounter++;
			if (beeCounter > 4 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
				beeCounter++;
			if (beeCounter > 8 && findPerk(PerkLib.TrachealSystemFinalForm) >= 0)
				beeCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				beeCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && beeCounter >= 4)
				beeCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && beeCounter >= 8)
				beeCounter += 1;
			if (isGargoyle()) beeCounter = 0;
			End("Player","racialScore");
			return beeCounter;
		}
		//Determine Ferret Rating!
		public function ferretScore():Number {
			Begin("Player","racialScore","ferret");
			var counter:int = 0;
			if (faceType == Face.FERRET_MASK) counter++;
			if (faceType == Face.FERRET) counter+=2;
			if (ears.type == Ears.FERRET) counter++;
			if (tailType == Tail.FERRET) counter++;
			if (lowerBody == LowerBody.FERRET) counter++;
			if (hasFur() && counter > 0) counter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				counter += 50;
			if (isGargoyle()) counter = 0;
			End("Player","racialScore");
			return counter;
		}
		//Determine Dog Rating
		public function dogScore():Number {
			Begin("Player","racialScore","dog");
			var dogCounter:Number = 0;
			if (faceType == Face.DOG)
				dogCounter++;
			if (ears.type == Ears.DOG)
				dogCounter++;
			if (tailType == Tail.DOG)
				dogCounter++;
			if (lowerBody == LowerBody.DOG)
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
			if (hasFur() && dogCounter > 0)
				dogCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				dogCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && dogCounter >= 4)
				dogCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && dogCounter >= 8)
				dogCounter += 1;
			if (isGargoyle()) dogCounter = 0;
			End("Player","racialScore");
			return dogCounter;
		}

		public function mouseScore():Number {
			Begin("Player","racialScore","mouse");
			var mouseCounter:Number = 0;
			if (ears.type == Ears.MOUSE)
				mouseCounter++;
			if (tailType == Tail.MOUSE || tailType == Tail.HINEZUMI)
				mouseCounter++;
			if (faceType == Face.BUCKTEETH || faceType == Face.MOUSE)
				mouseCounter += 2;
			if (lowerBody == LowerBody.MOUSE || lowerBody == LowerBody.HINEZUMI)
				mouseCounter++;
			if (arms.type == Arms.HINEZUMI)
				mouseCounter++;
			if (eyes.type == Eyes.HINEZUMI && eyes.colour == "blazing red")
				mouseCounter++;
			if (hairType == Hair.BURNING)
				mouseCounter++;
			if (hairColor == "red" || hairColor == "orange" || hairColor == "pinkish orange")
				mouseCounter++;
			if (hasFur() || hasPartialCoat(Skin.FUR)) {
				mouseCounter++;
				if (tallness < 60)
					mouseCounter++;
				if (tallness < 48)
					mouseCounter++;
			}
			if (findPerk(PerkLib.HinezumiBurningBlood) >= 0)
				mouseCounter++;
			if (findPerk(PerkLib.HinezumiBurningBloodEvolved) >= 0)
				mouseCounter++;
			if (findPerk(PerkLib.HinezumiBurningBloodFinalForm) >= 0)
				mouseCounter++;
			if (findPerk(PerkLib.HinezumiBurningBlood) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				mouseCounter++;
			if (findPerk(PerkLib.HinezumiBurningBloodEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				mouseCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				mouseCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && mouseCounter >= 4)
				mouseCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && mouseCounter >= 8)
				mouseCounter += 1;
			if (isGargoyle()) mouseCounter = 0;
			End("Player","racialScore");
			return mouseCounter;
		}

		public function raccoonScore():Number {
			Begin("Player","racialScore","raccoon");
			var coonCounter:Number = 0;
			if (faceType == Face.RACCOON_MASK)
				coonCounter++;
			if (faceType == Face.RACCOON)
				coonCounter += 2;
			if (ears.type == Ears.RACCOON)
				coonCounter++;
			if (tailType == Tail.RACCOON)
				coonCounter++;
			if (lowerBody == LowerBody.RACCOON)
				coonCounter++;
			if (coonCounter > 0 && balls > 0)
				coonCounter++;
			//Fur only counts if some canine features are present
			if (hasFur() && coonCounter > 0)
				coonCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				coonCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && coonCounter >= 4)
				coonCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && coonCounter >= 8)
				coonCounter += 1;
			if (isGargoyle()) coonCounter = 0;
			End("Player","racialScore");
			return coonCounter;
		}

		//Determine Fox Rating
		public function foxScore():Number {
			Begin("Player","racialScore","fox");
			var foxCounter:Number = 0;
			if (faceType == Face.FOX)
				foxCounter++;
			if (eyes.type == Eyes.FOX)
				foxCounter++;
			if (ears.type == Ears.FOX)
				foxCounter++;
			if (tailType == Tail.FOX)
				foxCounter++;
			if (tailType == Tail.FOX && tailCount >= 2)
				foxCounter -= 7;
			if (arms.type == Arms.FOX)
				foxCounter++;
			if (lowerBody == LowerBody.FOX)
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
			if (hasFur() && foxCounter > 0)
				foxCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				foxCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && foxCounter >= 4)
				foxCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && foxCounter >= 8)
				foxCounter += 1;
			if (isGargoyle()) foxCounter = 0;
			End("Player","racialScore");
			return foxCounter;
		}

		//Determine cat Rating
		public function catScore():Number {
			Begin("Player","racialScore","cat");
			var catCounter:Number = 0;
			if (faceType == Face.CAT || faceType == Face.CAT_CANINES)
				catCounter++;
			if (faceType == Face.CHESHIRE || faceType == Face.CHESHIRE_SMILE)
				catCounter -= 7;
			if (eyes.type == Eyes.CAT_SLITS)
				catCounter++;
			if (ears.type == Ears.CAT)
				catCounter++;
			if (eyes.type == Eyes.FERAL)
				catCounter -= 11;
			if (tongue.type == Tongue.CAT)
				catCounter++;
			if (tailType == Tail.CAT)
				catCounter++;
			if (arms.type == Arms.CAT)
				catCounter++;
			if (lowerBody == LowerBody.CAT)
				catCounter++;
			if (catCocks() > 0)
				catCounter++;
			if (breastRows.length > 1 && catCounter > 0)
				catCounter++;
			if (breastRows.length == 3 && catCounter > 0)
				catCounter++;
			if (breastRows.length > 3)
				catCounter -= 2;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				catCounter++;
			if (horns.type == Horns.DEMON || horns.type == Horns.DRACONIC_X2 || horns.type == Horns.DRACONIC_X4_12_INCH_LONG)
				catCounter -= 2;
			if (wings.type == Wings.BAT_LIKE_TINY || wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.BAT_LIKE_LARGE || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.BAT_LIKE_LARGE_2 || wings.type == Wings.DRACONIC_HUGE)
				catCounter -= 2;
			if (findPerk(PerkLib.Flexibility) > 0)
				catCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) > 0)
				catCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) > 0)
				catCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				catCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				catCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && catCounter >= 4)
				catCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && catCounter >= 8)
				catCounter += 1;
			if (tailType == Tail.NEKOMATA_FORKED_1_3 || tailType == Tail.NEKOMATA_FORKED_2_3 || (tailType == Tail.CAT && tailCount > 1) || rearBody.type == RearBody.LION_MANE || (hairColor == "lilac and white striped" && coatColor == "lilac and white striped") || eyes.type == Eyes.INFERNAL || hairType == Hair.BURNING || tailType == Tail.BURNING
			 || eyes.type == Eyes.DISPLACER || ears.type == Ears.DISPLACER || arms.type == Arms.DISPLACER || rearBody.type == RearBody.DISPLACER_TENTACLES) catCounter = 0;
			if (isGargoyle()) catCounter = 0;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				catCounter += 50;
			End("Player","racialScore");
			return catCounter;
		}
		//Determine nekomata Rating
		public function nekomataScore():Number {
			Begin("Player","racialScore","nekomata");
			var nekomataCounter:Number = 0;
			if (faceType == Face.CAT_CANINES)
				nekomataCounter++;
			if (eyes.type == Eyes.CAT_SLITS)
				nekomataCounter++;
			if (ears.type == Ears.CAT)
				nekomataCounter++;
			if (tongue.type == Tongue.CAT)
				nekomataCounter++;
			if (tailType == Tail.CAT)
				nekomataCounter++;
			if (tailType == Tail.NEKOMATA_FORKED_1_3)
				nekomataCounter += 2;
			if (tailType == Tail.NEKOMATA_FORKED_2_3)
				nekomataCounter += 3;
			if (tailType == Tail.CAT && tailCount == 2)
				nekomataCounter += 4;
			if (arms.type == Arms.CAT)
				nekomataCounter++;
			if (lowerBody == LowerBody.CAT)
				nekomataCounter++;
			if (rearBody.type == RearBody.LION_MANE)
				nekomataCounter++;
			if (hasPartialCoat(Skin.FUR))
				nekomataCounter++;
			if (findPerk(PerkLib.Flexibility) > 0)
				nekomataCounter++;
			if (findPerk(PerkLib.Necromancy) > 0)
				nekomataCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) > 0)
				nekomataCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) > 0)
				nekomataCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				nekomataCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				nekomataCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && nekomataCounter >= 4)
				nekomataCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && nekomataCounter >= 8)
				nekomataCounter += 1;
			if (catScore() >= 4 || (hairColor == "lilac and white striped" && coatColor == "lilac and white striped") || eyes.type == Eyes.INFERNAL || hairType == Hair.BURNING || tailType == Tail.BURNING || eyes.type == Eyes.DISPLACER || ears.type == Ears.DISPLACER || arms.type == Arms.DISPLACER || rearBody.type == RearBody.DISPLACER_TENTACLES) nekomataCounter = 0;
			if (isGargoyle()) nekomataCounter = 0;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				nekomataCounter += 50;
			End("Player","racialScore");
			return nekomataCounter;
		}
		//Determine cheshire Rating
		public function cheshireScore():Number {
			Begin("Player","racialScore","cheshire");
			var cheshireCounter:Number = 0;
			if (faceType == Face.CHESHIRE || faceType == Face.CHESHIRE_SMILE)
				cheshireCounter += 2;
			if (eyes.type == Eyes.CAT_SLITS)
				cheshireCounter++;
			if (ears.type == Ears.CAT)
				cheshireCounter++;
			if (tongue.type == Tongue.CAT)
				cheshireCounter++;
			if (tailType == Tail.CAT)
				cheshireCounter++;
			if (arms.type == Arms.CAT)
				cheshireCounter++;
			if (lowerBody == LowerBody.CAT)
				cheshireCounter++;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				cheshireCounter++;
			if (hairColor == "lilac and white striped" && coatColor == "lilac and white striped")
				cheshireCounter += 2;
			if (findPerk(PerkLib.Flexibility) > 0)
				cheshireCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) > 0)
				cheshireCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) > 0)
				cheshireCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				cheshireCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				cheshireCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && cheshireCounter >= 4)
				cheshireCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && cheshireCounter >= 8)
				cheshireCounter += 1;
			if (catScore() >= 4 || tailType == Tail.NEKOMATA_FORKED_1_3 || tailType == Tail.NEKOMATA_FORKED_2_3 || (tailType == Tail.CAT && tailCount > 1) || rearBody.type == RearBody.LION_MANE || eyes.type == Eyes.INFERNAL || hairType == Hair.BURNING || tailType == Tail.BURNING
			 || eyes.type == Eyes.DISPLACER || ears.type == Ears.DISPLACER || arms.type == Arms.DISPLACER || rearBody.type == RearBody.DISPLACER_TENTACLES) cheshireCounter = 0;
			if (isGargoyle()) cheshireCounter = 0;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				cheshireCounter += 50;
			End("Player","racialScore");
			return cheshireCounter;
		}
		//Determine hellcat Rating
		public function hellcatScore():Number {
			Begin("Player","racialScore","hellcat");
			var hellcatCounter:Number = 0;
			if (faceType == Face.CAT || faceType == Face.CAT_CANINES)
				hellcatCounter++;
			if (eyes.type == Eyes.INFERNAL)
				hellcatCounter++;
			if (ears.type == Ears.CAT)
				hellcatCounter++;
			if (tongue.type == Tongue.CAT)
				hellcatCounter++;
			if (hairType == Hair.BURNING)
				hellcatCounter++;
			if (tailType == Tail.BURNING)
				hellcatCounter++;
			if (arms.type == Arms.CAT)
				hellcatCounter++;
			if (lowerBody == LowerBody.CAT)
				hellcatCounter++;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				hellcatCounter++;
			if (coatColor == "midnight black")
				hellcatCounter++;
			if (skinTone == "ashen")
				hellcatCounter++;
			if (findPerk(PerkLib.Flexibility) > 0)
				hellcatCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) > 0)
				hellcatCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) > 0)
				hellcatCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				hellcatCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				hellcatCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && hellcatCounter >= 4)
				hellcatCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && hellcatCounter >= 8)
				hellcatCounter += 1;
			if (catScore() >= 4 || tailType == Tail.NEKOMATA_FORKED_1_3 || tailType == Tail.NEKOMATA_FORKED_2_3 || (tailType == Tail.CAT && tailCount > 1) || rearBody.type == RearBody.LION_MANE || (hairColor == "lilac and white striped" && coatColor == "lilac and white striped") || eyes.type != Eyes.INFERNAL || hairType != Hair.BURNING || tailType != Tail.BURNING
			 || eyes.type == Eyes.DISPLACER || ears.type == Ears.DISPLACER || arms.type == Arms.DISPLACER || rearBody.type == RearBody.DISPLACER_TENTACLES) hellcatCounter = 0;
			if (isGargoyle()) hellcatCounter = 0;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				hellcatCounter += 50;
			End("Player","racialScore");
			return hellcatCounter;
		}
		//Determine displacer beast Rating
		public function displacerbeastScore():Number {
			Begin("Player","racialScore","displacerbeast");
			var displacerbeastCounter:Number = 0;
			if (faceType == Face.CAT || faceType == Face.CAT_CANINES)
				displacerbeastCounter++;
			if (eyes.type == Eyes.DISPLACER && eyes.colour == "yellow")
				displacerbeastCounter++;
			if (tongue.type == Tongue.CAT)
				displacerbeastCounter++;
			if (ears.type == Ears.DISPLACER)
				displacerbeastCounter++;
			if (tailType == Tail.CAT)
				displacerbeastCounter++;
			if (lowerBody == LowerBody.LION)
				displacerbeastCounter++;
			if (arms.type == Arms.DISPLACER)
				displacerbeastCounter += 3;
			if (rearBody.type == RearBody.DISPLACER_TENTACLES)
				displacerbeastCounter += 2;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				displacerbeastCounter++;
			if (coatColor == "black" || coatColor == "midnight black")
				displacerbeastCounter++;
			if (skinTone == "dark grey")
				displacerbeastCounter++;
			if (findPerk(PerkLib.Flexibility) > 0)
				displacerbeastCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) > 0)
				displacerbeastCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) > 0)
				displacerbeastCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				displacerbeastCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				displacerbeastCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && displacerbeastCounter >= 4)
				displacerbeastCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && displacerbeastCounter >= 8)
				displacerbeastCounter += 1;
			if (catScore() >= 4 || tailType == Tail.NEKOMATA_FORKED_1_3 || tailType == Tail.NEKOMATA_FORKED_2_3 || (tailType == Tail.CAT && tailCount > 1) || rearBody.type == RearBody.LION_MANE || (hairColor == "lilac and white striped" && coatColor == "lilac and white striped") || eyes.type == Eyes.INFERNAL || hairType == Hair.BURNING || tailType == Tail.BURNING) displacerbeastCounter = 0;
			if (isGargoyle()) displacerbeastCounter = 0;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				displacerbeastCounter += 50;
			End("Player","racialScore");
			return displacerbeastCounter;
		}

		//Determine lizard rating
		public function lizardScore():Number {
			Begin("Player","racialScore","lizard");
			var lizardCounter:Number = 0;
			if (faceType == Face.LIZARD)
				lizardCounter++;
			if (ears.type == Ears.LIZARD)
				lizardCounter++;
			if (eyes.type == Eyes.REPTILIAN)
				lizardCounter++;
			if (tailType == Tail.LIZARD)
				lizardCounter++;
			if (arms.type == Arms.LIZARD)
				lizardCounter++;
			if (lowerBody == LowerBody.LIZARD)
				lizardCounter++;
			if (horns.count > 0 && (horns.type == Horns.DRACONIC_X2 || horns.type == Horns.DRACONIC_X4_12_INCH_LONG))
				lizardCounter++;
			if (hasScales())
				lizardCounter++;
			if (lizardCocks() > 0)
				lizardCounter++;
			if (lizardCounter > 0 && findPerk(PerkLib.LizanRegeneration) >= 0)
				lizardCounter++;
			if (findPerk(PerkLib.LizanMarrow) >= 0)
				lizardCounter++;
			if (findPerk(PerkLib.LizanMarrowEvolved) >= 0)
				lizardCounter++;
			if (findPerk(PerkLib.LizanMarrow) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				lizardCounter++;
			if (findPerk(PerkLib.LizanMarrowEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				lizardCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				lizardCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && lizardCounter >= 4)
				lizardCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && lizardCounter >= 8)
				lizardCounter += 1;
			if (isGargoyle()) lizardCounter = 0;
			End("Player","racialScore");
			return lizardCounter;
		}

		public function spiderScore():Number {
			Begin("Player","racialScore","spider");
			var spiderCounter:Number = 0;
			if (eyes.type == Eyes.FOUR_SPIDER_EYES)
				spiderCounter++;
			if (faceType == Face.SPIDER_FANGS)
				spiderCounter++;
			if (ears.type == Ears.ELFIN)
				spiderCounter++;
			if (arms.type == Arms.SPIDER)
				spiderCounter++;
			if (lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS)
				spiderCounter++;
			if (lowerBody == LowerBody.DRIDER)
				spiderCounter += 2;
			if (tailType == Tail.SPIDER_ADBOMEN)
				spiderCounter++;
			if (!hasCoatOfType(Skin.CHITIN) && spiderCounter > 0)
				spiderCounter--;
			if (hasCoatOfType(Skin.CHITIN))
				spiderCounter++;
			if (spiderCounter > 0 && findPerk(PerkLib.TrachealSystem) >= 0)
				spiderCounter++;
			if (spiderCounter > 4 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
				spiderCounter++;
			if (spiderCounter > 8 && findPerk(PerkLib.TrachealSystemFinalForm) >= 0)
				spiderCounter++;
			if (hasStatusEffect(StatusEffects.BlackNipples))
				spiderCounter++;
			if (findPerk(PerkLib.SpiderOvipositor) >= 0)
				spiderCounter++;
			if (findPerk(PerkLib.VenomGlands) >= 0)
				spiderCounter++;
			if (findPerk(PerkLib.VenomGlandsEvolved) >= 0)
				spiderCounter++;
			if (findPerk(PerkLib.VenomGlandsFinalForm) >= 0)
				spiderCounter++;
			if ((findPerk(PerkLib.VenomGlands) >= 0 || findPerk(PerkLib.TrachealSystem) >= 0) && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				spiderCounter++;
			if ((findPerk(PerkLib.VenomGlandsEvolved) >= 0 || findPerk(PerkLib.TrachealSystemEvolved) >= 0) && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				spiderCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				spiderCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && spiderCounter >= 4)
				spiderCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && spiderCounter >= 8)
				spiderCounter += 1;
			if (isGargoyle()) spiderCounter = 0;
			End("Player","racialScore");
			return spiderCounter;
		}

		//Determine Horse Rating
		public function horseScore():Number {
			Begin("Player","racialScore","horse");
			var horseCounter:Number = 0;
			if (faceType == Face.HORSE)
				horseCounter++;
			if (ears.type == Ears.HORSE)
				horseCounter++;
			if (tailType == Tail.HORSE)
				horseCounter++;
			if (lowerBody == LowerBody.HOOFED || lowerBody == LowerBody.CENTAUR)
				horseCounter++;
			if (horseCocks() > 0)
				horseCounter++;
			if (hasVagina() && vaginaType() == VaginaClass.EQUINE)
				horseCounter++;
			if (hasFur()) {
				horseCounter++;
				if (arms.type == Arms.HUMAN)
					horseCounter++;
			}
			if (isTaur()) {
				if (horseCounter >= 7) horseCounter -= 7;
				else horseCounter = 0;
			}
			if (unicornScore() > 9 || alicornScore() > 11) {
				if (horseCounter >= 7) horseCounter -= 7;
				else horseCounter = 0;
			}
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				horseCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && horseCounter >= 4)
				horseCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && horseCounter >= 8)
				horseCounter += 1;
			if (isGargoyle()) horseCounter = 0;
			End("Player","racialScore");
			return horseCounter;
		}

		//Determine kitsune Rating
		public function kitsuneScore():Number {
			Begin("Player","racialScore","kitsune");
			var kitsuneCounter:int = 0;
			if (eyes.type == Eyes.FOX)
				kitsuneCounter++;
			if (ears.type == Ears.FOX)
				kitsuneCounter++;
			//If the character has ears other than fox ears, -1
			if (ears.type != Ears.FOX)
				kitsuneCounter--;
			if (tailType == Tail.FOX && tailCount >= 2 && tailCount < 4)
				kitsuneCounter++;
			if (tailType == Tail.FOX && tailCount >= 4 && tailCount < 6)
				kitsuneCounter += 2;
			if (tailType == Tail.FOX && tailCount >= 6 && tailCount < 9)
				kitsuneCounter += 3;
			if (tailType == Tail.FOX && tailCount == 9)
				kitsuneCounter += 4;
			if (tailType != Tail.FOX || (tailType == Tail.FOX && tailCount < 2))
				kitsuneCounter -= 7;
			if (skin.base.pattern == Skin.PATTERN_MAGICAL_TATTOO || hasFur())
				kitsuneCounter++;
			//If the character has fur, scales, or gooey skin, -1
		//	if (skinType == FUR && !InCollection(furColor, KitsuneScene.basicKitsuneFur) && !InCollection(furColor, KitsuneScene.elderKitsuneColors))
		//		kitsuneCounter--;
			if (hasCoat() && !hasCoatOfType(Skin.FUR))
				kitsuneCounter -= 2;
			if (skin.base.type != Skin.PLAIN)
				kitsuneCounter -= 3;
			if (arms.type == Arms.HUMAN || arms.type == Arms.KITSUNE)
				kitsuneCounter++;
			if (lowerBody == LowerBody.FOX || lowerBody == LowerBody.HUMAN)
				kitsuneCounter++;
			if (lowerBody != LowerBody.HUMAN && lowerBody != LowerBody.FOX)
				kitsuneCounter--;
			//If the character has a 'vag of holding', +1
			if (vaginalCapacity() >= 8000)
				kitsuneCounter++;
			if (faceType == Face.HUMAN || faceType == Face.FOX)
				kitsuneCounter++;
			if (faceType != Face.HUMAN && faceType != Face.FOX)
				kitsuneCounter--;
			//If the character has "blonde","black","red","white", or "silver" hair, +1
		//	if (kitsuneCounter > 0 && (InCollection(furColor, KitsuneScene.basicKitsuneHair) || InCollection(furColor, KitsuneScene.elderKitsuneColors)))
		//		kitsuneCounter++;
			if (findPerk(PerkLib.StarSphereMastery) >= 0)
				kitsuneCounter++;
			//When character get Hoshi no tama
			if (findPerk(PerkLib.KitsuneThyroidGland) >= 0)
				kitsuneCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0)
				kitsuneCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGlandFinalForm) >= 0)
				kitsuneCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGland) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				kitsuneCounter++;
			if (findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				kitsuneCounter++;
			if (findPerk(PerkLib.KitsunesDescendant) >= 0 || findPerk(PerkLib.BloodlineKitsune) >= 0)
				kitsuneCounter += 2;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				kitsuneCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && kitsuneCounter >= 4)
				kitsuneCounter++;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && kitsuneCounter >= 8)
				kitsuneCounter += 1;
			if (isGargoyle()) kitsuneCounter = 0;
			End("Player","racialScore");
			return kitsuneCounter;
		}

		//Determine Dragon Rating
		public function dragonScore():Number {
			Begin("Player","racialScore","dragon");
			var dragonCounter:Number = 0;
			if (faceType == Face.DRAGON || faceType == Face.DRAGON_FANGS)
				dragonCounter++;
			if (faceType == Face.JABBERWOCKY || faceType == Face.BUCKTOOTH)
				dragonCounter -= 10;
			if (eyes.type == Eyes.DRAGON)
				dragonCounter++;
			if (ears.type == Ears.DRAGON)
				dragonCounter++;
			if (tailType == Tail.DRACONIC)
				dragonCounter++;
			if (tongue.type == Tongue.DRACONIC)
				dragonCounter++;
			if (wings.type == Wings.DRACONIC_SMALL)
				dragonCounter++;
			if (wings.type == Wings.DRACONIC_LARGE)
				dragonCounter += 2;
			if (wings.type == Wings.DRACONIC_HUGE)
				dragonCounter += 4;
			if (wings.type == Wings.FEY_DRAGON_WINGS)
				dragonCounter -= 10;
			if (lowerBody == LowerBody.DRAGON)
				dragonCounter++;
			if (arms.type == Arms.DRAGON)
				dragonCounter++;
			if (tallness > 120 && dragonCounter >= 10)
				dragonCounter++;
			if (skinType == Skin.DRAGON_SCALES)// FIXME: what about PARTIAL_DRAGON_SCALES?
				dragonCounter++;
			if (horns.type == Horns.DRACONIC_X4_12_INCH_LONG)
				dragonCounter += 2;
			if (horns.type == Horns.DRACONIC_X2)
				dragonCounter++;
		//	if (dragonCocks() > 0)
		//		dragonCounter++;
			if (dragonCounter >= 4) {
				if (findPerk(PerkLib.DragonFireBreath) >= 0)
					dragonCounter++;
				if (findPerk(PerkLib.DragonIceBreath) >= 0)
					dragonCounter++;
				if (findPerk(PerkLib.DragonLightningBreath) >= 0)
					dragonCounter++;
				if (findPerk(PerkLib.DragonDarknessBreath) >= 0)
					dragonCounter++;
			}
			if (findPerk(PerkLib.DraconicLungs) >= 0)
				dragonCounter++;
			if (findPerk(PerkLib.DraconicLungsEvolved) >= 0)
				dragonCounter++;
			if (findPerk(PerkLib.DraconicLungsFinalForm) >= 0)
				dragonCounter++;
			if (findPerk(PerkLib.DraconicLungs) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				dragonCounter++;
			if (findPerk(PerkLib.DraconicLungsEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				dragonCounter++;
			if (findPerk(PerkLib.DragonsDescendant) >= 0 || findPerk(PerkLib.BloodlineDragon) >= 0)
				dragonCounter += 2;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				dragonCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && dragonCounter >= 4)
				dragonCounter++;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && dragonCounter >= 8)
				dragonCounter += 1;
			if (isGargoyle()) dragonCounter = 0;
			End("Player","racialScore");
			return dragonCounter;
		}
		
		//Determine Jabberwocky Rating
		public function jabberwockyScore():Number {
			Begin("Player","racialScore","jabberwocky");
			var jabberwockyCounter:Number = 0;
			if (faceType == Face.JABBERWOCKY || faceType == Face.BUCKTOOTH)
				jabberwockyCounter++;
			if (faceType == Face.DRAGON || faceType == Face.DRAGON_FANGS)
				jabberwockyCounter -= 10;
			if (eyes.type == Eyes.DRAGON)
				jabberwockyCounter++;
			if (ears.type == Ears.DRAGON)
				jabberwockyCounter++;
			if (tailType == Tail.DRACONIC)
				jabberwockyCounter++;
			if (tongue.type == Tongue.DRACONIC)
				jabberwockyCounter++;
			if (wings.type == Wings.FEY_DRAGON_WINGS)
				jabberwockyCounter += 4;
			if (wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE)
				jabberwockyCounter -= 10;
			if (lowerBody == LowerBody.DRAGON)
				jabberwockyCounter++;
			if (arms.type == Arms.DRAGON)
				jabberwockyCounter++;
			if (tallness > 120 && jabberwockyCounter >= 10)
				jabberwockyCounter++;
			if (skinType == Skin.DRAGON_SCALES)// FIXME: what about PARTIAL_DRAGON_SCALES?
				jabberwockyCounter++;
			if (horns.type == Horns.DRACONIC_X4_12_INCH_LONG)
				jabberwockyCounter += 2;
			if (horns.type == Horns.DRACONIC_X2)
				jabberwockyCounter++;
		//	if (dragonCocks() > 0)
		//		dragonCounter++;
			if (jabberwockyCounter >= 4) {
				if (findPerk(PerkLib.DragonFireBreath) >= 0)
					jabberwockyCounter++;
				if (findPerk(PerkLib.DragonIceBreath) >= 0)
					jabberwockyCounter++;
				if (findPerk(PerkLib.DragonLightningBreath) >= 0)
					jabberwockyCounter++;
				if (findPerk(PerkLib.DragonDarknessBreath) >= 0)
					jabberwockyCounter++;
			}
			if (findPerk(PerkLib.DraconicLungs) >= 0)
				jabberwockyCounter++;
			if (findPerk(PerkLib.DraconicLungsEvolved) >= 0)
				jabberwockyCounter++;
			if (findPerk(PerkLib.DraconicLungsFinalForm) >= 0)
				jabberwockyCounter++;
			if (findPerk(PerkLib.DraconicLungs) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				jabberwockyCounter++;
			if (findPerk(PerkLib.DraconicLungsEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				jabberwockyCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && jabberwockyCounter >= 4)
				jabberwockyCounter++;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && jabberwockyCounter >= 8)
				jabberwockyCounter += 1;
			if (faceType != Face.JABBERWOCKY || faceType != Face.BUCKTOOTH || wings.type != Wings.FEY_DRAGON_WINGS) jabberwockyCounter = 0;
			if (isGargoyle()) jabberwockyCounter = 0;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				jabberwockyCounter += 50;
			End("Player","racialScore");
			return jabberwockyCounter;
		}

		//Goblin score
		public function goblinScore():Number
		{
			Begin("Player","racialScore","goblin");
			var goblinCounter:Number = 0;
			if (faceType == Face.HUMAN || faceType == Face.ANIMAL_TOOTHS)
				goblinCounter++;
			if (ears.type == Ears.ELFIN)
				goblinCounter++;
			if (tallness < 48)
				goblinCounter++;
			if (hasVagina())
				goblinCounter++;
			if (hasPlainSkinOnly()) {
				goblinCounter++;
				if (skinTone == "pale yellow" || skinTone == "grayish-blue" || skinTone == "green" || skinTone == "dark green" || skinTone == "emerald")
					goblinCounter++;
				if (eyes.type == Eyes.HUMAN && (eyes.colour == "red" || eyes.colour == "yellow" || eyes.colour == "purple"))
					goblinCounter++;
				if (hairColor == "red" || hairColor == "purple" || hairColor == "green" || hairColor == "blue" || hairColor == "pink")
					goblinCounter++;
				if (arms.type == Arms.HUMAN)
					goblinCounter++;
				if (lowerBody == LowerBody.HUMAN)
					goblinCounter++;
			}
			if (findPerk(PerkLib.GoblinoidBlood) >= 0)
				goblinCounter++;
			if (findPerk(PerkLib.BouncyBody) >= 0)
				goblinCounter++;
			if (findPerk(PerkLib.NaturalPunchingBag) >= 0)
				goblinCounter++;
			if (findPerk(PerkLib.NaturalPunchingBagEvolved) >= 0)
				goblinCounter++;
			if (findPerk(PerkLib.NaturalPunchingBagFinalForm) >= 0)
				goblinCounter++;
			if (findPerk(PerkLib.NaturalPunchingBag) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				goblinCounter++;
			if (findPerk(PerkLib.NaturalPunchingBagEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				goblinCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && goblinCounter >= 4)
				goblinCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && goblinCounter >= 8)
				goblinCounter += 1;
			if (findPerk(PerkLib.GoblinsDescendant) >= 0 || findPerk(PerkLib.BloodlineKitsune) >= 0)
				goblinCounter += 2;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				goblinCounter += 50;
			if (isGargoyle()) goblinCounter = 0;
			End("Player","racialScore");
			return goblinCounter;
		}

		//Goo score
		public function gooScore():Number
		{
			Begin("Player","racialScore","goo");
			var gooCounter:Number = 0;
			if (skinTone == "green" || skinTone == "magenta" || skinTone == "blue" || skinTone == "cerulean" || skinTone == "emerald" || skinTone == "pink") {
				gooCounter++;
				if (hairType == Hair.GOO)
					gooCounter++;
				if (arms.type == Arms.GOO)
					gooCounter++;
				if (lowerBody == LowerBody.GOO)
					gooCounter += 3;
				if (rearBody.type == RearBody.METAMORPHIC_GOO)
					gooCounter += 2;
				if (hasGooSkin() && skinAdj == "slimy") {
					gooCounter++;
					if (faceType == Face.HUMAN)
						gooCounter++;
					if (eyes.type == Eyes.HUMAN)
						gooCounter++;
					if (ears.type == Ears.HUMAN || ears.type == Ears.ELFIN)
						gooCounter++;
					if (tallness > 107)
						gooCounter++;
					if (hasVagina())
						gooCounter++;
					if (antennae.type == Antennae.NONE)
						gooCounter++;
					if (wings.type == Wings.NONE)
						gooCounter++;
					if (gills.type == Gills.NONE)
						gooCounter++;
				}
			}
			if (vaginalCapacity() > 9000)
				gooCounter++;
			if (hasStatusEffect(StatusEffects.SlimeCraving))
				gooCounter++;
			//if (findPerk(PerkLib.SlimeCore) >= 0)
			//	gooCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				gooCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && gooCounter >= 4)
				gooCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && gooCounter >= 8)
				gooCounter += 1;
			if (isGargoyle()) gooCounter = 0;
			End("Player","racialScore");
			return gooCounter;
		}
		//Magma Goo score
		public function magmagooScore():Number
		{
			Begin("Player","racialScore","magmagoo");
			var magmagooCounter:Number = 0;
			if (skinTone == "red" || skinTone == "orange" || skinTone == "reddish orange") {
				magmagooCounter += 2;
				if (hairType == Hair.GOO)
					magmagooCounter++;
				if (arms.type == Arms.GOO)
					magmagooCounter++;
				if (lowerBody == LowerBody.GOO)
					magmagooCounter += 3;
				if (rearBody.type == RearBody.METAMORPHIC_GOO)
					magmagooCounter += 2;
				if (hasGooSkin() && skinAdj == "slimy") {
					magmagooCounter++;
					if (faceType == Face.HUMAN)
						magmagooCounter++;
					if (eyes.type == Eyes.HUMAN)
						magmagooCounter++;
					if (ears.type == Ears.HUMAN || ears.type == Ears.ELFIN)
						magmagooCounter++;
					if (tallness > 107)
						magmagooCounter++;
					if (hasVagina())
						magmagooCounter++;
					if (antennae.type == Antennae.NONE)
						magmagooCounter++;
					if (wings.type == Wings.NONE)
						magmagooCounter++;
					if (gills.type == Gills.NONE)
						magmagooCounter++;
				}
			}
			if (vaginalCapacity() > 9000)
				magmagooCounter++;
			if (hasStatusEffect(StatusEffects.SlimeCraving))
				magmagooCounter++;
			//if (findPerk(PerkLib.SlimeCore) >= 0)
			//	magmagooCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				magmagooCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && magmagooCounter >= 4)
				magmagooCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && magmagooCounter >= 8)
				magmagooCounter += 1;
			if (isGargoyle()) magmagooCounter = 0;
			End("Player","racialScore");
			return magmagooCounter;
		}
		//Dark Goo score
		public function darkgooScore():Number
		{
			Begin("Player","racialScore","darkgoo");
			var darkgooCounter:Number = 0;
			if (skinTone == "indigo" || skinTone == "light purple" || skinTone == "purple" || skinTone == "purplish black") {
				darkgooCounter++;
				if (hairType == Hair.GOO)
					darkgooCounter++;
				if (arms.type == Arms.GOO) 
					darkgooCounter++;
				if (lowerBody == LowerBody.GOO)
					darkgooCounter += 3;
				if (rearBody.type == RearBody.METAMORPHIC_GOO)
					darkgooCounter += 2;
				if (hasGooSkin() && skinAdj == "slimy") {
					darkgooCounter++;
					if (faceType == Face.HUMAN)
						darkgooCounter++;
					if (eyes.type == Eyes.HUMAN || eyes.type == Eyes.DEVIL)
						darkgooCounter++;
					if (ears.type == Ears.HUMAN || ears.type == Ears.ELFIN)
						darkgooCounter++;
					if (tallness > 107)
						darkgooCounter++;
					if (hasVagina())
						darkgooCounter++;
					if (antennae.type == Antennae.NONE)
						darkgooCounter++;
					if (wings.type == Wings.NONE)
						darkgooCounter++;
					if (gills.type == Gills.NONE)
						darkgooCounter++;
				}
			}
			if (vaginalCapacity() > 9000)
				darkgooCounter++;
			if (hasStatusEffect(StatusEffects.SlimeCraving))
				darkgooCounter++;
			//if (findPerk(PerkLib.SlimeCore) >= 0)
			//	darkgooCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				darkgooCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && darkgooCounter >= 4)
				darkgooCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && darkgooCounter >= 8)
				darkgooCounter += 1;
			if (isGargoyle()) darkgooCounter = 0;
			End("Player","racialScore");
			return darkgooCounter;
		}

		//Naga score
		public function nagaScore():Number {
			Begin("Player","racialScore","naga");
			var nagaCounter:Number = 0;
			if (isNaga()) {
				nagaCounter += 2;
				if (arms.type == Arms.HUMAN)
					nagaCounter++;
			}
			if (tongue.type == Tongue.SNAKE)
				nagaCounter++;
			if (faceType == Face.SNAKE_FANGS)
				nagaCounter++;
			if (hasPartialCoat(Skin.SCALES))
				nagaCounter++;
			if (eyes.type == Eyes.SNAKE)
				nagaCounter++;
			if (ears.type == Ears.SNAKE)
				nagaCounter++;
			if (findPerk(PerkLib.VenomGlands) >= 0)
				nagaCounter++;
			if (findPerk(PerkLib.VenomGlandsEvolved) >= 0)
				nagaCounter++;
			if (findPerk(PerkLib.VenomGlandsFinalForm) >= 0)
				nagaCounter++;
			if (findPerk(PerkLib.VenomGlands) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				nagaCounter++;
			if (findPerk(PerkLib.VenomGlandsEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				nagaCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && nagaCounter >= 4)
				nagaCounter++;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && nagaCounter >= 8)
				nagaCounter += 1;
			if (hairType == Hair.GORGON || eyes.type == Eyes.GORGON || horns.type == Horns.DRACONIC_X4_12_INCH_LONG || horns.type == Horns.DRACONIC_X2 || tongue.type == Tongue.DRACONIC || wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE || hairType == Hair.FEATHER || arms.type == Arms.HARPY || wings.type == Wings.FEATHERED_LARGE
			 || lowerBody == LowerBody.HYDRA || arms.type == Arms.HYDRA)
				nagaCounter = 0;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				nagaCounter += 50;
			if (isGargoyle()) nagaCounter = 0;
			End("Player","racialScore");
			return nagaCounter;
		}
		//Gorgon score
		public function gorgonScore():Number {
			Begin("Player","racialScore","gorgon");
			var gorgonCounter:Number = 0;
			if (isNaga())
				gorgonCounter += 2;
			if (tongue.type == Tongue.SNAKE)
				gorgonCounter++;
			if (faceType == Face.SNAKE_FANGS)
				gorgonCounter++;
			if (arms.type == Arms.HUMAN)
				gorgonCounter++;
			if (hasCoatOfType(Skin.SCALES))
				gorgonCounter++;
			if (ears.type == Ears.SNAKE)
				gorgonCounter++;
			if (eyes.type == Eyes.SNAKE)
				gorgonCounter++;
			if (eyes.type == Eyes.GORGON)
				gorgonCounter += 2;
			if (hairType == Hair.GORGON)
				gorgonCounter += 2;
			if (findPerk(PerkLib.GorgonsEyes) >= 0)
				gorgonCounter++;
			if (findPerk(PerkLib.GorgonsEyesEvolved) >= 0)
				gorgonCounter++;
			if (findPerk(PerkLib.VenomGlands) >= 0)
				gorgonCounter++;
			if (findPerk(PerkLib.VenomGlandsEvolved) >= 0)
				gorgonCounter++;
			if (findPerk(PerkLib.VenomGlandsFinalForm) >= 0)
				gorgonCounter++;
			if ((findPerk(PerkLib.GorgonsEyes) >= 0 || findPerk(PerkLib.VenomGlands) >= 0) && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				gorgonCounter++;
			if ((findPerk(PerkLib.GorgonsEyesEvolved) >= 0 || findPerk(PerkLib.VenomGlandsEvolved) >= 0) && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				gorgonCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && gorgonCounter >= 4)
				gorgonCounter++;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && gorgonCounter >= 8)
				gorgonCounter += 1;
			if (nagaScore() > 10 || horns.type == Horns.DRACONIC_X4_12_INCH_LONG || horns.type == Horns.DRACONIC_X2 || tongue.type == Tongue.DRACONIC || wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE || hairType == Hair.FEATHER || arms.type == Arms.HARPY || wings.type == Wings.FEATHERED_LARGE
			 || lowerBody == LowerBody.HYDRA || arms.type == Arms.HYDRA)
				gorgonCounter = 0;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				gorgonCounter += 50;
			if (isGargoyle()) gorgonCounter = 0;
			End("Player","racialScore");
			return gorgonCounter;
		}
		//Vouivre score
		public function vouivreScore():Number {
			Begin("Player","racialScore","vouivre");
			var vouivreCounter:Number = 0;
			if (isNaga())
				vouivreCounter += 2;
			if (tongue.type == Tongue.SNAKE || tongue.type == Tongue.DRACONIC)
				vouivreCounter++;
			if (faceType == Face.SNAKE_FANGS)
				vouivreCounter++;
			if (arms.type == Arms.DRAGON)
				vouivreCounter++;
			if (hasCoatOfType(Skin.DRAGON_SCALES))
				vouivreCounter++;
			if (eyes.type == Eyes.SNAKE)
				vouivreCounter++;
			if (ears.type == Ears.DRAGON)
				vouivreCounter++;
			if (horns.type == Horns.DRACONIC_X4_12_INCH_LONG || horns.type == Horns.DRACONIC_X2)
				vouivreCounter++;
			if (wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE)
				vouivreCounter += 2;
			if (vouivreCounter >= 11) {
				if (findPerk(PerkLib.DragonFireBreath) >= 0)
					vouivreCounter++;
				if (findPerk(PerkLib.DragonIceBreath) >= 0)
					vouivreCounter++;
				if (findPerk(PerkLib.DragonLightningBreath) >= 0)
					vouivreCounter++;
				if (findPerk(PerkLib.DragonDarknessBreath) >= 0)
					vouivreCounter++;
			}
			if (findPerk(PerkLib.DraconicLungs) >= 0)
				vouivreCounter++;
			if (findPerk(PerkLib.DraconicLungsEvolved) >= 0)
				vouivreCounter++;
			if (findPerk(PerkLib.DraconicLungsFinalForm) >= 0)
				vouivreCounter++;
			if (findPerk(PerkLib.VenomGlands) >= 0)
				vouivreCounter++;
			if (findPerk(PerkLib.VenomGlandsEvolved) >= 0)
				vouivreCounter++;
			if (findPerk(PerkLib.VenomGlandsFinalForm) >= 0)
				vouivreCounter++;
			if ((findPerk(PerkLib.DraconicLungs) >= 0 || findPerk(PerkLib.VenomGlands) >= 0) && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				vouivreCounter++;
			if ((findPerk(PerkLib.DraconicLungsEvolved) >= 0 || findPerk(PerkLib.VenomGlandsEvolved) >= 0) && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				vouivreCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && vouivreCounter >= 4)
				vouivreCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && vouivreCounter >= 8)
				vouivreCounter += 1;
			if (nagaScore() > 10 || hairType == Hair.GORGON || eyes.type == Eyes.GORGON || hairType == Hair.FEATHER || arms.type == Arms.HARPY || wings.type == Wings.FEATHERED_LARGE || lowerBody == LowerBody.HYDRA || arms.type == Arms.HYDRA)
				vouivreCounter = 0;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				vouivreCounter += 50;
			if (isGargoyle()) vouivreCounter = 0;
			End("Player","racialScore");
			return vouivreCounter;
		}
		//Couatl score
		public function couatlScore():Number {
			Begin("Player","racialScore","couatl");
			var couatlCounter:Number = 0;
			if (isNaga())
				couatlCounter += 2;
			if (tongue.type == Tongue.SNAKE)
				couatlCounter++;
			if (faceType == Face.SNAKE_FANGS)
				couatlCounter++;
			if (arms.type == Arms.HARPY)
				couatlCounter++;
			if (hasCoatOfType(Skin.SCALES))
				couatlCounter++;
			if (ears.type == Ears.SNAKE)
				couatlCounter++;
			if (eyes.type == Eyes.SNAKE)
				couatlCounter++;
			if (hairType == Hair.FEATHER)
				couatlCounter++;
			if (wings.type == Wings.FEATHERED_LARGE)
				couatlCounter += 2;
			if (findPerk(PerkLib.VenomGlands) >= 0)
				couatlCounter++;
			if (findPerk(PerkLib.VenomGlandsEvolved) >= 0)
				couatlCounter++;
			if (findPerk(PerkLib.VenomGlandsFinalForm) >= 0)
				couatlCounter++;
			if (findPerk(PerkLib.VenomGlands) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				couatlCounter++;
			if (findPerk(PerkLib.VenomGlandsEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				couatlCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && couatlCounter >= 4)
				couatlCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && couatlCounter >= 8)
				couatlCounter += 1;
			if (nagaScore() > 10 || hairType == Hair.GORGON || eyes.type == Eyes.GORGON || horns.type == Horns.DRACONIC_X4_12_INCH_LONG || horns.type == Horns.DRACONIC_X2 || tongue.type == Tongue.DRACONIC || wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE || lowerBody == LowerBody.HYDRA || arms.type == Arms.HYDRA)
				couatlCounter = 0;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				couatlCounter += 50;
			if (isGargoyle()) couatlCounter = 0;
			End("Player","racialScore");
			return couatlCounter;
		}
		//hydra score
		public function hydraScore():Number {
			Begin("Player","racialScore","hydra");
			var hydraCounter:Number = 0;
			if (lowerBody == LowerBody.HYDRA && statusEffectv1(StatusEffects.HydraTailsPlayer) >= 2) {
				hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 3)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 4)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 5)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 6)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 7)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 8)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 9)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 10)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 11)
					hydraCounter++;
				if (statusEffectv1(StatusEffects.HydraTailsPlayer) >= 12)
					hydraCounter++;
			}
			if (arms.type == Arms.HYDRA)
				hydraCounter++;
			if (hairType == Hair.NORMAL || hairType == Hair.GORGON)
				hydraCounter++;
			if (tongue.type == Tongue.SNAKE)
				hydraCounter++;
			if (faceType == Face.SNAKE_FANGS)
				hydraCounter++;
			if (hasPartialCoat(Skin.SCALES))
				hydraCounter++;
			if (eyes.type == Eyes.SNAKE)
				hydraCounter++;
			if (ears.type == Ears.SNAKE)
				hydraCounter++;
			if (wings.type == Wings.NONE)
				hydraCounter += 2;
			if (tallness >= 120)
				hydraCounter++;
			if (findPerk(PerkLib.LizanRegeneration) >= 0)
				hydraCounter++;
			if (findPerk(PerkLib.HydraRegeneration) >= 0)
				hydraCounter++;
			if (findPerk(PerkLib.HydraAcidBreath) >= 0)
				hydraCounter++;
			if (findPerk(PerkLib.VenomGlands) >= 0)
				hydraCounter++;
			if (findPerk(PerkLib.VenomGlandsEvolved) >= 0)
				hydraCounter++;
			if (findPerk(PerkLib.VenomGlandsFinalForm) >= 0)
				hydraCounter++;
			if (findPerk(PerkLib.VenomGlands) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				hydraCounter++;
			if (findPerk(PerkLib.VenomGlandsEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				hydraCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && hydraCounter >= 4)
				hydraCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && hydraCounter >= 8)
				hydraCounter += 1;
			if (nagaScore() > 10 || eyes.type == Eyes.GORGON || horns.type == Horns.DRACONIC_X4_12_INCH_LONG || horns.type == Horns.DRACONIC_X2 || tongue.type == Tongue.DRACONIC || wings.type == Wings.DRACONIC_SMALL || wings.type == Wings.DRACONIC_LARGE || wings.type == Wings.DRACONIC_HUGE || hairType == Hair.FEATHER || arms.type == Arms.HARPY || wings.type == Wings.FEATHERED_LARGE)
				hydraCounter = 0;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				hydraCounter += 50;
			if (isGargoyle()) hydraCounter = 0;
			End("Player","racialScore");
			return hydraCounter;
		}

		//hydra score
		public function firesnailScore():Number {
			Begin("Player","racialScore","firesnail");
			var firesnailCounter:Number = 0;
			if (antennae.type == Antennae.FIRE_SNAIL)
				firesnailCounter++;
			if (eyes.type == Eyes.FIRE_SNAIL)
				firesnailCounter++;
			if (eyes.colour == "red" || eyes.colour == "orange" || eyes.colour == "yellow")
				firesnailCounter++;
			if (eyes.type == Eyes.FIRE_SNAIL)
				firesnailCounter++;
			if (hasPlainSkinOnly() && skinAdj == "sticky glistering")
				firesnailCounter++;
			if (skinTone == "red" || skinTone == "orange")
				firesnailCounter++;
			if (hairType == Hair.BURNING)
				firesnailCounter++;
			if (faceType == Face.FIRE_SNAIL)
				firesnailCounter++;
			if (lowerBody == LowerBody.FIRE_SNAIL) {
				firesnailCounter++;
				if (tailType == Tail.NONE)
					firesnailCounter += 2;
			}
			if (rearBody.type == RearBody.SNAIL_SHELL) {
				firesnailCounter++;
				if (wings.type == Wings.NONE)
					firesnailCounter += 4;
			}
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				firesnailCounter += 50;
			if (isGargoyle()) firesnailCounter = 0;
			End("Player","racialScore");
			return firesnailCounter;
		}

		//poltergeist score
		public function poltergeistScore():Number {
			Begin("Player","racialScore","poltergeist");
			var poltergeistCounter:Number = 0;
			if (hairType == Hair.GHOST)
				poltergeistCounter++;
			if (eyes.type == Eyes.GHOST)
				poltergeistCounter++;
			if (faceType == Face.GHOST)
				poltergeistCounter++;
			if (tongue.type == Tongue.GHOST)
				poltergeistCounter++;
			if (horns.type == Horns.GHOSTLY_WISPS)
				poltergeistCounter++;
			if (arms.type == Arms.GHOST)
				poltergeistCounter++;
			if (lowerBody == LowerBody.GHOST)
				poltergeistCounter++;
			if (lowerBody == LowerBody.GHOST_2)
				poltergeistCounter += 2;
			if (wings.type == Wings.ETHEREAL_WINGS)
				poltergeistCounter += 2;
			if (tailType == Tail.NONE)
				poltergeistCounter++;
			if (antennae.type == Antennae.NONE)
				poltergeistCounter++;
			if (rearBody.type == RearBody.GHOSTLY_AURA)
				poltergeistCounter++;
			if (skin.base.pattern == Skin.PATTERN_WHITE_BLACK_VEINS)
				poltergeistCounter++;
			if (hasPlainSkinOnly() && (skinAdj == "milky" && skinTone == "white") || (skinAdj == "ashen" && skinTone == "sable"))
				poltergeistCounter++;
			if (hasGhostSkin() && (skinAdj == "milky" || skinAdj == "ashen"))
				poltergeistCounter++;
			if (findPerk(PerkLib.Incorporeality) >= 0)
				poltergeistCounter++;
			if (findPerk(PerkLib.Ghostslinger) >= 0)
				poltergeistCounter++;
			if (findPerk(PerkLib.PhantomShooting) >= 0)
				poltergeistCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && poltergeistCounter >= 4)
				poltergeistCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && poltergeistCounter >= 8)
				poltergeistCounter += 1;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				poltergeistCounter += 50;
			if (isGargoyle()) poltergeistCounter = 0;
			End("Player","racialScore");
			return poltergeistCounter;
		}
		public function bansheeScore():Number {
			Begin("Player","racialScore","banshee");
			var bansheeCounter:Number = 0;
			if (hairType == Hair.GHOST)
				bansheeCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				bansheeCounter += 50;
			if (isGargoyle()) bansheeCounter = 0;
			End("Player","racialScore");
			return bansheeCounter;
		}

		//Bunny score
		public function bunnyScore():Number {
			Begin("Player","racialScore","bunny");
			var bunnyCounter:Number = 0;
			if (faceType == Face.BUNNY)
				bunnyCounter++;
			if (ears.type == Ears.BUNNY)
				bunnyCounter++;
			if (lowerBody == LowerBody.BUNNY)
				bunnyCounter++;
			if (tailType == Tail.RABBIT)
				bunnyCounter++;
			if (hasFur() || hasPartialCoat(Skin.FUR))
				bunnyCounter++;
			if (bunnyCounter > 4) {
				if (eyes.type == Eyes.HUMAN)
					bunnyCounter++;
				if (arms.type == Arms.HUMAN)
					bunnyCounter++;
			}
			if (bunnyCounter > 0 && antennae.type == 0)
				bunnyCounter++;
			if (bunnyCounter > 0 && wings.type == Wings.NONE)
				bunnyCounter++;
			if (tallness < 72)
				bunnyCounter++;
			if (balls > 2 && bunnyCounter > 0)
				bunnyCounter--;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				bunnyCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && bunnyCounter >= 4)
				bunnyCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && bunnyCounter >= 8)
				bunnyCounter += 1;
			if (isGargoyle()) bunnyCounter = 0;
			End("Player","racialScore");
			return bunnyCounter;
		}

		//Harpy score
		public function harpyScore():Number {
			Begin("Player","racialScore","harpy");
			var harpy:Number = 0;
			if (arms.type == Arms.HARPY)
				harpy++;
			if (hairType == Hair.FEATHER)
				harpy++;
			if (wings.type == Wings.FEATHERED_LARGE)
				harpy += 2;
			if (tailType == Tail.HARPY)
				harpy++;
			if (tailType == Tail.SHARK || tailType == Tail.SALAMANDER)
				harpy -= 5;
			if (lowerBody == LowerBody.HARPY)
				harpy++;
			if (lowerBody == LowerBody.SALAMANDER)
				harpy--;
			if (harpy >= 2 && faceType == Face.HUMAN)
				harpy++;
			if (faceType == Face.SHARK_TEETH)
				harpy--;
			if (harpy >= 2 && (ears.type == Ears.HUMAN || ears.type == Ears.ELFIN))
				harpy++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				harpy += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && harpy >= 4)
				harpy += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && harpy >= 8)
				harpy += 1;
			if (isGargoyle()) harpy = 0;
			End("Player","racialScore");
			return harpy;
		}

		//Kanga score
		public function kangaScore():Number {
			Begin("Player","racialScore","kanga");
			var kanga:Number = 0;
			if (kangaCocks() > 0)
				kanga++;
			if (ears.type == Ears.KANGAROO)
				kanga++;
			if (tailType == Tail.KANGAROO)
				kanga++;
			if (lowerBody == LowerBody.KANGAROO)
				kanga++;
			if (faceType == Face.KANGAROO)
				kanga++;
			if (kanga >= 2 && hasFur())
				kanga++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				kanga += 50;
			if (isGargoyle()) kanga = 0;
			End("Player","racialScore");
			return kanga;
		}

		//shark score
		public function sharkScore():Number {
			Begin("Player","racialScore","shark");
			var sharkCounter:Number = 0;
			if (faceType == Face.SHARK_TEETH)
				sharkCounter++;
			if (gills.type == Gills.FISH)
				sharkCounter++;
			if (ears.type == Ears.SHARK)
				sharkCounter++;
			if (rearBody.type == RearBody.SHARK_FIN)
				sharkCounter++;
			if (wings.type == Wings.SHARK_FIN)
				sharkCounter -= 7;
			if (arms.type == Arms.SHARK)
				sharkCounter++;
			if (lowerBody == LowerBody.SHARK)
				sharkCounter++;
			if (tailType == Tail.SHARK)
				sharkCounter++;
			if (hairType == Hair.NORMAL && hairColor == "silver")
				sharkCounter++;
			if (hasScales() && InCollection(skin.coat.color, "rough gray","orange","dark gray","iridescent gray","ashen grayish-blue","gray"))
				sharkCounter++;
			if (eyes.type == Eyes.HUMAN && hairType == Hair.NORMAL && hairColor == "silver" && hasScales() && InCollection(skin.coat.color, "rough gray","orange","dark gray","iridescent gray","ashen grayish-blue","gray"))
				sharkCounter++;
			if (vaginas.length > 0 && cocks.length > 0)
				sharkCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				sharkCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && sharkCounter >= 4)
				sharkCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && sharkCounter >= 8)
				sharkCounter += 1;
			if (isGargoyle()) sharkCounter = 0;
			End("Player","racialScore");
			return sharkCounter;
		}

		//Orca score
		public function orcaScore():Number {
			Begin("Player","racialScore","orca");
			var orcaCounter:Number = 0;
			if (ears.type == Ears.ORCA)
				orcaCounter++;
			if (tailType == Tail.ORCA)
				orcaCounter++;
			if (faceType == Face.ORCA)
				orcaCounter++;
			if (lowerBody == LowerBody.ORCA)
				orcaCounter++;
			if (arms.type == Arms.ORCA)
				orcaCounter++;
			if (rearBody.type == RearBody.ORCA_BLOWHOLE)
				orcaCounter++;
			if (hasPlainSkinOnly() && skinAdj == "glossy")
				orcaCounter++;
			if (skin.base.pattern == Skin.PATTERN_ORCA_UNDERBODY)
				orcaCounter++;
			if (wings.type == Wings.NONE)
				orcaCounter += 2;
			if (eyes.type == Eyes.HUMAN)
				orcaCounter++;
			if (tallness >= 84)
				orcaCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				orcaCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && orcaCounter >= 4)
				orcaCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && orcaCounter >= 8)
				orcaCounter += 1;
			if (isGargoyle()) orcaCounter = 0;
			End("Player","racialScore");
			return orcaCounter;
		}

		//Oni score
		public function oniScore():Number {
			Begin("Player","racialScore","oni");
			var oniCounter:Number = 0;
			if (ears.type == Ears.ONI)
				oniCounter++;
			if (faceType == Face.ONI_TEETH)
				oniCounter++;
			if (horns.type == Horns.ONI || horns.type == Horns.ONI_X2)
				oniCounter++;
			if (arms.type == Arms.ONI)
				oniCounter++;
			if (lowerBody == LowerBody.ONI)
				oniCounter++;
			if (eyes.type == Eyes.ONI && InCollection(eyes.colour,Mutations.oniEyeColors))
				oniCounter++;
			if (skinTone == "red" || skinTone == "reddish orange" || skinTone == "purple" || skinTone == "blue")
				oniCounter++;
			if (skin.base.pattern == Skin.PATTERN_BATTLE_TATTOO)
				oniCounter++;
			if (tailType == Tail.NONE)
				oniCounter++;
			if (tone >= 75)
				oniCounter++;
			if (tone >= 150 && oniCounter >= 4)
				oniCounter++;
			if ((hasVagina() && biggestTitSize() >= 19) || (cocks.length > 18))
				oniCounter++;
			if (tallness >= 108)
				oniCounter++;
			if (findPerk(PerkLib.OniMusculature) >= 0)
				oniCounter++;
			if (findPerk(PerkLib.OniMusculatureEvolved) >= 0)
				oniCounter++;
			if (findPerk(PerkLib.OniMusculatureFinalForm) >= 0)
				oniCounter++;
			if (findPerk(PerkLib.OniMusculature) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				oniCounter++;
			if (findPerk(PerkLib.OniMusculatureEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				oniCounter++;
			if (findPerk(PerkLib.OnisDescendant) >= 0 || findPerk(PerkLib.BloodlineOni) >= 0)
				oniCounter += 2;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				oniCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && oniCounter >= 4)
				oniCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && oniCounter >= 8)
				oniCounter += 1;
			if (isGargoyle()) oniCounter = 0;
			End("Player","racialScore");
			return oniCounter;
		}
		
		//Elf score
		public function elfScore():Number {
			Begin("Player","racialScore","elf");
			var elfCounter:Number = 0;
			if (ears.type == Ears.ELVEN)
				elfCounter++;
			if (eyes.type == Eyes.ELF)
				elfCounter++;
			if (tongue.type == Tongue.ELF)
				elfCounter++;
			if (arms.type == Arms.ELF)
				elfCounter++;
			if (lowerBody == LowerBody.ELF)
				elfCounter++;
			if (hairType == Hair.SILKEN)
				elfCounter++;
			if (wings.type == Wings.NONE)
				elfCounter++;
			if (elfCounter >= 2) {
				if (hairColor == "black" || hairColor == "leaf green" || hairColor == "golden blonde" || hairColor == "silver")
					elfCounter++;
				if (skinTone == "dark" || skinTone == "light" || skinTone == "tan")
					elfCounter++;
				if (skinType == Skin.PLAIN && skinAdj == "flawless")
					elfCounter++;
				if (tone <= 60)
					elfCounter++;
				if (thickness <= 50)
					elfCounter++;
				if (hasCock() && cocks.length < 6)
					elfCounter++;
				if (hasVagina() && biggestTitSize() >= 3)
					elfCounter++;
			}
			if (findPerk(PerkLib.FlawlessBody) >= 0)
				elfCounter++;
			if (findPerk(PerkLib.ElvenSense) >= 0)
				elfCounter++;
			if (findPerk(PerkLib.ElvishPeripheralNervSys) >= 0)
				elfCounter++;
			if (findPerk(PerkLib.ElvishPeripheralNervSysEvolved) >= 0)
				elfCounter++;
			if (findPerk(PerkLib.ElvishPeripheralNervSysFinalForm) >= 0)
				elfCounter++;
			if (findPerk(PerkLib.ElvishPeripheralNervSys) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				elfCounter++;
			if (findPerk(PerkLib.ElvishPeripheralNervSysEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				elfCounter++;/*
			if (elfCounter >= 11) {
				if (wings.type == Wings.)
					elfCounter++;
			}*/
			if (findPerk(PerkLib.ElfsDescendant) >= 0 || findPerk(PerkLib.BloodlineElf) >= 0)
				elfCounter += 2;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				elfCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && elfCounter >= 4)
				elfCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && elfCounter >= 8)
				elfCounter += 1;
			if (isGargoyle()) elfCounter = 0;
			End("Player","racialScore");
			return elfCounter;
		}
		
		//Orc score
		public function orcScore():Number {
			Begin("Player","racialScore","orc");
			var orcCounter:Number = 0;
			if (ears.type == Ears.ELFIN)
				orcCounter++;
			if (eyes.type == Eyes.ORC)
				orcCounter++;
			if (faceType == Face.ORC_FANGS)
				orcCounter++;
			if (arms.type == Arms.ORC)
				orcCounter++;
			if (lowerBody == LowerBody.ORC)
				orcCounter++;
			if (skin.base.pattern == Skin.PATTERN_SCAR_SHAPED_TATTOO)
				orcCounter++;
			if (tailType == Tail.NONE)
				orcCounter++;
			if (orcCounter >= 2) {
				if (skinTone == "green" || skinTone == "grey" || skinTone == "brown" || skinTone == "red" || skinTone == "sandy tan")
					orcCounter++;
				if (skinType == Skin.PLAIN)
					orcCounter++;
				if (tone >= 70)
					orcCounter++;
				if (tone >= 105)
					orcCounter++;
				if (thickness <= 60)
					orcCounter++;
				if (thickness <= 20)
					orcCounter++;
			}
			if (findPerk(PerkLib.Ferocity) >= 0)
				orcCounter += 2;
			if (findPerk(PerkLib.OrcAdrenalGlands) >= 0)
				orcCounter++;
			if (findPerk(PerkLib.OrcAdrenalGlandsEvolved) >= 0)
				orcCounter++;
			if (findPerk(PerkLib.OrcAdrenalGlandsFinalForm) >= 0)
				orcCounter++;
			if (findPerk(PerkLib.OrcAdrenalGlands) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				orcCounter++;
			if (findPerk(PerkLib.OrcAdrenalGlandsEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				orcCounter++;/*
			if (orcCounter >= 11) {
				if (tailType == Tail.)
					orcCounter++;
			}*/
			if (findPerk(PerkLib.OrcsDescendant) >= 0 || findPerk(PerkLib.BloodlineOrc) >= 0)
				orcCounter += 2;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				orcCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && orcCounter >= 4)
				orcCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && orcCounter >= 8)
				orcCounter += 1;
			if (isGargoyle()) orcCounter = 0;
			End("Player","racialScore");
			return orcCounter;
		}

		//Raiju score
		public function raijuScore():Number {
			Begin("Player","racialScore","raiju");
			var raijuCounter:Number = 0;
			if (ears.type == Ears.WEASEL)
				raijuCounter++;
			if (eyes.type == Eyes.RAIJU)
				raijuCounter++;
			if (faceType == Face.RAIJU_FANGS)
				raijuCounter++;
			if (arms.type == Arms.RAIJU || arms.type == Arms.RAIJU_2)
				raijuCounter++;
			if (lowerBody == LowerBody.RAIJU)
				raijuCounter++;
			if (tailType == Tail.RAIJU)
				raijuCounter++;
			if (wings.type == Wings.THUNDEROUS_AURA)
				raijuCounter++;
			if (rearBody.type == RearBody.RAIJU_MANE)
				raijuCounter++;
			if (skin.base.pattern == Skin.PATTERN_LIGHTNING_SHAPED_TATTOO)
				raijuCounter++;
			if (hairType == Hair.STORM)
				raijuCounter++;
			if (hairColor == "purple" || hairColor == "light blue" || hairColor == "yellow" || hairColor == "white" || hairColor == "lilac" || hairColor == "green")
				raijuCounter++;
			if (findPerk(PerkLib.RaijusDescendant) >= 0 || findPerk(PerkLib.BloodlineRaiju) >= 0)
				raijuCounter += 2;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				raijuCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && raijuCounter >= 4)
				raijuCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && raijuCounter >= 8)
				raijuCounter += 1;
			if (isGargoyle()) raijuCounter = 0;
			End("Player","racialScore");
			return raijuCounter;
		}

		//Thunderbird score
		public function thunderbirdScore():Number {
			Begin("Player","racialScore","thunderbird");
			var thunderbirdCounter:Number = 0;
			if (ears.type == Ears.ELFIN)
				thunderbirdCounter++;
			if (eyes.type == Eyes.RAIJU)
				thunderbirdCounter++;
			if (faceType == Face.HUMAN)
				thunderbirdCounter++;
			if (arms.type == Arms.HARPY)
				thunderbirdCounter++;
			if (wings.type == Wings.FEATHERED_LARGE)
				thunderbirdCounter += 2;
			if (lowerBody == LowerBody.HARPY)
				thunderbirdCounter++;
			if (tailType == Tail.THUNDERBIRD)
				thunderbirdCounter++;
			if (rearBody.type == RearBody.RAIJU_MANE)
				thunderbirdCounter++;
			if (skin.base.pattern == Skin.PATTERN_LIGHTNING_SHAPED_TATTOO)
				thunderbirdCounter++;
			if (hairType == Hair.STORM)
				thunderbirdCounter++;
			if (hairColor == "purple" || hairColor == "light blue" || hairColor == "yellow" || hairColor == "white")
				thunderbirdCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				thunderbirdCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && thunderbirdCounter >= 4)
				thunderbirdCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && thunderbirdCounter >= 8)
				thunderbirdCounter += 1;
			if (isGargoyle()) thunderbirdCounter = 0;
			End("Player","racialScore");
			return thunderbirdCounter;
		}

		//Determine Mutant Rating
		public function mutantScore():Number{
			Begin("Player","racialScore","mutant");
			var mutantCounter:Number = 0;
			if (faceType != Face.HUMAN)
				mutantCounter++;
			if (!hasPlainSkinOnly())
				mutantCounter++;
			if (tailType != Tail.NONE)
				mutantCounter++;
			if (cockTotal() > 1)
				mutantCounter++;
			if (hasCock() && hasVagina())
				mutantCounter++;
			if (hasFuckableNipples())
				mutantCounter++;
			if (breastRows.length > 1)
				mutantCounter++;
			if (faceType == Face.HORSE)
			{
				if (hasFur())
					mutantCounter--;
				if (tailType == Tail.HORSE)
					mutantCounter--;
			}
			if (faceType == Face.DOG)
			{
				if (hasFur())
					mutantCounter--;
				if (tailType == Tail.DOG)
					mutantCounter--;
			}
			if (isGargoyle()) mutantCounter = 0;
			End("Player","racialScore");
			return mutantCounter;
		}
		
		//scorpion score
		public function scorpionScore():Number {
			Begin("Player","racialScore","scorpion");
			var scorpionCounter:Number = 0;
			if (hasCoatOfType(Skin.CHITIN))
				scorpionCounter++;
			if (tailType == Tail.SCORPION)
				scorpionCounter++;
			if (scorpionCounter > 0 && findPerk(PerkLib.TrachealSystem) >= 0)
				scorpionCounter++;
			if (scorpionCounter > 4 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
				scorpionCounter++;
			if (scorpionCounter > 8 && findPerk(PerkLib.TrachealSystemFinalForm) >= 0)
				scorpionCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				scorpionCounter += 50;
			if (isGargoyle()) scorpionCounter = 0;
			End("Player","racialScore");
			return scorpionCounter;
		}
		
		//Mantis score
		public function mantisScore():Number {
			Begin("Player","racialScore","mantis");
			var mantisCounter:Number = 0;
			if (hasCoatOfType(Skin.CHITIN))
				mantisCounter += 3;//mantisCounter++;
			if (antennae.type == Antennae.MANTIS)
			{
				mantisCounter++;
				if (faceType == Face.HUMAN)
					mantisCounter++;
			}
			if (arms.type == Arms.MANTIS)
				mantisCounter++;
			if (lowerBody == LowerBody.MANTIS)
				mantisCounter++;
			if (tailType == Tail.MANTIS_ABDOMEN)
				mantisCounter++;
			if (wings.type == Wings.MANTIS_LIKE_SMALL)
				mantisCounter++;
			if (wings.type == Wings.MANTIS_LIKE_LARGE)
				mantisCounter += 2;
			if (wings.type == Wings.MANTIS_LIKE_LARGE_2)
				mantisCounter += 4;
			if (findPerk(PerkLib.MantisOvipositor) >= 0)
				mantisCounter++;
			if (mantisCounter > 0 && findPerk(PerkLib.TrachealSystem) >= 0)
				mantisCounter++;
			if (mantisCounter > 4 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
				mantisCounter++;
			if (mantisCounter > 8 && findPerk(PerkLib.TrachealSystemFinalForm) >= 0)
				mantisCounter++;
			if (findPerk(PerkLib.MantislikeAgility) >= 0)
				mantisCounter++;
			if (findPerk(PerkLib.MantislikeAgilityEvolved) >= 0)
				mantisCounter++;
			if ((findPerk(PerkLib.TrachealSystem) >= 0 || findPerk(PerkLib.MantislikeAgility) >= 0) && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				mantisCounter++;
			if ((findPerk(PerkLib.TrachealSystemEvolved) >= 0 || findPerk(PerkLib.MantislikeAgilityEvolved) >= 0) && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				mantisCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				mantisCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && mantisCounter >= 4)
				mantisCounter++;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && mantisCounter >= 8)
				mantisCounter += 1;
			if (isGargoyle()) mantisCounter = 0;
			End("Player","racialScore");
			return mantisCounter;
		}
		
		//Thunder Mantis score
		//4 eyes - adj spider 4 eyes desc
		//var. of arms, legs, wings, tail, ears
		
		//Salamander score
		public function salamanderScore():Number {
			Begin("Player","racialScore","salamander");
			var salamanderCounter:Number = 0;
			if (hasPartialCoat(Skin.SCALES))
				salamanderCounter++;
			if (faceType == Face.SALAMANDER_FANGS) {
				salamanderCounter++;
				if (ears.type == Ears.HUMAN)
					salamanderCounter++;
			}
			if (eyes.type == Eyes.REPTILIAN)
				salamanderCounter++;
			if (arms.type == Arms.SALAMANDER)
				salamanderCounter++;
			if (lowerBody == LowerBody.SALAMANDER)
				salamanderCounter++;
			if (tailType == Tail.SALAMANDER)
				salamanderCounter++;
			if (lizardCocks() > 0)
				salamanderCounter++;
			if (findPerk(PerkLib.Lustzerker) >= 0)
				salamanderCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlands) >= 0)
				salamanderCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlandsEvolved) >= 0)
				salamanderCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlandsFinalForm) >= 0)
				salamanderCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlands) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				salamanderCounter++;
			if (findPerk(PerkLib.SalamanderAdrenalGlandsEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				salamanderCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				salamanderCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && salamanderCounter >= 4)
				salamanderCounter++;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && salamanderCounter >= 8)
				salamanderCounter += 1;
			if (isGargoyle()) salamanderCounter = 0;
			End("Player","racialScore");
			return salamanderCounter;
		}
		
		//Cave Wyrm score
		public function cavewyrmScore():Number {
			Begin("Player","racialScore","cavewyrm");
			var cavewyrmCounter:Number = 0;
			if (hasPartialCoat(Skin.SCALES)) {
				if (coatColor == "black") cavewyrmCounter++;
				cavewyrmCounter++;
			}
			if (skinTone == "greyish blue")
				cavewyrmCounter++;
			if (ears.type == Ears.CAVE_WYRM)
				cavewyrmCounter++;
			if (eyes.type == Eyes.CAVE_WYRM)
				cavewyrmCounter++;
			if (tongue.type == Tongue.CAVE_WYRM)
				cavewyrmCounter++;
			if (faceType == Face.SALAMANDER_FANGS)
				cavewyrmCounter++;
			if (arms.type == Arms.CAVE_WYRM)
				cavewyrmCounter++;
			if (lowerBody == LowerBody.CAVE_WYRM)
				cavewyrmCounter++;
			if (tailType == Tail.CAVE_WYRM)
				cavewyrmCounter++;
			if (hasStatusEffect(StatusEffects.GlowingNipples) || hasStatusEffect(StatusEffects.GlowingAsshole))
				cavewyrmCounter++;
			if (cavewyrmCocks() > 0 || vaginaType() == VaginaClass.CAVE_WYRM)
				cavewyrmCounter++;
			if (findPerk(PerkLib.AcidSpit) >= 0)
				cavewyrmCounter++;
			if (findPerk(PerkLib.AzureflameBreath) >= 0)
				cavewyrmCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				cavewyrmCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && cavewyrmCounter >= 4)
				cavewyrmCounter++;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && cavewyrmCounter >= 8)
				cavewyrmCounter += 1;
			if (isGargoyle()) cavewyrmCounter = 0;
			End("Player","racialScore");
			return cavewyrmCounter;
		}
		
		//Yeti score
		public function yetiScore():Number {
			Begin("Player","racialScore","yeti");
			var yetiCounter:Number = 0;
			if (skinTone == "dark" || skinTone == "tan")
				yetiCounter++;
			if (eyes.colour == "silver" || eyes.colour == "grey")
				yetiCounter++;
			if (lowerBody == LowerBody.YETI)
				yetiCounter++;
			if (arms.type == Arms.YETI)
				yetiCounter++;
			if (rearBody.type == RearBody.YETI_FUR)
				yetiCounter++;
			if (eyes.type == Eyes.HUMAN)
				yetiCounter++;
			if (ears.type == Ears.YETI)
				yetiCounter++;
			if (faceType == Face.YETI_FANGS)
				yetiCounter++;
			if (hairType == Hair.FLUFFY)
				yetiCounter++;
			if (hairColor == "white")
				yetiCounter++;
			if (hasPartialCoat(Skin.FUR))
				yetiCounter++;
			if (hasFur() && coatColor == "white")
				yetiCounter++;
			if (tallness >= 78)
				yetiCounter++;
			if (butt.type >= 10)
				yetiCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				yetiCounter += 50;
			if (isGargoyle()) yetiCounter = 0;
			End("Player","racialScore");
			return yetiCounter;
		}

		//Yuki Onna score
		public function yukiOnnaScore():Number {
			Begin("Player","racialScore","yuki onna");
			var yukiOnnaCounter:Number = 0;
			if (skinTone == "snow white" || skinTone == "pale blue" || skinTone == "glacial white")
				yukiOnnaCounter++;
			if (skinAdj == "cold")
				yukiOnnaCounter++;
			if (eyes.colour == "light purple")
				yukiOnnaCounter++;
			if (hairColor == "snow white" || hairColor == "silver white" || hairColor == "platinum blonde" || hairColor == "quartz white")
				yukiOnnaCounter++;
			if (hairType == Hair.SNOWY)
				yukiOnnaCounter++;
			if (lowerBody == LowerBody.YUKI_ONNA)
				yukiOnnaCounter++;
			if (arms.type == Arms.YUKI_ONNA)
				yukiOnnaCounter++;
			if (faceType == Face.YUKI_ONNA)
				yukiOnnaCounter++;
			if (rearBody.type == RearBody.GLACIAL_AURA)
				yukiOnnaCounter += 2;
			if (wings.type == Wings.LEVITATION)
				yukiOnnaCounter += 3;
			if (femininity > 99)
				yukiOnnaCounter++;
			if (!hasCock())
				yukiOnnaCounter++;
			if (hasVagina())
				yukiOnnaCounter++;
			if (findPerk(PerkLib.FrozenHeart) >= 0)
				yukiOnnaCounter++;
			if (findPerk(PerkLib.FrozenHeartEvolved) >= 0)
				yukiOnnaCounter++;
			if (findPerk(PerkLib.FrozenHeartFinalForm) >= 0)
				yukiOnnaCounter++;
			if (findPerk(PerkLib.FrozenHeart) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				yukiOnnaCounter++;
			if (findPerk(PerkLib.FrozenHeartEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				yukiOnnaCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				yukiOnnaCounter += 50;
			if (isGargoyle()) yukiOnnaCounter = 0;
			End("Player","racialScore");
			return yukiOnnaCounter;
		}

		//Centaur score
		public function centaurScore():Number
		{
			if (horns.type == Horns.UNICORN || horns.type == Horns.BICORN)
				return 0;
			Begin("Player","racialScore","centaur");
			var centaurCounter:Number = 0;
			if (isTaur()) {
				centaurCounter += 2;
				if (arms.type == Arms.HUMAN)
					centaurCounter++;
				if (ears.type == Ears.HUMAN)
					centaurCounter++;
				if (faceType == Face.HUMAN)
					centaurCounter++;
				if (findPerk(PerkLib.TwinHeart) >= 0)
					centaurCounter++;
				if (findPerk(PerkLib.TwinHeartEvolved) >= 0)
					centaurCounter++;
				if (findPerk(PerkLib.TwinHeartFinalForm) >= 0)
					centaurCounter++;
			}
			if (lowerBody == LowerBody.HOOFED || lowerBody == LowerBody.CLOVEN_HOOFED)
				centaurCounter++;
			if (tailType == Tail.HORSE)
				centaurCounter++;
			if (hasPlainSkinOnly())
				centaurCounter++;
			if (horseCocks() > 0)
				centaurCounter++;
			if (hasVagina() && vaginaType() == VaginaClass.EQUINE)
				centaurCounter++;
			if (wings.type != Wings.NONE)
				centaurCounter -= 3;
			if (findPerk(PerkLib.TwinHeart) >= 0)
				centaurCounter++;
			if (findPerk(PerkLib.TwinHeartEvolved) >= 0)
				centaurCounter++;
			if (findPerk(PerkLib.TwinHeartFinalForm) >= 0)
				centaurCounter++;
			if (findPerk(PerkLib.TwinHeart) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				centaurCounter++;
			if (findPerk(PerkLib.TwinHeartEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				centaurCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				centaurCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && centaurCounter >= 4)
				centaurCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && centaurCounter >= 8)
				centaurCounter += 1;
			if (isGargoyle()) centaurCounter = 0;
			End("Player","racialScore");
			return centaurCounter;
		}

		public function sphinxScore():Number
		{
			Begin("Player","racialScore","sphinx");
			var sphinxCounter:Number = 0;
			if (isTaur()) {
				if (lowerBody == LowerBody.CAT)
					sphinxCounter += 2;
				if (tailType == Tail.CAT && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
				if (skinType == 0 && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
				if (arms.type == Arms.SPHINX && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
				if (ears.type == Ears.LION && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
				if (faceType == Face.CAT_CANINES && (lowerBody == LowerBody.CAT))
					sphinxCounter++;
			}
			if (eyes.type == Eyes.CAT_SLITS)
				sphinxCounter++;
			if (ears.type == Ears.LION)
				sphinxCounter++;
			if (tongue.type == Tongue.CAT)
				sphinxCounter++;
			if (tailType == Tail.CAT)
				sphinxCounter++;
			if (tailType == Tail.LION)
				sphinxCounter++;
			if (lowerBody == LowerBody.CAT)
				sphinxCounter++;
			if (faceType == Face.CAT_CANINES)
				sphinxCounter++;
			if (wings.type == Wings.FEATHERED_SPHINX)
				sphinxCounter += 2;
			if (findPerk(PerkLib.Flexibility) > 0)
				sphinxCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) > 0)
				sphinxCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) > 0)
				sphinxCounter++;
			if (findPerk(PerkLib.CatlikeNimbleness) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				sphinxCounter++;
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				sphinxCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				sphinxCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && sphinxCounter >= 4)
				sphinxCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && sphinxCounter >= 8)
				sphinxCounter += 1;
			if (isGargoyle()) sphinxCounter = 0;
			End("Player","racialScore");
			return sphinxCounter;
		}

		//Determine Unicorn Rating
		public function unicornScore():Number {
			Begin("Player","racialScore","unicorn");
			var unicornCounter:Number = 0;
			if (faceType == Face.HORSE)
				unicornCounter += 2;
			if (faceType == Face.HUMAN)
				unicornCounter++;
			if (ears.type == Ears.HORSE)
				unicornCounter++;
			if (tailType == Tail.HORSE)
				unicornCounter++;
			if (lowerBody == LowerBody.HOOFED)
				unicornCounter++;
			if (eyes.type == Eyes.HUMAN)
				unicornCounter++;
			if (horns.type == Horns.UNICORN) {
				if (horns.count < 6)
					unicornCounter++;
				if (horns.count >= 6)
					unicornCounter += 2;
				if (hairColor == "platinum blonde" || hairColor == "silver" || hairColor == "white")
					unicornCounter++;
				if (eyes.colour == "blue")
					unicornCounter++;
				if (findPerk(PerkLib.AvatorOfPurity) >= 0)
					unicornCounter++;
			}
			if (horns.type == Horns.BICORN) {
				if (horns.count < 6)
					unicornCounter++;
				if (horns.count >= 6)
					unicornCounter += 2;
				if (hairColor == "black")
					unicornCounter++;
				if (eyes.colour == "red")
					unicornCounter++;
				if (findPerk(PerkLib.AvatorOfCorruption) >= 0)
					unicornCounter++;
			}
			if (hasFur() || hasPlainSkinOnly())
				unicornCounter++;
			if (horns.type != Horns.UNICORN && horns.type != Horns.BICORN && (wings.type == Wings.FEATHERED_ALICORN || wings.type == Wings.NIGHTMARE))
				unicornCounter = 0;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				unicornCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && unicornCounter >= 4)
				unicornCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && unicornCounter >= 8)
				unicornCounter += 1;
			if (isGargoyle()) unicornCounter = 0;
			End("Player","racialScore");
			return unicornCounter;
		}
		
		//Determine Alicorn Rating
		public function alicornScore():Number {
			Begin("Player","racialScore","alicorn");
			var alicornCounter:Number = 0;
			if (faceType == Face.HORSE)
				alicornCounter += 2;
			if (faceType == Face.HUMAN)
				alicornCounter++;
			if (ears.type == Ears.HORSE)
				alicornCounter++;
			if (tailType == Tail.HORSE)
				alicornCounter++;
			if (lowerBody == LowerBody.HOOFED)
				alicornCounter++;
			if (eyes.type == Eyes.HUMAN)
				alicornCounter++;
			if (horns.type == Horns.UNICORN) {
				if (horns.count < 6)
					alicornCounter++;
				if (horns.count >= 6)
					alicornCounter += 2;
				if (wings.type == Wings.FEATHERED_ALICORN)
					alicornCounter += 2;
				if (hairColor == "platinum blonde" || hairColor == "silver" || hairColor == "white")
					alicornCounter++;
				if (eyes.colour == "blue")
					alicornCounter++;
				if (findPerk(PerkLib.AvatorOfPurity) >= 0)
					alicornCounter++;
			}
			if (horns.type == Horns.BICORN) {
				if (horns.count < 6)
					alicornCounter++;
				if (horns.count >= 6)
					alicornCounter += 2;
				if (wings.type == Wings.NIGHTMARE)
					alicornCounter += 2;
				if (hairColor == "black")
					alicornCounter++;
				if (eyes.colour == "red")
					alicornCounter++;
				if (findPerk(PerkLib.AvatorOfCorruption) >= 0)
					alicornCounter++;
			}
			if (hasFur() || hasPlainSkinOnly())
				alicornCounter++;
			if (horns.type != Horns.UNICORN && wings.type != Wings.FEATHERED_ALICORN && horns.type != Horns.BICORN && wings.type != Wings.NIGHTMARE)
				alicornCounter = 0;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				alicornCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && alicornCounter >= 4)
				alicornCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && alicornCounter >= 8)
				alicornCounter += 1;
			if (isGargoyle()) alicornCounter = 0;
			End("Player","racialScore");
			return alicornCounter;
		}
		
		//Determine Phoenix Rating
		public function phoenixScore():Number {
			Begin("Player","racialScore","phoenix");
			var phoenixCounter:Number = 0;
			if (wings.type == Wings.FEATHERED_PHOENIX)
				phoenixCounter++;
			if (arms.type == Arms.PHOENIX)
				phoenixCounter++;
			if (hairType == Hair.FEATHER) {
				phoenixCounter++;
				if (faceType == Face.HUMAN && phoenixCounter > 2)
					phoenixCounter++;
				if (ears.type == Ears.HUMAN && phoenixCounter > 2)
					phoenixCounter++;
			}
			if (eyes.type == Eyes.REPTILIAN)
				phoenixCounter++;
			if (lowerBody == LowerBody.SALAMANDER)
				phoenixCounter++;
			if (tailType == Tail.SALAMANDER)
				phoenixCounter++;
			if (hasPartialCoat(Skin.SCALES))
				phoenixCounter++;
			if (lizardCocks() > 0)
				phoenixCounter++;
			if (findPerk(PerkLib.PhoenixFireBreath) >= 0)
				phoenixCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				phoenixCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && phoenixCounter >= 4)
				phoenixCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && phoenixCounter >= 8)
				phoenixCounter += 1;
			if (isGargoyle()) phoenixCounter = 0;
			End("Player","racialScore");
			return phoenixCounter;
		}
		
		//Scylla score
		public function scyllaScore():Number {
			Begin("Player","racialScore","scylla");
			var scyllaCounter:Number = 0;
			if (faceType == Face.HUMAN)
				scyllaCounter++;
			if (faceType != 0)
				scyllaCounter--;
			if (ears.type == Ears.ELFIN)
				scyllaCounter++;
			if (hasPlainSkinOnly() && skinAdj == "slippery")
				scyllaCounter++;
		//	if (hasPlainSkinOnly() && skinAdj == "rubberlike slippery")
		//		scyllaCounter += 2;
			if (isScylla())
				scyllaCounter += 2;
			if (tallness > 96)
				scyllaCounter++;
			if (findPerk(PerkLib.InkSpray) >= 0)
				scyllaCounter++;
			if (findPerk(PerkLib.ScyllaInkGlands) >= 0)
				scyllaCounter++;
			if (findPerk(PerkLib.ScyllaInkGlandsEvolved) >= 0)
				scyllaCounter++;
			if (findPerk(PerkLib.ScyllaInkGlands) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				scyllaCounter++;
			if (findPerk(PerkLib.ScyllaInkGlandsEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				scyllaCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				scyllaCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && scyllaCounter >= 4)
				scyllaCounter++;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && scyllaCounter >= 8)
				scyllaCounter += 1;
			if (isGargoyle()) scyllaCounter = 0;
			End("Player","racialScore");
			return scyllaCounter;
		}//potem tentacle dick lub scylla vag też bedą sie liczyć do wyniku)
		
		//Determine Kitshoo Rating
		public function kitshooScore():Number {
			Begin("Player","racialScore","kitshoo");
			var kitshooCounter:int = 0;
			//If the character has fox ears, +1
			if (ears.type == Ears.FOX)
				kitshooCounter++;
			//If the character has a fox tail, +1
		//	if (tailType == FOX)
		//		kitshooCounter++;
			//If the character has two to eight fox tails, +2
		//	if (tailType == FOX && tailCount >= 2 && tailCount < 9)
		//		kitshooCounter += 2;
			//If the character has nine fox tails, +3
		//	if (tailType == FOX && tailCount == 9)
		//		kitshooCounter += 3;
			//If the character has tattooed skin, +1
			//9999
			//If the character has a 'vag of holding', +1
		//	if (vaginalCapacity() >= 8000)
		//		kitshooCounter++;
			//If the character's kitshoo score is greater than 0 and:
			//If the character has a normal face, +1
			if (kitshooCounter > 0 && (faceType == Face.HUMAN || faceType == Face.FOX))
				kitshooCounter++;
			//If the character's kitshoo score is greater than 1 and:
			//If the character has "blonde","black","red","white", or "silver" hair, +1
			if (kitshooCounter > 0 && hasFur() && (InCollection(coatColor, KitsuneScene.basicKitsuneHair) || InCollection(coatColor, KitsuneScene.elderKitsuneColors)))
				kitshooCounter++;
			//If the character's femininity is 40 or higher, +1
		//	if (kitshooCounter > 0 && femininity >= 40)
		//		kitshooCounter++;
			//If the character has fur, chitin, or gooey skin, -1
		//	if (skinType == FUR && !InCollection(furColor, KitsuneScene.basicKitsuneFur) && !InCollection(furColor, KitsuneScene.elderKitsuneColors))
		//		kitshooCounter--;
		//	if (skinType == SCALES)
		//		kitshooCounter -= 2; - czy bedzie pozytywny do wyniku czy tez nie?
			if (hasCoatOfType(Skin.CHITIN))
				kitshooCounter -= 2;
			if (hasGooSkin())
				kitshooCounter -= 3;
			//If the character has abnormal legs, -1
		//	if (lowerBody != HUMAN && lowerBody != FOX)
		//		kitshooCounter--;
			//If the character has a nonhuman face, -1
		//	if (faceType != HUMAN && faceType != FOX)
		//		kitshooCounter--;
			//If the character has ears other than fox ears, -1
		//	if (earType != FOX)
		//		kitshooCounter--;
			//If the character has tail(s) other than fox tails, -1
		//	if (tailType != FOX)
		//		kitshooCounter--;
			//When character get one of 9-tail perk
		//	if (kitshooCounter >= 3 && (findPerk(PerkLib.EnlightenedNinetails) >= 0 || findPerk(PerkLib.CorruptedNinetails) >= 0))
		//		kitshooCounter += 2;
			//When character get Hoshi no tama
		//	if (findPerk(PerkLib.KitsuneThyroidGland) >= 0)
		//		kitshooCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				kitshooCounter += 50;
			if (isGargoyle()) kitshooCounter = 0;
			End("Player","racialScore");
			return kitshooCounter;
		}
		
		//plant score
		public function plantScore():Number {
			Begin("Player","racialScore","plant");
			var plantCounter:Number = 0;
			if (faceType == Face.HUMAN)
				plantCounter++;
			if (faceType == Face.PLANT_DRAGON)
				plantCounter--;
			if (horns.type == Horns.OAK || horns.type == Horns.ORCHID)
				plantCounter++;
			if (ears.type == Ears.ELFIN)
				plantCounter++;
			if (ears.type == Ears.LIZARD)
				plantCounter--;
			if ((hairType == Hair.LEAF || hairType == Hair.GRASS) && hairColor == "green")
				plantCounter++;
			if (hasPlainSkinOnly() && (skinTone == "leaf green" || skinTone == "lime green" || skinTone == "turquoise" || skinTone == "light green"))
				plantCounter++;
		//	if (skinType == 6)/zielona skóra +1, bark skin +2
		//		plantCounter += 2;
			if (arms.type == Arms.PLANT)
				plantCounter++;
			if (lowerBody == LowerBody.PLANT_HIGH_HEELS || lowerBody == LowerBody.PLANT_ROOT_CLAWS) {
				if (tentacleCocks() > 0) {
					plantCounter++;
				}
				plantCounter++;
			}
			if (wings.type == Wings.PLANT)
				plantCounter++;
			if (alrauneScore() >= 10)
				plantCounter -= 7;
			if (yggdrasilScore() >= 10)
				plantCounter -= 4;
		//	if (scorpionCounter > 0 && findPerk(PerkLib.TrachealSystemEvolved) >= 0)
		//		plantCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				plantCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && plantCounter >= 4)
				plantCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && plantCounter >= 8)
				plantCounter += 1;
			if (isGargoyle()) plantCounter = 0;
			End("Player","racialScore");
			return plantCounter;
		}
		
		public function alrauneScore():Number {
			Begin("Player","racialScore","alraune");
			var alrauneCounter:Number = 0;
			if (faceType == Face.HUMAN)
				alrauneCounter++;
			if (eyes.type == Eyes.HUMAN)
				alrauneCounter++;
			if (ears.type == Ears.ELFIN)
				alrauneCounter++;
			if ((hairType == Hair.LEAF || hairType == Hair.GRASS) && hairColor == "green")
				alrauneCounter++;
			if (skinType == Skin.PLAIN && (skinTone == "leaf green" || skinTone == "lime green" || skinTone == "turquoise"))
				alrauneCounter++;
			if (arms.type == Arms.PLANT)
				alrauneCounter++;
			if (wings.type == Wings.NONE)
				alrauneCounter++;
			if (lowerBody == LowerBody.PLANT_FLOWER)
				alrauneCounter += 2;
			if (stamenCocks() > 0)
				alrauneCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				alrauneCounter += 50;
			if (isGargoyle()) alrauneCounter = 0;
			End("Player","racialScore");
			return alrauneCounter;
		}
		
		public function yggdrasilScore():Number {
			Begin("Player","racialScore","yggdrasil");
			var yggdrasilCounter:Number = 0;
			if (faceType == Face.PLANT_DRAGON)
				yggdrasilCounter += 2;
			if ((hairType == Hair.ANEMONE || hairType == Hair.LEAF || hairType == Hair.GRASS) && hairColor == "green")
				yggdrasilCounter++;
			if (ears.type == Ears.LIZARD)
				yggdrasilCounter++;
			if (ears.type == Ears.ELFIN)
				yggdrasilCounter -= 2;
			if (arms.type == Arms.PLANT || arms.type == Arms.PLANT2)
				yggdrasilCounter += 2;//++ - untill claws tf added arms tf will count for both arms and claws tf
			//claws?

			if (wings.type == Wings.PLANT)
				yggdrasilCounter++;
			//skin(fur(moss), scales(bark))
			if (skinType == Skin.SCALES)
				yggdrasilCounter++;
			if (tentacleCocks() > 0 || stamenCocks() > 0)
				yggdrasilCounter++;
			if (lowerBody == LowerBody.YGG_ROOT_CLAWS)
				yggdrasilCounter++;
			if (tailType == Tail.YGGDRASIL)
				yggdrasilCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				yggdrasilCounter += 50;
			if (isGargoyle()) yggdrasilCounter = 0;
			End("Player","racialScore");
			return yggdrasilCounter;
		}

		//Wolf/Fenrir score
		public function wolfScore():Number {
			Begin("Player","racialScore","wolf");
			var wolfCounter:Number = 0;
			if (faceType == Face.WOLF)
				wolfCounter++;
			if (eyes.type == Eyes.FENRIR)
				wolfCounter++;
			if (eyes.type == Eyes.FERAL)
				wolfCounter -= 11;
			if (ears.type == Ears.WOLF)
				wolfCounter++;
			if (arms.type == Arms.WOLF)
				wolfCounter++;
			if (lowerBody == LowerBody.WOLF)
				wolfCounter++;
			if (tailType == Tail.WOLF)
				wolfCounter++;
			if (hasFur())
				wolfCounter++;
			if (hairColor == "glacial white" && hasFur() && coatColor == "glacial white")
				wolfCounter++;
			if (rearBody.type == RearBody.FENRIR_ICE_SPIKES)
				wolfCounter++;
			if (wolfCocks() > 0 && wolfCounter > 0)
				wolfCounter++;
			if (findPerk(PerkLib.FreezingBreath) >= 0)
				wolfCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && wolfCounter >= 4)
				wolfCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && wolfCounter >= 8)
				wolfCounter += 1;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				wolfCounter += 50;
			if (isGargoyle()) wolfCounter = 0;
			End("Player","racialScore");
			return wolfCounter;
		}

		//Werewolf score
		public function werewolfScore():Number {
			Begin("Player","racialScore","werewolf");
			var werewolfCounter:Number = 0;
			if (faceType == Face.WOLF_FANGS)
				werewolfCounter++;
			if (eyes.type == Eyes.FERAL)
				werewolfCounter++;
			if (eyes.type == Eyes.FENRIR)
				werewolfCounter -= 7;
			if (ears.type == Ears.WOLF)
				werewolfCounter++;
			if (tongue.type == Tongue.DOG)
				werewolfCounter++;
			if (arms.type == Arms.WOLF)
				werewolfCounter++;
			if (lowerBody == LowerBody.WOLF)
				werewolfCounter++;
			if (tailType == Tail.WOLF)
				werewolfCounter++;
			if (hasPartialCoat(Skin.FUR))
				werewolfCounter++;
			if (rearBody.type == RearBody.WOLF_COLLAR)
				werewolfCounter++;
			if (rearBody.type == RearBody.FENRIR_ICE_SPIKES)
				werewolfCounter -= 7;
			if (wolfCocks() > 0 && werewolfCounter > 0)
				werewolfCounter++;
			if (cor >= 20)
				werewolfCounter += 2;
			if (findPerk(PerkLib.Lycanthropy) >= 0)
				werewolfCounter++;
			if (findPerk(PerkLib.LycanthropyDormant) >= 0)
				werewolfCounter -= 11;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && werewolfCounter >= 4)
				werewolfCounter++;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && werewolfCounter >= 8)
				werewolfCounter += 1;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				werewolfCounter += 50;
			if (isGargoyle()) werewolfCounter = 0;
			End("Player","racialScore");
			return werewolfCounter;
		}

		public function sirenScore():Number {
			Begin("Player","racialScore","siren");
			var sirenCounter:Number = 0;
			if (faceType == Face.SHARK_TEETH)
				sirenCounter++;
			if (hairType == Hair.FEATHER)
				sirenCounter++;
			if (hairColor == "silver")
				sirenCounter++;
			if (tailType == Tail.SHARK)
				sirenCounter++;
			if (wings.type == Wings.FEATHERED_LARGE)
				sirenCounter += 2;
			if (arms.type == Arms.HARPY)
				sirenCounter++;
			if (lowerBody == LowerBody.SHARK)
				sirenCounter++;
			if (skinType == Skin.SCALES && (skinTone == "rough gray" || skinTone == "orange" || skinTone == "dark gray" || skinTone == "grayish-blue" || skinTone == "iridescent gray" || skinTone == "ashen grayish-blue" || skinTone == "gray"))
				sirenCounter++;
			if (gills.type == Gills.FISH)
				sirenCounter++;
			if (eyes.type == Eyes.HUMAN)
				sirenCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				sirenCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && sirenCounter >= 4)
				sirenCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && sirenCounter >= 8)
				sirenCounter += 1;
			if (isGargoyle()) sirenCounter = 0;
			End("Player","racialScore");
			return sirenCounter;
		}
		
		public function pigScore():Number {
			Begin("Player","racialScore","pig");
			var pigCounter:Number = 0;
			if (ears.type == Ears.PIG)
				pigCounter++;
			if (tailType == Tail.PIG)
				pigCounter++;
			if (faceType == Face.PIG)
				pigCounter++;
			if (arms.type == Arms.PIG)
				pigCounter += 2;
			if (lowerBody == LowerBody.CLOVEN_HOOFED)
				pigCounter++;
			if (hasPlainSkinOnly())
				pigCounter++;
			if (skinTone == "pink" || skinTone == "tan" || skinTone == "sable")
				pigCounter++;
			if (thickness >= 75)
				pigCounter++;
			if (pigCocks() > 0)
				pigCounter++;
			if (pigCounter >= 4) {
				if (arms.type == Arms.HUMAN)
					pigCounter++;
				if (wings.type == Wings.NONE)
					pigCounter++;
				if (thickness >= 150)
					pigCounter++;
			}
			if (faceType == Face.BOAR || arms.type == Arms.BOAR) {
				if (faceType == Face.BOAR)
					pigCounter += 2;		
				if (arms.type == Arms.BOAR)
					pigCounter += 2;		
				if (skinTone == "pink" || skinTone == "dark blue")
					pigCounter += 2;
				if (hasFur() && (coatColor == "dark brown" || coatColor == "brown" || coatColor == "black" || coatColor == "red" || coatColor == "grey"))
					pigCounter += 2;
			}
			if (findPerk(PerkLib.PigBoarFat) >= 0)
				pigCounter++;
			if (findPerk(PerkLib.PigBoarFatEvolved) >= 0)
				pigCounter++;
			if (findPerk(PerkLib.PigBoarFatFinalForm) >= 0)
				pigCounter++;
			if (findPerk(PerkLib.PigBoarFat) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				pigCounter++;
			if (findPerk(PerkLib.PigBoarFatEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				pigCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				pigCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && pigCounter >= 5)
				pigCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && pigCounter >= 10)
				pigCounter += 1;
			if (isGargoyle()) pigCounter = 0;
			End("Player","racialScore");
			return pigCounter;
		}
		
		public function satyrScore():Number {
			Begin("Player","racialScore","satyr");
			var satyrCounter:Number = 0;
			if (lowerBody == LowerBody.HOOFED)
				satyrCounter++;
			if (tailType == Tail.GOAT)
				satyrCounter++;
			if (ears.type == Ears.ELFIN)
				satyrCounter++;
			if (satyrCounter >= 3) {
				if (faceType == Face.HUMAN)
					satyrCounter++;
				if (countCocksOfType(CockTypesEnum.HUMAN) > 0)
					satyrCounter++;
				if (balls > 0 && ballSize >= 3)
					satyrCounter++;
			}
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				satyrCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && satyrCounter >= 4)
				satyrCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && satyrCounter >= 8)
				satyrCounter += 1;
			if (isGargoyle()) satyrCounter = 0;
			End("Player","racialScore");
			return satyrCounter;
		}
		
		public function rhinoScore():Number {
			Begin("Player","racialScore","rhino");
			var rhinoCounter:Number = 0;
			if (ears.type == Ears.RHINO)
				rhinoCounter++;
			if (tailType == Tail.RHINO)
				rhinoCounter++;
			if (faceType == Face.RHINO)
				rhinoCounter++;
			if (horns.type == Horns.RHINO)
				rhinoCounter++;
			if (rhinoCounter >= 2 && skinTone == "gray")
				rhinoCounter++;
			if (rhinoCounter >= 2 && hasCock() && countCocksOfType(CockTypesEnum.RHINO) > 0)
				rhinoCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				rhinoCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && rhinoCounter >= 4)
				rhinoCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && rhinoCounter >= 8)
				rhinoCounter += 1;
			if (isGargoyle()) rhinoCounter = 0;
			End("Player","racialScore");
			return rhinoCounter;
		}
		
		public function echidnaScore():Number {
			Begin("Player","racialScore","echidna");
			var echidnaCounter:Number = 0;
			if (ears.type == Ears.ECHIDNA)
				echidnaCounter++;
			if (tailType == Tail.ECHIDNA)
				echidnaCounter++;
			if (faceType == Face.ECHIDNA)
				echidnaCounter++;
			if (tongue.type == Tongue.ECHIDNA)
				echidnaCounter++;
			if (lowerBody == LowerBody.ECHIDNA)
				echidnaCounter++;
			if (echidnaCounter >= 2 && skinType == Skin.FUR)
				echidnaCounter++;
			if (echidnaCounter >= 2 && countCocksOfType(CockTypesEnum.ECHIDNA) > 0)
				echidnaCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				echidnaCounter += 50;
			if (isGargoyle()) echidnaCounter = 0;
			End("Player","racialScore");
			return echidnaCounter;
		}
		
		public function deerScore():Number {
			Begin("Player","racialScore","deer");
			var deerCounter:Number = 0;
			if (ears.type == Ears.DEER)
				deerCounter++;
			if (tailType == Tail.DEER)
				deerCounter++;
			if (faceType == Face.DEER)
				deerCounter++;
			if (lowerBody == LowerBody.CLOVEN_HOOFED || lowerBody == LowerBody.DEERTAUR)
				deerCounter++;
			if (horns.type == Horns.ANTLERS && horns.count >= 4)
				deerCounter++;
			if (deerCounter >= 2 && skinType == Skin.FUR)
				deerCounter++;
			if (deerCounter >= 3 && countCocksOfType(CockTypesEnum.HORSE) > 0)
				deerCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				deerCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && deerCounter >= 4)
				deerCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && deerCounter >= 8)
				deerCounter += 1;
			if (isGargoyle()) deerCounter = 0;
			End("Player","racialScore");
			return deerCounter;
		}
		
		//Dragonne
		public function dragonneScore():Number {
			Begin("Player","racialScore","dragonne");
			var dragonneCounter:Number = 0;
			if (faceType == Face.CAT)
				dragonneCounter++;
			if (ears.type == Ears.CAT)
				dragonneCounter++;
			if (tailType == Tail.CAT)
				dragonneCounter++;
			if (tongue.type == Tongue.DRACONIC)
				dragonneCounter++;
			if (wings.type == Wings.DRACONIC_LARGE)
				dragonneCounter += 2;
			if (wings.type == Wings.DRACONIC_SMALL)
				dragonneCounter++;
			if (lowerBody == LowerBody.CAT)
				dragonneCounter++;
			if (skinType == Skin.SCALES && dragonneCounter > 0)
				dragonneCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				dragonneCounter += 50;
			if (isGargoyle()) dragonneCounter = 0;
			End("Player","racialScore");
			return dragonneCounter;
		}
		
		//Manticore
		public function manticoreScore():Number {
			Begin("Player","racialScore","manticore");
			var manticoreCounter:Number = 0;
			if (faceType == Face.MANTICORE)
				manticoreCounter++;
			if (eyes.type == Eyes.MANTICORE)
				manticoreCounter++;
			if (ears.type == Ears.LION)
				manticoreCounter++;
			if (tailType == Tail.MANTICORE_PUSSYTAIL)
				manticoreCounter += 2;
			if (rearBody.type == RearBody.LION_MANE)
				manticoreCounter++;
			if (arms.type == Arms.LION)
				manticoreCounter++;
			if (lowerBody == LowerBody.LION)
				manticoreCounter++;
			if (tongue.type == Tongue.CAT)
				manticoreCounter++;
			if (wings.type == Wings.MANTICORE_LIKE_SMALL)
				manticoreCounter++;
			if (wings.type == Wings.MANTICORE_LIKE_LARGE)
				manticoreCounter += 2;
			if (!hasCock())
				manticoreCounter++;
			if (cocks.length > 0)
				manticoreCounter -= 3;
			if (findPerk(PerkLib.ManticoreMetabolism) >= 0)
				manticoreCounter++;
			if (findPerk(PerkLib.ManticoreMetabolismEvolved) >= 0)
				manticoreCounter++;
			if (findPerk(PerkLib.ManticoreMetabolism) >= 0 && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0)
				manticoreCounter++;
			if (findPerk(PerkLib.ManticoreMetabolismEvolved) >= 0 && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0)
				manticoreCounter += 1;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				manticoreCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && manticoreCounter >= 4)
				manticoreCounter++;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && manticoreCounter >= 8)
				manticoreCounter += 1;
			if (isGargoyle()) manticoreCounter = 0;
			End("Player","racialScore");
			return manticoreCounter;
		}
		
		//Selkie
		public function selkieScore():Number {
			Begin("Player","racialScore","selkie");
			var selkieCounter:Number = 0;
			//uszy
			/*if (faceType == Face.HUMAN || faceType == Face.COW_MINOTAUR)
				selkieCounter++;*/
			if (selkieCounter >= 4) {//potem wstawić wymaganie posiadania Singing Voice aby wszystkie poniżej opcje dawały punkty
				/*selkieCounter++;
				if (faceType == Face.HUMAN || faceType == Face.COW_MINOTAUR)
					selkieCounter++;//oczy
				if (arms.type == Arms.HUMAN)
					selkieCounter++;//włosy
				if (hasFur() || hasPartialCoat(Skin.FUR))
					selkieCounter++;*/
				if (biggestTitSize() > 3)
					selkieCounter++;
				if (vaginas.length > 0)
					selkieCounter++;
			}
			if (isGargoyle()) selkieCounter = 0;
			End("Player","racialScore");
			return selkieCounter;
		}
		
		//Red Panda
		public function redpandaScore():Number {
			Begin("Player","racialScore","redpanda");
			var redpandaCounter:Number = 0;
			if (faceType == Face.RED_PANDA)
				redpandaCounter += 2;
			if (ears.type == Ears.RED_PANDA)
				redpandaCounter++;
			if (tailType == Tail.RED_PANDA)
				redpandaCounter++;
			if (arms.type == Arms.RED_PANDA)
				redpandaCounter++;
			if (lowerBody == LowerBody.RED_PANDA)
				redpandaCounter++;
			if (redpandaCounter >= 2 && skin.base.pattern == Skin.PATTERN_RED_PANDA_UNDERBODY)
				redpandaCounter++;
			if (redpandaCounter >= 2 && skinType == Skin.FUR)
				redpandaCounter++;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && redpandaCounter >= 4)
				redpandaCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && redpandaCounter >= 8)
				redpandaCounter += 1;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				redpandaCounter += 50;
			if (isGargoyle()) redpandaCounter = 0;
			End("Player","racialScore");
			return redpandaCounter;
		}
		
		//Bear or Panda
		public function bearpandaScore():Number {
			Begin("Player","racialScore","bearpanda");
			var bearpandaCounter:Number = 0;
			if (faceType == Face.BEAR || faceType == Face.PANDA)
				bearpandaCounter++;
			if (ears.type == Ears.BEAR || ears.type == Ears.PANDA)
				bearpandaCounter++;
			if (tailType == Tail.BEAR)
				bearpandaCounter++;
			if (arms.type == Arms.BEAR)
				bearpandaCounter++;
			if (lowerBody == LowerBody.BEAR)
				bearpandaCounter++;
			if (eyes.type == Eyes.BEAR)
				bearpandaCounter++;
			if (skinType == Skin.FUR)
				bearpandaCounter++;
			if (InCollection(skin.coat.color, "black","brown","white") || (skin.coat.color == "white" && skin.coat.color2 == "black"))
				bearpandaCounter++;
			if (tallness > 72)
				bearpandaCounter += 2;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				bearpandaCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && bearpandaCounter >= 4)
				bearpandaCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && bearpandaCounter >= 8)
				bearpandaCounter += 1;
			if (isGargoyle()) bearpandaCounter = 0;
			End("Player","racialScore");
			return bearpandaCounter;
		}
		
		//Determine Avian Rating
		public function avianScore():Number {
			Begin("Player","racialScore","avian");
			var avianCounter:Number = 0;
			if (hairType == Hair.FEATHER)
				avianCounter++;
			if (faceType == Face.AVIAN)
				avianCounter++;
			if (ears.type == Ears.AVIAN)
				avianCounter++;
			if (tailType == Tail.AVIAN)
				avianCounter++;
			if (arms.type == Arms.AVIAN)
				avianCounter++;
			if (lowerBody == LowerBody.AVIAN)
				avianCounter++;
			if (wings.type == Wings.FEATHERED_AVIAN)
				avianCounter += 2;
			if (hasCoatOfType(Skin.FEATHER))
				avianCounter++;
			if (avianCocks() > 0)
				avianCounter++;
			if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0)
				avianCounter += 50;
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && avianCounter >= 4)
				avianCounter += 1;
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && avianCounter >= 8)
				avianCounter += 1;
			if (isGargoyle()) avianCounter = 0;
			End("Player","racialScore");
			return avianCounter;
		}
		
		//Bat
		public function batScore():int {
            Begin("Player","racialScore","bat");
			var counter:int = 0;
			if (ears.type == Ears.BAT) { counter++;}
			if (ears.type == Ears.VAMPIRE) { counter -= 10;}
			if (wings.type == Wings.BAT_ARM) {counter += 4; }
			if (faceType == Face.VAMPIRE) {counter += 2;}
			if (eyes.type == Eyes.VAMPIRE) {counter++;}
			if (rearBody.type == RearBody.BAT_COLLAR) {counter++;}
			if (counter >= 8) {
				if (arms.type == Arms.HUMAN) {counter++;}
				if (lowerBody == LowerBody.HUMAN) {counter++;}
			}
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && counter >= 4) {counter++;}
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && counter >= 8) {counter++;}
            if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0) {counter += 50;}
			if (isGargoyle()) counter = 0;
			End("Player","racialScore");
			return counter < 0? 0:counter;
		}
		
		//Vampire
		public function vampireScore():int {
            Begin("Player","racialScore","vampire");
            var counter:int = 0;
            if (ears.type == Ears.BAT) {counter -= 10;}
            if (ears.type == Ears.VAMPIRE) { counter++;}
			if (wings.type == Wings.VAMPIRE) {counter += 4;}
            if (faceType == Face.VAMPIRE) {counter += 2;}
			if (eyes.type == Eyes.VAMPIRE) {counter++; }
			if (counter >= 8) {
				if (arms.type == Arms.HUMAN) {counter++;}
				if (lowerBody == LowerBody.HUMAN) {counter++;}
			}
			if (findPerk(PerkLib.VampiricBloodsteam) >= 0) {counter++;}
			if (findPerk(PerkLib.VampiricBloodsteamEvolved) >= 0) {counter++;}
			if (findPerk(PerkLib.VampiricBloodsteamFinalForm) >= 0) {counter++;}
			if (findPerk(PerkLib.HollowFangs) >= 0) {counter++;}
			if (findPerk(PerkLib.HollowFangsEvolved) >= 0) {counter++;}
			if (findPerk(PerkLib.HollowFangsFinalForm) >= 0) {counter++;}
			if ((findPerk(PerkLib.VampiricBloodsteam) >= 0 || findPerk(PerkLib.HollowFangs) >= 0) && findPerk(PerkLib.ChimericalBodySemiAdvancedStage) >= 0) {counter++;}
			if ((findPerk(PerkLib.VampiricBloodsteamEvolved) >= 0 || findPerk(PerkLib.HollowFangsEvolved) >= 0) && findPerk(PerkLib.ChimericalBodySemiPeerlessStage) >= 0) {counter++;}
			if (findPerk(PerkLib.AscensionHybridTheory) >= 0 && counter >= 4) {counter++;}
			if (findPerk(PerkLib.AscensionCruelChimerasThesis) >= 0 && counter >= 8) {counter++;}
            if (findPerk(PerkLib.ChimericalBodyUltimateStage) >= 0) {counter += 50;}
			if (isGargoyle()) counter = 0;
			End("Player","racialScore");
			return counter < 0? 0:counter;
		}
		
		//Gargoyle
		public function gargoyleScore():Number {
			Begin("Player","racialScore","gargoyle");
			var gargoyleCounter:Number = 0;
			if (hairColor == "light grey" || hairColor == "quartz white")
				gargoyleCounter++;
			if (skinTone == "light grey" || skinTone == "quartz white")
				gargoyleCounter++;
			if (hairType == Hair.NORMAL)
				gargoyleCounter++;
			if (skinType == Skin.STONE)
				gargoyleCounter++;
			if (horns.type == Horns.GARGOYLE)
				gargoyleCounter++;
			if (eyes.type == Eyes.GEMSTONES)
				gargoyleCounter++;
			if (ears.type == Ears.ELFIN)
				gargoyleCounter++;
			if (faceType == Face.DEVIL_FANGS)
				gargoyleCounter++;
			if (tongue.type == Tongue.DEMONIC)
				gargoyleCounter++;
			if (arms.type == Arms.GARGOYLE || arms.type == Arms.GARGOYLE_2)
				gargoyleCounter++;
			if (tailType == Tail.GARGOYLE || tailType == Tail.GARGOYLE_2)
				gargoyleCounter++;
			if (lowerBody == LowerBody.GARGOYLE || lowerBody == LowerBody.GARGOYLE_2)
				gargoyleCounter++;
			if (wings.type == Wings.GARGOYLE_LIKE_LARGE)
				gargoyleCounter += 2;
			if (gills.type == Gills.NONE)
				gargoyleCounter++;
			if (rearBody.type == RearBody.NONE)
				gargoyleCounter++;
			if (antennae.type == Antennae.NONE)
				gargoyleCounter++;
			if (hasPerk(PerkLib.GargoylePure) || hasPerk(PerkLib.GargoyleCorrupted))
				gargoyleCounter++;
			if (hasPerk(PerkLib.TransformationImmunity))
				gargoyleCounter += 5;
			End("Player","racialScore");
			return gargoyleCounter;
		}

		//TODO: (logosK) elderSlime, succubus pussy/demonic eyes, arachne, wasp, lactabovine/slut, sleipnir, hellhound, ryu, quetzalcoatl, eredar, anihilan, 

		public function currentBasicJobs():Number {
			var basicJobs:Number = 0;
			if (findPerk(PerkLib.JobAllRounder) >= 0)
				basicJobs++;
			if (findPerk(PerkLib.JobBeastWarrior) >= 0)
				basicJobs++;
			if (findPerk(PerkLib.JobGuardian) >= 0)
				basicJobs++;
			if (findPerk(PerkLib.JobLeader) >= 0)
				basicJobs++;
			if (findPerk(PerkLib.JobRanger) >= 0)
				basicJobs++;
			if (findPerk(PerkLib.JobSeducer) >= 0)
				basicJobs++;
			if (findPerk(PerkLib.JobSorcerer) >= 0)
				basicJobs++;
			if (findPerk(PerkLib.JobSoulCultivator) >= 0)
				basicJobs++;
			if (findPerk(PerkLib.JobWarrior) >= 0)
				basicJobs++;
			return basicJobs;
		}
		public function currentAdvancedJobs():Number {
			var advancedJobs1:Number = 0;
			if (findPerk(PerkLib.JobBrawler) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobCourtesan) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobDefender) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobDervish) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobElementalConjurer) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobEnchanter) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobEromancer) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobGolemancer) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobGunslinger) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobHealer) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobHunter) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobKnight) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobMonk) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobRogue) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobSwordsman) >= 0)
				advancedJobs1++;
			if (findPerk(PerkLib.JobWarlord) >= 0)
				advancedJobs1++;
			return advancedJobs1;
		}
		public function maxAdvancedJobs():Number {
			var advancedJobs2:Number = 3;
			if (findPerk(PerkLib.BasicAllRounderEducation) >= 0)
				advancedJobs2 += 3;
			if (findPerk(PerkLib.IntermediateAllRounderEducation) >= 0)
				advancedJobs2 += 3;
			if (findPerk(PerkLib.AdvancedAllRounderEducation) >= 0)
				advancedJobs2 += 3;
			if (findPerk(PerkLib.ExpertAllRounderEducation) >= 0)
				advancedJobs2 += 3;
			if (findPerk(PerkLib.MasterAllRounderEducation) >= 0)
				advancedJobs2 += 3;
			return advancedJobs2;
		}
		public function freeAdvancedJobsSlots():Number {
			var advancedJobs3:Number = 0;
			advancedJobs3 += maxAdvancedJobs();
			advancedJobs3 -= currentAdvancedJobs();
			return advancedJobs3;
		}
		public function currentHiddenJobs():Number {
			var hiddenJobs1:Number = 0;
			return hiddenJobs1;
		}
		public function maxHiddenJobs():Number {
			var hiddenJobs2:Number = 1;
			return hiddenJobs2;
		}
		public function freeHiddenJobsSlots():Number {
			var hiddenJobs2:Number = 0;
			hiddenJobs2 += maxHiddenJobs();
			hiddenJobs2 -= currentHiddenJobs();
			return hiddenJobs2;
		}
		public function currentPrestigeJobs():Number {
			var prestigeJobs1:Number = 0;
			if (findPerk(PerkLib.PrestigeJobArcaneArcher) >= 0)
				prestigeJobs1++;
			if (findPerk(PerkLib.PrestigeJobBerserker) >= 0)
				prestigeJobs1++;
			if (findPerk(PerkLib.PrestigeJobGreySage) >= 0)
				prestigeJobs1++;
			if (findPerk(PerkLib.PrestigeJobSeer) >= 0)
				prestigeJobs1++;
			if (findPerk(PerkLib.PrestigeJobSentinel) >= 0)
				prestigeJobs1++;
			if (findPerk(PerkLib.PrestigeJobSoulArcher) >= 0)
				prestigeJobs1++;
			if (findPerk(PerkLib.PrestigeJobSoulArtMaster) >= 0)
				prestigeJobs1++;
			if (findPerk(PerkLib.PrestigeJobSpellKnight) >= 0)
				prestigeJobs1++;
			if (findPerk(PerkLib.PrestigeJobTempest) >= 0)
				prestigeJobs1++;
			if (findPerk(PerkLib.PrestigeJobWarlock) >= 0)
				prestigeJobs1++;
			return prestigeJobs1;
		}
		public function maxPrestigeJobs():Number {
			var prestigeJobs2:Number = 1;
			if (level >= 72)
				prestigeJobs2++;
			if (findPerk(PerkLib.DeityJobMunchkin) >= 0)
				prestigeJobs2++;
			if (findPerk(PerkLib.AscensionBuildingPrestige01) >= 0)
				prestigeJobs2++;
			if (findPerk(PerkLib.AscensionBuildingPrestige02) >= 0)
				prestigeJobs2++;
			if (findPerk(PerkLib.AscensionBuildingPrestige03) >= 0)
				prestigeJobs2++;
			if (findPerk(PerkLib.AscensionBuildingPrestige04) >= 0)
				prestigeJobs2++;
			if (findPerk(PerkLib.AscensionBuildingPrestige05) >= 0)
				prestigeJobs2++;
			if (findPerk(PerkLib.AscensionBuildingPrestige06) >= 0)
				prestigeJobs2++;
			return prestigeJobs2;
		}
		public function freePrestigeJobsSlots():Number {
			var prestigeJobs3:Number = 0;
			prestigeJobs3 += maxPrestigeJobs();
			prestigeJobs3 -= currentPrestigeJobs();
			return prestigeJobs3;
		}
		
		public function maxHeartMutations():Number {
			var heartMutations:Number = 1;
			if (findPerk(PerkLib.BlackHeart) >= 0)
				heartMutations--;
			if (findPerk(PerkLib.FrozenHeart) >= 0)
				heartMutations--;
			if (findPerk(PerkLib.ObsidianHeart) >= 0)
				heartMutations--;
			//if (findPerk(PerkLib.) >= 0) - unicorn/bicorn
			//	heartMutations--;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation01) >= 0)
				heartMutations++;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation02) >= 0)
				heartMutations++;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation03) >= 0)
				heartMutations++;
			return heartMutations;
		}
		public function maxMusclesMutations():Number {
			var musclesMutations:Number = 1;
			if (findPerk(PerkLib.MantislikeAgility) >= 0)
				musclesMutations--;
			if (findPerk(PerkLib.OniMusculature) >= 0)
				musclesMutations--;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation01) >= 0)
				musclesMutations++;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation02) >= 0)
				musclesMutations++;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation03) >= 0)
				musclesMutations++;
			return musclesMutations;
		}
		public function maxMouthMutations():Number {
			var mouthMutations:Number = 1;
			if (findPerk(PerkLib.VenomGlands) >= 0)
				mouthMutations--;
			if (findPerk(PerkLib.HollowFangs) >= 0)
				mouthMutations--;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation01) >= 0)
				mouthMutations++;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation02) >= 0)
				mouthMutations++;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation03) >= 0)
				mouthMutations++;
			return mouthMutations;
		}
		public function maxAdrenalGlandsMutations():Number {
			var adrenalglandsMutations:Number = 1;
			if (findPerk(PerkLib.SalamanderAdrenalGlands) >= 0)
				adrenalglandsMutations--;
			if (findPerk(PerkLib.OrcAdrenalGlands) >= 0)
				adrenalglandsMutations--;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation01) >= 0)
				adrenalglandsMutations++;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation02) >= 0)
				adrenalglandsMutations++;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation03) >= 0)
				adrenalglandsMutations++;
			return adrenalglandsMutations;
		}
		public function maxBloodsteamMutations():Number {
			var bloodsteamMutations:Number = 1;
			if (findPerk(PerkLib.VampiricBloodsteam) >= 0)
				bloodsteamMutations--;
			if (findPerk(PerkLib.HinezumiBurningBlood) >= 0)
				bloodsteamMutations--;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation01) >= 0)
				bloodsteamMutations++;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation02) >= 0)
				bloodsteamMutations++;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation03) >= 0)
				bloodsteamMutations++;
			return bloodsteamMutations;
		}
		public function maxFatTissueMutations():Number {
			var fattissueMutations:Number = 1;
			if (findPerk(PerkLib.PigBoarFat) >= 0)
				fattissueMutations--;
			if (findPerk(PerkLib.NaturalPunchingBag) >= 0)
				fattissueMutations--;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation01) >= 0)
				fattissueMutations++;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation02) >= 0)
				fattissueMutations++;
			if (findPerk(PerkLib.AscensionAdditionalOrganMutation03) >= 0)
				fattissueMutations++;
			return fattissueMutations;
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
			if (!hasStatusEffect(StatusEffects.LactationEndurance))
				createStatusEffect(StatusEffects.LactationEndurance, 1, 0, 0, 0);
			total = biggestTitSize() * 10 * averageLactation() * statusEffectv1(StatusEffects.LactationEndurance) * totalBreasts();
			if (findPerk(PerkLib.MilkMaid) >= 0)
				total += 200 + (perkv1(PerkLib.MilkMaid) * 100);
			if (findPerk(PerkLib.LactaBovinaOvariesEvolved) >= 0)
				total += 200;
			if (findPerk(PerkLib.ProductivityDrugs) >= 0)
				total += (perkv3(PerkLib.ProductivityDrugs));
			if (findPerk(PerkLib.AscensionMilkFaucet) >= 0)
				total += (perkv1(PerkLib.AscensionMilkFaucet) * 200);
			if (findPerk(PerkLib.LactaBovinaOvariesFinalForm) >= 0)
				total *= 2.5;
			if (statusEffectv1(StatusEffects.LactationReduction) >= 48)
				total = total * 1.5;
			if (total > int.MAX_VALUE)
				total = int.MAX_VALUE;
			return total;
		}
		
		public function isLactating():Boolean
		{
			return lactationQ() > 0;

		}

		public function cuntChange(cArea:Number, display:Boolean, spacingsF:Boolean = false, spacingsB:Boolean = true):Boolean {
			if (vaginas.length==0) return false;
			var wasVirgin:Boolean = vaginas[0].virgin;
			var stretched:Boolean = cuntChangeNoDisplay(cArea);
			var devirgined:Boolean = wasVirgin && !vaginas[0].virgin;
			if (devirgined){
				if(spacingsF) outputText("  ");
				outputText("<b>Your hymen is torn, robbing you of your virginity.</b>");
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
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR) outputText("<b>Your " + Appearance.vaginaDescript(this,0)+ " is stretched painfully wide, large enough to accommodate most beasts and demons.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING_WIDE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched so wide that it gapes continually.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_GAPING) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " painfully stretches, the lips now wide enough to gape slightly.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_LOOSE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now very loose.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_NORMAL) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now a little loose.</b>");
				if(vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_TIGHT) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched out to a more normal size.</b>");
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
			var hungerActive:Boolean = false;
			if (flags[kFLAGS.HUNGER_ENABLED] > 0) hungerActive = true;
			if (hungerActive) {
				if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 2 || flags[kFLAGS.CURSE_OF_THE_JIANGSHI] == 3) hungerActive = false;
				else if (hasPerk(PerkLib.DeadMetabolism)) hungerActive = false;
				else if (hasPerk(PerkLib.GargoylePure) || hasPerk(PerkLib.GargoyleCorrupted)) hungerActive = false;
			}
			if (flags[kFLAGS.IN_PRISON] > 0) hungerActive = true;
			if (hungerActive) {
				var oldHunger:Number = hunger;
				var weightChange:int = 0;
				var overeatingLimit:int = 0;
				overeatingLimit += 10;
				if (findPerk(PerkLib.IronStomach) >= 0) overeatingLimit += 5;
				if (findPerk(PerkLib.IronStomachEx) >= 0) overeatingLimit += 10;
				if (findPerk(PerkLib.IronStomachSu) >= 0) overeatingLimit += 15;/*(perki muszą dać zwiekszenie limitu przejedzenia sie bez przyrostu wagi powyżej 10 ^^)
				overeatingLimit += 10;overating perk chyba			perki overating dające stałe utrzymywanie hunger powyżej limitu max hunger dopóki hunger naturalnie nie zostanie zużyty xD
				overeatingLimit += 20;overeating ex perk chyba		achiev polegający na przeżyciu x dni bez jedzenie czegokolwiek wic każde podniesienie hunger resetuje ten timer xD
				overeatingLimit += 40;overeating su perk chyba*/
				hunger += amnt;
				if (hunger > maxHunger()) {
					while (hunger > (maxHunger() + overeatingLimit) && !SceneLib.prison.inPrison) {
						weightChange++;
						hunger -= overeatingLimit;
					}
					modThickness(100, weightChange);
					hunger = maxHunger();
				}
				if (hunger > oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatUp('hunger');
				//game.dynStats("lus", 0, "scale", false);
				if (nl) outputText("\n");
				//Messages
				if (hunger < maxHunger() * 0.1) outputText("<b>You still need to eat more. </b>");
				else if (hunger >= maxHunger() * 0.1 && hunger < maxHunger() * 0.25) outputText("<b>You are no longer starving but you still need to eat more. </b>");
				else if (hunger >= maxHunger() * 0.25 && hunger < maxHunger() * 0.5) outputText("<b>The growling sound in your stomach seems to quiet down. </b>");
				else if (hunger >= maxHunger() * 0.5 && hunger < maxHunger() * 0.75) outputText("<b>Your stomach no longer growls. </b>");
				else if (hunger >= maxHunger() * 0.75 && hunger < maxHunger() * 0.9) outputText("<b>You feel so satisfied. </b>");
				else if (hunger >= maxHunger() * 0.9) outputText("<b>Your stomach feels so full. </b>");
				if (weightChange > 0) outputText("<b>You feel like you've put on some weight. </b>");
				EngineCore.awardAchievement("Tastes Like Chicken ", kACHIEVEMENTS.REALISTIC_TASTES_LIKE_CHICKEN);
				if (oldHunger < 1 && hunger >= 100) EngineCore.awardAchievement("Champion Needs Food Badly ", kACHIEVEMENTS.REALISTIC_CHAMPION_NEEDS_FOOD);
				if (oldHunger >= 90) EngineCore.awardAchievement("Glutton ", kACHIEVEMENTS.REALISTIC_GLUTTON);
				if (oldHunger >= 240) EngineCore.awardAchievement("Epic Glutton ", kACHIEVEMENTS.REALISTIC_EPIC_GLUTTON);
				if (oldHunger >= 490) EngineCore.awardAchievement("Legendary Glutton ", kACHIEVEMENTS.REALISTIC_LEGENDARY_GLUTTON);
				if (oldHunger >= 990) EngineCore.awardAchievement("Mythical Glutton ", kACHIEVEMENTS.REALISTIC_MYTHICAL_GLUTTON);
				if (hunger > oldHunger) CoC.instance.mainView.statsView.showStatUp("hunger");
				dynStats("lus", 0, "scale", false);
				EngineCore.statScreenRefresh();
			}
		}
		public function refillGargoyleHunger(amnt:Number = 0, nl:Boolean = true):void {
			var oldHunger:Number = hunger;
			hunger += amnt;
			if (hunger > maxHunger()) hunger = maxHunger();
			if (hunger > oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatUp('hunger');
			//game.dynStats("lus", 0, "scale", false);
			if (nl) outputText("\n");
			if (hunger > oldHunger) CoC.instance.mainView.statsView.showStatUp("hunger");
			dynStats("lus", 0, "scale", false);
			EngineCore.statScreenRefresh();
		}
		
		/**
		 * Damages player's hunger. 'amnt' is how much to deduct.
		 * @param	amnt
		 */
		public function damageHunger(amnt:Number = 0):void {
			var oldHunger:Number = hunger;
			hunger -= amnt;
			if (hunger < 0) hunger = 0;
			if (hunger < oldHunger && flags[kFLAGS.USE_OLD_INTERFACE] == 0) CoC.instance.mainView.statsView.showStatDown('hunger');
			dynStats("lus", 0, "scale", false);
		}
		
		public function corruptionTolerance():int {
			var temp:int = perkv1(PerkLib.AscensionTolerance) * 5;
			if (flags[kFLAGS.MEANINGLESS_CORRUPTION] > 0) temp += 100;
			return temp;
		}
		public function corAdjustedUp():Number {
			return boundFloat(0, cor + corruptionTolerance(), 100);
		}
		public function corAdjustedDown():Number {
			return boundFloat(0, cor - corruptionTolerance(), 100);
		}
		
		public function newGamePlusMod():int {
			var temp:int = flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			//Constrains value between 0 and 5.
			if (temp < 0) temp = 0;
			if (temp > 5) temp = 5;
			return temp;
		}
		
		public function buttChangeDisplay():void
		{	//Allows the test for stretching and the text output to be separated
			if (ass.analLooseness == 5) outputText("<b>Your " + Appearance.assholeDescript(this) + " is stretched even wider, capable of taking even the largest of demons and beasts.</b>");
			if (ass.analLooseness == 4) outputText("<b>Your " + Appearance.assholeDescript(this) + " becomes so stretched that it gapes continually.</b>");
			if (ass.analLooseness == 3) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now very loose.</b>");
			if (ass.analLooseness == 2) outputText("<b>Your " + Appearance.assholeDescript(this) + " is now a little loose.</b>");
			if (ass.analLooseness == 1) outputText("<b>You have lost your anal virginity.</b>");
		}

		public function slimeFeed():void{
			if (hasStatusEffect(StatusEffects.SlimeCraving)) {
				//Reset craving value
				changeStatusValue(StatusEffects.SlimeCraving,1,0);
				//Flag to display feed update and restore stats in event parser
				if(!hasStatusEffect(StatusEffects.SlimeCravingFeed)) {
					createStatusEffect(StatusEffects.SlimeCravingFeed,0,0,0,0);
				}
				refillHunger(30);
			}
			if (findPerk(PerkLib.Diapause) >= 0) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228] += 3 + rand(3);
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] = 1;
			}
			if (isGargoyle() && hasPerk(PerkLib.GargoyleCorrupted)) refillGargoyleHunger(30);
			if (jiangshiScore() >= 20 && statusEffectv1(StatusEffects.EnergyDependent) < 45) EnergyDependentRestore();
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
			if(findPerk(PerkLib.MinotaurCumResistance) >= 0 || findPerk(PerkLib.ManticoreCumAddict) >= 0 || findPerk(PerkLib.HaltedVitals) >= 0) raw *= 0;
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
			return spellCount() > 0 || findPerk(PerkLib.JobSorcerer) >= 0;
		}

		public function spellCount():Number
		{
			return [StatusEffects.KnowsArcticGale, StatusEffects.KnowsArouse, StatusEffects.KnowsBlind, StatusEffects.KnowsBlink, StatusEffects.KnowsBlizzard, StatusEffects.KnowsChainLighting, StatusEffects.KnowsCharge, StatusEffects.KnowsChargeA, StatusEffects.KnowsDarknessShard, StatusEffects.KnowsDuskWave, StatusEffects.KnowsFireStorm, StatusEffects.KnowsHeal,
			StatusEffects.KnowsIceRain, StatusEffects.KnowsIceSpike,StatusEffects.KnowsLightningBolt, StatusEffects.KnowsManaShield,StatusEffects.KnowsMight,StatusEffects.KnowsNosferatu,StatusEffects.KnowsRegenerate,StatusEffects.KnowsWhitefire]
					.filter(function(item:StatusEffectType, index:int, array:Array):Boolean{
						return this.hasStatusEffect(item);},this)
					.length;
		}
		public function spellCountWhiteBlack():Number
		{
			return [StatusEffects.KnowsIceSpike, StatusEffects.KnowsDarknessShard, StatusEffects.KnowsMight, StatusEffects.KnowsBlink, StatusEffects.KnowsRegenerate, StatusEffects.KnowsArouse, StatusEffects.KnowsWhitefire, StatusEffects.KnowsLightningBolt, StatusEffects.KnowsCharge, StatusEffects.KnowsChargeA, StatusEffects.KnowsHeal, StatusEffects.KnowsBlind,
			StatusEffects.KnowsPyreBurst, StatusEffects.KnowsChainLighting, StatusEffects.KnowsArcticGale, StatusEffects.KnowsDuskWave, StatusEffects.KnowsBlizzard]
					.filter(function(item:StatusEffectType, index:int, array:Array):Boolean{
						return this.hasStatusEffect(item);},this)
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
					if(temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your breasts have shrunk!  With a quick measure, you determine they're now " + breastCup(0) + "s.");
					if(temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are much smaller!  With a quick measure, you determine they're now " + breastCup(0) + "s.");
				}
			}
			else if(breastRows.length > 1) {
				//multiple
				outputText("\n");
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
						outputText("\n");
						if(temp3 < breastRows.length - 1) outputText("...and y");
						else outputText("Y");
						outputText("our " + breastDescript(temp3) + " shrink, dropping to " + breastCup(temp3) + "s.");
					}
					if(breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
				}
				if(temp2 == 2) outputText("\nYou feel so much lighter after the change.");
				if(temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.");
				if(temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
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
						if(breastRows.length > 1) outputText("Your rows of " + breastDescript(0) + " jiggle with added weight, growing a bit larger.");
						if(breastRows.length == 1) outputText("Your " + breastDescript(0) + " jiggle with added weight as they expand, growing a bit larger.");
					}
					else if(amount <= 4)
					{
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your rows of " + breastDescript(0) + " expand significantly.");
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.");
					}
					else
					{
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your " + breastDescript(0) + " tingle strongly, growing disturbingly large.");
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.");
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .5;
					}
				}
				else
				{
					if(amount <= 2) {
						if(breastRows.length > 1) outputText("Your top row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.");
						if(breastRows.length == 1) outputText("Your row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.");
					}
					if(amount > 2 && amount <= 4) {
						if(breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your top row of " + breastDescript(0) + " expand significantly.");
						if(breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.");
					}
					if(amount > 4) {
						if(breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your top row of " + breastDescript(0) + " tingle strongly, growing disturbingly large.");
						if(breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.");
					}
					if(biggestTitSize() >= 8.5 && nippleLength < 2) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 2;
					}
					if(biggestTitSize() >= 7 && nippleLength < 1) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = 1;
					}
					if(biggestTitSize() >= 5 && nippleLength < .75) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .75;
					}
					if(biggestTitSize() >= 3 && nippleLength < .5) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.");
						nippleLength = .5;
					}
				}
			}
		}

		public override function getAllMinStats():Object {
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			var minStr:int = 1;
			var minTou:int = 1;
			var minSpe:int = 1;
			var minInt:int = 1;
			var minWis:int = 1;
			var minLib:int = 0;
			var minSen:int = 10;
			var minCor:int = 0;
			//Minimum Libido
			if (this.gender > 0) minLib += 5;
	
			if (this.armorName == "lusty maiden's armor") {
				if (minLib < 50) minLib = 50;
			}
			if (minLib < (minLust() * 2 / 3) && this.findPerk(PerkLib.GargoylePure) >= 0)
			{
				minLib = (minLust() * 2 / 3);
			}
			if (this.jewelryEffectId == JewelryLib.PURITY)
			{
				minLib -= this.jewelryEffectMagnitude;
			}
			if (this.findPerk(PerkLib.PurityBlessing) >= 0) {
				minLib -= 2;
			}
			if (this.findPerk(PerkLib.HistoryReligious) >= 0 || this.findPerk(PerkLib.PastLifeReligious) >= 0) {
				minLib -= 2;
			}
			if (this.findPerk(PerkLib.PewWarmer) >= 0) {
				minLib -= 2;
			}
			if (this.findPerk(PerkLib.Acolyte) >= 0) {
				minLib -= 2;
			}
			if (this.findPerk(PerkLib.Priest) >= 0) {
				minLib -= 2;
			}
			if (this.findPerk(PerkLib.Pastor) >= 0) {
				minLib -= 2;
			}
			if (this.findPerk(PerkLib.Saint) >= 0) {
				minLib -= 2;
			}
			if (this.findPerk(PerkLib.Cardinal) >= 0) {
				minLib -= 2;
			}
			if (this.findPerk(PerkLib.Pope) >= 0) {
				minLib -= 2;
			}
			if (this.findPerk(PerkLib.GargoylePure) >= 0) {
				minLib = 5;
				minSen = 5;
			}
			if (this.findPerk(PerkLib.GargoyleCorrupted) >= 0) {
				minSen += 15;
			}
			//Factory Perks
			if (this.hasPerk(PerkLib.DemonicLethicite)) {minCor+=10;minLib+=10;}
			if (this.hasPerk(PerkLib.ProductivityDrugs)) {minLib+=this.perkv1(PerkLib.ProductivityDrugs);minCor+=10;}
			//Minimum Sensitivity
			if (this.manticoreScore() >= 6) minSen += (30 * newGamePlusMod);
			if (this.manticoreScore() >= 12) minSen += (15 * newGamePlusMod);
			if (this.devilkinScore() >= 7) minSen += (10 * newGamePlusMod);
			if (this.devilkinScore() >= 11) minSen += (5 * newGamePlusMod);
			if (this.devilkinScore() >= 16) minSen += (25 * newGamePlusMod);
			if (this.elfScore() >= 5) minSen += (15 * newGamePlusMod);
			if (this.elfScore() >= 11) minSen += (15 * newGamePlusMod);
			if (this.raijuScore() >= 5) minSen += (25 * newGamePlusMod);
			if (this.raijuScore() >= 10) minSen += (25 * newGamePlusMod);
			if (this.hellcatScore() >= 10) minSen += (25 * newGamePlusMod);
			if (this.firesnailScore() >= 15) minSen += (50 * newGamePlusMod);
			//Rings
			if (this.jewelryName == "Ring of Intelligence") minInt += 5;
			if (this.jewelryName == "Ring of Libido") minLib += 5;
			if (this.jewelryName == "Ring of Sensitivity") minSen += 5;
			if (this.jewelryName == "Ring of Speed") minSpe += 5;
			if (this.jewelryName == "Ring of Strength") minStr += 5;
			if (this.jewelryName == "Ring of Toughness") minTou += 5;
			if (this.jewelryName == "Ring of Wisdom") minWis += 5;
			//Other
			if (this.hasPerk(PerkLib.GoblinoidBlood)) {
				if (this.hasKeyItem("Drug injectors") >= 0) {
					minLib += 25;
					minSen += 5;
				}
				if (this.hasKeyItem("Improved Drug injectors") >= 0) {
					minLib += 50;
					minSen += 10;
				}
				if (this.hasKeyItem("Potent Drug injectors") >= 0) {
					minLib += 75;
					minSen += 15;
				}
				if (this.hasKeyItem("Power bracer") >= 0) minSen += 5;
				if (this.hasKeyItem("Powboy") >= 0) minSen += 10;
				if (this.hasKeyItem("M.G.S. bracer") >= 0) minSen += 15;
			}
			if (hasStatusEffect(StatusEffects.PlayerPhylactery)) minCor = 100;
			if (minLib < 1) minLib = 1;
			return {
				str:minStr,
				tou:minTou,
				spe:minSpe,
				inte:minInt,
				wis:minWis,
				lib:minLib,
				sens:minSen,
				cor:minCor
			};
		}

		//Determine minimum lust
		public override function minLust():Number
		{
			var min:Number = 0;
			var minCap:Number = maxLust();
			//Bimbo body boosts minimum lust by 40
			if(hasStatusEffect(StatusEffects.BimboChampagne) || findPerk(PerkLib.BimboBody) >= 0 || findPerk(PerkLib.BroBody) >= 0 || findPerk(PerkLib.FutaForm) >= 0) min += 40;
			//Omnibus' Gift
			if (findPerk(PerkLib.OmnibusGift) >= 0) min += 35;
			//Fera Blessing
			if (hasStatusEffect(StatusEffects.BlessingOfDivineFera)) min += 15;
			//Nymph perk raises to 30
			if(findPerk(PerkLib.Nymphomania) >= 0) min += 30;
			//Oh noes anemone!
			if(hasStatusEffect(StatusEffects.AnemoneArousal)) min += 30;
			//Hot blooded perk raises min lust!
			if(findPerk(PerkLib.HotBlooded) >= 0) min += perk(findPerk(PerkLib.HotBlooded)).value1;
			if(findPerk(PerkLib.LuststickAdapted) > 0) min += 10;
			if(hasStatusEffect(StatusEffects.Infested)) min += 50;
			//Add points for Crimstone
			min += perkv1(PerkLib.PiercedCrimstone);
			//Subtract points for Icestone!
			min -= perkv1(PerkLib.PiercedIcestone);
			min += perkv1(PerkLib.PentUp);
			//Cold blooded perk reduces min lust, to a minimum of 20! Takes effect after piercings.
			if (findPerk(PerkLib.ColdBlooded) >= 0) {
				if (min >= 20) min -= 20;
				else min = 0;
				minCap -= 20;
			}
			//Purity Blessing perk reduce min lust, to a minimum of 10! Takes effect after piercings.
			if (findPerk(PerkLib.PurityBlessing) >= 0) {
				if (min >= 10) min -= 10;
				else min = 0;
				minCap -= 10;
			}
			//Harpy Lipstick and Drunken Power statuses rise minimum lust by 50.
			if(hasStatusEffect(StatusEffects.Luststick)) min += 50;
			if(hasStatusEffect(StatusEffects.DrunkenPower)) min += 50;
			//SHOULDRA BOOSTS
			//+20
			if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -168 && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75) {
				min += 20;
				if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -216)
					min += 30;
			}
			//cumOmeter
			if (tailType == Tail.MANTICORE_PUSSYTAIL && flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] <= 25) {
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
			//Werebeast
			if (hasPerk(PerkLib.Lycanthropy)) min += perk(findPerk(PerkLib.Lycanthropy)).value1;
			//Jewelry effects
			if (jewelryEffectId == JewelryLib.MODIFIER_MINIMUM_LUST)
			{
				min += jewelryEffectMagnitude;
				if (min > (minCap - jewelryEffectMagnitude) && jewelryEffectMagnitude < 0)
				{
					minCap += jewelryEffectMagnitude;
				}
			}
			if (armorName == "lusty maiden's armor") min += 30;
			if (armorName == "tentacled bark armor") min += 20;
			//Constrain values
			if (min < 0) min = 0;
			if (min > (maxLust() - 10)) min = (maxLust() - 10);
			if (min > minCap) min = minCap;
			return min;
		}
	
		public function maxToneCap():Number {
			var maxToneCap:Number = 100;
			if (findPerk(PerkLib.OniMusculature) >= 0) maxToneCap += 10;
			if (findPerk(PerkLib.OniMusculatureEvolved) >= 0) maxToneCap += 20;
			if (findPerk(PerkLib.OniMusculatureFinalForm) >= 0) maxToneCap += 30;
			if (findPerk(PerkLib.OrcAdrenalGlandsEvolved) >= 0) maxToneCap += 10;
			return maxToneCap;
		}
		public function maxThicknessCap():Number {
			var maxThicknessCap:Number = 100;
			if (findPerk(PerkLib.PigBoarFat) >= 0) maxThicknessCap += 10;
			if (findPerk(PerkLib.PigBoarFatEvolved) >= 0) maxThicknessCap += 20;
			if (findPerk(PerkLib.PigBoarFatFinalForm) >= 0) maxThicknessCap += 30;
			if (findPerk(PerkLib.ElvishPeripheralNervSysEvolved) >= 0) maxThicknessCap += 10;
			return maxThicknessCap;
		}
		
		public override function getAllMaxStats():Object {
			Begin("Player","getAllMaxStats");
			var maxStr:int = 100;
			var maxTou:int = 100;
			var maxSpe:int = 100;
			var maxInt:int = 100;
			var maxWis:int = 100;
			var maxLib:int = 100;
			var maxSen:int = 100;
			var maxCor:int = 100;
			var newGamePlusMod:int = this.newGamePlusMod()+1;
			
			//Lowered caps due to too low lvl (yes every hero started from zero....right?)
			if (level < 12) {
				maxStr -= (5 * (12 - level));
				maxTou -= (5 * (12 - level));
				maxSpe -= (5 * (12 - level));
				maxInt -= (5 * (12 - level));
				maxWis -= (5 * (12 - level));
				maxLib -= (5 * (12 - level));
				maxSen -= (5 * (12 - level));
			}
			if (findPerk(PerkLib.Strong) > 0) maxStr += (50 * newGamePlusMod);
			if (findPerk(PerkLib.Tough) > 0) maxTou += (50 * newGamePlusMod);
			if (findPerk(PerkLib.Fast) > 0) maxSpe += (50 * newGamePlusMod);
			if (findPerk(PerkLib.Smart) > 0) maxInt += (50 * newGamePlusMod);
			if (findPerk(PerkLib.Wise) > 0) maxWis += (50 * newGamePlusMod);
			if (findPerk(PerkLib.Lusty) > 0) maxLib += (50 * newGamePlusMod);
			if (findPerk(PerkLib.Sensitive) > 0) maxSen += (50 * newGamePlusMod);
			
			//Alter max speed if you have oversized parts. (Realistic mode)
			if (flags[kFLAGS.HUNGER_ENABLED] >= 1)
			{
				//Balls
				var tempSpeedPenalty:Number = 0;
				var lim:int = isTaur() ? 9 : 4;
				if (ballSize > lim && balls > 0) tempSpeedPenalty += Math.round((ballSize - lim) / 2);
				//Breasts
				lim = isTaur() ? BreastCup.I : BreastCup.G;
				if (hasBreasts() && biggestTitSize() > lim) tempSpeedPenalty += ((biggestTitSize() - lim) / 2);
				//Cocks
				lim = isTaur() ? 72 : 24;
				if (biggestCockArea() > lim) tempSpeedPenalty += ((biggestCockArea() - lim) / 6);
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
			Begin("Player","getAllMaxStats.perks");
			if (findPerk(PerkLib.BasiliskResistance) >= 0 && findPerk(PerkLib.GorgonsEyes) >= 0)
			{
				if (findPerk(PerkLib.GorgonsEyesEvolved) >= 0) maxSpe += (5 * newGamePlusMod);
				else maxSpe -= (5 * newGamePlusMod);
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
			End("Player","getAllMaxStats.perks");
			Begin("Player","getAllMaxStats.racial");
			//Alter max stats depending on race (+15 za pkt)
			if (cowScore() >= 4) {
				if (cowScore() >= 10) {
					maxStr += (120 * newGamePlusMod);
					maxTou += (45 * newGamePlusMod);
					maxSpe -= (40 * newGamePlusMod);
					maxInt -= (20 * newGamePlusMod);
					maxLib += (45 * newGamePlusMod);
				}
				else {
					maxStr += (60 * newGamePlusMod);
					maxTou += (10 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
			}//+20/10-20
			if (minotaurScore() >= 4) {
				if (minotaurScore() >= 10) {
					maxStr += (120 * newGamePlusMod);
					maxTou += (45 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
					maxInt -= (40 * newGamePlusMod);
					maxLib += (45 * newGamePlusMod);
				}
				else {
					maxStr += (60 * newGamePlusMod);
					maxTou += (10 * newGamePlusMod);
					maxSpe -= (10 * newGamePlusMod);
					maxInt -= (20 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
			}//+20/10-20
			if (lizardScore() >= 4) {
				if (lizardScore() >= 8) {
					maxTou += (70 * newGamePlusMod);
					maxInt += (50 * newGamePlusMod);
				}
				else {
					maxTou += (40 * newGamePlusMod);
					maxInt += (20 * newGamePlusMod);
				}
			}//+10/10-20
			if (dragonScore() >= 4) {
				if (dragonScore() >= 28) {
				maxStr += (100 * newGamePlusMod);
				maxTou += (100 * newGamePlusMod);
				maxSpe += (40 * newGamePlusMod);
				maxInt += (50 * newGamePlusMod);
				maxWis += (50 * newGamePlusMod);
				maxLib += (20 * newGamePlusMod);
				}//+60
				else if (dragonScore() >= 20 && dragonScore() < 28) {
				maxStr += (95 * newGamePlusMod);
				maxTou += (95 * newGamePlusMod);
				maxSpe += (20 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
				maxWis += (40 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				}
				else if (dragonScore() >= 10 && dragonScore() < 20) {
				maxStr += (50 * newGamePlusMod);
				maxTou += (40 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (20 * newGamePlusMod);
				maxWis += (20 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				}
				else {
				maxStr += (15 * newGamePlusMod);
				maxTou += (15 * newGamePlusMod);
				maxInt += (15 * newGamePlusMod);
				maxWis += (15 * newGamePlusMod);
				}
			}//+60/50-60
			if (jabberwockyScore() >= 10) {
				if (jabberwockyScore() >= 20) {
				maxStr += (95 * newGamePlusMod);
				maxTou += (95 * newGamePlusMod);
				maxSpe += (100 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
				maxWis -= (50 * newGamePlusMod);
				maxLib += (20 * newGamePlusMod);
				}
				else {
				maxStr += (50 * newGamePlusMod);
				maxTou += (40 * newGamePlusMod);
				maxSpe += (50 * newGamePlusMod);
				maxInt += (20 * newGamePlusMod);
				maxWis -= (20 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				}
			}
			if (dogScore() >= 4) {
				maxSpe += (15 * newGamePlusMod);
				maxInt -= (5 * newGamePlusMod);
			}//+10/10-20
			if (mouseScore() >= 4) {
				if (mouseScore() >= 12 && arms.type == Arms.HINEZUMI && lowerBody == LowerBody.HINEZUMI) {
					maxStr += (60 * newGamePlusMod);
					maxTou -= (10 * newGamePlusMod);
					maxSpe += (80 * newGamePlusMod);
					maxWis += (50 * newGamePlusMod);
				}
				else if (mouseScore() >= 8) {
					maxTou -= (10 * newGamePlusMod);
					maxSpe += (80 * newGamePlusMod);
					maxWis += (50 * newGamePlusMod);
				}
				else {
					maxTou -= (10 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
					maxWis += (30 * newGamePlusMod);
				}
			}
			if (wolfScore() >= 4) {
				if (wolfScore() >= 10) {
					maxStr += (60 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxSpe += (60 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
				}
				else if (wolfScore() >= 7 && hasFur() && coatColor == "glacial white") {
					maxStr += (30 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
				}
				else if (wolfScore() >= 6) {
					maxStr += (30 * newGamePlusMod);
					maxTou += (10 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
				}
				else {
					maxStr += (15 * newGamePlusMod);
					maxSpe += (10 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
				}
			}//+15(60)((70))(((140))) / 10 - 20(50 - 60)((70 - 80))(((130 - 140)))
			if (werewolfScore() >= 12) {
				/*if (werewolfScore() >= 12) {
					maxStr += (100 * newGamePlusMod);
					maxTou += (40 * newGamePlusMod);
					maxSpe += (60 * newGamePlusMod);
					maxInt -= (20 * newGamePlusMod);
				}
				else {*/
					maxStr += (100 * newGamePlusMod);
					maxTou += (40 * newGamePlusMod);
					maxSpe += (60 * newGamePlusMod);
					maxInt -= (20 * newGamePlusMod);
				//}
			}
			if (foxScore() >= 4) {
				if (foxScore() >= 7) {
					maxStr -= (30 * newGamePlusMod);
					maxSpe += (80 * newGamePlusMod);
					maxInt += (55 * newGamePlusMod);
				}
				else {
					maxStr -= (5 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
					maxInt += (25 * newGamePlusMod);
				}
			}//+10/10-20
			if (catScore() >= 4) {
				if (catScore() >= 8) {
					if (findPerk(PerkLib.Flexibility) > 0) maxSpe += (70 * newGamePlusMod);
					else maxSpe += (60 * newGamePlusMod);
					maxLib += (60 * newGamePlusMod);
				}
				else {
					if (findPerk(PerkLib.Flexibility) > 0) maxSpe += (50 * newGamePlusMod);
					else maxSpe += (40 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
			}//+10 / 10 - 20
			if (sphinxScore() >= 14) {
				maxStr += (50 * newGamePlusMod);
				maxTou -= (20 * newGamePlusMod);
				if (findPerk(PerkLib.Flexibility) > 0) maxSpe += (50 * newGamePlusMod);
				else maxSpe += (40 * newGamePlusMod);
				maxInt += (100 * newGamePlusMod);
				maxWis += (40 * newGamePlusMod);
			}//+50/-20/+40/+100/+40
			if (nekomataScore() >= 10) {
				if (findPerk(PerkLib.Flexibility) > 0) maxSpe += (50 * newGamePlusMod);
				else maxSpe += (40 * newGamePlusMod);
				if (tailType == 8 && tailCount >= 2 && nekomataScore() >= 12) {
					maxInt += (40 * newGamePlusMod);
					maxWis += (100 * newGamePlusMod);
				}
				else {
					maxInt += (30 * newGamePlusMod);
					maxWis += (80 * newGamePlusMod);
				}
			}
			if (cheshireScore() >= 11) {
				if (findPerk(PerkLib.Flexibility) > 0) maxSpe += (70 * newGamePlusMod);
				else maxSpe += (60 * newGamePlusMod);
				maxInt += (80 * newGamePlusMod);
				maxSen += (25 * newGamePlusMod)
			}
			if (hellcatScore() >= 10) {
				if (findPerk(PerkLib.Flexibility) > 0) maxSpe += (50 * newGamePlusMod);
				else maxSpe += (40 * newGamePlusMod);
				maxInt += (70 * newGamePlusMod);
				maxLib += (40 * newGamePlusMod);
				maxSen += (25 * newGamePlusMod);
			}
			if (displacerbeastScore() >= 14) {
				maxStr += (95 * newGamePlusMod);
				if (findPerk(PerkLib.Flexibility) > 0) maxSpe += (110 * newGamePlusMod);
				else maxSpe += (100 * newGamePlusMod);
				maxInt -= (25 * newGamePlusMod);
				maxWis -= (20 * newGamePlusMod);
				maxLib += (60 * newGamePlusMod);
			}
			if (bunnyScore() >= 5) {/*
				if (bunnyScore() >= 10) {
					maxStr -= (20 * newGamePlusMod);
					maxTou -= (10 * newGamePlusMod);
					maxSpe += (90 * newGamePlusMod);
					maxLib += (90 * newGamePlusMod);
				}*/
				if (bunnyScore() >= 10) {
					maxStr -= (20 * newGamePlusMod);
					maxTou -= (10 * newGamePlusMod);
					maxSpe += (90 * newGamePlusMod);
					maxLib += (90 * newGamePlusMod);
				}
				else {
					maxStr -= (10 * newGamePlusMod);
					maxTou -= (5 * newGamePlusMod);
					maxSpe += (55 * newGamePlusMod);
					maxLib += (35 * newGamePlusMod);
				}
			}//+10/10-20
			if (raccoonScore() >= 4) {
				maxSpe += (15 * newGamePlusMod);
			}//+15/10-20
			if (horseScore() >= 4) {
				if (horseScore() >= 7) {
					maxSpe += (70 * newGamePlusMod);
					maxTou += (35 * newGamePlusMod);
				}
				else {
					maxSpe += (40 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
				}
			}//+15/10-20
			if (goblinScore() >= 10) {
				maxStr -= (50 * newGamePlusMod);
				maxSpe += (75 * newGamePlusMod);
				maxInt += (100 * newGamePlusMod);
				maxLib += (25 * newGamePlusMod);
			}//+20/10-20
			if (gooScore() >= 5) {
				if (gooScore() >= 15) {
					maxTou += (115 * newGamePlusMod);
					maxSpe -= (50 * newGamePlusMod);
					maxLib += (160 * newGamePlusMod);
				}
				else if (gooScore() >= 11) {
					maxTou += (100 * newGamePlusMod);
					maxSpe -= (40 * newGamePlusMod);
					maxLib += (105 * newGamePlusMod);
				}
				else {
					maxTou += (45 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
					maxLib += (50 * newGamePlusMod);
				}
			}//+20/10-20
			if (magmagooScore() >= 6) {
				if (magmagooScore() >= 17) {
					maxStr += (45 * newGamePlusMod);
					maxTou += (115 * newGamePlusMod);
					maxSpe -= (50 * newGamePlusMod);
					maxLib += (145 * newGamePlusMod);
				}
				else if (magmagooScore() >= 13) {
					maxStr += (35 * newGamePlusMod);
					maxTou += (100 * newGamePlusMod);
					maxSpe -= (40 * newGamePlusMod);
					maxLib += (100 * newGamePlusMod);
				}
				else {
					maxStr += (15 * newGamePlusMod);
					maxTou += (45 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
					maxLib += (50 * newGamePlusMod);
				}
			}//+20/10-20
			if (darkgooScore() >= 6) {
				if (darkgooScore() >= 17) {
					maxTou += (115 * newGamePlusMod);
					maxSpe -= (50 * newGamePlusMod);
					maxInt += (45 * newGamePlusMod);
					maxLib += (145 * newGamePlusMod);
				}
				else if (darkgooScore() >= 13) {
					maxTou += (90 * newGamePlusMod);
					maxSpe -= (40 * newGamePlusMod);
					maxInt += (45 * newGamePlusMod);
					maxLib += (100 * newGamePlusMod);
				}
				else {
					maxTou += (45 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
					maxInt += (15 * newGamePlusMod);
					maxLib += (50 * newGamePlusMod);
				}
			}//+20/10-20
			if (kitsuneScore() >= 5) {
				if (kitsuneScore() >= 12 && tailType == 13 && tailCount == 9) {
					maxStr -= (50 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
					maxInt += (70 * newGamePlusMod);
					maxWis += (100 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
				else {
					maxStr -= (35 * newGamePlusMod);
					maxSpe += (20 * newGamePlusMod);
					maxInt += (30 * newGamePlusMod);
					maxWis += (40 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
			}//+50/50-60
		/*	if (kitshooScore() >= 6) {
				if (tailType == 26) {
					if (tailCount == 1) {
						maxStr -= (2 * newGamePlusMod);
						maxSpe += (2 * newGamePlusMod);
						maxInt += (4 * newGamePlusMod);
					}
					else if (tailCount >= 2 && tailCount < 9) {
						maxStr -= ((tailCount + 1) * newGamePlusMod);
						maxSpe += ((tailCount + 1) * newGamePlusMod);
						maxInt += (((tailCount/2) + 2) * newGamePlusMod);
					}
					else if (tailCount >= 9) {
						maxStr -= (10 * newGamePlusMod);;
						maxSpe += (10 * newGamePlusMod);;
						maxInt += (20 * newGamePlusMod);;
					}
				}
			}
		*/	if (beeScore() >= 5) {
				if (beeScore() >= 9) {
					maxTou += (50 * newGamePlusMod);
					maxSpe += (50 * newGamePlusMod);
					maxInt += (35 * newGamePlusMod);
				}
				else {
					maxTou += (30 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
					maxInt += (15 * newGamePlusMod);
				}
			}//+40/30-40
			if (spiderScore() >= 4) {
				if (spiderScore() >= 7) {
					maxStr -= (20 * newGamePlusMod);
					maxTou += (50 * newGamePlusMod);
					maxInt += (75 * newGamePlusMod);
				}
				else {
					maxStr -= (10 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxInt += (40 * newGamePlusMod);
				}
			}//+10/10-20
			if (kangaScore() >= 4) {
				maxTou += (5 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
			}//+20/10-20
			if (sharkScore() >= 4) {
				if (sharkScore() >= 10 && vaginas.length > 0 && cocks.length > 0) {
					maxStr += (60 * newGamePlusMod);
					maxSpe += (85 * newGamePlusMod);
					maxLib += (20 * newGamePlusMod);
				}
				else if (sharkScore() >= 9) {
					maxStr += (40 * newGamePlusMod);
					maxSpe += (85 * newGamePlusMod);
					maxLib += (10 * newGamePlusMod);
				}
				else {
					maxStr += (20 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
				}
			}//+10/10-20
			if (harpyScore() >= 4) {
				if (harpyScore() >= 8) {
					maxTou -= (20 * newGamePlusMod);
					maxSpe += (80 * newGamePlusMod);
					maxLib += (60 * newGamePlusMod);
				}
				else {
					maxTou -= (10 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
					maxLib += (30 * newGamePlusMod);
				}
			}//+10/10-20
			if (sirenScore() >= 10) {
				maxStr += (40 * newGamePlusMod);
				maxSpe += (70 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
			}//+20/10-20
			if (orcaScore() >= 6) {
				if (orcaScore() >= 12) {
					maxStr += (70 * newGamePlusMod);
					maxTou += (40 * newGamePlusMod);
					maxSpe += (70 * newGamePlusMod);
				}
				else {
					maxStr += (35 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
					maxSpe += (35 * newGamePlusMod);
				}
			}//+10/10-20
			if (oniScore() >= 6) {
				if (oniScore() >= 12) {
					maxStr += (100 * newGamePlusMod);
					maxTou += (60 * newGamePlusMod);
					maxInt -= (20 * newGamePlusMod);
					maxWis += (40 * newGamePlusMod);
				}
				else {
					maxStr += (50 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
					maxWis += (20 * newGamePlusMod);
				}
			}//+10/10-20
			if (elfScore() >= 5) {
				/*if (elfScore() >= 12 && wings.type == Wings.NONE) {
					maxStr -= (10 * newGamePlusMod);
					maxTou -= (15 * newGamePlusMod);
					maxSpe += (80 * newGamePlusMod);
					maxInt += (80 * newGamePlusMod);
					maxWis += (60 * newGamePlusMod);
					maxSen += (30 * newGamePlusMod);
				}
				else */if (elfScore() >= 11) {
					maxStr -= (10 * newGamePlusMod);
					maxTou -= (15 * newGamePlusMod);
					maxSpe += (80 * newGamePlusMod);
					maxInt += (80 * newGamePlusMod);
					maxWis += (60 * newGamePlusMod);
					maxSen += (30 * newGamePlusMod);
				}
				else {
					maxStr -= (10 * newGamePlusMod);
					maxTou -= (10 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
					maxInt += (40 * newGamePlusMod);
					maxWis += (30 * newGamePlusMod);
					maxSen += (15 * newGamePlusMod);
				}
			}//+10/10-20
			if (orcScore() >= 5) {
				/*if (orcScore() >= 12 && tailType == Tail.NONE) {
					maxStr += (130 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxSpe += (10 * newGamePlusMod);
					maxInt -= (30 * newGamePlusMod);
					maxLib += (25 * newGamePlusMod); 
				}
				else */if (orcScore() >= 11) {
					maxStr += (130 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxSpe += (10 * newGamePlusMod);
					maxInt -= (30 * newGamePlusMod);
					maxLib += (25 * newGamePlusMod);
				}
				else {
					maxStr += (60 * newGamePlusMod);
					maxTou += (15 * newGamePlusMod);
					maxSpe += (5 * newGamePlusMod);
					maxInt -= (15 * newGamePlusMod);
					maxLib += (10 * newGamePlusMod);
				}
			}//+10/10-20
			if (raijuScore() >= 5) {
				if (raijuScore() >= 10) {
					maxSpe += (70 * newGamePlusMod);
					maxInt += (50 * newGamePlusMod);
					maxLib += (80 * newGamePlusMod);
					maxSen += (50 * newGamePlusMod);
				}
				else {
					maxSpe += (35 * newGamePlusMod);
					maxInt += (25 * newGamePlusMod);
					maxLib += (40 * newGamePlusMod);
					maxSen += (25 * newGamePlusMod);
				}
			}//+10/10-20
			if (thunderbirdScore() >= 12) {
				maxTou -= (20 * newGamePlusMod);
				maxSpe += (100 * newGamePlusMod);
				maxLib += (100 * newGamePlusMod);
			}//+10/10-20
			if (demonScore() >= 5) {
				if (demonScore() >= 11) {
					maxSpe += (30 * newGamePlusMod);
					maxInt += (35 * newGamePlusMod);
					maxLib += (100 * newGamePlusMod);
				}
				else {
					maxSpe += (15 * newGamePlusMod);
					maxInt += (15 * newGamePlusMod);
					maxLib += (45 * newGamePlusMod);
				}
			}//+60/50-60
			if (devilkinScore() >= 7) {
				if (devilkinScore() >= 16 && hasStatusEffect(StatusEffects.PlayerPhylactery)) {
					if (devilkinScore() >= 21) {
						maxStr += (105 * newGamePlusMod);
						maxInt += (150 * newGamePlusMod);
						maxLib += (100 * newGamePlusMod);
					}
					else {
						maxStr += (95 * newGamePlusMod);
						maxInt += (85 * newGamePlusMod);
						maxLib += (100 * newGamePlusMod);
					}
				}
				else if (devilkinScore() >= 11) {
					maxStr += (65 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
					maxInt += (60 * newGamePlusMod);
					maxLib += (75 * newGamePlusMod);
				}
				else {
					maxStr += (35 * newGamePlusMod);
					maxSpe -= (10 * newGamePlusMod);
					maxInt += (40 * newGamePlusMod);
					maxLib += (50 * newGamePlusMod);
				}
			}//+60/50-60
			if (rhinoScore() >= 4) {
				maxStr += (15 * newGamePlusMod);
				maxTou += (15 * newGamePlusMod);
				maxSpe -= (10 * newGamePlusMod);
				maxInt -= (10 * newGamePlusMod);
			}//+10/10-20
			if (satyrScore() >= 4) {
				maxStr += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
			}//+10/10-20
			if (manticoreScore() >= 6) {
				if (manticoreScore() >= 12) {
					maxSpe += (100 * newGamePlusMod);
					maxInt += (50 * newGamePlusMod);
					maxLib += (60 * newGamePlusMod);
				}
				else {
					maxSpe += (50 * newGamePlusMod);
					maxInt += (25 * newGamePlusMod);
					maxLib += (30 * newGamePlusMod);
				}
			}//+60/50-60
			if (redpandaScore() >= 4) {
				if (redpandaScore() >= 8) {
					maxStr += (15 * newGamePlusMod);
					maxSpe += (75 * newGamePlusMod);
					maxInt += (30 * newGamePlusMod);
				}
				else {
					maxSpe += (45 * newGamePlusMod);
					maxInt += (15 * newGamePlusMod);
				}
			}
			if (bearpandaScore() >= 5) {
				if (bearpandaScore() >= 10) {
					maxStr += (100 * newGamePlusMod);
					maxTou += (70 * newGamePlusMod);
					maxInt -= (20 * newGamePlusMod);
				}
				else {
					maxStr += (50 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxInt -= (5 * newGamePlusMod);
				}
			}
			if (pigScore() >= 5) {
				if (pigScore() >= 15) {
					maxStr += (125 * newGamePlusMod);
					maxTou += (125 * newGamePlusMod);
					maxSpe -= (15 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
				}
				else if (pigScore() >= 10 && pigScore() < 15) {
					maxStr += (60 * newGamePlusMod);
					maxTou += (120 * newGamePlusMod);
					maxSpe -= (15 * newGamePlusMod);
					maxInt -= (10 * newGamePlusMod);
					maxWis -= (5 * newGamePlusMod);
				}
				else {
					maxStr += (30 * newGamePlusMod);
					maxTou += (60 * newGamePlusMod);
					maxSpe -= (10 * newGamePlusMod);
					maxInt -= (5 * newGamePlusMod);
				}
			}
			if (mantisScore() >= 6) {
				if (mantisScore() >= 12) {
					maxStr -= (40 * newGamePlusMod);
					maxTou += (60 * newGamePlusMod);
					maxSpe += (140 * newGamePlusMod);
					maxInt += (20 * newGamePlusMod);
				}
				else {
					maxStr -= (20 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxSpe += (70 * newGamePlusMod);
					maxInt += (10 * newGamePlusMod);
				}
			}//+35/30-40
			if (salamanderScore() >= 4) {
				if (salamanderScore() >= 7) {
					maxStr += (25 * newGamePlusMod);
					maxTou += (25 * newGamePlusMod);
					maxLib += (40 * newGamePlusMod);
				}
				else {
					maxStr += (15 * newGamePlusMod);
					maxTou += (15 * newGamePlusMod);
					maxLib += (30 * newGamePlusMod);
				}
			}//+15/10-20
			if (cavewyrmScore() >= 5) {
				if (cavewyrmScore() >= 10) {
					maxStr += (60 * newGamePlusMod);
					maxTou += (70 * newGamePlusMod);
					maxWis -= (30 * newGamePlusMod);
					maxLib += (50 * newGamePlusMod);
				}
				else {
					maxStr += (30 * newGamePlusMod);
					maxTou += (35 * newGamePlusMod);
					maxWis -= (15 * newGamePlusMod);
					maxLib += (25 * newGamePlusMod);
				}
			}//+15/10-20
			if (unicornScore() >= 10) {
				maxTou += (20 * newGamePlusMod);
				maxSpe += (40 * newGamePlusMod);
				maxInt += (30 * newGamePlusMod);
				maxWis += (60 * newGamePlusMod);
			}//+(15)30/(10-20)30-40
			if (alicornScore() >= 12) {
				maxTou += (25 * newGamePlusMod);
				maxSpe += (50 * newGamePlusMod);
				maxInt += (35 * newGamePlusMod);
				maxWis += (70 * newGamePlusMod);
			}//+(30)55/(30-40)50-60
			if (phoenixScore() >= 10) {
				maxStr += (20 * newGamePlusMod);
				maxTou += (20 * newGamePlusMod);
				maxSpe += (70 * newGamePlusMod);
				maxLib += (40 * newGamePlusMod);
			}//+30/30-40
			if (scyllaScore() >= 4) {
				if (scyllaScore() >= 12) {
					maxStr += (120 * newGamePlusMod);
					maxInt += (60 * newGamePlusMod);
				}
				else if (scyllaScore() >= 7 && scyllaScore() < 12) {
					maxStr += (65 * newGamePlusMod);
					maxInt += (40 * newGamePlusMod);
				}
				else {
					maxStr += (40 * newGamePlusMod);
					maxInt += (20 * newGamePlusMod);
				}
			}//+30/30-40
			if (plantScore() >= 4) {
				if (plantScore() >= 7) {
					maxStr += (25 * newGamePlusMod);
					maxTou += (100 * newGamePlusMod);
					maxSpe -= (50 * newGamePlusMod);
				}
				else if (plantScore() == 6) {
					maxStr += (20 * newGamePlusMod);
					maxTou += (80 * newGamePlusMod);
					maxSpe -= (40 * newGamePlusMod);
				}
				else if (plantScore() == 5) {
					maxStr += (10 * newGamePlusMod);
					maxTou += (50 * newGamePlusMod);
					maxSpe -= (20 * newGamePlusMod);
				}
				else {
					maxTou += (30 * newGamePlusMod);
					maxSpe -= (10 * newGamePlusMod);
				}
			}//+20(40)(60)(75)/10-20(30-40)(50-60)(70-80)
			if (alrauneScore() >= 10) {
				maxTou += (100 * newGamePlusMod);
				maxSpe -= (50 * newGamePlusMod);
				maxLib += (100 * newGamePlusMod);
			}
			if (yggdrasilScore() >= 10) {
				maxStr += (50 * newGamePlusMod);
				maxTou += (70 * newGamePlusMod);
				maxSpe -= (50 * newGamePlusMod);
				maxInt += (50 * newGamePlusMod);
				maxWis += (80 * newGamePlusMod);
				maxLib -= (50 * newGamePlusMod);
			}//+150
			if (deerScore() >= 4) {
				maxSpe += (20 * newGamePlusMod);
			}//+20/10-20
			if (yetiScore() >= 7) {
				if (yetiScore() >= 14) {
					maxStr += (100 * newGamePlusMod);
					maxTou += (80 * newGamePlusMod);
					maxSpe += (50 * newGamePlusMod);
					maxInt -= (70 * newGamePlusMod);
					maxLib += (50 * newGamePlusMod);
				}
				else {
					maxStr += (50 * newGamePlusMod);
					maxTou += (40 * newGamePlusMod);
					maxSpe += (25 * newGamePlusMod);
					maxInt -= (35 * newGamePlusMod);
					maxLib += (25 * newGamePlusMod);
				}
			}
			if (yukiOnnaScore() >= 14) {
				maxSpe += (70 * newGamePlusMod);
				maxInt += (140 * newGamePlusMod);
				maxWis += (70 * newGamePlusMod);
				maxLib += (50 * newGamePlusMod);
			}
			if (poltergeistScore() >= 6) {
				if (poltergeistScore() >= 18) {
					maxStr -= (45 * newGamePlusMod);
					maxTou -= (45 * newGamePlusMod);
					maxSpe += (150 * newGamePlusMod);
					maxInt += (150 * newGamePlusMod);
					maxWis += (60 * newGamePlusMod);
				}
				else if (poltergeistScore() >= 12) {
					maxStr -= (25 * newGamePlusMod);
					maxTou -= (25 * newGamePlusMod);
					maxSpe += (90 * newGamePlusMod);
					maxInt += (90 * newGamePlusMod);
					maxWis += (45 * newGamePlusMod);
				}
				else {
					maxStr -= (15 * newGamePlusMod);
					maxTou -= (15 * newGamePlusMod);
					maxSpe += (45 * newGamePlusMod);
					maxInt += (45 * newGamePlusMod);
					maxWis += (30 * newGamePlusMod);
				}
			}
			if (bansheeScore() >= 4) {
				
			}
			if (firesnailScore() >= 15) {
				maxStr += (65 * newGamePlusMod);
				maxTou += (140 * newGamePlusMod);
				maxSpe -= (80 * newGamePlusMod);
				maxLib += (100 * newGamePlusMod);
				maxSen += (50 * newGamePlusMod);
			}//+30/30-40
			if (lowerBody == 51 && hydraScore() >= 14) {
				if (hydraScore() >= 29) {
					maxStr += (160 * newGamePlusMod);
					maxTou += (145 * newGamePlusMod);
					maxSpe += (130 * newGamePlusMod);
				}
				else if (hydraScore() >= 24) {
					maxStr += (130 * newGamePlusMod);
					maxTou += (125 * newGamePlusMod);
					maxSpe += (105 * newGamePlusMod);
				}
				else if (hydraScore() >= 19) {
					maxStr += (120 * newGamePlusMod);
					maxTou += (105 * newGamePlusMod);
					maxSpe += (60 * newGamePlusMod);
				}
				else {
					maxStr += (100 * newGamePlusMod);
					maxTou += (50 * newGamePlusMod);
					maxSpe += (60 * newGamePlusMod);
				}
			}//+30/30-40
			if (couatlScore() >= 11) {
				maxStr += (40 * newGamePlusMod);
				maxTou += (25 * newGamePlusMod);
				maxSpe += (100 * newGamePlusMod);
			}//+30/30-40
			if (vouivreScore() >= 11) {
				maxStr += (10 * newGamePlusMod);
				maxTou -= (10 * newGamePlusMod);
				maxSpe += (35 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis -= (20 * newGamePlusMod);
			}//+30/30-40
			if (gorgonScore() >= 11) {
				maxStr += (50 * newGamePlusMod);
				maxTou += (45 * newGamePlusMod);
				maxSpe += (70 * newGamePlusMod);
			}//+30/30-40
			if (nagaScore() >= 4)
			{
				if (nagaScore() >= 8) {
					maxStr += (40 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
					maxSpe += (60 * newGamePlusMod);
				}
				else {
					maxStr += (20 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
				}
			}
			if (centaurScore() >= 8) {
				maxTou += (80 * newGamePlusMod);
				maxSpe += (40 * newGamePlusMod);
			}//+40/30-40
			if (avianScore() >= 4) {
				if (avianScore() >= 9) {
					maxStr += (30 * newGamePlusMod);
					maxSpe += (75 * newGamePlusMod);
					maxInt += (30 * newGamePlusMod);
				}
				else {
					maxStr += (15 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
					maxInt += (15 * newGamePlusMod);
				}
			}
			if (isNaga()) {
				maxStr += (15 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
			}
			if (isTaur()) {
				maxSpe += (20 * newGamePlusMod);
			}
			if (isDrider()) {
				maxTou += (15 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
			}
			if (isScylla()) {
				maxStr += (30 * newGamePlusMod);
			}
			if (isAlraune()) {
				maxTou += (15 * newGamePlusMod);
				maxLib += (15 * newGamePlusMod);
			}
			if (batScore() >= 6){
                var mod:int = batScore() >= 10 ? 35:20;
                maxStr += mod * newGamePlusMod;
                maxSpe += mod * newGamePlusMod;
                maxInt += mod * newGamePlusMod;
                maxLib += (10+mod) * newGamePlusMod;
			}
			if (vampireScore() >= 6){
                mod = vampireScore() >= 10 ? 35:20;
				maxStr += mod * newGamePlusMod;
				maxSpe += mod * newGamePlusMod;
				maxInt += mod * newGamePlusMod;
				maxLib += (10 + mod) * newGamePlusMod;
			}
			if (internalChimeraScore() >= 1) {
				maxStr += (5 * internalChimeraScore() * newGamePlusMod);
				maxTou += (5 * internalChimeraScore() * newGamePlusMod);
				maxSpe += (5 * internalChimeraScore() * newGamePlusMod);
				maxInt += (5 * internalChimeraScore() * newGamePlusMod);
				maxWis += (5 * internalChimeraScore() * newGamePlusMod);
				maxLib += (5 * internalChimeraScore() * newGamePlusMod);
				maxSen += (5 * internalChimeraScore() * newGamePlusMod);
			}
			if (jiangshiScore() >= 20) {
				maxStr += (140 * newGamePlusMod);
				maxTou += (100 * newGamePlusMod);
				maxSpe -= (90 * newGamePlusMod);
				maxInt -= (90 * newGamePlusMod);
				maxWis += (110 * newGamePlusMod);
				maxLib += (130 * newGamePlusMod);
			}//+110 strength +80 toughness +60 Wisdom +100 Libido +50 sensitivity
			if (gargoyleScore() >= 20) {
				if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) {
					maxStr += (165 * newGamePlusMod);
					maxTou += (250 * newGamePlusMod);
					maxSpe += (50 * newGamePlusMod);
					maxInt += (30 * newGamePlusMod);
				}
				if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) {
					maxStr += (50 * newGamePlusMod);
					maxTou += (250 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
					maxInt += (165 * newGamePlusMod);
				}
				if (findPerk(PerkLib.GargoylePure) >= 0) {
					maxWis += (80 * newGamePlusMod);
					maxLib -= (10 * newGamePlusMod);
					maxSen -= (10 * newGamePlusMod);
				}
				if (findPerk(PerkLib.GargoyleCorrupted) >= 0) {
					maxWis -= (10 * newGamePlusMod);
					maxLib += (80 * newGamePlusMod);
				}
			}
			if (maxStr < 25) maxStr = 25;
			if (maxTou < 25) maxTou = 25;
			if (maxSpe < 25) maxSpe = 25;
			if (maxInt < 25) maxInt = 25;
			if (maxWis < 25) maxWis = 25;
			if (maxLib < 25) maxLib = 25;
			if (maxSen < 25) maxSen = 25;
			End("Player","getAllMaxStats.racial");
			Begin("Player","getAllMaxStats.perks2");
			if (findPerk(PerkLib.ChimericalBodyInitialStage) >= 0) {
				maxTou += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ChimericalBodySemiBasicStage) >= 0) {
				maxStr += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ChimericalBodyBasicStage) >= 0) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
				maxSen += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
				maxSen += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ChimericalBodySemiSuperiorStage) >= 0) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
				maxSen += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ChimericalBodySuperiorStage) >= 0) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
				maxSen += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ChimericalBodyPeerlessStage) >= 0) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
				maxSen += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ChimericalBodySemiEpicStage) >= 0) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				maxSen += (10 * newGamePlusMod);// 8/8/8/7/7/7/7
			}
			if (findPerk(PerkLib.ChimericalBodyEpicStage) >= 0) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
				maxSen += (5 * newGamePlusMod);// 10/10/10/7/7/6/6
			}
			if (findPerk(PerkLib.BlackHeartFinalForm) >= 0) {
				maxWis += (5 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.CatlikeNimblenessEvolved) >= 0) maxSpe += (10 * newGamePlusMod);
			if (findPerk(PerkLib.DraconicLungs) >= 0) maxSpe += (5 * newGamePlusMod);
			if (findPerk(PerkLib.DraconicLungsEvolved) >= 0) {
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.DraconicLungsFinalForm) >= 0) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ElvishPeripheralNervSysEvolved) >= 0) maxSpe += (5 * newGamePlusMod);
			if (findPerk(PerkLib.ElvishPeripheralNervSysFinalForm) >= 0) maxSpe += (5 * newGamePlusMod);
			if (findPerk(PerkLib.GorgonsEyesEvolved) >= 0) {
				maxSpe += (5 * newGamePlusMod);
				maxSen += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.HinezumiBurningBloodFinalForm) >= 0) maxTou += (10 * newGamePlusMod);
			if (findPerk(PerkLib.KitsuneThyroidGland) >= 0) maxSpe += (5 * newGamePlusMod);
			if (findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0) {
				maxSpe += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.KitsuneThyroidGlandEvolved) >= 0) {
				maxSpe += (5 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.LactaBovinaOvariesEvolved) >= 0) maxLib += (10 * newGamePlusMod);
			if (findPerk(PerkLib.LactaBovinaOvariesFinalForm) >= 0) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.MantislikeAgility) >= 0) {
				if (hasCoatOfType(Skin.CHITIN) && findPerk(PerkLib.ThickSkin) >= 0) maxSpe += (20 * newGamePlusMod);
				if ((skinType == Skin.SCALES && findPerk(PerkLib.ThickSkin) >= 0) || hasCoatOfType(Skin.CHITIN)) maxSpe += (15 * newGamePlusMod);
				if (skinType == Skin.SCALES) maxSpe += (10 * newGamePlusMod);
				if (findPerk(PerkLib.ThickSkin) >= 0) maxSpe += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.MantislikeAgilityEvolved) >= 0) {
				if (hasCoatOfType(Skin.CHITIN) && findPerk(PerkLib.ThickSkin) >= 0) maxSpe += (25 * newGamePlusMod);
				if ((skinType == Skin.SCALES && findPerk(PerkLib.ThickSkin) >= 0) || hasCoatOfType(Skin.CHITIN)) maxSpe += (20 * newGamePlusMod);
				if (skinType == Skin.SCALES) maxSpe += (15 * newGamePlusMod);
				if (findPerk(PerkLib.ThickSkin) >= 0) maxSpe += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.MinotaurTesticlesEvolved) >= 0) maxLib += (10 * newGamePlusMod);
			if (findPerk(PerkLib.MinotaurTesticlesFinalForm) >= 0) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.NaturalPunchingBag) >= 0) maxTou += (5 * newGamePlusMod);
			if (findPerk(PerkLib.NaturalPunchingBagEvolved) >= 0) maxTou += (10 * newGamePlusMod);
			if (findPerk(PerkLib.NaturalPunchingBagFinalForm) >= 0) maxTou += (20 * newGamePlusMod);
			if (findPerk(PerkLib.ObsidianHeartFinalForm) >= 0) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.OniMusculature) >= 0) maxStr += (5 * newGamePlusMod);
			if (findPerk(PerkLib.OniMusculatureEvolved) >= 0) maxStr += (10 * newGamePlusMod);
			if (findPerk(PerkLib.OniMusculatureFinalForm) >= 0) maxStr += (15 * newGamePlusMod);
			if (findPerk(PerkLib.OrcAdrenalGlandsEvolved) >= 0) maxStr += (5 * newGamePlusMod);
			if (findPerk(PerkLib.OrcAdrenalGlandsFinalForm) >= 0) maxStr += (5 * newGamePlusMod);
			if (findPerk(PerkLib.PigBoarFat) >= 0) maxTou += (5 * newGamePlusMod);
			if (findPerk(PerkLib.PigBoarFatEvolved) >= 0) maxTou += (10 * newGamePlusMod);
			if (findPerk(PerkLib.PigBoarFatFinalForm) >= 0) maxTou += (15 * newGamePlusMod);
			if (findPerk(PerkLib.SalamanderAdrenalGlands) >= 0) {
				maxTou += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.SalamanderAdrenalGlandsEvolved) >= 0) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.SalamanderAdrenalGlandsFinalForm) >= 0) {
				maxStr += (15 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ScyllaInkGlands) >= 0) maxStr += (10 * newGamePlusMod);
			if (findPerk(PerkLib.TrachealSystemEvolved) >= 0) maxStr += (5 * newGamePlusMod);
			if (findPerk(PerkLib.TrachealSystemFinalForm) >= 0) maxSpe += (10 * newGamePlusMod);
			if (findPerk(PerkLib.TwinHeart) >= 0) {
				maxSpe += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.TwinHeartEvolved) >= 0) {
				maxSpe += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.TwinHeartFinalForm) >= 0) {
				maxSpe += (30 * newGamePlusMod);
				maxTou += (30 * newGamePlusMod);
			}
			if (findPerk(PerkLib.VenomGlandsFinalForm) >= 0) maxTou += (10 * newGamePlusMod);
			if (findPerk(PerkLib.EzekielBlessing) >= 0) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
				maxSen += (5 * newGamePlusMod);
			}
			//Perks
			if (findPerk(PerkLib.JobAllRounder) >= 0) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
				maxSen += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.JobBeastWarrior) >= 0) {
				maxStr += (5 * newGamePlusMod);
				maxTou += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
				if (findPerk(PerkLib.ImprovingNaturesBlueprintsApexPredator) >= 0) {
					maxInt += (5 * newGamePlusMod);
					maxWis += (5 * newGamePlusMod);
				}
				else {
					maxInt -= (5 * newGamePlusMod);
					maxWis -= (5 * newGamePlusMod);
				}
			}
			if (findPerk(PerkLib.JobBrawler) >= 0) maxStr += (10 * newGamePlusMod);
			if (findPerk(PerkLib.JobCourtesan) >= 0) maxLib += (15 * newGamePlusMod);
			if (findPerk(PerkLib.JobDefender) >= 0) maxTou += (15 * newGamePlusMod);
			if (findPerk(PerkLib.JobDervish) >= 0) maxSpe += (10 * newGamePlusMod);
			if (findPerk(PerkLib.JobElementalConjurer) >= 0) maxWis += (5 * newGamePlusMod);
			if (findPerk(PerkLib.JobEnchanter) >= 0) maxInt += (15 * newGamePlusMod);
			if (findPerk(PerkLib.JobEromancer) >= 0) {
				maxInt += (5 * newGamePlusMod);
				maxLib += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.JobGolemancer) >= 0) {
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.JobGuardian) >= 0) maxTou += (5 * newGamePlusMod);
			if (findPerk(PerkLib.JobGunslinger) >= 0) maxWis += (10 * newGamePlusMod);
			if (findPerk(PerkLib.JobHealer) >= 0) {
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.JobHunter) >= 0) {
				maxSpe += (10 * newGamePlusMod);
				maxInt += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.JobKnight) >= 0) maxTou += (10 * newGamePlusMod);
			if (findPerk(PerkLib.JobLeader) >= 0) {
				maxInt += (5 * newGamePlusMod);
				maxWis += (5 * newGamePlusMod);
				if (findPerk(PerkLib.ShootTheLoadAndHitTheRoad) >= 0) maxSpe += (5 * newGamePlusMod);
				if (findPerk(PerkLib.ShootTheLoadAndHitTheRoad) < 0) maxLib -= (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.JobMonk) >= 0) maxWis += (15 * newGamePlusMod);
			if (findPerk(PerkLib.JobRanger) >= 0) maxSpe += (5 * newGamePlusMod);
			if (findPerk(PerkLib.JobRogue) >= 0) {
				maxStr += (5 * newGamePlusMod);
				maxSpe += (5 * newGamePlusMod);
			}
			if (findPerk(PerkLib.JobSeducer) >= 0) maxLib += (5 * newGamePlusMod);
			if (findPerk(PerkLib.JobSorcerer) >= 0) maxInt += (5 * newGamePlusMod);
			if (findPerk(PerkLib.JobSoulCultivator) >= 0) maxWis += (5 * newGamePlusMod);
			if (findPerk(PerkLib.JobSwordsman) >= 0) maxStr += (10 * newGamePlusMod);
			if (findPerk(PerkLib.JobWarlord) >= 0) maxTou += (20 * newGamePlusMod);
			if (findPerk(PerkLib.JobWarrior) >= 0) maxStr += (5 * newGamePlusMod);
			if (findPerk(PerkLib.PrestigeJobArcaneArcher) >= 0) {
				maxSpe += (40 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
			}
			if (findPerk(PerkLib.PrestigeJobBerserker) >= 0) {
				maxStr += (60 * newGamePlusMod);
				maxTou += (20 * newGamePlusMod);
			}
			if (findPerk(PerkLib.PrestigeJobGreySage) >= 0) {
				maxInt += (80 * newGamePlusMod);
			}
			if (findPerk(PerkLib.PrestigeJobSeer) >= 0) {
				maxInt += (60 * newGamePlusMod);
				maxWis += (20 * newGamePlusMod);
			}
			if (findPerk(PerkLib.PrestigeJobSentinel) >= 0) {
				maxStr += (20 * newGamePlusMod);
				maxTou += (60 * newGamePlusMod);
			}
			if (findPerk(PerkLib.PrestigeJobSoulArcher) >= 0) {
				maxSpe += (40 * newGamePlusMod);
				maxWis += (40 * newGamePlusMod);
			}
			if (findPerk(PerkLib.PrestigeJobSoulArtMaster) >= 0) {
				maxStr += (40 * newGamePlusMod);
				maxWis += (40 * newGamePlusMod);
			}
			if (findPerk(PerkLib.PrestigeJobSpellKnight) >= 0) {
				maxStr += (40 * newGamePlusMod);
				maxInt += (40 * newGamePlusMod);
			}
			if (findPerk(PerkLib.PrestigeJobTempest) >= 0) {
				maxStr += (40 * newGamePlusMod);
				maxSpe += (40 * newGamePlusMod);
			}
			if (findPerk(PerkLib.PrestigeJobWarlock) >= 0) {
				maxInt += (60 * newGamePlusMod);
				maxLib += (20 * newGamePlusMod);
			}
			if (findPerk(PerkLib.DeityJobMunchkin) >= 0) {
				maxStr += (25 * newGamePlusMod);
				maxTou += (25 * newGamePlusMod);
				maxSpe += (25 * newGamePlusMod);
				maxInt += (25 * newGamePlusMod);
				maxWis += (25 * newGamePlusMod);
				maxLib += (15 * newGamePlusMod);
				maxSen += (15 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.Lycanthropy)) {
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 3 || flags[kFLAGS.LUNA_MOON_CYCLE] == 5) {
					maxStr += (10 * newGamePlusMod);
					maxTou += (10 * newGamePlusMod);
					maxSpe += (10 * newGamePlusMod);
				}
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 2 || flags[kFLAGS.LUNA_MOON_CYCLE] == 6) {
					maxStr += (20 * newGamePlusMod);
					maxTou += (20 * newGamePlusMod);
					maxSpe += (20 * newGamePlusMod);
				}
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 1 || flags[kFLAGS.LUNA_MOON_CYCLE] == 7) {
					maxStr += (30 * newGamePlusMod);
					maxTou += (30 * newGamePlusMod);
					maxSpe += (30 * newGamePlusMod);
				}
				if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) {
					maxStr += (40 * newGamePlusMod);
					maxTou += (40 * newGamePlusMod);
					maxSpe += (40 * newGamePlusMod);
				}
			}
			if (findPerk(PerkLib.CarefulButRecklessAimAndShooting) >= 0 && findPerk(PerkLib.ColdAim) < 0) maxTou -= (15 * newGamePlusMod);
			if (findPerk(PerkLib.WeaponMastery) >= 0) maxStr += (5 * newGamePlusMod);
			if (findPerk(PerkLib.WeaponGrandMastery) >= 0) maxStr += (10 * newGamePlusMod);
			if (findPerk(PerkLib.ElementalConjurerResolve) >= 0) {
				if (findPerk(PerkLib.ElementalConjurerMindAndBodyResolve) < 0) {
					maxStr -= (15 * newGamePlusMod);
					maxTou -= (15 * newGamePlusMod);
					maxSpe -= (15 * newGamePlusMod);
				}
				maxInt += (20 * newGamePlusMod);
				maxWis += (30 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ElementalConjurerDedication) >= 0) {
				if (findPerk(PerkLib.ElementalConjurerMindAndBodyDedication) < 0) {
					maxStr -= (30 * newGamePlusMod);
					maxTou -= (30 * newGamePlusMod);
					maxSpe -= (30 * newGamePlusMod);
				}
				maxInt += (40 * newGamePlusMod);
				maxWis += (60 * newGamePlusMod);
			}
			if (findPerk(PerkLib.ElementalConjurerSacrifice) >= 0) {
				if (findPerk(PerkLib.ElementalConjurerMindAndBodySacrifice) < 0) {
					maxStr -= (45 * newGamePlusMod);
					maxTou -= (45 * newGamePlusMod);
					maxSpe -= (45 * newGamePlusMod);
				}
				maxInt += (60 * newGamePlusMod);
				maxWis += (90 * newGamePlusMod);
			}
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				maxSen += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) {
				maxStr += (15 * newGamePlusMod);
				maxTou += (15 * newGamePlusMod);
				maxSpe += (15 * newGamePlusMod);
				maxInt += (15 * newGamePlusMod);
				maxWis += (15 * newGamePlusMod);
				maxLib += (15 * newGamePlusMod);
				maxSen += (15 * newGamePlusMod);
			}
			if (findPerk(PerkLib.FclassHeavenTribulationSurvivor) >= 0) {
				maxStr += (20 * newGamePlusMod);
				maxTou += (20 * newGamePlusMod);
				maxSpe += (20 * newGamePlusMod);
				maxInt += (20 * newGamePlusMod);
				maxWis += (20 * newGamePlusMod);
				maxLib += (20 * newGamePlusMod);
				maxSen += (20 * newGamePlusMod);
			}
			if (findPerk(PerkLib.EpicStrength) >= 0) maxStr += (35 + (5 * newGamePlusMod));
			if (findPerk(PerkLib.LegendaryStrength) >= 0) maxStr += (50 + (10 * newGamePlusMod));
			if (findPerk(PerkLib.MythicalStrength) >= 0) maxStr += (65 + (15 * newGamePlusMod));
			if (findPerk(PerkLib.EpicToughness) >= 0) maxTou += (35 + (5 * newGamePlusMod));
			if (findPerk(PerkLib.LegendaryToughness) >= 0) maxTou += (50 + (10 * newGamePlusMod));
			if (findPerk(PerkLib.MythicalToughness) >= 0) maxTou += (65 + (15 * newGamePlusMod));
			if (findPerk(PerkLib.EpicSpeed) >= 0) maxSpe += (35 + (5 * newGamePlusMod));
			if (findPerk(PerkLib.LegendarySpeed) >= 0) maxSpe += (50 + (10 * newGamePlusMod));
			if (findPerk(PerkLib.MythicalSpeed) >= 0) maxSpe += (65 + (15 * newGamePlusMod));
			if (findPerk(PerkLib.EpicIntelligence) >= 0) maxInt += (35 + (5 * newGamePlusMod));
			if (findPerk(PerkLib.LegendaryIntelligence) >= 0) maxInt += (50 + (10 * newGamePlusMod));
			if (findPerk(PerkLib.MythicalIntelligence) >= 0) maxInt += (65 + (15 * newGamePlusMod));
			if (findPerk(PerkLib.EpicWisdom) >= 0) maxWis += (35 + (5 * newGamePlusMod));
			if (findPerk(PerkLib.LegendaryWisdom) >= 0) maxWis += (50 + (10 * newGamePlusMod));
			if (findPerk(PerkLib.MythicalWisdom) >= 0) maxWis += (65 + (15 * newGamePlusMod));
			if (findPerk(PerkLib.EpicLibido) >= 0) maxLib += (35 + (5 * newGamePlusMod));
			if (findPerk(PerkLib.LegendaryLibido) >= 0) maxLib += (50 + (10 * newGamePlusMod));
			if (findPerk(PerkLib.MythicalLibido) >= 0) maxLib += (65 + (15 * newGamePlusMod));
			if (findPerk(PerkLib.EpicSensitivity) >= 0) maxSen += (35 + (5 * newGamePlusMod));
			if (findPerk(PerkLib.LegendarySensitivity) >= 0) maxSen += (50 + (10 * newGamePlusMod));
			if (findPerk(PerkLib.MythicalSensitivity) >= 0) maxSen += (65 + (15 * newGamePlusMod));
			if (findPerk(PerkLib.IronStomachSu) >= 0) maxTou += (5 * newGamePlusMod);
			if (findPerk(PerkLib.SoulApprentice) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulPersonage) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulWarrior) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulSprite) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulScholar) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulElder) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulExalt) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulOverlord) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulTyrant) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulKing) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulEmperor) >= 0) maxWis += 5;
			if (findPerk(PerkLib.SoulAncestor) >= 0) maxWis += 5;
			if (findPerk(PerkLib.GigantGrip) >= 0) maxStr += 5;
			if (findPerk(PerkLib.GigantGripEx) >= 0) {
				maxStr += 5;
				maxTou += 5;
			}
			if (findPerk(PerkLib.GigantGripSu) >= 0) {
				maxStr += 5;
				maxTou += 5;
				maxSpe += 5;
			}
			if (findPerk(PerkLib.TitanGrip) >= 0) maxStr += 5;
			if (findPerk(PerkLib.TitanGripEx) >= 0) {
				maxStr += 5;
				maxTou += 5;
			}
			if (findPerk(PerkLib.TitanGripSu) >= 0) {
				maxStr += 5;
				maxTou += 5;
				maxSpe += 5;
			}
			if (findPerk(PerkLib.EpicGolemMaker) >= 0) {
				maxInt += 10;
				maxWis += 10;
			}
			if (findPerk(PerkLib.EpicGolemMaker2ndCircle) >= 0) {
				maxInt += 20;
				maxWis += 20;
			}
			if (findPerk(PerkLib.EpicGolemMaker3rdCircle) >= 0) {
				maxInt += 30;
				maxWis += 30;
			}
			if (findPerk(PerkLib.LimitBreakerFlesh1stStage) >= 0) {
				maxStr += (10 * newGamePlusMod);
				maxTou += (10 * newGamePlusMod);
				maxSpe += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.LimitBreakerFlesh2ndStage) >= 0) {
				maxInt += (10 * newGamePlusMod);
				maxWis += (10 * newGamePlusMod);
				maxLib += (10 * newGamePlusMod);
				maxSen += (10 * newGamePlusMod);
			}
			if (findPerk(PerkLib.LimitBreakerPsyche1stStage) >= 0) {
				maxStr += (20 * newGamePlusMod);
				maxTou += (20 * newGamePlusMod);
				maxSpe += (20 * newGamePlusMod);
			}
			if (findPerk(PerkLib.LimitBreakerPsyche2ndStage) >= 0) {
				maxInt += (20 * newGamePlusMod);
				maxWis += (20 * newGamePlusMod);
				maxLib += (20 * newGamePlusMod);
				maxSen += (20 * newGamePlusMod);
			}
			if (hasPerk(PerkLib.ProductivityDrugs)) maxLib += perkv1(PerkLib.ProductivityDrugs);
			if (hasPerk(PerkLib.TitanicStrength)) maxStr += Math.round(maxStr * 0.01 * Math.round(tallness / 3) * newGamePlusMod);
			if (hasPerk(PerkLib.IcyFlesh)) maxTou = 1;
			End("Player","getAllMaxStats.perks2");
			Begin("Player","getAllMaxStats.effects");
			//Apply New Game+
			maxStr += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxTou += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxSpe += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxInt += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxWis += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxLib += 5 * perkv1(PerkLib.AscensionTranshumanism);
			maxSen += 5 * perkv1(PerkLib.AscensionTranshumanism);
			//Might
			if (hasStatusEffect(StatusEffects.Might)) {
				if (hasStatusEffect(StatusEffects.FortressOfIntellect)) maxInt += statusEffectv1(StatusEffects.Might);
				else maxStr += statusEffectv1(StatusEffects.Might);
				maxTou += statusEffectv2(StatusEffects.Might);
			}
			//Blink
			if (hasStatusEffect(StatusEffects.Blink)) {
				maxSpe += statusEffectv1(StatusEffects.Blink);
			}
			//Dwarf Rage
			if (hasStatusEffect(StatusEffects.WarriorsRage)) {
				maxStr += statusEffectv1(StatusEffects.WarriorsRage);
				maxTou += statusEffectv2(StatusEffects.WarriorsRage);
				maxSpe += statusEffectv2(StatusEffects.WarriorsRage);
			}
			//Drunken Power
			if (hasStatusEffect(StatusEffects.DrunkenPower)) {
				maxStr += statusEffectv2(StatusEffects.DrunkenPower);
				maxSpe -= statusEffectv3(StatusEffects.DrunkenPower);
				maxInt -= statusEffectv3(StatusEffects.DrunkenPower);
				maxLib += statusEffectv2(StatusEffects.DrunkenPower);
			}
			//Trance Transformation
			if (hasStatusEffect(StatusEffects.TranceTransformation)) {
				maxStr += statusEffectv1(StatusEffects.TranceTransformation);
				maxTou += statusEffectv1(StatusEffects.TranceTransformation);
			}
			//Crinos Shape
			if (hasStatusEffect(StatusEffects.CrinosShape)) {
				maxStr += statusEffectv1(StatusEffects.CrinosShape);
				maxTou += statusEffectv2(StatusEffects.CrinosShape);
				maxSpe += statusEffectv3(StatusEffects.CrinosShape);
			}
			//
			if (hasStatusEffect(StatusEffects.ShiraOfTheEastFoodBuff2)) {
				if (statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff2) >= 1) maxStr += statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff2);
				maxTou += statusEffectv4(StatusEffects.ShiraOfTheEastFoodBuff2);
				if (statusEffectv2(StatusEffects.ShiraOfTheEastFoodBuff2) >= 1) maxSpe += statusEffectv2(StatusEffects.ShiraOfTheEastFoodBuff2);
				if (statusEffectv3(StatusEffects.ShiraOfTheEastFoodBuff2) >= 1) maxInt += statusEffectv3(StatusEffects.ShiraOfTheEastFoodBuff2);
			}
			//Beat of War
			if (hasStatusEffect(StatusEffects.BeatOfWar)) {
				maxStr += statusEffectv1(StatusEffects.BeatOfWar);
			}
			if (hasStatusEffect(StatusEffects.AndysSmoke)) {
				maxSpe -= statusEffectv2(StatusEffects.AndysSmoke);
				maxInt += statusEffectv3(StatusEffects.AndysSmoke);
			}
			if (hasStatusEffect(StatusEffects.FeedingEuphoria)) {
				maxSpe += statusEffectv2(StatusEffects.FeedingEuphoria);
			}
			if (hasStatusEffect(StatusEffects.BlessingOfDivineFenrir)) {
				maxStr += statusEffectv2(StatusEffects.BlessingOfDivineFenrir);
				maxTou += statusEffectv3(StatusEffects.BlessingOfDivineFenrir);
			}
			if (hasStatusEffect(StatusEffects.BlessingOfDivineTaoth)) {
				maxSpe += statusEffectv2(StatusEffects.BlessingOfDivineTaoth);
			}
			var vthirst:VampireThirstEffect = statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
			if (vthirst != null) {
				maxStr += vthirst.currentBoost;
				maxSpe += vthirst.currentBoost;
				maxInt += vthirst.currentBoost;
				maxLib += vthirst.currentBoost;
			}
			if (hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
				maxStr += statusEffectv1(StatusEffects.UnderwaterCombatBoost);
				maxSpe += statusEffectv2(StatusEffects.UnderwaterCombatBoost);
			}
			if (hasStatusEffect(StatusEffects.PlayerPhylactery)) maxInt += (75 * newGamePlusMod);
			if (hasStatusEffect(StatusEffects.EnergyDependent)) {
				maxSpe += statusEffectv1(StatusEffects.EnergyDependent);
				maxInt += statusEffectv2(StatusEffects.EnergyDependent);
			}
			//Equipment
			if (this.jewelryName == "Ring of Intelligence") maxInt += 5;
			if (this.jewelryName2 == "Ring of Intelligence") maxInt += 5;
			if (this.jewelryName3 == "Ring of Intelligence") maxInt += 5;
			if (this.jewelryName4 == "Ring of Intelligence") maxInt += 5;
			if (this.jewelryName == "Ring of Libido") maxLib += 5;
			if (this.jewelryName2 == "Ring of Libido") maxLib += 5;
			if (this.jewelryName3 == "Ring of Libido") maxLib += 5;
			if (this.jewelryName4 == "Ring of Libido") maxLib += 5;
			if (this.jewelryName == "Ring of Sensitivity") maxSen += 5;
			if (this.jewelryName2 == "Ring of Sensitivity") maxSen += 5;
			if (this.jewelryName3 == "Ring of Sensitivity") maxSen += 5;
			if (this.jewelryName4 == "Ring of Sensitivity") maxSen += 5;
			if (this.jewelryName == "Ring of Speed") maxSpe += 5;
			if (this.jewelryName2 == "Ring of Speed") maxSpe += 5;
			if (this.jewelryName3 == "Ring of Speed") maxSpe += 5;
			if (this.jewelryName4 == "Ring of Speed") maxSpe += 5;
			if (this.jewelryName == "Ring of Strength") maxStr += 5;
			if (this.jewelryName2 == "Ring of Strength") maxStr += 5;
			if (this.jewelryName3 == "Ring of Strength") maxStr += 5;
			if (this.jewelryName4 == "Ring of Strength") maxStr += 5;
			if (this.jewelryName == "Ring of Toughness") maxTou += 5;
			if (this.jewelryName2 == "Ring of Toughness") maxTou += 5;
			if (this.jewelryName3 == "Ring of Toughness") maxTou += 5;
			if (this.jewelryName4 == "Ring of Toughness") maxTou += 5;
			if (this.jewelryName == "Ring of Wisdom") maxWis += 5;
			if (this.jewelryName2 == "Ring of Wisdom") maxWis += 5;
			if (this.jewelryName3 == "Ring of Wisdom") maxWis += 5;
			if (this.jewelryName4 == "Ring of Wisdom") maxWis += 5;
			if (this.headjewelryName == "Crown of Intelligence") maxInt += 20;
			if (this.headjewelryName == "Crown of Libido") maxLib += 20;
			if (this.headjewelryName == "Crown of Sensitivity") maxSen += 20;
			if (this.headjewelryName == "Crown of Speed") maxSpe += 20;
			if (this.headjewelryName == "Crown of Strength") maxStr += 20;
			if (this.headjewelryName == "Crown of Toughness") maxTou += 20;
			if (this.headjewelryName == "Crown of Wisdom") maxWis += 20;
			if (this.necklaceName == "Necklace of Intelligence") maxInt += 25;
			if (this.necklaceName == "Necklace of Libido") maxLib += 25;
			if (this.necklaceName == "Necklace of Sensitivity") maxSen += 25;
			if (this.necklaceName == "Necklace of Speed") maxSpe += 25;
			if (this.necklaceName == "Necklace of Strength") maxStr += 25;
			if (this.necklaceName == "Necklace of Toughness") maxTou += 25;
			if (this.necklaceName == "Necklace of Wisdom") maxWis += 25;
			if (this.jewelryName == "Ring of Intelligence" && this.jewelryName2 == "Ring of Intelligence" && this.jewelryName3 == "Ring of Intelligence" && this.jewelryName4 == "Ring of Intelligence" && this.headjewelryName == "Crown of Intelligence" && this.necklaceName == "Necklace of Intelligence") maxInt += 15;
			if (this.jewelryName == "Ring of Libido" && this.jewelryName2 == "Ring of Libido" && this.jewelryName3 == "Ring of Libido" && this.jewelryName4 == "Ring of Libido" && this.headjewelryName == "Crown of Libido" && this.necklaceName == "Necklace of Libido") maxLib += 15;
			if (this.jewelryName == "Ring of Sensitivity" && this.jewelryName2 == "Ring of Sensitivity" && this.jewelryName3 == "Ring of Sensitivity" && this.jewelryName4 == "Ring of Sensitivity" && this.headjewelryName == "Crown of Sensitivity" && this.necklaceName == "Necklace of Sensitivity") maxSen += 15;
			if (this.jewelryName == "Ring of Speed" && this.jewelryName2 == "Ring of Speed" && this.jewelryName3 == "Ring of Speed" && this.jewelryName4 == "Ring of Speed" && this.headjewelryName == "Crown of Speed" && this.necklaceName == "Necklace of Speed") maxSpe += 15;
			if (this.jewelryName == "Ring of Strength" && this.jewelryName2 == "Ring of Strength" && this.jewelryName3 == "Ring of Strength" && this.jewelryName4 == "Ring of Strength" && this.headjewelryName == "Crown of Strength" && this.necklaceName == "Necklace of Strength") maxStr += 15;
			if (this.jewelryName == "Ring of Toughness" && this.jewelryName2 == "Ring of Toughness" && this.jewelryName3 == "Ring of Toughness" && this.jewelryName4 == "Ring of Toughness" && this.headjewelryName == "Crown of Toughness" && this.necklaceName == "Necklace of Toughness") maxTou += 15;
			if (this.jewelryName == "Ring of Wisdom" && this.jewelryName2 == "Ring of Wisdom" && this.jewelryName3 == "Ring of Wisdom" && this.jewelryName4 == "Ring of Wisdom" && this.headjewelryName == "Crown of Wisdom" && this.necklaceName == "Necklace of Wisdom") maxWis += 15;
			//Key Items
			if (hasPerk(PerkLib.GoblinoidBlood)) {
				if (hasKeyItem("Drug injectors") >= 0) {
					maxLib += 25;
					maxSen += 5;
				}
				if (hasKeyItem("Improved Drug injectors") >= 0) {
					maxLib += 50;
					maxSen += 10;
				}
				if (hasKeyItem("Potent Drug injectors") >= 0) {
					maxLib += 75;
					maxSen += 15;
				}
				if (hasKeyItem("Power bracer") >= 0) {
					maxStr += 50;
					maxSen += 5;
				}
				if (hasKeyItem("Powboy") >= 0) {
					maxStr += 75;
					maxSen += 10;
				}
				if (hasKeyItem("M.G.S. bracer") >= 0) {
					maxStr += 100;
					maxSen += 15;
				}
			}
			End("Player","getAllMaxStats.effects");
			End("Player","getAllMaxStats");
			maxStr = Math.max(maxStr,1);
			maxTou = Math.max(maxTou,1);
			maxSpe = Math.max(maxSpe,1);
			maxInt = Math.max(maxInt,1);
			maxWis = Math.max(maxWis,1);
			maxLib = Math.max(maxLib,1);
			maxSen = Math.max(maxSen,1);
			maxCor = Math.max(maxCor,1);
			return {
				str:maxStr,
				tou:maxTou,
				spe:maxSpe,
				inte:maxInt,
				wis:maxWis,
				lib:maxLib,
				sens:maxSen,
				cor:maxCor
			};
		}
		
		public function requiredXP():int {
			var xpm:Number = 100;
			if (level >= 42) xpm += 100;
			if (level >= 102) xpm += 100;
			if (level >= 180) xpm += 100;
			//if (level >= 274) 
			var temp:int = (level + 1) * xpm;
			if (temp > 74000) temp = 74000;//(max lvl)185 * 400(exp multi)
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
			if (hasStatusEffect(StatusEffects.DriderIncubusVenom))
			{
				str += statusEffectv2(StatusEffects.DriderIncubusVenom);
				removeStatusEffect(StatusEffects.DriderIncubusVenom);
				CoC.instance.mainView.statsView.showStatUp('str');
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.Sandstorm)) CoC.instance.monster.removeStatusEffect(StatusEffects.Sandstorm);
			if(hasStatusEffect(StatusEffects.WarriorsRage)) {
				dynStats("str", -statusEffectv1(StatusEffects.WarriorsRage),"tou", -statusEffectv2(StatusEffects.WarriorsRage),"spe", -statusEffectv2(StatusEffects.WarriorsRage), "scale", false);
				removeStatusEffect(StatusEffects.WarriorsRage);
			}
			if(hasStatusEffect(StatusEffects.Berzerking)) {
				removeStatusEffect(StatusEffects.Berzerking);
			}
			if(hasStatusEffect(StatusEffects.Lustzerking)) {
				removeStatusEffect(StatusEffects.Lustzerking);
			}
			if(hasStatusEffect(StatusEffects.EverywhereAndNowhere)) {
				removeStatusEffect(StatusEffects.EverywhereAndNowhere);
			}
			if(hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
				removeStatusEffect(StatusEffects.BlazingBattleSpirit);
			}
			if(hasStatusEffect(StatusEffects.Cauterize)) {
				removeStatusEffect(StatusEffects.Cauterize);
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.TailWhip)) {
				CoC.instance.monster.removeStatusEffect(StatusEffects.TailWhip);
			}
			if(CoC.instance.monster.hasStatusEffect(StatusEffects.TwuWuv)) {
				inte += CoC.instance.monster.statusEffectv1(StatusEffects.TwuWuv);
				EngineCore.statScreenRefresh();
				CoC.instance.mainView.statsView.showStatUp( 'inte' );
			}
			if(hasStatusEffect(StatusEffects.NagaVenom)) {
				spe += statusEffectv1(StatusEffects.NagaVenom);
				CoC.instance.mainView.statsView.showStatUp( 'spe' );
				removeStatusEffect(StatusEffects.NagaVenom);
			}
			if(hasStatusEffect(StatusEffects.MedusaVenom)) {
				str += statusEffectv1(StatusEffects.MedusaVenom);
				tou += statusEffectv2(StatusEffects.MedusaVenom);
				spe += statusEffectv3(StatusEffects.MedusaVenom);
				inte += statusEffectv4(StatusEffects.MedusaVenom);
				CoC.instance.mainView.statsView.showStatUp( 'str' );
				CoC.instance.mainView.statsView.showStatUp( 'tou' );
				CoC.instance.mainView.statsView.showStatUp( 'spe' );
				CoC.instance.mainView.statsView.showStatUp( 'inte' );
				removeStatusEffect(StatusEffects.MedusaVenom);
			}
			if(hasStatusEffect(StatusEffects.Frostbite)) {
				str += statusEffectv1(StatusEffects.Frostbite);
				CoC.instance.mainView.statsView.showStatUp( 'str' );
				removeStatusEffect(StatusEffects.Frostbite);
			}
			if(hasStatusEffect(StatusEffects.Flying)) {
				removeStatusEffect(StatusEffects.Flying);
				if(hasStatusEffect(StatusEffects.FlyingNoStun)) {
					removeStatusEffect(StatusEffects.FlyingNoStun);
					removePerk(PerkLib.Resolute);
				}
			}
			if(hasStatusEffect(StatusEffects.Might)) {
				if (hasStatusEffect(StatusEffects.FortressOfIntellect)) dynStats("int", -statusEffectv1(StatusEffects.Might), "scale", false);
				else dynStats("str", -statusEffectv1(StatusEffects.Might), "scale", false);
				dynStats("tou", -statusEffectv2(StatusEffects.Might), "scale", false);
				removeStatusEffect(StatusEffects.Might);
			}
			if(hasStatusEffect(StatusEffects.Blink)) {
				dynStats("spe", -statusEffectv1(StatusEffects.Blink), "scale", false);
				removeStatusEffect(StatusEffects.Blink);
			}
			if(hasStatusEffect(StatusEffects.BeatOfWar)) {
				dynStats("str", -statusEffectv1(StatusEffects.BeatOfWar), "scale", false);
				removeStatusEffect(StatusEffects.BeatOfWar);
			}
			if(hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
				dynStats("str", -statusEffectv1(StatusEffects.UnderwaterCombatBoost),"spe", -statusEffectv2(StatusEffects.UnderwaterCombatBoost), "scale", false);
				removeStatusEffect(StatusEffects.UnderwaterCombatBoost);
			}
			if(hasStatusEffect(StatusEffects.TranceTransformation)) {
				dynStats("str", -statusEffectv1(StatusEffects.TranceTransformation), "scale", false);
				dynStats("tou", -statusEffectv1(StatusEffects.TranceTransformation), "scale", false);
				removeStatusEffect(StatusEffects.TranceTransformation);
			}
			if(hasStatusEffect(StatusEffects.CrinosShape)) {
				dynStats("str", -statusEffectv1(StatusEffects.CrinosShape), "scale", false);
				dynStats("tou", -statusEffectv2(StatusEffects.CrinosShape), "scale", false);
				dynStats("spe", -statusEffectv3(StatusEffects.CrinosShape), "scale", false);
				removeStatusEffect(StatusEffects.CrinosShape);
			}
			if(hasStatusEffect(StatusEffects.EzekielCurse) && flags[kFLAGS.EVANGELINE_AFFECTION] >= 3 && findPerk(PerkLib.EzekielBlessing) >= 0) {
				removeStatusEffect(StatusEffects.EzekielCurse);
			}
			if(hasStatusEffect(StatusEffects.DragonBreathCooldown) && findPerk(PerkLib.DraconicLungsFinalForm) >= 0) {
				removeStatusEffect(StatusEffects.DragonBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonDarknessBreathCooldown) && findPerk(PerkLib.DraconicLungs) >= 0) {
				removeStatusEffect(StatusEffects.DragonDarknessBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonFireBreathCooldown) && findPerk(PerkLib.DraconicLungs) >= 0) {
				removeStatusEffect(StatusEffects.DragonFireBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonIceBreathCooldown) && findPerk(PerkLib.DraconicLungs) >= 0) {
				removeStatusEffect(StatusEffects.DragonIceBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.DragonLightningBreathCooldown) && findPerk(PerkLib.DraconicLungs) >= 0) {
				removeStatusEffect(StatusEffects.DragonLightningBreathCooldown);
			}
			if(hasStatusEffect(StatusEffects.HeroBane)) {
				removeStatusEffect(StatusEffects.HeroBane);
			}
			if(hasStatusEffect(StatusEffects.PlayerRegenerate)) {
				removeStatusEffect(StatusEffects.PlayerRegenerate);
			}
			if(hasStatusEffect(StatusEffects.Disarmed)) {
				removeStatusEffect(StatusEffects.Disarmed);
				if (weapon == WeaponLib.FISTS) {
//					weapon = ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon;
//					(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon).doEffect(this, false);
					setWeapon(ItemType.lookupItem(flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID]) as Weapon);
				}
				else {
					flags[kFLAGS.BONUS_ITEM_AFTER_COMBAT_ID] = flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID];
				}
			}
			if (hasStatusEffect(StatusEffects.DriderIncubusVenom))
			{
				str += statusEffectv2(StatusEffects.DriderIncubusVenom);
				removeStatusEffect(StatusEffects.DriderIncubusVenom);
			}
			if(statusEffectv4(StatusEffects.CombatFollowerAlvina) > 0) addStatusValue(StatusEffects.CombatFollowerAlvina, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerAmily) > 0) addStatusValue(StatusEffects.CombatFollowerAmily, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerAurora) > 0) addStatusValue(StatusEffects.CombatFollowerAurora, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerAyane) > 0) addStatusValue(StatusEffects.CombatFollowerAyane, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerEtna) > 0) addStatusValue(StatusEffects.CombatFollowerEtna, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerExcellia) > 0) addStatusValue(StatusEffects.CombatFollowerExcellia, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerDiana) > 0) addStatusValue(StatusEffects.CombatFollowerDiana, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerDiva) > 0) addStatusValue(StatusEffects.CombatFollowerDiva, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerMitzi) > 0) addStatusValue(StatusEffects.CombatFollowerMitzi, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerNeisa) > 0) addStatusValue(StatusEffects.CombatFollowerNeisa, 4, -1);
			if(statusEffectv4(StatusEffects.CombatFollowerSiegweird) > 0) addStatusValue(StatusEffects.CombatFollowerSiegweird, 4, -1);
			
			// All CombatStatusEffects are removed here
			for (var a:/*StatusEffectClass*/Array=statusEffects.slice(),n:int=a.length,i:int=0;i<n;i++) {
				// Using a copy of array in case effects are removed/added in handler
				if (statusEffects.indexOf(a[i])>=0) a[i].onCombatEnd();
			}
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
				if(cocks.length == 1) outputText("Your [cock] has grown slightly longer.");
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("One of your [cocks] grows slightly longer.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("Some of your [cocks] grow slightly longer.");
					if(ncocks == cocks.length) outputText("Your [cocks] seem to fill up... growing a little bit larger.");
				}
			}
			if(temp2 > 1 && temp2 < 3) {
				if(cocks.length == 1) outputText("A very pleasurable feeling spreads from your groin as your [cock] grows permanently longer - at least an inch - and leaks pre-cum from the pleasure of the change.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A very pleasurable feeling spreads from your groin as your [cocks] grow permanently longer - at least an inch - and leak plenty of pre-cum from the pleasure of the change.");
					if(ncocks == 1) outputText("A very pleasurable feeling spreads from your groin as one of your [cocks] grows permanently longer, by at least an inch, and leaks plenty of pre-cum from the pleasure of the change.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("A very pleasurable feeling spreads from your groin as " + num2Text(ncocks) + " of your [cocks] grow permanently longer, by at least an inch, and leak plenty of pre-cum from the pleasure of the change.");
				}
			}
			if(temp2 >=3){
				if(cocks.length == 1) outputText("Your [cock] feels incredibly tight as a few more inches of length seem to pour out from your crotch.");
				if(cocks.length > 1) {
					if(ncocks == 1) outputText("Your [cocks] feel incredibly tight as one of their number begins to grow inch after inch of length.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("Your [cocks] feel incredibly number as " + num2Text(ncocks) + " of them begin to grow inch after inch of added length.");
					if(ncocks == cocks.length) outputText("Your [cocks] feel incredibly tight as inch after inch of length pour out from your groin.");
				}
			}
			//Display LengthChange
			if(temp2 > 0) {
				if(cocks[0].cockLength >= 8 && cocks[0].cockLength-temp2 < 8){
					if(cocks.length == 1) outputText("  <b>Most men would be overly proud to have a tool as long as yours.</b>");
					if(cocks.length > 1) outputText("  <b>Most men would be overly proud to have one cock as long as yours, let alone " + multiCockDescript() + ".</b>");
				}
				if(cocks[0].cockLength >= 12 && cocks[0].cockLength-temp2 < 12) {
					if(cocks.length == 1) outputText("  <b>Your [cock] is so long it nearly swings to your knee at its full length.</b>");
					if(cocks.length > 1) outputText("  <b>Your [cocks] are so long they nearly reach your knees when at full length.</b>");
				}
				if(cocks[0].cockLength >= 16 && cocks[0].cockLength-temp2 < 16) {
					if(cocks.length == 1) outputText("  <b>Your [cock] would look more at home on a large horse than you.</b>");
					if(cocks.length > 1) outputText("  <b>Your [cocks] would look more at home on a large horse than on your body.</b>");
					if (biggestTitSize() >= BreastCup.C) {
						if (cocks.length == 1) outputText("  You could easily stuff your [cock] between your breasts and give yourself the titty-fuck of a lifetime.");
						if (cocks.length > 1) outputText("  They reach so far up your chest it would be easy to stuff a few cocks between your breasts and give yourself the titty-fuck of a lifetime.");
					}
					else {
						if(cocks.length == 1) outputText("  Your [cock] is so long it easily reaches your chest.  The possibility of autofellatio is now a foregone conclusion.");
						if(cocks.length > 1) outputText("  Your [cocks] are so long they easily reach your chest.  Autofellatio would be about as hard as looking down.");
					}
				}
				if(cocks[0].cockLength >= 20 && cocks[0].cockLength-temp2 < 20) {
					if(cocks.length == 1) outputText("  <b>As if the pulsing heat of your [cock] wasn't enough, the tip of your [cock] keeps poking its way into your view every time you get hard.</b>");
					if(cocks.length > 1) outputText("  <b>As if the pulsing heat of your [cocks] wasn't bad enough, every time you get hard, the tips of your [cocks] wave before you, obscuring the lower portions of your vision.</b>");
					if(cor > 40 && cor <= 60) {
						if(cocks.length > 1) outputText("  You wonder if there is a demon or beast out there that could take the full length of one of your [cocks]?");
						if(cocks.length ==1) outputText("  You wonder if there is a demon or beast out there that could handle your full length.");
					}
					if(cor > 60 && cor <= 80) {
						if(cocks.length > 1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [cocks] to their hilts, milking you dry.\n\nYou smile at the pleasant thought.");
						if(cocks.length ==1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your [cock] to the hilt, milking it of all your cum.\n\nYou smile at the pleasant thought.");
					}
					if(cor > 80) {
						if(cocks.length > 1) outputText("  You find yourself fantasizing about impaling nubile young champions on your [cocks] in a year's time.");
					}
				}
			}
			//Display the degree of length loss.
			if(temp2 < 0 && temp2 >= -1) {
				if(cocks.length == 1) outputText("Your [cocks] has shrunk to a slightly shorter length.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your [cocks] have shrunk to a slightly shorter length.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your [cocks] have shrunk to a slightly shorter length.");
					if(ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your [cocks] has shrunk to a slightly shorter length.");
				}
			}
			if(temp2 < -1 && temp2 > -3) {
				if(cocks.length == 1) outputText("Your [cocks] shrinks smaller, flesh vanishing into your groin.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("Your [cocks] shrink smaller, the flesh vanishing into your groin.");
					if(ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your [cocks] shrink smaller, the flesh vanishing into your groin.");
					if(ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your [cocks] shrink smaller, the flesh vanishing into your groin.");
				}
			}
			if(temp2 <= -3) {
				if(cocks.length == 1) outputText("A large portion of your [cocks]'s length shrinks and vanishes.");
				if(cocks.length > 1) {
					if(ncocks == cocks.length) outputText("A large portion of your [cocks] recedes towards your groin, receding rapidly in length.");
					if(ncocks == 1) outputText("A single member of your [cocks] vanishes into your groin, receding rapidly in length.");
					if(ncocks > 1 && cocks.length > ncocks) outputText("Your [cocks] tingles as " + num2Text(ncocks) + " of your members vanish into your groin, receding rapidly in length.");
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
					outputText("<b>Your manhood shrinks into your body, disappearing completely.</b>");
					if (hasStatusEffect(StatusEffects.Infested)) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.");
				}
				if (cocks.length == 1) {
					outputText("<b>Your smallest penis disappears, shrinking into your body and leaving you with just one [cock].</b>");
				}
				if (cocks.length > 1) {
					outputText("<b>Your smallest penis disappears forever, leaving you with just your [cocks].</b>");
				}
			}
			if (removed > 1) {
				if (cocks.length == 0) {
					outputText("<b>All your male endowments shrink smaller and smaller, disappearing one at a time.</b>");
					if (hasStatusEffect(StatusEffects.Infested)) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.");
				}
				if (cocks.length == 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with just your [cock].");
				}
				if (cocks.length > 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with [cocks].");
				}
			}
			//remove infestation if cockless
			if (cocks.length == 0) removeStatusEffect(StatusEffects.Infested);
			if (cocks.length == 0 && balls > 0) {
				outputText("  <b>Your " + sackDescript() + " and [balls] shrink and disappear, vanishing into your groin.</b>");
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
					delta *= 2
				}
			}
			else if (delta < 0) {
				trace("and decreasing");
				if (findPerk(PerkLib.MessyOrgasms) >= 0) {
					trace("and MessyOrgasms found");
					delta *= 1
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
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Despite already being in heat, the desire to copulate constantly grows even larger.");
				}
				var sac:StatusEffectClass = statusEffectByType(StatusEffects.Heat);
				sac.value1 += 5 * intensity;
				sac.value2 += 5 * intensity;
				sac.value3 += 48 * intensity;
				dynStats("lib", 5 * intensity, "scale", false);
			}
			//Go into heat.  Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
			else {
				if(output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Your hands begin stroking your body from top to bottom, your sensitive skin burning with desire.  Fantasies about bending over and presenting your needy pussy to a male overwhelm you as <b>you realize you have gone into heat!</b>");
				}
				createStatusEffect(StatusEffects.Heat, 10 * intensity, 15 * intensity, 48 * intensity, 0);
				dynStats("lib", 15 * intensity, "scale", false);
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
					outputText("\n\nYour [cock] throbs and dribbles as your desire to mate intensifies.  You know that <b>you've sunken deeper into rut</b>, but all that really matters is unloading into a cum-hungry cunt.");
				}
				
				addStatusValue(StatusEffects.Rut, 1, 100 * intensity);
				addStatusValue(StatusEffects.Rut, 2, 5 * intensity);
				addStatusValue(StatusEffects.Rut, 3, 48 * intensity);
				dynStats("lib", 5 * intensity, "scale", false);
			}
			else {
				if(output) {
					outputText("\n\nYou stand up a bit straighter and look around, sniffing the air and searching for a mate.  Wait, what!?  It's hard to shake the thought from your head - you really could use a nice fertile hole to impregnate.  You slap your forehead and realize <b>you've gone into rut</b>!");
				}
				
				//v1 - bonus cum production
				//v2 - bonus libido
				//v3 - time remaining!
				createStatusEffect(StatusEffects.Rut, 150 * intensity, 5 * intensity, 100 * intensity, 0);
				dynStats("lib", 5 * intensity, "scale", false);
			}
			
			return true;
		}

		public function maxTeaseLevel():Number {
			var maxLevel:Number = 2;
			if (hasPerk(PerkLib.SuperSensual)) {
				if (level < 48) maxLevel += level;
				else maxLevel += 48;
			}
			else {
				if (level < 23) maxLevel += level;
				else maxLevel += 23;
			}
			return maxLevel;
		}
		public function teaseExpToLevelUp():Number {
			var expToLevelUp:Number = 10;
			var expToLevelUp00:Number = teaseLevel + 1;
			var expToLevelUp01:Number = 5;
			var expToLevelUp02:Number = teaseLevel + 1;
			if (hasPerk(PerkLib.ArouseTheAudience)) expToLevelUp00 -= 1;//2nd
			//-2;//4th
			//-3;//6th
			if (hasPerk(PerkLib.Sensual)) expToLevelUp01 -= 2;
			if (hasPerk(PerkLib.SuperSensual)) expToLevelUp01 -= 1;
			if (hasPerk(PerkLib.DazzlingDisplay)) expToLevelUp02 -= 1;//1st
			if (hasPerk(PerkLib.CriticalPerformance)) expToLevelUp02 -= 2;//3rd
			//-3;//5th
			expToLevelUp += expToLevelUp00 * expToLevelUp01 * expToLevelUp02;
			return expToLevelUp;
		}

		public function SexXP(XP:Number = 0):void {
			while (XP > 0) {
				if (XP == 1) {
					teaseXP++;
					XP--;
				}
				else {
					teaseXP += XP;
					XP -= XP;
				}
				//Level dat shit up!
				if (teaseLevel < maxTeaseLevel() && teaseXP >= teaseExpToLevelUp()) {
					outputText("\n<b>Tease skill leveled up to " + (teaseLevel + 1) + "!</b>");
					teaseLevel++;
					teaseXP = 0;
				}
			}
		}

		public function cumOmeter(changes:Number = 0):Number {
			flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] += changes;
			if (flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] > 100) flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] = 100;
			return flags[kFLAGS.SEXUAL_FLUIDS_LEVEL];
		}

		public function manticoreFeed():void
		{
			if (findPerk(PerkLib.ManticoreMetabolism) >= 0) {
				if (hasStatusEffect(StatusEffects.FeedingEuphoria)) {
					if (findPerk(PerkLib.ManticoreMetabolismEvolved) >= 0) {
						if (statusEffectv2(StatusEffects.FeedingEuphoria) < (30 + (10 * (1 + newGamePlusMod())))) {
							addStatusValue(StatusEffects.FeedingEuphoria, 2, 10);
							dynStats("spe", 10);
						}
						changeStatusValue(StatusEffects.FeedingEuphoria, 1, 15);
					}
					else {
						if (statusEffectv2(StatusEffects.FeedingEuphoria) < 30) {
							addStatusValue(StatusEffects.FeedingEuphoria, 2, 10);
							dynStats("spe", 10);
						}
						changeStatusValue(StatusEffects.FeedingEuphoria, 1, 10);
					}
				}
				else {
					if (findPerk(PerkLib.ManticoreMetabolismEvolved) >= 0) createStatusEffect(StatusEffects.FeedingEuphoria, 15, 10, 0, 0);
					else createStatusEffect(StatusEffects.FeedingEuphoria, 10, 10, 0, 0);
					dynStats("spe", 10);
				}
			}
			EngineCore.HPChange(Math.round(maxHP() * .2), true);
			cumOmeter(40);
			cor += 2;
			refillHunger(100);
		}

		public function sexReward(fluidtype:String = 'Default', type:String = 'Default', real:Boolean = true, Wasfluidinvolved:Boolean = true):void
		{
			if(Wasfluidinvolved)
			{
				switch (fluidtype)
				{
						// Start with that, whats easy
					case 'cum': //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_VAGINAL] < 10) flags[kFLAGS.TIMES_ORGASM_VAGINAL]++;
						if (hasPerk(PerkLib.ManticoreCumAddict))
						{
							manticoreFeed();
						}
						break;
					case 'vaginalFluids':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_ANAL]    < 10) flags[kFLAGS.TIMES_ORGASM_ANAL]++;
						break;
					case 'saliva':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_ANAL]    < 10) flags[kFLAGS.TIMES_ORGASM_ANAL]++;
						break;
					case 'milk':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_ANAL]    < 10) flags[kFLAGS.TIMES_ORGASM_ANAL]++;
						refillHunger(10, false);
						break;
						slimeFeed();
				}
			}
			SexXP(5+level);
			orgasm(type,real);
		}

		public function orgasmReal():void
		{
			dynStats("lus=", 0, "sca", false);
			hoursSinceCum = 0;
			flags[kFLAGS.TIMES_ORGASMED]++;

			if (countCockSocks("gilded") > 0) {
				var randomCock:int = rand( cocks.length );
				var bonusGems:int = rand( cocks[randomCock].cockThickness ) + countCockSocks("gilded"); // int so AS rounds to whole numbers
				EngineCore.outputText("\n\nFeeling some minor discomfort in your " + cockDescript(randomCock) + " you slip it out of your [armor] and examine it. <b>With a little exploratory rubbing and massaging, you manage to squeeze out " + bonusGems + " gems from its cum slit.</b>\n\n");
				gems += bonusGems;
			}
		}

		public function orgasm(type:String = 'Default', real:Boolean = true):void
		{
			switch (type) {
					// Start with that, whats easy
				case 'Vaginal': //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_VAGINAL] < 10) flags[kFLAGS.TIMES_ORGASM_VAGINAL]++;
					break;
				case 'Anal':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_ANAL]    < 10) flags[kFLAGS.TIMES_ORGASM_ANAL]++;
					break;
				case 'Dick':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_DICK]    < 10) flags[kFLAGS.TIMES_ORGASM_DICK]++;
					break;
				case 'Lips':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_LIPS]    < 10) flags[kFLAGS.TIMES_ORGASM_LIPS]++;
					break;
				case 'Tits':    //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_TITS]    < 10) flags[kFLAGS.TIMES_ORGASM_TITS]++;
					break;
				case 'Nipples': //if (CoC.instance.bimboProgress.ableToProgress() || flags[kFLAGS.TIMES_ORGASM_NIPPLES] < 10) flags[kFLAGS.TIMES_ORGASM_NIPPLES]++;
					break;
				case 'Ovi':     break;

					// Now to the more complex types
				case 'VaginalAnal':
					orgasm((hasVagina() ? 'Vaginal' : 'Anal'), real);
					return; // Prevent calling orgasmReal() twice

				case 'DickAnal':
					orgasm((rand(2) == 0 ? 'Dick' : 'Anal'), real);
					return;

				case 'Default':
				case 'Generic':
				default:
					if (!hasVagina() && !hasCock()) {
						orgasm('Anal'); // Failsafe for genderless PCs
						return;
					}

					if (hasVagina() && hasCock()) {
						orgasm((rand(2) == 0 ? 'Vaginal' : 'Dick'), real);
						return;
					}

					orgasm((hasVagina() ? 'Vaginal' : 'Dick'), real);
					return;
			}

			if (real) orgasmReal();
		}
		public function orgasmRaijuStyle():void
		{
			if (game.player.hasStatusEffect(StatusEffects.RaijuLightningStatus)) {
				EngineCore.outputText("\n\nAs you finish masturbating you feel a jolt in your genitals, as if for a small moment the raiju discharge was brought back, increasing the intensity of the pleasure and your desire to touch yourself. Electricity starts coursing through your body again by intermittence as something in you begins to change.");
				game.player.addStatusValue(StatusEffects.RaijuLightningStatus,1,6);
				dynStats("lus", (60 + rand(20)), "sca", false);
				game.mutations.voltageTopaz(false,CoC.instance.player);
			}
			else {
				EngineCore.outputText("\n\nAfter this electrifying orgasm your lust only raises higher than the sky above. You will need a partner to fuck with in order to discharge your ramping up desire and electricity.");
				dynStats("lus", (maxLust() * 0.1), "sca", false);
			}
			hoursSinceCum = 0;
			flags[kFLAGS.TIMES_ORGASMED]++;
		}
		public function penetrated(where:ISexyPart, tool:ISexyPart, options:Object = null):void {
			options = Utils.extend({
				display:true,
				orgasm:false
			},options||{});

			if (where.host != null && where.host != this) {
				trace("Penetration confusion! Host is "+where.host);
				return;
			}

			var size:Number = 8;
			if ('size' in options) size = options.size;
			else if (tool is Cock) size = (tool as Cock).cArea();

			var otype:String = 'Default';
			if (where is AssClass) {
				buttChange(size, options.display);
				otype = 'Anal';
			} else if (where is VaginaClass) {
				cuntChange(size, options.display);
				otype = 'Vaginal';
			}
			if (options.orgasm) {
				orgasm(otype);
			}
		}
		
		public function EnergyDependentRestore():void {
			addStatusValue(StatusEffects.EnergyDependent, 1, 5);
			addStatusValue(StatusEffects.EnergyDependent, 2, 12);
			spe += statusEffectv1(StatusEffects.EnergyDependent);
			inte += statusEffectv2(StatusEffects.EnergyDependent);
			soulforce += maxSoulforce() * 0.04;
			if (soulforce > maxSoulforce()) soulforce = maxSoulforce();
			outputText(" You feel slightly more alive from the soulforce you vampirised from your sexual partner orgasm.");
		}
		
		protected override function maxHP_base():Number {
			var max:Number = super.maxHP_base();
			if (alicornScore() >= 12) max += (250 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (centaurScore() >= 8) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 4) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 10) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 20) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 28) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (gorgonScore() >= 11) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (horseScore() >= 4) max += (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (horseScore() >= 7) max += (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (manticoreScore() >= 6) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (rhinoScore() >= 4) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (scyllaScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (scyllaScore() >= 7) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (scyllaScore() >= 12) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (unicornScore() >= 10) max += (150 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.ElementalBondFlesh) && statusEffectv1(StatusEffects.SummonedElementals) >= 2) max += maxLust_ElementalBondFleshMulti() * statusEffectv1(StatusEffects.SummonedElementals);
			
			return max;
		}
		protected override function maxLust_base():Number {
			var max:Number = super.maxLust_base();
			if (cowScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (cowScore() >= 9) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (demonScore() >= 5) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (demonScore() >= 11) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (devilkinScore() >= 7) max += (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (devilkinScore() >= 11) max += (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (devilkinScore() >= 16) max += (80 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (devilkinScore() >= 21) max += (90 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 20) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (dragonScore() >= 28) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (minotaurScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (minotaurScore() >= 9) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (phoenixScore() >= 5) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (salamanderScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (sharkScore() >= 9 && vaginas.length > 0 && cocks.length > 0) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.ElementalBondUrges) && statusEffectv1(StatusEffects.SummonedElementals) >= 2) max += maxLust_ElementalBondUrgesMulti() * statusEffectv1(StatusEffects.SummonedElementals);
			if (hasPerk(PerkLib.LactaBovinaOvaries)) max += (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.LactaBovinaOvariesFinalForm)) max += (90 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.MinotaurTesticles)) max += (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.MinotaurTesticlesFinalForm)) max += (90 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			return max;
		}
		
		override public function modStats(dstr:Number, dtou:Number, dspe:Number, dinte:Number, dwis:Number, dlib:Number, dsens:Number, dlust:Number, dcor:Number, scale:Boolean, max:Boolean):void {
			//Easy mode cuts lust gains!
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1 && dlust > 0 && scale) dlust /= 2;
			
			//Set original values to begin tracking for up/down values if
			//they aren't set yet.
			//These are reset when up/down arrows are hidden with
			//hideUpDown();
			//Just check str because they are either all 0 or real values
			if(game.oldStats.oldStr == 0) {
				game.oldStats.oldStr = str;
				game.oldStats.oldTou = tou;
				game.oldStats.oldSpe = spe;
				game.oldStats.oldInte = inte;
				game.oldStats.oldWis = wis;
				game.oldStats.oldLib = lib;
				game.oldStats.oldSens = sens;
				game.oldStats.oldCor = cor;
				game.oldStats.oldHP = HP;
				game.oldStats.oldLust = lust;
				game.oldStats.oldFatigue = fatigue;
				game.oldStats.oldSoulforce = soulforce;
				game.oldStats.oldHunger = hunger;
			}
			if (scale) {
				//MOD CHANGES FOR PERKS
				//Bimbos learn slower
				if (findPerk(PerkLib.FutaFaculties) >= 0 || findPerk(PerkLib.BimboBrains) >= 0 || findPerk(PerkLib.BroBrains) >= 0) {
					if (dinte > 0) dinte /= 2;
					if (dinte < 0) dinte *= 2;
				}
				if (findPerk(PerkLib.FutaForm) >= 0 || findPerk(PerkLib.BimboBody) >= 0 || findPerk(PerkLib.BroBody) >= 0) {
					if (dlib > 0) dlib *= 2;
					if (dlib < 0) dlib /= 2;
				}
				
				// Uma's Perkshit
				if (findPerk(PerkLib.ChiReflowSpeed) >= 0 && dspe < 0) dspe *= UmasShop.NEEDLEWORK_SPEED_SPEED_MULTI;
				if (findPerk(PerkLib.ChiReflowLust) >= 0 && dlib > 0) dlib *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
				if (findPerk(PerkLib.ChiReflowLust) >= 0 && dsens > 0) dsens *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
				
				//Apply lust changes in NG+.
				dlust *= 1 + (newGamePlusMod() * 0.2);
				
				//lust resistance
				if (dlust > 0 && scale) dlust *= EngineCore.lustPercent() / 100;
				if (dlib > 0 && findPerk(PerkLib.PurityBlessing) >= 0) dlib *= 0.75;
				if (dcor > 0 && findPerk(PerkLib.PurityBlessing) >= 0) dcor *= 0.5;
				if (dcor > 0 && findPerk(PerkLib.PureAndLoving) >= 0) dcor *= 0.75;
				if (dcor > 0 && weapon == game.weapons.HNTCANE) dcor *= 0.5;
				if (findPerk(PerkLib.AscensionMoralShifter) >= 0) dcor *= 1 + (perkv1(PerkLib.AscensionMoralShifter) * 0.2);
				if (findPerk(PerkLib.Lycanthropy) >= 0) dcor *= 1.2;
				if (hasStatusEffect(StatusEffects.BlessingOfDivineFera)) dcor *= 2;
				
				if (sens > 50 && dsens > 0) dsens /= 2;
				if (sens > 75 && dsens > 0) dsens /= 2;
				if (sens > 90 && dsens > 0) dsens /= 2;
				if (sens > 50 && dsens < 0) dsens *= 2;
				if (sens > 75 && dsens < 0) dsens *= 2;
				if (sens > 90 && dsens < 0) dsens *= 2;
				
				
				//Bonus gain for perks!
				if (findPerk(PerkLib.Strong) >= 0) dstr += dstr * perk(findPerk(PerkLib.Strong)).value1;
				if (findPerk(PerkLib.Tough) >= 0) dtou += dtou * perk(findPerk(PerkLib.Tough)).value1;
				if (findPerk(PerkLib.Fast) >= 0) dspe += dspe * perk(findPerk(PerkLib.Fast)).value1;
				if (findPerk(PerkLib.Smart) >= 0) dinte += dinte * perk(findPerk(PerkLib.Smart)).value1;
				if (findPerk(PerkLib.Wise) >= 0) dwis += dwis * perk(findPerk(PerkLib.Wise)).value1;
				if (findPerk(PerkLib.Lusty) >= 0) dlib += dlib * perk(findPerk(PerkLib.Lusty)).value1;
				if (findPerk(PerkLib.Sensitive) >= 0) dsens += dsens * perk(findPerk(PerkLib.Sensitive)).value1;
				
				// Uma's Str Cap from Perks (Moved to max stats)
				/*if (findPerk(PerkLib.ChiReflowSpeed) >= 0)
				{
					if (str > UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP)
					{
						str = UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP;
					}
				}
				if (findPerk(PerkLib.ChiReflowDefense) >= 0)
				{
					if (spe > UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP)
					{
						spe = UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP;
					}
				}*/
			}
			//Change original stats
			super.modStats(dstr,dtou,dspe,dinte,dwis,dlib,dsens,dlust,dcor,false,max);
			//Refresh the stat pane with updated values
			//mainView.statsView.showUpDown();
			EngineCore.showUpDown();
			EngineCore.statScreenRefresh();
		}
	}
}