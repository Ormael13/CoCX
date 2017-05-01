/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Appearance;
import classes.Creature;

public class SkinLayer extends BodyPart {
	public var tone:String   = "albino";
	private var _desc:String = "";
	private var _adj:String  = "";
	private var skin:Skin; // Reference to parent

	public function defaultDesc():String {
		return Appearance.DEFAULT_SKIN_DESCS[type] || "skin";
	}
	public function defaultAdj():String {
		return Appearance.DEFAULT_SKIN_ADJS[type] || "";
	}
	public function get color():String { return tone; }
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
	override public function set type(value:int):void {
		super.type = value;
		_desc      = "";
		if (!_adj) _adj = defaultAdj();
	}
	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		if (!keepColor) tone = "no";
		adj  = "";
		desc = "skin";
	}
	public function SkinLayer(skin:Skin) {
		super(skin.creature, ["adj", "desc", "tone"]);
		this.skin = skin;
	}
}
}
