package classes.Scenes.Combat.SpellsWhite {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class ChainLightningSpell extends AbstractWhiteSpell {
	
	private var ex:Boolean;
	
	public function ChainLightningSpell(ex:Boolean =false) {
		super(
				ex ? "Chain Lighting (Ex)":"Chain Lighting",
				ex ?
						"Chain Lighting (Ex) is a wrath-empowered lightning attack that will electrocute your foes with a chain bolts of lightning."
						: "Chain Lighting is a lightning attack that will electrocute your foes with a chain bolts of lightning.",
				TARGET_ENEMY,
				TIMING_INSTANT,
				[TAG_DAMAGING, TAG_AOE, TAG_LIGHTNING]
		);
		baseManaCost = 200;
		baseWrathCost = ex ? 100 : 0;
		this.ex = ex;
	}
	
	override public function get buttonName():String {
		return ex ? "ChainLtng (Ex)" : "ChainLtng"
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+calcDamage(target, false)+" lightning damage";
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsChainLighting) &&
				(!ex || player.hasPerk(PerkLib.MagesWrathEx))
	}
	
	override public function get currentCooldown():int {
		return ex ? player.statusEffectv1(StatusEffects.CooldownSpellChainLightingEx)
				: player.statusEffectv1(StatusEffects.CooldownSpellChainLighting);
	}
	
	override public function useResources():void {
		super.useResources(); // mana is used in AbstractSpell
		player.createStatusEffect(
				ex ?
						StatusEffects.CooldownSpellChainLightingEx
						: StatusEffects.CooldownSpellChainLighting,
				spellWhiteCooldown(),0,0,0
		);
	}
	
	/**
	 * Calculate real (or theoretic) damage dealt by this spell
	 * @param monster Target, or null if no target (ex. for description outside combat)
	 * @param randomize true: Apply random bonus, false: Apply average bonus
	 * @return {Number} Damage dealt by this spell
	 */
	public function calcDamage(monster:Monster, randomize:Boolean = true):Number {
		var baseDamage:Number = 2*scalingBonusIntelligence(randomize);
		if (ex) baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.LIGHTNING, CAT_SPELL_WHITE, monster);
	}
	
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You charge energy in your hand and fire it out in the form of a powerful bolt of lightning at " + monster.a + monster.short + " ");
			if (monster.plural) {
				outputText("that jumps from one target to another");
			}
			outputText("!");
		}
		var damage:Number = calcDamage(monster);
		critAndRepeatDamage(display, damage, DamageType.LIGHTNING);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		damage *= omnicasterRepeatCount();
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
