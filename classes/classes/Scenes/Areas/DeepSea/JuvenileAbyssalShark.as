/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.DeepSea 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class JuvenileAbyssalShark extends Monster
	{
		public function castHailOfSwordfishesSoulskill():void {
			outputText("Letting soulforce leak out around him, "+this.short+" form twelve ethereal two meter long weapons looking like swordfishes in two rows. Then he thrust his hand outwards and in the blink of an eye, weapons shoot forwards you. Weapons hits you, dealing ");
			addSoulforce(-90);
			var hobD:Number = 6;
			while (hobD-->0) bladesD(2);
			outputText("damage!");
		}
		private function bladesD(hits:Number = 1):void {
			var bd:Number = 0;
			bd += this.wis * 0.5;
			bd += wisdomscalingbonus() * 0.5;
			if (bd < 10) bd = 10;
			bd *= 1.9;
			var crit:Boolean = false;
			var critChance:int = 5;
			if (this.wis <= 200) critChance += this.wis / 10;
			if (this.wis > 200) critChance += 20;
			if (rand(100) < critChance) {
				crit = true;
				bd *= 1.75;
			}
			var bd2:Number = 0.9;
			bd2 += (rand(21) * 0.01);
			bd *= bd2;
			bd = Math.round(bd);
			bd = player.takeMagicDamage(bd, true);
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText(" ");
			if (hits == 2) {
				bd = player.takeMagicDamage(bd, true);
				if (crit == true) outputText(" <b>*Critical Hit!*</b>");
				outputText(" ");
			}
		}
		
		public function createElement():void {
			var type:String = "";
			if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.FireShadowAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) type = "ice";
			else {
				if (rand(2) == 0) type = "darkness";
				else type = "water";
			}
			addSoulforce(-60);
			outputText("The "+this.short+" infuse a bit of soulforce into a finger, light blue energy covering the tip. She draw a simple rune in the water, the energy from his finger dissipating into it. A moment later, the rune swells, energy forming into a small ball of "+type+". He motion, sending the ball flying toward you.");
			var ElementDmg:Number = eBaseWisdomDamage();
			ElementDmg *= 2;
			ElementDmg = Math.round(ElementDmg);
			if (type == "ice") player.takeIceDamage(ElementDmg, true);
			else if (type == "darkness") player.takeDarknessDamage(ElementDmg, true);
			else player.takeWaterDamage(ElementDmg, true);
		}
		
		private function abyssalSharkBiteAttack():void {
			outputText("Your opponent takes a turn and charges at you at high speed, large jaw open as he goes in for the kill, viciously biting you. You start to bleed in abundance the water around you turning red. ");
			var damage:Number = 0;
			damage += (eBaseDamage() * 2);
			player.takePhysDamage(damage, true);
			if (player.hasStatusEffect(StatusEffects.CombatWounds) && player.statusEffectv1(StatusEffects.CombatWounds) < 0.99) player.addStatusValue(StatusEffects.CombatWounds, 1, 0.01);
			if (!player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
				else player.createStatusEffect(StatusEffects.Hemorrhage, SceneLib.combat.debuffsOrDoTDuration(3), 0.1, 0, 0);
			}
		}
		
		override protected function performCombatAction():void
		{
			var chooser:Number = 0;
			chooser = rand(4);
			if (chooser < 2) {
				if (this.soulforce >= 60) createElement();
				else abyssalSharkBiteAttack();
			}
			if (chooser == 2) {
				if (this.soulforce >= 90) castHailOfSwordfishesSoulskill();
				else abyssalSharkBiteAttack();
			}
			if (chooser == 3) abyssalSharkBiteAttack();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.abyssalsharkScene.oceanJuvenileAbyssalSharkDefeated();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.abyssalsharkScene.oceanJuvenileAbyssalSharkVictorious();
		}
		
		public function JuvenileAbyssalShark() 
		{
			this.a = "the ";
			this.short = "juvenile abyssal shark";
			//this.imageName = "kraken";
			this.long = "You are currently fighting 11 feet tall juvenile abyssal shark. He looks very similar to shark girls you meet if not for the different look of the head, which looks like flattened into hammer shape with massive jaws in front and eyes on the sides.";
			// this.plural = false;
			this.createCock(20,2.5);
			this.balls = 2;
			this.ballSize = 4;
			this.cumMultiplier = 6;
			this.hoursSinceCum = 400;
			createBreastRow();
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 11*12;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.lowerBody = LowerBody.ABYSSAL_SHARK;
			this.bodyColor = "gray";
			this.hairColor = "silver";
			this.hairLength = 5;
			initStrTouSpeInte(400, 300, 300, 150);
			initWisLibSensCor(300, 100, 300, 100);
			this.weaponName = "shark teeth";
			this.weaponVerb="bite";
			this.weaponAttack = 35;
			this.armorName = "tough skin";
			this.armorDef = 100;
			this.armorMDef = 10;
			this.bonusHP = 2000;
			this.bonusLust = 473;
			this.bonusSoulforce = 100;
			this.lust = 20;
			this.lustVuln = .2;
			this.level = 73;
			this.gems = 0;
			this.drop = new WeightedDrop()
					.add(consumables.BAGOCA1,1)
					.add(consumables.SHARK_T,1)
					.add(consumables.ASTOOTH,3);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulPersonage, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
			this.createPerk(PerkLib.DaoistApprenticeStage, 0, 0, 0, 0);
			this.createPerk(PerkLib.WaterNature, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}