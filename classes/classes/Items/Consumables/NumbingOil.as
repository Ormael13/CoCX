package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	
	/**
	 * Oil that reduces sensitivity.
	 */
	public class NumbingOil extends Consumable 
	{
		private static const ITEM_VALUE:int = 100;
		
		public function NumbingOil() 
		{
			super("NumbOil","Numb Oil", "a bottle of numbing oil", ITEM_VALUE, "This bottle feels a bit warm to the touch. From the look of the label on the bottle of oil, you suspect this will make you less sensitive.");			
		}
		
		override public function useItem():Boolean
		{
			outputText("You open the bottle and begin pouring the oil all over your body.\r\r");
			if (player.sens < 20) {
				outputText("Your skin tingles slightly, and afterwords, you feel less sensitive than before.");
			}
			
			if (player.sens >= 20 && player.sens < 40) {
				outputText("Your skin burns a bit, but eventually the burning fades away, leaving your skin less sensitive than before.");
			}
			
			if (player.sens >= 40 && player.sens < 60) {
				outputText("Your skin burns and itches unbearably for several minutes, but eventually returns to normal. You feel less sensitive than before.");
			}
			
			if (player.sens >= 60) {
				outputText("As you finish rubbing the oil into your skin, you fall gasping to your knees. It feels like someone lit you on fire, and that the fire is made of biting ants. You write in agony for a few minutes until the sensations fade. You feel slightly less sensitive than before.");
			}
			
			var senLoss:Number = 5 + Math.floor(player.sens);
			dynStats("sen", -senLoss);
			
			return false;
		}
	}
}
