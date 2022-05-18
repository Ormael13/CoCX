package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

/**
 * Tier 1: goblin
 */
public class GoblinRace extends Race {
	public static const GoblinSkinColors:/*String*/Array = ["pale yellow", "grayish-blue", "green", "dark green", "emerald"];
	public static const GoblinEyeColors:/*String*/Array = ["red", "yellow", "purple"];
	public static const GoblinHairColors:/*String*/Array = ["red", "purple", "green", "blue", "pink", "orange"];
	
	public function GoblinRace(id:int) {
		super("Goblin", id);
		
		addScores()
				.faceType(ANY(Face.HUMAN, Face.ANIMAL_TOOTHS), +1)
				.earType(Ears.ELFIN, +1, -100)
				.height(LESS_THAN(48), +1)
				.hasPerk(PerkLib.GoblinoidBlood, +1)
				.hasPerk(PerkLib.BouncyBody, +1)
				.skinPlainOnly(+1)
				.skinBaseColor(ANY(GoblinSkinColors), +1, -100)
				.hasVagina(+1);
		addConditionedScores(
				function (body:BodyData):Boolean {
					return body.player.hasPlainSkinOnly();
				},
				"plain skin; "
		)
				.eyeTypeAndColor(Eyes.HUMAN, ANY(GoblinEyeColors), +1)
				.hairColor(ANY(GoblinHairColors), +1)
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
