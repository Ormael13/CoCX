package classes.Scenes.Combat.SpellsWhite {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class LightningBoltSpell extends AbstractWhiteSpell {
	
	private var ex:Boolean;
	
	public function LightningBoltSpell(ex:Boolean=false) {
		super(
			ex ? "Lightning Bolt (Ex)":"Lightning Bolt",
			ex ?
				"Lightning Bolt (Ex) is a basic wrath-empowered lightning attack that will electrocute your foe with a single bolt of lightning."
				:"Lightning Bolt is a basic lightning attack that will electrocute your foe with a single bolt of lightning.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_LIGHTNING, TAG_TIER1]
		);
		baseManaCost = 40;
		baseWrathCost = ex ? 100 : 0;
		this.ex = ex;
	}
	
	override public function get buttonName():String {
		return ex ? "Lightning(Ex)" : "Lightning"
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+calcDamage(target, false, false)+" lightning damage";
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsLightningBolt) &&
				(!ex || player.hasPerk(PerkLib.MagesWrathEx))
	}
	
	override public function calcCooldown():int {
		var calcC:int = 0;
		calcC += spellWhiteCooldown();
		if (player.weaponRange == weaponsrange.RW_TOME && player.level < 18) {
			if (player.level < 6) calcC -= 1;
			if (player.level < 12) calcC -= 1;
			calcC -= 1;
			if (calcC < 0) calcC = 0;
		}
		return calcC;
	}
	
	/**
	 * Calculate real (or theoretic) damage dealt by this spell
	 * @param monster Target, or null if no target (ex. for description outside combat)
	 * @param randomize true: Apply random bonus, false: Apply average bonus
	 * @return {Number} Damage dealt by this spell
	 */
	public function calcDamage(monster:Monster, randomize:Boolean=true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = 2*scalingBonusIntelligence(randomize);
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		if (ex) baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.LIGHTNING, CAT_SPELL_WHITE, monster, true, casting);
	}
	
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You focus your mana into your hand, and sparks form, sending pins and needles through your arm. The sharp tang of ozone fills the air, and you point your palm at [themonster] . Tendrils of electricity arc from your hand, striking [themonster] with lethal force.\n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.LIGHTNING);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
