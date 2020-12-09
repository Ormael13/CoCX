/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Places.Boat
{
import classes.*;
import classes.Scenes.Places.Boat;
import classes.Scenes.SceneLib;

public class AbstractBoatContent extends BaseContent
	{
		protected function get boat():Boat {
			return SceneLib.boat;
		}
		public function AbstractBoatContent()
		{
		}
	}
}