/**
 * ...
 * @author Ormael
 */
package classes.Items.Jewelries 
{
	import classes.Items.Jewelry;
	import classes.Player;

	public class RingOfLibido extends Jewelry
	{
		
		public function RingOfLibido() 
		{
			super("RingLib", "RingOfLibido", "Ring of Libido", "a Ring of Libido", 0, 0, 800, "A simple ring to boost libido.","Ring");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Ring)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Libido +5";
			return desc;
		}
		
		override public function playerEquip():Jewelry {
			game.player.lib += 5;
			return super.playerEquip();
		}
		
		override public function playerRemove():Jewelry {
			game.player.lib -= 5;
			return super.playerRemove();
		}
		
	}

}