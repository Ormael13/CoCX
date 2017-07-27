/**
 * Coded by aimozg on 27.07.2017.
 */
package coc.view.charview {
public class PartList extends ModelPart{
	private var _parts:/*ModelPart*/Array;

	public function get parts():Array {
		return _parts;
	}
	public function PartList(parts:/*ModelPart*/Array) {
		this._parts = parts;
	}

	override public function display(character:Object):void {
		for each (var part:ModelPart in _parts) {
			part.display(character);
		}
	}
}
}
