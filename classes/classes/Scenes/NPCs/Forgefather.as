/**
	 * ...
	 * @author melyons
	 */

package classes.Scenes.NPCs	{
	
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class Forgefather extends NPCAwareContent	{
		
		public function Forgefather() 
		{}
		
		public function meetForgefather():void	{
			flags[kFLAGS.MET_FORGEFATHER] = 1;
			clearOutput();
			outputText("Write Write Write.");
			outputText("Meet him");
			addButton(0, "Accept Forgefather", moveInFF);
			addButton(1, "Not Now", notNow);
		}
		
		public function moveInFF():void {
			flags[kFLAGS.FORGEFATHER_MOVED_TO_TEMPLE] = 1;
			clearOutput();
			outputText("Write Write Write");
			outputText("Move him in");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function notNow():void {
			clearOutput();
			outputText("Write Write Write");
			outputText("Not Now");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function repeatForgefather():void {
			clearOutput();
			outputText("Write Write Write");
			outputText("Welcome Back");
			addButton(0, "Accept Forgefather", moveInFF);
			addButton(1, "Not Now", notNow);
		}
	}

}