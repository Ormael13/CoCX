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

use namespace CoC;

	public class Aurora extends Monster
	{
		
		
		public function clawstrike():void {
			outputText("Aurora thrust her hand at you.");
			//Dodge
			if (player.getEvasionRoll()) outputText(" You slide underneath the thrust!");
			else
			{
				var damage:Number = 0;
				var storeTou:Number = tou;
				tou = str;
				damage += this.str;
				damage += eBaseStrengthDamage() * 0.5;
				damage += this.tou;
				damage += eBaseToughnessDamage() * 0.5;
				damage += weaponAttack;
				tou = storeTou;
				var crit:Boolean = false;
				var critChance:int = 5;
				if (this.inte <= 200) critChance += this.inte / 10;
				if (this.inte > 200) critChance += 20;
				if (rand(100) < critChance) {
					crit = true;
					damage *= 1.75;
				}
				damage = Math.round(damage);
				outputText(" It strikes you in the chest. ");
				damage = player.takePhysDamage(damage, true);
				if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			}
		}
		
		override protected function performCombatAction():void
		{
			if (flags[kFLAGS.AURORA_LVL] >= 10) {
				var choice2:Number = rand(2);
				if (choice2 == 0) {
					eAttack();
					if (rand(3) > 0) {
						outputText("\n");
						eAttack();
					}
					if (rand(3) == 0) {
						outputText("\n");
						eAttack();
					}
				}
				if (choice2 == 1) {
					clawstrike();
					if (rand(3) > 0) {
						outputText("\n");
						clawstrike();
					}
					if (rand(3) == 0) {
						outputText("\n");
						clawstrike();
					}
				}
				//if (choice2 == 2) x
				//if (choice2 == 3) x
			}
			else if (flags[kFLAGS.AURORA_LVL] >= 6 && flags[kFLAGS.AURORA_LVL] < 10) {
				var choice1:Number = rand(2);
				if (choice1 == 0) {
					eAttack();
					if (rand(3) == 0) {
						outputText("\n");
						eAttack();
					}
				}
				if (choice1 == 1) {
					clawstrike();
					if (rand(3) == 0) {
						outputText("\n");
						clawstrike();
					}
				}
				//if (choice1 == 2) x
			}
			else {
				var choice0:Number = rand(2);
				if (choice0 == 0) eAttack();
				if (choice0 == 1) clawstrike();
			}
		}
		/*
		override public function defeated(hpVictory:Boolean):void
		{
			darkelf.wonWithDarkElf();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			darkelf.lostToDarkElf();
		}
		*/
		public function Aurora() 
		{
			if (flags[kFLAGS.AURORA_LVL] == 1) {
				initStrTouSpeInte(10, 300, 30, 80);
				initWisLibSensCor(80, 20, 10, 50);
				this.weaponAttack = 5;
				this.armorDef = 105;
				this.armorMDef = 105;
				this.bonusHP = 100;
				this.level = 1;
			}
			if (flags[kFLAGS.AURORA_LVL] == 2) {
				initStrTouSpeInte(50, 300, 80, 85);
				initWisLibSensCor(85, 30, 15, 50);
				this.weaponAttack = 9;
				this.armorDef = 105;
				this.armorMDef = 105;
				this.bonusHP = 700;
				this.level = 7;
			}
			if (flags[kFLAGS.AURORA_LVL] == 3) {
				initStrTouSpeInte(90, 320, 130, 90);
				initWisLibSensCor(90, 40, 20, 50);
				this.weaponAttack = 15;
				this.armorDef = 112;
				this.armorMDef = 112;
				this.bonusHP = 1300;
				this.level = 13;
			}
			if (flags[kFLAGS.AURORA_LVL] == 4) {
				initStrTouSpeInte(130, 320, 180, 95);
				initWisLibSensCor(95, 50, 25, 50);
				this.weaponAttack = 23;
				this.armorDef = 112;
				this.armorMDef = 112;
				this.bonusHP = 1900;
				this.level = 19;
			}
			if (flags[kFLAGS.AURORA_LVL] == 5) {
				initStrTouSpeInte(170, 340, 230, 100);
				initWisLibSensCor(100, 60, 30, 50);
				this.weaponAttack = 33;
				this.armorDef = 119;
				this.armorMDef = 119;
				this.bonusHP = 2500;
				this.level = 25;
			}
			if (flags[kFLAGS.AURORA_LVL] == 6) {
				initStrTouSpeInte(210, 340, 280, 105);
				initWisLibSensCor(105, 70, 35, 50);
				this.weaponAttack = 45;
				this.armorDef = 119;
				this.armorMDef = 119;
				this.bonusHP = 3100;
				this.level = 31;
			}
			if (flags[kFLAGS.AURORA_LVL] == 7) {
				initStrTouSpeInte(250, 360, 330, 110);
				initWisLibSensCor(110, 80, 40, 50);
				this.weaponAttack = 59;
				this.armorDef = 126;
				this.armorMDef = 126;
				this.bonusHP = 3700;
				this.level = 37;
			}
			if (flags[kFLAGS.AURORA_LVL] == 8) {
				initStrTouSpeInte(290, 360, 380, 115);
				initWisLibSensCor(115, 90, 45, 50);
				this.weaponAttack = 75;
				this.armorDef = 126;
				this.armorMDef = 126;
				this.bonusHP = 4300;
				this.level = 43;
			}
			if (flags[kFLAGS.AURORA_LVL] == 9) {
				initStrTouSpeInte(330, 380, 430, 120);
				initWisLibSensCor(120, 100, 50, 50);
				this.weaponAttack = 93;
				this.armorDef = 133;
				this.armorMDef = 133;
				this.bonusHP = 4900;
				this.level = 49;
			}
			if (flags[kFLAGS.AURORA_LVL] == 10) {
				initStrTouSpeInte(333, 386, 439, 121);
				initWisLibSensCor(128, 115, 54, 50);
				this.weaponAttack = 97;
				this.armorDef = 135;
				this.armorMDef = 135;
				this.bonusHP = 5000;
				this.bonusWrath = 100;
				this.bonusSoulforce = 400;
				this.level = 55;
			}
			if (flags[kFLAGS.AURORA_LVL] == 11) {
				initStrTouSpeInte(336, 392, 448, 122);
				initWisLibSensCor(136, 130, 58, 50);
				this.weaponAttack = 101;
				this.armorDef = 137;
				this.armorMDef = 137;
				this.bonusHP = 5100;
				this.bonusWrath = 200;
				this.bonusSoulforce = 800;
				this.level = 61;
			}
			if (flags[kFLAGS.AURORA_LVL] == 12) {
				initStrTouSpeInte(339, 398, 457, 123);
				initWisLibSensCor(144, 145, 62, 50);
				this.weaponAttack = 105;
				this.armorDef = 139;
				this.armorMDef = 139;
				this.bonusHP = 5200;
				this.bonusWrath = 300;
				this.bonusSoulforce = 1200;
				this.level = 67;
			}
			if (flags[kFLAGS.AURORA_LVL] == 13) {
				initStrTouSpeInte(342, 404, 466, 124);
				initWisLibSensCor(152, 145, 62, 50);
				this.weaponAttack = 109;
				this.armorDef = 141;
				this.armorMDef = 141;
				this.bonusHP = 5300;
				this.bonusWrath = 400;
				this.bonusSoulforce = 1600;
				this.level = 73;
			}
			if (flags[kFLAGS.AURORA_LVL] < 5) this.lustVuln = .5;
			if (flags[kFLAGS.AURORA_LVL] >= 5 && flags[kFLAGS.AURORA_LVL] < 8) this.lustVuln = .4;
			if (flags[kFLAGS.AURORA_LVL] >= 8 && flags[kFLAGS.AURORA_LVL] < 13) this.lustVuln = .3;
			if (flags[kFLAGS.AURORA_LVL] >= 13 && flags[kFLAGS.AURORA_LVL] < 18) this.lustVuln = .2;
			if (flags[kFLAGS.AURORA_LVL] >= 18) this.lustVuln = .1;
			this.a = "";
			this.short = "Aurora";
			this.imageName = "aurora";
			this.long = "Before you stands Aurora at 9 feet tall, and has an overall thicker body than most golems. She has HHH cup breasts. Right above where her cleavage begins, is a black tattoo with the letter A above 3 lines, forming the Roman numeral 3. Her skin is a light turquoise with blue markings all over, and a white belly. Her hair is a navy blue, with green eyes on a bat-like face. Two huge bat wings come from her back, and she has a long tail ending in blue fur. Around her neck is a mane of light blue fur. Two huge bat ears swivel around from the top of her head, detecting all noises in the area.";
			this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("HHH"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 108;//9 feet
			this.hips.type = Hips.RATING_CURVY + 4;
			this.butt.type = Butt.RATING_EXPANSIVE + 1;
			this.skinTone = "turquoise";
			this.hairColor = "navy blue";
			this.hairLength = 20;
			this.weaponName = "claws";
			this.weaponVerb = "claw-slash";
			this.armorName = "stone skin";
			this.bonusLust = 20;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 0;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.Sentience, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			if (flags[kFLAGS.AURORA_LVL] >= 2) {
				this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
				this.createPerk(PerkLib.UnlockArdor, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 3) {
				this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
				this.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 4) {
				this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobBeastWarrior, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 5) {
				this.createPerk(PerkLib.SoulPersonage, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 6) {
				this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
				this.createPerk(PerkLib.ClawTraining, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 7) {
				this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
				this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 8) {
				this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
				this.createPerk(PerkLib.ImprovingNaturesBlueprintsApexPredator, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 9) {
				this.createPerk(PerkLib.SoulSprite, 0, 0, 0, 0);
				this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 10) {
				this.createPerk(PerkLib.FeralArmor, 0, 0, 0, 0);
				this.createPerk(PerkLib.ExtraClawAttack, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 11) {
				this.createPerk(PerkLib.SoulScholar, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);//czy coś innego związanego z spe/tou/str/lib statami jako perk?
			}
			if (flags[kFLAGS.AURORA_LVL] >= 12) {
				this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);//czy coś innego związanego z spe/tou/str/lib statami jako perk?
				this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);//czy coś innego związanego z spe/tou/str/lib statami jako perk?
			}
			if (flags[kFLAGS.AURORA_LVL] >= 13) {
				this.createPerk(PerkLib.SoulElder, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicLibido, 0, 0, 0, 0);//czy coś innego związanego z spe/tou/str/lib statami jako perk?
			}
			//prestige job sentinel? next step after epic tou/spe/str/lib?
			checkMonster();
		}	
	}
}