package classes.Scenes.Combat.SpellsGrey {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreySpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class CorrosiveWaveSpell extends AbstractGreySpell {
	public var ex:Boolean;
	
	public function CorrosiveWaveSpell(ex:Boolean = false) {
		super(
			ex ? "Corrosive Wave (Ex)" : "Corrosive Wave",
			ex ?
				"Condense part of the ambient moisture into wrath-empowered acid wave to attack your enemy."
				: "Condense part of the ambient moisture into acid wave to attack your enemy.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_ACID, TAG_AOE, TAG_TIER1]
		);
		baseManaCost = 200;
		if (ex) baseWrathCost = 100;
		this.ex = ex;
	}
	
	override public function get buttonName():String {
		return ex ? "CorrosiveWave(Ex)" : "Corrosive Wave";
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false, false) + " acid damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsCorrosiveWave) &&
				(!ex || player.hasPerk(PerkLib.MagesWrathEx));
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
		return adjustSpellDamage(baseDamage, DamageType.ACID, CAT_SPELL_GREY, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("Your mana condenses around you, beads of moisture forming, growing. Focusing, you grit your teeth, motioning upwards with both hands. Sickly green acid rises in a wave, hissing as it touches the ground around you.\n");
			outputText("[Monster A] [monster name] is covered in the burning fluids, and they flail, the acidic liquid clinging to them.\n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.ACID,false,true,true);
		if (monster.hasStatusEffect(StatusEffects.AcidDoT)) {
			monster.addStatusValue(StatusEffects.AcidDoT,1,1);
			monster.addStatusValue(StatusEffects.AcidDoT,3,0.5);
		}
		else monster.createStatusEffect(StatusEffects.AcidDoT,2,0.01,0.5,0);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}

}
}