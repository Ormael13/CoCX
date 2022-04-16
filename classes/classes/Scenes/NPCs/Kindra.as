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
import classes.internals.*;

use namespace CoC;
	
	public class Kindra extends Monster
	{
		public var kindraScene:KindraFollower = new KindraFollower();
		
		public function bowShooting():Number {
			var cost:Number = 15;
			if (flags[kFLAGS.KINDRA_ARROWS_SHOT] >= 60) cost -= 5;
			if (flags[kFLAGS.KINDRA_ARROWS_SHOT] >= 240) cost -= 5;
			return cost;
		}
		public function soulskillMulti():Number {
			var multi:Number = 1;
			if (hasPerk(PerkLib.DaoistCultivator)) multi += 0.2;
			if (hasPerk(PerkLib.DaoistApprenticeStage)) {
				if (hasPerk(PerkLib.SoulApprentice)) multi += .4;
				if (hasPerk(PerkLib.SoulPersonage)) multi += .4;
				if (hasPerk(PerkLib.SoulWarrior)) multi += .4;
			}
			if (hasPerk(PerkLib.DaoistWarriorStage)) {
				if (hasPerk(PerkLib.SoulSprite)) multi += .6;
				if (hasPerk(PerkLib.SoulScholar)) multi += .6;
				if (hasPerk(PerkLib.SoulElder)) multi += .6;
			}
			if (hasPerk(PerkLib.DaoistElderStage)) {
				if (hasPerk(PerkLib.SoulExalt)) multi += .8;
				if (hasPerk(PerkLib.SoulOverlord)) multi += .8;
				if (hasPerk(PerkLib.SoulTyrant)) multi += .8;
			}
			return multi;
		}
		
		public function KindraFireBow01():void {
			KindraFireBow();
		}
		public function KindraFireBow02():void {
			KindraFireBow();
			KindraFireBow();
		}
		public function KindraFireBow03():void {
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
		}
		public function KindraFireBow04():void {
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
		}
		public function KindraFireBow05():void {
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
		}
		public function KindraFireBow06():void {
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
			KindraFireBow();
		}
		
		public function KindraFireBow():void {
			if (flags[kFLAGS.KINDRA_AFFECTION] < 7) outputText("Sheep-morph archer");
			if (flags[kFLAGS.KINDRA_AFFECTION] >= 7) outputText("Kindra");
			outputText(" casually fire an arrow at you with supreme skill.");
			if (player.hasStatusEffect(StatusEffects.WindWall)) {
				outputText(" Still surrounding you wind wall stops it without much trouble.");
				player.addStatusValue(StatusEffects.WindWall,2,-1);
			}
			else {
				var damage:Number = 0;
				damage += eBaseSpeedDamage() * 0.2;
				if (damage < 10) damage = 10;
				//weapon bonus
				if (this.weaponRangeAttack < 51) damage *= (1 + (this.weaponRangeAttack * 0.03));
				else if (this.weaponRangeAttack >= 51 && this.weaponRangeAttack < 101) damage *= (2.5 + ((this.weaponRangeAttack - 50) * 0.025));
				else if (this.weaponRangeAttack >= 101 && this.weaponRangeAttack < 151) damage *= (3.75 + ((this.weaponRangeAttack - 100) * 0.02));
				else if (this.weaponRangeAttack >= 151 && this.weaponRangeAttack < 201) damage *= (4.75 + ((this.weaponRangeAttack - 150) * 0.015));
				else damage *= (5.5 + ((this.weaponRangeAttack - 200) * 0.01));
				player.takePhysDamage(damage, true);
			}
			outputText("\n\n");
			fatigue += bowShooting();
			flags[kFLAGS.KINDRA_ARROWS_SHOT]++;
		}
		
		public function KindraDrinkSheepMilk():void {
			if (flags[kFLAGS.KINDRA_AFFECTION] < 5) outputText("Sheep-morph archer");
			if (flags[kFLAGS.KINDRA_AFFECTION] >= 5) outputText("Kindra");
			outputText(" gulps down a bottle of sheep milk.\n");
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 15) {
				fatigue -= 240;
				if (lust >= 81) lust -= 80;
				else lust = 0;
			}
			else if (flags[kFLAGS.KINDRA_LVL_UP] >= 11) {
				fatigue -= 180;
				if (lust >= 61) lust -= 60;
				else lust = 0;
			}
			else if (flags[kFLAGS.KINDRA_LVL_UP] >= 7) {
				fatigue -= 120;
				if (lust >= 41) lust -= 40;
				else lust = 0;
			}
			else {
				fatigue -= 60;
				if (lust >= 21) lust -= 20;
				else lust = 0;
			}
		}
		
		public function KindraManyBirdsSoulskill():void {
			outputText("Kindra thrust her hand outwards with deadly intent, and in the blink of an eye a crystals shoots towards you.  Crystals hits you, dealing ");
			var soulforcecost:int = 9;
			soulforce -= soulforcecost;
			var damage:Number = wisdomscalingbonus();
			damage *= soulskillMulti();
			if (damage < 10) damage = 10;
			damage = Math.round(damage);
			player.takeMagicDamage(damage, true);
			outputText(" damage!");
		}
		
		override protected function performCombatAction():void
		{
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 7 && HPRatio() < .5 && soulforce >= 100 && !hasStatusEffect(StatusEffects.MonsterVPT)) {
				outputText("Kindra eyes starts to glow with a violet hue and you can see all of her wounds are now slowly healing.\n");
				createStatusEffect(StatusEffects.MonsterVPT, 200, 0, 0, 0);
			}
			if (hasStatusEffect(StatusEffects.MonsterVPT)) {
				if (HPRatio() > .9 || soulforce < 100) removeStatusEffect(StatusEffects.MonsterVPT);
				else soulforce -= 100;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 15) {
				if (fatigue < (maxFatigue() - (bowShooting() * 6))) {
					if (rand(2) == 0) {
						if (fatigue >= 240) KindraDrinkSheepMilk();
						else KindraFireBow04();
					}
					else {
						if (rand(2) == 0) {
							if (fatigue >= 240) KindraDrinkSheepMilk();
							else KindraFireBow05();
						}
						else KindraFireBow06();
					}
				}
				else {
					if (rand(3) == 0 && fatigue >= 240) KindraDrinkSheepMilk();
					else {
						if (rand(2) == 0 && soulforce >= 10) KindraManyBirdsSoulskill();
						else eAttack();
					}
				}
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 11 && flags[kFLAGS.KINDRA_LVL_UP] < 15) {
				if (fatigue < (maxFatigue() - (bowShooting() * 6))) {
					if (rand(2) == 0) {
						if (fatigue >= 180) KindraDrinkSheepMilk();
						else KindraFireBow04();
					}
					else {
						if (rand(2) == 0) {
							if (fatigue >= 180) KindraDrinkSheepMilk();
							else KindraFireBow05();
						}
						else KindraFireBow06();
					}
				}
				else {
					if (rand(3) == 0 && fatigue >= 180) KindraDrinkSheepMilk();
					else {
						if (rand(2) == 0 && soulforce >= 10) KindraManyBirdsSoulskill();
						else eAttack();
					}
				}
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 7 && flags[kFLAGS.KINDRA_LVL_UP] < 11) {
				if (fatigue < (maxFatigue() - (bowShooting() * 6))) {
					if (rand(2) == 0) {
						if (fatigue >= 120) KindraDrinkSheepMilk();
						else KindraFireBow04();
					}
					else {
						if (rand(2) == 0) {
							if (fatigue >= 120) KindraDrinkSheepMilk();
							else KindraFireBow05();
						}
						else KindraFireBow06();
					}
				}
				else {
					if (rand(3) == 0 && fatigue >= 120) KindraDrinkSheepMilk();
					else eAttack();
				}
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 6) {
				if (fatigue < (maxFatigue() - (bowShooting() * 6))) KindraFireBow06();
				else {
					if (rand(3) == 0 && fatigue >= 60) KindraDrinkSheepMilk();
					else eAttack();
				}
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 5) {
				if (fatigue < (maxFatigue() - (bowShooting() * 5))) KindraFireBow05();
				else {
					if (rand(3) == 0 && fatigue >= 60) KindraDrinkSheepMilk();
					else eAttack();
				}
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 4) {
				if (fatigue < (maxFatigue() - (bowShooting() * 4))) KindraFireBow04();
				else {
					if (rand(3) == 0 && fatigue >= 60) KindraDrinkSheepMilk();
					else eAttack();
				}
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 3) {
				if (fatigue < (maxFatigue() - (bowShooting() * 3))) KindraFireBow03();
				else {
					if (rand(3) == 0 && fatigue >= 60) KindraDrinkSheepMilk();
					else eAttack();
				}
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 2) {
				if (fatigue < (maxFatigue() - (bowShooting() * 2))) KindraFireBow02();
				else {
					if (rand(3) == 0 && fatigue >= 60) KindraDrinkSheepMilk();
					else eAttack();
				}
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 1) {
				if (fatigue < (maxFatigue() - bowShooting())) KindraFireBow01();
				else {
					if (rand(3) == 0 && fatigue >= 60) KindraDrinkSheepMilk();
					else eAttack();
				}
			}
		}//używanie sheep milk w czasie walki czasami (daje -60 fat i -20 lust)
		//nie zapomnieć używać KINDRA_ARROWS_SHOT flagi do śledzenia ile już strzał wystrzeliła kindra w celu zmniejszania kosztu ich
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.KINDRA_FOLLOWER] == 1) kindraScene.wonFightWithKindra();
			else if (flags[kFLAGS.KINDRA_AFFECTION] >= 6) kindraScene.thirdWonFightWithKindra();
			else if (flags[kFLAGS.KINDRA_AFFECTION] >= 2 && flags[kFLAGS.KINDRA_AFFECTION] < 6) kindraScene.secondWonFightWithKindra();
			else kindraScene.firstWonFightWithKindra();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.KINDRA_FOLLOWER] == 1) kindraScene.lostFightWithKindra();
			else kindraScene.lostFightToKindra();
		}
		
		public function Kindra()
		{
			if (flags[kFLAGS.KINDRA_AFFECTION] < 7) {
				this.a = "the ";
				this.short = "sheep-morph archer";
				this.imageName = "kindra";
				this.long = "You fight against sheep-morph archer.";//6'4"
				this.weaponName = "dagger";
				this.weaponRangeName = "bow";
				this.armorName = "clothes";
			}
			if (flags[kFLAGS.KINDRA_AFFECTION] >= 7) {
				this.a = "";
				this.short = "Kindra";
				this.imageName = "kindra";
				if (flags[kFLAGS.KINDRA_LVL_UP] < 7) {
					this.long = "You fight against Kindra.";//6'4"
					this.weaponName = "dagger";
					this.weaponRangeName = "bow";
					this.armorName = "clothes";
				}
				if (flags[kFLAGS.KINDRA_LVL_UP] >= 7 && flags[kFLAGS.KINDRA_LVL_UP] < 15) {
					this.long = "You fight against Kindra.";//6'4"
					this.weaponName = "sharp dagger";
					this.weaponRangeName = "long bow";
					this.armorName = "light leather armor";
				}
				if (flags[kFLAGS.KINDRA_LVL_UP] >= 15) {
					this.long = "You fight against Kindra.";//6'4"
					this.weaponName = "sharp tri-dagger";
					this.weaponRangeName = "long composite bow";//potem jak stanie sie wiecej niż sheep-morph kolejna zmiana łuku
					this.armorName = "light ebonweave armor";
				}
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 1) {
				initStrTouSpeInte(30, 50, 100, 80);
				initWisLibSensCor(80, 30, 40, 10);
				this.weaponAttack = 8;
				this.weaponRangeAttack = 20;
				this.armorDef = 5;
				this.armorMDef = 5;
				this.bonusHP = 50;
				this.bonusLust = 90;
				this.level = 20;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 2) {
				initStrTouSpeInte(40, 65, 120, 100);
				initWisLibSensCor(100, 30, 40, 10);
				this.weaponAttack = 8;
				this.weaponRangeAttack = 20;
				this.armorDef = 5;
				this.armorMDef = 5;
				this.bonusHP = 100;
				this.bonusLust = 95;
				this.level = 25;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 3) {
				initStrTouSpeInte(50, 80, 140, 120);
				initWisLibSensCor(120, 30, 40, 10);
				this.weaponAttack = 8;
				this.weaponRangeAttack = 20;
				this.armorDef = 5;
				this.armorMDef = 5;
				this.bonusHP = 150;
				this.bonusLust = 100;
				this.level = 30;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 4) {
				initStrTouSpeInte(60, 95, 160, 140);
				initWisLibSensCor(140, 30, 40, 10);
				this.weaponAttack = 8;
				this.weaponRangeAttack = 20;
				this.armorDef = 5;
				this.armorMDef = 5;
				this.bonusHP = 200;
				this.bonusLust = 105;
				this.level = 35;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 5) {
				initStrTouSpeInte(70, 110, 180, 150);
				initWisLibSensCor(150, 30, 40, 10);
				this.weaponAttack = 8;
				this.weaponRangeAttack = 20;
				this.armorDef = 5;
				this.armorMDef = 5;
				this.bonusHP = 250;
				this.bonusLust = 110;
				this.level = 40;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 6) {
				initStrTouSpeInte(80, 130, 205, 150);
				initWisLibSensCor(150, 30, 40, 10);
				this.weaponAttack = 8;
				this.weaponRangeAttack = 20;
				this.armorDef = 5;
				this.armorMDef = 5;
				this.bonusHP = 300;
				this.bonusLust = 115;
				this.level = 45;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 7) {
				initStrTouSpeInte(100, 150, 235, 150);
				initWisLibSensCor(150, 50, 50, 10);
				this.weaponAttack = 16;
				this.weaponRangeAttack = 50;
				this.armorDef = 16;
				this.armorMDef = 5;
				this.bonusHP = 320;
				this.bonusLust = 151;
				this.level = 51;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 8) {
				initStrTouSpeInte(120, 170, 270, 160);
				initWisLibSensCor(160, 70, 60, 10);
				this.weaponAttack = 17;
				this.weaponRangeAttack = 55;
				this.armorDef = 18;
				this.armorMDef = 5;
				this.bonusHP = 340;
				this.bonusLust = 187;
				this.level = 57;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 9) {
				initStrTouSpeInte(140, 190, 305, 170);
				initWisLibSensCor(170, 90, 70, 10);
				this.weaponAttack = 18;
				this.weaponRangeAttack = 60;
				this.armorDef = 20;
				this.armorMDef = 5;
				this.bonusHP = 360;
				this.bonusLust = 223;
				this.level = 63;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 10) {
				initStrTouSpeInte(160, 210, 340, 180);
				initWisLibSensCor(180, 110, 80, 10);
				this.weaponAttack = 19;
				this.weaponRangeAttack = 65;
				this.armorDef = 22;
				this.armorMDef = 6;
				this.bonusHP = 380;
				this.bonusLust = 259;
				this.level = 69;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 11) {
				initStrTouSpeInte(180, 230, 375, 190);
				initWisLibSensCor(190, 130, 90, 10);
				this.weaponAttack = 20;
				this.weaponRangeAttack = 70;
				this.armorDef = 24;
				this.armorMDef = 7;
				this.bonusHP = 400;
				this.bonusLust = 295;
				this.level = 75;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 12) {
				initStrTouSpeInte(200, 250, 410, 200);
				initWisLibSensCor(200, 150, 100, 10);
				this.weaponAttack = 21;
				this.weaponRangeAttack = 75;
				this.armorDef = 26;
				this.armorMDef = 8;
				this.bonusHP = 420;
				this.bonusLust = 331;
				this.level = 81;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 13) {
				initStrTouSpeInte(220, 270, 445, 210);
				initWisLibSensCor(210, 170, 110, 10);
				this.weaponAttack = 22;
				this.weaponRangeAttack = 80;
				this.armorDef = 28;
				this.armorMDef = 9;
				this.bonusHP = 440;
				this.bonusLust = 367;
				this.level = 87;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 14) {
				initStrTouSpeInte(240, 290, 480, 220);
				initWisLibSensCor(220, 190, 120, 10);
				this.weaponAttack = 23;
				this.weaponRangeAttack = 85;
				this.armorDef = 30;
				this.armorMDef = 10;
				this.bonusHP = 460;
				this.bonusLust = 403;
				this.level = 93;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 15) {
				initStrTouSpeInte(260, 310, 515, 230);
				initWisLibSensCor(230, 210, 130, 10);
				this.weaponAttack = 24;
				this.weaponRangeAttack = 90;
				this.armorDef = 45;
				this.armorMDef = 15;
				this.bonusHP = 480;
				this.bonusLust = 439;
				this.level = 99;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 16) {
				initStrTouSpeInte(300, 350, 585, 250);
				initWisLibSensCor(250, 250, 150, 10);
				this.weaponAttack = 30;
				this.weaponRangeAttack = 120;
				this.armorDef = 50;
				this.armorMDef = 17;
				this.bonusHP = 600;
				this.bonusLust = 505;
				this.level = 105;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] == 17) {
				initStrTouSpeInte(340, 390, 655, 270);
				initWisLibSensCor(270, 290, 170, 10);
				this.weaponAttack = 32;
				this.weaponRangeAttack = 130;
				this.armorDef = 55;
				this.armorMDef = 19;
				this.bonusHP = 650;
				this.bonusLust = 571;
				this.level = 111;
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 6) {
				this.drop = new ChainedDrop().
						add(consumables.BAGOCA3,0.2).
						add(consumables.MG_SFRP,0.3).
						add(consumables.SHEEPMK,0.6);
			}
			else {
				this.drop = new ChainedDrop().
						add(consumables.BAGOCA2,0.2).
						add(consumables.LG_SFRP,0.3).
						add(consumables.SHEEPMK,0.6);
			}
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_TIGHT);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 64;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_TIGHT;
			this.skinTone = "white";
			this.hairColor = "white";
			this.hairLength = 4;
			this.weaponVerb= "stab";
			this.weaponRangeVerb= "shoot";
			this.lust = 20;
			this.lustVuln = .95;
			this.gems = 0;
			this.createPerk(PerkLib.JobRanger, 0, 0, 0, 0);
			this.createPerk(PerkLib.BasicEndurance, 0, 0, 0, 0);
			this.createPerk(PerkLib.ArchersStaminaI, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulPersonage, 0, 0, 0, 0);
			this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 1) {
				this.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.HclassHeavenTribulationSurvivor, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulSprite, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 2) {
				this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToImprovedEndurance, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulScholar, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 4) {
				this.createPerk(PerkLib.JobHunter, 0, 0, 0, 0);
				this.createPerk(PerkLib.ImprovedEndurance, 0, 0, 0, 0);
				this.createPerk(PerkLib.VitalShot, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 6) {
				this.createPerk(PerkLib.PrestigeJobArcaneArcher, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToAdvancedEndurance, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulElder, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 7) {
				this.createPerk(PerkLib.NaturesSpringI, 0, 0, 0, 0);
				this.createPerk(PerkLib.PrestigeJobArcaneArcher, 0, 0, 0, 0);
				this.createPerk(PerkLib.GclassHeavenTribulationSurvivor, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 8) {
				this.createPerk(PerkLib.AdvancedEndurance, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulExalt, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 9) {
				this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulOverlord, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 10) {
				this.createPerk(PerkLib.HalfStepToSuperiorEndurance, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToAdvancedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.FclassHeavenTribulationSurvivor, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 11) {
				this.createPerk(PerkLib.AdvancedSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.DaoistCultivator, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulTyrant, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 12) {
				this.createPerk(PerkLib.SuperiorEndurance, 0, 0, 0, 0);
				this.createPerk(PerkLib.DaoistApprenticeStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.PrestigeJobSoulArcher, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 13) {
				this.createPerk(PerkLib.HalfStepToSuperiorSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.LegendarySpeed, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulKing, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 14) {
				this.createPerk(PerkLib.HalfStepToPeerlessEndurance, 0, 0, 0, 0);
				this.createPerk(PerkLib.DaoistWarriorStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.EclassHeavenTribulationSurvivor, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 15) {
				this.createPerk(PerkLib.SuperiorSelfControl, 0, 0, 0, 0);
				this.createPerk(PerkLib.DaoistElderStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulEmperor, 0, 0, 0, 0);
			}
			//if (flags[kFLAGS.KINDRA_LVL_UP] >= ) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);kiedy zacznie sie KindraQuest
			checkMonster();
		}
		
	}

}