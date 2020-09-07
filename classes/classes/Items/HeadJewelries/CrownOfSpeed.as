/**
 * ...
 * @author Ormael
 */
package classes.Items.HeadJewelries 
{
	import classes.Items.HeadJewelry;
	import classes.Player;

	public class CrownOfSpeed extends HeadJewelry
	{
		
		public function CrownOfSpeed() 
		{
			super("CrowSpe", "CrownOfSpeed", "Crown of Speed", "a Crown of Speed", 0, 0, 3200, "A simple crown to boost speed.","Crown");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Crown)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Speed +20";
			return desc;
		}
		
		override public function playerEquip():HeadJewelry {
			game.player.statStore.addBuff('spe',+20,'tag',{text:'CrownOfSpeed'});
			return super.playerEquip();
		}
		
		override public function playerRemove():HeadJewelry {
			game.player.statStore.removeBuffs('CrownOfSpeed');
			return super.playerRemove();
		}
		
	}

}