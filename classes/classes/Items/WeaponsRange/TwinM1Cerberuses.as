/**
 * ...
 * @author Ormael
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.PerkLib;
	import classes.Player;
	
	public class TwinM1Cerberuses extends WeaponRange {
		
		public function TwinM1Cerberuses() 
		{
			super("TM1Cerb", "TwinM1Cerberuses", "Twin M1 Cerberuses", "a Twin M1 Cerberuses", "shot", 45, 1860, "A twin rifles prized for their precision and versatility, the Cerberuses shoots multiple bullet in salvo ensuring that if one shot land all the others do with minimal recoil.\n\nGoblin Mech Compatibile", "Dual 2H Firearms");
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if ((game.player.hasPerk(PerkLib.DualWield) && (game.player.hasPerk(PerkLib.GigantGrip) || game.player.hasPerk(PerkLib.AntyDexterity))) || (game.player.hasPerk(PerkLib.GigantGrip) && game.player.hasPerk(PerkLib.AntyDexterity))) {
				return super.canEquip(doOutput, slot);
			}
			if (!game.player.hasPerk(PerkLib.GigantGrip) && !game.player.hasPerk(PerkLib.AntyDexterity)) {
				if (doOutput) outputText("You aren't skilled enough to handle this pair of firearms! (req. Gigant's Grip/Anty-Dexternity)  ");
				return false;
			}
			if (doOutput) outputText("You aren't skilled in handling large firearms with one hand yet to effectively use those rifles. Unless you want to hurt yourself instead of your enemies when trying to use them...  ");
			return false;
		}
	}
}
