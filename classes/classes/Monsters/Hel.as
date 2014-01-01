package classes.Monsters
{
	import classes.CoC;
	import classes.Monster;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Hel extends Monster 
	{

		override protected function performCombatAction():void
		{
			game.helAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if(hasStatusAffect("sparring") >= 0) game.PCBeatsUpSalamanderSparring();
			else game.beatUpHel();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nHelia waits it out in stoic silence...");
				game.doNext(game.endLustLoss);
			} else {
				if(hasStatusAffect("sparring") >= 0) game.loseToSparringHeliaLikeAButtRapedChump();
				else game.loseToSalamander();
			}
		}

		public function Hel(game:CoC)
		{
			super(game);
			var met:Boolean = game.flags[kFLAGS.HEL_TALKED_ABOUT_HER] == 1;
			init01Names(met?"":"the ",met?"Hel":"salamander","hel","You are fighting a (literally) smoking hot salamander – a seven foot tall woman with crimson scales covering her legs, back, and forearms, with a tail swishing menacingly behind her, ablaze with a red-hot fire.  Her red hair whips wildly around her slender shoulders, occasionally flitting over her hefty E-cup breasts, only just concealed within a scale-covered bikini top.  Bright red eyes focus on you from an almost-human face as she circles you, ready to close in for the kill.  Her brutal, curved sword is raised to her side, feinting at you between genuine attacks.");
			init02Female(VAGINA_WETNESS_NORMAL,VAGINA_LOOSENESS_NORMAL,85);
			init03BreastRows("E+");
			init04Ass(ANAL_LOOSENESS_VIRGIN,ANAL_WETNESS_DRY,85);
			init05Body(90,HIP_RATING_CURVY+2, BUTT_RATING_LARGE+1);
			init06Skin("dusky");
			init07Hair("red",13);
			init08Face();
			init09PrimaryStats(80,70,75,60,65,25,30);
			init10Weapon("sword","slashing blade",20);
			init11Armor("scales",14,"",50);
			init12Combat(275,30,.35,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(16,10 + rand(5));
			initX_Tail(TAIL_TYPE_LIZARD,0,0);
			this.createStatusAffect("keen",0,0,0,0);
		}
		
	}

}