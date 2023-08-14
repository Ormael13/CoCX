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
	outputText("\n\n");
	outputText("\"<i></i>\"\n\n");
	outputText("\n\n");
	startCombat(new Wereshark());
}

	}

}