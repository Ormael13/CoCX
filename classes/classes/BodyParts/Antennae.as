package classes.BodyParts {
import classes.internals.EnumValue;

public class Antennae extends BodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NONE", "MANTIS")
	 * - name: human-readable name, ("non-existant", "mantis")
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const NONE: int = 0;
	EnumValue.add(Types, NONE, "NONE", {
		name: "non-existant",
		appearanceDesc: ""
	});
	public static const MANTIS: int = 1;
	EnumValue.add(Types, MANTIS, "MANTIS", {
		name: "mantis",
		appearanceDesc: "You have long prehensile mantis antennae on your head, bouncing and swaying in the breeze."
	});
	public static const BEE: int = 2;
	EnumValue.add(Types, BEE, "BEE", {
		name: "bee",
		appearanceDesc: "You have floppy bee antennae on your head, bouncing and swaying in the breeze."
	});
	public static const COCKATRICE: int = 3;
	EnumValue.add(Types, COCKATRICE, "COCKATRICE", {
		name: "cockatrice",
		appearanceDesc: ""
	});
	public static const FIRE_SNAIL: int = 4;
	EnumValue.add(Types, FIRE_SNAIL, "FIRE_SNAIL", {
		name: "fire snail",
		appearanceDesc: "Two horn like antennae grow from your head, feeling the air around and feeding you sensory information."
	});
	public static const MOTH: int = 5;
	EnumValue.add(Types, MOTH, "MOTH", {
		name: "moth",
		appearanceDesc: "Floppy moth antennae grow from your head, bouncing and swaying in the breeze."
	});
	public static const CENTIPEDE: int = 6;
	EnumValue.add(Types, CENTIPEDE, "CENTIPEDE", {
		name: "centipede",
		appearanceDesc: "A pair of long antennae have grown on your head, occasionally curling and twitching at the slightest of movements."
	});
	public static const SEA_DRAGON: int = 7;
	EnumValue.add(Types, SEA_DRAGON, "SEA_DRAGON", {
		name: "sea dragon",
		appearanceDesc: "By the sides of your head are four bioluminescent strands that run down your neck, beautifully lighting up your front and giving you an air of mystique."
	});
	public static const JABBERWOCKY: int = 8;
	EnumValue.add(Types, JABBERWOCKY, "JABBERWOCKY", {
		name: "jabberwocky",
		appearanceDesc: "By the sides of your head are two long strands not unlike tentacles that run down your neck enhancing your senses."
	});

	public function Antennae() {
		super(null, null);
	}

	public static function getAppearanceDescription(creature: *):String {
		const id: int = creature.antennae.type;

		return formatDescription((Types[id].appearanceDescFunc ? Types[id].appearanceDescFunc(creature) : Types[id].appearanceDesc) || "", creature);
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;

		return desc
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
