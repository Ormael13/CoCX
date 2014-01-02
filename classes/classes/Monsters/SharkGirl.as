package classes.Monsters
{
	import classes.CoC;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class SharkGirl extends Monster
	{

		override public function defeated(hpVictory:Boolean):void
		{
			game.sharkWinChoices();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				game.doNext(game.endLustLoss);
			} else {
				game.sharkLossRape();
			}
		}

		public function SharkGirl()
		{
			trace("SharkGirl Constructor!");
			init01Names("the ", "shark-girl", "sharkgirl", "The shark girl stands just over 5'5\", with grey skin shimmering from water droplets catching the sunlight and slender muscles built for swimming.  Her shoulder-length silver hair brushes past her pretty face and her eyes are a striking shade of red. She has rows of intimidating sharp teeth glinting in the light. A fish-like tail protrudes from her backside, wrapping around her toned legs at every opportunity. She's wearing a rather skimpy black bikini, strings done in such a way that they move around her fin; though the swimwear itself barely covers her perky breasts and tight snatch.");
			init02Female(VAGINA_WETNESS_DROOLING,VAGINA_LOOSENESS_NORMAL,15);
			init03BreastRows("D");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,40);
			init05Body("5'5",HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin("gray");
			init07Hair("silver",16);
			init08Face();
			init09PrimaryStats(40,40,55,42,75,35,40);
			init10Weapon("shark teeth","bite",3);
			init11Armor("tough skin",5);
			init12Combat(20,40,.9,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(4,rand(15) + 5);
			initX_Specials(5097,5097);



		}

	}

}