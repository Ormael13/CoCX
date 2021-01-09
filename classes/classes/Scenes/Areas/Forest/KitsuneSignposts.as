package classes.Scenes.Areas.Forest {
import classes.*;
import classes.Scenes.*;
import classes.GlobalFlags.kFLAGS;

public class KitsuneSignposts extends BaseContent {

		public function KitsuneSignpost():void {
			if ((kFLAGS.SIGNPOSTS_DISCOVERED) < 0) {
				outputText("You wander into the forest once more, and you admire the scenery, and sometimes jump away from the tentacle beasts that try an snare you, when you walk headfirst into a pole.\n"
						+ "You collide with it with such force that your forehead mildly bruises. Rubbing it as you look up, you wonder what a pole is doing here in the middle of the forest, when you notice arrows pointing to different directions and a piece of paper stuck to it, flapping in the breeze.\n"
						+ "You read the paper, and learn that you have stumbled upon a mystical nexus, a guidepost that would point you to known locations of kitsunes in the area. It further states below that the signpost is enchanted to look different to each person, as to protect the location of each kitsune, and that only the locations of kitsunes that the reader knows would be shown here.\n"
						+ "You quickly memorise the location, as to easily return your way back to here.")
				flags[kFLAGS.SIGNPOSTS_DISCOVERED] = 1
			} else {
				outputText("You once again make your way into the forest, in search of the signpost. It seems like each time, you're finding it faster and faster. You promptly arrive, and look for the direction of the kitsune you're looking for.")
			}
			if (flags[kFLAGS.KITSUNE_SHRINE_UNLOCKED] > 0) addButton(1, "Shrine", SceneLib.kitsuneScene.kitsuneShrine).hint("Visit the kitsune shrine in the deepwoods.");
			else addButtonDisabled(1, "???", "???");
			if (flags[kFLAGS.AIKO_TIMES_MET] > 3) addButton(2, "Great Tree", SceneLib.aikoScene.encounterAiko).hint("Visit the Great Tree in the Deep Woods where Aiko lives.");
			else addButtonDisabled(2, "???", "???");

		}
	}
}