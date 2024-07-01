package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.lists.BreastCup;

public class GremlinRace extends Race {
	public static const GremlinEyeColors:/*String*/Array = ["red", "yellow", "purple"];
	public static const GremlinSkinColors:/*String*/Array = ["light", "tan", "dark", "olive"];
	public static const GremlinHairColors:/*String*/Array = ["emerald", "green", "dark green", "aqua", "light green", "olive", "lime green", "turquoise"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Snake",
        /*Eyes*/		"Gorgon",
        /*Face*/		"Snake",
        /*Gills*/		"None",
        /*Hair*/		"Gorgon",
        /*Horns*/		"Human",
        /*LowerBody*/	"Snake",
        /*RearBody*/	"Human",
        /*Skin*/		"Snake",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Snake",
        /*Wings*/		"Human",
        /*Penis*/		"Lizard",
        /*Vagina*/		"Lizard",
        /*Perks*/		"Human"];
	
	public function GremlinRace(id:int) {
		super("Gremlin", id, []);//RaceBody);
        //tfRace = RaceMem.GREMLIN;
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.CRAZY, +1)
				.earType(Ears.GREMLIN, +1, -1000)
				.hairType(Hair.CRAZY, +1)
				.eyeType(Eyes.GREMLIN, +1)
				.eyeColor(ANY(GremlinEyeColors), +1)
				.skinColor1(ANY(GremlinSkinColors), +1, -1000)
				.hairColor1(ANY(GremlinHairColors), +1)
				.armType(Arms.HUMAN, +1)
				.legType(LowerBody.HUMAN, +1)
				.skinPlainOnly(+1)
				.noWings(0, -1)
				.noTail(0, -1)
				.noHorns(0, -1)
				.height(LESS_THAN(48), +2)
				.hasVagina(+1)
				.biggestTitSize(GREATER_THAN(BreastCup.A), 0, +1)
				.customRequirement("",'A cup tits or flat',
						function (body:BodyData):Boolean {
							return body.biggestTitSize <= 1
						}, +1)
				.femininity(GREATER_THAN(70), +1)
				.corruption(AT_LEAST(30), +2)
				.hasPerk(PerkLib.GoblinoidBlood, +1)
				.hasPerk(PerkLib.BouncyBody, +1)
				.hasPerk(PerkLib.Soulless, +4);
		
		addBloodline(PerkLib.GoblinsDescendant, PerkLib.BloodlineGoblin);
		addMutation(IMutationsLib.NaturalPunchingBagIM);
		addMutation(IMutationsLib.GoblinOvariesIM);
		addMutation(IMutationsLib.BlackHeartIM);
		
		buildTier(15, "gremlin-kin")
				.buffs({
					"str.mult": -0.50,
					"spe.mult": +0.75,
					"int.mult": +1.20,
					"lib.mult": +1.00,
					"sens": +20
				})
				.end();
		
		buildTier(24, "gremlin")
				.requirePerk(PerkLib.Soulless)
				.buffs({
					"str.mult": -0.50,
					"spe.mult": +1.00,
					"int.mult": +1.80,
					"lib.mult": +1.50,
					"sens": +20
				})
				.end();
		
		buildTier(36, "arch gremlin")
				.requirePerk(PerkLib.Soulless)
				.buffs({
					"str.mult": -0.50,
					"spe.mult": +1.60,
					"int.mult": +2.50,
					"lib.mult": +2.00,
					"sens": +20
				})
				.end();
	}
}
}
