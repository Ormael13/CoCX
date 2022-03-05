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
					"Harden part of the the ground into many wrath-enpowered earth spike to attack your enemies."
					: "Harden part of the the ground into many earth spike to attack your enemies.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_EARTH, TAG_AOE]
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
	
	override public function calcCooldown():int {
		return spellGreyCooldown();
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = 2 * scalingBonusIntelligence(randomize);
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		if (ex) baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.EARTH, CAT_SPELL_GREY, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You spread your fingers, touching each of your fingertips together. Sending mana pulsing down into the earth, you grit your teeth, spikes of stone forming underneath. Your eyes flash blue for a brief moment, and the earth below your foe trembles. Spikes of stone shoot from the ground, impaling your enemy. You let a grunt of effort escape your mouth, and each spike explodes in a burst of flying stone.\n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.EARTH,false,false,true);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}

}
}