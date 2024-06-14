/**
 * @author Liadri
 */
package classes.Items.Armors
{
	import classes.CoC;
	import classes.Items.Armor;
import classes.PerkLib;
import classes.Player;
	
	public class OniTyrantKimono extends Armor
	{
		
		public function OniTyrantKimono()
		{
			super("OT Kimo", "OniTyrantKimono", "Oni Tyrant kimono", "a oni tyrant kimono", 30, 50, 27000, "This deceptively sturdy kimono belonged to a tyrant amonst oni nobility. In their homeland oni rules over lesser race with an iron fist. Might makes right or so they say.", "Light");
			withTag(A_AGILE);
			withTag(I_LEGENDARY);
			withPerk(PerkLib.OniTyrantKimono, 0, 0, 0, 0);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.tallness >= 80) return super.canEquip(doOutput);
			if (doOutput) outputText("You aren't tall enough to wear this kimono!");
			return false;
		}
		override public function get def():Number{
			var mod:int = game.player.cor/10;
			return 20 + mod;
		}
		override public function get mdef():Number{
			var mod:int = game.player.cor/5;
			return 30 + mod;
		}
	}
}
