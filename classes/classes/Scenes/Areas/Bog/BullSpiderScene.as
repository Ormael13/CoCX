/**
 * ...
 * @author ...
 */
package classes.Scenes.Areas.Bog 
{

import classes.*;
import classes.Scenes.SceneLib;

public class BullSpiderScene extends BaseContent
{
	public function BullSpiderScene() 
	{}
	
	public function defeatBullSpider():void {
		clearOutput();
		if (player.hasPerk(PerkLib.HighStakesTamer)) {
			menu();
			addButton(3, "Tame It", SceneLib.campMakeWinions.tamingAttempt);
			addButton(4, "Next", cleanupAfterCombat);
		}
		else cleanupAfterCombat();
	}
}
}