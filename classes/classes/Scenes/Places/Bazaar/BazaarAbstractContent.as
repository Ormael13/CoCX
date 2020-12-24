/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Places.Bazaar
{
import classes.*;
import classes.Scenes.Places.Bazaar;
import classes.Scenes.SceneLib;

public class BazaarAbstractContent extends BaseContent
	{
		protected function get bazaar():Bazaar {
			return SceneLib.bazaar;
		}
		public function BazaarAbstractContent()
		{
		}
	}
}