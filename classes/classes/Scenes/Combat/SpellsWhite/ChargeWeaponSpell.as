package classes.Scenes.Combat.SpellsWhite {
import classes.Items.ItemConstants;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.Scenes.Combat.CombatAbilities;
import classes.StatusEffects;

public class ChargeWeaponSpell extends AbstractWhiteSpell {
	public function ChargeWeaponSpell() {
		super(
			"Charge Weapon",
			"The Charge Weapon spell will surround your weapons in magical energy, causing them to do even more damage.  The effect lasts for a few combat turns.",
			TARGET_SELF,
			TIMING_LASTING,
			[TAG_BUFF]
		);
		baseManaCost = 60;
	}
	
	override public function get buttonName():String {
		return "Charge W.";
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.ChargeWeapon);
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsCharge);
	}
	
	override public function manaCost():Number {
		return super.manaCost() * costMultiplier();
	}
	
	override public function advance(display:Boolean):void {
		if (player.statusEffectv2(StatusEffects.ChargeWeapon) <= 0) {
			player.removeStatusEffect(StatusEffects.ChargeWeapon);
			if (player.hasPerk(PerkLib.SelfbuffsProficiencyEx) && player.mana >= CombatAbilities.ChargeWeapon.manaCost()) CombatAbilities.ChargeWeapon.autocast();
			else if (display) outputText("<b>Charged Weapon effect wore off!</b>\n\n");
		} else {
			if (!player.hasPerk(PerkLib.PureMagic)) player.addStatusValue(StatusEffects.ChargeWeapon, 2, -1);
		}
	}
	
	override protected function usabilityCheck():String {
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		if (player.weaponName == "fists" && !player.hasPerk(PerkLib.ImprovingNaturesBlueprintsNaturalWeapons)) {
			return "Charge weapon can't be casted on your bare fists.";
		}
		
		return "";
	}
	
	private function weaponSizeBoost():Number {
		var ab12:Number = 2;
		if (player.weapon == weapons.MGSWORD) ab12 *= 2;
		return ab12;
	}
	
	private function weaponSizeManaCost():Number {
		var ba21:Number = 0;
		if (player.weapon.isHybrid()) ba21 += 3;
		if (player.weapon.isSingleMedium()) ba21 += 2;
		if (player.weaponOff.isSingleMedium()) ba21 += 2;
		if (player.weapon.isSingleLarge()) ba21 += 4;
		if (player.weaponOff.isSingleLarge()) ba21 += 4;
		if (player.weapon.isSingleMassive()) ba21 += 8;
		if (player.weaponOff.isSingleMassive()) ba21 += 8;
		if (ba21 < 1) ba21 = 1;
		return ba21;
	}
	
	
	private function costMultiplier():Number {
		var spellChargeWeaponMultiplier:Number = 1;
		spellChargeWeaponMultiplier *= weaponSizeManaCost();
		if (player.hasStatusEffect(StatusEffects.SiegweirdTraining)) spellChargeWeaponMultiplier *= 0.5;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) spellChargeWeaponMultiplier *= 2;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) spellChargeWeaponMultiplier *= 2;
		if (player.hasPerk(PerkLib.SelfbuffsProficiencySu)) spellChargeWeaponMultiplier *= 2;
		return spellChargeWeaponMultiplier;
	}
	
	override protected function doSpellEffect(output:Boolean = true):void {
		var ChargeWeaponBoostCap:Number = 4;
		var ChargeWeaponBoost:Number = 5;
		if (player.hasPerk(PerkLib.SelfbuffsProficiency)) {
			var capB:Number = 1.2;
			if (player.hasPerk(PerkLib.SelfbuffsProficiencyEx)) capB += 0.8;
			if (player.hasPerk(PerkLib.SelfbuffsProficiencySu)) capB *= 5;
			ChargeWeaponBoostCap *= capB;
		}
		ChargeWeaponBoostCap *= ChargeWeaponBoost;
		if (player.hasPerk(PerkLib.DivineArmament)) {
			ChargeWeaponBoostCap *= 2;
			ChargeWeaponBoost *= 2;
		}
		//ChargeWeaponBoost += Math.round(player.intStat.max * 0.1); - może tylko jak bedzie mieć perk z prestige job: magus/warock/inny związany z spells (maybe only when they have a perk from the prestige job: magus/warlock/another related to spells)
		if (player.hasPerk(PerkLib.JobEnchanter)) ChargeWeaponBoost *= 1.2;
		ChargeWeaponBoost *= spellModWhite();
		//ChargeWeaponBoost = FnHelpers.FN.logScale(ChargeWeaponBoost,ChargeWeaponABC,10);
		if (ChargeWeaponBoost > ChargeWeaponBoostCap) ChargeWeaponBoost = ChargeWeaponBoostCap;
		ChargeWeaponBoost *= weaponSizeBoost();
		ChargeWeaponBoost = Math.round(ChargeWeaponBoost);
		var ChargeWeaponDuration:Number = 5;
		ChargeWeaponDuration += combat.magic.perkRelatedDurationBoosting();
		
		if(output) {
			outputText("You whisper the brief spell, the words of power cause mana to pour into your weapon as sparks of electricity burst into being. A halo of lightning crackles, surrounding your [weapon] with a fierce, magical charge, allowing it to deal more damage.");
		}
		player.createStatusEffect(StatusEffects.ChargeWeapon, ChargeWeaponBoost, ChargeWeaponDuration, 0, 0);
	}
}
}
