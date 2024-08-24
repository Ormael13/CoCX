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
				player.takeEarthDamage(damage, true);
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
				player.takeEarthDamage(damage, true);
				player.takeEarthDamage(damage, true);
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
				player.takeEarthDamage(damage, true);
				player.takeEarthDamage(damage, true);
				player.takeEarthDamage(damage, true);
				player.takeEarthDamage(damage, true);
				player.takeEarthDamage(damage, true);
				player.takeEarthDamage(damage, true);
				player.takeEarthDamage(damage, true);
				player.takeEarthDamage(damage, true);
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
				initStrTouSpeInte(20, 80, 80, 80);
				initWisLibSensCor(80, 20, 40, 50);
				this.weaponAttack = 10;
				this.armorDef = 20;
				this.armorMDef = 60;
				this.level = 12;
				this.bonusHP = 1000;
				this.additionalXP = 50;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 1) {
				this.short = "earth elemental";
				this.imageName = "earth elemental";
				this.long = "You're currently fighting earth elemental. It's a four foot, three inch tall creature of made of rocks, currently using its bare fists to fight.";
				this.tallness = 51;
				initStrTouSpeInte(24, 84, 84, 100);
				initWisLibSensCor(100, 20, 50, 50);
				this.weaponAttack = 14;
				this.armorDef = 30;
				this.armorMDef = 70;
				this.level = 14;
				this.bonusHP = 1200;
				this.additionalXP = 75;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 2) {
				this.short = "earth elemental";
				this.imageName = "earth elemental";
				this.long = "You're currently fighting earth elemental. It's a four and a half foot tall creature of made of rocks, currently using its bare fists to fight.";
				this.tallness = 54;
				initStrTouSpeInte(28, 88, 88, 120);
				initWisLibSensCor(120, 20, 60, 50);
				this.weaponAttack = 18;
				this.armorDef = 40;
				this.armorMDef = 80;
				this.level = 16;
				this.bonusHP = 1400;
				this.additionalXP = 100;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 3) {
				this.short = "earth elemental";
				this.imageName = "earth elemental";
				this.long = "You're currently fighting earth elemental. It's a four foot, nine inch tall creature of made of rocks, currently using its bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(32, 92, 92, 140);
				initWisLibSensCor(140, 20, 70, 50);
				this.weaponAttack = 22;
				this.armorDef = 50;
				this.armorMDef = 90;
				this.level = 18;
				this.bonusHP = 1600;
				this.additionalXP = 125;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) {
				this.short = "golem";
				this.imageName = "earth golem";
				this.long = "You're currently fighting 'female' golem. It's a nine foot tall creature of made of rocks, currently using its bare fists to fight.";
				this.tallness = 108;
				initStrTouSpeInte(48, 138, 138, 210);
				initWisLibSensCor(210, 30, 110, 50);
				this.weaponAttack = 34;
				this.armorDef = 80;
				this.armorMDef = 140;
				this.level = 21;
				this.bonusHP = 2400;
				this.additionalXP = 190;
			}
			this.a = "the ";
			this.plural = false;
			this.lustVuln = 0.01;
			this.createBreastRow(0, 1);
			initGenderless();
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.armorName = "earth skin";
			this.createPerk(PerkLib.EnemyElementalType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EarthNature, 0, 0, 0, 0);
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) {
				this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
				this.createPerk(PerkLib.EnemyChampionType, 0, 0, 0, 0);
				this.drop = new WeightedDrop()
					.add(useables.LELSHARD, 3)
					.add(useables.ELCRYST, 1);
			}
			else {
				this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
				this.drop = new WeightedDrop()
					.add(useables.ELSHARD, 3)
					.add(useables.LELSHARD, 1);
			}
			checkMonster();
		}
		
	}

}