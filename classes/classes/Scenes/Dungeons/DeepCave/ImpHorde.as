package classes.Scenes.Dungeons.DeepCave
{
	import classes.CoC;
	import classes.Cock;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class ImpHorde extends Monster
	{


		override protected function performCombatAction():void
		{
			game.impGangAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.impGangVICTORY();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foes don't seem put off enough to leave...");
				doNext(game.endLustLoss);
			} else {
				game.loseToImpMob();
			}
		}

		public function ImpHorde()
		{
			trace("ImpHorde Constructor!");
			init01Names("the ","imp horde","impmob","Imps of all shapes and sizes fill the room around you, keeping you completely surrounded by their myriad forms.  You can see more than a few sporting disproportionate erections, and there's even some with exotic dog-dicks, horse-pricks, and the odd spiny cat-cock.  Escape is impossible, you'll have to fight or seduce your way out of this one!",true);
			init02Male(new Cock(12,2,CockTypesEnum.DEMON),2,1);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,10);
			init05Body(36,HIP_RATING_SLENDER,BUTT_RATING_TIGHT);
			init06Skin("red");
			init07Hair("black",1);
			init08Face();
			init09PrimaryStats(20,10,25,12,45,45,100);
			init10Weapon("fists","punches");
			init11Armor("skin");
			init12Combat(450,10,.5,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(10,20 + rand(25));
			init14FixedDrop(armors.NURSECL);
			initX_Wings(WING_TYPE_IMP,"imp wings");

		}

	}

}