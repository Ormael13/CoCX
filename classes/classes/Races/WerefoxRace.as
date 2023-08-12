package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.GeneticMemories.RaceMem;
import classes.PerkLib;
import classes.Race;

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
				.faceType(Face.FOX_FANGS, +1)
				.eyeType(Eyes.FERAL, +1)
				.eyeType(NOT(Eyes.FOX), 0,-7)
				.earType(Ears.FENNEC_FOX, +2)
				//.tongueType(Tongue., +1)
				.armType(Arms.FOX, +1)
				.legType(LowerBody.FOX, +1)
				.customScoreRequirement("tail", "multiple fox tails, +1 per tail",
						function (body:BodyData):Boolean {
							return body.tailType == Tail.FOX && body.tailCount >= 1;
						},
						function (body:BodyData):int {
							return body.tailCount;
						},
						-7
				)
				.skinCoatType(Skin.FUR, +1)
				.rearType(RearBody.WOLF_COLLAR, +1)
				.corruption(AT_LEAST(20), +2)
				.hasPerk(PerkLib.Vulpesthropy, +1, -11)/*
				.hasPerk(PerkLib.VulpesthropyDormant, -11)*/;
		
		buildTier(12, "werefox")
                .requirePerk(PerkLib.Vulpesthropy)
				.buffs({
					"str.mult": +0.10,
					"tou.mult": +1.00,
					"wis.mult": +1.20,
					"sens": +50,
					"maxlust_mult": -0.15,
					"maxsf_mult": +1.0,
					"maxwrath_mult": +0.6,
					"maxmana_mult": -0.8
				})
				.end();
		buildTier(16, "elder werefox")
				.requirePreviousTier()
				.requireTailCount(AT_LEAST(3))
				.buffs({
					"str.mult": +0.15,
					"tou.mult": +1.50,
					"wis.mult": +1.75,
					"sens": +100,
					"maxlust_mult": -0.15,
					"maxsf_mult": +1.2,
					"maxwrath_mult": +0.7,
					"maxmana_mult": -0.8
				})
				.end();
		buildTier(20, "ancient werefox")
				.requirePreviousTier()
				.requireTailCount(AT_LEAST(6))
				.buffs({
					"str.mult": +0.20,
					"tou.mult": +2.00,
					"wis.mult": +2.30,
					"sens": +150,
					"maxlust_mult": -0.15,
					"maxsf_mult": +1.4,
					"maxwrath_mult": +0.8,
					"maxmana_mult": -0.8
				})
				.end();
	}
}
}
