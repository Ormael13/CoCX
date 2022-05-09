package classes.Races {
import classes.BodyParts.*;
import classes.MutationsLib;
import classes.PerkLib;
import classes.Race;

/**
 * Tier 1: vampire
 * Tier 2: pureblood vampire
 */
public class VampireRace extends Race {
	public function VampireRace(id:int) {
		super("Vampire", id)
		
		addScores()
				.earType(NOT(Ears.BAT), 0, -10)
				.earType(Ears.VAMPIRE, -10)
				.wingType(Wings.VAMPIRE, +4)
				.faceType(Face.VAMPIRE, +2)
				.eyeType(Eyes.VAMPIRE, +1)
				.eyeColor("blood-red", +1)
				.skinBaseColor("pale", +1)
				.noTail(+1)
				.noHorns(+1)
				.noAntennae(+1)
				.mutationPerks([
					MutationsLib.VampiricBloodsteam,
					MutationsLib.VampiricBloodsteamPrimitive,
					MutationsLib.VampiricBloodsteamEvolved,
					MutationsLib.HollowFangs,
					MutationsLib.HollowFangsPrimitive,
					MutationsLib.HollowFangsEvolved
				])
				.chimericalBodyPerks1([MutationsLib.VampiricBloodsteam, MutationsLib.HollowFangs])
				.chimericalBodyPerks2([MutationsLib.VampiricBloodsteamPrimitive, MutationsLib.HollowFangsPrimitive])
				.chimericalBodyPerks3([MutationsLib.VampiricBloodsteamEvolved, MutationsLib.HollowFangsEvolved])
		addScoresAfter(8)
				.armType(Arms.HUMAN, +1)
				.legType(LowerBody.HUMAN, +1)
		addBloodline([PerkLib.VampiresDescendant,PerkLib.BloodlineVampire])
		
		buildTier(10, "vampire")
				.buffs({
					"str.mult": +0.35,
					"spe.mult": +0.35,
					"int.mult": +0.35,
					"lib.mult": +0.45
				})
				.end();
		
		buildTier(20, "pureblood vampire")
				.buffs({
					"str.mult": +0.70,
					"spe.mult": +0.70,
					"int.mult": +0.70,
					"lib.mult": +0.90
				})
				.end();
	}
}
}
