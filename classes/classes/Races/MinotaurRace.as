package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class MinotaurRace extends Race {
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

	public function MinotaurRace(id:int) {
		super("Minotaur", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.earType(Ears.COW, +1)
				.tailType(Tail.COW, +1)
				.legType(LowerBody.CLOVEN_HOOFED, +1)
				.hornType(Horns.COW_MINOTAUR, +1)
				.customRequirement("","cum volume > 500",
						function (body:BodyData):Boolean {
							return body.player.cumQ() > 500
						}, +1);
		addScoresAfter(3)
				.customRequirement("","cum volume > 1000",
						function (body:BodyData):Boolean {
							return body.player.cumQ() > 1000
						}, +1)
				.skinCoatType(Skin.FUR, +1)
				.faceType(ANY(Face.HUMAN, Face.COW_MINOTAUR), +1)
				.armType(Arms.HUMAN, +1)
				.customRequirement("","horns size > 5",
						function (body:BodyData):Boolean {
							return body.player.horns.count > 5
						}, +1)
				.hasBalls(+1)
				.ballSize(GREATER_THAN(4), +1)
				.height(AT_LEAST(81), +1)
				.corruption(AT_LEAST(20), +1)
				.noVagina(0, -8)
				.hasCockOfType(CockTypesEnum.HORSE, +1);
		
		addBloodline(PerkLib.MinotaursDescendant, PerkLib.BloodlineMinotaur);
		addMutation(IMutationsLib.MinotaurTesticlesIM);
		addMutation(IMutationsLib.MightyLegsIM);
		
		buildTier(10, "bull-morph")
				.namesMaleFemale("bull-boy","bull-morph")
				.buffs({
					"str.mult": +1.20,
					"tou.mult": +0.40,
					"spe.mult": -0.40,
					"int.mult": -0.20,
					"lib.mult": +0.50
				})
				.end();
		
		buildTier(16, "Minotaur")
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
