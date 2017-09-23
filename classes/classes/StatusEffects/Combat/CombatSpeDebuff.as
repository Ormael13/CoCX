/**
 * Coded by aimozg on 23.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class CombatSpeDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Combat Spe Debuff", CombatSpeDebuff);
	public function CombatSpeDebuff() {
		super(TYPE, "spe");
	}
	public function applyEffect(speDebuff:Number):Number {
		return buffHost("spe", -speDebuff).spe;
	}
}
}
