package classes.Races {
import classes.BodyParts.*;
import classes.PerkLib;
import classes.Race;

/**
 * Tier 1: Incomplete Atlach Nacha
 * Tier 2: Atlach Nacha
 * Tier 3: Greater Atlach Nacha
 */
public class AtlachNachaRace extends Race{
	public function AtlachNachaRace(id:int) {
		super("Atlach Nacha", id);
		
		addScores()
				.legType(LowerBody.CHITINOUS_SPIDER_LEGS, +1)
				.legType(LowerBody.ATLACH_NACHA, +2)
				.armType(Arms.SPIDER, +1)
				.eyeType(Eyes.SPIDER, +1)
				.eyeTypeAndColor(Eyes.SPIDER, "red", +1)
				.tailType(Tail.SPIDER_ADBOMEN, +1)
				.rearType(RearBody.ATLACH_NACHA, +4)
				.faceType(Face.SPIDER_FANGS, +1)
				.skinCoatType(Skin.CHITIN, +1)
				.skinCoatTypeAndColor(Skin.CHITIN, "midnight purple", +1)
				.hairColor("midnight purple", +1)
				.earType(Ears.ELFIN, +1)
				.corruption(AT_LEAST(50), +1)
				.hasPerk(PerkLib.Insanity, +1)
				.hasPerk(PerkLib.SpiderOvipositor, +1)
				.hasPerk(PerkLib.TransformationImmunityAtlach, +3)
				/* these were commented in Player.atlachNachaScore()
				.mutationPerks([
					MutationsLib.ArachnidBookLung,
					MutationsLib.ArachnidBookLungPrimitive,
					MutationsLib.ArachnidBookLungEvolved,
				], +2)
				.mutationPerks([
					MutationsLib.TrachealSystem,
					MutationsLib.TrachealSystemPrimitive,
					MutationsLib.TrachealSystemEvolved,
					MutationsLib.TrachealSystemFinalForm
				], +1)
				.mutationPerks([
					MutationsLib.VenomGlands,
					MutationsLib.VenomGlandsPrimitive,
					MutationsLib.VenomGlandsEvolved
				], +1)
				*/
		
		buildTier(14, "incomplete Atlach Nacha")
				.buffs({
					"str.mult": +0.60,
					"int.mult": +1.00,
					"lib.mult": +0.40,
					"wis.mult": -0.10
				})
				.end()
		
		buildTier(21, "Atlach Nacha")
				.buffs({
					"str.mult": +2.80,
					"tou.mult": +3.15,
					"int.mult": +3.50,
					"lib.mult": +3.50,
					"wis.mult": -0.50,
					"sens": +90
				})
				.end()
		
		/* Not Yet Implemented
		buildTier(30, "greater Atlach Nacha")
				.buffs({
					"str.mult": +1.15,
					"tou.mult": +1.35,
					"int.mult": +1.50,
					"lib.mult": +1.50,
					"wis.mult": -0.50,
					"sens": +50
				})
				.end()
				
		 */
	}
}
}
