/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;
import classes.internals.Utils;

public class Face extends BodyPart {

	public function Face(creature:Creature) {
		super(creature);
	}

	public function hasMuzzle():Boolean {
		return [
				   FACE_HORSE, FACE_DOG, FACE_CAT, FACE_LIZARD, FACE_KANGAROO,
				   FACE_FOX, FACE_DRAGON, FACE_RHINO, FACE_ECHIDNA, FACE_DEER,
				   FACE_WOLF
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
	public function nounPhrase():String {
		var stringo:String = "";
		if (type == FACE_HUMAN) return "face";
		if (hasMuzzle()) {
			if (Utils.trueOnceInN(3)) {
				if (type == FACE_HORSE) stringo = "long ";
				if (type == FACE_CAT) stringo = "feline ";
				if (type == FACE_RHINO) stringo = "rhino ";
				if (type == FACE_LIZARD
					|| type == FACE_DRAGON) stringo = "reptilian ";
				if (type == FACE_WOLF) stringo = "canine ";
			}
			return stringo + Utils.randomChoice("muzzle", "snout", "face");
		}
		//3 - cowface
		if (type == FACE_COW_MINOTAUR) {
			if (Utils.trueOnceInN(4)) stringo = "bovine ";
			return Utils.randomChoice("muzzle", stringo + "face");
		}
		//4 - sharkface-teeth
		if (type == FACE_SHARK_TEETH) {
			if (Utils.trueOnceInN(4)) stringo = "angular ";
			return stringo + "face";
		}
		if (type == FACE_PIG || type == FACE_BOAR) {
			if (Utils.trueOnceInN(4))
				stringo = (type == FACE_PIG ? "pig" : "boar") + "-like ";
			if (Utils.trueOnceInN(4))
				return stringo + "snout";
			return stringo + "face";
		}
		return "face";
	}
	/**
	 * @param options.fem (default false): Describe femininity level
	 * @param options.a (default false): Add an article a/an/the
	 */
	override public function describe(options:Object):String {
		var femininity:Number = creature.femininity;
		var a:String          = "", an:String = "", the:String = "";
		if (options.a) {
			a   = "a ";
			an  = "an ";
			the = "the ";
		}
		if (!options.fem) {
			return a + nounPhrase();
		} else {
			var faceo:String = "";
			//0-10
			if (femininity < 10) {
				faceo = a + "square chin";
				if (!hasBeard()) faceo += " and chiseled jawline";
				else faceo += ", chiseled jawline, and " + beard();
				return faceo;
			}
			//10+ -20
			else if (femininity < 20) {
				faceo = a + "rugged looking " + nounPhrase() + " ";
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
	}
}
}
