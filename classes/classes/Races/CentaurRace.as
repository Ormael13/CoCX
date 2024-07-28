package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class CentaurRace extends Race {
	public static const CentaurSkinColors:/*String*/Array = ["dark", "light","tan","olive"];
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
		super("Centaur", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.hornType(NONE(Horns.UNICORN,Horns.BICORN), 0, -1000)
				.earType(ANY(Ears.HUMAN,Ears.ELFIN,Ears.HORSE),+1)
				.faceType(ANY(Face.HUMAN,Face.ELF),+1)
				.eyeType(Eyes.HUMAN,+1)
				.hairType(Hair.NORMAL,+1)
				.isTaur(+2, -1000)
				.legType(ANY(LowerBody.HOOFED,LowerBody.CLOVEN_HOOFED),+1)
				.skinColor1(ANY(CentaurSkinColors), +1)
				.tailType(Tail.HORSE,+1)
				.skinPlainOnly(+1)
				.noWings(+3, -3)
				.noRearBody(+1, -3)
				.armType(Arms.HUMAN,+1)
				.height(AT_LEAST(84), +1)
				.customRequirement("",'vagina and D+ tits or 15\"+ long cock',
						function (body:BodyData):Boolean {
							return body.hasVagina && body.biggestTitSize >= 3 || body.biggestCockSize > 14
						}, +1)
				.cockOrVaginaOfType(CockTypesEnum.HORSE, VaginaClass.EQUINE, +1);
		
		addMutation(IMutationsLib.TwinHeartIM, +2);
		addMutation(IMutationsLib.EquineMuscleIM);
		addMutation(IMutationsLib.MightyLegsIM);
		
		buildTier(8, "lesser centaur")
				.buffs({
					"tou.mult": +0.40,
					"spe.mult": +0.80,
					"maxhp_base": +100
				})
				.end();
		
		buildTier(16, "centaur")
				.buffs({
					"tou.mult": +0.80,
					"spe.mult": +1.60,
					"maxhp_base": +250
				})
				.end();
		
		buildTier(24, "elder centaur")
				.buffs({
					"str.mult": +1.00,
					"tou.mult": +0.80,
					"spe.mult": +1.75,
					"lib.mult": +0.80,
					"sens": +75,
					"maxhp_base": +350
				})
				.end();
		
		buildTier(30, "true centaur")
				.buffs({
					"str.mult": +1.40,
					"tou.mult": +1.00,
					"spe.mult": +1.85,
					"lib.mult": +1.00,
					"sens": +75,
					"maxhp_base": +500
				})
				.end();
	}
}
}
