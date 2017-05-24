/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class UniqueCampScenes extends BaseContent
	{
		
		public function UniqueCampScenes() 
		{	//flags[kFLAGS.ALRAUNE_GROWING] == 15 - 2 weeks old children
		}	//flags[kFLAGS.ALRAUNE_GROWING] == 22 - 3 weeks old children

public function manageuyourgarden():void
{
	clearOutput();
	outputText("Once again this is maig garden menu so it's up to Liadri to decide if we gonna get some text here or not.\n\n");
	menu();
	if (flags[kFLAGS.ALRAUNE_GROWING] > 14) addButton(0, "Play", playwithyourplantdaughters);
	if (flags[kFLAGS.ALRAUNE_DAILY_WATERING] < 1) addButton(9, "Water", wateryourgarden);
	addButton(14, "Back", inventory.stash);
}

public function wateryourgarden():void
{
	clearOutput();
	outputText("You water your sprouts, making sure they don’t lack anything. This includes spending a little time ensuring no weeds get so much as half a chance to encroach on your private garden.\n\n");
	flags[kFLAGS.ALRAUNE_DAILY_WATERING] = 1;
	if (flags[kFLAGS.ALRAUNE_GROWING] < 22) flags[kFLAGS.ALRAUNE_GROWING]++;
	doNext(camp.returnToCampUseOneHour);
}

public function playwithyourplantdaughters():void
{
	clearOutput();
	outputText("You decide to set some time aside to play with your sprouts. You tell them as much while you pull water toys you bought in Tel'Adre out of your pack. The happiness on their little faces warms your heart.\n\n");
	outputText("\"<i>Wow, really mom? You are the best!</i>\"\n\n");
	outputText("Your daughters all cheer up as they pick up the toys and rush to the rivers to fill them up. Soon you’re all splashing each other. The experience is refreshing and soothing. You never thought you would appreciate having children this much. Perhaps parenting comes included in the whole “being a child of a fertility goddess” deal, you ponder, before being splashed in the face by one of your daughters, breaking you out of your reverie, and dragging you back into the game.\n\n");
	doNext(camp.returnToCampUseOneHour);
}

	}

}