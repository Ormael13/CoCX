package classes.BodyParts {
import classes.Creature;
import classes.internals.Utils;

/**
 * Container class for the players skin
 * @since December 27, 2016
 * @author Stadler76
 */
public class Skin extends BodyPart {
	include "../../../includes/appearanceDefs.as";

	public var desc:String     = "skin";
	public var furColor:String = "no";
	public var tone:String     = "albino";
	public var adj:String      = "";

	public function Skin(creature:Creature) {
		super(creature);
		addPublicPrimitives("tone", "adj", "desc", "furColor");
	}

	public function skinFurScales():String {
		return describe({layer: 'cover'});
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
				return coverLayerDesc(options);
			case 'both':
				switch (coverage()) {
					case 0:
						return basicLayerDesc(options.noAdj, options.noTone);
					case 1:
						return basicLayerDesc(options.noAdj, options.noTone) +
							   ' covered with ' +
							   coverLayerDesc(options.noAdj, options.noTone);
					default:
					case 2:
						return coverLayerDesc(options.noAdj, options.noTone);
				}
			case 'basic':
			default:
				return basicLayerDesc(options);
		}
	}
	public function coverColor():String {
		switch (type) {
			case SKIN_TYPE_PARTIAL_FUR:
			case SKIN_TYPE_FUR:
				return creature.furColor;
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
	public function coverLayerDesc(noAdj:Boolean = false, noTone:Boolean = false):String {
		var p_adj:String  = coverage() == 1 ? "small patches of" : adj;
		var p_tone:String = coverage() > 0 ? coverColor() : tone;
		if (noTone) p_tone = "";
		if (noAdj) p_adj = "";
		return p_adj + (p_adj && p_tone ? ", " : "") + p_tone + (p_adj || p_tone ? " " : "") + desc;
	}
	public function basicLayerDesc(noAdj:Boolean = false, noTone:Boolean = false):String {
		var p_adj:String  = !noAdj ? adj : "";
		var p_tone:String = coverage() > 0 ? furColor : tone;
		var p_desc:String = (coverage() <= 1) ? desc : "skin";
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

	public function hasPlainSkin():Boolean {
		return type == SKIN_TYPE_PLAIN;
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
}
}
