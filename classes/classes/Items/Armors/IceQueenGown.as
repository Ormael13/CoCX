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
	
	public class IceQueenGown extends ArmorWithPerk
	{

		public function IceQueenGown()
		{
			super("I.Q.Gown","I.Q.Gown","Ice Queen Gown","a Ice Queen Gown",0,30,12000,".","Light",
					PerkLib.WizardsAndDaoistsEndurance,60,0,0,0);
		}

		override public function playerEquip():Armor {
			while (game.player.hasPerk(PerkLib.IceQueenGown)) game.player.removePerk(PerkLib.IceQueenGown);
			game.player.createPerk(PerkLib.IceQueenGown,0,0,0,0);
			while (game.player.hasPerk(PerkLib.SluttySeduction)) game.player.removePerk(PerkLib.SluttySeduction);
			game.player.createPerk(PerkLib.SluttySeduction,10,0,0,0);
			game.player.createPerk(PerkLib.IceNature,0,0,0,0);
			game.player.createPerk(PerkLib.IcyFlesh,0,0,0,0);
			return super.playerEquip();
		}

		override public function playerRemove():Armor {
			while (game.player.hasPerk(PerkLib.IceQueenGown)) game.player.removePerk(PerkLib.IceQueenGown);
			while (game.player.hasPerk(PerkLib.SluttySeduction)) game.player.removePerk(PerkLib.SluttySeduction);
			return super.playerRemove();
		}

	}
}