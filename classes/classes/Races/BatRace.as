package classes.Races {
import classes.BodyParts.*;
import classes.PerkLib;
import classes.Race;

public class BatRace extends Race {
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

	public function BatRace(id: int) {
		super("Bat", id, []);//RaceBody);
        //tfRace = RaceMem.appendEnumVal("Bat", CoC.instance.transformations.FullBat);
	}
	
	public override function setup():void {
		
		addScores()
				.earType(Ears.BAT, +1)
				.earType(NOT(Ears.VAMPIRE), 0,-10)
				.armType(Arms.BAT, +5)
				.faceType(Face.VAMPIRE, +2)
				.eyeType(Eyes.VAMPIRE, +1)
				.rearType(RearBody.BAT_COLLAR, +1)
				.armType(Arms.HUMAN, +1)
				.legType(LowerBody.HUMAN, +1);
		
		addBloodline(PerkLib.BatsDescendant, PerkLib.BloodlineBat);
		
		buildTier(10,"bat")
				.namesMaleFemale("bat boy","bat girl")
				.buffs({
					"str.mult": +0.35,
					"spe.mult": +0.35,
					"int.mult": +0.35,
					"lib.mult": +0.45
				})
				.end()
	}
}
}
