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
	
	public function JabberwockyRace(id:int) {
		super("Jabberwocky", id);
		mutationThreshold = 6;
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(ANY(Face.JABBERWOCKY, Face.BUCKTOOTH), +1, -1000)
				.faceType(NONE(Face.DRAGON, Face.DRAGON_FANGS), 0, -10)
				.eyeType(Eyes.DRACONIC, +1)
				.eyeColor("red", +1)
				.hairColor("purplish-pink", +1)
				.scaleColor(ANY(JabberwockyScaleColors), +1)
				.skinCoatType(Skin.DRAGON_SCALES, +1)
				.skinColor("caramel", +1)
				.hornType(Horns.JABBERWOCKY, +2)
				.earType(Ears.BUNNY, +1)
				.tailType(Tail.DRACONIC, +1)
				.tongueType(Tongue.DRACONIC, +1)
				.antennaeType(Antennae.JABBERWOCKY, +1)
				.wingType(Wings.FEY_DRAGON, +4, -1000)
				.legType(LowerBody.JABBERWOCKY, +1)
				.legType(NOT(LowerBody.FROSTWYRM), 0, -1000)
				.armType(Arms.JABBERWOCKY, +1)
				.hasCockOfType(CockTypesEnum.DRAGON, +1)
				.gender(Gender.GENDER_FEMALE, +1)
		addScoresAfter(5)
				.hasPerk(PerkLib.DragonLustPoisonBreath, +1)
				.hasPerk(PerkLib.Insanity, +1);
		addScoresAfter(10)
				.height(GREATER_THAN(120),+1);
		
		addMutation(IMutationsLib.DraconicBonesIM);
		addMutation(IMutationsLib.DraconicHeartIM);
		addMutation(IMutationsLib.DrakeLungsIM);
		addBloodline(PerkLib.DragonsDescendant,PerkLib.BloodlineDragon);
		
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
