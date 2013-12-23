package classes.Monsters
{
	import classes.Cock;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class FetishZealot extends Monster
	{
		

		public function FetishZealot(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("FetishZealot Constructor!");
		
			init01Names("the ", "fetish zealot", "fetishzealot", "The zealot is clad in a bizarre set of religious robes.  They are similar to what you've seen on other religious leaders from home, but none that included the large slit at the front that lets his above average sized human dick stick out the front.");
			init02Male(new Cock(7,1.5));
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_LOOSE,ANAL_WETNESS_DRY,40);
			init05Body("6'",HIP_RATING_BOYISH+1,BUTT_RATING_TIGHT);
			init06Skin("tan");
			init07Hair("black",4);
			init08Face();
			init09PrimaryStats(35,35,30,1,75,80,90);
			init10Weapon("wavy dagger","stab",3);
			init11Armor("religious clothes",5);
			init12Combat(0,25,0.75,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(5,5+rand(10));
			initX_Specials(5103,5104);
		}

	}

}