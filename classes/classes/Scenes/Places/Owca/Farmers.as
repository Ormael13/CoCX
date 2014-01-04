package classes.Scenes.Places.Owca
{
	import classes.CoC;
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Farmers extends Monster 
	{

		override protected function performCombatAction():void
		{
			game.farmersAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.beatUpOwca();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.loseToOwca();
		}

		public function Farmers()
		{
			init01Names("the ", "farmers", "farmers", "This is a group of thirty angry villagers, almost all human-looking but for the tiny horn-like protrusions growing from their heads and the white fuzz that almost passes off as hair.  They are all armed with pitchforks or other crude farming tools they use in their everyday task.  Rebecc is staring from behind them with horrified eyes at the combat, paralyzed by the sudden turn of events.",true);
			init02Male(new Cock(9,2,CockTypesEnum.HUMAN),2,1,3);
			init02Female(VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_LOOSE);
			init03BreastRows("A");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(8) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin("red");
			init07Hair("black",15);
			init08Face();
			init09PrimaryStats(40,50,99,99,35,35,20);
			init10Weapon("pitchforks","stab");
			init11Armor("chitin");
			init12Combat(500,0,0,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(10,rand(25)+40);
			initX_Specials(5043,5044);
			initX_Horns(HORNS_DEMON);
			initX_Tail(TAIL_TYPE_DEMONIC);
		}
		
	}

}