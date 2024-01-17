/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Items.Weapons.Tidarion;
import classes.Monster;
import classes.PerkLib;
import classes.Races;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Scenes.NPCs.Jojo;
import classes.Scenes.NPCs.JojoScene;
import classes.StatusEffects;

import coc.view.ButtonData;
import coc.view.ButtonDataList;
import classes.Items.JewelryLib;

public class CombatSoulskills extends BaseCombatContent {
	private var multiTrustDNLag:Number = 0;
	public function CombatSoulskills() {
	}

	internal function soulskillCooldownImpl(duration:int = 2, physical:Boolean = true):Number {
		if (player.weapon == weapons.B_FLYWHISK) duration--;
		if (duration < 0) duration = 0;
		return duration;
	}

	internal function soulskillTier2CooldownImpl(duration:int = 4, physical:Boolean = true):Number {
		if (player.weapon == weapons.B_FLYWHISK) duration--;
		if (duration < 0) duration = 0;
		return duration;
	}

	internal function soulskillTier3CooldownImpl(duration:int = 10, physical:Boolean = true):Number {
		if (player.weapon == weapons.B_FLYWHISK) duration--;
		if (duration < 0) duration = 0;
		return duration;
	}

	private function sfT():Number {
		var sfT:Number = 0.8;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 3) sfT -= 0.1;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4) sfT -= 0.1;
		return sfT;
	}

	internal function soulskillModImpl():Number {
		var modss:Number = 1;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SOUL_POWER) modss += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId2 == JewelryLib.MODIFIER_SOUL_POWER) modss += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId3 == JewelryLib.MODIFIER_SOUL_POWER) modss += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId4 == JewelryLib.MODIFIER_SOUL_POWER) modss += (player.jewelryEffectMagnitude / 100);
		if (player.hasPerk(PerkLib.SoulApprentice)) modss += .1;
		if (player.hasPerk(PerkLib.SoulPersonage)) modss += .1;
		if (player.hasPerk(PerkLib.SoulWarrior)) modss += .1;
		if (player.hasPerk(PerkLib.SoulSprite)) modss += .2;
		if (player.hasPerk(PerkLib.SoulScholar)) modss += .2;
		if (player.hasPerk(PerkLib.SoulGrandmaster)) modss += .2;
		if (player.hasPerk(PerkLib.SoulElder)) modss += .4;
		if (player.hasPerk(PerkLib.SoulExalt)) modss += .4;
		if (player.hasPerk(PerkLib.SoulOverlord)) modss += .4;
		if (player.hasPerk(PerkLib.SoulTyrant)) modss += .6;
		if (player.hasPerk(PerkLib.SoulKing)) modss += .6;
		if (player.hasPerk(PerkLib.SoulEmperor)) modss += .6;
		if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) modss += .25;
		if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) modss += .5;
		if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) modss += .75;
		if (player.hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) modss += 1;
		if (player.hasPerk(PerkLib.EclassHeavenTribulationSurvivor)) modss += 1.25;
		if (player.hasPerk(PerkLib.SeersInsight)) modss += player.perkv1(PerkLib.SeersInsight);
		if (player.hasPerk(PerkLib.AscensionSpiritualEnlightenment)) modss *= 1 + (player.perkv1(PerkLib.AscensionSpiritualEnlightenment) * 0.1);
		if (player.hasPerk(PerkLib.InariBlessedKimono)) modss += ((100 - player.cor) * .01);
		if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) modss += (player.cor * .01);
		if (player.hasPerk(PerkLib.MummyLord) && player.perkv1(PerkLib.MummyLord) > 0) modss += (player.perkv1(PerkLib.MummyLord) * 0.05);
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 1) modss += .2;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 2) modss += .1;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 3) modss += .1;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4) modss += .1;
		if (player.necklaceName == "Yin Yang Amulet") modss += .15;
		if (player.armorName == "Traditional clothes") modss += .4;
		if (player.headJewelry == headjewelries.DEATHPR) modss += .2;
		if (player.hasPerk(PerkLib.ElementalBody)) {
			if (player.perkv1(PerkLib.ElementalBody) == 1 || player.perkv1(PerkLib.ElementalBody) == 2 || player.perkv1(PerkLib.ElementalBody) == 3) {
				if (player.perkv2(PerkLib.ElementalBody) == 1) modss += .05;
				if (player.perkv2(PerkLib.ElementalBody) == 2) modss += .1;
				if (player.perkv2(PerkLib.ElementalBody) == 3) modss += .15;
				if (player.perkv2(PerkLib.ElementalBody) == 4) modss += .2;
			}
			else {
				if (player.perkv2(PerkLib.ElementalBody) == 1) modss += .1;
				if (player.perkv2(PerkLib.ElementalBody) == 2) modss += .2;
				if (player.perkv2(PerkLib.ElementalBody) == 3) modss += .3;
				if (player.perkv2(PerkLib.ElementalBody) == 4) modss += .4;
			}
		}
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 2 && player.soulforce >= Math.round(player.maxSoulforce() * sfT())) modss *= 2;
		modss = Math.round(modss * 100) / 100;
		return modss;
	}

	internal function soulskillPhysicalModImpl():Number {
		var modssp:Number = player.psoulskillPowerStat.value;
		var modsspb:Number = 1;
		if (soulskillMod() > 1) modsspb += soulskillMod() - 1;
		if (player.hasPerk(PerkLib.FleshBodyApprenticeStage)) {
			if (player.hasPerk(PerkLib.SoulApprentice)) modssp += .5;
			if (player.hasPerk(PerkLib.SoulPersonage)) modssp += .5;
			if (player.hasPerk(PerkLib.SoulWarrior)) modssp += .5;
		}
		if (player.hasPerk(PerkLib.FleshBodyWarriorStage)) {
			if (player.hasPerk(PerkLib.SoulSprite)) modssp += 1;
			if (player.hasPerk(PerkLib.SoulScholar)) modssp += 1;
			if (player.hasPerk(PerkLib.SoulGrandmaster)) modssp += 1;
		}
		if (player.hasPerk(PerkLib.FleshBodyElderStage)) {
			if (player.hasPerk(PerkLib.SoulElder)) modssp += 1.5;
			if (player.hasPerk(PerkLib.SoulExalt)) modssp += 1.5;
			if (player.hasPerk(PerkLib.SoulOverlord)) modssp += 1.5;
		}
		if (player.hasPerk(PerkLib.FleshBodyOverlordStage)) {
			if (player.hasPerk(PerkLib.SoulTyrant)) modssp += 2;
			if (player.hasPerk(PerkLib.SoulKing)) modssp += 2;
			if (player.hasPerk(PerkLib.SoulEmperor)) modssp += 2;
			//if (player.hasPerk(PerkLib.SoulAncestor)) modssm += 2;
		}
		if (modsspb > 1) modssp *= modsspb;
		modssp = Math.round(modssp * 100) / 100;
		return modssp;
	}

	internal function soulskillMagicalModImpl():Number {
		var modssm:Number = player.msoulskillPowerStat.value;
		var modssmb:Number = 1;
		if (soulskillMod() > 1) modssmb += soulskillMod() - 1;
		if (player.hasPerk(PerkLib.DaoistApprenticeStage)) {
			if (player.hasPerk(PerkLib.SoulApprentice)) modssm += .5;
			if (player.hasPerk(PerkLib.SoulPersonage)) modssm += .5;
			if (player.hasPerk(PerkLib.SoulWarrior)) modssm += .5;
		}
		if (player.hasPerk(PerkLib.DaoistWarriorStage)) {
			if (player.hasPerk(PerkLib.SoulSprite)) modssm += 1;
			if (player.hasPerk(PerkLib.SoulScholar)) modssm += 1;
			if (player.hasPerk(PerkLib.SoulGrandmaster)) modssm += 1;
		}
		if (player.hasPerk(PerkLib.DaoistElderStage)) {
			if (player.hasPerk(PerkLib.SoulElder)) modssm += 1.5;
			if (player.hasPerk(PerkLib.SoulExalt)) modssm += 1.5;
			if (player.hasPerk(PerkLib.SoulOverlord)) modssm += 1.5;
		}
		if (player.hasPerk(PerkLib.DaoistOverlordStage)) {
			if (player.hasPerk(PerkLib.SoulTyrant)) modssm += 2;
			if (player.hasPerk(PerkLib.SoulKing)) modssm += 2;
			if (player.hasPerk(PerkLib.SoulEmperor)) modssm += 2;
			//if (player.hasPerk(PerkLib.SoulAncestor)) modssm += 2;
		}
		if (player.perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 2) {
			var wfb:Number = 0.5;
			if (player.perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 3) wfb += 0.25;
			if (player.perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 4) wfb += 0.25;
			if (player.tailCount >= 3) wfb *= 2;
			modssm += wfb;
		}
		if (player.shieldName == "spirit focus") modssm += .25;
		if (player.armor == armors.DEATHPO) modssm += .5;
		if (player.armor == armors.DEATHPGA) modssm += 2;
		if (modssmb > 1) modssm *= modssmb;
		modssm = Math.round(modssm * 100) / 100;
		return modssm;
	}

	internal function soulskillcostmultiImpl():Number {
		var multiss:Number = 1;
		if (player.level >= 27 && player.wis >= 100) multiss += 1;//początek używania Dao of Elements
		if (player.level >= 54 && player.wis >= 200) multiss += 1;//początek zdolności latania
		if (player.level >= 78 && player.wis >= 300) multiss += 1;//początek tworzenia klonów
		//if (player.level >= 126 && player.wis >= 400) multiss += 1;//początek czegoś tam
		multiss = Math.round(multiss * 100) / 100;
		return multiss;
	}

	internal function soulskillCostImpl():Number {
		var modssc:Number = player.soulskillcostStat.value;
		if (soulskillMod() > 1) modssc += (soulskillMod() - 1) * 0.1;
		if (player.hasPerk(PerkLib.DaoistApprenticeStage)) modssc -= .1;
		if (player.hasPerk(PerkLib.DaoistWarriorStage)) modssc -= .1;
		if (player.hasPerk(PerkLib.DaoistElderStage)) modssc -= .1;
		if (player.hasPerk(PerkLib.DaoistOverlordStage)) modssc -= .1;
		if (player.jewelryName == "fox hairpin") modssc -= .2;
		if (player.hasPerk(PerkLib.AscensionSpiritualEnlightenment)) modssc -= (player.perkv1(PerkLib.AscensionSpiritualEnlightenment) * 0.02);
		if (player.perkv1(IMutationsLib.WhiteFacedOneBirthrightIM) >= 4) modssc -= .1;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 2 && player.soulforce >= Math.round(player.maxSoulforce() * sfT())) modssc *= 1.5;
		if (modssc < 0.1) modssc = 0.1;
		modssc = Math.round(modssc * 100) / 100;
		return modssc;
	}
	/*
	 * Code needed for later so would stay here for a while more
	 * 
	public function spellMight(silent:Boolean = false):void {
		var doEffect:Function = function():* {
			var MightBoostCap:Number = 1.5;
			MightBoostCap *= player.intStat.core.max;
			MightBoostCap = Math.round(MightBoostCap);
			var MightBoost:Number = player.intStat.core.value;
			//MightBoost += Math.round(player.intStat.max * 0.1); - może tylko jak bedzie mieć perk z prestige job: magus / warock / inny związany z spells
			if (MightBoost < 10) MightBoost = 10;
			if (player.hasPerk(PerkLib.JobEnchanter)) MightBoost *= 1.2;
			MightBoost *= spellModBlack();
			//MightBoost = FnHelpers.FN.logScale(MightBoost,MightABC,10);
			MightBoost = Math.round(MightBoost);
			if (MightBoost > MightBoostCap) MightBoost = MightBoostCap;
			var MightDuration:Number = 5;
			if (player.hasPerk(PerkLib.LongerLastingBuffsI)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsII)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsIII)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsIV)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsV)) MightDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsVI)) MightDuration += 1;
			if (player.hasPerk(PerkLib.EverLastingBuffs)) MightDuration += 5;
			if (player.hasPerk(PerkLib.EternalyLastingBuffs)) MightDuration += 5;
			tempTou = MightBoost;
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) tempInt = Math.round(MightBoost * 1.25);
			else tempStr = MightBoost;
			var oldHPratio:Number = player.hp100/100;
			var buffValues:Object = {"tou.mult":tempTou/100};
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) {
				buffValues["int.mult"] = Math.min( tempInt/100, player.intStat.mult.value/2);
			} else {
				buffValues["str.mult"] = Math.min( tempStr/100, player.strStat.mult.value/2);
			}
			player.buff("Might").setStats(buffValues).combatTemporary(MightDuration);
			player.HP = oldHPratio*player.maxHP();
			statScreenRefresh();
		};
		if (silent)	{ // for Battlemage
			doEffect.call();
			return;
		}
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < (50 * spellMightCostMultiplier())) player.HP -= (50 * spellMightCostMultiplier());
		else useMana((50 * spellMightCostMultiplier()),6);
		var tempStr:Number = 0;
		var tempTou:Number = 0;
		var tempInt:Number = 0;
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		outputText("You flush, drawing on your body's desires to empower your muscles and toughen you up.\n\n");
		//30% backfire!
		var backfire:int = 30;
		if (player.hasStatusEffect(StatusEffects.AlvinaTraining)) backfire -= 10;
		if (player.hasPerk(PerkLib.FocusedMind)) backfire -= 10;
		backfire -= (player.inte * 0.15);
		if (backfire < 5 && player.hasPerk(PerkLib.FocusedMind)) backfire = 5;
		else if (backfire < 15) backfire = 15;
		if(rand(100) < backfire) {
			outputText("An errant sexual thought crosses your mind, and you lose control of the spell!  Your ");
			if(player.gender == 0) outputText(assholeDescript() + " tingles with a desire to be filled as your libido spins out of control.");
			if(player.gender == 1) {
				if(player.cockTotal() == 1) outputText(player.cockDescript(0) + " twitches obscenely and drips with pre-cum as your libido spins out of control.");
				else outputText(player.multiCockDescriptLight() + " twitch obscenely and drip with pre-cum as your libido spins out of control.");
			}
			if(player.gender == 2) outputText(vaginaDescript(0) + " becomes puffy, hot, and ready to be touched as the magic diverts into it.");
			if(player.gender == 3) outputText(vaginaDescript(0) + " and [cocks] overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.");
			dynStats("lib", .25, "lus", 15);
		}
		else {
			outputText("The rush of success and power flows through your body.  You feel like you can do anything!");
			doEffect.call();
		}
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxOverLust()) doNext(endLustLoss);
		else enemyAI();
	}*/
	/*
	 //Mantis Omni Slash (AoE attack) - przerobić to na soulskilla zużywającego jak inne soulforce z rosnącym kosztem im wyższy lvl postaci ^^ owinno wciąż jakoś być powiązane z posiadaniem mantis arms czy też ulepszonych mantis arms (czyt. versji 2.0 tych ramion z TF bdącego soul evolution of Mantis) ^^
	 public function mantisOmniSlash():void {
	 flags[kFLAGS.LAST_ATTACK_TYPE] = 4;
	 clearOutput();
	 if (monster.plural) {
	 if (player.fatigue + physicalCost(50) > player.maxFatigue()) {
	 outputText("You are too tired to slash " + monster.a + " [monster name].");
	 addButton(0, "Next", combatMenu, false);
	 return;
	 }
	 }
	 else {
	 if (player.fatigue + physicalCost(20) > player.maxFatigue()) {
	 outputText("You are too tired to slash " + monster.a + " [monster name].");
	 addButton(0, "Next", combatMenu, false);
	 return;
	 }
	 }
	 if (monster.plural) {
	 fatigue(60, USEFATG_PHYSICAL);
	 }
	 else fatigue(24, USEFATG_PHYSICAL);
	if (combat.checkConcentration()) return; //Amily concentration
	 outputText("You ready your wrist-mounted scythes and prepare to sweep them towards [themonster].\n\n");
	 if ((player.playerIsBlinded() && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe-player.spe) / 4) + 80)) > 80)) {
	 if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attacks!\n\n");
	 if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attacks with superior quickness!\n\n");
	 if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attacks.\n\n");
	 enemyAI();
	 return;
	 if (monster.plural) {
	 if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1) {
	 if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 2 && player.hasPerk(PerkLib.TrachealSystemEvolved)) flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 10;
	 else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 6;
	 }
	 else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 3;
	 }
	 else flags[kFLAGS.MULTIPLE_ATTACK_STYLE] = 1;
	 mantisMultipleAttacks();
	 }
	 public function mantisMultipleAttacks():void {
	 var damage:Number = player.spe;
	 damage += speedscalingbonus() * 0.5;
	 if (damage < 10) damage = 10;
	 //adjusting to be used 60/100% of base speed while attacking depending on insect-related perks possesed
	 if (!player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1) damage *= 0.6;
	 //bonuses if fighting multiple enemies
	 if (monster.plural) {
	 if (!player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1 && !player.hasPerk(PerkLib.TrachealSystemEvolved)) damage *= 1.1;
	 if (player.perkv1(IMutationsLib.MantislikeAgilityIM) >= 1 && player.hasPerk(PerkLib.TrachealSystemEvolved)) damage *= 1.5;
	 }
	 //weapon bonus
	 if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
	 else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
	 else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
	 else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
	 else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
	 //other bonuses
	 if (player.hasPerk(PerkLib.ThunderousStrikes) && player.str >= 80) damage *= 1.2;
	 if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
	 if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
	 if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
	 if (player.armor == armors.SPKIMO) damage *= 1.2;
	 if (player.hasPerk(PerkLib.OniTyrantKimono)) damage *= 2;
		if (player.hasPerk(PerkLib.OniEnlightenedKimono)) damage *= 1.5;
		if (player.necklace == necklaces.OBNECK) damage *= 1.2;
	 //Determine if critical hit!
	 var crit:Boolean = false;
	 var critChance:int = 5;
	 if (player.hasPerk(PerkLib.Tactician) && player.inte >= 50) {
	 if (player.inte <= 100) critChance += (player.inte - 50) / 50;
	 if (player.inte > 100) critChance += 1;
	 }
	 if (player.hasPerk(PerkLib.ElvenSense) && && player.inte >= 50) critChance += 5;
	 if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
	 if (rand(100) < critChance) {
	 crit = true;
	 damage *= 1.75;
	 }
	 doDamage(damage);
	 outputText("Your scythes swiftly sweeps against [themonster], dealing <b><font color=\"#800000\">" + damage + "</font></b> damage!");
	 if (crit == true) outputText(" <b>*Critical Hit!*</b>");
	 outputText("\n");
	 checkAchievementDamage(damage);
	 combat.heroBaneProc(damage);
	 combat.WrathGenerationPerHit2(5);
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 0) {
	 outputText("\n");
	 enemyAI();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 1) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 2) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 3) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 4) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 5) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 6) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 7) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 8) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 if (flags[kFLAGS.MULTIPLE_ATTACK_STYLE] == 9) {
	 flags[kFLAGS.MULTIPLE_ATTACK_STYLE] -= 1;
	 mantisMultipleAttacks();
	 }
	 }
	 public function tripleThrust():void {
	 flags[kFLAGS.LAST_ATTACK_TYPE] = 4;//fizyczny atak
	 clearOutput();
	 if (player.soulforce < 10 * soulskillCost() * soulskillcostmulti()) {
	 outputText("<b>Your current soulforce is too low.</b>");
	 doNext(combatMenu);
	 return;
	 }
	 outputText("You ready your [weapon] and prepare to thrust it towards [themonster].  ");
	 if ((player.playerIsBlinded() && rand(2) == 0) || (monster.spe - player.spe > 0 && int(Math.random() * (((monster.spe-player.spe) / 4) + 80)) > 80)) {
	 if (monster.spe - player.spe < 8) outputText(monster.capitalA + monster.short + " narrowly avoids your attack!");
	 if (monster.spe - player.spe >= 8 && monster.spe-player.spe < 20) outputText(monster.capitalA + monster.short + " dodges your attack with superior quickness!");
	 if (monster.spe - player.spe >= 20) outputText(monster.capitalA + monster.short + " deftly avoids your slow attack.");
	 enemyAI();
	 return;
	 }
	 var soulforcecost:Number = 10 * soulskillCost() * soulskillcostmulti();
	 soulforcecost = Math.round(soulforcecost);
	 player.soulforce -= soulforcecost;
	 var damage:Number = 0;
	 damage += combat.meleeDamageNoLagSingle();
	 damage *= 1.75;
	 //other bonuses
	 if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) damage *= combat.historyFighterBonus();
	 if (player.hasPerk(PerkLib.DemonSlayer) && monster.hasPerk(PerkLib.EnemyTrueDemon)) damage *= 1 + player.perkv1(PerkLib.DemonSlayer);
	 if (player.hasPerk(PerkLib.FeralHunter) && monster.hasPerk(PerkLib.EnemyFeralType)) damage *= 1 + player.perkv1(PerkLib.FeralHunter);
	 if (player.hasPerk(PerkLib.JobWarrior)) damage *= 1.05;
	 if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
	if (player.armor == armors.SPKIMO) damage *= 1.2;
	if (player.hasPerk(PerkLib.OniTyrantKimono)) damage *= 2;
	if (player.hasPerk(PerkLib.OniEnlightenedKimono)) damage *= 1.5;
	if (player.necklace == necklaces.OBNECK) damage *= 1.2;
	 //triple strike bonus
	 damage *= 3;
	 //soulskill mod effect
	 damage *= soulskillPhysicalMod();
	 doDamage(damage);
	 outputText("Your [weapon] hits thrice against [themonster], dealing <b><font color=\"#800000\">" + damage + "</font></b> damage! ");
	 checkAchievementDamage(damage);
	 combat.WrathGenerationPerHit2(5);
	 combat.heroBaneProc(damage);
	 outputText("\n\n");
	 if (monster.HP <= monster.minHP()) doNext(endHpVictory);
	 else enemyAI();
	 }*/
}
}