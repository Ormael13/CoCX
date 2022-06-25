package classes.Items.Dynamic {
import classes.ItemType;
import classes.Items.Armor;
import classes.Items.DynamicItems;
import classes.Items.Enchantment;
import classes.Items.EnchantmentType;
import classes.Items.IDynamicItem;
import classes.Items.ItemTemplateLib;

public class DynamicArmor extends Armor implements IDynamicItem {
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
	
	public function DynamicArmor(id:String, params:Object) {
		var parsedParams:Object  = DynamicItems.loadCommonDynamicItemParams(params, Subtypes);
		_subtypeId               = parsedParams.subtypeId;
		_subtype                 = parsedParams.subtype || {};
		_quality                 = parsedParams.quality;
		_rarity                  = parsedParams.rarity;
		_curseStatus             = parsedParams.curseStatus;
		_cursed                  = parsedParams.cursed;
		_identified              = parsedParams.identified;
		_effects                 = parsedParams.effects;
		var shortName:String     = parsedParams.shortName;
		var name:String          = parsedParams.name;
		var longName:String      = parsedParams.longName;
		var desc:String          = parsedParams.desc;
		var value:Number         = parsedParams.value;
		var type:String          = subtype.type;
		var tags:Array           = (subtype.tags || []).slice();
		var def:Number           = subtype.def;
		var mdef:Number          = subtype.mdef;
		var qdef:Number          = numberOr(subtype.qdef, 0);
		var bulge:Boolean        = subtype.bulge;
		var undergarment:Boolean = subtype.undergarment;
		if (parsedParams.error) {
			trace("[ERROR] Failed to parse " + id + " with error " + parsedParams.error);
			name      = "ERROR " + name;
			shortName = "ERROR " + shortName;
			longName  = "ERROR " + longName;
			desc      = "INVALID ITEM:\n" + parsedParams.error + "\n" + desc;
		}
		
		def *= (1.0 + quality * qdef);
		mdef *= (1.0 + quality * qdef);
		
		super(
				id,
				shortName,
				name,
				longName,
				def,
				mdef,
				value,
				desc,
				type,
				bulge,
				undergarment
		)
		
		stackSize = 1;
		withTag.apply(this, tags);
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
		return ItemTemplateLib.instance.createArmor(
				valueOr(options.t, subtype),
				valueOr(options.r, rarity),
				valueOr(options.q, quality),
				valueOr(options.c, curseStatus),
				valueOr(options.e, effects)
		);
	}
	
	override public function useText():void {
		DynamicItems.equipText(this);
	}
	
	override public function playerEquip():Armor {
		if (!identified) {
			return (identifiedCopy() as Armor).playerEquip();
		}
		for each (var e:Enchantment in effects) {
			e.onEquip(game.player, this);
		}
		return super.playerEquip();
	}
	
	override public function playerRemove():Armor {
		for each (var e:Enchantment in effects) {
			e.onUnequip(game.player, this);
		}
		return super.playerRemove();
	}
	
	/**
	 * Key: subtype id
	 * Values:
	 * - chance: weight when generating random item of this category, default 1
	 * - name: displayed name
	 * - shortName: for buttons. keep it VERY short, 3-4 chars
	 * - TODO @aimozg longName?
	 * - desc: description, can contain templates
	 * - (optional) type: Armor type (AT_XXXX)
	 * - def: Base defense
	 * - mdef: Base magic defense
	 * - qdef: Defense-per-quality (0.25 = +25% per +1 qualiity)
	 * - value: Base cost in gems
	 * - bulge: Can be modded by Exgartuan (ugh). Default false
	 * - undergarment: Can be worn with undergarment. Default true
	 */
	public static const Subtypes:Object = {
		"clothes": {
			chance: 1,
			name: "comfortable clothes",
			shortName: "clth",
			desc: "These loose fitting and comfortable clothes allow you to move freely while protecting you from the elements.",
			type: AP_LIGHT,
			def: 0,
			mdef: 0,
			qdef: 0.25,
			value: 10
		},
		"fullchain": {
			chance: 1,
			name: "full-body chainmal",
			shortName: "fchm",
			desc: "This full suit of chainmail armor covers its wearer from head to toe in protective steel rings.",
			type: AP_MEDIUM,
			def: 8,
			mdef: 0,
			qdef: 0.25,
			value: 320
		},
		"fullplate": {
			chance: 0.5,
			name: "full platemail",
			shortName: "fplm",
			desc: "A highly protective suit of steel platemail.  It would be hard to find better physical protection than this.",
			type: AP_HEAVY,
			def: 21,
			mdef: 0,
			qdef: 0.25,
			value: 1260
		},
		"heavyleather": {
			chance: 1,
			name: "heavy leather armor",
			shortName: "hlth",
			desc: "Layers of cured animal hide to offer greater protection from damage.",
			type: AP_HEAVY,
			def: 10,
			mdef: 0,
			qdef: 0.25,
			value: 375
		},
		"leather": {
			chance: 1,
			name: "leather armor",
			shortName: "lthr",
			desc: "This is a suit of well-made leather armor.  It looks fairly rugged.",
			type: AP_LIGHT,
			def: 5,
			mdef: 0,
			qdef: 0.25,
			value: 100
		},
		"samurai": {
			chance: 0.5,
			name: "samurai armor",
			shortName: "samu",
			desc: "This suit of armor is originally worn by the Samurai, the warriors from the far East.",
			type: AP_HEAVY,
			def: 18,
			mdef: 0,
			qdef: 0.25,
			value: 300
		},
		"scalemail": {
			chance: 1,
			name: "scale-mail armor",
			shortName: "sclm",
			desc: "This suit of scale-mail covers the entire body with layered steel scales, providing flexibility and protection.",
			type: AP_HEAVY,
			def: 12,
			mdef: 0,
			qdef: 0.25,
			value: 820
		},
		"studdedleather": {
			chance: 1,
			name: "cured leather armor",
			shortName: "clth",
			desc: "A cured leather armor, it’s tough and can offer some modest protection while also allowing freedom of movement.",
			type: AP_LIGHT,
			def: 8,
			mdef: 0,
			qdef: 0.25,
			value: 250
		}
	}
}
}
