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

public class AirElemental extends Monster
	{
		public function baseElementalAttack():void {
			outputText(""+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Sylph":"Air elemental")+" launches the full force of its fists at you, guided by a strong force of wind.");
			var damage:Number = inte + wis;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 1.5);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise punch!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" It hits you square in the chest. ");
				player.takeWindDamage(damage, true);
			}
		}
		
		public function fluffyOfPunches():void {
			outputText(""+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Sylph":"Air elemental")+" wraps itself in a swirling vortex before spinning towards you in a tornado of fighting fury.");
			var damage:Number = inte + wis;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 1.25);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath it, avoiding all punches!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" Each hit connects, nearly causing you to spin from the force of the trauma. ");
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
			}
		}
		
		public function subbossSpecial():void {
			outputText("The sylph concentrates, hardening the air until several crescent-like shards of air coalesce. With a graceful twirl, it directs the razor-sharp wind toward you, followed by a powerful gust.");
			if (player.getEvasionRoll()) outputText(" You slide underneath the barrage!");
			else {
				var damage:Number = inte + wis;
				damage *= 3.175;
				damage = Math.round(damage);
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The wind slices through you. ");
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
				player.takeWindDamage(damage, true);
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
			if (inDungeon) {
				if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) SceneLib.dungeons.riverdungeon.defeatAirElementalSubBoss();
				else SceneLib.exploration.elementalsDefeated();
			}
			else SceneLib.exploration.elementalsDefeated();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (inDungeon) {
				if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) SceneLib.dungeons.riverdungeon.defeatedByAirElementalSubBoss();
				else SceneLib.dungeons.riverdungeon.defeatedByAirElemental();
			}
			else cleanupAfterCombat();
		}
		
		public function AirElemental() 
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 0) {
				this.short = "air elemental";
				this.imageName = "air elemental";
				this.long = "You're currently fighting an air elemental. It's a four foot tall creature. Its body is wrapped in an air current, almost completely concealing its form as it uses its bare fists to fight.";
				this.tallness = 48;
				initStrTouSpeInte(20, 40, 120, 80);
				initWisLibSensCor(80, 20, 40, 0);
				this.weaponAttack = 10;
				this.armorDef = 10;
				this.armorMDef = 60;
				this.level = 12;
				this.bonusHP = 800;
				this.additionalXP = 50;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 1) {
				this.short = "air elemental";
				this.imageName = "air elemental";
				this.long = "You're currently fighting an air elemental. It's a four foot, three inch tall creature. Its body is wrapped in an air current, almost completely concealing its form as it uses its bare fists to fight.";
				this.tallness = 51;
				initStrTouSpeInte(24, 44, 124, 100);
				initWisLibSensCor(100, 20, 50, 0);
				this.weaponAttack = 12;
				this.armorDef = 12;
				this.armorMDef = 70;
				this.level = 14;
				this.bonusHP = 900;
				this.additionalXP = 75;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 2) {
				this.short = "air elemental";
				this.imageName = "air elemental";
				this.long = "You're currently fighting an air elemental. It's a four and a half foot tall creature. Its body is wrapped in an air current, almost completely concealing its form as it uses its bare fists to fight.";
				this.tallness = 54;
				initStrTouSpeInte(28, 48, 128, 120);
				initWisLibSensCor(120, 20, 60, 0);
				this.weaponAttack = 14;
				this.armorDef = 14;
				this.armorMDef = 80;
				this.level = 16;
				this.bonusHP = 1000;
				this.additionalXP = 100;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 3) {
				this.short = "air elemental";
				this.imageName = "air elemental";
				this.long = "You're currently fighting an air elemental. It's a four foot, nine inch tall creature. Its body is wrapped in an air current, almost completely concealing its form as it uses its bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(32, 52, 132, 140);
				initWisLibSensCor(140, 20, 70, 0);
				this.weaponAttack = 16;
				this.armorDef = 16;
				this.armorMDef = 90;
				this.level = 18;
				this.bonusHP = 1100;
				this.additionalXP = 125;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) {
				this.short = "sylph";
				this.imageName = "air sylph";
				this.long = "You're currently fighting 'male' sylph. It's a nine foot tall creature. Its body is wrapped in an air current, almost completely concealing its form as it uses its bare fists to fight.";
				this.tallness = 108;
				initStrTouSpeInte(48, 78, 198, 210);
				initWisLibSensCor(210, 30, 110, 0);
				this.weaponAttack = 20;
				this.armorDef = 20;
				this.armorMDef = 120;
				this.level = 21;
				this.bonusHP = 1750;
				this.additionalXP = 190;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 5) {
				this.short = "air elemental";
				this.imageName = "air elemental";
				this.long = "You're currently fighting an air elemental. It's a four and a half foot tall creature. Its body is wrapped in an air current, almost completely concealing its form as it uses its bare fists to fight.";
				this.tallness = 54;
				initStrTouSpeInte(48, 68, 148, 220);
				initWisLibSensCor(220, 20, 110, 0);
				this.weaponAttack = 26;
				this.armorDef = 26;
				this.armorMDef = 130;
				this.level = 26;
				this.bonusHP = 1500;
				this.additionalXP = 225;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 6) {
				this.short = "air elemental";
				this.imageName = "air elemental";
				this.long = "You're currently fighting an air elemental. It's a four foot, nine inch tall creature. Its body is wrapped in an air current, almost completely concealing its form as it uses its bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(90, 120, 240, 420);
				initWisLibSensCor(420, 20, 100, 0);
				this.weaponAttack = 150;
				this.armorDef = 150;
				this.armorMDef = 800;
				this.level = 56;
				this.bonusHP = 1800;
				this.additionalXP = 300;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 7) {
				this.short = "air elemental";
				this.imageName = "air elemental";
				this.long = "You're currently fighting an air elemental. It's a four foot, nine inch tall creature. Its body is wrapped in an air current, almost completely concealing its form as it uses its bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(126, 156, 276, 600);
				initWisLibSensCor(600, 20, 140, 0);
				this.weaponAttack = 210;
				this.armorDef = 210;
				this.armorMDef = 1100;
				this.level = 86;
				this.bonusHP = 2400;
				this.additionalXP = 450;
			}
			this.a = "the ";
			this.flyer = true;
			this.plural = false;
			this.lustVuln = 0.01;
			this.createBreastRow(0, 1);
			initGenderless();
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.armorName = "air currents armor";
			this.createPerk(PerkLib.EnemyElementalType, 0, 0, 0, 0);
			this.createPerk(PerkLib.WindNature, 0, 0, 0, 0);
			if (inDungeon) {
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
			}
			else {
				if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 7) {
					this.drop = new WeightedDrop()
						.add(useables.ELCRYST, 3)
						.add(useables.LELCRYST, 1);
				}
				else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 6) {
					this.drop = new WeightedDrop()
						.add(useables.LELSHARD, 3)
						.add(useables.ELCRYST, 1);
				}
				else {
					this.drop = new WeightedDrop()
						.add(useables.ELSHARD, 3)
						.add(useables.LELSHARD, 1);
				}
			}
			checkMonster();
		}
		
	}

}