package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.Race;

public class YetiRace extends Race {
	public static const YetiSkinColors:/*String*/Array = ["dark", "tan"];
	public static const YetiEyeColors:/*String*/Array = ["siilver", "grey", "gray"];
	
	public function YetiRace(id: int) {
		super("Yeti", id);
	}
	
	public override function setup():void {
		
		addScores()
				.skinMaterialColor(ANY(YetiSkinColors), +1)
				.eyeColor(ANY(YetiEyeColors), +1)
				.legType(LowerBody.YETI, +1)
				.armType(Arms.YETI, +1)
				.rearType(RearBody.YETI_FUR, +1)
				.eyeType(Eyes.HUMAN, +1)
				.earType(Ears.YETI, +1)
				.faceType(Face.YETI_FANGS, +1)
				.hairType(Hair.FLUFFY, +1)
				.hairColor("white", +1)
				.skinCoatType(Skin.FUR, +1)
				.skinCoatTypeAndColor(Skin.FUR, "white", +1)
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
