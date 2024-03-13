package classes.Scenes.Combat.SpellsGrey {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreySpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class ShatterstoneSpell extends AbstractGreySpell {
	public var ex:Boolean;
	
	public function ShatterstoneSpell(ex:Boolean = false) {
		super(
			ex ? "Shatterstone (Ex)" : "Shatterstone",
			ex ?
				"Harden part of the ground into many wrath-empowered earth spikes to attack your enemies."
				: "Harden part of the ground into many earth spikes to attack your enemies.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_EARTH, TAG_AOE, TAG_TIER1]
		);
		baseManaCost = 200;
		if (ex) baseWrathCost = 100;
		this.ex = ex;
	}
	
	override public function get buttonName():String {
		return ex ? "Shatterstone(Ex)" : "Shatterstone";
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false, false) + " earth damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsShatterstone) &&
				(!ex || player.hasPerk(PerkLib.MagesWrathEx));
	}
	
	override protected function usabilityCheck():String {
		if (monster.hasStatusEffect(StatusEffects.Flying)) {
			return "You can only use earth magic against enemy on the ground."
		}
		if (player.hasStatusEffect(StatusEffects.Flying)) {
			return "You can't use earth magic when too far from the ground."
		}
		return super.usabilityCheck();
	}
	
	override public function calcCooldown():int {
		var calcC:int = 0;
		calcC += spellGreyCooldown();
		if (player.weaponRange == weaponsrange.RG_TOME && player.level < 18) {
			if (player.level < 6) calcC -= 1;
			if (player.level < 12) calcC -= 1;
			calcC -= 1;
			if (calcC < 0) calcC = 0;
		}
		return calcC;
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = 2 * scalingBonusIntelligence(randomize);
		if (player.hasPerk(PerkLib.Convergence) && monster != null && (monster.hasPerk(PerkLib.EnemyGroupType) || monster.hasPerk(PerkLib.EnemyLargeGroupType) || monster.hasPerk(PerkLib.Enemy300Type))) {
			if (player.hasPerk(PerkLib.SuperConvergence)) {
				if (monster.hasPerk(PerkLib.EnemyGroupType)) baseDamage *= 3.5;
				else if (monster.hasPerk(PerkLib.EnemyLargeGroupType)) baseDamage *= 2;
				else baseDamage *= 1.5;
			}
			else {
				if (monster.hasPerk(PerkLib.EnemyGroupType)) baseDamage *= 2;
				else baseDamage *= 1.5;
			}
		}
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		if (ex) baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.EARTH, CAT_SPELL_GREY, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You spread your fingers, touching each of your fingertips together. Sending mana pulsing down into the earth, you grit your teeth, spikes of stone forming underneath. Your eyes flash blue for a brief moment, and the earth below your foe trembles. Spikes of stone shoot from the ground, impaling your enemy. You let a grunt of effort escape your mouth, and each spike explodes in a burst of flying stone.\n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.EARTH,false,true,true);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}

}
}