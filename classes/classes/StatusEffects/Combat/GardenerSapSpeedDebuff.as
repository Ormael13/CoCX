/**
 * Coded by aimozg on 01.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class GardenerSapSpeedDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Sap Speed",GardenerSapSpeedDebuff);
	public function GardenerSapSpeedDebuff() {
		super(TYPE,'spe');
	}

	override protected function apply(firstTime:Boolean):void {
		buffHost('spe',-host.spe*0.2);
	}
}

}
