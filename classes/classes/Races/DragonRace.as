package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.lists.Gender;

/**
 * Tier 1: dragon
 * Tier 2: elder dragon
 * Tier 3: ancient dragon
 */
public class DragonRace extends Race {
	public function DragonRace(id:int) {
		super("Dragon", id);
		addScores()
				.faceType(ANY(Face.DRAGON, Face.DRAGON_FANGS), +1)
				.faceType(ANY(Face.JABBERWOCKY, Face.BUCKTOOTH), -10)
				.eyeType(Eyes.DRACONIC, +1)
				.earType(Ears.DRAGON, +1)
				.tailType(Tail.DRACONIC, +1)
				.tongueType(Tongue.DRACONIC, +1)
				.wingType(Wings.DRACONIC_SMALL, +1)
				.wingType(Wings.DRACONIC_LARGE, +2)
				.wingType(Wings.DRACONIC_HUGE, +4)
				.wingType(Wings.FEY_DRAGON, -10)
				.legType(LowerBody.DRAGON, +1)
				.legType(LowerBody.FROSTWYRM, -10)
				.armType(Arms.DRACONIC, +1)
				.skinCoatType(Skin.DRAGON_SCALES, +1)
				.hornType(Horns.DRACONIC_X2, +1)
				.hornType(Horns.DRACONIC_X4_12_INCH_LONG, +2)
				.hornType(Horns.FROSTWYRM, -3)
				.hasCockOfType(CockTypesEnum.DRAGON, +1)
				.gender(Gender.GENDER_FEMALE, +1);
		addScoresAfter(8)
				.height(GREATER_THAN(120), +1)
				.hasAnyPerk([
					PerkLib.DragonFireBreath,
					PerkLib.DragonIceBreath,
					PerkLib.DragonLightningBreath,
					PerkLib.DragonDarknessBreath
				], +1)
				.hasAllPerks([
					PerkLib.DragonFireBreath,
					PerkLib.DragonIceBreath,
					PerkLib.DragonLightningBreath,
					PerkLib.DragonDarknessBreath
				], +1);
		
		addBloodline(PerkLib.DragonsDescendant, PerkLib.BloodlineDragon);
		addMutation(IMutationsLib.DraconicBonesIM);
		addMutation(IMutationsLib.DraconicHeartIM);
		addMutation(IMutationsLib.DraconicLungIM);
		
		buildTier(16, "dragon")
				.namesMaleFemaleMorphTaur("dragon-man","dragon-girl",
						"dragon","dragon-taur")
				.buffs({
					"maxhp_mult": +0.10,
					"str.mult": +0.50,
					"tou.mult": +0.50,
					"spe.mult": +0.50,
					"int.mult": +0.40,
					"wis.mult": +0.40,
					"lib.mult": +0.30,
					"sens": +20
				})
				.withExtraBonuses("+1 Armor / Magic Resistance")
				.end();
		buildTier(24, "elder dragon")
				.namesMaleFemaleMorphTaur("elder dragon-man","elder dragon-girl",
						"elder dragon","elder dragon-taur")
				.buffs({
					"maxfatigue_base": +100,
					"maxlust_base": +25,
					"maxhp_mult": +0.20,
					"str.mult": +0.80,
					"tou.mult": +0.80,
					"spe.mult": +0.80,
					"int.mult": +0.70,
					"wis.mult": +0.70,
					"lib.mult": +0.40,
					"sens": +30
				})
				.withExtraBonuses("+4 Armor / Magic Resistance")
				.end();
		buildTier(32, "ancient dragon")
				.namesMaleFemaleMorphTaur("ancient dragon-man","ancient dragon-girl",
						"ancient dragon","ancient dragon-taur")
				.buffs({
					"maxfatigue_base": +200,
					"maxlust_base": +50,
					"maxhp_mult": +0.30,
					"str.mult": +1.00,
					"tou.mult": +1.00,
					"spe.mult": +1.00,
					"int.mult": +0.80,
					"wis.mult": +0.80,
					"lib.mult": +0.60,
					"sens": +40
				})
				.withExtraBonuses("+10 Armor / Magic Resistance")
				.end();
	}
}
}
