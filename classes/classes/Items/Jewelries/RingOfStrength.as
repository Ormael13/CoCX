/**
 * ...
 * @author Ormael
 */
package classes.Items.Jewelries 
{
	import classes.Items.Jewelry;
	import classes.Player;

	public class RingOfStrength extends Jewelry
	{
		
		public function RingOfStrength() 
		{
			super("RingStr", "RingOfStrength", "Ring of Strength", "a Ring of Strength", 0, 0, 800, "A simple ring to boost strength.","Ring");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Ring)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Strength +5";
			return desc;
		}
		
		override public function playerEquip():Jewelry {
			game.player.str += 5;
			return super.playerEquip();
		}
		
		override public function playerRemove():Jewelry {
			game.player.str -= 5;
			return super.playerRemove();
		}
		
	}

}