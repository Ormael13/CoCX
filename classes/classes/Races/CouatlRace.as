package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;

public class CouatlRace extends Race {
	public function CouatlRace(id:int) {
		super("Couatl", id);
	}
	
	public override function setup():void {
		addScores()
				.isNaga(+3, -1000)
				.tongueType(Tongue.SNAKE, +1)
				.faceType(Face.SNAKE_FANGS, +1)
				.armType(Arms.HARPY, +1)
				.skinCoatType(Skin.SCALES, +1)
				.earType(Ears.SNAKE, +1)
				.eyeType(Eyes.SNAKE, +1)
				.hairType(Hair.FEATHER, +1)
				.wingType(Wings.FEATHERED_LARGE, +1, -1000)
				.customRequirement("","naga vagina or lizard cock",
						function (body:BodyData):Boolean {
							return body.vaginaType == VaginaClass.NAGA || body.player.lizardCocks() > 0
						}, +1)
				.customRequirement("","not another snake-like race",
						function (body:BodyData):Boolean {
							return !(body.player.nagaScore() > 10
									|| GorgonRace.isGorgonLike(body)
									|| VouivreRace.isVouivreLike(body)
									|| HydraRace.isHydraLike(body));
						}, 0, -1000);
		
		addMutation(IMutationsLib.VenomGlandsIM);
		addMutation(IMutationsLib.HeartOfTheStormIM);
		
		buildTier(11, "couatl")
				.buffs({
					"str.mult": +0.30,
					"tou.mult": +0.25,
					"spe.mult": +0.80,
					"int.mult": +0.30
				})
				.end();
		
		buildTier(19, "greater couatl")
				.buffs({
					"str.mult": +0.50,
					"tou.mult": +0.45,
					"spe.mult": +1.40,
					"int.mult": +0.50
				})
				.end();
	}
	
	public static function isCouatlLike(body:BodyData):Boolean {
		return body.hairType == Hair.FEATHER
				|| body.armType == Arms.HARPY
				|| body.wingType == Wings.FEATHERED_LARGE;
	}
}
}
