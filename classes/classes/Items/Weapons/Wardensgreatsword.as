/**
 * ...
 * @author Zevos
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class Wardensgreatsword extends WeaponWithPerk
	{
		
		public function Wardensgreatsword() 
		{
			super("WGSword", "WardenGSword", "Warden’s greatsword", "a Warden’s greatsword", "slash", 30, 2400, "Wrought from alchemy, not the forge, this sword is made from sacred wood and resonates with Yggdrasil’s song.", "Large", PerkLib.DaoistsFocus, 0.4, 0, 0, 0);
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Weapon (Large)";
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Daoist's Focus (+40% Magical Soulskill Power)";
			desc += "\nSpecial: Body Cultivator's Focus (+40% Physical Soulskill Power)";
			desc += "\nSpecial: Strife-Warden (enables Beat of War soul skill)";
			return desc;
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 100) boost += 10;
			if (game.player.str >= 50) boost += 10;
			return (10 + boost);
		}
		
		override public function playerEquip():Weapon {
			while (game.player.hasPerk(PerkLib.BodyCultivatorsFocus)) game.player.removePerk(PerkLib.BodyCultivatorsFocus);
			game.player.createPerk(PerkLib.BodyCultivatorsFocus,0.4,0,0,0);
			while (game.player.hasPerk(PerkLib.StrifeWarden)) game.player.removePerk(PerkLib.StrifeWarden);
			game.player.createPerk(PerkLib.StrifeWarden,0,0,0,0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Weapon {
			while (game.player.hasPerk(PerkLib.BodyCultivatorsFocus)) game.player.removePerk(PerkLib.BodyCultivatorsFocus);
			while (game.player.hasPerk(PerkLib.StrifeWarden)) game.player.removePerk(PerkLib.StrifeWarden);
			return super.playerRemove();
		}
	}
}