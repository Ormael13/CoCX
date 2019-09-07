/**
 * ...
 * @author Ormael
 */
package classes.Items.Necklaces 
{
	import classes.Items.Necklace;
	import classes.Player;

	public class NecklaceOfWisdom extends Necklace
	{
		
		public function NecklaceOfWisdom() 
		{
			super("NeckWis", "NecklaceOfWisdom", "Necklace of Wisdom", "a Necklace of Wisdom", 0, 0, 4000, "A simple necklace to boost wisdom.","Necklace");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Necklace)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Wisdom +25";
			return desc;
		}
		
		override public function playerEquip():Necklace {
			game.player.wis += 25;
			return super.playerEquip();
		}
		
		override public function playerRemove():Necklace {
			game.player.wis -= 25;
			return super.playerRemove();
		}
		
	}

}