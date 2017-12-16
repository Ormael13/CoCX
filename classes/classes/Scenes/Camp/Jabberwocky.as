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
		public var patchouli:PatchouliScene = new PatchouliScene();
		
		public function ClawSwipe():void {
			outputText("The jabberwocky slices you with its claw for ");
			ClawSwipeDmg();
			ClawSwipeDmg();
			outputText(" damage.");
		}
		public function ClawSwipeDmg():void {
			var damage:Number = 0;
			damage += eBaseStrengthDamage() * 0.75;
			damage = player.reduceDamage(damage);
			if (damage < 10) damage = 10;
			if (this.weaponAttack < 51) damage *= (1 + (this.weaponAttack * 0.03));
			else if (this.weaponAttack >= 51 && this.weaponAttack < 101) damage *= (2.5 + ((this.weaponAttack - 50) * 0.025));
			else if (this.weaponAttack >= 101 && this.weaponAttack < 151) damage *= (3.75 + ((this.weaponAttack - 100) * 0.02));
			else if (this.weaponAttack >= 151 && this.weaponAttack < 201) damage *= (4.75 + ((this.weaponAttack - 150) * 0.015));
			else damage *= (5.5 + ((this.weaponAttack - 200) * 0.01));
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
		}
		
		public function HyperFang():void {
			game.spriteSelect(70);
			outputText("The jabberwocky bites you with it’s massive incisors, causing a deep wound. You start to bleed. ");
			var damage:Number = 0;
			damage += eBaseDamage();
			player.takePhysDamage(damage, true);
			if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.removeStatusEffect(StatusEffects.Hemorrhage);
			player.createStatusEffect(StatusEffects.Hemorrhage,10,0.1,0,0);
		}
		
		private function Flying():void {
			
		}
		
		override protected function performCombatAction():void {
			var choice:Number = rand(5);
			if (choice < 3) ClawSwipe();
			if (choice == 3) HyperFang();
			if (choice == 4) ClawSwipe();//flying + using fire breath when flying instead this one option
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			flags[kFLAGS.PATCHOULI_AND_WONDERLAND] = 2;
			if (this.HP < 1) patchouli.patchouliExploreWonderlandJabberwockyHP();
			else patchouli.patchouliExploreWonderlandJabberwockyLust();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			patchouli.patchouliExploreWonderlandJabberwockyLost();
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
			this.weaponAttack = 40;
			this.armorName = "dragon scales";
			this.armorDef = 800;
			this.bonusLust = 30;
			this.lustVuln = .5;
			this.lust = 50;
			this.level = 60;
			this.drop = new ChainedDrop()
					.add(consumables.JABBERS, 1);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.SuperiorSelfControl, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			checkMonster();
		}	
	}
}