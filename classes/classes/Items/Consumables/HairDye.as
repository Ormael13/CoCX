package classes.Items.Consumables
{
import classes.BodyParts.BodyMaterial;
import classes.BodyParts.Skin;
import classes.CoC;
import classes.EngineCore;
import classes.ItemType;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;
import classes.Scenes.SceneLib;

public class HairDye extends Consumable
	{
		private var _color:String;
		
		public static const RARITY_TO_VALUE:Object = {
			1: 6,
			2: 10,
			3: 50,
			4: 100
		};
		
		public function HairDye(id:String, params:Object)
		{
			var color:String = params.color;
			var rarity:int = params.rarity;
			_color = color.toLowerCase();
			var shortName:String = capitalizeFirstLetter(color) + " Dye";
			var longName:String = "a vial of " + _color + " hair dye";
			var description:String = "This bottle of dye will allow you to change the color of your hair, fur, scales, chitin, or feathers.";
			super(id, shortName, longName, RARITY_TO_VALUE[rarity] || 6, description);
			refineableInto([[1, AlchemyLib.AS_HAIR]], [], [], [_color]);
		}
		
		override public function canUse():Boolean {
			return true;
		}
		
		override public function useItem():Boolean {
			clearOutput();
			EngineCore.menu();
			if (player.blockingBodyTransformations()){
				EngineCore.addButtonDisabled(0, "Immune", "Your body is immune to any and all transformations.");
			} else {
				outputText("What do you want to dye "+_color+"?\n");
				var i:int = 0;
				for each (var type:int in [
						BodyMaterial.HAIR,
						BodyMaterial.FUR,
						BodyMaterial.SCALES,
						BodyMaterial.CHITIN,
						BodyMaterial.FEATHERS,
				]) {
					var name:String = BodyMaterial.Types[type].name;
					var itemReq:ItemType = game.useables.REAGENT;
					var itemCnt:int = 0;
					if (type == BodyMaterial.SCALES) {
						itemCnt = 1;
						if (player.coatType() == Skin.DRAGON_SCALES) itemCnt = 2;
					} else if (type == BodyMaterial.CHITIN) {
						itemCnt = 2;
					}
					
					var present:Boolean = player.hasBodyMaterial(type);
					if (present) {
						outputText("\nYou have " + player.bodyMaterialColor(type) + " " + name + ". ");
					} else {
						outputText("\nYou have no " + name + ". ");
					}
					var hint:String = "";
					if (!itemReq.isNothing && itemCnt > 0) {
						hint = "You'll need "+itemReq.shortName+" x "+itemCnt+" to dye your "+name;
						if (present) {
							outputText("You'll need " + itemReq.shortName + " x " + itemCnt + " to dye your " + name + ".");
						}
					}
					
					EngineCore.button(i++)
							.show(
									capitalizeFirstLetter(name),
									curry(dye, type, itemReq, itemCnt),
									hint)
							.disableIf(!itemReq.isNothing && itemCnt > 0 && !player.hasItem(itemReq, itemCnt),
									"You don't have enough "+itemReq.shortName+" ("+itemCnt+" needed)")
							.disableIf(player.bodyMaterialColor(type) == _color,
									"You already have "+_color+" "+name+"!")
							.disableIf(!present,
									"You don't have any "+name+" on your body!");
				}
			}
			EngineCore.addButton(14, "Never mind", dyeCancel);
			return true;
		}
		private function dye(material:int, itemReq:ItemType, itemCnt:int, slot:String=""):void {
			clearOutput();

			var bm:BodyMaterial = player.bodyMaterials[material];
			if (slot == "") {
				clearOutput();
				if (bm.binary) {
					outputText("Do you want to dye primary color (" + bm.color1 + "), secondary (" + bm.color2 + "), or both?");
					EngineCore.menu();
					EngineCore.addButton(0, "Primary", curry(dye, material, itemReq, itemCnt, "color1"));
					EngineCore.addButton(1, "Secondary", curry(dye, material, itemReq, itemCnt, "color2"));
					EngineCore.addButton(2, "Both", curry(dye, material, itemReq, itemCnt, "color"));
					EngineCore.addButton(14, "Never mind", dyeCancel);
					return;
				} else {
					outputText("Do you want to dye solid " + _color +" or add it as a secondary color?");
					EngineCore.menu();
					EngineCore.addButton(0, "Solid", curry(dye, material, itemReq, itemCnt, "color"));
					EngineCore.addButton(1, "Secondary", curry(dye, material, itemReq, itemCnt, "color2"));
					EngineCore.addButton(14, "Never mind", dyeCancel);
					return;
				}
			}
			
			if (material == BodyMaterial.HAIR) {
				// TODO should check hairAdj
				if (player.hairColor.indexOf("rubbery") != -1 || player.hairColor.indexOf("latex-textured") != -1) {
					outputText("You massage the dye into your [hair] but the dye cannot penetrate the impermeable material your hair is composed of.");
					return;
				}
				outputText("You rub the dye into your [hair], then use a bucket of cool lakewater to rinse it off a few minutes later.  ");
			} else {
				outputText("You rub the dye into your " + BodyMaterial.Types[material].name + ", then use a bucket of cool lakewater to rinse it off a few minutes later.  ");
			}
			bm[slot] = _color;
			outputText("You now have " +bm.color+" "+bm.name+"!");
			if (game.player.lust > 50) {
				outputText("\n\nThe cool water calms your urges somewhat, letting you think more clearly.");
				game.player.dynStats("lus", -15, "scale", false);
			}
			if (!itemReq.isNothing && itemCnt > 0) player.consumeItem(itemReq, itemCnt);
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
