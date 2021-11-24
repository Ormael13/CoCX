/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Items.HeadJewelryLib;
import classes.Items.JewelryLib;
import classes.Items.NecklaceLib;
import classes.Items.ShieldLib;
import classes.PerkLib;
import classes.MutationsLib;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.Areas.GlacialRift.FrostGiant;
import classes.Scenes.Areas.Tundra.YoungFrostGiant;
import classes.Scenes.Combat.SpellsWhite.PyreBurstSpell;
import classes.Scenes.Combat.SpellsWhite.WhitefireSpell;
import classes.Scenes.Dungeons.D3.Doppleganger;
import classes.Scenes.Dungeons.D3.JeanClaude;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Scenes.NPCs.Diva;
import classes.Scenes.NPCs.Holli;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.Codex;
import classes.Scenes.SceneLib;
import classes.Stats.Buff;
import classes.EngineCore;
import classes.StatusEffects;
import classes.VaginaClass;

import coc.view.ButtonData;
import coc.view.ButtonDataList;

public class CombatMagic extends BaseCombatContent {
	public var codex:Codex = new Codex();
	public function CombatMagic() {}

	internal function applyAutocast():void {
		outputText("\n\n");
		if (player.hasPerk(PerkLib.Spellsword) && CombatAbilities.ChargeWeapon.isKnownAndUsable && flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] == 0) {
			CombatAbilities.ChargeWeapon.autocast();
		}
		if (player.hasPerk(PerkLib.Spellarmor) && CombatAbilities.ChargeArmor.isKnownAndUsable && flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] == 0) {
			CombatAbilities.ChargeArmor.autocast();
		}
		if (player.hasPerk(PerkLib.Battlemage) && CombatAbilities.Might.isKnownAndUsable && flags[kFLAGS.AUTO_CAST_MIGHT] == 0) {
			CombatAbilities.Might.autocast();
		}
		if (player.hasPerk(PerkLib.Battleflash) && CombatAbilities.Blink.isKnownAndUsable && flags[kFLAGS.AUTO_CAST_BLINK] == 0) {
			CombatAbilities.Blink.autocast();
		}
		if (player.hasPerk(PerkLib.Battleshield) && (player.lust >= 50 || player.lust < (player.maxLust() - 49)) && flags[kFLAGS.AUTO_CAST_MANA_SHIELD] == 0) {
			spellManaShield(true);
			flags[kFLAGS.SPELLS_CAST]++;
			if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell, 0, 0, 0, 0);
			spellPerkUnlock();
			outputText("<b>Mana Shield was autocasted successfully.</b>\n\n");
		}
	}

	internal function cleanupAfterCombatImpl():void {
		if (player.hasStatusEffect(StatusEffects.CounterRagingInferno)) player.removeStatusEffect(StatusEffects.CounterRagingInferno);
		if (player.hasStatusEffect(StatusEffects.CounterGlacialStorm)) player.removeStatusEffect(StatusEffects.CounterGlacialStorm);
		if (player.hasStatusEffect(StatusEffects.CounterHighVoltage)) player.removeStatusEffect(StatusEffects.CounterHighVoltage);
		if (player.hasStatusEffect(StatusEffects.CounterEclipsingShadow)) player.removeStatusEffect(StatusEffects.CounterEclipsingShadow);
	}

	internal function spellCostImpl(mod:Number):Number {
		//Addiditive mods
		var costPercent:Number = 100;
		if (player.hasPerk(PerkLib.SeersInsight)) costPercent -= (100 * player.perkv1(PerkLib.SeersInsight));
		if (player.hasPerk(PerkLib.SpellcastingAffinity)) costPercent -= player.perkv1(PerkLib.SpellcastingAffinity);
		if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) costPercent -= player.perkv1(PerkLib.WizardsEnduranceAndSluttySeduction);
		if (player.hasPerk(PerkLib.WizardsAndDaoistsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsAndDaoistsEndurance);
		if (player.hasPerk(PerkLib.WizardsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsEndurance);
		if (player.headjewelryName == "fox hairpin") costPercent -= 20;
		if (player.weapon == weapons.ASCENSU) costPercent -= 15;
		if (player.weapon == weapons.N_STAFF) costPercent += 200;
		if (spellModImpl() > 1) costPercent += Math.round(spellModImpl() - 1) * 10;
		if (player.level >= 24 && player.inte >= 60) costPercent += 50;
		if (player.level >= 42 && player.inte >= 120) costPercent += 50;
		if (player.level >= 60 && player.inte >= 180) costPercent += 50;
		if (player.level >= 78 && player.inte >= 240) costPercent += 50;
		//Limiting it and multiplicative mods
		if (player.hasPerk(PerkLib.BloodMage) && costPercent < 50) costPercent = 50;
		mod *= costPercent / 100;
		if (player.hasPerk(PerkLib.BloodMage) && mod < 5) mod = 5;
		else if (mod < 2) mod = 2;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}
	
	internal function spellCostBloodImpl(mod:Number):Number {
		//Addiditive mods
		var costPercent:Number = 100;
		if (player.hasPerk(PerkLib.SeersInsight)) costPercent -= (100 * player.perkv1(PerkLib.SeersInsight));
		if (player.hasPerk(PerkLib.SpellcastingAffinity)) costPercent -= player.perkv1(PerkLib.SpellcastingAffinity);
		if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) costPercent -= player.perkv1(PerkLib.WizardsEnduranceAndSluttySeduction);
		if (player.hasPerk(PerkLib.WizardsAndDaoistsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsAndDaoistsEndurance);
		if (player.hasPerk(PerkLib.WizardsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsEndurance);
		if (player.hasPerk(PerkLib.HiddenJobBloodDemon)) costPercent -= 5;
		if (player.hasPerk(PerkLib.WayOfTheBlood)) costPercent -= 5;
		if (player.hasPerk(PerkLib.YourPainMyPower)) costPercent -= 5;
		if (player.hasPerk(PerkLib.MyBloodForBloodPuppies)) costPercent -= 5;
		if (player.hasPerk(PerkLib.BloodDemonToughness)) costPercent -= 5;
		//
		if (player.hasPerk(PerkLib.BloodDemonWisdom)) costPercent -= 5;
		//
		if (player.hasPerk(PerkLib.BloodDemonIntelligence)) costPercent -= 5;
		if (player.headjewelryName == "fox hairpin") costPercent -= 20;
		if (player.weapon == weapons.ASCENSU) costPercent -= 15;
		if (player.weapon == weapons.N_STAFF) costPercent += 200;
		if (spellModImpl() > 1) costPercent += Math.round(spellModImpl() - 1) * 10;
		if (player.level >= 24 && player.inte >= 60) costPercent += 50;
		if (player.level >= 42 && player.inte >= 120) costPercent += 50;
		if (player.level >= 60 && player.inte >= 180) costPercent += 50;
		if (player.level >= 78 && player.inte >= 240) costPercent += 50;
		//Limiting it and multiplicative mods
		if (costPercent < 5) costPercent = 5;
		mod *= costPercent / 100;
		if (mod < 2) mod = 2;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}

	internal function healCostImpl(mod:Number):Number {
		var costPercent:Number = 100;
		if (player.hasPerk(PerkLib.SeersInsight)) costPercent -= (100 * player.perkv1(PerkLib.SeersInsight));
		if (player.hasPerk(PerkLib.SpellcastingAffinity)) costPercent -= player.perkv1(PerkLib.SpellcastingAffinity);
		if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) costPercent -= player.perkv1(PerkLib.WizardsEnduranceAndSluttySeduction);
		if (player.hasPerk(PerkLib.WizardsAndDaoistsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsAndDaoistsEndurance);
		if (player.hasPerk(PerkLib.WizardsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsEndurance);
		if (player.hasPerk(PerkLib.WisenedHealer)) {
			costPercent += 100;
			if (player.level >= 24 && player.wis >= 60) costPercent += 25;
			if (player.level >= 42 && player.wis >= 120) costPercent += 25;
			if (player.level >= 60 && player.wis >= 180) costPercent += 25;
			if (player.level >= 78 && player.wis >= 240) costPercent += 25;
		}
		if (player.level >= 24 && player.inte >= 60) costPercent += 25;
		if (player.level >= 42 && player.inte >= 120) costPercent += 25;
		if (player.level >= 60 && player.inte >= 180) costPercent += 25;
		if (player.level >= 78 && player.inte >= 240) costPercent += 25;
		if (player.hasPerk(PerkLib.NaturalHealingMinor)) costPercent -= 10;
		if (player.hasPerk(PerkLib.NaturalHealingMajor)) costPercent -= 15;
		if (player.hasPerk(PerkLib.NaturalHealingEpic)) costPercent -= 20;
		if (player.hasPerk(PerkLib.NaturalHealingLegendary)) costPercent -= 25;
		if (player.headjewelryName == "fox hairpin") costPercent -= 20;
		if (player.weapon == weapons.ASCENSU) costPercent -= 15;
		if (player.weapon == weapons.N_STAFF) costPercent += 200;
		if (healModImpl() > 1) costPercent += Math.round(healModImpl() - 1) * 10;
		mod *= costPercent / 100;
		if (mod < 5) mod = 5;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}

	internal function spellCostWhiteImpl(mod:Number):Number {
		//Addiditive mods
		var costPercent:Number = 100;
		if (player.hasPerk(PerkLib.Ambition)) costPercent -= (100 * player.perkv2(PerkLib.Ambition));
		if (player.hasPerk(PerkLib.SeersInsight)) costPercent -= (100 * player.perkv1(PerkLib.SeersInsight));
		if (player.hasPerk(PerkLib.SpellcastingAffinity)) costPercent -= player.perkv1(PerkLib.SpellcastingAffinity);
		if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) costPercent -= player.perkv1(PerkLib.WizardsEnduranceAndSluttySeduction);
		if (player.hasPerk(PerkLib.WizardsAndDaoistsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsAndDaoistsEndurance);
		if (player.hasPerk(PerkLib.WizardsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsEndurance);
		if (player.headjewelryName == "fox hairpin") costPercent -= 20;
		if (player.weapon == weapons.PURITAS || player.weapon == weapons.ASCENSU) costPercent -= 15;
		if (player.weapon == weapons.N_STAFF) costPercent += 200;
		if (spellModWhiteImpl() > 1) costPercent += Math.round(spellModWhiteImpl() - 1) * 10;
		if (player.level >= 24 && player.inte >= 60) costPercent += 50;
		if (player.level >= 42 && player.inte >= 120) costPercent += 50;
		if (player.level >= 60 && player.inte >= 180) costPercent += 50;
		if (player.level >= 78 && player.inte >= 240) costPercent += 50;
		//Limiting it and multiplicative mods
		if (player.hasPerk(PerkLib.BloodMage) && costPercent < 50) costPercent = 50;
		mod *= costPercent / 100;
		if (player.hasPerk(PerkLib.BloodMage) && mod < 5) mod = 5;
		else if (mod < 2) mod = 2;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}

	internal function healCostWhiteImpl(mod:Number):Number {
		var costPercent:Number = 100;
		if (player.hasPerk(PerkLib.Ambition)) costPercent -= (100 * player.perkv2(PerkLib.Ambition));
		if (player.hasPerk(PerkLib.SeersInsight)) costPercent -= (100 * player.perkv1(PerkLib.SeersInsight));
		if (player.hasPerk(PerkLib.SpellcastingAffinity)) costPercent -= player.perkv1(PerkLib.SpellcastingAffinity);
		if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) costPercent -= player.perkv1(PerkLib.WizardsEnduranceAndSluttySeduction);
		if (player.hasPerk(PerkLib.WizardsAndDaoistsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsAndDaoistsEndurance);
		if (player.hasPerk(PerkLib.WizardsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsEndurance);
		if (player.hasPerk(PerkLib.WisenedHealer)) {
			costPercent += 100;
			if (player.level >= 24 && player.wis >= 60) costPercent += 25;
			if (player.level >= 42 && player.wis >= 120) costPercent += 25;
			if (player.level >= 60 && player.wis >= 180) costPercent += 25;
			if (player.level >= 78 && player.wis >= 240) costPercent += 25;
		}
		if (player.level >= 24 && player.inte >= 60) costPercent += 25;
		if (player.level >= 42 && player.inte >= 120) costPercent += 25;
		if (player.level >= 60 && player.inte >= 180) costPercent += 25;
		if (player.level >= 78 && player.inte >= 240) costPercent += 25;
		if (player.hasPerk(PerkLib.NaturalHealingMinor)) costPercent -= 10;
		if (player.hasPerk(PerkLib.NaturalHealingMajor)) costPercent -= 15;
		if (player.hasPerk(PerkLib.NaturalHealingEpic)) costPercent -= 20;
		if (player.hasPerk(PerkLib.NaturalHealingLegendary)) costPercent -= 25;
		if (player.headjewelryName == "fox hairpin") costPercent -= 20;
		if (player.weapon == weapons.PURITAS || player.weapon == weapons.ASCENSU) costPercent -= 15;
		if (player.weapon == weapons.N_STAFF) costPercent += 200;
		if (healModWhiteImpl() > 1) costPercent += Math.round(healModWhiteImpl() - 1) * 10;
		mod *= costPercent / 100;
		if (mod < 5) mod = 5;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}

	internal function spellCostBlackImpl(mod:Number):Number {
		//Addiditive mods
		var costPercent:Number = 100;
		if (player.hasPerk(PerkLib.Obsession)) costPercent -= (100 * player.perkv2(PerkLib.Obsession));
		if (player.hasPerk(PerkLib.SeersInsight)) costPercent -= (100 * player.perkv1(PerkLib.SeersInsight));
		if (player.hasPerk(PerkLib.SpellcastingAffinity)) costPercent -= player.perkv1(PerkLib.SpellcastingAffinity);
		if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) costPercent -= player.perkv1(PerkLib.WizardsEnduranceAndSluttySeduction);
		if (player.hasPerk(PerkLib.WizardsAndDaoistsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsAndDaoistsEndurance);
		if (player.hasPerk(PerkLib.WizardsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsEndurance);
		if (player.hasPerk(PerkLib.Necromancy)) costPercent -= 50;
		if (player.headjewelryName == "fox hairpin") costPercent -= 20;
		if (player.weapon == weapons.DEPRAVA || player.weapon == weapons.ASCENSU) costPercent -= 15;
		if (player.weapon == weapons.N_STAFF) costPercent += 200;
		if (spellModBlackImpl() > 1) costPercent += Math.round(spellModBlackImpl() - 1) * 10;
		if (player.level >= 24 && player.inte >= 60) costPercent += 50;
		if (player.level >= 42 && player.inte >= 120) costPercent += 50;
		if (player.level >= 60 && player.inte >= 180) costPercent += 50;
		if (player.level >= 78 && player.inte >= 240) costPercent += 50;
		//Limiting it and multiplicative mods
		if (player.hasPerk(PerkLib.BloodMage) && costPercent < 50) costPercent = 50;
		mod *= costPercent / 100;
		if (player.hasPerk(PerkLib.BloodMage) && mod < 5) mod = 5;
		else if (mod < 2) mod = 2;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}

	internal function healCostBlackImpl(mod:Number):Number {
		var costPercent:Number = 100;
		if (player.hasPerk(PerkLib.Obsession)) costPercent -= (100 * player.perkv2(PerkLib.Obsession));
		if (player.hasPerk(PerkLib.SeersInsight)) costPercent -= (100 * player.perkv1(PerkLib.SeersInsight));
		if (player.hasPerk(PerkLib.SpellcastingAffinity)) costPercent -= player.perkv1(PerkLib.SpellcastingAffinity);
		if (player.hasPerk(PerkLib.WizardsEnduranceAndSluttySeduction)) costPercent -= player.perkv1(PerkLib.WizardsEnduranceAndSluttySeduction);
		if (player.hasPerk(PerkLib.WizardsAndDaoistsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsAndDaoistsEndurance);
		if (player.hasPerk(PerkLib.WizardsEndurance)) costPercent -= player.perkv1(PerkLib.WizardsEndurance);
		if (player.hasPerk(PerkLib.WisenedHealer)) {
			costPercent += 100;
			if (player.level >= 24 && player.wis >= 60) costPercent += 25;
			if (player.level >= 42 && player.wis >= 120) costPercent += 25;
			if (player.level >= 60 && player.wis >= 180) costPercent += 25;
			if (player.level >= 78 && player.wis >= 240) costPercent += 25;
		}
		if (player.level >= 24 && player.inte >= 60) costPercent += 25;
		if (player.level >= 42 && player.inte >= 120) costPercent += 25;
		if (player.level >= 60 && player.inte >= 180) costPercent += 25;
		if (player.level >= 78 && player.inte >= 240) costPercent += 25;
		if (player.hasPerk(PerkLib.NaturalHealingMinor)) costPercent -= 10;
		if (player.hasPerk(PerkLib.NaturalHealingMajor)) costPercent -= 15;
		if (player.hasPerk(PerkLib.NaturalHealingEpic)) costPercent -= 20;
		if (player.hasPerk(PerkLib.NaturalHealingLegendary)) costPercent -= 25;
		if (player.hasPerk(PerkLib.Necromancy)) costPercent -= 50;
		if (player.headjewelryName == "fox hairpin") costPercent -= 20;
		if (player.weapon == weapons.DEPRAVA || player.weapon == weapons.ASCENSU) costPercent -= 15;
		if (player.weapon == weapons.N_STAFF) costPercent += 200;
		if (healModBlackImpl() > 1) costPercent += Math.round(healModBlackImpl() - 1) * 10;
		mod *= costPercent / 100;
		if (mod < 5) mod = 5;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}

	internal function spellModImpl():Number {
		var mod:Number = 1;
		if (player.hasPerk(PerkLib.Archmage) && player.inte >= 100) mod += .3;
		if (player.hasPerk(PerkLib.Channeling) && player.inte >= 60) mod += .2;
		if (player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 125) mod += .4;
		if (player.hasPerk(PerkLib.GrandArchmage2ndCircle) && player.inte >= 150) mod += .5;
		if (player.hasPerk(PerkLib.GrandArchmage3rdCircle) && player.inte >= 175) mod += .6;
		if (player.hasPerk(PerkLib.GrandMage) && player.inte >= 75) mod += .2;
		if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) mod += .1;
		if (player.hasPerk(PerkLib.PrestigeJobGreySage)) mod += .2;
		if (player.hasPerk(PerkLib.Mage) && player.inte >= 50) mod += .1;
		if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) mod += .1;
		if (player.hasPerk(PerkLib.TraditionalMageI) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if (player.hasPerk(PerkLib.TraditionalMageII) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if (player.hasPerk(PerkLib.TraditionalMageIII) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if (player.hasPerk(PerkLib.TraditionalMageIV) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if (player.hasPerk(PerkLib.TraditionalMageV) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if (player.hasPerk(PerkLib.TraditionalMageVI) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if (player.hasPerk(PerkLib.Obsession)) {
			mod += player.perkv1(PerkLib.Obsession);
		}
		if (player.hasPerk(PerkLib.Ambition)) {
			mod += player.perkv1(PerkLib.Ambition);
		}
		if (player.hasPerk(PerkLib.WizardsFocus)) {
			mod += player.perkv1(PerkLib.WizardsFocus);
		}
		if (player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) {
			mod += player.perkv1(PerkLib.WizardsAndDaoistsFocus);
		}
		if (player.hasPerk(PerkLib.SagesKnowledge)) {
			mod += player.perkv1(PerkLib.SagesKnowledge);
		}
		if (player.hasPerk(PerkLib.KnowledgeIsPower)) {
			if (player.hasPerk(PerkLib.RatatoskrSmartsFinalForm)) mod += (Math.round(codex.checkUnlocked() / 100) * 3);
			else mod += Math.round(codex.checkUnlocked() / 100);
		}
		if (player.hasPerk(PerkLib.ZenjisInfluence3)) mod += .3;
		if (player.hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
		if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) mod += (player.cor * .01)/2;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId2 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId3 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId4 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.necklaceEffectId == NecklaceLib.MODIFIER_SPELL_POWER) mod += (player.necklaceEffectMagnitude / 100);
		if (player.countCockSocks("blue") > 0) mod += (player.countCockSocks("blue") * .05);
		if (player.hasPerk(PerkLib.AscensionMysticality)) mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
		if (player.hasPerk(PerkLib.SeersInsight)) mod += player.perkv1(PerkLib.SeersInsight);
		if (player.shield == shields.SPI_FOC) mod += .2;
		if (player.shield == shields.MABRACE) mod += .5;
		if (player.weapon == weapons.N_STAFF) mod += player.cor * .01;
		if (player.weapon == weapons.U_STAFF) mod += (100 - player.cor) * .01;
		if (player.headJewelry == headjewelries.SPHINXAS) mod += .5;
		if (player.hasStatusEffect(StatusEffects.Maleficium)) {
			if (player.hasPerk(MutationsLib.ObsidianHeartPrimitive)) {
				if (player.hasPerk(MutationsLib.ObsidianHeartEvolved)) mod += 2.5;
				else mod += 1.25;
			} else mod += 1;
		}
		if (player.weapon == weapons.B_STAFF) {
			var mod1:Number = 0.4;
			mod1 -= player.cor / 10;
			if (mod1 < 0.1) mod1 = 0.1;
			mod += mod1;
		}
		if (player.hasPerk(PerkLib.InariBlessedKimono)){
			var mod2:Number = 0.5;
			mod2 -= player.cor / 10;
			if (mod1 < 0.1) mod2 = 0.1;
			mod += mod2;
		}
		if (player.weapon == weapons.PURITAS) mod *= 1.6;
		if (player.weapon == weapons.DEPRAVA) mod *= 1.6;
		if (player.weapon == weapons.ASCENSU) mod *= 2.5;
		if (player.hasStatusEffect(StatusEffects.DarkRitual)) mod *= 3;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}
	
	internal function spellModBloodImpl():Number {
		var mod:Number = 0;
		mod += spellModImpl();
		if (player.hasPerk(PerkLib.HiddenJobBloodDemon)) mod += .1;
		if (player.hasPerk(PerkLib.WayOfTheBlood)) mod += .1;
		if (player.hasPerk(PerkLib.YourPainMyPower)) mod += .1;
		if (player.hasPerk(PerkLib.MyBloodForBloodPuppies)) mod += .1;
		if (player.hasPerk(PerkLib.BloodDemonToughness)) mod += .1;
		//
		if (player.hasPerk(PerkLib.BloodDemonWisdom)) mod += .1;
		//
		if (player.hasPerk(PerkLib.BloodDemonIntelligence)) mod += .1;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}

	internal function spellGreyCooldownImpl():Number {
		var mod:Number = 3;
		if (mod < 0) mod = 0;
		return mod;
	}

	internal function healModImpl():Number {
		var mod:Number = 1;
		if (player.hasPerk(PerkLib.SpellpowerHealing) && player.wis >= 50) mod += .2;
		if (player.hasPerk(PerkLib.NaturalHealingMinor)) mod += .3;
		if (player.hasPerk(PerkLib.NaturalHealingMajor)) mod += .4;
		if (player.hasPerk(PerkLib.NaturalHealingEpic)) mod += .5;
		if (player.hasPerk(PerkLib.NaturalHealingLegendary)) mod += .6;
		if (player.hasPerk(PerkLib.Obsession)) {
			mod += player.perkv1(PerkLib.Obsession);
		}
		if (player.hasPerk(PerkLib.Ambition)) {
			mod += player.perkv1(PerkLib.Ambition);
		}
		if (player.hasPerk(PerkLib.WizardsFocus)) {
			mod += player.perkv1(PerkLib.WizardsFocus);
		}
		if (player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) {
			mod += player.perkv1(PerkLib.WizardsAndDaoistsFocus);
		}
		if (player.hasPerk(PerkLib.SagesKnowledge)) {
			mod += player.perkv1(PerkLib.SagesKnowledge);
		}
		if (player.hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId2 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId3 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId4 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.necklaceEffectId == NecklaceLib.MODIFIER_SPELL_POWER) mod += (player.necklaceEffectMagnitude / 100);
		if (player.countCockSocks("blue") > 0) mod += (player.countCockSocks("blue") * .05);
		if (player.hasPerk(PerkLib.AscensionMysticality)) mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
		if (player.hasPerk(PerkLib.SeersInsight)) mod += player.perkv1(PerkLib.SeersInsight);
		if (player.shield == shields.MABRACE) mod += .5;
		if (player.weapon == weapons.N_STAFF) mod += player.cor * .01;
		if (player.weapon == weapons.U_STAFF) mod += (100 - player.cor) * .01;
		if (player.weapon == weapons.B_STAFF) {
			var mod1:Number = 0.4;
			mod1 -= player.cor / 10;
			if (mod1 < 0.1) mod1 = 0.1;
			mod += mod1;
		}
		if (player.weapon == weapons.PURITAS) mod *= 1.6;
		if (player.weapon == weapons.DEPRAVA) mod *= 1.6;
		if (player.weapon == weapons.ASCENSU) mod *= 2.5;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}

	internal function spellModBase():Number {
		var mod:Number = 0;
		if (player.hasPerk(PerkLib.Archmage) && player.inte >= 100) mod += .3;
		if (player.hasPerk(PerkLib.Channeling) && player.inte >= 60) mod += .2;
		if (player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 125) mod += .4;
		if (player.hasPerk(PerkLib.GrandArchmage2ndCircle) && player.inte >= 150) mod += .5;
		if (player.hasPerk(PerkLib.GrandArchmage3rdCircle) && player.inte >= 175) mod += .6;
		if (player.hasPerk(PerkLib.GrandMage) && player.inte >= 75) mod += .2;
		if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) mod += .1;
		if (player.hasPerk(PerkLib.PrestigeJobGreySage)) mod += .2;
		if (player.hasPerk(PerkLib.Mage) && player.inte >= 50) mod += .1;
		if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) mod += .1;
		if (player.hasPerk(PerkLib.TraditionalMageI) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if (player.hasPerk(PerkLib.TraditionalMageII) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if (player.hasPerk(PerkLib.TraditionalMageIII) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if (player.hasPerk(PerkLib.TraditionalMageIV) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if (player.hasPerk(PerkLib.TraditionalMageV) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if (player.hasPerk(PerkLib.TraditionalMageVI) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if (player.hasPerk(PerkLib.Ambition)) {
			mod += player.perkv2(PerkLib.Ambition);
		}
		if (player.hasPerk(PerkLib.WizardsFocus)) {
			mod += player.perkv1(PerkLib.WizardsFocus);
		}
		if (player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) {
			mod += player.perkv1(PerkLib.WizardsAndDaoistsFocus);
		}
		if (player.hasPerk(PerkLib.SagesKnowledge)) {
			mod += player.perkv1(PerkLib.SagesKnowledge);
		}
		if (player.hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
		if (player.hasPerk(PerkLib.TamamoNoMaeCursedKimono)) mod += (player.cor * .01)/2;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId2 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId3 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId4 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.necklaceEffectId == NecklaceLib.MODIFIER_SPELL_POWER) mod += (player.necklaceEffectMagnitude / 100);
		if (player.countCockSocks("blue") > 0) mod += (player.countCockSocks("blue") * .05);
		if (player.hasPerk(PerkLib.AscensionMysticality)) mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
		if (player.hasPerk(PerkLib.SeersInsight)) mod += player.perkv1(PerkLib.SeersInsight);
		if (player.shield == shields.SPI_FOC) mod += .2;
		if (player.shield == shields.MABRACE) mod += .5;
		if (player.weapon == weapons.N_STAFF) mod += player.cor * .01;
		if (player.weapon == weapons.U_STAFF) mod += (100 - player.cor) * .01;
		if (player.headJewelry == headjewelries.SPHINXAS) mod += .5;
		if (player.headJewelry == headjewelries.DMONSKUL) mod += player.cor * .006;
		if (player.hasStatusEffect(StatusEffects.Maleficium)) {
			if (player.hasPerk(MutationsLib.ObsidianHeartPrimitive)) {
				if (player.hasPerk(MutationsLib.ObsidianHeartEvolved)) mod += 2.5;
				else mod += 1.25;
			} else mod += 1;
		}
		if (player.weapon == weapons.B_STAFF) {
			var mod1:Number = 0.4;
			mod1 -= player.cor / 10;
			if (mod1 < 0.1) mod1 = 0.1;
			mod += mod1;
		}
		if (player.hasPerk(PerkLib.InariBlessedKimono)){
			var mod2:Number = 0.5;
			mod2 -= player.cor / 10;
			if (mod1 < 0.1) mod2 = 0.1;
			mod += mod2;
		}
		if (player.weapon == weapons.ASCENSU) mod *= 2.5;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}
	
	public function spellModGrey():Number {
		var mod:Number = 1;
		if (player.hasPerk(PerkLib.GreyMageApprentice) && player.inte >= 75) mod += .1;
		if (player.hasPerk(PerkLib.GreyMage) && player.inte >= 125) mod += .2;
		if (player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 175) mod += .3;
		if (player.hasPerk(PerkLib.GrandGreyArchmage) && player.inte >= 225) mod += .4;
		return mod;
	}

	internal function spellModWhiteImpl():Number {
		var mod:Number = 1;
		mod += spellModBase();
		if (player.hasStatusEffect(StatusEffects.BlessingOfDivineMarae)) {
			mod += player.statusEffectv2(StatusEffects.BlessingOfDivineMarae);
		}
		if (player.hasPerk(PerkLib.AvatorOfPurity)) mod += .2;
		if (player.hasPerk(PerkLib.UnicornBlessing) && player.cor <= 20) mod += .2;
		if (player.hasPerk(PerkLib.PrestigeJobArchpriest)) mod += .2;
		if (player.hasPerk(PerkLib.PrestigeJobWarlock)) mod -= .4;
		if (player.hasKeyItem("Holy Symbol") >= 0) mod += .2;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}

	internal function spellWhiteCooldownImpl():Number {
		var mod:Number = 3;
		if (player.hasPerk(PerkLib.AvatorOfPurity)) mod -= 1;
		if (mod < 0) mod = 0;
		return mod;
	}

	internal function spellWhiteTier2CooldownImpl():Number {
		var mod:Number = 6;
		if (player.hasPerk(PerkLib.AvatorOfPurity)) mod -= 1;
		if (mod < 0) mod = 0;
		return mod;
	}

	internal function healModWhiteImpl():Number {
		var mod:Number = 1;
		if (player.hasPerk(PerkLib.SpellpowerHealing) && player.wis >= 50) mod += .2;
		if (player.hasPerk(PerkLib.NaturalHealingMinor)) mod += .3;
		if (player.hasPerk(PerkLib.NaturalHealingMajor)) mod += .4;
		if (player.hasPerk(PerkLib.NaturalHealingEpic)) mod += .5;
		if (player.hasPerk(PerkLib.NaturalHealingLegendary)) mod += .6;
		if (player.hasPerk(PerkLib.Ambition)) {
			mod += player.perkv2(PerkLib.Ambition);
		}
		if (player.hasStatusEffect(StatusEffects.BlessingOfDivineMarae)) {
			mod += player.statusEffectv2(StatusEffects.BlessingOfDivineMarae);
		}
		if (player.hasPerk(PerkLib.WizardsFocus)) {
			mod += player.perkv1(PerkLib.WizardsFocus);
		}
		if (player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) {
			mod += player.perkv1(PerkLib.WizardsAndDaoistsFocus);
		}
		if (player.hasPerk(PerkLib.SagesKnowledge)) {
			mod += player.perkv1(PerkLib.SagesKnowledge);
		}
		if (player.hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
		if (player.hasPerk(PerkLib.AvatorOfPurity)) mod += .3;
		if (player.hasPerk(PerkLib.UnicornBlessing) && player.cor <= 20) mod += .2;
		if (player.hasKeyItem("Holy Symbol") >= 0) mod += .2;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId2 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId3 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId4 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.necklaceEffectId == NecklaceLib.MODIFIER_SPELL_POWER) mod += (player.necklaceEffectMagnitude / 100);
		if (player.countCockSocks("blue") > 0) mod += (player.countCockSocks("blue") * .05);
		if (player.hasPerk(PerkLib.AscensionMysticality)) mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
		if (player.hasPerk(PerkLib.SeersInsight)) mod += player.perkv1(PerkLib.SeersInsight);
		if (player.shield == shields.MABRACE) mod += .5;
		if (player.weapon == weapons.N_STAFF) mod += player.cor * .02;
		if (player.weapon == weapons.U_STAFF) mod += (100 - player.cor) * .017;
		if (player.weapon == weapons.B_STAFF) {
			var mod1:Number = 0.4;
			mod1 -= player.cor / 10;
			if (mod1 < 0.1) mod1 = 0.1;
			mod += mod1;
		}
		if (player.weapon == weapons.PURITAS) mod *= 1.6;
		if (player.weapon == weapons.ASCENSU) mod *= 2.5;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}

	internal function spellModBlackImpl():Number {
		var mod:Number = 1;
		mod += spellModBase();
		if (player.hasPerk(PerkLib.AvatorOfCorruption)) mod += .3;
		if (player.hasPerk(PerkLib.BicornBlessing) && player.cor >= 80) mod += .2;
		if (player.hasPerk(PerkLib.PrestigeJobArchpriest)) mod -= .4;
		if (player.hasPerk(PerkLib.PrestigeJobWarlock)) mod += .2;
		if (player.miscJewelry == miscjewelries.DMAGETO || player.miscJewelry2 == miscjewelries.DMAGETO) mod += 0.25;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}

	internal function spellBlackCooldownImpl():Number {
		var mod:Number = 3;
		if (player.hasPerk(PerkLib.AvatorOfCorruption)) mod -= 1;
		if (mod < 0) mod = 0;
		return mod;
	}

	internal function spellBlackTier2CooldownImpl():Number {
		var mod:Number = 6;
		if (player.hasPerk(PerkLib.AvatorOfCorruption)) mod -= 1;
		if (mod < 0) mod = 0;
		return mod;
	}

	internal function healModBlackImpl():Number {
		var mod:Number = 1;
		if (player.hasPerk(PerkLib.SpellpowerHealing) && player.wis >= 50) mod += .2;
		if (player.hasPerk(PerkLib.NaturalHealingMinor)) mod += .3;
		if (player.hasPerk(PerkLib.NaturalHealingMajor)) mod += .4;
		if (player.hasPerk(PerkLib.NaturalHealingEpic)) mod += .5;
		if (player.hasPerk(PerkLib.NaturalHealingLegendary)) mod += .6;
		if (player.hasPerk(PerkLib.Obsession)) {
			mod += player.perkv2(PerkLib.Obsession);
		}
		if (player.hasPerk(PerkLib.WizardsFocus)) {
			mod += player.perkv1(PerkLib.WizardsFocus);
		}
		if (player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) {
			mod += player.perkv1(PerkLib.WizardsAndDaoistsFocus);
		}
		if (player.hasPerk(PerkLib.SagesKnowledge)) {
			mod += player.perkv1(PerkLib.SagesKnowledge);
		}
		if (player.hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
		if (player.hasPerk(PerkLib.AvatorOfCorruption)) mod += .3;
		if (player.hasPerk(PerkLib.BicornBlessing) && player.cor >= 80) mod += .2;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId2 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId3 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId4 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.necklaceEffectId == NecklaceLib.MODIFIER_SPELL_POWER) mod += (player.necklaceEffectMagnitude / 100);
		if (player.countCockSocks("blue") > 0) mod += (player.countCockSocks("blue") * .05);
		if (player.hasPerk(PerkLib.AscensionMysticality)) mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
		if (player.hasPerk(PerkLib.SeersInsight)) mod += player.perkv1(PerkLib.SeersInsight);
		if (player.shield == shields.MABRACE) mod += .5;
		if (player.weapon == weapons.N_STAFF) mod += player.cor * .01;
		if (player.weapon == weapons.U_STAFF) mod += (100 - player.cor) * .01;
		if (player.weapon == weapons.B_STAFF) {
			var mod1:Number = 0.4;
			mod1 -= player.cor / 10;
			if (mod1 < 0.1) mod1 = 0.1;
			mod += mod1;
		}
		if (player.weapon == weapons.DEPRAVA) mod *= 1.6;
		if (player.weapon == weapons.ASCENSU) mod *= 2.5;
		mod = Math.round(mod * 100) / 100;
		return mod;
	}

	public function getBlackMagicMinLust():Number {
		if (player.hasPerk(PerkLib.GreyMage)) return 30;
		return 50;
	}

	public function getWhiteMagicLustCap():Number {
		var whiteLustCap:int = player.maxLust() * 0.75;
		if (player.hasPerk(PerkLib.Enlightened) && player.cor < (10 + player.corruptionTolerance())) whiteLustCap += (player.maxLust() * 0.1);
		if (player.hasPerk(PerkLib.FocusedMind) && !player.hasPerk(PerkLib.GreyMage)) whiteLustCap += (player.maxLust() * 0.1);
		if (player.hasPerk(PerkLib.GreyMage)) {
			if (player.hasPerk(PerkLib.Enlightened) && player.cor < (10 + player.corruptionTolerance())) whiteLustCap = (player.maxLust() - 15);
			else whiteLustCap = (player.maxLust() - 45);
		}
		return whiteLustCap;
	}

	private function omnicasterMutliForReflectDmgAndAchievments():Number {
		return AbstractSpell.omnicasterRepeatCount();
	}
	
	public function perkRelatedDurationBoosting():Number {
		var perkRelatedDB:Number = 0;
		if (player.hasPerk(PerkLib.LongerLastingBuffsI)) perkRelatedDB += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsII)) perkRelatedDB += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsIII)) perkRelatedDB += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsIV)) perkRelatedDB += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsV)) perkRelatedDB += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsVI)) perkRelatedDB += 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) perkRelatedDB += 5;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) perkRelatedDB += 5;
		return perkRelatedDB;
	}

	internal function calcInfernoModImpl(damage:Number):int {
		if (player.hasPerk(PerkLib.RagingInferno)) {
			if (player.hasStatusEffect(StatusEffects.CounterRagingInferno)) {
				var multiplier:Number = 1;
				if (player.statusEffectv1(StatusEffects.CounterRagingInferno) == 0) outputText("Unfortunately, traces of your previously used fire magic are too weak to be used.\n\n");
				else {
					outputText("Traces of your previously used fire magic are still here, and you use them to empower another spell!\n\n");
					multiplier += player.statusEffectv1(StatusEffects.CounterRagingInferno) * 0.05;
					damage = Math.round(damage * multiplier);
				}
				if (player.statusEffectv4(StatusEffects.CounterRagingInferno) == 0) {
					player.addStatusValue(StatusEffects.CounterRagingInferno, 4, 1);
					if (player.hasPerk(PerkLib.RagingInfernoEx)) player.addStatusValue(StatusEffects.CounterRagingInferno, 1, 6);
					else player.addStatusValue(StatusEffects.CounterRagingInferno, 1, 4);
				}
				player.addStatusValue(StatusEffects.CounterRagingInferno, 2, 1);
			}
			else {
				if (player.hasPerk(PerkLib.RagingInfernoEx)) player.createStatusEffect(StatusEffects.CounterRagingInferno,6,1,0,1);
				else player.createStatusEffect(StatusEffects.CounterRagingInferno,4,1,0,1);
			}
		}
		return damage;
	}

	internal function calcGlacialModImpl(damage:Number):int {
		if (player.hasPerk(PerkLib.GlacialStorm)) {
			if (player.hasStatusEffect(StatusEffects.CounterGlacialStorm)) {
				var multiplier:Number = 1;
				if (player.statusEffectv1(StatusEffects.CounterGlacialStorm) == 0) outputText("Unfortunately, traces of your previously used ice magic are too weak to be used.\n\n");
				else {
					outputText("Traces of your previously used ice magic are still here, and you use them to empower another spell!\n\n");
					multiplier += player.statusEffectv1(StatusEffects.CounterGlacialStorm) * 0.05;
					damage = Math.round(damage * multiplier);
				}
				if (player.statusEffectv4(StatusEffects.CounterGlacialStorm) == 0) {
					player.addStatusValue(StatusEffects.CounterGlacialStorm, 4, 1);
					if (player.hasPerk(PerkLib.GlacialStormEx)) player.addStatusValue(StatusEffects.CounterGlacialStorm, 1, 6);
					else player.addStatusValue(StatusEffects.CounterGlacialStorm, 1, 4);
				}
				player.addStatusValue(StatusEffects.CounterGlacialStorm, 2, 1);
			}
			else {
				if (player.hasPerk(PerkLib.GlacialStormEx)) player.createStatusEffect(StatusEffects.CounterGlacialStorm,6,1,0,1);
				else player.createStatusEffect(StatusEffects.CounterGlacialStorm,4,1,0,1);
			}
		}
		return damage;
	}

	internal function calcVoltageModImpl(damage:Number):int {
		if (player.hasPerk(PerkLib.HighVoltage)) {
			if (player.hasStatusEffect(StatusEffects.CounterHighVoltage)) {
				var multiplier:Number = 1;
				if (player.statusEffectv1(StatusEffects.CounterHighVoltage) == 0) outputText("Unfortunately, traces of your previously used lightning magic are too weak to be used.\n\n");
				else {
					outputText("Traces of your previously used lightning magic are still here, and you use them to empower another spell!\n\n");
					multiplier += player.statusEffectv1(StatusEffects.CounterHighVoltage) * 0.05;
					damage = Math.round(damage * multiplier);
				}
				if (player.statusEffectv4(StatusEffects.CounterHighVoltage) == 0) {
					player.addStatusValue(StatusEffects.CounterHighVoltage, 4, 1);
					if (player.hasPerk(PerkLib.HighVoltageEx)) player.addStatusValue(StatusEffects.CounterHighVoltage, 1, 6);
					else player.addStatusValue(StatusEffects.CounterHighVoltage, 1, 4);
				}
				player.addStatusValue(StatusEffects.CounterHighVoltage, 2, 1);
			}
			else {
				if (player.hasPerk(PerkLib.HighVoltageEx)) player.createStatusEffect(StatusEffects.CounterHighVoltage,6,1,0,1);
				else player.createStatusEffect(StatusEffects.CounterHighVoltage,4,1,0,1);
			}
		}
		return damage;
	}

	internal function calcEclypseModImpl(damage:Number):int {
		if (player.hasPerk(PerkLib.EclipsingShadow)) {
			if (player.hasStatusEffect(StatusEffects.CounterEclipsingShadow)) {
				var multiplier:Number = 1;
				if (player.statusEffectv1(StatusEffects.CounterEclipsingShadow) == 0) outputText("Unfortunately, traces of your previously used darkness magic are too weak to be used.\n\n");
				else {
					outputText("Traces of your previously used darkness magic are still here, and you use them to empower another spell!\n\n");
					multiplier += player.statusEffectv1(StatusEffects.CounterEclipsingShadow) * 0.05;
					damage = Math.round(damage * multiplier);
				}
				if (player.statusEffectv4(StatusEffects.CounterEclipsingShadow) == 0) {
					player.addStatusValue(StatusEffects.CounterEclipsingShadow, 4, 1);
					if (player.hasPerk(PerkLib.EclipsingShadowEx)) player.addStatusValue(StatusEffects.CounterEclipsingShadow, 1, 6);
					else player.addStatusValue(StatusEffects.CounterEclipsingShadow, 1, 4);
				}
				player.addStatusValue(StatusEffects.CounterEclipsingShadow, 2, 1);
			}
			else {
				if (player.hasPerk(PerkLib.EclipsingShadowEx)) player.createStatusEffect(StatusEffects.CounterEclipsingShadow,6,1,0,1);
				else player.createStatusEffect(StatusEffects.CounterEclipsingShadow,4,1,0,1);
			}
		}
		return damage;
	}

	
	public function buildWhiteMenu(buttons:ButtonDataList):void {
		//WHITE SHITZ
		for each(var ability:CombatAbility in CombatAbilities.ALL_WHITE_SPELLS) {
			if (ability.isKnown) {
				buttons.list.push(ability.createButton(monster));
			}
		}
	}

	public function buildBlackMenu(buttons:ButtonDataList):void {
		//BLACK MAGICSKS
		for each(var ability:CombatAbility in CombatAbilities.ALL_BLACK_SPELLS) {
			if (ability.isKnown) {
				buttons.list.push(ability.createButton(monster));
			}
		}
	}

	public function buildHexMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		var badLustForBlack:Boolean = player.lust < getBlackMagicMinLust();
		var bloodForBloodGod:Number = (player.HP - player.minHP());

		//HEX MAGIC
		for each(var ability:CombatAbility in CombatAbilities.ALL_HEX_SPELLS) {
			if (ability.isKnown) {
				buttons.list.push(ability.createButton(monster));
			}
		}
	}
	
	public function buildDivineMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		var badLustForWhite:Boolean = player.lust >= getWhiteMagicLustCap();
		var bloodForBloodGod:Number = (player.HP - player.minHP());
		
		for each(var ability:CombatAbility in CombatAbilities.ALL_DIVINE_SPELLS) {
			if (ability.isKnown) {
				buttons.list.push(ability.createButton(monster));
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsAegis)) {
			bd = buttons.add("Aegis", spellAegis)
					.hint("Increase block chance by 1 to 10%, tripled if using a staff and no shield. (Based on spell buff and intelligence)  " +
							"\n\nMana Cost: " + spellCostWhite(500) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on divine magic.");
			} else if(player.cor > 20) {
				bd.disable("Your corruption is too high to cast this spell.");
			} else if (!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && !player.hasStatusEffect(StatusEffects.BloodMage) && player.mana < spellCostWhite(500)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(500) && player.HP < spellCostWhite(500)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.BloodMage) && (bloodForBloodGod - 1) < spellCostWhite(500)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.Aegis)) {
				bd.disable("Your Aegis is still active.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsExorcise)) {
			bd = buttons.add("Exorcise", spellExorcise)
					.hint("Smite your opponent with your weapon, inflicting damage based on the weapon’s damage and your magical power. Highly effective against the corrupt.  " +
							"\n\nMana Cost: " + spellCostWhite(400) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on divine magic.");
			} else if(player.cor > 20) {
				bd.disable("Your corruption is too high to cast this spell.");
			} else if (!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && !player.hasStatusEffect(StatusEffects.BloodMage) && player.mana < spellCostWhite(400)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(400) && player.HP < spellCostWhite(400)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.BloodMage) && (bloodForBloodGod - 1) < spellCostWhite(400)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellExorcise)) {
				bd.disable("You need more time before you can cast Exorcise again.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff magic while underground.");
			} else if (combat.isEnnemyInvisible) {
				bd.disable("You cannot use offensive spells against an opponent you cannot see or target.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsDivineShield)) {
			bd = buttons.add("DivineShield", spellDivineShield)
					.hint("Increase magic resistance by 40%.  " +
							"\n\nMana Cost: " + spellCostWhite(600) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on divine magic.");
			} else if(player.cor > 20) {
				bd.disable("Your corruption is too high to cast this spell.");
			} else if (!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && !player.hasStatusEffect(StatusEffects.BloodMage) && player.mana < spellCostWhite(600)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(600) && player.HP < spellCostWhite(600)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.BloodMage) && (bloodForBloodGod - 1) < spellCostWhite(600)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.DivineShield)) {
				bd.disable("Your Divine Shield is still active.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsThunderstorm)) {
			bd = buttons.add("Thunderstorm", spellThunderstorm)
					.hint("Call upon the heavenly thunder, starting a lightning storm that will systematically zap your opponents every turn for up to 30 rounds.  " +
							"\n\nMana Cost: " + spellCostWhite(1200) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on divine magic.");
			} else if(player.cor > 20) {
				bd.disable("Your corruption is too high to cast this spell.");
			} else if (!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && !player.hasStatusEffect(StatusEffects.BloodMage) && player.mana < spellCostWhite(1200)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(1200) && player.HP < spellCostWhite(1200)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.BloodMage) && (bloodForBloodGod - 1) < spellCostWhite(1200)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff magic while underground.");
			} else if (combat.isEnnemyInvisible) {
				bd.disable("You cannot use offensive spells against an opponent you cannot see or target.");
			} else if (player.hasStatusEffect(StatusEffects.Thunderstorm)) {
				bd.disable("Can be casted only once per combat.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsTearsOfDenial)) {
			bd = buttons.add("TearsOfDenial", spellTearsOfDenial)
					.hint("When hit by an ability that would put you to min hit points or be filled with lust instead heal you to full health and wash your desire away.  " +
							"\n\nMana Cost: " + spellCostWhite(3000) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on divine magic.");
			} else if(player.cor > 20) {
				bd.disable("Your corruption is too high to cast this spell.");
			} else if (!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && !player.hasStatusEffect(StatusEffects.BloodMage) && player.mana < spellCostWhite(3000)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(3000) && player.HP < spellCostWhite(3000)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.BloodMage) && (bloodForBloodGod - 1) < spellCostWhite(3000)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.TearsOfDenial)) {
				bd.disable("Can be casted only once per combat.");
			}
		}
	}
	
	public function buildNecroMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		for each(var ability:CombatAbility in CombatAbilities.ALL_NECRO_SPELLS) {
			if (ability.isKnown) {
				buttons.list.push(ability.createButton(monster));
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBoneSpirit)) {
			bd = buttons.add("Bone spirit", spellBoneSpirit)
					.hint("Turn an ordinary set of bones into a vengeance mad apparition that will charge at your target. Upon contact it will explode dealing massive true damage.  \n\nBones cost: 5");
			if (!player.hasPerk(PerkLib.BoneSoul) && player.perkv1(PerkLib.PrestigeJobNecromancer) < 5) {
				bd.disable("You not have enough demon bones to use any this necromancer spell.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff magic while underground.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBoneArmor)) {
			bd = buttons.add("Bone armor", spellBoneArmor)
					.hint("Animate bones to create an impenetrable shield lasting 5 rounds and reducing all damage taken by 50%.  \n\n<b>Cooldown: 10 turns</b>  \n\nBones cost: 10");
			if (!player.hasPerk(PerkLib.BoneSoul) && player.perkv1(PerkLib.PrestigeJobNecromancer) < 10) {
				bd.disable("You not have enough demon bones to use any this necromancer spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellBoneArmor)) {
				bd.disable("You need more time before you can cast Bone armor again.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBoneshatter)) {
			bd = buttons.add("Boneshatter", spellBoneshatter)
					.hint("Strike at the target ossature causing it to explode from the inside and causing serious internal damage and weakening its blow. Single target only (does not work on boneless creatures, Monster take 20% strength drain from this effect which stacks).  \n\n<b>Cooldown: 3 turns</b>  \n\nBones cost: 5");
			if (!player.hasPerk(PerkLib.BoneSoul) && player.perkv1(PerkLib.PrestigeJobNecromancer) < 5) {
				bd.disable("You not have enough demon bones to use any this necromancer spell.");
			} else if (monster.hasPerk(PerkLib.EnemyConstructType) || monster.hasPerk(PerkLib.EnemyElementalType) || monster.hasPerk(PerkLib.EnemyGhostType) || monster.hasPerk(PerkLib.EnemyGooType) || monster.hasPerk(PerkLib.EnemyPlantType)) {
				bd.disable("Your enemy lack bones.");
			} else if (monster.plural || monster.hasPerk(PerkLib.Enemy300Type) || monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType)) {
				bd.disable("You can only strike one target.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellBoneshatter)) {
				bd.disable("You need more time before you can cast Boneshatter again.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff magic while underground.");
			}
		}
	}

	public function buildGreyMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		var numb:Number = 50;
		if (player.hasPerk(PerkLib.GrandGreyArchmage)) numb -= 50;
		var badLustForGrey:Boolean = player.lust < numb || player.lust > (player.maxLust() - numb);
		var bloodForBloodGod:Number = (player.HP - player.minHP());
//perki z grey mage line dajace spell mod * x% wiecej (nie wplywa na sam spell mod anu spell mod white/black)
		// GRAY MAGIC
		for each(var ability:CombatAbility in CombatAbilities.ALL_GREY_SPELLS) {
			if (ability.isKnown) {
				buttons.list.push(ability.createButton(monster));
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsManaShield)) {
			if (player.hasStatusEffect(StatusEffects.ManaShield)) {
				buttons.add("Deactiv MS", DeactivateManaShield).hint("Deactivate Mana Shield.");
			} else {
				bd = buttons.add("Mana Shield", spellManaShield)
						.hint("Drawning your own mana with help of lust and force of the willpower to form shield that can absorb attacks.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  \n\nMana Cost: 1 mana point per 1 point of damage blocked");
				if (badLustForGrey) {
					bd.disable("You can't use any grey magics.");
				}
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsEnergyDrain)) {
			bd = buttons.add("Energy Drain", spellEnergyDrain)
					.hint("Fatigue the target (-20% damage for 7 rounds) and recover mana by draining the target's mana (up to 4x of spell cost).  " +
							"\n\nMana Cost: " + spellCost(350) + "");
			if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && !player.hasStatusEffect(StatusEffects.BloodMage) && player.mana < spellCost(350)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(350) && player.HP < spellCost(350)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.BloodMage) && (bloodForBloodGod - 1) < spellCost(350)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellEnergyDrain)) {
				bd.disable("You need more time before you can cast Energy Drain again.");
			} else if (monster.hasStatusEffect(StatusEffects.EnergyDrain)) {
				bd.disable("Energy Drain is still active.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff magic while underground.");
			} else if (combat.isEnnemyInvisible) {
				bd.disable("You cannot use offensive spells against an opponent you cannot see or target.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsRestore)) {
			bd = buttons.add("Restore", spellRestore)
					.hint("Heal for a decent amount of health and regenerate a little over time.  " +
							"\n\nMana Cost: " + healCost(80) + "");
			if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if(player.mana < healCost(80)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellRestore)) {
				bd.disable("You need more time before you can cast Restore again.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBalanceOfLife)) {
			bd = buttons.add("BalanceOfLife", spellBalanceOfLife)
					.hint("Heals for 5% of your hp when dealing spell damage." +
							"\n\nMana Cost: " + spellCost(500) + "");
			if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && !player.hasStatusEffect(StatusEffects.BloodMage) && player.mana < spellCost(500)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(500) && player.HP < spellCost(500)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.BloodMage) && (bloodForBloodGod - 1) < spellCost(500)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		//	if (player.hasStatusEffect(StatusEffects.KnowsWereBeast)) buttons.add("Were-beast",	were-beast spell goes here
		//	if (player.hasStatusEffect(StatusEffects.Knows)) buttons.add("	next spell (non-fire or non-ice based) goes here
		/*if (player.hasStatusEffect(StatusEffects.KnowsFireStorm)) {
			bd = buttons.add("Fire Storm", spell2FireStorm).hint("Drawning your own lust and force of the willpower to fuel radical change in the surrounding you can call forth an Fire Storm that will attack enemies in a wide area.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  \n\n<b>AoE Spell.</b>  \n\nMana Cost: " + spellCost(200) + "");
			if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if (!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && !player.hasStatusEffect(StatusEffects.BloodMage) && player.mana < spellCost(200)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200) && player.HP < spellCost(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.BloodMage) && (bloodForBloodGod - 1) < spellCost(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff magic while underground.");
			} else if (combat.isEnnemyInvisible) {
				bd.disable("You cannot use offensive spells against an opponent you cannot see or target.");
			}
		}*/
		//	if (player.hasStatusEffect(StatusEffects.Knows)) buttons.add("	fire single target spell goes here
		/*if (player.hasStatusEffect(StatusEffects.KnowsIceRain)) {
			bd = buttons.add("Ice Rain", spell2IceRain).hint("Drawning your own lust and force of the willpower to fuel radical change in the surrounding you can call forth an Ice Rain that will attack enemies in a wide area.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  \n\n<b>AoE Spell.</b>  \n\nMana Cost: " + spellCost(200) + "");
			if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && !player.hasStatusEffect(StatusEffects.BloodMage) && player.mana < spellCost(200)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200) && player.HP < spellCost(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.BloodMage) && (bloodForBloodGod - 1) < spellCost(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff magic while underground.");
			} else if (combat.isEnnemyInvisible) {
				bd.disable("You cannot use offensive spells against an opponent you cannot see or target.");
			}
		}*/
	}
	
	public function buildBloodMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		for each(var ability:CombatAbility in CombatAbilities.ALL_BLOOD_SPELLS) {
			if (ability.isKnown) {
				buttons.list.push(ability.createButton(monster));
			}
		}
		var bloodForBloodGod:Number = (player.HP - player.minHP());
		if (player.hasStatusEffect(StatusEffects.KnowsBloodMissiles)) {
			bd = buttons.add("BloodMissiles", spellBloodMissiles)
					.hint("Blood Missiles will attack foe with five blood spheres.  " +
							"\n\nBlood Cost: " + spellCostBlood(50) + "");
			if ((bloodForBloodGod - 1) < spellCostBlood(50)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellBloodMissiles)) {
				bd.disable("You need more time before you can cast this spell again.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff magic while underground.");
			} else if (combat.isEnnemyInvisible) {
				bd.disable("You cannot use offensive spells against an opponent you cannot see or target.");
			} else if (player.isGargoyle()) {
				bd.disable("You cannot use blood spells if you not have blood at all.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBloodShield)) {
			if (player.hasStatusEffect(StatusEffects.BloodShield)) {
				buttons.add("Deactiv BS", DeactivateBloodShield).hint("Deactivate Blood Shield.");
			}
			else {
				bd = buttons.add("BloodShield", spellBloodShield)
						.hint("Blood Shield will form blood shield to block enemy attacks.  " +
								"\n\nBlood Cost: " + spellCostBlood(spellBloodShieldCost()) + "");
				if ((bloodForBloodGod - 1) < spellCostBlood(spellBloodShieldCost())) {
					bd.disable("Your hp is too low to cast this spell.");
				} else if (player.isGargoyle()) {
					bd.disable("You cannot use blood spells if you not have blood at all.");
				}
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBloodExplosion)) {
			bd = buttons.add("BloodExplosion", spellBloodExplosion)
					.hint("Blood Explosion will attack foe with blood orb.  \n\n<b>AoE Spell.</b>  " +
							"\n\nBlood Cost: " + spellCostBlood(200) + "");
			if ((bloodForBloodGod - 1) < spellCostBlood(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellBloodExplosion)) {
				bd.disable("You need more time before you can cast this spell again.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff magic while underground.");
			} else if (combat.isEnnemyInvisible) {
				bd.disable("You cannot use offensive spells against an opponent you cannot see or target.");
			} else if (player.isGargoyle()) {
				bd.disable("You cannot use blood spells if you not have blood at all.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBloodChains)) {
			bd = buttons.add("BloodChains", spellBloodChains)
					.hint("Blood Chains will immobilize foe briefly.  " +
							"\n\nBlood Cost: " + spellCostBlood(100) + "");
			if ((bloodForBloodGod - 1) < spellCostBlood(100)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellBloodChains)) {
				bd.disable("You need more time before you can cast this spell again.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff magic while underground.");
			} else if (combat.isEnnemyInvisible) {
				bd.disable("You cannot use offensive spells against an opponent you cannot see or target.");
			} else if (player.isGargoyle()) {
				bd.disable("You cannot use blood spells if you not have blood at all.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBloodWave)) {//blood wave (deal more to larger groups of enemies than normal small groups)
			bd = buttons.add("BloodWave", spellBloodWave)
					.hint("Blood Shield will attack all surrounding foes with a wave of blood.  It would deal more damage when used against larger than averange sized group of enemies.  \n\n<b>AoE Spell.</b>  " +
							"\n\nBlood Cost: " + spellCostBlood(400) + "");
			if ((bloodForBloodGod - 1) < spellCostBlood(400)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellBloodWave)) {
				bd.disable("You need more time before you can cast this spell again.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff magic while underground.");
			} else if (combat.isEnnemyInvisible) {
				bd.disable("You cannot use offensive spells against an opponent you cannot see or target.");
			} else if (player.isGargoyle()) {
				bd.disable("You cannot use blood spells if you not have blood at all.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsLifestealEnchantment)) {
			bd = buttons.add("LifestealEnch", spellLifestealEnchantment)
					.hint("Lifesteal Enchantment will add lifesteal effect to your weapons.  " +
							"\n\nBlood Cost: " + spellCostBlood(500) + "");
			if ((bloodForBloodGod - 1) < spellCostBlood(500)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.LifestealEnchantment)) {
				bd.disable("You can recast this spell only after it duration ended.");
			} else if (player.isGargoyle()) {
				bd.disable("You cannot use blood spells if you not have blood at all.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBloodField)) {
			bd = buttons.add("BloodField", spellBloodField)
					.hint("Blood Field will form field on the ground that would slow down enemies, drain their health and heal the caster.  " +
							"\n\nBlood Cost: " + spellCostBlood(600) + "");
			if ((bloodForBloodGod - 1) < spellCostBlood(600)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.BloodField)) {
				bd.disable("You can recast this spell only after it duration ended.");
			} else if (monster.hasStatusEffect(StatusEffects.Dig)) {
				bd.disable("You can only use buff magic while underground.");
			} else if (combat.isEnnemyInvisible) {
				bd.disable("You cannot use offensive spells against an opponent you cannot see or target.");
			} else if (player.isGargoyle()) {
				bd.disable("You cannot use blood spells if you not have blood at all.");
			}
		}
	}

	//THIS FEATURE GOVERS EVERY POST CAST EFFECT YOUR SPELLS MAY CAUSE
	public function MagicAddonEffect(numberOfProcs:Number = 1):void {
		if (player.hasStatusEffect(StatusEffects.Venomancy)) {
			if (player.tailVenom >= player.VenomWebCost()) {
				var injections:Number = 0;
				while (player.tailVenom >= player.VenomWebCost() && injections < numberOfProcs) {
					var damageB:Number = 35 + rand(player.lib / 10);
					var poisonScaling:Number = 1;
					var dam4Bab:Number = 1;
					if (player.hasPerk(PerkLib.ImprovedVenomGlandSu)) dam4Bab *= 2;
					poisonScaling += player.lib/100;
					poisonScaling += player.tou/100;
					if (player.level < 10) damageB += 20 + (player.level * 3);
					else if (player.level < 20) damageB += 50 + (player.level - 10) * 2;
					else if (player.level < 30) damageB += 70 + (player.level - 20) * 1;
					else damageB += 80;
					damageB *= 0.04;
					damageB *= dam4Bab;
					poisonScaling *= dam4Bab;
					damageB *= 1+(poisonScaling/10);
					monster.teased(monster.lustVuln * damageB, false);
					monster.statStore.addBuffObject({tou:-poisonScaling}, "Poison",{text:"Poison"});
					if (monster.hasStatusEffect(StatusEffects.NagaVenom)) {
							monster.addStatusValue(StatusEffects.NagaVenom, 3, 1);
					} else monster.createStatusEffect(StatusEffects.NagaVenom, 0, 0, 1, 0);
					player.tailVenom -= player.VenomWebCost();
					flags[kFLAGS.VENOM_TIMES_USED] += 0.2;
					injections++;
				}
				outputText(" Your venom is forcefully injected ");
				if (injections > 1) outputText(""+injections+" times");
				outputText(" in [themonster] through your magic!");
			}
		}
		if (player.hasStatusEffect(StatusEffects.BalanceOfLife)) HPChange((player.maxHP() * numberOfProcs * 0.05), false);
	}
	
	public function spellBloodMissiles():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		HPChange(-spellCostBlood(50), false);
		player.createStatusEffect(StatusEffects.CooldownSpellBloodMissiles,2,0,0,0);
		if(handleShell()){return;}
		outputText("You concentrate, focusing on the power of your blood before drawing it from your body, "+(player.HP < player.maxOverHP() ? "wounds":"skin pores")+". Around you form a few crimson spheres you aim at [themonster]!\n\n");
		var damage:Number = scalingBonusIntelligence() * spellModBlood();
		if (damage < 10) damage = 10;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage * combat.bloodDamageBoostedByDao());
		outputText(monster.capitalA + monster.short + " takes ");
		doMagicDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doMagicDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doMagicDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doMagicDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		doMagicDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		outputText(" damage.");
		MagicAddonEffect(5);
		outputText("\n\n");
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else {
			if (monster is Lethice && (monster as Lethice).fightPhase == 3) {
				outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
	}
	
	public function spellBloodShieldCost():Number {
		var shieldcost:Number = 0;
		shieldcost += (player.maxOverHP() * 0.2);
		return shieldcost;
	}
	public function spellBloodShield():void {
		clearOutput();
		HPChange(-spellCostBlood(spellBloodShieldCost()), false);
		player.createStatusEffect(StatusEffects.BloodShield,Math.round(spellBloodShieldCost() * spellModBlood()),0,0,0);
		outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + (player.HP < player.maxOverHP() ? "wounds":"skin pores") + ". Blood starts to gather around you, coalescing into a semi transparent crimson "+(player.hasStatusEffect(StatusEffects.Flying)?"":"hemi")+"sphere.\n\n");
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		statScreenRefresh();
		enemyAI();
	}
	public function DeactivateBloodShield():void {
		clearOutput();
		outputText("Deciding you no longer need to maintain your blood shield, you stop maintaining it.\n\n");
		player.removeStatusEffect(StatusEffects.BloodShield);
		enemyAI();
	}
	
	public function spellBloodExplosion():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		HPChange(-spellCostBlood(200), false);
		player.createStatusEffect(StatusEffects.CooldownSpellBloodExplosion,3,0,0,0);
		if(handleShell()){return;}
		outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + (player.HP < player.maxOverHP() ? "wounds":"skin pores") + ". Blood starts to gather above your hand, coalescing into a crimson sphere. ");
		outputText("It roils as you concentrate on it before aim the orb at [themonster], it brusts and seeps into [monster him] on impact as [monster he]'" + (monster.plural ? "re":"s") + " afflicted by the magic.\n\n");
		var damage:Number = scalingBonusIntelligence() * spellModBlood() * 4;
		if (damage < 10) damage = 10;
		if (monster.plural) damage *= 5;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage * combat.bloodDamageBoostedByDao());
		outputText(monster.capitalA + monster.short + " takes ");
		doMagicDamage(damage, true, true);
		outputText(" damage.");
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		MagicAddonEffect();
		outputText("\n\n");
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else {
			if (monster is Lethice && (monster as Lethice).fightPhase == 3) {
				outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
	}
	
	public function spellBloodChains():void {
		clearOutput();
		HPChange(-spellCostBlood(100), false);
		player.createStatusEffect(StatusEffects.CooldownSpellBloodChains,3,0,0,0);
		outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + (player.HP < player.maxOverHP() ? "wounds":"skin pores") + ". Blood starts to gather before your chest, coalescing into a crimson sphere. ");
		outputText("The blood emitted by you splited into dozens of stems and surrounded [themonster], bounding [monster him] tight enought to prevent any movements for some time.\n\n");
		monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		statScreenRefresh();
		enemyAI();
	}
	
	public function spellBloodWave():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		HPChange(-spellCostBlood(400), false);
		player.createStatusEffect(StatusEffects.CooldownSpellBloodWave,5,0,0,0);
		if(handleShell()){return;}
		outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + (player.HP < player.maxOverHP() ? "wounds":"skin pores") + ". Blood starts to gather around you, coalescing into a crimson ring. ");
		outputText("It roils as you concentrate on it before you release it. It moves in all directions looking like a raging waves until it hits [themonster].\n\n");
		var damage:Number = scalingBonusIntelligence() * spellModBlood() * 4;
		if (damage < 10) damage = 10;
		if (monster.plural) damage *= 5;
		if (monster.hasPerk(PerkLib.EnemyLargeGroupType)) damage *= 5;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage * combat.bloodDamageBoostedByDao());
		outputText(monster.capitalA + monster.short + " takes ");
		doMagicDamage(damage, true, true);
		outputText(" damage.");
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		MagicAddonEffect();
		outputText("\n\n");
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if (monster.HP <= monster.minHP()) doNext(endHpVictory);
		else {
			if (monster is Lethice && (monster as Lethice).fightPhase == 3) {
				outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
	}
	
	public function spellLifestealEnchantment():void {
		clearOutput();
		HPChange(-spellCostBlood(500), false);
		player.createStatusEffect(StatusEffects.LifestealEnchantment,5,0,0,0);
		outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + (player.HP < player.maxOverHP() ? "wounds":"skin pores") + ". Blood starts to gather around weapons, adding a crimson glow.\n\n");
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		statScreenRefresh();
		enemyAI();
	}
	
	public function spellBloodField():void {
		clearOutput();
		HPChange(-spellCostBlood(600), false);
		player.createStatusEffect(StatusEffects.BloodField,3,Math.round(player.maxOverHP() * 0.01),0,0);
		if(handleShell()){return;}
		outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + (player.HP < player.maxOverHP() ? "wounds":"skin pores") + ". Blood starts to gather before your chest, coalescing into a crimson sphere. ");
		outputText("It roils as you concentrate on it before aim the orb at the ground, it brusts and seeps into it causing to appear a crimson field beneath your feet that start spread around until it cover large area. Additionaly small blood thorns grows from it imparing your enem" + (monster.plural ? "es":"y") + " movements.\n\n");
		if (!monster.isFlying()) monster.buff("BloodThorns").addStats({spe:-20}).withText("Blood Thorns").combatTemporary(3);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		statScreenRefresh();
		enemyAI();
	}

	public function spellMagicBolt():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		useMana(40, Combat.USEMANA_MAGIC);
		if(handleShell()){return;}
		spellMagicBolt2();
	}
	public function spellElementalBolt():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		useMana(80, Combat.USEMANA_MAGIC);
		if(handleShell()){return;}
		spellMagicBolt2();
	}
	public function spellEdgyMagicBolt():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		useMana(40, Combat.USEMANA_MAGIC);
		player.wrath -= 100;
		if(handleShell()){return;}
		spellMagicBolt2(true);
	}
	public function spellEdgyElementalBolt():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		useMana(80, Combat.USEMANA_MAGIC);
		player.wrath -= 100;
		if(handleShell()){return;}
		spellMagicBolt2(true);
	}
	public function spellMagicBolt2(edgy:Boolean = false):void {
		outputText("You narrow your eyes, focusing your mind with deadly intent.  ");
		if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponSpecials("Staff")) outputText("You point your staff and shots magic bolt toward [themonster]!\n\n");
		else outputText("You point your hand toward [themonster] and shots magic bolt!\n\n");
		var damage:Number = scalingBonusIntelligence() * spellMod() * 1.2;
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponSpecials("Staff")) {
			if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
			else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
			else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
			else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
			else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
		}
		if (player.hasPerk(PerkLib.ElementalBolt)) damage *= 1.25;
		if (edgy) damage *= 2;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		outputText(monster.capitalA + monster.short + " takes ");
		doMagicDamage(damage, true, true);
		outputText(" damage.");
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		MagicAddonEffect();
		outputText("\n\n");
		checkAchievementDamage(damage);
		if (edgy) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if (player.hasPerk(PerkLib.ElementalBolt)) {
			if (player.hasStatusEffect(StatusEffects.CounterEclipsingShadow)) {
				if (player.hasPerk(PerkLib.EclipsingShadowSu)) player.addStatusValue(StatusEffects.CounterEclipsingShadow, 1, 2);
				else if (player.hasPerk(PerkLib.EclipsingShadowEx)) player.addStatusValue(StatusEffects.CounterEclipsingShadow, 1, 3);
				player.addStatusValue(StatusEffects.CounterEclipsingShadow, 1, 4);
			}
			if (player.hasStatusEffect(StatusEffects.CounterGlacialStorm)) {
				if (player.hasPerk(PerkLib.GlacialStormSu)) player.addStatusValue(StatusEffects.CounterGlacialStorm, 1, 2);
				else if (player.hasPerk(PerkLib.GlacialStormEx)) player.addStatusValue(StatusEffects.CounterGlacialStorm, 1, 3);
				player.addStatusValue(StatusEffects.CounterGlacialStorm, 1, 4);
			}
			if (player.hasStatusEffect(StatusEffects.CounterHighVoltage)) {
				if (player.hasPerk(PerkLib.HighVoltageSu)) player.addStatusValue(StatusEffects.CounterHighVoltage, 1, 2);
				else if (player.hasPerk(PerkLib.HighVoltageEx)) player.addStatusValue(StatusEffects.CounterHighVoltage, 1, 3);
				player.addStatusValue(StatusEffects.CounterHighVoltage, 1, 4);
			}
			if (player.hasStatusEffect(StatusEffects.CounterRagingInferno)) {
				if (player.hasPerk(PerkLib.RagingInfernoSu)) player.addStatusValue(StatusEffects.CounterRagingInferno, 1, 2);
				else if (player.hasPerk(PerkLib.RagingInfernoEx)) player.addStatusValue(StatusEffects.CounterRagingInferno, 1, 3);
				player.addStatusValue(StatusEffects.CounterRagingInferno, 1, 4);
			}
		}
		if(monster.HP <= monster.minHP()) doNext(endHpVictory);
		else
		{
			if (monster is Lethice && (monster as Lethice).fightPhase == 3)
			{
				outputText("\n\n<i>“Ouch. Such arcane skills for one so uncouth,”</i> Lethice growls. With a snap of her fingers, a pearlescent dome surrounds her. <i>“How will you beat me without your magics?”</i>\n\n");
				monster.createStatusEffect(StatusEffects.Shell, 2, 0, 0, 0);
			}
			enemyAI();
		}
	}
	
	public function spellBoneSpirit():void {
		clearOutput();
		doNext(combatMenu);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		outputText("You wrap your soulforce around the bones and shape them into a horrifying bone wraith sending it flying and laughing madly toward [themonster]. The ghastly apparition explodes upon contact into a hundred sharp bone shards grievously wounding [themonster]. ");
		var damage:Number = scalingBonusIntelligence() * spellModBlack() * 3;
		if (player.hasPerk(PerkLib.Necromancy)) damage * 1.5;
		if (player.hasPerk(PerkLib.BoneSoul) && player.perkv1(PerkLib.PrestigeJobNecromancer) < 5) {
			var minus1:Number = player.perkv1(PerkLib.PrestigeJobNecromancer);
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, minus1);
			damage *= 0.5;
		}
		else player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, 5);
		if (player.hasPerk(PerkLib.BoneSoul) && player.perkv1(PerkLib.PrestigeJobNecromancer) >= 50) {
			var plus1:Number = player.perkv1(PerkLib.PrestigeJobNecromancer) * 0.1;
			plus1 = Math.round(plus1 - 0.5);
			damage *= (1 + (0.1*plus1));
		}
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		if (player.hasPerk(PerkLib.Omnicaster)) {
			if (player.hasPerk(MutationsLib.GazerEyeEvolved)) damage *= 0.5;
			else if (player.hasPerk(MutationsLib.GazerEyePrimitive)) damage *= 0.3;
			else damage *= 0.2;
			damage = Math.round(damage);
			doTrueDamage(damage, true, true);
			doTrueDamage(damage, true, true);
			doTrueDamage(damage, true, true);
			doTrueDamage(damage, true, true);
			doTrueDamage(damage, true, true);
			doTrueDamage(damage, true, true);
			if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 8) {
				doTrueDamage(damage, true, true);
				doTrueDamage(damage, true, true);
			}
			if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) {
				doTrueDamage(damage, true, true);
				doTrueDamage(damage, true, true);
			}
		}
		else doTrueDamage(damage, true, true);
		MagicAddonEffect();
		outputText("\n\n");
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}
	
	public function spellBoneArmor():void {
		clearOutput();
		doNext(combatMenu);
		var dura:Number = 5;
		outputText("You animate a set of bones to fly around you, deflecting incoming attacks.\n\n");
		if (player.hasPerk(PerkLib.BoneSoul) && player.perkv1(PerkLib.PrestigeJobNecromancer) < 10) {
			var minus2:Number = player.perkv1(PerkLib.PrestigeJobNecromancer);
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, minus2);
			dura -= 3;
		}
		else player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, 10);
		if (player.hasPerk(PerkLib.BoneSoul) && player.perkv1(PerkLib.PrestigeJobNecromancer) >= 50) {
			var plus2:Number = player.perkv1(PerkLib.PrestigeJobNecromancer) * 0.1;
			plus2 = Math.round(plus2 - 0.5);
			dura += plus2;
		}
		player.createStatusEffect(StatusEffects.BoneArmor,dura,0,0,0);
		player.createStatusEffect(StatusEffects.CooldownSpellBoneArmor,10,0,0,0);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}
	
	public function spellBoneshatter():void {
		clearOutput();
		doNext(combatMenu);
		var shatterIt:Number = 0.2;
		var damage:Number = scalingBonusIntelligence() * spellModBlack() * 1.5;
		if (player.hasPerk(PerkLib.Necromancy)) damage * 1.5;
		if (player.hasPerk(PerkLib.BoneSoul) && player.perkv1(PerkLib.PrestigeJobNecromancer) < 5) {
			var minus3:Number = player.perkv1(PerkLib.PrestigeJobNecromancer);
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, minus3);
			shatterIt *= 0.5;
			damage *= 0.5;
		}
		if (player.hasPerk(PerkLib.BoneSoul) && player.perkv1(PerkLib.PrestigeJobNecromancer) >= 50) {
			var plus3:Number = player.perkv1(PerkLib.PrestigeJobNecromancer) * 0.1;
			plus3 = Math.round(plus3 - 0.5);
			shatterIt *= (1 + (0.1*plus3));
			damage *= (1 + (0.1*plus3));
		}
		else player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, 5);
		if (player.hasPerk(PerkLib.Omnicaster)) {
			if (player.hasPerk(MutationsLib.GazerEyeEvolved)) damage *= 0.5;
			else if (player.hasPerk(MutationsLib.GazerEyePrimitive)) damage *= 0.3;
			else damage *= 0.2;
			damage = Math.round(damage);
			doTrueDamage(damage, true, true);
			doTrueDamage(damage, true, true);
			doTrueDamage(damage, true, true);
			doTrueDamage(damage, true, true);
			doTrueDamage(damage, true, true);
			doTrueDamage(damage, true, true);
			if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 8) {
				doTrueDamage(damage, true, true);
				doTrueDamage(damage, true, true);
			}
			if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) {
				doTrueDamage(damage, true, true);
				doTrueDamage(damage, true, true);
			}
		}
		else doTrueDamage(damage, true, true);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage);
		outputText("You channel your powers in [themonster] bone structure stressing it and forcing the bones to snap. [Themonster] cough blood you wreck [monster his] from the inside. ");
		doTrueDamage(damage, true, true);
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		MagicAddonEffect();
		outputText("\n\n");
		if (monster.hasStatusEffect(StatusEffects.Boneshatter)) {
			if (monster.statusEffectv1(StatusEffects.Boneshatter) < 0.9) {
				if (monster.statusEffectv1(StatusEffects.Boneshatter) + shatterIt > 0.9) {
					var shatterIt2:Number = (monster.statusEffectv1(StatusEffects.Boneshatter) + shatterIt) - 0.9;
					shatterIt -= shatterIt2;
					monster.addStatusValue(StatusEffects.Boneshatter, 1, shatterIt);
					monster.buff("Boneshatter").addStats({str:-(Math.round(shatterIt * monster.str))}).withText("Boneshatter").combatPermanent();
				}
				else {
					monster.addStatusValue(StatusEffects.Boneshatter, 1, shatterIt);
					monster.buff("Boneshatter").addStats({str:-(Math.round(shatterIt * monster.str))}).withText("Boneshatter").combatPermanent();
				}
			}
		}
		else if (!monster.hasStatusEffect(StatusEffects.Boneshatter)) {
			monster.createStatusEffect(StatusEffects.Boneshatter, shatterIt, 0, 0, 0);
			monster.buff("Boneshatter").addStats({str:-(Math.round(shatterIt * monster.str))}).withText("Boneshatter").combatPermanent();
		}
		player.createStatusEffect(StatusEffects.CooldownSpellBoneshatter,3,0,0,0);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}
	
	public function spellAegis():void {
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(500)) player.HP -= spellCostWhite(500);
		else useMana(500,Combat.USEMANA_WHITE);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		outputText("You call on divine protection in order to shield yourself against attacks."+(player.shield == ShieldLib.NOTHING ? " On your off-hand manifests a shield made of pure light, which will help deflect blows.":" Your shield begins to glow with white protective light, strengthening it as benevolent powers guide your hands, increasing your ability to block.")+"\n\n");
		var AegisDuration:Number = 6;
		AegisDuration += perkRelatedDurationBoosting();
		var aegismagnitude:Number = 0;
		if (spellModWhite() > 5) aegismagnitude += 5;
		else aegismagnitude += spellModWhite();
		if (player.inte / 50 > 5) aegismagnitude += 5;
		else aegismagnitude += player.inte / 25;
		if (player.hasPerk(PerkLib.DefensiveStaffChanneling)) aegismagnitude *= 1.1;
		if (player.isUsingStaff() && player.isNotHavingShieldCuzPerksNotWorkingOtherwise()) aegismagnitude *= 3;
		player.createStatusEffect(StatusEffects.Aegis,Math.round(aegismagnitude),AegisDuration,0,0);
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}
	
	public function spellExorcise():void {
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(400)) player.HP -= spellCostWhite(400);
		else useMana(400,Combat.USEMANA_WHITE);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		var damage:Number = scalingBonusIntelligence() * spellModBlack() * 4;
		if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.03));
        else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (2.5 + ((player.weaponAttack - 50) * 0.025));
        else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (3.75 + ((player.weaponAttack - 100) * 0.02));
        else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (4.75 + ((player.weaponAttack - 150) * 0.015));
        else damage *= (5.5 + ((player.weaponAttack - 200) * 0.01));
		if (player.hasPerk(PerkLib.DivineKnowledge) && monster.cor > 65) damage = Math.round(damage * 1.2);
		if (player.hasPerk(PerkLib.DivineArmament)) {
			if (monster.cor < 33) damage = Math.round(damage * 1.0);
			else if (monster.cor < 50) damage = Math.round(damage * 1.1);
			else if (monster.cor < 75) damage = Math.round(damage * 1.2);
			else if (monster.cor < 90) damage = Math.round(damage * 1.3);
			else damage = Math.round(damage * 1.4);
		}
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		player.createStatusEffect(StatusEffects.CooldownSpellExorcise,2,0,0,0);
		outputText("Your [weapon] begins to glow as you charge and deliver a mighty strike. As the mystical blow strikes your opponent"+(monster.plural ? "s":"")+", the magic explodes forward from your weapon in the shape of the sigil of the Marethian divine pantheon, damaging your foe"+(monster.plural ? "s":"")+" further and throwing [monster him] back.");
		doMagicDamage(damage, true, true);
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}
	
	public function spellDivineShield():void {
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(600)) player.HP -= spellCostWhite(600);
		else useMana(600,Combat.USEMANA_WHITE);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		outputText("You usher a prayer for protection from the dark spells cast by the heretics and a powerful bubble of raw energy encases you, deflecting most of the magical assaults away.\n\n");
		var DivineShieldDuration:Number = 6;
		DivineShieldDuration += perkRelatedDurationBoosting();
		player.createStatusEffect(StatusEffects.DivineShield,40,DivineShieldDuration,0,0);
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}
	
	public function spellThunderstorm():void {
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(1200)) player.HP -= spellCostWhite(1200);
		else useMana(1200,Combat.USEMANA_WHITE);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		var damage:Number = scalingBonusIntelligence() * spellModWhite() * 2;
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
		if (player.hasPerk(PerkLib.DivineKnowledge) && monster.cor > 65) damage = Math.round(damage * 1.2);
		if (player.hasPerk(PerkLib.DivineArmament)) {
			if (monster.cor < 33) damage = Math.round(damage * 1.0);
			else if (monster.cor < 50) damage = Math.round(damage * 1.1);
			else if (monster.cor < 75) damage = Math.round(damage * 1.2);
			else if (monster.cor < 90) damage = Math.round(damage * 1.3);
			else damage = Math.round(damage * 1.4);
		}
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		damage = Math.round(damage * combat.lightningDamageBoostedByDao());
		player.createStatusEffect(StatusEffects.Thunderstorm,damage,30,0,0);
		outputText("You call upon the anger of the gods to smite your foe and they gladly answer with thunder. Lightning begins to strike down upon your opponent"+(monster.plural ? "s":"")+" with perfect precision.");
		doLightingDamage(damage, true, true);
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}
	
	public function spellTearsOfDenial():void {
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(3000)) player.HP -= spellCostWhite(3000);
		else useMana(3000,Combat.USEMANA_WHITE);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		outputText("You call on the power of mercy in order to deny defeat. A small aura of magic shields your heart as your spell takes effect, ready to safeguard your victory.\n\n");
		player.createStatusEffect(StatusEffects.TearsOfDenial,1,0,0,0);
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}
	/*public function spell2IceRain():void {
		if (rand(2) == 0) flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		else flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200)) player.HP -= spellCost(200);
		else useMana(200,1);
		if(handleShell()){return;}
		//if (monster is Doppleganger)
		//{
		//(monster as Doppleganger).handleSpellResistance("whitefire");
		//flags[kFLAGS.SPELLS_CAST]++;
		//if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		//spellPerkUnlock();
		//return;
		//}
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You narrow your eyes, focusing on the force of your lust and willpower as you narrow your eyes with deadly intent. A dark cloud coalesces above you, stretching further until there is nothing but an eerie darkness above you. You narrow your gaze at  [themonster] as countless razor-like shards of ice rain upon your opponent.\n");
		var damage:Number = scalingBonusIntelligence() * spellMod() * spellModGrey();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//High damage to goes.
		damage = calcGlacialMod(damage);
		if (combat.wearingWinterScarf()) damage *= 1.2;
		if (player.armor == armors.BLIZZ_K) damage *= 1.5;
		if (player.headJewelry == headjewelries.SNOWFH) damage *= 1.3;
		damage = Math.round(damage * combat.iceDamageBoostedByDao());
		//if (monster.short == "goo-girl") damage = Math.round(damage * 1.5); - pomyśleć czy bedą dostawać bonusowe obrażenia
		//if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2); - tak samo przemyśleć czy bedą dodatkowo ranione
		if (monster.plural) damage *= 5;
		outputText(monster.capitalA + monster.short + " takes ");
		if (player.hasPerk(PerkLib.Omnicaster)) {
			if (player.hasPerk(MutationsLib.GazerEyeEvolved)) damage *= 0.5;
			else if (player.hasPerk(MutationsLib.GazerEyePrimitive)) damage *= 0.3;
			else damage *= 0.2;
			damage = Math.round(damage);
			doIceDamage(damage, true, true);
			doIceDamage(damage, true, true);
			doIceDamage(damage, true, true);
			doIceDamage(damage, true, true);
			doIceDamage(damage, true, true);
			doIceDamage(damage, true, true);
			if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 8) {
				doIceDamage(damage, true, true);
				doIceDamage(damage, true, true);
			}
			if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) {
				doIceDamage(damage, true, true);
				doIceDamage(damage, true, true);
			}
		}
		else doIceDamage(damage, true, true);
		if (!monster.hasPerk(PerkLib.EnemyGroupType) && !monster.hasPerk(PerkLib.EnemyLargeGroupType) && player.hasPerk(PerkLib.Convergence)) {
			if (player.hasPerk(PerkLib.Omnicaster)) {
				if (player.hasPerk(MutationsLib.GazerEyeEvolved)) damage *= 0.5;
				else if (player.hasPerk(MutationsLib.GazerEyePrimitive)) damage *= 0.3;
				else damage *= 0.2;
				damage = Math.round(damage);
				doIceDamage(damage, true, true);
				doIceDamage(damage, true, true);
				doIceDamage(damage, true, true);
				doIceDamage(damage, true, true);
				doIceDamage(damage, true, true);
				doIceDamage(damage, true, true);
				if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 8) {
					doIceDamage(damage, true, true);
					doIceDamage(damage, true, true);
				}
				if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) {
					doIceDamage(damage, true, true);
					doIceDamage(damage, true, true);
				}
			}
			else doIceDamage(damage, true, true);
			if (player.hasPerk(PerkLib.Omnicaster)) {
				if (player.hasPerk(MutationsLib.GazerEyeEvolved)) damage *= 0.5;
				else if (player.hasPerk(MutationsLib.GazerEyePrimitive)) damage *= 0.3;
				else damage *= 0.2;
				damage = Math.round(damage);
				doIceDamage(damage, true, true);
				doIceDamage(damage, true, true);
				doIceDamage(damage, true, true);
				doIceDamage(damage, true, true);
				doIceDamage(damage, true, true);
				doIceDamage(damage, true, true);
				if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 8) {
					doIceDamage(damage, true, true);
					doIceDamage(damage, true, true);
				}
				if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) {
					doIceDamage(damage, true, true);
					doIceDamage(damage, true, true);
				}
			}
			else doIceDamage(damage, true, true);
		}
		outputText(" damage.");
		//Using fire attacks on the goo]
		//if(monster.short == "goo-girl") {
		//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
		//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		//}
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		MagicAddonEffect();
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		if (!monster.hasPerk(PerkLib.EnemyGroupType) && !monster.hasPerk(PerkLib.EnemyLargeGroupType) && player.hasPerk(PerkLib.Convergence)) damage *= 3;
		if (player.hasPerk(PerkLib.Omnicaster)) damage *= omnicasterMutliForReflectDmgAndAchievments();
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if(monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}*/

	/*public function spell2FireStorm():void {
		if (rand(2) == 0) flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		else flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200)) player.HP -= spellCost(200);
		else useMana(200,1);
		if(handleShell()){return;}
		//if (monster is Doppleganger)
		//{
		//(monster as Doppleganger).handleSpellResistance("whitefire");
		//flags[kFLAGS.SPELLS_CAST]++;
		//if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		//spellPerkUnlock();
		//return;
		//}
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You narrow your eyes, focusing your own lust and willpower with a deadly intent. You cojure a small vortex of embers that expand into a vicious gout of flames.  With a single thought, you send a pillar of flames at [themonster]. You intend to leave nothing but ashes!\n");
		var damage:Number = scalingBonusIntelligence() * spellMod() * spellModGrey();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//High damage to goes.
		damage = calcInfernoMod(damage);
		if (player.armor == armors.BLIZZ_K) damage *= 0.5;
		if (player.headJewelry == headjewelries.SNOWFH) damage *= 0.7;
		if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2);
		if (monster.plural) damage *= 5;
		damage = Math.round(damage * combat.fireDamageBoostedByDao());
		outputText(monster.capitalA + monster.short + " takes ");
		if (player.hasPerk(PerkLib.Omnicaster)) {
			if (player.hasPerk(MutationsLib.GazerEyeEvolved)) damage *= 0.5;
			else if (player.hasPerk(MutationsLib.GazerEyePrimitive)) damage *= 0.3;
			else damage *= 0.2;
			damage = Math.round(damage);
			doFireDamage(damage, true, true);
			doFireDamage(damage, true, true);
			doFireDamage(damage, true, true);
			doFireDamage(damage, true, true);
			doFireDamage(damage, true, true);
			doFireDamage(damage, true, true);
			if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 8) {
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
			}
			if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) {
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
			}
		}
		else doFireDamage(damage, true, true);
		if (!monster.hasPerk(PerkLib.EnemyGroupType) && !monster.hasPerk(PerkLib.EnemyLargeGroupType) && player.hasPerk(PerkLib.Convergence)) {
			if (player.hasPerk(PerkLib.Omnicaster)) {
				if (player.hasPerk(MutationsLib.GazerEyeEvolved)) damage *= 0.5;
				else if (player.hasPerk(MutationsLib.GazerEyePrimitive)) damage *= 0.3;
				else damage *= 0.2;
				damage = Math.round(damage);
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
				if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 8) {
					doFireDamage(damage, true, true);
					doFireDamage(damage, true, true);
				}
				if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) {
					doFireDamage(damage, true, true);
					doFireDamage(damage, true, true);
				}
			}
			else doFireDamage(damage, true, true);
			if (player.hasPerk(PerkLib.Omnicaster)) {
				if (player.hasPerk(MutationsLib.GazerEyeEvolved)) damage *= 0.5;
				else if (player.hasPerk(MutationsLib.GazerEyePrimitive)) damage *= 0.3;
				else damage *= 0.2;
				damage = Math.round(damage);
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
				doFireDamage(damage, true, true);
				if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 8) {
					doFireDamage(damage, true, true);
					doFireDamage(damage, true, true);
				}
				if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) {
					doFireDamage(damage, true, true);
					doFireDamage(damage, true, true);
				}
			}
			else doFireDamage(damage, true, true);
		}
		outputText(" damage.");
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your fire storm lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if (crit) outputText(" <b>*Critical Hit!*</b>");
		MagicAddonEffect();
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		if (!monster.hasPerk(PerkLib.EnemyGroupType) && !monster.hasPerk(PerkLib.EnemyLargeGroupType) && player.hasPerk(PerkLib.Convergence)) damage *= 3;
		if (player.hasPerk(PerkLib.Omnicaster)) damage *= omnicasterMutliForReflectDmgAndAchievments();
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if(monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}*/
	
	public function spellManaShield(silent:Boolean = false):void {
		if (silent) {
			if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
			player.createStatusEffect(StatusEffects.ManaShield,0,0,0,0);
			statScreenRefresh();
			return;
		}
		clearOutput();
		outputText("Deciding you need additional protection during current fight you spend a moment to concentrate and form a barrier made of mana around you.  It will block attacks as long as you have enough mana to sustain it.\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		player.createStatusEffect(StatusEffects.ManaShield,0,0,0,0);
		enemyAI();
	}

	public function DeactivateManaShield():void {
		clearOutput();
		outputText("Deciding you no longer need to maintain your mana shield, you concentrate on deactivating it.\n\n");
		player.removeStatusEffect(StatusEffects.ManaShield);
		enemyAI();
	}
	
	public function spellClearMind():void {
		clearOutput();
		doNext(combatMenu);
		useMana(100, Combat.USEMANA_MAGIC_HEAL);
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
			outputText("As you incant the spell, you draw a small knife and cut your hand as the incantation ends, the jolt of pain clearing your mind and snapping you out of some of your lust.");
			HPChange(-(player.maxHP() * 0.01), false);
			if (player.hasStatusEffect(StatusEffects.IsabellaStunned)) player.removeStatusEffect(StatusEffects.IsabellaStunned);
			if (player.hasStatusEffect(StatusEffects.Stunned)) player.removeStatusEffect(StatusEffects.Stunned);
			if (player.hasStatusEffect(StatusEffects.Whispered)) player.removeStatusEffect(StatusEffects.Whispered);
			if (player.hasStatusEffect(StatusEffects.Confusion)) player.removeStatusEffect(StatusEffects.Confusion);
			if (player.hasStatusEffect(StatusEffects.Fear)) player.removeStatusEffect(StatusEffects.Fear);
		}
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.HP <= player.minHP()) doNext(endHpLoss);
		else enemyAI();
	}/*
	
	public function spellNosferatu():void {
		clearOutput();
		doNext(combatMenu);
		useMana(50, 9);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		outputText("You focus on your magic, trying to draw on it without enhancing your own arousal.\n");
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
			var nosferatu:Number = 0;
			nosferatu += player.inte;
			nosferatu += scalingBonusIntelligence();
			if (player.hasPerk(PerkLib.WisenedHealer)) nosferatu += scalingBonusWisdom();
			nosferatu = Math.round(nosferatu * healMod() * spellModGrey());
			outputText(" You chant as your shadow suddenly takes on a life of its own, sprouting a multitude of mouths and tentacles which seek and tear into [themonster] shadow");
			if (monster.plural) outputText("s");
			outputText(", gorging on its owner’s life force to replenish your own. Soon enough the spell is over and your shadow returns to you, leaving you better for the wear. <b>(<font color=\"#800000\">" + nosferatu + "</font>)</b>");
			monster.HP -= nosferatu;
			HPChange(nosferatu,false);
			MagicAddonEffect();
		}
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}*/
	
