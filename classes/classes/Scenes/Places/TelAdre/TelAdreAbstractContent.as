/**
 * Created by aimozg on 05.01.14.
 */
package classes.Scenes.Places.TelAdre
{
	import classes.BaseContent;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Places.TelAdre;

	use namespace kGAMECLASS;

	public class TelAdreAbstractContent extends BaseContent
	{
		protected function get telAdre():TelAdre {
			return kGAMECLASS.telAdre;
		}
		public function TelAdreAbstractContent()
		{
		}
	}
}
