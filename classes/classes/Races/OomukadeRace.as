package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class OomukadeRace extends Race {
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

	public function OomukadeRace(id:int) {
		super("Oomukade", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		addScores()
				.faceType(Face.ANIMAL_TOOTHS, +1)
				.eyeType(Eyes.CENTIPEDE, +1)
				.legType(LowerBody.CENTIPEDE, +1)
				.skinPlainOnly(+1)
				.armType(Arms.CENTIPEDE, +1)
				.antennaeType(Antennae.CENTIPEDE, +1)
				.rearType(RearBody.CENTIPEDE, +4)
				.earType(Ears.ELFIN, +1)
				.skinBasePattern(Skin.PATTERN_VENOMOUS_MARKINGS, +2)
				.cockOrVaginaOfType(CockTypesEnum.OOMUKADE, VaginaClass.VENOM_DRIPPING,2);
		
		buildTier(15, "oomukade")
				.buffs({
					"str.mult": +0.75,
					"tou.mult": +0.50,
					"spe.mult": +0.60,
					"wis.mult": -0.50,
					"lib.mult": +1.10
				})
				.end();
		
		buildTier(18, "elder oomukade")
				.buffs({
					"str.mult": +1.25,
					"tou.mult": +0.45,
					"spe.mult": +0.60,
					"wis.mult": -0.50,
					"lib.mult": +1.10
				})
				.end();
	}
}
}
