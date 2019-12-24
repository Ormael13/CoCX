/**
 * Coded by aimozg on 30.05.2017.
 */
package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.Items.HeadJewelryLib;
import classes.Items.JewelryLib;
import classes.PerkLib;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.Areas.GlacialRift.FrostGiant;
import classes.Scenes.Areas.Tundra.YoungFrostGiant;
import classes.Scenes.Dungeons.D3.Doppleganger;
import classes.Scenes.Dungeons.D3.JeanClaude;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.D3.LivingStatue;
import classes.Scenes.NPCs.Diva;
import classes.Scenes.NPCs.Holli;
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.VaginaClass;

import coc.view.ButtonData;
import coc.view.ButtonDataList;

public class CombatMagic extends BaseCombatContent {
	public function CombatMagic() {
	}
	internal function applyAutocast():void {
		outputText("\n\n");
		if (player.hasPerk(PerkLib.Spellsword) && player.lust < getWhiteMagicLustCap() && player.mana >= (spellCostWhite(30) * spellChargeWeaponCostMultiplier()) && flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] == 0 && player.weaponName != "fists") {
			spellChargeWeapon(true);
			useMana((30 * spellChargeWeaponCostMultiplier()),5);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			outputText("<b>Charge Weapon was autocasted succesfully.</b>\n\n");
		}
		if (player.hasPerk(PerkLib.Spellarmor) && player.lust < getWhiteMagicLustCap() && player.mana >= (spellCostWhite(40) * spellChargeArmorCostMultiplier()) && flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] == 0 && !player.isNaked()) {
			spellChargeArmor(true);
			useMana((40 * spellChargeArmorCostMultiplier()),5);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			outputText("<b>Charge Armor was autocasted succesfully.</b>\n\n");
		}
		if (player.hasPerk(PerkLib.Battlemage) && ((player.hasPerk(PerkLib.GreyMage) && player.lust >= 30) || player.lust >= 50) && player.mana >= (spellCostBlack(50) * spellMightCostMultiplier()) && flags[kFLAGS.AUTO_CAST_MIGHT] == 0) {
			spellMight(true);
			useMana((50 * spellMightCostMultiplier()),6);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			outputText("<b>Might was autocasted succesfully.</b>\n\n");
		}
		if (player.hasPerk(PerkLib.Battleflash) && ((player.hasPerk(PerkLib.GreyMage) && player.lust >= 30) || player.lust >= 50) && player.mana >= (spellCostBlack(40) * spellBlinkCostMultiplier()) && flags[kFLAGS.AUTO_CAST_BLINK] == 0) {
			spellBlink(true);
			useMana((40 * spellBlinkCostMultiplier()),6);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			outputText("<b>Blink was autocasted succesfully.</b>\n\n");
		}
		if (player.hasPerk(PerkLib.Battleshield) && (player.lust >= 50 || player.lust < (player.maxLust() - 49)) && flags[kFLAGS.AUTO_CAST_MANA_SHIELD] == 0) {
			spellManaShield(true);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			outputText("<b>Mana Shield was autocasted succesfully.</b>\n\n");
		}
	}
	internal function cleanupAfterCombatImpl():void {
		fireMagicLastTurn = -100;
		iceMagicLastTurn = -100;
		lightningMagicLastTurn = -100;
		darknessMagicLastTurn = -100;
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
		if(player.hasPerk(PerkLib.BloodMage) && costPercent < 50) costPercent = 50;
		mod *= costPercent/100;
		if (player.hasPerk(PerkLib.BloodMage) && mod < 5) mod = 5;
		else if(mod < 2) mod = 2;
		mod = Math.round(mod * 100)/100;
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
		mod *= costPercent/100;
		if (mod < 5) mod = 5;
		mod = Math.round(mod * 100)/100;
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
		if(player.hasPerk(PerkLib.BloodMage) && costPercent < 50) costPercent = 50;
		mod *= costPercent/100;
		if (player.hasPerk(PerkLib.BloodMage) && mod < 5) mod = 5;
		else if(mod < 2) mod = 2;
		mod = Math.round(mod * 100)/100;
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
		mod *= costPercent/100;
		if (mod < 5) mod = 5;
		mod = Math.round(mod * 100)/100;
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
		if(player.hasPerk(PerkLib.BloodMage) && costPercent < 50) costPercent = 50;
		mod *= costPercent/100;
		if (player.hasPerk(PerkLib.BloodMage) && mod < 5) mod = 5;
		else if(mod < 2) mod = 2;
		mod = Math.round(mod * 100)/100;
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
		mod *= costPercent/100;
		if (mod < 5) mod = 5;
		mod = Math.round(mod * 100)/100;
		return mod;
	}

	internal function spellModImpl():Number {
		var mod:Number = 1;
		if(player.hasPerk(PerkLib.Archmage) && player.inte >= 100) mod += .3;
		if(player.hasPerk(PerkLib.Channeling) && player.inte >= 60) mod += .2;
		if(player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 125) mod += .4;
		if(player.hasPerk(PerkLib.GrandArchmage2ndCircle) && player.inte >= 150) mod += .5;
		if(player.hasPerk(PerkLib.GrandArchmage3rdCircle) && player.inte >= 175) mod += .6;
		if(player.hasPerk(PerkLib.GrandMage) && player.inte >= 75) mod += .2;
		if(player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 275) mod += 1;
		if(player.hasPerk(PerkLib.GreyMage) && player.inte >= 225) mod += .8;
		if(player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) mod += .1;
		if(player.hasPerk(PerkLib.PrestigeJobGreySage)) mod += .2;
		if(player.hasPerk(PerkLib.Mage) && player.inte >= 50) mod += .1;
		if(player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) mod += .1;
		if(player.hasPerk(PerkLib.TraditionalMageI) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageII) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageIII) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageIV) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageV) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageVI) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.Obsession)) {
			mod += player.perkv1(PerkLib.Obsession);
		}
		if(player.hasPerk(PerkLib.Ambition)) {
			mod += player.perkv1(PerkLib.Ambition);
		}
		if(player.hasPerk(PerkLib.WizardsFocus)) {
			mod += player.perkv1(PerkLib.WizardsFocus);
		}
		if(player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) {
			mod += player.perkv1(PerkLib.WizardsAndDaoistsFocus);
		}
		if(player.hasPerk(PerkLib.SagesKnowledge)) {
			mod += player.perkv1(PerkLib.SagesKnowledge);
		}
		if (player.hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId2 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId3 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId4 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.countCockSocks("blue") > 0) mod += (player.countCockSocks("blue") * .05);
		if (player.hasPerk(PerkLib.AscensionMysticality)) mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
		if (player.hasPerk(PerkLib.SeersInsight)) mod += player.perkv1(PerkLib.SeersInsight);
		if (player.shield == shields.SPI_FOC) mod += .2;
		if (player.shield == shields.MABRACE) mod += .5;
		if (player.weapon == weapons.N_STAFF) mod += player.cor * .01;
		if (player.weapon == weapons.U_STAFF) mod += (100 - player.cor) * .01;
		if (player.hasStatusEffect(StatusEffects.Maleficium)) {
			if (player.hasPerk(PerkLib.ObsidianHeartEvolved)) {
				if (player.hasPerk(PerkLib.ObsidianHeartFinalForm)) mod += 2.5;
				else mod += 1.25;
			}
			else mod += 1;
		}
		if (player.weapon == weapons.B_STAFF) {
			var mod1:Number = 0.4;
			mod1 -= player.cor / 10;
			if (mod1 < 0.1) mod1 = 0.1;
			mod += mod1;
		}
		if (player.weapon == weapons.PURITAS) mod *= 1.6;
		if (player.weapon == weapons.DEPRAVA) mod *= 1.6;
		if (player.weapon == weapons.ASCENSU) mod *= 1.8;
		mod = Math.round(mod * 100)/100;
		return mod;
	}
	internal function spellGreyCooldownImpl():Number {
		var mod:Number = 3;
		if (mod < 0) mod = 0;
		return mod;
	}
	internal function healModImpl():Number {
		var mod:Number = 1;
		if(player.hasPerk(PerkLib.SpellpowerHealing) && player.wis >= 50) mod += .2;
		if(player.hasPerk(PerkLib.NaturalHealingMinor)) mod += .3;
		if(player.hasPerk(PerkLib.NaturalHealingMajor)) mod += .4;
		if(player.hasPerk(PerkLib.NaturalHealingEpic)) mod += .5;
		if(player.hasPerk(PerkLib.NaturalHealingLegendary)) mod += .6;
		if(player.hasPerk(PerkLib.Obsession)) {
			mod += player.perkv1(PerkLib.Obsession);
		}
		if(player.hasPerk(PerkLib.Ambition)) {
			mod += player.perkv1(PerkLib.Ambition);
		}
		if(player.hasPerk(PerkLib.WizardsFocus)) {
			mod += player.perkv1(PerkLib.WizardsFocus);
		}
		if(player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) {
			mod += player.perkv1(PerkLib.WizardsAndDaoistsFocus);
		}
		if(player.hasPerk(PerkLib.SagesKnowledge)) {
			mod += player.perkv1(PerkLib.SagesKnowledge);
		}
		if (player.hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId2 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId3 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId4 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
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
		if (player.weapon == weapons.ASCENSU) mod *= 1.8;
		mod = Math.round(mod * 100)/100;
		return mod;
	}
	internal function spellModWhiteImpl():Number {
		var mod:Number = 1;
		if(player.hasPerk(PerkLib.Archmage) && player.inte >= 100) mod += .3;
		if(player.hasPerk(PerkLib.Channeling) && player.inte >= 60) mod += .2;
		if(player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 125) mod += .4;
		if(player.hasPerk(PerkLib.GrandArchmage2ndCircle) && player.inte >= 150) mod += .5;
		if(player.hasPerk(PerkLib.GrandArchmage3rdCircle) && player.inte >= 175) mod += .6;
		if(player.hasPerk(PerkLib.GrandMage) && player.inte >= 75) mod += .2;
		if(player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 275) mod += 1;
		if(player.hasPerk(PerkLib.GreyMage) && player.inte >= 225) mod += .8;
		if(player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) mod += .1;
		if(player.hasPerk(PerkLib.PrestigeJobGreySage)) mod += .2;
		if(player.hasPerk(PerkLib.Mage) && player.inte >= 50) mod += .1;
		if(player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) mod += .1;
		if(player.hasPerk(PerkLib.TraditionalMageI) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageII) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageIII) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageIV) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageV) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageVI) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.Ambition)) {
			mod += player.perkv2(PerkLib.Ambition);
		}
		if(player.hasStatusEffect(StatusEffects.BlessingOfDivineMarae)) {
			mod += player.statusEffectv2(StatusEffects.BlessingOfDivineMarae);
		}
		if(player.hasPerk(PerkLib.WizardsFocus)) {
			mod += player.perkv1(PerkLib.WizardsFocus);
		}
		if(player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) {
			mod += player.perkv1(PerkLib.WizardsAndDaoistsFocus);
		}
		if(player.hasPerk(PerkLib.SagesKnowledge)) {
			mod += player.perkv1(PerkLib.SagesKnowledge);
		}
		if (player.hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
		if (player.hasPerk(PerkLib.AvatorOfPurity)) mod += .2;
		if (player.hasPerk(PerkLib.UnicornBlessing) && player.cor <= 20) mod += .2;
		if (player.hasPerk(PerkLib.HexKnowledge)) mod -= .4;
		if (player.hasKeyItem("Holy Symbol") >= 0) mod += .2;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId2 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId3 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId4 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.countCockSocks("blue") > 0) mod += (player.countCockSocks("blue") * .05);
		if (player.hasPerk(PerkLib.AscensionMysticality)) mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
		if (player.hasPerk(PerkLib.SeersInsight)) mod += player.perkv1(PerkLib.SeersInsight);
		if (player.shield == shields.SPI_FOC) mod += .2;
		if (player.shield == shields.MABRACE) mod += .5;
		if (player.weapon == weapons.N_STAFF) mod += player.cor * .01;
		if (player.weapon == weapons.U_STAFF) mod += (100 - player.cor) * .01;
		if (player.hasStatusEffect(StatusEffects.Maleficium)) {
			if (player.hasPerk(PerkLib.ObsidianHeartEvolved)) {
				if (player.hasPerk(PerkLib.ObsidianHeartFinalForm)) mod += 2.5;
				else mod += 1.25;
			}
			else mod += 1;
		}
		if (player.weapon == weapons.B_STAFF) {
			var mod1:Number = 0.4;
			mod1 -= player.cor / 10;
			if (mod1 < 0.1) mod1 = 0.1;
			mod += mod1;
		}
		if (player.weapon == weapons.PURITAS) mod *= 1.6;
		if (player.weapon == weapons.ASCENSU) mod *= 1.8;
		mod = Math.round(mod * 100)/100;
		return mod;
	}
	internal function spellWhiteCooldownImpl():Number {
		var mod:Number = 3;
		if (player.hasPerk(PerkLib.AvatorOfPurity)) mod -= 1;
		if (mod < 0) mod = 0;
		return mod;
	}
	internal function healModWhiteImpl():Number {
		var mod:Number = 1;
		if(player.hasPerk(PerkLib.SpellpowerHealing) && player.wis >= 50) mod += .2;
		if(player.hasPerk(PerkLib.NaturalHealingMinor)) mod += .3;
		if(player.hasPerk(PerkLib.NaturalHealingMajor)) mod += .4;
		if(player.hasPerk(PerkLib.NaturalHealingEpic)) mod += .5;
		if(player.hasPerk(PerkLib.NaturalHealingLegendary)) mod += .6;
		if(player.hasPerk(PerkLib.Ambition)) {
			mod += player.perkv2(PerkLib.Ambition);
		}
		if(player.hasStatusEffect(StatusEffects.BlessingOfDivineMarae)) {
			mod += player.statusEffectv2(StatusEffects.BlessingOfDivineMarae);
		}
		if(player.hasPerk(PerkLib.WizardsFocus)) {
			mod += player.perkv1(PerkLib.WizardsFocus);
		}
		if(player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) {
			mod += player.perkv1(PerkLib.WizardsAndDaoistsFocus);
		}
		if(player.hasPerk(PerkLib.SagesKnowledge)) {
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
		if (player.weapon == weapons.ASCENSU) mod *= 1.8;
		mod = Math.round(mod * 100)/100;
		return mod;
	}
	internal function spellModBlackImpl():Number {
		var mod:Number = 1;
		if(player.hasPerk(PerkLib.Archmage) && player.inte >= 100) mod += .3;
		if(player.hasPerk(PerkLib.Channeling) && player.inte >= 60) mod += .2;
		if(player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 125) mod += .4;
		if(player.hasPerk(PerkLib.GrandArchmage2ndCircle) && player.inte >= 150) mod += .5;
		if(player.hasPerk(PerkLib.GrandArchmage3rdCircle) && player.inte >= 175) mod += .6;
		if(player.hasPerk(PerkLib.GrandMage) && player.inte >= 75) mod += .2;
		if(player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 275) mod += 1;
		if(player.hasPerk(PerkLib.GreyMage) && player.inte >= 225) mod += .8;
		if(player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) mod += .1;
		if(player.hasPerk(PerkLib.PrestigeJobGreySage)) mod += .2;
		if(player.hasPerk(PerkLib.Mage) && player.inte >= 50) mod += .1;
		if(player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) mod += .1;
		if(player.hasPerk(PerkLib.TraditionalMageI) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageII) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageIII) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageIV) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageV) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.TraditionalMageVI) && player.isUsingStaff() && player.isUsingTome()) mod += 1;
		if(player.hasPerk(PerkLib.Obsession)) {
			mod += player.perkv2(PerkLib.Obsession);
		}
		if(player.hasPerk(PerkLib.WizardsFocus)) {
			mod += player.perkv1(PerkLib.WizardsFocus);
		}
		if(player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) {
			mod += player.perkv1(PerkLib.WizardsAndDaoistsFocus);
		}
		if(player.hasPerk(PerkLib.SagesKnowledge)) {
			mod += player.perkv1(PerkLib.SagesKnowledge);
		}
		if (player.hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
		if (player.hasPerk(PerkLib.AvatorOfCorruption)) mod += .3;
		if (player.hasPerk(PerkLib.BicornBlessing) && player.cor >= 80) mod += .2;
		if (player.hasPerk(PerkLib.HexKnowledge)) mod += .2;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId2 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId3 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId4 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.countCockSocks("blue") > 0) mod += (player.countCockSocks("blue") * .05);
		if (player.hasPerk(PerkLib.AscensionMysticality)) mod *= 1 + (player.perkv1(PerkLib.AscensionMysticality) * 0.1);
		if (player.hasPerk(PerkLib.SeersInsight)) mod += player.perkv1(PerkLib.SeersInsight);
		if (player.shield == shields.SPI_FOC) mod += .2;
		if (player.shield == shields.MABRACE) mod += .5;
		if (player.weapon == weapons.N_STAFF) mod += player.cor * .01;
		if (player.weapon == weapons.U_STAFF) mod += (100 - player.cor) * .01;
		if (player.hasStatusEffect(StatusEffects.Maleficium)) {
			if (player.hasPerk(PerkLib.ObsidianHeartEvolved)) {
				if (player.hasPerk(PerkLib.ObsidianHeartFinalForm)) mod += 2.5;
				else mod += 1.25;
			}
			else mod += 1;
		}
		if (player.weapon == weapons.B_STAFF) {
			var mod1:Number = 0.4;
			mod1 -= player.cor / 10;
			if (mod1 < 0.1) mod1 = 0.1;
			mod += mod1;
		}
		if (player.weapon == weapons.DEPRAVA) mod *= 1.6;
		if (player.weapon == weapons.ASCENSU) mod *= 1.8;
		mod = Math.round(mod * 100)/100;
		return mod;
	}
	internal function spellBlackCooldownImpl():Number {
		var mod:Number = 3;
		if (player.hasPerk(PerkLib.AvatorOfCorruption)) mod -= 1;
		if (mod < 0) mod = 0;
		return mod;
	}
	internal function healModBlackImpl():Number {
		var mod:Number = 1;
		if(player.hasPerk(PerkLib.SpellpowerHealing) && player.wis >= 50) mod += .2;
		if(player.hasPerk(PerkLib.NaturalHealingMinor)) mod += .3;
		if(player.hasPerk(PerkLib.NaturalHealingMajor)) mod += .4;
		if(player.hasPerk(PerkLib.NaturalHealingEpic)) mod += .5;
		if(player.hasPerk(PerkLib.NaturalHealingLegendary)) mod += .6;
		if(player.hasPerk(PerkLib.Obsession)) {
			mod += player.perkv2(PerkLib.Obsession);
		}
		if(player.hasPerk(PerkLib.WizardsFocus)) {
			mod += player.perkv1(PerkLib.WizardsFocus);
		}
		if(player.hasPerk(PerkLib.WizardsAndDaoistsFocus)) {
			mod += player.perkv1(PerkLib.WizardsAndDaoistsFocus);
		}
		if(player.hasPerk(PerkLib.SagesKnowledge)) {
			mod += player.perkv1(PerkLib.SagesKnowledge);
		}
		if (player.hasPerk(PerkLib.ChiReflowMagic)) mod += UmasShop.NEEDLEWORK_MAGIC_SPELL_MULTI;
		if (player.hasPerk(PerkLib.AvatorOfCorruption)) mod += .3;
		if (player.hasPerk(PerkLib.BicornBlessing) && player.cor >= 80) mod += .2;
		if (player.jewelryEffectId == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId2 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId3 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
		if (player.jewelryEffectId4 == JewelryLib.MODIFIER_SPELL_POWER) mod += (player.jewelryEffectMagnitude / 100);
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
		if (player.weapon == weapons.ASCENSU) mod *= 1.8;
		mod = Math.round(mod * 100)/100;
		return mod;
	}
	
	public function spellMightCostMultiplier():Number {
		var spellMightMultiplier:Number = 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) spellMightMultiplier *= 2;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) spellMightMultiplier *= 2;
		return spellMightMultiplier;
	}

	public function spellBlinkCostMultiplier():Number {
		var spellBlinkMultiplier:Number = 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) spellBlinkMultiplier *= 2;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) spellBlinkMultiplier *= 2;
		return spellBlinkMultiplier;
	}

	public function spellChargeWeaponCostMultiplier():Number {
		var spellChargeWeaponMultiplier:Number = 1;
		if (player.hasStatusEffect(StatusEffects.SiegweirdTraining)) spellChargeWeaponMultiplier *= 0.5;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) spellChargeWeaponMultiplier *= 2;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) spellChargeWeaponMultiplier *= 2;
		return spellChargeWeaponMultiplier;
	}

	public function spellChargeArmorCostMultiplier():Number {
		var spellChargeArmorMultiplier:Number = 1;
		if (player.hasStatusEffect(StatusEffects.SiegweirdTraining)) spellChargeArmorMultiplier *= 0.5;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) spellChargeArmorMultiplier *= 2;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) spellChargeArmorMultiplier *= 2;
		return spellChargeArmorMultiplier;
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


	private var fireMagicLastTurn:int = -100;
	private var fireMagicCumulated:int = 0;/*
	internal function calcInfernoModImpl(damage:Number):int {
		if (player.hasPerk(PerkLib.RagingInferno)) {
			var multiplier:Number = 1;
			if (combatRound - fireMagicLastTurn == 2) {
				if (fireMagicCumulated > 0) outputText("Traces of your previously used fire magic are still here, and you use them to empower another spell!\n\n");
				multiplier += fireMagicCumulated * 0.05;
				damage = Math.round(damage * multiplier);
				fireMagicCumulated += 2;
				//if (player.hasPerk(PerkLib.)) fireMagicCumulated++;
				//if (player.hasPerk(PerkLib.)) fireMagicCumulated++;
				// XXX: Message?
			} else {
				if (combatRound - fireMagicLastTurn > 2 && fireMagicCumulated > 0) {
					if (fireMagicLastTurn == 2) fireMagicCumulated = 0;
					else fireMagicCumulated -= 2;
				}
				if (fireMagicCumulated == 0) outputText("Unfortunately, traces of your previously used fire magic are too weak to be used.\n\n");
			}
			fireMagicLastTurn = combatRound;
		}
		return damage;
	}*/
	internal function calcInfernoModImpl(damage:Number):int {
		if (player.hasPerk(PerkLib.RagingInferno)) {
			var multiplier:Number = 1;
			if (combatRound - fireMagicLastTurn == 2) {
				outputText("Traces of your previously used fire magic are still here, and you use them to empower another spell!\n\n");
				switch(fireMagicCumulated) {
					case 0:
					case 1:
						multiplier = 1;
						break;
					case 2:
						multiplier = 1.2;
						break;
					case 3:
						multiplier = 1.35;
						break;
					case 4:
						multiplier = 1.45;
						break;
					default:
						multiplier = 1.5 + ((fireMagicCumulated - 5) * 0.05); //Diminishing returns at max, add 0.05 to multiplier.
				}
				damage = Math.round(damage * multiplier);
				fireMagicCumulated++;
				// XXX: Message?
			} else {
				if (combatRound - fireMagicLastTurn > 2 && fireMagicLastTurn > 0)
					outputText("Unfortunately, traces of your previously used fire magic are too weak to be used.\n\n");
				fireMagicCumulated = 1;
			}
			fireMagicLastTurn = combatRound;
		}
		return damage;
	}

	private var iceMagicLastTurn:int = -100;
	private var iceMagicCumulated:int = 0;
	internal function calcGlacialModImpl(damage:Number):int {
		if (player.hasPerk(PerkLib.GlacialStorm)) {
			var multiplier:Number = 1;
			if (combatRound - iceMagicLastTurn == 2) {
				outputText("Traces of your previously used ice magic are still here, and you use them to empower another spell!\n\n");
				switch(iceMagicCumulated) {
					case 0:
					case 1:
						multiplier = 1;
						break;
					case 2:
						multiplier = 1.2;
						break;
					case 3:
						multiplier = 1.35;
						break;
					case 4:
						multiplier = 1.45;
						break;
					default:
						multiplier = 1.5 + ((iceMagicCumulated - 5) * 0.05); //Diminishing returns at max, add 0.05 to multiplier.
				}
				damage = Math.round(damage * multiplier);
				iceMagicCumulated++;
				// XXX: Message?
			} else {
				if (combatRound - iceMagicLastTurn > 2 && iceMagicLastTurn > 0)
					outputText("Unfortunately, traces of your previously used ice magic are too weak to be used.\n\n");
				iceMagicCumulated = 1;
			}
			iceMagicLastTurn = combatRound;
		}
		return damage;
	}

	private var lightningMagicLastTurn:int = -100;
	private var lightningMagicCumulated:int = 0;
	internal function calcVoltageModImpl(damage:Number):int {
		if (player.hasPerk(PerkLib.HighVoltage)) {
			var multiplier:Number = 1;
			if (combatRound - lightningMagicLastTurn == 2) {
				outputText("Traces of your previously used lightning magic are still here, and you use them to empower another spell!\n\n");
				switch(lightningMagicCumulated) {
					case 0:
					case 1:
						multiplier = 1;
						break;
					case 2:
						multiplier = 1.2;
						break;
					case 3:
						multiplier = 1.35;
						break;
					case 4:
						multiplier = 1.45;
						break;
					default:
						multiplier = 1.5 + ((lightningMagicCumulated - 5) * 0.05); //Diminishing returns at max, add 0.05 to multiplier.
				}
				damage = Math.round(damage * multiplier);
				lightningMagicCumulated++;
				// XXX: Message?
			} else {
				if (combatRound - lightningMagicLastTurn > 2 && lightningMagicLastTurn > 0)
					outputText("Unfortunately, traces of your previously used lightning magic are too weak to be used.\n\n");
				lightningMagicCumulated = 1;
			}
			lightningMagicLastTurn = combatRound;
		}
		return damage;
	}

	private var darknessMagicLastTurn:int = -100;
	private var darknessMagicCumulated:int = 0;
	internal function calcEclypseModImpl(damage:Number):int {
		if (player.hasPerk(PerkLib.EclipsingShadow)) {
			var multiplier:Number = 1;
			if (combatRound - darknessMagicLastTurn == 2) {
				outputText("Traces of your previously used darkness magic are still here, and you use them to empower another spell!\n\n");
				switch(darknessMagicCumulated) {
					case 0:
					case 1:
						multiplier = 1;
						break;
					case 2:
						multiplier = 1.2;
						break;
					case 3:
						multiplier = 1.35;
						break;
					case 4:
						multiplier = 1.45;
						break;
					default:
						multiplier = 1.5 + ((darknessMagicCumulated - 5) * 0.05); //Diminishing returns at max, add 0.05 to multiplier.
				}
				damage = Math.round(damage * multiplier);
				darknessMagicCumulated++;
				// XXX: Message?
			} else {
				if (combatRound - darknessMagicLastTurn > 2 && darknessMagicLastTurn > 0)
					outputText("Unfortunately, traces of your previously used darkness magic are too weak to be used.\n\n");
				darknessMagicCumulated = 1;
			}
			darknessMagicLastTurn = combatRound;
		}
		return damage;
	}
	
	internal function buildMenu(buttons:ButtonDataList):void {
		var bd:ButtonData;
		
		var badLustForWhite:Boolean        = player.lust >= getWhiteMagicLustCap();
		var badLustForBlack:Boolean        = player.lust < getBlackMagicMinLust();
		var badLustForGrey:Boolean         = player.lust < 50 || player.lust > (player.maxLust() - 50);
		//Most basic spell ever ^^
		if (player.hasPerk(PerkLib.JobSorcerer)) {
			bd = buttons.add("M.Bolt", spellMagicBolt);
			if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponPerk == "Staff") bd.hint("Attempt to attack the enemy with magic bolt from your [weapon].  Damage done is determined by your intelligence and weapon.", "Magic Bolt");
			else bd.hint("Attempt to attack the enemy with magic bolt.  Damage done is determined by your intelligence.", "Magic Bolt");
			if (player.mana < spellCost(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			}
		}
		//WHITE SHITZ
		if (player.hasStatusEffect(StatusEffects.KnowsBlind)) {
			bd = buttons.add("Blind", spellBlind)
						.hint("Blind is a fairly self-explanatory spell.  It will create a bright flash just in front of the victim's eyes, blinding them for a time.  However if they blink it will be wasted.  " +
							  "\n\nMana Cost: " + spellCostWhite(30) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasPerk(PerkLib.HexKnowledge)) {
				bd.disable("Your chosen path of magic locked out this spell.");
			} else if (monster.hasStatusEffect(StatusEffects.Blind)) {
				bd.disable(monster.capitalA + monster.short + " is already affected by blind.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(30)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(30) && player.HP < spellCostWhite(30)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsWhitefire)) {
			bd = buttons.add("Whitefire", spellWhitefire)
						.hint("Whitefire is a potent fire based attack that will burn your foe with flickering white flames, ignoring their physical toughness and most armors.  " +
							  "\n\nMana Cost: " + spellCostWhite(40) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasPerk(PerkLib.HexKnowledge)) {
				bd.disable("Your chosen path of magic locked out this spell.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40) && player.HP < spellCostWhite(40)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellWhitefire)) {
				bd.disable("You need more time before you can cast Whitefire again.");
			}
			
		}
		if (player.hasStatusEffect(StatusEffects.KnowsLightningBolt)) {
			bd = buttons.add("LightningBolt", spellLightningBolt)
						.hint("Lightning Bolt is a basic lightning attack that will electrocute your foe with a single bolt of lightning.  " +
							  "\n\nMana Cost: " + spellCostWhite(40) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasPerk(PerkLib.HexKnowledge)) {
				bd.disable("Your chosen path of magic locked out this spell.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40) && player.HP < spellCostWhite(40)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellLightningBolt)) {
				bd.disable("You need more time before you can cast Lightning Bolt again.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsPyreBurst)) {
			bd = buttons.add("Pyre Burst", spellPyreBurst)
						.hint("Teach your foes a lesson with the strenght of a firestorm.  \n\n<b>AoE Spell.</b>  " +
							  "\n\nMana Cost: " + spellCostWhite(200) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasPerk(PerkLib.HexKnowledge)) {
				bd.disable("Your chosen path of magic locked out this spell.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(200)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40) && player.HP < spellCostWhite(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellPyreBurst)) {
				bd.disable("You need more time before you can cast Pyre Burst again.");
			}
			
		}
		if (player.hasStatusEffect(StatusEffects.KnowsChainLighting)) {
			bd = buttons.add("ChainLighting", spellChainLightning)
						.hint("Chain Lighting is a lightning attack that will electrocute your foes with a chain bolts of lightning.  \n\n<b>AoE Spell.</b>  " +
							  "\n\nMana Cost: " + spellCostWhite(200) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasPerk(PerkLib.HexKnowledge)) {
				bd.disable("Your chosen path of magic locked out this spell.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(200)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40) && player.HP < spellCostWhite(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellChainLighting)) {
				bd.disable("You need more time before you can cast Chain Lighting again.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsCharge)) {
			bd = buttons.add("Charge W.", spellChargeWeapon)
						.hint("The Charge Weapon spell will surround your weapon in electrical energy, causing it to do even more damage.  The effect lasts for a few combat turns.  " +
							  "\n\nMana Cost: " + spellCostWhite(30) * spellChargeWeaponCostMultiplier() + "", "Charge Weapon");
			if (player.weaponName == "fists" && !player.hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalWeapons)) {
				bd.disable("Charge weapon can't be casted on your own fists.");
			} else if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasPerk(PerkLib.HexKnowledge)) {
				bd.disable("Your chosen path of magic locked out this spell.");
			} else if (player.hasStatusEffect(StatusEffects.ChargeWeapon)){
				bd.disable("Charge weapon is already active and cannot be cast again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostWhite(30) * spellChargeWeaponCostMultiplier())) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostWhite(30) * spellChargeWeaponCostMultiplier()) && player.HP < (spellCostWhite(30) * spellChargeWeaponCostMultiplier())) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsChargeA)) {
			bd = buttons.add("Charge A.", spellChargeArmor)
						.hint("The Charge Armor spell will surround your armor with electrical energy, causing it to do provide additional protection.  The effect lasts for a few combat turns.  " +
							  "\n\nMana Cost: " + spellCostWhite(40) * spellChargeArmorCostMultiplier() + "", "Charge Armor");
			if (player.isNaked() && (!player.haveNaturalArmor() || player.hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor))) {
				bd.disable("Charge armor can't be casted without wearing any armor or even underwear.");
			} else if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasPerk(PerkLib.HexKnowledge)) {
				bd.disable("Your chosen path of magic locked out this spell.");
			} else if (player.hasStatusEffect(StatusEffects.ChargeArmor)) {
				bd.disable("Charge armor is already active and cannot be cast again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostWhite(40) * spellChargeArmorCostMultiplier())) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostWhite(40) * spellChargeArmorCostMultiplier()) && player.HP < (spellCostWhite(40) * spellChargeArmorCostMultiplier())) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsHeal)) {
			bd = buttons.add("Heal", spellHeal)
						.hint("Heal will attempt to use white magic to instnatly close your wounds and restore your body.  " +
							  "\n\nMana Cost: " + healCostWhite(30) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasPerk(PerkLib.HexKnowledge)) {
				bd.disable("Your chosen path of magic locked out this spell.");
			} else if(player.mana < healCostWhite(30)) {
				bd.disable("Your mana is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBlizzard)) {
			bd = buttons.add("Blizzard", spellBlizzard)
						.hint("Blizzard is a potent ice based defense spell that will reduce power of any fire based attack used against the user.  " +
							  "\n\nMana Cost: " + spellCostWhite(50) + "");
			if (badLustForWhite) {
				bd.disable("You are far too aroused to focus on white magic.");
			} else if (player.hasPerk(PerkLib.HexKnowledge)) {
				bd.disable("Your chosen path of magic locked out this spell.");
			} else if (player.hasStatusEffect(StatusEffects.Blizzard)) {
				bd.disable("Blizzard is already active and cannot be cast again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(50)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(50) && player.HP < spellCostWhite(50)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		
		//BLACK MAGICSKS
		if (player.hasStatusEffect(StatusEffects.KnowsArouse)) {
			bd = buttons.add("Arouse", spellArouse)
						.hint("The arouse spell draws on your own inner lust in order to enflame the enemy's passions.  " +
							  "\n\nMana Cost: " + spellCostBlack(20) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if (!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(20)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(20) && player.HP < spellCostBlack(20)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsRegenerate)) {
			bd = buttons.add("Regenerate", spellRegenerate)
						.hint("Regenerate will attempt to trigger health recovery over time, however like all black magic used on yourself, it has a chance of backfiring and greatly arousing you.  " +
							  "\n\nMana Cost: " + healCostBlack(50) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if (player.hasStatusEffect(StatusEffects.PlayerRegenerate)) {
				bd.disable("You are already under the effects of Regenerate and cannot cast it again.");
			} else if(player.mana < healCostBlack(50)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellRegenerate)) {
				bd.disable("You need more time before you can cast Regenerate again.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsIceSpike)) {
			bd = buttons.add("Ice Spike", spellIceSpike)
						.hint("Drawning your own lust to concentrate it into chilling spike of ice that will attack your enemies.  " +
							  "\n\nMana Cost: " + spellCostBlack(40) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40) && player.HP < spellCostBlack(40)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellIceSpike)) {
				bd.disable("You need more time before you can cast Ice Spike again.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsDarknessShard)) {
			bd = buttons.add("DarknessShard", spellDarknessShard)
						.hint("Drawning your own lust to condense part of the the ambivalent darkness into a shard to attack your enemies.  " +
							  "\n\nMana Cost: " + spellCostBlack(40) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40) && player.HP < spellCostBlack(40)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellDarknessShard)) {
				bd.disable("You need more time before you can cast Darkness Shard again.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsWaveOfEcstasy)) {
			bd = buttons.add("WaveOfEcstasy", spellWaveOfEcstasy)
						.hint("The arouse spell draws on your own inner lust in order to enflame the enemyies passions.  " +
							  "\n\nMana Cost: " + spellCostBlack(100) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if (!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(100)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(20) && player.HP < spellCostBlack(100)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellWaveOfEcstasy)) {
				bd.disable("You need more time before you can cast Wave of Ecstasy again.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsArcticGale)) {
			bd = buttons.add("Arctic Gale", spellArcticGale)
						.hint("Devastate the enemy ranks with a blast of icy wind sharper then steel blades.  \n\n<b>AoE Spell.</b>  " +
							  "\n\nMana Cost: " + spellCostBlack(200) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(200)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40) && player.HP < spellCostBlack(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellArcticGale)) {
				bd.disable("You need more time before you can cast Arctic Gale again.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsDuskWave)) {
			bd = buttons.add("Dusk Wave", spellDuskWave)
						.hint("Drawning your own lust to condense part of the the ambivalent darkness into a wave to attack your enemies.  \n\n<b>AoE Spell.</b>  " +
							  "\n\nMana Cost: " + spellCostBlack(200) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(200)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40) && player.HP < spellCostBlack(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellDuskWave)) {
				bd.disable("You need more time before you can cast Dusk Wave again.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsMight)) {
			bd = buttons.add("Might", spellMight)
						.hint("The Might spell draws upon your lust and uses it to fuel a temporary increase in muscle size and power.  It does carry the risk of backfiring and raising lust, like all black magic used on oneself.  " +
							  "\n\nMana Cost: " + spellCostBlack(50) * spellMightCostMultiplier() + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if (player.hasStatusEffect(StatusEffects.Might)) {
				bd.disable("You are already under the effects of Might and cannot cast it again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostBlack(50) * spellMightCostMultiplier())) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostBlack(50) * spellMightCostMultiplier()) && player.HP < (spellCostBlack(50) * spellMightCostMultiplier())) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsBlink)) {
			bd= buttons.add("Blink", spellBlink)
					   .hint("The Blink spell draws upon your lust and uses it to fuel a temporary increase in moving speed and if it's needed teleport over short distances.  It does carry the risk of backfiring and raising lust, like all black magic used on oneself.  " +
							 "\n\nMana Cost: " + spellCostBlack(40) * spellBlinkCostMultiplier() + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any black magics.");
			} else if (player.hasStatusEffect(StatusEffects.Blink)) {
				bd.disable("You are already under the effects of Blink and cannot cast it again.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostBlack(40) * spellBlinkCostMultiplier())) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < (spellCostBlack(40) * spellBlinkCostMultiplier()) && player.HP < (spellCostBlack(40) * spellBlinkCostMultiplier())) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		
		//HEX MAGIC
		if (player.hasStatusEffect(StatusEffects.KnowsLifetap)) {
			bd = buttons.add("Lifetap", spellLifetap)
						.hint("Sacrifice a quarter of your hp to recover a quarter of your mana.");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any hex magics.");
			} else if(player.cor < 80) {
				bd.disable("Your corruption is too low to cast this spell.");
			} else if(player.HP < player.maxHP() * .25) {
				bd.disable("Your HP is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsLifeSiphon)) {
			bd = buttons.add("Life siphon", spellLifeSiphon)
						.hint("Create a funnel between you and your target, forcefully stealing its vitality to recover your own.  " +
							  "\n\nMana Cost: " + spellCostBlack(750) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any hex magics.");
			} else if(player.cor < 80) {
				bd.disable("Your corruption is too low to cast this spell.");
			} else if(player.mana < spellCostBlack(750)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.LifeSiphon)) {
				bd.disable("You're still linked to the enemy.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsConsumingDarkness)) {
			bd = buttons.add("Consuming darkness", spellConsumingDarkness)
						.hint("For the next 7 round the target is devoured by living shadow trying to tear its body apart deals good damage on each round.  \n\n<b>Cooldown: 15 turns</b>  " +
							  "\n\nMana Cost: " + spellCostBlack(350) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any hex magics.");
			} else if(player.cor < 80) {
				bd.disable("Your corruption is too low to cast this spell.");
			} else if(player.mana < spellCostBlack(350)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownConsumingDarkness)) {
				bd.disable("You need more time before you can cast Consuming darkness again.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsCurseOfDesire)) {
			bd = buttons.add("Curse of Desire", spellCurseOfDesire)
						.hint("Arouse yourself and curse the target with lewd thoughts, weakening its resistance to lust and forcing it to take low lust damage each round for 8 rounds.  \n\n<b>Cooldown: 15 turns</b>  " +
							  "\n\nMana Cost: " + spellCostBlack(400) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any hex magics.");
			} else if(player.cor < 80) {
				bd.disable("Your corruption is too low to cast this spell.");
			} else if(player.mana < spellCostBlack(400)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownCurseOfDesire)) {
				bd.disable("You need more time before you can cast Curse of Desire again.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsCurseOfWeeping)) {
			bd = buttons.add("Curse of Weeping", spellCurseOfWeeping)
						.hint("Draw your own blood and inflict on your target a terrible curse, dealing high damage for 6 rounds.  \n\n<b>Cooldown: 10 turns</b>  " +
							  "\n\nMana Cost: " + spellCostBlack(300) + "");
			if (badLustForBlack) {
				bd.disable("You aren't turned on enough to use any hex magics.");
			} else if(player.cor < 80) {
				bd.disable("Your corruption is too low to cast this spell.");
			} else if(player.mana < spellCostBlack(300)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.HP < player.maxHP() * .5) {
				bd.disable("Your HP is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownCurseOfWeeping)) {
				bd.disable("You need more time before you can cast Curse of Weeping again.");
			}
		}
		
		// GRAY MAGIC
		if (player.hasStatusEffect(StatusEffects.KnowsNosferatu)) {
			bd = buttons.add("Nosferatu", spellNosferatu)
						.hint("Nosferatu will deals damage and heals the user for 100% of damage done.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  " +
							  "\n\nMana Cost: " + healCost(50) + "");
			if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if(player.mana < healCost(50)) {
				bd.disable("Your mana is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsManaShield)) {
			if (player.hasStatusEffect(StatusEffects.ManaShield)) {
				buttons.add("Deactiv MS", DeactivateManaShield).hint("Deactivate Mana Shield.\n");
			} else {
				bd = buttons.add("Mana Shield", spellManaShield)
						.hint("Drawning your own mana with help of lust and force of the willpower to form shield that can absorb attacks.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  \n\nMana Cost: 1 mana point per 1 point of damage blocked");
				if (badLustForGrey) {
					bd.disable("You can't use any grey magics.");
				}
			}
		}
		//	if (player.hasStatusEffect(StatusEffects.KnowsWereBeast)) buttons.add("Were-beast",	were-beast spell goes here
		//	if (player.hasStatusEffect(StatusEffects.Knows)) buttons.add("	next spell (non-fire or non-ice based) goes here
		if (player.hasStatusEffect(StatusEffects.KnowsFireStorm)) {
			bd = buttons.add("Fire Storm", spellFireStorm).hint("Drawning your own lust and force of the willpower to fuel radical change in the surrounding you can call forth an Fire Storm that will attack enemies in a wide area.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  \n\n<b>AoE Spell.</b>  \n\nMana Cost: " + spellCost(200) + "");
			if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200) && player.HP < spellCost(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsMeteorShower)) {
			bd = buttons.add("Meteor Shower", spellMeteorShower)
						.hint("Call down a rain of meteors on your opponents, stunning them for 1 round and dealing area damage. Hits 12 times. Despite been grey magic it still does carry the risk of backfiring and raising lust.  " +
							 "\n\n<b>AoE Spell and req. 1 turn channeling. Cooldown: 12 turns</b>  \n\nMana Cost: " + spellCost(250) + "");
			if (inDungeon || player.hasStatusEffect(StatusEffects.InsideSmallSpace)) {
				bd.disable("You can't use this spell inside small spaces. Unless you want get killed along with your enemies.");
			} else if (player.hasStatusEffect(StatusEffects.UnderwaterCombatBoost)) {
				bd.disable("You can't use this spell underwater.");
			} else if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(250)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(250) && player.HP < spellCost(250)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellMeteorShower)) {
				bd.disable("You need more time before you can cast Meteor Shower again.");
			}
		}
		//	if (player.hasStatusEffect(StatusEffects.Knows)) buttons.add("	fire single target spell goes here
		if (player.hasStatusEffect(StatusEffects.KnowsIceRain)) {
			bd = buttons.add("Ice Rain", spellIceRain).hint("Drawning your own lust and force of the willpower to fuel radical change in the surrounding you can call forth an Ice Rain that will attack enemies in a wide area.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  \n\n<b>AoE Spell.</b>  \n\nMana Cost: " + spellCost(200) + "");
			if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(200) && player.HP < spellCost(200)) {
				bd.disable("Your hp is too low to cast this spell.");
			}
		}
		if (player.hasStatusEffect(StatusEffects.KnowsPolarMidnight)) {
			bd = buttons.add("Polar Midnight", spellPolarMidnight)
						.hint("Cause a massive temperature drop which freezes the air solid in an area. Opponents caught in this spell take the cold damage and are stunned for 5 round.  Despite been grey magic it still does carry the risk of backfiring and raising lust.  " +
							 "\n\n<b>AoE Spell and req. 1 turn channeling. Cooldown: 12 turns</b>  \n\nMana Cost: " + spellCost(250) + "");
			if (badLustForGrey) {
				bd.disable("You can't use any grey magics.");
			} else if(!player.hasPerk(PerkLib.BloodMage) && !player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(250)) {
				bd.disable("Your mana is too low to cast this spell.");
			} else if(player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(250) && player.HP < spellCost(250)) {
				bd.disable("Your hp is too low to cast this spell.");
			} else if (player.hasStatusEffect(StatusEffects.CooldownSpellPolarMidnight)) {
				bd.disable("You need more time before you can cast Polar Midnight again.");
			}
		}
		//	if (player.hasStatusEffect(StatusEffects.Knows)) buttons.add("	ice single target spell goes here
		
	}
	
	public function spellMagicBolt():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		useMana(40, 1);
		if(handleShell()){return;}
		outputText("You narrow your eyes, focusing your mind with deadly intent.  ");
		if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponPerk == "Staff") outputText("You point your staff and shots magic bolt toward " + monster.a + monster.short + "!\n\n");
		else outputText("You point your hand toward " + monster.a + monster.short + " and shots magic bolt!\n\n");
		var damage:Number = scalingBonusIntelligence() * spellMod() * 1.2;
		if (damage < 10) damage = 10;
		//weapon bonus
		if (player.hasPerk(PerkLib.StaffChanneling) && player.weaponPerk == "Staff") {
			if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.04));
			else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (3 + ((player.weaponAttack - 50) * 0.035));
			else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (4.75 + ((player.weaponAttack - 100) * 0.03));
			else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (6.25 + ((player.weaponAttack - 150) * 0.025));
			else damage *= (7.5 + ((player.weaponAttack - 200) * 0.02));
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
		damage = Math.round(damage);
		outputText(monster.capitalA + monster.short + " takes ");
		damage = doMagicDamage(damage, true, true);
		outputText(" damage.");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
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
	
	public function spellArouse():void {
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(20)) player.HP -= spellCostBlack(20);
		else useMana(20,6);
		statScreenRefresh();
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		if(handleShell()){return;}
		outputText("You make a series of arcane gestures, drawing on your own lust to inflict it upon your foe!\n");
		//Worms be immune
		if(monster.short == "worms") {
			outputText("The worms appear to be unaffected by your magic!");
			outputText("\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			doNext(playerMenu);
			if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
			else enemyAI();
			return;
		}
		if(monster.lustVuln == 0) {
			outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			enemyAI();
			return;
		}
		var lustDmg:Number = monster.lustVuln * (player.inte / 5 * spellModBlack() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
		if(player.hasPerk(PerkLib.ArcaneLash)) lustDmg *= 1.5;
		if(player.hasStatusEffect(StatusEffects.AlvinaTraining2)) lustDmg *= 1.2;
		if(player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34) lustDmg = Math.round(lustDmg * 1.2);
		if(monster.lust < (monster.maxLust() * 0.3)) outputText(monster.capitalA + monster.short + " squirms as the magic affects " + monster.pronoun2 + ".  ");
		if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
			if(monster.plural) outputText(monster.capitalA + monster.short + " stagger, suddenly weak and having trouble focusing on staying upright.  ");
			else outputText(monster.capitalA + monster.short + " staggers, suddenly weak and having trouble focusing on staying upright.  ");
		}
		if(monster.lust >= (monster.maxLust() * 0.6)) {
			outputText(monster.capitalA + monster.short + "'");
			if(!monster.plural) outputText("s");
			outputText(" eyes glaze over with desire for a moment.  ");
		}
		if(monster.cocks.length > 0) {
			if(monster.lust >= (monster.maxLust() * 0.6) && monster.cocks.length > 0) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " dribble pre-cum.  ");
			if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length == 1) outputText(monster.capitalA + monster.short + "'s " + monster.cockDescriptShort(0) + " hardens, distracting " + monster.pronoun2 + " further.  ");
			if(monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6) && monster.cocks.length > 1) outputText("You see " + monster.pronoun3 + " " + monster.multiCockDescriptLight() + " harden uncomfortably.  ");
		}
		if(monster.vaginas.length > 0) {
			if(monster.plural) {
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s dampen perceptibly.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotches become sticky with girl-lust.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s become sloppy and wet.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + "s instantly soak " + monster.pronoun2 + " groin.  ");
			}
			else {
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_NORMAL) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " dampens perceptibly.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_WET) outputText(monster.capitalA + monster.short + "'s crotch becomes sticky with girl-lust.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLICK) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " becomes sloppy and wet.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DROOLING) outputText("Thick runners of girl-lube stream down the insides of " + monster.a + monster.short + "'s thighs.  ");
				if(monster.lust >= (monster.maxLust() * 0.6) && monster.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) outputText(monster.capitalA + monster.short + "'s " + monster.vaginaDescript() + " instantly soaks her groin.  ");
			}
		}
		//Determine if critical tease!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.CriticalPerformance)) {
			if (player.lib <= 100) critChance += player.lib / 5;
			if (player.lib > 100) critChance += 20;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			lustDmg *= 1.75;
		}
		lustDmg = Math.round(lustDmg);
		monster.teased(lustDmg);
		if (crit == true) outputText(" <b>Critical!</b>");
		outputText("\n\n");
		if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		doNext(playerMenu);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
		else enemyAI();
	}
	public function spellRegenerate():void {
		clearOutput();
		doNext(combatMenu);
		useMana(50, 11);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		outputText("You focus on your body and its desire to end pain, trying to draw on your arousal without enhancing it.");
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
			player.createStatusEffect(StatusEffects.PlayerRegenerate,7,0,0,0);
			outputText(" This should hold up for about seven rounds.");
		}
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}
	/**
	 * Generates from (x1,x2,x3,y1,y2) log-scale parameters (a,b,c) that will return:
	 * y1= 10 at x1=  10
	 * y2= 55 at x2= 100
	 * y3=100 at x3=1000
	 */
	private static const MightABC:Object = FnHelpers.FN.buildLogScaleABC(10,100,1000,10,100);
//(25) Might – increases strength/toughness by 5 * (Int / 10) * spellMod, up to a
//maximum of 15, allows it to exceed the maximum.  Chance of backfiring
//and increasing lust by 15.
	public function spellMight(silent:Boolean = false):void {

		var doEffect:Function = function():* {
			var MightBoost:Number = 10;
			if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) MightBoost += 5;
			if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) MightBoost += 5;
			if (player.hasPerk(PerkLib.Mage) && player.inte >= 50) MightBoost += 10;
			if (player.hasPerk(PerkLib.GrandMage) && player.inte >= 75) MightBoost += 15;
			if (player.hasPerk(PerkLib.FocusedMind) && player.inte >= 50) MightBoost += 10;
			if (player.hasPerk(PerkLib.Channeling) && player.inte >= 60) MightBoost += 10;
			if (player.hasPerk(PerkLib.Archmage) && player.inte >= 100) MightBoost += 20;
			if (player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 125) MightBoost += 25;
			if (player.hasPerk(PerkLib.GrandArchmage2ndCircle) && player.inte >= 150) MightBoost += 30;
			if (player.hasPerk(PerkLib.GrandArchmage3rdCircle) && player.inte >= 175) MightBoost += 35;
			if (player.hasPerk(PerkLib.GreyMage) && player.inte >= 200) MightBoost += 40;
			if (player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 225) MightBoost += 45;
			if (player.hasPerk(PerkLib.JobEnchanter) && player.inte >= 50) MightBoost += 5;
			if (player.hasPerk(PerkLib.Battlemage) && player.inte >= 50) MightBoost += 15;
			if (player.hasPerk(PerkLib.JobSwordsman)) MightBoost -= 10;
			if (player.hasPerk(PerkLib.JobBrawler)) MightBoost -= 10;
			if (player.hasPerk(PerkLib.JobDervish)) MightBoost -= 10;
			if (player.hasPerk(PerkLib.IronFistsI)) MightBoost -= 10;
			if (player.hasPerk(PerkLib.JobMonk)) MightBoost -= 15;
			if (player.hasPerk(PerkLib.Berzerker)) MightBoost -= 15;
			if (player.hasPerk(PerkLib.Lustzerker)) MightBoost -= 15;
			if (player.hasPerk(PerkLib.WeaponMastery)) MightBoost -= 15;
			if (player.hasPerk(PerkLib.WeaponGrandMastery)) MightBoost -= 25;
			if (player.hasPerk(PerkLib.HeavyArmorProficiency)) MightBoost -= 15;
			if (player.hasPerk(PerkLib.AyoArmorProficiency)) MightBoost -= 20;
			if (player.hasPerk(PerkLib.Agility)) MightBoost -= 10;
			if (player.hasPerk(PerkLib.LightningStrikes)) MightBoost -= 10;
			if (player.hasPerk(PerkLib.StarlightStrikes)) MightBoost -= 10;
			if (player.hasPerk(PerkLib.BodyCultivator)) MightBoost -= 5;
		//	MightBoost += player.inte / 10;player.inte * 0.1 - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells
			if (MightBoost < 10) MightBoost = 10;
			if (player.hasPerk(PerkLib.JobEnchanter)) MightBoost *= 1.2;
			MightBoost *= spellModBlack();
			MightBoost = FnHelpers.FN.logScale(MightBoost,MightABC,10);
			MightBoost = Math.round(MightBoost);
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
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) {
				var MightIntBoost:Number = 0;
				MightIntBoost += 25 * spellModBlack() * (1 + player.newGamePlusMod());
				tempInt = MightIntBoost;
			} else {
				tempStr = MightBoost;
			}
			var oldHPratio:Number = player.hp100/100;
			player.createStatusEffect(StatusEffects.Might,0,0,MightDuration,0);
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) player.changeStatusValue(StatusEffects.Might,1,tempInt);
			else player.changeStatusValue(StatusEffects.Might,1,tempStr);
			player.changeStatusValue(StatusEffects.Might,2,tempTou);
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) {
				player.inte += player.statusEffectv1(StatusEffects.Might);
			} else {
				player.str += player.statusEffectv1(StatusEffects.Might);
			}
			player.tou += player.statusEffectv2(StatusEffects.Might);
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
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}

	/**
	 * Generates from (x1,x2,x3,y1,y2) log-scale parameters (a,b,c) that will return:
	 * y1= 10 at x1=  10
	 * y2= 55 at x2= 100
	 * y3=100 at x3=1000
	 */
	private static const BlinkABC:Object = FnHelpers.FN.buildLogScaleABC(10,100,1000,10,100);
//(25) Blink – increases speed by 5 * (Int / 10) * spellMod, up to a
//maximum of 15, allows it to exceed the maximum.  Chance of backfiring
//and increasing lust by 15.
	public function spellBlink(silent:Boolean = false):void {

		var doEffect:Function = function():* {
			var BlinkBoost:Number = 10;
			if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) BlinkBoost += 5;
			if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) BlinkBoost += 5;
			if (player.hasPerk(PerkLib.Mage) && player.inte >= 50) BlinkBoost += 10;
			if (player.hasPerk(PerkLib.GrandMage) && player.inte >= 75) BlinkBoost += 15;
			if (player.hasPerk(PerkLib.FocusedMind) && player.inte >= 50) BlinkBoost += 10;
			if (player.hasPerk(PerkLib.Channeling) && player.inte >= 60) BlinkBoost += 10;
			if (player.hasPerk(PerkLib.Archmage) && player.inte >= 100) BlinkBoost += 20;
			if (player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 125) BlinkBoost += 25;
			if (player.hasPerk(PerkLib.GrandArchmage2ndCircle) && player.inte >= 150) BlinkBoost += 30;
			if (player.hasPerk(PerkLib.GrandArchmage3rdCircle) && player.inte >= 175) BlinkBoost += 35;
			if (player.hasPerk(PerkLib.GreyMage) && player.inte >= 200) BlinkBoost += 40;
			if (player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 225) BlinkBoost += 45;
			if (player.hasPerk(PerkLib.JobEnchanter) && player.inte >= 50) BlinkBoost += 5;
			if (player.hasPerk(PerkLib.Battleflash) && player.inte >= 50) BlinkBoost += 15;
			if (player.hasPerk(PerkLib.JobSwordsman)) BlinkBoost -= 10;
			if (player.hasPerk(PerkLib.JobBrawler)) BlinkBoost -= 10;
			if (player.hasPerk(PerkLib.JobDervish)) BlinkBoost -= 10;
			if (player.hasPerk(PerkLib.IronFistsI)) BlinkBoost -= 10;
			if (player.hasPerk(PerkLib.JobMonk)) BlinkBoost -= 15;
			if (player.hasPerk(PerkLib.Berzerker)) BlinkBoost -= 15;
			if (player.hasPerk(PerkLib.Lustzerker)) BlinkBoost -= 15;
			if (player.hasPerk(PerkLib.WeaponMastery)) BlinkBoost -= 15;
			if (player.hasPerk(PerkLib.WeaponGrandMastery)) BlinkBoost -= 25;
			if (player.hasPerk(PerkLib.HeavyArmorProficiency)) BlinkBoost -= 15;
			if (player.hasPerk(PerkLib.AyoArmorProficiency)) BlinkBoost -= 20;
			if (player.hasPerk(PerkLib.Agility)) BlinkBoost -= 10;
			if (player.hasPerk(PerkLib.LightningStrikes)) BlinkBoost -= 10;
			if (player.hasPerk(PerkLib.StarlightStrikes)) BlinkBoost -= 10;
			if (player.hasPerk(PerkLib.BodyCultivator)) BlinkBoost -= 5;
		//	BlinkBoost += player.inte / 10;player.inte * 0.1 - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells
			if (BlinkBoost < 10) BlinkBoost = 10;
			BlinkBoost *= 1.2;
			if (player.hasPerk(PerkLib.JobEnchanter)) BlinkBoost *= 1.25;
			BlinkBoost *= spellModBlack();
			BlinkBoost = FnHelpers.FN.logScale(BlinkBoost,BlinkABC,10);
			BlinkBoost = Math.round(BlinkBoost);
			var BlinkDuration:Number = 5;
			if (player.hasPerk(PerkLib.LongerLastingBuffsI)) BlinkDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsII)) BlinkDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsIII)) BlinkDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsIV)) BlinkDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsV)) BlinkDuration += 1;
			if (player.hasPerk(PerkLib.LongerLastingBuffsVI)) BlinkDuration += 1;
			if (player.hasPerk(PerkLib.EverLastingBuffs)) BlinkDuration += 5;
			if (player.hasPerk(PerkLib.EternalyLastingBuffs)) BlinkDuration += 5;
			player.createStatusEffect(StatusEffects.Blink,0,0,BlinkDuration,0);
			tempSpe = BlinkBoost;
			//if(player.spe + temp > 100) tempSpe = 100 - player.spe;
			player.changeStatusValue(StatusEffects.Blink,1,tempSpe);
			mainView.statsView.showStatUp('spe');
			// strUp.visible = true;
			// strDown.visible = false;
			player.spe += player.statusEffectv1(StatusEffects.Blink);
			statScreenRefresh();
		};

		if (silent)	{ // for Battleflash
			doEffect.call();
			return;
		}

		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < (40 * spellBlinkCostMultiplier())) player.HP -= (40 * spellBlinkCostMultiplier());
		else useMana((40 * spellBlinkCostMultiplier()),6);
		var tempSpe:Number = 0;
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		outputText("You flush, drawing on your body's desires to empower your muscles and hasten you up.\n\n");
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
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}

//(45) Ice Spike - ice version of whitefire
	public function spellIceSpike():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40)) player.HP -= spellCostBlack(40);
		else useMana(40, 6);
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) player.createStatusEffect(StatusEffects.CooldownSpellIceSpike,spellBlackCooldown(),0,0,0);
		if (handleShell()){return;}
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
		spellIceSpike2();
		if(monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	public function spellIceSpike2():void {
		outputText("You narrow your eyes, focusing your own lust with deadly intent.  At the palm of your hand form ice spike that shots toward " + monster.a + monster.short + " !\n");
		var damage:Number = scalingBonusIntelligence() * spellModBlack();
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) damage *= 4;
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
		if (player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34) damage = Math.round(damage * 1.2);
		damage = Math.round(damage);
		//if (monster.short == "goo-girl") damage = Math.round(damage * 1.5); - pomyśleć czy bdą dostawać bonusowe obrażenia
		//if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2); - tak samo przemyśleć czy bedą dodatkowo ranione
		outputText(monster.capitalA + monster.short + " takes ");
		damage = doIceDamage(damage, true, true);
		outputText(" damage.");
		//Using fire attacks on the goo]
		//if(monster.short == "goo-girl") {
		//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
		//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		//}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
	}

//(45) Darkness Shard
	public function spellDarknessShard():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(40)) player.HP -= spellCostBlack(40);
		else useMana(40, 6);
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) player.createStatusEffect(StatusEffects.CooldownSpellDarknessShard,spellBlackCooldown(),0,0,0);
		if (handleShell()){return;}
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
		spellDarknessShard2();
		if(monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	public function spellDarknessShard2():void {
		outputText("You narrow your eyes, focusing your own lust with deadly intent.  At the palm of your hand form a shard from pure darkness that shots toward " + monster.a + monster.short + " !\n");
		var damage:Number = scalingBonusIntelligence() * spellModBlack();
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) damage *= 4;
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
		damage = calcEclypseMod(damage);
		if (player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34) damage = Math.round(damage * 1.2);
		damage = Math.round(damage);
		//if (monster.short == "goo-girl") damage = Math.round(damage * 1.5); - pomyśleć czy bdą dostawać bonusowe obrażenia
		//if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2); - tak samo przemyśleć czy bedą dodatkowo ranione
		outputText(monster.capitalA + monster.short + " takes ");
		damage = doDarknessDamage(damage, true, true);
		outputText(" damage.");
		//Using fire attacks on the goo]
		//if(monster.short == "goo-girl") {
		//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
		//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		//}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
	}
	
	public function spellWaveOfEcstasy():void {
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(100)) player.HP -= spellCostBlack(100);
		else useMana(100,6);
		statScreenRefresh();
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		player.createStatusEffect(StatusEffects.CooldownSpellWaveOfEcstasy,6,0,0,0);
		if(handleShell()){return;}
		outputText("You almost moan in pleasure as you draw on this spell, sending forth your lust like a shockwave. ");
		//Worms be immune
		if(monster.short == "worms") {
			outputText("\nThe worms appear to be unaffected by your magic!\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			doNext(playerMenu);
			if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
			else enemyAI();
			return;
		}
		if(monster.lustVuln == 0) {
			outputText("\nIt has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			enemyAI();
			return;
		}
		var lustDmg:Number = monster.lustVuln * 0.5 * (player.inte / 5 * spellModBlack() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
		if(player.hasPerk(PerkLib.ArcaneLash)) lustDmg *= 1.5;
		if(player.hasStatusEffect(StatusEffects.AlvinaTraining2)) lustDmg *= 1.2;
		if(player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34) lustDmg = Math.round(lustDmg * 1.2);
		if(monster.plural) {
			outputText("Arousal breaks in the eyes of your many opponents as pleasure strikes them");
			lustDmg *= 5;
		}
		else outputText("Unable to evade it " + monster.a + monster.short + " is struck squarely by the pleasure wave");
		outputText(" for ");
		//Determine if critical tease!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.CriticalPerformance)) {
			if (player.lib <= 100) critChance += player.lib / 5;
			if (player.lib > 100) critChance += 20;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			lustDmg *= 1.75;
		}
		lustDmg = Math.round(lustDmg);
		monster.teased(lustDmg);
		outputText(" damage.");
		if (crit == true) outputText(" <b>Critical!</b>");
		outputText("\n\n");
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
		if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		doNext(playerMenu);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(monster.lust >= monster.maxLust()) doNext(endLustVictory);
		else enemyAI();
	}

//(50) Arctic Gale - AoE Ice spell
	public function spellArcticGale():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(200)) player.HP -= spellCostBlack(200);
		else useMana(200,6);
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) player.createStatusEffect(StatusEffects.CooldownSpellArcticGale,spellBlackCooldown(),0,0,0);
		if (handleShell()){return;}
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
		outputText("You wave the signs with your hands and unleash an howling blast of cold magic upon " + monster.a + monster.short + ".  \n");
		var damage:Number = scalingBonusIntelligence() * spellModBlack();
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) damage *= 4;
		if (monster.plural == true) damage *= 5;
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
		if (player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34) damage = Math.round(damage * 1.2);
		damage = Math.round(damage);
		//if (monster.short == "goo-girl") damage = Math.round(damage * 1.5); - pomyśleć czy bdą dostawać bonusowe obrażenia
		//if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2); - tak samo przemyśleć czy bedą dodatkowo ranione
		outputText(monster.capitalA + monster.short + " takes ");
		damage = doIceDamage(damage, true, true);
		outputText(" damage.");
		//Using fire attacks on the goo]
		//if(monster.short == "goo-girl") {
		//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
		//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		//}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if(monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

