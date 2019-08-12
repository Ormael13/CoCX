/**
 * ...
 * @author Ormael
 */
package classes.Items.Necklaces 
{
	import classes.Items.Necklace;
	import classes.Player;

	public class NecklaceOfIntelligence extends Necklace
	{
		
		public function NecklaceOfIntelligence() 
		{
			super("NeckInt", "NecklaceOfIntelligence", "Necklace of Intelligence", "a Necklace of Intelligence", 0, 0, 4000, "A simple necklace to boost intelligence.","Necklace");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Necklace)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Intelligence +25";
			return desc;
		}
		
		override public function playerEquip():Necklace {
			game.player.inte += 25;
			return super.playerEquip();
		}
		
		override public function playerRemove():Necklace {
			game.player.inte -= 25;
			return super.playerRemove();
		}
		
	}

}