package classes.Monsters
{
	import classes.CoC;
	import classes.Cock;
	import classes.Monster;
	/**
	 * ...
	 * @author aimozg
	 */
	public class PhoenixPlatoon extends Monster 
	{

		override protected function performCombatAction():void
		{
			game.phoenixPlatoonAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.phoenixPlatoonLosesToPC();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.phoenixPlatoonMurdersPC();
		}

		public function PhoenixPlatoon(game:CoC)
		{
			super(game);
			init01Names("the ","phoenix platoon","phoenixmob","You are faced with a platoon of heavy infantry, all armed to the teeth and protected by chain vests and shields. They look like a cross between salamander and harpy, humanoid save for crimson wings, scaled feet, and long fiery tails. They stand in a tight-knit shield wall, each phoenix protecting herself and the warrior next to her with their tower-shield. Their scimitars cut great swaths through the room as they slowly advance upon you.",true);
			init02Male(new Cock(),0,1,3);
			init02Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_LOOSE);
			init03BreastRows("D");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_DRY);
			init05Body(rand(8) + 70, HIP_RATING_AMPLE+2,BUTT_RATING_LARGE,LOWER_BODY_TYPE_LIZARD);
			init06Skin("red");
			init07Hair("black",15);
			init08Face();
			init09PrimaryStats(70,60,120,40,40,45,50);
			init10Weapon("spears","stab",20);
			init11Armor("armor",20);
			init12Combat(1000,20,.15,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(20,rand(25)+160,50);
			initX_Horns(HORNS_DRACONIC_X2);
			initX_Tail(TAIL_TYPE_HARPY);
			initX_Wings(WING_TYPE_FEATHERED_LARGE);
		}
		
	}

}