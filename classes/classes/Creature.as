//CoC Creature.as
package classes
{
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Beard;
import classes.BodyParts.Butt;
import classes.BodyParts.Claws;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.IOrifice;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.UnderBody;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Items.ItemTags;
import classes.Items.JewelryLib;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Stats.Buff;
import classes.Stats.BuffBuilder;
import classes.Stats.BuffableStat;
import classes.Stats.PrimaryStat;
import classes.Stats.RawStat;
import classes.Stats.StatStore;
import classes.StatusEffects.Combat.CombatInteBuff;
import classes.StatusEffects.Combat.CombatSpeBuff;
import classes.StatusEffects.Combat.CombatStrBuff;
import classes.StatusEffects.Combat.CombatTouBuff;
import classes.StatusEffects.Combat.CombatWisBuff;
import classes.internals.Utils;
import classes.lists.BreastCup;
import classes.lists.Gender;

import flash.errors.IllegalOperationError;

public class Creature extends Utils
	{
		// Ability types
		public static const ABILITY_PHYSICAL: String = "physical";
		public static const ABILITY_MAGIC: String = "magic";
		public static const ABILITY_TEASE: String = "tease";
		public static const ABILITY_SPECIAL: String = "special";

		// Ability ranges
		public static const RANGE_SELF: int = 0;
		public static const RANGE_MELEE: int = 1;
		public static const RANGE_RANGED: int = 2;

		// Ability tags
		/**
		 * This ability uses one's weapon
		 */
		public static const TAG_WEAPON: String = "weapon";
		public static const TAG_BODY: String = "body";
		// element tags
		public static const TAG_ACID: String = "acid";
		public static const TAG_FIRE: String = "fire";
		public static const TAG_ICE: String = "ice";
		public static const TAG_HEAL: String = "heal";
		public static const TAG_FLUID: String = "fluid";



		public function get game():CoC {
			return CoC.instance;
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
		private var _weaponType:String = "";
		private var _weaponValue:Number = 0;
		public function get weaponName():String { return _weaponName; }
		public function get weaponVerb():String { return _weaponVerb; }
		public function get weaponAttack():Number { return _weaponAttack; }
		public function get weaponPerk():String { return _weaponPerk; }
		public function get weaponType():String { return _weaponType; }
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
		private var _armorMDef:Number = 0;
		private var _armorPerk:String = "";
		private var _armorValue:Number = 0;
		public function get armorName():String { return _armorName; }
		public function get armorDef():Number { return _armorDef; }
		public function get armorMDef():Number { return _armorMDef; }
		public function get armorPerk():String { return _armorPerk; }
		public function get armorValue():Number { return _armorValue; }
		public function set armorValue(value:Number):void { _armorValue = value; }
		public function set armorName(value:String):void { _armorName = value; }
		public function set armorDef(value:Number):void { _armorDef = value; }
		public function set armorMDef(value:Number):void { _armorMDef = value; }
		public function set armorPerk(value:String):void { _armorPerk = value; }
		//Head Jewelery
		private var _headjewelryName:String = "";
		private var _headjewelryEffectId:Number = 0;
		private var _headjewelryEffectMagnitude:Number = 0;
		private var _headjewelryPerk:String = "";
		private var _headjewelryValue:Number = 0;
		public function get headjewelryName():String { return _headjewelryName; }
		public function get headjewelryEffectId():Number { return _headjewelryEffectId; }
		public function get headjewelryEffectMagnitude():Number { return _headjewelryEffectMagnitude; }
		public function get headjewelryPerk():String { return _headjewelryPerk; }
		public function get headjewelryValue():Number { return _headjewelryValue; }
		public function set headjewelryValue(value:Number):void { _headjewelryValue = value; }
		public function set headjewelryName(value:String):void { _headjewelryName = value; }
		public function set headjewelryEffectId(value:Number):void { _headjewelryEffectId = value; }
		public function set headjewelryEffectMagnitude(value:Number):void { _headjewelryEffectId = value; }
		public function set headjewelryPerk(value:String):void { _headjewelryPerk = value; }
		//Necklace
		private var _necklaceName:String = "";
		private var _necklaceEffectId:Number = 0;
		private var _necklaceEffectMagnitude:Number = 0;
		private var _necklacePerk:String = "";
		private var _necklaceValue:Number = 0;
		public function get necklaceName():String { return _necklaceName; }
		public function get necklaceEffectId():Number { return _necklaceEffectId; }
		public function get necklaceEffectMagnitude():Number { return _necklaceEffectMagnitude; }
		public function get necklacePerk():String { return _necklacePerk; }
		public function get necklaceValue():Number { return _necklaceValue; }
		public function set necklaceValue(value:Number):void { _necklaceValue = value; }
		public function set necklaceName(value:String):void { _necklaceName = value; }
		public function set necklaceEffectId(value:Number):void { _necklaceEffectId = value; }
		public function set necklaceEffectMagnitude(value:Number):void { _necklaceEffectId = value; }
		public function set necklacePerk(value:String):void { _necklacePerk = value; }
		//Rings (Jewelry)
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
		private var _jewelryName2:String = "";
		private var _jewelryEffectId2:Number = 0;
		private var _jewelryEffectMagnitude2:Number = 0;
		private var _jewelryPerk2:String = "";
		private var _jewelryValue2:Number = 0;
		public function get jewelryName2():String { return _jewelryName2; }
		public function get jewelryEffectId2():Number { return _jewelryEffectId2; }
		public function get jewelryEffectMagnitude2():Number { return _jewelryEffectMagnitude2; }
		public function get jewelryPerk2():String { return _jewelryPerk2; }
		public function get jewelryValue2():Number { return _jewelryValue2; }
		public function set jewelryValue2(value:Number):void { _jewelryValue2 = value; }
		public function set jewelryName2(value:String):void { _jewelryName2 = value; }
		public function set jewelryEffectId2(value:Number):void { _jewelryEffectId2 = value; }
		public function set jewelryEffectMagnitude2(value:Number):void { _jewelryEffectId2 = value; }
		public function set jewelryPerk2(value:String):void { _jewelryPerk2 = value; }
		private var _jewelryName3:String = "";
		private var _jewelryEffectId3:Number = 0;
		private var _jewelryEffectMagnitude3:Number = 0;
		private var _jewelryPerk3:String = "";
		private var _jewelryValue3:Number = 0;
		public function get jewelryName3():String { return _jewelryName3; }
		public function get jewelryEffectId3():Number { return _jewelryEffectId3; }
		public function get jewelryEffectMagnitude3():Number { return _jewelryEffectMagnitude3; }
		public function get jewelryPerk3():String { return _jewelryPerk3; }
		public function get jewelryValue3():Number { return _jewelryValue3; }
		public function set jewelryValue3(value:Number):void { _jewelryValue3 = value; }
		public function set jewelryName3(value:String):void { _jewelryName3 = value; }
		public function set jewelryEffectId3(value:Number):void { _jewelryEffectId3 = value; }
		public function set jewelryEffectMagnitude3(value:Number):void { _jewelryEffectId3 = value; }
		public function set jewelryPerk3(value:String):void { _jewelryPerk3 = value; }
		private var _jewelryName4:String = "";
		private var _jewelryEffectId4:Number = 0;
		private var _jewelryEffectMagnitude4:Number = 0;
		private var _jewelryPerk4:String = "";
		private var _jewelryValue4:Number = 0;
		public function get jewelryName4():String { return _jewelryName4; }
		public function get jewelryEffectId4():Number { return _jewelryEffectId4; }
		public function get jewelryEffectMagnitude4():Number { return _jewelryEffectMagnitude4; }
		public function get jewelryPerk4():String { return _jewelryPerk4; }
		public function get jewelryValue4():Number { return _jewelryValue4; }
		public function set jewelryValue4(value:Number):void { _jewelryValue4 = value; }
		public function set jewelryName4(value:String):void { _jewelryName4 = value; }
		public function set jewelryEffectId4(value:Number):void { _jewelryEffectId4 = value; }
		public function set jewelryEffectMagnitude4(value:Number):void { _jewelryEffectId4 = value; }
		public function set jewelryPerk4(value:String):void { _jewelryPerk4 = value; }
		//Shield
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
		//Undergarments
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
		//Vehicles
		private var _vehiclesName:String = "";
		private var _vehiclesEffectId:Number = 0;
		private var _vehiclesEffectMagnitude:Number = 0;
		private var _vehiclesPerk:String = "";
		private var _vehiclesValue:Number = 0;
		public function get vehiclesName():String { return _vehiclesName; }
		public function get vehiclesEffectId():Number { return _vehiclesEffectId; }
		public function get vehiclesEffectMagnitude():Number { return _vehiclesEffectMagnitude; }
		public function get vehiclesPerk():String { return _vehiclesPerk; }
		public function get vehiclesValue():Number { return _vehiclesValue; }
		public function set vehiclesValue(value:Number):void { _vehiclesValue = value; }
		public function set vehiclesName(value:String):void { _vehiclesName = value; }
		public function set vehiclesEffectId(value:Number):void { _vehiclesEffectId = value; }
		public function set vehiclesEffectMagnitude(value:Number):void { _vehiclesEffectId = value; }
		public function set vehiclesPerk(value:String):void { _vehiclesPerk = value; }

		/*

		   [   S T A T S   ]

		 */
		public function get statStore():StatStore { return _stats; }

		public function buff(tag:String):BuffBuilder {
			return new BuffBuilder(statStore, tag);
		}

		//new stat area
		public var strStat:PrimaryStat;
		public var touStat:PrimaryStat;
		public var speStat:PrimaryStat;
		public var intStat:PrimaryStat;
		public var wisStat:PrimaryStat;
		public var libStat:PrimaryStat;
		public var sensStat:BuffableStat;

		private var _stats: StatStore;


		public function get str():Number { return strStat.value; }
		public function get tou():Number {if (this.hasPerk(PerkLib.IcyFlesh) || this.hasPerk(PerkLib.HaltedVitals)) {
			return 1;
		} else {
			return touStat.value;
		}
		}

		public function get spe():Number { return speStat.value; }
		public function get inte():Number { return intStat.value; }
		public function get wis():Number { return Math.round(wisStat.value); }
		public function get lib():Number { return Math.round(libStat.value); }

		public function trainStat(statName: String, amount: Number, limit: Number):void {
			var stat:PrimaryStat = statStore.findStat(statName) as PrimaryStat;
			if (stat.core.value < limit){
				stat.core.value += amount;
				if (stat.core.value > limit){
					stat.core.value = limit;
				} else{
					CoC.instance.mainView.statsView.refreshStats(CoC.instance);
					CoC.instance.mainView.statsView.showStatUp(statName);
				}
			}
		}

		public function addCurse(statName:String, power:Number):void {
			if (this.hasPerk(PerkLib.ZenjisInfluence2)) power *= 0.60;
			if (statName == "sens" || statName == "cor") {
				statStore.addBuff(statName, power, 'Curse', {text: 'Curse'});
				CoC.instance.mainView.statsView.refreshStats(CoC.instance);
				CoC.instance.mainView.statsView.showStatUp(statName);
			} else {
				statStore.addBuff(statName, -power, 'Curse', {text: 'Curse'});
				CoC.instance.mainView.statsView.refreshStats(CoC.instance);
				CoC.instance.mainView.statsView.showStatDown(statName);
			}
		}
		public function removeCurse(statName:String, power:Number):void {
			var stat:BuffableStat = statStore.findBuffableStat(statName);
			if (!stat) {
				// Error? No stat with such name
				throw new Error("No such stat "+statName);
			}
			var current:Number = stat.valueOfBuff('Curse');
			if (statName == "sens" || statName == "cor") {
				if (current >0){
					if (power*2 >= current) {
						stat.removeBuff('Curse');
						CoC.instance.mainView.statsView.refreshStats(CoC.instance);
						CoC.instance.mainView.statsView.showStatDown(statName);
					} else if (power*2 < current) {
						stat.addOrIncreaseBuff('Curse', -power*2);
						CoC.instance.mainView.statsView.refreshStats(CoC.instance);
						CoC.instance.mainView.statsView.showStatUp(statName);
					}
				}
			}
			else {
				if (current < 0) {
					if (power*2 >= -current) {
						stat.removeBuff('Curse');
						CoC.instance.mainView.statsView.refreshStats(CoC.instance);
						CoC.instance.mainView.statsView.showStatUp(statName);
					} else if (power*2 < -current) {
						stat.addOrIncreaseBuff('Curse', power*2);
						CoC.instance.mainView.statsView.refreshStats(CoC.instance);
						CoC.instance.mainView.statsView.showStatDown(statName);
					}
				}
			}
		}

		//Primary stats
		public function get sens():Number { return sensStat.value; }
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

		public function get str100():Number { return 100*str/strStat.max; }
		public function get tou100():Number { return 100*tou/touStat.max; }
		public function get spe100():Number { return 100*spe/speStat.max; }
		public function get inte100():Number { return 100*inte/intStat.max; }
		public function get wis100():Number { return 100*wis/wisStat.max; }
		public function get lib100():Number { return 100*lib/libStat.max; }
		public function get sens100():Number { return 100*sens/sensStat.max; }
		public function get fatigue100():Number { return 100*fatigue/maxFatigue(); }
		public function get hp100():Number { return 100*HP/maxHP(); }
		public function get wrath100():Number { return 100*wrath/maxWrath(); }
		public function get mana100():Number { return 100*mana/maxMana(); }
		public function get soulforce100():Number { return 100*soulforce/maxSoulforce(); }
		public function get lust100():Number { return 100*lust/maxLust(); }

		public function minLust():Number {
			return 0;
		}
		public function minLib():Number {
			return 1;
		}
		public function minSens():Number {
			return 10;
		}
		protected function maxHP_base():Number {
			var max:Number = 0;
			var multimax:Number = 1;
			if (hasPerk(PerkLib.IcyFlesh)) {
				max += int(inte * 2 + 50);
				if (inte >= 21) max += Math.round(inte);
				if (inte >= 41) max += Math.round(inte);
				if (inte >= 61) max += Math.round(inte);
				if (inte >= 81) max += Math.round(inte);
				if (inte >= 101) max += Math.round(inte) * Math.floor( (inte-100)/50 + 1);
				if (hasPerk(PerkLib.FrozenHeartFinalForm)) max *= 1.5;
			}
			else if (hasPerk(PerkLib.HaltedVitals)) {
				max += int(lib * 2 + 50);
				if (lib >= 21) max += Math.round(lib);
				if (lib >= 41) max += Math.round(lib);
				if (lib >= 61) max += Math.round(lib);
				if (lib >= 81) max += Math.round(lib);
				if (lib >= 101) max += Math.round(lib) * Math.floor( (lib-100)/50 + 1);
			}
			else {
				max += int(tou * 2 + 50);
				if (tou >= 21) max += Math.round(tou);
				if (tou >= 41) max += Math.round(tou);
				if (tou >= 61) max += Math.round(tou);
				if (tou >= 81) max += Math.round(tou);
				if (tou >= 101) max += Math.round(tou) * Math.floor( (tou-100)/50 + 1);
			}
			if (hasPerk(PerkLib.IcyFlesh)) {
				if (hasPerk(PerkLib.FrozenHeartFinalForm)) {
					if (hasPerk(PerkLib.TankI)) max += Math.round(inte*18);
					if (hasPerk(PerkLib.TankII)) max += Math.round(inte*18);
					if (hasPerk(PerkLib.TankIII)) max += Math.round(inte*18);
					if (hasPerk(PerkLib.TankIV)) max += Math.round(inte*18);
					if (hasPerk(PerkLib.TankV)) max += Math.round(inte*18);
					if (hasPerk(PerkLib.TankVI)) max += Math.round(inte*18);
				}
				else {
					if (hasPerk(PerkLib.TankI)) max += Math.round(inte*12);
					if (hasPerk(PerkLib.TankII)) max += Math.round(inte*12);
					if (hasPerk(PerkLib.TankIII)) max += Math.round(inte*12);
					if (hasPerk(PerkLib.TankIV)) max += Math.round(inte*12);
					if (hasPerk(PerkLib.TankV)) max += Math.round(inte*12);
					if (hasPerk(PerkLib.TankVI)) max += Math.round(inte*12);
				}
			}
			else {
				if (hasPerk(PerkLib.TankI)) max += Math.round(tou*12);
				if (hasPerk(PerkLib.TankII)) max += Math.round(tou*12);
				if (hasPerk(PerkLib.TankIII)) max += Math.round(tou*12);
				if (hasPerk(PerkLib.TankIV)) max += Math.round(tou*12);
				if (hasPerk(PerkLib.TankV)) max += Math.round(tou*12);
				if (hasPerk(PerkLib.TankVI)) max += Math.round(tou*12);
			}
			if (hasPerk(PerkLib.GoliathI)) max += Math.round(str*8);
			if (hasPerk(PerkLib.GoliathII)) max += Math.round(str*8);
			if (hasPerk(PerkLib.GoliathIII)) max += Math.round(str*8);
			if (hasPerk(PerkLib.GoliathIV)) max += Math.round(str*8);
			if (hasPerk(PerkLib.GoliathV)) max += Math.round(str*8);
			if (hasPerk(PerkLib.GoliathVI)) max += Math.round(str*8);
			if (hasPerk(PerkLib.CheetahI)) max += Math.round(spe*4);
			if (hasPerk(PerkLib.CheetahII)) max += Math.round(spe*4);
			if (hasPerk(PerkLib.CheetahIII)) max += Math.round(spe*4);
			if (hasPerk(PerkLib.CheetahIV)) max += Math.round(spe*4);
			if (hasPerk(PerkLib.CheetahV)) max += Math.round(spe*4);
			if (hasPerk(PerkLib.CheetahVI)) max += Math.round(spe*4);
			if (hasPerk(PerkLib.ElementalBondFlesh)) {
				if (hasStatusEffect(StatusEffects.SummonedElementalsAir)) max += maxHP_ElementalBondFleshMulti() * 4 * statusEffectv2(StatusEffects.SummonedElementalsAir);
				if (hasStatusEffect(StatusEffects.SummonedElementalsEarth)) max += maxHP_ElementalBondFleshMulti() * 4 * statusEffectv2(StatusEffects.SummonedElementalsEarth);
				if (hasStatusEffect(StatusEffects.SummonedElementalsFire)) max += maxHP_ElementalBondFleshMulti() * 4 * statusEffectv2(StatusEffects.SummonedElementalsFire);
				if (hasStatusEffect(StatusEffects.SummonedElementalsWater)) max += maxHP_ElementalBondFleshMulti() * 4 * statusEffectv2(StatusEffects.SummonedElementalsWater);
				if (hasStatusEffect(StatusEffects.SummonedElementalsEther)) max += maxHP_ElementalBondFleshMulti() * 4 * statusEffectv2(StatusEffects.SummonedElementalsEther);
				if (hasStatusEffect(StatusEffects.SummonedElementalsWood)) max += maxHP_ElementalBondFleshMulti() * 4 * statusEffectv2(StatusEffects.SummonedElementalsWood);
				if (hasStatusEffect(StatusEffects.SummonedElementalsMetal)) max += maxHP_ElementalBondFleshMulti() * 4 * statusEffectv2(StatusEffects.SummonedElementalsMetal);
				if (hasStatusEffect(StatusEffects.SummonedElementalsIce)) max += maxHP_ElementalBondFleshMulti() * 4 * statusEffectv2(StatusEffects.SummonedElementalsIce);
				if (hasStatusEffect(StatusEffects.SummonedElementalsLightning)) max += maxHP_ElementalBondFleshMulti() * 4 * statusEffectv2(StatusEffects.SummonedElementalsLightning);
				if (hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) max += maxHP_ElementalBondFleshMulti() * 4 * statusEffectv2(StatusEffects.SummonedElementalsDarkness);
				if (hasStatusEffect(StatusEffects.SummonedElementalsPoison)) max += maxHP_ElementalBondFleshMulti() * 4 * statusEffectv2(StatusEffects.SummonedElementalsPoison);
				if (hasStatusEffect(StatusEffects.SummonedElementalsPurity)) max += maxHP_ElementalBondFleshMulti() * 4 * statusEffectv2(StatusEffects.SummonedElementalsPurity);
				if (hasStatusEffect(StatusEffects.SummonedElementalsCorruption)) max += maxHP_ElementalBondFleshMulti() * 4 * statusEffectv2(StatusEffects.SummonedElementalsCorruption);
			}
			if (hasPerk(PerkLib.JobGuardian)) max += 120;
			if (hasPerk(PerkLib.BodyCultivator)) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.FleshBodyApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) max += (200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (hasPerk(PerkLib.SoulPersonage)) max += (200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (hasPerk(PerkLib.SoulWarrior)) max += (200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (hasPerk(PerkLib.FleshBodyWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) max += (300 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (hasPerk(PerkLib.SoulScholar)) max += (300 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (hasPerk(PerkLib.SoulElder)) max += (300 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (hasPerk(PerkLib.FleshBodyElderStage)) {
				if (hasPerk(PerkLib.SoulExalt)) max += (400 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (hasPerk(PerkLib.SoulOverlord)) max += (400 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (hasPerk(PerkLib.SoulTyrant)) max += (400 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (hasPerk(PerkLib.FleshBodyOverlordStage)) {
				if (hasPerk(PerkLib.SoulKing)) max += (500 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (hasPerk(PerkLib.SoulEmperor)) max += (500 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (hasPerk(PerkLib.SoulAncestor)) max += (500 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) max += (600 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) max += (900 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) max += (1200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) max += (1500 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.AscensionHardiness)) max += perkv1(PerkLib.AscensionHardiness) * 400;
			if (hasPerk(PerkLib.ChiReflowDefense)) max += UmasShop.NEEDLEWORK_DEFENSE_EXTRA_HP;
			max += level * 60;
			if (level <= 6) max += level * 60;
			if (hasPerk(PerkLib.UnlockBody)) max += level * 60;
			if (hasPerk(PerkLib.UnlockBody2ndStage)) max += level * 60;
			if (hasPerk(PerkLib.UnlockBody3rdStage)) max += level * 60;
			if (hasPerk(PerkLib.UnlockBody4thStage)) max += level * 60;
			if (hasPerk(PerkLib.AscensionUnlockedPotential) >= 0) max += level * 80;
			if (hasPerk(PerkLib.AscensionUnlockedPotential3rdStage) >= 0) max += level * 80;
			if (jewelryEffectId == JewelryLib.MODIFIER_HP) max += jewelryEffectMagnitude;
			if (jewelryEffectId2 == JewelryLib.MODIFIER_HP) max += jewelryEffectMagnitude2;
			if (jewelryEffectId3 == JewelryLib.MODIFIER_HP) max += jewelryEffectMagnitude3;
			if (jewelryEffectId4 == JewelryLib.MODIFIER_HP) max += jewelryEffectMagnitude4;
			if (hasPerk(PerkLib.RefinedBodyI)) multimax += 0.05;
			if (hasPerk(PerkLib.RefinedBodyII)) multimax += 0.05;
			if (hasPerk(PerkLib.RefinedBodyIII)) multimax += 0.05;
			if (hasPerk(PerkLib.RefinedBodyIV)) multimax += 0.05;
			if (hasPerk(PerkLib.RefinedBodyV)) multimax += 0.05;
			if (hasPerk(PerkLib.RefinedBodyVI)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerBody1stStage)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerBody2ndStage)) multimax += 0.1;
			if (hasPerk(PerkLib.DeityJobMunchkin)) multimax += 0.2;
			max *= multimax;
			max = Math.round(max);
			return max;
		}
		protected function maxHP_mult():Number {
			var maxHP_mult1:Number = 1;
			maxHP_mult1 += (countCockSocks("green") * 0.02);
			if (game.player.dragonScore() >= 5) maxHP_mult1 += 0.05;
			if (game.player.dragonScore() >= 16) maxHP_mult1 += 0.05;
			if (game.player.dragonScore() >= 24) maxHP_mult1 += 0.1;
			if (game.player.dragonScore() >= 32) maxHP_mult1 += 0.1;
			if (game.player.vehiclesName == "Goblin Mech Alpha") {
				if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) maxHP_mult1 += 0.2;
				if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) maxHP_mult1 += 0.35;
				if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) maxHP_mult1 += 0.5;
			}
			if (game.player.vehiclesName == "Goblin Mech Prime") {
				if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) maxHP_mult1 += 0.4;
				if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) maxHP_mult1 += 0.7;
				if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) maxHP_mult1 += 1;
			}
			if (game.player.vehiclesName == "Giant Slayer Mech") {
				if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) maxHP_mult1 += 0.25;
				if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) maxHP_mult1 += 0.5;
				if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) maxHP_mult1 += 0.75;
				if (game.player.hasKeyItem("Upgraded Leather Insulation 1.0") >= 0) maxHP_mult1 += 0.25;
				if (game.player.hasKeyItem("Upgraded Leather Insulation 2.0") >= 0) maxHP_mult1 += 0.5;
				if (game.player.hasKeyItem("Upgraded Leather Insulation 3.0") >= 0) maxHP_mult1 += 0.75;
			}
			if (game.player.vehiclesName == "Howling Banshee Mech") {
				if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) maxHP_mult1 += 0.25;
				if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) maxHP_mult1 += 0.5;
				if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) maxHP_mult1 += 0.75;
			}
			return maxHP_mult1;
		}
		public function maxHP():Number {
			var max:Number = Math.round(maxHP_base()*maxHP_mult());
			return Math.min(9999999,max);
		}
		public function maxOverHP():Number {
			var maxOver:Number = maxHP();
			if (hasPerk(PerkLib.HiddenJobBloodDemon)) {
				if (hasPerk(PerkLib.IcyFlesh)) maxOver += Math.round(inte * 10);
				else maxOver += Math.round(tou * 10);
			}
			if (hasPerk(PerkLib.WayOfTheBlood)) {
				if (hasPerk(PerkLib.IcyFlesh)) maxOver += Math.round(inte * 10);
				else maxOver += Math.round(tou * 10);
			}
			if (hasPerk(PerkLib.YourPainMyPower)) {
				if (hasPerk(PerkLib.IcyFlesh)) maxOver += Math.round(inte * 10);
				else maxOver += Math.round(tou * 10);
			}
			if (hasPerk(PerkLib.MyBloodForBloodPuppies)) {
				if (hasPerk(PerkLib.IcyFlesh)) maxOver += Math.round(inte * 10);
				else maxOver += Math.round(tou * 10);
			}
			if (hasPerk(PerkLib.BloodDemonToughness)) {
				if (hasPerk(PerkLib.IcyFlesh)) maxOver += Math.round(inte * 10);
				else maxOver += Math.round(tou*10);
			}
			//
			if (hasPerk(PerkLib.BloodDemonWisdom)) {
				if (hasPerk(PerkLib.IcyFlesh)) maxOver += Math.round(inte * 10);
				else maxOver += Math.round(tou*10);
			}
			//
			if (hasPerk(PerkLib.BloodDemonIntelligence)) {
				if (hasPerk(PerkLib.IcyFlesh)) maxOver += Math.round(inte * 10);
				else maxOver += Math.round(tou*10);
			}
			return Math.min(19999999,maxOver);
		}
		public function minHP():Number {
			return 0;
		}
		protected function maxLust_base():Number {
			var max:Number = 100;
			var multimax:Number = 1;
			if (hasPerk(PerkLib.InhumanDesireI)) max += Math.round(lib*3);
			if (hasPerk(PerkLib.InhumanDesireII)) max += Math.round(lib*3);
			if (hasPerk(PerkLib.InhumanDesireIII)) max += Math.round(lib*3);
			if (hasPerk(PerkLib.InhumanDesireIV)) max += Math.round(lib*3);
			if (hasPerk(PerkLib.InhumanDesireV)) max += Math.round(lib*3);
			if (hasPerk(PerkLib.InhumanDesireVI)) max += Math.round(lib*3);
			if (hasPerk(PerkLib.BasicSelfControl)) max += 45;
			if (hasPerk(PerkLib.HalfStepToImprovedSelfControl)) max += 75;
			if (hasPerk(PerkLib.ImprovedSelfControl)) max += 120;
			if (hasPerk(PerkLib.HalfStepToAdvancedSelfControl)) max += 180;
			if (hasPerk(PerkLib.AdvancedSelfControl)) max += 300;
			if (hasPerk(PerkLib.HalfStepToSuperiorSelfControl)) max += 480;
			if (hasPerk(PerkLib.SuperiorSelfControl)) max += 750;
			if (hasPerk(PerkLib.HalfStepToPeerlessSelfControl)) max += 1050;
			if (hasPerk(PerkLib.PeerlessSelfControl)) max += 1500;
			if (hasPerk(PerkLib.HalfStepToInhumanSelfControl)) max += 2250;
			if (hasPerk(PerkLib.InhumanSelfControl)) max += 3000;
			if (hasPerk(PerkLib.HalfStepToEpicSelfControl)) max += 4500;
			if (hasPerk(PerkLib.EpicSelfControl)) max += 6750;
			if (hasPerk(PerkLib.HalfStepToLegendarySelfControl)) max += 10500;
			if (hasPerk(PerkLib.LegendarySelfControl)) max += 15000;
			if (hasPerk(PerkLib.HalfStepToMythicalSelfControl)) max += 22500;
			if (hasPerk(PerkLib.MythicalSelfControl)) max += 30000;
			if (hasPerk(PerkLib.Mage)) max += 15;
			if (hasPerk(PerkLib.GrandMage)) max += 30;
			if (hasPerk(PerkLib.Archmage)) max += 45;
			if (hasPerk(PerkLib.GrandArchmage)) max += 60;
			if (hasPerk(PerkLib.GrandArchmage2ndCircle)) max += 75;
			if (hasPerk(PerkLib.GrandArchmage3rdCircle)) max += 90;
			if (hasPerk(PerkLib.GreyMage)) max += 120;
			if (hasPerk(PerkLib.GreyArchmage)) max += 150;
			if (hasPerk(PerkLib.ElementalBondUrges)) {
				if (hasStatusEffect(StatusEffects.SummonedElementalsAir)) max += maxLust_ElementalBondUrgesMulti() * 3 * statusEffectv2(StatusEffects.SummonedElementalsAir);
				if (hasStatusEffect(StatusEffects.SummonedElementalsEarth)) max += maxLust_ElementalBondUrgesMulti() * 3 * statusEffectv2(StatusEffects.SummonedElementalsEarth);
				if (hasStatusEffect(StatusEffects.SummonedElementalsFire)) max += maxLust_ElementalBondUrgesMulti() * 3 * statusEffectv2(StatusEffects.SummonedElementalsFire);
				if (hasStatusEffect(StatusEffects.SummonedElementalsWater)) max += maxLust_ElementalBondUrgesMulti() * 3 * statusEffectv2(StatusEffects.SummonedElementalsWater);
				if (hasStatusEffect(StatusEffects.SummonedElementalsEther)) max += maxLust_ElementalBondUrgesMulti() * 3 * statusEffectv2(StatusEffects.SummonedElementalsEther);
				if (hasStatusEffect(StatusEffects.SummonedElementalsWood)) max += maxLust_ElementalBondUrgesMulti() * 3 * statusEffectv2(StatusEffects.SummonedElementalsWood);
				if (hasStatusEffect(StatusEffects.SummonedElementalsMetal)) max += maxLust_ElementalBondUrgesMulti() * 3 * statusEffectv2(StatusEffects.SummonedElementalsMetal);
				if (hasStatusEffect(StatusEffects.SummonedElementalsIce)) max += maxLust_ElementalBondUrgesMulti() * 3 * statusEffectv2(StatusEffects.SummonedElementalsIce);
				if (hasStatusEffect(StatusEffects.SummonedElementalsLightning)) max += maxLust_ElementalBondUrgesMulti() * 3 * statusEffectv2(StatusEffects.SummonedElementalsLightning);
				if (hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) max += maxLust_ElementalBondUrgesMulti() * 3 * statusEffectv2(StatusEffects.SummonedElementalsDarkness);
				if (hasStatusEffect(StatusEffects.SummonedElementalsPoison)) max += maxLust_ElementalBondUrgesMulti() * 3 * statusEffectv2(StatusEffects.SummonedElementalsPoison);
				if (hasStatusEffect(StatusEffects.SummonedElementalsPurity)) max += maxLust_ElementalBondUrgesMulti() * 3 * statusEffectv2(StatusEffects.SummonedElementalsPurity);
				if (hasStatusEffect(StatusEffects.SummonedElementalsCorruption)) max += maxLust_ElementalBondUrgesMulti() * 3 * statusEffectv2(StatusEffects.SummonedElementalsCorruption);
			}
			if (hasPerk(PerkLib.BroBody) || hasPerk(PerkLib.BimboBody) || hasPerk(PerkLib.FutaForm)) max += 60;
			if (hasPerk(PerkLib.OmnibusGift)) max += 45;
			if (hasPerk(PerkLib.JobCourtesan)) max += 60;
			if (hasPerk(PerkLib.JobSeducer)) max += 30;
			if (hasPerk(PerkLib.PrestigeJobGreySage)) max += 300;
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) max += (150 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) max += (225 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) max += (300 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) max += (375 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.AscensionDesires)) max += perkv1(PerkLib.AscensionDesires) * 30;
			max += level * 3;
			if (level <= 6) max += level * 3;
			if (hasPerk(PerkLib.UnlockArdor)) max += level * 3;
			if (hasPerk(PerkLib.UnlockArdor2ndStage)) max += level * 3;
			if (hasPerk(PerkLib.UnlockArdor3rdStage)) max += level * 3;
			if (hasPerk(PerkLib.UnlockArdor4thStage)) max += level * 3;
			if (hasPerk(PerkLib.AscensionUnlockedPotential)) max += level * 6;
			if (hasPerk(PerkLib.AscensionUnlockedPotential3rdStage)) max += level * 6;
			if (hasPerk(PerkLib.DemonicDesireI)) multimax += 0.05;
			if (hasPerk(PerkLib.DemonicDesireII)) multimax += 0.05;
			if (hasPerk(PerkLib.DemonicDesireIII)) multimax += 0.05;
			if (hasPerk(PerkLib.DemonicDesireVI)) multimax += 0.05;
			if (hasPerk(PerkLib.DemonicDesireV)) multimax += 0.05;
			if (hasPerk(PerkLib.DemonicDesireVI)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerHeart1stStage)) multimax += 0.05;
			if (hasPerk(PerkLib.LimitBreakerHeart2ndStage)) multimax += 0.1;
			if (hasPerk(PerkLib.DeityJobMunchkin)) multimax += 0.2;
			max *= multimax;
			max = Math.round(max);
			return max;
		}
		protected function maxHP_ElementalBondFleshMulti():Number {
			var multiValue1a:Number = 1;
			multiValue1a += (0.2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			multiValue1a *= 25;
			return multiValue1a;
		}
		protected function maxLust_ElementalBondUrgesMulti():Number {
			var multiValue1b:Number = 1;
			multiValue1b += (0.2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			multiValue1b *= 5;
			return multiValue1b;
		}
		public function maxLust_mult():Number {
			return 1;
		}
		public function maxLust():Number {
			var max:Number = Math.round(maxLust_base()*maxLust_mult());
			return Math.min(199999,max);
		}
		public function maxFatigue():Number {
			return 150;
		}
		public function maxWrath():Number {
			return 0;
		}
		public function maxOverWrath():Number {
			return 0;
		}
		public function maxSoulforce():Number {
			return 0;
		}
		public function maxMana():Number {
			return 0;
		}
		/**
		 * @return keys: str, tou, spe, inte, wis, lib, sens, cor
		 */
		public function getAllMinStats():Object {
			return {
				str:1,
				tou:1,
				spe:1,
				inte:1,
				wis:1,
				lib:1,
				sens:10,
				cor:0
			};
		}
		/**
		 * Modify stats.
		 *
		 * Arguments should come in pairs nameOp:String, value:Number/Boolean <br/>
		 * where nameOp is ( stat_name + [operator] ) and value is operator argument<br/>
		 * valid operators are "=" (set), "+", "-", "*", "/", add is default.<br/>
		 * valid stat_names are "str", "tou", "spe", "int", "wis", "lib", "sen", "lus", "cor" or their full names;
		 * also "scaled"/"scale"/"sca" (default true: apply resistances, perks; false - force values)
		 *
		 * @return Object of (newStat-oldStat) with keys str, tou, spe, inte, wis, lib, sens, lust, cor
		 * */
		public function dynStats(... args):Object {
			Begin("Creature","dynStats");
			var argz:Object = parseDynStatsArgs(this, args);
			var prevStr:Number  = str;
			var prevTou:Number  = tou;
			var prevSpe:Number  = spe;
			var prevInte:Number  = inte;
			var prevWis:Number  = wis;
			var prevLib:Number  = lib;
			var prevSens:Number  = sens;
			var prevLust:Number  = lust;
			var prevCor:Number  = cor;
			modStats(argz.str, argz.tou, argz.spe, argz.inte, argz.wis, argz.lib, argz.sens, argz.lust, argz.cor, argz.scale, argz.max);
			End("Creature","dynStats");
			//trace("dynStats("+args.join(", ")+") => ("+[str,tou,spe,inte,wis,lib,sens,lust,cor].join(", ")+")");
			return {
				str:str-prevStr,
				tou:tou-prevTou,
				spe:spe-prevSpe,
				inte:inte-prevInte,
				wis:wis-prevWis,
				lib:lib-prevLib,
				sens:sens-prevSens,
				lust:lust-prevLust,
				cor:cor-prevCor
			};
		}
		public function modStats(dstr:Number, dtou:Number, dspe:Number, dint:Number, dwis:Number, dlib:Number, dsens:Number, dlust:Number, dcor:Number, scale:Boolean, max:Boolean):void {
			var maxes:Object;
			//if (max) {
			//	maxes.lust = maxLust();
			//}
			var mins:Object = getAllMinStats();
			mins.lust = minLust();
			var oldHPratio:Number = hp100/100;
			//Strength
			if (dstr < 0){
				addCurse("str", -dstr);
			}
			if (dstr > 0){
				removeCurse("str", dstr);
			}
			//toughness
			if (dtou < 0){
				addCurse("tou", -dtou);
			}
			if (dtou > 0){
				removeCurse("tou", dtou);
			}
			//Speed
			if (dspe < 0){
				addCurse("spe", -dspe);
			}
			if (dspe > 0){
				removeCurse("spe", dspe);
			}
			//Intelligence
			if (dint < 0){
				addCurse("int", -dint);
			}
			if (dint > 0){
				removeCurse("int", dint);
			}
			//Wisdom
			if (dwis < 0){
				addCurse("wis", -dwis);
			}
			if (dwis > 0){
				removeCurse("wis", dwis);
			}
			//Libido
			if (dlib < 0){
				addCurse("lib", -dlib);
			}
			if (dlib > 0){
				removeCurse("lib", dlib);
			}
			//Sensitivity
			if (dsens > 0){
				addCurse("sens", dsens);
			}
			if (dsens < 0){
				removeCurse("sens", -dsens);
			}
			lust = Utils.boundFloat(mins.lust, lust + dlust, maxLust());
			cor  = Utils.boundFloat(mins.cor, cor + dcor, 100);

			// old_hp / old_max = new_hp / new_max
			HP = oldHPratio * maxHP();

			// Keep values in bounds (lust and HP handled above)
			fatigue = Math.min(fatigue, maxFatigue());
			mana = Math.min(mana, maxMana());
			soulforce = Math.min(soulforce, maxSoulforce());
			wrath = Math.min(wrath,maxWrath());
		}
		// Lust gain, in % (100 = receive as is, 25 = receive one fourth, 0 = immune)
		public function lustPercent():Number {
			return 100;
		}
		public function takePhysDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takeMagicDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takeFireDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takeIceDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takeLightningDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takeDarknessDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takePoisonDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takeLustDamage(lustDmg:Number, display:Boolean = true, applyRes:Boolean = true):Number{
			if (applyRes) lustDmg *= lustPercent()/100;
			lust = boundFloat(minLust(),lust+Math.round(lustDmg),maxLust());
			return (lustDmg > 0 && lustDmg < 1) ? 1 : lustDmg;
		}
		/**
		 * Get the remaining fatigue of the Creature.
		 * @return maximum amount of fatigue that still can be used
		 */
		public function fatigueLeft():Number
		{
			return maxFatigue() - fatigue;
		}

		/*

		[    A P P E A R A N C E    ]

		*/

		//Appearance Variables
		//Gender 1M, 2F, 3H
		public function get gender():int {
			if (hasCock() && hasVagina()) return Gender.GENDER_HERM;
			if (hasCock()) return Gender.GENDER_MALE;
			if (hasVagina()) return Gender.GENDER_FEMALE;
			return Gender.GENDER_NONE;
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
		public var hairType:Number = Hair.NORMAL;
		public var hairStyle:Number = Hair.NORMAL;
		private var _hairColor:String = "no";
		public var hairLength:Number = 0;
		public function get hairColor():String {
			return _hairColor;
		}
		public function set hairColorOnly(value:String):void {
			_hairColor = value;
		}

		public function set hairColor(value:String):void {
			_hairColor = value;
			if (!skin.hasCoat()) skin.coat.color = value;
		}

		public function get coatColor():String {
			if (!skin.hasCoat()) return hairColor;
			return skin.coat.color;
		}
		public function get coatColor2():String {
			if (!skin.hasCoat()) return hairColor;
			return skin.coat.color2;
		}
		public function get NakedCoatColor():String {
			return skin.coat.color;
		}
		public function set coatColor(value:String):void {
			if (!skin.hasCoat()) trace("[WARNING] set coatColor() called with no coat");
			skin.coat.color = value;
		}
		public function set coatColor2(value:String):void {
			if (!skin.hasCoat()) trace("[WARNING] set coatColor() called with no coat");
			skin.coat.color2 = value;
		}

		public var beardStyle:Number = Beard.NORMAL;
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
		public function hasCoatOfType(...types:Array):Boolean { return skin.hasCoatOfType.apply(skin,types); }
		public function hasFullCoatOfType(...types:Array):Boolean { return skin.hasFullCoatOfType.apply(skin,types); }
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
		public var ears:Ears = new Ears();
		public var horns:Horns = new Horns();
		public var wings:Wings = new Wings();

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


		public var hips:Hips = new Hips();
		public var butt:Butt = new Butt();

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
		public var antennae:Antennae = new Antennae();
		public var eyes:Eyes = new Eyes();
		public var tongue:Tongue = new Tongue();
		public var arms:Arms = new Arms();

		public var gills:Gills = new Gills();
		public function hasGills():Boolean { return gills.type != Gills.NONE; }

		public var rearBody:RearBody = new RearBody();

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
		public var breastRows:/*BreastRowClass*/Array;
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
			strStat = new PrimaryStat(this,'str');
			touStat = new PrimaryStat(this,'tou');
			speStat = new PrimaryStat(this,'spe');
			intStat = new PrimaryStat(this,'int');
			wisStat = new PrimaryStat(this,'wis');
			libStat = new PrimaryStat(this,'lib');
			sensStat = new BuffableStat(this,'sens', {base:15, min:0});

			_stats = new StatStore({
				'str': strStat,
				'tou': touStat,
				'spe': speStat,
				'int': intStat,
				'wis': wisStat,
				'lib': libStat,
				'sens': sensStat
			});

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
			_perks        = new PerkManager(this);
			_statusEffects = new StatusEffectManager(this);
			this.strStat.core.value = 15;
			this.touStat.core.value = 15;
			this.speStat.core.value = 15;
			this.intStat.core.value = 15;
			this.wisStat.core.value = 15;
			this.libStat.core.value = 15;
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
				"tallness", "hips.type", "butt.type", "lowerBody", "arms.type",
				"hairLength", "hairType",
				"faceType", "ears.type", "tongue.type", "eyes.type",
				"str", "tou", "spe", "inte", "wis", "lib", "sens", "cor",
				// Allow weaponAttack to be negative as a penalty to strength-calculated damage
				// Same with armorDef, bonusHP, additionalXP
				"weaponValue", "armorValue",
				"lust", "fatigue", "soulforce", "mana", "wrath",
				"level", "gems",
				"tailCount", "tailVenom", "tailRecharge", "horns.type",
				"HP", "XP"
			]);
			// 2.2. non-empty String fields
			error += Utils.validateNonEmptyStringFields(this,"Monster.validate",[
				"short",
				"skinDesc", "eyes.colour",
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
				if (hairType != Hair.NORMAL) error += "No hair but hairType = " + hairType + ". ";
			}
			// 4.3. tail
			if (tailType == Tail.NONE) {
				if (tailCount != 0) error += "No tail but tailCount = "+tailCount+". ";
			}
			// 4.4. horns
			if (horns.type == Horns.NONE){
				if (horns.count > 0) error += "horns > 0 but horns.type = NONE. ";
			} else {
				if (horns.count == 0) error += "Has horns but their number 'horns' = 0. ";
			}
			return error;
		}

		/*

		[        P E R K S          ]

		*/
		//Monsters have few perks, which I think should be a status effect for clarity's sake.
		//TODO: Move perks into monster status effects.
		private var _perks:PerkManager;

		public function get perkManager():PerkManager
		{
			return this._perks;
		}

		/**
		 * STOP USING THIS! Use getPerk instead!
		 * @deprecated
		 * @param i
		 * @return
		 */
		public function perk(i:int):PerkClass {
			return _perks.asArray()[i];
		}

		/**
		 * Perks as an array. Only use this when needing a full list of active perks.
		 * If searching for a perk, use hasPerk or getPerk instead.
		 */
		public function get perks():Array {
			return _perks.asArray();
		}

		/**
		 * Get count of active perks
		 * @return {Number} Number of active perks.
		 */
		public function get numPerks():int {
			return _perks.count();
		}

		//Functions

		//Create a perk
		public function createPerk(ptype:PerkType, value1:Number, value2:Number, value3:Number, value4:Number):void
		{
			this._perks.createPerk(ptype, value1, value2, value3, value4);
		}

		public function addPerkInstance(pclass:PerkClass):void {
			this._perks.add(pclass);
		}

		/**
		 * Remove perk. Return true if there was such perk
		 */
		public function removePerk(ptype:PerkType):Boolean
		{
			return this._perks.remove(ptype);
		}

		/**
		 * STOP USING THIS! Use Creature.hasPerk or Creature.getPerk instead!
		 * Perks are no longer stored as an array this is an extremely slow compatibility measure.
		 * @deprecated
		 * @see Creature.hasPerk
		 * @see Creature.getPerk
		 * @param ptype
		 * @return {Number} Index of perk in array if it exists. -1 if perk does not exist.
		 */
		public function findPerk(ptype:PerkType):Number
		{
			var perk:PerkClass = this._perks.get(ptype);
			if (perk) {
				return this._perks.asArray().indexOf(perk);
			}
			return -1;
		}

		/**
		 * Check if this creature has a perk.
		 * @param ptype {PerkType}
		 * @return {Boolean} True if creature has the perk, otherwise false.
		 */
		public function hasPerk(ptype:PerkType):Boolean {
			return this._perks.has(ptype);
		}

		/**
		 * Get the instance of a perk.
		 * @param {PerkType} ptype
		 */
		public function getPerk(ptype:PerkType):PerkClass {
			return this._perks.get(ptype);
		}

		/**
		 * Check if a perk is duplicated.
		 * Always returns false as PerkManager forbids duplicates. Attempting to add an existing perk keeps the original
		 * perk and aborts adding the new one.
		 * @deprecated
		 * @return {Boolean} False.
		 */
		public function perkDuplicated(ptype:PerkType):Boolean
		{
			return false;
		}

		//remove all perks
		public function removePerks():void
		{
			for each(var pc:PerkClass in _perks.asArray()){
				this._perks.remove(pc.ptype);
			}
			_perks.clear(); // Clean up anything else, just in case.
		}

		public function addPerkValue(ptype:PerkType, valueIdx:Number = 1, bonus:Number = 0): void
		{
			this._perks.addPerkValue(ptype, valueIdx, bonus);
		}

		public function setPerkValue(ptype:PerkType, valueIdx:Number = 1, newNum:Number = 0): void
		{
			this._perks.setPerkValue(ptype, valueIdx, newNum);
		}

		public function perkv1(ptype:PerkType):Number
		{
			return this._perks.getPerkValue(ptype, 1);
		}

		public function perkv2(ptype:PerkType):Number
		{
			return this._perks.getPerkValue(ptype, 2);
		}

		public function perkv3(ptype:PerkType):Number
		{
			return this._perks.getPerkValue(ptype, 3);
		}

		public function perkv4(ptype:PerkType):Number
		{
			return this._perks.getPerkValue(ptype, 4);
		}
		/*

		[    S T A T U S   E F F E C T S    ]

		*/
		//{region StatusEffects

		//Current status effects. This has got very muddy between perks and status effects. Will have to look into it.
		//Someone call the grammar police!
		//TODO: Move monster status effects into perks. Needs investigation though.
		private var _statusEffects:StatusEffectManager;

		//Current status effects. This has got very muddy between perks and status effects. Will have to look into it.
		//Someone call the grammar police!
		//TODO: Move monster status effects into perks. Needs investigation though.
		/**
		 * List of all status effects.
		 */
		public function get statusEffects():Array {
			return this._statusEffects.asArray();
		}
		public function createOrFindStatusEffect(stype:StatusEffectType):StatusEffectClass
		{
			return this._statusEffects.createOrFindStatusEffect(stype);
		}
		public function createStatusEffect(stype:StatusEffectType, value1:Number, value2:Number, value3:Number, value4:Number, fireEvent:Boolean = true):StatusEffectClass
		{
			return this._statusEffects.createStatusEffect(stype, value1, value2, value3, value4, fireEvent);
		}
		public function addStatusEffect(sec:StatusEffectClass/*,fireEvent:Boolean = true*/):void
		{
			return this._statusEffects.addStatusEffect(sec);
		}
		public function removeStatusEffect(stype:StatusEffectType/*, fireEvent:Boolean = true*/):StatusEffectClass
		{
			return this._statusEffects.removeStatusEffect(stype);
		}
		public function removeStatusEffectInstance(sec:StatusEffectClass/*, fireEvent:Boolean = true*/):void
		{
			return this._statusEffects.removeStatusEffectInstance(sec);
		}

		public function statusEffectByType(stype:StatusEffectType):StatusEffectClass
		{
			return this._statusEffects.statusEffectByType(stype);
		}
		public function hasStatusEffect(stype:StatusEffectType):Boolean {
			return this._statusEffects.hasStatusEffect(stype);
		}
		public function changeStatusValue(stype:StatusEffectType, statusValueNum:Number = 1, newNum:Number = 0):void
		{
			return this._statusEffects.changeStatusValue(stype, statusValueNum, newNum);
		}
		public function addStatusValue(stype:StatusEffectType, statusValueNum:Number = 1, bonus:Number = 0):void
		{
			return this._statusEffects.addStatusValue(stype, statusValueNum, bonus);
		}

		public function statusEffectv1(stype:StatusEffectType):Number
		{
			if (this._statusEffects.hasStatusEffect(stype)) {
				return this._statusEffects.getStatusValue(stype, 1);
			}
			return 0;
		}

		public function statusEffectv2(stype:StatusEffectType):Number
		{
			if (this._statusEffects.hasStatusEffect(stype)) {
				return this._statusEffects.getStatusValue(stype, 2);
			}
			return 0;
		}

		public function statusEffectv3(stype:StatusEffectType):Number
		{
			if (this._statusEffects.hasStatusEffect(stype)) {
				return this._statusEffects.getStatusValue(stype, 3);
			}
			return 0;
		}

		public function statusEffectv4(stype:StatusEffectType):Number
		{
			if (this._statusEffects.hasStatusEffect(stype)) {
				return this._statusEffects.getStatusValue(stype, 4);
			}
			return 0;
		}

		public function cleanAllBuffs():void
		{
			this.statStore.forEachStat(function(stat:BuffableStat):void{
				// This function will be called for every buffable stat
				stat.removeAllBuffs()
			},BuffableStat);
		}

		public function removeStatuses():void
		{
			this._statusEffects.removeStatuses();
		}


		/**
		 * Applies (creates or increases) a combat-long debuff to stat.
		 * Stat is fully restored after combat.
		 * Different invocations are indistinguishable - do not use this if you need
		 * to check for _specific_ debuff source (poison etc) mid-battle
		 * @param stat 'str','spe','tou','inte','wis'
		 * @param buff Creature stat is decremented by this value.
		 * @return (oldStat-newStat)
		 */
		public function addCombatBuff(stat:String, buff:Number):Number {
			switch(stat) {
				case 'str':
					return (createOrFindStatusEffect(StatusEffects.GenericCombatStrBuff)
							as CombatStrBuff).applyEffect(buff);
				case 'spe':
					return (createOrFindStatusEffect(StatusEffects.GenericCombatSpeBuff)
							as CombatSpeBuff).applyEffect(buff);
				case 'tou':
					return (createOrFindStatusEffect(StatusEffects.GenericCombatTouBuff)
							as CombatTouBuff).applyEffect(buff);
				case 'int':
				case 'inte':
					return (createOrFindStatusEffect(StatusEffects.GenericCombatInteBuff)
							as CombatInteBuff).applyEffect(buff);
				case 'wis':
					return (createOrFindStatusEffect(StatusEffects.GenericCombatWisBuff)
							as CombatWisBuff).applyEffect(buff);
			}
			trace("/!\\ ERROR: addCombatBuff('"+stat+"', "+buff+")");
			return 0;
		}
		/*

		[    ? ? ?    ]

		*/
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
			var isGooey:Boolean = (skin.type == Skin.GOO);
			var isGhastly:Boolean = (skin.type == Skin.TRANSPARENT);
			return Appearance.cockAdjective(cocks[index].cockType, cocks[index].cockLength, cocks[index].cockThickness, lust, cumQ(), isPierced, hasSock, isGooey, isGhastly);
		}

		public function wetness():Number
		{
			if (vaginas.length == 0)
				return 0;
			else
				return vaginas[0].vaginalWetness;
		}

		public function vaginaType(newType:int = -1, vagNum:int = 0):int
		{
			if (!hasVagina())
				return -1;
			if (newType != -1) // this handles the sandtrap pussy... for some reason.
			{
				vaginas[vagNum].type = newType;
			}
			return vaginas[vagNum].type;
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
			//Wet pussy provides 50 point boost
			if (hasPerk(PerkLib.WetPussy))
				bonus += 50;
			if (hasPerk(PerkLib.HistorySlut) || hasPerk(PerkLib.PastLifeSlut))
				bonus += 20;
			if (hasPerk(PerkLib.OneTrackMind))
				bonus += 10;
			if (hasPerk(PerkLib.Cornucopia))
				bonus += 30;
			if(hasPerk(PerkLib.FerasBoonWideOpen))
				bonus += 25;
			if(hasPerk(PerkLib.FerasBoonMilkingTwat))
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
			if (hasPerk(PerkLib.HistorySlut) || hasPerk(PerkLib.PastLifeSlut))
				bonus += 20;
			if (hasPerk(PerkLib.Cornucopia))
				bonus += 30;
			if (hasPerk(PerkLib.OneTrackMind))
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
			if (hasPerk(PerkLib.Feeder))
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
			if (hasPerk(PerkLib.BroBody))
				percent += 0.05;
			if (hasPerk(PerkLib.MaraesGiftStud))
				percent += 0.15;
			if (hasPerk(PerkLib.FerasBoonAlpha))
				percent += 0.10;
			if (perkv1(PerkLib.ElvenBounty) > 0)
				percent += 0.05;
			if (hasPerk(PerkLib.FertilityPlus))
				percent += 0.03;
			if (hasPerk(PerkLib.FertilityMinus) && lib < 25) //Reduces virility by 3%.
				percent -= 0.03;
			if (hasPerk(PerkLib.PiercedFertite))
				percent += 0.03;
			if (hasPerk(PerkLib.OneTrackMind))
				percent += 0.03;
			if (hasPerk(PerkLib.MagicalVirility))
				percent += 0.05 + (perkv1(PerkLib.MagicalVirility) * 0.01);
			//Messy Orgasms?
			if (hasPerk(PerkLib.MessyOrgasms))
				percent += 0.06;
			//Satyr Sexuality
			if (hasPerk(PerkLib.SatyrSexuality))
				percent += 0.10;
			//Fertite ring bonus!
			if (jewelryEffectId == JewelryLib.MODIFIER_FERTILITY)
				percent += (jewelryEffectMagnitude / 100);
			if (hasPerk(PerkLib.AscensionVirility))
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
				if (hasPerk(PerkLib.PilgrimsBounty)) lustCoefficient = 30;
				var percent:Number = 0;
				percent = lustCoefficient + (hoursSinceCum + 10);
				if (percent > 100)
					percent = 100;
				if (quantity > cumCapacity())
					quantity = cumCapacity();
				return (percent / 100) * cumCapacity();
			}
			//Pilgrim's bounty maxes lust coefficient
			if (hasPerk(PerkLib.PilgrimsBounty))
				lustCoefficient = 150 / 10;
			if (balls == 0)
				quantity = int(1.25 * 2 * cumMultiplier * 2 * lustCoefficient * (hoursSinceCum + 10) / 24) / 10;
			else
				quantity = int(ballSize * balls * cumMultiplier * 2 * lustCoefficient * (hoursSinceCum + 10) / 24) / 10;
			if (hasPerk(PerkLib.BroBody))
				quantity *= 1.3;
			if (hasPerk(PerkLib.FertilityPlus))
				quantity *= 1.5;
			if (hasPerk(PerkLib.FertilityMinus) && lib < 25)
				quantity *= 0.7;
			if (hasPerk(PerkLib.MessyOrgasms))
				quantity *= 2;
			if (hasPerk(PerkLib.OneTrackMind))
				quantity *= 1.1;
			if (hasPerk(PerkLib.MinotaurTesticlesFinalForm))
				quantity *= 2.5;
			if (hasPerk(PerkLib.MaraesGiftStud))
				quantity += 350;
			if (hasPerk(PerkLib.FerasBoonAlpha))
				quantity += 200;
			if (hasPerk(PerkLib.MagicalVirility))
				quantity += 200 + (perkv1(PerkLib.MagicalVirility) * 100);
			if (hasPerk(PerkLib.FerasBoonSeeder))
				quantity += 1000;
			if (hasPerk(PerkLib.MinotaurTesticlesEvolved))
				quantity += 200;
			if (hasPerk(PerkLib.NukiNutsEvolved))
				quantity += 200;
			if (hasPerk(PerkLib.NukiNutsFinalForm))
				quantity *= 2;
			if (hasPerk(PerkLib.EasterBunnyEggBagEvolved))
				quantity *= 1.5;
			if (hasPerk(PerkLib.EasterBunnyEggBagFinalForm))
				quantity *= 3;
			if (hasPerk(PerkLib.ProductivityDrugs))
				quantity += (perkv3(PerkLib.ProductivityDrugs));
			//if(hasPerk("Elven Bounty") >= 0) quantity += 250;;
			quantity += perkv1(PerkLib.ElvenBounty);
			if (hasPerk(PerkLib.BroBody))
				quantity += 200;
			if (hasPerk(PerkLib.SatyrSexuality))
				quantity += 50;
			quantity += statusEffectv1(StatusEffects.Rut);
			quantity *= (1 + (2 * perkv1(PerkLib.PiercedFertite)) / 100);
			if (jewelryEffectId == JewelryLib.MODIFIER_FERTILITY)
				quantity *= (1 + (jewelryEffectMagnitude / 100));
			if (hasPerk(PerkLib.AscensionCumHose))
				quantity += perkv1(PerkLib.AscensionCumHose) * 200;
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
			if (hasPerk(PerkLib.BroBody)) cumCap *= 1.3;
			if (hasPerk(PerkLib.FertilityPlus)) cumCap *= 1.5;
			if (hasPerk(PerkLib.FertilityMinus) && lib < 25) cumCap *= 0.7;
			if (hasPerk(PerkLib.MessyOrgasms)) cumCap *= 2;
			if (hasPerk(PerkLib.OneTrackMind)) cumCap *= 1.1;
			if (hasPerk(PerkLib.MaraesGiftStud)) cumCap += 350;
			if (hasPerk(PerkLib.FerasBoonAlpha)) cumCap += 200;
			if (hasPerk(PerkLib.MagicalVirility)) cumCap += 200;
			if (hasPerk(PerkLib.FerasBoonSeeder)) cumCap += 1000;
			if (hasPerk(PerkLib.ElvenBounty)) cumCap += perkv1(PerkLib.ElvenBounty);
			if (hasPerk(PerkLib.BroBody)) cumCap += 200;
			if (hasPerk(PerkLib.PiercedFertite)) cumCap *= (1 + (2 * perkv1(PerkLib.PiercedFertite)) / 100);
			if (hasStatusEffect(StatusEffects.Rut)) cumCap += statusEffectv1(StatusEffects.Rut);
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

		public function foamingCocks():int { //How many catcocks?
			return countCocksOfType(CockTypesEnum.CANCER);
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

		public function cavewyrmCocks():int { //How many cave wyrm-cocks?
			return countCocksOfType(CockTypesEnum.CAVE_WYRM);
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

		public function avianCocks():int { //How many aviancocks?
			return countCocksOfType(CockTypesEnum.AVIAN);
		}

		public function gryphonCocks():int { //How many gryphoncocks?
			return countCocksOfType(CockTypesEnum.GRYPHON);
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
		//How many cocks?
		public function cockTotal():Number
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

		//PC can fly?
		public function canFly():Boolean
		{
			//web also makes false!
			if (hasStatusEffect(StatusEffects.Web))
				return false;
			return Arms.Types[arms.type].canFly || Wings.Types[wings.type].canFly;
		}

		public function canPounce():Boolean
		{
			return (LowerBody.Types[lowerBody].canPounce && Arms.Types[arms.type].canPounce);
		}


		//PC can swim underwater?
		public function canSwimUnderwater():Boolean
		{
			if (gills.type != Gills.NONE || lowerBody == LowerBody.SCYLLA || hasStatusEffect(StatusEffects.Airweed) || game.player.necklaceName == "Magic coral and pearl necklace" || game.player.headjewelryName == "Aqua breather" || (game.player.isInGoblinMech() && game.player.hasKeyItem("Safety bubble") >= 0))
				return true;	//efekt of itemów dające oddych. pod wodą
			return false;
		}
		public function underwaterCombatBoost():void
		{
			var oldHPratio:Number = hp100/100;
			createStatusEffect(StatusEffects.UnderwaterCombatBoost, 0, 0, 0, 0);
			var bonusStr:Number = 0;
			var bonusSpe:Number = 0;
			if (game.player.hasPerk(PerkLib.AquaticAffinity)) {
				bonusStr += 30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				bonusSpe += 30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			}
			if (game.player.armorName == "Sexy Aquamarine Bikini" || game.player.armorName == "Sexy Black Bikini" || game.player.armorName == "Sexy Blue Bikini" || game.player.armorName == "Sexy Green Bikini" || game.player.armorName == "Sexy Pink Bikini" || game.player.armorName == "Sexy Red Bikini" || game.player.armorName == "Sexy White Bikini" || game.player.armorName == "Sexy Yellow Bikini") {
				bonusStr += 20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				bonusSpe += 20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			}
			if (game.player.necklaceName == "Magic coral and pearl necklace") bonusSpe += 10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			game.player.buff("UnderwaterCombatBoost").addStats({str:bonusStr,spe:bonusSpe}).withText("Fighting Underwater").combatPermanent();
			HP = oldHPratio * maxHP();
		}

		//Naked
		public function isNaked():Boolean
		{
			return game.player.armorName == "nothing" && game.player.upperGarmentName == "nothing" && game.player.lowerGarmentName == "nothing";
		}
		public function isNaked2():Boolean
		{
			return game.player.upperGarmentName == "nothing" && game.player.lowerGarmentName == "nothing";
		}

		//Crit immunity
		public function isImmuneToCrits():Boolean
		{
			if (game.monster.hasPerk(PerkLib.EnemyConstructType) || game.monster.hasPerk(PerkLib.EnemyFleshConstructType) || game.monster.hasPerk(PerkLib.EnemyGooType) || game.monster.hasPerk(PerkLib.EnemyPlantType) || game.monster.hasPerk(PerkLib.EnemyElementalType))
				return true;//dodać inne typy wrogów: nieumarli/duchy
			return false;
		}

		//Eyes of the Hunter
		public function whenEyesOfTheHunterActivates():Boolean
		{
			return (game.player.hasPerk(PerkLib.EyesOfTheHunterNovice) && game.player.sens >= 25 && (game.monster.hasPerk(PerkLib.EnemyBeastOrAnimalMorphType) || game.monster.hasPerk(PerkLib.EnemyFeralType) || game.monster.hasPerk(PerkLib.EnemyConstructType) || game.monster.hasPerk(PerkLib.EnemyFleshConstructType) || game.monster.hasPerk(PerkLib.EnemyElementalType)
					|| game.monster.hasPerk(PerkLib.EnemyGooType) || game.monster.hasPerk(PerkLib.EnemyHugeType) || game.monster.hasPerk(PerkLib.EnemyGigantType) || game.monster.hasPerk(PerkLib.EnemyColossalType) || game.monster.hasPerk(PerkLib.EnemyGroupType) || game.monster.hasPerk(PerkLib.EnemyPlantType) || game.monster.hasPerk(PerkLib.EnemyGhostType))
					|| game.monster.hasPerk(PerkLib.EnemyLargeGroupType)) || (game.player.hasPerk(PerkLib.EyesOfTheHunterAdept) && game.player.sens >= 50 && (game.monster.hasPerk(PerkLib.EnemyGodType) || game.monster.hasPerk(PerkLib.EnemyBossType) || game.monster.hasPerk(PerkLib.DarknessNature) || game.monster.hasPerk(PerkLib.FireNature) || game.monster.hasPerk(PerkLib.IceNature)
                    || game.monster.hasPerk(PerkLib.LightningNature))) || (game.player.hasPerk(PerkLib.EyesOfTheHunterMaster) && game.player.sens >= 75 && (game.monster.hasPerk(PerkLib.DarknessVulnerability) || game.monster.hasPerk(PerkLib.FireVulnerability) || game.monster.hasPerk(PerkLib.IceVulnerability) || game.monster.hasPerk(PerkLib.LightningVulnerability)));
		}
		public function whenGeneralEnemyPerksDisplayed():Boolean
		{
			return (game.player.hasPerk(PerkLib.EyesOfTheHunterNovice) && game.player.sens >= 25 && (game.monster.hasPerk(PerkLib.EnemyBeastOrAnimalMorphType) || game.monster.hasPerk(PerkLib.EnemyFeralType) || game.monster.hasPerk(PerkLib.EnemyConstructType) || game.monster.hasPerk(PerkLib.EnemyFleshConstructType) || game.monster.hasPerk(PerkLib.EnemyElementalType)
					|| game.monster.hasPerk(PerkLib.EnemyGroupType) || game.monster.hasPerk(PerkLib.EnemyLargeGroupType) || game.monster.hasPerk(PerkLib.EnemyGooType) || game.monster.hasPerk(PerkLib.EnemyHugeType) || game.monster.hasPerk(PerkLib.EnemyGigantType) || game.monster.hasPerk(PerkLib.EnemyColossalType) || game.monster.hasPerk(PerkLib.EnemyGhostType)
					|| game.monster.hasPerk(PerkLib.EnemyPlantType) || game.monster.hasPerk(PerkLib.EnemyGhostType))) || (game.player.hasPerk(PerkLib.EyesOfTheHunterAdept) && game.player.sens >= 50 && (game.monster.hasPerk(PerkLib.EnemyGodType) || game.monster.hasPerk(PerkLib.EnemyBossType)));
		}
		public function whenElementalEnemyPerksDisplayed():Boolean
		{
			return (game.player.hasPerk(PerkLib.EyesOfTheHunterAdept) && game.player.sens >= 50 && (game.monster.hasPerk(PerkLib.DarknessNature) || game.monster.hasPerk(PerkLib.FireNature) || game.monster.hasPerk(PerkLib.IceNature) || game.monster.hasPerk(PerkLib.LightningNature)))
                    || (game.player.hasPerk(PerkLib.EyesOfTheHunterMaster) && game.player.sens >= 75 && (game.monster.hasPerk(PerkLib.DarknessVulnerability) || game.monster.hasPerk(PerkLib.FireVulnerability) || game.monster.hasPerk(PerkLib.IceVulnerability) || game.monster.hasPerk(PerkLib.LightningVulnerability)));
		}

		//Unique sex scenes
		public function pcCanUseUniqueSexScene():Boolean
		{
			if ((game.player.tailType == Tail.MANTICORE_PUSSYTAIL && game.monster.hasCock()) || (game.player.isAlraune() && game.monster.hasCock()) || (game.player.isAlraune() && game.monster.hasVagina()) || game.player.tailType == Tail.HINEZUMI || game.player.tailType == Tail.SALAMANDER ||
			((game.player.gender == 1 || game.player.gender == 2) && (game.player.tailType == Tail.HINEZUMI || game.player.tailType == Tail.MOUSE || game.player.tailType == Tail.DEMONIC)) || (game.player.isInGoblinMech() && game.player.hasKeyItem("Cum Reservoir") >= 0 && game.monster.hasCock()) ||
			(game.player.raijuScore() >= 10 && !game.monster.hasPerk(PerkLib.EnemyHugeType) && !game.monster.hasPerk(PerkLib.EnemyGigantType) && !game.monster.hasPerk(PerkLib.EnemyColossalType) && !game.monster.isAlraune() && !game.monster.isDrider() && !game.monster.isGoo() && !game.monster.isNaga() && !game.monster.isScylla() && !game.monster.isTaur()) ||
			(game.player.yukiOnnaScore() >= 14 && game.monster.hasCock() && !game.monster.hasPerk(PerkLib.UniqueNPC) && !game.monster.hasPerk(PerkLib.EnemyHugeType) && !game.monster.hasPerk(PerkLib.EnemyGigantType) && !game.monster.hasPerk(PerkLib.EnemyColossalType) && !game.monster.isAlraune() && !game.monster.isDrider() && !game.monster.isGoo() && !game.monster.isNaga() && !game.monster.isScylla() && !game.monster.isTaur()))
				return true;
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
			if (cockTotal() > 0)
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

		//Rewritten!
		public function mf(male:String, female:String):String
		{
			if (hasCock() && hasVagina()) // herm
				return (biggestTitSize() >= 3 || biggestTitSize() == 2 && femininity >= 15 || biggestTitSize() == 1 && femininity >= 40 || femininity >= 65) ? female : male;
			if (hasCock()) // male
				return (biggestTitSize() >= 3 && femininity >= 5 || biggestTitSize() == 2 && femininity >= 35 || biggestTitSize() == 1 && femininity >= 65 || femininity >= 95) ? female : male;
			if (hasVagina()) // pure female
				return (biggestTitSize() >= 3 || femininity >= 75) ? female : male;
			// genderless
			return (biggestTitSize() >= 3 || biggestTitSize() == 2 && femininity >= 15 || biggestTitSize() == 1 && femininity >= 40 || femininity >= 65) ? female : male;
		}

		public function maleFemaleHerm(caps:Boolean = false):String
		{
			switch (gender) {
				case Gender.GENDER_NONE:   return caps ? mf("Genderless", "Fem-genderless") : mf("genderless", "fem-genderless");
				case Gender.GENDER_MALE:   return caps ? mf("Male", biggestTitSize() > BreastCup.A ? "Shemale" : "Femboy")             : mf("male", biggestTitSize() > BreastCup.A ? "shemale" : "femboy");
				case Gender.GENDER_FEMALE: return caps ? mf("Cuntboy", "Female")            : mf("cuntboy", "female");
				case Gender.GENDER_HERM:   return caps ? mf("Maleherm", "Hermaphrodite")    : mf("maleherm", "hermaphrodite");
				default: return "<b>Gender error!</b>";
			}
		}

		/**
		 * Checks if the creature is technically male: has cock but not vagina.
		 */
		public function isMale():Boolean
		{
			return gender == Gender.GENDER_MALE;
		}

		/**
		 * Checks if the creature is technically female: has vagina but not cock.
		 */
		public function isFemale():Boolean
		{
			return gender == Gender.GENDER_FEMALE;
					}

		/**
		 * Checks if the creature is technically herm: has both cock and vagina.
		 */
		public function isHerm():Boolean
					{
			return gender == Gender.GENDER_HERM;
					}

		/**
		 * Checks if the creature is technically genderless: has neither cock nor vagina.
		 */
		public function isGenderless():Boolean
				{
			return gender == Gender.GENDER_NONE;
				}

		/**
		 * Checks if the creature is technically male or herm: has at least a cock.
		 */
		public function isMaleOrHerm():Boolean
			{
			return (gender & Gender.GENDER_MALE) != 0;
				}

		/**
		 * Checks if the creature is technically female or herm: has at least a vagina.
		 */
		public function isFemaleOrHerm():Boolean
				{
			return (gender & Gender.GENDER_FEMALE) != 0;
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
			if(!hasPerk(PerkLib.FerasBoonMilkingTwat) || vaginas[0].vaginalLooseness <= VaginaClass.LOOSENESS_NORMAL) {
			//cArea > capacity = autostreeeeetch.
			if(cArea >= vaginalCapacity()) {
				if(vaginas[0].vaginalLooseness >= VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR) {}
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
			if (hasPerk(PerkLib.FertilityPlus))
				counter += 15;
			if (hasPerk(PerkLib.FertilityMinus) && lib < 25)
				counter -= 15;
			if (hasPerk(PerkLib.MaraesGiftFertility))
				counter += 50;
			if (hasPerk(PerkLib.FerasBoonBreedingBitch))
				counter += 30;
			if (hasPerk(PerkLib.MagicalFertility))
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
		public function hasChitin():Boolean { return skin.hasChitin(); }
		public function hasFeather():Boolean { return skin.hasFeather(); }
		public function hasMostlyPlainSkin():Boolean { return skin.hasMostlyPlainSkin(); }
		public function hasPlainSkinOnly():Boolean { return skin.hasPlainSkinOnly(); }
		public function hasPartialCoat(coat_type:int):Boolean { return skin.hasPartialCoatOfType(coat_type); }
		public function hasPartialCoatNoTypeDeclaration():Boolean { return skin.hasPartialCoat(); }
		public function hasRubberSkin():Boolean { return skin.hasRubberSkin(); }
		public function hasPlainSkin():Boolean { return skin.hasPlainSkin(); }
		public function hasGooSkin():Boolean { return skin.hasGooSkin(); }
		public function hasGhostSkin():Boolean { return skin.hasGhostSkin(); }
		public function isGargoyle():Boolean { return skin.hasBaseOnly(Skin.STONE); }
		public function skinDescript():String { return skin.describe('base'); }
		public function skinFurScales():String { return skin.describe('coat'); }

		// <mod name="Predator arms" author="Stadler76">
		public function claws():String { return clawsPart.descriptionFull(); }
		public function finger():String { return clawsPart.descriptionFinger(); }
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
		public function isKraken():Boolean { return lowerBodyPart.isKraken(); }
		public function isAlraune():Boolean { return lowerBodyPart.isAlraune(); }
		public function isLiliraune():Boolean { return lowerBodyPart.isLiliraune(); }
		public function isElf():Boolean {
			return hasPerk(PerkLib.ElvishPeripheralNervSysFinalForm) || game.player.elfScore() >= 10 || game.player.woodElfScore() >= 17
		}

		public function isFlying():Boolean {
			return hasStatusEffect(StatusEffects.Flying);
		}

		public function canOvipositSpider():Boolean
		{
			return eggs() >= 10 && hasPerk(PerkLib.SpiderOvipositor) && isDrider() && tail.type == Tail.SPIDER_ADBOMEN;
		}

		public function canOvipositBee():Boolean
		{
			return eggs() >= 10 && hasPerk(PerkLib.BeeOvipositor) && tail.type == Tail.BEE_ABDOMEN;
		}

		public function canOvipositMantis():Boolean
		{
			return eggs() >= 10 && hasPerk(PerkLib.MantisOvipositor) && tail.type == Tail.MANTIS_ABDOMEN;
		}

		public function canOviposit():Boolean
		{
			return canOvipositSpider() || canOvipositBee() || canOvipositMantis();
		}

		public function eggs():int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor) && !hasPerk(PerkLib.MantisOvipositor))
				return -1;
			else if (hasPerk(PerkLib.SpiderOvipositor))
				return perkv1(PerkLib.SpiderOvipositor);
			else if (hasPerk(PerkLib.BeeOvipositor))
				return perkv1(PerkLib.BeeOvipositor);
			else
				return perkv1(PerkLib.MantisOvipositor);
		}

		public function addEggs(arg:int = 0):int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor) && !hasPerk(PerkLib.MantisOvipositor))
				return -1;
			else {
				if (hasPerk(PerkLib.SpiderOvipositor)) {
					addPerkValue(PerkLib.SpiderOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.SpiderOvipositor, 1, 50);
					return perkv1(PerkLib.SpiderOvipositor);
				}
				else if (hasPerk(PerkLib.BeeOvipositor)) {
					addPerkValue(PerkLib.BeeOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.BeeOvipositor, 1, 50);
					return perkv1(PerkLib.BeeOvipositor);
				}
				else {
					addPerkValue(PerkLib.MantisOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.MantisOvipositor, 1, 50);
					return perkv1(PerkLib.MantisOvipositor);
				}
			}
		}

		public function dumpEggs():void
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor) && !hasPerk(PerkLib.MantisOvipositor))
				return;
			setEggs(0);
			//Sets fertile eggs = regular eggs (which are 0)
			fertilizeEggs();
		}

		public function setEggs(arg:int = 0):int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor) && !hasPerk(PerkLib.MantisOvipositor))
				return -1;
			else {
				if (hasPerk(PerkLib.SpiderOvipositor)) {
					setPerkValue(PerkLib.SpiderOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.SpiderOvipositor, 1, 50);
					return perkv1(PerkLib.SpiderOvipositor);
				}
				else if (hasPerk(PerkLib.BeeOvipositor)) {
					setPerkValue(PerkLib.BeeOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.BeeOvipositor, 1, 50);
					return perkv1(PerkLib.BeeOvipositor);
				}
				else {
					setPerkValue(PerkLib.MantisOvipositor, 1, arg);
					if (eggs() > 50)
						setPerkValue(PerkLib.MantisOvipositor, 1, 50);
					return perkv1(PerkLib.MantisOvipositor);
				}
			}
		}

		public function fertilizedEggs():int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor) && !hasPerk(PerkLib.MantisOvipositor))
				return -1;
			else if (hasPerk(PerkLib.SpiderOvipositor))
				return perkv2(PerkLib.SpiderOvipositor);
			else if (hasPerk(PerkLib.BeeOvipositor))
				return perkv2(PerkLib.BeeOvipositor);
			else
				return perkv2(PerkLib.MantisOvipositor);
		}

		public function fertilizeEggs():int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor) && !hasPerk(PerkLib.MantisOvipositor))
				return -1;
			else if (hasPerk(PerkLib.SpiderOvipositor))
				setPerkValue(PerkLib.SpiderOvipositor, 2, eggs());
			else if (hasPerk(PerkLib.BeeOvipositor))
				setPerkValue(PerkLib.BeeOvipositor, 2, eggs());
			else
				setPerkValue(PerkLib.MantisOvipositor, 2, eggs());
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
			return breastRows[index].breasts >= 2 && breastRows[index].breastRating > 3;

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
				case CockTypesEnum.CAVE_WYRM:
				case CockTypesEnum.RED_PANDA:
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
			return tongue.type == Tongue.DEMONIC || tongue.type == Tongue.DRACONIC || tongue.type == Tongue.ECHIDNA;
		}

		public function hairOrFur():String
		{
			return Appearance.hairOrFur(this);
		}

		public function hairDescript(longDesc:Boolean = false):String
		{
			return Appearance.hairDescription(this, longDesc);
		}

		public function beardDescript():String
		{
			return Appearance.beardDescription(this);
		}

		public function hairStyleDescript():String
		{
			return Appearance.beardDescription(this);
		}

		public function hipDescript():String
		{
			return Appearance.hipDescription(this);
		}

		public function assDescript():String
		{
			return buttDescript();
		}

		public function buttDescript():String
		{
			return Appearance.buttDescription(this);
		}

		public function tongueDescript():String
		{
			return Appearance.tongueDescription(this);
		}

		public function hornDescript():String
		{
			return Horns.Types[horns.type].name + " horns";
		}

		public function tailDescript():String
		{
			return Appearance.tailDescript(this);
		}

		public function oneTailDescript():String
		{
			return Appearance.oneTailDescript(this);
		}

		public function wingsDescript():String
		{
			return Appearance.wingsDescript(this);
		}

		public function eyesDescript():String
		{
			return Appearance.eyesDescript(this);
		}

		public function earsDescript():String
		{
			return Appearance.earsDescript(this);
		}

		public function antennaeDescript():String
		{
			return Appearance.antennaeDescript(this);
		}

		public function damagePercent():Number {
			var mult:Number = 100;
			return mult;
		}

		public function damageRangePercent():Number {
			var mult:Number = 100;
			return mult;
		}

		public function damageMagicalPercent():Number {
			var mult:Number = 100;
			return mult;
		}

		public function damageFirePercent():Number {
			var mult:Number = 100;
			return mult;
		}

		public function damageIcePercent():Number {
			var mult:Number = 100;
			return mult;
		}

		public function damageLightningPercent():Number {
			var mult:Number = 100;
			return mult;
		}

		public function damageDarknessPercent():Number {
			var mult:Number = 100;
			return mult;
		}

		public function damagePoisonPercent():Number {
			var mult:Number = 100;
			return mult;
		}

		/**
		* Look into perks and special effects and @return summery extra chance to avoid attack granted by them.
		*/
		public function getEvasionChance():Number
		{
			var chance:Number = 0;
			var flychance:Number = 20;
			if (hasPerk(PerkLib.AdvancedAerialCombat)) flychance += 5;
			if (hasPerk(PerkLib.GreaterAerialCombat)) flychance += 15;
			if (hasPerk(PerkLib.HarpyHollowBonesEvolved)) flychance += 10;
			if ((game.player.hasKeyItem("Jetpack") >= 0 || game.player.hasKeyItem("MK2 Jetpack") >= 0) && game.player.isInGoblinMech()) flychance += 25;
			if (hasPerk(PerkLib.Evade)) {
				chance += 5;
				if (hasPerk(PerkLib.ImprovedEvade)) chance += 10;
				if (hasPerk(PerkLib.GreaterEvade)) chance += 15;
				if (hasPerk(PerkLib.JobRogue)) chance += 5;
				if (hasPerk(PerkLib.Spectre) && hasPerk(PerkLib.Incorporeality)) chance += 10;
			}
			if (hasPerk(PerkLib.ElvenSense)) {
				chance += 5;
				if (hasPerk(PerkLib.ElvishPeripheralNervSysEvolved)) chance += 10;
				if (hasPerk(PerkLib.ElvishPeripheralNervSysFinalForm)) chance += 15;
			}
			if (hasPerk(PerkLib.Flexibility)) chance += 6;
			if (hasPerk(PerkLib.Misdirection) && (armorName == "red, high-society bodysuit" || armorName == "Fairy Queen Regalia")) chance += 10;
			//if (hasPerk(PerkLib.Unhindered) && meetUnhinderedReq()) chance += 10;
			if (hasPerk(PerkLib.Unhindered) && game.player.armor.hasTag(ItemTags.AGILE)) chance += 10;
			if (game.player.armor == game.armors.R_CHANG || game.player.armor == game.armors.R_QIPAO || game.player.armor == game.armors.G_CHANG || game.player.armor == game.armors.G_QIPAO || game.player.armor == game.armors.B_CHANG || game.player.armor == game.armors.B_QIPAO || game.player.armor == game.armors.P_CHANG || game.player.armor == game.armors.P_QIPAO) chance += 5;
			if (game.player.hasKeyItem("Spring Boots") >= 0 && game.player.tallness < 48 && game.player.isBiped()) chance += 10;
			if (game.player.hasKeyItem("Rocket Boots") >= 0 && game.player.tallness < 48 && game.player.isBiped()) chance += 20;
			if (game.player.hasKeyItem("Nitro Boots") >= 0 && game.player.tallness < 48 && game.player.isBiped()) chance += 30;
			if (hasPerk(PerkLib.JunglesWanderer)) chance += 35;
			if (hasStatusEffect(StatusEffects.Illusion)) {
				if (hasPerk(PerkLib.KitsuneThyroidGlandFinalForm)) chance += 20;
				else chance += 10;
			}
			if (hasStatusEffect(StatusEffects.HurricaneDance)) chance += 25;
			if (hasStatusEffect(StatusEffects.BladeDance)) chance += 30;
			if (game.player.cheshireScore() >= 11) {
				if (hasStatusEffect(StatusEffects.EverywhereAndNowhere)) chance += 80;
				else chance += 30;
			}
			if (game.player.displacerbeastScore() >= 11) {
				if (hasStatusEffect(StatusEffects.Displacement)) chance += 80;
				else chance += 30;
			}
			if (hasStatusEffect(StatusEffects.Displacement)) chance += 60;
			if (game.player.shieldPerk == "Large" && !hasPerk(PerkLib.GigantGrip)) chance -= 20;
			if (game.player.shieldPerk == "Massive") {
				if (!hasPerk(PerkLib.GigantGrip)) chance -= 75;
				else chance -= 30;
			}
			if (game.player.hasStatusEffect(StatusEffects.Snow) && game.player.tallness < 84) chance -= 50;
			if (hasStatusEffect(StatusEffects.Flying)) chance += flychance;
			return chance;
		}

		public const EVASION_SPEED:String = "Speed"; // enum maybe?
		public const EVASION_EVADE:String = "Evade";
		public const EVASION_FLEXIBILITY:String = "Flexibility";
		public const EVASION_MISDIRECTION:String = "Misdirection";
		public const EVASION_UNHINDERED:String = "Unhindered";
		public const EVASION_JUNGLESWANDERER:String = "Jungle's Wanderer";
		public const EVASION_ILLUSION:String = "Illusion";
		public const EVASION_FLYING:String = "Flying";
		public const EVASION_CHESHIRE_PHASING:String = "Phasing";
		public const EVASION_TITANIA_MINIMISE:String = "Minimise";

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
			var generalevasion:Number = 0;
			var flyeavsion:Number = 20;
			if (hasPerk(PerkLib.Evade)) generalevasion += 5;
			if (hasPerk(PerkLib.ImprovedEvade)) generalevasion += 10;
			if (hasPerk(PerkLib.GreaterEvade)) generalevasion += 15;
			if (hasPerk(PerkLib.JobRogue)) generalevasion += 5;
			if (hasPerk(PerkLib.Spectre) && hasPerk(PerkLib.Incorporeality)) generalevasion += 10;
			if (hasPerk(PerkLib.ElvenSense)) generalevasion += 5;
			if (hasPerk(PerkLib.ElvishPeripheralNervSysEvolved)) generalevasion += 10;
			if (hasPerk(PerkLib.ElvishPeripheralNervSysFinalForm)) generalevasion += 15;
			if (generalevasion > 0) flyeavsion += generalevasion;
			if (hasPerk(PerkLib.AdvancedAerialCombat)) flyeavsion += 5;
			if (hasPerk(PerkLib.GreaterAerialCombat)) flyeavsion += 15;
			if (game.player.hasKeyItem("Spring Boots") >= 0 && game.player.tallness < 48 && game.player.isBiped()) generalevasion += 10;
			if (game.player.hasKeyItem("Rocket Boots") >= 0 && game.player.tallness < 48 && game.player.isBiped()) generalevasion += 20;
			if (game.player.hasKeyItem("Nitro Boots") >= 0 && game.player.tallness < 48 && game.player.isBiped()) generalevasion += 30;
			// perks
			if ((hasPerk(PerkLib.Evade) || hasPerk(PerkLib.ElvenSense) || ((game.player.hasKeyItem("Nitro Boots") >= 0 || game.player.hasKeyItem("Rocket Boots") >= 0 || game.player.hasKeyItem("Spring Boots") >= 0) && game.player.tallness < 48 && game.player.isBiped())) && (roll < generalevasion)) return "Evade";
			if (hasPerk(PerkLib.Flexibility) && (roll < 6)) return "Flexibility";
			if (hasPerk(PerkLib.Misdirection) && (game.player.armor.hasTag(ItemTags.AGILE)) && (roll < 10)) return "Misdirection";
			//if (hasPerk(PerkLib.Unhindered) && meetUnhinderedReq() && (roll < 10)) return "Unhindered";
			if (hasPerk(PerkLib.Unhindered) && game.player.armor.hasTag(ItemTags.AGILE) && (roll < 10)) return "Unhindered";
			if (hasPerk(PerkLib.JunglesWanderer) && (roll < 35)) return "Jungle's Wanderer";
			if (hasStatusEffect(StatusEffects.Illusion)) {
				if (hasPerk(PerkLib.KitsuneThyroidGlandFinalForm) && roll < 20) return "Illusion";
				else if (roll < 10) return "Illusion";
			}
			if (hasStatusEffect(StatusEffects.Flying) && (roll < flyeavsion)) return "Flying";
			if (hasStatusEffect(StatusEffects.HurricaneDance) && (roll < 25)) return "Hurricane Dance";
			if (hasStatusEffect(StatusEffects.BladeDance) && (roll < 30)) return "Blade Dance";
			if (game.player.cheshireScore() >= 11 && ((!hasStatusEffect(StatusEffects.Minimise) && (roll < 30)) || (hasStatusEffect(StatusEffects.EverywhereAndNowhere) && (roll < 80)))) return "Minimise";
			if (game.player.cheshireScore() >= 11 && ((!hasStatusEffect(StatusEffects.EverywhereAndNowhere) && (roll < 30)) || (hasStatusEffect(StatusEffects.EverywhereAndNowhere) && (roll < 80)))) return "Phasing";
			if (game.player.displacerbeastScore() >= 11 && ((!hasStatusEffect(StatusEffects.Displacement) && (roll < 30)) || (hasStatusEffect(StatusEffects.Displacement) && (roll < 80)))) return "Displacing";
			return null;
		}

		/**
		 * Runs all checks on ability and returns true if it possible
		 */
		public function abilityIsPossible(ability:Object, target: Creature):Boolean {
			if (!ability.call) return false; // no function specified
			// ability has condition check that fails
			if ('condition' in ability && !ability.condition()) return false;
			if ('weight' in ability && ability.weight <= 0 && isNaN(ability.weight)) return false;
			if (!canUseAbility(ability)) return false;
			if (ability.range != RANGE_SELF && !target.canBeTargetedWith(ability)) return false;
			return true;
		}

		/**
		 * Pick and return one possible ability; or null if none are possible
		 */
		public function pickRandomAbility(abilities:/*Object*/Array, target: Creature):Object {
			var n:int = abilities.length;
			abilities = abilities.filter(
					function (ability:Object, idx:int, array:Array):Boolean {
						return abilityIsPossible(ability, target);
					}
			);
			trace(short+" filtered "+abilities.length+" possible abilities out of "+n);
			if (abilities.length == 0) return null;
			// Run weighted random
			var sum:Number = 0;
			for each (var ability:Object in abilities) {
				if ('weight' in ability) {
					if (!isFinite(ability.weight)) {
						// Infinite weight - pick only this ability, ignore others
						return ability;
					}
				} else {
					ability.weight = 1;
				}
				sum += ability.weight;
			}
			var pick:Number = Math.random()*sum;
			for each (ability in abilities) {
				pick -= ability.weight;
				if (pick <= 0) return ability;
			}
			// Should never happen but just in case, return first ability
			return abilities[0];
		}



		/**
		 * Check if this creature is in condition to perform the ability (not sealed etc)
		 * @param ability See Monster.abilities for documentation on structure
		 * @return
		 */
		public function canUseAbility(ability:Object):Boolean {
			return true;
		}

		/**
		 * Check the ability for tags, if it applicable to current state of this creature
		 * @param ability See Monster.abilities for documentation on structure
		 * @return true if this creature can be targeted with ability
		 */
		public function canBeTargetedWith(ability:Object):Boolean {
			if (ability.range == RANGE_MELEE && isFlying()) {
				return false;
			}
			return true;
		}

		public function getEvasionRoll(useMonster:Boolean = true, attackSpeed:int = int.MIN_VALUE):Boolean
		{
			return getEvasionReason(useMonster, attackSpeed) != null;
		}

		//private function evasionCalc():void { //In development
			//var evasionValue:Number = 0;
			//evasionValue += Math.min( 40, spe/25);
			//if (hasPerk(PerkLib.Flexibility)) evasionValue += 5;
			//if (hasPerk(PerkLib.CatlikeNimbleness)) evasionValue += 5;
			//if (hasPerk(PerkLib.CatlikeNimblenessEvolved)) evasionValue += 5;
			//if (hasPerk(PerkLib.CatlikeNimblenessFinalForm)) evasionValue += 5;
			//if (hasPerk(PerkLib.ElvenSense)) evasionValue += 5;
			//if (hasPerk(PerkLib.Evade)) evasionValue += 5;
			//if (hasPerk(PerkLib.ImprovedEvade)) evasionValue += 10;
			//if (hasPerk(PerkLib.GreaterEvade)) evasionValue += 15;
			//if (hasPerk(PerkLib.Spectre && hasPerk(PerkLib.Incorporeality) >= 0)) evasionValue += 10;
			//if (hasPerk(PerkLib.AdvancedAerialCombat) && isFlying()) evasionValue += 5;
			//if (hasPerk(PerkLib.GreaterAerialCombat) && isFlying()) evasionValue += 15;
			//if (game.player.hasKeyItem("Spring Boots") >= 0 && tallness < 48 && isBiped()) evasionValue += 10;
			//if (game.player.hasKeyItem("Rocket Boots") >= 0 && tallness < 48 && isBiped()) evasionValue += 20;
			//if (game.player.hasKeyItem("Nitro Boots") >= 0 && tallness < 48 && isBiped()) evasionValue += 30;
			//if (hasPerk(PerkLib.Unhindered) && (armorName == "arcane bangles" || armorName == "practically indecent steel armor"
			//|| armorName == "revealing chainmail bikini" || armorName == "slutty swimwear" || armorName == "barely-decent bondage straps"
			//|| armorName == "berserker armor" || armorName == "nothing")) evasionValue += 10;
			//if (hasPerk(PerkLib.Misdirection) && (armorName == "red, high-society bodysuit"
			//|| armorName == "Fairy Queen Regalia")) evasionValue += 10;
		//}

		public function get vagorass():IOrifice {
			return hasVagina() ? vaginas[0] : ass;
		}


		// returns OLD OP VAL
		public static function applyOperator(old:Number, op:String, val:Number):Number {
			switch(op) {
				case "=":
					return val;
				case "+":
					return old + val;
				case "-":
					return old - val;
				case "*":
					return old * val;
				case "/":
					return old / val;
				default:
					trace("applyOperator(" + old + ",'" + op + "'," + val + ") unknown op");
					return old;
			}
		}
		/**
		 * Generate increments for stats
		 *
		 * @return Object of (newStat-oldStat) with keys str, tou, spe, inte, wis, lib, sens, lust, cor
		 * and flags scale, max
		 * */
		public static function parseDynStatsArgs(c:Creature, args:Array):Object {
			// Check num of args, we should have a multiple of 2
			if ((args.length % 2) != 0)
			{
				trace("dynStats aborted. Keys->Arguments could not be matched");
				return {str:0,tou:0,spe:0,inte:0,wis:0,lib:0,sens:0,lust:0,cor:0,scale:true};
			}
			var argDefs:Object = { //[value, operator]
				str: [ 0, "+"],
				tou: [ 0, "+"],
				spe: [ 0, "+"],
				int: [ 0, "+"],
				wis: [ 0, "+"],
				lib: [ 0, "+"],
				sen: [ 0, "+"],
				lus: [ 0, "+"],
				cor: [ 0, "+"],
				scale: [ true, "="],
				max: [ true, "="]
			};
			var aliases:Object = {
				"strength":"str",
				"toughness": "tou",
				"speed": "spe",
				"intellect": "int",
				"inte": "int",
				"libido": "lib",
				"sensitivity": "sen",
				"sens": "sen",
				"lust": "lus",
				"corruption": "cor",
				"sca": "scale",
				"scaled": "scale",
				"res": "scale",
				"resisted": "scale",
				"wisdom": "wis"
			};

			for (var i:int = 0; i < args.length; i += 2)
			{
				if (typeof(args[i]) == "string")
				{
					// Make sure the next arg has the POSSIBILITY of being correct
					if ((typeof(args[i + 1]) != "number") && (typeof(args[i + 1]) != "boolean"))
					{
						trace("dynStats aborted. Next argument after argName is invalid! arg is type " + typeof(args[i + 1]));
						continue;
					}
					var argOp:String = "";
					// Figure out which array to search
					var argsi:String = (args[i] as String);
					if ("+-*/=".indexOf(argsi.charAt(argsi.length - 1)) != -1) {
						argOp = argsi.charAt(argsi.length - 1);
						argsi = argsi.slice(0, argsi.length - 1);
					}
					if (argsi in aliases) argsi = aliases[argsi];

					if (argsi in argDefs) {
						argDefs[argsi][0] = args[i + 1];
						if (argOp) argDefs[argsi][1] = argOp;
					} else {
						trace("Couldn't find the arg name " + argsi + " in the index arrays. Welp!");
					}
				}
				else
				{
					trace("dynStats aborted. Expected a key and got SHIT");
				}
			}
			// Got this far, we have values to statsify
			var newStr:Number = applyOperator(c.str, argDefs.str[1], argDefs.str[0]);
			var newTou:Number = applyOperator(c.tou, argDefs.tou[1], argDefs.tou[0]);
			var newSpe:Number = applyOperator(c.spe, argDefs.spe[1], argDefs.spe[0]);
			var newInte:Number = applyOperator(c.inte, argDefs.int[1], argDefs.int[0]);
			var newWis:Number = applyOperator(c.wis, argDefs.wis[1], argDefs.wis[0]);
			var newLib:Number = applyOperator(c.lib, argDefs.lib[1], argDefs.lib[0]);
			var newSens:Number = applyOperator(c.sens, argDefs.sen[1], argDefs.sen[0]);
			var newLust:Number = applyOperator(c.lust, argDefs.lus[1], argDefs.lus[0]);
			var newCor:Number = applyOperator(c.cor, argDefs.cor[1], argDefs.cor[0]);
			// Because lots of checks and mods are made in the stats(), calculate deltas and pass them. However, this means that the '=' operator could be resisted
			// In future (as I believe) stats() should be replaced with dynStats(), and checks and mods should be made here
			return {
				str     : newStr - c.str,
				tou     : newTou - c.tou,
				spe     : newSpe - c.spe,
				inte    : newInte - c.inte,
				wis     : newWis - c.wis,
				lib     : newLib - c.lib,
				sens    : newSens - c.sens,
				lust    : newLust - c.lust,
				cor     : newCor - c.cor,
				scale   : argDefs.scale[0],
				max     : argDefs.max[0]
			};
		}
	}
}
