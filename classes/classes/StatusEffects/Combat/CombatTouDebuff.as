/**
 * Coded by aimozg on 23.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class CombatTouDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Combat Tou Debuff", CombatTouDebuff);
	public function CombatTouDebuff() {
		super(TYPE, "tou");
	}
	public function applyEffect(touDebuff:Number):Number {
		return buffHost("tou", -touDebuff).tou;
	}
}
}
