package classes.Monsters
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Marble extends Monster
	{
		

		public function Marble(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("Marble Constructor!");
			init01Names("", "Marble", "marble", "Before you stands a female humanoid with numerous cow features, such as medium-sized cow horns, cow ears, and a cow tail.  She is very well endowed, with wide hips and a wide ass.  She stands over 6 feet tall.  She is using a large two handed hammer with practiced ease, making it clear she is much stronger then she may appear to be.");
			init02Female(VAGINA_WETNESS_NORMAL,VAGINA_LOOSENESS_NORMAL);
			init03BreastRows("F");
			init04Ass(ANAL_LOOSENESS_VIRGIN,ANAL_WETNESS_DRY);
			init05Body("6'4",HIP_RATING_CURVY,BUTT_RATING_LARGE,LOWER_BODY_TYPE_HOOFED);
			init06Skin("pale");
			init07Hair("brown",13);
			init08Face();
			init09PrimaryStats(75,70,35,40,25,45,40);
			init10Weapon("large hammer","hammer-blow",10);
			init11Armor("tough hide",5);
			init12Combat(0,0,1,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(7,rand(5) + 25);
			initX_Tail(TAIL_TYPE_COW);
			initX_Specials(5092,5093);

		}

	}

}