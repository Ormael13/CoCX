/**
 * ...
 * @author Ormael
 */
package classes.Items.HeadJewelries
{
	import classes.Items.HeadJewelry;
	import classes.Player;

	public class CrownOfToughness extends HeadJewelry
	{
		
		public function CrownOfToughness()
		{
			super("CrowTou", "CrownOfToughness", "Crown of Toughness", "a Crown of Toughness", 0, 0, 3200, "A simple crown to boost toughness.","Crown");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Crown)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Toughness +20%";
			return desc;
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				game.player.statStore.addBuff('tou.mult', 0.20, 'CrownOfToughness', {text: 'Crown Of Toughness'});
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			game.player.statStore.removeBuffs('CrownOfToughness');
			super.afterUnequip(doOutput);
		}
		
	}

}
