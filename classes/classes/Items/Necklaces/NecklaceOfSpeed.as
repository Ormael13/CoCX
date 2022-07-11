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
			desc += "\nSpecial: Speed +25%";
			return desc;
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				game.player.statStore.addBuff('spe.mult', 0.25, 'NecklaceOfSpeed', {text: 'Necklace Of Speed'});
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			game.player.statStore.removeBuffs('NecklaceOfSpeed');
			super.afterUnequip(doOutput);
		}
		
	}

}
