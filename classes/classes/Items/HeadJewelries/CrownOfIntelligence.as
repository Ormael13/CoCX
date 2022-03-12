/**
 * ...
 * @author Ormael
 */
package classes.Items.HeadJewelries 
{
	import classes.Items.HeadJewelry;
	import classes.Player;

	public class CrownOfIntelligence extends HeadJewelry
	{
		
		public function CrownOfIntelligence() 
		{
			super("CrowInt", "CrownOfIntelligence", "Crown of Intelligence", "a Crown of Intelligence", 0, 0, 3200, "A simple crown to boost intelligence.","Crown");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Crown)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Intelligence +20%";
			return desc;
		}
		
		override public function playerEquip():HeadJewelry {
			game.player.statStore.addBuff('int.mult',0.20,'CrownOfIntelligence',{text:'Crown Of Intelligence'});
			return super.playerEquip();
		}
		
		override public function playerRemove():HeadJewelry {
			game.player.statStore.removeBuffs('CrownOfIntelligence');
			return super.playerRemove();
		}
		
	}

}