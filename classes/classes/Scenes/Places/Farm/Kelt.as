package classes.Scenes.Places.Farm
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	public class Kelt extends Monster
	{
		//Trample - once every five turns
		private function keltTramplesJoo():void {
			outputText("Before you know what's what, Kelt is galloping toward you, kicking up a cloud of dust in his wake.  He's trying to trample you!  ");
			//Miss:
			if (player.getEvasionRoll()) {
				outputText("You roll out of the way at the last moment, avoiding his dangerous hooves.");
				combatRoundOver();
				return;
			}

			//Determine damage - str modified by enemy toughness!
			var damage:int = Math.round((str + weaponAttack) - rand(player.tou) - player.armorDef);
			
			//Block:
			if (damage <= 0) {
				outputText("Incredibly, you brace yourself and dig in your [feet].  Kelt slams into you, but you grind his momentum to a half.  His mouth flaps uncomprehendingly for a moment before he backs up, flushing from being so close to you.");
				lust += 5;
			}
			//Hit:
			else {
				outputText("You can't get out of the way in time, and you're knocked down!  Kelt tramples overtop of you!  ");
			}
			if (damage > 0) damage = player.takeDamage(damage, true);
			combatRoundOver();
		}

		//Arrow Attack
		private function keltShootBow():void {
			createStatusEffect(StatusEffects.BowCooldown,3,0,0,0);
			outputText("Kelt knocks and fires an arrow almost faster than you can track.  He's lost none of his talent with a bow, even after everything you've put him through.  ");

			//Miss:
			if (player.getEvasionRoll()) {
				outputText("You manage to avoid the missile by the skin of your teeth!");
				combatRoundOver();
				return;
			}

			var damage:Number = 0;
			damage = int((20 + str/3 + 100) + spe/3 - rand(player.tou) - player.armorDef);
			if (damage < 0) damage = 0;
			if (damage == 0) {
				outputText("You deflect the hit, preventing it from damaging you.");
				combatRoundOver();
				return;
			}
			//Hit:
			
			outputText("The arrow bites into you before you can react. ");
			damage = player.takeDamage(damage, true);
			combatRoundOver();
		}

		//Aura Arouse
		private function KellyuraAttack():void {
			var select:int = rand(3);
			//(1)
			if (select == 0) outputText("Kelt flashes his cockiest smile and gestures downward.  \"<i>Did you forget why you're here, slut?  Taking me by surprise once doesn't make you any less of a whore.</i>\"");
			//(2)
			else if (select == 2) outputText("Grinning, Kelt runs by, trailing a cloud of his musk and pheremones behind you.  You have to admit, they get you a little hot under the collar...");
			//(3)
			else {
				outputText("Kelt snarls, \"<i>Why don't you just masturbate like the slut that you are until I come over there and punish you?</i>\"  ");
				if (player.lust >= 80) outputText("Your hand moves towards your groin seemingly of its own volition.");
				else outputText("Your hands twitch towards your groin but you arrest them.  Still, the idea seems to buzz at the back of your brain, exciting you.");
			}
			game.dynStats("lus", player.lib/5 + rand(10));
			combatRoundOver();
		}

		//Attacks as normal + daydream "attack"
		//DayDream "Attack"
		private function dayDreamKelly():void {
			if (rand(2) == 0) outputText("Kelt pauses mid-draw, looking you up and down.  He licks his lips for a few moments before shaking his head to rouse himself from his lusty stupor.  He must miss the taste of your sperm.");
			else outputText("Flaring 'his' nostrils, Kelt inhales deeply, his eyelids fluttering closed as he gives a rather lady-like moan.   His hands roam over his stiff nipples, tweaking them slightly before he recovers.");
			lust += 5;
			combatRoundOver();
		}



		override protected function performCombatAction():void
		{
			if (statusEffectv1(StatusEffects.BowCooldown) > 0) {
				addStatusValue(StatusEffects.BowCooldown, 1, -1);
				if (statusEffectv1(StatusEffects.BowCooldown) <= 0) removeStatusEffect(StatusEffects.BowCooldown);
			}
			else {
				if (rand(2) == 0 && flags[kFLAGS.KELT_BREAK_LEVEL] >= 2) dayDreamKelly();
				else keltShootBow();
			}
			var select:int = rand(5);
			if (select <= 1) eAttack();
			else if (select <= 3) KellyuraAttack();
			else keltTramplesJoo();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (game.flags[kFLAGS.KELT_KILL_PLAN] == 1) {
				if (hpVictory) {
					game.farm.keltScene.fightToBeatKeltVictoryHP();
				} else {
					game.farm.keltScene.fightToBeatKeltVictoryLust();
				}
			}
			else{
				if (game.flags[kFLAGS.KELT_BREAK_LEVEL] == 1) game.farm.kelly.defeatKellyNDBREAKHIM();
				else game.farm.kelly.breakingKeltNumeroThree();
			}
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nKelt recoils for a moment before assuming a look of superiority...");
				doNext(game.combat.endLustLoss);
			} else {
				game.farm.kelly.keltFucksShitUp();
			}
		}

		public function Kelt()
		{
			var breakLevel2:Boolean = game.flags[kFLAGS.KELT_BREAK_LEVEL] == 2;
			this.a = "";
			this.short = "Kelt";
			this.imageName = "kelt";
			this.long = "Kelt has changed for the worse since your first meeting.  Gone is his muscular, barrel chest.  In its place is a softer frame, capped with tiny boobs - remnants of your last treatment.  His jaw is fairly square and chiselled (though less than before).  From the waist down, he has the body of a horse, complete with a fairly large pair of balls and a decent-sized dong.  Both are smaller than they used to be, however.  He has his bow strung and out, clearly intent on defending himself from your less than gentle touches."+(breakLevel2?"Kelt is looking less and less like the burly centaur from before, and more and more like a woman.  He looks more like an odd, androgynous hybrid than the beautiful woman you had turned him into.  He currently sports roughly B-cup breasts and a smallish, miniature horse-cock.  There's barely any hair on his human body, aside from a long mane of hair.  Each treatment seems to be more effective than the last, and you can't wait to see what happens after you tame him THIS time.":"");
			// this.plural = false;
			this.createCock(breakLevel2?12:24,3.5,CockTypesEnum.HORSE);
			this.balls = 2;
			this.ballSize = 2+rand(13);
			this.cumMultiplier = 1.5;
			this.hoursSinceCum = player.ballSize * 10;
			this.createBreastRow(Appearance.breastCupInverse(breakLevel2?"B":"A"));
			this.ass.analLooseness = ANAL_LOOSENESS_NORMAL;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,50,0,0,0);
			this.tallness = 84;
			this.hipRating = HIP_RATING_AVERAGE;
			this.buttRating = BUTT_RATING_AVERAGE+1;
			this.lowerBody = LOWER_BODY_TYPE_HOOFED;
			this.legCount = 4;
			this.skinTone = "tan";
			this.hairColor = randomChoice("black","brown");
			this.hairLength = 3;
			initStrTouSpeInte(60, 70, 40, 20);
			initLibSensCor(40, 25, 55);
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 10;
			this.armorName = "tough skin";
			this.armorDef = 4;
			this.bonusHP = 200;
			this.lust = 40;
			this.lustVuln = 0.83;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 6;
			this.gems = rand(5) + 5;
			this.tailType = TAIL_TYPE_HORSE;
			this.drop = NO_DROP;
			checkMonster();
		}
		
	}

}