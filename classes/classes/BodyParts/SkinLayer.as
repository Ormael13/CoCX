/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Appearance;

public class SkinLayer extends BodyPart {
	public var pattern:int   = Skin.PATTERN_NONE;
	private var _desc:String = "";
	private var _adj:String  = "";
	private var skin:Skin; // Reference to parent

	public function get material():int {
		return Skin.SkinTypes[type].material;
	}
	public function get color():String {
		return creature.bodyMaterials[material].color;
	}
	public function set color(value:String):void {
		creature.bodyMaterials[material].color = value;
	}
	public function get color1():String {
		return creature.bodyMaterials[material].color1;
	}
	public function set color1(value:String):void {
		creature.bodyMaterials[material].color1 = value;
	}
	public function get color2():String {
		return creature.bodyMaterials[material].color2;
	}
	public function set color2(value:String):void {
		creature.bodyMaterials[material].color2 = value;
	}
	override public function hasMaterial(type:int):Boolean {
		return material == type;
	}
	override public function setProps(p:Object):void {
		super.setProps(p);
		if ("color" in p) color = p.color;
		if ("color1" in p) color1 = p.color1;
		if ("color2" in p) color2 = p.color2;
	}
	
	public function defaultDesc():String {
        //if it throws an error hear, it means Svalkash fucked up again.
        // Add the check like "if (Skin.SkinTypes[type])" then to check for undefined
		return Skin.SkinTypes[type].name || "skin";
	}
	public function defaultAdj():String {
		return Skin.SkinTypes[type].adj || "";
	}
	public function get desc():String {
		return _desc || defaultDesc();
	}
	public function set desc(value:String):void {
		_desc = value;
	}
	public function get descRaw():String {
		return _desc;
	}
	public function set descRaw(value:String):void {
		_desc = value;
	}
	public function get adj():String {
		return _adj;
	}
	public function set adj(value:String):void {
		_adj = value;
	}
	override public function set type(value:int):void {
		if (type != value) {
			super.type = value;
			_desc      = "";
			pattern    = Skin.PATTERN_NONE;
			if (!_adj) _adj = defaultAdj();
		}
	}
	/**
	 * Returns `s` (default "is") if the skin main layer noun is singular (skin,fur,chitin)
	 * and `p` (default "are") if plural (scales)
	 */
	public function isAre(s:String="is",p:String="are"):String {
		return Skin.SkinTypes[type].plural ? p : s;
	}
	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		adj  = "";
		desc = "";
	}
	public function SkinLayer(skin:Skin) {
		super(skin.creature, ["adj", "desc", "pattern"]);
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
	}
}
}
