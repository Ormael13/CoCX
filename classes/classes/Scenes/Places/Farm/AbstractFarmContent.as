/**
 * Created by aimozg on 08.01.14.
 */
package classes.Scenes.Places.Farm
{
	import classes.BaseContent;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.NPCs.MarbleScene;
	import classes.Scenes.Places.Farm;

	public class AbstractFarmContent extends BaseContent
	{
		public function AbstractFarmContent()
		{
		}
		protected function get farm():Farm {
			return kGAMECLASS.farm;
		}

	}
}
