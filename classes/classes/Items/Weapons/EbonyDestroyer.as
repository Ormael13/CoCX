package classes.Items.Weapons
{
	import classes.Items.Weapon;

	public class EbonyDestroyer extends Weapon
	{
		public function EbonyDestroyer()
		{
			super(
				"EBNYBlade","Ebony Destroyer","ebony destroyer","an ebony destroyer","slash",180,7200,
				"This massive weapon, made of the darkest metal seems to seethe with unseen malice. Its desire to destroy and hurt the pure is so strong that it’s wielder must be wary, lest the blade take control of their body to fulfill its gruesome desires.",
				"Large, LGWrath", "Sword"
			);
		}
		override public function get attack():Number {
			var boost:int = 0;
			var scal:Number = 10;
			if (game.player.str >= 250) {
				boost += 50;
				scal -= 1;
			}
			if (game.player.str >= 200) {
				boost += 40;
				scal -= 1;
			}
			if (game.player.str >= 150) {
				boost += 30;
				scal -= 1;
			}
			if (game.player.str >= 100) {
				boost += 20;
				scal -= 1;
			}
			if (game.player.str >= 50) {
				boost += 10;
				scal -= 1;
			}
			boost += Math.round(game.player.cor / scal);
			return (10 + boost);
		}
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if(doOutput) outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
	}

}
