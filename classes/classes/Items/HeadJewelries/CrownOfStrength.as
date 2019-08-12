/**
 * ...
 * @author Ormael
 */
package classes.Items.HeadJewelries 
{
	import classes.Items.HeadJewelry;
	import classes.Player;

	public class CrownOfStrength extends HeadJewelry
	{
		
		public function CrownOfStrength() 
		{
			super("CrowStr", "CrownOfStrength", "Crown of Strength", "a Crown of Strength", 0, 0, 3200, "A simple crown to boost strength.","Crown");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Crown)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Strength +20";
			return desc;
		}
		
		override public function playerEquip():HeadJewelry {
			game.player.str += 20;
			return super.playerEquip();
		}
		
		override public function playerRemove():HeadJewelry {
			game.player.str -= 20;
			return super.playerRemove();
		}
		
	}

}