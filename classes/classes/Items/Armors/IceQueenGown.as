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
			super("I.Q.Gown","I.Q.Gown","Ice Queen Gown","a Ice Queen Gown",0,30,12000,"A gown, previously worn by the late Queen Sophia before her kingdom was buried under the snow by the frost titan. The queen is said to have perished as the restless spirits of her people rose from their icy tomb. Eternally cold and devoid of life's warmth, the spirits seek to steal whatever heat they can get from others if only to soothe their ice-coated flesh. Anyone wearing this dress shall have their hearts, blood and body freeze in exchange for an undying fortitude and control over ice and light.","Light",
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