/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class Dinah extends Monster
	{
		private function spellCostMultiplier():Number {
			var multiplier:Number = 1;
			if (flags[kFLAGS.DINAH_SPELLS_CASTED] >= 10) multiplier -= 0.1;
			if (flags[kFLAGS.DINAH_SPELLS_CASTED] >= 30) multiplier -= 0.1;
			if (flags[kFLAGS.DINAH_SPELLS_CASTED] >= 70) multiplier -= 0.1;
			if (flags[kFLAGS.DINAH_SPELLS_CASTED] >= 150) multiplier -= 0.1;
			if (flags[kFLAGS.DINAH_SPELLS_CASTED] >= 310) multiplier -= 0.1;
			return multiplier;
		}
		public function spellCostWhitefire():Number {
			var cost:Number = 40;
			cost *= spellCostMultiplier();
			return cost;
		}
		public function spellCostBlink():Number {
			var cost:Number = 40;
			cost *= spellCostMultiplier();
			return cost;
		}
		public function spellCostArouse():Number {
			var cost:Number = 20;
			cost *= spellCostMultiplier();
			return cost;
		}
		public function spellCostHeal():Number {
			var cost:Number = 30;
			cost *= spellCostMultiplier();
			return cost;
		}
		public function soulskillCostManyBirds():Number {
			var cost:Number = 10;
			if (findPerk(PerkLib.DaoistCultivator) >= 0) cost -= 1;
			return cost;
		}
		public function soulskillCostHailofBlades():Number {
			var cost:Number = 50;
			if (findPerk(PerkLib.DaoistCultivator) >= 0) cost -= 5;
			return cost;
		}
		
		public function SoulskillMod():Number {
			var mod1:Number = 1;
			if (findPerk(PerkLib.DaoistCultivator) >= 0) mod1 += .1;
			if (findPerk(PerkLib.DaoistApprenticeStage) >= 0) {
				if (findPerk(PerkLib.SoulApprentice) >= 0) mod1 += .2;
				if (findPerk(PerkLib.SoulPersonage) >= 0) mod1 += .2;
				if (findPerk(PerkLib.SoulWarrior) >= 0) mod1 += .2;
			}
			if (findPerk(PerkLib.DaoistWarriorStage) >= 0) {
				if (findPerk(PerkLib.SoulSprite) >= 0) mod1 += .3;
				if (findPerk(PerkLib.SoulScholar) >= 0) mod1 += .3;
				if (findPerk(PerkLib.SoulElder) >= 0) mod1 += .3;
			}
			return mod1;
		}
		public function SpellMod():Number {
			var mod2:Number = 1;
			if (findPerk(PerkLib.Channeling) >= 0) mod2 += .2;
			if (findPerk(PerkLib.Spellpower) >= 0) mod2 += .1;
			if (findPerk(PerkLib.JobSorcerer) >= 0) mod2 += .1;
			return mod2;
		}
		
		public function castManyBirdsSoulskillDinah():void {
			outputText("She thrust her hand outwards with deadly intent, and in the blink of an eye a crystals shoots towards you.  Crystals hits you, dealing ");
			soulforce -= soulskillCostManyBirds();
			var damage:Number = wisdomscalingbonus();
			if (damage < 10) damage = 10;
			damage *= SoulskillMod();
			damage = Math.round(damage);
			player.takeMagicDamage(damage, true);
			outputText(" damage!");
		}
		public function castHailOfBladesSoulskillDinah():void {
			outputText("Letting soulforce leak out around her, Dinah form six ethereal two meter long weapons. Then she thrust her hand outwards and in the blink of an eye, weapons shoot forwards you. Weapons hits you, dealing ");
			soulforce -= soulskillCostHailofBlades();
			bladesD();
			bladesD();
			bladesD();
			bladesD();
			bladesD();
			bladesD();
			outputText(" damage!");
		}
		private function bladesD():void {
			var bd:Number = 0;
			bd += this.wis * 0.5;
			bd += wisdomscalingbonus() * 0.5;
			if (bd < 10) bd = 10;
			bd *= SoulskillMod();
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
		}
		
		public function castWhiteFireSpellDinah():void {
			var damage:int = (inte/3 + rand(inte/2));
			if (inte >= 21 && inte < 41) damage += (inte / 2 + rand((inte * 3) / 4));
			if (inte >= 41 && inte < 61) damage += ((inte * 2) / 3 + rand(inte));
			if (inte >= 61 && inte < 81) damage += ((inte * 5) / 6 + rand(inte * 1.25));
			if (inte >= 81 && inte < 101) damage += (inte + rand(inte * 1.5));
			if (inte >= 101 && inte < 151) damage += ((inte * 1.25) + rand(inte * 1.75));
			if (inte >= 151 && inte < 201) damage += ((inte * 1.5) + rand(inte * 2));
			if (inte >= 201) damage += ((inte * 1.75) + rand(inte * 2.25));
			damage *= SpellMod();
			damage = Math.round(damage);
			if (player.hasStatusEffect(StatusEffects.Blizzard)) {
			player.addStatusValue(StatusEffects.Blizzard, 1, -1);
			outputText("Dinah narrows her eyes and focuses her mind with deadly intent. She snaps her fingers and you are enveloped in a flash of white flames!  Thanks to surrounding you ice shards this attack isn't at it peak power!  ");
			damage *= 0.2;
			}
			else {
			outputText("Dinah narrows her eyes and focuses her mind with deadly intent. She snaps her fingers and you are enveloped in a flash of white flames!  ");
			}
			if (player.isGoo()) {
				damage *= 1.5;
				outputText("It's super effective!  ");
			}
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
			mana -= spellCostWhitefire();
			flags[kFLAGS.DINAH_SPELLS_CASTED]++;
		}
		public function castBlinkSpellDinah():void {
			outputText("She flushes, drawing on her body's desires to empower her muscles and hasten her up.");
			outputText("The rush of success and power flows through her body.  <b>She looks like she can move faster!</b>");
			createStatusEffect(StatusEffects.Blink, 50, 0, 0, 0);
			if (findPerk(PerkLib.JobEnchanter) >= 0) this.spe += (5 + (inte / 10)) * 1.5 * SpellMod();
			else this.spe += (5 + (inte / 10)) * 1.2 * SpellMod();
			mana -= spellCostBlink();
			flags[kFLAGS.DINAH_SPELLS_CASTED]++;
		}
		public function castArouseDinah():void {
			outputText("Dinah makes a series of arcane gestures, drawing on her lust to inflict it upon you! ");
			var lustDamage:int = (inte / 5) + rand(10);
			lustDamage = lustDamage * (EngineCore.lustPercent() / 100);
			player.dynStats("lus", lustDamage, "scale", false);
			outputText(" <b>(<font color=\"#ff00ff\">" + (Math.round(lustDamage * 10) / 10) + "</font>)</b>");
			mana -= spellCostArouse();
			flags[kFLAGS.DINAH_SPELLS_CASTED]++;
		}
		public function castHealDinah():void {
			outputText("Dinah focuses on her body and her desire to end pain, trying to draw on her arousal without enhancing it.");
			var temp:int = int((inte / (2 + rand(3))) * (maxHP() / 50));
			outputText("She flushes with success as her wounds begin to knit! <b>(<font color=\"#008000\">+" + temp + "</font>)</b>.");
			addHP(temp);
			mana -= spellCostHeal();
			flags[kFLAGS.DINAH_SPELLS_CASTED]++;
		}
		
		public function hellcatFireballDinah():void
		{
			var damage:int = (inte * 1.1) + rand(25);
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
			outputText("Dinah cast a spell, materializing a fireball before throwing it at you. " + damage + " fire damage!");
		}
		
		public function hellcatInfernalClawDinah():void
		{
			outputText("Dinah growls at you, unsheathing her claws which turns orange-red like hot irons as she enhances it with a dash of fire magic. She leaps forward and viciously attempts to rend you. ");
			var firedamage:int = (inte * 0.45) + rand(10);
			firedamage = Math.round(firedamage);
			player.takeFireDamage(firedamage, true);
			if (player.hasStatusEffect(StatusEffects.BurnDoT)) player.addStatusValue(StatusEffects.BurnDoT, 1, 1);
			else player.createStatusEffect(StatusEffects.BurnDoT,3,0.05,0,0);
			var physdamage:Number = 0;
			physdamage += eBaseDamage();
			player.takePhysDamage(physdamage, true);
			if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
			else player.createStatusEffect(StatusEffects.Hemorrhage,3,0.05,0,0);
			outputText("" + physdamage + " physical damage, " + firedamage + " fire damage. Reeling in pain you begin to bleed and burn at the same time.");
		}
		
		public function hellcatFelineCurseDinah():void
		{
			outputText("Dinah incants a curse and you suddenly shrink in size. To your complete horror, you realize she polymorphed you into a small housecat!");
			player.createStatusEffect(StatusEffects.Polymorphed, 3, 0, 0, 0);
			createStatusEffect(StatusEffects.AbilityCooldown1, 8, 0, 0, 0);
		}
		
		public function displacerBeastPhaseStrikeDinah():void {
			outputText("Dinah blinks out and appears right behind you as it begins mauling you with her claws.");
			outputText("\n\nShe claws you! ");
			phasestrikeDmg();
			outputText("\n\nShe claws you! ");
			phasestrikeDmg();
			outputText("\n\nShe claws you! ");
			phasestrikeDmg();
			outputText("\n\nShe claws you! ");
			phasestrikeDmg();
		}
		private function phasestrikeDmg():void {
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			damage += this.weaponAttack;
			damage += rand(str);
			damage += rand(weaponAttack);
			damage += 1.2;
			damage = Math.round(damage);
			damage = player.takePhysDamage(damage, true);
		}
		
		override protected function performCombatAction():void {
			if (flags[kFLAGS.DINAH_LVL_UP] >= 7) {
				var choice2:Number = rand(6);
				switch (choice2) {
					case 0:
						eAttack();
						break;
					case 1:
						if (HPRatio() < .5 && rand(3) == 0 && (mana >= spellCostHeal())) castHealDinah();
						else if (rand(2) == 0 && !hasStatusEffect(StatusEffects.Blink) && (mana >= spellCostBlink())) castBlinkSpellDinah();
						else if (mana >= spellCostArouse()) castArouseDinah();
						else eAttack();
						break;
					case 2:
						if ((soulforce >= soulskillCostManyBirds()) && rand(2) == 0) castManyBirdsSoulskillDinah();
						else hellcatFireballDinah();
						break;
					case 3:
						if ((soulforce >= soulskillCostHailofBlades()) && rand(2) == 0) castHailOfBladesSoulskillDinah();
						else hellcatInfernalClawDinah();
						break;
					case 4:
						displacerBeastPhaseStrikeDinah();
						break;
					case 5:
						if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) hellcatFelineCurseDinah();
						else eAttack();
						break;
					default:
						eAttack();
				}
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 4 && flags[kFLAGS.DINAH_LVL_UP] < 7) {
				var choice1:Number = rand(6);
				switch (choice1) {
					case 0:
						eAttack();
						break;
					case 1:
						if (HPRatio() < .5 && rand(3) == 0 && (mana >= spellCostHeal())) castHealDinah();
						else if (rand(2) == 0 && !hasStatusEffect(StatusEffects.Blink) && (mana >= spellCostBlink())) castBlinkSpellDinah();
						else if (mana >= spellCostArouse()) castArouseDinah();
						else eAttack();
						break;
					case 2:
						if ((soulforce >= soulskillCostManyBirds()) && rand(2) == 0) castManyBirdsSoulskillDinah();
						else hellcatFireballDinah();
						break;
					case 3:
						if ((soulforce >= soulskillCostHailofBlades()) && rand(2) == 0) castHailOfBladesSoulskillDinah();
						else hellcatInfernalClawDinah();
						break;
					case 4:
						displacerBeastPhaseStrikeDinah();
						break;
					case 5:
						if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) hellcatFelineCurseDinah();
						else eAttack();
						break;
					default:
						eAttack();
				}
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 1 && flags[kFLAGS.DINAH_LVL_UP] < 4) {
				var choice0:Number = rand(4);
				switch (choice0) {
					case 0:
						eAttack();
						break;
					case 1:
						if (HPRatio() < .5 && rand(3) == 0 && (mana >= spellCostHeal())) castHealDinah();
						else if (mana >= spellCostArouse()) castArouseDinah();
						else eAttack();
						break;
					case 2:
						hellcatFireballDinah();
						break;
					case 3:
						hellcatInfernalClawDinah();
						break;
					default:
						eAttack();
				}
			}
			if (flags[kFLAGS.DINAH_LVL_UP] < 1) eAttack();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.DINAH_LVL_UP] < 0.5) flags[kFLAGS.DINAH_DEFEATS_COUNTER]++;
			if (player.hasStatusEffect(StatusEffects.CampSparingDinah)) {
				player.removeStatusEffect(StatusEffects.CampSparingDinah);
				SceneLib.dinahScene.DinahLostSparring();
			}
			else {
				cleanupAfterCombat();
				SceneLib.dinahScene.DinahMainMenu();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.CampSparingDinah)) {
				player.removeStatusEffect(StatusEffects.CampSparingDinah);
				SceneLib.dinahScene.DinahWonSparring();
			}
			else {
				cleanupAfterCombat();
				SceneLib.dinahScene.DinahMainMenu();
			}
		}
		
		public function Dinah() 
		{
			if (flags[kFLAGS.DINAH_LVL_UP] < 1) {
				this.a = "the ";
				this.short = "cat";
				this.long = "You are fighting a cat-morph. She would looks quite averange if not for black stripes on purple fur.";
				this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_NORMAL);
				this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
				this.tallness = 5*12+10;
				this.hairLength = 7;
				initStrTouSpeInte(20, 20, 20, 60);
				initWisLibSensCor(30, 20, 20, 50);
				this.weaponAttack = 5;
				this.armorDef = 3;
				this.armorMDef = 6;
				this.armorName = "fur";
				this.bonusHP = 30;
				this.bonusLust = 10;
				this.lustVuln = .9;
				this.level = 2;
				this.drop = NO_DROP;
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 1) {
				this.a = "";
				this.short = "Dinah";
				this.long = "You are fighting Dinah. She's a cat chimera that mixes nearly all, if not all, cat races you could find in this demonic realm. Burning eyes like those of hellcats and fiery hair with colors like those of cheshire cats, parted by twin pair of small horns. Behind her slowly moves two blazing tails, and two long tentacles similar to that of a calamari. Her four arms completes her chimeric visage.";
				this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_NORMAL);
				this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
				//createBreastRow(Appearance.breastCupInverse("A"));
				this.tallness = 7*12+8;
				this.hairLength = 21;//very long, flowing locks of - between shouled length and ass length
				this.armorName = "fur";
			}
			if (flags[kFLAGS.DINAH_LVL_UP] == 1) {
				initStrTouSpeInte(30, 25, 60, 80);
				initWisLibSensCor(40, 40, 30, 50);
				this.weaponAttack = 10;
				this.armorDef = 40;
				this.armorMDef = 30;
				this.bonusHP = 60;
				this.bonusMana = 50;
				this.bonusLust = 12;
				this.level = 8;
			}
			if (flags[kFLAGS.DINAH_LVL_UP] == 2) {
				initStrTouSpeInte(40, 30, 100, 100);
				initWisLibSensCor(50, 60, 40, 50);
				this.weaponAttack = 20;
				this.armorDef = 42;
				this.armorMDef = 32;
				this.bonusHP = 90;
				this.bonusMana = 100;
				this.bonusLust = 14;
				this.level = 14;
			}
			if (flags[kFLAGS.DINAH_LVL_UP] == 3) {
				initStrTouSpeInte(50, 35, 140, 120);
				initWisLibSensCor(60, 80, 50, 50);
				this.weaponAttack = 30;
				this.armorDef = 44
				this.armorMDef = 33;
				this.bonusHP = 120;
				this.bonusMana = 150;
				this.bonusLust = 16;
				this.level = 20;
			}
			if (flags[kFLAGS.DINAH_LVL_UP] == 4) {
				initStrTouSpeInte(60, 40, 180, 140);
				initWisLibSensCor(70, 100, 60, 50);
				this.weaponAttack = 40;
				this.armorDef = 46;
				this.armorMDef = 35;
				this.bonusHP = 150;
				this.bonusMana = 200;
				this.bonusLust = 18;
				this.level = 26;
			}
			if (flags[kFLAGS.DINAH_LVL_UP] == 5) {
				initStrTouSpeInte(70, 45, 220, 160);
				initWisLibSensCor(80, 120, 70, 50);
				this.weaponAttack = 50;
				this.armorDef = 48;
				this.armorMDef = 36;
				this.bonusHP = 180;
				this.bonusMana = 250;
				this.bonusLust = 20;
				this.level = 32;
			}
			if (flags[kFLAGS.DINAH_LVL_UP] == 6) {
				initStrTouSpeInte(80, 50, 260, 180);
				initWisLibSensCor(90, 140, 80, 50);
				this.weaponAttack = 60;
				this.armorDef = 50;
				this.armorMDef = 38;
				this.bonusHP = 210;
				this.bonusMana = 300;
				this.bonusLust = 22;
				this.level = 38;
			}
			if (flags[kFLAGS.DINAH_LVL_UP] == 7) {
				initStrTouSpeInte(90, 55, 300, 200);
				initWisLibSensCor(100, 160, 90, 50);
				this.weaponAttack = 70;
				this.armorDef = 52;
				this.armorMDef = 39;
				this.bonusHP = 240;
				this.bonusMana = 350;
				this.bonusLust = 24;
				this.level = 44;
			}
			createBreastRow(game.flags[kFLAGS.DINAH_CUP_SIZE]);
			this.hips.type = Hips.RATING_BOYISH+game.flags[kFLAGS.DINAH_HIPS_ASS_SIZE];
			this.butt.type = Butt.RATING_BUTTLESS+game.flags[kFLAGS.DINAH_HIPS_ASS_SIZE];
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.hairColor = "black and purple";
			this.weaponName = "claws";
			this.weaponVerb = "slash";
			this.lust = 30;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 0;
			if (flags[kFLAGS.DINAH_LVL_UP] >= 1 && flags[kFLAGS.DINAH_LVL_UP] < 4) {
				this.lustVuln = .9;
				this.createStatusEffect(StatusEffects.EvasiveTeleport, 40, 0, 0, 0);
				this.drop = new WeightedDrop(consumables.BAGOCA1, 1);
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 4 && flags[kFLAGS.DINAH_LVL_UP] < 7) {
				this.lustVuln = .8;
				this.createStatusEffect(StatusEffects.EvasiveTeleport, 70, 0, 0, 0);
				this.drop = new WeightedDrop(consumables.BAGOCA2, 1);
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 7 && flags[kFLAGS.DINAH_LVL_UP] < 10) {
				this.lustVuln = .7;
				this.createStatusEffect(StatusEffects.EvasiveTeleport, 100, 0, 0, 0);
				this.drop = new WeightedDrop(consumables.BAGOCA3, 1);
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 10 && flags[kFLAGS.DINAH_LVL_UP] < 12) {
				this.lustVuln = .6;
				this.createStatusEffect(StatusEffects.EvasiveTeleport, 130, 0, 0, 0);
				this.drop = NO_DROP;//
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 12 && flags[kFLAGS.DINAH_LVL_UP] < 14) {
				this.lustVuln = .5;
				this.createStatusEffect(StatusEffects.EvasiveTeleport, 160, 0, 0, 0);
				this.drop = NO_DROP;//
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 14) {
				this.lustVuln = .4;
				this.createStatusEffect(StatusEffects.EvasiveTeleport, 190, 0, 0, 0);
				this.drop = NO_DROP;//
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 1) {
				this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
				this.createPerk(PerkLib.BasicSpirituality, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 2) {
				this.createPerk(PerkLib.ManaAffinityI, 0, 0, 0, 0);
				this.createPerk(PerkLib.DaoistCultivator, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 3) {
				this.createPerk(PerkLib.HalfStepToImprovedSpirituality, 0, 0, 0, 0);
				this.createPerk(PerkLib.DaoistApprenticeStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.Lifeline, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 4) {
				this.createPerk(PerkLib.MindOverBodyI, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulPersonage, 0, 0, 0, 0);
				this.createPerk(PerkLib.InsightfulResourcesI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 5) {
				this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
				this.createPerk(PerkLib.Spellpower, 0, 0, 0, 0);
				this.createPerk(PerkLib.Channeling, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 6) {
				this.createPerk(PerkLib.SoulSprite, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobEnchanter, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 7) {
				this.createPerk(PerkLib.DaoistWarriorStage, 0, 0, 0, 0);
				//this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
				//this.createPerk(PerkLib.MindOverBodyI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 8) {
				this.createPerk(PerkLib.SoulScholar, 0, 0, 0, 0);
				//this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
				//this.createPerk(PerkLib.MindOverBodyI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DINAH_LVL_UP] >= 9) {
				this.createPerk(PerkLib.SoulElder, 0, 0, 0, 0);
				//this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
				//this.createPerk(PerkLib.MindOverBodyI, 0, 0, 0, 0);
			}
			checkMonster();
		}
	}
}