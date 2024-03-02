package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.ItemTags;
	import classes.PerkLib;
	import classes.Player;

	public class BloodLetter extends Weapon
	{
		
		public function BloodLetter() 
		{
			super(
				"BLDLetter","Blood Letter","bloodletter katana","a bloodletter katana","slash",132,10560,
				"This dark blade is as beautiful as it is deadly, made in black metal and decorated with crimson ruby gemstones. Lending its power to a corrupt warrior, it will strike with an unholy force, albeit, draining some blood from its wielder on the process.", "Large", "Dueling"
			);
			withTag(ItemTags.I_LEGENDARY);
		}
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.HiddenJobSwordImmortal)) boost += 40;
			else {
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
			}
			return (12 + (3 * boost)); 
		}
	}

}