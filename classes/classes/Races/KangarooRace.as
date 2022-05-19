package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class KangarooRace extends Race {
	
	public function KangarooRace(id:int) {
		super("Kangaroo", id);
	}
	
	public override function setup():void {
		addScores()
				.hasCockOfType(CockTypesEnum.KANGAROO, +1)
				.earType(Ears.KANGAROO, +1)
				.tailType(Tail.KANGAROO, +1)
				.legType(LowerBody.KANGAROO, +1)
				.faceType(Face.KANGAROO,1);
		addScoresAfter(2)
				.skinCoatType(Skin.FUR, +1);
		
		buildTier(4, "kangaroo-morph")
				.buffs({
					"tou.mult": +0.05,
					"spe.mult": +0.15
				})
				.end();
	}
}
}
