/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.IMutations.WhiteFacedOneBirthrightMutation;
import classes.Scenes.SceneLib;
import classes.Scenes.Areas.Desert.AnubisScene;
import classes.Stats.Buff;
import classes.internals.*;

	public class Werefox extends Monster
	{
		public function SoulskillMod():Number {
			var mod1:Number = 1;
			if (hasPerk(PerkLib.DaoistApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) mod1 += .3;
				if (hasPerk(PerkLib.SoulPersonage)) mod1 += .3;
				if (hasPerk(PerkLib.SoulWarrior)) mod1 += .3;
			}
			if (hasPerk(PerkLib.DaoistWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) mod1 += .6;
				if (hasPerk(PerkLib.SoulScholar)) mod1 += .6;
				if (hasPerk(PerkLib.SoulGrandmaster)) mod1 += .6;
			}
			if (flags[kFLAGS.WEREFOX_EXTRAS] >= 2) mod1 += 1;
			return mod1;
		}
		private function cost():Number {
			var cost1:Number = 60;
			if (flags[kFLAGS.WEREFOX_EXTRAS] >= 2) cost1 += 30;
			return cost1;
		}
		
		//later add some more attack(s) options for stronger werefoxes
		
		public function createElement():void {
			var type:String = "";
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity))  type = "fire";
			else if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.FireShadowAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) type = "ice";
			else if (player.hasPerk(PerkLib.AquaticAffinity) || player.hasPerk(PerkLib.AffinityUndine)) type = "lightning";
			else {
				if (rand(2) == 0) type = "darkness";
				else {
					if (rand(2) == 0) type = "water";
					else {
						if (rand(2) == 0) type = "earth";
						else type = "wind";
					}
				}
			}
			addSoulforce(-cost());
			outputText("The "+this.short+" infuse a bit of soulforce into a finger, light blue energy covering the tip. She draw a simple rune in the air, the energy from her finger dissipating into it. A moment later, the rune swells, energy forming into a small ball of "+type+". She motion, sending the ball flying toward you.");
			var ElementDmg:Number = eBaseWisdomDamage() * 1.5;
			ElementDmg *= SoulskillMod();
			ElementDmg = Math.round(ElementDmg);
			if (type == "fire") player.takeFireDamage(ElementDmg, true);
			else if (type == "ice") player.takeIceDamage(ElementDmg, true);
			else if (type == "lightning") player.takeLightningDamage(ElementDmg, true);
			else if (type == "darkness") player.takeDarknessDamage(ElementDmg, true);
			else if (type == "water") player.takeWaterDamage(ElementDmg, true);
			else if (type == "earth") player.takeEarthDamage(ElementDmg, true);
			else player.takeWindDamage(ElementDmg, true);
		}
		
		override protected function performCombatAction():void
		{
			var chooser:Number = 0;
			chooser = rand(5);
			if (chooser < 4) {
				if (this.soulforce >= cost()) createElement();
				else eAttack();
			}
			if (chooser >= 4) eAttack();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.werefoxScene.wonWithWerefox();
		}
		  
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.werefoxScene.lostToWerefox();
		}
		
		//flags[kFLAGS.WEREFOX_EXTRAS] >>> 1 - werefox, 2 - elder werefox, ?? 3 - ancient/ancestor werefox ??
		public function Werefox() 
		{
			if (flags[kFLAGS.WEREFOX_EXTRAS] == 1) {
				this.short = "werefox";
				this.long = "Your opponent is a werefox. While halfway human in appearance its glowing green eyes, fennec ears, sharp fangs, three bushy tails and claw armed paws reminds you of its bestial nature.";
				this.createStatusEffect(StatusEffects.BonusVCapacity, 45, 0, 0, 0);
				createBreastRow(Appearance.breastCupInverse("C"));
				initStrTouSpeInte(110, 230, 211, 175);
				initWisLibSensCor(280, 155, 172, -50);
				this.hips.type = Hips.RATING_CURVY;
				this.butt.type = Butt.RATING_AVERAGE + 1;
				this.weaponAttack = 40;
				this.armorDef = 30;
				this.armorMDef = 450;
				this.tailCount = 3;
				this.bonusHP = 1500;
				this.bonusLust = 360;
				this.bonusSoulforce = 2000;
				this.level = 33;
				this.gems = rand(16) + 30;
				this.drop = new WeightedDrop().
						add(consumables.BAGOCA2,1).
						add(consumables.BAGOCA1,3).
						add(consumables.DESERTB,6);
			}
			if (flags[kFLAGS.WEREFOX_EXTRAS] == 2) {
				this.short = "elder werefox";
				this.long = "Your opponent is a elder werefox. While halfway human in appearance its glowing green eyes, fennec ears, sharp fangs, five bushy tails and claw armed paws reminds you of its bestial nature.";
				this.createStatusEffect(StatusEffects.BonusVCapacity, 75, 0, 0, 0);
				createBreastRow(Appearance.breastCupInverse("E"));
				initStrTouSpeInte(231, 455, 411, 315);
				initWisLibSensCor(500, 232, 272, 25);
				this.hips.type = Hips.RATING_CURVY + 2;
				this.butt.type = Butt.RATING_NOTICEABLE + 1;
				this.weaponAttack = 60;
				this.armorDef = 50;
				this.armorMDef = 750;
				this.tailCount = 5;
				this.bonusHP = 3500;
				this.bonusLust = 565;
				this.bonusSoulforce = 5000;
				this.level = 61;
				this.gems = rand(24) + 45;
				this.drop = new WeightedDrop().
						add(consumables.BAGOCA3,1).
						add(consumables.BAGOCA2,3).
						add(consumables.DESERTB,6);
			}
			this.a = "the ";
			//this.imageName = "werefox";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 6*12+2;
			this.hairColor = "white";
			this.hairLength = 9;
			this.weaponName = "paws";
			this.weaponVerb="paw-slash";
			this.armorName = "fur";
			this.lust = 30;
			this.tailType = Tail.FOX;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.BasicSpirituality, 0, 0, 0, 0);
			this.createPerk(PerkLib.HalfStepToImprovedSpirituality, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulPersonage, 0, 0, 0, 0);
			this.createPerk(PerkLib.DaoistApprenticeStage, 0, 0, 0, 0);
			if (flags[kFLAGS.WEREFOX_EXTRAS] >= 2) {
				this.createPerk(PerkLib.ImprovedSpirituality, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToAdvancedSpirituality, 0, 0, 0, 0);
				this.createPerk(PerkLib.AdvancedSpirituality, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
				this.createPerk(PerkLib.DaoistWarriorStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulSprite, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.WEREFOX_EXTRAS] == 1) IMutationsLib.WhiteFacedOneBirthrightIM.acquireMutation(this, "none");
			if (flags[kFLAGS.WEREFOX_EXTRAS] == 2) IMutationsLib.WhiteFacedOneBirthrightIM.acquireMutation(this, "none", 2);
			checkMonster();
		}
		
	}

}