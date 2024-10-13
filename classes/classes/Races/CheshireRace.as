package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class CheshireRace extends Race{
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

    public function CheshireRace(id:int) {
		super("Cheshire", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.CHESHIRE, +2)
				.faceType(Face.CHESHIRE_SMILE, +2)
				.eyeType(Eyes.CAT, +1)
				.eyeColor("yellow", +1)
				.earType(Ears.CAT, +1)
				.tongueType(Tongue.CAT, +1)
				.tailType(Tail.CAT, +1)
				.armType(Arms.CAT, +1)
				.legType(LowerBody.CAT, +1)
				.skinCoatType(Skin.FUR, +1)
				.customRequirement("", "light purple secondary hair and fur and any primary color hair and fur",
						function (body:BodyData):Boolean {
							return body.hairColor2 == "light purple" &&
									body.furColor2 == "light purple"
						}, +2)
				.hasPerk(PerkLib.Flexibility, +1)
				.hasPerk(PerkLib.Insanity, +1)
				.customRequirement("","more cheshire features than other magical feline",
						CatRace.isCheshireSubrace,0,-1000
				);
		
		addBloodline(PerkLib.FelinesDescendant, PerkLib.BloodlineFeline);
		addMutation(IMutationsLib.CatLikeNimblenessIM);
		addMutation(IMutationsLib.EyeOfTheTigerIM);
		
		buildTier(13, "trickster cat")
				.buffs({
					"spe.mult": +1.80,
					"int.mult": +0.30,
					"sens": +25
				})
				.end()

		buildTier(20, "cheshire cat")
				.buffs({
					"spe.mult": +2.60,
					"int.mult": +1.00,
					"sens": +60
				})
				.end()
	}
}
}
