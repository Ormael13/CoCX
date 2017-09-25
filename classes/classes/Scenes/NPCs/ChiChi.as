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
	
	public class ChiChi extends Monster
	{
		public var chichiScene:ChiChiFollower = game.chichiScene;
		
		public function PentaStrike():void {
			outputText("Chi Chi unleashes a devastating combo at you. ");
			SimpleStrike();
			SimpleStrike();
			SimpleStrike();
			SimpleStrike();
			SimpleStrike();
			if (player.findPerk(PerkLib.Resolute) < 0) {
				outputText(" You stagger under the violence of the consecutive impacts, unable to recover your balance.");
				player.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
			}
			outputText("\n\n");
		}
		public function SimpleStrike():void {
			var damage:Number = 0;
			damage += rand(this.str) * 0.5;
			damage += eBaseDamage() * 0.5;
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
			player.takeDamage(damage, true);
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText(" ");
		}
		
		override protected function performCombatAction():void {
			/*if (this.HPRatio() < 0.75 && !hasStatusEffect(StatusEffects.)) defence;
			else */ PentaStrike();
			combatRoundOver();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			chichiScene.LostFirstFight();
		}
		
		public function ChiChi() 
		{
			this.a = "";
			this.short = "Master Chi Chi of the four winds";
			this.long = "Chi Chi is a mouse morph albeit a strange one because her fist, tail and even legs are on fire. She has pink fur and bright red hairs which always seems as if about to catch fire. She wears a pair of gauntlet and a qipao characteristic of her homeland.";
			createVagina(true,VAGINA_WETNESS_NORMAL,VAGINA_LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,60,0,0,0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 72;
			this.hipRating = HIP_RATING_CURVY+2;
			this.buttRating = BUTT_RATING_LARGE+1;
			this.skinTone = "light";
			this.hairColor = "pinkish red";
			this.hairLength = 13;
			initStrTouSpeInte(250, 250, 240, 170);
			initLibSensCor(100, 80, 80);
			this.weaponName = "master gloves";
			this.weaponVerb="punch";
			this.weaponAttack = 68 + (14 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "qipao";
			this.armorDef = 1 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 25000;
			this.bonusLust = 20;
			this.lust = 30;
			this.lustVuln = .8;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 50;
			this.gems = 45 + rand(40);
			this.drop = new ChainedDrop().add(consumables.MOUSECO, 0.2);//do zmiany potem
			//this.armType = ARM_TYPE_LION;
			//this.lowerBody = LOWER_BODY_TYPE_LION;
			//this.tailType = TAIL_TYPE_MANTICORE_PUSSYTAIL;
			//this.tailRecharge = 0;
			if (flags[kFLAGS.CHI_CHI_AFFECTION] < 20) this.createPerk(PerkLib.MonsterRegeneration, 5, 0, 0, 0);
			this.createPerk(PerkLib.FireAffinity, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.str += 75 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 75 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 72 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 51 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 18180;
			checkMonster();
		}
		
	}
}