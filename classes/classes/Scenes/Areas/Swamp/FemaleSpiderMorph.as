package classes.Scenes.Areas.Swamp
{
	import classes.Monster;

	/**
	 * ...
	 * @author ...
	 */
	public class FemaleSpiderMorph extends AbstractSpiderMorph
	{


		override public function defeated(hpVictory:Boolean):void
		{
			game.swamp.femaleSpiderMorphScene.defeatASpiderBitch();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe spider flashes a predatory grin while she waits it out...");
				doNext(game.endLustLoss);
			} else {
				game.swamp.femaleSpiderMorphScene.loseToFemaleSpiderMorph();
			}
		}

		public function FemaleSpiderMorph()
		{
			init01Names("the ", "female spider-morph", "femalespidermorph", "The female spider-morph is completely nude, save for her thigh-high stockings and forearm-length gloves, which upon closer inspection, appear to be actually be part of her body - her exoskeleton.  Her exposed skin is pale as the full moon, save for the dusky skin of her nipples and the black-skinned delta of her sex.  Her breasts and ass are both full and well-rounded, and just above her ass-cheeks there's a bulbous spider-abdomen.  The spider-girl is currently eyeing you with a strange expression and her fangs bared.");
			init02Female(VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_LOOSE, 40);
			init03BreastRows("E+");
			init04Ass(ANAL_LOOSENESS_VIRGIN,ANAL_WETNESS_DRY,30);
			init05Body("7'6",HIP_RATING_CURVY+2,BUTT_RATING_LARGE+1,LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS);
			init06Skin("dusky");
			init07Hair("red",13);
			init08Face();
			init09PrimaryStats(60,50,99,99,35,35,20);
			init10Weapon("dagger","stab",15);
			init11Armor("exoskeleton",14,"",50);
			init12Combat(200,20,.6,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(13,rand(10) + 10);
			init14WeightedDrop()
					.add(consumables.S_GOSSR,5)
					.add(useables.T_SSILK,1)
					.add(null,4);
			initX_Tail(TAIL_TYPE_SPIDER_ADBOMEN);
		}
		
	}

}