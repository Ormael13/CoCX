package classes.Items {
	import classes.*;
	import classes.BodyParts.Skin;
	import classes.GlobalFlags.kFLAGS;
	import classes.StatusEffects;
	import classes.StatusEffects;

	/**
	 * Helper class to get rid of the copy&paste-mess in classes.Items.Mutations
	 * @since July 8, 2016
	 * @author Stadler76
	 */
	public class MutationsHelper extends BaseContent
	{
		include "../../../includes/appearanceDefs.as";

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
			player.lowerBody = LOWER_BODY_TYPE_HUMAN;
			player.legCount  = 2;
			changes++;
		}

		public function humanizeSkin(degargoylize:Boolean=false):void {
			switch (player.coatType()) {
				case SKIN_COAT_FUR:
					outputText("\n\nYour fur itches incessantly, so you start scratching it.  It starts coming off in big clumps before the whole mess begins sloughing off your body.  In seconds, your skin is nude.  <b>You've lost your fur!</b>");
					break;
				case SKIN_COAT_SCALES:
					outputText("\n\nYour scales itch incessantly, so you scratch at them.  They start falling off wholesale, leaving you standing in a pile of scales after only a few moments.  <b>You've lost your scales!</b>");
					break;
				case SKIN_COAT_DRAGON_SCALES:
					outputText("\n\nYour dragon scales itch incessantly, so you scratch at them.  They start falling off wholesale, leaving you standing in a pile of scales after only a few moments.  <b>You've lost your dragon scales!</b>");
					break;
				default:
					outputText("\n\nYour [skin noadj] itches incessantly, and as you scratch it shifts and changes, becoming normal human-like skin.  <b>Your skin is once again normal!</b>");
			}
			player.skin.setBaseOnly({type: SKIN_BASE_PLAIN});
			changes++;
		}

		public function growChitin(color:String,coverage:int=Skin.COVERAGE_HIGH):void {
			if (player.hasScales()) outputText("\n\nYour [skin coat.color] scales begin to itch insufferably.  You reflexively scratch yourself, setting off an avalanche of discarded scales.  The itching intensifies as you madly scratch and tear at yourself, revealing a coat of [skin coat.type].  At last the itching stops as <b>you brush a few more loose scales from your new chitin exoskeleton.</b>");
			else if (player.hasFur()) outputText("Your skin suddenly feels itchy as your [skin coat.type] begins falling out in clumps, <b>revealing smooth chitin</b> underneath.");
			else outputText("\n\nAn itchy feeling springs up over every inch of your [skin.type].  As you scratch yourself madly, you feel your skin hardening until <b>you are wholy covered in chitin.</b>");
			player.skin.growCoat(SKIN_COAT_CHITIN,{color:color},coverage);
			changes++;
		}

		public function humanizeEars():void {
			outputText("\n\nOuch, your head aches! It feels like your ears are being yanked out of your head, and when you reach up to hold your aching noggin, you find they've vanished! Swooning and wobbling with little sense of balance, you nearly fall a half-dozen times before <b>a pair of normal, human ears sprout from the sides of your head.</b> You had almost forgotten what human ears felt like!");
			player.earType = EARS_HUMAN;
			changes++;
		}

		public function humanizeFace():void {
			outputText("\n\nSudden agony sweeps over your [face], your visage turning hideous as bones twist and your jawline shifts. The pain slowly vanishes, leaving you weeping into your fingers. When you pull your hands away you realize you've been left with a completely normal, <b>human face</b>.");
			player.faceType = FACE_HUMAN;
			changes++;
		}

		public function humanizeEyes():void {
			if (player.eyeType == EYES_BLACK_EYES_SAND_TRAP) {
				outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
			}
			else {
				outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [feet] from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
				if (player.eyeType == EYES_FOUR_SPIDER_EYES) outputText("  Your multiple, arachnid eyes are gone!</b>");
				outputText("  <b>You have normal, humanoid eyes again.</b>");
			}
			player.eyeType = EYES_HUMAN;
			changes++;
		}

		public function humanizeArms(degargoylize:Boolean=false):void {
			switch (player.armType) {
				case ARM_TYPE_HUMAN:
					return;
				case ARM_TYPE_WOLF:
				case ARM_TYPE_FOX:
				case ARM_TYPE_LION:
				case ARM_TYPE_YETI:
				case ARM_TYPE_DEVIL:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' [skin coat.color] fur is flaking away, leaving [skin base.type] behind.  Also the claws on your fingers reverts back into ordinary nails.");
					break;
				case ARM_TYPE_ELF:
				case ARM_TYPE_KITSUNE:
				case ARM_TYPE_ONI:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' claws retracting back into ordinary nails. You hand looks human again.");
					break;
				case ARM_TYPE_SHARK:
				case ARM_TYPE_ORCA:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' fin suddenly fell down, leaving [skin base.type] behind.  Also webbing between your fingers slowly disappearing.");
					break;
				case ARM_TYPE_PLANT:
				case ARM_TYPE_PLANT2:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' vines are withering.  Leaves also falling donw, leaving [skin base.type] behind.");
					break;
				case ARM_TYPE_SALAMANDER:
				case ARM_TYPE_LIZARD:
				case ARM_TYPE_DRAGON:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' scales are flaking away.  The leathery [skin coat.noadj] [skin coat.isare] soon gone, leaving [skin base.type] behind.");
					break;
				case ARM_TYPE_BEE:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' chitinous covering and fuzz is flaking away.  The glossy black and yellow coating is soon gone, leaving [skin base.type] behind.");
					break;
				case ARM_TYPE_MANTIS:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' chitinous covering is flaking away and scythe shrinking until it vanish completly.  The glossy green coating is soon gone, leaving [skin base.type] behind.");
					break;
				case ARM_TYPE_SPIDER:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your arms' chitinous covering is flaking away.  The glossy black coating is soon gone, leaving [skin base.type] behind.");
					break;
				case ARM_TYPE_HARPY:
				case ARM_TYPE_PHOENIX:
					outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your feathery arms are shedding their feathery coating.  The wing-like shape your arms once had is gone in a matter of moments, leaving [skin] behind.");
					break;
				case ARM_TYPE_GARGOYLE:
					if (!degargoylize) return;
					outputText("You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. ");
					break;
				default:
					outputText("You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. ");
					break;
			}
			outputText("You now have <b>human arms</b>!");
			setArmType(ARM_TYPE_HUMAN);
			changes++;
		}

		public function removeWings(degargoylize:Boolean=false):void {
			if (player.wingType == WING_TYPE_GARGOYLE_LIKE_LARGE && !degargoylize) return;
			if (player.wingType == WING_TYPE_NONE) return;
			switch(rand(2)) {
				case 0:
					outputText("\n\nSensation fades from your " + player.wingDesc + " wings slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.");
					break;
				case 1:
					outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into each of your shoulder-blades.  After a moment the pain passes, though your wings are gone!");
					break;
			}
			player.wingType = WING_TYPE_NONE;
			player.wingDesc = "non-existant";
			changes++;
		}

		public function updateGills(newGillType:int = GILLS_NONE):int
		{
			trace("Called updateGills(" + newGillType + ")");
			var oldgillType:int = player.gillType;
			if (oldgillType == newGillType) return 0; // no change

			setGillType(newGillType);
			changes++;

			// for now, we only have anemone gills on the chest
			switch (newGillType) {
				case GILLS_NONE:
					if (oldgillType == GILLS_ANEMONE) {
						outputText("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your"
						           +" skin.");
					} else { // losing fish gills
						outputText("\n\nYou feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your"
						           +" gills shrink into nothingness, leaving only smooth skin behind. Seems you won't be able to stay in the water"
						           +" quite so long anymore.");
					}
					outputText("  <b>You no longer have gills!</b>");
					return -1; // Gills lost

				case GILLS_ANEMONE:
					if (oldgillType == GILLS_FISH) {
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
					return 1; // Gained gills or gillType changed

				case GILLS_FISH:
					if (oldgillType == GILLS_ANEMONE) {
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
					return 1; // Gained gills or gillType changed

				default:
					player.gillType = oldgillType;
					changes--;
					trace("ERROR: Unimplemented new gillType (" + newGillType + ") used");
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
		return setBodyPartType("antennae", METAMORPH_ANTENNAE, antennae);
	}
	private const METAMORPH_ANTENNAE:Object = createMapFromPairs([
		[ANTENNAE_BEE, StatusEffects.UnlockedBeeAntennae],
	]);
	public function setArmType(armType:int):Boolean {
		return setBodyPartType("armType", METAMORPH_ARMS, armType);
	}
	private const METAMORPH_ARMS:Object = createMapFromPairs([
		[ARM_TYPE_BEE, StatusEffects.UnlockedBeeArms],
		[ARM_TYPE_DRAGON, StatusEffects.UnlockedDraconicArms],
		[ARM_TYPE_DEVIL, null],
		[ARM_TYPE_ELF, null],
		[ARM_TYPE_FOX, StatusEffects.UnlockedFoxArms],
		[ARM_TYPE_GARGOYLE, null],
		[ARM_TYPE_HARPY, StatusEffects.UnlockedHarpyArms],
		[ARM_TYPE_HUMAN, null],
		[ARM_TYPE_KITSUNE, StatusEffects.UnlockedKitsuneArms],
		[ARM_TYPE_LION, null],
		[ARM_TYPE_LIZARD, StatusEffects.UnlockedLizardArms],
		[ARM_TYPE_MANTIS, null],
		[ARM_TYPE_ONI, null],
		[ARM_TYPE_ORCA, StatusEffects.UnlockedOrcaArms],
		[ARM_TYPE_PHOENIX, StatusEffects.UnlockedPhoenixArms],
		[ARM_TYPE_PLANT, null],
		[ARM_TYPE_PLANT2, null],
		[ARM_TYPE_SALAMANDER, StatusEffects.UnlockedSalamanderArms],
		[ARM_TYPE_SHARK, StatusEffects.UnlockedSharkArms],
		[ARM_TYPE_SPIDER, StatusEffects.UnlockedSpiderArms],
		[ARM_TYPE_WOLF, null],
		[ARM_TYPE_YETI, null],
	]);

	public function setEarType(earType:int):Boolean {
		return setBodyPartType("earType", METAMORPH_EARS, earType);
	}
	private const METAMORPH_EARS:Object = createMapFromPairs([
		[EARS_BUNNY, null],
		[EARS_CAT, null],
		[EARS_COW, null],
		[EARS_DEER, null],
		[EARS_DOG, null],
		[EARS_DRAGON, StatusEffects.UnlockedDraconicEars],
		[EARS_ECHIDNA, null],
		[EARS_ELFIN, StatusEffects.UnlockedElfinEars],
		[EARS_ELVEN, null],
		[EARS_FERRET, null],
		[EARS_FOX, StatusEffects.UnlockedFoxEars],
		[EARS_GOAT, null],
		[EARS_HORSE, null],
		[EARS_HUMAN, null],
		[EARS_KANGAROO, null],
		[EARS_LION, null],
		[EARS_LIZARD, StatusEffects.UnlockedLizardEars],
		[EARS_MOUSE, null],
		[EARS_ONI, null],
		[EARS_ORCA, StatusEffects.UnlockedOrcaEars],
		[EARS_PIG, null],
		[EARS_RACCOON, null],
		[EARS_RHINO, null],
		[EARS_SNAKE, StatusEffects.UnlockedSnakeEars],
		[EARS_WOLF, null],
		[EARS_YETI, null],
	]);

	public function setEyeType(eyeType:int):Boolean {
		return setBodyPartType("eyeType", METAMORPH_EYES, eyeType);
	}
	public function setEyeTypeAndColor(eyeType:int, color:String):Boolean {
		player.eyeColor = color;
		return setBodyPartType("eyeType", METAMORPH_EYES, eyeType);
	}
	private const METAMORPH_EYES:Object = createMapFromPairs([
		[EYES_BLACK_EYES_SAND_TRAP, null],
		[EYES_CAT_SLITS, null],
		[EYES_DRAGON, StatusEffects.UnlockedDraconicEyes],
		[EYES_DEVIL, null],
		[EYES_ELF, null],
		[EYES_FENRIR, null],
		[EYES_FOUR_SPIDER_EYES, StatusEffects.UnlockedSpiderFourEyes],
		[EYES_FOX, StatusEffects.UnlockedFoxEyes],
		[EYES_GORGON, StatusEffects.UnlockedGorgonEyes],
		[EYES_HUMAN, null],
		[EYES_MANTICORE, null],
		[EYES_ONI, null],
		[EYES_REPTILIAN, StatusEffects.UnlockedLizardEyes],
		[EYES_SNAKE, StatusEffects.UnlockedSnakeEyes],
	]);

	public function setFaceType(faceType:int):Boolean {
		return setBodyPartType("faceType", METAMORPH_FACES, faceType);
	}
	private const METAMORPH_FACES:Object = createMapFromPairs([
		[FACE_BOAR, null],
		[FACE_BUCKTEETH, null],
		[FACE_BUNNY, null],
		[FACE_CAT, null],
		[FACE_COW_MINOTAUR, null],
		[FACE_DEER, null],
		[FACE_DOG, null],
		[FACE_DRAGON, StatusEffects.UnlockedDraconicFace],
		[FACE_DRAGON_FANGS, StatusEffects.UnlockedDraconicFangs],
		[FACE_DEVIL_FANGS, null],
		[FACE_ECHIDNA, null],
		[FACE_FERRET, null],
		[FACE_FERRET_MASK, null],
		[FACE_FOX, null],
		[FACE_HORSE, null],
		[FACE_HUMAN, null],
		[FACE_KANGAROO, null],
		[FACE_LIZARD, StatusEffects.UnlockedLizardFace],
		[FACE_MANTICORE, null],
		[FACE_MOUSE, null],
		[FACE_ONI_TEETH, null],
		[FACE_ORCA, StatusEffects.UnlockedOrcaFace],
		[FACE_PIG, null],
		[FACE_PLANT_DRAGON, null],
		[FACE_RACCOON, null],
		[FACE_RACCOON_MASK, null],
		[FACE_RHINO, null],
		[FACE_SALAMANDER_FANGS, StatusEffects.UnlockedSalamanderFace],
		[FACE_SHARK_TEETH, StatusEffects.UnlockedSharkTeeth],
		[FACE_SNAKE_FANGS, StatusEffects.UnlockedSnakeFangs],
		[FACE_SPIDER_FANGS, StatusEffects.UnlockedSpiderFangs],
		[FACE_WOLF, null],
		[FACE_YETI_FANGS, null],
	]);

	public function setGillType(gillType:int):Boolean {
		return setBodyPartType("gillType", METAMORPH_GILLS, gillType);
	}
	private const METAMORPH_GILLS:Object = createMapFromPairs([
		[GILLS_ANEMONE, null],
		[GILLS_FISH, StatusEffects.UnlockedFishGills],
		[GILLS_IN_TENTACLE_LEGS, null],
		[GILLS_NONE, null],
	]);

	public function setHairType(hairType:int):Boolean {
		return setBodyPartType("hairType", METAMORPH_HAIR_TYPES, hairType);
	}
	private const METAMORPH_HAIR_TYPES:Object = createMapFromPairs([
		[HAIR_ANEMONE, null],
		[HAIR_FEATHER, StatusEffects.UnlockedHarpyHair],
		[HAIR_FLUFFY, null],
		[HAIR_GHOST, null],
		[HAIR_GOO, null],
		[HAIR_GORGON, StatusEffects.UnlockedGorgonHair],
		[HAIR_GRASS, null],
		[HAIR_LEAF, null],
		[HAIR_NORMAL, null],
		[HAIR_QUILL, null],
		[HAIR_SILKEN, null],
	]);

	/**
	 * @param hornType HORN_TYPE_xxxx
	 * @param hornCount New horn count; -1 if "don't change"
	 */
	public function setHornType(hornType:int, hornCount:int = -1):Boolean {
		var a:Boolean = setBodyPartType("hornType", METAMORPH_HORNS, hornType);
		if (hornCount >= 0) player.horns = hornCount;
		return a;
	}
	private const METAMORPH_HORNS:Object = createMapFromPairs([
		[HORNS_ANTLERS, null],
		[HORNS_COW_MINOTAUR, null],
		[HORNS_DEMON, StatusEffects.UnlockedDemonHorns],
		[HORNS_DRACONIC_X2, StatusEffects.UnlockedDraconicX2],
		[HORNS_DRACONIC_X4_12_INCH_LONG, StatusEffects.UnlockedDraconicX4],
		[HORNS_GARGOYLE, null],
		[HORNS_GOAT, null],
		[HORNS_NONE, null],
		[HORNS_OAK, null],
		[HORNS_ONI, null],
		[HORNS_ONI_X2, null],
		[HORNS_ORCHID, null],
		[HORNS_RHINO, null],
		[HORNS_UNICORN, null],
	]);

	public function setLowerBody(lowerBody:int):Boolean {
		return setBodyPartType("lowerBody", METAMORPH_LOWER_BODIES, lowerBody);
	}
	private const METAMORPH_LOWER_BODIES:Object = createMapFromPairs([
		[LOWER_BODY_TYPE_BEE, StatusEffects.UnlockedBeeLegs],
		[LOWER_BODY_TYPE_BUNNY, null],
		[LOWER_BODY_TYPE_CAT, null],
		[LOWER_BODY_TYPE_CENTAUR, null],
		[LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS, StatusEffects.UnlockedSpiderLegs],
		[LOWER_BODY_TYPE_CLOVEN_HOOFED, null],
		[LOWER_BODY_TYPE_DEERTAUR, null],
		[LOWER_BODY_TYPE_DEMONIC_CLAWS, StatusEffects.UnlockedDemonClawedLegs],
		[LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS, StatusEffects.UnlockedDemonHighHeels],
		[LOWER_BODY_TYPE_DOG, null],
		[LOWER_BODY_TYPE_DRAGON, StatusEffects.UnlockedDraconicLegs],
		[LOWER_BODY_TYPE_DRIDER_LOWER_BODY, StatusEffects.UnlockedDriderLegs],
		[LOWER_BODY_TYPE_ECHIDNA, null],
		[LOWER_BODY_TYPE_ELF, null],
		[LOWER_BODY_TYPE_FERRET, null],
		[LOWER_BODY_TYPE_FOX, StatusEffects.UnlockedFoxLowerBody],
		[LOWER_BODY_TYPE_GARGOYLE, null],
		[LOWER_BODY_TYPE_GOO, null],
		[LOWER_BODY_TYPE_HARPY, StatusEffects.UnlockedHarpyLegs],
		[LOWER_BODY_TYPE_HOOFED, null],
		[LOWER_BODY_TYPE_HUMAN, null],
		[LOWER_BODY_TYPE_KANGAROO, null],
		[LOWER_BODY_TYPE_LION, null],
		[LOWER_BODY_TYPE_LIZARD, StatusEffects.UnlockedLizardLegs],
		[LOWER_BODY_TYPE_MANTIS, null],
		[LOWER_BODY_TYPE_NAGA, StatusEffects.UnlockedSnakeLowerBody],
		[LOWER_BODY_TYPE_ONI, null],
		[LOWER_BODY_TYPE_ORCA, StatusEffects.UnlockedOrcaLegs],
		[LOWER_BODY_TYPE_PLANT_FLOWER, null],
		[LOWER_BODY_TYPE_PLANT_HIGH_HEELS, null],
		[LOWER_BODY_TYPE_PLANT_ROOT_CLAWS, null],
		[LOWER_BODY_TYPE_PONY, null],
		[LOWER_BODY_TYPE_RACCOON, null],
		[LOWER_BODY_TYPE_SALAMANDER, StatusEffects.UnlockedSalamanderLegs],
		[LOWER_BODY_TYPE_SCYLLA, null],
		[LOWER_BODY_TYPE_SHARK, StatusEffects.UnlockedSharkLegs],
		[LOWER_BODY_TYPE_WOLF, null],
		[LOWER_BODY_TYPE_YETI, null],
		[LOWER_BODY_TYPE_YGG_ROOT_CLAWS, null],
	]);

	public function setRearBody(rearBody:int):Boolean {
		return setBodyPartType("rearBody", METAMORPH_REAR_BODIES, rearBody);
	}
	private const METAMORPH_REAR_BODIES:Object = createMapFromPairs([
		[REAR_BODY_BEHEMOTH, null],
		[REAR_BODY_DRACONIC_MANE, null],
		[REAR_BODY_DRACONIC_SPIKES, null],
		[REAR_BODY_FENRIR_ICE_SPIKES, null],
		[REAR_BODY_LION_MANE, null],
		[REAR_BODY_NONE, null],
		[REAR_BODY_ORCA_BLOWHOLE, StatusEffects.UnlockedOrcaBlowhole],
		[REAR_BODY_SHARK_FIN, StatusEffects.UnlockedSharkFin],
	]);

	public function setTongueType(tongueType:int):Boolean {
		return setBodyPartType("tongueType", METAMORPH_TONGUES, tongueType);
	}
	// Here we override flavour text because it is 'tonuge' in StatusEffect id
	// but changing that would break the saves
	private const METAMORPH_TONGUES:Object = createMapFromPairs([
		[TONGUE_CAT, [null, "Cat Tongue"]],
		[TONGUE_DEMONIC, [StatusEffects.UnlockedDemonTonuge, "Demonic Tongue"]],
		[TONGUE_DRACONIC, [StatusEffects.UnlockedDraconicTongue, "Draconic Tongue"]],
		[TONGUE_ECHIDNA, [null, "Echidna Tongue"]],
		[TONGUE_HUMAN, [null, "Human Tongue"]],
		[TONGUE_ELF, [null, "Elf Tongue"]],
		[TONGUE_SNAKE, [StatusEffects.UnlockedSnakeTongue, "Snake Tongue"]],
	]);

	/**
	 * @param tailType TAIL_TYPE_xxx
	 * @param tailCount new tail count, -1 means "do not change"
	 */
	public function setTailType(tailType:int, tailCount:int = -1):Boolean {
		var a:Boolean = setBodyPartType("tailType", METAMORPH_TAILS, tailType);
		if (tailCount < 0) return a;
		if (tailType == TAIL_TYPE_FOX) {
			var b:Boolean = setBodyPartType("tailCount", METAMORPH_FOX_TAILS, tailCount);
			return a || b;
		} else {
			player.tailCount = tailCount;
			return a;
		}
	}
	private const METAMORPH_TAILS:Object     = createMapFromPairs([
		[TAIL_TYPE_BEE_ABDOMEN, StatusEffects.UnlockedBeeTail],
		[TAIL_TYPE_BEHEMOTH, null],
		[TAIL_TYPE_CAT, null],
		[TAIL_TYPE_COW, null],
		[TAIL_TYPE_DEER, null],
		[TAIL_TYPE_DEMONIC, StatusEffects.UnlockedDemonTail],
		[TAIL_TYPE_DOG, null],
		[TAIL_TYPE_DRACONIC, StatusEffects.UnlockedDraconicTail],
		[TAIL_TYPE_ECHIDNA, null],
		[TAIL_TYPE_FERRET, null],
		[TAIL_TYPE_FOX, StatusEffects.UnlockedFoxTail],
		[TAIL_TYPE_GARGOYLE, null],
		[TAIL_TYPE_GOAT, null],
		[TAIL_TYPE_HARPY, StatusEffects.UnlockedHarpyTail],
		[TAIL_TYPE_HORSE, null],
		[TAIL_TYPE_KANGAROO, null],
		[TAIL_TYPE_KITSHOO, null],
		[TAIL_TYPE_LIZARD, StatusEffects.UnlockedLizardTail],
		[TAIL_TYPE_MANTICORE_PUSSYTAIL, null],
		[TAIL_TYPE_MANTIS_ABDOMEN, null],
		[TAIL_TYPE_MOUSE, null],
		[TAIL_TYPE_NONE, null],
		[TAIL_TYPE_ORCA, StatusEffects.UnlockedOrcaTail],
		[TAIL_TYPE_PIG, null],
		[TAIL_TYPE_RABBIT, null],
		[TAIL_TYPE_RACCOON, null],
		[TAIL_TYPE_RHINO, null],
		[TAIL_TYPE_SALAMANDER, StatusEffects.UnlockedSalamanderTail],
		[TAIL_TYPE_SCORPION, null],
		[TAIL_TYPE_SHARK, StatusEffects.UnlockedSharkTail],
		[TAIL_TYPE_SPIDER_ADBOMEN, StatusEffects.UnlockedSpiderTail],
		[TAIL_TYPE_WOLF, null],
		[TAIL_TYPE_YGGDRASIL, null],
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
		var a:Boolean   = setBodyPartType("wingType", METAMORPH_WINGS, wingType);
		player.wingDesc = wingDesc;
		return a;
	}
	private const METAMORPH_WINGS:Object = createMapFromPairs([
		[WING_TYPE_BAT_LIKE_LARGE, StatusEffects.UnlockedDemonLargeBatWings],
		[WING_TYPE_BAT_LIKE_LARGE_2, StatusEffects.UnlockedDemonLargeBatWings2],
		[WING_TYPE_BAT_LIKE_TINY, StatusEffects.UnlockedDemonTinyBatWings],
		[WING_TYPE_BEE_LIKE_LARGE, StatusEffects.UnlockedBeeWingsLarge],
		[WING_TYPE_BEE_LIKE_SMALL, StatusEffects.UnlockedBeeWingsSmall],
		[WING_TYPE_DRACONIC_HUGE, StatusEffects.UnlockedDraconicWingsHuge],
		[WING_TYPE_DRACONIC_LARGE, StatusEffects.UnlockedDraconicWingsLarge],
		[WING_TYPE_DRACONIC_SMALL, StatusEffects.UnlockedDraconicWingsSmall],
		[WING_TYPE_FEATHERED_ALICORN, null],
		[WING_TYPE_FEATHERED_LARGE, StatusEffects.UnlockedHarpyWings],
		[WING_TYPE_FEATHERED_PHOENIX, StatusEffects.UnlockedPhoenixWings],
		[WING_TYPE_GARGOYLE_LIKE_LARGE, null],
		[WING_TYPE_GIANT_DRAGONFLY, null],
		[WING_TYPE_HARPY, null],
		[WING_TYPE_IMP, null],
		[WING_TYPE_MANTICORE_LIKE_LARGE, null],
		[WING_TYPE_MANTICORE_LIKE_SMALL, null],
		[WING_TYPE_MANTIS_LIKE_LARGE, null],
		[WING_TYPE_MANTIS_LIKE_LARGE_2, null],
		[WING_TYPE_MANTIS_LIKE_SMALL, null],
		[WING_TYPE_NONE, null],
		[WING_TYPE_PLANT, null],
		[WING_TYPE_SHARK_FIN, null],
	]);

	/**
	 * Change player[key] to `tgtType`.
	 * Update genetic memory using `dict`, if perk present and body type registered.
	 * No mutation flavour text is displayed
	 * @return true if added genetic memory (displayed "genetic memory unlocked" text)
	 */
	private function setBodyPartType(key:String, dict:Object, tgtType:int):Boolean {
		if (player[key] == tgtType) return false;
		player[key] = tgtType;
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