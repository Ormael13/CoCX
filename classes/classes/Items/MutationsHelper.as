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

		public function updateGills(newGillType:int = Gills.NONE):int
		{
			trace("Called updateGills(" + newGillType + ")");
			var oldgillType:int = player.gills.type;
			if (oldgillType == newGillType) return 0; // no change

			setGillType(newGillType);
			changes++;

			// for now, we only have anemone gills on the chest
			switch (newGillType) {
				case Gills.NONE:
					if (oldgillType == Gills.ANEMONE) {
						outputText("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your"
						           +" skin.");
					} else { // losing fish gills
						outputText("\n\nYou feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your"
						           +" gills shrink into nothingness, leaving only smooth skin behind. Seems you won't be able to stay in the water"
						           +" quite so long anymore.");
					}
					outputText("  <b>You no longer have gills!</b>");
					return -1; // Gills lost

				case Gills.ANEMONE:
					if (oldgillType == Gills.FISH) {
						outputText("\n\nYou feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your"
						           +" gills shrink into nothingness, leaving only smooth skin behind. When you think it's over you feel something"
						           +" emerge from under your neck, flowing down over your chest and brushing your nipples. You look in surprise as"
						           +" your new feathery gills finish growing out, a film of mucus forming over them shoftly after.");
					} else { // if no gills
						outputText("\n\nYou feel a pressure in your lower esophageal region and pull your garments down to check the area."
						           +" Before your eyes a pair of feathery gills start to push out of the center of your chest,"
						           +" just below your neckline, parting sideways and draping over your [nipple]s."
						           +" They feel a bit uncomfortable in the open air at first, but soon a thin film of mucus covers them and you"
						           +" hardly notice anything at all. You redress carefully.");
					}
					outputText("\n\n<b>You now have feathery gills!</b>");
					return 1; // Gained gills or gills.type changed

				case Gills.FISH:
					if (oldgillType == Gills.ANEMONE) {
						outputText("\n\nYou feel your gills tingle, a vague numbness registering across thier feathery exterior. You watch in awe as"
						           +" your gill's feathery folds dry out and fall off like crisp autumn leaves. The slits of your gills then"
						           +" rearrange themselves, becoming thinner and shorter, as they shift to the sides of your neck. They now close in"
						           +" a way that makes them almost invisible. As you run a finger over your neck you feel little more than several"
						           +" small raised lines where they meet your skin.");
					} else { // if no gills
						outputText("\n\nYou feel a sudden tingle on your neck. You reach up to it to feel, whats the source of it. When you touch"
						           +" your neck, you feel that it begins to grow serveral narrow slits which slowly grow longer. After the changes"
						           +" have stopped you quickly head to a nearby puddle to take a closer look at your neck. You realize,"
						           +" that your neck has grown gills allowing you to breathe under water as if you were standing on land.");
					}
					outputText("\n\n<b>You now have fish like gills!</b>");
					return 1; // Gained gills or gills.type changed

				default:
					player.gills.type = oldgillType;
					changes--;
					trace("ERROR: Unimplemented new gills.type (" + newGillType + ") used");
					return 0; // failsafe, should hopefully never happen
			}
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

	public function setGillType(gillType:int):Boolean {
		return setBodyPartType("gills.type", METAMORPH_GILLS, gillType);
	}
	private const METAMORPH_GILLS:Object = createMapFromPairs([
		[Gills.ANEMONE, null],
		[Gills.FISH, StatusEffects.UnlockedFishGills],
		[Gills.GILLS_IN_TENTACLE_LEGS, null],
		[Gills.NONE, StatusEffects.UnlockedHumanNoGills],
	]);

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

	public function setRearBody(rearBody:int):Boolean {
		return setBodyPartType("rearBody.type", METAMORPH_REAR_BODIES, rearBody);
	}
	private const METAMORPH_REAR_BODIES:Object = createMapFromPairs([
		[RearBody.ATLACH_NACHA, null],
		[RearBody.BAT_COLLAR, StatusEffects.UnlockedBatCollar],
		[RearBody.BEHEMOTH, null],
		[RearBody.CENTIPEDE, null],
		[RearBody.DISPLACER_TENTACLES, StatusEffects.UnlockedDisplacerBTentacles],
		[RearBody.DRACONIC_MANE, null],
		[RearBody.DRACONIC_SPIKES, null],
		[RearBody.FENRIR_ICE_SPIKES, null],
		[RearBody.FROSTWYRM, null],
		[RearBody.FUR_COAT, null],
		[RearBody.GHOSTLY_AURA, null],
		[RearBody.GLACIAL_AURA, null],
		[RearBody.KRAKEN, null],
		[RearBody.LION_MANE, StatusEffects.UnlockedLionMane],
		[RearBody.METAMORPHIC_GOO, null],
		[RearBody.NONE, StatusEffects.UnlockedHumanNoRearBody],
		[RearBody.ORCA_BLOWHOLE, StatusEffects.UnlockedOrcaBlowhole],
		[RearBody.RAIJU_MANE, StatusEffects.UnlockedRaijuMane],
		[RearBody.SHARK_FIN, StatusEffects.UnlockedSharkFin],
		[RearBody.SNAIL_SHELL, null],
		[RearBody.TENTACLE_EYESTALKS, null],
		[RearBody.WOLF_COLLAR, null],
		[RearBody.YETI_FUR, null],
	]);

	/**
	 * @param tailType TAIL_TYPE_xxx
	 * @param tailCount new tail count, -1 means "do not change"
	 */
	public function setTailType(tailType:int, tailCount:int = -1):Boolean {
		var a:Boolean = setBodyPartType("tail.type", METAMORPH_TAILS, tailType);
		if (tailCount < 0) return a;
		if (tailType == Tail.FOX) {
			var b:Boolean = setBodyPartType("tail.count", METAMORPH_FOX_TAILS, tailCount);
			return a || b;
		} else {
			player.tailCount = tailCount;
			return a;
		}
	}
	private const METAMORPH_TAILS:Object     = createMapFromPairs([
		[Tail.AVIAN, null],
		[Tail.BEAR, null],
		[Tail.BEE_ABDOMEN, StatusEffects.UnlockedBeeTail],
		[Tail.BEHEMOTH, null],
		[Tail.BURNING, StatusEffects.UnlockedHellcatBurningTail],
		[Tail.CAT, StatusEffects.UnlockedCatTail],
		[Tail.CAVE_WYRM, null],
		[Tail.COW, StatusEffects.UnlockedCowTail],
		[Tail.DEER, null],
		[Tail.DEMONIC, StatusEffects.UnlockedDemonTail],
		[Tail.DOG, null],
		[Tail.DRACONIC, StatusEffects.UnlockedDraconicTail],
		[Tail.ECHIDNA, null],
		[Tail.FERRET, null],
		[Tail.FOX, StatusEffects.UnlockedFoxTail],
		[Tail.GARGOYLE, null],
		[Tail.GARGOYLE_2, null],
		[Tail.GOAT, StatusEffects.UnlockedGoatTail],
		[Tail.GRIFFIN, null],
		[Tail.HARPY, StatusEffects.UnlockedHarpyTail],
		[Tail.HINEZUMI, null],
		[Tail.HORSE, StatusEffects.UnlockedHorseTail],
		[Tail.KANGAROO, null],
		[Tail.KITSHOO, null],
		[Tail.LION, null],
		[Tail.LIZARD, StatusEffects.UnlockedLizardTail],
		[Tail.MANTICORE_PUSSYTAIL, StatusEffects.UnlockedManticoreTail],
		[Tail.MANTIS_ABDOMEN, StatusEffects.UnlockedMantisTail],
		[Tail.MONKEY, null],
		[Tail.MOUSE, null],
		[Tail.NEKOMATA_FORKED_1_3, StatusEffects.UnlockedNekomataForkedTail1],
		[Tail.NEKOMATA_FORKED_2_3, StatusEffects.UnlockedNekomataForkedTail2],
		[Tail.NONE, StatusEffects.UnlockedHumanNoTail],
		[Tail.ORCA, StatusEffects.UnlockedOrcaTail],
		[Tail.PIG, StatusEffects.UnlockedPigTail],
		[Tail.RABBIT, null],
		[Tail.RACCOON, null],
		[Tail.RAIJU, StatusEffects.UnlockedRaijuTail],
		[Tail.RED_PANDA, StatusEffects.UnlockedRedPandaTail],
		[Tail.RHINO, null],
		[Tail.SALAMANDER, StatusEffects.UnlockedSalamanderTail],
		[Tail.SCORPION, StatusEffects.UnlockedScorpionTail],
		[Tail.SHARK, StatusEffects.UnlockedSharkTail],
		[Tail.SPIDER_ADBOMEN, StatusEffects.UnlockedSpiderTail],
		[Tail.SQUIRREL, null],
		[Tail.THUNDERBIRD, null],
		[Tail.TWINKASHA, null],
		[Tail.USHI_ONI, null],
		[Tail.WEASEL, null],
		[Tail.WENDIGO, null],
		[Tail.WOLF, null],
		[Tail.YGGDRASIL, null],
	]);
	private const METAMORPH_FOX_TAILS:Object = createMapFromPairs([
		[1, StatusEffects.UnlockedFoxTail],
		[2, StatusEffects.UnlockedFoxTail2nd],
		[3, StatusEffects.UnlockedFoxTail3rd],
		[4, StatusEffects.UnlockedFoxTail4th],
		[5, StatusEffects.UnlockedFoxTail5th],
		[6, StatusEffects.UnlockedFoxTail6th]
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
