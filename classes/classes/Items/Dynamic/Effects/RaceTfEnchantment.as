package classes.Items.Dynamic.Effects {
import classes.ItemType;
import classes.Items.Enchantment;
import classes.Items.EnchantmentLib;
import classes.Items.EnchantmentType;
import classes.Player;
import classes.Race;
import classes.StatusEffectClass;
import classes.StatusEffects;

public class RaceTfEnchantment extends Enchantment {
	public var race:Race;
	
	public function RaceTfEnchantment(
			identified:Boolean,
			type:EnchantmentType,
			prefix:String,
			suffix:String,
			shortSuffix:String,
			power:Number,
			race:Race,
			params:Array,
			valueAdd:Number,
			valueMul:Number
	) {
		super(identified, type, prefix, suffix, shortSuffix, power, params, valueAdd, valueMul, false);
		this.race = race;
		genDescription();
	}
	
	override public function onEquip(player:Player, item:ItemType):void {
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
	
	override public function onUnequip(player:Player, item:ItemType):void {
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
		if (ench) {
			(ench[0] as Enchantment).onEquip(player, ench[1]);
		}
		
	}
}
}
