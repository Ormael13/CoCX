package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;

public class SandWormRace extends Race {
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
	
	public function SandWormRace(id:int) {
		super("Sand Worm", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.hairType(Hair.DRIPPING, +1)
				.faceType(Face.HUMAN, +1)
				.eyeType(Eyes.HUMAN, +1)
				.eyeColor("red", +1)
				.skinColor1("light pink", +1)
				.plainSkinOfAdj("slippery", +2)
				.armType(Arms.HUMAN, +1)
				.hairColor1("pink", +1)
				.hasVagina(+1)
				.customRequirement("", "Breasts B+",
						function(body:BodyData):Boolean {
					return body.biggestTitSize >= 2
				}, +1)
				.femininity(AT_LEAST(80), +1)
				.height(AT_LEAST(11*12), +1)
				.hornType(Horns.NONE, +1)
				.legType(LowerBody.SANDWORM, +9)

		addMutation(IMutationsLib.TrachealSystemIM);
		addMutation(IMutationsLib.TwinHeartIM, +2);
		addMutation(IMutationsLib.PoisonGlandIM);

		buildTier(23, "sand worm")
				.requireLegType(LowerBody.SANDWORM)
				.buffs({
					"str.mult": +4.20,
					"tou.mult": +3.50,
					"int.mult": -1.00,
					"lib.mult": +4.00
				})
				.end();

		buildTier(32, "greater sand worm")
				.requirePreviousTier()
				.buffs({
					"str.mult": +6.00,
					"tou.mult": +4.25,
					"int.mult": -1.00,
					"lib.mult": +5.50
				})
				.end();
	}
}
}
