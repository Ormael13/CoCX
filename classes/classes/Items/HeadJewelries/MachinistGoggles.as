/**
 * ...
 * @author Liadri
 */
package classes.Items.HeadJewelries 
{
	import classes.Items.HeadJewelry;
	import classes.PerkLib;
	import classes.Player;

	public class MachinistGoggles extends HeadJewelry
	{
		
		public function MachinistGoggles() 
		{
			super("MachGog", "MachinistGoggles", "Machinist Goggles", "a Machinist Goggles", 0, 0, 400, "A pair of ordinary machinist goggles. One of the basic tools of anyone working with engines. Helps prevent blindness.","Helm");
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