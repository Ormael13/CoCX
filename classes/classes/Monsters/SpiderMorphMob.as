package classes.Monsters
{
	import classes.CoC;
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class SpiderMorphMob extends Monster 
	{

		override protected function performCombatAction():void
		{
			game.spiderHordeAI();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.beatSpiderMob();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe spiders smile to one at another as they watch your display, then close in...");
				game.doNext(game.endLustLoss);
			} else {
				game.loseToSpiderMob();
			}
		}

		public function SpiderMorphMob()
		{
			init01Names("the ","mob of spiders-morphs","spidermorphmob","You are fighting a horde of spider-morphs!  A group of some two-dozen spiders and driders approaches you, all baring their teeth.  A pair of large, powerful driders lead the group, their corrupt, lusty stares sending shivers up your spine.  While "+(player.level <= 13?"you'd never face such a large horde on your own":"you could probably handle them alone")+", you have a powerful ally in this fight - the dragoness Kiha!",true);
			init02Male(new Cock(9,2,CockTypesEnum.HUMAN),2,1,3);
			init02Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_LOOSE);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(8) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin("red");
			init07Hair("black",15);
			init08Face();
			init09PrimaryStats(60,50,99,99,35,35,20);
			init10Weapon("claws","claws");
			init11Armor("chitin");
			init12Combat(1200,0,.2,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(18,rand(25)+40);
			initX_Specials(5043,5044);
			initX_Tail(TAIL_TYPE_SPIDER_ADBOMEN);
		}
		
	}

}