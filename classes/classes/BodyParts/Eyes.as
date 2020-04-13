package classes.BodyParts {

public class Eyes extends BodyPart {
	public var count:int;
	public static const HUMAN:int                = 0;
	public static const FOUR_SPIDER_EYES:int     = 1;
	public static const BLACK_EYES_SAND_TRAP:int = 2;
	public static const CAT_SLITS:int            = 3;
	public static const GORGON:int               = 4;
	public static const FENRIR:int               = 5;
	public static const MANTICORE:int            = 6;
	public static const FOX:int                  = 7;
	public static const REPTILIAN:int            = 8;
	public static const SNAKE:int                = 9;
	public static const DRAGON:int               = 10;
	public static const DEVIL:int                = 11;
	public static const ONI:int                  = 12;
	public static const ELF:int                  = 13;
	public static const RAIJU:int                = 14;//button 0 on 2nd page of metamorph
	public static const VAMPIRE:int              = 15;
	public static const GEMSTONES:int            = 16;
	public static const FERAL:int            	 = 17;
	public static const GRYPHON:int            	 = 18;
	public static const INFERNAL:int           	 = 19;
	public static const ORC:int		           	 = 20;
	public static const CAVE_WYRM:int		     = 21;
	public static const HINEZUMI:int		     = 22;
	public static const BEAR:int			     = 23;
	public static const DISPLACER:int			 = 24;
	public static const FIRE_SNAIL:int			 = 25;
	public static const GHOST:int				 = 26;
	public static const JIANGSHI:int			 = 27;
	public static const GOAT:int			     = 28;
	public static const CENTIPEDE:int			 = 29;
	public static const KRAKEN:int			     = 30;
	// Don't forget to add new types in DebugMenu.as list EYE_TYPE_CONSTANTS
	
	public var colour:String = "brown";
	public function Eyes() {
		super(null, null);
	}
}
}
