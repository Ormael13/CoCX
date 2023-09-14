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
		
		// Perk distance values
		// "Distance" is how far perk requirements are from the starting player.
		public static const DISTANCE_STARTING: Number = 10; // all perks start with 10
		public static const DISTANCE_DEFAULT: Number = 10; // custom requirement default distance
		public static const DISTANCE_PER_LEVEL: Number = 10;
		public static const DISTANCE_PER_PERK: Number = 10; // 1 perk = 1 level
		public static const DISTANCE_PER_NG: Number = 1000; // 1 NG+ = 100 levels
		public static const DISTANCE_PER_PRIMARY_STAT: Number = 1; // 10 stat = 1 level
		public static const DISTANCE_PER_SENS: Number = 0.5; // 20 sens = 1 level
		public static const DISTANCE_PER_COR: Number = 0.5; // 20 cor = 1 level
		public static const DISTANCE_PER_MINLUST: Number = 0.25; // 40 minlust = 1 level
		public static const DISTANCE_PER_MAXMANA: Number = 0.25; // 40 maxmana = 1 level
		public static const DISTANCE_PER_MAXVENOM: Number = 0.25; // 40 maxvenom = 1 level
		public static const DISTANCE_PER_RACIAL_TIER: Number = 60.0; // 1 racial tier = 6 levels
		public static const DISTANCE_ADVANCED_JOB_SLOT: Number = 100.0; // 1 adv job slot = 10 levels
		public static const DISTANCE_HIDDEN_JOB_SLOT: Number = 200.0; // 1 hidden job slot = 20 levels
		public static const DISTANCE_PRESTIGE_JOB_SLOT: Number = 300.0; // 1 prestige job slot = 30 levels
		public static const DISTANCE_MUTATION_SLOT: Number = 100.0; // 1 mutation slot = 10 levels

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
		 *   type: String,
		 *   distance: Number,
		 *   distanceFor: (Player)=>Number,
		 *   // additional depending on type
		 * }
		 */
		public var requirements:Array = [];
		/**
		 * Absolute distance - how "far" is that perk in the progression.
		 */
		public var distance:Number = 0;
		
		/**
		 * Computes relative distance - how "far" is specific player to obtain that perk.
		 * 0 = player has perk.
		 * DISTANCE_STARTING = player doesn't have the perk, but all requirements are passed
		 */
		public function distanceFor(player:Player):Number {
			if (player.hasPerk(this)) return 0;
			var d:Number = DISTANCE_STARTING;
			for each (var req:Object in requirements) {
				// skip if player passes the requirement
				if (req.fn(player)) continue;
				var x:Number;
				if (req.distanceFor is Function) {
					x = Math.max(0, req.distanceFor(player));
				} else if (req.distance is Number && isFinite(req.distance) && req.distance > 0) {
					x = req.distance;
				}
				if (req.type == 'allperks') {
					x += req.allperks.length*PerkType.DISTANCE_PER_PERK;
					d = Math.max(d, x);
				} else if (req.type == 'perk' || req.type == 'anyperk') {
					x += PerkType.DISTANCE_PER_PERK;
					d = Math.max(d, x);
				} else {
					d += x;
				}
			}
			return d;
		}

		public function available(player:Player):Boolean {
			for each (var c: Object in requirements) {
				if (!c.fn(player)) return false;
			}
			return true;
		}

		public function requireCustomFunction(playerToBoolean:Function, requirementText:String, distance:Number = DISTANCE_DEFAULT, internalType:String = "custom"):PerkType {
			requirements.push({
				fn      : playerToBoolean,
				text    : requirementText,
				type    : internalType,
				distance: distance
			});

			return this;
		}

		public function requireLevel(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("level", value),
				text: "Level " + value,
				type: "level",
				value: value,
				distance: value*DISTANCE_PER_LEVEL,
				distanceFor: fnDistanceAttr("level", value, DISTANCE_PER_LEVEL)
			});
			return this;
		}
		public function requireStr(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("str", value),
				text: "Strength " + value,
				type: "attr",
				attr: "str",
				value: value,
				distance: Math.max(1,value*DISTANCE_PER_PRIMARY_STAT),
				distanceFor: fnDistanceAttr("str", value, DISTANCE_PER_PRIMARY_STAT)
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
					if(player.hasPerk(PerkLib.IcyFlesh)) Attribute = "Intelligence";
					if(player.hasPerk(PerkLib.HaltedVitals)) Attribute = "Libido";
					return Attribute +" "+ value;
				},
				statictext: "Toughness "+value,
				type: "attr",
				attr: "tou",
				value: value,
				distance: Math.max(1,value*DISTANCE_PER_PRIMARY_STAT),
				distanceFor: function(player:Player):Number {
					var Attribute:String = "tou";
					if(player.hasPerk(PerkLib.IcyFlesh)) Attribute = "inte";
					if(player.hasPerk(PerkLib.HaltedVitals)) Attribute = "lib";
					return (value-player[Attribute])*DISTANCE_PER_PRIMARY_STAT
				}
			});
			return this;
		}
		public function requireSpe(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("spe", value),
				text: "Speed " + value,
				type: "attr",
				attr: "spe",
				value: value,
				distance: Math.max(1,value*DISTANCE_PER_PRIMARY_STAT),
				distanceFor: fnDistanceAttr("spe", value, DISTANCE_PER_PRIMARY_STAT)
			});
			return this;
		}
		public function requireInt(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("inte", value),
				text: "Intellect " + value,
				type: "attr",
				attr: "inte",
				value: value,
				distance: Math.max(1,value*DISTANCE_PER_PRIMARY_STAT),
				distanceFor: fnDistanceAttr("inte", value, DISTANCE_PER_PRIMARY_STAT)
			});
			return this;
		}
		public function requireWis(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("wis", value),
				text: "Wisdom " + value,
				type: "attr",
				attr: "wis",
				value: value,
				distance: Math.max(1,value*DISTANCE_PER_PRIMARY_STAT),
				distanceFor: fnDistanceAttr("wis", value, DISTANCE_PER_PRIMARY_STAT)
			});
			return this;
		}
		public function requireLib(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("lib", value),
				text: "Libido " + value,
				type: "attr",
				attr: "lib",
				value: value,
				distance: Math.max(1,value*DISTANCE_PER_PRIMARY_STAT),
				distanceFor: fnDistanceAttr("lib", value, DISTANCE_PER_PRIMARY_STAT)
			});
			return this;
		}
		public function requireSen(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("sens", value),
				text: "Sensitivity " + value,
				type: "attr",
				attr: "sens",
				value: value,
				distance: value*DISTANCE_PER_SENS,
				distanceFor: fnDistanceAttr("sens", value, DISTANCE_PER_SENS)
			});
			return this;
		}
		public function requireCor(value:int):PerkType {
			requirements.push({
				fn  : fnRequireAttr("cor", value),
				text: "Corruption " + value,
				type: "attr",
				attr: "cor",
				value: value,
				distance: value*DISTANCE_PER_COR,
				distanceFor: fnDistanceAttr("cor", value, DISTANCE_PER_COR)
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
				value: value,
				distance: value*DISTANCE_PER_PRIMARY_STAT,
				distanceFor: fnDistanceAttr("lib", value, -DISTANCE_PER_PRIMARY_STAT)
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
				value: value,
				distance: value*DISTANCE_PER_NG,
				distanceFor: fnDistanceAttr("newGamePlusMod", value, DISTANCE_PER_NG)
			});
			return this;
		}
		public function requireAdvancedJobSlot():PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.freeAdvancedJobsSlots() > 0;
				},
				text: "Free Advanced Job Slot",
				type: "advanced",
				distance: DISTANCE_ADVANCED_JOB_SLOT
			});
			return this;
		}
		public function requireHiddenJobSlot():PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.freeHiddenJobsSlots() > 0;
				},
				text: "Free Hidden Job Slot",
				type: "hidden",
				distance: DISTANCE_HIDDEN_JOB_SLOT
			});
			return this;
		}
		public function requirePrestigeJobSlot():PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return player.freePrestigeJobsSlots() > 0;
				},
				text: "Free Prestige Job Slot",
				type: "prestige",
				distance: DISTANCE_PRESTIGE_JOB_SLOT
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
				slot: slot,
				distance: DISTANCE_MUTATION_SLOT
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
		public function requireHungerEnabled():PerkType {
			requirements.push({
				fn  : function(player:Player):Boolean {
					return CoC.instance.flags[kFLAGS.HUNGER_ENABLED] > 0;
				},
				text: "Hunger enabled",
				type: "hungerflag",
				distance: DISTANCE_DEFAULT
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
				value: value,
				distance: value*DISTANCE_PER_MINLUST,
				distanceFor: fnDistanceAttr("minLust", value, DISTANCE_PER_MINLUST)
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
				value: value,
				distance: DISTANCE_DEFAULT
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
				value: value,
				distance: DISTANCE_DEFAULT
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
				value: value,
				distance: value*DISTANCE_PER_MAXMANA,
				distanceFor: fnDistanceAttr("maxMana", value, DISTANCE_PER_MAXMANA)
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
				value: value,
				distance: value*DISTANCE_PER_MAXVENOM,
				distanceFor: fnDistanceAttr("maxVenom", value, DISTANCE_PER_MAXMANA)
			});
			return this;
		}
		private function fnRequireAttr(attrname:String,value:int):Function {
			return function(player:Player):Boolean {
				return player[attrname] >= value;
			};
		}
		
		/**
		 * Create a relative distance computing function that returns a score for player's property "attrname"
		 * distance to "target" value.
		 * For example, fnDistanceAttr("str", 60, 0.5) creates a function that counts 0.5 per player strength below 60.
		 * If property goes down, for example "corruption no more than 50", multiply scale by -1.
		 * @param attrname Player property name. Should be a number or no-arg function returning number
		 * @param target Target value.
		 * @param scale Score per 1 of difference
		 * @return {(Player)=>Number} distance function
		 */
		private function fnDistanceAttr(attrname:String,target:Number,scale:Number):Function {
			return function(player:Player):Number {
				var attr:* = player[attrname];
				if (attr is Function) attr = attr();
				return (target - attr) * scale;
			}
		}
		public function requireStatusEffect(effect:StatusEffectType, text:String, distance:Number = DISTANCE_DEFAULT):PerkType {
			requirements.push({
				fn  : function (player:Player):Boolean {
					return player.hasStatusEffect(effect);
				},
				text: text,
				type: "effect",
				effect: effect,
				distance: distance
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
				tier: minTier,
				distance: minTier*DISTANCE_PER_RACIAL_TIER,
				distanceFor: function(player:Player):Number {
					return (minTier - player.racialTier(race)) * DISTANCE_PER_RACIAL_TIER;
				}
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
				races: races,
				distance: DISTANCE_PER_RACIAL_TIER
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
				perk: perk,
				// distance is computed in PerkTree
				distanceFor: function(player:Player):Number {
					return perk.distanceFor(player);
				}
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
				perks: perks,
				// distance is computed in PerkTree
				distanceFor: function(player:Player):Number {
					var mindist:Number = Infinity;
					for each(var perk:PerkType in perks) {
						mindist = Math.min(mindist, perk.distanceFor(player));
					}
					return DISTANCE_PER_PERK + (isFinite(mindist) ? mindist : 0);
				}
			});
			return this;
		}
		public function requireOrPerks(perk1:PerkType, perk2:PerkType, v1:Number):PerkType {
			requirements.push({
				fn  : function (player:Player):Boolean {
					return (player.hasPerk(perk1) || (player.hasPerk(perk2) && player.perkv1(perk2) == v1));
				},
				text: perk1.name(),
				type: "perk",
				perk: perk1,
				// distance is computed in PerkTree
				distanceFor: function(player:Player):Number {
					return perk1.distanceFor(player);
				}
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
				allperks: perks,
				// distance is computed in PerkTree
				distanceFor: function(player:Player):Number {
					var maxdist:Number = -Infinity;
					for each(var perk:PerkType in perks) {
						maxdist = Math.max(maxdist, perk.distanceFor(player));
					}
					return DISTANCE_PER_PERK*perks.length + (isFinite(maxdist) ? maxdist : 0);
				}
			});
			return this;
		}
		public function requireNotThosePerks(...perks:Array):PerkType {
			if (perks.length == 0) throw ("Incorrect call of requireNotThosePerk() - should NOT be empty");
			var text:Array = [];
			for each (var perk:PerkType in perks) {
				text.push(perk.name());
			}
			requirements.push({
				fn  : function (player:Player):Boolean {
                    var allPerksYes:Boolean = true;
                    for each (var perk:PerkType in perks) {
                        if (player.hasPerk(perk)) {
                            allPerksYes = false;
                            break;
                        }
                    }
                    return allPerksYes;
                },
				text: "Blocked by " + (text.length>1?"perks: ":"perk ") + text.join(", "),
				type: "noperks",
				perks: perks
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
				perk: mutation,
				distance: DISTANCE_PER_PERK,
				distanceFor: function(player:Player):Number {
					return mutation.distanceFor(player);
				}
			});
			return this;
		}

		public function mDesc(params:PerkClass, tier:int = 0):String	//Can't overload the function, and override won't do it.
		{
			return _desc;
		}
	}
}
