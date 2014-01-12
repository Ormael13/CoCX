package classes.Scenes.Areas.HighMountains
{
	import classes.CoC;
	import classes.Cock;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Monster;
	import classes.Player;

	/**
	 * ...
	 * @author ...
	 */
	public class Basilisk extends Monster 
	{

		public static function basiliskSpeed(player:Player,amount:Number = 0):void {
			if(player.spe - amount < 1) {
				amount = player.spe - 1;
				if(amount < 0) amount = 0;
			}
			player.spe -= amount;
			if(player.hasStatusAffect("BasiliskSlow") >= 0) player.addStatusValue("BasiliskSlow",1,amount);
			else player.createStatusAffect("BasiliskSlow",amount,0,0,0);
			showStatDown( 'spe' );
			// speUp.visible = false;
			// speDown.visible = true;
		}

		//special 1: basilisk mental compulsion attack
		//(Check vs. Intelligence/Sensitivity, loss = recurrent speed loss each
		//round, one time lust increase):
		private function compulsion():void {
			outputText("The basilisk opens its mouth and, staring at you, utters words in its strange, dry, sibilant tongue.  The sounds bore into your mind, working and buzzing at the edges of your resolve, suggesting, compelling, then demanding you look into the basilisk's eyes.  ", false);
			//Success:
			if(player.inte/5 + rand(20) < 24) {
				outputText("You can't help yourself... you glimpse the reptile's grey, slit eyes. You look away quickly, but you can picture them in your mind's eye, staring in at your thoughts, making you feel sluggish and unable to coordinate. Something about the helplessness of it feels so good... you can't banish the feeling that really, you want to look in the basilisk's eyes forever, for it to have total control over you.", false);
				game.dynStats("lus", 3);
				//apply status here
				basiliskSpeed(player,20);
				player.createStatusAffect("Basilisk Compulsion",0,0,0,0);
			}
			//Failure:
			else {
				outputText("You concentrate, focus your mind and resist the basilisk's psychic compulsion.", false);
			}
			game.combatRoundOver();
		}



		//Special 3: basilisk tail swipe (Small physical damage):
		private function basiliskTailSwipe():void {
			var damage:Number = int((str + 20) - Math.random()*(player.tou+player.armorDef));
			damage = player.takeDamage(damage);
			outputText("The basilisk suddenly whips its tail at you, swiping your " + player.feet() + " from under you!  You quickly stagger upright, being sure to hold the creature's feet in your vision. (" + damage + ")", false);
			if(damage == 0) outputText("  The fall didn't harm you at all.", false);
			game.combatRoundOver();
		}

		//basilisk physical attack: With lightning speed, the basilisk slashes you with its index claws!
		//Noun: claw

		override protected function performCombatAction():void
		{
			if(player.hasStatusAffect("Basilisk Compulsion") < 0 && rand(3) == 0 && hasStatusAffect("Blind") < 0) compulsion();
			else if(rand(3) == 0) basiliskTailSwipe();
			else eAttack();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.highMountains.basiliskScene.defeatBasilisk();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe basilisk smirks, but waits for you to finish...");
				doNext(game.endLustLoss);
			} else {
				game.highMountains.basiliskScene.loseToBasilisk();
			}
		}

		public function Basilisk()
		{
			init01Names("the ", "basilisk", "basilisk", "You are fighting a basilisk!  From what you can tell while not looking directly at it, the basilisk is a male reptilian biped standing a bit over 6' tall.  It has a thin but ropy build, its tightly muscled yellow underbelly the only part of its frame not covered in those deceptive, camouflaging grey-green scales.  A long, whip-like tail flits restlessly through the dirt behind its skinny legs, and sharp sickle-shaped index claws decorate each hand and foot.  You don't dare to look at its face, but you have the impression of a cruel jaw, a blunt lizard snout and a crown of dull spines.");
			init02Male([new Cock(6,2)],2,2);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,30);
			init05Body("6'2",HIP_RATING_SLENDER+1,BUTT_RATING_AVERAGE,LOWER_BODY_TYPE_LIZARD);
			init06Skin("gray",SKIN_TYPE_SCALES);
			init07Hair("none",0);
			init08Face();
			init09PrimaryStats(85,70,35,70,50,35,60);
			init10Weapon("claws","claw",30);
			init11Armor("scales",10,"",70);
			init12Combat(200,30,.5,TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(12,rand(10) + 10);
			init14ChainedDrop().add(consumables.REPTLUM,0.9);
			initX_Tail(TAIL_TYPE_COW,0,0);
		}
		
	}

}