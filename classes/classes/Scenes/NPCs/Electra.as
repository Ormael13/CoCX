/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;
	
	public class Electra extends Monster
	{
		public var electraScene:ElectraFollower = SceneLib.electraScene;
		
		public function moveLightningClaw():void {
			if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.RiverDungeonA)) outputText("Electra");
			else outputText("The raiju");
			outputText(" rushes at you with a mad glare, trying to hit you with her claws.");
			HitOrMiss();
			HitOrMiss();
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) HitOrMiss();
			else {
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 5) HitOrMiss();
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 8) HitOrMiss();
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 11) HitOrMiss();
			}
		}
		private function HitOrMiss():void {
			outputText("\n\n");
			if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.RiverDungeonA)) outputText("Electra");
			else outputText("The raiju");
			outputText(" attempts to strike you with her claw.");
			if (player.getEvasionRoll()) {
				outputText("\nThrowing yourself out of the way, you manage to avoid the strike.");
			}
			else {
				var damage:Number = 0;
				damage += eBaseStrengthDamage();
				var damageLust:Number = 0;
				damageLust += Math.round(this.lib / 20);
				if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
					damage += eBaseStrengthDamage() * 0.4;
					damageLust += Math.round(this.lib / 50);
				}
				else {
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 4) {
						damage += eBaseStrengthDamage() * 0.5;
						damageLust += Math.round(this.lib / 40);
					}
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 7) {
						damage += eBaseStrengthDamage() * 0.5;
						damageLust += Math.round(this.lib / 40);
					}
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 11) {
						damage += eBaseStrengthDamage() * 0.5;
						damageLust += Math.round(this.lib / 40);
					}
				}
				outputText(" You are slashed for ");
				player.takePhysDamage(damage, true);
				player.dynStats("lus", damageLust, "scale", false);
				outputText(" damage. The lingering electricity on her claws leaves you aroused. <b>(<font color=\"#ff00ff\">" + damageLust + "</font>)</b> lust damage.");
			}
		}
		
		public function moveStaticDischarge():void {
			if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.RiverDungeonA)) outputText("Electra");
			else outputText("The raiju");
			outputText(" touches you with her claw and you feel some of her electricity rush and course through your body, slowly building your arousal. This is very bad! There is no telling how long you will be able to stand it.");
			var discharge:Number = 4 + int(player.effectiveSensitivity()) / 8;
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 4) discharge += Math.round(player.effectiveSensitivity() / 16);
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 7) discharge += Math.round(player.effectiveSensitivity() / 16);
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 11) discharge += Math.round(player.effectiveSensitivity() / 16);
			if (player.hasStatusEffect(StatusEffects.RaijuStaticDischarge)) {
				outputText(" Her repeated touches increase the voltage!!!!");
				discharge += 4;
				if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) discharge += 1;
				else {
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 4) discharge += 2;
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 7) discharge += 2;
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 11) discharge += 2;
				}
				player.dynStats("lus", discharge);
			}
			else {
				player.createStatusEffect(StatusEffects.RaijuStaticDischarge, 0, 0, 0, 0);
				player.dynStats("lus", discharge);
			}
			outputText("\n\n");
		}
		
		public function moveMasturbate():void {
			if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.RiverDungeonA)) outputText("Electra");
			else outputText("The raiju");
			var damageLust:Number = 0;
			damageLust += Math.round(this.lib / 10);
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) damageLust += Math.round(this.lib / 25);
			else {
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 4) damageLust += Math.round(this.lib / 20);
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 7) damageLust += Math.round(this.lib / 20);
				if (flags[kFLAGS.ELECTRA_LVL_UP] >= 11) damageLust += Math.round(this.lib / 20);
			}
			player.dynStats("lus", damageLust, "scale", false);
			outputText(" gleefully fingers herself while looking at you with a half crazed look.\n\n");
			outputText("\"<i>Do you know... How frustrating it is to be dependant on someone else to achieve release? Ohhhh soon you will find out!</i>\"\n\n");
			outputText("The display left you aroused but likely she's preparing something. <b>(<font color=\"#ff00ff\">" + damageLust + "</font>)</b> lust damage.\n\n");
			lust += maxLust() * 0.2;
			createStatusEffect(StatusEffects.RaijuUltReady,0,0,0,0);
		}
		public function moveOrgasmicLightningBolt():void {
			if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.RiverDungeonA)) outputText("Electra");
			else outputText("The raiju");
			outputText(" screams in pleasure as a bolt of lightning rushes out of her pussy straight toward you.");
			if (player.getEvasionRoll()) {
				outputText(" Throwing yourself out of the way, you manage to avoid the bolt.");
			}
			else {
				var damageLust:Number = 0;
				damageLust += lust * 2;
				if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) damageLust += lust;
				else {
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 4) damageLust += lust;
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 7) damageLust += lust;
					if (flags[kFLAGS.ELECTRA_LVL_UP] >= 11) damageLust += lust;
				}
				damageLust = Math.round(damageLust);
				player.dynStats("lus", damageLust, "scale", false);
				outputText(" You are zapped clean but instead of feeling pain, you feel intense electric pleasure coursing through your body as the Raiju shares some of her unbridled arousal. <b>(<font color=\"#ff00ff\">" + damageLust + "</font>)</b> lust damage.");
			}
			lust -= lust * 0.2;
			if (lust < 0) lust = 0;
			removeStatusEffect(StatusEffects.RaijuUltReady);
			createStatusEffect(StatusEffects.AbilityCooldown1,5,0,0,0);
		}
		public function moveElectraLightningBolt():void {
			var damage:Number = 0;
			damage += eBaseIntelligenceDamage() * 1.2;
			damage += eBaseWisdomDamage() * 1.2;
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 9) {
				damage += eBaseIntelligenceDamage() * 0.6;
				damage += eBaseWisdomDamage() * 0.6;
			}
			outputText("Electra charge out energy in her hand and then fire it out in the form of a huge bolt of lightning at you.  ");
			damage = Math.round(damage);
			player.takeLightningDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.RaijuUltReady) && !hasStatusEffect(StatusEffects.AbilityCooldown1)) {
				moveOrgasmicLightningBolt();
			}
			else {
				if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
					var choice0:Number = rand(3);
					if (choice0 == 0) moveLightningClaw();
					if (choice0 == 1) moveStaticDischarge();
					if (choice0 == 2) moveMasturbate();
				}
				else if (flags[kFLAGS.ELECTRA_LVL_UP] >= 6) {
					var choice2:Number = rand(6);
					if (choice2 < 3) moveLightningClaw();
					if (choice2 == 3) moveStaticDischarge();
					if (choice2 == 4) moveElectraLightningBolt();
					if (choice2 == 5) moveMasturbate();
				}
				else {
					var choice1:Number = rand(5);
					if (choice1 < 3) moveLightningClaw();
					if (choice1 == 3) moveStaticDischarge();
					if (choice1 == 4) moveMasturbate();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) cleanupAfterCombat();
			else {
				if (flags[kFLAGS.ELECTRA_FOLLOWER] >= 2) electraScene.PlayerSexElectraPostSpar();
				else electraScene.PlayerSexElectra();
			}
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) SceneLib.dungeons.riverdungeon.defeatedByRaiju();
			else electraScene.ElectraSexPlayer();
		}
		
		public function Electra() 
		{
			if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1 && !player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				this.a = "";
				this.short = "Electra";
				this.long = "You are fighting Electra, a lightning imbued weasel morph. She is fiercely masturbating as she looks at you from a distance and you have issues figuring out whenever she is going to strike.";
			}
			else {
				this.a = "the ";
				this.short = "raiju";
				this.long = "You are fighting a Raiju, a lightning imbued weasel morph. She is fiercely masturbating as she looks at you from a distance and you have issues figuring out whenever she is going to strike.";
			}
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				initStrTouSpeInte(70, 170, 150, 160);
				initWisLibSensCor(160, 280, 200, 80);
				this.weaponAttack = 18;
				this.armorDef = 30;
				this.armorMDef = 40;
				this.bonusHP = 200;
				this.bonusLust = 520;
				this.level = 40;
			}
			else {
				if (flags[kFLAGS.ELECTRA_LVL_UP] < 2) {
					initStrTouSpeInte(60, 110, 100, 150);
					initWisLibSensCor(150, 220, 160, 80);
					this.weaponAttack = 12;
					this.armorDef = 12;
					this.armorMDef = 10;
					this.bonusHP = 100;
					this.bonusLust = 410;
					this.level = 30;
				}
				if (flags[kFLAGS.ELECTRA_LVL_UP] == 2) {
					initStrTouSpeInte(70, 125, 120, 160);
					initWisLibSensCor(160, 250, 180, 80);
					this.weaponAttack = 15;
					this.armorDef = 18;
					this.armorMDef = 20;
					this.bonusHP = 150;
					this.bonusLust = 466;
					this.level = 36;
				}
				if (flags[kFLAGS.ELECTRA_LVL_UP] == 3) {
					initStrTouSpeInte(80, 140, 140, 170);
					initWisLibSensCor(170, 280, 200, 80);
					this.weaponAttack = 18;
					this.armorDef = 24;
					this.armorMDef = 30;
					this.bonusHP = 200;
					this.bonusLust = 522;
					this.level = 42;
				}
				if (flags[kFLAGS.ELECTRA_LVL_UP] == 4) {
					initStrTouSpeInte(90, 165, 160, 180);
					initWisLibSensCor(180, 310, 220, 80);
					this.weaponAttack = 21;
					this.armorDef = 30;
					this.armorMDef = 40;
					this.bonusHP = 250;
					this.bonusLust = 578;
					this.level = 48;
				}
				if (flags[kFLAGS.ELECTRA_LVL_UP] == 5) {
					initStrTouSpeInte(100, 190, 180, 190);
					initWisLibSensCor(190, 340, 240, 80);
					this.weaponAttack = 24;
					this.armorDef = 36;
					this.armorMDef = 50;
					this.bonusHP = 300;
					this.bonusLust = 624;
					this.level = 54;
				}
				if (flags[kFLAGS.ELECTRA_LVL_UP] == 6) {
					initStrTouSpeInte(110, 215, 200, 200);
					initWisLibSensCor(200, 370, 260, 80);
					this.weaponAttack = 27;
					this.armorDef = 42;
					this.armorMDef = 60;
					this.bonusHP = 350;
					this.bonusLust = 690;
					this.level = 60;
				}
				if (flags[kFLAGS.ELECTRA_LVL_UP] == 7) {
					initStrTouSpeInte(120, 240, 220, 210);
					initWisLibSensCor(210, 400, 280, 80);
					this.weaponAttack = 30;
					this.armorDef = 48;
					this.armorMDef = 70;
					this.bonusHP = 400;
					this.bonusLust = 746;
					this.level = 66;
				}
				if (flags[kFLAGS.ELECTRA_LVL_UP] == 8) {
					initStrTouSpeInte(130, 265, 240, 220);
					initWisLibSensCor(220, 430, 300, 80);
					this.weaponAttack = 33;
					this.armorDef = 54;
					this.armorMDef = 80;
					this.bonusHP = 450;
					this.bonusLust = 802;
					this.level = 72;
				}
				if (flags[kFLAGS.ELECTRA_LVL_UP] == 9) {
					initStrTouSpeInte(140, 290, 260, 230);
					initWisLibSensCor(230, 460, 320, 80);
					this.weaponAttack = 36;
					this.armorDef = 60;
					this.armorMDef = 90;
					this.bonusHP = 500;
					this.bonusLust = 858;
					this.level = 78;
				}
				if (flags[kFLAGS.ELECTRA_LVL_UP] == 10) {
					initStrTouSpeInte(150, 315, 280, 240);
					initWisLibSensCor(240, 490, 340, 80);
					this.weaponAttack = 39;
					this.armorDef = 66;
					this.armorMDef = 100;
					this.bonusHP = 550;
					this.bonusLust = 914;
					this.level = 84;
				}
				if (flags[kFLAGS.ELECTRA_LVL_UP] == 11) {
					initStrTouSpeInte(150, 340, 300, 250);
					initWisLibSensCor(250, 520, 340, 80);
					this.weaponAttack = 42;
					this.armorDef = 72;
					this.armorMDef = 110;
					this.bonusHP = 600;
					this.bonusLust = 950;
					this.level = 90;
				}
				if (flags[kFLAGS.ELECTRA_LVL_UP] == 12) {
					initStrTouSpeInte(150, 365, 320, 260);
					initWisLibSensCor(260, 550, 340, 80);
					this.weaponAttack = 45;
					this.armorDef = 78;
					this.armorMDef = 120;
					this.bonusHP = 650;
					this.bonusLust = 986;
					this.level = 96;
				}//level up giving 2x all growns and so follow next level ups's as long each npc break lvl 100 (also makes npc use new better gear)
			}
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,60,0,0,0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.skinTone = "light";
			this.hairColor = "blue";
			this.hairLength = 13;
			this.weaponName = "claw";
			this.weaponVerb="claw-slash";
			this.armorName = "indecent spider silk robe";
			this.lust = 30;
			this.lustVuln = .8;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 500;
			this.drop = new ChainedDrop().
					add(armors.INDESSR,1/10).
					add(consumables.L_DRAFT,1/4).
					add(consumables.VOLTTOP,0.7);
			this.rearBody.type = RearBody.RAIJU_MANE;
			this.arms.type = Arms.RAIJU;
			this.lowerBody = LowerBody.RAIJU;
			this.tailType = Tail.RAIJU;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.LightningNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			if (flags[kFLAGS.ELECTRA_LVL_UP] > 1 || flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] > 1) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 2) {
				this.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobSeducer, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 3) {
				this.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobEromancer, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 4) this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 5) {
				this.createPerk(PerkLib.HalfStepToAdvancedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EromancyBeginner, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 6) {
				this.createPerk(PerkLib.AdvancedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicLibido, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 7) this.createPerk(PerkLib.HalfStepToSuperiorSelfControl, 0, 0, 0, 0);
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 8) {
				this.createPerk(PerkLib.SuperiorSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EromancyExpert, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 9) {
				this.createPerk(PerkLib.HalfStepToPeerlessSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.LegendaryLibido, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 10) this.createPerk(PerkLib.PeerlessSelfControl, 0, 0, 0, 0);
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 11) {
				this.createPerk(PerkLib.HalfStepToInhumanSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EromancyMaster, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.ELECTRA_LVL_UP] >= 12) {
				this.createPerk(PerkLib.InhumanSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.MythicalLibido, 0, 0, 0, 0);
			}
			checkMonster();
		}
		
	}

}