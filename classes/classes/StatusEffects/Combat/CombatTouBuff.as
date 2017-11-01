/**
 * Coded by aimozg on 23.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class CombatTouBuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Combat Tou Buff", CombatTouBuff);
	public function CombatTouBuff() {
		super(TYPE, "tou");
	}
	public function applyEffect(touBuff:Number):Number {
		return buffHost("tou", touBuff).tou;
	}
}
}
