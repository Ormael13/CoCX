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
			game.player.statStore.addBuff('sens',5,'RingOfSensitivity',{text:'Ring Of Sensitivity'});
			return super.playerEquip();
		}
		
		override public function playerRemove():Jewelry {
			game.player.statStore.removeBuffs('RingOfSensitivity');
			return super.playerRemove();
		}
		
	}

}