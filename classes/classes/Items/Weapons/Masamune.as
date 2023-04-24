package classes.Items.Weapons 
{
import classes.Items.Weapon;

public class Masamune extends Weapon
	{
		
		public function Masamune() 
		{
			super(
				"masamune","Masamune","masamune katana","a masamune katana","slash",112,8960,
				"This blessed katana is made in shining steel and heavily decorated with silver and blue sapphires. When used by a pure-hearted knight, the divine will within guides each strike, making it much deadlier.", "Large", "Dueling"
			);
		}
		override public function get attack():Number {
			var boost:int = 0;
			var scal:Number = 10;
			if (game.player.spe >= 100) {
				boost += 15;
				scal -= 3;
			}
			if (game.player.spe >= 50) {
				boost += 15;
				scal -= 2;
			}
			boost += Math.round((100 - game.player.cor) / scal);
			return (12 + (2 * boost)); 
		}
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if (doOutput) outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
	
	}

}