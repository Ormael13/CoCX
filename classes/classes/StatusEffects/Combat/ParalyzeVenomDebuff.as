package classes.StatusEffects.Combat {
import classes.EngineCore;
import classes.StatusEffectType;

public class ParalyzeVenomDebuff extends CombatBuff {

	public static const TYPE:StatusEffectType = register("paralyze venom",ParalyzeVenomDebuff);
	public function ParalyzeVenomDebuff() {
		super(TYPE,'str','spe');
	}


	override public function onRemove():void {
		super.onRemove();
		if (playerHost) {
			EngineCore.outputText("<b>You feel quicker and stronger as the paralyzation venom in your veins wears off.</b>\n\n");
		}
	}

	public function increaseBee():void {
		buffHost('str',-3,'spe',-3);
	}
	public function increaseWasp1():void {
		buffHost('str',-6,'spe',-6);
	}
	public function increaseWasp2():void {
		buffHost('str',-10,'spe',-10);
	}
	public function increaseHornet1():void {
		buffHost('str',-9,'spe',-9);
	}
	public function increaseHornet2():void {
		buffHost('str',-15,'spe',-15);
	}

}

}