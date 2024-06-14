package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
//import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
//import classes.lists.Gender;

public class DragonneRace extends Race{
	public static const DragonneScaleColors:Array = ["yellow", "golden", "golden blonde"];
	public static const DragonneFurColors:Array = ["red", "brown", "tawny"];
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

    public function DragonneRace(id:int) {
		super("Dragonne", id, []);//RaceBody);
		mutationThreshold = 6;
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(ANY(Face.CAT, Face.CAT_CANINES), +1)
				.earType(Ears.CAT, +1)
				.eyeType(Eyes.CAT, +1)
				.eyeColor("red", +1)
				.tailType(Tail.CAT, +1)
				.tailType(NONE(Tail.FEY_DRACONIC, Tail.DRACONIC), 0, -10)
				.tongueType(Tongue.CAT, +1, -1000)
				.tongueType(NOT(Tongue.DRACONIC), 0, -10)
				.wingType(Wings.DRACONIC_SMALL, +2)
				.wingType(Wings.DRACONIC_LARGE, +4)
				.wingType(Wings.DRACONIC_HUGE, +4)
				.hornType(Horns.DRACONIC_X2, +1)
				.hornType(Horns.DRACONIC_X4_12_INCH_LONG, +2)
				.legType(LowerBody.LION, +1)
				.legType(NONE(LowerBody.FROSTWYRM, LowerBody.FEY_DRAGON, LowerBody.DRAGON), 0, -10)
				.armType(Arms.LION, +1)
				.armType(NONE(Arms.FEY_DRACONIC, Arms.DRACONIC), 0, -10)
				.rearType(RearBody.LION_MANE, +1)
				.hornType(NOT(Horns.FROSTWYRM), 0, -3)
				.skinCoatType(Skin.DRAGON_SCALES, +1)
				.scaleColor1(ANY(DragonneScaleColors), +1)
				.furColor01(ANY(DragonneFurColors), +1)
				.customRequirement("",'vagina and C+ tits or 16\"+ long cock',
						function (body:BodyData):Boolean {
							return body.hasVagina && body.biggestTitSize >= 3 || body.biggestCockSize > 16
						}, +1);
		addScoresAfter(8)
				.height(GREATER_THAN(96), +1)
				.hasPerk(PerkLib.Flexibility, +1)
				.hasPerk(PerkLib.DragonRegalBreath, +1);
		
		addBloodline(PerkLib.DragonsDescendant, PerkLib.BloodlineDragon);
		addMutation(IMutationsLib.EyeOfTheTigerIM);
		addMutation(IMutationsLib.CatLikeNimblenessIM);
		addMutation(IMutationsLib.DrakeLungsIM);
		
		buildTier(16, "dragonne")
				.namesMaleFemaleMorphTaur("dragonne-man", "dragonne-girl",
						"dragonne", "dragonne-taur")
				.buffs({
					"str.mult": +0.70,
					"tou.mult": +0.60,
					"spe.mult": +1.00,
					"int.mult": -0.20,
					"lib.mult": +0.30,
					"def": +1,
					"mdef": +1
				})
				.end();
		buildTier(24, "elder dragonne")
				.namesMaleFemaleMorphTaur("elder dragonne-man", "elder dragonne-girl",
						"elder dragonne", "elder dragonne-taur")
				.buffs({
					"str.mult": +1.05,
					"tou.mult": +0.90,
					"spe.mult": +1.50,
					"int.mult": -0.30,
					"lib.mult": +0.45,
					"def": +4,
					"mdef": +4
				})
				.end();
		buildTier(32, "ancient dragonne")
				.namesMaleFemaleMorphTaur("ancient dragonne-man", "ancient dragonne-girl",
						"ancient dragonne", "ancient dragonne-taur")
				.buffs({
					"str.mult": +1.40,
					"tou.mult": +1.20,
					"spe.mult": +2.00,
					"int.mult": -0.40,
					"lib.mult": +0.60,
					"def": +10,
					"mdef": +10
				})
				.end();
	}
}
}
