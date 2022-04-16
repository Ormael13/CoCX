package classes.BodyParts {
import classes.internals.EnumValue;
import classes.internals.Utils;
import classes.Measurements;
import classes.CoC;

public class Horns extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "DEMON")
	 * - name: human-readable default name, ("non-existant", "demon")
	 *
	 * - appearanceDesc: description for PlayerAppearance.as (always visible)
	 * - appearanceDescFunc: a function that returns a description for PlayerAppearance.as (appearanceDesc is ignored if this exists)
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const NONE: int = 0;
	EnumValue.add(Types, NONE, "NONE", {
		name:"non-existant"
	});

	public static const DEMON: int = 1;
	EnumValue.add(Types, DEMON, "DEMON", {
		name:"demon",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count == 2) desc += "A small pair of pointed horns has broken through the [skin.type] on your forehead, proclaiming some demonic taint to any who see them.";
			else if (player.horns.count == 4) desc += "A quartet of prominent horns has broken through your [skin.type]. The back pair are longer, and curve back along your head. The front pair protrude forward demonically.";
			else if (player.horns.count == 6) desc += "Six horns have sprouted through your [skin.type], the back two pairs curve backwards over your head and down towards your neck, while the front two horns stand almost eight inches long upwards and a little forward.";
			else if (player.horns.count >= 8) desc += "A large number of thick demonic horns sprout through your [skin.type], each pair sprouting behind the ones before. The front jut forwards nearly ten inches while the rest curve back over your head, some of the points ending just below your ears. You estimate you have a total of " + Utils.num2Text(player.horns.count) + " horns.";

			return desc;
		}
	});

	public static const COW_MINOTAUR: int = 2;
	EnumValue.add(Types, COW_MINOTAUR, "COW_MINOTAUR", {
		name:"cow",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count < 3) desc += "Two tiny horns-like nubs protrude from your forehead, resembling the horns of the young livestock kept by your village.";
			if (player.horns.count >= 3 && player.horns.count < 6) desc += "Two moderately sized horns grow from your forehead, similar in size to those on a young bovine.";
			if (player.horns.count >= 6 && player.horns.count < 12) desc += "Two large horns sprout from your forehead, curving forwards like those of a bull.";
			if (player.horns.count >= 12 && player.horns.count < 20) desc += "Two very large and dangerous looking horns sprout from your head, curving forward and over a foot long. They have dangerous looking points.";
			if (player.horns.count >= 20) desc += "Two huge horns erupt from your forehead, curving outward at first, then forwards. The weight of them is heavy, and they end in dangerous looking points.";

			return desc;
		},
		gore: true
	});

	public static const DRACONIC_X2: int = 3;
	EnumValue.add(Types, DRACONIC_X2, "DRACONIC_X2", {
		name:"2 draconic",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "A pair of " + Measurements.inchesOrCentimetres(int(player.horns.count)) + " horns grow from the sides of your head, sweeping backwards and adding to your imposing visage.";

			return desc;
		}
	});

	public static const DRACONIC_X4_12_INCH_LONG: int = 4;
	EnumValue.add(Types, DRACONIC_X4_12_INCH_LONG, "DRACONIC_X4_12_INCH_LONG", {
		name:"four 12\" long draconic",
		appearanceDesc: "Two pairs of horns, roughly a foot long, sprout from the sides of your head. They sweep back and give you a fearsome look, almost like the dragons from your village's legends."
	});

	public static const ANTLERS: int = 5;
	EnumValue.add(Types, ANTLERS, "ANTLERS", {
		name:"deer",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count > 0) desc += "Two antlers, forking into " + num2Text(player.horns.count) + " points, have sprouted from the top of your head, forming a spiky, regal crown of bone.";

			return desc;
		},
		gore: true
	});

	public static const GOAT: int = 6;
	EnumValue.add(Types, GOAT, "GOAT", {
		name:"goat",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count == 1) desc += "A pair of stubby goat horns sprout from the sides of your head.";
			else desc += "A pair of tall-standing goat horns sprout from the sides of your head. They are curved and patterned with ridges.";

			return desc;
		},
		gore: true
	});

	public static const UNICORN: int = 7;
	EnumValue.add(Types, UNICORN, "UNICORN", {
		name:"unicorn",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count < 3) desc += "Tiny horns-like nub protrude from your forehead, resembling the horns of the young unicorn.";
			if (player.horns.count >= 3 && player.horns.count < 6) desc += "A moderately sized horn sprouts from your forehead, similar in size to those on a young unicorn.";
			if (player.horns.count >= 6 && player.horns.count < 12) desc += "A large horn sprouts from your forehead, spiraling and pointing forwards like those of an unicorn.";
			if (player.horns.count >= 12 && player.horns.count < 20) desc += "A very large and dangerous looking spiraling horn sprouts from your forehead, pointing forward and over a foot long. It have dangerous looking tip.";
			if (player.horns.count >= 20) desc += "One huge and long spiraling horns erupt from your forehead, pointing forward. The weight of it is heavy and ends with dangerous and sharp looking tip.";

			return desc;
		},
		gore: true
	});

	public static const RHINO: int = 8;
	EnumValue.add(Types, RHINO, "RHINO", {
		name:"rhino",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count >= 2) {
				if (CoC.instance.transformations.FaceRhino.isPresent()) desc += "A second horns sprouts from your forehead just above the horns on your nose.";
				else desc += "A single horn sprouts from your forehead. It is conical and resembles a rhino's horn.";
				desc += "You estimate it to be about seven inches long.";
			} else {
				desc += "A single horn sprouts from your forehead. It is conical and resembles a rhino's horn. You estimate it to be about six inches long.";
			}

			return desc;
		},
		gore: true
	});

	public static const OAK: int = 9;
	EnumValue.add(Types, OAK, "OAK", {
		name:"oak",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count > 0) desc += "Two branches, forking into " + num2Text(player.horns.count) + " points, have sprouted from the top of your head, forming a spiky, regal crown made of oak wood.";

			return desc;
		}
	});

	public static const GARGOYLE: int = 10;
	EnumValue.add(Types, GARGOYLE, "GARGOYLE", {
		name:"gargoyle",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count > 0) desc += " A large pair of thick demonic looking horns sprout through the side of your head giving you a fiendish appearance.";

			return desc;
		}
	});

	public static const ORCHID: int = 11;
	EnumValue.add(Types, ORCHID, "ORCHID", {
		name:"orchid",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count > 0) desc += " A huge pair of "+player.nakedCoatColor+" orchids grows on each side of your head, their big long petals flopping gaily when you move.";

			return desc;
		}
	});

	public static const ONI_X2: int = 12;
	EnumValue.add(Types, ONI_X2, "ONI_X2", {
		name:"2 oni",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count > 0) desc += " You have a pair of horn on your head warning anyone who looks that you are an oni and mean serious business.";

			return desc;
		}
	});

	public static const ONI: int = 13;
	EnumValue.add(Types, ONI, "ONI", {
		name:"1 oni",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count > 0) desc += " You have a single horns on your head warning anyone who looks that you are an oni and mean serious business.";

			return desc;
		}
	});

	public static const BICORN: int = 14;
	EnumValue.add(Types, BICORN, "BICORN", {
		name:"bicorn",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count < 3) desc += "A pair of tiny horns-like nub protrude from your forehead, resembling the horns of the young bicorns.";
			if (player.horns.count >= 3 && player.horns.count < 6) desc += "Two moderately sized horns grow from your forehead, similar in size to those on a young bicorn.";
			if (player.horns.count >= 6 && player.horns.count < 12) desc += "Two large horns sprout from your forehead, spiraling and pointing forwards like those of a bicorn.";
			if (player.horns.count >= 12 && player.horns.count < 20) desc += "Two very large and dangerous looking spiraling horns sprout from your forehead, pointing forward and over a foot long. They have dangerous looking tip.";
			if (player.horns.count >= 20) desc += "Two huge and long spiraling horns erupt from your forehead, pointing forward. The weight of them is heavy and ends with dangerous and sharp looking tips.";

			return desc;
		},
		gore: true
	});

	public static const GHOSTLY_WISPS: int = 15;
	EnumValue.add(Types, GHOSTLY_WISPS, "GHOSTLY_WISPS", {
		name:"ghostly wisps",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count > 0) desc += " Floating above your head is several wispy balls of light. They hold an unsettling ethereal presence around them, though in reality they’re merely an extension of yourself.";

			return desc;
		}
	});

	public static const SPELL_TAG: int = 16;
	EnumValue.add(Types, SPELL_TAG, "SPELL_TAG", {
		name:"spell tag",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count > 0) desc += " On your forehead is a cursed spell tag, the source of both your current predicament and your supernatural powers.";

			return desc;
		}
	});

	public static const GOATQUAD: int = 17;
	EnumValue.add(Types, GOATQUAD, "GOATQUAD", {
		name:"4 goat",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count === 1) desc += "Four tall-standing goat horns sprout from the sides of your head denouncing your fiendish nature. They are curved and patterned with ridges.";

			return desc;
		},
		gore: true
	});

	public static const KRAKEN: int = 18;
	EnumValue.add(Types, KRAKEN, "KRAKEN", {
		name:"kraken",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count > 0) desc += " Crowning above your head is a fleshy Kraken hood easily adding you a few extra inch in height.";

			return desc;
		}
	});

	public static const FROSTWYRM: int = 19;
	EnumValue.add(Types, FROSTWYRM, "FROSTWYRM", {
		name:"frostwyrm",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "Two large sized spiraling horns grow from the side of your head, similar to those of a ram or frost wyrm. They kind of look great";

			if (player.lowerBody == LowerBody.FROSTWYRM) desc += ", especially with your fluffy fur, which makes you look like a sheep serpentine dragon";

			desc += ".";

			return desc;
		},
		gore: true
	});

	public static const USHI_ONI: int = 20;
	EnumValue.add(Types, USHI_ONI, "USHI_ONI", {
		name:"ushi-oni",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count > 0) desc += " You have a pair of ushi-oni horns, both come out of your skull and go upward in a spiral pattern.";

			return desc;
		},
		gore: true
	});

	public static const SEA_DRAGON: int = 21;
	EnumValue.add(Types, SEA_DRAGON, "SEA_DRAGON", {
		name:"sea dragon",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count > 0) desc += " Two large-sized horns grow from the side of your head. The faint bioluminescent specks that line the length of each horn enhance with a mesmerizing glow. At the tip of each horn is a bright red glow, both as a gentle warning and an enthralling lure to unwary prey.";

			return desc;
		}
	});

	public static const JABBERWOCKY: int = 22;
	EnumValue.add(Types, JABBERWOCKY, "JABBERWOCKY", {
		name:"jabberwocky",
		appearanceDescFunc: function(player: *): String {
			var desc: String = "";

			if (player.horns.count > 0) desc += " Four large-sized dragon horns grow from the side of your head curved like those of a jabberwocky.";

			return desc;
		}
	});

	public function Horns() {
		super(null, null);
	}
	public var count:int = 0;

	public static function getAppearanceDescription(player: *):String {
		const id: int = player.horns.type;

		return formatDescription((Types[id].appearanceDescFunc ? Types[id].appearanceDescFunc(player) : Types[id].appearanceDesc) || "", player);
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;

		return desc
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
