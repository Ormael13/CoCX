package classes.Items.Dynamic.Effects {
import classes.EngineCore;
import classes.ItemType;
import classes.Items.Armor;
import classes.Items.Enchantment;
import classes.Items.EnchantmentLib;
import classes.Items.EnchantmentType;
import classes.Items.Equipable;
import classes.Items.IDynamicItem;
import classes.Items.Shield;
import classes.Items.Weapon;
import classes.Items.WeaponRange;
import classes.Player;
import classes.Race;
import classes.Races;
import classes.StatusEffectClass;
import classes.StatusEffects;
import classes.Transformations.PossibleEffect;
import classes.Transformations.TransformationUtils;

public class RaceTfEnchantmentType extends EnchantmentType {
	
	/**
	 * Element properties:
	 * - chance:Number, spawn weight, default 1
	 * - race:Race
	 * - tfs:Transformation[]
	 */
	private var RaceGen_field:Array = null;
	public function get RaceGen():Array {
		if (!RaceGen_field) RaceGen_field = [{
				chance: 1.0,
				race: Races.BEE,
				tfs: Races.BEE.TfList,
				tfPerm: false
			}, {
				chance: 1.0,
				race: Races.CAT,
				tfs: Races.CAT.TfList,
				tfPerm: false
			}, {
				chance: 1.0,
				race: Races.FOX,
				tfs: Races.FOX.TfList,
				tfPerm: false
			}, {
				chance: 1.0,
				race: Races.GOBLIN,
				tfs: Races.GOBLIN.TfList,
				tfPerm: false
			}, {
				chance: 0.5,
				race: Races.KITSUNE,
				tfs: Races.KITSUNE.TfList,
				tfPerm: false
			}, {
				chance: 0.1,
				race: Races.IMP,
				tfs: Races.IMP.TfList,
				tfPerm: false
			}];
		return RaceGen_field;
	}
	private static var instance:RaceTfEnchantmentType;
	
	public static function hoursBetweenTf(power:int):int {
		return Math.max(1, 30 - 6 * power);
	}
	
	public static function allEnchantedEquipment(race:Race):/*ItemType*/Array {
		return game.player.allEquipment().filter(varargify(function (it:ItemType):Boolean {
			var e:SimpleRaceEnchantment = it.enchantmentOfType(EnchantmentLib.RaceTf) as SimpleRaceEnchantment;
			return e && (e.race == race || race == null);
		}));
	}
	
	/**
	 * Advance the TF from the status effect
	 * @param effect
	 * @return true if text was printed
	 */
	public static function advance(effect:StatusEffectClass):Boolean {
		// v1: hours till next TF, v2: race id, v3: no. of equipped items of that race
		var race:Race = Race.byId(effect.value2);
		var items:/*ItemType*/Array = allEnchantedEquipment(race);
		var removeEffect:Boolean = true;
		var entry:Object = findByProp(instance.RaceGen, "race", Race.byId(effect.value2));
		if (entry.tfPerm) removeEffect = false;
		// Sanity check
		if (items.length == 0) {
			EngineCore.outputText("\n<b>ERROR</b> ItemEffectRaceTf effect ("+race.name+") present but no such item equipped (this is a bug). ");
			items = allEnchantedEquipment(null);
			game.player.removeStatusEffectInstance(effect);
			if (items.length > 0) {
				var e:SimpleRaceEnchantment = items[0].enchantmentOfType(EnchantmentLib.RaceTf) as SimpleRaceEnchantment;
				EngineCore.outputText("Replacing with "+e.race.name+". \n");
				e.onEquip(game.player, items[0]);
			} else {
				EngineCore.outputText("Effect removed. \n");
			}
			return true;
		}
		if (game.player.blockingBodyTransformations()) return false;
		if (game.player.isRace(race, 1, false) && removeEffect) { //I guess it should apply here too?
			disenchant(race);
			return true;
		}
		effect.value1--;
		trace("RaceTf tick-->" + effect.value1);
		var textOutput:Boolean      = false;
		if (effect.value1 <= 0) {
			var tfList:Array      = entry.tfs;
			var tf:PossibleEffect = TransformationUtils.randomPossibleEffect(tfList);
			if (tf) {
				trace("RaceTf tf");
				EngineCore.outputText("\n<b>Your " + items[0].longName + " twists your body...</b> ");
				tf.applyEffect(true);
				textOutput = true;
				if (game.player.isRace(race, 1, false) && removeEffect) { //should apply here too?
					disenchant(race);
				} else {
					var maxPower:int = 0;
					for each (var item:ItemType in items) {
						maxPower = Math.max(maxPower, item.enchantmentPower(EnchantmentLib.RaceTf));
					}
					effect.value1 = hoursBetweenTf(maxPower);
					trace("RaceTf tick reset to " + effect.value1);
				}
			}
		} else if (effect.value1 == 1) {
			EngineCore.outputText("\n<b>Your " + items[0].longName + " is almost charged...</b> ");
			textOutput = true;
		}
		return textOutput;
	}
	
	/**
	 * Player has been TF'd into race. Remove enchantment and curse status
	 */
	public static function disenchant(race:Race):void {
		trace("RaceTf disencnant");
		EngineCore.outputText("\n\n<b>Your transformation into " + race.nameFor(game.player.bodyData()))
		if (game.player.raceObject() == race) {
			EngineCore.outputText(" is complete, and the curse is lifted!</b>")
		} else {
			// main race is different, but player is tier1 at least
			EngineCore.outputText(" has advanced enough to lift the curse!</b>")
		}
		for each (var i:ItemType in game.player.allEquipment()) {
			var e:SimpleRaceEnchantment = i.enchantmentOfType(EnchantmentLib.RaceTf) as SimpleRaceEnchantment;
			if (!e) continue;
			if (e.race == race) {
				var e2:Enchantment;
				if (i is Weapon || i is WeaponRange) {
					e2 = EnchantmentLib.RaceAttackBonus.spawn2(true, e.power, e.race);
				} else if (i is Armor || i is Shield) {
					e2 = EnchantmentLib.RaceDefenseBonus.spawn2(true, e.power, e.race);
				} else {
					e2 = EnchantmentLib.RaceSpellPowerBonus.spawn2(true, e.power, e.race);
				}
				var i2:ItemType = i;
				i2              = (i2 as IDynamicItem).copyWithoutEnchantment(e);
				i2              = (i2 as IDynamicItem).uncursedCopy();
				i2              = (i2 as IDynamicItem).copyWithEnchantment(e2);
				game.player.replaceEquipment(i as Equipable, i2 as Equipable);
				EngineCore.outputText(" Your " + i.longName + " turns into " + i2.longName + "!");
			}
		}
	}
	
	public function RaceTfEnchantmentType(
			id:int,
			name:String,
			rarity:int,
			minLevel:int
	) {
		instance               = this;
		var curse:Boolean      = true;
		var descPattern:String = "Every {30-6*power} hours transforms you into {race.name}.";
		super(id, name, curse, descPattern, rarity, minLevel);
		negative = true;
	}
	
	override protected function doDecode(identified:Boolean, paramsOnly:Array):Enchantment {
		var power:Number            = paramsOnly[0];
		var race:Race               = Race.byId(paramsOnly[1]);
		var valueAddBase:int        = 0;
		var valueAddPerPower:int    = 250;
		var valueMulBase:Number     = 1.0;
		var valueMulPerPower:Number = 0.0;
		var valueAdd:Number         = valueAddBase + valueAddPerPower * power;
		var valueMul:Number         = valueMulBase + valueMulPerPower * power;
		var prefix:String           = "{race.name;C} nature ";
		var suffix:String           = " of {race.name;C} nature ";
		var shortSuffix:String      = "RTF";
		return new SimpleRaceEnchantment(
				identified,
				this,
				prefix,
				suffix,
				shortSuffix,
				power,
				race,
				paramsOnly,
				valueAdd,
				valueMul
		)
	}
	
	public function spawn(identified:Boolean, power:int, race:Race, permEffect:Boolean=false):SimpleRaceEnchantment {
		return doDecode(identified, [power, race.id, permEffect]) as SimpleRaceEnchantment;
	}
	
	override public function generateRandom(options:Object = null):Enchantment {
		var minPower:int = 1;
		var maxPower:int = 4;
		var power:int    = randIntIn(minPower, maxPower);
		var race:Race    = weightedRandomBy(RaceGen, "chance", "race");
		return doDecode(valueOr(options.identified, false), [power, race.id]);
	}
	
	override public function onEquip(player:Player, enchantment:Enchantment, item:Equipable):void {
		if (game.isLoadingSave) return;
		var race:Race = (enchantment as SimpleRaceEnchantment).race;
		var power:int = enchantment.power;
		var eff:StatusEffectClass = player.statusEffectByType(StatusEffects.ItemEffectRaceTf);
		trace("RaceTf equip "+race.name+" "+power+" "+eff);
		if (eff) {
			// Player is already TF'ing.
			if (eff.value2 == race.id) {
				// same race
				eff.value3++;
			} // else already TF into diff race - do nothing
		} else {
			// This is first TF item
			eff = player.createStatusEffect(StatusEffects.ItemEffectRaceTf, RaceTfEnchantmentType.hoursBetweenTf(power), race.id, 1, 0);
		}
		trace("      -> "+eff);
	}
	
	override public function onUnequip(player:Player, enchantment:Enchantment, item:Equipable):void {
		if (game.isLoadingSave) return;
		var race:Race = (enchantment as SimpleRaceEnchantment).race;
		var power:int = enchantment.power;
		var eff:StatusEffectClass = player.statusEffectByType(StatusEffects.ItemEffectRaceTf);
		trace("RaceTf unequip "+race.name+" "+power+" "+eff);
		if (!eff) return; // something very wrong here
		if (eff.value2 != race.id) return; // unequip RaceA TF while player is TF'ing into RaceB
		// unequip RaceA TF enchantment
		eff.value3--;
		trace("      -> "+eff);
		if (eff.value3 > 0) return; // still more TF enchantment of that race
		// last TF enchantment of RaceA unequipped.
		player.removeStatusEffectInstance(eff);
		// Check if player has other TF items
		var ench:Array = player.findEnchantmentAndItem(EnchantmentLib.RaceTf);
		if (ench && ench[1].category != item.category) {
			// Don't call onEquip of item in the same slot - it will be called by its afterEquip instead
			(ench[0] as Enchantment).onEquip(player, ench[1]);
		}
	}
}
}
