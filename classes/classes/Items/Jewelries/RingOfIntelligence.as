/**
 * ...
 * @author Ormael
 */
package classes.Items.Jewelries 
{
	import classes.Items.Jewelry;
	import classes.Player;

	public class RingOfIntelligence extends Jewelry
	{
		
		public function RingOfIntelligence() 
		{
			super("RingInt", "RingOfIntelligence", "Ring of Intelligence", "a Ring of Intelligence", 0, 0, 800, "A simple ring to boost intelligence.","Ring");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Ring)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Intelligence +5";
			return desc;
		}
		
		override public function playerEquip():Jewelry {
			game.player.inte += 5;
			return super.playerEquip();
		}
		
		override public function playerRemove():Jewelry {
			game.player.inte -= 5;
			return super.playerRemove();
		}
		
	}

}