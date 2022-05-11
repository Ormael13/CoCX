package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.Race;

public class DeerRace extends Race{
	public function DeerRace(id:int) {
		super("Deer", id);
		
		addScores()
				.earType(Ears.DEER, +1)
				.tailType(Tail.DEER, +1)
				.faceType(Face.DEER, +1)
				.legType(ANY(LowerBody.CLOVEN_HOOFED, LowerBody.DEERTAUR), +1)
				.hornTypeAndCount(Horns.ANTLERS, AT_LEAST(4), +1);
		addScoresAfter(2)
				.skinCoatType(Skin.FUR, +1);
		addScoresAfter(3)
				.hasCockOfType(CockTypesEnum.HORSE, +1);
		
		buildTier(4, "deer")
				.namesMaleFemaleMorphTaur("deer-morph", "deer-girl", "deer-morph", "deer-taur")
				.buffs({
					"spe.mult": +0.20
				})
				.end()
	}
}
}
