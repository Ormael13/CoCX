/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas.Lake
{
	import classes.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.Lake;

	public class AbstractLakeContent extends BaseContent
	{
		protected function get lake():Lake{
			return kGAMECLASS.lake;
		}
		public function AbstractLakeContent()
		{
		}
	}
}
