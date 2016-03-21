package classes.Items.Consumables 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.internals.Utils;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	
	/**
	 * Skin oils, courtesy of Foxxling.
	 * @author Kitteh6660
	 */
	public class SkinOil extends Consumable 
	{
		private var _color:String;
		
		public function SkinOil(id:String, color:String) 
		{
			this._color = color.toLowerCase();
			var shortName:String = color + " Oil";
			var longName:String = "a bottle of " + this._color + " oil"
			var value:int = ConsumableLib.DEFAULT_VALUE;
			var description:String = "A small glass bottle filled with a smooth clear liquid. A label across the front says, \"" + color + " Skin Oil.\""
			super(id, shortName, longName, value, description);
		}
		
		override public function useItem():Boolean {
			if (game.player.skinTone == _color) {
				outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your body. Once you’ve finished you feel rejuvenated.");
				game.player.changeFatigue(-10);
			}
			else {
				if (game.player.skinType != 3) game.player.skinTone = _color;
				switch(game.player.skinType) {
					case 0: //Plain
						outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your body. Even before you’ve covered your arms and [chest] your skin begins to tingle pleasantly all over. After your skin darkens a little, it begins to change until you have " + _color + " skin.");
						break;
					case 1: //Fur
						outputText("" + game.player.clothedOrNaked("Once you’ve disrobed you take the oil and", "You take the oil and") + " begin massaging it into your skin despite yourself being covered with fur. Once you’ve finished... nothing happens. Then your skin begins to tingle and soon you part your fur to reveal " + _color + " skin.");
						break;
					case 2: //Scales
						outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your body. Even before you’ve covered your arms and [chest] your scaly skin begins to tingle pleasantly all over. After your skin darkens a little, it begins to change until you have " + _color + " skin.");
						break;
					case 3: //Goo
						outputText("You take the oil and pour the contents into your skin. The clear liquid dissolves, leaving your gooey skin unchanged. You do feel a little less thirsty though.");
						game.player.slimeFeed();
						break;
					default:
						outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your body. Even before you’ve covered your arms and [chest] your skin begins to tingle pleasantly all over. After your skin darkens a little, it begins to change until you have " + _color + " skin.");
				}
			}
			game.inventory.itemGoNext();
			return true;
		}
		
	}

}