//(50) Dusk Wave - AoE Darkness spell
	public function spellDuskWave():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostBlack(200)) player.HP -= spellCostBlack(200);
		else useMana(200,6);
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) player.createStatusEffect(StatusEffects.CooldownSpellDuskWave,spellBlackCooldown(),0,0,0);
		if (handleShell()){return;}
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
		outputText("You wave the signs with your hands and all light fades as you call down to the primordial darkness to gnaw at " + monster.a + monster.short + ".  \n");
		var damage:Number = scalingBonusIntelligence() * spellModBlack();
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) damage *= 4;
		if (monster.plural == true) damage *= 5;
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
		damage = calcEclypseMod(damage);
		if (player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34) damage = Math.round(damage * 1.2);
		damage = Math.round(damage);
		//if (monster.short == "goo-girl") damage = Math.round(damage * 1.5); - pomyśleć czy bdą dostawać bonusowe obrażenia
		//if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2); - tak samo przemyśleć czy bedą dodatkowo ranione
		outputText(monster.capitalA + monster.short + " takes ");
		damage = doDarknessDamage(damage, true, true);
		outputText(" damage.");
		//Using fire attacks on the goo]
		//if(monster.short == "goo-girl") {
		//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
		//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		//}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if(monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	
	public function spellLifetap():void {
		clearOutput();
		doNext(combatMenu);
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
			var lifetap:Number = 0;
			lifetap += Math.round(player.maxHP() * .25);
			outputText("You proceed to cut your hand and draw a small pattern. You feel your magical reservoirs fill back up by a significant amount.");
			HPChange(-lifetap, false);
			player.mana += lifetap;
			if (player.mana > player.maxMana()) player.mana = player.maxMana();
		}
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}
	
	public function spellLifeSiphon():void {
		clearOutput();
		doNext(combatMenu);
		useMana(750, 9);
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
			var lifesiphon:Number = 0;
			lifesiphon += player.inte;
			if (player.hasPerk(PerkLib.WisenedHealer)) lifesiphon += player.wis;
			if (player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34) lifesiphon = Math.round(lifesiphon * 1.2);
			outputText("You wave a sign linking yourself to " + monster.a + monster.short + " as you begin to funnel its health and vitality to yourself.");
			monster.HP -= lifesiphon;
			HPChange(lifesiphon, false);
			player.createStatusEffect(StatusEffects.LifeSiphon, 15, lifesiphon, 0, 0);
		}
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}
	
	public function spellConsumingDarkness():void {
		clearOutput();
		doNext(combatMenu);
		useMana(350, 9);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		player.createStatusEffect(StatusEffects.CooldownConsumingDarkness, 15, 0, 0, 0);
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
			var consumingdarkness:Number = scalingBonusIntelligence() * spellModBlack();
			if (player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34) consumingdarkness = Math.round(consumingdarkness * 1.2);
			outputText("You call on the power of primordial darkness, which is all too happy to oblige your request of ripping your foe to shreds. The shadows all around you sprouting countless mouths and claws to do just that. " + monster.capitalA + monster.short + " can only scream in surprise, then in pain, at the sudden assault. ");
			player.createStatusEffect(StatusEffects.ConsumingDarkness, 7, 0.05, 0, 0);
			if (player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34) {
				consumingdarkness = Math.round(consumingdarkness * 1.2);
				player.addStatusValue(StatusEffects.ConsumingDarkness, 2, 0.01);
			}
			consumingdarkness = doDarknessDamage(consumingdarkness, true, true);
		}
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}
	
	public function spellCurseOfDesire():void {
		clearOutput();
		doNext(combatMenu);
		useMana(400, 9);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		player.createStatusEffect(StatusEffects.CooldownCurseOfDesire, 15, 0, 0, 0);
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
			var lustDmg:Number = monster.lustVuln * 0.5 * (player.inte / 5 * spellModBlack() + rand(monster.lib - monster.inte * 2 + monster.cor) / 5);
			outputText("You moan in pleasure as you curse your target with lewd thoughts. " + monster.capitalA + monster.short + " pants in arousal, unable to stop the encroaching fantasies you forced on her/him/it/them from having their desired effect. ");
			player.createStatusEffect(StatusEffects.CurseOfDesire, 8, 0.05, 0, 0);
			if (player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34) {
				lustDmg = Math.round(lustDmg * 1.2);
				player.addStatusValue(StatusEffects.CurseOfDesire, 2, 0.01);
			}
			lustDmg = Math.round(lustDmg);
			monster.teased(lustDmg);
			dynStats("lus", 10);
		}
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}
	
	public function spellCurseOfWeeping():void {
		clearOutput();
		doNext(combatMenu);
		useMana(300, 9);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		player.createStatusEffect(StatusEffects.CooldownCurseOfWeeping, 10, 0, 0, 0);
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
			outputText("You cut deep into your arm, drawing plenty of your blood and letting it flow in a large pattern on the ground as you hex your target with a powerful malediction, causing it to bleed from every orifice. " + monster.capitalA + monster.short + " screams in pain, unable to stop the blood flow. ");
			player.createStatusEffect(StatusEffects.CurseOfWeeping, 6, 0.125, 0, 0);
			if (player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34) player.addStatusValue(StatusEffects.CurseOfWeeping, 2, 0.025);
			HPChange(-(Math.round(player.maxHP() * .5)), false);
		}
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}

