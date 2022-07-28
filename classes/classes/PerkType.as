/**
 * Created by aimozg on 26.01.14.
 */
package classes
{
import classes.GlobalFlags.kFLAGS;
import classes.Stats.StatUtils;

import flash.utils.Dictionary;

public class PerkType extends BaseContent
	{
		private static var PERK_LIBRARY:Dictionary = new Dictionary();

		public static function lookupPerk(id:String):PerkType{
			return PERK_LIBRARY[id];
		}

		public static function getPerkLibrary():Dictionary
		{
			return PERK_LIBRARY;
		}
		
		private var _id:String;
		protected var _name:String;
		protected var _desc:String;
		protected var _longDesc:String;
		protected var _keepOnAscension:Boolean;
		public var buffs:Object;
		public var defaultValue1:Number = 0;
		public var defaultValue2:Number = 0;
		public var defaultValue3:Number = 0;
		public var defaultValue4:Number = 0;
		public var tierList:/*PerkType*/Array = null;
		

		public function tierPos():int {
			return tierList ? tierList.indexOf(this) : -1;
		}
		public function tierNext():PerkType {
			return tierList ? tierList[tierPos()+1] : null;
		}
		public function tierPrev():PerkType {
			return tierList ? tierList[tierPos()-1] : null;
		}

		/**
		 * Unique perk id, should be kept in future game versions
		 */
		public function get id():String
		{
			return _id;
		}

		/**
		 * Perk short name.
		 * If this is perk player has, `params` is not-null and has value1-4 properties
		 */
		public function name(params:PerkClass=null):String {
			return _name;
		}

		/**
		 * Short description used in perk listing
		 */
		public function desc(params:PerkClass=null):String
		{
			return _desc;
		}

		/**
		 * Long description used when offering perk at levelup
		 */
		public function get longDesc():String
		{
			return _longDesc;
		}

		public function keepOnAscension(respec:Boolean = false):Boolean
		{
			if (_keepOnAscension)
				return true;

			return _longDesc != _desc && !respec; // dirty condition
		}

		public function PerkType(id:String,name:String,desc:String,longDesc:String = null,keepOnAscension:Boolean = false)
		{
			this._id = id;
			this._name = name;
			this._desc = desc;
			this._longDesc = longDesc || _desc;
			this._keepOnAscension = keepOnAscension;
			if (PERK_LIBRARY[id] != null) {
				CoC_Settings.error("Duplicate perk id "+id+", old perk is "+(PERK_LIBRARY[id] as PerkType)._name);
			}
			PERK_LIBRARY[id] = this;
		}

		public function toString():String
		{
			return "\""+_name+"\"";
		}

		/**
		 * Array of:
		 * {
		 *   fn: (Player)=>Boolean,
		 *   text: String,
		 *   type: String
		 *   // additional depending on type
		 * }
		 */
		public var requirements:Array = [];

		public function available(player:Player):Boolean {
			for each (var c: Object in requirements) {
				if (!c.fn(player)) return false;
			}
			return true;
		}

		public function requireCustomFunction(playerToBoolean:Function, requirementText:String, internalType:String = "custom"):PerkType {
			requirements.push({
				fn  : playerToBoolean,
				text: requirementText,
				type: internalType
			});

			return this;
		}

		public function requireLevel(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("level", value),
				text: "Level " + value,
				type: "level",
				value: value
			});
			return this;
		}
		public function requireStr(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("str", value),
				text: "Strength " + value,
				type: "attr",
				attr: "str",
				value: value
			});
			return this;
		}
		public function requireTou(value:int):PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					// return true if player meets perk requirements
					var Attribute:String = "tou";
					if(player.hasPerk(PerkLib.IcyFlesh)) Attribute = "inte";
					if(player.hasPerk(PerkLib.HaltedVitals)) Attribute = "lib";
					return player[Attribute] >= value;
				},
				text: function(player:Player):String {
					// return true if player meets perk requirements
					var Attribute:String = "Toughness";
					if(player.hasPerk(PerkLib.IcyFlesh)) Attribute = "intelligence";
					if(player.hasPerk(PerkLib.HaltedVitals)) Attribute = "libido";
					return Attribute +" "+ value;
				},
				statictext: "Toughness "+value,
				type: "attr",
				attr: "tou",
				value: value
			});
			return this;
		}
		public function requireSpe(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("spe", value),
				text: "Speed " + value,
				type: "attr",
				attr: "spe",
				value: value
			});
			return this;
		}
		public function requireInt(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("inte", value),
				text: "Intellect " + value,
				type: "attr",
				attr: "inte",
				value: value
			});
			return this;
		}
		public function requireWis(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("wis", value),
				text: "Wisdom " + value,
				type: "attr",
				attr: "wis",
				value: value
			});
			return this;
		}
		public function requireLib(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("lib", value),
				text: "Libido " + value,
				type: "attr",
				attr: "lib",
				value: value
			});
			return this;
		}
		public function requireSen(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("sens", value),
				text: "Sensitivity " + value,
				type: "attr",
				attr: "sens",
				value: value
			});
			return this;
		}
		public function requireCor(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("cor", value),
				text: "Corruption " + value,
				type: "attr",
				attr: "cor",
				value: value
			});
			return this;
		}
		public function requireLibLessThan(value:int):PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.lib < value;
				},
				text: "Libido &lt; " + value,
				type: "attr-lt",
				attr: "lib",
				value: value
			});
			return this;
		}
		public function requireNGPlus(value:int):PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.newGamePlusMod() >= value;
				},
				text: "New Game+ " + value,
				type: "ng+",
				value: value
			});
			return this;
		}
		public function requireAdvancedJobSlot():PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.freeAdvancedJobsSlots() > 0;
				},
				text: "Free Advanced Job Slot",
				type: "advanced"
			});
			return this;
		}
		public function requireHiddenJobSlot():PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.freeHiddenJobsSlots() > 0;
				},
				text: "Free Hidden Job Slot",
				type: "hidden"
			});
			return this;
		}
		public function requirePrestigeJobSlot():PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.freePrestigeJobsSlots() > 0;
				},
				text: "Free Prestige Job Slot",
				type: "prestige"
			});
			return this;
		}
		public function requireMutationSlot(slot:String):PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.maxCurrentMutationsInSlot(slot) > 0;
				},
				text: "Free "+IMutationPerkType.Slots[slot].name+" Mutation Slot",
				type: "mutationslot",
				slot: slot
			});
			return this;
		}
		public function requireHeartMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_HEART);
		}
		public function requireMusclesMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_MUSCLE);
		}
		public function requireMouthMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_MOUTH);
		}
		public function requireAdrenalGlandsMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_ADRENALS);
		}
		public function requireBloodsteamMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_BLOODSTREAM);
		}
		public function requireFatTissueMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_FAT);
		}
		public function requireLungsMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_LUNGS);
		}
		public function requireMetabolismMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_METABOLISM);
		}
		public function requireOvariesMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_OVARIES);
		}
		public function requireBallsMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_TESTICLES);
		}
		public function requireEyesMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_EYES);
		}
		public function requirePeripheralNervSysMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_NERVSYS);
		}
		public function requireBonesAndMarrowMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_BONE);
		}
		public function requireThyroidGlandMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_THYROID);
		}
		public function requireParathyroidGlandMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_PARATHYROID);
		}
		public function requireAdaptationsMutationSlot():PerkType {
			return requireMutationSlot(IMutationPerkType.SLOT_ADAPTATIONS);
		}
		public function requireDragonMutationSlot():PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.maxDragonMutations() > 0;
				},
				text: "Free Dragon Mutation Slot",
				type: "dragonmutation"
			});
			return this;
		}
		public function requireKitsuneMutationSlot():PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.maxKitsuneMutations() > 0;
				},
				text: "Free Kitsune Mutation Slot",
				type: "kitsunemutation"
			});
			return this;
		}
		public function requireHungerEnabled():PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return CoC.instance.flags[kFLAGS.HUNGER_ENABLED] > 0;
				},
				text: "Hunger enabled",
				type: "hungerflag"
			});
			return this;
		}
		public function requireMinLust(value:int):PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return EngineCore.minLust() >= value;
				},
				text: "Min. Lust "+value,
				type: "minlust",
				value: value
			});
			return this;
		}
		public function requireMinSens(value:int):PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return CoC.instance.player.minSens() >= value;
				},
				text: "Min. Sensitivity "+value,
				type: "minsensitivity",
				value: value
			});
			return this;
		}
		public function requireMaxSoulforce(value:int):PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.maxSoulforce() >= value;
				},
				text: "Max. Soulforce "+value,
				type: "soulforce",
				value: value
			});
			return this;
		}
		public function requireMaxMana(value:int):PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.maxMana() >= value;
				},
				text: "Max. Mana "+value,
				type: "mana",
				value: value
			});
			return this;
		}
		public function requireMaxVenom(value:int):PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.maxVenom() >= value;
				},
				text: "Max. Venom/Web "+value,
				type: "venom_web",
				value: value
			});
			return this;
		}
		private function fnRequireAttr(attrname:String,value:int):Function {
			return function(player:Player):Boolean {
				return player[attrname] >= value;
			};
		}
		public function requireStatusEffect(effect:StatusEffectType, text:String):PerkType {
			requirements.push({
				fn  : function (player:Player):Boolean {
					return player.hasStatusEffect(effect);
				},
				text: text,
				type: "effect",
				effect: effect
			});
			return this;
		}
		
		/**
		 * Require player to be of specified race with optional minimum tier
		 * @example
		 * requireRace(Races.KITSUNE)
		 * -> name: "Kitsune race"
		 * -> fn: player.isRace(Races.KITSUNE, 1)
		 * @example
		 * requireRace(Races.KITSUNE, 3)
		 * -> name: "Nine-tailed kitsune of balance race"
		 * -> fn: player.isRace(Races.KITSUNE, 3)
		 */
		public function requireRace(race:Race, minTier:int=1):PerkType {
			var text:String;
			if (minTier == 1) {
				text = capitalizeFirstLetter(race.name)+" race";
			} else {
				text = capitalizeFirstLetter(race.tiers[minTier-1].name)+" race";
			}
			requirements.push({
				fn : function (player:Player):Boolean {
					return player.isRace(race, minTier);
				},
				text: text,
				type: "race",
				race: race,
				tier: minTier
			});
			return this;
		}
		
		/**
		 * Require player to be at tier 1+ in any of listed races.
		 * Consider using `requireRacialGroup` if too many races
		 * @param {Race[]} races
		 * @example
		 * requireAnyRace(Races.KITSUNE, Races.FOX)
		 * -> name: "Kitsune or Fox race"
		 * -> fn: player.isRace(Races.KITSUNE) || player.isRace(Races.FOX)
		 */
		public function requireAnyRace(...races):PerkType {
			return requireRacialGroup(races as Array);
		}
		/**
		 * Require player to be at tier 1+ in any of listed races.
		 * Can provide a custom name for this requirement
		 * @example
		 * requireRacialGroup([Races.KITSUNE, Races.FOX], "Any vulpine race")
		 * -> name: "Any vulpine race"
		 * -> fn: player.isRace(Races.KITSUNE) || player.isRace(Races.FOX)
		 */
		public function requireRacialGroup(races:/*Race*/Array, text:String =""):PerkType {
			races = flatten(races);
			if (!text) text = mergeSentences(mapOneProp(races,"name"),", or ",", ",false)+" race";
			requirements.push({
				fn : function (player:Player):Boolean {
					for each (var race:Race in races) {
						if (player.isRace(race)) return true;
					}
					return false;
				},
				text: text,
				type: "anyrace",
				races: races
			});
			return this;
		}
		public function requirePerk(perk:PerkType):PerkType {
			requirements.push({
				fn  : function (player:Player):Boolean {
					return player.hasPerk(perk);
				},
				text: perk.name(),
				type: "perk",
				perk: perk
			});
			return this;
		}
		public function requireAnyPerk(...perks:Array):PerkType {
			if (perks.length == 0) throw ("Incorrect call of requireAnyPerk() - should NOT be empty");
			var text:Array = [];
			for each (var perk:PerkType in perks) {
				text.push(perk.name());
			}
			requirements.push({
				fn  : function (player:Player):Boolean {
					for each (var perk:PerkType in perks) {
						if (player.hasPerk(perk)) return true;
					}
					return false;
				},
				text: text.join(" or "),
				type: "anyperk",
				perks: perks
			});
			return this;
		}
		public function requirePerks(...perks:Array):PerkType {	//As opposed to requirePerk or requireAnyPerk, this checks for if player has all required perks instead of any of them or just the one.
			if (perks.length == 0) throw ("Incorrect call of requirePerks() - should NOT be empty");
			var text:Array = [];
			for each (var perk:PerkType in perks) {
				text.push(perk.name());
			}
			requirements.push({
				fn  : function (player:Player):Boolean {
					var allPerksYes:Boolean = true;
					for each (var perk:PerkType in perks) {
						if (!player.hasPerk(perk)) {
							allPerksYes = false;
							break;
						}
					}
					return allPerksYes;
				},
				text: text.join(" and "),
				type: "allperks",
				allperks: perks
			});
			return this;
		}

		public function withBuffs(buffs:Object, showText:Boolean = true):PerkType {
			this.buffs = buffs;
			var tempText:String = "";
			if(showText) {
				var key:String;
				for (key in this.buffs) {
					StatUtils.validateBuff(key, "perk "+this.id);
					tempText += " " + StatUtils.explainBuff(key, buffs[key]) + ",";
				}
				tempText = tempText.slice(0, tempText.length - 1) + "."
				_desc += tempText;
				_longDesc += tempText;
			}
			return this;
		}

		public function requireMutation(mutation:IMutationPerkType):PerkType {
			requirements.push({
				fn  : function (player:Player):Boolean {
					return player.hasMutation(mutation);
				},
				text: mutation.name(),
				type: "mutation",
				perk: mutation
			});
			return this;
		}

		public function mDesc(params:PerkClass, tier:int = 0):String	//Can't overload the function, and override won't do it.
		{
			return _desc;
		}
	}
}
