/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Places.HeXinDao 
{
import classes.*;
import classes.CoC;
import classes.Scenes.Places.HeXinDao;
import classes.Scenes.SceneLib;

use namespace CoC;

	internal class HeXinDaoAbstractContent extends BaseContent
	{
		protected function get heXinDao():HeXinDao {
			return SceneLib.hexindao;
		}
		public function HeXinDaoAbstractContent()
		{
		}
	}
}