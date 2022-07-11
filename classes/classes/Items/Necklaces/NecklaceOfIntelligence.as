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
			desc += "\nSpecial: Intelligence +25%";
			return desc;
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				game.player.statStore.addBuff('int.mult', 0.25, 'NecklaceOfIntelligence', {text: 'Necklace Of Intelligence'});
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			game.player.statStore.removeBuffs('NecklaceOfIntelligence');
			super.afterUnequip(doOutput);
		}
		
	}

}
