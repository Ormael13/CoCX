package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class BearRace extends Race {
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

	public static const BearFurColors:/*String*/Array = ["black","brown","white"];
	
	public function BearRace(id: int) {
		super("Bear", id, []);//RaceBody);
        //tfRace = RaceMem.appendEnumVal("Bear", CoC.instance.transformations.FullBear);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(ANY(Face.BEAR, Face.PANDA), +2)
				.earType(ANY(Ears.BEAR, Ears.PANDA), +1)
				.tailType(Tail.BEAR, +1)
				.armType(Arms.BEAR, +1)
				.legType(LowerBody.BEAR, +1)
				.eyeType(Eyes.BEAR, +1)
				.skinCoatType(Skin.FUR, +1)
				.furColor1(ANY(BearFurColors), +1)
				.furColors("white and black", +1)
				.height(GREATER_THAN(72), +2);
		
		addBloodline(PerkLib.UrsinesDescendant, PerkLib.BloodlineUrsine);
		
		buildTier(10,"bear")
				.customNamingFunction(function(body:BodyData):String {
					return (body.faceType == Face.PANDA || body.earType == Ears.PANDA) ? "panda-morph" : "bear-morph";
				})
				.buffs({
					"str.mult": +1.00,
					"tou.mult": +0.80,
					"int.mult": -0.20
				})
				.end();
	}
}
}
