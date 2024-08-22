package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.lists.Gender;

public class JabberwockyRace extends Race {
	public static const JabberwockyScaleColors:/*String*/Array = ["magenta", "pink"];
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
	
	public function JabberwockyRace(id:int) {
		super("Jabberwocky", id, []);//RaceBody);
		mutationThreshold = 6;
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(ANY(Face.JABBERWOCKY, Face.BUCKTOOTH), +1, -1000)
				.faceType(NONE(Face.DRAGON, Face.DRAGON_FANGS, Face.CAT, Face.CAT_CANINES), 0, -10)
				.eyeType(Eyes.DRACONIC, +1)
				.eyeType(NOT(Eyes.CAT), 0, -10)
				.eyeColor("red", +1)
				.hairColor1("purplish-pink", +1)
				.scaleColor1(ANY(JabberwockyScaleColors), +1)
				.skinCoatType(Skin.DRAGON_SCALES, +1)
				.skinColor1("caramel", +1)
				.hornType(Horns.JABBERWOCKY, +2)
				.earType(Ears.BUNNY, +1)
				.tailType(Tail.DRACONIC, +1)
				.tongueType(Tongue.DRACONIC, +1)
				.antennaeType(Antennae.JABBERWOCKY, +1)
				.wingType(Wings.JABBERWOCKY, +4, -1000)
				.legType(LowerBody.JABBERWOCKY, +1)
				.legType(NONE(LowerBody.FROSTWYRM, LowerBody.FEY_DRAGON, LowerBody.LION), 0, -1000)
				.armType(Arms.JABBERWOCKY, +1)
				.armType(NONE(Arms.DRACONIC, Arms.FEY_DRACONIC, Arms.LION), 0, -10)
				.hasCockOfType(CockTypesEnum.DRAGON, +1)
				.gender(Gender.GENDER_FEMALE, +1)
		addScoresAfter(5)
				.hasPerk(PerkLib.DragonLustPoisonBreath, +1)
				.hasPerk(PerkLib.Insanity, +1);
		addScoresAfter(10)
				.height(GREATER_THAN(120),+1)
				.hasPerk(PerkLib.Dracoforce, +1);
		
		addBloodline(PerkLib.DragonsDescendant,PerkLib.BloodlineDragon);
		addMutation(IMutationsLib.DrakeBloodIM);
		addMutation(IMutationsLib.DrakeBonesIM);
		addMutation(IMutationsLib.DrakeHeartIM);
		addMutation(IMutationsLib.DrakeLungsIM);
		addMutation(IMutationsLib.MightyLegsIM);
		
		buildTier(10, "lesser jabberwocky")
				.namesTauric("lesser jabberwocky", "lesser jabberwocky-taur")
				.buffs({
					"str.mult": +0.50,
					"tou.mult": +0.40,
					"spe.mult": +0.50,
					"int.mult": +0.20,
					"wis.mult": -0.20,
					"lib.mult": +0.10
				})
				.end();
		
		buildTier(20, "jabberwocky")
				.namesTauric("jabberwocky", "jabberwocky-taur")
				.buffs({
					"str.mult": +0.90,
					"tou.mult": +0.70,
					"spe.mult": +0.80,
					"int.mult": +0.30,
					"wis.mult": -0.30,
					"lib.mult": +0.60
				})
				.end();
		
		buildTier(25, "greater jabberwocky")
				.namesTauric("greater jabberwocky", "greater jabberwocky-taur")
				.buffs({
					"str.mult": +1.05,
					"tou.mult": +0.80,
					"spe.mult": +0.90,
					"int.mult": +0.40,
					"wis.mult": -0.40,
					"lib.mult": +1.00
				})
				.end();
		
		buildTier(30, "primal jabberwocky")
				.namesTauric("primal jabberwocky", "primal jabberwocky-taur")
				.buffs({
					"str.mult": +1.25,
					"tou.mult": +0.95,
					"spe.mult": +1.00,
					"int.mult": +0.40,
					"wis.mult": -0.50,
					"lib.mult": +1.40
				})
				.end();
	}
}
}
