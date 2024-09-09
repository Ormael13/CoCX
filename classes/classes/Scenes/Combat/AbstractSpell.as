package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.NPCs.SiegweirdBoss;
import classes.StatusEffects;
import classes.lists.Gender;
import classes.Scenes.NPCs.Forgefather;

/**
 * In addition to the CombatAbility:
 *
 * 1. Put spell effect in doSpellEffect, not doEffect
 * 2. Configure baseManaCost, baseWrathCost, isBloodMagicApplicable, isLastResortApplicable in the constructor and total mana cost would be calculated automatically
 * 3. In useResources call super to use mana/hp/wrath, then apply cooldown.
 */
public class AbstractSpell extends CombatAbility {
	
	protected var isBloodMagicApplicable:Boolean = true;
	protected var isLastResortApplicable:Boolean = true;
	protected var useManaType:int;
	protected var canBackfire:Boolean = false;
	protected var isAutocasting:Boolean = false;
	protected var magicAddonProcs:int = 1;
	
	function AbstractSpell(
			name:String,
			desc:String,
			targetType:int,
			timingType:int,
			useManaType:int,
			tags:/*int*/Array
	) {
		super(name, desc, targetType, timingType, tags);
		this.useManaType = useManaType;
		this.lastAttackType = Combat.LAST_ATTACK_SPELL;
	}

	override public function manaCost():Number {
		return combat.finalSpellCost(super.manaCost(), useManaType); //includes modifiers
	}
	
