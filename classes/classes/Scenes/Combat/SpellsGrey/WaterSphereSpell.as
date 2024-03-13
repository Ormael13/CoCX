package classes.Scenes.Combat.SpellsGrey {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreySpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class WaterSphereSpell extends AbstractGreySpell {
	public var ex:Boolean;
	
	public function WaterSphereSpell(ex:Boolean = false) {
		super(
			ex ? "Water Sphere (Ex)" : "Water Sphere",
			ex ?
				"Condense part of the ambient moisture into wrath-empowered water spheres to attack your enemies."
				: "Condense part of the ambient moisture into spheres water to attack your enemies.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_WATER, TAG_AOE, TAG_TIER1]
		);
		baseManaCost = 200;
		if (ex) baseWrathCost = 100;
		this.ex = ex;
	}
	
	override public function get buttonName():String {
		return ex ? "WaterSphere(Ex)" : "Water Sphere";
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false, false) + " water damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsWaterSphere) &&
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
		return adjustSpellDamage(baseDamage, DamageType.WATER, CAT_SPELL_GREY, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			if (player.hasStatusEffect(StatusEffects.InWater)) {
				outputText("You focus your intents on the water around your body. A vortex whirls around your palms as the force of your magic fuses with the water. Countless spheres form around you before you send them all crashing into [themonster].\n");
				outputText("The waves crash against them!\n");
			}
			else {
				outputText("You focus your intents toward your open palm as water begins welling up in the air above your hand. Several spheres of water form, circling above your hand before you shoot them at [themonster].\n");
				outputText("It violently crashes against them!\n");
			}
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.WATER,false,true,true);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}

}
}