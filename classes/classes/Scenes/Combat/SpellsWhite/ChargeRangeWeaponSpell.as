package classes.Scenes.Combat.SpellsWhite {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.Scenes.Combat.CombatAbilities;
import classes.StatusEffects;

public class ChargeRangeWeaponSpell extends AbstractWhiteSpell {
	public function ChargeRangeWeaponSpell() {
		super(
			"Charge Range Weapon",
			"The Charge Range Weapon spell will surround your range weapons in magical energy, causing them to do even more damage.  The effect lasts for a few combat turns.",
			TARGET_SELF,
			TIMING_LASTING,
			[TAG_BUFF]
		);
		baseManaCost = 60;
	}
	
	override public function get buttonName():String {
		return "Charge RW.";
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.ChargeRWeapon);
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsChargeR);
	}
	
	override public function manaCost():Number {
		return super.manaCost() * costMultiplier();
	}
	
	override public function advance(display:Boolean):void {
		if (player.statusEffectv2(StatusEffects.ChargeRWeapon) <= 0) {
			player.removeStatusEffect(StatusEffects.ChargeRWeapon);
			if (player.hasPerk(PerkLib.SelfbuffsProficiencyEx) && player.mana >= CombatAbilities.ChargeRWeapon.manaCost()) CombatAbilities.ChargeRWeapon.autocast();
			else if (display) outputText("<b>Charged Range Weapon effect wore off!</b>\n\n");
		} else {
			if (!player.hasPerk(PerkLib.PureMagic)) player.addStatusValue(StatusEffects.ChargeRWeapon, 2, -1);
		}
	}
	
	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		if (player.weaponRangeName == "nothing") {
			return "Charge range weapon can't be casted without any range weapon.";
		}
		
		return "";
	}
	
	private function weaponSizeBoost():Number {
		var ab12r:Number = 1;/*
		if (player.weaponSpecials("") || player.weaponSpecials("Dual")) ab12 *= 2;
		if (player.weaponSpecials("Hybrid")) ab12 *= 2.5;
		if (player.weaponSpecials("Large") || player.weaponSpecials("Dual Large")) ab12 *= 3;
		if (player.weaponSpecials("Massive")) ab12 *= 4;
		if (player.weapon == weapons.MGSWORD) ab12 *= 2;*/
		return ab12r;
	}
	
	private function weaponSizeManaCost():Number {
		var ba21r:Number = 1;/*
		if (player.weaponSpecials("") || player.weaponSpecials("Dual Small")) ba21 *= 2;
		if (player.weaponSpecials("Hybrid")) ba21 *= 3;
		if (player.weaponSpecials("Large") || player.weaponSpecials("Dual")) ba21 *= 4;
		if (player.weaponSpecials("Massive") || player.weaponSpecials("Dual Large")) ba21 *= 8;*/
		return ba21r;
	}
	
	
	private function costMultiplier():Number {
		var spellChargeRangeWeaponMultiplier:Number = 1;
		spellChargeRangeWeaponMultiplier *= weaponSizeManaCost();
		if (player.hasStatusEffect(StatusEffects.SiegweirdTraining)) spellChargeRangeWeaponMultiplier *= 0.5;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) spellChargeRangeWeaponMultiplier *= 2;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) spellChargeRangeWeaponMultiplier *= 2;
		if (player.hasPerk(PerkLib.SelfbuffsProficiencySu)) spellChargeRangeWeaponMultiplier *= 2;
		return spellChargeRangeWeaponMultiplier;
	}
	
	override protected function doSpellEffect(output:Boolean = true):void {
		var ChargeRangeWeaponBoostCap:Number = 4;
		var ChargeRangeWeaponBoost:Number = 5;
		if (player.hasPerk(PerkLib.SelfbuffsProficiency)) {
			var capB:Number = 1.2;
			if (player.hasPerk(PerkLib.SelfbuffsProficiencyEx)) capB += 0.8;
			if (player.hasPerk(PerkLib.SelfbuffsProficiencySu)) capB *= 5;
			ChargeRangeWeaponBoostCap *= capB;
		}
		ChargeRangeWeaponBoostCap *= ChargeRangeWeaponBoost;
		if (player.hasPerk(PerkLib.DivineArmament)) {
			ChargeRangeWeaponBoostCap *= 2;
			ChargeRangeWeaponBoost *= 2;
		}
		//ChargeRangeWeaponBoost += Math.round(player.intStat.max * 0.1); - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells
		if (player.hasPerk(PerkLib.JobEnchanter)) ChargeRangeWeaponBoost *= 1.2;
		ChargeRangeWeaponBoost *= spellModWhite();
		//ChargeRangeWeaponBoost = FnHelpers.FN.logScale(ChargeRangeWeaponBoost,ChargeWeaponABC,10);
		if (ChargeRangeWeaponBoost > ChargeRangeWeaponBoostCap) ChargeRangeWeaponBoost = ChargeRangeWeaponBoostCap;
		ChargeRangeWeaponBoost *= weaponSizeBoost();
		ChargeRangeWeaponBoost = Math.round(ChargeRangeWeaponBoost);
		var ChargeRangeWeaponDuration:Number = 5;
		ChargeRangeWeaponDuration += combat.magic.perkRelatedDurationBoosting();
		
		if(output) {
			outputText("You whisper the brief spell, the words of power cause mana to pour into your weapon as sparks of electricity burst into being. A halo of lightning hums, swirling around your [weaponrange] with a steady charge. Your ammunition crackles with hints of a magical charge as you prepare to fire, allowing your shots to deal more damage.");
		}
		player.createStatusEffect(StatusEffects.ChargeRWeapon, ChargeRangeWeaponBoost, ChargeRangeWeaponDuration, 0, 0);
	}
}
}
