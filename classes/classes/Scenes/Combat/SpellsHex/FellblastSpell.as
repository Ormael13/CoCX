package classes.Scenes.Combat.SpellsHex {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractHexSpell;
import classes.Scenes.Combat.DamageType;
import classes.Scenes.Combat.Combat;
import classes.StatusEffects;

public class FellblastSpell extends AbstractHexSpell {
	public function FellblastSpell() {
		super(
			"Fellblast",
			"This powerful hex spell devours the target based on how afflicted by curses and hex magic it is.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_DARKNESS, TAG_TIER1]
		);
		baseManaCost = 40;
		useManaType = Combat.USEMANA_BLACK;
		canBackfire  = true;
	}
	
	override public function get buttonName():String {
		return "Fellblast";
	}
	
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+calcDamage(target, false, false)+" darkness damage";
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsFellblast);
	}
	
	override public function calcCooldown():int {
		return 6;
	}
	
	/**
	 * Calculate real (or theoretic) damage dealt by this spell
	 * @param monster Target, or null if no target (ex. for description outside combat)
	 * @param randomize true: Apply random bonus, false: Apply average bonus
	 * @return {Number} Damage dealt by this spell
	 */
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number {
		var baseDamage:Number = damageCalculationTier1Spells(randomize);
		daaamageaddons(baseDamage);
		var bDm:Number = 2;
		if (monster.hasStatusEffect(StatusEffects.ConsumingDarkness)) bDm *= 2;
		if (monster.hasStatusEffect(StatusEffects.CurseOfDesire)) bDm *= 2;
		if (monster.hasStatusEffect(StatusEffects.CurseOfWeeping)) bDm *= 2;
		if (monster.hasStatusEffect(StatusEffects.LifeSiphon)) bDm *= 2;
		if (monster.hasStatusEffect(StatusEffects.EntangledBySpell)) bDm *= 2;
		if (monster.hasStatusEffect(StatusEffects.Briarthorn)) bDm *= 2;
		if (monster.hasStatusEffect(StatusEffects.DeathBlossom)) bDm *= 2;
		baseDamage *= bDm;
		return adjustSpellDamage(baseDamage, DamageType.DARKNESS, CAT_SPELL_HEX, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("Your magic condenses into a deadly mass of cursed black flames which you release unto [themonster].\n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.DARKNESS);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}

}
