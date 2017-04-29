/**
 * Created by aimozg on 25.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

public class SkinPart extends BodyPart {
	public var modAdj:String = "";
	public var modDesc:String = "";
	public var modTone:String = "";
	public function get adj():String {return modAdj == "" ? defaultAdj() : modAdj;}
	public function set adj(value:String) {modAdj = (value == "") ? defaultAdj() : value;}
	public function get desc():String {return modDesc == "" ? defaultAdj() : modDesc;}
	public function set desc(value:String) {modDesc = (value == "") ? defaultDesc() : value;}
	public function get tone():String {return modTone == "" ? defaultAdj() : modDesc;}
	public function set tone(value:String) {modDesc = (value == "") ? defaultDesc() : value;}

	public function defaultTone():String {
		return creature.skin.tone;
	}
	public function defaultAdj():String {
		return creature.skin.adj;
	}
	public function defaultDesc():String {
		return creature.skin.desc;
	}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		if (!keepColor) modTone = "";
		modAdj = "";
		modDesc = "";
	}
	public function SkinPart(creature:Creature) {
		super(creature);
		addPublicPrimitives("modAdj","modDesc","modTone");
	}
}
}
