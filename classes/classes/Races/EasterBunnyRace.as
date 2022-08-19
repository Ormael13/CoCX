package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class EasterBunnyRace extends Race {
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Bunny",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Bunny",
        /*Eyes*/		"Human",
        /*Face*/		"Bunny",
        /*Gills*/		"Human",
        /*Hair*/		"Human",
        /*Horns*/		"Human",
        /*LowerBody*/	"Bunny",
        /*RearBody*/	"Human",
        /*Skin*/		"Fur",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Bunny",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"EasterBunny",
        /*Vagina*/		"Human",
        /*Perks*/		"EasterBunny"];

    public function EasterBunnyRace(id:int) {
		super("Easter Bunny", id, RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(ANY(Face.BUNNY,Face.BUCKTEETH), +1)
				.earType(Ears.BUNNY, +1, -1000)
				.legType(LowerBody.BUNNY, +1)
				.skinCoatType(Skin.FUR, +1)
				.tailType(Tail.RABBIT, +1)
				.eyeType(Eyes.HUMAN, +1)
				.armType(Arms.HUMAN, +1)
				.noAntennae(+1)
				.noWings(+1)
				.height(LESS_THAN(72), +1)
				.hasCockOfType(CockTypesEnum.HUMAN, +1)
				.customRequirement("","Easter bunny balls",
						function (body:BodyData): Boolean {
							return body.player.hasPerk(PerkLib.EasterBunnyBalls) && body.hasBalls
						}, +1);
		
		addMutation(IMutationsLib.EasterBunnyEggBagIM);
		
		buildTier(12, "easter bunny")
				.namesMaleFemale("easter bunny-boy", "easter bunny-girl")
				.requirePerk(PerkLib.EasterBunnyBalls)
				.buffs({
					"str.mult": -0.20,
					"tou.mult": -0.10,
					"spe.mult": +0.90,
					"lib.mult": +1.20
				})
				.end();
		
		buildTier(15, "true easter bunny")
				.namesMaleFemale("true easter bunny-boy", "true easter bunny-girl")
				.requirePreviousTier()
				.buffs({
					"str.mult": -0.20,
					"tou.mult": -0.10,
					"spe.mult": +1.05,
					"lib.mult": +1.50
				})
				.end();
	}
}
}
