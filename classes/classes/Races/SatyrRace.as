package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.Race;

public class SatyrRace extends Race {
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
	
	public function SatyrRace(id: int) {
		super("Satyr", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		
		addScores()
				.legType(LowerBody.HOOFED, +1)
				.tailType(Tail.GOAT, +1)
				.earType(Ears.ELFIN, +1);
		addScoresAfter(3)
				.faceType(Face.HUMAN, +1)
				.hasCockOfType(CockTypesEnum.HUMAN, +1)
				.ballSize(AT_LEAST(3), +1);
		
		buildTier(4,"satyr")
				.buffs({
					"str.mult": +0.05,
					"spe.mult": +0.05
				})
				.end();
	}
}
}
