package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.lists.Gender;

public class FaerieDragonRace extends Race {
	public static const DragonScaleColors:Array = ["red", "golden", "metallic golden", "metallic silver", "silver", "snow white", "green", "blue", "bronzed", "black", "midnight", "pinkish purple"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Elf",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Elven",
        /*Eyes*/		"Elf",
        /*Face*/		"Elf",
        /*Gills*/		"None",
        /*Hair*/		"Elf",
        /*Horns*/		"Human",
        /*LowerBody*/	"Elf",
        /*RearBody*/	"Human",
        /*Skin*/		"Elf",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Elf",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Elf"];

	public function FaerieDragonRace(id:int) {
		super("Faerie Dragon", id, []);//RaceBody);
		mutationThreshold = 6;
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(ANY(Face.DRAGON, Face.DRAGON_FANGS), +1)
				.faceType(NONE(Face.JABBERWOCKY, Face.BUCKTOOTH, Face.PLANT_DRAGON, Face.CAT, Face.CAT_CANINES), 0, -10)
				.skinCoatTypeAndColor1(Skin.DRAGON_SCALES, "pinkish purple", +2)
				.hairColor1("pink", +1)
				.eyeType(Eyes.DRACONIC, +1)
				.eyeType(NOT(Eyes.CAT), 0, -10)
				.earType(Ears.DRAGON, +1)
				.earType(NOT(Ears.CAT), 0, -10)
				.tailType(Tail.FEY_DRACONIC, +1)
				.tongueType(Tongue.DRACONIC, +1)
				.wingType(Wings.FEY_DRAGON, +6)
				.wingType(NONE(Wings.DRACONIC_SMALL, Wings.DRACONIC_LARGE, Wings.DRACONIC_HUGE), 0, -10)
				.legType(LowerBody.FEY_DRAGON, +1)
				.legType(NOT(LowerBody.FROSTWYRM), 0, -10)
				.armType(Arms.FEY_DRACONIC, +1)
				.armType(NONE(Arms.DRACONIC, Arms.LION), 0, -10)
				.hornType(Horns.DRACONIC_X2, +1)
				.hornType(Horns.DRACONIC_X4_12_INCH_LONG, +2)
				.hornType(NOT(Horns.FROSTWYRM), 0, -3)
				.hasCockOfType(CockTypesEnum.DRAGON, +1)
				.gender(Gender.GENDER_FEMALE, +1)
				.hasPerk(PerkLib.Dracoforce, +1);
		//addScoresAfter(8)
		//		.height(GREATER_THAN(120), +1);//maybe less than X?
		
		addBloodline(PerkLib.DragonsDescendant,PerkLib.BloodlineDragon);
		addMutation(IMutationsLib.FeyArcaneBloodstreamIM);
		addMutation(IMutationsLib.DrakeBonesIM);
		addMutation(IMutationsLib.DrakeHeartIM);
		addMutation(IMutationsLib.DrakeLungsIM);
		
		buildTier(15, "faerie dragon")
				.buffs({
					"maxhp_mult": +0.05,
					"str.mult": +0.35,
					"tou.mult": +0.50,
					"spe.mult": +0.60,
					"int.mult": +0.90,
					"wis.mult": -0.10,
					"def": +1,
					"mdef": +1
				})
				.end();
		
		buildTier(23, "elder faerie dragon")
				.buffs({
					"maxhp_mult": +0.10,
					"str.mult": +0.55,
					"tou.mult": +0.75,
					"spe.mult": +0.90,
					"int.mult": +1.45,
					"wis.mult": -0.20,
					"def": +4,
					"mdef": +4
				})
				.end();
		
		buildTier(31, "ancient faerie dragon")
				.buffs({
					"maxhp_mult": +0.15,
					"str.mult": +0.75,
					"tou.mult": +1.00,
					"spe.mult": +1.20,
					"int.mult": +2.00,
					"wis.mult": -0.30,
					"def": +7,
					"mdef": +7
				})
				.end();
	}
}
}