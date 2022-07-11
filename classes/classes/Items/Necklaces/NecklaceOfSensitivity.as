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
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				game.player.statStore.addBuff('sens', 25, 'NecklaceOfSensitivity', {text: 'Necklace Of Sensitivity'});
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			game.player.statStore.removeBuffs('NecklaceOfSensitivity');
			super.afterUnequip(doOutput);
		}
		
	}

}
