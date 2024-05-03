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
	public static const GoblinRareSkinColors:/*String*/Array = ["red", "orange","pale purple", "royal purple", "light purple"];
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
	
	public function get TfList():/*Transformation*/Array {
		return [
			new TransformationGroupAny("FaceHumanOrAnimal", [
				game.transformations.FaceHuman,
				game.transformations.FaceAnimalTeeth
			]),
			new TransformationGroupAny("EarsElfinOrBig", [
				game.transformations.EarsElfin,
				game.transformations.EarsBig
			]),
			game.transformations.SkinPlain,
			game.transformations.SkinColor(GoblinSkinColors),
			game.transformations.EyesHuman,
			game.transformations.EyesChangeColor(GoblinEyeColors),
			game.transformations.HairChangeColor(GoblinHairColors),
			game.transformations.ArmsHuman,
			game.transformations.LowerBodyHuman,
			game.transformations.AntennaeNone
		];
	}
	
	public function GoblinRace(id:int) {
		super("Goblin", id, RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(ANY(Face.HUMAN, Face.ANIMAL_TOOTHS), +1)
				.earType(ANY(Ears.ELFIN, Ears.BIG), +1, -1000)
				.hornType(NOT(Horns.DEMON), 0, -10)
				.height(LESS_THAN(48), +1)
				.hasPerk(PerkLib.GoblinoidBlood, +1)
				.hasPerk(PerkLib.BouncyBody, +1)
				.skinPlainOnly(+1)
				.skinColor1(ANY(GoblinSkinColors, GoblinRareSkinColors), +1, -1000)
				.hasVagina(+1);
		addConditionedScores(
				function (body:BodyData):Boolean {
					return body.player.hasPlainSkinOnly();
				}, "plain skin; ")
				.eyeTypeAndColor(Eyes.HUMAN, ANY(GoblinEyeColors), +1)
				.hairColor1(ANY(GoblinHairColors), +1)
				.armType(Arms.HUMAN, +1)
				.armType(NOT(Arms.TINY), 0, -10)
				.legType(LowerBody.HUMAN, +1)
				.legType(NOT(LowerBody.TINY), 0, -10)
				.noAntennae(+1);
		
		addBloodline(PerkLib.GoblinsDescendant, PerkLib.BloodlineGoblin);
		addMutation(IMutationsLib.NaturalPunchingBagIM);
		addMutation(IMutationsLib.GoblinOvariesIM);
		
		buildTier(10, "goblin")
				.buffs({
					"str.mult": -0.50,
					"spe.mult": +0.60,
					"int.mult": +1.00,
					"lib.mult": +0.40
				})
				.end();
		
		buildTier(20, "broodmother goblin")
				.buffs({
					"str.mult": -0.60,
					"spe.mult": +1.20,
					"int.mult": +2.00,
					"lib.mult": +0.80,
					"sens": +40
				})
				.end();/*
		
		buildTier(10, "goblin (GOBX)")
				.buffs({
					"str.mult": -0.50,
					"spe.mult": +1.50,
					"int.mult": +1.80,
					"lib.mult": +1.20
				})
				.end();
		
		buildTier(20, "broodmother goblin (GOBX)")
				.buffs({
					"str.mult": -0.60,
					"spe.mult": +2.00,
					"int.mult": +3.20,
					"lib.mult": +1.60,
					"sens": +80
				})
				.end();*/
	}
}
}
