package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class CentipedeRace extends Race {
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Human",
        /*Eyes*/		"Human",
        /*Face*/		"Human",
        /*Gills*/		"Human",
        /*Hair*/		"Human",
        /*Horns*/		"Human",
        /*LowerBody*/	"Human",
        /*RearBody*/	"Human",
        /*Skin*/		"Human",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Human"];

    public function CentipedeRace(id:int) {
		super("Centipede", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
		disabled = true;
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
