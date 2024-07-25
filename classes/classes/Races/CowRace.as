package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class CowRace extends Race {
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Human",
        /*Eyes*/		"Human",
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
        /*Tail*/		"Human",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Human"];

    public function CowRace(id:int) {
		super("Cow", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.earType(Ears.COW, +1)
				.tailType(Tail.COW, +1)
				.legType(LowerBody.CLOVEN_HOOFED, +1)
				.hornType(Horns.COW_MINOTAUR, +1)
				.customRequirement("","milk production > 500",
						function (body:BodyData):Boolean {
							return body.player.lactationQ() > 500
						}, +1);
		addScoresAfter(3)
				.customRequirement("","milk production > 1000",
						function (body:BodyData):Boolean {
							return body.player.lactationQ() > 1000
						}, +1)
				.faceType(ANY(Face.HUMAN, Face.COW_MINOTAUR), +1)
				.skinPlainOnly(+2)
				.biggestTitSize(GREATER_THAN(4), +1)
				.height(AT_LEAST(73), +1)
				.corruption(AT_LEAST(20), +1)
				.noCock(0,-8)
				.hasVagina(+1)
				.hasPerk(PerkLib.Feeder, +1);
		
		addBloodline(PerkLib.MinotaursDescendant, PerkLib.BloodlineMinotaur);
		addMutation(IMutationsLib.LactaBovinaOvariesIM);
		addMutation(IMutationsLib.MightyLegsIM);
		
		buildTier(10, "cow-morph")
				.namesMaleFemale("cow-morph", "cow-girl")
				.buffs({
					"str.mult": +1.20,
					"tou.mult": +0.40,
					"spe.mult": -0.40,
					"int.mult": -0.20,
					"lib.mult": +0.50
				})
				.end();
		
		buildTier(16, "Lacta Bovine")
				.buffs({
					"str.mult": +2.00,
					"tou.mult": +0.50,
					"spe.mult": -0.50,
					"int.mult": -0.30,
					"lib.mult": +0.70
				})
				.end();
	}
}
}
