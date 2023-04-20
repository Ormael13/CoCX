package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	/**
	 * ...
	 * @author Liadri
	 */
	public class Hellraiser extends Weapon
	{
		
		public function Hellraiser() 
		{
			super("Helrais", "Hellraiser", "Hellraiser", "a Hellraiser", "slash", 90, 14400,
					"An infamous weapon not from this world. Rumors has it that fiends from the void forged it. Many unscruppulous spellcaster used this unholy weapon through the ages.",
					"Large, Whirlwind, Bleed10", "Scythe, StaffPart"
			);
			withBuff('spellpower', +2);
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
			boost += Math.round(game.player.cor / scal);
			return (40 + boost);
		}
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if(doOutput) outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
	}

}
