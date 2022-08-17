package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.lists.BreastCup;

public class FairyRace extends Race {
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Elf",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Elven",
        /*Eyes*/		"Elf",
        /*Face*/		"Elf",
        /*Gills*/		"None",
        /*Hair*/		"Elf",
        /*Horns*/		"Human",
        /*LowerBody*/	"Elf",
        /*RearBody*/	"Human",
        /*Skin*/		"Elf",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Elf",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Elf"];

	public function FairyRace(id:int) {
		super("Fairy", id);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.FAIRY, +2)
				.eyeType(Eyes.FAIRY, +2)
				.hairType(Hair.FAIRY, +2)
				.earType(Ears.ELVEN, +1)
				.noTail(+1)
				.armType(Arms.ELF, +1)
				.legType(LowerBody.ELF, +1)
				.tongueType(Tongue.ELF, +1)
				.wingType(Wings.FAIRY, +3)
				.biggestTitSize(GREATER_THAN(BreastCup.A), +1)
				.customRequirement("skin","flawless skin",
						function (body:BodyData):Boolean {
							return body.player.skinType == Skin.PLAIN && body.skinBaseAdj == "flawless"
						}, +1)
				.hasPerk(PerkLib.TransformationImmunityFairy, +5);
		addScoresAfter(1)
				.skinPlainOnly(+1)
				.noCock(+1);
		
		addMutation(IMutationsLib.FeyArcaneBloodstreamIM, +3);
		
		buildTier(23, "great fairy")
				.buffs({
					"str.mult": -0.20,
					"tou.mult": -0.10,
					"spe.mult": +4.80,
					"int.mult": +4.80,
					"wis.mult": +1.25,
					"sens": +20
				})
				.end();
		
		buildTier(26, "noble fairy")
				.buffs({
					"str.mult": -0.20,
					"tou.mult": -0.10,
					"spe.mult": +5.40,
					"int.mult": +5.40,
					"wis.mult": +1.50,
					"sens": +30
				})
				.end();
		
		buildTier(29, "fairy queen")
				.buffs({
					"str.mult": -0.20,
					"tou.mult": -0.10,
					"spe.mult": +6.00,
					"int.mult": +6.00,
					"wis.mult": +1.75,
					"sens": +40
				})
				.end();
		
		buildTier(32, "Titania")
				.buffs({
					"str.mult": -0.20,
					"tou.mult": -0.10,
					"spe.mult": +6.60,
					"int.mult": +6.60,
					"wis.mult": +2.00,
					"sens": +50
				})
				.end();
	}
}
}
