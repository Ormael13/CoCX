package classes.Monsters
{
	import classes.CoC;
	import classes.Cock;
	import classes.GlobalFlags.kFLAGS;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class SandTrap extends Monster 
	{

		override protected function performCombatAction():void
		{
			if (hasStatusAffect("level") >= 0) {
				game.sandTrapAI();
			} else super.performCombatAction();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.pcBeatsATrap();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nThe sand trap seems bemused by the insects your body houses...");
				game.doNext(game.endLustLoss);
			} else {
				game.sandtrapmentLoss(true);
			}
		}

		public function SandTrap()
		{
			//1/3 have fertilized eggs!
			if(rand(3) == 0) this.createStatusAffect("Fertilized",0,0,0,0);
			init01Names("the ", game.silly()?"sandtrap":"sand tarp", "sandtrap", "You are fighting the sandtrap.  It sits half buried at the bottom of its huge conical pit, only its lean human anatomy on show, leering at you from beneath its shoulder length black hair with its six equally sable eyes.  You cannot say whether its long, soft face with its pointed chin is very pretty or very handsome - every time the creature's face moves, its gender seems to shift.  Its lithe, brown flat-chested body supports four arms, long fingers playing with the rivulets of powder sand surrounding it.  Beneath its belly you occasionally catch glimpses of its insect half: a massive sand-coloured abdomen which anchors it to the desert, with who knows what kind of anatomy.");
			init02Male(new Cock(10,2,CockTypesEnum.HUMAN),2,4,3);
			init03BreastRows([0,0]);
			init04Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_DRY);
			init05Body(rand(8) + 150,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin("fair");
			init07Hair("black",15);
			init08Face();
			init09PrimaryStats(55,10,45,55,60,45,50);
			init10Weapon("claws","claw",10);
			init11Armor("chitin",20);
			init12Combat(100,20,.55,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(4,2 + rand(5));
			initX_Tail(TAIL_TYPE_DEMONIC);
		}
		
	}

}