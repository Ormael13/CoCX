/**
 * ...
 * @author Liadri
 */
package classes.Items.Armors
{
import classes.Items.Armor;
import classes.Items.ItemTags;
import classes.PerkLib;
import classes.Player;
import classes.StatusEffects;

	public class CowGunslingerOutfit extends Armor {
		
		public function CowGunslingerOutfit()
		{
			super("C.G.Outfit","C.G.Outfit","Cow Gunslinger Outfit","a Cow Gunslinger Outfit",15,30,12000,"A leather coat with a belt for holstering guns all made for a sturdy holstein. This outfit was retrieved from an offworld gunslinger who became a cow.","Medium");
			withBuffs({
				'teasedmg': +15
			});
			withTag(ItemTags.A_AGILE);
			withPerk(PerkLib.CowGunslingerOutfit,0,0,0,0);
			withTag(ItemTags.A_REVEALING);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if (doOutput) outputText("You try and wear the legendary armor but to your disapointment the item simply refuse to stay on your body. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
		override public function get def():Number{
			var mod:int = game.player.cor/10;
			return 15 + mod;
		}
		override public function get mdef():Number{
			var mod:int = game.player.cor/10;
			return 30 + mod;
		}
	}
}
