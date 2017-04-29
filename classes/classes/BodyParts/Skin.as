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
		return describe({layer: 'cover'});
	}
	public function defaultDesc():String {
		return Appearance.DEFAULT_SKIN_DESCS[
					   isPartiallyCovered()
							   ? PARTIAL_TO_FULL[type]
							   : Appearance.DEFAULT_SKIN_DESCS[type]
					   ] || "skin";
	}
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
	 * @param options.layer: (default 'basic'
	 *  opt\cov | 0 (none)| 2 (full)| 1 (partial)
	 * ---------+---------+---------+------------
	 *  'basic' | [basic] | [basic] | [basic]
	 *  'cover' | [basic] | [cover] | [cover]
	 *  'both'  | [basic] | [cover] | [basic] covered with [cover]
	 * @param options.noTone (default false)
	 * @param options.noAdj (default false)
	 */
	override public function describe(options:Object):String {
		switch (options.layer) {
			case 'cover':
				return coverLayerDescription(options);
			case 'both':
				switch (coverage()) {
					case 0:
						return basicLayerDescription(options.noAdj, options.noTone);
					case 1:
						return basicLayerDescription(options.noAdj, options.noTone) +
							   ' covered with ' +
							   coverLayerDescription(options.noAdj, options.noTone);
					default:
					case 2:
						return coverLayerDescription(options.noAdj, options.noTone);
				}
			case 'basic':
			default:
				return basicLayerDescription(options);
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
				return "";
			default:
				return "no";
		}
	}
	public function coverLayerDescription(noAdj:Boolean = false, noTone:Boolean = false):String {
		var p_adj:String  = [adj, "small patches of", adj][coverage()];
		var p_tone:String = [tone, coverColor(), tone][coverage()];
		if (noTone) p_tone = "";
		if (noAdj) p_adj = "";
		return p_adj + (p_adj && p_tone ? " " : "") + p_tone + (p_adj || p_tone ? " " : "") + desc;
	}
	public function basicLayerDescription(noAdj:Boolean = false, noTone:Boolean = false):String {
		var p_adj:String  = !noAdj ? adj : "";
		var p_tone:String = tone;//[tone,tone,tone][coverage()];
		var p_desc:String = [desc, "skin", "skin"][coverage()];
		if (noTone) p_tone = "";
		return p_adj + (p_adj && p_tone ? ", " : "") + p_tone + (p_adj || p_tone ? " " : "") + p_desc;
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
	public function description(noAdj:Boolean = false, noTone:Boolean = false):String {
		return describe({noAdj: noAdj, noTone: noTone});
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
