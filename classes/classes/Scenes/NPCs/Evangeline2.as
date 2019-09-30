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

public class Evangeline2 extends Monster
	{
		
		public function spellCostChargeWeapon():Number {
			var cost:Number = 30;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 10) cost -= 3;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 30) cost -= 3;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 70) cost -= 3;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 150) cost -= 3;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 310) cost -= 3;
			return cost;
		}
		public function spellCostChargeArmor():Number {
			var cost:Number = 40;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 10) cost -= 4;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 30) cost -= 4;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 70) cost -= 4;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 150) cost -= 4;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 310) cost -= 4;
			return cost;
		}
		public function spellCostBlind():Number {
			var cost:Number = 10;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 10) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 30) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 70) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 150) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 310) cost -= 1;
			return cost;
		}
		public function spellCostWhitefire():Number {
			var cost:Number = 40;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 10) cost -= 4;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 30) cost -= 4;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 70) cost -= 4;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 150) cost -= 4;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 310) cost -= 4;
			return cost;
		}
		public function spellCostArouse():Number {
			var cost:Number = 20;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 10) cost -= 2;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 30) cost -= 2;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 70) cost -= 2;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 150) cost -= 2;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 310) cost -= 2;
			return cost;
		}
		public function spellCostHeal():Number {
			var cost:Number = 30;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 10) cost -= 3;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 30) cost -= 3;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 70) cost -= 3;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 150) cost -= 3;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 310) cost -= 3;
			return cost;
		}
		public function spellCostMight():Number {
			var cost:Number = 50;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 10) cost -= 5;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 30) cost -= 5;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 70) cost -= 5;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 150) cost -= 5;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 310) cost -= 5;
			return cost;
		}
		public function spellCostBlink():Number {
			var cost:Number = 40;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 10) cost -= 4;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 30) cost -= 4;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 70) cost -= 4;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 150) cost -= 4;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 310) cost -= 4;
			return cost;
		}
		public function spellCostChargeWeaponMight():Number {
			var cost:Number = 80;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 10) cost -= 8;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 30) cost -= 8;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 70) cost -= 8;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 150) cost -= 8;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 310) cost -= 8;
			return cost;
		}
		
		public function SpellMod():Number {
			var mod:Number = 1;
			if (findPerk(PerkLib.Channeling) >= 0) mod += .2;
			if (findPerk(PerkLib.JobSorcerer) >= 0) mod += .1;
			if (findPerk(PerkLib.Mage) >= 0) mod += .2;
			if (findPerk(PerkLib.Spellpower) >= 0) mod += .2;
			if (findPerk(PerkLib.WizardsFocus) >= 0) mod += .5;
			return mod;
		}
		
		public function ChargeWeaponSpell():void {
			outputText("Evangeline utters word of power, summoning an electrical charge around her weapon. <b>It looks like she'll deal more physical damage now!</b>");
			createStatusEffect(StatusEffects.ChargeWeapon, 50, 0, 0, 0);
			if (findPerk(PerkLib.JobEnchanter) >= 0) this.weaponAttack += (5 + (inte / 10)) * 1.2 * SpellMod();
			else this.weaponAttack += (5 + (inte / 10)) * SpellMod();
			fatigue += spellCostChargeWeapon();
			flags[kFLAGS.EVANGELINE_SPELLS_CASTED]++;
		}
		
		public function ChargeArmorSpell():void {
			outputText("Evangeline utters word of power, summoning an electrical charge around her armor. <b>It looks like her armor will be reducing some of incoming damage now!</b>");
			createStatusEffect(StatusEffects.ChargeArmor, 50, 0, 0, 0);
			if (findPerk(PerkLib.JobEnchanter) >= 0) this.armorDef += (4 + (inte / 15)) * 1.2 * SpellMod();
			else this.armorDef += (4 + (inte / 15)) * SpellMod();
			fatigue += spellCostChargeArmor();
			flags[kFLAGS.EVANGELINE_SPELLS_CASTED]++;
		}
		
		public function BlindSpell():void {
			outputText("Evangeline glare at you and point at you.  A bright flash erupts before you!\n");
			if ((player.findPerk(PerkLib.GorgonsEyes) < 0 && rand(100) > 20) && !player.hasPerk(PerkLib.BlindImmunity)) {
				player.createStatusEffect(StatusEffects.Blind,2,0,0,0);
			}
			else if (player.findPerk(PerkLib.GorgonsEyes) >= 0) {
				outputText("Your mutated eyes not been affected at all by this flash!");
			}
			else {
				outputText("You manage to blink in the nick of time!");
			}
			fatigue += spellCostBlind();
			flags[kFLAGS.EVANGELINE_SPELLS_CASTED]++;
		}
		
		public function WhiteFireSpell():void {
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
			outputText("Evangeline narrows her eyes and focuses her mind with deadly intent. She snaps her fingers and you are enveloped in a flash of white flames!  Thanks to surrounding you ice shards this attack isn't at it peak power!  ");
			damage *= 0.2;
			}
			else {
			outputText("Evangeline narrows her eyes and focuses her mind with deadly intent. She snaps her fingers and you are enveloped in a flash of white flames!  ");
			}
			if (player.isGoo()) {
				damage *= 1.5;
				outputText("It's super effective!  ");
			}
			damage = Math.round(damage);
			player.takeFireDamage(damage, true);
			fatigue += spellCostWhitefire();
			flags[kFLAGS.EVANGELINE_SPELLS_CASTED]++;
		}
		
		public function ArouseSpell():void {
			outputText("Evangeline make a series of arcane gestures, drawing on her own lust to inflict it upon you!\n", true);
			var lustDmg:Number = player.lustVuln * (inte/5*SpellMod() + rand(player.lib - player.inte*2 + player.cor)/5);
			if(player.lust < (player.maxLust() * 0.3)) outputText("You squirms as the magic affects you.  ");
			if(player.lust >= (player.maxLust() * 0.3) && player.lust < (player.maxLust() * 0.6)) outputText("You staggers, suddenly weak and having trouble focusing on staying upright.  ");
			if(player.lust >= (player.maxLust() * 0.6)) outputText("Your eyes glaze over with desire for a moment.  ");
			lustDmg = Math.round(lustDmg);
			player.dynStats("lus", lustDmg, "scale", false);
			outputText(" <b>(<font color=\"#ff00ff\">" + lustDmg + "</font>)</b>");
			fatigue += spellCostArouse();
			flags[kFLAGS.EVANGELINE_SPELLS_CASTED]++;
		}
		
		public function HealSpell():void {
			var temp:int = (inte/3 + rand(inte/2));
			if (inte >= 21 && inte < 41) temp += (inte / 2 + rand((inte * 3) / 4));
			if (inte >= 41 && inte < 61) temp += ((inte * 2) / 3 + rand(inte));
			if (inte >= 61 && inte < 81) temp += ((inte * 5) / 6 + rand(inte * 1.25));
			if (inte >= 81 && inte < 101) temp += (inte + rand(inte * 1.5));
			if (inte >= 101) temp += ((inte * 1.25) + rand(inte * 1.75));
			temp *= SpellMod();
			temp = Math.round(temp);
			outputText("Evangeline flushes with success as her wounds begin to knit! <b>(<font color=\"#008000\">+" + temp + "</font>)</b>.");
			addHP(temp);
			fatigue += spellCostHeal();
			flags[kFLAGS.EVANGELINE_SPELLS_CASTED]++;
		}
		
		public function MightSpell():void {
			outputText("She flushes, drawing on her body's desires to empower her muscles and toughen her up.");
			outputText("The rush of success and power flows through her body.  <b>She looks like she can do anything!</b>");
			createStatusEffect(StatusEffects.Might, 50, 0, 0, 0);
			if (findPerk(PerkLib.JobEnchanter) >= 0) {
				this.str += (5 + (inte / 10)) * 1.2 * SpellMod();
				this.tou += (5 + (inte / 10)) * 1.2 * SpellMod();
			}
			else {
				this.str += (5 + (inte / 10)) * SpellMod();
				this.tou += (5 + (inte / 10)) * SpellMod();
			}
			fatigue += spellCostMight();
			flags[kFLAGS.EVANGELINE_SPELLS_CASTED]++;
		}
		
		public function BlinkSpell():void {
			outputText("She flushes, drawing on her body's desires to empower her muscles and hasten her up.");
			outputText("The rush of success and power flows through her body.  <b>She looks like she can move faster!</b>");
			createStatusEffect(StatusEffects.Blink, 50, 0, 0, 0);
			if (findPerk(PerkLib.JobEnchanter) >= 0) this.spe += (5 + (inte / 10)) * 1.5 * SpellMod();
			else this.spe += (5 + (inte / 10)) * 1.2 * SpellMod();
			fatigue += spellCostBlink();
			flags[kFLAGS.EVANGELINE_SPELLS_CASTED]++;
		}
		
		public function ChargeWeaponMightSpell():void {
			outputText("Evangeline utters word of power, summoning an electrical charge around her weapon. <b>It looks like she'll deal more physical damage now!</b>\n\n");
			createStatusEffect(StatusEffects.ChargeWeapon, 50, 0, 0, 0);
			this.weaponAttack += (5 + (inte / 10)) * 1.2 * SpellMod();
			outputText("She flushes, drawing on her body's desires to empower her muscles and toughen her up.");
			outputText("The rush of success and power flows through her body.  <b>She looks like she can do anything!</b>\n\n");
			createStatusEffect(StatusEffects.Might, 50, 0, 0, 0);
			this.str += (5 + (inte / 10)) * 1.2 * SpellMod();
			this.tou += (5 + (inte / 10)) * 1.2 * SpellMod();
			fatigue += spellCostChargeWeaponMight();
			flags[kFLAGS.EVANGELINE_SPELLS_CASTED] += 2;
		}
		
		override protected function performCombatAction():void
		{
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 10 || flags[kFLAGS.EVANGELINE_LVL_UP] == 11) {
				if (!hasStatusEffect(StatusEffects.ChargeWeapon)) {
					ChargeWeaponMightSpell();
					eAttack();
				}
				else {
					//var choice3:Number = rand(3);
					var choice3:Number = rand(2);
					if (choice3 == 0) eAttack();
					if (choice3 == 1) {
						if ((this.lust < maxLust() * 0.75) && !hasStatusEffect(StatusEffects.ChargeArmor)) ChargeArmorSpell();
						else if (!hasStatusEffect(StatusEffects.Blink) && (fatigue < (maxFatigue() - spellCostBlink()))) BlinkSpell();
						else if (HPRatio() < .75 && (fatigue < (maxFatigue() - spellCostHeal()))) HealSpell();
						else if ((this.lust < maxLust() * 0.75) && rand(2) == 0 && (fatigue < (maxFatigue() - spellCostBlind())) && !player.hasStatusEffect(StatusEffects.Blind)) BlindSpell();
						else if (rand(2) == 0 && (fatigue < (maxFatigue() - spellCostArouse()))) ArouseSpell();
						else if ((this.lust < maxLust() * 0.75) && (fatigue < (maxFatigue() - spellCostWhitefire()))) WhiteFireSpell();
						else eAttack();
					}
					//if (choice3 == 3) EvangelineTease();
				}
			}
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 8 || flags[kFLAGS.EVANGELINE_LVL_UP] == 9) {
				//var choice2:Number = rand(3);
				var choice2:Number = rand(2);
				if (choice2 == 0) eAttack();
				if (choice2 == 1) {
					if ((this.lust < maxLust() * 0.75) && !hasStatusEffect(StatusEffects.ChargeWeapon)) ChargeWeaponSpell();
					else if (!hasStatusEffect(StatusEffects.Might) && (fatigue < (maxFatigue() - spellCostMight()))) MightSpell();
					else if ((this.lust < maxLust() * 0.75) && !hasStatusEffect(StatusEffects.ChargeArmor)) ChargeArmorSpell();
					else if (!hasStatusEffect(StatusEffects.Blink) && (fatigue < (maxFatigue() - spellCostBlink()))) BlinkSpell();
					else if (HPRatio() < .75 && (fatigue < (maxFatigue() - spellCostHeal()))) HealSpell();
					else if ((this.lust < maxLust() * 0.75) && rand(2) == 0 && (fatigue < (maxFatigue() - spellCostBlind())) && !player.hasStatusEffect(StatusEffects.Blind)) BlindSpell();
					else if (rand(2) == 0 && (fatigue < (maxFatigue() - spellCostArouse()))) ArouseSpell();
					else if ((this.lust < maxLust() * 0.75) && (fatigue < (maxFatigue() - spellCostWhitefire()))) WhiteFireSpell();
					else eAttack();
				}
				//if (choice2 == 3) EvangelineTease();
			}
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 7) {
				//var choice1:Number = rand(3);
				var choice1:Number = rand(2);
				if (choice1 == 0) eAttack();
				if (choice1 == 1) {
					if (this.lust > 50) {
						if ((this.lust < maxLust() * 0.75) && !hasStatusEffect(StatusEffects.ChargeWeapon)) ChargeWeaponSpell();
						else if ((this.lust < maxLust() * 0.75) && !hasStatusEffect(StatusEffects.ChargeArmor)) ChargeArmorSpell();
						else if (!hasStatusEffect(StatusEffects.Might) && (fatigue < (maxFatigue() - spellCostMight()))) MightSpell();
						else if (!hasStatusEffect(StatusEffects.Blink) && (fatigue < (maxFatigue() - spellCostBlink()))) BlinkSpell();
						else if (HPRatio() < .75 && (fatigue < (maxFatigue() - spellCostHeal()))) HealSpell();
						else if ((this.lust < maxLust() * 0.75) && rand(2) == 0 && (fatigue < (maxFatigue() - spellCostBlind())) && !player.hasStatusEffect(StatusEffects.Blind)) BlindSpell();
						else if (rand(2) == 0 && (fatigue < (maxFatigue() - spellCostArouse()))) ArouseSpell();
						else if ((this.lust < maxLust() * 0.75) && (fatigue < (maxFatigue() - spellCostWhitefire()))) WhiteFireSpell();
						else eAttack();
					}
					else {
						if ((this.lust < maxLust() * 0.75) && !hasStatusEffect(StatusEffects.ChargeWeapon)) ChargeWeaponSpell();
						else if ((this.lust < maxLust() * 0.75) && !hasStatusEffect(StatusEffects.ChargeArmor)) ChargeArmorSpell();
						else if ((this.lust < maxLust() * 0.75) && (fatigue < (maxFatigue() - spellCostWhitefire()))) WhiteFireSpell();
						else if ((this.lust < maxLust() * 0.75) && rand(2) == 0 && (fatigue < (maxFatigue() - spellCostBlind())) && !player.hasStatusEffect(StatusEffects.Blind)) BlindSpell();
						else eAttack();
					}
				}
				//if (choice1 == 3) EvangelineTease();
			}
		}
		
		public function Evangeline2() 
		{
			this.a = "";
			this.short = "Evangeline";
			this.imageName = "evangeline";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 7) {//na etapie tym zrobić event z atakiem na obóz i ktoś z atakujących poznaje Evangeline jako demonice - po tym jest scena z Eve ujawniającą swoje demoniczne korzenie a także jak sie jej udawało ukrywać swoją korupcje przed mieszkańcami obozu i PC ^^
				this.long = "You are currently fighting Evangeline, which is a seven and a half feet tall human bimbo. She's wearing practically indecent steel armor and using inscribed spellblade to attack.";
				createBreastRow(Appearance.breastCupInverse("E"));
				this.tallness = 90;
				this.hairColor = "platinum blonde";
				this.skin.setBaseOnly({color:"olive"});
				this.hips.type = Hips.RATING_CURVY + 2;//hips.type = 12
				this.butt.type = Butt.RATING_JIGGLY + 2;//butt.type = 12
				initStrTouSpeInte(29, 34, 45, 50);
				this.weaponName = "inscribed spellblade";
				this.weaponVerb="slash";
				this.weaponAttack = 9;
				this.armorName = "practically indecent steel armor";
				this.armorDef = 11;
				this.armorMDef = 5;
				this.bonusHP = 210;
				this.bonusLust = 40;
				this.lustVuln = .8;
				this.lust = 40;
				this.additionalXP += 35;
				this.level = 14;
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			}//nie gotowy etap
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 8) {
				this.long = "You are currently fighting Evangeline, which is a seven and a half feet tall human bimbo. She's wearing lusty maiden's armor and using inscribed spellblade to attack.";
				createBreastRow(Appearance.breastCupInverse("E"));
				this.tallness = 90;
				this.hairColor = "platinum blonde";
				this.skin.restore();
				this.hips.type = Hips.RATING_CURVY + 2;
				this.butt.type = Butt.RATING_JIGGLY + 2;
				initStrTouSpeInte(41, 46, 55, 50);
				this.weaponName = "inscribed spellblade";
				this.weaponVerb="slash";
				this.weaponAttack = 9;
				this.armorName = "lusty maiden's armor";
				this.armorDef = 16;
				this.armorMDef = 5;
				this.bonusHP = 240;
				this.bonusLust = 40;
				this.lustVuln = .8;
				this.lust = 70;
				this.additionalXP += 40;
				this.level = 16;
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
				this.createPerk(PerkLib.Channeling, 0, 0, 0, 0);
			}//nie gotowy etap
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 9) {
				this.long = "You are currently fighting Evangeline, which is a seven and a half feet tall human bimbo. She's wearing lusty maiden's armor and using inscribed spellblade to attack.";
				createBreastRow(Appearance.breastCupInverse("E"));
				this.tallness = 90;
				this.hairColor = "platinum crimson";
				this.skin.setBaseOnly({});
				this.hips.type = Hips.RATING_CURVY + 2;
				this.butt.type = Butt.RATING_JIGGLY + 2;
				initStrTouSpeInte(41, 46, 55, 50);
				this.weaponName = "inscribed spellblade";
				this.weaponVerb="slash";
				this.weaponAttack = 9;
				this.armorName = "lusty maiden's armor";
				this.armorDef = 16;
				this.armorMDef = 5;
				this.bonusHP = 270;
				this.bonusLust = 40;
				this.lustVuln = .8;
				this.lust = 70;
				this.additionalXP += 45;
				this.level = 18;
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
				this.createPerk(PerkLib.Channeling, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobEnchanter, 0, 0, 0, 0);
			}//nie gotowy etap
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 10) {
				this.long = "You are currently fighting Evangeline, which is a eight feet tall cow-morph bimbo. She's wearing lusty maiden's armor and using inscribed spellblade to attack.";
				createBreastRow(Appearance.breastCupInverse("F"));
				this.tallness = 96;
				this.hairColor = "crimson platinum";
				this.skin.growFur();
				this.hips.type = Hips.RATING_FERTILE + 3;//hips.type = 18
				this.butt.type = Butt.RATING_EXPANSIVE + 1;//butt.type = 14
				initStrTouSpeInte(41, 46, 70, 50);
				this.weaponName = "inscribed spellblade";
				this.weaponVerb="slash";
				this.weaponAttack = 9;
				this.armorName = "lusty maiden's armor";
				this.armorDef = 16;
				this.armorMDef = 10;
				this.bonusHP = 330;
				this.bonusLust = 40;//Jak zyska perk BoosTierEnemy wtedy bonus lust musi wzrosnac do 50 z 40 wiec do tego czasu nie ma bonus lust bedzie na 40 stał
				this.lust = 70;
				this.lustVuln = .75;//im bedziej poteżna bedzie tym bliżej 0 powinno być czyli trudniej ją lustem pobijać ^^
				this.additionalXP += 55;
				this.level = 22;
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
				this.createPerk(PerkLib.Channeling, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobEnchanter, 0, 0, 0, 0);
				//this.createPerk(PerkLib., 0, 0, 0, 0);//tu powinien być dodany perk Spellsword dający autorzucanie charge weapon ale, że to npc to sie załatwi w kodzie to zamiast dodawać perk ;)
				//this.createPerk(PerkLib., 0, 0, 0, 0);//tu powinien być dodany perk Battlemage dający autorzucanie might ale, że to npc to sie załatwi w kodzie to zamiast dodawać perk ;)
			}
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 11) {
				this.long = "You are currently fighting Evangeline, which is a eight feet tall cow-morph bimbo. She's wearing lusty maiden's armor and using inscribed spellblade to attack.";
				createBreastRow(Appearance.breastCupInverse("F"));//succubus milk może teoretycznie w nieskończoność zwiekszać rozmiar biustu
				this.tallness = 96;
				this.hairColor = "crimson platinum";
				this.skin.growFur();
				this.hips.type = Hips.RATING_FERTILE + 3;//hips.type = 18
				this.butt.type = Butt.RATING_EXPANSIVE + 1;//butt.type = 14
				initStrTouSpeInte(41, 46, 80, 50);
				this.weaponName = "inscribed spellblade";
				this.weaponVerb="slash";
				this.weaponAttack = 9;
				this.armorName = "lusty maiden's armor";
				this.armorDef = 16;
				this.armorMDef = 10;
				this.bonusHP = 360;
				this.bonusLust = 40;
				this.lust = 70;
				this.lustVuln = .75;
				this.additionalXP += 60;
				this.level = 24;//nastepny lvl to 28 i dać kilka kolejnych etapów zmiany dot. bazowych mutacji: cow, succubus, kitsune i dragoness. zawsze wpierw danej rasy zmiany i +4 lvl w gór a potem +2 lvl i inne zmiany/dostosowania do nowej formy ;)
				//w Evangeline 4 zamieścić etapy zmiany obejmujące inne rasy jak mantis/salamander a w Evangeline 5 awasowanie jako bogini (max do lvl 200) ^^
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
				this.createPerk(PerkLib.Channeling, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobEnchanter, 0, 0, 0, 0);
				this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			}
			this.createVagina(false, VaginaClass.WETNESS_DRY, VaginaClass.LOOSENESS_TIGHT);
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.skinTone = "olive";
			this.hairLength = 36;
			initWisLibSensCor(15, 25, 35, 100);
			this.fatigue = 0;
			this.gems = 0;
			this.drop = NO_DROP;
			this.lib += 5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.createPerk(PerkLib.WizardsFocus, 0, 0, 0, 0);
			this.createPerk(PerkLib.EzekielBlessing, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
			this.createPerk(PerkLib.Spellpower, 0, 0, 0, 0);
			this.createPerk(PerkLib.Mage, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}