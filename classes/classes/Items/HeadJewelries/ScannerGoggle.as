/**
 * ...
 * @author Liadri
 */
package classes.Items.HeadJewelries 
{
	import classes.Items.HeadJewelry;
	import classes.PerkLib;
	import classes.Player;

	public class ScannerGoggle extends HeadJewelry
	{
		
		public function ScannerGoggle() 
		{
			super("Scangog", "Scangoggle", "Scanner goggle", "a Scanner goggle", 0, 0, 4030, "This set of goggles naturally include a user interface and scanner, revealing information about your opponents.","Helm");
		}
		
		override public function canUse():Boolean {
			if (!super.canUse()) {
				return false;
			}
			if (game.player.tallness > 48) { //Taller than 4 ft
				outputText("You try to put your goggles on but the things clearly weren't designed for someone your size. Frustrated, you put them back in the bag.\n\n");
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