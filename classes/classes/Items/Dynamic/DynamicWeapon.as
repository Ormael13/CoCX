package classes.Items.Dynamic {
import classes.EngineCore;
import classes.ItemType;
import classes.Items.DynamicItems;
import classes.Items.Enchantment;
import classes.Items.EnchantmentType;
import classes.Items.IDynamicItem;
import classes.Items.ItemTemplateLib;
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
	
	override public function get buttonColor():String {
		return DynamicItems.itemButtonColor(this);
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
		var value:Number        = parsedParams.value;
		var verb:String         = subtype.verb;
		var type:String         = subtype.type;
		var perks:Array         = (subtype.perks || []).slice();
		var attack:Number       = subtype.attack;
		if (parsedParams.error) {
			trace("[ERROR] Failed to parse "+id+" with error "+parsedParams.error);
			name      = "ERROR " + name;
			shortName = "ERROR " + shortName;
			longName  = "ERROR " + longName;
			desc      = "INVALID ITEM:\n" + parsedParams.error + "\n" + desc;
		}
		
		attack *= (1.0 + quality*subtype.qattack);
		
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
			var params:Object = templateParams();
			params.c |= DynamicItems.CS_KNOWN_MASK; // set known flag
			for each (var effect:Array in params.e) {
				effect[0] = 1; // set identified flag
			}
			var id:String = dynamicItemId(templateId(),params);
			_identifiedCopy = lookupItem(id);
		}
		return _identifiedCopy;
	}
	public function uncursedCopy():ItemType {
		if (!cursed) return this;
		var params:Object = templateParams();
		params.c = DynamicItems.KNOWN_UNCURSED;
		var id:String = dynamicItemId(templateId(),params);
		return lookupItem(id);
	}
	
	public function moddedCopy(options:Object):ItemType {
		return ItemTemplateLib.instance.createWeapon(
				valueOr(options.t, subtype),
				valueOr(options.r, rarity),
				valueOr(options.q, quality),
				valueOr(options.c, curseStatus),
				valueOr(options.e, effects)
		);
	}
	
	override public function useText():void {
		outputText("You equip " + longName + ".  ");
		if (cursed) {
			if (curseStatus == DynamicItems.HIDDEN_CURSED) {
				if (EngineCore.silly()) {
					outputText("A horrible chill runs down your spine - <b>this weapon is cursed!</b> ")
				} else {
					outputText("You feel a nasty zap in your hand and realize you cannot let go of the weapon - <b>it is cursed!</b> ")
				}
			} else {
				outputText("<b>You cannot unequip it</b>. ")
			}
		}
		if (!identified) {
			if (effects.length > 0) {
				// This should be in sync with playerEquip
				outputText("You discover it to be " + identifiedCopy().longName + ". ");
			} else {
				outputText("It is not cursed. ");
			}
		}
	}
	
	override public function playerEquip():Weapon {
		if (!identified) {
			return (identifiedCopy() as Weapon).playerEquip();
		}
		for each (var e:Enchantment in effects) {
			e.onEquip(game.player, this);
		}
		return super.playerEquip();
	}
	
	
	override public function playerRemove():Weapon {
		for each (var e:Enchantment in effects) {
			e.onUnequip(game.player, this);
		}
		return super.playerRemove();
	}
	
	/**
	 * Key: subtype id
	 * Values:
	 * - name: displayed name
	 * - weight: chance to generate item of this category, default 1
	 * - shortName: for buttons. keep it VERY short
	 * - verb: used in attack texts, ex. "slash"
	 * - desc: description, can contain templates
	 * - type: Weapon class
	 * - (optional) perks: Weapon perks
	 * - attack: Base attack power
	 * - qattack: Attack-per-quality (0.25 = +25% per +1 qualiity)
	 * - value: Base cost in gems
	 */
	public static const Subtypes:Object = {
		"sword": {
			name: "sword",
			weight: 1,
			shortName: "swd",
			verb: "slash",
			desc: "A long sword made of the finest steel.",
			type: "Sword",
			attack: 10,
			qattack: 0.25,
			value: 200
		},
		"dagger": {
			name: "dagger",
			weight: 1,
			shortName: "dgr",
			verb: "stab",
			desc: "A small blade. Preferred weapon for the rogues.",
			perks: ["Small"],
			type: "Dagger",
			attack: 3,
			qattack: 0.25,
			value: 120
		}
	}
}
}
