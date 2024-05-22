package classes.Items.Effects {
import classes.CoC;
import classes.EngineCore;
import classes.ItemType;
import classes.Items.Dynamic.Effects.RaceTfEnchantmentType;
import classes.Items.Dynamic.Effects.SimpleRaceEnchantment;
import classes.Items.EnchantmentLib;
import classes.Items.Equipable;
import classes.Items.IELib;
import classes.Items.ItemConstants;
import classes.Items.ItemEffect;
import classes.Items.ItemEffectType;
import classes.Player;
import classes.Race;
import classes.Races;
import classes.StatusEffectClass;
import classes.StatusEffects;
import classes.Transformations.PossibleEffect;
import classes.Transformations.TransformationUtils;
import classes.internals.Utils;

public class RaceTfItemEffect extends ItemEffectType{
	/**
	 * Element properties:
	 * - chance:Number, spawn weight, default 1
	 * - race:Race
	 * - tfs:Transformation[]
	 */
	private static var RaceGen_field:Array = null;
	public static function get RaceGen():Array {
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
			chance: 0.1,
			race: Races.IMP,
			tfs: Races.IMP.TfList,
			tfPerm: false
		}, {
			chance: 0.5,
			race: Races.KITSUNE,
			tfs: Races.KITSUNE.TfList,
			tfPerm: false
		}, {
			chance: 1.0,
			race: Races.LIZARD,
			tfs: Races.LIZARD.TfList,
			tfPerm: false
		}, {
			chance: 1.0,
			race: Races.WOLF,
			tfs: Races.WOLF.TfList,
			tfPerm: false
		}];
		return RaceGen_field;
	}
	
	public function RaceTfItemEffect() {
        super("RaceTf");
		withFlags(ItemConstants.IEF_ONEQUIP);
	}
	
	override public function description(effect:ItemEffect, item:ItemType):String {
		return "Every "+Utils.numberOfThings(effect.power,"hour")+" hours transforms you into "+(effect.value1 as Race).name;
	}
	
	public static function allEnchantedEquipment(player:Player, race:Race):/*Equipable*/Array {
		return player.allEquipment().filter(Utils.varargify(function (it:Equipable):Boolean {
			var e:ItemEffect = it.findEffect(IELib.RaceTf);
			return e && (e.value1 == race || race == null);
		}));
	}
	
	/**
	 * Advance the TF from the status effect
	 * @param effect
	 * @return true if text was printed
	 */
	public static function advance(player:Player, effect:StatusEffectClass):Boolean {
		// v1: hours till next TF, v2: race id, v3: no. of equipped items of that race
		var race:Race = Race.byId(effect.value2);
		var items:/*Equipable*/Array = allEnchantedEquipment(player, race);
		var removeEffect:Boolean = true;
		var entry:Object = Utils.findByProp(RaceGen, "race", Race.byId(effect.value2));
		if (entry.tfPerm) removeEffect = false;
		// Sanity check
		if (items.length == 0) {
			EngineCore.outputText("\n<b>ERROR</b> ItemEffectRaceTf effect ("+race.name+") present but no such item equipped (this is a bug). ");
			items = allEnchantedEquipment(player, null);
			player.removeStatusEffectInstance(effect);
			if (items.length > 0) {
				var e:ItemEffect = items[0].findEffect(IELib.RaceTf);
				EngineCore.outputText("Replacing with "+(e.value1 as Race).name+". \n");
				e.onEquip(player, items[0]);
			} else {
				EngineCore.outputText("Effect removed. \n");
			}
			return true;
		}
		if (player.blockingBodyTransformations()) return false;
		
		//
		var hasEnchantments:Boolean = false;
		for each (var item:Equipable in items) {
			var enchantment:SimpleRaceEnchantment = item.enchantmentOfType(EnchantmentLib.RaceTf) as SimpleRaceEnchantment;
			if (enchantment && enchantment.race == race) {
				hasEnchantments = true;
				break;
			}
		}
		if (!hasEnchantments) removeEffect = false;
		
		if (removeEffect && player.isRace(race, 1, false)) {
			// If player is target race before tick, disenchant the item
			RaceTfEnchantmentType.disenchant(race);
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
				if (removeEffect && player.isRace(race, 1, false)) {
					// if player becomes target race, disenchant the item
					RaceTfEnchantmentType.disenchant(race);
				} else {
					var hoursBetween:int = 30;
					for each (item in items) {
						hoursBetween = Math.min(hoursBetween, item.effectPower(IELib.RaceTf));
					}
					effect.value1 = hoursBetween;
					trace("RaceTf tick reset to " + effect.value1);
				}
			}
		} else if (effect.value1 == 1) {
			EngineCore.outputText("\n<b>Your " + items[0].longName + " is almost charged...</b> ");
			textOutput = true;
		}
		return textOutput;
	}
	
	override public function onEquip(player:Player, item:Equipable, effect:ItemEffect):void {
		if (CoC.instance.isLoadingSave) return;
		var race:Race = effect.value1 as Race;
		var eff:StatusEffectClass = player.statusEffectByType(StatusEffects.ItemEffectRaceTf);
		trace("RaceTf equip "+race.name+" "+effect.power+" "+eff);
		if (eff) {
			// Player is already TF'ing.
			if (eff.value2 == race.id) {
				// same race
				eff.value3++;
			} // else already TF into diff race - do nothing
		} else {
			// This is first TF item
			eff = player.createStatusEffect(StatusEffects.ItemEffectRaceTf, effect.power, race.id, 1, 0);
		}
		trace("      -> "+eff);
	}
	
	override public function onUnequip(player:Player, item:Equipable, effect:ItemEffect):void {
		if (CoC.instance.isLoadingSave) return;
		var race:Race = effect.value1 as Race;
		var eff:StatusEffectClass = player.statusEffectByType(StatusEffects.ItemEffectRaceTf);
		trace("RaceTf unequip "+race.name+" "+effect.power+" "+eff);
		if (!eff) return; // something very wrong here
		if (eff.value2 != race.id) return; // unequip RaceA TF while player is TF'ing into RaceB
		// unequip RaceA TF enchantment
		eff.value3--;
		trace("      -> "+eff);
		if (eff.value3 > 0) return; // still more TF enchantment of that race
		// last TF enchantment of RaceA unequipped.
		player.removeStatusEffectInstance(eff);
		// Check if player has other TF items
		var ench:Array = player.findItemEffectAndItem(IELib.RaceTf);
		if (ench && ench[1].category != item.category) {
			// Don't call onEquip of item in the same slot - it will be called by its afterEquip instead
			(ench[0] as ItemEffect).onEquip(player, ench[1]);
		}
	}
}
}