//(100) Ice Rain - AoE Ice spell
	public function spellIceRain():void {
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
		outputText("You narrow your eyes, focusing your own lust and willpower with a deadly intent.  Above you starting to form small dark cloud that soon becoming quite wide and long.  Then almost endless rain of ice shards start to downpour on " + monster.a + monster.short + " and the rest of your surrounding!\n");
		var damage:Number = scalingBonusIntelligence() * spellMod();
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
		damage = Math.round(damage);
		//if (monster.short == "goo-girl") damage = Math.round(damage * 1.5); - pomyśleć czy bedą dostawać bonusowe obrażenia
		//if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2); - tak samo przemyśleć czy bedą dodatkowo ranione
		if (monster.plural == true) damage *= 5;
		outputText(monster.capitalA + monster.short + " takes ");
		damage = doIceDamage(damage, true, true);
		if (!monster.hasPerk(PerkLib.EnemyGroupType) && player.hasPerk(PerkLib.Convergence)) {
			damage = doIceDamage(damage, true, true);
			damage = doIceDamage(damage, true, true);
		}
		outputText(" damage.");
		//Using fire attacks on the goo]
		//if(monster.short == "goo-girl") {
		//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
		//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		//}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		if (!monster.hasPerk(PerkLib.EnemyGroupType) && player.hasPerk(PerkLib.Convergence)) damage *= 3;
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if(monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

//(100) Polar Midnight - AoE Ice spell
	public function spellPolarMidnight():void {
		if (rand(2) == 0) flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		else flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			outputText("You drain the heat out of the air around your foe, causing its temperature to plummet far below its freezing point in an instant, effectively flash freezing your enemy for \n");
			var damage:Number = scalingBonusIntelligence() * spellMod() * 24;
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
			damage = Math.round(damage);
			//if (monster.short == "goo-girl") damage = Math.round(damage * 1.5); - pomyśleć czy bedą dostawać bonusowe obrażenia
			//if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2); - tak samo przemyśleć czy bedą dodatkowo ranione
			if (monster.plural == true) damage *= 5;
			damage = doIceDamage(damage, true, true);
			if (!monster.hasPerk(PerkLib.EnemyGroupType) && player.hasPerk(PerkLib.Convergence)) {
				damage = doIceDamage(damage, true, true);
				damage = doIceDamage(damage, true, true);
			}
			outputText(" damage!");
			//Using fire attacks on the goo]
			//if(monster.short == "goo-girl") {
			//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
			//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
			//}
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText(" " + monster.a + monster.short + " is encased in a thick layer of ice.\n\n");
			if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
			if (!monster.hasPerk(PerkLib.EnemyGroupType) && player.hasPerk(PerkLib.Convergence)) damage *= 3;
			monster.createStatusEffect(StatusEffects.Stunned,5,0,0,0);
			checkAchievementDamage(damage);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			combat.heroBaneProc(damage);
			statScreenRefresh();
			if(monster.HP <= monster.minHP()) doNext(endHpVictory);
			else enemyAI();
		}
		else {
			doNext(combatMenu);
			if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(250)) player.HP -= spellCost(250);
			else useMana(250,1);
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
			outputText("You begin to channel magic, the air temperature dropping around you.");
			player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.ChanneledAttackType, 5, 0, 0, 0);
			player.createStatusEffect(StatusEffects.CooldownSpellPolarMidnight,12,0,0,0);
			outputText("\n\n");
			enemyAI();
		}
	}

