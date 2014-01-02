package classes.Monsters
{
	import classes.CoC;
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Gnoll extends Monster 
	{


		override public function eAttack():void
		{
			game.gnollAttackText();
		}

		override protected function performCombatAction():void
		{
			game.gnollAI();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			if(hasStatusAffect("PhyllaFight") >= 0) {
				removeStatusAffect("PhyllaFight");
				game.phyllaPCBeatsGnoll();
				return;
			}
			game.defeatHyena();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(hasStatusAffect("PhyllaFight") >= 0) {
				removeStatusAffect("PhyllaFight");
				game.phyllaGnollBeatsPC();
			} else if(pcCameWorms) {
				outputText("\n\nYour foe doesn't seem put off enough to leave...");
				game.doNext(game.endLustLoss);
			} else {
				game.getRapedByGnoll();
			}
		}

		public function Gnoll()
		{
			init01Names("the ", "gnoll", "gnoll", "This lanky figure is dappled with black spots across rough, tawny fur. Wiry muscle ripples along long legs and arms, all of it seeming in perpetual frenetic motion: every moment half flinching and half lunging.  The head bears a dark muzzle curled in a perpetual leer and bright orange eyes watching with a savage animal cunning.  Between the legs hang what appears at first to be a long, thin dong; however, on closer inspection it is a fused tube of skin composed of elongated pussy lips and clitoris.  The hyena girl is sporting a pseudo-penis, and judging by the way it bobs higher as she jinks back and forth, she's happy to see you!\n\nShe wears torn rags scavenged from some other, somewhat smaller, creature, and in one hand clutches a twisted club.");
			init02Female(VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_LOOSE);
			init03BreastRows("C");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_DRY,25);
			init05Body("6'",HIP_RATING_AMPLE,BUTT_RATING_TIGHT);
			init06Skin("tawny",SKIN_TYPE_FUR);
			init07Hair("black",22);
			init08Face();
			init09PrimaryStats(80,70,75,60,65,25,60);
			init10Weapon("twisted club","smash",0,"",25);
			init11Armor("skin",2);
			init12Combat(250,30,.35,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(14,10 + rand(5));
		}
		
	}

}