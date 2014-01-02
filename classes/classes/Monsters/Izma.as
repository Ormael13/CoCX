package classes.Monsters
{
	import classes.CoC;
	import classes.Cock;
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Izma extends Monster 
	{


		override public function eAttack():void
		{
			outputText("Izma slides up to you, throws a feint, and then launches a rain of jabs at you!\n", false);
			super.eAttack();
		}

		override protected function performCombatAction():void
		{
			game.IzmaAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.defeatIzma();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\n\"<i>Gross!</i>\" Izma cries as she backs away, leaving you to recover alone.");
				game.cleanupAfterCombat();
			} else {
				game.IzmaWins();
			}
		}

		public function Izma()
		{
			init01Names("", "Izma", "izma", "Izma the tigershark stands a bit over 6' tall, with orange skin bearing horizontal stripes covering most of her body.  Her silver-white hair cascades past her shoulders, draping over an impressive pair of DD-cup breasts barely restrained by a skimpy black bikini top.  Under the knee-length grass skirt below them rustles her beastly fifteen-inch penis and four-balled sack; you catch occasional glimpses of them as she moves.  She's tucked her usual reading glasses into her locker at the moment.");
			init02Male(new Cock(15,2.2),4,3);
			init02Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_LOOSE,45);
			init03BreastRows("DD");
			init04Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_DRY,30);
			init05Body("5'5",HIP_RATING_CURVY,BUTT_RATING_NOTICEABLE);
			init06Skin("striped orange");
			init07Hair("silver",20);
			init08Face();
			init09PrimaryStats(80,90,85,65,75,25,40);
			init10Weapon("clawed gauntlets","clawed punches",45);
			init11Armor("bikini and grass skirt",8);
			init12Combat(330,20,.20,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(15,rand(5) + 1);
			initX_Specials();


		}
		
	}

}