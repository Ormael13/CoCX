/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.BodyParts.SaveableBodyPart;
import classes.Creature;
import classes.internals.Utils;

public class Claws extends SaveableBodyPart {
	public var tone:String                  = "";

	public function Claws(creature:Creature) {
		super(creature,"clawsPart",["tone"]);
	}

	override public function restore(keepColor:Boolean = true):void {
		super.restore(keepColor);
		tone = "";
	}

	override public function descriptionFull():String {
		var toneText:String = tone == "" ? " " : (", " + tone + " ");
		switch (type) {
			case CLAW_TYPE_NORMAL: return "fingernails";
			case CLAW_TYPE_LIZARD: return "short curved" + toneText + "claws";
			case CLAW_TYPE_DRAGON: return "powerful, thick curved" + toneText + "claws";
			// Since mander arms are hardcoded and the others are NYI, we're done here for now
		}
		return "fingernails";
	}

	override protected function loadFromOldSave(savedata:Object):void {
		type = intOr(savedata.clawType,CLAW_TYPE_NORMAL);
		tone = stringOr(savedata.clawTone,"");
	}
	override protected function saveToOldSave(savedata:Object):void {
		savedata.clawType = type;
		savedata.clawTone = tone;
	}
}
}
