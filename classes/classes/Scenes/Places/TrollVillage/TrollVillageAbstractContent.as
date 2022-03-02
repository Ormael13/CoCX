/**
 * @Author Pyromania
 * Coded in by Jtecx, Jan/Feb 2022
 */
package classes.Scenes.Places.TrollVillage
{
import classes.*;
import classes.CoC;
import classes.Scenes.Places.TrollVillage;
import classes.Scenes.SceneLib;

use namespace CoC;

    internal class TrollVillageAbstractContent extends BaseContent
    {
        protected function get trollVillage():TrollVillage {
            return SceneLib.trollVillage;
        }
        public function TrollVillageAbstractContent()
        {
        }
    }
}
