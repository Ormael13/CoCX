package classes.Races {

import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.PerkLib;
import classes.Race;

public class GryphonRace extends Race{
	public function GryphonRace(id:int) {
		super("gryphon", id);
		
		addScores()
				.hairType(Hair.FEATHER, +1)
				.faceType(Face.AVIAN, +1)
				.earType(Ears.GRYPHON, +1)
				.eyeType(Eyes.GRYPHON, +1)
				.tailType(Tail.GRIFFIN, +1)
				.armType(Arms.GRYPHON, +1)
				.legType(LowerBody.GRYPHON, +1)
				.wingType(Wings.FEATHERED_AVIAN, +2)
				.skinCoatType(Skin.FEATHER, +1)
				.hasCockOfType(CockTypesEnum.GRYPHON, +1);
		
		buildTier(9,"gryphon")
				.end();
	}
}
}
