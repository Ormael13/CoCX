/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas.Lake
{
import classes.*;
import classes.Scenes.Areas.Lake;
import classes.Scenes.SceneLib;

public class AbstractLakeContent extends BaseContent
	{
		protected function get lake():Lake{
			return SceneLib.lake;
		}
		public function AbstractLakeContent()
		{
		}
	}
}