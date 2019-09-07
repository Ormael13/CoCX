/**
 * ...
 * @author Ormael
 */
package classes.Items.Jewelries 
{
	import classes.Items.Jewelry;
	import classes.Player;

	public class RingOfWisdom extends Jewelry
	{
		
		public function RingOfWisdom() 
		{
			super("RingWis", "RingOfWisdom", "Ring of Wisdom", "a Ring of Wisdom", 0, 0, 800, "A simple ring to boost wisdom.","Ring");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Ring)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Wisdom +5";
			return desc;
		}
		
		override public function playerEquip():Jewelry {
			game.player.wis += 5;
			return super.playerEquip();
		}
		
		override public function playerRemove():Jewelry {
			game.player.wis -= 5;
			return super.playerRemove();
		}
		
	}

}