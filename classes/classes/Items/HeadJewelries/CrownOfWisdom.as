/**
 * ...
 * @author Ormael
 */
package classes.Items.HeadJewelries 
{
	import classes.Items.HeadJewelry;
	import classes.Player;

	public class CrownOfWisdom extends HeadJewelry
	{
		
		public function CrownOfWisdom() 
		{
			super("CrowWis", "CrownOfWisdom", "Crown of Wisdom", "a Crown of Wisdom", 0, 0, 3200, "A simple crown to boost Wisdom.","Crown");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Crown)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Wisdom +20";
			return desc;
		}
		
		override public function playerEquip():HeadJewelry {
			game.player.wis += 20;
			return super.playerEquip();
		}
		
		override public function playerRemove():HeadJewelry {
			game.player.wis -= 20;
			return super.playerRemove();
		}
		
	}

}