/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Monsters 
{
import classes.*;

	public class WeresharkScene extends BaseContent
	{
		
		public function WeresharkScene() 
		{}

public function weresharkEncounter():void {
	clearOutput();
	outputText("As you steadily row your boat through the moonlit ocean, you spot a figure looming close to the surface in the distance. Before you can assess the situation, the figure seemingly disappears deeper into the water.\n\n");
	outputText("With your guard raised, you slow down, preparing for anything that could happen. In moments, something erupts from beneath you, knocking you out of the boat as your vessel capsizes. The ocean's cool embrace envelops you as you plunge into the water. You're met with several rows of teeth from a creature in the water before you.\n\n");
	outputText("You struggle to regain your composure, trying not to give it an advantage over you. Rubbing your eyes as you resurface, you prepare for a fight against the shark-like creature!\n\n");
	startCombat(new Wereshark());
}

public function lostToWereshark():void {
	clearOutput();
	//spriteSelect(SpriteDb.s_DarkElf);
	outputText("Suddenly, she throws a runed scroll at you. As it flies towards you, it forms a small dome forms around you, trapping you inside. When the dome fades away, there is no sign of werefox.\n\n");
	outputText("\"<i></i>\"\n\n");
	outputText("\"<i></i>\"\n\n");
	cleanupAfterCombat();
}
public function wonWithWereshark():void {
	clearOutput();
	//spriteSelect(SpriteDb.s_DarkElf);
	outputText("The werefox falls to the ground, thoroughly defeated. It snarls defiantly at you, but you know this is a facade and that if you wanted to have your way with [monster him], all you need to do is push [monster him] on [monster his] back and get to work. ");
	outputText("Suddenly, she throws a runed scroll at you. As it flies towards you, it forms a small dome forms around you, trapping you inside. When the dome fades away, there is no sign of werefox.\n\n");
	cleanupAfterCombat();
}
	}

}