package classes.Items.Dynamic {
import classes.ItemType;
import classes.Items.DynamicItems;
import classes.Items.Enchantment;
import classes.Items.EnchantmentType;
import classes.Items.Equipable;
import classes.Items.IDynamicItem;
import classes.Items.Jewelry;

public class DynamicRing extends Jewelry implements IDynamicItem {
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
	
	public function DynamicRing(id:String, params:Object) {
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
		var perks:Array         = (subtype.perks || []).slice();
		var tags:Array          = subtype.tags || [];
		var effectId:int        = subtype.effectId;
		var effectPower:Number  = subtype.effectPower;
		var itemEffects:Array   = subtype.effects || [];
		var qitemEffects:Array  = subtype.qeffects || [];
		if (parsedParams.error) {
			trace("[ERROR] Failed to parse " + id + " with error " + parsedParams.error);
			name      = "ERROR " + name;
			shortName = "ERROR " + shortName;
			longName  = "ERROR " + longName;
			desc      = "INVALID ITEM:\n" + parsedParams.error + "\n" + desc;
		}
		
		effectPower = Math.floor(effectPower*(1.0 + quality * subtype.qpower));
		
		super(
				id,
				shortName,
				name,
				longName,
				effectId,
				effectPower,
				Math.max(1, value),
				desc,
				"",
				perks.join(", ")
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
	 * - desc: description, can contain templates
	 * - (optional) tags: Array of item tags (ItemTag.XXXX)
	 * - (optional) quality: force quality
	 * - value: Base cost in gems
	 * - effectId: Ring effect id (RINGEFF_XXXX)
	 * - effectPower: Ring effect magnitude
	 * - qpower: Ring effect magnitude per quality level (0.25 = +25% per +1)
	 */
	public static const Subtypes:Object = {
		"ring": {
			chance: 10,
			name: "ring",
			shortName: "Ring",
			desc: "A plain-looking ring.",
			quality: 0,
			value: 15,
			effectId: 0,
			effectPower: 0,
			qpower: 0
		},
		"crimstone ring": {
			chance: 1,
			name: "crimstone ring",
			shortName: "Crimst.Ring",
			desc: "This ring is topped with crimstone. It's said that this will help to keep your desires burning.",
			value: 1000,
			effectId: RINGEFF_MINLUST,
			effectPower: 10,
			qpower: 0.25
		},
		"icestone ring": {
			chance: 1,
			name: "icestone ring",
			shortName: "Icestn.Ring",
			desc: "This ring is topped with icestone. It's said that this will counter ever-burning desires.",
			value: 1000,
			effectId: RINGEFF_MINLUST,
			effectPower: -10,
			qpower: 0.25
		}
	}
}
}
