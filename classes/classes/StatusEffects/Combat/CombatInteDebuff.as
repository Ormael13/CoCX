/**
 * Coded by aimozg on 23.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class CombatInteDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Combat Inte Debuff", CombatInteDebuff);
	public function CombatInteDebuff() {
		super(TYPE, "inte");
	}
	public function applyEffect(inteDebuff:Number):Number {
		return buffHost("inte", -inteDebuff).inte;
	}
}
}
