package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	
	public class CumBread extends Consumable 
	{
		
		public function CumBread() {
			super("C.Bread","C.Bread", "a bowl of cum with bread pieces floating in it", ConsumableLib.DEFAULT_VALUE, "A bowl of cum with pieces of bread floating in it.  Eating this would take the edge off your hunger but damage your dignity.");
		}
		
		override public function canUse():Boolean {
			return true;
		}
		
		override public function useItem():Boolean {
			game.prison.prisonItemBread(true, true);
			return true;
		}
		
	}

}