package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;

public class NagaRace extends Race {
	public function NagaRace(id:int) {
		super("Naga", id);
	}
	
	public override function setup():void {
		addScores()
				.isNaga(+3, -1000)
				.tongueType(Tongue.SNAKE, +1)
				.faceType(Face.SNAKE_FANGS, +1)
				.armType(Arms.HUMAN, +1)
				.skinCoatType(Skin.SCALES, +1)
				.earType(Ears.SNAKE, +1)
				.eyeType(Eyes.SNAKE, +1)
				.customRequirement("","naga vagina or lizard cock",
						function (body:BodyData):Boolean {
							return body.vaginaType == VaginaClass.NAGA || body.player.lizardCocks() > 0
						}, +1)
				.customRequirement("","not another snake-like race",
						function (body:BodyData):Boolean {
							return !(GorgonRace.isGorgonLike(body)
									|| CouatlRace.isCouatlLike(body)
									|| VouivreRace.isVouivreLike(body)
									|| HydraRace.isHydraLike(body));
						}, 0, -1000);
		
		addMutation(IMutationsLib.VenomGlandsIM);
		
		buildTier(8, "naga")
				.buffs({
					"str.mult": +0.40,
					"tou.mult": +0.20,
					"spe.mult": +0.60
				})
				.end();
	}
}
}
