package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Izabella extends Monster 
	{


		override protected function performCombatAction():void
		{
			game.isabellaAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.defeatIsabella();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\n\"<i>Ick,</i>\" Isabella tuts as she turns to leave...");
				game.cleanupAfterCombat();
			} else {
				game.isabellaDefeats();
			}
		}

		public function Izabella(mainClassPtr:*)
		{
			super(mainClassPtr);
			init01Names("", "Isabella", "isabella", "Isabella is a seven foot tall, red-headed tower of angry cow-girl.  She's snarling at you from behind her massive shield, stamping her hooves in irritation as she prepares to lay into you.  Her skin is dusky, nearly chocolate except for a few white spots spattered over her body.  She wears a tight silk shirt and a corset that barely supports her bountiful breasts, but it's hard to get a good look at them behind her giant shield.");
			init02Female(VAGINA_WETNESS_DROOLING,VAGINA_LOOSENESS_GAPING,45);
			init03BreastRows("EE+");
			init04Ass(ANAL_LOOSENESS_VIRGIN,ANAL_WETNESS_DRY,38);
			init05Body("7'6",HIP_RATING_CURVY+2,BUTT_RATING_LARGE+1);
			init06Skin("dusky");
			init07Hair("red",13);
			init08Face();
			init09PrimaryStats(70,98,75,65,65,25,40);
			init10Weapon("giant shield","smash",15);
			init11Armor("giant shield",8,"",70);
			init12Combat(700,30,.35,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(15,rand(5) + 20);
			initX_Tail(TAIL_TYPE_COW,0,0);
			initX_Specials();

		}
		
	}

}