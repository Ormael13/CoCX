package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.MutationsLib;
import classes.PerkLib;
import classes.Race;

/**
 * Tier 1: goblin
 */
public class GoblinRace extends Race {
	public function GoblinRace(id:int) {
		super("goblin", id);
		
		addScores()
				.faceType(ANY(Face.HUMAN, Face.ANIMAL_TOOTHS), +1)
				.earType(Ears.ELFIN, +1)
				.earType(NOT(Ears.ELFIN), -100)
				.height(LESS_THAN(48), +1)
				.perk(PerkLib.GoblinoidBlood, +1)
				.perk(PerkLib.BouncyBody, +1)
				.perk(MutationsLib.NaturalPunchingBag, +1)
				.perk(MutationsLib.NaturalPunchingBagPrimitive, +1)
				.perk(MutationsLib.NaturalPunchingBagEvolved, +1)
				.skinPlainOnly(+1)
				.skinBaseColor(NONE("pale yellow", "grayish-blue", "green", "dark green", "emerald"), -100)
				.allPerks([MutationsLib.NaturalPunchingBag, PerkLib.ChimericalBodySemiImprovedStage], +1)
				.allPerks([MutationsLib.NaturalPunchingBagPrimitive, PerkLib.ChimericalBodySemiSuperiorStage], +1)
				.allPerks([MutationsLib.NaturalPunchingBagEvolved, PerkLib.ChimericalBodySemiEpicStage], +1)
				.hasVagina(+1);
		addConditionedScores(
				function (body:BodyData):Boolean {
					return body.player.hasPlainSkinOnly();
				},
				"plain skin; "
		)
				.skinBaseColor(ANY("pale yellow", "grayish-blue", "green", "dark green", "emerald"), +1)
				.eyeTypeOfColor(Eyes.HUMAN, ANY("red", "yellow", "purple"), +1)
				.hairColor(ANY("red", "purple", "green", "blue", "pink", "orange"), +1)
				.armType(Arms.HUMAN, +1)
				.legType(LowerBody.HUMAN, +1)
				.noAntennae(+1);
		buildTier(10, "goblin")
				.buffs({
					"str.mult": -0.50,
					"spe.mult": +0.75,
					"int.mult": +1.00,
					"lib.mult": +0.25
				})
				.end();
		
		addBloodline([PerkLib.GoblinsDescendant, PerkLib.BloodlineGoblin]);
	}
}
}
