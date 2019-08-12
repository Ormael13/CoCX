/**
 * ...
 * @author Ormael
 */
package classes.Items.Jewelries 
{
	import classes.Items.Jewelry;
	import classes.Player;

	public class RingOfToughness extends Jewelry
	{
		
		public function RingOfToughness() 
		{
			super("RingTou", "RingOfToughness", "Ring of Toughness", "a Ring of Toughness", 0, 0, 800, "A simple ring to boost toughness.","Ring");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Ring)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Toughness +5";
			return desc;
		}
		
		override public function playerEquip():Jewelry {
			game.player.tou += 5;
			return super.playerEquip();
		}
		
		override public function playerRemove():Jewelry {
			game.player.tou -= 5;
			return super.playerRemove();
		}
		
	}

}