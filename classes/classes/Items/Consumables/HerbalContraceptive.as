package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.StatusEffects;
	
	public class HerbalContraceptive extends Consumable 
	{
		public function HerbalContraceptive() 
		{
			super("HrblCnt", "HrblCnt", "a bundle of verdant green leaves", ConsumableLib.DEFAULT_VALUE, "A small bundle of verdant green leaves.");
		}
		
		override public function useItem():Boolean
		{
			clearOutput();

			// Placeholder, sue me
			outputText("You chew on the frankly awfully bitter leaves as quickly as possible before swallowing them down.");

			player.createStatusEffect(StatusEffects.Contraceptives, 1, 48, 0, 0);
			
			return false;
		}
	}
}