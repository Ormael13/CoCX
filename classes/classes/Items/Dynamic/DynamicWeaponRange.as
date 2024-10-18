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
import classes.Items.ItemEffect;
import classes.Items.WeaponRange;

public class DynamicWeaponRange extends WeaponRange implements IDynamicItem {
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

	public function DynamicWeaponRange(id:String, params:Object) {
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
		var perk:Array          = (subtype.perk || []).slice();
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
				perk.join(", ")
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
	 * - (optional) perks: Array of weapon perks (WP_XXXX)
	 * - (optional) tags: Array of item tags (ItemTag.XXXX)
	 * - (optional) quality: force quality
	 * - attack: Base attack power
	 * - qattack: Attack-per-quality (0.25 = +25% per +1 qualiity)
	 * - value: Base cost in gems
	 */
	public static const Subtypes:Object = {
		"bow": {
			chance: 1,
			name: "bow",
			shortName: "Bow",
			verb: "shot",
			desc: "This is a light bow.",
			perk: WT_BOW,
			attack: 1,
			qattack: 0.25,
			value: 120
		},
		"crossbow": {
			chance: 0.5,
			name: "crossbow",
			shortName: "Crossbow",
			verb: "shot",
			desc: "This is a light crossbow, a most basic one that fires bolts at your enemies.",
			perk: WT_CROSSBOW,
			attack: 5,
			qattack: 0.25,
			value: 120
		},
		"pistol": {
			chance: 0.5,
			name: "pistol",
			shortName: "pistol",
			verb: "shot",
			desc: "This is a basic pistol. Can fire once before a reload is required.",
			perk: WT_PISTOL,
			attack: 14,
			qattack: 0.25,
			value: 360
		},
		"rifle": {
			chance: 0.3,
			name: "rifle",
			shortName: "rifle",
			verb: "shot",
			desc: "This is a basic rifle. Can fire once before a reload is required.",
			perk: WT_RIFLE,
			attack: 16,
			qattack: 0.25,
			value: 590
		},
		"2h firearm": {
			chance: 0.1,
			name: "2h firearm",
			shortName: "2h Firearm",
			verb: "slash",
			desc: "A highly accurate rifle.",
			perk: WT_2H_FIREARM,
			attack: 10,
			qattack: 0.25,
			value: 200
		},
		"throwing": {
			chance: 1,
			name: "throwing knife",
			shortName: "Throwing Knife",
			verb: "shot",
			desc: "A simple throwing knife.",
			perk: WT_THROWING,
			attack: 3,
			qattack: 0.25,
			value: 200
		},
		"tome": {
			chance: 0.5,
			name: "tome",
			shortName: "Tome",
			verb: "shot",
			desc: "A tome to assist with casting simple spells.",
			type: WT_TOME,
			attack: 0,
			qattack: 0.25,
			value: 200
		}
	}
}
}
