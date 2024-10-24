package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class BunnyRace extends Race {
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

    public function BunnyRace(id:int) {
		super("Bunny", id, []);//RaceBody);
        //tfRace = RaceMem.appendEnumVal("Bunny", CoC.instance.transformations.FullBunny);
	}
	
	public override function setup():void {
		addScores()
				.faceType(ANY(Face.BUNNY, Face.BUCKTEETH), +1)
				.earType(Ears.BUNNY, +1, -10)
				.eyeType(Eyes.HUMAN, +1)
				.armType(Arms.HUMAN, +1)
				.legType(LowerBody.BUNNY, +1)
				.skinCoatType(Skin.FUR, +2)
				.tailType(Tail.RABBIT, +1)
				.noAntennae(+1)
				.noWings(+1)
				.height(LESS_THAN(72), +1)
				.customRequirement("","No horse cock",
						function (body:BodyData): Boolean {
							return body.player.horseCocks() < 1
						}, 0, -10)
				.customRequirement("","No equine vagina",
						function (body:BodyData): Boolean {
							return body.player.vaginaType() != VaginaClass.EQUINE
						}, 0, -10)
				.customRequirement("","No easter bunny balls",
						function (body:BodyData): Boolean {
							return !body.player.hasPerk(PerkLib.EasterBunnyBalls)
						}, 0, -10);
		
		addBloodline(PerkLib.BunnysDescendant, PerkLib.BloodlineBunny);
		addMutation(IMutationsLib.MightyLegsIM);
		
		buildTier(10, "bunny")
				.namesMaleFemale("bunny-boy","bunny-girl")
				.buffs({
					"str.mult": -0.20,
					"tou.mult": -0.10,
					"spe.mult": +0.90,
					"lib.mult": +0.90
				})
				.end();
		
		buildTier(13, "greater bunny")
				.namesMaleFemale("greater bunny-boy","greater bunny-girl")
				.buffs({
					"tou.mult": -0.10,
					"spe.mult": +1.00,
					"lib.mult": +1.05
				})
				.end();
	}
}
}
