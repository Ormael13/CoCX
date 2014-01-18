package classes.Scenes.Dungeons.DesertCave
{
	import classes.CoC;
	import classes.Monster;

	/**
	 * ...
	 * @author aimozg
	 */
	public class SandMother extends Monster 
	{

		override public function defeated(hpVictory:Boolean):void
		{
			game.defeatTheSandMother();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.loseToTheSandMother();
		}

		public function SandMother()
		{
			init01Names("the ", "Sand Mother", "sandmother", "The Sand Mother is a towering woman of imposing stature and bust.  She wears a much silkier, regal-looking robe than her sisters, and it barely serves to contain her four milk-laden breasts, straining under their jiggling weight.  Dangling around her in a way that reminds you oddly of a halo, the Sand Mother's blonde-white hair fans around her, hanging long behind her.  The queen witch is brandishing a pearly white scepter rather threateningly, though from the way she holds it, it's clear she doesn't intend to use it as a physical weapon.");
			init02Female(VAGINA_WETNESS_WET,VAGINA_LOOSENESS_LOOSE,70);
			init03BreastRows(["DD"],["DD"]);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_NORMAL,50);
			init05Body("8'6",HIP_RATING_CURVY,BUTT_RATING_LARGE);
			init06Skin("bronzed");
			init07Hair("platinum-blonde",15);
			init08Face();
			init09PrimaryStats(55,55,35,45,55,40,30);
			init10Weapon("fists","punches",0,"",150);
			init11Armor("robes",1,armorPerk,armorValue);
			init12Combat(130,20,.6,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(7,rand(15) + 55);
			this.createPerk("Resolute",0,0,0,0);
			this.createPerk("Focused",0,0,0,0);
		}
		
	}

}