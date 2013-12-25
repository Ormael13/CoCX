package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Basilisk extends Monster 
	{

		override protected function performCombatAction():void
		{
			mainClassPtr.basiliskAI();
		}

		public function Basilisk(mainClassPtr:*)
		{
			super(mainClassPtr);
			init01Names("the ", "basilisk", "basilisk", "You are fighting a basilisk!  From what you can tell while not looking directly at it, the basilisk is a male reptilian biped standing a bit over 6' tall.  It has a thin but ropy build, its tightly muscled yellow underbelly the only part of its frame not covered in those deceptive, camouflaging grey-green scales.  A long, whip-like tail flits restlessly through the dirt behind its skinny legs, and sharp sickle-shaped index claws decorate each hand and foot.  You don't dare to look at its face, but you have the impression of a cruel jaw, a blunt lizard snout and a crown of dull spines.");
			init02Male([new Cock(6,2)],2,2);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,30);
			init05Body("7'6",HIP_RATING_SLENDER+1,BUTT_RATING_AVERAGE);
			init06Skin("gray",SKIN_TYPE_SCALES);
			init07Hair("none",0);
			init08Face();
			init09PrimaryStats(85,70,35,70,50,35,60);
			init10Weapon("claws","claw",30);
			init11Armor("scales",10,"",70);
			init12Combat(200,30,.5,TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(12,rand(10) + 10);
			initX_Tail(TAIL_TYPE_COW,0,0);
		}
		
	}

}