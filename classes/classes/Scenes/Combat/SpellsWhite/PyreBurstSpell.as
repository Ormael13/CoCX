package classes.Scenes.Combat.SpellsWhite {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractWhiteSpell;
import classes.Scenes.Combat.DamageType;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.StatusEffects;

public class PyreBurstSpell extends AbstractWhiteSpell {
	private var ex:Boolean;
	public function PyreBurstSpell(ex:Boolean=false) {
		super(
			ex ? "Pyre Burst(Ex)" : "Pyre Burst",
			ex ?
				"Teach your foes a lesson with the strength of a wrath-empowered firestorm."
				: "Teach your foes a lesson with the strength of a firestorm.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_AOE, TAG_FIRE, TAG_TIER1]
		);
		baseManaCost = 200;
		baseWrathCost = ex ? 100 : 0;
		this.ex = ex;
	}
	
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+calcDamage(target, false, false)+" fire damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsPyreBurst) &&
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
		return adjustSpellDamage(baseDamage, DamageType.FIRE, CAT_SPELL_WHITE, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (monster is Lethice && (monster as Lethice).fightPhase == 2) {
			if (display) {
				outputText("You let loose a roiling cone of flames that wash over the horde of demons like a tidal wave, scorching at their tainted flesh with vigor unlike anything you've seen before. Screams of terror as much as, maybe more than, pain fill the air as the mass of corrupted bodies try desperately to escape from you! Though more demons pile in over the affected front ranks, you've certainly put the fear of your magic into them!")
			}
			monster.createStatusEffect(StatusEffects.OnFire, 2 + rand(2), 0, 0, 0);
		} else {
			if (display) {
				outputText("Following practiced somatics, you circle your hands in the air before striking the ground, causing a pillar of flame to wash over [themonster].\n");
			}
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.FIRE);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
