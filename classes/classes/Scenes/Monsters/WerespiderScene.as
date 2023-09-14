/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
import classes.*;

	public class WerespiderScene extends BaseContent
	{
		
		public function WerespiderScene() 
		{}

public function werespiderEncounter():void {
	clearOutput();
	outputText("\n\n");
	outputText("\"<i></i>\"\n\n");
	outputText("\n\n");
	startCombat(new Werespider());
}

	}

}