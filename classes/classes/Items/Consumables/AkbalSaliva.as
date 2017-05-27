package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	
	public class AkbalSaliva extends Consumable 
	{
		public function AkbalSaliva() 
		{
			super("AkbalSl","AkbalSlv", "a vial of Akbal's saliva", ConsumableLib.DEFAULT_VALUE,"This corked vial of Akbal's saliva is said to contain healing properties. ");
		}
		
		override public function useItem():Boolean
		{
			outputText("You uncork the vial and chug down the saliva.  ");
			game.HPChange((player.maxHP() / 4), true);
			player.refillHunger(5);
			
			return false;
		}
	}
}
