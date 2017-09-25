/**
 * Coded by aimozg on 23.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class CombatInteBuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Combat Inte Buff", CombatInteBuff);
	public function CombatInteBuff() {
		super(TYPE, "inte");
	}
	public function applyEffect(inteBuff:Number):Number {
		return buffHost("inte", inteBuff).inte;
	}
}
}