//(100) Fire Storm - AoE Fire spell
	public function spellFireStorm():void {
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
		outputText("You narrow your eyes, focusing your own lust and willpower with a deadly intent.  Around you starting to form small vortex of flames that soon becoming quite wide.  Then with a single thought you sends all that fire like a unstoppable storm toward " + monster.a + monster.short + " and the rest of your surrounding!\n");
		var damage:Number = scalingBonusIntelligence() * spellMod();
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
		if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2);
		if (monster.plural == true) damage *= 5;
		damage = Math.round(damage);
		outputText(monster.capitalA + monster.short + " takes ");
		damage = doFireDamage(damage, true, true);
		if (!monster.hasPerk(PerkLib.EnemyGroupType) && player.hasPerk(PerkLib.Convergence)) {
			damage = doFireDamage(damage, true, true);
			damage = doFireDamage(damage, true, true);
		}
		outputText(" damage.");
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your fire storm lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		if (!monster.hasPerk(PerkLib.EnemyGroupType) && player.hasPerk(PerkLib.Convergence)) damage *= 3;
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if(monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

//(100) Meteor Shower - AoE Fire spell
	public function spellMeteorShower():void {
		if (rand(2) == 0) flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		else flags[kFLAGS.LAST_ATTACK_TYPE] = 3;
		clearOutput();
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			outputText("You call out to the celestial vault, knocking some rocks out of orbit and into a crash course towards your opponents.\n\n");
			var damage:Number = scalingBonusIntelligence() * spellMod() * 3;
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
			if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
			if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2);
			if (monster.plural == true) damage *= 5;
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
			if (player.hasPerk(PerkLib.FireAffinity)) damage *= 2;
			damage = Math.round(damage);
			if (monster.plural == true) damage *= 5;
			damage = doFireDamage(damage, true, true);
			damage = doFireDamage(damage, true, true);
			damage = doFireDamage(damage, true, true);
			damage = doFireDamage(damage, true, true);
			damage = doFireDamage(damage, true, true);
			damage = doFireDamage(damage, true, true);
			damage = doFireDamage(damage, true, true);
			damage = doFireDamage(damage, true, true);
			damage = doFireDamage(damage, true, true);
			damage = doFireDamage(damage, true, true);
			damage = doFireDamage(damage, true, true);
			damage = doFireDamage(damage, true, true);
			if (!monster.hasPerk(PerkLib.EnemyGroupType) && player.hasPerk(PerkLib.Convergence)) {
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
				damage = doFireDamage(damage, true, true);
			}
			outputText(" damage!");
			//Using fire attacks on the goo]
			if(monster.short == "goo-girl") {
				outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
				if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
			}
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			outputText(" " + monster.capitalA + monster.short + " reels from the impact, trying to recover from this devastating assault as a meteor crash in the area.\n\n");
			if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
			damage *= 10;
			if (!monster.hasPerk(PerkLib.EnemyGroupType) && player.hasPerk(PerkLib.Convergence)) damage *= 3;
			monster.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
			checkAchievementDamage(damage);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			combat.heroBaneProc(damage);
			statScreenRefresh();
			if(monster.HP <= monster.minHP()) doNext(endHpVictory);
			else enemyAI();
		}
		else {
			doNext(combatMenu);
			if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCost(250)) player.HP -= spellCost(250);
			else useMana(250,1);
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
			outputText("You begin to channel magic, the sky reddening above you.");
			player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.ChanneledAttackType, 6, 0, 0, 0);
			player.createStatusEffect(StatusEffects.CooldownSpellMeteorShower,12,0,0,0);
			outputText("\n\n");
			enemyAI();
		}
	}
	
	public function spellManaShield(silent:Boolean = false):void {
		if (silent) {
			if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
			player.createStatusEffect(StatusEffects.ManaShield,0,0,0,0);
			statScreenRefresh();
			return;
		}
		clearOutput();
		outputText("Deciding you need additional protection during current fight you spend moment to concentrate and form barrier made of mana around you.  It will block attacks as long you would have enough mana.\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		player.createStatusEffect(StatusEffects.ManaShield,0,0,0,0);
		enemyAI();
	}

	public function DeactivateManaShield():void {
		clearOutput();
		outputText("Deciding you not need for now to keep youe mana shield you concentrate and deactivating it.\n\n");
		player.removeStatusEffect(StatusEffects.ManaShield);
		enemyAI();
	}
	
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
			if (player.hasPerk(PerkLib.WisenedHealer)) nosferatu += player.wis;
			outputText(" You chant as your shadow suddenly takes on a life of its own, sprouting a multitude of mouths and tentacles which seek and tear into " + monster.a + monster.short + " shadow");
			if (monster.plural == true) outputText("s");
			outputText(", gorging on its owner’s life force to replenish your own. Soon enough the spell is over and your shadow returns to you, leaving you better for the wear. <b>(<font color=\"#800000\">" + nosferatu + "</font>)</b>");
			monster.HP -= nosferatu;
			HPChange(nosferatu,false);
		}
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}

	/**
	 * Generates from (x1,x2,x3,y1,y2) log-scale parameters (a,b,c) that will return:
	 * y1= 10 at x1=  10
	 * y2= 55 at x2= 100
	 * y3=100 at x3=1000
	 */
	private static const ChargeWeaponABC:Object = FnHelpers.FN.buildLogScaleABC(10,100,1000,10,100);
