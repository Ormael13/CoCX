package classes.Monsters 
{
	import classes.Cock;
	import classes.Monster;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Sirius extends Monster 
	{

		override public function eAttack():void
		{
			outputText("Sirius readies his hands, undulating his body erratically with quick motions in order to catch you off-guard and strike at you.\n");
			super.eAttack();
		}


		override protected function outputPlayerDodged(dodge:int):void
		{
			outputText("With your trained eyes, you see through his feints and effectively block his first swipe, then quickly twist your body to kick him away.  He clutches his belly where you kicked him, but recovers quickly, eyes fixated on yours.\n");
		}

		override public function outputAttack(damage:int):void
		{
			if (damage<=0) {
				super.outputAttack(damage);
			} else {
				outputText("You misjudge his pattern and wind up getting slashed by a series of swipes from his sharpened nails.  He distances himself from you in order to avoid retaliation and glares at you with his piercing yellow eyes, a hint of a smile on his face. (" + damage + ")");
			}
		}

		override protected function performCombatAction():void
		{
			game.nagaSiriusRadioAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.urtaBeatsUpSiriusRadio();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.urtaLosesToSirriusSnakeRadio();
		}

		public function Sirius(mainClassPtr:*)
		{
			super(mainClassPtr);
			init01Names("", "Sirius, a naga hypnotist", "sirius", "A strange being with the upper torso of a human man topped with the head of a giant serpent stands before you, hissing in anger and occasionally letting a long, fork-tipped tongue flicker out past his lips.  An imperial-featured masculine human face regards you with an indifferent expression.  A ponytail of deep orange - almost bright red - hair falls down between his shoulders, held together by snake-styled circlets of silver, and matching bracelets of the same material and design adorn his wrists. Scales begin at his lower waist, concealing his manhood from you; he's completely naked otherwise.  His snake body is long and slender, covered in finely meshing scales of a rich orange-red shade, the red broken by a pattern of randomly thick or thin stripes of black.  His burning yellow eyes stare directly into yours, vertical slits of pupils fixated on your own as he undulates and coils in an eerily seductive manner.");
			init02Male(new Cock(14,2));
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,10);
			init05Body("5'10",HIP_RATING_AMPLE+2,BUTT_RATING_LARGE,LOWER_BODY_TYPE_NAGA);
			init06Skin("mediterranean-toned");
			init07Hair("orange",16);
			init08Face();
			init09PrimaryStats(75,70,75,92,45,35,40);
			init10Weapon("fangs","bite",25);
			init11Armor("scales",30);
			init12Combat(400,30,1,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(12,rand(5) + 8);
			initX_Specials(5109,5110,5111);

		}
		
	}

}