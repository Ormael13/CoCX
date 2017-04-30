package classes.BodyParts {
import classes.Appearance;
import classes.Appearance;
import classes.Creature;
import classes.internals.Utils;

/**
 * Container class for the players skin
 * @since December 27, 2016
 * @author Stadler76
 */
public class Skin extends BodyPart {
	include "../../../includes/appearanceDefs.as";

	private var _desc:String   = "";
	public var furColor:String = "no";
	public var tone:String     = "albino";
	public var adj:String      = "";

	public function Skin(creature:Creature) {
		super(creature, ["tone", "adj", "desc", "furColor"]);
	}

	public function skinFurScales():String {
		return describe('cover');
	}
	public function defaultDesc():String {
		return Appearance.DEFAULT_SKIN_DESCS[
					   isPartiallyCovered()
							   ? PARTIAL_TO_FULL[type]
							   : type
					   ] || "skin";
	}
	public function get color():String { return tone; }
	public function get desc():String {
		return _desc || defaultDesc();
	}
	public function set desc(value:String):void {
		_desc = value == defaultDesc() ? "" : value;
	}
	override public function set type(value:int):void {
		super.type = value;
		_desc      = "";
	}
	/**
	 * @param layer: (default 'basic')
	 *  opt\cov | 0 (none) |    1 (partial)     | 2 (maximum)
	 * ---------+----------+--------------------+------------
	 *  'basic' | [basic]  |      [basic]       | [basic]
	 *  'main'  | [basic]  |      [basic]       | [cover]
	 *  'cover' | [basic]  |      [cover]       | [cover]
	 *  'both'  | [basic]  |[basic] with [cover]| [basic] under [cover]
	 * @param noTone (default false)
	 * @param noAdj (default false)
	 */
	public function describe(layer:String = 'main', noAdj:Boolean = false, noTone:Boolean = false):String {
		var cover:int             = coverage();
		var c_adj:String          = [adj, "small patches of", adj][cover];
		var c_adj_tone_sep:String = [", ", " ", ", "][cover];
		var c_tone:String         = [tone, coverColor(), coverColor()][cover];
		var c_desc:String         = desc;//[desc, desc, desc][cover];
		var b_adj:String          = adj;//[adj, adj, adj][cover];
		var b_tone:String         = tone;//[tone,tone,tone][cover];
		var b_desc:String         = [desc, "skin", "skin"][cover];
		if (noAdj) c_adj = b_adj = "";
		if (noTone) c_tone = b_tone = "";
		if (layer == 'main') layer = ['basic', 'basic', 'cover'][cover];
		if (cover == 0) layer = 'basic';
		var b_part:String = b_adj + (b_adj && b_tone ? ", " : "") + b_tone + (b_tone || b_adj ? " " : "") + b_desc;
		var c_part:String = c_adj + (c_adj && c_tone ? c_adj_tone_sep : "") + c_tone + (c_tone || c_adj ? " " : "") + c_desc;
		switch (layer) {
			case 'cover':
				return c_part;
			case 'both':
				return b_part + ["", " with ", " under "][cover] + c_part;
			case 'basic':
			default:
				return b_part;
		}
	}
	public function coverColor():String {
		switch (type) {
			case SKIN_TYPE_PARTIAL_FUR:
			case SKIN_TYPE_FUR:
				return furColor;
			case SKIN_TYPE_PARTIAL_SCALES:
			case SKIN_TYPE_SCALES:
				return creature.scalesColor;
			case SKIN_TYPE_PARTIAL_CHITIN:
			case SKIN_TYPE_CHITIN:
				return creature.chitinColor;
			case SKIN_TYPE_PARTIAL_BARK:
			case SKIN_TYPE_BARK:
				return tone;
			default:
				return "no";
		}
	}
	// Returns 0: none, 1: partial, 2: max cover
	public function coverage():int {
		switch (type) {
			case SKIN_TYPE_PLAIN:
			case SKIN_TYPE_GOO:
			case SKIN_TYPE_UNDEFINED:
			case SKIN_TYPE_TATTOED:
			case SKIN_TYPE_STONE:
				return 0;
			case SKIN_TYPE_PARTIAL_FUR:
			case SKIN_TYPE_PARTIAL_SCALES:
			case SKIN_TYPE_PARTIAL_CHITIN:
			case SKIN_TYPE_PARTIAL_BARK:
				return 1;
			case SKIN_TYPE_FUR:
			case SKIN_TYPE_SCALES:
			case SKIN_TYPE_AQUA_SCALES:
			case SKIN_TYPE_CHITIN:
			case SKIN_TYPE_BARK:
				return 2;
			default:
				return 0;
		}
	}
	override public function descriptionFull():String {
		return describe("both");
	}
	public function hasFur():Boolean {
		return [SKIN_TYPE_FUR, SKIN_TYPE_PARTIAL_FUR].indexOf(type) != -1;
	}
	public function hasScales():Boolean {
		return [SKIN_TYPE_SCALES, SKIN_TYPE_AQUA_SCALES, SKIN_TYPE_PARTIAL_SCALES].indexOf(type) != -1;
	}
	public function hasChitin():Boolean {
		return [SKIN_TYPE_CHITIN, SKIN_TYPE_PARTIAL_CHITIN].indexOf(type) != -1;
	}
	public function hasBark():Boolean {
		return [SKIN_TYPE_BARK, SKIN_TYPE_PARTIAL_BARK].indexOf(type) != -1;
	}
	public function isPartiallyCovered():Boolean {
		return [
				   SKIN_TYPE_PARTIAL_FUR, SKIN_TYPE_PARTIAL_BARK, SKIN_TYPE_PARTIAL_SCALES, SKIN_TYPE_PARTIAL_CHITIN
			   ].indexOf(type) != -1;
	}
	public function isCovered():Boolean {
		return isPartiallyCovered()
			   || [
					  SKIN_TYPE_FUR, SKIN_TYPE_BARK, SKIN_TYPE_SCALES, SKIN_TYPE_CHITIN
				  ].indexOf(type) != -1;
	}
	public function isFacePartiallyCovered():Boolean {
		return [
				   SKIN_TYPE_SCALES, SKIN_TYPE_PARTIAL_SCALES, SKIN_TYPE_FUR
			   ].indexOf(type) != -1;
	}
	public function hasReptileScales():Boolean {
		return [SKIN_TYPE_SCALES, SKIN_TYPE_PARTIAL_SCALES].indexOf(type) != -1;
	}
	public function hasDragonScales():Boolean {
		return false;//type == SKIN_TYPE_DRAGON_SCALES;
	}
	public function hasLizardScales():Boolean {
		return type == SKIN_TYPE_SCALES;//type == SKIN_TYPE_LIZARD_SCALES;
	}
	public function hasNonLizardScales():Boolean {
		return hasScales() && !hasLizardScales();
	}
	public function hasFurOrScales():Boolean {
		return hasFur() || hasScales();
	}
	public function hasGooSkin():Boolean {
		return type == SKIN_TYPE_GOO;
	}
	public function hasPlainSkinOnly(allowTatoo:Boolean = true):Boolean {
		return type == SKIN_TYPE_PLAIN
			   || allowTatoo && type == SKIN_TYPE_TATTOED;
	}
	public function hasPlainSkin(allowTatoo:Boolean = true):Boolean {
		return isPartiallyCovered()
			   || type == SKIN_TYPE_PLAIN
			   || allowTatoo && type == SKIN_TYPE_TATTOED;
	}
	public function hasSmoothSkinType(allowPartiallyCovered:Boolean = true):Boolean {
		return isAny(SKIN_TYPE_TATTOED, SKIN_TYPE_PLAIN, SKIN_TYPE_GOO, SKIN_TYPE_STONE)
			   || allowPartiallyCovered && isPartiallyCovered();
	}
	override public function restore(keepTone:Boolean = true):void {
		super.restore(keepTone);
		if (!keepTone) tone = "albino";
		desc     = "skin";
		furColor = "no";
		adj      = "";
	}

	public function setProps(p:Object):void {
		Utils.copyObjectEx(this, p, myPublicPrimitives);
	}

	public function setAllProps(p:Object, keepTone:Boolean = true):void {
		restore(keepTone);
		setProps(p);
	}
	public static const PARTIAL_TO_FULL:Object = Appearance.createMapFromPairs([
		[SKIN_TYPE_PARTIAL_CHITIN, SKIN_TYPE_CHITIN],
		[SKIN_TYPE_PARTIAL_SCALES, SKIN_TYPE_SCALES],
		[SKIN_TYPE_PARTIAL_FUR, SKIN_TYPE_FUR],
		[SKIN_TYPE_PARTIAL_BARK, SKIN_TYPE_BARK]
	]);
}
}
