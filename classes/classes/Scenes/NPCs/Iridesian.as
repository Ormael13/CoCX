/**
 * ...
 * @author Ormael (for now)
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class Iridesian extends Monster
	{
		public function soulskillCostHailofBlades():Number {
			var cost:Number = 50;
			if (hasPerk(PerkLib.DaoistApprenticeStage)) cost -= 5;
			if (hasPerk(PerkLib.DaoistWarriorStage)) cost -= 5;
			return cost;
		}
		public function soulskillCostGrandioseHailofBlades():Number {
			var cost:Number = 200;
			if (hasPerk(PerkLib.DaoistApprenticeStage)) cost -= 20;
			if (hasPerk(PerkLib.DaoistWarriorStage)) cost -= 20;
			return cost;
		}
		public function soulskillCostGrandioseHailofMoonBlades():Number {
			var cost:Number = 800;
			if (hasPerk(PerkLib.DaoistApprenticeStage)) cost -= 80;
			if (hasPerk(PerkLib.DaoistWarriorStage)) cost -= 80;
			return cost;
		}
		public function soulskillCostEnergyProjection():Number {
			var cost:Number = 20;
			if (hasPerk(PerkLib.DaoistApprenticeStage)) cost -= 2;
			if (hasPerk(PerkLib.DaoistWarriorStage)) cost -= 2;
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) cost *= 2;
			return cost;
		}
		
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
		
		public function castHailOfBladesSoulskillIridesian():void {
			outputText("Letting soulforce leak out around him, oculicorn form six ethereal two meter long weapons. Then he thrust his hand outwards and in the blink of an eye, weapons shoot forwards you. Weapons hits you, dealing ");
			soulforce -= soulskillCostHailofBlades();
			var hobI:Number = 6;
			while (hobI-->0) bladesD();
			outputText(" damage!");
		}
		public function castGrandioseHailOfBladesSoulskillIridesian():void {
			outputText("Letting soulforce leak out around him, oculicorn form eighteen ethereal two meter long weapons in two rows. Then he thrust his hand outwards and in the blink of an eye, weapons shoot forwards you. Weapons hits you, dealing ");
			soulforce -= soulskillCostGrandioseHailofBlades();
			createStatusEffect(StatusEffects.AbilityCooldown2, 3, 0, 0, 0);
			var ghobI:Number = 9;
			while (ghobI-->0) bladesD(2);
			outputText(" damage!");
		}
		public function castGrandioseHailOfMoonBladesSoulskillIridesian():void {
			outputText("Letting soulforce leak out around him, oculicorn form fifty six ethereal two meter long weapons in four rows. Then he thrust his hand outwards and in the blink of an eye, weapons shoot forwards you. Weapons hits you, dealing ");
			soulforce -= soulskillCostGrandioseHailofMoonBlades();
			createStatusEffect(StatusEffects.AbilityCooldown3, 9, 0, 0, 0);
			var ghombI:Number = 19;
			while (ghombI-->0) bladesD(4);
			outputText(" damage!");
		}
		private function bladesD(hits:Number = 1):void {
			var bd:Number = 0;
			bd += this.wis * 0.5;
			bd += wisdomscalingbonus() * 0.5;
			if (bd < 10) bd = 10;
			bd *= SoulskillMod();
			var crit:Boolean = false;
			if (rand(100) < 25) {
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
			if (hits == 4) {
				bd = player.takeMagicDamage(bd, true);
				if (crit == true) outputText(" <b>*Critical Hit!*</b>");
				outputText(" ");
				bd = player.takeMagicDamage(bd, true);
				if (crit == true) outputText(" <b>*Critical Hit!*</b>");
				outputText(" ");
				bd = player.takeMagicDamage(bd, true);
				if (crit == true) outputText(" <b>*Critical Hit!*</b>");
				outputText(" ");
			}
		}
		
		public function castEnergyProjectionIridesian():void {
			outputText("His eye begins to glow with a harsh radiance as energy gathers around him. In a flash, you're struck by a large cross-shaped explosion"+(hasStatusEffect(StatusEffects.TrueFormAngel)?"s":"")+". ");
			soulforce -= soulskillCostEnergyProjection();
			var damage:Number = eBaseIntelligenceDamage();
			damage += eBaseWisdomDamage();
			damage *= SoulskillMod();
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) {
				player.takeFireDamage(damage, true);
				player.takeFireDamage(damage, true);
			}
		}
		
		private function IridesianDominationGaze():void {
			outputText("The eyes gaze bore deep within your very mind with a single order.\n\n");
			outputText("\"<i>Stillness</i>\"\n\n");
			outputText("You suddenly panic as you are held in place, fighting against the mind control as the thing takes aim.\n\n");
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) {
				createStatusEffect(StatusEffects.AbilityCooldown1, 7, 0, 0, 0);
				player.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
			}
			else {
				createStatusEffect(StatusEffects.AbilityCooldown1, 3, 0, 0, 0);
				player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			}
		}
		
		private function IridesianOmnicast():void {
			outputText("Oculicorn suddenly fixates you with all of its eye unleashing a barrage of rays at you! ");
			var omni:Number = 6;
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) omni *= 4;
			while (omni-->0) IridesianOmnicastD();
			outputText("\n\n");
		}
		private function IridesianOmnicastD():void {
			var damage:Number = eBaseIntelligenceDamage() * 0.15;
			damage += eBaseWisdomDamage() * 0.15;
			damage = Math.round(damage);
			var element:Number = rand(5);
			if (element == 0) damage = player.takeMagicDamage(damage, true);
			if (element == 1) damage = player.takeFireDamage(damage, true);
			if (element == 2) damage = player.takeIceDamage(damage, true);
			if (element == 3) damage = player.takeLightningDamage(damage, true);
			if (element == 4) damage = player.takeDarknessDamage(damage, true);
		}
		
		private function AuraOfPurityIridesian():void {
			var damage:Number = eBaseIntelligenceDamage();
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) damage *= 18;
			else damage *= 12;
			if (player.cor < 33) damage = Math.round(damage * 1.0);
			else if (player.cor < 50) damage = Math.round(damage * 1.1);
			else if (player.cor < 75) damage = Math.round(damage * 1.2);
			else if (player.cor < 90) damage = Math.round(damage * 1.3);
			else damage = Math.round(damage * 1.4); //30% more damage against very high corruption.
			var crit:Boolean = false;
			var critChance:int = 15;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
            damage = Math.round(damage);
            outputText("Oculicorn aura of purity burns you with holy fire for ");
            damage = player.takeFireDamage(damage, true);
            outputText(" damage!");
            if (crit) outputText(" <b>*Critical Hit!*</b>");
			outputText("\n\n");
        }
		
		override protected function performCombatAction():void
		{
			if (player.cor > 20) AuraOfPurityIridesian();
			if (!hasStatusEffect(StatusEffects.TranscendentSoulField) && soulforce >= 20) createStatusEffect(StatusEffects.TranscendentSoulField, 10, 10, 0, 0);
			if (hasStatusEffect(StatusEffects.TranscendentSoulField)) {
				if (soulforce >= 20) soulforce -= 20;
				else removeStatusEffect(StatusEffects.TranscendentSoulField);
			}
			if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) IridesianDominationGaze();
			else {
				var choice:Number = rand(5);
				if (choice == 0) IridesianOmnicast();
				if (choice == 1) {
					if (soulforce >= soulskillCostHailofBlades()) castHailOfBladesSoulskillIridesian();
					else IridesianOmnicast();
				}
				if (choice == 2) {
					if (soulforce >= soulskillCostGrandioseHailofBlades() && !hasStatusEffect(StatusEffects.AbilityCooldown2)) castGrandioseHailOfBladesSoulskillIridesian();
					else IridesianOmnicast();
				}
				if (choice == 3) {
					if (soulforce >= soulskillCostGrandioseHailofMoonBlades() && !hasStatusEffect(StatusEffects.AbilityCooldown3)) castGrandioseHailOfMoonBladesSoulskillIridesian();
					else IridesianOmnicast();
				}
				if (choice == 4) {
					if (soulforce >= soulskillCostEnergyProjection()) castEnergyProjectionIridesian();
					else IridesianOmnicast();
				}
			}
		}
		
		private function angelification():void {
			clearOutput();
			var TB:Number = Math.round(touStat.core.value * 0.2);
			var SB:Number = Math.round(speStat.core.value * 0.1);
			var WB:Number = Math.round(wisStat.core.value * 0.3);
			touStat.core.value += TB;
			speStat.core.value += SB;
			wisStat.core.value += WB;
			addPerkValue(PerkLib.DieHardHP, 1, 30);
			addPerkValue(PerkLib.MonsterRegeneration, 1, 3);
			addStatusValue(StatusEffects.TranscendentSoulField, 1, 10);
			addStatusValue(StatusEffects.TranscendentSoulField, 2, 10);
			HP = maxHP();
			lustVuln += 0.15;
			bonusWrath += 500;
			bonusSoulforce += 1000;
			outputText("Staggering back, Oculicorn wastes no time and above his head starts to manifest sort of halo. It have wings on the sides and in the middle of it forms something reasambling eyeball. After halo formation a wave of light wash over it changing him. His horn grows longer, his monoeye pupil split into three separate ones and his teeth grow longer and sharper. ");
			outputText("Eyestalks behind his back shows grew additional eyeballs located along the length of the stalks. Bottom half not change much aside gorwing fur all over it. After the wave reach his feet he starts to levitate.");
			outputText("\n\n\"<i>Behold my true form foul creature!!!</i>\" he speaks with barely hidden content and reassume combat pose.");
			createStatusEffect(StatusEffects.TrueFormAngel, 0, 0, 0, 0);
			createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			short = "Arch-Oculicorn";
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
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) {
				str += "You are fighting an Arch-Oculicorn. This powerful creature looks humanoid with hooves, horse tail and fur covering his whole bottom half. Monoeye on his head posses now three pupils, sharp teeth and long single horn adorn his forehead ocassionaly glowing with mild white light. ";
				str += "Above his head hoover halo with wings on it sides and something akin to single eye at the front. Six stalks expending from his back each with three eyeballs placed along the stalk length with fouth at the end. While he does have legs he moves by levitating around instead.";
			}
			else str += "You are fighting an Oculicorn. This powerful creature look like a human save for the hooves, horse tail, the mono all encompassing eye in his head and six eye mounted stalks expending from his back. Medium long single horn adorn his forehead ocassionaly glowing with mild white light.";
			if (hasStatusEffect(StatusEffects.TranscendentSoulField))
			{
				str += "\n\n<i>From time to time you can notice faint glimmers of orange protective field surrounding him.";
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " After your attacks it take octagonal shapes for a brief moment.";
				str += "</i>";
			}
			return str;
		}
		
		public function Iridesian()
		{
			initStrTouSpeInte(32, 259, 97, 112);
            initWisLibSensCor(270, 160, 103, -100);
            this.armorDef = 150;
            this.armorMDef = 150;
            this.bonusHP = 2000;
            this.bonusLust = 323;
			this.bonusWrath = 500;
			this.bonusSoulforce = 1000;
            this.level = 60;
            this.gems = 1300 + rand(260);
            this.additionalXP = 6000;
			this.a = "the ";
			this.short = "Oculicorn";//Iridesian
			this.imageName = "gazer";
			this.long = "";
			// this.plural = false;
			this.createCock(12,2.5,CockTypesEnum.HORSE);
			this.balls = 2;
			this.ballSize = 2+rand(13);
			this.cumMultiplier = 1.5;
			this.hoursSinceCum = player.ballSize * 10;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,50,0,0,0);
			this.tallness = 10*12+10;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.lowerBody = LowerBody.HOOFED;
			this.faceType = Face.ANIMAL_TOOTHS;
			this.tailType = Tail.HORSE;
			this.bodyColor = "light grey";
			this.hairColor = "black";
			this.hairLength = 10;
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 5;
			this.armorName = "skin";
			this.lustVuln = .75;
			this.lust = 30;
			this.drop = new WeightedDrop()
					.add(useables.SRESIDUE, 1)
					.add(consumables.ME_DROP, 1);
			this.createStatusEffect(StatusEffects.TranscendentSoulField, 10, 10, 0, 0);//X times less dmg, +X lvl diff bonus
			this.createPerk(PerkLib.EpicWisdom, 0, 0, 0, 0);
			//this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.InsightfulResourcesI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.DieHardHP, 30, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 2, 0, 0, 0);
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.DaoistApprenticeStage, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulPersonage, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
			this.createPerk(PerkLib.DaoistWarriorStage, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulSprite, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulScholar, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulGrandmaster, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
