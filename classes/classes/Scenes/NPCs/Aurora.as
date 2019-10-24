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
		public function soulskillCostTripleTrust():Number {
			var cost:Number = 30;
			if (this.level >= 24) cost += 30;
			if (this.level >= 42) cost += 30;
			if (this.level >= 60) cost += 30;
			if (this.level >= 78) cost += 30;
			return cost;
		}
		public function soulskillCostSextupleTrust():Number {
			var cost:Number = 70;
			if (this.level >= 24) cost += 70;
			if (this.level >= 42) cost += 70;
			if (this.level >= 60) cost += 70;
			if (this.level >= 78) cost += 70;
			return cost;
		}
		public function soulskillCostNonupleTrust():Number {
			var cost:Number = 150;
			if (this.level >= 24) cost += 150;
			if (this.level >= 42) cost += 150;
			if (this.level >= 60) cost += 150;
			if (this.level >= 78) cost += 150;
			return cost;
		}
		
		public function wingbuffetattack():void {
			clearOutput();
			var damage:Number = 0;
			damage += this.str / 6;
			damage += this.tou / 6;
			var crit:Boolean = false;
			var critChance:int = 5;
			if (this.inte <= 200) critChance += this.inte / 10;
			if (this.inte > 200) critChance += 20;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
			createStatusEffect(StatusEffects.AbilityCooldown1, 4, 0, 0, 0);
			outputText("Aurora flaps her huge bat wings at you trying to knock you down. You’re thrown to the ground. <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			if (player.findPerk(PerkLib.Resolute) < 0) player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			if (player.findPerk(PerkLib.Resolute) >= 0) outputText(" You’re thankfully to resilient to be stunned by such attacks and remain standing.");
		}
		
		public function tripletrust():void {
			outputText("Aurora ready her claws and prepare to thrust it towards you. ");
			if (player.getEvasionRoll()) outputText(" You slide underneath the thrust!");
			else {
				this.soulforce -= soulskillCostTripleTrust();
				outputText(" Her hand hits you thrice dealing ");
				trustD();
				trustD();
				trustD();
				outputText(" damage!");
			}
		}
		public function sextupletrust():void {
			outputText("Aurora ready her claws and prepare to thrust it towards you. ");
			if (player.getEvasionRoll()) outputText(" You slide underneath the thrust!");
			else {
				createStatusEffect(StatusEffects.AbilityCooldown2, 1, 0, 0, 0);
				this.soulforce -= soulskillCostSextupleTrust();
				outputText(" Her hand hits you six times dealing ");
				trustD();
				trustD();
				trustD();
				trustD();
				trustD();
				trustD();
				outputText(" damage!");
			}
		}
		public function nonupletrust():void {
			outputText("Aurora ready her claws and prepare to thrust it towards you. ");
			if (player.getEvasionRoll()) outputText(" You slide underneath the thrust!");
			else {
				createStatusEffect(StatusEffects.AbilityCooldown3, 2, 0, 0, 0);
				this.soulforce -= soulskillCostNonupleTrust();
				outputText(" Her hand hits you nine times dealing ");
				trustD();
				trustD();
				trustD();
				trustD();
				trustD();
				trustD();
				trustD();
				trustD();
				trustD();
				outputText("damage!");
			}
		}
		private function trustD():void {
			var td:Number = 0;
			td += this.str;
			td += eBaseStrengthDamage() * 0.5;
			if (weaponAttack < 51) td *= (1 + (weaponAttack * 0.04));
			else if (weaponAttack >= 51 && weaponAttack < 101) td *= (3 + ((weaponAttack - 50) * 0.035));
			else if (weaponAttack >= 101 && weaponAttack < 151) td *= (4.75 + ((weaponAttack - 100) * 0.03));
			else if (weaponAttack >= 151 && weaponAttack < 201) td *= (6.25 + ((weaponAttack - 150) * 0.025));
			else td *= (7.5 + ((weaponAttack - 200) * 0.02));
			var crit:Boolean = false;
			var critChance:int = 5;
			if (this.inte <= 200) critChance += this.inte / 10;
			if (this.inte > 200) critChance += 20;
			if (rand(100) < critChance) {
				crit = true;
				td *= 1.75;
			}
			var td2:Number = 0.9;
			td2 += (rand(21) * 0.01);
			td *= td2;
			td = Math.round(td);
			td = player.takePhysDamage(td, true);
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText(" ");
		}
		
		public function clawstrike():void {
			outputText("Aurora thrust her hand at you.");
			//Dodge
			if (player.getEvasionRoll()) outputText(" You slide underneath the thrust!");
			else
			{
				var damage:Number = 0;
				var storeTou:Number = tou;//obniża tou dla ataku na gracza do poziomu str
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
			if (flags[kFLAGS.AURORA_LVL] >= 3 && HPRatio() < .4 && soulforce >= 100 && !hasStatusEffect(StatusEffects.MonsterVPT)) {
				outputText("Aura eyes starts to glow with a violet hue and you can see all of her wounds are now slowly healing.\n");
				createStatusEffect(StatusEffects.MonsterVPT, 200, 0, 0, 0);
			}
			if (hasStatusEffect(StatusEffects.MonsterVPT)) {
				if (HPRatio() > .8 || soulforce < 100) removeStatusEffect(StatusEffects.MonsterVPT);
				else soulforce -= 100;
			}
			if (flags[kFLAGS.AURORA_LVL] >= 9) {
				var choice4:Number = rand(3);
				if (choice4 == 0) {
					eAttack();
					if (rand(3) > 0) {
						outputText("\n");
						eAttack();
					}
					if (rand(3) == 0) {
						outputText("\n");
						eAttack();
					}
					if (rand(3) == 0) {
						outputText("\n");
						eAttack();
					}
					if (rand(3) == 0) {
						outputText("\n");
						eAttack();
					}
				}
				if (choice4 == 1) {
					clawstrike();
					if (rand(3) == 0) {
						outputText("\n");
						clawstrike();
					}
					if (rand(3) == 0) {
						outputText("\n");
						clawstrike();
					}
					if (rand(3) == 0) {
						outputText("\n");
						clawstrike();
					}
					if (rand(3) == 0) {
						outputText("\n");
						clawstrike();
					}
				}
				if (choice4 == 2) {
					if (this.soulforce >= soulskillCostNonupleTrust() && !hasStatusEffect(StatusEffects.AbilityCooldown3)) nonupletrust();
					else if (this.soulforce >= soulskillCostSextupleTrust() && !hasStatusEffect(StatusEffects.AbilityCooldown2)) sextupletrust();
					else if (this.soulforce >= soulskillCostTripleTrust()) tripletrust();
					else {
						clawstrike();
						if (rand(3) == 0) {
							outputText("\n");
							clawstrike();
						}
						if (rand(3) == 0) {
							outputText("\n");
							clawstrike();
						}
						if (rand(3) == 0) {
							outputText("\n");
							clawstrike();
						}
						if (rand(3) == 0) {
							outputText("\n");
							clawstrike();
						}
					}
				}
				if (choice4 == 3) {
					if (hasStatusEffect(StatusEffects.AbilityCooldown1)) {
						eAttack();
						if (rand(3) == 0) {
							outputText("\n");
							eAttack();
						}
						if (rand(3) == 0) {
							outputText("\n");
							eAttack();
						}
						if (rand(3) == 0) {
							outputText("\n");
							eAttack();
						}
						if (rand(3) == 0) {
							outputText("\n");
							eAttack();
						}
					}
					else wingbuffetattack();
				}
				//if (choice4 == 4) x
				//if (choice4 == 5) x
				//if (choice4 == 6) x
			}
			if (flags[kFLAGS.AURORA_LVL] >= 7 && flags[kFLAGS.AURORA_LVL] < 9) {
				var choice3:Number = rand(3);
				if (choice3 == 0) {
					eAttack();
					if (rand(3) == 0) {
						outputText("\n");
						eAttack();
					}
					if (rand(3) == 0) {
						outputText("\n");
						eAttack();
					}
					if (rand(3) == 0) {
						outputText("\n");
						eAttack();
					}
				}
				if (choice3 == 1) {
					clawstrike();
					if (rand(3) == 0) {
						outputText("\n");
						clawstrike();
					}
					if (rand(3) == 0) {
						outputText("\n");
						clawstrike();
					}
					if (rand(3) == 0) {
						outputText("\n");
						clawstrike();
					}
				}
				if (choice3 == 2) {
					if (this.soulforce >= soulskillCostNonupleTrust() && !hasStatusEffect(StatusEffects.AbilityCooldown3)) nonupletrust();
					else if (this.soulforce >= soulskillCostSextupleTrust() && !hasStatusEffect(StatusEffects.AbilityCooldown2)) sextupletrust();
					else if (this.soulforce >= soulskillCostTripleTrust()) tripletrust();
					else {
						clawstrike();
						if (rand(3) == 0) {
							outputText("\n");
							clawstrike();
						}
						if (rand(3) == 0) {
							outputText("\n");
							clawstrike();
						}
						if (rand(3) == 0) {
							outputText("\n");
							clawstrike();
						}
					}
				}
				if (choice3 == 3) {
					if (hasStatusEffect(StatusEffects.AbilityCooldown1)) {
						eAttack();
						if (rand(3) == 0) {
							outputText("\n");
							eAttack();
						}
						if (rand(3) == 0) {
							outputText("\n");
							eAttack();
						}
						if (rand(3) == 0) {
							outputText("\n");
							eAttack();
						}
					}
					else wingbuffetattack();
				}
				//if (choice3 == 4) x
				//if (choice3 == 5) some elemental melee soulskill like fire / ice fist / punch chi chi teach
			}
			if (flags[kFLAGS.AURORA_LVL] >= 5 && flags[kFLAGS.AURORA_LVL] < 7) {
				var choice2:Number = rand(3);
				if (choice2 == 0) {
					eAttack();
					if (rand(3) == 0) {
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
					if (rand(3) == 0) {
						outputText("\n");
						clawstrike();
					}
					if (rand(3) == 0) {
						outputText("\n");
						clawstrike();
					}
				}
				if (choice2 == 2) {
					if (this.soulforce >= soulskillCostSextupleTrust() && !hasStatusEffect(StatusEffects.AbilityCooldown2)) sextupletrust();
					else if (this.soulforce >= soulskillCostTripleTrust()) tripletrust();
					else {
						clawstrike();
						if (rand(3) == 0) {
							outputText("\n");
							clawstrike();
						}
						if (rand(3) == 0) {
							outputText("\n");
							clawstrike();
						}
					}
				}
				if (choice2 == 3) {
					if (hasStatusEffect(StatusEffects.AbilityCooldown1)) {
						eAttack();
						if (rand(3) == 0) {
							outputText("\n");
							eAttack();
						}
						if (rand(3) == 0) {
							outputText("\n");
							eAttack();
						}
					}
					else wingbuffetattack();
				}
				//if (choice2 == 4) Yin Palm
			}
			else if (flags[kFLAGS.AURORA_LVL] >= 3 && flags[kFLAGS.AURORA_LVL] < 5) {
				var choice1:Number = rand(3);
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
				if (choice1 == 2) {
					if (this.soulforce >= soulskillCostSextupleTrust() && !hasStatusEffect(StatusEffects.AbilityCooldown2)) sextupletrust();
					else if (this.soulforce >= soulskillCostTripleTrust()) tripletrust();
					else {
						clawstrike();
						if (rand(3) == 0) {
							outputText("\n");
							clawstrike();
						}
					}
				}
				if (choice1 == 3) {
					if (hasStatusEffect(StatusEffects.AbilityCooldown1)) {
						eAttack();
						if (rand(3) == 0) {
							outputText("\n");
							eAttack();
						}
					}
					else wingbuffetattack();
				}
			}
			else {
				var choice0:Number = rand(3);
				if (choice0 == 0) eAttack();
				if (choice0 == 1) clawstrike();
				if (choice0 == 2) {
					if (this.soulforce >= soulskillCostTripleTrust()) tripletrust();
					else clawstrike();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.auroraFollower.AuroraLostSparring();
		}
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.auroraFollower.AuroraWonSparring();
		}
		
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
			this.long = "Before you stands Aurora at 9 feet tall, she has an overall thicker body than most golems. Right above where her cleavage begins, is a black tattoo with the letter A above 3 lines, forming the Roman numeral 3. Her skin is a light turquoise with blue markings all over and a white belly. Two huge bat wings come from her back, and she has a long tail ending in blue fur. Around her neck is a mane of light blue fur. Two huge bat ears swivel around from the top of her head, detecting all noises in the area.";
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
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.Sentience, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.BodyCultivator, 0, 0, 0, 0);
			this.createPerk(PerkLib.UnlockArdor, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobBeastWarrior, 0, 0, 0, 0);
			if (flags[kFLAGS.AURORA_LVL] >= 2) {
				this.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
				this.createPerk(PerkLib.ToughHide, 0, 0, 0, 0);
				this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
				this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
				this.createPerk(PerkLib.BasicTranquilness, 0, 0, 0, 0);
				this.createPerk(PerkLib.BasicSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 3) {
				this.createPerk(PerkLib.FleshBodyApprenticeStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.ClawTraining, 0, 0, 0, 0);
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 4) {
				this.createPerk(PerkLib.SoulPersonage, 0, 0, 0, 0);
				this.createPerk(PerkLib.FeralArmor, 0, 0, 0, 0);
				this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 5) {//lvl 25
				this.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
				this.createPerk(PerkLib.ExtraClawAttack, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToImprovedSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 6) {//lvl 31
				this.createPerk(PerkLib.HclassHeavenTribulationSurvivor, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulSprite, 0, 0, 0, 0);
				this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 7) {//lvl 37
				this.createPerk(PerkLib.FleshBodyWarriorStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.MultiClawAttack, 0, 0, 0, 0);
				this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 8) {//lvl 43
				this.createPerk(PerkLib.SoulScholar, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
				this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 9) {//lvl 49
				this.createPerk(PerkLib.SoulElder, 0, 0, 0, 0);
				this.createPerk(PerkLib.ClawingFlurry, 0, 0, 0, 0);
				this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 10) {//lvl 55
				this.createPerk(PerkLib.GclassHeavenTribulationSurvivor, 0, 0, 0, 0);
				this.createPerk(PerkLib.SoulExalt, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 11) {//lvl 61
				this.createPerk(PerkLib.FleshBodyElderStage, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
				this.createPerk(PerkLib.HalfStepToAdvancedSelfControl, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 12) {//lvl 67
				this.createPerk(PerkLib.SoulOverlord, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicLibido, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.AURORA_LVL] >= 13) {//lvl 73
				this.createPerk(PerkLib.SoulTyrant, 0, 0, 0, 0);
				this.createPerk(PerkLib.AdvancedSelfControl, 0, 0, 0, 0);
			}
			//prestige job sentinel? next step after epic tou/spe/str/lib?
			checkMonster();
		}	
	}
}