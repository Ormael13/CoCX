/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Battlefield 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.Scenes.Areas.Battlefield.BattlefieldEnemiesScenes;
import classes.internals.*;

	public class VengefulApparitions extends Monster
	{
		public var Ghosts:BattlefieldEnemiesScenes = new BattlefieldEnemiesScenes();
		
		private function VengefulApparitionsMagicMissles():void {
			outputText("Among group, few appariutions raises their hand and casts a small spell. From their fingertips shoot magic missiles that slam against your skin and cause a surprising amount of discomfort. ");
			var damage:Number = eBaseIntelligenceDamage() * 0.25;
			player.takeMagicDamage(damage, true);
			player.takeMagicDamage(damage, true);
			player.takeMagicDamage(damage, true);
			player.takeMagicDamage(damage, true);
			if (this.level == 30) {
				player.takeMagicDamage(damage, true);
				player.takeMagicDamage(damage, true);
			}
			if (player.hasStatusEffect(StatusEffects.ChargeWeapon) || player.hasStatusEffect(StatusEffects.ChargeArmor) || player.statStore.hasBuff("Might") || player.statStore.hasBuff("Blink")) {
				if (player.hasStatusEffect(StatusEffects.ChargeWeapon)) player.removeStatusEffect(StatusEffects.ChargeWeapon);
				else if (player.hasStatusEffect(StatusEffects.ChargeArmor)) player.removeStatusEffect(StatusEffects.ChargeArmor);
				else if (player.statStore.hasBuff("Might")) player.statStore.removeBuffs("Might");
				else player.statStore.removeBuffs("Blink");
			}
			outputText("\n");
		}

		override protected function performCombatAction():void
		{
			var choice:Number = rand(4);
			switch (choice) {
				case 0:
				case 1:
				case 2:
					eAttack();
					break;
				case 3:
					VengefulApparitionsMagicMissles();
					break;
				default:
					eAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			Ghosts.defeatVengefulApparitions();
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			Ghosts.loseToAVengefulApparitions();
		}
		
		public function VengefulApparitions() 
		{
			this.a = "the ";
			this.short = "vengeful apparitions";
			this.imageName = "vengefulapparitions";
			this.long = "You are currently battling vengeful apparitions. They all looks very humanlike, even dressed in various exotic looking clothes. But they ocassionaly fades away partialy and this only server to increase difficulty of predicting attacks.";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock(15,2);
			this.createCock(15,2,CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_LOOSE);
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 78;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.skinTone = "white";
			this.hairColor = "white";
			this.hairLength = 3;
			this.weaponName = "fists";
			this.weaponVerb="punches";
			this.armorName = "translucent clothes";
			this.armorDef = 1;
			this.lust = 10;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			if (rand(2) == 0) {
				initStrTouSpeInte(44, 55, 66, 140);
				initWisLibSensCor(140, 1, 140, 50);
				this.weaponAttack = 30;
				this.armorMDef = 30;
				this.bonusHP = 150;
				this.bonusLust = 171;
				this.level = 30;
			}
			else {
				initStrTouSpeInte(42, 53, 63, 100);
				initWisLibSensCor(100, 1, 100, 50);
				this.weaponAttack = 24;
				this.armorMDef = 24;
				this.bonusHP = 120;
				this.bonusLust = 131;
				this.level = 24;
			}
			this.gems = 0;
			this.drop = NO_DROP;
			if (rand(2) == 0) this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
			else this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGhostType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}