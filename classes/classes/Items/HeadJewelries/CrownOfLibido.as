/**
 * ...
 * @author Ormael
 */
package classes.Items.HeadJewelries
{
	import classes.Items.HeadJewelry;
	import classes.Player;

	public class CrownOfLibido extends HeadJewelry
	{
		
		public function CrownOfLibido()
		{
			super("CrowLib", "CrownOfLibido", "Crown of Libido", "a Crown of Libido", 0, 0, 3200, "A simple crown to boost libido.","Crown");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Crown)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Libido +20%";
			return desc;
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				game.player.statStore.addBuff('lib.mult', 0.20, 'CrownOfLibido', {text: 'Crown Of Libido'});
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			game.player.statStore.removeBuffs('CrownOfLibido');
			super.afterUnequip(doOutput);
		}
		
	}

}
