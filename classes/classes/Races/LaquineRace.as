package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class LaquineRace extends Race {
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

    public function LaquineRace(id:int) {
		super("Laquine", id, []);//RaceBody);
        //tfRace = RaceMem.appendEnumVal("Bunny", CoC.instance.transformations.FullBunny);
	}
	
	public override function setup():void {
		addScores()
				.faceType(ANY(Face.BUNNY, Face.BUCKTEETH), +1)
				.earType(Ears.BUNNY, +1, -10)
				.eyeType(Eyes.HUMAN, +1)
				.armType(Arms.HUMAN, +1)
				.legType(LowerBody.BUNNY, +1)
				.skinCoatType(Skin.FUR, +2)
				.tailType(ANY(Tail.RABBIT, Tail.HORSE), +1)
				.noAntennae(+1)
				.noWings(+1)
				.tone(AT_LEAST(60), +1)
				.tone(AT_LEAST(80), +1)
				.tone(AT_LEAST(100), +1)
				.hasBalls(+1)
				.height(GREATER_THAN(84), +1)
				.hasCockOfType(CockTypesEnum.HORSE, +1, -10)
				.vaginaType(VaginaClass.EQUINE, +1, -10)
				.customRequirement("","No easter bunny balls",
						function (body:BodyData): Boolean {
							return !body.player.hasPerk(PerkLib.EasterBunnyBalls)
						}, 0, -10);
		
		addMutation(IMutationsLib.EquineMuscleIM);
		addMutation(IMutationsLib.MightyLegsIM);
		
		buildTier(12, "laquine")
				.namesMaleFemale("laquine-boy","laquine-girl")
				.buffs({
					"str.mult": +0.80,
					"tou.mult": -0.10,
					"spe.mult": +0.80,
					"wis.mult": -0.20,
					"lib.mult": +1.00,
					"sens": +50
				})
				.end();
		
		buildTier(20, "elder laquine")
				.namesMaleFemale("elder laquine-boy","elder laquine-girl")
				.buffs({
					"str.mult": +1.50,
					"tou.mult": -0.20,
					"spe.mult": +1.20,
					"wis.mult": -0.50,
					"lib.mult": +2.00,
					"sens": +100
				})
				.end();
	}
}
}
