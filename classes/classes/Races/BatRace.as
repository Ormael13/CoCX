package classes.Races {
import classes.BodyParts.*;
import classes.Race;

public class BatRace extends Race {
	public function BatRace(id: int) {
		super("Bat", id);
		
		addScores()
				.earType(Ears.BAT, +1)
				.earType(NOT(Ears.VAMPIRE), 0,-10)
				.armType(Arms.BAT, +5)
				.faceType(Face.VAMPIRE, +2)
				.eyeType(Eyes.VAMPIRE, +1)
				.rearType(RearBody.BAT_COLLAR, +1);
		addScoresAfter(8)
				.legType(LowerBody.HUMAN, +1);
		
		buildTier(10,"bat boy","bat girl")
				.buffs({
					"str.mult": +0.35,
					"spe.mult": +0.35,
					"int.mult": +0.35,
					"lib.mult": +0.45
				})
				.end()
	}
}
}
