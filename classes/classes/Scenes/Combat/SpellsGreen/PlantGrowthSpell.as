package classes.Scenes.Combat.SpellsGreen {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreenSpell;
import classes.StatusEffects;

public class PlantGrowthSpell extends AbstractGreenSpell {
	public function PlantGrowthSpell() {
		super("Plant growth",
			"Grow plants around the caster. If plants are already present, turn them into invasive vines to deal lust damage.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_LUSTDMG]);
		baseManaCost = 20;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsPlantGrowth);
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false, false) + " lust posion damage"
	}
	
	override public function calcCooldown():int {
		return (1+spellWhiteCooldown());
	}
	
	override public function advance(display:Boolean):void {
		if (player.hasStatusEffect(StatusEffects.PlantGrowth)) {
			if (player.statusEffectv1(StatusEffects.PlantGrowth) <= 0) {
				player.removeStatusEffect(StatusEffects.PlantGrowth);
				if (display) outputText("<b>Plant Growth effect wore off!</b>\n\n");
			} else {
				player.addStatusValue(StatusEffects.PlantGrowth, 1, -1);
			}
		}
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = (combat.teases.teaseBaseLustDamage() * 0.5 * spellModWhite());
		if (player.hasPerk(PerkLib.VegetalAffinity)) baseDamage *= 1.5;
		if (player.hasPerk(PerkLib.GreenMagic)) baseDamage *= 2;
		if (player.hasStatusEffect(StatusEffects.GreenCovenant)) baseDamage *= 2;
		return adjustLustDamage(baseDamage, monster, CAT_SPELL_GREEN, randomize);
	}
	
	public function calcDuration():int {
		var dura:Number = 4;
		if (player.hasPerk(PerkLib.GreenMagic)) dura *= 2;
		return dura;
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			if (player.hasStatusEffect(StatusEffects.NearbyPlants)) {
				outputText("You focus your intent on the flora around you, infusing them with the power of your emotions. The onslaught of lust causes flowers to bloom into a pollen cloud as vine surges from the canopy and darts to your opponent.\n");
				if (monster.lustVuln == 0) {
					if (display) {
						outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
					}
					return;
				}
				player.createStatusEffect(StatusEffects.PlantGrowth, calcDuration(), 0, 0, 0);
				var arve:Number = 1;
				if (player.hasPerk(PerkLib.ArcaneVenom)) arve += stackingArcaneVenom();
				while (arve-->0) doSpellEffect2();
			}
			else {
				outputText("You focus your energy on the world around you causing vegetation to surge out of the ground at an accelerated rate into a verdant patch of vines and other tentacle greenery.\n");
				player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
			}
		}
	}
	
	private function doSpellEffect2():void {
		var lustDmg:Number = calcDamage(monster, true, true);
		//Determine if critical tease!
		var crit:Boolean   = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.CriticalPerformance)) {
			if (player.lib <= 100) critChance += player.lib / 5;
			if (player.lib > 100) critChance += 20;
		}
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			lustDmg *= 1.75;
		}
		lustDmg = Math.round(monster.lustVuln * lustDmg);
		monster.teased(lustDmg, false);
		if (crit) outputText(" <b>Critical!</b>");
		combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		if (player.hasPerk(PerkLib.VerdantLeech)) {
			if (monster.lustVuln != 0) monster.lustVuln += 0.025;
			HPChange(Math.round(player.maxHP() * 0.05), false);
		}
	}
}
}
