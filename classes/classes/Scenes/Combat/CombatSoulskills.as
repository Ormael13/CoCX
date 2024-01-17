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
}
}