/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

public class SkinLayer extends BodyPart {
	public var adj:String = "";
	public var desc:String = "skin";
	public var tone:String = "no";

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		if (!keepColor) tone = "no";
		adj = "";
		desc = "skin";
	}
	public function SkinLayer(creature:Creature) {
		super(creature);
		addPublicPrimitives("adj","desc","tone");
	}
}
}
