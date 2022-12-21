package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.Race;

public class PigRace extends Race{
	public static const PigSkinColors:/*String*/Array = ["pink", "tan", "sable"];
	public static const BoarSkinColors:/*String*/Array = ["pink", "dark blue"];
	public static const BoarFurColors:/*String*/Array = ["dark brown", "brown", "black", "red", "grey"];
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
	
	public function PigRace(id:int) {
		super("Pig", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.earType(Ears.PIG, +1)
				.tailType(Tail.PIG, +1)
				.faceType(Face.PIG, +1)
				.faceType(Face.BOAR, +2)
				.armType(ANY(Arms.PIG, Arms.BOAR), +2)
				.legType(LowerBody.CLOVEN_HOOFED, +1)
				.skinPlainOnly(+1)
				.skinColor1(ANY(PigSkinColors), +1)
				.thickness(AT_LEAST(75), +1)
				.hasCockOfType(CockTypesEnum.PIG, +1)
		addConditionedScores(
				function(body:BodyData):Boolean {
					return body.faceType === Face.BOAR || body.armType === Arms.BOAR
				}, "boar arms or face;"
		)
				.skinColor1(ANY(BoarSkinColors), +2)
				.skinCoatTypeAndColor1(Skin.FUR, ANY(BoarFurColors), +2);
		addScoresAfter(4)
				.skinCoatType(Arms.HUMAN, +1)
				.noWings(+1)
				.thickness(AT_LEAST(150), +1);
		
		addMutation(IMutationsLib.PigBoarFatIM);
		
		buildTier(10, "pig-morph")
				.buffs({
					"str.mult": +0.60,
					"tou.mult": +1.20,
					"spe.mult": -0.15,
					"int.mult": -0.10,
					"wis.mult": -0.05
				})
				.withExtraBonuses("+25 Max Hunger")
				.end()
		
		buildTier(15, "boar-morph")
				.buffs({
					"str.mult": +1.25,
					"tou.mult": +1.25,
					"spe.mult": -0.15,
					"int.mult": -0.10
				})
				.withExtraBonuses("+45 Max Hunger")
				.end()
	}
}
}
