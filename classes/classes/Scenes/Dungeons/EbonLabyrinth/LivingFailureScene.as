
package classes.Scenes.Dungeons.EbonLabyrinth
{
import classes.BaseContent;
import classes.EventParser;

public class LivingFailureScene extends BaseContent {
    public function LivingFailureScene() {}
    
    public function encounter():void {
        clearOutput();
        outputText("As you enter the room, you are greeted right away by a monstrosity not meant to exist in the waking world.");
        outputText("\n\nIn front of you, sitting in the middle of a pond of ever flowing cum is a 15 feet tall abomination. The creature has the body of a grown man with the head and hooved legs of a goat and that would be weird enough if not for the quartet of bat wings and tentacles at its back. The heart tipped tail alone is enough to hint at its demonic origin but you could have figured that out simply from how ");
        outputText("vigorously its first set of claw tipped hands jerk its two massive erupting horse cocks under which a quarter of melon sized balls constantly churn with more vile fluids. The thing seems locked in constant orgasm as if the corruption within its body was so unstable the only option was to constantly cum it out yet at the same time it is frozen in a meditative pose, both legs crossed and its ");
        outputText("two free hand palm to palm as if praying. You're just about to leave when the thing suddenly speaks arcane power sealing your exit with a barrier. Behind the pleasure glazed expression of its eyes you can see its malevolent intensions. It's not going to let you leave.\n\n");
        startCombat(new LivingFailure(), true);
    }

    public function defeatedBy():void {
        clearOutput();
        outputText("As you fall defeated by the fiend the last thing you see is the opening orifice of his massive dick as it proceeds to swallow you in. Past this point your death is left to speculation but most scholars agreed that these details were best left ignored and forgotten just like the horror you fought.\n\n");
        //[GAME OVER]
        EventParser.gameOver();
    }
    
    public function defeat():void {
        clearOutput();
        outputText("The fiend concentration wavers as one of his rebeling vagina tentacles encapsulate one of his erupting cock. The monster loses control of his magic if only for an instant causing the barrier to shatter. Not one to miss an opportunity you run away escaping this fiend back in the labyrinth however by chance you manage to bottle some of that oozing black fluid it was cuming.\n\n");
        cleanupAfterCombat();
    }
}
}
