package classes.Items.Consumables 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.internals.Utils;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;

	public class HairDye extends Consumable 
	{
		private var _color:String;
		
		public function HairDye(id:String, color:String, value:int = ConsumableLib.DEFAULT_VALUE) 
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
			if (game.player.skinType == 1) { //Furry? You get to dye your hair or fur!
				clearOutput();
				game.menu();
				game.addButton(0, "Hair", dyeHair);
				game.addButton(1, "Fur", dyeFur);
				game.addButton(4, "Nevermind", dyeCancel);
			}
			else { //No fur? Dye hair as usual.
				dyeHair();
			}
			return true;
		}
		
		private function dyeHair():void {
			clearOutput();
			if (game.player.hairLength == 0) {
				outputText("You rub the dye into your bald head, but it has no effect.");
			}
			else if (game.player.hairColor.indexOf("rubbery") != -1 || game.player.hairColor.indexOf("latex-textured") != -1) {
				outputText("You massage the dye into your " + game.hairDescript() + " but the dye cannot penetrate the impermeable material your hair is composed of.");
			}
			else {
				outputText("You rub the dye into your " + game.hairDescript() + ", then use a bucket of cool lakewater to rinse clean a few minutes later.  ");
				game.player.hairColor = _color;
				outputText("You now have " + game.hairDescript() + ".");
				if (game.player.lust > 50) {
					outputText("\n\nThe cool water calms your urges somewhat, letting you think more clearly.");
					game.dynStats("lus", -15);
				}
			}
			game.inventory.itemGoNext();
		}
		
		private function dyeFur():void {
			clearOutput();
			outputText("You rub the dye into your fur, then use a bucket of cool lakewater to rinse clean a few minutes later.  ");
			game.player.furColor = _color;
			outputText("You now have " + game.player.furColor + " fur.");
			if (game.player.lust > 50) {
				outputText("\n\nThe cool water calms your urges somewhat, letting you think more clearly.");
				game.dynStats("lus", -15);
			}
			game.inventory.itemGoNext();
		}
		
		private function dyeCancel():void {
			clearOutput();
			outputText("You put the dye away.\n\n");
			game.inventory.returnItemToInventory(this);
		}
	}

}