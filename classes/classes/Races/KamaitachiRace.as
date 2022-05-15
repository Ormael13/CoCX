package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.MutationsLib;
import classes.PerkLib;
import classes.Race;

public class KamaitachiRace extends Race {
	public static const KamaitachiHairColors:/*String*/Array = ["blonde", "yellow", "caramel", "brown", "emerald"];
	public static const KamaitachiFurColors:/*String*/Array = KamaitachiHairColors;
	public function KamaitachiRace(id:int) {
		super("Kamaitachi", id);
		
		addScores()
				.earType(Ears.WEASEL, +1)
				.eyeType(Eyes.WEASEL, +1)
				.eyeColor("golden", +1)
				.faceType(Face.WEASEL, +1)
				.armType(Arms.KAMAITACHI, +1)
				.skinCoatType(Skin.FUR, +1)
				.wingType(Wings.WINDY_AURA, +3)
				.legType(LowerBody.WEASEL,1)
				.tailType(Tail.WEASEL, +1)
				.skinBasePattern(Skin.PATTERN_SCAR_WINDSWEPT, +1)
				.hairType(Hair.WINDSWEPT, +1)
				.hairColor(ANY(KamaitachiHairColors), +1)
				.skinCoatColor(ANY(KamaitachiHairColors), +1)
				.mutationPerks([
					MutationsLib.HeartOfTheStorm,
					MutationsLib.HeartOfTheStormPrimitive,
					MutationsLib.HeartOfTheStormEvolved
				])
				.chimericalBodyPerks1([
					MutationsLib.HeartOfTheStorm
				])
				.chimericalBodyPerks2([
					MutationsLib.HeartOfTheStormPrimitive
				])
				.chimericalBodyPerks3([
					MutationsLib.HeartOfTheStormEvolved
				])
		
		buildTier(14, "kamaitachi")
				.tauricName("kamaitachi-taur")
				.buffs({
					"str.mult": -0.20,
					"spe.mult": +1.40,
					"int.mult": +0.45,
					"wis.mult": +0.70,
					"sens": +25
				})
				.end();
		
		buildTier(18, "greater kamaitachi")
				.tauricName("greater kamaitachi-taur")
				.buffs({
					"str.mult": -0.35,
					"spe.mult": +2.00,
					"int.mult": +0.55,
					"wis.mult": +1.00,
					"sens": +50
				})
				.end();
	}
}
}
