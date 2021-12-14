package classes.BodyParts {
import classes.internals.EnumValue;

public class Tongue extends BodyPart{
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("HUMAN", "SNAKE")
	 * - name: human-readable default name, ("human", "snake")
	 *
	 * - appearanceDesc: description for PlayerAppearance.as (always visible)
	 * - appearanceDescFunc: a function that returns a description for PlayerAppearance.as (appearanceDesc is ignored if this exists)
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const HUMAN: int = 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {
		name:"human",
		appearanceDesc: "You have a completely normal tongue, unlike a good number of Mareth's denizens."
	});
	public static const SNAKE: int = 1;
	EnumValue.add(Types, SNAKE, "SNAKE", {
		name:"snake",
		appearanceDesc: "A snake-like tongue occasionally flits between your lips, tasting the air."
	});
	public static const DEMONIC: int = 2;
	EnumValue.add(Types, DEMONIC, "DEMONIC", {
		name:"demonic",
		appearanceDesc: "A slowly undulating tongue occasionally slips from between your lips. It hangs nearly two feet long when you let the whole thing slide out, though you can retract it to appear normal."
	});
	public static const DRACONIC: int = 3;
	EnumValue.add(Types, DRACONIC, "DRACONIC", {
		name:"draconic",
		appearanceDesc: "Your mouth contains a thick, fleshy tongue that, if you so desire, can telescope to a distance of about four feet. It has sufficient manual dexterity that you can use it almost like a third arm."
	});
	public static const ECHIDNA: int = 4;
	EnumValue.add(Types, ECHIDNA, "ECHIDNA", {
		name:"echidna",
		appearanceDesc: "A thin echidna tongue, at least a foot long, occasionally flits out from between your lips."
	});
	public static const CAT: int = 5;
	EnumValue.add(Types, CAT, "CAT", {
		name:"cat",
		appearanceDesc: "Your tongue is rough like that of a cat. You sometimes groom yourself with it."
	});
	public static const ELF: int = 6;
	EnumValue.add(Types, ELF, "ELF", {
		name:"elf",
		appearanceDesc: "Your voice is unnaturally beautiful and melodious."
	});
	public static const DOG: int = 7;
	EnumValue.add(Types, DOG, "DOG", {
		name:"dog",
		appearanceDesc: "You sometime let your canine tongue out to vent heat."
	});
	public static const CAVE_WYRM: int = 8;
	EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {
		name:"draconic",
		appearanceDesc: "A slowly undulating neon blue tongue that glow in the dark occasionally slips from between your lips. It hangs nearly two feet long when you let the whole thing slide out, though you can retract it to appear normal."
	});
	public static const GHOST: int = 9;
	EnumValue.add(Types, GHOST, "GHOST", {
		name:"ghost",
		appearanceDesc: "Occasionally a long transparent tongue slicks out of your mouth, stretching out about a foot in length."
	});
	public static const MELKIE: int = 10;
	EnumValue.add(Types, MELKIE, "MELKIE", {
		name:"melkie",
		appearanceDesc: "Your voice is unnaturally beautiful and melodious; your mermaid-like song is capable of captivating the minds of those who listens to it."
	});
	public static const RATATOSKR: int = 11;
	EnumValue.add(Types, RATATOSKR, "RATATOSKR", {
		name:"ratatoskr",
		appearanceDesc: "Your tongue is human in appearance but way more dexterous at handling words, able to form sentences and words so good it becomes art or so bad that it bleeds the ears and drives who hear them insane."
	});
	public static const RAVENOUS_TONGUE: int = 12;
	EnumValue.add(Types, RAVENOUS_TONGUE, "RAVENOUS_TONGUE", {
		name:"ravenous",
		appearanceDesc: "You constantly hunger for food and your ravenous tongue has gained some unnatural skills of its own, always ready to coax a penis or a pussy into cumming."
	});
	public static const MINDBREAKER: int = 13;
	EnumValue.add(Types, MINDBREAKER, "MINDBREAKER", {
		name:"mindbreaker",
		appearanceDesc: "In your mouth hides a long tentacle-like tongue ready to probe the mouth of others."
	});

	public static const MINDBREAKERMALE: int = 14;
	EnumValue.add(Types, MINDBREAKERMALE, "MINDBREAKERMALE", {
		name:"mindbreaker male",
		appearanceDesc: "Over your mouth are several tentacles, but underneath that is your long tentacle-like tongue, ready to probe the mouth of others."
	});

	public function Tongue() {
		super(null, null);
	}

	public static function getAppearanceDescription(creature: *):String {
		const id: int = creature.tongue.type;

		return formatDescription((Types[id].appearanceDescFunc ? Types[id].appearanceDescFunc(creature) : Types[id].appearanceDesc) || "", creature);
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;

		return desc
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
