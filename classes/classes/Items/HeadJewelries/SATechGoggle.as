/**
 * ...
 * @author Liadri
 */
package classes.Items.HeadJewelries 
{
	import classes.Items.HeadJewelry;
	import classes.PerkLib;
	import classes.Player;

	public class SATechGoggle extends HeadJewelry
	{
		
		public function SATechGoggle() 
		{
			super("SATGog", "SATechGoggle", "S.A Tech Goggle", "a S.A Tech Goggle", 0, 0, 11105, "Better than its previous iteration the Scanner google, the tech google actually also reveal opponent's flaws and weaknesses highlighting their vulnerability in red within the google glass. The fact it also has a complete logbook and access to previous encounter informations also helps catalogise foes weaknesses.","Helm");
		}
		
		override public function canUse():Boolean {
			if (!super.canUse()) {
				return false;
			}
			if (game.player.tallness > 48) { //Taller than 4 ft
				outputText("You try to put your google on but the things clearly weren't designed for someone your size. Frustrated you bag them back.\n\n");
				return false;
			}
			return true;
		}
		
		override public function playerEquip():HeadJewelry {
			while (game.player.findPerk(PerkLib.BlindImmunity) >= 0) game.player.removePerk(PerkLib.BlindImmunity);
			game.player.createPerk(PerkLib.BlindImmunity,0,0,0,0);
			return super.playerEquip();
		}
		
		override public function playerRemove():HeadJewelry {
			while (game.player.findPerk(PerkLib.BlindImmunity) >= 0) game.player.removePerk(PerkLib.BlindImmunity);
			return super.playerRemove();
		}
		
	}

}