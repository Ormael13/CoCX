package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.Race;

public class EchidnaRace extends Race {
	
	public function EchidnaRace(id:int) {
		super("Echidna", id);
		
		addScores()
				.earType(Ears.ECHIDNA, +1)
				.tailType(Tail.ECHIDNA, +1)
				.faceType(Face.ECHIDNA, +1)
				.tongueType(Tongue.ECHIDNA, +1)
				.legType(LowerBody.ECHIDNA, +1);
		addScoresAfter(2)
				.skinCoatType(Skin.FUR,+1);
		addScoresAfter(3)
				.hasCockOfType(CockTypesEnum.ECHIDNA, +1);
		
		buildTier(4, "echidna")
				.namesMaleFemaleMorphTaur("echidna-boy",
						"echidna-girl", "echidna", "echidna")
				.end();
	}
}
}
