package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.GlobalFlags.kFLAGS;
import classes.internals.*;

import coc.view.CoCButton;

public class Grayda extends Monster
	{
		private function graydaSwing():void {
			outputText("The "+this.short+" lunges forward and slashes you with the sharpened end of her staff. ");
			var damage:Number = 0;
			damage += this.str;
			damage += eBaseDamage();
			damage += eBaseStrengthDamage();
			damage *= 2;
			player.takePhysDamage(damage, true);
			if (rand(4) == 0 && !player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
				else player.createStatusEffect(StatusEffects.Hemorrhage, SceneLib.combat.debuffsOrDoTDuration(3), 0.05, 0, 0);
			}
		}
		private function graydaHeadbutt():void {
			outputText("The "+this.short+" rushes towards you and rams you with her head, knocking you back and disorentating you. ");
			var damage:Number = 0;
			damage += this.str;
			damage += eBaseDamage();
			damage += eBaseStrengthDamage();
			damage *= 3;
			player.takePhysDamage(damage, true);
			if (rand(5) == 0 && !player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		private function graydaManaShot():void {
			outputText("Your opponent slightly raises her staff and slams it back into the water’s surface and a series of blasts are launched from the object on her head. ");
			var damage:Number = 0;
			damage += this.str;
			damage += eBaseDamage();
			damage += eBaseSpeedDamage();
			damage *= 4;
			//damage += this.inte;
			//damage += this.wis;
			//damage += eBaseIntelligenceDamage();
			//damage += eBaseWisdomDamage();
			player.takeMagicDamage(damage, true);
			player.takeMagicDamage(damage, true);
			player.takeMagicDamage(damage, true);
			player.takeMagicDamage(damage, true);
		}
		private function graydaFlyingConstruct():void {
			outputText("The "+this.short+" raises her staff and summons a small group of levitating bird shaped constructs. ");
			var damage:Number = 0;
			damage += this.str;
			damage += eBaseDamage();
			damage += eBaseStrengthDamage();
			damage *= 4;
			var fC:Number = 12;
			while (fC-->0) {
				outputText("A construct firing at you before fizzling out of existence. ");
				player.takeMagicDamage(damage, true);
			}
		}
		private function graydaTerrorize():void {
			outputText("The Arigean’s Countess eyes glow a strong yellow before she waves her staff, causing the fog in the area to grow even denser, obscuring her from your sight. You attempt to move but find your feet have been frozen in place. ");
			player.createStatusEffect(StatusEffects.Terrorize, 0, 0, 0, 0);
		}
		public function graydaTerrorizeStruggle():void
		{
			clearOutput();
			outputText("You try your hardest to get any sort of movement from your feet, moving your legs side to side makes you realize you are stuck in place until whatever force holding you releases you. ");
			outputText("Suddenly a loud growl can be heard from the fog, followed shortly by a sudden and fast appearance of a sea monster’s open mouth quickly snapping you up and shortly vanishing, leaves you in shock.");
			var damage:Number = 0;
			damage += this.str;
			damage += eBaseDamage();
			damage *= 3;
			player.takeMagicDamage(damage, true);
			outputText("\n\n");
			if (!player.hasPerk(PerkLib.Resolute)) player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			player.removeStatusEffect(StatusEffects.Terrorize);
			SceneLib.combat.enemyAIImpl();
		}
		public function graydaTerrorizeWait():void
		{
			clearOutput();
			outputText("You wait for any sign of movement from the dense fog and catch a faint shape moving out from the fog. The head of a sea monster bursts through the fog and with a well timed strike the illusion fizzles and vanishes from existence.\n\n");
			player.removeStatusEffect(StatusEffects.Terrorize);
			SceneLib.combat.enemyAIImpl();
		}
		override public function changeBtnWhenBound(btnStruggle:CoCButton, btnBoundWait:CoCButton):void{
			if (player.hasStatusEffect(StatusEffects.Terrorize)) {
				btnStruggle.call(graydaTerrorizeStruggle);
				btnBoundWait.call(graydaTerrorizeWait);
			}
		}
		override protected function performCombatAction():void
		{
			var choice:Number = rand(5);
			if (choice == 0) graydaSwing();
			if (choice == 1) graydaHeadbutt();
			if (choice == 2) graydaManaShot();
			if (choice == 3) graydaFlyingConstruct();
			if (choice == 4) graydaTerrorize();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.THE_TRENCH_ENTERED] == 7) SceneLib.graydaScene.graydaEncounterLoss2();
			else SceneLib.graydaScene.graydaEncounterLoss();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.THE_TRENCH_ENTERED] == 7) SceneLib.graydaScene.graydaEncounterWin2();
			else SceneLib.graydaScene.graydaEncounterWin();
		}
		
		public function Grayda() 
		{
			this.a = "the ";
			this.short = "arigean countess";
			//this.imageName = "sharkgirl";
			if (flags[kFLAGS.THE_TRENCH_ENTERED] == 7) this.long = "Your enemy is Grayda, a 6’3 Arigean Countess. And although this is just a friendly spar, she is not to be underestimated in the slightest.";
			else this.long = "Your enemy is an Arigean Countess, an elusive being that lurks in depths of the ocean’s waters. A patch of particularly dense dark yellow fog clings around your opponent, Her glowing yellow eyes stare at you with a look of indifference and she holds her staff with seasoned confidence. Judging from the initial attack you would have to guess she’s well practiced in magic.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 15, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,40,0,0,0);
			this.tallness = 6*12+3;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "albino";
			this.hairColor = "white";
			this.hairLength = 16;
			initStrTouSpeInte(230, 190, 210, 290);
			initWisLibSensCor(290, 106, 75, 45);
			this.weaponName = "staff";
			this.weaponVerb="bite";
			this.weaponAttack = 35;
			this.armorName = "white one-piece swimsuit";
			this.armorDef = 60;
			this.armorMDef = 60;
			this.bonusHP = 250;
			this.bonusLust = 251;
			this.lust = 40;
			this.lustVuln = .8;
			this.level = 70;
			this.gems = rand(30) + 25;
			this.drop = new WeightedDrop()
					.add(consumables.SFILLET,1)
					.add(consumables.C_STEAK,1)
					.add(consumables.C_JERKY,1)
					.add(consumables.SIINGOT,3)
					.add(consumables.L_B_BAR,3)
					.add(consumables.EAINGOT,3);
			//this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}