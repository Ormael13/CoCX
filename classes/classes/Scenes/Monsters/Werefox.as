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
//import classes.BodyParts.LowerBody;
//import classes.BodyParts.Skin;
import classes.IMutations.IMutationsLib;
import classes.IMutations.WhiteFacedOneBirthrightMutation;
import classes.Scenes.SceneLib;
import classes.Scenes.Areas.Desert.AnubisScene;
import classes.Stats.Buff;
import classes.internals.*;

	public class Werefox extends Monster
	{
		public function createElement():void {
			var type:String = "";
			if (player.hasPerk(PerkLib.FromTheFrozenWaste) || player.hasPerk(PerkLib.ColdAffinity))  type = "fire";
			else if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.AffinityIgnis)) type = "ice";
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
			addSoulforce(-60);
			outputText("The werefox infuse a bit of soulforce into a finger, light blue energy covering the tip. She draw a simple rune in the air, the energy from her finger dissipating into it. A moment later, the rune swells, energy forming into a small ball of "+type+". She motion, sending the ball flying toward you.");
			var ElementDmg:Number = eBaseWisdomDamage();
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
				if (this.soulforce >= 60) createElement();
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
		
		public function Werefox() 
		{
			
			this.short = "werefox";
			this.long = "Your opponent is a werefox. While halfway human in appearance its glowing green eyes, fennec ears, sharp fangs, three bushy tails and claw armed paws reminds you of its bestial nature.";
			initStrTouSpeInte(55, 110, 91, 75);
			initWisLibSensCor(125, 55, 72, 25);
			this.weaponAttack = 11;
			this.armorDef = 5;
			this.armorMDef = 200;
			this.tailCount = 3;
			this.bonusHP = 1000;
			this.bonusLust = 146;
			this.bonusSoulforce = 1000;
			this.level = 19;
			this.gems = rand(16) + 30;
			
			this.a = "the ";
			//this.imageName = "werefox";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 60, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 6*12+2;
			this.hips.type = Hips.RATING_CURVY + 1;
			this.butt.type = Butt.RATING_NOTICEABLE;
			this.hairColor = "white";
			this.hairLength = 9;
			this.weaponName = "paws";
			this.weaponVerb="paw-slash";
			this.armorName = "fur";
			this.lust = 30;
			this.drop = new WeightedDrop().
					add(null,1).
					//add(consumables.REPTLUM,2).
					add(consumables.DESERTB,5);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.BasicSpirituality, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulPersonage, 0, 0, 0, 0);
			IMutationsLib.WhiteFacedOneBirthrightIM.acquireMutation(this, "none");
			checkMonster();
		}
		
	}

}