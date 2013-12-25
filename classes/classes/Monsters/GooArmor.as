package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class GooArmor extends Monster 
	{

		override protected function performCombatAction():void
		{
			mainClassPtr.gooArmorAI();
		}

		public function GooArmor(mainClassPtr:*)
		{
			super(mainClassPtr);
			init01Names("a ", "Goo Armor", "gooarmor", "Before you stands a suit of plated mail armor filled with a bright blue goo, standing perhaps six feet off the ground.  She has a beautiful, feminine face, and her scowl as she stands before you is almost cute.  She has formed a mighty greatsword from her goo, and has assumed the stance of a well-trained warrior.");
			init02Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_GAPING_WIDE);
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(8) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin("red");
			init07Hair("black",15);
			init08Face();
			init09PrimaryStats(60,50,50,40,60,35,50);
			init10Weapon("claws","claws",60);
			init11Armor("armor",50);
			init12Combat(500,0,.35,Monster.TEMPERMENT_LOVE_GRAPPLES,fatigue);
			init13Level(16,rand(25)+40);
			initX_Tail(TAIL_TYPE_DEMONIC);
			initX_Horns(HORNS_DEMON);
		}
		
	}

}