//(15) Charge Weapon – boosts your weapon attack value by 5 + (player.inte/10) * SpellMod till the end of combat.
	public function spellChargeWeapon(silent:Boolean = false):void {
		var ChargeWeaponBoost:Number = 10;
		if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) ChargeWeaponBoost += 5;
		if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) ChargeWeaponBoost += 5;
		if (player.hasPerk(PerkLib.Mage) && player.inte >= 50) ChargeWeaponBoost += 10;
		if (player.hasPerk(PerkLib.GrandMage) && player.inte >= 75) ChargeWeaponBoost += 15;
		if (player.hasPerk(PerkLib.FocusedMind) && player.inte >= 50) ChargeWeaponBoost += 10;
		if (player.hasPerk(PerkLib.Channeling) && player.inte >= 60) ChargeWeaponBoost += 10;
		if (player.hasPerk(PerkLib.Archmage) && player.inte >= 100) ChargeWeaponBoost += 20;
		if (player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 125) ChargeWeaponBoost += 25;
		if (player.hasPerk(PerkLib.GrandArchmage2ndCircle) && player.inte >= 150) ChargeWeaponBoost += 30;
		if (player.hasPerk(PerkLib.GrandArchmage3rdCircle) && player.inte >= 175) ChargeWeaponBoost += 35;
		if (player.hasPerk(PerkLib.GreyMage) && player.inte >= 200) ChargeWeaponBoost += 40;
		if (player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 225) ChargeWeaponBoost += 45;
		if (player.hasPerk(PerkLib.JobEnchanter) && player.inte >= 50) ChargeWeaponBoost += 5;
		if (player.hasPerk(PerkLib.Spellsword) && player.inte >= 50) ChargeWeaponBoost += 15;
		if (player.hasPerk(PerkLib.JobSwordsman)) ChargeWeaponBoost -= 10;
		if (player.hasPerk(PerkLib.JobBrawler)) ChargeWeaponBoost -= 10;
		if (player.hasPerk(PerkLib.JobDervish)) ChargeWeaponBoost -= 10;
		if (player.hasPerk(PerkLib.IronFistsI)) ChargeWeaponBoost -= 10;
		if (player.hasPerk(PerkLib.JobMonk)) ChargeWeaponBoost -= 15;
		if (player.hasPerk(PerkLib.Berzerker)) ChargeWeaponBoost -= 15;
		if (player.hasPerk(PerkLib.Lustzerker)) ChargeWeaponBoost -= 15;
		if (player.hasPerk(PerkLib.WeaponMastery)) ChargeWeaponBoost -= 15;
		if (player.hasPerk(PerkLib.WeaponGrandMastery)) ChargeWeaponBoost -= 25;
		if (player.hasPerk(PerkLib.HeavyArmorProficiency)) ChargeWeaponBoost -= 15;
		if (player.hasPerk(PerkLib.AyoArmorProficiency)) ChargeWeaponBoost -= 15;
		if (player.hasPerk(PerkLib.Agility)) ChargeWeaponBoost -= 10;
		if (player.hasPerk(PerkLib.LightningStrikes)) ChargeWeaponBoost -= 10;
		if (player.hasPerk(PerkLib.StarlightStrikes)) ChargeWeaponBoost -= 10;
		if (player.hasPerk(PerkLib.BodyCultivator)) ChargeWeaponBoost -= 5;
	//	ChargeWeaponBoost += player.inte / 10;player.inte * 0.1 - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells
		if (ChargeWeaponBoost < 10) ChargeWeaponBoost = 10;
		ChargeWeaponBoost *= 1.5;
		if (player.hasPerk(PerkLib.JobEnchanter)) ChargeWeaponBoost *= 1.2;
		ChargeWeaponBoost *= spellModWhite();
		ChargeWeaponBoost = FnHelpers.FN.logScale(ChargeWeaponBoost,ChargeWeaponABC,10);
		ChargeWeaponBoost = Math.round(ChargeWeaponBoost);
		var ChargeWeaponDuration:Number = 5;
		if (player.hasPerk(PerkLib.LongerLastingBuffsI)) ChargeWeaponDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsII)) ChargeWeaponDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsIII)) ChargeWeaponDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsIV)) ChargeWeaponDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsV)) ChargeWeaponDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsVI)) ChargeWeaponDuration += 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) ChargeWeaponDuration += 5;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) ChargeWeaponDuration += 5;
		if (silent) {
			player.createStatusEffect(StatusEffects.ChargeWeapon,ChargeWeaponBoost,ChargeWeaponDuration,0,0);
			statScreenRefresh();
			return;
		}

		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < (30 * spellChargeWeaponCostMultiplier())) player.HP -= (30 * spellChargeWeaponCostMultiplier());
		else useMana((30 * spellChargeWeaponCostMultiplier()), 5);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You utter words of power, summoning an electrical charge around your [weapon].  It crackles loudly, ensuring you'll do more damage with it for the rest of the fight.\n\n");
		player.createStatusEffect(StatusEffects.ChargeWeapon, ChargeWeaponBoost, ChargeWeaponDuration, 0, 0);
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}

	/**
	 * Generates from (x1,x2,x3,y1,y2) log-scale parameters (a,b,c) that will return:
	 * y1= 10 at x1=  10
	 * y2= 55 at x2= 100
	 * y3=100 at x3=1000
	 */
	private static const ChargeArmorABC:Object = FnHelpers.FN.buildLogScaleABC(10,100,1000,10,100);
