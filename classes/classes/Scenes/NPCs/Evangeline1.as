/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	public class Evangeline1 extends Monster
	{
		/*
		Perki jakie Evangeline powinna zdobyć:
		JobWarrior (zrobić custom eAttack i tam wstawić jak ma ten perk to 1.05x dmg)
		JobBrawler
		IronFistsI (w NG+ i dalej kolejne tego wersje chyba)
		Berzerker
		ColdFury
		Regeneration (w NG+ i dalej kolejne tego wersje chyba)
		ImprovedEndurance
		AdvancedEndurance
		IronMan
		SuperiorEndurance
		JobRanger
		ManaAffinityI (w NG+ i dalej kolejne tego wersje chyba)
		MindOverBodyI (w NG+ i dalej kolejne tego wersje chyba)
		Battlemage
		Spellsword
		Battleflash
		Spellarmor
		JobSeducer
		ImprovedSelfControl
		AdvancedSelfControl
		InhumanDesireI (w NG+ i dalej kolejne tego wersje chyba)
		DemonicDesireI (w NG+ i dalej kolejne tego wersje chyba)
		SuperiorSelfControl
		?CorruptedLibido?
		?Seduction?
		?ArousingAura?
		BlackHeart
		DraconicLungs
		KitsuneThyroidGland
		MantislikeAgility
		SalamanderAdrenalGlands
		TrachealSystem
		?DeityJobMunchkin? - tylko czy możliwe skoro nie ma duszy na stałe w ciele wiec nie może nauczyć zostać Soul Cultivator a może w jej wypadku zignorowąć ten wymóg lub wytłumaczyć tym iż jej dusza w lethice może zostać soul cultivator i ona majac odrobine jej ze sobą potrafi w bardzo ograniczonym stopniu używać soulforce...
		*/	
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
			var cost:Number = 10;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 10) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 30) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 70) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 150) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 310) cost -= 1;
			return cost;
		}
		public function spellCostArouse():Number {
			var cost:Number = 10;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 10) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 30) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 70) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 150) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 310) cost -= 1;
			return cost;
		}
		public function spellCostHeal():Number {
			var cost:Number = 10;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 10) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 30) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 70) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 150) cost -= 1;
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 310) cost -= 1;
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
		
		public function SpellMod():Number {
			var mod:Number = 1;
			if (findPerk(PerkLib.JobSorcerer) >= 0) mod += .1;
			if (findPerk(PerkLib.Mage) >= 0) mod += .2;
			if (findPerk(PerkLib.Spellpower) >= 0) mod += .2;
			if (findPerk(PerkLib.WizardsFocus) >= 0) mod += .5;
			return mod;
		}
		
		public function ChargeWeaponSpell():void {
			outputText("Evangeline utters word of power, summoning an electrical charge around her weapon. <b>It looks like she'll deal more physical damage now!</b>");
			createStatusEffect(StatusEffects.ChargeWeapon, 50, 0, 0, 0);
			this.weaponAttack += (5 + (inte / 10)) * SpellMod();
			fatigue += spellCostChargeWeapon();
			flags[kFLAGS.EVANGELINE_SPELLS_CASTED]++;
		}
		
		public function ChargeArmorSpell():void {
			outputText("Evangeline utters word of power, summoning an electrical charge around her armor. <b>It looks like her armor will be reducing some of incoming damage now!</b>");
			createStatusEffect(StatusEffects.ChargeArmor, 50, 0, 0, 0);
			this.armorDef += (4 + (inte / 15)) * SpellMod();
			fatigue += spellCostChargeArmor();
			flags[kFLAGS.EVANGELINE_SPELLS_CASTED]++;
		}
		
		public function BlindSpell():void {
			outputText("Evangeline glare at you and point at you.  A bright flash erupts before you!\n");
			if (player.findPerk(PerkLib.GorgonsEyes) < 0 && rand(100) > 20) {
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
			if (inte >= 101) damage += ((inte * 1.25) + rand(inte * 1.75));
			damage *= SpellMod();
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
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
			damage *= 0.25;
			damage = Math.round(damage);
			player.takeDamage(damage, true);
			fatigue += spellCostWhitefire();
			flags[kFLAGS.EVANGELINE_SPELLS_CASTED]++;
		}
		
		public function ArouseSpell():void {
			outputText("Evangeline make a series of arcane gestures, drawing on her own lust to inflict it upon you!\n", true);
			var lustDmg:Number = player.lustVuln * (inte/5*SpellMod() + rand(player.lib - player.inte*2 + player.cor)/5);
			if(player.lust < (player.maxLust() * 0.3)) outputText("You squirms as the magic affects you.  ");
			if(player.lust >= (player.maxLust() * 0.3) && player.lust < (player.maxLust() * 0.6)) outputText("You staggers, suddenly weak and having trouble focusing on staying upright.  ");
			if(player.lust >= (player.maxLust() * 0.6)) outputText("Your eyes glaze over with desire for a moment.  ");
			lustDmg *= 0.5;
			lustDmg = Math.round(lustDmg);
			game.dynStats("lus", lustDmg, "resisted", false);
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
			temp /= 3;
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
			this.str += (5 + (inte / 10)) * SpellMod();
			this.tou += (5 + (inte / 10)) * SpellMod();
			fatigue += spellCostMight();
			flags[kFLAGS.EVANGELINE_SPELLS_CASTED]++;
		}
		
		public function BlinkSpell():void {
			outputText("She flushes, drawing on her body's desires to empower her muscles and hasten her up.");
			outputText("The rush of success and power flows through her body.  <b>She looks like she can move faster!</b>");
			createStatusEffect(StatusEffects.Blink, 50, 0, 0, 0);
			this.spe += (5 + (inte / 10)) * 1.2 * SpellMod();
			fatigue += spellCostBlink();
			flags[kFLAGS.EVANGELINE_SPELLS_CASTED]++;
		}
		
		override protected function performCombatAction():void
		{
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 6) {
				var choice4:Number = rand(2);
				if (choice4 == 0) eAttack();
				if (choice4 == 1) {
					if (this.lust > 50) {
						if ((this.lust < eMaxLust() * 0.75) && !hasStatusEffect(StatusEffects.ChargeWeapon)) ChargeWeaponSpell();
						else if ((this.lust < eMaxLust() * 0.75) && !hasStatusEffect(StatusEffects.ChargeArmor)) ChargeArmorSpell();
						else if (!hasStatusEffect(StatusEffects.Might) && (fatigue < (eMaxFatigue() - spellCostMight()))) MightSpell();
						else if (!hasStatusEffect(StatusEffects.Blink) && (fatigue < (eMaxFatigue() - spellCostBlink()))) BlinkSpell();
						else if (HPRatio() < .75 && (fatigue < (eMaxFatigue() - spellCostHeal()))) HealSpell();
						else if ((this.lust < eMaxLust() * 0.75) && rand(2) == 0 && (fatigue < (eMaxFatigue() - spellCostBlind())) && !player.hasStatusEffect(StatusEffects.Blind)) BlindSpell();
						else if (rand(2) == 0 && (fatigue < (eMaxFatigue() - spellCostArouse()))) ArouseSpell();
						else if ((this.lust < eMaxLust() * 0.75) && (fatigue < (eMaxFatigue() - spellCostWhitefire()))) WhiteFireSpell();
						else eAttack();
					}
					else {
						if ((this.lust < eMaxLust() * 0.75) && !hasStatusEffect(StatusEffects.ChargeWeapon)) ChargeWeaponSpell();
						else if ((this.lust < eMaxLust() * 0.75) && !hasStatusEffect(StatusEffects.ChargeArmor)) ChargeArmorSpell();
						else if ((this.lust < eMaxLust() * 0.75) && (fatigue < (eMaxFatigue() - spellCostWhitefire()))) WhiteFireSpell();
						else if ((this.lust < eMaxLust() * 0.75) && rand(2) == 0 && (fatigue < (eMaxFatigue() - spellCostBlind())) && !player.hasStatusEffect(StatusEffects.Blind)) BlindSpell();
						else eAttack();
					}
				}
				combatRoundOver();
			}
			else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 5) {
				var choice3:Number = rand(2);
				if (choice3 == 0) eAttack();
				if (choice3 == 1) {
					if (this.lust > 50) {
						if ((this.lust < eMaxLust() * 0.75) && !hasStatusEffect(StatusEffects.ChargeWeapon)) ChargeWeaponSpell();
						else if (!hasStatusEffect(StatusEffects.Might) && (fatigue < (eMaxFatigue() - spellCostMight()))) MightSpell();
						else if (HPRatio() < .75 && (fatigue < (eMaxFatigue() - spellCostHeal()))) HealSpell();
						else if ((this.lust < eMaxLust() * 0.75) && rand(2) == 0 && (fatigue < (eMaxFatigue() - spellCostBlind())) && !player.hasStatusEffect(StatusEffects.Blind)) BlindSpell();
						else if (rand(2) == 0 && (fatigue < (eMaxFatigue() - spellCostArouse()))) ArouseSpell();
						else if ((this.lust < eMaxLust() * 0.75) && (fatigue < (eMaxFatigue() - spellCostWhitefire()))) WhiteFireSpell();
						else eAttack();
					}
					else {
						if ((this.lust < eMaxLust() * 0.75) && !hasStatusEffect(StatusEffects.ChargeWeapon)) ChargeWeaponSpell();
						else if ((this.lust < eMaxLust() * 0.75) && (fatigue < (eMaxFatigue() - spellCostWhitefire()))) WhiteFireSpell();
						else if ((this.lust < eMaxLust() * 0.75) && rand(2) == 0 && (fatigue < (eMaxFatigue() - spellCostBlind())) && !player.hasStatusEffect(StatusEffects.Blind)) BlindSpell();
						else eAttack();
					}
				}
				combatRoundOver();
			}
			else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 4) {
				var choice2:Number = rand(2);
				if (choice2 == 0) eAttack();
				if (choice2 == 1) {
					if (this.lust > 50) {
						if (HPRatio() < .75 && (fatigue < (eMaxFatigue() - spellCostHeal()))) HealSpell();
						else if ((this.lust < eMaxLust() * 0.75) && rand(2) == 0 && (fatigue < (eMaxFatigue() - spellCostBlind())) && !player.hasStatusEffect(StatusEffects.Blind)) BlindSpell();
						else if (rand(2) == 0 && (fatigue < (eMaxFatigue() - spellCostArouse()))) ArouseSpell();
						else if ((this.lust < eMaxLust() * 0.75) && (fatigue < (eMaxFatigue() - spellCostWhitefire()))) WhiteFireSpell();
						else eAttack();
					}
					else {
						if ((this.lust < eMaxLust() * 0.75) && (fatigue < (eMaxFatigue() - spellCostWhitefire()))) WhiteFireSpell();
						else if ((this.lust < eMaxLust() * 0.75) && rand(2) == 0 && (fatigue < (eMaxFatigue() - spellCostBlind())) && !player.hasStatusEffect(StatusEffects.Blind)) BlindSpell();
						else eAttack();
					}
				}
				combatRoundOver();
			}
			else if (flags[kFLAGS.EVANGELINE_LVL_UP] == 2 || flags[kFLAGS.EVANGELINE_LVL_UP] == 3) {
				var choice1:Number = rand(2);
				if (choice1 == 0) eAttack();
				if (choice1 == 1) {
					if (this.lust > 50) {
						if (HPRatio() < .75 && (fatigue < (eMaxFatigue() - spellCostHeal()))) HealSpell();
						else if (rand(3) == 0 && (fatigue < (eMaxFatigue() - spellCostArouse()))) ArouseSpell();
						else if ((this.lust < eMaxLust() * 0.75) && (fatigue < (eMaxFatigue() - spellCostWhitefire()))) WhiteFireSpell();
						else eAttack();
					}
					else {
						if ((this.lust < eMaxLust() * 0.75) && (fatigue < (eMaxFatigue() - spellCostWhitefire()))) WhiteFireSpell();
						else eAttack();
					}
				}
				combatRoundOver();
			}
			else {
				eAttack();
				combatRoundOver();
			}
		}
		
		public function Evangeline1() 
		{
			this.a = "";
			this.short = "Evangeline";
			this.imageName = "evangeline";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 0 || flags[kFLAGS.EVANGELINE_LVL_UP] == 1) {
				this.long = "You are currently fighting Evangeline, which is a seven and a half feet tall human. She's wearing simple peasant's rags and using bare fists to attack.";
				initStrTouSpeInte(10, 10, 5, 40);
				this.weaponName = "fists";
				this.weaponVerb="punches";
				this.weaponAttack = 1 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorName = "rags";
				this.armorDef = 1 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 30;
				this.bonusLust = 5;
				this.additionalXP += 5;
				this.str += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.newgamebonusHP = 150;
				this.level = 2;
				this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 2) {
				this.long = "You are currently fighting Evangeline, which is a seven and a half feet tall human. She's wearing simple peasant's rags and using bare fists to attack.";
				initStrTouSpeInte(18, 18, 10, 61);
				this.weaponName = "fists";
				this.weaponVerb="punches";
				this.weaponAttack = 1 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorName = "rags";
				this.armorDef = 1 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 60;
				this.bonusLust = 10;
				this.additionalXP += 10;
				this.level = 4;
				this.str += 3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.newgamebonusHP = 220;
				this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 3) {
				this.long = "You are currently fighting Evangeline, which is a seven and a half feet tall human. She's wearing simple peasant's rags and using bare fists to attack.";
				initStrTouSpeInte(28, 28, 15, 100);
				this.weaponName = "fists";
				this.weaponVerb="punches";
				this.weaponAttack = 1 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorName = "rags";
				this.armorDef = 1 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 90;
				this.bonusLust = 15;
				this.additionalXP += 15;
				this.level = 6;
				this.str += 5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 20 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.newgamebonusHP = 350;
				this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 4) {
				this.long = "You are currently fighting Evangeline, which is a seven and a half feet tall human. She's wearing simple peasant's rags and using spiked gauntlet to attack.";
				initStrTouSpeInte(32, 32, 25, 100);
				this.weaponName = "spiked gauntlet";
				this.weaponVerb="spiked punch";
				this.weaponAttack = 6 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorName = "rags";
				this.armorDef = 1 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 120;
				this.bonusLust = 20;
				this.additionalXP += 20;
				this.level = 8;
				this.str += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 20 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.newgamebonusHP = 390;
				this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
				this.createPerk(PerkLib.Spellpower, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 5) {
				this.long = "You are currently fighting Evangeline, which is a seven and a half feet tall human. She's wearing practically indecent steel armor and using spiked gauntlet to attack.";
				initStrTouSpeInte(32, 32, 35, 100);
				this.weaponName = "spiked gauntlet";
				this.weaponVerb="spiked punch";
				this.weaponAttack = 6 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorName = "practically indecent steel armor";
				this.armorDef = 11 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 150;
				this.bonusLust = 25;
				this.additionalXP += 25;
				this.level = 10;
				this.str += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 7 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 20 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.newgamebonusHP = 820;
				this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
				this.createPerk(PerkLib.Spellpower, 0, 0, 0, 0);
				this.createPerk(PerkLib.Mage, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 6) {
				this.long = "You are currently fighting Evangeline, which is a seven and a half feet tall human. She's wearing practically indecent steel armor and using inscribed spellblade to attack.";
				initStrTouSpeInte(32, 32, 45, 100);
				this.weaponName = "inscribed spellblade";
				this.weaponVerb="slash";
				this.weaponAttack = 9 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.armorName = "practically indecent steel armor";
				this.armorDef = 11 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusHP = 180;
				this.bonusLust = 30;
				this.additionalXP += 30;
				this.level = 12;
				this.str += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.tou += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.spe += 9 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				this.inte += 20 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
				this.newgamebonusHP = 860;
				this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
				this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
				this.createPerk(PerkLib.Spellpower, 0, 0, 0, 0);
				this.createPerk(PerkLib.Mage, 0, 0, 0, 0);
				this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
				this.createPerk(PerkLib.WizardsFocus, 0, 0, 0, 0);
			}
			createBreastRow(Appearance.breastCupInverse("A"));
			this.createVagina(false, VAGINA_WETNESS_DRY, VAGINA_LOOSENESS_TIGHT);
			this.ass.analLooseness = ANAL_LOOSENESS_VIRGIN;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.tallness = 90;
			this.hipRating = HIP_RATING_BOYISH;
			this.buttRating = BUTT_RATING_BUTTLESS;
			this.skin.setBaseOnly({color:"olive"});
			this.hairColor = "red";
			this.hairLength = 6;
			initLibSensCor(10, 10, 100);
			this.lustVuln = .85;
			this.lust = 10;
			this.fatigue = 0;
			this.gems = 0;
			this.drop = NO_DROP;
			this.lib += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.createPerk(PerkLib.EzekielBlessing, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}