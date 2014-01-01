package classes.Monsters
{
	import classes.CoC;
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class HarpyMob extends Monster 
	{

		override protected function performCombatAction():void
		{
			game.harpyHordeAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.pcDefeatsHarpyHorde();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.pcLosesToHarpyHorde();
		}

		public function HarpyMob(game:CoC)
		{
			super(game);
			init01Names("the ","harpy horde","harpymob","You are surrounded by a wing of particularly large and muscular harpies, perhaps a dozen of them in total.  All of them are clad in simple brown shifts that give them good camouflage in the mountains, and are using their talon-like claws as weapons against you. While not a great threat to a champion of your ability individually, a whole brood of them together is... something else entirely.",true);
			init02Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_GAPING_WIDE);
			init03BreastRows("B");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(8) + 70,HIP_RATING_CURVY+2,BUTT_RATING_LARGE,LOWER_BODY_TYPE_HARPY);
			init06Skin("red",SKIN_TYPE_PLAIN,"feathers");
			init07Hair("black",15);
			init08Face(faceType,earType,tongueType,eyeType);
			init09PrimaryStats(50,50,120,40,60,45,50);
			init10Weapon("claw","claw",10);
			init11Armor("armor",20);
			init12Combat(1000,20,.2,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(18,rand(25)+140,50);
			initX_Horns(HORNS_DEMON);
			initX_Tail(TAIL_TYPE_DEMONIC);
			initX_Specials(special1,special2,special3);

		}
		
	}

}