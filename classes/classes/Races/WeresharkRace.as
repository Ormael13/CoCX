package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class WeresharkRace extends Race {
    public static const SharkScaleColors:/*String*/Array = ["rough gray","orange","dark gray","iridescent gray","ashen grayish-blue","gray"];
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

	public function WeresharkRace(id:int) {
		super("Wereshark", id, []);//RaceBody);
		//disabled = true;
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.SHARK_TEETH,1)
				.eyeType(Eyes.FERAL, +2)
				.gillType(Gills.FISH, +1)
				.earType(Ears.SHARK, +1)
				.tongueType(Tongue.HUMAN, +1)
				.rearType(RearBody.SHARK_FIN, +1)
				.armType(Arms.SHARK, +1)
				//.legType(LowerBody.SHARK, +1)
				//.tailType(Tail.SHARK, +1)
				.hairTypeAndColor1(Hair.NORMAL, "silver", +1)
				.skinCoatType(ANY(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES), +1)
				.skinColor1(ANY(SharkScaleColors), +1)
				.cockOrVaginaOfType(CockTypesEnum.HUMAN, VaginaClass.SHARK, +1)
				.noWings(+4)
				.corruption(AT_LEAST(20), +1)
				.corruption(AT_LEAST(50), +1)
				.corruption(AT_LEAST(80), +1)
				.hasPerk(PerkLib.Selachimorphanthropy, +2, -11);
		
		addMutation(IMutationsLib.FerasBirthrightIM);
		addMutation(IMutationsLib.SharkOlfactorySystemIM);
		
		buildTier(12, "wereshark")
				.buffs({
					"str.mult": +0.90,
					"tou.mult": +0.50,
					"spe.mult": +0.50,
					"int.mult": -0.10
				})
				.end();
		buildTier(18, "elder wereshark")
				.requirePreviousTier()
				.buffs({
					"str.mult": +1.40,
					"tou.mult": +0.70,
					"spe.mult": +0.70,
					"int.mult": -0.10
				})
				.end();
		buildTier(24, "ancient wereshark")
				.requirePreviousTier()
				.buffs({
					"str.mult": +1.90,
					"tou.mult": +0.90,
					"spe.mult": +0.90,
					"int.mult": -0.10
				})
				.end();
	}
}
}
