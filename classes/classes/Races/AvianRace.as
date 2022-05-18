package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.PerkLib;
import classes.Race;

public class AvianRace extends Race{
	public function AvianRace(id:int) {
		super("Avian", id);
	}
	
	public override function setup():void {
		
		addScores()
				.hairType(Hair.FEATHER, +1)
				.faceType(Face.AVIAN, +1)
				.earType(Ears.AVIAN, +1)
				.tailType(Tail.AVIAN, +1)
				.armType(Arms.AVIAN, +1)
				.legType(LowerBody.AVIAN, +1)
				.wingType(Wings.FEATHERED_AVIAN, +2)
				.skinCoatType(Skin.FEATHER, +1)
				.hasCockOfType(CockTypesEnum.AVIAN, +1);
		
		buildTier(9, "avian-morph")
				.buffs({
					"str.mult": +0.30,
					"spe.mult": +0.75,
					"int.mult": +0.30
				})
				.end()
	}
}
}
