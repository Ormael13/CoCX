package classes.Items.Armors 
{
	import classes.Items.Armor;
	import classes.Player;
	
	public class LethiciteArmor extends Armor
	{	
		public function LethiciteArmor() 
		{
			super("LthcArm","Leth. Armor","lethicite armor","a suit of glowing purple lethicite armor",28,3000,"This is a suit of lethicite armor. It's all purple and it seems to glow. The pauldrons are spiky to give this armor an imposing appearance. It doesn't seem to cover your crotch and nipples though. It appears to be enchanted to never break and you highly doubt the demons might be able to eat it! \n\nType: Heavy armor \nDefense: Varies (higher with corruption) \nBase value: 3000");
		}
		
		override public function get def():Number { return 10 + int(game.player.cor / 5); }
	}

}