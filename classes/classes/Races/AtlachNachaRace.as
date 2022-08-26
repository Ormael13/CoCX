package classes.Races {
import classes.BodyParts.*;
import classes.CoC;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Player;
import classes.Race;

/**
 * Tier 1: Incomplete Atlach Nacha
 * Tier 2: Atlach Nacha
 * Tier 3: Greater Atlach Nacha
 */
public class AtlachNachaRace extends Race{
    public static const AtlachNachaHairColors:/*String*/Array = ["midnight purple"];
    public static const AtlachNachaChitinColors:/*String*/Array = ["midnight purple"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Spider",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Elfin",
        /*Eyes*/		"AtlachNacha",
        /*Face*/		"Spider",
        /*Gills*/		"None",
        /*Hair*/		"AtlachNacha",
        /*Horns*/		"Human",
        /*LowerBody*/	"AtlachNacha",
        /*RearBody*/	"AtlachNacha",
        /*Skin*/		"AtlachNacha",
        /*Ovipositor*/	"Spider",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Spider",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"AtlachNacha"];

	public function AtlachNachaRace(id:int) {
		super("Atlach Nacha", id, RaceBody);
	}
	
	public override function setup():void {
		
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
				.skinCoatTypeAndColor1(Skin.CHITIN, "midnight purple", +1)
				.hairColor1("midnight purple", +1)
				.earType(Ears.ELFIN, +1)
				.corruption(AT_LEAST(50), +1)
				.hasPerk(PerkLib.Insanity, +1)
				.hasPerk(PerkLib.SpiderOvipositor, +1)
				.hasPerk(PerkLib.TransformationImmunityAtlach, +3);
		
		addMutation(IMutationsLib.ArachnidBookLungIM)
		addMutation(IMutationsLib.TrachealSystemIM);
		addMutation(IMutationsLib.VenomGlandsIM);
		
		buildTier(14, "Incomplete Atlach Nacha")
				.buffs({
					"str.mult": +0.60,
					"int.mult": +1.00,
					"lib.mult": +0.40,
					"wis.mult": -0.10
				})
				.end()
		buildTier(20, "Half Atlach Nacha")
				.buffs({
					"str.mult": +1.40,
                    "tou.mult": +2.20,
					"int.mult": +2.20,
					"lib.mult": +2.20,
					"wis.mult": -0.25,
                    "sens": +60
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
				.requirePerk(PerkLib.Insanity)
				.requirePerk(PerkLib.TransformationImmunityAtlach)
				.end()
		
		buildTier(30, "Greater Atlach Nacha")
                .requirePreviousTier()
				.buffs({
					"str.mult": +3.40,
					"tou.mult": +4.00,
					"int.mult": +4.25,
					"lib.mult": +4.25,
					"wis.mult": -0.90,
					"sens": +150
				})
				.end()
	}
	
	public static function fullTfCheck(player:Player):Boolean {
		return player.lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS
				&& player.arms.type == Arms.SPIDER
				&& player.eyes.type == Eyes.SPIDER
				&& player.ears.type == Ears.ELFIN
				&& player.rearBody.type == RearBody.ATLACH_NACHA
				&& player.faceType == Face.SPIDER_FANGS
				&& player.hasCoatOfType(Skin.CHITIN)
				&& player.eyes.colour == "red"
				&& player.chitinColor == "midnight purple"
				&& player.hairColor == "midnight purple";
	}
}
}
