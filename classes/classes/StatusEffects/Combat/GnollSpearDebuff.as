package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class GnollSpearDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Gnoll Spear",GnollSpearDebuff);
	public function GnollSpearDebuff() {
		super(TYPE,'spe');
	}


	override protected function apply(firstTime:Boolean):void {
		buffHost('spe', -15);
	}
}

}
