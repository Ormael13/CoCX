package classes.StatusEffects.Combat {
import classes.StatusEffectType;
import classes.StatusEffects.TemporaryBuff;

public class CombatBuff extends TemporaryBuff{
	public function CombatBuff(stype:StatusEffectType, stat1:String, stat2:String ='', stat3:String ='', stat4:String ='') {
		super(stype, stat1, stat2, stat3, stat4);
	}

	override public function onCombatEnd():void {
		super.onCombatEnd();
		remove();
	}
}
}
