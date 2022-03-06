package classes.Items.Consumables 
{
import classes.Appearance;
import classes.BodyParts.Skin;
import classes.CoC;
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
			var description:String = "This bottle of dye will allow you to change the color of your hair.  Of course, if you don't have hair, using this would be a waste.";
			super(id, shortName, longName, value, description);
		}
		
		override public function canUse():Boolean {
			return true;
		}
		
		override public function useItem():Boolean {
			clearOutput();
			EngineCore.menu();
			if (player.blockingBodyTransformations()){
				EngineCore.addButtonDisabled(0, "Immune", "Your body is immune to any and all transformations.");
			}
			else{
				if (game.player.hairLength > 0) {
					outputText("You have " + game.player.hairColor + " hair.");
					if (game.player.hairColor != _color) EngineCore.addButton(0, "Hair", dyeHair);
					else EngineCore.addButtonDisabled(0, "Hair", "Your already have " + game.player.hairColor + " hair!");
				} else {
					outputText("You don't have any hair.");
					EngineCore.addButtonDisabled(0, "Hair", "You are bald!");
				}
				if (game.player.hasCoatOfType(Skin.FUR)) {
					outputText("\n\nYou have [skin coat].");
					if (game.player.coatColor != _color) EngineCore.addButton(1, "Fur", dyeFur);
					else EngineCore.addButtonDisabled(1, "Fur", "Your already have " + _color + " fur!");
				} else {
					outputText("\n\nYou don't have any fur.");
					EngineCore.addButtonDisabled(1, "Fur", "You don't have any fur!");
				}
				if (game.player.hasCoatOfType(Skin.SCALES)) {
					outputText("\n\nYou have [skin coat].");
					if (game.player.coatColor != _color) {
						if (game.player.hasItem(game.useables.REAGENT, 1)) EngineCore.addButton(2, "Scales", dyeScales);
						else EngineCore.addButtonDisabled(2, "Scales", "You do not have enough reagents! (1)");
					}
					else EngineCore.addButtonDisabled(2, "Scale", "Your already have " + _color + " scales!");
				} else {
					outputText("\n\nYou don't have any scales.");
					EngineCore.addButtonDisabled(2, "Scale", "You don't have any scales!");
				}
				if (game.player.hasCoatOfType(Skin.CHITIN)) {
					outputText("\n\nYou have [skin coat].");
					if (game.player.coatColor != _color) {
						if (game.player.hasItem(game.useables.REAGENT, 2)) EngineCore.addButton(3, "Chitin", dyeChitin);
						else EngineCore.addButtonDisabled(3, "Chitin", "You do not have enough reagents! (2)");
					}
					else EngineCore.addButtonDisabled(3, "Chitin", "Your already have " + _color + " chitin!");
				} else {
					outputText("\n\nYou don't have any chitin.");
					EngineCore.addButtonDisabled(3, "Chitin", "You don't have any chitin!");
				}
				if (game.player.hasCoatOfType(Skin.DRAGON_SCALES)) {
					outputText("\n\nYou have [skin coat].");
					if (game.player.coatColor != _color) {
						if (game.player.hasItem(game.useables.REAGENT, 2)) EngineCore.addButton(7, "D.Scales", dyeDragonScales);
						else EngineCore.addButtonDisabled(7, "D.Scales", "You do not have enough reagents! (2)");
					}
					else EngineCore.addButtonDisabled(7, "D.Scales", "Your already have " + _color + " dragon scales!");
				} else {
					outputText("\n\nYou don't have any dragon scales.");
					EngineCore.addButtonDisabled(7, "D.Scales", "You don't have any scales!");
				}
			}
			EngineCore.addButton(14, "Nevermind", dyeCancel);
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
				outputText("You rub the dye into your " + Appearance.hairDescription(player) + ", then use a bucket of cool lakewater to rinse it off a few minutes later.  ");
				game.player.hairColorOnly = _color;
				outputText("You now have " + Appearance.hairDescription(player) + "!");
				if (game.player.lust > 50) {
					outputText("\n\nThe cool water calms your urges somewhat, letting you think more clearly.");
					game.player.dynStats("lus", -15);
				}
			}
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			SceneLib.inventory.itemGoNext();
		}
		private function dyeFur():void {
			clearOutput();
			outputText("You rub the dye into your fur, then use a bucket of cool lakewater to rinse it off a few minutes later.  ");
			game.player.skin.coat.color = _color;
			outputText("You now have [skin coat]!");
			if (game.player.lust > 50) {
				outputText("\n\nThe cool water calms your urges somewhat, letting you think more clearly.");
				game.player.dynStats("lus", -15);
			}
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			SceneLib.inventory.itemGoNext();
		}
		private function dyeScales():void {
			clearOutput();
			outputText("You rub the dye into your scales, then use a bucket of cool lakewater to rinse it off a few minutes later.  ");
			game.player.skin.coat.color = _color;
			player.consumeItem(game.useables.REAGENT, 1);
			outputText("You now have [skin coat]!");
			if (game.player.lust > 50) {
				outputText("\n\nThe cool water calms your urges somewhat, letting you think more clearly.");
				game.player.dynStats("lus", -15);
			}
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			SceneLib.inventory.itemGoNext();
		}
		private function dyeChitin():void {
			clearOutput();
			outputText("You rub the dye into your chitin, then use a bucket of cool lakewater to rinse it off a few minutes later.  ");
			game.player.skin.coat.color = _color;
			player.consumeItem(game.useables.REAGENT, 2);
			outputText("You now have [skin coat]!");
			if (game.player.lust > 50) {
				outputText("\n\nThe cool water calms your urges somewhat, letting you think more clearly.");
				game.player.dynStats("lus", -15);
			}
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			SceneLib.inventory.itemGoNext();
		}
		private function dyeDragonScales():void {
			clearOutput();
			outputText("You rub the dye into your dragon scales, then use a bucket of cool lakewater to rinse it off a few minutes later.  ");
			game.player.skin.coat.color = _color;
			player.consumeItem(game.useables.REAGENT, 2);
			outputText("You now have [skin coat]!");
			if (game.player.lust > 50) {
				outputText("\n\nThe cool water calms your urges somewhat, letting you think more clearly.");
				game.player.dynStats("lus", -15);
			}
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			SceneLib.inventory.itemGoNext();
		}
		
		private function dyeCancel():void {
			clearOutput();
			outputText("You put the dye away.\n\n");
			SceneLib.inventory.returnItemToInventory(this);
		}
	}
}