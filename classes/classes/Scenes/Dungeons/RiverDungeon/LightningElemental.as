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

public class LightningElemental extends Monster
	{
		public function baseElementalAttack():void {
			outputText("Sparks of electricity wrap around "+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Undine":"the lightning elemental")+"'s fists before it hurts its fist toward you.");
			var damage:Number = inte + wis;
			if (player.hasPerk(PerkLib.LightningAffinity)) damage *= 0.3;
			if (player.hasPerk(PerkLib.DarknessAffinity)) damage *= 3;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 2);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise punch!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" It hits you square in the chest. ");
				damage = player.takeLightningDamage(damage, true);
			}
		}
		
		public function fluffyOfPunches():void {
			outputText("Electricity crackles around "+(flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4?"Undine":"the lightning elemental")+"'s fists before it launches itself into a flurry of punches against you.");
			var damage:Number = inte + wis;
			if (player.hasPerk(PerkLib.LightningAffinity)) damage *= 0.3;
			if (player.hasPerk(PerkLib.DarknessAffinity)) damage *= 3;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 1.5);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath it avoiding all punches!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The strikes connect, hitting you directly in the chest. ");
				damage = player.takeLightningDamage(damage, true);
				damage = player.takeLightningDamage(damage, true);
				damage = player.takeLightningDamage(damage, true);
				damage = player.takeLightningDamage(damage, true);
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
			else */SceneLib.dungeons.riverdungeon.defeatedByLightningElemental();
		}
		
		public function LightningElemental() 
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 0) {
				this.short = "lightning elemental";
				this.imageName = "lightning elemental";
				this.long = "You're currently fighting lightning elemental. It's a four feet tall body of lightning shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 48;
				initStrTouSpeInte(44, 64, 104, 220);
				initWisLibSensCor(220, 20, 110, 50);
				this.weaponAttack = 24;
				this.armorDef = 24;
				this.armorMDef = 130;
				this.level = 26;
				this.bonusHP = 1500;
				this.additionalXP = 185;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 1) {
				this.short = "lightning elemental";
				this.imageName = "lightning elemental";
				this.long = "You're currently fighting lightning elemental. It's a four foot, three inch tall body of lightning shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 51;
				initStrTouSpeInte(50, 70, 110, 250);
				initWisLibSensCor(250, 20, 130, 50);
				this.weaponAttack = 28;
				this.armorDef = 28;
				this.armorMDef = 150;
				this.level = 28;
				this.bonusHP = 1700;
				this.additionalXP = 215;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 2) {
				this.short = "lightning elemental";
				this.imageName = "lightning elemental";
				this.long = "You're currently fighting lightning elemental. It's a four and half foot tall body of lightning shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 54;
				initStrTouSpeInte(56, 76, 116, 280);
				initWisLibSensCor(280, 20, 150, 50);
				this.weaponAttack = 32;
				this.armorDef = 32;
				this.armorMDef = 170;
				this.level = 30;
				this.bonusHP = 1900;
				this.additionalXP = 245;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 3) {
				this.short = "lightning elemental";
				this.imageName = "lightning elemental";
				this.long = "You're currently fighting lightning elemental. It's four foot, nine inch tall body of lightning shaped into a humanoid form. It's using bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(62, 82, 122, 310);
				initWisLibSensCor(310, 20, 170, 50);
				this.weaponAttack = 36;
				this.armorDef = 36;
				this.armorMDef = 190;
				this.level = 32;
				this.bonusHP = 2100;
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
			this.armorName = "lightning skin";
			this.createPerk(PerkLib.EnemyElementalType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			this.createPerk(PerkLib.LightningNature, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}