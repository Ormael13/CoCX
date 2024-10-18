package classes.Scenes.Areas.Beach 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.GlobalFlags.kFLAGS;
import classes.internals.*;

import coc.view.CoCButton;

public class ArigeanOmnibusAbomination extends Monster
	{
		override public function combatStatusesUpdateWhenBound():void{
			tentacleBindUpdateWhenBound();
		}

		override public function playerBoundStruggle():Boolean{
			return tentacleBindStruggle();
		}

		override public function playerBoundWait():Boolean{
			return tentacleBindWait();
		}

		private function arigeanOmnibusAbominationFoulMagic():void {
			outputText("Her body goes limp before her arms lazily start tracing various shapes in the air, quickly gaining a crackling aura as she strikes you with a bolt of pink lightning. \"<i>P-please k- GIVE UP ALREADY!</i>\" ");
			var lustDmg:Number = 0;
			lustDmg += Math.round(eBaseIntelligenceDamage() / 3);
			if (player.hasStatusEffect(StatusEffects.PlayerBoundPhysical)) lustDmg *= 2;
			player.takeLustDamage(lustDmg, true);
		}
		private function arigeanOmnibusAbominationSpray():void {
			outputText("The mutant swiftly starts stroking her member while groping herself, and very quickly reaches her limit, spraying you with demonic cum.");
			var lustDmg:Number = this.lust;
			lustDmg += this.lib;
			lustDmg *= 3;
			if (player.hasStatusEffect(StatusEffects.PlayerBoundPhysical)) lustDmg *= 2;
			this.lust = 0;
			player.takeLustDamage(lustDmg, true);
		}
		private function arigeanOmnibusAbominationSquirt():void {
			outputText("Her various mouths start heavily leaking cum before spraying a thick stream towards you.");
			var lustDmg:Number = 0;
			lustDmg += this.lib;
			lustDmg *= 3;
			if (player.hasStatusEffect(StatusEffects.PlayerBoundPhysical)) lustDmg *= 2;
			player.takeLustDamage(lustDmg, true);
		}
		private function arigeanOmnibusAbominationMultiBite():void {
			outputText("One of her various mouths growls before clamping its jaws down on you.");
			var damage:Number = 0;
			damage += this.str;
			damage += eBaseDamage();
			damage += eBaseSpeedDamage();
			damage *= 4;
			if (player.hasStatusEffect(StatusEffects.PlayerBoundPhysical)) damage *= 2;
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
		}
		private function arigeanOmnibusAbominationMultiSlap():void {
			outputText("The mutant Arigean wildly flails her tentacles around. ");
			var damage:Number = 0;
			damage += this.str;
			damage += eBaseDamage();
			damage += eBaseStrengthDamage();
			damage *= 3;
			if (player.hasStatusEffect(StatusEffects.PlayerBoundPhysical)) damage *= 2;
			player.takePhysDamage(damage, true);
		}
		private function arigeanOmnibusAbominationViolate():void {
			outputText("A singular tentacle swiftly enters your mouth, quickly filling it with what you can only assume is cum. While multiple mouths lick various intimate parts around your body. \"<i>I-im sorr- FEELING GREAT! AHAHAHA!</i>\" her voice madly calls out. ");
			var lustDmg:Number = 0;
			lustDmg += eBaseIntelligenceDamage();
			player.takeLustDamage(lustDmg, true);
		}
		private function arigeanOmnibusAbominationEnsnare():void {
			outputText("Multiple tentacles burst out of the writhing mass supporting her, reaching out for limbs and anything they can get ahold of. ");
			if (rand(3) == 0 || rand(80) < player.str / 2 || player.hasPerk(PerkLib.FluidBody)) outputText("Fortunately, you're much quicker than they are and evade their grasps.");
			else {
				outputText("They find their target, swiftly grabbing and entangling you within the mass.");
				player.createStatusEffect(StatusEffects.PlayerBoundPhysical, 0, 0, 0, 0);
			}
		}
		public function arigeanOmnibusAbominationEnsnareStruggle():void
		{
			clearOutput();
			outputText("You struggle with all of your might to free yourself from the tentacles before the creature can fulfill whatever unholy desire it has for you.\n");
			//33% chance to break free + up to 50% chance for strength
            if (rand(3) == 0 || rand(80) < player.str / 2 || player.hasPerk(PerkLib.FluidBody)) {
                outputText("You're able to use your strength to slip out of the slippery tentacles.\n\n");
                player.removeStatusEffect(StatusEffects.PlayerBoundPhysical);
                createStatusEffect(StatusEffects.TentacleCoolDown, 3, 0, 0, 0);
            }
            //Fail to break free
            else {
                outputText("Despite trying to escape, the mutant Arigean only tightens her grip, making it difficult to breathe.\n\n");
                player.takePhysDamage(5);
                player.takeLustDamage((3 + player.effectiveSensitivity() / 10 + player.lib / 20), true);
            }
			SceneLib.combat.enemyAIImpl();
		}
		public function arigeanOmnibusAbominationEnsnareWait():void
		{
			clearOutput();
			outputText("You wait for any sign of movement from the dense fog and catch a faint shape moving out from the fog. The head of a sea monster bursts through the fog, and with a well-timed strike, the illusion fizzles and vanishes from existence.\n\n");
			player.removeStatusEffect(StatusEffects.Terrorize);
			SceneLib.combat.enemyAIImpl();
		}
		override public function changeBtnWhenBound(btnStruggle:CoCButton, btnBoundWait:CoCButton):void{
			if (player.hasStatusEffect(StatusEffects.PlayerBoundPhysical)) {
				btnStruggle.call(arigeanOmnibusAbominationEnsnareStruggle);
				btnBoundWait.call(arigeanOmnibusAbominationEnsnareWait);
			}
		}
		override protected function performCombatAction():void
		{
			this.lust += 40;
			var choice:Number = rand(5);
			if (choice == 0 || choice == 1) {
				if (player.hasStatusEffect(StatusEffects.TentacleCoolDown)) arigeanOmnibusAbominationFoulMagic();
				else {
					if (player.hasStatusEffect(StatusEffects.PlayerBoundPhysical)) arigeanOmnibusAbominationViolate();
					else arigeanOmnibusAbominationEnsnare();
				}
			}
			if (choice == 2) {
				if (rand(2) == 0) arigeanOmnibusAbominationMultiSlap();
				else arigeanOmnibusAbominationMultiBite();
			}
			if (choice == 3) {
				if (rand(2) == 0) arigeanOmnibusAbominationSquirt();
				else arigeanOmnibusAbominationSpray();
			}
			if (choice == 4) arigeanOmnibusAbominationFoulMagic();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.beach.arigeanOmnibusAbominationScene.arigeanOmnibusAbominationEncounterLoss();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.beach.arigeanOmnibusAbominationScene.arigeanOmnibusAbominationEncounterWin();
		}
		
		override public function get long():String
		{
			var str:String = "";
			str += "You're fighting the Arigean Abomination. The poor girl seems to have been completely taken over by her symbiote and reeks of corruption. Multiple writhing tentacles and mouths leak a viscous white fluid, and almost every orifice of her body seems ";
			str += "to be violated as she seemingly reaches her peak multiple times. Multiple injuries litter her body she has yet to recover from.\n\n<b>She seems to produce a strong pheromone which makes your body feel tingly, it’s best to end this quickly.</b>";
			return str;
		}
		
		public function ArigeanOmnibusAbomination() 
		{
			this.a = "the ";
			this.short = "arigean abomination";
			//this.imageName = "sharkgirl";
			this.long = "";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("B"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIMY;
			this.createStatusEffect(StatusEffects.BonusACapacity,80,0,0,0);
			this.tallness = 6*12+8;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_NOTICEABLE;
			this.bodyColor = "albino";
			this.hairColor = "white";
			this.hairLength = 16;
			initStrTouSpeInte(253, 191, 224, 342);
			initWisLibSensCor(321, 306, 125, 90);
			this.weaponName = "tentacles";
			this.weaponVerb="slap";
			this.weaponAttack = 35;
			this.armorName = "white one-piece swimsuit";
			this.armorDef = 30;
			this.armorMDef = 30;
			this.bonusHP = 100;
			this.bonusLust = 511;
			this.lust = 40;
			this.lustVuln = .2;
			this.level = 80;
			this.gems = rand(30) + 25;
			this.drop = new WeightedDrop()
					.add(consumables.SIINGOT,3)
					.add(consumables.L_B_BAR,3)
					.add(consumables.EAINGOT,3);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}