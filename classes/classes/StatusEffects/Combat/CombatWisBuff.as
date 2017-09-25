/**
 * Coded by aimozg on 23.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class CombatWisBuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Combat Wis Buff", CombatWisBuff);
	public function CombatWisBuff() {
		super(TYPE, "wis");
	}
	public function applyEffect(wisBuff:Number):Number {
		return buffHost("wis", wisBuff).wis;
	}
}
}
