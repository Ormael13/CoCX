package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.MutationsLib;
import classes.PerkLib;
import classes.Race;
public class HellcatRace extends Race{
	public function HellcatRace(id:int) {
		super("Hellcat", id);
		
		addScores()
				.faceType(ANY(Face.CAT, Face.CAT_CANINES), +1)
				.eyeType(Eyes.INFERNAL, +1, -100)
				.earType(Ears.CAT, +1)
				.tongueType(Tongue.CAT, +1)
				.hairType(Hair.BURNING, +1, -100)
				.tailType(ANY(Tail.BURNING, Tail.TWINKASHA), +1, -100)
				.tailTypeAndCount(Tail.TWINKASHA, 2, +2)
				.armType(Arms.CAT, +1)
				.legType(LowerBody.CAT, +1)
				.skinCoatType(Skin.FUR, +1)
				.skinCoatColor("midnight black", +1)
				.skinBaseColor("ashen", +1)
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
				.customRequirement("","not other magical feline race",
						function (body:BodyData):Boolean {
							return !(CatRace.isSphinxLike(body)
									|| body.tailType == Tail.MANTICORE_PUSSYTAIL
									|| body.rearType == RearBody.LION_MANE
									|| CatRace.isNekomataLike(body)
									|| CatRace.isCheshireLike(body)
									|| CatRace.isDisplacerLike(body));
						},0,-100
				);
		// TODO @aimozg +10% speed if has Flexibility perk
		buildTier(10, "hellcat")
				.buffs({
					"spe.mult": +0.40,
					"int.mult": +0.85,
					"lib.mult": +0.50,
					"sens": +25
				})
				.end();
		
		buildTier(17, "Kasha")
				.buffs({
					"spe.mult": +0.70,
					"int.mult": +1.35,
					"lib.mult": +1.00,
					"sens": +50
				})
				.end();
	}
}
}
