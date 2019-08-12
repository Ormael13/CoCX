/**
 * ...
 * @author Ormael
 */
package classes.Items.Necklaces 
{
	import classes.Items.Necklace;
	import classes.Player;

	public class NecklaceOfSpeed extends Necklace
	{
		
		public function NecklaceOfSpeed() 
		{
			super("NeckSpe", "NecklaceOfSpeed", "Necklace of Speed", "a Necklace of Speed", 0, 0, 4000, "A simple necklace to boost speed.","Necklace");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Necklace)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Speed +25";
			return desc;
		}
		
		override public function playerEquip():Necklace {
			game.player.spe += 25;
			return super.playerEquip();
		}
		
		override public function playerRemove():Necklace {
			game.player.spe -= 25;
			return super.playerRemove();
		}
		
	}

}