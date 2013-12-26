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


	public class GreenSlime extends Monster
	{


		public function GreenSlime(mainClassPtr:*)
		{
			super(mainClassPtr);
			trace("GreenSlime Constructor!");
			init01Names("a ", "green slime", "greenslime", "The green slime has a normally featureless face that sits on top of wide shoulders that sprout into thick, strong arms.  Its torso fades into an indistinct column that melds into the lump of ooze on the ground that serves as a makeshift form of locomotion.");
			init02Male(new Cock(18, 2, CockTypesEnum.HUMAN), 0, 0, 3, 20);
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED, ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(8) + 80, HIP_RATING_AMPLE, BUTT_RATING_LARGE,LOWER_BODY_TYPE_GOO);
			init06Skin("green");
			init07Hair();
			init08Face();
			init09PrimaryStats(25, 20, 10, 5, 50, 60, 20);
			init10Weapon("hands", "slap");
			init11Armor("gelatinous skin");
			init12Combat(30, 30, 1, Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(2, rand(5) + 1);
			initX_Specials(5040, 5039, 5039);
		}

	}

}