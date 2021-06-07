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
		//public const ONIGOURD:OniGourd = new OniGourd();
		
		public function MiscJewelryLib() 
		{
		}
	}
}