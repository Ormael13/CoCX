
package classes.Scenes.Dungeons.EbonLabyrinth
{
import classes.BaseContent;
import classes.StatusEffects;
import classes.EventParser;

public class EyeTyrantScene extends BaseContent {
    public function EyeTyrantScene() {}

    public function encounter():void {
        clearOutput();
        outputText("While exploring the depth of the labyrinth, you hear the sound of something dripping on the ground in the far distance. As you turn the corner, you run into a black rippling form of tentacle mounted eyestalks. Tar-like fluids drip from the creature to the ground in constant drops. You're too stunned by this eldritch oddity to notice the eyestalks all stopped moving to point and stare at you, ");
        outputText("the floating horror turning over itself gaze unblinking to reveal the form of a pale beautiful human half dripping with black goop. Everything about her body would look normal if not for the single all encompassing red eye below her black hairs and above her nose. She smiles revealing sharp teeth before a voice echo in your head coming from seemingly nowhere.\n\n");
        outputText("\"<i>Yes… that is it stare into my eye… lose yourself inside, there is nothing but this eye you should ever look into.</i>\"\n\n");
        outputText("For a moment you succumb, mumbling incoherently and walking to this beautiful eye calling to you, but the sound of the dripping fluid on the ground suddenly jars you to reality. You swiftly back away just before she tries and wraps her arms around you. Realising you snapped out of her dominating gaze the woman attacked.\n\n");
        startCombat(new EyeTyrant(), true);
    }
    
    public function defeatedBy():void {
        clearOutput();
        outputText("You fall to the ground defeated yet for some reason you are not reduced to ashes by the gazer. Instead your gaze is caught once more into its all encompassing eye.\n\n");
        outputText("\"<i>Stay here… with me</i>\"\n\n");
        outputText("Afterward you begin to lose the notion of time. You've been living in the depths with this thing for years now, satisfying its many appetites as they come. When she's hungry you go get her food and when she's in the mood you willingly offer your body to please her. She has all but subdued your willpower entirely making you its permanent willing slave. All you care about is to please the mistress now. ");
        outputText("Every now and then the mistress rewards you and feeds you off course, can't exactly let you starve to death. You think you're forgetting something important however... didn't you have a mission, a duty? It does not matter though so long as your mistress is happy you are happy.\n\n");
        //[GAME OVER]
        EventParser.gameOver();
    }
    
    public function defeat():void {
        clearOutput();
        outputText("You watch in confusion as the omni eyed girl simply vanishes from existence with a growl of anger. Well, the passage ahead of you is free now so might as well take it.\n\n");
        if (player.hasStatusEffect(StatusEffects.TFDealer2) && player.statusEffectv1(StatusEffects.TFDealer2) < 1) player.addStatusValue(StatusEffects.TFDealer2, 1, 1);
        else player.createStatusEffect(StatusEffects.TFDealer2, 1, 0, 0, 0);
        cleanupAfterCombat();
	}
}
}
