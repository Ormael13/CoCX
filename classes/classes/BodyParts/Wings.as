package classes.BodyParts {

public class Wings extends BodyPart {
	public static const NONE:int                 = 0;
	public static const BEE_LIKE_SMALL:int       = 1;
	public static const BEE_LIKE_LARGE:int       = 2;
	//unused yet nr 3 wing type
	public static const HARPY:int                = 4;
	public static const IMP:int                  = 5;//not used for PC - can change it with some new wing type
	public static const BAT_LIKE_TINY:int        = 6;
	public static const BAT_LIKE_LARGE:int       = 7;
	public static const SHARK_FIN:int            = 8;//not longer used so not count
	public static const FEATHERED_LARGE:int      = 9;
	public static const DRACONIC_SMALL:int       = 10;
	public static const DRACONIC_LARGE:int       = 11;
	public static const GIANT_DRAGONFLY:int      = 12;
	public static const BAT_LIKE_LARGE_2:int     = 13;
	public static const DRACONIC_HUGE:int        = 14;
	public static const FEATHERED_PHOENIX:int    = 15;//button 0 on 2nd page of metamorph
	public static const FEATHERED_ALICORN:int    = 16;
	public static const MANTIS_LIKE_SMALL:int    = 17;
	public static const MANTIS_LIKE_LARGE:int    = 18;
	public static const MANTIS_LIKE_LARGE_2:int  = 19;
	public static const GARGOYLE_LIKE_LARGE:int  = 20;
	public static const PLANT:int                = 21;
	public static const MANTICORE_LIKE_SMALL:int = 22;
	public static const MANTICORE_LIKE_LARGE:int = 23;
	public static const BAT_ARM:int              = 24;
	public static const VAMPIRE:int              = 25;
	public static const FEY_DRAGON_WINGS:int     = 26;
	public static const FEATHERED_AVIAN:int      = 27;
	public static const NIGHTMARE:int    		 = 28;
	public static const FEATHERED_SPHINX:int     = 29;//button 0 on 3rd page of metamorph
	public static const ETHEREAL_WINGS:int    	 = 30;
	public static const THUNDEROUS_AURA:int    	 = 31;
	public static const LEVITATION:int    		 = 32;
	public static const DEVILFEATHER:int       	 = 33;
	// Don't forget to add new types in DebugMenu.as list WING_TYPE_CONSTANTS
	
	public var desc:String = "non-existant";
	public function Wings() {
		super(null, null);
	}
}
}
