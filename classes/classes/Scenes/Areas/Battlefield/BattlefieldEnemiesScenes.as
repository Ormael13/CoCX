/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Battlefield 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Battlefield.*;
	
	public class BattlefieldEnemiesScenes extends BaseContent
	{
		
		public function BattlefieldEnemiesScenes() 
		{}
		
		public function encounterVengefulApparitions():void {
			clearOutput();
			outputText("As you wander in the battlefield, from behind some debrises you hear rattling sound. Then another from other pile direction. Then you see a partialy ghastly shapes emerging and soon enough you're surrounded.  \"<i>Liiivinnng....</i>\" one of apparitions finaly speaks and that seems to become a trigger, as rest of them start rushing toward you.");
			startCombat(new VengefulApparitions());
			doNext(playerMenu);
		}
		
		public function defeatVengefulApparitions():void {
			clearOutput();
			outputText("Finaly it's over. With the last of apparitions defeated you can catch your breath. But your victory seems to looks empty as they all starts to disperse nearly the same way they appeared before. Only thing that was left behind is a bottle with some green-tinded substance.");
			inventory.takeItem(consumables.ECTOPLS, cleanupAfterCombat);
		}
		
		public function loseToAVengefulApparitions():void {
			clearOutput();
			outputText("Yoyu fall to your knees out of steam to keep fighting your adversaries. Without delay they all pounce at you starting to ripping pieces of you. Suprisingly it's not your flesh but somethign more etheral but before you can think more on this you losoe consciousness...");
			player.fatigue = player.maxFatigue();
			player.mana = 0;
			player.soulforce = 0;
			cleanupAfterCombat();
		}
	}
}