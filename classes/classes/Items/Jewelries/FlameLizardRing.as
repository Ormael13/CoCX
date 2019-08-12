/**
 * ...
 * @author Ormael
 */
package classes.Items.Jewelries 
{
	import classes.Items.Jewelry;
	import classes.Player;
	import classes.StatusEffects;

	public class FlameLizardRing extends Jewelry
	{
		public static const MODIFIER_WR:int = 				10;
		
		public function FlameLizardRing() 
		{
			super("FlLiRng", "FlaLizRing", "Flame Lizard ring", "an Flame Lizard ring", MODIFIER_WR, 75, 3200, "Ring is encrusted with a few small emerald, peridot and carnelian gemstones. Usefull to use Lustzerker or boost it.","Ring");
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Jewelry (Ring)";
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: Increases maximum Wrath by 75. Generate 2/1 wrath per turn/hour. Allow to use Lustzerker.";
			return desc;
		}
		
	}

}