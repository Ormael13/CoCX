package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.GeneticMemories.RaceMem;
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
        /*Eyes*/		"Fairy",
        /*Face*/		"Fairy",
        /*Gills*/		"Human",
        /*Hair*/		"Fairy",
        /*Horns*/		"Human",
        /*LowerBody*/	"Elf",
        /*RearBody*/	"Human",
        /*Skin*/		"Human",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Elf",
        /*Wings*/		"Fairy",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Fairy"];

	public function FairyRace(id:int) {
		super("Fairy", id, RaceBody);
		mutationThreshold = 9;
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
				.hasPerk(PerkLib.TransformationImmunity2, +5)
				.skinPlainOnly(+1)
				.noCock(+1);
		
		addMutation(IMutationsLib.FeyArcaneBloodstreamIM, +3);
		
		buildTier(15, "Half fairy")
				.buffs({
					"str.mult": -0.10,
					"tou.mult": -0.05,
					"spe.mult": +0.80,
					"int.mult": +0.80,
					"wis.mult": +0.60,
					"sens": +10
				})
				.end();

		buildTier(23, "Great Fairy")
                .requirePerk(PerkLib.TransformationImmunity2)
				.buffs({
					"str.mult": -0.20,
					"tou.mult": -0.10,
					"spe.mult": +4.80,
					"int.mult": +4.80,
					"wis.mult": +1.25,
					"sens": +20
				})
				.end();
		
		buildTier(26, "Noble Fairy")
				.requirePreviousTier()
				.buffs({
					"str.mult": -0.20,
					"tou.mult": -0.10,
					"spe.mult": +5.40,
					"int.mult": +5.40,
					"wis.mult": +1.50,
					"sens": +30
				})
				.end();
		
		buildTier(29, "Fairy Queen")
                .requirePreviousTier()
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
                .requirePreviousTier()
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
