package classes.Items.Consumables {
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;

public class EyeDye extends Consumable {
	private var _color:String;
	
	public function EyeDye(id:String, params:Object) {
		var color:String = params.color;
		_color           = color.toLowerCase();
		super(id, capitalizeFirstLetter(_color) + " EyDr", "a vial of " + _color + " eye drops", 50, "This vial will allow you to change the color of your irises.");
		refineableInto([[1, AlchemyLib.AS_EYES]], [], [], [_color]);
	}
	
	override public function canUse():Boolean {
		if (player.blockingBodyTransformations()) {
			outputText("Your body is immune to any and all transformations.");
			return false;
		}
		return true;
	}
	
	override public function useItem():Boolean {
		clearOutput();
		if (player.blockingBodyTransformations()) {
			outputText("Your body is immune to any and all transformations.");
			return false;
		}
		player.eyes.colour = _color;
		outputText("You apply the eyedrops to your "+player.eyes.noun+" and wince at the stingy feeling. For a few seconds, your vision becomes blurried.  <b>You now have [eyecolor] irises</b>.");
		SceneLib.inventory.itemGoNext();
		return true;
	}
}
}
