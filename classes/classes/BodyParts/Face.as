/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;

public class Face extends SaveableBodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 10)
	 * - id: name of the constant ("HUMAN", "SPIDER_FANGS")
	 * - name: human-readable name, ("human", "spider")
	 * - bite:
	 */
	public static var Types:/*EnumValue*/Array = [];

	public static const HUMAN:int            = 0;
	EnumValue.add(Types, HUMAN, "HUMAN", {name: "human"});
	public static const HORSE:int            = 1;
	EnumValue.add(Types, HORSE, "HORSE", {name: "horse"});
	public static const DOG:int              = 2;
	EnumValue.add(Types, DOG, "DOG", {name: "dog", bite: true});
	public static const COW_MINOTAUR:int     = 3;
	EnumValue.add(Types, COW_MINOTAUR, "COW_MINOTAUR", {name: "cow"});
	public static const SHARK_TEETH:int      = 4;
	EnumValue.add(Types, SHARK_TEETH, "SHARK_TEETH", {name: "shark", bite: true});
	public static const SNAKE_FANGS:int      = 5;
	EnumValue.add(Types, SNAKE_FANGS, "SNAKE_FANGS", {name: "snake", bite: true});
	public static const CAT:int              = 6;
	EnumValue.add(Types, CAT, "CAT", {name: "cat", bite: true});
	public static const LIZARD:int           = 7;
	EnumValue.add(Types, LIZARD, "LIZARD", {name: "lizard", bite: true});
	public static const BUNNY:int            = 8;
	EnumValue.add(Types, BUNNY, "BUNNY", {name: "bunny", bite: true});
	public static const KANGAROO:int         = 9;
	EnumValue.add(Types, KANGAROO, "KANGAROO", {name: "kangaroo"});
	public static const SPIDER_FANGS:int     = 10;
	EnumValue.add(Types, SPIDER_FANGS, "SPIDER_FANGS", {name: "spider", bite: true});
	public static const FOX:int              = 11;
	EnumValue.add(Types, FOX, "FOX", {name: "fox", bite: true});
	public static const DRAGON:int           = 12;
	EnumValue.add(Types, DRAGON, "DRAGON", {name: "dragon", bite: true});
	public static const RACCOON_MASK:int     = 13;
	EnumValue.add(Types, RACCOON_MASK, "RACCOON_MASK", {name: "raccoon mask"});
	public static const RACCOON:int          = 14;//button 0 on 2nd page of metamorph
	EnumValue.add(Types, RACCOON, "RACCOON", {name: "raccoon", bite: true});
	public static const BUCKTEETH:int        = 15;
	EnumValue.add(Types, BUCKTEETH, "BUCKTEETH", {name: "buckteeth", bite: true});
	public static const MOUSE:int            = 16;
	EnumValue.add(Types, MOUSE, "MOUSE", {name: "mouse", bite: true});
	public static const FERRET_MASK:int      = 17;
	EnumValue.add(Types, FERRET_MASK, "FERRET_MASK", {name: "ferret mask"});
	public static const FERRET:int           = 18;
	EnumValue.add(Types, FERRET, "FERRET", {name: "ferret", bite: true});
	public static const PIG:int              = 19;
	EnumValue.add(Types, PIG, "PIG", {name: "pig"});
	public static const BOAR:int             = 20;
	EnumValue.add(Types, BOAR, "BOAR", {name: "boar"});
	public static const RHINO:int            = 21;
	EnumValue.add(Types, RHINO, "RHINO", {name: "rhino"});
	public static const ECHIDNA:int          = 22;
	EnumValue.add(Types, ECHIDNA, "ECHIDNA", {name: "echidna"});
	public static const DEER:int             = 23;
	EnumValue.add(Types, DEER, "DEER", {name: "deer"});
	public static const WOLF:int             = 24;
	EnumValue.add(Types, WOLF, "WOLF", {name: "wolf", bite: true});
	public static const MANTICORE:int        = 25;
	EnumValue.add(Types, MANTICORE, "MANTICORE", {name: "manticore", bite: true});
	public static const SALAMANDER_FANGS:int = 26;
	EnumValue.add(Types, SALAMANDER_FANGS, "SALAMANDER_FANGS", {name: "salamander", bite: true});
	public static const YETI_FANGS:int       = 27;
	EnumValue.add(Types, YETI_FANGS, "YETI_FANGS", {name: "yeti", bite: true});
	public static const ORCA:int	         = 28;//button 0 on 3rd page of metamorph
	EnumValue.add(Types, ORCA, "ORCA", {name: "orca", bite: true});
	public static const PLANT_DRAGON:int	 = 29;
	EnumValue.add(Types, PLANT_DRAGON, "PLANT_DRAGON", {name: "plant dragon", bite: true});
	public static const DRAGON_FANGS:int	 = 30;
	EnumValue.add(Types, DRAGON_FANGS, "DRAGON_FANGS", {name: "dragon fangs", bite: true});
	public static const DEVIL_FANGS:int 	 = 31;
	EnumValue.add(Types, DEVIL_FANGS, "DEVIL_FANGS", {name: "devil fangs", bite: true});
	public static const ONI_TEETH:int   	 = 32;
	EnumValue.add(Types, ONI_TEETH, "ONI_TEETH", {name: "oni teeth", bite: true});
	public static const WEASEL:int 	 		 = 33;
	EnumValue.add(Types, WEASEL, "WEASEL", {name: "weasel", bite: true});
	public static const VAMPIRE:int     	 = 34;
	EnumValue.add(Types, VAMPIRE, "VAMPIRE", {name: "vampire", bite: true});
	public static const BUCKTOOTH:int   	 = 35;
	EnumValue.add(Types, BUCKTOOTH, "BUCKTOOTH", {name: "jabberwocky bucktooth", bite: true});
	public static const JABBERWOCKY:int 	 = 36;
	EnumValue.add(Types, JABBERWOCKY, "JABBERWOCKY", {name: "jabberwocky", bite: true});
	public static const RED_PANDA:int   	 = 37;
	EnumValue.add(Types, RED_PANDA, "RED_PANDA", {name: "red-panda", bite: true});
	public static const CAT_CANINES:int 	 = 38;
	EnumValue.add(Types, CAT_CANINES, "CAT_CANINES", {name: "cat canines", bite: true});
	public static const CHESHIRE:int    	 = 39;
	EnumValue.add(Types, CHESHIRE, "CHESHIRE", {name: "cheshire", bite: true});
	public static const CHESHIRE_SMILE:int	 = 40;
	EnumValue.add(Types, CHESHIRE_SMILE, "CHESHIRE_SMILE", {name: "cheshire", bite: true});
	public static const AVIAN:int			 = 41;
	EnumValue.add(Types, AVIAN, "AVIAN", {name: "avian", bite: true});
	public static const WOLF_FANGS:int		 = 42;//button 0 on 4th page of metamorph
	EnumValue.add(Types, WOLF_FANGS, "WOLF_FANGS", {name: "wolf fangs", bite: true});
	public static const ORC_FANGS:int		 = 43;
	EnumValue.add(Types, ORC_FANGS, "ORC_FANGS", {name: "orc fangs", bite: true});
	public static const ANIMAL_TOOTHS:int	 = 44;
	EnumValue.add(Types, ANIMAL_TOOTHS, "ANIMAL_TOOTHS", {name: "animal teeth", bite: true});
	public static const BEAR:int			 = 45;
	EnumValue.add(Types, BEAR, "BEAR", {name: "bear", bite: true});
	public static const PANDA:int			 = 46;
	EnumValue.add(Types, PANDA, "PANDA", {name: "panda", bite: true});
	public static const FIRE_SNAIL:int		 = 47;
	EnumValue.add(Types, FIRE_SNAIL, "FIRE_SNAIL", {name: "fire snail"});
	public static const GHOST:int			 = 48;
	EnumValue.add(Types, GHOST, "GHOST", {name: "ghost"});
	public static const JIANGSHI:int		 = 49;
	EnumValue.add(Types, JIANGSHI, "JIANGSHI", {name: "jiangshi"});
	public static const YUKI_ONNA:int		 = 50;
	EnumValue.add(Types, YUKI_ONNA, "YUKI_ONNA", {name: "yuki onna"});
	public static const KUDERE:int	 		 = 51;
	EnumValue.add(Types, KUDERE, "KUDERE", {name: "kuudere"});
	public static const USHI_ONI_ONNA:int	 = 52;
	EnumValue.add(Types, USHI_ONI_ONNA, "USHI_ONI_ONNA", {name: "ushi-oni", bite: true});
	public static const FAIRY:int            = 53;
	EnumValue.add(Types, FAIRY, "FAIRY", {name: "fairy"});
	public static const CRAZY:int            = 54;
	EnumValue.add(Types, CRAZY, "CRAZY", {name: "crazy"});
	public static const SMUG:int             = 55;
	EnumValue.add(Types, SMUG, "SMUG", {name: "smug"});
	public static const SQUIRREL:int         = 56;
	EnumValue.add(Types, SQUIRREL, "SQUIRREL", {name: "squirrel", bite: true});
	public static const ELF:int           	 = 57;
	EnumValue.add(Types, ELF, "ELF", {name: "elf"});

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
			WOLF, SQUIRREL, BEAR, PANDA
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
				FERRET_MASK, VAMPIRE, ANIMAL_TOOTHS, FIRE_SNAIL, GHOST, ELF, FAIRY,
				SMUG, JIANGSHI, KUDERE, YUKI_ONNA, USHI_ONI_ONNA, CRAZY, WOLF_FANGS);
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
