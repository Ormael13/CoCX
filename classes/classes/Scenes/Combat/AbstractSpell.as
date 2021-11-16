package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.Monster;
import classes.MutationsLib;
import classes.PerkLib;
import classes.StatusEffects;

public class AbstractSpell extends CombatAbility {
	
	protected var isBloodMagicApplicable:Boolean = true;
	protected var isLastResortApplicable:Boolean = true;
	protected var useManaType:int;
	
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
	}
	
	override public function useResources():void {
		var realCost:Number = manaCost();
		
		flags[kFLAGS.LAST_ATTACK_TYPE] = 2;
		
		if (player.hasPerk(PerkLib.LastResort) && player.mana < realCost) {
			player.HP -= realCost;
		} else {
			useMana(40, useManaType);
		}
		
		flags[kFLAGS.SPELLS_CAST]++;
		if (!player.hasStatusEffect(StatusEffects.CastedSpell)) player.createStatusEffect(StatusEffects.CastedSpell, 0, 0, 0, 0);
		combat.spellPerkUnlock();
	}
	
	override protected function usabilityCheck():String {
		
		// Run all check applicable to all abilities
		var uc:String = super.usabilityCheck();
		if (uc) return uc;
		
		// Run our checks
		if (isBloodMagicApplicable && player.hasStatusEffect(StatusEffects.BloodMage)) {
			if (player.HP - player.minHP() > manaCost()) {
				return "Your hp is too low to cast this spell."
			}
		} else {
			if (player.mana < manaCost()) {
				if (isLastResortApplicable && player.hasPerk(PerkLib.LastResort)) {
					if (player.HP < manaCost()) {
						return "Your hp and mana are too low to cast this spell."
					}
				} else {
					return "Your mana is too low to cast this spell."
				}
			}
		}
		if (targetType == TARGET_ENEMY) {
			if (monster.hasStatusEffect(StatusEffects.Dig)) {
				return "You can only use buff magic while underground."
			}
			if (combat.isEnnemyInvisible) {
				return "You cannot use offensive spells against an opponent you cannot see or target."
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
	
	protected function postSpellEffect():void {
		MagicAddonEffect();
		if (player.weapon == weapons.DEMSCYT && player.cor < 90) dynStats("cor", 0.3);
	}
	
	public override function doEffect(output:Boolean = true):void {
		if (monster.hasStatusEffect(StatusEffects.Shell)) {
			if (output) {
				outputText("As soon as your magic touches the multicolored shell around " + monster.a + monster.short + ", it sizzles and fades to nothing.  Whatever that thing is, it completely blocks your magic!\n\n");
			}
		} else {
			doSpellEffect(output);
			postSpellEffect();
		}
	}
	
	///////////////////////////
	// Shortcuts and utilities
	///////////////////////////
	
	protected function MagicAddonEffect(numberOfProcs:Number = 1):void {
		combat.magic.MagicAddonEffect(numberOfProcs);
	}
	
	/**
	 * Apply bonuses from perks, items, and other sources to a damage.
	 * Returned value is rounded.
	 * @param baseDamage Base damage value (typically X*scalingBonusSomething)
	 * @param damageType DamageType.XXX constant
	 * @param category CombatAbility.CATEGORY_XXX constant
	 * @param monster Target or null if evaluating damage outside combat
	 * @return
	 */
	protected function adjustSpellDamage(
			baseDamage:Number,
			damageType:int,
			category:int,
			monster:Monster
	):Number {
		var damage:Number = baseDamage;
		
		switch (category) {
			case SPELL_WHITE:
				damage *= spellModWhite();
				break;
		}
		
		switch (damageType) {
			case DamageType.FIRE: {
				damage = calcInfernoMod(damage);
				if (player.armor == armors.BLIZZ_K) damage *= 0.5;
				if (player.headJewelry == headjewelries.SNOWFH) damage *= 0.7;
				if (monster != null) {
					if (monster.short == "goo-girl") damage *= 1.5;
					if (monster.short == "tentacle beast") damage *= 1.2;
				}
				damage *= combat.fireDamageBoostedByDao();
				break;
			}
			case DamageType.LIGHTNING: {
				damage = calcVoltageMod(damage);
				if (player.hasPerk(PerkLib.ElectrifiedDesire)) damage *= (1 + (player.lust100 * 0.01));
				damage *= combat.lightningDamageBoostedByDao();
				break;
			}
		}
		if (monster != null) {
			if (player.hasPerk(PerkLib.DivineKnowledge) && monster.cor > 65) damage *= 1.2;
			if (player.hasPerk(PerkLib.PureMagic)) {
				if (monster.cor < 33) damage *= 1.0;
				else if (monster.cor < 50) damage *= 1.1;
				else if (monster.cor < 75) damage *= 1.2;
				else if (monster.cor < 90) damage *= 1.3;
				else damage *= 1.4;
			}
		}
		if (player.hasPerk(PerkLib.Omnicaster)) {
			if (player.hasPerk(MutationsLib.GazerEyeEvolved)) damage *= 0.5;
			else if (player.hasPerk(MutationsLib.GazerEyePrimitive)) damage *= 0.3;
			else damage *= 0.2;
		}
		
		return Math.round(damage);
	}
	
	/**
	 * Do a crit roll and apply crit multiplier.
	 * Deal damage once or repeatedly (if Omnicaster). Does NOT apply Omnicaster damage downscale!
	 * Also prints "Monster takes N N N N damage. Critical Hit!"
	 * @param damage Damage to deal
	 * @param damageType Damage type (DamageType.XXX)
	 */
	protected function critAndRepeatDamage(
			display:Boolean,
			damage:Number,
			damageType:int,
			baseCritChance:Number=5,
			critMultiplier:Number=1.75
	):void {
		outputText(monster.capitalA + monster.short + " takes ");
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = baseCritChance + combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (critChance > 0 && rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		
		var damageFn:Function;
		switch (damageType) {
			case DamageType.FIRE:
				damageFn =doFireDamage;
				break;
			case DamageType.DARKNESS:
				damageFn = doDarknessDamage;
				break;
			case DamageType.ICE:
				damageFn = doIceDamage;
				break;
			case DamageType.LIGHTNING:
				damageFn = doLightingDamage;
				break;
			case DamageType.MAGICAL:
				damageFn = doMagicDamage;
				break;
			case DamageType.PHYSICAL:
			default:
				damageFn = doDamage;
		}
		var repeats:int = 1;
		if (player.hasPerk(PerkLib.Omnicaster)) {
			repeats = 6;
			if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 8) {
				repeats = 8;
			}
			if (player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) {
				repeats = 10;
			}
		}
		while (repeats-->0) {
			damageFn(damage, true, display);
		}
		outputText(" damage.");
		if (crit) outputText(" <b>*Critical Hit!*</b>");
	}
}
}
