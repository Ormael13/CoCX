/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
import classes.*;

	public class WerefoxScene extends BaseContent
	{
		
		public function WerefoxScene() 
		{}

public function werefoxEncounter():void {
	clearOutput();
	outputText("\n\n");
	outputText("\"<i></i>\"\n\n");
	outputText("\n\n");
	startCombat(new Werefox());
}

	}

}