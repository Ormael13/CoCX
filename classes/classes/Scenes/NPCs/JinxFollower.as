/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
	
	public class JinxFollower extends NPCAwareContent
	{
		
		public function JinxFollower() 
		{}
		
		public function bazaarEncounters():void {
			clearOutput();
			if (flags[kFLAGS.JINX_LVL_UP] == 0.4) {
				outputText("When you walk into the bazaar alley, a blue-haired goblin followed by a large golem-like figure pushing a cart approaches you again.\n\n");
				outputText("\"<i>Hey there! You're back. Need something?</i>\"\n\n");
			}
			else {
				outputText("When you walk into the bazaar alley, a blue-haired goblin followed by large golem-like figure pushing a cart approaches you.\n\n");
				outputText("\"<i>Hello there. Are you in need of gun? Or maybe ammo to it? Or... belts?!</i>\" She uncovers the top of the cart, showing you her wares. You notice a strange contraption that appears to be a cockpump attached to something resembling a canon.\n\n");
				outputText("She follows your gaze to the item, \"<i>Oh this is the MinoBomber! Original project of greatest inventor, Minx!</i>\"\n\n");
				outputText("Noticing your confusion, she folds her arms, \"<i>You have not heard about her?</i>\" Her ears droop, briefly crestfallen, before she straightens her back with a grin, starting to laugh maniacally. \"<i>Not to worry, for I am she!</i>\" She starts to talk seemingly to herself, as if remembering something from the past.\n\n");
				outputText("\"<i>They said. 'Minx you can't do it. You not ready. Who would want this.'</i>\" She beams brighter as she puffs out her chest, \"<i>But I did it, I showed all those cunts it was possible! So, do you want it or maybe... some other stuff?</i>\"\n\n");
				flags[kFLAGS.JINX_LVL_UP] = 0.4;
			}
			menu();
			addButton(14, "Back", SceneLib.bazaar.enterTheBazaarAndMenu);
		}
	}
}