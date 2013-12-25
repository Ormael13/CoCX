package classes.Monsters
{
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Sophie extends Monster
	{


		override protected function performCombatAction():void
		{
			//Sophie has special AI in harpySophie.as
			mainClassPtr.sophieAI();
		}

		public function Sophie(mainClassPtr:*)
		{
			super(mainClassPtr);
			trace("Sophie Constructor!");
		
			init01Names("", "Sophie", "sophie", "Sophie is approximately the size of a normal human woman, not counting the large feathery wings that sprout from her back.  Her face is gorgeous, with large rounded eyes and glimmering amber lip-gloss painted on her lush, kissable lips.  In spite of her beauty, it's clear from the barely discernible laugh lines around her mouth that she's been around long to enough to have quite a few children.  Her feathers are light pink, though the downy plumage that comprises her 'hair' is brighter than the rest.  She moves with practiced grace despite the large, jiggling breasts that hang from her chest.  Judging from her confident movements, she's an experienced fighter.");
			init02Female(VAGINA_WETNESS_DROOLING,VAGINA_LOOSENESS_GAPING_WIDE,40);
			init03BreastRows("DD");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,10);
			init05Body("5'5",HIP_RATING_INHUMANLY_WIDE,BUTT_RATING_EXPANSIVE);
			init06Skin("pink",SKIN_TYPE_PLAIN,"feathers");
			init07Hair("pink",16);
			init08Face();
			init09PrimaryStats(55,40,110,60,60,50,60);
			init10Weapon("talons","slashing talons",20);
			init11Armor("feathers",5);
			init12Combat(250,10,.3,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(11,20 + rand(25));
			initX_Wings(WING_TYPE_HARPY,"large feathery");
			initX_Specials(5136,5137);

		}

	}

}