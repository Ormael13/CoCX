/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	use namespace kGAMECLASS;
	
	public class Electra extends Monster
	{
		public var electraScene:ElectraFollower = game.electraScene;
		
		public function moveLightningClaw():void {
			if (game.flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1) outputText("Electra");
			else outputText("The raiju");
			outputText(" rushes at you with a mad glare trying to hit you with her claws.");
			HitOrMiss();
			HitOrMiss();
		}
		private function HitOrMiss():void {
			outputText("\n\n");
			if (game.flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1) outputText("Electra");
			else outputText("The raiju");
			outputText(" attempt to strike you with her claw.");
			if (player.getEvasionRoll()) {
				outputText("\nThrowing yourself out of the way, you manage to avoid the strike.");
			}
			else {
				var damage:Number = 0;
				damage += eBaseStrengthDamage();
				var damageLust:Number = 0;
				damageLust += Math.round(this.lib / 20);
				outputText(" You are slashed for ");
				player.takeDamage(damage, true);
				player.dynStats("lus", damageLust, "scale", false);
				outputText(" damage. The lingering electricity on her claws leaves you aroused. <b>(<font color=\"#ff00ff\">" + damageLust + "</font>)</b> lust damage.");
			}
		}
		
		public function moveStaticDischarge():void {
			if (game.flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1) outputText("Electra");
			else outputText("The raiju");
			outputText(" touches you with her claw and you feel ");
			if (player.hasStatusEffect(StatusEffects.RaijuStaticDischarge)) {
				outputText("(probably smth Lia want to write when Raiju/Electra hit PC when it already have static discharge on it).\n\n");
				player.dynStats("lus", 8 + int(player.sens) / 8);
			}
			else {
				outputText("some of her electricity rush and course through your body slowly building your arousal. This is very bad; there is no telling how long you will be able to stand it.\n\n");
				player.createStatusEffect(StatusEffects.RaijuStaticDischarge, 0, 0, 0, 0);
				player.dynStats("lus", 4 + int(player.sens) / 8);
			}
		}
		
		public function moveMasturbate():void {
			if (game.flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1) outputText("Electra");
			else outputText("The raiju");
			var damageLust:Number = 0;
			damageLust += Math.round(this.lib / 10);
			player.dynStats("lus", damageLust, "scale", false);
			outputText(" gleefully fingers herself while looking at you with a half crazed look.\n\n");
			outputText("\"<i>Do you know... How frustrating it is to be dependant on someone else to achieve release? Ohhhh soon you will find out!</i>\"\n\n");
			outputText("The display left you aroused but likely she's preparing something. <b>(<font color=\"#ff00ff\">" + damageLust + "</font>)</b> lust damage.\n\n");
			lust += maxLust() * 0.2;
			createStatusEffect(StatusEffects.RaijuUltReady,0,0,0,0);
		}
		public function moveOrgasmicLightningBolt():void {
			if (game.flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1) outputText("Electra");
			else outputText("The raiju");
			outputText(" screams in pleasure as a bolt of lightning rush out of her pussy straight toward you.");
			if (player.getEvasionRoll()) {
				outputText(" Throwing yourself out of the way, you manage to avoid the bolt.");
			}
			else {
				var damageLust:Number = 0;
				damageLust += lust * 2;
				damageLust = Math.round(damageLust);
				player.dynStats("lus", damageLust, "scale", false);
				outputText(" You are zapped clean but instead of feeling pain, you feel intense electric pleasure coursing through your body as the Raiju shares some of her unbridled arousal. <b>(<font color=\"#ff00ff\">" + damageLust + "</font>)</b> lust damage.");
			}
			lust -= lust * 0.2;
			removeStatusEffect(StatusEffects.RaijuUltReady);
			createStatusEffect(StatusEffects.AbilityCooldown1,5,0,0,0);
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.RaijuUltReady) && !hasStatusEffect(StatusEffects.AbilityCooldown1)) {
				moveOrgasmicLightningBolt();
			}
			else {
				var choice:Number = rand(5);
				if (choice < 3) moveLightningClaw();
				if (choice == 3) moveStaticDischarge();
				if (choice == 4) {
					/*if (hasStatusEffect(StatusEffects.AbilityCooldown1)) {
						if (rand(2) == 0) moveLightningClaw();
						else moveStaticDischarge();
					}
					else */moveMasturbate();
				}
			}
			combatRoundOver();
		}
		
		public function Electra() 
		{
			if (game.flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1) {
				this.a = "";
				this.short = "Electra";
				this.long = "You are fighting Electra, a lightning imbued weasel morph. She is fiercely masturbating as she looks you from a distance and you have issues figuring whenever she is going to strike.";
			}
			else {
				this.a = "the ";
				this.short = "raiju";
				this.long = "You are fighting a Raiju, a lightning imbued weasel morph. She is fiercely masturbating as she looks you from a distance and you have issues figuring whenever she is going to strike.";
			}
			createVagina(true,VAGINA_WETNESS_NORMAL,VAGINA_LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,60,0,0,0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 72;
			this.hipRating = HIP_RATING_CURVY+2;
			this.buttRating = BUTT_RATING_LARGE+1;
			this.skinTone = "light";
			this.hairColor = "blue";
			this.hairLength = 13;
			initStrTouSpeInte(60, 110, 100, 150);
			initLibSensCor(220, 80, 80);
			this.weaponName = "claw";
			this.weaponVerb="claw-slash";
			this.weaponAttack = 12 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "indecent spider silk robe";
			this.armorDef = 12 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 100;
			this.bonusLust = 50;
			this.lust = 30;
			this.lustVuln = .8;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 30;
			this.gems = 45 + rand(40);
			this.drop = new ChainedDrop().
					add(armors.INDESSR,1/10).
					add(consumables.L_DRAFT,1/4).
					add(consumables.VOLTTOP,0.7);
			this.rearBody = REAR_BODY_RAIJU_MANE;
			this.armType = ARM_TYPE_RAIJU;
			this.lowerBody = LOWER_BODY_TYPE_RAIJU;
			this.tailType = TAIL_TYPE_RAIJU;
			this.tailRecharge = 0;
			//if (flags[kFLAGS.ETNA_FOLLOWER] > 1 || flags[kFLAGS.ETNA_TALKED_ABOUT_HER] > 1) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.str += 18 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 33 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 66 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 7680;
			checkMonster();
		}
		
	}

}