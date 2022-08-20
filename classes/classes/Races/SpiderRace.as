package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;

public class SpiderRace extends Race {
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
	
	public function SpiderRace(id:int) {
		super("Spider", id, []);
	}
	
	public override function setup():void {
		addScores()
				.eyeType(Eyes.SPIDER, +1)
				.faceType(Face.SPIDER_FANGS, +1)
				.armType(Arms.SPIDER, +1)
				.legType(LowerBody.CHITINOUS_SPIDER_LEGS,+1)
				.legType(LowerBody.DRIDER, +2)
				.tailType(Tail.SPIDER_ADBOMEN, +1)
		addScoresAfter(4)
				.earType(Ears.ELFIN,1)
				.skinCoatType(Skin.CHITIN, +1)
				.hasStatusEffect(StatusEffects.BlackNipples,"black nipples", +1)
				.hasPerk(PerkLib.SpiderOvipositor, +1)
		
		addMutation(IMutationsLib.VenomGlandsIM);
		addMutation(IMutationsLib.ArachnidBookLungIM);
		
		buildTier(7, "spider-morph")
				.customNamingFunction(function (body:BodyData):String {
					if (body.isDrider) return "drider";
					return body.mf("spider-morph", "spider-girl");
				})
				.buffs({
					"str.mult": -0.20,
					"tou.mult": +0.50,
					"int.mult": +0.75
				})
				.end();
	}
}
}
