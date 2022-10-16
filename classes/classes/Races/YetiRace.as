package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.Race;

public class YetiRace extends Race {
	public static const YetiSkinColors:/*String*/Array = ["dark", "tan"];
	public static const YetiEyeColors:/*String*/Array = ["siilver", "grey", "gray"];
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
	
	public function YetiRace(id: int) {
		super("Yeti", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.skinColor1(ANY(YetiSkinColors), +1)
				.eyeColor(ANY(YetiEyeColors), +1)
				.legType(LowerBody.YETI, +1)
				.armType(Arms.YETI, +1)
				.rearType(RearBody.YETI_FUR, +1)
				.eyeType(Eyes.HUMAN, +1)
				.earType(Ears.YETI, +1)
				.faceType(Face.YETI_FANGS, +1)
				.hairType(Hair.FLUFFY, +1)
				.hairColor1("white", +1)
				.skinCoatType(Skin.FUR, +1)
				.skinCoatTypeAndColor1(Skin.FUR, "white", +1)
				.height(AT_LEAST(78), +1)
				.customRequirement("butt", "thicc butt",
						function (body:BodyData):Boolean {
							return body.player.butt.type >= 10;
						}, +1);
		
		addMutation(IMutationsLib.YetiFatIM);
		
		buildTier(14,"yeti")
				.namesTauric("yeti", "yeti-taur")
				.buffs({
					"str.mult": +1.00,
					"tou.mult": +0.80,
					"spe.mult": +0.50,
					"int.mult": -0.70,
					"lib.mult": +0.50
				})
				.end()
		
		buildTier(17,"true yeti")
				.namesTauric("true yeti", "true yeti-taur")
				.buffs({
					"str.mult": +1.30,
					"tou.mult": +1.00,
					"spe.mult": +0.65,
					"int.mult": -0.90,
					"lib.mult": +0.50
				})
				.end()
	}
}
}
