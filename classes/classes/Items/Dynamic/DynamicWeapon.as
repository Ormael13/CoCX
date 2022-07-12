package classes.Items.Dynamic {
import classes.ItemType;
import classes.Items.Dynamic.Effects.SimpleRaceEnchantment;
import classes.Items.DynamicItems;
import classes.Items.Enchantment;
import classes.Items.EnchantmentLib;
import classes.Items.EnchantmentType;
import classes.Items.Equipable;
import classes.Items.IDynamicItem;
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
		var effDesc:String      = parsedParams.effectDesc;
		var value:Number        = parsedParams.value;
		var verb:String         = subtype.verb;
		var type:String         = subtype.type;
		var perks:Array         = (subtype.perks || []).slice();
		var tags:Array          = subtype.tags || {};
		var attack:Number       = subtype.attack;
		if (parsedParams.error) {
			trace("[ERROR] Failed to parse " + id + " with error " + parsedParams.error);
			name      = "ERROR " + name;
			shortName = "ERROR " + shortName;
			longName  = "ERROR " + longName;
			desc      = "INVALID ITEM:\n" + parsedParams.error + "\n" + desc;
		}
		
		attack *= (1.0 + quality * subtype.qattack);
		desc += "\n\n"+effDesc;
		
		super(
				id,
				shortName,
				name,
				longName,
				verb,
				Math.max(1, attack),
				Math.max(1, value),
				desc,
				perks.join(", "),
				type
		);
		
		stackSize = 1;
		withTags(tags);
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
	
	override public function get attack():Number {
		var attack:Number = super.attack;
		var e:SimpleRaceEnchantment = enchantmentOfType(EnchantmentLib.RaceAttackBonus) as SimpleRaceEnchantment;
		if (e) {
			attack *= 1 + 0.05 * e.power * game.player.racialTier(e.race);
		}
		return attack;
	}
	
	override public function equipText():void {
		DynamicItems.equipText(this);
	}
	
	override public function beforeEquip(doOutput:Boolean):Equipable {
		if (!identified) {
			return (identifiedCopy() as Equipable).beforeEquip(doOutput);
		}
		return super.beforeEquip(doOutput);
	}
	
	override public function afterEquip(doOutput:Boolean):void {
		for each (var e:Enchantment in effects) {
			e.onEquip(game.player, this);
		}
	}
	override public function afterUnequip(doOutput:Boolean):void {
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
		"dagger": {
			chance: 1,
			name: "dagger",
			shortName: "dagger",
			verb: "stab",
			desc: "A small blade. Preferred weapon for the rogues.",
			perks: [WP_SMALL],
			type: WT_DAGGER,
			attack: 3,
			qattack: 0.25,
			value: 120
		},
		"flail": {
			chance: 0.5,
			name: "flail",
			shortName: "flail",
			verb: "smash",
			desc: "This is a flail, a weapon consisting of a metal spiked ball attached to a stick by chain. Be careful with this as you might end up injuring yourself.",
			perks: [WP_WHIPPING],
			type: WT_MACE_HAMMER,
			attack: 10,
			qattack: 0.25,
			value: 400
		},
		"katana": {
			chance: 0.5,
			name: "katana",
			shortName: "katana",
			verb: "keen cut",
			desc: "A curved bladed weapon that cuts through flesh with the greatest of ease.",
			perks: [WP_LARGE, WP_AP10],
			type: WT_DUELING,
			attack: 17,
			qattack: 0.25,
			value: 680
		},
		"mace": {
			chance: 0.5,
			name: "mace",
			shortName: "mace",
			verb: "smash",
			desc: "This is a mace, designed to be able to crush various defenses.",
			type: WT_MACE_HAMMER,
			attack: 9,
			qattack: 0.25,
			value: 360
		},
		"spear": {
			chance: 1,
			name: "spear",
			shortName: "spear",
			verb: "stab",
			desc: "A staff with a sharp blade at the tip designed to pierce through the toughest armor.",
			type: WT_SPEAR,
			perks: [WP_AP40],
			attack: 7,
			qattack: 0.25,
			value: 400
		},
		"sword": {
			chance: 1,
			name: "sword",
			shortName: "sword",
			verb: "slash",
			desc: "A long sword made of the finest steel.",
			type: WT_SWORD,
			attack: 10,
			qattack: 0.25,
			value: 200
		},
		"uchigatana": {
			chance: 0.25,
			name: "uchigatana",
			shortName: "uchigtn",
			verb: "keen cut",
			desc: "A one handed curved bladed weapon that cuts through flesh with the greatest of ease. Can also be wielded with both hands.",
			perks: [WP_HYBRID],
			type: WT_DUELING,
			attack: 15,
			qattack: 0.25,
			value: 680
		}
	}
}
}
