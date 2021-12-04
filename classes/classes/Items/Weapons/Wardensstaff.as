/**
 * ...
 * @author Zevos
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class Wardensstaff extends WeaponWithPerk
	{
		
		public function Wardensstaff() 
		{
			super("WDStaff", "WardensStaff", "Warden’s staff", "a Warden’s staff", "smack", 10, 1600, "This staff looks ordinary up until the crystal at its tip, which is attached by tendrils grown from the staff’s body. The sacred wood faintly seethes with arcane power, and the light within the crystal pulses to the tempo of Yggdrasil's song.", "Staff, Wizard's and Daoists's Focus (+60% Spell Power and +40% Magical Soulskill Power), Body Cultivator's Focus (+40% Physical Soulskill Power), Mage-Warden (enables Avatar of the Song soul skill)", PerkLib.WizardsAndDaoistsFocus, 0.6, 0.4, 0, 0, "", "Staff");
		}

		override public function get verb():String { 
			return game.player.hasPerk(PerkLib.StaffChanneling) ? "shot" : "smack";
		}
		
		override public function playerEquip():Weapon {
			while (game.player.hasPerk(PerkLib.BodyCultivatorsFocus)) game.player.removePerk(PerkLib.BodyCultivatorsFocus);
			game.player.createPerk(PerkLib.BodyCultivatorsFocus,0.4,0,0,0);
			while (game.player.hasPerk(PerkLib.MageWarden)) game.player.removePerk(PerkLib.MageWarden);
			game.player.createPerk(PerkLib.MageWarden,0,0,0,0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Weapon {
			while (game.player.hasPerk(PerkLib.BodyCultivatorsFocus)) game.player.removePerk(PerkLib.BodyCultivatorsFocus);
			while (game.player.hasPerk(PerkLib.MageWarden)) game.player.removePerk(PerkLib.MageWarden);
			return super.playerRemove();
		}
	}
}