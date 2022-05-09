package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.PerkLib;
import classes.Race;

public class RedPandaRace extends Race{
	public function RedPandaRace(id:int) {
		super("red panda", id);
		
		addScores()
				.faceType(Face.RED_PANDA, +2)
				.earType(Ears.RED_PANDA, +1)
				.tailType(Tail.RED_PANDA, +1)
				.armType(Arms.RED_PANDA, +1)
				.legType(LowerBody.RED_PANDA, +1);
		addScoresAfter(2)
				.skinBasePattern(Skin.PATTERN_RED_PANDA_UNDERBODY, +1)
				.skinCoatType(Skin.FUR, +1);
		
		buildTier(8, "red panda")
				.customNamingFunction(function(body:BodyData):String {
					if (body.isTaur) return "red-panda-taur";
					if (body.faceType == Face.HUMAN) return "red-panda-"+body.mf("boy","girl");
					return "red-panda-morph"
				})
				.buffs({
					"str.mult": +0.15,
					"spe.mult": +0.75,
					"int.mult": +0.30
				})
				.end()
	}
}
}
