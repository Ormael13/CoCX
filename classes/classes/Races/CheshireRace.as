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
				.earType(Ears.CAT, +1)
				.tongueType(Tongue.CAT, +1)
				.tailType(Tail.CAT, +1)
				.armType(Arms.CAT, +1)
				.legType(LowerBody.CAT, +1)
				.skinCoatType(Skin.FUR, +1)
				.customRequirement("", "lilac and white hair and fur",
						function (body:BodyData):Boolean {
							return body.hairColors == "lilac and white" &&
									body.furColors == "lilac and white"
						}, +2)
				.hasPerk(PerkLib.Flexibility, +1)
				.customRequirement("","more cheshire features than other magical feline",
						CatRace.isCheshireSubrace,0,-1000
				);
		
		addMutation(IMutationsLib.CatLikeNimblenessIM);
		
		buildTier(11, "cheshire cat")
				.buffs({
					"spe.mult": +0.60,
					"int.mult": +0.10,
					"sens": +25
				})
				.end()
	}
}
}
