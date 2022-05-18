package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.PerkLib;
import classes.Race;

public class WerewolfRace extends Race {
	
	public function WerewolfRace(id:int) {
		super("Werewolf", id);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.WOLF_FANGS, +1)
				.eyeType(Eyes.FERAL, +1)
				.eyeType(Eyes.FENRIR, -7)
				.earType(Ears.WOLF, +1)
				.tongueType(Tongue.DOG, +1)
				.armType(Arms.WOLF, +1)
				.legType(LowerBody.WOLF, +1)
				.tailType(Tail.WOLF, +1)
				.skinCoatType(Skin.FUR, +1)
				.rearType(RearBody.WOLF_COLLAR, +1)
				.rearType(RearBody.FENRIR_ICE_SPIKES, -7)
				.corruption(AT_LEAST(20), +2)
				.hasPerk(PerkLib.Lycanthropy, +1)
				//.hasPerk(PerkLib.LycanthropyDormant, -11)
		;
		addScoresAfter(1)
				.hasCockOfType(CockTypesEnum.WOLF, +1)
		
		buildTier(12, "werewolf")
				.buffs({
					"str.mult": +1.00,
					"tou.mult": +0.40,
					"spe.mult": +0.60,
					"int.mult": -0.20
				})
				.end();
	}
}
}
