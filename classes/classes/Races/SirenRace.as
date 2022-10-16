package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.Race;
import classes.VaginaClass;

public class SirenRace extends Race {
	public static const SirenScaleColors:/*String*/Array = ["rough gray", "orange", "dark gray", "grayish-blue", "iridescent gray", "ashen grayish-blue", "gray"];
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
	
	public function SirenRace(id: int) {
		super("Siren", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.SHARK_TEETH, +1)
				.hairType(Hair.FEATHER, +1)
				.hairColor1("silver", +1)
				.earType(ANY(Ears.SHARK, Ears.HUMAN, Ears.ELFIN), +1)
				.tailType(Tail.SHARK, +1)
				.wingType(Wings.FEATHERED_LARGE, +4, -1000)
				.armType(ANY(Arms.HARPY, Arms.SHARK), +1)
				.legType(ANY(LowerBody.SHARK, LowerBody.HARPY), +1)
				.skinCoatTypeAndColor1(Skin.AQUA_SCALES, ANY(SirenScaleColors), +2)
				.gillType(Gills.FISH, +1)
				.eyeType(Eyes.HUMAN, +1)
				.vaginaType(VaginaClass.SHARK, +1);
		
		addMutation(IMutationsLib.HarpyHollowBonesIM);
		addMutation(IMutationsLib.SharkOlfactorySystemIM);
		
		buildTier(10,"siren")
				.namesTauric("siren", "siren-taur")
				.buffs({
					"str.mult": +0.50,
					"spe.mult": +0.70,
					"lib.mult": +0.30
				})
				.end();
		
		buildTier(20,"Greater siren")
				.namesTauric("Greater siren", "Greater siren-taur")
				.buffs({
					"str.mult": +0.80,
					"spe.mult": +1.20,
					"lib.mult": +1.00
				})
				.end();
	}
	
	public static function isSirenLike(body:BodyData):Boolean {
		return body.tailType == Tail.SHARK
				|| body.faceType == Face.SHARK_TEETH;
	}
}
}
