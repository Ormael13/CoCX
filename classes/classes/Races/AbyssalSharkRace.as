package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class AbyssalSharkRace extends Race {
	
	public function AbyssalSharkRace(id:int) {
		super("Abbysal Shark", id, []);//RaceBody);
		//disabled = true;
	}
	
	public override function setup():void {
		
		addScores()
				.gillType(Gills.FISH, +1);
		
		buildTier(10, "shark-morph")
				.end();
	}
}
}
