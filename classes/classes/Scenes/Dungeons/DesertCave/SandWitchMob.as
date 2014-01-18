package classes.Scenes.Dungeons.DesertCave
{
	import classes.CoC;
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class SandWitchMob extends Monster 
	{

		override protected function performCombatAction():void
		{
			game.sandWitchMobAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.yoYouBeatUpSomeSandWitchesYOUMONSTER();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.loseToSammitchMob();
		}

		public function SandWitchMob()
		{
			init01Names("the ","sand witches","sandwitchmob","You are surrounded by a veritable tribe of sand witches.  Like the ones that roam the sands, they have simple robes, blond hair, and four big breasts that push at the concealing cloth immodestly.  Glowering at you hatefully, the pack of female spellcasters readies itself to drag you down with sheer numbers.",true);
			init02Female(VAGINA_WETNESS_WET,VAGINA_LOOSENESS_LOOSE);
			init03BreastRows(["DD"],["DD"]);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_NORMAL);
			init05Body(rand(12) + 55,HIP_RATING_CURVY,BUTT_RATING_LARGE);
			init06Skin("bronzed");
			init07Hair("sandy-blonde",15);
			init08Face();
			init09PrimaryStats(25,25,35,45,55,40,30);
			init10Weapon("fists","punches",0,"",150);
			init11Armor("robes",1,"",5);
			init12Combat(80,30,.5,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(4,rand(15) + 5);


		}
		
	}

}