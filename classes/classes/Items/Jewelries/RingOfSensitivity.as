/**
 * ...
 * @author Ormael
 */
package classes.Items.Jewelries 
{
	import classes.Items.Jewelry;
	import classes.Player;

	public class RingOfSensitivity extends Jewelry
	{
		
		public function RingOfSensitivity() 
		{
			super("RingSen", "RingOfSensitivity", "Ring of Sensitivity", "a Ring of Sensitivity", 0, 0, 800, "A simple ring to boost sensitivity.","Ring");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Ring)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Sensitivity +5";
			return desc;
		}
		
		override public function playerEquip():Jewelry {
			game.player.sens += 5;
			return super.playerEquip();
		}
		
		override public function playerRemove():Jewelry {
			game.player.sens -= 5;
			return super.playerRemove();
		}
		
	}

}