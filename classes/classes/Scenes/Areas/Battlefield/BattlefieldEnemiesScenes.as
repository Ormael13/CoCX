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
			outputText("You fall to your knees out of steam to keep fighting your adversaries. Without delay they all pounce at you starting to ripping pieces of you. Suprisingly it's not your flesh but something more etheral but before you can think more on this you loose consciousness...");
			player.fatigue = player.maxFatigue();
			player.mana = 0;
			player.soulforce = 0;
			cleanupAfterCombat();
		}
		
		public function canEncounterZombies():Boolean {
			return !player.isRaceCached(Races.JIANGSHI);
		}
		
		public function encounterZombies():void {
			clearOutput();
			outputText("As you explore the battlefield you hear what sounds like a pleading moans. Confused, you head toward the sound and find what appears to be a beautiful naked human men and women with pale blue skin. They slowly turns toward you revealing what appears to be a strange paper tag stuck to their foreheads.\n\n");
			if (flags[kFLAGS.CURSE_OF_THE_JIANGSHI] > 3) outputText("Crap it's zombies just like you used to be and they noticed you!");
			else outputText("At first you ask one of them if it needs help but the way it's salivating at you now puts you on your guard.");
			outputText("\n\nWith a dim-witted moan and a look of yearning and hunger that shakes you to your core with fear, they slowly begins to hop toward you with its glowing purple nails pointing in your direction.");
			startCombat(new Zombies());
			doNext(playerMenu);
		}
		
		public function defeatZombies():void {
			clearOutput();
			outputText("The undead falls to the ground, clearly in need of rest after taking so much punishment. You know better than to try and fuck something that might drain you dry and leave with whatever spoil this thing dropped.");
			inventory.takeItem(consumables.L_DRAFT, cleanupAfterCombat);
		}
		
		public function loseToZombies():void {
			clearOutput();
			outputText("Suprisingly it's not your flesh but somethign more etheral but before you can think more on this you losoe consciousness");
			if (player.hasVagina()) {
				if (player.hasCock()) outputText("grabbing and sucking your cock");
				outputText("lapping at your exposed slit");
			}
			else outputText("forcing you into a kiss");
			outputText(".\n\nTry as you might, the thing is unbelievably strong and you just can't manage to push it off, something your unrequited growing pleasure only makes harder. As the undead quite literally forces you toward your impending orgasm, you feel your life energy being sucked out by the ravenous dead, leaving you increasingly drained, which only drives you closer to orgasm as your will and ability to resist dies out");
			if (player.hasCock() || player.hasVagina()) {
				outputText(". You spasm helplessly as you cum into the mouth of the zombie, your energy being forcefully extracted along the way. Too weak to go on you pass out as the zombie mouth and ravenous tongue unplug from your ");
				if (player.gender == 3) outputText("[cock] and [vagina]");
				else if (player.gender == 2) outputText("[vagina]");
				else outputText("[cock]");
			}
			outputText(".\n\nYou wake up several hours later, feeling empty and weak. Whatever the thing took from you, it left you worse for the wear.\n\n");
			player.addCurse("tou", 1, 40);
			player.HP = player.minHP() + 1;
			player.fatigue = player.maxFatigue();
			player.mana = 0;
			player.soulforce = 0;
			cleanupAfterCombat();
		}
	}
}