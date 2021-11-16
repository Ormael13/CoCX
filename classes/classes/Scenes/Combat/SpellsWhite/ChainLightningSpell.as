package classes.Scenes.Combat.SpellsWhite {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;
import classes.StatusEffects;

public class ChainLightningSpell extends AbstractWhiteSpell {
	
	private var ex:Boolean;
	
	public function ChainLightningSpell(ex:Boolean =false) {
		super(
				ex ? "Chain Lighting (Ex)":"Chain Lighting",
				ex ?
						"Chain Lighting is a lightning attack that will electrocute your foes with a chain bolts of lightning."
						: "Chain Lighting is a lightning attack that will electrocute your foes with a chain bolts of lightning.",
				TARGET_ENEMY,
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
		return ""+calcDamage(target)+" lightning damage";
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsChainLighting) &&
				(!ex || player.hasPerk(PerkLib.MagesWrathEx))
	}
	
	override public function get currentCooldown():int {
		return ex ? player.statusEffectv1(StatusEffects.CooldownSpellChainLightingEx)
				: player.statusEffectv1(StatusEffects.CooldownSpellChainLighting);
	}
	
	override protected function useResources():void {
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
	 * @return {Number} Damage dealt by this spell
	 */
	public function calcDamage(monster:Monster):Number {
		var baseDamage:Number = 2*scalingBonusIntelligence();
		if (monster != null && monster.plural) baseDamage *= 5;
		if (ex) baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.LIGHTNING, SPELL_WHITE, monster);
	}
	
	
	override protected function doSpellEffect():void {
		outputText("You charge energy in your hand and fire it out in the form of a powerful bolt of lightning at " + monster.a + monster.short + " ");
		if (monster.plural) {
			outputText("that jumps from one target to another");
		}
		outputText("!");
		var damage:Number = calcDamage(monster);
		critAndRepeatDamage(damage, DamageType.LIGHTNING);
		outputText("\n\n");
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
