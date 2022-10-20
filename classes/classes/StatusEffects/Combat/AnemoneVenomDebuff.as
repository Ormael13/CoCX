package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class AnemoneVenomDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Anemone Venom",AnemoneVenomDebuff);
	public function AnemoneVenomDebuff() {
		super(TYPE,'str','spe');
	}

	public function applyEffect(amt:Number):void {
		host.takeLustDamage((2 * amt), true);
		var debuff:* = buffHost('str', -amt,'spe',-amt);
		//Str bottommed out, convert to lust
		if (debuff.str == 0) host.takeLustDamage(amt, true);
		//Spe bottommed out, convert to lust
		if (debuff.spe == 0) host.takeLustDamage(amt, true);
	}
}

}
