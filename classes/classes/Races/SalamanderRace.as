package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.internals.Utils;

public class SalamanderRace extends Race {
	public static const SalamanderScaleColors:/*String*/Array = ["red", "blazing red", "orange", "reddish-orange"];
	public static const SalamanderSkinColors:/*String*/Array = ["tan", "light", "dark", "mohagany", "russet"];
	
	public function SalamanderRace(id:int) {
		super("Salamander", id);
	}
	
	public override function setup():void {
		addScores()
				.skinCoatType(Skin.SCALES, +1)
				.faceType(Face.SALAMANDER_FANGS, +1)
				.customRequirement("","salamander fangs; human or lizard ears", function (body:BodyData): Boolean {
					return body.faceType == Face.SALAMANDER_FANGS
							&& (body.earType == Ears.HUMAN || body.earType == Ears.LIZARD);
				}, +1)
				.eyeType(Eyes.LIZARD, +1)
				.armType(Arms.SALAMANDER, +1)
				.tailType(Tail.SALAMANDER, +2)
				.hasCockOfType(CockTypesEnum.LIZARD,+1)
				.hasPerk(PerkLib.Lustzerker, +1)
				.wingType(NOT(Wings.FEATHERED_PHOENIX), 0, -1000);
		addConditionedScores(function (body:BodyData):Boolean {
			return body.skinCoatType == Skin.SCALES
		},"scales;")
				.skinCoatTypeAndColor(Skin.SCALES, ANY(SalamanderScaleColors), +1)
				.skinColor(ANY(SalamanderSkinColors), +1);
		addConditionedScores(function (body:BodyData):Boolean {
			return body.tailType == Tail.SALAMANDER
		},"salamander tail;")
				.noWings(+1)
				.noHorns(+1)
				.noRearBody(+1);
		
		addMutation(IMutationsLib.SalamanderAdrenalGlandsIM);
		
		buildTier(7, "salamander")
				.namesTauric("salamander", "salamander-taur")
				.buffs({
					"str.mult": +0.25,
					"tou.mult": +0.25,
					"lib.mult": +0.40,
					"maxlust_base": +25
				})
				.end();
		
		buildTier(16, "primordial salamander")
				.namesTauric("primordial salamander", "primordial salamander-taur")
				.buffs({
					"str.mult": +1.05,
					"tou.mult": +0.80,
					"lib.mult": +0.40,
					"sens": +75,
					"maxlust_base": +25
				})
				.end();
	}
	
	public static function isSalamanderLike(body:BodyData):Boolean {
		return body.tailType == Tail.SALAMANDER
				|| body.legType == LowerBody.SALAMANDER;
	}
}
}
