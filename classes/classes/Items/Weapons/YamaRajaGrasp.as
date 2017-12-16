/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class YamaRajaGrasp extends WeaponWithPerk
	{
		
		public function YamaRajaGrasp() 
		{
			super("YamaRG", "YamaRajaGrasp", "Yama Raja Grasp", "a Yama Raja Grasp", "punch", 0, 400, "These black gloves with spiked bracelets look ordinary at first glance, but this weapon seeks to destroy innocence and purity.  As such it will seek the weak points of its victims when striking.", "Body Cultivator's Focus", PerkLib.BodyCultivatorsFocus, 0.5, 0, 0, 0);
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
			desc += "\nSpecial: Body Cultivator's Focus (+50% Physical Soulskills Power)";
			return desc;
		}
	}
}