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
				[TAG_DAMAGING, TAG_LIGHTNING]
		);
		baseManaCost = 40;
		baseWrathCost = ex ? 100 : 0;
		this.ex = ex;
	}
	
	override public function get buttonName():String {
		return ex ? "Lightning(Ex)" : "Lightning"
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+calcDamage(target,false)+" lightning damage";
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsLightningBolt) &&
				(!ex || player.hasPerk(PerkLib.MagesWrathEx))
	}
	
	override public function get currentCooldown():int {
		return ex ? player.statusEffectv1(StatusEffects.CooldownSpellLightningBoltEx)
				: player.statusEffectv1(StatusEffects.CooldownSpellLightningBolt);
	}
	
	override public function useResources():void {
		super.useResources(); // mana is used in AbstractSpell
		player.createStatusEffect(
				ex ?
						StatusEffects.CooldownSpellLightningBoltEx
						: StatusEffects.CooldownSpellLightningBolt,
				spellWhiteCooldown(),0,0,0
		);
	}
	
	/**
	 * Calculate real (or theoretic) damage dealt by this spell
	 * @param monster Target, or null if no target (ex. for description outside combat)
	 * @param randomize true: Apply random bonus, false: Apply average bonus
	 * @return {Number} Damage dealt by this spell
	 */
	public function calcDamage(monster:Monster, randomize:Boolean=true):Number {
		var baseDamage:Number = 2*scalingBonusIntelligence(randomize);
		if (ex) baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.LIGHTNING, CAT_SPELL_WHITE, monster);
	}
	
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You charge out energy in your hand and fire it out in the form of a powerful bolt of lightning at " + monster.a + monster.short + " !\n");
		}
		var damage:Number = calcDamage(monster);
		critAndRepeatDamage(display, damage, DamageType.LIGHTNING);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
