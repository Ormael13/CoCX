/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Dungeons.RiverDungeon 
{

import classes.*;
import classes.internals.*;
import classes.CoC;
//import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

public class QuatroElementalBoss extends Monster
	{
		public function baseElementalAttack():void {
			outputText("Elemental concentrate fire on it fist and send punch toward you.");
			var damage:Number = inte + wis;
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 2);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise punch!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" It hit you square in the chest. ");
				damage = player.takeFireDamage(damage, true);
			}
		}
		
		public function fluffyOfPunches():void {
			outputText("Elemental concentrate fire on it fists and goes wild at you sending flurry of punches.");
			var damage:Number = inte + wis;
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 1.5);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath it avoiding all punches!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" They hits you all over the body. ");
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
			}
		}
		
		public function subbossSpecial1():void {
			outputText("Elemental solidiies the ambient elemental energy into countles small fireballs before launching them at you with a thrust of its hands.");
			if (player.getEvasionRoll()) outputText(" You slide underneath the barrage. Talk about Pyromania!");
			else {
				var damage:Number = inte + wis;
				if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
				if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
				damage *= 3.75;
				damage = Math.round(damage);
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The flaming spheres explode upon impact with you. Talk about Pyromania! ");
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
			}
		}
		public function subbossSpecial2():void {
			outputText("Elemental unearths the ground beneath itself, reshaping the stone into razor-sharp rocks. It thrusts its arms down, sending the rocks toward you.");
			if (player.getEvasionRoll()) outputText(" You slide underneath the barrage!");
			else {
				var damage:Number = inte + wis;
				damage *= 5;
				damage = Math.round(damage);
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The razor-like rocks cut into you. ");
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
			}
		}
		public function subbossSpecial3():void {
			outputText("Elemental concentrates, coalescing nearby ambient water into crescent-shaped shards of water before hurling them toward you with a flick of his wrist.");
			if (player.getEvasionRoll()) outputText(" You slide underneath the barrage!");
			else {
				var damage:Number = inte + wis;
				if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 0.3;
				if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 3;
				damage *= 3.75;
				damage = Math.round(damage);
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The watery strikes connect with your body. ");
				damage = player.takeIceDamage(damage, true);
				damage = player.takeIceDamage(damage, true);
				damage = player.takeIceDamage(damage, true);
				damage = player.takeIceDamage(damage, true);
				damage = player.takeIceDamage(damage, true);
				damage = player.takeIceDamage(damage, true);
				damage = player.takeIceDamage(damage, true);
				damage = player.takeIceDamage(damage, true);
			}
		}
		public function subbossSpecial4():void {
			outputText("Elemental concentrates, hardening the air until several crescent-like shards of air coalesce. With a twirl, it aims the razor wind toward you before shooting a gust of wind.");
			if (player.getEvasionRoll()) outputText(" You slide underneath the barrage!");
			else {
				var damage:Number = inte + wis;
				damage *= 3.175;
				damage = Math.round(damage);
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The wind slices through you. ");
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (_fightPhase == 1) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP1:Number = rand(5);
					if (choiceP1 == 0) fluffyOfPunches();
					if (choiceP1 == 1) baseElementalAttack();
					if (choiceP1 > 1) subbossSpecial1();
				}
				else {
					var choice11:Number = rand(6);
					if (choice11 < 2) fluffyOfPunches();
					if (choice11 == 2 || choice11 == 3) baseElementalAttack();
					if (choice11 > 3) subbossSpecial1();
				}
			}
			if (_fightPhase == 2) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP2:Number = rand(5);
					if (choiceP2 == 0) fluffyOfPunches();
					if (choiceP2 == 1) baseElementalAttack();
					if (choiceP2 > 1) {
						if (rand(2) == 0) subbossSpecial1();
						else subbossSpecial2();
					}
				}
				else {
					var choice12:Number = rand(6);
					if (choice12 < 2) fluffyOfPunches();
					if (choice12 == 2 || choice12 == 3) baseElementalAttack();
					if (choice12 > 3) {
						if (rand(2) == 0) subbossSpecial1();
						else subbossSpecial2();
					}
				}
			}
			if (_fightPhase == 3) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP3:Number = rand(5);
					if (choiceP3 == 0) fluffyOfPunches();
					if (choiceP3 == 1) subbossSpecial3();
					if (choiceP3 > 1) {
						if (rand(2) == 0) subbossSpecial1();
						else subbossSpecial2();
					}
				}
				else {
					var choice13:Number = rand(6);
					if (choice13 < 2) fluffyOfPunches();
					if (choice13 == 2 || choice13 == 3) subbossSpecial3();
					if (choice13 > 3) {
						if (rand(2) == 0) subbossSpecial1();
						else subbossSpecial2();
					}
				}
			}
			if (_fightPhase == 4) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP4:Number = rand(5);
					if (choiceP4 == 0) fluffyOfPunches();
					if (choiceP4 == 1) {
						if (rand(2) == 0) subbossSpecial4();
						else subbossSpecial3();
					}
					if (choiceP4 > 1) {
						if (rand(2) == 0) subbossSpecial1();
						else subbossSpecial2();
					}
				}
				else {
					var choice14:Number = rand(6);
					if (choice14 < 2) fluffyOfPunches();
					if (choice14 == 2 || choice14 == 3) {
						if (rand(2) == 0) subbossSpecial4();
						else subbossSpecial3();
					}
					if (choice14 > 3) {
						if (rand(2) == 0) subbossSpecial1();
						else subbossSpecial2();
					}
				}
			}
		}
		
		private var _fightPhase:int = 1;
		
		private function phase1Ends():void
		{
			clearOutput();
			outputText("Unable to resist your assault, the elemental collapses to the ground. As the flames die out and the elemental lies dormant, it suddenly resurges with a rumble of earth. Before you have time to react, they rebuild the elemental, forming a chrysalis of rock. The revenant stands before you once more, ready to keep fighting.");
			player.addStatusValue(StatusEffects.RivereDungeonIB, 1, 1);
			_fightPhase = 2;
			short = "mutated fire-earth elemental";
			armorName = "magma skin";
			weaponAttack += 10;
			armorDef += 10;
			armorMDef += 60;
			bonusHP += 125;
			this.strStat.core.value *= 1.5;
			this.touStat.core.value *= 1.5;
			this.removePerk(PerkLib.FireNature);
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			HP = maxHP();
			SceneLib.combat.combatRoundOver();
		}
		private function phase2Ends():void
		{
			clearOutput();
			outputText("The elemental falls once more, unable to resist your assault. The flames die out and the rocky armor crumbles with it as well. Before you can react, a downpour of rain falls upon you. A stream of water pours directly into the elemental as it surges once more with life. A head-like silhouette faces you as the revenant rises from the ground. Looks like your job here isn't done yet.");
			player.addStatusValue(StatusEffects.RivereDungeonIB, 4, 1);
			_fightPhase = 3;
			short = "tripple-fusion elemental";
			armorName = "magma skin covered with layer of steam";
			armorDef += 5;
			armorMDef = 30;
			this.wisStat.core.value *= 1.5;
			this.removePerk(PerkLib.IceVulnerability);
			this.createPerk(PerkLib.MonsterRegeneration, 2, 0, 0, 0);
			HP = maxHP();
			SceneLib.combat.combatRoundOver();
		}
		private function phase3Ends():void
		{
			clearOutput();
			outputText("The elemental falls again, defeatedly collapsing on the ground. You wonder if you should wait or try to inspect the dormant elemental quickly.Before you can react, a sudden gust of wind shakes the room, causing the remains of the elemental to swirl in a small vortex before spinning back into shape. ");
			outputText("The revenant rises once more before it speaks to you in a cacophony of different voices, <i>“I will not be aired once more.”</i> Without further warning, it rushes toward you, prepared for combat.");
			player.addStatusValue(StatusEffects.RivereDungeonIB, 2, 1);
			_fightPhase = 4;
			short = "quatro elemental";
			armorName = "magma skin covered with layer of steam and air currents";
			weaponAttack += 5;
			armorDef += 5;
			armorMDef = 30;
			this.intStat.core.value *= 1.5;
			this.removePerk(PerkLib.MonsterRegeneration);
			this.createPerk(PerkLib.MonsterRegeneration, 5, 0, 0, 0);
			HP = maxHP();
			SceneLib.combat.combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (_fightPhase == 1) {
				phase1Ends();
				return;
			}
			else if (_fightPhase == 2) {
				phase2Ends();
				return;
			}
			else if (_fightPhase == 3) {
				phase3Ends();
				return;
			}
			SceneLib.dungeons.riverdungeon.defeatQuatroElementalBoss();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.riverdungeon.defeatedByQuatroElementalBoss();
		}
		
		override public function get long():String
		{
			var str:String = "";
			if (_fightPhase == 1) str += "You're currently fighting mutated elemental. It's ten feet tall, it body covered with fire and it's using bare fists to fight.";
			else if (_fightPhase == 2) str += "You're currently fighting mutated elemental. It's ten feet tall, it body covered with fire and earth, it's using bare fists to fight.";
			else if (_fightPhase == 3) str += "You're currently fighting mutated elemental. It's ten feet tall, it body covered with earth armor and surrounded by thick steam layer, it's using bare fists to fight.";
			else if (_fightPhase == 4) str += "You're currently fighting mutated elemental. It's ten feet tall, it body covered with mix of four elements and it's using bare fists to fight.";
			return str;
		}
		
		public function QuatroElementalBoss() 
		{
			this.a = "the ";
			this.short = "mutated fire elemental";
			this.imageName = "quatro elemental boss";
			this.long = "";
			this.tallness = 120;
			this.plural = false;
			this.createBreastRow(0, 1);
			initGenderless();
			initStrTouSpeInte(24, 40, 70, 120);
			initWisLibSensCor(120, 15, 55, 50);
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 10;
			this.armorName = "fire skin";
			this.armorDef = 10;
			this.armorMDef = 60;
			this.bonusHP = 875;
			this.lustVuln = 0;
			this.drop = new ChainedDrop()
					.add(useables.ELSHARD, 1);
			this.level = 24;
			this.additionalXP = 200;
			this.createPerk(PerkLib.EnemyElementalType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireNature, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}