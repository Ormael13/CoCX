/**
 * ...
 * @author Ormael
 */
package classes.Items.Necklaces 
{
	import classes.Items.Necklace;
	import classes.Player;

	public class NecklaceOfLibido extends Necklace
	{
		
		public function NecklaceOfLibido() 
		{
			super("NeckLib", "NecklaceOfLibido", "Necklace of Libido", "a Necklace of Libido", 0, 0, 4000, "A simple necklace to boost libido.","Necklace");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Necklace)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Libido +25";
			return desc;
		}
		
		override public function playerEquip():Necklace {
			game.player.lib += 25;
			return super.playerEquip();
		}
		
		override public function playerRemove():Necklace {
			game.player.lib -= 25;
			return super.playerRemove();
		}
		
	}

}