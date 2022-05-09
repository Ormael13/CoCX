package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.Race;

public class PeacockRace extends Race{
	public function PeacockRace(id:int) {
		super("Peacock", id);
		
		addScores()
				.hairType(Hair.FEATHER, +1)
				.faceType(Face.AVIAN, +1)
				.earType(Ears.AVIAN, +1)
				.tailType(Tail.AVIAN, +1)
				.armType(Arms.AVIAN, +1)
				.legType(LowerBody.AVIAN, +1)
				.wingType(Wings.FEATHERED_AVIAN, +2)
				.skinCoatType(Skin.FEATHER, +1)
				.hasCockOfType(CockTypesEnum.AVIAN, +1)
		
		buildTier(9, "peacock")
				.end();
	}
}
}
