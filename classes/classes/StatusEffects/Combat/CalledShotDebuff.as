package classes.StatusEffects.Combat {
import classes.StatusEffectType;
import classes.StatusEffects.CombatStatusEffect;

public class CalledShotDebuff extends CombatBuff {

	public static const TYPE:StatusEffectType = register("Called Shot",CalledShotDebuff);
	public function CalledShotDebuff() {
		super(TYPE,'spe');
	}
	
	public function increase():void {
		buffHost('spe', -20 - rand(5));
	}
}

}