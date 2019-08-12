/**
 * ...
 * @author Ormael
 */
package classes.Items.Necklaces 
{
	import classes.Items.Necklace;
	import classes.Player;

	public class NecklaceOfSensitivity extends Necklace
	{
		
		public function NecklaceOfSensitivity() 
		{
			super("NeckSen", "NecklaceOfSensitivity", "Necklace of Sensitivity", "a Necklace of Sensitivity", 0, 0, 4000, "A simple necklace to boost sensitivity.","Necklace");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Necklace)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Sensitivity +25";
			return desc;
		}
		
		override public function playerEquip():Necklace {
			game.player.sens += 25;
			return super.playerEquip();
		}
		
		override public function playerRemove():Necklace {
			game.player.sens -= 25;
			return super.playerRemove();
		}
		
	}

}