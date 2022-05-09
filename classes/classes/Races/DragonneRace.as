package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.PerkLib;
import classes.Race;

public class DragonneRace extends Race{
	public function DragonneRace(id:int) {
		super("Dragonne", id);
		
		addScores()
				.faceType(Face.CAT, +1)
				.earType(Ears.CAT, +1)
				.tailType(Tail.CAT, +1)
				.tongueType(Tongue.DRACONIC, +1)
				.wingType(Wings.DRACONIC_LARGE, +2)
				.wingType(Wings.DRACONIC_SMALL, +1)
				.legType(LowerBody.CAT, +1);
		addScoresAfter(1)
				.skinCoatType(Skin.SCALES, +1);
		
		buildTier(6, "dragonne")
				.customNamingFunction(function (body:BodyData):String {
					if (body.isTaur) return "dragonne-taur";
					if (body.faceType == Face.HUMAN) return "dragonne-"+body.mf("man","girl");
					return "dragonne";
				})
				.end();
	}
}
}
