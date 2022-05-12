package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.MutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;

public class CancerRace extends Race{
	public function CancerRace(id:int) {
        super("Cancer", id);
		
		addScores()
				.earType(Ears.HUMAN, +1)
				.hairType(Hair.NORMAL, +1)
				.eyeType(Eyes.CANCER, +1)
				.faceType(Face.KUDERE, +1)
				.hasStatusEffect(StatusEffects.CancerCrabStance, "Crab stance", +1)
				.legType(ANY(LowerBody.CRAB, LowerBody.CANCER), +1, -100)
				.legType(LowerBody.CANCER, +3)
				.noWings(+1)
				.eyeColor("orange", +1)
				.customRequirement("", "cancer genitals",
						function (body:BodyData):Boolean {
							return body.player.foamingCocks()>0 || body.vaginaType == VaginaClass.CANCER
						}, +1
						)
				.biggestTitSize(AT_MOST(3), +1)
				.mutationPerks([
					MutationsLib.TwinHeart,
					MutationsLib.TwinHeartPrimitive,
					MutationsLib.TwinHeartEvolved,
				], +2)
				.chimericalBodyPerks1([
					MutationsLib.TwinHeart,
					MutationsLib.TrachealSystem
				])
				.chimericalBodyPerks2([
					MutationsLib.TwinHeartPrimitive,
					MutationsLib.TrachealSystemPrimitive
				])
				.chimericalBodyPerks3([
					MutationsLib.TwinHeartEvolved,
					MutationsLib.TrachealSystemEvolved
				])
		;
		
		
		buildTier(13, "lesser cancer")
				.buffs({
					"str.mult": +1.05,
					"tou.mult": +0.80,
					"spe.mult": +0.55,
					"int.mult": -0.30,
					"wis.mult": -0.15
				})
				.end();
		
		buildTier(20, "cancer")
				.buffs({
					"str.mult": +1.25,
					"tou.mult": +1.15,
					"spe.mult": +1.05,
					"int.mult": -0.30,
					"wis.mult": -0.15
				})
				.end();
	}
}
}
