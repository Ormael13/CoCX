package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class KitshooRace extends Race {
	public static const KitshooHairColors:/*String*/Array = ["white", "black", "red", "orange"];
	//public static const KitshooScaleColors:/*String*/Array = ["red", "blazing red", "orange", "reddish-orange"];
	public static const KitshooSkinColors:/*String*/Array = ["tan", "olive", "light"];
	public static const ElderKitshooSkinColors:/*String*/Array = ["dark", "ebony", "ashen", "sable", "milky white"];
	
	public function KitshooRace(id:int) {
		super("Kitshoo", id);
		mutationThreshold = 6;
	}
	
	public override function setup():void {
		addScores()
				.earType(Ears.FOX, +1)
				.customScoreRequirement("tail", "multiple cinder fox tails, +1 per tail",
						function (body:BodyData):Boolean {
							return body.tailType == Tail.KITSHOO && body.tailCount >= 2;
						},
						function (body:BodyData):int {
							return body.tailCount;
						},
						-7
				)
				.faceType(Face.SALAMANDER_FANGS, +1)
				.armType(Arms.SALAMANDER, +1)
				.legType(LowerBody.SALAMANDER, +1)
		//		.skinCoatTypeAndColor(Skin.FUR, ANY(KitsuneRace.KitshooHairColors), +1)
				.skinCoatType(NOT(Skin.CHITIN), 0, -2)
				.skinBaseType(NOT(Skin.GOO), 0, -3)
				.hasPerk(PerkLib.Lustzerker, +1)
		addScoresAfter(5)
				.skinBaseType(Skin.PLAIN, +1, -1)
				.skinBasePattern(Skin.PATTERN_MAGICAL_TATTOO, +1, -1)
				.hairColor(ANY(KitshooHairColors), +1)
		
		addMutation(IMutationsLib.KitsuneThyroidGlandIM);
		addMutation(IMutationsLib.KitsuneParathyroidGlandsIM);
		addMutation(IMutationsLib.SalamanderAdrenalGlandsIM);
		
		buildTier(8, "kitshoo")
				.namesTauric("kitshoo", "kitshoo-taur")
				.buffs({
					"tou.mult": +0.15,
					"spe.mult": +0.15,
					"int.mult": +0.40,
					"wis.mult": +0.50,
					"lib.mult": +0.50,
					"sens": +50,
					"maxlust_base": +20,
					"maxsf_mult": +0.15
				})
				.end();
	}
}
}
