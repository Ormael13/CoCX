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
			outputText("Water elemental concentrate water on it fist and send punch toward you.");
			var damage:Number = inte + wis;
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 0.3;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 3;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 1.25);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise punch!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" It hit you square in the chest. ");
				damage = player.takeIceDamage(damage, true);
			}
		}
		
		public function fluffyOfPunches():void {
			outputText("Water elemental concentrate water on it fists and goes wild at you sending punches.");
			var damage:Number = inte + wis;
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 0.3;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 3;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 1.5);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath it avoiding all punches!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" They hits you all over the body. ");
				damage = player.takeIceDamage(damage, true);
				damage = player.takeIceDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Provoke)) {
				var choiceP:Number = rand(5);
				if (choice1 < 5) fluffyOfPunches();
				if (choiceP == 5) baseElementalAttack();
			}
			else {
				var choice1:Number = rand(5);
				if (choice1 < 3) fluffyOfPunches();
				if (choice1 == 3 || choice1 == 4) baseElementalAttack();
				if (choice1 == 5) eAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.riverdungeon.defeatedByWaterElemental();
		}
		
		public function WaterElemental() 
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 0) {
				this.long = "You're currently fighting water elemental. It's four feet tall, it body covered with water and it's using bare fists to fight.";
				this.tallness = 48;
				initStrTouSpeInte(10, 35, 45, 45);
				initWisLibSensCor(45, 10, 20, 50);
				this.weaponAttack = 5;
				this.armorDef = 5;
				this.armorMDef = 30;
				this.level = 12;
				this.bonusHP = 400;
				this.additionalXP = 50;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 1) {
				this.long = "You're currently fighting water elemental. It's four feet and three inches tall, it body covered with water and it's using bare fists to fight.";
				this.tallness = 51;
				initStrTouSpeInte(12, 27, 47, 55);
				initWisLibSensCor(55, 10, 25, 50);
				this.weaponAttack = 6;
				this.armorDef = 6;
				this.armorMDef = 40;
				this.level = 15;
				this.bonusHP = 440;
				this.additionalXP = 75;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 2) {
				this.long = "You're currently fighting water elemental. It's four and half feet tall, it body covered with water and it's using bare fists to fight.";
				this.tallness = 54;
				initStrTouSpeInte(14, 29, 49, 65);
				initWisLibSensCor(65, 10, 30, 50);
				this.weaponAttack = 7;
				this.armorDef = 7;
				this.armorMDef = 50;
				this.level = 18;
				this.bonusHP = 480;
				this.additionalXP = 100;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 3) {
				this.long = "You're currently fighting water elemental. It's four feet and nine iches tall, it body covered with water and it's using bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(16, 31, 51, 75);
				initWisLibSensCor(75, 10, 35, 50);
				this.weaponAttack = 8;
				this.armorDef = 8;
				this.armorMDef = 60;
				this.level = 21;
				this.bonusHP = 520;
				this.additionalXP = 125;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) {//river dungeon floor 2 subboss
				this.long = "You're currently fighting water elemental. It's five feet tall, it body covered with water and it's using bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(16, 31, 51, 75);
				initWisLibSensCor(75, 10, 35, 50);
				this.weaponAttack = 8;
				this.armorDef = 8;
				this.armorMDef = 60;
				this.level = 24;
				this.bonusHP = 560;
				this.additionalXP = 125;
			}
			this.a = "the ";
			this.short = "water elemental";
			this.imageName = "water elemental";
			this.plural = false;
			this.lustVuln = 0;
			this.drop = new ChainedDrop()
					.add(useables.ELSHARD, 1);
			this.createBreastRow(0, 1);
			initGenderless();
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.armorName = "water skin";
			this.createPerk(PerkLib.EnemyElementalType, 0, 0, 0, 0);
			this.createPerk(PerkLib.IceNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 2, 0, 0, 0);
			checkMonster();
		}
		
	}

}