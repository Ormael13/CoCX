/**
 * Coded by aimozg on 23.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class CombatStrDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Combat Str Debuff", CombatStrDebuff);
	public function CombatStrDebuff() {
		super(TYPE, "str");
	}
	public function applyEffect(strDebuff:Number):Number {
		return buffHost("str", -strDebuff).str;
	}
}
}
