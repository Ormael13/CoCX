/**
 * Coded by aimozg on 01.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class GiantStrLossDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("GiantStrLoss",GiantStrLossDebuff);
	public function GiantStrLossDebuff() {
		super(TYPE,'str');
	}

	public function applyEffect(magnitude:Number):void {
		buffHost('str', -magnitude);
	}
}

}
