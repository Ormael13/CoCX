package classes.Scenes.Combat.SpellsGreen {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractGreenSpell;
import classes.StatusEffects;
import classes.CoC;

public class PlantBloomSpell extends AbstractGreenSpell {
	public function PlantBloomSpell() {
		super("Plant Bloom",
			"Cause nearby plants to turn into invasive vines, inflicting lust damage.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_LUSTDMG, TAG_TIER1]);
		baseManaCost = 40;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsPlantGrowth) && (!CoC.instance.inCombat || combat.isNearPlants());
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target, false, false)) + " lust poison damage"
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
		var baseDamage:Number = ((scalingBonusIntelligence() + scalingBonusLibido()));
		return adjustLustDamage(baseDamage, monster, CAT_SPELL_GREEN, randomize);
	}
	
	override public function calcDuration():int {
		var dura:Number = 4;
		if (player.hasPerk(PerkLib.GreenMagic)) dura *= 2;
		return dura;
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (combat.isNearPlants()) {
			if (display) outputText("You focus your intent on the flora around you, infusing them with the power of your emotions. The onslaught of lust causes flowers to bloom into a pollen cloud as vine surges from the canopy and darts to your opponent.");
			if (monster.lustVuln == 0) {
				if (display) outputText("\nIt has no effect!  Your foe clearly does not experience lust in the same way as you.\n");
				return;
			}
			player.createStatusEffect(StatusEffects.PlantGrowth, calcDuration(), 0, 0, 0);

			var lustDmg:Number = calcDamage(monster, true, true);
			var resultArray:Array = critAndRepeatLust(display, lustDmg, CAT_SPELL_GREEN);
			postLustSpellEffect(resultArray[1]);
			if (display) outputText("\n");
		}
		
	}
}
}
