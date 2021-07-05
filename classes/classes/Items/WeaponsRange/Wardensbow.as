/**
 * ...
 * @author Zevos
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.PerkLib;
	import classes.Player;
	
	public class Wardensbow extends WeaponRangeWithPerk
	{
		
		public function Wardensbow() 
		{
			super("WardBow", "WardensBow", "Warden’s bow", "a Warden’s bow", "shot", 20, 2000, "Recurve bows like this serve as a compromise for a shortbow’s accuracy and ease of use, with a longbow’s devastating stopping power.  The sacred wood quietly hums Yggdrasil's song, unheard by all but it’s wielder.", "Bow", PerkLib.Accuracy1,10,0,0,0);
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Range Weapon (Bow)";
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Accuracy (+5% Accuracy)";
			desc += "\nSpecial: Daoist's Focus (+40% Magical Soulskill Power)";
			desc += "\nSpecial: Body Cultivator's Focus (+40% Physical Soulskill Power)";
			desc += "\nSpecial: Wild-Warden (enables Resonance Volley soul skill)";
			return desc;
		}
		
		override public function playerEquip():WeaponRange {
			while (game.player.hasPerk(PerkLib.DaoistsFocus)) game.player.removePerk(PerkLib.DaoistsFocus);
			game.player.createPerk(PerkLib.DaoistsFocus,0.4,0,0,0);
			while (game.player.hasPerk(PerkLib.BodyCultivatorsFocus)) game.player.removePerk(PerkLib.BodyCultivatorsFocus);
			game.player.createPerk(PerkLib.BodyCultivatorsFocus,0.4,0,0,0);
			while (game.player.hasPerk(PerkLib.WildWarden)) game.player.removePerk(PerkLib.WildWarden);
			game.player.createPerk(PerkLib.WildWarden,0,0,0,0);
			return super.playerEquip();
		}
		
		override public function playerRemove():WeaponRange {
			while (game.player.hasPerk(PerkLib.DaoistsFocus)) game.player.removePerk(PerkLib.DaoistsFocus);
			while (game.player.hasPerk(PerkLib.BodyCultivatorsFocus)) game.player.removePerk(PerkLib.BodyCultivatorsFocus);
			while (game.player.hasPerk(PerkLib.WildWarden)) game.player.removePerk(PerkLib.WildWarden);
			return super.playerRemove();
		}
		
	}

}