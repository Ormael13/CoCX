package classes.Monsters 
{
	import classes.Appearance;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class BeeGirl extends Monster
	{
		

		public function BeeGirl(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init01Names("a ", "bee-girl", "beegirl", "A bee-girl buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.");
			init02Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_GAPING);
			init03BreastRows("DD");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_NORMAL);
			init05Body(rand(14) + 59,HIP_RATING_CURVY+3,BUTT_RATING_EXPANSIVE,LOWER_BODY_TYPE_BEE);
			init06Skin("yellow");
			init07Hair(Appearance.randomChoice("black","black and yellow"),6);
			init08Face(FACE_COW_MINOTAUR);
			init09PrimaryStats(30,30,30,20,60,55,0);
			init10Weapon("chitin-plated fist","armored punch");
			init11Armor("chitin",9);
			init12Combat(0,20 + rand(40),0.9,TEMPERMENT_LOVE_GRAPPLES);
			init13Level(4,rand(15) + 1);
			initX_Antennae(ANTENNAE_BEE);
			initX_Wings(WING_TYPE_BEE_LIKE_SMALL);
			initX_Tail(TAIL_TYPE_BEE_ABDOMEN,100);
			initX_Specials(5036);
		}

	}

}