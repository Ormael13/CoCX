package classes.Monsters
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Goblin extends Monster
	{
		

		public function Goblin(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("Goblin Constructor!");
			init01Names("the ", "goblin", "goblin", "The goblin before you is a typical example of her species, with dark green skin, pointed ears, and purple hair that would look more at home on a punk-rocker.  She's only about three feet tall, but makes up for it with her curvy body, sporting hips and breasts that would entice any of the men in your village were she full-size.  There isn't a single scrap of clothing on her, just lewd leather straps and a few clinking pouches.  She does sport quite a lot of piercings – the most noticeable being large studs hanging from her purple nipples.  Her eyes are fiery red, and practically glow with lust.  This one isn't going to be satisfied until she has her way with you.  It shouldn't be too hard to subdue such a little creature, right?");
			init02Female(VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_NORMAL, 40);
			init03BreastRows("E");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,30);
			init05Body(35 + rand(4),HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin("dark green");
			init07Hair("purple",4);
			init08Face();
			init09PrimaryStats(12,13,35,42,45,45,60);
			init10Weapon("fists","tiny punch");
			init11Armor("leather straps");
			init12Combat(0,50,1,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(1,rand(5) + 5);
			initX_Specials(5087,5088);
		}

	}

}