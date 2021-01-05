/**
 * Created by aimozg on 27.04.2017.
 */
package classes.BodyParts {
import classes.Creature;
import classes.internals.EnumValue;

public class Claws extends SaveableBodyPart {
	/**
	 * Entry properties:
	 * - value: numerical id (0, 1)
	 * - id: name of the constant ("NORMAL", "LIZARD")
	 * - name: human-readable default name, ("normal", "lizard")
	 */
	public static var Types:/*EnumValue*/Array = [];
	
	public static const NORMAL:int     =  0;
	EnumValue.add(Types, NORMAL, "NORMAL", {name:"normal"});
	public static const LIZARD:int     =  1;
	EnumValue.add(Types, LIZARD, "LIZARD", {name:"lizard"});
	public static const DRAGON:int     =  2;
	EnumValue.add(Types, DRAGON, "DRAGON", {name:"dragon"});
	public static const SALAMANDER:int =  3;
	EnumValue.add(Types, SALAMANDER, "SALAMANDER", {name:"salamander"});
	public static const CAT:int        =  4; // NYI! Placeholder for now!!
	EnumValue.add(Types, CAT, "CAT", {name:"cat"});
	public static const DOG:int        =  5; // NYI! Placeholder for now!!
	EnumValue.add(Types, DOG, "DOG", {name:"dog"});
	public static const RAPTOR:int     =  6; // NYI! Placeholder for now!!
	EnumValue.add(Types, RAPTOR, "RAPTOR", {name:"raptor"});
	public static const MANTIS:int     =  7; // NYI! Placeholder for Xianxia mod
	EnumValue.add(Types, MANTIS, "MANTIS", {name:"mantis"});
	public static const IMP:int        =  8; // NYI! Placeholder from Revamp
	EnumValue.add(Types, IMP, "IMP", {name:"imp"});
	public static const COCKATRICE:int =  9; // NYI! Placeholder from Revamp
	EnumValue.add(Types, COCKATRICE, "COCKATRICE", {name:"cockatrice"});
	public static const RED_PANDA:int  = 10; // NYI! Placeholder from Revamp
	EnumValue.add(Types, RED_PANDA, "RED_PANDA", {name:"red panda"});
	
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
			case NORMAL: return "fingernails";
			case LIZARD: return "short curved" + toneText + "claws";
			case DRAGON: return "powerful, thick curved" + toneText + "claws";
			// Since mander arms are hardcoded and the others are NYI, we're done here for now
		}
		return "fingernails";
	}

	public function descriptionFinger():String {
		var toneText:String = tone == "" ? " " : (", " + tone + " ");
		switch (type) {
			case NORMAL: return "fingernail";
			case LIZARD: return "short curved" + toneText + "claw";
			case DRAGON: return "powerful, thick curved" + toneText + "claw";
			// Since mander arms are hardcoded and the others are NYI, we're done here for now
		}
		return "fingernail";
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
