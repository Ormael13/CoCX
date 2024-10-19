package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

/**
 * Tier 1: Mouse
 * Tier 2: Hinezumi
 * Tier 3: Hinezumi
 */
public class MouseRace extends Race {
	public static const MouseHairColors:/*String*/Array = ["red", "orange", "pinkish orange", "platinum crimson"];
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
	
	public function MouseRace(id:int) {
		super("Mouse", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.earType(Ears.MOUSE, +1)
				.tailType(ANY(Tail.MOUSE,Tail.HINEZUMI), +1)
				.faceType(ANY(Face.BUCKTEETH,Face.MOUSE), +2)
				.legType(ANY(LowerBody.MOUSE, LowerBody.HINEZUMI), +1)
				.armType(Arms.HINEZUMI, +1)
				.eyeTypeAndColor(Eyes.HINEZUMI, "blazing red", +1)
				.hairType(Hair.BURNING, +1)
				.hairColor1(ANY(MouseHairColors), +1)
				.skinCoatType(Skin.FUR, +1);
		addConditionedScores(function (body:BodyData): Boolean {
			return body.skinCoatType == Skin.FUR;
		}, "fur;")
				.height(LESS_THAN(60), +1)
				.height(LESS_THAN(52), +1);
		
		addBloodline(PerkLib.MousesDescendant, PerkLib.BloodlineMouse);
		addMutation(IMutationsLib.HinezumiBurningBloodIM);
		addMutation(IMutationsLib.BlazingHeartIM);
		
		buildTier(8, "mouse-morph")
				.namesMaleFemaleMorphTaur("mouse-boy","mouse-girl","mouse-morph","mouse-taur")
				.buffs({
					"tou.mult": -0.10,
					"spe.mult": +0.80,
					"wis.mult": +0.50
				})
				.end();
		
		buildTier(12, "fire mouse")
				.namesTauric("fire mouse","fire mouse-taur")
				.requireArmType(Arms.HINEZUMI)
				.requireLegType(LowerBody.HINEZUMI)
				.buffs({
					"str.mult": +0.60,
					"tou.mult": -0.10,
					"spe.mult": +0.80,
					"wis.mult": +0.50
				})
				.end();
		
		buildTier(15, "hinezumi")
				.namesTauric("hinezumi","hinezumi-taur")
				.requirePreviousTier()
				.buffs({
					"str.mult": +0.75,
					"tou.mult": -0.10,
					"spe.mult": +0.80,
					"wis.mult": +0.80
				})
				.end();
	}
}
}
