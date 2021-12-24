/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.VolcanicCrag 
{
	import classes.*;
	import classes.internals.*;
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Camp.CampMakeWinions;
	
	public class GolemsTrueFire extends Monster
	{
		public var campMake:CampMakeWinions = new CampMakeWinions();
		
		public function backhand():void {
			outputText("The golems visage twists into a grimace of irritation, and few of them swings their hands at you in a vicious backhand.");
			var damage:Number = int (((str + weaponAttack) * 5) - rand(player.tou) - player.armorDef);
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 0.3;
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise swings!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" They hits you square in the chest from a few different angles. ");
				damage = player.takeFireDamage(damage, true);
			}
		}
		
		public function overhandSmash():void {
			outputText("Raising their fists high overhead, the golems swiftly brings them down in a punishing strike!");
			
			var damage:Number = 100 + int(((str + weaponAttack) * 5) - rand(player.tou) - player.armorDef);
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 0.3;
			damage = Math.round(damage);
			if (damage <= 0 || rand(100) < 25 || player.getEvasionRoll()) outputText(" You're able to sidestep it just in time.");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The concussive strikes impacts you with a bonecrushing force. ");
				damage = player.takeFireDamage(damage, true);
			}
		}
		
		public function fireBalls():void {
			var damage:Number = (eBaseIntelligenceDamage() + eBaseWisdomDamage()) * 2;
			damage = Math.round(damage);
			if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
			outputText("At the palm of their hands form fireballs, which they throws towards you! ");
			damage = player.takeFireDamage(damage, true);
			damage = player.takeFireDamage(damage, true);
			damage = player.takeFireDamage(damage, true);
			damage = player.takeFireDamage(damage, true);
			damage = player.takeFireDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Provoke)) {
				var choiceP:Number = rand(4);
				if (choiceP == 0) eAttack();
				if (choiceP == 1) backhand();
				if (choiceP == 2) overhandSmash();
				if (choiceP == 3) fireBalls();
			}
			else {
				if (this.HPRatio() < 0.6) {
					var choice2:Number = rand(6);
					if (choice2 < 3) eAttack();
					if (choice2 == 3) backhand();
					if (choice2 == 4) overhandSmash();
					if (choice2 == 5) fireBalls();
				}
				else if (this.HPRatio() < 0.8) {
					var choice1:Number = rand(5);
					if (choice1 < 3) eAttack();
					if (choice1 == 3) backhand();
					if (choice1 == 4) fireBalls();
				}
				else eAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			campMake.postFightGolemOptions2();
		}
		
		public function GolemsTrueFire() 
		{
			this.a = "the ";
			this.short = "true fire golems";
			this.imageName = "true fire golems";
			this.long = "You're currently fighting true fire golems. They're all around ten feet tall without any sexual characteristics, their body shaped like lizard, with bat-like wings, covered with dense layer of flames and using bare fists to smash enemies.";
			this.plural = true;
			initStrTouSpeInte(375, 335, 190, 20);
			initWisLibSensCor(20, 10, 10, 50);
			this.lustVuln = 0;
			this.tallness = 120;
			this.drop = NO_DROP;
			this.createBreastRow(0, 1);
			initGenderless();
			this.level = 80;
			this.bonusHP = 5000;
			this.additionalXP = 1000;
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 175;
			this.armorName = "flame armor";
			this.armorDef = 360;
			this.armorMDef = 360;
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}