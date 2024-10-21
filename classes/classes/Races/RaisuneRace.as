package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.CoC;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class RaisuneRace extends Race {
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Raiju",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Fox",
        /*Eyes*/		"Fox",
        /*Face*/		"Fox",
        /*Gills*/		"Human",
        /*Hair*/		"Raiju",
        /*Horns*/		"Human",
        /*LowerBody*/	"Raiju",
        /*RearBody*/	"Raiju",
        /*Skin*/		"Human",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Raisune",
        /*Tongue*/		"Human",
        /*Wings*/		"Thunder",
        /*Penis*/		"Raiju",
        /*Vagina*/		"Raiju",
        /*Perks*/		"Human"];

	public function RaisuneRace(id:int) {
		super("Raisune", id, []);//RaceBody);
		mutationThreshold = 6;
	}
	
	public override function setup():void {
		
		addScores()
				.eyeType(Eyes.FOX, +1)
				.earType(Ears.FOX, +1, -1)
				.faceType(ANY(Face.ANIMAL_TOOTHS, Face.HUMAN, Face.FOX), +1, -1)
				.armType(ANY(Arms.RAIJU,Arms.RAIJU_PAWS), +1)
				.legType(LowerBody.RAIJU, +1)
				.wingType(Wings.THUNDEROUS_AURA, +4)
				.rearType(RearBody.RAIJU_MANE, +1)
				.hairType(Hair.STORM, +1)
				.skinCoatType(NOT(Skin.CHITIN), 0, -2)
				.skinBaseType(NOT(Skin.GOO), 0, -3)
				.cockOrVaginaOfType(CockTypesEnum.RAIJU, VaginaClass.RAIJU, +1);
		addScoresAfter(5)
				.customRequirement("skin", "fur or magical tattoo",
						function (body:BodyData):Boolean {
							return body.skinCoatType == Skin.FUR
									|| body.skinBasePattern == Skin.PATTERN_MAGICAL_TATTOO
						}, +1)
				.hasPerk(PerkLib.StarSphereMastery, +1);
				
		addBloodline(PerkLib.RaijusDescendant, PerkLib.BloodlineRaiju);
		addMutation(IMutationsLib.KitsuneParathyroidGlandsIM);
		
		buildTier(11, "raisune")
				.buffs({
					"str.mult": +0.30,
					"tou.mult": +0.35,
					"wis.mult": +1.00,
					"maxlust_mult": -0.15,
					"maxsf_mult": +1,
					"maxwrath_mult": +0.6,
					"maxmana_mult": -0.8
				})
				.end();
		/*
		buildTier(16, "tierName")
				.buffs({
					"str.mult": +0.40,
					"tou.mult": +0.60,
					"wis.mult": +1.40,
					"maxlust_mult": -0.3,
					"maxsf_mult": +1,
					"maxwrath_mult": +0.8,
					"maxmana_mult": -0.8
				})
				.end();
		 */
	}
}
}
