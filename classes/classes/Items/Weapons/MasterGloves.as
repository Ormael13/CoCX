/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class MasterGloves extends WeaponWithPerk
	{
		
		public function MasterGloves() 
		{
			super("MastGlo", "MasterGloves", "Master Gloves", "a Master Gloves", "punch", 1, 400, "These gloves belonged to Chi Chi. They seem to naturally strengthen the soulforce techniques of the user.", "Body Cultivator's Focus", PerkLib.BodyCultivatorsFocus, 0.4, 0, 0, 0);
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Weapon (Gauntlet)";
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Body Cultivator's Focus (+40% Physical Soulskills Power)";
			return desc;
		}
	}
}