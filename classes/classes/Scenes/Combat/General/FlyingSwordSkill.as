package classes.Scenes.Combat.General {
import classes.PerkLib;
import classes.StatusEffects;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Camp.TrainingDummy;
import classes.Scenes.Combat.AbstractGeneral;
import classes.CoC;

public class FlyingSwordSkill extends AbstractGeneral {
	public var preTurnAttack:Boolean = false;
    public function FlyingSwordSkill() {
        super(
            "Flying Sword",
            "Attack the oppenent with your flying sword",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING],
            null
        )
		lastAttackType = Combat.LAST_ATTACK_PHYS;
    }

    override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

		//Cannot attack with a single flying sword while flying on it, but having more than 1 is fine
		if (player.hasStatusEffect(StatusEffects.Flying) && player.statusEffectv2(StatusEffects.Flying) == 1 && player.weaponFlyingSwords.count == 1) {
			return "You're currently using your sword to fly, you can't attack with it as well.";
		}

        return "";
    }

	override public function describeEffectVs(target:Monster):String {
		var element:String = AllTags[player.weaponFlyingSwords.element].name.toLowerCase();
		
		var hitCounter:int = player.weaponFlyingSwords.count;
		//If flying on flying sword, take 1 sword away for calculations
		if (CoC.instance.inCombat && player.hasStatusEffect(StatusEffects.Flying) && player.statusEffectv2(StatusEffects.Flying) == 1) {
			hitCounter--;
		}

		return "Deals ~" + numberFormat(calcDamage(target) * hitCounter) + " " + element +" damage.";
	}

	override public function get isKnown():Boolean {
		return player.weaponFlyingSwordsName != "nothing";
	}

	override public function sfCost():int {
		return combat.flyingSwordAttackCost();
	}

	public function calcDamage(monster:Monster):Number {
		var damage:Number = player.weaponFlyingSwordsAttack * 25;
		damage += scalingBonusWisdom() * 0.5;
		if (player.hasPerk(PerkLib.FlyingSwordPath) && player.perkv1(PerkLib.FlyingSwordPath) > 0) {
			if (player.hasPerk(PerkLib.SpeedDemon) && player.weaponFlyingSwordsPerk != "Large" && player.weaponFlyingSwordsPerk != "Massive") {
				damage += player.spe;
				damage += scalingBonusSpeed() * 0.2;
			}
			if (player.hasPerk(PerkLib.QuickStrike) && player.weaponFlyingSwordsPerk == "Small") {
				damage += (player.spe / 2);
				damage += scalingBonusSpeed() * 0.1;
			}
		}
		damage *= 1 + player.perkv1(PerkLib.FlyingSwordPath);
		//Weapon addition!
		damage = combat.flyingSwordAttackModifier(damage);
		if (player.weaponFlyingSwords.perk == "Large") damage *= 4;
		if (player.weaponFlyingSwords.perk == "Massive") damage *= 10;
		var sizeMatters:Number = 1;
		sizeMatters += (0.01 * combat.masterySwordLevel());
		if (player.weaponFlyingSwords.perk == "Small") sizeMatters += 0.01 * combat.weaponSizeSmall();
		else if (player.weaponFlyingSwords.perk == "Large") sizeMatters += 0.01 * combat.weaponSizeLarge();
		else if (player.weaponFlyingSwords.perk == "Massive") sizeMatters += 0.01 * combat.weaponSizeMassive();
		else if (player.weaponFlyingSwords.perk == "") sizeMatters += 0.01 * combat.weaponSizeNormal();
		if (sizeMatters > 1) damage *= sizeMatters;
		if (player.hasPerk(PerkLib.SwordIntentAura)) damage *= 2;
		if (player.statStore.hasBuff("SwordIntentAura")) damage += combat.layerSwordIntentAuraOnThis(damage);
		return Math.round(damage);
	}

    override public function doEffect(display:Boolean = true):void {
		if (!preTurnAttack) clearOutput();
    	var damage:Number = calcDamage(monster);

		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 25;
		critChance += combatPhysicalCritical();
		if (player.weaponFlyingSwords == weaponsflyingswords.ASAUCHI) critChance -= 15;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}

		var hitCounter:int = player.weaponFlyingSwords.count;
		//If flying on flying sword, take 1 sword away for calculations
		if (player.hasStatusEffect(StatusEffects.Flying) && player.statusEffectv2(StatusEffects.Flying) == 1) {
			hitCounter--;
		}

		damage = Math.round(damage);

		if (display) outputText("You send a bit of soulforce to " + player.weaponFlyingSwordsName+" and with a graceful hand gesture direct it towards [themonster]. " + 
			(hitCounter == 1?"It slashes":"They slash") + " the target, leaving " + (hitCounter == 1?"a minor wound":"minor wounds") + ". ");

		var damageFunc:Function;
		switch(player.weaponFlyingSwords.element) {
			case TAG_FIRE: 				damageFunc = doFireDamage;
										break;
			case TAG_ICE: 				damageFunc = doIceDamage;
										break;
			case TAG_LIGHTNING: 		damageFunc = doLightningDamage;
										break;
			case TAG_DARKNESS: 			damageFunc = doDarknessDamage;
										break;
			case TAG_POISON: 			damageFunc = doPoisonDamage;
										break;
			case TAG_WIND: 				damageFunc = doWindDamage;
										break;
			case TAG_WATER: 			damageFunc = doWaterDamage;
										break;
			case TAG_EARTH: 			damageFunc = doEarthDamage;
										break;
			case TAG_ACID: 				damageFunc = doAcidDamage;
										break;
			case TAG_PLASMA: 			damageFunc = doPlasmaDamage;
										break;
			default: 					damageFunc = doPhysicalDamage;
										break;
		}

		for(var hit:int = 0; hit < hitCounter; hit++)
		{
			damageFunc(damage, true, display);
			if (player.statStore.hasBuff("FoxflamePelt")) combat.layerFoxflamePeltOnThis(damage, display);
			
		}
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		
		combat.WeaponFlyingSwordsStatusProcs();
		var baseMasteryXP:Number = 1;
		if (player.hasPerk(PerkLib.MeleeWeaponsMastery)) baseMasteryXP += 2;
        if (player.hasPerk(PerkLib.SwordIntentAura)) baseMasteryXP += 2;
		if (monster is TrainingDummy && flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 1) {
			var bMXPMulti:Number = 1;
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 2) bMXPMulti += 1.5;
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 3) bMXPMulti += 2;
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 4) bMXPMulti += 2.5;
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 5) bMXPMulti += 3;
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] > 6) bMXPMulti += 5;
			baseMasteryXP *= bMXPMulti;
		}
		var critCounter:int = 1;
		if (crit) {
			critCounter++;
			if (player.hasPerk(PerkLib.MeleeWeaponsMasteryEx)) critCounter *= 2;
		}
		var meleeMasteryEXPgains:Number = baseMasteryXP * hitCounter * critCounter;
		combat.swordXP(meleeMasteryEXPgains, false);
		if (player.weaponFlyingSwords.perk == "Small") combat.weaponSmallMastery(meleeMasteryEXPgains);
		else if (player.weaponFlyingSwords.perk == "Large") combat.weaponLargeMastery(meleeMasteryEXPgains);
		else if (player.weaponFlyingSwords.perk == "Massive") combat.weaponMassiveMastery(meleeMasteryEXPgains);
		else if (player.weaponFlyingSwords.perk == "") combat.weaponNormalMastery(meleeMasteryEXPgains);
		if (display) outputText("\n\n");
    }
}
}