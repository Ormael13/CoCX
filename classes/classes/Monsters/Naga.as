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


	public class Naga extends Monster
	{

		override public function defeated(hpVictory:Boolean):void
		{
			game.nagaRapeChoice();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe naga's eyes go wide and she turns to leave, no longer interested in you.", false);
				game.dynStats("lus=", 0);
				doNext(game.cleanupAfterCombat);
			} else {
				game.nagaFUCKSJOOOOOO();
			}
		}

		public function Naga()
		{
			trace("Naga Constructor!");
			init01Names("the ", "naga", "naga", "You are fighting a naga. She resembles a beautiful and slender woman from the waist up, with dark hair hanging down to her neck. Her upper body is deeply tanned, while her lower body is covered with shiny scales, striped in a pattern reminiscent of the dunes around you. Instead of bifurcating into legs, her hips elongate into a snake's body which stretches far out behind her, leaving a long and curving trail in the sand.  She's completely naked, with her round C-cup breasts showing in plain sight. In her mouth you can see a pair of sharp, poisonous fangs and a long forked tongue moving rapidly as she hisses at you.");
			init02Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_NORMAL,40);
			init03BreastRows("C");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,10);
			init05Body("5'10",HIP_RATING_AMPLE+2,BUTT_RATING_LARGE,LOWER_BODY_TYPE_NAGA);
			init06Skin("mediterranean-toned");
			init07Hair("brown",16);
			init08Face();
			init09PrimaryStats(28,20,35,42,55,55,40);
			init10Weapon("fist","punch",3);
			init11Armor("scales",5);
			init12Combat(0,30,1,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(2,rand(5) + 8);
			initX_Specials(5109,5110,5111);


		}

	}

}