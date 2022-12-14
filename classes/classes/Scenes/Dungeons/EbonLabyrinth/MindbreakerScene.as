package classes.Scenes.Dungeons.EbonLabyrinth 
{
import classes.BaseContent;
import classes.Scenes.Places.Mindbreaker;

public class MindbreakerScene extends BaseContent {
	
	public function MindbreakerScene() {}
	
	public function encounter():void {
		outputText("You turn around a corner of the labyrinth and come face to face with some kind of strange tentacle woman. She looks surprised at first then smirks as many eyes on her forehead and tentacle hairs open.\n\n");
		outputText("\"<i>Did you come here for a brain wash?.. No worries, I will handle it. Soon your mind will be as beautiful as mine.</i>\"\n\n");
		outputText("You ready yourself for a fight, this girl is clearly an enemy!");
	}
	
	public function defeatedBy():void {
        clearOutput();
        if (player.hasCock()) {
			outputText("You black out as she begins to fuck with your brain. When you wake up you feel somewhat weird. It would seem the creature abused of your penis for several hours while you were unconscious. Furthermore your balls grew larger and more ripe with cum.\n\n");
			if (player.cumQ() < 30000) player.cumMultiplier += 5;
		}
		else {
			outputText("You blackout as she begins to fuck with your brain. When you wake up you feel somewhat weird but also the vivid memory of a cave somewhere in the mountains haunts your mind. Perhaps you should seek it out.\n\n");
			Mindbreaker.MindbreakerEncounterChance *= 3;
		}
		dynStats("cor", 5);
		cleanupAfterCombat();
    }
}
}