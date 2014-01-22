package classes.Scenes.Areas.Desert
{
	import classes.CoC;
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;

	/**
	 * ...
	 * @author aimozg
	 */
	public class CumWitch extends Monster 
	{

		override protected function performCombatAction():void
		{
			game.cumWitchAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.cumWitchDefeated();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.defeatedByCumWitch();
		}

		public function CumWitch()
		{
			init01Names("the ", "Cum Witch", "cumwitch", "The Cum Witch is a moderately tall woman, almost six feet in height.  Her dark ebony skin is nearly as black as pitch, though it glitters with sweat from her recent sexual activities and the fight.  She has plump lips and long, smooth blonde hair, though much of it is hidden behind a pointed, wide-brimmed hat.  Her robes are even blacker than she is, but she wields an alabaster staff that fairly sizzles with magical might.  Of course, her garments don't do much to conceal her gigantic breasts.  Though there are only two, they're large enough to dwarf the four tits most sand witches are packing.");
			init02Male(new Cock(12,2,CockTypesEnum.HUMAN),0,0,3,20);
			init02Female(VAGINA_WETNESS_WET, VAGINA_LOOSENESS_LOOSE, 20);
			init03BreastRows("E");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_NORMAL);
			init05Body(rand(12) + 55,HIP_RATING_CURVY,BUTT_RATING_LARGE);
			init06Skin("black");
			init07Hair("sandy-blonde",15);
			init08Face();
			init09PrimaryStats(35,35,35,85,55,40,30);
			init10Weapon("fists","punches");
			init11Armor("robes");
			init12Combat(100,30,.8,TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(6,rand(15) + 5);
			init14WeightedDrop().addMany(1,
								consumables.TSCROLL,
								consumables.OVIELIX,
								consumables.LACTAID,
								consumables.LABOVA_,
								consumables.W__BOOK,
								consumables.B__BOOK,
								null);
		}
		
	}

}