	override public function useResources():void {
		super.useResources();
		//var realManaCost:Number = combat.finalSpellCost(manaCost(), useManaType);
		var realManaCost:Number = manaCost();
		var realWrathCost:Number = wrathCost();
		if (realManaCost > 0) {
			// Blood magic first
			if (isBloodMagicApplicable && (player.hasStatusEffect(StatusEffects.BloodMage) || player.hasPerk(PerkLib.BloodMage)))
				player.HP -= realManaCost;
			else {
				// Normal mana usage, if possible
				var manaUsed:Number = Math.min(realManaCost, player.mana);
				useMana(manaUsed); // no type - it's already accounted for!!!
				realManaCost -= manaUsed;
				// Now last resort, if not enough mana
				if (realManaCost > 0 && isLastResortApplicable && player.hasPerk(PerkLib.LastResort))
					player.HP -= realManaCost;
			}
		}
		combat.darkRitualCheckDamage();
		player.wrath -= realWrathCost;
		
		flags[kFLAGS.SPELLS_CAST]++;
		if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell, 0, 0, 0, 0);
		combat.spellPerkUnlock();
	}
	
	override protected function usabilityCheck():String {
		
		// Run all check applicable to all abilities
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		// Run our checks
		//var finalCost:Number = combat.finalSpellCost(manaCost(), useManaType);
		var finalCost:Number = this.manaCost();
		if (isBloodMagicApplicable && (player.hasStatusEffect(StatusEffects.BloodMage) || player.hasPerk(PerkLib.BloodMage))) {
			if (player.HP - player.minHP() <= finalCost) {
				return "Your HP is too low to cast this spell."
			}
		} else if (isLastResortApplicable && player.hasPerk(PerkLib.LastResort)) {
			if (player.mana + (player.HP - player.minHP()) < finalCost) {
				return "Your HP and mana are too low to cast this spell.";
			}
		} else if (player.mana < finalCost)
			return "Your mana is too low to cast this spell.";

		if (targetType == TARGET_ENEMY) {
			if (monster.hasStatusEffect(StatusEffects.Dig)) {
				return "You can only use buff magic while underground."
			}
		}
		
		if (player.wrath < wrathCost()) {
			return "Your wrath is too low to cast this spell."
		}
		return ""
	}
	
	protected function doSpellEffect(display:Boolean = true):void {
		throw new Error("Method performSpellEffect() not implemented for ability " + name);
	}
	
	protected function preSpellEffect(display:Boolean = true):void {
		MagicPrefixEffect(display);
	}
	
	protected function postSpellEffect(display:Boolean = true):void {
		MagicAddonEffect(magicAddonProcs);
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
		if (targetType == TARGET_ENEMY && hasTag(TAG_LUSTDMG)) combat.teases.fueledByDesireHeal(display);
		if (monster is SiegweirdBoss) (monster as SiegweirdBoss).castedSpellThisTurn = true;
		if (targetType == TARGET_ENEMY && hasTag(TAG_DAMAGING) && player.hasPerk(PerkLib.BrutalSpells)) combat.magic.brutalSpellsEffect(display);
	}
	
	public override function doEffect(display:Boolean = true):void {
		if (monster.hasStatusEffect(StatusEffects.Shell)) {
			if (display) {
				outputText("As soon as your magic touches the multicolored shell around [themonster], it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			}
		} else if (monster.hasStatusEffect(StatusEffects.LowtierMagicImmunity) && hasTag(TAG_DAMAGING) && hasTag(TAG_TIER1)) {
			if (display) {
				outputText("As soon as your magic touches [themonster], it sizzles and fades to nothing.\n\n");
			}
		} else {
			if (!isAutocasting) preSpellEffect(display);
			doSpellEffect(display);
			if(monster.hasStatusEffect(StatusEffects.Blacken) && (hasTag(TAG_FIRE) || hasTag(TAG_AOE))) {
				monster.removeStatusEffect(StatusEffects.Blacken);
				player.removeStatusEffect(StatusEffects.Blind);
				player.buff("Black Gas").remove();
			}
			if (!isAutocasting) postSpellEffect(display);
			if (display) {
				outputText("\n\n");
			}
		}
	}
	
	// Hacky way to disable backfire. Don't forget to enable back!
	public var backfireEnabled:Boolean = true;
	/**
	 * Autocast spell at combat start (guaranteed success, no output, interception)
	 */
	public function autocast():void {
		backfireEnabled = false;
		isAutocasting = true;
		perform(false,false,false);
		backfireEnabled = canBackfire;
		isAutocasting = false;
		outputText("<b>"+name+" was autocasted successfully.</b>\n\n");
	}
	
	///////////////////////////
	// Shortcuts and utilities
	///////////////////////////
	
	protected function MagicPrefixEffect(display:Boolean = true):void {
		combat.magic.MagicPrefixEffect(display);
	}
	
	protected function MagicAddonEffect(numberOfProcs:Number = 1):void {
		combat.magic.MagicAddonEffect(numberOfProcs);
	}
	
	public function spellModByCat(category:int):Number {
		switch (category) {
			case CAT_SPELL_WHITE:
				return spellModWhite();
			case CAT_SPELL_BLACK:
				return spellModBlack();
			case CAT_SPELL_GREY:
				return spellModGrey();
			case CAT_SPELL_BLOOD:
				return spellModBlood();
			case CAT_SPELL_HEX:
				return spellModBlack();
			case CAT_SPELL_NECRO:
				return spellModBlack();
			case CAT_SPELL_GREEN:
				return spellModGreen();
			default:
				return spellMod();
		}
	}
	
	/**
	 * Apply bonuses from perks, items, and other sources (including target lustVuln) to a lust damage.
	 * Returned value is rounded.
	 * @param baseDamage Base lust damage (typically player.inte/5)
	 * @param monster Target or null if evaluating damage outside combat
	 * @param category CAT_XXX
	 * @param randomize If false, use 0.5 for random roll
	 * @return
	 */
	protected function adjustLustDamage(
			baseDamage:Number,
			monster:Monster,
			category:int,
			randomize:Boolean=true,
			applyOmnicaster:Boolean = true
	): Number {
		var lustDmg:Number = baseDamage;
		lustDmg *= spellModByCat(category);
		if (monster != null) {
			var randomBonus:Number = (monster.lib - monster.inte * 2 + monster.cor)/5;
			lustDmg += randomize ? rand(randomBonus) : 0.5*randomBonus;
			lustDmg *= monster.lustVuln;
			if (hasTag(TAG_AOE) && monster.plural) {
				lustDmg *= 5;
			}
		}
		if(player.hasPerk(PerkLib.ArcaneLash) && player.isWhipTypeWeapon()) lustDmg *= 1.5;
		if(player.hasStatusEffect(StatusEffects.AlvinaTraining2)) lustDmg *= 1.2;
		lustDmg = combat.teases.fueledByDesireDamageBonus(lustDmg);
		if (monster != null) {
			if (player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34) lustDmg *= 1.2;
			lustDmg *= corruptMagicPerkFactor(monster);
		}
		if (player.armor == armors.ELFDRES && player.isElf()) lustDmg *= 2;
		if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDmg *= 2;

		if (applyOmnicaster && (category != CAT_SPELL_GREEN || !player.hasPerk(PerkLib.ArcaneVenom))) {
			lustDmg *= omnicasterDamageFactor();
		}

		return Math.round(lustDmg);
	}
	
	/**
	 * Apply bonuses from perks, items, and other sources to a damage.
	 * Returned value is rounded.
	 * @param baseDamage Base damage value (typically X*scalingBonusSomething)
	 * @param damageType DamageType.XXX constant
	 * @param category CombatAbility.CATEGORY_XXX constant
	 * @param applyOmnicaster Determines if Omnicaster perk can be applied
	 * @param casting Determines if elemental spell counter (like Raging Inferno) should be increased
	 * @return
	 */
	public function adjustSpellDamage(
			baseDamage:Number,
			damageType:int,
			category:int,
			monster:Monster,
			applyOmnicaster:Boolean = true,
            casting:Boolean = true
	):Number {
		var damage:Number = baseDamage;
		
		damage *= spellModByCat(category);
		
		switch (damageType) {
			case DamageType.GENERIC: {
				/* don't change */
				break;
			}
			case DamageType.PHYSICAL: {
				break;
			}
			case DamageType.MAGICAL: {
				if (category == CAT_SPELL_BLOOD) {
					if (player.hasPerk(PerkLib.BloodMastery)) damage *= 2;
					damage *= combat.bloodDamageBoostedByDao();
				}
				break;
			}
			case DamageType.FIRE: {
				damage = calcInfernoMod(damage, casting);
				if (player.armor == armors.BLIZZ_K) damage *= 0.5;
				if (player.headJewelry == headjewelries.SNOWFH) damage *= 0.7;
				if (monster != null) {
					if (monster.short == "goo-girl") damage *= 1.5;
					if (monster.short == "tentacle beast") damage *= 1.2;
				}
				if (player.statStore.hasBuff("AjidAji")) damage *= 1.3;
				if (Forgefather.channelInlay == "ruby" && Forgefather.refinement == 3) damage *= 1.25
				if (Forgefather.channelInlay == "ruby" && Forgefather.refinement == 4) damage *= 1.5
				if (Forgefather.gem == "ruby" && Forgefather.refinement == 3) damage *= 1.12
				if (Forgefather.gem == "ruby" && Forgefather.refinement == 4) damage *= 1.25
				damage *= combat.fireDamageBoostedByDao();
				break;
			}
			case DamageType.LIGHTNING: {
				damage = calcVoltageMod(damage, casting);
				if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
				if (Forgefather.channelInlay == "topaz" && Forgefather.refinement == 3) damage *= 1.25
				if (Forgefather.channelInlay == "topaz" && Forgefather.refinement == 4) damage *= 1.5
				if (Forgefather.gem == "topaz" && Forgefather.refinement == 3) damage *= 1.12
				if (Forgefather.gem == "topaz" && Forgefather.refinement == 4) damage *= 1.25
				damage *= combat.lightningDamageBoostedByDao();
				break;
			}
			case DamageType.ICE: {
				damage = calcGlacialMod(damage, casting);
				if (combat.wearingWinterScarf()) damage *= 1.2;
				if (player.armor == armors.BLIZZ_K) damage *= 1.5;
				if (player.headJewelry == headjewelries.SNOWFH) damage *= 1.3;
				if (Forgefather.channelInlay == "sapphire" && Forgefather.refinement == 3) damage *= 1.25
				if (Forgefather.channelInlay == "sapphire" && Forgefather.refinement == 4) damage *= 1.5
				if (Forgefather.gem == "sapphire" && Forgefather.refinement == 3) damage *= 1.12
				if (Forgefather.gem == "sapphire" && Forgefather.refinement == 4) damage *= 1.25
				damage *= combat.iceDamageBoostedByDao();
				break;
			}
			case DamageType.DARKNESS: {
				damage = calcEclypseMod(damage, casting);
				if (Forgefather.channelInlay == "amethyst" && Forgefather.refinement == 3) damage *= 1.25
				if (Forgefather.channelInlay == "amethyst" && Forgefather.refinement == 4) damage *= 1.5
				if (Forgefather.gem == "amethyst" && Forgefather.refinement == 3) damage *= 1.12
				if (Forgefather.gem == "amethyst" && Forgefather.refinement == 4) damage *= 1.25
				damage *= combat.darknessDamageBoostedByDao();
				break;
			}
			case DamageType.WATER: {
				damage = calcTideMod(damage, casting);
				damage *= combat.waterDamageBoostedByDao();
				break;
			}
			case DamageType.WIND: {
				damage = calcGaleMod(damage, casting);
				damage *= combat.windDamageBoostedByDao();
				break;
			}
			case DamageType.EARTH: {
				damage = calcQuakeMod(damage, casting);
				damage *= combat.earthDamageBoostedByDao();
				break;
			}
			case DamageType.ACID: {
				damage = calcCorrosionMod(damage, casting);
				damage *= combat.acidDamageBoostedByDao();
				break;
			}
			case DamageType.TRUE: {
				break;
			}
		}
		if (monster != null) {
			if (hasTag(TAG_AOE) && (monster.plural || monster.hasPerk(PerkLib.EnemyGigantType) || monster.hasPerk(PerkLib.EnemyColossalType))) damage *= 5;
			if (category == CAT_SPELL_WHITE || category == CAT_SPELL_DIVINE) {
				if (player.hasPerk(PerkLib.DivineKnowledge) && monster.cor > 65) {
					damage *= 1.2;
				}
				damage *= pureMagicPerkFactor(monster);
			}
			if (category == CAT_SPELL_BLACK || category == CAT_SPELL_HEX) {
				if (player.hasPerk(PerkLib.HexKnowledge) && monster.cor < 34) {
					damage *= 1.2;
				}
				damage *= corruptMagicPerkFactor(monster);
			}
		}
		if (applyOmnicaster) {
			damage *= omnicasterDamageFactor();
		}
		
		return Math.round(damage);
	}
	
	public static function corruptMagicPerkFactor(monster:Monster):Number {
		if (monster == null) return 1.0;
		if (!player.hasPerk(PerkLib.CorruptMagic)) return 1.0;
		
		if (monster.cor >= 66) return 1.0;
		else if (monster.cor >= 50) return 1.1;
		else if (monster.cor >= 25) return 1.2;
		else if (monster.cor >= 10) return 1.3;
		else return 1.4;
	}
	
	public static function pureMagicPerkFactor(monster:Monster):Number {
		if (monster == null) return 1.0
		if (!player.hasPerk(PerkLib.PureMagic)) return 1.0;
		
		if (monster.cor < 33) return 1.0;
		else if (monster.cor < 50) return 1.1;
		else if (monster.cor < 75) return 1.2;
		else if (monster.cor < 90) return 1.3;
		else return 1.4
	}
    
    public static function omnicasterDamageFactor_gazer():Number {
        if (player.hasPerk(PerkLib.Omnicaster)) {
			if (player.perkv1(IMutationsLib.GazerEyesIM) >= 4) return 1;
			else if (player.perkv1(IMutationsLib.GazerEyesIM) >= 3) return 0.5;
			else if (player.perkv1(IMutationsLib.GazerEyesIM) >= 2) return 0.3;
			else return 0.2;
		}
        else return 0.0;
    }
	
	public static function omnicasterRepeatCount_gazer():int {
		if (player.hasPerk(PerkLib.Omnicaster)) {
			if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) return 10;
			else if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 8) return 8;
			else return 6;
		}
        else return 1;
	}
    
    public static function omnicasterDamageFactor_osc():Number {
		if ((player.isStaffTypeWeapon() || player.weapon.isWandType() || player.weaponOff.isWandType() || player.isPartiallyStaffTypeWeapon()) && player.hasPerk(PerkLib.OffensiveStaffChanneling)) {
			if (player.weapon.isWandType() || player.weaponOff.isWandType() || player.isPartiallyStaffTypeWeapon()) return 0.8;
			else return 0.7;
		}
        else return 0.0;
    }
	
	public static function omnicasterRepeatCount_osc():int {
		if ((player.isStaffTypeWeapon() || player.weapon.isWandType() || player.weaponOff.isWandType() || player.isPartiallyStaffTypeWeapon()) && player.hasPerk(PerkLib.OffensiveStaffChanneling)) {
			if (player.weapon.isWandType() || player.weaponOff.isWandType() || player.isPartiallyStaffTypeWeapon()) return 2;
			else return 3;
		}
        else return 1;
	}

    public static function oscOverGazer():Boolean {
        //you still can attack, so you CAN use your staff
        //damageFactors return 0 if not present
        return omnicasterDamageFactor_osc() * omnicasterRepeatCount_osc() > omnicasterDamageFactor_gazer() * omnicasterRepeatCount_gazer()
    }
	
	public static function omnicasterDamageFactor():Number {
        if ((player.isStaffTypeWeapon() || player.weapon.isWandType() || player.weaponOff.isWandType() || player.isPartiallyStaffTypeWeapon()) && player.hasPerk(PerkLib.OffensiveStaffChanneling)) {
            if (player.hasPerk(PerkLib.Omnicaster) && !oscOverGazer())
                return omnicasterDamageFactor_gazer() * 1.2;
            else
                return omnicasterDamageFactor_osc();
        }
        else {
            if (player.hasPerk(PerkLib.Omnicaster))
                return omnicasterDamageFactor_gazer();
            else
                return 1.0;
        }
	}
	
	public static function omnicasterRepeatCount():int {
        if (!player.hasPerk(PerkLib.Omnicaster) &&
                !(player.isStaffTypeWeapon() || player.weapon.isWandType() || player.weaponOff.isWandType() || player.isPartiallyStaffTypeWeapon()) && player.hasPerk(PerkLib.OffensiveStaffChanneling))
            return 1;
        return oscOverGazer() ? omnicasterRepeatCount_osc() : omnicasterRepeatCount_gazer();
	}
	
	public function calcBackfirePercent():int {
		if (!canBackfire) return 0;
		//30% backfire!
		var backfire:int = 30;
		if (player.hasStatusEffect(StatusEffects.AlvinaTraining)) backfire -= 10;
		if (player.hasPerk(PerkLib.FocusedMind)) backfire -= 10;
		backfire -= (player.inte * 0.15);
		if (backfire < 5 && player.hasPerk(PerkLib.FocusedMind)) backfire = 5;
		else if (backfire < 15) backfire = 15;
		return backfire
	}
	
	public static function stackingArcaneVenom():Number {
		var sAV:Number = 0;
		sAV += Math.round((player.intStat.core.value + player.intStat.train.value) / 50);
		return sAV;
	}
	
	public function bloodAffinityBoost():Number {
		var bAB:Number = 1;
		if (player.hasPerk(PerkLib.BloodAffinity)) bAB += 1;
		return bAB;
	}

	/**
	 * Award tease exp if nessecary, and apply verdent leech effects
	 * @param hits (int) - number of hits applied by the lust spell
	 */
	protected function postLustSpellEffect(hits:int):void {
		if (player.hasPerk(PerkLib.EromancyMaster)) combat.teaseXP((1 + combat.bonusExpAfterSuccesfullTease()) * hits);
		if (player.hasPerk(PerkLib.VerdantLeech)) {
			if (monster.lustVuln != 0 && !player.enemiesImmuneToLustResistanceDebuff()) monster.lustVuln += hits * 0.025;
			HPChange(Math.round(player.maxHP() * 0.01 * hits), false);
		}
	}

	/**
	 * Do a crit roll and apply crit multiplier.
	 * Deal damage once or repeatedly (if Omnicaster and param set). Does NOT apply Omnicaster damage downscale!
	 * Also prints "Monster takes N N N N damage. Critical Hit!"
	 * @param lustDmg Lust damage to deal
	 * @param Spell category (e.g. CAT_SPELL_GREEN)
	 * @param omnicaterRepeat Determine if spell should hit multiple times
	 * @return {Array} [Total damage dealt (int), number of hits (int), crit or not (boolean)]
	 */
	protected function critAndRepeatLust(
			display:Boolean,
			lustDmg:Number,
			category:int,
			displayDamageOnly:Boolean=false,
			omnicasterRepeat:Boolean=true
	):Array {
		
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5 + combat.teases.combatTeaseCritical();
        if (player.perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 4) critChance += 10;
		if (player.perkv1(IMutationsLib.GazerEyesIM) >= 3) critChance += 10;
		if (player.perkv1(IMutationsLib.GazerEyesIM) >= 4) critChance += 25;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (critChance > 0 && rand(100) < critChance) {
			crit = true;
			lustDmg *= 1.75;
		}

		var repeats:int = 1;
		if (omnicasterRepeat) {
			if (category == CAT_SPELL_GREEN && player.hasPerk(PerkLib.ArcaneVenom)) {
				repeats += stackingArcaneVenom();
			} else {
				repeats = omnicasterRepeatCount();
			}
		}

		var i:int = repeats;
		while (i-->0) {
			if (display) outputText(" ");
			monster.teased(lustDmg, false, display || displayDamageOnly);
		}
		if (display) {
			if (crit) outputText(" <b>*Critical Hit!*</b>");
		}

		return [lustDmg * repeats, repeats, crit];
	}
	
	/**
	 * Do a crit roll and apply crit multiplier.
	 * Deal damage once or repeatedly (if Omnicaster and param set). Does NOT apply Omnicaster damage downscale!
	 * Also prints "Monster takes N N N N damage. Critical Hit!"
	 * @param damage Damage to deal
	 * @param damageType Damage type (DamageType.XXX)
	 * @return {Number} Total damage dealt, with crit and omnicaster adjustment
	 */
	protected function critAndRepeatDamage(
			display:Boolean,
			damage:Number,
			damageType:int,
			displayDamageOnly:Boolean=false,
			omnicasterRepeat:Boolean=true,
			convergenceRepeat:Boolean=false
	):Number {
		if (display) {
			outputText("[Themonster] takes ");
		}
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5 + combatMagicalCritical();
        if (player.perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 4) critChance += 10;
		if (player.perkv1(IMutationsLib.GazerEyesIM) >= 3) critChance += 10;
		if (player.perkv1(IMutationsLib.GazerEyesIM) >= 4) critChance += 25;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (critChance > 0 && rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		
		var damageFn:Function;
		switch (damageType) {
			case DamageType.FIRE:
				damageFn = doFireDamage;
				break;
			case DamageType.DARKNESS:
				damageFn = doDarknessDamage;
				break;
			case DamageType.ICE:
				damageFn = doIceDamage;
				break;
			case DamageType.LIGHTNING:
				damageFn = doLightningDamage;
				break;
			case DamageType.WATER:
				damageFn = doWaterDamage;
				break;
			case DamageType.WIND:
				damageFn = doWindDamage;
				break;
			case DamageType.EARTH:
				damageFn = doEarthDamage;
				break;
			case DamageType.ACID:
				damageFn = doAcidDamage;
				break;
			case DamageType.MAGICAL:
				damageFn = doMagicDamage;
				break;
			case DamageType.PHYSICAL:
			default:
				damageFn = doDamage;
		}
		var repeats:int = omnicasterRepeat ? omnicasterRepeatCount() : 1;
		if (convergenceRepeat && player.hasPerk(PerkLib.Convergence) && !monster.hasPerk(PerkLib.EnemyGroupType) && !monster.hasPerk(PerkLib.EnemyLargeGroupType) && !monster.hasPerk(PerkLib.Enemy300Type)) {
			if (player.hasPerk(PerkLib.SuperConvergence)) repeats *= 3;
			else repeats *= 2;
			if (monster.hasPerk(PerkLib.EnemyGigantType) || monster.hasPerk(PerkLib.EnemyColossalType)) repeats *= 3;
		}
		var i:int = repeats;
		while (i-->0) {
			damageFn(damage, true, display || displayDamageOnly);
		}
		if (display) {
			outputText(" damage.");
			if (crit) outputText(" <b>*Critical Hit!*</b>");
		}
		return damage*repeats;
	}
	
	protected function backfireEffect(display:Boolean = true):void {
		if (display) {
			outputText("An errant sexual thought crosses your mind, and <b>you lose control of the spell!</b>  Your ");
			switch (player.gender) {
				case Gender.GENDER_NONE:
					outputText("[asshole] tingles with a desire to be filled as your libido spins out of control.");
					break;
				case Gender.GENDER_MALE:
					if (player.cockTotal() == 1) outputText("[cock] twitches obscenely and drips with pre-cum as your libido spins out of control.");
					else outputText("[cocks] twitch obscenely and drip with pre-cum as your libido spins out of control.");
					break;
				case Gender.GENDER_FEMALE:
					outputText("[vagina] becomes puffy, hot, and ready to be touched as the magic diverts into it.");
					break;
				case Gender.GENDER_HERM:
					outputText("[vagina] and [cocks] overfill with blood, becoming puffy and incredibly sensitive as the magic focuses on them.");
					break;
			}
		}
		dynStats("lib", .25, "lus", Math.max(player.maxLust() * 0.01, 15));
	}
	
	/**
	 * Do a backfire roll; if backfired, perform its effect
	 * @return true Spell backfired, do not proceed with effect
	 */
	protected function backfired(display:Boolean):Boolean {
		if (!backfireEnabled) return false;
		var backfire:int = calcBackfirePercent();
		if(rand(100) < backfire) {
			backfireEffect(display);
			return true;
		} else {
			return false;
		}
	}
}
}
