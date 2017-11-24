package classes.StatusEffects.Combat {
import classes.EngineCore;
import classes.StatusEffectType;

public class ParalyzeVenomDebuff extends CombatBuff {

	public static const TYPE:StatusEffectType = register("paralyze venom",ParalyzeVenomDebuff);
	public function ParalyzeVenomDebuff() {
		super(TYPE,'str','spe');
	}


	override public function onRemove():void {
		if (playerHost) {
			EngineCore.outputText("<b>You feel quicker and stronger as the paralyzation venom in your veins wears off.</b>\n\n");
		}
	}

	public function increase():void {
		buffHost('str',-3,'spe',-3);
	}

}

}