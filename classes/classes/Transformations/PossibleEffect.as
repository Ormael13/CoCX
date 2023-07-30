package classes.Transformations {
import classes.BaseContent;
import classes.Items.Alchemy.AlchemyLib;

import flash.utils.Dictionary;

/**
 * Abstract superclass for applicable effects that have a condition (for example, transformative effects)
 */
public class PossibleEffect extends BaseContent {
	// TF id -> PossibleEffect[]
	public static var registry:Dictionary = new Dictionary();
	

	/**
	 * Name (for display and debugging)
	 */
	public var name: String;
	
	// See AlchemyLib
	public var substance:int = AlchemyLib.AS_NONE;
	public var essence:int = AlchemyLib.AE_NONE;
	public var residue:int = AlchemyLib.AR_NONE;
	public var alchemyShortName:String = "Nothing";
	public var alchemyLongName:String = "Nothing";

	public function PossibleEffect(name:String) {
		this.name = name;
	}
	public function isPossible():Boolean {
		return true;
	}

	/**
	 * Apply effect the effect to player.
	 * If doOutput is false, do not print any text.
	 * Should not do clearOutput or setup any menus!
	 */
	public function applyEffect(doOutput:Boolean = true):void {
	}
	
	public function registerEffectRaw(id:String):PossibleEffect {
		if (!(id in registry)) registry[id] = [];
		registry[id].push(this);
		return this;
	}
	public function registerEffect(substance:int, essence:int):PossibleEffect {
		this.substance = substance;
		this.essence = essence;
		if (alchemyShortName == "Nothing") {
			this.alchemyShortName = AlchemyLib.Essences[essence].short + AlchemyLib.Substances[substance].short;
			this.alchemyLongName  = AlchemyLib.Essences[essence].name + " " + AlchemyLib.Substances[substance].name;
		}
		registerEffectRaw("TF_"+substance+"_"+essence);
		return this;
	}
	public static function findEffect(id:String):PossibleEffect {
		if (id in registry) return randomChoice(registry[id]);
		return null;
	}
}
}
