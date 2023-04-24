package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class BloodLetter extends Weapon
	{
		
		public function BloodLetter() 
		{
			super(
				"BLDLetter","Blood Letter","bloodletter katana","a bloodletter katana","slash",132,10560,
				"This dark blade is as beautiful as it is deadly, made in black metal and decorated with crimson ruby gemstones. Lending its power to a corrupt warrior, it will strike with an unholy force, albeit, draining some blood from its wielder on the process.", "Large", "Dueling"
			);
		}
		override public function get attack():Number {
			var boost:int = 0;
			var scal:Number = 10;
			if (game.player.spe >= 100) {
				boost += 10;
				scal -= 3;
			}
			if (game.player.spe >= 50) {
				boost += 10;
				scal -= 2;
			}
			boost += Math.round(game.player.cor / scal);
			return (12 + (3 * boost)); 
		}
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if (doOutput) outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
		
	}

}