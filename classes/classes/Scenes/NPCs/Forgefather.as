/**
	 * ...
	 * @author melyons
	 */

package classes.Scenes.NPCs	{
	
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class Forgefather extends NPCAwareContent	{
		
		public function Forgefather() 
		{}
		
		public function meetForgefather():void	{
			flags[kFLAGS.MET_FORGEFATHER] = 1;
			clearOutput();
			outputText("You wander the area, finding the remains of an abandoned, played-out mine. Remains of long destroyed golems litter the ground around the entrance. As you move closer, you hear the faintest sound of metal striking metal. Once inside, you hear a deep, sad voice, singing a sorrowful tune. \n\n");
			outputText("Following the song, you happen across a most unique individual. A squat, muscular being; hunched over an anvil, shaping the head of a warhammer. Powerful arms rhythmically bring the hammer down, pounding the metal further into a shape that seems to flow from the beings mind.\n");
			outputText("After minutes pass, the being stops and turns slightly to face you.\n\n\"<i>Well " + player.mf("lad","lass") + ", are you going to stand there and gawk all day, or are you going to introduce yourself?</i>\"\n\n");
			addButton(0, "Introduce Yourself", introduceSelf);
			addButton(1, "Not Now", notNow);
		}
		
		public function introduceSelf():void {
			flags[kFLAGS.FORGEFATHER_MOVED_TO_TEMPLE] = 1;
			clearOutput();
			outputText("You introduce yourself to the being. /n/n");
			outputText("Eyeing your quite solid form, he chuckles."
			outputText("\"<i>That's quite the stout form you have. I thought the demons destroyed all of your kind.</i>\"\n\n");
			outputText("Your respond, telling him of the Temple, and the 2 gargoyles now there. You describe you were a champion of your village, and how you willingly gave up your original form to inhabit the stony body.\n\n");
			outputText("Surprised, the being exclaims.\n\n");
			outputText("\n<i>The temple, high in the mountains. It still stands? Those old stones are more stubborn than we thought. And to hear my people's most wonderful designs live on.</i>\"\n\n");
			outputText("The being grabs his gear from behind the anvil, and steps forward.\n\n");
			outputText("\"<i>I'm going to see how the old workshop fares. If you want to learn more about your kind, " + player.mf("lad","lass") + ", come find me there.</i>\"");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function notNow():void {
			clearOutput();
			outputText("Write Write Write");
			outputText("Not Now");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function repeatForgefather():void {
			clearOutput();
			outputText("Write Write Write");
			outputText("Welcome Back");
			addButton(0, "Introduce Yourself", introduceSelf);
			addButton(1, "Not Now", notNow);
		}
	}

}