package classes.Items.Consumables 
{
import classes.Appearance;
import classes.BodyParts.Skin;
import classes.CoC;
import classes.EngineCore;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;
import classes.ItemType;

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
                //hair
				if (game.player.hairLength > 0) {
					outputText("You have " + game.player.hairColor + " hair.");
					if (game.player.hairColor != _color) EngineCore.addButton(0, "Hair", dyeHair);
					else EngineCore.addButtonDisabled(0, "Hair", "Your already have " + game.player.hairColor + " hair!");
				} else {
					outputText("You don't have any hair.");
					EngineCore.addButtonDisabled(0, "Hair", "You are bald!");
				}
                //coat
                var coatShort:String = player.hasCoat() ? player.skin.shortName : "coat";
                var coatText:String = "You rub the dye into your "+ coatShort + ", then use a bucket of cool lakewater to rinse it off a few minutes later.  ";
                var itemReq:ItemType = game.useables.REAGENT;
                var itemCnt:int = 0;
                var alreadyText:String = "You already have " + _color + " " + coatText;
                switch(game.player.coatType()) {
                    case Skin.FUR:
                        break;
                    case Skin.SCALES:
                        itemCnt = 1;
                        break;
                    case Skin.CHITIN:
                        itemCnt = 2;
                        break;
                    case Skin.DRAGON_SCALES:
                        itemCnt = 2;
                        break;
                }
                if (game.player.hasCoat())
				    outputText("\n\nYou have [skin coat].");
                else
				    outputText("\n\nYou don't have any skin coat (yet?), but maybe some parts of your body are still coated?");
                if (itemReq != ItemType.NOTHING && itemCnt > 0)
                    outputText("\n\nYou'll need " + itemReq.shortName + " x " + itemCnt + " to dye your coat.");
                //button
                if (game.player.hasCoat() && game.player.coatColor == _color)
                    EngineCore.addButtonDisabled(1, "Coat", alreadyText);
                else if (itemReq != ItemType.NOTHING && itemCnt > 0 && !game.player.hasItem(itemReq, itemCnt))
                    EngineCore.addButtonDisabled(1, "Coat", "You don't have enough " + itemReq.shortName + "!");
                else
                    EngineCore.addButton(1, "Coat", dyeCoat, coatText, itemReq, itemCnt);
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

		private function dyeCoat(text:String, itemReq:ItemType, itemCnt:int):void {
			clearOutput();
			outputText(text);
			game.player.skin.coat.color = _color;
            if (itemReq != ItemType.NOTHING && itemCnt > 0)
			    player.consumeItem(itemReq, itemCnt);
            if (game.player.hasCoat())
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