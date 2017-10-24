package classes.Scenes.NPCs
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;

public class Ember extends Monster
	{
		private function emberMF(male:String,female:String):String{
			return SceneLib.emberScene.emberMF(male,female);
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
			if(hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) {
				outputText(capitalA + short + " completely misses you with a blind attack!");
			}
			//Miss/dodge
			else if(player.getEvasionRoll()) outputText("You dodge aside at the last second and Ember's claws whistle past you.");
			else {
				var damage:int = int((str + weaponAttack) - rand(player.tou) - player.armorDef);
				if(damage <= 0) outputText("Ember's claws scrape noisily but harmlessly off your [armor].");
				else {
					outputText("Ember's claws rip into you, leaving stinging wounds. ");
					damage = player.takeDamage(damage, true);
				}
			}
			combatRoundOver();
		}
		
		//Dragon Breath: Very rare attack, very high damage
		private function embersSupahSpecialDragonBreath():void {
			if(hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) {
				//Blind Ember: 
				outputText("The blinded dragon tracks you with difficulty as you sprint around the landscape; seeing an opportunity, you strafe around " + emberMF("his","her") + " side, planting yourself behind a large flat boulder near " + emberMF("him","her") + " and pelting " + emberMF("him","her") + " with a small rock.  The scream as the dragon turns the magical conflagration toward you, only to have it hit the rock and blow up in " + emberMF("his","her") + " face, is quite satisfying.");
				//(Ember HP damage)
				game.doDamage(50);
			}
			else {
				outputText("Ember inhales deeply, then "+ emberMF("his","her") + " jaws open up, releasing streams of fire, ice and lightning; magical rather than physical, the gaudy displays lose cohesion and amalgamate into a column of raw energy as they fly at you.");
				if(player.getEvasionRoll()) outputText("  It's a narrow thing, but you manage to throw yourself aside at the last moment.  Fortunately, the energy whirling around and tearing up the soil blinds Ember to your escape until you have recovered and are ready to keep fighting.");
				else {
					if (player.hasStatusEffect(StatusEffects.Blizzard)) {
						player.addStatusValue(StatusEffects.Blizzard, 1, -1);
						outputText("  The pain as the deadly combination washes over you is indescribable.  Despite it wasn't pure fire attack surrounding you blizzard still managed to block prt of it power and you endure it somehow making even Ember looks amazed to see you still standing. ");
						var damage2:Number = 140 + (this.inte * 1.5) + rand(140);
						if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0 || player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 1.6;
						damage2 = player.takeDamage(damage2, true);
					}
					else {
						outputText("  The pain as the deadly combination washes over you is indescribable.  It's a miracle that you endure it, and even Ember looks amazed to see you still standing. ");
						var damage:Number = 200 + (this.inte * 2) + rand(200);
						if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0 || player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 1.6;
						damage = player.takeDamage(damage, true);
					}
				}
			}
			combatRoundOver();
		}
		
		//Tailslap: Rare attack, high damage, low accuracy
		private function emberTailSlap():void {
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind)) {
				outputText(capitalA + short + " completely misses you with a blind tail-slap!");
				combatRoundOver();
				return;
			}
			outputText("Ember suddenly spins on "+ emberMF("his","her") + " heel, the long tail that splays behind " + emberMF("him","her") + " lashing out like a whip.  As it hurtles through the air towards you, your attention focuses on the set of spikes suddenly protruding from its tip!");
			if(player.getEvasionRoll() || rand(2) == 0) {
				outputText("  You ");
				if(rand(2) == 0) outputText("duck under");
				else outputText("leap over");
				outputText(" the tail at the last moment, causing Ember to lose control of "+ emberMF("his","her") + " own momentum and stumble.");
			}
			else {
				var damage:int = int((str + weaponAttack + 100) - rand(player.tou) - player.armorDef);
				outputText("  The tail slams into you with bone-cracking force, knocking you heavily to the ground even as the spines jab you wickedly.  You gasp for breath in pain and shock, but manage to struggle to your feet again. ");
				damage = player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
				
		//Dragon Force: Tainted Ember only
		private function dragonFarce():void {
			//Effect: Stuns the PC for one turn and deals some damage, not much though. (Note: PC's version of this does something different and Ember has no cooldown to use this again. Obviously do not spam or peeps will rage.)
			//Description:
			outputText("Ember bares "+ emberMF("his","her") + " teeth and releases a deafening roar; a concussive blast of force heads straight for you!  ");
			if (player.getEvasionRoll()) {
				outputText("You quickly manage to jump out of the way and watch in awe as the blast gouges into the ground you were standing on mere moments ago.");
			}
			else {
				outputText("Try as you might, you can't seem to protect yourself; and the blast hits you like a stone, throwing you to the ground. ");
				if(player.findPerk(PerkLib.Resolute) < 0) {
					outputText("Your head swims - it'll take a moment before you can regain your balance. ");
					player.createStatusEffect(StatusEffects.Stunned,0,0,0,0);
				}
				createStatusEffect(StatusEffects.StunCooldown,4,0,0,0);
				var damage:Number = 10 + rand(10);
				damage = player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
		
		override protected function performCombatAction():void
		{
			if (lust >= (maxLust() * 0.4)) {
				emberReactsToLustiness();
				return;
			}
			if (hasStatusEffect(StatusEffects.StunCooldown)) {
				addStatusValue(StatusEffects.StunCooldown, 1, -1);
				if (statusEffectv1(StatusEffects.StunCooldown) <= 0) removeStatusEffect(StatusEffects.StunCooldown);
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
			if (hpVictory) SceneLib.emberScene.beatEmberSpar();
			else emberReactsToLustiness();
		}


		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.emberScene.loseToEmberSpar();
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
				this.createVagina(game.flags[kFLAGS.EMBER_PUSSY_FUCK_COUNT] == 0, AppearanceDefs.VAGINA_WETNESS_SLAVERING, AppearanceDefs.VAGINA_LOOSENESS_LOOSE);
				createBreastRow(Appearance.breastCupInverse("F"));
			} else {
				createBreastRow(Appearance.breastCupInverse("flat"));
			}
			if (flags[kFLAGS.EMBER_LVL_UP] < 1) {
				initStrTouSpeInte(120, 90, 100, 90);
				initLibSensCor(50, 35, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 36 + (8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorDef = 54 + (6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 800;
				this.level = 20;
				this.str += 24 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 18 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 20 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 18 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 2700;
			}
			if (flags[kFLAGS.EMBER_LVL_UP] == 1) {
				initStrTouSpeInte(130, 100, 120, 100);
				initLibSensCor(60, 40, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 43 + (9 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorDef = 74 + (8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 900;
				this.level = 30;
				this.str += 39 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 36 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 18 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 6120;
			}
			if (flags[kFLAGS.EMBER_LVL_UP] == 2) {
				initStrTouSpeInte(140, 110, 140, 110);
				initLibSensCor(70, 45, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 49 + (10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorDef = 94 + (10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 1000;
				this.level = 40;
				this.str += 42 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 33 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 42 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 33 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 8550;
			}
			if (flags[kFLAGS.EMBER_LVL_UP] == 3) {
				initStrTouSpeInte(150, 120, 160, 120);
				initLibSensCor(80, 50, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 54 + (11 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorDef = 114 + (12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 1100;
				this.level = 50;
				this.str += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 36 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 48 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 36 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 24 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 11340;
			}
			if (flags[kFLAGS.EMBER_LVL_UP] == 4) {
				initStrTouSpeInte(250, 200, 210, 200);
				initLibSensCor(100, 55, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 66 + (14 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorDef = 150 + (16 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 1500;
				this.level = 60;
				this.str += 100 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 80 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 84 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 80 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.lib += 40 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.newgamebonusHP = 26880;
			}
			this.ass.analLooseness = AppearanceDefs.ANAL_LOOSENESS_NORMAL;
			this.ass.analWetness = AppearanceDefs.ANAL_WETNESS_DRY;
			this.tallness = rand(8) + 70;
			this.hipRating = AppearanceDefs.HIP_RATING_AMPLE+2;
			this.buttRating = AppearanceDefs.BUTT_RATING_LARGE;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.armorName = "scales";
			this.bonusLust = 10 + (game.flags[kFLAGS.EMBER_AFFECTION] / 5);
			this.lust = 20;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.gems = 0;
			this.hornType = AppearanceDefs.HORNS_DRACONIC_X4_12_INCH_LONG;
			this.horns = 4;
			this.tailType = AppearanceDefs.TAIL_TYPE_DRACONIC;
			this.drop = new ChainedDrop().add(useables.D_SCALE, 0.2);
			if (flags[kFLAGS.EMBER_LVL_UP] >= 1) this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			if (flags[kFLAGS.EMBER_LVL_UP] >= 2) this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			if (flags[kFLAGS.EMBER_LVL_UP] >= 3) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
