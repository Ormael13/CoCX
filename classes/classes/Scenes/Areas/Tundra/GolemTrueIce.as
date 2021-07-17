/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Tundra 
{
	import classes.*;
	import classes.internals.*;
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Camp.CampMakeWinions;
	
	public class GolemTrueIce extends Monster
	{
		public var campMake:CampMakeWinions = new CampMakeWinions();
		
		public function backhand():void {
			outputText("The golem visage twists into a grimace of irritation, and it flyby you swinging hand at you in a vicious backhand.");
			var damage:Number = int ((str + weaponAttack) - rand(player.tou) - player.armorDef);
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 0.3;
			if (player.hasPerk(PerkLib.FireAffinity)) damage *= 3;
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise swing!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" It hits you square in the chest. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		public function overhandSmash():void {
			outputText("Raising it fists high overhead, golem swiftly dives down bringing it fists down in a punishing strike!");
			
			var damage:Number = 100 + int((str + weaponAttack) - rand(player.tou) - player.armorDef);
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 0.3;
			if (player.hasPerk(PerkLib.FireAffinity)) damage *= 3;
			damage = Math.round(damage);
			if (damage <= 0 || rand(100) < 25 || player.getEvasionRoll()) outputText(" You're able to sidestep it just in time.");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The concussive strike impacts you with a bonecrushing force. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		public function iceSpikes():void {
			var damage:Number = (eBaseIntelligenceDamage() + eBaseWisdomDamage()) * 2;
			damage = Math.round(damage);
			if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
			outputText("At the palm of it hand form ice spike that then shots toward you! ");
			damage = player.takeIceDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Provoke)) {
				var choiceP:Number = rand(4);
				if (choiceP == 0) eAttack();
				if (choiceP == 1) backhand();
				if (choiceP == 2) overhandSmash();
				if (choiceP == 3) iceSpikes();
			}
			else {
				if (this.HPRatio() < 0.6) {
					var choice2:Number = rand(6);
					if (choice2 < 3) eAttack();
					if (choice2 == 3) backhand();
					if (choice2 == 4) overhandSmash();
					if (choice2 == 5) iceSpikes();
				}
				else if (this.HPRatio() < 0.8) {
					var choice1:Number = rand(5);
					if (choice1 < 3) eAttack();
					if (choice1 == 3) backhand();
					if (choice1 == 4) iceSpikes();
				}
				else eAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			campMake.postFightGolemOptions1();
		}
		
		public function GolemTrueIce() 
		{
			this.a = "the ";
			this.short = "true ice golem";
			this.imageName = "true ice golem";
			this.long = "You're currently fighting true ice golem. It's over twenty four feet tall without any sexual characteristics, it body shaped like gigantic gorilla, with bird-like wings, covered with with thick ice and using huge fists to smash enemies.";
			//this.plural = true;
			initStrTouSpeInte(315, 295, 175, 20);
			initWisLibSensCor(20, 10, 10, 50);
			this.lustVuln = 0;
			this.tallness = 290;
			this.drop = NO_DROP;
			this.createBreastRow(0, 1);
			initGenderless();
			this.level = 64;
			this.bonusHP = 4000;
			this.additionalXP = 800;
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 150;
			this.armorName = "ice armor";
			this.armorDef = 180;
			this.armorMDef = 180;
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}