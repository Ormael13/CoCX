package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;

public class SandTrapRace extends Race {
	public function SandTrapRace(id:int) {
		super("Sand Trap", id);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		addScores()
				.eyeType(Eyes.BLACK_EYES_SAND_TRAP, +1)
				.wingType(Wings.GIANT_DRAGONFLY, +1)
				.vaginaType(VaginaClass.BLACK_SAND_TRAP, +1)
				.hasStatusEffect(StatusEffects.BlackNipples, "Black nipples", +1)
				.hasStatusEffect(StatusEffects.Uniball, "Uniball", +2);
		
		buildTier(5, "sand trap")
				.end();
	}
}
}