//(35) Charge Armor – boosts your armor value by 5 + (player.inte/10) * SpellMod till the end of combat.
	public function spellChargeArmor(silent:Boolean = false):void {
		var ChargeArmorBoost:Number = 10;
		if (player.hasPerk(PerkLib.JobSorcerer) && player.inte >= 25) ChargeArmorBoost += 5;
		if (player.hasPerk(PerkLib.Spellpower) && player.inte >= 50) ChargeArmorBoost += 5;
		if (player.hasPerk(PerkLib.Mage) && player.inte >= 50) ChargeArmorBoost += 10;
		if (player.hasPerk(PerkLib.GrandMage) && player.inte >= 75) ChargeArmorBoost += 15;
		if (player.hasPerk(PerkLib.FocusedMind) && player.inte >= 50) ChargeArmorBoost += 10;
		if (player.hasPerk(PerkLib.Channeling) && player.inte >= 60) ChargeArmorBoost += 10;
		if (player.hasPerk(PerkLib.Archmage) && player.inte >= 100) ChargeArmorBoost += 20;
		if (player.hasPerk(PerkLib.GrandArchmage) && player.inte >= 125) ChargeArmorBoost += 25;
		if (player.hasPerk(PerkLib.GrandArchmage2ndCircle) && player.inte >= 150) ChargeArmorBoost += 30;
		if (player.hasPerk(PerkLib.GrandArchmage3rdCircle) && player.inte >= 175) ChargeArmorBoost += 35;
		if (player.hasPerk(PerkLib.GreyMage) && player.inte >= 200) ChargeArmorBoost += 40;
		if (player.hasPerk(PerkLib.GreyArchmage) && player.inte >= 225) ChargeArmorBoost += 45;
		if (player.hasPerk(PerkLib.JobEnchanter) && player.inte >= 50) ChargeArmorBoost += 5;
		if (player.hasPerk(PerkLib.Spellarmor) && player.inte >= 50) ChargeArmorBoost += 15;
		if (player.hasPerk(PerkLib.JobSwordsman)) ChargeArmorBoost -= 10;
		if (player.hasPerk(PerkLib.JobBrawler)) ChargeArmorBoost -= 10;
		if (player.hasPerk(PerkLib.JobDervish)) ChargeArmorBoost -= 10;
		if (player.hasPerk(PerkLib.IronFistsI)) ChargeArmorBoost -= 10;
		if (player.hasPerk(PerkLib.JobMonk)) ChargeArmorBoost -= 15;
		if (player.hasPerk(PerkLib.Berzerker)) ChargeArmorBoost -= 15;
		if (player.hasPerk(PerkLib.Lustzerker)) ChargeArmorBoost -= 15;
		if (player.hasPerk(PerkLib.WeaponMastery)) ChargeArmorBoost -= 15;
		if (player.hasPerk(PerkLib.WeaponGrandMastery)) ChargeArmorBoost -= 25;
		if (player.hasPerk(PerkLib.HeavyArmorProficiency)) ChargeArmorBoost -= 15;
		if (player.hasPerk(PerkLib.AyoArmorProficiency)) ChargeArmorBoost -= 15;
		if (player.hasPerk(PerkLib.Agility)) ChargeArmorBoost -= 10;
		if (player.hasPerk(PerkLib.LightningStrikes)) ChargeArmorBoost -= 10;
		if (player.hasPerk(PerkLib.StarlightStrikes)) ChargeArmorBoost -= 10;
		if (player.hasPerk(PerkLib.BodyCultivator)) ChargeArmorBoost -= 5;
	//	ChargeArmorBoost += player.inte / 10;player.inte * 0.1 - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells
		if (ChargeArmorBoost < 10) ChargeArmorBoost = 10;
		if (player.hasPerk(PerkLib.JobEnchanter)) ChargeArmorBoost *= 1.2;
		ChargeArmorBoost *= spellModWhite();
		ChargeArmorBoost = FnHelpers.FN.logScale(ChargeArmorBoost,ChargeArmorABC,10);
		ChargeArmorBoost = Math.round(ChargeArmorBoost);
		var ChargeArmorDuration:Number = 5;
		if (player.hasPerk(PerkLib.LongerLastingBuffsI)) ChargeArmorDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsII)) ChargeArmorDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsIII)) ChargeArmorDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsIV)) ChargeArmorDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsV)) ChargeArmorDuration += 1;
		if (player.hasPerk(PerkLib.LongerLastingBuffsVI)) ChargeArmorDuration += 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) ChargeArmorDuration += 5;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) ChargeArmorDuration += 5;
		if (silent) {
			player.createStatusEffect(StatusEffects.ChargeArmor,ChargeArmorBoost,ChargeArmorDuration,0,0);
			statScreenRefresh();
			return;
		}

		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < (40 * spellChargeArmorCostMultiplier())) player.HP -= (40 * spellChargeArmorCostMultiplier());
		else useMana((40 * spellChargeArmorCostMultiplier()), 5);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You utter words of power, summoning an electrical charge around your");
		if (player.isNaked() && player.haveNaturalArmor() && player.hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalArmor)) outputText(" natural armor.");
		else outputText(" [armor].");
		outputText("  It crackles loudly, ensuring you'll have more protection for the rest of the fight.\n\n");
		player.createStatusEffect(StatusEffects.ChargeArmor, ChargeArmorBoost, ChargeArmorDuration, 0, 0);
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}
	public function spellHeal():void {
		clearOutput();
		doNext(combatMenu);
		useMana(30, 10);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		spellHealEffect();
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		if(player.lust >= player.maxLust()) doNext(endLustLoss);
		else enemyAI();
	}
	public function spellHealEffect():void {
		var heal:Number = 0;
		heal += scalingBonusIntelligence();
		if (player.hasPerk(PerkLib.WisenedHealer)) heal += scalingBonusWisdom();
		heal *= healModWhite();
		if (player.armorName == "skimpy nurse's outfit") heal *= 1.2;
		if (player.weaponName == "unicorn staff") heal *= 1.5;
		if (player.hasPerk(PerkLib.CloseToDeath) && player.HP < (player.maxHP() * 0.25)) {
			if (player.hasPerk(PerkLib.CheatDeath) && player.HP < (player.maxHP() * 0.1)) heal *= 2.5;
			else heal *= 1.5;
		}
		//Determine if critical heal!
		var crit:Boolean = false;
		var critHeal:int = 5;
		critHeal += combatMagicalCritical();
		if (rand(100) < critHeal) {
			crit = true;
			heal *= 1.75;
		}
		heal = Math.round(heal);
		outputText("You chant a magical song of healing and recovery and your wounds start knitting themselves shut in response. <b>(<font color=\"#008000\">+" + heal + "</font>)</b>.");
		if (crit == true) outputText(" <b>*Critical Heal!*</b>");
		HPChange(heal,false);
	}
