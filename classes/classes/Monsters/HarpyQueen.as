package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class HarpyQueen extends Monster 
	{

		override protected function performCombatAction():void
		{
			mainClassPtr.harpyQueenAI();
		}

		public function HarpyQueen(mainClassPtr:*)
		{
			super(mainClassPtr);
			init01Names("the ", "Harpy Queen", "harpyqueen", "You face the Harpy Queen, a broodmother of epic proportions - literally.  Her hips are amazingly wide, thrice her own width at the least, and the rest of her body is lushly voluptuous, with plush, soft thighs and a tremendous butt.  Her wide wings beat occasionally, sending ripples through her jiggly body.  She wields a towering whitewood staff in one hand, using the other to cast eldritch spells.");
			init02Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_LOOSE);
			init03BreastRows("D");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_DRY);
			init05Body(rand(8) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE,LOWER_BODY_TYPE_HARPY);
			init06Skin("red",SKIN_TYPE_PLAIN,"feathers");
			init07Hair("black",15);
			init08Face();
			init09PrimaryStats(70,60,120,40,40,45,50);
			init10Weapon("eldritch staff","thwack",20);
			init11Armor("armor",20);
			init12Combat(1000,20,.15,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(20,rand(25)+160,50);
			initX_Tail(TAIL_TYPE_HARPY);
			initX_Wings(WING_TYPE_FEATHERED_LARGE);
			initX_Specials();
		}
		
	}

}