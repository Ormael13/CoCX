package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class OrcaRace extends Race {
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

	public function OrcaRace(id:int) {
		super("Orca", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.earType(ANY(Ears.ORCA, Ears.ORCA2), +1)
				.tailType(Tail.ORCA, +1)
				.faceType(Face.ORCA, +1, -1000)
				.eyeType(Eyes.HUMAN, +1)
				.eyeColor("orange", +1)
				.hairType(Hair.NORMAL, +1)
				.legType(LowerBody.ORCA, +1)
				.armType(Arms.ORCA, +1)
				.rearType(RearBody.ORCA_BLOWHOLE, +1)
				.skinPlainOnly(+1)
				.skinBaseAdj("glossy", +1)
				.skinBasePattern(Skin.PATTERN_ORCA_UNDERBODY, +1)
				.noWings(+2)
				.tone(LESS_THAN(10), +1)
				.height(AT_LEAST(84),+1)
				.customRequirement("",'big H-cup tits (or bigger) or 19"+ long cock',
						function (body:BodyData):Boolean {
							return body.biggestTitSize > 19 || body.biggestCockSize > 18
						}, +1)
				.customRequirement("","not a sea dragon",
						function (body:BodyData):Boolean {
							return !SeaDragonRace.isSeaDragonLike(body)
						}, +1);
		
		addMutation(IMutationsLib.WhaleFatIM);
		
		buildTier(14, "orca")
				.namesMaleFemaleTaur("orca-boy", "orca-girl", "orca-taur")
				.buffs({
					"str.mult": +1.00,
					"tou.mult": +0.40,
					"spe.mult": +0.70
				})
				.withExtraBonuses("+35 Max Hunger")
				.end();
		
		buildTier(20, "greater orca")
				.namesMaleFemaleTaur("greater orca-boy", "greater orca-girl", "greater orca-taur")
				.buffs({
					"str.mult": +1.40,
					"tou.mult": +0.70,
					"spe.mult": +1.00
				})
				.withExtraBonuses("+60 Max Hunger")
				.end();
	}
}
}
