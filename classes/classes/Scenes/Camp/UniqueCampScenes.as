/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class UniqueCampScenes 
	{
		
		public function UniqueCampScenes() 
		{	//flags[kFLAGS.ALRAUNE_GROWING] == 15 - 2 weeks old children
		}	//flags[kFLAGS.ALRAUNE_GROWING] == 22 - 3 weeks old children

public function wateryourgarden():void
{
	clearOutput();
	outputText("You water your sprouts, making sure they don’t lack anything. This includes spending a little time ensuring no weeds get so much as half a chance to encroach on your private garden.\n\n");
	flags[kFLAGS.ALRAUNE_DAILY_WATERING] = 1;
	if (flags[kFLAGS.ALRAUNE_GROWING] < 22) flags[kFLAGS.ALRAUNE_GROWING]++;
	doNext(playerMenu);
}

	}

}