/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Scenes.NPCs.PatchouliScene;
	import classes.Scenes.SceneLib;
	import classes.internals.*;
	
	public class Jabberwocky extends Monster
	{
		public function ClawSwipe():void {
			outputText("The jabberwocky slices you with its claw for ");
			ClawSwipeDmg();
			ClawSwipeDmg();
			outputText(" damage.");
		}
		private function ClawSwipeDmg():void {
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			if (damage < 10) damage = 10;
			if (this.weaponAttack < 51) damage *= (1 + (this.weaponAttack * 0.03));
			else if (this.weaponAttack >= 51 && this.weaponAttack < 101) damage *= (2.5 + ((this.weaponAttack - 50) * 0.025));
			else if (this.weaponAttack >= 101 && this.weaponAttack < 151) damage *= (3.75 + ((this.weaponAttack - 100) * 0.02));
			else if (this.weaponAttack >= 151 && this.weaponAttack < 201) damage *= (4.75 + ((this.weaponAttack - 150) * 0.015));
			else damage *= (5.5 + ((this.weaponAttack - 200) * 0.01));
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
		}
		
		private function HyperFang():void {
			outputText("The jabberwocky bites you with it’s massive incisors, causing a deep wound. You start to bleed. ");
			var damage:Number = 0;
			damage += eBaseDamage();
			player.takePhysDamage(damage, true);
			if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.removeStatusEffect(StatusEffects.Hemorrhage);
			player.createStatusEffect(StatusEffects.Hemorrhage,10,0.1,0,0);
		}
		
		private function TakeFlight():void {
			outputText("The jabberwocky takes flight, likely intending to torch you from afar. ");
			createStatusEffect(StatusEffects.Flying,7,0,0,0);
		}
		
		private function FireBreath():void {
			outputText("The jabberwock inhales and breathes a massive cone of fire in your direction. ");
			var damage:Number = 0;
			damage += eBaseIntelligenceDamage();
			damage += eBaseWisdomDamage();
			if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				player.addStatusValue(StatusEffects.Blizzard, 1, -1);
				damage *= 0.2;
			}
			player.takeFireDamage(damage, true);
			outputText(" damage. ");
		}
		
		override protected function performCombatAction():void {
			if (statusEffectv1(StatusEffects.Flying) == 1) {
				outputText("The jabberwocky flies down and lands.\n\n");
				removeStatusEffect(StatusEffects.Flying);
			}
			var choice:Number = rand(6);
			if (hasStatusEffect(StatusEffects.Flying)) {
				if (choice < 3) ClawSwipe();
				if (choice == 3) HyperFang();
				if (choice == 4 || choice == 5) FireBreath();
			}
			else {
				if (choice < 4) ClawSwipe();
				if (choice == 4) HyperFang();
				if (choice == 5) TakeFlight();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			flags[kFLAGS.PATCHOULI_AND_WONDERLAND] = 2;
			clearOutput();
			if (hpVictory){
				outputText("The jabberwocky dies from the fatal wound you dealt him, its death throes echoing through the forest. While examining the beast’s corpse, you find a peculiar blade stuck in his back. It looks to be enchanted, albeit in which way, you have no idea. On the hilt is carved a single V. You proceed to get out of here with a still shaking Patchouli.\n\n");
				SceneLib.inventory.takeItem(weapons.VBLADE, cleanupAfterCombat);
			} else {
				outputText("The jabberwock falls to the ground, unable to fight further as it begins to masturbate fiercely. You pick up a few items you found in the area, and hurry to get the hell out before the seemingly indestructible beast is back up and ready to fight.\n\n");
				cleanupAfterCombat();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			clearOutput();
			outputText("The last thing you see is the jabberwocky’s open maw, before the rabbit-dragon devours you alive. What a tragic ending to your adventures.\n\n");
			EventParser.gameOver();
		}
		
		public function Jabberwocky() 
		{
			this.a = "";
			this.short = "Jabberwocky";
			this.imageName = "jabberwocky";
			this.long = "The only word that comes to mind when looking at this horror is rabbit-dragon. It is easily 15 feet tall and about three time as long. The jabberwocky looks both ridiculous and horrifyingly strong at the same time. Regardless, it looks keen on killing you.";
			this.createCock(rand(2) + 11, 2.5, CockTypesEnum.DRAGON);
			this.balls = 2;
			this.ballSize = 1;
			createBreastRow(0);
			initStrTouSpeInte(160, 350, 180, 100);
			initWisLibSensCor(100, 10, 50, 50);
			this.tallness = 15*12;
			this.bonusHP = 1000;
			this.additionalXP = 500;
			this.weaponName = "claws";
			this.weaponVerb = "slash";
			this.weaponAttack = 50;
			this.armorName = "dragon scales";
			this.armorDef = 2000;
			this.armorMDef = 10;
			this.bonusLust = 30;
			this.lustVuln = .6;
			this.lust = 50;
			this.level = 60;
			this.drop = new ChainedDrop()
					.add(consumables.JABBERS, 1);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.PeerlessSelfControl, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			checkMonster();
		}	
	}
}