package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.MutationsLib;
import classes.PerkLib;
import classes.Race;

public class CatRace extends Race {
	
	public function CatRace(id:int) {
		super("Cat", id);
		
		addScores()
				.faceType(ANY(Face.CAT,Face.CAT_CANINES), +1)
				.faceType(NONE(Face.CHESHIRE,Face.CHESHIRE_SMILE), 0, -7)
				.eyeType(Eyes.CAT,+1)
				.eyeType(Eyes.FERAL, -11)
				.earType(Ears.CAT,+1)
				.tongueType(Tongue.CAT, +1)
				.tailType(Tail.CAT, +1)
				.armType(Arms.CAT, +1)
				.legType(LowerBody.CAT, +1)
				.skinCoatType(Skin.FUR, +1)
				.hornType(NONE(Horns.DEMON,Horns.DRACONIC_X2,Horns.DRACONIC_X4_12_INCH_LONG), 0, -2)
				.wingType(NONE(Wings.BAT_LIKE_TINY,Wings.DRACONIC_SMALL,Wings.BAT_LIKE_LARGE,Wings.DRACONIC_LARGE,Wings.BAT_LIKE_LARGE_2,Wings.DRACONIC_HUGE),0,-2)
				.hasCockOfType(CockTypesEnum.CAT, +1)
				.breastRowCount(2, +1)
				.breastRowCount(3, +2)
				.breastRowCount(LESS_THAN(4), 0, -1)
				.customRequirement("","not magical feline race",
						function (body:BodyData):Boolean {
							return !(body.armType == Arms.SPHINX
									|| body.wingType == Wings.FEATHERED_SPHINX
									|| body.tailType == Tail.MANTICORE_PUSSYTAIL
									|| body.tailType == Tail.NEKOMATA_FORKED_1_3
									|| body.tailType == Tail.NEKOMATA_FORKED_2_3
									|| (body.tailType == Tail.CAT && body.tailCount > 1)
									|| body.rearType == RearBody.LION_MANE
									|| (body.hairColor == "lilac and white striped" && body.skinCoatColor == "lilac and white striped")
									|| body.eyeType == Eyes.INFERNAL
									|| body.hairType == Hair.BURNING
									|| body.tailType == Tail.BURNING
									|| body.eyeType == Eyes.DISPLACER
									|| body.earType == Ears.DISPLACER
									|| body.armType == Arms.DISPLACER
									|| body.rearType == RearBody.DISPLACER_TENTACLES);
						},0,-100
						)
				.hasPerk(PerkLib.Flexibility, +1)
				.mutationPerks([
					MutationsLib.CatlikeNimbleness,
					MutationsLib.CatlikeNimblenessPrimitive,
					MutationsLib.CatlikeNimblenessEvolved
				])
				.chimericalBodyPerks1([
					MutationsLib.CatlikeNimbleness
				])
				.chimericalBodyPerks2([
					MutationsLib.CatlikeNimblenessPrimitive
				])
				.chimericalBodyPerks3([
					MutationsLib.CatlikeNimblenessEvolved
				])
		;
		
		buildTier(8, "cat")
				.customNamingFunction(function(body:BodyData):String {
					if (body.isTaur && body.legType == LowerBody.CAT) return "cat-taur";
					if (body.faceType == Face.HUMAN) return "cat-morph";
					return "cat-"+body.mf("boy","girl")
				})
				.buffs({
					"spe.mult": +0.60, // TODO @aimozg +10 more if has PerkLib.Flexibility
					"lib.mult": +0.60
				})
				.end();
	}
}
}
