package classes.Monsters
{
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;

	/**
	 * ...
	 * @author aimozg
	 */
	public class Kitsune extends Monster
	{

		override protected function performCombatAction():void
		{
			mainClassPtr.kitsuneAI();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			mainClassPtr.defeatTheKitsunes();
		}

		public function Kitsune(mainClassPtr:*, hairColor:String)
		{
			super(mainClassPtr);

			if (rand(3) != 2) mainClassPtr.flags[kFLAGS.redheadIsFuta] = 1;
			init01Names("a ", "kitsune", "kitsune",
					"A kitsune stands in front of you, about five and a half feet tall.  She has a head of " + ({
						"blonde": "long flaxen",
						"black": "lustrous, ass-length black",
						"red": "unkempt, shoulder-length reddish"
					}[hairColor]) +
							" hair.  She appears mostly human, except for a pair of large, furry ears poking through her hair and six luxurious silky tails swaying in the air behind her.  Her robes are revealing but comfortable-looking, hugging her voluptuous curves and exposing large swaths of tattooed skin.  A layer of ornate tattoos covers patches of her exposed flesh, accentuating her feminine curves nicely, and each movement brings a pleasant jiggle from her plump backside and large breasts.");
			if (hairColor=="red" && mainClassPtr.flags[kFLAGS.redheadIsFuta] == 1) {
				init02Male(new Cock(rand(13) + 14,1.5 + rand(20)/2,CockTypesEnum.HUMAN),
						2,2 + rand(13),1.5,player.ballSize * 10);
			}
			init02Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_NORMAL,20);
			init03BreastRows("D");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_NORMAL,20);
			init05Body(rand(24) + 60,HIP_RATING_AMPLE,BUTT_RATING_AVERAGE+1);
			init06Skin("pale");
			init07Hair(hairColor,13 + rand(20));
			init08Face();
			init09PrimaryStats(35,45,90,95,60,65,45);
			init10Weapon("claws","punch");
			init11Armor("skin");
			init12Combat(120,20,0.9,Monster.TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(6,rand(10) + 10);
			initX_Tail(TAIL_TYPE_FOX);
			initX_Specials(5029);

		}

	}

}