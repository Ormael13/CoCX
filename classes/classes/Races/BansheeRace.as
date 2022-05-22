package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class BansheeRace extends Race {
	public function BansheeRace(id:int) {
		super("Banshee", id);
		disabled = true;
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		addScores()
				.hairType(Hair.GHOST, +1)
		
		buildTier(1000, "tierName")
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
