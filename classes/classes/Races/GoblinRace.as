package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.Transformations.TransformationGroupAny;

/**
 * Tier 1: goblin
 */
public class GoblinRace extends Race {
	public static const GoblinSkinColors:/*String*/Array = ["pale yellow", "grayish-blue", "green", "dark green", "emerald"];
	public static const GoblinEyeColors:/*String*/Array = ["red", "yellow", "purple"];
	public static const GoblinHairColors:/*String*/Array = ["red", "purple", "green", "blue", "pink", "orange"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Elfin",
        /*Eyes*/		"Goblin",
        /*Face*/		"Human",
        /*Gills*/		"None",
        /*Hair*/		"Goblin",
        /*Horns*/		"Human",
        /*LowerBody*/	"Human",
        /*RearBody*/	"Human",
        /*Skin*/		"Goblin",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Goblin"];
	
	public const TfList:/*Transformation*/Array = [
		new TransformationGroupAny("FaceHumanOrAnimal", [
			game.transformations.FaceHuman,
			game.transformations.FaceAnimalTeeth
		]),
		game.transformations.EarsElfin,
		game.transformations.SkinPlain,
		game.transformations.SkinColor(GoblinSkinColors),
		game.transformations.EyesHuman,
		game.transformations.EyesChangeColor(GoblinEyeColors),
		game.transformations.HairChangeColor(GoblinHairColors),
		game.transformations.ArmsHuman,
		game.transformations.LowerBodyHuman,
		game.transformations.AntennaeNone
	];
	
	public function GoblinRace(id:int) {
		super("Goblin", id);
        tfRace = RaceMem.GOBLIN;
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(ANY(Face.HUMAN, Face.ANIMAL_TOOTHS), +1)
				.earType(Ears.ELFIN, +1, -1000)
				.height(LESS_THAN(48), +1)
				.hasPerk(PerkLib.GoblinoidBlood, +1)
				.hasPerk(PerkLib.BouncyBody, +1)
				.skinPlainOnly(+1)
				.skinColor1(ANY(GoblinSkinColors), +1, -1000)
				.hasVagina(+1);
		addConditionedScores(
				function (body:BodyData):Boolean {
					return body.player.hasPlainSkinOnly();
				},
				"plain skin; "
		)
				.eyeTypeAndColor(Eyes.HUMAN, ANY(GoblinEyeColors), +1)
				.hairColor1(ANY(GoblinHairColors), +1)
				.armType(Arms.HUMAN, +1)
				.legType(LowerBody.HUMAN, +1)
				.noAntennae(+1);
		
		addMutation(IMutationsLib.NaturalPunchingBagIM);
		addBloodline(PerkLib.GoblinsDescendant, PerkLib.BloodlineGoblin);
		
		buildTier(10, "goblin")
				.buffs({
					"str.mult": -0.50,
					"spe.mult": +0.75,
					"int.mult": +1.00,
					"lib.mult": +0.25
				})
				.end();
	}
}
}
