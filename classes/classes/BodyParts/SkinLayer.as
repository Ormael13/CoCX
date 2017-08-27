/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Appearance;
import classes.Creature;

public class SkinLayer extends BodyPart {
	public var color:String  = "albino";
	public var pattern:int   = PATTERN_NONE;
	private var _desc:String = "";
	private var _adj:String  = "";
	private var _color2:String = "";
	private var skin:Skin; // Reference to parent

	public function get color2():String {
		return _color2 || color;
	}
	public function set color2(value:String):void {
		_color2 = value == color ? "" : value;
	}
	public function defaultDesc():String {
		return Appearance.DEFAULT_SKIN_DESCS[type] || "skin";
	}
	public function defaultAdj():String {
		return Appearance.DEFAULT_SKIN_ADJS[type] || "";
	}
	public function get desc():String {
		return _desc || defaultDesc();
	}
	public function set desc(value:String):void {
		_desc = value == defaultDesc() ? "" : value;
	}
	public function get adj():String {
		return _adj;
	}
	public function set adj(value:String):void {
		_adj = value == defaultAdj() ? "" : value;
	}
	[Deprecated("Use color, not tone")]
	public function get tone():String {
		trace("[DEPRECATED] SkinLayer.tone get");
		return color;
	}
	[Deprecated("Use color, not tone")]
	public function set tone(value:String):void {
		trace("[DEPRECATED] SkinLayer.tone = "+value);
		this.color = value;
	}
	override public function set type(value:int):void {
		if (type != value) {
			super.type = value;
			_desc      = "";
			pattern    = PATTERN_NONE;
			if (!_adj) _adj = defaultAdj();
		}
	}
	/**
	 * Returns `s` (default "is") if the skin main layer noun is singular (skin,fur,chitin)
	 * and `p` (default "are") if plural (scales)
	 */
	public function isAre(s:String="is",p:String="are"):String {
		return Appearance.DEFAULT_SKIN_PLURAL[type] ? p : s;
	}
	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		if (!keepColor) color = "no";
		adj  = "";
		desc = "skin";
	}
	public function SkinLayer(skin:Skin) {
		super(skin.creature, ["adj", "desc", "color", "color2", "pattern"]);
		this.skin = skin;
	}
	public function describe(noAdj:Boolean = false, noColor:Boolean = false):String {
		var c_adj:String  = noAdj ? "" : adj;
		var c_color:String = noColor ? "" : color;
		return c_adj + (c_adj && c_color ? ", " : "") + c_color + (c_color || c_adj ? " " : "") + desc;
	}

	override public function descriptionFull():String {
		return describe();
	}

	override public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		super.loadFromObject(o, ignoreErrors);
		if (_adj == "sexy tattooed") {
			pattern = PATTERN_MAGICAL_TATTOO;
		} else if (_adj == "covered with various intricate battle tattoos") {
			pattern = PATTERN_BATTLE_TATTOO;
		} else if (color == "white and black") {
			color = "white";
			color2 = "black";
			pattern = PATTERN_ORCA_UNDERBODY;
		}
	}
}
}
