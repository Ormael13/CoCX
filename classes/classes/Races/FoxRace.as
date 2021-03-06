package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class FoxRace extends Race {
	public function FoxRace(id:int) {
		super("Fox", id);
	}
	
	public override function setup():void {
		addScores()
				.faceType(Face.FOX, +1)
				.eyeType(Eyes.FOX, +1)
				.earType(Ears.FOX, +1)
				.tailType(Tail.FOX, +1)
				.customRequirement("","no more than 1 fox tail",
						function (body:BodyData):Boolean {
							return !(body.tailType == Tail.FOX && body.tailCount > 1)
						}, 0, -7)
				.armType(Arms.FOX, +1)
				.legType(LowerBody.FOX, +1);
		addScoresAfter(1)
				.hasCockOfType(CockTypesEnum.FOX, +1)
				.breastRowCount(GREATER_THAN(1), +1)
				.breastRowCount(3, +1)
				.breastRowCount(4, +2)
				.skinCoatType(Skin.FUR, +1);
		
		buildTier(7, "fox-morph")
				.namesTauric("fox-morph", "fox-taur")
				.buffs({
					"str.mult": -0.30,
					"spe.mult": +0.80,
					"int.mult": +0.55,
					"maxfatigue_base": +20
				})
				.end();
	}
}
}
