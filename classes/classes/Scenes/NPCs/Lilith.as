/**
 * ...
 * @author Ormael (for now)
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class Lilith extends Monster
	{
		public function castEnergyProjectionLilith():void {
			outputText("Her eyes begins to glow with a harsh radiance as energy gathers around her. In a flash, you're struck by a large cross-shaped explosion. ");
			soulforce -= 20;//soulskillCostEnergyProjection();
			var damage:Number = eBaseIntelligenceDamage();
			damage += eBaseWisdomDamage();
			//damage *= SoulskillMod();
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) damage *= 3;
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
		}
		
		private function lilithInfernalFlare():void {
			mana -= 50;
			var damage:Number = 0;
			damage += eBaseIntelligenceDamage() * 4;
			if (player.cor >= 66) damage = Math.round(damage * 1.0);
			else if (player.cor >= 50) damage = Math.round(damage * 1.1);
			else if (player.cor >= 25) damage = Math.round(damage * 1.2);
			else if (player.cor >= 10) damage = Math.round(damage * 1.3);
			else damage = Math.round(damage * 1.4);
			if (hasStatusEffect(StatusEffects.Maleficium)) damage *= 2;
			outputText("Goth girl moves her hands in air tracing complicated arcane signs, as a purple flame surges under you, searing your flesh. ");
			player.takeFireDamage(damage, true);
			if (!player.immuneToBurn()) {
				if (player.hasStatusEffect(StatusEffects.BurnDoT)) player.addStatusValue(StatusEffects.BurnDoT, 1, 1);
				else player.createStatusEffect(StatusEffects.BurnDoT,SceneLib.combat.debuffsOrDoTDuration(5),0.05,0,0);
			}
			statScreenRefresh();
			outputText("\n");
		}
		
		private function lilithLustStrike():void {
			outputText("Goth girl start drawing symbols in the air toward you.");
			var lustDmg:Number = this.lust / 10 + this.lib / 10 + this.inte / 10 + this.wis / 10 + this.sens / 10;
			lustDmg = Math.round(lustDmg);
			player.takeLustDamage(lustDmg, true);
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(3);
			if (choice == 0) lilithLustStrike();
			if (choice == 1) {
				if (soulforce >= 20) castEnergyProjectionLilith();
				else eAttack();
			}
			if (choice == 2) {
				if (mana >= 50) lilithInfernalFlare();
				else eAttack();
			}
			if (choice == 3) eAttack();
		}
		
		private function angelification():void {
			clearOutput();
			var TB:Number = Math.round(touStat.core.value * 0.2);
			var SB:Number = Math.round(speStat.core.value * 0.1);
			var WB:Number = Math.round(wisStat.core.value * 0.3);
			touStat.core.value += TB;
			speStat.core.value += SB;
			wisStat.core.value += WB;
			addPerkValue(PerkLib.DieHardHP, 1, 9);
			addPerkValue(PerkLib.MonsterRegeneration, 1, 3);
			addStatusValue(StatusEffects.TranscendentSoulField, 1, 10);
			addStatusValue(StatusEffects.TranscendentSoulField, 2, 10);
			HP = maxOverHP();
			lustVuln += 0.15;
			bonusWrath += 500;
			bonusSoulforce += 1000;
			outputText("");
			outputText("\n\n\"<i></i>\" .");
			createStatusEffect(StatusEffects.TrueFormAngel, 0, 0, 0, 0);
			SceneLib.combat.combatRoundOver();
		}
		
		override public function get long():String
		{
			var str:String = "";//You're fighting pale skinned woman with snow black hair. Even her eyes or lips are pitch black. And you would mistake her for normal human woman wearing catsuit if not noticable goat-like horns, small bat wings or arrow tipped tail.
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += "</i>";
			else {
				str += "You're fighting devilish cute goth girl. She stands about nine feet tall and is hugely voluptuous, with breasts two times the size of her head. Her hips flare out into an exaggerated hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her spankable butt. ";
				str += "Her raven hair cascades around ram horns that gleam like polished ivory, and her red eyes following your every move. A black catsuit huggs her curves, clinging to her body tightly. A powerful aura emanates from her.";
			}
			if (hasStatusEffect(StatusEffects.ATranscendentSoulField))
			{
				str += "\n\n<i>From time to time you can notice faint glimmers of orange protective field surrounding her.";
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " After your attacks it take octagonal shapes for a brief moment.";
				str += "</i>";
			}
			return str;
		}
		
		public function Lilith()
		{
			createBreastRow(Appearance.breastCupInverse("RR"));//G_BIG ?K - 1 head size, RR - 2 heads size, ZZ - 3 heads size?
			this.tallness = 9*12+2;
			this.hairLength = 16;//this.hairLength = 21;//very long, flowing locks of - between shouled length and ass length//this.hairLength = 40;//obscenely long, >= 40 a mniej niż tallness
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE;
			initStrTouSpeInte(90, 90, 90, 100);
			initWisLibSensCor(100, 125, 75, 50);
			this.weaponAttack = 5;
			this.armorDef = 150;
			this.armorMDef = 150;
            this.bonusHP = 500;
			this.bonusLust = 218;
			this.bonusWrath = 100;
			this.bonusSoulforce = 200;
			this.level = 18;
			this.gems = rand(15) + 10;
			this.createStatusEffect(StatusEffects.ATranscendentSoulField, 20, 20, 0, 0);//X times less dmg, +X lvl diff bonus
			this.createPerk(PerkLib.OverMaxHP, 18, 0, 0, 0);//v1 = enemy lvl
			this.a = "the ";
			this.short = "goth girl";
			this.imageName = "lilith";
			this.long = "";
			//this.plural = false;
			this.createVagina(true, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.bodyColor = "light";
			this.hairColor = "raven";
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.armorName = "skin";
			this.lustVuln = .75;
			this.lust = 30;
			this.drop = new WeightedDrop()
					.add(null, 2)
					.add(useables.SRESIDUE, 1);
			this.horns.type = Horns.DEMON;
			this.horns.count = 12;
			this.wings.type = Wings.BAT_LIKE_TINY;
			this.wings.desc = "tiny hidden";
			this.tailType = Tail.DEMONIC;
			this.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
			this.createPerk(PerkLib.OverMaxHP, 18, 0, 0, 0);
			this.createPerk(PerkLib.DieHardHP, 9, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 1, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueAngel, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			//this.createPerk(PerkLib.InsightfulResourcesI, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
