/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.Aria;
import classes.display.SpriteDb;
import classes.Scenes.SceneLib;

	public class AriaFollower extends NPCAwareContent
	{
		
		public function AriaFollower() 
		{}
		
		public function MelkieEncounter():void {
			spriteSelect(SpriteDb.s_aria);
			clearOutput();
			outputText("As you explore the rift you hear the echoes of a singing voice in the distance. Captivated, you head toward the source of the sound and come upon what at first looks like a woman sitting on the icy ground, you can see the sea in the distance. A closer examination reveals that she has long, drooping, spotted ears, a powerful seal like tail where her legs would normally be. ");
			outputText("The things you mistook for a pair of gloves from a distance are actually her two paws with finned forearms, ending with a set of sharp claws. The girl stops singing and turns over to look at you.\n\n");
			outputText("\"<i>Well, would you look at that, another scavenger and food thief…well no! You won’t have any of my fish, hunter!</i>\"\n\n");
			outputText("Under her glacial blonde hair is two eyes that stare at you with barely contained aggression. She bares her now obvious fang at you and smashes her weapon in the ground revealing that you both are standing on a layer of ice as she dives underwater, using the newly opened hole and swims toward you. Well, seems you are the victim of a massive misunderstanding.\n\n");
			outputText("<b>You are fighting a Melkie!</b>\n\n");
			
			SceneLib.glacialRift.GlacialRiftConditions();
			startCombat(new Aria());
		}
		
		public function MelkieEncounterLost():void {
			spriteSelect(SpriteDb.s_aria);
			clearOutput();
			outputText("You are defeated. Luckily for you, the seal girl seems to have no interest in sex at the moment and decide to knocks you out, leaving you to freeze on the rift’s glacial landscape. When you wake up, you find out she also got away with some of your gems.\n\n");
			cleanupAfterCombat();
		}
		public function MelkieEncounterWon():void {
			spriteSelect(SpriteDb.s_aria);
			clearOutput();
			outputText("<b>You Won! Congrats but for now only fight itself is tested so nothing to see here yet.</b>\n\n");
			cleanupAfterCombat();
		}
	}
}