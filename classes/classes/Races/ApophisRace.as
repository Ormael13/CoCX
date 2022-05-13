package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.MutationsLib;
import classes.Race;
import classes.VaginaClass;

public class ApophisRace extends Race {
	public static const ApophisScaleColors:/*String*/Array = ["black", "midnight", "midnight black"];
	public static const ApophisHairColors:/*String*/Array = ["black", "midnight", "midnight black"];
	
	public function ApophisRace(id:int) {
		super("Apophis", id);
		
		addScores()
				.isNaga(+3, -100)
				.armType(Arms.HUMAN, +1)
				.hairColor(ANY(ApophisHairColors), +1)
				.skinBaseColor("light purple", +1)
				.skinCoatType(Skin.SCALES, +1)
				.skinCoatColor(ANY(ApophisScaleColors), +1)
				.tongueType(Tongue.SNAKE, +1)
				.faceType(Face.SNAKE_FANGS, +1)
				.eyeTypeAndColor(Eyes.SNAKEFIENDISH, "yellow", +2)
				.earType(Ears.SNAKE, +1)
				.rearType(RearBody.COBRA_HOOD, +1)
				.noWings(+4)
				.customRequirement("","naga vagina or lizard cock",
						function (body:BodyData):Boolean {
							return body.vaginaType == VaginaClass.NAGA || body.player.lizardCocks() > 0;
						}, +1)
				.corruption(AT_LEAST(20), +1)
				.corruption(AT_LEAST(50), +1)
				.corruption(AT_LEAST(100), +2)
				.mutationPerks([
					MutationsLib.VenomGlands,
					MutationsLib.VenomGlandsPrimitive,
					MutationsLib.VenomGlandsEvolved,
				])
				.chimericalBodyPerks1([
					MutationsLib.VenomGlands
				])
				.chimericalBodyPerks2([
					MutationsLib.VenomGlandsPrimitive
				])
				.chimericalBodyPerks3([
					MutationsLib.VenomGlandsEvolved
				])
				.customRequirement("","not another snake-like race",
						function (body:BodyData):Boolean {
							return !(body.hairType == Hair.GORGON
									|| body.eyeType == Eyes.GORGON
									|| body.hornType == Horns.DRACONIC_X4_12_INCH_LONG
									|| body.hornType == Horns.DRACONIC_X2
									|| body.tongueType == Tongue.DRACONIC
									|| body.wingType == Wings.DRACONIC_SMALL
									|| body.wingType == Wings.DRACONIC_LARGE
									|| body.wingType == Wings.DRACONIC_HUGE
									|| body.hairType == Hair.FEATHER
									|| body.armType == Arms.HARPY
									|| body.wingType == Wings.FEATHERED_LARGE
									|| body.legType == LowerBody.HYDRA
									|| body.armType == Arms.HYDRA);
						}, 0, -100)
		
		buildTier(23, "apophis")
				.buffs({
					"str.mult": +0.70,
					"tou.mult": +0.70,
					"spe.mult": +1.00,
					"lib.mult": +1.05
				})
				.end();
		
		buildTier(26, "unhallowed apophis")
				.buffs({
					"str.mult": +0.80,
					"tou.mult": +0.80,
					"spe.mult": +1.00,
					"lib.mult": +1.30
				})
				.end();
	}
}
}
