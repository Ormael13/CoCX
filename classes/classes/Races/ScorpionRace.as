package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class ScorpionRace extends Race {
	
	public function ScorpionRace(id:int) {
		super("Scorpion", id);
		disabled = true;
	}
	
	public override function setup():void {
		addScores()
				.skinCoatType(Skin.CHITIN, +1)
				.tailType(Tail.SCORPION, +1);
		
		addMutation(IMutationsLib.TrachealSystemIM);
		
		buildTier(4, "scorpion")
				.namesTauric("scorpion-morph","scorpion-taur")
				.buffs({
					"str.mult": +0.00,
					"tou.mult": +0.00,
					"spe.mult": +0.00,
					"int.mult": +0.00,
					"wis.mult": +0.00,
					"lib.mult": +0.00,
					"sens": +0
				})
				.end();
	}
}
}
