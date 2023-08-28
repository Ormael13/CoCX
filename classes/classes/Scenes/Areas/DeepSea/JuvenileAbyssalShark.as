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
		private function abyssalSharkBiteAttack():void {
			outputText("Your opponent takes a turn and charges at you at high speed, large jaw open as he goes in for the kill, viciously biting you. You start to bleed in abundance the water around you turning red. ");
			var damage:Number = 0;
			damage += (eBaseDamage() * 2);
			player.takePhysDamage(damage, true);
			if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
			else player.createStatusEffect(StatusEffects.Hemorrhage,SceneLib.combat.debuffsOrDoTDuration(4),0.1,0,0);
		}
		
		override protected function performCombatAction():void
		{
			var chooser:Number = 0;
			chooser = rand(3);/*
			if (chooser < 4) {
				if (this.soulforce >= cost()) createElement();
				else eAttack();
			}*/if (chooser < 2) 
			if (chooser >= 2) eAttack();
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
			this.long = "You are currently fighting 10 feet tall juvenile abyssal shark. He looks very similar to shark girls you meet if not for the different look of the head, which looks like flattened into hammer shape with massive jaws in front and eyes on the sides.";
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
			this.drop = new WeightedDrop(consumables.ASTOOTH, 1);
			//this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			//this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			//this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}