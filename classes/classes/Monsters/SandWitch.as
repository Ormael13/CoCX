package classes.Monsters
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class SandWitch extends Monster
	{
		

		public function SandWitch(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("SandWitch Constructor!");
			init01Names("the ","sand witch",mainClassPtr.silly()?"sandwidch":"sandwitch","A sand witch appears to be totally human, an oddity in this strange land.  She has dirty blonde hair and a very tanned complexion, choosing to cover most of her body with robes of the same color as the desert sands, making her impossible to spot from afar.");
			init02Female(VAGINA_WETNESS_WET,VAGINA_LOOSENESS_LOOSE);
			init03BreastRows(["DD"],["DD"]);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_NORMAL);
			init05Body(rand(12) + 55,HIP_RATING_CURVY,BUTT_RATING_LARGE);
			init06Skin("bronzed");
			init07Hair("sandy-blonde",15);
			init08Face();
			init09PrimaryStats(25,25,35,45,55,40,30);
			init10Weapon("kick","kick");
			init11Armor("robes");
			init12Combat(20,30,1,TEMPERMENT_LUSTY_GRAPPLES,0);
			init13Level(3,rand(15) + 5);
			initX_Specials(5020,special2,special3);



		}

	}

}