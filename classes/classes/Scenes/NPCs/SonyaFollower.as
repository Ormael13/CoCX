/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.GlobalFlags.kFLAGS;

public class SonyaFollower extends NPCAwareContent
	{
		
		public function SonyaFollower() 
		{}

public function firstEnc():void
{
	clearOutput();
	outputText("You casually take a stroll in the mountains, passing through a tunnel. Weirdly, in the middle of the tunnel you find several unconscious minotaurs. You examine them and discover they all fainted from…sexual exhaustion? Out of nowhere, something scrapes your skin, missing you by a mere inch. You look down to see what looks like a bony spike burrowed in the ground a few feet ahead of you. ");
	outputText("A menacing growl echoes in the tunnel as another spike flies right by you, barely missing your arm this time. Figuring you've been ambushed, you run to the other end to confront your invisible assailant in broad daylight. As soon as you're out, your opponent surges after you. At first glance it looks like a catgirl, however, the shape of her paws and ears hint at being more like a lion’s, ");
	outputText("especially with the large mane around her neck. She could pass for having a human face if not for her malicious cat-like red pupils and sharp canines. The comparison to a cat ends there, due to the pair of large leathery wings that rest on her back.  Where you would have expected a cat tail a scorpion-like chitin covered tail grows. It ends in a bulbous tip crowned with sharp bony spikes, ");
	outputText("akin to those that nearly hit you earlier. She smirks sadistically, dropping down on all fours to point her tail at you.");
	outputText("\n\nYou're under attack by a Manticore!");
	camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_MANTICORES);
	startCombat(new Sonya());
	doNext(playerMenu);
}


	}

}