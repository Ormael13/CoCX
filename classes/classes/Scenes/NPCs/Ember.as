package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.Tail;
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
			SceneLib.combat.cleanupAfterCombatImpl();
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
				var damage:Number = 0;
				if (wrath >= 100) {
					wrath -= 100;
					damage += (((str + weaponAttack) * 2) - rand(player.tou) - player.armorDef);
				}
				else damage += ((str + weaponAttack) - rand(player.tou) - player.armorDef);
				if (flags[kFLAGS.EMBER_LVL_UP] >= 1) damage += (1 + (flags[kFLAGS.EMBER_LVL_UP] * 0.1));
				if (flags[kFLAGS.EMBER_LVL_UP] >= 8) damage += (1 + (flags[kFLAGS.EMBER_LVL_UP] * 0.2));
				if(damage <= 0) outputText("Ember's claws scrape noisily but harmlessly off your [armor].");
				else {
					outputText("Ember's claws rip into you, leaving stinging wounds. ");
					damage = player.takePhysDamage(damage, true);
				}
			}
		}
		
		//Dragon Breath: Very rare attack, very high damage
		private function embersSupahSpecialDragonBreath():void {
			if(hasStatusEffect(StatusEffects.Blind) && rand(2) == 0) {
				//Blind Ember: 
				outputText("The blinded dragon tracks you with difficulty as you sprint around the landscape; seeing an opportunity, you strafe around " + emberMF("his","her") + " side, planting yourself behind a large flat boulder near " + emberMF("him","her") + " and pelting " + emberMF("him","her") + " with a small rock.  The scream as the dragon turns the magical conflagration toward you, only to have it hit the rock and blow up in " + emberMF("his","her") + " face, is quite satisfying.");
				//(Ember HP damage)
				SceneLib.combat.doDamage(50);
			}
			else {
				outputText("Ember inhales deeply, then "+ emberMF("his","her") + " jaws open up, releasing streams of fire, ice and lightning; magical rather than physical, the gaudy displays lose cohesion and amalgamate into a column of raw energy as they fly at you.");
				if(player.getEvasionRoll()) outputText("  It's a narrow thing, but you manage to throw yourself aside at the last moment.  Fortunately, the energy whirling around and tearing up the soil blinds Ember to your escape until you have recovered and are ready to keep fighting.");
				else {
					var damage2:Number = 0;
					if (player.hasStatusEffect(StatusEffects.Blizzard)) {
						player.addStatusValue(StatusEffects.Blizzard, 1, -1);
						outputText("  The pain as the deadly combination washes over you is indescribable.  Despite it wasn't pure fire attack surrounding you blizzard still managed to block prt of it power and you endure it somehow making even Ember looks amazed to see you still standing. ");
						damage2 += 140 + (this.inte * 1.5) + rand(140);
					}
					else {
						outputText("  The pain as the deadly combination washes over you is indescribable.  It's a miracle that you endure it, and even Ember looks amazed to see you still standing. ");
						damage2 += 200 + (this.inte * 2) + rand(200);
					}
					if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0 || player.findPerk(PerkLib.FireAffinity) >= 0) damage2 *= 1.6;
					if (flags[kFLAGS.EMBER_LVL_UP] >= 1) damage2 *= (1 + (flags[kFLAGS.EMBER_LVL_UP] * 0.1));
					if (flags[kFLAGS.EMBER_LVL_UP] >= 8) damage2 *= (1 + (flags[kFLAGS.EMBER_LVL_UP] * 0.2));
					damage2 = Math.round(damage2);
					damage2 = player.takeMagicDamage(damage2, true);
				}
			}
		}
		
		//Tailslap: Rare attack, high damage, low accuracy
		private function emberTailSlap():void {
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind)) {
				outputText(capitalA + short + " completely misses you with a blind tail-slap!");
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
				var damage3:Number = 0;
				damage3 += ((str + weaponAttack + 100) - rand(player.tou) - player.armorDef);
				if (flags[kFLAGS.EMBER_LVL_UP] >= 1) damage3 *= (1 + (flags[kFLAGS.EMBER_LVL_UP] * 0.1));
				if (flags[kFLAGS.EMBER_LVL_UP] >= 8) damage3 *= (1 + (flags[kFLAGS.EMBER_LVL_UP] * 0.2));
				outputText("  The tail slams into you with bone-cracking force, knocking you heavily to the ground even as the spines jab you wickedly.  You gasp for breath in pain and shock, but manage to struggle to your feet again. ");
				damage3 = player.takePhysDamage(damage3, true);
			}
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
				createStatusEffect(StatusEffects.StunCooldown,2,0,0,0);
				var damage4:Number = 10 + rand(10);
				if (flags[kFLAGS.EMBER_LVL_UP] >= 1) damage4 *= (1 + (flags[kFLAGS.EMBER_LVL_UP] * 0.1));
				if (flags[kFLAGS.EMBER_LVL_UP] >= 8) damage4 *= (1 + (flags[kFLAGS.EMBER_LVL_UP] * 0.2));
				damage4 = player.takePhysDamage(damage4, true);
			}
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
			var choice:Number = rand(5);
			if (choice == 0) embersSupahSpecialDragonBreath();
			if (choice == 1) emberTailSlap();
			if (choice == 2) {
				if (hasStatusEffect(StatusEffects.StunCooldown)) emberTailSlap();
				else dragonFarce();
			}
			if (choice > 2) emberAttack();
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
				this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			}
			if(gender >= 2) {
				this.createVagina(game.flags[kFLAGS.EMBER_PUSSY_FUCK_COUNT] == 0, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_LOOSE);
				createBreastRow(Appearance.breastCupInverse("F"));
			} else {
				createBreastRow(Appearance.breastCupInverse("flat"));
			}
			if (flags[kFLAGS.EMBER_LVL_UP] < 1) {
				initStrTouSpeInte(120, 90, 100, 90);
				initWisLibSensCor(90, 50, 35, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 36;
				this.armorDef = 54;
				this.armorMDef = 54;
				this.bonusHP = 800;
				this.level = 20;
			}
			if (flags[kFLAGS.EMBER_LVL_UP] == 1) {
				initStrTouSpeInte(140, 110, 115, 105);
				initWisLibSensCor(105, 60, 40, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 43;
				this.armorDef = 73;
				this.armorMDef = 73;
				this.bonusHP = 900;
				this.level = 26;
			}
			if (flags[kFLAGS.EMBER_LVL_UP] == 2) {
				initStrTouSpeInte(165, 135, 130, 120);
				initWisLibSensCor(120, 70, 45, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 50;
				this.armorDef = 92;
				this.armorMDef = 92;
				this.bonusHP = 1000;
				this.level = 32;
			}
			if (flags[kFLAGS.EMBER_LVL_UP] == 3) {
				initStrTouSpeInte(190, 160, 145, 135);
				initWisLibSensCor(135, 80, 50, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 57;
				this.armorDef = 111;
				this.armorMDef = 111;
				this.bonusHP = 1200;
				this.level = 38;
			}
			if (flags[kFLAGS.EMBER_LVL_UP] == 4) {
				initStrTouSpeInte(220, 190, 160, 150);
				initWisLibSensCor(150, 90, 55, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 64;
				this.armorDef = 130;
				this.armorMDef = 130;
				this.bonusHP = 1400;
				this.level = 44;
			}
			if (flags[kFLAGS.EMBER_LVL_UP] == 5) {
				initStrTouSpeInte(250, 220, 175, 165);
				initWisLibSensCor(165, 100, 60, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 71;
				this.armorDef = 150;
				this.armorMDef = 150;
				this.bonusHP = 1600;
				this.level = 50;
			}
			if (flags[kFLAGS.EMBER_LVL_UP] == 6) {
				initStrTouSpeInte(280, 250, 190, 180);
				initWisLibSensCor(180, 110, 65, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 78;
				this.armorDef = 170;
				this.armorMDef = 170;
				this.bonusHP = 1800;
				this.level = 56;
			}
			if (flags[kFLAGS.EMBER_LVL_UP] == 7) {
				initStrTouSpeInte(310, 280, 205, 195);
				initWisLibSensCor(195, 120, 70, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 85;
				this.armorDef = 190;
				this.armorMDef = 190;
				this.bonusHP = 2000;
				this.level = 62;
			}
			if (flags[kFLAGS.EMBER_LVL_UP] == 8) {
				initStrTouSpeInte(340, 310, 220, 210);
				initWisLibSensCor(210, 120, 75, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 92;
				this.armorDef = 210;
				this.armorMDef = 210;
				this.bonusHP = 2200;
				this.level = 68;
			}
			if (flags[kFLAGS.EMBER_LVL_UP] == 9) {
				initStrTouSpeInte(370, 340, 235, 225);
				initWisLibSensCor(225, 120, 80, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 99;
				this.armorDef = 230;
				this.armorMDef = 230;
				this.bonusHP = 2400;
				this.level = 74;
			}
			if (flags[kFLAGS.EMBER_LVL_UP] == 10) {
				initStrTouSpeInte(410, 380, 260, 250);
				initWisLibSensCor(250, 120, 80, game.flags[kFLAGS.EMBER_COR]);
				this.weaponAttack = 106;
				this.armorDef = 260;
				this.armorMDef = 260;
				this.bonusHP = 2700;
				this.level = 80;
			}
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = rand(8) + 70;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
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
			this.horns.type = Horns.DRACONIC_X4_12_INCH_LONG;
			this.horns.count = 4;
			this.tailType = Tail.DRACONIC;
			this.drop = new ChainedDrop().add(useables.D_SCALE, 0.2);
			if (flags[kFLAGS.EMBER_LVL_UP] >= 1) this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			if (flags[kFLAGS.EMBER_LVL_UP] >= 2) {
				this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
				this.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.EMBER_LVL_UP] >= 3) this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			if (flags[kFLAGS.EMBER_LVL_UP] >= 4) {
				this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.EMBER_LVL_UP] >= 5) this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			if (flags[kFLAGS.EMBER_LVL_UP] >= 6) {
				this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
				this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.EMBER_LVL_UP] >= 7) this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			if (flags[kFLAGS.EMBER_LVL_UP] >= 8) {
				this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToAdvancedSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.EMBER_LVL_UP] >= 9) this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
			if (flags[kFLAGS.EMBER_LVL_UP] >= 10) {
				this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
				this.createPerk(PerkLib.AdvancedSelfControl, 0, 0, 0, 0);
			}
			checkMonster();
		}
		
	}

}
