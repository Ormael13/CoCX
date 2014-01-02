package classes.Monsters 
{
	import classes.Monster;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GnollSpearThrower extends Monster 
	{

		override public function eAttack():void
		{
			game.hyenaPhysicalAttack();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if(short == "alpha gnoll") {
				game.clearOutput();
				outputText("The gnoll alpha is defeated!  You could use her for a quick, willing fuck to sate your lusts before continuing on.  Hell, you could even dose her up with that succubi milk you took from the goblin first - it might make her even hotter.  Do you?");
				game.menu();
				game.addButton(0,"Fuck",	game.winRapeHyenaPrincess);
				game.addButton(1,"Succ Milk", game.useSuccubiMilkOnGnollPrincesses);
				game.addButton(4,"Leave",game.urtaNightSleep);
			} else {
				game.hyenaVictory();
			}
		}

		public function GnollSpearThrower()
		{
			super();
			init01Names("the ", "gnoll spear-thrower", "gnollspearthrower", "You are fighting a gnoll.  An amalgam of voluptuous, sensual lady and snarly, pissed off hyena, she clearly intends to punish you for trespassing.  Her dark-tan, spotted hide blends into a soft cream-colored fur covering her belly and two D-cup breasts, leaving two black nipples poking through the fur.  A crude loincloth is tied around her waist, obscuring her groin from view.  A leather strap cuts between her heavy breasts, holding a basket of javelins on her back.  Large, dish-shaped ears focus on you, leaving no doubt that she can hear every move you make.  Sharp, dark eyes are locked on your body, filled with aggression and a hint of lust.");
			init02Female(VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_LOOSE);
			init03BreastRows("D");
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_DRY,25);
			init05Body(72,HIP_RATING_AMPLE,BUTT_RATING_TIGHT);
			init06Skin("tawny",SKIN_TYPE_FUR);
			init07Hair("black",22);
			init08Face();
			init09PrimaryStats(85,60,100,50,65,45,60);
			init10Weapon("teeth","bite",0,"",25);
			init11Armor("skin",2);
			init12Combat(250,30,.35,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(10,10 + rand(5));
			initX_Specials(5147,5146,5145);
		}
	}
}