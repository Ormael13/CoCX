package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.Race;

public class SatyrRace extends Race {
	
	public function SatyrRace(id: int) {
		super("Satyr", id);
		
		addScores()
				.legType(LowerBody.HOOFED, +1)
				.tailType(Tail.GOAT, +1)
				.earType(Ears.ELFIN, +1);
		addScoresAfter(3)
				.faceType(Face.HUMAN, +1)
				.hasCockOfType(CockTypesEnum.HUMAN, +1)
				.ballSize(AT_LEAST(3), +1);
		
		buildTier(4,"satyr")
				.buffs({
					"str.mult": +0.05,
					"spe.mult": +0.05
				})
				.end();
	}
}
}
