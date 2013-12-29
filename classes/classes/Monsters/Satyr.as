package classes.Monsters 
{
	import classes.Appearance;
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Satyr extends Monster 
	{

		override protected function performCombatAction():void
		{
			mainClassPtr.satyrAI();
		}

		public function Satyr(mainClassPtr:*)
		{
			super(mainClassPtr);
			init01Names("a ", "satyr", "satyr", "From the waist up, your opponent is perfectly human, save his curling, goat-like horns and his pointed, elven ears.  His muscular chest is bare and glistening with sweat, while his coarsely rugged, masculine features are contorted into an expression of savage lust.  Looking at his waist, you notice he has a bit of a potbelly, no doubt the fruits of heavy drinking, judging by the almost overwhelming smell of booze and sex that emanates from him.  Further down you see his legs are the coarse, bristly-furred legs of a bipedal goat, cloven hooves pawing the ground impatiently, sizable manhood swaying freely in the breeze.");
			var ballSize:Number = 2 + rand(13);
			init02Male(new Cock(rand(13) + 14,1.5 + rand(20)/2,CockTypesEnum.HUMAN),2, ballSize,1.5,mainClassPtr.player.ballSize * 10);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_NORMAL,20);
			init05Body(rand(37) + 64,HIP_RATING_AVERAGE,BUTT_RATING_AVERAGE+1,LOWER_BODY_TYPE_HOOFED);
			init06Skin("tan");
			init07Hair(Appearance.randomChoice("black","brown"),3+rand(20));
			init08Face(FACE_COW_MINOTAUR);
			init09PrimaryStats(75,70,110,70,60,35,45);
			init10Weapon("fist","punch");
			init11Armor("thick fur");
			init12Combat(300,20,0.30,Monster.TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(14,rand(25) + 25);
			initX_Tail(TAIL_TYPE_COW);
			initX_Specials(5029);

		}
		
	}

}