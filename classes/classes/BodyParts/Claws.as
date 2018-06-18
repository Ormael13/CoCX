/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;

public class Claws extends SaveableBodyPart {
	public var tone:String                  = "";
	
	public static const NORMAL:int     =  0;
	public static const LIZARD:int     =  1;
	public static const DRAGON:int     =  2;
	public static const SALAMANDER:int =  3;
	public static const CAT:int        =  4; // NYI! Placeholder for now!!
	public static const DOG:int        =  5; // NYI! Placeholder for now!!
	public static const RAPTOR:int     =  6; // NYI! Placeholder for now!!
	public static const MANTIS:int     =  7; // NYI! Placeholder for Xianxia mod
	public static const IMP:int        =  8; // NYI! Placeholder from Revamp
	public static const COCKATRICE:int =  9; // NYI! Placeholder from Revamp
	public static const RED_PANDA:int  = 10; // NYI! Placeholder from Revamp
	// Don't forget to add new types in DebugMenu.as list CLAW_TYPE_CONSTANTS
	
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
			case NORMAL: return "fingernails";
			case LIZARD: return "short curved" + toneText + "claws";
			case DRAGON: return "powerful, thick curved" + toneText + "claws";
			// Since mander arms are hardcoded and the others are NYI, we're done here for now
		}
		return "fingernails";
	}

	override protected function loadFromOldSave(savedata:Object):void {
		type = intOr(savedata.clawType,NORMAL);
		tone = stringOr(savedata.clawTone,"");
	}
	override protected function saveToOldSave(savedata:Object):void {
		savedata.clawType = type;
		savedata.clawTone = tone;
	}
}
}
