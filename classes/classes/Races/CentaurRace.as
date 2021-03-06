package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class CentaurRace extends Race {
	public function CentaurRace(id:int) {
		super("Centaur", id);
	}
	
	public override function setup():void {
		addScores()
				.hornType(NONE(Horns.UNICORN,Horns.BICORN), 0, -1000)
				.legType(ANY(LowerBody.HOOFED,LowerBody.CLOVEN_HOOFED),+1)
				.tailType(Tail.HORSE,+1)
				.skinPlainOnly(+1)
				.hasCockOfType(CockTypesEnum.HORSE, +1)
				.vaginaType(VaginaClass.EQUINE, +1)
				.noWings(0, -3);
		addConditionedScores(function(body:BodyData):Boolean{
			return body.isTaur;
		},"taur;")
				.armType(Arms.HUMAN,+1)
				.earType(Ears.HUMAN,+1)
				.faceType(Face.HUMAN,+1);
		
		addMutation(IMutationsLib.TwinHeartIM, +2);
		
		buildTier(8, "centaur")
				.buffs({
					"tou.mult": +0.80,
					"spe.mult": -0.40,
					"maxhp_base": +100
				})
				.end();
	}
}
}
