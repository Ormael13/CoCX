package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class SphinxRace extends Race {
	public static const SphinxSkinColor:/*String*/Array = ["dark", "tan"];
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
	
	public function SphinxRace(id:int) {
		super("Sphinx", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.skinColor1(ANY(SphinxSkinColor), +1)
				.eyeType(Eyes.CAT, +1)
				.tongueType(Tongue.CAT, +1)
				.tailType(ANY(Tail.CAT, Tail.LION), +1)
				.legType(LowerBody.CAT, +1)
				.faceType(Face.CAT_CANINES, +1)
				.wingType(Wings.FEATHERED_SPHINX, +4, -1000)
				.armType(Arms.SPHINX, +1, -1000)
				.customRequirement("","cat cock or have a vagina",
						function (body:BodyData):Boolean {
							return body.player.catCocks() > 0 || body.hasVagina;
						}, +1)
				.customRequirement("","fur or plain skin",
						function (body:BodyData):Boolean {
							return body.skinCoatType == Skin.FUR || body.player.hasPlainSkinOnly();
						}, +1)
				.customRequirement("legs","cat-legged taur",
						function (body:BodyData):Boolean {
							return body.isTaur && body.legType == LowerBody.CAT
						}, +2)
				.customRequirement("","more sphinx features than other magical feline",
						CatRace.isSphinxSubrace,0,-1000
				);
		addConditionedScores(
				function (body:BodyData):Boolean {
					return body.isTaur && body.legType == LowerBody.CAT;
				},"cat-legged taur;")
				.tailType(Tail.CAT, +1)
				.skinPlainOnly(+1)
				.armType(Arms.SPHINX, +1)
				.earType(Ears.LION, +1)
				.faceType(Face.CAT_CANINES, +1);
		addScores()
				.hasPerk(PerkLib.Flexibility, +1);
		
		addMutation(IMutationsLib.TwinHeartIM, +2);
		addMutation(IMutationsLib.CatLikeNimblenessIM);
		addMutation(IMutationsLib.EyeOfTheTigerIM);
		
		buildTier(14, "sphinx")
				.buffs({
					"str.mult": +0.50,
					"tou.mult": -0.10,
					"spe.mult": +0.40,
					"int.mult": +0.90,
					"wis.mult": +0.40
				})
				.end()
		
		buildTier(21, "greater sphinx")
				.buffs({
					"str.mult": +0.90,
					"tou.mult": -0.20,
					"spe.mult": +0.50,
					"int.mult": +1.00,
					"wis.mult": +0.95
				})
				.end()
		
		buildTier(30, "noble sphinx")
				.buffs({
					"str.mult": +1.10,
					"tou.mult": -0.20,
					"spe.mult": +0.60,
					"int.mult": +1.50,
					"wis.mult": +1.50
				})
				.end()
	}
}
}
