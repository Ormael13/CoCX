/**
 * ...
 * @author Ormael
 */
package classes.Items.Necklaces 
{
	import classes.Items.Necklace;
	import classes.Player;

	public class NecklaceOfToughness extends Necklace
	{
		
		public function NecklaceOfToughness() 
		{
			super("NeckTou", "NecklaceOfToughness", "Necklace of Toughness", "a Necklace of Toughness", 0, 0, 4000, "A simple necklace to boost toughness.","Necklace");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Necklace)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Toughness +25";
			return desc;
		}
		
		override public function playerEquip():Necklace {
			game.player.tou += 25;
			return super.playerEquip();
		}
		
		override public function playerRemove():Necklace {
			game.player.tou -= 25;
			return super.playerRemove();
		}
		
	}

}