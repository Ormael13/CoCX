/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Places.HeXinDao 
{
import classes.*;
import classes.GlobalFlags.kGAMECLASS;
import classes.Scenes.Places.HeXinDao;
import classes.Scenes.SceneLib;

use namespace kGAMECLASS;

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