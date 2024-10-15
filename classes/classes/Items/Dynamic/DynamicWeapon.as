package classes.Items.Dynamic {
import classes.ItemType;
import classes.Items.Dynamic.Effects.SimpleRaceEnchantment;
import classes.Items.DynamicItems;
import classes.Items.Enchantment;
import classes.Items.EnchantmentLib;
import classes.Items.EnchantmentType;
import classes.Items.Equipable;
import classes.Items.IDynamicItem;
import classes.Items.IELib;
import classes.Items.Weapon;

public class DynamicWeapon extends Weapon implements IDynamicItem {
	public var _subtypeId:String;
	public var _subtype:Object;
	public var _quality:int;
	public var _rarity:int;
	public var _curseStatus:int;
	public var _cursed:Boolean;
	public var _identified:Boolean;
	public var _effects:/*Enchantment*/Array;
	public var _effectDesc:Array;
	
	public override function get cursed():Boolean {
		return _cursed;
	}
	
	public function get subtypeId():String {
		return _subtypeId;
	}
	
	public function get subtype():Object {
		return _subtype;
	}
	
	public function get quality():int {
		return _quality;
	}
	
	public function get rarity():int {
		return _rarity;
	}
	
	public function get curseStatus():int {
		return _curseStatus;
	}
	
	public function get identified():Boolean {
		return _identified;
	}
	
	public function get effects():/*Enchantment*/Array {
		return _effects;
	}
	
	public function DynamicWeapon(id:String, params:Object) {
		var parsedParams:Object = DynamicItems.loadCommonDynamicItemParams(params, Subtypes);
		_subtypeId              = parsedParams.subtypeId;
		_subtype                = parsedParams.subtype || {};
		_quality                = parsedParams.quality;
		_rarity                 = parsedParams.rarity;
		_curseStatus            = parsedParams.curseStatus;
		_cursed                 = parsedParams.cursed;
		_identified             = parsedParams.identified;
		_effects                = parsedParams.effects;
		var shortName:String    = parsedParams.shortName;
		var name:String         = parsedParams.name;
		var longName:String     = parsedParams.longName;
		var desc:String         = parsedParams.desc;
		_effectDesc             = parsedParams.effectDesc;
		var value:Number        = parsedParams.value;
		var buffs:Object        = parsedParams.buffs;
		var verb:String         = subtype.verb;
		var type:String         = subtype.type;
		var size:int            = valueOr(subtype.size, WSZ_LARGE);
		var dual:Boolean        = valueOr(subtype.dual, false);
		var tags:Array          = subtype.tags || [];
		var attack:Number       = subtype.attack;
		var itemEffects:Array   = subtype.effects || [];
		var qitemEffects:Array  = subtype.qeffects || [];
		if (parsedParams.error) {
			trace("[ERROR] Failed to parse " + id + " with error " + parsedParams.error);
			name      = "ERROR " + name;
			shortName = "ERROR " + shortName;
			longName  = "ERROR " + longName;
			desc      = "INVALID ITEM:\n" + parsedParams.error + "\n" + desc;
		}
		
		attack *= (1.0 + quality * subtype.qattack);
		
		super(
				id,
				shortName,
				name,
				longName,
				verb,
				Math.max(1, attack),
				Math.max(1, value),
				desc,
				type,
				size,
				dual
		);
		
		DynamicItems.postConstruct(this, tags, buffs, itemEffects, qitemEffects, quality);
	}
	
	override public function effectDescriptionParts():Array {
		return super.effectDescriptionParts().concat(_effectDesc);
	}
	
	override public function get buttonColor():String {
		return DynamicItems.itemButtonColor(this);
	}
	
	override public function getEnchantments():Array {
		return effects;
	}
	
	override public function hasEnchantment(type:EnchantmentType):Boolean {
		return DynamicItems.itemHasEnchantment(this, type);
	}
	
	override public function enchantmentPower(type:EnchantmentType):Number {
		return DynamicItems.itemEnchantmentPower(this, type);
	}
	
	override public function enchantmentOfType(type:EnchantmentType):Enchantment {
		return DynamicItems.itemEnchantmentOfType(this, type);
	}
	
	private var _identifiedCopy:ItemType;
	
	/**
	 * Returns fully identified copy of this weapon (this if it is already identified)
	 */
	public function identifiedCopy():ItemType {
		if (identified) return this;
		if (!_identifiedCopy) {
			_identifiedCopy = DynamicItems.identifiedCopy(this);
		}
		return _identifiedCopy;
	}
	
	public function uncursedCopy():ItemType {
		return DynamicItems.uncursedCopy(this);
	}
	
	public function moddedCopy(options:Object):ItemType {
		return DynamicItems.moddedCopy(this, options);
	}
	
	public function copyWithEnchantment(e:Enchantment):ItemType {
		return DynamicItems.copyWithEnchantment(this, e);
	}
	
	public function copyWithoutEnchantment(e:Enchantment):ItemType {
		return DynamicItems.copyWithoutEnchantment(this, e);
	}
	
	override public function equipText():void {
		DynamicItems.equipText(this);
	}
	
	override public function beforeEquip(doOutput:Boolean, slot:int):Equipable {
		if (!identified) {
			return (identifiedCopy() as Equipable).beforeEquip(doOutput, slot);
		}
		return super.beforeEquip(doOutput, slot);
	}
	
	override public function afterEquip(doOutput:Boolean, slot:int):void {
		super.afterEquip(doOutput, slot);
		for each (var e:Enchantment in effects) {
			e.onEquip(game.player, this);
		}
	}
	override public function afterUnequip(doOutput:Boolean, slot:int):void {
		super.afterUnequip(doOutput, slot);
		for each (var e:Enchantment in effects) {
			e.onUnequip(game.player, this);
		}
	}
	
	/**
	 * Key: subtype id
	 * Values:
	 * - chance: weight when generating random item of this category, default 1
	 * - name: displayed name
	 * - shortName: for buttons. keep it VERY short, 4-7 chars
	 * - TODO @aimozg longName?
	 * - verb: used in attack texts, ex. "slash"
	 * - desc: description, can contain templates
	 * - type: Weapon class (WT_XXXX)
	 * - (optional) size: WSZ_XXXX, default WSZ_MEDIUM
	 * - (optional) dual: Boolean, default faluse
	 * - (optional) tags: Array of item tags (ItemTag.XXXX)
	 * - (optional) quality: force quality
	 * - (optional) effects: item effects, array of tuples [ItemEffectType, power, v1, v2, v3, v4] with v1-v4 optional
	 * - (optional) qeffects: item effect power increase per quality, array of tuples [ItemEffectType, v1, v2, v3, v4] with v1-v4 optional
	 * - attack: Base attack power
	 * - qattack: Attack-per-quality (0.25 = +25% per +1 qualiity)
	 * - value: Base cost in gems
	 *
	 * qeffects searches for effect with same ItemEffectType and v1-v4
	 */
	public static const Subtypes:Object = {
		"claymore":   {
			chance:    0.5,
			name:      "large claymore",
			shortName: "L.Claymore",
			longName:  "a large claymore",
			verb:      "cleaving sword-slash",
			desc:      "A massive sword that a very strong warrior might use.",
			type:      WT_SWORD,
			size:      WSZ_LARGE,
			effects:   [
				[IELib.ScaleAttack_Str, 60]
			],
			attack:    15,
			qattack:   0.25,
			value:     600
		},
		"dagger":     {
			chance:    1,
			name:      "dagger",
			shortName: "Dagger",
			verb:      "stab",
			desc:      "A small blade. A preferred weapon of rogues.",
			size:      WSZ_SMALL,
			type:      WT_DAGGER,
			attack:    3,
			qattack:   0.25,
			value:     120
		},
		"flail":      {
			chance:    0.5,
			name:      "flail",
			shortName: "Flail",
			verb:      "smash",
			desc:      "This is a flail, a weapon consisting of a metal spiked ball attached to a stick by chain. Be careful with this as you might end up injuring yourself.",
			tags:      [W_WHIPPING],
			type:      WT_MACE_HAMMER,
			size:      WSZ_MEDIUM,
			attack:    10,
			qattack:   0.25,
			value:     400
		},
		"halberd":    {
			chance:    0.25,
			name:      "halberd",
			shortName: "Halberd",
			longName:  "a halberd",
			verb:      "slash",
			desc:      "This imposing cross between a spear and an axe features a 5 foot solid steel pole with two crescent-shaped blades on each end of the pole, with a prominent spear tip.  The tool feels heavy enough to crush armor.",
			tags:      [W_WHIRLWIND],
			type:      WT_POLEARM,
			size:      WSZ_LARGE,
			effecs:    [
				[IELib.ArmorPenetration, 40],
				[IELib.ScaleAttack_Str, 100],
			],
			qeffects: [
				[IELib.ArmorPenetration, 3] // +3% armor penetration per quality point
			],
			attack:    30,
			qattack:   0.2,
			value:     1200
		},
		"kama":       {
			chance:    0.5,
			name:      "kama",
			shortName: "Kama",
			longName:  "a kama",
			verb:      "slash",
			desc:      "The kama is a simple and elegant hand scythe weapon. Preferred weapon for the ninja fans.",
			type:      WT_SCYTHE,
			size:      WSZ_SMALL,
			effects:   [
				[IELib.Bleed, 10]
			],
			qeffects: [
				[IELib.Bleed, 2] // +2% bleed chance per quality point
			],
			attack:    4,
			qattack:   0.2,
			value:     320
		},
		"katana":     {
			chance:    0.5,
			name:      "katana",
			shortName: "Katana",
			verb:      "keen cut",
			desc:      "A curved bladed weapon that cuts through flesh with the greatest of ease.",
			size:      WSZ_LARGE,
			effects:   [
				[IELib.ArmorReduction, 10]
			],
			type:      WT_DUELING,
			attack:    17,
			qattack:   0.25,
			value:     680
		},
		"mace":       {
			chance:    0.5,
			name:      "mace",
			shortName: "Mace",
			verb:      "smash",
			desc:      "This is a mace, designed to be able to crush various defenses.",
			type:      WT_MACE_HAMMER,
			size:      WSZ_MEDIUM,
			attack:    9,
			qattack:   0.25,
			value:     360
		},
		"nodachi":    {
			chance:    0.1,
			name:      "nodachi",
			shortName: "Nodachi",
			longName:  "a nodachi",
			verb:      "keen cut",
			desc:      "A curved bladed weapon, over 3 meters long, that cuts through flesh with the greatest of ease.",
			type:      WT_DUELING,
			size:      WSZ_MASSIVE,
			effects:   [
				[IELib.ScaleAttack_StrXL, 250]
			],
			attack:    65,
			qattack:   0.25,
			value:     2600
		},
		"ribbon":     {
			chance:    0.25,
			name:      "long ribbon",
			shortName: "Ribbon",
			longName:  "a long ribbon",
			verb:      "whip-like slash",
			desc:      "A long ribbon made of fine silk that despite it seemly fragile appearance can deal noticeable damage to even few enemies at once.  Perfect example of weapon that is more dangerous than it looks.",
			type:      WT_RIBBON,
			size:      WSZ_MEDIUM,
			tags:      [W_WHIPPING],
			attack:    5,
			qattack:   0.25,
			value:     200
		},
		"scimitar":   {
			chance:    0.5,
			name:      "scimitar",
			shortName: "Scimitar",
			longName:  "a scimitar",
			verb:      "slash",
			desc:      "This curved sword is made for slashing.  No doubt it'll easily cut through flesh.",
			type:      WT_DUELING,
			size:      WSZ_MEDIUM,
			attack:    15,
			qattack:   0.25,
			value:     600
		},
		"spear":      {
			chance:    1,
			name:      "spear",
			shortName: "Spear",
			verb:      "stab",
			desc:      "A staff with a sharp blade at the tip designed to pierce through the toughest armor.",
			type:      WT_SPEAR,
			size:      WSZ_MEDIUM,
			effects:   [
				[IELib.ArmorPenetration, 40]
			],
			qeffects: [
				[IELib.ArmorPenetration, 3] // +3% AP per quality point
			],
			attack:    7,
			qattack:   0.2,
			value:     400
		},
		"sword":      {
			chance:    1,
			name:      "sword",
			shortName: "Sword",
			verb:      "slash",
			desc:      "A long sword made of the finest steel.",
			type:      WT_SWORD,
			size:      WSZ_MEDIUM,
			attack:    10,
			qattack:   0.25,
			value:     200
		},
		"uchigatana": {
			chance:    0.25,
			name:      "uchigatana",
			shortName: "Uchigatana",
			verb:      "keen cut",
			desc:      "A one-handed curved bladed weapon that cuts through flesh with the greatest of ease. Can also be wielded with both hands.",
			tags:      [W_HYBRID],
			type:      WT_DUELING,
			size:      WSZ_MEDIUM,
			attack:    15,
			qattack:   0.25,
			value:     680
		},
		"warhammer":  {
			chance:    0.25,
			name:      "huge warhammer",
			shortName: "Warhammer",
			longName:  "a huge warhammer",
			verb:      "smash",
			desc:      "A huge warhammer made almost entirely of steel that only the strongest warriors could use.  Getting hit with this might stun the victim.",
			tags:      [W_WHIRLWIND],
			type:      WT_MACE_HAMMER,
			size:      WSZ_LARGE,
			effects:   [
				[IELib.Stun, 10],
				[IELib.ScaleAttack_Str, 80]
			],
			qeffects:  [
				[IELib.Stun, 1] // +1% stun chance per quality point
			],
			attack:    15,
			qattack:   0.25,
			value:     1200
		},
		"whip":       {
			chance:    0.25,
			name:      "coiled whip",
			shortName: "Whip",
			longName:  "a coiled whip",
			verb:      "whip-crack",
			desc:      "A coiled length of leather designed to lash your foes into submission.  There's a chance the bondage-inclined might enjoy it!",
			tags:      [W_WHIPPING],
			type:      WT_WHIP,
			size:      WSZ_MEDIUM,
			effects:   [
				[IELib.Buff, 35, 'teasedmg']
			],
			qeffects:  [
				[IELib.Buff, 5, 'teasedmg'] // +5 teasedmg per quality point
			],
			attack:    5,
			qattack:   0,
			value:     200
		},
		"zweihander": {
			chance:    0.1,
			name:      "zweihander",
			shortName: "Zwnder",
			longName:  "a zweihander",
			verb:      "slash",
			desc:      "A zweihander is a longsword recognizable by its six foot monster of a blade and its wavy edges. The pommel and handle of this one are decorated with a fierce-looking wolf and made of silver with other lupine motifs as ornaments.",
			type:      WT_SWORD,
			size:      WSZ_LARGE,
			effects:   [
				[IELib.Stun, 30],
				[IELib.ScaleAttack_Str, 105]
			],
			qeffects:  [
				[IELib.Stun, 2] // +2% stun chance per quality point
			],
			attack:    31,
			qattack:   0.2,
			value:     2480
		}
	}
}
}
