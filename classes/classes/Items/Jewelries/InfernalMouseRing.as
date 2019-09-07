/**
 * ...
 * @author Ormael
 */
package classes.Items.Jewelries 
{
	import classes.Items.Jewelry;
	import classes.Player;
	import classes.StatusEffects;

	public class InfernalMouseRing extends Jewelry
	{
		public static const MODIFIER_WR:int = 				10;
		
		public function InfernalMouseRing() 
		{
			super("InMoRng", "InfMouRing", "Infernal Mouse ring", "an Infernal Mouse ring", MODIFIER_WR, 75, 3200, "Ring is encrusted with a few small emerald, peridot and sunstone gemstones. Usefull to use Blazing battle spirit or boost it.","Ring");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Ring)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Increases maximum Wrath by 75. Generate 2/1 wrath per turn/hour. Allow to use Blazing battle spirit.";
			return desc;
		}
		
	}

}