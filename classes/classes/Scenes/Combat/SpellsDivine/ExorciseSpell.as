package classes.Scenes.Combat.SpellsDivine {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractDivineSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class ExorciseSpell extends AbstractDivineSpell {
	
	function ExorciseSpell() {
		super(
			"Exorcise",
			"Smite your opponent with your weapon, inflicting damage based on the weapon’s damage and your magical power. Highly effective against the corrupt.  ",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING]
		);
		baseManaCost = 400;
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+numberFormat(calcDamage(target, false, false))+" magical damage";
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsExorcise)
	}
	
	override public function calcCooldown():int {
		var calcC:int = -1;
		calcC += spellGenericCooldown();
		if (calcC < 0) calcC = 0;
		return calcC;
	}
	
	/**
	 * Calculate real (or theoretic) damage dealt by this spell
	 * @param monster Target, or null if no target (ex. for description outside combat)
	 * @param randomize true: Apply random bonus, false: Apply average bonus
	 * @return {Number} Damage dealt by this spell
	 */
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var damage:Number = scalingBonusIntelligence() * 4;
		if (player.weaponAttack < 51) damage *= (1 + (player.weaponAttack * 0.03));
		else if (player.weaponAttack >= 51 && player.weaponAttack < 101) damage *= (2.5 + ((player.weaponAttack - 50) * 0.025));
		else if (player.weaponAttack >= 101 && player.weaponAttack < 151) damage *= (3.75 + ((player.weaponAttack - 100) * 0.02));
		else if (player.weaponAttack >= 151 && player.weaponAttack < 201) damage *= (4.75 + ((player.weaponAttack - 150) * 0.015));
		else damage *= (5.5 + ((player.weaponAttack - 200) * 0.01));
		return adjustSpellDamage(damage, DamageType.MAGICAL, CAT_SPELL_DIVINE, monster, false, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You narrow your eyes, focusing your mind with deadly intent.  You snap your fingers and [themonster] is enveloped in a flash of white flames!\n" +
					"Your [weapon] begins to glow as you charge and deliver a mighty strike. As the mystical blow strikes your opponent"+(monster.plural ? "s":"")+", the magic explodes forward from your weapon in the shape of the sigil of the Marethian divine pantheon, damaging your foe"+(monster.plural ? "s":"")+" further and throwing [monster him] back.");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.MAGICAL);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}

}
