/**
 * ...
 * @author Ormael
 */
package classes.Items
{
import classes.Items.Vehicles.*;

public final class VehiclesLib extends ItemConstants
	{
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const NOTHING:Nothing = new Nothing();
		
		public const GOBMALP:GoblinMechAlpha = new GoblinMechAlpha();
		public const GOBMPRI:GoblinMechPrime = new GoblinMechPrime();
		public const GS_MECH:GiantSlayerMech = new GiantSlayerMech();
		public const HB_MECH:HowlingBansheeMech = new HowlingBansheeMech();
		
		public function VehiclesLib()
		{
		}
	}
}
