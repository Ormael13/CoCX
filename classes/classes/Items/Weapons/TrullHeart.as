/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Items.ItemTags;
	import classes.PerkLib;
	import classes.Player;
	
	public class TrullHeart extends Weapon {
		
		public function TrullHeart() {
			super("T.Heart", "T.Heart", "Trull Heart", "a Trull Heart", "slash", 180, 14400, "This pair of oversized swords is said to have once belonged to a legendary giant. The owner wounds seems to recover when those pure blades are used.", "Dual Large, LGWrath", "Sword");
			withTag(ItemTags.I_LEGENDARY);
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.HiddenJobSwordImmortal)) boost += 170;
			else {
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
				boost += Math.round((100 - game.player.cor) / scal);
			}
			return (10 + boost);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (((game.player.hasPerk(PerkLib.DualWield) && (game.player.hasPerk(PerkLib.GigantGrip) || game.player.hasPerk(PerkLib.AntyDexterity))) || (game.player.hasPerk(PerkLib.GigantGrip) && game.player.hasPerk(PerkLib.AntyDexterity)))) return super.canEquip(doOutput);
			if (doOutput) {
				if (game.player.hasPerk(PerkLib.GigantGrip) || game.player.hasPerk(PerkLib.AntyDexterity)) outputText("You aren't skilled in handling large weapons with one hand yet to effectively use those swords. Unless you want to hurt yourself instead enemies when trying to use them...  ");
				else outputText("You aren't skilled enough to handle this pair of weapons!  ");
			}
			return false;
		}
	}
}
