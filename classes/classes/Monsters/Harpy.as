package classes.Monsters
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Harpy extends Monster
	{


		override protected function performCombatAction():void
		{
			game.harpyAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.harpyVictoryuuuuu();
		}


		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				game.doNext(game.endLustLoss);
			} else {
				game.harpyLossU();
			}
		}

		override protected function outputPlayerDodged(dodge:int):void
		{
			outputText("With another deranged cry the harpy dives at you, swinging her razor-sharp talons through the air with the grace of a ballerina. Your quick reflexes allow you to dodge every vicious slash she makes at you.\n", false);
		}

		override public function outputAttack(damage:int):void
		{
			if (damage <= 0){
				outputText("The harpy dives at you with her foot-talons, but you deflect the attack, grasp onto her leg, and swing her through the air, tossing her away from you before she has a chance to right herself.", false);
			} else {outputText("The harpy surges forward, bringing her razor-sharp claws down on you, tearing at all the exposed flesh she can reach! (" + damage + ")", false);
			}
		}

		public function Harpy(mainClassPtr:*)
		{
			super(mainClassPtr);
			trace("Harpy Constructor!");
			init01Names("the ", "harpy", "harpy", "You are fighting a tall, deranged harpy. She appears very human, about six feet six inches tall but covered in a fine layer of powder-blue down. Her arms are sinewy and muscular, with a long web connecting them to her ample hips, covered in stringy blue feathers to aid her flight. A larger pair of powdery-blue wings also protrudes from her shoulder blades, flapping idly. She appears quite deranged as she circles you, approaching and backing away erratically. Her face is quite beautiful, with fine lilac makeup adorning the features of a handsome woman, and her lips are traced with rich golden lipstick. As she circles you, squawking frantically and trying to intimidate you, your eyes are drawn to her slender torso and small, pert breasts, each the size of a small fruit and covered in a layer of the softest feathers which ripple and move with the gusts from her wings. As astounding as her breasts are, her egg-bearing hips are even more impressive.  They're twice as wide as her torso, with enormous, jiggling buttocks where her huge, meaty thighs are coming up to meet them. Her legs end in three-pronged talons; their shadowy black curves glinting evilly in the light.");
			init02Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_GAPING_WIDE,40);
			init03BreastRows("B");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,20);
			init05Body("6'6",HIP_RATING_INHUMANLY_WIDE,BUTT_RATING_EXPANSIVE,LOWER_BODY_TYPE_HARPY);
			init06Skin("pink",SKIN_TYPE_PLAIN,"feathers");
			init07Hair("blue",16);
			init08Face();
			init09PrimaryStats(60,40,90,40,70,30,80);
			init10Weapon("talons","slashing talons",15);
			init11Armor("feathers",5);
			init12Combat(150,10,.7,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(10,10 + rand(4));
			initX_Wings(WING_TYPE_HARPY);
			initX_Specials(5136,5137);

		}

	}

}