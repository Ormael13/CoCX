/**
 * Coded by aimozg on 23.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class CombatStrBuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Combat Str Buff", CombatStrBuff);
	public function CombatStrBuff() {
		super(TYPE, "str");
	}
	public function applyEffect(strBuff:Number):Number {
		return buffHost("str", strBuff).str;
	}
}
}
