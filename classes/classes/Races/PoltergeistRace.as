package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.GeneticMemories.RaceMem;
import classes.PerkLib;
import classes.Race;

/**
 * Tier 1: Phantom
 * Tier 2: Poltergeist
 * Tier 3: Eldritch Poltergeist
 */

public class PoltergeistRace extends Race{
	public static const PoltergeistSkinColors:/*String*/Array = ["sable", "white"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Ghost",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Human",
        /*Eyes*/		"Ghost",
        /*Face*/		"Ghost",
        /*Gills*/		"Human",
        /*Hair*/		"Ghost",
        /*Horns*/		"Ghost",
        /*LowerBody*/	"Ghost2",
        /*RearBody*/	"Ghost",
        /*Skin*/		"Ghost",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Ghost",
        /*Wings*/		"Ghost",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Ghost"];

	public function PoltergeistRace(id:int) {
		super("Poltergeist", id, RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		
		addScores()
				.hairType(Hair.GHOST, +1)
				.eyeType(Eyes.GHOST, +1)
				.faceType(Face.GHOST, +1)
				.tongueType(Tongue.GHOST, +1)
				.hornType(Horns.GHOSTLY_WISPS, +1)
				.armType(Arms.GHOST, +1)
				.legType(LowerBody.GHOST, +1)
				.legType(LowerBody.GHOST_2, +2)
				.wingType(Wings.ETHEREAL, +2)
				.noTail(+1)
				.noAntennae(+1)
				.rearType(RearBody.GHOSTLY_AURA, +1)
				.skinBasePattern(Skin.PATTERN_WHITE_BLACK_VEINS, +1)
				.customRequirement("skin",
						"milky white or ashen sable, plain skin",
						function (body:BodyData):Boolean {
							return body.player.hasPlainSkinOnly() &&
									(body.skinBaseAdj == "milky" && body.skinColor1 == "white" ||
											body.skinBaseAdj == "ashen" && body.skinColor1 == "sable")
						}, +1)
				.customRequirement("skin",
						"milky or ashen ghost skin",
						function (body:BodyData):Boolean {
							return body.player.isGhostSkin() &&
									(body.skinBaseAdj == "milky" || body.skinBaseAdj == "ashen")
						}, +1)
				.hasPerk(PerkLib.Incorporeality, +1)
				.hasPerk(PerkLib.Ghostslinger, +1)
				.hasPerk(PerkLib.PhantomShooting, +1)
				.hasPerk(PerkLib.Telekinesis, +1);
		
		buildTier(6, "phantom")
				.buffs({
					"str.mult": -0.15,
					"tou.mult": -0.15,
					"spe.mult": +0.50,
					"int.mult": +0.70,
					"wis.mult": +0.40,
					"sens": +40
				})
				.end();
		
		buildTier(12, "poltergeist")
				.buffs({
					"str.mult": -0.25,
					"tou.mult": -0.25,
					"spe.mult": +1.00,
					"int.mult": +1.60,
					"wis.mult": +0.90,
					"sens": +125
				})
				.end();
		
		buildTier(18, "eldritch poltergeist")
				.buffs({
					"str.mult": -0.45,
					"tou.mult": -0.45,
					"spe.mult": +1.60,
					"int.mult": +3.10,
					"wis.mult": +1.70,
					"sens": +280
				})
				.end();
	}
}
}
