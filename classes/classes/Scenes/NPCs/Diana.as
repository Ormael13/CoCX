/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Ears;
	import classes.BodyParts.Face;
	import classes.BodyParts.Hips;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.Tail;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	import classes.internals.*;
	
	use namespace CoC;
	
	public class Diana extends Monster
	{
		public var dianaScene:DianaFollower = SceneLib.dianaScene;
		
		private function spellCostMultiplier():Number {
			var multiplier:Number = 1;
			if (flags[kFLAGS.DIANA_SPELLS_CASTED] >= 10) multiplier -= 0.1;
			if (flags[kFLAGS.DIANA_SPELLS_CASTED] >= 30) multiplier -= 0.1;
			if (flags[kFLAGS.DIANA_SPELLS_CASTED] >= 70) multiplier -= 0.1;
			if (flags[kFLAGS.DIANA_SPELLS_CASTED] >= 150) multiplier -= 0.1;
			if (flags[kFLAGS.DIANA_SPELLS_CASTED] >= 310) multiplier -= 0.1;
			return multiplier;
		}
		public function spellCostMagicBolt():Number {
			var cost:Number = 40;
			cost *= spellCostMultiplier();
			return cost;
		}
		public function spellCostMagicBoltsBarrage():Number {
			var cost:Number = 200;
			cost *= spellCostMultiplier();
			return cost;
		}
		public function spellCostHeal():Number {
			var cost:Number = 30;
			cost *= spellCostMultiplier();
			if (findPerk(PerkLib.NaturalHealingMinor) >= 0) cost -= 3;
			if (findPerk(PerkLib.NaturalHealingMajor) >= 0) cost -= 4.5;
			if (findPerk(PerkLib.NaturalHealingEpic) >= 0) cost -= 5;
			if (findPerk(PerkLib.NaturalHealingLegendary) >= 0) cost -= 6.5;
			if (findPerk(PerkLib.WisenedHealer) >= 0) cost *= 2;
			return cost;
		}
		public function spellCostRegenerate():Number {
			var cost:Number = 50;
			cost *= spellCostMultiplier();
			if (findPerk(PerkLib.NaturalHealingMinor) >= 0) cost -= 5;
			if (findPerk(PerkLib.NaturalHealingMajor) >= 0) cost -= 7.5;
			if (findPerk(PerkLib.NaturalHealingEpic) >= 0) cost -= 10;
			if (findPerk(PerkLib.NaturalHealingLegendary) >= 0) cost -= 12.5;
			if (findPerk(PerkLib.WisenedHealer) >= 0) cost *= 2;
			return cost;
		}
		public function soulskillCostManyBirds():Number {
			var cost:Number = 10;
			if (findPerk(PerkLib.DaoistCultivator) >= 0) cost -= 1;
			return cost;
		}
		public function soulskillCostHailOfBlades1():Number {
			var cost:Number = 50;
			if (findPerk(PerkLib.DaoistCultivator) >= 0) cost -= 5;
			return cost;
		}
		
		public function HealMod():Number {
			var mod1:Number = 1;
			if (findPerk(PerkLib.WizardsFocus) >= 0) mod1 += .4;
			if (findPerk(PerkLib.SpellpowerHealing) >= 0) mod1 += .2;
			if (findPerk(PerkLib.NaturalHealingMinor) >= 0) mod1 += .3;
			if (findPerk(PerkLib.NaturalHealingMajor) >= 0) mod1 += .4;
			if (findPerk(PerkLib.NaturalHealingEpic) >= 0) mod1 += .5;
			if (findPerk(PerkLib.NaturalHealingLegendary) >= 0) mod1 += .6;
			return mod1;
		}
		public function SpellMod():Number {
			var mod2:Number = 1;
			if (findPerk(PerkLib.Spellpower) >= 0) mod2 += .1;
			if (findPerk(PerkLib.Channeling) >= 0) mod2 += .2;
			if (findPerk(PerkLib.JobSorcerer) >= 0) mod2 += .1;
			if (findPerk(PerkLib.WizardsFocus) >= 0) mod2 += .4;
			return mod2;
		}
		public function SoulskillMod():Number {
			var mod3:Number = 1;
			if (findPerk(PerkLib.DaoistCultivator) >= 0) mod3 += .1;
			if (findPerk(PerkLib.DaoistApprenticeStage) >= 0) {
				if (findPerk(PerkLib.SoulApprentice) >= 0) mod3 += .2;
				if (findPerk(PerkLib.SoulPersonage) >= 0) mod3 += .2;
				if (findPerk(PerkLib.SoulWarrior) >= 0) mod3 += .2;
			}
			return mod3;
		}
		
		public function usingHealPill():void {
			var temp:Number = 50;
			temp += this.tou;
			if (flags[kFLAGS.DIANA_LVL_UP] >= 5) temp *= 3;
			if (flags[kFLAGS.DIANA_LVL_UP] >= 10) temp *= 3;
			if (flags[kFLAGS.DIANA_LVL_UP] >= 15) temp *= 3;
			outputText("She pop the small pill into her mouth and swallow. <b>(<font color=\"#008000\">+" + temp + "</font>)</b>.");
			addHP(temp);
		}
		public function usingARC():void {
			outputText("She grab mana potion, pull the cork off and swiftly chug it down.");
			if (flags[kFLAGS.DIANA_LVL_UP] >= 16) mana += 8640;
			else if (flags[kFLAGS.DIANA_LVL_UP] >= 12) mana += 1440;
			else if (flags[kFLAGS.DIANA_LVL_UP] >= 5) mana += 240;
			else mana += 40;
		}
		
		public function usingManyBirdsSoulskill():void {
			outputText("She thrust her hand outwards with deadly intent, and in the blink of an eye a crystals shoots towards you.  Crystals hits you, dealing ");
			soulforce -= soulskillCostManyBirds();
			var damage:Number = wisdomscalingbonus();
			if (damage < 10) damage = 10;
			damage *= SoulskillMod();
			damage = Math.round(damage);
			player.takeMagicDamage(damage, true);
			outputText(" damage!");
		}
		
		public function usingHailOfBlades1Soulskill():void {
			outputText("Letting soulforce leak out around her, Diana form six ethereal two meter long weapons. She thrust her hand outwards and in the blink of an eye, weapons shoot towards you.  ");
			soulforce -= soulskillCostHailOfBlades1();
			outputText("Weapons hits you, dealing ");
			BladesD();
			BladesD();
			BladesD();
			BladesD();
			BladesD();
			BladesD();
			outputText(" damage!");
		}
		private function BladesD():void {
			var damage:Number = this.wis * 0.5;
			damage += wisdomscalingbonus() * 0.5;
			if (damage < 10) damage = 10;
			damage *= SoulskillMod();
			damage = Math.round(damage);
			player.takeMagicDamage(damage, true);
		}
		
		public function usingMagicBoltsBarrageSpell():void {
			outputText("Diana narrow her eyes, focusing her mind with deadly intent.  After longer time she spend focusing, she point her staff and shots magic bolts toward you! ");
			mana -= spellCostMagicBoltsBarrage();
			var damage:Number = inteligencescalingbonus() * SpellMod() * 1.2;
			if (damage < 10) damage = 10;
			if (weaponAttack < 51) damage *= (1 + (weaponAttack * 0.04));
			else if (weaponAttack >= 51 && weaponAttack < 101) damage *= (3 + ((weaponAttack - 50) * 0.035));
			else if (weaponAttack >= 101 && weaponAttack < 151) damage *= (4.75 + ((weaponAttack - 100) * 0.03));
			else if (weaponAttack >= 151 && weaponAttack < 201) damage *= (6.25 + ((weaponAttack - 150) * 0.025));
			else damage *= (7.5 + ((weaponAttack - 200) * 0.02));
			player.takeMagicDamage(damage, true);
			player.takeMagicDamage(damage, true);
			player.takeMagicDamage(damage, true);
			player.takeMagicDamage(damage, true);
			player.takeMagicDamage(damage, true);
			flags[kFLAGS.DIANA_SPELLS_CASTED]++;
		}
		
		public function usingMagicBoltSpell():void {
			outputText("Diana narrow her eyes, focusing her mind with deadly intent.  Then she point her staff and shots magic bolt toward you! ");
			mana -= spellCostMagicBolt();
			var damage:Number = inteligencescalingbonus() * SpellMod() * 1.2;
			if (damage < 10) damage = 10;
			if (weaponAttack < 51) damage *= (1 + (weaponAttack * 0.04));
			else if (weaponAttack >= 51 && weaponAttack < 101) damage *= (3 + ((weaponAttack - 50) * 0.035));
			else if (weaponAttack >= 101 && weaponAttack < 151) damage *= (4.75 + ((weaponAttack - 100) * 0.03));
			else if (weaponAttack >= 151 && weaponAttack < 201) damage *= (6.25 + ((weaponAttack - 150) * 0.025));
			else damage *= (7.5 + ((weaponAttack - 200) * 0.02));
			player.takeMagicDamage(damage, true);
			flags[kFLAGS.DIANA_SPELLS_CASTED]++;
		}
		
		public function usingRegenerateSpell():void {
			outputText("She focus on her body and its desire to end pain, trying to draw on her arousal without enhancing it.\n");
			var hpChange2:int = inte;
			if (findPerk(PerkLib.WisenedHealer) >= 0) hpChange2 += wis;
			createStatusEffect(StatusEffects.MonsterRegen2, 7, hpChange2, 0, 0);
			mana -= spellCostRegenerate();
			flags[kFLAGS.DIANA_SPELLS_CASTED]++;
		}
		
		public function usingHealSpell():void {
			var temp:Number = 0;
			temp += inteligencescalingbonus();
			if (findPerk(PerkLib.WisenedHealer) >= 0) temp += wisdomscalingbonus();
			temp *= HealMod();
			temp = Math.round(temp);
			if (flags[kFLAGS.DIANA_LVL_UP] < 2) outputText("Horse-morph");
			else if (flags[kFLAGS.DIANA_LVL_UP] >= 2 && flags[kFLAGS.DIANA_LVL_UP] < 8) outputText("Unicorn");
			else outputText("Diana");
			outputText(" chant a magical song of healing and recovery and her wounds start knitting themselves shut in response. <b>(<font color=\"#008000\">+" + temp + "</font>)</b>.");
			addHP(temp);
			mana -= spellCostHeal();
			flags[kFLAGS.DIANA_SPELLS_CASTED]++;
		}
		
		override protected function performCombatAction():void
		{
			if (flags[kFLAGS.DIANA_LVL_UP] >= 16 && HPRatio() < .4 && soulforce >= 100 && !hasStatusEffect(StatusEffects.MonsterVPT)) {
				outputText("Diana eyes starts to glow with a violet hue and you can see all of her wounds are now slowly healing.\n");
				createStatusEffect(StatusEffects.MonsterVPT, 550, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 12 && flags[kFLAGS.DIANA_LVL_UP] < 16 && HPRatio() < .3 && soulforce >= 100 && !hasStatusEffect(StatusEffects.MonsterVPT)) {
				outputText("Diana eyes starts to glow with a violet hue and you can see all of her wounds are now slowly healing.\n");
				createStatusEffect(StatusEffects.MonsterVPT, 350, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 8 && flags[kFLAGS.DIANA_LVL_UP] < 12 && HPRatio() < .2 && soulforce >= 100 && !hasStatusEffect(StatusEffects.MonsterVPT)) {
				outputText("Diana eyes starts to glow with a violet hue and you can see all of her wounds are now slowly healing.\n");
				createStatusEffect(StatusEffects.MonsterVPT, 200, 0, 0, 0);
			}
			if (hasStatusEffect(StatusEffects.MonsterVPT)) {
				if (HPRatio() > .9 || soulforce < 100) removeStatusEffect(StatusEffects.MonsterVPT);
				else soulforce -= 100;
			}
			if (HPRatio() < .2 && (mana >= spellCostHeal())) usingHealSpell();
			else if (flags[kFLAGS.DIANA_LVL_UP] >= 12 && flags[kFLAGS.DIANA_LVL_UP] < 16) {
				var choice4:Number = rand(6);
				if (choice4 < 3) {
					if ((soulforce >= soulskillCostHailOfBlades1()) && rand(3) == 0) usingHailOfBlades1Soulskill();
					else if ((soulforce >= soulskillCostManyBirds()) && rand(2) == 0) usingManyBirdsSoulskill();
					else eAttack();
				}
				if (choice4 > 2 && choice4 < 5) {
					if (HPRatio() < .5 && rand(3) == 0 && (mana >= spellCostHeal())) usingHealSpell();
					else if (HPRatio() < .5 && rand(3) == 0 && !hasStatusEffect(StatusEffects.MonsterRegen2) && (mana >= spellCostRegenerate())) usingRegenerateSpell();
					else if (rand(3) == 0 && (mana >= spellCostMagicBoltsBarrage())) usingMagicBoltsBarrageSpell();
					else if (rand(2) == 0 && (mana >= spellCostMagicBolt())) usingMagicBoltSpell();
					else if (rand(2) == 0 && (mana < (this.maxMana() - 1500))) usingARC();
					else eAttack();
				}
				if (choice4 == 5) {
					if (HPRatio() < .8) usingHealPill();
					else eAttack();
				}
			}
			else if (flags[kFLAGS.DIANA_LVL_UP] >= 5 && flags[kFLAGS.DIANA_LVL_UP] < 12) {
				var choice3:Number = rand(6);
				if (choice3 < 3) {
					if ((soulforce >= soulskillCostManyBirds()) && rand(2) == 0) usingManyBirdsSoulskill();
					else eAttack();
				}
				if (choice3 > 2 && choice3 < 5) {
					if (HPRatio() < .6 && rand(3) == 0 && (mana >= spellCostHeal())) usingHealSpell();
					else if (HPRatio() < .6 && rand(3) == 0 && !hasStatusEffect(StatusEffects.MonsterRegen2) && (mana >= spellCostRegenerate())) usingRegenerateSpell();
					else if (rand(2) == 0 && (mana >= spellCostMagicBolt())) usingMagicBoltSpell();
					else if (rand(2) == 0 && (mana < (this.maxMana() - 300))) usingARC();
					else eAttack();
				}
				if (choice3 == 5) {
					if (HPRatio() < .8) usingHealPill();
					else eAttack();
				}
			}
			else if (flags[kFLAGS.DIANA_LVL_UP] >= 2 && flags[kFLAGS.DIANA_LVL_UP] < 5) {
				var choice2:Number = rand(6);
				if (choice2 < 3) {
					if ((soulforce >= soulskillCostManyBirds()) && rand(2) == 0) usingManyBirdsSoulskill();
					else eAttack();
				}
				if (choice2 > 2 && choice2 < 5) {
					if (HPRatio() < .6 && rand(3) == 0 && (mana >= spellCostHeal())) usingHealSpell();
					else if (rand(3) == 0 && (mana < (this.maxMana() - 80))) usingARC();
					else eAttack();
				}
				if (choice2 == 5) {
					if (HPRatio() < .8) usingHealPill();
					else eAttack();
				}
			}
			else {
				var choice1:Number = rand(6);
				if (choice1 < 3) eAttack();
				if (choice1 > 2 && choice1 < 5) {
					if (HPRatio() < .5 && rand(4) == 0 && (mana >= spellCostHeal())) usingHealSpell();
					else if (rand(4) == 0 && (mana < (this.maxMana() - 40))) usingARC();
					else eAttack();
				}
				if (choice1 == 5) {
					if (HPRatio() < .75) usingHealPill();
					else eAttack();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.DIANA_FOLLOWER] >= 6) dianaScene.wonOverDianaSpar();
			else if (flags[kFLAGS.DIANA_AFFECTION] >= 100 && flags[kFLAGS.DIANA_LVL_UP] >= 8) {
				if (flags[kFLAGS.DIANA_FOLLOWER] < 3) dianaScene.beMyStallion();
				else dianaScene.beMyStallionRepeat();
			}
			else dianaScene.wonOverDiana();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.DIANA_FOLLOWER] >= 6) dianaScene.lostToDianaSpar();
			else dianaScene.lostToDiana();
		}
		
		public function Diana() 
		{
			if (flags[kFLAGS.DIANA_LVL_UP] == 0) {
				initStrTouSpeInte(25, 25, 25, 75);
				initWisLibSensCor(25, 25, 25, 50);
				this.weaponAttack = 3;
				this.armorDef = 6;
				this.armorMDef = 12;
				this.level = 3;
				this.bonusHP = 80;
				this.bonusLust = 53;
				this.bonusMana = 50;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 1) {
				initStrTouSpeInte(25, 30, 30, 80);
				initWisLibSensCor(30, 30, 25, 50);
				this.weaponAttack = 3;
				this.armorDef = 6;
				this.armorMDef = 12;
				this.level = 6;
				this.bonusHP = 270;
				this.bonusLust = 61;
				this.bonusMana = 65;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 2) {
				initStrTouSpeInte(30, 40, 35, 80);
				initWisLibSensCor(50, 50, 50, 30);
				this.weaponAttack = 6;
				this.armorDef = 9;
				this.armorMDef = 27;
				this.level = 9;
				this.bonusHP = 485;
				this.bonusLust = 109;
				this.bonusMana = 170;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 3) {
				initStrTouSpeInte(30, 50, 40, 80);
				initWisLibSensCor(60, 55, 50, 30);
				this.weaponAttack = 6;
				this.armorDef = 9;
				this.armorMDef = 27;
				this.level = 12;
				this.bonusHP = 520;
				this.bonusLust = 117;
				this.bonusMana = 220;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 4) {
				initStrTouSpeInte(30, 60, 45, 80);
				initWisLibSensCor(70, 60, 50, 30);
				this.weaponAttack = 6;
				this.armorDef = 9;
				this.armorMDef = 27;
				this.level = 15;
				this.bonusHP = 725;
				this.bonusLust = 125;
				this.bonusMana = 265;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 5) {
				initStrTouSpeInte(30, 70, 50, 80);
				initWisLibSensCor(80, 65, 50, 30);
				this.weaponAttack = 6;
				this.armorDef = 9;
				this.armorMDef = 27;
				this.level = 18;
				this.bonusHP = 730;
				this.bonusLust = 133;
				this.bonusMana = 285;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 6) {
				initStrTouSpeInte(30, 80, 55, 90);
				initWisLibSensCor(80, 70, 50, 30);
				this.weaponAttack = 6;
				this.armorDef = 9;
				this.armorMDef = 27;
				this.level = 21;
				this.bonusHP = 785;
				this.bonusLust = 141;
				this.bonusMana = 310;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 7) {
				initStrTouSpeInte(30, 90, 60, 90);
				initWisLibSensCor(90, 75, 50, 30);
				this.weaponAttack = 6;
				this.armorDef = 9;
				this.armorMDef = 27;
				this.level = 24;
				this.bonusHP = 790;
				this.bonusLust = 149;
				this.bonusMana = 330;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 8) {
				initStrTouSpeInte(40, 100, 70, 100);
				initWisLibSensCor(100, 100, 75, 5);
				this.weaponAttack = 9;
				this.armorDef = 12;
				this.armorMDef = 48;
				this.level = 27;
				this.bonusHP = 1000;
				this.bonusLust = 202;
				this.bonusMana = 450;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 9) {
				initStrTouSpeInte(42, 110, 80, 110);
				initWisLibSensCor(110, 110, 85, 5);
				this.weaponAttack = 10;
				this.armorDef = 13;
				this.armorMDef = 52;
				this.level = 33;
				this.bonusHP = 1010;
				this.bonusLust = 228;
				this.bonusMana = 480;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 10) {
				initStrTouSpeInte(44, 120, 90, 120);
				initWisLibSensCor(120, 120, 95, 5);
				this.weaponAttack = 11;
				this.armorDef = 14;
				this.armorMDef = 56;
				this.level = 39;
				this.bonusHP = 1020;
				this.bonusLust = 254;
				this.bonusMana = 510;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 11) {
				initStrTouSpeInte(46, 130, 100, 130);
				initWisLibSensCor(130, 130, 105, 5);
				this.weaponAttack = 12;
				this.armorDef = 15;
				this.armorMDef = 60;
				this.level = 45;
				this.bonusHP = 1030;
				this.bonusLust = 280;
				this.bonusMana = 540;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 12) {
				initStrTouSpeInte(48, 140, 110, 140);
				initWisLibSensCor(140, 140, 115, 5);
				this.weaponAttack = 13;
				this.armorDef = 16;
				this.armorMDef = 64;
				this.level = 51;
				this.bonusHP = 1040;
				this.bonusLust = 306;
				this.bonusMana = 570;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 13) {
				initStrTouSpeInte(50, 150, 120, 150);
				initWisLibSensCor(150, 150, 125, 5);
				this.weaponAttack = 14;
				this.armorDef = 17;
				this.armorMDef = 68;
				this.level = 57;
				this.bonusHP = 1050;
				this.bonusLust = 332;
				this.bonusMana = 600;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 14) {
				initStrTouSpeInte(52, 160, 130, 160);
				initWisLibSensCor(160, 160, 135, 5);
				this.weaponAttack = 15;
				this.armorDef = 18;
				this.armorMDef = 72;
				this.level = 63;
				this.bonusHP = 1060;
				this.bonusLust = 358;
				this.bonusMana = 630;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 15) {
				initStrTouSpeInte(54, 170, 140, 170);
				initWisLibSensCor(170, 170, 145, 5);
				this.weaponAttack = 16;
				this.armorDef = 19;
				this.armorMDef = 76;
				this.level = 69;
				this.bonusHP = 1070;
				this.bonusLust = 384;
				this.bonusMana = 660;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 16) {
				initStrTouSpeInte(56, 180, 150, 180);
				initWisLibSensCor(180, 180, 155, 5);
				this.weaponAttack = 17;
				this.armorDef = 20;
				this.armorMDef = 80;
				this.level = 75;
				this.bonusHP = 1080;
				this.bonusLust = 410;
				this.bonusMana = 690;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] < 2 && flags[kFLAGS.DIANA_FOLLOWER] < 3) {
				this.a = "the ";
				this.short = "horse morph";
				this.imageName = "whitemare";
				this.long = "You are fighting a white furred 6.6 foot tall horse morph with long white hair and a decently toned body. Her green eyes follows your every move, looking for an exploitable opening. She’s currently in a defensive stance, ready to strike with her staff or kick your face with her hooves at the first opportunity.";
				this.createVagina(true, VaginaClass.WETNESS_DRY, VaginaClass.LOOSENESS_TIGHT);
				createBreastRow(Appearance.breastCupInverse("F"));
				this.tallness = 6*12+6;
				this.hips.type = Hips.RATING_CURVY;
				this.butt.type = Butt.RATING_LARGE;
				this.hairLength = 12;
				this.gems = rand(5) + 5;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.H_PILL,1/5).
					add(consumables.VDARCON,1/5).
					add(consumables.BAGOCA1,1/5).
					add(consumables.EQUINUM,1/2);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 0 && flags[kFLAGS.DIANA_FOLLOWER] == 3) {
				this.a = "the ";
				this.short = "horse morph";
				this.imageName = "whitemare";
				this.long = "You are fighting a white furred 6.8 foot tall horse morph with long white hair and a decently toned body. Her green eyes follows your every move, looking for an exploitable opening. She’s currently in a defensive stance, ready to strike with her staff or kick your face with her hooves at the first opportunity.";
				this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
				createBreastRow(Appearance.breastCupInverse("H"));
				this.tallness = 6*12+8;
				this.hips.type = Hips.RATING_CURVY+2;
				this.butt.type = Butt.RATING_LARGE+1;
				this.hairLength = 16;
				this.gems = rand(5) + 10;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.H_PILL,1/5).
					add(consumables.D_ARCON,1/5).
					add(consumables.BAGOCA1,1/5).
					add(consumables.EQUINUM,1/2);
			}
			if ((flags[kFLAGS.DIANA_LVL_UP] >= 2 && flags[kFLAGS.DIANA_LVL_UP] < 8) && flags[kFLAGS.DIANA_FOLLOWER] < 3) {
				this.a = "the ";
				this.short = "unicorn";
				this.imageName = "unicornmare";
				this.long = "You are fighting a white furred 6.8 foot tall unicorn with long white hair and a decently toned body. Her green eyes follows your every move, looking for an exploitable opening. She’s currently in a defensive stance, ready to strike with her staff or kick your face with her hooves at the first opportunity.";
				this.createVagina(true, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_TIGHT);
				createBreastRow(Appearance.breastCupInverse("H"));
				this.tallness = 6*12+8;
				this.hips.type = Hips.RATING_CURVY+2;
				this.butt.type = Butt.RATING_LARGE+1;
				this.hairLength = 16;
				this.gems = rand(5) + 10;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.MH_PILL,1/5).
					add(consumables.D_ARCON,1/5).
					add(consumables.BAGOCA1,1/5).
					add(consumables.UNICORN,1/2);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 2 && flags[kFLAGS.DIANA_FOLLOWER] == 4) {
				this.a = "the ";
				this.short = "unicorn";
				this.imageName = "unicornmare";
				this.long = "You are fighting a white furred 7 foot tall unicorn with long white hair and a decently toned body. Her green eyes follows your every move, looking for an exploitable opening. She’s currently in a defensive stance, ready to strike with her staff or kick your face with her hooves at the first opportunity.";
				this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_NORMAL);
				createBreastRow(Appearance.breastCupInverse("J"));
				this.tallness = 7*12;
				this.hips.type = Hips.RATING_FERTILE+1;
				this.butt.type = Butt.RATING_JIGGLY+1;
				this.hairLength = 26;
				this.gems = rand(5) + 10;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.MH_PILL,1/5).
					add(consumables.AREGCON,1/5).
					add(consumables.BAGOCA2,1/5).
					add(consumables.UNICORN,1/2);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 8 && flags[kFLAGS.DIANA_LVL_UP] < 17 && (flags[kFLAGS.DIANA_FOLLOWER] < 3 || flags[kFLAGS.DIANA_FOLLOWER] >= 6)) {
				this.a = "";
				this.short = "Diana";
				this.imageName = "diana";
				this.long = "Diana is a white furred 7 foot tall alicorn with long white hair and a decently toned body. Her green eyes follows your every move, looking for an exploitable opening. She’s currently in a defensive stance, ready to strike with her staff or kick your face with her hooves at the first opportunity.";
				this.createVagina(true, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_TIGHT);
				createBreastRow(Appearance.breastCupInverse("J"));
				this.tallness = 7*12;
				this.hips.type = Hips.RATING_FERTILE+1;
				this.butt.type = Butt.RATING_JIGGLY+1;
				this.hairLength = 26;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 8 && flags[kFLAGS.DIANA_LVL_UP] < 12 && (flags[kFLAGS.DIANA_FOLLOWER] < 3 || flags[kFLAGS.DIANA_FOLLOWER] >= 6)) {
				this.gems = rand(6) + 14;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.MH_PILL,1/5).
					add(consumables.AREGCON,1/5).
					add(consumables.BAGOCA3,1/5).
					add(consumables.BAGOCA2,1/4).
					add(consumables.ALICORN,1/2);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 12 && flags[kFLAGS.DIANA_LVL_UP] < 17) {
				this.gems = rand(7) + 18;
				this.drop = new ChainedDrop().
					add(consumables.BH_PILL,1/15).
					add(consumables.BAGOCA4,1/15).
					add(weapons.W_STAFF,1/10).
					add(consumables.MH_PILL,1/5).
					add(consumables.AREGCON,1/5).
					add(consumables.BAGOCA3,1/5).
					add(consumables.BAGOCA2,1/4).
					add(consumables.ALICORN,1/2);
			}
			// this.plural = false;
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.lowerBody = LowerBody.HOOFED;
			this.skinTone = "light";
			this.hairColor = "white";
			this.weaponName = "staff";
			this.weaponVerb="smack";
			this.armorName = "fur";
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.ears.type = Ears.HORSE;
			this.faceType = Face.HORSE;
			this.tailType = Tail.HORSE;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.AlwaysSuccesfullRunaway, 0, 0, 0, 0);
			this.createPerk(PerkLib.WizardsFocus, 0, 0, 0, 0);
			if (flags[kFLAGS.DIANA_LVL_UP] >= 1) {
				this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobHealer, 0, 0, 0, 0);
				this.createPerk(PerkLib.BasicSpirituality, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 2) {
				this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
				this.createPerk(PerkLib.SpellpowerHealing, 0, 0, 0, 0);
				this.createPerk(PerkLib.Diehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 3) {
				this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
				this.createPerk(PerkLib.ManaAffinityI, 0, 0, 0, 0);
				this.createPerk(PerkLib.WisenedHealer, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 4) {
				this.createPerk(PerkLib.SoulPersonage, 0, 0, 0, 0);
				this.createPerk(PerkLib.MindOverBodyI, 0, 0, 0, 0);
				this.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 5) {
				this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToImprovedSpirituality, 0, 0, 0, 0);
				this.createPerk(PerkLib.NaturalHealingMinor, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 6) {
				this.createPerk(PerkLib.DaoistCultivator, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.ImprovedDiehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 7) {
				this.createPerk(PerkLib.SoulSprite, 0, 0, 0, 0);
				this.createPerk(PerkLib.DaoistApprenticeStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.NaturalHealingMajor, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 8) {
				this.createPerk(PerkLib.HclassHeavenTribulationSurvivor, 0, 0, 0, 0);
				this.createPerk(PerkLib.Channeling, 0, 0, 0, 0);
				this.createPerk(PerkLib.DaoistWarriorStage, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 9) {
				this.createPerk(PerkLib.SoulScholar, 0, 0, 0, 0);
				this.createPerk(PerkLib.NaturalHealingEpic, 0, 0, 0, 0);
				this.createPerk(PerkLib.ImprovedSpirituality, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 10) {
				this.createPerk(PerkLib.NaturalHealingLegendary, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulElder, 0, 0, 0, 0);
				this.createPerk(PerkLib.GreaterDiehard, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 11) {
				this.createPerk(PerkLib.GclassHeavenTribulationSurvivor, 0, 0, 0, 0);
				this.createPerk(PerkLib.DaoistElderStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 12) {
				this.createPerk(PerkLib.SoulExalt, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicDiehard, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToAdvancedSpirituality, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 13) {
				this.createPerk(PerkLib.SoulOverlord, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicIntelligence, 0, 0, 0, 0);
				this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 14) {
				this.createPerk(PerkLib.FclassHeavenTribulationSurvivor, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulTyrant, 0, 0, 0, 0);
				this.createPerk(PerkLib.AdvancedSpirituality, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 15) {
				this.createPerk(PerkLib.DaoistOverlordStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicWisdom, 0, 0, 0, 0);
				this.createPerk(PerkLib.Spellpower, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 16) {
				this.createPerk(PerkLib.SoulKing, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToSuperiorSpirituality, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 17) {
				this.createPerk(PerkLib.EclassHeavenTribulationSurvivor, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulEmperor, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] >= 18) {
				this.createPerk(PerkLib.SoulAncestor, 0, 0, 0, 0);
				this.createPerk(PerkLib.SuperiorSpirituality, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.DIANA_FOLLOWER] == 3 || flags[kFLAGS.DIANA_FOLLOWER] == 4) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}