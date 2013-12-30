package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class ImpLord extends Monster 
	{
		override protected function performCombatAction():void
		{
			game.impLordAI();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.defeatImpLord();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.loseToAnImpLord();
		}

		public function ImpLord(mainClassPtr:*)
		{
			super(mainClassPtr);
			init01Names("the ", "imp lord", "implord", "The greater imp has an angular face, complete with curved nose and burnt red skin typical of imps.  He has no hair on his head, leaving his cold, lust-clouded, black eyes unobstructed.  Just above his long pointed ears are two curved bovine horns.  While still short, he's much taller then the average imp, being nearly four feet tall, and extremely well-muscled.  A pair of powerful wings extends out from his shoulders, however, you suspect he wouldn't be able to fly for long due to his extreme bulk.  A thick coating of fur starts at his well toned hips and works it's way down his powerful legs.  His legs end in a pair of oddly jointed, demonic hooves.  His demonic figure is completed by a thin tail that has an arrowhead shaped tip.\n\nThe greater imp, like most imps wears very little clothing, only a simple loincloth and satchel hang from his waist.  You also note that the imp has two barbell piercings in his nipples. The creature doesn't seem to have any weapons, aside from his sharp black finger nails.");
			// Imps now only have demon dicks.
			// Not sure if I agree with this, I can imagine the little fuckers abusing the
			// shit out of any potions they can get their hands on.
			init02Male(new Cock(rand(2)+11,2.5,CockTypesEnum.DEMON),2,1,3,20);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_NORMAL);
			init05Body(rand(14) + 40,HIP_RATING_BOYISH,BUTT_RATING_TIGHT,LOWER_BODY_TYPE_HOOFED);
			init06Skin("red");
			init07Hair();
			init08Face();
			init09PrimaryStats(55,40,75,42,55,35,100);
			init10Weapon("fist","punch",10);
			init11Armor("leathery skin",5);
			init12Combat(100,30,.65,Monster.TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(7,rand(15) + 25);
			initX_Wings(WING_TYPE_IMP);
			initX_Specials(5019);

		}
		
	}

}