//(20) Blind – reduces your opponent's accuracy, giving an additional 50% miss chance to physical attacks.
	public function spellBlind():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(30)) player.HP -= spellCostWhite(30);
		else useMana(30,5);
		var successrate:int = 60;
		successrate -= (player.inte * 0.4);
		if (successrate > 20) successrate = 20;
		if (rand(100) > successrate) {
			if (monster.hasStatusEffect(StatusEffects.Shell)) {
				outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
				flags[kFLAGS.SPELLS_CAST]++;
				if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
				spellPerkUnlock();
				enemyAI();
				return;
			}
			if (monster is JeanClaude)
			{
				outputText("Jean-Claude howls, reeling backwards before turning back to you, rage clenching his dragon-like face and enflaming his eyes. Your spell seemed to cause him physical pain, but did nothing to blind his lidless sight.");

				outputText("\n\n“<i>You think your hedge magic will work on me, intrus?</i>” he snarls. “<i>Here- let me show you how it’s really done.</i>” The light of anger in his eyes intensifies, burning a retina-frying white as it demands you stare into it...");

				if (rand(player.spe) >= 50 || rand(player.inte) >= 50)
				{
					outputText("\n\nThe light sears into your eyes, but with the discipline of conscious effort you escape the hypnotic pull before it can mesmerize you, before Jean-Claude can blind you.");

					outputText("\n\n“<i>You fight dirty,</i>” the monster snaps. He sounds genuinely outraged. “<i>I was told the interloper was a dangerous warrior, not a little [boy] who accepts duels of honour and then throws sand into his opponent’s eyes. Look into my eyes, little [boy]. Fair is fair.</i>”");

					monster.HP -= int(10+(player.inte/3 + rand(player.inte/2)) * spellModWhite());
				}
				else
				{
					outputText("\n\nThe light sears into your eyes and mind as you stare into it. It’s so powerful, so infinite, so exquisitely painful that you wonder why you’d ever want to look at anything else, at anything at- with a mighty effort, you tear yourself away from it, gasping. All you can see is the afterimages, blaring white and yellow across your vision. You swipe around you blindly as you hear Jean-Claude bark with laughter, trying to keep the monster at arm’s length.");

					outputText("\n\n“<i>The taste of your own medicine, it is not so nice, eh? I will show you much nicer things in there in time intrus, don’t worry. Once you have learnt your place.</i>”");

					if (!player.hasPerk(PerkLib.BlindImmunity)) player.createStatusEffect(StatusEffects.Blind, 2 + player.inte / 20, 0, 0, 0);
				}
				if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
					if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
					if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
					enemyAI();
					return;
				}
				flags[kFLAGS.SPELLS_CAST]++;
				if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
				spellPerkUnlock();
				if(monster.HP <= monster.minHP()) doNext(endHpVictory);
				else enemyAI();
				return;
			}
			else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
			{
				outputText("You hold your [weapon] aloft and thrust your will forward, causing it to erupt in a blinding flash of light. The demons of the court scream and recoil from the radiant burst, clutching at their eyes and trampling over each other to get back.");

				outputText("\n\n<i>“Damn you, fight!”</i> Lethice screams, grabbing her whip and lashing out at the back-most demons, driving them forward -- and causing the middle bunch to be crushed between competing forces of retreating demons! <i>“Fight, or you'll be in the submission tanks for the rest of your miserable lives!”</i>");

				monster.createStatusEffect(StatusEffects.Blind, 5 * spellModWhite(), 0, 0, 0);
				outputText("\n\n");
				flags[kFLAGS.SPELLS_CAST]++;
				if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
				spellPerkUnlock();
				statScreenRefresh();
				enemyAI();
				return;
			}
			clearOutput();
			outputText("You glare at " + monster.a + monster.short + " and point at " + monster.pronoun2 + ".  A bright flash erupts before " + monster.pronoun2 + "!\n");
			if (monster is LivingStatue)
			{
				// noop
			}
			else if(rand(3) != 0) {
				outputText(" <b>" + monster.capitalA + monster.short + " ");
				if(monster.plural && monster.short != "imp horde") outputText("are blinded!</b>");
				else outputText("is blinded!</b>");
				monster.createStatusEffect(StatusEffects.Blind, 2 + player.inte / 20,0,0,0);
                if(monster is Diva){(monster as Diva).handlePlayerSpell("blind");}
				if(monster.short == "Isabella")
					if (SceneLib.isabellaFollowerScene.isabellaAccent()) outputText("\n\n\"<i>Nein! I cannot see!</i>\" cries Isabella.");
					else outputText("\n\n\"<i>No! I cannot see!</i>\" cries Isabella.");
				if(monster.short == "Kiha") outputText("\n\n\"<i>You think blindness will slow me down?  Attacks like that are only effective on those who don't know how to see with their other senses!</i>\" Kiha cries defiantly.");
				if(monster.short == "plain girl") {
					outputText("  Remarkably, it seems as if your spell has had no effect on her, and you nearly get clipped by a roundhouse as you stand, confused. The girl flashes a radiant smile at you, and the battle continues.");
					monster.removeStatusEffect(StatusEffects.Blind);
				}
			}
		}
		else outputText(monster.capitalA + monster.short + " blinked!");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		statScreenRefresh();
		enemyAI();
	}
	//(30) Whitefire – burns the enemy for 10 + int/3 + rand(int/2) * spellMod.
	public function spellWhitefire():void {
		var damage:Number;
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40)) player.HP -= spellCostWhite(40);
		else useMana(40, 5);
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) player.createStatusEffect(StatusEffects.CooldownSpellWhitefire,spellWhiteCooldown(),0,0,0);
		if (handleShell()){return;}
		if (monster is Doppleganger)
		{
			(monster as Doppleganger).handleSpellResistance("whitefire");
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			return;
		}
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
			damage = scalingBonusIntelligence() * spellModWhite();
			if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) damage *= 4;
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combatMagicalCritical();
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			damage *= 1.75;
			damage = doFireDamage(damage, true, true);
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			if(monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
			outputText("\n\n");
			if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
			checkAchievementDamage(damage);
			flags[kFLAGS.SPELLS_CAST]++;
			if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
			spellPerkUnlock();
			combat.heroBaneProc(damage);
			statScreenRefresh();
		}
		else
		{
			clearOutput();
			spellWhitefire2();
		}
		if (monster.HP <= monster.minHP())
		{
			doNext(endHpVictory);
		}
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
	public function spellWhitefire2():void {
		outputText("You narrow your eyes, focusing your mind with deadly intent.  You snap your fingers and " + monster.a + monster.short + " is enveloped in a flash of white flames!\n");
		if(monster is Diva){(monster as Diva).handlePlayerSpell("whitefire");}
		var damage:Number = scalingBonusIntelligence() * spellModWhite();
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) damage *= 4;
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//High damage to goes.
		damage = calcInfernoMod(damage);
		if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
		if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2);
		damage = Math.round(damage);
		outputText(monster.capitalA + monster.short + " takes ");
		damage = doFireDamage(damage, true, true);
		outputText(" damage.");
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		//Using fire attacks on the goo]
		if(monster.short == "goo-girl") {
			outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
			if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		}
		if(monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
	}

