/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class TwinSapphireClaymores extends Weapon
	{
		
		public function TwinSapphireClaymores() 
		{
			super("TSClaym", "T.S.Claymore", "twin sapphire claymores", "a twin sapphire claymores", "cleaving sword-slash", 15, 2400, "Those twin two-handed swords are made of azure metal and richly decorated with sapphires and silver engravings. The magic within those azure blades will radiate magical frost when charged with magic.", "Dual Large", "Sword");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 40 || game.player.hasPerk(PerkLib.HiddenJobSwordImmortal)) boost += 8;
			return (7 + boost); 
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if ((game.player.hasPerk(PerkLib.DualWield) && (game.player.hasPerk(PerkLib.GigantGrip) || game.player.hasPerk(PerkLib.AntyDexterity))) || (game.player.hasPerk(PerkLib.GigantGrip) && game.player.hasPerk(PerkLib.AntyDexterity))) {
				return super.canEquip(doOutput);
			}
			if (!game.player.hasPerk(PerkLib.GigantGrip) && !game.player.hasPerk(PerkLib.AntyDexterity)) {
				if (doOutput) outputText("You aren't skilled enough to handle this pair of weapons!  ");
				return false;
			}
			if (doOutput) outputText("You aren't skilled in handling large weapons with one hand yet to effectively use those swords. Unless you want to hurt yourself instead of your enemies when trying to use them...  ");
			return false;
		}
	}
}