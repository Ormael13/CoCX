package classes.Monsters
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class FetishCultist extends Monster
	{
		

		public function FetishCultist(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("GenericMonstah Constructor!");
			init01Names("the ", "fetish cultist", "fetishcultist", "The woman across from you has her eyes closed, her hands joined, and seems to be chanting under her breath. She is wearing a religious outfit that closely hugs her curvacious shape, with a skirt so short that you can clearly see her pussy's lips.\n\nShe has clealy lost her grasp on sanity, and filled the void with pure perversion.");
			init02Female(VAGINA_LOOSENESS_GAPING, VAGINA_WETNESS_WET);
			init03BreastRows("DD");
			init04Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_NORMAL);
			init05Body("5'7",HIP_RATING_AMPLE,BUTT_RATING_LARGE);
			init06Skin("pale");
			init07Hair("black",15);
			init08Face();
			init09PrimaryStats(35,25,30,1,75,80,90);
			init10Weapon("whip","whip-crack");
			init11Armor("fetishy outfit");
			init12Combat(0,25,1,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(2,5+rand(10));
			initX_Specials(5062,5063,5062);
		}

	}

}