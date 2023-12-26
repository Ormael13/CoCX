package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Items.ItemTags;
	/**
	 * ...
	 * @author Oxdeception
	 */
	public class LifehuntScythe extends Weapon
	{
		
		public function LifehuntScythe()
		{
			super("LifScyt", "L.Scythe", "lifehunt scythe", "a lifehunt scythe", "slash", 90, 14400,
					"This enchanted scythe is made of a white metal, and its surface is decorated with ruby gemstones and silver engravings depicting dragons. It seems to drink in the opponents blood use it to heal its user’s wounds.",
					"Large, Whirlwind, Bleed25", "Scythe, StaffPart"
			);
			withBuff('spellpower', +1.0);
			withTag(ItemTags.I_LEGENDARY);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			var scal:Number = 20;
			if (game.player.str >= 100) {
				boost += 20;
				scal -= 5;
			}
			if (game.player.str >= 50) {
				boost += 20;
				scal -= 5;
			}
			boost += Math.round((100 - game.player.cor) / scal);
			return (40 + boost);
		}
	}

}
