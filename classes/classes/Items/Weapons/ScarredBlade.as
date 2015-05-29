package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	import classes.GlobalFlags.*;
	
	public class ScarredBlade extends Weapon
	{
		
		public function ScarredBlade() 
		{
			super("ScarBld", "ScarBlade", "scarred blade", "a scarred blade", "slash", 10, 1000, "This saber, made from lethicite-imbued metal, eagerly seeks flesh; it resonates with disdain and delivers deep, jagged wounds as it tries to bury itself in the bodies of others. It only cooperates with the corrupt.");
		}
		
		override public function get attack():Number { 
			var temp:int = 10 + int((game.player.cor - 70) / 3)
			if (temp < 10) temp = 10;
			return temp; 
		}
		
		override public function canUse():Boolean {
			if (game.player.cor >= (70 - game.player.corruptionTolerance())) return true;
			game.sheilaScene.rebellingScarredBlade(true);
			return false;
		}
		
	}

}