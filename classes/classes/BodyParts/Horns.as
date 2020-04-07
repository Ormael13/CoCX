package classes.BodyParts {

public class Horns extends BodyPart {
	public static const NONE:int                     = 0;
	public static const DEMON:int                    = 1;
	public static const COW_MINOTAUR:int             = 2;
	public static const DRACONIC_X2:int              = 3;
	public static const DRACONIC_X4_12_INCH_LONG:int = 4;
	public static const ANTLERS:int                  = 5;
	public static const GOAT:int                     = 6;
	public static const UNICORN:int                  = 7;
	public static const RHINO:int                    = 8;
	public static const OAK:int                      = 9;
	public static const GARGOYLE:int                 = 10;
	public static const ORCHID:int                   = 11;
	public static const ONI_X2:int                   = 12;
	public static const ONI:int                      = 13;
	public static const BICORN:int                   = 14;//button 0 on 2nd page of metamorph
	public static const GHOSTLY_WISPS:int            = 15;
	public static const SPELL_TAG:int           	 = 16;
	public static const GOATQUAD:int                 = 17;
	public static const KRAKEN:int              	 = 18;
	// Don't forget to add new types in DebugMenu.as list HORN_TYPE_CONSTANTS
	
	public function Horns() {
		super(null, null);
	}
	public var count:int = 0;
}
}
