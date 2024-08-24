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
import classes.Items.Shield;
import classes.Items.WeaponRange;
import classes.Race;

public class DynamicShield extends Shield implements IDynamicItem {
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
	
	public function DynamicShield(id:String, params:Object) {
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
		var perk:Array          = (subtype.perk || []).slice();
		var tags:Array          = subtype.tags || [];
		var block:Number        = subtype.block;
		var itemEffects:Array   = subtype.effects || [];
		var qitemEffects:Array  = subtype.qeffects || [];
		if (parsedParams.error) {
			trace("[ERROR] Failed to parse " + id + " with error " + parsedParams.error);
			name      = "ERROR " + name;
			shortName = "ERROR " + shortName;
			longName  = "ERROR " + longName;
			desc      = "INVALID ITEM:\n" + parsedParams.error + "\n" + desc;
		}
		
		block *= (1.0 + quality * subtype.qattack);
		
		super(
				id,
				shortName,
				name,
				longName,
				Math.max(1, block),
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
	
	override public function get block():Number {
		var block:Number = super.block;
		var ie:ItemEffect = findEffect(IELib.DefenseMult_RaceTier);
		if (ie) {
			block *= 1 + ie.power * game.player.racialTier(ie.value1 as Race) / 100;
		}
		return block;
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
	 * - desc: description, can contain templates
	 * - (optional) perks: Array of weapon perks (WP_XXXX)
	 * - (optional) tags: Array of item tags (ItemTag.XXXX)
	 * - (optional) quality: force quality
	 * - block: Base attack power
	 * - qdef: quality-per-defence (0.25 = +25% per +1 qualiity)
	 * - value: Base cost in gems
	 */
	public static const Subtypes:Object = {
		"shield": {
			chance: 1,
			name: "Shield",
			shortName: "Shield",
			desc: "This is a basic light shield.",
			block: 4,
			qattack: 0.25,
			value: 120
		},
		"tome": {
			chance: 1,
			name: "Tome",
			shortName: "Tome",
			desc: "This is a basic tome of knowledge.",
			block: 4,
			qattack: 0.25,
			value: 120
		}
	}
}
}
