package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.MutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

/**
 * Tier 1: manticore
 * Tier 2: true manticore
 */
public class ManticoreRace extends Race {
	public function ManticoreRace(id:int) {
		super("Manticore", id);
		
		addScores()
				.faceType(Face.MANTICORE, +1)
				.eyeType(Eyes.MANTICORE, +1)
				.earType(Ears.LION, +1)
				.tailType(Tail.MANTICORE_PUSSYTAIL, +2, -100)
				.rearType(RearBody.LION_MANE, +1)
				.armType(Arms.LION, +1)
				.legType(LowerBody.LION, +1)
				.tongueType(Tongue.CAT, +1)
				.wingType(Wings.MANTICORE_SMALL, +1)
				.wingType(Wings.MANTICORE_LARGE, +4)
				.noCock(+1, -3)
				.vaginaType(VaginaClass.MANTICORE, +1)
				.corruption(AT_LEAST(20), +1)
				.mutationPerks([
					MutationsLib.CatlikeNimbleness,
					MutationsLib.CatlikeNimblenessPrimitive,
					MutationsLib.CatlikeNimblenessEvolved,
					MutationsLib.ManticoreMetabolism,
					MutationsLib.ManticoreMetabolismPrimitive,
					MutationsLib.ManticoreMetabolismEvolved
				])
				.chimericalBodyPerks1([
					MutationsLib.CatlikeNimbleness,
					MutationsLib.ManticoreMetabolism
				])
				.chimericalBodyPerks2([
					MutationsLib.CatlikeNimblenessPrimitive,
					MutationsLib.ManticoreMetabolismPrimitive
				])
				.chimericalBodyPerks3([
					MutationsLib.CatlikeNimblenessEvolved,
					MutationsLib.ManticoreMetabolismEvolved
				]);
		
		buildTier(15, "manticore")
				.customNamingFunction(function(body:BodyData):String {
					if (body.isTaur && body.legType == LowerBody.LION) return "manticore-taur";
					return "manticore"
				})
				.buffs({
					"spe.mult": +1.10,
					"int.mult": +0.70,
					"lib.mult": +0.90,
					"sens": +45,
					"maxhp_base": +75
				})
				.end()
		
		buildTier(22, "true manticore")
				.customNamingFunction(function(body:BodyData):String {
					if (body.isTaur && body.legType == LowerBody.LION) return "true manticore-taur";
					return "true manticore"
				})
				.buffs({
					"spe.mult": +1.60,
					"int.mult": +0.90,
					"lib.mult": +1.40,
					"sens": +60,
					"maxhp_base": +150
				})
				.end()
	}
}
}
