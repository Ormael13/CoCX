/**
 * Coded by aimozg on 23.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class CombatSpeBuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Combat Spe Buff", CombatSpeBuff);
	public function CombatSpeBuff() {
		super(TYPE, "spe");
	}
	public function applyEffect(speBuff:Number):Number {
		return buffHost("spe", speBuff).spe;
	}
}
}
