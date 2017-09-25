/**
 * Coded by aimozg on 01.09.2017.
 */
package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class LizanBlowpipeDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Lizan Blowpipe", LizanBlowpipeDebuff);
	public function LizanBlowpipeDebuff() {
		super(TYPE, 'str', 'tou', 'spe', 'sen');
	}
	public function debuffStrSpe():void {
		var power:Number = 5;
		// don't want to have corruptionTolerance() in Creature in favour of future (?) corruptAtLeast/corruptAtMost
		if (host.cor > 50 + (playerHost ? playerHost.corruptionTolerance() : 0)) {
			power = 10;
		}
		buffHost('str', -power, 'spe', -power);
	}
	public function debuffTouSens():void {
		var power:Number = 5;
		if (host.cor > 50 + (playerHost ? playerHost.corruptionTolerance() : 0)) {
			power = 10;
		}
		buffHost('tou', -power, 'sens', power);
	}
}

}
