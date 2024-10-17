//CoC Creature.as
package classes
{
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Beard;
import classes.BodyParts.BodyMaterial;
import classes.BodyParts.BodyPart;
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
import classes.IMutations.*;
import classes.Items.JewelryLib;
import classes.Races.ElementalRace;
import classes.Scenes.Combat.Combat;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.SceneLib;
import classes.Stats.BuffBuilder;
import classes.Stats.BuffableStat;
import classes.Stats.PrimaryStat;
import classes.Stats.StatStore;
import classes.internals.Utils;
import classes.lists.BreastCup;
import classes.lists.Gender;

import flash.errors.IllegalOperationError;
import classes.Scenes.Combat.CombatAbilities;

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
		private var _weaponType:String = "";
		private var _weaponValue:Number = 0;
		public function get weaponName():String { return _weaponName; }
		public function get weaponVerb():String { return _weaponVerb; }
		public function get weaponAttack():Number { return _weaponAttack; }
		//Warning: Deprecated since 0.8s2. New tagging system uses this args. DO NOT USE, MUST REPLACE WITH weaponSpecials
		public function get weaponType():String { return _weaponType; }
		public function get weaponValue():Number { return _weaponValue; }
		public function set weaponName(value:String):void { _weaponName = value; }
		public function set weaponVerb(value:String):void { _weaponVerb = value; }
		public function set weaponAttack(value:Number):void { _weaponAttack = value; }
		public function set weaponValue(value:Number):void { _weaponValue = value; }
		//Weapon melee (offhand)
		private var _weaponOffhandName:String = "";
		private var _weaponOffhandVerb:String = "";
		private var _weaponOffhandAttack:Number = 0;
		private var _weaponOffhandType:String = "";
		private var _weaponOffhandValue:Number = 0;
		public function get weaponOffhandName():String { return _weaponOffhandName; }
		public function get weaponOffhandVerb():String { return _weaponOffhandVerb; }
		public function get weaponOffhandAttack():Number { return _weaponOffhandAttack; }
		public function get weaponOffhandType():String { return _weaponOffhandType; }
		public function get weaponOffhandValue():Number { return _weaponOffhandValue; }
		public function set weaponOffhandName(value:String):void { _weaponOffhandName = value; }
		public function set weaponOffhandVerb(value:String):void { _weaponOffhandVerb = value; }
		public function set weaponOffhandAttack(value:Number):void { _weaponOffhandAttack = value; }
		public function set weaponOffhandValue(value:Number):void { _weaponOffhandValue = value; }
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
		//Weapon flying swords
		private var _weaponFlyingSwordsName:String = "";
		private var _weaponFlyingSwordsVerb:String = "";
		private var _weaponFlyingSwordsAttack:Number = 0;
		private var _weaponFlyingSwordsPerk:String = "";
		private var _weaponFlyingSwordsValue:Number = 0;
		public function get weaponFlyingSwordsName():String { return _weaponFlyingSwordsName; }
		public function get weaponFlyingSwordsVerb():String { return _weaponFlyingSwordsVerb; }
		public function get weaponFlyingSwordsAttack():Number { return _weaponFlyingSwordsAttack; }
		public function get weaponFlyingSwordsPerk():String { return _weaponFlyingSwordsPerk; }
		public function get weaponFlyingSwordsValue():Number { return _weaponFlyingSwordsValue; }
		public function set weaponFlyingSwordsName(value:String):void { _weaponFlyingSwordsName = value; }
		public function set weaponFlyingSwordsVerb(value:String):void { _weaponFlyingSwordsVerb = value; }
		public function set weaponFlyingSwordsAttack(value:Number):void { _weaponFlyingSwordsAttack = value; }
		public function set weaponFlyingSwordsPerk(value:String):void { _weaponFlyingSwordsPerk = value; }
		public function set weaponFlyingSwordsValue(value:Number):void { _weaponFlyingSwordsValue = value; }
		//Clothing/Armor
		private var _armorName:String = "";
		private var _armorDef:Number = 0;
		private var _armorDefSlashing:Number = 0;
		private var _armorDefPiercing:Number = 0;
		private var _armorDefBludgeoning:Number = 0;
		private var _armorMDef:Number = 0;
		private var _armorMDefFire:Number = 0;
		private var _armorMDefIce:Number = 0;
		private var _armorMDefLightning:Number = 0;
		private var _armorMDefDarkness:Number = 0;
		private var _armorPerk:String = "";
		private var _armorValue:Number = 0;
		public function get armorName():String { return _armorName; }
		public function get armorDef():Number {
			return defStat.value + _armorDef;
		}
		public function get armorMDef():Number {
			return mdefStat.value + _armorMDef;
		}
		public function get armorPerk():String { return _armorPerk; }
		public function get armorValue():Number { return _armorValue; }
		public function set armorValue(value:Number):void { _armorValue = value; }
		public function set armorName(value:String):void { _armorName = value; }
		public function set armorDef(value:Number):void { _armorDef = value; }
		public function set armorDefSlashing(value:Number):void { _armorDefSlashing = value; }
		public function set armorDefPiercing(value:Number):void { _armorDefPiercing = value; }
		public function set armorDefBludgeoning(value:Number):void { _armorDefBludgeoning = value; }
		public function set armorMDef(value:Number):void { _armorMDef = value; }
		public function set armorMDefFire(value:Number):void { _armorMDefFire = value; }
		public function set armorMDefIce(value:Number):void { _armorMDefIce = value; }
		public function set armorMDefLightning(value:Number):void { _armorMDefLightning = value; }
		public function set armorMDefDarkness(value:Number):void { _armorMDefDarkness = value; }
		public function set armorPerk(value:String):void { _armorPerk = value; }
		//Misc Jewelry
		private var _miscjewelryName:String = "";
		private var _miscjewelryEffectId:Number = 0;
		private var _miscjewelryEffectMagnitude:Number = 0;
		private var _miscjewelryPerk:String = "";
		private var _miscjewelryValue:Number = 0;
		public function get miscjewelryName():String { return _miscjewelryName; }
		public function get miscjewelryEffectId():Number { return _miscjewelryEffectId; }
		public function get miscjewelryEffectMagnitude():Number { return _miscjewelryEffectMagnitude; }
		public function get miscjewelryPerk():String { return _miscjewelryPerk; }
		public function get miscjewelryValue():Number { return _miscjewelryValue; }
		public function set miscjewelryValue(value:Number):void { _miscjewelryValue = value; }
		public function set miscjewelryName(value:String):void { _miscjewelryName = value; }
		public function set miscjewelryEffectId(value:Number):void { _miscjewelryEffectId = value; }
		public function set miscjewelryEffectMagnitude(value:Number):void { _miscjewelryEffectId = value; }
		public function set miscjewelryPerk(value:String):void { _miscjewelryPerk = value; }
		private var _miscjewelryName2:String = "";
		private var _miscjewelryEffectId2:Number = 0;
		private var _miscjewelryEffectMagnitude2:Number = 0;
		private var _miscjewelryPerk2:String = "";
		private var _miscjewelryValue2:Number = 0;
		public function get miscjewelryName2():String { return _miscjewelryName2; }
		public function get miscjewelryEffectId2():Number { return _miscjewelryEffectId2; }
		public function get miscjewelryEffectMagnitude2():Number { return _miscjewelryEffectMagnitude2; }
		public function get miscjewelryPerk2():String { return _miscjewelryPerk2; }
		public function get miscjewelryValue2():Number { return _miscjewelryValue2; }
		public function set miscjewelryValue2(value:Number):void { _miscjewelryValue2 = value; }
		public function set miscjewelryName2(value:String):void { _miscjewelryName2 = value; }
		public function set miscjewelryEffectId2(value:Number):void { _miscjewelryEffectId2 = value; }
		public function set miscjewelryEffectMagnitude2(value:Number):void { _miscjewelryEffectId2 = value; }
		public function set miscjewelryPerk2(value:String):void { _miscjewelryPerk2 = value; }
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
		
		// auxiliary stats
		public var minLustStat: BuffableStat;
		public var minLustXStat: BuffableStat; // min lust as factor of max lust, 0.5 = 50%
		public var maxHpBaseStat: BuffableStat;
		public var maxHpPerLevelStat: BuffableStat;
		public var maxHpMultStat: BuffableStat;
		public var maxLustBaseStat: BuffableStat;
		public var maxLustPerLevelStat: BuffableStat;
		public var maxLustPerLibStat: BuffableStat;
		public var maxLustMultStat: BuffableStat;
		public var maxWrathBaseStat: BuffableStat;
		public var maxWrathPerLevelStat: BuffableStat;
		public var maxWrathMultStat: BuffableStat;
		public var maxFatigueBaseStat: BuffableStat;
		public var maxFatiguePerLevelStat: BuffableStat;
		public var maxFatiguePerSpeStat: BuffableStat;
		public var maxFatigueMultStat: BuffableStat;
		public var maxManaBaseStat: BuffableStat;
		public var maxManaPerLevelStat: BuffableStat;
		public var maxManaPerIntStat: BuffableStat;
		public var maxManaPerWisStat: BuffableStat;
		public var maxManaMultStat: BuffableStat;
		public var maxSfBaseStat: BuffableStat;
		public var maxSfPerLevelStat: BuffableStat;
		public var maxSfPerWisStat: BuffableStat;
		public var maxSfMultStat: BuffableStat;
		
		public var defStat: BuffableStat; // raw values (1pt = 1%)
		public var mdefStat: BuffableStat; // raw values (1pt = 1%)
		public var rangedAccuracyStat: BuffableStat; // raw values (2pt = 1%)
		public var spellpowerStat: BuffableStat; // multiplier (1pt = 100%)
		public var spellcostStat: BuffableStat; // multiplier (1pt = 100%)
		public var psoulskillPowerStat: BuffableStat; // multiplier (1pt = 100%)
		public var msoulskillPowerStat: BuffableStat; // multiplier (1pt = 100%)
		public var soulskillcostStat: BuffableStat; // multiplier (1pt = 100%)
		public var teaseDmgStat: BuffableStat; // raw values (1pt = 2 tease base lust damage)
		public var evadeStat: BuffableStat; // raw values (1pt = 1 evasion chance)

		public var resPhysicalStat: BuffableStat;
		public var resMagicStat: BuffableStat;
		public var resLustStat: BuffableStat;
		public var resFireStat: BuffableStat;
		public var resIceStat: BuffableStat;
		public var resLightningStat: BuffableStat;
		public var resDarknessStat: BuffableStat;
		public var resPoisonStat: BuffableStat;
		public var resWindStat: BuffableStat;
		public var resWaterStat: BuffableStat;
		public var resEarthStat: BuffableStat;
		public var resAcidStat: BuffableStat;
		public var resPsychicStat: BuffableStat;
		public var resTrueStat: BuffableStat;
		public var resStat: BuffableStat;

		private var _stats: StatStore;


		public function get str():Number { return strStat.value; }
		public function get tou():Number {if (this.hasPerk(PerkLib.IcyFlesh) || this.hasPerk(PerkLib.HaltedVitals)) {
			return 1;
			} else {
				return touStat.value;
			}
		}
		public function get spe():Number { return speStat.value; }
		public function get inte():Number {if (this.statStore.hasBuff("Atavism")) {
			return 1;
			} else {
				return intStat.value;
			}
		}
		public function get wis():Number { return Math.round(wisStat.value); }
		public function get lib():Number { return Math.round(libStat.value); }

		public function canTrain(statName: String, limit:Number):Boolean {
			var stat:PrimaryStat = statStore.findStat(statName) as PrimaryStat;
			return stat.train.value < limit;
		}
		
		/**
		 * Increase stat `statName`'s train component by `amount`, up to `limit`.
		 * @return true if stat was changed
		 */
		public function trainStat(statName: String, amount: Number, limit: Number):Boolean {
			var stat:PrimaryStat = statStore.findStat(statName) as PrimaryStat;
			if (stat.train.value < limit){
				stat.train.value += amount;
				if (stat.train.value > limit){
					stat.train.value = limit;
				}
				CoC.instance.mainView.statsView.refreshStats(CoC.instance);
				CoC.instance.mainView.statsView.showStatUp(statName);
				return true;
			}
			return false;
		}
		public function trainStatCap(statName: String, limit: Number):Number {
			var cap:Number = limit;
			var cap2:Number = 1;
			//cap += 2 * host.perkv1(PerkLib.AscensionTranshumanism);
			if (game.player.hasPerk(PerkLib.MunchkinAtBioLab)) cap2 += 0.1;
			cap *= cap2;
			switch (statName) {
				case "str":
					var str:Number = 1;
					if (game.player.perkv1(IMutationsLib.HumanBonesIM) >= 3) str += 0.2;
					if (game.player.perkv1(IMutationsLib.HumanBonesIM) >= 4) str += 0.1;
					cap *= str;
					break;
				case "tou":
					var tou:Number = 1;
					if (game.player.perkv1(IMutationsLib.HumanBonesIM) >= 3) tou += 0.2;
					if (game.player.perkv1(IMutationsLib.HumanBonesIM) >= 4) tou += 0.1;
					cap *= tou;
					break;
				case "spe":
					var spe:Number = 1;
					if (game.player.perkv1(IMutationsLib.HumanBloodstreamIM) >= 3) spe += 0.2;
					if (game.player.perkv1(IMutationsLib.HumanBloodstreamIM) >= 4) spe += 0.1;
					cap *= spe;
					break;
				case "int":
					var inte:Number = 1;
					if (game.player.perkv1(IMutationsLib.HumanSmartsIM) >= 3) inte += 0.2;
					if (game.player.perkv1(IMutationsLib.HumanSmartsIM) >= 4) inte += 0.1;
					cap *= inte;
					break;
				case "wis":
					//cap += 16 * host.perkv1(PerkLib.AscensionTranshumanismWis);
					//cap += host.perkv1(PerkLib.SoulTempering);
					var wis:Number = 1;
					if (game.player.perkv1(IMutationsLib.HumanSmartsIM) >= 3) wis += 0.2;
					if (game.player.perkv1(IMutationsLib.HumanSmartsIM) >= 4) wis += 0.1;
					cap *= wis;
					break;
				case "lib":
					var lib:Number = 1;
					if (game.player.perkv1(IMutationsLib.HumanBloodstreamIM) >= 3) lib += 0.2;
					if (game.player.perkv1(IMutationsLib.HumanBloodstreamIM) >= 4) lib += 0.1;
					cap *= lib;
					break;
			}
			cap = Math.round(cap);
			return cap;
		}

		/**
		 * Adds a curse effect to the creature.
		 * @param statName 	Name of the stat, like "str" or "spe.mult"
		 * @param power		Curse power to substract from or add to (cor or sens) stat.
		 * @param tier		Effect tier (1,2,3). 1 - mutagen debuffs. 2 - caused by monsters. 3 - high-level attack effects.
		 */
		public function addCurse(statName:String, power:Number, tier:int = 2):void{
			if (tier < 1 || tier > 3) CoC_Settings.error("Invalid curse tier!");
			var tierPower:String = 	tier == 1 ? "Weakened" :
									tier == 2 ? "Drained" :
												"Damaged";
			if (this.hasPerk(PerkLib.ZenjisInfluence2)) power *= 0.60;
			if (statName == "sens" || statName == "cor") {
				statStore.addBuff(statName, power, tierPower, {text: tierPower});
				CoC.instance.mainView.statsView.refreshStats(CoC.instance);
				CoC.instance.mainView.statsView.showStatUp(statName);
			} else {
				statStore.addBuff(statName, -power, tierPower, {text: tierPower});
				CoC.instance.mainView.statsView.refreshStats(CoC.instance);
				CoC.instance.mainView.statsView.showStatDown(statName);
			}
		}

		/**
		 * Weakens or removes the curse from the creature. Each tier removes only the curse of its level!
		 * @param statName 	Name of the stat, like "str" or "spe.mult"
		 * @param power		Curse power to substract from or add to (cor or sens) stat.
		 * @param tier		Effect tier (1,2,3). 1 - mutagen debuffs. 2 - caused by monsters. 3 - high-level attack effects. Negative - removes the highest (-2 => 2 or 1), then part of the lowest (2=0.5, 1=1.0, power=1. Removed 2, decreased 1=0.5)
		 * @return			Change magnitude (always >0)
		 */
		public function removeCurse(statName:String, power:Number, tier:int = -2):Number {
			if (tier > 3) CoC_Settings.error("Invalid curse tier!");
			var tierPower:String;
			if (tier == 0) tier = -3; //set to (-max)
			if (tier < 0) {
				var remPower:Number = power;
				var curTier:Number = -tier;
				while (remPower > 0 && curTier > 0) { //while power left
					remPower -= removeCurse(statName, remPower, curTier); //change current tier
					--curTier; //decrease tier
				}
				return power - remPower;
			}
			tierPower = tier == 1 ? "Weakened" :
				tier == 2 ? "Drained" :
					"Damaged";
			var stat:BuffableStat = statStore.findBuffableStat(statName);
			if (!stat) {
				// Error? No stat with such name
				throw new Error("No such stat "+statName);
			}
			var current:Number = stat.valueOfBuff(tierPower);
			var change:Number = 0;
			if (statName == "sens" || statName == "cor") {
				if (current > 0) {
					if (power >= current) {
						stat.removeBuff(tierPower);
						CoC.instance.mainView.statsView.refreshStats(CoC.instance);
						CoC.instance.mainView.statsView.showStatDown(statName);
						change = current;
					} else if (power < current) {
						stat.addOrIncreaseBuff(tierPower, -power);
						CoC.instance.mainView.statsView.refreshStats(CoC.instance);
						CoC.instance.mainView.statsView.showStatUp(statName);
						change = power;
					}
				}
			}
			else {
				if (current < 0) {
					if (power >= -current) {
						stat.removeBuff(tierPower);
						CoC.instance.mainView.statsView.refreshStats(CoC.instance);
						CoC.instance.mainView.statsView.showStatUp(statName);
						change = -current;
					} else if (power < -current) {
						stat.addOrIncreaseBuff(tierPower, power);
						CoC.instance.mainView.statsView.refreshStats(CoC.instance);
						CoC.instance.mainView.statsView.showStatDown(statName);
						change = power;
					}
				}
			}
			return change;
		}

		//Primary stats
		public function get sens():Number { return sensStat.value; }
		public var cor:Number = 0;
		public var fatigue:Number = 0;
		public var mana:Number = 0;
		public var soulforce:Number = 0;
		public var demonicenergy:Number = 0;

		//Combat Stats
		public var HP:Number = 0;
		public var lust:Number = 0;
		public var wrath:Number = 0;

		//Level Stats
		//public var XP:Number = 0;
		private var _xp:Number = 0
		public function get XP():Number { return _xp; } //Returns the object
		public function set XP(value:Number):void { _xp = value; }
		
		// public var level:Number = 0;
		private var _level:Number = 0;
		public function get level():Number { return _level; }
		public function set level(value:Number):void { _level = value; }
		// Can't imagine why you would want to do this but it's there to bypass player override
		public function setLevelDirectly(value:Number):void { _level = value; }
		
		// TODO: (lvl) Implement stat scaling to negative levels -- and for monsters? Maybe some kind of level drain mechanics?
		private var _negativeLevel:Number = 0;
		public function get negativeLevel():Number { return _negativeLevel; }
		public function set negativeLevel(value:Number):void { _negativeLevel = value; }
		
		//public var additionalXP:Number = 0;
		private var _additionalXP:Number = 0;
		public function get additionalXP():Number { return _additionalXP; }
		public function set additionalXP(value:Number):void { _additionalXP = value; }
		public var gems:Number = 0;
		
		
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

		private var _savedHPRatio:Number = 1;
		public function saveHPRatio():void {
			_savedHPRatio = HP / maxHP();
		}
		public function restoreHPRatio():void {
			HP = _savedHPRatio*maxHP();
		}
		
		public function minLust():Number {
			var max:Number = maxLust();
			return boundFloat(0, minLustStat.value + max*minLustXStat.value, max);
		}
		public function minLib():Number {
			return 1;
		}
		public function minSens():Number {
			return 10;
		}
		protected function maxHP_base():Number {
			var max:Number = maxHpBaseStat.value;
			var multimax:Number = maxHpMultStat.value;
			if (hasPerk(PerkLib.IcyFlesh)) {
				max += int(inte * 2 + 50);
				if (inte >= 21) max += Math.round(inte);
				if (inte >= 41) max += Math.round(inte);
				if (inte >= 61) max += Math.round(inte);
				if (inte >= 81) max += Math.round(inte);
				if (inte >= 101) max += Math.round(inte) * Math.floor( (inte-100)/50 + 1);
				if (perkv1(IMutationsLib.FrozenHeartIM) >= 3) max *= 1.5;
			}
			else if (hasPerk(PerkLib.HaltedVitals) || hasPerk(PerkLib.Undeath)) {
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
				if (hasPerk(PerkLib.DeathPriest)) {
					max += int(wis * 2 + 50);
					if (wis >= 21) max += Math.round(wis);
					if (wis >= 41) max += Math.round(wis);
					if (wis >= 61) max += Math.round(wis);
					if (wis >= 81) max += Math.round(wis);
					if (wis >= 101) max += Math.round(wis) * Math.floor( (wis-100)/50 + 1);
				}
			}
			if (hasPerk(PerkLib.IcyFlesh)) {
				if (perkv1(IMutationsLib.FrozenHeartIM) >= 3) {
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
				if (hasPerk(PerkLib.TankVI)) max += Math.round(tou * 12);
				if (hasPerk(PerkLib.DeathPriest)) {
					if (hasPerk(PerkLib.TankI)) max += Math.round(wis*12);
					if (hasPerk(PerkLib.TankII)) max += Math.round(wis*12);
					if (hasPerk(PerkLib.TankIII)) max += Math.round(wis*12);
					if (hasPerk(PerkLib.TankIV)) max += Math.round(wis*12);
					if (hasPerk(PerkLib.TankV)) max += Math.round(wis*12);
					if (hasPerk(PerkLib.TankVI)) max += Math.round(wis*12);
				}
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
				if (hasStatusEffect(StatusEffects.SummonedElementalsAirE)) max += maxHP_ElementalBondFleshMulti() * 20 * statusEffectv2(StatusEffects.SummonedElementalsAirE);
				if (hasStatusEffect(StatusEffects.SummonedElementalsEarthE)) max += maxHP_ElementalBondFleshMulti() * 20 * statusEffectv2(StatusEffects.SummonedElementalsEarthE);
				if (hasStatusEffect(StatusEffects.SummonedElementalsFireE)) max += maxHP_ElementalBondFleshMulti() * 20 * statusEffectv2(StatusEffects.SummonedElementalsFireE);
				if (hasStatusEffect(StatusEffects.SummonedElementalsWaterE)) max += maxHP_ElementalBondFleshMulti() * 20 * statusEffectv2(StatusEffects.SummonedElementalsWaterE);
			}
			if (hasPerk(PerkLib.JobGuardian)) max += 120;
			if (hasPerk(PerkLib.FleshBodyApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) max += (400 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]) * game.player.humanBodyCultivators());
				if (hasPerk(PerkLib.SoulPersonage)) max += (400 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]) * game.player.humanBodyCultivators());
				if (hasPerk(PerkLib.SoulWarrior)) max += (400 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]) * game.player.humanBodyCultivators());
			}
			if (hasPerk(PerkLib.FleshBodyWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) max += (800 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]) * game.player.humanBodyCultivators());
				if (hasPerk(PerkLib.SoulScholar)) max += (800 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]) * game.player.humanBodyCultivators());
				if (hasPerk(PerkLib.SoulGrandmaster)) max += (800 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]) * game.player.humanBodyCultivators());
			}
			if (hasPerk(PerkLib.FleshBodyElderStage)) {
				if (hasPerk(PerkLib.SoulElder)) max += (1200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]) * game.player.humanBodyCultivators());
				if (hasPerk(PerkLib.SoulExalt)) max += (1200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]) * game.player.humanBodyCultivators());
				if (hasPerk(PerkLib.SoulOverlord)) max += (1200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]) * game.player.humanBodyCultivators());
			}
			if (hasPerk(PerkLib.FleshBodyOverlordStage)) {
				if (hasPerk(PerkLib.SoulTyrant)) max += (1600 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]) * game.player.humanBodyCultivators());
				if (hasPerk(PerkLib.SoulKing)) max += (1600 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]) * game.player.humanBodyCultivators());
				if (hasPerk(PerkLib.SoulEmperor)) max += (1600 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]) * game.player.humanBodyCultivators());
			}
			if (hasPerk(PerkLib.FleshBodyTyrantStage)) {
				if (hasPerk(PerkLib.SoulAncestor)) max += (2000 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]) * game.player.humanBodyCultivators());
			}
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) max += (600 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) max += (900 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) max += (1200 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) max += (1500 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) max += (1800 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.AscensionHardiness)) max += perkv1(PerkLib.AscensionHardiness) * 400;
			if (hasPerk(PerkLib.ChiReflowDefense)) max += UmasShop.NEEDLEWORK_DEFENSE_EXTRA_HP;
			max += level * maxHpPerLevelStat.value;
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
			if (game.player.vehiclesName == "Goblin Mech Alpha") {
				if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) maxHP_mult1 += 0.2;
				if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) maxHP_mult1 += 0.4;
				if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) maxHP_mult1 += 0.6;
				if (game.player.hasKeyItem("Upgraded Armor plating 4.0") >= 0) maxHP_mult1 += 0.8;
				if (game.player.hasKeyItem("Upgraded Armor plating 5.0") >= 0) maxHP_mult1 += 1;
				if (game.player.hasKeyItem("Upgraded Armor plating 6.0") >= 0) maxHP_mult1 += 1.2;
			}
			if (game.player.vehiclesName == "Goblin Mech Prime") {
				if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) maxHP_mult1 += 0.4;
				if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) maxHP_mult1 += 0.8;
				if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) maxHP_mult1 += 1.2;
				if (game.player.hasKeyItem("Upgraded Armor plating 4.0") >= 0) maxHP_mult1 += 1.6;
				if (game.player.hasKeyItem("Upgraded Armor plating 5.0") >= 0) maxHP_mult1 += 2;
				if (game.player.hasKeyItem("Upgraded Armor plating 6.0") >= 0) maxHP_mult1 += 2.4;
			}
			if (game.player.vehiclesName == "Giant Slayer Mech") {
				if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) maxHP_mult1 += 0.25;
				if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) maxHP_mult1 += 0.5;
				if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) maxHP_mult1 += 0.75;
				if (game.player.hasKeyItem("Upgraded Armor plating 4.0") >= 0) maxHP_mult1 += 1;
				if (game.player.hasKeyItem("Upgraded Armor plating 5.0") >= 0) maxHP_mult1 += 1.25;
				if (game.player.hasKeyItem("Upgraded Armor plating 6.0") >= 0) maxHP_mult1 += 1.5;
				if (game.player.hasKeyItem("Upgraded Leather Insulation 1.0") >= 0) maxHP_mult1 += 0.25;
				if (game.player.hasKeyItem("Upgraded Leather Insulation 2.0") >= 0) maxHP_mult1 += 0.5;
				if (game.player.hasKeyItem("Upgraded Leather Insulation 3.0") >= 0) maxHP_mult1 += 0.75;
			}
			if (game.player.vehiclesName == "Howling Banshee Mech") {
				if (game.player.hasKeyItem("HB Armor Plating") >= 1) maxHP_mult1 += 0.25;
				if (game.player.hasKeyItem("HB Armor Plating") >= 2) maxHP_mult1 += 0.5;
				if (game.player.hasKeyItem("HB Armor Plating") >= 3) maxHP_mult1 += 0.75;
				if (game.player.hasKeyItem("HB Armor Plating") >= 4) maxHP_mult1 += 1;
				if (game.player.hasKeyItem("HB Armor Plating") >= 5) maxHP_mult1 += 1.25;
				if (game.player.hasKeyItem("HB Armor Plating") >= 6) maxHP_mult1 += 1.5;
				if (game.player.hasKeyItem("HB Armor Plating") >= 7) maxHP_mult1 += 1.75;
				if (game.player.hasKeyItem("HB Leather Insulation") >= 1) maxHP_mult1 += 0.25;
				if (game.player.hasKeyItem("HB Leather Insulation") >= 2) maxHP_mult1 += 0.5;
				if (game.player.hasKeyItem("HB Leather Insulation") >= 3) maxHP_mult1 += 0.75;
				if (game.player.hasKeyItem("HB Leather Insulation") >= 4) maxHP_mult1 += 1;
				if (game.player.hasKeyItem("HB Leather Insulation") >= 5) maxHP_mult1 += 1.25;
				if (game.player.hasKeyItem("HB Leather Insulation") >= 6) maxHP_mult1 += 1.5;
				if (game.player.hasKeyItem("HB Leather Insulation") >= 7) maxHP_mult1 += 1.75;
			}
			if (game.player.hasPerk(PerkLib.SharedPower) && game.player.perkv1(PerkLib.SharedPower) > 0) maxHP_mult1 += (0.1*game.player.perkv1(PerkLib.SharedPower));
			return maxHP_mult1;
		}
		public function maxHP():Number {
			var max:Number = Math.round(maxHP_base()*maxHP_mult());
			return Math.min(19999999,max);
		}
		public function maxOverHP():Number {
			var maxOver:Number = maxHP();
			var maxOver2:Number = 1;
			if (hasPerk(PerkLib.HiddenJobBloodDemon)) maxOver2 += 0.1;
			if (hasPerk(PerkLib.WayOfTheBlood)) maxOver2 += 0.1;
			if (hasPerk(PerkLib.BloodDemonToughness)) maxOver2 += 0.1;
			if (hasPerk(PerkLib.MyBloodForBloodPuppies)) maxOver2 += 0.1;
			if (hasPerk(PerkLib.YourPainMyPower)) maxOver2 += 0.1;
			if (hasPerk(PerkLib.BloodDemonIntelligence)) maxOver2 += 0.1;
			//
			//
			if (hasPerk(PerkLib.BloodDemonWisdom)) maxOver2 += 0.1;
			if (hasPerk(PerkLib.MunchkinAtWork)) maxOver2 += 0.1;
			if (hasPerk(PerkLib.SPSurvivalTrainingX)) {
				var limit:Number = perkv1(PerkLib.SPSurvivalTrainingX) * 10;
				var bonus:Number = Math.round((level - 1) / 3);
				if (bonus > limit) bonus = limit;
				maxOver2 += (0.01 * bonus);
			}
			if (perkv1(IMutationsLib.LizanMarrowIM) >= 4) maxOver2 += 0.1;
			if (perkv1(IMutationsLib.FerasBirthrightIM) >= 4) maxOver2 += 0.2;
			if (perkv1(IMutationsLib.HumanBonesIM) >= 4) maxOver2 += 0.1;
			if (hasPerk(PerkLib.Soulless)) maxOver2 += (0.01 * level);
			maxOver *= maxOver2;//~270%
			maxOver = Math.round(maxOver);
			return Math.min(54999999,maxOver);
		}
		public function minHP():Number {
			return 0;
		}
		protected function maxLust_base():Number {
			var max:Number = maxLustBaseStat.value;
			var multimax:Number = maxLustMultStat.value;
			max += maxLustPerLibStat.value*lib;
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
				if (hasStatusEffect(StatusEffects.SummonedElementalsAirE)) max += maxLust_ElementalBondUrgesMulti() * 15 * statusEffectv2(StatusEffects.SummonedElementalsAirE);
				if (hasStatusEffect(StatusEffects.SummonedElementalsEarthE)) max += maxLust_ElementalBondUrgesMulti() * 15 * statusEffectv2(StatusEffects.SummonedElementalsEarthE);
				if (hasStatusEffect(StatusEffects.SummonedElementalsFireE)) max += maxLust_ElementalBondUrgesMulti() * 15 * statusEffectv2(StatusEffects.SummonedElementalsFireE);
				if (hasStatusEffect(StatusEffects.SummonedElementalsWaterE)) max += maxLust_ElementalBondUrgesMulti() * 15 * statusEffectv2(StatusEffects.SummonedElementalsWaterE);
			}
			if (hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) max += (150 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) max += (225 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) max += (300 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) max += (375 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) max += (450 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (hasPerk(PerkLib.AscensionDesires)) max += perkv1(PerkLib.AscensionDesires) * 30;
			max += level * maxLustPerLevelStat.value;
			if (level <= 6) max += level * 3;
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
			var maxmult:Number = 1;
			if (TyrantiaFollower.TyrantiaTrainingSessions > 0.5) maxmult += 0.01 * TyrantiaFollower.TyrantiaTrainingSessions;
			return maxmult;
		}
		public function maxLust():Number {
			var max:Number = Math.round(maxLust_base()*maxLust_mult());
			return Math.min(699999,max);
		}
		public function maxOverLust():Number {
			var max1:Number = Math.round(maxLust_base()*maxLust_mult());
			var max2:Number = 1;
			if (hasPerk(PerkLib.MunchkinAtWork)) max2 += 0.1;
			if (hasPerk(PerkLib.SPSurvivalTrainingX)) {
				var limit:Number = perkv1(PerkLib.SPSurvivalTrainingX) * 10;
				var bonus:Number = Math.round((level - 1) / 3);
				if (bonus > limit) bonus = limit;
				max2 += (0.01 * bonus);
			}
			if (perkv1(IMutationsLib.MinotaurTesticlesIM) >= 4 && hasCock()) max2 += 0.1;
			if (perkv1(IMutationsLib.LactaBovinaOvariesIM) >= 4 && hasVagina()) max2 += 0.1;
			if (perkv1(IMutationsLib.HumanTesticlesIM) >= 4 && hasCock()) max2 += 0.1;
			if (perkv1(IMutationsLib.HumanOvariesIM) >= 4 && hasVagina()) max2 += 0.1;
			max1 *= max2;//~230%
			max1 = Math.round(max1);
			return Math.min(1609999,max1);
		}
		public function maxFatigue():Number {
			return 150;
		}
		public function maxOverFatigue():Number {
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
		public function maxOverSoulforce():Number {
			return 0;
		}
		public function maxMana():Number {
			return 0;
		}
		public function maxOverMana():Number {
			return 0;
		}
		public function maxDemonicEnergy():Number {
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
			modStats(argz.str, argz.tou, argz.spe, argz.inte, argz.wis, argz.lib, argz.sens, argz.lust, argz.cor, argz.scale);
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
		public function modStats(dstr:Number, dtou:Number, dspe:Number, dint:Number, dwis:Number, dlib:Number, dsens:Number, dlust:Number, dcor:Number, scale:Boolean):void {
			var mins:Object = getAllMinStats();
			mins.lust = minLust();
			var oldHPratio:Number = hp100/100;
			//Strength
			if (dstr < 0){
				addCurse("str", -dstr,2);
			}
			if (dstr > 0){
				removeCurse("str", dstr,2);
			}
			//toughness
			if (dtou < 0){
				addCurse("tou", -dtou,2);
			}
			if (dtou > 0){
				removeCurse("tou", dtou,2);
			}
			//Speed
			if (dspe < 0){
				addCurse("spe", -dspe,2);
			}
			if (dspe > 0){
				removeCurse("spe", dspe,2);
			}
			//Intelligence
			if (dint < 0){
				addCurse("int", -dint,2);
			}
			if (dint > 0){
				removeCurse("int", dint,2);
			}
			//Wisdom
			if (dwis < 0){
				addCurse("wis", -dwis,2);
			}
			if (dwis > 0){
				removeCurse("wis", dwis,2);
			}
			//Libido
			if (dlib < 0){
				addCurse("lib", -dlib,2);
			}
			if (dlib > 0){
				removeCurse("lib", dlib,2);
			}
			//Sensitivity
			if (dsens > 0){
				addCurse("sens", dsens,2);
			}
			if (dsens < 0){
				removeCurse("sens", -dsens,2);
			}
			lust = Utils.boundFloat(mins.lust, lust + dlust, maxOverLust());
			cor  = Utils.boundFloat(mins.cor, cor + dcor, 100);
            if (cor < 1.0) cor = 0;//check [0,1] to avoid confusion

			// old_hp / old_max = new_hp / new_max
			HP = oldHPratio * maxHP();

			// Keep values in bounds (lust and HP handled above)
			fatigue = Math.min(fatigue, maxFatigue());
			mana = Math.min(mana, maxOverMana());
			soulforce = Math.min(soulforce, maxOverSoulforce());
			wrath = Math.min(wrath,maxOverWrath());
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
		public function takeWindDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takeWaterDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takeEarthDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takeAcidDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takePsychicDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takeTrueDamage(damage:Number, display:Boolean = false):Number {
			HP = boundFloat(0,HP-Math.round(damage),HP);
			return (damage > 0 && damage < 1) ? 1 : damage;
		}
		public function takeLustDamage(lustDmg:Number, display:Boolean = false, applyRes:Boolean = true):Number{
			if (applyRes) lustDmg *= lustPercent()/100; //the same as dynStats("lus", lustDmg, applyRes);
			var ldi:int = int(lustDmg);
			dynStats("lus", ldi);
			if (display) SceneLib.combat.CommasForDigits(ldi, true);
			return ldi;
		}
		/**
		 * Get the remaining fatigue of the Creature.
		 * @return maximum amount of fatigue that still can be used
		 */
		public function fatigueLeft():Number
		{
			return maxOverFatigue() - fatigue;
		}

		/**
		 * @return 0: did not avoid; 1-3: avoid with varying difference between
		 * speeds (1: narrowly avoid, 3: deftly avoid)
		 */
		public function speedDodge(creature:Creature):int {
			return calcSpeedDodge(creature.spe);
		}

		/**
		 * @return 0: did not avoid; 1-3: avoid with varying difference between
		 * speeds (1: narrowly avoid, 3: deftly avoid)
		 */
		public function calcSpeedDodge(attackSpeed:int):int {
			var diff:Number = spe - attackSpeed;
			var rnd:int = int(Math.random() * ((diff / 4) + 80));
			if (rnd<=80) return 0;
			else if (diff<8) return 1;
			else if (diff<20) return 2;
			else return 3;
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
		public function get tallness():Number {
			var multiplier:Number = 1;
			if (hasPerk(PerkLib.TitanicSize)) multiplier = 5;
			return basetallness*multiplier;
		}

		public function get basetallness():Number {
			return _tallness;
		}

		public function get effectiveTallness():Number {
			var multiplier:Number = 1;
			if (hasPerk(PerkLib.GiantMight)) multiplier += 4;
			return tallness*multiplier;
		}

		public function set tallness(value:Number):void {
			var multiplier:Number = 1;
			if (hasPerk(PerkLib.TitanicSize)) multiplier += 4;
			_tallness = value*multiplier;
		}
		
		public var bodyMaterials:/*BodyMaterial*/Array = [];
		public var hairType:Number                     = Hair.NORMAL;
		public var hairStyle:Number                    = Hair.NORMAL;
		public var hairLength:Number                   = 0;
		public function get hairColor():String {
			return bodyMaterials[BodyMaterial.HAIR].color;
		}
		public function get hairColor1():String {
			return bodyMaterials[BodyMaterial.HAIR].color1;
		}
		public function get hairColor2():String {
			return bodyMaterials[BodyMaterial.HAIR].color2;
		}
		public function set hairColor1(value:String):void {
			bodyMaterials[BodyMaterial.HAIR].color1 = value;
		}
		public function set hairColor2(value:String):void {
			bodyMaterials[BodyMaterial.HAIR].color2 = value;
		}
		public function set hairColor(value:String):void {
			bodyMaterials[BodyMaterial.HAIR].color = value;
		}

		public function get coatColor():String {
			return skin.coat.color;
		}
		public function set coatColor(value:String):void {
			if (!skin.hasCoat()) trace("[WARNING] set coatColor() called with no coat");
			skin.coat.color = value;
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
		public function get skinColor():String {
			return bodyMaterials[BodyMaterial.SKIN].color;
		}
		public function set skinColor(value:String):void {
			bodyMaterials[BodyMaterial.SKIN].color = value;
		}
		public function get skinColor1():String {
			return bodyMaterials[BodyMaterial.SKIN].color1;
		}
		public function set skinColor1(value:String):void {
			bodyMaterials[BodyMaterial.SKIN].color1 = value;
		}
		public function get skinColor2():String {
			return bodyMaterials[BodyMaterial.SKIN].color2;
		}
		public function set skinColor2(value:String):void {
			bodyMaterials[BodyMaterial.SKIN].color2 = value;
		}

		public var skinColor3:String = "black";

		public function get furColor():String {
			return bodyMaterials[BodyMaterial.FUR].color;
		}
		public function set furColor(value:String):void {
			bodyMaterials[BodyMaterial.FUR].color = value;
		}
		public function get furColor1():String {
			return bodyMaterials[BodyMaterial.FUR].color1;
		}
		public function set furColor1(value:String):void {
			bodyMaterials[BodyMaterial.FUR].color1 = value;
		}
		public function get furColor2():String {
			return bodyMaterials[BodyMaterial.FUR].color2;
		}
		public function set furColor2(value:String):void {
			bodyMaterials[BodyMaterial.FUR].color2 = value;
		}
		public function get scaleColor():String {
			return bodyMaterials[BodyMaterial.SCALES].color;
		}
		public function set scaleColor(value:String):void {
			bodyMaterials[BodyMaterial.SCALES].color = value;
		}
		public function get scaleColor1():String {
			return bodyMaterials[BodyMaterial.SCALES].color1;
		}
		public function set scaleColor1(value:String):void {
			bodyMaterials[BodyMaterial.SCALES].color1 = value;
		}
		public function get scaleColor2():String {
			return bodyMaterials[BodyMaterial.SCALES].color2;
		}
		public function set scaleColor2(value:String):void {
			bodyMaterials[BodyMaterial.SCALES].color2 = value;
		}
		public function get chitinColor():String {
			return bodyMaterials[BodyMaterial.CHITIN].color;
		}
		public function set chitinColor(value:String):void {
			bodyMaterials[BodyMaterial.CHITIN].color = value;
		}
		public function get chitinColor1():String {
			return bodyMaterials[BodyMaterial.CHITIN].color1;
		}
		public function set chitinColor1(value:String):void {
			bodyMaterials[BodyMaterial.CHITIN].color1 = value;
		}
		public function get chitinColor2():String {
			return bodyMaterials[BodyMaterial.CHITIN].color2;
		}
		public function set chitinColor2(value:String):void {
			bodyMaterials[BodyMaterial.CHITIN].color2 = value;
		}
		public function get featherColor():String {
			return bodyMaterials[BodyMaterial.FEATHERS].color;
		}
		public function set featherColor(value:String):void {
			bodyMaterials[BodyMaterial.FEATHERS].color = value;
		}
		public function get featherColor1():String {
			return bodyMaterials[BodyMaterial.FEATHERS].color1;
		}
		public function set featherColor1(value:String):void {
			bodyMaterials[BodyMaterial.FEATHERS].color1 = value;
		}
		public function get featherColor2():String {
			return bodyMaterials[BodyMaterial.FEATHERS].color2;
		}
		public function set featherColor2(value:String):void {
			bodyMaterials[BodyMaterial.FEATHERS].color2 = value;
		}
		public function get bodyColor():String {
			return skin.color;
		}
		public function set bodyColor(value:String):void {
			skin.color = value;
		}
		public function bodyMaterialColor(type:int):String {
			return bodyMaterials[type].color;
		}
		public function bodyMaterialColor1(type:int):String {
			return bodyMaterials[type].color1;
		}
		public function bodyMaterialColor2(type:int):String {
			return bodyMaterials[type].color2;
		}
		public function setBodyMaterialColor(type:int, value:String):void {
			bodyMaterials[type].color = value;
		}
		public function setBodyMaterialColor1(type:int, value:String):void {
			bodyMaterials[type].color1 = value;
		}
		public function setBodyMaterialColor2(type:int, value:String):void {
			bodyMaterials[type].color2 = value;
		}
		public function hasBodyMaterial(type:int):Boolean {
			if (type == BodyMaterial.SKIN) return true; // right?
			if (type == BodyMaterial.HAIR) {
				if (hairLength > 0 || beardLength > 0) return true;
			}
			for each (var bp:BodyPart in bodyParts) {
				if (bp.hasMaterial(type)) return true;
			}
			return false;
		}
		public function hasSkinMaterial():Boolean {
			return hasBodyMaterial(BodyMaterial.SKIN);
		}
		public function hasHairMaterial():Boolean {
			return hasBodyMaterial(BodyMaterial.HAIR);
		}
		public function hasFurMaterial():Boolean {
			return hasBodyMaterial(BodyMaterial.FUR);
		}
		public function hasScaleMaterial():Boolean {
			return hasBodyMaterial(BodyMaterial.SCALES);
		}
		public function hasChitinMaterial():Boolean {
			return hasBodyMaterial(BodyMaterial.CHITIN);
		}
		public function hasFeatherMaterial():Boolean {
			return hasBodyMaterial(BodyMaterial.FEATHERS);
		}
		public var bodyParts:/*BodyPart*/Array = [];
		public function hasCoat():Boolean { return skin.hasCoat(); }
		public function hasFullCoat():Boolean { return skin.hasFullCoat(); }
		/**
		 * @return -1 if hasCoat(), skin.coat.type otherwise
		 */
		public function coatType():int { return skin.coatType(); }
		public function hasCoatOfType(...types:Array):Boolean { return skin.hasCoatOfType.apply(skin,types); }
		public function hasFullCoatOfType(...types:Array):Boolean { return skin.hasFullCoatOfType.apply(skin,types); }
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
		public var ears:Ears;
		public var horns:Horns;
		public var wings:Wings;

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


		public var hips:Hips;
		public var butt:Butt;

		//Piercings
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
		public var antennae:Antennae;
		public var eyes:Eyes;
		public var tongue:Tongue;
		public var arms:Arms;

		public var gills:Gills;
		public function hasGills():Boolean { return gills.type != Gills.NONE; }

		public var rearBody:RearBody;

		//Sexual Stuff
		//MALE STUFF
		//public var cocks:Array;
		public var cocks:/*Cock*/Array;
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
		public var vaginas:Vector.<VaginaClass>;
		//Fertility is a % out of 100.
		public var fertility:Number = 10;
		public var nippleLength:Number = .25;
		public var breastRows:/*BreastRowClass*/Array;
		public var ass:AssClass = new AssClass();

		public function get clitLength():Number {
			if (vaginas.length==0) {
				CoC_Settings.error("get clitLength called with no vaginas present");
				return VaginaClass.DEFAULT_CLIT_LENGTH;
			}
			return vaginas[0].clitLength;
		}

		public function set clitLength(value:Number):void {
			if (vaginas.length==0) {
				CoC_Settings.error("set clitLength called with no vaginas present");
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
			
			minLustStat = new BuffableStat(this, 'minlust', {base:0});
			minLustXStat = new BuffableStat(this, 'minlustx', {base:0});
			maxHpBaseStat = new BuffableStat(this, 'maxhp_base', {base:0});
			maxHpPerLevelStat = new BuffableStat(this, 'maxhp_perlevel', {base:60});
			maxHpMultStat = new BuffableStat(this, 'maxhp_mult', {base:1});
			maxLustBaseStat = new BuffableStat(this, 'maxlust_base', {base:100});
			maxLustPerLevelStat = new BuffableStat(this, 'maxlust_perlevel', {base:3});
			maxLustPerLibStat = new BuffableStat(this, 'maxlust_perlib', {base:0});
			maxLustMultStat = new BuffableStat(this, 'maxlust_mult', {base:1});
			maxWrathBaseStat = new BuffableStat(this, 'maxwrath_base', {base:500});
			maxWrathPerLevelStat = new BuffableStat(this, 'maxwrath_perlevel', {base:5});
			maxWrathMultStat = new BuffableStat(this, 'maxwrath_mult', {base:1});
			maxFatigueBaseStat = new BuffableStat(this, 'maxfatigue_base', {base:150});
			maxFatiguePerLevelStat = new BuffableStat(this, 'maxfatigue_perlevel', {base:5});
			maxFatiguePerSpeStat = new BuffableStat(this, 'maxfatigue_perspe', {base:0});
			maxFatigueMultStat = new BuffableStat(this, 'maxfatigue_mult', {base:1});
			maxManaBaseStat = new BuffableStat(this, 'maxmana_base', {base:300});
			maxManaPerLevelStat = new BuffableStat(this, 'maxmana_perlevel', {base:10});
			maxManaPerIntStat = new BuffableStat(this, 'maxmana_perint', {base:0});
			maxManaPerWisStat = new BuffableStat(this, 'maxmana_perwis', {base:0});
			maxManaMultStat = new BuffableStat(this, 'maxmana_mult', {base:1});
			maxSfBaseStat = new BuffableStat(this, 'maxsf_base', {base:50});
			maxSfPerLevelStat = new BuffableStat(this, 'maxsf_perlevel', {base:5});
			maxSfPerWisStat = new BuffableStat(this, 'maxsf_perwis', {base:0});
			maxSfMultStat = new BuffableStat(this, 'maxsf_mult', {base:1});
			
			defStat = new BuffableStat(this, 'def', {base:0});
			mdefStat = new BuffableStat(this, 'mdef', {base:0});
			rangedAccuracyStat = new BuffableStat(this, 'rangedaccuracy', {base:0});
			spellpowerStat = new BuffableStat(this, 'spellpower', {base:1});
			spellcostStat = new BuffableStat(this, 'spellcost', {base:1});
			psoulskillPowerStat = new BuffableStat(this, 'psoulskillpower', {base:1});
			msoulskillPowerStat = new BuffableStat(this, 'msoulskillpower', {base:1});
			soulskillcostStat = new BuffableStat(this, 'soulskillcost', {base:1});
			teaseDmgStat = new BuffableStat(this, 'teasedmg', {base:0});
			evadeStat = new BuffableStat(this, 'evade', {base:0});

			resPhysicalStat = new BuffableStat(this, 'res_physical', {base:0});
			resMagicStat = new BuffableStat(this, 'res_magic', {base:0});
			resLustStat = new BuffableStat(this, 'res_lust', {base:0});
			resFireStat = new BuffableStat(this, 'res_fire', {base:0});
			resIceStat = new BuffableStat(this, 'res_ice', {base:0});
			resLightningStat = new BuffableStat(this, 'res_lightning', {base:0});
			resDarknessStat = new BuffableStat(this, 'res_darkness', {base:0});
			resPoisonStat = new BuffableStat(this, 'res_poison', {base:0});
			resWindStat = new BuffableStat(this, 'res_wind', {base:0});
			resWaterStat = new BuffableStat(this, 'res_water', {base:0});
			resEarthStat = new BuffableStat(this, 'res_earth', {base:0});
			resAcidStat = new BuffableStat(this, 'res_acid', {base:0});
			resPsychicStat = new BuffableStat(this, 'res_psychich', {base:0});
			resTrueStat = new BuffableStat(this, 'res_true', {base:0});

			_stats = new StatStore([
				strStat,
				touStat,
				speStat,
				intStat,
				wisStat,
				libStat,
				sensStat,
				
				minLustStat,
				minLustXStat,
				maxHpBaseStat,
				maxHpPerLevelStat,
				maxHpMultStat,
				maxLustBaseStat,
				maxLustPerLevelStat,
				maxLustPerLibStat,
				maxLustMultStat,
				maxWrathBaseStat,
				maxWrathPerLevelStat,
				maxWrathMultStat,
				maxFatigueBaseStat,
				maxFatiguePerLevelStat,
				maxFatiguePerSpeStat,
				maxFatigueMultStat,
				maxManaBaseStat,
				maxManaPerLevelStat,
				maxManaPerIntStat,
				maxManaPerWisStat,
				maxManaMultStat,
				maxSfBaseStat,
				maxSfPerLevelStat,
				maxSfPerWisStat,
				maxSfMultStat,
				
				defStat,
				mdefStat,
				rangedAccuracyStat,
				spellpowerStat,
				spellcostStat,
				psoulskillPowerStat,
				msoulskillPowerStat,
				soulskillcostStat,
				teaseDmgStat,
				evadeStat,
				
				resPhysicalStat,
				resMagicStat,
				resLustStat,
				resFireStat,
				resIceStat,
				resLightningStat,
				resDarknessStat,
				resPoisonStat,
				resWindStat,
				resWaterStat,
				resEarthStat,
				resAcidStat,
				resPsychicStat,
				resTrueStat,
			]);
			
			for (var i:int = 0; i<BodyMaterial.Types.length; i++) {
				bodyMaterials[i] = new BodyMaterial(this, i);
			}
			antennae = new Antennae(this);
			arms = new Arms(this);
			butt = new Butt(this);
			clawsPart = new Claws(this);
			ears = new Ears(this);
			eyes = new Eyes(this);
			facePart = new Face(this);
			gills = new Gills(this);
			horns = new Horns(this);
			hips = new Hips(this);
			lowerBodyPart = new LowerBody(this);
			rearBody = new RearBody(this);
			skin = new Skin(this);
			tail = new Tail(this);
			tongue = new Tongue(this);
			underBody = new UnderBody(this);
			wings = new Wings(this);
			//cocks = new Array();
			//The world isn't ready for typed Arrays just yet.
			cocks         = [];
			vaginas       = new Vector.<VaginaClass>();
			ass           = new AssClass();
			ass.host      = this;
			breastRows    = [];
			_perks        = new PerkManager(this);
			_statusEffects = new StatusEffectManager(this);
			this.strStat.train.value = 15;
			this.touStat.train.value = 15;
			this.speStat.train.value = 15;
			this.intStat.train.value = 15;
			this.wisStat.train.value = 15;
			this.libStat.train.value = 15;
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
				"lust", "fatigue", "soulforce", "mana", "wrath", "demonicenergy",
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
		public function gainOrLosePerk(ptype:PerkType, condition:Boolean, gainText:String = "", loseText:String = "", addLossCondition:Boolean = true, gainFunct:Function = null, loseFunct:Function = null, doOutput:Boolean = true, value1:Number = 0, value2:Number = 0, value3:Number = 0, value4:Number = 0):Boolean {
			if (!hasPerk(ptype) && condition) {
				createPerk(ptype, value1, value2, value3, value4);
				if (doOutput) EngineCore.outputText("\n" + gainText + "\n\n(<b>Gained Perk: "+ptype.name()+"</b> - " + ptype.desc() + ")\n");
				if (gainFunct != null) gainFunct();
				return true;
			}
			if (hasPerk(ptype) && !condition && addLossCondition) {
				removePerk(ptype);
				if (doOutput) EngineCore.outputText("\n" + loseText + "\n\n(<b>Lost Perk: "+ptype.name()+"</b>)\n");
				if (loseFunct != null) loseFunct();
				return true;
			}
			return false;
		}

		public function gainPerk(ptype:PerkType, condition:Boolean, gainText:String = "", gainFunct:Function = null, doOutput:Boolean = true, value1:Number = 0, value2:Number = 0, value3:Number = 0, value4:Number = 0):Boolean {
			if (!hasPerk(ptype) && condition) {
				createPerk(ptype, value1, value2, value3, value4);
				if (doOutput) EngineCore.outputText("\n" + gainText + "\n\n(<b>Gained Perk: "+ptype.name()+"</b> - " + ptype.desc() + ")\n");
				if (gainFunct != null) gainFunct();
				return true;
			}
			return false;
		}

		public function losePerk(ptype:PerkType, losecondition:Boolean,loseText:String = "", loseFunct:Function = null, doOutput:Boolean = true):Boolean {
			if (hasPerk(ptype) && losecondition) {
				removePerk(ptype);
				if (doOutput) EngineCore.outputText("\n" + loseText + "\n\n(<b>Lost Perk: "+ptype.name()+"</b>)\n");
				if (loseFunct != null) loseFunct();
				return true;
			}
			return false;
		}

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
		 * Check if this creature has a perk.
		 * @param ptype {PerkType}
		 * @return {Boolean} True if creature has the perk, otherwise false.
		 */
		public function hasPerk(ptype:PerkType):Boolean {
			return this._perks.has(ptype);
		}

		/**
		 * Check if this creature has any of the specified perks.
		 * @param ptypes {Array<PerkType>}
		 * @return {Boolean} True if creature has any of the perks, otherwise false.
		 */
		public function hasAnyPerk(...ptypes:/*PerkType*/Array):Boolean {
			return ptypes.some(function(ptype:PerkType, index:int, array:Array):Boolean { return hasPerk(ptype); });
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

		public function getPerkValue(ptype:PerkType, valueIdx:Number = 1):Number
		{
			return this._perks.getPerkValue(ptype, valueIdx);
		}

		public function perkv1(ptype:PerkType):Number
		{
			return getPerkValue(ptype, 1);
		}

		public function perkv2(ptype:PerkType):Number
		{
			return getPerkValue(ptype, 2);
		}

		public function perkv3(ptype:PerkType):Number
		{
			return getPerkValue(ptype, 3);
		}

		public function perkv4(ptype:PerkType):Number
		{
			return getPerkValue(ptype, 4);
		}

		public function hasMutation(mutate:IMutationPerkType):Boolean{
			return perkv1(mutate) > 0;
		}

		public function hasMutationCount(invert:Boolean = false):int{
			var total:int = 0;
				for each (var iMutate:IMutationPerkType in IMutationsLib.mutationsArray("")){
					if (hasMutation(iMutate)) total++;
				}
			if (invert) total = IMutationsLib.mutationsArray("").length - total;
			return total;
		}


		/*

		[    S T A T U S   E F F E C T S    ]

		*/
		//{region StatusEffects

		//Current status effects. This has got very muddy between perks and status effects. Will have to look into it.
		//Someone call the grammar police!
		private var _statusEffects:StatusEffectManager;

		//Current status effects. This has got very muddy between perks and status effects. Will have to look into it.
		//Someone call the grammar police!
		/**
		 * List of all status effects.
		 */
		public function get statusEffects():Array {
			return this._statusEffects.asArray();
		}
		public function createOrFindStatusEffect(stype:StatusEffectType,value1:Number=0,value2:Number=0,value3:Number=0,value4:Number=0):StatusEffectClass
		{
			return this._statusEffects.createOrFindStatusEffect(stype,value1,value2,value3,value4);
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
		/**
		 * Check if this creature has any of the specified status effects.
		 * @param stypes {Array - StatusEffectType}
		 * @return {Boolean} True if creature has any of the status effects, otherwise false.
		 */
		public function hasAnyStatusEffect(...stypes:Array):Boolean {
			return stypes.some(function(stype:StatusEffectType, index:int, array:Array):Boolean { return hasStatusEffect(stype); });
		}
		public function changeStatusValue(stype:StatusEffectType, statusValueNum:Number = 1, newNum:Number = 0):void
		{
			return this._statusEffects.changeStatusValue(stype, statusValueNum, newNum);
		}
		public function addStatusValue(stype:StatusEffectType, statusValueNum:Number = 1, bonus:Number = 0):void
		{
			return this._statusEffects.addStatusValue(stype, statusValueNum, bonus);
		}
		public function createOrAddStatusEffect(stype:StatusEffectType, statusValueNum:Number = 1, bonus:Number = 0):void
		{
			return this._statusEffects.createOrAddStatusEffect(stype, statusValueNum, bonus);
		}

		public function getStatusValue(stype:StatusEffectType, statusValueNum:int):Number
		{
			if (this._statusEffects.hasStatusEffect(stype)) {
				return this._statusEffects.getStatusValue(stype, statusValueNum);
			}
			return 0;
		}

		public function statusEffectv1(stype:StatusEffectType):Number
		{
            return getStatusValue(stype, 1);
		}

		public function statusEffectv2(stype:StatusEffectType):Number
		{
            return getStatusValue(stype, 2);
		}

		public function statusEffectv3(stype:StatusEffectType):Number
		{
            return getStatusValue(stype, 3);
		}

		public function statusEffectv4(stype:StatusEffectType):Number
		{
            return getStatusValue(stype, 4);
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
		public function addCombatBuff(stat:String, buff:Number, text:String = "Combat Buff", tag:String = "CombatBuff"):Number {
			if (stat == "inte") stat = "int";
            this.buff(tag).withText(text).addStat(stat,buff).combatPermanent();
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
			//This formula below will allow for cylindrical cock calculation. i.e. it's closest resemblence to horse cocks, but other cocks are more cylindrical than rectangular.
			//However, this also means all places that check for this will need to be adjusted, and thus, will not actually ever be used.
			//Go forth, and keep fucking with your rectangular dicks! -Jtecx
			//var cArea:Number = 2 * Math.PI * (cocks[i_cockIndex].cockThickness/2) * ((cocks[i_cockIndex].cockThickness/2) + cocks[i_cockIndex].cockLength);
			//return cArea;
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
			return cockArea(findCock(1, -1, -1, "area"));
		}

		//Find the second biggest dick and it's area.
		public function biggestCockArea2():Number
		{
			if (cocks.length <= 1)
				return 0;
			return cockArea(findCock(2, -1, -1, "area"));
		}

		public function longestCock():Number
		{
			if (cocks.length == 0)
				return 0;
			return findCock(1, -1, -1, "length");
		}

		public function longestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			return cocks[longestCock()].cockLength;
		}

		public function longestHorseCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			var index:Number = findCockWithType(CockTypesEnum.HORSE, 1, -1, -1, "length");
            if (index < 0)
                index = 0;
			return cocks[index].cockLength;
		}

		public function isDogCock(x:int = 0): Boolean {
			return x < cockTotal() && InCollection(cocks[x].cockType, CockTypesEnum.DOG, CockTypesEnum.FOX, CockTypesEnum.WOLF, CockTypesEnum.DISPLACER);
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

		public function thickestCockIndex():Number
		{
			return findCock(1, -1, -1, "thickness");
		}

		public function thickestCockThickness():Number
		{
			return cocks[thickestCockIndex()].cockThickness;
		}

		public function thinnestCockIndex():Number
		{
			return findCock(-1, -1, -1, "thickness");
		}

		public function smallestCockIndex():Number
		{
			return findCock(-1, -1, -1, "area");
		}

		public function smallestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			return cocks[smallestCockIndex()].cockLength;
		}

		public function shortestCockIndex():Number
		{
			return findCock(-1, -1, -1, "length");
		}

		public function shortestCockLength():Number
		{
			if (cocks.length == 0)
				return 0;
			return cocks[shortestCockIndex()].cockLength;
		}

        public function cockThatFits(i_fits:Number, type:String = "area"):Number {
            return findCock(1, -1, i_fits, type);
        }

		//Find the 2nd biggest cock that fits inside a given value
		public function cockThatFits2(fits:Number = 0):Number
		{
			return findCock(2, -1, fits, "area");
		}

		public function smallestCockArea():Number
		{
			if (cockTotal() == 0)
				return -1;
			return cockArea(smallestCockIndex());
		}

		public function biggestCockIndex():Number
		{
			return findCock(1, -1, -1, "area");
		}

		//Find the second biggest dick's index.
		public function biggestCockIndex2():Number
		{
			return findCock(2, -1, -1, "area");
		}

		public function smallestCockIndex2():Number
		{
			return findCock(-2, -1, -1, "area");
		}

		//Find the third biggest dick index.
		public function biggestCockIndex3():Number
		{
			return findCock(3, -1, -1, "area");
		}

        //Checks if the cock is tentacle/stamen
        public function cockIsTentacle(num:int):Boolean {
            return cocks[num].cockType == CockTypesEnum.STAMEN || cocks[num].cockType == CockTypesEnum.TENTACLE || cocks[num].cockType == CockTypesEnum.SCYLLATENTACLE;
        }

        /**
        * Returns the count of the cocks which meet the requirements
        * Assumes that TENTACLE type is the same as STAMEN (because it's the same, isn't it?)
        * @param    type        Cock type, UNDEFINED = "any"
        * @param    minSize     Minimum size, 0/-1 = no checking
        * @param    maxSize     Maximum size, -1 = no checking
        * @param    compareBy   The measurement to compare by, "area", "length" or "thickness"
        * @return   The count of matching dicks
        */
        public function countCocksWithType(type:CockTypesEnum, minSize:Number = -1, maxSize:Number = -1, compareBy:String = "area"):int {
            if (compareBy != "area" && compareBy != "length" && compareBy != "thickness") //sanity check
                throw new Error("Wrong compareBy value!");
            var cnt:int = 0;
            var tent:Boolean = (type == CockTypesEnum.STAMEN || type == CockTypesEnum.TENTACLE || type == CockTypesEnum.SCYLLATENTACLE);
            for (var i:int = 0; i < cocks.length; ++i) {
                var isize:Number = compareBy == "length" ? cocks[i].cockLength :
                                compareBy == "thickness" ? cocks[i].cockThickness :
                                cockArea(i);
                if ((isize >= minSize || minSize < 0) && (isize < maxSize || maxSize < 0)
                && (cocks[i].cockType == type || tent && cockIsTentacle(i) || type == CockTypesEnum.UNDEFINED))
                    ++cnt;
            }
            return cnt;
        }
		
		public function countCocks(minSize:Number = -1, maxSize:Number = -1, compareBy:String = "area"):int {
			return countCocksWithType(CockTypesEnum.UNDEFINED, minSize, maxSize, compareBy);
		}

        /**
        * Returns number of the biggest cock that meets the requirements
        * Assumes that TENTACLE type is the same as STAMEN (because it's the same, isn't it?)
        * @param    biggest     "0/1" = biggest, "-1" = smallest, "2" = second biggest, "-2" = second smallest, ...
        * @param    type        Cock type, UNDEFINED = "any"
        * @param    minSize     Minimum size, 0/-1 = no checking
        * @param    maxSize     Maximum size, -1 = no checking
        * @param    compareBy   The measurement to compare by, "area", "length" or "thickness"
        * @param    knot        Knot checks. 0 = no checks, -1 = no knot, 1 = must have knot
        * @return   The number of the biggest (comparing by 'compareBy') matching dick, -1 if no any
        */
        public function findCockWithType(type:CockTypesEnum, biggest:int = 1, minSize:Number = -1, maxSize:Number = -1, compareBy:String = "area", knot:int = 0):int {
            if (compareBy != "area" && compareBy != "length" && compareBy != "thickness") //sanity check
                throw new Error("Wrong compareBy value!");
            var sorted:Array = [];
            var tent:Boolean = (type == CockTypesEnum.STAMEN || type == CockTypesEnum.TENTACLE);
            //create an array of fitting cocks, sorted descending
            for (var num:int = 0; num < cocks.length; ++num) {
                var nsize:Number = compareBy == "length" ? cocks[num].cockLength :
                                compareBy == "thickness" ? cocks[num].cockThickness :
                                cockArea(num);
                if ((nsize >= minSize || minSize < 0) && (nsize < maxSize || maxSize < 0)
                        && (type == CockTypesEnum.UNDEFINED || cocks[num].cockType == type || tent && cockIsTentacle(num))
                        && (knot == 0 || knot == 1 && cocks[num].hasKnot() || knot == -1 && !cocks[num].hasKnot())) {
                    var j:int;
                    for (j = 0; j < sorted.length; ++j) {
                        var jsize:Number = compareBy == "length" ? cocks[sorted[j]].cockLength :
                                compareBy == "thickness" ? cocks[sorted[j]].cockThickness :
                                cockArea(sorted[j]);
                        if (jsize < nsize) {
                            sorted.splice(j, 0, num);
                            break;
                        }
                    }
                    //smallest
                    if (j == sorted.length)
                        sorted.push(num);
                }
            }
            if (sorted.length == 0 || Math.abs(biggest) > sorted.length)
                return -1;
            if (biggest > 0)
                return sorted[biggest - 1];
            if (biggest < 0)
                return sorted[sorted.length + biggest];
			return sorted[0];
        }
		
		public function findCock(biggest:int = 1, minSize:Number = -1, maxSize:Number = -1, compareBy:String = "area"):int {
			return findCockWithType(CockTypesEnum.UNDEFINED, biggest, minSize, maxSize, compareBy);
		}

        public function findCockWithTypeNotIn(arr:Array, type:CockTypesEnum, biggest:int = 1, minSize:Number = -1, maxSize:Number = -1, compareBy:String = "area"):int {
            var ret:int = -1;
            var sign:int = (biggest >= 0) ? 1 : -1;
            var cnt:int = sign;
            var biggest_cnt:int = sign;
            //correct 'biggest' value to account for zeros
            if (biggest == 0) biggest = 1;
            do {
                ret = findCockWithType(type, cnt, minSize, maxSize, compareBy); //find n-th cock
                if (ret >= 0 && arr.indexOf(ret) == -1) { //count those outside of the array
                    if (biggest_cnt == biggest) //if found b-th cock, return it
                        return ret;
                    else
                        biggest_cnt += sign;
                }
                cnt += sign;
            } while (ret >= 0);
            return -1;
        }

		public function findCockNotIn(arr:Array, biggest:int = 1, minSize:Number = -1, maxSize:Number = -1, compareBy:String = "area"):int {
			return findCockWithTypeNotIn(arr, CockTypesEnum.UNDEFINED, biggest, minSize, maxSize, compareBy);
		}

		public function cockDescript(cockIndex:int = 0):String {
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

		public function wetness(vagNum:int = 0):Number {
			if (vaginas.length == 0)
				return 0;
			else
				return vaginas[vagNum].vaginalWetness;
		}

		public function vaginaType(newType:int = -1, vagNum:int = 0):int {
			if (!hasVagina())
				return -1;
			if (newType != -1) // this handles the sandtrap pussy... for some reason.
			{
				vaginas[vagNum].type = newType;
			}
			return vaginas[vagNum].type;
		}

		public function looseness(isVag:Boolean = true, vagNum:int = 0):Number {
			if (isVag)
			{
				if (vaginas.length == 0)
					return 0;
				else
					return vaginas[vagNum].vaginalLooseness;
			}
			else
			{
				return ass.analLooseness;
			}
		}

		public function vaginalCapacity(vagNum:int = 0):int {
			//If the player has no vaginas
			if (vaginas.length == 0)
				return 0;
			var total:Number;
			var bonus:Number = 0;
			//Centaurs = +50 capacity
			if (isTaur())
				bonus = 50;
			//Naga = +20 capacity
			if (isNaga())
				bonus = 20;
			// Goo body - "infinite"
			if (isGoo())
				bonus += 9000;
			//Kitsune Vag of Holding - "infinite"
			if (tail.type == Tail.FOX && tailCount == 9)
				bonus += 9000;
			//Wet pussy provides 50 point boost
			if (hasPerk(PerkLib.WetPussy))
				bonus += 50;
			if (hasPerk(PerkLib.HistorySlut) || hasPerk(PerkLib.PastLifeSlut)) {
				bonus += 20;
				if (hasPerk(PerkLib.DoorKnob)) bonus += 5;
				if (hasPerk(PerkLib.Bicycle)) bonus += 5;
				if (hasPerk(PerkLib.MeatHole)) bonus += 5;
				if (hasPerk(PerkLib.BedWarmer)) bonus += 5;
				if (hasPerk(PerkLib.TensionTamer)) bonus += 5;
				if (hasPerk(PerkLib.PartyBoyGirl)) bonus += 5;
				if (hasPerk(PerkLib.MattressActressActor)) bonus += 5;
			}
			if (hasPerk(PerkLib.OneTrackMind))
				bonus += 10;
			if (hasPerk(PerkLib.Cornucopia))
				bonus += 30;
			if(hasPerk(PerkLib.FerasBoonWideOpen))
				bonus += 25;
			if(hasPerk(PerkLib.FerasBoonMilkingTwat))
				bonus += 40;
			return Math.floor((bonus + statusEffectv1(StatusEffects.BonusVCapacity) + 8 * vaginas[vagNum].vaginalLooseness * vaginas[vagNum].vaginalLooseness) * (1 + vaginas[vagNum].vaginalWetness / 10));
		}

		public function analCapacity():int {
			var bonus:Number = 0;
			//Centaurs = +30 capacity
			if (isTaur())
				bonus = 30;
			// Goo body - "infinite"
			if (isGoo())
				bonus += 9000;
			if (hasPerk(PerkLib.HistorySlut) || hasPerk(PerkLib.PastLifeSlut)) {
				bonus += 20;
				if (hasPerk(PerkLib.DoorKnob)) bonus += 5;
				if (hasPerk(PerkLib.Bicycle)) bonus += 5;
				if (hasPerk(PerkLib.MeatHole)) bonus += 5;
				if (hasPerk(PerkLib.BedWarmer)) bonus += 5;
				if (hasPerk(PerkLib.TensionTamer)) bonus += 5;
				if (hasPerk(PerkLib.PartyBoyGirl)) bonus += 5;
				if (hasPerk(PerkLib.MattressActressActor)) bonus += 5;
			}
			if (hasPerk(PerkLib.Cornucopia))
				bonus += 30;
			if (hasPerk(PerkLib.OneTrackMind))
				bonus += 10;
			if (ass.analWetness > 0)
				bonus += 15;
			return Math.floor((bonus + statusEffectv1(StatusEffects.BonusACapacity) + 6 * ass.analLooseness * ass.analLooseness) * (1 + ass.analWetness / 10));
		}

		public function hasFuckableNipples():Boolean {
			var counter:Number = breastRows.length;
			while (counter > 0)
			{
				counter--;
				if (breastRows[counter].fuckable)
					return true;
			}
			return false;
		}

		public function hasBreasts():Boolean {
			if (breastRows.length > 0)
			{
				if (biggestTitSize() >= 1)
					return true;
			}
			return false;
		}

		public function hasNipples():Boolean {
			var counter:Number = breastRows.length;
			while (counter > 0)
			{
				counter--;
				if (breastRows[counter].nipplesPerBreast > 0)
					return true;
			}
			return false;
		}

		public function lactationSpeed():Number {
			//Lactation * breastSize x 10 (milkPerBreast) determines scene
			return biggestLactation() * biggestTitSize() * 10;
		}

		public function biggestLactation():Number {
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
			if (hasPerk(PerkLib.Feeder))
			{
				//You've now been milked, reset the timer for that
				addStatusValue(StatusEffects.Feeder,1,1);
				changeStatusValue(StatusEffects.Feeder, 2, 0);
			}
		}
		public function boostLactation(remaining:Number, directIncrease:Boolean = false):Number
		{
			if (breastRows.length == 0)
				return 0;
			var counter:Number = breastRows.length;
			var index:Number = 0;
			var changes:Number = 0;
			var temp2:Number = 0;
			//Prevent lactation decrease if lactating.
			if (remaining >= 0 && hasStatusEffect(StatusEffects.LactationReduction))
					changeStatusValue(StatusEffects.LactationReduction, 1, 0);
			if (remaining > 0)
			{
				while (remaining > 0)
				{
					counter = breastRows.length;
                    //select breast row with the lowest lactation
					while (counter > 0)
					{
						counter--;
						if (breastRows[index].lactationMultiplier > breastRows[counter].lactationMultiplier)
							index = counter;
					}
					temp2 = remaining > .1 ? .1 : remaining;
					remaining -= temp2;
                    //diminishing increase - NOT INCLUDING LACTAID, IT WORKS WELL
                    if (!directIncrease) {
                        if (breastRows[index].lactationMultiplier > 1.5)
                            temp2 /= 2;
                        if (breastRows[index].lactationMultiplier > 2.5)
                            temp2 /= 2;
                        if (breastRows[index].lactationMultiplier > 3)
                            temp2 /= 2;
                    }
					changes += temp2;
					breastRows[index].lactationMultiplier += temp2;
				}
			}
			else
			{
				while (remaining < 0)
				{
					counter = breastRows.length;
					index = 0;
                    //select breast row with the lowest lactation
                    while (counter > 0)
                    {
                        counter--;
                        if (breastRows[index].lactationMultiplier < breastRows[counter].lactationMultiplier)
                            index = counter;
                    }
                    temp2 = remaining < -.1 ? -.1 : remaining;
                    remaining -= temp2;
                    //normal decrease
                    changes += temp2;
                    breastRows[index].lactationMultiplier += temp2;
                    if (breastRows[index].lactationMultiplier < 0)
                        breastRows[index].lactationMultiplier = 0;
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
			if (perkv1(IMutationsLib.FiendishBallsIM) >= 1)
				percent += (((perkv1(IMutationsLib.FiendishBallsIM)*2)+2)*0.1);
			if (perkv1(IMutationsLib.HumanTesticlesIM) >= 1 && game.player.racialScore(Races.HUMAN) > 17)
				percent += (0.05 * perkv1(IMutationsLib.HumanTesticlesIM));
			//Messy Orgasms?
			if (hasPerk(PerkLib.MessyOrgasms))
				percent += 0.06;
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
			var lustCoefficient:Number = lust / 10;
			//If realistic mode is enabled, limits cum to capacity.
			if (flags[kFLAGS.HUNGER_ENABLED] >= 1)
			{
				lustCoefficient = lust / 5;
				var percent:Number = 0;
				percent = lustCoefficient + (hoursSinceCum + 10);
				if (percent > 100)
					percent = 100;
				if (quantity > cumCapacity())
					quantity = cumCapacity();
				return (percent / 100) * cumCapacity();
			}
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
			if (perkv1(IMutationsLib.HumanTesticlesIM) >= 3 && game.player.racialScore(Races.HUMAN) > 17)
				quantity *= 2;
			if (perkv1(IMutationsLib.MinotaurTesticlesIM) >= 3) {
				if (perkv1(IMutationsLib.MinotaurTesticlesIM) >= 4) quantity *= 3;
				else quantity *= 2.5;
			}
			if (perkv1(IMutationsLib.FiendishBallsIM) >= 2)
				quantity *= (1 + (0.25 * perkv1(IMutationsLib.FiendishBallsIM)));
			if (hasPerk(PerkLib.MaraesGiftStud))
				quantity += 350;
			if (hasPerk(PerkLib.FerasBoonAlpha))
				quantity += 200;
			if (hasPerk(PerkLib.MagicalVirility))
				quantity += 200 + (perkv1(PerkLib.MagicalVirility) * 100);
			if (hasPerk(PerkLib.FerasBoonSeeder))
				quantity += 1000;
			if (perkv1(IMutationsLib.MinotaurTesticlesIM) >= 2)
				quantity += 200;
			if (perkv1(IMutationsLib.NukiNutsIM) >= 2)
				quantity += 200;
			if (perkv1(IMutationsLib.NukiNutsIM) >= 3)
				quantity *= 2;
			if (perkv1(IMutationsLib.EasterBunnyEggBagIM) >= 2)
				quantity *= 1.5;
			if (perkv1(IMutationsLib.EasterBunnyEggBagIM) >= 3)
				quantity *= 3;
			if (hasPerk(PerkLib.ProductivityDrugs))
				quantity += (perkv3(PerkLib.ProductivityDrugs));
			if (hasMutation(IMutationsLib.HellhoundFireBallsIM))
				switch (perkv1(IMutationsLib.HellhoundFireBallsIM)) {
					case 1:
					case 2:
					case 3: quantity *= 1.25; break;
					case 4: quantity *= 2; break;
				}
			//if(hasPerk("Elven Bounty") >= 0) quantity += 250;;
			quantity += perkv1(PerkLib.ElvenBounty);
			if (hasPerk(PerkLib.BroBody))
				quantity += 200;
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
			//limit to prevent reaching infinity
			if(quantity >= Utils.MAX_SAFE_NUMBER_VALUE) quantity = Utils.MAX_SAFE_NUMBER_VALUE;
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
			return cumCap;
		}
		public function countCocksOfType(type:CockTypesEnum):int {
            return countCocksWithType(type, -1, -1);
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

		public function eldritchCocks():int { //How many eldritchCocks?
			return countCocksOfType(CockTypesEnum.MINDBREAKER);
		}

		// Note: DogCocks/FoxCocks are functionally identical. They actually change back and forth depending on some
		// of the PC's attributes, and this is recaluculated every hour spent at camp.
		// As such, delineating between the two is kind of silly.
		public function dogCocks():int { //How many dogCocks
			if (cocks.length == 0) return 0;
			var counter:int = 0;
			for (var x:int = 0; x < cocks.length; x++) {
				if (InCollection(cocks[x].cockType, CockTypesEnum.DOG, CockTypesEnum.FOX, CockTypesEnum.WOLF, CockTypesEnum.DISPLACER)) counter++;
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

		public function kirinCocks():int { //How many horsecocks?
			return countCocksOfType(CockTypesEnum.KIRIN);
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

		public function raijuCocks():int { //How many raiju-cocks?
			return countCocksOfType(CockTypesEnum.RAIJU);
		}

		public function pigCocks():int { //How many pig-cocks?
			return countCocksOfType(CockTypesEnum.PIG);
		}

		public function normalCocks():int { //How many normalCocks?
			return countCocksOfType(CockTypesEnum.HUMAN);
		}

		public function tentacleCocks():int { //How many tentaclecocks?
			return countCocksOfType(CockTypesEnum.TENTACLE) + countCocksOfType(CockTypesEnum.STAMEN) + countCocksOfType(CockTypesEnum.SCYLLATENTACLE);
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

		public function beeCocks():int { //How many beecocks?
			return countCocksOfType(CockTypesEnum.BEE);
		}

		public function insectCocks():int { //How many insectcocks?
			return countCocksOfType(CockTypesEnum.INSECT);
		}


		public function findFirstCockType(ctype:CockTypesEnum):Number
		{
			for (var index:Number = 0; index < cocks.length; index++) {
				if (cocks[index].cockType == ctype)
					return index;
			}
			//trace("Creature.findFirstCockType ERROR - searched for cocktype: " + ctype + " and could not find it.");
			return -1;
		}

		public function findFirstCockNotInType(types:Array):Number {
			for (var cock:int = 0; cock<cockTotal() && types.indexOf(cocks[cock].cockType) >= 0; cock++) {}
			return cock < cockTotal() ? cock : -1;
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
				if (cocks[counter].cockType != CockTypesEnum.HORSE)
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
		public function vagTotal():Number
		{
			return (vaginas.length);
		}

		//Boolean alternate
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

		public function hasBalls():Boolean {
			return balls > 0;
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
			if (buff("Web").isPresent())
				return false;
			return Arms.Types[arms.type].canFly || Wings.Types[wings.type].canFly;
		}
		public function hasPhysicalWings():Boolean
		{
			return (Wings.Types[wings.type].physical) ;
		}
		public function hasTail():Boolean
		{
			return (tailType > Tail.NONE) ;
		}

		public function canPounce():Boolean
		{
			return (LowerBody.Types[lowerBody].canPounce && Arms.Types[arms.type].canPounce);
		}
		public function hasClaws():Boolean
		{
			return Arms.Types[arms.type].claw;
		}


		//PC can swim underwater?
		public function canSwimUnderwater():Boolean
		{
			if (gills.type != Gills.NONE || lowerBody == LowerBody.SCYLLA || lowerBody == LowerBody.KRAKEN || lowerBody == LowerBody.MELKIE || tailType == Tail.ARIGEAN_GREEN || tailType == Tail.ARIGEAN_RED || tailType == Tail.ARIGEAN_YELLOW || tailType == Tail.ARIGEAN_PRINCESS ||
				rearBody.type == RearBody.ORCA_BLOWHOLE || hasStatusEffect(StatusEffects.Airweed) || game.player.necklaceName == "Magic coral and pearl necklace" || game.player.headjewelryName == "Aqua breather" ||
				(game.player.isInGoblinMech() && game.player.hasKeyItem("Safety bubble") >= 0) || game.player.hasPerk(PerkLib.AffinityUndine) || game.player.hasPerk(PerkLib.Undeath))
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
			if (perkv1(IMutationsLib.ScyllaInkGlandsIM) >= 3) {
				bonusStr *= (perkv1(IMutationsLib.ScyllaInkGlandsIM) - 1);
				bonusSpe *= (perkv1(IMutationsLib.ScyllaInkGlandsIM) - 1);
			}
			if (game.player.hasPerk(PerkLib.AffinityUndine)) bonusSpe += 50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			if (game.player.armorName == "Sexy Aquamarine Bikini" || game.player.armorName == "Sexy Black Bikini" || game.player.armorName == "Sexy Blue Bikini" || game.player.armorName == "Sexy Green Bikini" || game.player.armorName == "Sexy Pink Bikini" || game.player.armorName == "Sexy Red Bikini" || game.player.armorName == "Sexy White Bikini" || game.player.armorName == "Sexy Yellow Bikini") {
				bonusStr += 20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				bonusSpe += 20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			}
			if (game.player.necklaceName == "Magic coral and pearl necklace") bonusSpe += 10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			if (perkv1(IMutationsLib.ScyllaInkGlandsIM) >= 4) {
				bonusStr *= 2;
				bonusSpe *= 2;
			}
			game.player.buff("UnderwaterCombatBoost").addStats({str:bonusStr,spe:bonusSpe}).withText("Fighting Underwater").combatPermanent();
			HP = oldHPratio * maxHP();
			if (game.player.hasPerk(PerkLib.AffinityIgnis)) createStatusEffect(StatusEffects.UnderwaterAndIgnis, 0, 0, 0, 0);
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
			if (game.monster.hasPerk(PerkLib.EnemyConstructType) || game.monster.hasPerk(PerkLib.EnemyFleshConstructType) || game.monster.hasPerk(PerkLib.EnemyGooType) || game.monster.hasPerk(PerkLib.EnemyPlantType) || game.monster.hasPerk(PerkLib.EnemyElementalType) || game.monster.hasPerk(PerkLib.EnemyGhostType) || game.monster.hasPerk(PerkLib.EnemyUndeadType))
				return true;
			return false;
		}

		//Bleed immunity
		public function isImmuneToBleed():Boolean
		{
			if (game.monster.hasPerk(PerkLib.EnemyConstructType) || game.monster.hasPerk(PerkLib.EnemyElementalType) || game.monster.hasPerk(PerkLib.EnemyGhostType) || game.monster.hasPerk(PerkLib.EnemyUndeadType) || game.monster.hasPerk(PerkLib.EnemyGooType))
				return true;
			return false;
		}

		//Blind Immunity
		public function isImmuneToBlind(): Boolean
		{
			return hasPerk(PerkLib.BlindImmunity) || hasPerk(PerkLib.TrueSeeing);
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
		public function looksFemale():Boolean {
			var titSize:Number = biggestTitSize();
			if (hasCock() && hasVagina()) // herm
				return (titSize >= 3 ||
						titSize == 2 && femininity >= 15 ||
						titSize == 1 && femininity >= 40 ||
						femininity >= 65);
			if (hasCock()) // male
				return (
						titSize >= 3 && femininity >= 5 ||
						titSize == 2 && femininity >= 35 ||
						titSize == 1 && femininity >= 65 ||
						femininity >= 95);
			if (hasVagina()) // pure female
				return (titSize > 0 ||
						femininity >= 40);
			// genderless
			return (titSize >= 3 ||
					titSize == 2 && femininity >= 15 ||
					titSize == 1 && femininity >= 40 ||
					femininity >= 65);
		}
		public function looksMale():Boolean {
			return !looksFemale();
		}
		public function mf(male:String, female:String):String
		{
			return looksFemale() ? female : male;
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
				CoC_Settings.error("removeCock called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if (cocks.length == 0)
			{
				CoC_Settings.error("removeCock called but cocks do not exist.");
			}
			else
			{
				if (arraySpot > cocks.length - 1)
				{
					CoC_Settings.error("removeCock failed - array location is beyond the bounds of the array.");
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
				CoC_Settings.error("removeVagina called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if (vaginas.length == 0)
			{
				CoC_Settings.error("removeVagina called but cocks do not exist.");
			}
			else
			{
				if (arraySpot > vaginas.length - 1)
				{
					CoC_Settings.error("removeVagina failed - array location is beyond the bounds of the array.");
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
				CoC_Settings.error("removeBreastRow called but arraySpot is negative or totalRemoved is 0.");
				return;
			}
			if (breastRows.length == 0)
			{
				CoC_Settings.error("removeBreastRow called but cocks do not exist.");
			}
			else if (breastRows.length == 1 || breastRows.length - totalRemoved < 1)
			{
				CoC_Settings.error("Removing the current breast row would break the Creature classes assumptions about breastRow contents.");
			}
			else
			{
				if (arraySpot > breastRows.length - 1)
				{
					CoC_Settings.error("removeBreastRow failed - array location is beyond the bounds of the array.");
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
			if (perkv1(IMutationsLib.GoblinOvariesIM) >= 1)
				counter += (10 * perkv1(IMutationsLib.GoblinOvariesIM));
			if (perkv1(IMutationsLib.FiendishOvariesIM) >= 1)
				counter += (((perkv1(IMutationsLib.FiendishOvariesIM)*2)+2)*10);
			if (perkv1(IMutationsLib.HumanOvariesIM) >= 1 && game.player.racialScore(Races.HUMAN) > 17)
				counter += (15 * perkv1(IMutationsLib.HumanOvariesIM));
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

		public function isScaleCovered():Boolean { return skin.isScaleCovered(); }
		public function isReptileScaleCovered():Boolean { return skin.isReptileScaleCovered(); }
		public function isDagonScaleCovered():Boolean { return skin.isDragonScaleCovered(); }
		public function isLizardScaleCovered():Boolean { return skin.isLizardScaleCovered(); }
		public function isNonLizardScaleCovered():Boolean { return skin.isNonLizardScaleCovered(); }
		public function isFurCovered():Boolean { return skin.isFurCovered(); }
		public function isChitinCovered():Boolean { return skin.isChitinCovered(); }
		public function isFeatherCovered():Boolean { return skin.isFeatherCovered(); }
		public function hasMostlyPlainSkin():Boolean { return skin.hasMostlyPlainSkin(); }
		public function hasPlainSkinOnly():Boolean { return skin.hasPlainSkinOnly(); }
		public function hasPartialCoatOfType(...coat_types:Array):Boolean {
			return skin.hasPartialCoatOfType(coat_types);
		}
		public function hasPartialCoat(coat_type:int):Boolean { return skin.hasPartialCoatOfType(coat_type); }
		public function hasAnyPartialCoat():Boolean { return skin.hasPartialCoat(); }
		public function hasRubberSkin():Boolean { return skin.hasRubberSkin(); }
		public function hasPlainSkin():Boolean { return skin.hasPlainSkin(); }
		public function isGooSkin():Boolean { return skin.isGooSkin(); }
		public function isGhostSkin():Boolean { return skin.isGhostSkin(); }
		public function isBarkSkin():Boolean { return skin.hasBark(); }
		public function isGargoyle():Boolean { return skin.hasBaseOnly(Skin.STONE); }
		public function skinDescript():String { return skin.describe('base'); }
		public function skinFurScales():String { return skin.describe('coat'); }

		// <mod name="Predator arms" author="Stadler76">
		public function claws():String { return clawsPart.descriptionFull(); }
		public function finger():String { return clawsPart.descriptionFinger(); }
		public function hands():String { return arms.hasPawsOrHands(); }
		// </mod>

		public function hasFourArms():Boolean { return arms.hasFourArms(); }
		public function legs():String { return lowerBodyPart.legs(); }
		public function leg():String { return lowerBodyPart.leg(); }
		public function feet():String { return lowerBodyPart.feet(); }
		public function foot():String { return lowerBodyPart.foot(); }
		public function isDrider():Boolean { return lowerBodyPart.isDrider(); }
		public function isGoo():Boolean { return lowerBodyPart.isGoo(); }
		public function isBiped():Boolean { return lowerBodyPart.isBiped(); }
		public function isNaga():Boolean { return lowerBodyPart.isNaga(); }
		public function isTaur():Boolean { return lowerBodyPart.isTaur(); }
		public function canTaur():Boolean { return lowerBodyPart.canTaur(); }
		public function isScylla():Boolean { return lowerBodyPart.isScylla(); }
		public function isSandWorm():Boolean { return lowerBodyPart.type == LowerBody.SANDWORM; }
		public function isKraken():Boolean { return lowerBodyPart.isKraken(); }
		public function isAlraune():Boolean { return lowerBodyPart.isAlraune(); }
		public function isLiliraune():Boolean { return lowerBodyPart.isLiliraune(); }
		public function isElf():Boolean {
			return perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 3 || game.player.isRace(Races.ELF) || game.player.isRace(Races.WOODELF);
		}
		public function isWoodElf():Boolean { return  game.player.isRace(Races.WOODELF); }
		public function isHellHound():Boolean { return ((faceType == Face.DOG && cor >= 60) && dogCocks() >= 2 && ((tail.type == Tail.DOG ? 1 : 0) ||
				(lowerBody == LowerBody.DOG) ||
				(hairColor == "midnight black") ||
				(furColor == "midnight black")
		))}

		public function isFlying():Boolean {
			return hasStatusEffect(StatusEffects.Flying);
		}

		public function isIncapacitated():Boolean {
			var rval:Boolean = false;
			rval =  hasStatusEffect(StatusEffects.Blind) || hasStatusEffect(StatusEffects.FrozenSolid) ||
					hasStatusEffect(StatusEffects.Stunned)|| hasStatusEffect(StatusEffects.Distracted);
			return rval;
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

		public function canOvipositAnt():Boolean
		{
			return eggs() >= 10 && hasPerk(PerkLib.AntOvipositor) && tail.type == Tail.ANT_ABDOMEN;
		}

		public function canOviposit():Boolean
		{
			return canOvipositSpider() || canOvipositBee() || canOvipositMantis() || canOvipositAnt();
		}

		public function eggs():int
		{
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor) && !hasPerk(PerkLib.MantisOvipositor) && !hasPerk(PerkLib.AntOvipositor))
				return -1;
			else if (hasPerk(PerkLib.SpiderOvipositor))
				return perkv1(PerkLib.SpiderOvipositor);
			else if (hasPerk(PerkLib.BeeOvipositor))
				return perkv1(PerkLib.BeeOvipositor);
			else if (hasPerk(PerkLib.MantisOvipositor))
				return perkv1(PerkLib.MantisOvipositor);
			else
				return perkv1(PerkLib.AntOvipositor);
			}

		public function addEggs(arg:int = 0):int
		{
			var oviPerk:PerkType = getOviPerk();
			if (oviPerk == null) return -1;
			addPerkValue(oviPerk, 1, arg);
			if (eggs() > maxEggs) setPerkValue(oviPerk, 1, maxEggs);

			if(eggs() >= 40) buff("EggFever").setStat("minlust", 0.2).withText("Egg Fever");
			else if(eggs() >= 20) buff("EggFever").setStat("minlust", 0.2).withText("Egg Fever");
			return eggs();
		}

		public function dumpEggs():void {
			if (!hasPerk(PerkLib.SpiderOvipositor) && !hasPerk(PerkLib.BeeOvipositor) && !hasPerk(PerkLib.MantisOvipositor) && !hasPerk(PerkLib.AntOvipositor))
				return;
			if (hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) {
				addPerkValue(PerkLib.BeeOvipositor, 1, -25);
				if (getPerkValue(PerkLib.BeeOvipositor, 1) > 0) EngineCore.outputText("\n\nWith no further space left to unload within your current incubator you sigh and stand up to be on your way. You will need more incubators in which to deliver your remaining eggs.");
				else EngineCore.outputText("\n\nYou will need to go see Tifa for a reload but you have a nice idea of where you could store the eggs from now on.");
				buff("Oviposition").addStats({"spe.mult": 0.1}).withText("Relief after the oviposition").forDays(1); //give that speed buff
			} else setEggs(0);
			fertilizeEggs(); //Sets fertile eggs = regular eggs
		}

		private function getOviPerk():PerkType {
			var oviPerks:Array = [PerkLib.SpiderOvipositor, PerkLib.BeeOvipositor, PerkLib.MantisOvipositor, PerkLib.AntOvipositor];
			for each (var perk:PerkType in oviPerks)
				if (hasPerk(perk)) return perk;
			return null;
		}

		public function get maxEggs():int {
			return hasPerk(PerkLib.TransformationImmunityBeeHandmaiden) ? 100 : 50;
		}

		public function setEggs(arg:int = 0):int {
			var oviPerk:PerkType = getOviPerk();
			if (oviPerk == null) return -1;
			setPerkValue(oviPerk, 1, arg);
			if (eggs() > maxEggs) setPerkValue(oviPerk, 1, maxEggs);
			if(eggs() >= 40) buff("EggFever").setStat("minlust", 0.2).withText("Egg Fever");
			else if(eggs() >= 20) buff("EggFever").setStat("minlust", 0.2).withText("Egg Fever");
			return perkv1(oviPerk);
		}

		public function fertilizedEggs():int {
			var oviPerk:PerkType = getOviPerk();
			if (oviPerk == null) return -1;
			return perkv2(oviPerk);
		}

		public function fertilizeEggs():int {
			var oviPerk:PerkType = getOviPerk();
			if (oviPerk == null) return -1;
			setPerkValue(oviPerk, 2, eggs());
			return perkv2(oviPerk);
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
		public function oMultiCockDesc():String {
			return (cocks.length > 1 ? "one of your " : "your ") + cockMultiLDescriptionShort();
		}

		public function OMultiCockDesc():String {
			return (cocks.length > 1 ? "One of your " : "Your ") + cockMultiLDescriptionShort();
		}

		public function sMultiCockDesc():String {
			return (cocks.length > 1 ? "each of your " : "your ") + cockMultiLDescriptionShort();
		}

		public function SMultiCockDesc():String {
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
				case CockTypesEnum.DOG:
				case CockTypesEnum.FOX:
				case CockTypesEnum.DRAGON:
				case CockTypesEnum.HORSE:
				case CockTypesEnum.KANGAROO:
				case CockTypesEnum.LIZARD:
				case CockTypesEnum.CAVE_WYRM:
				case CockTypesEnum.RED_PANDA:
				case CockTypesEnum.PIG:
				case CockTypesEnum.MINDBREAKER:
				case CockTypesEnum.TENTACLE:
				case CockTypesEnum.INSECT:
					if (countCocksOfType(cocks[0].cockType) == cocks.length) return Appearance.cockNoun(cocks[0].cockType) + "s";
					break;
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
					case CockTypesEnum.INSECT:
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
			return Appearance.vaginaDescript(this, idx);
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
				case CockTypesEnum.INSECT:
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

		public function ballsDescriptArticle(forcedSize:Boolean = true):String
		{
			return Appearance.ballsDescription(forcedSize, true, this, true);
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

		public function hairDescript():String
		{
			return Appearance.hairDescription(this);
		}

		public function beardDescript():String
		{
			return Appearance.beardDescription(this);
		}

		public function hairStyleDescript():String
		{
			return Appearance.hairStyleDescription(this);
		}

		public function hipDescript():String
		{
			return Appearance.hipDescription(this);
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
			mult -= resPhysicalStat.value;
			if (mult < 20) mult = 20;
			return mult;
		}
		public function damageRangePercent():Number {
			var mult:Number = 100;
			mult -= resPhysicalStat.value;
			if (mult < 20) mult = 20;
			return mult;
		}
		public function damageMagicalPercent():Number {
			var mult:Number = 100;
			mult -= resMagicStat.value;
			if (mult < 20) mult = 20;
			return mult;
		}
		public function damageFirePercent():Number {
			var mult:Number = 100;
			mult -= resFireStat.value;
			if (mult < 20) mult = 20;
			return mult;
		}
		public function damageIcePercent():Number {
			var mult:Number = 100;
			mult -= resIceStat.value;
			if (mult < 20) mult = 20;
			return mult;
		}
		public function damageLightningPercent():Number {
			var mult:Number = 100;
			mult -= resLightningStat.value;
			if (mult < 20) mult = 20;
			return mult;
		}
		public function damageDarknessPercent():Number {
			var mult:Number = 100;
			mult -= resDarknessStat.value;
			if (mult < 20) mult = 20;
			return mult;
		}
		public function damagePoisonPercent():Number {
			var mult:Number = 100;
			mult -= resPoisonStat.value;
			if (mult < 20) mult = 20;
			return mult;
		}
		public function damageWindPercent():Number {
			var mult:Number = 100;
			mult -= resWindStat.value;
			if (mult < 20) mult = 20;
			return mult;
		}
		public function damageWaterPercent():Number {
			var mult:Number = 100;
			mult -= resWaterStat.value;
			if (mult < 20) mult = 20;
			return mult;
		}
		public function damageEarthPercent():Number {
			var mult:Number = 100;
			mult -= resEarthStat.value;
			if (mult < 20) mult = 20;
			return mult;
		}
		public function damageAcidPercent():Number {
			var mult:Number = 100;
			mult -= resAcidStat.value;
			if (mult < 20) mult = 20;
			return mult;
		}
		public function damagePsychicPercent():Number {
			var mult:Number = 100;
			mult -= resPsychicStat.value;
			if (mult < 20) mult = 20;
			return mult;
		}
		public function damageTruePercent():Number {
			var mult:Number = 100;
			mult -= resTrueStat.value;
			if (mult < 20) mult = 20;
			return mult;
		}

		/**
		* Look into perks and special effects and @return summery extra chance to avoid attack granted by them.
		*/
		public function getEvasionChance():Number
		{
			var chance:Number = 0;
			if (hasPerk(PerkLib.GreaterEvade)) chance += 15;
			else if (hasPerk(PerkLib.ImprovedEvade)) chance += 10;
			else if (hasPerk(PerkLib.Evade)) chance += 5;
			if (hasPerk(PerkLib.JobRogue)) chance += 5;
			if (hasPerk(PerkLib.Spectre) && hasPerk(PerkLib.Incorporeality)) chance += 10;
			if (hasPerk(PerkLib.ElvenSense)) chance += 5;
			if (perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 3) chance += 15;
			else if (perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 2) chance += 10;
			if (isFlying()) {
				if (hasPerk(PerkLib.GreaterAerialCombat)) chance += 20;
				else if (hasPerk(PerkLib.AdvancedAerialCombat)) chance += 10;
				else chance += 5;
			} else {
				chance += (evadeStat.value * (game.time.hours < 7 || game.time.hours > 19? 2:1));
			}
			if (perkv1(IMutationsLib.CatLikeNimblenessIM) >= 4) chance += 20;
			else if (perkv1(IMutationsLib.CatLikeNimblenessIM) >= 3) chance += 15;
			else if (perkv1(IMutationsLib.CatLikeNimblenessIM) >= 2) chance += 10;
			else if (perkv1(IMutationsLib.CatLikeNimblenessIM) >= 1) chance += 5;
			if (hasPerk(PerkLib.Flexibility)) chance += 6;
			if (hasPerk(PerkLib.SmallFrame)) chance += 6;
			if (hasPerk(PerkLib.JunglesWanderer)) chance += 35;
			if (hasStatusEffect(StatusEffects.Illusion)) {
				var illDodgeChance:int = 10;
				if (perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 3) illDodgeChance += 20;
				chance += illDodgeChance;
			}
			if (this.statStore.hasBuff("Atavism")) chance += 10;
			if (hasStatusEffect(StatusEffects.BladeDance)) chance += 30;
			return chance;
		}

		public static const EVASION_SPEED:String = "Speed";
		public static const EVASION_EVADE:String = "Evade";
		public static const EVASION_FLEXIBILITY:String = "Flexibility";
		public static const EVASION_MISDIRECTION:String = "Misdirection";
		public static const EVASION_UNHINDERED:String = "Unhindered";
		public static const EVASION_BLIND:String = "Blind";
		public static const EVASION_SMALL_FRAME:String = "Small frame";
		public static const EVASION_HURRICANE_DANCE:String = "Hurricane Dance";
		public static const EVASION_WANDERER:String = "Jungle's Wanderer";
		public static const EVASION_ILLUSION:String = "Illusion";
		public static const EVASION_BLADE_DANCE:String = "Blade Dance";
		public static const EVASION_MINIMISE:String = "Minimise";
		public static const EVASION_PHASING:String = "Phasing";
		public static const EVASION_DISPLACING:String = "Displacing";
		public static const EVASION_FLYING:String = "Flying";

		public function canAutoHit():Boolean {
			return false;
		}

		/**
	    * Try to avoid and @return a reason if successfull or null if failed to evade.
		*
		* If attacker is null then you can specify attack speed for enviromental and non-combat cases. If no speed and attacker specified and then only perks would be accounted.
		*
		* This DOES account blind!
	    */
		public function getEvasionReason(considerBlindSpeed:Boolean = true, attackSpeed:int = int.MIN_VALUE, hitModifier:int = 0, dodgeArray:Array = null):String {
			var evasionReason:String;
			if (!dodgeArray) dodgeArray = [];
			
			if (hasStatusEffect(StatusEffects.GreenCovenant)) return null;
			if (considerBlindSpeed && attackSpeed != int.MIN_VALUE && spe - attackSpeed > 0 && calcSpeedDodge(attackSpeed) > 0) return EVASION_SPEED;

			var evadeChance:int = 0;

			if (hitModifier > 0) evadeChance += hitModifier;
			else if (hitModifier < 0) dodgeArray.push([hitModifier, null]);

			if (hasPerk(PerkLib.GreaterEvade)) evadeChance += 15;
			else if (hasPerk(PerkLib.ImprovedEvade)) evadeChance += 10;
			else if (hasPerk(PerkLib.Evade)) evadeChance += 5;

			if (hasPerk(PerkLib.JobRogue)) evadeChance += 5;
			if (hasPerk(PerkLib.Spectre) && hasPerk(PerkLib.Incorporeality)) evadeChance += 10;
			if (hasPerk(PerkLib.ElvenSense)) evadeChance += 5;

			if (perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 3) evadeChance += 15;
			else if (perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 2) evadeChance += 10;

			if (isFlying()) {
				if (hasPerk(PerkLib.GreaterAerialCombat)) evadeChance += 20;
				else if (hasPerk(PerkLib.AdvancedAerialCombat)) evadeChance += 10;
				else evadeChance += 5;

				dodgeArray.push([evadeChance, EVASION_FLYING]);
			} else {
				evadeChance += (evadeStat.value * (game.time.hours < 7 || game.time.hours > 19? 2:1));
				dodgeArray.push([evadeChance, EVASION_EVADE]);
			}

			var flexDodgeChance:int = 0;
			if (perkv1(IMutationsLib.CatLikeNimblenessIM) >= 4) flexDodgeChance += 20;
			else if (perkv1(IMutationsLib.CatLikeNimblenessIM) >= 3) flexDodgeChance += 15;
			else if (perkv1(IMutationsLib.CatLikeNimblenessIM) >= 2) flexDodgeChance += 10;
			else if (perkv1(IMutationsLib.CatLikeNimblenessIM) >= 1) flexDodgeChance += 5;
			if (hasPerk(PerkLib.Flexibility)) flexDodgeChance += 6;
			if (flexDodgeChance > 0) dodgeArray.push([flexDodgeChance, EVASION_FLEXIBILITY]);

			if (hasPerk(PerkLib.SmallFrame)) dodgeArray.push([6, EVASION_SMALL_FRAME]);

			if (hasPerk(PerkLib.JunglesWanderer)) dodgeArray.push([35, EVASION_WANDERER]);

			if (hasStatusEffect(StatusEffects.Illusion)) {
				var illDodgeChance:int = 10;
				if (perkv1(IMutationsLib.KitsuneThyroidGlandIM) >= 3) illDodgeChance += 20;
				dodgeArray.push([illDodgeChance, EVASION_ILLUSION]);
			}

			if (hasStatusEffect(StatusEffects.BladeDance)) dodgeArray.push([30, EVASION_BLADE_DANCE]);

			//Any remaining chances will cause the attack to hit
			var currentDodgeSum:int = 0;
			for each (var pair:Array in dodgeArray) {
				currentDodgeSum += pair[0];
			}
			if (currentDodgeSum < 100) dodgeArray.push([(100 - currentDodgeSum), null]);

			evasionReason = Utils.weightedRandom(dodgeArray);
			
			return evasionReason;
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
			return !(ability.range == RANGE_MELEE && isFlying());

		}

		public function getEvasionRoll(considerBlindSpeed:Boolean = true, attackSpeed:int = int.MIN_VALUE, hitModifier:int = 0):Boolean
		{
			return getEvasionReason(considerBlindSpeed, attackSpeed, hitModifier) != null;
		}

		public function get vagorass():IOrifice {
			return hasVagina() ? vaginas[0] : ass;
		}
		
		/**
		 * Generate increments for stats
		 *
		 * @return Object of (newStat-oldStat) with keys str, tou, spe, inte, wis, lib, sens, lust, cor
		 * and flags scale
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
				scale: [ true, "="]
			};
			var aliases:Object = {
				"strength":"str",
				"toughness": "tou",
				"speed": "spe",
				"intellect": "int",
				"inte": "int",
				"wisdom": "wis",
				"libido": "lib",
				"sensitivity": "sen",
				"sens": "sen",
				"lust": "lus",
				"corruption": "cor",
				"sca": "scale",
				"scaled": "scale",
				"res": "scale",
				"resisted": "scale"
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
			var newStr:Number = EngineCore.applyOperator(c.str, argDefs.str[1], argDefs.str[0]);
			var newTou:Number = EngineCore.applyOperator(c.tou, argDefs.tou[1], argDefs.tou[0]);
			var newSpe:Number = EngineCore.applyOperator(c.spe, argDefs.spe[1], argDefs.spe[0]);
			var newInte:Number = EngineCore.applyOperator(c.inte, argDefs.int[1], argDefs.int[0]);
			var newWis:Number = EngineCore.applyOperator(c.wis, argDefs.wis[1], argDefs.wis[0]);
			var newLib:Number = EngineCore.applyOperator(c.lib, argDefs.lib[1], argDefs.lib[0]);
			var newSens:Number = EngineCore.applyOperator(c.sens, argDefs.sen[1], argDefs.sen[0]);
			var newLust:Number = EngineCore.applyOperator(c.lust, argDefs.lus[1], argDefs.lus[0]);
			var newCor:Number = EngineCore.applyOperator(c.cor, argDefs.cor[1], argDefs.cor[0]);
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
				scale   : argDefs.scale[0]
			};
		}

		/**Creates Dynamic Perks that fulfill three criteria, returned in menuGen format.
		 *
		 * 1.Will use perkV1 to store variants of the same perk.
		 *
		 * 2.Has a changing Buff state due to the variants.
		 *
		 * 3.Has a changing Requirement state due to the varients.
		 *
		 * @param pPerk: Takes in the perk to be augmented.
		 * @param pClass: Perk file/Class name, to simplify and unify called functions.
		 * @return Array: Two item Array consisting of perk name[0], and a prepared function that will create/modify the perk/mutation[1].
		 *
		 */
		public static function cDynPerk(pPerk:PerkType, pClass:Class, target:*):*{
			target = CoC.instance.player;
			var pLvl:int = target.perkv1(pPerk);	//Gets Mutation Level if it exists.
			var pMax:int = pClass._perkLvl;	//Max Mutation Level
			//outputText(""+pPerk.name() + " Perk Tier: " + pLvl + "\n");
			extPerkTrigger(pClass.pReqs, pLvl);	//Requirements Loading.
			//trace("Requirements loaded in.");
			if (pPerk.available(target) && pMax > pLvl){
				//trace("Requirements met, adding in.");
				return([pPerk.name(), acquirePerk, pPerk.desc()]);	//This is witchcraft, not sure how acquirePerk still recalls which perk to give, but it does.
			}
			else if(pMax == pLvl){
				return([pPerk.name(), false, "You already have the highest tier!"]);
			}
			else{
				//trace("Unable to meet requirements/requirements borked.");
				return([pPerk.name(), false, "You don't meet the requirements for this!"]);
			}

			/*	//Requirements debug.
			var reqs:Array = [];
			for each (var cond:Object in pPerk.requirements) {
				var reqStr:String = cond.text;
				var color:String = "";
				if (!(reqStr.indexOf("Mutation") >= 0)) { //Ignores the "free mutation slot" note.
					if (cond.fn(player)) {
						color = "#008000";
					}
					else {
						color = "#800000";
					}
					reqs.push("<font color='"+color+"'>"+cond.text+"</font>");
				}
			}
			outputText("Requirements: " + reqs.join(", "));*/

			//Functions that need to be triggered externally go here. I.E. Requirements/Buffs due to circular dependency.
			function extPerkTrigger(fTrigger:Function, pLvl2:int):*{
				try{
					var result:* = fTrigger(pLvl2);
					//trace("External Function Trigger Success");
					return result;
				}
				catch (e:Error){
					//trace("External Function Trigger Failed. \n" + e.getStackTrace());
				}
			}

			//Gives the player the actual mutation itself.
			function acquirePerk(nextFunc:Function = null):void{
				try{
					if (nextFunc == null){
						//trace("Missing nextFunc, aborting perk adding.");
						EngineCore.outputText("Someone forgot to add a nextFunc to their acquirePerk. Please report which perk you selected. The perk was not applied.");
						nextFunc = SceneLib.camp.returnToCampUseOneHour;
					}
					else{
						if (!target.hasPerk(pPerk)){
							target.createPerk(pPerk, 1,0,0,0);
						}
						else{
							target.setPerkValue(pPerk,1,pLvl + 1);
						}
						setBuffs();
						//trace("Perk applied.");
					}
				} catch(e:Error){
					trace(e.getStackTrace());
					EngineCore.outputText("Something has gone wrong with Dynamic Perks. Please report this to JTecx along with which perk/mutation was selected, along with the bonk stick.");
					EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
				}
				nextFunc();
			}

			//Sets up the buff for the perk.
			function setBuffs():void{
				var stname:String = "perk_" + pPerk.id;
				var pBuff:Object = extPerkTrigger(pClass.pBuffs, pLvl + 1);
				if (target.statStore.hasBuff(stname)){
					target.statStore.removeBuffs(stname);
				}
				target.statStore.addBuffObject(
						pBuff,
						stname,
						{text:pPerk.name(), save:false}
				);
				//trace("Perk Buffs Applied.");
			}
		}

		//Use if a Dynamic Perk's buffs have been updated.
		public static function updateDynamicPerkBuffs(pPerk:PerkType, pClass:Class, target:*):*{
			target = CoC.instance.player;
			var stname:String = "perk_" + pPerk.id;
			var pLvl:int = target.perkv1(pPerk);
			var pBuff:Object = extPerkTrigger(pClass.pBuffs, pLvl);
			if (target.statStore.hasBuff(stname)){
				target.statStore.removeBuffs(stname);
			}
			else{
				trace("Warning: Perk Buff update failed either due to perk not existing, or buff was never applied in the first place.");
			}
			trace(pPerk.name() + ": ");
			for(var id:String in pBuff) {
				var value:Object = pBuff[id];

				trace(id + " = " + value);
			}
			trace("^^^^^^^^^^^^^^^^^^^^^^^^^^^^PERK")
			target.statStore.addBuffObject(
					pBuff,
					stname,
					{text:pPerk.name(), save:false}
			);
			trace("Perk Buffs Updated.");

			function extPerkTrigger(fTrigger:Function, pLvl2:int):*{
				try{
					var result:* = fTrigger(pLvl2);
					trace("External Function Trigger Success");
					return result
				}
				catch (e:Error){
					trace("External Function Trigger Failed. \n" + e.getStackTrace());
				}
			}
		}

		/**
		 * Function called when a statuseffect is added to a creature, to allow for additional functionality
		 * @param Status Effect Instance being attached
		 */
		public function onStatusAttach(sec:StatusEffectClass):void {
			//Do nothing
		}

		/**
		 * Function called when a statuseffect is removed from a creature, to allow for additional functionality
		 * @param Status Effect Instance being removed
		 */
		public function onStatusRemove(sec:StatusEffectClass):void {
			//Do nothing
		}
	}
}
