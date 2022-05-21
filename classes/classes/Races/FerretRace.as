package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class FerretRace extends Race {
	public function FerretRace(id:int) {
		super("Ferret", id);
	}
	
	public override function setup():void {
		addScores()
				.faceType(Face.FERRET_MASK, +1)
				.faceType(Face.FERRET, +2)
				.earType(Ears.FERRET, +1)
				.tailType(Tail.FERRET, +1)
				.legType(LowerBody.FERRET, +1);
		addScoresAfter(1)
				.skinCoatType(Skin.FUR, +1);
		
		buildTier(4, "ferret-morph")
				.namesMaleFemaleMorph("ferret-boy", "ferret-girl", "ferret-morph")
				.end();
	}
}
}
