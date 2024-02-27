/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	
	public class AstridFollower extends NPCAwareContent
	{
		
		public function AstridFollower() 
		{}//moth-girl merchant meet in forest/deepwods/other forest type area?

	public function approachWoman():void {
		clearOutput();
		menu();
		outputText("As you wander through the forest you see a peculiar sight, a shapely moth woman standing next to a knocked over cart. Do you approach her?");
		addButton(0, "Yes", helpWoman);
		addButton(1, "No", endEncounter);
	}
	public function helpWoman():void {
		outputText("The woman greets you... Do you help her?");
		addButton(0, "Yes", introduceYourself);
		addButton(1, "No", endEncounter);
	}
	public function introduceYourself():void {
		outputText("She introduces herself... Do you reply back introducing yourself?(yes/no)");
		outputText("You look at her and smile telling her that your name is [PC name] she smiles at you and says nice to meet you,come by my cart anytime and I will sell you whatever you need maybe we can even chat.");
		outputText("thanking her for her offer to help you and give you company as you return to camp.");
		addButton(1, "Return to Camp", endEncounter);
	}
}
}