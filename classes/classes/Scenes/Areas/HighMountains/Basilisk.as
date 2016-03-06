package classes.Scenes.Areas.HighMountains
{
	import classes.*;
	import classes.internals.ChainedDrop;
	import classes.GlobalFlags.*
	
	/**
	 * ...
	 * @author ...
	 */
	public class Basilisk extends Monster 
	{

		public static function basiliskSpeed(player:Player,amount:Number = 0):void {
			if (player.spe - amount < 1) {
				amount = player.spe - 1;
				if (amount < 0) amount = 0;
			}
			player.spe -= amount;
			if (player.findStatusEffect(StatusEffects.BasiliskSlow) >= 0) player.addStatusValue(StatusEffects.BasiliskSlow,1,amount);
			else player.createStatusEffect(StatusEffects.BasiliskSlow,amount,0,0,0);
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
			if (player.inte / 5 + rand(20) < 24 + player.newGamePlusMod() * 5) {
				//Immune to Basilisk?
				if (player.findPerk(PerkLib.BasiliskResistance) >= 0) {
					outputText("You can't help yourself... you glimpse the reptile's grey, slit eyes. However, no matter how much you look into the eyes, you do not see anything wrong. All you can see is the basilisk. The basilisk curses as he finds out that you're immune!", false);
				}
				else {
					outputText("You can't help yourself... you glimpse the reptile's grey, slit eyes. You look away quickly, but you can picture them in your mind's eye, staring in at your thoughts, making you feel sluggish and unable to coordinate. Something about the helplessness of it feels so good... you can't banish the feeling that really, you want to look in the basilisk's eyes forever, for it to have total control over you.", false);
					game.dynStats("lus", 3);
					//apply status here
					basiliskSpeed(player,20);
					player.createStatusEffect(StatusEffects.BasiliskCompulsion,0,0,0,0);
					flags[kFLAGS.BASILISK_RESISTANCE_TRACKER] += 2;
				}
			}
			//Failure:
			else {
				outputText("You concentrate, focus your mind and resist the basilisk's psychic compulsion.", false);
			}
			game.combat.combatRoundOver();
		}



		//Special 3: basilisk tail swipe (Small physical damage):
		private function basiliskTailSwipe():void {
			outputText("The basilisk suddenly whips its tail at you, swiping your " + player.feet() + " from under you!  You quickly stagger upright, being sure to hold the creature's feet in your vision.  ", false);
			if (damage == 0) outputText("The fall didn't harm you at all.  ", false);
			var damage:Number = int((str + 20) - Math.random()*(player.tou+player.armorDef));
			damage = player.takeDamage(damage, true);			
			game.combat.combatRoundOver();
		}

		//basilisk physical attack: With lightning speed, the basilisk slashes you with its index claws!
		//Noun: claw

		override protected function performCombatAction():void
		{
			if (player.findStatusEffect(StatusEffects.BasiliskCompulsion) < 0 && rand(3) == 0 && findStatusEffect(StatusEffects.Blind) < 0) compulsion();
			else if (rand(3) == 0) basiliskTailSwipe();
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
				doNext(game.combat.endLustLoss);
			} else {
				game.highMountains.basiliskScene.loseToBasilisk();
			}
		}

		public function Basilisk()
		{
			this.a = "the ";
			this.short = "basilisk";
			this.imageName = "basilisk";
			this.long = "You are fighting a basilisk!  From what you can tell while not looking directly at it, the basilisk is a male reptilian biped standing a bit over 6' tall.  He has a thin but ropy build, his tightly muscled yellow underbelly the only part of his frame not covered in those deceptive, camouflaging grey-green scales.  A long, whip-like tail flits restlessly through the dirt behind his skinny legs, and sharp sickle-shaped index claws decorate each hand and foot.  You don't dare to look at his face, but you have the impression of a cruel jaw, a blunt lizard snout and a crown of dull spines.";
			// this.plural = false;
			this.createCock(6,2);
			this.balls = 2;
			this.ballSize = 2;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 6*12+2;
			this.hipRating = HIP_RATING_SLENDER+1;
			this.buttRating = BUTT_RATING_AVERAGE;
			this.lowerBody = LOWER_BODY_TYPE_LIZARD;
			this.skinTone = "gray";
			this.skinType = SKIN_TYPE_SCALES;
			//this.skinDesc = Appearance.Appearance.DEFAULT_SKIN_DESCS[SKIN_TYPE_SCALES];
			this.hairColor = "none";
			this.hairLength = 0;
			initStrTouSpeInte(85, 70, 35, 70);
			initLibSensCor(50, 35, 60);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 30;
			this.armorName = "scales";
			this.armorDef = 10;
			this.armorPerk = "";
			this.armorValue = 70;
			this.bonusHP = 200;
			this.lust = 30;
			this.lustVuln = .5;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 12;
			this.gems = rand(10) + 10;
			this.drop = new ChainedDrop().add(consumables.REPTLUM,0.9);
			this.tailType = TAIL_TYPE_COW;
			this.tailRecharge = 0;
			checkMonster();
		}
		
	}

}