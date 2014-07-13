package classes.Scenes.NPCs
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	public class Ember extends Monster
	{
		private function emberMF(male:String,female:String):String{
			return game.emberScene.emberMF(male,female);
		}
		//The Actual Ember Fight (Z)
		//PC can't use any sexual moves in this battle. This means anything that deals or affects Ember's lust in any way.
		//It doesn't make sense to affect Ember's lust due to the nature of the combat, however it IS possible and encouraged to use lust moves when fighting Bimbo or Corrupt Ember.

		//PC shouldn't lose their turn for doing this, unless you want to penalize them Fen.
		private function emberReactsToLustiness():void {
			//(if PC uses any attack designed to increase Ember's lust)
			outputText("The dragon moans, weaving softly from side to side, eyes glazed and tongue lolling at the intimate prospect of sex... but then, to your surprise, " + emberMF("he","she") + " visibly shakes it off and recomposes " + emberMF("him","her") + "self, frowning at you.");
			outputText("\n\n\"<i>W-what do you think you're doing!?  I'm not some ordinary monster!  Don't think you can seduce me out of a battle!</i>\"");
			outputText("\n\nDespite Ember's initial display; you realize that, Ember was still a ways from " + emberMF("his","her") + " peak arousal.  The dragon flies off in a huff, irritated that you would stoop to fighting in a such a manner.");
			if(player.lib >= 50) outputText("  How boring.");
			gems = 0;
			XP = 0;
			HP = 0;
			game.cleanupAfterCombat();
		}
		//Ember Attacks:
		private function emberAttack():void {
			//Basic attack, average damage, average accuracy
			outputText("With a growl, the dragon lashes out in a ferocious splay-fingered slash, "+ emberMF("his","her") + " claws poised to rip into your flesh.  ");
			//Blind dodge change
			if(findStatusAffect(StatusAffects.Blind) >= 0 && rand(2) == 0) {
				outputText(capitalA + short + " completely misses you with a blind attack!", false);
			}
			//Miss/dodge
			else if(combatMiss() || combatEvade() || combatFlexibility() || combatMisdirect()) outputText("You dodge aside at the last second and Ember's claws whistle past you.");
			else {
				var damage:int = int((str + weaponAttack) - rand(player.tou) - player.armorDef);
				if(damage <= 0) outputText("Ember's claws scrape noisily but harmlessly off your [armor].");
				else {
					damage = player.takeDamage(damage);
					outputText("Ember's claws rip into you, leaving stinging wounds.");
					outputText(" (" + damage + ")");
				}
			}
			combatRoundOver();
		}
		
		//Dragon Breath: Very rare attack, very high damage
		private function embersSupahSpecialDragonBreath():void {
			if(findStatusAffect(StatusAffects.Blind) >= 0 && rand(2) == 0) {
				//Blind Ember: 
				outputText("The blinded dragon tracks you with difficulty as you sprint around the landscape; seeing an opportunity, you strafe around " + emberMF("his","her") + " side, planting yourself behind a large flat boulder near " + emberMF("him","her") + " and pelting " + emberMF("him","her") + " with a small rock.  The scream as the dragon turns the magical conflagration toward you, only to have it hit the rock and blow up in " + emberMF("his","her") + " face, is quite satisfying.");
				//(Ember HP damage)
				game.doDamage(50);
			}
			else {
				outputText("Ember inhales deeply, then "+ emberMF("his","her") + " jaws open up, releasing streams of fire, ice and lightning; magical rather than physical, the gaudy displays lose cohesion and amalgamate into a column of raw energy as they fly at you.");
				if(combatMiss() || combatEvade() || combatFlexibility() || combatMisdirect()) outputText("  It's a narrow thing, but you manage to throw yourself aside at the last moment.  Fortunately, the energy whirling around and tearing up the soil blinds Ember to your escape until you have recovered and are ready to keep fighting.");
				else {
					outputText("  The pain as the deadly combination washes over you is indescribable.  It's a miracle that you endure it, and even Ember looks amazed to see you still standing.");
					var damage:Number = 100 + rand(100);
					damage = player.takeDamage(damage);
					outputText(" (" + damage + ")");
				}
			}
			combatRoundOver();
		}
		
		//Tailslap: Rare attack, high damage, low accuracy
		private function emberTailSlap():void {
			//Blind dodge change
			if(findStatusAffect(StatusAffects.Blind) >= 0) {
				outputText(capitalA + short + " completely misses you with a blind tail-slap!", false);
				combatRoundOver();
				return;
			}
			outputText("Ember suddenly spins on "+ emberMF("his","her") + " heel, the long tail that splays behind " + emberMF("him","her") + " lashing out like a whip.  As it hurtles through the air towards you, your attention focuses on the set of spikes suddenly protruding from its tip!");
			if(combatMiss() || combatEvade() || combatFlexibility() || combatMisdirect() || rand(2) == 0) {
				outputText("  You ");
				if(rand(2) == 0) outputText("duck under");
				else outputText("leap over");
				outputText(" the tail at the last moment, causing Ember to lose control of "+ emberMF("his","her") + " own momentum and stumble.");
			}
			else {
				var damage:int = int((str + weaponAttack + 100) - rand(player.tou) - player.armorDef);
				outputText("  The tail slams into you with bone-cracking force, knocking you heavily to the ground even as the spines jab you wickedly.  You gasp for breath in pain and shock, but manage to struggle to your feet again.");
				damage = player.takeDamage(damage);
				outputText(" (" + damage + ")");
			}
			combatRoundOver();
		}
				
		//Dragon Force: Tainted Ember only
		private function dragonFarce():void {
			//Effect: Stuns the PC for one turn and deals some damage, not much though. (Note: PC's version of this does something different and Ember has no cooldown to use this again. Obviously do not spam or peeps will rage.)
			//Description:
			outputText("Ember bares "+ emberMF("his","her") + " teeth and releases a deafening roar; a concussive blast of force heads straight for you!");
			outputText("  Try as you might, you can't seem to protect yourself; and the blast hits you like a stone, throwing you to the ground.");
			if(player.findPerk(PerkLib.Resolute) < 0) {
				outputText("  Your head swims - it'll take a moment before you can regain your balance.");
				//Miss: You quickly manage to jump out of the way and watch in awe as the blast gouges into the ground you were standing on mere moments ago.
				player.createStatusAffect(StatusAffects.Stunned,0,0,0,0);
			}
			createStatusAffect(StatusAffects.StunCooldown,4,0,0,0);
			var damage:Number = 10 + rand(10);
			damage = player.takeDamage(damage);
			outputText(" (" + damage + ")");
			combatRoundOver();
		}
		
		override protected function performCombatAction():void
		{
			if (lust >= 40) {
				emberReactsToLustiness();
				return;
			}
			if (findStatusAffect(StatusAffects.StunCooldown) >= 0) {
				addStatusValue(StatusAffects.StunCooldown, 1, -1);
				if (statusAffectv1(StatusAffects.StunCooldown) <= 0) removeStatusAffect(StatusAffects.StunCooldown);
			}
			else if (rand(3) == 0) {
				dragonFarce();
				return;
			}
			if (rand(4) == 0) embersSupahSpecialDragonBreath();
			else if (rand(3) == 0) emberTailSlap();
			else emberAttack();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			//Hackers gonna hate. Tested and working as intended.
			if (hpVictory) game.emberScene.beatEmberSpar();
			else emberReactsToLustiness();
		}


		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.emberScene.loseToEmberSpar();
		}

		public function Ember()
		{
			this.a = " ";
			this.short = "Ember";
			this.imageName = "ember";
			this.long = "You are currently 'battling' Ember, the dragon, in a playfight.  At least, that was the intention.  The way " + emberMF("he", "she") + " lashes " + emberMF("his", "her") + " tail along the ground, with claws spread and teeth bared ferociously, makes you wonder.";
			// this.plural = false;
			var gender:int = game.flags[kFLAGS.EMBER_GENDER];
			if (gender==0){
				this.pronoun1 = "she";
				this.pronoun2 = "her";
				this.pronoun3 = "her";
			}
			if(gender == 1 || gender == 3) {
				this.createCock(16,2,CockTypesEnum.DRAGON);
				this.balls = 2;
				this.ballSize = 4;
				this.cumMultiplier = 3;
				// this.hoursSinceCum = 0;
			}
			if(gender >= 2) {
				this.createVagina(game.flags[kFLAGS.EMBER_PUSSY_FUCK_COUNT] == 0, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_LOOSE);
				createBreastRow(Appearance.breastCupInverse("F"));
			} else {
				createBreastRow(Appearance.breastCupInverse("flat"));
			}
			this.ass.analLooseness = ANAL_LOOSENESS_NORMAL;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.tallness = rand(8) + 70;
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(75, 75, 75, 75);
			initLibSensCor(50, 35, game.flags[kFLAGS.EMBER_COR]);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 30;
			this.armorName = "scales";
			this.armorDef = 40;
			this.bonusHP = 600;
			this.lust = 20;
			this.lustVuln = .25;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 15;
			this.gems = 0;
			this.hornType = HORNS_DRACONIC_X4_12_INCH_LONG;
			this.horns = 4;
			this.tailType = TAIL_TYPE_DRACONIC;
			this.drop = NO_DROP;
			checkMonster();
		}
		
	}

}
