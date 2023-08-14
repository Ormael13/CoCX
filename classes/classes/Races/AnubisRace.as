package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.CoC;
import classes.GeneticMemories.RaceMem;
import classes.PerkLib;
import classes.Race;
//import classes.VaginaClass;

public class AnubisRace extends Race {
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

	public function AnubisRace(id:int) {
		super("Anubis", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.earType(Ears.JACKAL, +1)
				.skinPlainOnly(+1)
				.eyeType(Eyes.HUMAN, +1)
				.eyeColor(ANY("red","green"), +1)
				.faceType(ANY(Face.CAT,Face.CAT_CANINES), +1)
				.tongueType(Tongue.CAT, +1)
				.armType(Arms.CAT, +1)
				.legType(LowerBody.CAT, +1)
				.tailType(Tail.CAT, +1)
				.wingType(Wings.NONE, +4)
				.hasCockOfType(CockTypesEnum.CAT, +1)//.cockOrVaginaOfType(CockTypesEnum.CAT, VaginaClass.cat,1)
				.corruption(AT_LEAST(50), +1);
		
		buildTier(20, "anubi")
				.buffs({
					"tou.mult": +1.00,
					"wis.mult": +1.50,
					"lib.mult": +0.50
				})
				.end();
		buildTier(28, "anubi high priest/ess")
				.namesMaleFemale("anubi high priest", "anubi high priestess")
				.buffs({
					"tou.mult": +1.00,
					"wis.mult": +2.00,
					"lib.mult": +1.20
				})
				.end();
	}
}
}
