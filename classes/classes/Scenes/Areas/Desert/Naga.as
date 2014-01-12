package classes.Scenes.Areas.Desert
{
	import classes.CoC;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Naga extends Monster
	{

		//2a)  Ability -  Poison Bite - poisons player
		protected function nagaPoisonBiteAttack():void {
			//(Deals damage over 4-5 turns, invariably reducing 
			//your speed. It wears off once combat is over.)
			outputText("The naga strikes with the speed of a cobra, sinking her fangs into your flesh!  ", false);
			if(player.hasStatusAffect("Naga Venom") < 0) {
				outputText("The venom's effects are almost instantaneous; your vision begins to blur and it becomes increasingly harder to stand.", false);
				if(player.spe > 4) {
					//stats(0,0,-3,0,0,0,0,0);
					player.spe -= 3;
					showStatDown( 'spe' );
					// speUp.visible = false;
					// speDown.visible = true;
					player.createStatusAffect("Naga Venom",3,0,0,0);		
				}
				else {
					player.createStatusAffect("Naga Venom",0,0,0,0);		
					player.takeDamage(5+rand(5));
				}
				player.takeDamage(5+rand(5));
			}
			else {
				outputText("The venom's effects intensify as your vision begins to blur and it becomes increasingly harder to stand.", false);
				if(player.spe > 3) {
					//stats(0,0,-2,0,0,0,0,0);
					player.spe -= 2;
					showStatDown( 'spe' );
					// speUp.visible = false;
					// speDown.visible = true;
					player.addStatusValue("Naga Venom",1,2);		
				}
				else player.takeDamage(5+rand(5));
				player.takeDamage(5+rand(5));
			}
			combatRoundOver();
		}
		
		//2b)  Ability - Constrict - entangles player, raises lust 
		//every turn until you break free
		protected function nagaConstrict():void {
			outputText("The naga draws close and suddenly wraps herself around you, binding you in place! You can't help but feel strangely aroused by the sensation of her scales rubbing against your body. All you can do is struggle as she begins to squeeze tighter!", false);
			player.createStatusAffect("Naga Bind",0,0,0,0); 
			player.takeDamage(2+rand(4));
			combatRoundOver();  
		}
		
		//2c) Abiliy - Tail Whip - minus ??? HP 
		//(base it on toughness?)
		protected function nagaTailWhip():void {
			outputText("The naga tenses and twists herself forcefully.  ", false);
			//[if evaded]
			if((player.hasPerk("Evade") && rand(6) == 0)) {
				outputText("You see her tail whipping toward you and evade it at the last second. You quickly roll back onto your feet.", false);
			}
			else if(player.hasPerk("Misdirection") >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings and the movement afforded by your bodysuit, you anticipate and sidestep " + a + short + "'s tail-whip.", false);
			}
			else if(player.spe > rand(300)) {
				outputText("You see her tail whipping toward you and jump out of the way at the last second. You quickly roll back onto your feet.", false);
			}
			else {
				outputText("Before you can even think, you feel a sharp pain at your side as the naga's tail slams into you and shoves you into the sands. You pick yourself up, wincing at the pain in your side.", false);
				var damage:Number = 10;
				if(player.armorDef < 10) damage += 10 - player.armorDef;
				damage += rand(3);
				damage = player.takeDamage(damage);
				outputText(" (" + damage + ")", false);
			}
			combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.desert.nagaScene.nagaRapeChoice();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe naga's eyes go wide and she turns to leave, no longer interested in you.", false);
				game.dynStats("lus=", 0);
				doNext(game.cleanupAfterCombat);
			} else {
				game.desert.nagaScene.nagaFUCKSJOOOOOO();
			}
		}

		public function Naga(noInit:Boolean = false)
		{
			if (noInit) return;
			trace("Naga Constructor!");
			init01Names("the ", "naga", "naga", "You are fighting a naga. She resembles a beautiful and slender woman from the waist up, with dark hair hanging down to her neck. Her upper body is deeply tanned, while her lower body is covered with shiny scales, striped in a pattern reminiscent of the dunes around you. Instead of bifurcating into legs, her hips elongate into a snake's body which stretches far out behind her, leaving a long and curving trail in the sand.  She's completely naked, with her round C-cup breasts showing in plain sight. In her mouth you can see a pair of sharp, poisonous fangs and a long forked tongue moving rapidly as she hisses at you.");
			init02Female(VAGINA_WETNESS_SLAVERING,VAGINA_LOOSENESS_NORMAL,40);
			init03BreastRows("C");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,10);
			init05Body("5'10",HIP_RATING_AMPLE+2,BUTT_RATING_LARGE,LOWER_BODY_TYPE_NAGA);
			init06Skin("mediterranean-toned");
			init07Hair("brown",16);
			init08Face();
			init09PrimaryStats(28,20,35,42,55,55,40);
			init10Weapon("fist","punch",3);
			init11Armor("scales",5);
			init12Combat(0,30,1,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(2,rand(5) + 8);
			init14WeightedDrop().
					add(null,1).
					add(consumables.REPTLUM,5).
					add(consumables.SNAKOIL,4);
			initX_Specials(nagaPoisonBiteAttack,nagaConstrict,nagaTailWhip);


		}

	}

}