/**
 * ...
 * @author Ormael
 */
package classes.Items.HeadJewelries
{
	import classes.Items.HeadJewelry;
	import classes.Player;
import classes.Stats.Buff;

public class CrownOfSensitivity extends HeadJewelry
	{
		
		public function CrownOfSensitivity()
		{
			super("CrowSen", "CrownOfSensitivity", "Crown of Sensitivity", "a Crown of Sensitivity", 0, 0, 3200, "A simple crown to boost sensitivity.","Crown");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Crown)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Sensitivity +20";
			return desc;
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				game.player.statStore.addBuff('sens', 20, 'CrownOfSensitivity', {text: 'Crown Of Sensitivity'});
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			game.player.statStore.removeBuffs('CrownOfSensitivity');
			super.afterUnequip(doOutput);
		}
		
	}

}
