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
			var cost:Number = 20;
			//if (hasPerk(PerkLib.DaoistApprenticeStage)) cost -= 2;
			//if (hasPerk(PerkLib.DaoistWarriorStage)) cost -= 2;
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) cost *= 2;
			return cost;
		}
		/*
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
			return mod1;
		}
		*/
		public function castEnergyProjectionKoshya():void {
			outputText("Her eyes begins to glow with a harsh radiance as energy gathers around her. In a flash, you're struck by a large cross-shaped explosion. ");
			soulforce -= soulskillCostEnergyProjection();
			var damage:Number = eBaseIntelligenceDamage();
			damage += eBaseWisdomDamage();
			//damage *= SoulskillMod();
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) damage *= 3;
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
		}
		
		override protected function performCombatAction():void
		{
			if (!hasStatusEffect(StatusEffects.ATranscendentSoulField) && soulforce >= 20) createStatusEffect(StatusEffects.ATranscendentSoulField, 20, 20, 0, 0);
			if (hasStatusEffect(StatusEffects.ATranscendentSoulField)) {
				if (soulforce >= 20) soulforce -= 20;
				else removeStatusEffect(StatusEffects.ATranscendentSoulField);
			}
			var choice:Number = rand(3);
			if (choice == 0) {
				if (soulforce >= soulskillCostEnergyProjection()) castEnergyProjectionKoshya();
				else eAttack();
			}
			if (choice > 0) eAttack();
		}
		
		private function angelification():void {
			clearOutput();
			var TB:Number = Math.round(touStat.core.value * 0.2);
			var SB:Number = Math.round(speStat.core.value * 0.1);
			var WB:Number = Math.round(wisStat.core.value * 0.3);
			touStat.core.value += TB;
			speStat.core.value += SB;
			wisStat.core.value += WB;
			createPerk(PerkLib.MonsterRegeneration, 3, 0, 0, 0);
			addPerkValue(PerkLib.DieHardHP, 1, 9);
			addStatusValue(StatusEffects.TranscendentSoulField, 1, 20);
			addStatusValue(StatusEffects.TranscendentSoulField, 2, 20);
			HP = maxHP();
			bonusWrath += 1000;
			bonusSoulforce += 2000;
			outputText("Recoiling, the woman saves herself from humiliatingly crashing to the ground with a graceless pose. Just as you think she has given up her glowing halo intensifise engulfing her body in a cocoon of light. After half a minute the cocoon of light dims and unfolds to reveal her new form.\n"
				+ "\n"
				+ "The now visible cocoon is shown to be five newly grown pairs of wings, each with three to four moving eyes. Her body is similarly covered in eyes, and as you study her features two new eyes open on her forehead. The halo that once hovered above her head is now split in two rotating around her and festooned with eyes.\n"
				+ "\n"
				+ "\"<i>That I should take this form is a grave misfortune!!!</i>\" she belows indignantly before launching up to continue the fight.");
			createStatusEffect(StatusEffects.TrueFormAngel, 0, 0, 0, 0);
			SceneLib.combat.combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (!hasStatusEffect(StatusEffects.TrueFormAngel)) {
				angelification();
				return;
			}
			cleanupAfterCombat();
		}
		
		override public function get long():String
		{
			var str:String = "";
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += "You're fighting pale blue skinned women with snow white medium long hair. Using her six pairs of snow-white wings she constantly stays airborne. On wings or her body you can see many closed eyeballs. Runic bracelets on her hands looks like they been partialy cracked. Around her rotate twin halo with more eyes on them. A powerful pure aura emanates from her.";
			else str += "You're fighting pale blue skinned women with snow white medium long hair. Using her snow-white wings she constantly stays airborne. On her hands you can see pair of runic bracelets. Above her head you see halo.";
			if (hasStatusEffect(StatusEffects.ATranscendentSoulField))
			{
				str += "\n\n<i>From time to time you can notice faint glimmers of orange protective field surrounding her.";
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " After your attacks it take octagonal shapes for a brief moment.";
				str += "</i>";
			}
			return str;
		}
		
		public function Koshya()
		{
			this.a = "the ";
			this.short = "blue skinned angel";
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
			initStrTouSpeInte(45, 100, 110, 50);
			initWisLibSensCor(110, 25, 15, 0);
			this.bodyColor = "pale blue";
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
			this.lustVuln = 0.01;
			this.lust = 30;
			this.level = 18;
			this.gems = rand(15) + 10;
			this.drop = new WeightedDrop()
					.add(null, 2)
					.add(useables.SRESIDUE, 1);
			this.createStatusEffect(StatusEffects.ATranscendentSoulField, 20, 20, 0, 0);//X times less dmg, +X lvl diff bonus
			this.createPerk(PerkLib.DieHardHP, 9, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueAngel, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.InsightfulResourcesI, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
