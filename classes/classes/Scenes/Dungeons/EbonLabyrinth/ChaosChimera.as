/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.EbonLabyrinth 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class ChaosChimera extends Monster
	{
		private function PentaAttack():void
		{
			outputText("The chimera smashes its claws at you for ");
			PentaAttackDamage();
			outputText("damage.\n\nThe chimera smashes its claws at you for ");
			PentaAttackDamage();
			outputText("damage.\n\nThe chimera’s dragon head tries to bite you. ");
			PentaAttackDamage();
			outputText("\n\nThe chimera’s lion head tries to bite you. ");
			PentaAttackDamage();
			outputText("\n\nThe chimera’s goat head tries to bite you. ");
			PentaAttackDamage();
		}
		private function PentaAttackDamage():void
		{
			var damage:Number = this.str * 2;
			damage += this.spe * 2;
			var damage2:Number = 0.9;
			damage2 += (rand(21) * 0.01);
			damage *= damage2;
			damage = Math.round(damage);
			damage = player.takePhysDamage(damage, true);
		}
		private function SnakeBite():void
		{
			outputText("The chimera tail’s snakehead tries to bite you. ");
			if (player.getEvasionRoll()) outputText("You barely get out of the way in time!");
			else {
				outputText("You are badly poisoned!");
				var damage:Number = this.inte * 2;
				damage += this.wis * 2;
				damage = Math.round(damage);
				damage = player.takePoisonDamage(damage, true);
				player.dynStats("lus", 7 + rand(5) + player.sens / 5);
			}
		}
		private function Dragonbreath():void
		{
			outputText("The chimera’s dragon head suddenly starts to inhale before unleashing a torrent of fire at you! ");
			if (player.getEvasionRoll()) outputText("You barely get out of the way in time!");
			else {
				var damage:Number = 0;
				damage += 1000 + (this.inte * 4) + rand(100);
				if (player.hasStatusEffect(StatusEffects.Blizzard)) {
					player.addStatusValue(StatusEffects.Blizzard, 1, -1);
					damage *= 0.2;
				}
				damage = Math.round(damage);
				damage = player.takeFireDamage(damage, true);
				createStatusEffect(StatusEffects.AbilityCooldown1, 4, 0, 0, 0);
			}
		}
		private function Curse():void
		{
			var resist:int = 0;
			if (player.inte < 30) resist = Math.round(player.inte);
			else resist = 30;
			if (player.findPerk(PerkLib.Whispered) >= 0) resist += 20;
			if ((player.findPerk(PerkLib.HistoryReligious) >= 0 || player.findPerk(PerkLib.PastLifeReligious) >= 0) && player.cor < 20) resist += 20 - player.cor;
			var select:int = rand(7);
			//Attack:
			if (select == 0) {
				outputText("The goat head incants a spell, placing a powerful curse on you, limiting your ability to attack with weapon. You'll have to wait for it to wear off before you can use your basic attacks.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 0, 0, 0);
			}
			else if (select == 1) {
				//Tease:
				outputText("The goat head incants a spell, placing a powerful curse on you, limiting your ability to use tease. Seems you won't be getting anyone hot and bothered until it wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 1, 0, 0);
			}
			//Spells:
			else if (select == 2) {
				outputText("The goat head incants a spell, placing a powerful curse on you, limiting your ability to use spells. You won't be able to cast any spells until it wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 2, 0, 0);
			}
			//Items:
			else if (select == 3) {
				outputText("The goat head incants a spell, placing a powerful curse on you, limiting your ability to use your item pouch. Looks like you won't be using any items until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 3, 0, 0);
			}
			//Run:
			else if (select == 4) {
				outputText("The goat head incants a spell, placing a powerful curse on you, limiting your ability to escape battle.  You'll have to tough it out until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 4, 0, 0);
			}
			//P.Special:
			else if (select == 5) {
				outputText("The goat head incants a spell, placing a powerful curse on you, limiting your ability to use physical skills. You won't be able to use any of them until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 5, 0, 0);
			}
			//M.Special:
			else {
				outputText("The goat head incants a spell, placing a powerful curse on you, limiting your ability to use magical skills. You won't be able to use any of them until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 6, 0, 0);
			}
			if (resist >= rand(100)) {
				outputText("\n\nUpon your touch, the curse dissipates, and you are free of the chimera's magic!  He frown in disappointment, looking thoroughly irritated, but quickly resumes his dedly enemy facade.");
				player.removeStatusEffect(StatusEffects.Sealed);
			}
		}
		private function TakeFlight():void
		{
			outputText("The chimera lifts off and takes flight, readying to repeatedly strike at you from above.");
			createStatusEffect(StatusEffects.Flying,6,0,0,0);
		}
		private function FlybyAttack():void
		{
			outputText("The chimera makes a flyby attack trying to rake you with its hind paws as it dives by your position. ");
			var damage:Number = this.str * 2;
			damage += this.spe * 3;
			damage = Math.round(damage);
			damage = player.takePhysDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Flying) && statusEffectv1(StatusEffects.Flying) <= 1) {
				outputText("The chimera lands next to you. Ready to resume its assault.\n\n");
				removeStatusEffect(StatusEffects.Flying);
			}
			if (hasStatusEffect(StatusEffects.Flying)) {
				if (!player.hasStatusEffect(StatusEffects.Sealed)) Curse();
				else if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) Dragonbreath();
				else FlybyAttack();
			}
			var choice:Number = rand(7);
			if (choice == 0) PentaAttack();
			if (choice == 1) SnakeBite();
			if (choice == 2 || choice == 3) {
				if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) Dragonbreath();
				else SnakeBite();
			}
			if (choice == 4 || choice == 5) {
				if (!player.hasStatusEffect(StatusEffects.Sealed)) Curse();
				else PentaAttack();
			}
			if (choice == 6) TakeFlight();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.defeatChaosChimera();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.ebonlabyrinth.defeatedByChaosChimera();
		}
		
		public function ChaosChimera() 
		{
			this.a = " ";
			this.short = "Chaos Chimera";
			this.long = "You are fighting a twelve-foot tall chimera. The beast has no less than four heads, a dragon, a lion, a goat, and a snake. All of them are ready to tear you apart. Its massive dragon-like wings hint at its ability to fly and the snake head on its tail is likely highly venomous. The goat head seems to regularly chant an incantation too, you can’t dismiss the likelihood that this beast uses magic.";
			this.tallness = 12 * 9;
			this.createCock(24, 5, CockTypesEnum.DEMON);
			this.createBreastRow(0);
			this.balls = 2;
			this.ballSize = 4;
			this.hoursSinceCum = 9999;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			initStrTouSpeInte(240, 310, 190, 210);
			initWisLibSensCor(80, 160, 40, 100);
			this.weaponName = "spear";
			this.weaponAttack = 38;
			this.weaponVerb = "lunge";
			this.armorName = "chitin";
			this.armorDef = 120;
			this.armorMDef = 20;
			this.bonusHP = 100000;
			this.bonusLust = 40;
			this.gems = 200 + rand(80);
			this.additionalXP = 1500;
			this.level = 70;
			this.lustVuln = 0.45;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.drop = NO_DROP;
			this.checkMonster();
		}
	}
}