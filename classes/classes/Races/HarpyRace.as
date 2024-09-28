package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.internals.Utils;

public class HarpyRace extends Race {
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Snake",
        /*Eyes*/		"Gorgon",
        /*Face*/		"Snake",
        /*Gills*/		"None",
        /*Hair*/		"Gorgon",
        /*Horns*/		"Human",
        /*LowerBody*/	"Snake",
        /*RearBody*/	"Human",
        /*Skin*/		"Snake",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Snake",
        /*Wings*/		"Human",
        /*Penis*/		"Lizard",
        /*Vagina*/		"Lizard",
        /*Perks*/		"Human"];

	public function HarpyRace(id:int) {
		super("Harpy", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.armType(Arms.HARPY, +1)
				.hairType(Hair.FEATHER, +1)
				.wingType(Wings.FEATHERED_LARGE, +4)
				.tailType(Tail.HARPY, +1)
				.legType(LowerBody.HARPY, +1)
				.hasPerk(PerkLib.HarpyWomb, +2)
				.customRequirement("","not another harpy-like race",
						function (body:BodyData):Boolean {
							return !(SalamanderRace.isSalamanderLike(body)
									|| SirenRace.isSirenLike(body)
									|| PhoenixRace.isPhoenixLike(body)
									|| body.tailType == Tail.THUNDERBIRD
							);
						}, 0, -1000);
		addScoresAfter(3)
				.hasVagina(+1)
				.skinCoverage(Skin.COVERAGE_NONE, +1)
				.faceType(ANY(Face.HUMAN, Face.ANIMAL_TOOTHS), +1)
				.earType(ANY(Ears.HUMAN, Ears.ELFIN), +1);
		
		addBloodline(PerkLib.HarpysDescendant, PerkLib.BloodlineHarpy);
		addMutation(IMutationsLib.HarpyHollowBonesIM);
		
		buildTier(8, "harpy")
				.namesMaleFemale("avian", "harpy")
				.buffs({
					"tou.mult": -0.20,
					"spe.mult": +0.80,
					"lib.mult": +0.60
				})
				.end();
		
		buildTier(15, "harpy queen")
				.buffs({
					"tou.mult": -0.30,
					"spe.mult": +1.50,
					"lib.mult": +1.05
				})
				.end();
	}
}
}
