/**
 * ...
 * @author Ormael
 */
package classes.Items
{
import classes.Items.MiscJewelries.*;

public final class MiscJewelryLib extends ItemConstants
	{
		public static const DEFAULT_VALUE:Number = 6;//base cost 200 gems, each effect increase up to 2x cost
		
		public static const NOTHING:Nothing = new Nothing();
		
		public const ATLATL_:MiscJewelry = new MiscJewelry("Atlatl", "Atlatl", "Atlatl", "an Atlatl", 0, 0, 800, 0, "This spear-throwing lever allows to throw any throwable range weapon with greater accuracy and power.","Atlatl");
		public const DMAGETO:DemonicMageTailOrnament = new DemonicMageTailOrnament();
		public const ONI_GOURD:MiscJewelry = new MiscJewelry("OniDGou", "OniDGourd", "Oni enchanted drinking gourd", "an Oni enchanted drinking gourd", 0, 0, 1600, 0, "This gourd grants an infinite supply of non-transformative alcohol and greatly increases attack power. Furthermore, the drunken power duration is doubled when drinking from the gourd.","Gourd");
		public const SNOWBOA:MiscJewelry = new MiscJewelry("Snowboa", "Snowboard", "Snowboard", "a Snowboard", 0, 0, 400, 0, "Allows for faster movement across the glacial wastes and helps escape from opponents.","Snowboard");
		
		public function MiscJewelryLib()
		{
		}
	}
}
