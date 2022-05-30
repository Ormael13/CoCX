package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.Race;

public class BearRace extends Race {
	public static const BearFurColors:/*String*/Array = ["black","brown","white"];
	
	public function BearRace(id: int) {
		super("Bear", id);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(ANY(Face.BEAR, Face.PANDA), +1)
				.earType(ANY(Ears.BEAR, Ears.PANDA), +1)
				.tailType(Tail.BEAR, +1)
				.armType(Arms.BEAR, +1)
				.legType(LowerBody.BEAR, +1)
				.eyeType(Eyes.BEAR, +1)
				.skinCoatType(Skin.FUR, +1)
				.skinCoatColor(ANY(BearFurColors), +1)
				.skinCoatColorPair("white", "black", +1)
				.height(GREATER_THAN(72), +2);
		
		buildTier(10,"bear")
				.customNamingFunction(function(body:BodyData):String {
					return body.faceType == Face.PANDA ? "panda-morph" : "bear-morph";
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
