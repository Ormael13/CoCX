package classes.Monsters 
{
	import classes.Appearance;
	import classes.Monster;
	/**
	 * ...
	 * @author aimozg
	 */
	public class GooGirl extends Monster
	{

		override protected function performCombatAction():void
		{
			mainClassPtr.gooAI();
		}

		public function GooGirl(mainClassPtr:*)
		{
			super(mainClassPtr);
			var playerHasBigBoobs:Boolean = mainClassPtr.player.biggestTitSize() >= 3;
			init01Names("the ","goo-girl","googirl","The goo-girl has a curious expression on her youthful, shimmering face. Her body is slender and globs of slime regularly drip from her limbs, splattering into the goo puddle pooling beneath her hips. A small, heart-shaped nucleus pulses in her chest with a red glow."+(playerHasBigBoobs?("  She has apparently made herself a bit more like you, as her chest appears to be a perfect copy of your " + mainClassPtr.biggestBreastSizeDescript()+ "."):""));
			init02Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_NORMAL,9001);
			init03BreastRows(playerHasBigBoobs?mainClassPtr.player.biggestTitSize():3);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_SLIME_DROOLING,9001);
			init05Body(rand(8) + 70,HIP_RATING_AMPLE,BUTT_RATING_LARGE,LOWER_BODY_TYPE_GOO);
			var tone:String = Appearance.randomChoice("blue","purple","crystal");
			init06Skin(tone,SKIN_TYPE_GOO);
			init07Hair(tone,12+rand(10));
			init08Face();
			init09PrimaryStats(25,25,20,30,50,40,10);
			init10Weapon("hands","slap");
			init11Armor("gelatinous skin");
			init12Combat(40,45,.75,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(3,rand(5)+1);
			initX_Specials(5040,5039,5039);
		}
		
	}

}