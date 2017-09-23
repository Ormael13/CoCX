package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class ParalyzeVenomDebuff extends CombatBuff {

	public static const TYPE:StatusEffectType = register("paralyze venom",ParalyzeVenomDebuff);
	public function ParalyzeVenomDebuff() {
		super(TYPE,'str','spe');
	}


	override public function onRemove():void {
		if (playerHost) {
			game.outputText("<b>You feel quicker and stronger as the paralyzation venom in your veins wears off.</b>\n\n");
		}
	}

	override protected function apply(firstTime:Boolean):void {
		buffHost('str',firstTime?-2:-3,'spe',firstTime?-2:-3);
	}

}

}