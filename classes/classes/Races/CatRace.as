package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
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
							return !(isSphinxLike(body)
									|| body.tailType == Tail.MANTICORE_PUSSYTAIL
									|| isNekomataLike(body)
									|| body.rearType == RearBody.LION_MANE
									|| isCheshireLike(body)
									|| isHellcatLike(body)
									|| isDisplacerLike(body));
						},0,-100
						)
				.hasPerk(PerkLib.Flexibility, +1);
		
		addMutation(IMutationsLib.CatLikeNimblenessIM);
		
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
	
	public static function isNekomataLike(body:BodyData):Boolean {
		return body.tailType == Tail.NEKOMATA_FORKED_1_3
				|| body.tailType == Tail.NEKOMATA_FORKED_2_3
				|| (body.tailType == Tail.CAT && body.tailCount > 1);
	}
	public static function isHellcatLike(body:BodyData):Boolean {
		return body.eyeType == Eyes.INFERNAL
				|| body.hairType == Hair.BURNING
				|| body.tailType == Tail.BURNING
				|| body.tailType == Tail.TWINKASHA;
	}
	public static function isCheshireLike(body:BodyData):Boolean {
		return (body.hairColor == "lilac and white striped" && body.skinCoatColor == "lilac and white striped");
	}
	public static function isSphinxLike(body:BodyData):Boolean {
		return body.armType == Arms.SPHINX
				|| body.wingType == Wings.FEATHERED_SPHINX;
	}
	public static function isDisplacerLike(body:BodyData):Boolean {
		return body.eyeType == Eyes.DISPLACER
				|| body.earType == Ears.DISPLACER
				|| body.armType == Arms.DISPLACER
				|| body.rearType == RearBody.DISPLACER_TENTACLES;
	}
}
}
