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
			outputText("The elemental concentrates the embers on it fist before sending a swift at you.");
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
				outputText(" It hits you square in the chest. ");
				damage = player.takeFireDamage(damage, true);
			}
		}
		
		public function fluffyOfPunches():void {
			outputText("The elemental concentrates the flames on it fists before bombarding you with a flurry of strikes.");
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
				outputText(" You're unable to dodge as the blazing strikes connect. ");
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
				damage = player.takeFireDamage(damage, true);
			}
		}
		
		public function subbossSpecial1():void {
			outputText("The elemental solidifies ambient elemental energy into several small before sending the flaming volley toward you.");
			if (player.getEvasionRoll()) outputText(" You slide underneath the barrage!");
			else {
				var damage:Number = inte + wis;
				if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
				if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
				damage *= 3.75;
				damage = Math.round(damage);
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The blazing strikes connect with your body. ");
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
			outputText("The elemental solidifies the nearby ambient elemental energy into countless razor-like shards of earth, each hanging above you. With a downward spin, the elemental shoots the earth at you.");
			if (player.getEvasionRoll()) outputText(" You slide underneath the incoming barrage!");
			else {
				var damage:Number = inte + wis;
				damage *= 5;
				damage = Math.round(damage);
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The razor-like shards of earth cut into you with countless lacerations. ");
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
			outputText("The elemental concentrates nearby ambient water into crescent-shaped shards. Throwing its hands toward you, it sends the razor-like water flying.");
			if (player.getEvasionRoll()) outputText(" You slide underneath the barrage!");
			else {
				var damage:Number = inte + wis;
				if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 0.3;
				if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 3;
				damage *= 3.75;
				damage = Math.round(damage);
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The crescent jets of water cut through you. ");
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
			outputText("The elemental concentrates as surrounding air currents warp into crescent-shaped wind blades. With a forceful gust of a wind, the crescents dart toward you.");
			if (player.getEvasionRoll()) outputText(" You slide underneath the barrage!");
			else {
				var damage:Number = inte + wis;
				damage *= 3.175;
				damage = Math.round(damage);
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The razor wind cuts through you with each contact. ");
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
			outputText("Unable to resist your assault, the elemental falls to the ground. The shedding embers quickly coalesce back into the fallen elemental.  ");
			outputText("In a flash of heat, the flames resurge into the revenant's armor, ready to continue fighting.");
			player.addStatusValue(StatusEffects.RivereDungeonIB, 1, 1);
			_fightPhase = 2;
			HP = maxHP();
			SceneLib.combat.combatRoundOver();
		}
		private function phase2Ends():void
		{
			clearOutput();
			outputText("As the elemental falls for the second time, you notice the blue embers that linger on the ground quickly merge with the remains once more. Steam erupts from the fire and water as eyes that been form at the top of the revenant. ");
			outputText("It stares at you, as a hunter would to his prey. It looks like it's still not going down without another fight.");
			player.addStatusValue(StatusEffects.RivereDungeonIB, 4, 1);
			_fightPhase = 3;
			HP = maxHP();
			SceneLib.combat.combatRoundOver();
		}
		private function phase3Ends():void
		{
			clearOutput();
			outputText("As the wind dissipates from the reformed being, you cautiously approach the corpse. A strong gust of wind suddenly causes another resurgence as white embers begin to coalesce from the remains.\n\n");
			outputText("The revenant rises again from the swirling air, ready to fight once more.\n\n");
			outputText("It speaks in an amalgamation of conflicting voices, <i>“To error, is human. You should air on the side of caution, lest I overtake you this time.”</i> Its speech is nearly impossible to understand. As you try to listen, it rushes toward you, clashing with you for the fourth time.");
			player.addStatusValue(StatusEffects.RivereDungeonIB, 2, 1);
			_fightPhase = 4;
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
		
		public function QuatroElementalBoss() 
		{
			if (_fightPhase == 1) {
				this.short = "mutated fire elemental";
				this.long = "You're currently fighting mutated elemental. It's a ten foot tall body of flame, currently using its bare fists to fight.";
				this.armorName = "fire skin";
				initStrTouSpeInte(24, 39, 69, 120);
				initWisLibSensCor(120, 15, 55, 50);
				this.weaponAttack = 10;
				this.armorDef = 10;
				this.armorMDef = 60;
				this.bonusHP = 875;
			}
			if (_fightPhase == 2) {
				this.short = "mutated fire-earth elemental";
				this.long = "You're currently fighting mutated elemental. It's a ten foot tall mixture of flame and earth, currently using its bare fists to fight.";
				this.armorName = "magma skin";
				initStrTouSpeInte(34, 59, 69, 120);
				initWisLibSensCor(120, 15, 55, 50);
				this.weaponAttack = 20;
				this.armorDef = 20;
				this.armorMDef = 120;
				this.bonusHP = 1000;
			}
			if (_fightPhase == 3) {
				this.short = "tripple-fusion elemental";
				this.long = "You're currently fighting mutated elemental. Standing ten feet tall, it's body is made of earth, surrounded by an armor of steam while using its bare fists to fight.";
				this.armorName = "magma skin covered with layer of steam";
				initStrTouSpeInte(34, 59, 69, 120);
				initWisLibSensCor(120, 15, 55, 50);
				this.weaponAttack = 20;
				this.armorDef = 20;
				this.armorMDef = 120;
				this.bonusHP = 1000;
				this.createPerk(PerkLib.MonsterRegeneration, 2, 0, 0, 0);
			}
			if (_fightPhase == 4) {
				this.short = "quatro elemental";
				this.long = "You're currently fighting mutated elemental. Standing ten feet tall, its body is covered with a mix of four elements, using its bare fists to fight.";
				this.armorName = "magma skin covered with layer of steam and air currents";
				initStrTouSpeInte(34, 59, 92, 120);
				initWisLibSensCor(120, 15, 55, 50);
				this.weaponAttack = 25;
				this.armorDef = 20;
				this.armorMDef = 120;
				this.bonusHP = 1000;
				this.createPerk(PerkLib.MonsterRegeneration, 5, 0, 0, 0);
			}
			this.a = "the ";
			this.imageName = "quatro elemental boss";
			this.tallness = 120;
			this.plural = false;
			this.lustVuln = 0;
			this.drop = new ChainedDrop()
					.add(useables.ELSHARD, 1);
			this.createBreastRow(0, 1);
			initGenderless();
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.level = 24;
			this.additionalXP = 200;
			this.createPerk(PerkLib.EnemyElementalType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}