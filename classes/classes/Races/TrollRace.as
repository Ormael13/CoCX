package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.PerkLib;
import classes.Race;
public class TrollRace extends Race {
	public function TrollRace(id:int) {
		super("Troll", id);
		
		buildTier(10, "troll")
				.buffs({
					"str.mult": +0.30,
					"spe.mult": +0.40,
					"int.mult": +0.30,
					"wis.mult": +0.50
				})
				.end();
	}
}
}