//(35) Energy Drain
	public function spellEnergyDrain():void {
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(350)) player.HP -= spellCost(350);
		else useMana(350, Combat.USEMANA_MAGIC);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		//30% backfire!
		var backfire:int = 30;
		if (player.hasStatusEffect(StatusEffects.AlvinaTraining)) backfire -= 10;
		if (player.hasPerk(PerkLib.FocusedMind)) backfire -= 10;
		backfire -= (player.inte * 0.15);
		if (backfire < 5 && player.hasPerk(PerkLib.FocusedMind)) backfire = 5;
		else if (backfire < 15) backfire = 15;
		if(rand(100) < backfire) {
			outputText(" An errant sexual thought crosses your mind, and you lose control of the spell!  Your ");
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
			outputText("You point at [themonster] and with a sharp pulling gesture you rip out some of their vigor for your own use. They won’t be hitting at full strength for a while.");
			monster.createStatusEffect(StatusEffects.EnergyDrain, 7, 0, 0, 0);
			var energydrain:Number = monster.maxMana() * 0.2;
			if (energydrain > spellCost(1400)) energydrain = spellCost(1400);
			EngineCore.ManaChange(Math.round(energydrain), false);
		}
		outputText("\n\n");
		player.createStatusEffect(StatusEffects.CooldownSpellEnergyDrain,7,0,0,0);
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}
	
