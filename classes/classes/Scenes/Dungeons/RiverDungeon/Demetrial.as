/**
 * ...
 * @author Canadian Snas
 */
package classes.Scenes.Dungeons.RiverDungeon
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Wings;
import classes.Items.DynamicItems;
import classes.Scenes.SceneLib;
import classes.Scenes.Monsters.AbstractAngel;
import classes.internals.*;

use namespace CoC;

	public class Demetrial extends AbstractAngel
	{
		private function dmgForAlmostAll():Number {
			var dFAA:Number = 0;
			dFAA += this.str;
			dFAA += eBaseStrengthDamage();
			dFAA += this.weaponAttack;
			dFAA = Math.round(dFAA);
			return dFAA;
		}
		
		private function moveSwarmbringer():void {
			outputText("The locusts’ buzzing rises to a deafening roar, the insects flying in from every direction. You swing your [weapon] wildly, but they come in from all sides, biting, scratching and stinging. ");
			player.takePhysDamage(dmgForAlmostAll(), true);
			createStatusEffect(StatusEffects.Swarmbringer, 0, 0, 0, 0);
			createStatusEffect(StatusEffects.AbilityCooldown1, 5, 0, 0, 0);
			player.buff("Swarmbringer").addStats({"str":-20,"spe":-20}).withText("Swarmbringer!").combatPermanent();
		}
		private function moveRootOfTheIssue():void {
			outputText("The ground beneath your feet rumbles, the plants of the field begin to shudder and shake around you. Roots erupt from the ground around you, thorns gleaming as they lash at you. ");
			if (player.getEvasionRoll())  outputText("You manage to duck and dodge the roots, narrowly avoiding their clutches. ");
			else {
				outputText("The roots grab you, running their spines across your [skin], carving furrows into you before throwing you skyward with immense force. ");
				var dmg1:Number = dmgForAlmostAll() * 0.5;
				if (hasStatusEffect(StatusEffects.AbilityCooldown2)) dmg1 *= 0.5;
				player.takePhysDamage(Math.round(dmg1), true);
				if (player.canFly()) outputText(" You stabilise yourself mid-flight, now looking down upon the angel and your ally. You’re outside the reach of the angel’s tendrils…and yet, you feel slightly nervous. ");
				createStatusEffect(StatusEffects.RootOfTheIssue, 0, 0, 0, 0);
			}
		}
		private function moveDivineJudgemen():void {
			if (player.canFly()) outputText("The sky above you begins to darken, as clouds form, blocking out the sun. You feel your entire body start to tingle. It’s building up to something big. You feel a sudden urge to land, but before you can react, a veritable wall of lightning forms around you, electricity surging through your body, sending you into convulsions. ");
			else outputText("You flail as the sky darkens, clouds forming around you. You can see sparks around you as you try to orient yourself. You know what’s happening, but you can’t do anything to stop it. A wall of lightning strikes you, sending you into convulsions as the strike slams into your back. ");
			outputText("You plummet towards the ground, crashing hard. You get your [legs] under you as the roots begin to move. ");
			var dmg0:Number = 0;
			dmg0 += this.wis;
			dmg0 += eBaseWisdomDamage();
			dmg0 += this.inte;
			dmg0 += eBaseIntelligenceDamage();
			dmg0 += this.weaponAttack;
			dmg0 = Math.round(dmg0);
			player.takeLightningDamage(dmg0, true);
			removeStatusEffect(StatusEffects.RootOfTheIssue);
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) {
				if (!hasStatusEffect(StatusEffects.ATranscendentSoulField) && soulforce >= 150) createStatusEffect(StatusEffects.ATranscendentSoulField, 100, 100, 0, 0);
				if (hasStatusEffect(StatusEffects.ATranscendentSoulField)) {
					if (soulforce >= 150) soulforce -= 150;
					else removeStatusEffect(StatusEffects.ATranscendentSoulField);
				}
			}
			else {
				if (!hasStatusEffect(StatusEffects.ATranscendentSoulField) && soulforce >= 75) createStatusEffect(StatusEffects.ATranscendentSoulField, 50, 50, 0, 0);
				if (hasStatusEffect(StatusEffects.ATranscendentSoulField)) {
					if (soulforce >= 75) soulforce -= 75;
					else removeStatusEffect(StatusEffects.ATranscendentSoulField);
				}
			}
			RandomiseAction();
			if (hasStatusEffect(StatusEffects.Swarmbringer)) {
				outputText("The swarm continues their relentless assault, practically blinding you with their sheer numbers. You need to do something about this swarm, and quickly!");
				player.takePhysDamage(dmgForAlmostAll(), true);
				outputText("\n\n");
				player.buff("Swarmbringer").addStats({"str": -20, "spe": -20}).withText("Swarmbringer!").combatPermanent();
			}
			if (!hasStatusEffect(StatusEffects.AbilityCooldown1) && !hasStatusEffect(StatusEffects.Swarmbringer)) moveSwarmbringer();
			else {
				if (!hasStatusEffect(StatusEffects.RootOfTheIssue)) moveRootOfTheIssue();
				else moveDivineJudgemen();
			}
		}
		
		protected function RandomiseAction():void {
			if (hasStatusEffect(StatusEffects.Swarmbringer) && !hasStatusEffect(StatusEffects.RootOfTheIssue)) secondFarmerAction();
			else {
				if (rand(2) == 0) firstFarmerAction();
				else thirdFarmerAction();
			}
		}
		private function firstFarmerAction():void {
			outputText("The farmer rushes towards the angel, his rake intercepting the locusts that get in his way. His eyes glow silver, and he leaps into the air, clumsily bringing his rake down across the angel’s main eye. The being roars, and the farmer is thrown back by a wave of force, landing next to you. He rolls to his feet, but he’s battered by the attack. ");
			SceneLib.combat.doPhysicalDamage(dmgForAlmostAll(), true, true, true);
		}
		private function secondFarmerAction():void {
			outputText("The farmer beside you plants his feet, and as the roots come from the ground, he steps away, slashing them with the thin metal prongs.");
			SceneLib.combat.doPhysicalDamage(Math.round(dmgForAlmostAll()*0.1), true, true, true);
			createStatusEffect(StatusEffects.AbilityCooldown2, 1, 0, 0, 0);
		}
		private function thirdFarmerAction():void {
			outputText("You hear an exhaled breath, through the cacophony of bugs and roots. The farmer beside you runs toward the angel, dodging several attacks. His body trails a silver aura, and as he nears the angel, he thrusts three times with his rake. ");
			SceneLib.combat.doPhysicalDamage(dmgForAlmostAll(), true, true, true);
			SceneLib.combat.doPhysicalDamage(dmgForAlmostAll(), true, true, true);
			SceneLib.combat.doPhysicalDamage(dmgForAlmostAll(), true, true, true);
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.riverdungeon.defeatPlantAngel();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.riverdungeon.defeatedByPlantAngel();
		}
		
		override public function get long():String {
			var str:String = "";
			str += "You're standing in front of a figure straight out of a nightmare. A single, multifaceted eye, like a dragonfly's, floats. You feel that no matter where you are, it can always see you.\n\n";
			str += "Around the eye, giant rings of wood spin, tendrils of root spiraling off the wooden frames. Inside, more insect eyes stare out, occasionally focusing on you. The root-tentacles writhe as they spin.\n\n";
			str += "Attached to the eye by mere threads of light, giant translucent wings, not unlike a locust's, flap regularly, seemingly keeping this unearthly thing aloft.";
			if (hasStatusEffect(StatusEffects.TranscendentSoulField)) str += "\n\n<i>From time to time you can notice faint glimmers of puple protective field surrounding it.</i>";
			return str;
		}

		public function Demetrial() 
		{
			super(false);
			this.a = "";
			this.short = "Demetrial, the Angel of Cultivation";
			this.long = "";
			this.tallness = 60;
			initStrTouSpeInte(360, 600, 330, 180);
			initWisLibSensCor(830, 7, 220, -100);
			this.bonusHP = 10000;
			this.bonusLust = 300;
			this.bonusWrath = 1000;
			this.bonusSoulforce = 5000;
			this.additionalXP = 1000;
			this.weaponAttack = 216;
			this.armorDef = 220;
			this.armorMDef = 220;
			this.weaponName = "energy blast";
			this.weaponVerb = "shoot";
			this.armorName = "skin";
			this.lust = 30;
			this.lustVuln = .8;
			this.level = 73;
			this.gems = 65 + rand(30);
			this.randomDropChance = 0.5;
			this.wings.type = Wings.FEATHERED_AVIAN;
			this.randomDropParams = {
				rarity: DynamicItems.RARITY_CHANCES_MINOR_HIGH
			};
			this.drop = new WeightedDrop().
					add(consumables.SNOWFLO,3).
					add(consumables.EMBER_F,3).
					add(consumables.MARAFRU,3).
					add(consumables.BEEHONY,3).
					add(useables.PCRYSTA,2).
					add(useables.SRESIDUE,1).
					add(useables.EL_CORE,1);
			this.createStatusEffect(StatusEffects.ATranscendentSoulField, 100, 100, 0, 0);//X times less dmg, +X lvl diff bonus
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.DieHardHP, 100, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 3, 0, 0, 0);
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createStatusEffect(StatusEffects.PastPresent, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}