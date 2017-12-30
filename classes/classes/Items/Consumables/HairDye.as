package classes.Items.Consumables 
{
import classes.Appearance;
import classes.BodyParts.Skin;
import classes.EngineCore;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;

public class HairDye extends Consumable
	{
		private var _color:String;

		public function HairDye(id:String, color:String, value:int = 6)
		{
			_color = color.toLowerCase();
			var shortName:String = color + " Dye";
			var longName:String = "a vial of " + _color + " hair dye";
			var description:String = "This bottle of dye will allow you to change the color of your hair.  Of course if you don't have hair, using this would be a waste.";
			super(id, shortName, longName, value, description);
		}
		
		override public function canUse():Boolean {
			return true;
		}
		
		override public function useItem():Boolean {
			clearOutput();
			EngineCore.menu();
			 
			if (game.player.hairLength > 0) {
				outputText("You have " + game.player.hairColor + " hair.");
				if (game.player.hairColor != _color) EngineCore.addButton(0, "Hair", dyeHair);
				else EngineCore.addButtonDisabled(0, "Hair", "Your already have " + game.player.hairColor + " hair!");
			} else {
				outputText("You have no hair.");
				EngineCore.addButtonDisabled(0, "Hair", "You are bald!");
			}
			
			if (game.player.hasCoatOfType(Skin.FUR)) {
				outputText("\n\nYou have [skin coat].");
				if (game.player.coatColor != _color) EngineCore.addButton(1, "Fur", dyeFur);
				else EngineCore.addButtonDisabled(1, "Fur", "Your already have " + _color + " fur!");
			} else {
				outputText("\n\nYou have no fur.");
				EngineCore.addButtonDisabled(1, "Fur", "You have no fur!");
			}
			
			EngineCore.addButton(4, "Nevermind", dyeCancel);
			return true;
		}
		
		private function dyeHair():void {
			clearOutput();
			if (game.player.hairLength == 0) {
				outputText("You rub the dye into your bald head, but it has no effect.");
			}
			else if (game.player.hairColor.indexOf("rubbery") != -1 || game.player.hairColor.indexOf("latex-textured") != -1) {
				outputText("You massage the dye into your " + Appearance.hairDescription(player) + " but the dye cannot penetrate the impermeable material your hair is composed of.");
			}
			else {
				outputText("You rub the dye into your " + Appearance.hairDescription(player) + ", then use a bucket of cool lakewater to rinse clean a few minutes later.  ");
				game.player.hairColor = _color;
				outputText("You now have " + Appearance.hairDescription(player) + ".");
				if (game.player.lust > 50) {
					outputText("\n\nThe cool water calms your urges somewhat, letting you think more clearly.");
					game.player.dynStats("lus", -15);
				}
			}
			SceneLib.inventory.itemGoNext();
		}
		
		private function dyeFur():void {
			clearOutput();
			outputText("You rub the dye into your fur, then use a bucket of cool lakewater to rinse clean a few minutes later.  ");
			game.player.skin.coat.color = _color;
			outputText("You now have [skin coat].");
			if (game.player.lust > 50) {
				outputText("\n\nThe cool water calms your urges somewhat, letting you think more clearly.");
				game.player.dynStats("lus", -15);
			}
			SceneLib.inventory.itemGoNext();
		}
		
		private function dyeCancel():void {
			clearOutput();
			outputText("You put the dye away.\n\n");
			SceneLib.inventory.returnItemToInventory(this);
		}
	}

}