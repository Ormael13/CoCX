/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

public class Face extends SaveableBodyPart {
	
	public static const HUMAN:int            = 0;
	public static const HORSE:int            = 1;
	public static const DOG:int              = 2;
	public static const COW_MINOTAUR:int     = 3;
	public static const SHARK_TEETH:int      = 4;
	public static const SNAKE_FANGS:int      = 5;
	public static const CAT:int              = 6;
	public static const LIZARD:int           = 7;
	public static const BUNNY:int            = 8;
	public static const KANGAROO:int         = 9;
	public static const SPIDER_FANGS:int     = 10;
	public static const FOX:int              = 11;
	public static const DRAGON:int           = 12;
	public static const RACCOON_MASK:int     = 13;
	public static const RACCOON:int          = 14;//button 0 on 2nd page of metamorph
	public static const BUCKTEETH:int        = 15;
	public static const MOUSE:int            = 16;
	public static const FERRET_MASK:int      = 17;
	public static const FERRET:int           = 18;
	public static const PIG:int              = 19;
	public static const BOAR:int             = 20;
	public static const RHINO:int            = 21;
	public static const ECHIDNA:int          = 22;
	public static const DEER:int             = 23;
	public static const WOLF:int             = 24;
	public static const MANTICORE:int        = 25;
	public static const SALAMANDER_FANGS:int = 26;
	public static const YETI_FANGS:int       = 27;
	public static const ORCA:int	         = 28;//button 0 on 3rd page of metamorph
	public static const PLANT_DRAGON:int	 = 29;
	public static const DRAGON_FANGS:int	 = 30;
	public static const DEVIL_FANGS:int 	 = 31;
	public static const ONI_TEETH:int   	 = 32;
	public static const RAIJU_FANGS:int 	 = 33;
	public static const VAMPIRE:int     	 = 34;
	public static const BUCKTOOTH:int   	 = 35;
	public static const JABBERWOCKY:int 	 = 36;
	public static const RED_PANDA:int   	 = 37;
	public static const CAT_CANINES:int 	 = 38;
	public static const CHESHIRE:int    	 = 39;
	public static const CHESHIRE_SMILE:int	 = 40;
	public static const AVIAN:int			 = 41;
	public static const WOLF_FANGS:int		 = 42;//button 0 on 4th page of metamorph
	public static const ORC_FANGS:int		 = 43;
	public static const ANIMAL_TOOTHS:int	 = 44;
	public static const BEAR:int			 = 45;
	public static const PANDA:int			 = 46;
	public static const FIRE_SNAIL:int		 = 47;
	public static const GHOST:int			 = 48;
	public static const JIANGSHI:int		 = 49;
	public static const YUKI_ONNA:int		 = 50;
	// Don't forget to add new types in DebugMenu.as list FACE_TYPE_CONSTANTS
	
	public function Face(creature:Creature) {
		super(creature,"facePart",[]);
	}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
	}
	public function hasMuzzle():Boolean {
		return [
			HORSE, DOG, CAT, LIZARD, KANGAROO,
			FOX, DRAGON, RHINO, ECHIDNA, DEER,
			WOLF
			   ].indexOf(type) >= 0;
	}
	public function hasBeak():Boolean {
		return [
			AVIAN
			   ].indexOf(type) >= 0;
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
	public function isHumanShaped():Boolean {
		return isAny(HUMAN,
				MANTICORE, BUCKTEETH, BUNNY, SHARK_TEETH, SNAKE_FANGS, SPIDER_FANGS,
				YETI_FANGS, SALAMANDER_FANGS, ONI_TEETH, ORC_FANGS, CHESHIRE_SMILE,
				FERRET_MASK, VAMPIRE, ANIMAL_TOOTHS, FIRE_SNAIL, GHOST);
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
			faceo = a + "rugged looks ";
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
				return an + "androgynous set of features that would look normal on a male or female";
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
}
}
