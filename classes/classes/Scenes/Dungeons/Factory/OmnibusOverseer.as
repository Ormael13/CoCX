package classes.Scenes.Dungeons.Factory
{
	import classes.CoC;
	import classes.Cock;
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class OmnibusOverseer extends Monster 
	{

		override public function defeated(hpVictory:Boolean):void
		{
			game.omnibusVictoryEvent();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem to care...");
				doNext(game.endLustLoss);
			} else {
				game.eventParser(11046);
			}
		}

		public function OmnibusOverseer()
		{
			init01Names("the ", "Omnibus Overseer", "omnibusoverseer", "The 'woman' before you is clothed only in a single strip of fabric that wraps around her bountiful chest.  She has striking red eyes that contrast visibly with her blue skin and dark make-up.  Shiny black gloss encapsulates her kissable bubbly black lips.  Her most striking feature is her crotch, which appears neither male nor female.  She has a puffy wet vulva, but a cock-shaped protrusion sprouts from where a clit should be.");
			init02Male(new Cock(10,1.5),0,0,3);
			init02Female(VAGINA_WETNESS_DROOLING,VAGINA_LOOSENESS_NORMAL);
			init03BreastRows("DD");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(9) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_TIGHT,LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS);
			init06Skin("light purple");
			init07Hair("purple",42);
			init08Face();
			init09PrimaryStats(65,45,45,85,80,70,80);
			init10Weapon("claws","claw",10,"",150);
			init11Armor("demonic skin",15);
			init12Combat(200,20,0.75,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(8,rand(25)+10);
			init14FixedDrop();
			initX_Specials(11043,11044);
			initX_Wings(WING_TYPE_BAT_LIKE_TINY,"tiny hidden");
			initX_Tail(TAIL_TYPE_DEMONIC);

		}
		
	}

}