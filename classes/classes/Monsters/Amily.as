package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Amily extends Monster 
	{

		override protected function performCombatAction():void
		{
			mainClassPtr.amilyAI();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			mainClassPtr.conquerThatMouseBitch();
		}

		public function Amily(mainClassPtr:*)
		{
			super(mainClassPtr);
			init01Names("", "Amily", "amily", "You are currently fighting Amily. The mouse-morph is dressed in rags and glares at you in rage, knife in hand. She keeps herself close to the ground, ensuring she can quickly close the distance between you two or run away.");
			init02Female(VAGINA_WETNESS_NORMAL, VAGINA_LOOSENESS_NORMAL, 48);
			init03BreastRows("C");
			init04Ass(ANAL_LOOSENESS_VIRGIN,ANAL_WETNESS_DRY);
			init05Body("4'",HIP_RATING_AMPLE,BUTT_RATING_TIGHT);
			init06Skin("tawny",SKIN_TYPE_FUR);
			init07Hair("brown",5);
			init08Face();
			init09PrimaryStats(30,30,85,60,45,45,10);
			init10Weapon("knife","slash",6);
			init11Armor("rags",1);
			init12Combat(20,20,.85);
			init13Level(4,2 + rand(5));
		}
		
	}

}