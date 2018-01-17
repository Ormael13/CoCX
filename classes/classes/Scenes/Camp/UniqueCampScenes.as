/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class UniqueCampScenes extends BaseContent
	{
		
		public function UniqueCampScenes() 
		{	//flags[kFLAGS.ALRAUNE_GROWING] == 15 - 2 weeks old children
		}	//flags[kFLAGS.ALRAUNE_GROWING] == 22 - 3 weeks old children

public function manageuyourgarden():void
{
	clearOutput();
	outputText("Your daughters are busy bickering about whose the most beautiful flower of them all.\n\n");
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

public function playsRathazulAndSoulgemScene():void
{
	clearOutput();
	outputText("As you pass by Rathazul considers you, then asks \"<i>May I ask what you’re planning to do with that soul gem of yours? Because yes I know exactly what this dangerous crystal you’re carrying is</i>\"\n\n");
	outputText("When you mention you want to create a golem, Rathazul seems to lose himself in thought, as if trying to remember something.\n\n");
	outputText("\"<i>Years ago, when I was younger, I knew a woman who specialised in such constructs. She was obsessed with creating the perfect servant. However when the demons came, hungry for power, she embraced them instead of fleeing and became one of those aberrations. Her laboratory is likely still located in the same area as before - hidden somewhere in the place now called the blighted ridges. If you go there, be careful. ");
	outputText("Losing her humanity likely didn't do any good to her already fragile sanity. None can say  what you will find.</i>\"\n\n");
	outputText("You thank Rathazul for telling you this as this might just be the information you need.");
	flags[kFLAGS.DEN_OF_DESIRE_QUEST] = 1;
	doNext(camp.returnToCampUseOneHour);
}

	}

}