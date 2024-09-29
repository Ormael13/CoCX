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
				.legType(LowerBody.CENTIPEDE, +4)
				.skinPlainOnly(+1)
				.armType(Arms.CENTIPEDE, +1)
				.antennaeType(Antennae.CENTIPEDE, +1)
				.rearType(RearBody.CENTIPEDE, +2)
				.earType(Ears.ELFIN, +1)
				.skinBasePattern(Skin.PATTERN_VENOMOUS_MARKINGS, +2)
				.cockOrVaginaOfType(CockTypesEnum.OOMUKADE, VaginaClass.VENOM_DRIPPING, +2);
		
		addBloodline(PerkLib.CentipedesDescendant, PerkLib.BloodlineCentipede);
		addMutation(IMutationsLib.TrachealSystemIM);
		
		buildTier(8, "centipede")
				.namesMaleFemale("centipede-man", "centipede-girl")
				.buffs({
					"str.mult": +0.70,
					"tou.mult": +0.20,
					"spe.mult": +0.30
				})
				.end();
		
		buildTier(13, "elder centipede")
				.namesMaleFemale("elder centipede-man", "elder centipede-girl")
				.buffs({
					"str.mult": +0.95,
					"tou.mult": +0.40,
					"spe.mult": +0.60
				})
				.end();
		
		buildTier(18, "oomukade")
				.buffs({
					"str.mult": +1.10,
					"tou.mult": +0.50,
					"spe.mult": +0.70,
					"wis.mult": -0.20,
					"lib.mult": +0.60
				})
				.end();/*
		
		buildTier(24, "primodal oomukade")
				.buffs({
					"str.mult": +1.30,
					"tou.mult": +0.70,
					"spe.mult": +0.90,
					"wis.mult": -0.20,
					"lib.mult": +0.90
				})
				.end();*/
	}
}
}
