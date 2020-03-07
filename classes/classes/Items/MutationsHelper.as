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
			if (player.isTaur()) outputText("\n\nYour quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side.  Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow.  When it finally stops, <b>you look down to behold your new pair of human legs</b>!");
			else if (player.isGoo()) outputText("\n\nYour lower body rushes inward, molding into two leg-like shapes that gradually stiffen up.  In moments they solidify into normal-looking legs, complete with regular, human feet.  <b>You now have normal feet!</b>");
			else if (player.isNaga()) outputText("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly where your new feet are forming.  <b>You have human legs again.</b>");
			else if (player.isScylla()) outputText("\n\nYou collapse as your tentacle legs starts to merge.  The pain is immense, particularly where your new feet are forming.  <b>You have human legs again.</b>");
			else if (player.isAlraune()) {
				outputText("\n\nYou suddenly lose all feeling from the waist down, your pitcher quickly withering and dying. Soon after it began, your pitcher is reduced to nothing but dust, leaving you to stand on two ordinary human legs. ");
				outputText("On the ground is all that is left of your flower, a single petal still intact that you proceed to put in your bag. Something tells you you will need it to become an alraune again.  <b>You have human legs again.</b>");
			}
			else /*if (player.isBiped()) */outputText("\n\nYou collapse as your legs shift and twist.  By the time the pain subsides, you notice that you have normal legs and normal feet.  <b>You now have normal feet!</b>");
			if (player.hasStatusEffect(StatusEffects.HydraTailsPlayer)) player.removeStatusEffect(StatusEffects.HydraTailsPlayer);
			setLowerBody(LowerBody.HUMAN);
			player.legCount = 2;
			changes++;
		}

		public function humanizeSkin(degargoylize:Boolean=false):void {
			switch (player.coatType()) {
				case Skin.FUR:
					outputText("\n\nYour fur itches incessantly, so you start scratching it.  It starts coming off in big clumps before the whole mess begins sloughing off your body.  In seconds, your skin is nude.  <b>You've lost your fur!</b>");
					break;
				case Skin.SCALES:
					outputText("\n\nYour scales itch incessantly, so you scratch at them.  They start falling off wholesale, leaving you standing in a pile of scales after only a few moments.  <b>You've lost your scales!</b>");
					break;
				case Skin.DRAGON_SCALES:
					outputText("\n\nYour dragon scales itch incessantly, so you scratch at them.  They start falling off wholesale, leaving you standing in a pile of scales after only a few moments.  <b>You've lost your dragon scales!</b>");
					break;
				default:
					outputText("\n\nYour [skin noadj] itches incessantly, and as you scratch it shifts and changes, becoming normal human-like skin.  <b>Your skin is once again normal!</b>");
			}
			player.skin.setBaseOnly({type: Skin.PLAIN, adj:""});
			if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedHumanSkin)) {
				outputText("\n\n<b>Genetic Memory: Human skin - Memorized!</b>\n\n");
				player.createStatusEffect(StatusEffects.UnlockedHumanSkin, 0, 0, 0, 0);
			}
			changes++;
		}

		public function growChitin(color:String,coverage:int=Skin.COVERAGE_HIGH):void {
			if (player.hasScales()) outputText("\n\nYour [skin coat.color] scales begin to itch insufferably.  You reflexively scratch yourself, setting off an avalanche of discarded scales.  The itching intensifies as you madly scratch and tear at yourself, revealing a coat of [skin coat.type].  At last the itching stops as <b>you brush a few more loose scales from your new chitin exoskeleton.</b>");
			else if (player.hasFur()) outputText("Your skin suddenly feels itchy as your [skin coat.type] begins falling out in clumps, <b>revealing smooth chitin</b> underneath.");
			else outputText("\n\nAn itchy feeling springs up over every inch of your [skin.type].  As you scratch yourself madly, you feel your skin hardening until <b>you are wholy covered in chitin.</b>");
			player.skin.growCoat(Skin.CHITIN,{color:color},coverage);
			changes++;
		}

		public function humanizeEars():void {
			outputText("\n\nOuch, your head aches! It feels like your ears are being yanked out of your head, and when you reach up to hold your aching noggin, you find they've vanished! Swooning and wobbling with little sense of balance, you nearly fall a half-dozen times before <b>a pair of normal, human ears sprout from the sides of your head.</b> You had almost forgotten what human ears felt like!");
			setEarType(Ears.HUMAN);
			changes++;
		}

		public function humanizeFace():void {
			outputText("\n\nSudden agony sweeps over your [face], your visage turning hideous as bones twist and your jawline shifts. The pain slowly vanishes, leaving you weeping into your fingers. When you pull your hands away you realize you've been left with a completely normal, <b>human face</b>.");
			setFaceType(Face.HUMAN);
			changes++;
		}

		public function humanizeEyes():void {
			if (player.eyes.type == Eyes.BLACK_EYES_SAND_TRAP) {
				outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
			}
			else {
				outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [feet] from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
				if (player.eyes.type == Eyes.FOUR_SPIDER_EYES) outputText("  Your multiple, arachnid eyes are gone!</b>");
				outputText("  <b>You have normal, humanoid eyes again.</b>");
			}
			setEyeType(Eyes.HUMAN);
			changes++;
		}

		public function humanizeArms(degargoylize:Boolean=false):void {
			switch (player.arms.type) {
				case Arms.HUMAN:
					return;
				case Arms.WOLF:
				case Arms.FOX:
				case Arms.LION:
				case Arms.YETI:
				case Arms.DEVIL:
				case Arms.CAT:
				case Arms.BOAR:
				case Arms.BEAR:
				case Arms.RAIJU_2:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' [skin coat.color] fur is flaking away, leaving [skin base.type] behind.  Also the claws on your fingers reverts back into ordinary nails.");
					break;
				case Arms.DISPLACER:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' [skin coat.color] fur is flaking away, leaving [skin base.type] behind.  Also the claws on your fingers reverts back into ordinary nails.");
					outputText("\n\nYou feel highly uncomfortable as your extra set of arms vanishes into your body following the loss of your leonine paw hands. Guess your back with only two arms now.");
					break;
				case Arms.ELF:
				case Arms.KITSUNE:
				case Arms.ONI:
				case Arms.ORC:
				case Arms.RAIJU:
				case Arms.PIG:
				case Arms.YUKI_ONNA:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' claws retracting back into ordinary nails. You hand looks human again.");
					break;
				case Arms.SHARK:
				case Arms.ORCA:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' fin suddenly fell down, leaving [skin base.type] behind.  Also webbing between your fingers slowly disappearing.");
					break;
				case Arms.PLANT:
				case Arms.PLANT2:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' vines are withering.  Leaves also falling donw, leaving [skin base.type] behind.");
					break;
				case Arms.SALAMANDER:
				case Arms.LIZARD:
				case Arms.DRAGON:
				case Arms.HYDRA:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' scales are flaking away.  The leathery [skin coat.noadj] [skin coat.isare] soon gone, leaving [skin base.type] behind.");
					break;
				case Arms.BEE:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' chitinous covering and fuzz is flaking away.  The glossy black and yellow coating is soon gone, leaving [skin base.type] behind.");
					break;
				case Arms.MANTIS:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' chitinous covering is flaking away and scythe shrinking until it vanish completly.  The glossy green coating is soon gone, leaving [skin base.type] behind.");
					break;
				case Arms.SPIDER:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' chitinous covering is flaking away.  The glossy black coating is soon gone, leaving [skin base.type] behind.");
					break;
				case Arms.HARPY:
				case Arms.PHOENIX:
				case Arms.AVIAN:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your feathery arms are shedding their feathery coating.  The wing-like shape your arms once had is gone in a matter of moments, leaving [skin] behind.");
					break;
				case Arms.GARGOYLE:
					if (!degargoylize) return;
					outputText("You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. ");
					break;
				default:
					outputText("You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. ");
					break;
			}
			outputText("You now have <b>human arms</b>!");
			setArmType(Arms.HUMAN);
			changes++;
		}

		public function removeWings(degargoylize:Boolean=false):void {
			if (player.wings.type == Wings.GARGOYLE_LIKE_LARGE && !degargoylize) return;
			if (player.wings.type == Wings.NONE) return;
			switch(rand(2)) {
				case 0:
					outputText("\n\nSensation fades from your " + player.wings.desc + " wings slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.");
					break;
				case 1:
					outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into each of your shoulder-blades.  After a moment the pain passes, though your wings are gone!");
					break;
			}
			setWingType(Wings.NONE, "non-existant");
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
		if (player.findPerk(PerkLib.HistoryAlchemist) >= 0 || player.findPerk(PerkLib.PastLifeAlchemist) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.Enhancement) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.Fusion) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.Enchantment) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.Refinement) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.Saturation) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.Perfection) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.Creationism) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.EzekielBlessing) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
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

	public function setAntennae(antennae:int):Boolean {
		return setBodyPartType("antennae.type", METAMORPH_ANTENNAE, antennae);
	}
	private const METAMORPH_ANTENNAE:Object = createMapFromPairs([
		[Antennae.BEE, StatusEffects.UnlockedBeeAntennae],
		[Antennae.COCKATRICE, null],
		[Antennae.FIRE_SNAIL, null],
		[Antennae.NONE, StatusEffects.UnlockedHumanNoAntennae],
		[Antennae.MANTIS, StatusEffects.UnlockedMantisAntennae],
		[Antennae.MOTH, null],
	]);
	public function setArmType(armType:int):Boolean {
		return setBodyPartType("arms.type", METAMORPH_ARMS, armType);
	}
	private const METAMORPH_ARMS:Object = createMapFromPairs([
		[Arms.AVIAN, null],
		[Arms.BEAR, null],
		[Arms.BEE, StatusEffects.UnlockedBeeArms],
		[Arms.BOAR, StatusEffects.UnlockedBoarArms],
		[Arms.CAT, StatusEffects.UnlockedCatArms],
		[Arms.DISPLACER, StatusEffects.UnlockedDisplacerArms],
		[Arms.DRAGON, StatusEffects.UnlockedDraconicArms],
		[Arms.DEVIL, StatusEffects.UnlockedDevilArms],
		[Arms.ELF, StatusEffects.UnlockedElfArms],
		[Arms.FOX, StatusEffects.UnlockedFoxArms],
		[Arms.GARGOYLE, null],
		[Arms.GARGOYLE_2, null],
		[Arms.GHOST, null],
		[Arms.GOO, null],
		[Arms.GRYPHON, null],
		[Arms.HARPY, StatusEffects.UnlockedHarpyArms],
		[Arms.HINEZUMI, null],
		[Arms.HUMAN, StatusEffects.UnlockedHumanArms],
		[Arms.HYDRA, null],
		[Arms.JIANGSHI, null],
		[Arms.KITSUNE, StatusEffects.UnlockedKitsuneArms],
		[Arms.LION, StatusEffects.UnlockedLionArms],
		[Arms.LIZARD, StatusEffects.UnlockedLizardArms],
		[Arms.MANTIS, StatusEffects.UnlockedMantisArms],
		[Arms.ONI, StatusEffects.UnlockedOniArms],
		[Arms.ORC, StatusEffects.UnlockedOrcArms],
		[Arms.ORCA, StatusEffects.UnlockedOrcaArms],
		[Arms.PHOENIX, StatusEffects.UnlockedPhoenixArms],
		[Arms.PIG, StatusEffects.UnlockedPigArms],
		[Arms.PLANT, null],
		[Arms.PLANT2, null],
		[Arms.RAIJU, StatusEffects.UnlockedRaijuArms],
		[Arms.RAIJU_2, StatusEffects.UnlockedRaijuArms2],
		[Arms.RED_PANDA, StatusEffects.UnlockedRedPandaArms],
		[Arms.SALAMANDER, StatusEffects.UnlockedSalamanderArms],
		[Arms.SHARK, StatusEffects.UnlockedSharkArms],
		[Arms.SPHINX, StatusEffects.UnlockedSphinxArms],
		[Arms.SPIDER, StatusEffects.UnlockedSpiderArms],
		[Arms.WOLF, null],
		[Arms.YETI, null],
		[Arms.YUKI_ONNA, null],
	]);

	public function setEarType(earType:int):Boolean {
		return setBodyPartType("ears.type", METAMORPH_EARS, earType);
	}
	private const METAMORPH_EARS:Object = createMapFromPairs([
		[Ears.AVIAN, null],
		[Ears.BAT, StatusEffects.UnlockedBatEars],
		[Ears.BEAR, null],
		[Ears.BUNNY, null],
		[Ears.CAT, StatusEffects.UnlockedCatEars],
		[Ears.COW, StatusEffects.UnlockedCowEars],
		[Ears.DEER, null],
		[Ears.DISPLACER, StatusEffects.UnlockedDisplacerEars],
		[Ears.DOG, null],
		[Ears.DRAGON, StatusEffects.UnlockedDraconicEars],
		[Ears.ECHIDNA, null],
		[Ears.ELFIN, StatusEffects.UnlockedElfinEars],
		[Ears.ELVEN, StatusEffects.UnlockedElfEars],
		[Ears.FERRET, null],
		[Ears.FOX, StatusEffects.UnlockedFoxEars],
		[Ears.GOAT, StatusEffects.UnlockedGoatEars],
		[Ears.GRYPHON, null],
		[Ears.HORSE, StatusEffects.UnlockedHorseEars],
		[Ears.HUMAN, StatusEffects.UnlockedHumanEars],
		[Ears.KANGAROO, null],
		[Ears.LION, StatusEffects.UnlockedLionEars],
		[Ears.LIZARD, StatusEffects.UnlockedLizardEars],
		[Ears.MOUSE, null],
		[Ears.ONI, StatusEffects.UnlockedOniEars],
		[Ears.ORCA, StatusEffects.UnlockedOrcaEars],
		[Ears.PANDA, null],
		[Ears.PIG, StatusEffects.UnlockedPigEars],
		[Ears.RACCOON, null],
		[Ears.RED_PANDA, StatusEffects.UnlockedRedPandaEars],
		[Ears.RHINO, null],
		[Ears.SHARK, null],
		[Ears.SNAKE, StatusEffects.UnlockedSnakeEars],
		[Ears.VAMPIRE, StatusEffects.UnlockedVampireEars],
		[Ears.WEASEL, StatusEffects.UnlockedRaijuEars],
		[Ears.WOLF, null],
		[Ears.YETI, null],
	]);

	public function setEyeType(eyeType:int):Boolean {
		return setBodyPartType("eyes.type", METAMORPH_EYES, eyeType);
	}
	public function setEyeTypeAndColor(eyeType:int, color:String):Boolean {
		player.eyes.colour = color;
		return setBodyPartType("eyes.type", METAMORPH_EYES, eyeType);
	}
	private const METAMORPH_EYES:Object = createMapFromPairs([
		[Eyes.BEAR, null],
		[Eyes.BLACK_EYES_SAND_TRAP, null],
		[Eyes.CAT_SLITS, StatusEffects.UnlockedCatEyes],
		[Eyes.DISPLACER, StatusEffects.UnlockedDisplacerEyes],
		[Eyes.DRAGON, StatusEffects.UnlockedDraconicEyes],
		[Eyes.DEVIL, StatusEffects.UnlockedDevilEyes],
		[Eyes.ELF, StatusEffects.UnlockedElfEyes],
		[Eyes.FENRIR, null],
		[Eyes.FIRE_SNAIL, null],
		[Eyes.FOUR_SPIDER_EYES, StatusEffects.UnlockedSpiderFourEyes],
		[Eyes.FOX, StatusEffects.UnlockedFoxEyes],
		[Eyes.GEMSTONES, null],
		[Eyes.GHOST, null],
		[Eyes.GORGON, StatusEffects.UnlockedGorgonEyes],
		[Eyes.GRYPHON, null],
		[Eyes.HINEZUMI, null],
		[Eyes.HUMAN, StatusEffects.UnlockedHumanEyes],
		[Eyes.INFERNAL, StatusEffects.UnlockedHellcatInfernalEyes],
		[Eyes.JIANGSHI, null],
		[Eyes.MANTICORE, StatusEffects.UnlockedManticoreEyes],
		[Eyes.ONI, StatusEffects.UnlockedOniEyes],
		[Eyes.ORC, StatusEffects.UnlockedOrcEyes],
		[Eyes.RAIJU, StatusEffects.UnlockedRaijuEyes],
		[Eyes.REPTILIAN, StatusEffects.UnlockedLizardEyes],
		[Eyes.SNAKE, StatusEffects.UnlockedSnakeEyes],
		[Eyes.VAMPIRE, StatusEffects.UnlockedVampireEyes],
	]);

	public function setFaceType(faceType:int):Boolean {
		return setBodyPartType("faceType", METAMORPH_FACES, faceType);
	}
	private const METAMORPH_FACES:Object = createMapFromPairs([
		[Face.AVIAN, null],
		[Face.BEAR, null],
		[Face.BOAR, StatusEffects.UnlockedBoarFace],
		[Face.BUCKTEETH, null],
		[Face.BUCKTOOTH, null],
		[Face.BUNNY, null],
		[Face.CAT, StatusEffects.UnlockedCatFace],
		[Face.CAT_CANINES, StatusEffects.UnlockedCatFangs],
		[Face.CHESHIRE, StatusEffects.UnlockedCheshireFace],
		[Face.CHESHIRE_SMILE,StatusEffects.UnlockedCheshireSmile],
		[Face.COW_MINOTAUR, StatusEffects.UnlockedCowMinotaurFace],
		[Face.DEER, null],
		[Face.DOG, null],
		[Face.DRAGON, StatusEffects.UnlockedDraconicFace],
		[Face.DRAGON_FANGS, StatusEffects.UnlockedDraconicFangs],
		[Face.DEVIL_FANGS, StatusEffects.UnlockedDevilFangs],
		[Face.ECHIDNA, null],
		[Face.FERRET, null],
		[Face.FERRET_MASK, null],
		[Face.FIRE_SNAIL, null],
		[Face.FOX, StatusEffects.UnlockedFoxFace],
		[Face.GHOST, null],
		[Face.HORSE, StatusEffects.UnlockedHorseFace],
		[Face.HUMAN, StatusEffects.UnlockedHumanFace],
		[Face.JABBERWOCKY, null],
		[Face.JIANGSHI, null],
		[Face.KANGAROO, null],
		[Face.LIZARD, StatusEffects.UnlockedLizardFace],
		[Face.MANTICORE, StatusEffects.UnlockedManticoreFace],
		[Face.MOUSE, null],
		[Face.ONI_TEETH, StatusEffects.UnlockedOniFace],
		[Face.ORC_FANGS, StatusEffects.UnlockedOrcFangs],
		[Face.ORCA, StatusEffects.UnlockedOrcaFace],
		[Face.PANDA, null],
		[Face.PIG, StatusEffects.UnlockedPigFace],
		[Face.PLANT_DRAGON, null],
		[Face.RACCOON, null],
		[Face.RACCOON_MASK, null],
		[Face.RAIJU_FANGS, StatusEffects.UnlockedRaijuFace],
		[Face.RED_PANDA, StatusEffects.UnlockedRedPandaFace],
		[Face.RHINO, null],
		[Face.SALAMANDER_FANGS, StatusEffects.UnlockedSalamanderFace],
		[Face.SHARK_TEETH, StatusEffects.UnlockedSharkTeeth],
		[Face.SNAKE_FANGS, StatusEffects.UnlockedSnakeFangs],
		[Face.SPIDER_FANGS, StatusEffects.UnlockedSpiderFangs],
		[Face.VAMPIRE, StatusEffects.UnlockedVampireFace],
		[Face.WOLF, null],
		[Face.WOLF_FANGS, null],
		[Face.YETI_FANGS, null],
		[Face.YUKI_ONNA, null],
	]);

	public function setGillType(gillType:int):Boolean {
		return setBodyPartType("gills.type", METAMORPH_GILLS, gillType);
	}
	private const METAMORPH_GILLS:Object = createMapFromPairs([
		[Gills.ANEMONE, null],
		[Gills.FISH, StatusEffects.UnlockedFishGills],
		[Gills.GILLS_IN_TENTACLE_LEGS, null],
		[Gills.NONE, StatusEffects.UnlockedHumanNoGills],
	]);

	public function setHairType(hairType:int):Boolean {
		return setBodyPartType("hairType", METAMORPH_HAIR_TYPES, hairType);
	}
	private const METAMORPH_HAIR_TYPES:Object = createMapFromPairs([
		[Hair.ANEMONE, null],
		[Hair.BURNING, StatusEffects.UnlockedHellcatBurningHair],
		[Hair.FEATHER, StatusEffects.UnlockedHarpyHair],
		[Hair.FLUFFY, null],
		[Hair.GHOST, null],
		[Hair.GOO, null],
		[Hair.GORGON, StatusEffects.UnlockedGorgonHair],
		[Hair.GRASS, null],
		[Hair.LEAF, null],
		[Hair.NORMAL, StatusEffects.UnlockedHumanHair],
		[Hair.QUILL, null],
		[Hair.SILKEN, StatusEffects.UnlockedElfHair],
		[Hair.SNOWY, null],
		[Hair.STORM, StatusEffects.UnlockedRaijuHair],
	]);

	/**
	 * @param hornType HORN_TYPE_xxxx
	 * @param hornCount New horns count; -1 if "don't change"
	 */
	public function setHornType(hornType:int, hornCount:int = -1):Boolean {
		var a:Boolean = setBodyPartType("horns.type", METAMORPH_HORNS, hornType);
		if (hornCount >= 0) player.horns.count = hornCount;
		return a;
	}
	private const METAMORPH_HORNS:Object = createMapFromPairs([
		[Horns.ANTLERS, null],
		[Horns.BICORN, StatusEffects.UnlockedBicornHorns],
		[Horns.COW_MINOTAUR, StatusEffects.UnlockedCowMinotaurHorns],
		[Horns.DEMON, StatusEffects.UnlockedDemonHorns],
		[Horns.DRACONIC_X2, StatusEffects.UnlockedDraconicX2],
		[Horns.DRACONIC_X4_12_INCH_LONG, StatusEffects.UnlockedDraconicX4],
		[Horns.GARGOYLE, null],
		[Horns.GHOSTLY_WISPS, null],
		[Horns.GOAT, StatusEffects.UnlockedGoatHorns],
		[Horns.NONE, StatusEffects.UnlockedHumanNoHorns],
		[Horns.OAK, null],
		[Horns.ONI, StatusEffects.UnlockedOniSingleHorn],
		[Horns.ONI_X2, StatusEffects.UnlockedOniTwinHorns],
		[Horns.ORCHID, null],
		[Horns.RHINO, null],
		[Horns.SPELL_TAG, null],
		[Horns.UNICORN, StatusEffects.UnlockedUnicornHorn],
	]);

	public function setLowerBody(lowerBody:int):Boolean {
		return setBodyPartType("lowerBody", METAMORPH_LOWER_BODIES, lowerBody);
	}
	private const METAMORPH_LOWER_BODIES:Object = createMapFromPairs([
		[LowerBody.AVIAN, null],
		[LowerBody.BEAR, null],
		[LowerBody.BEE, StatusEffects.UnlockedBeeLegs],
		[LowerBody.BUNNY, null],
		[LowerBody.CAT, StatusEffects.UnlockedCatLegs],
		[LowerBody.CENTAUR, null],
		[LowerBody.CHITINOUS_SPIDER_LEGS, StatusEffects.UnlockedSpiderLegs],
		[LowerBody.CLOVEN_HOOFED, StatusEffects.UnlockedClovenHoofedLegs],
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
		[LowerBody.LION, StatusEffects.UnlockedLionLegs],
		[LowerBody.LIZARD, StatusEffects.UnlockedLizardLegs],
		[LowerBody.MANTIS, StatusEffects.UnlockedMantisLegs],
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
		[LowerBody.WOLF, null],
		[LowerBody.YETI, null],
		[LowerBody.YGG_ROOT_CLAWS, null],
		[LowerBody.YUKI_ONNA, null],
	]);

	public function setRearBody(rearBody:int):Boolean {
		return setBodyPartType("rearBody.type", METAMORPH_REAR_BODIES, rearBody);
	}
	private const METAMORPH_REAR_BODIES:Object = createMapFromPairs([
		[RearBody.BAT_COLLAR, StatusEffects.UnlockedBatCollar],
		[RearBody.BEHEMOTH, null],
		[RearBody.DISPLACER_TENTACLES, StatusEffects.UnlockedDisplacerBTentacles],
		[RearBody.DRACONIC_MANE, null],
		[RearBody.DRACONIC_SPIKES, null],
		[RearBody.FENRIR_ICE_SPIKES, null],
		[RearBody.GHOSTLY_AURA, null],
		[RearBody.GLACIAL_AURA, null],
		[RearBody.LION_MANE, StatusEffects.UnlockedLionMane],
		[RearBody.METAMORPHIC_GOO, null],
		[RearBody.NONE, StatusEffects.UnlockedHumanNoRearBody],
		[RearBody.ORCA_BLOWHOLE, StatusEffects.UnlockedOrcaBlowhole],
		[RearBody.RAIJU_MANE, StatusEffects.UnlockedRaijuMane],
		[RearBody.SHARK_FIN, StatusEffects.UnlockedSharkFin],
		[RearBody.SNAIL_SHELL, null],
		[RearBody.WOLF_COLLAR, null],
		[RearBody.YETI_FUR, null],
	]);

	public function setTongueType(tongueType:int):Boolean {
		return setBodyPartType("tongue.type", METAMORPH_TONGUES, tongueType);
	}
	// Here we override flavour text because it is 'tonuge' in StatusEffect id
	// but changing that would break the saves
	private const METAMORPH_TONGUES:Object = createMapFromPairs([
		[Tongue.CAT, [StatusEffects.UnlockedCatTongue, "Cat Tongue"]],
		[Tongue.DEMONIC, [StatusEffects.UnlockedDemonTonuge, "Demonic Tongue"]],
		[Tongue.DRACONIC, [StatusEffects.UnlockedDraconicTongue, "Draconic Tongue"]],
		[Tongue.ECHIDNA, [null, "Echidna Tongue"]],
		[Tongue.GHOST, [null, "Ghost Tongue"]],
		[Tongue.HUMAN, [StatusEffects.UnlockedHumanTongue, "Human Tongue"]],
		[Tongue.ELF, [StatusEffects.UnlockedElfTongue, "Elf Tongue"]],
		[Tongue.SNAKE, [StatusEffects.UnlockedSnakeTongue, "Snake Tongue"]],
		[Tongue.DOG, [null, "Dog Tongue"]],
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
		[Tail.LIZARD, StatusEffects.UnlockedLizardTail],
		[Tail.MANTICORE_PUSSYTAIL, StatusEffects.UnlockedManticoreTail],
		[Tail.MANTIS_ABDOMEN, StatusEffects.UnlockedMantisTail],
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
		[Tail.THUNDERBIRD, null],
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

	public function setWingType(wingType:int, wingDesc:String):Boolean {
		var a:Boolean   = setBodyPartType("wings.type", METAMORPH_WINGS, wingType);
		player.wings.desc = wingDesc;
		return a;
	}
	private const METAMORPH_WINGS:Object = createMapFromPairs([
		[Wings.BAT_LIKE_LARGE, StatusEffects.UnlockedDemonLargeBatWings],
		[Wings.BAT_LIKE_LARGE_2, StatusEffects.UnlockedDemonLargeBatWings2],
		[Wings.BAT_LIKE_TINY, StatusEffects.UnlockedDemonTinyBatWings],
		[Wings.BEE_LIKE_LARGE, StatusEffects.UnlockedBeeWingsLarge],
		[Wings.BEE_LIKE_SMALL, StatusEffects.UnlockedBeeWingsSmall],
		[Wings.DRACONIC_HUGE, StatusEffects.UnlockedDraconicWingsHuge],
		[Wings.DRACONIC_LARGE, StatusEffects.UnlockedDraconicWingsLarge],
		[Wings.DRACONIC_SMALL, StatusEffects.UnlockedDraconicWingsSmall],
		[Wings.ETHEREAL_WINGS, null],
		[Wings.FEATHERED_ALICORN, StatusEffects.UnlockedAlicornWings],
		[Wings.FEATHERED_AVIAN, null],
		[Wings.FEATHERED_LARGE, StatusEffects.UnlockedHarpyWings],
		[Wings.FEATHERED_PHOENIX, StatusEffects.UnlockedPhoenixWings],
		[Wings.FEATHERED_SPHINX, StatusEffects.UnlockedSphinxWings],
		[Wings.FEY_DRAGON_WINGS, null],
		[Wings.GARGOYLE_LIKE_LARGE, null],
		[Wings.GIANT_DRAGONFLY, null],
		[Wings.HARPY, null],
		[Wings.IMP, null],
		[Wings.LEVITATION, null],
		[Wings.MANTICORE_LIKE_LARGE, StatusEffects.UnlockedManticoreWingsLarge],
		[Wings.MANTICORE_LIKE_SMALL, StatusEffects.UnlockedManticoreWingsSmall],
		[Wings.MANTIS_LIKE_LARGE, StatusEffects.UnlockedMantisWingsLarge],
		[Wings.MANTIS_LIKE_LARGE_2, null],
		[Wings.MANTIS_LIKE_SMALL, StatusEffects.UnlockedMantisWingsSmall],
		[Wings.NIGHTMARE, StatusEffects.UnlockedNightmareWings],
		[Wings.NONE, StatusEffects.UnlockedHumanNoWings],
		[Wings.PLANT, null],
		[Wings.SHARK_FIN, null],
		[Wings.THUNDEROUS_AURA, StatusEffects.UnlockedRaijuThunderousAura],
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
		if (player.findPerk(PerkLib.GeneticMemory) < 0) return false;

		var o:* = dict[tgtType];
		if (o is Array) {
			return addGeneticMemory(o[0], o[1]);
		} else if (o != null) {
			var sat:StatusEffectType = o;
			return addGeneticMemory(sat, sat.id.replace("Unlocked ", ""));
		} else return false;
	}
	public function addGeneticMemory(sat:StatusEffectType, name:String = null):Boolean {
		if (player.findPerk(PerkLib.GeneticMemory) < 0) return false;
		if (sat != null && !player.hasStatusEffect(sat)) {
			outputText("\n\n<b>Genetic Memory: " + name + " - Memorized!</b>\n\n");
			player.createStatusEffect(sat, 0, 0, 0, 0);
			return true;
		}
		return false;
	}
}

}