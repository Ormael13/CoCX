/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace kGAMECLASS;
	
	public class ChiChi extends Monster
	{
		public var chichiScene:ChiChiFollower = SceneLib.chichiScene;
		
		public function PentaStrike():void {
			outputText("Chi Chi unleashes a devastating combo at you. ");
			SimpleStrike();
			SimpleStrike();
			SimpleStrike();
			SimpleStrike();
			SimpleStrike();
			if (player.findPerk(PerkLib.Resolute) < 0 && flags[kFLAGS.CHI_CHI_SAM_TRAINING] < 2) {
				outputText(" You stagger under the violence of the consecutive impacts, unable to recover your balance.");
				player.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] >= 2) outputText(" Thankfully your training with her helped you learn how to counter most of these attacks and you manage to weaken her normally overwhelming blows.");
			outputText("\n\n");
		}
		public function SimpleStrike():void {
			var damage:Number = 0;
			if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] < 2 || flags[kFLAGS.CHI_CHI_SAM_TRAINING] == 3) {
				damage += rand(this.str);
				damage += eBaseDamage();
			}
			if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] == 2) {
				damage += rand(this.str) * 0.6;
				damage += eBaseDamage() * 0.6;
			}
			if (player.hasStatusEffect(StatusEffects.Stunned)) damage *= 1.5;
			var crit:Boolean = false;
			var critChance:int = 5;
			if (this.inte <= 200) critChance += this.inte / 10;
			if (this.inte > 200) critChance += 20;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText(" ");
		}
		
		public function DefensiveStance():void {
			outputText("The mouse looks to be in a rough shape. However, instead of dropping down and admitting defeat like most of your foes, she resumes standing and howls with rage, her fire increasing in size as she goes berserk. To your surprise, Chi Chi’s movement suddenly shifts as she begins to parry, dodge and block your every move with vexing efficiency. However she looks to be suffering. ");
			outputText("<b>There is an obsessed fury about it, like she is determined to defeat you at all cost. Perhaps you should surrender?</b>");
			createStatusEffect(StatusEffects.DefendMonsterVer, 50, 0.9, 0, 0);
		}
		
		public function Regeneration():void {
			outputText("To your surprise, Chi Chi’s wounds start closing!");
			createStatusEffect(StatusEffects.MonsterRegen, 5, 2, 0, 0);
		}
		
		public function SoulBlast():void {
			if (hasStatusEffect(StatusEffects.AbilityChanneled)) {
				if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) {
					outputText("When Chi Chi unleashes a torrent of soulforce energy at you, you’ve already dodged out of the way, predicting her move. The attack leaves a massive hole where you stood earlier. You are glad you moved out of the way!");
				}
				else {
					outputText("Chi Chi palms fills with a massive sphere of red energy which suddenly explodes in a devastating beam of concentrated soul force. You see the devastating torrent a mere fraction of a second before it hits you. Your defences are shattered, utterly unable to stop it as the energy overwhelms you. The blast barely leaves you intact.");
					player.takePhysDamage(5000000);
					player.takeMagicDamage(5000000);
				}
			}
			else {
				outputText("You see Chi Chi assuming a stance and waving soul art signs characteristic of a deadly attack you don’t recognise - its obviously a dangerous technique. The best option would be to dodge it.");
				createStatusEffect(StatusEffects.AbilityChanneled, 0, 0, 0, 0);
			}
		}
		
		override protected function performCombatAction():void {
			if (flags[kFLAGS.CHI_CHI_AFFECTION] < 20) {
				if (this.HPRatio() < 0.5 && !hasStatusEffect(StatusEffects.DefendMonsterVer)) DefensiveStance();
				else PentaStrike();
			}
			else {
				if (hasStatusEffect(StatusEffects.AbilityChanneled)) SoulBlast();
				else {
					var choice:Number = rand(5);
					if (choice < 3) PentaStrike();
					if (choice == 3) {
						if (hasStatusEffect(StatusEffects.MonsterRegen)) PentaStrike();
						else Regeneration();
					}
					if (choice == 4) SoulBlast();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] == 3) chichiScene.WonSparringFight();
			else if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] == 2) chichiScene.WonSecondFight();
			else chichiScene.WonFirstFight();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] == 3) chichiScene.LostSparringFight();
			else if (flags[kFLAGS.CHI_CHI_SAM_TRAINING] == 2) chichiScene.LostSecondFight();
			else chichiScene.LostFirstFight();
		}

		override public function get long():String {
			var str:String = "";
			str += "Chi Chi is a mouse morph albeit a strange one because her fist, tail and even legs are on fire. She has pink fur and bright red hairs which always seems as if about to catch fire. She wears a pair of gauntlet and a qipao characteristic of her homeland.";
			if (hasStatusEffect(StatusEffects.DefendMonsterVer)) str += " Chi Chi looks in great pain but keep fighting on with little regards for her wounds. <b>It would be smart to surrender so she doesn’t go so far as to kill herself for an arena match!</b>";
			return str;
		}
		
		public function ChiChi() 
		{
			this.a = "";
			this.short = "Master Chi Chi of the four winds";
			this.long = "";
			createVagina(true,AppearanceDefs.VAGINA_WETNESS_NORMAL,AppearanceDefs.VAGINA_LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,60,0,0,0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AppearanceDefs.ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = AppearanceDefs.ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 72;
			this.hipRating = AppearanceDefs.HIP_RATING_AMPLE+2;
			this.buttRating = AppearanceDefs.BUTT_RATING_NOTICEABLE+1;
			this.skinTone = "light";
			this.hairColor = "pinkish red";
			this.hairLength = 13;
			initStrTouSpeInte(250, 250, 240, 170);
			initWisLibSensCor(170, 100, 80, 80);
			this.weaponName = "master gloves";
			this.weaponVerb="punch";
			this.weaponAttack = 68;
			this.armorName = "qipao";
			this.armorDef = 1;
			this.bonusHP = 25000;
			this.bonusLust = 20;
			this.lust = 30;
			this.lustVuln = .8;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 50;
			this.gems = 45 + rand(40);
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 2) this.drop = new ChainedDrop().add(weapons.MASTGLO, 1);
			else this.drop = new ChainedDrop().add(consumables.MOUSECO, 0.2);//do zmiany potem
			//this.armType = ARM_TYPE_LION;
			//this.lowerBody = LOWER_BODY_TYPE_LION;
			//this.tailType = TAIL_TYPE_MANTICORE_PUSSYTAIL;
			//this.tailRecharge = 0;
			if (flags[kFLAGS.CHI_CHI_AFFECTION] < 20) this.createPerk(PerkLib.MonsterRegeneration, 5, 0, 0, 0);
			this.createPerk(PerkLib.FireAffinity, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}
}