package classes.Scenes.Combat {
import classes.Monster;
import classes.internals.EnumValue;
import classes.internals.Utils;

import coc.view.ButtonData;

public class CombatAbility extends BaseCombatContent {
	
	public static const TARGET_SELF:int = 0;
	public static const TARGET_ENEMY:int = 1;
	
	public static const TIMING_INSTANT:int = 0;
	public static const TIMING_LASTING:int = 1;
	public static const TIMING_TOGGLE:int = 2;
	
	public static const AllCategories:/*EnumValue*/Array = [];
	
	public static const UNIVERSAL:int = EnumValue.add(AllCategories, 0, "UNIVERSAL", {name:"universal"});
	public static const PHYSICAL_SPECIAL:int = EnumValue.add(AllCategories, 1, "PHYSICAL_SPECIAL", {name:"physical special"});
	public static const MAGICAL_SPECIAL:int = EnumValue.add(AllCategories, 2, "MAGICAL_SPECIAL", {name:"magical special"});
	public static const SOULSKILL:int = EnumValue.add(AllCategories, 3, "SOULSKILL", {name:"soulskill"});
	public static const SPELL_WHITE:int = EnumValue.add(AllCategories, 4, "SPELL_WHITE", {name:"white spell"});
	public static const SPELL_BLACK:int = EnumValue.add(AllCategories, 5, "SPELL_BLACK", {name:"black spell"});
	public static const SPELL_GREY:int = EnumValue.add(AllCategories, 6, "SPELL_GREY", {name:"grey spell"});
	public static const SPELL_HEX:int = EnumValue.add(AllCategories, 7, "SPELL_HEX", {name:"hex"});
	public static const SPELL_NECRO:int = EnumValue.add(AllCategories, 8, "SPELL_NECRO", {name:"necromancy spell"});
	public static const SPELL_BLOOD:int = EnumValue.add(AllCategories, 9, "SPELL_BLOOD", {name:"blood spell"});
	
	public static var AllTags:/*EnumValue*/Array = [];
	public static const TAG_DAMAGING:int = EnumValue.add(AllTags, 0, 'DAMAGING', {
		name: 'Damaging',
		desc: 'This ability deals damage.'
	});
	public static const TAG_BUFF:int = EnumValue.add(AllTags, 1, 'BUFF', {
		name: 'Buff',
		desc: 'This ability increases stats or otherwise buffs target.'
	});
	public static const TAG_DEBUFF:int = EnumValue.add(AllTags, 2, 'DEBUFF', {
		name: 'Debuff',
		desc: 'This ability decreases stats or otherwise debuffs target.'
	});
	public static const TAG_AOE:int = EnumValue.add(AllTags, 3, 'AOE', {
		name: 'AoE',
		desc: 'This ability has area-of-effect.'
	});
	public static const TAG_FIRE:int = EnumValue.add(AllTags, 4, 'FIRE', {
		name: 'Fire',
		desc: "This ability primary element is Fire"
	});
	public static const TAG_LIGHTNING:int = EnumValue.add(AllTags, 5, 'LIGHTNING', {
		name: 'Lightning',
		desc: "This ability primary element is Lightning"
	});
	public static const TAG_ICE:int = EnumValue.add(AllTags, 6, 'ICE', {
		name: 'Ice',
		desc: "This ability primary element is Ice"
	});
	public static const TAG_DARKNESS:int = EnumValue.add(AllTags, 7, 'DARKNESS', {
		name: 'Darkness',
		desc: "This ability primary element is Darkness"
	});
	
	private var _name:String;
	private var _desc:String;
	private var _targetType:int;
	private var _tags:/*Boolean*/Array;
	public var baseManaCost:Number = 0;
	public var baseWrathCost:Number = 0;
	
	public function CombatAbility(name:String,desc:String,targetType:int,tags:/*int*/Array) {
		this._name = name;
		this._desc = desc;
		this._targetType = targetType;
		this._tags = [];
		for (var tag:int=0; tag<AllTags.length; tag++) {
			this._tags[tag] = tags.indexOf(tag) >= 0;
		}
	}
	
	public function get name():String {
		return _name;
	}
	
	public function get description():String {
		return _desc
	}
	
	public function get targetType():int {
		return _targetType
	}
	
	public function get buttonName():String {
		return name;
	}
	
	public function presentTags():/*int*/Array {
		var result:/*int*/Array = [];
		for (var tag:int=0; tag<_tags.length; tag++) {
			if (_tags[tag]) result.push(tag);
		}
		return result;
	}
	
	public function hasTag(tag:int):Boolean {
		return _tags[tag];
	}
	
	/**
	 * Describe effect (for example, approximate damage).
	 * @param target Current target, or null if describing outside combat
	 * @return
	 */
	public function describeEffectVs(target:Monster):String {
		return "";
	}
	
	public function createButton(target:Monster):ButtonData {
		const bd:ButtonData = new ButtonData(buttonName, buttonCallback);
		var fullDesc:String = description+"\n";
		var effectDesc:String = describeEffectVs(target);
		if (effectDesc) fullDesc += "<b>Effect: "+effectDesc+"</b>\n";
		var tags:/*int*/Array = presentTags();
		if (tags.length > 0) {
			fullDesc += "\n<b>Tags: " + tags.map(function(tag:int,index:int,array:Array):String {
				return AllTags[tag].name;
			}).join(", ")+"</b>";
		}
		
		var costs:/*String*/Array = [];
		if (baseManaCost > 0) {
			costs.push("Mana Cost: " + manaCost());
		}
		if (baseWrathCost > 0) {
			costs.push("Wrath Cost: " + wrathCost());
		}
		if (costs.length > 0) fullDesc += "\n" + costs.join(", ");
		
		var ucheck:String = usabilityCheck();
		if (ucheck != "") {
			fullDesc = "<b>"+ucheck + "</b>\n\n" + fullDesc;
			bd.disable()
		}
		
		bd.hint(fullDesc,name);
		return bd;
	}
	
	public function get isKnown():Boolean {
		throw new Error("Method isKnown() not implemented for ability "+name);
	}
	
	public function get isUsable():Boolean {
		return usabilityCheck() == "";
	}
	
	public function buttonCallback():void {
		combat.callbackBeforeAbility(this);
		perform();
		combat.callbackAfterAbility(this);
	}
	
	public function perform():void {
		useResources();
		if (!monster.interceptPlayerAbility(this)) {
			doEffect();
			monster.postPlayerAbility(this);
		}
	}
	
	/**
	 * 1st part: use mana, set cooldown, increment counters etc.
	 */
	protected function useResources():void {
	
	}
	
	/**
	 * 2nd part: actual ability effect
	 */
	protected function doEffect():void {
		throw new Error("Method perform() not implemented for ability "+name);
	}
	
	public function manaCost():Number {
		return baseManaCost;
	}
	
	public function wrathCost():Number {
		return baseWrathCost;
	}
	
	public function get currentCooldown():int {
		return 0
	}
	
	/**
	 * @return String "" is this ability is usable, otherwise reason why it's not
	 */
	protected function usabilityCheck():String {
		// Checks applicable to all abilities could go here
		if (currentCooldown > 0) {
			return "You need more time before you can use this ability again."
		}
		return ""
	}
	
}
}
