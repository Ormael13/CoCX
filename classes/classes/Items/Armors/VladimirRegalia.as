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
	
	public class VladimirRegalia extends ArmorWithPerk
	{

		public function VladimirRegalia()
		{
			super("V.Regalia","V.Regalia","Vladimir Regalia","a Vladimir Regalia",0,20,6400,"These burgundy clothes fit for a noble seems to naturaly befit the style of what could be a vampire. Strangely the clothes seems to catch on fire when basked into sunlight yet remain intact when pulled back through the shadows.","Light",
					PerkLib.WizardsAndDaoistsEndurance,60,0,0,0);
		}

		override public function playerEquip():Armor {
			while (game.player.hasPerk(PerkLib.VladimirRegalia)) game.player.removePerk(PerkLib.VladimirRegalia);
			game.player.createPerk(PerkLib.VladimirRegalia,0,0,0,0);
			return super.playerEquip();
		}

		override public function playerRemove():Armor {
			while (game.player.hasPerk(PerkLib.VladimirRegalia)) game.player.removePerk(PerkLib.VladimirRegalia);
			return super.playerRemove();
		}

	}
}