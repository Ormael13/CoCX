package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.MutationsLib;
import classes.PerkLib;
import classes.Race;
public class RatatoskrRace extends Race{
	public static const RatatoskrHairColors:/*String*/Array = ["brown", "light brown", "caramel", "chocolate", "russet"];
	
	public function RatatoskrRace(id:int) {
		super("Ratatoskr", id);
		
		addScores()
				.earType(Ears.SQUIRREL, +1)
				.eyeType(Eyes.RATATOSKR, +1)
				.eyeColor(ANY("green","light green","emerald"), +1)
				.faceType(ANY(Face.SMUG, Face.SQUIRREL), +1)
				.armType(Arms.SQUIRREL, +1)
				.tongueType(Tongue.RATATOSKR, +1)
				.legType(LowerBody.SQUIRREL, +1)
				.tailType(Tail.SQUIRREL, +1)
				.noWings(+1)
				.noRearBody(+1)
				.hairType(Hair.RATATOSKR, +1)
				.hairColor(ANY(RatatoskrHairColors), +1)
				.skinCoatType(Skin.FUR, +1)
				.skinCoatColor(ANY(RatatoskrHairColors), +1)
				.height(LESS_THAN(48), +1)
				.mutationPerks([
					MutationsLib.RatatoskrSmarts,
					MutationsLib.RatatoskrSmartsPrimitive,
					MutationsLib.RatatoskrSmartsEvolved
				])
				.chimericalBodyPerks1([
					MutationsLib.RatatoskrSmarts
				])
				.chimericalBodyPerks2([
					MutationsLib.RatatoskrSmartsPrimitive
				])
				.chimericalBodyPerks3([
					MutationsLib.RatatoskrSmartsEvolved
				]);
		//if (hasPerk(PerkLib.RatatoskrsDescendant) || hasPerk(PerkLib.BloodlineRatatoskr))
		//	ratatoskrCounter += increaseFromBloodlinePerks();
		
		buildTier(12, "squirrel morph")
				.tauricName("squirrel-taur")
				.buffs({
					"str.mult": -0.20,
					"spe.mult": +0.95,
					"int.mult": +1.05
				})
				.end();
		
		buildTier(18, "ratatoskr")
				.tauricName("ratatoskr-taur")
				.buffs({
					"str.mult": -0.25,
					"spe.mult": +1.40,
					"int.mult": +1.55
				})
				.end();
	}
}
}
