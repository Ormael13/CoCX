package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.internals.race.RaceUtils;

public class WerefoxRace extends Race {
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Human",
        /*Eyes*/		"Feral",
        /*Face*/		"Human",
        /*Gills*/		"Human",
        /*Hair*/		"Human",
        /*Horns*/		"Human",
        /*LowerBody*/	"Human",
        /*RearBody*/	"Human",
        /*Skin*/		"Human",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Fox",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Human"];

	public function WerefoxRace(id:int) {
		super("Werefox", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.FOX_FANGS, +2)
				.eyeType(Eyes.FERAL, +2)
				.eyeType(NOT(Eyes.FOX), 0,-7)
				.earType(Ears.FENNEC_FOX, +2)
				.tongueType(Tongue.HUMAN, +1)
				.armType(Arms.FOX, +1)
				.legType(LowerBody.FOX, +1)
				.customScoreRequirement("tail", "multiple fox tails, +1 per tail",
						function (body:BodyData):Boolean {
							return body.tailType == Tail.FOX && body.tailCount >= 1;
						},
						function (body:BodyData):int {
							return body.tailCount * 2;
						},
						-7
				)
				.skinCoatType(Skin.FUR, +1)
				.rearType(RearBody.WOLF_COLLAR, +1)
				.noWings(+4)
				.hasPerk(PerkLib.VulpesthropyDormant, +1)
				.hasPerk(PerkLib.Vulpesthropy, +2, -11);
		
		addBloodline(PerkLib.WerefoxsDescendant,PerkLib.BloodlineWerefox);
		addMutation(IMutationsLib.WhiteFacedOneBirthrightIM);
		
		buildTier(12, "werefox cub")
				.require("Vulpesthropy or Dormant Vulpesthropy perk", 
					RaceUtils.hasAnyPerkFn([PerkLib.Vulpesthropy, PerkLib.VulpesthropyDormant]))
				.buffs({
					"str.mult": +0.10,
					"tou.mult": +1.00,
					"spe.mult": +0.40,
					"wis.mult": +1.00,
					"sens": +70,
					"maxlust_mult": -0.1,
					"maxsf_mult": +1,
					"maxmana_mult": -0.4
				})
				.end();
		buildTier(18, "werefox")
				.requirePreviousTier()
				.requireTailCount(AT_LEAST(3))
				.buffs({
					"str.mult": +0.10,
					"tou.mult": +1.50,
					"spe.mult": +0.70,
					"wis.mult": +1.80,
					"sens": +140,
					"maxlust_mult": -0.1,
					"maxsf_mult": +1.5,
					"maxmana_mult": -0.4
				})
				.end();
		buildTier(24, "elder werefox")
				.requirePreviousTier()
				.requireTailCount(AT_LEAST(5))
				.buffs({
					"str.mult": +0.10,
					"tou.mult": +2.00,
					"spe.mult": +1.00,
					"wis.mult": +2.60,
					"sens": +210,
					"maxlust_mult": -0.1,
					"maxsf_mult": +2,
					"maxmana_mult": -0.4
				})
				.end();
		buildTier(30, "ancient werefox")
				.requirePreviousTier()
				.requireTailCount(AT_LEAST(7))
				.buffs({
					"str.mult": +0.10,
					"tou.mult": +2.50,
					"spe.mult": +1.30,
					"wis.mult": +3.40,
					"sens": +280,
					"maxlust_mult": -0.1,
					"maxsf_mult": +2.5,
					"maxmana_mult": -0.4
				})
				.end();
	}
}
}
