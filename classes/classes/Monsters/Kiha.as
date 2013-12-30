package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Kiha extends Monster 
	{

		override protected function handleFear():Boolean
		{
			removeStatusAffect("Fear");
			outputText("Kiha shudders for a moment, then looks your way with a clear head.  \"<i>Fear was the first thing the demons taught us to overcome.  Do you think it would stay my blade?</i>\"\n", false);
			return true;
		}

		override protected function handleBlind():Boolean
		{
			return true;
		}


		override protected function postAttack(damage:int):void
		{
			super.postAttack(damage);
			var flame:int = 15 + rand(6);
			flame = player.takeDamage(flame);
			outputText("\nAn afterwash of flames trails behind her blow, immolating you! (" + flame + ")", false);
		}

		override protected function performCombatAction():void
		{
			game.kihaAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if(hasStatusAffect("spiderfight") >= 0)
				game.playerBeatsUpKihaPreSpiderFight();
			else if(hasStatusAffect("domfight") >= 0)
				game.pcWinsDomFight();
			else if(hasStatusAffect("spar") >= 0)
				game.winSparWithKiha();
			else game.kihaVictoryIntroduction();
		}


		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(hasStatusAffect("spiderfight") >= 0)
				game.loseKihaPreSpiderFight();
			else if(hasStatusAffect("domfight") >= 0)
				game.pcLosesDomFight();
			else if(hasStatusAffect("spar") >= 0)
				game.sparWithFriendlyKihaLose();
			else if (pcCameWorms){
				outputText("\n\nKiha seems visibly disturbed by your infection, enough that she turns to leave.");
				game.doNext(game.endLustLoss);
			} else {
				game.kihaLossIntro();
			}
		}

		public function Kiha(mainClassPtr:*)
		{
			super(mainClassPtr);
			init01Names("", "Kiha", "kiha", "Kiha is standing across from you, holding a double-bladed axe that's nearly as big as she is.  She's six feet tall, and her leathery wings span nearly twelve feet extended.  Her eyes are pure crimson, save for a black slit in the center, and a pair of thick draconic horns sprout from her forehead, arcing over her ruby-colored hair to point behind her.  Dim red scales cover her arms, legs, back, and strong-looking tail, providing what protection they might  to large areas of her body.  The few glimpses of exposed skin are dark, almost chocolate in color, broken only by a few stray scales on the underside of her bosom and on her cheekbones.  Her vagina constantly glistens with moisture, regardless of her state of arousal.  Despite her nudity, Kiha stands with the confidence and poise of a trained fighter.");
			init02Female(VAGINA_WETNESS_DROOLING,VAGINA_LOOSENESS_NORMAL,40);
			init03BreastRows("D");
			init04Ass(ANAL_LOOSENESS_LOOSE,ANAL_WETNESS_DRY,40);
			init05Body("6'1",HIP_RATING_AMPLE,BUTT_RATING_AVERAGE+1,LOWER_BODY_TYPE_HOOFED);
			init06Skin("dark",SKIN_TYPE_SCALES,"skin and scales");
			init07Hair("red",3);
			init08Face();
			init09PrimaryStats(65,60,85,60,50,45,66);
			init10Weapon("double-bladed axe","fiery cleave",25);
			init11Armor("thick scales",30);
			init12Combat(430,10,0.4,TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(16,rand(15) + 95);
			initX_Wings(WING_TYPE_IMP,"huge");
			initX_Tail(TAIL_TYPE_LIZARD);

		}
		
	}

}