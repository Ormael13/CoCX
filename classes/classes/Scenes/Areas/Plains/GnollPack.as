/**
 * ...
 * @author Coalsack
 */
package classes.Scenes.Areas.Plains
{
	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.Scenes.SceneLib;
	import classes.Scenes.NPCs.SidonieFollower;
	import classes.internals.*;
	
	public class GnollPack extends Monster
	{
		public function baseAttack():void
		{
			if (player.getEvasionRoll()) {
				if (player.spe - spe < 8) outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!\n");
				else if (player.spe - spe >= 8 && player.spe - spe < 20) outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!\n");
				else if (player.spe - spe >= 20) outputText("You deftly avoid " + a + short + "'s slow " + weaponVerb + ".\n");
			}
			else {
				outputText("The pack jumps over you, the warriors aiming at your weak spots with the spears while the gnoll rangers toss their javelins.");
				meleeAttack();
				meleeAttack();
				meleeAttack();
				meleeAttack();
			}
		}
		public function SpearRush():void
		{
			if (player.getEvasionRoll()) {
				if (player.spe - spe < 8) outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!\n");
				else if (player.spe - spe >= 8 && player.spe - spe < 20) outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!\n");
				else if (player.spe - spe >= 20) outputText("You deftly avoid " + a + short + "'s slow " + weaponVerb + ".\n");
			}
			else {
				outputText("Running forward, the gnoll warriors slam their spear tips on your body, making you  fall back at the sudden impact, severely harmed.");
				meleeAttack();
				meleeAttack();
			}
		}
		public function Javelins():void
		{
			if (player.getEvasionRoll()) {
				if (player.spe - spe < 8) outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!\n");
				else if (player.spe - spe >= 8 && player.spe - spe < 20) outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!\n");
				else if (player.spe - spe >= 20) outputText("You deftly avoid " + a + short + "'s slow " + weaponVerb + ".\n");
			}
			else {
				outputText("The duo of spear throwers aim at you, and after a surprisingly accurate tossing, manage to hit you with both of their javelins before you can fully retreat from the area.");
				meleeAttack();
				meleeAttack();
			}
		}
		
		private function meleeAttack():void {
			outputText(" ");
			var damage:Number = 0;
			damage = int((str + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
			player.takePhysDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Stunned)) {
				outputText("Your foes are too dazed from your last hit to strike back!");
				removeStatusEffect(StatusEffects.Stunned);
			}
			if (hasStatusEffect(StatusEffects.Fear)) {
				if (statusEffectv1(StatusEffects.Fear) == 0) {
					this.speStat.core.value += statusEffectv2(StatusEffects.Fear);
					removeStatusEffect(StatusEffects.Fear);
					outputText("Your foes shake free of their fear and ready themselves for battle.");
				}
				else {
					addStatusValue(StatusEffects.Fear, 1, -1);
					outputText(capitalA + short + " are too busy shivering with fear to fight.");
				}
			}
			var select:Number = rand(20);
			if (select < 3) Javelins();
			else if (select >= 3 && select < 6) SpearRush();
			else baseAttack();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.sidonieFollower.wonGnollPackFight();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.sidonieFollower.lostGnollPackFight();
		}
		
		public function GnollPack()
		{
			this.a = "the ";
			this.short = "gnoll pack";
			this.imageName = "gnoll";
			this.long = "A decidedly hostile raiding party of angry gnolls. These four have diverted from the main group, and intend to subject you to the same treatment that they had in store for the horse-girl from before. Looking at the pack of barbarians again, you notice that their group is formed for two warriors glaring at you, spears in hand, and two javelineers on the back, hurling projectiles at your direction.";
			this.plural = true;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_LOOSE);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
			this.tallness = 6*12;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.growFur({color:"tawny"});
			this.hairColor = "black";
			this.hairLength = 22;
			initStrTouSpeInte(390, 240, 240, 150);
			initWisLibSensCor(60, 240, 240, 20);
			this.weaponName = "twisted club";
			this.weaponVerb="smash";
			this.weaponAttack = 55;
			this.weaponValue = 25;
			this.armorName = "skin";
			this.armorDef = 70;
			this.armorMDef = 10;
			this.bonusHP = 500;
			this.bonusLust = 522;
			this.lust = 30;
			this.lustVuln = .35;
			this.level = 42;
			this.gems = 800;
			this.drop = new ChainedDrop().
					add(consumables.REDUCTO,1/5).
					add(consumables.SUCMILK,1/4).
					add(weaponsrange.GTHRSPE,1/2).
					elseDrop(consumables.BLACK_D);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
