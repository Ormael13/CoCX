/**
 * ...
 * @author Ormael (for now)
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class Koshya extends Monster
	{
		public function soulskillCostEnergyProjection():Number {
			var cost:Number = 100;
			//if (hasPerk(PerkLib.DaoistCultivator)) cost -= 10;
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) cost *= 3;
			return cost;
		}
		/*
		public function SoulskillMod():Number {
			var mod1:Number = 1;
			if (hasPerk(PerkLib.DaoistCultivator)) mod1 += .2;
			if (hasPerk(PerkLib.DaoistApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) mod1 += .4;
				if (hasPerk(PerkLib.SoulPersonage)) mod1 += .4;
				if (hasPerk(PerkLib.SoulWarrior)) mod1 += .4;
			}
			if (hasPerk(PerkLib.DaoistWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) mod1 += .6;
				if (hasPerk(PerkLib.SoulScholar)) mod1 += .6;
				if (hasPerk(PerkLib.SoulElder)) mod1 += .6;
			}
			return mod1;
		}
		*/
		public function castEnergyProjectionKoshya():void {
			outputText("Her eyes begins to glow with a harsh radiance as energy gathers around her. In a flash, you're struck by a large cross-shaped explosion. ");
			soulforce -= soulskillCostEnergyProjection();
			var damage:Number = eBaseIntelligenceDamage();
			damage += eBaseWisdomDamage();
			//damage *= SoulskillMod();
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) damage *= 2;
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			if (!hasStatusEffect(StatusEffects.ATranscendentSoulField) && soulforce >= 10) createStatusEffect(StatusEffects.ATranscendentSoulField, 10, 10, 0, 0);
			if (hasStatusEffect(StatusEffects.ATranscendentSoulField)) {
				if (soulforce >= 10) soulforce -= 10;
				else removeStatusEffect(StatusEffects.ATranscendentSoulField);
			}
			var choice:Number = rand(3);
			if (choice == 0) {
				if (soulforce >= soulskillCostEnergyProjection()) castEnergyProjectionKoshya();
				else eAttack();
			}
			if (choice > 0) eAttack();
		}
		
		override public function get long():String
		{
			var str:String = "";
			str += "You're fighting pale blue skinned women with snow white medium long hair. Using her snow-white wings she constantly stays airborne.";// A powerful pure aura emanates from her.
			if (hasStatusEffect(StatusEffects.ATranscendentSoulField))
			{
				str += "\n\n<i>From time to time you can notice faint glimmers of orange protective field surrounding her.";
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " After your attacks if assume octagonal shapes.";
				str += "</i>";
			}
			return str;
		}
		
		public function Koshya() 
		{
			this.a = "the ";
			this.short = "angel";
			this.imageName = "koshya";
			this.long = "";
			// this.plural = false;
			initGenderless();
			createBreastRow(Appearance.breastCupInverse("A"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,15,0,0,0);
			this.tallness = 8*12+6;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE;
			initStrTouSpeInte(45, 95, 80, 50);
			initWisLibSensCor(110, 25, 15, 0);
			this.skinTone = "pale blue";
			this.hairColor = "white";
			this.hairLength = 16;
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 5;
			this.armorName = "skin";
			this.armorDef = 150;
			this.armorMDef = 150;
            this.bonusHP = 500;
			this.bonusLust = 58;
			this.bonusWrath = 50;
			this.bonusSoulforce = 100;
			this.lustVuln = .75;
			this.lust = 30;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 18;
			this.gems = rand(25) + 138;
			this.drop = NO_DROP;
			this.createStatusEffect(StatusEffects.ATranscendentSoulField, 10, 10, 0, 0);//X times less dmg, +X lvl diff bonus
			this.createPerk(PerkLib.OverMaxHP, 10, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 2, 0, 0, 0);
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.InsightfulResourcesI, 0, 0, 0, 0);
			checkMonster();
		}
	}
}