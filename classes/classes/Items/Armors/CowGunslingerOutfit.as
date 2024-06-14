/**
 * ...
 * @author Liadri
 */
package classes.Items.Armors
{
import classes.Items.Armor;
import classes.PerkLib;
import classes.Player;
import classes.StatusEffects;

	public class CowGunslingerOutfit extends Armor {
		
		public function CowGunslingerOutfit()
		{
			super("C.G.Outfit","C.G.Outfit","Cow Gunslinger Outfit","a Cow Gunslinger Outfit",20,40,12800,"A leather coat with a belt for holstering guns all made for a sturdy holstein. This outfit was retrieved from an offworld gunslinger who became a cow.","Medium");
			withBuffs({
				'teasedmg': +15
			});
			withTag(A_AGILE);
			withPerk(PerkLib.CowGunslingerOutfit,0,0,0,0);
			withTag(A_REVEALING);
			withTag(I_LEGENDARY);
		}
		
		override public function get def():Number{
			var mod:int = 0;
			mod += game.player.cor/5;
			return 20 + mod;
		}
		override public function get mdef():Number{
			var mod:int = 0;
			mod += game.player.cor/10;
			return 10 + mod;
		}
	}
}
