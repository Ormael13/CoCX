package classes.Monsters
{
	import classes.CoC;
	import classes.Cock;
	import classes.CockTypesEnum;
	import classes.Monster;

	/**
	 * Holli
	 * @author aimozg
	 */
	public class Holli extends Monster
	{
		override protected function performCombatAction():void
		{
			game.holliAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.defeatHolli();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.enjoyYourBadEndBIYAAAATCH();
		}


		override public function teased(lustDelta:Number):void
		{
			if (hasStatusAffect("Holli Burning") >= 0) {
				outputText("Holli doesn't even seem to notice, so concerned is she with defeating you before the mounting bonfire causes her any more pain.");
				lustDelta = 0;
			}
			applyTease(lustDelta);
		}

		public function Holli()
		{
			init01Names("", "Holli", "holli", "Marae's offshoot, Holli stands rooted in front of you.  Solid black eyes with golden pupils stare out at you.  Her normally-nude body is concealed inside her tree, though occasionally she will flash you the devilish grin of a sadistic temptress and the bark will split to reveal a pale, jiggling bit of flesh.  A pair of gnarled oak horns sprout from her forehead; leaves and flowers alternately bloom and wither on them as her face contorts with emotion.");
			init02Male(new Cock(12,2,CockTypesEnum.HUMAN),0,0,3,20);
			init02Female(VAGINA_WETNESS_WET,VAGINA_LOOSENESS_LOOSE,20);
			init03BreastRows("E");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_NORMAL);
			init05Body(rand(12) + 55,HIP_RATING_CURVY,BUTT_RATING_LARGE);
			init06Skin("black");
			init07Hair("sandy-blonde",15);
			init08Face();
			init09PrimaryStats(150,80,80,85,75,40,80);
			init10Weapon("branches","branchy thwack");
			init11Armor("bark",40);
			init12Combat(1000,20,.2,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(20,0);

		}
		
	}

}