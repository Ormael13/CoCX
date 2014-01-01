package classes.Monsters
{
	import classes.CoC;
	import classes.Cock;
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Ember extends Monster 
	{

		override protected function performCombatAction():void
		{
			game.emberAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.beatEmberSpar();
		}


		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.loseToEmberSpar();
		}

		public function Ember(game:CoC)
		{
			super(game);
			init01Names(" ", "Ember", "ember", "You are currently 'battling' Ember, the dragon, in a playfight.  At least, that was the intention.  The way " + game.emberMF("he", "she") + " lashes " + game.emberMF("his", "her") + " tail along the ground, with claws spread and teeth bared ferociously, makes you wonder.");
			var gender:int = game.flags[kFLAGS.EMBER_GENDER];
			if (gender==0){
				init02Genderless("she","her","her");
			}
			if(gender >= 2) {
				init02Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_LOOSE,0,game.flags[kFLAGS.EMBER_PUSSY_FUCK_COUNT] == 0);
			}
			if(gender == 1 || gender == 3) {
				init02Male(new Cock(16,2,CockTypesEnum.DRAGON),2,4,3);
			}
			init04Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_DRY);
			init05Body(rand(8) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin("red");
			init07Hair("black",15);
			init08Face();
			init09PrimaryStats(75,75,75,75,50,35,game.flags[kFLAGS.EMBER_COR]);
			init10Weapon("claws","claw",30);
			init11Armor("scales",40);
			init12Combat(600,20,.25,TEMPERMENT_LOVE_GRAPPLES);
			init13Level(15,0);
			initX_Horns(HORNS_DRACONIC_X4_12_INCH_LONG);
			initX_Tail(TAIL_TYPE_DRACONIC);
		}
		
	}

}