package classes.Items.Jewelries 
{
	import classes.ItemType;
	import classes.Items.Jewelry;
	import classes.Player;
	
	public class Nothing extends Jewelry
	{
		
		override public function unequip(player:Player, returnToInventory:Boolean, output:Boolean):void
		{
		}
		
		override protected function unequipReturnItem(player:Player,output:Boolean):ItemType
		{
			return null;
		}
		
		public function Nothing()
		{
			super("nojewel", "nojewel", "nothing", "nothing", 0, 0, 0, "no jewelry", "ring");
		}
		
	}

}