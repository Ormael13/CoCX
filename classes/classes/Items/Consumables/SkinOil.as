package classes.Items.Consumables
{
import classes.BodyParts.Skin;
import classes.EngineCore;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;
import classes.Items.ConsumableLib;
import classes.Scenes.SceneLib;

/**
	 * Skin oils, courtesy of Foxxling.
	 * @author Kitteh6660
	 */
	public class SkinOil extends Consumable
	{
		private var _color:String;
		
		public function SkinOil(id:String, params:Object)
		{
			var color:String = params.color;
			this._color = color.toLowerCase();
			var shortName:String = capitalizeFirstLetter(color) + " Oil";
			var longName:String = "a bottle of " + this._color + " oil";
			var value:int = ConsumableLib.DEFAULT_VALUE;
			var description:String = "A small glass bottle filled with a smooth clear liquid. A label across the front says, \"" + color + " Skin Oil.\"";
			super(id, shortName, longName, value, description);
			refineableInto([[AlchemyLib.AS_SKIN]], [], [], [_color]);
		}
		
		override public function useItem():Boolean {
			if (player.skinColor == _color || player.blockingBodyTransformations()) {
				outputText("You " + player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your body. Once you’ve finished you feel rejuvenated.");
				EngineCore.fatigue(-10);
			}
			else {
				if (player.skin.base.type != Skin.GOO) player.skinColor = _color;
				if (player.hasPlainSkinOnly()) {
					outputText("You " + player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your body. Even before you’ve covered your arms and [chest], your skin begins to tingle pleasantly all over. After your skin darkens a little, it begins to change until you have " + _color + " skin.");
				} else if (player.isFurCovered()) {
					outputText("" + player.clothedOrNaked("Once you’ve disrobed you take the oil and", "You take the oil and") + " begin massaging it into your skin despite yourself being covered with fur. Once you’ve finished... nothing happens. Then your skin begins to tingle and soon you part your fur to reveal " + _color + " skin.");
				} else if (player.isScaleCovered()) {
					outputText("You " + player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your body. Even before you’ve covered your arms and [chest], your scaly skin begins to tingle pleasantly all over. After your skin darkens a little, it begins to change until you have " + _color + " skin.");
				} else if (player.skin.base.type == Skin.GOO) {
					outputText("You take the oil and pour the contents into your skin. The clear liquid dissolves, leaving your gooey skin unchanged. You do feel a little less thirsty though.");
				} else {
					outputText("You " + player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your body. Even before you’ve covered your arms and [chest], your skin begins to tingle pleasantly all over. After your skin darkens a little, it begins to change until you have " + _color + " skin.");
				}
			}
			SceneLib.inventory.itemGoNext();
			return true;
		}
		
	}

}
