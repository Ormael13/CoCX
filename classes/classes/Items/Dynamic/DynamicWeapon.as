package classes.Items.Dynamic {
import classes.EngineCore;
import classes.Items.DynamicItems;
import classes.Items.Enchantment;
import classes.Items.EnchantmentType;
import classes.Items.ItemTemplateLib;
import classes.Items.Weapon;

public class DynamicWeapon extends Weapon {
	public var subtypeId:String;
	public var subtype:Object;
	public var quality:int;
	public var rarity:int;
	public var curseStatus:int;
	public var _cursed:Boolean;
	public var curseKnown:Boolean;
	public var identified:Boolean;
	public var effects:/*Enchantment*/Array;
	
	public override function get cursed():Boolean {
		return _cursed;
	}
	
	public function DynamicWeapon(id:String, params:Object) {
		var parsedParams:Object = DynamicItems.loadCommonDynamicItemParams(params, Subtypes);
		subtypeId               = parsedParams.subtypeId;
		subtype                 = parsedParams.subtype || {};
		quality                 = parsedParams.quality;
		rarity                  = parsedParams.rarity;
		curseStatus             = parsedParams.curseStatus;
		_cursed                 = parsedParams.cursed;
		curseKnown              = parsedParams.curseKnown;
		identified              = parsedParams.identified;
		effects                 = parsedParams.effects;
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
		
		attack += quality;
		
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
		)
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
	
	private var _identifiedCopy:DynamicWeapon;
	/**
	 * Returns fully identified copy of this weapon (this if it is already identified)
	 */
	public function identifiedCopy():DynamicWeapon {
		if (identified) return this;
		if (!_identifiedCopy) {
			var params:Object = templateParams();
			params.c |= DynamicItems.CS_KNOWN_MASK; // set known flag
			for each (var effect:Array in params.e) {
				effect[0] = 1; // set identified flag
			}
			var id:String = dynamicItemId(templateId(),params);
			_identifiedCopy = lookupItem(id) as DynamicWeapon;
		}
		return _identifiedCopy;
	}
	public function uncursedCopy():DynamicWeapon {
		if (!cursed) return this;
		var params:Object = templateParams();
		params.c = DynamicItems.KNOWN_UNCURSED;
		var id:String = dynamicItemId(templateId(),params);
		return lookupItem(id) as DynamicWeapon;
	}
	override public function useText():void {
		outputText("You equip " + longName + ".  ");
		if (cursed) {
			if (!curseKnown) {
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
			return identifiedCopy().playerEquip();
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
			value: 120
		}
	}
}
}
