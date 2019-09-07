/**
 * Created by aimozg on 22.05.2017.
 */
package classes.Scenes.API {
import classes.BaseContent;

public class BasicEncounter extends BaseContent implements Encounter {
	public function modChance(chance:Number):Number {
		// COULD be overriden
		return 1;
	}
	public function condition():Boolean {
		// COULD be overriden
		return true;
	}
	public function execEncounter():void {
		// SHOULD be overriden
		trace("[WARNING] BasicEncounter(" +name+").execEncounter() not implemented"); // or super.execEncounter() called
	}

	public function encounterChance():Number {
		var c:Number = this.basicChance;
		return condition() ? modChance(c) : 0;
	}

	public var basicChance:Number;
	public var name:String;
	public function BasicEncounter(name:String, basicChance:Number=1) {
		this.name = name;
		this.basicChance = basicChance;
	}
	public function encounterName():String {
		return name;
	}
}
}
