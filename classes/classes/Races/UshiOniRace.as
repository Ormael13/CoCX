package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.Race;
import classes.StatusEffects;

public class UshiOniRace extends Race{
	public static const UshiOniSkinColors:/*String*/Array = ["green", "red", "grey", "sandy-tan", "pale", "purple"];
	public static const UshiOniHairColors:/*String*/Array = ["dark green", "dark red", "blue", "brown", "white", "black"];
	
	public function UshiOniRace(id:int) {
		super("Ushi-Onna", id);
		disabled = true;
	}
	
	public override function setup():void {
		
		addScores()
				.earType(Ears.COW, +1)
				.tailType(Tail.USHI_ONI, +1)
				.faceType(Face.USHI_ONI, +1)
				.hornType(Horns.USHI_ONI, +1)
				.armType(Arms.USHI_ONI, +1)
				.legType(LowerBody.USHI_ONI, +2)
				.skinBasePattern(Skin.PATTERN_RED_PANDA_UNDERBODY, +2)
				.hairTypeAndColor(Hair.NORMAL, ANY(UshiOniHairColors), +1);
		addConditionedScores(
				function (body:BodyData): Boolean {
					return body.player.hasPlainSkinOnly();
				},
				"plain skin;"
		)
				.skinMaterialColor(ANY(UshiOniSkinColors), +1);
		
		buildTier(11, "ushi-oni")
				.customNamingFunction(function(body:BodyData):String {
					var prefix:String = "";
					switch (body.player.statusEffectv1(StatusEffects.UshiOnnaVariant)) {
						case 1: prefix = "fiery "; break;
						case 2: prefix = "frozen "; break;
						case 3: prefix = "sandy "; break;
						case 4: prefix = "pure "; break;
						case 5: prefix = "wicked "; break;
					}
					return prefix + body.mf("ushi-oni","ushi-onna");
				})
				.buffs({
					"str.mult": +0.80,
					"tou.mult": +0.70,
					"int.mult": -0.40,
					"wis.mult": -0.40,
					"lib.mult": +0.95
				})
				.end();
	}
}
}