//(45) Lightning Bolt - base lighting spell
	public function spellLightningBolt():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(40)) player.HP -= spellCostWhite(40);
		else useMana(40, 5);
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) player.createStatusEffect(StatusEffects.CooldownSpellLightningBolt,spellWhiteCooldown(),0,0,0);
		if (handleShell()){return;}
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		spellLightningBolt2();
		if(monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}
	public function spellLightningBolt2():void {
		outputText("You charge out energy in your hand and fire it out in the form of a powerful bolt of lightning at " + monster.a + monster.short + " !\n");
		var damage:Number = scalingBonusIntelligence() * spellModWhite();
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) damage *= 4;
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
		damage = calcVoltageMod(damage);
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
		damage = Math.round(damage);
		//if (monster.short == "goo-girl") damage = Math.round(damage * 1.5); - pomyśleć czy bdą dostawać bonusowe obrażenia
		//if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2); - tak samo przemyśleć czy bedą dodatkowo ranione
		outputText(monster.capitalA + monster.short + " takes ");
		damage = doLightingDamage(damage, true, true);
		outputText(" damage.");
		//Using fire attacks on the goo]
		//if(monster.short == "goo-girl") {
		//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
		//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		//}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
	}
	
	//(50) Pyre Burst – aoe fire spell
	public function spellPyreBurst():void {
		var damage:Number;
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(200)) player.HP -= spellCostWhite(200);
		else useMana(200,5);
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) player.createStatusEffect(StatusEffects.CooldownSpellPyreBurst,spellWhiteCooldown(),0,0,0);
		if (handleShell()){return;}
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		else if (monster is Lethice && (monster as Lethice).fightPhase == 2)
		{
			//Attack gains burn DoT for 2-3 turns.
			outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!");
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
			damage = scalingBonusIntelligence() * spellModWhite();
			if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) damage *= 4;
			if (monster.plural == true) damage *= 5;
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 5;
			critChance += combatMagicalCritical();
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			damage *= 1.75;
			damage = doFireDamage(damage, true, true);
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		}
		else
		{
			clearOutput();
			outputText("You wave the signs with your hands before striking the grounds causing an expending wave of flames to wash over " + monster.a + monster.short + ".\n");
			damage = scalingBonusIntelligence() * spellModWhite();
			if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) damage *= 4;
			if (monster.plural == true) damage *= 5;
			//Determine if critical hit!
			var crit2:Boolean = false;
			var critChance2:int = 5;
			critChance2 += combatMagicalCritical();
			if (rand(100) < critChance2) {
				crit = true;
				damage *= 1.75;
			}
			//High damage to goes.
			damage = calcInfernoMod(damage);
			if (monster.short == "goo-girl") damage = Math.round(damage * 1.5);
			if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2);
			damage = Math.round(damage);
			outputText(monster.capitalA + monster.short + " takes ");
			damage = doFireDamage(damage, true, true);
			outputText(" damage.");
			if (crit == true) outputText(" <b>*Critical Hit!*</b>");
			//Using fire attacks on the goo]
			if(monster.short == "goo-girl") {
				outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
				if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
			}
		}
		if(monster.short == "Holli" && !monster.hasStatusEffect(StatusEffects.HolliBurning)) (monster as Holli).lightHolliOnFireMagically();
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if (monster.HP <= monster.minHP())
		{
			doNext(endHpVictory);
		}
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

//(50) Chain Lightning - aoe lighting spell
	public function spellChainLightning():void {
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(200)) player.HP -= spellCostWhite(200);
		else useMana(200,5);
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) player.createStatusEffect(StatusEffects.CooldownSpellChainLighting,spellWhiteCooldown(),0,0,0);
		if (handleShell()){return;}
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You charge energy in your hand and fire it out in the form of a powerful bolt of lightning at " + monster.a + monster.short + " ");
		var damage:Number = scalingBonusIntelligence() * spellModWhite();
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) damage *= 4;
		if (monster.plural == true) {
			outputText("that jumps from one target to another ");
			damage *= 5;
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
		//High damage to goes.
		damage = calcVoltageMod(damage);
		if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
		damage = Math.round(damage);
		//if (monster.short == "goo-girl") damage = Math.round(damage * 1.5); - pomyśleć czy bdą dostawać bonusowe obrażenia
		//if (monster.short == "tentacle beast") damage = Math.round(damage * 1.2); - tak samo przemyśleć czy bedą dodatkowo ranione
		outputText("for ");
		damage = doLightingDamage(damage, true, true);
		outputText(" damage.");
		//Using fire attacks on the goo]
		//if(monster.short == "goo-girl") {
		//outputText("  Your flames lick the girl's body and she opens her mouth in pained protest as you evaporate much of her moisture. When the fire passes, she seems a bit smaller and her slimy " + monster.skinTone + " skin has lost some of its shimmer.");
		//if(!monster.hasPerk(PerkLib.Acid)) monster.createPerk(PerkLib.Acid,0,0,0,0);
		//}
		if (crit == true) outputText(" <b>*Critical Hit!*</b>");
		outputText("\n\n");
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		checkAchievementDamage(damage);
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		combat.heroBaneProc(damage);
		statScreenRefresh();
		if(monster.HP <= monster.minHP()) doNext(endHpVictory);
		else enemyAI();
	}

//(35) Blizzard
	public function spellBlizzard():void {
		clearOutput();
		doNext(combatMenu);
		if (player.hasPerk(PerkLib.LastResort) && player.mana < spellCostWhite(50)) player.HP -= spellCostWhite(50);
		else useMana(50,5);
		if ((monster is FrostGiant || monster is YoungFrostGiant) && player.hasStatusEffect(StatusEffects.GiantBoulder)) {
			if (monster as FrostGiant) (monster as FrostGiant).giantBoulderHit(2);
			if (monster as YoungFrostGiant) (monster as YoungFrostGiant).youngGiantBoulderHit(2);
			enemyAI();
			return;
		}
		clearOutput();
		outputText("You utter words of power, summoning an ice storm.  It swirls arounds you, ensuring that you'll have more protection from the fire attacks for a few moments.\n\n");
		if (player.hasPerk(PerkLib.ColdMastery) || player.hasPerk(PerkLib.ColdAffinity)) {
			player.createStatusEffect(StatusEffects.Blizzard, 2 + player.inte / 10,0,0,0);
		}
		else {
			player.createStatusEffect(StatusEffects.Blizzard, 1 + player.inte / 25,0,0,0);
		}
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		statScreenRefresh();
		flags[kFLAGS.SPELLS_CAST]++;
		if(!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell,0,0,0,0);
		spellPerkUnlock();
		enemyAI();
	}

	private function handleShell():Boolean{
        if(monster.hasStatusEffect(StatusEffects.Shell)) {
            outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
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