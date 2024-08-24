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
				player.takeIceDamage(damage, true);
			}
		}
		
		public function fluffyOfPunches():void {
			outputText(""+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Undine":"The ice elemental")+" crystalizes its fist in ice. Jagged icicles emerge as the elemental jabs at you.");
			var damage:Number = inte + wis;
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity)) damage *= 0.3;
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) damage *= 3;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 1.5);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath it avoiding all punches!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The strikes connect, hitting you directly in the chest. ");
				player.takeIceDamage(damage, true);
				player.takeIceDamage(damage, true);
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
				initStrTouSpeInte(44, 74, 114, 210);
				initWisLibSensCor(210, 20, 110, 50);
				this.weaponAttack = 24;
				this.armorDef = 24;
				this.armorMDef = 200;
				this.level = 26;
				this.bonusHP = 1360;
				this.additionalXP = 185;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 1) {
				this.short = "ice elemental";
				this.imageName = "ice elemental";
				this.long = "You're currently fighting ice elemental. It's a four foot, three inch tall body of ice shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 51;
				initStrTouSpeInte(50, 80, 120, 240);
				initWisLibSensCor(240, 20, 130, 50);
				this.weaponAttack = 28;
				this.armorDef = 28;
				this.armorMDef = 240;
				this.level = 28;
				this.bonusHP = 1520;
				this.additionalXP = 215;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 2) {
				this.short = "ice elemental";
				this.imageName = "ice elemental";
				this.long = "You're currently fighting ice elemental. It's a four and half foot tall body of ice shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 54;
				initStrTouSpeInte(56, 86, 126, 270);
				initWisLibSensCor(270, 20, 150, 50);
				this.weaponAttack = 32;
				this.armorDef = 32;
				this.armorMDef = 280;
				this.level = 30;
				this.bonusHP = 1680;
				this.additionalXP = 245;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 3) {
				this.short = "ice elemental";
				this.imageName = "ice elemental";
				this.long = "You're currently fighting ice elemental. It's four foot, nine inch tall body of ice shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(62, 92, 132, 300);
				initWisLibSensCor(300, 20, 170, 50);
				this.weaponAttack = 36;
				this.armorDef = 36;
				this.armorMDef = 320;
				this.level = 32;
				this.bonusHP = 1840;
				this.additionalXP = 275;
			}
			this.a = "the ";
			this.plural = false;
			this.lustVuln = 0.01;
			this.drop = new WeightedDrop()
					.add(useables.ELSHARD, 3)
					.add(useables.LELSHARD, 1);
			this.createBreastRow(0, 1);
			initGenderless();
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.armorName = "ice skin";
			this.createPerk(PerkLib.EnemyElementalType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			this.createPerk(PerkLib.IceNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 1, 0, 0, 0);
			checkMonster();
		}
		
	}

}