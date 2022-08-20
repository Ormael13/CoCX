package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class CentaurRace extends Race {
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

    public function CentaurRace(id:int) {
		super("Centaur", id, []);
	}
	
	public override function setup():void {
		addScores()
				.hornType(NONE(Horns.UNICORN,Horns.BICORN), 0, -1000)
				.isTaur(+2, -1000)
				.legType(ANY(LowerBody.HOOFED,LowerBody.CLOVEN_HOOFED),+1)
				.tailType(Tail.HORSE,+1)
				.skinPlainOnly(+1)
				.hasCockOfType(CockTypesEnum.HORSE, +1)
				.vaginaType(VaginaClass.EQUINE, +1)
				.noWings(0, -3)
				.noRearBody(0, -3);
		addConditionedScores(function(body:BodyData):Boolean{
			return body.isTaur;
		},"taur;")
				.armType(Arms.HUMAN,+1)
				.earType(Ears.HUMAN,+1)
				.eyeType(Eyes.HUMAN,+1)
				.faceType(Face.HUMAN,+1);
		
		addMutation(IMutationsLib.TwinHeartIM, +2);
		
		buildTier(8, "centaur")
				.buffs({
					"tou.mult": +0.40,
					"spe.mult": +0.80,
					"maxhp_base": +100
				})
				.end();
		
		buildTier(16, "elder centaur")
				.buffs({
					"tou.mult": +0.80,
					"spe.mult": +1.60,
					"maxhp_base": +250
				})
				.end();
	}
}
}
