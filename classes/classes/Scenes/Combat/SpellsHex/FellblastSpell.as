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
		return "~"+calcDamageDarkness(target, false, false)+" darkness damage and ~"+calcDamageFire(target, false, false)+" fire damage";
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
	public function calcDamageDarkness(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number {
		var baseDamage:Number = damageCalculationTier1Spells(randomize);
		daaamageaddons(baseDamage);
		baseDamage *= (calcDamDF() * 2);
		return adjustSpellDamage(baseDamage, DamageType.DARKNESS, CAT_SPELL_HEX, monster, true, casting);
	}
	public function calcDamageFire(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number {
		var baseDamage:Number = damageCalculationTier1Spells(randomize);
		daaamageaddons(baseDamage);
		baseDamage *= calcDamDF();
		return adjustSpellDamage(baseDamage, DamageType.FIRE, CAT_SPELL_HEX, monster, true, casting);
	}
	private function calcDamDF():Number {
		var bDm:Number = 1;
		if (monster.hasStatusEffect(StatusEffects.ConsumingDarkness)) bDm *= 2;
		if (monster.hasStatusEffect(StatusEffects.CurseOfDesire)) bDm *= 2;
		if (monster.hasStatusEffect(StatusEffects.CurseOfWeeping)) bDm *= 2;
		if (monster.hasStatusEffect(StatusEffects.LifeSiphon)) bDm *= 2;
		if (monster.hasStatusEffect(StatusEffects.EntangledBySpell)) bDm *= 2;
		if (monster.hasStatusEffect(StatusEffects.Briarthorn)) bDm *= 2;
		if (monster.hasStatusEffect(StatusEffects.DeathBlossom)) bDm *= 2;
		return bDm;
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("Your magic condenses into a deadly mass of cursed black flames which you release unto [themonster].\n");
		}
		var damage:Number = 0;
		var damageD:Number = calcDamageDarkness(monster, true, true);
		var damageF:Number = calcDamageFire(monster, true, true);
		damage += damageD;
		damage += damageF;
		damageD = critAndRepeatDamage(display, damageD, DamageType.DARKNESS);
		damageF = critAndRepeatDamage(display, damageF, DamageType.FIRE);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}

}
