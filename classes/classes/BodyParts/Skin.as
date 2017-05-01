package classes.BodyParts {
import classes.Appearance;
import classes.Creature;

/**
 * Container class for the players skin
 *
 * * character has two layer of skin: base and ~~cover~~ coat
 * each layer has: `type`, `tone`, `adj` (optional adjective), and `desc` (overrides default noun for type)
 * a **coverage** parameter with the rance:
 * `(0) COVERAGE_NONE` : coat layer is non-existant
 * `(1) COVERAGE_LOW` : coat layer exists, but its descriptions appear only when explicitly called
 * `(2) COVERAGE_MEDIUM` : coat layer exists, descriptions use mixed "[base] and [coat]", can explicitly check either
 * `(3) COVERAGE_HIGH` : coat layer exists and is used as a default layer when describing skin; base description appear only when explicitly called
 * `(4) COVERAGE_FULL` : this is virtual state which should automatically reset the `{base:A, cover:B, coverage:FULL}` to `{base:B, coverage: NONE}`.
 * tattoos should be moved to body part-level or character-level
 *
 * @since December 27, 2016
 * @author Stadler76, aimozg
 */
public class Skin extends SaveableBodyPart {
	include "../../../includes/appearanceDefs.as";

	public static const COVERAGE_NONE:int   = 0;
	public static const COVERAGE_LOW:int    = 1;
	public static const COVERAGE_MEDIUM:int = 2;
	public static const COVERAGE_HIGH:int   = 3;
	public static const COVERAGE_FULL:int   = 4;

	public var base:SkinLayer;
	public var coat:SkinLayer;
	private var _coverage:int  = COVERAGE_NONE;

	public function Skin(creature:Creature) {
		super(creature, "skin", ["coverage"]);
		base = new SkinLayer(this);
		coat = new SkinLayer(this);
		addPublicJsonables(["base","coat"]);
	}

	[Deprecated(replacement="describe('coat')")]
	public function skinFurScales():String {
		return describe('coat');
	}
	public function get coverage():int {
		return _coverage;
	}
	public function set coverage(value:int):void {
		if (value <= COVERAGE_NONE) {
			_coverage = COVERAGE_NONE;
		} else if (value >= COVERAGE_FULL) {
			base.setAllProps(coat, false);
			_coverage = COVERAGE_NONE;
		} else {
			_coverage = value;
		}
	}
	public function get tone():String {
		return color;
	}
	public function get color():String {
		return skinValue(base.color, coat.color);
	}
	public function get desc():String {
		return skinValue(base.desc, coat.desc);
	}
	public function get adj():String {
		return skinValue(base.adj, coat.adj);
	}
	override public function get type():int {
		if (coverage >= COVERAGE_FULL) return coat.type;
		return base.type;
	}
	/**
	 * Checks both layers against property set
	 * @param p {color, type, adj, desc}
	 * @return this.base, this.coat, or null
	 */
	public function findLayer(p:Object):SkinLayer {
		if (coverage < COVERAGE_FULL && base.checkProps(p)) return base;
		if (coverage > COVERAGE_NONE && coat.checkProps(p)) return coat;
		return null;
	}
	/**
	 * @param props {type, color, adj, desc}
	 */
	public function setSingleLayer(props:Object):void {
		coverage = COVERAGE_NONE;
		base.setProps(props);
	}
	/**
	 * @param coat {type, color, adj, desc}
	 * @param base {type, color, adj, desc}
	 */
	public function setPatches(coat:Object,base:Object=null):void {
		coverage = COVERAGE_LOW;
		this.coat.setProps(coat);
		this.base.setProps(base);
	}
	/**
	 * @param coat {type, color, adj, desc}
	 * @param base {type, color, adj, desc}
	 */
	public function setMixed(coat:Object,base:Object):void {
		coverage = COVERAGE_MEDIUM;
		this.coat.setProps(coat);
		this.base.setProps(base);
	}
	/**
	 * @param coat {type, color, adj, desc}
	 * @param base {type, color, adj, desc}
	 */
	public function setCovered(coat:Object,base:Object=null):void {
		coverage = COVERAGE_HIGH;
		this.coat.setProps(coat);
		this.base.setProps(base);
	}
	/**
	 * @param layer 'base','coat','skin' (both layer if MEDIUM, else major),'full' (both layers if present)
	 * @return
	 */
	public function describe(layer:String = 'skin', noAdj:Boolean = false, noTone:Boolean = false):String {
		var s_base:String = base.describe(noAdj, noTone);
		var s_coat:String = coat.describe(noAdj,noTone);
		switch (coverage) {
			case COVERAGE_NONE:
				return s_base;
			case COVERAGE_LOW:
				switch (layer) {
					case 'coat':
						return s_coat;
					case 'full':
						return s_base + " with patches of " + s_coat;
					case 'skin':
					case 'base':
					default:
						return s_base;
				}
				break;
			case COVERAGE_MEDIUM:
				switch (layer) {
					case 'coat':
						return s_coat;
					case 'full':
					case 'skin':
						return s_base + " and " + s_coat;
					case 'base':
			default:
						return s_base;
		}
				break;
			case COVERAGE_HIGH:
				switch (layer) {
					case 'base':
						return s_coat;
					case 'full':
						return s_base + " under " + s_coat;
					case 'skin':
					case 'coat':
			default:
						return s_coat;
		}
				break;
			case COVERAGE_FULL:
			default:
				return s_coat;
		}

	}
	override public function descriptionFull():String {
		return describe("full");
	}
	public function hasAny(...types:Array):Boolean {
		if (types.length === 1 && types[0] is Array) types = types[0];
		return (coverage < COVERAGE_FULL && base.isAny(types)) ||
			   (coverage > COVERAGE_NONE && coat.isAny(types));
	}
	public function hasFur():Boolean {
		return hasAny(SKIN_TYPE_FUR);
	}
	public function hasChitin():Boolean {
		return hasAny(SKIN_TYPE_CHITIN);
	}
	public function hasBark():Boolean {
		return hasAny(SKIN_TYPE_BARK);
	}
	public function isPartiallyCovered():Boolean {
		return coverage > COVERAGE_NONE && coverage < COVERAGE_HIGH;
	}
	public function isCovered():Boolean {
		return coverage > COVERAGE_NONE && coverage < COVERAGE_FULL;
	}
	public function isFacePartiallyCovered():Boolean {
		return coverage == COVERAGE_HIGH;
	}
	public function hasScales():Boolean {
		return hasAny(SKIN_TYPE_SCALES, SKIN_TYPE_AQUA_SCALES, SKIN_TYPE_DRAGON_SCALES);
	}
	public function hasReptileScales():Boolean {
		return hasAny(SKIN_TYPE_SCALES,SKIN_TYPE_DRAGON_SCALES);
	}
	public function hasDragonScales():Boolean {
		return hasAny(SKIN_TYPE_DRAGON_SCALES);
	}
	public function hasLizardScales():Boolean {
		return hasAny(SKIN_TYPE_SCALES);
	}
	public function hasNonLizardScales():Boolean {
		return hasScales() && !hasLizardScales();
	}
	[Deprecated]
	public function hasFurOrScales():Boolean {
		return hasFur() || hasScales();
	}
	public function hasGooSkin():Boolean {
		return hasAny(SKIN_TYPE_GOO);
	}
	public function hasPlainSkinOnly():Boolean {
		return coverage == COVERAGE_NONE && base.type == SKIN_TYPE_PLAIN;
	}
	public function hasPlainSkin():Boolean {
		return coverage < COVERAGE_FULL && base.type == SKIN_TYPE_PLAIN;
	}
	public function hasSmoothSkinType():Boolean {
		return isAny(SKIN_TYPE_PLAIN, SKIN_TYPE_GOO, SKIN_TYPE_STONE);
	}
	override public function restore(keepTone:Boolean = true):void {
		coverage = COVERAGE_NONE;
		base.restore(keepTone);
		coat.restore(keepTone);
	}
	private function skinValue(inBase:String, inCoat:String):String {
		switch (coverage) {
			case COVERAGE_NONE:
			case COVERAGE_LOW:
				return inBase;
			case COVERAGE_MEDIUM:
				return inBase + " and " + inCoat;
			case COVERAGE_HIGH:
			case COVERAGE_FULL:
			default:
				return inCoat;
		}
	}
	//noinspection JSDeprecatedSymbols
	private static const PARTIAL_TO_FULL:Object = createMapFromPairs([
		[SKIN_TYPE_PARTIAL_CHITIN, SKIN_TYPE_CHITIN],
		[SKIN_TYPE_PARTIAL_SCALES, SKIN_TYPE_SCALES],
		[SKIN_TYPE_PARTIAL_FUR, SKIN_TYPE_FUR],
		[SKIN_TYPE_PARTIAL_BARK, SKIN_TYPE_BARK],
		[SKIN_TYPE_PARTIAL_AQUA_SCALES, SKIN_TYPE_AQUA_SCALES],
		[SKIN_TYPE_PARTIAL_DRAGON_SCALES, SKIN_TYPE_DRAGON_SCALES],
		[SKIN_TYPE_PARTIAL_STONE, SKIN_TYPE_PARTIAL_STONE]
	]);
	[Deprecated]
	public override function set type(value:int):void {
		//noinspection JSDeprecatedSymbols
		switch (value) {
			case SKIN_TYPE_PLAIN:
			case SKIN_TYPE_GOO:
			case SKIN_TYPE_UNDEFINED:
			case SKIN_TYPE_TATTOED:
			case SKIN_TYPE_STONE:
			case SKIN_TYPE_SCALES:
			case SKIN_TYPE_AQUA_SCALES:
			case SKIN_TYPE_DRAGON_SCALES:
				coverage  = COVERAGE_NONE;
				base.type = value;
				break;
			case SKIN_TYPE_PARTIAL_FUR:
			case SKIN_TYPE_PARTIAL_SCALES:
			case SKIN_TYPE_PARTIAL_AQUA_SCALES:
			case SKIN_TYPE_PARTIAL_DRAGON_SCALES:
			case SKIN_TYPE_PARTIAL_CHITIN:
			case SKIN_TYPE_PARTIAL_BARK:
			case SKIN_TYPE_PARTIAL_STONE:
				coverage  = COVERAGE_LOW;
				base.type = SKIN_TYPE_PLAIN;
				coat.type = PARTIAL_TO_FULL[value];
				break;
			case SKIN_TYPE_FUR:
			case SKIN_TYPE_CHITIN:
			case SKIN_TYPE_BARK:
				coverage  = COVERAGE_HIGH;
				base.type = SKIN_TYPE_PLAIN;
				coat.type = value;
				break;
		}
	}
	override protected function loadFromOldSave(savedata:Object):void {
		//Convert from old skinDesc to new skinAdj + skinDesc!
		var type:int = intOr(savedata.skinType, SKIN_TYPE_PLAIN);
		//noinspection JSDeprecatedSymbols
		if (type === SKIN_TYPE_UNDEFINED) type = SKIN_TYPE_PLAIN;
		var desc:String = stringOr(savedata.skinDesc, "");
		var adj:String  = stringOr(savedata.skinAdj, "");
		for each (var legacyAdj:String in ["smooth", "thick", "rubber", "latex", "slimey"]) {
			if (desc.indexOf(legacyAdj) != -1) {
				adj = legacyAdj;
				if (type == SKIN_TYPE_FUR) {
					desc = "fur";
				} else if (type == SKIN_TYPE_GOO) {
					desc = "goo";
				} else if ([
							   SKIN_TYPE_SCALES,
							   SKIN_TYPE_AQUA_SCALES,
								SKIN_TYPE_DRAGON_SCALES
						   ].indexOf(type) >= 0) {
					desc = "scales";
				} else {
					desc = "skin";
	}
	}
		}
		var tone:String        = stringOr(savedata.skinTone, "albino");
		var furColor:String    = stringOr(savedata.furColor, stringOr(savedata.hairColor, ""));
		var chitinColor:String = stringOr(savedata.chitinColor, "");
		var scalesColor:String = stringOr(savedata.scalesColor, "");
		if (furColor === "no") furColor = "";
		if (chitinColor === "no") chitinColor = "";
		if (scalesColor === "no") scalesColor = "";
		//noinspection JSDeprecatedSymbols
		if (InCollection(type, SKIN_TYPE_PLAIN, SKIN_TYPE_GOO, SKIN_TYPE_TATTOED, SKIN_TYPE_STONE, SKIN_TYPE_SCALES, SKIN_TYPE_AQUA_SCALES, SKIN_TYPE_PARTIAL_DRAGON_SCALES)) {
			coverage   = COVERAGE_NONE;
			base.type  = type;
			base.color = (type == SKIN_TYPE_SCALES && scalesColor) ? scalesColor : tone;
			base.adj   = adj;
			base.desc  = desc;
		} else {
			coverage = COVERAGE_HIGH;
			if (type in PARTIAL_TO_FULL) {
				coverage = COVERAGE_LOW;
				type     = PARTIAL_TO_FULL[type];
			}
			coat.type  = type;
			coat.adj   = adj;
			coat.desc  = desc;
			base.color = tone;
			if (type === SKIN_TYPE_FUR) {
				coat.color = furColor;
			} else if (type === SKIN_TYPE_SCALES) {
				coat.color = scalesColor;
			} else if (type === SKIN_TYPE_CHITIN) {
				coat.color = chitinColor;
			}
			if (!coat.color) coat.color = furColor || scalesColor || chitinColor || "white";
		}
	}
	override protected function saveToOldSave(savedata:Object):void {
		savedata.skinType = type;
		savedata.skinDesc = desc;
		savedata.skinAdj  = adj;
		savedata.skinTone = tone;
		savedata.furColor = coat.color;
		savedata.scalesColor = coat.color;
		savedata.chitinColor = coat.color;
	}
}
}
