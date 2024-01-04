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
		var baseDamage:Number = (2 * scalingBonusIntelligence(randomize));
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
			var arve:Number = 1;
			if (player.hasPerk(PerkLib.ArcaneVenom)) arve += stackingArcaneVenom();
			while (arve-->0) doSpellEffect2(display);
			if (display) outputText("\n");
		}
		
	}
	
	private function doSpellEffect2(display:Boolean = true):void {
		var lustDmg:Number = calcDamage(monster, true, true);
		//Determine if critical tease!
		var crit:Boolean   = false;
		var critChance:int = 5;
		critChance += combat.teases.combatTeaseCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			lustDmg *= 1.75;
		}
		monster.teased(lustDmg, false, display);
		if (crit && display) outputText(" <b>Critical!</b>");
		combat.teaseXP(1 + combat.bonusExpAfterSuccesfullTease());
		if (player.hasPerk(PerkLib.VerdantLeech)) {
			if (monster.lustVuln != 0 && !monster.hasPerk(PerkLib.EnemyTrueAngel)) monster.lustVuln += 0.025;
			HPChange(Math.round(player.maxHP() * 0.01), false);
		}
	}
}
}
