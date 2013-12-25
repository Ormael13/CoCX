package classes.Monsters
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class WormMass extends Monster
	{


		override protected function performCombatAction():void
		{
			//Worms have different AI
			mainClassPtr.eventParser((rand(2) == 0) ? special1 : special2);
		}

		public function WormMass(mainClassPtr:*)
		{
			super(mainClassPtr);
			trace("WormMass Constructor!");
			init01Names("the ","worms","worms","Before you stands the horrid mass of worms. It has shifted itself and now takes the shape of a humanoid composed completely of the worms in the colony. Its vaguely human shape lumbers towards you in a clearly aggressive manner.",true);
			init02Genderless();
			init03BreastRows();
			init04Ass(ANAL_LOOSENESS_VIRGIN,ANAL_WETNESS_DRY);
			init05Body(1,HIP_RATING_SLENDER,BUTT_RATING_BUTTLESS);
			init06Skin("white");
			init07Hair();
			init08Face();
			init09PrimaryStats(35,5,10,1,90,60,90);
			init10Weapon("worm","slap");
			init11Armor("skin");
			init12Combat(0,30,0,Monster.TEMPERMENT_LOVE_GRAPPLES);
			this.HP = 40;
			init13Level(3,0);
			initX_Specials(5054,5055);



		}

	}

}