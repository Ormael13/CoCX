package classes.Monsters
{
	import classes.CoC;
	import classes.Cock;
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Minerva extends Monster 
	{

		override protected function performCombatAction():void
		{
			game.minervaAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.beatUpDatSharpie();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.loseToMinerva();
		}

		public function Minerva()
		{
			init01Names("", "Minerva", "minerva", "You're fighting the tainted siren, Minerva.  Standing around eight feet and wielding a weapon just as tall, she is a force to be reckoned with.  Her skin is a dark navy blue, though her belly, neck and inner thighs are as white as the clouds in the sky, and a golden piecing decorates her navel.  Orange and white stripes adorn her legs, tail and back.  Two large wings sprout from her back, their feathers an attention-grabbing red and orange mix.  She wears a tube-top that hold back her double d-cups, and short shorts around her wide waist that seem to be holding back a huge bulge.\n\nHer weapon is a halberd, made from a shiny, silvery metal, and seems to have an unnatural glow to it.");
			init02Male(new Cock(16,3),2,3,3);
			init02Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_NORMAL);
			init03BreastRows("DD");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY);
			init05Body("8'4",HIP_RATING_CURVY,BUTT_RATING_LARGE+1);
			init06Skin("blue");
			init07Hair("red",25);
			init08Face();
			init09PrimaryStats(50,65,95,75,30,25,45);
			init10Weapon("halberd","slash",30,"",150);
			init11Armor("comfortable clothes",1,"",5);
			init12Combat(470,20,.2,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(16,rand(25)+10,50);
			initX_Wings(WING_TYPE_HARPY,"fluffy feathery");
			initX_Specials(11020,11021,11022);

		}
		
	}

}