package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Brigid extends Monster 
	{

		override protected function performCombatAction():void
		{
			game.BrigidAI();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.pcDefeatsBrigid();
		}

		public function Brigid(mainClassPtr:*)
		{
			super(mainClassPtr);
			init01Names("", "Brigid the Jailer", "brigid", "Brigid is a monster of a harpy, standing a foot taller than any other you've seen. She's covered in piercings, and her pink-dyed hair is shaved down to a long mohawk. She's nude, save for the hot poker in her right hand and the shield in her left, which jingles with every step she takes thanks to the cell keys beneath it.");
			init02Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_LOOSE,LOWER_BODY_TYPE_HARPY);
			init03BreastRows("D");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_DRY);
			init05Body(rand(8) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin("red");
			init07Hair("black",15);
			init08Face();
			init09PrimaryStats(90,60,120,40,40,45,50);
			init10Weapon("poker","burning stab",30);
			init11Armor("armor",20);
			init12Combat(1000,20,.25,TEMPERMENT_LOVE_GRAPPLES);
			init13Level(19,rand(25)+140,50);
			initX_Wings(WING_TYPE_FEATHERED_LARGE);
			initX_Tail(TAIL_TYPE_DEMONIC);
			initX_Horns(HORNS_DEMON);
		}
		
	}

}