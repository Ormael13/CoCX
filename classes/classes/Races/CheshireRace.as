package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class CheshireRace extends Race{
	public function CheshireRace(id:int) {
		super("Cheshire", id);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.CHESHIRE, +2)
				.faceType(Face.CHESHIRE_SMILE, +2)
				.eyeType(Eyes.CAT, +1)
				.earType(Ears.CAT, +1)
				.tongueType(Tongue.CAT, +1)
				.tailType(Tail.CAT, +1)
				.armType(Arms.CAT, +1)
				.legType(LowerBody.CAT, +1)
				.skinCoatType(Skin.FUR, +1)
				.customRequirement("", "lilac and white striped hair and fur",
						function (body:BodyData):Boolean {
							return body.hairColor == "lilac and white striped" &&
									body.skinCoatColor == "lilac and white striped"
						}, +2)
				.hasPerk(PerkLib.Flexibility, +1)
				.customRequirement("","not other magical feline race",
						function (body:BodyData):Boolean {
							return !(CatRace.isNekomataLike(body)
									|| body.rearType == RearBody.LION_MANE
									|| CatRace.isHellcatLike(body)
									|| CatRace.isDisplacerLike(body));
						},0,-1000
				);
		
		addMutation(IMutationsLib.CatLikeNimblenessIM);
		
		buildTier(11, "cheshire cat")
				.buffs({
					"spe.mult": +0.60,
					"int.mult": +0.10,
					"sens": +25
				})
				.end()
	}
}
}
