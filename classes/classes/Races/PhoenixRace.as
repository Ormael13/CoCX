package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class PhoenixRace extends Race {
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Phoenix",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Human",
        /*Eyes*/		"Lizard",
        /*Face*/		"Human",
        /*Gills*/		"None",
        /*Hair*/		"Feather",
        /*Horns*/		"Human",
        /*LowerBody*/	"Harpy",
        /*RearBody*/	"Human",
        /*Skin*/		"Salamander",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Salamander",
        /*Tongue*/		"Human",
        /*Wings*/		"Phoenix",
        /*Penis*/		"Lizard",
        /*Vagina*/		"Human",
        /*Perks*/		"Phoenix"];

	public function PhoenixRace(id:int) {
		super("Phoenix", id, RaceBody);
		;
	}
	
	public override function setup():void {
		
		addScores()
				.wingType(Wings.FEATHERED_PHOENIX, +4, -1000)
				.armType(Arms.PHOENIX, +1)
				.hairType(Hair.FEATHER, +1)
				.eyeType(Eyes.LIZARD, +1)
				.legType(ANY(LowerBody.SALAMANDER, LowerBody.HARPY), +1)
				.tailType(Tail.SALAMANDER, +1)
				.tailType(NOT(Tail.KITSHOO), 0, -1000)
				.skinCoatType(Skin.SCALES, +1)
				.hasCockOfType(CockTypesEnum.LIZARD, +1)
				.hasPerk(PerkLib.PhoenixFireBreath, +1)
				.hasPerk(PerkLib.HarpyWomb, +2);
		addConditionedScores(function (body:BodyData):Boolean {
			return body.hairType === Hair.FEATHER;
		}, "feather hair;",3)
				.faceType(ANY(Face.HUMAN, Face.SALAMANDER_FANGS), 2)
				.earType(ANY(Ears.HUMAN, Ears.ELFIN, Ears.LIZARD), +1);
		
		addBloodline(PerkLib.SalamandersDescendant, PerkLib.BloodlineSalamander);
		addMutation(IMutationsLib.HarpyHollowBonesIM);
		addMutation(IMutationsLib.SalamanderAdrenalGlandsIM);
		addMutation(IMutationsLib.BlazingHeartIM);
		
		buildTier(10, "phoenix")
				.namesTauric("phoenix", "phoenix-taur")
				.buffs({
					"str.mult": +0.20,
					"tou.mult": +0.20,
					"spe.mult": +0.70,
					"lib.mult": +0.40,
					"maxlust_base": +25
				})
				.end();
		
		buildTier(21, "greater phoenix")
				.namesTauric("Greater phoenix", "Greater phoenix-taur")
				.buffs({
					"str.mult": +0.40,
					"tou.mult": +0.20,
					"spe.mult": +1.50,
					"lib.mult": +1.05,
					"maxlust_base": +25
				})
				.end();
	}
	
	public static function isPhoenixLike(body:BodyData):Boolean {
		return body.wingType == Wings.FEATHERED_PHOENIX;
	}
}
}
