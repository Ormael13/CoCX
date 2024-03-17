package classes.Items.Consumables
{
import classes.EngineCore;
import classes.ItemType;
import classes.Items.*;
import classes.Races;
import classes.Scenes.SceneLib;

/**
	 * Satyr Wine, part of the Black Cock by Foxxling
	 * @author Kitteh6660
	 */
	public class SageMedicine extends Consumable
	{
		public function SageMedicine()
		{
			super("SageMed", "SageMed", "a bottle of Sage medicine", 6, "This drink is made from a bottle of infernal wine, a devil draft, but purified by Alvina. Are you sure it would be a smart idea to drink this?");
			withTag(U_TF);
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You look at the bottle of Sage Medicine given to you by Alvina...\n\n")
			outputText("Maybe you actually could make the push and Achieve the change Alvina could?\n\n");

			outputText("This consumable requires the use of a Legendary artifact. Which artifact will you use?\n\n<u>Available artifacts in inventory:</u>\n");
			var availableArtifacts:Array = player.allPureLegendaryItems();
			var button:int = 0;
			EngineCore.menu();
			for each(var item:ItemType in availableArtifacts){
				outputText(item.longName +"\n");
				EngineCore.addButton(button++, item.shortName, mutations.sageMedicine, game.player, item);
			}
			EngineCore.addButton(14, "Never mind", SageMedicineCancel);
            return true;
		}

		override public function canUse():Boolean {
			if (player.isRace(Races.DEVIL, 1, false))
			{
				if (!player.blockingBodyTransformations()) {
					if (player.hasPureLegendaryItem()) {
						return true;
					}
					outputText("\nIf only you had a holy item with you to act as a catalyst like Marae Pearl did for her.\n")
				}
				outputText("\nYour body has grown too resistant to transformations, this potion will have no effect on you.\n");
			}

			outputText("\nThe transformation would only properly work if you at least had the same kind of body structure Alvina did before her own ascension and in order to canalyse your want into a new shape you will probably need to at least look like a devil would if only to properly convert the power through otherwise who's to say what could happen.\n");
			return false;
		}

		private function SageMedicineCancel():void {
			clearOutput();
			outputText("You put the bottle away.\n\n");
			SceneLib.inventory.returnItemToInventory(this);
		}
		
	}

}
