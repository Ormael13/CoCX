package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.Race;

public class RhinoRace extends Race {
	public function RhinoRace(id:int) {
		super("Rhino", id);
		
		addScores()
				.earType(Ears.RHINO, +1)
				.tailType(Tail.RHINO, +1)
				.faceType(Face.RHINO, +1)
				.hornType(Horns.RHINO, +1);
		addScoresAfter(2)
				.skinBaseColor("gray", +1)
				.hasCockOfType(CockTypesEnum.RHINO, +1);
		
		buildTier(4, "rhino")
				.buffs({
					"str.mult": +0.15,
					"tou.mult": +0.15,
					"spe.mult": -0.10,
					"int.mult": -0.10,
					"maxhp_base": +100
				})
				.end();
	}
}
}
