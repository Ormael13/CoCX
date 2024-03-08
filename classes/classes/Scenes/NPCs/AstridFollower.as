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
		outputText("She introduces herself as Astrid\n");
		outputText("You look at her and smile telling her that your name is [PC name] she smiles at you and says nice to meet you,come by my cart anytime and I will sell you whatever you need maybe we can even chat.");
		outputText("thanking her for her offer to help you and give you company as you return to camp.");
		//TODO add Astrid to soulsense list here
		addButton(1, "Return to Camp", endEncounter);
	}

		//Win Scene: the moth girl falls on her back,
		// a panting mess, as you approach you decide to give her a taste of her own medicine,
		// you rub your foot on her pussy causing her to cry out in ecstasy as you continue to rub against her clit before you remove your pants and expose your dick/vagina and stroke/rub yourself as you torment the fallen moth girl before reaching orgasm and covering her in your cum/juices, smiling as the moth girl lays on the ground panting while covered in your cum/love juices you pull your pants back up and return to camp.
		public function astridDefeated():void {
			clearOutput();
			outputText("the moth girl falls on her back, a panting mess, as you approach you decide to give her a taste of her own medicine, you rub your foot on her pussy causing her to cry out in ecstasy as you continue to rub against her clit before you remove your pants and expose your dick/vagina and stroke/rub yourself as you torment the fallen moth girl before reaching orgasm and covering her in your cum/juices, smiling as the moth girl lays on the ground panting while covered in your cum/love juices you pull your pants back up and return to camp.\n");
			cleanupAfterCombat();
		}
		//Loss Scene: you fall to the ground a panting mess as the moth girl approaches you and rubs her feet against your sex, she looks down at you with a mischievous smile before flying away leaving you hard as she giggles mockingly. You are left alone without release.
		public function astridWon():void {
			clearOutput();
			outputText("you fall to the ground a panting mess as the moth girl approaches you and rubs her feet against your sex, she looks down at you with a mischievous smile before flying away leaving you hard as she giggles mockingly. You are left alone without release.");
			cleanupAfterCombat();
		}

		//TODO sex scenes and actual conversation
	}
}