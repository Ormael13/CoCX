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
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Human",
        /*Eyes*/		"Human",
        /*Face*/		"Human",
        /*Gills*/		"Human",
        /*Hair*/		"Human",
        /*Horns*/		"Human",
        /*LowerBody*/	"Human",
        /*RearBody*/	"Human",
        /*Skin*/		"Human",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Human"];
	
	public function SalamanderRace(id:int) {
		super("Salamander", id, []);//RaceBody);
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
				.legType(LowerBody.SALAMANDER, +1)
				.tailType(Tail.SALAMANDER, +2)
				.tailType(NOT(Tail.KITSHOO), 0, -1000)
				.hasCockOfType(CockTypesEnum.LIZARD,+1)
				.hasPerk(PerkLib.Lustzerker, +1)
				.wingType(NOT(Wings.FEATHERED_PHOENIX), 0, -1000);
		addConditionedScores(function (body:BodyData):Boolean {
			return body.skinCoatType == Skin.SCALES
		},"scales;")
				.skinCoatTypeAndColor1(Skin.SCALES, ANY(SalamanderScaleColors), +1)
				.skinColor1(ANY(SalamanderSkinColors), +1);
		addConditionedScores(function (body:BodyData):Boolean {
			return body.tailType == Tail.SALAMANDER
		},"salamander tail;")
				.noWings(+1)
				.noHorns(+1)
				.noRearBody(+1);
		
		addBloodline(PerkLib.SalamandersDescendant, PerkLib.BloodlineSalamander);
		addMutation(IMutationsLib.SalamanderAdrenalGlandsIM);
		addMutation(IMutationsLib.BlazingHeartIM);
		
		buildTier(7, "salamander")
				.namesTauric("salamander", "salamander-taur")
				.buffs({
					"str.mult": +0.55,
					"tou.mult": +0.35,
					"lib.mult": +0.40,
					"sens": +15,
					"maxlust_base": +25
				})
				.end();
		
		buildTier(16, "primordial salamander")
				.namesTauric("primordial salamander", "primordial salamander-taur")
				.buffs({
					"str.mult": +1.20,
					"tou.mult": +0.90,
					"lib.mult": +1.05,
					"sens": +75,
					"maxlust_base": +50
				})
				.end();
	}
	
	public static function isSalamanderLike(body:BodyData):Boolean {
		return body.tailType == Tail.SALAMANDER
				|| body.legType == LowerBody.SALAMANDER;
	}
}
}
