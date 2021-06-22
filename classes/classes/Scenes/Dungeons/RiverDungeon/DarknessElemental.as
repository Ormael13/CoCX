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

public class DarknessElemental extends Monster
	{
		public function baseElementalAttack():void {
			outputText(""+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Undine":"The darkness elemental")+" envelops its fists within inky shadows before throwing a punch toward you.");
			var damage:Number = inte + wis;
			//if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0) damage *= 0.3;
			if (player.findPerk(PerkLib.LightningAffinity) >= 0) damage *= 3;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 2);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise punch!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" It hits you square in the chest. ");
				damage = player.takeDarknessDamage(damage, true);
			}
		}
		
		public function fluffyOfPunches():void {
			outputText(""+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Undine":"The darkness elemental")+" wraps its fists in wicks of darkness before zeroing in for a flurry of punches.");
			var damage:Number = inte + wis;
			//if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0) damage *= 0.3;
			if (player.findPerk(PerkLib.LightningAffinity) >= 0) damage *= 3;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 1.5);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath it avoiding all punches!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The strikes connect, hitting you directly in the chest. ");
				damage = player.takeDarknessDamage(damage, true);
				damage = player.takeDarknessDamage(damage, true);
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
			else */SceneLib.dungeons.riverdungeon.defeatedByDarknessElemental();
		}
		
		public function DarknessElemental() 
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 0) {
				this.short = "darkness elemental";
				this.imageName = "darkness elemental";
				this.long = "You're currently fighting darkness elemental. It's a four feet tall body of darkness shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 48;
				initStrTouSpeInte(22, 32, 52, 110);
				initWisLibSensCor(110, 10, 55, 50);
				this.weaponAttack = 12;
				this.armorDef = 12;
				this.armorMDef = 65;
				this.level = 26;
				this.bonusHP = 750;
				this.additionalXP = 185;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 1) {
				this.short = "darkness elemental";
				this.imageName = "darkness elemental";
				this.long = "You're currently fighting darkness elemental. It's a four foot, three inch tall body of darkness shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 51;
				initStrTouSpeInte(25, 35, 55, 125);
				initWisLibSensCor(125, 10, 65, 50);
				this.weaponAttack = 14;
				this.armorDef = 14;
				this.armorMDef = 75;
				this.level = 29;
				this.bonusHP = 850;
				this.additionalXP = 215;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 2) {
				this.short = "darkness elemental";
				this.imageName = "darkness elemental";
				this.long = "You're currently fighting darkness elemental. It's a four and half foot tall body of darkness shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 54;
				initStrTouSpeInte(28, 38, 58, 140);
				initWisLibSensCor(140, 10, 75, 50);
				this.weaponAttack = 16;
				this.armorDef = 16;
				this.armorMDef = 85;
				this.level = 32;
				this.bonusHP = 950;
				this.additionalXP = 245;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 3) {
				this.short = "darkness elemental";
				this.imageName = "darkness elemental";
				this.long = "You're currently fighting darkness elemental. It's four foot, nine inch tall body of darkness shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(31, 41, 61, 155);
				initWisLibSensCor(155, 10, 85, 50);
				this.weaponAttack = 18;
				this.armorDef = 18;
				this.armorMDef = 95;
				this.level = 35;
				this.bonusHP = 1050;
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
			this.armorName = "darkness skin";
			this.createPerk(PerkLib.EnemyElementalType, 0, 0, 0, 0);
			this.createPerk(PerkLib.DarknessNature, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}