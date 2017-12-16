/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class KarmicTouch extends WeaponWithPerk
	{
		
		public function KarmicTouch() 
		{
			super("KarmTou", "KarmicTouch", "Karmic Touch", "a Karmic Touch", "punch", 0, 400, "These immaculate gauntlets look ordinary at first glance, but their touch makes the wicked feel and remember in their very bones every wrong doing they have ever done, paying for them in the form of blows more painful then should be.", "Body Cultivator's Focus", PerkLib.BodyCultivatorsFocus, 0.5, 0, 0, 0);
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