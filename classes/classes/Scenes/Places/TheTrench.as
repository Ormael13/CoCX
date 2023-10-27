/**
 * ...
 * @author Ohaxer & Sylabt
 */
package classes.Scenes.Places 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;

	public class TheTrench extends BaseContent {
		
		public function TheTrench() 
		{}

public function nightSixChoice():void {
	outputText("your facial features tingle as they start to change, quickly gaining the appearance of that of a woman, your voice quickly follows suit as you gasp at a sudden pain coming from the change of your figure, and an itch builds up from your now soft chest that you can’t help but scratch at furiously, the itch soon begins to turn to pleasure as your chest slowly swells out into a pair of perfectly plump breasts. After trying to catch your breath and take in your new form you can’t help but moan and spasm as a warm wetness seems to leak from your nether region, and as you look down you realize…");
	menu();
	addButton(1, "Dick", nightSixChoiceDick);
	addButton(3, "No Dick", nightSixChoiceNoDick);
}
private function nightSixChoiceDick():void {
	outputText("A look down between your now thicker covered thighs reveals your dick is still there"+(player.hasBalls()?" however your balls seem to have disappeared":"")+". What catches your attention however is a wet vertical slit underneath your cock, you experimentally take two fingers and slowly open your new light blue folds, and can’t help but moan from a sudden wave of pleasure and heat that radiates up your spine, forcibly arching your back.");
	player.balls = 0;
    player.ballSize = 1;
	if (!player.hasVagina()) transformations.VaginaArigean().applyEffect();
}
private function nightSixChoiceNoDick():void {
	outputText("It’s gone! A look down between your now thicker covered thighs reveals your dick"+(player.hasBalls()?" and balls":"")+" has been replaced with a moist vertical slit, you experimentally use two fingers to open your new light blue folds, and can’t help but moan from a sudden wave of pleasure and heat that radiate up your spine flushing your face blue.");
	player.balls = 0;
    player.ballSize = 1;
	player.killCocks( -1, false);
	if (!player.hasVagina()) transformations.VaginaArigean().applyEffect();
}
}
}