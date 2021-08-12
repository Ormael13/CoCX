/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Dungeons.RiverDungeon 
{

import classes.*;
import classes.internals.*;
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

public class EarthElemental extends Monster
	{
		public function baseElementalAttack():void {
			outputText(""+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Golem":"Earth elemental")+" solidifies its fist within hardened clay before jabbing at you.");
			var damage:Number = inte + wis;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 3);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise punch!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" It hits you square in the chest. ");
				damage = player.takeEarthDamage(damage, true);
			}
		}
		
		public function fluffyOfPunches():void {
			outputText(""+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Golem":"Earth elemental")+" wraps its fists within several jagged rocks before launching a flurry of jabs against you.");
			var damage:Number = inte + wis;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 2);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath it avoiding all punches!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The strikes connect, hitting you directly in the chest. ");
				damage = player.takeEarthDamage(damage, true);
				damage = player.takeEarthDamage(damage, true);
			}
		}
		
		public function subbossSpecial():void {
			outputText("The golem unearths the ground beneath itself, reshaping the stone into razor-sharp rocks. It thrusts its arms down, sending the rocks toward you.");
			if (player.getEvasionRoll()) outputText(" You slide underneath the barrage!");
			else {
				var damage:Number = inte + wis;
				damage *= 5;
				damage = Math.round(damage);
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The razor-like rocks cut into you. ");
				damage = player.takeEarthDamage(damage, true);
				damage = player.takeEarthDamage(damage, true);
				damage = player.takeEarthDamage(damage, true);
				damage = player.takeEarthDamage(damage, true);
				damage = player.takeEarthDamage(damage, true);
				damage = player.takeEarthDamage(damage, true);
				damage = player.takeEarthDamage(damage, true);
				damage = player.takeEarthDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP1:Number = rand(5);
					if (choiceP1 == 0) fluffyOfPunches();
					if (choiceP1 == 1) baseElementalAttack();
					if (choiceP1 > 1) subbossSpecial();
				}
				else {
					var choice11:Number = rand(6);
					if (choice11 < 2) fluffyOfPunches();
					if (choice11 == 2 || choice11 == 3) baseElementalAttack();
					if (choice11 > 3) subbossSpecial();
				}
			}
			else {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP:Number = rand(5);
					if (choiceP < 4) fluffyOfPunches();
					if (choiceP == 4) baseElementalAttack();
				}
				else {
					var choice1:Number = rand(6);
					if (choice1 < 3) fluffyOfPunches();
					if (choice1 == 3 || choice1 == 4) baseElementalAttack();
					if (choice1 == 5) eAttack();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) SceneLib.dungeons.riverdungeon.defeatEarthElementalSubBoss();
			else cleanupAfterCombat();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) SceneLib.dungeons.riverdungeon.defeatedByEarthElementalSubBoss();
			else SceneLib.dungeons.riverdungeon.defeatedByEarthElemental();
		}
		
		public function EarthElemental() 
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 0) {
				this.short = "earth elemental";
				this.imageName = "earth elemental";
				this.long = "You're currently fighting earth elemental. It's a four foot tall creature of made of rocks, currently using its bare fists to fight.";
				this.tallness = 48;
				initStrTouSpeInte(10, 40, 40, 40);
				initWisLibSensCor(40, 10, 20, 50);
				this.weaponAttack = 5;
				this.armorDef = 10;
				this.armorMDef = 30;
				this.level = 12;
				this.bonusHP = 500;
				this.additionalXP = 50;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 1) {
				this.short = "earth elemental";
				this.imageName = "earth elemental";
				this.long = "You're currently fighting earth elemental. It's a four foot, three inch tall creature of made of rocks, currently using its bare fists to fight.";
				this.tallness = 51;
				initStrTouSpeInte(12, 22, 42, 50);
				initWisLibSensCor(50, 10, 25, 50);
				this.weaponAttack = 7;
				this.armorDef = 15;
				this.armorMDef = 35;
				this.level = 15;
				this.bonusHP = 600;
				this.additionalXP = 75;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 2) {
				this.short = "earth elemental";
				this.imageName = "earth elemental";
				this.long = "You're currently fighting earth elemental. It's a four and a half foot tall creature of made of rocks, currently using its bare fists to fight.";
				this.tallness = 54;
				initStrTouSpeInte(14, 44, 44, 60);
				initWisLibSensCor(60, 10, 30, 50);
				this.weaponAttack = 9;
				this.armorDef = 20;
				this.armorMDef = 40;
				this.level = 18;
				this.bonusHP = 700;
				this.additionalXP = 100;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 3) {
				this.short = "earth elemental";
				this.imageName = "earth elemental";
				this.long = "You're currently fighting earth elemental. It's a four foot, nine inch tall creature of made of rocks, currently using its bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(16, 46, 46, 70);
				initWisLibSensCor(70, 10, 35, 50);
				this.weaponAttack = 11;
				this.armorDef = 25;
				this.armorMDef = 45;
				this.level = 21;
				this.bonusHP = 800;
				this.additionalXP = 125;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) {
				this.short = "golem";
				this.imageName = "earth golem";
				this.long = "You're currently fighting 'female' golem. It's a nine foot tall creature of made of rocks, currently using its bare fists to fight.";
				this.tallness = 108;
				initStrTouSpeInte(24, 69, 69, 105);
				initWisLibSensCor(105, 15, 55, 50);
				this.weaponAttack = 17;
				this.armorDef = 40;
				this.armorMDef = 70;
				this.level = 24;
				this.bonusHP = 1200;
				this.additionalXP = 190;
			}
			this.a = "the ";
			this.plural = false;
			this.lustVuln = 0;
			this.drop = new ChainedDrop()
					.add(useables.ELSHARD, 1);
			this.createBreastRow(0, 1);
			initGenderless();
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.armorName = "earth skin";
			this.createPerk(PerkLib.EnemyElementalType, 0, 0, 0, 0);
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) {
				this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
				this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			}
			checkMonster();
		}
		
	}

}