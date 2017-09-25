/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Places.HeXinDao 
{
	import classes.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Places.HeXinDao;

	use namespace kGAMECLASS;

	internal class HeXinDaoAbstractContent extends BaseContent
	{
		protected function get heXinDao():HeXinDao {
			return kGAMECLASS.hexindao;
		}
		public function HeXinDaoAbstractContent()
		{
		}
	}
}