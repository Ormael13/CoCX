/**
 * Coded by aimozg on 24.08.2017.
 */
package classes.StatusEffects.Combat {
import classes.EngineCore;
import classes.StatusEffectType;

public class AmilyVenomDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Amily Venom",AmilyVenomDebuff);
	public function AmilyVenomDebuff() {
		super(TYPE,'str','spe');
	}

	public function increase():void {
		buffHost('str', -2 - rand(5),'spe', -2 - rand(5));
		
		//If PC is reduced to 0 Speed and Strength, normal defeat by HP plays.
		if (host.spe <= 2 && host.str <= 2) {
			if (playerHost) EngineCore.outputText("  You've become so weakened that you can't even make an attempt to defend yourself, and Amily rains blow after blow down upon your helpless form.");
			host.takePhysDamage(8999);
		}
	}
}
}