//(35) Restore
	public function spellRestore():void {
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(350)) player.HP -= spellCost(80);
		else useMana(80, Combat.USEMANA_MAGIC_HEAL);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		//30% backfire!
		var backfire:int = 30;
		if (player.hasStatusEffect(StatusEffects.AlvinaTraining)) backfire -= 10;
		if (player.hasPerk(PerkLib.FocusedMind)) backfire -= 10;
		backfire -= (player.inte * 0.15);
		if (backfire < 5 && player.hasPerk(PerkLib.FocusedMind)) backfire = 5;
		else if (backfire < 15) backfire = 15;
		if(rand(100) < backfire) {
			outputText(" An errant sexual thought crosses your mind, and you lose control of the spell!  Your ");
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
			if (player.hasStatusEffect(StatusEffects.PlayerRegenerate)) player.addStatusValue(StatusEffects.PlayerRegenerate,1,7);
			else player.createStatusEffect(StatusEffects.PlayerRegenerate,7,0,0,0);
			outputText(" As you incant the spell, your wounds begins to close as if they never existed and you feel rejuvenated ready from battle! ");
			CombatAbilities.Heal.doEffect(false);
		}
		outputText("\n\n");
		player.createStatusEffect(StatusEffects.CooldownSpellRestore,8,0,0,0);
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}

//(35) Balance of Life
	public function spellBalanceOfLife():void {
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(500)) player.HP -= spellCost(500);
		else useMana(500,Combat.USEMANA_MAGIC);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		player.createStatusEffect(StatusEffects.CooldownSpellBalanceOfLife,8,0,0,0);
		outputText("A red aura envelop you as you begin converting some of your destructive magic to healing.\n\n");
		var durationBalanceOfLife:Number = 4;
		if (player.hasPerk(PerkLib.DefensiveStaffChanneling)) durationBalanceOfLife *= 1.1;
		player.createStatusEffect(StatusEffects.BalanceOfLife,Math.round(durationBalanceOfLife),0,0,0);
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}


	private function handleShell():Boolean{
        if(monster.hasStatusEffect(StatusEffects.Shell)) {
            outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
            flags[kFLAGS.SPELLS_CAST]++;
            if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
            spellPerkUnlock();
            enemyAI();
            return true;
        }
		return false;
	}
}
}
