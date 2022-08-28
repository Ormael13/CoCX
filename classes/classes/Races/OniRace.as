package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class OniRace extends Race {
	public static const OniEyeColors:/*String*/Array = ["red", "orange", "yellow", "green"];
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
	
	public function OniRace(id:int) {
		super("Oni", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.earType(Ears.ONI, +1)
				.faceType(Face.ONI_TEETH, +1)
				.hornType(ANY(Horns.ONI, Horns.ONI_X2), +1)
				.armType(Arms.ONI, +1)
				.legType(LowerBody.ONI, +1)
				.eyeTypeAndColor(Eyes.ONI, ANY(OniEyeColors), +1)
				.skinBasePattern(Skin.PATTERN_BATTLE_TATTOO, +1)
				.tone(AT_LEAST(80),+1)
				.customRequirement("",'vagina and H+ tits or 19\"+ long cock',
						function (body:BodyData):Boolean {
							return body.hasVagina && body.biggestTitSize >= 19 || body.biggestCockSize > 18
						}, +1)
				.height(AT_LEAST(108), +1);
		addScoresAfter(4)
				.noRearBody(+1)
				.noTail(+1)
				.tone(AT_LEAST(120), +1);
		addScoresAfter(8)
				.tone(AT_LEAST(160), +1);
		
		addBloodline(PerkLib.OnisDescendant, PerkLib.BloodlineOni);
		addMutation(IMutationsLib.OniMusculatureIM);
		
		buildTier(12, "oni")
				.namesTauric("oni", "oni-taur")
				.buffs({
					"str.mult": +1.00,
					"tou.mult": +0.60,
					"int.mult": -0.20,
					"wis.mult": +0.40
				})
				.end();
		
		buildTier(18, "elder oni")
				.namesTauric("elder oni", "elder oni-taur")
				.buffs({
					"str.mult": +1.50,
					"tou.mult": +0.90,
					"int.mult": -0.30,
					"wis.mult": +0.60
				})
				.end();
	}
}
}
