/**
 * Coded by aimozg on 22.08.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class WebDebuff extends CombatBuff{
	public static const TYPE:StatusEffectType = register("Web",WebDebuff);
	public function WebDebuff() {
		super(TYPE, 'spe');
	}

	override protected function apply(firstTime:Boolean):void {
		buffHost('spe',-25);
	}
}
}
