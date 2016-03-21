package classes.Scenes.Dungeons.D3 
{
	import classes.BaseContent;
	/**
	 * ...
	 * @author Gedan
	 */
	public class LivingStatueScenes extends BaseContent
	{
		public function LivingStatueScenes() 
		{
			
		}
		
		public function encounter():void
		{
			clearOutput();
			outputText("The immense statue gives a mighty groan as you near and shudders, shaking loose years of dust and grime. A few ravens cry in distress as they're shaken loose from their roosts. Taking a step back, you watch as the mammoth figure pushes itself up to a standing position. It towers above, at least thirty feet tall, and easily lifts a hammer carved from the same marble as its gleaming muscles.")
			if (silly()) outputText(" On the plus side, it seems to lack knees. That should make dodging its attacks a bit easier.");
			outputText( "Moss clings to its chin an age-gifted beard. Bits of it shake loose as it speaks. <i>\"Tresspasser!\"</i>");

			outputText("\n\nStriding towards you, the behemoth raises its hammer overhead. Dust cascades from its seamless joints, and it's only as it closes distance that you spot a pockmarks and near-invisible surface cracks, the hallmarks of its age. You'll have to fight this alabaster destroyer if you want to live!");

			startCombat(new LivingStatue());
		}
		
		public function beatUpDaStatue(hpVictory:Boolean):void
		{
			clearOutput();
			outputText("Cracks spiderweb out from the point of your last strike, spreading like wildfire across the surface of the stone giant. It groans in pain as its face slowly freezes, locked in a grimace of inhuman suffering before the whole of it comes apart. Chunks of marble fall, kicking up a cloud of white dust and dirt. When it clears, there's nothing left but two marble feet, amputated at the ankle, standing amidst a field of rubble.");
			outputText("\n\nA gleaming, purple stone in the center catches your eye.");
			
			menu();
			addButton(0, "Take Stone", takeTheStone);
		}
		
		private function takeTheStone():void
		{
			clearOutput();
			
			outputText("You carefully step through the cratered rubble to claim your prize. It's a chunk of lethicite,");
			
			// 9999 dis shit.
			if (player.hasKeyItem("Marae's Lethicite")) outputText(" easily as big as Marae's.");
			else outputText(" like the purple crystals in the factory, only this one is three times as big.");
			outputText("\n\n<b>Lethicite acquired!</b>");
			
			player.createKeyItem("Stone Statue Lethicite", 0, 0, 0, 0);

			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}
		
		public function fuckinMarbleOP(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			clearOutput();
			outputText("You slump to your knees, overwhelmed and unable to see the shadow of the falling hammer. Your last thoughts are of regret.");
			
			getGame().gameOver();
		}
	}

}