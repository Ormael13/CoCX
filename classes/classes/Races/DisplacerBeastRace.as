package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class DisplacerBeastRace extends Race {
	public static const DisplacerFurColors:/*String*/Array = ["black", "midnight black", "midnight"];
	
	public function DisplacerBeastRace(id:int) {
		super("Displacer beast", id);
		
		addScores()
				.faceType(ANY(Face.CAT,Face.CAT_CANINES), +1)
				.eyeTypeAndColor(Eyes.DISPLACER, "yellow", +1)
				.tongueType(Tongue.CAT, +1)
				.earType(Ears.DISPLACER, +1)
				.tailType(Tail.CAT, +1)
				.legType(LowerBody.LION, +1)
				.armType(Arms.DISPLACER, +3, -100)
				.rearType(RearBody.DISPLACER_TENTACLES, +2, -100)
				.skinCoatType(Skin.FUR, +1)
				.skinCoatColor(ANY(DisplacerFurColors), +1)
				.skinBaseColor("dark gray", +1)
				.hasPerk(PerkLib.Flexibility, +1)
				.customRequirement("","not other magical feline race",
						function (body:BodyData):Boolean {
							return !(CatRace.isSphinxLike(body)
									|| body.tailType == Tail.MANTICORE_PUSSYTAIL
									|| CatRace.isNekomataLike(body)
									|| body.rearType == RearBody.LION_MANE
									|| CatRace.isCheshireLike(body)
									|| CatRace.isHellcatLike(body));
						},0,-100
				);
		
		addMutation(IMutationsLib.CatLikeNimblenessIM);
		addMutation(IMutationsLib.DisplacerMetabolismIM);
		
		// TODO @aimozg extra +10% speed if has Flexibility perk
		buildTier(14, "displacer beast")
				.buffs({
					"str.mult": +0.95,
					"spe.mult": +1.00,
					"int.mult": -0.25,
					"wis.mult": -0.20,
					"lib.mult": +0.80
				})
				.end()
		
		buildTier(20, "elder displacer beast")
				.buffs({
					"str.mult": +1.40,
					"spe.mult": +1.40,
					"int.mult": -0.30,
					"wis.mult": -0.30,
					"lib.mult": +0.80
				})
				.end()
	}
}
}
