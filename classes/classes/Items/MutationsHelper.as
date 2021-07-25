package classes.Items {
import classes.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;

/**
	 * Helper class to get rid of the copy&paste-mess in classes.Items.Mutations
	 * @since July 8, 2016
	 * @author Stadler76
	 */
	public class MutationsHelper extends BaseContent
	{

    public var changes:int = 0;
		public var changeLimit:int = 1;

		public function MutationsHelper() { }

		public function humanizeLowerBody():void {
			outputText("\n\n");
			transformations.LegsHuman.applyEffect();
			changes++;
		}

	/**
	 * Initializes changes=0 and changeLimit to (1..maxChanges) + perk bonuses
	 * @param name
	 * @param maxChanges
	 * @return
	 */
	protected function mutationStart(name:String, maxChanges:int):int {
		changes     = 0;
		changeLimit = 1;
		for (var i:int = 2; i <= maxChanges; i++) {
			if (rand(i) == 0) changeLimit++;
		}
		if (player.hasPerk(PerkLib.HistoryAlchemist) || player.hasPerk(PerkLib.PastLifeAlchemist)) changeLimit++;
		if (player.hasPerk(PerkLib.Enhancement)) changeLimit++;
		if (player.hasPerk(PerkLib.Fusion)) changeLimit++;
		if (player.hasPerk(PerkLib.Enchantment)) changeLimit++;
		if (player.hasPerk(PerkLib.Refinement)) changeLimit++;
		if (player.hasPerk(PerkLib.Saturation)) changeLimit++;
		if (player.hasPerk(PerkLib.Perfection)) changeLimit++;
		if (player.hasPerk(PerkLib.Creationism)) changeLimit++;
		if (player.hasPerk(PerkLib.EzekielBlessing)) changeLimit++;
		if (player.hasPerk(PerkLib.TransformationResistance)) changeLimit--;
		return changes;
	}
	/**
	 * If:
	 * * changes < changeLimit
	 * * `condition` is 'true'
	 * * random*rarity < 1  (equivalent to (rand(rarity) = 0) for `rarity:int`)
	 * Then:
	 * * call `code`
	 * * changes++
	 * * return true
	 * Else:
	 * * return false
	 */
	protected function mutationStep(condition:Boolean, rarity:Number, code:Function):Boolean {
		if (changes < changeLimit
			&& condition
			&& Math.random() * rarity < 1) {
			code();
			changes++;
			return true;
		} else {
			return false;
		}
	}

	// =================================
	// Metamorph-aware mutation methods
	// ---------------------------------
	// * Change player.something to `newType`.
	// * Update genetic memory, if present.
	// * No mutation flavour text is displayed
	// * @return true if added genetic memory (displayed "genetic memory unlocked" text)
	// =================================

	public function setLowerBody(lowerBody:int):Boolean {
		return setBodyPartType("lowerBody", METAMORPH_LOWER_BODIES, lowerBody);
	}
	private const METAMORPH_LOWER_BODIES:Object = createMapFromPairs([
		[LowerBody.AVIAN, null],
		[LowerBody.ATLACH_NACHA, null],
		[LowerBody.BEAR, null],
		[LowerBody.BEE, StatusEffects.UnlockedBeeLegs],
		[LowerBody.BUNNY, null],
		[LowerBody.CANCER, null],
		[LowerBody.CAT, StatusEffects.UnlockedCatLegs],
		[LowerBody.CENTAUR, null],
		[LowerBody.CENTIPEDE, null],
		[LowerBody.CHITINOUS_SPIDER_LEGS, StatusEffects.UnlockedSpiderLegs],
		[LowerBody.CLOVEN_HOOFED, StatusEffects.UnlockedClovenHoofedLegs],
		[LowerBody.CRAB, null],
		[LowerBody.DEERTAUR, null],
		[LowerBody.DEMONIC_CLAWS, StatusEffects.UnlockedDemonClawedLegs],
		[LowerBody.DEMONIC_HIGH_HEELS, StatusEffects.UnlockedDemonHighHeels],
		[LowerBody.DOG, null],
		[LowerBody.DRAGON, StatusEffects.UnlockedDraconicLegs],
		[LowerBody.DRIDER, StatusEffects.UnlockedDriderLegs],
		[LowerBody.ECHIDNA, null],
		[LowerBody.ELF, StatusEffects.UnlockedElfLegs],
		[LowerBody.FERRET, null],
		[LowerBody.FIRE_SNAIL, null],
		[LowerBody.FOX, StatusEffects.UnlockedFoxLowerBody],
		[LowerBody.FROSTWYRM, null],
		[LowerBody.GARGOYLE, null],
		[LowerBody.GARGOYLE_2, null],
		[LowerBody.GHOST, null],
		[LowerBody.GHOST_2, null],
		[LowerBody.GOO, null],
		[LowerBody.GRYPHON, null],
		[LowerBody.HARPY, StatusEffects.UnlockedHarpyLegs],
		[LowerBody.HINEZUMI, null],
		[LowerBody.HOOFED, StatusEffects.UnlockedHoofedLegs],
		[LowerBody.HUMAN, StatusEffects.UnlockedHumanLowerBody],
		[LowerBody.HYDRA, null],
		[LowerBody.JIANGSHI, null],
		[LowerBody.KANGAROO, null],
		[LowerBody.KRAKEN, null],
		[LowerBody.LION, StatusEffects.UnlockedLionLegs],
		[LowerBody.LIZARD, StatusEffects.UnlockedLizardLegs],
		[LowerBody.MANTIS, StatusEffects.UnlockedMantisLegs],
		[LowerBody.MELKIE, null],
		[LowerBody.MOUSE, null],
		[LowerBody.NAGA, StatusEffects.UnlockedSnakeLowerBody],
		[LowerBody.ONI, StatusEffects.UnlockedOniLegs],
		[LowerBody.ORC, StatusEffects.UnlockedOrcLegs],
		[LowerBody.ORCA, StatusEffects.UnlockedOrcaLegs],
		[LowerBody.PLANT_FLOWER, null],
		[LowerBody.PLANT_HIGH_HEELS, null],
		[LowerBody.PLANT_ROOT_CLAWS, null],
		[LowerBody.PONY, null],
		[LowerBody.RACCOON, null],
		[LowerBody.RAIJU, StatusEffects.UnlockedRaijuLegs],
		[LowerBody.RED_PANDA, StatusEffects.UnlockedRedPandaLegs],
		[LowerBody.SALAMANDER, StatusEffects.UnlockedSalamanderLegs],
		[LowerBody.SCYLLA, null],
		[LowerBody.SHARK, StatusEffects.UnlockedSharkLegs],
		[LowerBody.USHI_ONI, null],
		[LowerBody.WENDIGO, null],
		[LowerBody.WOLF, null],
		[LowerBody.YETI, null],
		[LowerBody.YGG_ROOT_CLAWS, null],
		[LowerBody.YUKI_ONNA, null],
	]);

	/**
	 * Change player[key] to `tgtType`.
	 * Update genetic memory using `dict`, if perk present and body type registered.
	 * No mutation flavour text is displayed
	 * @return true if added genetic memory (displayed "genetic memory unlocked" text)
	 */
	private function setBodyPartType(key:String, dict:Object, tgtType:int):Boolean {
		var splitKey:Array = key.split('.');
		if(splitKey.length > 1){
			var part:String = splitKey[0];
			var prop:String = splitKey[1];
			if(player[part][prop] == tgtType) return false;
			player[part][prop] = tgtType;
		} else {
			if (player[key] == tgtType) return false;
			player[key] = tgtType;
		}
		if (!player.hasPerk(PerkLib.GeneticMemory)) return false;

		var o:* = dict[tgtType];
		if (o is Array) {
			return addGeneticMemory(o[0], o[1]);
		} else if (o != null) {
			var sat:StatusEffectType = o;
			return addGeneticMemory(sat, sat.id.replace("Unlocked ", ""));
		} else return false;
	}
	public function addGeneticMemory(sat:StatusEffectType, name:String = null, doOutput: Boolean = true):Boolean {
		if (!player.hasPerk(PerkLib.GeneticMemory)) return false;
		if (sat != null && !player.hasStatusEffect(sat)) {
			player.createStatusEffect(sat, 0, 0, 0, 0);
			return true;
		}
		return false;
	}
}
}
