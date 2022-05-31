package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class CentipedeRace extends Race {
	public function CentipedeRace(id:int) {
		super("Centipede", id);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.ANIMAL_TOOTHS, +1)
				.legType(LowerBody.CENTIPEDE, +2)
				.skinCoverage(Skin.COVERAGE_NONE, +1)
				.armType(Arms.HUMAN, +1)
				.antennaeType(Antennae.CENTIPEDE, +1)
				.rearType(RearBody.CENTIPEDE, +1)
				.earType(Ears.ELFIN, +1);
		
		buildTier(8, "centipede")
				.namesMaleFemale("centipede-man", "centipede-girl")
				.buffs({
					"str.mult": +0.60,
					"spe.mult": +0.80
				})
				.end();
	}
}
}
