/**
 * ...
 * @author Ormael
 */
package classes.Items.HeadJewelries 
{
	import classes.Items.HeadJewelry;
	import classes.Player;

	public class CrownOfSensitivity extends HeadJewelry
	{
		
		public function CrownOfSensitivity() 
		{
			super("CrowSen", "CrownOfSensitivity", "Crown of Sensitivity", "a Crown of Sensitivity", 0, 0, 3200, "A simple crown to boost sensitivity.","Crown");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Crown)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Sensitivity +20";
			return desc;
		}
		
		override public function playerEquip():HeadJewelry {
			game.player.sens += 20;
			return super.playerEquip();
		}
		
		override public function playerRemove():HeadJewelry {
			game.player.sens -= 20;
			return super.playerRemove();
		}
		
	}

}