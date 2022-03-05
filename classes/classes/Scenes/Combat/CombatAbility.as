package classes.Scenes.Combat {
import classes.Monster;
import classes.internals.EnumValue;

import coc.view.ButtonData;

/**
 * A combat ability invokable by player (spell, special, skill, etc).
 *
 * Handles checks for usability/knowledge, resource checks and usage, actual effect.
 *
 * Abilities are categorized with:
 * - **Category&Type** - Spells (and their sub-types), soulskills, physical and magical specials and so on.
 * - **Target type** - Target self or enemy. Used in monster reactions, or to disable ability targeting invisible monster.
 * - **Timing type** - Duration of the ability:<ul>
 *     <li> Instant (happens immediately), </li>
 *     <li> Lasting (started and lasts for some time and cannot be cast multiple times),</li>
 *     <li> Toggle (lasting that could be toggle off by player). </li>
 * - **Tags** - A set of extra flags (damaging or buffing, primary element, AoE and others) that could be used in checks, reactions, or modifiers
 *
 * Subclasses MUST implement:
 * - `category`
 * - `isKnown` (check if player knows the ability)
 * - `doEffect` (actual ability effect. For spells, override `doSpellEffect` instead)
 *
 * and COULD implement:
 * - `usabilityCheck` (check is ability is usable and return reason text if not)
 * - `useResources` (use mana and other resources. Some subclasses can handle it themselves)
 * - `calcCooldown` (cooldown between uses)
 * - any resource cost and description generating functions
 *
 * Lasting (and toggle) abilities MUST implement:
 * - `isActive`
 * and COULD implement:
 * - `advance` - called every turn
 * - `isStackable` to allow casting ability while it's active
 *
 * Toggle abilities MUST implement:
 * - `toggleOff`
 *
 * See subclasses for further info.
 */
public class CombatAbility extends BaseCombatContent {
	/**
	 * Array of all abilities.
	 */
	public static var Registry:/*CombatAbility*/Array = [];
	private static var idCounter:int = 0;
	
	/**
	 * This ability targets player only.
	 */
	public static const TARGET_SELF:int = 0;
	/**
	 * This ability targets enemy (or player and enemy).
	 */
	public static const TARGET_ENEMY:int = 1;
	
	/**
	 * This ability is executed instantly.
	 * OR it is a lasting/toggle ability not using default mechanism.
	 */
	public static const TIMING_INSTANT:int = 0;
	/**
	 * This ability adds an unstackable lasting effect.
	 * Stacked lasting abilities go under TIMING_INSTANT type.
	 */
	public static const TIMING_LASTING:int = 1;
	/**
	 * This ability adds an unstackable lasting effect that could be toggled off by caster
	 */
	public static const TIMING_TOGGLE:int = 2;
	// TODO @aimozg Channeling (precast) timing type
	// TODO @aimozg Reactive (cast automatically on some condition) timing type?
	
	public static const AllCategories:/*EnumValue*/Array = [];
	
	public static const CAT_UNIVERSAL:int        = EnumValue.add(AllCategories, 0, "UNIVERSAL", {
		name:"Universal",
		group:"general"
	});
	public static const CAT_PHYSICAL_SPECIAL:int = EnumValue.add(AllCategories, 1, "PHYSICAL_SPECIAL", {
		name:"Physical Special",
		group:"special"
	});
	public static const CAT_MAGICAL_SPECIAL:int  = EnumValue.add(AllCategories, 2, "MAGICAL_SPECIAL", {
		name:"Magical Special",
		group:"special"
	});
	public static const CAT_SOULSKILL:int   = EnumValue.add(AllCategories, 3, "SOULSKILL", {
		name:"Soulskill",
		group:"spell"
	});
	public static const CAT_SPELL_WHITE:int = EnumValue.add(AllCategories, 4, "SPELL_WHITE", {
		name:"White Spell",
		group:"spell"
	});
	public static const CAT_SPELL_BLACK:int     = EnumValue.add(AllCategories, 5, "SPELL_BLACK", {
		name:"Black Spell",
		group:"spell"
	});
	public static const CAT_SPELL_GREY:int = EnumValue.add(AllCategories, 6, "SPELL_GREY", {
		name:"Grey Spell",
		group:"spell"
	});
	public static const CAT_SPELL_HEX:int = EnumValue.add(AllCategories, 7, "SPELL_HEX", {
		name:"Hex",
		group:"spell"
	});
	public static const CAT_SPELL_NECRO:int = EnumValue.add(AllCategories, 8, "SPELL_NECRO", {
		name:"Necromancy Spell",
		group:"spell"
	});
	public static const CAT_SPELL_BLOOD:int = EnumValue.add(AllCategories, 9, "SPELL_BLOOD", {
		name:"Blood Spell",
		group:"spell"
	});
	public static const CAT_SPELL_DIVINE:int = EnumValue.add(AllCategories, 10, "SPELL_DIVINE", {
		name:"Divine Spell",
		group:"spell"
	});
	
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
		desc: 'This ability has area-of-effect. x5 damage to groups.'
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
	public static const TAG_HEALING:int = EnumValue.add(AllTags, 8, 'HEALING', {
		name: 'Healing',
		desc: "This ability heals player."
	});
	public static const TAG_RECOVERY:int = EnumValue.add(AllTags, 9, 'RECOVERY', {
		name: 'Recovery',
		desc: "This ability recovers player's stats (other than HP) and statuses."
	});
	public static const TAG_LUSTDMG:int = EnumValue.add(AllTags, 10, 'LUSTDMG', {
		name: 'Arousing',
		desc: "This ability deals lust damage."
	});
	public static const TAG_WATER:int = EnumValue.add(AllTags, 11, 'WATER', {
		name: 'Water',
		desc: "This ability primary element is Water"
	});
	public static const TAG_WIND:int = EnumValue.add(AllTags, 12, 'WIND', {
		name: 'Wind',
		desc: "This ability primary element is Wind"
	});
	public static const TAG_EARTH:int = EnumValue.add(AllTags, 13, 'EARTH', {
		name: 'Earth',
		desc: "This ability primary element is Earth"
	});
	public static const TAG_ACID:int = EnumValue.add(AllTags, 14, 'ACID', {
		name: 'Acid',
		desc: "This ability primary element is Acid"
	});
	
	/**
	 * Unique id of this ability.
	 */
	public var id:int;
	private var _name:String;
	private var _desc:String;
	public var targetType:int;
	public var timingType:int;
	private var _tags:/*Boolean*/Array;
	public var baseManaCost:Number = 0;
	public var baseWrathCost:Number = 0;
	
	public function CombatAbility(
			name:String,
			desc:String,
			targetType:int,
			timingType:int,
			tags:/*int*/Array
	) {
		this.id = ++idCounter;
		Registry[this.id] = this;
		this._name = name;
		this._desc = desc;
		this.targetType = targetType;
		this.timingType = timingType;
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
	
	public function get buttonName():String {
		return (timingType == TIMING_TOGGLE && isActive()) ? "Deactivate "+name : name;
	}
	
	public function get category():int {
		throw new Error("Method category() is not implemented for ability "+name);
	}
	
	public function get catObject():Object {
		return AllCategories[category];
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
	
	/**
	 * (For lasting/toggle abilities) Return true if ability is active.
	 */
	public function isActive():Boolean {
		if (timingType == TIMING_INSTANT) return false;
		throw new Error("Method isActive() is not implemented for ability "+name+", or it's timing type is incorrect");
	}
	
	/**
	 * (For lasting abilities) Return true if ability can be casted while it's still active
	 */
	public function isStackable():Boolean {
		return false;
	}
	
	/**
	 * (For lasting/toggle abilities)
	 * Called every round if ability is active. Reduce duration, do regular effect and such.
	 * @param display Print the effect
	 */
	public function advance(display:Boolean):void {
		/* do nothing */
	}
	
	/**
	 * @return {String[]} Array of strings like "Mana Cost: 50", "Cooldown: 10"
	 */
	public function costDescription():/*String*/Array {
		var costs:/*String*/Array = [];
		if (manaCost() > 0) {
			costs.push("Mana Cost: " + manaCost());
		}
		if (wrathCost() > 0) {
			costs.push("Wrath Cost: " + wrathCost());
		}
		if (hpCost() > 0) {
			costs.push("HP Cost: " + hpCost());
		}
		var cd:int = calcCooldown();
		if (cd > 0) {
			costs.push("Cooldown: "+cd);
		}
		return costs;
	}
	
	/**
	 * @param target Monster to gauge effect against, or null if viewing outside combat.
	 * @return {String} Ability description + costs, tags, and effects.
	 */
	public function fullDescription(target:Monster):String {
		var fullDesc:String = "";
		if (timingType == TIMING_TOGGLE && isActive()) {
			fullDesc += "<b>Deactivate "+name+"</b>\n";
		}
		fullDesc += description + "\n";
		
		var effectDesc:String = describeEffectVs(target);
		if (effectDesc) fullDesc += "\n<b>Effect: "+effectDesc+"</b>";
		
		var costs:/*String*/Array = costDescription();
		if (costs.length > 0) fullDesc += "\n<b>" + costs.join(", ")+"</b>";
		
		var tags:/*int*/Array = presentTags();
		if (tags.length > 0) {
			fullDesc += "\nTags: " + tags.map(function(tag:int,index:int,array:Array):String {
				return AllTags[tag].name;
			}).join(", ");
		}
		
		return fullDesc
	}
	
	/**
	 * Create a button in the abilities menu to invoke the ability.
	 * If ability is not usable at the moment, button will be disabled.
	 * Adds a tooltip with description, costs and predicted effect.
	 * DOES NOT check for isKnown.
	 */
	public function createButton(target:Monster):ButtonData {
		const bd:ButtonData = new ButtonData(buttonName, buttonCallback);
		
		var fullDesc: String = fullDescription(target);
		
		var ucheck:String;
		var deactivating:Boolean;
		if (deactivating) {
			ucheck = toggleOffUsabilityCheck();
		} else {
			ucheck = usabilityCheck();
		}
		if (ucheck != "") {
			fullDesc = "<b>"+ucheck + "</b>\n\n" + fullDesc;
			bd.disable()
		}
		
		bd.hint(fullDesc,deactivating ? "Deactivate " + name : name);
		return bd;
	}
	
	/**
	 * True if player knows this ability. Should be implemented in subclasses
	 */
	public function get isKnown():Boolean {
		throw new Error("Method isKnown() not implemented for ability "+name);
	}
	
	/**
	 * True if this ability can be invoked right now
	 */
	public function get isUsable():Boolean {
		return usabilityCheck() == "";
	}
	
	public function get isKnownAndUsable():Boolean {
		return isKnown && isUsable;
	}
	
	public function buttonCallback():void {
		combat.callbackBeforeAbility(this);
		if (timingType == TIMING_TOGGLE && isActive()) {
			toggleOff();
		} else {
			perform();
		}
		combat.callbackAfterAbility(this);
	}
	
	/**
	 * Invoke this ability. Takes resources,
	 * DOES NOT check for isKnown or isUsable.
	 * DOES NOT clear output or proceed the enemy turn.
	 * @param output Print texts
	 * @param free Do not use resources or set cooldown
	 * @param interceptable Can be intercepted by monster
	 */
	public function perform(output:Boolean=true,free:Boolean=false,interceptable:Boolean=true):void {
		if (!free) {
			setCooldown();
			useResources();
		}
		if (!interceptable || !monster.interceptPlayerAbility(this)) {
			doEffect(output);
			monster.postPlayerAbility(this);
		}
	}
	
	public function toggleOff(display:Boolean=true):void {
		if (timingType == TIMING_TOGGLE) {
			throw new Error("Cannot deactivate non-toggle ability "+name);
		}
		throw new Error("Method deactivate() not implemented for ability "+name);
	}
	
	public function ensureToggledOff(display:Boolean=true):void {
		if (timingType == TIMING_TOGGLE && isActive()) toggleOff(display);
	}
	
	// "Use ablity" = setCooldown() + useResources() + doEffect()
	
	public function setCooldown():void {
		player.cooldowns[id] = calcCooldown();
	}
	
	/**
	 * Use mana, increment counters etc. At this point ability still might fail or be intercepted by monster
	 */
	public function useResources():void {
		/* do nothing */
	}
	
	/**
	 * 2nd part: actual ability effect.
	 * Can be used instead of perform to skip resource usage, cooldown, or monster interception
	 */
	public function doEffect(display:Boolean = true):void {
		throw new Error("Method doEffect() not implemented for ability "+name);
	}
	
	public function manaCost():Number {
		return baseManaCost;
	}
	
	public function wrathCost():Number {
		return baseWrathCost;
	}
	
	public function hpCost():Number {
		return 0;
	}
	
	/**
	 * Current cooldown (number of rounds left before it could be used again)
	 */
	public function get currentCooldown():int {
		return player.cooldowns[id];
	}
	
	/**
	 * Calculate cooldown of this ability. Default is 0 (no cooldown).
	 * Will be applied automatically.
	 */
	public function calcCooldown():int {
		return 0;
	}
	
	/**
	 * @return {String} "" is this ability is usable, otherwise reason why it's not
	 */
	protected function usabilityCheck():String {
		// Checks applicable to all abilities could go here
		if (timingType == TIMING_LASTING && !isStackable() && isActive()) {
			return "This ability is already active."
		}
		var ccd:int = currentCooldown;
		if (ccd > 0) {
			return "You need to wait "+numberOfThings(ccd, "more round")+" before you can use this ability again."
		}
		return ""
	}
	
	/**
	 * Assuming this is an active toggle ability, check if it could be toggled off by player.
	 * @return {String} "" if ability can be toggled off, otherwise reason why it couldn't
	 */
	protected function toggleOffUsabilityCheck():String {
		return "";
	}
}
}
