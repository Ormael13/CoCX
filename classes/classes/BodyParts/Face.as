/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;
import classes.BodyParts.*;
import classes.internals.Utils;

public class Face extends SaveableBodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 10)
	 * - id: name of the constant ("HUMAN", "SPIDER_FANGS")
	 * - name: human-readable name, ("human", "spider")
	 *
	 * - appearanceDesc: detailed description of the hair for PlayerAppearance.as
	 * - appearanceDescFunc: function that returns an appearanceDesc value (appearanceDesc is ignored if this exists)
	 *
	 * - humanShaped: whether the face still resembles a human
	 * - bite: whether the part allows attacking with teeth
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const HUMAN: int = 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {
		name: "human",
		appearanceDesc: "",
		humanShaped: true
	});
	public static const HORSE: int = 1;
	EnumValue.add(Types, HORSE, "HORSE", {
		name: "horse",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			if (!creature.hasCoat()) {
				desc += "Your face is equine in shape and structure. The odd visage is hairless and covered with [skin base]";
			} else if (creature.hasFullCoatOfType(Skin.FUR)) {
				desc += "Your face is almost entirely equine in appearance, even having [skin coat]. Underneath the fur, you believe you have [skin base].";
			} else {
				desc += "You have the face and head structure of a horse, overlaid with glittering [skin coat].";
			}

			return desc;
		},
		hasMuzzle: true
	});
	public static const DOG: int = 2;
	EnumValue.add(Types, DOG, "DOG", {
		name: "dog",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			if (!creature.hasCoat()) {
				desc += "You have a dog-like face, complete with a wet nose. The odd visage is hairless and covered with [skin base].";
			} else if (creature.hasFullCoatOfType(Skin.FUR)) {
				desc += "You have a dog's face, complete with wet nose and panting tongue. You've got [skin coat], hiding your [skin base] underneath your furry visage.";
			} else {
				desc += "You have the facial structure of a dog, wet nose and all, but overlaid with glittering patches of [skin coat]";
			}

			return desc;
		},
		bite: true,
		hasMuzzle: true
	});
	public static const COW_MINOTAUR: int = 3;
	EnumValue.add(Types, COW_MINOTAUR, "COW_MINOTAUR", {
		name: "cow",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			if (!creature.hasCoat()) {
				desc += "You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose. Despite your lack of fur elsewhere, your visage does have a short layer of [haircolor] fuzz.";
			} else if (creature.hasFullCoatOfType(Skin.FUR)) {
				desc += "You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose. Your [skin coat] thickens noticeably on your head, looking shaggy and more than a little monstrous once laid over your visage.";
			} else if (creature.hasFullCoat()) {
				desc += "Your face resembles a minotaur's, though strangely it is covered in shimmering [skin coat], right up to the flat cow-like nose that protrudes from your face.";
			} else {
				desc += "Your face resembles a minotaur's, though strangely it is covered small patches of shimmering [skin coat], right up to the flat cow-like nose that protrudes from your face.";
			}

			return desc;
		}
	});
	public static const SHARK_TEETH: int = 4;
	EnumValue.add(Types, SHARK_TEETH, "SHARK_TEETH", {
		name: "shark",
		appearanceDesc: "A set of razor-sharp, retractable shark-teeth fill your mouth and gives your visage a slightly angular appearance.",
		bite: true,
		humanShaped: true
	});
	public static const SNAKE_FANGS: int = 5;
	EnumValue.add(Types, SNAKE_FANGS, "SNAKE_FANGS", {
		name: "snake",
		appearanceDesc: "A pair of fangs hang over your lower lip, dripping with venom.",
		bite: true,
		humanShaped: true
	});
	public static const CAT: int = 6;
	EnumValue.add(Types, CAT, "CAT", {
		name: "cat",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			if (!creature.hasCoat()) {
				desc += "You have a cat-like face, complete with a cute, moist nose and whiskers. The [skin] that is revealed by your lack of fur looks quite unusual on so feline a face.";
			} else if (creature.hasFullCoatOfType(Skin.FUR)) {
				desc += "You have a cat-like face, complete with moist nose and whiskers. Your [skin coat.nocolor] is [skin coat.color], hiding your [skin base] underneath.";
			} else {
				desc += "Your facial structure blends humanoid features with those of a cat. A moist nose and whiskers are included, but overlaid with glittering patches of [skin coat].";
			}

			return desc;
		},
		bite: true,
		hasMuzzle: true
	});
	public static const LIZARD: int = 7;
	EnumValue.add(Types, LIZARD, "LIZARD", {
		name: "lizard",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			if (!creature.hasCoat()) {
				desc += "You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage. The reptilian visage does look a little odd with just [skin].";
			} else if (creature.hasFullCoatOfType(Skin.FUR)) {
				desc += "You have a face resembling that of a lizard. Between the toothy maw, pointed snout, and the layer of [skin coat] covering your face, you have quite the fearsome visage.";
			} else if (creature.hasFullCoat()) {
				desc += "Your face is that of a lizard, complete with a toothy maw and pointed snout. Reflective [skin coat] complete the look, making you look quite fearsome.";
			} else {
				desc += "You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage. The reptilian visage does look a little odd with just [skin coat].";
			}

			return desc;
		},
		bite: true,
		hasMuzzle: true
	});
	public static const BUNNY: int = 8;
	EnumValue.add(Types, BUNNY, "BUNNY", {
		name: "bunny",
		appearanceDesc: "The constant twitches of your nose and the length of your incisors gives your visage a hint of bunny-like cuteness.",
		bite: true,
		humanShaped: true
	});
	public static const KANGAROO: int = 9;
	EnumValue.add(Types, KANGAROO, "KANGAROO", {
		name: "kangaroo",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "Your face is ";
			if (!creature.hasCoat()) {
				desc += "bald";
			} else desc += "covered with [skin coat]";
			desc += " and shaped like that of a kangaroo, somewhat rabbit-like except for the extreme length of your odd visage.";

			return desc;
		},
		hasMuzzle: true
	});
	public static const SPIDER_FANGS: int = 10;
	EnumValue.add(Types, SPIDER_FANGS, "SPIDER_FANGS", {
		name: "spider",
		appearanceDesc: "A set of retractable, needle-like fangs sit in place of your canines and are ready to dispense their venom.",
		bite: true,
		humanShaped: true
	});
	public static const FOX: int = 11;
	EnumValue.add(Types, FOX, "FOX", {
		name: "fox",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "You have a tapered, shrewd-looking vulpine face with a speckling of downward-curved whiskers just behind the nose.";
			if (!creature.hasCoat()) {
				desc += " Oddly enough, there's no fur on your animalistic muzzle, just [skin coat].";
			} else if (creature.hasFullCoatOfType(Skin.FUR)) desc += " A coat of [skin coat] decorates your muzzle.";
			else if (creature.skin.isCoverLowMid()) desc += " Strangely, [skin coat] adorn your animalistic visage.";
			else desc += " Strangely, [skin coat] adorn every inch of your animalistic visage.";

			return desc;
		},
		bite: true,
		hasMuzzle: true
	});
	public static const DRAGON: int = 12;
	EnumValue.add(Types, DRAGON, "DRAGON", {
		name: "dragon",
		appearanceDesc: "Your face is a narrow, reptilian muzzle. It looks like a predatory lizard's, at first glance, but with an unusual array of spikes along the under-jaw. It gives you a regal but fierce visage. Opening your mouth reveals several rows of dagger-like sharp teeth. The fearsome visage is decorated by [skin coat].",
		bite: true,
		hasMuzzle: true
	});
	public static const RACCOON_MASK: int = 13;
	EnumValue.add(Types, RACCOON_MASK, "RACCOON_MASK", {
		name: "raccoon mask",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "You have a sly-looking raccoon mask over your eyes";

			if (!creature.hasCoat()) {
				if (InCollection(creature.skin.base.color, "ebony", "black")) desc += ", although it isn't properly visible with your dusky hue";
			} else {
				if (InCollection(creature.skin.base.color, "black", "midnight", "black", "midnight", "black", "midnight"))
					desc += ", hidden under your [skin coat] and barely visible due to your inky hue";
			}

			desc += ".";

			return desc;
		},
		humanShaped: true
	});
	public static const RACCOON: int = 14;
	EnumValue.add(Types, RACCOON, "RACCOON", {
		name: "raccoon",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "You have a triangular raccoon face, including sensitive whiskers and a little black nose; a mask shades the space around your eyes, set apart from your [skin coat] by a band of white.";

			if (creature.hasPlainSkinOnly()){
				desc += " It looks a bit strange with no fur coverage.";
			} else if (creature.hasScales()) desc += " The presence of said scales gives your visage an eerie look, more reptile than mammal.";
			else if (creature.skin.hasChitin()) desc += " The presence of said chitin gives your visage an eerie look, more insect than mammal.";

			return desc;
		},
		bite: true
	});
	public static const BUCKTEETH: int = 15;
	EnumValue.add(Types, BUCKTEETH, "BUCKTEETH", {
		name: "buckteeth",
		appearanceDesc: "You have very noticeably mousey buckteeth.",
		bite: true,
		humanShaped: true
	});
	public static const MOUSE: int = 16;
	EnumValue.add(Types, MOUSE, "MOUSE", {
		name: "mouse",
		appearanceDesc: "You have a snubby, tapered mouse's face, with whiskers and a little pink nose. Two large incisors complete it.",
		bite: true
	});
	public static const FERRET_MASK: int = 17;
	EnumValue.add(Types, FERRET_MASK, "FERRET_MASK", {
		name: "ferret mask",
		appearanceDesc: "The [skinFurScales] around your eyes is significantly darker than the rest of your face, giving you a cute little ferret mask.",
		humanShaped: true
	});
	public static const FERRET: int = 18;
	EnumValue.add(Types, FERRET, "FERRET", {
		name: "ferret",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.hasFullCoatOfType(Skin.FUR)) desc += "Your face is coated in [skin coat] with [skin base] underneath, an adorable cross between human and ferret features. It is complete with a wet nose and whiskers.";
			else if (creature.hasCoat()) desc += "Your face is an adorable cross between human and ferret features, complete with a wet nose and whiskers. The only oddity is [skin base] covered with [skin coat].";
			else desc += "Your face is an adorable cross between human and ferret features, complete with a wet nose and whiskers. The only oddity is your lack of fur, leaving only [skin] visible on your ferret-like face.";

			return desc;
		},
		bite: true
	});
	public static const PIG: int = 19;
	EnumValue.add(Types, PIG, "PIG", {
		name: "pig",
		appearanceDesc: "Your face is like that of a pig, complete with a snout that is always wiggling."
	});
	public static const BOAR: int = 20;
	EnumValue.add(Types, BOAR, "BOAR", {
		name: "boar",
		appearanceDesc: "Your face is like that of a boar, complete with tusks and a snout that is always wiggling."
	});
	public static const RHINO: int = 21;
	EnumValue.add(Types, RHINO, "RHINO", {
		name: "rhino",
		appearanceDesc: "Your face is like that of a rhino, complete with a long muzzle and a horns on your nose.",
		hasMuzzle: true
	});
	public static const ECHIDNA: int = 22;
	EnumValue.add(Types, ECHIDNA, "ECHIDNA", {
		name: "echidna",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "Your odd visage consists of a long, thin echidna snout";

			if (!creature.hasCoat()) desc += ", though it looks rather strange without any coverage whatsoever"

			desc += ".";

			return desc;
		},
		hasMuzzle: true
	});
	public static const DEER: int = 23;
	EnumValue.add(Types, DEER, "DEER", {
		name: "deer",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "Your face is like that of a deer, with a nose at the end of your muzzle";

			if (!creature.hasCoat()) desc += ", though it looks rather strange without any coverage whatsoever"

			desc += ".";

			return desc;
		},
		hasMuzzle: true
	});
	public static const WOLF: int = 24;
	EnumValue.add(Types, WOLF, "WOLF", {
		name: "wolf",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			if (!creature.hasCoat()) {
				desc += "You have a wolf-like face, complete with a wet nose. ";
				if (creature.hasKeyItem("Gleipnir Collar") >= 0) desc += "Your breath freezes the air, and cold mist leaks from your jaws. ";
				desc += "The odd visage is hairless and covered with [skin coat].";
			} else if (creature.hasFullCoatOfType(Skin.FUR)) {
				desc += "You have a wolf’s face, complete with wet nose a panting tongue and threatening teeth. ";
				if (creature.hasKeyItem("Gleipnir Collar") >= 0) desc += "Your breath freezes the air, and cold mist leaks from your jaws. ";
				desc += "You've got [skin coat], hiding your [skin noadj] underneath your furry visage.";
			} else {
				desc += "You have the facial structure of a wolf, wet nose and all, but overlaid with glittering patches of [skin coat].";
				if (creature.hasKeyItem("Gleipnir Collar") >= 0) desc += " Your breath freezes the air, and cold mist leaks from your jaws.";
			}

			return desc;
		},
		bite: true,
		hasMuzzle: true
	});
	public static const MANTICORE: int = 25;
	EnumValue.add(Types, MANTICORE, "MANTICORE", {
		name: "manticore",
		appearanceDesc: "You have a set of sharp cat-like teeth in your mouth.",
		bite: true,
		humanShaped: true
	});
	public static const SALAMANDER_FANGS: int = 26;
	EnumValue.add(Types, SALAMANDER_FANGS, "SALAMANDER_FANGS", {
		name: "salamander",
		appearanceDesc: "A pair of salamander fangs grows out of your mouth giving you a menacing smile.",
		bite: true,
		humanShaped: true
	});
	public static const YETI_FANGS: int = 27;
	EnumValue.add(Types, YETI_FANGS, "YETI_FANGS", {
		name: "yeti",
		appearanceDesc: "Your mouth, while human-looking, has sharp yeti fangs.",
		bite: true,
		humanShaped: true
	});
	public static const ORCA: int = 28;//button 0 on 3rd page of metamorph
	EnumValue.add(Types, ORCA, "ORCA", {
		name: "orca",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			if (creature.skin.hasPlainSkinOnly() && creature.skinAdj == "glossy" && creature.skinTone == "white and black") desc += "You have a wider yet adorable nose, and your face is pitch black with a white underbelly; from your neck up to your mouth and lower cheeks your face is white with two extra white circles right under and above your eyes.";
			else desc += "You have a wide nose similar to that of an orca, which goes well with your sharp toothed mouth, giving you a cute look.";

			return desc;
		},
		bite: true,
		humanShaped: true
	});
	public static const PLANT_DRAGON: int = 29;
	EnumValue.add(Types, PLANT_DRAGON, "PLANT_DRAGON", {
		name: "plant dragon",
		appearanceDesc: "Your face is a narrow, reptilian and regal, reminiscent of a dragon. A [skin coat] decorates your visage.",
		bite: true
	});
	public static const DRAGON_FANGS: int = 30;
	EnumValue.add(Types, DRAGON_FANGS, "DRAGON_FANGS", {
		name: "dragon fangs",
		appearanceDesc: "Your mouth is somewhat human save for your draconic fangs giving you a menacing smile. It's decorated by [skin coat].",
		bite: true
	});
	public static const DEVIL_FANGS: int = 31;
	EnumValue.add(Types, DEVIL_FANGS, "DEVIL_FANGS", {
		name: "devil fangs",
		appearanceDesc: "Your mouth looks human enough, save for your fiendish canines. It's decorated by [skin coat].",
		bite: true
	});
	public static const ONI_TEETH: int = 32;
	EnumValue.add(Types, ONI_TEETH, "ONI_TEETH", {
		name: "oni teeth",
		appearanceDesc: "You have two large ogre canines in your mouth.",
		bite: true,
		humanShaped: true
	});
	public static const WEASEL: int = 33;
	EnumValue.add(Types, WEASEL, "WEASEL", {
		name: "weasel",
		appearanceDesc: "You have two sharp weasel canines in your mouth.",
		bite: true
	});
	public static const VAMPIRE: int = 34;
	EnumValue.add(Types, VAMPIRE, "VAMPIRE", {
		name: "vampire",
		appearanceDesc: "You own a pair of long and pointy vampire canines meant to pierce into victims and reach their blood.",
		bite: true,
		humanShaped: true
	});
	public static const BUCKTOOTH: int = 35;
	EnumValue.add(Types, BUCKTOOTH, "BUCKTOOTH", {
		name: "jabberwocky bucktooth",
		appearanceDesc: "You have two abnormally large buck tooth, like a Jabberwocky.",
		bite: true,
		humanShaped: true
	});
	public static const JABBERWOCKY: int = 36;
	EnumValue.add(Types, JABBERWOCKY, "JABBERWOCKY", {
		name: "jabberwocky",
		appearanceDesc: "Your face is a narrow, reptilian muzzle. It looks like a predatory lizard's, at first glance, but with an unusual array of spikes along the under-jaw. It gives you a regal but fierce visage. Opening your mouth reveals two buck tooth, which are abnormally large. Like a rabbit or rather a Jabberwocky. The fearsome visage is decorated by [skin coat].",
		bite: true
	});
	public static const RED_PANDA: int = 37;
	EnumValue.add(Types, RED_PANDA, "RED_PANDA", {
		name: "red panda",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "Your face has a distinctive animalistic muzzle, proper from a red-panda, complete with a cute pink nose";

			if (!creature.hasCoat()) desc += ", though it looks rather strange without any coverage whatsoever"

			desc += ".";

			return desc;
		},
		bite: true
	});
	public static const CAT_CANINES: int = 38;
	EnumValue.add(Types, CAT_CANINES, "CAT_CANINES", {
		name: "cat canines",
		appearanceDesc: "You have a pair of cat-like canines in your mouth.",
		bite: true
	});
	public static const CHESHIRE: int = 39;
	EnumValue.add(Types, CHESHIRE, "CHESHIRE", {
		name: "cheshire",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			if (!creature.hasCoat()) {
				desc += "You have a cat-like face, complete with a cute, moist nose and whiskers. The [skin] that is revealed by your lack of fur looks quite unusual on so feline a face.";
			} else if (creature.hasFullCoatOfType(Skin.FUR)) {
				desc += "You have a cat-like face, complete with moist nose and whiskers. Your [skin coat.nocolor] is [skin coat.color], hiding your [skin base] underneath.";
			} else {
				desc += "Your facial structure blends humanoid features with those of a cat. A moist nose and whiskers are included, but overlaid with glittering patches of [skin coat].";
			}
			desc += " For some reason your facial expression is that of an everlasting yet unsettling grin.";

			return desc;
		},
		bite: true
	});
	public static const CHESHIRE_SMILE: int = 40;
	EnumValue.add(Types, CHESHIRE_SMILE, "CHESHIRE_SMILE", {
		name: "cheshire",
		appearanceDesc: "You have a pair of cat-like canines in your mouth, and for some reason your facial expression is that of an everlasting yet unsettling grin.",
		bite: true,
		humanShaped: true
	});
	public static const AVIAN: int = 41;
	EnumValue.add(Types, AVIAN, "AVIAN", {
		name: "avian",
		appearanceDesc: "Your visage has a bird-like appearance, complete with an avian beak. A couple of small holes on it makes up for your nostrils, while a long, nimble tongue is hidden inside.",
		bite: true,
		hasBeak: true
	});
	public static const WOLF_FANGS: int = 42;//button 0 on 4th page of metamorph
	EnumValue.add(Types, WOLF_FANGS, "WOLF_FANGS", {
		name: "wolf fangs",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			if (!creature.hasCoat()) {
				desc += " Your face is human in shape and structure with [skin coat]. Your mouth is somewhat human save for your wolf-like canines.";
			} else if (creature.hasPartialCoat(Skin.FUR)) {
				desc += " Your face looks human save for your wolf-like canines, but overlaid with glittering patches of [skin coat].";
			} else {
				desc += " Your face looks human save for your wolf-like canines. You've got [skin coat], hiding your [skin noadj] underneath your furry visage.";
			}

			return desc;
		},
		bite: true,
		humanShaped: true
	});
	public static const ORC_FANGS: int = 43;
	EnumValue.add(Types, ORC_FANGS, "ORC_FANGS", {
		name: "orc fangs",
		appearanceDesc: "Your two lower canines resemble boar tusks poking out of your mouth.",
		bite: true,
		humanShaped: true
	});
	public static const ANIMAL_TOOTHS: int = 44;
	EnumValue.add(Types, ANIMAL_TOOTHS, "ANIMAL_TOOTHS", {
		name: "animal teeth",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			if (!creature.hasCoat()) {
				desc += "Your face looks human save for your sharp canines.";
			} else if (creature.hasFullCoatOfType(Skin.FUR)) {
				desc += "Your face looks human save for your sharp canines. Your [skin coat.nocolor] is [skin coat.color], hiding your [skin base] underneath.";
			} else {
				desc += "Your face looks human save for your sharp canines, but overlaid with glittering patches of [skin coat].";
			}
			if (creature.eyes.type == Eyes.CENTIPEDE){
				desc += " You wear a constant expression of sadness, barely drawing attention away from your mouth.";
			}

			return desc;
		},
		bite: true,
		humanShaped: true
	});
	public static const BEAR: int = 45;
	EnumValue.add(Types, BEAR, "BEAR", {
		name: "bear",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			desc += "Your face is that of a bear with an adorable wet nose and sharp teeth";

			if (!creature.hasCoat()) desc += ", though it looks rather strange without any coverage whatsoever"

			desc += ".";

			return desc;
		},
		bite: true,
		hasMuzzle: true
	});
	public static const PANDA: int = 46;
	EnumValue.add(Types, PANDA, "PANDA", {
		name: "panda",
		appearanceDesc: "Your face is that of a panda with an adorable wet nose and sharp teeth. Your face fur, much like most of your body, is white with two black circles right around your eyes.",
		bite: true,
		hasMuzzle: true
	});
	public static const FIRE_SNAIL: int = 47;
	EnumValue.add(Types, FIRE_SNAIL, "FIRE_SNAIL", {
		name: "fire snail",
		appearanceDesc: "Your mouth is drooling from constant arousal.",
		humanShaped: true
	});
	public static const GHOST: int = 48;
	EnumValue.add(Types, GHOST, "GHOST", {
		name: "ghost",
		appearanceDesc: "You have a perpetual wide smile on your face, hiding your true feelings at all times.",
		humanShaped: true
	});
	public static const JIANGSHI: int = 49;
	EnumValue.add(Types, JIANGSHI, "JIANGSHI", {
		name: "jiangshi",
		appearanceDesc: "Your expression is permanently dazed, as though you're in an eternal trance.",
		humanShaped: true
	});
	public static const YUKI_ONNA: int = 50;
	EnumValue.add(Types, YUKI_ONNA, "YUKI_ONNA", {
		name: "yuki onna",
		appearanceDesc: "Your lips, as lacking in wamth as the rest of your body, are dyed blue by the cold.",
		humanShaped: true
	});
	public static const KUDERE: int = 51;
	EnumValue.add(Types, KUDERE, "KUDERE", {
		name: "kuudere",
		appearanceDesc: "Your face shows no emotions whatsoever, hiding your true feelings at all times.",
		humanShaped: true
	});
	public static const USHI_ONI: int = 52;
	EnumValue.add(Types, USHI_ONI, "USHI_ONI", {
		name: "ushi-oni",
		appearanceDesc: "You have strange black tattoos circling your eyes and small fangs in your mouth ready to inject its victims with a weak poison.",
		bite: true,
		humanShaped: true
	});
	public static const FAIRY: int = 53;
	EnumValue.add(Types, FAIRY, "FAIRY", {
		name: "fairy",
		appearanceDesc: "Your fairy nature allows you to always display a pure, cheerful, innocent smile that warms the hearts of those around you.",
		humanShaped: true
	});
	public static const CRAZY: int = 54;
	EnumValue.add(Types, CRAZY, "CRAZY", {
		name: "crazy",
		appearanceDesc: "Although your mouth is quite human-looking, your have a near constant toothy smile makes you look quite unhinged, and your canines are slightly longer and pointier than human ones.",
		humanShaped: true
	});
	public static const SMUG: int = 55;
	EnumValue.add(Types, SMUG, "SMUG", {
		name: "smug",
		appearanceDesc: "The length of your incisors gives your visage a hint of squirrel-like cuteness, and once in a while you can't help but smirk smuggly at your interlocutors.",
		humanShaped: true
	});
	public static const SQUIRREL: int = 56;
	EnumValue.add(Types, SQUIRREL, "SQUIRREL", {
		name: "squirrel",
		appearanceDescFunc: function(creature: *): String {
			var desc: String = "";

			if (!creature.hasCoat()) {
				desc += "You have a squirrel-like face, complete with a twitching nose. The odd visage is hairless and covered with [skin base].";
			} else if (creature.hasFullCoatOfType(Skin.FUR)) {
				desc += "You have a squirrel's face, complete with twitching nose and two incisors. You've got [skin coat], hiding your [skin base] underneath your furry visage.";
			} else {
				desc += "You have the facial structure of a squirrel, twitching nose incisors and all, but overlaid with glittering patches of [skin coat]";
			}

			return desc;
		},
		bite: true,
		hasMuzzle: true
	});
	public static const ELF: int = 57;
	EnumValue.add(Types, ELF, "ELF", {
		name: "elf",
		appearanceDesc: "You have an enchanting smile and faultless pearlescent white teeth, so unnaturally perfect it makes you seem as though you came straight from a painting rather than real life.",
		humanShaped: true
	});

	public function Face(creature:Creature) {
		super(creature,"facePart",[]);
	}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
	}
	public function hasMuzzle():Boolean {
		return Types[type].hasMuzzle || false;
	}

	public function hasBeak():Boolean {
		return Types[type].hasBeak || false;
	}

	public function hasBeard():Boolean {
		return creature.beardLength > 0;
	}

	public function beard():String {
		if (hasBeard()) {
			return "beard";
		} else {
			//CoC_Settings.error("");
			return "ERROR: NO BEARD! <b>YOU ARE NOT A VIKING AND SHOULD TELL KITTEH IMMEDIATELY.</b>";
		}
	}
	public static function isHumanShaped(faceId: int):Boolean {
		return Types[faceId].humanShaped || false;
	}
	public function nounPhrase():String {
		var stringo:String = "";
		if (type == HUMAN) {
			return "face";
		}
		if (hasMuzzle()) {
			if (trueOnceInN(3)) {
				if (type == HORSE) {
					stringo = "long ";
				}
				if (type == CAT) {
					stringo = "feline ";
				}
				if (type == RHINO) {
					stringo = "rhino ";
				}
				if (type == LIZARD
						|| type == DRAGON) {
					stringo = "reptilian ";
				}
				if (type == WOLF) {
					stringo = "canine ";
				}
			}
			return stringo + randomChoice("muzzle", "snout", "face");
		}
		//3 - cowface
		if (type == COW_MINOTAUR) {
			if (trueOnceInN(4)) stringo = "bovine ";
			return randomChoice("muzzle", stringo + "face");
		}
		//4 - sharkface-teeth
		if (type == SHARK_TEETH) {
			if (trueOnceInN(4)) stringo = "angular ";
			return stringo + "face";
		}
		if (type == PIG || type == BOAR) {
			if (trueOnceInN(4)) {
				stringo = (type == PIG ? "pig" : "boar") + "-like ";
			}
			if (trueOnceInN(4))
				return stringo + "snout";
			return stringo + "face";
		}
		return "face";
	}

	override public function descriptionFull():String {
		return describe(false, true);
	}
	/**
	 * @param article (default false): Add an article a/an/the (default false): Describe femininity level
	 * @param deco (default false): If has decoration
	 */
	public function describe(article:Boolean=false,deco:Boolean=false):String {
		var femininity:Number = creature.femininity;
		var a:String          = "", an:String = "", the:String = "";
		if (article) {
			a   = "a ";
			an  = "an ";
			the = "the ";
		}
		return a + nounPhrase();
	}
	public function describeMF(article:Boolean=false):String {
			var faceo:String = "";
		var femininity:Number = creature.femininity;
		var a:String          = "", an:String = "", the:String = "";
		if (article) {
			a   = "a ";
			an  = "an ";
			the = "the ";
		}
			//0-10
			if (femininity < 10) {
				faceo = a + "square chin";
				if (!hasBeard()) faceo += " and chiseled jawline";
				else faceo += ", chiseled jawline, and " + beard();
				return faceo;
			}
			//10+ -20
			else if (femininity < 20) {
			faceo = a + "rugged look ";
				if (hasBeard()) faceo += "and " + beard();
				return faceo + "that's surely handsome";
			}
			//21-28
			else if (femininity < 28)
				return a + "well-defined jawline and a fairly masculine profile";
			//28+-35
			else if (femininity < 35)
				return a + "somewhat masculine, angular jawline";
			//35-45
			else if (femininity < 45)
				return the + "barest hint of masculinity on its features";
			//45-55
			else if (femininity <= 55)
				return an + "androgynous appearance that would look normal on a male or female";
			//55+-65
			else if (femininity <= 65)
				return a + "tiny touch of femininity to it, with gentle curves";
			//65+-72
			else if (femininity <= 72)
				return a + "nice set of cheekbones and lips that have the barest hint of pout";
			//72+-80
			else if (femininity <= 80)
				return a + "beautiful, feminine shapeliness that's sure to draw the attention of males";
			//81-90
			else if (femininity <= 90)
				return a + "gorgeous profile with full lips, a button nose, and noticeable eyelashes";
			//91-100
			else
				return a + "jaw-droppingly feminine shape with full, pouting lips, an adorable nose, and long, beautiful eyelashes";
		}
	override protected function loadFromOldSave(savedata:Object):void {
		type = intOr(savedata.faceType, HUMAN);
	}
	override protected function saveToOldSave(savedata:Object):void {
		savedata.faceType = type;
	}

	public static function getAppearanceDescription(creature: * ): String {
		const id: int = creature.faceType;

		var desc: String = "";


		if (Face.isHumanShaped(id)) {
			if (creature.skin.coverage < Skin.COVERAGE_COMPLETE) {
				desc += "Your face is human in shape and structure";
				if (creature.skin.isCoverLowMid()) {
					desc += ", and on your cheeks you have [skin coat]";
				}
				desc += ".";
			} else {
				desc += "Under your [skin coat], you have a face which is human in shape and structure.";
			}
		}

		// Links the descriptions properly if the face is human-shaped
		return Utils.mergeSentences([desc, formatDescription((Types[id].appearanceDescFunc ? Types[id].appearanceDescFunc(creature) : Types[id].appearanceDesc) || "", creature)], "; however, ")
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;

		return desc
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
