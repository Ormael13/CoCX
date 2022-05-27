package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class HorseRace extends Race {
	public function HorseRace(id:int) {
		super("Horse", id);
	}
	
	public override function setup():void {
		addScores()
				.faceType(Face.HORSE, +1)
				.earType(Ears.HORSE, +1)
				.hornType(NONE(Horns.UNICORN,Horns.BICORN), 0, -1000)
				.tailType(Tail.HORSE, +1)
				.legType(LowerBody.HOOFED, +1)
				.hasCockOfType(CockTypesEnum.HORSE, +1)
				.vaginaType(VaginaClass.EQUINE, +1)
				.skinCoatType(Skin.FUR, +1)
				.armType(Arms.HUMAN, +1)
				.isNotTaur(0,-7);
		
		buildTier(7, "equine-morph")
				.buffs({
					"spe.mult": +0.70,
					"tou.mult": +0.35,
					"maxhp_base": +70
				})
				.end();
	}
}
}
