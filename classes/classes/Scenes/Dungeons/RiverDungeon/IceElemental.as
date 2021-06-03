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

public class IceElemental extends Monster
	{
		public function baseElementalAttack():void {
			outputText(""+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Undine":"The ice elemental")+" crystalizes its fist within a block of hardened ice before jabbing at you.");
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
				outputText(" It hits you square in the chest. ");
				damage = player.takeIceDamage(damage, true);
			}
		}
		
		public function fluffyOfPunches():void {
			outputText(""+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Undine":"The ice elemental")+" crystalizes its fist in ice. Jagged icicles emerge as the elemental jabs at you.");
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
				outputText(" The strikes connect, hitting you directly in the chest. ");
				damage = player.takeIceDamage(damage, true);
				damage = player.takeIceDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			/*if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) {
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
			else {*/
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
			//}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			/*if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) SceneLib.dungeons.riverdungeon.defeatAirElementalSubBoss();
			else */cleanupAfterCombat();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			/*if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) SceneLib.dungeons.riverdungeon.defeatedByAirElementalSubBoss();
			else */SceneLib.dungeons.riverdungeon.defeatedByIceElemental();
		}
		
		public function IceElemental() 
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 0) {
				this.short = "ice elemental";
				this.imageName = "ice elemental";
				this.long = "You're currently fighting ice elemental. It's a four feet tall body of ice shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 48;
				initStrTouSpeInte(22, 37, 57, 105);
				initWisLibSensCor(105, 10, 55, 50);
				this.weaponAttack = 12;
				this.armorDef = 12;
				this.armorMDef = 100;
				this.level = 26;
				this.bonusHP = 680;
				this.additionalXP = 185;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 1) {
				this.short = "ice elemental";
				this.imageName = "ice elemental";
				this.long = "You're currently fighting ice elemental. It's a four foot, three inch tall body of ice shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 51;
				initStrTouSpeInte(25, 40, 60, 120);
				initWisLibSensCor(120, 10, 65, 50);
				this.weaponAttack = 14;
				this.armorDef = 14;
				this.armorMDef = 120;
				this.level = 29;
				this.bonusHP = 760;
				this.additionalXP = 215;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 2) {
				this.short = "ice elemental";
				this.imageName = "ice elemental";
				this.long = "You're currently fighting ice elemental. It's a four and half foot tall body of ice shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 54;
				initStrTouSpeInte(28, 43, 63, 135);
				initWisLibSensCor(135, 10, 75, 50);
				this.weaponAttack = 16;
				this.armorDef = 16;
				this.armorMDef = 140;
				this.level = 32;
				this.bonusHP = 840;
				this.additionalXP = 245;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 3) {
				this.short = "ice elemental";
				this.imageName = "ice elemental";
				this.long = "You're currently fighting ice elemental. It's four foot, nine inch tall body of ice shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(31, 46, 66, 150);
				initWisLibSensCor(150, 10, 85, 50);
				this.weaponAttack = 18;
				this.armorDef = 18;
				this.armorMDef = 160;
				this.level = 35;
				this.bonusHP = 920;
				this.additionalXP = 275;
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
			this.armorName = "ice skin";
			this.createPerk(PerkLib.EnemyElementalType, 0, 0, 0, 0);
			this.createPerk(PerkLib.IceNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 1, 0, 0, 0);
			checkMonster();
		}
		
	}

}