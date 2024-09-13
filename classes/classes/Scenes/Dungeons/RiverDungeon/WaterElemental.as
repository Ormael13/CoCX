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

public class WaterElemental extends Monster
	{
		public function baseElementalAttack():void {
			outputText(""+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Undine":"Water elemental")+" thickens the water on its fist before thrusting it's palm toward you with a violent punch.");
			var damage:Number = inte + wis;
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 0.3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 3;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 1.25);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise punch!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" It hits you square in the chest. ");
				player.takeWaterDamage(damage, true);
			}
		}
		
		public function fluffyOfPunches():void {
			outputText(""+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Undine":"Water elemental")+" tosses a barrage of punches toward you with it's watery fists.");
			var damage:Number = inte + wis;
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 0.3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 3;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 1.5);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath it, avoiding all punches!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The watery strikes connect with your body. ");
				player.takeWaterDamage(damage, true);
				player.takeWaterDamage(damage, true);
			}
		}
		
		public function subbossSpecial():void {
			outputText("The Undine concentrates, coalescing nearby ambient water into crescent-shaped shards of water before hurling them toward you with a flick of his wrist.");
			if (player.getEvasionRoll()) outputText(" You slide underneath the barrage!");
			else {
				var damage:Number = inte + wis;
				if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 0.3;
				if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 3;
				damage *= 3.75;
				damage = Math.round(damage);
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The watery strikes connect with your body. ");
				player.takeWaterDamage(damage, true);
				player.takeWaterDamage(damage, true);
				player.takeWaterDamage(damage, true);
				player.takeWaterDamage(damage, true);
				player.takeWaterDamage(damage, true);
				player.takeWaterDamage(damage, true);
				player.takeWaterDamage(damage, true);
				player.takeWaterDamage(damage, true);
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
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) SceneLib.dungeons.riverdungeon.defeatWaterElementalSubBoss();
			else cleanupAfterCombat();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) SceneLib.dungeons.riverdungeon.defeatedByWaterElementalSubBoss();
			else SceneLib.dungeons.riverdungeon.defeatedByWaterElemental();
		}
		
		public function WaterElemental() 
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 0) {
				this.short = "water elemental";
				this.imageName = "water elemental";
				this.long = "You're currently fighting water elemental. It's a four feet tall body of water shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 48;
				initStrTouSpeInte(20, 50, 90, 90);
				initWisLibSensCor(90, 20, 40, 0);
				this.weaponAttack = 10;
				this.armorDef = 10;
				this.armorMDef = 60;
				this.level = 12;
				this.bonusHP = 800;
				this.additionalXP = 50;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 1) {
				this.short = "water elemental";
				this.imageName = "water elemental";
				this.long = "You're currently fighting water elemental. It's a four foot, three inch tall body of water shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 51;
				initStrTouSpeInte(24, 54, 94, 110);
				initWisLibSensCor(110, 20, 50, 0);
				this.weaponAttack = 12;
				this.armorDef = 12;
				this.armorMDef = 80;
				this.level = 14;
				this.bonusHP = 880;
				this.additionalXP = 75;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 2) {
				this.short = "water elemental";
				this.imageName = "water elemental";
				this.long = "You're currently fighting water elemental. It's a four and half foot tall body of water shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 54;
				initStrTouSpeInte(28, 58, 98, 130);
				initWisLibSensCor(130, 20, 60, 0);
				this.weaponAttack = 14;
				this.armorDef = 14;
				this.armorMDef = 100;
				this.level = 16;
				this.bonusHP = 960;
				this.additionalXP = 100;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 3) {
				this.short = "water elemental";
				this.imageName = "water elemental";
				this.long = "You're currently fighting water elemental. It's four foot, nine inch tall body of water shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(32, 62, 102, 150);
				initWisLibSensCor(150, 20, 70, 0);
				this.weaponAttack = 16;
				this.armorDef = 16;
				this.armorMDef = 120;
				this.level = 18;
				this.bonusHP = 1040;
				this.additionalXP = 125;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) {
				this.short = "undine";
				this.imageName = "water undine";
				this.long = "You're currently fighting 'male' undine. It's a nine foot tall body of water shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 108;
				initStrTouSpeInte(48, 94, 154, 230);
				initWisLibSensCor(230, 30, 110, 0);
				this.weaponAttack = 24;
				this.armorDef = 24;
				this.armorMDef = 180;
				this.level = 21;
				this.bonusHP = 1560;
				this.additionalXP = 190;
			}
			this.a = "the ";
			this.plural = false;
			this.lustVuln = 0.01;
			this.createBreastRow(0, 1);
			initGenderless();
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.armorName = "water skin";
			this.createPerk(PerkLib.EnemyElementalType, 0, 0, 0, 0);
			this.createPerk(PerkLib.WaterNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 2, 0, 0, 0);
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