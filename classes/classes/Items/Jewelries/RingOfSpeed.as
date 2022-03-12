/**
 * ...
 * @author Ormael
 */
package classes.Items.Jewelries 
{
	import classes.Items.Jewelry;
	import classes.Player;

	public class RingOfSpeed extends Jewelry
	{
		
		public function RingOfSpeed() 
		{
			super("RingSpe", "RingOfSpeed", "Ring of Speed", "a Ring of Speed", 0, 0, 800, "A simple ring to boost speed.","Ring");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Ring)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Speed +5%";
			return desc;
		}
		
		override public function playerEquip():Jewelry {
			game.player.statStore.addBuff('spe.mult',0.05,'RingOfSpeed',{text:'Ring Of Speed'});
			return super.playerEquip();
		}
		
		override public function playerRemove():Jewelry {
			game.player.statStore.removeBuffs('RingOfSpeed');
			return super.playerRemove();
		}
		
	}

}