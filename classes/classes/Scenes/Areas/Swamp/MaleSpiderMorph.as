package classes.Scenes.Areas.Swamp
{
	import classes.CoC;
	import classes.Cock;
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MaleSpiderMorph extends Monster 
	{


		override public function defeated(hpVictory:Boolean):void
		{
			game.swamp.maleSpiderMorphScene.defeatSpiderBoy();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe spider flashes a predatory grin while she waits it out...");
				doNext(game.endLustLoss);
			} else {
				game.swamp.maleSpiderMorphScene.loseToMaleSpiderMorph();
			}
		}

		public function MaleSpiderMorph()
		{
			init01Names("the ", "male spider-morph", "malespidermorph", "The male spider-morph is completely nude, save for his thigh-high stockings and forearm-length gloves, which upon closer inspection, appear to be actually be part of his body - his exoskeleton.  His exposed skin is pale as the full moon, save for the dusk of his nipples and a patch of jet-black that spreads out over his groin, glossing the male's foreskinned cock and dangling sack in glistening ebon.  His ass is small but well-rounded, with a weighty spider-abdomen hanging from just above.  The spider-man is currently eyeing you with a strange expression and his fangs bared.");
			init02Male(new Cock(6,2),2,2);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,40);
			init05Body("7'6",HIP_RATING_CURVY+2,BUTT_RATING_LARGE+1,LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS);
			init06Skin("dusky");
			init07Hair("red",13);
			init08Face();
			init09PrimaryStats(60,50,99,99,35,35,20);
			init10Weapon("dagger","stab",15);
			init11Armor("exoskeleton",14,"",70);
			init12Combat(200,20,.6,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(13,rand(10) + 10);
			init14WeightedDrop()
					.add(consumables.S_GOSSR,5)
					.add(useables.T_SSILK,1)
					.add(null,4);
			initX_Tail(TAIL_TYPE_SPIDER_ADBOMEN,0,0);
			initX_Specials();
		}
		
	}

}