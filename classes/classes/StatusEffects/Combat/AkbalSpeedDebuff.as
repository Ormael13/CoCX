/**
 * Coded by aimozg on 22.08.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class AkbalSpeedDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Akbal Speed",AkbalSpeedDebuff);
	public function AkbalSpeedDebuff() {
		super(TYPE,'spe');
	}


	override protected function apply(firstTime:Boolean):void {
		buffHost('spe', -host.spe / 5);
	}
}

}
