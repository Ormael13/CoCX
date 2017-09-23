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

	public function increase():void {
		buffHost('spe',-25);
	}
}
}
