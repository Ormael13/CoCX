package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class MilkySuccubus extends Monster 
	{

		override protected function performCombatAction():void
		{
			game.milkSuccubusAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.urtaBeatsUpCowcubi();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.urtaLosesToCowCubi();
		}

		public function MilkySuccubus(mainClassPtr:*)
		{
			super(mainClassPtr);
			init01Names("the ", "milky succubus", "milkysuccubus", "You are fighting a milky, cow-like succubus.  She stands about seven feet tall and is hugely voluptuous, with breasts three times the size of her head, tipped with a cluster of four obscenely teat-like nipples.  Her hips flare out into an exaggerated hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her spankable butt.  A small cowbell is tied at the base of the arrow-head with a cute little ribbon.  Wide, cow-like horns, easily appropriate for a minotaur, rise from her head, and she flicks bovine ears about the sides of her head whilst sashaying from side to side on demonic, high-heeled feet.  Her skin is a vibrant purple with splotches of shiny black here and there, including one large spot covering her right eye.  She's using a leather whip as a weapon.");
			init02Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_NORMAL,300);
			init03BreastRows("G");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(9) + 60,HIP_RATING_CURVY,BUTT_RATING_LARGE+1,LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS);
			init06Skin("blue");
			init07Hair("black",13);
			init08Face();
			init09PrimaryStats(75,50,125,95,90,60,99);
			init10Weapon("whip","whipping",10,"",150);
			init11Armor("demonic skin",10);
			init12Combat(700,40,.3,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(16,rand(25)+10,50);
			initX_Horns(HORNS_DRACONIC_X2);
			initX_Wings(WING_TYPE_BAT_LIKE_TINY,"tiny hidden");
			initX_Tail(TAIL_TYPE_DEMONIC);
			initX_Specials(11020,11021,11022);

		}
		
	}

}