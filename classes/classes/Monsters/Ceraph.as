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


	public class Ceraph extends Monster
	{
		

		public function Ceraph(mainClassPtr:*) 
		{
			super(mainClassPtr);
			trace("Ceraph Constructor!");
			init01Names("", "Ceraph", "ceraph", "Ceraph the Omnibus is totally nude and reveling in it.  Her large yet perky breasts jiggle heavily against her chest as she moves.  The flawless purple skin of her twin mounds glistens with a thin sheen of sweat, inviting you to touch and rub your fingers along their slippery surface.  Her eyes are solid black, but convey a mix of amusement and desire, in spite of their alien appearance.  The demon's crotch is a combination of both genders – a drooling cunt topped with a thick demonic shaft, sprouting from where a clit should be.");
			init02Male(new Cock(10,2,CockTypesEnum.DEMON));
			init02Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_GAPING, 20);
			init03BreastRows("E");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_DRY,15);
			init05Body("5'6",HIP_RATING_CURVY,BUTT_RATING_NOTICEABLE,LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS);
			init06Skin("purple");
			init07Hair("black",20);
			init08Face();
			init09PrimaryStats(65,40,80,80,75,15,100);
			init10Weapon("flaming whip","flame-whip",15);
			init11Armor("demon-skin");
			init12Combat(200,30,0.75,TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(9,rand(5) + 38);
			initX_Specials(5133,5134,5135);
		}

	}

}