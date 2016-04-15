/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Places.Bazaar
{
	import classes.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Places.Bazaar;

	public class BazaarAbstractContent extends BaseContent
	{
		protected function get bazaar():Bazaar {
			return kGAMECLASS.bazaar;
		}
		
		public function BazaarAbstractContent() {}
	}
}
