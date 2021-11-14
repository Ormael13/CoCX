package classes.Scenes.Combat {
import classes.Scenes.Combat.SpellsWhite.PyreBurstSpell;
import classes.Scenes.Combat.SpellsWhite.WhitefireSpell;

public class CombatAbilities {
	
	public static const Whitefire:WhitefireSpell = new WhitefireSpell();
	public static const WhitefireEx:WhitefireSpell = new WhitefireSpell(true);
	public static const PyreBurst:PyreBurstSpell = new PyreBurstSpell();
	public static const PyreBurstEx:PyreBurstSpell              = new PyreBurstSpell(true);
	public static const ALL_WHITE_SPELLS:/*CombatAbility*/Array = [
		Whitefire,
		WhitefireEx,
		PyreBurst,
		PyreBurstEx
	];
	
	public static const ALL_SPELLS:/*CombatAbility*/Array = []
			.concat(ALL_WHITE_SPELLS);
	
	public static const ALL:/*CombatAbility*/Array = []
			.concat(ALL_SPELLS);
	
	function CombatAbilities() {
	}
}
}
