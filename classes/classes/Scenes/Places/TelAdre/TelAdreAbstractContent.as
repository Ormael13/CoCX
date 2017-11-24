/**
 * Created by aimozg on 05.01.14.
 */
package classes.Scenes.Places.TelAdre
{
import classes.*;
import classes.GlobalFlags.kGAMECLASS;
import classes.Scenes.Places.TelAdre;
import classes.Scenes.SceneLib;

use namespace kGAMECLASS;

	internal class TelAdreAbstractContent extends BaseContent
	{
		protected function get telAdre():TelAdre {
			return SceneLib.telAdre;
		}
		public function TelAdreAbstractContent()
		{
		}
	}
}
