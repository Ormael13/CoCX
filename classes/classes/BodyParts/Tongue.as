package classes.BodyParts {
import classes.internals.EnumValue;

public class Tongue extends BodyPart{
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("HUMAN", "SNAKE")
	 * - name: human-readable default name, ("human", "snake")
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const HUMAN:int			= 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {name:"human"})
	public static const SNAKE:int			= 1;
	EnumValue.add(Types, SNAKE, "SNAKE", {name:"snake"})
	public static const DEMONIC:int			= 2;
	EnumValue.add(Types, DEMONIC, "DEMONIC", {name:"demonic"})
	public static const DRACONIC:int		= 3;
	EnumValue.add(Types, DRACONIC, "DRACONIC", {name:"draconic"})
	public static const ECHIDNA:int			= 4;
	EnumValue.add(Types, ECHIDNA, "ECHIDNA", {name:"echidna"})
	public static const CAT:int				= 5;
	EnumValue.add(Types, CAT, "CAT", {name:"cat"})
	public static const ELF:int				= 6;
	EnumValue.add(Types, ELF, "ELF", {name:"elf"})
	public static const DOG:int				= 7;
	EnumValue.add(Types, DOG, "DOG", {name:"dog"})
	public static const CAVE_WYRM:int		= 8;
	EnumValue.add(Types, CAVE_WYRM, "CAVE_WYRM", {name:"draconic"})
	public static const GHOST:int			= 9;
	EnumValue.add(Types, GHOST, "GHOST", {name:"ghost"})
	public static const MELKIE:int			= 10;
	EnumValue.add(Types, MELKIE, "MELKIE", {name:"melkie"})
	public static const RATATOSKR:int		= 11;
	EnumValue.add(Types, RATATOSKR, "RATATOSKR", {name:"ratatoskr"})
	public static const RAVENOUS_TONGUE:int	= 12;
	EnumValue.add(Types, RAVENOUS_TONGUE, "RAVENOUS_TONGUE", {name:"ravenous"})
	// Don't forget to add new types in DebugMenu.as list TONGUE_TYPE_CONSTANTS

	public function Tongue() {
		super(null, null);
	}

	private static function formatDescription(desc:String, creature: *): String {
		const upperCasePattern:RegExp = /^./;

		return " " + desc
			.replace(upperCasePattern, function($0:*):* {return $0.toUpperCase();});
	}
}
}
