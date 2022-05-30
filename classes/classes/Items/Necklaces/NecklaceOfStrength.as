/**
 * ...
 * @author Ormael
 */
package classes.Items.Necklaces 
{
	import classes.Items.Necklace;
	import classes.Player;

	public class NecklaceOfStrength extends Necklace
	{
		
		public function NecklaceOfStrength() 
		{
			super("NeckStr", "NecklaceOfStrength", "Necklace of Strength", "a Necklace of Strength", 0, 0, 4000, "A simple necklace to boost strength.","Necklace");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Necklace)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Strength +25%";
			return desc;
		}
		
		override public function playerEquip():Necklace {
			game.player.statStore.addBuff('str.mult',0.25,'NecklaceOfStrength',{text:'Necklace Of Strength'});
			return super.playerEquip();
		}
		
		override public function playerRemove():Necklace {
			game.player.statStore.removeBuffs('NecklaceOfStrength');
			return super.playerRemove();
		}
		
	}

}