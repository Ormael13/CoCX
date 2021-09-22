/**
 * ...
 * @author Ormael
 */
package classes.Items 
{
	import classes.Items.MiscJewelries.*;
	import classes.PerkLib;
	import classes.PerkType;
	
	public final class MiscJewelryLib 
	{
		public static const DEFAULT_VALUE:Number = 6;//base cost 200 gems, each effect increase up to 2x cost
		
		public static const NOTHING:Nothing = new Nothing();
		
		public const DMAGETO:DemonicMageTailOrnament = new DemonicMageTailOrnament();
		public const ONI_GOURD:MiscJewelry = new MiscJewelry("OniDGou", "OniDGourd", "Oni enchanted drinking gourd", "an Oni enchanted drinking gourd", 0, 0, 1600, "This gourd grants an infinite supply of non transformative alcohol and greatly increase attack power. Furthermore drunken power duration is doubled when drinking from the gourd.","Gourd");
		
		public function MiscJewelryLib() 
		{
		}
	}
}