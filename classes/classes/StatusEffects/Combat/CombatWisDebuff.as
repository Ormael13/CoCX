/**
 * Coded by aimozg on 23.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class CombatWisDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Combat Wis Debuff", CombatWisDebuff);
	public function CombatWisDebuff() {
		super(TYPE, "wis");
	}
	public function applyEffect(wisDebuff:Number):Number {
		return buffHost("wis", -wisDebuff).wis;
	}
}
}
