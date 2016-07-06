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
		//Number of times explored for new areas
		public var explored:Number = 0;
		public var exploredForest:Number = 0;
		public var exploredDesert:Number = 0;
		public var exploredMountain:Number = 0;
		public var exploredLake:Number = 0;

		//Player pregnancy variables and functions
		override public function pregnancyUpdate():Boolean {
			return game.pregnancyProgress.updatePregnancy(); //Returns true if we need to make sure pregnancy texts aren't hidden
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
		private var _armor:Armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
		private var _jewelry:Jewelry = JewelryLib.NOTHING;
		private var _shield:Shield = ShieldLib.NOTHING;
		private var _upperGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _lowerGarment:Undergarment = UndergarmentLib.NOTHING;
		private var _modArmorName:String = "";

		//override public function set armors
		override public function set armorValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set armorValue.");
		}

		override public function set armorName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set armorName.");
		}

		override public function set armorDef(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set armorDef.");
		}

		override public function set armorPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set armorPerk.");
		}

		//override public function set weapons
		override public function set weaponName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set weaponName.");
		}

		override public function set weaponVerb(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set weaponVerb.");
		}

		override public function set weaponAttack(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set weaponAttack.");
		}

		override public function set weaponPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set weaponPerk.");
		}

		override public function set weaponValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set weaponValue.");
		}

		//override public function set jewelries
		override public function set jewelryName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set jewelryName.");
		}
		
		override public function set jewelryEffectId(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set jewelryEffectId.");
		}
		
		override public function set jewelryEffectMagnitude(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set jewelryEffectMagnitude.");
		}
				
		override public function set jewelryPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set jewelryPerk.");
		}
		
		override public function set jewelryValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set jewelryValue.");
		}

		//override public function set shields
		override public function set shieldName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set shieldName.");
		}
		
		override public function set shieldBlock(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set shieldBlock.");
		}
		
		override public function set shieldPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set shieldPerk.");
		}
		
		override public function set shieldValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set shieldValue.");
		}
		
		//override public function set undergarments
		override public function set upperGarmentName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set upperGarmentName.");
		}
		
		override public function set upperGarmentPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set upperGarmentPerk.");
		}
		
		override public function set upperGarmentValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set upperGarmentValue.");
		}

		override public function set lowerGarmentName(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set lowerGarmentName.");
		}
		
		override public function set lowerGarmentPerk(value:String):void
		{
			CoC_Settings.error("ERROR: attempt to directly set lowerGarmentPerk.");
		}
		
		override public function set lowerGarmentValue(value:Number):void
		{
			CoC_Settings.error("ERROR: attempt to directly set lowerGarmentValue.");
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
			if (armorDef > 0 && findPerk(PerkLib.HistorySmith) >= 0) {
				armorDef = Math.round(armorDef * 1.1);
				armorDef += 1;
			}
			//Skin armor perk
			if (findPerk(PerkLib.ThickSkin) >= 0) {
				armorDef += 2;
			}
			//Stacks on top of Thick Skin perk.
			if (skinType == SKIN_TYPE_FUR) armorDef += 1;
			if (skinType == SKIN_TYPE_SCALES) armorDef += 3;
			//'Thick' dermis descriptor adds 1!
			if (skinAdj == "smooth") armorDef += 1;
			//Bonus defense
			if (armType == ARM_TYPE_SPIDER) armorDef += 2;
			if (lowerBody == LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS || lowerBody == LOWER_BODY_TYPE_BEE) armorDef += 2;
			//Bonus when being a samurai
			if (armor == game.armors.SAMUARM && weapon == game.weapons.KATANA) {
				armorDef += 2;
			}
			//Agility boosts armor ratings!
			var speedBonus:int = 0;
			if (findPerk(PerkLib.Agility) >= 0) {
				if (armorPerk == "Light" || _armor.name == "nothing") speedBonus += Math.round(spe/8);
				else if (armorPerk == "Medium") speedBonus += Math.round(spe/13);
				if (speedBonus > 15) speedBonus = 15;
			}
			armorDef += speedBonus
			//Acupuncture effect
			if (findPerk(PerkLib.ChiReflowDefense) >= 0) armorDef *= UmasShop.NEEDLEWORK_DEFENSE_DEFENSE_MULTI;
			if (findPerk(PerkLib.ChiReflowAttack) >= 0) armorDef *= UmasShop.NEEDLEWORK_ATTACK_DEFENSE_MULTI;
			//Berzerking removes armor
			if (findStatusEffect(StatusEffects.Berzerking) >= 0) {
				if (findPerk(PerkLib.ColdFury) < 0)
					armorDef = 0;
				else
					armorDef /= 2;
			}
			if (kGAMECLASS.monster.findStatusEffect(StatusEffects.TailWhip) >= 0) {
				armorDef -= kGAMECLASS.monster.statusEffectv1(StatusEffects.TailWhip);
				if (armorDef < 0) armorDef = 0;
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
			if (findPerk(PerkLib.WeaponMastery) >= 0 && weaponPerk == "Large" && str > 60)
				attack *= 2;
			if (findPerk(PerkLib.LightningStrikes) >= 0 && spe >= 60 && weaponPerk != "Large") {
				attack += Math.round((spe - 50) / 3);
			}
			//Iron fists bonus!
			if (findPerk(PerkLib.IronFists) >= 0 && str >= 50 && weaponName == "fists")
				attack += 5;
			if (findPerk(PerkLib.IronFists2) >= 0 && str >= 65 && weaponName == "fists")
				attack += 3;
			if (findPerk(PerkLib.IronFists3) >= 0 && str >= 80 && weaponName == "fists")
				attack += 3;
			//Bonus for being samurai!
			if (armor == game.armors.SAMUARM && weapon == game.weapons.KATANA)
				attack += 2;
			//Berserking bonus!
			if (findStatusEffect(StatusEffects.Berzerking) >= 0) attack += 30;
			if (findStatusEffect(StatusEffects.Lustzerking) >= 0) attack += 30;
			attack += statusEffectv1(StatusEffects.ChargeWeapon);
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
				CoC_Settings.error(short + ".weapon is set to null");
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
			else if (flags[kFLAGS.GAME_DIFFICULTY] >= 3) damageMultiplier *= 1.5;

			
			//Opponents can critical too!
			var crit:Boolean = false
			if (rand(100) <= 4 || (kGAMECLASS.monster.findPerk(PerkLib.Tactician) >= 0 && kGAMECLASS.monster.inte >= 50 && (kGAMECLASS.monster.inte - 50)/5 > rand(100))) {
				crit = true;
				damage *= 1.75;
				flags[kFLAGS.ENEMY_CRITICAL] = 1;
			}
			if (findStatusEffect(StatusEffects.Shielding) >= 0) {
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
				race = "lizan";
			}
			if (dragonScore() >= 7)
			{
				race = "dragon-morph";
				if (faceType == 0)
					race = "dragon-" + mf("man", "girl");
				if (isTaur())
					race = "dragon-taur";
			}
			if (raccoonScore() >= 4)
			{
				race = "raccoon-morph";
				if (balls > 0 && ballSize > 5)
					race = "tanuki-morph";
				if (isTaur())
					race = "raccoon-taur";
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
			if (foxScore() >= 4)
			{
				if (isTaur() && lowerBody == LOWER_BODY_TYPE_FOX)
					race = "fox-taur";
				else if (skinType == 1)
					race = "fox-morph";
				else
					race = "fox-" + mf("morph", "girl");
			}
			if (ferretScore() >= 4)
			{
				if (skinType == 1)
					race = "ferret-morph";
				else
					race = "ferret-" + mf("morph", "girl");
			}
			if (kitsuneScore() >= 4)
			{
				race = "kitsune";
			}
			if (horseScore() >= 3)
			{
				if (isTaur())
					race = "centaur-morph";
				else
					if (hornType == HORNS_UNICORN) {
						if (wingType == WING_TYPE_FEATHERED_LARGE)
							race = "alicorn";
						else
							race = "unicorn-morph";
					} else {
						if (wingType == WING_TYPE_FEATHERED_LARGE)
							race = "pegasus";
						else
							race = "equine-morph";
					}
			}
			if (mutantScore() >= 5 && race == "human")
				race = "corrupted mutant";
			if (minoScore() >= 4) {
				race = "minotaur-morph";
				if (isTaur())
					race = "minotaur-taur";
			}
			if (cowScore() > 5)
			{
				race = "cow-";
				race += mf("morph", "girl");
			}
			if (beeScore() >= 5)
				race = "bee-morph";
			if (goblinScore() >= 5)
				race = "goblin";
			if (humanScore() >= 5 && race == "corrupted mutant")
				race = "somewhat human mutant";
			if (demonScore() > 4)
				race = "demon-morph";
			if (sharkScore() >= 3)
				race = "shark-morph";
			if (bunnyScore() >= 4)
				race = "bunny-" + mf("boy", "girl");
			if (harpyScore() >= 4)
			{
				if (gender >= 2)
					race = "harpy";
				else
					race = "avian";
			}
			if (spiderScore() >= 4)
			{
				race = "spider-morph";
				if (mf("no", "yes") == "yes")
					race = "spider-girl";
				if (isDrider())
					race = "drider";
			}
			if (kangaScore() >= 4)
				race = "kangaroo-morph";
			if (mouseScore() >= 3)
			{
				if (faceType != 16)
					race = "mouse-" + mf("boy", "girl");
				else
					race = "mouse-morph";
			}
			if (salamanderScore() >= 4)
			{
				if (isTaur()) race = "salamander-taur";
				else race = "salamander-morph";
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
				race = "echidna-morph";
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
					race  = "dragonne-morph";
					if (faceType == 0)
						race = "dragonne-" + mf("man", "girl");
				}
			}
			if (manticoreScore() >= 6)
			{
				race = "manticore-morph"
				if (faceType == 0)
					race = "manticore-" + mf("man", "girl");
			}
			if (sirenScore() >= 4)
			{
				race = "siren";
			}
			//</mod>
			if (lowerBody == 3)
				race = "naga";

			if (lowerBody == LOWER_BODY_TYPE_HOOFED && isTaur()) {
				if (wingType == WING_TYPE_FEATHERED_LARGE) {
					if (hornType == HORNS_UNICORN)
						race = "alicorn-taur";
					else
						race = "pegataur";
				} else {
					if (hornType == HORNS_UNICORN)
						race = "unicorn-taur";
					else {
						if (horseScore() >= 5)
							race = "equitaur";
						else
							race = "centaur";
					}
				}
			}

			if (lowerBody == LOWER_BODY_TYPE_PONY)
				race = "pony-kin";

			if (gooScore() >= 3)
			{
				race = "goo-";
				race += mf("boi", "girl");
			}
			
			
			return race;
		}

		//determine demon rating
		public function demonScore():Number
		{
			var demonCounter:Number = 0;
			if (hornType == 1 && horns > 0)
				demonCounter++;
			if (hornType == 1 && horns > 4)
				demonCounter++;
			if (tailType == 3)
				demonCounter++;
			if (wingType == 6 || wingType == 7)
				demonCounter++;
			if (skinType == 0 && cor > 50)
				demonCounter++;
			if (faceType == 0 && cor > 50)
				demonCounter++;
			if (lowerBody == 5 || lowerBody == 6)
				demonCounter++;
			if (countCocksOfType(CockTypesEnum.DEMON) > 0)
				demonCounter++;
			return demonCounter;
		}

		//Determine Human Rating
		public function humanScore():Number
		{
			var humanCounter:Number = 0;
			if (faceType == 0)
				humanCounter++;
			if (skinType == 0)
				humanCounter++;
			if (horns == 0)
				humanCounter++;
			if (tailType == 0)
				humanCounter++;
			if (wingType == 0)
				humanCounter++;
			if (lowerBody == 0)
				humanCounter++;
			if (countCocksOfType(CockTypesEnum.HUMAN) == 1 && totalCocks() == 1)
				humanCounter++;
			if (breastRows.length == 1 && skinType == 0)
				humanCounter++;
			return humanCounter;
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
				if (countCocksOfType(CockTypesEnum.HORSE) > 0)
					minoCounter++;
			}
			if (vaginas.length > 0)
				minoCounter--;
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
			if (tallness >= 73 && minoCounter > 0)
				minoCounter++;
			if (vaginas.length > 0)
				minoCounter++;
			if (biggestTitSize() > 4 && minoCounter > 0)
				minoCounter++;
			if (biggestLactation() > 2 && minoCounter > 0)
				minoCounter++;
			return minoCounter;
		}

		public function sandTrapScore():int
		{
			var counter:int = 0;
			if (findStatusEffect(StatusEffects.BlackNipples) >= 0)
				counter++;
			if (findStatusEffect(StatusEffects.Uniball) >= 0)
				counter++;
			if (hasVagina() && vaginaType() == 5)
				counter++;
			if (eyeType == 2)
				counter++;
			if (wingType == 12)
				counter++;
			if (findStatusEffect(StatusEffects.Uniball) >= 0)
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
			if (antennae > 0)
			{
				beeCounter++;
				if (faceType == 0)
					beeCounter++;
			}
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
				beeCounter++;
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
			return coonCounter;
		}

		//Determine Fox Rating
		public override function foxScore():Number
		{
			var foxCounter:Number = 0;
			if (faceType == 11)
				foxCounter++;
			if (earType == 9)
				foxCounter++;
			if (tailType == 13)
				foxCounter++;
			if (lowerBody == 17)
				foxCounter++;
			if (dogCocks() > 0 && foxCounter > 0)
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
			return foxCounter;
		}

		//Determine cat Rating
		public function catScore():Number
		{
			var catCounter:Number = 0;
			if (faceType == 6)
				catCounter++;
			if (earType == 5)
				catCounter++;
			if (tailType == 8)
				catCounter++;
			if (lowerBody == 9)
				catCounter++;
			if (countCocksOfType(CockTypesEnum.CAT) > 0)
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
			if (tailType == 9)
				lizardCounter++;
			if (lowerBody == 10)
				lizardCounter++;
			if (countCocksOfType(CockTypesEnum.LIZARD) > 0)
				lizardCounter++;
			if (horns > 0 && (hornType == 3 || hornType == 4))
				lizardCounter++;
			if (skinType == 2)
				lizardCounter++;
			return lizardCounter;
		}

		public function spiderScore():Number
		{
			var score:Number = 0;
			if (eyeType == 1)
				score += 2;
			if (faceType == 10)
				score++;
			if (armType == 2)
				score++;
			if (lowerBody == 15 || lowerBody == 16)
				score += 2;
			else if (score > 0)
				score--;
			if (tailType == 5)
				score += 2;
			if (skinType != SKIN_TYPE_PLAIN && score > 0)
				score--;
			return score;
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
			if (countCocksOfType(CockTypesEnum.HORSE) > 0)
				horseCounter++;
			if (lowerBody == 1 || lowerBody == 4)
				horseCounter++;
			//Fur only counts if some equine features are present
			if (skinType == 1 && horseCounter > 0)
				horseCounter++;
			return horseCounter;
		}

		//Determine kitsune Rating
		public function kitsuneScore():Number
		{
			var kitsuneCounter:int = 0;
			//If the character has fox ears, +1
			if (earType == EARS_FOX)
				kitsuneCounter++;
			//If the character has a fox tail, +1
			if (tailType == TAIL_TYPE_FOX)
				kitsuneCounter++;
			//If the character has two or more fox tails, +2
			if (tailType == TAIL_TYPE_FOX && tailVenom >= 2)
				kitsuneCounter += 2;
			//If the character has tattooed skin, +1
			//9999
			//If the character has a 'vag of holding', +1
			if (vaginalCapacity() >= 8000)
				kitsuneCounter++;
			//If the character's kitsune score is greater than 0 and:
			//If the character has a normal face, +1
			if (kitsuneCounter > 0 && (faceType == FACE_HUMAN || faceType == FACE_FOX))
				kitsuneCounter++;
			//If the character's kitsune score is greater than 1 and:
			//If the character has "blonde","black","red","white", or "silver" hair, +1
			if (kitsuneCounter > 0 && (InCollection(furColor, KitsuneScene.basicKitsuneHair) || InCollection(furColor, KitsuneScene.elderKitsuneColors)))
				kitsuneCounter++;
			//If the character's femininity is 40 or higher, +1
			if (kitsuneCounter > 0 && femininity >= 40)
				kitsuneCounter++;
			//If the character has fur, scales, or gooey skin, -1
			if (skinType == SKIN_TYPE_FUR && !InCollection(furColor, KitsuneScene.basicKitsuneFur) && !InCollection(furColor, KitsuneScene.elderKitsuneColors))
				kitsuneCounter--;
			if (skinType == SKIN_TYPE_SCALES)
				kitsuneCounter -= 2;
			if (skinType == SKIN_TYPE_GOO)
				kitsuneCounter -= 3;
			//If the character has abnormal legs, -1
			if (lowerBody != LOWER_BODY_TYPE_HUMAN && lowerBody != LOWER_BODY_TYPE_FOX)
				kitsuneCounter--;
			//If the character has a nonhuman face, -1
			if (faceType != FACE_HUMAN && faceType != FACE_FOX)
				kitsuneCounter--;
			//If the character has ears other than fox ears, -1
			if (earType != EARS_FOX)
				kitsuneCounter--;
			//If the character has tail(s) other than fox tails, -1
			if (tailType != TAIL_TYPE_FOX)
				kitsuneCounter--;

			return kitsuneCounter;

		}

		//Determine Dragon Rating
		public function dragonScore():Number
		{
			var dragonCounter:Number = 0;
			if (faceType == 12)
				dragonCounter++;
			if (earType == 10)
				dragonCounter++;
			if (tailType == 14)
				dragonCounter++;
			if (tongueType == 3)
				dragonCounter++;
			if (countCocksOfType(CockTypesEnum.DRAGON) > 0)
				dragonCounter++;
			if (wingType == 10 || wingType == 11)
				dragonCounter++;
			if (lowerBody == 18)
				dragonCounter++;
			if (horns > 0 && (hornType == 3 || hornType == 4))
				dragonCounter++;
			if (skinType == 2 && dragonCounter > 0)
				dragonCounter++;
			if (hornType == HORNS_DRACONIC_X4_12_INCH_LONG || hornType == HORNS_DRACONIC_X2)
				dragonCounter++;
			if (findPerk(PerkLib.Dragonfire) >= 0)
				dragonCounter++;
			return dragonCounter;
		}

		//Goblinscore
		public function goblinScore():Number
		{
			var horseCounter:Number = 0;
			if (earType == 4)
				horseCounter++;
			if (skinTone == "pale yellow" || skinTone == "grayish-blue" || skinTone == "green" || skinTone == "dark green")
				horseCounter++;
			if (horseCounter > 0)
			{
				if (faceType == 0)
					horseCounter++;
				if (tallness < 48)
					horseCounter++;
				if (hasVagina())
					horseCounter++;
				if (lowerBody == 0)
					horseCounter++;
			}
			return horseCounter;
		}

		//Gooscore
		public function gooScore():Number
		{
			var gooCounter:Number = 0;
			if (hairType == 3)
				gooCounter++;
			if (skinAdj == "slimy")
				gooCounter++;
			if (lowerBody == 8)
				gooCounter++;
			if (vaginalCapacity() > 9000)
				gooCounter++;
			if (findStatusEffect(StatusEffects.SlimeCraving) >= 0)
				gooCounter++;
			return gooCounter;
		}

		//Nagascore
		public function nagaScore():Number
		{
			var nagaCounter:Number = 0;
			if (faceType == 5)
				nagaCounter++;
			if (tongueType == 1)
				nagaCounter++;
			if (nagaCounter > 0 && antennae == 0)
				nagaCounter++;
			if (nagaCounter > 0 && wingType == 0)
				nagaCounter++;
			return nagaCounter;
		}

		//Bunnyscore
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
			if (skinType == 0 && bunnyCounter > 1)
				bunnyCounter++;
			//No wings and antennae a plus
			if (bunnyCounter > 0 && antennae == 0)
				bunnyCounter++;
			if (bunnyCounter > 0 && wingType == 0)
				bunnyCounter++;
			return bunnyCounter;
		}

		//Harpyscore
		public function harpyScore():Number
		{
			var harpy:Number = 0;
			if (armType == 1)
				harpy++;
			if (hairType == 1)
				harpy++;
			if (wingType == 9)
				harpy++;
			if (tailType == 11)
				harpy++;
			if (lowerBody == 13)
				harpy++;
			if (harpy >= 2 && faceType == 0)
				harpy++;
			if (harpy >= 2 && (earType == 0 || earType == 4))
				harpy++;
			return harpy;
		}

		//Kangascore
		public function kangaScore():Number
		{
			var kanga:Number = 0;
			if (countCocksOfType(CockTypesEnum.KANGAROO) > 0)
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

		//sharkscore
		public function sharkScore():Number
		{
			var sharkCounter:Number = 0;
			if (faceType == 4)
				sharkCounter++;
			if (wingType == 8)
				sharkCounter++;
			if (tailType == 7)
				sharkCounter++;
			//skin counting only if PC got any other shark traits
			if (skinType == 0 && sharkCounter > 0)
				sharkCounter++;
			return sharkCounter;
		}

		//Determine Mutant Rating
		public function mutantScore():Number
		{
			var mutantCounter:Number = 0;
			if (faceType > 0)
				mutantCounter++;
			if (skinType != SKIN_TYPE_PLAIN)
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
		
		//Salamander score
		public function salamanderScore():Number
		{
			var salamanderCounter:Number = 0;
			if (faceType == 0)
				salamanderCounter++;
			if (earType == 0)
				salamanderCounter++;
			if (armType == 5)
				salamanderCounter++;
			if (lowerBody == 25)
				salamanderCounter++;
			if (tailType == TAIL_TYPE_SALAMANDER)
				salamanderCounter++;
			if (countCocksOfType(CockTypesEnum.LIZARD) > 0)
				salamanderCounter++;
			if (findPerk(PerkLib.Lustzerker) >= 0)
				salamanderCounter++;
			return salamanderCounter;
		}
		
		//------------
		// Mod-Added
		//------------
		public function sirenScore():Number 
		{
			var sirenCounter:Number = 0;
			if (faceType == 4 && tailType == 7 && wingType == WING_TYPE_FEATHERED_LARGE && armType == ARM_TYPE_HARPY)
				sirenCounter+= 4;
			if (hasVagina()) 
				sirenCounter++;
			//if (hasCock() && findFirstCockType(CockTypesEnum.ANEMONE) >= 0)
			//	sirenCounter++;
			return sirenCounter++;
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
			if (countCocksOfType(CockTypesEnum.PIG) > 0)
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
			if (tongueType == TONGUE_ECHIDNA)
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
			if (tongueType == TONGUE_DRACONIC)
				dragonneCounter++;
			if (wingType == WING_TYPE_DRACONIC_LARGE || wingType == WING_TYPE_DRACONIC_SMALL)
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
			var catCounter:Number = 0;
			if (faceType == FACE_CAT)
				catCounter++;
			if (earType == EARS_CAT)
				catCounter++;
			if (tailType == TAIL_TYPE_SCORPION)
				catCounter += 2;
			if (lowerBody == LOWER_BODY_TYPE_CAT)
				catCounter++;
			if (catCounter >= 4) {
				if (hornType == HORNS_DEMON || hornType == HORNS_DRACONIC_X2 || hornType == HORNS_DRACONIC_X4_12_INCH_LONG)
					catCounter++;
				if (wingType == WING_TYPE_BAT_LIKE_TINY || wingType == WING_TYPE_DRACONIC_SMALL)
					catCounter++;
				if (wingType == WING_TYPE_BAT_LIKE_LARGE || wingType == WING_TYPE_DRACONIC_LARGE)
					catCounter += 2;
			}
			//Fur only counts if some canine features are present
			if (skinType == 1 && catCounter >= 6)
				catCounter++;
			return catCounter;
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
			if (findStatusEffect(StatusEffects.LactationEndurance) < 0)
				createStatusEffect(StatusEffects.LactationEndurance, 1, 0, 0, 0);
			total = biggestTitSize() * 10 * averageLactation() * statusEffectv1(StatusEffects.LactationEndurance) * totalBreasts();
			if (findPerk(PerkLib.MilkMaid) >= 0)
				total += 200 + (perkv1(PerkLib.MilkMaid) * 100);
			if (statusEffectv1(StatusEffects.LactationReduction) >= 48)
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
				if (spacingsF) outputText("  ");
				outputText("<b>Your hymen is torn, robbing you of your virginity.</b>", false);
				if (spacingsB) outputText("  ");
			}
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if (display && stretched) {
				//Virgins get different formatting
				if (devirgined) {
					//If no spaces after virgin loss
					if (!spacingsB) outputText("  ");
				}
				//Non virgins as usual
				else if (spacingsF) outputText("  ");
				if (vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LEVEL_CLOWN_CAR) outputText("<b>Your " + Appearance.vaginaDescript(this,0)+ " is stretched painfully wide, large enough to accommodate most beasts and demons.</b>");
				if (vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched so wide that it gapes continually.</b>");
				if (vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " painfully stretches, the lips now wide enough to gape slightly.</b>");
				if (vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LOOSE) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now very loose.</b>", false);
				if (vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_NORMAL) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is now a little loose.</b>", false);
				if (vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_TIGHT) outputText("<b>Your " + Appearance.vaginaDescript(this,0) + " is stretched out to a more normal size.</b>");
				if (spacingsB) outputText("  ");
			}
			return stretched;
		}

		public function buttChange(cArea:Number, display:Boolean, spacingsF:Boolean = true, spacingsB:Boolean = true):Boolean
		{
			var stretched:Boolean = buttChangeNoDisplay(cArea);
			//STRETCH SUCCESSFUL - begin flavor text if outputting it!
			if (stretched && display) {
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
				if (hunger > 100)
				{
					while (hunger > 110 && !game.prison.inPrison) {
						weightChange++;
						hunger -= 10;
					}
					modThickness(100, weightChange);
					hunger = 100;
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
			if (findStatusEffect(StatusEffects.SlimeCraving) >= 0) {
				//Reset craving value
				changeStatusValue(StatusEffects.SlimeCraving,1,0);
				//Flag to display feed update and restore stats in event parser
				if (findStatusEffect(StatusEffects.SlimeCravingFeed) < 0) {
					createStatusEffect(StatusEffects.SlimeCravingFeed,0,0,0,0);
				}
			}
			if (findPerk(PerkLib.Diapause) >= 0) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228] += 3 + rand(3);
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] = 1;
			}

		}

		public function minoCumAddiction(raw:Number = 10):void {
			//Increment minotaur cum intake count
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00340]++;
			//Fix if variables go out of range.
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 0;
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;

			//Turn off withdrawal
			//if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 1;
			//Reset counter
			flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] = 0;
			//If highly addicted, rises slower
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 60) raw /= 2;
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 80) raw /= 2;
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 90) raw /= 2;
			if (findPerk(PerkLib.MinotaurCumResistance) >= 0) raw *= 0;
			//If in withdrawl, readdiction is potent!
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) raw += 10;
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) raw += 5;
			raw = Math.round(raw * 100)/100;
			//PUT SOME CAPS ON DAT' SHIT
			if (raw > 50) raw = 50;
			if (raw < -50) raw = -50;
			flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] += raw;
			//Recheck to make sure shit didn't break
			if (findPerk(PerkLib.MinotaurCumResistance) >= 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0; //Never get addicted!
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 120) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 120;
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 0) flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;

		}

		public function spellMod():Number {
			var mod:Number = 1;
			if (findPerk(PerkLib.Archmage) >= 0 && inte >= 75) mod += .5;
			if (findPerk(PerkLib.Channeling) >= 0 && inte >= 60) mod += .5;
			if (findPerk(PerkLib.Mage) >= 0 && inte >= 50) mod += .5;
			if (findPerk(PerkLib.Spellpower) >= 0 && inte >= 50) mod += .5;
			if (findPerk(PerkLib.WizardsFocus) >= 0) {
				mod += perkv1(PerkLib.WizardsFocus);
			}
			if (findPerk(PerkLib.ChiReflowMagic) >= 0) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
			if (jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (jewelryEffectMagnitude / 100);
			if (countCockSocks("blue") > 0) mod += (countCockSocks("blue") * .05);
			if (findPerk(PerkLib.AscensionMysticality) >= 0) mod *= 1 + (perkv1(PerkLib.AscensionMysticality) * 0.05);
			return mod;
		}
		
		public function hasSpells():Boolean
		{
			return spellCount() > 0;
		}

		public function spellCount():Number
		{
			return [StatusEffects.KnowsArouse, StatusEffects.KnowsHeal, StatusEffects.KnowsMight, StatusEffects.KnowsCharge, StatusEffects.KnowsBlind, StatusEffects.KnowsWhitefire].filter(function(item:StatusEffectType, index:int, array:Array):Boolean {
						return this.findStatusEffect(item) >= 0; }, this).length;
		}

		public function spellCost(mod:Number):Number {
			//Addiditive mods
			var costPercent:Number = 100;
			if (findPerk(PerkLib.SpellcastingAffinity) >= 0) costPercent -= perkv1(PerkLib.SpellcastingAffinity);
			if (findPerk(PerkLib.WizardsEndurance) >= 0) costPercent -= perkv1(PerkLib.WizardsEndurance);
			
			//Limiting it and multiplicative mods
			if (findPerk(PerkLib.BloodMage) >= 0 && costPercent < 50) costPercent = 50;
			
			mod *= costPercent/100;
			
			if (findPerk(PerkLib.HistoryScholar) >= 0) {
				if (mod > 2) mod *= .8;
			}
			if (findPerk(PerkLib.BloodMage) >= 0 && mod < 5) mod = 5;
			else if (mod < 2) mod = 2;
			
			mod = Math.round(mod * 100)/100;
			return mod;
		}
		
		public function physicalCost(mod:Number):Number {
			var costPercent:Number = 100;
			if (findPerk(PerkLib.IronMan) >= 0) costPercent -= 50;
			mod *= costPercent/100;
			return mod;
		}
		
		//Modify fatigue
		//types:
		//  0 - normal
		//	1 - magic
		//	2 - physical
		//	3 - non-bloodmage magic
		public function changeFatigue(mod:Number,type:Number  = 0):void {
			//Spell reductions
			if (type == 1) {
				mod = spellCost(mod);
				
				//Blood mages use HP for spells
				if (findPerk(PerkLib.BloodMage) >= 0) {
					takeDamage(mod);
					return;
				}                
			}
			//Physical special reductions
			if (type == 2) {
				mod = physicalCost(mod);
			}
			if (type == 3) {
				mod = spellCost(mod);
			}
			if (fatigue >= maxFatigue() && mod > 0) return;
			if (fatigue <= 0 && mod < 0) return;
			//Fatigue restoration buffs!
			if (mod < 0) {
				var multi:Number = 1;
				
				if (findPerk(PerkLib.HistorySlacker) >= 0) multi *= 1.2;
				if (findPerk(PerkLib.ControlledBreath) >= 0 && cor < (30 + corruptionTolerance())) multi *= 1.1;
				if (findPerk(PerkLib.SpeedyRecovery) >= 0) multi *= 1.5;
				
				mod *= multi;
			}
			fatigue += mod;
			if (mod > 0) {
				game.mainView.statsView.showStatUp( 'fatigue' );
				// fatigueUp.visible = true;
				// fatigueDown.visible = false;
			}
			if (mod < 0) {
				game.mainView.statsView.showStatDown( 'fatigue' );
				// fatigueDown.visible = true;
				// fatigueUp.visible = false;
			}
			kGAMECLASS.dynStats("lus", 0, "resisted", false); //Force display fatigue up/down by invoking zero lust change.
			if (fatigue > maxFatigue()) fatigue = maxFatigue();
			if (fatigue < 0) fatigue = 0;
			kGAMECLASS.statScreenRefresh();
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
			if (breastRows.length == 1) {
				if (breastRows[0].breastRating > 0) {
					//Shrink if bigger than N/A cups
					var temp:Number;
					temp = 1;
					breastRows[0].breastRating--;
					//Shrink again 50% chance
					if (breastRows[0].breastRating >= 1 && rand(2) == 0 && findPerk(PerkLib.BigTits) < 0) {
						temp++;
						breastRows[0].breastRating--;
					}
					if (breastRows[0].breastRating < 0) breastRows[0].breastRating = 0;
					//Talk about shrinkage
					if (temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your breasts have shrunk!  With a quick measure, you determine they're now " + breastCup(0) + "s.", false);
					if (temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are much smaller!  With a quick measure, you determine they're now " + breastCup(0) + "s.", false);
				}
			}
			else if (breastRows.length > 1) {
				//multiple
				outputText("\n", false);
				//temp2 = amount changed
				//temp3 = counter
				var temp2:Number = 0;
				var temp3:Number = breastRows.length;
				while(temp3 > 0) {
					temp3--;
					if (breastRows[temp3].breastRating > 0) {
						breastRows[temp3].breastRating--;
						if (breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
						temp2++;
						outputText("\n", false);
						if (temp3 < breastRows.length - 1) outputText("...and y", false);
						else outputText("Y", false);
						outputText("our " + breastDescript(temp3) + " shrink, dropping to " + breastCup(temp3) + "s.", false);
					}
					if (breastRows[temp3].breastRating < 0) breastRows[temp3].breastRating = 0;
				}
				if (temp2 == 2) outputText("\nYou feel so much lighter after the change.", false);
				if (temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.", false);
				if (temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.", false);
			}
		}

		public function growTits(amount:Number, rowsGrown:Number, display:Boolean, growthType:Number):void
		{
			if (breastRows.length == 0) return;
			//GrowthType 1 = smallest grows
			//GrowthType 2 = Top Row working downward
			//GrowthType 3 = Only top row
			var temp2:Number = 0;
			var temp3:Number = 0;
			//Chance for "big tits" perked characters to grow larger!
			if (findPerk(PerkLib.BigTits) >= 0 && rand(3) == 0 && amount < 1) amount=1;

			// Needs to be a number, since uint will round down to 0 prevent growth beyond a certain point
			var temp:Number = breastRows.length;
			if (growthType == 1) {
				//Select smallest breast, grow it, move on
				while(rowsGrown > 0) {
					//Temp = counter
					temp = breastRows.length;
					//Temp2 = smallest tits index
					temp2 = 0;
					//Find smallest row
					while(temp > 0) {
						temp--;
						if (breastRows[temp].breastRating < breastRows[temp2].breastRating) temp2 = temp;
					}
					//Temp 3 tracks total amount grown
					temp3 += amount;
					trace("Breastrow chosen for growth: " + String(temp2) + ".");
					//Reuse temp to store growth amount for diminishing returns.
					temp = amount;
					if (!flags[kFLAGS.HYPER_HAPPY])
					{
						//Diminishing returns!
						if (breastRows[temp2].breastRating > 3)
						{
							if (findPerk(PerkLib.BigTits) < 0)
								temp /=1.5;
							else
								temp /=1.3;
						}

						// WHy are there three options here. They all have the same result.
						if (breastRows[temp2].breastRating > 7)
						{
							if (findPerk(PerkLib.BigTits) < 0)
								temp /=2;
							else
								temp /=1.5;
						}
						if (breastRows[temp2].breastRating > 9)
						{
							if (findPerk(PerkLib.BigTits) < 0)
								temp /=2;
							else
								temp /=1.5;
						}
						if (breastRows[temp2].breastRating > 12)
						{
							if (findPerk(PerkLib.BigTits) < 0)
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
				if (breastRows[0].breastRating > 3) {
					if (findPerk(PerkLib.BigTits) < 0) amount/=1.5;
					else amount/=1.3;
				}
				if (breastRows[0].breastRating > 7) {
					if (findPerk(PerkLib.BigTits) < 0) amount/=2;
					else amount /= 1.5;
				}
				if (breastRows[0].breastRating > 12) {
					if (findPerk(PerkLib.BigTits) < 0) amount/=2;
					else amount /= 1.5;
				}
			}
			/*if (breastRows[0].breastRating > 12) {
				if (hasPerk("Big Tits") < 0) amount/=2;
				else amount /= 1.5;
			}*/
			if (growthType == 2) {
				temp = 0;
				//Start at top and keep growing down, back to top if hit bottom before done.
				while(rowsGrown > 0) {
					if (temp+1 > breastRows.length) temp = 0;
					breastRows[temp].breastRating += amount;
					trace("Breasts increased by " + amount + " on row " + temp);
					temp++;
					temp3 += amount;
					rowsGrown--;
				}
			}
			if (growthType == 3) {
				while(rowsGrown > 0) {
					rowsGrown--;
					breastRows[0].breastRating += amount;
					temp3 += amount;
				}
			}
			//Breast Growth Finished...talk about changes.
			trace("Growth amount = ", amount);
			if (display) {
				if (growthType < 3) {
					if (amount <= 2)
					{
						if (breastRows.length > 1) outputText("Your rows of " + breastDescript(0) + " jiggle with added weight, growing a bit larger.", false);
						if (breastRows.length == 1) outputText("Your " + breastDescript(0) + " jiggle with added weight as they expand, growing a bit larger.", false);
					}
					else if (amount <= 4)
					{
						if (breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your rows of " + breastDescript(0) + " expand significantly.", false);
						if (breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.", false);
					}
					else
					{
						if (breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your " + breastDescript(0) + " tingle strongly, growing disturbingly large.", false);
						if (breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.", false);
					}
					if (biggestTitSize() >= 8.5 && nippleLength < 2)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 2;
					}
					if (biggestTitSize() >= 7 && nippleLength < 1)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 1;
					}
					if (biggestTitSize() >= 5 && nippleLength < .75)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .75;
					}
					if (biggestTitSize() >= 3 && nippleLength < .5)
					{
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .5;
					}
				}
				else
				{
					if (amount <= 2) {
						if (breastRows.length > 1) outputText("Your top row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.", false);
						if (breastRows.length == 1) outputText("Your row of " + breastDescript(0) + " jiggles with added weight as it expands, growing a bit larger.", false);
					}
					if (amount > 2 && amount <= 4) {
						if (breastRows.length > 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your top row of " + breastDescript(0) + " expand significantly.", false);
						if (breastRows.length == 1) outputText("You stagger as your chest gets much heavier.  Looking down, you watch with curiosity as your " + breastDescript(0) + " expand significantly.", false);
					}
					if (amount > 4) {
						if (breastRows.length > 1) outputText("You drop to your knees from a massive change in your body's center of gravity.  Your top row of " + breastDescript(0) + " tingle strongly, growing disturbingly large.", false);
						if (breastRows.length == 1) outputText("You drop to your knees from a massive change in your center of gravity.  The tingling in your " + breastDescript(0) + " intensifies as they continue to grow at an obscene rate.", false);
					}
					if (biggestTitSize() >= 8.5 && nippleLength < 2) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 2;
					}
					if (biggestTitSize() >= 7 && nippleLength < 1) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = 1;
					}
					if (biggestTitSize() >= 5 && nippleLength < .75) {
						outputText("  A tender ache starts at your " + nippleDescript(0) + "s as they grow to match your burgeoning breast-flesh.", false);
						nippleLength = .75;
					}
					if (biggestTitSize() >= 3 && nippleLength < .5) {
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
			if (findStatusEffect(StatusEffects.BimboChampagne) >= 0 || findPerk(PerkLib.BimboBody) >= 0 || findPerk(PerkLib.BroBody) >= 0 || findPerk(PerkLib.FutaForm) >= 0) {
				if (min > 40) min += 10;
				else if (min >= 20) min += 20;
				else min += 40;
			}
			//Omnibus' Gift
			if (findPerk(PerkLib.OmnibusGift) >= 0) {
				if (min > 40) min += 10;
				else if (min >= 20) min += 20;
				else min += 35;
			}
			//Nymph perk raises to 30
			if (findPerk(PerkLib.Nymphomania) >= 0) {
				if (min >= 40) min += 10;
				else if (min >= 20) min += 15;
				else min += 30;
			}
			//Oh noes anemone!
			if (findStatusEffect(StatusEffects.AnemoneArousal) >= 0) {
				if (min >= 40) min += 10;
				else if (min >= 20) min += 20;
				else min += 30;
			}
			//Hot blooded perk raises min lust!
			if (findPerk(PerkLib.HotBlooded) >= 0) {
				if (min > 0) min += perk(findPerk(PerkLib.HotBlooded)).value1 / 2;
				else min += perk(findPerk(PerkLib.HotBlooded)).value1;
			}
			if (findPerk(PerkLib.LuststickAdapted) > 0) {
				if (min < 50) min += 10;
				else min += 5;
			}
			if (findStatusEffect(StatusEffects.Infested) >= 0) {
				if (min < 50) min = 50;
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
			//Harpy Lipstick status forces minimum lust to be at least 50.
			if (min < 50 && findStatusEffect(StatusEffects.Luststick) >= 0) min = 50;
			//SHOULDRA BOOSTS
			//+20
			if (flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -168 && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75) {
				min += 20;
				if (flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -216)
					min += 30;
			}
			//SPOIDAH BOOSTS
			if (eggs() >= 20) {
				min += 10;
				if (eggs() >= 40) min += 10;
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
			if (findPerk(PerkLib.BasiliskResistance) >= 0)
			{
				maxSpe -= 5;
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
			//Alter max stats depending on race
			if (minoScore() >= 4) {
				maxStr += 20;
				maxTou += 10;
				maxInt -= 10;
			}
			if (lizardScore() >= 4) {
				maxInt += 10;
			}
			if (dragonScore() >= 4) {
				maxStr += 5;
				maxTou += 10;
				maxInt += 10;
			}
			if (dogScore() >= 4) {
				maxSpe += 10;
				maxInt -= 10;
			}
			if (foxScore() >= 4) {
				maxStr -= 10;
				maxSpe += 5;
				maxInt += 5;
			}
			if (catScore() >= 4) {
				maxSpe += 5;
			}
			if (bunnyScore() >= 4) {
				maxSpe += 10;
			}
			if (raccoonScore() >= 4) {
				maxSpe += 15;
			}
			if (horseScore() >= 4 && !isTaur() && !isNaga()) {
				maxSpe += 15;
				maxTou += 10;
				maxInt -= 10;
			}
			if (gooScore() >= 3) {
				maxTou += 10;
				maxSpe -= 10;
			}
			if (kitsuneScore() >= 4) {
				if (tailType == 13) {
					if (tailVenom == 1) {
						maxStr -= 2;
						maxSpe += 2;
						maxInt += 1;
					}
					else if (tailVenom >= 2 && tailVenom < 9) {
						maxStr -= tailVenom + 1;
						maxSpe += tailVenom + 1;
						maxInt += (tailVenom/2) + 0.5;
					}
					else if (tailVenom >= 9) {
						maxStr -= 10;
						maxSpe += 10;
						maxInt += 5;
					}
				}
			}
			if (beeScore() >= 4) {
				maxSpe += 5;
				maxTou += 5;
			}
			if (spiderScore() >= 4) {
				maxInt += 15;
				maxTou += 5;
				maxStr -= 10;
			}
			if (sharkScore() >= 4) {
				maxStr += 10;
				maxSpe += 5;
				maxInt -= 5;
			}
			if (harpyScore() >= 4) {
				maxSpe += 15;
				maxTou -= 10;
			}
			if (sirenScore() >= 4) {
				maxStr += 5;
				maxSpe += 20;
				maxTou -= 5;
			}
			if (demonScore() >= 4) {
				maxSpe += 5;
				maxInt += 5;
			}
			if (rhinoScore() >= 4) {
				maxStr += 15;
				maxTou += 15;
				maxSpe -= 10;
				maxInt -= 10;
			}
			if (satyrScore() >= 4) {
				maxStr += 5;
				maxSpe += 5;
			}
			if (salamanderScore() >= 4) {
				maxStr += 5;
				maxTou += 5;
			}
			if (isNaga()) maxSpe += 10;
			if (isTaur() || isDrider()) maxSpe += 20;
			//Apply New Game+
			maxStr += 25 * newGamePlusMod();
			maxTou += 25 * newGamePlusMod();
			maxSpe += 25 * newGamePlusMod();
			maxInt += 25 * newGamePlusMod();
			//Might
			if (findStatusEffect(StatusEffects.Might) >= 0) {
				maxStr += statusEffectv1(StatusEffects.Might);
				maxTou += statusEffectv2(StatusEffects.Might);
			}
			if (findStatusEffect(StatusEffects.AndysSmoke) >= 0) {
				maxSpe -= statusEffectv2(StatusEffects.AndysSmoke);
				maxInt += statusEffectv3(StatusEffects.AndysSmoke);
			}
			if (stats == "str" || stats == "strength") return maxStr;
			else if (stats == "tou" || stats == "toughness") return maxTou;
			else if (stats == "spe" || stats == "speed") return maxSpe;
			else if (stats == "inte" || stats == "int" || stats == "intelligence") return maxInt;
			else return 100;
		}
		
		public function requiredXP():int {
			var temp:int = level * 100;
			if (temp > 9999) temp = 9999;
			return temp;
		}
		
		public function minotaurAddicted():Boolean {
			return findPerk(PerkLib.MinotaurCumResistance) < 0 && (findPerk(PerkLib.MinotaurCumAddict) >= 0 || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1);
		}
		public function minotaurNeed():Boolean {
			return findPerk(PerkLib.MinotaurCumResistance) < 0 && flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1;
		}

		public function clearStatuses(visibility:Boolean):void
		{
			while(findStatusEffect(StatusEffects.Web) >= 0) {
				spe += statusEffectv1(StatusEffects.Web);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusEffect(StatusEffects.Web);
			}
			if (findStatusEffect(StatusEffects.Shielding) >= 0) removeStatusEffect(StatusEffects.Shielding);
			if (findStatusEffect(StatusEffects.HolliConstrict) >= 0) removeStatusEffect(StatusEffects.HolliConstrict);
			if (findStatusEffect(StatusEffects.LustStones) >= 0) removeStatusEffect(StatusEffects.LustStones);
			if (kGAMECLASS.monster.findStatusEffect(StatusEffects.Sandstorm) >= 0) kGAMECLASS.monster.removeStatusEffect(StatusEffects.Sandstorm);
			if (findStatusEffect(StatusEffects.Sealed) >= 0) {
				removeStatusEffect(StatusEffects.Sealed);
			}
			if (findStatusEffect(StatusEffects.Berzerking) >= 0) {
				removeStatusEffect(StatusEffects.Berzerking);
			}
			if (findStatusEffect(StatusEffects.Lustzerking) >= 0) {
				removeStatusEffect(StatusEffects.Lustzerking);
			}
			if (kGAMECLASS.monster.findStatusEffect(StatusEffects.TailWhip) >= 0) {
				kGAMECLASS.monster.removeStatusEffect(StatusEffects.TailWhip);
			}
			if (findStatusEffect(StatusEffects.UBERWEB) >= 0) removeStatusEffect(StatusEffects.UBERWEB);
			if (findStatusEffect(StatusEffects.DriderKiss) >= 0) removeStatusEffect(StatusEffects.DriderKiss);
			if (findStatusEffect(StatusEffects.WebSilence) >= 0) removeStatusEffect(StatusEffects.WebSilence);
			if (findStatusEffect(StatusEffects.GooArmorSilence) >= 0) removeStatusEffect(StatusEffects.GooArmorSilence);
			if (findStatusEffect(StatusEffects.Bound) >= 0) removeStatusEffect(StatusEffects.Bound);
			if (findStatusEffect(StatusEffects.GooArmorBind) >= 0) removeStatusEffect(StatusEffects.GooArmorBind);
			if (findStatusEffect(StatusEffects.Whispered) >= 0) removeStatusEffect(StatusEffects.Whispered);
			if (findStatusEffect(StatusEffects.AkbalSpeed) >= 0) {
				kGAMECLASS.dynStats("spe", statusEffectv1(StatusEffects.AkbalSpeed) * -1);
				removeStatusEffect(StatusEffects.AkbalSpeed);
			}
			if (findStatusEffect(StatusEffects.AmilyVenom) >= 0) {
				kGAMECLASS.dynStats("str", statusEffectv1(StatusEffects.AmilyVenom),"spe", statusEffectv2(StatusEffects.AmilyVenom));
				removeStatusEffect(StatusEffects.AmilyVenom);
			}
			while(findStatusEffect(StatusEffects.Blind) >= 0) {
				removeStatusEffect(StatusEffects.Blind);
			}
			if (findStatusEffect(StatusEffects.SheilaOil) >= 0) {
				removeStatusEffect(StatusEffects.SheilaOil);
			}
			if (kGAMECLASS.monster.findStatusEffect(StatusEffects.TwuWuv) >= 0) {
				inte += kGAMECLASS.monster.statusEffectv1(StatusEffects.TwuWuv);
				kGAMECLASS.statScreenRefresh();
				kGAMECLASS.mainView.statsView.showStatUp( 'inte' );
			}
			if (findStatusEffect(StatusEffects.NagaVenom) >= 0) {
				spe += statusEffectv1(StatusEffects.NagaVenom);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				//stats(0,0,statusEffectv1(StatusEffects.NagaVenom),0,0,0,0,0);
				removeStatusEffect(StatusEffects.NagaVenom);
			}
			if (findStatusEffect(StatusEffects.TentacleBind) >= 0) removeStatusEffect(StatusEffects.TentacleBind);
			if (findStatusEffect(StatusEffects.NagaBind) >= 0) removeStatusEffect(StatusEffects.NagaBind);
			if (findStatusEffect(StatusEffects.StoneLust) >= 0) {
				removeStatusEffect(StatusEffects.StoneLust);
			}
			removeStatusEffect(StatusEffects.FirstAttack);
			if (findStatusEffect(StatusEffects.TemporaryHeat) >= 0) removeStatusEffect(StatusEffects.TemporaryHeat);
			if (findStatusEffect(StatusEffects.NoFlee) >= 0) removeStatusEffect(StatusEffects.NoFlee);
			if (findStatusEffect(StatusEffects.Poison) >= 0) removeStatusEffect(StatusEffects.Poison);
			if (findStatusEffect(StatusEffects.IsabellaStunned) >= 0) removeStatusEffect(StatusEffects.IsabellaStunned);
			if (findStatusEffect(StatusEffects.Stunned) >= 0) removeStatusEffect(StatusEffects.Stunned);
			if (findStatusEffect(StatusEffects.Confusion) >= 0) removeStatusEffect(StatusEffects.Confusion);
			if (findStatusEffect(StatusEffects.ThroatPunch) >= 0) removeStatusEffect(StatusEffects.ThroatPunch);
			if (findStatusEffect(StatusEffects.KissOfDeath) >= 0) removeStatusEffect(StatusEffects.KissOfDeath);
			if (findStatusEffect(StatusEffects.AcidSlap) >= 0) removeStatusEffect(StatusEffects.AcidSlap);
			if (findStatusEffect(StatusEffects.GooBind) >= 0) removeStatusEffect(StatusEffects.GooBind);
			if (findStatusEffect(StatusEffects.HarpyBind) >= 0) removeStatusEffect(StatusEffects.HarpyBind);
			if (findStatusEffect(StatusEffects.CalledShot) >= 0) {
				spe += statusEffectv1(StatusEffects.CalledShot);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speDown.visible = false;
				// speUp.visible = true;
				removeStatusEffect(StatusEffects.CalledShot);
			}
			if (findStatusEffect(StatusEffects.DemonSeed) >= 0) {
				removeStatusEffect(StatusEffects.DemonSeed);
			}
			if (findStatusEffect(StatusEffects.ParalyzeVenom) >= 0) {
				str += statusEffect(findStatusEffect(StatusEffects.ParalyzeVenom)).value1;
				spe += statusEffect(findStatusEffect(StatusEffects.ParalyzeVenom)).value2;
				removeStatusEffect(StatusEffects.ParalyzeVenom);
			}
			if (findStatusEffect(StatusEffects.lustvenom) >= 0) {
				removeStatusEffect(StatusEffects.lustvenom);
			}
			if (findStatusEffect(StatusEffects.InfestAttempted) >= 0) {
				removeStatusEffect(StatusEffects.InfestAttempted);
			}
			if (findStatusEffect(StatusEffects.Might) >= 0) {
				kGAMECLASS.dynStats("str", -statusEffectv1(StatusEffects.Might),"tou", -statusEffectv2(StatusEffects.Might));
				removeStatusEffect(StatusEffects.Might);
			}
			if (findStatusEffect(StatusEffects.ChargeWeapon) >= 0) {
				removeStatusEffect(StatusEffects.ChargeWeapon);
			}
			if (findStatusEffect(StatusEffects.Disarmed) >= 0) {
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
			if (findStatusEffect(StatusEffects.AnemoneVenom) >= 0) {
				str += statusEffectv1(StatusEffects.AnemoneVenom);
				spe += statusEffectv2(StatusEffects.AnemoneVenom);
				//Make sure nothing got out of bounds
				kGAMECLASS.dynStats("cor", 0);

				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				kGAMECLASS.mainView.statsView.showStatUp( 'str' );
				// speUp.visible = true;
				// strUp.visible = true;
				removeStatusEffect(StatusEffects.AnemoneVenom);
			}
			if (findStatusEffect(StatusEffects.GnollSpear) >= 0) {
				spe += statusEffectv1(StatusEffects.GnollSpear);
				//Make sure nothing got out of bounds
				kGAMECLASS.dynStats("cor", 0);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusEffect(StatusEffects.GnollSpear);
			}
			if (findStatusEffect(StatusEffects.BasiliskCompulsion) >= 0) removeStatusEffect(StatusEffects.BasiliskCompulsion);
			if (findStatusEffect(StatusEffects.BasiliskSlow) >= 0) {
				spe += statusEffectv1(StatusEffects.BasiliskSlow);
				kGAMECLASS.mainView.statsView.showStatUp( 'spe' );
				// speUp.visible = true;
				// speDown.visible = false;
				removeStatusEffect(StatusEffects.BasiliskSlow);
			}
			if (findStatusEffect(StatusEffects.GiantGrabbed) >= 0) removeStatusEffect(StatusEffects.GiantGrabbed);
			if (findStatusEffect(StatusEffects.GiantBoulder) >= 0) removeStatusEffect(StatusEffects.GiantBoulder);
			if (findStatusEffect(StatusEffects.GiantStrLoss) >= 0) {
				str += statusEffectv1(StatusEffects.GiantStrLoss);
				removeStatusEffect(StatusEffects.GiantStrLoss);
			}
			if (findStatusEffect(StatusEffects.LizanBlowpipe) >= 0) {
				str += statusEffectv1(StatusEffects.LizanBlowpipe);
				tou += statusEffectv2(StatusEffects.LizanBlowpipe);
				spe += statusEffectv3(StatusEffects.LizanBlowpipe);
				sens -= statusEffectv4(StatusEffects.LizanBlowpipe);
				removeStatusEffect(StatusEffects.LizanBlowpipe);
			}
			while (findStatusEffect(StatusEffects.IzmaBleed) >= 0) removeStatusEffect(StatusEffects.IzmaBleed);
			if (findStatusEffect(StatusEffects.GardenerSapSpeed) >= 0)
			{
				spe += statusEffectv1(StatusEffects.GardenerSapSpeed);
				kGAMECLASS.mainView.statsView.showStatUp('spe');
				removeStatusEffect(StatusEffects.GardenerSapSpeed);
			}
			if (findStatusEffect(StatusEffects.KnockedBack) >= 0) removeStatusEffect(StatusEffects.KnockedBack);
			if (findStatusEffect(StatusEffects.RemovedArmor) >= 0) removeStatusEffect(StatusEffects.KnockedBack);
			if (findStatusEffect(StatusEffects.JCLustLevel) >= 0) removeStatusEffect(StatusEffects.JCLustLevel);
			if (findStatusEffect(StatusEffects.MirroredAttack) >= 0) removeStatusEffect(StatusEffects.MirroredAttack);
			if (findStatusEffect(StatusEffects.Tentagrappled) >= 0) removeStatusEffect(StatusEffects.Tentagrappled);
			if (findStatusEffect(StatusEffects.TentagrappleCooldown) >= 0) removeStatusEffect(StatusEffects.TentagrappleCooldown);
			if (findStatusEffect(StatusEffects.ShowerDotEffect) >= 0) removeStatusEffect(StatusEffects.ShowerDotEffect);
			if (findStatusEffect(StatusEffects.GardenerSapSpeed) >= 0)
			{
				spe += statusEffectv1(StatusEffects.GardenerSapSpeed);
				kGAMECLASS.mainView.statsView.showStatUp('spe');
				removeStatusEffect(StatusEffects.GardenerSapSpeed);
			}
			if (findStatusEffect(StatusEffects.DriderIncubusVenom) >= 0) {
				str += statusEffectv1(StatusEffects.DriderIncubusVenom);
				kGAMECLASS.mainView.statsView.showStatUp('str');
				removeStatusEffect(StatusEffects.DriderIncubusVenom);
			}
			if (findStatusEffect(StatusEffects.PurpleHaze) >= 0) removeStatusEffect(StatusEffects.PurpleHaze);
			if (findStatusEffect(StatusEffects.TaintedMind) >= 0) removeStatusEffect(StatusEffects.TaintedMind);
			if (findStatusEffect(StatusEffects.MinotaurKingMusk) >= 0) removeStatusEffect(StatusEffects.MinotaurKingMusk);
			if (findStatusEffect(StatusEffects.MinotaurKingsTouch) >= 0) removeStatusEffect(StatusEffects.MinotaurKingsTouch);
			if (findStatusEffect(StatusEffects.PigbysHands) >= 0) removeStatusEffect(StatusEffects.PigbysHands);
			if (findStatusEffect(StatusEffects.WhipSilence) >= 0) removeStatusEffect(StatusEffects.WhipSilence);
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
				if (!hasItem(itype,1))
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
					if (slot.quantity == 0) slot.emptySlot();
					trace("EATIN' AN ITEM");
				}
				//If on slot 5 and it doesn't have any more to take, break out!
				if (slot == undefined) amount = -1

			}
			if (amount == 0) consumed = true;
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
				if (itemSlot(i).itype == itype && itemSlot(i).quantity != 0 && itemSlot(i).quantity < 5)
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
				if (itemSlot(slotNum).itype == itype)
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
			if (temp2 <= 1 && temp2 > 0) {
				if (cocks.length == 1) outputText("Your " + cockDescript(0) + " has grown slightly longer.", false);
				if (cocks.length > 1) {
					if (ncocks == 1) outputText("One of your " + multiCockDescriptLight() + " grows slightly longer.", false);
					if (ncocks > 1 && ncocks < cocks.length) outputText("Some of your " + multiCockDescriptLight() + " grow slightly longer.", false);
					if (ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " seem to fill up... growing a little bit larger.", false);
				}
			}
			if (temp2 > 1 && temp2 < 3) {
				if (cocks.length == 1) outputText("A very pleasurable feeling spreads from your groin as your " + cockDescript(0) + " grows permanently longer - at least an inch - and leaks pre-cum from the pleasure of the change.", false);
				if (cocks.length > 1) {
					if (ncocks == cocks.length) outputText("A very pleasurable feeling spreads from your groin as your " + multiCockDescriptLight() + " grow permanently longer - at least an inch - and leak plenty of pre-cum from the pleasure of the change.", false);
					if (ncocks == 1) outputText("A very pleasurable feeling spreads from your groin as one of your " + multiCockDescriptLight() + " grows permanently longer, by at least an inch, and leaks plenty of pre-cum from the pleasure of the change.", false);
					if (ncocks > 1 && ncocks < cocks.length) outputText("A very pleasurable feeling spreads from your groin as " + num2Text(ncocks) + " of your " + multiCockDescriptLight() + " grow permanently longer, by at least an inch, and leak plenty of pre-cum from the pleasure of the change.", false);
				}
			}
			if (temp2 >=3){
				if (cocks.length == 1) outputText("Your " + cockDescript(0) + " feels incredibly tight as a few more inches of length seem to pour out from your crotch.", false);
				if (cocks.length > 1) {
					if (ncocks == 1) outputText("Your " + multiCockDescriptLight() + " feel incredibly tight as one of their number begins to grow inch after inch of length.", false);
					if (ncocks > 1 && ncocks < cocks.length) outputText("Your " + multiCockDescriptLight() + " feel incredibly number as " + num2Text(ncocks) + " of them begin to grow inch after inch of added length.", false);
					if (ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " feel incredibly tight as inch after inch of length pour out from your groin.", false);
				}
			}
			//Display LengthChange
			if (temp2 > 0) {
				if (cocks[0].cockLength >= 8 && cocks[0].cockLength-temp2 < 8){
					if (cocks.length == 1) outputText("  <b>Most men would be overly proud to have a tool as long as yours.</b>", false);
					if (cocks.length > 1) outputText("  <b>Most men would be overly proud to have one cock as long as yours, let alone " + multiCockDescript() + ".</b>", false);
				}
				if (cocks[0].cockLength >= 12 && cocks[0].cockLength-temp2 < 12) {
					if (cocks.length == 1) outputText("  <b>Your " + cockDescript(0) + " is so long it nearly swings to your knee at its full length.</b>", false);
					if (cocks.length > 1) outputText("  <b>Your " + multiCockDescriptLight() + " are so long they nearly reach your knees when at full length.</b>", false);
				}
				if (cocks[0].cockLength >= 16 && cocks[0].cockLength-temp2 < 16) {
					if (cocks.length == 1) outputText("  <b>Your " + cockDescript(0) + " would look more at home on a large horse than you.</b>", false);
					if (cocks.length > 1) outputText("  <b>Your " + multiCockDescriptLight() + " would look more at home on a large horse than on your body.</b>", false);
					if (biggestTitSize() >= BREAST_CUP_C) {
						if (cocks.length == 1) outputText("  You could easily stuff your " + cockDescript(0) + " between your breasts and give yourself the titty-fuck of a lifetime.", false);
						if (cocks.length > 1) outputText("  They reach so far up your chest it would be easy to stuff a few cocks between your breasts and give yourself the titty-fuck of a lifetime.", false);
					}
					else {
						if (cocks.length == 1) outputText("  Your " + cockDescript(0) + " is so long it easily reaches your chest.  The possibility of autofellatio is now a foregone conclusion.", false);
						if (cocks.length > 1) outputText("  Your " + multiCockDescriptLight() + " are so long they easily reach your chest.  Autofellatio would be about as hard as looking down.", false);
					}
				}
				if (cocks[0].cockLength >= 20 && cocks[0].cockLength-temp2 < 20) {
					if (cocks.length == 1) outputText("  <b>As if the pulsing heat of your " + cockDescript(0) + " wasn't enough, the tip of your " + cockDescript(0) + " keeps poking its way into your view every time you get hard.</b>", false);
					if (cocks.length > 1) outputText("  <b>As if the pulsing heat of your " + multiCockDescriptLight() + " wasn't bad enough, every time you get hard, the tips of your " + multiCockDescriptLight() + " wave before you, obscuring the lower portions of your vision.</b>", false);
					if (cor > 40 && cor <= 60) {
						if (cocks.length > 1) outputText("  You wonder if there is a demon or beast out there that could take the full length of one of your " + multiCockDescriptLight() + "?", false);
						if (cocks.length ==1) outputText("  You wonder if there is a demon or beast out there that could handle your full length.", false);
					}
					if (cor > 60 && cor <= 80) {
						if (cocks.length > 1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your " + multiCockDescriptLight() + " to their hilts, milking you dry.\n\nYou smile at the pleasant thought.", false);
						if (cocks.length ==1) outputText("  You daydream about being attacked by a massive tentacle beast, its tentacles engulfing your " + cockDescript(0) + " to the hilt, milking it of all your cum.\n\nYou smile at the pleasant thought.", false);
					}
					if (cor > 80) {
						if (cocks.length > 1) outputText("  You find yourself fantasizing about impaling nubile young champions on your " + multiCockDescriptLight() + " in a year's time.", false);
					}
				}
			}
			//Display the degree of length loss.
			if (temp2 < 0 && temp2 >= -1) {
				if (cocks.length == 1) outputText("Your " + multiCockDescriptLight() + " has shrunk to a slightly shorter length.", false);
				if (cocks.length > 1) {
					if (ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " have shrunk to a slightly shorter length.", false);
					if (ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your " + multiCockDescriptLight() + " have shrunk to a slightly shorter length.", false);
					if (ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your " + multiCockDescriptLight() + " has shrunk to a slightly shorter length.", false);
				}
			}
			if (temp2 < -1 && temp2 > -3) {
				if (cocks.length == 1) outputText("Your " + multiCockDescriptLight() + " shrinks smaller, flesh vanishing into your groin.", false);
				if (cocks.length > 1) {
					if (ncocks == cocks.length) outputText("Your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
					if (ncocks == 1) outputText("You feel " + num2Text(ncocks) + " of your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
					if (ncocks > 1 && ncocks < cocks.length) outputText("You feel " + num2Text(ncocks) + " of your " + multiCockDescriptLight() + " shrink smaller, the flesh vanishing into your groin.", false);
				}
			}
			if (temp2 <= -3) {
				if (cocks.length == 1) outputText("A large portion of your " + multiCockDescriptLight() + "'s length shrinks and vanishes.", false);
				if (cocks.length > 1) {
					if (ncocks == cocks.length) outputText("A large portion of your " + multiCockDescriptLight() + " recedes towards your groin, receding rapidly in length.", false);
					if (ncocks == 1) outputText("A single member of your " + multiCockDescriptLight() + " vanishes into your groin, receding rapidly in length.", false);
					if (ncocks > 1 && cocks.length > ncocks) outputText("Your " + multiCockDescriptLight() + " tingles as " + num2Text(ncocks) + " of your members vanish into your groin, receding rapidly in length.", false);
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
					if (findStatusEffect(StatusEffects.Infested) >= 0) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
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
					if (findStatusEffect(StatusEffects.Infested) >= 0) outputText("  Like rats fleeing a sinking ship, a stream of worms squirts free from your withering member, slithering away.", false);
				}
				if (cocks.length == 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with just your " + cockDescript(0) + ".", false);
				}
				if (cocks.length > 1) {
					outputText("<b>You feel " + num2Text(removed) + " cocks disappear into your groin, leaving you with " + multiCockDescriptLight() + ".", false);
				}
			}
			//remove infestation if cockless
			if (cocks.length == 0) removeStatusEffect(StatusEffects.Infested);
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
			if (!hasVagina() || pregnancyIncubation != 0) {
				// No vagina or already pregnant, can't go into heat.
				return false;
			}
			
			//Already in heat, intensify further.
			if (inHeat) {
				if (output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Despite already being in heat, the desire to copulate constantly grows even larger.", false);
				}
				var temp:Number = findStatusEffect(StatusEffects.Heat);
				statusEffect(temp).value1 += 5 * intensity;
				statusEffect(temp).value2 += 5 * intensity;
				statusEffect(temp).value3 += 48 * intensity;
				game.dynStats("lib", 5 * intensity, "resisted", false, "noBimbo", true);
			}
			//Go into heat.  Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
			else {
				if (output) {
					outputText("\n\nYour mind clouds as your " + vaginaDescript(0) + " moistens.  Your hands begin stroking your body from top to bottom, your sensitive skin burning with desire.  Fantasies about bending over and presenting your needy pussy to a male overwhelm you as <b>you realize you have gone into heat!</b>", false);
				}
				createStatusEffect(StatusEffects.Heat, 10 * intensity, 15 * intensity, 48 * intensity, 0);
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
				if (output) {
					outputText("\n\nYour " + cockDescript(0) + " throbs and dribbles as your desire to mate intensifies.  You know that <b>you've sunken deeper into rut</b>, but all that really matters is unloading into a cum-hungry cunt.", false);
				}
				
				addStatusValue(StatusEffects.Rut, 1, 100 * intensity);
				addStatusValue(StatusEffects.Rut, 2, 5 * intensity);
				addStatusValue(StatusEffects.Rut, 3, 48 * intensity);
				game.dynStats("lib", 5 * intensity, "resisted", false, "noBimbo", true);
			}
			else {
				if (output) {
					outputText("\n\nYou stand up a bit straighter and look around, sniffing the air and searching for a mate.  Wait, what!?  It's hard to shake the thought from your head - you really could use a nice fertile hole to impregnate.  You slap your forehead and realize <b>you've gone into rut</b>!", false);
				}
				
				//v1 - bonus cum production
				//v2 - bonus libido
				//v3 - time remaining!
				createStatusEffect(StatusEffects.Rut, 150 * intensity, 5 * intensity, 100 * intensity, 0);
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
