/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Desert 
{
import classes.*;
import classes.BodyParts.Butt;
//import classes.BodyParts.Face;
import classes.BodyParts.Hips;
//import classes.BodyParts.LowerBody;
import classes.Scenes.Areas.Desert.AnubisScene;
import classes.Stats.Buff;
import classes.internals.*;	
	
public class Anubis extends Monster
	{
		public var anubisScene:AnubisScene = new AnubisScene();
		public var anubisGender:Number = 0;
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (this.hasVagina()) anubisGender = 1;
			anubisScene.anubisDefeated(anubisGender);
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (this.hasVagina()) anubisGender = 1;
			anubisScene.anubisWon(anubisGender);
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(3);
			if (choice == 0) anubisSoulDrain();
			if (choice == 1) {
				if (hasStatusEffect(StatusEffects.AbilityCooldown1)) anubisSoulDrain();
				else anubisFingerOfDeath();
			}
			if (choice == 2) {
				if (player.hasStatusEffect(StatusEffects.LockingCurse) && player.statusEffectv1(StatusEffects.LockingCurse) == 1) anubisSoulDrain();
				else anubisLockingCurse();
			}
		}
		
		public function anubisLockingCurse():void {
			outputText("The Anubis weaves a seal, encasing you both in a large energy dome. Looks like there is no escaping this battle anymore!");
			player.addStatusValue(StatusEffects.LockingCurse,1,1);
		}
		
		public function anubisSoulDrain():void {
			outputText("The anubis stretches h"+(this.hasVagina()?"er":"is")+" hand out and you feel your soul force being forcefully pulled out drop by drop!");
			var dmgW1:Number = this.weaponAttack;
			dmgW1 += wisdomscalingbonus() * 2;
			player.takeDarknessDamage(dmgW1);
			this.HP += Math.round(this.maxHP() * 0.2);
			if (this.HP > this.maxOverHP()) this.HP = this.maxOverHP();
			EngineCore.SoulforceChange(-Math.round(player.maxSoulforce()*0.2));
			if (player.soulforce <= 0) {
				if (this.hasVagina()) anubisGender = 1;
				anubisScene.anubisWon(anubisGender);
			}
		}
		
		public function anubisFingerOfDeath():void {
			outputText("The anubis stretches h"+(this.hasVagina()?"er":"is")+" hand out, delivering a red ray of death at you. Your body sustains substantial damage but you discover to your dismay that the ray also took away some of your hard-earned vitality and strength.");
			createStatusEffect(StatusEffects.AbilityCooldown1, 6, 0, 0, 0);
			var dmgW2:Number = this.weaponAttack * 3;
			dmgW2 += wisdomscalingbonus() * 6;
			player.takeDarknessDamage(dmgW2);
			player.addCurse("str", 10,1);
			player.addCurse("tou", 10,1);
		}
		
		public function Anubis(genderA:Number, skinA:Number) 
		{
			this.a = "the ";
			this.short = "anubi";
			//this.imageName = "gorgon";
			this.long = "You are fighting an anubi. For the rest of combat desc pest Liadri.";
			// this.plural = false;
			if (genderA == 1) {
				this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
				this.createStatusEffect(StatusEffects.BonusVCapacity, 60, 0, 0, 0);
				createBreastRow(Appearance.breastCupInverse("D"));
				this.hips.type = Hips.RATING_AMPLE + 2;
				this.butt.type = Butt.RATING_LARGE;
			}
			else {
				this.createCock(14,2);
				createBreastRow(0);
				this.hips.type = Hips.RATING_AVERAGE;
				this.butt.type = Butt.RATING_AVERAGE;
			}
			if (skinA == 1) this.bodyColor = "obsidian";
			else this.bodyColor = "dark-skinned";
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 8*12+2;
			//this.lowerBody = LowerBody.NAGA;
			this.hairColor = "green";
			this.hairLength = 16;
			initStrTouSpeInte(21, 125, 50, 50);
			initWisLibSensCor(125, 52, 43, 50);
			this.weaponName = "claws";
			this.weaponVerb="claw-slash";
			this.weaponAttack = 10;
			this.armorName = "skin";
			this.armorDef = 5;
			this.armorMDef = 60;
			this.bonusHP = 1500;
			this.bonusLust = 119;
			this.lust = 30;
			this.level = 24;
			this.gems = rand(16) + 30;
			this.drop = new WeightedDrop().
					add(useables.BANDAGE,1).
					add(weapons.JUDGE_S,2).
					add(headjewelries.DEATHPR,3);
			//this.faceType = Face.SNAKE_FANGS;
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			this.createPerk(PerkLib.LightningVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.Diehard, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}